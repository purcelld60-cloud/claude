--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __le, __gt, __ge, __isInteger, __mod, __ord, __arrL, __iterar, __t, __get, __set = __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__isInteger, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set
local __len, __call, __add, __assign, __bor = __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__assign, __JSR.__bor
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local function clamp(____, n, a, b)
        return math.max(
            a,
            math.min(b, n)
        )
    end
    local QUESTIONS = __arrL(
        {
            __ord(
                {
                    prompt = "ALLRIGHT! You find the caderno. What is LIVRO in english, é ou não é?",
                    choices = __arrL({"BOOK", "BALL", "BEANS"}, 3),
                    answer = 0,
                    word = "LIVRO",
                    icon = "book"
                },
                "prompt,choices,answer,word,icon"
            ),
            __ord(
                {
                    prompt = "The Mota do the gol! Choose the word GOL, beleza creuza!",
                    choices = __arrL({"GLASS", "GOAL", "GAS"}, 3),
                    answer = 1,
                    word = "GOL",
                    icon = "goal"
                },
                "prompt,choices,answer,word,icon"
            ),
            __ord(
                {
                    prompt = "Da Roça need a amigo. AMIGO is what, concorda ou sem corda?",
                    choices = __arrL({"FROG", "FLOOR", "FRIEND"}, 3),
                    answer = 2,
                    word = "AMIGO",
                    icon = "friend"
                },
                "prompt,choices,answer,word,icon"
            ),
            __ord(
                {
                    prompt = "My classroom is azul! AZUL is what, you is knowing?",
                    choices = __arrL({"BLUE", "BREAD", "BROWN"}, 3),
                    answer = 0,
                    word = "AZUL",
                    icon = "blue"
                },
                "prompt,choices,answer,word,icon"
            ),
            __ord(
                {
                    prompt = "The bolo is very bom! Choose BOLO in english, ALLRIGHT!",
                    choices = __arrL({"CAPE", "CAKE", "CABLE"}, 3),
                    answer = 1,
                    word = "BOLO",
                    icon = "cake"
                },
                "prompt,choices,answer,word,icon"
            )
        },
        5
    )
    local function create(self, kind, options)
        if options == nil then
            options = {}
        end
        if kind == "dinner" then
            return window.AmandaDinner:create(options)
        end
        if kind == "quiz" then
            return {
                kind = kind,
                options = options,
                time = 0,
                done = false,
                success = false,
                cancelled = false,
                score = 0,
                correct = 0,
                attempts = 0,
                questionIndex = 0,
                phase = "question",
                phaseTime = 0,
                cooldown = 0,
                feedback = "",
                feedbackGood = true,
                selected = nil,
                questions = QUESTIONS
            }
        end
        return {
            kind = "football",
            options = options,
            time = 0,
            done = false,
            success = false,
            cancelled = false,
            score = 0,
            phase = "aim",
            phaseTime = 0,
            cooldown = 0.15,
            aim = 0.18,
            aimDirection = 1,
            aimSpeed = 0.58,
            power = 0.05,
            powerDirection = 1,
            powerSpeed = 1.02,
            keeper = 0.5,
            lockedAim = nil,
            lockedKeeper = nil,
            target = nil,
            shot = nil,
            shots = 0,
            totalShots = 0,
            maxShots = 5,
            goals = 0,
            goalArea = {x = 548, y = 120, w = 320, h = 205},
            feedback = "Mota: mira no canto e manda essa bola pra rede!",
            feedbackGood = true
        }
    end
    local function bounce(self, s, key, direction, speed, dt)
        __set(
            s,
            key,
            __get(s, key) + __get(s, direction) * speed * dt
        )
        if __gt(
            __get(s, key),
            1
        ) then
            __set(
                s,
                key,
                2 - __get(s, key)
            )
            __set(s, direction, -1)
        elseif __lt(
            __get(s, key),
            0
        ) then
            __set(
                s,
                key,
                __TS__Number(-__get(s, key))
            )
            __set(s, direction, 1)
        end
    end
    local function nextShot(self, s)
        s.phase = "aim"
        s.phaseTime = 0
        s.cooldown = 0.18
        s.aim = __mod(0.17 + s.shots * 0.21, 1)
        s.aimDirection = __t(__mod(s.shots, 2)) and -1 or 1
        s.power = 0.05
        s.powerDirection = 1
        s.lockedAim = nil
        s.lockedKeeper = nil
        s.shot = nil
        s.target = nil
        s.feedback = "Mota: mais uma! Três gols e o treino é seu."
    end
    local function update(self, s, dt)
        local ____opt_result_2
        if s ~= nil then
            ____opt_result_2 = s.kind
        end
        if ____opt_result_2 == "dinner" then
            return window.AmandaDinner:update(s, dt)
        end
        local ____t_6 = __t
        local ____t_result_5
        local ____t_4 = __t
        local ____temp_3 = not __t(s)
        __O[1268] = ____temp_3
        if ____t_4(____temp_3) then
            ____t_result_5 = __O[1268]
        else
            ____t_result_5 = s.done
        end
        if ____t_6(____t_result_5) then
            return
        end
        s.time = s.time + math.max(0, dt)
        s.phaseTime = s.phaseTime + math.max(0, dt)
        s.cooldown = math.max(0, s.cooldown - dt)
        if s.kind == "quiz" then
            if __t(s.phase == "feedback" and __ge(s.phaseTime, 0.65)) then
                if __ge(s.correct, 3) then
                    s.done = true
                    s.success = true
                    s.phase = "complete"
                    s.feedback = "ALLRIGHT! You is aprovado, beleza creuza!"
                else
                    s.questionIndex = s.questionIndex + 1
                    s.phase = "question"
                    s.phaseTime = 0
                    s.feedback = ""
                    s.selected = nil
                end
            end
            return
        end
        if __t(s.phase == "aim" or s.phase == "power") then
            s.keeper = 0.5 + math.sin(s.time * 1.55 + 0.45) * 0.36
        end
        if s.phase == "aim" then
            bounce(
                nil,
                s,
                "aim",
                "aimDirection",
                s.aimSpeed,
                dt
            )
        elseif s.phase == "power" then
            bounce(
                nil,
                s,
                "power",
                "powerDirection",
                s.powerSpeed,
                dt
            )
        elseif s.phase == "flight" then
            local u = clamp(nil, s.phaseTime / 0.82, 0, 1)
            local ease = 1 - (1 - u) ^ 1.65
            s.shot.x = s.shot.startX + (s.target.x - s.shot.startX) * ease
            s.shot.y = s.shot.startY + (s.target.y - s.shot.startY) * ease - math.sin(u * math.pi) * (35 + s.shot.power * 45)
            s.shot.rotation = u * 12
            if u >= 1 then
                s.phase = "result"
                s.phaseTime = 0
                s.feedbackGood = s.shot.goal
                if __t(s.shot.goal) then
                    s.goals = s.goals + 1
                    s.score = s.score + (100 + math.floor((1 - math.abs(s.shot.power - 0.6)) * 40 + 0.5))
                    s.feedback = __get(
                        __arrL({"Mota: GOLAÇO! A bola pediu até autógrafo!", "Mota: É rede! O gás foi só no chute, hein!", "Mota: Tá contratado pro time da resenha!"}, 3),
                        math.min(2, s.goals - 1)
                    )
                else
                    s.feedback = __t(s.shot.blocked) and "Mota: defendi! Espere o goleiro sair do canto." or "Mota: foi parar na roça! Use força dentro da faixa verde."
                end
            end
        elseif __t(s.phase == "result" and __ge(s.phaseTime, 1.05)) then
            if __t(__ge(s.goals, 3) or __ge(s.shots, s.maxShots)) then
                s.done = true
                s.success = __ge(s.goals, 3)
                s.phase = "complete"
                s.feedback = __t(s.success) and "Mota: treino completo! Esse dash agora vai voar." or "Mota: quase! Volte e tente de novo. Craque também erra."
            else
                nextShot(nil, s)
            end
        end
    end
    local function submit(self, s, value)
        local ____opt_result_9
        if s ~= nil then
            ____opt_result_9 = s.kind
        end
        if ____opt_result_9 == "dinner" then
            return window.AmandaDinner:submit(s, value)
        end
        local ____t_15 = __t
        local ____t_result_14
        local ____t_13 = __t
        local ____t_result_12
        local ____t_11 = __t
        local ____temp_10 = not __t(s)
        __O[1269] = ____temp_10
        if ____t_11(____temp_10) then
            ____t_result_12 = __O[1269]
        else
            ____t_result_12 = s.done
        end
        __O[1270] = ____t_result_12
        if ____t_13(____t_result_12) then
            ____t_result_14 = __O[1270]
        else
            ____t_result_14 = __gt(s.cooldown, 0)
        end
        if ____t_15(____t_result_14) then
            return false
        end
        if s.kind == "quiz" then
            if s.phase ~= "question" then
                return false
            end
            local answer = __TS__Number(value)
            local q = __get(
                QUESTIONS,
                __mod(
                    s.questionIndex,
                    __len(QUESTIONS)
                )
            )
            local ____t_19 = __t
            local ____t_result_18
            local ____t_17 = __t
            local ____temp_16 = not __isInteger(answer) or answer < 0
            __O[1271] = ____temp_16
            if ____t_17(____temp_16) then
                ____t_result_18 = __O[1271]
            else
                ____t_result_18 = answer > 2
            end
            if ____t_19(____t_result_18) then
                return false
            end
            s.attempts = s.attempts + 1
            s.selected = answer
            s.cooldown = 0.25
            if answer == q.answer then
                s.correct = s.correct + 1
                s.score = s.correct
                s.phase = "feedback"
                s.phaseTime = 0
                s.feedbackGood = true
                s.feedback = "ALLRIGHT! Your answer is muito certo, beleza creuza!"
            else
                s.feedbackGood = false
                s.feedback = __add("Not this, my friend! Try de novo: ", q.prompt)
            end
            return true
        end
        if s.phase == "aim" then
            s.lockedAim = s.aim
            s.phase = "power"
            s.phaseTime = 0
            s.power = 0.05
            s.powerDirection = 1
            s.cooldown = 0.12
            s.feedback = "Mota: agora acerte a força no verde. O goleiro ainda está se mexendo!"
            return true
        end
        if s.phase == "power" then
            s.lockedKeeper = s.keeper
            s.shots = s.shots + 1
            s.totalShots = s.shots
            local aim = s.lockedAim
            local goodPower = __ge(s.power, 0.35) and __le(s.power, 0.85)
            local inside = __ge(aim, 0.04) and __le(aim, 0.96)
            local blocked = math.abs(aim - s.lockedKeeper) < 0.135
            s.target = {x = s.goalArea.x + aim * s.goalArea.w, y = s.goalArea.y + 105 - (s.power - 0.55) * 95}
            if __t(not __t(goodPower) or not __t(inside)) then
                local ____s_target_20, ____x_21 = s.target, "x"
                ____s_target_20[____x_21] = ____s_target_20[____x_21] + (__lt(aim, 0.5) and -70 or 70)
                s.target.y = __gt(s.power, 0.85) and 82 or 345
            end
            local ____s_30 = s
            local ____s_power_28 = s.power
            local ____aim_29 = aim
            local ____t_result_24
            local ____t_23 = __t
            local ____t_result_22
            if __t(goodPower) then
                ____t_result_22 = inside
            else
                ____t_result_22 = goodPower
            end
            __O[1272] = ____t_result_22
            if ____t_23(____t_result_22) then
                ____t_result_24 = not __t(blocked)
            else
                ____t_result_24 = __O[1272]
            end
            local ____t_result_27
            local ____t_26 = __t
            local ____t_result_25
            if __t(goodPower) then
                ____t_result_25 = inside
            else
                ____t_result_25 = goodPower
            end
            __O[1273] = ____t_result_25
            if ____t_26(____t_result_25) then
                ____t_result_27 = blocked
            else
                ____t_result_27 = __O[1273]
            end
            ____s_30.shot = {
                startX = 236,
                startY = 319,
                x = 236,
                y = 319,
                power = ____s_power_28,
                aim = ____aim_29,
                goal = ____t_result_24,
                blocked = ____t_result_27,
                rotation = 0
            }
            s.phase = "flight"
            s.phaseTime = 0
            s.cooldown = 0.85
            s.feedback = "Mota: vai, vai, vai…"
            return true
        end
        return false
    end
    local function view(self, s)
        local ____opt_result_33
        if s ~= nil then
            ____opt_result_33 = s.kind
        end
        if ____opt_result_33 == "dinner" then
            return window.AmandaDinner:view(s)
        end
        if not __t(s) then
            return {
                title = "",
                text = "",
                scoreLabel = "",
                actionLabel = "",
                choices = nil
            }
        end
        if s.kind == "quiz" then
            local q = __get(
                QUESTIONS,
                __mod(
                    s.questionIndex,
                    __len(QUESTIONS)
                )
            )
            local ____t_result_34
            if __t(s.feedback) then
                ____t_result_34 = s.feedback
            else
                ____t_result_34 = q.prompt
            end
            return {
                title = "ENGLISH DO MIQUEIAS",
                text = ____t_result_34,
                scoreLabel = ((tostring(s.correct) .. " / 3 acertos · ") .. tostring(s.attempts)) .. " respostas",
                actionLabel = "",
                choices = __call(
                    q.choices,
                    "map",
                    function(____, label, value) return {label = label, value = value, disabled = s.phase ~= "question"} end
                )
            }
        end
        return {
            title = "FUTEBOL COM GABRIEL MOTA",
            text = s.feedback,
            scoreLabel = ((((((tostring(s.goals) .. " / 3 gols · ") .. tostring(s.shots)) .. " / ") .. tostring(s.maxShots)) .. " chutes · ") .. tostring(s.score)) .. " pontos",
            actionLabel = s.phase == "aim" and "MIRAR" or (s.phase == "power" and "CHUTAR!" or (s.phase == "complete" and "CONCLUÍDO" or "A BOLA ESTÁ NO AR…")),
            choices = nil
        }
    end
    local function cancel(self, s)
        local ____t_38 = __t
        local ____t_result_37
        local ____t_36 = __t
        local ____temp_35 = not __t(s)
        __O[1274] = ____temp_35
        if ____t_36(____temp_35) then
            ____t_result_37 = __O[1274]
        else
            ____t_result_37 = s.done
        end
        if ____t_38(____t_result_37) then
            return
        end
        s.done = true
        s.success = false
        s.cancelled = true
        s.phase = "cancelled"
    end
    local function rect(self, c, x, y, w, h, col)
        c.fillStyle = col
        c:fillRect(
            math.floor(x + 0.5),
            math.floor(y + 0.5),
            math.floor(w + 0.5),
            math.floor(h + 0.5)
        )
    end
    local function text(self, c, t, x, y, size, col, align)
        if size == nil then
            size = 14
        end
        if col == nil then
            col = "#f8f0cb"
        end
        if align == nil then
            align = "center"
        end
        c.font = ("bold " .. tostring(size)) .. "px monospace"
        c.textAlign = align
        c.textBaseline = "middle"
        c.fillStyle = "#17362b"
        c:fillText(t, x + 1, y + 2)
        c.fillStyle = col
        c:fillText(t, x, y)
    end
    local function line(self, c, points, color, width)
        if color == nil then
            color = "#f5f0cf"
        end
        if width == nil then
            width = 2
        end
        c.strokeStyle = color
        c.lineWidth = width
        c:beginPath()
        __call(
            points,
            "forEach",
            function(____, p, i)
                local ____t_result_39
                if __t(i) then
                    ____t_result_39 = c:lineTo(
                        __get(p, 0),
                        __get(p, 1)
                    )
                else
                    ____t_result_39 = c:moveTo(
                        __get(p, 0),
                        __get(p, 1)
                    )
                end
                return ____t_result_39
            end
        )
        c:stroke()
    end
    local function ball(self, c, x, y, t, scale)
        if t == nil then
            t = 0
        end
        if scale == nil then
            scale = 1
        end
        c:save()
        c:translate(x, y)
        c:rotate(t)
        c:scale(scale, scale)
        rect(
            nil,
            c,
            -7,
            -5,
            14,
            10,
            "#fcf6db"
        )
        rect(
            nil,
            c,
            -5,
            -7,
            10,
            14,
            "#fcf6db"
        )
        rect(
            nil,
            c,
            -3,
            -3,
            6,
            6,
            "#2e4241"
        )
        rect(
            nil,
            c,
            -7,
            -1,
            3,
            3,
            "#2e4241"
        )
        rect(
            nil,
            c,
            4,
            -3,
            3,
            3,
            "#2e4241"
        )
        rect(
            nil,
            c,
            -1,
            4,
            3,
            3,
            "#2e4241"
        )
        c:restore()
    end
    local function actor(self, c, ____type, x, y, options)
        if options == nil then
            options = {}
        end
        local ____t_42 = __t
        local ____opt_40 = window.Art
        if ____opt_40 ~= nil then
            ____opt_40 = ____opt_40.drawCharacter
        end
        if ____t_42(____opt_40) then
            window.Art:drawCharacter(
                c,
                ____type,
                x,
                y,
                __assign({}, {frame = 0, facing = 1, grounded = true}, options)
            )
        else
            rect(
                nil,
                c,
                x - 12,
                y - 48,
                24,
                48,
                ____type == "daroca" and "#e2a04c" or "#83a0ba"
            )
        end
    end
    local function meter(self, c, x, y, w, value, color, greenStart, greenEnd)
        rect(
            nil,
            c,
            x - 3,
            y - 3,
            w + 6,
            21,
            "#18382a"
        )
        rect(
            nil,
            c,
            x,
            y,
            w,
            15,
            color
        )
        if greenStart ~= nil then
            rect(
                nil,
                c,
                x + greenStart * w,
                y,
                (greenEnd - greenStart) * w,
                15,
                "#b9dd7f"
            )
        end
        rect(
            nil,
            c,
            x + value * w - 3,
            y - 6,
            6,
            27,
            "#fff6cf"
        )
        rect(
            nil,
            c,
            x + value * w - 1,
            y - 3,
            2,
            21,
            "#314b33"
        )
    end
    local function P(____, c, x, y, w, h, col)
        return rect(
            nil,
            c,
            x * 2,
            y * 2,
            w * 2,
            h * 2,
            col
        )
    end
    local ROUPAS = __arrL({
        "#e8433a",
        "#3a6aa8",
        "#f2c94c",
        "#3c8a5a",
        "#c84a8a",
        "#f2f2ee",
        "#e8843a",
        "#2a2a3a"
    }, 8)
    local PELES = __arrL({
        "#f0c8a0",
        "#c48a62",
        "#8a5a3c",
        "#5a3a28",
        "#e8b88a"
    }, 5)
    local campos = {}
    local function campo(self, quadro)
        if __t(__get(campos, quadro)) then
            return __get(campos, quadro)
        end
        local PK = window.PixelKit
        local cv = window.document:createElement("canvas")
        cv.width = 480
        cv.height = 270
        local c = cv:getContext("2d")
        c.imageSmoothingEnabled = false
        local R = PK.R
        local h = PK.hash
        PK:faixas(
            c,
            0,
            0,
            480,
            30,
            __arrL({"#4a92da", "#5aa0e0", "#6eb0e8", "#86c2ee"}, 4)
        )
        for ____, x in __iterar((__arrL({10, 452}, 2))) do
            R(
                nil,
                c,
                x + 6,
                4,
                4,
                52,
                "#5a646e"
            )
            R(
                nil,
                c,
                x + 7,
                4,
                1,
                52,
                "#8a949e"
            )
            R(
                nil,
                c,
                x,
                2,
                16,
                8,
                "#3a444e"
            )
            do
                local k = 0
                while k < 4 do
                    do
                        local j = 0
                        while j < 2 do
                            R(
                                nil,
                                c,
                                x + 1 + k * 4,
                                3 + j * 3,
                                3,
                                2,
                                "#fff6c8"
                            )
                            j = j + 1
                        end
                    end
                    k = k + 1
                end
            end
        end
        R(
            nil,
            c,
            0,
            14,
            480,
            6,
            "#5a646e"
        )
        R(
            nil,
            c,
            0,
            14,
            480,
            1,
            "#8a949e"
        )
        do
            local x = 0
            while x < 480 do
                R(
                    nil,
                    c,
                    x,
                    15,
                    1,
                    5,
                    "#3a444e"
                )
                x = x + 12
            end
        end
        do
            local fila = 0
            while fila < 4 do
                local y = 20 + fila * 9
                R(
                    nil,
                    c,
                    0,
                    y + 7,
                    480,
                    2,
                    "#9aa0a6"
                )
                R(
                    nil,
                    c,
                    0,
                    y,
                    480,
                    7,
                    __t(__mod(fila, 2)) and "#5a6470" or "#4a545e"
                )
                do
                    local k = 0
                    while k < 70 do
                        do
                            local x = k * 7 + __mod(fila, 2) * 3 + math.floor(h(nil, k + fila * 70) * 2 + 0.5)
                            local pula = quadro == 1 and __mod(k + fila, 3) == 0
                            local braco = __mod(k * 7 + fila, 5) == 0
                            if __lt(
                                h(nil, k * 3 + fila),
                                0.12
                            ) then
                                do k = k + 1 continue end
                            end
                            local ____PK_pessoa_45 = PK.pessoa
                            local ____array_44 = __TS__SparseArrayNew(
                                c,
                                x,
                                y - 1,
                                __get(
                                    PELES,
                                    __mod(k + fila, 5)
                                ),
                                __get(
                                    ROUPAS,
                                    __mod(k * 3 + fila, 8)
                                ),
                                "#1c1410",
                                pula
                            )
                            local ____t_result_43
                            if __t(braco) then
                                ____t_result_43 = quadro == 1
                            else
                                ____t_result_43 = braco
                            end
                            __TS__SparseArrayPush(____array_44, ____t_result_43)
                            ____PK_pessoa_45(
                                PK,
                                __TS__SparseArraySpread(____array_44)
                            )
                        end
                        k = k + 1
                    end
                end
                fila = fila + 1
            end
        end
        local placas = __arrL(
            {
                __arrL({"CACAU DA ROÇA", "#c43c3a", "#fff2c0"}, 3),
                __arrL({"ITABUNA", "#2c5a9e", "#ffffff"}, 3),
                __arrL({"GÁS DO PAI", "#f2c94c", "#3a2a0a"}, 3),
                __arrL({"ESCOLA", "#3c8a5a", "#ffffff"}, 3)
            },
            4
        )
        do
            local k = 0
            while k < 6 do
                local txt, f, cor = table.unpack(
                    __get(
                        placas,
                        __mod(k, 4)
                    ),
                    1,
                    3
                )
                local x = k * 80
                R(
                    nil,
                    c,
                    x,
                    56,
                    79,
                    8,
                    f
                )
                R(
                    nil,
                    c,
                    x,
                    56,
                    79,
                    1,
                    "rgba(255,255,255,.35)"
                )
                R(
                    nil,
                    c,
                    x + 79,
                    56,
                    1,
                    8,
                    "#1c1c1c"
                )
                PK:texto(
                    c,
                    txt,
                    x + 40,
                    60,
                    8,
                    cor,
                    "center",
                    nil
                )
                k = k + 1
            end
        end
        do
            local y = 64
            while y < 270 do
                local k = math.floor((y - 64) / 10)
                R(
                    nil,
                    c,
                    0,
                    y,
                    480,
                    10,
                    __t(__mod(k, 2)) and "#3a8a48" or "#348042"
                )
                y = y + 10
            end
        end
        do
            local i = 0
            while i < 2600 do
                local x = h(nil, i * 0.77) * 480
                local y = 64 + h(nil, i * 1.31) * 206
                R(
                    nil,
                    c,
                    x,
                    y,
                    1,
                    1,
                    __t(__mod(i, 3)) and "#2c7038" or "#4a9a54"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 90 do
                local x = h(nil, i * 4.1) * 480
                local y = 70 + h(nil, i * 2.7) * 196
                R(
                    nil,
                    c,
                    x,
                    y - 2,
                    1,
                    2,
                    "#5aaa5a"
                )
                R(
                    nil,
                    c,
                    x + 1,
                    y - 1,
                    1,
                    1,
                    "#5aaa5a"
                )
                i = i + 1
            end
        end
        local function giz(____, x, y, w, hh)
            do
                local xx = 0
                while __lt(xx, w) do
                    do
                        local yy = 0
                        while __lt(yy, hh) do
                            if __gt(
                                h(nil, x + xx + (y + yy) * 7),
                                0.12
                            ) then
                                R(
                                    nil,
                                    c,
                                    x + xx,
                                    y + yy,
                                    1,
                                    1,
                                    "#e8f2d8"
                                )
                            end
                            yy = yy + 1
                        end
                    end
                    xx = xx + 1
                end
            end
        end
        giz(
            nil,
            20,
            151,
            440,
            1
        )
        giz(
            nil,
            20,
            210,
            440,
            1
        )
        giz(
            nil,
            20,
            151,
            1,
            60
        )
        giz(
            nil,
            459,
            151,
            1,
            60
        )
        giz(
            nil,
            245,
            152,
            1,
            58
        )
        R(
            nil,
            c,
            116,
            161,
            3,
            1,
            "#e8f2d8"
        )
        return __set(campos, quadro, cv)
    end
    local redeCv = nil
    local function rede(self)
        if __t(redeCv) then
            return redeCv
        end
        local PK = window.PixelKit
        redeCv = window.document:createElement("canvas")
        redeCv.width = 160
        redeCv.height = 103
        local c = redeCv:getContext("2d")
        c.imageSmoothingEnabled = false
        do
            local y = 0
            while y < 103 do
                do
                    local x = 0
                    while x < 160 do
                        if __t(__mod(x + y, 6) == 0 or __mod(x - y + 600, 6) == 0) then
                            PK:R(
                                c,
                                x,
                                y,
                                1,
                                1,
                                "rgba(235,240,230,.55)"
                            )
                        end
                        x = x + 1
                    end
                end
                y = y + 1
            end
        end
        return redeCv
    end
    local function football(self, c, s)
        local PK = window.PixelKit
        if not __t(PK) then
            rect(
                nil,
                c,
                0,
                0,
                960,
                540,
                "#367f44"
            )
            return
        end
        c:drawImage(
            campo(
                nil,
                __mod(
                    math.floor(s.time * 2.5),
                    2
                )
            ),
            0,
            0,
            480,
            270,
            0,
            0,
            960,
            540
        )
        do
            local k = 0
            while k < 4 do
                local ph = __mod(s.time * 1.3 + k * 0.37, 1)
                if ph < 0.06 then
                    P(
                        nil,
                        c,
                        math.floor(PK:hash(k + math.floor(s.time * 1.3)) * 470 + 0.5),
                        22 + math.floor(PK:hash(k * 3 + math.floor(s.time * 1.3)) * 30 + 0.5),
                        2,
                        2,
                        "#ffffff"
                    )
                end
                k = k + 1
            end
        end
        for ____, fx in __iterar((__arrL({60, 410}, 2))) do
            P(
                nil,
                c,
                fx,
                24,
                1,
                14,
                "#c8c8c0"
            )
            do
                local y = 0
                while y < 6 do
                    P(
                        nil,
                        c,
                        fx + 1,
                        24 + y,
                        8 + math.floor(math.sin(s.time * 6 + y * 0.6) * 1.5 + 0.5),
                        1,
                        y < 3 and "#2c5a9e" or "#f2c94c"
                    )
                    y = y + 1
                end
            end
        end
        local g = s.goalArea
        local gx = g.x / 2
        local gy = g.y / 2
        local gw = g.w / 2
        local gh = g.h / 2
        local ____t_result_52
        local ____t_51 = __t
        local ____t_result_50
        local ____t_47 = __t
        local ____temp_46 = s.phase == "result"
        __O[1275] = ____temp_46
        if ____t_47(____temp_46) then
            local ____opt_48 = s.shot
            if ____opt_48 ~= nil then
                ____opt_48 = ____opt_48.goal
            end
            ____t_result_50 = ____opt_48
        else
            ____t_result_50 = __O[1275]
        end
        if ____t_51(____t_result_50) then
            ____t_result_52 = math.max(0, 1 - s.phaseTime * 1.6)
        else
            ____t_result_52 = 0
        end
        local tremendo = ____t_result_52
        P(
            nil,
            c,
            gx - 2,
            gy - 2,
            gw + 4,
            gh + 3,
            "rgba(10,30,20,.25)"
        )
        if tremendo > 0 then
            do
                local k = 0
                while k < 8 do
                    local y0 = math.floor(gh * k / 8)
                    local hh = math.ceil(gh / 8)
                    local dx = math.floor(math.sin(s.phaseTime * 30 + k) * 3 * tremendo + 0.5)
                    c:drawImage(
                        rede(nil),
                        0,
                        y0,
                        160,
                        hh,
                        (gx + dx) * 2,
                        (gy + y0) * 2,
                        320,
                        hh * 2
                    )
                    k = k + 1
                end
            end
        else
            c:drawImage(
                rede(nil),
                0,
                0,
                160,
                103,
                gx * 2,
                gy * 2,
                320,
                206
            )
        end
        P(
            nil,
            c,
            gx - 4,
            gy - 4,
            3,
            gh + 4,
            "#f2f2ee"
        )
        P(
            nil,
            c,
            gx - 2,
            gy - 4,
            1,
            gh + 4,
            "#c8c8c0"
        )
        P(
            nil,
            c,
            gx + gw + 1,
            gy - 4,
            3,
            gh + 4,
            "#f2f2ee"
        )
        P(
            nil,
            c,
            gx + gw + 3,
            gy - 4,
            1,
            gh + 4,
            "#c8c8c0"
        )
        P(
            nil,
            c,
            gx - 4,
            gy - 4,
            gw + 8,
            3,
            "#f2f2ee"
        )
        P(
            nil,
            c,
            gx - 4,
            gy - 2,
            gw + 8,
            1,
            "#c8c8c0"
        )
        P(
            nil,
            c,
            gx - 3,
            gy + gh,
            gw + 6,
            1,
            "rgba(0,0,0,.25)"
        )
        local ____t_result_57
        local ____t_56 = __t
        local ____t_result_55
        local ____t_54 = __t
        local ____temp_53 = s.lockedKeeper ~= nil
        __O[1276] = ____temp_53
        if ____t_54(____temp_53) then
            ____t_result_55 = s.phase == "flight" or s.phase == "result"
        else
            ____t_result_55 = __O[1276]
        end
        if ____t_56(____t_result_55) then
            ____t_result_57 = s.lockedKeeper
        else
            ____t_result_57 = s.keeper
        end
        local keeper = ____t_result_57
        local kx = g.x + keeper * g.w
        rect(
            nil,
            c,
            kx - 20,
            312,
            40,
            6,
            "#1b493355"
        )
        actor(
            nil,
            c,
            "mota",
            kx,
            315,
            {
                frame = s.time,
                scale = 1.18,
                facing = -1,
                moving = s.phase == "aim" or s.phase == "power",
                speed = 60
            }
        )
        P(
            nil,
            c,
            (kx - 31) / 2,
            130,
            7,
            6,
            "#f7f2d2"
        )
        P(
            nil,
            c,
            (kx - 31) / 2,
            130,
            7,
            1,
            "#ffffff"
        )
        P(
            nil,
            c,
            (kx + 16) / 2,
            130,
            7,
            6,
            "#f7f2d2"
        )
        P(
            nil,
            c,
            (kx + 16) / 2,
            130,
            7,
            1,
            "#ffffff"
        )
        actor(
            nil,
            c,
            "daroca",
            193,
            325,
            {
                frame = s.time,
                muscular = not not __t(s.options.trained),
                animation = s.phase == "flight" and "paper" or "idle",
                spriteFrame = s.phase == "flight" and 3 or 0,
                attack = s.phase == "flight",
                attackType = "paper",
                attackProgress = 0.6
            }
        )
        local ____s_lockedAim_58 = s.lockedAim
        if ____s_lockedAim_58 == nil then
            ____s_lockedAim_58 = s.aim
        end
        local aim = ____s_lockedAim_58
        local tx = math.floor((g.x + aim * g.w) / 2 + 0.5)
        local ty = math.floor((g.y + 101) / 2 + 0.5)
        local cm = s.phase == "aim" and "#e0ff8a" or "#ffd24a"
        P(
            nil,
            c,
            tx - 6,
            ty,
            4,
            1,
            cm
        )
        P(
            nil,
            c,
            tx + 3,
            ty,
            4,
            1,
            cm
        )
        P(
            nil,
            c,
            tx,
            ty - 6,
            1,
            4,
            cm
        )
        P(
            nil,
            c,
            tx,
            ty + 3,
            1,
            4,
            cm
        )
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({-5, -5}, 2),
                __arrL({4, -5}, 2),
                __arrL({-5, 4}, 2),
                __arrL({4, 4}, 2)
            },
            4
        ))) do
            local dx = ____value[1]
            local dy = ____value[2]
            P(
                nil,
                c,
                tx + dx,
                ty + dy,
                2,
                1,
                cm
            )
            P(
                nil,
                c,
                tx + dx + (dx < 0 and 0 or 1),
                ty + dy + (dy < 0 and 0 or 0),
                1,
                2,
                cm
            )
        end
        if __t(s.phase == "flight" or s.phase == "result") then
            local b = s.shot
            if __t(b) then
                P(
                    nil,
                    c,
                    math.floor(b.x / 2 + 0.5) - 4,
                    math.floor(math.max(b.y, b.startY) / 2 + 0.5) + 5,
                    8,
                    2,
                    "rgba(0,0,0,.25)"
                )
                ball(
                    nil,
                    c,
                    b.x,
                    b.y,
                    b.rotation,
                    1.15
                )
            end
        else
            P(
                nil,
                c,
                114,
                164,
                8,
                2,
                "rgba(0,0,0,.25)"
            )
            ball(
                nil,
                c,
                236,
                319,
                s.time * 0.4,
                1.15
            )
        end
        PK:painel(
            c,
            20,
            14,
            408,
            44,
            {u = 2, fundo = "#13283a", borda = "#e8d8a0", rebite = "#c8a848"}
        )
        PK:texto(
            c,
            "MOTA · TREINO DE CRAQUE",
            224,
            36,
            16,
            "#fff2c0"
        )
        PK:painel(
            c,
            696,
            10,
            248,
            72,
            {u = 2, fundo = "#0a0a12", borda = "#5a646e", rebite = "#9aa0a6"}
        )
        PK:texto(
            c,
            "GOLS",
            758,
            32,
            16,
            "#9aa0a6"
        )
        PK:texto(
            c,
            tostring(s.goals) .. "/3",
            758,
            58,
            24,
            "#ffd24a"
        )
        PK:texto(
            c,
            "CHUTE",
            878,
            32,
            16,
            "#9aa0a6"
        )
        PK:texto(
            c,
            (tostring(math.min(s.shots + 1, s.maxShots)) .. "/") .. tostring(s.maxShots),
            878,
            58,
            24,
            "#7af07a"
        )
        do
            local k = 0
            while __lt(k, s.maxShots) do
                local feito = __lt(k, s.shots)
                P(
                    nil,
                    c,
                    363 + k * 5,
                    36,
                    3,
                    3,
                    __t(feito) and "#f2f2ee" or "#2a2a3a"
                )
                k = k + 1
            end
        end
        PK:painel(
            c,
            140,
            326,
            680,
            80,
            {u = 2, fundo = "#14281e", borda = "#a8c878", sombra = true}
        )
        PK:texto(
            c,
            "MIRA",
            158,
            349,
            16,
            "#d5e7b5",
            "left"
        )
        local kz = __arrL(
            {
                math.max(0, keeper - 0.135),
                math.min(1, keeper + 0.135)
            },
            2
        )
        PK:barra(
            c,
            252,
            340,
            548,
            16,
            aim,
            {
                u = 2,
                gomos = 40,
                ruim = kz,
                ruimCor = "#c86a5a",
                vazio = "#3a6a4a",
                marcador = "#fff7d2"
            }
        )
        PK:texto(
            c,
            "FORÇA",
            158,
            385,
            16,
            "#d5e7b5",
            "left"
        )
        PK:barra(
            c,
            252,
            376,
            548,
            16,
            s.power,
            {
                u = 2,
                gomos = 40,
                zona = __arrL({0.35, 0.85}, 2),
                zonaCor = "#8ad86a",
                vazio = "#7a4a3a",
                marcador = "#fff7d2"
            }
        )
        local ____t_62 = __t
        local ____t_result_61
        local ____t_60 = __t
        local ____temp_59 = s.phase == "result"
        __O[1277] = ____temp_59
        if ____t_60(____temp_59) then
            ____t_result_61 = s.shot
        else
            ____t_result_61 = __O[1277]
        end
        if ____t_62(____t_result_61) then
            local txt = __t(s.shot.goal) and "GOLAÇO!" or (__t(s.shot.blocked) and "DEFENDEU!" or "PRA FORA!")
            PK:contorno(
                c,
                txt,
                480,
                100,
                32,
                __t(s.shot.goal) and "#fff0a0" or "#f4baa1",
                "#1c1410"
            )
            if __t(s.shot.goal) then
                do
                    local i = 0
                    while i < 26 do
                        local xx = 430 + __mod(i * 47 + s.phaseTime * 24, 490)
                        local yy = 112 + __mod(i * 31 + s.phaseTime * 55, 188)
                        P(
                            nil,
                            c,
                            math.floor(xx / 2 + 0.5),
                            math.floor(yy / 2 + 0.5),
                            2,
                            2,
                            __get(
                                __arrL({"#f4dd87", "#c8eb99", "#efb5b5", "#9ad0ff"}, 4),
                                __mod(i, 4)
                            )
                        )
                        i = i + 1
                    end
                end
            end
        end
    end
    local lousaCv = nil
    local function lousa(self)
        if __t(lousaCv) then
            return lousaCv
        end
        local PK = window.PixelKit
        local R = PK.R
        local h = PK.hash
        lousaCv = window.document:createElement("canvas")
        lousaCv.width = 304
        lousaCv.height = 172
        local c = lousaCv:getContext("2d")
        c.imageSmoothingEnabled = false
        R(
            nil,
            c,
            0,
            0,
            304,
            164,
            "#5a3a22"
        )
        do
            local x = 0
            while x < 304 do
                if __gt(
                    h(nil, x * 1.7),
                    0.55
                ) then
                    R(
                        nil,
                        c,
                        x,
                        1 + h(nil, x) * 3,
                        2,
                        1,
                        "#7a5232"
                    )
                end
                x = x + 3
            end
        end
        R(
            nil,
            c,
            0,
            0,
            304,
            1,
            "#8a5a36"
        )
        R(
            nil,
            c,
            4,
            4,
            296,
            152,
            "#2a4636"
        )
        do
            local i = 0
            while i < 1400 do
                R(
                    nil,
                    c,
                    4 + h(nil, i * 0.91) * 295,
                    4 + h(nil, i * 1.73) * 151,
                    1,
                    1,
                    __t(__mod(i, 3)) and "#304e3e" or "#26402f"
                )
                i = i + 1
            end
        end
        do
            local k = 0
            while k < 9 do
                local x = 20 + h(nil, k * 5.1) * 250
                local y = 14 + h(nil, k * 2.3) * 120
                local w = 20 + h(nil, k) * 40
                do
                    local j = 0
                    while j < 4 do
                        do
                            local xx = 0
                            while xx < w do
                                if __gt(
                                    h(nil, xx + j * 9 + k),
                                    0.5
                                ) then
                                    R(
                                        nil,
                                        c,
                                        x + xx,
                                        y + j * 2,
                                        2,
                                        1,
                                        "rgba(200,220,210,.10)"
                                    )
                                end
                                xx = xx + 2
                            end
                        end
                        j = j + 1
                    end
                end
                k = k + 1
            end
        end
        R(
            nil,
            c,
            0,
            156,
            304,
            8,
            "#7a5232"
        )
        R(
            nil,
            c,
            0,
            156,
            304,
            1,
            "#9a7248"
        )
        R(
            nil,
            c,
            2,
            164,
            300,
            4,
            "#4a2c18"
        )
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({40, "#f2f2ee"}, 2),
                __arrL({52, "#f2e27a"}, 2),
                __arrL({61, "#f2a8c8"}, 2),
                __arrL({250, "#f2f2ee"}, 2)
            },
            4
        ))) do
            local x = ____value[1]
            local cor = ____value[2]
            R(
                nil,
                c,
                x,
                153,
                8,
                3,
                cor
            )
        end
        R(
            nil,
            c,
            210,
            151,
            22,
            5,
            "#8a6a4a"
        )
        R(
            nil,
            c,
            210,
            154,
            22,
            2,
            "#d8d0c0"
        )
        return lousaCv
    end
    local function giz(self, c, x, y, w, h, cor)
        if cor == nil then
            cor = "rgba(245,248,240,.92)"
        end
        local PK = window.PixelKit
        do
            local xx = 0
            while __lt(xx, w) do
                do
                    local yy = 0
                    while __lt(yy, h) do
                        if __gt(
                            PK:hash((x + xx) * 3.1 + (y + yy) * 7.7),
                            0.14
                        ) then
                            P(
                                nil,
                                c,
                                x + xx,
                                y + yy,
                                1,
                                1,
                                cor
                            )
                        end
                        yy = yy + 1
                    end
                end
                xx = xx + 1
            end
        end
    end
    local function quizIcon(self, c, kind, x, y, t)
        x = math.floor(x / 2 + 0.5)
        y = math.floor(y / 2 + 0.5)
        if kind == "book" then
            giz(
                nil,
                c,
                x - 16,
                y - 12,
                32,
                1
            )
            giz(
                nil,
                c,
                x - 16,
                y + 10,
                32,
                1
            )
            giz(
                nil,
                c,
                x - 16,
                y - 12,
                1,
                23
            )
            giz(
                nil,
                c,
                x + 15,
                y - 12,
                1,
                23
            )
            giz(
                nil,
                c,
                x,
                y - 12,
                1,
                23
            )
            do
                local j = 0
                while j < 4 do
                    giz(
                        nil,
                        c,
                        x - 12,
                        y - 7 + j * 4,
                        9,
                        1,
                        "rgba(245,248,240,.6)"
                    )
                    giz(
                        nil,
                        c,
                        x + 4,
                        y - 7 + j * 4,
                        9,
                        1,
                        "rgba(245,248,240,.6)"
                    )
                    j = j + 1
                end
            end
        elseif kind == "goal" then
            giz(
                nil,
                c,
                x - 18,
                y - 12,
                1,
                24
            )
            giz(
                nil,
                c,
                x + 17,
                y - 12,
                1,
                24
            )
            giz(
                nil,
                c,
                x - 18,
                y - 12,
                36,
                1
            )
            do
                local i = -12
                while i <= 12 do
                    giz(
                        nil,
                        c,
                        x + i,
                        y - 10,
                        1,
                        21,
                        "rgba(245,248,240,.45)"
                    )
                    i = i + 6
                end
            end
            ball(
                nil,
                c,
                (x + math.sin(t * 2) * 10) * 2,
                (y + 4) * 2,
                t,
                1.2
            )
        elseif kind == "friend" then
            for ____, dx in __iterar((__arrL({-10, 10}, 2))) do
                giz(
                    nil,
                    c,
                    x + dx - 2,
                    y - 12,
                    5,
                    5
                )
                giz(
                    nil,
                    c,
                    x + dx,
                    y - 7,
                    1,
                    10
                )
                giz(
                    nil,
                    c,
                    x + dx - 4,
                    y - 4,
                    9,
                    1
                )
                giz(
                    nil,
                    c,
                    x + dx - 3,
                    y + 3,
                    1,
                    6
                )
                giz(
                    nil,
                    c,
                    x + dx + 3,
                    y + 3,
                    1,
                    6
                )
            end
            P(
                nil,
                c,
                x - 2,
                y - 14,
                2,
                2,
                "#f2a8c8"
            )
            P(
                nil,
                c,
                x + 1,
                y - 14,
                2,
                2,
                "#f2a8c8"
            )
            P(
                nil,
                c,
                x - 2,
                y - 12,
                5,
                2,
                "#f2a8c8"
            )
            P(
                nil,
                c,
                x - 1,
                y - 10,
                3,
                1,
                "#f2a8c8"
            )
        elseif kind == "blue" then
            do
                local yy = -11
                while yy <= 11 do
                    giz(
                        nil,
                        c,
                        x - 14,
                        y + yy,
                        28,
                        1,
                        "rgba(110,160,230,.9)"
                    )
                    yy = yy + 2
                end
            end
            giz(
                nil,
                c,
                x - 14,
                y - 12,
                28,
                1
            )
        else
            giz(
                nil,
                c,
                x - 14,
                y - 2,
                28,
                1
            )
            giz(
                nil,
                c,
                x - 14,
                y + 10,
                28,
                1
            )
            giz(
                nil,
                c,
                x - 14,
                y - 2,
                1,
                13
            )
            giz(
                nil,
                c,
                x + 13,
                y - 2,
                1,
                13
            )
            giz(
                nil,
                c,
                x - 10,
                y - 8,
                20,
                1
            )
            giz(
                nil,
                c,
                x - 10,
                y - 8,
                1,
                6
            )
            giz(
                nil,
                c,
                x + 9,
                y - 8,
                1,
                6
            )
            giz(
                nil,
                c,
                x - 14,
                y + 4,
                28,
                1,
                "rgba(242,168,200,.9)"
            )
            giz(
                nil,
                c,
                x,
                y - 14,
                1,
                6,
                "rgba(242,226,122,.95)"
            )
            if math.sin(t * 8) > 0 then
                P(
                    nil,
                    c,
                    x,
                    y - 16,
                    1,
                    2,
                    "#ffb040"
                )
            end
        end
    end
    local function quiz(self, c, s)
        local PK = window.PixelKit
        local ____t_65 = __t
        local ____opt_63 = window.Art
        if ____opt_63 ~= nil then
            ____opt_63 = ____opt_63.drawClassroom
        end
        if ____t_65(____opt_63) then
            window.Art:drawClassroom(c, "miqueias", s.time)
        else
            rect(
                nil,
                c,
                0,
                0,
                960,
                540,
                "#e5e9dd"
            )
        end
        rect(
            nil,
            c,
            0,
            0,
            960,
            540,
            "#142f2940"
        )
        if not __t(PK) then
            rect(
                nil,
                c,
                180,
                55,
                600,
                335,
                "#204a46"
            )
            return
        end
        c:drawImage(
            lousa(nil),
            0,
            0,
            304,
            172,
            176,
            46,
            608,
            344
        )
        actor(
            nil,
            c,
            "miqueias",
            105,
            360,
            {frame = s.time, scale = 1.1, talking = true}
        )
        actor(
            nil,
            c,
            "daroca",
            861,
            360,
            {
                frame = s.time,
                scale = 1.05,
                muscular = not not __t(s.options.trained)
            }
        )
        local q = __get(
            QUESTIONS,
            __mod(
                s.questionIndex,
                __len(QUESTIONS)
            )
        )
        PK:texto(
            c,
            "ENGLISH DO MIQUEIAS",
            480,
            88,
            16,
            "#f2f2ea",
            "center",
            "#1a2e24"
        )
        PK:texto(
            c,
            "How you say...",
            480,
            124,
            16,
            "#b8d8c8",
            "center",
            "#1a2e24"
        )
        PK:texto(
            c,
            __add(q.word, "?"),
            480,
            162,
            32,
            "#f2e27a",
            "center",
            "#1a2e24"
        )
        quizIcon(
            nil,
            c,
            q.icon,
            480,
            244,
            s.time
        )
        do
            local i = 0
            while i < 3 do
                local x = 228 + i * 14
                local y = 166
                local on = __lt(i, s.correct)
                local cor = __t(on) and "#f2e27a" or "rgba(245,248,240,.35)"
                P(
                    nil,
                    c,
                    x,
                    y - 3,
                    1,
                    7,
                    cor
                )
                P(
                    nil,
                    c,
                    x - 3,
                    y,
                    7,
                    1,
                    cor
                )
                P(
                    nil,
                    c,
                    x - 1,
                    y - 1,
                    3,
                    3,
                    cor
                )
                P(
                    nil,
                    c,
                    x - 2,
                    y - 2,
                    1,
                    1,
                    cor
                )
                P(
                    nil,
                    c,
                    x + 2,
                    y - 2,
                    1,
                    1,
                    cor
                )
                P(
                    nil,
                    c,
                    x - 2,
                    y + 2,
                    1,
                    1,
                    cor
                )
                P(
                    nil,
                    c,
                    x + 2,
                    y + 2,
                    1,
                    1,
                    cor
                )
                i = i + 1
            end
        end
        if s.phase == "feedback" then
            do
                local k = 0
                while k < 8 do
                    local ____c_68 = c
                    local ____temp_69 = 352 + k
                    local ____bor_67 = __bor
                    local ____temp_66
                    if k < 3 then
                        ____temp_66 = k
                    else
                        ____temp_66 = 3 - (k - 3) * 1.6
                    end
                    P(
                        nil,
                        ____c_68,
                        ____temp_69,
                        ____bor_67(146 + ____temp_66, 0),
                        2,
                        2,
                        "#9aff9a"
                    )
                    k = k + 1
                end
            end
            PK:texto(
                c,
                "ALLRIGHT!",
                480,
                314,
                16,
                "#9aff9a",
                "center",
                "#1a2e24"
            )
        else
            local ____t_71 = __t
            local ____t_result_70
            if __t(s.feedback) then
                ____t_result_70 = not __t(s.feedbackGood)
            else
                ____t_result_70 = s.feedback
            end
            if ____t_71(____t_result_70) then
                do
                    local k = 0
                    while k < 12 do
                        P(
                            nil,
                            c,
                            350 + k,
                            136 + k,
                            2,
                            2,
                            "#ff9a8a"
                        )
                        P(
                            nil,
                            c,
                            361 - k,
                            136 + k,
                            2,
                            2,
                            "#ff9a8a"
                        )
                        k = k + 1
                    end
                end
            end
        end
    end
    local function draw(self, c, s)
        if not __t(s) then
            return
        end
        if s.kind == "dinner" then
            return window.AmandaArt:drawDinner(c, s)
        end
        c:save()
        c.imageSmoothingEnabled = false
        if s.kind == "quiz" then
            quiz(nil, c, s)
        else
            football(nil, c, s)
        end
        c:restore()
    end
    window.Activities = __ord({
        create = create,
        update = update,
        submit = submit,
        view = view,
        draw = draw,
        cancel = cancel
    }, "create,update,submit,view,draw,cancel")
end)(nil)
return ____exports
