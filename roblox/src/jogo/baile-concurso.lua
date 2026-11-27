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
                local ____t_8 = __t
                local ____opt_5 = window.Game
                if ____opt_5 ~= nil then
                    ____opt_5 = ____opt_5.soundOn
                end
                local ____opt_result_7
                if ____opt_5 ~= nil then
                    ____opt_result_7 = ____opt_5(____opt_5)
                end
                if not ____t_8(____opt_result_7) then
                    return true
                end
                audio = if __t(audio) then audio else __newExpr(if __t(window.AudioContext) then window.AudioContext else window.webkitAudioContext)
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
        local ____t_11 = __t
        local ____t_10 = __t
        local ____temp_9 = not __t(jogo)
        __O[1411] = ____temp_9
        if ____t_11(if ____t_10(____temp_9) then __O[1411] else jogo.fim) then
            return
        end
        __set(jogo.trilha, lane, 0.18)
        local melhor = nil
        local dist = 1
        for ____, n in __iterar((jogo.notas)) do
            if __t(n.ok ~= nil or n.lane ~= lane) then
                continue
            end
            local d = math.abs(n.t - jogo.t)
            if d < dist then
                dist = d
                melhor = n
            end
        end
        if __t(if __t(melhor) then dist <= 0.16 else melhor) then
            local ____set_13 = __set
            local ____temp_12 = if __t(jogo.acerto) then jogo.acerto else __arrL({0, 0, 0, 0}, 4)
            jogo.acerto = ____temp_12
            ____set_13(____temp_12, lane, 0.3)
            melhor.ok = if dist <= 0.06 then 1 else 0.7
            jogo.combo = jogo.combo + 1
            jogo.melhorCombo = math.max(jogo.melhorCombo, jogo.combo)
            jogo.msg = if dist <= 0.06 then "PERFEITO!" else "BOM!"
            jogo.msgT = 0.45
            jogo.pulo = 0.25
            som(nil, if dist <= 0.06 then 880 else 660)
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
            function(____, s, x) return __add(s, if __t(x.ok) then x.ok else 0) end,
            0
        ) / __len(n) * 100 + 0.5)
    end
    function parcial(self)
        local n = __call(
            jogo.notas,
            "filter",
            function(____, x) return x.ok ~= nil end
        )
        return if __t(__len(n)) then math.floor(__call(
            n,
            "reduce",
            function(____, s, x) return __add(s, x.ok) end,
            0
        ) / __len(n) * 100 + 0.5) else 100
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
                            if y > 50 then "#ff4fa8" else if y > 30 then "#ffd24a" else __get(
                                CORES,
                                __mod(k + beat, 4)
                            )
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
            if __t(cfg.versos) then 60 else 64,
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
                local ____opt_16 = window.Art
                if ____opt_16 ~= nil then
                    ____opt_16 = ____opt_16.drawCharacter
                end
                if ____opt_16 ~= nil then
                    ____opt_16(
                        ____opt_16,
                        c,
                        cfg.rival,
                        52,
                        230,
                        {
                            frame = t * 2,
                            facing = 1,
                            grounded = true,
                            scale = 0.9,
                            attack = if __t(cfg.versos) then __mod(
                                math.floor(t / (BEAT * 8)),
                                2
                            ) == 0 else cfg.versos,
                            attackProgress = __mod(t, BEAT) / BEAT
                        }
                    )
                end
                local pula = math.abs(math.sin(t * math.pi / BEAT)) * 6 + jogo.pulo * 14
                local ____opt_20 = window.Art
                if ____opt_20 ~= nil then
                    ____opt_20 = ____opt_20.drawCharacter
                end
                if ____opt_20 ~= nil then
                    ____opt_20(
                        ____opt_20,
                        c,
                        "daroca",
                        138,
                        230 - pula,
                        {
                            frame = t * 2.2,
                            facing = if __t(__mod(beat, 2)) then 1 else -1,
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
                    local ____opt_24 = window.Art
                    if ____opt_24 ~= nil then
                        ____opt_24 = ____opt_24.drawCharacter
                    end
                    if ____opt_24 ~= nil then
                        ____opt_24(
                            ____opt_24,
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
                {fundo = "#0e0818", borda = if __t(seu) then "#3fe0ff" else "#ff4fa8", sombra = false}
            )
            PK:texto(
                c,
                __add(
                    if __t(seu) then "DA ROÇA: " else "FREDDY: ",
                    __get(v, 0)
                ),
                22,
                83,
                8,
                if __t(seu) then "#9af4ff" else "#ffb0d8",
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
            local px = if __t(seu) then 138 else 52
            do
                local k = 0
                while k < 2 do
                    local u = __mod(t * 0.8 + k / 2, 1)
                    local nx = math.floor(px + 12 + k * 6 + math.sin(t * 3 + k) * 2 + 0.5)
                    local ny = math.floor(168 - u * 30 + 0.5)
                    local cor = if __t(seu) then "#3fe0ff" else "#ff4fa8"
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
                local ____PK_pessoa_30 = PK.pessoa
                local ____get_result_28 = __get(
                    PELES,
                    __mod(k, 5)
                )
                local ____get_result_29 = __get(
                    ROUPAS,
                    __mod(k, 8)
                )
                local ____t_27 = __t
                local ____temp_26 = __mod(k, 4) == 1
                __O[1412] = ____temp_26
                ____PK_pessoa_30(
                    PK,
                    c,
                    x,
                    y,
                    ____get_result_28,
                    ____get_result_29,
                    "#1c1410",
                    pula,
                    if ____t_27(____temp_26) then __O[1412] else if __t(pula) then __mod(k, 2) == 0 else pula
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
                R(
                    nil,
                    c,
                    lx(nil, i) - 16,
                    LINHA - 1,
                    32,
                    2,
                    if __t(on) then __get(CORES, i) else "#3a2a4a"
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
                local ac = if __t(jogo.acerto) then __get(jogo.acerto, i) else 0
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
                if n.ok == 0 then "#5a3a3a" else __get(CORES, n.lane),
                2
            )
        end
        local pct = if __t(jogo.fim) then nota(nil) else parcial(nil)
        PK:painel(
            c,
            290,
            4,
            180,
            16,
            {fundo = "#120a1e", borda = if pct >= META then "#7af07a" else "#ff9a7a", sombra = false}
        )
        PK:texto(
            c,
            ((("ACERTO " .. tostring(pct)) .. "%  META ") .. tostring(META)) .. "%",
            380,
            12,
            8,
            if pct >= META then "#c8ffc8" else "#ffd0c0"
        )
        if __gt(jogo.combo, 2) then
            PK:contorno(
                c,
                __add("COMBO ", jogo.combo),
                360,
                240,
                if __gt(jogo.pulo, 0.15) then 16 else 8,
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
                if jogo.msg == "FORA DO RITMO" then "#ff7a6a" else "#9aff9a",
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
                if __lt(jogo.t, 1) then "PREPARA..." else "VAI!",
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
                {fundo = "#0e0818", borda = if pct >= META then "#7af07a" else "#ffd24a", rebite = "#ff4fa8"}
            )
            PK:texto(
                c,
                ("NOTA " .. tostring(pct)) .. "%",
                LW / 2,
                120,
                16,
                if pct >= META then "#b8ffb8" else "#ffe9a8"
            )
            PK:texto(
                c,
                if pct >= META then cfg.ganhou else "FALTOU POUCO!",
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
            fechar(nil, false, if __t(jogo) then nota(nil) else 0, true)
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
        local ____opt_33 = window.document:getElementById("gameCanvas")
        local ____opt_31 = ____opt_33 and ____opt_33.focus
        if ____opt_31 ~= nil then
            ____opt_31(____opt_33)
        end
        local fn = aoFim
        aoFim = nil
        if __t(fn) then
            do
                pcall(function()
                    fn(
                        nil,
                        not not __t(ok),
                        if __t(pct) then pct else 0,
                        desistiu
                    )
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
                __call(notas, "push", {t = t, lane = if __mod(b + compasso, 4) == 0 then 0 else math.floor(rnd(nil) * 4)})
                local ____t_2 = __t
                local ____t_1 = __t
                local ____temp_0 = __mod(compasso, 2) == 1 and __mod(b, 2) == 1
                __O[1410] = ____temp_0
                if ____t_2(if ____t_1(____temp_0) then rnd(nil) < 0.55 else __O[1410]) then
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
        local dt = math.min(0.1, (agora - if __t(jogo.ultimo) then jogo.ultimo else agora) / 1000)
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
            function() return fechar(nil, false, if __t(jogo) then nota(nil) else 0, true) end
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
        aoFim = if __t(o.onFim) then o.onFim else nil
        cfg = __assign({}, PADRAO, if __t(o.config) then o.config else {})
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
            estado = function() return if __t(jogo) then {
                t = jogo.t,
                nota = nota(nil),
                notas = __call(
                    jogo.notas,
                    "map",
                    function(____, n) return {t = n.t, lane = n.lane, ok = n.ok} end
                )
            } else jogo end
        },
        "abrir,fechar,aberto,META,estado"
    )
end)(nil)
return ____exports
