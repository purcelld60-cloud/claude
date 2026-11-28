--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __gt, __ge, __getq, __mod, __ord, __arrL, __iterar, __t, __get, __set, __len = __JSR.__lt, __JSR.__gt, __JSR.__ge, __JSR.__getq, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__len
local __call, __add, __new = __JSR.__call, __JSR.__add, __JSR.__new
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Iterator = ____lualib.__TS__Iterator
local ____exports = {}
local __O = {};
(function()
    local puxar, fundo, desenhar, tecla, fechar, LW, LH, TENTATIVAS, TAU, R, PEIXES, box, ctx, raf, j, aoFim, fundos
    function puxar(self)
        local ____t_3 = __t
        local ____t_result_2
        local ____t_1 = __t
        local ____temp_0 = not __t(j)
        __O[1365] = ____temp_0
        if ____t_1(____temp_0) then
            ____t_result_2 = __O[1365]
        else
            ____t_result_2 = j.fim
        end
        if ____t_3(____t_result_2) then
            return
        end
        if j.fase == "mordeu" then
            j.peixes = j.peixes + 1
            j.ultimo = __get(
                PEIXES,
                math.floor(math.random() * __len(PEIXES))
            )
            local ____call_6 = __call
            local ____j_5 = j
            local ____t_result_4
            if __t(j.peixesTipo) then
                ____t_result_4 = j.peixesTipo
            else
                ____t_result_4 = __arrL({}, 0)
            end
            ____j_5.peixesTipo = ____t_result_4
            ____call_6(
                ____t_result_4,
                "push",
                __get(j.ultimo, 0)
            )
            j.fase = "pegou"
            j.tf = 0
            j.msg = __add(
                __add(
                    "PEGOU UMA ",
                    __get(j.ultimo, 0)
                ),
                "!"
            )
        elseif j.fase == "espera" then
            j.fase = "espantou"
            j.tf = 0
            j.msg = "CEDO DEMAIS! O PEIXE FUGIU"
        end
    end
    function fundo(self, noite)
        local k = __t(noite) and "n" or "d"
        if __t(__get(fundos, k)) then
            return __get(fundos, k)
        end
        local PK = window.PixelKit
        local cvf = window.document:createElement("canvas")
        cvf.width = LW
        cvf.height = LH
        local c = cvf:getContext("2d")
        c.imageSmoothingEnabled = false
        local function T(____, d, n)
            local ____t_result_19
            if __t(noite) then
                ____t_result_19 = n
            else
                ____t_result_19 = d
            end
            return ____t_result_19
        end
        local h = PK.hash
        local ____PK_faixas_21 = PK.faixas
        local ____t_result_20
        if __t(noite) then
            ____t_result_20 = __arrL({
                "#0a1028",
                "#0e1634",
                "#121c3e",
                "#18244a",
                "#1e2c54",
                "#26365e"
            }, 6)
        else
            ____t_result_20 = __arrL({
                "#4a92da",
                "#5aa0e0",
                "#6aaee6",
                "#7cbcea",
                "#90caf0",
                "#a8d8f4"
            }, 6)
        end
        ____PK_faixas_21(
            PK,
            c,
            0,
            0,
            LW,
            104,
            ____t_result_20
        )
        if __t(noite) then
            do
                local i = 0
                while i < 70 do
                    R(
                        nil,
                        c,
                        h(nil, i) * LW,
                        h(nil, i + 9) * 80,
                        1,
                        1,
                        __t(__mod(i, 7)) and "#c8d0f0" or "#ffffff"
                    )
                    i = i + 1
                end
            end
            do
                local y = -7
                while y <= 7 do
                    local w = math.floor(math.sqrt(49 - y * y) + 0.5)
                    R(
                        nil,
                        c,
                        236 - w,
                        34 + y,
                        w * 2,
                        1,
                        "#f2f2e0"
                    )
                    y = y + 1
                end
            end
            R(
                nil,
                c,
                233,
                31,
                3,
                2,
                "#d8d8c8"
            )
            R(
                nil,
                c,
                239,
                37,
                2,
                2,
                "#d8d8c8"
            )
        else
            do
                local y = -9
                while y <= 9 do
                    local w = math.floor(math.sqrt(81 - y * y) + 0.5)
                    R(
                        nil,
                        c,
                        236 - w,
                        36 + y,
                        w * 2,
                        1,
                        y < -3 and "#fffbe0" or "#fff2b0"
                    )
                    y = y + 1
                end
            end
            do
                local k = 0
                while k < 24 do
                    local a = k / 24 * TAU
                    if __t(__mod(k, 2)) then
                        R(
                            nil,
                            c,
                            236 + math.cos(a) * 13,
                            36 + math.sin(a) * 13,
                            1,
                            1,
                            "#fff6c8"
                        )
                    end
                    k = k + 1
                end
            end
        end
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({70, 30, 5}, 3),
                __arrL({190, 18, 4}, 3),
                __arrL({300, 50, 3}, 3),
                __arrL({440, 70, 3}, 3)
            },
            4
        ))) do
            local cx = ____value[1]
            local cy = ____value[2]
            local n = ____value[3]
            do
                local k = 0
                while k < n do
                    local r = 5 + __mod(k, 2) * 3
                    local x = cx + k * 9 - n * 4
                    do
                        local y = -r
                        while y <= 0 do
                            local w = math.floor(math.sqrt(r * r - y * y) + 0.5)
                            R(
                                nil,
                                c,
                                x - w,
                                cy + y,
                                w * 2,
                                1,
                                T(nil, "#ffffff", "#3a4468")
                            )
                            y = y + 1
                        end
                    end
                    k = k + 1
                end
            end
            R(
                nil,
                c,
                cx - n * 4 - 4,
                cy,
                n * 9 + 6,
                2,
                T(nil, "#d8e8f4", "#2a3254")
            )
        end
        do
            local x = 0
            while x < LW do
                local y1 = math.floor(76 + math.sin(x * 0.021) * 8 + math.sin(x * 0.07 + 1) * 3 + 0.5)
                local y2 = math.floor(90 + math.sin(x * 0.03 + 2) * 6 + math.sin(x * 0.11) * 2 + 0.5)
                local sobe = math.cos(x * 0.021) * 8 * 0.021 + math.cos(x * 0.07 + 1) * 3 * 0.07
                R(
                    nil,
                    c,
                    x,
                    y1,
                    1,
                    112 - y1,
                    T(nil, sobe < 0 and "#86a4b8" or "#6a8aa4", "#1e2a44")
                )
                R(
                    nil,
                    c,
                    x,
                    y1,
                    1,
                    1,
                    T(nil, "#b8cedc", "#2a3858")
                )
                if __gt(
                    h(nil, x * 1.3),
                    0.6
                ) then
                    R(
                        nil,
                        c,
                        x,
                        y1 + 3 + math.floor(h(nil, x) * 8),
                        1,
                        1,
                        T(nil, "#5a7a94", "#18223a")
                    )
                end
                R(
                    nil,
                    c,
                    x,
                    y2,
                    1,
                    112 - y2,
                    T(
                        nil,
                        __t(__mod(
                            math.floor((x + y2) / 14),
                            2
                        )) and "#5a9a4e" or "#6aaa58",
                        "#16281e"
                    )
                )
                if __t(__mod(x, 4) == 0 and y2 + 4 < 108) then
                    R(
                        nil,
                        c,
                        x,
                        y2 + 4,
                        1,
                        1,
                        T(nil, "#3a7a3a", "#0e1c16")
                    )
                end
                x = x + 1
            end
        end
        do
            local i = 0
            while i < 40 do
                local x = i * 12 + h(nil, i) * 8
                local y = 106 - h(nil, i * 3) * 4
                local r = 4 + math.floor(h(nil, i * 7) * 4)
                do
                    local yy = -r
                    while yy <= 0 do
                        local w = math.floor(math.sqrt(r * r - yy * yy) + 0.5)
                        R(
                            nil,
                            c,
                            x - w,
                            y + yy,
                            w * 2,
                            1,
                            T(nil, yy < -r / 2 and "#4a8a40" or "#2f6a34", yy < -r / 2 and "#1a3226" or "#12241a")
                        )
                        yy = yy + 1
                    end
                end
                i = i + 1
            end
        end
        for ____, x in __iterar((__arrL({150, 330}, 2))) do
            do
                local y = 0
                while y < 24 do
                    R(
                        nil,
                        c,
                        x + math.sin(y * 0.1) * 2,
                        106 - y,
                        2,
                        1,
                        T(nil, "#7a5a34", "#2a2018")
                    )
                    y = y + 1
                end
            end
            do
                local f = 0
                while f < 6 do
                    local a = -math.pi / 2 + (f - 2.5) * 0.55
                    do
                        local k = 1
                        while k < 10 do
                            R(
                                nil,
                                c,
                                x + 1 + math.cos(a) * k,
                                82 + math.sin(a) * k * 0.6 + k * k * 0.05,
                                1,
                                1,
                                T(nil, "#3a8a3a", "#16301e")
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
            400,
            92,
            26,
            16,
            T(nil, "#e8d8b8", "#3a3448")
        )
        do
            local k = 0
            while k < 8 do
                R(
                    nil,
                    c,
                    398 + k,
                    92 - k,
                    30 - k * 2,
                    1,
                    T(nil, "#b8543a", "#2a2238")
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            418,
            82,
            4,
            8,
            T(nil, "#8a4a3a", "#2a2020")
        )
        R(
            nil,
            c,
            405,
            96,
            6,
            6,
            __t(noite) and "#ffd27a" or "#5a7a9a"
        )
        R(
            nil,
            c,
            415,
            98,
            6,
            10,
            T(nil, "#7a4a2a", "#1a1418")
        )
        local ____PK_faixas_23 = PK.faixas
        local ____t_result_22
        if __t(noite) then
            ____t_result_22 = __arrL({
                "#1e3058",
                "#1a2a50",
                "#162448",
                "#132040",
                "#101c38",
                "#0e1830",
                "#0c1428",
                "#0a1222"
            }, 8)
        else
            ____t_result_22 = __arrL({
                "#8ac4e4",
                "#78b6dc",
                "#68a8d2",
                "#5a9ac8",
                "#4c8cbc",
                "#407eb0",
                "#3670a4",
                "#2c6298"
            }, 8)
        end
        ____PK_faixas_23(
            PK,
            c,
            0,
            110,
            LW,
            160,
            ____t_result_22
        )
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({260, 214, 14}, 3),
                __arrL({290, 222, 10}, 3),
                __arrL({420, 190, 16}, 3),
                __arrL({446, 200, 11}, 3),
                __arrL({380, 240, 13}, 3)
            },
            5
        ))) do
            local x = ____value[1]
            local y = ____value[2]
            local w = ____value[3]
            R(
                nil,
                c,
                x - w / 2,
                y,
                w,
                3,
                T(nil, "#3a8a3a", "#14301e")
            )
            R(
                nil,
                c,
                x - w / 2 + 1,
                y,
                w - 2,
                1,
                T(nil, "#5aaa4a", "#1e4028")
            )
            R(
                nil,
                c,
                x,
                y + 1,
                2,
                2,
                T(nil, "#2a6a2a", "#0e2414")
            )
            if w > 12 then
                R(
                    nil,
                    c,
                    x - 2,
                    y - 2,
                    3,
                    2,
                    "#f2a8c8"
                )
                R(
                    nil,
                    c,
                    x - 1,
                    y - 3,
                    1,
                    1,
                    "#ffffff"
                )
            end
        end
        do
            local k = 0
            while k < 9 do
                local x = 452 + k * 3
                local hh = 26 + __mod(k, 3) * 9
                do
                    local y = 0
                    while y < hh do
                        R(
                            nil,
                            c,
                            x + (y > hh * 0.6 and 1 or 0),
                            268 - y,
                            1,
                            1,
                            T(nil, "#4a7a3a", "#16301e")
                        )
                        y = y + 1
                    end
                end
                R(
                    nil,
                    c,
                    x,
                    268 - hh - 6,
                    2,
                    6,
                    T(nil, "#6a4a2a", "#22180e")
                )
                k = k + 1
            end
        end
        do
            local x = 0
            while x < 158 do
                R(
                    nil,
                    c,
                    x,
                    174,
                    9,
                    4,
                    T(
                        nil,
                        __get(
                            __arrL({"#b8844e", "#a8784a", "#c08a52"}, 3),
                            __mod(x / 10, 3)
                        ),
                        "#4a3420"
                    )
                )
                R(
                    nil,
                    c,
                    x + 9,
                    174,
                    1,
                    4,
                    T(nil, "#6a4224", "#22160c")
                )
                R(
                    nil,
                    c,
                    x + 2,
                    175,
                    1,
                    1,
                    "#3a2414"
                )
                R(
                    nil,
                    c,
                    x + 6,
                    175,
                    1,
                    1,
                    "#3a2414"
                )
                x = x + 10
            end
        end
        R(
            nil,
            c,
            0,
            178,
            158,
            7,
            T(nil, "#7a5230", "#2a1c10")
        )
        R(
            nil,
            c,
            0,
            178,
            158,
            1,
            T(nil, "#5a3a20", "#1c120a")
        )
        do
            local x = 4
            while x < 158 do
                R(
                    nil,
                    c,
                    x,
                    180,
                    14,
                    1,
                    T(nil, "#6a4628", "#24180e")
                )
                x = x + 26
            end
        end
        do
            local x = 8
            while x < 158 do
                R(
                    nil,
                    c,
                    x,
                    185,
                    6,
                    85,
                    T(nil, "#5a3a22", "#1e140c")
                )
                R(
                    nil,
                    c,
                    x,
                    185,
                    2,
                    85,
                    T(nil, "#7a5230", "#2a1c10")
                )
                R(
                    nil,
                    c,
                    x,
                    196,
                    6,
                    4,
                    T(nil, "#4a7a3a", "#16301e")
                )
                R(
                    nil,
                    c,
                    x - 2,
                    200,
                    10,
                    1,
                    T(nil, "#a8d8f0", "#3a5a8a")
                )
                x = x + 30
            end
        end
        R(
            nil,
            c,
            136,
            160,
            14,
            14,
            T(nil, "#3a6aa8", "#18243a")
        )
        R(
            nil,
            c,
            135,
            160,
            16,
            2,
            T(nil, "#6a9ad8", "#24365a")
        )
        R(
            nil,
            c,
            137,
            156,
            12,
            1,
            T(nil, "#9aa0a6", "#3a3e48")
        )
        R(
            nil,
            c,
            136,
            157,
            1,
            3,
            T(nil, "#9aa0a6", "#3a3e48")
        )
        R(
            nil,
            c,
            149,
            157,
            1,
            3,
            T(nil, "#9aa0a6", "#3a3e48")
        )
        R(
            nil,
            c,
            6,
            166,
            9,
            8,
            T(nil, "#9aa0a6", "#3a3e48")
        )
        R(
            nil,
            c,
            6,
            166,
            9,
            2,
            T(nil, "#c43c3a", "#3a1a1a")
        )
        R(
            nil,
            c,
            8,
            164,
            2,
            2,
            T(nil, "#c87a7a", "#3a2a2a")
        )
        R(
            nil,
            c,
            11,
            163,
            1,
            3,
            T(nil, "#c87a7a", "#3a2a2a")
        )
        R(
            nil,
            c,
            18,
            168,
            14,
            6,
            T(nil, "#2f7a4a", "#10261a")
        )
        R(
            nil,
            c,
            18,
            168,
            14,
            1,
            T(nil, "#5aa86a", "#1e3a28")
        )
        R(
            nil,
            c,
            24,
            170,
            2,
            2,
            T(nil, "#e8c24a", "#3a3418")
        )
        return __set(fundos, k, cvf)
    end
    function desenhar(self)
        local c = ctx
        local t = j.t
        local PK = window.PixelKit
        c:setTransform(
            1,
            0,
            0,
            1,
            0,
            0
        )
        c.imageSmoothingEnabled = false
        if not __t(PK) then
            R(
                nil,
                c,
                0,
                0,
                LW,
                LH,
                "#3a7aa8"
            )
            return
        end
        local ____gt_34 = __gt
        local ____t_result_33
        local ____t_32 = __t
        local ____opt_28 = window.DayTime
        if ____opt_28 ~= nil then
            ____opt_28 = ____opt_28.state
        end
        local ____opt_result_30
        if ____opt_28 ~= nil then
            ____opt_result_30 = ____opt_28(____opt_28)
        end
        local ____opt_result_31
        if ____opt_result_30 ~= nil then
            ____opt_result_31 = ____opt_result_30.night
        end
        __O[1368] = ____opt_result_31
        if ____t_32(____opt_result_31) then
            ____t_result_33 = __O[1368]
        else
            ____t_result_33 = 0
        end
        local noite = ____gt_34(____t_result_33, 0.55)
        c:drawImage(
            fundo(nil, noite),
            0,
            0
        )
        local f = fundo(nil, noite)
        do
            local y = 0
            while y < 14 do
                local dx = math.floor(math.sin(t * 2.2 + y * 0.8) * (1 + y * 0.15) + 0.5)
                c.globalAlpha = 0.28 - y * 0.015
                c:drawImage(
                    f,
                    0,
                    108 - y,
                    LW,
                    1,
                    dx,
                    111 + y,
                    LW,
                    1
                )
                y = y + 1
            end
        end
        c.globalAlpha = 1
        do
            local k = 0
            while k < 34 do
                local x = __mod(
                    k * 61 + t * (6 + __mod(k, 3) * 3),
                    520
                ) - 20
                local y = 118 + __mod(k * 23, 150)
                local w = 3 + __mod(k, 4) * 2
                local ____t_result_35
                if __t(noite) then
                    ____t_result_35 = __t(__mod(k, 2)) and "#3a5a8a" or "#2a4a7a"
                else
                    ____t_result_35 = __t(__mod(k, 2)) and "#a8d8f0" or "#8ac0e0"
                end
                R(
                    nil,
                    c,
                    x,
                    y,
                    w,
                    1,
                    ____t_result_35
                )
                k = k + 1
            end
        end
        do
            local k = 0
            while k < 8 do
                if math.sin(t * 4 + k * 2.1) > 0.6 then
                    PK:brilho4(
                        c,
                        math.floor(170 + PK:hash(k) * 300 + 0.5),
                        math.floor(116 + PK:hash(k + 4) * 120 + 0.5),
                        2,
                        __t(noite) and "#c8d8ff" or "#ffffff"
                    )
                end
                k = k + 1
            end
        end
        do
            local x = 236
            do
                local y = 112
                while y < 170 do
                    local w = 2 + math.floor(math.sin(t * 3 + y * 0.7) * 1.5 + (y - 110) * 0.06 + 0.5)
                    c.globalAlpha = 0.5 - (y - 110) / 140
                    R(
                        nil,
                        c,
                        x - w + math.sin(t * 2 + y) * 2,
                        y,
                        w * 2,
                        1,
                        __t(noite) and "#e8f0ff" or "#fff6c8"
                    )
                    y = y + 2
                end
            end
            c.globalAlpha = 1
        end
        do
            local u = __mod(t * 0.07, 1)
            local x = 520 - u * 600
            local y = 236 + math.sin(t * 0.8) * 6
            c.globalAlpha = 0.25
            R(
                nil,
                c,
                x,
                y,
                14,
                3,
                "#0a1a2a"
            )
            R(
                nil,
                c,
                x + 3,
                y - 1,
                8,
                5,
                "#0a1a2a"
            )
            R(
                nil,
                c,
                x + 14,
                y - 1,
                3,
                5,
                "#0a1a2a"
            )
            c.globalAlpha = 1
        end
        if not __t(noite) then
            local x = 220 + math.sin(t * 0.7) * 60
            local y = 150 + math.sin(t * 1.9) * 12
            local a = math.sin(t * 40) > 0
            R(
                nil,
                c,
                x,
                y,
                6,
                1,
                "#3a6ac8"
            )
            R(
                nil,
                c,
                x + 1,
                y - (__t(a) and 2 or 1),
                3,
                1,
                "rgba(220,240,255,.8)"
            )
        end
        do
            pcall(function()
                local ____opt_38 = window.Art
                if ____opt_38 ~= nil then
                    ____opt_38 = ____opt_38.drawCharacter
                end
                if ____opt_38 ~= nil then
                    ____opt_38(
                        ____opt_38,
                        c,
                        "vagner",
                        40,
                        174,
                        {frame = t, facing = 1, grounded = true, scale = 0.85}
                    )
                end
                local ____opt_42 = window.Art
                if ____opt_42 ~= nil then
                    ____opt_42 = ____opt_42.drawCharacter
                end
                if ____opt_42 ~= nil then
                    ____opt_42(
                        ____opt_42,
                        c,
                        "daroca",
                        108,
                        174,
                        {
                            frame = t,
                            facing = 1,
                            grounded = true,
                            scale = 0.9,
                            attack = j.fase == "pegou" and __lt(j.tf, 0.4)
                        }
                    )
                end
            end)
        end
        local ____temp_44
        if j.fase == "pegou" then
            ____temp_44 = math.max(0, 1 - j.tf * 2)
        else
            ____temp_44 = 0
        end
        local puxa = ____temp_44
        local tx = 186 - puxa * 14
        local ty = 92 - puxa * 18
        do
            local k = 0
            while k <= 22 do
                local u = k / 22
                local x = 118 + (tx - 118) * u
                local y = 142 + (ty - 142) * u - math.sin(u * math.pi) * (j.fase == "mordeu" and 5 or 2)
                R(
                    nil,
                    c,
                    x,
                    y,
                    k < 6 and 2 or 1,
                    2,
                    k < 6 and "#3a2414" or "#8a5a2a"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            120,
            140,
            4,
            4,
            "#9aa0a6"
        )
        R(
            nil,
            c,
            121,
            141,
            2,
            2,
            "#3a3e44"
        )
        local bx = 300
        local base = 158
        local ____temp_46
        if j.fase == "mordeu" then
            ____temp_46 = 5 + math.floor(math.sin(j.tf * 30) * 2 + 0.5)
        else
            local ____temp_45
            if j.fase == "espera" then
                ____temp_45 = math.floor(math.sin(t * 2) * 1.2 + 0.5)
            else
                ____temp_45 = 0
            end
            ____temp_46 = ____temp_45
        end
        local afunda = ____temp_46
        if j.fase ~= "pegou" then
            do
                local k = 0
                while k <= 30 do
                    local u = k / 30
                    local x = tx + (bx - tx) * u
                    local y = ty + (base + afunda - 8 - ty) * u * u + math.sin(u * math.pi) * -6
                    R(
                        nil,
                        c,
                        x,
                        y,
                        1,
                        1,
                        __t(noite) and "rgba(200,210,240,.6)" or "rgba(255,255,255,.8)"
                    )
                    k = k + 1
                end
            end
            local by = base + afunda
            R(
                nil,
                c,
                bx - 3,
                by - 6,
                6,
                3,
                "#e8433a"
            )
            R(
                nil,
                c,
                bx - 2,
                by - 7,
                4,
                1,
                "#ff7a6a"
            )
            R(
                nil,
                c,
                bx - 3,
                by - 3,
                6,
                3,
                "#f2f2ee"
            )
            R(
                nil,
                c,
                bx - 2,
                by,
                4,
                1,
                "#c8c8c0"
            )
            R(
                nil,
                c,
                bx,
                by - 12,
                1,
                5,
                "#1c1c1c"
            )
            R(
                nil,
                c,
                bx - 4,
                by + 1,
                9,
                1,
                __t(noite) and "#4a6a9a" or "#c8e8f8"
            )
        end
        if j.fase == "mordeu" then
            do
                local k = 0
                while k < 3 do
                    local r = 6 + k * 5 + math.floor(j.tf * 18 + 0.5)
                    local a = 0.7 - k * 0.2
                    c.globalAlpha = math.max(0, a)
                    do
                        local i = 0
                        while i < 24 do
                            local an = i / 24 * TAU
                            R(
                                nil,
                                c,
                                bx + math.cos(an) * r,
                                base + 4 + math.sin(an) * r * 0.3,
                                1,
                                1,
                                "#ffffff"
                            )
                            i = i + 1
                        end
                    end
                    k = k + 1
                end
            end
            c.globalAlpha = 1
            do
                local k = 0
                while k < 5 do
                    local u = __mod(j.tf * 3 + k / 5, 1)
                    R(
                        nil,
                        c,
                        bx - 6 + k * 3,
                        base - u * 8,
                        1,
                        1,
                        "#e8f8ff"
                    )
                    k = k + 1
                end
            end
            if __mod(
                math.floor(j.tf * 8),
                2
            ) == 0 then
                PK:contorno(
                    c,
                    "!",
                    bx,
                    base - 26,
                    16,
                    "#ffd24a",
                    "#3a1a0a"
                )
            end
        end
        local ____t_50 = __t
        local ____t_result_49
        local ____t_48 = __t
        local ____temp_47 = j.fase == "pegou"
        __O[1369] = ____temp_47
        if ____t_48(____temp_47) then
            ____t_result_49 = j.ultimo
        else
            ____t_result_49 = __O[1369]
        end
        if ____t_50(____t_result_49) then
            local u = math.min(1, j.tf / 0.6)
            local fx = bx - (bx - 140) * u
            local fy = base - math.sin(u * math.pi) * 70 - u * 20
            PK:peixe(
                c,
                __get(j.ultimo, 0),
                fx,
                fy,
                1,
                false
            )
            do
                local k = 0
                while k < 6 do
                    local v = __mod(j.tf * 2 + k / 6, 1)
                    R(
                        nil,
                        c,
                        fx + (PK:hash(k) - 0.5) * 20,
                        fy + v * 24,
                        1,
                        2,
                        "#c8e8ff"
                    )
                    k = k + 1
                end
            end
        end
        do
            local k = 0
            while k < math.min(j.peixes, 5) do
                local x = 138 + k * 2.5
                local y = 158 - __mod(k, 2)
                R(
                    nil,
                    c,
                    x,
                    y,
                    2,
                    3,
                    __t(__getq(j.peixesTipo, k)) and "#c8d0d8" or "#a8b8c0"
                )
                R(
                    nil,
                    c,
                    x - 1,
                    y - 1,
                    1,
                    1,
                    "#a8b8c0"
                )
                R(
                    nil,
                    c,
                    x + 2,
                    y - 1,
                    1,
                    1,
                    "#a8b8c0"
                )
                k = k + 1
            end
        end
        PK:painel(
            c,
            300,
            6,
            172,
            30,
            {fundo = "#13283a", borda = "#9ad0e8", rebite = "#5a8aa8"}
        )
        do
            local k = 0
            while k < TENTATIVAS do
                local x = 318 + k * 22
                local y = 21
                if __lt(k, j.peixes) then
                    local ____PK_peixe_54 = PK.peixe
                    local ____t_result_53
                    local ____t_52 = __t
                    local ____t_result_51
                    if __t(j.peixesTipo) then
                        ____t_result_51 = __get(j.peixesTipo, k)
                    else
                        ____t_result_51 = j.peixesTipo
                    end
                    __O[1370] = ____t_result_51
                    if ____t_52(____t_result_51) then
                        ____t_result_53 = __O[1370]
                    else
                        ____t_result_53 = "TILÁPIA"
                    end
                    ____PK_peixe_54(
                        PK,
                        c,
                        ____t_result_53,
                        x,
                        y,
                        1
                    )
                else
                    c.globalAlpha = 0.3
                    PK:peixe(
                        c,
                        "PIABA",
                        x,
                        y,
                        1
                    )
                    c.globalAlpha = 1
                end
                k = k + 1
            end
        end
        PK:texto(
            c,
            (tostring(math.min(j.tent + 1, TENTATIVAS)) .. "/") .. tostring(TENTATIVAS),
            448,
            21,
            8,
            "#fff6dc"
        )
        PK:painel(
            c,
            6,
            6,
            118,
            20,
            {fundo = "#2a1e12", borda = "#e8c24a"}
        )
        PK:texto(
            c,
            "PESCARIA",
            65,
            16,
            8,
            "#ffe9a8"
        )
        if j.fase == "mordeu" then
            PK:contorno(
                c,
                "PUXA!",
                bx,
                112,
                16,
                __t(__mod(
                    math.floor(t * 10),
                    2
                )) and "#ffd24a" or "#ffffff",
                "#3a1a0a"
            )
        end
        if __t(j.msg) then
            local bom = j.fase == "pegou"
            PK:painel(
                c,
                120,
                238,
                240,
                24,
                {
                    fundo = __t(bom) and "#14301e" or "#3a1414",
                    borda = __t(bom) and "#7af07a" or "#ff9a7a"
                }
            )
            PK:texto(
                c,
                j.msg,
                LW / 2,
                250,
                8,
                __t(bom) and "#b8ffb8" or "#ffd0c0"
            )
        end
        if __t(j.fim) then
            PK:painel(
                c,
                70,
                96,
                340,
                64,
                {
                    fundo = "#101c2a",
                    borda = __ge(j.peixes, 3) and "#7af07a" or "#ffd24a",
                    rebite = "#5a8aa8"
                }
            )
            local ____PK_texto_56 = PK.texto
            local ____ge_result_55
            if __ge(j.peixes, 3) then
                ____ge_result_55 = tostring(j.peixes) .. " PEIXES!"
            else
                ____ge_result_55 = tostring(j.peixes) .. " PEIXE(S)"
            end
            ____PK_texto_56(
                PK,
                c,
                ____ge_result_55,
                LW / 2,
                116,
                16,
                __ge(j.peixes, 3) and "#b8ffb8" or "#ffe9a8"
            )
            PK:texto(
                c,
                __ge(j.peixes, 3) and "PESCADOR DE VERDADE!" or "O VAGNER RIU DE VOCÊ.",
                LW / 2,
                140,
                8,
                "#fff6dc"
            )
        end
    end
    function tecla(self, e)
        if not __t(box) then
            return
        end
        if e.code == "Escape" then
            e:preventDefault()
            e:stopPropagation()
            local ____fechar_62 = fechar
            local ____t_result_61
            local ____t_60 = __t
            local ____opt_result_59
            if j ~= nil then
                ____opt_result_59 = j.peixes
            end
            __O[1371] = ____opt_result_59
            if ____t_60(____opt_result_59) then
                ____t_result_61 = __O[1371]
            else
                ____t_result_61 = 0
            end
            ____fechar_62(nil, ____t_result_61)
            return
        end
        if __t(__call(
            __arrL({"KeyE", "Space", "Enter", "KeyJ"}, 4),
            "includes",
            e.code
        )) then
            e:preventDefault()
            e:stopPropagation()
            if not __t(e["repeat"]) then
                puxar(nil)
            end
        end
    end
    function fechar(self, peixes)
        if not __t(box) then
            return
        end
        window:cancelAnimationFrame(raf)
        window:removeEventListener("keydown", tecla, true)
        box:remove()
        box = nil
        j = nil
        window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {active = false}}))
        local ____opt_72 = window.document:getElementById("gameCanvas")
        local ____opt_70 = ____opt_72 and ____opt_72.focus
        if ____opt_70 ~= nil then
            ____opt_70(____opt_72)
        end
        local fn = aoFim
        aoFim = nil
        if __t(fn) then
            do
                pcall(function()
                    local ____t_result_74
                    if __t(peixes) then
                        ____t_result_74 = peixes
                    else
                        ____t_result_74 = 0
                    end
                    fn(nil, ____t_result_74)
                end)
            end
        end
    end
    local ____ = "use strict"
    if __t(window.PescariaBene) then
        return
    end
    LW = 480
    LH = 270
    TENTATIVAS = 5
    local JANELA = 0.62
    TAU = math.pi * 2
    R = function(____, c, x, y, w, h, cor)
        c.fillStyle = cor
        c:fillRect(
            math.floor(x + 0.5),
            math.floor(y + 0.5),
            math.floor(w + 0.5),
            math.floor(h + 0.5)
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
    PEIXES = __arrL(
        {
            __arrL({"TILÁPIA", "#a8b8c0"}, 2),
            __arrL({"TRAÍRA", "#7a8a5a"}, 2),
            __arrL({"PIABA", "#d8d0a0"}, 2),
            __arrL({"CARÁ", "#c8a06a"}, 2),
            __arrL({"TUCUNARÉ", "#e8b84a"}, 2)
        },
        5
    )
    box = nil
    local cv = nil
    ctx = nil
    raf = 0
    j = nil
    aoFim = nil
    local function novoArremesso(self)
        j.fase = "espera"
        j.espera = 1.2 + math.random() * 2.3
        j.tf = 0
        j.msg = ""
    end
    local function quadro(self, agora)
        if not __t(j) then
            return
        end
        local ____agora_8 = agora
        local ____t_result_7
        if __t(j.ultimoT) then
            ____t_result_7 = j.ultimoT
        else
            ____t_result_7 = agora
        end
        local dt = math.min(0.1, (____agora_8 - ____t_result_7) / 1000)
        j.ultimoT = agora
        j.t = j.t + dt
        j.tf = j.tf + dt
        if __t(j.fase == "espera" and __ge(j.tf, j.espera)) then
            j.fase = "mordeu"
            j.tf = 0
        elseif __t(j.fase == "mordeu" and __ge(j.tf, JANELA)) then
            j.fase = "escapou"
            j.tf = 0
            j.msg = "ESCAPOU! PUXE QUANDO A BOIA AFUNDAR"
        else
            local ____t_12 = __t
            local ____t_result_11
            local ____t_10 = __t
            local ____call_result_9 = __call(
                __arrL({"pegou", "espantou", "escapou"}, 3),
                "includes",
                j.fase
            )
            __O[1366] = ____call_result_9
            if ____t_10(____call_result_9) then
                ____t_result_11 = __ge(j.tf, 1.3)
            else
                ____t_result_11 = __O[1366]
            end
            if ____t_12(____t_result_11) then
                j.tent = j.tent + 1
                if __ge(j.tent, TENTATIVAS) then
                    j.fim = true
                    window:setTimeout(
                        function()
                            local ____fechar_18 = fechar
                            local ____t_result_17
                            local ____t_16 = __t
                            local ____opt_result_15
                            if j ~= nil then
                                ____opt_result_15 = j.peixes
                            end
                            __O[1367] = ____opt_result_15
                            if ____t_16(____opt_result_15) then
                                ____t_result_17 = __O[1367]
                            else
                                ____t_result_17 = 0
                            end
                            return ____fechar_18(nil, ____t_result_17)
                        end,
                        1400
                    )
                else
                    novoArremesso(nil)
                end
            end
        end
        desenhar(nil)
        raf = window:requestAnimationFrame(quadro)
    end
    fundos = {}
    local function abrir(self, o)
        if o == nil then
            o = {}
        end
        if __t(box) then
            return false
        end
        local ____t_result_63
        if __t(o.onFim) then
            ____t_result_63 = o.onFim
        else
            ____t_result_63 = nil
        end
        aoFim = ____t_result_63
        if not __t(window.document:getElementById("pbEstilo")) then
            local st = window.document:createElement("style")
            st.id = "pbEstilo"
            st.textContent = ".pb-overlay{position:fixed;inset:0;z-index:9000;background:rgba(6,14,20,.86);display:flex;flex-direction:column;align-items:center;justify-content:center;gap:10px;font-family:monospace;touch-action:none;user-select:none}.pb-overlay canvas{width:min(96vw,calc(78vh*16/9),960px);aspect-ratio:16/9;image-rendering:pixelated;border:4px solid #5a3a22;box-shadow:0 0 0 2px #e8c24a,0 6px 0 2px #2a1a0e;border-radius:0}.pb-puxar{font:16px Pixel,monospace;color:#fff6dc;background:#2a5a7a;border:0;border-radius:0;padding:14px 36px;box-shadow:0 0 0 3px #0a1a2a,inset 0 -4px 0 #1a3a52,inset 0 3px 0 #5a9ac8;text-shadow:2px 2px 0 #0a1a2a}.pb-puxar:active{background:#3a7aa8;transform:translateY(2px)}.pb-sair{font:8px Pixel,monospace;color:#ffd24a;background:#2a1e12;border:0;border-radius:0;padding:8px 14px;box-shadow:0 0 0 2px #ffd24a}"
            window.document.head:append(st)
        end
        box = window.document:createElement("div")
        box.className = "pb-overlay"
        box:setAttribute("role", "dialog")
        box:setAttribute("aria-label", "Pescaria do Vagner")
        cv = window.document:createElement("canvas")
        cv.width = LW
        cv.height = LH
        ctx = cv:getContext("2d")
        box:append(cv)
        local b = window.document:createElement("button")
        b.type = "button"
        b.className = "pb-puxar"
        b.textContent = "PUXAR!"
        b:addEventListener(
            "pointerdown",
            function(____, e)
                e:preventDefault()
                puxar(nil)
            end
        )
        box:append(b)
        local s = window.document:createElement("button")
        s.type = "button"
        s.className = "pb-sair"
        s.textContent = "SAIR (Esc)"
        s:addEventListener(
            "click",
            function()
                local ____fechar_69 = fechar
                local ____t_result_68
                local ____t_67 = __t
                local ____opt_result_66
                if j ~= nil then
                    ____opt_result_66 = j.peixes
                end
                __O[1372] = ____opt_result_66
                if ____t_67(____opt_result_66) then
                    ____t_result_68 = __O[1372]
                else
                    ____t_result_68 = 0
                end
                return ____fechar_69(nil, ____t_result_68)
            end
        )
        box:append(s)
        window.document.body:append(box)
        window:addEventListener("keydown", tecla, true)
        j = {
            t = 0,
            tf = 0,
            tent = 0,
            peixes = 0,
            fase = "espera",
            espera = 1.5,
            msg = "",
            fim = false,
            ultimoT = 0
        }
        novoArremesso(nil)
        window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {active = true}}))
        window:cancelAnimationFrame(raf)
        raf = window:requestAnimationFrame(quadro)
        return true
    end
    window.PescariaBene = __ord(
        {
            abrir = abrir,
            aberto = function() return not not __t(box) end,
            estado = function()
                local ____t_result_75
                if __t(j) then
                    ____t_result_75 = {fase = j.fase, peixes = j.peixes, tent = j.tent}
                else
                    ____t_result_75 = j
                end
                return ____t_result_75
            end
        },
        "abrir,aberto,estado"
    )
end)(nil)
return ____exports
