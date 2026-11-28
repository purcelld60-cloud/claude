--!native
--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __gt, __callq, __mod, __ord, __arrL, __iterar, __t, __get, __len, __call, __iter = __JSR.__lt, __JSR.__gt, __JSR.__callq, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__len, __JSR.__call, __JSR.__iter
local __assign, __hypot = __JSR.__assign, __JSR.__hypot
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local __TS__Iterator = ____lualib.__TS__Iterator
local Map = ____lualib.Map
local __TS__New = ____lualib.__TS__New
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local A = window.ArenaArt
    local ____t_3 = __t
    local ____t_result_2
    local ____t_1 = __t
    local ____temp_0 = not __t(A)
    __O[2720] = ____temp_0
    if ____t_1(____temp_0) then
        ____t_result_2 = __O[2720]
    else
        ____t_result_2 = window.ArenaFx
    end
    if ____t_3(____t_result_2) then
        return
    end
    local function lite()
        local ____t_9 = __t
        local ____opt_6 = window.Graphics
        if ____opt_6 ~= nil then
            ____opt_6 = ____opt_6.isLite
        end
        local ____opt_result_8
        if ____opt_6 ~= nil then
            ____opt_result_8 = ____opt_6(____opt_6)
        end
        return not not ____t_9(____opt_result_8)
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
        local ____t_result_15
        local ____t_14 = __t
        local ____opt_result_12
        if camera ~= nil then
            ____opt_result_12 = camera.x
        end
        local ____TS__Number_result_13 = __TS__Number(____opt_result_12)
        __O[2721] = ____TS__Number_result_13
        if ____t_14(____TS__Number_result_13) then
            ____t_result_15 = __O[2721]
        else
            ____t_result_15 = 640
        end
        local cx = ____t_result_15
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
                    local side = __t(__mod(i, 2)) and 1 or -1
                    local x = fx + row * 10
                    local ____t_result_16
                    if __t(i) then
                        ____t_result_16 = side * row * 6
                    else
                        ____t_result_16 = 0
                    end
                    local y = fy + ____t_result_16
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
                    __mod(i, 3) == 0 and "#ffb7c8" or (__mod(i, 3) == 1 and "#8fcf5a" or "#ffe08a")
                )
                c:restore()
                i = i + 1
            end
        end
    end
    local function stage(self, c, platforms, t)
        local ____iter_33 = __iter
        local ____t_result_32
        if __t(platforms) then
            ____t_result_32 = platforms
        else
            ____t_result_32 = __arrL({}, 0)
        end
        for ____, p in __TS__Iterator(____iter_33(____t_result_32)) do
            local ____t_result_19
            local ____t_18 = __t
            local ____TS__Number_result_17 = __TS__Number(p.x)
            __O[2722] = ____TS__Number_result_17
            if ____t_18(____TS__Number_result_17) then
                ____t_result_19 = __O[2722]
            else
                ____t_result_19 = 0
            end
            local x = ____t_result_19
            local ____t_result_22
            local ____t_21 = __t
            local ____TS__Number_result_20 = __TS__Number(p.y)
            __O[2723] = ____TS__Number_result_20
            if ____t_21(____TS__Number_result_20) then
                ____t_result_22 = __O[2723]
            else
                ____t_result_22 = 0
            end
            local y = ____t_result_22
            local ____t_result_25
            local ____t_24 = __t
            local ____TS__Number_result_23 = __TS__Number(p.w)
            __O[2724] = ____TS__Number_result_23
            if ____t_24(____TS__Number_result_23) then
                ____t_result_25 = __O[2724]
            else
                ____t_result_25 = 100
            end
            local w = ____t_result_25
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
                        rnd(nil, gx + 1) > 0.5 and "#3f9a3a" or "#6cc44a"
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
            local depth = __t(main) and 120 or 44
            do
                local i = 0
                while i < math.max(
                    2,
                    math.floor(w / 70)
                ) do
                    local ____temp_30 = x + 20
                    local ____temp_29 = i * (w - 40)
                    local ____t_result_28
                    local ____t_27 = __t
                    local ____temp_26 = math.floor(w / 70) - 1
                    __O[2725] = ____temp_26
                    if ____t_27(____temp_26) then
                        ____t_result_28 = __O[2725]
                    else
                        ____t_result_28 = 1
                    end
                    local vx = ____temp_30 + ____temp_29 / math.max(1, ____t_result_28)
                    local len = 18 + rnd(nil, vx) * (__t(main) and 60 or 26)
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
                                __mod(k, 12) == 0 and "#7ccf5a" or "#3a7a3a"
                            )
                            k = k + 4
                        end
                    end
                    i = i + 1
                end
            end
            do
                local i = 0
                while i < (__t(main) and 5 or 2) do
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
                while i < (__t(main) and 4 or 1) do
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
                    local ____temp_31
                    if side < 0 then
                        ____temp_31 = x + 40
                    else
                        ____temp_31 = x + w - 40
                    end
                    local mx = ____temp_31
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
        local ____t_result_36
        local ____t_35 = __t
        local ____TS__Number_result_34 = __TS__Number(p.attackProgress)
        __O[2726] = ____TS__Number_result_34
        if ____t_35(____TS__Number_result_34) then
            ____t_result_36 = __O[2726]
        else
            ____t_result_36 = 0
        end
        local prog = ____t_result_36
        local ____t_40 = __t
        local ____t_result_39
        local ____t_38 = __t
        local ____temp_37 = not __gt(p.attackAnim, 0) or prog < 0.16
        __O[2727] = ____temp_37
        if ____t_38(____temp_37) then
            ____t_result_39 = __O[2727]
        else
            ____t_result_39 = prog > 0.72
        end
        if ____t_40(____t_result_39) then
            return
        end
        local k = (prog - 0.16) / 0.56
        local face = __lt(p.facing, 0) and -1 or 1
        local ____t_result_41
        if __t(p.attackDirection) then
            ____t_result_41 = p.attackDirection
        else
            ____t_result_41 = "side"
        end
        local dir = ____t_result_41
        local ranged = p.attackType == "ranged"
        local combo = p.attackType == "combo"
        local cx = p.x + face * (__t(ranged) and 10 or 16)
        local cy = p.y - 36
        local r = __t(ranged) and 26 or (__t(combo) and 50 or 40)
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
        local ____t_45 = __t
        local ____t_result_44
        local ____t_43 = __t
        local ____temp_42 = face < 0 and dir ~= "up"
        __O[2728] = ____temp_42
        if ____t_43(____temp_42) then
            ____t_result_44 = dir ~= "down"
        else
            ____t_result_44 = __O[2728]
        end
        if ____t_45(____t_result_44) then
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
                c.strokeStyle = i == 0 and "#ffffff" or color
                c.lineCap = "round"
                c:stroke()
                i = i + 1
            end
        end
        c:restore()
    end
    local function fighter(self, c, p, t)
        local ____t_49 = __t
        local ____t_result_48
        local ____t_47 = __t
        local ____temp_46 = not __t(p) or p.stocks == 0
        __O[2729] = ____temp_46
        if ____t_47(____temp_46) then
            ____t_result_48 = __O[2729]
        else
            ____t_result_48 = p.eliminated
        end
        if ____t_49(____t_result_48) then
            return A:drawFighter(c, p, t)
        end
        local ____t_result_50
        if __t(p.id) then
            ____t_result_50 = p.id
        else
            ____t_result_50 = p.character
        end
        local id = ____t_result_50
        local ____t_result_53
        local ____t_52 = __t
        local ____call_result_51 = __call(hist, "get", id)
        __O[2730] = ____call_result_51
        if ____t_52(____call_result_51) then
            ____t_result_53 = __O[2730]
        else
            ____t_result_53 = {
                ghosts = __arrL({}, 0),
                spin = 0,
                lastT = t,
                puffs = __arrL({}, 0)
            }
        end
        local h = ____t_result_53
        __call(hist, "set", id, h)
        local dt = math.max(
            0,
            math.min(0.05, t - h.lastT)
        )
        h.lastT = t
        local ____t_result_56
        local ____t_55 = __t
        local ____TS__Number_result_54 = __TS__Number(p.vx)
        __O[2731] = ____TS__Number_result_54
        if ____t_55(____TS__Number_result_54) then
            ____t_result_56 = __O[2731]
        else
            ____t_result_56 = 0
        end
        local vx = ____t_result_56
        local ____t_result_59
        local ____t_58 = __t
        local ____TS__Number_result_57 = __TS__Number(p.vy)
        __O[2732] = ____TS__Number_result_57
        if ____t_58(____TS__Number_result_57) then
            ____t_result_59 = __O[2732]
        else
            ____t_result_59 = 0
        end
        local vy = ____t_result_59
        local speed = __hypot(vx, vy)
        local air = not __t(p.ground)
        local ____t_result_67
        local ____t_66 = __t
        local ____t_result_65
        if __t(air) then
            local ____gt_61 = __gt
            local ____t_result_60
            if __t(p.launch) then
                ____t_result_60 = p.launch
            else
                ____t_result_60 = 0
            end
            local ____gt_61_result_64 = ____gt_61(____t_result_60, 0)
            if not ____gt_61_result_64 then
                local ____gt_63 = __gt
                local ____t_result_62
                if __t(p.stun) then
                    ____t_result_62 = p.stun
                else
                    ____t_result_62 = 0
                end
                ____gt_61_result_64 = ____gt_63(____t_result_62, 0)
            end
            ____t_result_65 = ____gt_61_result_64
        else
            ____t_result_65 = air
        end
        __O[2733] = ____t_result_65
        if ____t_66(____t_result_65) then
            ____t_result_67 = speed > 330
        else
            ____t_result_67 = __O[2733]
        end
        local launched = ____t_result_67
        local ____t_result_68
        if __t(p.motion) then
            ____t_result_68 = p.motion
        else
            ____t_result_68 = "idle"
        end
        local motion = ____t_result_68
        local ____t_result_71
        local ____t_70 = __t
        local ____TS__Number_result_69 = __TS__Number(p.motionTime)
        __O[2734] = ____TS__Number_result_69
        if ____t_70(____TS__Number_result_69) then
            ____t_result_71 = __O[2734]
        else
            ____t_result_71 = 0
        end
        local mt = ____t_result_71
        local ____t_result_75
        local ____t_74 = __t
        local ____opt_72 = __callq(window.ArenaRoster, "get", p.character)
        if ____opt_72 ~= nil then
            ____opt_72 = ____opt_72.color
        end
        __O[2735] = ____opt_72
        if ____t_74(____opt_72) then
            ____t_result_75 = __O[2735]
        else
            ____t_result_75 = "#ffd27a"
        end
        local color = ____t_result_75
        local ____t_81 = __t
        local ____t_result_80
        local ____t_79 = __t
        local ____t_result_78
        local ____t_77 = __t
        local ____temp_76 = motion == "dash"
        __O[2736] = ____temp_76
        if ____t_77(____temp_76) then
            ____t_result_78 = __O[2736]
        else
            ____t_result_78 = launched
        end
        __O[2737] = ____t_result_78
        if ____t_79(____t_result_78) then
            ____t_result_80 = not __t(__len(h.ghosts)) or t - __get(
                h.ghosts,
                __len(h.ghosts) - 1
            ).t > 0.035
        else
            ____t_result_80 = __O[2737]
        end
        if ____t_81(____t_result_80) then
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
        local ____t_83 = __t
        local ____t_result_82
        if __t(launched) then
            ____t_result_82 = math.random() < 0.7
        else
            ____t_result_82 = launched
        end
        if ____t_83(____t_result_82) then
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
            rot = (__lt(p.facing, 0) and -1 or 1) * (mt / 0.32) * math.pi * 2
        end
        if __t(motion == "land" and mt < 0.14) then
            local k = 1 - mt / 0.14
            sy = 1 - 0.16 * k
            sx = 1 + 0.14 * k
        else
            local ____t_87 = __t
            local ____t_result_86
            local ____t_85 = __t
            local ____t_result_84
            if __t(air) then
                ____t_result_84 = not __t(launched)
            else
                ____t_result_84 = air
            end
            __O[2738] = ____t_result_84
            if ____t_85(____t_result_84) then
                ____t_result_86 = vy < -150
            else
                ____t_result_86 = __O[2738]
            end
            if ____t_87(____t_result_86) then
                sy = 1.07
                sx = 0.95
            elseif motion == "run" then
                sy = 1 + math.sin(t * 22) * 0.025
            end
        end
        local ____gt_89 = __gt
        local ____t_result_88
        if __t(p.hit) then
            ____t_result_88 = p.hit
        else
            ____t_result_88 = 0
        end
        if ____gt_89(____t_result_88, 0) then
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
        local ____gt_91 = __gt
        local ____t_result_90
        if __t(p.hit) then
            ____t_result_90 = p.hit
        else
            ____t_result_90 = 0
        end
        if ____gt_91(____t_result_90, 0) then
            local ____flash_94 = flash
            local ____array_93 = __TS__SparseArrayNew(nil, c, p, t)
            local ____t_result_92
            if __t(p.hit) then
                ____t_result_92 = p.hit
            else
                ____t_result_92 = 0
            end
            __TS__SparseArrayPush(
                ____array_93,
                math.min(0.85, ____t_result_92 / 0.18)
            )
            ____flash_94(__TS__SparseArraySpread(____array_93))
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
                                local ____sky_100 = sky
                                local ____c_98 = c
                                local ____camera_99 = camera
                                local ____t_result_97
                                local ____t_96 = __t
                                local ____TS__Number_result_95 = __TS__Number(t)
                                __O[2739] = ____TS__Number_result_95
                                if ____t_96(____TS__Number_result_95) then
                                    ____t_result_97 = __O[2739]
                                else
                                    ____t_result_97 = 0
                                end
                                ____sky_100(
                                    nil,
                                    ____c_98,
                                    ____camera_99,
                                    ____t_result_97,
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
                                local ____stage_106 = stage
                                local ____c_104 = c
                                local ____platforms_105 = platforms
                                local ____t_result_103
                                local ____t_102 = __t
                                local ____TS__Number_result_101 = __TS__Number(t)
                                __O[2740] = ____TS__Number_result_101
                                if ____t_102(____TS__Number_result_101) then
                                    ____t_result_103 = __O[2740]
                                else
                                    ____t_result_103 = 0
                                end
                                ____stage_106(nil, ____c_104, ____platforms_105, ____t_result_103)
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
                            local ____fighter_112 = fighter
                            local ____c_110 = c
                            local ____p_111 = p
                            local ____t_result_109
                            local ____t_108 = __t
                            local ____TS__Number_result_107 = __TS__Number(t)
                            __O[2741] = ____TS__Number_result_107
                            if ____t_108(____TS__Number_result_107) then
                                ____t_result_109 = __O[2741]
                            else
                                ____t_result_109 = 0
                            end
                            ____fighter_112(nil, ____c_110, ____p_111, ____t_result_109)
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
