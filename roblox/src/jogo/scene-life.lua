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
        local ____t_1 = __t
        local ____get_result_0 = __get(DUST, scene)
        __O[1510] = ____get_result_0
        return if ____t_1(____get_result_0) then __O[1510] else "#bdb4a2"
    end
    local function puff(self, x, y, vx, vy, size, color, life)
        local ____t_8 = __t
        local ____t_7 = __t
        local ____opt_4 = window.Graphics
        if ____opt_4 ~= nil then
            ____opt_4 = ____opt_4.isLite
        end
        local ____opt_result_6
        if ____opt_4 ~= nil then
            ____opt_result_6 = ____opt_4(____opt_4)
        end
        __O[1511] = ____opt_result_6
        if ____t_8(if ____t_7(____opt_result_6) then __len(particles) > 14 or math.random() < 0.5 else __O[1511]) then
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
        local ____t_10 = __t
        local ____TS__Number_result_9 = __TS__Number(dt)
        __O[1512] = ____TS__Number_result_9
        dt = clamp(nil, if ____t_10(____TS__Number_result_9) then __O[1512] else 0, 0, 0.05)
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
        local ____t_12 = __t
        local ____TS__Number_result_11 = __TS__Number(p.anim)
        __O[1513] = ____TS__Number_result_11
        local step = math.floor(if ____t_12(____TS__Number_result_11) then __O[1513] else 0 / math.pi)
        local ____t_17 = __t
        local ____t_16 = __t
        local ____t_14 = __t
        local ____temp_13 = if __t(onGround) then moving else onGround
        __O[1514] = ____temp_13
        local ____temp_15 = if ____t_14(____temp_13) then lastStep ~= nil else __O[1514]
        __O[1515] = ____temp_15
        if ____t_17(if ____t_16(____temp_15) then step ~= lastStep else __O[1515]) then
            local ____t_19 = __t
            local ____temp_18 = -__TS__MathSign(p.vx)
            __O[1516] = ____temp_18
            local back = if ____t_19(____temp_18) then __O[1516] else __TS__Number(-p.facing)
            local fast = math.abs(p.vx) > 200
            do
                local i = 0
                while i < if __t(fast) then 3 else 2 do
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
        local ____t_24 = __t
        local ____t_23 = __t
        local ____t_21 = __t
        local ____temp_20 = if __t(wasGround) then not __t(p.ground) else wasGround
        __O[1517] = ____temp_20
        local ____temp_22 = if ____t_21(____temp_20) then __lt(p.vy, -150) else __O[1517]
        __O[1518] = ____temp_22
        if ____t_24(if ____t_23(____temp_22) then not __t(s.vehicle) else __O[1518]) then
            do
                local i = 0
                while i < 6 do
                    local d = if __t(__mod(i, 2)) then 1 else -1
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
        local ____t_27 = __t
        local ____t_26 = __t
        local ____temp_25 = not __t(wasGround)
        __O[1519] = ____temp_25
        if ____t_27(if ____t_26(____temp_25) then p.ground else __O[1519]) then
            local impact = clamp(nil, lastVy / 520, 0.25, 1.2)
            do
                local i = 0
                while i < math.floor(6 + impact * 6 + 0.5) do
                    local d = if __t(__mod(i, 2)) then 1 else -1
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
        if __t(if __t(s.dashing) then not __t(calm) else s.dashing) then
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
        lastAttack = if __t(p.attack) then p.attack else 0
        local ____opt_30 = window.Critters
        if ____opt_30 ~= nil then
            ____opt_30 = ____opt_30.update
        end
        if ____opt_30 ~= nil then
            ____opt_30(____opt_30, dt, s)
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
        local ____t_33 = __t
        local ____get_result_32 = __get(MEADOW, s.scene)
        __O[1520] = ____get_result_32
        local meadow = if ____t_33(____get_result_32) then not __t(s.arena) else __O[1520]
        if __t(meadow) then
            local near = if __t(onGround) then math.abs(p.y - FLOOR) < 6 else onGround
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
                if __t(if __t(near) then math.abs(dx) < 22 else near) then
                    target = __TS__MathSign(if __t(dx) then dx else p.facing) * (1 - math.abs(dx) / 22) * 1.15 + clamp(nil, p.vx / 400, -0.5, 0.5) * (1 - math.abs(dx) / 22)
                end
                sp.v = sp.v + ((target - sp.d) * 120 - sp.v * 9) * dt
                sp.d = sp.d + sp.v * dt
                local ____t_36 = __t
                local ____t_35 = __t
                local ____temp_34 = math.abs(dx) > 90 and math.abs(sp.d) < 0.01
                __O[1521] = ____temp_34
                if ____t_36(if ____t_35(____temp_34) then math.abs(sp.v) < 0.01 else __O[1521]) then
                    __call(springs, "delete", i)
                end
            end
        end
    end
    local function heroScale(self, p, vehicle)
        local ____t_41 = __t
        local ____t_40 = __t
        local ____t_38 = __t
        local ____temp_37 = not __t(p)
        __O[1522] = ____temp_37
        local ____temp_39 = if ____t_38(____temp_37) then __O[1522] else vehicle
        __O[1523] = ____temp_39
        if ____t_41(if ____t_40(____temp_39) then __O[1523] else calm) then
            return {sx = 1, sy = 1}
        end
        local sy = 1 + squash
        if not __t(p.ground) then
            sy = sy + if __lt(p.vy, 0) then clamp(
                nil,
                __TS__Number(-p.vy) / 5200,
                0,
                0.07
            ) else clamp(nil, p.vy / 9000, 0, 0.04)
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
        local ____opt_44 = window.Critters
        if ____opt_44 ~= nil then
            ____opt_44 = ____opt_44.draw
        end
        if ____opt_44 ~= nil then
            ____opt_44(____opt_44, c, s)
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
                c:fillRect(
                    math.floor(l.x - if __gt(l.dir, 0) then l.len else 0 + 0.5),
                    math.floor(l.y + 0.5),
                    math.floor(l.len * (1 - k * 0.5) + 0.5),
                    2
                )
                c:restore()
            end
        end
    end
    local function drawFront(self, c, s)
        local ____t_47 = __t
        local ____TS__Number_result_46 = __TS__Number(s.time)
        __O[1524] = ____TS__Number_result_46
        local t = if ____t_47(____TS__Number_result_46) then __O[1524] else 0
        local ____t_49 = __t
        local ____TS__Number_result_48 = __TS__Number(s.camera)
        __O[1525] = ____TS__Number_result_48
        local cam = if ____t_49(____TS__Number_result_48) then __O[1525] else 0
        local ____t_55 = __t
        local ____opt_52 = window.Graphics
        if ____opt_52 ~= nil then
            ____opt_52 = ____opt_52.isLite
        end
        local ____opt_result_54
        if ____opt_52 ~= nil then
            ____opt_result_54 = ____opt_52(____opt_52)
        end
        local lite = not not ____t_55(____opt_result_54)
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
                c.fillStyle = if __t(gas) then "#cfe58a" else "#fff6d6"
                do
                    local i = 0
                    while i <= 8 do
                        local a = -1.15 + i / 8 * 1.5
                        local x = l.x + l.dir * math.cos(a) * r0
                        local y = l.y - 36 + math.sin(a) * r0
                        local z = if __t(i > 2 and i < 7) then 3 else 2
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
        local ____t_58 = __t
        local ____t_57 = __t
        local ____call_result_56 = __call(
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
        __O[1526] = ____call_result_56
        if ____t_58(if ____t_57(____call_result_56) then not __t(s.arena) else __O[1526]) then
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
                    c.fillStyle = if s.scene == 4 then __get(
                        __arrL({"#ffb7c8", "#ffe08a", "#ffffff"}, 3),
                        __mod(i, 3)
                    ) else __get(
                        __arrL({"#8fcf5a", "#c9a24a", "#e8783a", "#6aa84a"}, 4),
                        __mod(i, 4)
                    )
                    c:fillRect(-3, -1, 6, 3)
                    c.fillStyle = "#00000022"
                    c:fillRect(-3, 1, 6, 1)
                    c:restore()
                    i = i + 1
                end
            end
        end
        local pal = __get(MEADOW, s.scene)
        if __t(if __t(pal) then not __t(s.arena) else pal) then
            local from = math.floor(cam / 6) - 1
            local to = math.ceil((cam + 960) / 6) + 1
            do
                local i = from
                while i <= to do
                    if __t(if __t(s.gapAt) then s:gapAt(i * 6 + 3) else s.gapAt) then
                        continue
                    end
                    local bx = i * 6 + 3
                    local h = 3 + math.floor(hash(nil, i) * 5) + if hash(nil, i + 50) > 0.9 then 3 else 0
                    local sp = __call(springs, "get", i)
                    local push = if __t(sp) then sp.d else 0
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
                            c.fillStyle = if f > 0.7 then __get(
                                pal,
                                math.min(
                                    __len(pal) - 1,
                                    __call(pal, "indexOf", col) + 1
                                )
                            ) else col
                            c:fillRect(bx + ox, FLOOR - k, 2, 2)
                            k = k + 2
                        end
                    end
                    if hash(nil, i + 77) > 0.965 then
                        local ox = math.floor(lean + 0.5)
                        c.fillStyle = if hash(nil, i + 3) > 0.5 then "#f3d36a" else "#f2a2b2"
                        c:fillRect(bx + ox - 1, FLOOR - h - 2, 4, 3)
                    end
                    i = i + 1
                end
            end
        else
            local ____t_61 = __t
            local ____t_60 = __t
            local ____get_result_59 = __get(WEEDS, s.scene)
            __O[1527] = ____get_result_59
            if ____t_61(if ____t_60(____get_result_59) then not __t(s.arena) else __O[1527]) then
                local from = math.floor(cam / 37) - 1
                local to = math.ceil((cam + 960) / 37) + 1
                do
                    local i = from
                    while i <= to do
                        if hash(nil, i + 13) < 0.62 then
                            continue
                        end
                        local bx = i * 37 + math.floor(hash(nil, i) * 20)
                        if __t(if __t(s.gapAt) then s:gapAt(bx) else s.gapAt) then
                            continue
                        end
                        local ____t_64 = __t
                        local ____t_63 = __t
                        local ____temp_62 = if __t(s.player) then math.abs(s.player.x - bx) < 18 else s.player
                        __O[1528] = ____temp_62
                        local ____t_66 = __t
                        local ____temp_65 = bx - s.player.x
                        __O[1529] = ____temp_65
                        local near = if ____t_64(if ____t_63(____temp_62) then s.player.ground else __O[1528]) then __TS__MathSign(if ____t_66(____temp_65) then __O[1529] else 1) * 2 else 0
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
                        i = i + 1
                    end
                end
            end
        end
    end
    local function impact(self, x, y, color, power, dir)
        local ____t_72 = __t
        local ____opt_69 = window.Graphics
        if ____opt_69 ~= nil then
            ____opt_69 = ____opt_69.isLite
        end
        local ____opt_result_71
        if ____opt_69 ~= nil then
            ____opt_result_71 = ____opt_69(____opt_69)
        end
        local lite = not not ____t_72(____opt_result_71)
        local n = if __t(lite) then 3 else math.min(
            14,
            5 + math.floor(if __t(power) then power else 10 / 6 + 0.5)
        )
        do
            local i = 0
            while i < n do
                local a = (math.random() - 0.5) * 2.4 + if __lt(dir, 0) then math.pi else 0
                local sp = 160 + math.random() * 260
                __call(
                    sparks,
                    "push",
                    {
                        x = x,
                        y = y,
                        vx = math.cos(a) * sp,
                        vy = math.sin(a) * sp - 40,
                        life = 0.12 + math.random() * 0.14,
                        col = if __t(__mod(i, 3)) then color else "#fff6d8"
                    }
                )
                i = i + 1
            end
        end
        if not __t(lite) then
            do
                local i = 0
                while i < math.min(
                    8,
                    2 + math.floor(if __t(power) then power else 10 / 10 + 0.5)
                ) do
                    __call(
                        shards,
                        "push",
                        {
                            x = x,
                            y = y,
                            vx = if __t(dir) then dir else 1 * (40 + math.random() * 120) + (math.random() - 0.5) * 80,
                            vy = -80 - math.random() * 160,
                            rot = math.random() * 6,
                            vr = (math.random() - 0.5) * 20,
                            life = 0.5 + math.random() * 0.4,
                            col = if math.random() > 0.5 then "#f3ead2" else color
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
        local ____t_78 = __t
        local ____opt_75 = window.Graphics
        if ____opt_75 ~= nil then
            ____opt_75 = ____opt_75.isLite
        end
        local ____opt_result_77
        if ____opt_75 ~= nil then
            ____opt_result_77 = ____opt_75(____opt_75)
        end
        local lite = not not ____t_78(____opt_result_77)
        local n = if __t(lite) then 3 else 6 + stage * 4
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
                        col = if stage == 3 then "#d9ee86" else "#bfdc66"
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
    local ____opt_86 = window.Graphics
    if ____opt_86 ~= nil then
        ____opt_86 = ____opt_86.onChange
    end
    if ____opt_86 ~= nil then
        ____opt_86(
            ____opt_86,
            function()
                local ____opt_82 = window.Critters
                if ____opt_82 ~= nil then
                    ____opt_82 = ____opt_82.reset
                end
                local ____opt_result_84
                if ____opt_82 ~= nil then
                    ____opt_result_84 = ____opt_82(____opt_82)
                end
                return ____opt_result_84
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
