--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __le, __gt, __ge, __mod, __ord, __arrL, __iterar, __t, __get, __arr, __len = __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__arr, __JSR.__len
local __call, __add, __iter, __keys, __assign, __isArray, __hypot = __JSR.__call, __JSR.__add, __JSR.__iter, __JSR.__keys, __JSR.__assign, __JSR.__isArray, __JSR.__hypot
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__Spread = ____lualib.__TS__Spread
local __TS__Number = ____lualib.__TS__Number
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local ____t_3 = __t
    local ____t_2 = __t
    local ____opt_0 = window.Mapa3D
    if ____opt_0 ~= nil then
        ____opt_0 = ____opt_0.arte
    end
    if ____t_3(if __t(window.MapasJogo) then window.MapasJogo else not ____t_2(____opt_0)) then
        return
    end
    local ____window_Mapa3D_arte_4 = window.Mapa3D.arte
    local hash = ____window_Mapa3D_arte_4.hash
    local TS = 16
    local function L16(____, n)
        return n * TS
    end
    local function previaCena(____, scene, camera)
        local off = nil
        return function(____, c, w, h, t)
            if not __t(off) then
                off = window.document:createElement("canvas")
                off.width = 960
                off.height = 540
            end
            local o = off:getContext("2d")
            o.imageSmoothingEnabled = false
            local ____opt_7 = window.Art
            if ____opt_7 ~= nil then
                ____opt_7 = ____opt_7.drawScene
            end
            if ____opt_7 ~= nil then
                ____opt_7(
                    ____opt_7,
                    o,
                    scene,
                    camera + math.sin(t * 0.3) * 40,
                    t
                )
            end
            c.imageSmoothingEnabled = false
            c:drawImage(
                off,
                0,
                0,
                w,
                h
            )
        end
    end
    local function livre(____, x, y, caixas, m)
        if m == nil then
            m = 10
        end
        return not __t(__call(
            caixas,
            "some",
            function(____, ____bindingPattern0)
                local bh
                local bw
                local by
                local bx
                bx = ____bindingPattern0[1]
                by = ____bindingPattern0[2]
                bw = ____bindingPattern0[3]
                bh = ____bindingPattern0[4]
                local ____t_12 = __t
                local ____t_10 = __t
                local ____temp_9 = __gt(x, bx - m) and __lt(
                    x,
                    __add(bx, bw) + m
                )
                __O[608] = ____temp_9
                local ____temp_11 = if ____t_10(____temp_9) then __gt(y, by - m) else __O[608]
                __O[609] = ____temp_11
                return if ____t_12(____temp_11) then __lt(
                    y,
                    __add(by, bh) + m
                ) else __O[609]
            end
        ))
    end
    local function ponte(____, P, x, y, w, h)
        if h == nil then
            h = 30
        end
        local R = P.R
        P:sombra(
            x + w / 2,
            y + h + 4,
            w / 2,
            4,
            0.3
        )
        R(
            nil,
            x,
            y,
            w,
            h,
            "#8a9096"
        )
        do
            local k = 0
            while __lt(k, w) do
                R(
                    nil,
                    x + k,
                    y + 2,
                    5,
                    h - 4,
                    "#b8bcc0"
                )
                R(
                    nil,
                    x + k,
                    y + 2,
                    5,
                    1,
                    "#dde0e3"
                )
                k = k + 6
            end
        end
        R(
            nil,
            x - 2,
            y - 4,
            w + 4,
            5,
            "#9aa0a6"
        )
        R(
            nil,
            x - 2,
            y + h - 2,
            w + 4,
            6,
            "#7a8086"
        )
        do
            local k = 0
            while __lt(k, w) do
                R(
                    nil,
                    x + k,
                    y - 7,
                    3,
                    4,
                    "#c8ccd0"
                )
                R(
                    nil,
                    x + k,
                    y + h - 5,
                    3,
                    4,
                    "#c8ccd0"
                )
                k = k + 10
            end
        end
        R(
            nil,
            x - 2,
            y + h + 4,
            w + 4,
            2,
            "#5a6066"
        )
    end
    local function escada(____, P, x, y, n, larg)
        if larg == nil then
            larg = 14
        end
        do
            local k = 0
            while __lt(k, n) do
                P:R(
                    x,
                    y + k * 4,
                    larg,
                    4,
                    if __t(__mod(k, 2)) then "#a8aeb4" else "#bcc0c4"
                )
                P:R(
                    x,
                    y + k * 4,
                    larg,
                    1,
                    "#dde0e3"
                )
                k = k + 1
            end
        end
        P:R(
            x - 1,
            y,
            1,
            n * 4,
            "#7a8086"
        )
        P:R(
            x + larg,
            y,
            1,
            n * 4,
            "#7a8086"
        )
    end
    local function pessoa(____, P, x, y, cor, t, anda)
        if t == nil then
            t = 0
        end
        if anda == nil then
            anda = true
        end
        local f = if __t(anda) then __mod(
            math.floor(t * 6),
            2
        ) else 0
        P:R(
            x - 1,
            y - 2,
            2,
            2 + f,
            "#2a2f3a"
        )
        P:R(
            x + 1,
            y - 2,
            2,
            3 - f,
            "#2a2f3a"
        )
        P:R(
            x - 2,
            y - 8,
            5,
            6,
            cor
        )
        P:R(
            x - 1,
            y - 11,
            3,
            3,
            "#d9a57f"
        )
        P:R(
            x - 1,
            y - 12,
            3,
            1,
            "#2a201a"
        )
        P:R(
            x - 3,
            y,
            7,
            1,
            "rgba(0,0,0,.25)"
        )
    end
    local function carrinho(____, P, x, y, cor, dir, taxi)
        if dir == nil then
            dir = 1
        end
        if taxi == nil then
            taxi = false
        end
        local R = P.R
        R(
            nil,
            x - 9,
            y + 1,
            18,
            2,
            "rgba(0,0,0,.3)"
        )
        R(
            nil,
            x - 9,
            y - 6,
            18,
            7,
            cor
        )
        R(
            nil,
            x - 9,
            y - 6,
            18,
            1,
            "#ffffff55"
        )
        R(
            nil,
            x - 5 + dir,
            y - 10,
            10,
            5,
            cor
        )
        R(
            nil,
            x - 4 + dir,
            y - 9,
            8,
            3,
            "#9fc4d0"
        )
        R(
            nil,
            x - 8,
            y,
            4,
            2,
            "#1c1c1c"
        )
        R(
            nil,
            x + 4,
            y,
            4,
            2,
            "#1c1c1c"
        )
        R(
            nil,
            if dir > 0 then x + 8 else x - 9,
            y - 4,
            1,
            2,
            "#fff2b0"
        )
        if __t(taxi) then
            R(
                nil,
                x - 2 + dir,
                y - 12,
                5,
                2,
                "#f6f6f0"
            )
            do
                local k = 0
                while k < 9 do
                    R(
                        nil,
                        x - 9 + k * 2,
                        y - 3,
                        1,
                        1,
                        if __t(__mod(k, 2)) then "#1c1c1c" else "#f6f6f0"
                    )
                    k = k + 1
                end
            end
        end
    end
    local function carroViagem(____, P, t, o, tipo)
        if o == nil then
            o = {}
        end
        if tipo == nil then
            tipo = "gas"
        end
        local R = P.R
        local K = "#14201f"
        local taxi = tipo == "taxi"
        local cor = if __t(taxi) then __arrL({"#f2c94c", "#ffe48a", "#b8901c"}, 3) else __arrL({"#3c8a8a", "#7ac8c8", "#265e5e"}, 3)
        if __t(o.voando) then
            for ____, ____value in __iterar((__arrL(
                {
                    __arrL({-9, 0}, 2),
                    __arrL({7, 1.7}, 2)
                },
                2
            ))) do
                local fx = ____value[1]
                local ff = ____value[2]
                local f = 4 + math.sin(t * 38 + ff) * 2
                P.c.globalAlpha = 0.45
                R(
                    nil,
                    fx - 2,
                    3,
                    5,
                    f + 3,
                    "#bff0c8"
                )
                P.c.globalAlpha = 0.9
                R(
                    nil,
                    fx - 1,
                    3,
                    3,
                    f,
                    "#f4fff0"
                )
                P.c.globalAlpha = 1
            end
        end
        if not __t(taxi) then
            R(
                nil,
                -20,
                -10,
                7,
                8,
                K
            )
            R(
                nil,
                -19,
                -9,
                5,
                6,
                "#c8ccd0"
            )
            R(
                nil,
                -19,
                -9,
                5,
                1,
                "#f2f4f6"
            )
            R(
                nil,
                -19,
                -5,
                5,
                1,
                "#8a9096"
            )
            R(
                nil,
                -17,
                -11,
                1,
                2,
                K
            )
        end
        R(
            nil,
            -16,
            -10,
            32,
            11,
            K
        )
        R(
            nil,
            -9,
            -18,
            18,
            9,
            K
        )
        R(
            nil,
            -15,
            -9,
            30,
            9,
            __get(cor, 0)
        )
        R(
            nil,
            -15,
            -9,
            30,
            2,
            __get(cor, 1)
        )
        R(
            nil,
            -15,
            -2,
            30,
            2,
            __get(cor, 2)
        )
        R(
            nil,
            -15,
            -9,
            1,
            7,
            __get(cor, 2)
        )
        R(
            nil,
            -8,
            -17,
            16,
            8,
            __get(cor, 0)
        )
        R(
            nil,
            -8,
            -17,
            16,
            1,
            __get(cor, 1)
        )
        R(
            nil,
            -7,
            -16,
            6,
            6,
            "#a8d4e2"
        )
        R(
            nil,
            0,
            -16,
            7,
            6,
            "#8ab8c8"
        )
        R(
            nil,
            -7,
            -16,
            2,
            1,
            "#ffffff"
        )
        R(
            nil,
            -6,
            -15,
            1,
            2,
            "#e6f6fc"
        )
        R(
            nil,
            -1,
            -16,
            1,
            7,
            __get(cor, 2)
        )
        R(
            nil,
            2,
            -15,
            4,
            4,
            "#8a5a36"
        )
        R(
            nil,
            1,
            -16,
            6,
            1,
            "#e8c86a"
        )
        R(
            nil,
            2,
            -17,
            4,
            1,
            "#e8c86a"
        )
        R(
            nil,
            5,
            -13,
            1,
            1,
            "#1c1c1c"
        )
        R(
            nil,
            -1,
            -8,
            1,
            7,
            __get(cor, 2)
        )
        R(
            nil,
            1,
            -6,
            3,
            1,
            "#d8dce0"
        )
        R(
            nil,
            -11,
            -6,
            3,
            1,
            "#d8dce0"
        )
        if __t(taxi) then
            do
                local k = 0
                while k < 15 do
                    R(
                        nil,
                        -15 + k * 2,
                        -5,
                        2,
                        1,
                        if __t(__mod(k, 2)) then "#1c1c1c" else "#f6f6f0"
                    )
                    k = k + 1
                end
            end
            R(
                nil,
                -4,
                -22,
                9,
                5,
                K
            )
            R(
                nil,
                -3,
                -21,
                7,
                3,
                "#f6f6f0"
            )
            R(
                nil,
                -2,
                -20,
                1,
                1,
                "#1c1c1c"
            )
            R(
                nil,
                0,
                -20,
                1,
                1,
                "#1c1c1c"
            )
            R(
                nil,
                2,
                -20,
                1,
                1,
                "#1c1c1c"
            )
        end
        R(
            nil,
            -16,
            0,
            32,
            1,
            "#9aa0a6"
        )
        R(
            nil,
            14,
            -7,
            2,
            3,
            "#fff2b0"
        )
        R(
            nil,
            -15,
            -7,
            1,
            2,
            "#e83a3a"
        )
        R(
            nil,
            15,
            -3,
            1,
            2,
            "#ff9a3a"
        )
        local ____t_15 = __t
        local ____t_14 = __t
        local ____temp_13 = not __t(o.parado) and __mod(
            math.floor(t * 4),
            2
        ) == 0
        __O[610] = ____temp_13
        if ____t_15(if ____t_14(____temp_13) then not __t(o.voando) else __O[610]) then
            R(
                nil,
                15,
                -3,
                1,
                2,
                "#ffd36b"
            )
        end
        for ____, wx in __iterar((__arrL({-9, 9}, 2))) do
            R(
                nil,
                wx - 4,
                -2,
                8,
                6,
                K
            )
            R(
                nil,
                wx - 3,
                -1,
                6,
                4,
                "#2a2a2a"
            )
            R(
                nil,
                wx - 1,
                0,
                2,
                2,
                "#9aa0a6"
            )
            local a = if __t(o.roda) then o.roda else 0
            do
                local k = 0
                while k < 2 do
                    R(
                        nil,
                        wx - 1 + math.floor(math.cos(a + k * math.pi) * 2 + 0.5),
                        math.floor(1 + math.sin(a + k * math.pi) * 1.5 + 0.5) - 1,
                        1,
                        1,
                        "#d8dce0"
                    )
                    k = k + 1
                end
            end
        end
        P.c.globalAlpha = 0.16 + math.sin(t * 9) * 0.04
        do
            local k = 0
            while k < 9 do
                R(
                    nil,
                    16 + k * 2,
                    -8 - k * 0.45,
                    2,
                    4 + k * 0.9,
                    "#fff2b0"
                )
                k = k + 1
            end
        end
        P.c.globalAlpha = 1
    end
    local function fumaca(____, P, x, y, t)
        do
            local k = 0
            while k < 5 do
                local q = __mod(t * 0.4 + k / 5, 1)
                P.c.globalAlpha = (1 - q) * 0.55
                P:circ(
                    x + math.sin(t + k) * 3 + q * 6,
                    y - q * 26,
                    2 + q * 4,
                    "#f2f2ee"
                )
                k = k + 1
            end
        end
        P.c.globalAlpha = 1
    end
    local h = hash
    local A = window.Mapa3D.arte
    local shade = A.shade
    local function txt(____, P, s, x, y, col, o)
        if o == nil then
            o = {}
        end
        local ____opt_18 = window.CampanhaCamadas
        if ____opt_18 ~= nil then
            ____opt_18 = ____opt_18.kit
        end
        local ____opt_result_20
        if ____opt_18 ~= nil then
            ____opt_result_20 = ____opt_18.pxText
        end
        local f = ____opt_result_20
        if __t(f) then
            return f(
                nil,
                P.c,
                s,
                x,
                y,
                col,
                o
            )
        end
        P.c.font = "6px monospace"
        P.c.fillStyle = col
        P.c.textAlign = "center"
        P.c:fillText(s, x, y + 5)
        P.c.textAlign = "left"
        return 0
    end
    local function caixasDe(____, lista)
        return __call(
            lista,
            "map",
            function(____, L)
                local x, y, w, h = table.unpack(L.caixa, 1, 4)
                local dx, dy = table.unpack(if __t(L.desloc) then L.desloc else __arrL({0, 0}, 2), 1, 2)
                return __arrL(
                    {
                        __add(x, dx),
                        __add(y, dy),
                        w,
                        h
                    },
                    4
                )
            end
        )
    end
    local function faixa(____, pl, off, rev)
        local o = __call(
            pl,
            "map",
            function(____, p, k)
                local a = __get(
                    pl,
                    math.max(0, k - 1)
                )
                local b = __get(
                    pl,
                    math.min(
                        __len(pl) - 1,
                        k + 1
                    )
                )
                local dx = __get(b, 0) - __get(a, 0)
                local dy = __get(b, 1) - __get(a, 1)
                local ____t_22 = __t
                local ____hypot_result_21 = __hypot(dx, dy)
                __O[611] = ____hypot_result_21
                local l = if ____t_22(____hypot_result_21) then __O[611] else 1
                return __arrL(
                    {
                        __get(p, 0) - dy / l * off,
                        __get(p, 1) + dx / l * off
                    },
                    2
                )
            end
        )
        return if __t(rev) then __call(o, "reverse") else o
    end
    local function cruza(____, pl, y)
        local best = __get(pl, 0)
        local d = 1000000000
        for ____, p in __iterar((pl)) do
            local e = math.abs(__get(p, 1) - y)
            if e < d then
                d = e
                best = p
            end
        end
        return __get(best, 0)
    end
    local function veiculo(self, P, x, y, cor, ang, tipo)
        local R = P.R
        local vx = math.cos(ang)
        local vy = math.sin(ang)
        x = math.floor(x + 0.5)
        y = math.floor(y + 0.5)
        if tipo == "moto" then
            R(
                nil,
                x - 4,
                y,
                9,
                1,
                "rgba(0,0,0,.3)"
            )
            R(
                nil,
                x - 4,
                y - 3,
                8,
                2,
                "#2a2a2a"
            )
            R(
                nil,
                x - 4,
                y - 2,
                2,
                2,
                "#1c1c1c"
            )
            R(
                nil,
                x + 3,
                y - 2,
                2,
                2,
                "#1c1c1c"
            )
            R(
                nil,
                x - 2,
                y - 5,
                5,
                2,
                cor
            )
            R(
                nil,
                x - 1,
                y - 9,
                3,
                4,
                "#3c6aa8"
            )
            R(
                nil,
                x - 1,
                y - 11,
                3,
                2,
                cor
            )
            return
        end
        if tipo == "bus" then
            if math.abs(vy) > math.abs(vx) * 1.1 then
                R(
                    nil,
                    x - 7,
                    y - 1,
                    15,
                    3,
                    "rgba(0,0,0,.3)"
                )
                R(
                    nil,
                    x - 7,
                    y - 20,
                    14,
                    20,
                    cor
                )
                R(
                    nil,
                    x - 6,
                    if vy > 0 then y - 6 else y - 19,
                    12,
                    5,
                    "#9fc4d0"
                )
                R(
                    nil,
                    x - 7,
                    y - 11,
                    14,
                    2,
                    "#f2f2ee"
                )
                return
            end
            local d = if vx >= 0 then 1 else -1
            R(
                nil,
                x - 15,
                y,
                31,
                2,
                "rgba(0,0,0,.3)"
            )
            R(
                nil,
                x - 15,
                y - 13,
                30,
                13,
                cor
            )
            R(
                nil,
                x - 15,
                y - 13,
                30,
                1,
                "#ffffff66"
            )
            do
                local k = 0
                while k < 5 do
                    R(
                        nil,
                        x - 12 + k * 5,
                        y - 10,
                        4,
                        4,
                        "#9fc4d0"
                    )
                    k = k + 1
                end
            end
            R(
                nil,
                x - 15,
                y - 4,
                30,
                1,
                "#f2f2ee"
            )
            R(
                nil,
                if d > 0 then x + 12 else x - 15,
                y - 10,
                3,
                6,
                "#9fc4d0"
            )
            R(
                nil,
                x - 11,
                y,
                4,
                2,
                "#1c1c1c"
            )
            R(
                nil,
                x + 7,
                y,
                4,
                2,
                "#1c1c1c"
            )
            return
        end
        if math.abs(vy) > math.abs(vx) * 1.1 then
            R(
                nil,
                x - 6,
                y - 1,
                13,
                3,
                "rgba(0,0,0,.28)"
            )
            R(
                nil,
                x - 5,
                y - 13,
                10,
                14,
                cor
            )
            R(
                nil,
                x - 5,
                y - 13,
                10,
                1,
                "#ffffff66"
            )
            R(
                nil,
                x - 4,
                if vy > 0 then y - 4 else y - 12,
                8,
                3,
                "#9fc4d0"
            )
            R(
                nil,
                x - 4,
                y - 8,
                8,
                3,
                shade(nil, cor, 0.82)
            )
            for ____, ____value in __iterar((__arrL(
                {
                    __arrL({-6, -11}, 2),
                    __arrL({5, -11}, 2),
                    __arrL({-6, -4}, 2),
                    __arrL({5, -4}, 2)
                },
                4
            ))) do
                local a = ____value[1]
                local b = ____value[2]
                R(
                    nil,
                    x + a,
                    y + b,
                    1,
                    3,
                    "#1c1c1c"
                )
            end
            if vy > 0 then
                R(
                    nil,
                    x - 4,
                    y,
                    2,
                    1,
                    "#fff2b0"
                )
                R(
                    nil,
                    x + 2,
                    y,
                    2,
                    1,
                    "#fff2b0"
                )
            else
                R(
                    nil,
                    x - 4,
                    y - 13,
                    2,
                    1,
                    "#e8433a"
                )
                R(
                    nil,
                    x + 2,
                    y - 13,
                    2,
                    1,
                    "#e8433a"
                )
            end
            if tipo == "taxi" then
                R(
                    nil,
                    x - 2,
                    y - 10,
                    4,
                    2,
                    "#1c1c1c"
                )
            end
            return
        end
        carrinho(
            nil,
            P,
            x,
            y,
            cor,
            if vx >= 0 then 1 else -1,
            tipo == "taxi"
        )
    end
    local function naRua(____, P, t, pl, n, cores, vel, fase, tipo)
        if vel == nil then
            vel = 22
        end
        if fase == nil then
            fase = 0
        end
        local tr = A:trilho(pl)
        do
            local j = 0
            while __lt(j, n) do
                local p = tr:em(t * vel / tr.total + j / n + fase)
                veiculo(
                    nil,
                    P,
                    p.x,
                    p.y + 3,
                    __get(
                        cores,
                        __mod(
                            j,
                            __len(cores)
                        )
                    ),
                    p.ang,
                    if type(tipo) == "function" then tipo(nil, j) else tipo
                )
                j = j + 1
            end
        end
    end
    local function Lote(self, Tr, caixas)
        local rects = __call(
            caixas,
            "map",
            function(____, ____bindingPattern0)
                local h
                local w
                local y
                local x
                x = ____bindingPattern0[1]
                y = ____bindingPattern0[2]
                w = ____bindingPattern0[3]
                h = ____bindingPattern0[4]
                return __arrL({x - 6, y - 6, w + 12, h + 12}, 4)
            end
        )
        local function bate(____, x, y, w, h)
            return __call(
                rects,
                "some",
                function(____, ____bindingPattern0)
                    local d
                    local c
                    local b
                    local a
                    a = ____bindingPattern0[1]
                    b = ____bindingPattern0[2]
                    c = ____bindingPattern0[3]
                    d = ____bindingPattern0[4]
                    local ____t_26 = __t
                    local ____t_24 = __t
                    local ____temp_23 = __lt(
                        x,
                        __add(a, c)
                    ) and __gt(
                        __add(x, w),
                        a
                    )
                    __O[612] = ____temp_23
                    local ____temp_25 = if ____t_24(____temp_23) then __lt(
                        y,
                        __add(b, d)
                    ) else __O[612]
                    __O[613] = ____temp_25
                    return if ____t_26(____temp_25) then __gt(
                        __add(y, h),
                        b
                    ) else __O[613]
                end
            )
        end
        return {
            bate = bate,
            marca = function(____, x, y, w, h) return __call(
                rects,
                "push",
                __arrL({x, y, w, h}, 4)
            ) end,
            ponto = function(____, x, y, r, aceita)
                if r == nil then
                    r = 7
                end
                if aceita == nil then
                    aceita = Tr.livre
                end
                local ____t_29 = __t
                local ____t_28 = __t
                local ____temp_27 = not __t(aceita(nil, x, y))
                __O[614] = ____temp_27
                if ____t_29(if ____t_28(____temp_27) then __O[614] else bate(
                    nil,
                    x - r,
                    y - r * 0.6,
                    r * 2,
                    r * 1.2
                )) then
                    return false
                end
                __call(
                    rects,
                    "push",
                    __arrL({x - r, y - r * 0.6, r * 2, r * 1.2}, 4)
                )
                return true
            end,
            area = function(____, x, y, w, h, aceita)
                if aceita == nil then
                    aceita = Tr.livre
                end
                if __t(bate(
                    nil,
                    x,
                    y,
                    w,
                    h
                )) then
                    return false
                end
                do
                    local yy = y + h * 0.45
                    while __le(
                        yy,
                        __add(y, h)
                    ) do
                        do
                            local xx = x
                            while __le(
                                xx,
                                __add(x, w)
                            ) do
                                if not __t(aceita(nil, xx, yy)) then
                                    return false
                                end
                                xx = xx + 6
                            end
                        end
                        yy = yy + 6
                    end
                end
                __call(
                    rects,
                    "push",
                    __arrL({x, y, w, h}, 4)
                )
                return true
            end
        }
    end
    local function tipoEh(____, Tr, ...)
        local tipos = {...}
        return function(____, x, y)
            local ____t_33 = __t
            local ____t_31 = __t
            local ____gt_result_30 = __gt(
                Tr:nivelEm(x, y),
                0
            )
            __O[615] = ____gt_result_30
            local ____temp_32 = if ____t_31(____gt_result_30) then __call(
                tipos,
                "includes",
                Tr:tipoEm(x, y)
            ) else __O[615]
            __O[616] = ____temp_32
            return if ____t_33(____temp_32) then __lt(
                __get(
                    Tr.px.wd,
                    math.floor(y + 0.5) * Tr.px.W + math.floor(x + 0.5)
                ),
                0
            ) else __O[616]
        end
    end
    local pecas = __ord(
        {
            placaTaxi = function(____, P, x, y)
                local R = P.R
                R(
                    nil,
                    x,
                    y - 16,
                    2,
                    16,
                    "#5a5e62"
                )
                R(
                    nil,
                    x - 7,
                    y - 24,
                    16,
                    9,
                    "#1c1c1c"
                )
                R(
                    nil,
                    x - 6,
                    y - 23,
                    14,
                    7,
                    "#f2c94c"
                )
                txt(
                    nil,
                    P,
                    "TAXI",
                    x + 1,
                    y - 22,
                    "#1c1c1c"
                )
                R(
                    nil,
                    x - 1,
                    y,
                    5,
                    1,
                    "rgba(0,0,0,.25)"
                )
            end,
            outdoor = function(____, P, x, y, s, bg, fg)
                local R = P.R
                local w = math.max(
                    40,
                    __len(s) * 4 + 10
                )
                P:sombra(
                    x + w / 2 + 3,
                    y + 1,
                    w / 2,
                    3,
                    0.22
                )
                R(
                    nil,
                    x + 6,
                    y - 12,
                    2,
                    12,
                    "#5a5e62"
                )
                R(
                    nil,
                    x + w - 8,
                    y - 12,
                    2,
                    12,
                    "#5a5e62"
                )
                R(
                    nil,
                    x - 1,
                    y - 27,
                    w + 2,
                    17,
                    "#2a2a2a"
                )
                R(
                    nil,
                    x,
                    y - 26,
                    w,
                    15,
                    bg
                )
                txt(
                    nil,
                    P,
                    s,
                    x + w / 2,
                    y - 21,
                    fg
                )
            end,
            cacto = function(____, P, x, y)
                local R = P.R
                P:sombra(x + 1, y, 5, 2)
                P:circ(
                    x,
                    y - 3,
                    4,
                    "#3f7a3a",
                    3
                )
                P:circ(
                    x - 1,
                    y - 4,
                    2,
                    "#5a9a4a",
                    1
                )
                do
                    local k = -3
                    while k <= 3 do
                        R(
                            nil,
                            x + k,
                            y - 6,
                            1,
                            5,
                            "#2f5e2a"
                        )
                        k = k + 2
                    end
                end
                P:circ(
                    x,
                    y - 6,
                    2,
                    "#c43c5a",
                    1
                )
                R(
                    nil,
                    x,
                    y - 8,
                    1,
                    1,
                    "#ff8aa0"
                )
            end,
            antena = function(____, P, x, y)
                local R = P.R
                P:sombra(x + 6, y, 8, 2)
                do
                    local k = 0
                    while k < 44 do
                        local w = math.floor(6 - k / 10 + 0.5)
                        R(
                            nil,
                            x - w,
                            y - k - 4,
                            1,
                            4,
                            "#8a9096"
                        )
                        R(
                            nil,
                            x + w,
                            y - k - 4,
                            1,
                            4,
                            "#8a9096"
                        )
                        R(
                            nil,
                            x - w,
                            y - k - 2,
                            w * 2 + 1,
                            1,
                            "#a8aeb4"
                        )
                        k = k + 4
                    end
                end
                R(
                    nil,
                    x,
                    y - 50,
                    1,
                    6,
                    "#5a5e62"
                )
                R(
                    nil,
                    x - 3,
                    y - 30,
                    3,
                    4,
                    "#e8ecef"
                )
            end,
            pessoaG = function(____, P, x, y, roupa, pele, cabelo)
                if pele == nil then
                    pele = "#d9a57f"
                end
                if cabelo == nil then
                    cabelo = "#2a201a"
                end
                local R = P.R
                R(
                    nil,
                    x - 3,
                    y,
                    7,
                    1,
                    "rgba(0,0,0,.25)"
                )
                R(
                    nil,
                    x - 2,
                    y - 3,
                    2,
                    3,
                    "#2a2f3a"
                )
                R(
                    nil,
                    x + 1,
                    y - 3,
                    2,
                    3,
                    "#2a2f3a"
                )
                R(
                    nil,
                    x - 3,
                    y - 9,
                    7,
                    6,
                    roupa
                )
                R(
                    nil,
                    x - 2,
                    y - 13,
                    5,
                    4,
                    pele
                )
                R(
                    nil,
                    x - 2,
                    y - 14,
                    5,
                    2,
                    cabelo
                )
            end
        },
        "placaTaxi,outdoor,cacto,antena,pessoaG"
    )
    local C1 = __arrL(
        {
            __ord(
                {
                    id = 0,
                    nome = "A roça",
                    sub = "Onde tudo começou",
                    caixa = __arrL({64, 300, 176, 120}, 4),
                    cam = 300,
                    descricao = "Cheiro de terra molhada, galinheiro barulhento e um carro velho que não anda sozinho. Tudo começa aqui. E alguma coisa sempre precisa de conserto.",
                    desenho = function(____, P)
                        P:casa(
                            100,
                            330,
                            76,
                            60,
                            {
                                telhado = "#c8543a",
                                parede = "#f2e2c0",
                                chamine = true,
                                janelas = __arrL({8, 58}, 2)
                            }
                        )
                        P:R(
                            190,
                            352,
                            26,
                            34,
                            "#a8643a"
                        )
                        P:R(
                            190,
                            352,
                            26,
                            4,
                            "#c8844a"
                        )
                        do
                            local k = 0
                            while k < 26 do
                                P:R(
                                    190 + k,
                                    356,
                                    1,
                                    30,
                                    "#7a4426"
                                )
                                k = k + 4
                            end
                        end
                        P:R(
                            186,
                            346,
                            34,
                            8,
                            "#8a4a2a"
                        )
                        P:R(
                            80,
                            310,
                            4,
                            62,
                            "#8a6a45"
                        )
                        P:R(
                            78,
                            306,
                            8,
                            6,
                            "#6a4a2a"
                        )
                        P:cercaH(70, 404, 150)
                        for ____, ____value in __iterar((__arrL(
                            {
                                __arrL({196, 396}, 2),
                                __arrL({206, 392}, 2),
                                __arrL({214, 398}, 2)
                            },
                            3
                        ))) do
                            local x = ____value[1]
                            local y = ____value[2]
                            P:R(
                                x,
                                y - 4,
                                5,
                                4,
                                "#f6f6f0"
                            )
                            P:R(
                                x + 4,
                                y - 6,
                                2,
                                2,
                                "#c43c3a"
                            )
                        end
                    end
                },
                "id,nome,sub,caixa,cam,descricao,desenho"
            ),
            __ord(
                {
                    id = 7,
                    nome = "Campo do Mota",
                    sub = "Futebol e experiência",
                    caixa = __arrL({56, 56, 208, 150}, 4),
                    descricao = "Grama alta, trave torta e um treinador que exige o máximo. O que se aprende ali muda o jeito de correr para sempre.",
                    desenho = function(____, P)
                        local R = P.R
                        R(
                            nil,
                            64,
                            64,
                            192,
                            128,
                            "rgba(255,255,255,0)"
                        )
                        R(
                            nil,
                            160,
                            66,
                            2,
                            124,
                            "#f2f2ee"
                        )
                        P:circ(
                            160,
                            128,
                            16,
                            "#f2f2ee",
                            10
                        )
                        P:circ(
                            160,
                            128,
                            14,
                            "#62aa4e",
                            8
                        )
                        for ____, gx in __iterar((__arrL({66, 246}, 2))) do
                            R(
                                nil,
                                gx,
                                108,
                                3,
                                36,
                                "#f6f6f0"
                            )
                            R(
                                nil,
                                gx,
                                106,
                                10 * if gx < 100 then 1 else -1 + 0,
                                3,
                                "#f6f6f0"
                            )
                            R(
                                nil,
                                gx + if gx < 100 then 6 else -9,
                                108,
                                3,
                                36,
                                "#e8e8e2"
                            )
                        end
                        R(
                            nil,
                            100,
                            58,
                            120,
                            14,
                            "#8a9096"
                        )
                        R(
                            nil,
                            100,
                            58,
                            120,
                            3,
                            "#b8bcc0"
                        )
                        do
                            local k = 0
                            while k < 8 do
                                R(
                                    nil,
                                    104 + k * 14,
                                    62,
                                    10,
                                    4,
                                    __get(
                                        __arrL({"#e8433a", "#2c5a9e", "#f2c94c"}, 3),
                                        __mod(k, 3)
                                    )
                                )
                                k = k + 1
                            end
                        end
                        R(
                            nil,
                            140,
                            160,
                            4,
                            4,
                            "#ffffff"
                        )
                    end
                },
                "id,nome,sub,caixa,descricao,desenho"
            ),
            __ord(
                {
                    id = 1,
                    nome = "Colégio Adventista",
                    sub = "Professores e provocações",
                    caixa = __arrL({416, 20, 190, 130}, 4),
                    descricao = "Corredores compridos, professores de olho em tudo e uma provocação esperando no fim do corredor. Leve o caderno. E coragem.",
                    desenho = function(____, P)
                        P:predio(
                            430,
                            34,
                            162,
                            106,
                            {topo = "#3c6aa8", parede = "#efebe0", faixa = "#2c5a9e", fachada = 36}
                        )
                        P:R(
                            480,
                            112,
                            60,
                            10,
                            "#2c5a9e"
                        )
                        P:R(
                            484,
                            114,
                            52,
                            6,
                            "#f2efe6"
                        )
                        P:R(
                            420,
                            30,
                            3,
                            70,
                            "#c8ccd0"
                        )
                        P:R(
                            423,
                            30,
                            14,
                            9,
                            "#3c8a5a"
                        )
                        P:R(
                            423,
                            33,
                            14,
                            2,
                            "#f2c94c"
                        )
                        P:R(
                            470,
                            136,
                            80,
                            9,
                            "#2c5a9e"
                        )
                        txt(
                            nil,
                            P,
                            "COLÉGIO ADVENTISTA",
                            510,
                            138,
                            "#f2efe6"
                        )
                        for ____, x in __iterar((__arrL({440, 572}, 2))) do
                            P:arbusto(x, 146, x, "#e86a8a")
                        end
                    end
                },
                "id,nome,sub,caixa,descricao,desenho"
            ),
            __ord(
                {
                    id = 9,
                    nome = "Pátio da escola",
                    sub = "O intervalo mais longo do mundo",
                    caixa = __arrL({690, 52, 132, 120}, 4),
                    descricao = "Na hora do intervalo tudo pode acontecer. Alguém por ali precisa de ajuda... e outra pessoa está doida por uma revanche.",
                    desenho = function(____, P)
                        local R = P.R
                        R(
                            nil,
                            692,
                            54,
                            128,
                            24,
                            "#efebe0"
                        )
                        R(
                            nil,
                            692,
                            52,
                            128,
                            4,
                            "#3c6aa8"
                        )
                        R(
                            nil,
                            692,
                            70,
                            128,
                            4,
                            "#2c5a9e"
                        )
                        do
                            local x = 698
                            while x < 816 do
                                R(
                                    nil,
                                    x,
                                    58,
                                    9,
                                    8,
                                    "#3a5a8a"
                                )
                                R(
                                    nil,
                                    x,
                                    58,
                                    3,
                                    2,
                                    "#9ac8f0"
                                )
                                x = x + 14
                            end
                        end
                        R(
                            nil,
                            750,
                            62,
                            12,
                            12,
                            "#5a6f86"
                        )
                        R(
                            nil,
                            714,
                            46,
                            50,
                            8,
                            "#2c5a9e"
                        )
                        txt(
                            nil,
                            P,
                            "PÁTIO",
                            739,
                            47,
                            "#f2efe6"
                        )
                        R(
                            nil,
                            692,
                            78,
                            128,
                            92,
                            "#d8d4cc"
                        )
                        do
                            local y = 78
                            while y < 170 do
                                R(
                                    nil,
                                    692,
                                    y,
                                    128,
                                    1,
                                    "#c4c0b8"
                                )
                                y = y + 10
                            end
                        end
                        do
                            local x = 692
                            while x < 820 do
                                R(
                                    nil,
                                    x,
                                    78,
                                    1,
                                    92,
                                    "#c4c0b8"
                                )
                                x = x + 16
                            end
                        end
                        R(
                            nil,
                            700,
                            118,
                            20,
                            20,
                            "#8a8478"
                        )
                        R(
                            nil,
                            702,
                            120,
                            16,
                            16,
                            "#6a5a44"
                        )
                        P:coqueiro(710, 132)
                        P:banco(732, 104)
                        P:banco(772, 104)
                        P:banco(752, 150)
                        P:banco(796, 140)
                        for ____, x in __iterar((__arrL({696, 816}, 2))) do
                            R(
                                nil,
                                x,
                                80,
                                2,
                                22,
                                "#7a8086"
                            )
                        end
                        do
                            local k = 0
                            while k < 15 do
                                local x = 698 + k * 8
                                local y = 82 + math.floor(math.sin(k / 14 * math.pi) * 5 + 0.5)
                                R(
                                    nil,
                                    x,
                                    y,
                                    5,
                                    4,
                                    __get(
                                        __arrL({
                                            "#e8433a",
                                            "#f2c94c",
                                            "#3c8a5a",
                                            "#3c6aa8",
                                            "#e86a8a"
                                        }, 5),
                                        __mod(k, 5)
                                    )
                                )
                                R(
                                    nil,
                                    x + 1,
                                    y + 4,
                                    3,
                                    1,
                                    "#00000033"
                                )
                                k = k + 1
                            end
                        end
                        R(
                            nil,
                            780,
                            120,
                            30,
                            12,
                            "#a8643a"
                        )
                        R(
                            nil,
                            780,
                            120,
                            30,
                            2,
                            "#c8844a"
                        )
                        txt(
                            nil,
                            P,
                            "SHOW",
                            795,
                            123,
                            "#f2e2b8"
                        )
                        pessoa(
                            nil,
                            P,
                            760,
                            132,
                            "#e8433a"
                        )
                        pessoa(
                            nil,
                            P,
                            790,
                            160,
                            "#3c6aa8"
                        )
                        pessoa(
                            nil,
                            P,
                            724,
                            160,
                            "#f2c94c"
                        )
                    end
                },
                "id,nome,sub,caixa,descricao,desenho"
            ),
            __ord(
                {
                    id = 6,
                    nome = "Caderno do Caos",
                    sub = "O monstro gigante",
                    caixa = __arrL({432, 186, 150, 104}, 4),
                    descricao = "As páginas viraram sozinhas. Os rabiscos ganharam vida. E aquela coisa enorme desenhada na última folha... acordou.",
                    desenho = function(____, P)
                        local R = P.R
                        P:sombra(
                            510,
                            286,
                            72,
                            8,
                            0.3
                        )
                        R(
                            nil,
                            438,
                            204,
                            144,
                            82,
                            "#4a1e6a"
                        )
                        R(
                            nil,
                            438,
                            204,
                            144,
                            3,
                            "#6a3a8a"
                        )
                        R(
                            nil,
                            444,
                            210,
                            64,
                            70,
                            "#f0e8f8"
                        )
                        R(
                            nil,
                            512,
                            210,
                            64,
                            70,
                            "#ebe2f4"
                        )
                        do
                            local k = 0
                            while k < 9 do
                                R(
                                    nil,
                                    446,
                                    218 + k * 7,
                                    60,
                                    1,
                                    "#b89ad8"
                                )
                                R(
                                    nil,
                                    514,
                                    218 + k * 7,
                                    60,
                                    1,
                                    "#b89ad8"
                                )
                                k = k + 1
                            end
                        end
                        R(
                            nil,
                            454,
                            210,
                            1,
                            70,
                            "#e86a8a"
                        )
                        do
                            local k = 0
                            while k < 10 do
                                P:circ(
                                    510,
                                    213 + k * 7,
                                    3,
                                    "#5a5e64",
                                    2
                                )
                                P:circ(
                                    510,
                                    213 + k * 7,
                                    2,
                                    "#c8ccd0",
                                    1
                                )
                                k = k + 1
                            end
                        end
                        do
                            local k = 0
                            while k < 5 do
                                R(
                                    nil,
                                    462 + k * 8,
                                    262 - __mod(k, 2) * 4,
                                    6,
                                    2,
                                    "#2a2a3a"
                                )
                                k = k + 1
                            end
                        end
                        R(
                            nil,
                            462,
                            232,
                            24,
                            2,
                            "#2a2a3a"
                        )
                        R(
                            nil,
                            470,
                            240,
                            30,
                            2,
                            "#2a2a3a"
                        )
                        txt(
                            nil,
                            P,
                            "TEM FOME",
                            476,
                            246,
                            "#7a3a8a"
                        )
                        for ____, ____value in __iterar((__arrL(
                            {
                                __arrL({446, "#f2c94c"}, 2),
                                __arrL({566, "#e8433a"}, 2),
                                __arrL({574, "#3c6aa8"}, 2)
                            },
                            3
                        ))) do
                            local x = ____value[1]
                            local cor = ____value[2]
                            R(
                                nil,
                                x,
                                188,
                                6,
                                44,
                                cor
                            )
                            R(
                                nil,
                                x,
                                188,
                                2,
                                44,
                                "#ffffff55"
                            )
                            R(
                                nil,
                                x,
                                182,
                                6,
                                6,
                                "#f6c8c8"
                            )
                            R(
                                nil,
                                x,
                                186,
                                6,
                                2,
                                "#c8ccd0"
                            )
                            R(
                                nil,
                                x + 1,
                                232,
                                4,
                                4,
                                "#e8d0a8"
                            )
                            R(
                                nil,
                                x + 2,
                                236,
                                2,
                                3,
                                "#2a2a2a"
                            )
                        end
                        R(
                            nil,
                            528,
                            222,
                            32,
                            36,
                            "#7a3a8a"
                        )
                        R(
                            nil,
                            524,
                            214,
                            40,
                            16,
                            "#8a4a9a"
                        )
                        R(
                            nil,
                            532,
                            219,
                            8,
                            6,
                            "#ffffff"
                        )
                        R(
                            nil,
                            548,
                            219,
                            8,
                            6,
                            "#ffffff"
                        )
                        R(
                            nil,
                            535,
                            221,
                            3,
                            3,
                            "#1c1c1c"
                        )
                        R(
                            nil,
                            551,
                            221,
                            3,
                            3,
                            "#1c1c1c"
                        )
                        do
                            local k = 0
                            while k < 6 do
                                R(
                                    nil,
                                    532 + k * 4,
                                    232,
                                    2,
                                    3,
                                    "#ffffff"
                                )
                                k = k + 1
                            end
                        end
                        R(
                            nil,
                            518,
                            236,
                            12,
                            4,
                            "#7a3a8a"
                        )
                        R(
                            nil,
                            558,
                            234,
                            12,
                            4,
                            "#7a3a8a"
                        )
                        for ____, ____value in __iterar((__arrL(
                            {
                                __arrL({452, 276}, 2),
                                __arrL({570, 270}, 2),
                                __arrL({500, 284}, 2)
                            },
                            3
                        ))) do
                            local x = ____value[1]
                            local y = ____value[2]
                            P:circ(
                                x,
                                y,
                                3,
                                "#3a1a4a",
                                2
                            )
                        end
                    end
                },
                "id,nome,sub,caixa,descricao,desenho"
            ),
            __ord(
                {
                    id = 3,
                    nome = "A quadra",
                    sub = "O bolo está por perto",
                    caixa = __arrL({656, 336, 132, 100}, 4),
                    desloc = __arrL({12, 0}, 2),
                    descricao = "O som da bola quicando chega até a rua. Tem alguém lá dentro que sabe muito bem onde o bolo foi parar...",
                    desenho = function(____, P)
                        local R = P.R
                        R(
                            nil,
                            666,
                            352,
                            124,
                            82,
                            "#c8643a"
                        )
                        R(
                            nil,
                            666,
                            352,
                            124,
                            6,
                            "#3c8a5a"
                        )
                        R(
                            nil,
                            666,
                            428,
                            124,
                            6,
                            "#3c8a5a"
                        )
                        R(
                            nil,
                            672,
                            358,
                            112,
                            1,
                            "#f2f2ee"
                        )
                        R(
                            nil,
                            672,
                            427,
                            112,
                            1,
                            "#f2f2ee"
                        )
                        R(
                            nil,
                            727,
                            358,
                            2,
                            70,
                            "#f2f2ee"
                        )
                        P:circ(
                            728,
                            392,
                            12,
                            "#f2f2ee",
                            9
                        )
                        P:circ(
                            728,
                            392,
                            10,
                            "#c8643a",
                            7
                        )
                        for ____, x in __iterar((__arrL({676, 776}, 2))) do
                            R(
                                nil,
                                x,
                                380,
                                3,
                                26,
                                "#c8ccd0"
                            )
                            R(
                                nil,
                                x - 4,
                                378,
                                11,
                                8,
                                "#f6f6f0"
                            )
                            R(
                                nil,
                                x - 1,
                                386,
                                5,
                                3,
                                "#e8433a"
                            )
                        end
                        do
                            local k = 0
                            while k <= 120 do
                                R(
                                    nil,
                                    664 + k,
                                    340,
                                    2,
                                    14,
                                    "#7a8086"
                                )
                                k = k + 8
                            end
                        end
                        R(
                            nil,
                            664,
                            342,
                            122,
                            1,
                            "#9aa0a6"
                        )
                        R(
                            nil,
                            664,
                            348,
                            122,
                            1,
                            "#9aa0a6"
                        )
                        do
                            local k = 0
                            while k < 15 do
                                local x = 666 + k * 8
                                local y = 336 + math.floor(math.sin(k / 14 * math.pi) * 4 + 0.5)
                                R(
                                    nil,
                                    x,
                                    y,
                                    5,
                                    4,
                                    __get(
                                        __arrL({"#e8433a", "#f2c94c", "#3c8a5a", "#3c6aa8"}, 4),
                                        __mod(k, 4)
                                    )
                                )
                                k = k + 1
                            end
                        end
                        R(
                            nil,
                            694,
                            410,
                            30,
                            6,
                            "#a8643a"
                        )
                        R(
                            nil,
                            694,
                            410,
                            30,
                            2,
                            "#c8844a"
                        )
                        P:circ(752, 400, 3, "#e8833a")
                        R(
                            nil,
                            751,
                            398,
                            1,
                            5,
                            "#7a3a10"
                        )
                        pessoa(
                            nil,
                            P,
                            704,
                            404,
                            "#2c5a9e"
                        )
                    end
                },
                "id,nome,sub,caixa,desloc,descricao,desenho"
            ),
            __ord(
                {
                    id = 4,
                    nome = "Praça Camacan",
                    sub = "Uma pausa na resenha",
                    caixa = __arrL({470, 380, 176, 150}, 4),
                    desloc = __arrL({-20, 0}, 2),
                    descricao = "Banco de praça, sorvete e fofoca fresquinha. Às vezes, uma pausa é tudo de que a resenha precisa.",
                    desenho = function(____, P)
                        local R = P.R
                        P:fonte(560, 452)
                        for ____, ____value in __iterar((__arrL(
                            {
                                __arrL({494, 420}, 2),
                                __arrL({626, 420}, 2),
                                __arrL({494, 516}, 2),
                                __arrL({626, 516}, 2)
                            },
                            4
                        ))) do
                            local x = ____value[1]
                            local y = ____value[2]
                            P:coqueiro(x, y)
                        end
                        for ____, ____value in __iterar((__arrL(
                            {
                                __arrL({520, 420}, 2),
                                __arrL({590, 420}, 2),
                                __arrL({520, 494}, 2),
                                __arrL({590, 494}, 2)
                            },
                            4
                        ))) do
                            local x = ____value[1]
                            local y = ____value[2]
                            P:banco(x, y)
                        end
                        for ____, ____value in __iterar((__arrL(
                            {
                                __arrL({504, 470}, 2),
                                __arrL({612, 470}, 2)
                            },
                            2
                        ))) do
                            local x = ____value[1]
                            local y = ____value[2]
                            P:flores(
                                x,
                                y,
                                __arrL({"#e86a8a", "#f2c94c", "#ffffff"}, 3)
                            )
                        end
                        P:poste(482, 456)
                        P:poste(636, 456)
                        R(
                            nil,
                            476,
                            386,
                            4,
                            140,
                            "#c8ccd0"
                        )
                        R(
                            nil,
                            476,
                            386,
                            1,
                            140,
                            "#eef0f2"
                        )
                        do
                            local y = 390
                            while y < 526 do
                                R(
                                    nil,
                                    472,
                                    y,
                                    4,
                                    2,
                                    "#a8aeb4"
                                )
                                y = y + 10
                            end
                        end
                        R(
                            nil,
                            530,
                            384,
                            60,
                            12,
                            "#f2f0e8"
                        )
                        R(
                            nil,
                            530,
                            384,
                            60,
                            2,
                            "#2c5a9e"
                        )
                        txt(
                            nil,
                            P,
                            "PRAÇA CAMACAN",
                            560,
                            388,
                            "#2c5a9e"
                        )
                        R(
                            nil,
                            536,
                            396,
                            2,
                            8,
                            "#7a8086"
                        )
                        R(
                            nil,
                            582,
                            396,
                            2,
                            8,
                            "#7a8086"
                        )
                        R(
                            nil,
                            600,
                            520,
                            30,
                            14,
                            "#e8e4dc"
                        )
                        do
                            local k = 0
                            while k < 30 do
                                R(
                                    nil,
                                    600 + k,
                                    512,
                                    3,
                                    8,
                                    if __t(__mod(k, 12)) then "#3c8ab0" else "#f6f6f0"
                                )
                                k = k + 6
                            end
                        end
                        R(
                            nil,
                            600,
                            512,
                            30,
                            2,
                            "#2c5a9e"
                        )
                        R(
                            nil,
                            606,
                            524,
                            18,
                            6,
                            "#9ad0e8"
                        )
                        pessoa(
                            nil,
                            P,
                            540,
                            470,
                            "#e8833a"
                        )
                        pessoa(
                            nil,
                            P,
                            584,
                            506,
                            "#7a3a8a"
                        )
                    end
                },
                "id,nome,sub,caixa,desloc,descricao,desenho"
            ),
            __ord(
                {
                    id = 2,
                    nome = "Academia do Caleb",
                    sub = "Caleb e o shape",
                    caixa = __arrL({856, 196, 120, 100}, 4),
                    descricao = "Dizem que ninguém sai de lá do mesmo jeito que entrou. Os reflexos que o digam. E o espelho também.",
                    desenho = function(____, P)
                        local R = P.R
                        P:predio(
                            866,
                            216,
                            100,
                            72,
                            {
                                topo = "#2e3a34",
                                parede = "#3f5a4c",
                                fachada = 32,
                                caixa = false,
                                porta = false
                            }
                        )
                        for ____, x in __iterar((__arrL({872, 904, 936}, 3))) do
                            R(
                                nil,
                                x,
                                258,
                                24,
                                18,
                                "#24302a"
                            )
                            R(
                                nil,
                                x + 1,
                                259,
                                22,
                                16,
                                "#9ac8d8"
                            )
                            do
                                local y = 260
                                while y < 274 do
                                    R(
                                        nil,
                                        x + 1,
                                        y,
                                        22,
                                        1,
                                        "#d8e8ec"
                                    )
                                    y = y + 3
                                end
                            end
                        end
                        R(
                            nil,
                            906,
                            278,
                            16,
                            10,
                            "#1c2420"
                        )
                        R(
                            nil,
                            907,
                            279,
                            14,
                            9,
                            "#7ab0c0"
                        )
                        R(
                            nil,
                            878,
                            200,
                            76,
                            14,
                            "#1c1c1c"
                        )
                        R(
                            nil,
                            878,
                            200,
                            76,
                            2,
                            "#e8433a"
                        )
                        txt(
                            nil,
                            P,
                            "CALEB",
                            906,
                            204,
                            "#f2c94c"
                        )
                        R(
                            nil,
                            934,
                            205,
                            14,
                            2,
                            "#c8ccd0"
                        )
                        R(
                            nil,
                            932,
                            202,
                            3,
                            8,
                            "#5a5e64"
                        )
                        R(
                            nil,
                            947,
                            202,
                            3,
                            8,
                            "#5a5e64"
                        )
                        R(
                            nil,
                            858,
                            290,
                            26,
                            4,
                            "#5a5e64"
                        )
                        for ____, x in __iterar((__arrL({856, 880}, 2))) do
                            R(
                                nil,
                                x,
                                286,
                                4,
                                10,
                                "#2a2a2a"
                            )
                        end
                        R(
                            nil,
                            944,
                            288,
                            6,
                            8,
                            "#f2f2ee"
                        )
                        R(
                            nil,
                            945,
                            286,
                            4,
                            2,
                            "#3c8ab0"
                        )
                        do
                            local y = 236
                            P:sombra(
                                916,
                                y + 12,
                                44,
                                4,
                                0.3
                            )
                            R(
                                nil,
                                880,
                                y - 2,
                                72,
                                5,
                                "#3a3f44"
                            )
                            R(
                                nil,
                                880,
                                y - 2,
                                72,
                                2,
                                "#c8ccd0"
                            )
                            R(
                                nil,
                                880,
                                y + 2,
                                72,
                                1,
                                "#2a2e32"
                            )
                            for ____, ____value in __iterar((__arrL(
                                {
                                    __arrL({872, 8, 26, "#1c1c20"}, 4),
                                    __arrL({864, 7, 20, "#c43c3a"}, 4),
                                    __arrL({952, 8, 26, "#1c1c20"}, 4),
                                    __arrL({960, 7, 20, "#c43c3a"}, 4)
                                },
                                4
                            ))) do
                                local x = ____value[1]
                                local w = ____value[2]
                                local h = ____value[3]
                                local cor = ____value[4]
                                R(
                                    nil,
                                    x - 1,
                                    y - h / 2 - 1,
                                    w + 2,
                                    h + 2,
                                    "#0a0a0c"
                                )
                                R(
                                    nil,
                                    x,
                                    y - h / 2,
                                    w,
                                    h,
                                    cor
                                )
                                R(
                                    nil,
                                    x,
                                    y - h / 2,
                                    2,
                                    h,
                                    "#ffffff33"
                                )
                                R(
                                    nil,
                                    x,
                                    y - h / 2,
                                    w,
                                    2,
                                    "#ffffff22"
                                )
                            end
                            R(
                                nil,
                                856,
                                y - 4,
                                7,
                                9,
                                "#5a5e64"
                            )
                            R(
                                nil,
                                968,
                                y - 4,
                                7,
                                9,
                                "#5a5e64"
                            )
                            txt(
                                nil,
                                P,
                                "200KG",
                                916,
                                y - 12,
                                "#f2c94c"
                            )
                        end
                    end
                },
                "id,nome,sub,caixa,descricao,desenho"
            ),
            __ord(
                {
                    id = 8,
                    nome = "Bigodon",
                    sub = "Davi Costa e Vitor",
                    caixa = __arrL({848, 340, 116, 112}, 4),
                    descricao = "Tesoura afiada, espelho que parece mágico e a melhor conversa da cidade. Você sai de lá com outro visual?",
                    desenho = function(____, P)
                        local R = P.R
                        P:casa(
                            868,
                            388,
                            78,
                            58,
                            {
                                telhado = "#5a3a2a",
                                parede = "#ecd6a8",
                                madeira = true,
                                paredeH = 26,
                                janelas = __arrL({8, 58}, 2),
                                porta = 34
                            }
                        )
                        do
                            local k = 0
                            while k < 78 do
                                R(
                                    nil,
                                    868 + k,
                                    412,
                                    6,
                                    6,
                                    if __t(__mod(k, 12)) then "#f2f2ee" else "#c43c3a"
                                )
                                k = k + 6
                            end
                        end
                        R(
                            nil,
                            868,
                            418,
                            78,
                            1,
                            "#00000033"
                        )
                        R(
                            nil,
                            882,
                            344,
                            52,
                            13,
                            "#2a1a10"
                        )
                        R(
                            nil,
                            883,
                            345,
                            50,
                            11,
                            "#3a2a1a"
                        )
                        txt(
                            nil,
                            P,
                            "BIGODON",
                            908,
                            347,
                            "#e8c66a"
                        )
                        R(
                            nil,
                            890,
                            357,
                            2,
                            10,
                            "#5a3820"
                        )
                        R(
                            nil,
                            924,
                            357,
                            2,
                            10,
                            "#5a3820"
                        )
                        R(
                            nil,
                            858,
                            404,
                            6,
                            30,
                            "#f2f2ee"
                        )
                        do
                            local k = 0
                            while k < 10 do
                                R(
                                    nil,
                                    858,
                                    404 + k * 3,
                                    6,
                                    2,
                                    if __mod(k, 3) == 0 then "#c43c3a" else if __mod(k, 3) == 1 then "#2c5a9e" else "#f2f2ee"
                                )
                                k = k + 1
                            end
                        end
                        R(
                            nil,
                            857,
                            401,
                            8,
                            3,
                            "#c8ccd0"
                        )
                        R(
                            nil,
                            857,
                            434,
                            8,
                            3,
                            "#c8ccd0"
                        )
                        R(
                            nil,
                            878,
                            424,
                            10,
                            8,
                            "#c43c3a"
                        )
                        R(
                            nil,
                            879,
                            422,
                            8,
                            3,
                            "#e8433a"
                        )
                        R(
                            nil,
                            926,
                            424,
                            10,
                            8,
                            "#c43c3a"
                        )
                        R(
                            nil,
                            927,
                            422,
                            8,
                            3,
                            "#e8433a"
                        )
                        do
                            local cx = 907
                            local cy = 380
                            P:sombra(
                                cx + 4,
                                cy + 12,
                                44,
                                5,
                                0.35
                            )
                            for ____, lado in __iterar((__arrL({-1, 1}, 2))) do
                                do
                                    local k = 0
                                    while k < 30 do
                                        local t = k / 29
                                        local x = cx + lado * (2 + t * 42)
                                        local y = cy - math.sin(t * math.pi) * 6 + t * t * 5 - if t > 0.82 then (t - 0.82) * 50 else 0
                                        local esp = math.floor(13 * (1 - t * 0.75) + 0.5)
                                        R(
                                            nil,
                                            x - 2,
                                            y - esp / 2 - 2,
                                            4,
                                            esp + 4,
                                            "#0e0806"
                                        )
                                        k = k + 1
                                    end
                                end
                                do
                                    local k = 0
                                    while k < 30 do
                                        local t = k / 29
                                        local x = cx + lado * (2 + t * 42)
                                        local y = cy - math.sin(t * math.pi) * 6 + t * t * 5 - if t > 0.82 then (t - 0.82) * 50 else 0
                                        local esp = math.floor(13 * (1 - t * 0.75) + 0.5)
                                        R(
                                            nil,
                                            x - 1,
                                            y - esp / 2,
                                            3,
                                            esp,
                                            "#3a2418"
                                        )
                                        if __mod(k, 3) == 1 then
                                            R(
                                                nil,
                                                x - 1,
                                                y - esp / 2 + 1,
                                                3,
                                                2,
                                                "#7a5238"
                                            )
                                        end
                                        k = k + 1
                                    end
                                end
                            end
                            R(
                                nil,
                                cx - 4,
                                cy - 7,
                                8,
                                13,
                                "#0e0806"
                            )
                            R(
                                nil,
                                cx - 3,
                                cy - 6,
                                6,
                                11,
                                "#3a2418"
                            )
                            R(
                                nil,
                                cx - 2,
                                cy - 5,
                                2,
                                3,
                                "#7a5238"
                            )
                        end
                    end
                },
                "id,nome,sub,caixa,descricao,desenho"
            ),
            __ord(
                {
                    id = 10,
                    nome = "Casa de Rayssa",
                    sub = "As garotas e a resenha",
                    caixa = __arrL({652, 556, 120, 96}, 4),
                    desloc = __arrL({16, 0}, 2),
                    descricao = "Entra, mas limpa o tênis. As garotas estão reunidas e, lá dentro, tem um segredo elétrico esperando por você.",
                    desenho = function(____, P)
                        local R = P.R
                        P:casa(
                            670,
                            570,
                            84,
                            64,
                            {
                                telhado = "#d06a4a",
                                parede = "#f6d8b8",
                                paredeH = 28,
                                janelas = __arrL({6, 62}, 2),
                                porta = 36
                            }
                        )
                        for ____, x in __iterar((__arrL({676, 732}, 2))) do
                            R(
                                nil,
                                x - 1,
                                608,
                                18,
                                14,
                                "#7a4a2a"
                            )
                            R(
                                nil,
                                x,
                                609,
                                16,
                                12,
                                "#bfe0f0"
                            )
                            R(
                                nil,
                                x,
                                609,
                                5,
                                12,
                                "#f29ab8"
                            )
                            R(
                                nil,
                                x + 11,
                                609,
                                5,
                                12,
                                "#f29ab8"
                            )
                            R(
                                nil,
                                x,
                                609,
                                16,
                                2,
                                "#e86a8a"
                            )
                            R(
                                nil,
                                x + 6,
                                614,
                                4,
                                4,
                                "#3c8a5a"
                            )
                        end
                        for ____, x in __iterar((__arrL({664, 756}, 2))) do
                            R(
                                nil,
                                x,
                                626,
                                8,
                                7,
                                "#c8643a"
                            )
                            R(
                                nil,
                                x,
                                626,
                                8,
                                2,
                                "#e8844a"
                            )
                            P:circ(
                                x + 4,
                                622,
                                5,
                                "#3f8a30",
                                4
                            )
                            P:circ(
                                x + 3,
                                620,
                                2,
                                "#58a83c",
                                2
                            )
                        end
                        P:cercaH(660, 648, 104)
                        P:flores(
                            666,
                            636,
                            __arrL({"#e86a8a", "#f2c94c", "#b86ad8"}, 3)
                        )
                        P:flores(
                            736,
                            636,
                            __arrL({"#e86a8a", "#ffffff"}, 2)
                        )
                        R(
                            nil,
                            704,
                            556,
                            26,
                            9,
                            "#f6eadc"
                        )
                        R(
                            nil,
                            704,
                            556,
                            26,
                            1,
                            "#e86a8a"
                        )
                        txt(
                            nil,
                            P,
                            "RAYSSA",
                            717,
                            558,
                            "#c8546a"
                        )
                    end
                },
                "id,nome,sub,caixa,desloc,descricao,desenho"
            ),
            __ord(
                {
                    id = 11,
                    nome = "Baile funk",
                    sub = "Ollyan e a perseguição",
                    caixa = __arrL({836, 556, 160, 120}, 4),
                    desloc = __arrL({16, 0}, 2),
                    descricao = "O grave treme o chão, as luzes não param e a pista está cheia. E tem um carro por ali que não devia estar no céu...",
                    desenho = function(____, P)
                        local R = P.R
                        R(
                            nil,
                            846,
                            574,
                            140,
                            90,
                            "#2a2440"
                        )
                        do
                            local y = 574
                            while y < 664 do
                                R(
                                    nil,
                                    846,
                                    y,
                                    140,
                                    1,
                                    "#322c4a"
                                )
                                y = y + 6
                            end
                        end
                        R(
                            nil,
                            856,
                            578,
                            120,
                            18,
                            "#1a1626"
                        )
                        R(
                            nil,
                            856,
                            578,
                            120,
                            2,
                            "#5a4a7a"
                        )
                        R(
                            nil,
                            896,
                            584,
                            40,
                            8,
                            "#3a3a46"
                        )
                        R(
                            nil,
                            900,
                            586,
                            32,
                            4,
                            "#7af0ff"
                        )
                        for ____, x in __iterar((__arrL({858, 958}, 2))) do
                            R(
                                nil,
                                x,
                                580,
                                16,
                                24,
                                "#14141a"
                            )
                            P:circ(x + 8, 587, 4, "#5a5a66")
                            P:circ(x + 8, 598, 4, "#5a5a66")
                            P:circ(x + 8, 587, 2, "#2a2a30")
                            P:circ(x + 8, 598, 2, "#2a2a30")
                        end
                        R(
                            nil,
                            870,
                            562,
                            92,
                            12,
                            "#1c1626"
                        )
                        R(
                            nil,
                            870,
                            562,
                            92,
                            2,
                            "#ff3a8a"
                        )
                        txt(
                            nil,
                            P,
                            "BAILE FUNK",
                            916,
                            566,
                            "#ff6ab8"
                        )
                        P.c.globalAlpha = 0.28
                        for ____, ____value in __iterar((__arrL(
                            {
                                __arrL({880, "#ff3a8a"}, 2),
                                __arrL({916, "#3af0ff"}, 2),
                                __arrL({952, "#ffe14a"}, 2)
                            },
                            3
                        ))) do
                            local x = ____value[1]
                            local cor = ____value[2]
                            P.c.fillStyle = cor
                            P.c:beginPath()
                            P.c:moveTo(x, 596)
                            P.c:lineTo(x - 22, 660)
                            P.c:lineTo(x + 22, 660)
                            __call(P.c, "fill")
                        end
                        P.c.globalAlpha = 1
                        do
                            local k = 0
                            while k < 18 do
                                local x = 850 + k * 7.6
                                R(
                                    nil,
                                    x,
                                    606 + math.floor(math.sin(k) * 2 + 0.5),
                                    2,
                                    2,
                                    __get(
                                        __arrL({"#ff3a8a", "#ffe14a", "#3af0ff", "#7af07a"}, 4),
                                        __mod(k, 4)
                                    )
                                )
                                k = k + 1
                            end
                        end
                        R(
                            nil,
                            848,
                            605,
                            136,
                            1,
                            "#5a5a66"
                        )
                        do
                            local k = 0
                            while k < 26 do
                                local x = 856 + __mod(k * 37, 120)
                                local y = 624 + math.floor(k / 6) * 9 + __mod(k, 2) * 3
                                pessoa(
                                    nil,
                                    P,
                                    x,
                                    y,
                                    __get(
                                        __arrL({
                                            "#e8433a",
                                            "#f2c94c",
                                            "#3c8ab0",
                                            "#7af07a",
                                            "#ff6ab8",
                                            "#f2f2ee"
                                        }, 6),
                                        __mod(k, 6)
                                    )
                                )
                                k = k + 1
                            end
                        end
                    end
                },
                "id,nome,sub,caixa,desloc,descricao,desenho"
            ),
            __ord(
                {
                    id = 5,
                    nome = "Favela do Reeis",
                    sub = "Do beco ao rei",
                    caixa = __arrL({800, 0, 224, 196}, 4),
                    descricao = "Becos que sobem, escadas que não acabam, pipa no céu e um nome que todo mundo respeita lá em cima.",
                    desenho = function(____, P)
                        local cores = __arrL(
                            {
                                __arrL({"#f2c4c4", "#c8544a"}, 2),
                                __arrL({"#f2e2a8", "#d0683a"}, 2),
                                __arrL({"#c8dcf0", "#8a8e94"}, 2),
                                __arrL({"#d4ecc8", "#c8544a"}, 2),
                                __arrL({"#e8c8e8", "#d0683a"}, 2),
                                __arrL({"#f0d0a0", "#8a8e94"}, 2),
                                __arrL({"#c8e8e0", "#c8544a"}, 2)
                            },
                            7
                        )
                        local i = 0
                        for ____, ____value in __iterar((__arrL(
                            {
                                __arrL({132, 812, 1012}, 3),
                                __arrL({84, 860, 1012}, 3),
                                __arrL({36, 920, 1012}, 3)
                            },
                            3
                        ))) do
                            local y0 = ____value[1]
                            local x0 = ____value[2]
                            local x1 = ____value[3]
                            do
                                local x = x0
                                while x < x1 - 30 do
                                    local ____get_36 = __get
                                    local ____mod_35 = __mod
                                    local ____i_34 = i
                                    i = ____i_34 + 1
                                    local par, tel = table.unpack(
                                        ____get_36(
                                            cores,
                                            ____mod_35(
                                                ____i_34,
                                                __len(cores)
                                            )
                                        ),
                                        1,
                                        2
                                    )
                                    P:casa(
                                        x,
                                        y0 - __mod(i, 2) * 4,
                                        32,
                                        34,
                                        {
                                            telhado = tel,
                                            parede = par,
                                            madeira = false,
                                            paredeH = 16,
                                            janelas = __arrL({4}, 1),
                                            porta = 18
                                        }
                                    )
                                    x = x + 36
                                end
                            end
                        end
                        escada(
                            nil,
                            P,
                            830,
                            152,
                            10
                        )
                        escada(
                            nil,
                            P,
                            880,
                            102,
                            10
                        )
                        escada(
                            nil,
                            P,
                            940,
                            54,
                            10
                        )
                        for ____, ____value in __iterar((__arrL(
                            {
                                __arrL({822, 120}, 2),
                                __arrL({906, 72}, 2),
                                __arrL({966, 26}, 2),
                                __arrL({1000, 120}, 2)
                            },
                            4
                        ))) do
                            local x = ____value[1]
                            local y = ____value[2]
                            P:R(
                                x,
                                y,
                                9,
                                7,
                                "#3c6aa8"
                            )
                            P:R(
                                x,
                                y,
                                9,
                                2,
                                "#6a9ad0"
                            )
                        end
                        P:R(
                            990,
                            10,
                            2,
                            26,
                            "#5a5a56"
                        )
                        P:R(
                            992,
                            10,
                            14,
                            9,
                            "#e8433a"
                        )
                    end
                },
                "id,nome,sub,caixa,descricao,desenho"
            ),
            __ord(
                {
                    id = 40,
                    nome = "Oficina do Lucas",
                    sub = "Garagem e ferramentas",
                    caixa = __arrL({222, 210, 82, 72}, 4),
                    cam = 200,
                    descricao = "Onde o carro a gás do seu pai nasceu. O Tio Juca perdeu as ferramentas nas prateleiras e o gato da oficina não ajuda.",
                    desenho = function()
                    end
                },
                "id,nome,sub,caixa,cam,descricao,desenho"
            ),
            __ord(
                {
                    id = 41,
                    nome = "Lanchonete do Zito",
                    sub = "Coxinha, pastel e suco de cacau",
                    caixa = __arrL({428, 566, 96, 70}, 4),
                    cam = 500,
                    descricao = "Coxinha quentinha, acarajé e suco de cacau da roça. Herói de Itabuna come de graça e sai com a vida e o gás cheios.",
                    desenho = function()
                    end
                },
                "id,nome,sub,caixa,cam,descricao,desenho"
            ),
            __ord(
                {
                    id = 42,
                    nome = "Açude da Roça",
                    sub = "Píer, capivaras e pescaria",
                    caixa = __arrL({172, 430, 92, 56}, 4),
                    cam = 900,
                    descricao = "Água parada, capivara folgada, fogueira acesa e o Seu Vagner no píer, esperando alguém com paciência para pescar.",
                    desenho = function()
                    end
                },
                "id,nome,sub,caixa,cam,descricao,desenho"
            )
        },
        15
    )
    local RIO1 = __arrL({}, 0)
    local TR1 = nil
    local RUAS1 = {}
    local MAPA1 = __ord(
        {
            chave = "itabuna2d",
            titulo = "CARRO A GÁS · MAPA DE ITABUNA",
            subtitulo = "Escolha um lugar. O carro do seu pai voa até lá.",
            lajotas = __arrL({64, 44}, 2),
            voa = true,
            ilha = {margem = 300},
            relevo = true,
            terreno = function(____, T)
                T:poli(
                    __arrL(
                        {
                            __arrL({51.2, -1.5}, 2),
                            __arrL({51.6, 3.8}, 2),
                            __arrL({51, 8.2}, 2),
                            __arrL({51.4, 10.8}, 2),
                            __arrL({55, 10.5}, 2),
                            __arrL({59.5, 11}, 2),
                            __arrL({65, 10.5}, 2),
                            __arrL({65, -1.5}, 2)
                        },
                        8
                    ),
                    {nivel = 2}
                )
                T:poli(
                    __arrL(
                        {
                            __arrL({52.9, -1.5}, 2),
                            __arrL({53.5, 3.5}, 2),
                            __arrL({53.1, 7.3}, 2),
                            __arrL({57, 7.6}, 2),
                            __arrL({61, 7.1}, 2),
                            __arrL({65, 7.5}, 2),
                            __arrL({65, -1.5}, 2)
                        },
                        7
                    ),
                    {nivel = 3}
                )
                T:poli(
                    __arrL(
                        {
                            __arrL({57.3, -1.5}, 2),
                            __arrL({57.7, 2.5}, 2),
                            __arrL({58.6, 4.4}, 2),
                            __arrL({62, 4.1}, 2),
                            __arrL({65, 4.6}, 2),
                            __arrL({65, -1.5}, 2)
                        },
                        6
                    ),
                    {nivel = 4}
                )
                T:poli(
                    __arrL(
                        {
                            __arrL({-1.5, 35.6}, 2),
                            __arrL({6, 35}, 2),
                            __arrL({12, 36.6}, 2),
                            __arrL({17.2, 35.8}, 2),
                            __arrL({18.6, 40}, 2),
                            __arrL({17.4, 45.5}, 2),
                            __arrL({-1.5, 45.5}, 2)
                        },
                        7
                    ),
                    {nivel = 2, tipo = "mata"}
                )
                T:poli(
                    __arrL(
                        {
                            __arrL({-1.5, -1.5}, 2),
                            __arrL({19, -1.5}, 2),
                            __arrL({18.4, 2.4}, 2),
                            __arrL({11, 3.1}, 2),
                            __arrL({4, 2.2}, 2),
                            __arrL({-1.5, 3.4}, 2)
                        },
                        6
                    ),
                    {tipo = "mata"}
                )
                T:poli(
                    __arrL(
                        {
                            __arrL({0.4, 15.4}, 2),
                            __arrL({5, 14.8}, 2),
                            __arrL({5.8, 19.2}, 2),
                            __arrL({5.2, 24.6}, 2),
                            __arrL({0.4, 25}, 2)
                        },
                        5
                    ),
                    {tipo = "trigo"}
                )
                T:poli(
                    __arrL(
                        {
                            __arrL({1, 26.4}, 2),
                            __arrL({6.6, 26}, 2),
                            __arrL({7.2, 30.6}, 2),
                            __arrL({1.4, 31}, 2)
                        },
                        4
                    ),
                    {tipo = "plantacao"}
                )
                T:oval(
                    13.6,
                    28.6,
                    2.6,
                    1.5,
                    {nivel = 0}
                )
                T:retR(
                    4,
                    4,
                    12,
                    8,
                    0.8,
                    {tipo = "campo"}
                )
                T:curva(
                    __arrL(
                        {
                            __arrL({20, 3}, 2),
                            __arrL({19.8, 5}, 2),
                            __arrL({22.6, 11}, 2),
                            __arrL({21.4, 15}, 2)
                        },
                        4
                    ),
                    6.4,
                    {tipo = "areia"}
                )
                T:curva(
                    __arrL(
                        {
                            __arrL({22.2, 28}, 2),
                            __arrL({21.8, 30}, 2),
                            __arrL({24.6, 36}, 2),
                            __arrL({23.6, 42}, 2)
                        },
                        4
                    ),
                    6.4,
                    {tipo = "areia"}
                )
                RIO1 = T:curva(
                    __arrL(
                        {
                            __arrL({21.6, -1.5}, 2),
                            __arrL({19.8, 5}, 2),
                            __arrL({22.6, 11}, 2),
                            __arrL({21, 17}, 2),
                            __arrL({23.5, 24}, 2),
                            __arrL({21.8, 30}, 2),
                            __arrL({24.6, 36}, 2),
                            __arrL({23.4, 45.5}, 2)
                        },
                        8
                    ),
                    4,
                    {nivel = 0}
                )
                T:curva(
                    __arrL(
                        {
                            __arrL({20.5, 19.75}, 2),
                            __arrL({16, 19.2}, 2),
                            __arrL({12.5, 20.4}, 2),
                            __arrL({10.2, 18.4}, 2),
                            __arrL({9.6, 14.6}, 2),
                            __arrL({10, 12.2}, 2)
                        },
                        6
                    ),
                    1.6,
                    {tipo = "chao"}
                )
                T:curva(
                    __arrL(
                        {
                            __arrL({12.5, 20.4}, 2),
                            __arrL({12.6, 23.4}, 2),
                            __arrL({10.6, 25.6}, 2),
                            __arrL({8.6, 25.6}, 2)
                        },
                        4
                    ),
                    1.4,
                    {tipo = "chao"}
                )
                T:curva(
                    __arrL(
                        {
                            __arrL({20.5, 33.9}, 2),
                            __arrL({16, 34.6}, 2),
                            __arrL({12, 33.2}, 2),
                            __arrL({8.6, 34.6}, 2),
                            __arrL({6.6, 37.6}, 2),
                            __arrL({5, 41}, 2),
                            __arrL({4, 45.5}, 2)
                        },
                        7
                    ),
                    1.5,
                    {tipo = "chao"}
                )
                RUAS1.n = T:curva(
                    __arrL(
                        {
                            __arrL({19.6, 19.75}, 2),
                            __arrL({24, 19.1}, 2),
                            __arrL({28, 19.9}, 2),
                            __arrL({33, 20.6}, 2),
                            __arrL({38, 19.6}, 2),
                            __arrL({42, 19.2}, 2),
                            __arrL({47, 20.1}, 2),
                            __arrL({52, 20.6}, 2),
                            __arrL({57, 19.4}, 2),
                            __arrL({61, 19.9}, 2),
                            __arrL({65.5, 20.4}, 2)
                        },
                        11
                    ),
                    1.9,
                    {tipo = "pedra"}
                )
                RUAS1.s = T:curva(
                    __arrL(
                        {
                            __arrL({19.6, 33.9}, 2),
                            __arrL({25, 34.6}, 2),
                            __arrL({30, 33.4}, 2),
                            __arrL({35, 33.9}, 2),
                            __arrL({40, 34.6}, 2),
                            __arrL({45, 33.6}, 2),
                            __arrL({50, 34}, 2),
                            __arrL({56, 34.5}, 2),
                            __arrL({60, 33.6}, 2),
                            __arrL({65.5, 34}, 2)
                        },
                        10
                    ),
                    1.9,
                    {tipo = "pedra"}
                )
                RUAS1.a = T:curva(
                    __arrL(
                        {
                            __arrL({41.8, -1.5}, 2),
                            __arrL({41.6, 4}, 2),
                            __arrL({40.2, 9.5}, 2),
                            __arrL({39.2, 13}, 2),
                            __arrL({40.4, 17}, 2),
                            __arrL({40.6, 20}, 2),
                            __arrL({39.4, 24.5}, 2),
                            __arrL({39.2, 28}, 2),
                            __arrL({40.4, 32}, 2),
                            __arrL({41, 37}, 2),
                            __arrL({40.1, 41.5}, 2),
                            __arrL({41.2, 45.5}, 2)
                        },
                        12
                    ),
                    1.6,
                    {tipo = "pedra"}
                )
                RUAS1.b = T:curva(
                    __arrL(
                        {
                            __arrL({52.4, 10.4}, 2),
                            __arrL({51.2, 14}, 2),
                            __arrL({50.8, 17.5}, 2),
                            __arrL({52, 20}, 2),
                            __arrL({52.3, 23}, 2),
                            __arrL({51.2, 27}, 2),
                            __arrL({50.6, 30}, 2),
                            __arrL({51.6, 34}, 2),
                            __arrL({52.1, 37}, 2),
                            __arrL({51.4, 41}, 2),
                            __arrL({52, 45.5}, 2)
                        },
                        11
                    ),
                    1.6,
                    {tipo = "pedra"}
                )
                RUAS1.c = T:curva(
                    __arrL(
                        {
                            __arrL({26, 19.6}, 2),
                            __arrL({26.4, 15}, 2),
                            __arrL({26, 12.2}, 2),
                            __arrL({27.4, 10.4}, 2)
                        },
                        4
                    ),
                    1.6,
                    {tipo = "pedra"}
                )
                T:poli(
                    __arrL(
                        {
                            __arrL({26.6, 9.4}, 2),
                            __arrL({30, 8.7}, 2),
                            __arrL({36, 8.8}, 2),
                            __arrL({38.2, 9.6}, 2),
                            __arrL({37, 11}, 2),
                            __arrL({31, 11.3}, 2),
                            __arrL({27.6, 10.9}, 2)
                        },
                        7
                    ),
                    {tipo = "pedra"}
                )
                T:poli(
                    __arrL(
                        {
                            __arrL({43.4, 4.4}, 2),
                            __arrL({45.5, 3.4}, 2),
                            __arrL({48.8, 3.6}, 2),
                            __arrL({50.2, 5.2}, 2),
                            __arrL({50, 8.8}, 2),
                            __arrL({48.4, 10.2}, 2),
                            __arrL({44.6, 10}, 2),
                            __arrL({43.2, 8}, 2)
                        },
                        8
                    ),
                    {tipo = "pedra"}
                )
                T:oval(
                    33.6,
                    28.3,
                    5.6,
                    4.4,
                    {tipo = "pedra"}
                )
                T:curva(
                    __arrL(
                        {
                            __arrL({47.6, 10.4}, 2),
                            __arrL({48.4, 13}, 2),
                            __arrL({47.4, 16}, 2),
                            __arrL({48.2, 18.6}, 2)
                        },
                        4
                    ),
                    1.1,
                    {tipo = "chao"}
                )
                T:curva(
                    __arrL(
                        {
                            __arrL({30, 32.4}, 2),
                            __arrL({27.6, 30}, 2),
                            __arrL({25.6, 27}, 2),
                            __arrL({26.2, 23.5}, 2),
                            __arrL({25.2, 21}, 2)
                        },
                        5
                    ),
                    1,
                    {tipo = "chao"}
                )
                T:curva(
                    __arrL(
                        {
                            __arrL({37.6, 25.2}, 2),
                            __arrL({38.6, 23.4}, 2)
                        },
                        2
                    ),
                    1,
                    {tipo = "chao"}
                )
                T:retR(
                    42.5,
                    21.8,
                    7.4,
                    5.4,
                    0.3,
                    {tipo = "quadra"}
                )
                T:retR(
                    52.9,
                    41.8,
                    10.8,
                    3,
                    0.6,
                    {tipo = "asfalto"}
                )
            end,
            objetos = function(____, add, Tr)
                TR1 = Tr
                local caixas = caixasDe(nil, C1)
                local lote = Lote(nil, Tr, caixas)
                local function R0(____, f)
                    return f
                end
                for ____, yy in __iterar((__arrL({19.75 * TS, 33.9 * TS}, 2))) do
                    local x = cruza(nil, RIO1, yy)
                    lote:marca(x - 48, yy - 20, 96, 40)
                    add(
                        nil,
                        yy + 14,
                        function(____, P) return ponte(
                            nil,
                            P,
                            x - 46,
                            yy - 14,
                            92,
                            28
                        ) end
                    )
                end
                local function ref(____, x, y, w, h, f)
                    lote:marca(x - 4, y - 4, w + 8, h + 8)
                    add(
                        nil,
                        __add(y, h),
                        f
                    )
                end
                ref(
                    nil,
                    232,
                    222,
                    60,
                    52,
                    function(____, P)
                        local R = P.R
                        local x = 238
                        local y = 236
                        P:sombra(
                            x + 26,
                            y + 32,
                            32,
                            5,
                            0.25
                        )
                        R(
                            nil,
                            x,
                            y,
                            50,
                            30,
                            "#a87a54"
                        )
                        do
                            local k = 0
                            while k < 50 do
                                R(
                                    nil,
                                    x + k,
                                    y,
                                    1,
                                    30,
                                    "#8a5e3a"
                                )
                                k = k + 5
                            end
                        end
                        R(
                            nil,
                            x + 4,
                            y + 6,
                            42,
                            24,
                            "#3a2a1e"
                        )
                        R(
                            nil,
                            x + 8,
                            y + 18,
                            30,
                            9,
                            "#a85a3a"
                        )
                        R(
                            nil,
                            x + 14,
                            y + 13,
                            16,
                            6,
                            "#94503a"
                        )
                        R(
                            nil,
                            x + 15,
                            y + 14,
                            6,
                            4,
                            "#7ab0c8"
                        )
                        R(
                            nil,
                            x + 10,
                            y + 26,
                            5,
                            3,
                            "#1c1c1c"
                        )
                        R(
                            nil,
                            x + 31,
                            y + 26,
                            5,
                            3,
                            "#1c1c1c"
                        )
                        R(
                            nil,
                            x + 38,
                            y + 22,
                            3,
                            3,
                            "#fff2b0"
                        )
                        R(
                            nil,
                            x - 4,
                            y - 9,
                            58,
                            11,
                            "#8a8e94"
                        )
                        do
                            local k = 0
                            while k < 58 do
                                R(
                                    nil,
                                    x - 4 + k,
                                    y - 9,
                                    1,
                                    11,
                                    "#6a6e74"
                                )
                                k = k + 3
                            end
                        end
                        R(
                            nil,
                            x - 4,
                            y + 1,
                            58,
                            1,
                            "#4a4e54"
                        )
                        R(
                            nil,
                            x + 10,
                            y - 18,
                            30,
                            9,
                            "#5a3820"
                        )
                        txt(
                            nil,
                            P,
                            "OFICINA",
                            x + 25,
                            y - 16,
                            "#f2e2b8"
                        )
                        do
                            local k = 0
                            while k < 3 do
                                P:circ(
                                    x + 58,
                                    y + 26 - k * 5,
                                    5,
                                    "#1c1c1c",
                                    3
                                )
                                P:circ(
                                    x + 58,
                                    y + 26 - k * 5,
                                    2,
                                    "#5a5e62",
                                    1
                                )
                                k = k + 1
                            end
                        end
                        R(
                            nil,
                            x - 9,
                            y + 14,
                            7,
                            13,
                            "#3c6aa8"
                        )
                        R(
                            nil,
                            x - 9,
                            y + 14,
                            7,
                            2,
                            "#5a8ac8"
                        )
                        R(
                            nil,
                            x + 6,
                            y + 34,
                            38,
                            3,
                            "#7a4a2a"
                        )
                        R(
                            nil,
                            x + 8,
                            y + 37,
                            2,
                            5,
                            "#5a3820"
                        )
                        R(
                            nil,
                            x + 40,
                            y + 37,
                            2,
                            5,
                            "#5a3820"
                        )
                        P:circ(
                            x + 13,
                            y + 31,
                            4,
                            "#8a9096",
                            3
                        )
                        do
                            local a = 0
                            while a < 4 do
                                R(
                                    nil,
                                    x + 13 + math.cos(a * 1.57) * 2,
                                    y + 31 + math.sin(a * 1.57) * 2,
                                    2,
                                    1,
                                    "#dde0e3"
                                )
                                a = a + 1
                            end
                        end
                        R(
                            nil,
                            x + 21,
                            y + 30,
                            9,
                            2,
                            "#9aa0a6"
                        )
                        R(
                            nil,
                            x + 28,
                            y + 26,
                            2,
                            6,
                            "#9aa0a6"
                        )
                        R(
                            nil,
                            x + 21,
                            y + 30,
                            9,
                            1,
                            "#dde0e3"
                        )
                        R(
                            nil,
                            x + 35,
                            y + 28,
                            2,
                            5,
                            "#f2f2ee"
                        )
                        R(
                            nil,
                            x + 34,
                            y + 27,
                            4,
                            2,
                            "#a8643a"
                        )
                        R(
                            nil,
                            x + 35,
                            y + 33,
                            2,
                            1,
                            "#9aa0a6"
                        )
                    end
                )
                ref(
                    nil,
                    268,
                    172,
                    50,
                    50,
                    function(____, P)
                        P:arvore(
                            282,
                            214,
                            1.4,
                            "verde",
                            7
                        )
                        P:R(
                            292,
                            196,
                            20,
                            3,
                            "#5a3820"
                        )
                        P:R(
                            292,
                            196,
                            20,
                            1,
                            "#8a5a36"
                        )
                    end
                )
                ref(
                    nil,
                    40,
                    330,
                    24,
                    30,
                    function(____, P)
                        local R = P.R
                        local x = 52
                        local y = 358
                        P:sombra(x + 2, y, 7, 2)
                        R(
                            nil,
                            x,
                            y - 24,
                            2,
                            24,
                            "#7a5228"
                        )
                        R(
                            nil,
                            x - 9,
                            y - 18,
                            20,
                            2,
                            "#7a5228"
                        )
                        R(
                            nil,
                            x - 5,
                            y - 18,
                            12,
                            9,
                            "#c8544a"
                        )
                        R(
                            nil,
                            x - 5,
                            y - 14,
                            12,
                            1,
                            "#a8443a"
                        )
                        R(
                            nil,
                            x - 3,
                            y - 24,
                            8,
                            6,
                            "#e8c87a"
                        )
                        R(
                            nil,
                            x - 5,
                            y - 26,
                            12,
                            3,
                            "#d8b04a"
                        )
                        R(
                            nil,
                            x - 2,
                            y - 22,
                            1,
                            1,
                            "#2a2a2a"
                        )
                        R(
                            nil,
                            x + 2,
                            y - 22,
                            1,
                            1,
                            "#2a2a2a"
                        )
                        R(
                            nil,
                            x - 10,
                            y - 17,
                            2,
                            3,
                            "#e8c87a"
                        )
                        R(
                            nil,
                            x + 10,
                            y - 17,
                            2,
                            3,
                            "#e8c87a"
                        )
                    end
                )
                ref(
                    nil,
                    130,
                    452,
                    44,
                    26,
                    function(____, P)
                        local R = P.R
                        local x = 134
                        local y = 474
                        P:sombra(x + 20, y, 22, 3)
                        R(
                            nil,
                            x,
                            y - 12,
                            40,
                            12,
                            "#a87a54"
                        )
                        R(
                            nil,
                            x,
                            y - 12,
                            40,
                            2,
                            "#c89a6a"
                        )
                        do
                            local k = 0
                            while k < 40 do
                                R(
                                    nil,
                                    x + k,
                                    y - 10,
                                    1,
                                    10,
                                    "#7a5230"
                                )
                                k = k + 10
                            end
                        end
                        R(
                            nil,
                            x + 3,
                            y - 17,
                            18,
                            4,
                            "#f2c94c"
                        )
                        R(
                            nil,
                            x + 3,
                            y - 17,
                            18,
                            1,
                            "#ffe39a"
                        )
                        R(
                            nil,
                            x + 21,
                            y - 17,
                            4,
                            4,
                            "#e8c8a0"
                        )
                        R(
                            nil,
                            x + 25,
                            y - 16,
                            2,
                            2,
                            "#2a2a2a"
                        )
                        R(
                            nil,
                            x + 1,
                            y - 17,
                            3,
                            4,
                            "#e86a8a"
                        )
                        R(
                            nil,
                            x + 4,
                            y - 17,
                            1,
                            4,
                            "#c8ccd0"
                        )
                        R(
                            nil,
                            x + 28,
                            y - 18,
                            9,
                            5,
                            "#f29ab0"
                        )
                        R(
                            nil,
                            x + 28,
                            y - 18,
                            9,
                            1,
                            "#ffd0de"
                        )
                        R(
                            nil,
                            x + 28,
                            y - 15,
                            9,
                            2,
                            "#3c6aa8"
                        )
                        P.c.strokeStyle = "#a8aeb4"
                        P.c.lineWidth = 1
                        P.c:strokeRect(x + 12.5, y - 23.5, 8, 4)
                        P.c:strokeRect(x + 14.5, y - 22.5, 4, 2)
                    end
                )
                ref(
                    nil,
                    176,
                    588,
                    70,
                    40,
                    function(____, P)
                        local R = P.R
                        local x = 182
                        local y = 596
                        P:sombra(x + 30, y + 26, 34, 4)
                        R(
                            nil,
                            x,
                            y,
                            60,
                            24,
                            "#8a5a36"
                        )
                        do
                            local k = 0
                            while k < 140 do
                                R(
                                    nil,
                                    x + 2 + h(nil, k, 1) * 55,
                                    y + 2 + h(nil, k, 2) * 20,
                                    2,
                                    1,
                                    if __gt(
                                        h(nil, k, 3),
                                        0.5
                                    ) then "#5a3420" else "#7a4a2a"
                                )
                                k = k + 1
                            end
                        end
                        R(
                            nil,
                            x - 2,
                            y + 24,
                            64,
                            2,
                            "#5a3820"
                        )
                        R(
                            nil,
                            x + 34,
                            y - 6,
                            34,
                            8,
                            "#9a5a3a"
                        )
                        do
                            local k = 0
                            while k < 34 do
                                R(
                                    nil,
                                    x + 34 + k,
                                    y - 6,
                                    1,
                                    8,
                                    "#7a4228"
                                )
                                k = k + 4
                            end
                        end
                        R(
                            nil,
                            x + 34,
                            y + 2,
                            34,
                            1,
                            "#5a3420"
                        )
                        for ____, px in __iterar((__arrL({x - 2, x + 60}, 2))) do
                            R(
                                nil,
                                px,
                                y - 4,
                                2,
                                30,
                                "#6a4228"
                            )
                        end
                        R(
                            nil,
                            x + 64,
                            y + 2,
                            2,
                            22,
                            "#6a4228"
                        )
                    end
                )
                ref(
                    nil,
                    244,
                    280,
                    40,
                    18,
                    function(____, P)
                        local R = P.R
                        local x = 246
                        local y = 296
                        R(
                            nil,
                            x + 4,
                            y - 8,
                            2,
                            8,
                            "#5a3820"
                        )
                        R(
                            nil,
                            x + 30,
                            y - 8,
                            2,
                            8,
                            "#5a3820"
                        )
                        R(
                            nil,
                            x - 1,
                            y - 20,
                            38,
                            13,
                            "#5a3820"
                        )
                        R(
                            nil,
                            x,
                            y - 19,
                            36,
                            11,
                            "#a8643a"
                        )
                        R(
                            nil,
                            x,
                            y - 19,
                            36,
                            1,
                            "#d8a070"
                        )
                        txt(
                            nil,
                            P,
                            "ITABUNA",
                            x + 18,
                            y - 16,
                            "#fff2c8",
                            {sombra = "#5a3820"}
                        )
                    end
                )
                for ____, ____value in __iterar((__arrL(
                    {
                        __arrL({404, 58}, 2),
                        __arrL({398, 98}, 2),
                        __arrL({406, 136}, 2)
                    },
                    3
                ))) do
                    local x = ____value[1]
                    local y = ____value[2]
                    ref(
                        nil,
                        x - 8,
                        y - 22,
                        16,
                        22,
                        function(____, P) return P:mamoeiro(x, y) end
                    )
                end
                ref(
                    nil,
                    546,
                    156,
                    30,
                    14,
                    function(____, P)
                        P:banco(552, 168)
                        for ____, ____value in __iterar((__arrL(
                            {
                                __arrL({0, "#3c6aa8"}, 2),
                                __arrL({1, "#c43c3a"}, 2),
                                __arrL({2, "#3c8a5a"}, 2)
                            },
                            3
                        ))) do
                            local k = ____value[1]
                            local cor = ____value[2]
                            P:R(
                                554 + k * 4,
                                159 - k,
                                6,
                                4,
                                cor
                            )
                            P:R(
                                554 + k * 4,
                                159 - k,
                                6,
                                1,
                                "#ffffff88"
                            )
                        end
                    end
                )
                ref(
                    nil,
                    668,
                    172,
                    24,
                    18,
                    function(____, P) return P:arbusto(680, 188, 3) end
                )
                ref(
                    nil,
                    676,
                    440,
                    108,
                    14,
                    function(____, P)
                        local R = P.R
                        do
                            local k = 0
                            while k < 3 do
                                R(
                                    nil,
                                    682 + k * 3,
                                    440 + k * 4,
                                    96 - k * 6,
                                    4,
                                    if __t(__mod(k, 2)) then "#8a9096" else "#a8aeb4"
                                )
                                R(
                                    nil,
                                    682 + k * 3,
                                    440 + k * 4,
                                    96 - k * 6,
                                    1,
                                    "#dde0e3"
                                )
                                k = k + 1
                            end
                        end
                    end
                )
                ref(
                    nil,
                    744,
                    462,
                    30,
                    22,
                    function(____, P)
                        local R = P.R
                        local x = 748
                        local y = 482
                        P:sombra(x + 10, y, 12, 2)
                        R(
                            nil,
                            x,
                            y - 8,
                            22,
                            3,
                            "#a8643a"
                        )
                        R(
                            nil,
                            x + 2,
                            y - 5,
                            2,
                            5,
                            "#5a3820"
                        )
                        R(
                            nil,
                            x + 18,
                            y - 5,
                            2,
                            5,
                            "#5a3820"
                        )
                        R(
                            nil,
                            x + 5,
                            y - 15,
                            12,
                            7,
                            "#7a4a2a"
                        )
                        R(
                            nil,
                            x + 5,
                            y - 15,
                            12,
                            2,
                            "#f29ab0"
                        )
                        R(
                            nil,
                            x + 6,
                            y - 13,
                            1,
                            2,
                            "#f29ab0"
                        )
                        R(
                            nil,
                            x + 11,
                            y - 13,
                            1,
                            3,
                            "#f29ab0"
                        )
                        R(
                            nil,
                            x + 10,
                            y - 19,
                            1,
                            4,
                            "#f2f2ee"
                        )
                    end
                )
                ref(
                    nil,
                    578,
                    446,
                    22,
                    22,
                    function(____, P)
                        local R = P.R
                        local x = 584
                        local y = 466
                        P:sombra(x + 6, y, 10, 2)
                        R(
                            nil,
                            x,
                            y - 10,
                            14,
                            9,
                            "#f2f2ee"
                        )
                        R(
                            nil,
                            x,
                            y - 10,
                            14,
                            2,
                            "#e86a8a"
                        )
                        R(
                            nil,
                            x + 1,
                            y - 1,
                            3,
                            2,
                            "#1c1c1c"
                        )
                        R(
                            nil,
                            x + 10,
                            y - 1,
                            3,
                            2,
                            "#1c1c1c"
                        )
                        R(
                            nil,
                            x + 6,
                            y - 22,
                            1,
                            12,
                            "#8a8e94"
                        )
                    end
                )
                ref(
                    nil,
                    470,
                    448,
                    26,
                    18,
                    function(____, P)
                        local R = P.R
                        local x = 476
                        local y = 462
                        R(
                            nil,
                            x,
                            y - 7,
                            14,
                            4,
                            "#7a4a2a"
                        )
                        R(
                            nil,
                            x + 6,
                            y - 3,
                            2,
                            3,
                            "#5a3820"
                        )
                        do
                            local k = 0
                            while k < 4 do
                                R(
                                    nil,
                                    x + 2 + k * 3,
                                    y - 8,
                                    2,
                                    1,
                                    "#f6f6f0"
                                )
                                k = k + 1
                            end
                        end
                        pecas:pessoaG(
                            P,
                            x - 4,
                            y,
                            "#3c8a5a",
                            "#c99068",
                            "#b8b2a6"
                        )
                        pecas:pessoaG(
                            P,
                            x + 18,
                            y,
                            "#c8544a",
                            "#8a5a3a",
                            "#e0e0e0"
                        )
                    end
                )
                ref(
                    nil,
                    436,
                    574,
                    80,
                    56,
                    function(____, P)
                        P:casa(
                            442,
                            578,
                            58,
                            46,
                            {
                                telhado = "#c8543a",
                                parede = "#f2e2a8",
                                madeira = false,
                                janelas = __arrL({6}, 1),
                                porta = 34
                            }
                        )
                        P:R(
                            446,
                            598,
                            28,
                            8,
                            "#e8433a"
                        )
                        txt(
                            nil,
                            P,
                            "LANCHE",
                            460,
                            600,
                            "#fff6dc"
                        )
                        local R = P.R
                        R(
                            nil,
                            504,
                            602,
                            12,
                            22,
                            "#2a2a4a"
                        )
                        R(
                            nil,
                            504,
                            602,
                            12,
                            2,
                            "#5a5a8a"
                        )
                        R(
                            nil,
                            506,
                            606,
                            8,
                            6,
                            "#1c2a3a"
                        )
                        R(
                            nil,
                            506,
                            615,
                            8,
                            2,
                            "#5a5a8a"
                        )
                        R(
                            nil,
                            507,
                            618,
                            2,
                            2,
                            "#e8433a"
                        )
                        R(
                            nil,
                            511,
                            618,
                            2,
                            2,
                            "#f2c94c"
                        )
                    end
                )
                ref(
                    nil,
                    978,
                    226,
                    40,
                    64,
                    function(____, P)
                        local R = P.R
                        R(
                            nil,
                            992,
                            280,
                            24,
                            2,
                            "#3a3f48"
                        )
                        for ____, x in __iterar((__arrL({990, 1016}, 2))) do
                            R(
                                nil,
                                x,
                                276,
                                3,
                                8,
                                "#2a2a2a"
                            )
                        end
                        R(
                            nil,
                            990,
                            279,
                            29,
                            2,
                            "#8a9096"
                        )
                        R(
                            nil,
                            984,
                            286,
                            6,
                            3,
                            "#2a2a2a"
                        )
                        R(
                            nil,
                            1000,
                            286,
                            6,
                            3,
                            "#2a2a2a"
                        )
                        R(
                            nil,
                            1004,
                            236,
                            2,
                            30,
                            "#5a5e62"
                        )
                        R(
                            nil,
                            1000,
                            228,
                            10,
                            10,
                            "#1c1c1c"
                        )
                    end
                )
                ref(
                    nil,
                    704,
                    214,
                    44,
                    34,
                    function(____, P)
                        local R = P.R
                        local x = 708
                        local y = 244
                        P:sombra(x + 18, y, 20, 3)
                        R(
                            nil,
                            x,
                            y - 10,
                            36,
                            10,
                            "#8a5a36"
                        )
                        R(
                            nil,
                            x + 2,
                            y - 26,
                            2,
                            16,
                            "#6a4228"
                        )
                        R(
                            nil,
                            x + 32,
                            y - 26,
                            2,
                            16,
                            "#6a4228"
                        )
                        do
                            local k = 0
                            while k < 40 do
                                R(
                                    nil,
                                    x - 2 + k,
                                    y - 30,
                                    8,
                                    6,
                                    if __t(__mod(k, 16)) then "#f2f2ee" else "#3c8a5a"
                                )
                                k = k + 8
                            end
                        end
                        do
                            local k = 0
                            while k < 6 do
                                P:circ(
                                    x + 6 + __mod(k, 3) * 11,
                                    y - 12 - math.floor(k / 3) * 3,
                                    4,
                                    "#b89a6a",
                                    3
                                )
                                k = k + 1
                            end
                        end
                        do
                            local k = 0
                            while k < 5 do
                                R(
                                    nil,
                                    x + 4 + k * 6,
                                    y - 15,
                                    3,
                                    2,
                                    "#e8c87a"
                                )
                                k = k + 1
                            end
                        end
                        R(
                            nil,
                            x + 6,
                            y - 6,
                            24,
                            5,
                            "#f2e2b8"
                        )
                        txt(
                            nil,
                            P,
                            "BATATA",
                            x + 18,
                            y - 6,
                            "#7a2a1a"
                        )
                    end
                )
                local cores = __arrL(
                    {
                        __arrL({"#f2e2c0", "#c8543a"}, 2),
                        __arrL({"#c8dcf0", "#8a4a3a"}, 2),
                        __arrL({"#f2c4c4", "#a8443a"}, 2),
                        __arrL({"#d4ecc8", "#c8644a"}, 2),
                        __arrL({"#f2e2a8", "#9a4a34"}, 2),
                        __arrL({"#e8c8e8", "#b8644a"}, 2),
                        __arrL({"#f0d0a0", "#8a8e94"}, 2)
                    },
                    7
                )
                do
                    local i = 0
                    while i < 3000 do
                        local w = 26 + math.floor(h(nil, i, 41) * 3) * 6
                        local hh = 30 + math.floor(h(nil, i, 42) * 2) * 6
                        local x = 430 + h(nil, i, 43) * 560
                        local y = 6 + h(nil, i, 44) * 660
                        if __gt(
                            Tr:nivelEm(x, y + hh),
                            1
                        ) then
                            continue
                        end
                        if not __t(lote:area(x - 4, y - 4, w + 10, hh + 10)) then
                            continue
                        end
                        local par, tel = table.unpack(
                            __get(
                                cores,
                                __mod(
                                    i,
                                    __len(cores)
                                )
                            ),
                            1,
                            2
                        )
                        add(
                            nil,
                            y + hh,
                            function(____, P) return P:casa(
                                x,
                                y,
                                w,
                                hh,
                                {
                                    telhado = tel,
                                    parede = par,
                                    madeira = __mod(i, 3) == 0,
                                    janelas = if w > 34 then __arrL({4, w - 10}, 2) else __arrL({4}, 1),
                                    porta = math.floor(w / 2 + 0.5) - 4,
                                    chamine = __mod(i, 5) == 0
                                }
                            ) end
                        )
                        i = i + 1
                    end
                end
                local areia = tipoEh(nil, Tr, "areia")
                do
                    local i = 0
                    while i < 70 do
                        local x = 280 + h(nil, i, 51) * 180
                        local y = 20 + h(nil, i, 52) * 680
                        if not __t(lote:ponto(x, y, 8, areia)) then
                            continue
                        end
                        local k = h(nil, i, 53)
                        add(
                            nil,
                            y,
                            function(____, P)
                                do
                                    do
                                        do
                                            P:sombra(x + 1, y, 6, 2)
                                            P:R(
                                                x - 5,
                                                y - 5,
                                                10,
                                                5,
                                                "#8a5a3a"
                                            )
                                        end
                                        P:R(
                                            x + 4,
                                            y - 7,
                                            4,
                                            4,
                                            "#7a4a2a"
                                        )
                                    end
                                    P:R(
                                        x - 4,
                                        y - 5,
                                        8,
                                        1,
                                        "#a87a4a"
                                    )
                                end
                                return if __gt(k, 0.6) then P:coqueiro(x, y) else if __gt(k, 0.45) then P:R(
                                    x + 6,
                                    y - 6,
                                    1,
                                    1,
                                    "#1c1c1c"
                                ) else P:pedra(x, y)
                            end
                        )
                        i = i + 1
                    end
                end
                do
                    local i = 0
                    while i < 900 do
                        local x = 4 + h(nil, i, 61) * 1016
                        local y = 8 + h(nil, i, 62) * 694
                        if not __t(lote:ponto(x, y, 8)) then
                            continue
                        end
                        local tp = Tr:tipoEm(x, y)
                        local lvl = Tr:nivelEm(x, y)
                        local k = h(nil, i, 63)
                        if __t(__ge(lvl, 2) and x < 320) then
                            add(
                                nil,
                                y,
                                function(____, P) return P:cacaueiro(x, y, 1, i) end
                            )
                        elseif tp == "mata" then
                            add(
                                nil,
                                y,
                                function(____, P) return P:arvore(
                                    x,
                                    y,
                                    0.9 + k * 0.5,
                                    if __gt(k, 0.5) then "escura" else "verde",
                                    i
                                ) end
                            )
                        elseif x > 420 then
                            if __gt(k, 0.55) then
                                continue
                            end
                            add(
                                nil,
                                y,
                                function(____, P) return if __gt(k, 0.47) then P:arvore(
                                    x,
                                    y,
                                    0.9,
                                    "amarela",
                                    i
                                ) else if __gt(k, 0.4) then P:arvore(
                                    x,
                                    y,
                                    0.9,
                                    "rosa",
                                    i
                                ) else if __gt(k, 0.3) then P:arbusto(x, y, i, "#f2c94c") else P:arvore(
                                    x,
                                    y,
                                    0.8 + k * 0.6,
                                    "verde",
                                    i
                                ) end
                            )
                        else
                            if __gt(k, 0.7) then
                                continue
                            end
                            add(
                                nil,
                                y,
                                function(____, P) return if __gt(k, 0.6) then P:arbusto(x, y, i, "#e86a8a") else if __gt(k, 0.55) then P:pedra(x, y) else P:arvore(
                                    x,
                                    y,
                                    0.85 + k * 0.5,
                                    if __gt(k, 0.3) then "escura" else "verde",
                                    i
                                ) end
                            )
                        end
                        i = i + 1
                    end
                end
                for ____, pl in __iterar((__arrL({RUAS1.n, RUAS1.s, RUAS1.a, RUAS1.b}, 4))) do
                    do
                        local k = 10
                        while __lt(
                            k,
                            __len(pl)
                        ) do
                            local x, y = table.unpack(
                                __get(
                                    faixa(nil, pl, 22, false),
                                    k
                                ),
                                1,
                                2
                            )
                            if __t(lote:ponto(x, y, 4)) then
                                add(
                                    nil,
                                    y,
                                    function(____, P) return P:poste(x - 2, y) end
                                )
                            end
                            k = k + 34
                        end
                    end
                end
            end,
            chao = function(____, P)
                local ____ = P
            end,
            animarChao = function(____, P, t)
                local R = P.R
                local Tr = TR1
                if not __t(Tr) then
                    return
                end
                do
                    local k = 0
                    while k < 14 do
                        local u = __mod(t * 0.18 + k / 14, 1)
                        local x = 4 + u * 100
                        local y = 244 + __mod(k * 37, 150)
                        if Tr:tipoEm(x, y) ~= "trigo" then
                            continue
                        end
                        P.c.globalAlpha = 0.45 * math.sin(u * math.pi)
                        R(
                            nil,
                            x,
                            y,
                            10,
                            1,
                            "#fff4b0"
                        )
                        R(
                            nil,
                            x + 3,
                            y + 1,
                            6,
                            1,
                            "#fff4b0"
                        )
                        P.c.globalAlpha = 1
                        k = k + 1
                    end
                end
                do
                    local k = 0
                    while k < 3 do
                        local a = t * 0.5 + k * 2.1
                        local x = 218 + math.cos(a) * 26
                        local y = 458 + math.sin(a) * 10
                        R(
                            nil,
                            x - 3,
                            y,
                            7,
                            1,
                            "#9fd0f0"
                        )
                        R(
                            nil,
                            x - 2,
                            y - 3,
                            5,
                            3,
                            "#f6f6f0"
                        )
                        R(
                            nil,
                            x + if math.cos(a + 1.6) > 0 then 2 else -3,
                            y - 5,
                            2,
                            2,
                            "#3c8a5a"
                        )
                        R(
                            nil,
                            x + if math.cos(a + 1.6) > 0 then 4 else -4,
                            y - 4,
                            1,
                            1,
                            "#f2a03a"
                        )
                        k = k + 1
                    end
                end
                do
                    local tr = A:trilho(__call(
                        RIO1,
                        "filter",
                        function(____, p) return __gt(
                            __get(p, 1),
                            380
                        ) and __lt(
                            __get(p, 1),
                            640
                        ) end
                    ))
                    local u = (math.sin(t * 0.06) + 1) / 2
                    local p = tr:em(u * 0.999)
                    local x = math.floor(p.x + 0.5)
                    local y = math.floor(p.y + 0.5)
                    R(
                        nil,
                        x - 9,
                        y + 1,
                        19,
                        2,
                        "#3a7ad0"
                    )
                    R(
                        nil,
                        x - 8,
                        y - 2,
                        17,
                        3,
                        "#7a4a2a"
                    )
                    R(
                        nil,
                        x - 8,
                        y - 2,
                        17,
                        1,
                        "#a87a4a"
                    )
                    R(
                        nil,
                        x - 1,
                        y - 9,
                        4,
                        7,
                        "#c8544a"
                    )
                    R(
                        nil,
                        x - 1,
                        y - 12,
                        4,
                        3,
                        "#c99068"
                    )
                    R(
                        nil,
                        x - 2,
                        y - 13,
                        6,
                        1,
                        "#d8b04a"
                    )
                    P.c.strokeStyle = "#5a3820"
                    P.c:beginPath()
                    P.c:moveTo(x + 3, y - 8)
                    P.c:lineTo(x + 14, y - 16)
                    P.c:lineTo(
                        x + 15 + math.sin(t * 2),
                        y - 2
                    )
                    P.c:stroke()
                end
            end,
            animar = function(____, P, t)
                local R = P.R
                do
                    local cx = 82
                    local cy = 306
                    do
                        local k = 0
                        while k < 4 do
                            local a = t * 2 + k * math.pi / 2
                            do
                                local j = 4
                                while j < 20 do
                                    R(
                                        nil,
                                        cx + math.cos(a) * j,
                                        cy + math.sin(a) * j,
                                        2,
                                        2,
                                        if __t(__mod(j, 4)) then "#e8e2d0" else "#c8b48a"
                                    )
                                    j = j + 1
                                end
                            end
                            k = k + 1
                        end
                    end
                    R(
                        nil,
                        cx - 2,
                        cy - 2,
                        5,
                        5,
                        "#6a4a2a"
                    )
                end
                fumaca(
                    nil,
                    P,
                    170,
                    326,
                    t
                )
                fumaca(
                    nil,
                    P,
                    900,
                    200,
                    t + 1
                )
                do
                    local k = 0
                    while k < 6 do
                        local a = t * 3 + k
                        R(
                            nil,
                            540 + math.cos(a) * 3,
                            438 - __mod(t * 20 + k * 4, 12),
                            1,
                            2,
                            "#c8eaff"
                        )
                        k = k + 1
                    end
                end
                naRua(
                    nil,
                    P,
                    t,
                    faixa(nil, RUAS1.n, -5, false),
                    3,
                    __arrL({"#c43c3a", "#f2f2ee", "#3c6aa8"}, 3),
                    26
                )
                naRua(
                    nil,
                    P,
                    t,
                    faixa(nil, RUAS1.n, 5, true),
                    2,
                    __arrL({"#e8c24c", "#3c8a5a"}, 2),
                    24,
                    0.3
                )
                naRua(
                    nil,
                    P,
                    t,
                    faixa(nil, RUAS1.s, -5, false),
                    2,
                    __arrL({"#7a3a8a", "#f2f2ee"}, 2),
                    22,
                    0.5
                )
                naRua(
                    nil,
                    P,
                    t,
                    faixa(nil, RUAS1.s, 5, true),
                    2,
                    __arrL({"#3c6aa8", "#c43c3a"}, 2),
                    25,
                    0.1
                )
                naRua(
                    nil,
                    P,
                    t,
                    RUAS1.a,
                    2,
                    __arrL({"#f2f2ee", "#e8c24c"}, 2),
                    20,
                    0.2
                )
                naRua(
                    nil,
                    P,
                    t,
                    __call(
                        __arr(__TS__Spread(__iter(RUAS1.b))),
                        "reverse"
                    ),
                    2,
                    __arrL({"#c43c3a", "#2a2a2a"}, 2),
                    18,
                    0.7,
                    function(____, j) return if __t(j) then "moto" else nil end
                )
                do
                    local k = 0
                    while k < 6 do
                        local u = __mod(t * 0.05 + k / 6, 1)
                        pessoa(
                            nil,
                            P,
                            450 + u * 160,
                            468 + __mod(k, 3) * 18,
                            __get(
                                __arrL({"#e86a8a", "#3c6aa8", "#f2c94c", "#7a3a8a"}, 4),
                                __mod(k, 4)
                            ),
                            t
                        )
                        k = k + 1
                    end
                end
                do
                    local k = 0
                    while k < 5 do
                        local x = 516 + k * 9 + math.sin(t * 0.7 + k) * 4
                        local y = 486 + __mod(k, 2) * 5
                        local b = __mod(
                            math.floor(t * 4 + k),
                            3
                        ) == 0
                        R(
                            nil,
                            x,
                            y - 3 + if __t(b) then 1 else 0,
                            4,
                            3,
                            "#8a9096"
                        )
                        R(
                            nil,
                            x + if __t(b) then 3 else 3,
                            y - 4 + if __t(b) then 2 else 0,
                            2,
                            2,
                            "#6a7076"
                        )
                        R(
                            nil,
                            x + 1,
                            y,
                            1,
                            1,
                            "#e8833a"
                        )
                        k = k + 1
                    end
                end
                do
                    local s = math.sin(t * 6) > 0
                    do
                        local k = 0
                        while k < 3 do
                            local q = __mod(t * 0.6 + k, 3)
                            if q < 0.25 then
                                R(
                                    nil,
                                    250 + k * 9,
                                    262 - q * 30,
                                    1,
                                    3,
                                    "#fff6c0"
                                )
                                R(
                                    nil,
                                    249 + k * 9,
                                    263 - q * 30,
                                    3,
                                    1,
                                    "#fff6c0"
                                )
                            end
                            k = k + 1
                        end
                    end
                    if __t(s) then
                        R(
                            nil,
                            250,
                            262,
                            1,
                            1,
                            "#ffffff"
                        )
                    end
                end
                do
                    local a = math.sin(t * 2.2) * 0.55
                    local sx = 302 + math.sin(a) * 18
                    local sy = 199 + math.cos(a) * 18
                    P.c.strokeStyle = "#3a2a1a"
                    P.c.lineWidth = 1
                    P.c:beginPath()
                    P.c:moveTo(298, 199)
                    P.c:lineTo(sx - 4, sy)
                    P.c:moveTo(306, 199)
                    P.c:lineTo(sx + 4, sy)
                    P.c:stroke()
                    R(
                        nil,
                        sx - 5,
                        sy,
                        11,
                        2,
                        "#7a4a2a"
                    )
                end
                do
                    local k = 0
                    while k < 3 do
                        local x = 150 + k * 26 + math.sin(t * 0.8 + k * 2) * 10
                        local y = 440 + __mod(k, 2) * 6
                        local b = __mod(
                            math.floor(t * 3 + k),
                            4
                        ) == 0
                        R(
                            nil,
                            x,
                            y - 5 + if __t(b) then 2 else 0,
                            5,
                            4,
                            "#f6f6f0"
                        )
                        R(
                            nil,
                            x + 4,
                            y - 7 + if __t(b) then 3 else 0,
                            2,
                            2,
                            "#c43c3a"
                        )
                        R(
                            nil,
                            x + 1,
                            y - 1,
                            1,
                            1,
                            "#f2a03a"
                        )
                        R(
                            nil,
                            x + 3,
                            y - 1,
                            1,
                            1,
                            "#f2a03a"
                        )
                        k = k + 1
                    end
                end
                do
                    local u = (math.sin(t * 0.7) + 1) / 2
                    local x = 96 + u * 128
                    local y = 156 + math.sin(t * 1.4) * 10
                    pessoa(
                        nil,
                        P,
                        x,
                        y,
                        "#2c5a9e",
                        t
                    )
                    local by = math.abs(math.sin(t * 6)) * 5
                    R(
                        nil,
                        x + 4,
                        y - 3 - by,
                        3,
                        3,
                        "#ffffff"
                    )
                    R(
                        nil,
                        x + 5,
                        y - 3 - by,
                        1,
                        1,
                        "#1c1c1c"
                    )
                    do
                        local k = 0
                        while k < 4 do
                            R(
                                nil,
                                100 + k * 30,
                                180,
                                3,
                                4,
                                "#f2833a"
                            )
                            R(
                                nil,
                                100 + k * 30,
                                180,
                                3,
                                1,
                                "#ffffff"
                            )
                            k = k + 1
                        end
                    end
                end
                do
                    local pisca = __mod(
                        math.floor(t * 1.5),
                        7
                    ) == 0
                    R(
                        nil,
                        681,
                        182 - if __t(pisca) then 0 else 1,
                        3,
                        2,
                        "#8a9096"
                    )
                    if not __t(pisca) then
                        R(
                            nil,
                            681,
                            181,
                            1,
                            1,
                            "#1c1c1c"
                        )
                        R(
                            nil,
                            683,
                            181,
                            1,
                            1,
                            "#1c1c1c"
                        )
                    end
                    R(
                        nil,
                        680,
                        183,
                        5,
                        1,
                        "#f29ab0"
                    )
                    R(
                        nil,
                        684 + math.floor(math.sin(t * 3) + 0.5),
                        186,
                        4,
                        1,
                        "#e8c8c8"
                    )
                end
                do
                    local k = 0
                    while k < 4 do
                        local u = __mod(t * 0.12 + k / 4, 1)
                        local x = 540 - u * 40 + math.sin(u * 12 + k) * 10
                        local y = 150 + u * 90
                        local f = __mod(
                            math.floor(t * 8 + k),
                            2
                        )
                        R(
                            nil,
                            x,
                            y,
                            if __t(f) then 5 else 3,
                            if __t(f) then 3 else 4,
                            "#f6f4ee"
                        )
                        R(
                            nil,
                            x + 1,
                            y + 1,
                            if __t(f) then 3 else 1,
                            1,
                            "#8ab8e8"
                        )
                        k = k + 1
                    end
                end
                do
                    local k = 0
                    while k < 4 do
                        local a = t * 0.7 + k * 1.57
                        local x = 508 + math.cos(a) * 74
                        local y = 282 + math.sin(a) * 8
                        P.c.strokeStyle = "#1c1c1c"
                        P.c:beginPath()
                        do
                            local j = 0
                            while j < 6 do
                                P.c:lineTo(
                                    x + math.sin(t * 9 + j * 2 + k) * 3 + j - 3,
                                    y - j * 2
                                )
                                j = j + 1
                            end
                        end
                        P.c:stroke()
                        R(
                            nil,
                            x - 1,
                            y - 12,
                            1,
                            1,
                            "#e8433a"
                        )
                        R(
                            nil,
                            x + 2,
                            y - 12,
                            1,
                            1,
                            "#e8433a"
                        )
                        k = k + 1
                    end
                end
                do
                    local b = math.abs(math.sin(t * 4)) * 14
                    P:circ(712, 404 - b, 3, "#e8833a")
                    R(
                        nil,
                        711,
                        403 - b,
                        1,
                        3,
                        "#7a3a1a"
                    )
                    pessoa(
                        nil,
                        P,
                        718,
                        410,
                        "#e8433a",
                        t,
                        false
                    )
                end
                do
                    local on = __mod(
                        math.floor(t * 1.2),
                        2
                    )
                    R(
                        nil,
                        1001,
                        230,
                        8,
                        3,
                        if __t(on) then "#3ce06a" else "#1c3a24"
                    )
                    R(
                        nil,
                        1001,
                        234,
                        8,
                        3,
                        if __t(on) then "#3a1414" else "#e8433a"
                    )
                    local d = math.abs(math.sin(t * 3)) * 2
                    R(
                        nil,
                        988,
                        278 + d,
                        10,
                        3,
                        "#3c6aa8"
                    )
                    R(
                        nil,
                        997,
                        276 + d,
                        3,
                        3,
                        "#c99068"
                    )
                end
                do
                    local k = __mod(
                        math.floor(t * 8),
                        6
                    )
                    do
                        local j = 0
                        while j < 9 do
                            R(
                                nil,
                                860,
                                412 + j * 3,
                                4,
                                3,
                                if __mod(j + k, 3) == 0 then "#e8433a" else if __mod(j + k, 3) == 1 then "#f2f2ee" else "#3c6aa8"
                            )
                            j = j + 1
                        end
                    end
                end
                do
                    local x = 906
                    local y = 395
                    R(
                        nil,
                        x - 12,
                        y,
                        10,
                        3,
                        "#1c1c1c"
                    )
                    R(
                        nil,
                        x + 2,
                        y,
                        10,
                        3,
                        "#1c1c1c"
                    )
                    R(
                        nil,
                        x - 14,
                        y - 2,
                        4,
                        3,
                        "#1c1c1c"
                    )
                    R(
                        nil,
                        x + 10,
                        y - 2,
                        4,
                        3,
                        "#1c1c1c"
                    )
                    R(
                        nil,
                        x - 2,
                        y + 1,
                        4,
                        2,
                        "#1c1c1c"
                    )
                end
                do
                    local k = 0
                    while k < 3 do
                        local x = 694 + k * 12
                        local y = 642
                        R(
                            nil,
                            x,
                            y - 7,
                            6,
                            8,
                            __get(
                                __arrL({"#2a8ae8", "#e8c24c", "#2ad06a"}, 3),
                                k
                            )
                        )
                        R(
                            nil,
                            x,
                            y - 7,
                            6,
                            2,
                            "#dde0e3"
                        )
                        R(
                            nil,
                            x + 1,
                            y - 4,
                            1,
                            3,
                            "#ffffff"
                        )
                        if __mod(
                            math.floor(t * 6 + k * 2),
                            4
                        ) == 0 then
                            R(
                                nil,
                                x + 2,
                                y - 13,
                                1,
                                4,
                                "#fff27a"
                            )
                            R(
                                nil,
                                x + 3,
                                y - 15,
                                1,
                                3,
                                "#fff27a"
                            )
                            R(
                                nil,
                                x + 1,
                                y - 10,
                                1,
                                2,
                                "#fff27a"
                            )
                        end
                        k = k + 1
                    end
                end
                do
                    local k = 0
                    while k < 4 do
                        local on = __mod(
                            math.floor(t * 4 + k),
                            2
                        )
                        R(
                            nil,
                            906 + k * 14,
                            624,
                            10,
                            10,
                            if __t(on) then __get(
                                __arrL({"#ff3a8a", "#3ae0ff", "#ffe23a", "#8a3aff"}, 4),
                                k
                            ) else "#3a2a4a"
                        )
                        k = k + 1
                    end
                end
                for ____, sx in __iterar((__arrL({877, 989}, 2))) do
                    do
                        local k = 0
                        while k < 3 do
                            local q = __mod(t * 1.6 + k / 3, 1)
                            P.c.globalAlpha = (1 - q) * 0.6
                            P.c.strokeStyle = "#ff6ac0"
                            P.c:beginPath()
                            P.c:ellipse(
                                sx,
                                644,
                                6 + q * 22,
                                (6 + q * 22) * 0.5,
                                0,
                                0,
                                math.pi * 2
                            )
                            P.c:stroke()
                            k = k + 1
                        end
                    end
                end
                P.c.globalAlpha = 1
                do
                    local a = t * 0.9
                    local x = 932 + math.cos(a) * 70
                    local y = 510 + math.sin(a * 2) * 16
                    local d = if -math.sin(a) >= 0 then 1 else -1
                    do
                        local k = 1
                        while k < 6 do
                            P.c.globalAlpha = 0.5 - k * 0.08
                            P:circ(
                                932 + math.cos(a - k * 0.08) * 70,
                                513 + math.sin((a - k * 0.08) * 2) * 16,
                                2 + k * 0.4,
                                "#c1db7b"
                            )
                            k = k + 1
                        end
                    end
                    P.c.globalAlpha = 1
                    R(
                        nil,
                        x - 8,
                        y - 5,
                        16,
                        6,
                        "#7a3a8a"
                    )
                    R(
                        nil,
                        x - 4,
                        y - 9,
                        9,
                        4,
                        "#7a3a8a"
                    )
                    R(
                        nil,
                        x - 3 + d,
                        y - 8,
                        7,
                        2,
                        "#9fc4d0"
                    )
                    R(
                        nil,
                        x - 7,
                        y + 1,
                        3,
                        2,
                        "#1c1c1c"
                    )
                    R(
                        nil,
                        x + 4,
                        y + 1,
                        3,
                        2,
                        "#1c1c1c"
                    )
                end
                for ____, ____value in __iterar((__arrL(
                    {
                        __arrL({1000, 6, "#e8433a"}, 3),
                        __arrL({952, 2, "#3c6aa8"}, 3),
                        __arrL({880, 30, "#f2c94c"}, 3),
                        __arrL({1010, 70, "#3c8a5a"}, 3)
                    },
                    4
                ))) do
                    local bx = ____value[1]
                    local by = ____value[2]
                    local cor = ____value[3]
                    local x = bx + math.sin(__add(t, bx)) * 6
                    local y = by + math.sin(t * 1.4 + bx) * 4 + 4
                    P.c.strokeStyle = "#2a2a2a"
                    P.c:beginPath()
                    P.c:moveTo(bx - 8, by + 34)
                    P.c:lineTo(x, y + 9)
                    P.c:stroke()
                    R(
                        nil,
                        x - 4,
                        y,
                        9,
                        9,
                        cor
                    )
                    R(
                        nil,
                        x - 1,
                        y + 9,
                        3,
                        6,
                        "#f2f2ee"
                    )
                    R(
                        nil,
                        x,
                        y + 1,
                        1,
                        7,
                        "#ffffff66"
                    )
                end
                for ____, ____value in __iterar((__arrL(
                    {
                        __arrL({868, 122, 4}, 3),
                        __arrL({926, 76, 3}, 3),
                        __arrL({972, 28, 3}, 3)
                    },
                    3
                ))) do
                    local x0 = ____value[1]
                    local y0 = ____value[2]
                    local n = ____value[3]
                    P.c.strokeStyle = "#4a4a4a"
                    P.c:beginPath()
                    P.c:moveTo(x0, y0)
                    P.c:lineTo(x0 + n * 7, y0 + 2)
                    P.c:stroke()
                    do
                        local k = 0
                        while k < n do
                            local w = math.floor(math.sin(t * 3 + k) * 1 + 0.5)
                            R(
                                nil,
                                x0 + 2 + k * 7,
                                y0 + 1,
                                4,
                                5 + w,
                                __get(
                                    __arrL({"#e86a8a", "#3c6aa8", "#f2c94c", "#f6f6f0"}, 4),
                                    __mod(k, 4)
                                )
                            )
                            k = k + 1
                        end
                    end
                end
                txt(
                    nil,
                    P,
                    "OOO REEEIS",
                    930,
                    176,
                    "#ffd24a",
                    {sombra = "#7a2a1a"}
                )
                do
                    local k = 0
                    while k < 3 do
                        local x = __mod(t * 30 + k * 300, 1100) - 40
                        local y = 60 + k * 70 + math.sin(t * 2 + k) * 6
                        local f = math.sin(t * 12 + k) > 0
                        R(
                            nil,
                            x,
                            y,
                            3,
                            1,
                            "#2a2a2a"
                        )
                        R(
                            nil,
                            x - 2,
                            y - if __t(f) then 2 else 0,
                            2,
                            1,
                            "#2a2a2a"
                        )
                        R(
                            nil,
                            x + 3,
                            y - if __t(f) then 2 else 0,
                            2,
                            1,
                            "#2a2a2a"
                        )
                        k = k + 1
                    end
                end
                do
                    local on = __mod(
                        math.floor(t * 5),
                        2
                    )
                    R(
                        nil,
                        506,
                        606,
                        8,
                        6,
                        if __t(on) then "#3ae0ff" else "#ff3a8a"
                    )
                    R(
                        nil,
                        507,
                        607,
                        2,
                        2,
                        "#ffffff"
                    )
                end
            end,
            veiculo = function(____, P, t, o) return carroViagem(
                nil,
                P,
                t,
                o,
                "gas"
            ) end,
            locais = C1
        },
        "chave,titulo,subtitulo,lajotas,voa,ilha,relevo,terreno,objetos,chao,animarChao,animar,veiculo,locais"
    )
    local function quemC1(self, id, q)
        if not __t(q.lucas) then
            return {
                titulo = "PRECISA PRIMEIRO",
                nomes = __arrL({"CONSERTAR O CARRO COM O LUCAS"}, 1)
            }
        end
        if id == 5 then
            local ____call_46 = __call
            local ____arrL_45 = __arrL
            local ____t_38 = __t
            local ____temp_37 = not __t(q.mota)
            __O[617] = ____temp_37
            local ____temp_43 = if ____t_38(____temp_37) then "O DESAFIO DO MOTA" else __O[617]
            local ____t_40 = __t
            local ____temp_39 = not __t(q.almiro)
            __O[618] = ____temp_39
            local ____temp_44 = if ____t_40(____temp_39) then "A MISSÃO DO ALMIRO" else __O[618]
            local ____t_42 = __t
            local ____temp_41 = not __t(q.miqueias)
            __O[619] = ____temp_41
            return {
                titulo = "PRECISA VENCER",
                nomes = ____call_46(
                    ____arrL_45({____temp_43, ____temp_44, if ____t_42(____temp_41) then "O ENGLISH DO MIQUEIAS" else __O[619]}, 3),
                    "filter",
                    window.Boolean
                )
            }
        end
        if id == 6 then
            return {
                titulo = "PRECISA DERROTAR",
                nomes = __arrL({"MARCO"}, 1)
            }
        end
        if id == 2 then
            return {
                titulo = "PRECISA DERROTAR",
                nomes = __arrL({"MENEZES"}, 1)
            }
        end
        if id == 3 then
            local ____call_53 = __call
            local ____arrL_52 = __arrL
            local ____t_48 = __t
            local ____temp_47 = not __t(q.giant)
            __O[620] = ____temp_47
            local ____temp_51 = if ____t_48(____temp_47) then "O MONSTRO DO CADERNO DO CAOS" else __O[620]
            local ____t_50 = __t
            local ____temp_49 = not __t(q.menezes)
            __O[621] = ____temp_49
            local d = ____call_53(
                ____arrL_52({____temp_51, if ____t_50(____temp_49) then "MENEZES" else __O[621]}, 2),
                "filter",
                window.Boolean
            )
            return {
                titulo = if __t(__len(d)) then "PRECISA DERROTAR" else "PRECISA",
                nomes = __call(d, "concat", if __t(q.trained) then __arrL({}, 0) else __arrL(
                    {__add(if __t(__len(d)) then "+ " else "", "O TREINO DO CALEB")},
                    1
                ))
            }
        end
        return {
            titulo = "AINDA TRANCADO",
            nomes = __arrL({}, 0)
        }
    end
    local function abrirMapa1(self, preferido)
        local G = window.Game
        local ____t_58 = __t
        local ____t_57 = __t
        local ____opt_result_56
        if G ~= nil then
            ____opt_result_56 = G.getState
        end
        if ____t_58(not ____t_57(____opt_result_56) or not __t(window.Mapa3D)) then
            return false
        end
        local st = G:getState()
        local q = if __t(st.q) then st.q else {}
        local ____preferido_59 = preferido
        if ____preferido_59 == nil then
            ____preferido_59 = st.scene
        end
        local atual = __TS__Number(____preferido_59)
        local function estado(____, id)
            if id == atual then
                return {ok = true}
            end
            local ____t_65 = __t
            local ____opt_62 = window.Campaign
            if ____opt_62 ~= nil then
                ____opt_62 = ____opt_62.canTravel
            end
            local ____opt_result_64
            if ____opt_62 ~= nil then
                ____opt_result_64 = ____opt_62(____opt_62, id, q)
            end
            __O[622] = ____opt_result_64
            local r = if ____t_65(____opt_result_64) then __O[622] else {ok = true}
            if r.ok == false then
                return {
                    ok = false,
                    motivo = r.reason,
                    trava = __assign(
                        {},
                        quemC1(nil, id, q),
                        {texto = r.reason}
                    )
                }
            end
            return if __t(st.vehicle) then {ok = true} else {ok = false, motivo = "Entre no carro a gás (tecla V ou botão CARRO) para viajar."}
        end
        local d = __assign(
            {},
            MAPA1,
            {
                locais = __call(
                    C1,
                    "map",
                    function(____, L)
                        local ____assign_72 = __assign
                        local ____temp_70 = {}
                        local ____L_71 = L
                        local ____temp_68 = L.id == atual
                        local ____estado_result_69 = estado(nil, L.id)
                        local ____L_id_67 = L.id
                        local ____L_cam_66 = L.cam
                        if ____L_cam_66 == nil then
                            ____L_cam_66 = 700
                        end
                        return ____assign_72(
                            ____temp_70,
                            ____L_71,
                            {
                                atual = ____temp_68,
                                estado = ____estado_result_69,
                                previa = previaCena(nil, ____L_id_67, ____L_cam_66)
                            }
                        )
                    end
                ),
                aoIr = function(____, id)
                    local ____opt_73 = G.travel
                    if ____opt_73 ~= nil then
                        ____opt_73 = ____opt_73(G, id)
                    end
                    return ____opt_73
                end,
                aoFechar = function()
                end
            }
        )
        return window.Mapa3D:abrir(d)
    end
    local VILOES = __ord({
        creuza = "DONA CREUZA",
        tonhao = "TONHÃO DO MOTOTÁXI",
        valdomiro = "SEU VALDOMIRO",
        kaua = "KAUÃ INFLUENCER",
        barao = "BARÃO DO CAFÉ",
        breno = "BRENO PITBULL",
        gemeos = "RYAN E BRYAN",
        fred = "FRED"
    }, "creuza,tonhao,valdomiro,kaua,barao,breno,gemeos,fred")
    local VNOME = __ord({
        creuza = "a Dona Creuza",
        tonhao = "o Tonhão do Mototáxi",
        valdomiro = "o Seu Valdomiro",
        kaua = "o Kauã Influencer",
        barao = "o Barão do Café",
        breno = "o Breno Pitbull",
        gemeos = "os gêmeos Ryan e Bryan",
        fred = "o Fred"
    }, "creuza,tonhao,valdomiro,kaua,barao,breno,gemeos,fred")
    local ORDEM = __keys(VILOES)
    local REQUER = __ord({
        t16 = "creuza",
        t17 = "creuza",
        t30 = "creuza",
        t32 = "creuza",
        t28 = "tonhao",
        t33 = "tonhao",
        t15 = "valdomiro",
        t29 = "valdomiro",
        t18 = "kaua",
        t31 = "kaua",
        t19 = "barao",
        t34 = "barao",
        t22 = "breno",
        t21 = "gemeos"
    }, "t16,t17,t30,t32,t28,t33,t15,t29,t18,t31,t19,t34,t22,t21")
    local KEY_V = "daroca-c2-vencidos"
    local vencidos = __arrL({}, 0)
    do
        pcall(function()
            local ____self_77 = window.JSON
            local ____self_77_parse_78 = ____self_77.parse
            local ____t_76 = __t
            local ____temp_75 = window.localStorage:getItem(KEY_V)
            __O[623] = ____temp_75
            local v = ____self_77_parse_78(____self_77, if ____t_76(____temp_75) then __O[623] else "[]")
            if __isArray(v) then
                vencidos = __call(
                    v,
                    "filter",
                    function(____, x) return __call(ORDEM, "includes", x) end
                )
            end
        end)
    end
    local function salvarV()
        do
            pcall(function()
                window.localStorage:setItem(
                    KEY_V,
                    window.JSON:stringify(vencidos)
                )
            end)
        end
    end
    local function travaC2(____, L)
        local r = __get(REQUER, L.id)
        local ____t_81 = __t
        local ____t_80 = __t
        local ____temp_79 = not __t(r)
        __O[624] = ____temp_79
        if ____t_81(if ____t_80(____temp_79) then __O[624] else __call(vencidos, "includes", r)) then
            return {ok = true}
        end
        local nome = __get(VILOES, r)
        local txt = ((("O Seu Zé não leva ninguém pra lá enquanto " .. tostring(__get(VNOME, r))) .. " ") .. if r == "gemeos" then "estiverem" else "estiver") .. " no caminho."
        return {
            ok = false,
            motivo = ("Derrote " .. tostring(nome)) .. " para liberar.",
            trava = {
                titulo = "PRECISA DERROTAR",
                nomes = __arrL({nome}, 1),
                texto = txt
            }
        }
    end
    local PONTOS = __arrL(
        {
            __ord(
                {
                    id = "t12",
                    cena = 12,
                    x = 4000,
                    nome = "Aeroporto Glauber Rocha",
                    sub = "Ponto de táxi do desembarque",
                    caixa = __arrL({8, 132, 200, 150}, 4),
                    descricao = "Quem desce aqui sente o frio já na escada do avião. Foi onde a história em Conquista começou, e talvez seja onde ela termine.",
                    desenho = function(____, P)
                        local R = P.R
                        P:predio(
                            40,
                            200,
                            150,
                            72,
                            {topo = "#e8ecee", parede = "#9cc4d2", fachada = 32, faixa = "#2a3aa8"}
                        )
                        R(
                            nil,
                            30,
                            192,
                            170,
                            10,
                            "#f8f8f4"
                        )
                        R(
                            nil,
                            30,
                            200,
                            170,
                            2,
                            "#9aa4a8"
                        )
                        R(
                            nil,
                            60,
                            226,
                            110,
                            6,
                            "#2a3aa8"
                        )
                        R(
                            nil,
                            20,
                            150,
                            70,
                            14,
                            "#f2f4f6"
                        )
                        R(
                            nil,
                            14,
                            140,
                            12,
                            16,
                            "#3c6aa8"
                        )
                        R(
                            nil,
                            84,
                            152,
                            12,
                            10,
                            "#e8ecef"
                        )
                        R(
                            nil,
                            40,
                            160,
                            30,
                            6,
                            "#c9ced2"
                        )
                        do
                            local k = 0
                            while k < 8 do
                                R(
                                    nil,
                                    30 + k * 7,
                                    154,
                                    3,
                                    3,
                                    "#3c4a5a"
                                )
                                k = k + 1
                            end
                        end
                        R(
                            nil,
                            178,
                            150,
                            10,
                            46,
                            "#d8d4cc"
                        )
                        R(
                            nil,
                            172,
                            140,
                            22,
                            14,
                            "#7ac0d0"
                        )
                        R(
                            nil,
                            170,
                            138,
                            26,
                            3,
                            "#2c4a5a"
                        )
                    end
                },
                "id,cena,x,nome,sub,caixa,descricao,desenho"
            ),
            __ord(
                {
                    id = "t13",
                    cena = 13,
                    x = 1500,
                    nome = "Pensão Dona Lurdes",
                    sub = "Bairro da pensão",
                    caixa = __arrL({236, 216, 150, 100}, 4),
                    descricao = "Um quarto pequeno, um mural na parede e uma dona de pensão que sabe de tudo antes de acontecer. É aqui que você volta pra descansar.",
                    desenho = function(____, P)
                        P:casa(
                            270,
                            228,
                            84,
                            74,
                            {
                                telhado = "#9a4a34",
                                parede = "#f2dfb0",
                                paredeH = 26,
                                chamine = true,
                                janelas = __arrL({8, 30, 66}, 3)
                            }
                        )
                        P:R(
                            272,
                            262,
                            80,
                            3,
                            "#3a3026"
                        )
                        do
                            local k = 0
                            while k < 80 do
                                P:R(
                                    272 + k,
                                    258,
                                    1,
                                    6,
                                    "#3a3026"
                                )
                                k = k + 4
                            end
                        end
                        P:casa(
                            240,
                            260,
                            30,
                            40,
                            {
                                telhado = "#b8644a",
                                parede = "#c8dcf0",
                                madeira = false,
                                janelas = __arrL({4}, 1),
                                porta = 18
                            }
                        )
                        P:casa(
                            356,
                            262,
                            30,
                            38,
                            {
                                telhado = "#b8644a",
                                parede = "#f2c4c4",
                                madeira = false,
                                janelas = __arrL({18}, 1),
                                porta = 4
                            }
                        )
                    end
                },
                "id,cena,x,nome,sub,caixa,descricao,desenho"
            ),
            __ord(
                {
                    id = "t14",
                    cena = 14,
                    x = 1700,
                    nome = "Centro · Catedral",
                    sub = "Praça da Catedral",
                    caixa = __arrL({460, 90, 170, 150}, 4),
                    descricao = "Comércio, buzina, pombo e o sino da Catedral. Quando a neblina desce à noite, a praça guarda segredos... e encontros.",
                    desenho = function(____, P)
                        local R = P.R
                        P:casa(
                            520,
                            150,
                            90,
                            70,
                            {
                                telhado = "#cdb98a",
                                parede = "#eedfb6",
                                madeira = false,
                                paredeH = 30,
                                janelas = __arrL({10, 70}, 2)
                            }
                        )
                        R(
                            nil,
                            490,
                            120,
                            32,
                            100,
                            "#eedfb6"
                        )
                        R(
                            nil,
                            490,
                            120,
                            32,
                            3,
                            "#f8f3e4"
                        )
                        R(
                            nil,
                            488,
                            210,
                            36,
                            10,
                            "#cdb98a"
                        )
                        do
                            local k = 0
                            while k < 14 do
                                R(
                                    nil,
                                    506 - (14 - k) * 1.1,
                                    120 - k * 2.6,
                                    (14 - k) * 2.2,
                                    3,
                                    if __t(__mod(k, 3)) then "#eedfb6" else "#f8f3e4"
                                )
                                k = k + 1
                            end
                        end
                        R(
                            nil,
                            505,
                            78,
                            2,
                            10,
                            "#5a5248"
                        )
                        R(
                            nil,
                            501,
                            81,
                            10,
                            2,
                            "#5a5248"
                        )
                        P:circ(506, 140, 6, "#f8f3e4")
                        P:circ(506, 140, 4, "#f4f0e2")
                        R(
                            nil,
                            506,
                            137,
                            1,
                            3,
                            "#2a2a2a"
                        )
                        for ____, y in __iterar((__arrL({160, 190}, 2))) do
                            R(
                                nil,
                                498,
                                y,
                                6,
                                14,
                                "#5a6f86"
                            )
                            R(
                                nil,
                                510,
                                y,
                                6,
                                14,
                                "#5a6f86"
                            )
                        end
                        R(
                            nil,
                            500,
                            200,
                            14,
                            20,
                            "#5a3c28"
                        )
                        P:arvore(
                            470,
                            226,
                            0.9,
                            "roxa",
                            1
                        )
                        P:arvore(
                            620,
                            228,
                            0.9,
                            "amarela",
                            2
                        )
                    end
                },
                "id,cena,x,nome,sub,caixa,descricao,desenho"
            ),
            __ord(
                {
                    id = "t15",
                    cena = 15,
                    x = 300,
                    nome = "Trilha do Cristo",
                    sub = "Pé da Serra do Periperi",
                    caixa = __arrL({440, 0, 100, 140}, 4),
                    desloc = __arrL({-60, 0}, 2),
                    descricao = "Lá em cima, o Cristo de braços abertos vê a cidade inteira. O vento sopra forte, e dizem que alguém sobe lá só pra ser visto.",
                    desenho = function(____, P)
                        local R = P.R
                        P:sombra(
                            492,
                            58,
                            18,
                            5,
                            0.3
                        )
                        R(
                            nil,
                            484,
                            44,
                            16,
                            14,
                            "#8a8478"
                        )
                        R(
                            nil,
                            482,
                            42,
                            20,
                            4,
                            "#a49c90"
                        )
                        R(
                            nil,
                            489,
                            6,
                            6,
                            38,
                            "#a49c90"
                        )
                        R(
                            nil,
                            489,
                            6,
                            2,
                            38,
                            "#c4bcb0"
                        )
                        R(
                            nil,
                            474,
                            14,
                            36,
                            5,
                            "#a49c90"
                        )
                        R(
                            nil,
                            474,
                            14,
                            36,
                            2,
                            "#c4bcb0"
                        )
                        P:circ(492, 6, 3, "#9a8a76")
                        R(
                            nil,
                            520,
                            4,
                            3,
                            54,
                            "#f2f2ee"
                        )
                        do
                            local y = 4
                            while y < 58 do
                                R(
                                    nil,
                                    520,
                                    y,
                                    3,
                                    4,
                                    "#c43c3a"
                                )
                                y = y + 8
                            end
                        end
                        R(
                            nil,
                            516,
                            56,
                            11,
                            3,
                            "#7a8086"
                        )
                        R(
                            nil,
                            519,
                            2,
                            5,
                            3,
                            "#c43c3a"
                        )
                        do
                            local y = 10
                            while y < 56 do
                                R(
                                    nil,
                                    516,
                                    y,
                                    3,
                                    1,
                                    "#9aa0a6"
                                )
                                R(
                                    nil,
                                    523,
                                    y + 4,
                                    3,
                                    1,
                                    "#9aa0a6"
                                )
                                y = y + 10
                            end
                        end
                        escada(
                            nil,
                            P,
                            486,
                            62,
                            18
                        )
                        P:placa(500, 128, "#5a3820")
                    end
                },
                "id,cena,x,nome,sub,caixa,desloc,descricao,desenho"
            ),
            __ord(
                {
                    id = "t16",
                    cena = 16,
                    x = 2700,
                    nome = "Monumento ao Índio",
                    sub = "Avenidas e rotatória",
                    caixa = __arrL({680, 276, 110, 94}, 4),
                    descricao = "A rotatória mais famosa da cidade. Trânsito pesado, mototáxi pra todo lado e alguém que cobra caro demais por uma corrida.",
                    desenho = function(____, P)
                        local R = P.R
                        P:circ(
                            734,
                            334,
                            42,
                            "#6a7076",
                            22
                        )
                        P:circ(
                            734,
                            332,
                            40,
                            "#8a9096",
                            20
                        )
                        P:circ(
                            734,
                            330,
                            36,
                            "#5aa046",
                            18
                        )
                        P:circ(
                            734,
                            330,
                            30,
                            "#7cc458",
                            15
                        )
                        do
                            local k = 0
                            while k < 24 do
                                local a = k / 24 * math.pi * 2
                                R(
                                    nil,
                                    734 + math.cos(a) * 33,
                                    330 + math.sin(a) * 16,
                                    3,
                                    3,
                                    __get(
                                        __arrL({"#e8433a", "#f2c94c", "#ffffff", "#e86a8a"}, 4),
                                        __mod(k, 4)
                                    )
                                )
                                k = k + 1
                            end
                        end
                        P:sombra(
                            738,
                            334,
                            16,
                            5,
                            0.3
                        )
                        R(
                            nil,
                            720,
                            318,
                            28,
                            14,
                            "#8a8478"
                        )
                        R(
                            nil,
                            720,
                            318,
                            28,
                            3,
                            "#b0aa9c"
                        )
                        R(
                            nil,
                            724,
                            310,
                            20,
                            10,
                            "#a49c90"
                        )
                        R(
                            nil,
                            724,
                            310,
                            20,
                            2,
                            "#c4bcb0"
                        )
                        R(
                            nil,
                            726,
                            324,
                            16,
                            4,
                            "#6a6458"
                        )
                        R(
                            nil,
                            730,
                            282,
                            9,
                            28,
                            "#7a4a20"
                        )
                        R(
                            nil,
                            731,
                            282,
                            3,
                            28,
                            "#c8904a"
                        )
                        R(
                            nil,
                            729,
                            276,
                            11,
                            9,
                            "#8a5a2a"
                        )
                        R(
                            nil,
                            731,
                            277,
                            3,
                            3,
                            "#c8904a"
                        )
                        do
                            local k = 0
                            while k < 5 do
                                R(
                                    nil,
                                    727 + k * 3,
                                    268 + math.abs(k - 2),
                                    2,
                                    8,
                                    if __t(__mod(k, 2)) then "#e8c24c" else "#c43c3a"
                                )
                                k = k + 1
                            end
                        end
                        R(
                            nil,
                            724,
                            296,
                            7,
                            6,
                            "#7a4a20"
                        )
                        R(
                            nil,
                            724,
                            300,
                            5,
                            10,
                            "#7a4a20"
                        )
                        R(
                            nil,
                            739,
                            288,
                            16,
                            3,
                            "#7a4a20"
                        )
                        P.c.strokeStyle = "#5a3418"
                        P.c.lineWidth = 2
                        P.c:beginPath()
                        P.c:arc(
                            754,
                            290,
                            11,
                            -1.35,
                            1.35
                        )
                        P.c:stroke()
                        P.c.lineWidth = 1
                        R(
                            nil,
                            752,
                            279,
                            1,
                            22,
                            "#e8dcc0"
                        )
                        R(
                            nil,
                            740,
                            289,
                            16,
                            1,
                            "#e8dcc0"
                        )
                        R(
                            nil,
                            756,
                            288,
                            3,
                            3,
                            "#a8aeb4"
                        )
                    end
                },
                "id,cena,x,nome,sub,caixa,descricao,desenho"
            ),
            __ord(
                {
                    id = "t17",
                    cena = 17,
                    x = 400,
                    nome = "Feira do Planalto",
                    sub = "Barracas e biscoitarias",
                    caixa = __arrL({470, 356, 176, 100}, 4),
                    descricao = "Grito de feirante, cheiro de biscoito quente e um senhor que vende garrafadas misteriosas. Tem quem diga que ali se compra até coragem.",
                    desenho = function(____, P)
                        local R = P.R
                        local cores = __arrL({
                            "#3c6aa8",
                            "#e8833a",
                            "#e8c24c",
                            "#3c8a5a",
                            "#c43c3a",
                            "#7a3a8a"
                        }, 6)
                        do
                            local k = 0
                            while k < 6 do
                                local x = 480 + __mod(k, 3) * 54
                                local y = 372 + math.floor(k / 3) * 40
                                P:sombra(x + 22, y + 30, 22, 4)
                                R(
                                    nil,
                                    x,
                                    y,
                                    46,
                                    12,
                                    __get(cores, k)
                                )
                                do
                                    local j = 0
                                    while j < 46 do
                                        R(
                                            nil,
                                            x + j,
                                            y,
                                            3,
                                            12,
                                            "#f6f2ea"
                                        )
                                        j = j + 6
                                    end
                                end
                                R(
                                    nil,
                                    x + 2,
                                    y + 12,
                                    2,
                                    18,
                                    "#6a5a44"
                                )
                                R(
                                    nil,
                                    x + 42,
                                    y + 12,
                                    2,
                                    18,
                                    "#6a5a44"
                                )
                                R(
                                    nil,
                                    x + 4,
                                    y + 22,
                                    38,
                                    8,
                                    "#8a6a45"
                                )
                                do
                                    local j = 0
                                    while j < 6 do
                                        P:circ(
                                            x + 8 + j * 6,
                                            y + 20,
                                            2,
                                            __get(
                                                __arrL({"#e8c24c", "#7cbf6a", "#d9634a", "#f6ecd0"}, 4),
                                                __mod(j + k, 4)
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
                            while k < 22 do
                                local x = 476 + k * 8
                                local y = 366 + math.floor(math.sin(k / 21 * math.pi) * 5 + 0.5)
                                R(
                                    nil,
                                    x,
                                    y,
                                    5,
                                    4,
                                    __get(
                                        __arrL({
                                            "#e8433a",
                                            "#f2c94c",
                                            "#3c8a5a",
                                            "#3c6aa8",
                                            "#e86a8a"
                                        }, 5),
                                        __mod(k, 5)
                                    )
                                )
                                k = k + 1
                            end
                        end
                        R(
                            nil,
                            600,
                            440,
                            30,
                            12,
                            "#e8d8a8"
                        )
                        R(
                            nil,
                            600,
                            440,
                            30,
                            2,
                            "#a8643a"
                        )
                        txt(
                            nil,
                            P,
                            "BISCOITO",
                            615,
                            443,
                            "#7a3a10"
                        )
                    end
                },
                "id,cena,x,nome,sub,caixa,descricao,desenho"
            ),
            __ord(
                {
                    id = "t18",
                    cena = 18,
                    x = 300,
                    nome = "Fazendas de café",
                    sub = "Porteira da fazenda",
                    caixa = __arrL({970, 560, 140, 100}, 4),
                    descricao = "Fileiras de café até onde a vista alcança. O dono da fazenda vizinha anda nervoso... e não é só por causa da cafeína.",
                    desenho = function(____, P)
                        P:casa(
                            990,
                            580,
                            84,
                            60,
                            {
                                telhado = "#8a4430",
                                parede = "#f2ece0",
                                paredeH = 22,
                                chamine = true,
                                janelas = __arrL({8, 30, 64}, 3)
                            }
                        )
                        P:R(
                            1080,
                            608,
                            26,
                            30,
                            "#cfcac0"
                        )
                        do
                            local k = 0
                            while k < 26 do
                                P:R(
                                    1080 + k,
                                    610,
                                    2,
                                    26,
                                    if __mod(k, 6) < 3 then "#7a4a2a" else "#5a3420"
                                )
                                k = k + 3
                            end
                        end
                        P:R(
                            1010,
                            568,
                            46,
                            9,
                            "#5a3820"
                        )
                        txt(
                            nil,
                            P,
                            "FAZENDA",
                            1033,
                            570,
                            "#f2e2b8"
                        )
                        do
                            local k = 0
                            while k < 6 do
                                P:R(
                                    1084 + __mod(k, 2) * 8,
                                    642 + math.floor(k / 2) * 3,
                                    3,
                                    2,
                                    "#c43c3a"
                                )
                                k = k + 1
                            end
                        end
                        P:cercaH(976, 652, 120)
                    end
                },
                "id,cena,x,nome,sub,caixa,descricao,desenho"
            ),
            __ord(
                {
                    id = "t19",
                    cena = 19,
                    x = 300,
                    nome = "Teatro e Planetário",
                    sub = "Centro de Cultura",
                    caixa = __arrL({730, 120, 150, 110}, 4),
                    descricao = "De noite, as luzes do teatro acendem e a cúpula do planetário guarda o céu inteiro. Tem show hoje... e um valentão na plateia.",
                    desenho = function(____, P)
                        local R = P.R
                        P:predio(
                            734,
                            140,
                            54,
                            62,
                            {
                                topo = "#7a8086",
                                parede = "#9aa0a6",
                                fachada = 26,
                                caixa = false,
                                porta = false
                            }
                        )
                        R(
                            nil,
                            738,
                            178,
                            46,
                            6,
                            "#3a3f44"
                        )
                        txt(
                            nil,
                            P,
                            "CULTURA",
                            761,
                            179,
                            "#e8e4dc"
                        )
                        R(
                            nil,
                            752,
                            188,
                            18,
                            12,
                            "#9ad0e8"
                        )
                        P:sombra(
                            824,
                            216,
                            34,
                            5,
                            0.25
                        )
                        R(
                            nil,
                            792,
                            160,
                            64,
                            50,
                            "#a8583a"
                        )
                        do
                            local y = 162
                            while y < 210 do
                                do
                                    local x = 792 + __mod(y / 4, 2) * 4
                                    while x < 856 do
                                        R(
                                            nil,
                                            x,
                                            y,
                                            7,
                                            3,
                                            "#b86a48"
                                        )
                                        x = x + 8
                                    end
                                end
                                y = y + 4
                            end
                        end
                        R(
                            nil,
                            792,
                            158,
                            64,
                            4,
                            "#5a2a1a"
                        )
                        R(
                            nil,
                            796,
                            164,
                            56,
                            10,
                            "#3a1a14"
                        )
                        txt(
                            nil,
                            P,
                            "TEATRO",
                            824,
                            166,
                            "#ffe39a"
                        )
                        do
                            local k = 0
                            while k < 56 do
                                R(
                                    nil,
                                    797 + k,
                                    175,
                                    2,
                                    2,
                                    "#ffe39a"
                                )
                                k = k + 5
                            end
                        end
                        for ____, ____value in __iterar((__arrL(
                            {
                                __arrL({0, "#e8433a"}, 2),
                                __arrL({1, "#3c6aa8"}, 2),
                                __arrL({2, "#f2c94c"}, 2),
                                __arrL({3, "#9a52c0"}, 2)
                            },
                            4
                        ))) do
                            local k = ____value[1]
                            local cor = ____value[2]
                            R(
                                nil,
                                796 + k * 14,
                                190,
                                11,
                                20,
                                cor
                            )
                            R(
                                nil,
                                796 + k * 14,
                                190,
                                11,
                                2,
                                "#ffffff55"
                            )
                            R(
                                nil,
                                800 + k * 14,
                                200,
                                1,
                                2,
                                "#2a1a10"
                            )
                        end
                        P:circ(
                            866,
                            198,
                            14,
                            "#c8ccd0",
                            10
                        )
                        P:circ(
                            866,
                            196,
                            13,
                            "#eef0f2",
                            9
                        )
                        P:circ(
                            862,
                            192,
                            5,
                            "#ffffff",
                            3
                        )
                        R(
                            nil,
                            852,
                            200,
                            28,
                            10,
                            "#d8dce0"
                        )
                        R(
                            nil,
                            862,
                            202,
                            8,
                            8,
                            "#5a6a7a"
                        )
                    end
                },
                "id,cena,x,nome,sub,caixa,descricao,desenho"
            ),
            __ord(
                {
                    id = "t22",
                    cena = 22,
                    x = 1100,
                    nome = "Frente do Shopping",
                    sub = "Estacionamento e entrada",
                    caixa = __arrL({890, 150, 190, 130}, 4),
                    descricao = "Cinema, lan house e gente fugindo do frio. Dizem que lá dentro tem um jogo dentro do jogo... e dois irmãos que não sabem perder.",
                    desenho = function(____, P)
                        local R = P.R
                        P:predio(
                            900,
                            158,
                            160,
                            76,
                            {
                                topo = "#c8ccd0",
                                parede = "#ece6d8",
                                fachada = 34,
                                caixa = false,
                                porta = false
                            }
                        )
                        R(
                            nil,
                            946,
                            186,
                            64,
                            48,
                            "#5aa0c8"
                        )
                        do
                            local x = 948
                            while x < 1008 do
                                R(
                                    nil,
                                    x,
                                    188,
                                    7,
                                    44,
                                    "#9ad0e8"
                                )
                                x = x + 8
                            end
                        end
                        do
                            local y = 196
                            while y < 232 do
                                R(
                                    nil,
                                    948,
                                    y,
                                    60,
                                    1,
                                    "#f2f4f6"
                                )
                                y = y + 10
                            end
                        end
                        R(
                            nil,
                            946,
                            186,
                            64,
                            2,
                            "#f2f4f6"
                        )
                        R(
                            nil,
                            950,
                            176,
                            56,
                            10,
                            "#e8833a"
                        )
                        R(
                            nil,
                            950,
                            176,
                            56,
                            2,
                            "#f8a85a"
                        )
                        txt(
                            nil,
                            P,
                            "SHOPPING",
                            978,
                            178,
                            "#fff6e0"
                        )
                        for ____, ____value in __iterar((__arrL(
                            {
                                __arrL({956, "#e8433a"}, 2),
                                __arrL({972, "#f2c94c"}, 2),
                                __arrL({988, "#3c6aa8"}, 2)
                            },
                            3
                        ))) do
                            local x = ____value[1]
                            local cor = ____value[2]
                            R(
                                nil,
                                x,
                                214,
                                6,
                                8,
                                cor
                            )
                        end
                        R(
                            nil,
                            1066,
                            166,
                            10,
                            50,
                            "#2a2a30"
                        )
                        do
                            local k = 0
                            while k < 6 do
                                R(
                                    nil,
                                    1067,
                                    170 + k * 7,
                                    8,
                                    5,
                                    __get(
                                        __arrL({
                                            "#e8833a",
                                            "#e8433a",
                                            "#f2c94c",
                                            "#3c8a5a",
                                            "#3c6aa8",
                                            "#e86a8a"
                                        }, 6),
                                        k
                                    )
                                )
                                k = k + 1
                            end
                        end
                        R(
                            nil,
                            900,
                            242,
                            170,
                            34,
                            "#5b6066"
                        )
                        do
                            local x = 904
                            while x < 1068 do
                                R(
                                    nil,
                                    x,
                                    244,
                                    1,
                                    30,
                                    "#f2f2ee"
                                )
                                x = x + 20
                            end
                        end
                        do
                            local k = 0
                            while k < 6 do
                                if k == 3 then
                                    continue
                                end
                                carrinho(
                                    nil,
                                    P,
                                    914 + k * 28,
                                    262,
                                    __get(
                                        __arrL({
                                            "#c43c3a",
                                            "#f2f2ee",
                                            "#3c6aa8",
                                            "#e8c24c",
                                            "#2a2a2a",
                                            "#3c8a5a"
                                        }, 6),
                                        k
                                    )
                                )
                                k = k + 1
                            end
                        end
                        pessoa(
                            nil,
                            P,
                            940,
                            240,
                            "#e86a8a"
                        )
                        pessoa(
                            nil,
                            P,
                            1014,
                            240,
                            "#3c8a5a"
                        )
                    end
                },
                "id,cena,x,nome,sub,caixa,descricao,desenho"
            ),
            __ord(
                {
                    id = "t21",
                    cena = 21,
                    x = 3700,
                    nome = "Entrada da Escola SESI",
                    sub = "Avenida Olívia Flores",
                    caixa = __arrL({890, 350, 160, 120}, 4),
                    descricao = "O táxi deixa você no portão. Lá dentro tem escada, pátio e alguém que diz que o seu melhor amigo agora é dele.",
                    desenho = function(____, P)
                        local R = P.R
                        P:predio(
                            940,
                            360,
                            100,
                            60,
                            {topo = "#e8e8e4", parede = "#f2f2ee", fachada = 26, faixa = "#2c5a9e"}
                        )
                        R(
                            nil,
                            892,
                            366,
                            44,
                            56,
                            "#3c8a5a"
                        )
                        R(
                            nil,
                            894,
                            368,
                            40,
                            52,
                            "#4a9a5a"
                        )
                        R(
                            nil,
                            894,
                            393,
                            40,
                            1,
                            "#f2f2ee"
                        )
                        R(
                            nil,
                            894,
                            368,
                            1,
                            52,
                            "#f2f2ee"
                        )
                        R(
                            nil,
                            933,
                            368,
                            1,
                            52,
                            "#f2f2ee"
                        )
                        P:circ(
                            914,
                            393,
                            6,
                            "#f2f2ee",
                            5
                        )
                        P:circ(
                            914,
                            393,
                            5,
                            "#4a9a5a",
                            4
                        )
                        R(
                            nil,
                            892,
                            424,
                            156,
                            20,
                            "#f6f6f2"
                        )
                        R(
                            nil,
                            892,
                            424,
                            156,
                            2,
                            "#ffffff"
                        )
                        R(
                            nil,
                            892,
                            442,
                            156,
                            2,
                            "#c8ccd0"
                        )
                        do
                            local k = 0
                            while k < 22 do
                                local x = 896 + k * 7
                                local cor = __get(
                                    __arrL({
                                        "#e8433a",
                                        "#f2c94c",
                                        "#3c8a5a",
                                        "#3c6aa8",
                                        "#9a52c0",
                                        "#e8833a"
                                    }, 6),
                                    __mod(k, 6)
                                )
                                R(
                                    nil,
                                    x,
                                    430 + math.floor(math.sin(k * 0.9) * 4 + 0.5),
                                    6,
                                    6,
                                    cor
                                )
                                R(
                                    nil,
                                    x + 2,
                                    428 + math.floor(math.cos(k) * 3 + 0.5),
                                    3,
                                    3,
                                    cor
                                )
                                k = k + 1
                            end
                        end
                        R(
                            nil,
                            960,
                            444,
                            30,
                            20,
                            "#c8ccd0"
                        )
                        do
                            local x = 962
                            while x < 990 do
                                R(
                                    nil,
                                    x,
                                    446,
                                    1,
                                    16,
                                    "#5a5e64"
                                )
                                x = x + 3
                            end
                        end
                        R(
                            nil,
                            958,
                            442,
                            34,
                            3,
                            "#2c5a9e"
                        )
                        txt(
                            nil,
                            P,
                            "SESI",
                            975,
                            437,
                            "#2c5a9e"
                        )
                        do
                            local x = 896
                            while x < 1046 do
                                R(
                                    nil,
                                    x,
                                    452,
                                    1,
                                    12,
                                    "#2c5a9e"
                                )
                                x = x + 4
                            end
                        end
                        R(
                            nil,
                            896,
                            452,
                            150,
                            2,
                            "#2c5a9e"
                        )
                        pessoa(
                            nil,
                            P,
                            1010,
                            468,
                            "#2c5a9e"
                        )
                        pessoa(
                            nil,
                            P,
                            1024,
                            466,
                            "#e8433a"
                        )
                    end
                },
                "id,cena,x,nome,sub,caixa,descricao,desenho"
            ),
            __ord(
                {
                    id = "t28",
                    cena = 28,
                    x = 250,
                    nome = "Reserva do Poço Escuro",
                    sub = "Entrada da trilha",
                    caixa = __arrL({16, 380, 200, 210}, 4),
                    descricao = "Mata fechada dentro da cidade. Água que cai das pedras, saguis curiosos e um silêncio que parece guardar alguma coisa.",
                    desenho = function(____, P)
                        do
                            local i = 0
                            while i < 16 do
                                local x = 30 + hash(nil, i, 1) * 170
                                local y = 420 + hash(nil, i, 2) * 150
                                local ____t_84 = __t
                                local ____t_83 = __t
                                local ____temp_82 = math.abs(x - 100) < 20 and y > 480
                                __O[625] = ____temp_82
                                if ____t_84(if ____t_83(____temp_82) then y < 540 else __O[625]) then
                                    continue
                                end
                                P:arvore(
                                    x,
                                    y,
                                    1 + hash(nil, i, 3) * 0.4,
                                    if __t(__mod(i, 3)) then "escura" else "verde",
                                    i
                                )
                                i = i + 1
                            end
                        end
                        P:placa(190, 580)
                        P:R(
                            150,
                            560,
                            28,
                            20,
                            "#8a6a45"
                        )
                        P:R(
                            148,
                            556,
                            32,
                            6,
                            "#6a4a32"
                        )
                    end
                },
                "id,cena,x,nome,sub,caixa,descricao,desenho"
            ),
            __ord(
                {
                    id = "t29",
                    cena = 29,
                    x = 250,
                    nome = "Portão do Lomantão",
                    sub = "Estádio Lomanto Júnior",
                    caixa = __arrL({214, 560, 180, 150}, 4),
                    descricao = "Em dia de jogo a cidade para. Torcida cantando, espetinho na porta e um goleiro que conversa com a bola.",
                    desenho = function(____, P)
                        local R = P.R
                        P:sombra(
                            304,
                            690,
                            84,
                            12,
                            0.3
                        )
                        P:circ(
                            304,
                            632,
                            82,
                            "#9aa0a6",
                            56
                        )
                        P:circ(
                            304,
                            628,
                            78,
                            "#c8ccd0",
                            52
                        )
                        do
                            local k = 0
                            while k < 40 do
                                local a = k / 40 * math.pi * 2
                                local r = 70
                                R(
                                    nil,
                                    304 + math.cos(a) * r,
                                    628 + math.sin(a) * r * 0.66,
                                    4,
                                    4,
                                    __get(
                                        __arrL({"#e8433a", "#f2efe6", "#2c5a9e", "#e8c24c"}, 4),
                                        __mod(k, 4)
                                    )
                                )
                                k = k + 1
                            end
                        end
                        P:circ(
                            304,
                            630,
                            58,
                            "#5aa046",
                            36
                        )
                        R(
                            nil,
                            256,
                            628,
                            96,
                            1,
                            "#f2f2ee"
                        )
                        P:circ(
                            304,
                            630,
                            10,
                            "#f2f2ee",
                            6
                        )
                        P:circ(
                            304,
                            630,
                            9,
                            "#5aa046",
                            5
                        )
                        for ____, ____value in __iterar((__arrL(
                            {
                                __arrL({226, 580}, 2),
                                __arrL({382, 580}, 2)
                            },
                            2
                        ))) do
                            local x = ____value[1]
                            local y = ____value[2]
                            R(
                                nil,
                                x,
                                y - 40,
                                3,
                                40,
                                "#6a6e74"
                            )
                            R(
                                nil,
                                x - 6,
                                y - 46,
                                15,
                                8,
                                "#f2f2ee"
                            )
                        end
                        P:R(
                            250,
                            660,
                            108,
                            10,
                            "#c43c3a"
                        )
                        txt(
                            nil,
                            P,
                            "LOMANTÃO",
                            304,
                            662,
                            "#f2efe6"
                        )
                        R(
                            nil,
                            290,
                            690,
                            30,
                            12,
                            "#2c5a9e"
                        )
                    end
                },
                "id,cena,x,nome,sub,caixa,descricao,desenho"
            ),
            __ord(
                {
                    id = "t30",
                    cena = 30,
                    x = 4500,
                    nome = "Rodoviária",
                    sub = "Plataformas de embarque",
                    caixa = __arrL({730, 560, 170, 116}, 4),
                    descricao = "Gente chegando, gente partindo, um engraxate que viu a cidade inteira passar e ônibus pra todo canto do mapa.",
                    desenho = function(____, P)
                        local R = P.R
                        P:predio(
                            738,
                            568,
                            60,
                            72,
                            {topo = "#b8b4aa", parede = "#e2ddd0", fachada = 28}
                        )
                        R(
                            nil,
                            740,
                            570,
                            56,
                            10,
                            "#2c5a9e"
                        )
                        txt(
                            nil,
                            P,
                            "RODOVIÁRIA",
                            768,
                            572,
                            "#f2efe6"
                        )
                        P:sombra(
                            850,
                            664,
                            50,
                            6,
                            0.25
                        )
                        R(
                            nil,
                            802,
                            584,
                            94,
                            10,
                            "#d8dcde"
                        )
                        R(
                            nil,
                            802,
                            584,
                            94,
                            2,
                            "#f2f4f4"
                        )
                        R(
                            nil,
                            802,
                            593,
                            94,
                            2,
                            "#9aa0a6"
                        )
                        for ____, x in __iterar((__arrL({806, 836, 866, 892}, 4))) do
                            R(
                                nil,
                                x,
                                594,
                                3,
                                40,
                                "#a8aeb4"
                            )
                        end
                        do
                            local k = 0
                            while k < 3 do
                                local x = 808 + k * 30
                                R(
                                    nil,
                                    x,
                                    602,
                                    24,
                                    50,
                                    "#f2f4f6"
                                )
                                R(
                                    nil,
                                    x,
                                    602,
                                    24,
                                    2,
                                    "#ffffff"
                                )
                                R(
                                    nil,
                                    x + 2,
                                    606,
                                    20,
                                    9,
                                    "#24303a"
                                )
                                R(
                                    nil,
                                    x,
                                    622,
                                    24,
                                    4,
                                    "#2c5a9e"
                                )
                                R(
                                    nil,
                                    x,
                                    627,
                                    24,
                                    2,
                                    "#e8c24c"
                                )
                                R(
                                    nil,
                                    x + 3,
                                    646,
                                    5,
                                    4,
                                    "#1c1c1c"
                                )
                                R(
                                    nil,
                                    x + 16,
                                    646,
                                    5,
                                    4,
                                    "#1c1c1c"
                                )
                                R(
                                    nil,
                                    x + 10,
                                    640,
                                    4,
                                    3,
                                    "#2c5a9e"
                                )
                                R(
                                    nil,
                                    x + 2,
                                    652,
                                    20,
                                    3,
                                    "#00000033"
                                )
                                R(
                                    nil,
                                    x + 6,
                                    596,
                                    12,
                                    6,
                                    "#9aa0a6"
                                )
                                txt(
                                    nil,
                                    P,
                                    tostring(k + 1),
                                    x + 12,
                                    597,
                                    "#f2efe6"
                                )
                                k = k + 1
                            end
                        end
                        pessoa(
                            nil,
                            P,
                            790,
                            652,
                            "#e8833a"
                        )
                        pessoa(
                            nil,
                            P,
                            870,
                            668,
                            "#3c8a5a"
                        )
                    end
                },
                "id,cena,x,nome,sub,caixa,descricao,desenho"
            ),
            __ord(
                {
                    id = "t31",
                    cena = 31,
                    x = 4300,
                    nome = "UESB",
                    sub = "Ponto do circular",
                    caixa = __arrL({920, 16, 220, 130}, 4),
                    descricao = "Módulos de aula, cantina, biblioteca e uma professora que guarda a história da cidade em caixas de sapato.",
                    desenho = function(____, P)
                        local R = P.R
                        for ____, ____value in __iterar((__arrL(
                            {
                                __arrL({930, 34, 100}, 3),
                                __arrL({1046, 30, 88}, 3),
                                __arrL({960, 82, 120}, 3)
                            },
                            3
                        ))) do
                            local x = ____value[1]
                            local y = ____value[2]
                            local w = ____value[3]
                            P:predio(
                                x,
                                y,
                                w,
                                40,
                                {
                                    topo = "#c8c4b8",
                                    parede = "#f2efe6",
                                    fachada = 18,
                                    faixa = "#2c5a9e",
                                    caixa = false,
                                    porta = false
                                }
                            )
                        end
                        R(
                            nil,
                            1000,
                            30,
                            30,
                            8,
                            "#2c5a9e"
                        )
                        txt(
                            nil,
                            P,
                            "UESB",
                            1015,
                            31,
                            "#f2efe6"
                        )
                        for ____, ____value in __iterar((__arrL(
                            {
                                __arrL({944, 132, "roxa"}, 3),
                                __arrL({1092, 136, "roxa"}, 3),
                                __arrL({1124, 90, "amarela"}, 3),
                                __arrL({924, 92, "roxa"}, 3)
                            },
                            4
                        ))) do
                            local x = ____value[1]
                            local y = ____value[2]
                            local t = ____value[3]
                            P:arvore(
                                x,
                                y,
                                0.85,
                                t,
                                x
                            )
                        end
                        R(
                            nil,
                            1024,
                            128,
                            34,
                            3,
                            "#2c5a9e"
                        )
                        R(
                            nil,
                            1024,
                            131,
                            34,
                            2,
                            "#9aa0a6"
                        )
                        R(
                            nil,
                            1026,
                            131,
                            2,
                            12,
                            "#7a8086"
                        )
                        R(
                            nil,
                            1054,
                            131,
                            2,
                            12,
                            "#7a8086"
                        )
                        R(
                            nil,
                            1030,
                            136,
                            22,
                            3,
                            "#a8643a"
                        )
                        R(
                            nil,
                            1060,
                            118,
                            18,
                            9,
                            "#f2c94c"
                        )
                        txt(
                            nil,
                            P,
                            "CIRC",
                            1069,
                            120,
                            "#2a2a2a"
                        )
                        R(
                            nil,
                            1068,
                            127,
                            2,
                            16,
                            "#5a5e62"
                        )
                        pessoa(
                            nil,
                            P,
                            1036,
                            142,
                            "#9a52c0"
                        )
                        pessoa(
                            nil,
                            P,
                            1046,
                            142,
                            "#3c8ab0"
                        )
                    end
                },
                "id,cena,x,nome,sub,caixa,descricao,desenho"
            ),
            __ord(
                {
                    id = "t32",
                    cena = 32,
                    x = 300,
                    nome = "Lagoa das Bateias",
                    sub = "Pista de caminhada",
                    caixa = __arrL({430, 560, 220, 170}, 4),
                    descricao = "Garças pescando, pedalinhos de cisne e a lenda de uma pepita no fundo. Um menino jura que ainda vai achar.",
                    desenho = function(____, P)
                        local R = P.R
                        R(
                            nil,
                            600,
                            650,
                            40,
                            8,
                            "#a87a4a"
                        )
                        do
                            local k = 0
                            while k < 40 do
                                R(
                                    nil,
                                    600 + k,
                                    650,
                                    1,
                                    8,
                                    "#7a4a2a"
                                )
                                k = k + 5
                            end
                        end
                        for ____, ____value in __iterar((__arrL(
                            {
                                __arrL({470, 612}, 2),
                                __arrL({520, 640}, 2),
                                __arrL({560, 600}, 2)
                            },
                            3
                        ))) do
                            local x = ____value[1]
                            local y = ____value[2]
                            R(
                                nil,
                                x,
                                y,
                                14,
                                7,
                                "#f6f6f0"
                            )
                            R(
                                nil,
                                x + 11,
                                y - 7,
                                3,
                                8,
                                "#f6f6f0"
                            )
                            R(
                                nil,
                                x + 12,
                                y - 8,
                                4,
                                2,
                                "#f6f6f0"
                            )
                            R(
                                nil,
                                x + 15,
                                y - 7,
                                2,
                                1,
                                "#f08a24"
                            )
                            R(
                                nil,
                                x + 3,
                                y - 3,
                                4,
                                3,
                                "#e8433a"
                            )
                        end
                        do
                            local k = 0
                            while k < 60 do
                                local a = math.pi * (0.08 + k / 59 * 0.84)
                                local x = 540 + math.cos(a) * 104
                                local y = 640 + math.sin(a) * 82
                                R(
                                    nil,
                                    x - 3,
                                    y - 3,
                                    7,
                                    7,
                                    "#c8543a"
                                )
                                if __mod(k, 6) == 0 then
                                    R(
                                        nil,
                                        x - 1,
                                        y - 1,
                                        3,
                                        1,
                                        "#f2f2ee"
                                    )
                                end
                                k = k + 1
                            end
                        end
                        for ____, ____value in __iterar((__arrL(
                            {
                                __arrL({452, 690, "300M"}, 3),
                                __arrL({540, 716, "700M"}, 3),
                                __arrL({628, 690, "1100M"}, 3)
                            },
                            3
                        ))) do
                            local x = ____value[1]
                            local y = ____value[2]
                            local t = ____value[3]
                            txt(
                                nil,
                                P,
                                t,
                                x,
                                y,
                                "#f2f2ee"
                            )
                        end
                        for ____, ____value in __iterar((__arrL(
                            {
                                __arrL({446, "#f2c94c"}, 2),
                                __arrL({460, "#e8433a"}, 2)
                            },
                            2
                        ))) do
                            local x = ____value[1]
                            local cor = ____value[2]
                            R(
                                nil,
                                x,
                                650,
                                2,
                                14,
                                cor
                            )
                            R(
                                nil,
                                x + 10,
                                650,
                                2,
                                14,
                                cor
                            )
                            R(
                                nil,
                                x,
                                650,
                                12,
                                2,
                                cor
                            )
                        end
                        P:coqueiro(444, 724)
                        P:coqueiro(648, 600)
                        P:banco(600, 728)
                        for ____, ____value in __iterar((__arrL(
                            {
                                __arrL({620, 610}, 2),
                                __arrL({470, 584}, 2)
                            },
                            2
                        ))) do
                            local x = ____value[1]
                            local y = ____value[2]
                            R(
                                nil,
                                x,
                                y,
                                2,
                                8,
                                "#f2f2ee"
                            )
                            R(
                                nil,
                                x - 1,
                                y - 3,
                                4,
                                3,
                                "#f2f2ee"
                            )
                            R(
                                nil,
                                x + 3,
                                y - 2,
                                2,
                                1,
                                "#e8c24c"
                            )
                        end
                    end
                },
                "id,cena,x,nome,sub,caixa,descricao,desenho"
            ),
            __ord(
                {
                    id = "t33",
                    cena = 33,
                    x = 300,
                    nome = "Parque da Cidade",
                    sub = "Portão do parque",
                    caixa = __arrL({720, 680, 200, 86}, 4),
                    descricao = "Balanço, pista de skate, dominó dos aposentados e cachorro correndo atrás de bolinha. O lugar mais feliz da cidade. Por enquanto.",
                    desenho = function(____, P)
                        local R = P.R
                        R(
                            nil,
                            738,
                            694,
                            3,
                            32,
                            "#e8433a"
                        )
                        R(
                            nil,
                            774,
                            694,
                            3,
                            32,
                            "#e8433a"
                        )
                        R(
                            nil,
                            736,
                            692,
                            44,
                            4,
                            "#f2c94c"
                        )
                        for ____, x in __iterar((__arrL({748, 764}, 2))) do
                            R(
                                nil,
                                x,
                                696,
                                1,
                                18,
                                "#5a5e62"
                            )
                            R(
                                nil,
                                x - 3,
                                714,
                                7,
                                2,
                                "#3c6aa8"
                            )
                        end
                        R(
                            nil,
                            790,
                            694,
                            22,
                            22,
                            "#3c6aa8"
                        )
                        R(
                            nil,
                            790,
                            694,
                            22,
                            3,
                            "#6a9ad0"
                        )
                        R(
                            nil,
                            792,
                            690,
                            18,
                            5,
                            "#e8433a"
                        )
                        do
                            local k = 0
                            while k < 6 do
                                R(
                                    nil,
                                    812 + k * 3,
                                    698 + k * 4,
                                    4,
                                    3,
                                    "#f2c94c"
                                )
                                k = k + 1
                            end
                        end
                        R(
                            nil,
                            788,
                            716,
                            3,
                            12,
                            "#3c6aa8"
                        )
                        R(
                            nil,
                            809,
                            716,
                            3,
                            12,
                            "#3c6aa8"
                        )
                        R(
                            nil,
                            836,
                            690,
                            76,
                            16,
                            "#c8ccd0"
                        )
                        R(
                            nil,
                            836,
                            690,
                            76,
                            2,
                            "#e8ecef"
                        )
                        do
                            local k = 0
                            while k < 18 do
                                local x = 838 + k * 4
                                local cor = __get(
                                    __arrL({
                                        "#e8433a",
                                        "#e8833a",
                                        "#f2c94c",
                                        "#3c8a5a",
                                        "#3c6aa8",
                                        "#9a52c0"
                                    }, 6),
                                    __mod(
                                        math.floor(k / 3),
                                        6
                                    )
                                )
                                R(
                                    nil,
                                    x,
                                    694 + math.floor(math.sin(k * 1.4) * 4 + 0.5) + 2,
                                    4,
                                    5,
                                    cor
                                )
                                k = k + 1
                            end
                        end
                        R(
                            nil,
                            800,
                            732,
                            28,
                            12,
                            "#e8d8a8"
                        )
                        R(
                            nil,
                            800,
                            732,
                            28,
                            2,
                            "#a8643a"
                        )
                        for ____, ____value in __iterar((__arrL(
                            {
                                __arrL({860, 744}, 2),
                                __arrL({900, 752}, 2),
                                __arrL({736, 756}, 2),
                                __arrL({918, 720}, 2)
                            },
                            4
                        ))) do
                            local x = ____value[1]
                            local y = ____value[2]
                            P:arvore(
                                x,
                                y,
                                0.9,
                                "verde",
                                x
                            )
                        end
                        P:flores(
                            842,
                            746,
                            __arrL({"#e86a8a", "#f2c94c"}, 2)
                        )
                        pessoa(
                            nil,
                            P,
                            760,
                            740,
                            "#e8433a"
                        )
                    end
                },
                "id,cena,x,nome,sub,caixa,descricao,desenho"
            ),
            __ord(
                {
                    id = "t34",
                    cena = 34,
                    x = 300,
                    nome = "Serra do Marçal",
                    sub = "Mirante na beira da serra",
                    caixa = __arrL({0, 588, 200, 120}, 4),
                    descricao = "A cidade acaba e o mundo despenca num mar de nuvens. Quem tem coragem pula de parapente. Quem não tem, compra mel.",
                    desenho = function(____, P)
                        local R = P.R
                        for ____, x in __iterar((__arrL({30, 90}, 2))) do
                            R(
                                nil,
                                x,
                                600,
                                3,
                                60,
                                "#e8ecef"
                            )
                            R(
                                nil,
                                x - 1,
                                598,
                                5,
                                4,
                                "#d8dce0"
                            )
                        end
                        R(
                            nil,
                            110,
                            660,
                            60,
                            4,
                            "#a87a4a"
                        )
                        do
                            local k = 0
                            while k < 60 do
                                R(
                                    nil,
                                    110 + k,
                                    664,
                                    3,
                                    10,
                                    "#6a4a2a"
                                )
                                k = k + 10
                            end
                        end
                        R(
                            nil,
                            166,
                            640,
                            2,
                            22,
                            "#9aa0a6"
                        )
                        do
                            local x = 10
                            while x < 190 do
                                R(
                                    nil,
                                    x,
                                    690,
                                    4,
                                    3,
                                    "#c8ccd0"
                                )
                                x = x + 6
                            end
                        end
                        P:R(
                            40,
                            664,
                            40,
                            20,
                            "#e8833a"
                        )
                        P:R(
                            36,
                            650,
                            48,
                            10,
                            "#f2e2b8"
                        )
                        P:R(
                            36,
                            650,
                            48,
                            1,
                            "#a8643a"
                        )
                        txt(
                            nil,
                            P,
                            "MEL DA SERRA",
                            60,
                            652,
                            "#7a4a10"
                        )
                        do
                            local k = 0
                            while k < 4 do
                                P:R(
                                    44 + k * 9,
                                    676,
                                    6,
                                    7,
                                    "#e8a83a"
                                )
                                P:R(
                                    45 + k * 9,
                                    675,
                                    4,
                                    2,
                                    "#f6f6f0"
                                )
                                k = k + 1
                            end
                        end
                        P.c.globalAlpha = 0.45
                        do
                            local x = 0
                            while x < 200 do
                                P:circ(
                                    x + 9,
                                    700,
                                    12,
                                    "#ffffff",
                                    5
                                )
                                x = x + 18
                            end
                        end
                        P.c.globalAlpha = 1
                        do
                            local k = 0
                            while k < 40 do
                                P:R(
                                    40 + k,
                                    664,
                                    4,
                                    20,
                                    "#f6ead0"
                                )
                                k = k + 8
                            end
                        end
                    end
                },
                "id,cena,x,nome,sub,caixa,descricao,desenho"
            )
        },
        17
    )
    local TR2 = nil
    local RUAS2 = {}
    local function emBreve(self, P, t, lista)
        local R = P.R
        for ____, ____value in __iterar((lista)) do
            local x = ____value[1]
            local y = ____value[2]
            local b = math.floor(math.sin(t * 2 + x) * 1 + 0.5)
            local X = x - 4
            local Y = y - 22 + b
            P.c.globalAlpha = 0.35
            P:circ(
                x,
                y - 15 + b,
                9,
                "#1c1c24",
                9
            )
            P.c.globalAlpha = 1
            R(
                nil,
                X + 1,
                Y - 5,
                6,
                1,
                "#2a2a30"
            )
            R(
                nil,
                X,
                Y - 4,
                1,
                5,
                "#2a2a30"
            )
            R(
                nil,
                X + 7,
                Y - 4,
                1,
                5,
                "#2a2a30"
            )
            R(
                nil,
                X + 1,
                Y - 4,
                1,
                4,
                "#c8ccd0"
            )
            R(
                nil,
                X + 6,
                Y - 4,
                1,
                4,
                "#9aa0a6"
            )
            R(
                nil,
                X - 1,
                Y,
                10,
                9,
                "#2a2a30"
            )
            R(
                nil,
                X,
                Y + 1,
                8,
                7,
                "#8a8e96"
            )
            R(
                nil,
                X,
                Y + 1,
                8,
                1,
                "#b8bcc4"
            )
            R(
                nil,
                X + 3,
                Y + 3,
                2,
                3,
                "#2a2a30"
            )
            R(
                nil,
                X - 9,
                Y + 11,
                26,
                7,
                "#2a2a30"
            )
            R(
                nil,
                X - 8,
                Y + 12,
                24,
                5,
                "#d8d4c8"
            )
            txt(
                nil,
                P,
                "EM BREVE",
                x,
                Y + 12,
                "#4a4a52"
            )
        end
    end
    local MAPA2 = __ord(
        {
            chave = "conquista2d",
            titulo = "TÁXI DO SEU ZÉ · VITÓRIA DA CONQUISTA",
            subtitulo = "O táxi só para nas entradas. Lá dentro, é com você.",
            lajotas = __arrL({72, 48}, 2),
            botao = "IR DE TÁXI ▶",
            ilha = __ord({margem = 300, eolicas = 7, parapentes = 3, balao = true}, "margem,eolicas,parapentes,balao"),
            relevo = true,
            terreno = function(____, T)
                T:poli(
                    __arrL(
                        {
                            __arrL({-1.5, -1.5}, 2),
                            __arrL({-1.5, 3.9}, 2),
                            __arrL({2.4, 4.5}, 2),
                            __arrL({5, 3.6}, 2),
                            __arrL({7.5, 3.2}, 2),
                            __arrL({12, 4.4}, 2),
                            __arrL({18, 5.2}, 2),
                            __arrL({24, 4.6}, 2),
                            __arrL({30, 5.4}, 2),
                            __arrL({37, 4.8}, 2),
                            __arrL({44, 5.6}, 2),
                            __arrL({50, 4.9}, 2),
                            __arrL({56.5, 4.2}, 2),
                            __arrL({60.5, 4.7}, 2),
                            __arrL({64.5, 4.3}, 2),
                            __arrL({68.5, 4.9}, 2),
                            __arrL({73.5, 4.5}, 2),
                            __arrL({73.5, -1.5}, 2)
                        },
                        18
                    ),
                    {nivel = 2, tipo = "cerrado"}
                )
                T:poli(
                    __arrL(
                        {
                            __arrL({15, -1.5}, 2),
                            __arrL({16.2, 1.8}, 2),
                            __arrL({20, 2.6}, 2),
                            __arrL({23.5, 2.2}, 2),
                            __arrL({24.2, -1.5}, 2)
                        },
                        5
                    ),
                    {nivel = 3, tipo = "cerrado"}
                )
                T:poli(
                    __arrL(
                        {
                            __arrL({33, -1.5}, 2),
                            __arrL({34, 2.2}, 2),
                            __arrL({38, 3}, 2),
                            __arrL({42, 2.4}, 2),
                            __arrL({43, -1.5}, 2)
                        },
                        5
                    ),
                    {nivel = 3, tipo = "cerrado"}
                )
                T:poli(
                    __arrL(
                        {
                            __arrL({-1.5, 30}, 2),
                            __arrL({13, 30}, 2),
                            __arrL({12.6, 36.4}, 2),
                            __arrL({-1.5, 36.2}, 2)
                        },
                        4
                    ),
                    {tipo = "mata"}
                )
                T:poli(
                    __arrL(
                        {
                            __arrL({-1.5, 22.8}, 2),
                            __arrL({7, 22.4}, 2),
                            __arrL({12.4, 23.4}, 2),
                            __arrL({12.6, 27}, 2),
                            __arrL({12.2, 30.4}, 2),
                            __arrL({8, 30.2}, 2),
                            __arrL({4, 30.6}, 2),
                            __arrL({-1.5, 30.4}, 2)
                        },
                        8
                    ),
                    {nivel = 2, tipo = "mata"}
                )
                T:oval(
                    6,
                    33.6,
                    3.2,
                    2,
                    {nivel = 0}
                )
                T:ret(
                    -1.5,
                    42,
                    16,
                    7,
                    {tipo = "nuvem"}
                )
                T:poli(
                    __arrL(
                        {
                            __arrL({-1.5, 37}, 2),
                            __arrL({6, 36.6}, 2),
                            __arrL({12.6, 37.4}, 2),
                            __arrL({13, 40.4}, 2),
                            __arrL({12, 43.1}, 2),
                            __arrL({6, 42.9}, 2),
                            __arrL({-1.5, 43.3}, 2)
                        },
                        7
                    ),
                    {nivel = 3, tipo = "cerrado"}
                )
                T:retR(
                    -1,
                    9.2,
                    14.5,
                    2.6,
                    0.5,
                    {tipo = "pista"}
                )
                T:retR(
                    -1,
                    12,
                    14.2,
                    5.6,
                    0.6,
                    {tipo = "pedra"}
                )
                local lag = __arrL(
                    {
                        __arrL({27.4, 38.6}, 2),
                        __arrL({30, 36.9}, 2),
                        __arrL({35, 36.7}, 2),
                        __arrL({39.4, 38.3}, 2),
                        __arrL({40.2, 41.3}, 2),
                        __arrL({38.2, 44.2}, 2),
                        __arrL({33.5, 45}, 2),
                        __arrL({30.5, 43.6}, 2),
                        __arrL({28.2, 42.6}, 2)
                    },
                    9
                )
                T:poli(
                    __call(
                        lag,
                        "map",
                        function(____, ____bindingPattern0)
                            local y
                            local x
                            x = ____bindingPattern0[1]
                            y = ____bindingPattern0[2]
                            return __arrL({33.8 + (x - 33.8) * 1.14, 40.8 + (y - 40.8) * 1.2}, 2)
                        end
                    ),
                    {tipo = "areia"}
                )
                T:poli(lag, {nivel = 0})
                T:poli(
                    __arrL(
                        {
                            __arrL({57.5, 35.2}, 2),
                            __arrL({64, 34.6}, 2),
                            __arrL({73.5, 35}, 2),
                            __arrL({73.5, 49.5}, 2),
                            __arrL({57, 49.5}, 2),
                            __arrL({56.6, 42}, 2)
                        },
                        6
                    ),
                    {tipo = "cafe"}
                )
                T:retR(
                    60.4,
                    35.4,
                    9.2,
                    6.2,
                    0.6,
                    {tipo = "chao"}
                )
                T:retR(
                    61,
                    42.4,
                    7,
                    3,
                    0.3,
                    {tipo = "calcada"}
                )
                T:poli(
                    __arrL(
                        {
                            __arrL({28.4, 12.2}, 2),
                            __arrL({31, 11.6}, 2),
                            __arrL({37, 11.7}, 2),
                            __arrL({39.6, 12.6}, 2),
                            __arrL({39, 15}, 2),
                            __arrL({34, 15.6}, 2),
                            __arrL({29.4, 15.2}, 2)
                        },
                        7
                    ),
                    {tipo = "pedra"}
                )
                T:retR(
                    29.2,
                    22.4,
                    11.4,
                    6.2,
                    0.8,
                    {tipo = "pedra"}
                )
                T:poli(
                    __arrL(
                        {
                            __arrL({45.8, 8.6}, 2),
                            __arrL({48, 7.6}, 2),
                            __arrL({53.6, 7.8}, 2),
                            __arrL({55.2, 9.4}, 2),
                            __arrL({54.8, 13.6}, 2),
                            __arrL({50, 14.4}, 2),
                            __arrL({46.2, 13.8}, 2)
                        },
                        7
                    ),
                    {tipo = "pedra"}
                )
                T:retR(
                    55.6,
                    15.6,
                    12,
                    2.6,
                    0.4,
                    {tipo = "asfalto"}
                )
                T:retR(
                    55.4,
                    21.8,
                    10.4,
                    6.6,
                    0.6,
                    {tipo = "calcada"}
                )
                T:retR(
                    57.4,
                    0.8,
                    13.6,
                    8.2,
                    0.8,
                    {tipo = "calcada"}
                )
                T:retR(
                    45.4,
                    35.2,
                    11,
                    7,
                    0.6,
                    {tipo = "asfalto"}
                )
                T:retR(
                    14.8,
                    18.4,
                    9.4,
                    1.2,
                    0.3,
                    {tipo = "calcada"}
                )
                T:retR(
                    15.2,
                    45,
                    8,
                    4,
                    0.5,
                    {tipo = "asfalto"}
                )
                T:retR(
                    15.6,
                    23.4,
                    9.6,
                    9.2,
                    1,
                    {tipo = "chao"}
                )
                T:oval(
                    45.9,
                    20.75,
                    3.4,
                    2.6,
                    {tipo = "asfalto"}
                )
                RUAS2.av1 = T:curva(
                    __arrL(
                        {
                            __arrL({13, 20.5}, 2),
                            __arrL({20, 20.9}, 2),
                            __arrL({28, 20.2}, 2),
                            __arrL({36, 20.8}, 2),
                            __arrL({42.5, 20.6}, 2)
                        },
                        5
                    ),
                    1.9,
                    {tipo = "asfalto"}
                )
                RUAS2.av1b = T:curva(
                    __arrL(
                        {
                            __arrL({49.3, 20.7}, 2),
                            __arrL({56, 20.2}, 2),
                            __arrL({64, 20.8}, 2),
                            __arrL({73.5, 20.4}, 2)
                        },
                        4
                    ),
                    1.9,
                    {tipo = "asfalto"}
                )
                RUAS2.av2 = T:curva(
                    __arrL(
                        {
                            __arrL({44.2, 30.6}, 2),
                            __arrL({50, 30.9}, 2),
                            __arrL({57, 30.3}, 2),
                            __arrL({64, 30.8}, 2),
                            __arrL({73.5, 30.5}, 2)
                        },
                        5
                    ),
                    1.9,
                    {tipo = "asfalto"}
                )
                RUAS2.nB = T:curva(
                    __arrL(
                        {
                            __arrL({45.9, 14.6}, 2),
                            __arrL({45.9, 18.2}, 2)
                        },
                        2
                    ),
                    1.7,
                    {tipo = "asfalto"}
                )
                RUAS2.sB = T:curva(
                    __arrL(
                        {
                            __arrL({45.9, 23.3}, 2),
                            __arrL({45.2, 27}, 2),
                            __arrL({44.2, 31}, 2),
                            __arrL({43.3, 35}, 2),
                            __arrL({43.1, 40}, 2),
                            __arrL({44.2, 44}, 2),
                            __arrL({45.8, 49.5}, 2)
                        },
                        7
                    ),
                    1.8,
                    {tipo = "asfalto"}
                )
                RUAS2.A = T:curva(
                    __arrL(
                        {
                            __arrL({27.2, 8.6}, 2),
                            __arrL({26.5, 13}, 2),
                            __arrL({26.9, 20.5}, 2),
                            __arrL({26.2, 27}, 2),
                            __arrL({26.6, 31}, 2),
                            __arrL({25.6, 34.2}, 2)
                        },
                        6
                    ),
                    1.8,
                    {tipo = "asfalto"}
                )
                RUAS2.W = T:curva(
                    __arrL(
                        {
                            __arrL({13.4, 20.4}, 2),
                            __arrL({14.4, 26}, 2),
                            __arrL({14, 31}, 2),
                            __arrL({14.5, 33.6}, 2),
                            __arrL({18, 34.3}, 2),
                            __arrL({22, 34.1}, 2),
                            __arrL({25.6, 34.2}, 2)
                        },
                        7
                    ),
                    1.7,
                    {tipo = "asfalto"}
                )
                RUAS2.aero = T:curva(
                    __arrL(
                        {
                            __arrL({12.6, 14.6}, 2),
                            __arrL({15, 12.4}, 2),
                            __arrL({20, 11.9}, 2),
                            __arrL({26.6, 12.6}, 2)
                        },
                        4
                    ),
                    1.6,
                    {tipo = "asfalto"}
                )
                T:curva(
                    __arrL(
                        {
                            __arrL({12.8, 14.6}, 2),
                            __arrL({13.2, 20.4}, 2)
                        },
                        2
                    ),
                    1.6,
                    {tipo = "asfalto"}
                )
                RUAS2.C = T:curva(
                    __arrL(
                        {
                            __arrL({71, 9.2}, 2),
                            __arrL({71.4, 15}, 2),
                            __arrL({70.8, 20.4}, 2)
                        },
                        3
                    ),
                    1.6,
                    {tipo = "asfalto"}
                )
                T:curva(
                    __arrL(
                        {
                            __arrL({45, 46.5}, 2),
                            __arrL({50, 45.2}, 2),
                            __arrL({55, 46.8}, 2),
                            __arrL({58, 45.5}, 2)
                        },
                        4
                    ),
                    1,
                    {tipo = "chao"}
                )
                T:curva(
                    __arrL(
                        {
                            __arrL({3, 23}, 2),
                            __arrL({5, 26.5}, 2),
                            __arrL({9, 27.6}, 2),
                            __arrL({12, 26}, 2)
                        },
                        4
                    ),
                    1,
                    {tipo = "chao"}
                )
            end,
            chao = function(____, P, c, Tr)
                local R = P.R
                for ____, r in __iterar((Tr.ruas)) do
                    if __t(r.tipo == "asfalto" and __ge(r.larg, 1.8)) then
                        __call(
                            r.pl,
                            "forEach",
                            function(____, ____bindingPattern0, k)
                                local y
                                local x
                                x = ____bindingPattern0[1]
                                y = ____bindingPattern0[2]
                                if __mod(k, 8) < 3 then
                                    R(
                                        nil,
                                        x,
                                        y,
                                        2,
                                        1,
                                        "#f2e2a0"
                                    )
                                end
                            end
                        )
                    end
                end
                do
                    local k = 0
                    while k < 120 do
                        R(
                            nil,
                            980 + h(nil, k, 71) * 104,
                            682 + h(nil, k, 72) * 42,
                            2,
                            1,
                            if __gt(
                                h(nil, k, 73),
                                0.5
                            ) then "#5a3420" else "#7a4a2a"
                        )
                        k = k + 1
                    end
                end
            end,
            objetos = function(____, add, Tr)
                TR2 = Tr
                local caixas = caixasDe(nil, PONTOS)
                local lote = Lote(nil, Tr, caixas)
                local function ref(____, x, y, w, h, f)
                    lote:marca(x - 4, y - 4, w + 8, h + 8)
                    add(
                        nil,
                        __add(y, h),
                        f
                    )
                end
                ref(
                    nil,
                    250,
                    404,
                    150,
                    116,
                    function(____, P)
                        local R = P.R
                        do
                            local k = 0
                            while k <= 150 do
                                R(
                                    nil,
                                    250 + k,
                                    404,
                                    3,
                                    12,
                                    "#8a8e94"
                                )
                                R(
                                    nil,
                                    250 + k,
                                    404,
                                    3,
                                    1,
                                    "#c8ccd0"
                                )
                                k = k + 6
                            end
                        end
                        R(
                            nil,
                            250,
                            406,
                            150,
                            2,
                            "#6a6e74"
                        )
                        R(
                            nil,
                            250,
                            412,
                            150,
                            1,
                            "#6a6e74"
                        )
                        for ____, ____value in __iterar((__arrL(
                            {
                                __arrL({276, 470, 1}, 3),
                                __arrL({330, 490, 1.2}, 3),
                                __arrL({372, 462, 0.9}, 3)
                            },
                            3
                        ))) do
                            local x = ____value[1]
                            local y = ____value[2]
                            local s = ____value[3]
                            P:sombra(x, y + 2, 20 * s, 4)
                            P:circ(
                                x,
                                y - 6 * s,
                                20 * s,
                                "#6a5a4a",
                                10 * s
                            )
                            P:circ(
                                x - 3,
                                y - 8 * s,
                                15 * s,
                                "#8a7a6a",
                                7 * s
                            )
                            do
                                local j = 0
                                while j < 10 do
                                    R(
                                        nil,
                                        x - 14 * s + h(nil, j, x) * 28 * s,
                                        y - 14 * s + h(nil, x, j) * 12 * s,
                                        3,
                                        2,
                                        __get(
                                            __arrL({"#a85a3a", "#c8ccd0", "#3c6aa8", "#5a5e62"}, 4),
                                            __mod(j, 4)
                                        )
                                    )
                                    j = j + 1
                                end
                            end
                        end
                        R(
                            nil,
                            296,
                            430,
                            34,
                            12,
                            "#a85a3a"
                        )
                        R(
                            nil,
                            302,
                            424,
                            18,
                            7,
                            "#94503a"
                        )
                        R(
                            nil,
                            304,
                            426,
                            6,
                            4,
                            "#4a5a6a"
                        )
                        R(
                            nil,
                            298,
                            440,
                            5,
                            4,
                            "#1c1c1c"
                        )
                        R(
                            nil,
                            322,
                            440,
                            5,
                            4,
                            "#1c1c1c"
                        )
                        do
                            local k = 0
                            while k < 4 do
                                P:circ(
                                    388,
                                    508 - k * 5,
                                    6,
                                    "#1c1c1c",
                                    3
                                )
                                P:circ(
                                    388,
                                    508 - k * 5,
                                    2,
                                    "#5a5e62",
                                    1
                                )
                                k = k + 1
                            end
                        end
                        R(
                            nil,
                            352,
                            420,
                            3,
                            44,
                            "#e8a83a"
                        )
                        R(
                            nil,
                            352,
                            420,
                            40,
                            3,
                            "#e8a83a"
                        )
                        R(
                            nil,
                            348,
                            460,
                            12,
                            6,
                            "#c8962a"
                        )
                        R(
                            nil,
                            258,
                            386,
                            74,
                            13,
                            "#2a2a2a"
                        )
                        R(
                            nil,
                            259,
                            387,
                            72,
                            11,
                            "#e8c24c"
                        )
                        txt(
                            nil,
                            P,
                            "FERRO-VELHO",
                            295,
                            390,
                            "#2a1a10"
                        )
                        R(
                            nil,
                            266,
                            399,
                            2,
                            6,
                            "#5a5e62"
                        )
                        R(
                            nil,
                            322,
                            399,
                            2,
                            6,
                            "#5a5e62"
                        )
                    end
                )
                ref(
                    nil,
                    258,
                    354,
                    40,
                    40,
                    function(____, P) return P:casa(
                        262,
                        360,
                        34,
                        34,
                        {
                            telhado = "#9a4a34",
                            parede = "#f2c4dc",
                            madeira = false,
                            janelas = __arrL({4, 24}, 2),
                            porta = 13
                        }
                    ) end
                )
                ref(
                    nil,
                    796,
                    262,
                    60,
                    42,
                    function(____, P)
                        local R = P.R
                        R(
                            nil,
                            800,
                            266,
                            2,
                            26,
                            "#5a5e62"
                        )
                        R(
                            nil,
                            796,
                            258,
                            56,
                            10,
                            "#1c1c1c"
                        )
                        R(
                            nil,
                            797,
                            259,
                            54,
                            8,
                            "#e8833a"
                        )
                        txt(
                            nil,
                            P,
                            "MOTOTAXI",
                            824,
                            261,
                            "#1c1c1c"
                        )
                        do
                            local k = 0
                            while k < 3 do
                                local x = 812 + k * 13
                                local y = 296
                                R(
                                    nil,
                                    x - 5,
                                    y,
                                    11,
                                    1,
                                    "rgba(0,0,0,.3)"
                                )
                                R(
                                    nil,
                                    x - 5,
                                    y - 4,
                                    10,
                                    3,
                                    "#2a2a2a"
                                )
                                R(
                                    nil,
                                    x - 5,
                                    y - 3,
                                    3,
                                    3,
                                    "#1c1c1c"
                                )
                                R(
                                    nil,
                                    x + 3,
                                    y - 3,
                                    3,
                                    3,
                                    "#1c1c1c"
                                )
                                R(
                                    nil,
                                    x - 2,
                                    y - 7,
                                    6,
                                    3,
                                    __get(
                                        __arrL({"#c43c3a", "#3c6aa8", "#e8c24c"}, 3),
                                        k
                                    )
                                )
                                k = k + 1
                            end
                        end
                        pecas:pessoaG(
                            P,
                            850,
                            298,
                            "#e8833a",
                            "#a8704a",
                            "#1c1c1c"
                        )
                        P:R(
                            847,
                            287,
                            7,
                            3,
                            "#1c1c1c"
                        )
                    end
                )
                ref(
                    nil,
                    556,
                    466,
                    66,
                    52,
                    function(____, P)
                        P:casa(
                            560,
                            470,
                            58,
                            44,
                            {
                                telhado = "#c8846a",
                                parede = "#f6ead0",
                                madeira = false,
                                janelas = __arrL({6}, 1),
                                porta = 36
                            }
                        )
                        local R = P.R
                        R(
                            nil,
                            564,
                            490,
                            28,
                            9,
                            "#7a4a2a"
                        )
                        txt(
                            nil,
                            P,
                            "BISCOITO",
                            578,
                            492,
                            "#ffe39a"
                        )
                        P:circ(
                            610,
                            470,
                            7,
                            "#e8d4a0",
                            7
                        )
                        P:circ(
                            610,
                            470,
                            3,
                            "#c8a46a",
                            3
                        )
                    end
                )
                ref(
                    nil,
                    494,
                    470,
                    34,
                    28,
                    function(____, P)
                        local R = P.R
                        local x = 496
                        local y = 494
                        P:sombra(x + 14, y, 16, 3)
                        R(
                            nil,
                            x,
                            y - 12,
                            28,
                            10,
                            "#8a5a36"
                        )
                        R(
                            nil,
                            x,
                            y - 12,
                            28,
                            2,
                            "#a87a4a"
                        )
                        do
                            local k = 0
                            while k < 6 do
                                R(
                                    nil,
                                    x + 2 + k * 4,
                                    y - 18 + __mod(k, 2),
                                    3,
                                    6,
                                    __get(
                                        __arrL({"#7a3a2a", "#3c8a5a", "#c8962a", "#5a2a5a"}, 4),
                                        __mod(k, 4)
                                    )
                                )
                                R(
                                    nil,
                                    x + 3 + k * 4,
                                    y - 20 + __mod(k, 2),
                                    1,
                                    2,
                                    "#dde0e3"
                                )
                                k = k + 1
                            end
                        end
                        P:circ(x + 4, y - 1, 3, "#3a2414")
                        P:circ(x + 24, y - 1, 3, "#3a2414")
                        R(
                            nil,
                            x - 6,
                            y - 10,
                            6,
                            2,
                            "#6a4228"
                        )
                    end
                )
                ref(
                    nil,
                    1040,
                    272,
                    30,
                    30,
                    function(____, P)
                        local R = P.R
                        P.c.strokeStyle = "#f6f6f0"
                        P.c.lineWidth = 2
                        P.c:beginPath()
                        P.c:arc(
                            1046,
                            280,
                            6,
                            0,
                            math.pi * 2
                        )
                        P.c:stroke()
                        P.c.lineWidth = 1
                        R(
                            nil,
                            1045,
                            286,
                            2,
                            14,
                            "#5a5e62"
                        )
                        R(
                            nil,
                            1041,
                            299,
                            10,
                            1,
                            "#5a5e62"
                        )
                        pecas:pessoaG(
                            P,
                            1060,
                            300,
                            "#f29ab0",
                            "#c99068",
                            "#e8c24c"
                        )
                        R(
                            nil,
                            1056,
                            288,
                            3,
                            4,
                            "#1c1c1c"
                        )
                    end
                )
                ref(
                    nil,
                    1066,
                    356,
                    74,
                    60,
                    function(____, P)
                        P:predio(
                            1070,
                            360,
                            66,
                            52,
                            {parede = "#2a2a3a", topo = "#4a4a5a", fachada = 26, caixa = false}
                        )
                        local R = P.R
                        R(
                            nil,
                            1084,
                            384,
                            38,
                            10,
                            "#1c1c1c"
                        )
                    end
                )
                ref(
                    nil,
                    828,
                    518,
                    52,
                    40,
                    function(____, P)
                        local R = P.R
                        R(
                            nil,
                            838,
                            520,
                            3,
                            34,
                            "#5a5e62"
                        )
                        R(
                            nil,
                            838,
                            520,
                            22,
                            3,
                            "#5a5e62"
                        )
                        R(
                            nil,
                            856,
                            523,
                            1,
                            6,
                            "#2a2a2a"
                        )
                        R(
                            nil,
                            852,
                            529,
                            9,
                            16,
                            "#c43c3a"
                        )
                        R(
                            nil,
                            852,
                            529,
                            9,
                            2,
                            "#e8635a"
                        )
                        R(
                            nil,
                            830,
                            553,
                            30,
                            2,
                            "rgba(0,0,0,.2)"
                        )
                    end
                )
                ref(
                    nil,
                    1100,
                    680,
                    46,
                    66,
                    function(____, P)
                        local R = P.R
                        do
                            local k = 0
                            while k < 6 do
                                local x = 1104 + __mod(k, 3) * 12
                                local y = 744 - math.floor(k / 3) * 9
                                R(
                                    nil,
                                    x,
                                    y - 9,
                                    12,
                                    10,
                                    "#c8b48a"
                                )
                                R(
                                    nil,
                                    x,
                                    y - 9,
                                    12,
                                    1,
                                    "#e8d8b0"
                                )
                                txt(
                                    nil,
                                    P,
                                    "B",
                                    x + 6,
                                    y - 7,
                                    "#7a4a2a"
                                )
                                k = k + 1
                            end
                        end
                        R(
                            nil,
                            1122,
                            694,
                            2,
                            30,
                            "#5a3820"
                        )
                        R(
                            nil,
                            1108,
                            672,
                            30,
                            22,
                            "#2a1a10"
                        )
                        R(
                            nil,
                            1110,
                            674,
                            26,
                            18,
                            "#f6ead0"
                        )
                        R(
                            nil,
                            1116,
                            678,
                            12,
                            10,
                            "#f2f2ee"
                        )
                        R(
                            nil,
                            1128,
                            680,
                            3,
                            5,
                            "#f2f2ee"
                        )
                        R(
                            nil,
                            1117,
                            680,
                            10,
                            3,
                            "#5a3420"
                        )
                        txt(
                            nil,
                            P,
                            "BARAO",
                            1123,
                            666,
                            "#ffe39a",
                            {sombra = "#2a1a10"}
                        )
                    end
                )
                ref(
                    nil,
                    648,
                    202,
                    22,
                    34,
                    function(____, P)
                        local R = P.R
                        R(
                            nil,
                            658,
                            210,
                            2,
                            24,
                            "#5a5e62"
                        )
                        R(
                            nil,
                            648,
                            196,
                            22,
                            14,
                            "#1c1c1c"
                        )
                        P:sombra(660, 234, 6, 2)
                    end
                )
                ref(
                    nil,
                    654,
                    64,
                    56,
                    58,
                    function(____, P)
                        local R = P.R
                        for ____, x in __iterar((__arrL({664, 696}, 2))) do
                            R(
                                nil,
                                x,
                                96,
                                2,
                                26,
                                "#c8ccd0"
                            )
                        end
                        R(
                            nil,
                            662,
                            120,
                            38,
                            2,
                            "#8a8e94"
                        )
                        P:sombra(681, 122, 22, 3)
                    end
                )
                ref(
                    nil,
                    42,
                    196,
                    1,
                    1,
                    function()
                    end
                )
                for ____, ____value in __iterar((__arrL(
                    {
                        __arrL({
                            586,
                            304,
                            "SMART FAT",
                            "#1c2a3a",
                            "#7af0c8"
                        }, 5),
                        __arrL({
                            988,
                            552,
                            "PAGUE MAIS",
                            "#c43c3a",
                            "#fff6dc"
                        }, 5),
                        __arrL({
                            118,
                            332,
                            "CASAS BAIXA",
                            "#2c5a9e",
                            "#ffe39a"
                        }, 5)
                    },
                    3
                ))) do
                    local x = ____value[1]
                    local y = ____value[2]
                    local s = ____value[3]
                    local bg = ____value[4]
                    local fg = ____value[5]
                    ref(
                        nil,
                        x,
                        y - 28,
                        60,
                        30,
                        function(____, P) return pecas:outdoor(
                            P,
                            x,
                            y,
                            s,
                            bg,
                            fg
                        ) end
                    )
                end
                for ____, ____value in __iterar((__arrL(
                    {
                        __arrL({180, 52}, 2),
                        __arrL({300, 34}, 2),
                        __arrL({880, 52}, 2)
                    },
                    3
                ))) do
                    local x = ____value[1]
                    local y = ____value[2]
                    ref(
                        nil,
                        x - 8,
                        y - 50,
                        16,
                        52,
                        function(____, P) return pecas:antena(P, x, y) end
                    )
                end
                for ____, ____value in __iterar((caixas)) do
                    local bx = ____value[1]
                    local by = ____value[2]
                    local bw = ____value[3]
                    local bh = ____value[4]
                    for ____, ____value in __iterar((__arrL(
                        {
                            __arrL({bw - 8, bh + 12}, 2),
                            __arrL({8, bh + 12}, 2),
                            __arrL({bw + 10, bh - 4}, 2),
                            __arrL({-10, bh - 4}, 2)
                        },
                        4
                    ))) do
                        local dx = ____value[1]
                        local dy = ____value[2]
                        local x = __add(bx, dx)
                        local y = __add(by, dy)
                        if __t(lote:ponto(
                            x,
                            y,
                            5,
                            function(____, a, b) return __gt(
                                Tr:nivelEm(a, b),
                                0
                            ) and __lt(
                                __get(
                                    Tr.px.wd,
                                    math.floor(b + 0.5) * Tr.px.W + math.floor(a + 0.5)
                                ),
                                0
                            ) end
                        )) then
                            add(
                                nil,
                                y,
                                function(____, P) return pecas:placaTaxi(P, x, y) end
                            )
                            break
                        end
                    end
                end
                local paredes = __arrL({
                    "#ebe8de",
                    "#e0d6c2",
                    "#dfe6ea",
                    "#e8dcc8",
                    "#f2e2a8",
                    "#d8d0c0",
                    "#f0ece4"
                }, 7)
                do
                    local i = 0
                    while i < 4000 do
                        local alto = __gt(
                            h(nil, i, 81),
                            0.35
                        )
                        local w = if __t(alto) then 30 + math.floor(h(nil, i, 82) * 3) * 6 else 30
                        local hh = if __t(alto) then 40 + math.floor(h(nil, i, 83) * 4) * 6 else 32
                        local x = 210 + h(nil, i, 84) * 930
                        local y = 96 + h(nil, i, 85) * 470
                        if Tr:nivelEm(x, y + hh) ~= 1 then
                            continue
                        end
                        if not __t(lote:area(x - 3, y - 2, w + 8, hh + 8)) then
                            continue
                        end
                        local cor = __get(
                            paredes,
                            __mod(
                                i,
                                __len(paredes)
                            )
                        )
                        add(
                            nil,
                            y + hh,
                            function(____, P) return if __t(alto) then P:predio(
                                x,
                                y,
                                w,
                                hh,
                                {
                                    parede = cor,
                                    fachada = 18 + __mod(i, 3) * 6,
                                    porta = __mod(i, 2) == 0,
                                    faixa = if __mod(i, 4) == 0 then "#c8a46a" else nil
                                }
                            ) else P:casa(
                                x,
                                y,
                                w,
                                hh,
                                {
                                    telhado = __get(
                                        __arrL({"#b8644a", "#9a4a34", "#c8544a"}, 3),
                                        __mod(i, 3)
                                    ),
                                    parede = cor,
                                    madeira = false,
                                    janelas = __arrL({4, 22}, 2),
                                    porta = 13
                                }
                            ) end
                        )
                        i = i + 1
                    end
                end
                local cerrado = tipoEh(nil, Tr, "cerrado")
                do
                    local i = 0
                    while i < 260 do
                        local x = h(nil, i, 91) * 1150
                        local y = h(nil, i, 92) * 768
                        if not __t(lote:ponto(x, y, 6, cerrado)) then
                            continue
                        end
                        local k = h(nil, i, 93)
                        add(
                            nil,
                            y,
                            function(____, P) return if __gt(k, 0.6) then pecas:cacto(P, x, y) else if __gt(k, 0.35) then P:pedra(x, y) else P:arbusto(x, y, i, if __gt(k, 0.2) then "#f2c94c" else nil) end
                        )
                        i = i + 1
                    end
                end
                do
                    local i = 0
                    while i < 900 do
                        local x = 4 + h(nil, i, 101) * 1144
                        local y = 8 + h(nil, i, 102) * 756
                        if not __t(lote:ponto(x, y, 8)) then
                            continue
                        end
                        local tp = Tr:tipoEm(x, y)
                        local k = h(nil, i, 103)
                        if tp == "mata" then
                            add(
                                nil,
                                y,
                                function(____, P) return if __gt(k, 0.75) then P:eucalipto(x, y, 1, i) else P:arvore(
                                    x,
                                    y,
                                    0.9 + k * 0.5,
                                    if __gt(k, 0.4) then "escura" else "verde",
                                    i
                                ) end
                            )
                        else
                            local ____t_87 = __t
                            local ____t_86 = __t
                            local ____temp_85 = y > 660 and x > 700
                            __O[626] = ____temp_85
                            if ____t_87(if ____t_86(____temp_85) then x < 940 else __O[626]) then
                                add(
                                    nil,
                                    y,
                                    function(____, P) return if __gt(k, 0.5) then P:pinheiro(x, y, 1, i) else P:arvore(
                                        x,
                                        y,
                                        0.9,
                                        "verde",
                                        i
                                    ) end
                                )
                            elseif __t(x > 900 and y > 540) then
                                if __gt(k, 0.5) then
                                    continue
                                end
                                add(
                                    nil,
                                    y,
                                    function(____, P) return P:eucalipto(x, y, 0.9 + k * 0.3, i) end
                                )
                            else
                                if __gt(k, 0.5) then
                                    continue
                                end
                                add(
                                    nil,
                                    y,
                                    function(____, P) return if __gt(k, 0.38) then P:arvore(
                                        x,
                                        y,
                                        0.9,
                                        "roxa",
                                        i
                                    ) else if __gt(k, 0.3) then P:arvore(
                                        x,
                                        y,
                                        0.9,
                                        "amarela",
                                        i
                                    ) else P:arvore(
                                        x,
                                        y,
                                        0.8 + k * 0.6,
                                        "verde",
                                        i
                                    ) end
                                )
                            end
                        end
                        i = i + 1
                    end
                end
                for ____, pl in __iterar((__arrL({RUAS2.av1, RUAS2.av1b, RUAS2.av2, RUAS2.A}, 4))) do
                    do
                        local k = 12
                        while __lt(
                            k,
                            __len(pl)
                        ) do
                            local x, y = table.unpack(
                                __get(
                                    faixa(nil, pl, 22, false),
                                    k
                                ),
                                1,
                                2
                            )
                            if __t(lote:ponto(x, y, 4)) then
                                add(
                                    nil,
                                    y,
                                    function(____, P) return P:poste(x - 2, y) end
                                )
                            end
                            k = k + 36
                        end
                    end
                end
            end,
            animarChao = function(____, P, t)
                local R = P.R
                do
                    local k = 0
                    while k < 12 do
                        local y = 486 + __mod(t * 46 + k * 7, 48)
                        R(
                            nil,
                            90 + __mod(k, 4) * 4,
                            y,
                            2,
                            5,
                            if __t(__mod(k, 3)) then "#e2f4ff" else "#9fd0f0"
                        )
                        k = k + 1
                    end
                end
                do
                    local k = 0
                    while k < 5 do
                        local a = t * 3 + k
                        P.c.globalAlpha = 0.6
                        P:circ(
                            98 + math.cos(a) * 8,
                            536 + math.sin(a) * 2,
                            3,
                            "#ffffff",
                            1
                        )
                        P.c.globalAlpha = 1
                        k = k + 1
                    end
                end
                do
                    local k = 0
                    while k < 9 do
                        local x = __mod(t * 6 + k * 34, 240) - 20
                        local y = 742 + __mod(k, 3) * 9
                        P.c.globalAlpha = 0.75
                        P:circ(
                            x,
                            y,
                            16,
                            "#ffffff",
                            5
                        )
                        P.c.globalAlpha = 1
                        k = k + 1
                    end
                end
            end,
            animar = function(____, P, t)
                local R = P.R
                emBreve(
                    nil,
                    P,
                    t,
                    __arrL(
                        {
                            __arrL({295, 384, "FERRO-VELHO"}, 3),
                            __arrL({578, 486, "BISCOITO"}, 3),
                            __arrL({824, 255, "MOTOTÁXI"}, 3)
                        },
                        3
                    )
                )
                naRua(
                    nil,
                    P,
                    t,
                    faixa(nil, RUAS2.av1, -5, false),
                    3,
                    __arrL({"#c43c3a", "#3c6aa8", "#f2f2ee"}, 3),
                    26
                )
                naRua(
                    nil,
                    P,
                    t,
                    faixa(nil, RUAS2.av1, 5, true),
                    2,
                    __arrL({"#e8c24c", "#2a2a2a"}, 2),
                    24,
                    0.4,
                    function(____, j) return if j == 0 then "taxi" else nil end
                )
                naRua(
                    nil,
                    P,
                    t,
                    faixa(nil, RUAS2.av2, 5, true),
                    2,
                    __arrL({"#2c5a9e", "#c43c3a", "#3c8a5a"}, 3),
                    18,
                    0.2,
                    "bus"
                )
                naRua(
                    nil,
                    P,
                    t,
                    faixa(nil, RUAS2.av2, -5, false),
                    2,
                    __arrL({"#f2f2ee", "#7a3a8a"}, 2),
                    24,
                    0.6
                )
                naRua(
                    nil,
                    P,
                    t,
                    RUAS2.A,
                    2,
                    __arrL({"#f2f2ee", "#c43c3a"}, 2),
                    20,
                    0.1
                )
                naRua(
                    nil,
                    P,
                    t,
                    __call(
                        __arr(__TS__Spread(__iter(RUAS2.sB))),
                        "reverse"
                    ),
                    2,
                    __arrL({"#e8c24c", "#3c6aa8"}, 2),
                    20,
                    0.5,
                    function(____, j) return if j == 0 then "taxi" else nil end
                )
                naRua(
                    nil,
                    P,
                    t,
                    RUAS2.W,
                    1,
                    __arrL({"#3c8a5a"}, 1),
                    18,
                    0.3
                )
                naRua(
                    nil,
                    P,
                    t,
                    RUAS2.aero,
                    1,
                    __arrL({"#e8c24c"}, 1),
                    16,
                    0.2,
                    "taxi"
                )
                do
                    local k = 0
                    while k < 4 do
                        local a = t * 1.1 + k * 1.57
                        local x = 734 + math.cos(a) * 46
                        local y = 334 + math.sin(a) * 30
                        veiculo(
                            nil,
                            P,
                            x,
                            y,
                            __get(
                                __arrL({"#c43c3a", "#e8833a", "#3c6aa8", "#e8c24c"}, 4),
                                k
                            ),
                            a + math.pi / 2,
                            "moto"
                        )
                        k = k + 1
                    end
                end
                do
                    local fila = A:trilho(faixa(nil, RUAS2.av1b, -5, false))
                    do
                        local k = 0
                        while k < 7 do
                            local p = fila:em(0.05 + k * 0.055)
                            veiculo(
                                nil,
                                P,
                                p.x,
                                p.y + 3,
                                __get(
                                    __arrL({
                                        "#f2f2ee",
                                        "#c43c3a",
                                        "#3c6aa8",
                                        "#2a2a2a",
                                        "#3c8a5a",
                                        "#e8c24c",
                                        "#7a3a8a"
                                    }, 7),
                                    k
                                ),
                                0
                            )
                            if __t(__mod(
                                math.floor(t * 2 + k),
                                2
                            )) then
                                R(
                                    nil,
                                    p.x - 9,
                                    p.y - 1,
                                    1,
                                    2,
                                    "#ff3a3a"
                                )
                            end
                            k = k + 1
                        end
                    end
                    local q = __mod(
                        math.floor(t / 1.6),
                        7
                    )
                    local p = fila:em(0.05 + q * 0.055)
                    local b = __mod(t / 1.6, 1)
                    if b < 0.7 then
                        R(
                            nil,
                            p.x - 12,
                            p.y - 26,
                            26,
                            10,
                            "#fff6dc"
                        )
                        R(
                            nil,
                            p.x - 12,
                            p.y - 26,
                            26,
                            1,
                            "#2a2a2a"
                        )
                        R(
                            nil,
                            p.x - 12,
                            p.y - 17,
                            26,
                            1,
                            "#2a2a2a"
                        )
                        R(
                            nil,
                            p.x - 2,
                            p.y - 16,
                            3,
                            3,
                            "#fff6dc"
                        )
                        txt(
                            nil,
                            P,
                            if __t(__mod(q, 2)) then "BIII!" else "FOOM!",
                            p.x + 1,
                            p.y - 24,
                            "#c43c3a"
                        )
                    end
                end
                do
                    local c = __mod(t, 18) / 18
                    if c < 0.55 then
                        local u = c / 0.55
                        local x = 10 + u * u * 260
                        local sobe = math.max(0, u - 0.45) * 120
                        local y = 172 - sobe
                        P.c.globalAlpha = 0.25
                        P:circ(
                            x + 4,
                            174,
                            12,
                            "#000",
                            2
                        )
                        P.c.globalAlpha = 1
                        R(
                            nil,
                            x - 12,
                            y - 4,
                            26,
                            6,
                            "#f2f4f6"
                        )
                        R(
                            nil,
                            x - 12,
                            y - 1,
                            26,
                            1,
                            "#c9ced2"
                        )
                        R(
                            nil,
                            x - 14,
                            y - 10,
                            5,
                            7,
                            "#3c6aa8"
                        )
                        R(
                            nil,
                            x - 2,
                            y - 2,
                            10,
                            3,
                            "#e8ecef"
                        )
                        R(
                            nil,
                            x + 12,
                            y - 3,
                            3,
                            3,
                            "#9fc4d0"
                        )
                        do
                            local k = 0
                            while k < 5 do
                                R(
                                    nil,
                                    x - 6 + k * 3,
                                    y - 3,
                                    2,
                                    1,
                                    "#3c4a5a"
                                )
                                k = k + 1
                            end
                        end
                    end
                end
                fumaca(
                    nil,
                    P,
                    1066,
                    576,
                    t
                )
                do
                    local k = 0
                    while k < 5 do
                        local u = __mod(t * 0.04 + k / 5, 1)
                        pessoa(
                            nil,
                            P,
                            470 + u * 170,
                            448 + __mod(k, 2) * 10,
                            __get(
                                __arrL({
                                    "#e86a8a",
                                    "#3c6aa8",
                                    "#f2c94c",
                                    "#7a3a8a",
                                    "#3c8a5a"
                                }, 5),
                                k
                            ),
                            t
                        )
                        k = k + 1
                    end
                end
                do
                    local k = 0
                    while k < 4 do
                        local u = __mod(t * 0.05 + k / 4, 1)
                        pessoa(
                            nil,
                            P,
                            936 + u * 190,
                            140 + __mod(k, 2) * 4,
                            __get(
                                __arrL({"#3c6aa8", "#c43c3a", "#3c8a5a", "#f2c94c"}, 4),
                                k
                            ),
                            t
                        )
                        R(
                            nil,
                            936 + u * 190 + 2,
                            133 + __mod(k, 2) * 4,
                            3,
                            3,
                            "#f6ead0"
                        )
                        k = k + 1
                    end
                end
                do
                    local a = math.sin(t * 2.4) * 0.6
                    R(
                        nil,
                        760 + math.sin(a) * 10 - 3,
                        712 + math.cos(a) * 6,
                        7,
                        2,
                        "#3a3a36"
                    )
                    pessoa(
                        nil,
                        P,
                        760 + math.sin(a) * 10,
                        712 + math.cos(a) * 6,
                        "#e86a8a",
                        0,
                        false
                    )
                    local u = __mod(t * 0.3, 1)
                    local bx = 840 + u * 60
                    local d = math.abs(math.sin(u * math.pi * 3)) * 6
                    R(
                        nil,
                        bx,
                        748 - d,
                        3,
                        3,
                        "#f2c94c"
                    )
                    R(
                        nil,
                        bx - 12,
                        748,
                        8,
                        4,
                        "#c8a46a"
                    )
                    R(
                        nil,
                        bx - 6,
                        746,
                        3,
                        3,
                        "#c8a46a"
                    )
                    R(
                        nil,
                        bx - 13,
                        746,
                        2,
                        2,
                        "#c8a46a"
                    )
                end
                for ____, x in __iterar((__arrL({30, 90}, 2))) do
                    do
                        local k = 0
                        while k < 3 do
                            local a = t * 3 + k * 2.1 + x
                            P.c.strokeStyle = "#f2f4f6"
                            P.c.lineWidth = 2
                            P.c:beginPath()
                            P.c:moveTo(x + 1, 600)
                            P.c:lineTo(
                                x + 1 + math.cos(a) * 14,
                                600 + math.sin(a) * 14
                            )
                            P.c:stroke()
                            k = k + 1
                        end
                    end
                end
                P.c.lineWidth = 1
                do
                    local u = __mod(t * 0.12, 1)
                    local x = 168 + u * 120
                    local y = 640 + u * 80 - math.sin(u * 6) * 6
                    do
                        local k = -5
                        while k <= 5 do
                            R(
                                nil,
                                x + k * 2,
                                y - 10 - math.floor(math.sqrt(1 - (k / 6) ^ 2) * 3 + 0.5),
                                2,
                                2,
                                if __t(__mod(k, 2)) then "#3c8ad8" else "#f2c94c"
                            )
                            k = k + 1
                        end
                    end
                    R(
                        nil,
                        x - 1,
                        y - 2,
                        3,
                        4,
                        "#c43c3a"
                    )
                end
                do
                    local k = 0
                    while k < 3 do
                        local u = __mod(t * 0.03 + k / 3, 1)
                        local a = u * math.pi * 2
                        local x = 33 * TS + math.cos(a) * 70
                        local y = 41 * TS + math.sin(a) * 36 - 4
                        R(
                            nil,
                            x,
                            y,
                            8,
                            4,
                            "#f6f6f0"
                        )
                        R(
                            nil,
                            x + 6,
                            y - 4,
                            2,
                            5,
                            "#f6f6f0"
                        )
                        R(
                            nil,
                            x + 7,
                            y - 5,
                            3,
                            2,
                            "#f6f6f0"
                        )
                        R(
                            nil,
                            x + 9,
                            y - 4,
                            1,
                            1,
                            "#f08a24"
                        )
                        R(
                            nil,
                            x + 1,
                            y + 4,
                            8,
                            1,
                            "#9fd0f0"
                        )
                        k = k + 1
                    end
                end
                do
                    local k = 0
                    while k < 40 do
                        if math.sin(t * 6 + k) > 0.5 then
                            R(
                                nil,
                                304 + math.cos(k / 40 * math.pi * 2) * 70,
                                628 + math.sin(k / 40 * math.pi * 2) * 46,
                                3,
                                3,
                                "#ffffff"
                            )
                        end
                        k = k + 1
                    end
                end
                do
                    local x = 452
                    local y = 640
                    local g = __mod(
                        math.floor(t * 2),
                        5
                    ) == 0
                    pessoa(
                        nil,
                        P,
                        x,
                        y,
                        "#3c8a5a",
                        0,
                        false
                    )
                    P:circ(
                        x + 6,
                        y - 2,
                        4,
                        "#7a5a3a",
                        1
                    )
                    if __t(g) then
                        R(
                            nil,
                            x + 5,
                            y - 4,
                            2,
                            2,
                            "#ffe23a"
                        )
                        R(
                            nil,
                            x + 4,
                            y - 6,
                            1,
                            1,
                            "#ffffff"
                        )
                    end
                end
                for ____, ____value in __iterar((__arrL(
                    {
                        __arrL({620, 610}, 2),
                        __arrL({600, 700}, 2)
                    },
                    2
                ))) do
                    local x = ____value[1]
                    local y = ____value[2]
                    R(
                        nil,
                        x,
                        y - 8,
                        3,
                        5,
                        "#f6f6f0"
                    )
                    R(
                        nil,
                        x + 1,
                        y - 11,
                        2,
                        3,
                        "#f6f6f0"
                    )
                    R(
                        nil,
                        x + 3,
                        y - 10,
                        3,
                        1,
                        "#e8c24c"
                    )
                    R(
                        nil,
                        x,
                        y - 3,
                        1,
                        4,
                        "#2a2a2a"
                    )
                    R(
                        nil,
                        x + 2,
                        y - 3,
                        1,
                        4,
                        "#2a2a2a"
                    )
                end
                do
                    local k = 0
                    while k < 3 do
                        local u = __mod(t * 0.25 + k / 3, 1)
                        local x = 40 + k * 50 + u * 30
                        local y = 420 + k * 20 - math.abs(math.sin(u * math.pi * 2)) * 14
                        R(
                            nil,
                            x,
                            y - 4,
                            4,
                            3,
                            "#8a7a6a"
                        )
                        R(
                            nil,
                            x + 3,
                            y - 6,
                            3,
                            3,
                            "#a89a88"
                        )
                        R(
                            nil,
                            x + 3,
                            y - 7,
                            1,
                            1,
                            "#f6f6f0"
                        )
                        R(
                            nil,
                            x + 5,
                            y - 7,
                            1,
                            1,
                            "#f6f6f0"
                        )
                        R(
                            nil,
                            x - 3,
                            y - 3 + math.floor(math.sin(t * 4 + k) + 0.5),
                            3,
                            1,
                            "#5a4a3a"
                        )
                        k = k + 1
                    end
                end
                do
                    local q = __mod(t / 2.2, 1)
                    local fr = __get(
                        __arrL({"PSIU", "JURA?", "SABIA?"}, 3),
                        __mod(
                            math.floor(t / 2.2),
                            3
                        )
                    )
                    R(
                        nil,
                        276,
                        372,
                        6,
                        6,
                        "#3a5a8a"
                    )
                    R(
                        nil,
                        277,
                        373,
                        4,
                        4,
                        "#c99068"
                    )
                    if q < 0.8 then
                        local y = 352 - q * 8
                        R(
                            nil,
                            266,
                            y - 9,
                            30,
                            10,
                            "#fff6dc"
                        )
                        R(
                            nil,
                            266,
                            y - 9,
                            30,
                            1,
                            "#2a2a2a"
                        )
                        R(
                            nil,
                            266,
                            y,
                            30,
                            1,
                            "#2a2a2a"
                        )
                        R(
                            nil,
                            278,
                            y + 1,
                            3,
                            3,
                            "#fff6dc"
                        )
                        txt(
                            nil,
                            P,
                            fr,
                            281,
                            y - 7,
                            "#7a2a5a"
                        )
                    end
                end
                do
                    pecas:pessoaG(
                        P,
                        262,
                        314,
                        "#7a4a8a",
                        "#c99068",
                        "#d0d0d0"
                    )
                    R(
                        nil,
                        266,
                        304,
                        5,
                        3,
                        "#3c8a5a"
                    )
                    do
                        local k = 0
                        while k < 3 do
                            local q = __mod(t * 2 + k / 3, 1)
                            R(
                                nil,
                                272 + q * 3,
                                305 + q * 8,
                                1,
                                2,
                                "#9fd0f0"
                            )
                            k = k + 1
                        end
                    end
                    R(
                        nil,
                        276,
                        310,
                        8,
                        5,
                        "#a8643a"
                    )
                    R(
                        nil,
                        277,
                        306,
                        2,
                        4,
                        "#e86a8a"
                    )
                    R(
                        nil,
                        281,
                        307,
                        2,
                        3,
                        "#f2c94c"
                    )
                    P.c.strokeStyle = "#4a4a4a"
                    P.c:beginPath()
                    P.c:moveTo(284, 236)
                    P.c:lineTo(334, 238)
                    P.c:stroke()
                    do
                        local k = 0
                        while k < 5 do
                            R(
                                nil,
                                287 + k * 9,
                                237,
                                5,
                                6 + math.floor(math.sin(t * 3 + k) + 0.5),
                                __get(
                                    __arrL({
                                        "#e86a8a",
                                        "#f6f6f0",
                                        "#3c6aa8",
                                        "#f2c94c",
                                        "#3c8a5a"
                                    }, 5),
                                    k
                                )
                            )
                            k = k + 1
                        end
                    end
                end
                do
                    local k = 0
                    while k < 4 do
                        local q = __mod(t * 0.5 + k / 4, 1)
                        P.c.globalAlpha = (1 - q) * 0.6
                        P:circ(
                            590 + math.sin(t + k) * 4,
                            470 - q * 22,
                            2 + q * 3,
                            "#ffffff"
                        )
                        k = k + 1
                    end
                end
                P.c.globalAlpha = 1
                do
                    local f = __mod(t, 2.6) < 0.12
                    if __t(f) then
                        P.c.globalAlpha = 0.7
                        P:circ(
                            1057,
                            290,
                            12,
                            "#ffffff",
                            10
                        )
                        P.c.globalAlpha = 1
                        do
                            local k = 0
                            while k < 6 do
                                local a = k * 1.05
                                R(
                                    nil,
                                    1057 + math.cos(a) * 14,
                                    290 + math.sin(a) * 10,
                                    2,
                                    2,
                                    "#fff6a0"
                                )
                                k = k + 1
                            end
                        end
                    end
                end
                do
                    local on = __mod(
                        math.floor(t * 3),
                        4
                    ) ~= 0
                    txt(
                        nil,
                        P,
                        "LAN",
                        1103,
                        386,
                        if __t(on) then "#3ae0ff" else "#1c4a5a",
                        {s = 2}
                    )
                    do
                        local k = 0
                        while k < 4 do
                            R(
                                nil,
                                1076 + k * 15,
                                400,
                                10,
                                6,
                                if __t(__mod(
                                    math.floor(t * 5 + k),
                                    3
                                )) then "#2a6ae8" else "#5ae0ff"
                            )
                            k = k + 1
                        end
                    end
                end
                do
                    local lat = __mod(
                        math.floor(t * 2),
                        3
                    ) == 0
                    local x = 866 + math.sin(t * 0.8) * 6
                    R(
                        nil,
                        x,
                        550,
                        11,
                        5,
                        "#d8d0c4"
                    )
                    R(
                        nil,
                        x + 9,
                        547,
                        5,
                        5,
                        "#d8d0c4"
                    )
                    R(
                        nil,
                        x + 12,
                        549,
                        1,
                        1,
                        "#1c1c1c"
                    )
                    R(
                        nil,
                        x + 1,
                        555,
                        2,
                        2,
                        "#b8b0a4"
                    )
                    R(
                        nil,
                        x + 8,
                        555,
                        2,
                        2,
                        "#b8b0a4"
                    )
                    R(
                        nil,
                        x - 2,
                        549,
                        3,
                        1,
                        "#d8d0c4"
                    )
                    R(
                        nil,
                        x + 9,
                        552,
                        3,
                        1,
                        "#c43c3a"
                    )
                    if __t(lat) then
                        R(
                            nil,
                            x + 16,
                            538,
                            16,
                            8,
                            "#fff6dc"
                        )
                        txt(
                            nil,
                            P,
                            "AU!",
                            x + 24,
                            540,
                            "#c43c3a"
                        )
                    end
                end
                do
                    local mostra = __mod(
                        math.floor(t / 2.5),
                        2
                    )
                    R(
                        nil,
                        650,
                        198,
                        18,
                        10,
                        "#0c0c0c"
                    )
                    txt(
                        nil,
                        P,
                        if __t(mostra) then "12C" else "0740",
                        659,
                        200,
                        if __t(mostra) then "#5ae0ff" else "#ff9a3a"
                    )
                end
                do
                    local cx = 681
                    local cy = 92
                    local r = 24
                    P.c.strokeStyle = "#e8ecef"
                    P.c:beginPath()
                    P.c:arc(
                        cx,
                        cy,
                        r,
                        0,
                        math.pi * 2
                    )
                    P.c:stroke()
                    do
                        local k = 0
                        while k < 8 do
                            local a = t * 0.5 + k * math.pi / 4
                            local x = cx + math.cos(a) * r
                            local y = cy + math.sin(a) * r
                            P.c:beginPath()
                            P.c:moveTo(cx, cy)
                            P.c:lineTo(x, y)
                            P.c:stroke()
                            R(
                                nil,
                                x - 3,
                                y,
                                6,
                                5,
                                __get(
                                    __arrL({"#e8433a", "#f2c94c", "#3c6aa8", "#3c8a5a"}, 4),
                                    __mod(k, 4)
                                )
                            )
                            k = k + 1
                        end
                    end
                    R(
                        nil,
                        cx - 2,
                        cy - 2,
                        4,
                        4,
                        "#c8ccd0"
                    )
                end
                if __t(__mod(
                    math.floor(t * 1.5),
                    2
                )) then
                    for ____, ____value in __iterar((__arrL(
                        {
                            __arrL({180, 52}, 2),
                            __arrL({300, 34}, 2),
                            __arrL({880, 52}, 2)
                        },
                        3
                    ))) do
                        local x = ____value[1]
                        local y = ____value[2]
                        R(
                            nil,
                            x - 1,
                            y - 52,
                            3,
                            3,
                            "#ff3a3a"
                        )
                    end
                end
                do
                    local k = 0
                    while k < 4 do
                        local a = t * 0.5 + k * 1.6
                        local x = 432 + math.cos(a) * (40 + k * 12)
                        local y = 40 + math.sin(a) * 10 + k * 8
                        R(
                            nil,
                            x - 4,
                            y,
                            3,
                            1,
                            "#2a2622"
                        )
                        R(
                            nil,
                            x + 2,
                            y,
                            3,
                            1,
                            "#2a2622"
                        )
                        R(
                            nil,
                            x - 1,
                            y,
                            3,
                            1,
                            "#2a2622"
                        )
                        k = k + 1
                    end
                end
                do
                    local k = 0
                    while k < 5 do
                        R(
                            nil,
                            60 + math.sin(t * 5 + k * 2) * 10,
                            660 + math.cos(t * 4 + k) * 5,
                            1,
                            1,
                            "#f2c94c"
                        )
                        k = k + 1
                    end
                end
                do
                    local k = 0
                    while k < 4 do
                        local x = __mod(t * 5 + k * 330, 1500) - 200
                        local y = 140 + k * 150
                        P.c.globalAlpha = 0.13
                        P:circ(
                            x,
                            y,
                            110,
                            "#f4f8fa",
                            26
                        )
                        P:circ(
                            x + 70,
                            y + 8,
                            80,
                            "#f4f8fa",
                            20
                        )
                        P.c.globalAlpha = 1
                        k = k + 1
                    end
                end
            end,
            veiculo = function(____, P, t, o) return carroViagem(
                nil,
                P,
                t,
                o,
                "taxi"
            ) end,
            locais = PONTOS
        },
        "chave,titulo,subtitulo,lajotas,botao,ilha,relevo,terreno,chao,objetos,animarChao,animar,veiculo,locais"
    )
    local function abrirMapa2(self, cenaAtual, aoIr, opts)
        if opts == nil then
            opts = {}
        end
        if not __t(window.Mapa3D) then
            return false
        end
        local visto = if __t(opts.liberado) then opts.liberado else travaC2
        local d = __assign(
            {},
            MAPA2,
            {
                locais = __call(
                    PONTOS,
                    "map",
                    function(____, L) return __assign(
                        {},
                        L,
                        {
                            atual = L.cena == cenaAtual,
                            estado = if L.cena == cenaAtual then {ok = true} else visto(nil, L),
                            previa = previaCena(
                                nil,
                                L.cena,
                                math.max(0, L.x - 360)
                            )
                        }
                    ) end
                ),
                aoIr = function(____, id)
                    local L = __call(
                        PONTOS,
                        "find",
                        function(____, q) return q.id == id end
                    )
                    if __t(L) then
                        if aoIr ~= nil then
                            aoIr(nil, L.cena, L.x)
                        end
                    end
                end
            }
        )
        if __t(opts.teste) then
            local prox = __call(
                ORDEM,
                "find",
                function(____, v) return not __t(__call(vencidos, "includes", v)) end
            )
            d.teste = if __t(prox) then {
                rotulo = __add(
                    "TESTE: VENCER ",
                    __get(VILOES, prox)
                ),
                acao = function()
                    __call(vencidos, "push", prox)
                    salvarV(nil)
                    window.Mapa3D:fechar()
                    window:setTimeout(
                        function() return abrirMapa2(nil, cenaAtual, aoIr, opts) end,
                        380
                    )
                end
            } else {
                rotulo = "TESTE: ZERAR VILÕES",
                acao = function()
                    vencidos = __arrL({}, 0)
                    salvarV(nil)
                    window.Mapa3D:fechar()
                    window:setTimeout(
                        function() return abrirMapa2(nil, cenaAtual, aoIr, opts) end,
                        380
                    )
                end
            }
        end
        return window.Mapa3D:abrir(d)
    end
    local function desenharTaxi(self, c, x, t, perto)
        local y = 440
        local function R(____, a, b, w, h, col)
            c.fillStyle = col
            c:fillRect(
                math.floor(a + 0.5),
                math.floor(b + 0.5),
                w,
                h
            )
        end
        R(
            nil,
            x - 76,
            y - 4,
            152,
            6,
            "rgba(0,0,0,.22)"
        )
        R(
            nil,
            x - 74,
            y - 44,
            148,
            30,
            "#e8b83a"
        )
        R(
            nil,
            x - 74,
            y - 44,
            148,
            4,
            "#ffd86a"
        )
        R(
            nil,
            x - 76,
            y - 18,
            152,
            8,
            "#c8962a"
        )
        R(
            nil,
            x - 46,
            y - 70,
            82,
            28,
            "#e8b83a"
        )
        R(
            nil,
            x - 46,
            y - 70,
            82,
            4,
            "#ffd86a"
        )
        R(
            nil,
            x - 40,
            y - 64,
            34,
            20,
            "#9fc4d0"
        )
        R(
            nil,
            x - 2,
            y - 64,
            34,
            20,
            "#9fc4d0"
        )
        R(
            nil,
            x - 6,
            y - 66,
            4,
            24,
            "#e8b83a"
        )
        R(
            nil,
            x - 38,
            y - 62,
            6,
            16,
            "rgba(255,255,255,.35)"
        )
        R(
            nil,
            x + 4,
            y - 58,
            14,
            14,
            "#c99068"
        )
        R(
            nil,
            x + 4,
            y - 60,
            14,
            4,
            "#b8b2a6"
        )
        R(
            nil,
            x + 6,
            y - 50,
            10,
            2,
            "#d6d0c4"
        )
        do
            local k = 0
            while k < 18 do
                R(
                    nil,
                    x - 72 + k * 8,
                    y - 32,
                    4,
                    4,
                    if __t(__mod(k, 2)) then "#1c1c1c" else "#f6f6f0"
                )
                k = k + 1
            end
        end
        do
            local k = 0
            while k < 18 do
                R(
                    nil,
                    x - 68 + k * 8,
                    y - 28,
                    4,
                    4,
                    if __t(__mod(k, 2)) then "#f6f6f0" else "#1c1c1c"
                )
                k = k + 1
            end
        end
        local pisca = __mod(
            math.floor(t * 2),
            2
        )
        R(
            nil,
            x - 20,
            y - 82,
            40,
            12,
            "#1c1c1c"
        )
        R(
            nil,
            x - 18,
            y - 80,
            36,
            8,
            if __t(pisca) then "#fff2a0" else "#e8d070"
        )
        c.font = "9px Pixel, monospace"
        c.textAlign = "center"
        c.fillStyle = "#1c1c1c"
        c:fillText("TÁXI", x, y - 73)
        R(
            nil,
            x + 70,
            y - 40,
            6,
            6,
            "#fff2b0"
        )
        R(
            nil,
            x - 76,
            y - 40,
            4,
            8,
            "#e8433a"
        )
        for ____, wx in __iterar((__arrL({x - 46, x + 46}, 2))) do
            R(
                nil,
                wx - 14,
                y - 16,
                28,
                18,
                "#1c1c1c"
            )
            R(
                nil,
                wx - 7,
                y - 10,
                14,
                8,
                "#9aa0a6"
            )
        end
        if __t(perto) then
            local dy = math.floor(math.sin(t * 5) * 3 + 0.5)
            R(
                nil,
                x + 30,
                y - 110 + dy,
                22,
                22,
                "#2a1a14"
            )
            R(
                nil,
                x + 32,
                y - 108 + dy,
                18,
                18,
                "#ffd24a"
            )
            c.fillStyle = "#2a1a14"
            c.font = "14px Pixel, monospace"
            c:fillText("?", x + 41, y - 93 + dy)
        end
        c.textAlign = "left"
    end
    local CampanhaTaxi = __ord(
        {
            pontos = function() return __call(
                PONTOS,
                "map",
                function(____, ____bindingPattern0)
                    local sub
                    local nome
                    local x
                    local cena
                    local id
                    id = ____bindingPattern0.id
                    cena = ____bindingPattern0.cena
                    x = ____bindingPattern0.x
                    nome = ____bindingPattern0.nome
                    sub = ____bindingPattern0.sub
                    return {
                        id = id,
                        cena = cena,
                        x = x,
                        nome = nome,
                        sub = sub
                    }
                end
            ) end,
            perto = function(____, cena, x)
                local p = __call(
                    PONTOS,
                    "find",
                    function(____, q) return q.cena == cena and math.abs(q.x - x) < 90 end
                )
                return if __t(p) then {id = p.id, x = p.x, rotulo = "CHAMAR O TÁXI DO SEU ZÉ", botao = "TÁXI"} else nil
            end,
            desenhar = function(____, c, o)
                local ____t_93 = __t
                local ____opt_90 = o.player
                if ____opt_90 ~= nil then
                    ____opt_90 = ____opt_90.x
                end
                local ____TS__Number_result_92 = __TS__Number(____opt_90)
                __O[627] = ____TS__Number_result_92
                local hx = if ____t_93(____TS__Number_result_92) then __O[627] else -9999
                local ____t_95 = __t
                local ____TS__Number_result_94 = __TS__Number(o.time)
                __O[628] = ____TS__Number_result_94
                local t = if ____t_95(____TS__Number_result_94) then __O[628] else 0
                for ____, p in __iterar((PONTOS)) do
                    local ____t_100 = __t
                    local ____temp_99 = p.cena == __TS__Number(o.scene)
                    if ____temp_99 then
                        local ____p_x_98 = p.x
                        local ____t_97 = __t
                        local ____TS__Number_result_96 = __TS__Number(o.camera)
                        __O[629] = ____TS__Number_result_96
                        ____temp_99 = math.abs(____p_x_98 - if ____t_97(____TS__Number_result_96) then __O[629] else 0 - 480) < 640
                    end
                    if ____t_100(____temp_99) then
                        desenharTaxi(
                            nil,
                            c,
                            p.x,
                            t,
                            math.abs(p.x - hx) < 90
                        )
                    end
                end
            end,
            abrir = abrirMapa2,
            vencidos = function() return __call(vencidos, "slice") end,
            vencer = function(____, v)
                local ____t_103 = __t
                local ____t_102 = __t
                local ____call_result_101 = __call(ORDEM, "includes", v)
                __O[630] = ____call_result_101
                if ____t_103(if ____t_102(____call_result_101) then not __t(__call(vencidos, "includes", v)) else __O[630]) then
                    __call(vencidos, "push", v)
                    salvarV(nil)
                end
            end,
            zerarVencidos = function()
                vencidos = __arrL({}, 0)
                salvarV(nil)
            end,
            viloes = function() return __assign({}, VILOES) end
        },
        "pontos,perto,desenhar,abrir,vencidos,vencer,zerarVencidos,viloes"
    )
    window.MapasJogo = __ord(
        {
            abrirCampanha1 = abrirMapa1,
            abrirCampanha2 = abrirMapa2,
            campanha1 = function() return __call(
                C1,
                "map",
                function(____, ____bindingPattern0)
                    local descricao
                    local sub
                    local nome
                    local id
                    id = ____bindingPattern0.id
                    nome = ____bindingPattern0.nome
                    sub = ____bindingPattern0.sub
                    descricao = ____bindingPattern0.descricao
                    return {id = id, nome = nome, sub = sub, descricao = descricao}
                end
            ) end,
            taxi = CampanhaTaxi
        },
        "abrirCampanha1,abrirCampanha2,campanha1,taxi"
    )
    window.CampanhaTaxi = CampanhaTaxi
end)(nil)
return ____exports
