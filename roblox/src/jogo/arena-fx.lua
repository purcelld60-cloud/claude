--!native
--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __D = {}
local __lt, __gt, __callq, __mod, __ord, __arrL, __iterar, __t, __get, __len, __call, __assign = __JSR.__lt, __JSR.__gt, __JSR.__callq, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__len, __JSR.__call, __JSR.__assign
local __hypot = __JSR.__hypot
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local __TS__Iterator = ____lualib.__TS__Iterator
local Map = ____lualib.Map
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local A = window.ArenaArt
    local ____t_2 = __t
    local ____t_1 = __t
    local ____temp_0 = not __t(A)
    __O[2715] = ____temp_0
    if ____t_2(if ____t_1(____temp_0) then __O[2715] else window.ArenaFx) then
        return
    end
    local function lite()
        local ____t_8 = __t
        local ____opt_5 = window.Graphics
        if ____opt_5 ~= nil then
            ____opt_5 = ____opt_5.isLite
        end
        local ____opt_result_7
        if ____opt_5 ~= nil then
            ____opt_result_7 = ____opt_5(____opt_5)
        end
        return not not ____t_8(____opt_result_7)
    end
    local function rnd(____, n)
        local x = math.sin(n * 63.71 + 9.13) * 43758.5453
        return x - math.floor(x)
    end
    local function R(____, c, x, y, w, h, col)
        c.fillStyle = col
        c:fillRect(
            math.floor(x + 0.5),
            math.floor(y + 0.5),
            math.floor(w + 0.5),
            math.floor(h + 0.5)
        )
    end
    local function sky(self, c, camera, t, W, H)
        local ____t_13 = __t
        local ____opt_result_11
        if camera ~= nil then
            ____opt_result_11 = camera.x
        end
        local ____TS__Number_result_12 = __TS__Number(____opt_result_11)
        __O[2716] = ____TS__Number_result_12
        local cx = if ____t_13(____TS__Number_result_12) then __O[2716] else 640
        local sunX = W * 0.76 - (cx - 640) * 0.006
        local sunY = H * 0.17
        c:save()
        c.globalCompositeOperation = "lighter"
        do
            local i = 0
            while i < 7 do
                local a = 1.95 + i * 0.13 + math.sin(t * 0.23 + i * 1.7) * 0.05
                local len = H * 1.4
                local w = 50 + __mod(i, 3) * 34
                local alpha = 0.03 + 0.02 * math.sin(t * 0.6 + i * 2.1)
                c:save()
                c:translate(sunX, sunY)
                c:rotate(a)
                local g = c:createLinearGradient(0, 0, len, 0)
                g:addColorStop(
                    0,
                    ("rgba(255,244,200," .. tostring(alpha * 1.3)) .. ")"
                )
                g:addColorStop(1, "rgba(255,244,200,0)")
                c.fillStyle = g
                c:beginPath()
                c:moveTo(0, -14)
                c:lineTo(len, -w)
                c:lineTo(len, w)
                c:lineTo(0, 14)
                c:closePath()
                __call(c, "fill")
                c:restore()
                i = i + 1
            end
        end
        local glow = c:createRadialGradient(
            sunX,
            sunY,
            4,
            sunX,
            sunY,
            150
        )
        glow:addColorStop(0, "rgba(255,240,190,.35)")
        glow:addColorStop(1, "rgba(255,240,190,0)")
        c.fillStyle = glow
        c:fillRect(sunX - 150, sunY - 150, 300, 300)
        c:restore()
        local bx = __mod(
            __mod(t * 6 - cx * 0.03, W + 200) + W + 200,
            W + 200
        ) - 100
        local by = H * 0.3 + math.sin(t * 0.4) * 8
        R(
            nil,
            c,
            bx - 9,
            by - 22,
            18,
            20,
            "#e2445c"
        )
        R(
            nil,
            c,
            bx - 11,
            by - 18,
            22,
            12,
            "#e2445c"
        )
        R(
            nil,
            c,
            bx - 3,
            by - 22,
            6,
            20,
            "#ffd24b"
        )
        R(
            nil,
            c,
            bx - 4,
            by + 2,
            8,
            6,
            "#8a5a3a"
        )
        R(
            nil,
            c,
            bx - 5,
            by - 2,
            1,
            4,
            "#3a2a20"
        )
        R(
            nil,
            c,
            bx + 4,
            by - 2,
            1,
            4,
            "#3a2a20"
        )
        local fp = __mod(t, 19) / 19
        if fp < 0.7 then
            local k = fp / 0.7
            local fx = W + 60 - k * (W + 160)
            local fy = H * 0.22 + math.sin(t) * 6
            do
                local i = 0
                while i < 7 do
                    local row = math.ceil(i / 2)
                    local side = if __t(__mod(i, 2)) then 1 else -1
                    local x = fx + row * 10
                    local y = fy + if __t(i) then side * row * 6 else 0
                    local f = math.floor(math.sin(t * 9 + i) * 2 + 0.5)
                    R(
                        nil,
                        c,
                        x - 3,
                        y - f,
                        3,
                        1,
                        "#2f5d7a"
                    )
                    R(
                        nil,
                        c,
                        x,
                        y,
                        2,
                        1,
                        "#2f5d7a"
                    )
                    R(
                        nil,
                        c,
                        x + 2,
                        y - f,
                        3,
                        1,
                        "#2f5d7a"
                    )
                    i = i + 1
                end
            end
        end
        c:save()
        do
            local i = 0
            while i < 3 do
                local x = __mod(i * 520 + t * 22, W + 700) - 350
                local g = c:createRadialGradient(
                    x,
                    H * 0.86,
                    10,
                    x,
                    H * 0.86,
                    260
                )
                g:addColorStop(0, "rgba(30,50,60,.16)")
                g:addColorStop(1, "rgba(30,50,60,0)")
                c.fillStyle = g
                c:save()
                c:translate(0, H * 0.86)
                c:scale(1, 0.3)
                c:translate(
                    0,
                    __TS__Number(-H) * 0.86
                )
                c:fillRect(x - 260, H * 0.86 - 260, 520, 520)
                c:restore()
                i = i + 1
            end
        end
        c:restore()
        do
            local i = 0
            while i < 26 do
                local k = __mod(
                    t * (0.05 + rnd(nil, i) * 0.05) + rnd(nil, i * 3),
                    1
                )
                local x = W + 30 - k * (W + 60)
                local y = H * (0.15 + rnd(nil, i * 5) * 0.7) + math.sin(t * 2 + i) * 18
                c:save()
                c:translate(x, y)
                c:rotate(t * 3 + i)
                R(
                    nil,
                    c,
                    -3,
                    -1.5,
                    6,
                    3,
                    if __mod(i, 3) == 0 then "#ffb7c8" else if __mod(i, 3) == 1 then "#8fcf5a" else "#ffe08a"
                )
                c:restore()
                i = i + 1
            end
        end
    end
    local function stage(self, c, platforms, t)
        for ____, p in __iterar((if __t(platforms) then platforms else __arrL({}, 0))) do
            local ____t_15 = __t
            local ____TS__Number_result_14 = __TS__Number(p.x)
            __O[2717] = ____TS__Number_result_14
            local x = if ____t_15(____TS__Number_result_14) then __O[2717] else 0
            local ____t_17 = __t
            local ____TS__Number_result_16 = __TS__Number(p.y)
            __O[2718] = ____TS__Number_result_16
            local y = if ____t_17(____TS__Number_result_16) then __O[2718] else 0
            local ____t_19 = __t
            local ____TS__Number_result_18 = __TS__Number(p.w)
            __O[2719] = ____TS__Number_result_18
            local w = if ____t_19(____TS__Number_result_18) then __O[2719] else 100
            local main = not not __t(p.main)
            do
                local gx = x + 4
                while gx < x + w - 4 do
                    local h = 4 + rnd(nil, gx) * 6
                    local sw = math.floor(math.sin(t * 2.2 + gx * 0.05) * 2 + 0.5)
                    R(
                        nil,
                        c,
                        gx,
                        y - h + 1,
                        2,
                        h,
                        if rnd(nil, gx + 1) > 0.5 then "#3f9a3a" else "#6cc44a"
                    )
                    R(
                        nil,
                        c,
                        gx + sw,
                        y - h - 1,
                        2,
                        2,
                        "#9be36a"
                    )
                    gx = gx + 7
                end
            end
            local depth = if __t(main) then 120 else 44
            do
                local i = 0
                while i < math.max(
                    2,
                    math.floor(w / 70)
                ) do
                    local ____temp_23 = x + 20
                    local ____temp_22 = i * (w - 40)
                    local ____t_21 = __t
                    local ____temp_20 = math.floor(w / 70) - 1
                    __O[2720] = ____temp_20
                    local vx = ____temp_23 + ____temp_22 / math.max(1, if ____t_21(____temp_20) then __O[2720] else 1)
                    local len = 18 + rnd(nil, vx) * if __t(main) then 60 else 26
                    do
                        local k = 0
                        while k < len do
                            local sx = math.sin(t * 1.6 + vx + k * 0.08) * k * 0.08
                            R(
                                nil,
                                c,
                                vx + sx,
                                y + depth * 0.3 + k,
                                2,
                                4,
                                if __mod(k, 12) == 0 then "#7ccf5a" else "#3a7a3a"
                            )
                            k = k + 4
                        end
                    end
                    i = i + 1
                end
            end
            do
                local i = 0
                while i < if __t(main) then 5 else 2 do
                    local k = __mod(
                        t * 0.5 + rnd(nil, i + x),
                        1
                    )
                    local px = x + 20 + rnd(nil, i * 7 + x) * (w - 40)
                    local py = y + depth * 0.6 + k * 140
                    c.globalAlpha = 1 - k
                    R(
                        nil,
                        c,
                        px,
                        py,
                        3,
                        3,
                        "#7a5a3a"
                    )
                    R(
                        nil,
                        c,
                        px + 4,
                        py - 6,
                        2,
                        2,
                        "#9a7a52"
                    )
                    i = i + 1
                end
            end
            c.globalAlpha = 1
            do
                local i = 0
                while i < if __t(main) then 4 else 1 do
                    local cx = x + w * (0.2 + i * 0.2)
                    local cy = y + depth * 0.55 + __mod(i, 2) * 14
                    local pulse = 0.5 + 0.5 * math.sin(t * 2 + i)
                    c:save()
                    c.globalCompositeOperation = "lighter"
                    local g = c:createRadialGradient(
                        cx,
                        cy,
                        1,
                        cx,
                        cy,
                        22
                    )
                    g:addColorStop(
                        0,
                        ("rgba(140,230,255," .. tostring(0.25 + 0.2 * pulse)) .. ")"
                    )
                    g:addColorStop(1, "rgba(140,230,255,0)")
                    c.fillStyle = g
                    c:fillRect(cx - 22, cy - 22, 44, 44)
                    c:restore()
                    c.fillStyle = "#9fe8ff"
                    c:beginPath()
                    c:moveTo(cx, cy - 8)
                    c:lineTo(cx + 4, cy)
                    c:lineTo(cx, cy + 6)
                    c:lineTo(cx - 4, cy)
                    c:closePath()
                    __call(c, "fill")
                    R(
                        nil,
                        c,
                        cx - 1,
                        cy - 5,
                        2,
                        3,
                        "#ffffff"
                    )
                    i = i + 1
                end
            end
            if __t(main) then
                for ____, side in __iterar((__arrL({-1, 1}, 2))) do
                    local mx = if side < 0 then x + 40 else x + w - 40
                    do
                        local i = 0
                        while i < 6 do
                            local k = __mod(t * 0.6 + i / 6, 1)
                            c.globalAlpha = (1 - k) * 0.35
                            c.fillStyle = "#e6fbff"
                            c:beginPath()
                            c:ellipse(
                                mx + math.sin(t + i) * 10,
                                y + 150 + k * 20,
                                8 + k * 16,
                                4 + k * 6,
                                0,
                                0,
                                math.pi * 2
                            )
                            __call(c, "fill")
                            i = i + 1
                        end
                    end
                end
                c.globalAlpha = 1
                do
                    local i = 0
                    while i < 10 do
                        local fx = x + rnd(nil, i) * w + math.sin(t * 0.8 + i) * 20
                        local fy = y - 30 - rnd(nil, i * 2) * 120 + math.cos(t * 0.9 + i) * 14
                        local a = 0.4 + 0.6 * math.abs(math.sin(t * 2 + i))
                        c.globalAlpha = a
                        R(
                            nil,
                            c,
                            fx,
                            fy,
                            2,
                            2,
                            "#fff6a8"
                        )
                        i = i + 1
                    end
                end
                c.globalAlpha = 1
            end
        end
    end
    local hist = __TS__New(Map)
    local OX = 130
    local OY = 180
    local buf = window.document:createElement("canvas")
    buf.width = 260
    buf.height = 230
    local bx = buf:getContext("2d")
    local function flash(self, c, p, t, alpha)
        bx:setTransform(
            1,
            0,
            0,
            1,
            0,
            0
        )
        bx.globalCompositeOperation = "source-over"
        bx.globalAlpha = 1
        bx:clearRect(0, 0, 260, 230)
        A:drawFighter(
            bx,
            __assign({}, p, {x = OX, y = OY}),
            t
        )
        bx.globalCompositeOperation = "source-in"
        bx.fillStyle = "#ffffff"
        bx:fillRect(0, 0, 260, 230)
        bx.globalCompositeOperation = "source-over"
        c:save()
        c.globalAlpha = c.globalAlpha * alpha
        c:drawImage(
            buf,
            math.floor(p.x + 0.5) - OX,
            math.floor(p.y + 0.5) - OY
        )
        c:restore()
    end
    local function smear(self, c, p, color)
        local ____t_25 = __t
        local ____TS__Number_result_24 = __TS__Number(p.attackProgress)
        __O[2721] = ____TS__Number_result_24
        local prog = if ____t_25(____TS__Number_result_24) then __O[2721] else 0
        local ____t_28 = __t
        local ____t_27 = __t
        local ____temp_26 = not __gt(p.attackAnim, 0) or prog < 0.16
        __O[2722] = ____temp_26
        if ____t_28(if ____t_27(____temp_26) then __O[2722] else prog > 0.72) then
            return
        end
        local k = (prog - 0.16) / 0.56
        local face = if __lt(p.facing, 0) then -1 else 1
        local dir = if __t(p.attackDirection) then p.attackDirection else "side"
        local ranged = p.attackType == "ranged"
        local combo = p.attackType == "combo"
        local cx = p.x + face * if __t(ranged) then 10 else 16
        local cy = p.y - 36
        local r = if __t(ranged) then 26 else if __t(combo) then 50 else 40
        local a0
        local a1
        if dir == "up" then
            a0 = math.pi * 1.05
            a1 = math.pi * 1.95
        elseif dir == "down" then
            a0 = math.pi * 0.05
            a1 = math.pi * 0.95
        else
            a0 = -1.1
            a1 = 1
        end
        local ____t_31 = __t
        local ____t_30 = __t
        local ____temp_29 = face < 0 and dir ~= "up"
        __O[2723] = ____temp_29
        if ____t_31(if ____t_30(____temp_29) then dir ~= "down" else __O[2723]) then
            a0 = math.pi - 1
            a1 = math.pi + 1.1
        end
        local head = a0 + (a1 - a0) * math.min(1, k * 1.4)
        local tail = a0 + (a1 - a0) * math.max(0, k * 1.4 - 0.55)
        c:save()
        c.globalAlpha = (1 - k) * 0.9
        do
            local i = 0
            while i < 3 do
                c:beginPath()
                c:arc(
                    cx,
                    cy,
                    r - i * 6,
                    tail,
                    head
                )
                c.lineWidth = (3 - i) * 4 * (1 - k * 0.5)
                c.strokeStyle = if i == 0 then "#ffffff" else color
                c.lineCap = "round"
                c:stroke()
                i = i + 1
            end
        end
        c:restore()
    end
    local function fighter(self, c, p, t)
        local ____t_34 = __t
        local ____t_33 = __t
        local ____temp_32 = not __t(p) or p.stocks == 0
        __O[2724] = ____temp_32
        if ____t_34(if ____t_33(____temp_32) then __O[2724] else p.eliminated) then
            return A:drawFighter(c, p, t)
        end
        local id = if __t(p.id) then p.id else p.character
        local ____t_36 = __t
        local ____call_result_35 = __call(hist, "get", id)
        __O[2725] = ____call_result_35
        local h = if ____t_36(____call_result_35) then __O[2725] else {
            ghosts = __arrL({}, 0),
            spin = 0,
            lastT = t,
            puffs = __arrL({}, 0)
        }
        __call(hist, "set", id, h)
        local dt = math.max(
            0,
            math.min(0.05, t - h.lastT)
        )
        h.lastT = t
        local ____t_38 = __t
        local ____TS__Number_result_37 = __TS__Number(p.vx)
        __O[2726] = ____TS__Number_result_37
        local vx = if ____t_38(____TS__Number_result_37) then __O[2726] else 0
        local ____t_40 = __t
        local ____TS__Number_result_39 = __TS__Number(p.vy)
        __O[2727] = ____TS__Number_result_39
        local vy = if ____t_40(____TS__Number_result_39) then __O[2727] else 0
        local speed = __hypot(vx, vy)
        local air = not __t(p.ground)
        local ____t_42 = __t
        local ____temp_41 = if __t(air) then __gt(if __t(p.launch) then p.launch else 0, 0) or __gt(if __t(p.stun) then p.stun else 0, 0) else air
        __O[2728] = ____temp_41
        local launched = if ____t_42(____temp_41) then speed > 330 else __O[2728]
        local motion = if __t(p.motion) then p.motion else "idle"
        local ____t_44 = __t
        local ____TS__Number_result_43 = __TS__Number(p.motionTime)
        __O[2729] = ____TS__Number_result_43
        local mt = if ____t_44(____TS__Number_result_43) then __O[2729] else 0
        local ____t_47 = __t
        local ____opt_45 = __callq(window.ArenaRoster, "get", p.character)
        if ____opt_45 ~= nil then
            ____opt_45 = ____opt_45.color
        end
        __O[2730] = ____opt_45
        local color = if ____t_47(____opt_45) then __O[2730] else "#ffd27a"
        local ____t_52 = __t
        local ____t_51 = __t
        local ____t_49 = __t
        local ____temp_48 = motion == "dash"
        __O[2731] = ____temp_48
        local ____temp_50 = if ____t_49(____temp_48) then __O[2731] else launched
        __O[2732] = ____temp_50
        __D[1] = if ____t_52(if ____t_51(____temp_50) then not __t(__len(h.ghosts)) or t - __get(
            h.ghosts,
            __len(h.ghosts) - 1
        ).t > 0.035 else __O[2732]) then
            __call(
                h.ghosts,
                "push",
                __assign({}, p, {t = t, a = 0.32})
            )
            if __gt(
                __len(h.ghosts),
                5
            ) then
                __call(h.ghosts, "shift")
            end
        end
        for ____, g in __iterar((h.ghosts)) do
            g.a = g.a - dt * 1.6
        end
        h.ghosts = __call(
            h.ghosts,
            "filter",
            function(____, g) return __gt(g.a, 0) end
        )
        for ____, g in __iterar((h.ghosts)) do
            c:save()
            c.globalAlpha = c.globalAlpha * g.a
            A:drawFighter(
                c,
                __assign({}, g, {hit = 0, attackAnim = 0}),
                t
            )
            c:restore()
        end
        if __t(if __t(launched) then math.random() < 0.7 else launched) then
            __call(
                h.puffs,
                "push",
                {
                    x = p.x,
                    y = p.y - 30,
                    life = 0.5,
                    r = 5 + math.random() * 5
                }
            )
            if __gt(
                __len(h.puffs),
                24
            ) then
                __call(h.puffs, "shift")
            end
        end
        for ____, q in __iterar((h.puffs)) do
            q.life = q.life - dt
            q.r = q.r + dt * 18
        end
        h.puffs = __call(
            h.puffs,
            "filter",
            function(____, q) return __gt(q.life, 0) end
        )
        c:save()
        for ____, q in __iterar((h.puffs)) do
            c.globalAlpha = q.life * 0.8
            c.fillStyle = "#eef2f4"
            c:beginPath()
            c:arc(
                q.x,
                q.y,
                q.r,
                0,
                math.pi * 2
            )
            __call(c, "fill")
            c.globalAlpha = q.life * 0.5
            c.fillStyle = "#cfd6da"
            c:beginPath()
            c:arc(
                q.x + 2,
                q.y + 2,
                q.r * 0.6,
                0,
                math.pi * 2
            )
            __call(c, "fill")
        end
        c:restore()
        local rot = 0
        local sx = 1
        local sy = 1
        local jx = 0
        if __t(launched) then
            h.spin = h.spin + vx / 260 * dt * 6
            rot = h.spin
        else
            h.spin = h.spin * 0.8
        end
        if __t(motion == "doubleJump" and mt < 0.32) then
            rot = if __lt(p.facing, 0) then -1 else 1 * (mt / 0.32) * math.pi * 2
        end
        if __t(motion == "land" and mt < 0.14) then
            local k = 1 - mt / 0.14
            sy = 1 - 0.16 * k
            sx = 1 + 0.14 * k
        else
            local ____t_55 = __t
            local ____t_54 = __t
            local ____temp_53 = if __t(air) then not __t(launched) else air
            __O[2733] = ____temp_53
            if ____t_55(if ____t_54(____temp_53) then vy < -150 else __O[2733]) then
                sy = 1.07
                sx = 0.95
            elseif motion == "run" then
                sy = 1 + math.sin(t * 22) * 0.025
            end
        end
        if __gt(if __t(p.hit) then p.hit else 0, 0) then
            jx = (math.random() - 0.5) * 5
        end
        c:save()
        if __t(rot) then
            c:translate(p.x, p.y - 34)
            c:rotate(rot)
            c:translate(
                __TS__Number(-p.x),
                -(p.y - 34)
            )
        end
        if __t(sx ~= 1 or sy ~= 1) then
            c:translate(p.x, p.y)
            c:scale(sx, sy)
            c:translate(
                __TS__Number(-p.x),
                __TS__Number(-p.y)
            )
        end
        if __t(jx) then
            c:translate(jx, 0)
        end
        A:drawFighter(c, p, t)
        if __gt(if __t(p.hit) then p.hit else 0, 0) then
            flash(
                nil,
                c,
                p,
                t,
                math.min(0.85, if __t(p.hit) then p.hit else 0 / 0.18)
            )
        end
        c:restore()
        smear(nil, c, p, color)
    end
    window.ArenaArt = __ord(
        __assign(
            {},
            A,
            {
                drawBackground = function(self, c, camera, t, W, H)
                    if W == nil then
                        W = 960
                    end
                    if H == nil then
                        H = 540
                    end
                    A:drawBackground(
                        c,
                        camera,
                        t,
                        W,
                        H
                    )
                    if not __t(lite(nil)) then
                        do
                            pcall(function()
                                local ____sky_60 = sky
                                local ____c_58 = c
                                local ____camera_59 = camera
                                local ____t_57 = __t
                                local ____TS__Number_result_56 = __TS__Number(t)
                                __O[2734] = ____TS__Number_result_56
                                ____sky_60(
                                    nil,
                                    ____c_58,
                                    ____camera_59,
                                    if ____t_57(____TS__Number_result_56) then __O[2734] else 0,
                                    W,
                                    H
                                )
                            end)
                        end
                    end
                end,
                drawStage = function(self, c, platforms, t)
                    A:drawStage(c, platforms, t)
                    if not __t(lite(nil)) then
                        do
                            pcall(function()
                                local ____stage_65 = stage
                                local ____c_63 = c
                                local ____platforms_64 = platforms
                                local ____t_62 = __t
                                local ____TS__Number_result_61 = __TS__Number(t)
                                __O[2735] = ____TS__Number_result_61
                                ____stage_65(nil, ____c_63, ____platforms_64, if ____t_62(____TS__Number_result_61) then __O[2735] else 0)
                            end)
                        end
                    end
                end,
                drawFighter = function(self, c, p, t)
                    if __t(lite(nil)) then
                        return A:drawFighter(c, p, t)
                    end
                    do
                        local function ____catch(e)
                            A:drawFighter(c, p, t)
                        end
                        local ____try, ____hasReturned = pcall(function()
                            local ____fighter_70 = fighter
                            local ____c_68 = c
                            local ____p_69 = p
                            local ____t_67 = __t
                            local ____TS__Number_result_66 = __TS__Number(t)
                            __O[2736] = ____TS__Number_result_66
                            ____fighter_70(nil, ____c_68, ____p_69, if ____t_67(____TS__Number_result_66) then __O[2736] else 0)
                        end)
                        if not ____try then
                            ____catch(____hasReturned)
                        end
                    end
                end
            }
        ),
        "drawBackground,drawStage,drawFighter"
    )
    window.ArenaFx = {version = 1}
end)(nil)
return ____exports
