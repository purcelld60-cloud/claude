--!native
--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __gt, __isFiniteN, __mod, __ord, __arrL, __iterar, __t, __get, __len, __call, __add = __JSR.__lt, __JSR.__gt, __JSR.__isFiniteN, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__len, __JSR.__call, __JSR.__add
local ____lualib = require(script.Parent.lualib_bundle)
local Map = ____lualib.Map
local __TS__New = ____lualib.__TS__New
local __TS__Number = ____lualib.__TS__Number
local __TS__MathSign = ____lualib.__TS__MathSign
local __TS__Iterator = ____lualib.__TS__Iterator
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local FLOOR = 440
    local function clamp(____, v, a, b)
        return math.max(
            a,
            math.min(b, v)
        )
    end
    local function hash(____, i)
        local x = math.sin(i * 127.1 + 311.7) * 43758.5453
        return x - math.floor(x)
    end
    local calm = (function()
        do
            local function ____catch(e)
                return true, false
            end
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                return true, window:matchMedia("(prefers-reduced-motion: reduce)").matches
            end)
            if not ____try then
                ____hasReturned, ____returnValue = ____catch(____hasReturned)
            end
            if ____hasReturned then
                return ____returnValue
            end
        end
    end)(nil)
    local MEADOW = {
        ["0"] = __arrL({
            "#2f6e31",
            "#3e863d",
            "#5f9f3f",
            "#86b84a",
            "#a9cf5d"
        }, 5),
        ["7"] = __arrL({
            "#2c6a33",
            "#3a7f3a",
            "#4f9a40",
            "#73b34c",
            "#9ccd5c"
        }, 5)
    }
    local WEEDS = {
        ["1"] = 1,
        ["3"] = 1,
        ["4"] = 1,
        ["5"] = 1,
        ["9"] = 1
    }
    local WEED_COLORS = __arrL({"#3f6e3a", "#55873f", "#79a64a"}, 3)
    local DUST = {
        ["0"] = "#b8946a",
        ["7"] = "#8fb36a",
        ["2"] = "#8f8780",
        ["6"] = "#a58fbd",
        ["8"] = "#cdb594",
        ["10"] = "#c9a77f"
    }
    local heroPos = nil
    local springs = __TS__New(Map)
    local sparks = __arrL({}, 0)
    local shards = __arrL({}, 0)
    local clouds = __arrL({}, 0)
    local particles = __arrL({}, 0)
    local lines = __arrL({}, 0)
    local lastStep = nil
    local wasGround = true
    local lastVy = 0
    local squash = 0
    local squashV = 0
    local lastScene = -1
    local lastAttack = 0
    local function wind(self, t, x)
        local g = 0.55 + 0.45 * math.sin(t * 0.31)
        return (math.sin(t * 1.15 + x * 0.0042) * 0.62 + math.sin(t * 2.4 + x * 0.013) * 0.38) * g
    end
    local function dustColor(self, scene)
        local ____t_result_2
        local ____t_1 = __t
        local ____get_result_0 = __get(DUST, scene)
        __O[1530] = ____get_result_0
        if ____t_1(____get_result_0) then
            ____t_result_2 = __O[1530]
        else
            ____t_result_2 = "#bdb4a2"
        end
        return ____t_result_2
    end
    local function puff(self, x, y, vx, vy, size, color, life)
        local ____t_10 = __t
        local ____t_result_9
        local ____t_8 = __t
        local ____opt_5 = window.Graphics
        if ____opt_5 ~= nil then
            ____opt_5 = ____opt_5.isLite
        end
        local ____opt_result_7
        if ____opt_5 ~= nil then
            ____opt_result_7 = ____opt_5(____opt_5)
        end
        __O[1531] = ____opt_result_7
        if ____t_8(____opt_result_7) then
            ____t_result_9 = __len(particles) > 14 or math.random() < 0.5
        else
            ____t_result_9 = __O[1531]
        end
        if ____t_10(____t_result_9) then
            return
        end
        if __len(particles) > 70 then
            __call(particles, "shift")
        end
        __call(particles, "push", {
            x = x,
            y = y,
            vx = vx,
            vy = vy,
            size = size,
            color = color,
            life = life,
            max = life
        })
    end
    local function update(self, dt, s)
        local ____t_result_13
        local ____t_12 = __t
        local ____TS__Number_result_11 = __TS__Number(dt)
        __O[1532] = ____TS__Number_result_11
        if ____t_12(____TS__Number_result_11) then
            ____t_result_13 = __O[1532]
        else
            ____t_result_13 = 0
        end
        dt = clamp(nil, ____t_result_13, 0, 0.05)
        local p = s.player
        if __t(not __t(p) or not __isFiniteN(p.x)) then
            return
        end
        heroPos = {x = p.x, y = p.y, scene = s.scene}
        if s.scene ~= lastScene then
            __call(springs, "clear")
            particles = __arrL({}, 0)
            lines = __arrL({}, 0)
            lastScene = s.scene
            lastStep = nil
        end
        local moving = math.abs(p.vx) > 40
        local onGround = not not __t(p.ground) and not __t(s.vehicle)
        local color = dustColor(nil, s.scene)
        local ____t_result_16
        local ____t_15 = __t
        local ____TS__Number_result_14 = __TS__Number(p.anim)
        __O[1533] = ____TS__Number_result_14
        if ____t_15(____TS__Number_result_14) then
            ____t_result_16 = __O[1533]
        else
            ____t_result_16 = 0
        end
        local step = math.floor(____t_result_16 / math.pi)
        local ____t_22 = __t
        local ____t_result_21
        local ____t_20 = __t
        local ____t_result_19
        local ____t_18 = __t
        local ____t_result_17
        if __t(onGround) then
            ____t_result_17 = moving
        else
            ____t_result_17 = onGround
        end
        __O[1534] = ____t_result_17
        if ____t_18(____t_result_17) then
            ____t_result_19 = lastStep ~= nil
        else
            ____t_result_19 = __O[1534]
        end
        __O[1535] = ____t_result_19
        if ____t_20(____t_result_19) then
            ____t_result_21 = step ~= lastStep
        else
            ____t_result_21 = __O[1535]
        end
        if ____t_22(____t_result_21) then
            local ____t_result_25
            local ____t_24 = __t
            local ____temp_23 = -__TS__MathSign(p.vx)
            __O[1536] = ____temp_23
            if ____t_24(____temp_23) then
                ____t_result_25 = __O[1536]
            else
                ____t_result_25 = __TS__Number(-p.facing)
            end
            local back = ____t_result_25
            local fast = math.abs(p.vx) > 200
            do
                local i = 0
                while i < (__t(fast) and 3 or 2) do
                    puff(
                        nil,
                        p.x + back * (4 + i * 3),
                        p.y - 2,
                        back * (25 + math.random() * 35),
                        -12 - math.random() * 22,
                        2 + math.floor(math.random() * 2 + 0.5),
                        color,
                        0.32 + math.random() * 0.18
                    )
                    i = i + 1
                end
            end
        end
        lastStep = step
        local ____t_31 = __t
        local ____t_result_30
        local ____t_29 = __t
        local ____t_result_28
        local ____t_27 = __t
        local ____t_result_26
        if __t(wasGround) then
            ____t_result_26 = not __t(p.ground)
        else
            ____t_result_26 = wasGround
        end
        __O[1537] = ____t_result_26
        if ____t_27(____t_result_26) then
            ____t_result_28 = __lt(p.vy, -150)
        else
            ____t_result_28 = __O[1537]
        end
        __O[1538] = ____t_result_28
        if ____t_29(____t_result_28) then
            ____t_result_30 = not __t(s.vehicle)
        else
            ____t_result_30 = __O[1538]
        end
        if ____t_31(____t_result_30) then
            do
                local i = 0
                while i < 6 do
                    local d = __t(__mod(i, 2)) and 1 or -1
                    puff(
                        nil,
                        p.x + d * (3 + i),
                        p.y - 1,
                        d * (30 + i * 12),
                        -6 - i * 2,
                        3,
                        color,
                        0.34
                    )
                    i = i + 1
                end
            end
            squash = 0.14
            squashV = 0
        end
        local ____t_35 = __t
        local ____t_result_34
        local ____t_33 = __t
        local ____temp_32 = not __t(wasGround)
        __O[1539] = ____temp_32
        if ____t_33(____temp_32) then
            ____t_result_34 = p.ground
        else
            ____t_result_34 = __O[1539]
        end
        if ____t_35(____t_result_34) then
            local impact = clamp(nil, lastVy / 520, 0.25, 1.2)
            do
                local i = 0
                while i < math.floor(6 + impact * 6 + 0.5) do
                    local d = __t(__mod(i, 2)) and 1 or -1
                    puff(
                        nil,
                        p.x + d * (4 + math.random() * 8),
                        p.y - 1,
                        d * (50 + math.random() * 90) * impact,
                        -8 - math.random() * 30 * impact,
                        2 + math.floor(math.random() * 2 + 0.5),
                        color,
                        0.3 + math.random() * 0.25
                    )
                    i = i + 1
                end
            end
            squash = -0.2 * impact
            squashV = 0
            if impact > 0.7 then
                __call(lines, "push", {
                    x = p.x,
                    y = p.y,
                    age = 0,
                    life = 0.28,
                    kind = "ring",
                    size = impact
                })
            end
        end
        wasGround = not not __t(p.ground)
        lastVy = p.vy
        squashV = squashV + (-squash * 210 - squashV * 16) * dt
        squash = squash + squashV * dt
        if __t(math.abs(squash) < 0.002 and math.abs(squashV) < 0.01) then
            squash = 0
            squashV = 0
        end
        local ____t_37 = __t
        local ____t_result_36
        if __t(s.dashing) then
            ____t_result_36 = not __t(calm)
        else
            ____t_result_36 = s.dashing
        end
        if ____t_37(____t_result_36) then
            __call(
                lines,
                "push",
                {
                    x = p.x - p.facing * (18 + math.random() * 30),
                    y = p.y - 10 - math.random() * 50,
                    age = 0,
                    life = 0.2,
                    kind = "streak",
                    dir = p.facing,
                    len = 26 + math.random() * 30
                }
            )
        end
        if __t(__gt(p.attack, 0) and lastAttack <= 0) then
            __call(lines, "push", {
                x = p.x,
                y = p.y,
                age = 0,
                life = 0.2,
                kind = "smear",
                dir = p.facing,
                type = p.attackType
            })
        end
        local ____t_result_38
        if __t(p.attack) then
            ____t_result_38 = p.attack
        else
            ____t_result_38 = 0
        end
        lastAttack = ____t_result_38
        local ____opt_41 = window.Critters
        if ____opt_41 ~= nil then
            ____opt_41 = ____opt_41.update
        end
        if ____opt_41 ~= nil then
            ____opt_41(____opt_41, dt, s)
        end
        for ____, e in __iterar((sparks)) do
            e.life = e.life - dt
            e.x = e.x + e.vx * dt
            e.y = e.y + e.vy * dt
            e.vy = e.vy + 300 * dt
            e.vx = e.vx * math.exp(__TS__Number(-dt) * 5)
        end
        sparks = __call(
            sparks,
            "filter",
            function(____, e) return __gt(e.life, 0) end
        )
        for ____, e in __iterar((shards)) do
            e.life = e.life - dt
            e.x = e.x + e.vx * dt
            e.y = e.y + e.vy * dt
            e.vy = e.vy + 620 * dt
            e.rot = e.rot + e.vr * dt
            if __gt(e.y, FLOOR - 1) then
                e.y = FLOOR - 1
                e.vy = e.vy * -0.25
                e.vx = e.vx * 0.6
                e.vr = e.vr * 0.5
            end
        end
        shards = __call(
            shards,
            "filter",
            function(____, e) return __gt(e.life, 0) end
        )
        for ____, e in __iterar((clouds)) do
            e.life = e.life - dt
            e.x = e.x + e.vx * dt
            e.y = e.y + e.vy * dt
            e.vx = e.vx * math.exp(__TS__Number(-dt) * 2.6)
            e.r = e.r + e.grow * dt
        end
        clouds = __call(
            clouds,
            "filter",
            function(____, e) return __gt(e.life, 0) end
        )
        for ____, e in __iterar((particles)) do
            e.life = e.life - dt
            e.x = e.x + e.vx * dt
            e.y = e.y + e.vy * dt
            e.vx = e.vx * math.exp(__TS__Number(-dt) * 4)
            e.vy = e.vy + 40 * dt
        end
        particles = __call(
            particles,
            "filter",
            function(____, e) return __gt(e.life, 0) end
        )
        for ____, l in __iterar((lines)) do
            l.age = __add(l.age, dt)
        end
        lines = __call(
            lines,
            "filter",
            function(____, l) return __lt(l.age, l.life) end
        )
        if __len(lines) > 30 then
            __call(
                lines,
                "splice",
                0,
                __len(lines) - 30
            )
        end
        local ____t_result_45
        local ____t_44 = __t
        local ____get_result_43 = __get(MEADOW, s.scene)
        __O[1540] = ____get_result_43
        if ____t_44(____get_result_43) then
            ____t_result_45 = not __t(s.arena)
        else
            ____t_result_45 = __O[1540]
        end
        local meadow = ____t_result_45
        if __t(meadow) then
            local ____t_result_46
            if __t(onGround) then
                ____t_result_46 = math.abs(p.y - FLOOR) < 6
            else
                ____t_result_46 = onGround
            end
            local near = ____t_result_46
            local from = math.floor((p.x - 60) / 6)
            local to = math.ceil((p.x + 60) / 6)
            do
                local i = from
                while i <= to do
                    if not __t(__call(springs, "has", i)) then
                        __call(springs, "set", i, {d = 0, v = 0})
                    end
                    i = i + 1
                end
            end
            for ____, ____value in __iterar((springs)) do
                local i = ____value[1]
                local sp = ____value[2]
                local bx = i * 6 + 3
                local dx = bx - p.x
                local target = 0
                local ____t_48 = __t
                local ____t_result_47
                if __t(near) then
                    ____t_result_47 = math.abs(dx) < 22
                else
                    ____t_result_47 = near
                end
                if ____t_48(____t_result_47) then
                    local ____t_result_49
                    if __t(dx) then
                        ____t_result_49 = dx
                    else
                        ____t_result_49 = p.facing
                    end
                    target = __TS__MathSign(____t_result_49) * (1 - math.abs(dx) / 22) * 1.15 + clamp(nil, p.vx / 400, -0.5, 0.5) * (1 - math.abs(dx) / 22)
                end
                sp.v = sp.v + ((target - sp.d) * 120 - sp.v * 9) * dt
                sp.d = sp.d + sp.v * dt
                local ____t_53 = __t
                local ____t_result_52
                local ____t_51 = __t
                local ____temp_50 = math.abs(dx) > 90 and math.abs(sp.d) < 0.01
                __O[1541] = ____temp_50
                if ____t_51(____temp_50) then
                    ____t_result_52 = math.abs(sp.v) < 0.01
                else
                    ____t_result_52 = __O[1541]
                end
                if ____t_53(____t_result_52) then
                    __call(springs, "delete", i)
                end
            end
        end
    end
    local function heroScale(self, p, vehicle)
        local ____t_59 = __t
        local ____t_result_58
        local ____t_57 = __t
        local ____t_result_56
        local ____t_55 = __t
        local ____temp_54 = not __t(p)
        __O[1542] = ____temp_54
        if ____t_55(____temp_54) then
            ____t_result_56 = __O[1542]
        else
            ____t_result_56 = vehicle
        end
        __O[1543] = ____t_result_56
        if ____t_57(____t_result_56) then
            ____t_result_58 = __O[1543]
        else
            ____t_result_58 = calm
        end
        if ____t_59(____t_result_58) then
            return {sx = 1, sy = 1}
        end
        local sy = 1 + squash
        if not __t(p.ground) then
            local ____lt_result_60
            if __lt(p.vy, 0) then
                ____lt_result_60 = clamp(
                    nil,
                    __TS__Number(-p.vy) / 5200,
                    0,
                    0.07
                )
            else
                ____lt_result_60 = clamp(nil, p.vy / 9000, 0, 0.04)
            end
            sy = sy + ____lt_result_60
        end
        sy = clamp(nil, sy, 0.8, 1.12)
        return {
            sx = clamp(
                nil,
                1 / math.sqrt(sy),
                0.92,
                1.12
            ),
            sy = sy
        }
    end
    local function drawBack(self, c, s)
        local ____opt_63 = window.Critters
        if ____opt_63 ~= nil then
            ____opt_63 = ____opt_63.draw
        end
        if ____opt_63 ~= nil then
            ____opt_63(____opt_63, c, s)
        end
        for ____, l in __iterar((lines)) do
            if l.kind == "ring" then
                local k = l.age / l.life
                local w = (18 + k * 46) * l.size
                c:save()
                c.globalAlpha = (1 - k) * 0.7
                c.fillStyle = dustColor(nil, s.scene)
                do
                    local i = -6
                    while i <= 6 do
                        local x = math.floor(l.x + i / 6 * w + 0.5)
                        local y = math.floor(l.y - 2 - math.cos(i / 6 * math.pi / 2) * 5 * (1 - k) + 0.5)
                        c:fillRect(x, y, 3, 2)
                        i = i + 1
                    end
                end
                c:restore()
            end
        end
        for ____, l in __iterar((lines)) do
            if l.kind == "streak" then
                local k = l.age / l.life
                c:save()
                c.globalAlpha = (1 - k) * 0.55
                c.fillStyle = "#fff4d4"
                local ____c_67 = c
                local ____c_fillRect_68 = c.fillRect
                local ____l_x_66 = l.x
                local ____gt_result_65
                if __gt(l.dir, 0) then
                    ____gt_result_65 = l.len
                else
                    ____gt_result_65 = 0
                end
                ____c_fillRect_68(
                    ____c_67,
                    math.floor(____l_x_66 - ____gt_result_65 + 0.5),
                    math.floor(l.y + 0.5),
                    math.floor(l.len * (1 - k * 0.5) + 0.5),
                    2
                )
                c:restore()
            end
        end
    end
    local function drawFront(self, c, s)
        local ____t_result_71
        local ____t_70 = __t
        local ____TS__Number_result_69 = __TS__Number(s.time)
        __O[1544] = ____TS__Number_result_69
        if ____t_70(____TS__Number_result_69) then
            ____t_result_71 = __O[1544]
        else
            ____t_result_71 = 0
        end
        local t = ____t_result_71
        local ____t_result_74
        local ____t_73 = __t
        local ____TS__Number_result_72 = __TS__Number(s.camera)
        __O[1545] = ____TS__Number_result_72
        if ____t_73(____TS__Number_result_72) then
            ____t_result_74 = __O[1545]
        else
            ____t_result_74 = 0
        end
        local cam = ____t_result_74
        local ____t_80 = __t
        local ____opt_77 = window.Graphics
        if ____opt_77 ~= nil then
            ____opt_77 = ____opt_77.isLite
        end
        local ____opt_result_79
        if ____opt_77 ~= nil then
            ____opt_result_79 = ____opt_77(____opt_77)
        end
        local lite = not not ____t_80(____opt_result_79)
        for ____, e in __iterar((clouds)) do
            local k = e.life / e.max
            c:save()
            c.globalAlpha = math.min(0.55, k * 0.7)
            c.fillStyle = e.col
            local r = math.floor(e.r + 0.5)
            c:beginPath()
            c:arc(
                math.floor(e.x + 0.5),
                math.floor(e.y + 0.5),
                r,
                0,
                math.pi * 2
            )
            __call(c, "fill")
            c.globalAlpha = c.globalAlpha * 0.6
            c.fillStyle = "#f2f8c8"
            c:beginPath()
            c:arc(
                math.floor(e.x - r * 0.3 + 0.5),
                math.floor(e.y - r * 0.35 + 0.5),
                math.floor(r * 0.45 + 0.5),
                0,
                math.pi * 2
            )
            __call(c, "fill")
            c:restore()
        end
        for ____, e in __iterar((sparks)) do
            c:save()
            c.globalAlpha = math.min(1, e.life * 8)
            c.strokeStyle = e.col
            c.lineWidth = 2
            c:beginPath()
            c:moveTo(
                math.floor(e.x + 0.5),
                math.floor(e.y + 0.5)
            )
            c:lineTo(
                math.floor(e.x - e.vx * 0.025 + 0.5),
                math.floor(e.y - e.vy * 0.025 + 0.5)
            )
            c:stroke()
            c:restore()
        end
        for ____, e in __iterar((shards)) do
            c:save()
            c.globalAlpha = math.min(1, e.life * 3)
            c:translate(
                math.floor(e.x + 0.5),
                math.floor(e.y + 0.5)
            )
            c:rotate(math.floor(e.rot * 2 + 0.5) / 2)
            c.fillStyle = e.col
            c:fillRect(-2, -1, 4, 2)
            c:restore()
        end
        for ____, e in __iterar((particles)) do
            local k = e.life / e.max
            c:save()
            c.globalAlpha = clamp(nil, k * 1.4, 0, 0.85)
            c.fillStyle = e.color
            local z = math.max(
                1,
                math.floor(e.size * (1.6 - k * 0.6) + 0.5)
            )
            c:fillRect(
                math.floor(e.x - z / 2 + 0.5),
                math.floor(e.y - z / 2 + 0.5),
                z,
                z
            )
            c:restore()
        end
        for ____, l in __iterar((lines)) do
            if l.kind == "smear" then
                local k = l.age / l.life
                local gas = l.type == "fart"
                local r0 = 26 + k * 10
                c:save()
                c.globalAlpha = (1 - k) * 0.85
                c.fillStyle = __t(gas) and "#cfe58a" or "#fff6d6"
                do
                    local i = 0
                    while i <= 8 do
                        local a = -1.15 + i / 8 * 1.5
                        local x = l.x + l.dir * math.cos(a) * r0
                        local y = l.y - 36 + math.sin(a) * r0
                        local z = __t(i > 2 and i < 7) and 3 or 2
                        c:fillRect(
                            math.floor(x + 0.5),
                            math.floor(y + 0.5),
                            z,
                            z
                        )
                        i = i + 1
                    end
                end
                c:restore()
            end
        end
        if __t(lite) then
            return
        end
        local ____t_84 = __t
        local ____t_result_83
        local ____t_82 = __t
        local ____call_result_81 = __call(
            __arrL({
                0,
                1,
                3,
                4,
                5,
                7,
                9
            }, 7),
            "includes",
            s.scene
        )
        __O[1546] = ____call_result_81
        if ____t_82(____call_result_81) then
            ____t_result_83 = not __t(s.arena)
        else
            ____t_result_83 = __O[1546]
        end
        if ____t_84(____t_result_83) then
            do
                local i = 0
                while i < 22 do
                    local sp = 0.045 + hash(nil, i + 900) * 0.05
                    local k = __mod(
                        t * sp + hash(nil, i + 910),
                        1
                    )
                    local gust = wind(nil, t, i * 40)
                    local x = cam + 990 - k * 1060
                    local y = 60 + hash(nil, i + 920) * 340 + math.sin(t * 1.7 + i) * 16 + gust * 10
                    c:save()
                    c:translate(
                        math.floor(x + 0.5),
                        math.floor(y + 0.5)
                    )
                    c:rotate(t * (2 + hash(nil, i) * 3) + i)
                    c.globalAlpha = 0.9
                    local ____c_86 = c
                    local ____temp_85
                    if s.scene == 4 then
                        ____temp_85 = __get(
                            __arrL({"#ffb7c8", "#ffe08a", "#ffffff"}, 3),
                            __mod(i, 3)
                        )
                    else
                        ____temp_85 = __get(
                            __arrL({"#8fcf5a", "#c9a24a", "#e8783a", "#6aa84a"}, 4),
                            __mod(i, 4)
                        )
                    end
                    ____c_86.fillStyle = ____temp_85
                    c:fillRect(-3, -1, 6, 3)
                    c.fillStyle = "#00000022"
                    c:fillRect(-3, 1, 6, 1)
                    c:restore()
                    i = i + 1
                end
            end
        end
        local pal = __get(MEADOW, s.scene)
        local ____t_88 = __t
        local ____t_result_87
        if __t(pal) then
            ____t_result_87 = not __t(s.arena)
        else
            ____t_result_87 = pal
        end
        if ____t_88(____t_result_87) then
            local from = math.floor(cam / 6) - 1
            local to = math.ceil((cam + 960) / 6) + 1
            do
                local i = from
                while i <= to do
                    do
                        local ____t_90 = __t
                        local ____t_result_89
                        if __t(s.gapAt) then
                            ____t_result_89 = s:gapAt(i * 6 + 3)
                        else
                            ____t_result_89 = s.gapAt
                        end
                        if ____t_90(____t_result_89) then
                            do i = i + 1 continue end
                        end
                        local bx = i * 6 + 3
                        local h = 3 + math.floor(hash(nil, i) * 5) + (hash(nil, i + 50) > 0.9 and 3 or 0)
                        local sp = __call(springs, "get", i)
                        local ____t_result_91
                        if __t(sp) then
                            ____t_result_91 = sp.d
                        else
                            ____t_result_91 = 0
                        end
                        local push = ____t_result_91
                        local lean = wind(nil, t, bx) * (1 + h * 0.12) + push * (h * 0.9)
                        local col = __get(
                            pal,
                            math.floor(hash(nil, i + 9) * __len(pal))
                        )
                        c.fillStyle = __get(pal, 0)
                        c:fillRect(bx, FLOOR - 1, 2, 2)
                        do
                            local k = 1
                            while k <= h do
                                local f = k / h
                                local ox = math.floor(lean * f * f + 0.5)
                                local ____c_93 = c
                                local ____temp_92
                                if f > 0.7 then
                                    ____temp_92 = __get(
                                        pal,
                                        math.min(
                                            __len(pal) - 1,
                                            __call(pal, "indexOf", col) + 1
                                        )
                                    )
                                else
                                    ____temp_92 = col
                                end
                                ____c_93.fillStyle = ____temp_92
                                c:fillRect(bx + ox, FLOOR - k, 2, 2)
                                k = k + 2
                            end
                        end
                        if hash(nil, i + 77) > 0.965 then
                            local ox = math.floor(lean + 0.5)
                            c.fillStyle = hash(nil, i + 3) > 0.5 and "#f3d36a" or "#f2a2b2"
                            c:fillRect(bx + ox - 1, FLOOR - h - 2, 4, 3)
                        end
                    end
                    i = i + 1
                end
            end
        else
            local ____t_97 = __t
            local ____t_result_96
            local ____t_95 = __t
            local ____get_result_94 = __get(WEEDS, s.scene)
            __O[1547] = ____get_result_94
            if ____t_95(____get_result_94) then
                ____t_result_96 = not __t(s.arena)
            else
                ____t_result_96 = __O[1547]
            end
            if ____t_97(____t_result_96) then
                local from = math.floor(cam / 37) - 1
                local to = math.ceil((cam + 960) / 37) + 1
                do
                    local i = from
                    while i <= to do
                        do
                            if hash(nil, i + 13) < 0.62 then
                                do i = i + 1 continue end
                            end
                            local bx = i * 37 + math.floor(hash(nil, i) * 20)
                            local ____t_99 = __t
                            local ____t_result_98
                            if __t(s.gapAt) then
                                ____t_result_98 = s:gapAt(bx)
                            else
                                ____t_result_98 = s.gapAt
                            end
                            if ____t_99(____t_result_98) then
                                do i = i + 1 continue end
                            end
                            local ____t_result_107
                            local ____t_103 = __t
                            local ____t_result_102
                            local ____t_101 = __t
                            local ____t_result_100
                            if __t(s.player) then
                                ____t_result_100 = math.abs(s.player.x - bx) < 18
                            else
                                ____t_result_100 = s.player
                            end
                            __O[1548] = ____t_result_100
                            if ____t_101(____t_result_100) then
                                ____t_result_102 = s.player.ground
                            else
                                ____t_result_102 = __O[1548]
                            end
                            if ____t_103(____t_result_102) then
                                local ____t_result_106
                                local ____t_105 = __t
                                local ____temp_104 = bx - s.player.x
                                __O[1549] = ____temp_104
                                if ____t_105(____temp_104) then
                                    ____t_result_106 = __O[1549]
                                else
                                    ____t_result_106 = 1
                                end
                                ____t_result_107 = __TS__MathSign(____t_result_106) * 2
                            else
                                ____t_result_107 = 0
                            end
                            local near = ____t_result_107
                            do
                                local j = 0
                                while j < 3 do
                                    local h = 4 + math.floor(hash(nil, i * 3 + j) * 5)
                                    local lean = math.floor(wind(nil, t, bx) * 1.6 + near + 0.5)
                                    c.fillStyle = __get(WEED_COLORS, j)
                                    c:fillRect(bx + j * 2, FLOOR - h + 2, 2, h - 2)
                                    c:fillRect(bx + j * 2 + lean, FLOOR - h, 2, 2)
                                    j = j + 1
                                end
                            end
                        end
                        i = i + 1
                    end
                end
            end
        end
    end
    local function impact(self, x, y, color, power, dir)
        local ____t_113 = __t
        local ____opt_110 = window.Graphics
        if ____opt_110 ~= nil then
            ____opt_110 = ____opt_110.isLite
        end
        local ____opt_result_112
        if ____opt_110 ~= nil then
            ____opt_result_112 = ____opt_110(____opt_110)
        end
        local lite = not not ____t_113(____opt_result_112)
        local ____t_result_115
        if __t(lite) then
            ____t_result_115 = 3
        else
            local ____t_result_114
            if __t(power) then
                ____t_result_114 = power
            else
                ____t_result_114 = 10
            end
            ____t_result_115 = math.min(
                14,
                5 + math.floor(____t_result_114 / 6 + 0.5)
            )
        end
        local n = ____t_result_115
        do
            local i = 0
            while i < n do
                local ____temp_117 = (math.random() - 0.5) * 2.4
                local ____lt_result_116
                if __lt(dir, 0) then
                    ____lt_result_116 = math.pi
                else
                    ____lt_result_116 = 0
                end
                local a = ____temp_117 + ____lt_result_116
                local sp = 160 + math.random() * 260
                local ____call_125 = __call
                local ____sparks_124 = sparks
                local ____x_119 = x
                local ____y_120 = y
                local ____temp_121 = math.cos(a) * sp
                local ____temp_122 = math.sin(a) * sp - 40
                local ____temp_123 = 0.12 + math.random() * 0.14
                local ____t_result_118
                if __t(__mod(i, 3)) then
                    ____t_result_118 = color
                else
                    ____t_result_118 = "#fff6d8"
                end
                ____call_125(____sparks_124, "push", {
                    x = ____x_119,
                    y = ____y_120,
                    vx = ____temp_121,
                    vy = ____temp_122,
                    life = ____temp_123,
                    col = ____t_result_118
                })
                i = i + 1
            end
        end
        if not __t(lite) then
            do
                local i = 0
                while true do
                    local ____i_132 = i
                    local ____t_result_131
                    if __t(power) then
                        ____t_result_131 = power
                    else
                        ____t_result_131 = 10
                    end
                    if not (____i_132 < math.min(
                        8,
                        2 + math.floor(____t_result_131 / 10 + 0.5)
                    )) then
                        break
                    end
                    local ____call_130 = __call
                    local ____shards_129 = shards
                    local ____x_127 = x
                    local ____y_128 = y
                    local ____t_result_126
                    if __t(dir) then
                        ____t_result_126 = dir
                    else
                        ____t_result_126 = 1
                    end
                    ____call_130(
                        ____shards_129,
                        "push",
                        {
                            x = ____x_127,
                            y = ____y_128,
                            vx = ____t_result_126 * (40 + math.random() * 120) + (math.random() - 0.5) * 80,
                            vy = -80 - math.random() * 160,
                            rot = math.random() * 6,
                            vr = (math.random() - 0.5) * 20,
                            life = 0.5 + math.random() * 0.4,
                            col = math.random() > 0.5 and "#f3ead2" or color
                        }
                    )
                    i = i + 1
                end
            end
        end
        if __len(sparks) > 60 then
            __call(
                sparks,
                "splice",
                0,
                __len(sparks) - 60
            )
        end
        if __len(shards) > 40 then
            __call(
                shards,
                "splice",
                0,
                __len(shards) - 40
            )
        end
    end
    local function gas(self, x, y, dir, stage)
        local ____t_138 = __t
        local ____opt_135 = window.Graphics
        if ____opt_135 ~= nil then
            ____opt_135 = ____opt_135.isLite
        end
        local ____opt_result_137
        if ____opt_135 ~= nil then
            ____opt_result_137 = ____opt_135(____opt_135)
        end
        local lite = not not ____t_138(____opt_result_137)
        local n = __t(lite) and 3 or 6 + stage * 4
        do
            local i = 0
            while i < n do
                __call(
                    clouds,
                    "push",
                    {
                        x = x + dir * (6 + math.random() * 20),
                        y = y + (math.random() - 0.5) * 14,
                        vx = dir * (60 + math.random() * 140 * stage) + (math.random() - 0.5) * 40,
                        vy = -10 - math.random() * 30,
                        r = 6 + math.random() * 8,
                        grow = 22 + stage * 10,
                        life = 0.7 + math.random() * 0.5,
                        max = 1.2,
                        col = stage == 3 and "#d9ee86" or "#bfdc66"
                    }
                )
                i = i + 1
            end
        end
        if __len(clouds) > 50 then
            __call(
                clouds,
                "splice",
                0,
                __len(clouds) - 50
            )
        end
    end
    local function burst(self, x, y, color, n)
        do
            local i = 0
            while __lt(i, n) do
                puff(
                    nil,
                    x,
                    y,
                    (math.random() - 0.5) * 120,
                    -20 - math.random() * 50,
                    2,
                    color,
                    0.35
                )
                i = i + 1
            end
        end
    end
    local ____opt_146 = window.Graphics
    if ____opt_146 ~= nil then
        ____opt_146 = ____opt_146.onChange
    end
    if ____opt_146 ~= nil then
        ____opt_146(
            ____opt_146,
            function()
                local ____opt_142 = window.Critters
                if ____opt_142 ~= nil then
                    ____opt_142 = ____opt_142.reset
                end
                local ____opt_result_144
                if ____opt_142 ~= nil then
                    ____opt_result_144 = ____opt_142(____opt_142)
                end
                return ____opt_result_144
            end
        )
    end
    window.SceneLife = __ord(
        {
            update = update,
            drawBack = drawBack,
            drawFront = drawFront,
            heroScale = heroScale,
            burst = burst,
            impact = impact,
            gas = gas,
            hero = function() return heroPos end
        },
        "update,drawBack,drawFront,heroScale,burst,impact,gas,hero"
    )
end)(nil)
return ____exports
