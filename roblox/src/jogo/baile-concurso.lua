--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __newExpr, __lt, __gt, __mod, __ord, __arrL, __iterar, __t, __get, __set, __len, __call = __JSR.__newExpr, __JSR.__lt, __JSR.__gt, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__len, __JSR.__call
local __add, __new, __assign = __JSR.__add, __JSR.__new, __JSR.__assign
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Iterator = ____lualib.__TS__Iterator
local ____exports = {}
local __O = {};
(function()
    local som, apertar, nota, parcial, fundo, desenhar, tecla, fechar, LW, LH, BEAT, DURACAO, LINHA, VEL, META, CORES, TECLAS, R, lx, TAU, box, ctx, raf, jogo, aoFim, audio, cfg, fundoCv, ROUPAS, PELES
    function som(self, f, d, tipo, vol)
        if d == nil then
            d = 0.07
        end
        if tipo == nil then
            tipo = "square"
        end
        if vol == nil then
            vol = 0.03
        end
        do
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                local ____t_9 = __t
                local ____opt_6 = window.Game
                if ____opt_6 ~= nil then
                    ____opt_6 = ____opt_6.soundOn
                end
                local ____opt_result_8
                if ____opt_6 ~= nil then
                    ____opt_result_8 = ____opt_6(____opt_6)
                end
                if not ____t_9(____opt_result_8) then
                    return true
                end
                local ____t_result_12
                if __t(audio) then
                    ____t_result_12 = audio
                else
                    local ____newExpr_11 = __newExpr
                    local ____t_result_10
                    if __t(window.AudioContext) then
                        ____t_result_10 = window.AudioContext
                    else
                        ____t_result_10 = window.webkitAudioContext
                    end
                    ____t_result_12 = ____newExpr_11(____t_result_10)
                end
                audio = ____t_result_12
                local o = audio:createOscillator()
                local g = audio:createGain()
                o.type = tipo
                o.frequency.value = f
                g.gain:setValueAtTime(vol, audio.currentTime)
                g.gain:exponentialRampToValueAtTime(0.0001, audio.currentTime + d)
                o:connect(g)
                g:connect(audio.destination)
                o:start()
                o:stop(audio.currentTime + d)
            end)
            if ____try and ____hasReturned then
                return ____returnValue
            end
        end
    end
    function apertar(self, lane)
        local ____t_16 = __t
        local ____t_result_15
        local ____t_14 = __t
        local ____temp_13 = not __t(jogo)
        __O[1430] = ____temp_13
        if ____t_14(____temp_13) then
            ____t_result_15 = __O[1430]
        else
            ____t_result_15 = jogo.fim
        end
        if ____t_16(____t_result_15) then
            return
        end
        __set(jogo.trilha, lane, 0.18)
        local melhor = nil
        local dist = 1
        for ____, n in __iterar((jogo.notas)) do
            do
                if __t(n.ok ~= nil or n.lane ~= lane) then
                    continue
                end
                local d = math.abs(n.t - jogo.t)
                if d < dist then
                    dist = d
                    melhor = n
                end
            end
        end
        local ____t_18 = __t
        local ____t_result_17
        if __t(melhor) then
            ____t_result_17 = dist <= 0.16
        else
            ____t_result_17 = melhor
        end
        if ____t_18(____t_result_17) then
            local ____set_21 = __set
            local ____jogo_20 = jogo
            local ____t_result_19
            if __t(jogo.acerto) then
                ____t_result_19 = jogo.acerto
            else
                ____t_result_19 = __arrL({0, 0, 0, 0}, 4)
            end
            ____jogo_20.acerto = ____t_result_19
            ____set_21(____t_result_19, lane, 0.3)
            melhor.ok = dist <= 0.06 and 1 or 0.7
            jogo.combo = jogo.combo + 1
            jogo.melhorCombo = math.max(jogo.melhorCombo, jogo.combo)
            jogo.msg = dist <= 0.06 and "PERFEITO!" or "BOM!"
            jogo.msgT = 0.45
            jogo.pulo = 0.25
            som(nil, dist <= 0.06 and 880 or 660)
        else
            jogo.combo = 0
            jogo.msg = "FORA DO RITMO"
            jogo.msgT = 0.35
            som(
                nil,
                150,
                0.08,
                "sawtooth",
                0.02
            )
        end
    end
    function nota(self)
        local n = jogo.notas
        return math.floor(__call(
            n,
            "reduce",
            function(____, s, x)
                local ____add_24 = __add
                local ____s_23 = s
                local ____t_result_22
                if __t(x.ok) then
                    ____t_result_22 = x.ok
                else
                    ____t_result_22 = 0
                end
                return ____add_24(____s_23, ____t_result_22)
            end,
            0
        ) / __len(n) * 100 + 0.5)
    end
    function parcial(self)
        local n = __call(
            jogo.notas,
            "filter",
            function(____, x) return x.ok ~= nil end
        )
        local ____t_result_25
        if __t(__len(n)) then
            ____t_result_25 = math.floor(__call(
                n,
                "reduce",
                function(____, s, x) return __add(s, x.ok) end,
                0
            ) / __len(n) * 100 + 0.5)
        else
            ____t_result_25 = 100
        end
        return ____t_result_25
    end
    function fundo(self)
        if __t(fundoCv) then
            return fundoCv
        end
        local PK = window.PixelKit
        fundoCv = window.document:createElement("canvas")
        fundoCv.width = LW
        fundoCv.height = LH
        local c = fundoCv:getContext("2d")
        c.imageSmoothingEnabled = false
        PK:faixas(
            c,
            0,
            0,
            LW,
            LH,
            __arrL({
                "#0a0614",
                "#0e0818",
                "#120a1e",
                "#160c24",
                "#1a0e2a",
                "#1e1030",
                "#221236",
                "#26143a"
            }, 8)
        )
        do
            local y = 16
            while y < 230 do
                do
                    local x = __mod(y / 6, 2) * 6
                    while x < 280 do
                        R(
                            nil,
                            c,
                            x,
                            y,
                            11,
                            1,
                            "rgba(0,0,0,.35)"
                        )
                        R(
                            nil,
                            c,
                            x + 11,
                            y,
                            1,
                            6,
                            "rgba(0,0,0,.3)"
                        )
                        x = x + 12
                    end
                end
                y = y + 6
            end
        end
        R(
            nil,
            c,
            0,
            2,
            282,
            2,
            "#5a5a6a"
        )
        R(
            nil,
            c,
            0,
            12,
            282,
            2,
            "#5a5a6a"
        )
        do
            local x = 0
            while x < 282 do
                do
                    local k = 0
                    while k < 9 do
                        R(
                            nil,
                            c,
                            x + k / 2,
                            12 - k,
                            1,
                            1,
                            "#4a4a58"
                        )
                        R(
                            nil,
                            c,
                            x + 9 - k / 2,
                            12 - k,
                            1,
                            1,
                            "#4a4a58"
                        )
                        k = k + 1
                    end
                end
                x = x + 10
            end
        end
        for ____, x in __iterar((__arrL({
            30,
            85,
            140,
            195,
            250
        }, 5))) do
            R(
                nil,
                c,
                x - 4,
                14,
                9,
                7,
                "#2a2a34"
            )
            R(
                nil,
                c,
                x - 3,
                20,
                7,
                2,
                "#5a5a6a"
            )
            R(
                nil,
                c,
                x - 2,
                21,
                5,
                1,
                "#e8e8f0"
            )
            R(
                nil,
                c,
                x,
                13,
                1,
                2,
                "#3a3a44"
            )
        end
        PK:painel(
            c,
            12,
            46,
            256,
            106,
            {fundo = "#05030a", borda = "#3a3048", luz = "rgba(255,255,255,.12)", sombra = false}
        )
        do
            local y = 50
            while y < 148 do
                R(
                    nil,
                    c,
                    16,
                    y,
                    248,
                    1,
                    "rgba(255,255,255,.03)"
                )
                y = y + 2
            end
        end
        for ____, x0 in __iterar((__arrL({0, 260}, 2))) do
            do
                local k = 0
                while k < 3 do
                    local y = 156 + k * 25
                    R(
                        nil,
                        c,
                        x0,
                        y,
                        22,
                        24,
                        "#16121e"
                    )
                    R(
                        nil,
                        c,
                        x0,
                        y,
                        22,
                        1,
                        "#3a3448"
                    )
                    R(
                        nil,
                        c,
                        x0 + 1,
                        y + 1,
                        1,
                        22,
                        "#2a2436"
                    )
                    do
                        local yy = -6
                        while yy <= 6 do
                            local w = math.floor(math.sqrt(36 - yy * yy) + 0.5)
                            R(
                                nil,
                                c,
                                x0 + 11 - w,
                                y + 12 + yy,
                                w * 2,
                                1,
                                "#0a080e"
                            )
                            yy = yy + 1
                        end
                    end
                    do
                        local yy = -3
                        while yy <= 3 do
                            local w = math.floor(math.sqrt(9 - yy * yy) + 0.5)
                            R(
                                nil,
                                c,
                                x0 + 11 - w,
                                y + 12 + yy,
                                w * 2,
                                1,
                                "#2a2436"
                            )
                            yy = yy + 1
                        end
                    end
                    R(
                        nil,
                        c,
                        x0 + 10,
                        y + 11,
                        2,
                        2,
                        "#5a5468"
                    )
                    k = k + 1
                end
            end
        end
        R(
            nil,
            c,
            0,
            228,
            282,
            2,
            "#5a4a6a"
        )
        R(
            nil,
            c,
            0,
            230,
            282,
            14,
            "#1a1428"
        )
        do
            local x = 0
            while x < 282 do
                R(
                    nil,
                    c,
                    x,
                    231,
                    19,
                    12,
                    "#221a32"
                )
                x = x + 20
            end
        end
        PK:painel(
            c,
            282,
            2,
            196,
            266,
            {fundo = "#0a0614", borda = "#4a2a5a", luz = "rgba(255,255,255,.1)", sombra = false}
        )
        do
            local i = 0
            while i < 4 do
                R(
                    nil,
                    c,
                    lx(nil, i) - 15,
                    6,
                    30,
                    258,
                    "rgba(255,255,255,.025)"
                )
                R(
                    nil,
                    c,
                    lx(nil, i) - 16,
                    6,
                    1,
                    258,
                    "#1e1430"
                )
                i = i + 1
            end
        end
        return fundoCv
    end
    function desenhar(self)
        local c = ctx
        local t = jogo.t
        local beat = math.floor(t / BEAT)
        local fase = __mod(t, BEAT) / BEAT
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
                "#0a0618"
            )
            return
        end
        c:drawImage(
            fundo(nil),
            0,
            0
        )
        do
            local k = 0
            while k < 30 do
                local h = math.floor((math.abs(math.sin(t * 3 + k * 0.7)) * 0.6 + (1 - fase) * 0.4) * (20 + PK:hash(k + beat) * 46) + 0.5)
                do
                    local y = 0
                    while y < h do
                        R(
                            nil,
                            c,
                            20 + k * 8,
                            146 - y,
                            6,
                            2,
                            y > 50 and "#ff4fa8" or (y > 30 and "#ffd24a" or __get(
                                CORES,
                                __mod(k + beat, 4)
                            ))
                        )
                        y = y + 3
                    end
                end
                k = k + 1
            end
        end
        PK:contorno(
            c,
            cfg.titulo,
            140,
            __t(cfg.versos) and 60 or 64,
            8,
            "#ffffff",
            "#3a1a4a"
        )
        c:save()
        c.globalCompositeOperation = "lighter"
        do
            local i = 0
            while i < 5 do
                local x = 30 + i * 55
                local a = math.sin(t * 0.9 + i) * 0.4
                c.globalAlpha = 0.1
                c.fillStyle = __get(
                    CORES,
                    __mod(i + beat, 4)
                )
                c:beginPath()
                c:moveTo(x - 2, 22)
                c:lineTo(x + 2, 22)
                c:lineTo(
                    x + math.sin(a) * 200 + 26,
                    230
                )
                c:lineTo(
                    x + math.sin(a) * 200 - 26,
                    230
                )
                c:closePath()
                __call(c, "fill")
                i = i + 1
            end
        end
        c:restore()
        if fase < 0.2 then
            for ____, x0 in __iterar((__arrL({0, 260}, 2))) do
                do
                    local k = 0
                    while k < 3 do
                        local y = 168 + k * 25
                        do
                            local a = 0
                            while a < 16 do
                                R(
                                    nil,
                                    c,
                                    x0 + 11 + math.cos(a / 16 * TAU) * 7,
                                    y + math.sin(a / 16 * TAU) * 7,
                                    1,
                                    1,
                                    "#ff4fa8"
                                )
                                a = a + 1
                            end
                        end
                        k = k + 1
                    end
                end
            end
        end
        do
            local x = 0
            while x < 282 do
                if __mod(x / 20 + beat, 3) == 0 then
                    R(
                        nil,
                        c,
                        x,
                        231,
                        19,
                        12,
                        __get(
                            CORES,
                            __mod(x / 20 + beat, 4)
                        )
                    )
                    R(
                        nil,
                        c,
                        x,
                        231,
                        19,
                        2,
                        "#ffffff"
                    )
                end
                x = x + 20
            end
        end
        do
            pcall(function()
                local ____opt_33 = window.Art
                if ____opt_33 ~= nil then
                    ____opt_33 = ____opt_33.drawCharacter
                end
                if ____opt_33 ~= nil then
                    local ____cfg_rival_31 = cfg.rival
                    local ____temp_30 = t * 2
                    local ____t_result_29
                    if __t(cfg.versos) then
                        ____t_result_29 = __mod(
                            math.floor(t / (BEAT * 8)),
                            2
                        ) == 0
                    else
                        ____t_result_29 = cfg.versos
                    end
                    ____opt_33(
                        ____opt_33,
                        c,
                        ____cfg_rival_31,
                        52,
                        230,
                        {
                            frame = ____temp_30,
                            facing = 1,
                            grounded = true,
                            scale = 0.9,
                            attack = ____t_result_29,
                            attackProgress = __mod(t, BEAT) / BEAT
                        }
                    )
                end
                local pula = math.abs(math.sin(t * math.pi / BEAT)) * 6 + jogo.pulo * 14
                local ____opt_37 = window.Art
                if ____opt_37 ~= nil then
                    ____opt_37 = ____opt_37.drawCharacter
                end
                if ____opt_37 ~= nil then
                    ____opt_37(
                        ____opt_37,
                        c,
                        "daroca",
                        138,
                        230 - pula,
                        {
                            frame = t * 2.2,
                            facing = __t(__mod(beat, 2)) and 1 or -1,
                            moving = true,
                            grounded = pula < 2,
                            scale = 1
                        }
                    )
                end
                if __t(cfg.premioLook) then
                    R(
                        nil,
                        c,
                        212,
                        160,
                        4,
                        70,
                        "#8a7a5a"
                    )
                    R(
                        nil,
                        c,
                        200,
                        228,
                        28,
                        4,
                        "#6a5a3a"
                    )
                    local ____opt_41 = window.Art
                    if ____opt_41 ~= nil then
                        ____opt_41 = ____opt_41.drawCharacter
                    end
                    if ____opt_41 ~= nil then
                        ____opt_41(
                            ____opt_41,
                            c,
                            "daroca",
                            214,
                            226,
                            {
                                frame = 0,
                                facing = -1,
                                grounded = true,
                                scale = 0.82,
                                look = {
                                    costume = cfg.premioLook,
                                    hat = "palha",
                                    hatColor = "#c0392b",
                                    hairStyle = "curto",
                                    hairColor = "#5f4934",
                                    shirt = "#dc8c47",
                                    shirtLight = "#e7ac65",
                                    pants = "#455b62"
                                }
                            }
                        )
                    end
                end
            end)
        end
        if __t(cfg.premio) then
            PK:painel(
                c,
                176,
                236,
                76,
                14,
                {fundo = "#2a1a08", borda = "#ffd24a", sombra = false}
            )
            PK:texto(
                c,
                cfg.premio,
                214,
                243,
                8,
                "#ffe9a8"
            )
        end
        if __t(cfg.versos) then
            local i = math.floor(math.max(0, t) / (BEAT * 8))
            local seu = __mod(i, 2) == 1
            local v = __get(
                cfg.versos,
                __mod(
                    i,
                    __len(cfg.versos)
                )
            )
            PK:painel(
                c,
                16,
                74,
                248,
                32,
                {
                    fundo = "#0e0818",
                    borda = __t(seu) and "#3fe0ff" or "#ff4fa8",
                    sombra = false
                }
            )
            PK:texto(
                c,
                __add(
                    __t(seu) and "DA ROÇA: " or "FREDDY: ",
                    __get(v, 0)
                ),
                22,
                83,
                8,
                __t(seu) and "#9af4ff" or "#ffb0d8",
                "left"
            )
            PK:texto(
                c,
                __get(v, 1),
                22,
                95,
                8,
                "#f2f2ea",
                "left"
            )
            local px = __t(seu) and 138 or 52
            do
                local k = 0
                while k < 2 do
                    local u = __mod(t * 0.8 + k / 2, 1)
                    local nx = math.floor(px + 12 + k * 6 + math.sin(t * 3 + k) * 2 + 0.5)
                    local ny = math.floor(168 - u * 30 + 0.5)
                    local cor = __t(seu) and "#3fe0ff" or "#ff4fa8"
                    c.globalAlpha = 1 - u
                    R(
                        nil,
                        c,
                        nx + 2,
                        ny,
                        1,
                        6,
                        cor
                    )
                    R(
                        nil,
                        c,
                        nx,
                        ny + 5,
                        3,
                        2,
                        cor
                    )
                    R(
                        nil,
                        c,
                        nx + 3,
                        ny,
                        2,
                        1,
                        cor
                    )
                    R(
                        nil,
                        c,
                        nx + 4,
                        ny + 1,
                        1,
                        1,
                        cor
                    )
                    c.globalAlpha = 1
                    k = k + 1
                end
            end
        end
        do
            local k = 0
            while k < 24 do
                local x = 2 + k * 11.5
                local grupo = __mod(k + beat, 3)
                local pula = grupo == 0 and fase < 0.5
                local y = 250 + __mod(k, 2) * 4
                local ____PK_pessoa_49 = PK.pessoa
                local ____get_result_47 = __get(
                    PELES,
                    __mod(k, 5)
                )
                local ____get_result_48 = __get(
                    ROUPAS,
                    __mod(k, 8)
                )
                local ____t_result_46
                local ____t_44 = __t
                local ____temp_43 = __mod(k, 4) == 1
                __O[1431] = ____temp_43
                if ____t_44(____temp_43) then
                    ____t_result_46 = __O[1431]
                else
                    local ____t_result_45
                    if __t(pula) then
                        ____t_result_45 = __mod(k, 2) == 0
                    else
                        ____t_result_45 = pula
                    end
                    ____t_result_46 = ____t_result_45
                end
                ____PK_pessoa_49(
                    PK,
                    c,
                    x,
                    y,
                    ____get_result_47,
                    ____get_result_48,
                    "#1c1410",
                    pula,
                    ____t_result_46
                )
                if __mod(k, 6) == 2 then
                    R(
                        nil,
                        c,
                        x + 7,
                        y - 6,
                        2,
                        3,
                        "#e8e8f0"
                    )
                    if fase < 0.5 then
                        R(
                            nil,
                            c,
                            x + 7,
                            y - 7,
                            2,
                            1,
                            "#ffffff"
                        )
                    end
                end
                k = k + 1
            end
        end
        do
            local i = 0
            while i < 4 do
                local on = __gt(
                    __get(jogo.trilha, i),
                    0
                )
                if __t(on) then
                    c.globalAlpha = 0.25
                    R(
                        nil,
                        c,
                        lx(nil, i) - 14,
                        6,
                        28,
                        LINHA,
                        __get(CORES, i)
                    )
                    c.globalAlpha = 1
                end
                local ____temp_51 = lx(nil, i) - 16
                local ____temp_52 = LINHA - 1
                local ____t_result_50
                if __t(on) then
                    ____t_result_50 = __get(CORES, i)
                else
                    ____t_result_50 = "#3a2a4a"
                end
                R(
                    nil,
                    c,
                    ____temp_51,
                    ____temp_52,
                    32,
                    2,
                    ____t_result_50
                )
                if __t(on) then
                    PK:seta(
                        c,
                        lx(nil, i),
                        LINHA,
                        i,
                        "#ffffff",
                        2,
                        __get(CORES, i)
                    )
                else
                    PK:alvo(
                        c,
                        lx(nil, i),
                        LINHA,
                        i,
                        "#8a7a9a",
                        2
                    )
                end
                local ____t_result_53
                if __t(jogo.acerto) then
                    ____t_result_53 = __get(jogo.acerto, i)
                else
                    ____t_result_53 = 0
                end
                local ac = ____t_result_53
                if __gt(ac, 0) then
                    local r = math.floor(6 + (1 - ac / 0.3) * 14 + 0.5)
                    do
                        local a = 0
                        while a < 12 do
                            R(
                                nil,
                                c,
                                lx(nil, i) + math.cos(a / 12 * TAU) * r,
                                LINHA + math.sin(a / 12 * TAU) * r,
                                2,
                                2,
                                __get(CORES, i)
                            )
                            a = a + 1
                        end
                    end
                    PK:brilho4(
                        c,
                        lx(nil, i),
                        LINHA,
                        5,
                        "#ffffff"
                    )
                end
                i = i + 1
            end
        end
        for ____, n in __iterar((jogo.notas)) do
            do
                if __t(n.ok) then
                    continue
                end
                local y = LINHA - (n.t - t) * VEL
                if __t(y < -14 or y > LH + 14) then
                    continue
                end
                PK:seta(
                    c,
                    lx(nil, n.lane),
                    y,
                    n.lane,
                    n.ok == 0 and "#5a3a3a" or __get(CORES, n.lane),
                    2
                )
            end
        end
        local ____t_result_54
        if __t(jogo.fim) then
            ____t_result_54 = nota(nil)
        else
            ____t_result_54 = parcial(nil)
        end
        local pct = ____t_result_54
        PK:painel(
            c,
            290,
            4,
            180,
            16,
            {fundo = "#120a1e", borda = pct >= META and "#7af07a" or "#ff9a7a", sombra = false}
        )
        PK:texto(
            c,
            ((("ACERTO " .. tostring(pct)) .. "%  META ") .. tostring(META)) .. "%",
            380,
            12,
            8,
            pct >= META and "#c8ffc8" or "#ffd0c0"
        )
        if __gt(jogo.combo, 2) then
            PK:contorno(
                c,
                __add("COMBO ", jogo.combo),
                360,
                240,
                __gt(jogo.pulo, 0.15) and 16 or 8,
                "#ffd24a",
                "#3a1a0a"
            )
        end
        if __gt(jogo.msgT, 0) then
            PK:contorno(
                c,
                jogo.msg,
                360,
                130,
                8,
                jogo.msg == "FORA DO RITMO" and "#ff7a6a" or "#9aff9a",
                "#0a0614"
            )
        end
        PK:barra(
            c,
            292,
            258,
            156,
            5,
            math.min(1, t / DURACAO),
            {gomos = 26, cheio = "#ff4fa8", vazio = "#2a2040", borda = "#0a0614"}
        )
        if __lt(jogo.t, 2) then
            PK:contorno(
                c,
                __lt(jogo.t, 1) and "PREPARA..." or "VAI!",
                360,
                100,
                16,
                "#ffffff",
                "#3a1a4a"
            )
        end
        if __t(jogo.fim) then
            PK:painel(
                c,
                40,
                100,
                400,
                64,
                {fundo = "#0e0818", borda = pct >= META and "#7af07a" or "#ffd24a", rebite = "#ff4fa8"}
            )
            PK:texto(
                c,
                ("NOTA " .. tostring(pct)) .. "%",
                LW / 2,
                120,
                16,
                pct >= META and "#b8ffb8" or "#ffe9a8"
            )
            local ____PK_texto_56 = PK.texto
            local ____temp_55
            if pct >= META then
                ____temp_55 = cfg.ganhou
            else
                ____temp_55 = "FALTOU POUCO!"
            end
            ____PK_texto_56(
                PK,
                c,
                ____temp_55,
                LW / 2,
                144,
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
            local ____fechar_58 = fechar
            local ____t_result_57
            if __t(jogo) then
                ____t_result_57 = nota(nil)
            else
                ____t_result_57 = 0
            end
            ____fechar_58(nil, false, ____t_result_57, true)
            return
        end
        local lane = __get(TECLAS, e.code)
        if lane == nil then
            return
        end
        e:preventDefault()
        e:stopPropagation()
        if not __t(e["repeat"]) then
            apertar(nil, lane)
        end
    end
    function fechar(self, ok, pct, desistiu)
        if desistiu == nil then
            desistiu = false
        end
        if not __t(box) then
            return
        end
        window:cancelAnimationFrame(raf)
        window:removeEventListener("keydown", tecla, true)
        box:remove()
        box = nil
        jogo = nil
        window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {active = false}}))
        local ____opt_67 = window.document:getElementById("gameCanvas")
        local ____opt_65 = ____opt_67 and ____opt_67.focus
        if ____opt_65 ~= nil then
            ____opt_65(____opt_67)
        end
        local fn = aoFim
        aoFim = nil
        if __t(fn) then
            do
                pcall(function()
                    local ____temp_70 = not not __t(ok)
                    local ____t_result_69
                    if __t(pct) then
                        ____t_result_69 = pct
                    else
                        ____t_result_69 = 0
                    end
                    fn(nil, ____temp_70, ____t_result_69, desistiu)
                end)
            end
        end
    end
    local ____ = "use strict"
    if __t(window.BaileConcurso) then
        return
    end
    LW = 480
    LH = 270
    local BPM = 128
    BEAT = 60 / BPM
    DURACAO = 30
    LINHA = 214
    VEL = 150
    META = 70
    CORES = __arrL({"#ff4fa8", "#3fe0ff", "#5dff9a", "#ffd24a"}, 4)
    local SETAS = __arrL({"←", "↓", "↑", "→"}, 4)
    TECLAS = __ord({
        ArrowLeft = 0,
        KeyA = 0,
        ArrowDown = 1,
        KeyS = 1,
        ArrowUp = 2,
        KeyW = 2,
        ArrowRight = 3,
        KeyD = 3
    }, "ArrowLeft,KeyA,ArrowDown,KeyS,ArrowUp,KeyW,ArrowRight,KeyD")
    R = function(____, c, x, y, w, h, cor)
        c.fillStyle = cor
        c:fillRect(
            math.floor(x + 0.5),
            math.floor(y + 0.5),
            math.floor(w + 0.5),
            math.floor(h + 0.5)
        )
    end
    lx = function(____, i) return 300 + i * 40 end
    TAU = math.pi * 2
    box = nil
    local cv = nil
    ctx = nil
    raf = 0
    jogo = nil
    aoFim = nil
    audio = nil
    cfg = {}
    local PADRAO = __ord({
        titulo = "CONCURSO DA FANTASIA",
        rival = "mc_batidao",
        premio = "DA JEGUE",
        premioLook = "dajegue",
        ganhou = "O BAILE GRITOU: DA JEGUE!",
        perdeu = "FALTOU POUCO!",
        versos = nil
    }, "titulo,rival,premio,premioLook,ganhou,perdeu,versos")
    local function mapa(self)
        local notas = __arrL({}, 0)
        local seed = 7
        local function rnd()
            seed = __mod(seed * 9301 + 49297, 233280)
            return seed / 233280
        end
        do
            local b = 4
            while b < DURACAO / BEAT - 2 do
                local t = b * BEAT
                local compasso = math.floor(b / 8)
                __call(
                    notas,
                    "push",
                    {
                        t = t,
                        lane = __mod(b + compasso, 4) == 0 and 0 or math.floor(rnd(nil) * 4)
                    }
                )
                local ____t_3 = __t
                local ____t_result_2
                local ____t_1 = __t
                local ____temp_0 = __mod(compasso, 2) == 1 and __mod(b, 2) == 1
                __O[1429] = ____temp_0
                if ____t_1(____temp_0) then
                    ____t_result_2 = rnd(nil) < 0.55
                else
                    ____t_result_2 = __O[1429]
                end
                if ____t_3(____t_result_2) then
                    __call(
                        notas,
                        "push",
                        {
                            t = t + BEAT / 2,
                            lane = math.floor(rnd(nil) * 4)
                        }
                    )
                end
                if __mod(b, 16) == 15 then
                    __call(
                        notas,
                        "push",
                        {
                            t = t,
                            lane = __mod(
                                __get(
                                    notas,
                                    __len(notas) - 1
                                ).lane + 2,
                                4
                            )
                        }
                    )
                end
                b = b + 1
            end
        end
        return __call(
            __call(
                notas,
                "sort",
                function(____, a, b) return a.t - b.t end
            ),
            "map",
            function(____, n) return __assign({}, n, {ok = nil}) end
        )
    end
    local function quadro(self, agora)
        if not __t(jogo) then
            return
        end
        local ____agora_27 = agora
        local ____t_result_26
        if __t(jogo.ultimo) then
            ____t_result_26 = jogo.ultimo
        else
            ____t_result_26 = agora
        end
        local dt = math.min(0.1, (____agora_27 - ____t_result_26) / 1000)
        jogo.ultimo = agora
        jogo.t = jogo.t + dt
        jogo.msgT = jogo.msgT - dt
        jogo.pulo = math.max(0, jogo.pulo - dt)
        do
            local i = 0
            while i < 4 do
                __set(
                    jogo.trilha,
                    i,
                    math.max(
                        0,
                        __get(jogo.trilha, i) - dt
                    )
                )
                if __t(jogo.acerto) then
                    __set(
                        jogo.acerto,
                        i,
                        math.max(
                            0,
                            __get(jogo.acerto, i) - dt
                        )
                    )
                end
                i = i + 1
            end
        end
        for ____, n in __iterar((jogo.notas)) do
            if __t(n.ok == nil and jogo.t - n.t > 0.18) then
                n.ok = 0
                jogo.combo = 0
            end
        end
        desenhar(nil)
        if __t(__gt(jogo.t, DURACAO) and not __t(jogo.fim)) then
            jogo.fim = true
            local pct = nota(nil)
            window:setTimeout(
                function() return fechar(nil, pct >= META, pct) end,
                900
            )
        end
        raf = window:requestAnimationFrame(quadro)
    end
    fundoCv = nil
    ROUPAS = __arrL({
        "#e8433a",
        "#3a6aa8",
        "#f2c94c",
        "#3c8a5a",
        "#c84a8a",
        "#f2f2ee",
        "#e8843a",
        "#6a4ac8"
    }, 8)
    PELES = __arrL({
        "#f0c8a0",
        "#c48a62",
        "#8a5a3c",
        "#5a3a28",
        "#e8b88a"
    }, 5)
    local function montar(self)
        if __t(box) then
            return
        end
        if not __t(window.document:getElementById("bcEstilo")) then
            local st = window.document:createElement("style")
            st.id = "bcEstilo"
            st.textContent = ".bc-overlay{position:fixed;inset:0;z-index:9000;background:rgba(6,4,14,.86);display:flex;flex-direction:column;align-items:center;justify-content:center;gap:10px;font-family:monospace;touch-action:none;user-select:none}.bc-overlay canvas{width:min(96vw,calc(78vh*16/9),960px);aspect-ratio:16/9;image-rendering:pixelated;border:4px solid #2a1438;box-shadow:0 0 0 2px #ff4fa8,0 0 18px #ff4fa866;border-radius:0;background:#0a0618}.bc-botoes{display:flex;gap:10px}.bc-botoes button{width:64px;height:56px;font:24px Pixel,monospace;color:#fff;background:#2a1438;border:0;border-radius:0;box-shadow:0 0 0 3px currentColor,inset 0 -5px 0 #14081e,inset 0 3px 0 #5a3a6a;text-shadow:2px 2px 0 #0a0614}.bc-botoes button:active{background:#5a2a6a;transform:translateY(2px)}.bc-sair{font:8px Pixel,monospace;color:#ffd24a;background:#1a0e24;border:0;border-radius:0;padding:8px 14px;box-shadow:0 0 0 2px #ffd24a}"
            window.document.head:append(st)
        end
        box = window.document:createElement("div")
        box.className = "bc-overlay"
        box:setAttribute("role", "dialog")
        box:setAttribute("aria-label", "Concurso da Fantasia")
        cv = window.document:createElement("canvas")
        cv.width = LW
        cv.height = LH
        ctx = cv:getContext("2d")
        box:append(cv)
        local bt = window.document:createElement("div")
        bt.className = "bc-botoes"
        __call(
            SETAS,
            "forEach",
            function(____, s, i)
                local b = window.document:createElement("button")
                b.type = "button"
                b.textContent = s
                b.style.color = __get(CORES, i)
                b:setAttribute(
                    "aria-label",
                    __add(
                        "seta ",
                        __get(
                            __arrL({"esquerda", "baixo", "cima", "direita"}, 4),
                            i
                        )
                    )
                )
                b:addEventListener(
                    "pointerdown",
                    function(____, e)
                        e:preventDefault()
                        apertar(nil, i)
                    end
                )
                bt:append(b)
            end
        )
        box:append(bt)
        local sair = window.document:createElement("button")
        sair.type = "button"
        sair.className = "bc-sair"
        sair.textContent = "DESISTIR (Esc)"
        sair:addEventListener(
            "click",
            function()
                local ____fechar_60 = fechar
                local ____t_result_59
                if __t(jogo) then
                    ____t_result_59 = nota(nil)
                else
                    ____t_result_59 = 0
                end
                return ____fechar_60(nil, false, ____t_result_59, true)
            end
        )
        box:append(sair)
        window.document.body:append(box)
        window:addEventListener("keydown", tecla, true)
    end
    local function abrir(self, o)
        if o == nil then
            o = {}
        end
        if __t(box) then
            return false
        end
        local ____t_result_61
        if __t(o.onFim) then
            ____t_result_61 = o.onFim
        else
            ____t_result_61 = nil
        end
        aoFim = ____t_result_61
        local ____assign_64 = __assign
        local ____temp_63 = {}
        local ____t_result_62
        if __t(o.config) then
            ____t_result_62 = o.config
        else
            ____t_result_62 = {}
        end
        cfg = ____assign_64(____temp_63, PADRAO, ____t_result_62)
        montar(nil)
        jogo = {
            t = -1,
            notas = mapa(nil),
            combo = 0,
            melhorCombo = 0,
            msg = "",
            msgT = 0,
            pulo = 0,
            trilha = __arrL({0, 0, 0, 0}, 4),
            fim = false,
            ultimo = 0
        }
        window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {active = true}}))
        window:cancelAnimationFrame(raf)
        raf = window:requestAnimationFrame(quadro)
        return true
    end
    window.BaileConcurso = __ord(
        {
            abrir = abrir,
            fechar = function() return fechar(nil, false, 0, true) end,
            aberto = function() return not not __t(box) end,
            META = META,
            estado = function()
                local ____t_result_71
                if __t(jogo) then
                    ____t_result_71 = {
                        t = jogo.t,
                        nota = nota(nil),
                        notas = __call(
                            jogo.notas,
                            "map",
                            function(____, n) return {t = n.t, lane = n.lane, ok = n.ok} end
                        )
                    }
                else
                    ____t_result_71 = jogo
                end
                return ____t_result_71
            end
        },
        "abrir,fechar,aberto,META,estado"
    )
end)(nil)
return ____exports
