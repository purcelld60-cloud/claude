--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __ge, __mod, __pk, __ord, __arrL, __t, __get, __len, __call, __add, __assign = __JSR.__lt, __JSR.__ge, __JSR.__mod, __JSR.__pk, __JSR.__ord, __JSR.__arrL, __JSR.__t, __JSR.__get, __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__assign
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local original = window.Cinematics
    if not __t(original) then
        return
    end
    local KIND = "easy_finish"
    local W = 960
    local H = 540
    local frames = __arrL(
        {
            __ord({
                id = "prize",
                duration = 2.2,
                title = "O PRÊMIO DO MODO FÁCIL",
                speaker = "Irmão de Clara Swift",
                text = "Zerou no Fácil? O bolo voltou… e a chupeta veio de brinde, bebezinho!"
            }, "id,duration,title,speaker,text"),
            __ord({
                id = "pacifier",
                duration = 2.6,
                title = "UMA CONQUISTA BEM DIFERENTE",
                speaker = "Da Roça",
                text = "Eu só pedi mais tempo entre os ataques, pô… E me deram logo uma chupeta!"
            }, "id,duration,title,speaker,text"),
            __ord({
                id = "babble",
                duration = 3.6,
                title = "CHUPETA CONQUISTADA",
                speaker = "Da Roça",
                text = "Gugu dada!"
            }, "id,duration,title,speaker,text")
        },
        3
    )
    local cursor = 0
    local serial = 0
    local shots = __call(
        frames,
        "map",
        function(____, f, index)
            local shot = __assign({}, f, {label = f.title, index = index, start = cursor})
            cursor = cursor + f.duration
            return shot
        end
    )
    local total = math.floor(cursor * 100 + 0.5) / 100
    local info = __ord({id = KIND, duration = total, manualDefault = false, shots = shots}, "id,duration,manualDefault,shots")
    local function clamp(____, n, a, b)
        if a == nil then
            a = 0
        end
        if b == nil then
            b = 1
        end
        local ____a_3 = a
        local ____b_2 = b
        local ____t_1 = __t
        local ____TS__Number_result_0 = __TS__Number(n)
        __O[1247] = ____TS__Number_result_0
        return math.max(
            ____a_3,
            math.min(____b_2, if ____t_1(____TS__Number_result_0) then __O[1247] else 0)
        )
    end
    local function ease(____, n)
        n = clamp(nil, n)
        return n * n * (3 - 2 * n)
    end
    local function mix(____, a, b, n)
        return a + (b - a) * n
    end
    local function isEasy(____, s)
        local ____opt_result_6
        if s ~= nil then
            ____opt_result_6 = s.kind
        end
        return ____opt_result_6 == KIND
    end
    local function position(self, s)
        if not __t(s) then
            return 0
        end
        if __t(s.done) then
            return total
        end
        local index = clamp(
            nil,
            math.floor(s.index),
            0,
            __len(frames) - 1
        )
        local ____get_result_start_9 = __get(shots, index).start
        local ____t_8 = __t
        local ____TS__Number_result_7 = __TS__Number(s.time)
        __O[1248] = ____TS__Number_result_7
        return clamp(
            nil,
            ____get_result_start_9 + math.max(0, if ____t_8(____TS__Number_result_7) then __O[1248] else 0),
            0,
            total
        )
    end
    local function create(self, options)
        if options == nil then
            options = {}
        end
        local ____add_10 = __add
        serial = serial + 1
        return {
            kind = KIND,
            index = 0,
            time = 0,
            elapsed = 0,
            done = false,
            token = ____add_10("easy-finish-", serial),
            sfxPlayed = false,
            options = __assign({}, options)
        }
    end
    local function stateAt(self, seconds, options)
        if seconds == nil then
            seconds = 0
        end
        if options == nil then
            options = {}
        end
        local elapsed = clamp(nil, seconds, 0, total)
        local index = __call(
            shots,
            "findIndex",
            function(____, shot) return elapsed < shot.start + shot.duration end
        )
        if index < 0 then
            index = __len(shots) - 1
        end
        return {
            kind = KIND,
            index = index,
            time = elapsed - __get(shots, index).start,
            elapsed = elapsed,
            done = elapsed >= total,
            sfxPlayed = true,
            options = __assign({}, options, {musicTimed = true, preview = true})
        }
    end
    local function voice(self, s)
        local ____t_17 = __t
        local ____t_16 = __t
        local ____t_14 = __t
        local ____opt_11 = s.options
        if ____opt_11 ~= nil then
            ____opt_11 = ____opt_11.preview
        end
        local ____temp_13 = if __t(s.sfxPlayed) then s.sfxPlayed else ____opt_11
        __O[1249] = ____temp_13
        local ____temp_15 = if ____t_14(____temp_13) then __O[1249] else s.index ~= 2
        __O[1250] = ____temp_15
        if ____t_17(if ____t_16(____temp_15) then __O[1250] else __lt(s.time, 0.08)) then
            return
        end
        s.sfxPlayed = true
        local ____opt_22 = window.ArenaSound
        if ____opt_22 ~= nil then
            ____opt_22 = ____opt_22.play
        end
        if ____opt_22 ~= nil then
            local ____add_20 = __add
            local ____s_audioToken_19 = s.audioToken
            if ____s_audioToken_19 == nil then
                ____s_audioToken_19 = s.token
            end
            ____opt_22(
                ____opt_22,
                "gugu-dada",
                {id = ____add_20("easy-babble-", ____s_audioToken_19)}
            )
        end
    end
    local function update(self, s, dt)
        local ____t_26 = __t
        local ____t_25 = __t
        local ____temp_24 = not __t(s)
        __O[1251] = ____temp_24
        if ____t_26(if ____t_25(____temp_24) then __O[1251] else s.done) then
            return
        end
        s.time = s.time + clamp(nil, dt, 0, 0.1)
        while __t(not __t(s.done) and __ge(
            s.time,
            __get(frames, s.index).duration
        )) do
            s.time = s.time - __get(frames, s.index).duration
            if __ge(
                s.index + 1,
                __len(frames)
            ) then
                s.done = true
                s.time = __get(frames, s.index).duration
            else
                s.index = s.index + 1
            end
        end
        s.elapsed = position(nil, s)
        voice(nil, s)
    end
    local function advance(self, s)
        local ____t_29 = __t
        local ____t_28 = __t
        local ____temp_27 = not __t(s)
        __O[1252] = ____temp_27
        if ____t_29(if ____t_28(____temp_27) then __O[1252] else s.done) then
            return false
        end
        if __ge(
            s.index + 1,
            __len(frames)
        ) then
            s.done = true
            s.time = __get(frames, s.index).duration
            s.elapsed = total
            return false
        end
        s.index = s.index + 1
        s.time = 0
        s.elapsed = __get(shots, s.index).start
        return true
    end
    local function rect(self, c, x, y, w, h, color)
        c.fillStyle = color
        c:fillRect(
            math.floor(x + 0.5),
            math.floor(y + 0.5),
            math.floor(w + 0.5),
            math.floor(h + 0.5)
        )
    end
    local function text(self, c, value, x, y, size, color, align)
        if size == nil then
            size = 14
        end
        if color == nil then
            color = "#fff0c1"
        end
        if align == nil then
            align = "center"
        end
        c.font = __add(
            __add("bold ", size),
            "px monospace"
        )
        c.textAlign = align
        c.textBaseline = "middle"
        c.fillStyle = "#513321"
        c:fillText(value, x + 2, y + 2)
        c.fillStyle = color
        c:fillText(value, x, y)
    end
    local function pennants(self, c, t)
        rect(
            nil,
            c,
            0,
            46,
            W,
            3,
            "#3c5966"
        )
        do
            local i = 0
            while i < 25 do
                local x = i * 40 - 7
                local y = 49 + math.floor(math.sin(t * 2 + i) * 3 + 0.5)
                local color = __get(
                    __arrL({"#e95239", "#ffd04b", "#338bcc"}, 3),
                    __mod(i, 3)
                )
                rect(
                    nil,
                    c,
                    x,
                    y,
                    24,
                    8,
                    color
                )
                rect(
                    nil,
                    c,
                    x + 3,
                    y + 8,
                    18,
                    6,
                    color
                )
                rect(
                    nil,
                    c,
                    x + 7,
                    y + 14,
                    10,
                    5,
                    color
                )
                rect(
                    nil,
                    c,
                    x + 10,
                    y + 19,
                    4,
                    4,
                    color
                )
                i = i + 1
            end
        end
    end
    local function pacifier(self, c, x, y, scale, bob)
        if scale == nil then
            scale = 1
        end
        if bob == nil then
            bob = 0
        end
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + bob + 0.5)
        )
        c:scale(scale, scale)
        rect(
            nil,
            c,
            -13,
            -2,
            7,
            6,
            "#fff1bc"
        )
        rect(
            nil,
            c,
            -11,
            -4,
            7,
            10,
            "#d5ae70"
        )
        rect(
            nil,
            c,
            -10,
            -3,
            6,
            7,
            "#f4d89d"
        )
        rect(
            nil,
            c,
            -5,
            -8,
            14,
            18,
            "#7e2932"
        )
        rect(
            nil,
            c,
            -7,
            -5,
            18,
            12,
            "#7e2932"
        )
        rect(
            nil,
            c,
            -4,
            -7,
            12,
            16,
            "#f3cb45"
        )
        rect(
            nil,
            c,
            -6,
            -4,
            16,
            10,
            "#ffdb50"
        )
        rect(
            nil,
            c,
            -2,
            -5,
            8,
            3,
            "#fff3af"
        )
        rect(
            nil,
            c,
            -3,
            5,
            11,
            3,
            "#eaa82c"
        )
        rect(
            nil,
            c,
            1,
            -2,
            12,
            6,
            "#962f38"
        )
        rect(
            nil,
            c,
            4,
            -3,
            8,
            8,
            "#e84d55"
        )
        rect(
            nil,
            c,
            8,
            -1,
            9,
            4,
            "#e84d55"
        )
        rect(
            nil,
            c,
            12,
            1,
            9,
            3,
            "#284a82"
        )
        rect(
            nil,
            c,
            17,
            3,
            6,
            10,
            "#284a82"
        )
        rect(
            nil,
            c,
            11,
            12,
            9,
            4,
            "#284a82"
        )
        rect(
            nil,
            c,
            7,
            5,
            5,
            8,
            "#284a82"
        )
        rect(
            nil,
            c,
            12,
            4,
            7,
            2,
            "#6ecbff"
        )
        rect(
            nil,
            c,
            19,
            6,
            2,
            5,
            "#3faaf0"
        )
        rect(
            nil,
            c,
            11,
            12,
            7,
            2,
            "#3faaf0"
        )
        rect(
            nil,
            c,
            9,
            7,
            2,
            4,
            "#6ecbff"
        )
        c:restore()
    end
    local function toy(self, c, x, y, t, withPacifier)
        if withPacifier == nil then
            withPacifier = true
        end
        c:save()
        c:translate(x, y)
        c:rotate(math.sin(t * 2) * 0.035)
        rect(
            nil,
            c,
            -61,
            0,
            122,
            37,
            "#855139"
        )
        rect(
            nil,
            c,
            -65,
            -6,
            130,
            8,
            "#e2ac65"
        )
        rect(
            nil,
            c,
            -55,
            30,
            11,
            22,
            "#5b3c2d"
        )
        rect(
            nil,
            c,
            44,
            30,
            11,
            22,
            "#5b3c2d"
        )
        rect(
            nil,
            c,
            -45,
            5,
            90,
            3,
            "#b97b46"
        )
        if __t(withPacifier) then
            pacifier(
                nil,
                c,
                -8,
                -18,
                1.1,
                math.sin(t * 3) * 2
            )
        end
        rect(
            nil,
            c,
            -45,
            -30,
            29,
            20,
            "#e84b3b"
        )
        rect(
            nil,
            c,
            -41,
            -26,
            21,
            12,
            "#ffda51"
        )
        rect(
            nil,
            c,
            -34,
            -23,
            7,
            7,
            "#f5efc6"
        )
        c:restore()
    end
    local function backdrop(self, c, s)
        local t = position(nil, s)
        rect(
            nil,
            c,
            0,
            0,
            W,
            H,
            "#4ba9e0"
        )
        do
            local i = 0
            while i < 5 do
                local x = __mod(i * 251 + t * 7, 1250) - 170
                local y = 87 + __mod(i, 2) * 59
                rect(
                    nil,
                    c,
                    x,
                    y,
                    84,
                    15,
                    "#fff4ce"
                )
                rect(
                    nil,
                    c,
                    x + 15,
                    y - 13,
                    49,
                    15,
                    "#fff4ce"
                )
                rect(
                    nil,
                    c,
                    x + 30,
                    y - 23,
                    22,
                    10,
                    "#fff4ce"
                )
                i = i + 1
            end
        end
        rect(
            nil,
            c,
            0,
            290,
            W,
            135,
            "#81b953"
        )
        do
            local i = 0
            while i < 8 do
                rect(
                    nil,
                    c,
                    i * 137 - 35,
                    264 + __mod(i, 3) * 14,
                    104,
                    94,
                    "#5ba358"
                )
                rect(
                    nil,
                    c,
                    i * 137 - 12,
                    245 + __mod(i, 3) * 14,
                    60,
                    44,
                    "#6bac5a"
                )
                i = i + 1
            end
        end
        rect(
            nil,
            c,
            0,
            398,
            W,
            142,
            "#bc793e"
        )
        rect(
            nil,
            c,
            0,
            397,
            W,
            8,
            "#f6c04f"
        )
        do
            local i = 0
            while i < 25 do
                rect(
                    nil,
                    c,
                    __mod(i * 79 + 17, 960),
                    422 + __mod(i * 37, 100),
                    10 + __mod(i, 4),
                    3,
                    "#e3a25e"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 12 do
                local x = i * 88 - 7
                rect(
                    nil,
                    c,
                    x,
                    335,
                    9,
                    64,
                    "#e9d3a5"
                )
                rect(
                    nil,
                    c,
                    x + 1,
                    335,
                    7,
                    8,
                    "#fff0c9"
                )
                i = i + 1
            end
        end
        rect(
            nil,
            c,
            0,
            353,
            W,
            8,
            "#dca96d"
        )
        rect(
            nil,
            c,
            0,
            380,
            W,
            7,
            "#dca96d"
        )
        pennants(nil, c, t)
        rect(
            nil,
            c,
            77,
            224,
            313,
            66,
            "#65412c"
        )
        rect(
            nil,
            c,
            82,
            229,
            303,
            56,
            "#d8a766"
        )
        rect(
            nil,
            c,
            90,
            235,
            287,
            2,
            "#f7d491"
        )
        text(
            nil,
            c,
            "FINALIZOU NO FÁCIL",
            234,
            252,
            18,
            "#fff0b0"
        )
        text(
            nil,
            c,
            "PACOTINHO DE CORAGEM",
            234,
            274,
            10,
            "#6e4126"
        )
        toy(
            nil,
            c,
            245,
            405,
            t,
            s.index == 0
        )
    end
    local function draw(self, c, s)
        if __t(not __t(c) or not __t(s)) then
            return
        end
        c:save()
        c.imageSmoothingEnabled = false
        backdrop(nil, c, s)
        local ____t_31 = __t
        local ____TS__Number_result_30 = __TS__Number(s.time)
        __O[1253] = ____TS__Number_result_30
        local t = if ____t_31(____TS__Number_result_30) then __O[1253] else 0
        local i = clamp(nil, s.index, 0, 2)
        local globalTime = position(nil, s)
        local bouncing = if i == 2 then math.abs(math.sin(t * 5.1)) * 11 else 0
        local actorX = if i == 0 then 625 else 615
        local actorY = 475 - bouncing
        local scale = if i == 0 then 3.45 else 3.9
        local tilt = if i == 2 then math.sin(t * 5.1) * 0.035 else 0
        local reach = if i == 1 then ease(nil, t / 1.8) else if i == 2 then 1 else 0
        c:save()
        c:translate(actorX, actorY)
        c:rotate(tilt)
        local ____t_34 = __t
        local ____opt_32 = window.Art
        if ____opt_32 ~= nil then
            ____opt_32 = ____opt_32.drawCharacter
        end
        if ____t_34(____opt_32) then
            local ____self_41 = window.Art
            local ____self_41_drawCharacter_42 = ____self_41.drawCharacter
            local ____c_40 = c
            local ____scale_38 = scale
            local ____temp_39 = if i == 2 then t * 0.8 else 0
            local ____t_37 = __t
            local ____opt_35 = s.options
            if ____opt_35 ~= nil then
                ____opt_35 = ____opt_35.trained
            end
            ____self_41_drawCharacter_42(
                ____self_41,
                ____c_40,
                "daroca",
                0,
                0,
                {
                    scale = ____scale_38,
                    facing = 1,
                    frame = ____temp_39,
                    moving = false,
                    grounded = true,
                    muscular = not not ____t_37(____opt_35),
                    attack = i == 1 and t < 1.65,
                    attackType = if i == 1 then "paper" else nil,
                    animation = "idle",
                    attackProgress = if i == 1 then 0.02 + reach * 0.16 else 0,
                    pose = if i == 0 then "offer" else nil
                }
            )
        else
            rect(
                nil,
                c,
                -45,
                -158,
                90,
                111,
                "#dd8a43"
            )
            rect(
                nil,
                c,
                -35,
                -242,
                70,
                87,
                "#d9a073"
            )
            rect(
                nil,
                c,
                -72,
                -245,
                144,
                18,
                "#e3bb65"
            )
            rect(
                nil,
                c,
                -45,
                -294,
                90,
                50,
                "#e3bb65"
            )
            rect(
                nil,
                c,
                -33,
                -47,
                24,
                47,
                "#344c58"
            )
            rect(
                nil,
                c,
                14,
                -47,
                24,
                47,
                "#344c58"
            )
        end
        if i > 0 then
            local handProgress = (0.02 + reach * 0.16) / 0.3
            local handX = 13 - 21 * handProgress
            local handY = -24 - 28 * handProgress
            local attach = ease(nil, (reach - 0.74) / 0.26)
            local localX = if i == 2 then 10 else mix(nil, handX + 4, 10, attach)
            local localY = if i == 2 then -43.8 else mix(nil, handY - 1, -43.8, attach)
            local wobble = if i == 2 then math.sin(t * 11) * 1.5 else 0
            pacifier(
                nil,
                c,
                localX * scale,
                localY * scale,
                1.65,
                wobble
            )
        end
        c:restore()
        if i == 2 then
            local words = if t < 1.55 then "GUGU…" else "DADA!"
            text(
                nil,
                c,
                words,
                239,
                333 + math.sin(t * 5) * 4,
                if t < 1.55 then 35 else 44,
                if t < 1.55 then "#fff2a0" else "#ffda50"
            )
            do
                local j = 0
                while j < 9 do
                    local x = 490 + __mod(j * 51 + globalTime * 19, 330)
                    local y = 135 + __mod(j * 31 + globalTime * 35, 175)
                    rect(
                        nil,
                        c,
                        x,
                        y,
                        4,
                        6,
                        __get(
                            __arrL({"#ffdd52", "#f36052", "#fff6c9"}, 3),
                            __mod(j, 3)
                        )
                    )
                    j = j + 1
                end
            end
            rect(
                nil,
                c,
                99,
                444,
                289,
                38,
                "#344b7a"
            )
            rect(
                nil,
                c,
                104,
                449,
                279,
                28,
                "#4489c4"
            )
            text(
                nil,
                c,
                "CHUPETA CONQUISTADA!",
                244,
                463,
                14,
                "#fff1b3"
            )
        end
        rect(
            nil,
            c,
            0,
            0,
            W,
            24,
            "#31241f"
        )
        rect(
            nil,
            c,
            0,
            520,
            W,
            20,
            "#31241f"
        )
        text(
            nil,
            c,
            "DA ROÇA · UM PRÊMIO À ALTURA DA RESENHA",
            480,
            531,
            10,
            "#e8cba4"
        )
        c:restore()
    end
    local api = __ord(
        __assign(
            {},
            original,
            {
                create = function(____, kind, options)
                    if kind == nil then
                        kind = "intro"
                    end
                    if options == nil then
                        options = {}
                    end
                    return if kind == KIND then create(nil, options) else original:create(kind, options)
                end,
                stateAt = function(____, kind, seconds, options)
                    if seconds == nil then
                        seconds = 0
                    end
                    if options == nil then
                        options = {}
                    end
                    return if kind == KIND then stateAt(nil, seconds, options) else original:stateAt(kind, seconds, options)
                end,
                timeline = function(____, kind)
                    if kind == nil then
                        kind = "intro"
                    end
                    return if __t(isEasy(nil, kind)) then position(nil, kind) else if kind == KIND then info else original:timeline(kind)
                end,
                timelinePosition = function(____, s) return if __t(isEasy(nil, s)) then position(nil, s) else original:timelinePosition(s) end,
                update = function(____, s, dt) return if __t(isEasy(nil, s)) then update(nil, s, dt) else original:update(s, dt) end,
                advance = function(____, s) return if __t(isEasy(nil, s)) then advance(nil, s) else original:advance(s) end,
                beat = function(____, s) return if __t(isEasy(nil, s)) then __assign(
                    {},
                    __get(
                        frames,
                        clamp(nil, s.index, 0, 2)
                    ),
                    {
                        index = clamp(nil, s.index, 0, 2),
                        number = clamp(nil, s.index, 0, 2) + 1,
                        total = __len(frames)
                    }
                ) else original:beat(s) end,
                draw = function(____, c, s) return if __t(isEasy(nil, s)) then draw(nil, c, s) else original:draw(c, s) end,
                anchor = function(____, s) return if __t(isEasy(nil, s)) then {
                    x = 235,
                    y = 62,
                    width = 390,
                    tail = "right",
                    speakerX = 650,
                    speakerY = 293,
                    safeBottom = 224
                } else original:anchor(s) end,
                metadata = __assign(
                    {},
                    original.metadata,
                    {[__pk(KIND)] = __call(
                        frames,
                        "map",
                        function(____, frame) return __assign({}, frame) end
                    )}
                )
            }
        ),
        "create,stateAt,timeline,timelinePosition,update,advance,beat,draw,anchor,metadata"
    )
    window.Cinematics = api
    window.EasyEnding = __ord({kind = KIND, duration = total, frames = frames, drawPacifier = pacifier}, "kind,duration,frames,drawPacifier")
end)(nil)
return ____exports
