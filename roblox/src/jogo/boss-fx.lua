--!native
--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __le, __gt, __ge, __mod, __ord, __arrL, __iterar, __t, __get, __len, __call = __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__len, __JSR.__call
local __add = __JSR.__add
local ____lualib = require(script.Parent.lualib_bundle)
local WeakMap = ____lualib.WeakMap
local __TS__New = ____lualib.__TS__New
local __TS__Number = ____lualib.__TS__Number
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__MathSign = ____lualib.__TS__MathSign
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
    local function R(____, c, x, y, w, h, col)
        c.fillStyle = col
        c:fillRect(
            math.floor(x + 0.5),
            math.floor(y + 0.5),
            w,
            h
        )
    end
    local COLORS = __ord({
        igor = "#f2c14e",
        kaique = "#7fb6e8",
        arthur = "#f08a5d",
        dede = "#c9d3c4",
        freddy = "#f4a04a",
        reeisBoss = "#ffd166",
        marco = "#ef5d5d",
        giant = "#f0a35b",
        nicolas = "#fff0aa",
        menezes = "#efbfd3",
        nikolas = "#a6d05d"
    }, "igor,kaique,arthur,dede,freddy,reeisBoss,marco,giant,nicolas,menezes,nikolas")
    local mem = __TS__New(WeakMap)
    local shotTrails = __TS__New(WeakMap)
    local function lite()
        local ____t_5 = __t
        local ____opt_2 = window.Graphics
        if ____opt_2 ~= nil then
            ____opt_2 = ____opt_2.isLite
        end
        local ____opt_result_4
        if ____opt_2 ~= nil then
            ____opt_result_4 = ____opt_2(____opt_2)
        end
        return not not ____t_5(____opt_result_4)
    end
    local function color(____, e)
        local ____t_7 = __t
        local ____get_result_6 = __get(COLORS, e.type)
        __O[1539] = ____get_result_6
        return if ____t_7(____get_result_6) then __O[1539] else "#ffe08b"
    end
    local function headY(____, e)
        return e.y - if e.type == "giant" then 205 else if e.type == "igor" then 92 * if __t(e.igorScale) then e.igorScale else 1 else if __t(e.type == "nikolas" and __ge(e.phase, 4)) then 230 else if __t(e.rage) then 130 else 100
    end
    local function state(self, e)
        local m = __call(mem, "get", e)
        if not __t(m) then
            m = {
                last = e.state,
                age = 0,
                ghosts = __arrL({}, 0),
                motes = __arrL({}, 0),
                rings = __arrL({}, 0),
                ghostT = 0,
                prevY = e.y,
                jitter = 0
            }
            __call(mem, "set", e, m)
        end
        return m
    end
    local function update(self, dt, s)
        local ____t_9 = __t
        local ____TS__Number_result_8 = __TS__Number(dt)
        __O[1540] = ____TS__Number_result_8
        dt = clamp(nil, if ____t_9(____TS__Number_result_8) then __O[1540] else 0, 0, 0.05)
        local e = s.boss
        if __t(not __t(e) or __le(e.hp, 0)) then
            return
        end
        local m = state(nil, e)
        local full = not __t(lite(nil))
        if __t(m.last ~= e.state and e.type == "igor") then
            if e.state == "bellyAir" then
                m.takeoff = 0
                local ____opt_12 = window.SceneLife
                if ____opt_12 ~= nil then
                    ____opt_12 = ____opt_12.burst
                end
                if ____opt_12 ~= nil then
                    ____opt_12(
                        ____opt_12,
                        e.x,
                        FLOOR - 3,
                        "#d9c39a",
                        if __t(full) then 14 else 5
                    )
                end
                __call(m.rings, "push", {
                    x = e.x,
                    y = FLOOR - 2,
                    age = 0,
                    life = 0.3,
                    size = 1.2,
                    col = "#d8c7a4",
                    dust = true
                })
            end
            if m.last == "bellyAir" then
                m.landed = 0
                m.crackX = e.x
                __call(m.rings, "push", {
                    x = e.x,
                    y = FLOOR - 2,
                    age = 0,
                    life = 0.5,
                    size = 2.4,
                    col = "#d8c7a4",
                    dust = true
                })
                local ____opt_16 = window.SceneLife
                if ____opt_16 ~= nil then
                    ____opt_16 = ____opt_16.impact
                end
                if ____opt_16 ~= nil then
                    ____opt_16(
                        ____opt_16,
                        e.x,
                        FLOOR - 8,
                        "#c9a87a",
                        40,
                        1
                    )
                end
                local ____opt_20 = window.SceneLife
                if ____opt_20 ~= nil then
                    ____opt_20 = ____opt_20.impact
                end
                if ____opt_20 ~= nil then
                    ____opt_20(
                        ____opt_20,
                        e.x,
                        FLOOR - 8,
                        "#c9a87a",
                        40,
                        -1
                    )
                end
                local ____opt_24 = window.SceneLife
                if ____opt_24 ~= nil then
                    ____opt_24 = ____opt_24.burst
                end
                if ____opt_24 ~= nil then
                    ____opt_24(
                        ____opt_24,
                        e.x,
                        FLOOR - 3,
                        "#d9c39a",
                        if __t(full) then 22 else 8
                    )
                end
            end
            if e.state == "firing" then
                m.clap = 0
                __call(m.rings, "push", {
                    x = e.x,
                    y = FLOOR - 2,
                    age = 0,
                    life = 0.4,
                    size = 1.8,
                    col = "#f2c14e",
                    dust = true
                })
            end
        end
        if e.type == "igor" then
            if m.landed ~= nil then
                m.landed = __add(m.landed, dt)
            end
            if m.clap ~= nil then
                m.clap = __add(m.clap, dt)
            end
            if m.takeoff ~= nil then
                m.takeoff = __add(m.takeoff, dt)
            end
            local ____t_30 = __t
            local ____t_29 = __t
            local ____t_27 = __t
            local ____temp_26 = e.state == "bellyRolling"
            __O[1541] = ____temp_26
            local ____temp_28 = if ____t_27(____temp_26) then full else __O[1541]
            __O[1542] = ____temp_28
            if ____t_30(if ____t_29(____temp_28) then math.random() < 0.6 else __O[1542]) then
                local ____opt_33 = window.SceneLife
                if ____opt_33 ~= nil then
                    ____opt_33 = ____opt_33.burst
                end
                if ____opt_33 ~= nil then
                    ____opt_33(
                        ____opt_33,
                        e.x - if __t(e.dashDir) then e.dashDir else 1 * 30,
                        FLOOR - 3,
                        "#d9c39a",
                        2
                    )
                end
            end
        end
        if m.last ~= e.state then
            m.last = e.state
            m.age = 0
            local ____t_37 = __t
            local ____t_36 = __t
            local ____temp_35 = e.state == "firing"
            __O[1543] = ____temp_35
            if ____t_37(if ____t_36(____temp_35) then full else __O[1543]) then
                __call(
                    m.rings,
                    "push",
                    {
                        x = e.x + if __t(if __t(s.player) then __lt(s.player.x, e.x) else s.player) then -30 else 30,
                        y = e.y - 42,
                        age = 0,
                        life = 0.25,
                        size = 0.6,
                        col = color(nil, e)
                    }
                )
            end
        else
            m.age = __add(m.age, dt)
        end
        local ____t_42 = __t
        local ____t_41 = __t
        local ____t_39 = __t
        local ____temp_38 = e.state == "windup"
        __O[1544] = ____temp_38
        local ____temp_40 = if ____t_39(____temp_38) then full else __O[1544]
        __O[1545] = ____temp_40
        if ____t_42(if ____t_41(____temp_40) then __lt(
            __len(m.motes),
            26
        ) else __O[1545]) then
            local a = math.random() * math.pi * 2
            local r = 70 + math.random() * 40
            __call(
                m.motes,
                "push",
                {
                    x = e.x + math.cos(a) * r,
                    y = e.y - 50 + math.sin(a) * r * 0.7,
                    life = 0.45
                }
            )
        end
        for ____, p in __iterar((m.motes)) do
            p.life = p.life - dt
            p.x = p.x + (e.x - p.x) * dt * 5
            p.y = p.y + (e.y - 50 - p.y) * dt * 5
        end
        m.motes = __call(
            m.motes,
            "filter",
            function(____, p) return __gt(p.life, 0) end
        )
        m.ghostT = m.ghostT - dt
        local ____t_47 = __t
        local ____t_46 = __t
        local ____t_44 = __t
        local ____temp_43 = e.state == "dashing" or e.state == "bellyRolling"
        __O[1546] = ____temp_43
        local ____temp_45 = if ____t_44(____temp_43) then __le(m.ghostT, 0) else __O[1546]
        __O[1547] = ____temp_45
        if ____t_47(if ____t_46(____temp_45) then full else __O[1547]) then
            __call(m.ghosts, "push", {x = e.x, y = e.y, face = if __t(if __t(s.player) then __lt(s.player.x, e.x) else s.player) then -1 else 1, life = 0.22})
            m.ghostT = 0.045
            if __gt(
                __len(m.ghosts),
                5
            ) then
                __call(m.ghosts, "shift")
            end
        end
        for ____, g in __iterar((m.ghosts)) do
            g.life = g.life - dt
        end
        m.ghosts = __call(
            m.ghosts,
            "filter",
            function(____, g) return __gt(g.life, 0) end
        )
        if __t(__lt(m.prevY, FLOOR - 12) and __ge(e.y, FLOOR - 1)) then
            __call(m.rings, "push", {
                x = e.x,
                y = FLOOR - 2,
                age = 0,
                life = 0.35,
                size = if e.type == "giant" then 1.6 else 1,
                col = "#d8c7a4",
                dust = true
            })
            local ____opt_50 = window.SceneLife
            if ____opt_50 ~= nil then
                ____opt_50 = ____opt_50.burst
            end
            if ____opt_50 ~= nil then
                ____opt_50(
                    ____opt_50,
                    e.x,
                    FLOOR - 3,
                    "#cdbb95",
                    if __t(full) then 10 else 4
                )
            end
        end
        m.prevY = e.y
        for ____, r in __iterar((m.rings)) do
            r.age = __add(r.age, dt)
        end
        m.rings = __call(
            m.rings,
            "filter",
            function(____, r) return __lt(r.age, r.life) end
        )
    end
    local function transform(self, e, player)
        local ____t_54 = __t
        local ____t_53 = __t
        local ____temp_52 = not __t(e) or __le(e.hp, 0)
        __O[1548] = ____temp_52
        if ____t_54(if ____t_53(____temp_52) then __O[1548] else e.state == "underground") then
            return nil
        end
        local m = state(nil, e)
        local face = if __t(if __t(player) then __lt(player.x, e.x) else player) then -1 else 1
        local sx = 1
        local sy = 1
        local dx = 0
        local rot = 0
        local py = 0
        if __t(e.type == "igor" and not __t(lite(nil))) then
            local sc = if __t(e.igorScale) then e.igorScale else 1
            local function jig(____, k, f)
                return math.sin(k * f) * math.exp(__TS__Number(-k) * 7)
            end
            py = 46 * sc
            if __t(e.state == "windup" and e.kind == "bellyBounce") then
                local k = clamp(nil, 1 - if __t(e.stateTimer) then e.stateTimer else 0 / if __t(e.windupDuration) then e.windupDuration else 1, 0, 1)
                sy = 1 - 0.2 * k
                sx = 1 + 0.16 * k
                dx = math.floor((math.random() - 0.5) * 3 * k + 0.5)
                return {
                    sx = sx,
                    sy = sy,
                    dx = dx,
                    rot = rot,
                    py = py
                }
            end
            if e.state == "bellyAir" then
                local k = clamp(nil, 1 - if __t(e.stateTimer) then e.stateTimer else 0 / if __t(e.bellyDuration) then e.bellyDuration else 1, 0, 1)
                local ____t_56 = __t
                local ____TS__MathSign_result_55 = __TS__MathSign(if __t(e.bellyTo) then e.bellyTo else e.x - if __t(e.bellyFrom) then e.bellyFrom else e.x)
                __O[1549] = ____TS__MathSign_result_55
                local dir = if ____t_56(____TS__MathSign_result_55) then __O[1549] else 1
                local ____ = dir
                if k < 0.25 then
                    sy = 1.18 - k * 0.7
                    sx = 0.88 + k * 0.45
                elseif k > 0.75 then
                    sy = 1.1
                    sx = 0.93
                end
                return {
                    sx = sx,
                    sy = sy,
                    dx = dx,
                    rot = rot,
                    py = py
                }
            end
            if __t(m.landed ~= nil and __lt(m.landed, 0.6)) then
                local k = m.landed
                sy = 1 - 0.3 * math.exp(__TS__Number(-k) * 9) + jig(nil, k, 30) * 0.08
                sx = 1 + 0.3 * math.exp(__TS__Number(-k) * 9) - jig(nil, k, 30) * 0.08
                return {
                    sx = sx,
                    sy = sy,
                    dx = dx,
                    rot = rot,
                    py = py
                }
            end
            if e.state == "bellyRolling" then
                sx = 1.05
                sy = 0.96
            else
                local ____t_59 = __t
                local ____t_58 = __t
                local ____temp_57 = e.state == "firing" and m.clap ~= nil
                __O[1550] = ____temp_57
                if ____t_59(if ____t_58(____temp_57) then __lt(m.clap, 0.5) else __O[1550]) then
                    local k = m.clap
                    sx = 1 + 0.18 * math.exp(__TS__Number(-k) * 8) + jig(nil, k, 34) * 0.06
                    sy = 1 - 0.12 * math.exp(__TS__Number(-k) * 8)
                    return {
                        sx = sx,
                        sy = sy,
                        dx = dx,
                        rot = rot,
                        py = py
                    }
                elseif __t(e.state == "idle" or e.state == "recover") then
                    local b = math.sin(window.performance:now() / 380) * 0.02
                    sx = 1 + b
                    sy = 1 - b * 0.6
                end
            end
        end
        if e.state == "windup" then
            local k = clamp(nil, 1 - if __t(e.stateTimer) then e.stateTimer else 0 / if __t(e.windupDuration) then e.windupDuration else 1, 0, 1)
            sy = 1 - 0.07 * k
            sx = 1 + 0.05 * k
            dx = -face * math.floor(k * 2 + 0.5)
        elseif e.state == "dashing" then
            sx = 1.07
            sy = 0.95
        elseif __t(e.state == "firing" and __lt(m.age, 0.14)) then
            dx = -face * math.floor((1 - m.age / 0.14) * 4 + 0.5)
            sy = 1.03
            sx = 0.98
        end
        if __t(__gt(e.hit, 0) and not __t(lite(nil))) then
            dx = dx + math.floor((math.random() - 0.5) * 4 + 0.5)
        end
        local ____t_64 = __t
        local ____t_63 = __t
        local ____t_61 = __t
        local ____temp_60 = sx == 1 and sy == 1
        __O[1551] = ____temp_60
        local ____temp_62 = if ____t_61(____temp_60) then dx == 0 else __O[1551]
        __O[1552] = ____temp_62
        if ____t_64(if ____t_63(____temp_62) then not __t(rot) else __O[1552]) then
            return nil
        end
        return {
            sx = sx,
            sy = sy,
            dx = dx,
            rot = rot,
            py = py
        }
    end
    local function drawBack(self, c, e, t)
        if __t(not __t(e) or __le(e.hp, 0)) then
            return
        end
        local m = __call(mem, "get", e)
        if not __t(m) then
            return
        end
        local col = color(nil, e)
        local full = not __t(lite(nil))
        local ____t_67 = __t
        local ____opt_65 = window.CharDetail
        if ____opt_65 ~= nil then
            ____opt_65 = ____opt_65.original
        end
        if ____t_67(if __t(full) then ____opt_65 else full) then
            for ____, g in __iterar((m.ghosts)) do
                c:save()
                c.globalAlpha = g.life / 0.22 * 0.28
                window.CharDetail:original(
                    c,
                    e.type,
                    g.x,
                    g.y,
                    {
                        facing = g.face,
                        frame = t,
                        dash = true,
                        moving = true,
                        grounded = __ge(g.y, FLOOR - 1),
                        bossPhase = e.phase,
                        scale = if __t(if __t(e.rage) then e.type == "marco" else e.rage) then 1.4 else 1
                    }
                )
                c:restore()
            end
        end
        if e.state == "windup" then
            local k = clamp(nil, 1 - if __t(e.stateTimer) then e.stateTimer else 0 / if __t(e.windupDuration) then e.windupDuration else 1, 0, 1)
            local pulse = 0.5 + 0.5 * math.sin(t * 20)
            c:save()
            c.globalAlpha = 0.25 + 0.35 * k * pulse
            c.fillStyle = col
            local w = 26 + k * 22
            do
                local i = -w
                while i <= w do
                    local h = math.floor(math.sqrt(math.max(0, 1 - (i / w) ^ 2)) * 4 + 0.5)
                    c:fillRect(
                        math.floor(e.x + i + 0.5),
                        FLOOR - h,
                        3,
                        h * 2
                    )
                    i = i + 3
                end
            end
            c:restore()
        end
        local ____t_72 = __t
        local ____t_71 = __t
        local ____t_69 = __t
        local ____temp_68 = e.type == "igor" and m.landed ~= nil
        __O[1553] = ____temp_68
        local ____temp_70 = if ____t_69(____temp_68) then __lt(m.landed, 1.1) else __O[1553]
        __O[1554] = ____temp_70
        if ____t_72(if ____t_71(____temp_70) then m.crackX ~= nil else __O[1554]) then
            local a = 1 - m.landed / 1.1
            c:save()
            c.globalAlpha = a
            c.fillStyle = "#3a2a1e"
            do
                local i = 0
                while i < 9 do
                    local ang = math.pi + i / 8 * math.pi
                    local len = 26 + __mod(i * 37, 40)
                    local x = m.crackX
                    local y = FLOOR - 1
                    do
                        local k = 0
                        while k < len do
                            x = x + (math.cos(ang) * 4 + (__mod(i * 13 + k, 3) - 1))
                            y = FLOOR - 1 + math.sin(ang) * k * 0.08
                            c:fillRect(
                                math.floor(x + 0.5),
                                math.floor(y + 0.5),
                                3,
                                2
                            )
                            k = k + 4
                        end
                    end
                    i = i + 1
                end
            end
            c:restore()
        end
        local ____t_75 = __t
        local ____t_74 = __t
        local ____temp_73 = e.type == "igor" and e.state == "bellyRolling"
        __O[1555] = ____temp_73
        if ____t_75(if ____t_74(____temp_73) then full else __O[1555]) then
            c:save()
            c.globalAlpha = 0.5
            c.fillStyle = "#fff4d4"
            do
                local i = 0
                while i < 6 do
                    local yy = e.y - 20 - i * 14
                    local len = 30 + __mod(i * 23, 40)
                    c:fillRect(
                        math.floor(e.x - if __t(e.dashDir) then e.dashDir else 1 * (60 + len) + 0.5),
                        yy,
                        len,
                        2
                    )
                    i = i + 1
                end
            end
            c:restore()
        end
        for ____, r in __iterar((m.rings)) do
            if __t(r.dust) then
                local k = r.age / r.life
                local w = (20 + k * 60) * r.size
                c:save()
                c.globalAlpha = (1 - k) * 0.7
                c.fillStyle = r.col
                do
                    local i = -8
                    while i <= 8 do
                        c:fillRect(
                            math.floor(r.x + i / 8 * w + 0.5),
                            math.floor(r.y - math.cos(i / 8 * math.pi / 2) * 6 * (1 - k) + 0.5),
                            3,
                            2
                        )
                        i = i + 1
                    end
                end
                c:restore()
            end
        end
    end
    local function drawFront(self, c, e, t)
        if __t(not __t(e) or __le(e.hp, 0)) then
            return
        end
        local m = __call(mem, "get", e)
        if not __t(m) then
            return
        end
        local col = color(nil, e)
        for ____, p in __iterar((m.motes)) do
            c.globalAlpha = clamp(nil, p.life * 3, 0, 1)
            R(
                nil,
                c,
                p.x,
                p.y,
                3,
                3,
                col
            )
            R(
                nil,
                c,
                p.x + 1,
                p.y + 1,
                1,
                1,
                "#ffffff"
            )
        end
        c.globalAlpha = 1
        for ____, r in __iterar((m.rings)) do
            if not __t(r.dust) then
                local k = r.age / r.life
                local rad = 8 + k * 26
                c:save()
                c.globalAlpha = 1 - k
                c.fillStyle = "#fff6d8"
                do
                    local i = 0
                    while i < 8 do
                        local a = i / 8 * math.pi * 2
                        R(
                            nil,
                            c,
                            r.x + math.cos(a) * rad - 2,
                            r.y + math.sin(a) * rad - 2,
                            4,
                            4,
                            if __t(__mod(i, 2)) then col else "#fff6d8"
                        )
                        i = i + 1
                    end
                end
                R(
                    nil,
                    c,
                    r.x - 5,
                    r.y - 5,
                    10,
                    10,
                    col
                )
                c:restore()
            end
        end
        if e.state == "recover" then
            local y = headY(nil, e) - 6
            do
                local i = 0
                while i < 3 do
                    local a = t * 5 + i * 2.09
                    local x = e.x + math.cos(a) * 18
                    local yy = y + math.sin(a) * 5
                    local s = if math.sin(a) > 0 then 2 else 1
                    c.fillStyle = "#ffe36b"
                    c:fillRect(
                        math.floor(x + 0.5) - s,
                        math.floor(yy + 0.5),
                        s * 2 + 1,
                        1
                    )
                    c:fillRect(
                        math.floor(x + 0.5),
                        math.floor(yy + 0.5) - s,
                        1,
                        s * 2 + 1
                    )
                    i = i + 1
                end
            end
        end
    end
    local function drawShotTrails(self, c, shots)
        if __t(lite(nil)) then
            return
        end
        for ____, s in __iterar((shots)) do
            local mine = s.owner ~= "enemy"
            local tr = __call(shotTrails, "get", s)
            if not __t(tr) then
                tr = __arrL({}, 0)
                __call(shotTrails, "set", s, tr)
            end
            __call(
                tr,
                "push",
                __arrL({s.x, s.y}, 2)
            )
            if __gt(
                __len(tr),
                6
            ) then
                __call(tr, "shift")
            end
            do
                local i = 0
                while i < __len(tr) - 1 do
                    local a = (i + 1) / __len(tr)
                    c.globalAlpha = a * 0.45
                    local z = math.max(
                        2,
                        math.floor(a * 6 + 0.5)
                    )
                    c.fillStyle = if __t(mine) then if s.element == "electric" then "#a9e7f4" else if s.element == "fire" then "#ffb064" else "#fff6e0" else if __t(s.enraged) then "#ff8a7a" else "#fff1c4"
                    c:fillRect(
                        math.floor(__get(
                            __get(tr, i),
                            0
                        ) - z / 2 + 0.5),
                        math.floor(__get(
                            __get(tr, i),
                            1
                        ) - z / 2 + 0.5),
                        z,
                        z
                    )
                    i = i + 1
                end
            end
        end
        c.globalAlpha = 1
    end
    local function igorPose(self, e)
        local ____t_78 = __t
        local ____t_77 = __t
        local ____temp_76 = not __t(e) or e.type ~= "igor"
        __O[1556] = ____temp_76
        if ____t_78(if ____t_77(____temp_76) then __O[1556] else lite(nil)) then
            return nil
        end
        local m = state(nil, e)
        if __t(e.state == "windup" and e.kind == "bellyBounce") then
            return {
                pose = "crouch",
                k = clamp(nil, 1 - if __t(e.stateTimer) then e.stateTimer else 0 / if __t(e.windupDuration) then e.windupDuration else 1, 0, 1)
            }
        end
        if e.state == "bellyAir" then
            local k = clamp(nil, 1 - if __t(e.stateTimer) then e.stateTimer else 0 / if __t(e.bellyDuration) then e.bellyDuration else 1, 0, 1)
            return {pose = if k < 0.45 then "rise" else if k < 0.8 then "fall" else "land", k = k}
        end
        if __t(m.landed ~= nil and __lt(m.landed, 0.3)) then
            return {pose = "land", k = 1}
        end
        return nil
    end
    window.BossFx = __ord({
        update = update,
        transform = transform,
        drawBack = drawBack,
        drawFront = drawFront,
        drawShotTrails = drawShotTrails,
        igorPose = igorPose
    }, "update,transform,drawBack,drawFront,drawShotTrails,igorPose")
end)(nil)
return ____exports
