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
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
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
        local ____t_result_7
        local ____t_6 = __t
        local ____t_result_5
        local ____t_4 = __t
        local ____getq_2 = __getq
        local ____opt_0 = window.WorldData
        if ____opt_0 ~= nil then
            ____opt_0 = ____opt_0.widths
        end
        local ____TS__Number_result_3 = __TS__Number(____getq_2(____opt_0, sc))
        __O[1503] = ____TS__Number_result_3
        if ____t_4(____TS__Number_result_3) then
            ____t_result_5 = __O[1503]
        else
            ____t_result_5 = __get(
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
        end
        __O[1504] = ____t_result_5
        if ____t_6(____t_result_5) then
            ____t_result_7 = __O[1504]
        else
            ____t_result_7 = 4800
        end
        worldW = ____t_result_7
        local plan = __get(PLAN, sc)
        if not __t(plan) then
            return
        end
        local ____t_13 = __t
        local ____opt_10 = window.Graphics
        if ____opt_10 ~= nil then
            ____opt_10 = ____opt_10.isLite
        end
        local ____opt_result_12
        if ____opt_10 ~= nil then
            ____opt_result_12 = ____opt_10(____opt_10)
        end
        local lite = not not ____t_13(____opt_result_12)
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
                        do
                            local seed = math.floor(x) + k * 1000 + sc * 77
                            if __gt(
                                hash(nil, seed),
                                chance
                            ) then
                                do x = x + gap * (__t(lite) and 1.8 or 1) continue end
                            end
                            local ____temp_16
                            if ____type == "chicken" then
                                ____temp_16 = 2 + math.floor(hash(nil, seed + 1) * 2)
                            else
                                local ____temp_15
                                if ____type == "pigeon" then
                                    ____temp_15 = 2 + math.floor(hash(nil, seed + 2) * 3)
                                else
                                    local ____temp_14
                                    if ____type == "sparrow" then
                                        ____temp_14 = 3 + math.floor(hash(nil, seed + 5) * 4)
                                    else
                                        ____temp_14 = 1
                                    end
                                    ____temp_15 = ____temp_14
                                end
                                ____temp_16 = ____temp_15
                            end
                            local n = ____temp_16
                            do
                                local j = 0
                                while j < n do
                                    local ____x_19 = x
                                    local ____j_18 = j
                                    local ____temp_17
                                    if ____type == "sparrow" then
                                        ____temp_17 = 7 + hash(nil, seed + j) * 12
                                    else
                                        ____temp_17 = 14 + hash(nil, seed + j) * 22
                                    end
                                    local hx = ____x_19 + ____j_18 * ____temp_17
                                    local ____call_25 = __call
                                    local ____list_24 = list
                                    local ____type_22 = ____type
                                    local ____hx_23 = hx
                                    local ____temp_21
                                    if ____type == "butterfly" then
                                        ____temp_21 = FLOOR - 40 - hash(nil, seed + j) * 50
                                    else
                                        local ____temp_20
                                        if ____type == "kite" then
                                            ____temp_20 = 70 + hash(nil, seed) * 70
                                        else
                                            ____temp_20 = FLOOR
                                        end
                                        ____temp_21 = ____temp_20
                                    end
                                    ____call_25(
                                        ____list_24,
                                        "push",
                                        {
                                            type = ____type_22,
                                            hx = ____hx_23,
                                            x = hx,
                                            y = ____temp_21,
                                            vx = 0,
                                            vy = 0,
                                            face = hash(nil, seed + j * 3) > 0.5 and 1 or -1,
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
                        end
                        x = x + gap * (__t(lite) and 1.8 or 1)
                    end
                end
            end
        )
    end
    local function update(self, dt, s)
        local ____t_result_28
        local ____t_27 = __t
        local ____TS__Number_result_26 = __TS__Number(dt)
        __O[1505] = ____TS__Number_result_26
        if ____t_27(____TS__Number_result_26) then
            ____t_result_28 = __O[1505]
        else
            ____t_result_28 = 0
        end
        dt = clamp(nil, ____t_result_28, 0, 0.05)
        if s.scene ~= scene then
            build(nil, s.scene)
        end
        local ____t_32 = __t
        local ____t_result_31
        local ____t_30 = __t
        local ____temp_29 = not __t(__len(list))
        __O[1506] = ____temp_29
        if ____t_30(____temp_29) then
            ____t_result_31 = __O[1506]
        else
            ____t_result_31 = s.arena
        end
        if ____t_32(____t_result_31) then
            return
        end
        local p = s.player
        local ____t_result_35
        local ____t_34 = __t
        local ____TS__Number_result_33 = __TS__Number(s.time)
        __O[1507] = ____TS__Number_result_33
        if ____t_34(____TS__Number_result_33) then
            ____t_result_35 = __O[1507]
        else
            ____t_result_35 = 0
        end
        local t = ____t_result_35
        local ____t_result_38
        local ____t_37 = __t
        local ____t_result_36
        if __t(p) then
            ____t_result_36 = p.ground
        else
            ____t_result_36 = p
        end
        __O[1508] = ____t_result_36
        if ____t_37(____t_result_36) then
            ____t_result_38 = math.abs(p.y - FLOOR) < 8
        else
            ____t_result_38 = __O[1508]
        end
        local onFloor = ____t_result_38
        for ____, c in __iterar((list)) do
            local ____t_result_39
            if __t(p) then
                ____t_result_39 = c.x - p.x
            else
                ____t_result_39 = 999
            end
            local dx = ____t_result_39
            local near = math.abs(dx)
            local ____t_result_44
            local ____t_43 = __t
            local ____t_result_42
            local ____t_41 = __t
            local ____t_result_40
            if __t(p) then
                ____t_result_40 = near < 85
            else
                ____t_result_40 = p
            end
            __O[1509] = ____t_result_40
            if ____t_41(____t_result_40) then
                ____t_result_42 = math.abs(p.vx) > 60 or near < 34
            else
                ____t_result_42 = __O[1509]
            end
            __O[1510] = ____t_result_42
            if ____t_43(____t_result_42) then
                ____t_result_44 = math.abs(p.y - c.y) < 90
            else
                ____t_result_44 = __O[1510]
            end
            local threat = ____t_result_44
            c.timer = c.timer - dt
            if c.type == "chicken" then
                local ____t_46 = __t
                local ____t_result_45
                if __t(threat) then
                    ____t_result_45 = c.state ~= "flee"
                else
                    ____t_result_45 = threat
                end
                if ____t_46(____t_result_45) then
                    c.state = "flee"
                    local ____t_result_49
                    local ____t_48 = __t
                    local ____TS__MathSign_result_47 = __TS__MathSign(dx)
                    __O[1511] = ____TS__MathSign_result_47
                    if ____t_48(____TS__MathSign_result_47) then
                        ____t_result_49 = __O[1511]
                    else
                        ____t_result_49 = 1
                    end
                    c.face = ____t_result_49
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
                    c.state = hash(
                        nil,
                        c.seed + math.floor(t)
                    ) > 0.5 and "peck" or "walk"
                    c.timer = 1 + hash(nil, c.seed + t) * 2
                    if c.state == "walk" then
                        c.face = __gt(c.x, c.hx + 40) and -1 or (__lt(c.x, c.hx - 40) and 1 or c.face)
                    end
                end
                if c.state == "walk" then
                    c.x = c.x + c.face * 18 * dt
                end
            elseif __t(c.type == "pigeon" or c.type == "sparrow") then
                local fear = (c.type == "sparrow" and 70 or 60) + hash(nil, c.seed + 9) * 70
                local ____t_result_52
                local ____t_51 = __t
                local ____t_result_50
                if __t(p) then
                    ____t_result_50 = near < fear
                else
                    ____t_result_50 = p
                end
                __O[1512] = ____t_result_50
                if ____t_51(____t_result_50) then
                    ____t_result_52 = math.abs(p.y - c.y) < 110
                else
                    ____t_result_52 = __O[1512]
                end
                local scared = ____t_result_52
                if c.state == "fly" then
                    c.vy = c.vy - 60 * dt
                    c.x = c.x + c.vx * dt
                    c.y = c.y + c.vy * dt
                    if __lt(c.y, -40) then
                        c.state = "away"
                        c.timer = 6 + hash(nil, c.seed) * 6
                    end
                elseif c.state == "away" then
                    local ____t_56 = __t
                    local ____t_result_55
                    local ____t_54 = __t
                    local ____le_result_53 = __le(c.timer, 0)
                    __O[1513] = ____le_result_53
                    if ____t_54(____le_result_53) then
                        ____t_result_55 = not __t(p) or math.abs(p.x - c.hx) > 520
                    else
                        ____t_result_55 = __O[1513]
                    end
                    if ____t_56(____t_result_55) then
                        c.state = "idle"
                        c.x = c.hx
                        c.y = FLOOR
                    end
                else
                    local ____t_58 = __t
                    local ____t_result_57
                    if __t(scared) then
                        ____t_result_57 = scared
                    else
                        ____t_result_57 = threat
                    end
                    if ____t_58(____t_result_57) then
                        c.state = "fly"
                        local ____t_result_61
                        local ____t_60 = __t
                        local ____TS__MathSign_result_59 = __TS__MathSign(dx)
                        __O[1514] = ____TS__MathSign_result_59
                        if ____t_60(____TS__MathSign_result_59) then
                            ____t_result_61 = __O[1514]
                        else
                            ____t_result_61 = 1
                        end
                        c.face = ____t_result_61
                        local ____c_face_63 = c.face
                        local ____temp_62
                        if c.type == "sparrow" then
                            ____temp_62 = 170 + hash(nil, c.seed) * 110
                        else
                            ____temp_62 = 120 + hash(nil, c.seed) * 80
                        end
                        c.vx = ____c_face_63 * ____temp_62
                        c.vy = -(c.type == "sparrow" and 200 or 170) - hash(nil, c.seed + 3) * 90
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
                        c.state = r > 0.55 and "peck" or "hop"
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
                        c.state = hash(
                            nil,
                            c.seed + math.floor(t * 2)
                        ) > 0.4 and "peck" or "walk"
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
                local ____t_result_64
                if __t(p) then
                    ____t_result_64 = __hypot(c.x - p.x, c.y - (p.y - 40)) < 70
                else
                    ____t_result_64 = p
                end
                local scare = ____t_result_64
                local ____temp_67 = c.hx + math.sin(t * 0.6 + c.seed) * 60
                local ____t_result_66
                if __t(scare) then
                    local ____t_result_65
                    if __t(dx) then
                        ____t_result_65 = dx
                    else
                        ____t_result_65 = 1
                    end
                    ____t_result_66 = __TS__MathSign(____t_result_65) * 90
                else
                    ____t_result_66 = 0
                end
                local tx = ____temp_67 + ____t_result_66
                local ty = FLOOR - 55 + math.sin(t * 1.3 + c.seed * 2) * 30 - (__t(scare) and 60 or 0)
                c.vx = c.vx + ((tx - c.x) * dt * 2 - c.vx * dt)
                c.vy = c.vy + ((ty - c.y) * dt * 2 - c.vy * dt)
                c.x = c.x + c.vx * dt
                c.y = c.y + c.vy * dt
                c.face = __ge(c.vx, 0) and 1 or -1
            elseif c.type == "dog" then
                local ____t_69 = __t
                local ____t_result_68
                if __t(threat) then
                    ____t_result_68 = near < 60
                else
                    ____t_result_68 = threat
                end
                if ____t_69(____t_result_68) then
                    c.state = "wag"
                    local ____t_result_72
                    local ____t_71 = __t
                    local ____temp_70 = -__TS__MathSign(dx)
                    __O[1515] = ____temp_70
                    if ____t_71(____temp_70) then
                        ____t_result_72 = __O[1515]
                    else
                        ____t_result_72 = 1
                    end
                    c.face = ____t_result_72
                    c.timer = 2
                elseif __le(c.timer, 0) then
                    c.state = c.state == "walk" and "sit" or "walk"
                    c.timer = 2 + hash(nil, c.seed + t) * 3
                    c.face = __gt(c.x, c.hx + 120) and -1 or (__lt(c.x, c.hx - 120) and 1 or (hash(
                        nil,
                        c.seed + math.floor(t)
                    ) > 0.5 and 1 or -1))
                end
                if c.state == "walk" then
                    c.x = c.x + c.face * 26 * dt
                end
            elseif c.type == "cat" then
                local ____t_74 = __t
                local ____t_result_73
                if __t(threat) then
                    ____t_result_73 = c.state ~= "run"
                else
                    ____t_result_73 = threat
                end
                if ____t_74(____t_result_73) then
                    c.state = "run"
                    local ____t_result_77
                    local ____t_76 = __t
                    local ____TS__MathSign_result_75 = __TS__MathSign(dx)
                    __O[1516] = ____TS__MathSign_result_75
                    if ____t_76(____TS__MathSign_result_75) then
                        ____t_result_77 = __O[1516]
                    else
                        ____t_result_77 = 1
                    end
                    c.face = ____t_result_77
                    c.timer = 1.4
                end
                if c.state == "run" then
                    c.x = c.x + c.face * 170 * dt
                    if __le(c.timer, 0) then
                        c.state = "sit"
                    end
                else
                    local ____t_81 = __t
                    local ____t_result_80
                    local ____t_79 = __t
                    local ____temp_78 = __le(c.timer, 0) and math.abs(c.x - c.hx) > 200
                    __O[1517] = ____temp_78
                    if ____t_79(____temp_78) then
                        ____t_result_80 = not __t(p) or math.abs(p.x - c.hx) > 520
                    else
                        ____t_result_80 = __O[1517]
                    end
                    if ____t_81(____t_result_80) then
                        c.x = c.hx
                        c.state = "sit"
                    end
                end
            elseif __t(c.type == "ball" or c.type == "can") then
                local r = c.type == "ball" and 7 or 4
                local ____t_89 = __t
                local ____t_result_88
                local ____t_87 = __t
                local ____t_result_86
                local ____t_85 = __t
                local ____t_result_84
                local ____t_83 = __t
                local ____t_result_82
                if __t(p) then
                    ____t_result_82 = near < 16 + r
                else
                    ____t_result_82 = p
                end
                __O[1518] = ____t_result_82
                if ____t_83(____t_result_82) then
                    ____t_result_84 = math.abs(p.y - c.y) < 34
                else
                    ____t_result_84 = __O[1518]
                end
                __O[1519] = ____t_result_84
                if ____t_85(____t_result_84) then
                    ____t_result_86 = math.abs(p.vx) > 30
                else
                    ____t_result_86 = __O[1519]
                end
                __O[1520] = ____t_result_86
                if ____t_87(____t_result_86) then
                    ____t_result_88 = __le(c.timer, 0)
                else
                    ____t_result_88 = __O[1520]
                end
                if ____t_89(____t_result_88) then
                    local kick = c.type == "ball" and 1.5 or 1.15
                    c.vx = p.vx * kick + __TS__MathSign(p.vx) * 40
                    c.vy = -(120 + math.abs(p.vx) * (c.type == "ball" and 0.7 or 0.4))
                    c.timer = 0.25
                    local ____opt_92 = window.SceneLife
                    if ____opt_92 ~= nil then
                        ____opt_92 = ____opt_92.burst
                    end
                    if ____opt_92 ~= nil then
                        ____opt_92(
                            ____opt_92,
                            c.x,
                            FLOOR - 2,
                            c.type == "ball" and "#e6f0d8" or "#c9c2b2",
                            4
                        )
                    end
                end
                c.vy = c.vy + GRAV * dt
                c.x = c.x + c.vx * dt
                c.y = c.y + c.vy * dt
                if __ge(c.y, FLOOR) then
                    c.y = FLOOR
                    local ____temp_94
                    if math.abs(c.vy) > 80 then
                        ____temp_94 = __TS__Number(-c.vy) * (c.type == "ball" and 0.55 or 0.3)
                    else
                        ____temp_94 = 0
                    end
                    c.vy = ____temp_94
                    c.vx = c.vx * math.exp(__TS__Number(-dt) * (c.type == "ball" and 1.1 or 3))
                end
                if __t(__lt(c.x, 20) or __gt(c.x, worldW - 20)) then
                    c.x = clamp(nil, c.x, 20, worldW - 20)
                    c.vx = c.vx * -0.5
                end
                c.rot = c.rot + c.vx * dt / r
            end
            local ____t_104 = __t
            local ____t_result_103
            local ____t_102 = __t
            local ____t_result_101
            local ____t_100 = __t
            local ____t_result_99
            local ____t_98 = __t
            local ____t_result_97
            local ____t_96 = __t
            local ____temp_95 = c.type ~= "kite" and c.type ~= "ball"
            __O[1521] = ____temp_95
            if ____t_96(____temp_95) then
                ____t_result_97 = c.type ~= "can"
            else
                ____t_result_97 = __O[1521]
            end
            __O[1522] = ____t_result_97
            if ____t_98(____t_result_97) then
                ____t_result_99 = c.type ~= "butterfly"
            else
                ____t_result_99 = __O[1522]
            end
            __O[1523] = ____t_result_99
            if ____t_100(____t_result_99) then
                ____t_result_101 = c.state ~= "fly"
            else
                ____t_result_101 = __O[1523]
            end
            __O[1524] = ____t_result_101
            if ____t_102(____t_result_101) then
                ____t_result_103 = c.state ~= "away"
            else
                ____t_result_103 = __O[1524]
            end
            if ____t_104(____t_result_103) then
                c.x = clamp(nil, c.x, c.hx - 260, c.hx + 260)
            end
        end
    end
    local function chicken(self, c, x, y, f, t, k)
        local ____temp_105
        if k.state == "peck" then
            ____temp_105 = math.max(
                0,
                math.sin(t * 9 + k.seed)
            ) * 4
        else
            ____temp_105 = 0
        end
        local peck = ____temp_105
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
        local ____temp_106
        if k.state == "peck" then
            ____temp_106 = math.max(
                0,
                math.sin(t * 11 + k.seed)
            ) * 3
        else
            ____temp_106 = 0
        end
        local peck = ____temp_106
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
        local ____temp_107
        if k.state == "peck" then
            ____temp_107 = math.max(
                0,
                math.sin(t * 13 + k.seed)
            ) * 2
        else
            ____temp_107 = 0
        end
        local peck = ____temp_107
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
        local ____t_result_108
        if __t(walk) then
            ____t_result_108 = math.floor(math.sin(t * 12 + k.seed) * 2 + 0.5)
        else
            ____t_result_108 = 0
        end
        local leg = ____t_result_108
        local wag = math.floor(math.sin(t * (k.state == "wag" and 22 or 6)) * 2 + 0.5)
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
                local ____array_110 = __TS__SparseArrayNew(
                    nil,
                    c,
                    sx + math.sin(t * 4 + i) * 3 - i,
                    sy + 9 + i * 4,
                    2,
                    2
                )
                local ____t_result_109
                if __t(__mod(i, 2)) then
                    ____t_result_109 = col
                else
                    ____t_result_109 = "#fff"
                end
                __TS__SparseArrayPush(____array_110, ____t_result_109)
                R(__TS__SparseArraySpread(____array_110))
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
        local ____t_114 = __t
        local ____t_result_113
        local ____t_112 = __t
        local ____temp_111 = not __t(__len(list))
        __O[1525] = ____temp_111
        if ____t_112(____temp_111) then
            ____t_result_113 = __O[1525]
        else
            ____t_result_113 = s.arena
        end
        if ____t_114(____t_result_113) then
            return
        end
        local ____t_result_117
        local ____t_116 = __t
        local ____TS__Number_result_115 = __TS__Number(s.time)
        __O[1526] = ____TS__Number_result_115
        if ____t_116(____TS__Number_result_115) then
            ____t_result_117 = __O[1526]
        else
            ____t_result_117 = 0
        end
        local t = ____t_result_117
        local ____t_result_120
        local ____t_119 = __t
        local ____TS__Number_result_118 = __TS__Number(s.camera)
        __O[1527] = ____TS__Number_result_118
        if ____t_119(____TS__Number_result_118) then
            ____t_result_120 = __O[1527]
        else
            ____t_result_120 = 0
        end
        local cam = ____t_result_120
        for ____, k in __iterar((list)) do
            do
                if __t(__lt(k.x, cam - 80) or __gt(k.x, cam + 1040)) then
                    continue
                end
                if k.state == "away" then
                    continue
                end
                local ____t_126 = __t
                local ____t_result_125
                local ____t_124 = __t
                local ____t_result_123
                local ____t_122 = __t
                local ____t_result_121
                if __t(s.gapAt) then
                    ____t_result_121 = __ge(k.y, FLOOR - 1)
                else
                    ____t_result_121 = s.gapAt
                end
                __O[1528] = ____t_result_121
                if ____t_122(____t_result_121) then
                    ____t_result_123 = s:gapAt(k.x)
                else
                    ____t_result_123 = __O[1528]
                end
                __O[1529] = ____t_result_123
                if ____t_124(____t_result_123) then
                    ____t_result_125 = k.type ~= "kite"
                else
                    ____t_result_125 = __O[1529]
                end
                if ____t_126(____t_result_125) then
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
