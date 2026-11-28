--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __newExpr, __lt, __le, __gt, __ge, __callq, __mod, __ord, __arrL, __iterar, __t, __get = __JSR.__newExpr, __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__callq, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get
local __set, __arr, __len, __call, __add, __new, __iter, __assign, __arrayFrom, __bor, __band, __shr = __JSR.__set, __JSR.__arr, __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__new, __JSR.__iter, __JSR.__assign, __JSR.__arrayFrom, __JSR.__bor, __JSR.__band, __JSR.__shr
local __hypot = __JSR.__hypot
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__Spread = ____lualib.__TS__Spread
local __TS__MathSign = ____lualib.__TS__MathSign
local __TS__Number = ____lualib.__TS__Number
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local __TS__ParseInt = ____lualib.__TS__ParseInt
local ____exports = {}
local __O = {};
(function()
    local cena, g, chao, q, fixo, f, logoCv, lc, letrasCv, lt, placaCv, pc
    local __L1 = {}
    __L1.tom = function(self, f1, f2, dur, tipo, vol, atraso)
        if tipo == nil then
            tipo = "square"
        end
        if vol == nil then
            vol = 0.05
        end
        if atraso == nil then
            atraso = 0
        end
        local t = __L1.ac.currentTime + atraso
        local o = __L1.ac:createOscillator()
        local g = __L1.ac:createGain()
        o.type = tipo
        o.frequency:setValueAtTime(f1, t)
        o.frequency:exponentialRampToValueAtTime(
            math.max(20, f2),
            __add(t, dur)
        )
        g.gain:setValueAtTime(vol, t)
        g.gain:exponentialRampToValueAtTime(
            0.0001,
            __add(t, dur)
        )
        o:connect(g)
        g:connect(__L1.ac.destination)
        o:start(t)
        o:stop(__add(t, dur) + 0.02)
    end
    __L1.ruido = function(self, dur, vol, corte)
        if vol == nil then
            vol = 0.05
        end
        if corte == nil then
            corte = 1800
        end
        local n = math.floor(__L1.ac.sampleRate * dur)
        local b = __L1.ac:createBuffer(1, n, __L1.ac.sampleRate)
        local d = b:getChannelData(0)
        do
            local i = 0
            while i < n do
                __set(
                    d,
                    i,
                    (math.random() * 2 - 1) * (1 - i / n)
                )
                i = i + 1
            end
        end
        local s = __L1.ac:createBufferSource()
        local f = __L1.ac:createBiquadFilter()
        local g = __L1.ac:createGain()
        f.type = "lowpass"
        f.frequency.value = corte
        g.gain.value = vol
        s.buffer = b
        s:connect(f)
        f:connect(g)
        g:connect(__L1.ac.destination)
        s:start()
    end
    __L1.som = function(self, tipo)
        do
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                local ____t_4 = __t
                local ____t_result_3
                local ____t_2 = __t
                local ____opt_0 = window.Game
                if ____opt_0 ~= nil then
                    ____opt_0 = ____opt_0.soundOn
                end
                __O[3204] = ____opt_0
                if ____t_2(____opt_0) then
                    ____t_result_3 = not __t(window.Game:soundOn())
                else
                    ____t_result_3 = __O[3204]
                end
                if ____t_4(____t_result_3) then
                    return true
                end
                local ____t_result_7
                if __t(__L1.ac) then
                    ____t_result_7 = __L1.ac
                else
                    local ____newExpr_6 = __newExpr
                    local ____t_result_5
                    if __t(window.AudioContext) then
                        ____t_result_5 = window.AudioContext
                    else
                        ____t_result_5 = window.webkitAudioContext
                    end
                    ____t_result_7 = ____newExpr_6(____t_result_5)
                end
                __L1.ac = ____t_result_7
                if __L1.ac.state == "suspended" then
                    __L1.ac:resume()
                end
                local ____opt_8 = __get(
                    {
                        planta = function()
                            __L1:tom(
                                330,
                                660,
                                0.09,
                                "triangle",
                                0.07
                            )
                            __L1:tom(
                                660,
                                990,
                                0.1,
                                "triangle",
                                0.05,
                                0.07
                            )
                        end,
                        galinha = function()
                            __L1:tom(
                                900,
                                1300,
                                0.06,
                                "square",
                                0.03
                            )
                            __L1:tom(
                                1000,
                                1500,
                                0.07,
                                "square",
                                0.03,
                                0.09
                            )
                            __L1:tom(
                                800,
                                1100,
                                0.05,
                                "square",
                                0.025,
                                0.2
                            )
                        end,
                        dia = function()
                            __call(
                                __arrL({523, 659, 784, 1047}, 4),
                                "forEach",
                                function(____, f, i) return __L1:tom(
                                    f,
                                    f,
                                    0.18,
                                    "triangle",
                                    0.045,
                                    i * 0.07
                                ) end
                            )
                        end,
                        estrela = function()
                            __call(
                                __arrL({1568, 1319, 1175, 1568}, 4),
                                "forEach",
                                function(____, f, i) return __L1:tom(
                                    f,
                                    f * 1.01,
                                    0.12,
                                    "sine",
                                    0.04,
                                    i * 0.06
                                ) end
                            )
                        end,
                        agua = function()
                            __L1:ruido(0.25, 0.08, 1200)
                            __L1:tom(
                                500,
                                180,
                                0.15,
                                "sine",
                                0.05
                            )
                        end,
                        sapo = function()
                            __L1:tom(
                                160,
                                110,
                                0.12,
                                "square",
                                0.05
                            )
                            __L1:tom(
                                150,
                                100,
                                0.12,
                                "square",
                                0.045,
                                0.14
                            )
                        end,
                        vento = function()
                            __L1:ruido(0.6, 0.05, 700)
                        end,
                        oi = function()
                            __L1:tom(
                                587,
                                784,
                                0.1,
                                "triangle",
                                0.05
                            )
                            __L1:tom(
                                784,
                                988,
                                0.12,
                                "triangle",
                                0.05,
                                0.1
                            )
                        end,
                        pop = function()
                            __L1:tom(
                                600,
                                900,
                                0.06,
                                "triangle",
                                0.05
                            )
                        end,
                        chuva = function()
                            __L1:ruido(0.9, 0.04, 3000)
                        end,
                        logo = function()
                            __call(
                                __arrL({
                                    392,
                                    494,
                                    587,
                                    784,
                                    988
                                }, 5),
                                "forEach",
                                function(____, f, i) return __L1:tom(
                                    f,
                                    f,
                                    0.12,
                                    "square",
                                    0.03,
                                    i * 0.05
                                ) end
                            )
                        end
                    },
                    tipo
                )
                if ____opt_8 ~= nil then
                    ____opt_8(nil)
                end
            end)
            if ____try and ____hasReturned then
                return ____returnValue
            end
        end
    end
    __L1.montarFixo = function(self)
        local R = __L1:pinta(f)
        local B = __L1:bola(f)
        f:clearRect(0, 0, __L1.LW, __L1.LH)
        do
            local x = 0
            while x < __L1.LW do
                local h = math.floor(122 + math.sin(x * 0.02) * 6 + math.sin(x * 0.053 + 1) * 4 + 0.5)
                R(
                    nil,
                    x,
                    h,
                    1,
                    __L1.HZ + 4 - h,
                    __L1:mixc(
                        "#8fb8a0",
                        "#7aa88a",
                        __mod(x, 7) / 14
                    )
                )
                if __L1:hash(x * 3.1) > 0.7 then
                    R(
                        nil,
                        x,
                        h,
                        1,
                        1,
                        "#a8cbb4"
                    )
                end
                x = x + 1
            end
        end
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({300, 7, 10}, 3),
                __arrL({309, 5, 15}, 3),
                __arrL({316, 9, 8}, 3),
                __arrL({327, 6, 12}, 3),
                __arrL({335, 8, 9}, 3),
                __arrL({345, 5, 7}, 3)
            },
            6
        ))) do
            local bx = ____value[1]
            local bw = ____value[2]
            local bh = ____value[3]
            R(
                nil,
                bx,
                141 - bh,
                bw,
                bh,
                "#b4c8cc"
            )
            do
                local k = 2
                while k < bh - 1 do
                    R(
                        nil,
                        bx + 1,
                        141 - bh + k,
                        bw - 2,
                        1,
                        "#c8d8da"
                    )
                    k = k + 3
                end
            end
        end
        R(
            nil,
            320,
            120,
            1,
            6,
            "#b4c8cc"
        )
        R(
            nil,
            318,
            122,
            5,
            1,
            "#b4c8cc"
        )
        do
            local x = 0
            while x < __L1.LW do
                local h = math.floor(136 + math.sin(x * 0.031 + 2) * 6 + math.sin(x * 0.07) * 3 + 0.5)
                R(
                    nil,
                    x,
                    h,
                    1,
                    __L1.HZ + 6 - h,
                    "#6aa064"
                )
                if __mod(x, 9) == 0 then
                    B(
                        nil,
                        x + 2,
                        h + 1,
                        3,
                        __L1:hash(x) > 0.5 and "#4f8a4a" or "#5a944e",
                        2
                    )
                end
                x = x + 1
            end
        end
        do
            local y = __L1.HZ
            while y < __L1.LH do
                R(
                    nil,
                    0,
                    y,
                    __L1.LW,
                    1,
                    __L1:mixc(
                        "#6aa84e",
                        "#84c85c",
                        __L1:kY(y)
                    )
                )
                y = y + 1
            end
        end
        do
            local i = 0
            while i < 1800 do
                local x = __bor(
                    __L1:hash(i) * __L1.LW,
                    0
                )
                local y = __bor(
                    __L1.HZ + 2 + __L1:hash(i + 0.5) * (__L1.LH - __L1.HZ - 2),
                    0
                )
                R(
                    nil,
                    x,
                    y,
                    1,
                    __L1:hash(i + 0.7) > 0.75 and 2 or 1,
                    __L1:hash(i + 0.3) > 0.5 and "#5a9a40" or "#9ad86e"
                )
                i = i + 1
            end
        end
        do
            local y = __L1.HZ + 1
            while y < __L1.LH do
                local c = __L1:trilhaC(y)
                local w = __L1:trilhaW(y)
                R(
                    nil,
                    c - w - 1,
                    y,
                    2 * w + 2,
                    1,
                    "#b8955c"
                )
                R(
                    nil,
                    c - w,
                    y,
                    2 * w,
                    1,
                    __L1:mixc(
                        "#d8bc84",
                        "#e2c690",
                        __L1:hash(y)
                    )
                )
                y = y + 1
            end
        end
        do
            local i = 0
            while i < 90 do
                local y = __L1.HZ + 4 + __L1:hash(i * 2.3) * (__L1.LH - __L1.HZ - 4)
                local c = __L1:trilhaC(y)
                local w = __L1:trilhaW(y)
                R(
                    nil,
                    c + (__L1:hash(i * 5.1) * 2 - 1) * w * 0.8,
                    y,
                    2,
                    1,
                    __L1:hash(i) > 0.5 and "#a88a58" or "#f0dcae"
                )
                i = i + 1
            end
        end
        do
            local y = __L1.HZ + 1
            while y < __L1.LH do
                local a = __L1:rioL(y)
                local b = __L1:rioR(y)
                R(
                    nil,
                    a - 3,
                    y,
                    3,
                    1,
                    "#d8c08a"
                )
                R(
                    nil,
                    a,
                    y,
                    b - a,
                    1,
                    __L1:mixc(
                        "#9ad0ec",
                        "#3a8cc8",
                        __L1:kY(y)
                    )
                )
                R(
                    nil,
                    a,
                    y,
                    1,
                    1,
                    "#2a6a9a"
                )
                y = y + 1
            end
        end
        do
            local x = 0
            while x < 34 do
                local y = 206 + math.floor(math.sin(x / 33 * math.pi) * -4 + 0.5)
                R(
                    nil,
                    392 + x,
                    y,
                    1,
                    4,
                    __t(__mod(x, 4)) and "#a8743e" or "#7a4a24"
                )
                x = x + 1
            end
        end
        R(
            nil,
            392,
            202,
            34,
            1,
            "#6a3c1c"
        )
        for ____, x in __iterar((__arrL({393, 424}, 2))) do
            R(
                nil,
                x,
                206,
                2,
                10,
                "#6a3c1c"
            )
        end
        do
            local r = 0
            while r < 6 do
                local y = 214 + r * 8
                R(
                    nil,
                    10,
                    y,
                    166,
                    6,
                    "#8a5a34"
                )
                R(
                    nil,
                    10,
                    y,
                    166,
                    1,
                    "#a8744a"
                )
                R(
                    nil,
                    10,
                    y + 6,
                    166,
                    2,
                    "#6a4024"
                )
                do
                    local x = 12
                    while x < 174 do
                        if __L1:hash(x + r * 31) > 0.7 then
                            R(
                                nil,
                                x,
                                y + 2 + __mod(x, 3),
                                1,
                                1,
                                "#6a4024"
                            )
                        end
                        x = x + 3
                    end
                end
                r = r + 1
            end
        end
        do
            local x = 18
            while x < 172 do
                B(
                    nil,
                    x,
                    225,
                    4,
                    "#3f8a32",
                    3
                )
                B(
                    nil,
                    x - 1,
                    224,
                    2,
                    "#6abf4a",
                    2
                )
                x = x + 12
            end
        end
        do
            local x = 16
            while x < 172 do
                R(
                    nil,
                    x,
                    236,
                    1,
                    3,
                    "#4f9a32"
                )
                R(
                    nil,
                    x + 1,
                    235,
                    1,
                    2,
                    "#6abf4a"
                )
                R(
                    nil,
                    x,
                    239,
                    2,
                    1,
                    "#e8782a"
                )
                x = x + 9
            end
        end
        local function cerca(____, x0, x1, y)
            R(
                nil,
                x0,
                y + 3,
                x1 - x0,
                2,
                "#a8743e"
            )
            R(
                nil,
                x0,
                y + 9,
                x1 - x0,
                2,
                "#a8743e"
            )
            R(
                nil,
                x0,
                y + 3,
                x1 - x0,
                1,
                "#c8945a"
            )
            do
                local x = x0
                while __le(x, x1) do
                    R(
                        nil,
                        x,
                        y,
                        3,
                        15,
                        "#8a5a30"
                    )
                    R(
                        nil,
                        x,
                        y,
                        1,
                        15,
                        "#b07a44"
                    )
                    R(
                        nil,
                        x,
                        y - 1,
                        3,
                        1,
                        "#c8945a"
                    )
                    x = x + 14
                end
            end
        end
        cerca(nil, 4, 200, 196)
        cerca(nil, 282, 358, 192)
        R(
            nil,
            10,
            130,
            6,
            66,
            "#6a4426"
        )
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({4, 118, 22}, 3),
                __arrL({24, 110, 18}, 3),
                __arrL({-4, 100, 16}, 3),
                __arrL({18, 94, 14}, 3),
                __arrL({30, 126, 14}, 3)
            },
            5
        ))) do
            local x = ____value[1]
            local y = ____value[2]
            local r = ____value[3]
            B(
                nil,
                x,
                y,
                r,
                "#3a6e2e"
            )
            B(
                nil,
                x - 3,
                y - 3,
                r - 4,
                "#4f8a3a"
            )
            B(
                nil,
                x - 6,
                y - 6,
                math.max(2, r - 10),
                "#6aa84a"
            )
        end
        do
            local i = 0
            while i < 9 do
                local x = 2 + __L1:hash(i * 9) * 34
                local y = 96 + __L1:hash(i * 4) * 36
                R(
                    nil,
                    x,
                    y,
                    2,
                    3,
                    "#f0a030"
                )
                R(
                    nil,
                    x,
                    y,
                    1,
                    1,
                    "#f8d040"
                )
                i = i + 1
            end
        end
        local ____L1_CASA_10 = __L1.CASA
        local x0 = ____L1_CASA_10.x0
        local x1 = ____L1_CASA_10.x1
        local cx = (x0 + x1) / 2
        B(
            nil,
            cx,
            193,
            52,
            "rgba(0,0,0,.12)",
            3
        )
        R(
            nil,
            36,
            150,
            86,
            42,
            "#f0dfbc"
        )
        R(
            nil,
            110,
            150,
            12,
            42,
            "#dcc8a0"
        )
        R(
            nil,
            36,
            186,
            86,
            6,
            "#b8a07a"
        )
        do
            local i = 0
            while i < 70 do
                R(
                    nil,
                    37 + __L1:hash(i * 2.2) * 84,
                    151 + __L1:hash(i * 3.7) * 34,
                    1,
                    1,
                    "#e0caa0"
                )
                i = i + 1
            end
        end
        R(
            nil,
            104,
            106,
            9,
            22,
            "#a8543a"
        )
        do
            local y = 108
            while y < 126 do
                R(
                    nil,
                    104 + (__t(__mod(y / 3, 2)) and 0 or 4),
                    y,
                    4,
                    1,
                    "#8a3c28"
                )
                y = y + 3
            end
        end
        R(
            nil,
            102,
            104,
            13,
            3,
            "#5a3a2a"
        )
        do
            local y = 118
            while y < 151 do
                local k = (y - 118) / 32
                local hw = math.floor(__L1:lerp(38, 52, k) + 0.5)
                local row = math.floor((y - 118) / 4)
                R(
                    nil,
                    cx - hw,
                    y,
                    hw * 2,
                    1,
                    __t(__mod(row, 2)) and "#c8583a" or "#b44c32"
                )
                if __mod(y - 118, 4) == 3 then
                    R(
                        nil,
                        cx - hw,
                        y,
                        hw * 2,
                        1,
                        "#8a3424"
                    )
                end
                y = y + 1
            end
        end
        do
            local y = 118
            while y < 150 do
                do
                    local x = -52
                    while x < 52 do
                        if __lt(
                            math.abs(x),
                            __L1:lerp(38, 52, (y - 118) / 32)
                        ) then
                            R(
                                nil,
                                cx + x + (__t(__mod(y / 4, 2)) and 3 or 0),
                                y,
                                1,
                                3,
                                "#9a3c2a"
                            )
                        end
                        x = x + 7
                    end
                end
                y = y + 4
            end
        end
        R(
            nil,
            cx - 38,
            117,
            76,
            2,
            "#7a2c1e"
        )
        R(
            nil,
            cx - 52,
            150,
            104,
            2,
            "#5a2a1a"
        )
        R(
            nil,
            72,
            166,
            14,
            26,
            "#7a4a28"
        )
        R(
            nil,
            72,
            166,
            14,
            1,
            "#5a3418"
        )
        do
            local x = 75
            while x < 86 do
                R(
                    nil,
                    x,
                    167,
                    1,
                    25,
                    "#6a3c20"
                )
                x = x + 4
            end
        end
        R(
            nil,
            83,
            179,
            2,
            2,
            "#e8c86a"
        )
        R(
            nil,
            62,
            156,
            34,
            8,
            "#6a3a20"
        )
        R(
            nil,
            63,
            157,
            32,
            6,
            "#8a5030"
        )
        local mini = {
            D = __arrL({
                "11.",
                "1.1",
                "1.1",
                "1.1",
                "11."
            }, 5),
            O = __arrL({
                ".1.",
                "1.1",
                "1.1",
                "1.1",
                ".1."
            }, 5),
            S = __arrL({
                ".11",
                "1..",
                ".1.",
                "..1",
                "11."
            }, 5),
            A = __arrL({
                ".1.",
                "1.1",
                "111",
                "1.1",
                "1.1"
            }, 5),
            P = __arrL({
                "11.",
                "1.1",
                "11.",
                "1..",
                "1.."
            }, 5)
        }
        local px = 66
        for ____, ch in __iterar(("DO SAPO")) do
            if ch ~= " " then
                __call(
                    __get(mini, ch),
                    "forEach",
                    function(____, row, y) return __call(
                        __arr(__TS__Spread(__iter(row))),
                        "forEach",
                        function(____, v, x)
                            if v == "1" then
                                R(
                                    nil,
                                    px + x,
                                    158 + y,
                                    1,
                                    1,
                                    "#f6e6b8"
                                )
                            end
                        end
                    ) end
                )
            end
            px = px + (ch == " " and 2 or 4)
        end
        for ____, ____value in __iterar((__call(__L1.JANELAS, "slice", 0, 2))) do
            local wx = ____value[1]
            local wy = ____value[2]
            local ww = ____value[3]
            local wh = ____value[4]
            R(
                nil,
                wx - 1,
                wy - 1,
                ww + 2,
                wh + 2,
                "#f8f4ea"
            )
            R(
                nil,
                wx,
                wy,
                ww,
                wh,
                "#5a7a9a"
            )
            do
                local k = 0
                while k < 5 do
                    R(
                        nil,
                        wx + 2 + k,
                        wy + 1 + k,
                        2,
                        1,
                        "#8ab0c8"
                    )
                    k = k + 1
                end
            end
            R(
                nil,
                wx + ww / 2,
                wy,
                1,
                wh,
                "#f8f4ea"
            )
            R(
                nil,
                wx,
                wy + wh / 2,
                ww,
                1,
                "#f8f4ea"
            )
            R(
                nil,
                wx - 2,
                wy + wh + 1,
                ww + 4,
                3,
                "#8a5030"
            )
            do
                local k = 0
                while k < ww do
                    R(
                        nil,
                        wx + k,
                        wy + wh,
                        2,
                        2,
                        __t(__mod(k, 2)) and "#e8504a" or "#f8d040"
                    )
                    k = k + 3
                end
            end
        end
        R(
            nil,
            40,
            184,
            14,
            2,
            "#8a5030"
        )
        R(
            nil,
            41,
            186,
            1,
            4,
            "#6a3c20"
        )
        R(
            nil,
            52,
            186,
            1,
            4,
            "#6a3c20"
        )
        R(
            nil,
            92,
            184,
            6,
            6,
            "#b8583a"
        )
        B(
            nil,
            95,
            181,
            4,
            "#4f9a3a",
            3
        )
        R(
            nil,
            94,
            178,
            2,
            2,
            "#e8504a"
        )
        B(
            nil,
            317,
            193,
            36,
            "rgba(0,0,0,.12)",
            3
        )
        do
            local y = 126
            while y < 151 do
                local hw = math.floor((y - 126) * 34 / 24 + 0.5)
                R(
                    nil,
                    317 - hw,
                    y,
                    hw * 2,
                    1,
                    __t(__mod(y, 3)) and "#7a2a24" or "#6a2420"
                )
                y = y + 1
            end
        end
        R(
            nil,
            286,
            150,
            62,
            42,
            "#b8463a"
        )
        do
            local x = 289
            while x < 346 do
                R(
                    nil,
                    x,
                    150,
                    1,
                    42,
                    "#9a3a30"
                )
                x = x + 5
            end
        end
        R(
            nil,
            286,
            150,
            2,
            42,
            "#f2ead8"
        )
        R(
            nil,
            346,
            150,
            2,
            42,
            "#f2ead8"
        )
        R(
            nil,
            286,
            150,
            62,
            2,
            "#f2ead8"
        )
        R(
            nil,
            302,
            166,
            28,
            26,
            "#9a3a30"
        )
        R(
            nil,
            302,
            166,
            28,
            2,
            "#f2ead8"
        )
        R(
            nil,
            302,
            166,
            2,
            26,
            "#f2ead8"
        )
        R(
            nil,
            328,
            166,
            2,
            26,
            "#f2ead8"
        )
        R(
            nil,
            315,
            166,
            2,
            26,
            "#f2ead8"
        )
        do
            local k = 0
            while k < 13 do
                R(
                    nil,
                    304 + k,
                    168 + k * 2,
                    2,
                    2,
                    "#f2ead8"
                )
                R(
                    nil,
                    326 - k,
                    168 + k * 2,
                    2,
                    2,
                    "#f2ead8"
                )
                k = k + 1
            end
        end
        R(
            nil,
            311,
            135,
            10,
            9,
            "#f2ead8"
        )
        R(
            nil,
            312,
            136,
            8,
            7,
            "#3a2a20"
        )
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({348, 182}, 2),
                __arrL({356, 182}, 2),
                __arrL({352, 174}, 2)
            },
            3
        ))) do
            local bx = ____value[1]
            local by = ____value[2]
            R(
                nil,
                bx,
                by,
                9,
                10,
                "#e8c860"
            )
            R(
                nil,
                bx,
                by,
                9,
                1,
                "#f8e080"
            )
            R(
                nil,
                bx + 3,
                by,
                1,
                10,
                "#c8a040"
            )
            R(
                nil,
                bx + 6,
                by,
                1,
                10,
                "#c8a040"
            )
        end
        local ____L1_MOINHO_11 = __L1.MOINHO
        local mx = ____L1_MOINHO_11.hx
        B(
            nil,
            mx,
            193,
            22,
            "rgba(0,0,0,.12)",
            3
        )
        do
            local y = 112
            while y < 192 do
                local k = (y - 112) / 80
                local hw = math.floor(__L1:lerp(9, 16, k) + 0.5)
                R(
                    nil,
                    mx - hw,
                    y,
                    hw * 2,
                    1,
                    "#e8dcc4"
                )
                R(
                    nil,
                    mx + hw - 5,
                    y,
                    5,
                    1,
                    "#cbbd9f"
                )
                if __mod(y, 6) == 0 then
                    do
                        local x = -hw
                        while x < hw do
                            R(
                                nil,
                                mx + x + (__t(__mod(y / 6, 2)) and 3 or 0),
                                y,
                                1,
                                1,
                                "#b8a888"
                            )
                            x = x + 6
                        end
                    end
                end
                y = y + 1
            end
        end
        do
            local y = 98
            while y < 113 do
                local hw = math.floor((y - 98) * 13 / 14 + 0.5)
                R(
                    nil,
                    mx - hw,
                    y,
                    hw * 2,
                    1,
                    __t(__mod(y, 3)) and "#8a4a2a" or "#7a3c22"
                )
                y = y + 1
            end
        end
        R(
            nil,
            mx - 5,
            178,
            10,
            14,
            "#6a4426"
        )
        R(
            nil,
            mx - 5,
            178,
            10,
            1,
            "#4a2a18"
        )
        R(
            nil,
            375,
            140,
            7,
            8,
            "#5a7a9a"
        )
        R(
            nil,
            375,
            140,
            7,
            1,
            "#f8f4ea"
        )
        local A = __L1.ARVORE
        R(
            nil,
            A.x - 4,
            138,
            9,
            58,
            "#6a4426"
        )
        R(
            nil,
            A.x - 4,
            138,
            2,
            58,
            "#8a5a34"
        )
        do
            local y = 142
            while y < 196 do
                R(
                    nil,
                    A.x + 1 + __mod(y, 2),
                    y,
                    2,
                    1,
                    "#4a2e18"
                )
                y = y + 5
            end
        end
        do
            local x = 0
            while x < 30 do
                R(
                    nil,
                    A.x + 4 + x,
                    147 - math.floor(x * 0.2 + 0.5),
                    1,
                    3,
                    "#6a4426"
                )
                x = x + 1
            end
        end
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({A.cx, A.cy, 26}, 3),
                __arrL({A.cx - 22, A.cy + 8, 17}, 3),
                __arrL({A.cx + 22, A.cy + 6, 18}, 3),
                __arrL({A.cx - 10, A.cy - 16, 16}, 3),
                __arrL({A.cx + 12, A.cy - 14, 15}, 3),
                __arrL({A.cx + 30, A.cy + 18, 11}, 3)
            },
            6
        ))) do
            local x = ____value[1]
            local y = ____value[2]
            local r = ____value[3]
            B(
                nil,
                x,
                y,
                r,
                "#3a6e2e"
            )
            B(
                nil,
                x - 3,
                y - 3,
                r - 4,
                "#4f8a3a"
            )
            B(
                nil,
                x - 6,
                y - 6,
                math.max(2, r - 11),
                "#6aa84a"
            )
        end
        do
            local i = 0
            while i < 60 do
                R(
                    nil,
                    A.cx - 40 + __L1:hash(i * 7.3) * 80,
                    A.cy - 26 + __L1:hash(i * 1.9) * 48,
                    1,
                    1,
                    __L1:hash(i) > 0.5 and "#2f5a26" or "#86c25a"
                )
                i = i + 1
            end
        end
        for ____, ____value in __iterar((__L1.CACAUS)) do
            local x = ____value[1]
            local y = ____value[2]
            R(
                nil,
                x - 1,
                y - 14,
                3,
                14,
                "#5a3a22"
            )
            B(
                nil,
                x,
                y - 18,
                9,
                "#2f6a2e",
                7
            )
            B(
                nil,
                x - 2,
                y - 20,
                6,
                "#3f8a3a",
                4
            )
            B(
                nil,
                x - 3,
                y - 22,
                3,
                "#5aa84a",
                2
            )
            for ____, ____value in __iterar((__arrL(
                {
                    __arrL({-3, -9, "#e8882a"}, 3),
                    __arrL({2, -7, "#f0c030"}, 3),
                    __arrL({-1, -4, "#c8562a"}, 3)
                },
                3
            ))) do
                local dx = ____value[1]
                local dy = ____value[2]
                local c = ____value[3]
                R(
                    nil,
                    x + dx,
                    y + dy,
                    2,
                    4,
                    c
                )
                R(
                    nil,
                    x + dx,
                    y + dy,
                    1,
                    1,
                    "#ffffff55"
                )
            end
        end
        do
            local i = 0
            while i < 70 do
                do
                    local x = __L1:hash(i * 13.1) * __L1.LW
                    local y = 200 + __L1:hash(i * 3.3) * 66
                    local ____t_19 = __t
                    local ____t_result_18
                    local ____t_17 = __t
                    local ____t_result_16
                    local ____t_15 = __t
                    local ____t_result_14
                    local ____t_13 = __t
                    local ____temp_12 = __L1:naTrilha(x, y)
                    __O[3206] = ____temp_12
                    if ____t_13(____temp_12) then
                        ____t_result_14 = __O[3206]
                    else
                        ____t_result_14 = __L1:noRio(x - 4, y)
                    end
                    __O[3207] = ____t_result_14
                    if ____t_15(____t_result_14) then
                        ____t_result_16 = __O[3207]
                    else
                        ____t_result_16 = __L1:noRio(x + 4, y)
                    end
                    __O[3208] = ____t_result_16
                    if ____t_17(____t_result_16) then
                        ____t_result_18 = __O[3208]
                    else
                        ____t_result_18 = x < 180 and y > 210
                    end
                    if ____t_19(____t_result_18) then
                        do i = i + 1 continue end
                    end
                    R(
                        nil,
                        x,
                        y,
                        1,
                        2,
                        "#4f9a32"
                    )
                    R(
                        nil,
                        x,
                        y - 1,
                        2,
                        1,
                        __get(
                            __arrL({"#f8f4ea", "#f8d040", "#e87aa8", "#a87ae8"}, 4),
                            __mod(i, 4)
                        )
                    )
                end
                i = i + 1
            end
        end
    end
    __L1.fase = function(self)
        local p = __mod(
            __mod(__L1.hora, 1) + 1,
            1
        )
        local K = __arrL(
            {
                __arrL({0, "noite"}, 2),
                __arrL({0.2, "noite"}, 2),
                __arrL({0.27, "aurora"}, 2),
                __arrL({0.35, "dia"}, 2),
                __arrL({0.66, "dia"}, 2),
                __arrL({0.74, "tarde"}, 2),
                __arrL({0.81, "noite"}, 2),
                __arrL({1, "noite"}, 2)
            },
            8
        )
        local C = {noite = {a = "#0b1030", b = "#2a3566", n = 1, w = 0}, aurora = {a = "#4a5a9a", b = "#f6a86a", n = 0.35, w = 0.6}, dia = {a = "#5aa8e8", b = "#c4e8f8", n = 0, w = 0}, tarde = {a = "#4a3a7a", b = "#f48a4a", n = 0.3, w = 0.9}}
        local i = 0
        while __t(i < __len(K) - 2 and __gt(
            p,
            __get(
                __get(K, i + 1),
                0
            )
        )) do
            i = i + 1
        end
        local p0, n0 = table.unpack(
            __get(K, i),
            1,
            2
        )
        local p1, n1 = table.unpack(
            __get(K, i + 1),
            1,
            2
        )
        local k = (p - p0) / math.max(0.000001, p1 - p0)
        local A = __get(C, n0)
        local Bc = __get(C, n1)
        return {
            p = p,
            a = __L1:mixc(A.a, Bc.a, k),
            b = __L1:mixc(A.b, Bc.b, k),
            noite = __L1:lerp(A.n, Bc.n, k),
            quente = __L1:lerp(A.w, Bc.w, k)
        }
    end
    __L1.galinha = function(self, c, x, y, d, bica, branca, z)
        if z == nil then
            z = 0
        end
        local Rr = __L1:pinta(c)
        local function RM(____, dx, dy, w, h, col)
            local ____gt_result_20
            if __gt(d, 0) then
                ____gt_result_20 = __add(x, dx)
            else
                ____gt_result_20 = x - dx - w + 1
            end
            return Rr(
                nil,
                ____gt_result_20,
                __add(y, dy) - z,
                w,
                h,
                col
            )
        end
        local corpo = __t(branca) and "#f6f2ea" or "#b8743a"
        local sombra = __t(branca) and "#d8d0c4" or "#8a5228"
        Rr(
            nil,
            x - 3,
            y,
            7,
            1,
            "rgba(0,0,0,.22)"
        )
        RM(
            nil,
            -1,
            -1,
            1,
            1,
            "#e8a030"
        )
        RM(
            nil,
            1,
            -1,
            1,
            1,
            "#e8a030"
        )
        RM(
            nil,
            -4,
            -6,
            7,
            5,
            corpo
        )
        RM(
            nil,
            -3,
            -7,
            5,
            1,
            corpo
        )
        RM(
            nil,
            -6,
            -9,
            2,
            4,
            sombra
        )
        RM(
            nil,
            -5,
            -8,
            1,
            2,
            corpo
        )
        RM(
            nil,
            -2,
            -5,
            3,
            2,
            sombra
        )
        if __t(bica) then
            RM(
                nil,
                2,
                -6,
                3,
                3,
                corpo
            )
            RM(
                nil,
                3,
                -7,
                2,
                1,
                "#e03a2a"
            )
            RM(
                nil,
                5,
                -4,
                1,
                1,
                "#f0b030"
            )
            RM(
                nil,
                4,
                -5,
                1,
                1,
                "#1c1c1c"
            )
        else
            RM(
                nil,
                2,
                -10,
                3,
                4,
                corpo
            )
            RM(
                nil,
                3,
                -11,
                2,
                1,
                "#e03a2a"
            )
            RM(
                nil,
                5,
                -9,
                1,
                1,
                "#f0b030"
            )
            RM(
                nil,
                4,
                -9,
                1,
                1,
                "#1c1c1c"
            )
            RM(
                nil,
                4,
                -7,
                1,
                1,
                "#e03a2a"
            )
        end
    end
    __L1.daRoca = function(self, c, o, t)
        local Rr = __L1:pinta(c)
        local x = math.floor(o.x + 0.5)
        local y = math.floor(o.y + 0.5)
        local resp = math.floor(math.sin(t * 2) * 0.5 + 0.5)
        local pele = "#c98a5a"
        Rr(
            nil,
            x - 5,
            y,
            11,
            1,
            "rgba(0,0,0,.22)"
        )
        Rr(
            nil,
            x - 3,
            y - 8,
            3,
            7,
            "#3a3a52"
        )
        Rr(
            nil,
            x + 1,
            y - 8,
            3,
            7,
            "#3a3a52"
        )
        Rr(
            nil,
            x - 3,
            y - 2,
            3,
            2,
            "#4a2a18"
        )
        Rr(
            nil,
            x + 1,
            y - 2,
            3,
            2,
            "#4a2a18"
        )
        Rr(
            nil,
            x - 4,
            y - 17 + resp,
            9,
            9 - resp,
            "#d8783a"
        )
        Rr(
            nil,
            x + 3,
            y - 17 + resp,
            2,
            9 - resp,
            "#b05a28"
        )
        Rr(
            nil,
            x - 4,
            y - 9,
            9,
            1,
            "#4a2a18"
        )
        Rr(
            nil,
            x - 6,
            y - 16 + resp,
            2,
            6,
            "#6a4a2a"
        )
        Rr(
            nil,
            x - 6,
            y - 15 + resp,
            2,
            6,
            "#d8783a"
        )
        Rr(
            nil,
            x - 6,
            y - 9 + resp,
            2,
            2,
            pele
        )
        if __gt(o.aceno, 0) then
            local a = math.floor(math.sin(t * 16) * 1.5 + 0.5)
            Rr(
                nil,
                x + 5,
                y - 22 + resp,
                2,
                7,
                "#d8783a"
            )
            Rr(
                nil,
                x + 5 + a,
                y - 25 + resp,
                2,
                3,
                pele
            )
        else
            Rr(
                nil,
                x + 5,
                y - 15 + resp,
                2,
                6,
                "#d8783a"
            )
            Rr(
                nil,
                x + 5,
                y - 9 + resp,
                2,
                2,
                pele
            )
        end
        local hy = y - 23 + resp
        Rr(
            nil,
            x - 3,
            hy,
            7,
            6,
            pele
        )
        Rr(
            nil,
            x + 3,
            hy + 1,
            1,
            4,
            "#b87a4a"
        )
        if __t(__mod(
            math.floor(t * 1.3),
            6
        ) == 0 and __mod(t * 1.3, 1) < 0.15) then
            Rr(
                nil,
                x,
                hy + 2,
                4,
                1,
                "#2a1a10"
            )
        else
            Rr(
                nil,
                x,
                hy + 2,
                1,
                1,
                "#2a1a10"
            )
            Rr(
                nil,
                x + 2,
                hy + 2,
                1,
                1,
                "#2a1a10"
            )
        end
        Rr(
            nil,
            x,
            hy + 4,
            3,
            1,
            "#7a3a2a"
        )
        local cy = hy - 1 - math.floor(o.chapeu + 0.5)
        Rr(
            nil,
            x - 6,
            cy,
            13,
            2,
            "#e8c86a"
        )
        Rr(
            nil,
            x - 6,
            cy + 1,
            13,
            1,
            "#b8963a"
        )
        Rr(
            nil,
            x - 3,
            cy - 4,
            7,
            4,
            "#f0d27a"
        )
        Rr(
            nil,
            x - 3,
            cy - 1,
            7,
            1,
            "#8a3a2a"
        )
        Rr(
            nil,
            x - 2,
            cy - 4,
            2,
            1,
            "#fff0b0"
        )
    end
    __L1.sapinho = function(self, c, o, t)
        local Rr = __L1:pinta(c)
        local x = math.floor(o.x + 0.5)
        local y = math.floor(o.y - o.z + 0.5)
        Rr(
            nil,
            x - 4,
            math.floor(o.y + 0.5),
            9,
            1,
            "rgba(0,0,0,.2)"
        )
        Rr(
            nil,
            x - 4,
            y - 4,
            9,
            4,
            "#4a9a3a"
        )
        Rr(
            nil,
            x - 3,
            y - 5,
            7,
            1,
            "#4a9a3a"
        )
        Rr(
            nil,
            x - 3,
            y - 2,
            7,
            2,
            "#a8d878"
        )
        Rr(
            nil,
            x - 5,
            y - 1,
            2,
            1,
            "#3a7a2a"
        )
        Rr(
            nil,
            x + 4,
            y - 1,
            2,
            1,
            "#3a7a2a"
        )
        Rr(
            nil,
            x - 3,
            y - 7,
            3,
            3,
            "#4a9a3a"
        )
        Rr(
            nil,
            x + 1,
            y - 7,
            3,
            3,
            "#4a9a3a"
        )
        if __gt(o.pisca, 0) then
            Rr(
                nil,
                x - 2,
                y - 6,
                2,
                1,
                "#2a5a20"
            )
            Rr(
                nil,
                x + 2,
                y - 6,
                2,
                1,
                "#2a5a20"
            )
        else
            Rr(
                nil,
                x - 2,
                y - 6,
                2,
                2,
                "#ffffff"
            )
            Rr(
                nil,
                x + 2,
                y - 6,
                2,
                2,
                "#ffffff"
            )
            Rr(
                nil,
                x - 1,
                y - 6,
                1,
                1,
                "#1c1c1c"
            )
            Rr(
                nil,
                x + 3,
                y - 6,
                1,
                1,
                "#1c1c1c"
            )
        end
        if __gt(o.papo, 0) then
            __L1:bola(c)(
                nil,
                x,
                y - 2,
                2 + math.floor(o.papo * 2 + 0.5),
                "#d8f0a0",
                2
            )
        end
    end
    __L1.planta = function(self, c, p, t)
        local Rr = __L1:pinta(c)
        local Bb = __L1:bola(c)
        local x = math.floor(p.x + 0.5)
        local y = math.floor(p.y + 0.5)
        local idade = t - p.t0
        local ____t_result_21
        if __t(p.fim) then
            ____t_result_21 = __L1:clamp(1 - (t - p.fim) / 0.8, 0, 1)
        else
            ____t_result_21 = 1
        end
        local fim = ____t_result_21
        if fim <= 0 then
            return
        end
        if fim < 1 then
            c.globalAlpha = fim
        end
        Rr(
            nil,
            x - 3,
            y,
            7,
            2,
            "#7a4a28"
        )
        Rr(
            nil,
            x - 2,
            y - 1,
            5,
            1,
            "#8a5a34"
        )
        if idade < 0.35 then
            Rr(
                nil,
                x,
                y - 2,
                1,
                1,
                "#e8d8a0"
            )
            c.globalAlpha = 1
            return
        end
        if idade < 0.9 then
            local s = math.floor(__L1:clamp((idade - 0.35) / 0.3, 0, 1) * 3 + 0.5)
            Rr(
                nil,
                x,
                y - 1 - s,
                1,
                s + 1,
                "#4f9a32"
            )
            Rr(
                nil,
                x - 2,
                y - 2 - s,
                2,
                1,
                "#6abf4a"
            )
            Rr(
                nil,
                x + 1,
                y - 2 - s,
                2,
                1,
                "#6abf4a"
            )
            c.globalAlpha = 1
            return
        end
        local ____temp_22
        if idade < 1.15 then
            ____temp_22 = 1 + math.sin((idade - 0.9) / 0.25 * math.pi) * 0.3
        else
            ____temp_22 = 1
        end
        local pop = ____temp_22
        local function h(____, n)
            return math.floor(n * pop + 0.5)
        end
        local bal = math.floor(math.sin(t * 1.6 + p.x) * (idade > 1.15 and 1 or 0) + 0.5)
        if p.tipo == "girassol" then
            Rr(
                nil,
                x,
                y - h(nil, 18),
                1,
                h(nil, 18),
                "#3f8a2a"
            )
            Rr(
                nil,
                x - 3,
                y - h(nil, 9),
                3,
                2,
                "#4f9a32"
            )
            Rr(
                nil,
                x + 1,
                y - h(nil, 12),
                3,
                2,
                "#4f9a32"
            )
            local hx2 = x + bal
            local hy = y - h(nil, 20)
            Bb(
                nil,
                hx2,
                hy,
                4,
                "#f8c820"
            )
            Bb(
                nil,
                hx2,
                hy,
                2,
                "#7a4a1c"
            )
            Rr(
                nil,
                hx2 - 1,
                hy - 1,
                1,
                1,
                "#a8642a"
            )
        elseif p.tipo == "milho" then
            Rr(
                nil,
                x,
                y - h(nil, 20),
                2,
                h(nil, 20),
                "#4f9a32"
            )
            do
                local k = 0
                while k < 4 do
                    local yy = y - h(nil, 5 + k * 4)
                    local dd = __t(__mod(k, 2)) and 1 or -1
                    local ____temp_23
                    if dd > 0 then
                        ____temp_23 = x + 2
                    else
                        ____temp_23 = x - 4
                    end
                    Rr(
                        nil,
                        ____temp_23,
                        yy,
                        4,
                        1,
                        "#6abf4a"
                    )
                    local ____temp_24
                    if dd > 0 then
                        ____temp_24 = x + 5
                    else
                        ____temp_24 = x - 5
                    end
                    Rr(
                        nil,
                        ____temp_24,
                        yy + 1,
                        1,
                        1,
                        "#6abf4a"
                    )
                    k = k + 1
                end
            end
            Rr(
                nil,
                x + 2,
                y - h(nil, 13),
                2,
                5,
                "#f0c838"
            )
            Rr(
                nil,
                x + 2,
                y - h(nil, 13),
                1,
                5,
                "#e0a828"
            )
            Rr(
                nil,
                x + bal,
                y - h(nil, 23),
                1,
                3,
                "#e8d878"
            )
            Rr(
                nil,
                x - 1 + bal,
                y - h(nil, 22),
                3,
                1,
                "#e8d878"
            )
        elseif p.tipo == "flores" then
            for ____, ____value in __iterar((__arrL(
                {
                    __arrL({-3, 6, "#e87aa8"}, 3),
                    __arrL({0, 9, "#a87ae8"}, 3),
                    __arrL({3, 5, "#f8f4ea"}, 3)
                },
                3
            ))) do
                local dx = ____value[1]
                local hh = ____value[2]
                local col = ____value[3]
                Rr(
                    nil,
                    x + dx,
                    y - h(nil, hh),
                    1,
                    h(nil, hh),
                    "#4f9a32"
                )
                local fx = x + dx + bal
                local fy = y - h(nil, hh) - 1
                Rr(
                    nil,
                    fx - 1,
                    fy,
                    3,
                    1,
                    col
                )
                Rr(
                    nil,
                    fx,
                    fy - 1,
                    1,
                    3,
                    col
                )
                Rr(
                    nil,
                    fx,
                    fy,
                    1,
                    1,
                    "#f8d040"
                )
            end
        elseif p.tipo == "abobora" then
            Rr(
                nil,
                x - 6,
                y - 1,
                12,
                1,
                "#3f8a2a"
            )
            Bb(
                nil,
                x - 6,
                y - 3,
                2,
                "#4f9a32"
            )
            Bb(
                nil,
                x + 6,
                y - 2,
                2,
                "#4f9a32"
            )
            Bb(
                nil,
                x,
                y - h(nil, 4),
                h(nil, 5),
                "#e8782a",
                h(nil, 4)
            )
            Rr(
                nil,
                x - 2,
                y - h(nil, 8),
                1,
                h(nil, 8),
                "#c85a1a"
            )
            Rr(
                nil,
                x + 2,
                y - h(nil, 8),
                1,
                h(nil, 7),
                "#c85a1a"
            )
            Rr(
                nil,
                x,
                y - h(nil, 9),
                1,
                2,
                "#4a6a2a"
            )
            Rr(
                nil,
                x - 3,
                y - h(nil, 7),
                2,
                1,
                "#f8a858"
            )
        elseif p.tipo == "cacau" then
            Rr(
                nil,
                x,
                y - h(nil, 13),
                2,
                h(nil, 13),
                "#5a3a22"
            )
            Bb(
                nil,
                x + bal,
                y - h(nil, 16),
                h(nil, 6),
                "#2f6a2e",
                h(nil, 5)
            )
            Bb(
                nil,
                x - 1 + bal,
                y - h(nil, 17),
                h(nil, 3),
                "#4f9a3a",
                h(nil, 3)
            )
            Rr(
                nil,
                x - 2,
                y - h(nil, 9),
                2,
                3,
                "#e8882a"
            )
            Rr(
                nil,
                x + 2,
                y - h(nil, 7),
                2,
                3,
                "#f0c030"
            )
        else
            Bb(
                nil,
                x,
                y - h(nil, 3),
                h(nil, 5),
                "#3f8a32",
                h(nil, 3)
            )
            Bb(
                nil,
                x - 1,
                y - h(nil, 4),
                h(nil, 3),
                "#6abf4a",
                h(nil, 2)
            )
            Rr(
                nil,
                x,
                y - h(nil, 5),
                1,
                1,
                "#a8e07a"
            )
        end
        c.globalAlpha = 1
    end
    __L1.brilho = function(self, x, y, n, cores)
        if n == nil then
            n = 8
        end
        if cores == nil then
            cores = __arrL({"#fff6b0", "#ffffff", "#f8d040"}, 3)
        end
        do
            local i = 0
            while i < n do
                local a = __L1:rnd(0, 6.28)
                local v = __L1:rnd(15, 45)
                __L1:P({
                    x = x,
                    y = y,
                    vx = math.cos(a) * v,
                    vy = math.sin(a) * v - 10,
                    gr = 30,
                    vida = __L1:rnd(0.4, 0.8),
                    cor = __get(
                        cores,
                        __mod(
                            i,
                            __len(cores)
                        )
                    ),
                    tipo = "estrela"
                })
                i = i + 1
            end
        end
    end
    __L1.folhas = function(self, x, y, n, cores)
        if n == nil then
            n = 6
        end
        if cores == nil then
            cores = __arrL({"#4f8a3a", "#6aa84a", "#86c25a"}, 3)
        end
        do
            local i = 0
            while i < n do
                __L1:P({
                    x = __add(
                        x,
                        __L1:rnd(-14, 14)
                    ),
                    y = __add(
                        y,
                        __L1:rnd(-8, 8)
                    ),
                    vx = __L1:rnd(-12, 12),
                    vy = __L1:rnd(-6, 4),
                    gr = 18,
                    vida = __L1:rnd(1.4, 2.4),
                    cor = __get(
                        cores,
                        __mod(
                            i,
                            __len(cores)
                        )
                    ),
                    tipo = "folha",
                    f = __L1:rnd(0, 6)
                })
                i = i + 1
            end
        end
    end
    __L1.atualizar = function(self, dt)
        __L1.tempo = __L1.tempo + dt
        if __L1.horaAlvo ~= nil then
            local d = __L1.horaAlvo - __L1.hora
            local passo = __TS__MathSign(d) * math.min(
                math.abs(d),
                dt * 0.2
            )
            __L1.hora = __L1.hora + passo
            if math.abs(__L1.horaAlvo - __L1.hora) < 0.002 then
                __L1.hora = __mod(__L1.horaAlvo, 1)
                __L1.horaAlvo = nil
            end
        else
            __L1.hora = __mod(__L1.hora + dt / 1200, 1)
        end
        __L1.pas = __L1.pas + __L1.pasVel * dt
        __L1.pasVel = __L1.pasVel + (0.55 - __L1.pasVel) * math.min(1, dt * 0.5)
        __L1.balancoV = __L1.balancoV + (__TS__Number(-__L1.balanco) * 9 - __L1.balancoV * 0.25) * dt
        __L1.balanco = __L1.balanco + __L1.balancoV * dt
        if __t(math.abs(__L1.balanco) < 0.12 and math.abs(__L1.balancoV) < 0.4) then
            local ____L1_26, ____balancoV_27 = __L1, "balancoV"
            local ____t_result_25
            if __t(__L1.balancoV) then
                ____t_result_25 = __L1.balancoV
            else
                ____t_result_25 = 1
            end
            ____L1_26[____balancoV_27] = ____L1_26[____balancoV_27] + __TS__MathSign(____t_result_25) * 0.5 * dt
        end
        for ____, n in __iterar((__L1.nuvens)) do
            n.x = n.x + n.v * dt
            if n.x - n.w > __L1.LW + 20 then
                n.x = __TS__Number(-n.w) - 20
            end
        end
        for ____, gal in __iterar((__L1.galinhas)) do
            gal.t = gal.t - dt
            gal.bica = math.max(0, gal.bica - dt)
            gal.susto = math.max(0, gal.susto - dt)
            local ____t_31 = __t
            local ____t_result_30
            local ____t_29 = __t
            local ____temp_28 = gal.z > 0
            __O[3209] = ____temp_28
            if ____t_29(____temp_28) then
                ____t_result_30 = __O[3209]
            else
                ____t_result_30 = gal.vz
            end
            if ____t_31(____t_result_30) then
                gal.vz = gal.vz + 300 * dt
                gal.z = gal.z - gal.vz * dt
                if gal.z <= 0 then
                    gal.z = 0
                    gal.vz = 0
                end
            end
            if __t(gal.alvo) then
                local dx = __get(gal.alvo, 0) - gal.x
                local dy = __get(gal.alvo, 1) - gal.y
                local d = __hypot(dx, dy)
                local v = gal.susto > 0 and 55 or 16
                if d < 1.5 then
                    gal.alvo = nil
                else
                    gal.x = gal.x + dx / d * v * dt
                    gal.y = gal.y + dy / d * v * dt
                    gal.d = dx >= 0 and 1 or -1
                end
            elseif __le(gal.t, 0) then
                gal.t = __L1:rnd(1.2, 3.5)
                if math.random() < 0.45 then
                    gal.bica = __L1:rnd(0.6, 1.4)
                else
                    gal.alvo = __arrL(
                        {
                            __L1:clamp(
                                gal.x + __L1:rnd(-40, 40),
                                196,
                                318
                            ),
                            __L1:clamp(
                                gal.y + __L1:rnd(-14, 14),
                                204,
                                252
                            )
                        },
                        2
                    )
                end
            end
        end
        __L1.roca.aceno = math.max(0, __L1.roca.aceno - dt)
        local ____L1_roca_32, ____vChapeu_33 = __L1.roca, "vChapeu"
        ____L1_roca_32[____vChapeu_33] = ____L1_roca_32[____vChapeu_33] - 220 * dt
        __L1.roca.chapeu = math.max(0, __L1.roca.chapeu + __L1.roca.vChapeu * dt)
        if __L1.roca.chapeu == 0 then
            __L1.roca.vChapeu = 0
        end
        __L1.sapo.pisca = math.max(0, __L1.sapo.pisca - dt)
        if math.random() < dt * 0.25 then
            __L1.sapo.pisca = 0.15
        end
        __L1.sapo.papo = math.max(0, __L1.sapo.papo - dt * 1.5)
        if math.random() < dt * 0.15 then
            __L1.sapo.papo = 1
        end
        local ____t_37 = __t
        local ____t_result_36
        local ____t_35 = __t
        local ____temp_34 = __L1.sapo.z > 0
        __O[3210] = ____temp_34
        if ____t_35(____temp_34) then
            ____t_result_36 = __O[3210]
        else
            ____t_result_36 = __L1.sapo.vz
        end
        if ____t_37(____t_result_36) then
            local ____L1_sapo_38, ____vz_39 = __L1.sapo, "vz"
            ____L1_sapo_38[____vz_39] = ____L1_sapo_38[____vz_39] + 320 * dt
            local ____L1_sapo_40, ____z_41 = __L1.sapo, "z"
            ____L1_sapo_40[____z_41] = ____L1_sapo_40[____z_41] - __L1.sapo.vz * dt
            if __L1.sapo.z <= 0 then
                __L1.sapo.z = 0
                __L1.sapo.vz = 0
                __call(__L1.aneis, "push", {x = __L1.sapo.x + 10, y = __L1.sapo.y, r = 1, t = 0})
            end
        end
        if __t(__L1.peixe) then
            __L1.peixe.t = __add(__L1.peixe.t, dt)
            if __gt(__L1.peixe.t, 0.9) then
                __call(__L1.aneis, "push", {x = __L1.peixe.x + 14, y = __L1.peixe.y0, r = 1, t = 0})
                __L1.peixe = nil
            end
        end
        __L1.fumacaExtra = math.max(0, __L1.fumacaExtra - dt)
        __L1.luzCasa = math.max(0, __L1.luzCasa - dt)
        if math.random() < dt * (__L1.fumacaExtra > 0 and 14 or 1.6) then
            __L1:P({
                x = 108 + __L1:rnd(-1, 1),
                y = 104,
                vx = __L1:rnd(2, 6),
                vy = __TS__Number(-__L1:rnd(8, 14)),
                vida = __L1:rnd(2, 3),
                cor = "#f2f2ee",
                tipo = "fumaca"
            })
        end
        for ____, a in __iterar((__L1.aves)) do
            a.x = a.x + a.v * dt
        end
        do
            local i = __len(__L1.aves) - 1
            while i >= 0 do
                if __t(__gt(
                    __get(__L1.aves, i).x,
                    __L1.LW + 60
                ) or __lt(
                    __get(__L1.aves, i).x,
                    -80
                )) then
                    __call(__L1.aves, "splice", i, 1)
                end
                i = i - 1
            end
        end
        local fz = __L1:fase()
        if __t(__lt(fz.noite, 0.5) and math.random() < dt * 0.05) then
            __call(
                __L1.aves,
                "push",
                {
                    x = -40,
                    y = __L1:rnd(20, 80),
                    v = __L1:rnd(26, 40),
                    n = 3 + __bor(
                        math.random() * 3,
                        0
                    ),
                    f = __L1:rnd(0, 6)
                }
            )
        end
        if __t(__gt(fz.noite, 0.7) and math.random() < dt * 0.04) then
            __call(
                __L1.cadentes,
                "push",
                {
                    x = __L1:rnd(80, 420),
                    y = __L1:rnd(10, 40),
                    vx = __L1:rnd(-140, -90),
                    vy = __L1:rnd(40, 70),
                    t = 0
                }
            )
        end
        for ____, s in __iterar((__L1.cadentes)) do
            s.t = __add(s.t, dt)
            s.x = s.x + s.vx * dt
            s.y = s.y + s.vy * dt
        end
        do
            local i = __len(__L1.cadentes) - 1
            while i >= 0 do
                if __gt(
                    __get(__L1.cadentes, i).t,
                    1.1
                ) then
                    __call(__L1.cadentes, "splice", i, 1)
                end
                i = i - 1
            end
        end
        for ____, ch in __iterar((__L1.chuvas)) do
            ch.t = __add(ch.t, dt)
            if __lt(ch.t, 2.2) then
                do
                    local k = 0
                    while k < 3 do
                        __L1:P({
                            x = __add(
                                ch.x,
                                __L1:rnd(
                                    __TS__Number(-ch.w),
                                    ch.w
                                )
                            ),
                            y = ch.y + 4,
                            vy = __L1:rnd(120, 160),
                            vx = -6,
                            vida = 1.2,
                            cor = "#8ac8f0",
                            tipo = "gota",
                            chao = __L1:rnd(170, 262)
                        })
                        k = k + 1
                    end
                end
            end
        end
        do
            local i = __len(__L1.chuvas) - 1
            while i >= 0 do
                if __gt(
                    __get(__L1.chuvas, i).t,
                    2.4
                ) then
                    __call(__L1.chuvas, "splice", i, 1)
                end
                i = i - 1
            end
        end
        for ____, a in __iterar((__L1.aneis)) do
            a.t = __add(a.t, dt)
            a.r = a.r + dt * 14
        end
        do
            local i = __len(__L1.aneis) - 1
            while i >= 0 do
                if __gt(
                    __get(__L1.aneis, i).t,
                    0.9
                ) then
                    __call(__L1.aneis, "splice", i, 1)
                end
                i = i - 1
            end
        end
        for ____, p in __iterar((__L1.parts)) do
            p.t = __add(p.t, dt)
            p.vy = p.vy + p.gr * dt
            p.x = p.x + p.vx * dt
            p.y = p.y + p.vy * dt
            if p.tipo == "folha" then
                p.vx = math.sin(p.t * 3 + p.f) * 14
                p.vy = math.min(p.vy, 14)
            end
            if __t(p.tipo == "gota" and __gt(p.y, p.chao)) then
                p.t = p.vida
                __call(__L1.aneis, "push", {
                    x = p.x,
                    y = p.y,
                    r = 0.5,
                    t = 0.55,
                    chuva = true
                })
                for ____, pl in __iterar((__L1.plantas)) do
                    if __t(math.abs(pl.x - p.x) < 8 and math.abs(pl.y - p.y) < 8) then
                        pl.t0 = math.min(pl.t0, __L1.tempo - 1.2)
                    end
                end
            end
        end
        do
            local i = __len(__L1.parts) - 1
            while i >= 0 do
                if __ge(
                    __get(__L1.parts, i).t,
                    __get(__L1.parts, i).vida
                ) then
                    __call(__L1.parts, "splice", i, 1)
                end
                i = i - 1
            end
        end
        do
            local i = __len(__L1.plantas) - 1
            while i >= 0 do
                local ____t_45 = __t
                local ____t_result_44
                local ____t_43 = __t
                local ____get_result_fim_42 = __get(__L1.plantas, i).fim
                __O[3211] = ____get_result_fim_42
                if ____t_43(____get_result_fim_42) then
                    ____t_result_44 = __L1.tempo - __get(__L1.plantas, i).fim > 0.8
                else
                    ____t_result_44 = __O[3211]
                end
                if ____t_45(____t_result_44) then
                    __call(__L1.plantas, "splice", i, 1)
                end
                i = i - 1
            end
        end
    end
    __L1.desenharCena = function(self)
        local fz = __L1:fase()
        local t = __L1.tempo
        do
            local y = 0
            while y < __L1.HZ + 6 do
                __L1:Rg(
                    0,
                    y,
                    __L1.LW,
                    2,
                    __L1:mixc(fz.a, fz.b, y / (__L1.HZ + 6))
                )
                y = y + 2
            end
        end
        if __gt(fz.noite, 0.05) then
            for ____, s in __iterar((__L1.estrelas)) do
                local a = fz.noite * (0.4 + 0.6 * math.abs(math.sin(t * 1.3 + s.f)))
                g.globalAlpha = a
                __L1:Rg(
                    s.x,
                    s.y,
                    1,
                    1,
                    "#fffbe0"
                )
                if s.f > 5.2 then
                    __L1:Rg(
                        s.x - 1,
                        s.y,
                        3,
                        1,
                        "#fffbe0"
                    )
                    __L1:Rg(
                        s.x,
                        s.y - 1,
                        1,
                        3,
                        "#fffbe0"
                    )
                end
            end
        end
        g.globalAlpha = 1
        local sol = __L1:posSol(fz.p)
        local lua = __L1:posLua(fz.p)
        if __t(sol) then
            g.globalAlpha = 0.25
            __L1:Bg(sol.x, sol.y, 20, "#fff2a0")
            g.globalAlpha = 1
            do
                local k = 0
                while k < 8 do
                    local a = t * 0.4 + k * 0.785
                    do
                        local j = 14
                        while j < 19 do
                            __L1:Rg(
                                sol.x + math.cos(a) * j,
                                sol.y + math.sin(a) * j,
                                1,
                                1,
                                "#fff2a0"
                            )
                            j = j + 1
                        end
                    end
                    k = k + 1
                end
            end
            __L1:Bg(sol.x, sol.y, 11, "#ffd23a")
            __L1:Bg(sol.x - 2, sol.y - 2, 7, "#ffe88a")
            __L1:Rg(
                sol.x - 5,
                sol.y - 6,
                3,
                2,
                "#fffbe0"
            )
        end
        if __t(lua) then
            g.globalAlpha = 0.18
            __L1:Bg(lua.x, lua.y, 18, "#e8f0ff")
            g.globalAlpha = 1
            __L1:Bg(lua.x, lua.y, 9, "#f4f2e0")
            __L1:Bg(lua.x + 4, lua.y - 3, 8, fz.a)
            __L1:Rg(
                lua.x - 5,
                lua.y + 1,
                2,
                2,
                "#d8d6c4"
            )
            __L1:Rg(
                lua.x - 3,
                lua.y + 4,
                1,
                1,
                "#d8d6c4"
            )
        end
        for ____, s in __iterar((__L1.cadentes)) do
            do
                local k = 0
                while k < 14 do
                    g.globalAlpha = (1 - k / 14) * (1 - s.t / 1.1)
                    __L1:Rg(
                        s.x - s.vx * k * 0.008,
                        s.y - s.vy * k * 0.008,
                        2,
                        1,
                        "#fffbe0"
                    )
                    k = k + 1
                end
            end
        end
        g.globalAlpha = 1
        local corN = __L1:mixc("#ffffff", "#4a4a7a", fz.noite * 0.8)
        local corNs = __L1:mixc("#d8e8f4", "#2a2a52", fz.noite * 0.8)
        for ____, n in __iterar((__L1.nuvens)) do
            local cx = n.x
            local cy = n.y
            local w = n.w
            __L1:Bg(
                cx,
                cy + 3,
                w,
                corNs,
                6
            )
            __L1:Bg(
                cx - w * 0.4,
                cy,
                w * 0.45,
                corN,
                6
            )
            __L1:Bg(
                cx + w * 0.1,
                cy - 3,
                w * 0.5,
                corN,
                8
            )
            __L1:Bg(
                cx + w * 0.5,
                cy + 1,
                w * 0.35,
                corN,
                5
            )
            __L1:Rg(
                cx - w,
                cy + 6,
                w * 2,
                3,
                corNs
            )
        end
        for ____, a in __iterar((__L1.aves)) do
            do
                local i = 0
                while __lt(i, a.n) do
                    local lado = __t(__mod(i, 2)) and 1 or -1
                    local k = math.ceil(i / 2)
                    local bx = a.x - k * 7
                    local by = a.y + lado * k * 4 + math.sin(t * 2 + a.f) * 3
                    local asa = math.sin(t * 12 + i + a.f) > 0
                    __L1:Rg(
                        bx - 3,
                        by - (__t(asa) and 2 or 0),
                        2,
                        1,
                        "#2a2a3a"
                    )
                    __L1:Rg(
                        bx - 1,
                        by,
                        2,
                        1,
                        "#2a2a3a"
                    )
                    __L1:Rg(
                        bx + 1,
                        by - (__t(asa) and 2 or 0),
                        2,
                        1,
                        "#2a2a3a"
                    )
                    i = i + 1
                end
            end
        end
        q:clearRect(0, 0, __L1.LW, __L1.LH)
        q:drawImage(fixo, 0, 0)
        do
            local i = 0
            while i < 26 do
                local y = __L1.HZ + 6 + __mod(i * 37, __L1.LH - __L1.HZ - 8)
                local ph = __mod(
                    t * 0.5 + __L1:hash(i) * 4,
                    1
                )
                local x0 = __L1:rioL(y)
                local x1 = __L1:rioR(y)
                local x = x0 + 3 + __mod(
                    __L1:hash(i * 3) + ph * 0.3,
                    1
                ) * math.max(1, x1 - x0 - 8)
                q.globalAlpha = math.sin(ph * math.pi) * 0.7
                __L1:R(
                    x,
                    y + ph * 4,
                    3 + __L1:kY(y) * 4,
                    1,
                    "#e2f6ff"
                )
                i = i + 1
            end
        end
        q.globalAlpha = 1
        for ____, a in __iterar((__L1.aneis)) do
            q.globalAlpha = math.max(0, 1 - a.t / 0.9)
            q.strokeStyle = __t(a.chuva) and "#cfe8ff" or "#e8f8ff"
            q.lineWidth = 1
            q:beginPath()
            q:ellipse(
                a.x,
                a.y,
                a.r * 1.6,
                a.r * 0.6,
                0,
                0,
                math.pi * 2
            )
            q:stroke()
        end
        q.globalAlpha = 1
        if __t(__L1.peixe) then
            local u = __L1.peixe.t / 0.9
            local x = __L1.peixe.x + u * 28
            local y = __L1.peixe.y0 - math.sin(u * math.pi) * 22
            local ang = math.cos(u * math.pi)
            __L1:R(
                x - 3,
                y - 1,
                7,
                3,
                "#f08a3a"
            )
            __L1:R(
                x - 3,
                y - 1,
                7,
                1,
                "#f8b060"
            )
            __L1:R(
                x + (ang > 0 and 3 or -5),
                y - 1 + math.floor(ang + 0.5),
                2,
                3,
                "#d86a2a"
            )
            __L1:R(
                x + 2,
                y - 1,
                1,
                1,
                "#1c1c1c"
            )
        end
        local ____L1_MOINHO_46 = __L1.MOINHO
        local mx = ____L1_MOINHO_46.hx
        local my = ____L1_MOINHO_46.hy
        do
            local b = 0
            while b < 4 do
                local a = __L1.pas + b * math.pi / 2
                local ca = math.cos(a)
                local sa = math.sin(a)
                do
                    local j = 4
                    while j < 36 do
                        local x = mx + ca * j
                        local y = my + sa * j
                        __L1:R(
                            x,
                            y,
                            2,
                            2,
                            "#6a4a30"
                        )
                        if j > 9 then
                            do
                                local w = 2
                                while w < 8 do
                                    __L1:R(
                                        x - sa * w,
                                        y + ca * w,
                                        1,
                                        1,
                                        __mod(j + w, 4) == 0 and "#a88a6a" or "#f2e8d0"
                                    )
                                    w = w + 1
                                end
                            end
                        end
                        j = j + 1
                    end
                end
                b = b + 1
            end
        end
        __L1:B(mx, my, 3, "#4a3020")
        __L1:R(
            mx - 1,
            my - 1,
            2,
            2,
            "#8a6a4a"
        )
        local sx = __L1.BALANCO.x + math.sin(__L1.balanco) * __L1.BALANCO.L
        local sy = __L1.BALANCO.y + math.cos(__L1.balanco) * __L1.BALANCO.L
        q.strokeStyle = "#d8c8a0"
        q.lineWidth = 1
        for ____, o in __iterar((__arrL({-4, 4}, 2))) do
            q:beginPath()
            q:moveTo(__L1.BALANCO.x + o, __L1.BALANCO.y)
            q:lineTo(sx + o, sy)
            q:stroke()
        end
        __L1:R(
            sx - 6,
            sy,
            13,
            2,
            "#8a5030"
        )
        __L1:R(
            sx - 6,
            sy,
            13,
            1,
            "#b07a44"
        )
        local ____arr_48 = __arr
        local ____array_47 = __TS__SparseArrayNew(__TS__Spread(__iter(__call(
            __L1.galinhas,
            "map",
            function(____, o) return {
                y = o.y,
                f = function() return __L1:galinha(
                    q,
                    math.floor(o.x + 0.5),
                    math.floor(o.y + 0.5),
                    o.d,
                    o.bica > 0,
                    o.br,
                    math.floor(o.z + 0.5)
                ) end
            } end
        ))))
        __TS__SparseArrayPush(
            ____array_47,
            {
                y = __L1.roca.y,
                f = function() return __L1:daRoca(q, __L1.roca, t) end
            },
            {
                y = __L1.sapo.y,
                f = function() return __L1:sapinho(q, __L1.sapo, t) end
            },
            __TS__Spread(__iter(__call(
                __L1.plantas,
                "map",
                function(____, p) return {
                    y = p.y,
                    f = function() return __L1:planta(q, p, t) end
                } end
            )))
        )
        local atores = ____arr_48(__TS__SparseArraySpread(____array_47))
        __call(
            atores,
            "sort",
            function(____, a, b) return a.y - b.y end
        )
        for ____, a in __iterar((atores)) do
            a:f()
        end
        if __lt(fz.noite, 0.6) then
            for ____, b in __iterar((__L1.borboletas)) do
                local bt = t + b.f
                local x = b.x + math.sin(bt * 0.6) * 30
                local y = b.y + math.sin(bt * 1.3) * 10 - 10
                local ab = math.sin(bt * 14) > 0
                __L1:R(
                    x - (__t(ab) and 2 or 1),
                    y,
                    __t(ab) and 2 or 1,
                    2,
                    b.c
                )
                __L1:R(
                    x + 1,
                    y,
                    __t(ab) and 2 or 1,
                    2,
                    b.c
                )
                __L1:R(
                    x,
                    y,
                    1,
                    2,
                    "#2a1a10"
                )
            end
        end
        for ____, p in __iterar((__L1.parts)) do
            local k = 1 - p.t / p.vida
            if p.tipo == "fumaca" then
                q.globalAlpha = k * 0.55
                __L1:B(p.x, p.y, 1.5 + (1 - k) * 4, p.cor)
            elseif p.tipo == "folha" then
                q.globalAlpha = math.min(1, k * 3)
                __L1:R(
                    p.x,
                    p.y,
                    2,
                    1,
                    p.cor
                )
                __L1:R(
                    p.x + (math.sin(p.t * 6) > 0 and 1 or 0),
                    p.y - 1,
                    1,
                    1,
                    p.cor
                )
            elseif p.tipo == "gota" then
                q.globalAlpha = 0.8
                __L1:R(
                    p.x,
                    p.y,
                    1,
                    3,
                    p.cor
                )
            elseif p.tipo == "pena" then
                q.globalAlpha = k
                __L1:R(
                    p.x,
                    p.y,
                    2,
                    1,
                    p.cor
                )
            elseif p.tipo == "coracao" then
                q.globalAlpha = k
                __L1:R(
                    p.x - 2,
                    p.y,
                    2,
                    1,
                    "#e84a6a"
                )
                __L1:R(
                    p.x + 1,
                    p.y,
                    2,
                    1,
                    "#e84a6a"
                )
                __L1:R(
                    p.x - 2,
                    p.y + 1,
                    5,
                    1,
                    "#e84a6a"
                )
                __L1:R(
                    p.x - 1,
                    p.y + 2,
                    3,
                    1,
                    "#e84a6a"
                )
                __L1:R(
                    p.x,
                    p.y + 3,
                    1,
                    1,
                    "#e84a6a"
                )
            elseif p.tipo == "pod" then
                q.globalAlpha = 1
                __L1:R(
                    p.x - 1,
                    p.y - 2,
                    3,
                    4,
                    p.cor
                )
                __L1:R(
                    p.x - 1,
                    p.y - 2,
                    1,
                    1,
                    "#ffffff66"
                )
            end
            q.globalAlpha = 1
        end
        q.globalCompositeOperation = "source-atop"
        if __gt(fz.noite, 0) then
            q.fillStyle = ("rgba(10,14,44," .. tostring(fz.noite * 0.58)) .. ")"
            q:fillRect(0, 0, __L1.LW, __L1.LH)
        end
        if __gt(fz.quente, 0) then
            q.fillStyle = ("rgba(255,128,48," .. tostring(fz.quente * 0.14)) .. ")"
            q:fillRect(0, 0, __L1.LW, __L1.LH)
        end
        q.globalCompositeOperation = "source-over"
        g:drawImage(chao, 0, 0)
        local luz = math.max(fz.noite, __L1.luzCasa > 0 and 0.8 or 0)
        if luz > 0.05 then
            g.globalCompositeOperation = "lighter"
            local function halo(____, x, y, r, a)
                local gr = g:createRadialGradient(
                    x,
                    y,
                    0,
                    x,
                    y,
                    r
                )
                gr:addColorStop(
                    0,
                    ("rgba(255,170,60," .. tostring(a)) .. ")"
                )
                gr:addColorStop(1, "rgba(255,170,60,0)")
                g.fillStyle = gr
                g:fillRect(x - r, y - r, r * 2, r * 2)
            end
            for ____, ____value in __iterar((__L1.JANELAS)) do
                local wx = ____value[1]
                local wy = ____value[2]
                local ww = ____value[3]
                local wh = ____value[4]
                g.globalAlpha = luz * 0.85
                __L1:Rg(
                    wx,
                    wy,
                    ww,
                    wh,
                    "#c87a20"
                )
                g.globalAlpha = 1
                halo(
                    nil,
                    wx + ww / 2,
                    wy + wh / 2,
                    ww + 8,
                    0.28 * luz
                )
            end
            halo(
                nil,
                348,
                160,
                12,
                0.4 * luz
            )
            g.globalAlpha = luz
            __L1:Rg(
                347,
                158,
                2,
                3,
                "#ffd080"
            )
            if __gt(fz.noite, 0.3) then
                for ____, v in __iterar((__L1.vagalumes)) do
                    local a = math.max(
                        0,
                        math.sin(t * 2 + v.f)
                    ) * fz.noite
                    g.globalAlpha = a
                    __L1:Rg(
                        v.x + math.sin(t * 0.7 + v.f) * 10,
                        v.y + math.cos(t * 0.5 + v.f) * 6,
                        1,
                        1,
                        "#e8ff80"
                    )
                    g.globalAlpha = a * 0.3
                    __L1:Bg(
                        v.x + math.sin(t * 0.7 + v.f) * 10,
                        v.y + math.cos(t * 0.5 + v.f) * 6,
                        3,
                        "#c8ff60"
                    )
                end
            end
            g.globalAlpha = 1
            g.globalCompositeOperation = "source-over"
        end
        for ____, p in __iterar((__L1.parts)) do
            if p.tipo == "estrela" then
                local k = 1 - p.t / p.vida
                g.globalAlpha = k
                __L1:Rg(
                    p.x,
                    p.y,
                    1,
                    1,
                    p.cor
                )
                if k > 0.5 then
                    __L1:Rg(
                        p.x - 1,
                        p.y,
                        3,
                        1,
                        p.cor
                    )
                    __L1:Rg(
                        p.x,
                        p.y - 1,
                        1,
                        3,
                        p.cor
                    )
                end
            end
        end
        g.globalAlpha = 1
    end
    __L1.tocar = function(self, x, y)
        __L1.dicaUsos = __L1.dicaUsos + 1
        if __L1.dicaUsos >= 3 then
            local ____callq_51 = __callq
            local ____opt_49 = __L1.dica
            if ____opt_49 ~= nil then
                ____opt_49 = ____opt_49.classList
            end
            ____callq_51(____opt_49, "add", "some")
        end
        local fz = __L1:fase()
        local t = __L1.tempo
        for ____, gal in __iterar((__L1.galinhas)) do
            local ____t_55 = __t
            local ____t_result_54
            local ____t_53 = __t
            local ____temp_52 = math.abs(gal.x - x) < 8 and __gt(y, gal.y - 14 - gal.z)
            __O[3212] = ____temp_52
            if ____t_53(____temp_52) then
                ____t_result_54 = __lt(y, gal.y + 3)
            else
                ____t_result_54 = __O[3212]
            end
            if ____t_55(____t_result_54) then
                gal.vz = -110
                gal.z = 0.1
                gal.susto = 1.6
                gal.alvo = __arrL(
                    {
                        __L1:clamp(
                            gal.x + (__gt(gal.x, x) and 1 or -1) * __L1:rnd(30, 60),
                            196,
                            318
                        ),
                        __L1:clamp(
                            gal.y + __L1:rnd(-14, 14),
                            204,
                            252
                        )
                    },
                    2
                )
                do
                    local i = 0
                    while i < 6 do
                        __L1:P({
                            x = gal.x,
                            y = gal.y - 8,
                            vx = __L1:rnd(-30, 30),
                            vy = __L1:rnd(-50, -20),
                            gr = 40,
                            vida = __L1:rnd(0.8, 1.4),
                            cor = __t(gal.br) and "#ffffff" or "#c8844a",
                            tipo = "pena"
                        })
                        i = i + 1
                    end
                end
                __L1:som("galinha")
                return
            end
        end
        local ____t_59 = __t
        local ____t_result_58
        local ____t_57 = __t
        local ____temp_56 = math.abs(__L1.roca.x - x) < 8 and __gt(y, __L1.roca.y - 30)
        __O[3213] = ____temp_56
        if ____t_57(____temp_56) then
            ____t_result_58 = __lt(y, __L1.roca.y + 2)
        else
            ____t_result_58 = __O[3213]
        end
        if ____t_59(____t_result_58) then
            __L1.roca.aceno = 1.6
            __L1.roca.vChapeu = 70
            __L1:P({
                x = __L1.roca.x + 6,
                y = __L1.roca.y - 32,
                vy = -14,
                vida = 1.2,
                tipo = "coracao"
            })
            __L1:som("oi")
            return
        end
        local ____t_63 = __t
        local ____t_result_62
        local ____t_61 = __t
        local ____temp_60 = math.abs(__L1.sapo.x - x) < 9 and math.abs(__L1.sapo.y - 3 - y) < 8
        __O[3214] = ____temp_60
        if ____t_61(____temp_60) then
            ____t_result_62 = __L1.sapo.z == 0
        else
            ____t_result_62 = __O[3214]
        end
        if ____t_63(____t_result_62) then
            __L1.sapo.vz = -120
            __L1.sapo.z = 0.1
            __L1.sapo.papo = 1
            __L1:som("sapo")
            return
        end
        for ____, p in __iterar((__L1.plantas)) do
            local ____t_69 = __t
            local ____t_result_68
            local ____t_67 = __t
            local ____t_result_66
            local ____t_65 = __t
            local ____temp_64 = not __t(p.fim) and math.abs(p.x - x) < 5
            __O[3215] = ____temp_64
            if ____t_65(____temp_64) then
                ____t_result_66 = __lt(y, p.y + 2)
            else
                ____t_result_66 = __O[3215]
            end
            __O[3216] = ____t_result_66
            if ____t_67(____t_result_66) then
                ____t_result_68 = __gt(y, p.y - 24)
            else
                ____t_result_68 = __O[3216]
            end
            if ____t_69(____t_result_68) then
                __L1:brilho(p.x, p.y - 12, 6)
                if __L1.tempo - p.t0 > 1.2 then
                    p.fim = __L1.tempo
                end
                __L1:som("pop")
                return
            end
        end
        local sx = __L1.BALANCO.x + math.sin(__L1.balanco) * __L1.BALANCO.L
        local sy = __L1.BALANCO.y + math.cos(__L1.balanco) * __L1.BALANCO.L
        if __t(math.abs(x - sx) < 10 and math.abs(y - sy) < 8) then
            __L1.balancoV = __L1.balancoV + (__L1.balancoV >= 0 and 1 or -1) * 3.2
            __L1:som("vento")
            return
        end
        local sol = __L1:posSol(fz.p)
        local lua = __L1:posLua(fz.p)
        local ____t_result_70
        if __t(sol) then
            ____t_result_70 = sol
        else
            ____t_result_70 = lua
        end
        local astro = ____t_result_70
        local ____t_72 = __t
        local ____t_result_71
        if __t(astro) then
            ____t_result_71 = __hypot(x - astro.x, y - astro.y) < 18
        else
            ____t_result_71 = astro
        end
        if ____t_72(____t_result_71) then
            local p = fz.p
            local alvos = __arrL({0.45, 0.74, 0.9, 1.27}, 4)
            local ____call_result_73 = __call(
                alvos,
                "find",
                function(____, a) return a > p + 0.02 end
            )
            if ____call_result_73 == nil then
                ____call_result_73 = 1.45
            end
            local alvo = ____call_result_73
            __L1.horaAlvo = alvo
            __L1.hora = p
            __L1:brilho(astro.x, astro.y, 12)
            __L1:som("dia")
            return
        end
        for ____, n in __iterar((__L1.nuvens)) do
            if __t(math.abs(x - n.x) < n.w + 4 and math.abs(y - n.y) < 9) then
                __call(__L1.chuvas, "push", {x = n.x, y = n.y, w = n.w * 0.8, t = 0})
                __L1:som("chuva")
                return
            end
        end
        local ____L1_MOINHO_74 = __L1.MOINHO
        local mx = ____L1_MOINHO_74.hx
        local my = ____L1_MOINHO_74.hy
        local ____t_83 = __t
        local ____t_result_82
        local ____t_76 = __t
        local ____temp_75 = __hypot(x - mx, y - my) < 38
        __O[3219] = ____temp_75
        if ____t_76(____temp_75) then
            ____t_result_82 = __O[3219]
        else
            local ____t_result_81
            local ____t_80 = __t
            local ____t_result_79
            local ____t_78 = __t
            local ____temp_77 = __gt(x, __L1.MOINHO.x0) and __lt(x, __L1.MOINHO.x1)
            __O[3217] = ____temp_77
            if ____t_78(____temp_77) then
                ____t_result_79 = __gt(y, 98)
            else
                ____t_result_79 = __O[3217]
            end
            __O[3218] = ____t_result_79
            if ____t_80(____t_result_79) then
                ____t_result_81 = __lt(y, 192)
            else
                ____t_result_81 = __O[3218]
            end
            ____t_result_82 = ____t_result_81
        end
        if ____t_83(____t_result_82) then
            __L1.pasVel = 7
            __L1:folhas(
                mx,
                my,
                6,
                __arrL({"#f2e8d0", "#e8dcc4", "#c8b898"}, 3)
            )
            __L1:som("vento")
            return
        end
        local ____t_89 = __t
        local ____t_result_88
        local ____t_87 = __t
        local ____t_result_86
        local ____t_85 = __t
        local ____temp_84 = __gt(x, __L1.CASA.x0) and __lt(x, __L1.CASA.x1)
        __O[3220] = ____temp_84
        if ____t_85(____temp_84) then
            ____t_result_86 = __gt(y, __L1.CASA.y0)
        else
            ____t_result_86 = __O[3220]
        end
        __O[3221] = ____t_result_86
        if ____t_87(____t_result_86) then
            ____t_result_88 = __lt(y, __L1.CASA.y1)
        else
            ____t_result_88 = __O[3221]
        end
        if ____t_89(____t_result_88) then
            __L1.fumacaExtra = 1.4
            __L1.luzCasa = 3
            __L1:brilho(
                108,
                106,
                6,
                __arrL({"#ffffff", "#f2f2ee"}, 2)
            )
            __L1:som("pop")
            return
        end
        local ____t_95 = __t
        local ____t_result_94
        local ____t_93 = __t
        local ____t_result_92
        local ____t_91 = __t
        local ____temp_90 = __gt(x, __L1.CELEIRO.x0) and __lt(x, __L1.CELEIRO.x1)
        __O[3222] = ____temp_90
        if ____t_91(____temp_90) then
            ____t_result_92 = __gt(y, __L1.CELEIRO.y0)
        else
            ____t_result_92 = __O[3222]
        end
        __O[3223] = ____t_result_92
        if ____t_93(____t_result_92) then
            ____t_result_94 = __lt(y, __L1.CELEIRO.y1)
        else
            ____t_result_94 = __O[3223]
        end
        if ____t_95(____t_result_94) then
            do
                local i = 0
                while i < 10 do
                    __L1:P({
                        x = 316 + __L1:rnd(-10, 10),
                        y = 150,
                        vx = __L1:rnd(-30, 30),
                        vy = __L1:rnd(-50, -20),
                        gr = 50,
                        vida = __L1:rnd(0.8, 1.4),
                        cor = __t(__mod(i, 2)) and "#e8c860" or "#f8e080",
                        tipo = "pena"
                    })
                    i = i + 1
                end
            end
            __L1:som("pop")
            return
        end
        for ____, ____value in __iterar((__L1.CACAUS)) do
            local cxx = ____value[1]
            local cyy = ____value[2]
            local ____t_99 = __t
            local ____t_result_98
            local ____t_97 = __t
            local ____temp_96 = math.abs(x - cxx) < 10 and __gt(y, cyy - 28)
            __O[3224] = ____temp_96
            if ____t_97(____temp_96) then
                ____t_result_98 = __lt(y, cyy)
            else
                ____t_result_98 = __O[3224]
            end
            if ____t_99(____t_result_98) then
                __L1:P({
                    x = cxx + __L1:rnd(-3, 3),
                    y = cyy - 8,
                    vx = __L1:rnd(-20, 20),
                    vy = -30,
                    gr = 260,
                    vida = 1.2,
                    cor = math.random() < 0.5 and "#e8882a" or "#f0c030",
                    tipo = "pod"
                })
                __L1:folhas(cxx, cyy - 18, 4)
                __L1:som("pop")
                return
            end
        end
        local ____t_108 = __t
        local ____t_result_107
        local ____t_101 = __t
        local ____temp_100 = __hypot(x - __L1.ARVORE.cx, y - __L1.ARVORE.cy) < 34
        __O[3227] = ____temp_100
        if ____t_101(____temp_100) then
            ____t_result_107 = __O[3227]
        else
            local ____t_result_106
            local ____t_105 = __t
            local ____t_result_104
            local ____t_103 = __t
            local ____temp_102 = __gt(x, 2) and __lt(x, 40)
            __O[3225] = ____temp_102
            if ____t_103(____temp_102) then
                ____t_result_104 = __gt(y, 86)
            else
                ____t_result_104 = __O[3225]
            end
            __O[3226] = ____t_result_104
            if ____t_105(____t_result_104) then
                ____t_result_106 = __lt(y, 140)
            else
                ____t_result_106 = __O[3226]
            end
            ____t_result_107 = ____t_result_106
        end
        if ____t_108(____t_result_107) then
            __L1:folhas(x, y, 9)
            __L1.balancoV = __L1.balancoV + 1
            __L1:som("vento")
            return
        end
        if __t(__L1:noRio(x, y)) then
            __L1.peixe = {x = x - 14, y0 = y, t = 0}
            __call(__L1.aneis, "push", {x = x, y = y, r = 1, t = 0})
            do
                local i = 0
                while i < 8 do
                    __L1:P({
                        x = x,
                        y = y,
                        vx = __L1:rnd(-30, 30),
                        vy = __L1:rnd(-70, -30),
                        gr = 200,
                        vida = 0.6,
                        cor = "#cfeaff",
                        tipo = "gota",
                        chao = y + 2
                    })
                    i = i + 1
                end
            end
            __L1:som("agua")
            return
        end
        if __lt(y, __L1.HZ - 4) then
            if __gt(fz.noite, 0.5) then
                __call(__L1.cadentes, "push", {
                    x = x,
                    y = y,
                    vx = -120,
                    vy = 55,
                    t = 0
                })
                __L1:brilho(x, y, 6)
                __L1:som("estrela")
            else
                __call(
                    __L1.aves,
                    "push",
                    {
                        x = x - 60,
                        y = y,
                        v = 46,
                        n = 5,
                        f = __L1:rnd(0, 6)
                    }
                )
                __L1:brilho(x, y, 4)
                __L1:som("pop")
            end
            return
        end
        if __t(__L1:naTrilha(x, y)) then
            do
                local i = 0
                while i < 6 do
                    __L1:P({
                        x = x,
                        y = y,
                        vx = __L1:rnd(-20, 20),
                        vy = __L1:rnd(-20, -6),
                        gr = 60,
                        vida = 0.5,
                        cor = "#e2c690",
                        tipo = "pena"
                    })
                    i = i + 1
                end
            end
            return
        end
        if __gt(y, __L1.HZ + 24) then
            if __len(__call(
                __L1.plantas,
                "filter",
                function(____, p) return not __t(p.fim) end
            )) >= 24 then
                local velha = __call(
                    __L1.plantas,
                    "find",
                    function(____, p) return not __t(p.fim) end
                )
                if __t(velha) then
                    velha.fim = __L1.tempo
                end
            end
            __call(
                __L1.plantas,
                "push",
                {
                    x = x,
                    y = y,
                    tipo = __get(
                        __L1.TIPOS,
                        __bor(
                            math.random() * __len(__L1.TIPOS),
                            0
                        )
                    ),
                    t0 = __L1.tempo
                }
            )
            __L1:brilho(
                x,
                y - 2,
                5,
                __arrL({"#e8d8a0", "#8ad05a", "#ffffff"}, 3)
            )
            __L1:som("planta")
        end
    end
    __L1.letra = function(self, ch, s, E)
        local gl = __get(__L1.GL, ch)
        local gw = 10 * s
        local gh = __len(gl) * s
        local alt12 = 12 * s
        local pad = E.borda
        local W = gw + pad * 2
        local H = gh + pad * 2 + E.ext
        local m = __new("Uint8Array", W * H)
        local function at(____, x, y)
            local ____t_result_115
            local ____t_114 = __t
            local ____t_result_113
            local ____t_112 = __t
            local ____t_result_111
            local ____t_110 = __t
            local ____temp_109 = __ge(x, 0) and __ge(y, 0)
            __O[3228] = ____temp_109
            if ____t_110(____temp_109) then
                ____t_result_111 = __lt(x, W)
            else
                ____t_result_111 = __O[3228]
            end
            __O[3229] = ____t_result_111
            if ____t_112(____t_result_111) then
                ____t_result_113 = __lt(y, H)
            else
                ____t_result_113 = __O[3229]
            end
            if ____t_114(____t_result_113) then
                ____t_result_115 = __get(m, y * W + x)
            else
                ____t_result_115 = 0
            end
            return ____t_result_115
        end
        __call(
            gl,
            "forEach",
            function(____, row, y) return __call(
                __arr(__TS__Spread(__iter(row))),
                "forEach",
                function(____, v, x)
                    if v == "#" then
                        do
                            local a = 0
                            while __lt(a, s) do
                                do
                                    local b = 0
                                    while __lt(b, s) do
                                        __set(m, (pad + y * s + a) * W + pad + x * s + b, 1)
                                        b = b + 1
                                    end
                                end
                                a = a + 1
                            end
                        end
                    end
                end
            ) end
        )
        local ext = __new("Uint8Array", W * H)
        do
            local y = 0
            while __lt(y, H) do
                do
                    local x = 0
                    while x < W do
                        if not __t(__get(m, y * W + x)) then
                            do
                                local k = 1
                                while __le(k, E.ext) do
                                    if at(nil, x, y - k) == 1 then
                                        __set(ext, y * W + x, k)
                                        break
                                    end
                                    k = k + 1
                                end
                            end
                        end
                        x = x + 1
                    end
                end
                y = y + 1
            end
        end
        local cv, c = table.unpack(
            __L1:mk(W, H),
            1,
            2
        )
        local Rr = __L1:pinta(c)
        do
            local y = 0
            while __lt(y, H) do
                do
                    local x = 0
                    while x < W do
                        do
                            local ____t_119 = __t
                            local ____t_result_118
                            local ____t_117 = __t
                            local ____get_result_116 = __get(m, y * W + x)
                            __O[3230] = ____get_result_116
                            if ____t_117(____get_result_116) then
                                ____t_result_118 = __O[3230]
                            else
                                ____t_result_118 = __get(ext, y * W + x)
                            end
                            if ____t_119(____t_result_118) then
                                do x = x + 1 continue end
                            end
                            local perto = false
                            do
                                local dy = __TS__Number(-pad)
                                while __t(__le(dy, pad) and not __t(perto)) do
                                    do
                                        local dx = __TS__Number(-pad)
                                        while __le(dx, pad) do
                                            do
                                                if __gt(
                                                    math.abs(dx) + math.abs(dy),
                                                    pad + (__gt(pad, 1) and 1 or 0)
                                                ) then
                                                    do dx = dx + 1 continue end
                                                end
                                                local xx = x + dx
                                                local yy = y + dy
                                                local ____t_130 = __t
                                                local ____t_result_129
                                                local ____t_125 = __t
                                                local ____t_result_124
                                                local ____t_123 = __t
                                                local ____t_result_122
                                                local ____t_121 = __t
                                                local ____temp_120 = xx >= 0 and yy >= 0
                                                __O[3231] = ____temp_120
                                                if ____t_121(____temp_120) then
                                                    ____t_result_122 = xx < W
                                                else
                                                    ____t_result_122 = __O[3231]
                                                end
                                                __O[3232] = ____t_result_122
                                                if ____t_123(____t_result_122) then
                                                    ____t_result_124 = __lt(yy, H)
                                                else
                                                    ____t_result_124 = __O[3232]
                                                end
                                                __O[3234] = ____t_result_124
                                                if ____t_125(____t_result_124) then
                                                    local ____t_result_128
                                                    local ____t_127 = __t
                                                    local ____get_result_126 = __get(m, yy * W + xx)
                                                    __O[3233] = ____get_result_126
                                                    if ____t_127(____get_result_126) then
                                                        ____t_result_128 = __O[3233]
                                                    else
                                                        ____t_result_128 = __get(ext, yy * W + xx)
                                                    end
                                                    ____t_result_129 = ____t_result_128
                                                else
                                                    ____t_result_129 = __O[3234]
                                                end
                                                if ____t_130(____t_result_129) then
                                                    perto = true
                                                    break
                                                end
                                            end
                                            dx = dx + 1
                                        end
                                    end
                                    dy = dy + 1
                                end
                            end
                            if __t(perto) then
                                Rr(
                                    nil,
                                    x,
                                    y,
                                    1,
                                    1,
                                    E.contorno
                                )
                            end
                        end
                        x = x + 1
                    end
                end
                y = y + 1
            end
        end
        do
            local y = 0
            while __lt(y, H) do
                do
                    local x = 0
                    while x < W do
                        local k = __get(ext, y * W + x)
                        if __t(k) then
                            local ____x_132 = x
                            local ____y_133 = y
                            local ____ge_result_131
                            if __ge(k, E.ext) then
                                ____ge_result_131 = E.extFundo
                            else
                                ____ge_result_131 = E.extCor
                            end
                            Rr(
                                nil,
                                ____x_132,
                                ____y_133,
                                1,
                                1,
                                ____ge_result_131
                            )
                        end
                        x = x + 1
                    end
                end
                y = y + 1
            end
        end
        do
            local y = 0
            while __lt(y, H) do
                do
                    local x = 0
                    while x < W do
                        do
                            if not __t(__get(m, y * W + x)) then
                                do x = x + 1 continue end
                            end
                            local ry = __L1:clamp((y - pad) / alt12, 0, 1)
                            local i = 0
                            while __t(i < __len(E.grad) - 1 and __gt(
                                ry,
                                __get(
                                    __get(E.grad, i + 1),
                                    0
                                )
                            )) do
                                i = i + 1
                            end
                            local a0, c0 = table.unpack(
                                __get(E.grad, i),
                                1,
                                2
                            )
                            local a1, c1 = table.unpack(
                                __get(
                                    E.grad,
                                    math.min(
                                        i + 1,
                                        __len(E.grad) - 1
                                    )
                                ),
                                1,
                                2
                            )
                            local ____gt_result_134
                            if __gt(a1, a0) then
                                ____gt_result_134 = (ry - a0) / (a1 - a0)
                            else
                                ____gt_result_134 = 0
                            end
                            local kk = ____gt_result_134
                            local ____temp_135
                            if kk > 0.5 ~= (__mod(x + y, 2) == 0 and math.abs(kk - 0.5) < 0.2) then
                                ____temp_135 = c1
                            else
                                ____temp_135 = c0
                            end
                            local col = ____temp_135
                            if not __t(at(nil, x, y - 1)) then
                                col = E.luz
                            elseif not __t(at(nil, x, y + 1)) then
                                col = E.fundo
                            elseif not __t(at(nil, x - 1, y)) then
                                col = __L1:mixc(col, "#ffffff", 0.25)
                            else
                                local ____t_137 = __t
                                local ____t_result_136
                                if __t(E.textura) then
                                    ____t_result_136 = __L1:hash(x * 7.1 + y * 3.3) > 0.92
                                else
                                    ____t_result_136 = E.textura
                                end
                                if ____t_137(____t_result_136) then
                                    col = __L1:mixc(col, "#ffffff", 0.3)
                                end
                            end
                            Rr(
                                nil,
                                x,
                                y,
                                1,
                                1,
                                col
                            )
                        end
                        x = x + 1
                    end
                end
                y = y + 1
            end
        end
        return {cv = cv, w = W, h = H, pad = pad}
    end
    __L1.montarLetras = function(self, max)
        local feitas = 0
        while __t(__len(__L1.BIG) < __len(__L1.TEXTO_G) and __lt(feitas, max)) do
            local ch = __get(
                __L1.TEXTO_G,
                __len(__L1.BIG)
            )
            local ____call_140 = __call
            local ____L1_BIG_139 = __L1.BIG
            local ____temp_138
            if ch == " " then
                ____temp_138 = nil
            else
                ____temp_138 = __L1:letra(ch, 3, __L1.ESTILO_G)
            end
            ____call_140(____L1_BIG_139, "push", ____temp_138)
            feitas = feitas + 1
        end
        while __t(__len(__L1.SMALL) < __len(__L1.TEXTO_P) and __lt(feitas, max)) do
            __call(
                __L1.SMALL,
                "push",
                __L1:letra(
                    __get(
                        __L1.TEXTO_P,
                        __len(__L1.SMALL)
                    ),
                    1,
                    __L1.ESTILO_P
                )
            )
            feitas = feitas + 1
        end
        return __len(__L1.BIG) == __len(__L1.TEXTO_G) and __len(__L1.SMALL) == __len(__L1.TEXTO_P)
    end
    __L1.montarPlaca = function(self)
        local R = __L1:pinta(pc)
        pc:clearRect(0, 0, __L1.LOGW, __L1.LOGH)
        local x0 = 22
        local x1 = 318
        local y0 = 24
        local y1 = 100
        local cores = __arrL({"#b47442", "#a46838", "#ba7c48"}, 3)
        R(
            nil,
            x0 + 3,
            y1 + 1,
            x1 - x0,
            4,
            "rgba(40,20,8,.35)"
        )
        R(
            nil,
            x0,
            y0 + 2,
            x1 - x0,
            y1 - y0 - 4,
            "#2a1408"
        )
        R(
            nil,
            x0 + 2,
            y0,
            x1 - x0 - 4,
            y1 - y0,
            "#2a1408"
        )
        R(
            nil,
            x0 + 1,
            y0 + 1,
            x1 - x0 - 2,
            y1 - y0 - 2,
            "#2a1408"
        )
        do
            local p = 0
            while p < 3 do
                local py = y0 + 2 + p * 25
                local ph = 24
                local base = __get(cores, p)
                R(
                    nil,
                    x0 + 2,
                    py,
                    x1 - x0 - 4,
                    ph,
                    base
                )
                R(
                    nil,
                    x0 + 2,
                    py,
                    x1 - x0 - 4,
                    2,
                    __L1:mixc(base, "#ffe0a8", 0.45)
                )
                R(
                    nil,
                    x0 + 2,
                    py + ph - 2,
                    x1 - x0 - 4,
                    2,
                    __L1:mixc(base, "#3a1a08", 0.35)
                )
                do
                    local gy = 4
                    while gy < ph - 3 do
                        do
                            local x = x0 + 3
                            while x < x1 - 3 do
                                local v = math.sin(x * 0.05 + gy * 1.7 + p * 3) * 1.2
                                if __L1:hash(x * 0.37 + gy * 11 + p * 101) > 0.55 then
                                    R(
                                        nil,
                                        x,
                                        py + gy + math.floor(v + 0.5),
                                        1,
                                        1,
                                        __L1:mixc(base, "#5a2c10", 0.22)
                                    )
                                end
                                x = x + 1
                            end
                        end
                        gy = gy + 3
                    end
                end
                do
                    local k = 0
                    while k < 2 do
                        local kx = x0 + 40 + __L1:hash(p * 7 + k) * (x1 - x0 - 80)
                        local ky = py + 8 + __L1:hash(p * 3 + k) * 8
                        pc.strokeStyle = __L1:mixc(base, "#4a2008", 0.4)
                        pc.lineWidth = 1
                        pc:beginPath()
                        pc:ellipse(
                            kx,
                            ky,
                            5,
                            2.5,
                            0,
                            0,
                            math.pi * 2
                        )
                        pc:stroke()
                        R(
                            nil,
                            kx - 1,
                            ky,
                            3,
                            1,
                            __L1:mixc(base, "#4a2008", 0.5)
                        )
                        k = k + 1
                    end
                end
                if p < 2 then
                    R(
                        nil,
                        x0 + 2,
                        py + ph,
                        x1 - x0 - 4,
                        1,
                        "#3a1a08"
                    )
                end
                for ____, nx in __iterar((__arrL({x0 + 7, x1 - 10}, 2))) do
                    R(
                        nil,
                        nx,
                        py + 10,
                        3,
                        3,
                        "#5a5450"
                    )
                    R(
                        nil,
                        nx,
                        py + 10,
                        2,
                        2,
                        "#d8d0c8"
                    )
                    R(
                        nil,
                        nx,
                        py + 10,
                        1,
                        1,
                        "#ffffff"
                    )
                end
                p = p + 1
            end
        end
        pc.font = "8px Pixel, monospace"
        local tx = "UMA AVENTURA CULTIVADA EM ITABUNA"
        local tw = math.ceil(pc:measureText(tx).width)
        local bx = math.floor((__L1.LOGW - tw) / 2 + 0.5) - 8
        for ____, cx in __iterar((__arrL({bx + 18, bx + tw - 2}, 2))) do
            R(
                nil,
                cx,
                13,
                1,
                11,
                "#5a5450"
            )
            R(
                nil,
                cx + 1,
                15,
                1,
                2,
                "#8a8480"
            )
            R(
                nil,
                cx + 1,
                19,
                1,
                2,
                "#8a8480"
            )
        end
        R(
            nil,
            bx - 1,
            1,
            tw + 18,
            14,
            "#2a1408"
        )
        R(
            nil,
            bx,
            2,
            tw + 16,
            12,
            "#f6e6bc"
        )
        R(
            nil,
            bx,
            2,
            tw + 16,
            1,
            "#fffaf0"
        )
        R(
            nil,
            bx,
            12,
            tw + 16,
            2,
            "#d8c08a"
        )
        pc.fillStyle = "#5a3418"
        pc.textBaseline = "top"
        pc:fillText(tx, bx + 8, 4)
        local d = pc:getImageData(bx, 2, tw + 16, 12)
        do
            local i = 3
            while __lt(
                i,
                __len(d.data)
            ) do
                if __t(__gt(
                    __get(d.data, i),
                    0
                ) and __lt(
                    __get(d.data, i),
                    255
                )) then
                    if __gt(
                        __get(d.data, i),
                        110
                    ) then
                        __set(d.data, i, 255)
                    end
                end
                i = i + 4
            end
        end
        pc:putImageData(d, bx, 2)
    end
    __L1.desenharLogo = function(self, t)
        if not __t(__L1:montarLetras(3)) then
            return
        end
        if __L1.logo0 == nil then
            __L1.logo0 = t
        end
        local e = __t(__L1.reduzido) and 9 or t - __L1.logo0
        __L1.onda = math.max(0, __L1.onda - 1 / 60 * 1.2)
        lc:clearRect(0, 0, __L1.LOGW, __L1.LOGH)
        local placaY = math.floor((1 - __L1:easeBack(__L1:clamp(e / 0.45, 0, 1))) * -140 + 0.5)
        local ____temp_141
        if e > 2 then
            ____temp_141 = math.floor(math.sin(t * 1.4) * 1 + 0.5)
        else
            ____temp_141 = 0
        end
        local flut = ____temp_141
        local deco = __L1:clamp((e - 1.1) / 0.3, 0, 1)
        if deco > 0 then
            lc.globalAlpha = deco
            local function espiga(____, x, y, inc)
                do
                    local r = 0
                    while r < 22 do
                        local cx2 = math.floor(x + r * inc + 0.5)
                        local ____temp_143
                        if r < 3 then
                            ____temp_143 = r + 1
                        else
                            local ____temp_142
                            if r > 18 then
                                ____temp_142 = 22 - r
                            else
                                ____temp_142 = 4
                            end
                            ____temp_143 = ____temp_142
                        end
                        local w = ____temp_143
                        __L1:L(
                            cx2 - w - 1,
                            y + r,
                            w * 2 + 3,
                            1,
                            "#2a1408"
                        )
                        do
                            local k = -w
                            while k <= w do
                                __L1:L(
                                    cx2 + k,
                                    y + r,
                                    1,
                                    1,
                                    __t(__mod(k + r, 2)) and "#f8d040" or (k < -w + 2 and "#c88a18" or "#e8b020")
                                )
                                k = k + 1
                            end
                        end
                        __L1:L(
                            cx2 - w + 1,
                            y + r,
                            1,
                            1,
                            "#fff0a0"
                        )
                        r = r + 1
                    end
                end
                do
                    local k = 0
                    while k < 16 do
                        local cx2 = math.floor(x + (16 + k) * inc + 0.5)
                        __L1:L(
                            cx2 - 6 - math.floor(k * 0.5 + 0.5),
                            y + 15 + k,
                            4,
                            1,
                            __t(__mod(k, 3)) and "#5aa83a" or "#3f8a2a"
                        )
                        __L1:L(
                            cx2 + 3 + math.floor(k * 0.5 + 0.5),
                            y + 15 + k,
                            4,
                            1,
                            __t(__mod(k, 3)) and "#4f9a32" or "#3f8a2a"
                        )
                        __L1:L(
                            cx2 - 1,
                            y + 18 + k,
                            3,
                            1,
                            "#6abf4a"
                        )
                        k = k + 1
                    end
                end
                __L1:L(
                    math.floor(x + 0.5) - 1,
                    y - 3,
                    1,
                    3,
                    "#e8d878"
                )
                __L1:L(
                    math.floor(x + 0.5) + 1,
                    y - 4,
                    1,
                    4,
                    "#d8c060"
                )
            end
            espiga(nil, 9, 40 + placaY + flut, -0.2)
            espiga(nil, 19, 47 + placaY + flut, 0.15)
            local sw = math.floor(math.sin(t * 1.2) * 1.5 + 0.5)
            do
                local k = 0
                while k < 70 do
                    __L1:L(
                        326 + math.floor(math.sin(k * 0.05) * 1 + 0.5),
                        112 - k + placaY + flut,
                        2,
                        1,
                        "#3f8a2a"
                    )
                    k = k + 1
                end
            end
            __L1:L(
                318,
                82 + placaY + flut,
                8,
                3,
                "#4f9a32"
            )
            __L1:L(
                328,
                70 + placaY + flut,
                8,
                3,
                "#4f9a32"
            )
            local hx2 = 327 + sw
            local hy = 38 + placaY + flut
            do
                local k = 0
                while k < 12 do
                    local a = k * 0.5236 + t * 0.2
                    __L1:LB(
                        hx2 + math.cos(a) * 9,
                        hy + math.sin(a) * 9,
                        3,
                        __t(__mod(k, 2)) and "#f8c820" or "#ffd84a",
                        3
                    )
                    k = k + 1
                end
            end
            __L1:LB(hx2, hy, 7, "#2a1408")
            __L1:LB(hx2, hy, 6, "#7a4a1c")
            do
                local k = 0
                while k < 10 do
                    __L1:L(
                        hx2 - 4 + __L1:hash(k) * 8,
                        hy - 4 + __L1:hash(k * 3) * 8,
                        1,
                        1,
                        "#a86a2a"
                    )
                    k = k + 1
                end
            end
            lc.globalAlpha = 1
        end
        lc:drawImage(placaCv, 0, placaY + flut)
        if e > 0.5 then
            do
                local x = 24
                while x < 316 do
                    local y = 24 + math.floor(math.sin(x * 0.12) * 1.6 + 0.5) + placaY + flut
                    __L1:L(
                        x,
                        y,
                        2,
                        2,
                        "#3f7a2a"
                    )
                    if __mod(x, 12) == 0 then
                        local sw = math.floor(math.sin(t * 2 + x) * 1 + 0.5)
                        __L1:L(
                            x - 2 + sw,
                            y - 3,
                            3,
                            2,
                            "#5aa83a"
                        )
                        __L1:L(
                            x - 1 + sw,
                            y - 3,
                            1,
                            1,
                            "#8ad05a"
                        )
                    end
                    if __mod(x, 12) == 6 then
                        __L1:L(
                            x + 1,
                            y + 2,
                            3,
                            2,
                            "#4f9a32"
                        )
                    end
                    if __mod(x, 36) == 18 then
                        local fc = __get(
                            __arrL({"#f07aa8", "#f8d84a", "#ffffff"}, 3),
                            __mod(
                                __bor(x / 36, 0),
                                3
                            )
                        )
                        __L1:L(
                            x - 1,
                            y - 4,
                            3,
                            1,
                            fc
                        )
                        __L1:L(
                            x,
                            y - 5,
                            1,
                            3,
                            fc
                        )
                        __L1:L(
                            x,
                            y - 4,
                            1,
                            1,
                            "#f8a020"
                        )
                    end
                    x = x + 2
                end
            end
        end
        if deco > 0 then
            lc.globalAlpha = deco
            __L1:L(
                56,
                100 + placaY + flut,
                1,
                6,
                "#5a3a22"
            )
            __L1:L(
                54,
                105 + placaY + flut,
                5,
                8,
                "#2a1408"
            )
            __L1:L(
                55,
                106 + placaY + flut,
                3,
                6,
                "#e8882a"
            )
            __L1:L(
                55,
                106 + placaY + flut,
                1,
                2,
                "#f8b860"
            )
            __L1:L(
                60,
                102 + placaY + flut,
                4,
                7,
                "#2a1408"
            )
            __L1:L(
                61,
                103 + placaY + flut,
                2,
                5,
                "#f0c030"
            )
            lc.globalAlpha = 1
        end
        lt:clearRect(0, 0, __L1.LOGW, __L1.LOGH)
        local total = 0
        for ____, b in __iterar((__L1.BIG)) do
            local ____t_result_144
            if __t(b) then
                ____t_result_144 = b.w - 2
            else
                ____t_result_144 = 12
            end
            total = total + ____t_result_144
        end
        local x = math.floor((__L1.LOGW - total) / 2 + 0.5)
        local i = 0
        for ____, b in __iterar((__L1.BIG)) do
            do
                if not __t(b) then
                    x = x + 12
                    continue
                end
                local t0 = 0.35 + i * 0.08
                local u = __L1:clamp((e - t0) / 0.55, 0, 1)
                if u > 0 then
                    local queda = math.floor((1 - __L1:easeBounce(u)) * -90 + 0.5)
                    local ____temp_145
                    if e > 2 then
                        ____temp_145 = math.floor(math.sin(t * 2.2 + i * 0.7) * 0.8 + math.sin(t * 9 - i * 0.9) * __L1.onda * 6 + 0.5)
                    else
                        ____temp_145 = 0
                    end
                    local bob = ____temp_145
                    lt:drawImage(b.cv, x, 30 + queda + bob + placaY + flut)
                end
                x = x + (b.w - 2)
                i = i + 1
            end
        end
        local gp = __mod(t, 5) / 0.7
        if __t(e > 2 and gp < 1) then
            lt.globalCompositeOperation = "source-atop"
            lt.fillStyle = "rgba(255,255,240,.55)"
            local gx = 40 + gp * 280
            lt:beginPath()
            lt:moveTo(gx, 20)
            lt:lineTo(gx + 10, 20)
            lt:lineTo(gx - 20, 100)
            lt:lineTo(gx - 30, 100)
            __call(lt, "fill")
            lt.globalCompositeOperation = "source-over"
        end
        lc:drawImage(letrasCv, 0, 0)
        local fx = __L1:clamp((e - 1) / 0.35, 0, 1)
        if fx > 0 then
            local cx = __L1.LOGW / 2
            local cy = 116 + placaY + flut
            local hw = math.floor(80 * fx + 0.5)
            local fh = 22
            local top = cy - fh / 2
            if fx >= 1 then
                for ____, s in __iterar((__arrL({-1, 1}, 2))) do
                    do
                        local k = 0
                        while k < 28 do
                            local ____temp_146
                            if s > 0 then
                                ____temp_146 = cx + hw - 6 + k
                            else
                                ____temp_146 = cx - hw + 5 - k
                            end
                            local xx = ____temp_146
                            local y0 = top + 6
                            local h2 = fh - 2
                            local mid = y0 + h2 / 2
                            local v = math.max(0, k - 19)
                            do
                                local y = y0
                                while y < y0 + h2 do
                                    do
                                        if math.abs(y - mid) < v * 1.2 then
                                            do y = y + 1 continue end
                                        end
                                        local ____t_result_151
                                        local ____t_150 = __t
                                        local ____t_result_149
                                        local ____t_148 = __t
                                        local ____temp_147 = y == y0 or y == y0 + h2 - 1
                                        __O[3235] = ____temp_147
                                        if ____t_148(____temp_147) then
                                            ____t_result_149 = __O[3235]
                                        else
                                            ____t_result_149 = k == 27
                                        end
                                        __O[3236] = ____t_result_149
                                        if ____t_150(____t_result_149) then
                                            ____t_result_151 = __O[3236]
                                        else
                                            ____t_result_151 = math.abs(math.abs(y - mid) - v * 1.2) < 1
                                        end
                                        local borda = ____t_result_151
                                        __L1:L(
                                            xx,
                                            y,
                                            1,
                                            1,
                                            __t(borda) and "#1a3a12" or (y < y0 + 3 and "#4f9a3a" or "#2f6a2a")
                                        )
                                    end
                                    y = y + 1
                                end
                            end
                            k = k + 1
                        end
                    end
                    local ____L1_L_153 = __L1.L
                    local ____temp_152
                    if s > 0 then
                        ____temp_152 = cx + hw - 6
                    else
                        ____temp_152 = cx - hw + 3
                    end
                    ____L1_L_153(
                        __L1,
                        ____temp_152,
                        top + 6,
                        3,
                        fh - 2,
                        "#173010"
                    )
                end
            end
            __L1:L(
                cx - hw - 1,
                top,
                hw * 2 + 2,
                fh,
                "#1a3a12"
            )
            __L1:L(
                cx - hw,
                top + 1,
                hw * 2,
                fh - 2,
                "#3f8a3a"
            )
            __L1:L(
                cx - hw,
                top + 1,
                hw * 2,
                2,
                "#6abf5a"
            )
            __L1:L(
                cx - hw,
                top + fh - 4,
                hw * 2,
                3,
                "#2f6a2a"
            )
            do
                local k = -hw + 2
                while k < hw - 2 do
                    __L1:L(
                        cx + k,
                        top + 3,
                        2,
                        1,
                        "#5aaa4a"
                    )
                    k = k + 5
                end
            end
            if fx >= 1 then
                local tw3 = 0
                for ____, s2 in __iterar((__L1.SMALL)) do
                    tw3 = tw3 + s2.w
                end
                local sx2 = math.floor(cx - tw3 / 2 + 0.5)
                __call(
                    __L1.SMALL,
                    "forEach",
                    function(____, s2, j)
                        local ____temp_154
                        if e > 2 then
                            ____temp_154 = math.floor(math.sin(t * 9 - j * 0.8) * __L1.onda * 3 + 0.5)
                        else
                            ____temp_154 = 0
                        end
                        local bob = ____temp_154
                        lc:drawImage(s2.cv, sx2, cy - 8 + bob)
                        sx2 = sx2 + s2.w
                    end
                )
            end
        end
        if deco > 0 then
            local bica = __mod(
                math.floor(t * 0.7),
                4
            ) == 0 and __mod(t * 0.7, 1) < 0.5
            __L1:galinha(
                lc,
                70,
                23 + placaY + flut,
                1,
                bica,
                true
            )
            __L1:sapinho(
                lc,
                {
                    x = 256,
                    y = 128 + placaY + flut,
                    z = 0,
                    pisca = __mod(t, 3.3) < 0.15 and 1 or 0,
                    papo = math.max(
                        0,
                        math.sin(t * 1.1)
                    ) * 0.8
                },
                t
            )
            do
                local k = 0
                while k < 2 do
                    local bt = t * 0.8 + k * 3
                    local bx = 170 + math.sin(bt) * 150
                    local by = 14 + math.sin(bt * 1.7) * 10 + k * 120
                    local ab = math.sin(t * 14 + k) > 0
                    local cor = __t(k) and "#f07aa8" or "#f8d040"
                    __L1:L(
                        bx - (__t(ab) and 2 or 1),
                        by,
                        __t(ab) and 2 or 1,
                        2,
                        cor
                    )
                    __L1:L(
                        bx + 1,
                        by,
                        __t(ab) and 2 or 1,
                        2,
                        cor
                    )
                    __L1:L(
                        bx,
                        by,
                        1,
                        2,
                        "#2a1408"
                    )
                    k = k + 1
                end
            end
        end
        if e > 1.6 then
            do
                local k = 0
                while k < 7 do
                    do
                        local ph = __mod(
                            t * 0.6 + __L1:hash(k) * 7,
                            3
                        )
                        if ph > 1 then
                            do k = k + 1 continue end
                        end
                        local sx3 = 40 + __L1:hash(k * 5.3) * 260
                        local sy3 = 26 + __L1:hash(k * 2.7) * 70 + placaY
                        local a = math.sin(ph * math.pi)
                        lc.globalAlpha = a
                        __L1:L(
                            sx3,
                            sy3,
                            1,
                            1,
                            "#ffffff"
                        )
                        if a > 0.5 then
                            __L1:L(
                                sx3 - 2,
                                sy3,
                                5,
                                1,
                                "#fff6c0"
                            )
                            __L1:L(
                                sx3,
                                sy3 - 2,
                                1,
                                5,
                                "#fff6c0"
                            )
                        end
                    end
                    k = k + 1
                end
            end
        end
        lc.globalAlpha = 1
    end
    __L1.icone = function(self, fn)
        local cv, c = table.unpack(
            __L1:mk(16, 16),
            1,
            2
        )
        fn(
            nil,
            __L1:pinta(c),
            __L1:bola(c)
        )
        return cv:toDataURL()
    end
    __L1.enfeitar = function(self)
        local function por(____, b, k)
            local ____t_158 = __t
            local ____t_result_157
            local ____t_156 = __t
            local ____temp_155 = not __t(b)
            __O[3237] = ____temp_155
            if ____t_156(____temp_155) then
                ____t_result_157 = __O[3237]
            else
                ____t_result_157 = b:querySelector(".tr-ico")
            end
            if ____t_158(____t_result_157) then
                return
            end
            local i = window.document:createElement("i")
            i.className = "tr-ico"
            i:setAttribute("aria-hidden", "true")
            i.style.backgroundImage = ("url(" .. tostring(__get(__L1.ICONES, k))) .. ")"
            b:prepend(i)
            __call(b.classList, "add", "tr-tabua")
        end
        por(
            nil,
            window.document:getElementById("menuJogarBtn"),
            "jogar"
        )
        por(
            nil,
            window.document:getElementById("menuMultiBtn"),
            "multi"
        )
        por(
            nil,
            window.document:getElementById("adventureInfoBtn"),
            "diario"
        )
        por(
            nil,
            window.document:getElementById("continueBtn"),
            "continuar"
        )
        por(
            nil,
            window.document:getElementById("startBtn"),
            "nova"
        )
    end
    __L1.paraCena = function(self, e)
        local r = __L1.cvFundo:getBoundingClientRect()
        local esc = math.max(r.width / 960, r.height / 540)
        local ox = r.left + (r.width - 960 * esc) / 2
        local oy = r.top + (r.height - 540 * esc) / 2
        return __arrL({(e.clientX - ox) / esc / 2, (e.clientY - oy) / esc / 2}, 2)
    end
    __L1.desenhar = function(self, ctx, segundos, w, h)
        if w == nil then
            w = 960
        end
        if h == nil then
            h = 540
        end
        local ____t_result_159
        if __t(__L1.ultimo) then
            ____t_result_159 = __L1:clamp(segundos - __L1.ultimo, 0, 0.1)
        else
            ____t_result_159 = 1 / 30
        end
        local dt = ____t_result_159
        __L1.ultimo = segundos
        if not __t(__L1.reduzido) then
            __L1:atualizar(dt)
        else
            __L1.tempo = __L1.tempo + dt
        end
        __L1:desenharCena()
        ctx.imageSmoothingEnabled = false
        ctx:drawImage(
            cena,
            0,
            0,
            w,
            h
        )
        __L1:desenharLogo(segundos)
    end
    local ____ = "use strict"
    __L1.tela = window.document:getElementById("startScreen")
    __L1.cvFundo = window.document:getElementById("titleCanvas")
    local ____t_163 = __t
    local ____t_result_162
    local ____t_161 = __t
    local ____temp_160 = not __t(__L1.tela) or not __t(__L1.cvFundo)
    __O[3203] = ____temp_160
    if ____t_161(____temp_160) then
        ____t_result_162 = __O[3203]
    else
        ____t_result_162 = window.TelaInicial
    end
    if ____t_163(____t_result_162) then
        return
    end
    __call(__L1.tela.classList, "add", "tela-roca")
    __L1.hash = function(____, n)
        local s = math.sin(n * 127.1 + 311.7) * 43758.5453
        return s - math.floor(s)
    end
    __L1.mk = function(____, w, h)
        local c = window.document:createElement("canvas")
        c.width = w
        c.height = h
        local x = c:getContext("2d")
        x.imageSmoothingEnabled = false
        return __arrL({c, x}, 2)
    end
    __L1.lerp = function(____, a, b, k) return a + (b - a) * k end
    __L1.clamp = function(____, v, a, b) return math.max(
        a,
        math.min(b, v)
    ) end
    __L1.rnd = function(____, a, b) return a + math.random() * (b - a) end
    __L1.hx = function(____, h)
        local n = __TS__ParseInt(
            __call(h, "slice", 1),
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
    __L1.mixc = function(____, a, b, k)
        local A = __L1:hx(a)
        local B = __L1:hx(b)
        return __add(
            "#",
            __call(
                __call(
                    A,
                    "map",
                    function(____, v, i) return __call(
                        __call(
                            math.floor(v + (__get(B, i) - v) * __L1:clamp(k, 0, 1) + 0.5),
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
    __L1.pinta = function(____, c) return function(____, x, y, w, h, col)
        c.fillStyle = col
        c:fillRect(
            math.floor(x + 0.5),
            math.floor(y + 0.5),
            math.floor(w + 0.5),
            math.floor(h + 0.5)
        )
    end end
    __L1.bola = function(____, c) return function(____, cx, cy, r, col, ry)
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
    end end
    __L1.reduzido = window:matchMedia("(prefers-reduced-motion: reduce)").matches
    __L1.ac = nil
    __L1.LW = 480
    __L1.LH = 270
    __L1.HZ = 150
    cena, g = table.unpack(
        __L1:mk(__L1.LW, __L1.LH),
        1,
        2
    )
    chao, q = table.unpack(
        __L1:mk(__L1.LW, __L1.LH),
        1,
        2
    )
    fixo, f = table.unpack(
        __L1:mk(__L1.LW, __L1.LH),
        1,
        2
    )
    __L1.R = __L1:pinta(q)
    __L1.B = __L1:bola(q)
    __L1.Rg = __L1:pinta(g)
    __L1.Bg = __L1:bola(g)
    __L1.kY = function(____, y) return __L1:clamp((y - __L1.HZ) / (__L1.LH - __L1.HZ), 0, 1) end
    __L1.rioL = function(____, y) return __L1:lerp(
        438,
        326,
        __L1:kY(y)
    ) + math.sin(__L1:kY(y) * 3) * 8 end
    __L1.rioR = function(____, y) return __L1:lerp(
        448,
        510,
        __L1:kY(y)
    ) + math.sin(__L1:kY(y) * 3) * 6 end
    __L1.noRio = function(____, x, y)
        local ____t_result_166
        local ____t_165 = __t
        local ____temp_164 = __gt(y, __L1.HZ + 1) and __gt(
            x,
            __L1:rioL(y)
        )
        __O[3205] = ____temp_164
        if ____t_165(____temp_164) then
            ____t_result_166 = __lt(
                x,
                __L1:rioR(y)
            )
        else
            ____t_result_166 = __O[3205]
        end
        return ____t_result_166
    end
    __L1.trilhaC = function(____, y) return __L1:lerp(
        238,
        212,
        __L1:kY(y)
    ) + math.sin(__L1:kY(y) * 2.2) * 10 end
    __L1.trilhaW = function(____, y) return __L1:lerp(
        3,
        36,
        __L1:kY(y)
    ) end
    __L1.naTrilha = function(____, x, y) return __gt(y, __L1.HZ) and __lt(
        math.abs(x - __L1:trilhaC(y)),
        __L1:trilhaW(y)
    ) end
    __L1.CASA = __ord({x0 = 30, x1 = 128, y0 = 104, y1 = 192}, "x0,x1,y0,y1")
    __L1.CELEIRO = __ord({x0 = 284, x1 = 350, y0 = 126, y1 = 192}, "x0,x1,y0,y1")
    __L1.MOINHO = __ord({
        hx = 379,
        hy = 110,
        x0 = 362,
        x1 = 396,
        y1 = 192
    }, "hx,hy,x0,x1,y1")
    __L1.JANELAS = __arrL(
        {
            __arrL({44, 160, 16, 14}, 4),
            __arrL({98, 160, 16, 14}, 4),
            __arrL({312, 136, 8, 7}, 4),
            __arrL({375, 140, 7, 8}, 4)
        },
        4
    )
    __L1.CACAUS = __arrL(
        {
            __arrL({218, 170}, 2),
            __arrL({240, 166}, 2),
            __arrL({262, 171}, 2)
        },
        3
    )
    __L1.ARVORE = __ord({x = 172, y = 196, cx = 176, cy = 122}, "x,y,cx,cy")
    __L1.BALANCO = __ord({x = 200, y = 141, L = 34}, "x,y,L")
    if __t(window.DAROCA_ROBLOX) then
        window:requestAnimationFrame(function() return __L1:montarFixo() end)
    else
        __L1:montarFixo()
    end
    __L1.hora = (__new("Date"):getHours() + __new("Date"):getMinutes() / 60) / 24
    __L1.horaAlvo = nil
    __L1.pas = 0
    __L1.pasVel = 0.55
    __L1.balanco = 0.18
    __L1.balancoV = 0
    __L1.ultimo = 0
    __L1.tempo = 0
    __L1.parts = __arrL({}, 0)
    __L1.plantas = __arrL({}, 0)
    __L1.aves = __arrL({}, 0)
    __L1.cadentes = __arrL({}, 0)
    __L1.chuvas = __arrL({}, 0)
    __L1.aneis = __arrL({}, 0)
    __L1.nuvens = __arrayFrom(
        {length = 6},
        function(____, _, i) return {
            x = __L1:hash(i * 3) * __L1.LW,
            y = 14 + __L1:hash(i * 7) * 60,
            w = 18 + __L1:hash(i * 11) * 26,
            v = 2 + __L1:hash(i * 5) * 3
        } end
    )
    __L1.estrelas = __arrayFrom(
        {length = 70},
        function(____, _, i) return {
            x = __L1:hash(i * 1.3) * __L1.LW,
            y = __L1:hash(i * 2.9) * 120,
            f = __L1:hash(i * 4.1) * 6
        } end
    )
    __L1.borboletas = __arrayFrom(
        {length = 4},
        function(____, _, i) return {
            x = 60 + i * 90,
            y = 200 + __mod(i, 2) * 20,
            f = i * 1.7,
            c = __get(
                __arrL({"#f8d040", "#e87aa8", "#ffffff", "#7ac8f8"}, 4),
                i
            )
        } end
    )
    __L1.vagalumes = __arrayFrom(
        {length = 26},
        function(____, _, i) return {
            x = __L1:hash(i * 9.7) * __L1.LW,
            y = 170 + __L1:hash(i * 3.1) * 90,
            f = __L1:hash(i) * 6
        } end
    )
    __L1.galinhas = __call(
        __arrL(
            {
                __ord({x = 250, y = 222, d = 1, br = true}, "x,y,d,br"),
                __ord({x = 290, y = 236, d = -1, br = false}, "x,y,d,br"),
                __ord({x = 330, y = 214, d = 1, br = true}, "x,y,d,br")
            },
            3
        ),
        "map",
        function(____, gal) return __assign(
            {},
            gal,
            {
                alvo = nil,
                t = __L1:rnd(0, 2),
                z = 0,
                vz = 0,
                bica = 0,
                susto = 0
            }
        ) end
    )
    __L1.sapo = __ord({
        x = 344,
        y = 250,
        z = 0,
        vz = 0,
        pisca = 0,
        papo = 0
    }, "x,y,z,vz,pisca,papo")
    __L1.roca = __ord({
        x = 192,
        y = 238,
        aceno = 0,
        chapeu = 0,
        vChapeu = 0
    }, "x,y,aceno,chapeu,vChapeu")
    __L1.peixe = nil
    __L1.fumacaExtra = 0
    __L1.luzCasa = 0
    __L1.dicaUsos = 0
    __L1.posSol = function(____, p)
        if __t(__lt(p, 0.22) or __gt(p, 0.78)) then
            return nil
        end
        local u = (p - 0.22) / 0.56
        return {
            x = 40 + u * 400,
            y = 140 - math.sin(u * math.pi) * 112
        }
    end
    __L1.posLua = function(____, p)
        local ____lt_result_167
        if __lt(p, 0.5) then
            ____lt_result_167 = p + 1
        else
            ____lt_result_167 = p
        end
        local pp = ____lt_result_167
        if __t(__lt(pp, 0.72) or __gt(pp, 1.28)) then
            return nil
        end
        local u = (pp - 0.72) / 0.56
        return {
            x = 40 + u * 400,
            y = 140 - math.sin(u * math.pi) * 104
        }
    end
    __L1.TIPOS = __arrL({
        "girassol",
        "milho",
        "flores",
        "abobora",
        "cacau",
        "couve",
        "girassol",
        "flores"
    }, 8)
    __L1.P = function(____, o) return __call(
        __L1.parts,
        "push",
        __assign({}, {
            vx = 0,
            vy = 0,
            gr = 0,
            t = 0,
            vida = 1,
            tam = 1,
            tipo = "px"
        }, o)
    ) end
    __L1.GL = __ord(
        {
            D = __arrL({
                "#######...",
                "########..",
                "###..####.",
                "###...###.",
                "###....###",
                "###....###",
                "###....###",
                "###....###",
                "###...###.",
                "###..####.",
                "########..",
                "#######..."
            }, 12),
            A = __arrL({
                "...####...",
                "..######..",
                ".###..###.",
                ".###..###.",
                "###....###",
                "###....###",
                "##########",
                "##########",
                "###....###",
                "###....###",
                "###....###",
                "###....###"
            }, 12),
            R = __arrL({
                "#######...",
                "########..",
                "###...###.",
                "###...###.",
                "###...###.",
                "########..",
                "#######...",
                "###.###...",
                "###..###..",
                "###...###.",
                "###...###.",
                "###....###"
            }, 12),
            O = __arrL({
                "..######..",
                ".########.",
                "###....###",
                "###....###",
                "###....###",
                "###....###",
                "###....###",
                "###....###",
                "###....###",
                "###....###",
                ".########.",
                "..######.."
            }, 12),
            ["Ç"] = __arrL({
                "..#######.",
                ".#########",
                "###.....##",
                "###.......",
                "###.......",
                "###.......",
                "###.......",
                "###.......",
                "###.......",
                "###.....##",
                ".#########",
                "..#######.",
                ".....##...",
                "......##..",
                "....###..."
            }, 15),
            V = __arrL({
                "###....###",
                "###....###",
                "###....###",
                "###....###",
                "###....###",
                ".###..###.",
                ".###..###.",
                ".###..###.",
                "..######..",
                "..######..",
                "...####...",
                "....##...."
            }, 12),
            E = __arrL({
                "##########",
                "##########",
                "###.......",
                "###.......",
                "###.......",
                "########..",
                "########..",
                "###.......",
                "###.......",
                "###.......",
                "##########",
                "##########"
            }, 12),
            N = __arrL({
                "###....###",
                "####...###",
                "#####..###",
                "######.###",
                "###.######",
                "###..#####",
                "###...####",
                "###....###",
                "###....###",
                "###....###",
                "###....###",
                "###....###"
            }, 12),
            T = __arrL({
                "##########",
                "##########",
                "...####...",
                "...####...",
                "...####...",
                "...####...",
                "...####...",
                "...####...",
                "...####...",
                "...####...",
                "...####...",
                "...####..."
            }, 12),
            U = __arrL({
                "###....###",
                "###....###",
                "###....###",
                "###....###",
                "###....###",
                "###....###",
                "###....###",
                "###....###",
                "###....###",
                "####..####",
                ".########.",
                "..######.."
            }, 12)
        },
        "D,A,R,O,Ç,V,E,N,T,U"
    )
    __L1.ESTILO_G = __ord(
        {
            borda = 2,
            ext = 4,
            contorno = "#2a1408",
            extCor = "#8a4a1c",
            extFundo = "#5a2c10",
            grad = __arrL(
                {
                    __arrL({0, "#fff8dc"}, 2),
                    __arrL({0.25, "#ffe48a"}, 2),
                    __arrL({0.6, "#f6b840"}, 2),
                    __arrL({1, "#d8802a"}, 2)
                },
                4
            ),
            luz = "#ffffff",
            fundo = "#b8641e",
            textura = true
        },
        "borda,ext,contorno,extCor,extFundo,grad,luz,fundo,textura"
    )
    __L1.ESTILO_P = __ord(
        {
            borda = 1,
            ext = 2,
            contorno = "#1a3410",
            extCor = "#2a5a1c",
            extFundo = "#1a3410",
            grad = __arrL(
                {
                    __arrL({0, "#fffbe8"}, 2),
                    __arrL({0.6, "#fff0c8"}, 2),
                    __arrL({1, "#f0d8a0"}, 2)
                },
                3
            ),
            luz = "#ffffff",
            fundo = "#d8bc84",
            textura = false
        },
        "borda,ext,contorno,extCor,extFundo,grad,luz,fundo,textura"
    )
    __L1.TEXTO_G = __arr(__TS__Spread(__iter("DA ROÇA")))
    __L1.TEXTO_P = __arr(__TS__Spread(__iter("ADVENTURE")))
    __L1.BIG = __arrL({}, 0)
    __L1.SMALL = __arrL({}, 0)
    if not __t(window.DAROCA_ROBLOX) then
        __L1:montarLetras(99)
    end
    __L1.LOGW = 340
    __L1.LOGH = 168
    logoCv, lc = table.unpack(
        __L1:mk(__L1.LOGW, __L1.LOGH),
        1,
        2
    )
    letrasCv, lt = table.unpack(
        __L1:mk(__L1.LOGW, __L1.LOGH),
        1,
        2
    )
    placaCv, pc = table.unpack(
        __L1:mk(__L1.LOGW, __L1.LOGH),
        1,
        2
    )
    logoCv.className = "tr-logo"
    logoCv:setAttribute("role", "img")
    logoCv:setAttribute("aria-label", "Da Roça Adventure")
    __L1.L = __L1:pinta(lc)
    __L1.LB = __L1:bola(lc)
    if __t(window.DAROCA_ROBLOX) then
        window:requestAnimationFrame(function() return __L1:montarPlaca() end)
    else
        __L1:montarPlaca()
    end
    if not __t(window.DAROCA_ROBLOX) then
        local ____opt_171 = window.document.fonts
        local ____opt_168 = ____opt_171 and ____opt_171.load
        if ____opt_168 ~= nil then
            local ____self_169 = ____opt_168(____opt_171, "8px Pixel")
            ____self_169["then"](____self_169, __L1.montarPlaca):catch(function()
            end)
        end
    end
    __L1.logo0 = nil
    __L1.onda = 0
    __L1.easeBounce = function(____, u)
        if __lt(u, 1 / 2.75) then
            return 7.5625 * u * u
        end
        if __lt(u, 2 / 2.75) then
            u = u - 1.5 / 2.75
            return 7.5625 * u * u + 0.75
        end
        if __lt(u, 2.5 / 2.75) then
            u = u - 2.25 / 2.75
            return 7.5625 * u * u + 0.9375
        end
        u = u - 2.625 / 2.75
        return 7.5625 * u * u + 0.984375
    end
    __L1.easeBack = function(____, u)
        local c1 = 1.70158
        local c3 = c1 + 1
        return 1 + c3 * (u - 1) ^ 3 + c1 * (u - 1) ^ 2
    end
    __L1.ICONES = __ord(
        {
            jogar = __L1:icone(function(____, R, Bb)
                R(
                    nil,
                    2,
                    12,
                    12,
                    3,
                    "#5a3418"
                )
                R(
                    nil,
                    3,
                    11,
                    10,
                    1,
                    "#8a5a30"
                )
                R(
                    nil,
                    4,
                    13,
                    2,
                    1,
                    "#3a200e"
                )
                R(
                    nil,
                    9,
                    13,
                    2,
                    1,
                    "#3a200e"
                )
                R(
                    nil,
                    7,
                    5,
                    2,
                    7,
                    "#3f8a2a"
                )
                R(
                    nil,
                    2,
                    4,
                    5,
                    3,
                    "#3f8a2a"
                )
                R(
                    nil,
                    3,
                    4,
                    3,
                    1,
                    "#7ad04a"
                )
                R(
                    nil,
                    9,
                    2,
                    5,
                    3,
                    "#3f8a2a"
                )
                R(
                    nil,
                    10,
                    2,
                    3,
                    1,
                    "#7ad04a"
                )
                R(
                    nil,
                    5,
                    6,
                    2,
                    1,
                    "#3f8a2a"
                )
                R(
                    nil,
                    9,
                    5,
                    1,
                    1,
                    "#3f8a2a"
                )
            end),
            multi = __L1:icone(function(____, R)
                for ____, ____value in __iterar((__arrL(
                    {
                        __arrL({1, 6, "#e8c86a", "#8a3a2a"}, 4),
                        __arrL({6, 3, "#f0d27a", "#3a6a9a"}, 4)
                    },
                    2
                ))) do
                    local x = ____value[1]
                    local y = ____value[2]
                    local c = ____value[3]
                    local b = ____value[4]
                    R(
                        nil,
                        x,
                        y + 5,
                        10,
                        2,
                        "#2a1408"
                    )
                    R(
                        nil,
                        x,
                        y + 5,
                        10,
                        1,
                        c
                    )
                    R(
                        nil,
                        x + 2,
                        y,
                        6,
                        6,
                        "#2a1408"
                    )
                    R(
                        nil,
                        x + 3,
                        y + 1,
                        4,
                        5,
                        c
                    )
                    R(
                        nil,
                        x + 3,
                        y + 4,
                        4,
                        1,
                        b
                    )
                    R(
                        nil,
                        x + 3,
                        y + 1,
                        1,
                        1,
                        "#fff6c0"
                    )
                end
            end),
            diario = __L1:icone(function(____, R)
                R(
                    nil,
                    1,
                    3,
                    14,
                    11,
                    "#2a1408"
                )
                R(
                    nil,
                    2,
                    4,
                    5,
                    9,
                    "#f6e6bc"
                )
                R(
                    nil,
                    9,
                    4,
                    5,
                    9,
                    "#f6e6bc"
                )
                R(
                    nil,
                    7,
                    3,
                    2,
                    11,
                    "#8a3a2a"
                )
                do
                    local y = 6
                    while y < 12 do
                        R(
                            nil,
                            3,
                            y,
                            3,
                            1,
                            "#a8906a"
                        )
                        R(
                            nil,
                            10,
                            y,
                            3,
                            1,
                            "#a8906a"
                        )
                        y = y + 2
                    end
                end
                R(
                    nil,
                    11,
                    2,
                    2,
                    5,
                    "#e84a4a"
                )
            end),
            continuar = __L1:icone(function(____, R)
                R(
                    nil,
                    7,
                    8,
                    2,
                    7,
                    "#6a4426"
                )
                R(
                    nil,
                    2,
                    3,
                    11,
                    6,
                    "#2a1408"
                )
                R(
                    nil,
                    3,
                    4,
                    9,
                    4,
                    "#c88a4a"
                )
                R(
                    nil,
                    12,
                    4,
                    1,
                    4,
                    "#2a1408"
                )
                R(
                    nil,
                    13,
                    5,
                    1,
                    2,
                    "#2a1408"
                )
                R(
                    nil,
                    12,
                    5,
                    1,
                    2,
                    "#c88a4a"
                )
                R(
                    nil,
                    4,
                    5,
                    6,
                    1,
                    "#7a4a24"
                )
                R(
                    nil,
                    3,
                    4,
                    9,
                    1,
                    "#e8b070"
                )
            end),
            nova = __L1:icone(function(____, R, Bb)
                R(
                    nil,
                    0,
                    11,
                    16,
                    5,
                    "#5a9a3a"
                )
                R(
                    nil,
                    0,
                    11,
                    16,
                    1,
                    "#86c25a"
                )
                Bb(
                    nil,
                    8,
                    11,
                    5,
                    "#ffd23a",
                    5
                )
                R(
                    nil,
                    0,
                    12,
                    16,
                    4,
                    "#5a9a3a"
                )
                for ____, ____value in __iterar((__arrL(
                    {
                        __arrL({8, 2}, 2),
                        __arrL({2, 6}, 2),
                        __arrL({14, 6}, 2),
                        __arrL({4, 3}, 2),
                        __arrL({12, 3}, 2)
                    },
                    5
                ))) do
                    local x = ____value[1]
                    local y = ____value[2]
                    R(
                        nil,
                        x,
                        y,
                        1,
                        2,
                        "#ffe88a"
                    )
                end
                R(
                    nil,
                    6,
                    8,
                    2,
                    1,
                    "#fff6c0"
                )
            end)
        },
        "jogar,multi,diario,continuar,nova"
    )
    __L1.conteudo = __L1.tela:querySelector(".start-content")
    __L1.placaHtml = __L1.tela:querySelector(".wooden-title")
    if __t(__L1.conteudo) then
        if __t(__L1.placaHtml) then
            __L1.placaHtml:before(logoCv)
        else
            __L1.conteudo:prepend(logoCv)
        end
    end
    __L1.dica = window.document:createElement("div")
    __L1.dica.className = "tr-dica"
    __L1.dica.innerHTML = "<b>✿</b> <span class=\"longa\">Toque no cenário: plante na horta, assuste as galinhas, troque o dia no sol...</span><span class=\"curta\">Toque no cenário!</span>"
    do
        pcall(function()
            if window.localStorage:getItem("daroca-tela-dica") == "1" then
                __call(__L1.dica.classList, "add", "some")
            end
        end)
    end
    __L1.tela:appendChild(__L1.dica)
    logoCv:addEventListener(
        "pointerdown",
        function(____, e)
            e:stopPropagation()
            __L1.onda = 1
            __L1:som("logo")
            do
                local k = 0
                while k < 10 do
                    __L1:folhas(
                        __L1:rnd(120, 360),
                        __L1:rnd(20, 60),
                        1
                    )
                    k = k + 1
                end
            end
        end
    )
    __L1.tela:addEventListener(
        "pointerdown",
        function(____, e)
            local alvo = e.target
            local ____t_179 = __t
            local ____t_result_178
            local ____t_174 = __t
            local ____temp_173 = alvo ~= __L1.tela and alvo ~= __L1.cvFundo
            __O[3238] = ____temp_173
            if ____t_174(____temp_173) then
                local ____t_177 = __t
                local ____opt_175 = alvo.classList
                if ____opt_175 ~= nil then
                    ____opt_175 = ____opt_175:contains("start-content")
                end
                ____t_result_178 = not ____t_177(____opt_175)
            else
                ____t_result_178 = __O[3238]
            end
            if ____t_179(____t_result_178) then
                return
            end
            local x, y = table.unpack(
                __L1:paraCena(e),
                1,
                2
            )
            local ____t_185 = __t
            local ____t_result_184
            local ____t_183 = __t
            local ____t_result_182
            local ____t_181 = __t
            local ____temp_180 = x < 0 or y < 0
            __O[3239] = ____temp_180
            if ____t_181(____temp_180) then
                ____t_result_182 = __O[3239]
            else
                ____t_result_182 = x > __L1.LW
            end
            __O[3240] = ____t_result_182
            if ____t_183(____t_result_182) then
                ____t_result_184 = __O[3240]
            else
                ____t_result_184 = y > __L1.LH
            end
            if ____t_185(____t_result_184) then
                return
            end
            __L1:tocar(x, y)
            if __L1.dicaUsos == 3 then
                do
                    pcall(function()
                        window.localStorage:setItem("daroca-tela-dica", "1")
                    end)
                end
            end
        end
    )
    __L1.rastro = 0
    __L1.tela:addEventListener(
        "pointermove",
        function(____, e)
            local ____t_189 = __t
            local ____t_result_188
            local ____t_187 = __t
            local ____temp_186 = e.pointerType ~= "mouse"
            __O[3241] = ____temp_186
            if ____t_187(____temp_186) then
                ____t_result_188 = __O[3241]
            else
                ____t_result_188 = e.target ~= __L1.cvFundo and e.target ~= __L1.tela
            end
            if ____t_189(____t_result_188) then
                return
            end
            if window.performance:now() - __L1.rastro < 45 then
                return
            end
            __L1.rastro = window.performance:now()
            local x, y = table.unpack(
                __L1:paraCena(e),
                1,
                2
            )
            __L1:P({
                x = x,
                y = y,
                vx = __L1:rnd(-6, 6),
                vy = __L1:rnd(-10, 0),
                vida = 0.5,
                cor = __get(
                    __arrL({"#fff6b0", "#ffffff", "#c8f080"}, 3),
                    __bor(
                        math.random() * 3,
                        0
                    )
                ),
                tipo = "estrela"
            })
        end
    )
    __L1:enfeitar()
    __new("MutationObserver", __L1.enfeitar):observe(
        __L1.tela,
        __ord({childList = true, subtree = true}, "childList,subtree")
    )
    if __t(window.Art) then
        window.Art.drawTitleScene = __L1.desenhar
    end
    window.TelaInicial = __ord(
        {
            tocar = __L1.tocar,
            hora = function(____, h)
                if h ~= nil then
                    __L1.hora = __mod(
                        __mod(h, 1) + 1,
                        1
                    )
                    __L1.horaAlvo = nil
                end
                return __L1.hora
            end,
            plantas = function() return __len(__L1.plantas) end,
            cena = function() return cena end,
            logo = function() return logoCv end
        },
        "tocar,hora,plantas,cena,logo"
    )
end)(nil)
return ____exports
