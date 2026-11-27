--!native
--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __NumberV, __lt, __le, __gt, __mod, __ord, __arrL, __iterar, __t, __get, __call, __add = __JSR.__NumberV, __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__call, __JSR.__add
local __re, __re_match = __JSR.__re, __JSR.__re_match
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__ParseInt = ____lualib.__TS__ParseInt
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local __TS__Iterator = ____lualib.__TS__Iterator
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    if __t(window.EstradaViagem) then
        return
    end
    local DUR = 2.8
    local function clamp(____, v, a, b)
        return math.max(
            a,
            math.min(b, v)
        )
    end
    local function ease(____, u)
        return 1 - (1 - clamp(nil, u, 0, 1)) ^ 3
    end
    local function hash(____, n)
        local x = math.sin(n * 127.1 + 311.7) * 43758.5453
        return x - math.floor(x)
    end
    local function hx(____, c)
        return if __get(c, 0) == "#" then __arrL(
            {
                __TS__ParseInt(
                    __call(c, "slice", 1, 3),
                    16
                ),
                __TS__ParseInt(
                    __call(c, "slice", 3, 5),
                    16
                ),
                __TS__ParseInt(
                    __call(c, "slice", 5, 7),
                    16
                )
            },
            3
        ) else __call(
            __call(
                __re_match(
                    c,
                    __re("\\d+", "g")
                ),
                "slice",
                0,
                3
            ),
            "map",
            __NumberV
        )
    end
    local function mix(____, a, b, k)
        local A = hx(nil, a)
        local B = hx(nil, b)
        return ("rgb(" .. tostring(__call(
            __call(
                A,
                "map",
                function(____, v, i) return math.floor(v + (__get(B, i) - v) * k + 0.5) end
            ),
            "join",
            ","
        ))) .. ")"
    end
    local function mod(____, a, n)
        return __mod(
            __mod(a, n) + n,
            n
        )
    end
    local CIDADE = __TS__New(
        Set,
        __arrL({
            1,
            2,
            3,
            4,
            5,
            8,
            9,
            10,
            11
        }, 9)
    )
    local c = nil
    local function R(____, x, y, w, h, col)
        c.fillStyle = col
        c:fillRect(
            math.floor(x + 0.5),
            math.floor(y + 0.5),
            math.floor(w + 0.5),
            math.floor(h + 0.5)
        )
    end
    local function nuvem(self, x, y, k, col)
        R(
            nil,
            x + 8 * k,
            y,
            20 * k,
            4 * k,
            col
        )
        R(
            nil,
            x,
            y + 4 * k,
            40 * k,
            6 * k,
            col
        )
        R(
            nil,
            x + 4 * k,
            y + 10 * k,
            30 * k,
            3 * k,
            col
        )
        R(
            nil,
            x + 24 * k,
            y - 3 * k,
            10 * k,
            4 * k,
            col
        )
    end
    local function cacau(self, x, y, noite)
        R(
            nil,
            x - 2,
            y - 26,
            5,
            26,
            mix(nil, "#6a4426", "#241a20", noite)
        )
        local v = mix(nil, "#3e8a34", "#16302a", noite)
        local v2 = mix(nil, "#5aaa44", "#1e3a30", noite)
        R(
            nil,
            x - 16,
            y - 44,
            32,
            14,
            v
        )
        R(
            nil,
            x - 12,
            y - 52,
            24,
            8,
            v
        )
        R(
            nil,
            x - 20,
            y - 36,
            40,
            8,
            v
        )
        R(
            nil,
            x - 10,
            y - 50,
            12,
            5,
            v2
        )
        R(
            nil,
            x - 16,
            y - 42,
            8,
            4,
            v2
        )
        if __lt(noite, 0.6) then
            R(
                nil,
                x - 6,
                y - 24,
                3,
                5,
                "#e8b030"
            )
            R(
                nil,
                x + 4,
                y - 20,
                3,
                5,
                "#d88a28"
            )
        end
    end
    local function casinha(self, x, y, cor, noite)
        R(
            nil,
            x,
            y - 24,
            34,
            24,
            mix(nil, cor, "#2a2440", noite * 0.7)
        )
        R(
            nil,
            x - 4,
            y - 32,
            42,
            9,
            mix(nil, "#b0482e", "#3a2030", noite * 0.7)
        )
        R(
            nil,
            x + 13,
            y - 14,
            8,
            14,
            mix(nil, "#6a4426", "#241a20", noite)
        )
        R(
            nil,
            x + 4,
            y - 19,
            6,
            6,
            if __gt(noite, 0.4) then "#ffd880" else mix(nil, "#bfe4ff", "#304060", noite)
        )
        R(
            nil,
            x + 24,
            y - 19,
            6,
            6,
            if __gt(noite, 0.4) then "#ffd880" else mix(nil, "#bfe4ff", "#304060", noite)
        )
    end
    local function predio(self, x, y, w, h, i, noite)
        R(
            nil,
            x,
            y - h,
            w,
            h,
            mix(
                nil,
                __get(
                    __arrL({"#c8b8a0", "#a8b8c8", "#d8c0a8", "#b0a8c0"}, 4),
                    __mod(i, 4)
                ),
                "#28284a",
                noite * 0.8
            )
        )
        R(
            nil,
            x,
            y - h,
            w,
            3,
            mix(nil, "#e8e0d0", "#3a3a5a", noite)
        )
        do
            local wy = y - h + 8
            while wy < y - 8 do
                do
                    local wx = x + 5
                    while __lt(
                        wx,
                        __add(x, w) - 6
                    ) do
                        local aceso = hash(nil, wx * 7 + wy) > 0.45
                        R(
                            nil,
                            wx,
                            wy,
                            5,
                            6,
                            if __gt(noite, 0.35) then if __t(aceso) then "#ffd870" else "#2a2a40" else mix(
                                nil,
                                "#8ac0e0",
                                "#5a7a90",
                                hash(nil, wx + wy) * 0.5
                            )
                        )
                        wx = wx + 9
                    end
                end
                wy = wy + 11
            end
        end
    end
    local function vaca(self, x, y, t)
        local rabo = math.floor(math.sin(t * 5) * 2 + 0.5)
        R(
            nil,
            x,
            y - 14,
            26,
            11,
            "#f4f2ea"
        )
        R(
            nil,
            x + 4,
            y - 12,
            7,
            5,
            "#2a2a2a"
        )
        R(
            nil,
            x + 15,
            y - 14,
            6,
            4,
            "#2a2a2a"
        )
        R(
            nil,
            x + 24,
            y - 18,
            9,
            8,
            "#f4f2ea"
        )
        R(
            nil,
            x + 30,
            y - 14,
            4,
            4,
            "#f0b0b0"
        )
        R(
            nil,
            x + 27,
            y - 16,
            2,
            2,
            "#141018"
        )
        R(
            nil,
            x + 24,
            y - 20,
            2,
            3,
            "#e8dcc0"
        )
        R(
            nil,
            x + 2,
            y - 3,
            3,
            4,
            "#f4f2ea"
        )
        R(
            nil,
            x + 9,
            y - 3,
            3,
            4,
            "#f4f2ea"
        )
        R(
            nil,
            x + 16,
            y - 3,
            3,
            4,
            "#f4f2ea"
        )
        R(
            nil,
            x + 21,
            y - 3,
            3,
            4,
            "#f4f2ea"
        )
        R(
            nil,
            x - 3,
            y - 13 + rabo,
            3,
            8,
            "#2a2a2a"
        )
    end
    local function poste(self, x, y, noite)
        R(
            nil,
            x,
            y - 120,
            5,
            120,
            mix(nil, "#8a7a68", "#3a3440", noite)
        )
        R(
            nil,
            x - 14,
            y - 116,
            33,
            4,
            mix(nil, "#6a5a48", "#2a2430", noite)
        )
        R(
            nil,
            x - 12,
            y - 119,
            3,
            3,
            "#4a5a68"
        )
        R(
            nil,
            x + 14,
            y - 119,
            3,
            3,
            "#4a5a68"
        )
        if __gt(noite, 0.4) then
            c.globalAlpha = 0.25 * noite
            R(
                nil,
                x - 30,
                y - 112,
                64,
                112,
                "#ffe8a0"
            )
            c.globalAlpha = 1
            R(
                nil,
                x + 15,
                y - 112,
                6,
                4,
                "#fff0b0"
            )
        end
    end
    local function placaVerde(self, x, y, txt, sub)
        c.font = "bold 15px Pixel, monospace"
        local w = math.max(
            150,
            math.ceil(c:measureText(txt).width) + 44
        )
        local h = 52
        R(
            nil,
            x + 12,
            y - 40,
            6,
            40,
            "#5a6068"
        )
        R(
            nil,
            x + w - 18,
            y - 40,
            6,
            40,
            "#5a6068"
        )
        R(
            nil,
            x - 3,
            y - 40 - h - 3,
            w + 6,
            h + 6,
            "#1a1020"
        )
        R(
            nil,
            x,
            y - 40 - h,
            w,
            h,
            "#1f7a46"
        )
        R(
            nil,
            x + 3,
            y - 40 - h + 3,
            w - 6,
            h - 6,
            "#f4f4ec"
        )
        R(
            nil,
            x + 5,
            y - 40 - h + 5,
            w - 10,
            h - 10,
            "#1f7a46"
        )
        c.fillStyle = "#f4f4ec"
        c.textAlign = "left"
        c.textBaseline = "middle"
        c:fillText(txt, x + 14, y - 40 - h + 22)
        c.font = "10px Pixel, monospace"
        c:fillText(sub, x + 14, y - 40 - h + 39)
        R(
            nil,
            x + w - 30,
            y - 40 - h + 16,
            14,
            4,
            "#f4f4ec"
        )
        R(
            nil,
            x + w - 22,
            y - 40 - h + 12,
            4,
            12,
            "#f4f4ec"
        )
        R(
            nil,
            x + w - 18,
            y - 40 - h + 14,
            3,
            8,
            "#f4f4ec"
        )
    end
    local function desenhar(self, ctx, o)
        c = ctx
        local W = if __t(o.W) then o.W else 960
        local H = if __t(o.H) then o.H else 540
        local t = if __t(o.t) then o.t else 0
        local dur = if __t(o.dur) then o.dur else DUR
        local u = clamp(nil, t / dur, 0, 1)
        local s = t * 660
        local time = if __t(o.time) then o.time else t
        local ____o_de_0 = o.de
        if ____o_de_0 == nil then
            ____o_de_0 = 0
        end
        local de = ____o_de_0
        local ____o_para_1 = o.para
        if ____o_para_1 == nil then
            ____o_para_1 = 0
        end
        local para = ____o_para_1
        local nomes = if __t(o.nomes) then o.nomes else __arrL({}, 0)
        local urb = if __t(__call(CIDADE, "has", para)) then ease(nil, (u - 0.15) / 0.55) else 0
        local roca = if __t(para == 0 or para == 7) then 1 else 1 - urb
        local noite = 0
        do
            pcall(function()
                local ____t_10 = __t
                local ____opt_6 = window.DayTime
                if ____opt_6 ~= nil then
                    ____opt_6 = ____opt_6.state
                end
                local ____opt_result_8
                if ____opt_6 ~= nil then
                    ____opt_result_8 = ____opt_6(____opt_6)
                end
                local ____opt_result_9
                if ____opt_result_8 ~= nil then
                    ____opt_result_9 = ____opt_result_8.night
                end
                __O[688] = ____opt_result_9
                noite = clamp(nil, if ____t_10(____opt_result_9) then __O[688] else 0, 0, 1)
            end)
        end
        if para == 11 then
            noite = math.max(
                noite,
                ease(nil, u * 1.3)
            )
        end
        local ROAD = 372
        local CHAO = 470
        ctx:save()
        ctx.imageSmoothingEnabled = false
        do
            local i = 0
            while i < 14 do
                R(
                    nil,
                    0,
                    i * 24,
                    W,
                    24,
                    mix(
                        nil,
                        mix(nil, "#6cc0f4", "#d8f2ff", i / 13),
                        mix(nil, "#0e1030", "#4a2a5a", i / 13),
                        noite
                    )
                )
                i = i + 1
            end
        end
        if noite < 0.5 then
            local sx = 760
            local sy = 82
            c.globalAlpha = 0.25 * (1 - noite * 2)
            R(
                nil,
                sx - 44,
                sy - 44,
                88,
                88,
                "#fff6c0"
            )
            c.globalAlpha = 1
            R(
                nil,
                sx - 22,
                sy - 22,
                44,
                44,
                "#fff2a0"
            )
            R(
                nil,
                sx - 26,
                sy - 14,
                52,
                28,
                "#fff2a0"
            )
            R(
                nil,
                sx - 14,
                sy - 26,
                28,
                52,
                "#fff2a0"
            )
            R(
                nil,
                sx - 16,
                sy - 16,
                20,
                10,
                "#fffbe0"
            )
        else
            R(
                nil,
                770,
                70,
                30,
                30,
                "#f4f0d8"
            )
            R(
                nil,
                778,
                66,
                30,
                30,
                mix(nil, "#0e1030", "#4a2a5a", 0.1)
            )
            do
                local i = 0
                while i < 40 do
                    if hash(nil, i) < noite then
                        R(
                            nil,
                            hash(nil, i * 3) * W,
                            hash(nil, i * 7) * 220,
                            2,
                            2,
                            if __t(__mod(
                                math.floor(time * 3 + i),
                                5
                            )) then "#ffffff" else "#ffe8a0"
                        )
                    end
                    i = i + 1
                end
            end
        end
        do
            local i = 0
            while i < 6 do
                nuvem(
                    nil,
                    mod(
                        nil,
                        i * 230 - s * 0.05 + hash(nil, i) * 180,
                        W + 260
                    ) - 130,
                    40 + hash(nil, i + 9) * 110,
                    1 + hash(nil, i + 3),
                    mix(nil, "#ffffff", "#3a3a5a", noite * 0.85)
                )
                i = i + 1
            end
        end
        do
            local x = 0
            while __lt(x, W) do
                local X = x + s * 0.08
                local y = 248 - math.sin(X * 0.006) * 34 - math.sin(X * 0.017 + 1) * 14
                R(
                    nil,
                    x,
                    y,
                    4,
                    ROAD - y,
                    mix(nil, "#8ab8d0", "#22264a", noite)
                )
                x = x + 4
            end
        end
        if urb > 0 then
            c.globalAlpha = urb
            do
                local i = 0
                while i < 14 do
                    local bw = 46 + hash(nil, i) * 40
                    local bh = 70 + hash(nil, i + 5) * 110
                    predio(
                        nil,
                        mod(nil, i * 86 - s * 0.22, W + 200) - 100,
                        312,
                        bw,
                        bh,
                        i,
                        noite
                    )
                    i = i + 1
                end
            end
            c.globalAlpha = 1
        end
        do
            local x = 0
            while __lt(x, W) do
                local X = x + s * 0.3
                local y = 292 - math.sin(X * 0.009) * 18 - math.sin(X * 0.021 + 2) * 8
                R(
                    nil,
                    x,
                    y,
                    4,
                    ROAD - y,
                    mix(nil, "#7ccf50", "#1c3a2c", noite)
                )
                R(
                    nil,
                    x,
                    y,
                    4,
                    4,
                    mix(nil, "#b0e870", "#2a4a34", noite)
                )
                x = x + 4
            end
        end
        if roca > 0 then
            c.globalAlpha = roca
            do
                local i = 0
                while i < 9 do
                    local x = mod(
                        nil,
                        i * 140 - s * 0.34 + hash(nil, i) * 60,
                        W + 200
                    ) - 100
                    if hash(nil, i + 20) > 0.72 then
                        casinha(
                            nil,
                            x,
                            330,
                            __get(
                                __arrL({"#f0e0b0", "#c8e0f0", "#f0c8c8"}, 3),
                                __mod(i, 3)
                            ),
                            noite
                        )
                    else
                        cacau(
                            nil,
                            x,
                            334 + hash(nil, i + 4) * 10,
                            noite
                        )
                    end
                    i = i + 1
                end
            end
            c.globalAlpha = 1
        end
        local cerca = mix(nil, "#b08858", "#3a3040", noite)
        R(
            nil,
            0,
            ROAD - 22,
            W,
            3,
            cerca
        )
        R(
            nil,
            0,
            ROAD - 12,
            W,
            3,
            cerca
        )
        do
            local x = mod(nil, -s * 0.6, 40) - 40
            while __lt(x, W) do
                R(
                    nil,
                    x,
                    ROAD - 28,
                    5,
                    28,
                    cerca
                )
                x = x + 40
            end
        end
        if __t(not __t(urb) or urb < 0.6) then
            local vx = mod(nil, 380 - s * 0.6, W + 600) - 120
            vaca(nil, vx, ROAD - 2, time)
        end
        do
            local i = 0
            while i < 4 do
                poste(
                    nil,
                    mod(nil, i * 300 + 90 - s * 0.75, W + 300) - 150,
                    ROAD,
                    noite
                )
                i = i + 1
            end
        end
        c.strokeStyle = mix(nil, "#3a3a40", "#101018", noite)
        c.lineWidth = 2
        for ____, dy in __iterar((__arrL({0, 6}, 2))) do
            c:beginPath()
            do
                local x = 0
                while __le(x, W) do
                    local ph = mod(nil, x + s * 0.75 - 90, 300) / 300
                    local y = ROAD - 115 + dy + math.sin(ph * math.pi) * 14
                    local ____ = if __t(x) then c:lineTo(x, y) else c:moveTo(x, y)
                    x = x + 8
                end
            end
            c:stroke()
        end
        local ____call_13 = __call
        local ____t_12 = __t
        local ____get_result_11 = __get(nomes, para)
        __O[689] = ____get_result_11
        local nome = ____call_13(
            tostring(if ____t_12(____get_result_11) then __O[689] else "Destino"),
            "toUpperCase"
        )
        local px = W + 60 - (t - 0.55) * 640 * 0.78
        if __t(__lt(px, W + 40) and px > -360) then
            placaVerde(
                nil,
                px,
                ROAD - 4,
                nome,
                __add(
                    __add(
                        "SIGA EM FRENTE · ",
                        1 + math.floor((1 - u) * 4 + 0.5)
                    ),
                    " KM"
                )
            )
        end
        R(
            nil,
            0,
            ROAD - 4,
            W,
            5,
            mix(nil, "#d8d0b0", "#4a4450", noite)
        )
        R(
            nil,
            0,
            ROAD,
            W,
            CHAO - ROAD,
            mix(nil, "#5e6068", "#24242e", noite)
        )
        R(
            nil,
            0,
            ROAD + 2,
            W,
            3,
            mix(nil, "#f4f4ec", "#8a8a98", noite)
        )
        R(
            nil,
            0,
            CHAO - 6,
            W,
            3,
            mix(nil, "#f4f4ec", "#8a8a98", noite)
        )
        do
            local i = 0
            while i < 40 do
                R(
                    nil,
                    mod(
                        nil,
                        hash(nil, i) * 2000 - s,
                        W + 40
                    ) - 20,
                    ROAD + 8 + hash(nil, i + 2) * 52,
                    3,
                    2,
                    mix(nil, "#6e7078", "#2e2e38", noite)
                )
                i = i + 1
            end
        end
        do
            local x = mod(nil, -s, 120) - 120
            while __lt(x, W) do
                R(
                    nil,
                    x,
                    ROAD + 42,
                    64,
                    6,
                    mix(nil, "#f2c63a", "#8a7a3a", noite)
                )
                x = x + 120
            end
        end
        local cx = 300 + ease(nil, u) * 80 + math.sin(t * 1.7) * 8
        local buraco = if math.abs(math.sin(t * 9)) > 0.97 then -3 else 0
        local cy = ROAD + 66 + math.floor(math.sin(t * 22) + 0.5) + buraco
        do
            local k = 0
            while k < 10 do
                local a = __mod(t * 2.4 + k / 10, 1)
                local r = 4 + a * 12
                c.globalAlpha = (1 - a) * 0.55
                R(
                    nil,
                    cx - 66 - a * 150,
                    cy - 20 - a * 26 - r / 2,
                    r,
                    r,
                    mix(nil, "#d8f0ff", "#8a9ab0", noite)
                )
                k = k + 1
            end
        end
        c.globalAlpha = 1
        do
            local k = 0
            while k < 4 do
                local a = __mod(t * 3 + k / 4, 1)
                c.globalAlpha = (1 - a) * 0.7
                R(
                    nil,
                    cx - 90 - a * 260,
                    cy - 40 + k * 11,
                    30 + a * 40,
                    2,
                    "#ffffff"
                )
                k = k + 1
            end
        end
        c.globalAlpha = 1
        c.globalAlpha = 0.3
        R(
            nil,
            cx - 60,
            cy - 2,
            120,
            7,
            "#141018"
        )
        c.globalAlpha = 1
        ctx:save()
        ctx:translate(cx, cy)
        ctx:scale(1.4, 1.4)
        ctx:translate(-cx, -cy)
        do
            pcall(function()
                local ____this_15
                ____this_15 = o
                local ____opt_14 = ____this_15.carro
                if ____opt_14 ~= nil then
                    ____opt_14(____this_15, ctx, cx, cy)
                end
            end)
        end
        ctx:restore()
        if noite > 0.3 then
            c.globalAlpha = 0.22 * noite
            c:beginPath()
            c:moveTo(cx + 56, cy - 22)
            c:lineTo(cx + 300, cy - 60)
            c:lineTo(cx + 300, cy + 14)
            c:closePath()
            c.fillStyle = "#fff0b0"
            __call(c, "fill")
            c.globalAlpha = 1
        end
        R(
            nil,
            0,
            CHAO,
            W,
            H - CHAO,
            mix(nil, "#5cb040", "#183022", noite)
        )
        R(
            nil,
            0,
            CHAO,
            W,
            4,
            mix(nil, "#8ad060", "#22402a", noite)
        )
        do
            local i = 0
            while i < 30 do
                local x = mod(
                    nil,
                    hash(nil, i) * 2400 - s * 1.35,
                    W + 60
                ) - 30
                local y = CHAO + 10 + hash(nil, i + 7) * 50
                R(
                    nil,
                    x,
                    y,
                    3,
                    8,
                    mix(nil, "#3e8a30", "#10241a", noite)
                )
                R(
                    nil,
                    x + 4,
                    y + 2,
                    3,
                    6,
                    mix(nil, "#3e8a30", "#10241a", noite)
                )
                if hash(nil, i + 11) > 0.6 then
                    R(
                        nil,
                        x + 1,
                        y - 3,
                        4,
                        4,
                        __get(
                            __arrL({"#ffe14a", "#ff8ab0", "#ffffff"}, 3),
                            __mod(i, 3)
                        )
                    )
                end
                i = i + 1
            end
        end
        R(
            nil,
            0,
            0,
            W,
            30,
            "#0c0810"
        )
        R(
            nil,
            0,
            H - 30,
            W,
            30,
            "#0c0810"
        )
        local bw = 380
        local bx = math.floor(W / 2 - bw / 2 + 0.5)
        local by = 96
        local entra = ease(nil, t / 0.4)
        c:save()
        c:translate(
            0,
            math.floor((1 - entra) * -150 + 0.5)
        )
        R(
            nil,
            bx + 40,
            30,
            4,
            by - 30,
            "#3a2414"
        )
        R(
            nil,
            bx + bw - 44,
            30,
            4,
            by - 30,
            "#3a2414"
        )
        R(
            nil,
            bx - 3,
            by - 3,
            bw + 6,
            66,
            "#2a1a10"
        )
        R(
            nil,
            bx,
            by,
            bw,
            60,
            "#a8643a"
        )
        R(
            nil,
            bx,
            by,
            bw,
            3,
            "#c88a5a"
        )
        R(
            nil,
            bx,
            by + 20,
            bw,
            1,
            "#8a4e2a"
        )
        R(
            nil,
            bx,
            by + 40,
            bw,
            1,
            "#8a4e2a"
        )
        c.textAlign = "center"
        c.textBaseline = "middle"
        c.fillStyle = "#ffe9b8"
        c.font = "10px Pixel, monospace"
        c:fillText("A CAMINHO DE", W / 2, by + 12)
        c.fillStyle = "#fff6dc"
        c.font = "bold 16px Pixel, monospace"
        c:fillText(nome, W / 2, by + 30)
        local lx0 = bx + 24
        local lx1 = bx + bw - 24
        local ly = by + 48
        do
            local x = lx0
            while x < lx1 do
                R(
                    nil,
                    x,
                    ly,
                    6,
                    2,
                    "#5a3018"
                )
                x = x + 10
            end
        end
        R(
            nil,
            lx0 - 4,
            ly - 3,
            8,
            8,
            "#3a6a8a"
        )
        R(
            nil,
            lx1 - 4,
            ly - 3,
            8,
            8,
            "#e8433a"
        )
        local kx = math.floor(lx0 + (lx1 - lx0) * ease(nil, u) + 0.5)
        R(
            nil,
            kx - 7,
            ly - 6,
            14,
            6,
            "#5aa0d8"
        )
        R(
            nil,
            kx - 4,
            ly - 9,
            8,
            3,
            "#5aa0d8"
        )
        R(
            nil,
            kx - 6,
            ly,
            4,
            3,
            "#141018"
        )
        R(
            nil,
            kx + 3,
            ly,
            4,
            3,
            "#141018"
        )
        c:restore()
        local fade = if __lt(t, 0.35) then 1 - t / 0.35 else if u > 0.86 then (u - 0.86) / 0.14 else 0
        if fade > 0 then
            c.globalAlpha = clamp(nil, fade, 0, 1)
            R(
                nil,
                0,
                0,
                W,
                H,
                "#0c0810"
            )
            c.globalAlpha = 1
        end
        ctx:restore()
        c = nil
        return true
    end
    window.EstradaViagem = __ord({desenhar = desenhar, duracao = DUR}, "desenhar,duracao")
end)(nil)
return ____exports
