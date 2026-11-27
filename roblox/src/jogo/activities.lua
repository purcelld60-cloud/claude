--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __le, __gt, __ge, __isInteger, __mod, __ord, __arrL, __t, __get, __set, __len = __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__isInteger, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__len
local __call, __add, __assign = __JSR.__call, __JSR.__add, __JSR.__assign
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
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
        s.aimDirection = if __t(__mod(s.shots, 2)) then -1 else 1
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
        local ____t_5 = __t
        local ____t_4 = __t
        local ____temp_3 = not __t(s)
        __O[1254] = ____temp_3
        if ____t_5(if ____t_4(____temp_3) then __O[1254] else s.done) then
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
                    s.feedback = if __t(s.shot.blocked) then "Mota: defendi! Espere o goleiro sair do canto." else "Mota: foi parar na roça! Use força dentro da faixa verde."
                end
            end
        elseif __t(s.phase == "result" and __ge(s.phaseTime, 1.05)) then
            if __t(__ge(s.goals, 3) or __ge(s.shots, s.maxShots)) then
                s.done = true
                s.success = __ge(s.goals, 3)
                s.phase = "complete"
                s.feedback = if __t(s.success) then "Mota: treino completo! Esse dash agora vai voar." else "Mota: quase! Volte e tente de novo. Craque também erra."
            else
                nextShot(nil, s)
            end
        end
    end
    local function submit(self, s, value)
        local ____opt_result_8
        if s ~= nil then
            ____opt_result_8 = s.kind
        end
        if ____opt_result_8 == "dinner" then
            return window.AmandaDinner:submit(s, value)
        end
        local ____t_13 = __t
        local ____t_12 = __t
        local ____t_10 = __t
        local ____temp_9 = not __t(s)
        __O[1255] = ____temp_9
        local ____temp_11 = if ____t_10(____temp_9) then __O[1255] else s.done
        __O[1256] = ____temp_11
        if ____t_13(if ____t_12(____temp_11) then __O[1256] else __gt(s.cooldown, 0)) then
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
            local ____t_16 = __t
            local ____t_15 = __t
            local ____temp_14 = not __isInteger(answer) or answer < 0
            __O[1257] = ____temp_14
            if ____t_16(if ____t_15(____temp_14) then __O[1257] else answer > 2) then
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
                local ____s_target_17, ____x_18 = s.target, "x"
                ____s_target_17[____x_18] = ____s_target_17[____x_18] + if __lt(aim, 0.5) then -70 else 70
                s.target.y = if __gt(s.power, 0.85) then 82 else 345
            end
            local ____s_26 = s
            local ____s_power_23 = s.power
            local ____aim_24 = aim
            local ____t_20 = __t
            local ____temp_19 = if __t(goodPower) then inside else goodPower
            __O[1258] = ____temp_19
            local ____temp_25 = if ____t_20(____temp_19) then not __t(blocked) else __O[1258]
            local ____t_22 = __t
            local ____temp_21 = if __t(goodPower) then inside else goodPower
            __O[1259] = ____temp_21
            ____s_26.shot = {
                startX = 236,
                startY = 319,
                x = 236,
                y = 319,
                power = ____s_power_23,
                aim = ____aim_24,
                goal = ____temp_25,
                blocked = if ____t_22(____temp_21) then blocked else __O[1259],
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
        local ____opt_result_29
        if s ~= nil then
            ____opt_result_29 = s.kind
        end
        if ____opt_result_29 == "dinner" then
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
            return {
                title = "ENGLISH DO MIQUEIAS",
                text = if __t(s.feedback) then s.feedback else q.prompt,
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
            actionLabel = if s.phase == "aim" then "MIRAR" else if s.phase == "power" then "CHUTAR!" else if s.phase == "complete" then "CONCLUÍDO" else "A BOLA ESTÁ NO AR…",
            choices = nil
        }
    end
    local function cancel(self, s)
        local ____t_32 = __t
        local ____t_31 = __t
        local ____temp_30 = not __t(s)
        __O[1260] = ____temp_30
        if ____t_32(if ____t_31(____temp_30) then __O[1260] else s.done) then
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
            function(____, p, i) return if __t(i) then c:lineTo(
                __get(p, 0),
                __get(p, 1)
            ) else c:moveTo(
                __get(p, 0),
                __get(p, 1)
            ) end
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
        local ____t_35 = __t
        local ____opt_33 = window.Art
        if ____opt_33 ~= nil then
            ____opt_33 = ____opt_33.drawCharacter
        end
        if ____t_35(____opt_33) then
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
                if ____type == "daroca" then "#e2a04c" else "#83a0ba"
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
    local function football(self, c, s)
        rect(
            nil,
            c,
            0,
            0,
            960,
            540,
            "#77bfe7"
        )
        rect(
            nil,
            c,
            0,
            76,
            960,
            70,
            "#cadede"
        )
        rect(
            nil,
            c,
            0,
            110,
            960,
            430,
            "#367f44"
        )
        do
            local i = 0
            while i < 8 do
                rect(
                    nil,
                    c,
                    0,
                    110 + i * 54,
                    960,
                    27,
                    if __t(__mod(i, 2)) then "#388647" else "#3c8d49"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 32 do
                local x = i * 33 - 12
                rect(
                    nil,
                    c,
                    x,
                    83,
                    20,
                    34,
                    "#25516a"
                )
                rect(
                    nil,
                    c,
                    x + 3,
                    80,
                    14,
                    8,
                    if __t(__mod(i, 3)) then "#e9d7a7" else "#885c43"
                )
                rect(
                    nil,
                    c,
                    x + 4,
                    93,
                    12,
                    16,
                    if __t(__mod(i, 2)) then "#244875" else "#ecefe3"
                )
                i = i + 1
            end
        end
        rect(
            nil,
            c,
            70,
            25,
            300,
            44,
            "#183d4c"
        )
        rect(
            nil,
            c,
            75,
            30,
            290,
            34,
            "#265268"
        )
        text(
            nil,
            c,
            "MOTA · TREINO DE CRAQUE",
            220,
            47,
            14,
            "#e6f1cd"
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({40, 302}, 2),
                    __arrL({920, 302}, 2),
                    __arrL({920, 420}, 2),
                    __arrL({40, 420}, 2),
                    __arrL({40, 302}, 2)
                },
                5
            ),
            "#d0e7ad",
            3
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({490, 305}, 2),
                    __arrL({490, 420}, 2)
                },
                2
            ),
            "#d0e7ad",
            3
        )
        local g = s.goalArea
        rect(
            nil,
            c,
            g.x - 9,
            g.y - 9,
            g.w + 18,
            g.h + 16,
            "#1c5145"
        )
        rect(
            nil,
            c,
            g.x,
            g.y,
            g.w,
            g.h,
            "#49715f"
        )
        do
            local x = g.x
            while __le(
                x,
                __add(g.x, g.w)
            ) do
                line(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x, g.y}, 2),
                            __arrL(
                                {
                                    x,
                                    __add(g.y, g.h)
                                },
                                2
                            )
                        },
                        2
                    ),
                    "#a5c2a275",
                    1
                )
                x = x + 23
            end
        end
        do
            local y = g.y
            while __le(
                y,
                __add(g.y, g.h)
            ) do
                line(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({g.x, y}, 2),
                            __arrL(
                                {
                                    __add(g.x, g.w),
                                    y
                                },
                                2
                            )
                        },
                        2
                    ),
                    "#a5c2a275",
                    1
                )
                y = y + 20
            end
        end
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL(
                        {
                            g.x - 6,
                            __add(g.y, g.h)
                        },
                        2
                    ),
                    __arrL({g.x - 6, g.y - 7}, 2),
                    __arrL(
                        {
                            __add(g.x, g.w) + 6,
                            g.y - 7
                        },
                        2
                    ),
                    __arrL(
                        {
                            __add(g.x, g.w) + 6,
                            __add(g.y, g.h)
                        },
                        2
                    )
                },
                4
            ),
            "#f8f5d9",
            7
        )
        local ____t_38 = __t
        local ____t_37 = __t
        local ____temp_36 = s.lockedKeeper ~= nil
        __O[1261] = ____temp_36
        local keeper = if ____t_38(if ____t_37(____temp_36) then s.phase == "flight" or s.phase == "result" else __O[1261]) then s.lockedKeeper else s.keeper
        local kx = g.x + keeper * g.w
        rect(
            nil,
            c,
            kx - 20,
            306,
            40,
            7,
            "#1b493340"
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
        rect(
            nil,
            c,
            kx - 31,
            260,
            14,
            11,
            "#f7f2d2"
        )
        rect(
            nil,
            c,
            kx + 16,
            260,
            14,
            11,
            "#f7f2d2"
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
                animation = if s.phase == "flight" then "paper" else "idle",
                spriteFrame = if s.phase == "flight" then 3 else 0,
                attack = s.phase == "flight",
                attackType = "paper",
                attackProgress = 0.6
            }
        )
        local ____s_lockedAim_39 = s.lockedAim
        if ____s_lockedAim_39 == nil then
            ____s_lockedAim_39 = s.aim
        end
        local aim = ____s_lockedAim_39
        local tx = g.x + aim * g.w
        local ty = g.y + 101
        local cross = if s.phase == "aim" then "#e0efad" else "#f8d786"
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({tx - 12, ty}, 2),
                    __arrL({tx + 12, ty}, 2)
                },
                2
            ),
            cross,
            2
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({tx, ty - 12}, 2),
                    __arrL({tx, ty + 12}, 2)
                },
                2
            ),
            cross,
            2
        )
        if __t(s.phase == "flight" or s.phase == "result") then
            local b = s.shot
            if __t(b) then
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
            ball(
                nil,
                c,
                236,
                319,
                s.time * 0.4,
                1.15
            )
        end
        text(
            nil,
            c,
            "MIRA: procure o canto livre",
            160,
            332,
            11,
            "#d5e7b5",
            "left"
        )
        meter(
            nil,
            c,
            160,
            348,
            630,
            aim,
            "#7cbb76"
        )
        rect(
            nil,
            c,
            160 + clamp(nil, keeper - 0.135, 0, 1) * 630,
            348,
            math.min(
                0.27,
                1 - clamp(nil, keeper - 0.135, 0, 1)
            ) * 630,
            15,
            "#d08d77"
        )
        rect(
            nil,
            c,
            160 + aim * 630 - 3,
            342,
            6,
            27,
            "#fff7d2"
        )
        text(
            nil,
            c,
            "FORÇA: acerte no verde",
            160,
            385,
            11,
            "#d5e7b5",
            "left"
        )
        meter(
            nil,
            c,
            430,
            377,
            360,
            s.power,
            "#aa7861",
            0.35,
            0.85
        )
        text(
            nil,
            c,
            tostring(s.goals) .. " / 3 GOLS",
            805,
            56,
            17,
            "#f7f0bd"
        )
        text(
            nil,
            c,
            (("CHUTE " .. tostring(math.min(s.shots + 1, s.maxShots))) .. " / ") .. tostring(s.maxShots),
            805,
            80,
            11,
            "#e1e5bf"
        )
        if s.phase == "result" then
            text(
                nil,
                c,
                if __t(s.shot.goal) then "GOLAÇO!" else if __t(s.shot.blocked) then "DEFENDEU!" else "PRA FORA!",
                475,
                92,
                34,
                if __t(s.shot.goal) then "#fff0a0" else "#f4baa1"
            )
            if __t(s.shot.goal) then
                local shake = math.sin(s.phaseTime * 35) * 4
                do
                    local i = 0
                    while i < 22 do
                        local xx = 430 + __mod(i * 47 + s.phaseTime * 24, 490)
                        local yy = 112 + __mod(i * 31 + s.phaseTime * 55, 188)
                        rect(
                            nil,
                            c,
                            xx,
                            yy,
                            4,
                            4,
                            __get(
                                __arrL({"#f4dd87", "#c8eb99", "#efb5b5"}, 3),
                                __mod(i, 3)
                            )
                        )
                        i = i + 1
                    end
                end
                line(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({g.x - 6, g.y - 7}, 2),
                            __arrL(
                                {
                                    __add(g.x, g.w) + 6,
                                    g.y - 7 + shake
                                },
                                2
                            )
                        },
                        2
                    ),
                    "#f8f5d9",
                    5
                )
            end
        end
    end
    local function quizIcon(self, c, kind, x, y, t)
        if kind == "book" then
            rect(
                nil,
                c,
                x - 35,
                y - 32,
                70,
                60,
                "#264c62"
            )
            rect(
                nil,
                c,
                x - 31,
                y - 28,
                28,
                52,
                "#e8ead2"
            )
            rect(
                nil,
                c,
                x + 3,
                y - 28,
                28,
                52,
                "#f5efd3"
            )
            rect(
                nil,
                c,
                x - 2,
                y - 32,
                4,
                63,
                "#7397a0"
            )
            do
                local j = 0
                while j < 4 do
                    rect(
                        nil,
                        c,
                        x - 26,
                        y - 18 + j * 10,
                        18,
                        2,
                        "#a0b3aa"
                    )
                    rect(
                        nil,
                        c,
                        x + 8,
                        y - 18 + j * 10,
                        18,
                        2,
                        "#a0b3aa"
                    )
                    j = j + 1
                end
            end
        elseif kind == "goal" then
            line(
                nil,
                c,
                __arrL(
                    {
                        __arrL({x - 39, y + 27}, 2),
                        __arrL({x - 39, y - 29}, 2),
                        __arrL({x + 39, y - 29}, 2),
                        __arrL({x + 39, y + 27}, 2)
                    },
                    4
                ),
                "#eaf2dd",
                5
            )
            do
                local i = -25
                while i <= 25 do
                    line(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({x + i, y - 25}, 2),
                                __arrL({x + i, y + 25}, 2)
                            },
                            2
                        ),
                        "#a0bcb0",
                        1
                    )
                    i = i + 13
                end
            end
            ball(
                nil,
                c,
                x + math.sin(t * 2) * 21,
                y + 4,
                t,
                1.4
            )
        elseif kind == "friend" then
            actor(
                nil,
                c,
                "daroca",
                x - 25,
                y + 35,
                {scale = 0.85}
            )
            actor(
                nil,
                c,
                "reeis",
                x + 26,
                y + 35,
                {scale = 0.85, facing = -1}
            )
            rect(
                nil,
                c,
                x - 5,
                y - 30,
                10,
                10,
                "#efb0ad"
            )
            rect(
                nil,
                c,
                x - 10,
                y - 34,
                9,
                8,
                "#efb0ad"
            )
            rect(
                nil,
                c,
                x + 2,
                y - 34,
                9,
                8,
                "#efb0ad"
            )
        elseif kind == "blue" then
            rect(
                nil,
                c,
                x - 31,
                y - 30,
                62,
                60,
                "#487fcb"
            )
            rect(
                nil,
                c,
                x - 24,
                y - 24,
                17,
                9,
                "#80b9ec"
            )
        else
            local ____t_42 = __t
            local ____opt_40 = window.Art
            if ____opt_40 ~= nil then
                ____opt_40 = ____opt_40.drawCake
            end
            if ____t_42(____opt_40) then
                window.Art:drawCake(c, x, y + 22)
            end
        end
    end
    local function quiz(self, c, s)
        local ____t_45 = __t
        local ____opt_43 = window.Art
        if ____opt_43 ~= nil then
            ____opt_43 = ____opt_43.drawClassroom
        end
        if ____t_45(____opt_43) then
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
            rect(
                nil,
                c,
                60,
                70,
                840,
                310,
                "#8cc1b8"
            )
        end
        rect(
            nil,
            c,
            0,
            0,
            960,
            540,
            "#142f294f"
        )
        rect(
            nil,
            c,
            180,
            55,
            600,
            335,
            "#204a46"
        )
        rect(
            nil,
            c,
            188,
            63,
            584,
            319,
            "#85bcb1"
        )
        rect(
            nil,
            c,
            193,
            68,
            574,
            309,
            "#9bcfc2"
        )
        rect(
            nil,
            c,
            201,
            76,
            558,
            3,
            "#c5e3d6"
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({215, 95}, 2),
                    __arrL({310, 75}, 2)
                },
                2
            ),
            "#d7e9df77",
            9
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({232, 121}, 2),
                    __arrL({360, 92}, 2)
                },
                2
            ),
            "#d7e9df45",
            5
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
        text(
            nil,
            c,
            "ENGLISH DO MIQUEIAS",
            480,
            98,
            22,
            "#174a47"
        )
        text(
            nil,
            c,
            "How you say…",
            480,
            134,
            13,
            "#36665c"
        )
        text(
            nil,
            c,
            __add(q.word, "?"),
            480,
            171,
            27,
            "#fff5d4"
        )
        quizIcon(
            nil,
            c,
            q.icon,
            480,
            240,
            s.time
        )
        do
            local i = 0
            while i < 3 do
                rect(
                    nil,
                    c,
                    423 + i * 40,
                    333,
                    27,
                    9,
                    if __lt(i, s.correct) then "#f6df93" else "#629c91"
                )
                rect(
                    nil,
                    c,
                    423 + i * 40,
                    333,
                    27,
                    2,
                    if __lt(i, s.correct) then "#fff1bc" else "#b4dacb"
                )
                i = i + 1
            end
        end
        if s.phase == "feedback" then
            line(
                nil,
                c,
                __arrL(
                    {
                        __arrL({703, 285}, 2),
                        __arrL({715, 300}, 2),
                        __arrL({739, 268}, 2)
                    },
                    3
                ),
                "#fff0a0",
                6
            )
            text(
                nil,
                c,
                "ALLRIGHT!",
                480,
                306,
                18,
                "#fff2bd"
            )
        elseif __t(if __t(s.feedback) then not __t(s.feedbackGood) else s.feedback) then
            line(
                nil,
                c,
                __arrL(
                    {
                        __arrL({707, 274}, 2),
                        __arrL({732, 299}, 2)
                    },
                    2
                ),
                "#ae655c",
                5
            )
            line(
                nil,
                c,
                __arrL(
                    {
                        __arrL({732, 274}, 2),
                        __arrL({707, 299}, 2)
                    },
                    2
                ),
                "#ae655c",
                5
            )
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
