--!native
--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __gt, __ge, __mod, __ord, __arrL, __iterar, __t, __get, __call, __add, __assign = __JSR.__lt, __JSR.__gt, __JSR.__ge, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__call, __JSR.__add, __JSR.__assign
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local __TS__Iterator = ____lualib.__TS__Iterator
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    if __t(window.ChegadaCarro) then
        return
    end
    local DUR = 2.3
    local FLOOR = 440
    local ch = nil
    local fila = __arrL({}, 0)
    local function ease(____, u)
        return 1 - (1 - math.max(
            0,
            math.min(1, u)
        )) ^ 3
    end
    local function lerp(____, a, b, k)
        return a + (b - a) * k
    end
    local function clamp(____, v, a, b)
        return math.max(
            a,
            math.min(b, v)
        )
    end
    local function hash(____, n)
        local x = math.sin(n * 127.1 + 311.7) * 43758.5453
        return x - math.floor(x)
    end
    local function iniciar(self, cena)
        local ____t_result_2
        local ____t_1 = __t
        local ____TS__Number_result_0 = __TS__Number(cena)
        __O[698] = ____TS__Number_result_0
        if ____t_1(____TS__Number_result_0) then
            ____t_result_2 = __O[698]
        else
            ____t_result_2 = 0
        end
        ch = {
            cena = ____t_result_2,
            t = 0,
            parts = __arrL({}, 0)
        }
        return true
    end
    local function ativa(self)
        return not not __t(ch)
    end
    local function depois(self, fn)
        if type(fn) == "function" then
            if __t(ch) then
                __call(fila, "push", fn)
            else
                fn(nil)
            end
        end
    end
    local function atualizar(self, dt)
        if not __t(ch) then
            return false
        end
        ch.t = __add(ch.t, dt)
        for ____, p in __iterar((ch.parts)) do
            p.t = __add(p.t, dt)
            p.x = p.x + p.vx * dt
            p.y = p.y + p.vy * dt
            local ____p_4, ____vy_5 = p, "vy"
            local ____t_result_3
            if __t(p.g) then
                ____t_result_3 = p.g
            else
                ____t_result_3 = 0
            end
            ____p_4[____vy_5] = ____p_4[____vy_5] + ____t_result_3 * dt
        end
        ch.parts = __call(
            ch.parts,
            "filter",
            function(____, p) return __lt(p.t, p.vida) end
        )
        if __ge(ch.t, DUR) then
            ch = nil
            local f = fila
            fila = __arrL({}, 0)
            window:setTimeout(
                function() return __call(
                    f,
                    "forEach",
                    function(____, fn)
                        do
                            pcall(function()
                                fn(nil)
                            end)
                        end
                    end
                ) end,
                0
            )
            return false
        end
        return true
    end
    local function P(____, o)
        return __call(
            ch.parts,
            "push",
            __assign({
                t = 0,
                vx = 0,
                vy = 0,
                g = 0,
                vida = 0.8,
                tam = 3
            }, o)
        )
    end
    local ANIM = {
        ["0"] = function(____, u, x1, y1, t)
            local k = clamp(nil, u / 0.72, 0, 1)
            local x = lerp(
                nil,
                -140,
                x1,
                ease(nil, k)
            )
            local freio = __gt(u, 0.72) and __lt(u, 0.86)
            if __t(k < 1 and math.random() < 0.7) then
                P(
                    nil,
                    {
                        x = x - 40,
                        y = y1 - 4,
                        vx = -40 - math.random() * 40,
                        vy = -20 - math.random() * 20,
                        cor = "#d8c098",
                        vida = 0.7,
                        tam = 5 + math.random() * 4
                    }
                )
            end
            local ____x_8 = x
            local ____y1_7 = y1
            local ____temp_6
            if k < 1 then
                ____temp_6 = math.abs(math.sin(u * 34)) * 3
            else
                ____temp_6 = 0
            end
            return {
                x = ____x_8,
                y = ____y1_7 - ____temp_6,
                rot = __t(freio) and 0.08 or 0
            }
        end,
        ["1"] = function(____, u, x1, y1)
            local k = clamp(nil, u / 0.8, 0, 1)
            local y = lerp(
                nil,
                y1 - 430,
                y1,
                ease(nil, k)
            )
            local sw = math.sin(u * 14) * 0.12 * (1 - k)
            return {
                x = x1,
                y = y,
                rot = sw,
                antes = function(____, c)
                    if __t(k >= 1 and __gt(u, 0.92)) then
                        return
                    end
                    local ____temp_9
                    if k >= 1 then
                        ____temp_9 = 1 - (u - 0.8) / 0.2
                    else
                        ____temp_9 = 1
                    end
                    local a = ____temp_9
                    c.globalAlpha = clamp(nil, a, 0, 1)
                    local px = x1
                    local py = y - 120
                    do
                        local i = 0
                        while i < 6 do
                            c.fillStyle = __get(
                                __arrL({"#e8433a", "#f6f2ea", "#3c6ab8"}, 3),
                                __mod(i, 3)
                            )
                            c:beginPath()
                            c:moveTo(px, py)
                            c:arc(
                                px,
                                py,
                                58,
                                math.pi + i * math.pi / 6,
                                math.pi + (i + 1) * math.pi / 6
                            )
                            __call(c, "fill")
                            i = i + 1
                        end
                    end
                    c.strokeStyle = "#3a3026"
                    c.lineWidth = 1
                    for ____, dx in __iterar((__arrL({-56, -20, 20, 56}, 4))) do
                        c:beginPath()
                        c:moveTo(px + dx, py)
                        c:lineTo(px + dx * 0.3, y - 30)
                        c:stroke()
                    end
                    c.globalAlpha = 1
                end,
                poeira = k >= 1 and __lt(u, 0.86)
            }
        end,
        ["2"] = function(____, u, x1, y1, t)
            local k = clamp(nil, u / 0.4, 0, 1)
            local x = lerp(
                nil,
                -140,
                x1,
                ease(nil, k)
            )
            local sy = 1
            local dy = 0
            if k >= 1 then
                local r = (u - 0.4) / 0.6 * 3
                local f = __mod(r, 1)
                sy = 1 - math.sin(f * math.pi) * 0.22
                dy = 0
                local ____t_13 = __t
                local ____t_result_12
                local ____t_11 = __t
                local ____temp_10 = f > 0.45 and f < 0.5
                __O[699] = ____temp_10
                if ____t_11(____temp_10) then
                    ____t_result_12 = math.random() < 0.8
                else
                    ____t_result_12 = __O[699]
                end
                if ____t_13(____t_result_12) then
                    do
                        local i = 0
                        while i < 3 do
                            P(
                                nil,
                                {
                                    x = x + 14 + math.random() * 10,
                                    y = y1 - 40,
                                    vx = 30 + math.random() * 40,
                                    vy = -80 - math.random() * 40,
                                    g = 400,
                                    cor = "#8ad8ff",
                                    vida = 0.6,
                                    tam = 3
                                }
                            )
                            i = i + 1
                        end
                    end
                end
            end
            return {x = x, y = y1 + dy, sy = sy, sx = 2 - sy}
        end,
        ["3"] = function(____, u, x1, y1)
            local k = clamp(nil, u / 0.8, 0, 1)
            local x = lerp(
                nil,
                -100,
                x1,
                ease(nil, k)
            )
            local rot = (1 - ease(nil, k)) * math.pi * 2
            if k < 1 then
                P(nil, {
                    x = x - 10,
                    y = y1 - 3,
                    vx = 0,
                    vy = 0,
                    cor = "#2a2a30",
                    vida = 1.6,
                    tam = 4,
                    chao = true
                })
                if math.random() < 0.6 then
                    P(
                        nil,
                        {
                            x = x,
                            y = y1 - 10,
                            vx = -30 + math.random() * 60,
                            vy = -40 - math.random() * 30,
                            cor = "#e8e8e8",
                            vida = 0.7,
                            tam = 7
                        }
                    )
                end
            end
            return {x = x, y = y1, rot = rot}
        end,
        ["4"] = function(____, u, x1, y1)
            local k = clamp(nil, u / 0.7, 0, 1)
            local x = lerp(
                nil,
                -140,
                x1,
                ease(nil, k)
            )
            local ____temp_14
            if k < 1 then
                ____temp_14 = (1 - ease(nil, k)) * 60
            else
                ____temp_14 = 0
            end
            local voo = ____temp_14
            if __t(k >= 1 and __lt(u, 0.74)) then
                do
                    local i = 0
                    while i < 14 do
                        P(
                            nil,
                            {
                                x = x + (math.random() - 0.5) * 60,
                                y = y1 - 4,
                                vx = (math.random() - 0.5) * 160,
                                vy = -120 - math.random() * 160,
                                g = 600,
                                cor = __t(__mod(i, 2)) and "#7ad0f0" or "#d8f2ff",
                                vida = 0.9,
                                tam = 3
                            }
                        )
                        i = i + 1
                    end
                end
            end
            return {x = x, y = y1 - voo, rot = k < 1 and -0.08 or 0}
        end,
        ["5"] = function(____, u, x1, y1)
            local k = clamp(nil, u / 0.85, 0, 1)
            local seg = math.min(
                2,
                math.floor(k * 3)
            )
            local f = k * 3 - seg
            local xs = __arrL({-160, 0, 140, x1}, 4)
            local ys = __arrL({y1 - 260, y1 - 170, y1 - 80, y1}, 4)
            local x = lerp(
                nil,
                __get(xs, seg),
                __get(xs, seg + 1),
                f
            )
            local y = lerp(
                nil,
                __get(ys, seg),
                __get(ys, seg + 1),
                f
            ) - math.sin(f * math.pi) * 70
            if __t(f < 0.06 and seg > 0) then
                do
                    local i = 0
                    while i < 6 do
                        P(
                            nil,
                            {
                                x = x + (math.random() - 0.5) * 40,
                                y = y - 2,
                                vx = (math.random() - 0.5) * 100,
                                vy = -60 - math.random() * 60,
                                g = 400,
                                cor = __t(__mod(i, 2)) and "#c8543a" or "#a87a5a",
                                vida = 0.6,
                                tam = 3
                            }
                        )
                        i = i + 1
                    end
                end
            end
            local ____temp_15
            if k >= 1 then
                ____temp_15 = x1
            else
                ____temp_15 = x
            end
            local ____temp_16
            if k >= 1 then
                ____temp_16 = y1
            else
                ____temp_16 = y
            end
            local ____temp_17
            if k < 1 then
                ____temp_17 = math.sin(f * math.pi) * 0.2
            else
                ____temp_17 = 0
            end
            return {
                x = ____temp_15,
                y = ____temp_16,
                rot = ____temp_17,
                poeira = k >= 1 and __lt(u, 0.9)
            }
        end,
        ["6"] = function(____, u, x1, y1, t)
            local a = clamp(nil, (u - 0.45) / 0.4, 0, 1)
            return {
                x = x1,
                y = y1,
                alpha = a,
                antes = function(____, c)
                    local n = math.floor(clamp(nil, u / 0.5, 0, 1) * 40)
                    c.strokeStyle = "#2a2a3a"
                    c.lineWidth = 2
                    c.globalAlpha = 1 - a * 0.9
                    c:beginPath()
                    do
                        local i = 0
                        while i < n do
                            local ang = i * 0.9
                            local r = 30 + __mod(i, 5) * 4
                            c:lineTo(
                                x1 + math.cos(ang) * r * 1.2,
                                y1 - 22 + math.sin(ang) * r * 0.5
                            )
                            i = i + 1
                        end
                    end
                    c:stroke()
                    c.globalAlpha = 1
                    if __lt(u, 0.55) then
                        local lx = x1 + math.cos(u * 30) * 34
                        local ly = y1 - 22 + math.sin(u * 30) * 14
                        c.fillStyle = "#f2c94c"
                        c:fillRect(lx - 2, ly - 18, 5, 16)
                        c.fillStyle = "#2a2a2a"
                        c:fillRect(lx - 1, ly - 2, 3, 3)
                        c.fillStyle = "#f6c8c8"
                        c:fillRect(lx - 2, ly - 21, 5, 3)
                    end
                end
            }
        end,
        ["7"] = function(____, u, x1, y1, t)
            local k = clamp(nil, u / 0.7, 0, 1)
            local x = lerp(
                nil,
                -140,
                x1,
                ease(nil, k)
            )
            local ____temp_18
            if k < 1 then
                ____temp_18 = x + 46
            else
                ____temp_18 = x1 + 46 + (u - 0.7) / 0.3 * 260
            end
            local bx = ____temp_18
            local ____temp_19
            if k < 1 then
                ____temp_19 = y1 - 8 - math.abs(math.sin(u * 20)) * 6
            else
                ____temp_19 = y1 - 8 - math.sin(clamp(nil, (u - 0.7) / 0.3, 0, 1) * math.pi) * 160
            end
            local by = ____temp_19
            if __t(k >= 1 and __lt(u, 0.74)) then
                do
                    local i = 0
                    while i < 16 do
                        P(
                            nil,
                            {
                                x = x1 + (math.random() - 0.5) * 80,
                                y = y1 - 80,
                                vx = (math.random() - 0.5) * 200,
                                vy = -150 - math.random() * 100,
                                g = 300,
                                cor = __get(
                                    __arrL({
                                        "#f2c94c",
                                        "#3c8a5a",
                                        "#e8433a",
                                        "#3c6ab8",
                                        "#ffffff"
                                    }, 5),
                                    __mod(i, 5)
                                ),
                                vida = 1.4,
                                tam = 3
                            }
                        )
                        i = i + 1
                    end
                end
            end
            return {
                x = x,
                y = y1,
                depois = function(____, c)
                    local rr = 7
                    c.fillStyle = "#1c1c1c"
                    c:beginPath()
                    c:arc(
                        bx,
                        by,
                        rr + 1,
                        0,
                        7
                    )
                    __call(c, "fill")
                    c.fillStyle = "#f6f6f0"
                    c:beginPath()
                    c:arc(
                        bx,
                        by,
                        rr,
                        0,
                        7
                    )
                    __call(c, "fill")
                    c.fillStyle = "#1c1c1c"
                    c:fillRect(bx - 2, by - 2, 4, 4)
                    c:fillRect(bx + 3, by + 2, 2, 2)
                    c:fillRect(bx - 5, by + 1, 2, 2)
                end
            }
        end,
        ["8"] = function(____, u, x1, y1, t)
            local a = clamp(nil, u / 0.35, 0, 1)
            local gira = (1 - ease(
                nil,
                clamp(nil, u / 0.75, 0, 1)
            )) * 6
            return {
                x = x1,
                y = y1,
                alpha = a,
                sx = math.cos(gira * 3) >= 0 and 1 or -1,
                antes = function(____, c)
                    if __gt(u, 0.8) then
                        return
                    end
                    c.globalAlpha = clamp(nil, 1 - (u - 0.5) / 0.3, 0, 1) * 0.8
                    do
                        local i = 0
                        while i < 10 do
                            local fase = __mod(u * 4 + i / 10, 1)
                            local yy = y1 - 80 + fase * 80
                            c.fillStyle = __get(
                                __arrL({"#c43c3a", "#f2f2ee", "#2c5a9e"}, 3),
                                __mod(i, 3)
                            )
                            c:fillRect(x1 - 46, yy, 92, 4)
                            i = i + 1
                        end
                    end
                    c.globalAlpha = 1
                end,
                depois = function(____, c)
                    if __lt(u, 0.55) then
                        return
                    end
                    local s = clamp(nil, (u - 0.55) / 0.2, 0, 1)
                    local cx = x1 + 30
                    local cy = y1 - 16
                    c.fillStyle = "#2a1a12"
                    for ____, l in __iterar((__arrL({-1, 1}, 2))) do
                        do
                            local k2 = 0
                            while k2 < 10 do
                                local q = k2 / 9
                                local ____c_23 = c
                                local ____c_fillRect_24 = c.fillRect
                                local ____math_floor_result_22 = math.floor(cx + l * q * 12 * s + 0.5)
                                local ____temp_21 = cy - math.sin(q * math.pi) * 3 + q * q * 2
                                local ____temp_20
                                if q > 0.8 then
                                    ____temp_20 = (q - 0.8) * 14
                                else
                                    ____temp_20 = 0
                                end
                                ____c_fillRect_24(
                                    ____c_23,
                                    ____math_floor_result_22,
                                    math.floor(____temp_21 - ____temp_20 + 0.5),
                                    2,
                                    math.max(
                                        1,
                                        math.floor(4 * (1 - q * 0.6) * s + 0.5)
                                    )
                                )
                                k2 = k2 + 1
                            end
                        end
                    end
                end
            }
        end,
        ["9"] = function(____, u, x1, y1)
            local k = clamp(nil, u / 0.85, 0, 1)
            local y
            if k < 0.45 then
                y = lerp(nil, y1 - 380, y1, (k / 0.45) ^ 2)
            else
                local f = (k - 0.45) / 0.55
                local ____temp_25
                if f < 0.55 then
                    ____temp_25 = math.sin(f / 0.55 * math.pi) * 70
                else
                    ____temp_25 = math.sin((f - 0.55) / 0.45 * math.pi) * 22
                end
                local b = ____temp_25
                y = y1 - b
            end
            if __t(k > 0.44 and k < 0.47) then
                do
                    local i = 0
                    while i < 14 do
                        P(
                            nil,
                            {
                                x = x1 + (math.random() - 0.5) * 90,
                                y = y1 - 60,
                                vx = (math.random() - 0.5) * 180,
                                vy = -160 - math.random() * 80,
                                g = 280,
                                cor = __get(
                                    __arrL({
                                        "#e8433a",
                                        "#f2c94c",
                                        "#3c8a5a",
                                        "#3c6ab8",
                                        "#e86a8a"
                                    }, 5),
                                    __mod(i, 5)
                                ),
                                vida = 1.3,
                                tam = 4,
                                bandeira = true
                            }
                        )
                        i = i + 1
                    end
                end
            end
            local sq = __t(k > 0.44 and k < 0.52) and 0.2 or 0
            return {x = x1, y = y, sy = 1 - sq, sx = 1 + sq}
        end,
        ["10"] = function(____, u, x1, y1, t)
            local k = clamp(nil, u / 0.85, 0, 1)
            local x = lerp(
                nil,
                -120,
                x1,
                ease(nil, k)
            )
            if math.random() < 0.25 then
                P(
                    nil,
                    {
                        x = x + (math.random() - 0.5) * 50,
                        y = y1 - 50,
                        vx = (math.random() - 0.5) * 20,
                        vy = -50,
                        cor = math.random() < 0.5 and "#e86a8a" or "#f29ab8",
                        vida = 1.4,
                        tam = 6,
                        coracao = true
                    }
                )
            end
            return {
                x = x,
                y = y1 - math.abs(math.sin(u * 10)) * 2
            }
        end,
        ["11"] = function(____, u, x1, y1, t)
            local k = clamp(nil, u / 0.65, 0, 1)
            local x = lerp(
                nil,
                -140,
                x1,
                ease(nil, k)
            )
            return {
                x = x,
                y = y1,
                antes = function(____, c)
                    local cor = __t(__mod(
                        math.floor(t * 6),
                        2
                    )) and "#ff3a8a" or "#3af0ff"
                    c.globalAlpha = 0.5
                    c.fillStyle = cor
                    c:fillRect(x - 44, y1 - 4, 88, 6)
                    c.globalAlpha = 0.18
                    c:fillRect(x - 60, y1 - 10, 120, 14)
                    if k >= 1 then
                        do
                            local i = 0
                            while i < 3 do
                                local r = __mod((u - 0.65) * 3 + i / 3, 1)
                                c.globalAlpha = (1 - r) * 0.6
                                c.strokeStyle = __t(__mod(i, 2)) and "#ff3a8a" or "#3af0ff"
                                c.lineWidth = 3
                                c:beginPath()
                                c:ellipse(
                                    x1,
                                    y1 - 20,
                                    30 + r * 120,
                                    12 + r * 40,
                                    0,
                                    0,
                                    7
                                )
                                c:stroke()
                                i = i + 1
                            end
                        end
                    end
                    c.globalAlpha = 1
                end
            }
        end
    }
    local function desenhar(self, ctx, o)
        if not __t(ch) then
            return false
        end
        local u = clamp(nil, ch.t / DUR, 0, 1)
        local x1 = o.x
        local y1 = o.y
        local ____t_result_28
        local ____t_27 = __t
        local ____get_result_26 = __get(ANIM, ch.cena)
        __O[700] = ____get_result_26
        if ____t_27(____get_result_26) then
            ____t_result_28 = __O[700]
        else
            ____t_result_28 = __get(ANIM, 0)
        end
        local fn = ____t_result_28
        local ____t_result_32
        local ____t_31 = __t
        local ____t_result_29
        if __t(o.time) then
            ____t_result_29 = o.time
        else
            ____t_result_29 = 0
        end
        local ____fn_result_30 = fn(
            nil,
            u,
            x1,
            y1,
            ____t_result_29
        )
        __O[701] = ____fn_result_30
        if ____t_31(____fn_result_30) then
            ____t_result_32 = __O[701]
        else
            ____t_result_32 = {}
        end
        local a = ____t_result_32
        ctx:save()
        for ____, p in __iterar((ch.parts)) do
            if __t(p.chao) then
                ctx.globalAlpha = math.max(0, 1 - p.t / p.vida) * 0.5
                ctx.fillStyle = p.cor
                ctx:fillRect(
                    math.floor(p.x + 0.5),
                    math.floor(p.y + 0.5),
                    p.tam,
                    2
                )
            end
        end
        ctx.globalAlpha = 1
        do
            pcall(function()
                local ____opt_33 = a.antes
                if ____opt_33 ~= nil then
                    ____opt_33(a, ctx)
                end
            end)
        end
        if __t(a.poeira) then
            do
                local i = 0
                while i < 2 do
                    __call(
                        ch.parts,
                        "push",
                        {
                            x = x1 + (math.random() - 0.5) * 70,
                            y = y1 - 4,
                            vx = (math.random() - 0.5) * 120,
                            vy = -30 - math.random() * 30,
                            g = 0,
                            t = 0,
                            vida = 0.6,
                            tam = 7,
                            cor = "#e8dcc0"
                        }
                    )
                    i = i + 1
                end
            end
        end
        ctx:save()
        local ____ctx_36 = ctx
        local ____a_alpha_35 = a.alpha
        if ____a_alpha_35 == nil then
            ____a_alpha_35 = 1
        end
        ____ctx_36.globalAlpha = ____a_alpha_35
        local ____a_x_37 = a.x
        if ____a_x_37 == nil then
            ____a_x_37 = x1
        end
        local px = ____a_x_37
        local ____a_y_38 = a.y
        if ____a_y_38 == nil then
            ____a_y_38 = y1
        end
        local py = ____a_y_38
        ctx:translate(
            math.floor(px + 0.5),
            math.floor(py - 14 + 0.5)
        )
        if __t(a.rot) then
            ctx:rotate(a.rot)
        end
        local ____ctx_41 = ctx
        local ____ctx_scale_42 = ctx.scale
        local ____a_sx_39 = a.sx
        if ____a_sx_39 == nil then
            ____a_sx_39 = 1
        end
        local ____a_sy_40 = a.sy
        if ____a_sy_40 == nil then
            ____a_sy_40 = 1
        end
        ____ctx_scale_42(____ctx_41, ____a_sx_39, ____a_sy_40)
        ctx:translate(
            -math.floor(px + 0.5),
            -math.floor(py - 14 + 0.5)
        )
        do
            pcall(function()
                local ____this_44
                ____this_44 = o
                local ____opt_43 = ____this_44.pintar
                if ____opt_43 ~= nil then
                    ____opt_43(____this_44, ctx, px, py)
                end
            end)
        end
        ctx:restore()
        do
            pcall(function()
                local ____opt_45 = a.depois
                if ____opt_45 ~= nil then
                    ____opt_45(a, ctx)
                end
            end)
        end
        for ____, p in __iterar((ch.parts)) do
            do
                if __t(p.chao) then
                    continue
                end
                local al = math.max(0, 1 - p.t / p.vida)
                ctx.globalAlpha = al
                ctx.fillStyle = p.cor
                if __t(p.coracao) then
                    local s = 2
                    ctx:fillRect(p.x - 2 * s, p.y - s, 2 * s, 2 * s)
                    ctx:fillRect(p.x, p.y - s, 2 * s, 2 * s)
                    ctx:fillRect(p.x - s * 1.5, p.y, 3 * s, s * 1.5)
                    ctx:fillRect(p.x - s * 0.5, p.y + s, s, s)
                elseif __t(p.bandeira) then
                    ctx:beginPath()
                    ctx:moveTo(p.x, p.y)
                    ctx:lineTo(p.x + 6, p.y)
                    ctx:lineTo(p.x + 3, p.y + 6)
                    __call(ctx, "fill")
                else
                    local ____p_tam_52 = p.tam
                    local ____t_result_51
                    local ____t_50 = __t
                    local ____t_result_49
                    local ____t_48 = __t
                    local ____temp_47 = p.cor == "#e8dcc0" or p.cor == "#d8c098"
                    __O[702] = ____temp_47
                    if ____t_48(____temp_47) then
                        ____t_result_49 = __O[702]
                    else
                        ____t_result_49 = p.cor == "#e8e8e8"
                    end
                    if ____t_50(____t_result_49) then
                        ____t_result_51 = 1 + p.t * 1.5
                    else
                        ____t_result_51 = 1
                    end
                    local tam = ____p_tam_52 * ____t_result_51
                    ctx:fillRect(
                        math.floor(p.x - tam / 2 + 0.5),
                        math.floor(p.y - tam / 2 + 0.5),
                        math.floor(tam + 0.5),
                        math.floor(tam + 0.5)
                    )
                end
            end
        end
        ctx:restore()
        return true
    end
    window.ChegadaCarro = __ord({
        iniciar = iniciar,
        ativa = ativa,
        atualizar = atualizar,
        depois = depois,
        desenhar = desenhar,
        duracao = DUR
    }, "iniciar,ativa,atualizar,depois,desenhar,duracao")
end)(nil)
return ____exports
