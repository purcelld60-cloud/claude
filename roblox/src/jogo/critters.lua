--!native
--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __le, __gt, __ge, __getq, __mod, __ord, __arrL, __iterar, __t, __get, __len = __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__getq, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__len
local __call, __add, __hypot = __JSR.__call, __JSR.__add, __JSR.__hypot
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local __TS__MathSign = ____lualib.__TS__MathSign
local __TS__Iterator = ____lualib.__TS__Iterator
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local FLOOR = 440
    local GRAV = 900
    local function clamp(____, v, a, b)
        return math.max(
            a,
            math.min(b, v)
        )
    end
    local function hash(____, i)
        local x = math.sin(i * 91.7 + 17.3) * 43758.5453
        return x - math.floor(x)
    end
    local function R(____, c, x, y, w, h, col)
        c.fillStyle = col
        c:fillRect(
            math.floor(x + 0.5),
            math.floor(y + 0.5),
            w,
            h
        )
    end
    local PLAN = {
        ["0"] = __arrL(
            {
                __arrL({"chicken", 420, 0.8}, 3),
                __arrL({"butterfly", 360, 0.7}, 3),
                __arrL({"sparrow", 380, 0.85}, 3)
            },
            3
        ),
        ["1"] = __arrL(
            {
                __arrL({"pigeon", 520, 0.7}, 3),
                __arrL({"can", 900, 0.6}, 3),
                __arrL({"sparrow", 640, 0.7}, 3)
            },
            3
        ),
        ["3"] = __arrL(
            {
                __arrL({"ball", 1400, 1}, 3),
                __arrL({"butterfly", 700, 0.4}, 3),
                __arrL({"sparrow", 420, 0.85}, 3)
            },
            3
        ),
        ["4"] = __arrL(
            {
                __arrL({"pigeon", 380, 0.9}, 3),
                __arrL({"butterfly", 600, 0.5}, 3),
                __arrL({"can", 1000, 0.5}, 3)
            },
            3
        ),
        ["5"] = __arrL(
            {
                __arrL({"pigeon", 600, 0.6}, 3),
                __arrL({"dog", 1500, 0.9}, 3),
                __arrL({"cat", 1300, 0.8}, 3),
                __arrL({"kite", 700, 0.8}, 3),
                __arrL({"can", 800, 0.6}, 3)
            },
            5
        ),
        ["7"] = __arrL(
            {
                __arrL({"ball", 2000, 1}, 3),
                __arrL({"butterfly", 500, 0.6}, 3),
                __arrL({"sparrow", 450, 0.9}, 3)
            },
            3
        ),
        ["9"] = __arrL(
            {
                __arrL({"pigeon", 600, 0.8}, 3),
                __arrL({"can", 900, 0.5}, 3),
                __arrL({"sparrow", 560, 0.7}, 3)
            },
            3
        )
    }
    local scene = -1
    local list = __arrL({}, 0)
    local worldW = 4800
    local function build(self, sc)
        scene = sc
        list = __arrL({}, 0)
        local ____t_6 = __t
        local ____t_4 = __t
        local ____getq_2 = __getq
        local ____opt_0 = window.WorldData
        if ____opt_0 ~= nil then
            ____opt_0 = ____opt_0.widths
        end
        local ____TS__Number_result_3 = __TS__Number(____getq_2(____opt_0, sc))
        __O[1498] = ____TS__Number_result_3
        local ____temp_5 = if ____t_4(____TS__Number_result_3) then __O[1498] else __get(
            __arrL({
                4800,
                6200,
                5000,
                5200,
                6000,
                7200,
                6600,
                4800,
                3600,
                4200,
                3600,
                4800
            }, 12),
            sc
        )
        __O[1499] = ____temp_5
        worldW = if ____t_6(____temp_5) then __O[1499] else 4800
        local plan = __get(PLAN, sc)
        if not __t(plan) then
            return
        end
        local ____t_12 = __t
        local ____opt_9 = window.Graphics
        if ____opt_9 ~= nil then
            ____opt_9 = ____opt_9.isLite
        end
        local ____opt_result_11
        if ____opt_9 ~= nil then
            ____opt_result_11 = ____opt_9(____opt_9)
        end
        local lite = not not ____t_12(____opt_result_11)
        __call(
            plan,
            "forEach",
            function(____, ____bindingPattern0, k)
                local chance
                local gap
                local ____type
                ____type = ____bindingPattern0[1]
                gap = ____bindingPattern0[2]
                chance = ____bindingPattern0[3]
                do
                    local x = 300 + hash(
                        nil,
                        __add(k, sc)
                    ) * gap
                    while x < worldW - 120 do
                        local seed = math.floor(x) + k * 1000 + sc * 77
                        if __gt(
                            hash(nil, seed),
                            chance
                        ) then
                            continue
                        end
                        local n = if ____type == "chicken" then 2 + math.floor(hash(nil, seed + 1) * 2) else if ____type == "pigeon" then 2 + math.floor(hash(nil, seed + 2) * 3) else if ____type == "sparrow" then 3 + math.floor(hash(nil, seed + 5) * 4) else 1
                        do
                            local j = 0
                            while j < n do
                                local hx = x + j * if ____type == "sparrow" then 7 + hash(nil, seed + j) * 12 else 14 + hash(nil, seed + j) * 22
                                __call(
                                    list,
                                    "push",
                                    {
                                        type = ____type,
                                        hx = hx,
                                        x = hx,
                                        y = if ____type == "butterfly" then FLOOR - 40 - hash(nil, seed + j) * 50 else if ____type == "kite" then 70 + hash(nil, seed) * 70 else FLOOR,
                                        vx = 0,
                                        vy = 0,
                                        face = if hash(nil, seed + j * 3) > 0.5 then 1 else -1,
                                        state = "idle",
                                        timer = hash(nil, seed + j) * 3,
                                        seed = seed + j,
                                        rot = 0,
                                        gone = 0
                                    }
                                )
                                j = j + 1
                            end
                        end
                        x = x + gap * if __t(lite) then 1.8 else 1
                    end
                end
            end
        )
    end
    local function update(self, dt, s)
        local ____t_14 = __t
        local ____TS__Number_result_13 = __TS__Number(dt)
        __O[1500] = ____TS__Number_result_13
        dt = clamp(nil, if ____t_14(____TS__Number_result_13) then __O[1500] else 0, 0, 0.05)
        if s.scene ~= scene then
            build(nil, s.scene)
        end
        local ____t_17 = __t
        local ____t_16 = __t
        local ____temp_15 = not __t(__len(list))
        __O[1501] = ____temp_15
        if ____t_17(if ____t_16(____temp_15) then __O[1501] else s.arena) then
            return
        end
        local p = s.player
        local ____t_19 = __t
        local ____TS__Number_result_18 = __TS__Number(s.time)
        __O[1502] = ____TS__Number_result_18
        local t = if ____t_19(____TS__Number_result_18) then __O[1502] else 0
        local ____t_21 = __t
        local ____temp_20 = if __t(p) then p.ground else p
        __O[1503] = ____temp_20
        local onFloor = if ____t_21(____temp_20) then math.abs(p.y - FLOOR) < 8 else __O[1503]
        for ____, c in __iterar((list)) do
            local dx = if __t(p) then c.x - p.x else 999
            local near = math.abs(dx)
            local ____t_25 = __t
            local ____t_23 = __t
            local ____temp_22 = if __t(p) then near < 85 else p
            __O[1504] = ____temp_22
            local ____temp_24 = if ____t_23(____temp_22) then math.abs(p.vx) > 60 or near < 34 else __O[1504]
            __O[1505] = ____temp_24
            local threat = if ____t_25(____temp_24) then math.abs(p.y - c.y) < 90 else __O[1505]
            c.timer = c.timer - dt
            if c.type == "chicken" then
                if __t(if __t(threat) then c.state ~= "flee" else threat) then
                    c.state = "flee"
                    local ____t_27 = __t
                    local ____TS__MathSign_result_26 = __TS__MathSign(dx)
                    __O[1506] = ____TS__MathSign_result_26
                    c.face = if ____t_27(____TS__MathSign_result_26) then __O[1506] else 1
                    c.vx = c.face * (150 + hash(nil, c.seed) * 60)
                    c.vy = -160 - hash(nil, c.seed + 4) * 90
                    c.timer = 1.1
                end
                if c.state == "flee" then
                    c.vy = c.vy + GRAV * dt
                    c.x = c.x + c.vx * dt
                    c.y = math.min(FLOOR, c.y + c.vy * dt)
                    if __ge(c.y, FLOOR) then
                        c.vy = 0
                        c.vx = c.vx * math.exp(__TS__Number(-dt) * 3)
                    end
                    if __le(c.timer, 0) then
                        c.state = "idle"
                    end
                elseif __le(c.timer, 0) then
                    c.state = if hash(
                        nil,
                        c.seed + math.floor(t)
                    ) > 0.5 then "peck" else "walk"
                    c.timer = 1 + hash(nil, c.seed + t) * 2
                    if c.state == "walk" then
                        c.face = if __gt(c.x, c.hx + 40) then -1 else if __lt(c.x, c.hx - 40) then 1 else c.face
                    end
                end
                if c.state == "walk" then
                    c.x = c.x + c.face * 18 * dt
                end
            elseif __t(c.type == "pigeon" or c.type == "sparrow") then
                local fear = if c.type == "sparrow" then 70 else 60 + hash(nil, c.seed + 9) * 70
                local ____t_29 = __t
                local ____temp_28 = if __t(p) then near < fear else p
                __O[1507] = ____temp_28
                local scared = if ____t_29(____temp_28) then math.abs(p.y - c.y) < 110 else __O[1507]
                if c.state == "fly" then
                    c.vy = c.vy - 60 * dt
                    c.x = c.x + c.vx * dt
                    c.y = c.y + c.vy * dt
                    if __lt(c.y, -40) then
                        c.state = "away"
                        c.timer = 6 + hash(nil, c.seed) * 6
                    end
                elseif c.state == "away" then
                    local ____t_32 = __t
                    local ____t_31 = __t
                    local ____le_result_30 = __le(c.timer, 0)
                    __O[1508] = ____le_result_30
                    if ____t_32(if ____t_31(____le_result_30) then not __t(p) or math.abs(p.x - c.hx) > 520 else __O[1508]) then
                        c.state = "idle"
                        c.x = c.hx
                        c.y = FLOOR
                    end
                else
                    if __t(if __t(scared) then scared else threat) then
                        c.state = "fly"
                        local ____t_34 = __t
                        local ____TS__MathSign_result_33 = __TS__MathSign(dx)
                        __O[1509] = ____TS__MathSign_result_33
                        c.face = if ____t_34(____TS__MathSign_result_33) then __O[1509] else 1
                        c.vx = c.face * if c.type == "sparrow" then 170 + hash(nil, c.seed) * 110 else 120 + hash(nil, c.seed) * 80
                        c.vy = -if c.type == "sparrow" then 200 else 170 - hash(nil, c.seed + 3) * 90
                    elseif c.state == "hop" then
                        c.vy = c.vy + GRAV * dt
                        c.x = c.x + c.vx * dt
                        c.y = math.min(FLOOR, c.y + c.vy * dt)
                        if __ge(c.y, FLOOR) then
                            c.state = "peck"
                            c.vx = 0
                        end
                    elseif __t(__le(c.timer, 0) and c.type == "sparrow") then
                        local r = hash(
                            nil,
                            c.seed + math.floor(t * 3)
                        )
                        c.state = if r > 0.55 then "peck" else "hop"
                        if c.state == "hop" then
                            c.vy = -90
                            c.vx = c.face * 40
                            c.y = c.y - 1
                            if r < 0.2 then
                                c.face = c.face * -1
                            end
                        end
                        c.timer = 0.35 + hash(nil, c.seed + t) * 0.9
                    elseif __le(c.timer, 0) then
                        c.state = if hash(
                            nil,
                            c.seed + math.floor(t * 2)
                        ) > 0.4 then "peck" else "walk"
                        c.timer = 0.6 + hash(nil, c.seed + t) * 1.6
                        if hash(
                            nil,
                            c.seed + math.floor(t)
                        ) > 0.7 then
                            c.face = c.face * -1
                        end
                    end
                    if c.state == "walk" then
                        c.x = c.x + c.face * 14 * dt
                    end
                end
            elseif c.type == "butterfly" then
                local scare = if __t(p) then __hypot(c.x - p.x, c.y - (p.y - 40)) < 70 else p
                local tx = c.hx + math.sin(t * 0.6 + c.seed) * 60 + if __t(scare) then __TS__MathSign(if __t(dx) then dx else 1) * 90 else 0
                local ty = FLOOR - 55 + math.sin(t * 1.3 + c.seed * 2) * 30 - if __t(scare) then 60 else 0
                c.vx = c.vx + ((tx - c.x) * dt * 2 - c.vx * dt)
                c.vy = c.vy + ((ty - c.y) * dt * 2 - c.vy * dt)
                c.x = c.x + c.vx * dt
                c.y = c.y + c.vy * dt
                c.face = if __ge(c.vx, 0) then 1 else -1
            elseif c.type == "dog" then
                if __t(if __t(threat) then near < 60 else threat) then
                    c.state = "wag"
                    local ____t_36 = __t
                    local ____temp_35 = -__TS__MathSign(dx)
                    __O[1510] = ____temp_35
                    c.face = if ____t_36(____temp_35) then __O[1510] else 1
                    c.timer = 2
                elseif __le(c.timer, 0) then
                    c.state = if c.state == "walk" then "sit" else "walk"
                    c.timer = 2 + hash(nil, c.seed + t) * 3
                    c.face = if __gt(c.x, c.hx + 120) then -1 else if __lt(c.x, c.hx - 120) then 1 else if hash(
                        nil,
                        c.seed + math.floor(t)
                    ) > 0.5 then 1 else -1
                end
                if c.state == "walk" then
                    c.x = c.x + c.face * 26 * dt
                end
            elseif c.type == "cat" then
                if __t(if __t(threat) then c.state ~= "run" else threat) then
                    c.state = "run"
                    local ____t_38 = __t
                    local ____TS__MathSign_result_37 = __TS__MathSign(dx)
                    __O[1511] = ____TS__MathSign_result_37
                    c.face = if ____t_38(____TS__MathSign_result_37) then __O[1511] else 1
                    c.timer = 1.4
                end
                if c.state == "run" then
                    c.x = c.x + c.face * 170 * dt
                    if __le(c.timer, 0) then
                        c.state = "sit"
                    end
                else
                    local ____t_41 = __t
                    local ____t_40 = __t
                    local ____temp_39 = __le(c.timer, 0) and math.abs(c.x - c.hx) > 200
                    __O[1512] = ____temp_39
                    if ____t_41(if ____t_40(____temp_39) then not __t(p) or math.abs(p.x - c.hx) > 520 else __O[1512]) then
                        c.x = c.hx
                        c.state = "sit"
                    end
                end
            elseif __t(c.type == "ball" or c.type == "can") then
                local r = if c.type == "ball" then 7 else 4
                local ____t_48 = __t
                local ____t_47 = __t
                local ____t_45 = __t
                local ____t_43 = __t
                local ____temp_42 = if __t(p) then near < 16 + r else p
                __O[1513] = ____temp_42
                local ____temp_44 = if ____t_43(____temp_42) then math.abs(p.y - c.y) < 34 else __O[1513]
                __O[1514] = ____temp_44
                local ____temp_46 = if ____t_45(____temp_44) then math.abs(p.vx) > 30 else __O[1514]
                __O[1515] = ____temp_46
                if ____t_48(if ____t_47(____temp_46) then __le(c.timer, 0) else __O[1515]) then
                    local kick = if c.type == "ball" then 1.5 else 1.15
                    c.vx = p.vx * kick + __TS__MathSign(p.vx) * 40
                    c.vy = -(120 + math.abs(p.vx) * if c.type == "ball" then 0.7 else 0.4)
                    c.timer = 0.25
                    local ____opt_51 = window.SceneLife
                    if ____opt_51 ~= nil then
                        ____opt_51 = ____opt_51.burst
                    end
                    if ____opt_51 ~= nil then
                        ____opt_51(
                            ____opt_51,
                            c.x,
                            FLOOR - 2,
                            if c.type == "ball" then "#e6f0d8" else "#c9c2b2",
                            4
                        )
                    end
                end
                c.vy = c.vy + GRAV * dt
                c.x = c.x + c.vx * dt
                c.y = c.y + c.vy * dt
                if __ge(c.y, FLOOR) then
                    c.y = FLOOR
                    c.vy = if math.abs(c.vy) > 80 then __TS__Number(-c.vy) * if c.type == "ball" then 0.55 else 0.3 else 0
                    c.vx = c.vx * math.exp(__TS__Number(-dt) * if c.type == "ball" then 1.1 else 3)
                end
                if __t(__lt(c.x, 20) or __gt(c.x, worldW - 20)) then
                    c.x = clamp(nil, c.x, 20, worldW - 20)
                    c.vx = c.vx * -0.5
                end
                c.rot = c.rot + c.vx * dt / r
            end
            local ____t_61 = __t
            local ____t_60 = __t
            local ____t_58 = __t
            local ____t_56 = __t
            local ____t_54 = __t
            local ____temp_53 = c.type ~= "kite" and c.type ~= "ball"
            __O[1516] = ____temp_53
            local ____temp_55 = if ____t_54(____temp_53) then c.type ~= "can" else __O[1516]
            __O[1517] = ____temp_55
            local ____temp_57 = if ____t_56(____temp_55) then c.type ~= "butterfly" else __O[1517]
            __O[1518] = ____temp_57
            local ____temp_59 = if ____t_58(____temp_57) then c.state ~= "fly" else __O[1518]
            __O[1519] = ____temp_59
            if ____t_61(if ____t_60(____temp_59) then c.state ~= "away" else __O[1519]) then
                c.x = clamp(nil, c.x, c.hx - 260, c.hx + 260)
            end
        end
    end
    local function chicken(self, c, x, y, f, t, k)
        local peck = if k.state == "peck" then math.max(
            0,
            math.sin(t * 9 + k.seed)
        ) * 4 else 0
        local flap = k.state == "flee" and __lt(k.y, FLOOR - 1)
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        c:scale(f, 1)
        R(
            nil,
            c,
            -7,
            -1,
            14,
            1,
            "rgba(30,30,20,.25)"
        )
        R(
            nil,
            c,
            -2,
            -4,
            2,
            4,
            "#d58a2a"
        )
        R(
            nil,
            c,
            2,
            -4,
            2,
            4,
            "#d58a2a"
        )
        R(
            nil,
            c,
            -8,
            -12,
            13,
            9,
            "#f3efe2"
        )
        R(
            nil,
            c,
            -9,
            -14,
            4,
            4,
            "#e8e2d0"
        )
        R(
            nil,
            c,
            -6,
            -5,
            9,
            2,
            "#d9d1bd"
        )
        if __t(flap) then
            R(
                nil,
                c,
                -6,
                -18 + math.floor(math.sin(t * 30) * 2 + 0.5),
                9,
                4,
                "#ffffff"
            )
        else
            R(
                nil,
                c,
                -5,
                -10,
                7,
                4,
                "#e4dccb"
            )
        end
        local hy = -17 + peck
        R(
            nil,
            c,
            2,
            hy,
            6,
            7,
            "#f3efe2"
        )
        R(
            nil,
            c,
            3,
            hy - 2,
            3,
            2,
            "#d8433a"
        )
        R(
            nil,
            c,
            8,
            hy + 3,
            3,
            2,
            "#f0b23a"
        )
        R(
            nil,
            c,
            6,
            hy + 2,
            1,
            1,
            "#222"
        )
        R(
            nil,
            c,
            6,
            hy + 5,
            2,
            3,
            "#d8433a"
        )
        c:restore()
    end
    local function pigeon(self, c, x, y, f, t, k)
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        c:scale(f, 1)
        if k.state == "fly" then
            local w = math.floor(math.sin(t * 28 + k.seed) * 4 + 0.5)
            R(
                nil,
                c,
                -5,
                -5,
                10,
                4,
                "#8b93a0"
            )
            R(
                nil,
                c,
                -3,
                -8 + w,
                8,
                3,
                "#a7aebb"
            )
            R(
                nil,
                c,
                -3,
                -1 - w,
                8,
                2,
                "#737b88"
            )
            R(
                nil,
                c,
                4,
                -6,
                3,
                3,
                "#7e8794"
            )
            c:restore()
            return
        end
        local peck = if k.state == "peck" then math.max(
            0,
            math.sin(t * 11 + k.seed)
        ) * 3 else 0
        R(
            nil,
            c,
            -5,
            -1,
            10,
            1,
            "rgba(30,30,30,.2)"
        )
        R(
            nil,
            c,
            -1,
            -3,
            1,
            3,
            "#c0605a"
        )
        R(
            nil,
            c,
            1,
            -3,
            1,
            3,
            "#c0605a"
        )
        R(
            nil,
            c,
            -6,
            -8,
            10,
            5,
            "#8b93a0"
        )
        R(
            nil,
            c,
            -7,
            -7,
            3,
            2,
            "#5f6672"
        )
        R(
            nil,
            c,
            -3,
            -7,
            5,
            2,
            "#a7aebb"
        )
        R(
            nil,
            c,
            2,
            -11 + peck,
            4,
            4,
            "#7e8794"
        )
        R(
            nil,
            c,
            2,
            -8 + peck,
            3,
            2,
            "#6aa38e"
        )
        R(
            nil,
            c,
            6,
            -10 + peck,
            2,
            1,
            "#e9d9b0"
        )
        R(
            nil,
            c,
            4,
            -10 + peck,
            1,
            1,
            "#f0a050"
        )
        c:restore()
    end
    local function sparrow(self, c, x, y, f, t, k)
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        c:scale(f, 1)
        if k.state == "fly" then
            local w = math.floor(math.sin(t * 34 + k.seed) * 3 + 0.5)
            R(
                nil,
                c,
                -3,
                -4,
                7,
                3,
                "#8a6a4a"
            )
            R(
                nil,
                c,
                -2,
                -7 + w,
                5,
                3,
                "#a88560"
            )
            R(
                nil,
                c,
                -2,
                -1 - w,
                5,
                2,
                "#6e5238"
            )
            R(
                nil,
                c,
                3,
                -5,
                3,
                2,
                "#7a5a3c"
            )
            R(
                nil,
                c,
                -5,
                -4,
                2,
                1,
                "#5e4630"
            )
            c:restore()
            return
        end
        local peck = if k.state == "peck" then math.max(
            0,
            math.sin(t * 13 + k.seed)
        ) * 2 else 0
        R(
            nil,
            c,
            -3,
            -1,
            7,
            1,
            "rgba(30,25,20,.22)"
        )
        R(
            nil,
            c,
            0,
            -2,
            1,
            2,
            "#c08a60"
        )
        R(
            nil,
            c,
            -4,
            -6,
            7,
            4,
            "#8a6a4a"
        )
        R(
            nil,
            c,
            -6,
            -5,
            3,
            1,
            "#5e4630"
        )
        R(
            nil,
            c,
            -3,
            -6,
            4,
            1,
            "#b08a62"
        )
        R(
            nil,
            c,
            -2,
            -3,
            4,
            1,
            "#d8c8a8"
        )
        R(
            nil,
            c,
            2,
            -8 + peck,
            3,
            3,
            "#7a5a3c"
        )
        R(
            nil,
            c,
            2,
            -6 + peck,
            2,
            1,
            "#e8dcc0"
        )
        R(
            nil,
            c,
            5,
            -7 + peck,
            1,
            1,
            "#e0b060"
        )
        R(
            nil,
            c,
            3,
            -8 + peck,
            1,
            1,
            "#1d1612"
        )
        c:restore()
    end
    local function butterfly(self, c, x, y, t, k)
        local w = math.abs(math.sin(t * 16 + k.seed)) * 3 + 1
        local col = __get(
            __arrL({"#f2b33d", "#f08bb0", "#8fd0f0", "#fff3c4"}, 4),
            __mod(k.seed, 4)
        )
        R(
            nil,
            c,
            x - w - 1,
            y - 2,
            w,
            3,
            col
        )
        R(
            nil,
            c,
            x + 2,
            y - 2,
            w,
            3,
            col
        )
        R(
            nil,
            c,
            x,
            y - 2,
            2,
            4,
            "#3a2a20"
        )
    end
    local function dog(self, c, x, y, f, t, k)
        local walk = k.state == "walk"
        local leg = if __t(walk) then math.floor(math.sin(t * 12 + k.seed) * 2 + 0.5) else 0
        local wag = math.floor(math.sin(t * if k.state == "wag" then 22 else 6) * 2 + 0.5)
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        c:scale(f, 1)
        R(
            nil,
            c,
            -11,
            -1,
            22,
            1,
            "rgba(30,25,20,.25)"
        )
        if k.state == "sit" then
            R(
                nil,
                c,
                -8,
                -12,
                12,
                9,
                "#b07a46"
            )
            R(
                nil,
                c,
                -6,
                -4,
                4,
                4,
                "#9a6a3c"
            )
            R(
                nil,
                c,
                2,
                -4,
                3,
                4,
                "#9a6a3c"
            )
        else
            R(
                nil,
                c,
                -9,
                -12,
                16,
                7,
                "#b07a46"
            )
            R(
                nil,
                c,
                -8 + leg,
                -5,
                3,
                5,
                "#9a6a3c"
            )
            R(
                nil,
                c,
                -3 - leg,
                -5,
                3,
                5,
                "#9a6a3c"
            )
            R(
                nil,
                c,
                1 + leg,
                -5,
                3,
                5,
                "#9a6a3c"
            )
            R(
                nil,
                c,
                5 - leg,
                -5,
                3,
                5,
                "#9a6a3c"
            )
        end
        R(
            nil,
            c,
            -12,
            -14 + wag,
            4,
            2,
            "#9a6a3c"
        )
        R(
            nil,
            c,
            4,
            -18,
            8,
            8,
            "#b07a46"
        )
        R(
            nil,
            c,
            11,
            -14,
            3,
            3,
            "#d9b48a"
        )
        R(
            nil,
            c,
            13,
            -14,
            1,
            1,
            "#222"
        )
        R(
            nil,
            c,
            8,
            -16,
            1,
            1,
            "#222"
        )
        R(
            nil,
            c,
            4,
            -19,
            3,
            4,
            "#7d5230"
        )
        c:restore()
    end
    local function cat(self, c, x, y, f, t, k)
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        c:scale(f, 1)
        R(
            nil,
            c,
            -7,
            -1,
            14,
            1,
            "rgba(30,25,20,.25)"
        )
        if k.state == "run" then
            local l = math.floor(math.sin(t * 20) * 2 + 0.5)
            R(
                nil,
                c,
                -8,
                -8,
                13,
                5,
                "#3b3a3f"
            )
            R(
                nil,
                c,
                -7 + l,
                -3,
                2,
                3,
                "#3b3a3f"
            )
            R(
                nil,
                c,
                2 - l,
                -3,
                2,
                3,
                "#3b3a3f"
            )
            R(
                nil,
                c,
                4,
                -11,
                6,
                5,
                "#3b3a3f"
            )
            R(
                nil,
                c,
                -12,
                -10,
                5,
                2,
                "#3b3a3f"
            )
        else
            local tail = math.floor(math.sin(t * 2 + k.seed) * 2 + 0.5)
            R(
                nil,
                c,
                -5,
                -11,
                9,
                10,
                "#3b3a3f"
            )
            R(
                nil,
                c,
                -8,
                -3 + tail,
                4,
                2,
                "#3b3a3f"
            )
            R(
                nil,
                c,
                -1,
                -17,
                7,
                6,
                "#3b3a3f"
            )
            R(
                nil,
                c,
                -1,
                -19,
                2,
                2,
                "#3b3a3f"
            )
            R(
                nil,
                c,
                4,
                -19,
                2,
                2,
                "#3b3a3f"
            )
            R(
                nil,
                c,
                1,
                -15,
                1,
                1,
                "#e5d24a"
            )
            R(
                nil,
                c,
                4,
                -15,
                1,
                1,
                "#e5d24a"
            )
        end
        c:restore()
    end
    local function kite(self, c, x, y, t, k, cam)
        local sx = x + math.sin(t * 0.7 + k.seed) * 30
        local sy = y + math.sin(t * 1.1 + k.seed) * 14
        local col = __get(
            __arrL({"#e2453c", "#f2c33a", "#3b8fd8", "#46b46a"}, 4),
            __mod(k.seed, 4)
        )
        c:save()
        c.globalAlpha = 0.55
        c.strokeStyle = "#4d4d4d"
        c.lineWidth = 1
        c:beginPath()
        c:moveTo(sx, sy + 8)
        c:lineTo(sx - 60, FLOOR - 60)
        c:stroke()
        c:restore()
        c.fillStyle = col
        c:beginPath()
        c:moveTo(sx, sy - 9)
        c:lineTo(sx + 7, sy)
        c:lineTo(sx, sy + 9)
        c:lineTo(sx - 7, sy)
        c:closePath()
        __call(c, "fill")
        R(
            nil,
            c,
            sx - 1,
            sy - 9,
            2,
            18,
            "rgba(255,255,255,.45)"
        )
        do
            local i = 1
            while i < 6 do
                R(
                    nil,
                    c,
                    sx + math.sin(t * 4 + i) * 3 - i,
                    sy + 9 + i * 4,
                    2,
                    2,
                    if __t(__mod(i, 2)) then col else "#fff"
                )
                i = i + 1
            end
        end
    end
    local function ball(self, c, x, y, k)
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5) - 7
        )
        R(
            nil,
            c,
            -6,
            6,
            12,
            1,
            "rgba(20,30,20,.3)"
        )
        R(
            nil,
            c,
            -5,
            -7,
            10,
            14,
            "#f4f4ee"
        )
        R(
            nil,
            c,
            -7,
            -5,
            14,
            10,
            "#f4f4ee"
        )
        R(
            nil,
            c,
            -6,
            -6,
            12,
            12,
            "#f4f4ee"
        )
        local a = k.rot
        do
            local i = 0
            while i < 3 do
                local ang = a + i * 2.1
                R(
                    nil,
                    c,
                    math.floor(math.cos(ang) * 3 + 0.5) - 2,
                    math.floor(math.sin(ang) * 3 + 0.5) - 2,
                    4,
                    4,
                    "#2b2b2b"
                )
                i = i + 1
            end
        end
        R(
            nil,
            c,
            -4,
            -6,
            4,
            2,
            "#ffffff"
        )
        c:restore()
    end
    local function can(self, c, x, y, k)
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5) - 4
        )
        c:rotate(__mod(
            math.floor(k.rot * 2 + 0.5) / 2 * math.pi / 4,
            math.pi * 2
        ))
        R(
            nil,
            c,
            -5,
            -3,
            10,
            7,
            "#b8433b"
        )
        R(
            nil,
            c,
            -5,
            -3,
            10,
            2,
            "#e3e3e3"
        )
        R(
            nil,
            c,
            -5,
            3,
            10,
            1,
            "#9a9a9a"
        )
        R(
            nil,
            c,
            -2,
            -1,
            5,
            2,
            "#f0d27a"
        )
        c:restore()
    end
    local function draw(self, c, s)
        local ____t_64 = __t
        local ____t_63 = __t
        local ____temp_62 = not __t(__len(list))
        __O[1520] = ____temp_62
        if ____t_64(if ____t_63(____temp_62) then __O[1520] else s.arena) then
            return
        end
        local ____t_66 = __t
        local ____TS__Number_result_65 = __TS__Number(s.time)
        __O[1521] = ____TS__Number_result_65
        local t = if ____t_66(____TS__Number_result_65) then __O[1521] else 0
        local ____t_68 = __t
        local ____TS__Number_result_67 = __TS__Number(s.camera)
        __O[1522] = ____TS__Number_result_67
        local cam = if ____t_68(____TS__Number_result_67) then __O[1522] else 0
        for ____, k in __iterar((list)) do
            if __t(__lt(k.x, cam - 80) or __gt(k.x, cam + 1040)) then
                continue
            end
            if k.state == "away" then
                continue
            end
            local ____t_73 = __t
            local ____t_72 = __t
            local ____t_70 = __t
            local ____temp_69 = if __t(s.gapAt) then __ge(k.y, FLOOR - 1) else s.gapAt
            __O[1523] = ____temp_69
            local ____temp_71 = if ____t_70(____temp_69) then s:gapAt(k.x) else __O[1523]
            __O[1524] = ____temp_71
            if ____t_73(if ____t_72(____temp_71) then k.type ~= "kite" else __O[1524]) then
                continue
            end
            repeat
                local ____switch84 = k.type
                local ____cond84 = ____switch84 == "chicken"
                if ____cond84 then
                    chicken(
                        nil,
                        c,
                        k.x,
                        k.y,
                        k.face,
                        t,
                        k
                    )
                    break
                end
                ____cond84 = ____cond84 or ____switch84 == "pigeon"
                if ____cond84 then
                    pigeon(
                        nil,
                        c,
                        k.x,
                        k.y,
                        k.face,
                        t,
                        k
                    )
                    break
                end
                ____cond84 = ____cond84 or ____switch84 == "sparrow"
                if ____cond84 then
                    sparrow(
                        nil,
                        c,
                        k.x,
                        k.y,
                        k.face,
                        t,
                        k
                    )
                    break
                end
                ____cond84 = ____cond84 or ____switch84 == "butterfly"
                if ____cond84 then
                    butterfly(
                        nil,
                        c,
                        k.x,
                        k.y,
                        t,
                        k
                    )
                    break
                end
                ____cond84 = ____cond84 or ____switch84 == "dog"
                if ____cond84 then
                    dog(
                        nil,
                        c,
                        k.x,
                        k.y,
                        k.face,
                        t,
                        k
                    )
                    break
                end
                ____cond84 = ____cond84 or ____switch84 == "cat"
                if ____cond84 then
                    cat(
                        nil,
                        c,
                        k.x,
                        k.y,
                        k.face,
                        t,
                        k
                    )
                    break
                end
                ____cond84 = ____cond84 or ____switch84 == "kite"
                if ____cond84 then
                    kite(
                        nil,
                        c,
                        k.x,
                        k.y,
                        t,
                        k,
                        cam
                    )
                    break
                end
                ____cond84 = ____cond84 or ____switch84 == "ball"
                if ____cond84 then
                    ball(
                        nil,
                        c,
                        k.x,
                        k.y,
                        k
                    )
                    break
                end
                ____cond84 = ____cond84 or ____switch84 == "can"
                if ____cond84 then
                    can(
                        nil,
                        c,
                        k.x,
                        k.y,
                        k
                    )
                    break
                end
            until true
        end
    end
    window.Critters = __ord(
        {
            update = update,
            draw = draw,
            count = function() return __len(list) end,
            reset = function()
                scene = -1
            end
        },
        "update,draw,count,reset"
    )
end)(nil)
return ____exports
