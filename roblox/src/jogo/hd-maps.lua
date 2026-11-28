--!native
--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __NumberV, __fapply, __lt, __le, __gt, __ge, __isFiniteN, __getq, __mod, __ord, __arrL, __iterar = __JSR.__NumberV, __JSR.__fapply, __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__isFiniteN, __JSR.__getq, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar
local __t, __get, __set, __len, __call, __add, __iter, __keys, __bor, __band, __shr, __hypot = __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__iter, __JSR.__keys, __JSR.__bor, __JSR.__band, __JSR.__shr, __JSR.__hypot
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__Number = ____lualib.__TS__Number
local Map = ____lualib.Map
local __TS__New = ____lualib.__TS__New
local __TS__ParseInt = ____lualib.__TS__ParseInt
local __TS__MathSign = ____lualib.__TS__MathSign
local ____exports = {}
local __O = {};
(function()
    local low, lc, lightCv, lg, skyCv, sk, darkCv, dk, alow, ac
    local __L1 = {}
    __L1.ellRows = function(self, c, cx, cy, rx, ry, dx, dy)
        do
            local y = math.ceil(cy - ry)
            while y <= math.floor(__add(cy, ry)) do
                local t = (y - cy) / ry
                local w = rx * math.sqrt(math.max(0, 1 - t * t))
                local xa = math.floor(cx - w + 0.5)
                local xb = math.floor(cx + w + 0.5)
                c:fillRect(
                    xa + dx,
                    y + dy,
                    math.max(1, xb - xa),
                    1
                )
                y = y + 1
            end
        end
    end
    __L1.ell = function(self, c, cx, cy, rx, ry, col)
        c.fillStyle = col
        if __lt(ry, 2.5) then
            __L1:ellRows(
                c,
                cx,
                cy,
                rx,
                ry,
                0,
                0
            )
            return
        end
        cx = __L1:q4(cx)
        cy = __L1:q4(cy)
        rx = __L1:q4(rx)
        ry = __L1:q4(ry)
        local ix = math.floor(cx)
        local iy = math.floor(cy)
        local fx = cx - ix
        local fy = cy - iy
        local key = __add(
            __add(
                __add(
                    __add(
                        __add(
                            __add(
                                __add(
                                    __add(col, "|"),
                                    rx
                                ),
                                "|"
                            ),
                            ry
                        ),
                        "|"
                    ),
                    fx
                ),
                "|"
            ),
            fy
        )
        local s = __call(__L1.ECACHE, "get", key)
        if not __t(s) then
            local now = window.performance:now()
            if now - __L1.missT > 250 then
                __L1.missT = now
                __L1.misses = 0
            end
            local ____L1_0, ____misses_1 = __L1, "misses"
            local ____L1_misses_2 = ____L1_0[____misses_1] + 1
            ____L1_0[____misses_1] = ____L1_misses_2
            if ____L1_misses_2 > 60 then
                __L1:ellRows(
                    c,
                    cx,
                    cy,
                    rx,
                    ry,
                    0,
                    0
                )
                return
            end
            if __L1.ECACHE.size > 1500 then
                __call(__L1.ECACHE, "clear")
            end
            local ox = math.ceil(rx) + 2
            local oy = math.ceil(fy - ry)
            local h = math.floor(fy + ry) - oy + 1
            local cv = window.document:createElement("canvas")
            cv.width = ox * 2 + 2
            cv.height = math.max(1, h)
            local g = cv:getContext("2d")
            g.fillStyle = col
            __L1:ellRows(
                g,
                fx,
                fy,
                rx,
                ry,
                ox,
                -oy
            )
            s = {cv = cv, ox = ox, oy = oy}
            __call(__L1.ECACHE, "set", key, s)
        end
        c:drawImage(s.cv, ix - s.ox, iy + s.oy)
    end
    __L1.limb = function(self, c, pts, w, col)
        do
            local i = 0
            while i < __len(pts) - 1 do
                local a = __get(pts, i)
                local b = __get(pts, i + 1)
                local n = math.ceil(__hypot(
                    __get(b, 0) - __get(a, 0),
                    __get(b, 1) - __get(a, 1)
                )) + 1
                do
                    local k = 0
                    while k <= n do
                        local u = k / n
                        c.fillStyle = col
                        c:fillRect(
                            math.floor(__get(a, 0) + (__get(b, 0) - __get(a, 0)) * u - w / 2 + 0.5),
                            math.floor(__get(a, 1) + (__get(b, 1) - __get(a, 1)) * u - w / 2 + 0.5),
                            math.max(1, w),
                            math.max(1, w)
                        )
                        k = k + 1
                    end
                end
                i = i + 1
            end
        end
    end
    __L1.dither = function(self, c, x, y, w, col)
        c.fillStyle = col
        do
            local i = __band(
                math.floor(y + 0.5),
                1
            )
            while __lt(i, w) do
                c:fillRect(
                    math.floor(x + 0.5) + i,
                    math.floor(y + 0.5),
                    1,
                    1
                )
                i = i + 2
            end
        end
    end
    __L1.sky = function(self, c, s, t, camL, arc)
        local ____t_6 = __t
        local ____t_result_5
        local ____t_4 = __t
        local ____t_result_3
        if __t(__L1.GRAV) then
            ____t_result_3 = c == __L1.GRAV.g
        else
            ____t_result_3 = __L1.GRAV
        end
        __O[299] = ____t_result_3
        if ____t_4(____t_result_3) then
            ____t_result_5 = not __t(__L1.GRAV.sujo)
        else
            ____t_result_5 = __O[299]
        end
        if ____t_6(____t_result_5) then
            local lw = __L1.LW
            __L1.LW = 482
            do
                local ____try, ____error = pcall(function()
                    __L1.GRAV.ceuG:clearRect(0, 0, 482, __L1.LH)
                    local ____L1_skyBase_9 = __L1.skyBase
                    local ____array_8 = __TS__SparseArrayNew(
                        __L1.GRAV.ceuG,
                        s,
                        t,
                        __add(camL, __L1.GRAV.M)
                    )
                    local ____t_result_7
                    if __t(arc) then
                        ____t_result_7 = arc
                    else
                        ____t_result_7 = {}
                    end
                    __TS__SparseArrayPush(____array_8, ____t_result_7)
                    ____L1_skyBase_9(
                        __L1,
                        __TS__SparseArraySpread(____array_8)
                    )
                end)
                do
                    __L1.LW = lw
                end
                if not ____try then
                    error(____error, 0)
                end
            end
            __call(__L1.GRAV.fundo, "push", {tipo = "ceu"})
            return
        end
        local ____L1_skyBase_12 = __L1.skyBase
        local ____array_11 = __TS__SparseArrayNew(c, s, t, camL)
        local ____t_result_10
        if __t(arc) then
            ____t_result_10 = arc
        else
            ____t_result_10 = {}
        end
        __TS__SparseArrayPush(____array_11, ____t_result_10)
        ____L1_skyBase_12(
            __L1,
            __TS__SparseArraySpread(____array_11)
        )
    end
    __L1.skyBase = function(self, c, s, t, camL, arc)
        local ____t_result_13
        if __t(arc.amb) then
            ____t_result_13 = arc.amb
        else
            ____t_result_13 = s.amb
        end
        local am = ____t_result_13
        local function pre(____, v)
            return __arrL(
                {
                    __get(v, 0) / __get(am, 0),
                    __get(v, 1) / __get(am, 1),
                    __get(v, 2) / __get(am, 2)
                },
                3
            )
        end
        if math.abs(s.h - __L1.skyH) > 0.012 then
            __L1.skyH = s.h
            local N = 14
            local bh = 14
            do
                local i = 0
                while i < N do
                    local k = i / (N - 1)
                    local col = __L1:css(pre(
                        nil,
                        __L1:mix(s.top, s.bot, k * k * 0.45 + k * 0.55)
                    ))
                    __L1:R(
                        sk,
                        0,
                        i * bh,
                        __L1.LW,
                        bh,
                        col
                    )
                    if __t(i) then
                        __L1:dither(
                            sk,
                            0,
                            i * bh - 1,
                            __L1.LW,
                            col
                        )
                        do
                            local x = 1
                            while x < __L1.LW do
                                sk:fillRect(x, i * bh - 2, 1, 1)
                                x = x + 4
                            end
                        end
                    end
                    i = i + 1
                end
            end
        end
        c:drawImage(skyCv, 0, 0)
        if __gt(s.night, 0.25) then
            do
                local i = 0
                while i < 90 do
                    local tw = 0.5 + 0.5 * math.sin(t * (1 + __L1:hash(i) * 2) + i)
                    c.fillStyle = ("rgba(255,255,255," .. tostring(__L1:cl((s.night - 0.25) * 1.4 * (0.35 + 0.65 * tw) * (0.4 + __L1:hash(i + 9) * 0.6)))) .. ")"
                    c:fillRect(
                        math.floor(__mod(
                            __mod(
                                __L1:hash(i + 300) * 560 - camL * 0.01,
                                __L1.LW
                            ) + __L1.LW,
                            __L1.LW
                        ) + 0.5),
                        math.floor(__L1:hash(i + 400) * 120 + 0.5),
                        1,
                        1
                    )
                    i = i + 1
                end
            end
        end
        local ____temp_14
        if s.sunT ~= nil then
            ____temp_14 = __L1:cl(1 - math.sin(s.sunT * math.pi) * 1.7)
        else
            ____temp_14 = 0
        end
        local gold = ____temp_14
        local ____temp_15
        if s.sunT ~= nil then
            ____temp_15 = 40 + s.sunT * 400 - camL * 0.012
        else
            ____temp_15 = -999
        end
        local sunX = ____temp_15
        local ____temp_19
        if s.sunT ~= nil then
            local ____t_result_16
            if __t(arc.sb) then
                ____t_result_16 = arc.sb
            else
                ____t_result_16 = 168
            end
            local ____math_sin_result_18 = math.sin(s.sunT * math.pi)
            local ____t_result_17
            if __t(arc.sa) then
                ____t_result_17 = arc.sa
            else
                ____t_result_17 = 128
            end
            ____temp_19 = ____t_result_16 - ____math_sin_result_18 * ____t_result_17
        else
            ____temp_19 = 0
        end
        local sunY = ____temp_19
        if gold > 0.02 then
            local wash = c:createLinearGradient(0, 0, 0, 180)
            wash:addColorStop(
                0,
                __L1:css(
                    pre(
                        nil,
                        __arrL({0.6, 0.12, 0.2}, 3)
                    ),
                    0.55 * gold
                )
            )
            wash:addColorStop(
                0.55,
                __L1:css(
                    pre(
                        nil,
                        __arrL({0.98, 0.3, 0.22}, 3)
                    ),
                    0.45 * gold
                )
            )
            wash:addColorStop(
                1,
                __L1:css(
                    pre(
                        nil,
                        __arrL({1, 0.62, 0.3}, 3)
                    ),
                    0.45 * gold
                )
            )
            c.fillStyle = wash
            c:fillRect(0, 0, __L1.LW, 196)
            c:save()
            c:translate(sunX, sunY)
            c:scale(1.7, 1)
            local g1 = c:createRadialGradient(
                0,
                0,
                3,
                0,
                0,
                220
            )
            g1:addColorStop(
                0,
                __L1:css(
                    pre(
                        nil,
                        __arrL({1, 0.9, 0.55}, 3)
                    ),
                    0.9 * gold
                )
            )
            g1:addColorStop(
                0.22,
                __L1:css(
                    pre(
                        nil,
                        __arrL({1, 0.66, 0.3}, 3)
                    ),
                    0.6 * gold
                )
            )
            g1:addColorStop(
                0.55,
                __L1:css(
                    pre(
                        nil,
                        __arrL({0.95, 0.36, 0.26}, 3)
                    ),
                    0.3 * gold
                )
            )
            g1:addColorStop(1, "rgba(0,0,0,0)")
            c.fillStyle = g1
            c:fillRect(-260, -220, 520, 440)
            c:restore()
            local g2 = c:createLinearGradient(0, 40, 0, 170)
            g2:addColorStop(0, "rgba(0,0,0,0)")
            g2:addColorStop(
                0.6,
                __L1:css(
                    pre(
                        nil,
                        __arrL({0.78, 0.45, 0.62}, 3)
                    ),
                    0.2 * gold
                )
            )
            g2:addColorStop(
                1,
                __L1:css(
                    pre(
                        nil,
                        __arrL({0.95, 0.6, 0.55}, 3)
                    ),
                    0.28 * gold
                )
            )
            c.fillStyle = g2
            c:fillRect(0, 40, __L1.LW, 130)
        end
        if s.sunT ~= nil then
            local x = sunX
            local y = sunY
            local sc = __L1:mix(
                s.sun,
                __arrL({1, 0.45, 0.25}, 3),
                gold * 0.6
            )
            __L1:ell(
                c,
                x,
                y,
                34 + gold * 14,
                34 + gold * 10,
                __L1:css(
                    pre(nil, sc),
                    0.08 + gold * 0.08
                )
            )
            __L1:ell(
                c,
                x,
                y,
                26,
                26,
                __L1:css(
                    pre(nil, sc),
                    0.14
                )
            )
            __L1:ell(
                c,
                x,
                y,
                19,
                19,
                __L1:css(
                    pre(nil, sc),
                    0.24
                )
            )
            __L1:ell(
                c,
                x,
                y,
                13,
                13,
                __L1:css(pre(
                    nil,
                    __L1:mix(
                        sc,
                        __arrL({1, 1, 0.92}, 3),
                        0.55
                    )
                ))
            )
            if gold > 0.35 then
                __L1:ell(
                    c,
                    x,
                    y + 1,
                    70 * gold,
                    2,
                    __L1:css(
                        pre(
                            nil,
                            __arrL({1, 0.85, 0.6}, 3)
                        ),
                        0.35 * gold
                    )
                )
                __L1:ell(
                    c,
                    x,
                    y + 1,
                    40 * gold,
                    1,
                    __L1:css(
                        pre(
                            nil,
                            __arrL({1, 0.95, 0.8}, 3)
                        ),
                        0.5 * gold
                    )
                )
            end
            if __t(gold > 0.15 and __lt(s.night, 0.4)) then
                c:save()
                c.globalCompositeOperation = "lighter"
                do
                    local i = 0
                    while i < 9 do
                        local a = -math.pi * 0.95 + i * 0.23 + math.sin(t * 0.05 + i) * 0.03
                        local len = 260
                        local wd = 0.045 + __L1:hash(i + 7) * 0.04
                        c.fillStyle = __L1:css(
                            pre(
                                nil,
                                __arrL({1, 0.78, 0.45}, 3)
                            ),
                            (0.05 + __L1:hash(i + 3) * 0.05) * gold
                        )
                        c:beginPath()
                        c:moveTo(x, y)
                        c:lineTo(
                            x + math.cos(a - wd) * len,
                            y + math.sin(a - wd) * len
                        )
                        c:lineTo(
                            x + math.cos(a + wd) * len,
                            y + math.sin(a + wd) * len
                        )
                        c:closePath()
                        __call(c, "fill")
                        i = i + 1
                    end
                end
                c:restore()
            end
        end
        if s.moonT ~= nil then
            local x = 50 + s.moonT * 380 - camL * 0.012
            local ____t_result_20
            if __t(arc.mb) then
                ____t_result_20 = arc.mb
            else
                ____t_result_20 = 150
            end
            local ____math_sin_result_22 = math.sin(s.moonT * math.pi)
            local ____t_result_21
            if __t(arc.ma) then
                ____t_result_21 = arc.ma
            else
                ____t_result_21 = 108
            end
            local y = ____t_result_20 - ____math_sin_result_22 * ____t_result_21
            __L1:ell(
                c,
                x,
                y,
                16,
                16,
                "rgba(200,215,255,.14)"
            )
            __L1:ell(
                c,
                x,
                y,
                9,
                9,
                "#ffffff"
            )
            __L1:R(
                c,
                x - 4,
                y - 3,
                3,
                3,
                "#dfe6ff"
            )
            __L1:R(
                c,
                x + 2,
                y + 3,
                3,
                2,
                "#dfe6ff"
            )
            __L1:R(
                c,
                x + 3,
                y - 5,
                2,
                2,
                "#dfe6ff"
            )
        end
        local cloud = pre(
            nil,
            __L1:mix(
                __L1:mix(
                    s.bot,
                    __arrL({1, 1, 1}, 3),
                    0.7 * (1 - s.night) + 0.1
                ),
                s.top,
                s.night * 0.45
            )
        )
        local shade = __arrL(
            {
                __get(cloud, 0) * 0.86,
                __get(cloud, 1) * 0.89,
                __get(cloud, 2) * 0.96
            },
            3
        )
        local cbody = pre(
            nil,
            __L1:mix(
                __L1:mix(
                    __L1:mix(
                        s.bot,
                        __arrL({1, 1, 1}, 3),
                        0.7 * (1 - s.night) + 0.1
                    ),
                    s.top,
                    s.night * 0.45
                ),
                __arrL({0.98, 0.5, 0.46}, 3),
                gold * 0.7 * (1 - s.night)
            )
        )
        local belly = pre(
            nil,
            __L1:mix(
                __L1:mix(
                    s.bot,
                    __arrL({0.62, 0.66, 0.78}, 3),
                    0.5
                ),
                __arrL({1, 0.42, 0.22}, 3),
                gold * (1 - s.night)
            )
        )
        local rim = pre(
            nil,
            __L1:mix(
                __arrL({1, 1, 0.96}, 3),
                __arrL({1, 0.9, 0.56}, 3),
                gold
            )
        )
        local dark = pre(
            nil,
            __L1:mix(
                shade,
                __arrL({0.5, 0.2, 0.3}, 3),
                gold * 0.6
            )
        )
        do
            local i = 0
            while i < 6 do
                local x = __mod(
                    __mod(
                        __L1:hash(i + 60) * 900 + t * (3 + __L1:hash(i) * 2) - camL * 0.03,
                        760
                    ) + 760,
                    760
                ) - 140
                local y = 18 + __L1:hash(i + 61) * 48
                local w = 70 + __L1:hash(i + 62) * 90
                c.fillStyle = __L1:css(
                    __L1:mix(cloud, belly, 0.6 * gold),
                    0.35 + 0.25 * gold
                )
                do
                    local k = 0
                    while k < 3 do
                        c:fillRect(
                            math.floor(x + k * 9 + 0.5),
                            math.floor(y + k * 3 + 0.5),
                            math.floor(w - k * 18 + 0.5),
                            1
                        )
                        k = k + 1
                    end
                end
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 8 do
                local x = __mod(
                    __mod(
                        __L1:hash(i + 20) * 700 + t * (1.5 + __L1:hash(i) * 2.5) - camL * 0.05,
                        680
                    ) + 680,
                    680
                ) - 110
                local y = 22 + __L1:hash(i + 30) * 92
                local w = 34 + __L1:hash(i + 31) * 42
                local h = 8 + __L1:hash(i + 32) * 6
                local puffs = __arrL(
                    {
                        __arrL({0, 0, w * 0.5, h}, 4),
                        __arrL({w * 0.28, -h * 0.7, w * 0.22, h * 0.8}, 4),
                        __arrL({w * 0.55, -h * 0.45, w * 0.2, h * 0.7}, 4),
                        __arrL({w * 0.78, 0, w * 0.26, h * 0.7}, 4),
                        __arrL({w * 0.4, -h * 1.2, w * 0.14, h * 0.55}, 4)
                    },
                    5
                )
                for ____, ____value in __iterar((puffs)) do
                    local px = ____value[1]
                    local py = ____value[2]
                    local rx = ____value[3]
                    local ry = ____value[4]
                    __L1:ell(
                        c,
                        x + px + w * 0.1,
                        y + py + 2,
                        rx,
                        ry,
                        __L1:css(dark)
                    )
                end
                for ____, ____value in __iterar((puffs)) do
                    local px = ____value[1]
                    local py = ____value[2]
                    local rx = ____value[3]
                    local ry = ____value[4]
                    local ____L1_ell_26 = __L1.ell
                    local ____array_25 = __TS__SparseArrayNew(
                        c,
                        x + px + w * 0.1,
                        y + py,
                        rx,
                        ry * 0.92
                    )
                    local ____L1_css_24 = __L1.css
                    local ____temp_23
                    if gold > 0.05 then
                        ____temp_23 = cbody
                    else
                        ____temp_23 = cloud
                    end
                    __TS__SparseArrayPush(
                        ____array_25,
                        ____L1_css_24(__L1, ____temp_23)
                    )
                    ____L1_ell_26(
                        __L1,
                        __TS__SparseArraySpread(____array_25)
                    )
                end
                for ____, ____value in __iterar((puffs)) do
                    local px = ____value[1]
                    local py = ____value[2]
                    local rx = ____value[3]
                    local ry = ____value[4]
                    __L1:ell(
                        c,
                        x + px + w * 0.1 + (sunX > x + w * 0.5 and 2 or -2),
                        y + py - 2,
                        rx * 0.7,
                        ry * 0.5,
                        __L1:css(rim, 0.55 + gold * 0.2)
                    )
                end
                local ____L1_R_30 = __L1.R
                local ____array_29 = __TS__SparseArrayNew(
                    c,
                    x + w * 0.05,
                    y + h * 0.55,
                    w * 1.05,
                    3
                )
                local ____L1_css_28 = __L1.css
                local ____temp_27
                if gold > 0.05 then
                    ____temp_27 = belly
                else
                    ____temp_27 = shade
                end
                __TS__SparseArrayPush(
                    ____array_29,
                    ____L1_css_28(__L1, ____temp_27)
                )
                ____L1_R_30(
                    __L1,
                    __TS__SparseArraySpread(____array_29)
                )
                local ____L1_R_34 = __L1.R
                local ____array_33 = __TS__SparseArrayNew(
                    c,
                    x + w * 0.15,
                    y + h * 0.55 + 3,
                    w * 0.8,
                    1
                )
                local ____L1_css_32 = __L1.css
                local ____temp_31
                if gold > 0.05 then
                    ____temp_31 = belly
                else
                    ____temp_31 = shade
                end
                __TS__SparseArrayPush(
                    ____array_33,
                    ____L1_css_32(__L1, ____temp_31, 0.7)
                )
                ____L1_R_34(
                    __L1,
                    __TS__SparseArraySpread(____array_33)
                )
                i = i + 1
            end
        end
    end
    __L1.haze = function(self, c, s, t, camL, y0, y1)
        if y0 == nil then
            y0 = 150
        end
        if y1 == nil then
            y1 = 215
        end
        local ____t_38 = __t
        local ____t_result_37
        local ____t_36 = __t
        local ____t_result_35
        if __t(__L1.GRAV) then
            ____t_result_35 = c == __L1.GRAV.g
        else
            ____t_result_35 = __L1.GRAV
        end
        __O[300] = ____t_result_35
        if ____t_36(____t_result_35) then
            ____t_result_37 = not __t(__L1.GRAV.sujo)
        else
            ____t_result_37 = __O[300]
        end
        if ____t_38(____t_result_37) then
            local ____L1_GRAV_39, ____nNevoa_40 = __L1.GRAV, "nNevoa"
            local ____L1_GRAV_nNevoa_41 = ____L1_GRAV_39[____nNevoa_40]
            ____L1_GRAV_39[____nNevoa_40] = ____L1_GRAV_nNevoa_41 + 1
            local k = ____L1_GRAV_nNevoa_41
            if not __t(__get(__L1.GRAV.nevoas, k)) then
                __set(
                    __L1.GRAV.nevoas,
                    k,
                    __L1:mk(482, __L1.LH)
                )
            end
            local nv, ng = table.unpack(
                __get(__L1.GRAV.nevoas, k),
                1,
                2
            )
            ng:clearRect(0, 0, 482, __L1.LH)
            local lw = __L1.LW
            __L1.LW = 482
            do
                local ____try, ____error = pcall(function()
                    __L1:hazeBase(
                        ng,
                        s,
                        t,
                        __add(camL, __L1.GRAV.M),
                        y0,
                        y1
                    )
                end)
                do
                    __L1.LW = lw
                end
                if not ____try then
                    error(____error, 0)
                end
            end
            __call(__L1.GRAV.fundo, "push", {tipo = "nevoa", cv = nv})
            return
        end
        __L1:hazeBase(
            c,
            s,
            t,
            camL,
            y0,
            y1
        )
    end
    __L1.hazeBase = function(self, c, s, t, camL, y0, y1)
        local ____temp_42
        if s.sunT ~= nil then
            ____temp_42 = __L1:cl(1 - math.sin(s.sunT * math.pi) * 1.7)
        else
            ____temp_42 = 0
        end
        local gold = ____temp_42
        local h = s.h
        local ____t_result_43
        if __t(__gt(h, 5) and __lt(h, 9.5)) then
            ____t_result_43 = math.sin((h - 5) / 4.5 * math.pi)
        else
            ____t_result_43 = 0
        end
        local morning = ____t_result_43
        local col = __L1:mix(
            __L1:mix(
                s.bot,
                __arrL({1, 1, 1}, 3),
                0.35
            ),
            __arrL({1, 0.66, 0.5}, 3),
            gold * 0.7
        )
        local a = 0.16 + gold * 0.18 + morning * 0.1
        local g = c:createLinearGradient(0, y0, 0, y1)
        g:addColorStop(0, "rgba(0,0,0,0)")
        g:addColorStop(
            0.55,
            __L1:css(col, a)
        )
        g:addColorStop(
            1,
            __L1:css(col, a * 0.4)
        )
        c.fillStyle = g
        c:fillRect(0, y0, __L1.LW, y1 - y0)
        if morning > 0.05 then
            do
                local i = 0
                while i < 9 do
                    local x = __mod(
                        __mod(
                            __L1:hash(i + 90) * 900 + t * (2 + __L1:hash(i) * 3) - camL * 0.2,
                            760
                        ) + 760,
                        760
                    ) - 140
                    local y = y1 - 26 + __L1:hash(i + 91) * 20
                    local w = 90 + __L1:hash(i + 92) * 120
                    c.fillStyle = __L1:css(
                        __L1:mix(
                            __arrL({1, 1, 1}, 3),
                            col,
                            0.4
                        ),
                        0.12 * morning
                    )
                    do
                        local k = 0
                        while k < 4 do
                            c:fillRect(
                                math.floor(x + k * 7 + 0.5),
                                math.floor(y - k * 2 + 0.5),
                                math.floor(w - k * 14 + 0.5),
                                2
                            )
                            k = k + 1
                        end
                    end
                    i = i + 1
                end
            end
        end
    end
    __L1.buildFar = function(self)
        local A = __L1:mk(__L1.TILE, 196)
        local B = __L1:mk(__L1.TILE, 196)
        local C = __L1:mk(__L1.TILE, 196)
        do
            local x = 0
            while x < __L1.TILE do
                local y = math.floor(96 + __L1:ridge(x, 1.3, 26) + 0.5)
                __L1:R(
                    __get(A, 1),
                    x,
                    y,
                    1,
                    196 - y,
                    "#a7c8d0"
                )
                __L1:R(
                    __get(A, 1),
                    x,
                    y,
                    1,
                    1,
                    "#c6dfe2"
                )
                if __L1:hash(x * 3) > 0.6 then
                    __L1:R(
                        __get(A, 1),
                        x,
                        y + 2 + __L1:hash(x) * 14,
                        1,
                        2,
                        "#9bbdc6"
                    )
                end
                do
                    local yy = y + 30
                    while yy < 196 do
                        if __band(x + yy, 3) == 0 then
                            __L1:R(
                                __get(A, 1),
                                x,
                                yy,
                                1,
                                1,
                                "#b9d6d8"
                            )
                        end
                        yy = yy + 2
                    end
                end
                x = x + 1
            end
        end
        do
            local x = 0
            while x < __L1.TILE do
                local y = math.floor(128 + __L1:ridge(x, 4.1, 20) + 0.5)
                __L1:R(
                    __get(B, 1),
                    x,
                    y,
                    1,
                    196 - y,
                    "#7fb098"
                )
                __L1:R(
                    __get(B, 1),
                    x,
                    y,
                    1,
                    1,
                    "#9cc8ad"
                )
                if __L1:hash(x * 7 + 1) > 0.45 then
                    local h = 2 + math.floor(__L1:hash(x * 5) * 4 + 0.5)
                    __L1:R(
                        __get(B, 1),
                        x,
                        y - h + 1,
                        1,
                        h,
                        "#5f957c"
                    )
                end
                do
                    local k = 0
                    while k < 3 do
                        if __L1:hash(x * 13 + k) > 0.82 then
                            __L1:R(
                                __get(B, 1),
                                x,
                                y + 4 + __L1:hash(x + k * 7) * 40,
                                2,
                                1,
                                "#6fa48b"
                            )
                        end
                        k = k + 1
                    end
                end
                x = x + 1
            end
        end
        do
            local i = 0
            while i < 9 do
                local x = math.floor(__L1:hash(i + 800) * (__L1.TILE - 20) + 0.5)
                local y = math.floor(128 + __L1:ridge(x, 4.1, 20) + 0.5) + 6 + math.floor(__L1:hash(i + 810) * 18 + 0.5)
                __L1:R(
                    __get(B, 1),
                    x,
                    y,
                    7,
                    5,
                    "#f2ead6"
                )
                __L1:R(
                    __get(B, 1),
                    x - 1,
                    y - 3,
                    9,
                    3,
                    "#c9634a"
                )
                __L1:R(
                    __get(B, 1),
                    x,
                    y - 4,
                    7,
                    1,
                    "#a94e3a"
                )
                __L1:R(
                    __get(B, 1),
                    x + 3,
                    y + 2,
                    2,
                    3,
                    "#6a5444"
                )
                i = i + 1
            end
        end
        do
            local x = 0
            while x < __L1.TILE do
                local y = math.floor(156 + __L1:ridge(x, 7.7, 13) + 0.5)
                __L1:R(
                    __get(C, 1),
                    x,
                    y,
                    1,
                    196 - y,
                    "#5f9e62"
                )
                __L1:R(
                    __get(C, 1),
                    x,
                    y,
                    1,
                    1,
                    "#8cc477"
                )
                __L1:R(
                    __get(C, 1),
                    x,
                    y + 1,
                    1,
                    1,
                    "#74b06c"
                )
                x = x + 1
            end
        end
        local PATCH = __arrL({
            "#7bb356",
            "#93c05a",
            "#d9c46a",
            "#56925a",
            "#a8c860",
            "#c9a85a"
        }, 6)
        do
            local i = 0
            while i < 46 do
                local x = math.floor(__L1:hash(i + 900) * (__L1.TILE - 60) + 0.5)
                local y0 = math.floor(156 + __L1:ridge(x + 20, 7.7, 13) + 0.5) + 6 + math.floor(__L1:hash(i + 910) * 22 + 0.5)
                local w = 22 + math.floor(__L1:hash(i + 920) * 30 + 0.5)
                local h = 5 + math.floor(__L1:hash(i + 930) * 7 + 0.5)
                local col = __get(
                    PATCH,
                    __mod(i, 6)
                )
                do
                    local r = 0
                    while r < h do
                        __L1:R(
                            __get(C, 1),
                            x + r,
                            y0 + r,
                            w,
                            1,
                            col
                        )
                        r = r + 1
                    end
                end
                do
                    local r = 0
                    while r < h do
                        do
                            local k = 2
                            while k < w do
                                __L1:R(
                                    __get(C, 1),
                                    x + r + k,
                                    y0 + r,
                                    1,
                                    1,
                                    "rgba(40,70,40,.28)"
                                )
                                k = k + 3
                            end
                        end
                        r = r + 2
                    end
                end
                __L1:R(
                    __get(C, 1),
                    x,
                    y0,
                    w,
                    1,
                    "rgba(255,255,220,.25)"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 70 do
                local x = math.floor(__L1:hash(i + 1000) * (__L1.TILE - 12) + 0.5)
                local y = math.floor(156 + __L1:ridge(x, 7.7, 13) + 0.5) + 2 + math.floor(__L1:hash(i + 1010) * 30 + 0.5)
                local r = 3 + math.floor(__L1:hash(i + 1020) * 3 + 0.5)
                __L1:ell(
                    __get(C, 1),
                    x,
                    y,
                    r + 1,
                    r,
                    "#356f44"
                )
                __L1:ell(
                    __get(C, 1),
                    x - 1,
                    y - 1,
                    r,
                    r - 1,
                    "#468a4e"
                )
                __L1:R(
                    __get(C, 1),
                    x - 2,
                    y - 2,
                    2,
                    1,
                    "#6fb062"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 14 do
                local x = math.floor(__L1:hash(i + 1100) * (__L1.TILE - 10) + 0.5)
                local y = math.floor(156 + __L1:ridge(x, 7.7, 13) + 0.5) + 12 + math.floor(__L1:hash(i + 1110) * 22 + 0.5)
                __L1:R(
                    __get(C, 1),
                    x,
                    y,
                    4,
                    2,
                    __t(__mod(i, 3)) and "#f4f0e4" or "#6a4a3a"
                )
                __L1:R(
                    __get(C, 1),
                    x + 4,
                    y - 1,
                    2,
                    2,
                    __t(__mod(i, 3)) and "#f4f0e4" or "#6a4a3a"
                )
                __L1:R(
                    __get(C, 1),
                    x + 1,
                    y,
                    1,
                    1,
                    "#2c2c2c"
                )
                __L1:R(
                    __get(C, 1),
                    x,
                    y + 2,
                    1,
                    1,
                    "#3a3a3a"
                )
                __L1:R(
                    __get(C, 1),
                    x + 3,
                    y + 2,
                    1,
                    1,
                    "#3a3a3a"
                )
                i = i + 1
            end
        end
        local function relief(____, seed, amp, baseY, depth, side)
            local cv, c = table.unpack(
                __L1:mk(__L1.TILE, 196),
                1,
                2
            )
            do
                local x = 0
                while x < __L1.TILE do
                    do
                        local y = math.floor(baseY + __L1:ridge(x, seed, amp) + 0.5)
                        local slope = __L1:ridge(x + 3, seed, amp) - __L1:ridge(x - 3, seed, amp)
                        local lit = slope * side > 0.12
                        local dark = slope * side < -0.12
                        if __t(not __t(lit) and not __t(dark)) then
                            do x = x + 1 continue end
                        end
                        local k = math.min(
                            1,
                            math.abs(slope) / 1.2
                        )
                        do
                            local d = 0
                            while __lt(d, depth) do
                                do
                                    local f = 1 - d / depth
                                    local ____t_47 = __t
                                    local ____t_result_46
                                    local ____t_45 = __t
                                    local ____temp_44 = f < 0.5
                                    __O[301] = ____temp_44
                                    if ____t_45(____temp_44) then
                                        ____t_result_46 = __band(x + d, 1)
                                    else
                                        ____t_result_46 = __O[301]
                                    end
                                    if ____t_47(____t_result_46) then
                                        do d = d + 1 continue end
                                    end
                                    local ____c_49 = c
                                    local ____t_result_48
                                    if __t(lit) then
                                        ____t_result_48 = ("rgba(255,244,196," .. tostring(0.42 * k * f)) .. ")"
                                    else
                                        ____t_result_48 = ("rgba(18,34,70," .. tostring(0.36 * k * f)) .. ")"
                                    end
                                    ____c_49.fillStyle = ____t_result_48
                                    c:fillRect(x, y + d, 1, 1)
                                end
                                d = d + 1
                            end
                        end
                    end
                    x = x + 1
                end
            end
            return cv
        end
        local P = __arrL(
            {
                __arrL({1.3, 26, 96, 34}, 4),
                __arrL({4.1, 20, 128, 26}, 4),
                __arrL({7.7, 13, 156, 16}, 4)
            },
            3
        )
        return __arrL(
            {
                __get(A, 0),
                __get(B, 0),
                __get(C, 0),
                __call(
                    P,
                    "map",
                    function(____, p) return relief(
                        nil,
                        __get(p, 0),
                        __get(p, 1),
                        __get(p, 2),
                        __get(p, 3),
                        -1
                    ) end
                ),
                __call(
                    P,
                    "map",
                    function(____, p) return relief(
                        nil,
                        __get(p, 0),
                        __get(p, 1),
                        __get(p, 2),
                        __get(p, 3),
                        1
                    ) end
                )
            },
            5
        )
    end
    __L1.tile = function(self, c, img, off, p)
        local ____t_54 = __t
        local ____t_result_53
        if __t(__L1.GRAV) then
            local ____t_result_52
            local ____t_51 = __t
            local ____temp_50 = c == __L1.GRAV.g and not __t(__L1.GRAV.sujo)
            __O[302] = ____temp_50
            if ____t_51(____temp_50) then
                ____t_result_52 = __O[302]
            else
                ____t_result_52 = c == __L1.GRAV.lg
            end
            ____t_result_53 = ____t_result_52
        else
            ____t_result_53 = __L1.GRAV
        end
        if ____t_54(____t_result_53) then
            local ____call_63 = __call
            local ____L1_GRAV_fundo_62 = __L1.GRAV.fundo
            local ____img_61 = img
            local ____t_result_57
            local ____t_56 = __t
            local ____TS__Number_result_55 = __TS__Number(off)
            __O[303] = ____TS__Number_result_55
            if ____t_56(____TS__Number_result_55) then
                ____t_result_57 = __O[303]
            else
                ____t_result_57 = 0
            end
            local ____t_result_60
            local ____t_59 = __t
            local ____TS__Number_result_58 = __TS__Number(p)
            __O[304] = ____TS__Number_result_58
            if ____t_59(____TS__Number_result_58) then
                ____t_result_60 = __O[304]
            else
                ____t_result_60 = 0
            end
            ____call_63(____L1_GRAV_fundo_62, "push", {
                tipo = "tile",
                img = ____img_61,
                off = ____t_result_57,
                p = ____t_result_60,
                alfa = c.globalAlpha,
                luz = c == __L1.GRAV.lg
            })
            return
        end
        local T = img.width
        local o = __mod(
            __mod(
                math.floor(off + 0.5),
                T
            ) + T,
            T
        )
        c:drawImage(
            img,
            __TS__Number(-o),
            0
        )
        if T - o < __L1.LW then
            c:drawImage(img, T - o, 0)
        end
    end
    __L1.fence = function(self, c, x, w)
        local y = 212
        for ____, ry in __iterar((__arrL({195, 203}, 2))) do
            __L1:R(
                c,
                x,
                ry,
                w,
                3,
                "#6c6945"
            )
            __L1:R(
                c,
                x,
                ry,
                w,
                1,
                "#b7ab70"
            )
            __L1:R(
                c,
                x,
                ry + 3,
                w,
                1,
                "rgba(30,40,20,.25)"
            )
        end
        do
            local xx = x
            while __lt(
                xx,
                __add(x, w)
            ) do
                __L1:R(
                    c,
                    xx,
                    y - 24,
                    4,
                    24,
                    "#756c48"
                )
                __L1:R(
                    c,
                    xx,
                    y - 24,
                    1,
                    24,
                    "#a38e5e"
                )
                __L1:R(
                    c,
                    xx + 3,
                    y - 24,
                    1,
                    24,
                    "#544d33"
                )
                __L1:R(
                    c,
                    xx,
                    y - 25,
                    4,
                    1,
                    "#c1ae76"
                )
                __L1:R(
                    c,
                    xx + 1,
                    y - 17,
                    1,
                    1,
                    "#3d3826"
                )
                __L1:R(
                    c,
                    xx + 1,
                    y - 9,
                    1,
                    1,
                    "#3d3826"
                )
                if __L1:hash(xx) > 0.7 then
                    __L1:R(
                        c,
                        xx - 1,
                        y - 3,
                        1,
                        3,
                        "#4f9a3f"
                    )
                    __L1:R(
                        c,
                        xx + 4,
                        y - 4,
                        1,
                        4,
                        "#6fb24a"
                    )
                end
                xx = xx + 16.5
            end
        end
    end
    __L1.house = function(self, c, x)
        local b = 215
        c.fillStyle = "rgba(20,40,20,.22)"
        c:fillRect(x - 6, b - 1, 106, 3)
        __L1:R(
            c,
            x,
            b - 56,
            91,
            56,
            "#efd5a0"
        )
        do
            local i = 0
            while i < 260 do
                __L1:R(
                    c,
                    x + __L1:hash(i + x) * 90,
                    b - 55 + __L1:hash(i + x + 3) * 40,
                    1,
                    1,
                    __L1:hash(i) > 0.5 and "#e3c890" or "#f8e4b8"
                )
                i = i + 1
            end
        end
        __L1:R(
            c,
            x + 80,
            b - 56,
            11,
            56,
            "rgba(120,90,60,.16)"
        )
        do
            local i = 0
            while i < 6 do
                local cx2 = x + 8 + __L1:hash(i + x + 9) * 70
                local cy2 = b - 50 + __L1:hash(i + x + 11) * 22
                do
                    local k = 0
                    while k < 5 do
                        __L1:R(
                            c,
                            cx2,
                            cy2,
                            1,
                            1,
                            "#c9ac78"
                        )
                        cx2 = cx2 + (__L1:hash(i * 7 + k) > 0.5 and 1 or 0)
                        cy2 = cy2 + 1
                        k = k + 1
                    end
                end
                i = i + 1
            end
        end
        __L1:R(
            c,
            x,
            b - 14,
            91,
            14,
            "#b8946a"
        )
        do
            local r2 = 0
            while r2 < 3 do
                do
                    local k = -1
                    while k < 12 do
                        do
                            local sx = x + k * 9 + __mod(r2, 2) * 4
                            if __t(__lt(sx + 8, x) or __gt(sx, x + 90)) then
                                do k = k + 1 continue end
                            end
                            __L1:R(
                                c,
                                math.max(x, sx),
                                b - 13 + r2 * 4.5,
                                math.min(
                                    8,
                                    x + 91 - math.max(x, sx)
                                ),
                                4,
                                __get(
                                    __arrL({"#c4a074", "#ab8960", "#d1ad79"}, 3),
                                    __mod(k + r2 * 2 + 9, 3)
                                )
                            )
                        end
                        k = k + 1
                    end
                end
                r2 = r2 + 1
            end
        end
        __L1:R(
            c,
            x,
            b - 15,
            91,
            1,
            "#f6e2b4"
        )
        __L1:R(
            c,
            x - 3,
            b - 56,
            4,
            56,
            "#795846"
        )
        __L1:R(
            c,
            x - 3,
            b - 56,
            1,
            56,
            "#9a765c"
        )
        __L1:R(
            c,
            x + 90,
            b - 56,
            4,
            56,
            "#5f4435"
        )
        do
            local r2 = 0
            while r2 < 11 do
                local k = r2 / 10
                local xa = x + 8 - k * 18
                local xb = x + 78 + k * 24
                local yy = b - 78 + r2 * 2
                __L1:R(
                    c,
                    xa,
                    yy,
                    xb - xa,
                    2,
                    __t(__mod(r2, 2)) and "#c96545" or "#d9774d"
                )
                do
                    local xx = xa + __mod(r2, 2) * 3
                    while xx < xb - 1 do
                        __L1:R(
                            c,
                            xx,
                            yy,
                            1,
                            2,
                            "#f0a56d"
                        )
                        __L1:R(
                            c,
                            xx + 5,
                            yy,
                            1,
                            2,
                            "#8f4739"
                        )
                        xx = xx + 6
                    end
                end
                r2 = r2 + 1
            end
        end
        __L1:R(
            c,
            x + 6,
            b - 80,
            74,
            2,
            "#8f4739"
        )
        __L1:R(
            c,
            x + 6,
            b - 80,
            74,
            1,
            "#e8936a"
        )
        __L1:R(
            c,
            x - 11,
            b - 57,
            115,
            3,
            "#7b4737"
        )
        __L1:R(
            c,
            x - 11,
            b - 57,
            115,
            1,
            "#d18b59"
        )
        c.fillStyle = "rgba(60,40,30,.28)"
        c:fillRect(x, b - 54, 91, 3)
        c:fillRect(x + 2, b - 51, 87, 1)
        __L1:R(
            c,
            x + 62,
            b - 92,
            9,
            16,
            "#a9684f"
        )
        __L1:R(
            c,
            x + 62,
            b - 92,
            2,
            16,
            "#c98a6c"
        )
        __L1:R(
            c,
            x + 61,
            b - 94,
            11,
            3,
            "#7b4737"
        )
        do
            local k = 0
            while k < 3 do
                __L1:R(
                    c,
                    x + 63 + __mod(k, 2) * 3,
                    b - 89 + k * 4,
                    4,
                    1,
                    "#8a5440"
                )
                k = k + 1
            end
        end
        __L1:R(
            c,
            x + 36,
            b - 37,
            21,
            37,
            "#6a4c30"
        )
        __L1:R(
            c,
            x + 37,
            b - 36,
            19,
            36,
            "#886641"
        )
        do
            local k = 0
            while k < 4 do
                __L1:R(
                    c,
                    x + 38 + k * 4.5,
                    b - 35,
                    4,
                    35,
                    __t(__mod(k, 2)) and "#7a5a3a" or "#8f6c46"
                )
                __L1:R(
                    c,
                    x + 38 + k * 4.5,
                    b - 35,
                    1,
                    35,
                    "#a07a50"
                )
                k = k + 1
            end
        end
        __L1:R(
            c,
            x + 38,
            b - 26,
            17,
            2,
            "#5a4028"
        )
        __L1:R(
            c,
            x + 38,
            b - 10,
            17,
            2,
            "#5a4028"
        )
        __L1:R(
            c,
            x + 52,
            b - 19,
            2,
            2,
            "#e4ba73"
        )
        __L1:R(
            c,
            x + 34,
            b,
            25,
            2,
            "#b9b0a0"
        )
        __L1:R(
            c,
            x + 34,
            b,
            25,
            1,
            "#dcd4c4"
        )
        __L1:R(
            c,
            x + 60,
            b - 40,
            3,
            5,
            "#3a3a3a"
        )
        __L1:R(
            c,
            x + 60,
            b - 39,
            3,
            3,
            "#ffe9a8"
        )
        for ____, wx in __iterar((__arrL({x + 7, x + 66}, 2))) do
            __L1:R(
                c,
                wx - 1,
                b - 41,
                21,
                21,
                "#7a5536"
            )
            __L1:R(
                c,
                wx,
                b - 40,
                19,
                19,
                "#ac7c52"
            )
            __L1:R(
                c,
                wx + 2,
                b - 38,
                15,
                15,
                "#42595a"
            )
            __L1:R(
                c,
                wx + 2,
                b - 38,
                15,
                6,
                "#5a7a7a"
            )
            do
                local k = 0
                while k < 6 do
                    __L1:R(
                        c,
                        wx + 4 + k,
                        b - 37 + k,
                        3,
                        1,
                        "rgba(255,255,255,.22)"
                    )
                    k = k + 1
                end
            end
            __L1:R(
                c,
                wx + 9,
                b - 38,
                1,
                15,
                "#c19969"
            )
            __L1:R(
                c,
                wx + 2,
                b - 31,
                15,
                1,
                "#c19969"
            )
            for ____, sx in __iterar((__arrL({wx - 5, wx + 19}, 2))) do
                __L1:R(
                    c,
                    sx,
                    b - 40,
                    5,
                    19,
                    "#3f7a52"
                )
                __L1:R(
                    c,
                    sx,
                    b - 40,
                    1,
                    19,
                    "#5a9c6c"
                )
                do
                    local k = 0
                    while k < 6 do
                        __L1:R(
                            c,
                            sx + 1,
                            b - 38 + k * 3,
                            3,
                            1,
                            "#2c5a3c"
                        )
                        k = k + 1
                    end
                end
            end
            __L1:R(
                c,
                wx - 3,
                b - 21,
                25,
                4,
                "#8a5a3a"
            )
            __L1:R(
                c,
                wx - 3,
                b - 21,
                25,
                1,
                "#b07a50"
            )
            do
                local k = 0
                while k < 7 do
                    __L1:R(
                        c,
                        wx - 2 + k * 3.5,
                        b - 24 - __mod(k, 2),
                        3,
                        3,
                        "#4f9a3f"
                    )
                    __L1:R(
                        c,
                        wx - 1 + k * 3.5,
                        b - 26 - __mod(k, 2),
                        2,
                        2,
                        __get(
                            __arrL({"#e04a4a", "#f2d24a", "#f08ab0"}, 3),
                            __mod(k, 3)
                        )
                    )
                    k = k + 1
                end
            end
        end
        __L1:R(
            c,
            x + 97,
            b - 13,
            9,
            13,
            "#8a6238"
        )
        __L1:R(
            c,
            x + 97,
            b - 13,
            2,
            13,
            "#a87a48"
        )
        __L1:R(
            c,
            x + 97,
            b - 10,
            9,
            1,
            "#4a4a4a"
        )
        __L1:R(
            c,
            x + 97,
            b - 4,
            9,
            1,
            "#4a4a4a"
        )
        __L1:R(
            c,
            x + 97,
            b - 14,
            9,
            1,
            "#5a4028"
        )
        do
            local k = 0
            while k < 5 do
                __L1:ell(
                    c,
                    x - 12 + __mod(k, 3) * 4 + (k > 2 and 2 or 0),
                    b - 2 - (k > 2 and 4 or 0),
                    2,
                    2,
                    "#8a6238"
                )
                __L1:R(
                    c,
                    x - 13 + __mod(k, 3) * 4 + (k > 2 and 2 or 0),
                    b - 3 - (k > 2 and 4 or 0),
                    1,
                    1,
                    "#d9b98a"
                )
                k = k + 1
            end
        end
        do
            local r2 = 0
            while r2 < 5 do
                __L1:R(
                    c,
                    x + 36 - r2 * 2,
                    b + r2,
                    21 + r2 * 4,
                    1,
                    __t(__mod(r2, 2)) and "#b99262" or "#c4a074"
                )
                r2 = r2 + 1
            end
        end
    end
    __L1.sign = function(self, c, x, w, h, y, arrow)
        __L1:R(
            c,
            x + w / 2 - 2,
            y,
            4,
            216 - y,
            "#6a583d"
        )
        __L1:R(
            c,
            x + w / 2 - 2,
            y,
            1,
            216 - y,
            "#8a7654"
        )
        __L1:R(
            c,
            x - 1,
            y - 1,
            w + 2,
            h + 2,
            "#4f3a28"
        )
        __L1:R(
            c,
            x,
            y,
            w,
            h,
            "#c6ab70"
        )
        __L1:R(
            c,
            x,
            y,
            w,
            1,
            "#e6cf98"
        )
        __L1:R(
            c,
            x,
            __add(y, h) - 1,
            w,
            1,
            "#9a8352"
        )
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({x + 1, y + 1}, 2),
                __arrL(
                    {
                        __add(x, w) - 2,
                        y + 1
                    },
                    2
                ),
                __arrL(
                    {
                        x + 1,
                        __add(y, h) - 2
                    },
                    2
                ),
                __arrL(
                    {
                        __add(x, w) - 2,
                        __add(y, h) - 2
                    },
                    2
                )
            },
            4
        ))) do
            local nx = ____value[1]
            local ny = ____value[2]
            __L1:R(
                c,
                nx,
                ny,
                1,
                1,
                "#5a4a30"
            )
        end
        if __t(arrow) then
            local axx = __add(x, w) - 9
            local ay = y + math.floor(h / 2)
            __L1:R(
                c,
                axx,
                ay,
                5,
                1,
                "#4c4c36"
            )
            __L1:R(
                c,
                axx + 3,
                ay - 1,
                1,
                3,
                "#4c4c36"
            )
            __L1:R(
                c,
                axx + 2,
                ay - 2,
                1,
                5,
                "#4c4c36"
            )
        end
    end
    __L1.stand = function(self, c, x)
        __L1:R(
            c,
            x - 2,
            196,
            82,
            3,
            "#d0a96c"
        )
        __L1:R(
            c,
            x - 2,
            196,
            82,
            1,
            "#ecd09a"
        )
        __L1:R(
            c,
            x,
            199,
            78,
            20,
            "#5a4a30"
        )
        do
            local i = 0
            while i < 6 do
                local cx2 = x + 2 + i * 12.5
                __L1:R(
                    c,
                    cx2,
                    201,
                    10,
                    17,
                    "#a27a49"
                )
                __L1:R(
                    c,
                    cx2,
                    201,
                    10,
                    1,
                    "#d3a960"
                )
                __L1:R(
                    c,
                    cx2,
                    207,
                    10,
                    1,
                    "#7a5a34"
                )
                __L1:R(
                    c,
                    cx2,
                    212,
                    10,
                    1,
                    "#7a5a34"
                )
                __L1:R(
                    c,
                    cx2,
                    201,
                    1,
                    17,
                    "#c49a5c"
                )
                local col = __get(
                    __arrL({
                        "#e8842a",
                        "#d83a3a",
                        "#5aa83a",
                        "#e8c83a",
                        "#8a4aa8",
                        "#e8842a"
                    }, 6),
                    i
                )
                do
                    local k = 0
                    while k < 4 do
                        __L1:R(
                            c,
                            cx2 + 1 + k * 2.2,
                            193 - __mod(k, 2),
                            2,
                            3,
                            col
                        )
                        __L1:R(
                            c,
                            cx2 + 1 + k * 2.2,
                            193 - __mod(k, 2),
                            1,
                            1,
                            "rgba(255,255,255,.5)"
                        )
                        k = k + 1
                    end
                end
                i = i + 1
            end
        end
        __L1:R(
            c,
            x - 4,
            172,
            2,
            47,
            "#6a583d"
        )
        __L1:R(
            c,
            x + 80,
            172,
            2,
            47,
            "#6a583d"
        )
        do
            local k = 0
            while k < 86 do
                __L1:R(
                    c,
                    x - 5 + k,
                    168,
                    6,
                    6,
                    __t(__mod(k / 6, 2)) and "#d9483b" or "#f3ead6"
                )
                __L1:R(
                    c,
                    x - 5 + k,
                    174,
                    6,
                    2,
                    __t(__mod(k / 6, 2)) and "#a8362e" or "#cfc5ae"
                )
                k = k + 6
            end
        end
        __L1:R(
            c,
            x - 5,
            167,
            87,
            1,
            "#fff6e0"
        )
    end
    __L1.hay = function(self, c, x)
        __L1:R(
            c,
            x,
            205,
            34,
            12,
            "#a77c45"
        )
        __L1:R(
            c,
            x - 1,
            202,
            36,
            4,
            "#dfbd6c"
        )
        __L1:R(
            c,
            x - 1,
            202,
            36,
            1,
            "#f4dc92"
        )
        do
            local k = 0
            while k < 34 do
                __L1:R(
                    c,
                    x + k,
                    206 + __mod(k, 2),
                    1,
                    10,
                    "#c79a56"
                )
                k = k + 3
            end
        end
        __L1:R(
            c,
            x,
            209,
            34,
            1,
            "#8a6238"
        )
        __L1:R(
            c,
            x,
            214,
            34,
            1,
            "#8a6238"
        )
        do
            local k = 0
            while k < 6 do
                __L1:R(
                    c,
                    x + __L1:hash(k + x) * 32,
                    200,
                    1,
                    2,
                    "#f4dc92"
                )
                k = k + 1
            end
        end
    end
    __L1.bush = function(self, c, x, w)
        local r = w / 4
        __L1:ell(
            c,
            x,
            212,
            r * 2,
            8,
            "#2f5f38"
        )
        __L1:ell(
            c,
            x - r * 0.6,
            209,
            r * 1.2,
            8,
            "#3f8045"
        )
        __L1:ell(
            c,
            x + r * 0.7,
            208,
            r * 1.1,
            7,
            "#4a914c"
        )
        __L1:ell(
            c,
            x - r * 0.8,
            206,
            r * 0.6,
            4,
            "#68ad58"
        )
        do
            local i = 0
            while i < 9 do
                __L1:R(
                    c,
                    x - r * 1.6 + __L1:hash(i + x) * r * 3.2,
                    202 + __L1:hash(i + x + 5) * 10,
                    1,
                    1,
                    __t(__mod(i, 3)) and "#8fcf6a" or "#e86a8a"
                )
                i = i + 1
            end
        end
    end
    __L1.buildFarmMid = function(self)
        local W = __L1:worldW(0)
        local cv, c = table.unpack(
            __L1:mk(W, __L1.LH),
            1,
            2
        )
        __L1:R(
            c,
            0,
            184,
            W,
            3,
            "#57923f"
        )
        __L1:R(
            c,
            0,
            187,
            W,
            9,
            "#68a34b"
        )
        __L1:R(
            c,
            0,
            196,
            W,
            24,
            "#80b751"
        )
        __L1:dither(
            c,
            0,
            186,
            W,
            "#68a34b"
        )
        __L1:dither(
            c,
            0,
            195,
            W,
            "#80b751"
        )
        __L1:R(
            c,
            0,
            184,
            W,
            1,
            "#9ccc68"
        )
        do
            local i = 0
            while i < W / 3 do
                do
                    local x = __L1:hash(i + 50) * W
                    local y = 188 + __L1:hash(i + 51) * 30
                    if y > 218 then
                        do i = i + 1 continue end
                    end
                    __L1:R(
                        c,
                        x,
                        y,
                        2 + __L1:hash(i) * 5,
                        1,
                        __L1:hash(i + 3) > 0.5 and "#6fa848" or "#92c860"
                    )
                end
                i = i + 1
            end
        end
        do
            local i = 0
            while i < W / 22 do
                local x = __L1:hash(i + 70) * W
                local y = 198 + __L1:hash(i + 71) * 18
                __L1:R(
                    c,
                    x,
                    y - 2,
                    1,
                    3,
                    "#3e863d"
                )
                __L1:R(
                    c,
                    x + 1,
                    y - 3,
                    1,
                    4,
                    "#58a046"
                )
                __L1:R(
                    c,
                    x + 2,
                    y - 1,
                    1,
                    2,
                    "#3e863d"
                )
                if __mod(i, 4) == 0 then
                    __L1:R(
                        c,
                        x + 4,
                        y - 3,
                        2,
                        2,
                        __get(
                            __arrL({"#efcf71", "#e86a8a", "#ffffff"}, 3),
                            __mod(i, 3)
                        )
                    )
                    __L1:R(
                        c,
                        x + 4,
                        y - 1,
                        1,
                        2,
                        "#456841"
                    )
                end
                i = i + 1
            end
        end
        __L1:R(
            c,
            0,
            __L1.FLOOR,
            W,
            50,
            "#a17349"
        )
        __L1:R(
            c,
            0,
            232,
            W,
            18,
            "#93673f"
        )
        __L1:R(
            c,
            0,
            250,
            W,
            20,
            "#825a36"
        )
        __L1:dither(
            c,
            0,
            231,
            W,
            "#93673f"
        )
        __L1:dither(
            c,
            0,
            230,
            W,
            "#93673f"
        )
        __L1:dither(
            c,
            0,
            249,
            W,
            "#825a36"
        )
        __L1:dither(
            c,
            0,
            248,
            W,
            "#825a36"
        )
        do
            local i = 0
            while i < W / 2 do
                local x = __L1:hash(i + 90) * W
                local y = 226 + __L1:hash(i + 91) * 43
                __L1:R(
                    c,
                    x,
                    y,
                    1 + __L1:hash(i) * 3,
                    1,
                    __L1:hash(i + 2) > 0.5 and "#b68b54" or "#7a5230"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < W / 14 do
                local x = __L1:hash(i + 110) * W
                local y = 230 + __L1:hash(i + 111) * 36
                local r = 1.5 + __L1:hash(i + 112) * 2.5
                __L1:ell(
                    c,
                    x,
                    y,
                    r + 1,
                    r,
                    "#6a5a48"
                )
                __L1:ell(
                    c,
                    x,
                    y - 0.5,
                    r,
                    r - 0.5,
                    "#b5a58c"
                )
                __L1:R(
                    c,
                    x - 1,
                    y - 1,
                    1,
                    1,
                    "#e0d4bc"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < W / 60 do
                local x = __L1:hash(i + 130) * W
                local y = 226
                do
                    local k = 0
                    while k < 9 + __L1:hash(i) * 8 do
                        __L1:R(
                            c,
                            x,
                            y,
                            1,
                            1,
                            "#6a4a2c"
                        )
                        x = x + (__L1:hash(i * 5 + k) > 0.5 and 1 or -1)
                        y = y + 1
                        k = k + 1
                    end
                end
                i = i + 1
            end
        end
        __L1:R(
            c,
            0,
            __L1.FLOOR,
            W,
            2,
            "#a6d055"
        )
        __L1:R(
            c,
            0,
            __L1.FLOOR + 2,
            W,
            3,
            "#3f7f35"
        )
        __L1:R(
            c,
            0,
            __L1.FLOOR + 5,
            W,
            2,
            "#736a3a"
        )
        do
            local x = 0
            while x < W do
                local h = __L1:hash(x * 3 + 7)
                if h > 0.55 then
                    __L1:R(
                        c,
                        x,
                        __L1.FLOOR + 5,
                        1,
                        1 + math.floor(h * 3 + 0.5),
                        "#3f7f35"
                    )
                end
                if h < 0.2 then
                    __L1:R(
                        c,
                        x,
                        __L1.FLOOR - 1,
                        1,
                        1,
                        "#c6e870"
                    )
                end
                x = x + 1
            end
        end
        for ____, ____value in __iterar((__L1.FARM_FENCES)) do
            local x = ____value[1]
            local w = ____value[2]
            __L1:fence(c, x, w)
        end
        do
            local x = 1295
            local i = 0
            while x < W do
                if __mod(i, 3) ~= 0 then
                    __L1:bush(c, x + 72, 42)
                end
                if __mod(i, 3) == 1 then
                    __L1:hay(c, x + 5)
                end
                do
                    x = x + 122.5
                    i = i + 1
                end
            end
        end
        __L1:house(c, 66)
        __L1:house(c, 1752)
        __L1:R(
            c,
            175,
            181,
            2,
            34,
            "#79664a"
        )
        __L1:R(
            c,
            243,
            178,
            2,
            37,
            "#79664a"
        )
        __L1:R(
            c,
            175,
            181,
            1,
            34,
            "#9a8462"
        )
        __L1:stand(c, 985)
        __L1:sign(
            c,
            303,
            60,
            15,
            183,
            true
        )
        __L1:sign(
            c,
            2136,
            50,
            25,
            176,
            false
        )
        return cv
    end
    __L1.touch = function(self, scene, wx, wy, vx, vy)
        if scene ~= __L1.treeScene then
            return
        end
        local ax = wx / 2
        local top = (wy - 76) / 2
        local bot = wy / 2
        local speed = math.min(
            1,
            (math.abs(vx) + math.abs(vy) * 0.6) / 260
        )
        for ____, tr in __iterar((__L1.TREES)) do
            do
                local r = tr.r * 1.05
                if math.abs(ax - tr.x) > r then
                    continue
                end
                if __t(bot < tr.y0 - 4 or __gt(top, tr.y1 + 20)) then
                    continue
                end
                local inside = top < tr.y1 - 4
                local add = (__t(inside) and 0.9 or 0.35) * speed
                if add < 0.01 then
                    continue
                end
                if __t(math.abs(vx) + math.abs(vy) > 20 and math.random() < (__t(inside) and 0.6 or 0.2) * (0.3 + speed)) then
                    do
                        local k = 0
                        while k < (__t(inside) and 2 or 1) do
                            __call(
                                __L1.LEAVES,
                                "push",
                                {
                                    wx = tr.x + (math.random() - 0.5) * r * 1.4,
                                    wy = tr.y0 + math.random() * (tr.y1 - tr.y0),
                                    vx = (math.random() - 0.5) * 10 + vx * 0.02,
                                    vy = 4 + math.random() * 6,
                                    a = math.random() * 6,
                                    life = 4 + math.random() * 3,
                                    col = math.random() < 0.25 and "#c9a24a" or (math.random() < 0.5 and "#56a64c" or "#7cc85a")
                                }
                            )
                            k = k + 1
                        end
                    end
                end
            end
        end
        if __len(__L1.LEAVES) > 140 then
            __call(
                __L1.LEAVES,
                "splice",
                0,
                __len(__L1.LEAVES) - 140
            )
        end
    end
    __L1.leavesDraw = function(self, c, camL, t, dt)
        for ____, ____value in __iterar((__L1.RUSTLE)) do
            local k = ____value[1]
            local v = ____value[2]
            local n = v * 0.25 ^ dt
            if n < 0.01 then
                __call(__L1.RUSTLE, "delete", k)
            else
                __call(__L1.RUSTLE, "set", k, n)
            end
        end
        for ____, L in __iterar((__L1.LEAVES)) do
            do
                L.life = L.life - dt
                L.a = L.a + dt * 3
                L.wx = L.wx + (L.vx + math.sin(L.a) * 8) * dt
                L.wy = L.wy + L.vy * dt
                if __gt(L.wy, 214) then
                    L.wy = 214
                    L.vx = L.vx * 0.5
                    L.vy = 0
                end
                local x = L.wx - camL
                if __t(x < -4 or x > __L1.LW + 4) then
                    continue
                end
                __L1:R(
                    c,
                    x,
                    L.wy,
                    2,
                    1,
                    L.col
                )
                if math.sin(L.a) > 0 then
                    __L1:R(
                        c,
                        x + 1,
                        L.wy - 1,
                        1,
                        1,
                        L.col
                    )
                end
            end
        end
        do
            local i = __len(__L1.LEAVES) - 1
            while i >= 0 do
                if __le(
                    __get(__L1.LEAVES, i).life,
                    0
                ) then
                    __call(__L1.LEAVES, "splice", i, 1)
                end
                i = i - 1
            end
        end
    end
    __L1.tree = function(self, c, x, base, s, kind, t, seed, lean)
        if lean == nil then
            lean = 1
        end
        local camHere = __L1.treeCam
        local ____call_68 = __call
        local ____L1_TREES_67 = __L1.TREES
        local ____seed_65 = seed
        local ____temp_66 = x + camHere
        local ____temp_64
        if kind == 1 then
            ____temp_64 = 26 * s
        else
            ____temp_64 = 30 * s
        end
        ____call_68(____L1_TREES_67, "push", {
            seed = ____seed_65,
            x = ____temp_66,
            r = ____temp_64,
            y0 = base - (kind == 1 and 50 or 92) * s,
            y1 = base - (kind == 1 and 30 or 38) * s
        })
        local ____t_result_71
        local ____t_70 = __t
        local ____call_result_69 = __call(__L1.RUSTLE, "get", seed)
        __O[305] = ____call_result_69
        if ____t_70(____call_result_69) then
            ____t_result_71 = __O[305]
        else
            ____t_result_71 = 0
        end
        local shake = ____t_result_71
        local ____t_result_81
        local ____t_80 = __t
        local ____opt_76 = window.Weather
        if ____opt_76 ~= nil then
            ____opt_76 = ____opt_76.state
        end
        local ____opt_result_78
        if ____opt_76 ~= nil then
            ____opt_result_78 = ____opt_76(____opt_76)
        end
        local ____opt_result_79
        if ____opt_result_78 ~= nil then
            ____opt_result_79 = ____opt_result_78.cover
        end
        __O[306] = ____opt_result_79
        if ____t_80(____opt_result_79) then
            ____t_result_81 = __O[306]
        else
            ____t_result_81 = 0
        end
        local snow = ____t_result_81
        if kind == 1 then
            do
                local k = 0
                while k < 42 * s do
                    local px = x + math.floor(k * 0.08 * s + 0.5)
                    local py = base - k
                    __L1:R(
                        c,
                        px - 2,
                        py,
                        5,
                        1,
                        __mod(k, 5) == 0 and "#5f4530" or "#79553b"
                    )
                    __L1:R(
                        c,
                        px - 2,
                        py,
                        1,
                        1,
                        "#98704b"
                    )
                    k = k + 1
                end
            end
            local tx = x + math.floor(42 * 0.08 * s * s + 0.5)
            local ty = base - math.floor(42 * s + 0.5)
            local sw = math.sin(t * (1.4 + shake * 6) + seed) * (1.5 + shake * 4)
            do
                local i = 0
                while i < 8 do
                    local a = -math.pi + 0.2 + i * 0.39
                    local len = 30 * s
                    do
                        local k = 0
                        while k <= len do
                            local u = k / len
                            local px = tx + math.cos(a) * k + sw * u
                            local py = ty + math.sin(a) * k * 0.55 + u * u * 16 * s
                            __L1:R(
                                c,
                                px,
                                py,
                                2,
                                1,
                                __t(__mod(i, 2)) and "#367c42" or "#64a147"
                            )
                            if __mod(k, 2) == 0 then
                                __L1:R(
                                    c,
                                    px,
                                    py + 1,
                                    1,
                                    2 + math.floor(u * 3 + 0.5),
                                    __t(__mod(i, 2)) and "#2c6838" or "#4f8f3f"
                                )
                            end
                            k = k + 1
                        end
                    end
                    i = i + 1
                end
            end
            __L1:ell(
                c,
                tx - 1,
                ty + 2,
                2,
                2,
                "#5a3f2a"
            )
            __L1:ell(
                c,
                tx + 3,
                ty + 3,
                2,
                2,
                "#6a4a30"
            )
            return
        end
        local th = 46 * s
        __L1:R(
            c,
            x - 4 * s,
            base - th,
            8 * s,
            th,
            "#674c36"
        )
        __L1:R(
            c,
            x - 4 * s,
            base - th,
            2 * s,
            th,
            "#896241"
        )
        __L1:R(
            c,
            x + 2 * s,
            base - th,
            2 * s,
            th,
            "#4f3a29"
        )
        do
            local k = 0
            while k < 6 do
                __L1:R(
                    c,
                    x - 2 * s + __L1:hash(k + seed) * 4 * s,
                    base - 6 - k * 7 * s,
                    1,
                    3,
                    "#4f3a29"
                )
                k = k + 1
            end
        end
        __L1:R(
            c,
            x - 6 * s,
            base - 2,
            12 * s,
            2,
            "#5a4230"
        )
        __L1:R(
            c,
            x - 9 * s,
            base - 30 * s,
            6 * s,
            3,
            "#674c36"
        )
        __L1:R(
            c,
            x + 4 * s,
            base - 36 * s,
            8 * s,
            3,
            "#674c36"
        )
        local CL = __arrL(
            {
                __arrL({0, -58, 19}, 3),
                __arrL({-18, -50, 15}, 3),
                __arrL({18, -52, 15}, 3),
                __arrL({-9, -70, 15}, 3),
                __arrL({11, -72, 14}, 3),
                __arrL({0, -82, 13}, 3),
                __arrL({-25, -62, 11}, 3),
                __arrL({25, -64, 11}, 3)
            },
            8
        )
        local function sway(____, i)
            local ____gt_result_82
            if __gt(shake, 0.05) then
                ____gt_result_82 = math.floor(math.sin(t * (1.3 + shake * 9) + seed + i * 1.7) * (1 + shake * 3.2) + 0.5)
            else
                ____gt_result_82 = math.floor(math.sin(t * 0.9 + seed + i * 0.18) * 0.9 + math.sin(t * 0.37 + seed) * 0.4 + 0.5)
            end
            return ____gt_result_82
        end
        __call(
            CL,
            "forEach",
            function(____, p, i) return __L1:ell(
                c,
                x + __get(p, 0) * s + sway(nil, i),
                base + __get(p, 1) * s + 3,
                __get(p, 2) * s,
                __get(p, 2) * s * 0.92,
                "#2a5f36"
            ) end
        )
        __call(
            CL,
            "forEach",
            function(____, p, i) return __L1:ell(
                c,
                x + __get(p, 0) * s + sway(nil, i),
                base + __get(p, 1) * s,
                __get(p, 2) * s,
                __get(p, 2) * s * 0.9,
                "#3f8a45"
            ) end
        )
        __call(
            CL,
            "forEach",
            function(____, p, i) return __L1:ell(
                c,
                x + __get(p, 0) * s + sway(nil, i) - lean * 4 * s,
                base + __get(p, 1) * s - 4 * s,
                __get(p, 2) * s * 0.62,
                __get(p, 2) * s * 0.5,
                "#56a64c"
            ) end
        )
        __call(
            CL,
            "forEach",
            function(____, p, i) return __L1:ell(
                c,
                x + __get(p, 0) * s + sway(nil, i) - lean * 7 * s,
                base + __get(p, 1) * s - 7 * s,
                __get(p, 2) * s * 0.3,
                __get(p, 2) * s * 0.2,
                "#7cc85a"
            ) end
        )
        do
            local i = 0
            while i < 46 do
                local p = __get(
                    CL,
                    __mod(i, 8)
                )
                local a = __L1:hash(i + seed) * 6.28
                local r = __L1:hash(i + seed + 3) * __get(p, 2) * s * 0.85
                local px = x + __get(p, 0) * s + math.cos(a) * r + sway(
                    nil,
                    __mod(i, 8)
                )
                local py = base + __get(p, 1) * s + math.sin(a) * r * 0.9
                __L1:R(
                    c,
                    px,
                    py,
                    2,
                    1,
                    __t(__mod(i, 3)) and "#2f6b3c" or "#8fd468"
                )
                if __mod(i, 9) == 0 then
                    __L1:R(
                        c,
                        px,
                        py + 1,
                        2,
                        2,
                        "#f0a030"
                    )
                    __L1:R(
                        c,
                        px,
                        py + 1,
                        1,
                        1,
                        "#ffd070"
                    )
                end
                i = i + 1
            end
        end
        if __gt(snow, 0.05) then
            local a = math.min(1, snow * 1.3)
            __call(
                CL,
                "forEach",
                function(____, p, i)
                    if __get(p, 1) > -55 then
                        return
                    end
                    local cx = x + __get(p, 0) * s + sway(nil, i)
                    local cy = base + __get(p, 1) * s - __get(p, 2) * s * 0.62
                    __L1:ell(
                        c,
                        cx,
                        cy + 1,
                        __get(p, 2) * s * 0.78,
                        math.max(
                            1.5,
                            __get(p, 2) * s * 0.26 * a
                        ),
                        ("rgba(150,170,205," .. tostring(0.7 * a)) .. ")"
                    )
                    __L1:ell(
                        c,
                        cx,
                        cy,
                        __get(p, 2) * s * 0.74,
                        math.max(
                            1.2,
                            __get(p, 2) * s * 0.22 * a
                        ),
                        ("rgba(250,252,255," .. tostring(a)) .. ")"
                    )
                end
            )
            __L1:R(
                c,
                x - 9 * s,
                base - 31 * s,
                6 * s,
                1,
                ("rgba(250,252,255," .. tostring(a)) .. ")"
            )
            __L1:R(
                c,
                x + 4 * s,
                base - 37 * s,
                8 * s,
                1,
                ("rgba(250,252,255," .. tostring(a)) .. ")"
            )
        end
    end
    __L1.sunInfo = function(self, s)
        local ____temp_83
        if s.sunT ~= nil then
            ____temp_83 = s.sunT
        else
            ____temp_83 = s.moonT
        end
        local T = ____temp_83
        if T == nil then
            return {lean = 0, str = 0}
        end
        local ____temp_85 = (0.5 - T) * 2
        local ____temp_84
        if s.sunT ~= nil then
            ____temp_84 = __L1:cl(math.sin(s.sunT * math.pi) * 1.4 + 0.15)
        else
            ____temp_84 = 0.3 * math.sin(s.moonT * math.pi)
        end
        return {lean = ____temp_85, str = ____temp_84}
    end
    __L1.shadeAt = function(self, scene, worldX)
        if scene ~= __L1.shadeScene then
            return {k = 0, leaves = false}
        end
        local x = worldX / 2 - __L1.shadeCam
        local k = 0
        local leaves = false
        for ____, ____value in __iterar((__L1.SHADE)) do
            local a = ____value[1]
            local b = ____value[2]
            local kk = ____value[3]
            local lv = ____value[4]
            do
                local edge = math.min(x - a, b - x)
                if edge <= -3 then
                    continue
                end
                local v = kk * math.min(1, (edge + 3) / 7)
                if v > k then
                    k = v
                    leaves = lv
                end
            end
        end
        return {k = k, leaves = leaves}
    end
    __L1.lightsAt = function(self, scene, worldX)
        if scene ~= __L1.lightScene then
            return __arrL({}, 0)
        end
        local out = __arrL({}, 0)
        local fl = __L1.FLOOR * 2
        for ____, L in __iterar((__L1.LIGHTS)) do
            do
                if __t(L.patch) then
                    local x0 = (L.x0 + __L1.lightCam) * 2
                    local x1 = (L.x1 + __L1.lightCam) * 2
                    if __t(__ge(worldX, x0 - 6) and __le(worldX, x1 + 6)) then
                        __call(
                            out,
                            "push",
                            {
                                k = L.k,
                                a = L.a * math.min(
                                    1,
                                    (math.min(worldX - x0, x1 - worldX) + 6) / 14
                                ),
                                fade = 0.55
                            }
                        )
                    end
                    continue
                end
                local lx = (L.x + __L1.lightCam) * 2
                local top = L.top * 2
                local hl = math.max(60, fl - top)
                local hw = L.reach * 2 * math.max(
                    0.2,
                    (__L1.FLOOR - L.top) / math.max(1, 262 - L.top)
                ) + 30
                local dx = worldX - lx
                if math.abs(dx) > hw then
                    continue
                end
                __call(
                    out,
                    "push",
                    {
                        k = math.max(
                            -3,
                            math.min(
                                3,
                                dx / math.max(40, hl - 75)
                            )
                        ),
                        a = L.a * (1 - math.abs(dx) / hw) ^ 0.6,
                        fade = 0.8,
                        lx = lx,
                        top = top
                    }
                )
            end
        end
        return __call(
            __call(
                out,
                "sort",
                function(____, a, b) return b.a - a.a end
            ),
            "slice",
            0,
            3
        )
    end
    __L1.slant = function(self, c, x0, x1, y0, dx, h, col)
        c.fillStyle = col
        do
            local r = 0
            while __lt(r, h) do
                c:fillRect(
                    math.floor(x0 + dx * (r + 1) / h + 0.5),
                    y0 + r,
                    math.max(
                        1,
                        math.floor(x1 - x0 + 0.5)
                    ),
                    1
                )
                r = r + 1
            end
        end
    end
    __L1.farm = function(self, c, s, t, camL)
        if not __t(__L1.far) then
            __L1.far = __L1:buildFar()
        end
        if not __t(__get(__L1.mids, 0)) then
            __set(
                __L1.mids,
                0,
                __L1:buildFarmMid()
            )
        end
        __L1:sky(c, s, t, camL)
        local sun = __L1:sunInfo(s)
        local lean = sun.lean
        local la = math.min(
            1,
            math.abs(lean) * 1.3
        ) * sun.str
        local rel = __get(__L1.far, lean >= 0 and 3 or 4)
        __call(
            __arrL({0.04, 0.1, 0.22}, 3),
            "forEach",
            function(____, p, i)
                __L1:tile(
                    c,
                    __get(__L1.far, i),
                    camL * p,
                    p
                )
                if la > 0.03 then
                    c.globalAlpha = la
                    __L1:tile(
                        c,
                        __get(rel, i),
                        camL * p,
                        p
                    )
                    c.globalAlpha = 1
                end
                if i == 1 then
                    __L1:haze(
                        c,
                        s,
                        t,
                        camL,
                        120,
                        200
                    )
                end
            end
        )
        for ____, hx in __iterar((__L1.FARM_HOUSES)) do
            do
                local x = hx - camL + 66
                if __t(x < -30 or x > __L1.LW + 30) then
                    continue
                end
                do
                    local i = 0
                    while i < 6 do
                        local k = __mod(t * 0.22 + i / 6, 1)
                        c.fillStyle = ("rgba(235,235,230," .. tostring((1 - k) * 0.5)) .. ")"
                        local r = 2 + k * 4
                        c:fillRect(
                            math.floor(x + math.sin(t + i * 2) * 3 * k + k * 10 - r / 2 + 0.5),
                            math.floor(119 - k * 34 + 0.5),
                            math.floor(r + 0.5),
                            math.floor(r * 0.8 + 0.5)
                        )
                        i = i + 1
                    end
                end
            end
        end
        c:drawImage(
            __get(__L1.mids, 0),
            camL,
            0,
            __L1.LW,
            __L1.LH,
            0,
            0,
            __L1.LW,
            __L1.LH
        )
        do
            local ____t_result_95
            local ____t_94 = __t
            local ____opt_90 = window.Weather
            if ____opt_90 ~= nil then
                ____opt_90 = ____opt_90.state
            end
            local ____opt_result_92
            if ____opt_90 ~= nil then
                ____opt_result_92 = ____opt_90(____opt_90)
            end
            local ____opt_result_93
            if ____opt_result_92 ~= nil then
                ____opt_result_93 = ____opt_result_92.cover
            end
            __O[309] = ____opt_result_93
            if ____t_94(____opt_result_93) then
                ____t_result_95 = __O[309]
            else
                ____t_result_95 = 0
            end
            local snow = ____t_result_95
            if __gt(snow, 0.05) then
                local a = math.min(1, snow * 1.3)
                for ____, hx in __iterar((__L1.FARM_HOUSES)) do
                    do
                        local x = hx - camL
                        if __t(x < -140 or x > __L1.LW + 40) then
                            continue
                        end
                        do
                            local r2 = 0
                            while r2 < 4 do
                                local k = r2 / 10
                                local xa = x + 8 - k * 18
                                local xb = x + 78 + k * 24
                                __L1:R(
                                    c,
                                    xa,
                                    136 + r2 * 2,
                                    xb - xa,
                                    2,
                                    ("rgba(250,252,255," .. tostring(a * (1 - r2 * 0.2))) .. ")"
                                )
                                r2 = r2 + 1
                            end
                        end
                        __L1:R(
                            c,
                            x + 50,
                            112,
                            13,
                            2,
                            ("rgba(250,252,255," .. tostring(a)) .. ")"
                        )
                    end
                end
            end
        end
        if sun.str > 0.04 then
            local sh = ("rgba(18,30,52," .. tostring(0.3 * sun.str)) .. ")"
            local reach = lean * (14 + math.abs(lean) * 26)
            for ____, hx in __iterar((__L1.FARM_HOUSES)) do
                local x = hx - camL
                if __t(x > -160 and x < __L1.LW + 160) then
                    __L1:slant(
                        c,
                        x - 3,
                        x + 94,
                        215,
                        reach * 1.6,
                        5,
                        sh
                    )
                    __L1:shadeAdd(x - 3 + reach * 1.6, x + 94 + reach * 1.6, 1)
                end
            end
            do
                local x = 985 - camL
                if __t(x > -160 and x < __L1.LW + 160) then
                    __L1:slant(
                        c,
                        x - 4,
                        x + 82,
                        219,
                        reach,
                        3,
                        sh
                    )
                end
            end
            for ____, ____value in __iterar((__L1.FARM_FENCES)) do
                local fx = ____value[1]
                local fw = ____value[2]
                do
                    if __t(fx - camL > __L1.LW + 40 or fx + fw - camL < -40) then
                        continue
                    end
                    do
                        local xx = fx
                        while xx < fx + fw do
                            __L1:slant(
                                c,
                                xx - camL,
                                xx - camL + 3,
                                212,
                                reach * 0.7,
                                4,
                                sh
                            )
                            xx = xx + 16.5
                        end
                    end
                    __L1:slant(
                        c,
                        fx - camL,
                        fx + fw - camL,
                        214,
                        reach * 0.5,
                        2,
                        ("rgba(18,30,52," .. tostring(0.14 * sun.str)) .. ")"
                    )
                end
            end
            for ____, ____value in __iterar((__L1.FARM_TREES)) do
                local tx = ____value[1]
                local base = ____value[2]
                local sc = ____value[3]
                local kind = ____value[4]
                do
                    local x = tx - camL
                    if __t(x < -120 or x > __L1.LW + 120) then
                        continue
                    end
                    __L1:slant(
                        c,
                        x - 2,
                        x + 3,
                        base,
                        reach * 0.8,
                        5,
                        sh
                    )
                    __L1:ell(
                        c,
                        x + reach * (__t(kind) and 1.5 or 1.2) * sc,
                        base + 4,
                        (__t(kind) and 16 or 24) * sc,
                        3.2,
                        sh
                    )
                    do
                        local cx = x + reach * (__t(kind) and 1.5 or 1.2) * sc
                        local r = (__t(kind) and 16 or 24) * sc
                        __L1:shadeAdd(cx - r, cx + r, 0.9, true)
                    end
                end
            end
        end
        for ____, ____value in __iterar((__L1.FARM_TREES)) do
            local tx = ____value[1]
            local base = ____value[2]
            local sc = ____value[3]
            local kind = ____value[4]
            do
                local x = tx - camL
                if __t(x < -70 or x > __L1.LW + 70) then
                    continue
                end
                local ____L1_tree_98 = __L1.tree
                local ____array_97 = __TS__SparseArrayNew(
                    c,
                    x,
                    base,
                    sc,
                    kind,
                    t,
                    tx
                )
                local ____temp_96
                if lean >= 0 then
                    ____temp_96 = math.max(0.35, lean)
                else
                    ____temp_96 = math.min(-0.35, lean)
                end
                __TS__SparseArrayPush(____array_97, ____temp_96)
                ____L1_tree_98(
                    __L1,
                    __TS__SparseArraySpread(____array_97)
                )
            end
        end
        if sun.str > 0.04 then
            for ____, hx in __iterar((__L1.FARM_HOUSES)) do
                do
                    local x = hx - camL
                    if __t(x < -120 or x > __L1.LW + 20) then
                        continue
                    end
                    local a = math.min(
                        1,
                        math.abs(lean) * 1.4
                    ) * sun.str
                    local ____temp_99
                    if lean >= 0 then
                        ____temp_99 = x
                    else
                        ____temp_99 = x + 63
                    end
                    local litX = ____temp_99
                    local ____temp_100
                    if lean >= 0 then
                        ____temp_100 = x + 63
                    else
                        ____temp_100 = x
                    end
                    local darkX = ____temp_100
                    do
                        local k = 0
                        while k < 28 do
                            do
                                local f = 1 - k / 28
                                local ____temp_101
                                if lean >= 0 then
                                    ____temp_101 = k
                                else
                                    ____temp_101 = 27 - k
                                end
                                local px = ____temp_101
                                local ____t_105 = __t
                                local ____t_result_104
                                local ____t_103 = __t
                                local ____temp_102 = f < 0.4
                                __O[310] = ____temp_102
                                if ____t_103(____temp_102) then
                                    ____t_result_104 = __band(k, 1)
                                else
                                    ____t_result_104 = __O[310]
                                end
                                if ____t_105(____t_result_104) then
                                    do k = k + 1 continue end
                                end
                                c.fillStyle = ("rgba(255,240,190," .. tostring(0.3 * a * f)) .. ")"
                                c:fillRect(
                                    math.floor(litX + px + 0.5),
                                    159,
                                    1,
                                    56
                                )
                                c.fillStyle = ("rgba(30,24,60," .. tostring(0.26 * a * f)) .. ")"
                                c:fillRect(
                                    math.floor(darkX + 27 - px + 0.5),
                                    159,
                                    1,
                                    56
                                )
                            end
                            k = k + 1
                        end
                    end
                    do
                        local r2 = 0
                        while r2 < 11 do
                            local k = r2 / 10
                            local xa = x + 8 - k * 18
                            local xb = x + 78 + k * 24
                            local half = (xb - xa) * 0.45
                            c.fillStyle = ("rgba(255,236,180," .. tostring(0.26 * a)) .. ")"
                            local ____c_107 = c
                            local ____c_fillRect_108 = c.fillRect
                            local ____temp_106
                            if lean >= 0 then
                                ____temp_106 = xa
                            else
                                ____temp_106 = xb - half
                            end
                            ____c_fillRect_108(
                                ____c_107,
                                math.floor(____temp_106 + 0.5),
                                137 + r2 * 2,
                                math.floor(half + 0.5),
                                1
                            )
                            c.fillStyle = ("rgba(40,20,50," .. tostring(0.22 * a)) .. ")"
                            local ____c_110 = c
                            local ____c_fillRect_111 = c.fillRect
                            local ____temp_109
                            if lean >= 0 then
                                ____temp_109 = xb - half
                            else
                                ____temp_109 = xa
                            end
                            ____c_fillRect_111(
                                ____c_110,
                                math.floor(____temp_109 + 0.5),
                                137 + r2 * 2,
                                math.floor(half + 0.5),
                                2
                            )
                            r2 = r2 + 1
                        end
                    end
                    local gl = math.max(
                        0,
                        1 - math.abs(lean) * 1.1
                    ) * 0.2 + math.min(
                        1,
                        math.abs(lean) * 1.5
                    ) * 0.75
                    for ____, wx in __iterar((__arrL({x + 9, x + 68}, 2))) do
                        local off = math.floor((lean >= 0 and 0 or 6) + math.sin(t * 0.5) * 1 + 0.5)
                        do
                            local k = 0
                            while k < 9 do
                                c.fillStyle = ("rgba(255,252,225," .. tostring(gl * sun.str * (k < 5 and 0.9 or 0.5))) .. ")"
                                local ____c_114 = c
                                local ____c_fillRect_115 = c.fillRect
                                local ____temp_113 = wx + off
                                local ____temp_112
                                if lean >= 0 then
                                    ____temp_112 = k
                                else
                                    ____temp_112 = 8 - k
                                end
                                ____c_fillRect_115(
                                    ____c_114,
                                    ____temp_113 + ____temp_112 * 0.6,
                                    177 + k,
                                    k < 5 and 4 or 2,
                                    1
                                )
                                k = k + 1
                            end
                        end
                    end
                end
            end
        end
        do
            local x0 = 176 - camL
            if __t(x0 > -80 and x0 < __L1.LW) then
                __L1:R(
                    c,
                    x0,
                    182,
                    68,
                    1,
                    "#706246"
                )
                do
                    local i = 0
                    while i < 4 do
                        local x = x0 + 7 + i * 14.5
                        local col = __get(
                            __arrL({"#f0c27c", "#74afb9", "#d57555", "#f2dda2"}, 4),
                            i
                        )
                        local col2 = __get(
                            __arrL({"#d9a85e", "#5a94a0", "#b85c40", "#dcc484"}, 4),
                            i
                        )
                        do
                            local r = 0
                            while r < 13 do
                                local wv = math.floor(math.sin(t * 3 + i + r * 0.25) * (r / 12) * 2.4 + 0.5)
                                local ____L1_R_118 = __L1.R
                                local ____array_117 = __TS__SparseArrayNew(
                                    c,
                                    x + wv,
                                    183 + r,
                                    10,
                                    1
                                )
                                local ____temp_116
                                if r > 9 then
                                    ____temp_116 = col2
                                else
                                    ____temp_116 = col
                                end
                                __TS__SparseArrayPush(____array_117, ____temp_116)
                                ____L1_R_118(
                                    __L1,
                                    __TS__SparseArraySpread(____array_117)
                                )
                                __L1:R(
                                    c,
                                    x + wv,
                                    183 + r,
                                    1,
                                    1,
                                    col2
                                )
                                r = r + 1
                            end
                        end
                        __L1:R(
                            c,
                            x + 1,
                            182,
                            1,
                            2,
                            "#5e6141"
                        )
                        __L1:R(
                            c,
                            x + 8,
                            182,
                            1,
                            2,
                            "#5e6141"
                        )
                        i = i + 1
                    end
                end
            end
        end
        do
            local i = 0
            while i < 22 do
                do
                    local x = math.floor(467.5 + i * 8.5 + 0.5) - camL
                    if __t(x < -10 or x > __L1.LW + 10) then
                        do i = i + 1 continue end
                    end
                    local y = 211 + __mod(i, 2) * 4
                    local wv = math.floor(math.sin(t * 2 + i * 0.2) * 1.3 + 0.5)
                    __L1:R(
                        c,
                        x,
                        y - 19,
                        2,
                        19,
                        "#497f38"
                    )
                    __L1:R(
                        c,
                        x,
                        y - 19,
                        1,
                        19,
                        "#6aa850"
                    )
                    do
                        local k = 0
                        while k < 5 do
                            __L1:R(
                                c,
                                x - 1 - k + wv * (k / 4),
                                y - 9 - k,
                                2,
                                1,
                                "#438a39"
                            )
                            __L1:R(
                                c,
                                x + 2 + k + wv * (k / 4),
                                y - 13 - k,
                                2,
                                1,
                                "#8bbb42"
                            )
                            k = k + 1
                        end
                    end
                    __L1:R(
                        c,
                        x - 1,
                        y - 17,
                        3,
                        8,
                        "#e7c94c"
                    )
                    __L1:R(
                        c,
                        x - 1,
                        y - 17,
                        1,
                        8,
                        "#fff09a"
                    )
                    __L1:R(
                        c,
                        x,
                        y - 20 + (__t(wv) and 0 or 0),
                        2,
                        3,
                        "#ffe17a"
                    )
                    __L1:R(
                        c,
                        x + wv,
                        y - 22,
                        1,
                        2,
                        "#d9b84a"
                    )
                end
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 8 do
                do
                    local x = 195 + i * 140 + math.sin(t * 0.8 + i) * 13 - camL
                    local y = 175 + math.sin(t * 1.6 + i * 3) * 8
                    if __t(x < -5 or x > __L1.LW + 5) then
                        do i = i + 1 continue end
                    end
                    local w = math.floor(math.abs(math.sin(t * 9 + i)) * 2 + 0.5) + 1
                    __L1:R(
                        c,
                        x - w,
                        y - 1,
                        w,
                        2,
                        __t(__mod(i, 2)) and "#f0ce60" or "#e9a66d"
                    )
                    __L1:R(
                        c,
                        x + 1,
                        y - 1,
                        w,
                        2,
                        __t(__mod(i, 2)) and "#ffe5a1" or "#f5bf8c"
                    )
                    __L1:R(
                        c,
                        x,
                        y - 1,
                        1,
                        3,
                        "#4b6240"
                    )
                end
                i = i + 1
            end
        end
    end
    __L1.farmText = function(self, c, camera)
        c:save()
        c:translate(
            -math.floor(camera + 0.5),
            0
        )
        c.font = "16px Pixel, monospace"
        c.textAlign = "center"
        c.textBaseline = "middle"
        c.fillStyle = "#4c4c36"
        c:fillText("ITABUNA", 654, 382)
        c:fillText("TRILHA", 4322, 366)
        c:fillText("DA ROÇA", 4322, 388)
        c:restore()
    end
    __L1.farmLights = function(self, g, s, t, camL)
        if __le(s.night, 0.15) then
            return
        end
        for ____, hx in __iterar((__L1.FARM_HOUSES)) do
            do
                local x = hx - camL
                if __t(x < -140 or x > __L1.LW + 60) then
                    continue
                end
                for ____, wx in __iterar((__arrL({16, 75}, 2))) do
                    __L1:lightAdd(x + wx, 184, 0.7 * s.night, 40)
                    local gr = g:createRadialGradient(
                        x + wx,
                        184,
                        2,
                        x + wx,
                        186,
                        34
                    )
                    gr:addColorStop(
                        0,
                        ("rgba(255,200,110," .. tostring(0.5 * s.night)) .. ")"
                    )
                    gr:addColorStop(1, "rgba(255,200,110,0)")
                    g.fillStyle = gr
                    g:fillRect(x + wx - 36, 150, 72, 72)
                    g.fillStyle = ("rgba(255,226,150," .. tostring(0.9 * s.night)) .. ")"
                    g:fillRect(
                        math.floor(x + wx - 7 + 0.5),
                        177,
                        15,
                        15
                    )
                end
                local gl = g:createRadialGradient(
                    x + 61,
                    177,
                    1,
                    x + 61,
                    180,
                    30
                )
                gl:addColorStop(
                    0,
                    ("rgba(255,220,150," .. tostring(0.8 * s.night)) .. ")"
                )
                gl:addColorStop(1, "rgba(255,220,150,0)")
                g.fillStyle = gl
                g:fillRect(x + 30, 148, 62, 62)
            end
        end
    end
    __L1.buildGymMid = function(self)
        local W = __L1:worldW(2)
        local cv, c = table.unpack(
            __L1:mk(W, __L1.LH),
            1,
            2
        )
        __L1:R(
            c,
            0,
            0,
            W,
            134,
            "#3f5654"
        )
        do
            local i = 0
            while i < W * 1.2 do
                __L1:R(
                    c,
                    __L1:hash(i + 5) * W,
                    18 + __L1:hash(i + 6) * 114,
                    1,
                    1,
                    __L1:hash(i) > 0.5 and "#3a504e" or "#466059"
                )
                i = i + 1
            end
        end
        do
            local x = 0
            while x < W do
                __L1:R(
                    c,
                    x,
                    18,
                    1,
                    116,
                    "#344a48"
                )
                __L1:R(
                    c,
                    x + 1,
                    18,
                    1,
                    116,
                    "#4a625f"
                )
                x = x + 70
            end
        end
        __L1:R(
            c,
            0,
            0,
            W,
            10,
            "#22302f"
        )
        __L1:R(
            c,
            0,
            10,
            W,
            3,
            "#35494a"
        )
        __L1:R(
            c,
            0,
            13,
            W,
            1,
            "#1a2625"
        )
        __L1:R(
            c,
            0,
            14,
            W,
            4,
            "#71806c"
        )
        __L1:R(
            c,
            0,
            14,
            W,
            1,
            "#93a08a"
        )
        do
            local x = 20
            while x < W do
                __L1:R(
                    c,
                    x,
                    0,
                    6,
                    13,
                    "#1a2625"
                )
                __L1:R(
                    c,
                    x,
                    0,
                    1,
                    13,
                    "#2e4040"
                )
                x = x + 70
            end
        end
        __L1:R(
            c,
            0,
            134,
            W,
            86,
            "#546960"
        )
        do
            local y = 146
            while y < 207 do
                __L1:R(
                    c,
                    0,
                    y,
                    W,
                    1,
                    "#465a52"
                )
                __L1:R(
                    c,
                    0,
                    y + 1,
                    W,
                    1,
                    "#5e746a"
                )
                y = y + 12
            end
        end
        do
            local i = 0
            while i < W do
                __L1:R(
                    c,
                    __L1:hash(i + 15) * W,
                    138 + __L1:hash(i + 16) * 68,
                    2,
                    1,
                    __L1:hash(i) > 0.5 and "#4c6058" or "#5d7369"
                )
                i = i + 1
            end
        end
        __L1:R(
            c,
            0,
            134,
            W,
            3,
            "#a19874"
        )
        __L1:R(
            c,
            0,
            134,
            W,
            1,
            "#c9c09a"
        )
        __L1:R(
            c,
            0,
            137,
            W,
            1,
            "#3e5048"
        )
        __L1:R(
            c,
            0,
            207,
            W,
            13,
            "#30463e"
        )
        __L1:R(
            c,
            0,
            207,
            W,
            1,
            "#4a655a"
        )
        __L1:R(
            c,
            0,
            __L1.FLOOR,
            W,
            50,
            "#554b48"
        )
        do
            local i = 0
            while i < W * 2.5 do
                __L1:R(
                    c,
                    __L1:hash(i + 25) * W,
                    224 + __L1:hash(i + 26) * 46,
                    1,
                    1,
                    __get(
                        __arrL({"#655956", "#463d3b", "#6f6360", "#7a8a80"}, 4),
                        __mod(i, 4)
                    )
                )
                i = i + 1
            end
        end
        do
            local x = 0
            while x < W do
                __L1:R(
                    c,
                    x,
                    225,
                    1,
                    45,
                    "#463d3b"
                )
                __L1:R(
                    c,
                    x + 1,
                    225,
                    1,
                    45,
                    "#5f5451"
                )
                x = x + 48
            end
        end
        __L1:R(
            c,
            0,
            246,
            W,
            1,
            "#463d3b"
        )
        __L1:R(
            c,
            0,
            __L1.FLOOR,
            W,
            3,
            "#8f8170"
        )
        __L1:R(
            c,
            0,
            __L1.FLOOR,
            W,
            1,
            "#b3a58e"
        )
        __L1:R(
            c,
            0,
            __L1.FLOOR + 3,
            W,
            2,
            "#3d3533"
        )
        do
            local i = 0
            while __L1.GW.x0 + i * __L1.GW.step < W do
                local wx = __L1.GW.x0 + i * __L1.GW.step
                local sl = __L1:gymSlats(i)
                local last = __get(
                    sl,
                    __len(sl) - 1
                )
                __L1:R(
                    c,
                    wx - 5,
                    __L1.GW.y - 5,
                    __L1.GW.w + 10,
                    __L1.GW.h + 10,
                    "#1d2e2e"
                )
                __L1:R(
                    c,
                    wx - 4,
                    __L1.GW.y - 4,
                    __L1.GW.w + 8,
                    __L1.GW.h + 8,
                    "#2a4141"
                )
                __L1:R(
                    c,
                    wx - 4,
                    __L1.GW.y - 4,
                    __L1.GW.w + 8,
                    1,
                    "#4a6a68"
                )
                __L1:R(
                    c,
                    wx - 4,
                    __L1.GW.y - 4,
                    1,
                    __L1.GW.h + 8,
                    "#3d5a58"
                )
                __L1:R(
                    c,
                    wx - 1,
                    __L1.GW.y - 1,
                    __L1.GW.w + 2,
                    __L1.GW.h + 2,
                    "#152222"
                )
                c:clearRect(wx, __L1.GW.y, __L1.GW.w, __L1.GW.h)
                __L1:R(
                    c,
                    wx,
                    __L1.GW.y,
                    __L1.GW.w,
                    2,
                    "#8f8562"
                )
                for ____, y in __iterar((sl)) do
                    __L1:R(
                        c,
                        wx,
                        y,
                        __L1.GW.w,
                        3,
                        "#cdbf92"
                    )
                    __L1:R(
                        c,
                        wx,
                        y,
                        __L1.GW.w,
                        1,
                        "#efe2b4"
                    )
                    __L1:R(
                        c,
                        wx,
                        y + 2,
                        __L1.GW.w,
                        1,
                        "#9f946e"
                    )
                end
                if __mod(i, 4) == 3 then
                    local y0 = __get(sl, 7)
                    c:clearRect(wx, y0, __L1.GW.w, 3)
                    do
                        local k = 0
                        while k < __L1.GW.w do
                            __L1:R(
                                c,
                                wx + k,
                                y0 + math.floor(k / 15),
                                1,
                                2,
                                "#cdbf92"
                            )
                            __L1:R(
                                c,
                                wx + k,
                                y0 + math.floor(k / 15),
                                1,
                                1,
                                "#efe2b4"
                            )
                            k = k + 1
                        end
                    end
                end
                __L1:R(
                    c,
                    wx,
                    last + 5,
                    __L1.GW.w,
                    3,
                    "#b3a67e"
                )
                __L1:R(
                    c,
                    wx,
                    last + 5,
                    __L1.GW.w,
                    1,
                    "#d9cc9e"
                )
                for ____, cx in __iterar((__arrL({wx + 20, wx + 67}, 2))) do
                    do
                        local y = __L1.GW.y + 2
                        while y < last + 5 do
                            __L1:R(
                                c,
                                cx,
                                y,
                                1,
                                1,
                                "#857b5c"
                            )
                            y = y + 1
                        end
                    end
                end
                if __t(__L1:gymOpen(i)) then
                    __L1:R(
                        c,
                        wx + 43,
                        last + 8,
                        2,
                        __L1.GW.y + __L1.GW.h - last - 8,
                        "#2a4141"
                    )
                    __L1:R(
                        c,
                        wx + 80,
                        last + 8,
                        1,
                        14,
                        "#857b5c"
                    )
                    __L1:R(
                        c,
                        wx + 79,
                        last + 22,
                        3,
                        3,
                        "#cdbf92"
                    )
                end
                __L1:R(
                    c,
                    wx - 8,
                    __L1.GW.y + __L1.GW.h + 5,
                    __L1.GW.w + 16,
                    3,
                    "#71806c"
                )
                __L1:R(
                    c,
                    wx - 8,
                    __L1.GW.y + __L1.GW.h + 5,
                    __L1.GW.w + 16,
                    1,
                    "#a3ae98"
                )
                c.fillStyle = "rgba(0,0,0,.18)"
                c:fillRect(wx - 6, __L1.GW.y + __L1.GW.h + 8, __L1.GW.w + 12, 2)
                local lx = wx + 114
                __L1:R(
                    c,
                    lx,
                    13,
                    1,
                    23,
                    "#1a2625"
                )
                do
                    local k = 0
                    while k < 6 do
                        __L1:R(
                            c,
                            lx - 5 - k,
                            36 + k,
                            11 + k * 2,
                            1,
                            __t(k) and "#c9a96a" or "#8a7448"
                        )
                        k = k + 1
                    end
                end
                __L1:R(
                    c,
                    lx - 10,
                    41,
                    21,
                    1,
                    "#e8cf94"
                )
                __L1:R(
                    c,
                    lx - 3,
                    42,
                    7,
                    2,
                    "#ffe5a1"
                )
                if __mod(i, 2) == 0 then
                    __L1:R(
                        c,
                        wx + 100,
                        62,
                        28,
                        36,
                        "#1d2e2e"
                    )
                    __L1:R(
                        c,
                        wx + 101,
                        63,
                        26,
                        34,
                        __get(
                            __arrL({"#d9a84a", "#c9574a", "#6a9a8a"}, 3),
                            __mod(i, 3)
                        )
                    )
                    __L1:R(
                        c,
                        wx + 108,
                        68,
                        12,
                        12,
                        "#2a3a38"
                    )
                    __L1:R(
                        c,
                        wx + 104,
                        73,
                        20,
                        2,
                        "#2a3a38"
                    )
                    __L1:R(
                        c,
                        wx + 104,
                        71,
                        3,
                        6,
                        "#2a3a38"
                    )
                    __L1:R(
                        c,
                        wx + 121,
                        71,
                        3,
                        6,
                        "#2a3a38"
                    )
                    do
                        local k = 0
                        while k < 3 do
                            __L1:R(
                                c,
                                wx + 104,
                                85 + k * 3,
                                14 + __mod(k, 2) * 6,
                                1,
                                "#f3ead6"
                            )
                            k = k + 1
                        end
                    end
                end
                i = i + 1
            end
        end
        do
            local i = 0
            while 45 + i * 282.5 < W do
                local x = math.floor(45 + i * 282.5 + 0.5)
                __L1:R(
                    c,
                    x - 1,
                    144,
                    86,
                    51,
                    "#3a4d48"
                )
                __L1:R(
                    c,
                    x,
                    145,
                    84,
                    49,
                    "#879c8a"
                )
                __L1:R(
                    c,
                    x + 2,
                    147,
                    80,
                    45,
                    "#6d8580"
                )
                __L1:R(
                    c,
                    x + 2,
                    147,
                    38,
                    45,
                    "#78958c"
                )
                __L1:R(
                    c,
                    x + 2,
                    180,
                    80,
                    12,
                    "#5e7570"
                )
                __L1:R(
                    c,
                    x + 2,
                    180,
                    80,
                    1,
                    "#8aa69a"
                )
                do
                    local k = 0
                    while k < 40 do
                        c.fillStyle = "rgba(255,255,255,.16)"
                        c:fillRect(
                            x + 8 + math.floor((40 - k) * 0.7 + 0.5),
                            149 + k,
                            6,
                            1
                        )
                        c.fillStyle = "rgba(255,255,255,.09)"
                        c:fillRect(
                            x + 22 + math.floor((40 - k) * 0.7 + 0.5),
                            149 + k,
                            3,
                            1
                        )
                        k = k + 1
                    end
                end
                __L1:R(
                    c,
                    x + 40,
                    147,
                    2,
                    45,
                    "#a6af98"
                )
                for ____, px in __iterar((__arrL({x - 7, x + 88}, 2))) do
                    __L1:R(
                        c,
                        px,
                        184,
                        3,
                        36,
                        "#263d3b"
                    )
                    __L1:R(
                        c,
                        px,
                        184,
                        1,
                        36,
                        "#3f5a56"
                    )
                    __L1:R(
                        c,
                        px - 1,
                        186,
                        5,
                        2,
                        "#8a968c"
                    )
                end
                __L1:R(
                    c,
                    x - 14,
                    188,
                    112,
                    2,
                    "#a6aba0"
                )
                __L1:R(
                    c,
                    x - 14,
                    188,
                    112,
                    1,
                    "#d5dad0"
                )
                for ____, ____value in __iterar((__arrL(
                    {
                        __arrL({x - 12, 1}, 2),
                        __arrL({x + 92, -1}, 2)
                    },
                    2
                ))) do
                    local px = ____value[1]
                    local d = ____value[2]
                    __L1:R(
                        c,
                        px,
                        181,
                        5,
                        16,
                        "#283b3a"
                    )
                    __L1:R(
                        c,
                        px,
                        181,
                        1,
                        16,
                        "#44605c"
                    )
                    __L1:R(
                        c,
                        px - 4 * d + (d < 0 and 5 or -1),
                        184,
                        4,
                        10,
                        "#75897c"
                    )
                end
                __L1:R(
                    c,
                    x + 12,
                    206,
                    54,
                    5,
                    "#a56d48"
                )
                __L1:R(
                    c,
                    x + 12,
                    206,
                    54,
                    1,
                    "#c98c62"
                )
                __L1:R(
                    c,
                    x + 12,
                    210,
                    54,
                    1,
                    "#7a4c30"
                )
                __L1:R(
                    c,
                    x + 15,
                    211,
                    3,
                    9,
                    "#293e3b"
                )
                __L1:R(
                    c,
                    x + 60,
                    211,
                    3,
                    9,
                    "#293e3b"
                )
                c.fillStyle = "rgba(0,0,0,.2)"
                c:fillRect(x + 10, __L1.FLOOR, 58, 2)
                i = i + 1
            end
        end
        __L1:R(
            c,
            371,
            148,
            152,
            21,
            "#1c2f2c"
        )
        __L1:R(
            c,
            372,
            149,
            150,
            19,
            "#2c4440"
        )
        __L1:R(
            c,
            372,
            149,
            150,
            1,
            "#4a6a64"
        )
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({374, 151}, 2),
                __arrL({519, 151}, 2),
                __arrL({374, 165}, 2),
                __arrL({519, 165}, 2)
            },
            4
        ))) do
            local bx = ____value[1]
            local by = ____value[2]
            __L1:R(
                c,
                bx,
                by,
                1,
                1,
                "#c9b06a"
            )
        end
        __L1:R(
            c,
            527,
            208,
            138,
            2,
            "#263d3b"
        )
        for ____, lx in __iterar((__arrL({529, 661}, 2))) do
            __L1:R(
                c,
                lx,
                210,
                2,
                10,
                "#263d3b"
            )
        end
        do
            local i = 0
            while i < 6 do
                local x = math.floor(530 + i * 22.5 + 0.5)
                __L1:R(
                    c,
                    x,
                    201,
                    17,
                    3,
                    "#9eac92"
                )
                __L1:R(
                    c,
                    x,
                    201,
                    17,
                    1,
                    "#c5d0bc"
                )
                for ____, px in __iterar((__arrL({x + 1, x + 12}, 2))) do
                    __L1:R(
                        c,
                        px,
                        196,
                        4,
                        12,
                        "#233f3b"
                    )
                    __L1:R(
                        c,
                        px,
                        196,
                        1,
                        12,
                        "#3f625c"
                    )
                end
                i = i + 1
            end
        end
        do
            local x = 1340
            local i = 0
            while x < W do
                __L1:R(
                    c,
                    x,
                    157,
                    65,
                    51,
                    "#263e3b"
                )
                __L1:R(
                    c,
                    x + 3,
                    160,
                    58,
                    45,
                    "#7d9889"
                )
                __L1:R(
                    c,
                    x + 7,
                    165,
                    21,
                    34,
                    "#99afa1"
                )
                __L1:R(
                    c,
                    x + 31,
                    164,
                    2,
                    37,
                    "#c5ccb0"
                )
                do
                    local k = 0
                    while k < 30 do
                        c.fillStyle = "rgba(255,255,255,.14)"
                        c:fillRect(
                            x + 38 + math.floor((30 - k) * 0.6 + 0.5),
                            164 + k,
                            4,
                            1
                        )
                        k = k + 1
                    end
                end
                __L1:R(
                    c,
                    x - 8,
                    207,
                    77,
                    4,
                    "#293f39"
                )
                __L1:R(
                    c,
                    x - 8,
                    207,
                    77,
                    1,
                    "#3f5a52"
                )
                do
                    local j = 0
                    while j < 4 do
                        local xx = math.floor(x + j * 16.5 + 0.5)
                        __L1:R(
                            c,
                            xx,
                            199,
                            13,
                            3,
                            "#a6b69c"
                        )
                        for ____, px in __iterar((__arrL({xx + 1, xx + 9}, 2))) do
                            __L1:R(
                                c,
                                px,
                                195,
                                3,
                                10,
                                "#304e43"
                            )
                            __L1:R(
                                c,
                                px,
                                195,
                                1,
                                10,
                                "#4a6e60"
                            )
                        end
                        j = j + 1
                    end
                end
                __L1:R(
                    c,
                    x - 7,
                    138,
                    142,
                    14,
                    "#1c2f2c"
                )
                __L1:R(
                    c,
                    x - 6,
                    139,
                    140,
                    12,
                    "#2c4440"
                )
                __L1:R(
                    c,
                    x - 6,
                    139,
                    140,
                    1,
                    "#4a6a64"
                )
                do
                    x = x + 175
                    i = i + 1
                end
            end
        end
        do
            local i = 0
            while 208 + i * 395 < W do
                local x = 208 + i * 395
                __L1:R(
                    c,
                    x,
                    217,
                    52,
                    3,
                    "#3a6a9a"
                )
                __L1:R(
                    c,
                    x,
                    217,
                    52,
                    1,
                    "#5a8cbc"
                )
                __L1:R(
                    c,
                    x + 25,
                    217,
                    1,
                    3,
                    "#2c5078"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while 160 + i * 565 < W do
                local x = 160 + i * 565
                __L1:R(
                    c,
                    x,
                    180,
                    12,
                    40,
                    "#cfd8dc"
                )
                __L1:R(
                    c,
                    x,
                    180,
                    12,
                    1,
                    "#ffffff"
                )
                __L1:R(
                    c,
                    x + 1,
                    164,
                    10,
                    16,
                    "#7ec3e6"
                )
                __L1:R(
                    c,
                    x + 2,
                    166,
                    2,
                    12,
                    "#c9ecfa"
                )
                __L1:R(
                    c,
                    x + 4,
                    194,
                    4,
                    3,
                    "#39464c"
                )
                i = i + 1
            end
        end
        return cv
    end
    __L1.gym = function(self, c, s, t, camL)
        if not __t(__get(__L1.mids, 2)) then
            __set(
                __L1.mids,
                2,
                __L1:buildGymMid()
            )
        end
        local am = __L1:gymAmb(s)
        local function pre(____, v)
            return __arrL(
                {
                    __get(v, 0) / __get(am, 0),
                    __get(v, 1) / __get(am, 1),
                    __get(v, 2) / __get(am, 2)
                },
                3
            )
        end
        __L1:sky(
            c,
            s,
            t,
            camL,
            {
                sb = 116,
                sa = 70,
                mb = 110,
                ma = 64,
                amb = am
            }
        )
        local day = 1 - s.night
        local far2 = pre(
            nil,
            __L1:mix(
                s.bot,
                __arrL({0.2 + 0.1 * day, 0.26 + 0.12 * day, 0.4 + 0.12 * day}, 3),
                0.62
            )
        )
        do
            local i = 0
            while i < 40 do
                local bw = 14 + math.floor(__L1:hash(i + 50) * 18 + 0.5)
                local bh = 16 + math.floor(__L1:hash(i + 60) * 40 + 0.5)
                local x = math.floor(i * 22 - 60 - __mod(camL * 0.3, 22) * 0 + 0.5)
                local xx = __mod(
                    __mod(x - camL * 0.3, 860) + 860,
                    860
                ) - 60
                __L1:R(
                    c,
                    xx,
                    124 - bh,
                    bw,
                    bh,
                    __L1:css(far2)
                )
                do
                    local wy = 3
                    while wy < bh - 3 do
                        do
                            local wx2 = 2
                            while wx2 < bw - 2 do
                                if __t(__L1:hash(i * 31 + wx2 * 7 + wy) > 0.55 and __gt(s.night, 0.3)) then
                                    __L1:R(
                                        c,
                                        xx + wx2,
                                        124 - bh + wy,
                                        2,
                                        2,
                                        ("rgba(255,220,130," .. tostring(__L1:cl((s.night - 0.3) * 2))) .. ")"
                                    )
                                end
                                wx2 = wx2 + 4
                            end
                        end
                        wy = wy + 5
                    end
                end
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 16 do
                local xx = __mod(
                    __mod(i * 57 - camL * 0.45, 900) + 900,
                    900
                ) - 40
                local g2 = pre(
                    nil,
                    __arrL({0.2 + 0.12 * day, 0.36 + 0.2 * day, 0.22 + 0.1 * day}, 3)
                )
                __L1:ell(
                    c,
                    xx + math.sin(t * 1.2 + i) * 1.2,
                    112,
                    13,
                    12,
                    __L1:css(g2)
                )
                __L1:ell(
                    c,
                    xx + 9,
                    117,
                    9,
                    8,
                    __L1:css(__arrL(
                        {
                            __get(g2, 0) * 0.8,
                            __get(g2, 1) * 0.8,
                            __get(g2, 2) * 0.8
                        },
                        3
                    ))
                )
                i = i + 1
            end
        end
        c:drawImage(
            __get(__L1.mids, 2),
            camL,
            0,
            __L1.LW,
            __L1.LH,
            0,
            0,
            __L1.LW,
            __L1.LH
        )
        do
            local i = 0
            while 173 + i * 395 < __L1:worldW(2) do
                do
                    local x = 173 + i * 395 - camL
                    if __t(x < -30 or x > __L1.LW + 30) then
                        do i = i + 1 continue end
                    end
                    __L1:R(
                        c,
                        x,
                        17,
                        2,
                        38,
                        "#314644"
                    )
                    __L1:R(
                        c,
                        x - 3,
                        55,
                        8,
                        3,
                        "#55656e"
                    )
                    local a = math.floor(math.abs(math.cos(t * 9 + i)) * 20 + 0.5) + 2
                    local b = math.floor(math.abs(math.cos(t * 9 + i + 1.05)) * 20 + 0.5) + 2
                    __L1:R(
                        c,
                        x - a,
                        56,
                        a * 2 + 2,
                        1,
                        "#a8b6a0"
                    )
                    __L1:R(
                        c,
                        x - b,
                        57,
                        b * 2 + 2,
                        1,
                        "#7f8f7c"
                    )
                end
                i = i + 1
            end
        end
        do
            local i = 0
            while 225 + i * 395 < __L1:worldW(2) do
                do
                    local x = 225 + i * 395 - camL
                    if __t(x < -30 or x > __L1.LW + 30) then
                        do i = i + 1 continue end
                    end
                    local sw = math.floor(math.sin(t * 1.5 + i) * 1.5 + 0.5)
                    do
                        local y = 18
                        while y < 141 do
                            __L1:R(
                                c,
                                x + 9 + math.floor(sw * (y - 18) / 123 + 0.5),
                                y,
                                1,
                                1,
                                "#a6a18a"
                            )
                            y = y + 2
                        end
                    end
                    __L1:R(
                        c,
                        x + sw,
                        140,
                        20,
                        50,
                        "#2c2422"
                    )
                    __L1:R(
                        c,
                        x + 1 + sw,
                        141,
                        18,
                        48,
                        "#a95f48"
                    )
                    __L1:R(
                        c,
                        x + 3 + sw,
                        144,
                        3,
                        40,
                        "#c37a55"
                    )
                    __L1:R(
                        c,
                        x + 15 + sw,
                        141,
                        4,
                        48,
                        "#874a38"
                    )
                    __L1:R(
                        c,
                        x + 1 + sw,
                        150,
                        18,
                        3,
                        "#7c493b"
                    )
                    __L1:R(
                        c,
                        x + 1 + sw,
                        176,
                        18,
                        3,
                        "#7c493b"
                    )
                    __L1:R(
                        c,
                        x + 4 + sw,
                        187,
                        12,
                        2,
                        "#2a3c35"
                    )
                    c.fillStyle = "rgba(0,0,0,.22)"
                    c:fillRect(
                        math.floor(x + 1 + 0.5),
                        __L1.FLOOR - 1,
                        18,
                        2
                    )
                end
                i = i + 1
            end
        end
    end
    __L1.gymText = function(self, c, camera)
        c:save()
        c:translate(
            -math.floor(camera + 0.5),
            0
        )
        c.font = "16px Pixel, monospace"
        c.textAlign = "center"
        c.textBaseline = "middle"
        c.fillStyle = "#e6cc8d"
        c:fillText("CALEB · SEM DESCULPA", 894, 318)
        local W = __L1:worldW(2)
        c.fillStyle = "#c0c99a"
        do
            local x = 1340
            local i = 0
            while x < W do
                do
                    if __t(x * 2 < camera - 300 or __gt(x * 2, camera + 1260)) then
                        do do x = x + 175 i = i + 1 end continue end
                    end
                    c:fillText(
                        __get(
                            __arrL({"FORÇA DA ROÇA", "UMA REPETIÇÃO A MAIS", "FOCO NO BOLO"}, 3),
                            __mod(i, 3)
                        ),
                        (x + 64) * 2,
                        291
                    )
                end
                do
                    x = x + 175
                    i = i + 1
                end
            end
        end
        c:restore()
    end
    __L1.gquad = function(self, g, pts, col)
        g.fillStyle = col
        g:beginPath()
        g:moveTo(
            __get(
                __get(pts, 0),
                0
            ),
            __get(
                __get(pts, 0),
                1
            )
        )
        do
            local i = 1
            while i < 4 do
                g:lineTo(
                    __get(
                        __get(pts, i),
                        0
                    ),
                    __get(
                        __get(pts, i),
                        1
                    )
                )
                i = i + 1
            end
        end
        g:closePath()
        __call(g, "fill")
    end
    __L1.gymLights = function(self, g, s, t, camL)
        local sun = __L1:sunInfo(s)
        local ____temp_119
        if s.sunT ~= nil then
            ____temp_119 = s.sun
        else
            ____temp_119 = __arrL({0.6, 0.7, 1}, 3)
        end
        local col = ____temp_119
        local lean = sun.lean
        local W = __L1:worldW(2)
        do
            local i = math.floor((camL - 200) / __L1.GW.step)
            while __L1.GW.x0 + i * __L1.GW.step - camL < __L1.LW + 200 do
                do
                    if __t(i < 0 or __L1.GW.x0 + i * __L1.GW.step > W) then
                        do i = i + 1 continue end
                    end
                    local wx = __L1.GW.x0 + i * __L1.GW.step - camL
                    if sun.str > 0.03 then
                        local sl = __L1:gymSlats(i)
                        local gaps = __call(
                            sl,
                            "map",
                            function(____, y) return __arrL({y + 3, 2}, 2) end
                        )
                        local open = __L1:gymOpen(i)
                        if __t(open) then
                            __call(
                                gaps,
                                "push",
                                __arrL({__L1.GW.y + __L1.GW.h - open + 2, open - 2}, 2)
                            )
                        end
                        __call(
                            gaps,
                            "forEach",
                            function(____, ____bindingPattern0, n)
                                local gh
                                local gy
                                gy = ____bindingPattern0[1]
                                gh = ____bindingPattern0[2]
                                local depth = (__L1.GW.y + __L1.GW.h - gy) / __L1.GW.h
                                local fy = __L1.FLOOR + 2 + depth * 44
                                local fh = math.max(2, gh * 0.5)
                                local sh = lean * (10 + depth * 46)
                                __L1:gquad(
                                    g,
                                    __arrL(
                                        {
                                            __arrL({wx + sh, fy}, 2),
                                            __arrL({wx + __L1.GW.w + sh, fy}, 2),
                                            __arrL({wx + __L1.GW.w + sh + lean * fh, fy + fh}, 2),
                                            __arrL({wx + sh + lean * fh, fy + fh}, 2)
                                        },
                                        4
                                    ),
                                    __L1:css(col, 0.3 * sun.str)
                                )
                                if n == 0 then
                                    __L1:patchAdd(wx + lean * 10, wx + __L1.GW.w + lean * 56, lean * 1.1, 0.6 * sun.str)
                                end
                                if __t(__mod(n, 2) == 0 or gh > 2) then
                                    __L1:gquad(
                                        g,
                                        __arrL(
                                            {
                                                __arrL({wx, gy}, 2),
                                                __arrL({wx + __L1.GW.w, gy}, 2),
                                                __arrL({wx + __L1.GW.w + sh, fy}, 2),
                                                __arrL({wx + sh, fy}, 2)
                                            },
                                            4
                                        ),
                                        __L1:css(col, (gh > 2 and 0.07 or 0.028) * sun.str)
                                    )
                                end
                            end
                        )
                        do
                            local k = 0
                            while k < 7 do
                                local u = __mod(
                                    t * 0.1 + __L1:hash(k + i * 9),
                                    1
                                )
                                local px = wx + __L1:hash(k * 3 + i) * __L1.GW.w + lean * 30 * u
                                local py = __L1.GW.y + u * (__L1.FLOOR - __L1.GW.y)
                                g.fillStyle = __L1:css(
                                    col,
                                    0.55 * sun.str * (0.5 + 0.5 * math.sin(t * 3 + k + i))
                                )
                                g:fillRect(
                                    math.floor(px + 0.5),
                                    math.floor(py + 0.5),
                                    1,
                                    1
                                )
                                k = k + 1
                            end
                        end
                    end
                    local lx = wx + 114
                    local a = 0.32 + s.night * 0.5
                    local _l = __L1:lightAdd(lx, 44, a * 1.1, 52)
                    local gr = g:createLinearGradient(0, 44, 0, __L1.LH)
                    gr:addColorStop(
                        0,
                        ("rgba(255,214,140," .. tostring(0.24 * a)) .. ")"
                    )
                    gr:addColorStop(
                        1,
                        ("rgba(255,214,140," .. tostring(0.03 * a)) .. ")"
                    )
                    g.fillStyle = gr
                    g:beginPath()
                    g:moveTo(lx - 10, 44)
                    g:lineTo(lx + 11, 44)
                    g:lineTo(lx + 52, __L1.LH)
                    g:lineTo(lx - 51, __L1.LH)
                    g:closePath()
                    __call(g, "fill")
                    local bl = g:createRadialGradient(
                        lx,
                        44,
                        1,
                        lx,
                        46,
                        26
                    )
                    bl:addColorStop(
                        0,
                        ("rgba(255,226,160," .. tostring(0.7 * a)) .. ")"
                    )
                    bl:addColorStop(1, "rgba(255,226,160,0)")
                    g.fillStyle = bl
                    g:fillRect(lx - 28, 18, 56, 56)
                    g:save()
                    g:translate(lx, __L1.FLOOR + 14)
                    g:scale(1, 0.28)
                    local pl = g:createRadialGradient(
                        0,
                        0,
                        0,
                        0,
                        0,
                        54
                    )
                    pl:addColorStop(
                        0,
                        ("rgba(255,214,140," .. tostring(0.3 * a)) .. ")"
                    )
                    pl:addColorStop(1, "rgba(255,214,140,0)")
                    g.fillStyle = pl
                    g:fillRect(-54, -54, 108, 108)
                    g:restore()
                end
                i = i + 1
            end
        end
    end
    __L1.city = function(self, seed, baseY)
        local key = __add(
            __add(seed, ":"),
            baseY
        )
        if __t(__get(__L1.cities, key)) then
            return __get(__L1.cities, key)
        end
        local D = __L1:mk(__L1.TILE, 196)
        local L = __L1:mk(__L1.TILE, 196)
        local COL = __arrL({"#8fa5b5", "#7d94a8", "#9ab0bd", "#8799ad"}, 4)
        local x = 0
        local i = 0
        while x < __L1.TILE - 8 do
            local bw = 12 + math.floor(__L1:hash(i + seed) * 20 + 0.5)
            local bh = 18 + math.floor(__L1:hash(i + seed + 40) * 52 + 0.5)
            local w = math.min(bw, __L1.TILE - x)
            local y = baseY - bh
            local col = __get(
                COL,
                __mod(i, 4)
            )
            __L1:R(
                __get(D, 1),
                x,
                y,
                w,
                196 - y,
                col
            )
            __L1:R(
                __get(D, 1),
                x,
                y,
                1,
                bh,
                "rgba(255,255,255,.22)"
            )
            __L1:R(
                __get(D, 1),
                x + w - 2,
                y,
                2,
                bh,
                "rgba(20,40,70,.22)"
            )
            __L1:R(
                __get(D, 1),
                x,
                y,
                w,
                1,
                "rgba(255,255,255,.3)"
            )
            if __L1:hash(i + seed + 80) > 0.6 then
                __L1:R(
                    __get(D, 1),
                    x + 3,
                    y - 4,
                    5,
                    4,
                    "#6f8597"
                )
                __L1:R(
                    __get(D, 1),
                    x + 3,
                    y - 4,
                    5,
                    1,
                    "#a9bcc8"
                )
            end
            if __L1:hash(i + seed + 90) > 0.7 then
                __L1:R(
                    __get(D, 1),
                    x + w - 5,
                    y - 7,
                    1,
                    7,
                    "#5f7587"
                )
            end
            do
                local wy = 3
                while wy < bh - 3 do
                    do
                        local wx = 2
                        while wx < w - 3 do
                            __L1:R(
                                __get(D, 1),
                                x + wx,
                                y + wy,
                                2,
                                3,
                                "rgba(40,70,100,.42)"
                            )
                            if __L1:hash(i * 31 + wx * 7 + wy + seed) > 0.6 then
                                __L1:R(
                                    __get(L, 1),
                                    x + wx,
                                    y + wy,
                                    2,
                                    3,
                                    __L1:hash(wx + wy + i) > 0.5 and "#ffd98a" or "#ffeebc"
                                )
                            end
                            wx = wx + 4
                        end
                    end
                    wy = wy + 5
                end
            end
            x = x + (w + (__L1:hash(i + seed + 120) > 0.7 and 3 or 0))
            i = i + 1
        end
        do
            local xx = 0
            while xx < __L1.TILE do
                do
                    local yy = baseY - 10
                    while yy < 196 do
                        if __band(xx + yy, 3) == 0 then
                            __L1:R(
                                __get(D, 1),
                                xx,
                                yy,
                                1,
                                1,
                                "rgba(200,225,230,.35)"
                            )
                        end
                        yy = yy + 2
                    end
                end
                xx = xx + 1
            end
        end
        return __set(
            __L1.cities,
            key,
            __arrL(
                {
                    __get(D, 0),
                    __get(L, 0)
                },
                2
            )
        )
    end
    __L1.floodlight = function(self, c, x, top, lamps)
        __L1:R(
            c,
            x,
            top,
            4,
            220 - top,
            "#4b6260"
        )
        __L1:R(
            c,
            x,
            top,
            1,
            220 - top,
            "#7a918c"
        )
        __L1:R(
            c,
            x + 3,
            top,
            1,
            220 - top,
            "#33474a"
        )
        local w = lamps * 6 + 4
        __L1:R(
            c,
            x + 2 - w / 2 - 1,
            top - 9,
            w + 2,
            10,
            "#27383a"
        )
        __L1:R(
            c,
            x + 2 - w / 2,
            top - 8,
            w,
            8,
            "#3e5354"
        )
        do
            local k = 0
            while __lt(k, lamps) do
                __L1:R(
                    c,
                    x + 4 - w / 2 + k * 6,
                    top - 7,
                    5,
                    5,
                    "#e9d8a2"
                )
                __L1:R(
                    c,
                    x + 4 - w / 2 + k * 6,
                    top - 7,
                    5,
                    1,
                    "#fff6d0"
                )
                k = k + 1
            end
        end
        do
            local y = top + 14
            while __lt(y, 214) do
                __L1:R(
                    c,
                    x - 1,
                    y,
                    6,
                    1,
                    "#33474a"
                )
                y = y + 22
            end
        end
    end
    __L1.floodBeam = function(self, g, x, top, a, reach)
        if __lt(a, 0.02) then
            return
        end
        __L1:lightAdd(x + 2, top - 4, a, reach)
        local gr = g:createLinearGradient(0, top, 0, 262)
        gr:addColorStop(
            0,
            ("rgba(235,240,255," .. tostring(0.34 * a)) .. ")"
        )
        gr:addColorStop(
            1,
            ("rgba(235,240,255," .. tostring(0.04 * a)) .. ")"
        )
        g.fillStyle = gr
        g:beginPath()
        g:moveTo(x - 8, top - 4)
        g:lineTo(x + 12, top - 4)
        g:lineTo(
            __add(x, reach),
            262
        )
        g:lineTo(x - reach + 4, 262)
        g:closePath()
        __call(g, "fill")
        local b = g:createRadialGradient(
            x + 2,
            top - 4,
            1,
            x + 2,
            top - 4,
            30
        )
        b:addColorStop(
            0,
            ("rgba(255,250,225," .. tostring(0.9 * a)) .. ")"
        )
        b:addColorStop(1, "rgba(255,250,225,0)")
        g.fillStyle = b
        g:fillRect(x - 30, top - 36, 64, 64)
        g:save()
        g:translate(x + 2, 232)
        g:scale(1, 0.3)
        local p = g:createRadialGradient(
            0,
            0,
            0,
            0,
            0,
            reach
        )
        p:addColorStop(
            0,
            ("rgba(235,240,255," .. tostring(0.3 * a)) .. ")"
        )
        p:addColorStop(1, "rgba(235,240,255,0)")
        g.fillStyle = p
        g:fillRect(
            __TS__Number(-reach),
            __TS__Number(-reach),
            reach * 2,
            reach * 2
        )
        g:restore()
    end
    __L1.board = function(self, c, x, y, w, h, col, edge)
        __L1:R(
            c,
            x - 1,
            y - 1,
            w + 2,
            h + 2,
            edge
        )
        __L1:R(
            c,
            x,
            y,
            w,
            h,
            col
        )
        __L1:R(
            c,
            x,
            y,
            w,
            1,
            "rgba(255,255,255,.2)"
        )
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({x + 1, y + 1}, 2),
                __arrL(
                    {
                        __add(x, w) - 2,
                        y + 1
                    },
                    2
                ),
                __arrL(
                    {
                        x + 1,
                        __add(y, h) - 2
                    },
                    2
                ),
                __arrL(
                    {
                        __add(x, w) - 2,
                        __add(y, h) - 2
                    },
                    2
                )
            },
            4
        ))) do
            local bx = ____value[1]
            local by = ____value[2]
            __L1:R(
                c,
                bx,
                by,
                1,
                1,
                "#d9cc9e"
            )
        end
    end
    __L1.backdrop = function(self, c, s, t, camL, cityKey)
        if not __t(__L1.far) then
            __L1.far = __L1:buildFar()
        end
        local sun = __L1:sunInfo(s)
        local la = math.min(
            1,
            math.abs(sun.lean) * 1.3
        ) * sun.str
        local rel = __get(__L1.far, sun.lean >= 0 and 3 or 4)
        __L1:sky(c, s, t, camL)
        __L1:tile(
            c,
            __get(__L1.far, 0),
            camL * 0.04,
            0.04
        )
        if la > 0.03 then
            c.globalAlpha = la
            __L1:tile(
                c,
                __get(rel, 0),
                camL * 0.04,
                0.04
            )
            c.globalAlpha = 1
        end
        __L1:tile(
            c,
            __get(__L1.far, 1),
            camL * 0.1 + 300,
            0.1
        )
        if la > 0.03 then
            c.globalAlpha = la
            __L1:tile(
                c,
                __get(rel, 1),
                camL * 0.1 + 300,
                0.1
            )
            c.globalAlpha = 1
        end
        __L1:haze(
            c,
            s,
            t,
            camL,
            110,
            190
        )
        __L1:tile(
            c,
            __get(
                __L1:city(
                    __get(cityKey, 0),
                    __get(cityKey, 1)
                ),
                0
            ),
            camL * 0.07,
            0.07
        )
        return sun
    end
    __L1.buildCourtMid = function(self)
        local W = __L1:worldW(3)
        local cv, c = table.unpack(
            __L1:mk(W, __L1.LH),
            1,
            2
        )
        __L1:R(
            c,
            0,
            168,
            W,
            12,
            "#6f9a5a"
        )
        __L1:R(
            c,
            0,
            168,
            W,
            1,
            "#9cc878"
        )
        do
            local i = 0
            while i < W / 2 do
                __L1:R(
                    c,
                    __L1:hash(i + 3) * W,
                    169 + __L1:hash(i + 4) * 10,
                    2,
                    1,
                    __t(__mod(i, 2)) and "#5f8a4c" or "#86b56a"
                )
                i = i + 1
            end
        end
        __L1:R(
            c,
            0,
            180,
            W,
            10,
            "#9aa89a"
        )
        __L1:R(
            c,
            0,
            180,
            W,
            1,
            "#c3cdc0"
        )
        do
            local x = 0
            while x < W do
                __L1:R(
                    c,
                    x,
                    181,
                    1,
                    9,
                    "#7f8f82"
                )
                x = x + 24
            end
        end
        __L1:R(
            c,
            0,
            190,
            W,
            30,
            "#a6795b"
        )
        __L1:R(
            c,
            0,
            190,
            W,
            1,
            "#c39a7a"
        )
        do
            local i = 0
            while i < W * 1.5 do
                __L1:R(
                    c,
                    __L1:hash(i + 13) * W,
                    191 + __L1:hash(i + 14) * 28,
                    1 + __L1:hash(i) * 2,
                    1,
                    __t(__mod(i, 3)) and "#96694d" or "#b88a6a"
                )
                i = i + 1
            end
        end
        __L1:R(
            c,
            620,
            191,
            320,
            28,
            "#3f8a6a"
        )
        do
            local i = 0
            while i < 500 do
                __L1:R(
                    c,
                    620 + __L1:hash(i + 23) * 320,
                    192 + __L1:hash(i + 24) * 26,
                    2,
                    1,
                    __t(__mod(i, 2)) and "#35785c" or "#4c9a78"
                )
                i = i + 1
            end
        end
        __L1:R(
            c,
            700,
            191,
            160,
            28,
            "#b8644a"
        )
        do
            local i = 0
            while i < 260 do
                __L1:R(
                    c,
                    700 + __L1:hash(i + 33) * 160,
                    192 + __L1:hash(i + 34) * 26,
                    2,
                    1,
                    __t(__mod(i, 2)) and "#a45640" or "#c87860"
                )
                i = i + 1
            end
        end
        __L1:R(
            c,
            620,
            191,
            320,
            1,
            "#f1ead0"
        )
        __L1:R(
            c,
            620,
            218,
            320,
            1,
            "#f1ead0"
        )
        __L1:R(
            c,
            620,
            191,
            1,
            28,
            "#f1ead0"
        )
        __L1:R(
            c,
            939,
            191,
            1,
            28,
            "#f1ead0"
        )
        __L1:R(
            c,
            779,
            191,
            2,
            28,
            "#f1ead0"
        )
        do
            local k = -14
            while k <= 14 do
                local w = math.floor(math.sqrt(196 - k * k) * 1.9 + 0.5)
                __L1:R(
                    c,
                    780 - w,
                    205 + math.floor(k * 0.5 + 0.5),
                    1,
                    1,
                    "#f1ead0"
                )
                __L1:R(
                    c,
                    780 + w,
                    205 + math.floor(k * 0.5 + 0.5),
                    1,
                    1,
                    "#f1ead0"
                )
                k = k + 1
            end
        end
        __L1:R(
            c,
            0,
            218,
            W,
            2,
            "#d6c29a"
        )
        __L1:R(
            c,
            0,
            __L1.FLOOR,
            W,
            50,
            "#97856e"
        )
        __L1:R(
            c,
            0,
            240,
            W,
            30,
            "#8a7862"
        )
        __L1:dither(
            c,
            0,
            239,
            W,
            "#8a7862"
        )
        do
            local x = 0
            while x < W do
                __L1:R(
                    c,
                    x,
                    225,
                    1,
                    45,
                    "#7a6a56"
                )
                __L1:R(
                    c,
                    x + 1,
                    225,
                    1,
                    45,
                    "#a8977b"
                )
                x = x + 40
            end
        end
        __L1:R(
            c,
            0,
            247,
            W,
            1,
            "#7a6a56"
        )
        __L1:R(
            c,
            0,
            248,
            W,
            1,
            "#a8977b"
        )
        do
            local i = 0
            while i < W * 1.5 do
                __L1:R(
                    c,
                    __L1:hash(i + 43) * W,
                    226 + __L1:hash(i + 44) * 43,
                    1 + __L1:hash(i) * 2,
                    1,
                    __t(__mod(i, 3)) and "#86745e" or "#ab9a80"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < W / 50 do
                local x = __L1:hash(i + 53) * W
                local y = 226 + __L1:hash(i + 54) * 20
                do
                    local k = 0
                    while k < 8 + __L1:hash(i) * 10 do
                        __L1:R(
                            c,
                            x,
                            y,
                            1,
                            1,
                            "#5f5242"
                        )
                        x = x + (__L1:hash(i * 5 + k) > 0.4 and 1 or -1)
                        y = y + (__L1:hash(i * 3 + k) > 0.5 and 1 or 0)
                        k = k + 1
                    end
                end
                i = i + 1
            end
        end
        __L1:R(
            c,
            0,
            __L1.FLOOR,
            W,
            3,
            "#c4b08a"
        )
        __L1:R(
            c,
            0,
            __L1.FLOOR,
            W,
            1,
            "#e6d6b0"
        )
        __L1:R(
            c,
            0,
            __L1.FLOOR + 3,
            W,
            2,
            "#655c4d"
        )
        do
            local i = 0
            while i < W / 30 do
                local x = __L1:hash(i + 63) * W
                __L1:R(
                    c,
                    x,
                    __L1.FLOOR - 2,
                    1,
                    2,
                    "#5f9a4a"
                )
                __L1:R(
                    c,
                    x + 1,
                    __L1.FLOOR - 3,
                    1,
                    3,
                    "#7ab85a"
                )
                __L1:R(
                    c,
                    x + 2,
                    __L1.FLOOR - 1,
                    1,
                    1,
                    "#5f9a4a"
                )
                i = i + 1
            end
        end
        c.fillStyle = "rgba(132,151,134,.55)"
        do
            local y = 122
            while y < 196 do
                do
                    local x = __mod(y, 8)
                    while x < W do
                        c:fillRect(x, y, 1, 1)
                        c:fillRect(
                            __mod(
                                x + 8 - __mod(y * 2, 8),
                                W
                            ),
                            y,
                            1,
                            1
                        )
                        x = x + 8
                    end
                end
                y = y + 1
            end
        end
        __L1:R(
            c,
            0,
            120,
            W,
            2,
            "#657e71"
        )
        __L1:R(
            c,
            0,
            120,
            W,
            1,
            "#93a898"
        )
        __L1:R(
            c,
            0,
            195,
            W,
            2,
            "#557169"
        )
        do
            local x = 0
            while x < W do
                __L1:R(
                    c,
                    x,
                    120,
                    3,
                    77,
                    "#597a70"
                )
                __L1:R(
                    c,
                    x,
                    120,
                    1,
                    77,
                    "#99a48a"
                )
                __L1:R(
                    c,
                    x - 1,
                    118,
                    5,
                    2,
                    "#3f5a52"
                )
                x = x + 32.5
            end
        end
        for ____, x in __iterar((__L1.COURT_HOOPS)) do
            __L1:R(
                c,
                x,
                115,
                5,
                104,
                "#425e58"
            )
            __L1:R(
                c,
                x,
                115,
                1,
                104,
                "#6f8a82"
            )
            __L1:R(
                c,
                x - 4,
                114,
                13,
                4,
                "#d8cba9"
            )
            __L1:R(
                c,
                x - 32,
                107,
                39,
                28,
                "#3a4a48"
            )
            __L1:R(
                c,
                x - 31,
                108,
                37,
                26,
                "#d3d2b8"
            )
            __L1:R(
                c,
                x - 29,
                110,
                33,
                22,
                "#849e91"
            )
            __L1:R(
                c,
                x - 20,
                116,
                15,
                12,
                "#dae0bf"
            )
            __L1:R(
                c,
                x - 18,
                118,
                11,
                8,
                "#98afa0"
            )
            __L1:R(
                c,
                x - 16,
                130,
                19,
                3,
                "#c16f4e"
            )
            __L1:R(
                c,
                x - 16,
                130,
                19,
                1,
                "#e8936a"
            )
            do
                local k = 0
                while k < 6 do
                    __L1:R(
                        c,
                        x - 15 + k * 3.4,
                        133,
                        1,
                        9 - math.abs(k - 2.5),
                        "#e3e6d2"
                    )
                    k = k + 1
                end
            end
            do
                local k = 0
                while k < 3 do
                    __L1:R(
                        c,
                        x - 14 + k,
                        135 + k * 3,
                        15 - k * 2,
                        1,
                        "#c3c7ac"
                    )
                    k = k + 1
                end
            end
        end
        for ____, ____value in __iterar((__L1.COURT_FLOODS)) do
            local x = ____value[1]
            local top = ____value[2]
            local n = ____value[3]
            __L1:floodlight(c, x, top, n)
        end
        local function bleach(____, x, y, w, rows, gap)
            do
                local i = 0
                while __lt(i, rows) do
                    local xx = x - i * gap
                    local yy = y + i * 10
                    local ww = w + i * gap * 2
                    __L1:R(
                        c,
                        xx,
                        yy,
                        ww,
                        5,
                        "#a68c74"
                    )
                    __L1:R(
                        c,
                        xx,
                        yy,
                        ww,
                        1,
                        "#cbb294"
                    )
                    __L1:R(
                        c,
                        xx,
                        yy + 4,
                        ww,
                        1,
                        "#7a6450"
                    )
                    do
                        local k = 8
                        while __lt(k, ww) do
                            __L1:R(
                                c,
                                xx + k,
                                yy + 1,
                                1,
                                3,
                                "#8f7660"
                            )
                            k = k + 14
                        end
                    end
                    __L1:R(
                        c,
                        xx + 4,
                        yy + 5,
                        3,
                        219 - yy - 5,
                        "#4c675c"
                    )
                    __L1:R(
                        c,
                        xx + ww - 7,
                        yy + 5,
                        3,
                        219 - yy - 5,
                        "#4c675c"
                    )
                    i = i + 1
                end
            end
        end
        bleach(
            nil,
            380,
            181,
            135,
            3,
            12
        )
        do
            local x = 1350
            while x < W do
                bleach(
                    nil,
                    x + 32,
                    180,
                    95,
                    3,
                    4.5
                )
                __L1:R(
                    c,
                    x + 38,
                    173,
                    71,
                    1,
                    "#78966f"
                )
                x = x + 210
            end
        end
        for ____, x in __iterar((__arrL({300, 980, 1650, 2250}, 4))) do
            if x > W then
                break
            end
            __L1:R(
                c,
                x,
                205,
                10,
                14,
                "#3f8a52"
            )
            __L1:R(
                c,
                x - 1,
                203,
                12,
                3,
                "#57a86a"
            )
            __L1:R(
                c,
                x + 3,
                209,
                4,
                4,
                "#e9f2e0"
            )
        end
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({395, "#c9574a"}, 2),
                __arrL({430, "#3a6a9a"}, 2),
                __arrL({505, "#e8c23a"}, 2)
            },
            3
        ))) do
            local x = ____value[1]
            local col = ____value[2]
            __L1:R(
                c,
                x,
                175,
                7,
                6,
                col
            )
            __L1:R(
                c,
                x + 1,
                174,
                5,
                1,
                col
            )
            __L1:R(
                c,
                x + 2,
                177,
                3,
                2,
                "rgba(255,255,255,.35)"
            )
        end
        __L1:board(
            c,
            1929,
            122,
            170,
            19,
            "#4d7263",
            "#2c4a40"
        )
        __L1:R(
            c,
            1960,
            141,
            3,
            78,
            "#425e58"
        )
        __L1:R(
            c,
            2066,
            141,
            3,
            78,
            "#425e58"
        )
        return cv
    end
    __L1.court = function(self, c, s, t, camL)
        if not __t(__get(__L1.mids, 3)) then
            __set(
                __L1.mids,
                3,
                __L1:buildCourtMid()
            )
        end
        local sun = __L1:backdrop(
            c,
            s,
            t,
            camL,
            __arrL({7, 150}, 2)
        )
        __L1:tile(
            c,
            __get(__L1.far, 2),
            camL * 0.22 + 500,
            0.22
        )
        c:drawImage(
            __get(__L1.mids, 3),
            camL,
            0,
            __L1.LW,
            __L1.LH,
            0,
            0,
            __L1.LW,
            __L1.LH
        )
        if sun.str > 0.04 then
            local sh = ("rgba(18,30,52," .. tostring(0.28 * sun.str)) .. ")"
            local reach = sun.lean * (14 + math.abs(sun.lean) * 26)
            do
                local x = math.floor(camL / 32.5) * 32.5 - 65
                while __lt(x, camL + __L1.LW + 65) do
                    __L1:slant(
                        c,
                        x - camL,
                        x - camL + 2,
                        197,
                        reach * 1.6,
                        12,
                        ("rgba(18,30,52," .. tostring(0.12 * sun.str)) .. ")"
                    )
                    x = x + 32.5
                end
            end
            for ____, x in __iterar((__L1.COURT_HOOPS)) do
                __L1:slant(
                    c,
                    x - camL,
                    x - camL + 5,
                    219,
                    reach,
                    4,
                    sh
                )
                __L1:slant(
                    c,
                    x - camL - 30 + reach * 3,
                    x - camL + 6 + reach * 3,
                    221,
                    reach * 0.3,
                    3,
                    sh
                )
            end
            for ____, ____value in __iterar((__L1.COURT_FLOODS)) do
                local x = ____value[1]
                __L1:slant(
                    c,
                    x - camL,
                    x - camL + 4,
                    219,
                    reach * 1.4,
                    5,
                    sh
                )
            end
            do
                local x = 356 - camL
                if __t(x > -260 and x < __L1.LW + 100) then
                    __L1:slant(
                        c,
                        x,
                        x + 183,
                        219,
                        reach * 1.2,
                        4,
                        sh
                    )
                    __L1:shadeAdd(x + reach * 1.2, x + 183 + reach * 1.2, 0.75)
                end
            end
            do
                local x = 1265 - camL
                if __t(x > -90 and x < __L1.LW + 90) then
                    local cx = x + reach * 1.2
                    __L1:ell(
                        c,
                        cx,
                        221,
                        18,
                        2.5,
                        sh
                    )
                    __L1:shadeAdd(cx - 18, cx + 18, 0.9, true)
                end
            end
        end
        do
            local x = 1265 - camL
            if __t(x > -70 and x < __L1.LW + 70) then
                local ____L1_tree_123 = __L1.tree
                local ____c_121 = c
                local ____t_122 = t
                local ____temp_120
                if sun.lean >= 0 then
                    ____temp_120 = math.max(0.35, sun.lean)
                else
                    ____temp_120 = math.min(-0.35, sun.lean)
                end
                ____L1_tree_123(
                    __L1,
                    ____c_121,
                    x,
                    218,
                    0.8,
                    0,
                    ____t_122,
                    1265,
                    ____temp_120
                )
            end
        end
        do
            local x = 55 - camL
            if x > -60 then
                __L1:bush(c, x, 50)
            end
        end
        do
            local x0 = 545 - camL
            if __t(x0 < __L1.LW and x0 + 485 > 0) then
                __L1:R(
                    c,
                    x0,
                    99,
                    485,
                    1,
                    "#586e65"
                )
                do
                    local i = 0
                    while i < 20 do
                        local x = x0 + 5 + i * 23.5
                        local wv = math.floor(math.sin(t * 2 + i) * 1.2 + 0.5)
                        do
                            local k = 0
                            while k < 11 do
                                __L1:R(
                                    c,
                                    x + k * 0.5 + wv * (k / 11),
                                    100 + k,
                                    12 - k,
                                    1,
                                    __mod(i, 3) == 0 and "#b87d59" or (__mod(i, 3) == 1 and "#879c81" or "#e8c86a")
                                )
                                k = k + 1
                            end
                        end
                        i = i + 1
                    end
                end
            end
        end
        do
            local bx = 587 + math.sin(t * 0.65) * 15 - camL
            local by = 214 - math.abs(math.sin(t * 2.8)) * 19
            __L1:ell(
                c,
                bx,
                219,
                4,
                1,
                "rgba(0,0,0,.25)"
            )
            __L1:ell(
                c,
                bx,
                by,
                4.5,
                4.5,
                "#6f4f35"
            )
            __L1:ell(
                c,
                bx,
                by,
                3.5,
                3.5,
                "#e19d4e"
            )
            __L1:R(
                c,
                bx,
                by - 4,
                1,
                8,
                "#875b38"
            )
            __L1:R(
                c,
                bx - 3,
                by,
                7,
                1,
                "#875b38"
            )
            __L1:R(
                c,
                bx - 2,
                by - 2,
                1,
                1,
                "#ffd08a"
            )
        end
    end
    __L1.courtText = function(self, c, camera)
        c:save()
        c:translate(
            -math.floor(camera + 0.5),
            0
        )
        c.font = "16px Pixel, monospace"
        c.textAlign = "center"
        c.textBaseline = "middle"
        c.fillStyle = "#e2dab1"
        c:fillText("QUADRA · FINAL DO RECREIO", 4028, 264)
        c:restore()
    end
    __L1.courtLights = function(self, g, s, t, camL)
        if __le(s.night, 0.12) then
            return
        end
        local a = __L1:cl((s.night - 0.12) * 1.4)
        g:save()
        g:beginPath()
        g:rect(0, 0, __L1.LW, 144)
        g:clip()
        g.globalAlpha = a
        __L1:tile(
            g,
            __get(
                __L1:city(7, 150),
                1
            ),
            camL * 0.07,
            0.07
        )
        g:restore()
        for ____, ____value in __iterar((__L1.COURT_FLOODS)) do
            local x = ____value[1]
            local top = ____value[2]
            local n = ____value[3]
            do
                local sx = x - camL
                if __t(sx < -160 or sx > __L1.LW + 160) then
                    continue
                end
                __L1:floodBeam(
                    g,
                    sx,
                    top - 4,
                    a * (0.92 + 0.08 * math.sin(t * 30 + x)),
                    70 + n * 12
                )
            end
        end
    end
    __L1.buildFieldBack = function(self)
        local W = 1400
        local cv, c = table.unpack(
            __L1:mk(W, 196),
            1,
            2
        )
        local lv, l = table.unpack(
            __L1:mk(W, 196),
            1,
            2
        )
        __L1:R(
            c,
            0,
            86,
            W,
            110,
            "#e2ebeb"
        )
        do
            local i = 0
            while i < W do
                __L1:R(
                    c,
                    __L1:hash(i + 73) * W,
                    100 + __L1:hash(i + 74) * 60,
                    2,
                    1,
                    __t(__mod(i, 2)) and "#d3dfdf" or "#f0f6f4"
                )
                i = i + 1
            end
        end
        __L1:R(
            c,
            0,
            86,
            W,
            8,
            "#21496c"
        )
        __L1:R(
            c,
            0,
            86,
            W,
            1,
            "#3a6a94"
        )
        __L1:R(
            c,
            0,
            94,
            W,
            2,
            "#f7fbfa"
        )
        __L1:R(
            c,
            0,
            150,
            W,
            14,
            "#c9d6d6"
        )
        __L1:R(
            c,
            0,
            150,
            W,
            1,
            "#aebcbc"
        )
        do
            local x = 10
            local i = 0
            while x < W do
                __L1:R(
                    c,
                    x - 1,
                    105,
                    41,
                    32,
                    "#5f8591"
                )
                __L1:R(
                    c,
                    x,
                    106,
                    39,
                    30,
                    "#87acb7"
                )
                __L1:R(
                    c,
                    x + 2,
                    108,
                    35,
                    26,
                    "#b3d5d9"
                )
                __L1:R(
                    c,
                    x + 2,
                    108,
                    35,
                    9,
                    "#c9e4e6"
                )
                __L1:R(
                    c,
                    x + 18,
                    108,
                    2,
                    26,
                    "#ebf2e7"
                )
                __L1:R(
                    c,
                    x + 2,
                    120,
                    35,
                    1,
                    "#ebf2e7"
                )
                do
                    local k = 0
                    while k < 20 do
                        __L1:R(
                            c,
                            x + 5 + math.floor((20 - k) * 0.5 + 0.5),
                            110 + k,
                            3,
                            1,
                            "rgba(255,255,255,.3)"
                        )
                        k = k + 1
                    end
                end
                __L1:R(
                    c,
                    x - 3,
                    137,
                    45,
                    2,
                    "#f7fbfa"
                )
                __L1:R(
                    c,
                    x - 3,
                    139,
                    45,
                    1,
                    "#9fb0b0"
                )
                if __mod(i, 3) == 1 then
                    __L1:R(
                        c,
                        x + 42,
                        126,
                        10,
                        7,
                        "#cfd8dc"
                    )
                    __L1:R(
                        c,
                        x + 43,
                        128,
                        8,
                        1,
                        "#8fa1a6"
                    )
                    __L1:R(
                        c,
                        x + 43,
                        130,
                        8,
                        1,
                        "#8fa1a6"
                    )
                end
                if __L1:hash(i + 83) > 0.45 then
                    __L1:R(
                        l,
                        x + 2,
                        108,
                        35,
                        26,
                        "#ffe2a0"
                    )
                end
                do
                    x = x + 55
                    i = i + 1
                end
            end
        end
        do
            local x = 80
            while x < W do
                __L1:R(
                    c,
                    x,
                    70,
                    22,
                    16,
                    "#6f8597"
                )
                __L1:R(
                    c,
                    x,
                    70,
                    22,
                    1,
                    "#a9bcc8"
                )
                __L1:R(
                    c,
                    x + 3,
                    86 - 20,
                    2,
                    4,
                    "#5f7587"
                )
                __L1:R(
                    c,
                    x + 120,
                    76,
                    1,
                    10,
                    "#5f7587"
                )
                __L1:R(
                    c,
                    x + 117,
                    76,
                    7,
                    1,
                    "#5f7587"
                )
                x = x + 330
            end
        end
        return __arrL({cv, lv}, 2)
    end
    __L1.buildFieldMid = function(self)
        local W = __L1:worldW(7)
        local cv, c = table.unpack(
            __L1:mk(W, __L1.LH),
            1,
            2
        )
        do
            local x = 0
            while x < W do
                __L1:R(
                    c,
                    x,
                    163,
                    40,
                    57,
                    __t(__mod(x / 40, 2)) and "#438c4b" or "#4e9752"
                )
                x = x + 40
            end
        end
        do
            local i = 0
            while i < W * 2 do
                local x = __L1:hash(i + 93) * W
                local y = 164 + __L1:hash(i + 94) * 55
                __L1:R(
                    c,
                    x,
                    y,
                    1,
                    2,
                    __L1:hash(i) > 0.5 and "#3a7f43" or "#62ab5e"
                )
                i = i + 1
            end
        end
        __L1:R(
            c,
            0,
            163,
            W,
            1,
            "#7cc070"
        )
        __L1:R(
            c,
            0,
            170,
            W,
            2,
            "#dce9c8"
        )
        __L1:R(
            c,
            0,
            216,
            W,
            2,
            "#ecedd1"
        )
        do
            local x = 625
            while x < W do
                __L1:R(
                    c,
                    x,
                    172,
                    2,
                    44,
                    "#eff0d0"
                )
                do
                    local a = 0
                    while a < 200 do
                        local an = a / 200 * math.pi * 2
                        __L1:R(
                            c,
                            x + math.cos(an) * 43,
                            195 + math.sin(an) * 18,
                            1,
                            1,
                            "#dcebc9"
                        )
                        a = a + 1
                    end
                end
                __L1:R(
                    c,
                    x - 1,
                    194,
                    4,
                    3,
                    "#eff0d0"
                )
                x = x + 1050
            end
        end
        for ____, gx in __iterar((__L1.FIELD_GOALS)) do
            do
                local i = 0
                while i < 60 do
                    __L1:R(
                        c,
                        gx - 20 + __L1:hash(i + gx) * 130,
                        205 + __L1:hash(i + gx + 3) * 10,
                        3,
                        1,
                        "#6a8a4a"
                    )
                    i = i + 1
                end
            end
            __L1:R(
                c,
                gx - 9,
                217,
                108,
                1,
                "#e6efcf"
            )
        end
        __L1:R(
            c,
            0,
            __L1.FLOOR,
            W,
            50,
            "#448646"
        )
        __L1:R(
            c,
            0,
            234,
            W,
            36,
            "#6a5236"
        )
        __L1:dither(
            c,
            0,
            233,
            W,
            "#6a5236"
        )
        __L1:dither(
            c,
            0,
            232,
            W,
            "#6a5236"
        )
        __L1:R(
            c,
            0,
            252,
            W,
            18,
            "#584329"
        )
        __L1:dither(
            c,
            0,
            251,
            W,
            "#584329"
        )
        do
            local i = 0
            while i < W * 1.5 do
                local x = __L1:hash(i + 103) * W
                local y = 236 + __L1:hash(i + 104) * 33
                __L1:R(
                    c,
                    x,
                    y,
                    1 + __L1:hash(i) * 3,
                    1,
                    __L1:hash(i + 2) > 0.5 and "#7a6040" or "#4a3822"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < W / 16 do
                local x = __L1:hash(i + 113) * W
                local y = 240 + __L1:hash(i + 114) * 26
                local r = 1.5 + __L1:hash(i + 115) * 2
                __L1:ell(
                    c,
                    x,
                    y,
                    r + 1,
                    r,
                    "#4a3e30"
                )
                __L1:ell(
                    c,
                    x,
                    y - 0.5,
                    r,
                    r - 0.5,
                    "#9a8a70"
                )
                i = i + 1
            end
        end
        __L1:R(
            c,
            0,
            __L1.FLOOR,
            W,
            2,
            "#a9cc70"
        )
        __L1:R(
            c,
            0,
            __L1.FLOOR + 2,
            W,
            4,
            "#2e623c"
        )
        do
            local x = 0
            while x < W do
                local h = __L1:hash(x * 3 + 17)
                if h > 0.4 then
                    __L1:R(
                        c,
                        x,
                        __L1.FLOOR + 6,
                        1,
                        1 + math.floor(h * 5 + 0.5),
                        "#2e623c"
                    )
                end
                if h < 0.25 then
                    __L1:R(
                        c,
                        x,
                        __L1.FLOOR - 1 - math.floor(h * 8 + 0.5),
                        1,
                        1 + math.floor(h * 8 + 0.5),
                        "#7ab85a"
                    )
                end
                x = x + 1
            end
        end
        for ____, x in __iterar((__L1.FIELD_FLOODS)) do
            __L1:floodlight(c, x, 50, 3)
        end
        do
            local x = 30
            local i = 0
            while x < W do
                local cols = __get(
                    __arrL(
                        {
                            __arrL({"#21496c", "#f2c14e"}, 2),
                            __arrL({"#c0392b", "#ffffff"}, 2),
                            __arrL({"#2e7d32", "#fff3c4"}, 2)
                        },
                        3
                    ),
                    __mod(i, 3)
                )
                __L1:R(
                    c,
                    x - 1,
                    149,
                    57,
                    13,
                    "#1c2a2a"
                )
                __L1:R(
                    c,
                    x,
                    150,
                    55,
                    11,
                    __get(cols, 0)
                )
                __L1:R(
                    c,
                    x + 2,
                    152,
                    51,
                    7,
                    __get(cols, 1)
                )
                __L1:R(
                    c,
                    x + 5,
                    154,
                    20,
                    3,
                    __get(cols, 0)
                )
                __L1:R(
                    c,
                    x + 28,
                    154,
                    22,
                    3,
                    __get(cols, 0)
                )
                __L1:R(
                    c,
                    x + 4,
                    161,
                    2,
                    3,
                    "#33474a"
                )
                __L1:R(
                    c,
                    x + 49,
                    161,
                    2,
                    3,
                    "#33474a"
                )
                do
                    x = x + 260
                    i = i + 1
                end
            end
        end
        do
            local x = 95
            while x < W do
                __L1:R(
                    c,
                    x + 60,
                    126,
                    46,
                    3,
                    "#183e60"
                )
                __L1:R(
                    c,
                    x + 60,
                    126,
                    46,
                    1,
                    "#3a6a94"
                )
                __L1:R(
                    c,
                    x - 20,
                    122,
                    2,
                    42,
                    "#33474a"
                )
                __L1:R(
                    c,
                    x + 178,
                    122,
                    2,
                    42,
                    "#33474a"
                )
                __L1:R(
                    c,
                    x - 22,
                    120,
                    204,
                    3,
                    "#21496c"
                )
                __L1:R(
                    c,
                    x - 22,
                    120,
                    204,
                    1,
                    "#3a6a94"
                )
                do
                    local r2 = 0
                    while r2 < 3 do
                        local xx = x - r2 * 8
                        local yy = 137 + r2 * 10
                        local w = 160 + r2 * 16
                        __L1:R(
                            c,
                            xx,
                            yy,
                            w,
                            4,
                            "#6b90a4"
                        )
                        __L1:R(
                            c,
                            xx,
                            yy,
                            w,
                            1,
                            "#9cc0d0"
                        )
                        __L1:R(
                            c,
                            xx,
                            yy + 3,
                            w,
                            1,
                            "#4a6c80"
                        )
                        __L1:R(
                            c,
                            xx,
                            yy + 4,
                            w,
                            6,
                            "#3f5a6a"
                        )
                        r2 = r2 + 1
                    end
                end
                x = x + 480
            end
        end
        for ____, gx in __iterar((__L1.FIELD_GOALS)) do
            c.fillStyle = "rgba(225,240,225,.5)"
            do
                local j = 0
                while j <= 18 do
                    c:fillRect(gx + 2 + j * 5, 145, 1, 73)
                    j = j + 1
                end
            end
            do
                local j = 0
                while j <= 14 do
                    c:fillRect(gx + 2, 145 + j * 5, 88, 1)
                    j = j + 1
                end
            end
            __L1:R(
                c,
                gx,
                141,
                4,
                78,
                "#e9f2de"
            )
            __L1:R(
                c,
                gx,
                141,
                1,
                78,
                "#ffffff"
            )
            __L1:R(
                c,
                gx + 87,
                141,
                4,
                78,
                "#e9f2de"
            )
            __L1:R(
                c,
                gx + 87,
                141,
                1,
                78,
                "#ffffff"
            )
            __L1:R(
                c,
                gx,
                141,
                91,
                4,
                "#faffeb"
            )
            __L1:R(
                c,
                gx,
                144,
                91,
                1,
                "#b9c8b0"
            )
        end
        __L1:board(
            c,
            175,
            102,
            171,
            19,
            "#153a60",
            "#0c2440"
        )
        __L1:R(
            c,
            200,
            121,
            3,
            30,
            "#33474a"
        )
        __L1:R(
            c,
            318,
            121,
            3,
            30,
            "#33474a"
        )
        for ____, x in __iterar((__arrL({352, 480, 2190, 2310}, 4))) do
            __L1:R(
                c,
                x,
                200,
                1,
                18,
                "#e9f2de"
            )
            __L1:R(
                c,
                x + 1,
                200,
                5,
                4,
                "#e04a3a"
            )
            __L1:R(
                c,
                x + 1,
                200,
                5,
                1,
                "#ff8a70"
            )
        end
        do
            local x = 700
            while x < W do
                __L1:R(
                    c,
                    x,
                    213,
                    5,
                    5,
                    "#e8842a"
                )
                __L1:R(
                    c,
                    x + 1,
                    210,
                    3,
                    3,
                    "#e8842a"
                )
                __L1:R(
                    c,
                    x,
                    215,
                    5,
                    1,
                    "#ffffff"
                )
                __L1:R(
                    c,
                    x - 1,
                    218,
                    7,
                    1,
                    "#b05c18"
                )
                x = x + 370
            end
        end
        return cv
    end
    __L1.field = function(self, c, s, t, camL)
        if not __t(__get(__L1.mids, 7)) then
            __set(
                __L1.mids,
                7,
                __L1:buildFieldMid()
            )
        end
        if not __t(__L1.fieldBack) then
            __L1.fieldBack = __L1:buildFieldBack()
        end
        local sun = __L1:backdrop(
            c,
            s,
            t,
            camL,
            __arrL({19, 132}, 2)
        )
        do
            local o = __mod(
                math.floor(camL * 0.3 + 0.5),
                1400
            )
            c:drawImage(
                __get(__L1.fieldBack, 0),
                __TS__Number(-o),
                0
            )
            if 1400 - o < __L1.LW then
                c:drawImage(
                    __get(__L1.fieldBack, 0),
                    1400 - o,
                    0
                )
            end
        end
        c:drawImage(
            __get(__L1.mids, 7),
            camL,
            0,
            __L1.LW,
            __L1.LH,
            0,
            0,
            __L1.LW,
            __L1.LH
        )
        do
            local x = 95
            while x < __L1:worldW(7) do
                do
                    if __t(x - camL > __L1.LW + 40 or x + 200 - camL < -40) then
                        do x = x + 480 continue end
                    end
                    do
                        local r2 = 0
                        while r2 < 3 do
                            do
                                local j = 0
                                while j < 15 + r2 do
                                    local n = x + r2 * 31 + j * 7
                                    local px = math.floor(x - r2 * 8 + 5 + j * 10.4 + 0.5) - camL
                                    local bob = math.floor(math.max(
                                        0,
                                        math.sin(t * (4 + __L1:hash(n) * 2.5) + n)
                                    ) * 2 + 0.5)
                                    local py = 128 + r2 * 10 - bob
                                    __L1:R(
                                        c,
                                        px,
                                        py + 5,
                                        7,
                                        5,
                                        __get(
                                            __L1.FAN_SHIRT,
                                            __mod(n, 6)
                                        )
                                    )
                                    __L1:R(
                                        c,
                                        px + 1,
                                        py,
                                        5,
                                        5,
                                        __get(
                                            __L1.FAN_SKIN,
                                            __mod(n, 5)
                                        )
                                    )
                                    __L1:R(
                                        c,
                                        px + 1,
                                        py - 1,
                                        5,
                                        2,
                                        __get(
                                            __L1.FAN_HAIR,
                                            __mod(n * 3, 5)
                                        )
                                    )
                                    __L1:R(
                                        c,
                                        px + 2,
                                        py + 2,
                                        1,
                                        1,
                                        "#1c1c22"
                                    )
                                    __L1:R(
                                        c,
                                        px + 4,
                                        py + 2,
                                        1,
                                        1,
                                        "#1c1c22"
                                    )
                                    if __mod(
                                        n + math.floor(t * 1.5),
                                        5
                                    ) == 0 then
                                        __L1:R(
                                            c,
                                            px - 1,
                                            py - 3 - bob,
                                            2,
                                            8,
                                            __get(
                                                __L1.FAN_SKIN,
                                                __mod(n, 5)
                                            )
                                        )
                                        __L1:R(
                                            c,
                                            px + 6,
                                            py - 3 - bob,
                                            2,
                                            8,
                                            __get(
                                                __L1.FAN_SKIN,
                                                __mod(n, 5)
                                            )
                                        )
                                    end
                                    if __mod(n, 11) == 0 then
                                        __L1:R(
                                            c,
                                            px - 2,
                                            py - 7,
                                            11,
                                            4,
                                            __get(
                                                __L1.FAN_SHIRT,
                                                __mod(n + 2, 6)
                                            )
                                        )
                                        __L1:R(
                                            c,
                                            px - 2,
                                            py - 7,
                                            1,
                                            10,
                                            "#6a583d"
                                        )
                                    end
                                    j = j + 1
                                end
                            end
                            r2 = r2 + 1
                        end
                    end
                end
                x = x + 480
            end
        end
        if sun.str > 0.04 then
            local sh = ("rgba(14,40,30," .. tostring(0.3 * sun.str)) .. ")"
            local reach = sun.lean * (14 + math.abs(sun.lean) * 26)
            for ____, gx in __iterar((__L1.FIELD_GOALS)) do
                do
                    local x = gx - camL
                    if __t(x < -200 or x > __L1.LW + 200) then
                        continue
                    end
                    __L1:slant(
                        c,
                        x,
                        x + 4,
                        219,
                        reach * 1.5,
                        5,
                        sh
                    )
                    __L1:slant(
                        c,
                        x + 87,
                        x + 91,
                        219,
                        reach * 1.5,
                        5,
                        sh
                    )
                    __L1:slant(
                        c,
                        x + reach * 1.5,
                        x + 91 + reach * 1.5,
                        223,
                        reach * 0.2,
                        2,
                        sh
                    )
                    __L1:shadeAdd(x + reach * 1.5, x + 91 + reach * 1.5, 0.45)
                end
            end
            for ____, fx in __iterar((__L1.FIELD_FLOODS)) do
                __L1:slant(
                    c,
                    fx - camL,
                    fx - camL + 4,
                    163,
                    reach * 1.2,
                    6,
                    sh
                )
            end
            do
                local x = 95
                while x < __L1:worldW(7) do
                    local sx = x - camL
                    if __t(sx > -300 and sx < __L1.LW + 100) then
                        __L1:slant(
                            c,
                            sx - 16,
                            sx + 192,
                            164,
                            reach,
                            5,
                            sh
                        )
                    end
                    x = x + 480
                end
            end
        end
        do
            local bx = 890 + math.sin(t * 0.7) * 11 - camL
            local by = 213 - math.abs(math.sin(t * 2.8)) * 9
            __L1:ell(
                c,
                bx,
                218,
                4,
                1,
                "rgba(0,0,0,.25)"
            )
            __L1:ell(
                c,
                bx,
                by,
                4.5,
                4.5,
                "#2a2a2a"
            )
            __L1:ell(
                c,
                bx,
                by,
                3.6,
                3.6,
                "#f4f4ea"
            )
            local a = t * 5
            __L1:R(
                c,
                bx - 1 + math.cos(a) * 1.5,
                by - 1 + math.sin(a) * 1.5,
                2,
                2,
                "#2a2a2a"
            )
            __L1:R(
                c,
                bx + math.cos(a + 2.4) * 2.6,
                by + math.sin(a + 2.4) * 2.6,
                1,
                1,
                "#2a2a2a"
            )
            __L1:R(
                c,
                bx + math.cos(a + 4.2) * 2.6,
                by + math.sin(a + 4.2) * 2.6,
                1,
                1,
                "#2a2a2a"
            )
        end
    end
    __L1.fieldText = function(self, c, camera)
        c:save()
        c:translate(
            -math.floor(camera + 0.5),
            0
        )
        c.font = "16px Pixel, monospace"
        c.textAlign = "center"
        c.textBaseline = "middle"
        c.fillStyle = "#eff5de"
        c:fillText("CAMPO DO MOTA · MOTA FC", 521, 224)
        c:restore()
    end
    __L1.fieldLights = function(self, g, s, t, camL)
        if __le(s.night, 0.12) then
            return
        end
        local a = __L1:cl((s.night - 0.12) * 1.4)
        g:save()
        g:beginPath()
        g:rect(0, 0, __L1.LW, 86)
        g:clip()
        g.globalAlpha = a
        __L1:tile(
            g,
            __get(
                __L1:city(19, 132),
                1
            ),
            camL * 0.07,
            0.07
        )
        g:restore()
        g.globalAlpha = a * 0.5
        do
            local o = __mod(
                math.floor(camL * 0.3 + 0.5),
                1400
            )
            g:drawImage(
                __get(__L1.fieldBack, 1),
                __TS__Number(-o),
                0
            )
            if 1400 - o < __L1.LW then
                g:drawImage(
                    __get(__L1.fieldBack, 1),
                    1400 - o,
                    0
                )
            end
        end
        g.globalAlpha = 1
        g:clearRect(174 - camL, 101, 173, 21)
        do
            local x = 95
            while x < __L1:worldW(7) do
                g:clearRect(x - 24 - camL, 118, 208, 46)
                x = x + 480
            end
        end
        for ____, x in __iterar((__L1.FIELD_FLOODS)) do
            do
                local sx = x - camL
                if __t(sx < -200 or sx > __L1.LW + 200) then
                    continue
                end
                __L1:floodBeam(
                    g,
                    sx,
                    46,
                    a * (0.92 + 0.08 * math.sin(t * 30 + x)),
                    120
                )
            end
        end
    end
    __L1.sunWall = function(self, c, x, y, w, h, lean, a)
        if __lt(a, 0.03) then
            return
        end
        local n = math.min(
            26,
            math.floor(w * 0.4)
        )
        do
            local k = 0
            while k < n do
                do
                    local f = 1 - k / n
                    local ____t_127 = __t
                    local ____t_result_126
                    local ____t_125 = __t
                    local ____temp_124 = f < 0.4
                    __O[311] = ____temp_124
                    if ____t_125(____temp_124) then
                        ____t_result_126 = __band(k, 1)
                    else
                        ____t_result_126 = __O[311]
                    end
                    if ____t_127(____t_result_126) then
                        do k = k + 1 continue end
                    end
                    c.fillStyle = ("rgba(255,240,190," .. tostring(0.28 * a * f)) .. ")"
                    local ____c_129 = c
                    local ____c_fillRect_130 = c.fillRect
                    local ____ge_result_128
                    if __ge(lean, 0) then
                        ____ge_result_128 = x + k
                    else
                        ____ge_result_128 = __add(x, w) - 1 - k
                    end
                    ____c_fillRect_130(
                        ____c_129,
                        math.floor(____ge_result_128 + 0.5),
                        y,
                        1,
                        h
                    )
                    c.fillStyle = ("rgba(30,24,60," .. tostring(0.24 * a * f)) .. ")"
                    local ____c_132 = c
                    local ____c_fillRect_133 = c.fillRect
                    local ____ge_result_131
                    if __ge(lean, 0) then
                        ____ge_result_131 = __add(x, w) - 1 - k
                    else
                        ____ge_result_131 = x + k
                    end
                    ____c_fillRect_133(
                        ____c_132,
                        math.floor(____ge_result_131 + 0.5),
                        y,
                        1,
                        h
                    )
                end
                k = k + 1
            end
        end
    end
    __L1.fHouse = function(self, c, L, x, y, w, h, seed, haze)
        x = math.floor(x + 0.5)
        y = math.floor(y + 0.5)
        w = math.floor(w + 0.5)
        h = math.floor(h + 0.5)
        local function hz(____, col, k)
            if k == nil then
                k = haze
            end
            local ____t_result_134
            if __t(k) then
                ____t_result_134 = __L1:css(__L1:mix(
                    __L1:hexv(col),
                    __arrL({0.62, 0.7, 0.72}, 3),
                    k
                ))
            else
                ____t_result_134 = col
            end
            return ____t_result_134
        end
        local front = not __t(haze)
        local pal = __get(
            __L1.FV_COL,
            __mod(
                math.abs(seed),
                __len(__L1.FV_COL)
            )
        )
        local plaster = __mod(seed, 2) == 0
        __L1:R(
            c,
            x,
            y,
            w,
            h,
            hz(nil, "#513e38")
        )
        local ____L1_R_137 = __L1.R
        local ____array_136 = __TS__SparseArrayNew(
            c,
            x + 1,
            y + 2,
            w - 2,
            h - 2
        )
        local ____t_result_135
        if __t(plaster) then
            ____t_result_135 = pal
        else
            ____t_result_135 = "#b8704e"
        end
        __TS__SparseArrayPush(
            ____array_136,
            hz(nil, ____t_result_135)
        )
        ____L1_R_137(
            __L1,
            __TS__SparseArraySpread(____array_136)
        )
        if not __t(plaster) then
            do
                local ry = y + 3
                while __lt(
                    ry,
                    __add(y, h) - 1
                ) do
                    __L1:R(
                        c,
                        x + 1,
                        ry + 2,
                        w - 2,
                        1,
                        hz(nil, "#8f5238")
                    )
                    do
                        local bx = x + 1 + __band(ry / 3, 1) * 3
                        while __lt(
                            bx,
                            __add(x, w) - 2
                        ) do
                            __L1:R(
                                c,
                                bx,
                                ry,
                                1,
                                2,
                                hz(nil, "#8f5238")
                            )
                            local ____t_139 = __t
                            local ____t_result_138
                            if __t(front) then
                                ____t_result_138 = __L1:hash(__add(bx * 7 + ry, seed)) > 0.8
                            else
                                ____t_result_138 = front
                            end
                            if ____t_139(____t_result_138) then
                                __L1:R(
                                    c,
                                    bx + 1,
                                    ry,
                                    4,
                                    2,
                                    "#cf8866"
                                )
                            end
                            bx = bx + 6
                        end
                    end
                    ry = ry + 3
                end
            end
        elseif __t(front) then
            do
                local i = 0
                while i < w * h / 26 do
                    __L1:R(
                        c,
                        x + 2 + __L1:hash(i + seed * 3) * (w - 4),
                        y + 3 + __L1:hash(i + seed * 5) * (h - 5),
                        1,
                        1,
                        __L1:hash(i) > 0.5 and "rgba(255,255,255,.14)" or "rgba(0,0,0,.10)"
                    )
                    i = i + 1
                end
            end
            __L1:R(
                c,
                x + 1,
                __add(y, h) - 9,
                w - 2,
                9,
                "rgba(60,40,30,.16)"
            )
            do
                local i = 0
                while i < 3 do
                    local sx = x + 4 + __L1:hash(i + seed) * (w - 10)
                    __L1:R(
                        c,
                        sx,
                        y + 3,
                        1,
                        6 + __L1:hash(i + seed + 2) * 14,
                        "rgba(60,40,30,.16)"
                    )
                    i = i + 1
                end
            end
        end
        __L1:R(
            c,
            x - 3,
            y - 4,
            w + 6,
            5,
            hz(nil, "#71645a")
        )
        __L1:R(
            c,
            x - 3,
            y - 4,
            w + 6,
            1,
            hz(nil, "#b2a58a")
        )
        __L1:R(
            c,
            x - 3,
            y,
            w + 6,
            1,
            hz(nil, "#4a3f38")
        )
        c.fillStyle = "rgba(30,20,30,.2)"
        c:fillRect(x + 1, y + 2, w - 2, 2)
        local wy = y + 9
        local wh = math.min(21, h - 14)
        local ww = math.min(
            15,
            math.floor(w * 0.3 + 0.5)
        )
        do
            local k = 0
            while k < 2 do
                local wx = math.floor(x + 6 + k * (w * 0.48) + 0.5)
                __L1:R(
                    c,
                    wx,
                    wy,
                    ww,
                    wh,
                    hz(nil, "#395462")
                )
                __L1:R(
                    c,
                    wx + 1,
                    wy + 1,
                    ww - 2,
                    wh - 3,
                    hz(
                        nil,
                        __t(__mod(seed, 3)) and "#84b6c0" or "#e1c892"
                    )
                )
                __L1:R(
                    c,
                    wx + 1,
                    wy + 1,
                    ww - 2,
                    4,
                    hz(
                        nil,
                        __t(__mod(seed, 3)) and "#a8d2d8" or "#f0dcae"
                    )
                )
                __L1:R(
                    c,
                    wx + math.floor(ww / 2),
                    wy,
                    1,
                    wh,
                    hz(nil, "#dbd3b6")
                )
                __L1:R(
                    c,
                    wx - 1,
                    wy + wh,
                    ww + 2,
                    1,
                    hz(nil, "#b2a58a")
                )
                if __t(front) then
                    do
                        local b = 2
                        while b < ww - 1 do
                            __L1:R(
                                c,
                                wx + b,
                                wy + 1,
                                1,
                                wh - 3,
                                "rgba(40,50,60,.5)"
                            )
                            b = b + 3
                        end
                    end
                    if __mod(seed + k, 3) == 1 then
                        __L1:R(
                            c,
                            wx + 1,
                            wy + wh - 4,
                            3,
                            3,
                            "#b0603a"
                        )
                        __L1:R(
                            c,
                            wx + 1,
                            wy + wh - 7,
                            3,
                            3,
                            "#4f9a3f"
                        )
                        __L1:R(
                            c,
                            wx + 2,
                            wy + wh - 8,
                            1,
                            1,
                            "#e86a8a"
                        )
                    end
                    if __mod(seed + k, 3) == 0 then
                        __L1:R(
                            c,
                            wx + 4,
                            wy + wh - 9,
                            5,
                            5,
                            __get(
                                __arrL({"#c8946a", "#8a5a3c", "#f0c8a0"}, 3),
                                __mod(seed, 3)
                            )
                        )
                        __L1:R(
                            c,
                            wx + 4,
                            wy + wh - 10,
                            5,
                            2,
                            "#2a1e18"
                        )
                        __L1:R(
                            c,
                            wx + 3,
                            wy + wh - 4,
                            7,
                            2,
                            __get(
                                __L1.FV_COL,
                                __mod(seed + 3, 8)
                            )
                        )
                    end
                    if __mod(seed + k, 5) == 2 then
                        __L1:R(
                            c,
                            wx + 1,
                            wy + wh + 2,
                            10,
                            6,
                            "#cfd8dc"
                        )
                        __L1:R(
                            c,
                            wx + 2,
                            wy + wh + 4,
                            8,
                            1,
                            "#8fa1a6"
                        )
                        __L1:R(
                            c,
                            wx + 2,
                            wy + wh + 6,
                            8,
                            1,
                            "#8fa1a6"
                        )
                    end
                end
                local ____t_141 = __t
                local ____t_result_140
                if __t(L) then
                    ____t_result_140 = __L1:hash(seed * 13 + k) > 0.42
                else
                    ____t_result_140 = L
                end
                if ____t_141(____t_result_140) then
                    L.fillStyle = __L1:hash(seed + k) > 0.5 and "#ffd98a" or "#ffe9b8"
                    L:fillRect(wx + 1, wy + 1, ww - 2, wh - 3)
                end
                k = k + 1
            end
        end
        local ____t_143 = __t
        local ____t_result_142
        if __t(front) then
            ____t_result_142 = __gt(h, 44)
        else
            ____t_result_142 = front
        end
        if ____t_143(____t_result_142) then
            local dx = math.floor(x + w * 0.39 + 0.5)
            __L1:R(
                c,
                dx,
                __add(y, h) - 31,
                14,
                31,
                "#3a443e"
            )
            __L1:R(
                c,
                dx + 1,
                __add(y, h) - 30,
                12,
                30,
                __t(__mod(seed, 2)) and "#647b6f" or "#7a5a3a"
            )
            __L1:R(
                c,
                dx + 1,
                __add(y, h) - 30,
                1,
                30,
                "rgba(255,255,255,.2)"
            )
            __L1:R(
                c,
                dx + 10,
                __add(y, h) - 15,
                2,
                2,
                "#d4b584"
            )
            __L1:R(
                c,
                dx + 3,
                __add(y, h) - 26,
                8,
                9,
                "rgba(0,0,0,.18)"
            )
            __L1:R(
                c,
                dx - 2,
                __add(y, h),
                18,
                1,
                "#b3a585"
            )
        end
        if __t(front) then
            __L1:R(
                c,
                x + 4,
                y - 12,
                18,
                8,
                "#2c5f94"
            )
            __L1:R(
                c,
                x + 4,
                y - 12,
                18,
                2,
                "#5a94c8"
            )
            __L1:R(
                c,
                x + 3,
                y - 13,
                20,
                2,
                "#3a7ab8"
            )
            __L1:R(
                c,
                x + 20,
                y - 11,
                2,
                7,
                "#1f4a78"
            )
            __L1:R(
                c,
                __add(x, w) - 11,
                y - 12,
                1,
                9,
                "#414d4c"
            )
            __L1:R(
                c,
                __add(x, w) - 17,
                y - 13,
                13,
                1,
                "#414d4c"
            )
            __L1:R(
                c,
                __add(x, w) - 15,
                y - 10,
                9,
                1,
                "#414d4c"
            )
            for ____, rx in __iterar((__arrL(
                {
                    x - 1,
                    __add(x, w) - 1,
                    x + math.floor(w / 2 + 0.5)
                },
                3
            ))) do
                __L1:R(
                    c,
                    rx,
                    y - 9,
                    1,
                    5,
                    "#5a4a40"
                )
            end
            if __mod(seed, 4) == 1 then
                __L1:ell(
                    c,
                    __add(x, w) - 24,
                    y - 8,
                    5,
                    4,
                    "#b9c3bf"
                )
                __L1:ell(
                    c,
                    __add(x, w) - 23,
                    y - 8,
                    3,
                    2.5,
                    "#8fa1a6"
                )
                __L1:R(
                    c,
                    __add(x, w) - 24,
                    y - 5,
                    1,
                    2,
                    "#414d4c"
                )
            end
            if __mod(seed, 3) == 1 then
                __L1:R(
                    c,
                    x + 26,
                    y - 10,
                    1,
                    6,
                    "#5a4a40"
                )
                __L1:R(
                    c,
                    __add(x, w) - 30,
                    y - 10,
                    1,
                    6,
                    "#5a4a40"
                )
                __L1:R(
                    c,
                    x + 26,
                    y - 10,
                    w - 55,
                    1,
                    "#3a3a3a"
                )
                do
                    local k = 0
                    while k < math.floor((w - 60) / 7) do
                        __L1:R(
                            c,
                            x + 29 + k * 7,
                            y - 9,
                            5,
                            5,
                            __get(
                                __arrL({"#e0c17c", "#6697ac", "#dc8666", "#f0f0f0"}, 4),
                                __mod(k + seed, 4)
                            )
                        )
                        k = k + 1
                    end
                end
            end
            if __mod(seed, 4) == 0 then
                local gx = x + 5
                local gy = __add(y, h) - 16
                local col = __get(
                    __arrL({"#e84a8a", "#3ad0c0", "#f2d24a", "#8a5ae8"}, 4),
                    __mod(seed, 4) + __mod(
                        __shr(seed, 2),
                        3
                    ) > 3 and 0 or __mod(
                        __shr(seed, 2),
                        4
                    )
                )
                do
                    local k = 0
                    while k < 16 do
                        __L1:R(
                            c,
                            gx + k,
                            gy + math.floor(math.sin(k * 0.9) * 3 + 0.5) + 4,
                            2,
                            2,
                            col
                        )
                        k = k + 1
                    end
                end
                __L1:R(
                    c,
                    gx + 2,
                    gy + 1,
                    3,
                    8,
                    col
                )
                __L1:R(
                    c,
                    gx + 10,
                    gy,
                    2,
                    9,
                    col
                )
            end
        end
    end
    __L1.buildFavelaBack = function(self, n, step, y0, yv, w, hBase, hv, haze, sd)
        local T = math.floor(n * step + 0.5)
        local D = __L1:mk(T, 230)
        local L = __L1:mk(T, 230)
        do
            local i = 0
            while __lt(i, n) do
                local yy = y0 + __mod(
                    i,
                    __gt(yv, 20) and 4 or 3
                ) * (__gt(yv, 20) and 15 or 8)
                local h = hBase + __mod(i, 3) * hv
                __L1:R(
                    __get(D, 1),
                    math.floor(i * step + 0.5),
                    __add(yy, h) - 2,
                    math.floor(step + 0.5) + 1,
                    230,
                    __L1:css(__L1:mix(
                        __arrL({0.45, 0.42, 0.4}, 3),
                        __arrL({0.62, 0.7, 0.72}, 3),
                        haze
                    ))
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while __lt(i, n) do
                local yy = y0 + __mod(
                    i,
                    __gt(yv, 20) and 4 or 3
                ) * (__gt(yv, 20) and 15 or 8)
                __L1:fHouse(
                    __get(D, 1),
                    __get(L, 1),
                    i * step,
                    yy,
                    w,
                    hBase + __mod(i, 3) * hv,
                    i + sd,
                    haze
                )
                i = i + 1
            end
        end
        return __arrL(
            {
                __get(D, 0),
                __get(L, 0)
            },
            2
        )
    end
    __L1.buildFavelaMid = function(self)
        local W = __L1:worldW(5)
        local cv, c = table.unpack(
            __L1:mk(W, __L1.LH),
            1,
            2
        )
        local lv, l = table.unpack(
            __L1:mk(W, __L1.LH),
            1,
            2
        )
        __L1:R(
            c,
            0,
            199,
            W,
            21,
            "#968a73"
        )
        __L1:R(
            c,
            0,
            199,
            W,
            1,
            "#b8ab90"
        )
        do
            local i = 0
            while i < W do
                __L1:R(
                    c,
                    __L1:hash(i + 3) * W,
                    200 + __L1:hash(i + 4) * 19,
                    2,
                    1,
                    __t(__mod(i, 2)) and "#857a66" or "#a69a82"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i * 105 < W do
                local h = __L1:fvHouse(i)
                __L1:fHouse(
                    c,
                    l,
                    h.x,
                    h.y,
                    h.w,
                    h.h,
                    i + 100,
                    0
                )
                do
                    local k = 0
                    while k < 3 do
                        __L1:R(
                            c,
                            h.x + 95 + k * 1.5,
                            h.y + 39 + k * 4 + (__t(__mod(i, 2)) and 0 or 0) + (82 - h.h) * 0 + (h.h - 43 - 12),
                            8 - k * 1.5,
                            4,
                            __get(
                                __arrL({"#b3a585", "#a69b81", "#958c78"}, 3),
                                k
                            )
                        )
                        __L1:R(
                            c,
                            h.x + 95 + k * 1.5,
                            h.y + h.h - 16 + k * 4,
                            8 - k * 1.5,
                            1,
                            "#d0c4a4"
                        )
                        k = k + 1
                    end
                end
                i = i + 1
            end
        end
        __L1:R(
            c,
            0,
            __L1.FLOOR,
            W,
            50,
            "#887f7a"
        )
        __L1:R(
            c,
            0,
            242,
            W,
            28,
            "#7a716c"
        )
        __L1:dither(
            c,
            0,
            241,
            W,
            "#7a716c"
        )
        do
            local i = 0
            while i < W * 2 do
                __L1:R(
                    c,
                    __L1:hash(i + 13) * W,
                    225 + __L1:hash(i + 14) * 44,
                    1 + __L1:hash(i) * 2,
                    1,
                    __get(
                        __arrL({"#766d68", "#9a918c", "#625c5c"}, 3),
                        __mod(i, 3)
                    )
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < W / 70 do
                local x = __L1:hash(i + 23) * W
                local w2 = 14 + __L1:hash(i + 24) * 22
                __L1:R(
                    c,
                    x,
                    228 + __L1:hash(i + 25) * 24,
                    w2,
                    5 + __L1:hash(i + 26) * 6,
                    "#6a625e"
                )
                __L1:R(
                    c,
                    x,
                    228 + __L1:hash(i + 25) * 24,
                    w2,
                    1,
                    "#7d7570"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < W / 55 do
                local x = __L1:hash(i + 33) * W
                local y = 226
                do
                    local k = 0
                    while k < 10 + __L1:hash(i) * 12 do
                        __L1:R(
                            c,
                            x,
                            y,
                            1,
                            1,
                            "#4f4947"
                        )
                        x = x + (__L1:hash(i * 5 + k) > 0.45 and 1 or -1)
                        y = y + (__L1:hash(i * 3 + k) > 0.4 and 1 or 0)
                        k = k + 1
                    end
                end
                i = i + 1
            end
        end
        do
            local x = 160
            while x < W do
                __L1:R(
                    c,
                    x,
                    226,
                    14,
                    6,
                    "#4a4543"
                )
                do
                    local k = 1
                    while k < 14 do
                        __L1:R(
                            c,
                            x + k,
                            227,
                            1,
                            4,
                            "#2a2726"
                        )
                        k = k + 3
                    end
                end
                x = x + 330
            end
        end
        __L1:R(
            c,
            0,
            __L1.FLOOR,
            W,
            3,
            "#a6a49a"
        )
        __L1:R(
            c,
            0,
            __L1.FLOOR,
            W,
            1,
            "#c9c7bc"
        )
        __L1:R(
            c,
            0,
            __L1.FLOOR + 3,
            W,
            2,
            "#625c5c"
        )
        do
            local x = 0
            while x < W do
                __L1:R(
                    c,
                    x,
                    __L1.FLOOR,
                    1,
                    3,
                    "#8a8880"
                )
                x = x + 20
            end
        end
        for ____, ____value in __iterar((__L1.FV_SIGNS)) do
            local x = ____value[1]
            local i = ____value[2]
            __L1:board(
                c,
                x,
                147,
                64,
                37,
                "#2a5b65",
                "#1f3d44"
            )
            __L1:R(
                c,
                x + 2,
                149,
                60,
                1,
                "#3f7a84"
            )
            __L1:R(
                c,
                x + 30,
                184,
                3,
                35,
                "#3c5358"
            )
            __L1:R(
                c,
                x + 70,
                196,
                15,
                23,
                "#395f59"
            )
            __L1:R(
                c,
                x + 69,
                193,
                17,
                4,
                "#82a087"
            )
            __L1:R(
                c,
                x + 73,
                200,
                9,
                8,
                "#22403c"
            )
            __L1:R(
                c,
                x + 74,
                201,
                3,
                3,
                "#f0c84a"
            )
        end
        do
            local x = 0
            while x < W do
                __L1:R(
                    c,
                    x,
                    58,
                    3,
                    162,
                    "#4b5b56"
                )
                __L1:R(
                    c,
                    x,
                    58,
                    1,
                    162,
                    "#6f807a"
                )
                __L1:R(
                    c,
                    x - 8,
                    62,
                    19,
                    2,
                    "#394b4f"
                )
                __L1:R(
                    c,
                    x - 8,
                    60,
                    1,
                    2,
                    "#9aa8a0"
                )
                __L1:R(
                    c,
                    x + 10,
                    60,
                    1,
                    2,
                    "#9aa8a0"
                )
                __L1:R(
                    c,
                    x + 3,
                    84,
                    10,
                    2,
                    "#394b4f"
                )
                __L1:R(
                    c,
                    x + 10,
                    86,
                    5,
                    3,
                    "#2a3a3c"
                )
                __L1:R(
                    c,
                    x + 11,
                    89,
                    3,
                    1,
                    "#ffe9a8"
                )
                __L1:R(
                    c,
                    x - 3,
                    112,
                    9,
                    11,
                    "#5a6a64"
                )
                __L1:R(
                    c,
                    x - 2,
                    113,
                    7,
                    3,
                    "#8a9a92"
                )
                do
                    local k = 0
                    while k < 4 do
                        __L1:R(
                            c,
                            x - 1 + k * 2,
                            150 + k * 3,
                            6,
                            1,
                            "rgba(240,240,230,.5)"
                        )
                        k = k + 1
                    end
                end
                x = x + 195
            end
        end
        return __arrL({cv, lv}, 2)
    end
    __L1.favela = function(self, c, s, t, camL)
        if not __t(__L1.far) then
            __L1.far = __L1:buildFar()
        end
        if not __t(__get(__L1.mids, 5)) then
            __set(
                __L1.mids,
                5,
                __L1:buildFavelaMid()
            )
        end
        if not __t(__len(__L1.FV_BACK)) then
            __call(
                __L1.FV_BACK,
                "push",
                __L1:buildFavelaBack(
                    10,
                    90.5,
                    47,
                    30,
                    87,
                    58,
                    8,
                    0.5,
                    20
                ),
                __L1:buildFavelaBack(
                    12,
                    79.5,
                    100,
                    8,
                    75,
                    64,
                    0,
                    0.25,
                    8
                )
            )
        end
        local sun = __L1:sunInfo(s)
        local la = math.min(
            1,
            math.abs(sun.lean) * 1.3
        ) * sun.str
        __L1:sky(c, s, t, camL)
        __L1:tile(
            c,
            __get(__L1.far, 0),
            camL * 0.04,
            0.04
        )
        if la > 0.03 then
            c.globalAlpha = la
            __L1:tile(
                c,
                __get(
                    __get(__L1.far, sun.lean >= 0 and 3 or 4),
                    0
                ),
                camL * 0.04,
                0.04
            )
            c.globalAlpha = 1
        end
        __L1:tile(
            c,
            __get(
                __get(__L1.FV_BACK, 0),
                0
            ),
            camL * 0.2,
            0.2
        )
        __L1:tile(
            c,
            __get(
                __get(__L1.FV_BACK, 1),
                0
            ),
            camL * 0.48,
            0.48
        )
        c:drawImage(
            __get(
                __get(__L1.mids, 5),
                0
            ),
            camL,
            0,
            __L1.LW,
            __L1.LH,
            0,
            0,
            __L1.LW,
            __L1.LH
        )
        if sun.str > 0.04 then
            local a = math.min(
                1,
                math.abs(sun.lean) * 1.4
            ) * sun.str
            local sh = ("rgba(18,24,48," .. tostring(0.28 * sun.str)) .. ")"
            local reach = sun.lean * (14 + math.abs(sun.lean) * 26)
            do
                local i = math.max(
                    0,
                    math.floor((camL - 100) / 105)
                )
                while __lt(i * 105, camL + __L1.LW + 10) do
                    local h = __L1:fvHouse(i)
                    local x = h.x - camL
                    __L1:sunWall(
                        c,
                        x + 1,
                        h.y + 2,
                        h.w - 2,
                        h.h - 2,
                        sun.lean,
                        a
                    )
                    __L1:slant(
                        c,
                        x - 3,
                        x + h.w + 3,
                        h.y + 1,
                        reach * 0.25,
                        3 + math.floor(math.abs(sun.lean) * 4 + 0.5),
                        ("rgba(18,24,48," .. tostring(0.2 * sun.str)) .. ")"
                    )
                    __L1:slant(
                        c,
                        x,
                        x + h.w,
                        218,
                        reach,
                        2,
                        sh
                    )
                    i = i + 1
                end
            end
            do
                local x = math.floor(camL / 195) * 195 - 195
                while __lt(x, camL + __L1.LW + 195) do
                    __L1:slant(
                        c,
                        x - camL,
                        x - camL + 3,
                        219,
                        reach * 1.5,
                        6,
                        sh
                    )
                    x = x + 195
                end
            end
        end
        do
            local x = math.floor(camL / 195) * 195
            while __lt(x, camL + __L1.LW + 200) do
                local x1 = x - 195 - camL
                local x2 = x - camL
                do
                    local k = 0
                    while k <= 48 do
                        local u = k / 48
                        local px = x1 + (x2 - x1) * u
                        local py = 63 + math.sin(u * math.pi) * 26
                        __L1:R(
                            c,
                            px,
                            py,
                            (x2 - x1) / 48 + 1,
                            1,
                            "#394b4f"
                        )
                        __L1:R(
                            c,
                            px,
                            py + 22 - math.sin(u * math.pi) * 8,
                            (x2 - x1) / 48 + 1,
                            1,
                            "rgba(40,52,56,.7)"
                        )
                        k = k + 1
                    end
                end
                do
                    local j = 0
                    while j < 4 do
                        local u = 0.25 + j * 0.12
                        local px = x1 + (x2 - x1) * u
                        local py = 64 + math.sin(u * math.pi) * 26
                        do
                            local r2 = 0
                            while r2 < 13 do
                                local wv = math.floor(math.sin(t * 3 + j + r2 * 0.25) * (r2 / 12) * 2.2 + 0.5)
                                __L1:R(
                                    c,
                                    px + wv,
                                    py + r2,
                                    11,
                                    1,
                                    __get(
                                        __arrL({"#e0c17c", "#6697ac", "#dc8666", "#d8d0a7"}, 4),
                                        j
                                    )
                                )
                                __L1:R(
                                    c,
                                    px + wv,
                                    py + r2,
                                    1,
                                    1,
                                    "rgba(0,0,0,.18)"
                                )
                                r2 = r2 + 1
                            end
                        end
                        j = j + 1
                    end
                end
                x = x + 195
            end
        end
        do
            local i = 0
            while i < 2 do
                local kx = __mod(
                    __mod(300 + i * 420 - camL * 0.3, 700) + 700,
                    700
                ) - 60
                local ky = 34 + i * 18 + math.sin(t * 0.9 + i * 2) * 8
                local col = __t(i) and "#e84a4a" or "#f2d24a"
                do
                    local k = 0
                    while k < 5 do
                        __L1:R(
                            c,
                            kx - k,
                            ky - 4 + k,
                            k * 2 + 1,
                            1,
                            col
                        )
                        __L1:R(
                            c,
                            kx - (4 - k),
                            ky + 1 + k,
                            (4 - k) * 2 + 1,
                            1,
                            col
                        )
                        k = k + 1
                    end
                end
                do
                    local k = 0
                    while k < 14 do
                        __L1:R(
                            c,
                            kx + math.floor(math.sin(t * 4 + k * 0.6) * 2 + 0.5),
                            ky + 6 + k,
                            1,
                            1,
                            __t(__mod(k, 3)) and "#e8e0d0" or "#3a7fd0"
                        )
                        k = k + 1
                    end
                end
                i = i + 1
            end
        end
    end
    __L1.favelaText = function(self, c, camera)
        c:save()
        c:translate(
            -math.floor(camera + 0.5),
            0
        )
        c.textAlign = "center"
        c.textBaseline = "middle"
        for ____, ____value in __iterar((__L1.FV_SIGNS)) do
            local x = ____value[1]
            local i = ____value[2]
            do
                if __t(x * 2 < camera - 200 or __gt(x * 2, camera + 1160)) then
                    continue
                end
                c.font = "16px Pixel, monospace"
                c.fillStyle = "#b0dfc5"
                local ____gt_result_144
                if __gt(i, 4) then
                    ____gt_result_144 = __arrL({"ALTO DO", "MORRO"}, 2)
                else
                    ____gt_result_144 = __arrL({"RESPEITA", "A RESENHA"}, 2)
                end
                local tx = ____gt_result_144
                c:fillText(
                    __get(tx, 0),
                    x * 2 + 64,
                    310
                )
                c:fillText(
                    __get(tx, 1),
                    x * 2 + 64,
                    328
                )
                c.font = "8px Pixel, monospace"
                c.fillStyle = "#e8d9a0"
                c:fillText("GABRIEL REEIS", x * 2 + 64, 352)
            end
        end
        c:restore()
    end
    __L1.favelaLights = function(self, g, s, t, camL)
        if __le(s.night, 0.12) then
            return
        end
        local a = __L1:cl((s.night - 0.12) * 1.4)
        g.globalAlpha = a * 0.4
        __L1:tile(
            g,
            __get(
                __get(__L1.FV_BACK, 0),
                1
            ),
            camL * 0.2,
            0.2
        )
        g.globalCompositeOperation = "destination-out"
        g.globalAlpha = 1
        __L1:tile(
            g,
            __get(
                __get(__L1.FV_BACK, 1),
                0
            ),
            camL * 0.48,
            0.48
        )
        g.globalCompositeOperation = "source-over"
        g.globalAlpha = a * 0.5
        __L1:tile(
            g,
            __get(
                __get(__L1.FV_BACK, 1),
                1
            ),
            camL * 0.48,
            0.48
        )
        g.globalCompositeOperation = "destination-out"
        g.globalAlpha = 1
        g:drawImage(
            __get(
                __get(__L1.mids, 5),
                0
            ),
            camL,
            0,
            __L1.LW,
            219,
            0,
            0,
            __L1.LW,
            219
        )
        g.globalCompositeOperation = "source-over"
        g.globalAlpha = a * 0.6
        g:drawImage(
            __get(
                __get(__L1.mids, 5),
                1
            ),
            camL,
            0,
            __L1.LW,
            __L1.LH,
            0,
            0,
            __L1.LW,
            __L1.LH
        )
        g.globalAlpha = 1
        do
            local x = math.floor(camL / 195) * 195 - 195
            while __lt(x, camL + __L1.LW + 195) do
                local sx = x - camL + 12
                local _l = __L1:lightAdd(x - camL + 12, 90, a, 60)
                local gr = g:createLinearGradient(0, 90, 0, 262)
                gr:addColorStop(
                    0,
                    ("rgba(255,206,130," .. tostring(0.34 * a)) .. ")"
                )
                gr:addColorStop(
                    1,
                    ("rgba(255,206,130," .. tostring(0.04 * a)) .. ")"
                )
                g.fillStyle = gr
                g:beginPath()
                g:moveTo(sx - 3, 90)
                g:lineTo(sx + 4, 90)
                g:lineTo(sx + 58, 262)
                g:lineTo(sx - 56, 262)
                g:closePath()
                __call(g, "fill")
                local b = g:createRadialGradient(
                    sx,
                    90,
                    1,
                    sx,
                    92,
                    24
                )
                b:addColorStop(
                    0,
                    ("rgba(255,226,160," .. tostring(0.85 * a)) .. ")"
                )
                b:addColorStop(1, "rgba(255,226,160,0)")
                g.fillStyle = b
                g:fillRect(sx - 26, 64, 52, 52)
                g:save()
                g:translate(sx, 230)
                g:scale(1, 0.28)
                local p = g:createRadialGradient(
                    0,
                    0,
                    0,
                    0,
                    0,
                    62
                )
                p:addColorStop(
                    0,
                    ("rgba(255,206,130," .. tostring(0.32 * a)) .. ")"
                )
                p:addColorStop(1, "rgba(255,206,130,0)")
                g.fillStyle = p
                g:fillRect(-62, -62, 124, 124)
                g:restore()
                x = x + 195
            end
        end
    end
    __L1.ptPoster = function(self, c, x, y, k)
        __L1:R(
            c,
            x - 1,
            y - 1,
            26,
            32,
            "#8a8f8a"
        )
        __L1:R(
            c,
            x,
            y,
            24,
            30,
            "#f3ead6"
        )
        if k == 0 then
            do
                local e = 0
                while e < 11 do
                    __L1:R(
                        c,
                        x + 1 + e * 2,
                        y + 2,
                        2,
                        20,
                        __get(__L1.ERAS, e)
                    )
                    e = e + 1
                end
            end
            __L1:R(
                c,
                x + 3,
                y + 24,
                18,
                1,
                "#5a5a5a"
            )
            __L1:R(
                c,
                x + 6,
                y + 26,
                12,
                1,
                "#5a5a5a"
            )
        elseif k == 1 then
            __L1:R(
                c,
                x,
                y,
                24,
                30,
                "#f7d8e4"
            )
            for ____, ____value in __iterar((__arrL(
                {
                    __arrL({4, 6}, 2),
                    __arrL({15, 6}, 2)
                },
                2
            ))) do
                local hx = ____value[1]
                local hy = ____value[2]
                __L1:R(
                    c,
                    x + hx,
                    y + hy,
                    5,
                    3,
                    "#d83a6a"
                )
            end
            __L1:R(
                c,
                x + 4,
                y + 9,
                16,
                3,
                "#d83a6a"
            )
            __L1:R(
                c,
                x + 6,
                y + 12,
                12,
                2,
                "#d83a6a"
            )
            __L1:R(
                c,
                x + 8,
                y + 14,
                8,
                2,
                "#d83a6a"
            )
            __L1:R(
                c,
                x + 10,
                y + 16,
                4,
                2,
                "#d83a6a"
            )
            __L1:R(
                c,
                x + 7,
                y + 21,
                2,
                6,
                "#3a3a3a"
            )
            __L1:R(
                c,
                x + 12,
                y + 21,
                5,
                1,
                "#3a3a3a"
            )
            __L1:R(
                c,
                x + 16,
                y + 22,
                1,
                2,
                "#3a3a3a"
            )
            __L1:R(
                c,
                x + 13,
                y + 23,
                4,
                1,
                "#3a3a3a"
            )
            __L1:R(
                c,
                x + 16,
                y + 24,
                1,
                2,
                "#3a3a3a"
            )
            __L1:R(
                c,
                x + 12,
                y + 26,
                5,
                1,
                "#3a3a3a"
            )
        elseif k == 2 then
            __L1:R(
                c,
                x,
                y,
                24,
                30,
                "#d8e8f0"
            )
            local function cat(____, cx, col)
                __L1:R(
                    c,
                    cx,
                    y + 12,
                    6,
                    9,
                    col
                )
                __L1:R(
                    c,
                    cx,
                    y + 8,
                    6,
                    5,
                    col
                )
                __L1:R(
                    c,
                    cx,
                    y + 6,
                    2,
                    2,
                    col
                )
                __L1:R(
                    c,
                    cx + 4,
                    y + 6,
                    2,
                    2,
                    col
                )
                __L1:R(
                    c,
                    cx + 1,
                    y + 10,
                    1,
                    1,
                    "#2a2a2a"
                )
                __L1:R(
                    c,
                    cx + 4,
                    y + 10,
                    1,
                    1,
                    "#2a2a2a"
                )
                __L1:R(
                    c,
                    cx + 6,
                    y + 17,
                    2,
                    1,
                    col
                )
                __L1:R(
                    c,
                    cx + 7,
                    y + 14,
                    1,
                    3,
                    col
                )
            end
            cat(nil, x + 2, "#f0f0f0")
            cat(nil, x + 9, "#c8a078")
            cat(nil, x + 16, "#8a8a8a")
            __L1:R(
                c,
                x + 4,
                y + 24,
                16,
                1,
                "#5a5a5a"
            )
        elseif k == 3 then
            __L1:R(
                c,
                x,
                y,
                24,
                30,
                "#2a3a78"
            )
            do
                local i = 0
                while i < 9 do
                    local sx = x + 2 + __L1:hash(i + 7) * 20
                    local sy = y + 2 + __L1:hash(i + 9) * 26
                    __L1:R(
                        c,
                        sx,
                        sy,
                        1,
                        1,
                        "#fff6c8"
                    )
                    if __mod(i, 3) == 0 then
                        __L1:R(
                            c,
                            sx - 1,
                            sy,
                            3,
                            1,
                            "#fff6c8"
                        )
                        __L1:R(
                            c,
                            sx,
                            sy - 1,
                            1,
                            3,
                            "#fff6c8"
                        )
                    end
                    i = i + 1
                end
            end
            __L1:ell(
                c,
                x + 12,
                y + 19,
                5,
                6,
                "#c98a5a"
            )
            __L1:ell(
                c,
                x + 12,
                y + 14,
                3.5,
                4,
                "#c98a5a"
            )
            __L1:ell(
                c,
                x + 12,
                y + 18,
                1.5,
                1.5,
                "#3a2a1a"
            )
            __L1:R(
                c,
                x + 11,
                y + 3,
                2,
                12,
                "#7a5a3a"
            )
            __L1:R(
                c,
                x + 10,
                y + 2,
                4,
                3,
                "#3a2a1a"
            )
        elseif k == 4 then
            __L1:R(
                c,
                x,
                y,
                24,
                30,
                "#1a1a1a"
            )
            do
                local i = 0
                while i < 22 do
                    local a = i / 22 * 5.2
                    local px = x + 12 + math.cos(a) * (2 + i * 0.38)
                    local py = y + 15 + math.sin(a) * (2 + i * 0.42)
                    __L1:R(
                        c,
                        px,
                        py,
                        2,
                        2,
                        __t(__mod(i, 4)) and "#3aa86a" or "#c8e86a"
                    )
                    i = i + 1
                end
            end
            __L1:R(
                c,
                x + 20,
                y + 13,
                2,
                2,
                "#3aa86a"
            )
            __L1:R(
                c,
                x + 22,
                y + 14,
                1,
                1,
                "#e84a4a"
            )
        else
            __L1:R(
                c,
                x,
                y,
                24,
                30,
                "#f2d0e0"
            )
            __L1:ell(
                c,
                x + 12,
                y + 13,
                8,
                8,
                "#e8e8f0"
            )
            do
                local i = 0
                while i < 26 do
                    local gx2 = x + 5 + __mod(i, 6) * 2.6 + __band(i / 6, 1)
                    local gy = y + 7 + math.floor(i / 6) * 2.8
                    __L1:R(
                        c,
                        gx2,
                        gy,
                        2,
                        2,
                        __get(
                            __arrL({"#ffffff", "#b8c8e8", "#f8c8e0", "#c8f0e8"}, 4),
                            __mod(i, 4)
                        )
                    )
                    i = i + 1
                end
            end
            __L1:R(
                c,
                x + 12,
                y + 1,
                1,
                5,
                "#5a5a5a"
            )
            __L1:R(
                c,
                x + 5,
                y + 25,
                14,
                1,
                "#8a4a6a"
            )
        end
        __L1:R(
            c,
            x + 11,
            y - 2,
            2,
            2,
            "#c94f45"
        )
    end
    __L1.buildPatioMid = function(self)
        local W = __L1:worldW(9)
        local cv, c = table.unpack(
            __L1:mk(W, __L1.LH),
            1,
            2
        )
        local lv, l = table.unpack(
            __L1:mk(W, __L1.LH),
            1,
            2
        )
        local fy = 176
        __call(
            __arrL({
                4,
                5,
                6,
                8,
                9,
                12
            }, 6),
            "forEach",
            function(____, rh, r2)
                local tw = 18 + r2 * 4
                do
                    local k = -1
                    while k * tw < W do
                        local x = k * tw + __mod(r2, 2) * tw / 2
                        local lt = __band(k + r2, 1)
                        local ____L1_R_147 = __L1.R
                        local ____array_146 = __TS__SparseArrayNew(
                            c,
                            x,
                            fy,
                            tw,
                            rh
                        )
                        local ____t_result_145
                        if __t(lt) then
                            ____t_result_145 = __L1:css(__L1:mix(
                                __arrL({0.78, 0.82, 0.78}, 3),
                                __arrL({0.87, 0.87, 0.78}, 3),
                                r2 / 5
                            ))
                        else
                            ____t_result_145 = __L1:css(__L1:mix(
                                __arrL({0.72, 0.77, 0.74}, 3),
                                __arrL({0.82, 0.83, 0.74}, 3),
                                r2 / 5
                            ))
                        end
                        __TS__SparseArrayPush(____array_146, ____t_result_145)
                        ____L1_R_147(
                            __L1,
                            __TS__SparseArraySpread(____array_146)
                        )
                        __L1:R(
                            c,
                            x,
                            fy,
                            tw,
                            1,
                            "rgba(255,255,255,.3)"
                        )
                        __L1:R(
                            c,
                            x,
                            fy,
                            1,
                            rh,
                            "rgba(90,110,110,.35)"
                        )
                        k = k + 1
                    end
                end
                fy = fy + rh
            end
        )
        __L1:R(
            c,
            0,
            176,
            W,
            2,
            "#f1f0da"
        )
        __L1:R(
            c,
            0,
            106,
            W,
            72,
            "#f0f4ef"
        )
        do
            local i = 0
            while i < W * 1.4 do
                __L1:R(
                    c,
                    __L1:hash(i + 3) * W,
                    112 + __L1:hash(i + 4) * 48,
                    2,
                    1,
                    __t(__mod(i, 2)) and "#e3e9e3" or "#fafcf8"
                )
                i = i + 1
            end
        end
        __L1:R(
            c,
            0,
            106,
            W,
            5,
            "#173e65"
        )
        __L1:R(
            c,
            0,
            106,
            W,
            1,
            "#3a6a94"
        )
        __L1:R(
            c,
            0,
            111,
            W,
            2,
            "#ffffff"
        )
        __L1:R(
            c,
            0,
            161,
            W,
            17,
            "#254f75"
        )
        __L1:R(
            c,
            0,
            161,
            W,
            2,
            "#183d5d"
        )
        __L1:R(
            c,
            0,
            163,
            W,
            1,
            "#3a6a94"
        )
        do
            local x = 0
            while x < W do
                __L1:R(
                    c,
                    x,
                    164,
                    1,
                    14,
                    "#1f4567"
                )
                x = x + 12
            end
        end
        do
            local i = 0
            while __L1:PT_WIN(i) < W do
                local x = math.floor(__L1:PT_WIN(i) + 0.5)
                local gap = x + 60
                if not __t(__get(__L1.PT_MURAL, i)) then
                    __L1:R(
                        c,
                        x - 1,
                        121,
                        52,
                        34,
                        "#1c3a50"
                    )
                    __L1:R(
                        c,
                        x,
                        122,
                        50,
                        32,
                        "#294e68"
                    )
                    __L1:R(
                        c,
                        x + 2,
                        124,
                        46,
                        28,
                        "#7bafb7"
                    )
                    __L1:R(
                        c,
                        x + 2,
                        124,
                        46,
                        9,
                        "#9ccdd2"
                    )
                    do
                        local k = 0
                        while k < 24 do
                            __L1:R(
                                c,
                                x + 6 + math.floor((24 - k) * 0.5 + 0.5),
                                126 + k,
                                4,
                                1,
                                "rgba(255,255,255,.28)"
                            )
                            k = k + 1
                        end
                    end
                    __L1:R(
                        c,
                        x + 24,
                        124,
                        2,
                        28,
                        "#e6eee1"
                    )
                    __L1:R(
                        c,
                        x + 2,
                        137,
                        46,
                        2,
                        "#e6eee1"
                    )
                    __L1:R(
                        c,
                        x - 3,
                        154,
                        56,
                        3,
                        "#acbcb7"
                    )
                    __L1:R(
                        c,
                        x - 3,
                        154,
                        56,
                        1,
                        "#d5e0da"
                    )
                    c.fillStyle = "rgba(0,0,0,.12)"
                    c:fillRect(x - 1, 157, 52, 2)
                    if __L1:hash(i + 31) > 0.4 then
                        l.fillStyle = "#ffe2a0"
                        l:fillRect(x + 2, 124, 46, 28)
                    end
                elseif __get(__L1.PT_MURAL, i) == "eras" then
                    __L1:R(
                        c,
                        x - 2,
                        116,
                        88,
                        43,
                        "#1c3a50"
                    )
                    do
                        local e = 0
                        while e < 11 do
                            __L1:R(
                                c,
                                x + e * 7.6,
                                118,
                                8,
                                39,
                                __get(__L1.ERAS, e)
                            )
                            __L1:R(
                                c,
                                x + e * 7.6,
                                118,
                                1,
                                39,
                                "rgba(255,255,255,.25)"
                            )
                            local ix = x + e * 7.6 + 3
                            local iy = 146
                            if __mod(e, 4) == 0 then
                                __L1:R(
                                    c,
                                    ix - 1,
                                    iy,
                                    3,
                                    1,
                                    "#fff6c8"
                                )
                                __L1:R(
                                    c,
                                    ix,
                                    iy - 1,
                                    1,
                                    3,
                                    "#fff6c8"
                                )
                            elseif __mod(e, 4) == 1 then
                                __L1:R(
                                    c,
                                    ix - 1,
                                    iy - 1,
                                    1,
                                    1,
                                    "#ffffff"
                                )
                                __L1:R(
                                    c,
                                    ix + 1,
                                    iy - 1,
                                    1,
                                    1,
                                    "#ffffff"
                                )
                                __L1:R(
                                    c,
                                    ix - 1,
                                    iy,
                                    3,
                                    1,
                                    "#ffffff"
                                )
                                __L1:R(
                                    c,
                                    ix,
                                    iy + 1,
                                    1,
                                    1,
                                    "#ffffff"
                                )
                            elseif __mod(e, 4) == 2 then
                                __L1:ell(
                                    c,
                                    ix,
                                    iy,
                                    2,
                                    2,
                                    "#ffffff"
                                )
                            else
                                __L1:R(
                                    c,
                                    ix,
                                    iy - 2,
                                    1,
                                    4,
                                    "#ffffff"
                                )
                                __L1:R(
                                    c,
                                    ix - 1,
                                    iy + 1,
                                    2,
                                    2,
                                    "#ffffff"
                                )
                            end
                            e = e + 1
                        end
                    end
                    __L1:R(
                        c,
                        x,
                        121,
                        84,
                        13,
                        "rgba(20,30,50,.55)"
                    )
                elseif __get(__L1.PT_MURAL, i) == "violao" then
                    __L1:R(
                        c,
                        x - 2,
                        116,
                        88,
                        43,
                        "#1c3a50"
                    )
                    __L1:R(
                        c,
                        x,
                        118,
                        84,
                        39,
                        "#2a3a78"
                    )
                    do
                        local k = 0
                        while k < 26 do
                            local sx = x + 2 + __L1:hash(k + 41) * 80
                            local sy = 119 + __L1:hash(k + 43) * 36
                            __L1:R(
                                c,
                                sx,
                                sy,
                                1,
                                1,
                                "#fff6c8"
                            )
                            if __mod(k, 3) == 0 then
                                __L1:R(
                                    c,
                                    sx - 1,
                                    sy,
                                    3,
                                    1,
                                    "#fff6c8"
                                )
                                __L1:R(
                                    c,
                                    sx,
                                    sy - 1,
                                    1,
                                    3,
                                    "#fff6c8"
                                )
                            end
                            k = k + 1
                        end
                    end
                    __L1:ell(
                        c,
                        x + 24,
                        144,
                        11,
                        9,
                        "#c98a5a"
                    )
                    __L1:ell(
                        c,
                        x + 37,
                        141,
                        8,
                        7,
                        "#c98a5a"
                    )
                    __L1:ell(
                        c,
                        x + 23,
                        143,
                        9,
                        7,
                        "#dba06a"
                    )
                    __L1:ell(
                        c,
                        x + 28,
                        143,
                        3,
                        3,
                        "#3a2a1a"
                    )
                    do
                        local k = 0
                        while k < 30 do
                            __L1:R(
                                c,
                                x + 42 + k,
                                139 - math.floor(k * 0.45 + 0.5),
                                2,
                                3,
                                "#7a5a3a"
                            )
                            k = k + 1
                        end
                    end
                    __L1:R(
                        c,
                        x + 71,
                        122,
                        7,
                        6,
                        "#3a2a1a"
                    )
                    do
                        local k = 0
                        while k < 44 do
                            __L1:R(
                                c,
                                x + 27 + k,
                                142 - math.floor(k * 0.45 + 0.5),
                                1,
                                1,
                                "#f0e8d0"
                            )
                            k = k + 2
                        end
                    end
                    __L1:R(
                        c,
                        x + 52,
                        143,
                        2,
                        11,
                        "#f2d24a"
                    )
                    __L1:R(
                        c,
                        x + 58,
                        142,
                        8,
                        2,
                        "#f2d24a"
                    )
                    __L1:R(
                        c,
                        x + 64,
                        144,
                        2,
                        4,
                        "#f2d24a"
                    )
                    __L1:R(
                        c,
                        x + 59,
                        147,
                        7,
                        2,
                        "#f2d24a"
                    )
                    __L1:R(
                        c,
                        x + 64,
                        149,
                        2,
                        4,
                        "#f2d24a"
                    )
                    __L1:R(
                        c,
                        x + 58,
                        152,
                        8,
                        2,
                        "#f2d24a"
                    )
                else
                    __L1:R(
                        c,
                        x - 2,
                        116,
                        88,
                        43,
                        "#1c3a50"
                    )
                    __L1:R(
                        c,
                        x,
                        118,
                        84,
                        39,
                        "#f7d8e4"
                    )
                    local function cat(____, cx, col, col2)
                        __L1:R(
                            c,
                            cx,
                            136,
                            16,
                            20,
                            col
                        )
                        __L1:R(
                            c,
                            cx + 1,
                            126,
                            14,
                            12,
                            col
                        )
                        __L1:R(
                            c,
                            cx + 1,
                            122,
                            4,
                            5,
                            col
                        )
                        __L1:R(
                            c,
                            cx + 11,
                            122,
                            4,
                            5,
                            col
                        )
                        __L1:R(
                            c,
                            cx + 2,
                            124,
                            2,
                            2,
                            "#f0a0b0"
                        )
                        __L1:R(
                            c,
                            cx + 12,
                            124,
                            2,
                            2,
                            "#f0a0b0"
                        )
                        __L1:R(
                            c,
                            cx + 4,
                            130,
                            2,
                            3,
                            "#3a7a4a"
                        )
                        __L1:R(
                            c,
                            cx + 10,
                            130,
                            2,
                            3,
                            "#3a7a4a"
                        )
                        __L1:R(
                            c,
                            cx + 7,
                            134,
                            2,
                            1,
                            "#e87a8a"
                        )
                        __L1:R(
                            c,
                            cx + 2,
                            140,
                            12,
                            14,
                            col2
                        )
                        __L1:R(
                            c,
                            cx + 16,
                            146,
                            4,
                            2,
                            col
                        )
                        __L1:R(
                            c,
                            cx + 19,
                            140,
                            2,
                            7,
                            col
                        )
                    end
                    cat(nil, x + 5, "#f0f0f0", "#ffffff")
                    cat(nil, x + 31, "#c8a078", "#e8d0b0")
                    cat(nil, x + 57, "#8a8a8a", "#b0b0b0")
                    for ____, ____value in __iterar((__arrL(
                        {
                            __arrL({26, 122}, 2),
                            __arrL({52, 121}, 2),
                            __arrL({78, 124}, 2)
                        },
                        3
                    ))) do
                        local hx = ____value[1]
                        local hy = ____value[2]
                        __L1:R(
                            c,
                            x + hx,
                            hy,
                            2,
                            2,
                            "#d83a6a"
                        )
                        __L1:R(
                            c,
                            x + hx + 3,
                            hy,
                            2,
                            2,
                            "#d83a6a"
                        )
                        __L1:R(
                            c,
                            x + hx,
                            hy + 2,
                            5,
                            1,
                            "#d83a6a"
                        )
                        __L1:R(
                            c,
                            x + hx + 1,
                            hy + 3,
                            3,
                            1,
                            "#d83a6a"
                        )
                        __L1:R(
                            c,
                            x + hx + 2,
                            hy + 4,
                            1,
                            1,
                            "#d83a6a"
                        )
                    end
                end
                if __t(gap + 30 < W and not __t(__get(__L1.PT_MURAL, i))) then
                    if __mod(i, 3) == 0 then
                        __L1:R(
                            c,
                            gap + 5,
                            116,
                            22,
                            13,
                            "#cfd8dc"
                        )
                        __L1:R(
                            c,
                            gap + 5,
                            116,
                            22,
                            1,
                            "#ffffff"
                        )
                        do
                            local k = 0
                            while k < 4 do
                                __L1:R(
                                    c,
                                    gap + 7,
                                    119 + k * 2.5,
                                    18,
                                    1,
                                    "#8fa1a6"
                                )
                                k = k + 1
                            end
                        end
                        __L1:R(
                            c,
                            gap + 14,
                            129,
                            1,
                            32,
                            "#9fb0b0"
                        )
                    elseif __mod(i, 3) == 1 then
                        __L1:ptPoster(
                            c,
                            gap + 5,
                            124,
                            __mod(
                                math.floor(i / 3),
                                6
                            )
                        )
                    else
                        __L1:R(
                            c,
                            gap + 15,
                            111,
                            3,
                            50,
                            "#b9c8c4"
                        )
                        __L1:R(
                            c,
                            gap + 15,
                            111,
                            1,
                            50,
                            "#e0ebe6"
                        )
                        __L1:R(
                            c,
                            gap + 14,
                            126,
                            5,
                            2,
                            "#8fa1a0"
                        )
                        __L1:R(
                            c,
                            gap + 14,
                            146,
                            5,
                            2,
                            "#8fa1a0"
                        )
                    end
                end
                i = i + 1
            end
        end
        __L1:R(
            c,
            5,
            93,
            W - 10,
            8,
            "#163e63"
        )
        __L1:R(
            c,
            5,
            93,
            W - 10,
            2,
            "#457c9d"
        )
        __L1:R(
            c,
            5,
            100,
            W - 10,
            1,
            "#0e2a44"
        )
        c.fillStyle = "rgba(10,20,40,.22)"
        c:fillRect(5, 101, W - 10, 4)
        do
            local x = 11
            while x < W do
                local next = x + 182.5
                do
                    local k = 0
                    while k <= 60 do
                        local u = k / 60
                        local px = x + 5 + (next - x - 5) * u
                        local py = 102 + math.sin(u * math.pi) * 9
                        if px > W then
                            break
                        end
                        __L1:R(
                            c,
                            px,
                            py,
                            2,
                            2,
                            __get(
                                __L1.ERAS,
                                __mod(
                                    k + math.floor(x + 0.5),
                                    11
                                )
                            )
                        )
                        if __mod(k, 6) == 3 then
                            __L1:R(
                                c,
                                px,
                                py,
                                2,
                                2,
                                "#ffffff"
                            )
                        end
                        k = k + 1
                    end
                end
                __L1:R(
                    c,
                    x,
                    100,
                    6,
                    78,
                    "#becfcf"
                )
                __L1:R(
                    c,
                    x + 1,
                    100,
                    2,
                    78,
                    "#f7f9ec"
                )
                __L1:R(
                    c,
                    x + 5,
                    100,
                    1,
                    78,
                    "#8fa5a5"
                )
                __L1:R(
                    c,
                    x - 2,
                    174,
                    10,
                    4,
                    "#7eaaad"
                )
                __L1:R(
                    c,
                    x - 1,
                    100,
                    8,
                    2,
                    "#9fb5b5"
                )
                x = x + 182.5
            end
        end
        __L1:board(
            c,
            166,
            114,
            200,
            23,
            "#1b4467",
            "#0e2a44"
        )
        __L1:board(
            c,
            1867,
            140,
            130,
            26,
            "#32617b",
            "#1c3d50"
        )
        for ____, x in __iterar((__arrL({35, 610, 1085, 1745}, 4))) do
            __L1:ell(
                c,
                x,
                216,
                27,
                4,
                "#6e9b8b"
            )
            __L1:R(
                c,
                x - 25,
                212,
                49,
                6,
                "#436d72"
            )
            __L1:R(
                c,
                x - 23,
                212,
                46,
                2,
                "#b2d1bd"
            )
            do
                local k = 0
                while k < 8 do
                    __L1:R(
                        c,
                        x - 20 + k * 5.5,
                        210 - __mod(k, 2),
                        2,
                        3,
                        __t(__mod(k, 3)) and "#4f9a3f" or "#e86a8a"
                    )
                    k = k + 1
                end
            end
        end
        __call(
            __arrL({45, 730, 990, 1685}, 4),
            "forEach",
            function(____, x, n)
                __L1:R(
                    c,
                    x,
                    186,
                    65,
                    4,
                    "#386e9d"
                )
                __L1:R(
                    c,
                    x,
                    192,
                    65,
                    3,
                    "#386e9d"
                )
                __L1:R(
                    c,
                    x,
                    186,
                    65,
                    1,
                    "#6296b7"
                )
                __L1:R(
                    c,
                    x,
                    198,
                    65,
                    5,
                    "#2c5e8e"
                )
                __L1:R(
                    c,
                    x + 2,
                    199,
                    61,
                    2,
                    "#6296b7"
                )
                __L1:R(
                    c,
                    x + 4,
                    203,
                    4,
                    16,
                    "#587e8d"
                )
                __L1:R(
                    c,
                    x + 56,
                    203,
                    4,
                    16,
                    "#587e8d"
                )
                c.fillStyle = "rgba(0,0,0,.18)"
                c:fillRect(x + 2, 219, 61, 1)
                do
                    local j = 0
                    while j < 2 do
                        local px = x + 18 + j * 22
                        local sd = n * 2 + j
                        __L1:R(
                            c,
                            px,
                            188,
                            9,
                            10,
                            __get(
                                __L1.FAN_SHIRT,
                                __mod(sd, 6)
                            )
                        )
                        __L1:R(
                            c,
                            px + 1,
                            181,
                            7,
                            7,
                            __get(
                                __L1.FAN_SKIN,
                                __mod(sd, 5)
                            )
                        )
                        __L1:R(
                            c,
                            px + 1,
                            180,
                            7,
                            3,
                            __get(
                                __L1.FAN_HAIR,
                                __mod(sd * 3, 5)
                            )
                        )
                        __L1:R(
                            c,
                            px + 2,
                            184,
                            1,
                            1,
                            "#1c1c22"
                        )
                        __L1:R(
                            c,
                            px + 5,
                            184,
                            1,
                            1,
                            "#1c1c22"
                        )
                        __L1:R(
                            c,
                            px,
                            198,
                            4,
                            8,
                            "#3a4a6a"
                        )
                        __L1:R(
                            c,
                            px + 5,
                            198,
                            4,
                            8,
                            "#3a4a6a"
                        )
                        __L1:R(
                            c,
                            px + (__t(j) and 8 or -2),
                            191,
                            3,
                            2,
                            __get(
                                __L1.ERAS,
                                __mod(sd * 3, 11)
                            )
                        )
                        j = j + 1
                    end
                end
                if n == 1 then
                    do
                        local k = 0
                        while k < 14 do
                            __L1:R(
                                c,
                                x + 48 + __mod(k, 2),
                                186 + k,
                                5,
                                1,
                                "#c8322e"
                            )
                            k = k + 1
                        end
                    end
                    __L1:R(
                        c,
                        x + 47,
                        199,
                        7,
                        3,
                        "#c8322e"
                    )
                    do
                        local k = 0
                        while k < 3 do
                            __L1:R(
                                c,
                                x + 47 + k * 2,
                                202,
                                1,
                                2,
                                "#8a1f1c"
                            )
                            k = k + 1
                        end
                    end
                end
                if n == 2 then
                    __L1:R(
                        c,
                        x + 2,
                        185,
                        13,
                        12,
                        "#ece4d0"
                    )
                    __L1:R(
                        c,
                        x + 8,
                        185,
                        1,
                        12,
                        "#b0a890"
                    )
                    __L1:R(
                        c,
                        x + 2,
                        195,
                        13,
                        2,
                        "#3a3a5a"
                    )
                    for ____, ____value in __iterar((__arrL(
                        {
                            __arrL({4, 188}, 2),
                            __arrL({11, 190}, 2),
                            __arrL({5, 192}, 2)
                        },
                        3
                    ))) do
                        local sx = ____value[1]
                        local sy = ____value[2]
                        __L1:R(
                            c,
                            x + sx,
                            sy,
                            1,
                            1,
                            "#3a3a5a"
                        )
                    end
                end
            end
        )
        for ____, x in __iterar((__L1.PT_LAMPS)) do
            __L1:R(
                c,
                x,
                82,
                3,
                95,
                "#365f75"
            )
            __L1:R(
                c,
                x,
                82,
                1,
                95,
                "#5a8aa0"
            )
            __L1:R(
                c,
                x - 5,
                75,
                13,
                8,
                "#244b69"
            )
            __L1:R(
                c,
                x - 3,
                77,
                9,
                4,
                "#fff0b4"
            )
            __L1:R(
                c,
                x - 2,
                174,
                7,
                3,
                "#244b69"
            )
        end
        __L1:R(
            c,
            860,
            196,
            96,
            5,
            "#8a6238"
        )
        __L1:R(
            c,
            860,
            196,
            96,
            1,
            "#b88a56"
        )
        do
            local k = 0
            while k < 96 do
                __L1:R(
                    c,
                    860 + k,
                    197,
                    1,
                    4,
                    "#6a4a2a"
                )
                k = k + 12
            end
        end
        __L1:R(
            c,
            906,
            172,
            1,
            24,
            "#3a3a3a"
        )
        __L1:R(
            c,
            904,
            169,
            5,
            4,
            "#8a8a9a"
        )
        __L1:R(
            c,
            904,
            169,
            5,
            1,
            "#e0e0f0"
        )
        do
            local k = 0
            while k < 5 do
                __L1:R(
                    c,
                    905 + __mod(k, 2) * 3,
                    168 - __mod(k, 3),
                    1,
                    1,
                    "#fff6c8"
                )
                k = k + 1
            end
        end
        __L1:R(
            c,
            902,
            195,
            9,
            1,
            "#3a3a3a"
        )
        __L1:R(
            c,
            930,
            178,
            12,
            18,
            "#c98a5a"
        )
        __L1:R(
            c,
            932,
            176,
            8,
            3,
            "#c98a5a"
        )
        __L1:R(
            c,
            935,
            160,
            2,
            17,
            "#7a5a3a"
        )
        __L1:R(
            c,
            934,
            158,
            4,
            3,
            "#3a2a1a"
        )
        __L1:ell(
            c,
            936,
            188,
            2,
            2,
            "#3a2a1a"
        )
        __L1:R(
            c,
            1378,
            196,
            56,
            4,
            "#f08ab8"
        )
        __L1:R(
            c,
            1378,
            196,
            56,
            1,
            "#ffc0dc"
        )
        __L1:R(
            c,
            1380,
            200,
            3,
            19,
            "#8a6238"
        )
        __L1:R(
            c,
            1429,
            200,
            3,
            19,
            "#8a6238"
        )
        do
            local k = 0
            while k < 8 do
                __L1:R(
                    c,
                    1381 + k * 6.5,
                    192,
                    5,
                    4,
                    "#f3ead6"
                )
                do
                    local b = 0
                    while b < 4 do
                        __L1:R(
                            c,
                            1381 + k * 6.5 + b,
                            193 + __mod(b, 2),
                            1,
                            1,
                            __get(
                                __L1.ERAS,
                                __mod(k * 3 + b, 11)
                            )
                        )
                        b = b + 1
                    end
                end
                k = k + 1
            end
        end
        __L1:R(
            c,
            1378,
            200,
            56,
            8,
            "rgba(240,138,184,.5)"
        )
        __L1:R(
            c,
            0,
            __L1.FLOOR,
            W,
            50,
            "#c3ccca"
        )
        __L1:R(
            c,
            0,
            242,
            W,
            28,
            "#b3bdbb"
        )
        __L1:dither(
            c,
            0,
            241,
            W,
            "#b3bdbb"
        )
        do
            local x = 0
            while x < W do
                __L1:R(
                    c,
                    x,
                    225,
                    1,
                    45,
                    "#9aaeb0"
                )
                __L1:R(
                    c,
                    x + 1,
                    225,
                    1,
                    45,
                    "#d8e0dc"
                )
                x = x + 26.5
            end
        end
        __L1:R(
            c,
            0,
            249,
            W,
            1,
            "#9aaeb0"
        )
        do
            local i = 0
            while i < W * 1.5 do
                __L1:R(
                    c,
                    __L1:hash(i + 53) * W,
                    226 + __L1:hash(i + 54) * 43,
                    1 + __L1:hash(i) * 2,
                    1,
                    __t(__mod(i, 3)) and "#b0bab8" or "#d5ddd9"
                )
                i = i + 1
            end
        end
        __L1:R(
            c,
            0,
            __L1.FLOOR,
            W,
            3,
            "#f2f3df"
        )
        __L1:R(
            c,
            0,
            __L1.FLOOR,
            W,
            1,
            "#ffffff"
        )
        __L1:R(
            c,
            0,
            __L1.FLOOR + 3,
            W,
            2,
            "#9aaeb0"
        )
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({300, "#f08ab8"}, 2),
                __arrL({1250, "#7ac8e8"}, 2),
                __arrL({1560, "#f2d24a"}, 2)
            },
            3
        ))) do
            local x = ____value[1]
            local col = ____value[2]
            do
                local k = 0
                while k < 9 do
                    local a = k / 9 * 6.28
                    local ____L1_R_150 = __L1.R
                    local ____array_149 = __TS__SparseArrayNew(
                        c,
                        x + math.cos(a) * 4,
                        216 + math.sin(a) * 1.5,
                        1,
                        1
                    )
                    local ____t_result_148
                    if __t(__mod(k, 2)) then
                        ____t_result_148 = col
                    else
                        ____t_result_148 = "#ffffff"
                    end
                    __TS__SparseArrayPush(____array_149, ____t_result_148)
                    ____L1_R_150(
                        __L1,
                        __TS__SparseArraySpread(____array_149)
                    )
                    k = k + 1
                end
            end
        end
        return __arrL({cv, lv}, 2)
    end
    __L1.patio = function(self, c, s, t, camL)
        if not __t(__get(__L1.mids, 9)) then
            __set(
                __L1.mids,
                9,
                __L1:buildPatioMid()
            )
        end
        local sun = __L1:backdrop(
            c,
            s,
            t,
            camL,
            __arrL({31, 108}, 2)
        )
        c:drawImage(
            __get(
                __get(__L1.mids, 9),
                0
            ),
            camL,
            0,
            __L1.LW,
            __L1.LH,
            0,
            0,
            __L1.LW,
            __L1.LH
        )
        if sun.str > 0.04 then
            local el = 1 - math.abs(sun.lean)
            local dep = math.floor(5 + el * 16 + 0.5)
            local sh = ("rgba(14,24,50," .. tostring(0.22 * sun.str)) .. ")"
            local reach = sun.lean * (10 + math.abs(sun.lean) * 30)
            __L1:R(
                c,
                0,
                101,
                __L1.LW,
                dep,
                sh
            )
            do
                local x = 0
                while x < __L1.LW do
                    if __t(__band(
                        __shr(x, 1),
                        1
                    )) then
                        __L1:R(
                            c,
                            x,
                            101 + dep,
                            1,
                            1,
                            sh
                        )
                    end
                    x = x + 2
                end
            end
            do
                local x = math.floor(camL / 182.5) * 182.5 + 11 - 182.5
                while __lt(x, camL + __L1.LW + 60) do
                    __L1:slant(
                        c,
                        x - camL + reach * 0.2,
                        x - camL + 6 + reach * 0.2,
                        101 + dep,
                        reach * 0.9,
                        178 - 101 - dep,
                        ("rgba(14,24,50," .. tostring(0.16 * sun.str)) .. ")"
                    )
                    __L1:slant(
                        c,
                        x - camL + reach * 1.1,
                        x - camL + 6 + reach * 1.1,
                        178,
                        reach * 0.9,
                        30,
                        ("rgba(14,24,50," .. tostring(0.14 * sun.str)) .. ")"
                    )
                    x = x + 182.5
                end
            end
            for ____, x in __iterar((__L1.PT_LAMPS)) do
                __L1:slant(
                    c,
                    x - camL,
                    x - camL + 3,
                    177,
                    reach * 1.4,
                    8,
                    sh
                )
            end
        end
        for ____, x in __iterar((__arrL({35, 610, 1085, 1745}, 4))) do
            local sx = x - camL
            if __t(sx > -60 and sx < __L1.LW + 60) then
                __L1:tree(
                    c,
                    sx,
                    213,
                    0.72,
                    1,
                    t,
                    x
                )
            end
        end
        do
            local x0 = 820 - camL
            if __t(x0 < __L1.LW and x0 + 420 > 0) then
                __L1:R(
                    c,
                    x0,
                    71,
                    417,
                    1,
                    "#557e85"
                )
                do
                    local i = 0
                    while i < 18 do
                        local x = x0 + 5 + i * 22.5
                        local wv = math.floor(math.sin(t * 2 + i) * 1.2 + 0.5)
                        do
                            local k = 0
                            while k < 11 do
                                __L1:R(
                                    c,
                                    x + k * 0.5 + wv * (k / 11),
                                    72 + k,
                                    11 - k,
                                    1,
                                    __get(
                                        __L1.ERAS,
                                        __mod(i, 11)
                                    )
                                )
                                k = k + 1
                            end
                        end
                        i = i + 1
                    end
                end
            end
        end
        do
            local px = 510 + math.sin(t * 0.8) * 2.5 - camL
            __L1:R(
                c,
                px,
                89,
                5,
                4,
                "#9caaa9"
            )
            __L1:R(
                c,
                px + 4,
                87,
                3,
                4,
                "#c6ccc3"
            )
            __L1:R(
                c,
                px + 5,
                88,
                1,
                1,
                "#3d5b62"
            )
            __L1:R(
                c,
                px + 7,
                89,
                1,
                1,
                "#ba9d60"
            )
            __L1:R(
                c,
                px + 1,
                92,
                1,
                1,
                "#b59872"
            )
            __L1:R(
                c,
                px + 3,
                92,
                1,
                1,
                "#b59872"
            )
        end
        do
            local mx = 908 - camL
            if __t(mx > -20 and mx < __L1.LW + 20) then
                __L1:R(
                    c,
                    mx,
                    101,
                    1,
                    7,
                    "#5a5a5a"
                )
                __L1:ell(
                    c,
                    mx,
                    114,
                    6,
                    6,
                    "#7a8aa8"
                )
                do
                    local i = 0
                    while i < 20 do
                        local a = __mod(i, 5) / 5 * 6.28 + t * 1.2 + math.floor(i / 5) * 0.6
                        local yy = 110 + math.floor(i / 5) * 2.6
                        local r = math.sqrt(math.max(0, 36 - (yy - 114) * (yy - 114)))
                        local px = mx + math.cos(a) * r
                        if math.sin(a) > -0.2 then
                            __L1:R(
                                c,
                                px,
                                yy,
                                2,
                                2,
                                __get(
                                    __arrL({"#ffffff", "#c8d8f8", "#f8d0e8", "#d0f0e8"}, 4),
                                    __mod(
                                        i + math.floor(t * 3),
                                        4
                                    )
                                )
                            )
                        end
                        i = i + 1
                    end
                end
            end
        end
    end
    __L1.patioText = function(self, c, camera)
        c:save()
        c:translate(
            -math.floor(camera + 0.5),
            0
        )
        c.textAlign = "center"
        c.textBaseline = "middle"
        c.font = "16px Pixel, monospace"
        c.fillStyle = "#f0f4e6"
        c:fillText("COLÉGIO ADVENTISTA", 532, 244)
        c:fillText("RESPEITO & RESENHA", 3864, 298)
        c.fillStyle = "#fff6c8"
        c:fillText(
            "AS ERAS",
            (__L1:PT_WIN(5) + 42) * 2,
            256
        )
        c.fillStyle = "#f7d8e4"
        c:fillText(
            "VERSÃO DA ROÇA",
            (__L1:PT_WIN(12) + 42) * 2,
            340
        )
        c:fillText(
            "SWIFTIES DO PÁTIO",
            (__L1:PT_WIN(17) + 42) * 2,
            340
        )
        c:fillText("TROCA DE PULSEIRAS", 2812, 340)
        c.fillStyle = "#b8d8e8"
        c:fillText("1989", 1160, 340)
        c:fillText("SHOW DE TALENTOS", 1816, 340)
        c.font = "8px Pixel, monospace"
        c.fillStyle = "#a9d5da"
        c:fillText("PÁTIO · UM RECREIO DE MUITAS HISTÓRIAS", 532, 262)
        c.fillStyle = "#e8efdc"
        c:fillText("TODO MUNDO TEM VEZ.", 3864, 318)
        c:restore()
    end
    __L1.patioLights = function(self, g, s, t, camL)
        local a = __L1:cl((s.night - 0.12) * 1.4)
        if a > 0.02 then
            g:save()
            g:beginPath()
            g:rect(0, 0, __L1.LW, 92)
            g:clip()
            g.globalAlpha = a
            __L1:tile(
                g,
                __get(
                    __L1:city(31, 108),
                    1
                ),
                camL * 0.07,
                0.07
            )
            g:restore()
            g.globalAlpha = a * 0.35
            g:drawImage(
                __get(
                    __get(__L1.mids, 9),
                    1
                ),
                camL,
                0,
                __L1.LW,
                __L1.LH,
                0,
                0,
                __L1.LW,
                __L1.LH
            )
            g.globalAlpha = 1
            for ____, x in __iterar((__L1.PT_LAMPS)) do
                do
                    local sx = x - camL + 1
                    if __t(sx < -120 or sx > __L1.LW + 120) then
                        continue
                    end
                    __L1:lightAdd(sx, 82, a, 70)
                    local gr = g:createLinearGradient(0, 82, 0, 262)
                    gr:addColorStop(
                        0,
                        ("rgba(255,236,170," .. tostring(0.3 * a)) .. ")"
                    )
                    gr:addColorStop(
                        1,
                        ("rgba(255,236,170," .. tostring(0.04 * a)) .. ")"
                    )
                    g.fillStyle = gr
                    g:beginPath()
                    g:moveTo(sx - 5, 82)
                    g:lineTo(sx + 6, 82)
                    g:lineTo(sx + 70, 262)
                    g:lineTo(sx - 69, 262)
                    g:closePath()
                    __call(g, "fill")
                    local b = g:createRadialGradient(
                        sx,
                        79,
                        1,
                        sx,
                        80,
                        26
                    )
                    b:addColorStop(
                        0,
                        ("rgba(255,240,180," .. tostring(0.85 * a)) .. ")"
                    )
                    b:addColorStop(1, "rgba(255,240,180,0)")
                    g.fillStyle = b
                    g:fillRect(sx - 28, 52, 56, 56)
                end
            end
        end
        local mx = 908 - camL
        if __t(mx > -220 and mx < __L1.LW + 220) then
            local k = 0.25 + a * 0.75
            do
                local i = 0
                while i < 26 do
                    local an = i / 26 * 6.28 + t * 0.5
                    local rr = 30 + __mod(i, 5) * 26
                    local px = mx + math.cos(an) * rr * 1.5
                    local py = 150 + math.sin(an) * rr * 0.55 + __mod(i, 3) * 8
                    local col = __get(
                        __arrL(
                            {
                                __arrL({1, 1, 1}, 3),
                                __arrL({0.75, 0.85, 1}, 3),
                                __arrL({1, 0.8, 0.92}, 3),
                                __arrL({0.8, 1, 0.95}, 3)
                            },
                            4
                        ),
                        __mod(i, 4)
                    )
                    g.fillStyle = __L1:css(col, 0.5 * k)
                    g:fillRect(
                        math.floor(px + 0.5),
                        math.floor(py + 0.5),
                        3,
                        2
                    )
                    g.fillStyle = __L1:css(col, 0.16 * k)
                    g:fillRect(
                        math.floor(px + 0.5) - 1,
                        math.floor(py + 0.5) - 1,
                        5,
                        4
                    )
                    i = i + 1
                end
            end
        end
    end
    __L1.paving = function(self, c, W, base, dark, line, top, step)
        __L1:R(
            c,
            0,
            __L1.FLOOR,
            W,
            50,
            base
        )
        __L1:R(
            c,
            0,
            242,
            W,
            28,
            dark
        )
        __L1:dither(
            c,
            0,
            241,
            W,
            dark
        )
        do
            local x = 0
            while __lt(x, W) do
                __L1:R(
                    c,
                    x,
                    225,
                    1,
                    45,
                    line
                )
                __L1:R(
                    c,
                    x + 1,
                    225,
                    1,
                    45,
                    "rgba(255,255,255,.16)"
                )
                x = x + step
            end
        end
        __L1:R(
            c,
            0,
            248,
            W,
            1,
            line
        )
        do
            local i = 0
            while i < W * 1.5 do
                __L1:R(
                    c,
                    __L1:hash(i + 143) * W,
                    226 + __L1:hash(i + 144) * 43,
                    1 + __L1:hash(i) * 2,
                    1,
                    __t(__mod(i, 3)) and "rgba(0,0,0,.10)" or "rgba(255,255,255,.14)"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < W / 55 do
                local x = __L1:hash(i + 153) * W
                local y = 226 + __L1:hash(i + 154) * 18
                do
                    local k = 0
                    while k < 8 + __L1:hash(i) * 10 do
                        __L1:R(
                            c,
                            x,
                            y,
                            1,
                            1,
                            "rgba(40,40,50,.45)"
                        )
                        x = x + (__L1:hash(i * 5 + k) > 0.45 and 1 or -1)
                        y = y + (__L1:hash(i * 3 + k) > 0.5 and 1 or 0)
                        k = k + 1
                    end
                end
                i = i + 1
            end
        end
        __L1:R(
            c,
            0,
            __L1.FLOOR,
            W,
            3,
            top
        )
        __L1:R(
            c,
            0,
            __L1.FLOOR,
            W,
            1,
            "rgba(255,255,255,.45)"
        )
        __L1:R(
            c,
            0,
            __L1.FLOOR + 3,
            W,
            2,
            line
        )
    end
    __L1.win = function(self, c, l, x, y, w, h, lit)
        x = math.floor(x + 0.5)
        __L1:R(
            c,
            x - 1,
            y - 1,
            w + 2,
            h + 2,
            "#22405a"
        )
        __L1:R(
            c,
            x,
            y,
            w,
            h,
            "#466c86"
        )
        __L1:R(
            c,
            x + 2,
            y + 2,
            w - 4,
            h - 4,
            "#7ba6ae"
        )
        __L1:R(
            c,
            x + 2,
            y + 2,
            w - 4,
            math.floor(h * 0.3 + 0.5),
            "#a5cbd0"
        )
        do
            local k = 0
            while k < h - 8 do
                __L1:R(
                    c,
                    x + 5 + math.floor((h - k) * 0.4 + 0.5),
                    y + 3 + k,
                    4,
                    1,
                    "rgba(255,255,255,.26)"
                )
                k = k + 1
            end
        end
        __L1:R(
            c,
            x + math.floor(w / 2) - 1,
            y + 2,
            2,
            h - 4,
            "#d7e7ec"
        )
        __L1:R(
            c,
            x + 2,
            y + math.floor(h / 2),
            w - 4,
            2,
            "#d7e7ec"
        )
        __L1:R(
            c,
            x - 3,
            __add(y, h) + 1,
            w + 6,
            3,
            "#c7d9e0"
        )
        __L1:R(
            c,
            x - 3,
            __add(y, h) + 1,
            w + 6,
            1,
            "#eef6f8"
        )
        c.fillStyle = "rgba(0,0,0,.13)"
        c:fillRect(
            x - 1,
            __add(y, h) + 4,
            w + 2,
            2
        )
        local ____t_152 = __t
        local ____t_result_151
        if __t(l) then
            ____t_result_151 = lit
        else
            ____t_result_151 = l
        end
        if ____t_152(____t_result_151) then
            l.fillStyle = "#ffe2a0"
            l:fillRect(x + 2, y + 2, w - 4, h - 4)
        end
    end
    __L1.bench = function(self, c, x, y, w, col, hi)
        __L1:R(
            c,
            x,
            y - 12,
            w,
            3,
            col
        )
        __L1:R(
            c,
            x,
            y - 12,
            w,
            1,
            hi
        )
        __L1:R(
            c,
            x,
            y - 7,
            w,
            3,
            col
        )
        __L1:R(
            c,
            x,
            y - 7,
            w,
            1,
            hi
        )
        __L1:R(
            c,
            x + 3,
            y - 12,
            2,
            12,
            "#5a5a48"
        )
        __L1:R(
            c,
            __add(x, w) - 5,
            y - 12,
            2,
            12,
            "#5a5a48"
        )
        __L1:R(
            c,
            x,
            y,
            w,
            4,
            col
        )
        __L1:R(
            c,
            x,
            y,
            w,
            1,
            hi
        )
        __L1:R(
            c,
            x,
            y + 3,
            w,
            1,
            "rgba(0,0,0,.25)"
        )
        __L1:R(
            c,
            x + 3,
            y + 4,
            3,
            12,
            "#58604b"
        )
        __L1:R(
            c,
            __add(x, w) - 6,
            y + 4,
            3,
            12,
            "#58604b"
        )
        c.fillStyle = "rgba(0,0,0,.18)"
        c:fillRect(
            math.floor(x + 1 + 0.5),
            219,
            math.floor(w - 2 + 0.5),
            1
        )
    end
    __L1.lampPost = function(self, c, x, top)
        __L1:R(
            c,
            x,
            top,
            3,
            220 - top - 1,
            "#476967"
        )
        __L1:R(
            c,
            x,
            top,
            1,
            220 - top - 1,
            "#6f918e"
        )
        __L1:R(
            c,
            x - 6,
            top - 6,
            15,
            7,
            "#294e5a"
        )
        __L1:R(
            c,
            x - 4,
            top - 4,
            11,
            3,
            "#fff0b4"
        )
        __L1:R(
            c,
            x - 2,
            216,
            7,
            3,
            "#294e5a"
        )
    end
    __L1.lampGlow = function(self, g, sx, top, a, rgb, reach)
        if rgb == nil then
            rgb = "255,236,170"
        end
        if reach == nil then
            reach = 66
        end
        local ____t_156 = __t
        local ____t_result_155
        local ____t_154 = __t
        local ____temp_153 = __lt(a, 0.02) or __lt(sx, -140)
        __O[312] = ____temp_153
        if ____t_154(____temp_153) then
            ____t_result_155 = __O[312]
        else
            ____t_result_155 = __gt(sx, __L1.LW + 140)
        end
        if ____t_156(____t_result_155) then
            return
        end
        __L1:lightAdd(sx, top, a, reach)
        local gr = g:createLinearGradient(0, top, 0, 262)
        gr:addColorStop(
            0,
            ((("rgba(" .. rgb) .. ",") .. tostring(0.3 * a)) .. ")"
        )
        gr:addColorStop(
            1,
            ((("rgba(" .. rgb) .. ",") .. tostring(0.04 * a)) .. ")"
        )
        g.fillStyle = gr
        g:beginPath()
        g:moveTo(sx - 5, top)
        g:lineTo(sx + 6, top)
        g:lineTo(sx + reach, 262)
        g:lineTo(sx - reach + 1, 262)
        g:closePath()
        __call(g, "fill")
        local b = g:createRadialGradient(
            sx,
            top - 2,
            1,
            sx,
            top,
            26
        )
        b:addColorStop(
            0,
            ((("rgba(" .. rgb) .. ",") .. tostring(0.85 * a)) .. ")"
        )
        b:addColorStop(1, ("rgba(" .. rgb) .. ",0)")
        g.fillStyle = b
        g:fillRect(sx - 28, top - 28, 56, 56)
    end
    __L1.buildSchoolMid = function(self)
        local W = __L1:worldW(1)
        local cv, c = table.unpack(
            __L1:mk(W, __L1.LH),
            1,
            2
        )
        local lv, l = table.unpack(
            __L1:mk(W, __L1.LH),
            1,
            2
        )
        __L1:R(
            c,
            0,
            196,
            W,
            24,
            "#b6b18a"
        )
        __L1:R(
            c,
            0,
            196,
            W,
            1,
            "#d3cea8"
        )
        do
            local x = 0
            while x < W do
                __L1:R(
                    c,
                    x,
                    197,
                    1,
                    23,
                    "#9c976f"
                )
                x = x + 30
            end
        end
        do
            local i = 0
            while i < W do
                __L1:R(
                    c,
                    __L1:hash(i + 3) * W,
                    198 + __L1:hash(i + 4) * 21,
                    2,
                    1,
                    __t(__mod(i, 2)) and "#a8a37c" or "#c6c19a"
                )
                i = i + 1
            end
        end
        __L1:R(
            c,
            45,
            111,
            W - 45,
            103,
            "#eef3f4"
        )
        do
            local i = 0
            while i < W * 2 do
                __L1:R(
                    c,
                    45 + __L1:hash(i + 13) * (W - 45),
                    120 + __L1:hash(i + 14) * 62,
                    2,
                    1,
                    __t(__mod(i, 2)) and "#e0e8ea" or "#fbfdfd"
                )
                i = i + 1
            end
        end
        __L1:R(
            c,
            40,
            107,
            W - 40,
            7,
            "#183a5e"
        )
        __L1:R(
            c,
            40,
            107,
            W - 40,
            1,
            "#3a6a94"
        )
        __L1:R(
            c,
            45,
            114,
            W - 45,
            4,
            "#ffffff"
        )
        c.fillStyle = "rgba(20,40,70,.16)"
        c:fillRect(45, 118, W - 45, 3)
        __L1:R(
            c,
            45,
            184,
            W - 45,
            30,
            "#244a70"
        )
        __L1:R(
            c,
            45,
            184,
            W - 45,
            2,
            "#132d4a"
        )
        __L1:R(
            c,
            45,
            186,
            W - 45,
            1,
            "#3a6a94"
        )
        do
            local x = 45
            while x < W do
                __L1:R(
                    c,
                    x,
                    187,
                    1,
                    27,
                    "#1d3f61"
                )
                x = x + 10
            end
        end
        __L1:R(
            c,
            45,
            200,
            W - 45,
            1,
            "#1d3f61"
        )
        __L1:R(
            c,
            40,
            111,
            5,
            103,
            "#173755"
        )
        local function busy(____, x, w)
            local ____t_result_159
            local ____t_158 = __t
            local ____call_result_157 = __call(
                __L1.SC_BUSY,
                "some",
                function(____, ____bindingPattern0)
                    local b
                    local a
                    a = ____bindingPattern0[1]
                    b = ____bindingPattern0[2]
                    return __gt(
                        __add(x, w),
                        a
                    ) and __lt(x, b)
                end
            )
            __O[313] = ____call_result_157
            if ____t_158(____call_result_157) then
                ____t_result_159 = __O[313]
            else
                ____t_result_159 = __gt(
                    __add(x, w),
                    W - 82
                )
            end
            return ____t_result_159
        end
        do
            local i = 0
            while i < 12 do
                local x = 70 + i * 68.5
                if not __t(busy(nil, x, 41)) then
                    __L1:win(
                        c,
                        l,
                        x,
                        133,
                        41,
                        39,
                        __L1:hash(i + 61) > 0.45
                    )
                end
                i = i + 1
            end
        end
        do
            local x = 950
            while x < W - 50 do
                if not __t(busy(nil, x, 46)) then
                    __L1:win(
                        c,
                        l,
                        x,
                        135,
                        46,
                        36,
                        __L1:hash(x + 71) > 0.45
                    )
                end
                x = x + 90
            end
        end
        do
            local x = 60
            while x < W do
                __L1:R(
                    c,
                    x,
                    118,
                    6,
                    96,
                    "#b3cbd8"
                )
                __L1:R(
                    c,
                    x + 1,
                    118,
                    2,
                    96,
                    "#f9fcff"
                )
                __L1:R(
                    c,
                    x + 5,
                    118,
                    1,
                    96,
                    "#8ea9b8"
                )
                __L1:R(
                    c,
                    x - 1,
                    211,
                    8,
                    3,
                    "#8ea9b8"
                )
                x = x + 137.5
            end
        end
        __L1:R(
            c,
            169,
            144,
            42,
            70,
            "#6a563c"
        )
        __L1:R(
            c,
            171,
            146,
            38,
            68,
            "#8f7657"
        )
        __L1:R(
            c,
            174,
            149,
            32,
            65,
            "#526661"
        )
        __L1:R(
            c,
            176,
            152,
            12,
            42,
            "#6e8980"
        )
        __L1:R(
            c,
            192,
            152,
            12,
            42,
            "#5e7770"
        )
        do
            local k = 0
            while k < 30 do
                __L1:R(
                    c,
                    178 + math.floor((30 - k) * 0.25 + 0.5),
                    154 + k,
                    3,
                    1,
                    "rgba(255,255,255,.22)"
                )
                k = k + 1
            end
        end
        __L1:R(
            c,
            189,
            149,
            2,
            65,
            "#b49d75"
        )
        __L1:R(
            c,
            186,
            181,
            2,
            2,
            "#efd49a"
        )
        __L1:R(
            c,
            192,
            181,
            2,
            2,
            "#efd49a"
        )
        __L1:R(
            c,
            165,
            214,
            50,
            2,
            "#c9c4a4"
        )
        __L1:R(
            c,
            162,
            216,
            56,
            2,
            "#b6b18a"
        )
        __L1:board(
            c,
            128,
            121,
            126,
            15,
            "#183c62",
            "#0e2a44"
        )
        __L1:R(
            c,
            129,
            136,
            124,
            1,
            "#7fb4cf"
        )
        __L1:R(
            c,
            186,
            139,
            8,
            4,
            "#2a3a3c"
        )
        __L1:R(
            c,
            187,
            143,
            6,
            1,
            "#ffe9a8"
        )
        __L1:R(
            c,
            942,
            140,
            212,
            77,
            "#d3c69a"
        )
        __L1:R(
            c,
            942,
            140,
            212,
            4,
            "#867b5e"
        )
        __L1:R(
            c,
            942,
            140,
            212,
            1,
            "#a89c7c"
        )
        do
            local j = 0
            while j < 9 do
                do
                    local i = 0
                    while i < 9 do
                        __L1:R(
                            c,
                            946 + i * 24 + __mod(j, 2) * 11,
                            147 + j * 8,
                            20,
                            1,
                            "#b7a981"
                        )
                        i = i + 1
                    end
                end
                j = j + 1
            end
        end
        do
            local i = 0
            while i < 14 do
                local hx = 950 + __L1:hash(i + 81) * 190
                local hy = 186 + __L1:hash(i + 82) * 18
                local col = __get(
                    __arrL({
                        "#d86a5a",
                        "#5a9ad8",
                        "#e8c84a",
                        "#6ab86a",
                        "#b87ad8"
                    }, 5),
                    __mod(i, 5)
                )
                __L1:R(
                    c,
                    hx,
                    hy,
                    5,
                    5,
                    col
                )
                do
                    local f = 0
                    while f < 4 do
                        __L1:R(
                            c,
                            hx + f * 1.4,
                            hy - 3,
                            1,
                            3,
                            col
                        )
                        f = f + 1
                    end
                end
                __L1:R(
                    c,
                    hx - 2,
                    hy + 1,
                    2,
                    2,
                    col
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 7 do
                __L1:bench(
                    c,
                    310 + i * 105,
                    204,
                    34,
                    "#a58859",
                    "#c9aa76"
                )
                i = i + 1
            end
        end
        __L1:R(
            c,
            487,
            153,
            17,
            4,
            "#8f8c70"
        )
        __L1:R(
            c,
            488,
            155,
            15,
            61,
            "#b9aa85"
        )
        __L1:R(
            c,
            488,
            155,
            4,
            61,
            "#f0dfb0"
        )
        __L1:R(
            c,
            492,
            158,
            10,
            56,
            "#dcc99b"
        )
        __L1:R(
            c,
            488,
            199,
            15,
            17,
            "#ad7153"
        )
        for ____, yy in __iterar((__arrL({163, 175, 187}, 3))) do
            __L1:R(
                c,
                493,
                yy,
                6,
                1,
                "#b6a67f"
            )
        end
        __L1:board(
            c,
            506,
            161,
            54,
            29,
            "#e2d9ae",
            "#6f8a72"
        )
        __L1:R(
            c,
            529,
            185,
            5,
            1,
            "#8c9b6b"
        )
        __L1:bush(c, 1160, 45)
        __L1:bush(c, 32, 28)
        __L1:R(
            c,
            832,
            199,
            14,
            19,
            "#54735b"
        )
        __L1:R(
            c,
            830,
            197,
            18,
            4,
            "#73906a"
        )
        __L1:R(
            c,
            835,
            203,
            2,
            13,
            "#a3ad79"
        )
        for ____, ____value in __iterar((__L1.SC_DOORS)) do
            local x = ____value[1]
            local en = ____value[2]
            local ac = __t(en) and "#796080" or "#527f93"
            local pn = __t(en) and "#93868d" or "#7f9ba1"
            __L1:R(
                c,
                x - 27,
                134,
                54,
                82,
                "#806d54"
            )
            __L1:R(
                c,
                x - 25,
                136,
                50,
                79,
                ac
            )
            __L1:R(
                c,
                x - 22,
                140,
                44,
                75,
                "#38595d"
            )
            __L1:R(
                c,
                x - 20,
                142,
                40,
                72,
                pn
            )
            __L1:R(
                c,
                x - 20,
                142,
                1,
                72,
                "rgba(255,255,255,.25)"
            )
            __L1:R(
                c,
                x - 16,
                147,
                32,
                36,
                "#bccbd1"
            )
            __L1:R(
                c,
                x - 14,
                149,
                28,
                32,
                "#d8e3d9"
            )
            do
                local k = 0
                while k < 26 do
                    __L1:R(
                        c,
                        x - 10 + math.floor((26 - k) * 0.3 + 0.5),
                        151 + k,
                        3,
                        1,
                        "rgba(255,255,255,.4)"
                    )
                    k = k + 1
                end
            end
            __L1:R(
                c,
                x - 1,
                147,
                2,
                36,
                ac
            )
            __L1:R(
                c,
                x - 16,
                165,
                32,
                2,
                ac
            )
            __L1:R(
                c,
                x + 13,
                193,
                3,
                3,
                "#f1d896"
            )
            __L1:R(
                c,
                x - 24,
                212,
                48,
                4,
                "#c9b792"
            )
            __L1:board(
                c,
                x - 38,
                120,
                76,
                13,
                ac,
                "#2a3a44"
            )
            if __L1:hash(x) > 0.2 then
                l.fillStyle = "#ffe2a0"
                l:fillRect(x - 14, 149, 28, 32)
            end
        end
        for ____, x in __iterar((__L1.SC_SKETCH)) do
            __L1:R(
                c,
                x - 29,
                131,
                56,
                45,
                "#8a8672"
            )
            __L1:R(
                c,
                x - 28,
                132,
                54,
                44,
                "#d4cfb5"
            )
            do
                local k = 0
                while k < 54 do
                    __L1:R(
                        c,
                        x - 28 + k,
                        176,
                        3,
                        1 + math.floor(__L1:hash(k + x) * 3 + 0.5),
                        "#d4cfb5"
                    )
                    k = k + 3
                end
            end
            __L1:R(
                c,
                x - 20,
                138,
                38,
                1,
                "#a7a296"
            )
            __L1:R(
                c,
                x - 24,
                132,
                1,
                44,
                "#c8a0a0"
            )
            __L1:R(
                c,
                x - 6,
                129,
                10,
                4,
                "rgba(240,230,170,.8)"
            )
        end
        for ____, x in __iterar((__L1.SC_BOARDS)) do
            __L1:R(
                c,
                x - 1,
                130,
                88,
                54,
                "#4a4636"
            )
            __L1:R(
                c,
                x,
                131,
                86,
                52,
                "#6e6951"
            )
            __L1:R(
                c,
                x + 2,
                134,
                82,
                46,
                "#3f7a74"
            )
            do
                local i = 0
                while i < 90 do
                    __L1:R(
                        c,
                        x + 3 + __L1:hash(i + x) * 79,
                        135 + __L1:hash(i + x + 2) * 43,
                        2,
                        1,
                        __t(__mod(i, 2)) and "#478880" or "#376e68"
                    )
                    i = i + 1
                end
            end
            __L1:R(
                c,
                x + 2,
                134,
                82,
                1,
                "#5aa39a"
            )
            __L1:R(
                c,
                x + 5,
                180,
                76,
                2,
                "#85977a"
            )
            __L1:R(
                c,
                x + 8,
                178,
                8,
                2,
                "#f3f0e2"
            )
            __L1:R(
                c,
                x + 66,
                177,
                10,
                3,
                "#c9b28a"
            )
        end
        do
            local x = 1350
            while x < W - 100 do
                __L1:bench(
                    c,
                    x,
                    205,
                    29,
                    "#977343",
                    "#bb9560"
                )
                __L1:bush(c, x + 57, 24)
                x = x + 235
            end
        end
        local ex = W - 75
        __L1:R(
            c,
            ex - 1,
            141,
            51,
            75,
            "#2f4a44"
        )
        __L1:R(
            c,
            ex,
            142,
            49,
            73,
            "#52736a"
        )
        __L1:R(
            c,
            ex + 2,
            146,
            44,
            66,
            "#8ba997"
        )
        __L1:R(
            c,
            ex + 24,
            146,
            1,
            66,
            "#52736a"
        )
        __L1:R(
            c,
            ex + 19,
            180,
            2,
            3,
            "#f1d896"
        )
        __L1:R(
            c,
            ex + 27,
            180,
            2,
            3,
            "#f1d896"
        )
        __L1:R(
            c,
            ex + 6,
            150,
            36,
            11,
            "#3d5a52"
        )
        __L1:paving(
            c,
            W,
            "#97856e",
            "#8a7862",
            "#7a6a56",
            "#c4b08a",
            40
        )
        __L1:R(
            c,
            140,
            150,
            2,
            66,
            "#4a5a68"
        )
        __L1:R(
            c,
            116,
            142,
            50,
            16,
            "#f2f2ee"
        )
        __L1:R(
            c,
            117,
            143,
            48,
            14,
            "#1f4fa8"
        )
        __L1:R(
            c,
            117,
            143,
            48,
            1,
            "#5a8ad8"
        )
        __L1:R(
            c,
            115,
            160,
            52,
            8,
            "#f2f2ee"
        )
        __L1:R(
            c,
            116,
            161,
            50,
            6,
            "#2a2a2a"
        )
        do
            local x = 1700
            while x <= 2000 do
                local u = (x - 1700) / 300
                local y = math.floor(107 - math.sin(u * math.pi) * 34 + 0.5)
                __L1:R(
                    c,
                    x,
                    y,
                    1,
                    107 - y,
                    __mod(x, 12) < 1 and "#8a96a4" or "#b8c4d0"
                )
                __L1:R(
                    c,
                    x,
                    y,
                    1,
                    1,
                    "#e8eef4"
                )
                x = x + 1
            end
        end
        __L1:R(
            c,
            1800,
            82,
            100,
            12,
            "#183a5e"
        )
        __L1:R(
            c,
            1801,
            83,
            98,
            10,
            "#24507a"
        )
        for ____, x in __iterar((__arrL({2508, 2688, 2868, 3018}, 4))) do
            do
                if x + 56 > W then
                    continue
                end
                __L1:R(
                    c,
                    x - 6,
                    121,
                    58,
                    11,
                    "#0e2a44"
                )
                __L1:R(
                    c,
                    x - 5,
                    122,
                    56,
                    9,
                    "#183c62"
                )
                __L1:R(
                    c,
                    x - 5,
                    122,
                    56,
                    1,
                    "#7fb4cf"
                )
            end
        end
        do
            local x = 2620
            __L1:R(
                c,
                x,
                168,
                3,
                52,
                "#c43c3a"
            )
            __L1:R(
                c,
                x + 14,
                168,
                3,
                52,
                "#c43c3a"
            )
            do
                local y = 172
                while y < 218 do
                    __L1:R(
                        c,
                        x,
                        y,
                        17,
                        2,
                        "#e8c24a"
                    )
                    y = y + 7
                end
            end
            __L1:R(
                c,
                x - 2,
                166,
                22,
                4,
                "#3a7ad0"
            )
            do
                local k = 0
                while k < 40 do
                    __L1:R(
                        c,
                        x + 18 + k,
                        168 + k * 1.2,
                        2,
                        4,
                        "#e8c24a"
                    )
                    k = k + 1
                end
            end
            __L1:R(
                c,
                x + 56,
                214,
                10,
                4,
                "#e8c24a"
            )
        end
        do
            local x = 2856
            __L1:R(
                c,
                x,
                166,
                3,
                54,
                "#3a7ad0"
            )
            __L1:R(
                c,
                x + 58,
                166,
                3,
                54,
                "#3a7ad0"
            )
            __L1:R(
                c,
                x,
                164,
                61,
                4,
                "#2a5aa8"
            )
            for ____, sx in __iterar((__arrL({x + 14, x + 38}, 2))) do
                __L1:R(
                    c,
                    sx,
                    168,
                    1,
                    28,
                    "#7a8086"
                )
                __L1:R(
                    c,
                    sx + 8,
                    168,
                    1,
                    28,
                    "#7a8086"
                )
                __L1:R(
                    c,
                    sx - 1,
                    196,
                    11,
                    3,
                    "#c43c3a"
                )
            end
        end
        return __arrL({cv, lv}, 2)
    end
    __L1.school = function(self, c, s, t, camL)
        if not __t(__get(__L1.mids, 1)) then
            __set(
                __L1.mids,
                1,
                __L1:buildSchoolMid()
            )
        end
        local sun = __L1:backdrop(
            c,
            s,
            t,
            camL,
            __arrL({43, 104}, 2)
        )
        __L1:tile(
            c,
            __get(__L1.far, 2),
            camL * 0.22 + 200,
            0.22
        )
        __L1:R(
            c,
            0,
            186,
            __L1.LW,
            12,
            "#7fa86a"
        )
        c:drawImage(
            __get(
                __get(__L1.mids, 1),
                0
            ),
            camL,
            0,
            __L1.LW,
            __L1.LH,
            0,
            0,
            __L1.LW,
            __L1.LH
        )
        if sun.str > 0.04 then
            local el = 1 - math.abs(sun.lean)
            local dep = math.floor(3 + el * 9 + 0.5)
            local reach = sun.lean * (12 + math.abs(sun.lean) * 26)
            local sh = ("rgba(14,24,50," .. tostring(0.24 * sun.str)) .. ")"
            __L1:R(
                c,
                math.max(0, 45 - camL),
                118,
                __L1.LW,
                dep,
                ("rgba(14,24,50," .. tostring(0.2 * sun.str)) .. ")"
            )
            do
                local x = math.floor(camL / 137.5) * 137.5 + 60 - 137.5
                while __lt(x, camL + __L1.LW + 40) do
                    local sx = x - camL + (sun.lean >= 0 and 6 or -math.floor(math.abs(reach) * 0.3 + 0.5))
                    __L1:R(
                        c,
                        sx,
                        118,
                        math.max(
                            1,
                            math.floor(math.abs(reach) * 0.3 + 0.5)
                        ),
                        96,
                        ("rgba(14,24,50," .. tostring(0.13 * sun.str)) .. ")"
                    )
                    x = x + 137.5
                end
            end
            do
                local i = 0
                while i < 7 do
                    local x = 310 + i * 105 - camL
                    if __t(x > -80 and x < __L1.LW + 40) then
                        __L1:slant(
                            c,
                            x,
                            x + 34,
                            219,
                            reach,
                            3,
                            sh
                        )
                    end
                    i = i + 1
                end
            end
        end
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({20, 0.9}, 2),
                __arrL({1190, 1.1}, 2)
            },
            2
        ))) do
            local tx = ____value[1]
            local sc = ____value[2]
            local x = tx - camL
            if __t(x > -80 and x < __L1.LW + 80) then
                if sun.str > 0.04 then
                    __L1:ell(
                        c,
                        x + sun.lean * 30 * sc,
                        220,
                        24 * sc,
                        3,
                        ("rgba(14,24,50," .. tostring(0.24 * sun.str)) .. ")"
                    )
                end
                local ____L1_tree_162 = __L1.tree
                local ____array_161 = __TS__SparseArrayNew(
                    c,
                    x,
                    217,
                    sc,
                    0,
                    t,
                    tx
                )
                local ____temp_160
                if sun.lean >= 0 then
                    ____temp_160 = math.max(0.35, sun.lean)
                else
                    ____temp_160 = math.min(-0.35, sun.lean)
                end
                __TS__SparseArrayPush(____array_161, ____temp_160)
                ____L1_tree_162(
                    __L1,
                    __TS__SparseArraySpread(____array_161)
                )
            end
        end
    end
    __L1.schoolText = function(self, c, camera)
        local W = __L1:worldW(1)
        c:save()
        c:translate(
            -math.floor(camera + 0.5),
            0
        )
        c.textAlign = "center"
        c.textBaseline = "middle"
        local function vis(____, x)
            return __gt(x, camera - 260) and __lt(x, camera + 1220)
        end
        c.font = "16px Pixel, monospace"
        c.fillStyle = "#f8fbfc"
        c:fillText("COLÉGIO ADVENTISTA", 382, 258)
        c.fillStyle = "#52766b"
        if __t(vis(nil, 2096)) then
            c:fillText("BEM-VINDOS", 2096, 314)
        end
        c.fillStyle = "#dfe6bb"
        if __t(vis(nil, (W - 51) * 2)) then
            c:fillText("SAÍDA", (W - 51) * 2, 312)
        end
        c.font = "8px Pixel, monospace"
        c.fillStyle = "#b27857"
        if __t(vis(nil, 2096)) then
            c:fillText("AQUI ATÉ A PAREDE TEM HISTÓRIA.", 2096, 334)
        end
        c.font = "8px Pixel, monospace"
        c.fillStyle = "#ffffff"
        if __t(vis(nil, 282)) then
            c.font = "7px Pixel, monospace"
            c:fillText("R. ALMIRANTE BARROSO", 282, 300)
            c:fillText("261 · CENTRO", 282, 328)
            c.font = "8px Pixel, monospace"
        end
        c.fillStyle = "#f2f2ee"
        if __t(vis(nil, 3700)) then
            c:fillText("QUADRA COBERTA", 3700, 176)
        end
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({2508, "BIBLIOTECA"}, 2),
                __arrL({2688, "LABORATÓRIO"}, 2),
                __arrL({2868, "AUDITÓRIO"}, 2),
                __arrL({3018, "SALA DE LEITURA"}, 2)
            },
            4
        ))) do
            local x = ____value[1]
            local nome = ____value[2]
            local ____t_166 = __t
            local ____t_result_165
            local ____t_164 = __t
            local ____vis_result_163 = vis(nil, x * 2)
            __O[314] = ____vis_result_163
            if ____t_164(____vis_result_163) then
                ____t_result_165 = __le(x + 56, W)
            else
                ____t_result_165 = __O[314]
            end
            if ____t_166(____t_result_165) then
                c:fillText(nome, (x + 23) * 2, 253)
            end
        end
        c.fillStyle = "#183c62"
        if __t(vis(nil, 5300)) then
            c:fillText("PARQUINHO", 5300, 358)
        end
        c.fillStyle = "#54735f"
        c:fillText("A PAREDE ESCUTA", 1066, 342)
        c:fillText("MAIS DO QUE FALA.", 1066, 356)
        c.fillStyle = "#fff1cb"
        for ____, ____value in __iterar((__L1.SC_DOORS)) do
            local x = ____value[1]
            local en = ____value[2]
            if __t(vis(nil, x * 2)) then
                c:fillText(
                    __t(en) and "SALA · MIQUEIAS" or "SALA · ALMIRO",
                    x * 2,
                    254
                )
            end
        end
        __call(
            __L1.SC_SKETCH,
            "forEach",
            function(____, x, i)
                if not __t(vis(nil, x * 2)) then
                    return
                end
                c.fillStyle = "#675975"
                c:fillText(
                    __get(__L1.SC_CAPS, i),
                    x * 2 - 2,
                    374
                )
                local ____t_169 = __t
                local ____opt_167 = window.Art
                if ____opt_167 ~= nil then
                    ____opt_167 = ____opt_167.drawDoodle
                end
                if ____t_169(____opt_167) then
                    c:save()
                    c:translate(x * 2 - 2, 318)
                    c:scale(1.2, 1.2)
                    do
                        pcall(function()
                            window.Art:drawDoodle(
                                c,
                                0,
                                0,
                                __mod(i, 3),
                                __L1.lastT * 0.35 + i,
                                false
                            )
                        end)
                    end
                    c:restore()
                end
            end
        )
        __call(
            __L1.SC_BOARDS,
            "forEach",
            function(____, x, i)
                if not __t(vis(nil, x * 2)) then
                    return
                end
                c.fillStyle = "#e8f4ee"
                local words = __call(
                    __get(__L1.SC_PHRASES, i),
                    "split",
                    " "
                )
                local line = ""
                local yy = 300
                for ____, w in __iterar((words)) do
                    if __len(__add(line, w)) > 14 then
                        c:fillText(
                            __call(
                                __call(line, "trim"),
                                "toUpperCase"
                            ),
                            (x + 43) * 2,
                            yy
                        )
                        line = ""
                        yy = yy + 18
                    end
                    line = __add(
                        line,
                        __add(w, " ")
                    )
                end
                c:fillText(
                    __call(
                        __call(line, "trim"),
                        "toUpperCase"
                    ),
                    (x + 43) * 2,
                    yy
                )
            end
        )
        c:restore()
    end
    __L1.schoolLights = function(self, g, s, t, camL)
        local a = __L1:cl((s.night - 0.12) * 1.4)
        if a < 0.02 then
            return
        end
        g:save()
        g:beginPath()
        g:rect(0, 0, __L1.LW, 106)
        g:clip()
        g.globalAlpha = a
        __L1:tile(
            g,
            __get(
                __L1:city(43, 104),
                1
            ),
            camL * 0.07,
            0.07
        )
        g:restore()
        g.globalAlpha = a * 0.4
        g:drawImage(
            __get(
                __get(__L1.mids, 1),
                1
            ),
            camL,
            0,
            __L1.LW,
            __L1.LH,
            0,
            0,
            __L1.LW,
            __L1.LH
        )
        g.globalAlpha = 1
        __L1:lampGlow(
            g,
            190 - camL,
            143,
            a,
            "255,226,160",
            60
        )
        for ____, ____value in __iterar((__L1.SC_DOORS)) do
            local x = ____value[1]
            __L1:lampGlow(
                g,
                x - camL,
                134,
                a * 0.8,
                "255,226,160",
                52
            )
        end
    end
    __L1.buildPlazaBack = function(self)
        local T = 956
        local D = __L1:mk(T, 196)
        local L = __L1:mk(T, 196)
        do
            local i = 0
            while i < 7 do
                local x = math.floor(i * 136.5 + 0.5)
                local h = math.floor(35 + __L1:hash(i + 83) * 30 + 0.5)
                local y = 125 - h
                local col = __get(
                    __arrL({"#bfd3d2", "#c9d6c8", "#b5cad0", "#d0d2c0"}, 4),
                    __mod(i, 4)
                )
                __L1:R(
                    __get(D, 1),
                    x,
                    y,
                    110,
                    h,
                    col
                )
                __L1:R(
                    __get(D, 1),
                    x,
                    y,
                    110,
                    1,
                    "#eef4ee"
                )
                __L1:R(
                    __get(D, 1),
                    x + 3,
                    y + 4,
                    104,
                    4,
                    "#e2ece6"
                )
                __L1:R(
                    __get(D, 1),
                    x,
                    y,
                    2,
                    h,
                    "rgba(255,255,255,.3)"
                )
                __L1:R(
                    __get(D, 1),
                    x + 106,
                    y,
                    4,
                    h,
                    "rgba(30,60,80,.18)"
                )
                do
                    local r2 = 0
                    while r2 * 17 + 12 < h - 6 do
                        do
                            local k = 0
                            while k < 6 do
                                local wx = x + 8 + k * 17
                                local wy = y + 12 + r2 * 17
                                __L1:R(
                                    __get(D, 1),
                                    wx,
                                    wy,
                                    9,
                                    12,
                                    "#7b9da5"
                                )
                                __L1:R(
                                    __get(D, 1),
                                    wx,
                                    wy,
                                    9,
                                    4,
                                    "#b8d8dd"
                                )
                                __L1:R(
                                    __get(D, 1),
                                    wx + 4,
                                    wy,
                                    1,
                                    12,
                                    "#e2ece6"
                                )
                                if __L1:hash(i * 9 + k + r2 * 5) > 0.5 then
                                    __get(L, 1).fillStyle = "#ffe2a0"
                                    __get(L, 1):fillRect(wx, wy, 9, 12)
                                end
                                k = k + 1
                            end
                        end
                        r2 = r2 + 1
                    end
                end
                if __t(__mod(i, 2)) then
                    __L1:R(
                        __get(D, 1),
                        x + 20,
                        y - 6,
                        14,
                        6,
                        "#8faeb0"
                    )
                    __L1:R(
                        __get(D, 1),
                        x + 70,
                        y - 10,
                        1,
                        10,
                        "#6f8f92"
                    )
                end
                __L1:R(
                    __get(D, 1),
                    x,
                    121,
                    110,
                    4,
                    "#8faeb0"
                )
                i = i + 1
            end
        end
        do
            local x = 0
            while x < T do
                __L1:ell(
                    __get(D, 1),
                    x + 4,
                    124,
                    6,
                    4,
                    __t(__mod(x, 18)) and "#5f9a6a" or "#4f8a5c"
                )
                x = x + 9
            end
        end
        __L1:R(
            __get(D, 1),
            0,
            126,
            T,
            4,
            "#6f9a7a"
        )
        return __arrL(
            {
                __get(D, 0),
                __get(L, 0)
            },
            2
        )
    end
    __L1.buildPlazaMid = function(self)
        local W = __L1:worldW(4)
        local cv, c = table.unpack(
            __L1:mk(W, __L1.LH),
            1,
            2
        )
        __L1:R(
            c,
            0,
            177,
            W,
            43,
            "#cbd0bb"
        )
        do
            local y = 180
            while y < 220 do
                do
                    local x = __band(y / 4, 1) * 4
                    while x < W do
                        __L1:R(
                            c,
                            x,
                            y,
                            4,
                            4,
                            "rgba(90,100,90,.10)"
                        )
                        x = x + 8
                    end
                end
                y = y + 4
            end
        end
        do
            local x = 0
            while x < W do
                do
                    local k = 0
                    while k < 24 do
                        local yy = 186 + math.floor(math.sin(k / 24 * 6.28) * 5 + 0.5)
                        __L1:R(
                            c,
                            x + k * 2.6,
                            yy + 12,
                            2,
                            2,
                            "#5a6660"
                        )
                        __L1:R(
                            c,
                            x + k * 2.6,
                            yy + 22,
                            2,
                            2,
                            "#5a6660"
                        )
                        k = k + 1
                    end
                end
                x = x + 64
            end
        end
        __L1:R(
            c,
            0,
            176,
            W,
            3,
            "#edf0d7"
        )
        __L1:R(
            c,
            0,
            176,
            W,
            1,
            "#ffffff"
        )
        do
            local x = 0
            while x < W do
                __L1:R(
                    c,
                    x,
                    164,
                    3,
                    26,
                    "#697f79"
                )
                __L1:R(
                    c,
                    x,
                    164,
                    1,
                    26,
                    "#9ab0a8"
                )
                __L1:R(
                    c,
                    x - 1,
                    162,
                    5,
                    2,
                    "#4f655f"
                )
                x = x + 160
            end
        end
        __L1:R(
            c,
            0,
            165,
            W,
            2,
            "#9aa995"
        )
        __L1:R(
            c,
            0,
            165,
            W,
            1,
            "#c8d4c0"
        )
        __L1:R(
            c,
            0,
            174,
            W,
            2,
            "#91a38e"
        )
        do
            local x = 0
            while x < W do
                __L1:R(
                    c,
                    x,
                    167,
                    1,
                    7,
                    "#8a9c88"
                )
                x = x + 8
            end
        end
        do
            local x = 80
            while x < W do
                __L1:bush(c, x + 37, 38)
                __L1:bench(
                    c,
                    x + 68,
                    204,
                    56,
                    "#c39b65",
                    "#e0bd88"
                )
                __L1:R(
                    c,
                    x + 88,
                    191,
                    8,
                    9,
                    __get(
                        __L1.FAN_SHIRT,
                        __mod(
                            math.floor(x / 285),
                            6
                        )
                    )
                )
                __L1:R(
                    c,
                    x + 89,
                    185,
                    6,
                    6,
                    __get(
                        __L1.FAN_SKIN,
                        __mod(
                            math.floor(x / 285),
                            5
                        )
                    )
                )
                __L1:R(
                    c,
                    x + 89,
                    184,
                    6,
                    2,
                    __get(
                        __L1.FAN_HAIR,
                        __mod(
                            math.floor(x / 285),
                            5
                        )
                    )
                )
                __L1:R(
                    c,
                    x + 88,
                    200,
                    4,
                    8,
                    "#3a4a6a"
                )
                __L1:R(
                    c,
                    x + 92,
                    200,
                    4,
                    8,
                    "#3a4a6a"
                )
                x = x + 285
            end
        end
        for ____, x in __iterar((__L1.PZ_FOUNT)) do
            __L1:ell(
                c,
                x,
                213,
                56,
                8,
                "#698d89"
            )
            __L1:ell(
                c,
                x,
                209,
                52,
                9,
                "#d7d4b8"
            )
            __L1:ell(
                c,
                x,
                208,
                50,
                8,
                "#eeebd2"
            )
            __L1:ell(
                c,
                x,
                205,
                46,
                7,
                "#77bbca"
            )
            __L1:ell(
                c,
                x,
                205,
                37,
                4,
                "#a5dce2"
            )
            __L1:R(
                c,
                x - 4,
                171,
                9,
                33,
                "#d9d9bd"
            )
            __L1:R(
                c,
                x - 4,
                171,
                3,
                33,
                "#f2f2dc"
            )
            __L1:R(
                c,
                x + 3,
                171,
                2,
                33,
                "#b0b098"
            )
            __L1:ell(
                c,
                x,
                171,
                29,
                4,
                "#d9d9bd"
            )
            __L1:ell(
                c,
                x,
                168,
                25,
                3,
                "#82c6cf"
            )
            __L1:R(
                c,
                x - 2,
                147,
                4,
                20,
                "#ecedcf"
            )
            __L1:ell(
                c,
                x,
                147,
                10,
                3,
                "#e5e7cd"
            )
        end
        for ____, x in __iterar((__L1.PZ_KIOSK)) do
            __L1:R(
                c,
                x - 1,
                156,
                87,
                64,
                "#8a7a5a"
            )
            __L1:R(
                c,
                x,
                157,
                85,
                62,
                "#efdfb5"
            )
            do
                local i = 0
                while i < 80 do
                    __L1:R(
                        c,
                        x + 2 + __L1:hash(i + x) * 81,
                        160 + __L1:hash(i + x + 3) * 56,
                        2,
                        1,
                        __t(__mod(i, 2)) and "#e3d2a4" or "#f8ecc8"
                    )
                    i = i + 1
                end
            end
            do
                local k = 0
                while k < 97 do
                    __L1:R(
                        c,
                        x - 6 + k,
                        152,
                        8,
                        8,
                        __t(__mod(k / 8, 2)) and "#274d61" or "#f3ead6"
                    )
                    __L1:R(
                        c,
                        x - 6 + k,
                        160,
                        8,
                        2,
                        __t(__mod(k / 8, 2)) and "#1a3848" or "#cfc5ae"
                    )
                    k = k + 8
                end
            end
            __L1:R(
                c,
                x - 6,
                151,
                97,
                1,
                "#3a6a84"
            )
            __L1:R(
                c,
                x + 4,
                163,
                77,
                7,
                "#305a6c"
            )
            __L1:R(
                c,
                x + 7,
                175,
                70,
                31,
                "#4c898c"
            )
            __L1:R(
                c,
                x + 9,
                177,
                66,
                26,
                "#89b9b6"
            )
            do
                local k = 0
                while k < 20 do
                    __L1:R(
                        c,
                        x + 14 + math.floor((20 - k) * 0.5 + 0.5),
                        179 + k,
                        4,
                        1,
                        "rgba(255,255,255,.25)"
                    )
                    k = k + 1
                end
            end
            __L1:R(
                c,
                x + 6,
                206,
                72,
                4,
                "#c79860"
            )
            __L1:R(
                c,
                x + 6,
                206,
                72,
                1,
                "#e8bd84"
            )
            do
                local i = 0
                while i < 3 do
                    __L1:R(
                        c,
                        x + 14 + i * 22,
                        187,
                        11,
                        15,
                        "#9b694b"
                    )
                    __L1:R(
                        c,
                        x + 15 + i * 22,
                        186,
                        8,
                        2,
                        "#d9ac69"
                    )
                    __L1:R(
                        c,
                        x + 16 + i * 22,
                        191,
                        6,
                        5,
                        "#f3ead6"
                    )
                    i = i + 1
                end
            end
            __L1:R(
                c,
                x + 41,
                196,
                6,
                7,
                __get(__L1.FAN_SKIN, 1)
            )
            __L1:R(
                c,
                x + 41,
                195,
                6,
                2,
                __get(__L1.FAN_HAIR, 0)
            )
            __L1:R(
                c,
                x + 39,
                203,
                10,
                3,
                "#f0f0f0"
            )
        end
        __L1:board(
            c,
            177,
            148,
            108,
            22,
            "#dbe8df",
            "#214e66"
        )
        __L1:R(
            c,
            195,
            170,
            3,
            49,
            "#3c6a76"
        )
        __L1:R(
            c,
            264,
            170,
            3,
            49,
            "#3c6a76"
        )
        for ____, x in __iterar((__L1.PZ_LAMPS)) do
            if x < W then
                __L1:lampPost(c, x, 131)
            end
        end
        do
            local x = 240
            while x < W do
                __L1:R(
                    c,
                    x,
                    205,
                    10,
                    14,
                    "#3f8a52"
                )
                __L1:R(
                    c,
                    x - 1,
                    203,
                    12,
                    3,
                    "#57a86a"
                )
                __L1:R(
                    c,
                    x + 3,
                    209,
                    4,
                    4,
                    "#e9f2e0"
                )
                x = x + 410
            end
        end
        __L1:paving(
            c,
            W,
            "#aeb8b5",
            "#9faaa7",
            "#899c9b",
            "#e0ded0",
            26.5
        )
        return cv
    end
    __L1.plaza = function(self, c, s, t, camL)
        if not __t(__get(__L1.mids, 4)) then
            __set(
                __L1.mids,
                4,
                __L1:buildPlazaMid()
            )
        end
        if not __t(__L1.plazaBack) then
            __L1.plazaBack = __L1:buildPlazaBack()
        end
        if not __t(__L1.far) then
            __L1.far = __L1:buildFar()
        end
        local sun = __L1:sunInfo(s)
        local la = math.min(
            1,
            math.abs(sun.lean) * 1.3
        ) * sun.str
        __L1:sky(c, s, t, camL)
        __L1:tile(
            c,
            __get(__L1.far, 0),
            camL * 0.04,
            0.04
        )
        if la > 0.03 then
            c.globalAlpha = la
            __L1:tile(
                c,
                __get(
                    __get(__L1.far, sun.lean >= 0 and 3 or 4),
                    0
                ),
                camL * 0.04,
                0.04
            )
            c.globalAlpha = 1
        end
        __L1:tile(
            c,
            __get(__L1.plazaBack, 0),
            camL * 0.28,
            0.28
        )
        do
            local i = 0
            while i < 10 do
                __L1:R(
                    c,
                    0,
                    130 + i * 5,
                    __L1.LW,
                    5,
                    __L1:css(__L1:mix(
                        __arrL({0.39, 0.66, 0.75}, 3),
                        __arrL({0.27, 0.5, 0.64}, 3),
                        i / 9
                    ))
                )
                i = i + 1
            end
        end
        __L1:R(
            c,
            0,
            130,
            __L1.LW,
            2,
            "#badcdd"
        )
        do
            local i = 0
            while i < 48 do
                local x = __mod(
                    __mod(
                        i * 37 - camL * 0.4 + t * (4 + __mod(i, 3) * 2),
                        540
                    ) + 540,
                    540
                ) - 30
                local yy = 134 + __L1:hash(i + 51) * 42
                __L1:R(
                    c,
                    x,
                    yy,
                    9 + __L1:hash(i + 4) * 15,
                    1,
                    __t(__mod(i, 2)) and "#96d4dd" or "#83c0d1"
                )
                i = i + 1
            end
        end
        do
            local ____temp_170
            if s.sunT ~= nil then
                ____temp_170 = s.sunT
            else
                ____temp_170 = s.moonT
            end
            local T = ____temp_170
            if __t(T ~= nil and sun.str > 0.03) then
                local ____temp_171
                if s.sunT ~= nil then
                    ____temp_171 = 40 + T * 400
                else
                    ____temp_171 = 50 + T * 380
                end
                local sx = ____temp_171 - camL * 0.012
                local col = s.sunT ~= nil and "255,244,200" or "210,225,255"
                do
                    local i = 0
                    while i < 46 do
                        local yy = 132 + __mod(i, 23) * 2
                        local sp = 3 + (yy - 132) * 0.45
                        local x = sx + (__L1:hash(i + math.floor(t * 5)) - 0.5) * sp * 2
                        local w = 2 + __L1:hash(i * 3 + math.floor(t * 4)) * (3 + (yy - 132) * 0.2)
                        c.fillStyle = ((("rgba(" .. col) .. ",") .. tostring((0.35 + __L1:hash(i + math.floor(t * 6)) * 0.55) * math.min(1, sun.str * 1.4))) .. ")"
                        c:fillRect(
                            math.floor(x - w / 2 + 0.5),
                            yy,
                            math.floor(w + 0.5),
                            1
                        )
                        i = i + 1
                    end
                end
            end
        end
        do
            local bx = __mod(
                __mod(t * 6 - camL * 0.4, 700) + 700,
                700
            ) - 60
            __L1:R(
                c,
                bx,
                150,
                22,
                3,
                "#7a5a3a"
            )
            __L1:R(
                c,
                bx + 2,
                153,
                18,
                1,
                "#5a4028"
            )
            __L1:R(
                c,
                bx + 9,
                143,
                4,
                7,
                "#c8946a"
            )
            __L1:R(
                c,
                bx + 9,
                141,
                4,
                3,
                "#e8c84a"
            )
            __L1:R(
                c,
                bx + 13,
                144,
                9,
                1,
                "#5a4028"
            )
            __L1:R(
                c,
                bx - 2,
                154,
                28,
                1,
                "rgba(255,255,255,.35)"
            )
        end
        c:drawImage(
            __get(__L1.mids, 4),
            camL,
            0,
            __L1.LW,
            __L1.LH,
            0,
            0,
            __L1.LW,
            __L1.LH
        )
        local reach = sun.lean * (12 + math.abs(sun.lean) * 26)
        local sh = ("rgba(14,24,50," .. tostring(0.24 * sun.str)) .. ")"
        if sun.str > 0.04 then
            for ____, x in __iterar((__L1.PZ_LAMPS)) do
                __L1:slant(
                    c,
                    x - camL,
                    x - camL + 3,
                    219,
                    reach * 1.5,
                    5,
                    sh
                )
            end
            for ____, x in __iterar((__L1.PZ_KIOSK)) do
                local sx = x - camL
                if __t(sx > -200 and sx < __L1.LW + 120) then
                    __L1:slant(
                        c,
                        sx,
                        sx + 85,
                        219,
                        reach,
                        3,
                        sh
                    )
                    __L1:shadeAdd(sx + reach, sx + 85 + reach, 0.9)
                    __L1:sunWall(
                        c,
                        sx,
                        157,
                        85,
                        62,
                        sun.lean,
                        math.min(
                            1,
                            math.abs(sun.lean) * 1.4
                        ) * sun.str
                    )
                end
            end
            do
                local x = math.floor(camL / 160) * 160 - 160
                while __lt(x, camL + __L1.LW + 60) do
                    __L1:slant(
                        c,
                        x - camL,
                        x - camL + 3,
                        190,
                        reach * 0.8,
                        6,
                        ("rgba(14,24,50," .. tostring(0.14 * sun.str)) .. ")"
                    )
                    x = x + 160
                end
            end
        end
        do
            local x = 80
            while x < __L1:worldW(4) do
                local sx = x - camL
                if __t(sx > -70 and sx < __L1.LW + 70) then
                    if sun.str > 0.04 then
                        __L1:ell(
                            c,
                            sx + reach * 1.2,
                            219,
                            14,
                            2.5,
                            sh
                        )
                        __L1:shadeAdd(sx + reach * 1.2 - 14, sx + reach * 1.2 + 14, 0.85, true)
                    end
                    __L1:tree(
                        c,
                        sx,
                        216,
                        0.72,
                        1,
                        t,
                        x
                    )
                end
                x = x + 285
            end
        end
        for ____, x in __iterar((__L1.PZ_FOUNT)) do
            do
                local sx = x - camL
                if __t(sx < -80 or sx > __L1.LW + 80) then
                    continue
                end
                do
                    local j = 0
                    while j < 7 do
                        local a = (j - 3) / 3
                        local ph = __mod(t * 1.6 + j * 0.13, 1)
                        do
                            local k = 0
                            while k < 14 do
                                local u = k / 13
                                local px = sx + a * 24 * u
                                local py = 146 - math.sin(u * math.pi) * (14 - math.abs(a) * 5) + u * 22
                                __L1:R(
                                    c,
                                    px,
                                    py,
                                    1,
                                    2,
                                    __mod(k, 3) == math.floor(ph * 3) and "#edf8ee" or "#b7eced"
                                )
                                k = k + 1
                            end
                        end
                        __L1:R(
                            c,
                            sx + a * 24,
                            166 + ph * 3,
                            2,
                            2,
                            "#edf8ee"
                        )
                        j = j + 1
                    end
                end
                do
                    local j = 0
                    while j < 12 do
                        __L1:R(
                            c,
                            sx - 37 + j * 7,
                            204 - math.abs(math.sin(t * 3 + j)) * 3,
                            2,
                            1,
                            "#d6f2e8"
                        )
                        j = j + 1
                    end
                end
                do
                    local j = 0
                    while j < 6 do
                        __L1:R(
                            c,
                            sx - 22 + j * 9,
                            172 + __mod(t * 20 + j * 7, 30),
                            1,
                            3,
                            "rgba(210,240,240,.7)"
                        )
                        j = j + 1
                    end
                end
            end
        end
    end
    __L1.plazaText = function(self, c, camera)
        c:save()
        c:translate(
            -math.floor(camera + 0.5),
            0
        )
        c.textAlign = "center"
        c.textBaseline = "middle"
        c.font = "16px Pixel, monospace"
        c.fillStyle = "#285e76"
        c:fillText("PRAÇA CAMACAN", 462, 312)
        c.font = "8px Pixel, monospace"
        c:fillText("ITABUNA · RIO CACHOEIRA", 462, 330)
        c.fillStyle = "#f8ebc7"
        for ____, x in __iterar((__L1.PZ_KIOSK)) do
            c:fillText("CACAU & RESENHA", (x + 42) * 2, 334)
        end
        c:restore()
    end
    __L1.plazaLights = function(self, g, s, t, camL)
        local a = __L1:cl((s.night - 0.12) * 1.4)
        if a < 0.02 then
            return
        end
        g.globalAlpha = a * 0.45
        __L1:tile(
            g,
            __get(__L1.plazaBack, 1),
            camL * 0.28,
            0.28
        )
        g.globalAlpha = 1
        for ____, x in __iterar((__L1.PZ_LAMPS)) do
            __L1:lampGlow(g, x - camL + 1, 127, a)
        end
        for ____, x in __iterar((__L1.PZ_KIOSK)) do
            do
                local sx = x - camL + 42
                if __t(sx < -120 or sx > __L1.LW + 120) then
                    continue
                end
                local b = g:createRadialGradient(
                    sx,
                    190,
                    4,
                    sx,
                    192,
                    58
                )
                b:addColorStop(
                    0,
                    ("rgba(255,214,140," .. tostring(0.6 * a)) .. ")"
                )
                b:addColorStop(1, "rgba(255,214,140,0)")
                g.fillStyle = b
                g:fillRect(sx - 60, 132, 120, 120)
            end
        end
        for ____, x in __iterar((__L1.PZ_FOUNT)) do
            do
                local sx = x - camL
                if __t(sx < -90 or sx > __L1.LW + 90) then
                    continue
                end
                local b = g:createRadialGradient(
                    sx,
                    200,
                    4,
                    sx,
                    200,
                    60
                )
                b:addColorStop(
                    0,
                    ("rgba(120,220,255," .. tostring(0.45 * a)) .. ")"
                )
                b:addColorStop(1, "rgba(120,220,255,0)")
                g.fillStyle = b
                g:fillRect(sx - 60, 140, 120, 120)
            end
        end
    end
    __L1.buildInkBack = function(self)
        local A = __L1:mk(__L1.TILE, __L1.LH)
        local B = __L1:mk(__L1.TILE, __L1.LH)
        local x = 0
        local i = 0
        while x < __L1.TILE do
            local w = 14 + math.floor(__L1:hash(i + 5) * 26 + 0.5)
            local h = 70 + math.floor(__L1:hash(i + 6) * 110 + 0.5)
            local col = __get(
                __arrL({"#3a3458", "#44385f", "#352f52", "#4a3d66"}, 4),
                __mod(i, 4)
            )
            __L1:R(
                __get(A, 1),
                x,
                200 - h,
                w,
                h + 70,
                col
            )
            __L1:R(
                __get(A, 1),
                x,
                200 - h,
                1,
                h + 70,
                "rgba(255,255,255,.08)"
            )
            __L1:R(
                __get(A, 1),
                x + w - 2,
                200 - h,
                2,
                h + 70,
                "rgba(0,0,0,.2)"
            )
            __L1:R(
                __get(A, 1),
                x + 2,
                208 - h,
                w - 4,
                2,
                "#6a5a80"
            )
            __L1:R(
                __get(A, 1),
                x + 2,
                214 - h,
                w - 4,
                1,
                "#6a5a80"
            )
            if __mod(i, 3) == 0 then
                __L1:R(
                    __get(A, 1),
                    x + 3,
                    230 - h,
                    w - 6,
                    10,
                    "#584a72"
                )
            end
            x = x + (w + (__mod(i, 5) == 0 and 4 or 0))
            i = i + 1
        end
        do
            local k = 0
            while k < 4 do
                local px = k * 240 + 20
                local top = 44 + __mod(k, 3) * 18
                do
                    local r2 = 0
                    while r2 < 98 do
                        local u = r2 / 98
                        local xa = px + 18 * (1 - u)
                        local xb = px + 72 + 15 * u + 58 * (1 - u) * 0 + 58
                        __L1:R(
                            __get(B, 1),
                            xa,
                            top + r2,
                            xb - xa,
                            1,
                            "#655579"
                        )
                        r2 = r2 + 1
                    end
                end
                do
                    local j = 0
                    while j < 7 do
                        __L1:R(
                            __get(B, 1),
                            px + 26,
                            top + 16 + j * 10,
                            46 + j * 2,
                            1,
                            "#9c8bac"
                        )
                        j = j + 1
                    end
                end
                __L1:R(
                    __get(B, 1),
                    px + 24,
                    top + 10,
                    1,
                    80,
                    "#b07a94"
                )
                local sx = px + 40 + k * 6
                local sy = top + 40
                do
                    local n = 0
                    while n < 60 do
                        local a = n * 0.42
                        __L1:R(
                            __get(B, 1),
                            sx + math.cos(a) * (2 + n * 0.22),
                            sy + math.sin(a) * (2 + n * 0.18),
                            1,
                            1,
                            "rgba(210,190,230,.4)"
                        )
                        n = n + 1
                    end
                end
                __L1:R(
                    __get(B, 1),
                    sx - 4,
                    sy - 2,
                    2,
                    2,
                    "rgba(230,210,240,.5)"
                )
                __L1:R(
                    __get(B, 1),
                    sx + 3,
                    sy - 2,
                    2,
                    2,
                    "rgba(230,210,240,.5)"
                )
                k = k + 1
            end
        end
        return __arrL(
            {
                __get(A, 0),
                __get(B, 0)
            },
            2
        )
    end
    __L1.buildInkMid = function(self)
        local W = __L1:worldW(6)
        local cv, c = table.unpack(
            __L1:mk(W, __L1.LH),
            1,
            2
        )
        __L1:R(
            c,
            0,
            180,
            W,
            40,
            "#68557f"
        )
        __L1:R(
            c,
            0,
            180,
            W,
            1,
            "#8a76a0"
        )
        do
            local i = 0
            while i < W * 1.5 do
                __L1:R(
                    c,
                    __L1:hash(i + 3) * W,
                    182 + __L1:hash(i + 4) * 37,
                    2,
                    1,
                    __t(__mod(i, 2)) and "#5b4a72" or "#77648e"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < W / 40 do
                local x = __L1:hash(i + 13) * W
                local y = 190 + __L1:hash(i + 14) * 24
                __L1:ell(
                    c,
                    x,
                    y,
                    8 + __L1:hash(i) * 12,
                    2.5,
                    "#1c1830"
                )
                __L1:ell(
                    c,
                    x - 2,
                    y - 1,
                    3,
                    1,
                    "#4a4470"
                )
                i = i + 1
            end
        end
        do
            local x = 200
            local i = 0
            while x < W do
                local col = __get(
                    __arrL({"#c9a23a", "#b84a4a", "#3a8ab8"}, 3),
                    __mod(i, 3)
                )
                local dk2 = __get(
                    __arrL({"#8f701f", "#7f2c2c", "#225f84"}, 3),
                    __mod(i, 3)
                )
                __L1:R(
                    c,
                    x,
                    60,
                    16,
                    160,
                    col
                )
                __L1:R(
                    c,
                    x,
                    60,
                    5,
                    160,
                    "rgba(255,255,255,.22)"
                )
                __L1:R(
                    c,
                    x + 11,
                    60,
                    5,
                    160,
                    dk2
                )
                __L1:R(
                    c,
                    x,
                    196,
                    16,
                    5,
                    "#b9c3bf"
                )
                __L1:R(
                    c,
                    x,
                    201,
                    16,
                    19,
                    "#e8a0b0"
                )
                do
                    local k = 0
                    while k < 8 do
                        __L1:R(
                            c,
                            x + k,
                            60 - k * 2 - 2,
                            16 - k * 2,
                            2,
                            k > 5 and "#2a2a30" or "#e8cfa0"
                        )
                        k = k + 1
                    end
                end
                do
                    x = x + 400
                    i = i + 1
                end
            end
        end
        do
            local x = 90
            local i = 0
            while x < W do
                do
                    local k = 0
                    while k < 44 do
                        __L1:R(
                            c,
                            x + k * 0.35,
                            218 - k,
                            1,
                            1,
                            "#e8e0d0"
                        )
                        k = k + 1
                    end
                end
                do
                    local k = 8
                    while k < 44 do
                        __L1:R(
                            c,
                            x + k * 0.35 - math.min(7, (44 - k) * 0.3),
                            218 - k,
                            math.min(7, (44 - k) * 0.3),
                            1,
                            __t(__mod(i, 2)) and "#b8a8d8" or "#d8c8e8"
                        )
                        __L1:R(
                            c,
                            x + k * 0.35 + 1,
                            218 - k,
                            math.min(6, (44 - k) * 0.25),
                            1,
                            __t(__mod(i, 2)) and "#9888c0" or "#c0b0d8"
                        )
                        k = k + 2
                    end
                end
                do
                    x = x + 310
                    i = i + 1
                end
            end
        end
        for ____, ____value in __iterar((__L1.INK_GLOW)) do
            local x = ____value[1]
            local k = ____value[2]
            local col = __L1:css(__get(__L1.INK_COL, k))
            __L1:R(
                c,
                x - 6,
                207,
                13,
                12,
                "#2a2440"
            )
            __L1:R(
                c,
                x - 5,
                208,
                11,
                10,
                "#3a3458"
            )
            __L1:R(
                c,
                x - 4,
                211,
                9,
                6,
                col
            )
            __L1:R(
                c,
                x - 4,
                211,
                9,
                1,
                "#ffffff"
            )
            __L1:R(
                c,
                x - 2,
                203,
                5,
                5,
                "#2a2440"
            )
            __L1:R(
                c,
                x - 1,
                204,
                3,
                3,
                col
            )
            __L1:R(
                c,
                x - 5,
                208,
                1,
                10,
                "rgba(255,255,255,.3)"
            )
            do
                local d = 0
                while d < 3 do
                    __L1:R(
                        c,
                        x + 8 + d * 3,
                        218 - d,
                        2,
                        1,
                        col
                    )
                    d = d + 1
                end
            end
        end
        for ____, ____value in __iterar((__L1.INK_SIGNS)) do
            local x = ____value[1]
            __L1:board(
                c,
                x - 26,
                54,
                124,
                20,
                "#876591",
                "#3c324f"
            )
            __L1:R(
                c,
                x + 4,
                30,
                1,
                24,
                "#3c324f"
            )
            __L1:R(
                c,
                x + 66,
                30,
                1,
                24,
                "#3c324f"
            )
        end
        __L1:paving(
            c,
            W,
            "#6b577e",
            "#5a486c",
            "#4d3c64",
            "#d9c4df",
            26.5
        )
        do
            local i = 0
            while i < W / 30 do
                local x = __L1:hash(i + 23) * W
                __L1:R(
                    c,
                    x,
                    223,
                    1,
                    3 + __L1:hash(i) * 9,
                    "#1c1830"
                )
                __L1:R(
                    c,
                    x,
                    223 + 3 + __L1:hash(i) * 9,
                    2,
                    2,
                    "#1c1830"
                )
                i = i + 1
            end
        end
        return cv
    end
    __L1.ink = function(self, c, s, t, camL)
        if not __t(__get(__L1.mids, 6)) then
            __set(
                __L1.mids,
                6,
                __L1:buildInkMid()
            )
        end
        if not __t(__L1.inkBack) then
            __L1.inkBack = __L1:buildInkBack()
        end
        do
            local i = 0
            while i < 14 do
                __L1:R(
                    c,
                    0,
                    i * 14,
                    __L1.LW,
                    14,
                    __L1:css(__L1:mix(
                        __arrL({0.12, 0.12, 0.25}, 3),
                        __arrL({0.26, 0.23, 0.39}, 3),
                        i / 13
                    ))
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 40 do
                local x = __mod(
                    __mod(i * 49 - camL * 0.22 + t * 3.5, 540) + 540,
                    540
                ) - 35
                local y = 18 + __mod(i * 21, 150)
                __L1:R(
                    c,
                    x,
                    y,
                    1,
                    1,
                    __t(__mod(i, 3)) and "#b5a2cf" or "#e3c7ed"
                )
                i = i + 1
            end
        end
        __L1:tile(
            c,
            __get(__L1.inkBack, 0),
            camL * 0.15,
            0.15
        )
        __L1:tile(
            c,
            __get(__L1.inkBack, 1),
            camL * 0.3,
            0.3
        )
        do
            local i = 0
            while i < 6 do
                local x = __mod(
                    __mod(i * 190 + 60 - camL * 0.3, 1140) + 1140,
                    1140
                ) - 40
                local col = __L1:css(__L1:mix(
                    __get(
                        __L1.INK_COL,
                        __mod(i, 3)
                    ),
                    __arrL({0.1, 0.08, 0.2}, 3),
                    0.55
                ))
                __L1:R(
                    c,
                    x,
                    0,
                    5,
                    182,
                    col
                )
                __L1:R(
                    c,
                    x,
                    0,
                    1,
                    182,
                    "rgba(255,255,255,.18)"
                )
                do
                    local k = 0
                    while k < 7 do
                        local yy = __mod(t * 60 + k * 27 + i * 13, 182)
                        __L1:R(
                            c,
                            x + 1 + __mod(k, 3),
                            yy,
                            2,
                            6,
                            __L1:css(__L1:mix(
                                __get(
                                    __L1.INK_COL,
                                    __mod(i, 3)
                                ),
                                __arrL({1, 1, 1}, 3),
                                0.25
                            ))
                        )
                        k = k + 1
                    end
                end
                __L1:ell(
                    c,
                    x + 2,
                    182,
                    9,
                    2,
                    col
                )
                i = i + 1
            end
        end
        c:drawImage(
            __get(__L1.mids, 6),
            camL,
            0,
            __L1.LW,
            __L1.LH,
            0,
            0,
            __L1.LW,
            __L1.LH
        )
        do
            local i = math.floor((camL - 90) / 90)
            while __lt(i * 90, camL + __L1.LW + 20) do
                local x = i * 90 - camL
                local y = math.floor(117 + math.sin(t * 0.8 + i) * 6 + 0.5)
                __L1:R(
                    c,
                    x - 1,
                    y - 1,
                    70,
                    54,
                    "#8a7a94"
                )
                __L1:R(
                    c,
                    x,
                    y,
                    68,
                    52,
                    "#d7c9d7"
                )
                do
                    local k = 0
                    while k < 68 do
                        __L1:R(
                            c,
                            x + k,
                            y + 52,
                            4,
                            1 + math.floor(__L1:hash(k + i * 7) * 4 + 0.5),
                            "#d7c9d7"
                        )
                        k = k + 4
                    end
                end
                do
                    local j = 0
                    while j < 5 do
                        __L1:R(
                            c,
                            x + 8,
                            y + 8 + j * 8,
                            54,
                            1,
                            "#b395bd"
                        )
                        j = j + 1
                    end
                end
                __L1:R(
                    c,
                    x + 9,
                    y + 6,
                    1,
                    42,
                    "#c28b9f"
                )
                __L1:R(
                    c,
                    x,
                    y,
                    68,
                    1,
                    "#efe4ef"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 16 do
                local x = __mod(
                    __mod(i * 45 + t * 9 - camL, 540) + 540,
                    540
                ) - 20
                local y = 32 + __mod(i * 31 + t * 11, 165)
                __L1:R(
                    c,
                    x,
                    y,
                    3,
                    2,
                    __t(__mod(i, 2)) and "#ddb8d0" or "#a5ca9c"
                )
                i = i + 1
            end
        end
        for ____, ____value in __iterar((__L1.INK_GLOW)) do
            local x = ____value[1]
            local k = ____value[2]
            do
                local sx = x - camL
                if __t(sx < -20 or sx > __L1.LW + 20) then
                    continue
                end
                do
                    local b = 0
                    while b < 3 do
                        local u = __mod(t * 0.5 + b / 3 + x, 1)
                        __L1:R(
                            c,
                            sx - 2 + b * 2,
                            203 - u * 18,
                            1,
                            1,
                            __L1:css(
                                __get(__L1.INK_COL, k),
                                1 - u
                            )
                        )
                        b = b + 1
                    end
                end
            end
        end
    end
    __L1.inkText = function(self, c, camera)
        c:save()
        c:translate(
            -math.floor(camera + 0.5),
            0
        )
        c.textAlign = "center"
        c.textBaseline = "middle"
        c.font = "16px Pixel, monospace"
        c.fillStyle = "#f1d3e1"
        for ____, ____value in __iterar((__L1.INK_SIGNS)) do
            local x = ____value[1]
            local i = ____value[2]
            do
                if __t(x * 2 < camera - 300 or __gt(x * 2, camera + 1260)) then
                    continue
                end
                c:fillText(
                    __gt(i, 3) and "O RABISCO GIGANTE" or "O CADERNO TEM FOME",
                    (x + 36) * 2,
                    129
                )
            end
        end
        local ____t_174 = __t
        local ____opt_172 = window.Art
        if ____opt_172 ~= nil then
            ____opt_172 = ____opt_172.drawDoodle
        end
        if ____t_174(____opt_172) then
            do
                local i = math.floor((camera - 180) / 180)
                while __lt(i * 180, camera + 1000) do
                    do
                        if __mod(
                            __mod(i, 3) + 3,
                            3
                        ) ~= 0 then
                            do i = i + 1 continue end
                        end
                        c:save()
                        c:translate(
                            i * 180 + 68,
                            math.floor(117 + math.sin(__L1.lastT * 0.8 + i) * 6 + 0.5) * 2 + 62
                        )
                        c:scale(1.2, 1.2)
                        do
                            pcall(function()
                                window.Art:drawDoodle(
                                    c,
                                    0,
                                    0,
                                    0,
                                    __L1.lastT * 0.4,
                                    false
                                )
                            end)
                        end
                        c:restore()
                    end
                    i = i + 1
                end
            end
        end
        c:restore()
    end
    __L1.inkLights = function(self, g, s, t, camL)
        for ____, ____value in __iterar((__L1.INK_GLOW)) do
            local x = ____value[1]
            local k = ____value[2]
            do
                local sx = x - camL
                if __t(sx < -60 or sx > __L1.LW + 60) then
                    continue
                end
                local p = 0.75 + 0.25 * math.sin(t * 2 + x)
                local b = g:createRadialGradient(
                    sx,
                    210,
                    1,
                    sx,
                    210,
                    34
                )
                b:addColorStop(
                    0,
                    __L1:css(
                        __get(__L1.INK_COL, k),
                        0.55 * p
                    )
                )
                b:addColorStop(
                    1,
                    __L1:css(
                        __get(__L1.INK_COL, k),
                        0
                    )
                )
                g.fillStyle = b
                g:fillRect(sx - 36, 174, 72, 72)
            end
        end
    end
    __L1.darkness = function(self, c, scene, camera, t, hx, hy, facing)
        if scene ~= 6 then
            return
        end
        local camL = math.floor(camera / 2)
        local sub = math.floor(camera + 0.5) - camL * 2
        local f = __lt(facing, 0) and -1 or 1
        local fl = 1 + math.sin(t * 13) * 0.035 + math.sin(t * 31) * 0.02
        local tx = (hx + sub) / 2 + f * 7
        local ty = hy / 2 - 22
        dk.globalCompositeOperation = "source-over"
        dk:clearRect(0, 0, __L1.LW, __L1.LH)
        dk.fillStyle = "rgba(5,3,14,.96)"
        dk:fillRect(0, 0, __L1.LW, __L1.LH)
        dk.globalCompositeOperation = "destination-out"
        local function hole(____, x, y, r)
            for ____, ____value in __iterar((__arrL(
                {
                    __arrL({1, 0.28}, 2),
                    __arrL({0.84, 0.42}, 2),
                    __arrL({0.66, 0.6}, 2),
                    __arrL({0.46, 1}, 2)
                },
                4
            ))) do
                local k = ____value[1]
                local a = ____value[2]
                __L1:ell(
                    dk,
                    x,
                    y,
                    r * k,
                    r * k * 0.86,
                    ("rgba(0,0,0," .. tostring(a)) .. ")"
                )
            end
        end
        hole(nil, tx, ty, 84 * fl)
        for ____, ____value in __iterar((__L1.INK_GLOW)) do
            local x = ____value[1]
            local sx = x - camL
            if __t(sx > -50 and sx < __L1.LW + 50) then
                hole(
                    nil,
                    sx,
                    208,
                    30 + math.sin(t * 2 + x) * 3
                )
            end
        end
        c:save()
        c.imageSmoothingEnabled = false
        c:drawImage(
            darkCv,
            -sub,
            0,
            __L1.LW * 2,
            __L1.LH * 2
        )
        lg:clearRect(0, 0, __L1.LW, __L1.LH)
        local b = lg:createRadialGradient(
            tx,
            ty,
            2,
            tx,
            ty,
            80 * fl
        )
        b:addColorStop(0, "rgba(255,170,80,.30)")
        b:addColorStop(1, "rgba(255,170,80,0)")
        lg.fillStyle = b
        lg:fillRect(tx - 90, ty - 90, 180, 180)
        c.globalCompositeOperation = "lighter"
        c:drawImage(
            lightCv,
            -sub,
            0,
            __L1.LW * 2,
            __L1.LH * 2
        )
        c.globalCompositeOperation = "source-over"
        local px = math.floor(hx + f * 16 + 0.5)
        local py = math.floor(hy - 50 + 0.5)
        c.fillStyle = "#5a3a1e"
        c:fillRect(px - 2, py, 4, 18)
        c.fillStyle = "#8a5a2e"
        c:fillRect(px - 2, py, 2, 18)
        c.fillStyle = "#3a3a3a"
        c:fillRect(px - 4, py - 2, 8, 4)
        do
            local i = 0
            while i < 7 do
                local u = __mod(t * 2.4 + i / 7, 1)
                local w = math.floor((1 - u) * 5 + 0.5) * 2 + 2
                local fx = px + math.floor(math.sin(t * 9 + i * 2) * 2 * u + 0.5) * 2
                c.fillStyle = u < 0.3 and "#fff3b0" or (u < 0.65 and "#ffb030" or "#e8581c")
                c:fillRect(
                    fx - w / 2,
                    py - 4 - math.floor(u * 9 + 0.5) * 2,
                    w,
                    4
                )
                i = i + 1
            end
        end
        c:restore()
    end
    __L1.tileFloor = function(self, c, W, y0, cols, step, rows)
        if rows == nil then
            rows = __arrL({
                5,
                6,
                8,
                9,
                10,
                12
            }, 6)
        end
        local fy = y0
        __call(
            rows,
            "forEach",
            function(____, rh, r2)
                local tw = step + r2 * 4
                do
                    local k = -1
                    while __lt(k * tw, W) do
                        local x = k * tw + __mod(r2, 2) * tw / 2
                        local lt = __band(k + r2, 1)
                        local f = r2 / (__len(rows) - 1)
                        local ____L1_R_183 = __L1.R
                        local ____array_182 = __TS__SparseArrayNew(
                            c,
                            x,
                            fy,
                            tw,
                            rh
                        )
                        local ____L1_css_181 = __L1.css
                        local ____L1_mix_180 = __L1.mix
                        local ____L1_hexv_176 = __L1.hexv
                        local ____t_result_175
                        if __t(lt) then
                            ____t_result_175 = __get(cols, 0)
                        else
                            ____t_result_175 = __get(cols, 1)
                        end
                        local ____L1_hexv_176_result_179 = ____L1_hexv_176(__L1, ____t_result_175)
                        local ____L1_hexv_178 = __L1.hexv
                        local ____t_result_177
                        if __t(lt) then
                            ____t_result_177 = __get(cols, 2)
                        else
                            ____t_result_177 = __get(cols, 3)
                        end
                        __TS__SparseArrayPush(
                            ____array_182,
                            ____L1_css_181(
                                __L1,
                                ____L1_mix_180(
                                    __L1,
                                    ____L1_hexv_176_result_179,
                                    ____L1_hexv_178(__L1, ____t_result_177),
                                    f
                                )
                            )
                        )
                        ____L1_R_183(
                            __L1,
                            __TS__SparseArraySpread(____array_182)
                        )
                        __L1:R(
                            c,
                            x,
                            fy,
                            tw,
                            1,
                            "rgba(255,255,255,.22)"
                        )
                        __L1:R(
                            c,
                            x,
                            fy,
                            1,
                            rh,
                            "rgba(0,0,0,.18)"
                        )
                        if __L1:hash(k * 13 + r2 * 7 + y0) > 0.88 then
                            __L1:R(
                                c,
                                x + 3,
                                fy + 2,
                                4,
                                1,
                                "rgba(255,255,255,.2)"
                            )
                        end
                        k = k + 1
                    end
                end
                fy = fy + rh
            end
        )
        __L1:R(
            c,
            0,
            y0,
            W,
            1,
            "rgba(255,255,255,.35)"
        )
        do
            local i = 0
            while i < 4 do
                c.fillStyle = ("rgba(10,16,20," .. tostring(0.2 - i * 0.045)) .. ")"
                c:fillRect(0, y0 + 1 + i, W, 1)
                i = i + 1
            end
        end
    end
    __L1.winBlind = function(self, c, x, y, w, h, i, openPx)
        x = math.floor(x + 0.5)
        __L1:R(
            c,
            x - 4,
            y - 4,
            w + 8,
            h + 8,
            "#1d2e2e"
        )
        __L1:R(
            c,
            x - 3,
            y - 3,
            w + 6,
            h + 6,
            "#3a2f26"
        )
        __L1:R(
            c,
            x - 3,
            y - 3,
            w + 6,
            1,
            "#8a6a46"
        )
        __L1:R(
            c,
            x - 3,
            y - 3,
            1,
            h + 6,
            "#6e5236"
        )
        __L1:R(
            c,
            x - 1,
            y - 1,
            w + 2,
            h + 2,
            "#15100c"
        )
        c:clearRect(x, y, w, h)
        __L1:R(
            c,
            x,
            y,
            w,
            2,
            "#c9b384"
        )
        local list = __arrL({}, 0)
        do
            local yy = y + 2
            while __lt(
                yy,
                __add(y, h) - openPx - 4
            ) do
                __call(list, "push", yy)
                __L1:R(
                    c,
                    x,
                    yy,
                    w,
                    3,
                    "#d9c99a"
                )
                __L1:R(
                    c,
                    x,
                    yy,
                    w,
                    1,
                    "#f3e6bc"
                )
                __L1:R(
                    c,
                    x,
                    yy + 2,
                    w,
                    1,
                    "#a89a70"
                )
                yy = yy + 5
            end
        end
        local last = __get(
            list,
            __len(list) - 1
        )
        for ____, cx in __iterar((__arrL(
            {
                x + 14,
                __add(x, w) - 15
            },
            2
        ))) do
            __L1:R(
                c,
                cx,
                y + 2,
                1,
                last - y + 3,
                "#857b5c"
            )
        end
        __L1:R(
            c,
            x,
            last + 5,
            w,
            3,
            "#b3a67e"
        )
        __L1:R(
            c,
            x,
            last + 5,
            w,
            1,
            "#d9cc9e"
        )
        if __t(openPx) then
            __L1:R(
                c,
                x + w / 2,
                last + 8,
                2,
                __add(y, h) - last - 8,
                "#3a2f26"
            )
        end
        __L1:R(
            c,
            x - 6,
            __add(y, h) + 4,
            w + 12,
            3,
            "#a97444"
        )
        __L1:R(
            c,
            x - 6,
            __add(y, h) + 4,
            w + 12,
            1,
            "#d8a468"
        )
        c.fillStyle = "rgba(0,0,0,.18)"
        c:fillRect(
            x - 4,
            __add(y, h) + 7,
            w + 8,
            2
        )
        return list
    end
    __L1.blindsLight = function(self, g, s, t, wins, camL, W)
        local sun = __L1:sunInfo(s)
        local ____temp_184
        if s.sunT ~= nil then
            ____temp_184 = s.sun
        else
            ____temp_184 = __arrL({0.6, 0.7, 1}, 3)
        end
        local col = ____temp_184
        local lean = sun.lean
        if sun.str < 0.03 then
            return
        end
        for ____, w in __iterar((wins)) do
            do
                local wx = w.x - camL
                local ____t_188 = __t
                local ____t_result_187
                local ____t_186 = __t
                local ____temp_185 = wx < __TS__Number(-w.w) - 120 or wx > __L1.LW + 120
                __O[315] = ____temp_185
                if ____t_186(____temp_185) then
                    ____t_result_187 = __O[315]
                else
                    ____t_result_187 = __gt(w.x, W)
                end
                if ____t_188(____t_result_187) then
                    continue
                end
                local gaps = __call(
                    w.slats,
                    "map",
                    function(____, y) return __arrL({y + 3, 2}, 2) end
                )
                if __t(w.open) then
                    __call(
                        gaps,
                        "push",
                        __arrL(
                            {
                                __add(w.y, w.h) - w.open + 2,
                                w.open - 2
                            },
                            2
                        )
                    )
                end
                __call(
                    gaps,
                    "forEach",
                    function(____, ____bindingPattern0, n)
                        local gh
                        local gy
                        gy = ____bindingPattern0[1]
                        gh = ____bindingPattern0[2]
                        local depth = (__add(w.y, w.h) - gy) / w.h
                        local fy = __L1.FLOOR + 2 + depth * 44
                        local fh = math.max(2, gh * 0.5)
                        local sh = lean * (10 + depth * 46)
                        __L1:gquad(
                            g,
                            __arrL(
                                {
                                    __arrL({wx + sh, fy}, 2),
                                    __arrL({wx + w.w + sh, fy}, 2),
                                    __arrL({wx + w.w + sh + lean * fh, fy + fh}, 2),
                                    __arrL({wx + sh + lean * fh, fy + fh}, 2)
                                },
                                4
                            ),
                            __L1:css(col, 0.28 * sun.str)
                        )
                        if n == 0 then
                            __L1:patchAdd(wx + lean * 10, wx + w.w + lean * 56, lean * 1.1, 0.55 * sun.str)
                        end
                        if __t(__mod(n, 2) == 0 or __gt(gh, 2)) then
                            __L1:gquad(
                                g,
                                __arrL(
                                    {
                                        __arrL({wx, gy}, 2),
                                        __arrL({wx + w.w, gy}, 2),
                                        __arrL({wx + w.w + sh, fy}, 2),
                                        __arrL({wx + sh, fy}, 2)
                                    },
                                    4
                                ),
                                __L1:css(
                                    col,
                                    (__gt(gh, 2) and 0.07 or 0.026) * sun.str
                                )
                            )
                        end
                    end
                )
                do
                    local k = 0
                    while k < 6 do
                        local u = __mod(
                            t * 0.1 + __L1:hash(k + w.x),
                            1
                        )
                        g.fillStyle = __L1:css(
                            col,
                            0.55 * sun.str * (0.5 + 0.5 * math.sin(t * 3 + k + w.x))
                        )
                        g:fillRect(
                            math.floor(wx + __L1:hash(k * 3 + w.x) * w.w + lean * 30 * u + 0.5),
                            math.floor(w.y + u * (__L1.FLOOR - w.y) + 0.5),
                            1,
                            1
                        )
                        k = k + 1
                    end
                end
            end
        end
    end
    __L1.bulbGlow = function(self, g, x, y, a, rgb, r)
        if rgb == nil then
            rgb = "255,206,120"
        end
        if r == nil then
            r = 30
        end
        local ____t_192 = __t
        local ____t_result_191
        local ____t_190 = __t
        local ____temp_189 = __lt(a, 0.02) or __lt(x, -60)
        __O[316] = ____temp_189
        if ____t_190(____temp_189) then
            ____t_result_191 = __O[316]
        else
            ____t_result_191 = __gt(x, __L1.LW + 60)
        end
        if ____t_192(____t_result_191) then
            return
        end
        local b = g:createRadialGradient(
            x,
            y,
            1,
            x,
            y + 2,
            r
        )
        b:addColorStop(
            0,
            ((("rgba(" .. rgb) .. ",") .. tostring(0.8 * a)) .. ")"
        )
        b:addColorStop(1, ("rgba(" .. rgb) .. ",0)")
        g.fillStyle = b
        g:fillRect(x - r, y - r, r * 2, r * 2)
    end
    __L1.pool = function(self, g, x, y, a, rgb, r)
        if rgb == nil then
            rgb = "255,206,120"
        end
        if r == nil then
            r = 60
        end
        local ____t_196 = __t
        local ____t_result_195
        local ____t_194 = __t
        local ____temp_193 = __lt(a, 0.02) or __lt(x, -90)
        __O[317] = ____temp_193
        if ____t_194(____temp_193) then
            ____t_result_195 = __O[317]
        else
            ____t_result_195 = __gt(x, __L1.LW + 90)
        end
        if ____t_196(____t_result_195) then
            return
        end
        g:save()
        g:translate(x, y)
        g:scale(1, 0.28)
        local p = g:createRadialGradient(
            0,
            0,
            0,
            0,
            0,
            r
        )
        p:addColorStop(
            0,
            ((("rgba(" .. rgb) .. ",") .. tostring(0.3 * a)) .. ")"
        )
        p:addColorStop(1, ("rgba(" .. rgb) .. ",0)")
        g.fillStyle = p
        g:fillRect(-r, -r, r * 2, r * 2)
        g:restore()
    end
    __L1.wallClock = function(self, c, kx, ky, h, rr, face, rim)
        __L1:ell(
            c,
            kx,
            ky,
            rr + 2,
            rr + 2,
            rim
        )
        __L1:ell(
            c,
            kx,
            ky,
            rr,
            rr,
            face
        )
        do
            local i = 0
            while i < 12 do
                __L1:R(
                    c,
                    kx + math.floor(math.sin(i / 6 * math.pi) * (rr - 2) + 0.5),
                    ky - math.floor(math.cos(i / 6 * math.pi) * (rr - 2) + 0.5),
                    1,
                    1,
                    "#795a3d"
                )
                i = i + 1
            end
        end
        local function hand(____, ang, len, col)
            do
                local k = 0
                while __le(k, len) do
                    __L1:R(
                        c,
                        kx + math.floor(math.sin(ang) * k + 0.5),
                        ky - math.floor(math.cos(ang) * k + 0.5),
                        1,
                        1,
                        col
                    )
                    k = k + 1
                end
            end
        end
        hand(nil, h / 12 * math.pi * 2, rr * 0.5, "#3a2c20")
        hand(
            nil,
            __mod(h, 1) * math.pi * 2,
            rr * 0.78,
            "#c94f45"
        )
        __L1:R(
            c,
            kx,
            ky,
            1,
            1,
            "#3a2c20"
        )
    end
    __L1.barberChair = function(self, c, x, y, occupied, seed)
        __L1:ell(
            c,
            x,
            y - 1,
            15,
            3,
            "rgba(10,14,16,.3)"
        )
        __L1:R(
            c,
            x - 2,
            y - 9,
            4,
            9,
            "#8a96a0"
        )
        __L1:R(
            c,
            x - 2,
            y - 9,
            1,
            9,
            "#d5dde4"
        )
        __L1:ell(
            c,
            x,
            y - 1,
            11,
            3,
            "#2a3236"
        )
        __L1:ell(
            c,
            x,
            y - 2,
            10,
            2.5,
            "#5a666e"
        )
        __L1:R(
            c,
            x - 10,
            y - 25,
            20,
            3,
            "#6a757d"
        )
        __L1:R(
            c,
            x - 14,
            y - 24,
            3,
            12,
            "#8a96a0"
        )
        __L1:R(
            c,
            x + 11,
            y - 24,
            3,
            12,
            "#8a96a0"
        )
        __L1:R(
            c,
            x - 10,
            y - 24,
            20,
            14,
            "#2a3236"
        )
        __L1:R(
            c,
            x - 9,
            y - 23,
            18,
            12,
            "#a8322f"
        )
        __L1:R(
            c,
            x - 9,
            y - 23,
            18,
            3,
            "#d4564a"
        )
        __L1:R(
            c,
            x - 9,
            y - 23,
            3,
            12,
            "#c4443c"
        )
        __L1:R(
            c,
            x + 6,
            y - 23,
            3,
            12,
            "#7a2220"
        )
        __L1:R(
            c,
            x - 12,
            y - 52,
            24,
            3,
            "#6a757d"
        )
        __L1:R(
            c,
            x - 9,
            y - 49,
            18,
            25,
            "#2a3236"
        )
        __L1:R(
            c,
            x - 8,
            y - 48,
            16,
            23,
            "#a8322f"
        )
        __L1:R(
            c,
            x - 8,
            y - 48,
            16,
            3,
            "#d4564a"
        )
        __L1:R(
            c,
            x - 8,
            y - 48,
            3,
            23,
            "#c4443c"
        )
        __L1:R(
            c,
            x + 5,
            y - 48,
            3,
            23,
            "#7a2220"
        )
        __L1:R(
            c,
            x - 5,
            y - 58,
            10,
            9,
            "#2a3236"
        )
        __L1:R(
            c,
            x - 4,
            y - 57,
            8,
            7,
            "#a8322f"
        )
        __L1:R(
            c,
            x - 4,
            y - 57,
            8,
            2,
            "#d4564a"
        )
        __L1:R(
            c,
            x - 6,
            y - 8,
            12,
            2,
            "#6a757d"
        )
        __L1:R(
            c,
            x - 5,
            y - 8,
            10,
            1,
            "#d5dde4"
        )
        if __t(occupied) then
            local sk = __get(
                __L1.FAN_SKIN,
                __mod(seed, 5)
            )
            __L1:R(
                c,
                x - 11,
                y - 46,
                22,
                26,
                "#2a4a7a"
            )
            __L1:R(
                c,
                x - 11,
                y - 46,
                5,
                26,
                "#3a6aa8"
            )
            __L1:R(
                c,
                x + 6,
                y - 46,
                5,
                26,
                "#1d3558"
            )
            __L1:R(
                c,
                x - 6,
                y - 60,
                12,
                14,
                sk
            )
            __L1:R(
                c,
                x - 7,
                y - 62,
                14,
                5,
                __get(
                    __L1.FAN_HAIR,
                    __mod(seed, 5)
                )
            )
            __L1:R(
                c,
                x - 4,
                y - 54,
                2,
                2,
                "#1c1c22"
            )
            __L1:R(
                c,
                x + 2,
                y - 54,
                2,
                2,
                "#1c1c22"
            )
            __L1:R(
                c,
                x - 6,
                y - 50,
                12,
                3,
                "#f3f3f0"
            )
            __L1:R(
                c,
                x - 5,
                y - 48,
                10,
                2,
                "#f3f3f0"
            )
        end
    end
    __L1.buildBigodonMid = function(self)
        local W = __L1:worldW(8)
        local cv, c = table.unpack(
            __L1:mk(W, __L1.LH),
            1,
            2
        )
        local lv, l = table.unpack(
            __L1:mk(W, __L1.LH),
            1,
            2
        )
        __L1:R(
            c,
            0,
            14,
            W,
            126,
            "#d5bea1"
        )
        do
            local i = 0
            while i < W * 2 do
                __L1:R(
                    c,
                    __L1:hash(i + 3) * W,
                    18 + __L1:hash(i + 4) * 118,
                    1,
                    1,
                    __t(__mod(i, 2)) and "#c9b393" or "#e2cfb3"
                )
                i = i + 1
            end
        end
        do
            local x = 0
            while x < W do
                __L1:R(
                    c,
                    x,
                    14,
                    1,
                    126,
                    "rgba(255,255,255,.07)"
                )
                __L1:R(
                    c,
                    x + 6,
                    14,
                    1,
                    126,
                    "rgba(120,80,40,.06)"
                )
                x = x + 12
            end
        end
        __L1:R(
            c,
            0,
            0,
            W,
            14,
            "#29373b"
        )
        __L1:R(
            c,
            0,
            14,
            W,
            3,
            "#a97444"
        )
        __L1:R(
            c,
            0,
            14,
            W,
            1,
            "#d8a468"
        )
        __L1:R(
            c,
            0,
            17,
            W,
            2,
            "#f1d3a0"
        )
        __L1:R(
            c,
            0,
            19,
            W,
            1,
            "rgba(60,40,20,.3)"
        )
        do
            local x = 20
            while x < W do
                __L1:R(
                    c,
                    x,
                    0,
                    8,
                    14,
                    "#1c282b"
                )
                __L1:R(
                    c,
                    x,
                    0,
                    1,
                    14,
                    "#3c5258"
                )
                x = x + 100
            end
        end
        __L1:R(
            c,
            0,
            139,
            W,
            70,
            "#74513c"
        )
        do
            local x = 0
            while x < W do
                __L1:R(
                    c,
                    x,
                    143,
                    3,
                    62,
                    "#4d3a31"
                )
                __L1:R(
                    c,
                    x + 3,
                    143,
                    1,
                    62,
                    "#9e7350"
                )
                __L1:R(
                    c,
                    x + 4,
                    144,
                    1,
                    60,
                    "rgba(0,0,0,.18)"
                )
                x = x + 11
            end
        end
        do
            local i = 0
            while i < 380 do
                __L1:R(
                    c,
                    __L1:hash(i + 13) * W,
                    144 + __L1:hash(i + 14) * 60,
                    1,
                    2,
                    "rgba(60,35,20,.35)"
                )
                i = i + 1
            end
        end
        __L1:R(
            c,
            0,
            138,
            W,
            3,
            "#c89b63"
        )
        __L1:R(
            c,
            0,
            138,
            W,
            1,
            "#e8c48c"
        )
        __L1:R(
            c,
            0,
            141,
            W,
            2,
            "#4d3a31"
        )
        __L1:R(
            c,
            0,
            205,
            W,
            4,
            "#3b2a20"
        )
        __L1:R(
            c,
            0,
            205,
            W,
            1,
            "#6a4a34"
        )
        __L1:R(
            c,
            0,
            209,
            W,
            11,
            "#1f2628"
        )
        __L1:R(
            c,
            0,
            209,
            W,
            1,
            "#4a5558"
        )
        __L1:tileFloor(
            c,
            W,
            __L1.FLOOR,
            __arrL({"#cfc6ae", "#46514f", "#ddd5bd", "#566160"}, 4),
            11
        )
        for ____, w in __iterar((__L1.BG_WIN)) do
            w.slats = __L1:winBlind(
                c,
                w.x,
                w.y,
                w.w,
                w.h,
                0,
                w.open
            )
        end
        do
            local x = 6
            while x < W do
                local y = 22 + math.floor(math.sin(x * 0.13) * 2 + 3 + 0.5)
                __L1:R(
                    c,
                    x,
                    20,
                    1,
                    y - 20,
                    "#1c282b"
                )
                __L1:R(
                    c,
                    x - 1,
                    y,
                    3,
                    2,
                    "#3a3c36"
                )
                __L1:R(
                    c,
                    x - 2,
                    y + 2,
                    5,
                    5,
                    "#ffe1a0"
                )
                __L1:R(
                    c,
                    x - 1,
                    y + 3,
                    3,
                    3,
                    "#fff3cf"
                )
                __L1:R(
                    c,
                    x - 2,
                    y + 2,
                    5,
                    1,
                    "#d8a468"
                )
                x = x + 24
            end
        end
        __call(
            __L1.BG_ST,
            "forEach",
            function(____, x, i)
                __L1:R(
                    c,
                    x - 1,
                    61,
                    109,
                    94,
                    "#1c282b"
                )
                __L1:R(
                    c,
                    x,
                    62,
                    107,
                    92,
                    "#b98b52"
                )
                __L1:R(
                    c,
                    x,
                    62,
                    107,
                    2,
                    "#dcae72"
                )
                __L1:R(
                    c,
                    x + 3,
                    65,
                    101,
                    86,
                    "#303b3f"
                )
                __L1:R(
                    c,
                    x + 4,
                    66,
                    99,
                    84,
                    "#576f75"
                )
                __L1:R(
                    c,
                    x + 6,
                    68,
                    95,
                    80,
                    "#8dafb0"
                )
                __L1:R(
                    c,
                    x + 6,
                    68,
                    95,
                    20,
                    "#a5c7c8"
                )
                do
                    local k = 0
                    while k < 74 do
                        c.fillStyle = "rgba(255,255,255,.2)"
                        c:fillRect(
                            x + 12 + math.floor((74 - k) * 0.72 + 0.5),
                            70 + k,
                            9,
                            1
                        )
                        c.fillStyle = "rgba(255,255,255,.11)"
                        c:fillRect(
                            x + 36 + math.floor((74 - k) * 0.72 + 0.5),
                            70 + k,
                            4,
                            1
                        )
                        k = k + 1
                    end
                end
                __L1:R(
                    c,
                    x + 12,
                    70,
                    38,
                    1,
                    "#d2e1cc"
                )
                __L1:R(
                    c,
                    x - 6,
                    154,
                    120,
                    7,
                    "#333f40"
                )
                __L1:R(
                    c,
                    x - 5,
                    154,
                    118,
                    2,
                    "#b98a55"
                )
                __L1:R(
                    c,
                    x - 3,
                    161,
                    114,
                    25,
                    "#a27a50"
                )
                __L1:R(
                    c,
                    x - 3,
                    161,
                    114,
                    3,
                    "#76563c"
                )
                do
                    local d = 0
                    while d < 3 do
                        __L1:R(
                            c,
                            x + 1 + d * 36,
                            166,
                            31,
                            14,
                            "#805a3f"
                        )
                        __L1:R(
                            c,
                            x + 3 + d * 36,
                            167,
                            27,
                            1,
                            "#bd9561"
                        )
                        __L1:R(
                            c,
                            x + 13 + d * 36,
                            172,
                            8,
                            2,
                            "#d3be86"
                        )
                        d = d + 1
                    end
                end
                __L1:R(
                    c,
                    x - 3,
                    186,
                    114,
                    1,
                    "rgba(0,0,0,.3)"
                )
                local cols = __arrL({"#67888c", "#b96851", "#d5b677"}, 3)
                do
                    local j = 0
                    while j < 5 do
                        local bx = x + 2 + j * 13
                        local hh = 11 + __mod(j, 2) * 4
                        __L1:R(
                            c,
                            bx,
                            154 - hh,
                            6,
                            hh,
                            __get(
                                cols,
                                __mod(j, 3)
                            )
                        )
                        __L1:R(
                            c,
                            bx,
                            154 - hh,
                            2,
                            hh,
                            "rgba(255,255,255,.3)"
                        )
                        __L1:R(
                            c,
                            bx + 1,
                            151 - hh,
                            4,
                            3,
                            "#28393e"
                        )
                        __L1:R(
                            c,
                            bx + 1,
                            148 - hh + 5,
                            4,
                            3,
                            "#f0e4bb"
                        )
                        j = j + 1
                    end
                end
                __L1:R(
                    c,
                    x + 76,
                    148,
                    16,
                    6,
                    "#d4dbcd"
                )
                do
                    local j = 0
                    while j < 4 do
                        __L1:R(
                            c,
                            x + 78 + j * 3,
                            145,
                            1,
                            7,
                            "#28383d"
                        )
                        j = j + 1
                    end
                end
                __L1:R(
                    c,
                    x + 96,
                    145,
                    4,
                    9,
                    "#46616b"
                )
                __L1:R(
                    c,
                    x + 95,
                    143,
                    6,
                    3,
                    "#bcc6b7"
                )
                __L1:R(
                    c,
                    x + 44,
                    20,
                    2,
                    24,
                    "#3f4140"
                )
                __L1:R(
                    c,
                    x + 32,
                    43,
                    32,
                    4,
                    "#3b3c36"
                )
                __L1:R(
                    c,
                    x + 34,
                    46,
                    28,
                    6,
                    "#b68a53"
                )
                __L1:R(
                    c,
                    x + 41,
                    51,
                    14,
                    2,
                    "#ffe8a4"
                )
                __L1:barberChair(
                    c,
                    x + 51,
                    217,
                    __call(__L1.BG_PEOPLE, "includes", i),
                    i
                )
                __L1:R(
                    c,
                    x + 28,
                    214,
                    8,
                    2,
                    "#403b34"
                )
                __L1:R(
                    c,
                    x + 62,
                    214,
                    8,
                    2,
                    "#53493e"
                )
            end
        )
        __L1:board(
            c,
            146,
            24,
            262,
            32,
            "#34484c",
            "#1c282b"
        )
        __L1:R(
            c,
            149,
            27,
            256,
            26,
            "#28373b"
        )
        __L1:R(
            c,
            149,
            27,
            256,
            1,
            "#e1b16b"
        )
        __L1:R(
            c,
            149,
            52,
            256,
            1,
            "#e1b16b"
        )
        __L1:R(
            c,
            149,
            27,
            1,
            26,
            "#e1b16b"
        )
        __L1:R(
            c,
            404,
            27,
            1,
            26,
            "#e1b16b"
        )
        for ____, sd in __iterar((__arrL({-1, 1}, 2))) do
            local pts = __arrL(
                {
                    __arrL({0, 0}, 2),
                    __arrL({5, -6}, 2),
                    __arrL({12, -6}, 2),
                    __arrL({20, 1}, 2),
                    __arrL({28, -2}, 2),
                    __arrL({24, 4}, 2),
                    __arrL({16, 6}, 2),
                    __arrL({8, 3}, 2)
                },
                8
            )
            do
                local k = 0
                while k < __len(pts) - 1 do
                    local a = __get(pts, k)
                    local b2 = __get(pts, k + 1)
                    local n = math.max(
                        math.abs(__get(b2, 0) - __get(a, 0)),
                        math.abs(__get(b2, 1) - __get(a, 1))
                    )
                    do
                        local q = 0
                        while q <= n do
                            __L1:R(
                                c,
                                209 + sd * (4 + __get(a, 0) + (__get(b2, 0) - __get(a, 0)) * q / n) - (sd > 0 and 0 or 1),
                                42 + __get(a, 1) + (__get(b2, 1) - __get(a, 1)) * q / n,
                                2,
                                2,
                                "#fae3a8"
                            )
                            q = q + 1
                        end
                    end
                    k = k + 1
                end
            end
        end
        for ____, x in __iterar((__L1.BG_POLES)) do
            __L1:R(
                c,
                x - 6,
                52,
                12,
                4,
                "#3b3c36"
            )
            __L1:R(
                c,
                x - 6,
                52,
                12,
                1,
                "#8a8a80"
            )
            __L1:R(
                c,
                x - 6,
                112,
                12,
                4,
                "#3b3c36"
            )
            __L1:R(
                c,
                x - 6,
                115,
                12,
                1,
                "rgba(0,0,0,.3)"
            )
        end
        __L1:R(
            c,
            642,
            115,
            115,
            11,
            "#2e4141"
        )
        __L1:R(
            c,
            642,
            115,
            115,
            1,
            "#4a6a6a"
        )
        do
            local j = 0
            while j < 3 do
                __L1:R(
                    c,
                    646 + j * 36,
                    109,
                    33,
                    7,
                    "#ece1c4"
                )
                __L1:R(
                    c,
                    646 + j * 36,
                    109,
                    33,
                    1,
                    "#fff5dd"
                )
                __L1:R(
                    c,
                    646 + j * 36,
                    114,
                    33,
                    1,
                    "#b9bcae"
                )
                __L1:R(
                    c,
                    646 + j * 36,
                    111,
                    33,
                    1,
                    "#d8cdb0"
                )
                j = j + 1
            end
        end
        __L1:R(
            c,
            75,
            168,
            86,
            9,
            "#293d40"
        )
        __L1:R(
            c,
            75,
            168,
            86,
            1,
            "#4a6a6e"
        )
        __L1:R(
            c,
            79,
            177,
            78,
            30,
            "#996b46"
        )
        do
            local k = 0
            while k < 78 do
                __L1:R(
                    c,
                    79 + k,
                    177,
                    1,
                    30,
                    "rgba(0,0,0,.2)"
                )
                k = k + 6
            end
        end
        __L1:R(
            c,
            79,
            177,
            78,
            3,
            "#c59a65"
        )
        __L1:R(
            c,
            83,
            204,
            70,
            3,
            "#4a4437"
        )
        __L1:R(
            c,
            92,
            162,
            24,
            7,
            "#d6dfcf"
        )
        __L1:R(
            c,
            94,
            164,
            20,
            3,
            "#667e75"
        )
        __L1:R(
            c,
            132,
            155,
            12,
            14,
            "#293b42"
        )
        __L1:R(
            c,
            134,
            157,
            8,
            9,
            "#84b7b1"
        )
        __L1:R(
            c,
            138,
            167,
            2,
            2,
            "#e4cd96"
        )
        __L1:R(
            c,
            120,
            166,
            7,
            3,
            "#d7b45a"
        )
        __L1:R(
            c,
            122,
            164,
            3,
            2,
            "#ffe9a8"
        )
        __L1:board(
            c,
            94,
            180,
            46,
            12,
            "#c9a56a",
            "#4a3a26"
        )
        for ____, x in __iterar((__L1.BG_SOFA)) do
            __L1:R(
                c,
                x - 1,
                182,
                109,
                29,
                "#1c282b"
            )
            __L1:R(
                c,
                x,
                183,
                107,
                27,
                "#273a3d"
            )
            __L1:R(
                c,
                x + 3,
                189,
                101,
                18,
                "#986553"
            )
            __L1:R(
                c,
                x + 3,
                189,
                101,
                2,
                "#bd8670"
            )
            __L1:R(
                c,
                x,
                177,
                107,
                11,
                "#a77158"
            )
            __L1:R(
                c,
                x,
                177,
                107,
                2,
                "#cc9c76"
            )
            do
                local j = 0
                while j < 3 do
                    __L1:R(
                        c,
                        x + 7 + j * 32,
                        192,
                        27,
                        15,
                        "#875648"
                    )
                    __L1:R(
                        c,
                        x + 9 + j * 32,
                        193,
                        23,
                        2,
                        "#b78261"
                    )
                    __L1:R(
                        c,
                        x + 30 + j * 32,
                        192,
                        1,
                        15,
                        "#6a4034"
                    )
                    j = j + 1
                end
            end
            __L1:R(
                c,
                x + 5,
                209,
                5,
                9,
                "#344342"
            )
            __L1:R(
                c,
                x + 97,
                209,
                5,
                9,
                "#344342"
            )
            c.fillStyle = "rgba(0,0,0,.2)"
            c:fillRect(x, 219, 107, 1)
        end
        __L1:board(
            c,
            1458,
            58,
            116,
            53,
            "#8c6247",
            "#303b3f"
        )
        __L1:R(
            c,
            1460,
            60,
            112,
            1,
            "#a97a58"
        )
        do
            local x = 90
            while x < W do
                do
                    local ____t_200 = __t
                    local ____t_result_199
                    local ____t_198 = __t
                    local ____call_result_197 = __call(
                        __L1.BG_SOFA,
                        "some",
                        function(____, s2) return math.abs(x - s2) < 70 end
                    )
                    __O[318] = ____call_result_197
                    if ____t_198(____call_result_197) then
                        ____t_result_199 = __O[318]
                    else
                        ____t_result_199 = __call(
                            __L1.BG_ST,
                            "some",
                            function(____, s2) return x > s2 - 12 and __lt(x, s2 + 118) end
                        )
                    end
                    if ____t_200(____t_result_199) then
                        do x = x + 330 continue end
                    end
                    __L1:R(
                        c,
                        x,
                        200,
                        14,
                        19,
                        "#94704e"
                    )
                    __L1:R(
                        c,
                        x - 2,
                        197,
                        18,
                        4,
                        "#c29961"
                    )
                    do
                        local j = 0
                        while j < 4 do
                            __L1:limb(
                                c,
                                __arrL(
                                    {
                                        __arrL({x + 7, 197}, 2),
                                        __arrL(
                                            {
                                                x + 3 + j * 3,
                                                184 + __mod(j, 2) * 4
                                            },
                                            2
                                        )
                                    },
                                    2
                                ),
                                1,
                                "#466e4a"
                            )
                            __L1:ell(
                                c,
                                x + 3 + j * 3,
                                183 + __mod(j, 2) * 4,
                                3,
                                2,
                                __t(__mod(j, 2)) and "#6f9c60" or "#91b374"
                            )
                            j = j + 1
                        end
                    end
                end
                x = x + 330
            end
        end
        return __arrL({cv, lv}, 2)
    end
    __L1.bigodon = function(self, c, s, t, camL)
        if not __t(__get(__L1.mids, 8)) then
            __set(
                __L1.mids,
                8,
                __L1:buildBigodonMid()
            )
        end
        if not __t(__L1.far) then
            __L1.far = __L1:buildFar()
        end
        local sun = __L1:backdrop(
            c,
            s,
            t,
            camL,
            __arrL({47, 112}, 2)
        )
        if __gt(s.night, 0.05) then
            c.fillStyle = ("rgba(6,10,36," .. tostring(0.5 * s.night)) .. ")"
            c:fillRect(0, 0, __L1.LW, 140)
        end
        c:drawImage(
            __get(
                __get(__L1.mids, 8),
                0
            ),
            camL,
            0,
            __L1.LW,
            __L1.LH,
            0,
            0,
            __L1.LW,
            __L1.LH
        )
        for ____, x in __iterar((__L1.BG_POLES)) do
            do
                local sx = x - camL
                if __t(sx < -20 or sx > __L1.LW + 20) then
                    continue
                end
                do
                    local r2 = 0
                    while r2 < 60 do
                        local ph = __mod(r2 + t * 10, 12) / 12
                        local col = ph < 0.33 and "#d83a3a" or (ph < 0.66 and "#f3f3f0" or "#3a6ad8")
                        __L1:R(
                            c,
                            sx - 4,
                            56 + r2,
                            8,
                            1,
                            col
                        )
                        if __mod(r2, 3) == 0 then
                            __L1:R(
                                c,
                                sx - 3,
                                56 + r2,
                                2,
                                1,
                                "rgba(255,255,255,.45)"
                            )
                        end
                        __L1:R(
                            c,
                            sx + 3,
                            56 + r2,
                            1,
                            1,
                            "rgba(0,0,0,.35)"
                        )
                        r2 = r2 + 1
                    end
                end
                __L1:ell(
                    c,
                    sx,
                    55,
                    5,
                    2,
                    "#d8d8d0"
                )
            end
        end
        do
            local kx = 682 - camL
            if __t(kx > -30 and kx < __L1.LW + 30) then
                __L1:wallClock(
                    c,
                    kx,
                    71,
                    window.DayTime:state().h,
                    14,
                    "#f1dfb5",
                    "#344549"
                )
            end
        end
        do
            local i = 0
            while i < 2 do
                local fx = 380 + i * 780 - camL * 0.17 * 2 / 2
                local a = t * 8 + i
                local x0 = __mod(
                    __mod(fx, __L1.LW) + __L1.LW,
                    __L1.LW
                )
                __L1:R(
                    c,
                    x0 - 1,
                    14,
                    2,
                    24,
                    "#3e4946"
                )
                do
                    local b = 0
                    while b < 3 do
                        local an = a + b * 2.09
                        local dx = math.cos(an)
                        local dy = math.sin(an) * 0.34
                        do
                            local k = 4
                            while k < 25 do
                                __L1:R(
                                    c,
                                    x0 + dx * k,
                                    38 + dy * k,
                                    2,
                                    1,
                                    "#65736b"
                                )
                                k = k + 1
                            end
                        end
                        b = b + 1
                    end
                end
                __L1:ell(
                    c,
                    x0,
                    38,
                    3,
                    2,
                    "#334344"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 12 do
                local dx = __mod(
                    __mod(i * 57 + t * 2 - camL * 0.36, __L1.LW) + __L1.LW,
                    __L1.LW
                )
                local dy = 40 + __mod(i * 31 + t * 3, 160)
                __L1:R(
                    c,
                    dx,
                    dy,
                    1,
                    1,
                    __t(__mod(i, 2)) and "rgba(244,215,155,.55)" or "rgba(245,233,190,.4)"
                )
                i = i + 1
            end
        end
        if sun.str > 0.04 then
            local sh = ("rgba(40,24,14," .. tostring(0.22 * sun.str)) .. ")"
            for ____, x in __iterar((__L1.BG_SOFA)) do
                __L1:slant(
                    c,
                    x - camL,
                    x - camL + 107,
                    220,
                    sun.lean * 20,
                    3,
                    sh
                )
            end
        end
    end
    __L1.bigodonText = function(self, c, camera)
        c:save()
        c:translate(
            -math.floor(camera + 0.5),
            0
        )
        c.textAlign = "center"
        c.textBaseline = "middle"
        c.font = "16px Pixel, monospace"
        c.fillStyle = "#7a4a1c"
        c:fillText("BIGODON", 546, 82)
        c.fillStyle = "#fae3a8"
        c:fillText("BIGODON", 544, 80)
        c.font = "8px Pixel, monospace"
        c.fillStyle = "#a8c9bd"
        c:fillText("CORTE NA RÉGUA, RESENHA SEM MEDIDA", 544, 98)
        c.fillStyle = "#f0d9a8"
        c:fillText("RECEPÇÃO", 232, 372)
        c.font = "16px Pixel, monospace"
        c.fillStyle = "#f2d69e"
        c:fillText("AQUI O PAPO", 3032, 140)
        c:fillText("RENDE MAIS", 3032, 166)
        c.font = "8px Pixel, monospace"
        c:fillText("QUE O DEGRADÊ.", 3032, 192)
        c:restore()
    end
    __L1.bigodonLights = function(self, g, s, t, camL)
        local W = __L1:worldW(8)
        local a = __L1:cl((s.night - 0.12) * 1.4)
        local base = 0.4 + a * 0.6
        __L1:blindsLight(
            g,
            s,
            t,
            __L1.BG_WIN,
            camL,
            W
        )
        g:save()
        g:beginPath()
        for ____, w in __iterar((__L1.BG_WIN)) do
            g:rect(w.x - camL, w.y, w.w, w.h)
        end
        g:clip()
        g.globalAlpha = a
        __L1:tile(
            g,
            __get(
                __L1:city(47, 112),
                1
            ),
            camL * 0.07,
            0.07
        )
        g:restore()
        do
            local x = 6
            while x < W do
                do
                    local y = 22 + math.floor(math.sin(x * 0.13) * 2 + 3 + 0.5)
                    local sx = x - camL
                    if __t(sx < -30 or sx > __L1.LW + 30) then
                        do x = x + 24 continue end
                    end
                    __L1:bulbGlow(
                        g,
                        sx,
                        y + 4,
                        base * (0.85 + 0.15 * math.sin(t * 2 + x)),
                        "255,200,110",
                        20
                    )
                end
                x = x + 24
            end
        end
        __call(
            __L1.BG_ST,
            "forEach",
            function(____, x)
                local sx = x - camL + 51
                if __t(sx < -90 or sx > __L1.LW + 90) then
                    return
                end
                __L1:lightAdd(sx, 52, base * 0.9, 48)
                local gr = g:createLinearGradient(0, 52, 0, 230)
                gr:addColorStop(
                    0,
                    ("rgba(255,222,150," .. tostring(0.32 * base)) .. ")"
                )
                gr:addColorStop(
                    1,
                    ("rgba(255,222,150," .. tostring(0.04 * base)) .. ")"
                )
                g.fillStyle = gr
                g:beginPath()
                g:moveTo(sx - 12, 52)
                g:lineTo(sx + 12, 52)
                g:lineTo(sx + 48, 232)
                g:lineTo(sx - 48, 232)
                g:closePath()
                __call(g, "fill")
                __L1:pool(
                    g,
                    sx,
                    224,
                    base,
                    "255,214,140",
                    48
                )
            end
        )
        __L1:bulbGlow(
            g,
            544 - camL,
            40,
            0.35 + a * 0.65,
            "255,190,90",
            70
        )
        __L1:bulbGlow(
            g,
            209 - camL,
            42,
            0.3 + a * 0.7,
            "255,214,150",
            26
        )
        for ____, x in __iterar((__L1.BG_POLES)) do
            __L1:bulbGlow(
                g,
                x - camL,
                84,
                a * 0.5,
                "255,255,255",
                24
            )
        end
    end
    __L1.buildRayssaMid = function(self)
        local W = __L1:worldW(10)
        local cv, c = table.unpack(
            __L1:mk(W, __L1.LH),
            1,
            2
        )
        local lv, l = table.unpack(
            __L1:mk(W, __L1.LH),
            1,
            2
        )
        __L1:R(
            c,
            0,
            14,
            W,
            150,
            "#eddcbf"
        )
        do
            local i = 0
            while i < W * 2 do
                __L1:R(
                    c,
                    __L1:hash(i + 3) * W,
                    18 + __L1:hash(i + 4) * 145,
                    1,
                    1,
                    __t(__mod(i, 2)) and "#e0cdae" or "#f6e9d0"
                )
                i = i + 1
            end
        end
        do
            local x = 0
            while x < W do
                __L1:R(
                    c,
                    x,
                    14,
                    1,
                    150,
                    "rgba(255,255,255,.1)"
                )
                do
                    local y = 30
                    while y < 150 do
                        __L1:R(
                            c,
                            x + 6,
                            y + __mod(x / 14, 2) * 8,
                            2,
                            2,
                            "rgba(184,112,100,.22)"
                        )
                        __L1:R(
                            c,
                            x + 7,
                            y + 2 + __mod(x / 14, 2) * 8,
                            1,
                            1,
                            "rgba(110,150,110,.25)"
                        )
                        y = y + 22
                    end
                end
                x = x + 14
            end
        end
        __L1:R(
            c,
            0,
            0,
            W,
            14,
            "#40575a"
        )
        __L1:R(
            c,
            0,
            14,
            W,
            4,
            "#b18b63"
        )
        __L1:R(
            c,
            0,
            14,
            W,
            1,
            "#d4ad82"
        )
        __L1:R(
            c,
            0,
            18,
            W,
            2,
            "#f8e6bc"
        )
        __L1:R(
            c,
            0,
            20,
            W,
            1,
            "rgba(60,40,20,.25)"
        )
        __L1:R(
            c,
            0,
            132,
            W,
            32,
            "#9db8ae"
        )
        __L1:R(
            c,
            0,
            132,
            W,
            2,
            "#f8e6bc"
        )
        __L1:R(
            c,
            0,
            134,
            W,
            1,
            "rgba(60,70,60,.35)"
        )
        do
            local x = 6
            while x < W do
                __L1:R(
                    c,
                    x,
                    138,
                    28,
                    22,
                    "#a9c4ba"
                )
                __L1:R(
                    c,
                    x,
                    138,
                    28,
                    1,
                    "#d3e6dc"
                )
                __L1:R(
                    c,
                    x,
                    159,
                    28,
                    1,
                    "#7a968c"
                )
                __L1:R(
                    c,
                    x,
                    138,
                    1,
                    22,
                    "#d3e6dc"
                )
                __L1:R(
                    c,
                    x + 27,
                    138,
                    1,
                    22,
                    "#7a968c"
                )
                x = x + 40
            end
        end
        __L1:R(
            c,
            0,
            162,
            W,
            3,
            "#416d70"
        )
        __L1:R(
            c,
            0,
            162,
            W,
            1,
            "#6a9da0"
        )
        __L1:R(
            c,
            0,
            164,
            W,
            56,
            "#84aaa2"
        )
        __L1:tileFloor(
            c,
            W,
            164,
            __arrL({"#9bc0b6", "#7fa69d", "#a9ccc2", "#8cb2a8"}, 4),
            20,
            __arrL({
                6,
                7,
                8,
                9,
                10,
                11,
                12,
                13,
                14,
                16
            }, 10)
        )
        do
            local x = 0
            while x < W do
                __L1:R(
                    c,
                    x + 6,
                    20,
                    4,
                    144,
                    "#d2ba96"
                )
                __L1:R(
                    c,
                    x + 7,
                    20,
                    1,
                    144,
                    "#fff0ce"
                )
                __L1:R(
                    c,
                    x + 9,
                    20,
                    1,
                    144,
                    "#a98f68"
                )
                __L1:R(
                    c,
                    x + 13,
                    52,
                    160,
                    3,
                    "#d8c49d"
                )
                __L1:R(
                    c,
                    x + 13,
                    52,
                    160,
                    1,
                    "#f2e2c0"
                )
                x = x + 210
            end
        end
        for ____, w in __iterar((__L1.RY_WIN)) do
            local x = w.x
            local y = w.y
            __L1:R(
                c,
                x - 7,
                y - 8,
                w.w + 14,
                5,
                "#705d48"
            )
            __L1:R(
                c,
                x - 6,
                y - 8,
                w.w + 12,
                1,
                "#a38a68"
            )
            __L1:R(
                c,
                x - 3,
                y - 3,
                w.w + 6,
                w.h + 6,
                "#80684d"
            )
            __L1:R(
                c,
                x - 3,
                y - 3,
                w.w + 6,
                1,
                "#a88d66"
            )
            c:clearRect(x, y, w.w, w.h)
            __L1:R(
                c,
                x + 50,
                y,
                3,
                w.h,
                "#f1e4c4"
            )
            __L1:R(
                c,
                x,
                y + 37,
                w.w,
                3,
                "#f1e4c4"
            )
            __L1:R(
                c,
                x + 51,
                y,
                1,
                w.h,
                "#c9b88f"
            )
            __L1:R(
                c,
                x - 5,
                __add(y, w.h) + 3,
                w.w + 10,
                4,
                "#b18b5d"
            )
            __L1:R(
                c,
                x - 5,
                __add(y, w.h) + 3,
                w.w + 10,
                1,
                "#d9b682"
            )
            c.fillStyle = "rgba(0,0,0,.14)"
            c:fillRect(
                x - 3,
                __add(y, w.h) + 7,
                w.w + 6,
                2
            )
            for ____, sd in __iterar((__arrL({-1, 1}, 2))) do
                local ____temp_201
                if sd < 0 then
                    ____temp_201 = x - 4
                else
                    ____temp_201 = __add(x, w.w) - 11
                end
                local cx = ____temp_201
                local ____t_result_202
                if __t(__mod(w.i, 2)) then
                    ____t_result_202 = __arrL({"#d6a5a0", "#bd8884"}, 2)
                else
                    ____t_result_202 = __arrL({"#b9b9cf", "#9a9ab4"}, 2)
                end
                local col = ____t_result_202
                do
                    local r2 = 0
                    while r2 < 66 do
                        local u = r2 / 65
                        __L1:R(
                            c,
                            cx - (sd < 0 and 0 or -1),
                            y - 1 + r2,
                            15 - math.floor(u * 3 + 0.5),
                            1,
                            __get(col, 0)
                        )
                        r2 = r2 + 1
                    end
                end
                do
                    local k = 0
                    while k < 4 do
                        __L1:R(
                            c,
                            cx + k * 3,
                            y - 1,
                            1,
                            64,
                            __get(col, 1)
                        )
                        k = k + 1
                    end
                end
                __L1:R(
                    c,
                    cx,
                    y - 1,
                    15,
                    2,
                    "#705d48"
                )
            end
            __L1:R(
                c,
                x - 7,
                y - 6,
                w.w + 14,
                2,
                "#3a2f26"
            )
            do
                local k = 0
                while k < 8 do
                    __L1:R(
                        c,
                        x - 5 + k * 14,
                        y - 5,
                        2,
                        3,
                        "#c9a56a"
                    )
                    k = k + 1
                end
            end
        end
        __L1:board(
            c,
            172,
            27,
            257,
            27,
            "#718c7d",
            "#425c5e"
        )
        __L1:R(
            c,
            175,
            31,
            251,
            2,
            "#bbd2b0"
        )
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({175, 33}, 2),
                __arrL({423, 33}, 2)
            },
            2
        ))) do
            local bx = ____value[1]
            local by = ____value[2]
            __L1:R(
                c,
                bx,
                by,
                2,
                2,
                "#e8d9a0"
            )
        end
        for ____, ____value in __iterar((__L1.RY_SOFA)) do
            local x = ____value[1]
            local i = ____value[2]
            __L1:R(
                c,
                x - 6,
                205,
                134,
                8,
                __t(__mod(i, 2)) and "#a65e5c" or "#a7774d"
            )
            __L1:R(
                c,
                x - 5,
                205,
                132,
                1,
                "rgba(255,255,255,.25)"
            )
            do
                local k = 0
                while k < 134 do
                    __L1:R(
                        c,
                        x - 6 + k,
                        213,
                        2,
                        3,
                        __t(__mod(i, 2)) and "#7a403e" or "#7a5632"
                    )
                    k = k + 5
                end
            end
            __L1:R(
                c,
                x - 8,
                186,
                10,
                28,
                __t(__mod(i, 2)) and "#a65e5c" or "#a7774d"
            )
            __L1:R(
                c,
                x + 124,
                186,
                10,
                28,
                __t(__mod(i, 2)) and "#a65e5c" or "#a7774d"
            )
            __L1:R(
                c,
                x - 8,
                186,
                10,
                3,
                "#d99987"
            )
            __L1:R(
                c,
                x + 124,
                186,
                10,
                3,
                "#d99987"
            )
            __L1:R(
                c,
                x - 2,
                175,
                126,
                40,
                "#5a5e50"
            )
            __L1:R(
                c,
                x,
                171,
                122,
                36,
                __t(__mod(i, 2)) and "#b56e68" or "#bb8b5b"
            )
            __L1:R(
                c,
                x,
                171,
                122,
                5,
                __t(__mod(i, 2)) and "#d99987" or "#e4b47a"
            )
            __L1:R(
                c,
                x,
                171,
                5,
                36,
                "rgba(255,255,255,.12)"
            )
            do
                local j = 0
                while j < 3 do
                    __L1:R(
                        c,
                        x + 2 + j * 40,
                        178,
                        37,
                        26,
                        __t(__mod(i, 2)) and "#c07b70" or "#d09e68"
                    )
                    __L1:R(
                        c,
                        x + 4 + j * 40,
                        179,
                        33,
                        2,
                        __t(__mod(i, 2)) and "#dda18d" or "#edc18a"
                    )
                    __L1:R(
                        c,
                        x + 38 + j * 40,
                        178,
                        1,
                        26,
                        "rgba(0,0,0,.2)"
                    )
                    j = j + 1
                end
            end
            __L1:R(
                c,
                x + 8,
                207,
                5,
                12,
                "#625844"
            )
            __L1:R(
                c,
                x + 108,
                207,
                5,
                12,
                "#625844"
            )
            __L1:R(
                c,
                x + 12,
                174,
                16,
                15,
                __t(__mod(i, 2)) and "#e4d59d" or "#8eafa3"
            )
            __L1:R(
                c,
                x + 14,
                176,
                12,
                11,
                __t(__mod(i, 2)) and "#f2e3af" or "#b7cfb4"
            )
            __L1:R(
                c,
                x + 92,
                175,
                15,
                14,
                "#d9b0b5"
            )
            __L1:R(
                c,
                x + 94,
                177,
                11,
                10,
                "#ecc8cc"
            )
            c.fillStyle = "rgba(0,0,0,.18)"
            c:fillRect(x - 6, 219, 134, 1)
        end
        for ____, x in __iterar((__L1.RY_PLANTS)) do
            __L1:R(
                c,
                x,
                197,
                22,
                22,
                "#94704e"
            )
            __L1:R(
                c,
                x - 2,
                194,
                26,
                4,
                "#c29961"
            )
            __L1:R(
                c,
                x + 3,
                202,
                16,
                1,
                "#d8b47a"
            )
            __L1:R(
                c,
                x + 6,
                186,
                11,
                8,
                "#bf755a"
            )
            __L1:R(
                c,
                x + 5,
                184,
                13,
                3,
                "#d99572"
            )
        end
        for ____, ____value in __iterar((__L1.RY_ART)) do
            local x = ____value[1]
            local col = ____value[3]
            __L1:R(
                c,
                x - 1,
                67,
                104,
                52,
                "#4a3a2a"
            )
            __L1:R(
                c,
                x,
                68,
                102,
                50,
                "#76624b"
            )
            __L1:R(
                c,
                x + 3,
                71,
                96,
                44,
                "#efdfbd"
            )
            __L1:R(
                c,
                x + 6,
                74,
                90,
                32,
                col
            )
            do
                local k = 0
                while k < 90 do
                    local hh = 6 + math.floor(math.sin(k * 0.15) * 5 + math.sin(k * 0.4) * 2.5 + 0.5)
                    __L1:R(
                        c,
                        x + 6 + k,
                        74 + 32 - hh,
                        2,
                        hh,
                        "#ead5ae"
                    )
                    k = k + 2
                end
            end
            __L1:R(
                c,
                x + 6,
                74,
                90,
                1,
                "rgba(255,255,255,.25)"
            )
        end
        __L1:R(
            c,
            1010,
            148,
            266,
            62,
            "#b3b49a"
        )
        do
            local i = 0
            while i < 6 do
                __L1:R(
                    c,
                    1013 + i * 43,
                    152,
                    40,
                    52,
                    "#d4c7a0"
                )
                __L1:R(
                    c,
                    1015 + i * 43,
                    154,
                    36,
                    2,
                    "#f3e3bb"
                )
                __L1:R(
                    c,
                    1027 + i * 43,
                    160,
                    10,
                    2,
                    "#7d8673"
                )
                __L1:R(
                    c,
                    1013 + i * 43,
                    203,
                    40,
                    1,
                    "rgba(0,0,0,.2)"
                )
                i = i + 1
            end
        end
        __L1:R(
            c,
            1007,
            145,
            272,
            7,
            "#7c8572"
        )
        __L1:R(
            c,
            1008,
            145,
            270,
            2,
            "#e6dcc0"
        )
        __L1:R(
            c,
            1020,
            89,
            136,
            48,
            "#758b80"
        )
        do
            local i = 0
            while i < 3 do
                __L1:R(
                    c,
                    1022 + i * 45,
                    92,
                    41,
                    41,
                    "#c1c5ab"
                )
                __L1:R(
                    c,
                    1024 + i * 45,
                    94,
                    37,
                    2,
                    "#e8e3c6"
                )
                __L1:R(
                    c,
                    1038 + i * 45,
                    123,
                    10,
                    2,
                    "#728574"
                )
                i = i + 1
            end
        end
        do
            local x = 1158
            while x < 1275 do
                do
                    local y = 112
                    while y < 144 do
                        __L1:R(
                            c,
                            x,
                            y,
                            5,
                            5,
                            __t(__band((x + y) / 6, 1)) and "#dfe8e0" or "#cfdcd4"
                        )
                        y = y + 6
                    end
                end
                x = x + 6
            end
        end
        __L1:R(
            c,
            1158,
            112,
            117,
            1,
            "#9fb0a8"
        )
        __L1:R(
            c,
            1180,
            134,
            49,
            11,
            "#5c6c65"
        )
        __L1:ell(
            c,
            1205,
            135,
            20,
            5,
            "#a9bbb0"
        )
        __L1:R(
            c,
            1204,
            123,
            3,
            13,
            "#b6c8bd"
        )
        __L1:R(
            c,
            1205,
            122,
            10,
            2,
            "#dbe4ce"
        )
        __L1:R(
            c,
            1078,
            133,
            18,
            11,
            "#736c64"
        )
        __L1:R(
            c,
            1077,
            131,
            20,
            3,
            "#c0b8a0"
        )
        do
            local k = 0
            while k < 4 do
                __L1:R(
                    c,
                    1082 + k * 4,
                    128,
                    2,
                    3,
                    "#c94f45"
                )
                k = k + 1
            end
        end
        __L1:R(
            c,
            1450,
            108,
            185,
            99,
            "#5f8780"
        )
        __L1:R(
            c,
            1453,
            111,
            179,
            93,
            "#a0c1ae"
        )
        __L1:R(
            c,
            1460,
            120,
            163,
            76,
            "#83aeaa"
        )
        c:clearRect(1460, 120, 163, 76)
        do
            local j = 0
            while j < 4 do
                __L1:R(
                    c,
                    1461 + j * 32 + 1,
                    120,
                    3,
                    76,
                    "#d2dfc3"
                )
                j = j + 1
            end
        end
        __L1:R(
            c,
            1460,
            155,
            163,
            3,
            "#d2dfc3"
        )
        __L1:R(
            c,
            1443,
            104,
            197,
            6,
            "#3f6a68"
        )
        __L1:R(
            c,
            1443,
            104,
            197,
            1,
            "#6a9a96"
        )
        do
            local k = 0
            while k < 6 do
                __L1:R(
                    c,
                    1450 + k * 36,
                    196,
                    20,
                    4,
                    "#e8d9a0"
                )
                k = k + 1
            end
        end
        return __arrL({cv, lv}, 2)
    end
    __L1.rayssa = function(self, c, s, t, camL)
        if not __t(__get(__L1.mids, 10)) then
            __set(
                __L1.mids,
                10,
                __L1:buildRayssaMid()
            )
        end
        if not __t(__L1.far) then
            __L1.far = __L1:buildFar()
        end
        local sun = __L1:sunInfo(s)
        local la = math.min(
            1,
            math.abs(sun.lean) * 1.3
        ) * sun.str
        __L1:sky(
            c,
            s,
            t,
            camL,
            {amb = __L1:roomAmb(0.6)(nil, s)}
        )
        __L1:tile(
            c,
            __get(__L1.far, 0),
            camL * 0.04,
            0.04
        )
        if la > 0.03 then
            c.globalAlpha = la
            __L1:tile(
                c,
                __get(
                    __get(__L1.far, sun.lean >= 0 and 3 or 4),
                    0
                ),
                camL * 0.04,
                0.04
            )
            c.globalAlpha = 1
        end
        __L1:tile(
            c,
            __get(__L1.far, 1),
            camL * 0.1 + 300,
            0.1
        )
        __L1:tile(
            c,
            __get(__L1.far, 2),
            camL * 0.22 + 500,
            0.22
        )
        do
            local x = __mod(
                __mod(
                    __TS__Number(-camL) * 0.4,
                    90
                ) + 90,
                90
            ) - 90
            while x < __L1.LW + 90 do
                local sd = math.floor((x + camL * 0.4) / 90 + 0.5)
                __L1:ell(
                    c,
                    x + 20,
                    150,
                    22,
                    16,
                    "#2a6a3a"
                )
                __L1:ell(
                    c,
                    x + 18,
                    146,
                    18,
                    12,
                    "#3f8a46"
                )
                __L1:ell(
                    c,
                    x + 12,
                    141,
                    9,
                    5,
                    "#68ad58"
                )
                do
                    local k = 0
                    while k < 6 do
                        __L1:R(
                            c,
                            x + 6 + __L1:hash(sd * 7 + k) * 28,
                            140 + __L1:hash(sd * 5 + k) * 18,
                            2,
                            2,
                            __get(
                                __arrL({"#e86a8a", "#f2d24a", "#ffffff"}, 3),
                                __mod(k, 3)
                            )
                        )
                        k = k + 1
                    end
                end
                x = x + 90
            end
        end
        __L1:R(
            c,
            0,
            158,
            __L1.LW,
            6,
            "#4f9a3f"
        )
        __L1:R(
            c,
            0,
            158,
            __L1.LW,
            1,
            "#8fcf6a"
        )
        if __gt(s.night, 0.05) then
            c.fillStyle = ("rgba(6,10,36," .. tostring(0.5 * s.night)) .. ")"
            c:fillRect(0, 0, __L1.LW, 164)
        end
        c:drawImage(
            __get(
                __get(__L1.mids, 10),
                0
            ),
            camL,
            0,
            __L1.LW,
            __L1.LH,
            0,
            0,
            __L1.LW,
            __L1.LH
        )
        do
            local kx = 1145 - camL
            if __t(kx > -30 and kx < __L1.LW + 30) then
                __L1:wallClock(
                    c,
                    kx,
                    71,
                    s.h,
                    16,
                    "#f0e3bb",
                    "#74614c"
                )
            end
        end
        for ____, x in __iterar((__L1.RY_PLANTS)) do
            do
                local sx = x - camL
                if __t(sx < -50 or sx > __L1.LW + 50) then
                    continue
                end
                do
                    local j = 0
                    while j < 5 do
                        local xx = sx + 11 + (j - 2) * 5 + math.sin(t + j) * 1
                        local yy = 169 - math.sin(t * 0.8 + j) * 1
                        __L1:limb(
                            c,
                            __arrL(
                                {
                                    __arrL({sx + 11, 184}, 2),
                                    __arrL({xx, yy}, 2)
                                },
                                2
                            ),
                            1,
                            "#466e4a"
                        )
                        __L1:ell(
                            c,
                            xx + (__t(__mod(j, 2)) and 5 or -5),
                            yy - 1,
                            6,
                            3,
                            __t(__mod(j, 2)) and "#6f9c60" or "#91b374"
                        )
                        j = j + 1
                    end
                end
            end
        end
        do
            local sx = 1205 - camL
            if __t(sx > -60 and sx < __L1.LW + 60) then
                do
                    local i = 0
                    while i < 4 do
                        local yy = 126 - __mod(t * 6.5 + i * 4, 18)
                        local xx = sx + math.sin(t + i) * 2.5
                        __L1:ell(
                            c,
                            xx,
                            yy,
                            3,
                            2,
                            "rgba(225,230,209,.55)"
                        )
                        i = i + 1
                    end
                end
            end
        end
        do
            local i = 0
            while i < 12 do
                local dx = __mod(
                    __mod(i * 69 + t * 1.5 - camL * 0.2, __L1.LW) + __L1.LW,
                    __L1.LW
                )
                local dy = 38 + __mod(i * 33 + t * 2, 160)
                __L1:R(
                    c,
                    dx,
                    dy,
                    1,
                    1,
                    "rgba(255,241,199,.5)"
                )
                i = i + 1
            end
        end
        for ____, ____value in __iterar((__L1.RY_SOFA)) do
            local x = ____value[1]
            if sun.str > 0.04 then
                __L1:slant(
                    c,
                    x - camL - 6,
                    x - camL + 128,
                    220,
                    sun.lean * 18,
                    3,
                    ("rgba(40,30,30," .. tostring(0.2 * sun.str)) .. ")"
                )
            end
        end
        if sun.str > 0.03 then
            local ____temp_203
            if s.sunT ~= nil then
                ____temp_203 = s.sun
            else
                ____temp_203 = __arrL({0.6, 0.7, 1}, 3)
            end
            local col = ____temp_203
            local lean = sun.lean
            local str = sun.str
            local ox = math.floor(lean * 30 + 0.5)
            for ____, w in __iterar((__L1.RY_WIN)) do
                do
                    local wx = w.x - camL
                    if __t(wx < -140 or wx > __L1.LW + 40) then
                        continue
                    end
                    for ____, ____value in __iterar((__arrL(
                        {
                            __arrL({0, 0}, 2),
                            __arrL({52, 0}, 2),
                            __arrL({0, 40}, 2),
                            __arrL({52, 40}, 2)
                        },
                        4
                    ))) do
                        local px = ____value[1]
                        local py = ____value[2]
                        local pw = __t(px) and 51 or 50
                        local ph = __t(py) and 36 or 38
                        local x0 = wx + px + ox * (__t(py) and 1.2 or 1)
                        local yy = 168 + (__t(py) and 24 or 6)
                        __L1:gquad2(
                            c,
                            __arrL(
                                {
                                    __arrL({x0, yy}, 2),
                                    __arrL({x0 + pw, yy}, 2),
                                    __arrL({x0 + pw + lean * 12, yy + ph * 0.5}, 2),
                                    __arrL({x0 + lean * 12, yy + ph * 0.5}, 2)
                                },
                                4
                            ),
                            __L1:css(col, 0.13 * str)
                        )
                    end
                end
            end
        end
    end
    __L1.gquad2 = function(self, c, pts, col)
        c.fillStyle = col
        c:beginPath()
        c:moveTo(
            __get(
                __get(pts, 0),
                0
            ),
            __get(
                __get(pts, 0),
                1
            )
        )
        do
            local i = 1
            while i < 4 do
                c:lineTo(
                    __get(
                        __get(pts, i),
                        0
                    ),
                    __get(
                        __get(pts, i),
                        1
                    )
                )
                i = i + 1
            end
        end
        c:closePath()
        __call(c, "fill")
    end
    __L1.rayssaText = function(self, c, camera)
        c:save()
        c:translate(
            -math.floor(camera + 0.5),
            0
        )
        c.textAlign = "center"
        c.textBaseline = "middle"
        c.font = "16px Pixel, monospace"
        c.fillStyle = "#fff0c9"
        c:fillText("CASA DE RAYSSA", 600, 82)
        c.font = "8px Pixel, monospace"
        c.fillStyle = "#dce7bc"
        c:fillText("PORTA ABERTA · CAFÉ NA MESA · RESENHA EM DIA", 600, 100)
        c.fillStyle = "#4b6257"
        for ____, ____value in __iterar((__L1.RY_ART)) do
            local x = ____value[1]
            local label = ____value[2]
            c:fillText(label, (x + 51) * 2, 226)
        end
        c:restore()
    end
    __L1.rayssaLights = function(self, g, s, t, camL)
        local a = __L1:cl((s.night - 0.12) * 1.4)
        local base = 0.3 + a * 0.7
        local sun = __L1:sunInfo(s)
        local ____temp_204
        if s.sunT ~= nil then
            ____temp_204 = s.sun
        else
            ____temp_204 = __arrL({0.6, 0.7, 1}, 3)
        end
        local col = ____temp_204
        if sun.str > 0.03 then
            for ____, w in __iterar((__L1.RY_WIN)) do
                do
                    local wx = w.x - camL
                    if __t(wx < -150 or wx > __L1.LW + 60) then
                        continue
                    end
                    local sh = sun.lean * 40
                    for ____, ____value in __iterar((__arrL(
                        {
                            __arrL({0, 0}, 2),
                            __arrL({52, 0}, 2),
                            __arrL({0, 40}, 2),
                            __arrL({52, 40}, 2)
                        },
                        4
                    ))) do
                        local px = ____value[1]
                        local py = ____value[2]
                        local pw = __t(px) and 50 or 50
                        local ph = __t(py) and 35 or 38
                        __L1:gquad(
                            g,
                            __arrL(
                                {
                                    __arrL({wx + px, w.y + py}, 2),
                                    __arrL({wx + px + pw, w.y + py}, 2),
                                    __arrL({wx + px + pw + sh, 176 + py * 0.3}, 2),
                                    __arrL({wx + px + sh, 176 + py * 0.3}, 2)
                                },
                                4
                            ),
                            __L1:css(col, 0.05 * sun.str)
                        )
                    end
                end
            end
        end
        for ____, x in __iterar((__L1.RY_LAMPS)) do
            do
                local sx = x - camL
                if __t(sx < -90 or sx > __L1.LW + 90) then
                    continue
                end
                __L1:lightAdd(sx, 36, base * 0.8, 56)
                __L1:bulbGlow(
                    g,
                    sx,
                    36,
                    base,
                    "255,214,150",
                    34
                )
                local gr = g:createLinearGradient(0, 36, 0, 240)
                gr:addColorStop(
                    0,
                    ("rgba(255,222,160," .. tostring(0.24 * base)) .. ")"
                )
                gr:addColorStop(
                    1,
                    ("rgba(255,222,160," .. tostring(0.03 * base)) .. ")"
                )
                g.fillStyle = gr
                g:beginPath()
                g:moveTo(sx - 8, 36)
                g:lineTo(sx + 8, 36)
                g:lineTo(sx + 56, 236)
                g:lineTo(sx - 56, 236)
                g:closePath()
                __call(g, "fill")
                __L1:pool(
                    g,
                    sx,
                    226,
                    base,
                    "255,214,150",
                    54
                )
            end
        end
        __L1:bulbGlow(
            g,
            1205 - camL,
            138,
            0.3 + a * 0.6,
            "255,190,100",
            34
        )
        for ____, w in __iterar((__L1.RY_WIN)) do
            __L1:bulbGlow(
                g,
                w.x + 51 - camL,
                100,
                a * 0.3,
                "150,170,255",
                40
            )
        end
    end
    __L1.aLayer = function(self, key, build)
        if not __t(__get(__L1.arenaLayers, key)) then
            local cv, c = table.unpack(
                __L1:mk(__L1.AW, __L1.LH),
                1,
                2
            )
            c:translate(__L1.AO, 0)
            build(nil, c)
            __set(__L1.arenaLayers, key, cv)
        end
        return __get(__L1.arenaLayers, key)
    end
    __L1.arenaGround = function(self, c, base, dark, line, top, step)
        __L1:R(
            c,
            __TS__Number(-__L1.AO),
            __L1.FLOOR,
            __L1.AW,
            50,
            base
        )
        __L1:R(
            c,
            __TS__Number(-__L1.AO),
            240,
            __L1.AW,
            30,
            dark
        )
        __L1:dither(
            c,
            __TS__Number(-__L1.AO),
            239,
            __L1.AW,
            dark
        )
        do
            local x = __TS__Number(-__L1.AO)
            while x < __L1.AW - __L1.AO do
                __L1:R(
                    c,
                    x,
                    225,
                    1,
                    45,
                    line
                )
                __L1:R(
                    c,
                    x + 1,
                    225,
                    1,
                    45,
                    "rgba(255,255,255,.14)"
                )
                x = x + step
            end
        end
        __L1:R(
            c,
            __TS__Number(-__L1.AO),
            248,
            __L1.AW,
            1,
            line
        )
        do
            local i = 0
            while i < 700 do
                __L1:R(
                    c,
                    __TS__Number(-__L1.AO) + __L1:hash(i + 223) * __L1.AW,
                    226 + __L1:hash(i + 224) * 43,
                    1 + __L1:hash(i) * 2,
                    1,
                    __t(__mod(i, 3)) and "rgba(0,0,0,.12)" or "rgba(255,255,255,.14)"
                )
                i = i + 1
            end
        end
        __L1:R(
            c,
            __TS__Number(-__L1.AO),
            __L1.FLOOR,
            __L1.AW,
            3,
            top
        )
        __L1:R(
            c,
            __TS__Number(-__L1.AO),
            __L1.FLOOR,
            __L1.AW,
            1,
            "rgba(255,255,255,.4)"
        )
        __L1:R(
            c,
            __TS__Number(-__L1.AO),
            __L1.FLOOR + 3,
            __L1.AW,
            2,
            line
        )
    end
    __L1.poly = function(self, c, pts, col)
        c.fillStyle = col
        c:beginPath()
        c:moveTo(
            __get(
                __get(pts, 0),
                0
            ),
            __get(
                __get(pts, 0),
                1
            )
        )
        do
            local i = 1
            while __lt(
                i,
                __len(pts)
            ) do
                c:lineTo(
                    __get(
                        __get(pts, i),
                        0
                    ),
                    __get(
                        __get(pts, i),
                        1
                    )
                )
                i = i + 1
            end
        end
        c:closePath()
        __call(c, "fill")
    end
    __L1.hillLine = function(self, c, x0, x1, base, amp, seed, fill, edge, edgeW)
        if edgeW == nil then
            edgeW = 1
        end
        do
            local x = x0
            while __lt(x, x1) do
                local y = math.floor(base - amp * (0.55 + 0.45 * math.sin(x * 0.021 + seed)) * (0.6 + 0.4 * math.sin(x * 0.053 + seed * 2)) - math.sin(x * 0.17 + seed) * 2 + 0.5)
                __L1:R(
                    c,
                    x,
                    y,
                    1,
                    __L1.LH - y,
                    fill
                )
                if __t(edge) then
                    __L1:R(
                        c,
                        x,
                        y,
                        1,
                        edgeW,
                        edge
                    )
                end
                x = x + 1
            end
        end
    end
    __L1.cakeHD = function(self, c, x, y)
        __L1:R(
            c,
            x - 14,
            y - 2,
            28,
            3,
            "#e8d8c0"
        )
        __L1:R(
            c,
            x - 12,
            y - 10,
            24,
            9,
            "#7a4a30"
        )
        __L1:R(
            c,
            x - 12,
            y - 10,
            24,
            2,
            "#e8c898"
        )
        __L1:R(
            c,
            x - 9,
            y - 18,
            18,
            8,
            "#a8603c"
        )
        __L1:R(
            c,
            x - 9,
            y - 18,
            18,
            2,
            "#f0d8a8"
        )
        do
            local k = 0
            while k < 6 do
                __L1:R(
                    c,
                    x - 11 + k * 4,
                    y - 9,
                    2,
                    3 + __mod(k, 2) * 2,
                    "#f6ecd0"
                )
                k = k + 1
            end
        end
        __L1:R(
            c,
            x - 3,
            y - 25,
            6,
            7,
            "#f6ecd0"
        )
        __L1:R(
            c,
            x - 1,
            y - 30,
            2,
            5,
            "#c94f45"
        )
        __L1:R(
            c,
            x - 2,
            y - 32,
            4,
            3,
            "#e04a3a"
        )
        __L1:R(
            c,
            x - 2,
            y - 32,
            1,
            1,
            "#ff9a8a"
        )
    end
    __L1.student = function(self, c, x, y, n, t, cheer)
        local ____t_result_205
        if __t(cheer) then
            ____t_result_205 = math.floor(math.max(
                0,
                math.sin(t * (4 + __L1:hash(n) * 2.5) + n)
            ) * 2 + 0.5)
        else
            ____t_result_205 = 0
        end
        local bob = ____t_result_205
        local yy = y - bob
        local sk = __get(
            __L1.FAN_SKIN,
            __mod(n, 5)
        )
        __L1:R(
            c,
            x,
            yy + 5,
            7,
            6,
            __get(
                __L1.FAN_SHIRT,
                __mod(n, 6)
            )
        )
        __L1:R(
            c,
            x + 1,
            yy,
            5,
            5,
            sk
        )
        __L1:R(
            c,
            x + 1,
            yy - 1,
            5,
            2,
            __get(
                __L1.FAN_HAIR,
                __mod(n * 3, 5)
            )
        )
        __L1:R(
            c,
            x + 2,
            yy + 2,
            1,
            1,
            "#1c1c22"
        )
        __L1:R(
            c,
            x + 4,
            yy + 2,
            1,
            1,
            "#1c1c22"
        )
        local ____t_207 = __t
        local ____t_result_206
        if __t(cheer) then
            ____t_result_206 = __mod(
                n + math.floor(t * 1.6),
                4
            ) == 0
        else
            ____t_result_206 = cheer
        end
        if ____t_207(____t_result_206) then
            __L1:R(
                c,
                x - 1,
                yy - 4,
                2,
                8,
                sk
            )
            __L1:R(
                c,
                x + 6,
                yy - 4,
                2,
                8,
                sk
            )
        end
    end
    __L1.favRow = function(self, c, y0, step, hmin, hmax, haze, litP, seed, night)
        local ____t_result_208
        if __t(night) then
            ____t_result_208 = __arrL({0.1, 0.12, 0.18}, 3)
        else
            ____t_result_208 = __arrL({0.62, 0.55, 0.62}, 3)
        end
        local base = ____t_result_208
        do
            local x = __TS__Number(-__L1.AO)
            local i = 0
            while x < __L1.AW - __L1.AO do
                local w = step - 2 - math.floor(__L1:hash(i + seed) * 6 + 0.5)
                local h = hmin + math.floor(__L1:hash(i + seed + 7) * (hmax - hmin) + 0.5)
                local y = y0 - h
                local body = __L1:css(__L1:mix(
                    __L1:hexv(__get(
                        __L1.FV_COL,
                        __mod(i + seed, 8)
                    )),
                    base,
                    haze
                ))
                __L1:R(
                    c,
                    x,
                    y,
                    w,
                    h + 60,
                    body
                )
                __L1:R(
                    c,
                    x - 1,
                    y - 2,
                    w + 2,
                    2,
                    __L1:css(__L1:mix(
                        __arrL({0.45, 0.42, 0.4}, 3),
                        base,
                        haze
                    ))
                )
                __L1:R(
                    c,
                    x,
                    y,
                    1,
                    h,
                    "rgba(255,255,255,.1)"
                )
                __L1:R(
                    c,
                    x + w - 2,
                    y,
                    2,
                    h,
                    "rgba(0,0,0,.18)"
                )
                do
                    local wy = y + 5
                    while wy < y0 - 4 do
                        do
                            local wx = x + 3
                            while wx < x + w - 5 do
                                local on = __lt(
                                    __L1:hash(i * 31 + wx * 3 + wy + seed),
                                    litP
                                )
                                local ____L1_R_211 = __L1.R
                                local ____array_210 = __TS__SparseArrayNew(
                                    c,
                                    wx,
                                    wy,
                                    4,
                                    5
                                )
                                local ____t_result_209
                                if __t(on) then
                                    ____t_result_209 = __L1:hash(wx + wy) > 0.5 and "#ffd27a" or "#ffe9b8"
                                else
                                    ____t_result_209 = __L1:css(__L1:mix(
                                        __arrL({0.16, 0.2, 0.26}, 3),
                                        base,
                                        haze * 0.6
                                    ))
                                end
                                __TS__SparseArrayPush(____array_210, ____t_result_209)
                                ____L1_R_211(
                                    __L1,
                                    __TS__SparseArraySpread(____array_210)
                                )
                                wx = wx + 8
                            end
                        end
                        wy = wy + 9
                    end
                end
                if __L1:hash(i + seed + 3) > 0.6 then
                    __L1:R(
                        c,
                        x + 3,
                        y - 6,
                        9,
                        5,
                        __L1:css(__L1:mix(
                            __arrL({0.17, 0.37, 0.58}, 3),
                            base,
                            haze
                        ))
                    )
                end
                if __L1:hash(i + seed + 5) > 0.7 then
                    __L1:R(
                        c,
                        x + w - 5,
                        y - 9,
                        1,
                        8,
                        __L1:css(__L1:mix(
                            __arrL({0.3, 0.3, 0.3}, 3),
                            base,
                            haze
                        ))
                    )
                end
                do
                    x = x + step
                    i = i + 1
                end
            end
        end
    end
    __L1.hillLights = function(self, c, base, amp, seed, fill, dots)
        __L1:hillLine(
            c,
            __TS__Number(-__L1.AO),
            __L1.AW - __L1.AO,
            base,
            amp,
            seed,
            fill
        )
        do
            local i = 0
            while __lt(i, dots) do
                local x = __TS__Number(-__L1.AO) + __L1:hash(i + seed * 13) * __L1.AW
                local top = math.floor(base - amp * (0.55 + 0.45 * math.sin(x * 0.021 + seed)) * (0.6 + 0.4 * math.sin(x * 0.053 + seed * 2)) - math.sin(x * 0.17 + seed) * 2 + 0.5)
                local y = top + 3 + __L1:hash(i + seed * 7) * (base + 30 - top)
                __L1:R(
                    c,
                    x,
                    y,
                    1,
                    1,
                    __L1:hash(i) > 0.3 and "#ffd27a" or "#bfe0ff"
                )
                i = i + 1
            end
        end
    end
    __L1.speakerTower = function(self, c, x)
        __L1:R(
            c,
            x,
            70,
            5,
            104,
            "#344a59"
        )
        __L1:R(
            c,
            x,
            70,
            1,
            104,
            "#5a7080"
        )
        __L1:R(
            c,
            x - 11,
            64,
            27,
            8,
            "#263b4b"
        )
        do
            local j = 0
            while j < 4 do
                __L1:R(
                    c,
                    x - 9 + j * 6,
                    66,
                    4,
                    4,
                    "#f7d997"
                )
                j = j + 1
            end
        end
        __L1:R(
            c,
            x - 14,
            135,
            33,
            40,
            "#1c2a33"
        )
        __L1:R(
            c,
            x - 12,
            137,
            29,
            36,
            "#3a4a52"
        )
        for ____, cy in __iterar((__arrL({147, 163}, 2))) do
            __L1:ell(
                c,
                x + 2,
                cy,
                9,
                9,
                "#141e24"
            )
            __L1:ell(
                c,
                x + 2,
                cy,
                6,
                6,
                "#8a9a92"
            )
            __L1:ell(
                c,
                x + 2,
                cy,
                2,
                2,
                "#2a3a40"
            )
        end
    end
    __L1.buildRoom = function(self, en)
        local cv, c = table.unpack(
            __L1:mk(__L1.LW, __L1.LH),
            1,
            2
        )
        local wallA = __t(en) and "#e3eef0" or "#e9f2f3"
        local line = __t(en) and "#c3b4a5" or "#9ab8c1"
        __L1:R(
            c,
            0,
            14,
            __L1.LW,
            160,
            wallA
        )
        do
            local row = 0
            while row < 7 do
                do
                    local col = 0
                    while col < 17 do
                        local x = col * 31 + __mod(row, 2) * 15.5
                        local y = 22 + row * 23.5
                        __L1:R(
                            c,
                            x,
                            y,
                            27,
                            1,
                            line
                        )
                        __L1:R(
                            c,
                            x,
                            y,
                            1,
                            20,
                            line
                        )
                        col = col + 1
                    end
                end
                row = row + 1
            end
        end
        do
            local i = 0
            while i < 700 do
                __L1:R(
                    c,
                    __L1:hash(i + 3) * __L1.LW,
                    16 + __L1:hash(i + 4) * 156,
                    1,
                    1,
                    __t(__mod(i, 2)) and "rgba(0,0,0,.04)" or "rgba(255,255,255,.3)"
                )
                i = i + 1
            end
        end
        __L1:R(
            c,
            0,
            0,
            __L1.LW,
            14,
            "#1c3f64"
        )
        __L1:R(
            c,
            0,
            14,
            __L1.LW,
            4,
            "#e8dec1"
        )
        __L1:R(
            c,
            0,
            14,
            __L1.LW,
            1,
            "#fff6dc"
        )
        __L1:R(
            c,
            0,
            18,
            __L1.LW,
            1,
            "rgba(0,0,0,.18)"
        )
        do
            local x = 30
            while x < __L1.LW do
                __L1:R(
                    c,
                    x,
                    10,
                    44,
                    3,
                    "#55656e"
                )
                __L1:R(
                    c,
                    x,
                    10,
                    44,
                    1,
                    "#738790"
                )
                x = x + 120
            end
        end
        __L1:R(
            c,
            0,
            174,
            __L1.LW,
            46,
            "#2d5278"
        )
        __L1:R(
            c,
            0,
            172,
            __L1.LW,
            4,
            "#e8d8b2"
        )
        __L1:R(
            c,
            0,
            172,
            __L1.LW,
            1,
            "#fff2d0"
        )
        do
            local x = 0
            while x < __L1.LW do
                __L1:R(
                    c,
                    x + 2,
                    180,
                    20,
                    34,
                    "#33608a"
                )
                __L1:R(
                    c,
                    x + 2,
                    180,
                    20,
                    1,
                    "#4a7aa4"
                )
                __L1:R(
                    c,
                    x + 2,
                    213,
                    20,
                    1,
                    "#22446a"
                )
                x = x + 24
            end
        end
        __L1:R(
            c,
            0,
            216,
            __L1.LW,
            4,
            "#1c3a5a"
        )
        c:save()
        local ____L1_tileFloor_214 = __L1.tileFloor
        local ____array_213 = __TS__SparseArrayNew(c, __L1.LW, __L1.FLOOR)
        local ____t_result_212
        if __t(en) then
            ____t_result_212 = __arrL({"#d8c8b0", "#b8a48a", "#e6d8c0", "#c8b49a"}, 4)
        else
            ____t_result_212 = __arrL({"#cfd8d0", "#aebcb4", "#dde6de", "#bccac2"}, 4)
        end
        __TS__SparseArrayPush(____array_213, ____t_result_212, 18)
        ____L1_tileFloor_214(
            __L1,
            __TS__SparseArraySpread(____array_213)
        )
        c:restore()
        for ____, w in __iterar((__L1.ROOM_WIN)) do
            w.slats = __L1:winBlind(
                c,
                w.x,
                w.y,
                w.w,
                w.h,
                0,
                w.open
            )
        end
        __L1:R(
            c,
            18,
            118,
            52,
            102,
            "#4a4234"
        )
        __L1:R(
            c,
            20,
            120,
            48,
            100,
            "#665d4c"
        )
        __L1:R(
            c,
            23,
            123,
            42,
            97,
            __t(en) and "#7b7a83" or "#6d8c97"
        )
        __L1:R(
            c,
            23,
            123,
            2,
            97,
            "rgba(255,255,255,.2)"
        )
        __L1:R(
            c,
            27,
            130,
            33,
            46,
            "#a9c5c8"
        )
        __L1:R(
            c,
            29,
            132,
            29,
            42,
            "#d3dfcf"
        )
        do
            local k = 0
            while k < 30 do
                __L1:R(
                    c,
                    32 + math.floor((30 - k) * 0.3 + 0.5),
                    134 + k,
                    3,
                    1,
                    "rgba(255,255,255,.45)"
                )
                k = k + 1
            end
        end
        __L1:R(
            c,
            56,
            188,
            3,
            3,
            "#edcc86"
        )
        __L1:R(
            c,
            16,
            216,
            56,
            4,
            "#d1bd91"
        )
        __L1:R(
            c,
            24,
            104,
            41,
            12,
            "#2a6a4a"
        )
        __L1:R(
            c,
            25,
            105,
            39,
            10,
            "#3e8a5b"
        )
        __L1:R(
            c,
            25,
            105,
            39,
            1,
            "#7ad09a"
        )
        __L1:R(
            c,
            145,
            30,
            190,
            88,
            "#5a4a34"
        )
        __L1:R(
            c,
            147,
            32,
            186,
            84,
            "#8f7653"
        )
        __L1:R(
            c,
            147,
            32,
            186,
            2,
            "#b8996c"
        )
        __L1:R(
            c,
            151,
            36,
            178,
            76,
            __t(en) and "#2f5f4a" or "#2f6a62"
        )
        do
            local i = 0
            while i < 260 do
                __L1:R(
                    c,
                    152 + __L1:hash(i + 9) * 176,
                    37 + __L1:hash(i + 10) * 74,
                    2,
                    1,
                    __t(__mod(i, 2)) and "rgba(255,255,255,.05)" or "rgba(0,0,0,.08)"
                )
                i = i + 1
            end
        end
        do
            local k = 0
            while k < 60 do
                __L1:R(
                    c,
                    160 + math.floor((60 - k) * 0.5 + 0.5),
                    38 + k,
                    6,
                    1,
                    "rgba(255,255,255,.035)"
                )
                k = k + 1
            end
        end
        __L1:R(
            c,
            145,
            116,
            190,
            4,
            "#bd9f69"
        )
        __L1:R(
            c,
            145,
            116,
            190,
            1,
            "#e8cf98"
        )
        __L1:R(
            c,
            152,
            113,
            10,
            3,
            "#eee9c7"
        )
        __L1:R(
            c,
            165,
            114,
            6,
            2,
            "#f0c8d0"
        )
        __L1:R(
            c,
            304,
            112,
            18,
            4,
            "#c6b37e"
        )
        __L1:R(
            c,
            305,
            113,
            16,
            2,
            "#85998b"
        )
        if __t(en) then
            do
                local k = 0
                while k < 16 do
                    __L1:R(
                        c,
                        300 + k,
                        96 + math.floor(math.sin(k * 0.5) * 2 + 0.5),
                        1,
                        1,
                        "rgba(255,255,255,.7)"
                    )
                    k = k + 1
                end
            end
            __L1:R(
                c,
                302,
                90,
                12,
                3,
                "rgba(255,255,255,.6)"
            )
            __L1:R(
                c,
                304,
                86,
                8,
                4,
                "rgba(255,255,255,.6)"
            )
            __L1:R(
                c,
                307,
                82,
                2,
                4,
                "rgba(255,200,200,.8)"
            )
        else
            local ax = 312
            local ay = 94
            do
                local a = 0
                while a < 3 do
                    do
                        local k = 0
                        while k < 40 do
                            local an = k / 40 * 6.28
                            __L1:R(
                                c,
                                ax + math.cos(an) * 11 * (a == 0 and 1 or 0.4) * (a == 2 and 0.4 or 1),
                                ay + math.sin(an) * 11 * (a == 1 and 1 or 0.35) * (a == 0 and 0.35 or 1),
                                1,
                                1,
                                "rgba(255,255,255,.75)"
                            )
                            k = k + 1
                        end
                    end
                    a = a + 1
                end
            end
            __L1:R(
                c,
                ax - 1,
                ay - 1,
                3,
                3,
                "#ffe9a0"
            )
        end
        for ____, ____value in __iterar((__arrL(
            {
                __arrL(
                    {
                        80,
                        __t(en) and "#74627f" or "#597687"
                    },
                    2
                ),
                __arrL(
                    {
                        354,
                        __t(en) and "#74627f" or "#597687"
                    },
                    2
                )
            },
            2
        ))) do
            local x = ____value[1]
            local col = ____value[2]
            __L1:R(
                c,
                x - 1,
                110,
                49,
                32,
                "#8b785d"
            )
            __L1:R(
                c,
                x,
                111,
                47,
                30,
                "#f0dfb0"
            )
            __L1:R(
                c,
                x + 4,
                114,
                39,
                3,
                col
            )
            __L1:R(
                c,
                x + 21,
                108,
                4,
                4,
                "#c94f45"
            )
        end
        __L1:R(
            c,
            368,
            182,
            73,
            7,
            "#ac8756"
        )
        __L1:R(
            c,
            368,
            182,
            73,
            2,
            "#d0a870"
        )
        __L1:R(
            c,
            371,
            189,
            5,
            31,
            "#786846"
        )
        __L1:R(
            c,
            433,
            189,
            5,
            31,
            "#786846"
        )
        __L1:R(
            c,
            376,
            190,
            52,
            18,
            "#9b7c50"
        )
        __L1:R(
            c,
            376,
            190,
            52,
            1,
            "#b8956a"
        )
        __L1:R(
            c,
            392,
            196,
            3,
            2,
            "#d5bf87"
        )
        __L1:R(
            c,
            380,
            176,
            17,
            6,
            __t(en) and "#678b6f" or "#7b96a6"
        )
        __L1:R(
            c,
            381,
            175,
            15,
            2,
            "#e7deb7"
        )
        __L1:R(
            c,
            380,
            170,
            13,
            6,
            "#c94f45"
        )
        __L1:R(
            c,
            381,
            169,
            11,
            2,
            "#e8786a"
        )
        __L1:R(
            c,
            412,
            175,
            7,
            7,
            "#d4ba7d"
        )
        __L1:R(
            c,
            413,
            170,
            1,
            6,
            "#7c8460"
        )
        __L1:R(
            c,
            415,
            168,
            1,
            8,
            "#a8684b"
        )
        __L1:ell(
            c,
            428,
            179,
            3,
            3,
            "#d83a3a"
        )
        __L1:R(
            c,
            428,
            175,
            1,
            2,
            "#5a8a3a"
        )
        return cv
    end
    __L1.drawRoom = function(self, c, id, t)
        local ____t_222 = __t
        local ____t_result_221
        local ____t_220 = __t
        local ____opt_217 = window.Graphics
        if ____opt_217 ~= nil then
            ____opt_217 = ____opt_217.isLite
        end
        local ____opt_result_219
        if ____opt_217 ~= nil then
            ____opt_result_219 = ____opt_217(____opt_217)
        end
        __O[319] = ____opt_result_219
        if ____t_220(____opt_result_219) then
            ____t_result_221 = __O[319]
        else
            ____t_result_221 = not __t(window.DayTime)
        end
        if ____t_222(____t_result_221) then
            return false
        end
        local en = id == "miqueias"
        local s = window.DayTime:state()
        local am = __L1:roomAmb(0.6)(nil, s)
        if not __t(__L1.far) then
            __L1.far = __L1:buildFar()
        end
        if not __t(__get(__L1.roomLayers, id)) then
            __set(
                __L1.roomLayers,
                id,
                __L1:buildRoom(en)
            )
        end
        lc:clearRect(0, 0, __L1.LW, __L1.LH)
        __L1:sky(
            lc,
            s,
            t,
            0,
            {
                amb = am,
                sb = 120,
                sa = 70,
                mb = 110,
                ma = 60
            }
        )
        __L1:tile(
            lc,
            __get(__L1.far, 1),
            300
        )
        __L1:tile(
            lc,
            __get(__L1.far, 2),
            500
        )
        do
            local x = 60
            while x < 420 do
                __L1:ell(
                    lc,
                    x + math.sin(t * 1.2 + x) * 1,
                    88,
                    12,
                    10,
                    "#3f8a46"
                )
                __L1:ell(
                    lc,
                    x - 3,
                    84,
                    6,
                    4,
                    "#68ad58"
                )
                x = x + 26
            end
        end
        if __gt(s.night, 0.05) then
            lc.fillStyle = ("rgba(6,10,36," .. tostring(0.5 * s.night)) .. ")"
            lc:fillRect(0, 0, __L1.LW, 172)
        end
        lc:drawImage(
            __get(__L1.roomLayers, id),
            0,
            0
        )
        __L1:wallClock(
            lc,
            240,
            24,
            s.h,
            8,
            "#f6f2e2",
            "#1c3f64"
        )
        do
            local row = 0
            while row < 3 do
                do
                    local col = 0
                    while col < 4 do
                        local i = row * 4 + col
                        local x = math.floor(122 + col * 69.5 + 0.5)
                        local y = math.floor(129 + row * 23.5 + 0.5)
                        local bob = math.floor(math.sin(t * 1.7 + i) * 0.6 + 0.5)
                        local sk = __get(
                            __L1.RSKIN,
                            __mod(i, 4)
                        )
                        __L1:R(
                            lc,
                            x - 8,
                            y + 7,
                            18,
                            11,
                            "#337ab3"
                        )
                        __L1:R(
                            lc,
                            x - 7,
                            y - 1 + bob,
                            15,
                            12,
                            __mod(i, 3) == 0 and "#e3ebed" or "#244e7b"
                        )
                        __L1:R(
                            lc,
                            x - 5,
                            y - 11 + bob,
                            11,
                            10,
                            "#4b4034"
                        )
                        __L1:R(
                            lc,
                            x - 4,
                            y - 10 + bob,
                            9,
                            8,
                            sk
                        )
                        __L1:R(
                            lc,
                            x - 5,
                            y - 12 + bob,
                            11,
                            4,
                            __get(
                                __L1.RHAIR,
                                __mod(i, 4)
                            )
                        )
                        __L1:R(
                            lc,
                            x - 5,
                            y - 9 + bob,
                            2,
                            4,
                            __get(
                                __L1.RHAIR,
                                __mod(i, 4)
                            )
                        )
                        __L1:R(
                            lc,
                            x + 2,
                            y - 6 + bob,
                            1,
                            1,
                            "#393c31"
                        )
                        if math.sin(t * 3 + i * 2) > 0.92 then
                            __L1:R(
                                lc,
                                x + 1,
                                y - 6 + bob,
                                3,
                                1,
                                "#76513a"
                            )
                        end
                        __L1:R(
                            lc,
                            x + 7 + math.floor(math.sin(t * 3 + i) * 1 + 0.5),
                            y + 6,
                            4,
                            2,
                            sk
                        )
                        __L1:R(
                            lc,
                            x - 19,
                            y + 9,
                            40,
                            4,
                            "#8e714d"
                        )
                        __L1:R(
                            lc,
                            x - 19,
                            y + 9,
                            40,
                            1,
                            "#d2b27a"
                        )
                        __L1:R(
                            lc,
                            x - 16,
                            y + 13,
                            2,
                            10,
                            "#65735e"
                        )
                        __L1:R(
                            lc,
                            x + 15,
                            y + 13,
                            2,
                            10,
                            "#65735e"
                        )
                        __L1:R(
                            lc,
                            x - 8,
                            y + 7,
                            12,
                            2,
                            "#f0e5bb"
                        )
                        __L1:R(
                            lc,
                            x - 6,
                            y + 7,
                            6,
                            1,
                            "#72908a"
                        )
                        __L1:R(
                            lc,
                            x + 9,
                            y + 7,
                            6,
                            1,
                            "#cfb065"
                        )
                        col = col + 1
                    end
                end
                row = row + 1
            end
        end
        c:save()
        c.imageSmoothingEnabled = false
        c:drawImage(
            low,
            0,
            0,
            960,
            540
        )
        c.textAlign = "center"
        c.textBaseline = "middle"
        c.font = "16px Pixel, monospace"
        c.fillStyle = "#e8f4ee"
        c:fillText(
            __t(en) and "MY ENGLISH IS VERY BOM TODAY!" or "CIÊNCIAS DA ROÇA",
            480,
            98
        )
        c.font = "8px Pixel, monospace"
        c.fillStyle = "#f2e8a8"
        local ____t_result_223
        if __t(en) then
            ____t_result_223 = __arrL({"The bolo are disappear.", "You is ready? ALLRIGHT!", "BELEZA CREUZA! CONCORDA OU SEM CORDA?"}, 3)
        else
            ____t_result_223 = __arrL({"Bolo + sapo = aventura", "Hipótese: o bolo foi roubado.", "Observação + amizade + muita coragem"}, 3)
        end
        local L = ____t_result_223
        __call(
            L,
            "forEach",
            function(____, l, k) return c:fillText(l, 450, 136 + k * 20) end
        )
        c.fillStyle = "#f4eccb"
        c:fillText("← SAÍDA", 89, 220)
        c.fillStyle = __t(en) and "#74627f" or "#597687"
        local ____t_result_224
        if __t(en) then
            ____t_result_224 = __arrL(
                {
                    __arrL({"BOOK = LIVRO", "CAKE = BOLO"}, 2),
                    __arrL({"HELLO, TURMA!", "GOOD LANCHE!"}, 2)
                },
                2
            )
        else
            ____t_result_224 = __arrL(
                {
                    __arrL({"PENSE. OBSERVE.", "FAÇA PERGUNTAS."}, 2),
                    __arrL({"AULA COM HUMOR", "E CURIOSIDADE!"}, 2)
                },
                2
            )
        end
        local P = ____t_result_224
        __call(
            P,
            "forEach",
            function(____, p, k)
                local x = (__t(k) and 354 or 80) * 2 + 47
                c:fillText(
                    __get(p, 0),
                    x,
                    248
                )
                c:fillText(
                    __get(p, 1),
                    x,
                    266
                )
            end
        )
        c.globalCompositeOperation = "multiply"
        c.fillStyle = __L1:css(am)
        c:fillRect(0, 0, 960, 540)
        c.globalCompositeOperation = "source-over"
        lg:clearRect(0, 0, __L1.LW, __L1.LH)
        __L1:blindsLight(
            lg,
            s,
            t,
            __L1.ROOM_WIN,
            0,
            __L1.LW
        )
        local a = __L1:cl((s.night - 0.12) * 1.4)
        local base = 0.12 + a * 0.78
        do
            local x = 30
            while x < __L1.LW do
                local sx = x + 22
                local gr = lg:createLinearGradient(0, 13, 0, 230)
                gr:addColorStop(
                    0,
                    ("rgba(240,248,255," .. tostring(0.22 * base)) .. ")"
                )
                gr:addColorStop(
                    1,
                    ("rgba(240,248,255," .. tostring(0.03 * base)) .. ")"
                )
                lg.fillStyle = gr
                lg:beginPath()
                lg:moveTo(sx - 22, 13)
                lg:lineTo(sx + 22, 13)
                lg:lineTo(sx + 60, 230)
                lg:lineTo(sx - 60, 230)
                lg:closePath()
                __call(lg, "fill")
                __L1:bulbGlow(
                    lg,
                    sx,
                    12,
                    base * 0.8,
                    "240,248,255",
                    26
                )
                x = x + 120
            end
        end
        c.globalCompositeOperation = "lighter"
        c:drawImage(
            lightCv,
            0,
            0,
            960,
            540
        )
        c:restore()
        return true
    end
    __L1.drawArena = function(self, c, ____type, camera, t, homeX)
        local ____temp_225
        if type(____type) == "table" then
            ____temp_225 = ____type.type
        else
            ____temp_225 = ____type
        end
        ____type = ____temp_225
        local a = __get(__L1.ARENA, ____type)
        local s = window.DayTime:state()
        local ____t_result_226
        if __t(homeX) then
            ____t_result_226 = homeX - camera
        else
            ____t_result_226 = 480
        end
        local center = ____t_result_226
        local ox = math.floor((center - 480) / 2 + 0.5)
        ac:clearRect(0, 0, __L1.LW, __L1.LH)
        local ____opt_227 = a.back
        if ____opt_227 ~= nil then
            ____opt_227(
                a,
                ac,
                s,
                t,
                ox
            )
        end
        __call(
            a.layers,
            "forEach",
            function(____, ____bindingPattern0, i)
                local build
                local key
                local p
                p = ____bindingPattern0[1]
                key = ____bindingPattern0[2]
                build = ____bindingPattern0[3]
                ac:drawImage(
                    __L1:aLayer(key, build),
                    math.floor(ox * p + 0.5) - __L1.AO,
                    0
                )
                if i == __len(a.layers) - 2 then
                    local ____opt_229 = a.mid
                    if ____opt_229 ~= nil then
                        ____opt_229(
                            a,
                            ac,
                            s,
                            t,
                            ox
                        )
                    end
                end
            end
        )
        local ____opt_231 = a.near
        if ____opt_231 ~= nil then
            ____opt_231(
                a,
                ac,
                s,
                t,
                ox
            )
        end
        c:save()
        c.imageSmoothingEnabled = false
        c:drawImage(
            alow,
            0,
            0,
            960,
            540
        )
        local ____opt_233 = a.text
        if ____opt_233 ~= nil then
            ____opt_233(a, c, t, ox)
        end
        c:restore()
        if __t(a.daytime) then
            c:save()
            c.globalCompositeOperation = "multiply"
            c.fillStyle = __L1:css(s.amb)
            c:fillRect(0, 0, 960, 540)
            c:restore()
        end
    end
    __L1.arenaFront = function(self, c, ____type, camera, t, homeX, blend)
        local ____temp_235
        if type(____type) == "table" then
            ____temp_235 = ____type.type
        else
            ____temp_235 = ____type
        end
        ____type = ____temp_235
        if not __t(__L1:arenaHandles(____type)) then
            return
        end
        local a = __get(__L1.ARENA, ____type)
        if not __t(a.light) then
            return
        end
        local s = window.DayTime:state()
        local ____t_result_236
        if __t(homeX) then
            ____t_result_236 = homeX - camera
        else
            ____t_result_236 = 480
        end
        local center = ____t_result_236
        local ox = math.floor((center - 480) / 2 + 0.5)
        lg:clearRect(0, 0, __L1.LW, __L1.LH)
        lg:save()
        lg:translate(ox, 0)
        a:light(lg, s, t)
        lg:restore()
        c:save()
        c.globalCompositeOperation = "lighter"
        c.globalAlpha = __L1:cl(blend)
        c.imageSmoothingEnabled = false
        c:drawImage(
            lightCv,
            0,
            0,
            960,
            540
        )
        c:restore()
    end
    __L1.register = function(self, scene, def)
        scene = __TS__Number(scene)
        local ____t_240 = __t
        local ____t_result_239
        local ____t_238 = __t
        local ____temp_237 = not __ge(scene, 12) or not __t(def)
        __O[325] = ____temp_237
        if ____t_238(____temp_237) then
            ____t_result_239 = __O[325]
        else
            ____t_result_239 = type(def.draw) ~= "function"
        end
        if ____t_240(____t_result_239) then
            return false
        end
        __set(__L1.MAPS, scene, def)
        return true
    end
    __L1.draw = function(self, c, scene, camera, t)
        if not __t(__L1:handles(scene)) then
            return false
        end
        local s = window.DayTime:state()
        local camL = math.floor(camera / 2)
        local sub = math.floor(camera + 0.5) - camL * 2
        lc:clearRect(0, 0, __L1.LW, __L1.LH)
        __L1.SHADE = __arrL({}, 0)
        __L1.shadeCam = camL
        __L1.shadeScene = scene
        __L1.TREES = __arrL({}, 0)
        __L1.treeCam = camL
        __L1.treeScene = scene
        __get(__L1.MAPS, scene):draw(lc, s, t, camL)
        do
            local dt = math.max(
                0,
                math.min(0.1, t - __L1.lastLeafT)
            )
            __L1.lastLeafT = t
            __L1:leavesDraw(lc, camL, t, dt)
        end
        c:save()
        c.imageSmoothingEnabled = false
        c:drawImage(
            low,
            -sub,
            0,
            __L1.LW * 2,
            __L1.LH * 2
        )
        c:restore()
        __L1.lastCam = camera
        __L1.lastT = t
        local ____this_242
        ____this_242 = __get(__L1.MAPS, scene)
        local ____opt_241 = ____this_242.text
        if ____opt_241 ~= nil then
            ____opt_241(____this_242, c, camera)
        end
        return true
    end
    __L1.dirLight = function(self, c, s)
        if s.sunT == nil then
            return
        end
        local sun = __L1:sunInfo(s)
        if sun.str < 0.05 then
            return
        end
        local ____t_result_249
        local ____t_248 = __t
        local ____opt_245 = window.Weather
        if ____opt_245 ~= nil then
            ____opt_245 = ____opt_245.state
        end
        local ____opt_result_247
        if ____opt_245 ~= nil then
            ____opt_result_247 = ____opt_245(____opt_245)
        end
        __O[326] = ____opt_result_247
        if ____t_248(____opt_result_247) then
            ____t_result_249 = __O[326]
        else
            ____t_result_249 = {}
        end
        local wx = ____t_result_249
        local ____L1_cl_255 = __L1.cl
        local ____t_result_250
        if __t(wx.rain) then
            ____t_result_250 = wx.rain
        else
            ____t_result_250 = 0
        end
        local ____temp_252 = 1 - ____t_result_250 * 0.8
        local ____t_result_251
        if __t(wx.snow) then
            ____t_result_251 = wx.snow
        else
            ____t_result_251 = 0
        end
        local ____temp_254 = ____temp_252 - ____t_result_251 * 0.4
        local ____t_result_253
        if __t(wx.dust) then
            ____t_result_253 = wx.dust
        else
            ____t_result_253 = 0
        end
        local cloud = ____L1_cl_255(__L1, ____temp_254 - ____t_result_253 * 0.2)
        local up = math.sin(s.sunT * math.pi)
        local gold = __L1:cl(1 - up * 1.7)
        local ____t_261 = __t
        local ____opt_258 = window.Graphics
        if ____opt_258 ~= nil then
            ____opt_258 = ____opt_258.isShader
        end
        local ____opt_result_260
        if ____opt_258 ~= nil then
            ____opt_result_260 = ____opt_258(____opt_258)
        end
        local k = (____t_261(____opt_result_260) and 0.55 or 1) * cloud * __L1:cl(sun.str)
        if k < 0.03 then
            return
        end
        local camL = math.floor(__L1.lastCam / 2)
        local sx = (40 + s.sunT * 400 - camL * 0.012) * 2
        local sy = (168 - up * 128) * 2
        c.globalCompositeOperation = "soft-light"
        local far = sx < 480 and 1060 or -100
        local g = c:createLinearGradient(sx, 0, far, 0)
        g:addColorStop(
            0,
            ((((("rgba(255," .. tostring(math.floor(214 - 70 * gold + 0.5))) .. ",") .. tostring(math.floor(150 - 80 * gold + 0.5))) .. ",") .. tostring((0.3 + 0.3 * gold) * k)) .. ")"
        )
        g:addColorStop(0.55, "rgba(128,128,128,0)")
        g:addColorStop(
            1,
            ((((("rgba(" .. tostring(math.floor(70 + 40 * gold + 0.5))) .. ",") .. tostring(math.floor(92 - 10 * gold + 0.5))) .. ",170,") .. tostring((0.22 + 0.18 * gold) * k)) .. ")"
        )
        c.fillStyle = g
        c:fillRect(0, 0, 960, 540)
        c.globalCompositeOperation = "screen"
        local r = c:createRadialGradient(
            sx,
            sy,
            0,
            sx,
            sy,
            560
        )
        r:addColorStop(
            0,
            ((((("rgba(255," .. tostring(math.floor(200 - 50 * gold + 0.5))) .. ",") .. tostring(math.floor(140 - 60 * gold + 0.5))) .. ",") .. tostring((0.16 + 0.16 * gold) * k)) .. ")"
        )
        r:addColorStop(1, "rgba(255,200,140,0)")
        c.fillStyle = r
        c:fillRect(0, 0, 960, 540)
        if gold > 0.05 then
            local gr = c:createLinearGradient(0, 360, 0, 452)
            gr:addColorStop(0, "rgba(255,170,90,0)")
            gr:addColorStop(
                0.8,
                ("rgba(255,170,90," .. tostring(0.1 * gold * k)) .. ")"
            )
            gr:addColorStop(1, "rgba(255,170,90,0)")
            c.fillStyle = gr
            c:fillRect(0, 360, 960, 92)
        end
        c.globalCompositeOperation = "multiply"
    end
    __L1.finish = function(self, c, scene)
        if not __t(__L1:handles(scene)) then
            return
        end
        local s = window.DayTime:state()
        local camL = math.floor(__L1.lastCam / 2)
        local sub = math.floor(__L1.lastCam + 0.5) - camL * 2
        c:save()
        c.globalCompositeOperation = "multiply"
        local ____c_264 = c
        local ____L1_css_263 = __L1.css
        local ____t_result_262
        if __t(__get(__L1.MAPS, scene).amb) then
            ____t_result_262 = __get(__L1.MAPS, scene):amb(s)
        else
            ____t_result_262 = s.amb
        end
        ____c_264.fillStyle = ____L1_css_263(__L1, ____t_result_262)
        c:fillRect(0, 0, 960, 540)
        if not __t(__get(__L1.MAPS, scene).amb) then
            __L1:dirLight(c, s)
        end
        __L1.LIGHTS = __arrL({}, 0)
        __L1.lightCam = camL
        __L1.lightScene = scene
        if __t(__get(__L1.MAPS, scene).lights) then
            lg:clearRect(0, 0, __L1.LW, __L1.LH)
            __get(__L1.MAPS, scene):lights(lg, s, __L1.lastT, camL)
            c.globalCompositeOperation = "lighter"
            c.imageSmoothingEnabled = false
            c:drawImage(
                lightCv,
                -sub,
                0,
                __L1.LW * 2,
                __L1.LH * 2
            )
        end
        c:restore()
    end
    __L1.desenharCamadas = function(self, scene, camera, t, hora)
        scene = __TS__Number(scene)
        local ____t_result_267
        local ____t_266 = __t
        local ____TS__Number_result_265 = __TS__Number(camera)
        __O[328] = ____TS__Number_result_265
        if ____t_266(____TS__Number_result_265) then
            ____t_result_267 = __O[328]
        else
            ____t_result_267 = 0
        end
        camera = ____t_result_267
        local ____t_result_270
        local ____t_269 = __t
        local ____TS__Number_result_268 = __TS__Number(t)
        __O[329] = ____TS__Number_result_268
        if ____t_269(____TS__Number_result_268) then
            ____t_result_270 = __O[329]
        else
            ____t_result_270 = 0
        end
        t = ____t_result_270
        if not __t(__L1:podeCamadas(scene)) then
            return nil
        end
        local forcar = type(hora) == "number" and __isFiniteN(hora)
        if __t(forcar) then
            window.DayTime:force(hora)
        end
        do
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                return true, __L1:desenharCamadasAgora(scene, camera, t)
            end)
            do
                if __t(forcar) then
                    window.DayTime:force(nil)
                end
            end
            if not ____try then
                error(____hasReturned, 0)
            end
            if ____try and ____hasReturned then
                return ____returnValue
            end
        end
    end
    __L1.desenharCamadasAgora = function(self, scene, camera, t)
        local M = __L1.CAMS.M
        local VW = 482 + 2 * M
        if not __t(__L1.CAMS.cv) then
            do
                do
                    __O[330] = __iter(__L1:mk(VW, __L1.LH))
                    __L1.CAMS.cv = __get(__O[330], 0)
                end
                __L1.CAMS.g = __get(__O[330], 1)
            end
            local ____ = __O[330]
            do
                do
                    __O[331] = __iter(__L1:mk(VW, __L1.LH))
                    __L1.CAMS.luz = __get(__O[331], 0)
                end
                __L1.CAMS.lg = __get(__O[331], 1)
            end
            local ____ = __O[331]
            do
                do
                    __O[332] = __iter(__L1:mk(482, __L1.LH))
                    __L1.CAMS.ceu = __get(__O[332], 0)
                end
                __L1.CAMS.ceuG = __get(__O[332], 1)
            end
            local ____ = __O[332]
        end
        local s = window.DayTime:state()
        local camL = math.floor(camera / 2)
        local camW = camL - M
        local g = __L1.CAMS.g
        g:save()
        g:setTransform(
            1,
            0,
            0,
            1,
            0,
            0
        )
        g.globalAlpha = 1
        g.globalCompositeOperation = "source-over"
        g:clearRect(0, 0, VW, __L1.LH)
        g:restore()
        __L1.GRAV = {
            g = g,
            lg = __L1.CAMS.lg,
            M = M,
            ceuG = __L1.CAMS.ceuG,
            nevoas = __L1.CAMS.nevoas,
            nNevoa = 0,
            fundo = __arrL({}, 0),
            sujo = false
        }
        local marca = __arrL({
            "fillRect",
            "drawImage",
            "fill",
            "stroke",
            "fillText",
            "strokeRect",
            "putImageData"
        }, 7)
        local orig = {}
        for ____, k in __iterar((marca)) do
            local f = __get(g, k)
            __set(orig, k, f)
            __set(
                g,
                k,
                function(self, ...)
                    local a = {...}
                    if __t(__L1.GRAV) then
                        __L1.GRAV.sujo = true
                    end
                    return __fapply(f, g, a)
                end
            )
        end
        local lw = __L1.LW
        __L1.LW = VW
        local luzes = false
        local ____t_result_271
        if __t(__get(__L1.MAPS, scene).amb) then
            ____t_result_271 = __get(__L1.MAPS, scene):amb(s)
        else
            ____t_result_271 = s.amb
        end
        local amb0 = ____t_result_271
        local amb = __arrL(
            {
                __L1:cl(__get(amb0, 0)),
                __L1:cl(__get(amb0, 1)),
                __L1:cl(__get(amb0, 2))
            },
            3
        )
        do
            local ____try, ____error = pcall(function()
                __L1.SHADE = __arrL({}, 0)
                __L1.shadeCam = camW
                __L1.shadeScene = scene
                __L1.TREES = __arrL({}, 0)
                __L1.treeCam = camW
                __L1.treeScene = scene
                __get(__L1.MAPS, scene):draw(g, s, t, camW)
                do
                    local dt = math.max(
                        0,
                        math.min(0.4, t - __L1.lastLeafT)
                    )
                    __L1.lastLeafT = t
                    __L1:leavesDraw(g, camW, t, dt)
                end
                for ____, k in __iterar((marca)) do
                    __set(
                        g,
                        k,
                        __get(orig, k)
                    )
                end
                __L1:multiplicar(g, VW, __L1.LH, amb)
                __L1.CAMS.lg:clearRect(0, 0, VW, __L1.LH)
                if __t(__get(__L1.MAPS, scene).lights) then
                    __L1.LIGHTS = __arrL({}, 0)
                    __L1.lightCam = camW
                    __L1.lightScene = scene
                    __get(__L1.MAPS, scene):lights(__L1.CAMS.lg, s, t, camW)
                    luzes = true
                end
                if __t(luzes) then
                    g.globalCompositeOperation = "lighter"
                    g:drawImage(__L1.CAMS.luz, 0, 0)
                    g.globalCompositeOperation = "source-over"
                end
            end)
            do
                __L1.LW = lw
                for ____, k in __iterar((marca)) do
                    __set(
                        g,
                        k,
                        __get(orig, k)
                    )
                end
            end
            if not ____try then
                error(____error, 0)
            end
        end
        local fundo = __L1.GRAV.fundo
        __L1.GRAV = nil
        __L1.lastCam = camera
        __L1.lastT = t
        return {
            cena = scene,
            camL = camL,
            camW = camW,
            M = M,
            VW = VW,
            LH = __L1.LH,
            meio = __L1.CAMS.cv,
            ceu = __L1.CAMS.ceu,
            fundo = fundo,
            amb = amb,
            camera = camera,
            t = t
        }
    end
    __L1.multiplicar = function(self, g, w, h, amb)
        local ____t_275 = __t
        local ____t_result_274
        local ____t_273 = __t
        local ____temp_272 = __gt(
            __get(amb, 0),
            0.997
        ) and __gt(
            __get(amb, 1),
            0.997
        )
        __O[333] = ____temp_272
        if ____t_273(____temp_272) then
            ____t_result_274 = __gt(
                __get(amb, 2),
                0.997
            )
        else
            ____t_result_274 = __O[333]
        end
        if ____t_275(____t_result_274) then
            return
        end
        if __t(g.multiplicarCor) then
            g:multiplicarCor(
                __get(amb, 0),
                __get(amb, 1),
                __get(amb, 2)
            )
            return
        end
        local d = g:getImageData(0, 0, w, h)
        local px = d.data
        do
            local i = 0
            while __lt(
                i,
                __len(px)
            ) do
                __set(
                    px,
                    i,
                    __get(px, i) * __get(amb, 0)
                )
                __set(
                    px,
                    i + 1,
                    __get(px, i + 1) * __get(amb, 1)
                )
                __set(
                    px,
                    i + 2,
                    __get(px, i + 2) * __get(amb, 2)
                )
                i = i + 4
            end
        end
        g:putImageData(d, 0, 0)
    end
    local ____ = "use strict"
    if __t(window.HdMaps) then
        return
    end
    __L1.LW = 482
    __L1.LH = 270
    __L1.FLOOR = 220
    __L1.mk = function(____, w, h)
        local cv = window.document:createElement("canvas")
        cv.width = w
        cv.height = h
        local c = cv:getContext("2d")
        c.imageSmoothingEnabled = false
        return __arrL({cv, c}, 2)
    end
    __L1.hash = function(____, n)
        local x = math.sin(n * 127.1 + 311.7) * 43758.5453
        return x - math.floor(x)
    end
    __L1.R = function(____, c, x, y, w, h, col)
        c.fillStyle = col
        c:fillRect(
            math.floor(x + 0.5),
            math.floor(y + 0.5),
            math.max(
                1,
                math.floor(w + 0.5)
            ),
            math.max(
                1,
                math.floor(h + 0.5)
            )
        )
    end
    __L1.cl = function(____, v) return math.max(
        0,
        math.min(1, v)
    ) end
    __L1.css = function(____, v, a)
        local s = (((tostring(math.floor(__L1:cl(__get(v, 0)) * 255 + 0.5)) .. ",") .. tostring(math.floor(__L1:cl(__get(v, 1)) * 255 + 0.5))) .. ",") .. tostring(math.floor(__L1:cl(__get(v, 2)) * 255 + 0.5))
        local ____temp_276
        if a == nil then
            ____temp_276 = ("rgb(" .. s) .. ")"
        else
            ____temp_276 = ((("rgba(" .. s) .. ",") .. tostring(a)) .. ")"
        end
        return ____temp_276
    end
    __L1.mix = function(____, a, b, k) return __arrL(
        {
            __get(a, 0) + (__get(b, 0) - __get(a, 0)) * k,
            __get(a, 1) + (__get(b, 1) - __get(a, 1)) * k,
            __get(a, 2) + (__get(b, 2) - __get(a, 2)) * k
        },
        3
    ) end
    __L1.ECACHE = __TS__New(Map)
    __L1.missT = 0
    __L1.misses = 0
    __L1.q4 = function(____, v) return math.floor(v * 4 + 0.5) / 4 end
    low, lc = table.unpack(
        __L1:mk(__L1.LW, __L1.LH),
        1,
        2
    )
    lightCv, lg = table.unpack(
        __L1:mk(__L1.LW, __L1.LH),
        1,
        2
    )
    __L1.worldW = function(____, scene)
        local ____t_result_282
        local ____t_281 = __t
        local ____getq_279 = __getq
        local ____opt_277 = window.WorldData
        if ____opt_277 ~= nil then
            ____opt_277 = ____opt_277.widths
        end
        local ____TS__Number_result_280 = __TS__Number(____getq_279(____opt_277, scene))
        __O[298] = ____TS__Number_result_280
        if ____t_281(____TS__Number_result_280) then
            ____t_result_282 = __O[298]
        else
            ____t_result_282 = 4800
        end
        return math.ceil(____t_result_282 / 2)
    end
    skyCv, sk = table.unpack(
        __L1:mk(__L1.LW, 196),
        1,
        2
    )
    __L1.skyH = -99
    __L1.GRAV = nil
    __L1.TILE = 960
    __L1.ridge = function(____, x, seed, amp)
        local a = x / __L1.TILE * math.pi * 2
        return (math.sin(a * 2 + seed) * 0.5 + math.sin(a * 5 + seed * 2.3) * 0.28 + math.sin(a * 11 + seed * 4.1) * 0.14 + math.sin(a * 23 + seed) * 0.06) * amp
    end
    __L1.far = nil
    __L1.mids = {}
    __L1.TREES = __arrL({}, 0)
    __L1.treeScene = -1
    __L1.RUSTLE = __TS__New(Map)
    __L1.LEAVES = __arrL({}, 0)
    __L1.lastLeafT = 0
    __L1.FARM_TREES = __arrL(
        {
            __arrL({26, 212, 1.25, 0}, 4),
            __arrL({267, 212, 0.78, 1}, 4),
            __arrL({397, 212, 1.12, 0}, 4),
            __arrL({695, 213, 1.2, 1}, 4),
            __arrL({905, 214, 1.2, 0}, 4),
            __arrL({1220, 215, 1.3, 0}, 4)
        },
        6
    )
    do
        do
            local x = 1295
            local i = 0
            while x < 2400 do
                if __mod(i, 3) == 0 then
                    __call(
                        __L1.FARM_TREES,
                        "push",
                        __arrL(
                            {
                                x + 74,
                                215,
                                0.8 + __mod(i, 2) * 0.2,
                                __mod(i, 2)
                            },
                            4
                        )
                    )
                end
                do
                    x = x + 122.5
                    i = i + 1
                end
            end
        end
    end
    __L1.FARM_HOUSES = __arrL({66, 1752}, 2)
    __L1.FARM_FENCES = __arrL(
        {
            __arrL({0, 56}, 2),
            __arrL({166, 157}, 2),
            __arrL({393, 107}, 2),
            __arrL({540, 210}, 2),
            __arrL({785, 340}, 2)
        },
        5
    )
    do
        do
            local x = 1295
            while x < 2400 do
                __call(
                    __L1.FARM_FENCES,
                    "push",
                    __arrL({x, 111}, 2)
                )
                x = x + 122.5
            end
        end
    end
    __L1.SHADE = __arrL({}, 0)
    __L1.shadeCam = 0
    __L1.shadeScene = -1
    __L1.treeCam = 0
    __L1.shadeAdd = function(____, x0, x1, k, leaves)
        if x1 - x0 > 4 then
            __call(
                __L1.SHADE,
                "push",
                __arrL(
                    {
                        math.min(x0, x1),
                        math.max(x0, x1),
                        k,
                        not not __t(leaves)
                    },
                    4
                )
            )
        end
    end
    __L1.LIGHTS = __arrL({}, 0)
    __L1.lightCam = 0
    __L1.lightScene = -1
    __L1.lightAdd = function(____, x, top, a, reach)
        local ____t_286 = __t
        local ____t_result_285
        local ____t_284 = __t
        local ____temp_283 = __gt(a, 0.04) and __gt(x, -160)
        __O[307] = ____temp_283
        if ____t_284(____temp_283) then
            ____t_result_285 = __lt(x, __L1.LW + 160)
        else
            ____t_result_285 = __O[307]
        end
        if ____t_286(____t_result_285) then
            __call(__L1.LIGHTS, "push", {x = x, top = top, a = a, reach = reach})
        end
    end
    __L1.patchAdd = function(____, x0, x1, k, a)
        local ____t_290 = __t
        local ____t_result_289
        local ____t_288 = __t
        local ____temp_287 = __gt(a, 0.03) and __gt(x1, -60)
        __O[308] = ____temp_287
        if ____t_288(____temp_287) then
            ____t_result_289 = __lt(x0, __L1.LW + 60)
        else
            ____t_result_289 = __O[308]
        end
        if ____t_290(____t_result_289) then
            __call(
                __L1.LIGHTS,
                "push",
                {
                    patch = true,
                    x0 = math.min(x0, x1),
                    x1 = math.max(x0, x1),
                    k = k,
                    a = a
                }
            )
        end
    end
    __L1.GW = __ord({
        step = 140,
        x0 = 23,
        w = 88,
        y = 32,
        h = 91
    }, "step,x0,w,y,h")
    __L1.gymOpen = function(____, i) return __mod(i, 4) == 1 and 34 or (__mod(i, 4) == 2 and 12 or 0) end
    __L1.gymSlats = function(____, i)
        local list = __arrL({}, 0)
        do
            local y = __L1.GW.y + 2
            while y < __L1.GW.y + __L1.GW.h - __L1:gymOpen(i) - 4 do
                __call(list, "push", y)
                y = y + 5
            end
        end
        return list
    end
    __L1.gymAmb = function(____, s) return __L1:mix(
        s.amb,
        __arrL({1, 1, 1}, 3),
        0.28
    ) end
    __L1.cities = {}
    __L1.COURT_HOOPS = __arrL({150, 1100}, 2)
    __L1.COURT_FLOODS = __arrL(
        {
            __arrL({42, 61, 3}, 3),
            __arrL({1225, 61, 3}, 3)
        },
        2
    )
    do
        do
            local x = 1350
            while x < 2600 do
                __call(
                    __L1.COURT_FLOODS,
                    "push",
                    __arrL({x, 101, 4}, 3)
                )
                x = x + 210
            end
        end
    end
    __L1.FIELD_FLOODS = __arrL({}, 0)
    do
        do
            local x = 150
            while x < 2400 do
                __call(__L1.FIELD_FLOODS, "push", x)
                x = x + 650
            end
        end
    end
    __L1.FIELD_GOALS = __arrL({370, 2205}, 2)
    __L1.fieldBack = nil
    __L1.FAN_SHIRT = __arrL({
        "#e04a3a",
        "#3a7fd0",
        "#e8c23a",
        "#3aa655",
        "#f0f0f0",
        "#21496c"
    }, 6)
    __L1.FAN_SKIN = __arrL({
        "#f0c8a0",
        "#c8946a",
        "#8a5a3c",
        "#e0aa80",
        "#6e452e"
    }, 5)
    __L1.FAN_HAIR = __arrL({
        "#2a1e18",
        "#4a2e1c",
        "#161616",
        "#7a4a24",
        "#d8b25a"
    }, 5)
    __L1.hexv = function(____, h) return __arrL(
        {
            __TS__ParseInt(
                __call(h, "slice", 1, 3),
                16
            ) / 255,
            __TS__ParseInt(
                __call(h, "slice", 3, 5),
                16
            ) / 255,
            __TS__ParseInt(
                __call(h, "slice", 5, 7),
                16
            ) / 255
        },
        3
    ) end
    __L1.FV_COL = __arrL({
        "#bf7956",
        "#d4a06d",
        "#c48b70",
        "#a8b29b",
        "#b7855e",
        "#9b9fa0",
        "#d98a8a",
        "#8fb0c4"
    }, 8)
    __L1.FV_BACK = __arrL({}, 0)
    __L1.FV_SIGNS = __arrL({}, 0)
    do
        do
            local x = 435
            local i = 0
            while x < 3600 do
                __call(
                    __L1.FV_SIGNS,
                    "push",
                    __arrL({x, i}, 2)
                )
                do
                    x = x + 450
                    i = i + 1
                end
            end
        end
    end
    __L1.fvHouse = function(____, i) return {
        x = i * 105,
        y = 136 + __mod(i, 2) * 14,
        w = 94,
        h = 82 - __mod(i, 2) * 14
    } end
    __L1.PT_MURAL = {["5"] = "eras", ["12"] = "violao", ["17"] = "gatos"}
    __L1.PT_WIN = function(____, i) return 27.5 + i * 93.5 end
    __L1.ERAS = __arrL({
        "#7fc8a0",
        "#e8c84a",
        "#9a6ad0",
        "#d83a3a",
        "#7ac8e8",
        "#2a2a2a",
        "#f08ab8",
        "#b8b0a0",
        "#c98a5a",
        "#2a3a78",
        "#d8d0c0"
    }, 11)
    __L1.PT_LAMPS = __arrL({}, 0)
    do
        do
            local x = 375
            while x < 2100 do
                __call(__L1.PT_LAMPS, "push", x)
                x = x + 425
            end
        end
    end
    __L1.SC_DOORS = __arrL(
        {
            __arrL({675, 0}, 2),
            __arrL({1175, 1}, 2)
        },
        2
    )
    __L1.SC_SKETCH = __call(
        __arrL({
            0,
            1,
            2,
            3,
            4
        }, 5),
        "map",
        function(____, i) return 1335 + i * 84.5 end
    )
    __L1.SC_BOARDS = __call(
        __arrL({
            0,
            1,
            2,
            3,
            4
        }, 5),
        "map",
        function(____, i) return 2010 + i * 91.5 end
    )
    __L1.SC_PHRASES = __arrL({
        "da roça poudiaaam",
        "reeeis pouddiaaam",
        "da roça pegou ar",
        "teketeketeketeke",
        "o pra ravid falando sozinho"
    }, 5)
    __L1.SC_CAPS = __arrL({
        "NÃO ABRA O CADERNO",
        "ELES ESTÃO OLHANDO",
        "SÓ UM RABISCO...",
        "O PAPEL RESPIRA",
        "MARCO ESTEVE AQUI"
    }, 5)
    __L1.SC_BUSY = __arrL(
        {
            __arrL({128, 256}, 2),
            __arrL({165, 215}, 2),
            __arrL({482, 562}, 2),
            __arrL({632, 718}, 2),
            __arrL({940, 1218}, 2),
            __arrL({1295, 1700}, 2),
            __arrL({1995, 2480}, 2)
        },
        7
    )
    __L1.plazaBack = nil
    __L1.PZ_FOUNT = __arrL({525, 2115}, 2)
    __L1.PZ_KIOSK = __arrL({985, 2515}, 2)
    __L1.PZ_LAMPS = __call(
        __arrL({
            0,
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8
        }, 9),
        "map",
        function(____, i) return 350 + i * 325 end
    )
    __L1.INK_GLOW = __arrL({}, 0)
    __L1.INK_SIGNS = __arrL({}, 0)
    do
        do
            local x = 120
            local i = 0
            while x < 3300 do
                __call(
                    __L1.INK_GLOW,
                    "push",
                    __arrL(
                        {
                            x + __mod(i, 2) * 36,
                            __mod(i, 3)
                        },
                        2
                    )
                )
                do
                    x = x + 215
                    i = i + 1
                end
            end
        end
        do
            local x = 340
            local i = 0
            while x < 3300 do
                __call(
                    __L1.INK_SIGNS,
                    "push",
                    __arrL({x, i}, 2)
                )
                do
                    x = x + 495
                    i = i + 1
                end
            end
        end
    end
    __L1.INK_COL = __arrL(
        {
            __arrL({0.35, 0.95, 1}, 3),
            __arrL({1, 0.45, 0.9}, 3),
            __arrL({0.75, 1, 0.45}, 3)
        },
        3
    )
    __L1.inkBack = nil
    darkCv, dk = table.unpack(
        __L1:mk(__L1.LW, __L1.LH),
        1,
        2
    )
    __L1.roomAmb = function(____, k) return function(____, s) return __L1:mix(
        s.amb,
        __arrL({1, 0.94, 0.84}, 3),
        k
    ) end end
    __L1.BG_ST = __arrL({}, 0)
    do
        do
            local x = 32
            while x < 1800 do
                __call(__L1.BG_ST, "push", x)
                x = x + 219
            end
        end
    end
    __L1.BG_WIN = __arrL({}, 0)
    do
        do
            local i = 2
            while i < 9 do
                if i ~= 6 then
                    local w = __ord(
                        {
                            x = 163 + 219 * i,
                            y = 28,
                            w = 64,
                            h = 74,
                            open = __mod(i, 3) == 0 and 24 or (__mod(i, 3) == 1 and 0 or 10)
                        },
                        "x,y,w,h,open"
                    )
                    __call(__L1.BG_WIN, "push", w)
                end
                i = i + 1
            end
        end
    end
    __L1.BG_SOFA = __arrL({870, 1195, 1520}, 3)
    __L1.BG_POLES = __arrL({123, 570}, 2)
    __L1.BG_PEOPLE = __arrL({3, 5}, 2)
    __L1.RY_WIN = __arrL({}, 0)
    do
        do
            local x = 62
            local i = 0
            while x < 2100 do
                __call(
                    __L1.RY_WIN,
                    "push",
                    __ord({
                        x = x,
                        y = 65,
                        w = 103,
                        h = 76,
                        i = i
                    }, "x,y,w,h,i")
                )
                do
                    x = x + 330
                    i = i + 1
                end
            end
        end
    end
    __L1.RY_SOFA = __arrL({}, 0)
    do
        do
            local x = 175
            local i = 0
            while x < 1025 do
                __call(
                    __L1.RY_SOFA,
                    "push",
                    __arrL({x, i}, 2)
                )
                do
                    x = x + 235
                    i = i + 1
                end
            end
        end
    end
    __L1.RY_ART = __arrL(
        {
            __arrL({500, "SE TOCA, MENINO", "#b08b9c"}, 3),
            __arrL({820, "AFF VEYR JURO", "#85a9a6"}, 3),
            __arrL({1350, "AQUI TEM RESENHA", "#b39268"}, 3)
        },
        3
    )
    __L1.RY_PLANTS = __arrL({
        35,
        352,
        557,
        855,
        1235,
        1600
    }, 6)
    __L1.RY_LAMPS = __arrL({
        200,
        470,
        740,
        1010,
        1280,
        1550,
        1820
    }, 7)
    __L1.AO = 150
    __L1.AW = 780
    __L1.ARENA = {}
    __L1.arenaLayers = {}
    alow, ac = table.unpack(
        __L1:mk(__L1.LW, __L1.LH),
        1,
        2
    )
    __L1.ART_FAR = function(____, c)
        __L1:R(
            c,
            20,
            58,
            440,
            96,
            "#e9eee9"
        )
        do
            local i = 0
            while i < 900 do
                __L1:R(
                    c,
                    20 + __L1:hash(i + 3) * 440,
                    60 + __L1:hash(i + 4) * 90,
                    1,
                    1,
                    __t(__mod(i, 2)) and "#dde4df" or "#f6f9f6"
                )
                i = i + 1
            end
        end
        __L1:R(
            c,
            18,
            54,
            444,
            5,
            "#173e65"
        )
        __L1:R(
            c,
            18,
            54,
            444,
            1,
            "#3a6a94"
        )
        __L1:R(
            c,
            20,
            140,
            440,
            14,
            "#254f75"
        )
        __L1:R(
            c,
            20,
            140,
            440,
            1,
            "#3a6a94"
        )
        do
            local r2 = 0
            while r2 < 3 do
                do
                    local k = 0
                    while k < 15 do
                        do
                            local x = 30 + k * 28.5
                            local y = 66 + r2 * 24
                            if __t(x > 196 and x < 270) then
                                do k = k + 1 continue end
                            end
                            __L1:R(
                                c,
                                x,
                                y,
                                16,
                                16,
                                "#294e68"
                            )
                            __L1:R(
                                c,
                                x + 1,
                                y + 1,
                                14,
                                14,
                                "#7bafb7"
                            )
                            __L1:R(
                                c,
                                x + 1,
                                y + 1,
                                14,
                                5,
                                "#a5cbd0"
                            )
                            __L1:R(
                                c,
                                x + 7,
                                y + 1,
                                1,
                                14,
                                "#e6eee1"
                            )
                            __L1:R(
                                c,
                                x - 1,
                                y + 16,
                                18,
                                2,
                                "#c7d9e0"
                            )
                        end
                        k = k + 1
                    end
                end
                r2 = r2 + 1
            end
        end
        __L1:R(
            c,
            205,
            20,
            70,
            120,
            "#f3f6f1"
        )
        __L1:R(
            c,
            205,
            20,
            2,
            120,
            "#ffffff"
        )
        __L1:R(
            c,
            272,
            20,
            3,
            120,
            "#c8d2cc"
        )
        __L1:R(
            c,
            200,
            16,
            80,
            5,
            "#173e65"
        )
        do
            local r2 = 0
            while r2 < 12 do
                __L1:R(
                    c,
                    210 + r2 * 2,
                    4 + r2,
                    60 - r2 * 4,
                    1,
                    "#2d5a86"
                )
                r2 = r2 + 1
            end
        end
        __L1:R(
            c,
            239,
            -2,
            2,
            6,
            "#5a6a7a"
        )
        __L1:R(
            c,
            222,
            108,
            36,
            32,
            "#5c4a36"
        )
        __L1:R(
            c,
            224,
            110,
            32,
            30,
            "#8a6a46"
        )
        __L1:R(
            c,
            239,
            110,
            2,
            30,
            "#5c4a36"
        )
        __L1:R(
            c,
            225,
            104,
            30,
            3,
            "#173e65"
        )
        __L1:R(
            c,
            300,
            8,
            2,
            50,
            "#8a96a0"
        )
        __L1:R(
            c,
            300,
            8,
            2,
            1,
            "#e0e8ee"
        )
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({48, 1}, 2),
                __arrL({150, 0.8}, 2),
                __arrL({330, 0.9}, 2),
                __arrL({430, 1.1}, 2)
            },
            4
        ))) do
            local x = ____value[1]
            local s = ____value[2]
            do
                local k = 0
                while k < 28 * s do
                    __L1:R(
                        c,
                        x + math.floor(k * 0.08 + 0.5),
                        154 - k,
                        3,
                        1,
                        __t(__mod(k, 4)) and "#7a5a3a" or "#5a4028"
                    )
                    k = k + 1
                end
            end
            do
                local i = 0
                while i < 7 do
                    local a = -math.pi + 0.25 + i * 0.44
                    local L = 16 * s
                    do
                        local k = 0
                        while k <= L do
                            local u = k / L
                            __L1:R(
                                c,
                                x + 2 + math.cos(a) * k,
                                154 - 28 * s + math.sin(a) * k * 0.5 + u * u * 8 * s,
                                2,
                                1,
                                __t(__mod(i, 2)) and "#3f8a46" or "#5aa850"
                            )
                            k = k + 1
                        end
                    end
                    i = i + 1
                end
            end
        end
    end
    __L1.ART_MID = function(____, c)
        do
            local r2 = 0
            while r2 < 3 do
                local y = 160 + r2 * 13
                __L1:R(
                    c,
                    __TS__Number(-__L1.AO),
                    y + 9,
                    __L1.AW,
                    4,
                    "#9aa6b0"
                )
                __L1:R(
                    c,
                    __TS__Number(-__L1.AO),
                    y + 9,
                    __L1.AW,
                    1,
                    "#d0d8de"
                )
                __L1:R(
                    c,
                    __TS__Number(-__L1.AO),
                    y + 13,
                    __L1.AW,
                    3,
                    "#5f6c78"
                )
                r2 = r2 + 1
            end
        end
        do
            local x = __TS__Number(-__L1.AO)
            while x < __L1.AW - __L1.AO do
                __L1:R(
                    c,
                    x,
                    169,
                    3,
                    51,
                    "#4f5c66"
                )
                x = x + 40
            end
        end
        c.fillStyle = "rgba(160,175,170,.45)"
        do
            local y = 120
            while y < 200 do
                do
                    local x = __TS__Number(-__L1.AO) + __mod(y, 6)
                    while x < __L1.AW - __L1.AO do
                        c:fillRect(x, y, 1, 1)
                        x = x + 6
                    end
                end
                y = y + 1
            end
        end
        __L1:R(
            c,
            __TS__Number(-__L1.AO),
            118,
            __L1.AW,
            2,
            "#657e71"
        )
        __L1:R(
            c,
            __TS__Number(-__L1.AO),
            118,
            __L1.AW,
            1,
            "#93a898"
        )
        do
            local x = __TS__Number(-__L1.AO)
            while x < __L1.AW - __L1.AO do
                __L1:R(
                    c,
                    x,
                    118,
                    3,
                    82,
                    "#597a70"
                )
                __L1:R(
                    c,
                    x,
                    118,
                    1,
                    82,
                    "#99a48a"
                )
                x = x + 48
            end
        end
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({100, 280, "#f3ead6"}, 3),
                __arrL({-110, 120, "#e8c84a"}, 3),
                __arrL({470, 110, "#7ac8e8"}, 3)
            },
            3
        ))) do
            local x = ____value[1]
            local w = ____value[2]
            local col = ____value[3]
            __L1:R(
                c,
                x,
                124,
                w,
                22,
                col
            )
            __L1:R(
                c,
                x,
                124,
                w,
                1,
                "rgba(255,255,255,.5)"
            )
            do
                local k = 0
                while __lt(k, w) do
                    __L1:R(
                        c,
                        x + k,
                        146,
                        3,
                        1 + __mod(k, 3),
                        col
                    )
                    k = k + 4
                end
            end
            __L1:R(
                c,
                x - 1,
                123,
                2,
                3,
                "#5a5a5a"
            )
            __L1:R(
                c,
                __add(x, w) - 1,
                123,
                2,
                3,
                "#5a5a5a"
            )
            do
                local i = 0
                while i < 30 do
                    __L1:R(
                        c,
                        x + __L1:hash(i + x) * w,
                        126 + __L1:hash(i + x + 1) * 18,
                        1,
                        1,
                        "rgba(0,0,0,.08)"
                    )
                    i = i + 1
                end
            end
        end
    end
    __L1.ART_NEAR = function(____, c)
        __L1:R(
            c,
            __TS__Number(-__L1.AO),
            200,
            __L1.AW,
            20,
            "#b9c3bd"
        )
        do
            local x = __TS__Number(-__L1.AO)
            while x < __L1.AW - __L1.AO do
                __L1:R(
                    c,
                    x,
                    201,
                    1,
                    19,
                    "#a3aea8"
                )
                x = x + 30
            end
        end
        __L1:R(
            c,
            __TS__Number(-__L1.AO),
            200,
            __L1.AW,
            1,
            "#e3e8e2"
        )
        __L1:arenaGround(
            c,
            "#bacbc7",
            "#a9bbb7",
            "#80a6aa",
            "#f3efcf",
            29.5
        )
        do
            local a = 0
            while a < 260 do
                local an = a / 260 * math.pi * 2
                local x = 240 + math.cos(an) * 120
                local y = 245 + math.sin(an) * 16
                if __L1:hash(a + 5) > 0.15 then
                    __L1:R(
                        c,
                        x,
                        y,
                        2,
                        1,
                        "rgba(255,255,255,.7)"
                    )
                end
                a = a + 1
            end
        end
        __L1:R(
            c,
            238,
            230,
            4,
            30,
            "rgba(255,255,255,.5)"
        )
        for ____, x in __iterar((__arrL({55, 404}, 2))) do
            __L1:R(
                c,
                x - 1,
                164,
                27,
                56,
                "#1d3a4c"
            )
            __L1:R(
                c,
                x,
                165,
                25,
                54,
                "#315d7a"
            )
            __L1:R(
                c,
                x + 2,
                168,
                21,
                30,
                "#527c91"
            )
            do
                local r2 = 0
                while r2 < 3 do
                    do
                        local k = 0
                        while k < 3 do
                            __L1:R(
                                c,
                                x + 4 + k * 6,
                                171 + r2 * 9,
                                4,
                                6,
                                __get(
                                    __arrL({"#e04a3a", "#3a7fd0", "#e8c23a"}, 3),
                                    __mod(k + r2, 3)
                                )
                            )
                            __L1:R(
                                c,
                                x + 4 + k * 6,
                                171 + r2 * 9,
                                4,
                                1,
                                "rgba(255,255,255,.5)"
                            )
                            k = k + 1
                        end
                    end
                    r2 = r2 + 1
                end
            end
            __L1:R(
                c,
                x + 2,
                203,
                21,
                8,
                "#1d2a30"
            )
            __L1:R(
                c,
                x + 18,
                200,
                3,
                3,
                "#7ad87a"
            )
            __L1:R(
                c,
                x - 3,
                162,
                31,
                4,
                "#bed4cf"
            )
            do
                local k = 0
                while k < 18 do
                    __L1:R(
                        c,
                        x + 4 + math.floor((18 - k) * 0.4 + 0.5),
                        169 + k,
                        2,
                        1,
                        "rgba(255,255,255,.3)"
                    )
                    k = k + 1
                end
            end
        end
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({-80, 1}, 2),
                __arrL({560, -1}, 2)
            },
            2
        ))) do
            local x = ____value[1]
            local d = ____value[2]
            __L1:R(
                c,
                x,
                120,
                4,
                100,
                "#425e58"
            )
            __L1:R(
                c,
                x,
                120,
                1,
                100,
                "#6f8a82"
            )
            __L1:R(
                c,
                x + (d > 0 and 4 or -34),
                108,
                34,
                22,
                "#d3d2b8"
            )
            __L1:R(
                c,
                x + (d > 0 and 6 or -32),
                110,
                30,
                18,
                "#849e91"
            )
            __L1:R(
                c,
                x + (d > 0 and 20 or -18),
                128,
                14,
                2,
                "#c16f4e"
            )
        end
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({30, "#c9574a"}, 2),
                __arrL({150, "#3a6a9a"}, 2),
                __arrL({330, "#e8c23a"}, 2),
                __arrL({440, "#6ab86a"}, 2)
            },
            4
        ))) do
            local x = ____value[1]
            local col = ____value[2]
            __L1:R(
                c,
                x,
                212,
                8,
                8,
                col
            )
            __L1:R(
                c,
                x + 1,
                210,
                6,
                2,
                col
            )
            __L1:R(
                c,
                x + 2,
                214,
                4,
                2,
                "rgba(255,255,255,.3)"
            )
            __L1:R(
                c,
                x,
                219,
                8,
                1,
                "rgba(0,0,0,.25)"
            )
        end
    end
    __L1.ARENA.arthur = __ord(
        {
            daytime = true,
            layers = __arrL(
                {
                    __arrL({0.3, "arthur-far", __L1.ART_FAR}, 3),
                    __arrL({0.6, "arthur-mid", __L1.ART_MID}, 3),
                    __arrL({1, "arthur-near", __L1.ART_NEAR}, 3)
                },
                3
            ),
            back = function(self, c, s, t, ox)
                __L1:sky(c, s, t, 0)
                __L1:tile(
                    c,
                    __get(
                        __L1:city(31, 108),
                        0
                    ),
                    __TS__Number(-ox) * 0.12
                )
            end,
            mid = function(self, c, s, t, ox)
                local fx = math.floor(ox * 0.3 + 0.5)
                do
                    local kx = 240 + fx
                    local ky = 36
                    __L1:ell(
                        c,
                        kx,
                        ky,
                        11,
                        11,
                        "#173e65"
                    )
                    __L1:wallClock(
                        c,
                        kx,
                        ky,
                        s.h,
                        9,
                        "#f6f2e2",
                        "#c8b88a"
                    )
                end
                do
                    local k = 0
                    while k < 13 do
                        local wv = math.floor(math.sin(t * 3 + k * 0.5) * (k / 12) * 2 + 0.5)
                        __L1:R(
                            c,
                            302 + k + fx,
                            9 + wv,
                            1,
                            9,
                            k < 6 and "#2a5ab8" or "#e8c84a"
                        )
                        k = k + 1
                    end
                end
                local mx = math.floor(ox * 0.6 + 0.5)
                do
                    local r2 = 0
                    while r2 < 3 do
                        do
                            local k = 0
                            while k < 66 do
                                do
                                    local x = __TS__Number(-__L1.AO) + 4 + k * 12 + __mod(r2, 2) * 6 + mx
                                    local y = 160 + r2 * 13 - 2
                                    if __t(x < -10 or x > __L1.LW + 10) then
                                        do k = k + 1 continue end
                                    end
                                    if __L1:hash(k * 7 + r2) < 0.18 then
                                        do k = k + 1 continue end
                                    end
                                    __L1:student(
                                        c,
                                        x,
                                        y,
                                        k * 3 + r2 * 31,
                                        t,
                                        true
                                    )
                                end
                                k = k + 1
                            end
                        end
                        r2 = r2 + 1
                    end
                end
            end,
            text = function(self, c, t, ox)
                c:save()
                c:translate(
                    math.floor(ox * 0.6 + 0.5) * 2,
                    0
                )
                c.font = "16px Pixel, monospace"
                c.textAlign = "center"
                c.textBaseline = "middle"
                c.fillStyle = "#c94f45"
                c:fillText("UM ACERTO NO PÁTIO", 480, 270)
                c.fillStyle = "#2a3a78"
                c:fillText("BRIGA!", -100, 270)
                c.fillStyle = "#16476a"
                c:fillText("UUUH!", 1050, 270)
                c:restore()
            end,
            light = function(self, g, s, t)
                local a = __L1:cl((s.night - 0.12) * 1.4)
                for ____, x in __iterar((__arrL({-60, 540}, 2))) do
                    if a < 0.02 then
                        break
                    end
                    local gr = g:createLinearGradient(0, 100, 0, 262)
                    gr:addColorStop(
                        0,
                        ("rgba(235,240,255," .. tostring(0.3 * a)) .. ")"
                    )
                    gr:addColorStop(
                        1,
                        ("rgba(235,240,255," .. tostring(0.04 * a)) .. ")"
                    )
                    g.fillStyle = gr
                    g:beginPath()
                    g:moveTo(x - 6, 100)
                    g:lineTo(x + 6, 100)
                    g:lineTo(
                        x + 120 * __TS__MathSign(240 - x),
                        262
                    )
                    g:lineTo(
                        x + 20 * __TS__MathSign(240 - x),
                        262
                    )
                    g:closePath()
                    __call(g, "fill")
                end
            end
        },
        "daytime,layers,back,mid,text,light"
    )
    __L1.MAR_FAR = function(____, c)
        __L1:R(
            c,
            __TS__Number(-__L1.AO),
            0,
            __L1.AW,
            __L1.LH,
            "#1e1b33"
        )
        do
            local x = __TS__Number(-__L1.AO)
            while x < __L1.AW - __L1.AO do
                __L1:R(
                    c,
                    x,
                    0,
                    1,
                    __L1.LH,
                    __t(__mod(x, 40)) and "#26234a" or "#34306a"
                )
                x = x + 8
            end
        end
        do
            local y = 0
            while y < __L1.LH do
                __L1:R(
                    c,
                    __TS__Number(-__L1.AO),
                    y,
                    __L1.AW,
                    1,
                    __t(__mod(y, 40)) and "#26234a" or "#34306a"
                )
                y = y + 8
            end
        end
        do
            local x = __TS__Number(-__L1.AO) + 6
            while x < __L1.AW - __L1.AO do
                __L1:ell(
                    c,
                    x + 4,
                    4,
                    6,
                    7,
                    "#5a5878"
                )
                __L1:ell(
                    c,
                    x + 4,
                    4,
                    4,
                    5,
                    "#1e1b33"
                )
                __L1:R(
                    c,
                    x,
                    0,
                    2,
                    6,
                    "#b8b8d8"
                )
                __L1:R(
                    c,
                    x + 1,
                    9,
                    6,
                    2,
                    "#0e0c1c"
                )
                x = x + 22
            end
        end
        do
            local a = 0
            while a < 140 do
                local an = a / 140 * 6.28
                __L1:R(
                    c,
                    360 + math.cos(an) * 18,
                    44 + math.sin(an) * 18,
                    1,
                    1,
                    "#c8d0ff"
                )
                a = a + 1
            end
        end
        do
            local k = -16
            while k < 16 do
                do
                    local j = 0
                    while j < 30 do
                        local x = 360 + k + j * 0.5 - 7
                        local y = 44 - 15 + j
                        if (x - 360) ^ 2 + (y - 44) ^ 2 < 300 then
                            __L1:R(
                                c,
                                x,
                                y,
                                1,
                                1,
                                "#8a96e8"
                            )
                        end
                        j = j + 1
                    end
                end
                k = k + 3
            end
        end
        do
            local i = 0
            while i < 40 do
                local x = __TS__Number(-__L1.AO) + __L1:hash(i + 31) * __L1.AW
                local y = 14 + __L1:hash(i + 32) * 90
                __L1:R(
                    c,
                    x - 1,
                    y,
                    3,
                    1,
                    "#9aa6ff"
                )
                __L1:R(
                    c,
                    x,
                    y - 1,
                    1,
                    3,
                    "#9aa6ff"
                )
                i = i + 1
            end
        end
    end
    __L1.MAR_HILLS = function(____, c)
        __L1:hillLine(
            c,
            __TS__Number(-__L1.AO),
            __L1.AW - __L1.AO,
            150,
            46,
            1.7,
            "#2c2846",
            "#6a7ad8",
            1
        )
        do
            local x = __TS__Number(-__L1.AO)
            while x < __L1.AW - __L1.AO do
                do
                    local y = 110
                    while y < 200 do
                        if __L1:hash(x * 7 + y) > 0.5 then
                            __L1:R(
                                c,
                                x + __band(y / 4, 1),
                                y,
                                2,
                                1,
                                "rgba(106,122,216,.18)"
                            )
                        end
                        y = y + 4
                    end
                end
                x = x + 3
            end
        end
        __L1:hillLine(
            c,
            __TS__Number(-__L1.AO),
            __L1.AW - __L1.AO,
            182,
            30,
            4.2,
            "#3a3458",
            "#7f8ff0",
            1
        )
        local cx = 110
        local cy = 112
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({-22, 12, 34}, 3),
                __arrL({-8, 18, 44}, 3),
                __arrL({12, 12, 30}, 3)
            },
            3
        ))) do
            local dx = ____value[1]
            local w = ____value[2]
            local h = ____value[3]
            local x = cx + dx
            __L1:R(
                c,
                x,
                cy - h,
                w,
                h,
                "#3a3458"
            )
            __L1:R(
                c,
                x,
                cy - h,
                w,
                1,
                "#8a9af8"
            )
            __L1:R(
                c,
                x,
                cy - h,
                1,
                h,
                "#8a9af8"
            )
            __L1:R(
                c,
                x + w - 1,
                cy - h,
                1,
                h,
                "#8a9af8"
            )
            do
                local k = 0
                while k < w do
                    __L1:R(
                        c,
                        x + k,
                        cy - h - 3,
                        2,
                        3,
                        "#8a9af8"
                    )
                    k = k + 4
                end
            end
            __L1:R(
                c,
                x + w / 2 - 1,
                cy - h + 8,
                2,
                4,
                "#ffd88a"
            )
        end
        __L1:R(
            c,
            cx + 1,
            cy - 58,
            1,
            14,
            "#8a9af8"
        )
        do
            local k = 0
            while k < 7 do
                __L1:R(
                    c,
                    cx + 2,
                    cy - 58 + k,
                    7 - k,
                    1,
                    "#e84a9a"
                )
                k = k + 1
            end
        end
        do
            local i = 0
            while i < 14 do
                local x = __TS__Number(-__L1.AO) + 20 + i * 56 + __L1:hash(i) * 20
                local y = 160 + math.floor(__L1:hash(i + 3) * 14 + 0.5)
                __L1:R(
                    c,
                    x,
                    y,
                    1,
                    12,
                    "#7f8ff0"
                )
                do
                    local a = 0
                    while a < 30 do
                        local an = a / 30 * 6.28
                        __L1:R(
                            c,
                            x + math.cos(an) * 6,
                            y - 4 + math.sin(an) * 5,
                            1,
                            1,
                            "#7f8ff0"
                        )
                        a = a + 1
                    end
                end
                i = i + 1
            end
        end
    end
    __L1.MAR_MID = function(____, c)
        do
            local i = 0
            while i < 7 do
                local x = -120 + i * 120 + __mod(i, 2) * 30
                local h = 70 + math.floor(__L1:hash(i + 41) * 40 + 0.5)
                local col = __t(__mod(i, 2)) and "#69617d" or "#5a546e"
                do
                    local r2 = 0
                    while r2 < h do
                        local ____temp_291
                        if r2 > h - 6 then
                            ____temp_291 = __t(__mod(r2 + i, 2)) and 2 or 0
                        else
                            ____temp_291 = 0
                        end
                        local edge = ____temp_291
                        __L1:R(
                            c,
                            x + edge,
                            r2,
                            40 - edge * 2,
                            1,
                            col
                        )
                        r2 = r2 + 1
                    end
                end
                __L1:R(
                    c,
                    x,
                    0,
                    1,
                    h,
                    "rgba(255,255,255,.16)"
                )
                do
                    local k = 0
                    while k < 5 do
                        __L1:R(
                            c,
                            x + 7,
                            16 + k * 12,
                            27,
                            1,
                            "#a69bad"
                        )
                        k = k + 1
                    end
                end
                __L1:R(
                    c,
                    x + 5,
                    8,
                    1,
                    h - 16,
                    "#b07a94"
                )
                for ____, hy in __iterar((__arrL({12, 34, 56}, 3))) do
                    __L1:ell(
                        c,
                        x + 3,
                        hy,
                        1.5,
                        1.5,
                        "#1c1830"
                    )
                end
                i = i + 1
            end
        end
        __L1:R(
            c,
            80,
            150,
            160,
            9,
            "#c9a56a"
        )
        __L1:R(
            c,
            80,
            150,
            160,
            2,
            "#e8c890"
        )
        do
            local k = 0
            while k < 160 do
                __L1:R(
                    c,
                    80 + k,
                    151,
                    1,
                    __t(__mod(k, 20)) and 3 or 5,
                    "#5a4028"
                )
                k = k + 4
            end
        end
        __L1:R(
            c,
            84,
            159,
            4,
            61,
            "#8a6a46"
        )
        __L1:R(
            c,
            232,
            159,
            4,
            61,
            "#8a6a46"
        )
        __L1:R(
            c,
            392,
            108,
            34,
            112,
            "#a8b0c0"
        )
        __L1:R(
            c,
            392,
            108,
            6,
            112,
            "#d8e0ec"
        )
        __L1:R(
            c,
            420,
            108,
            6,
            112,
            "#6a7080"
        )
        __L1:R(
            c,
            386,
            102,
            46,
            8,
            "#8a90a0"
        )
        do
            local y = 118
            while y < 210 do
                __L1:R(
                    c,
                    396,
                    y,
                    26,
                    2,
                    "#7a8090"
                )
                y = y + 10
            end
        end
        __L1:ell(
            c,
            409,
            132,
            7,
            7,
            "#2a2a38"
        )
        __L1:ell(
            c,
            409,
            132,
            4,
            4,
            "#14141c"
        )
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({-40, 14}, 2),
                __arrL({300, 10}, 2),
                __arrL({520, 16}, 2)
            },
            3
        ))) do
            local x = ____value[1]
            local r = ____value[2]
            __L1:ell(
                c,
                x,
                220 - r,
                r,
                r * 0.9,
                "#c8c0d0"
            )
            do
                local k = 0
                while k < 12 do
                    local a = __L1:hash(k + x) * 6.28
                    local rr = __L1:hash(k + x + 1) * r * 0.8
                    __L1:R(
                        c,
                        x + math.cos(a) * rr,
                        220 - r + math.sin(a) * rr * 0.9,
                        3,
                        1,
                        "#8a8098"
                    )
                    k = k + 1
                end
            end
            __L1:ell(
                c,
                x - r * 0.3,
                220 - r * 1.3,
                r * 0.3,
                r * 0.2,
                "#e8e0f0"
            )
        end
    end
    __L1.MAR_NEAR = function(____, c)
        __L1:arenaGround(
            c,
            "#4b3b60",
            "#3c2e50",
            "#76547f",
            "#c19bc6",
            26
        )
        do
            local y = 226
            while y < 270 do
                __L1:R(
                    c,
                    __TS__Number(-__L1.AO),
                    y,
                    __L1.AW,
                    1,
                    "rgba(154,109,148,.35)"
                )
                y = y + 5
            end
        end
        __L1:R(
            c,
            60,
            225,
            1,
            45,
            "rgba(255,90,120,.4)"
        )
        __L1:R(
            c,
            62,
            225,
            1,
            45,
            "rgba(255,90,120,.25)"
        )
        __L1:R(
            c,
            __TS__Number(-__L1.AO),
            196,
            __L1.AW,
            24,
            "#3a2e50"
        )
        __L1:R(
            c,
            __TS__Number(-__L1.AO),
            196,
            __L1.AW,
            1,
            "#6a5a88"
        )
        do
            local y = 200
            while y < 220 do
                __L1:R(
                    c,
                    __TS__Number(-__L1.AO),
                    y,
                    __L1.AW,
                    1,
                    "rgba(154,109,148,.3)"
                )
                y = y + 5
            end
        end
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({151, 238, "#b1a2bb", 1}, 4),
                __arrL({241, 328, "#cfbfd0", -1}, 4)
            },
            2
        ))) do
            local x0 = ____value[1]
            local x1 = ____value[2]
            local col = ____value[3]
            local sd = ____value[4]
            do
                local x = x0
                while __lt(x, x1) do
                    local k = (x - x0) / (x1 - x0)
                    local ____gt_result_292
                    if __gt(sd, 0) then
                        ____gt_result_292 = 150 + math.floor(k * 7 + 0.5)
                    else
                        ____gt_result_292 = 157 - math.floor(k * 8 + 0.5)
                    end
                    local top = ____gt_result_292
                    local ____gt_result_293
                    if __gt(sd, 0) then
                        ____gt_result_293 = 194 + math.floor(k * 9 + 0.5)
                    else
                        ____gt_result_293 = 203 - math.floor(k * 9 + 0.5)
                    end
                    local bot = ____gt_result_293
                    __L1:R(
                        c,
                        x,
                        top,
                        1,
                        bot - top,
                        col
                    )
                    __L1:R(
                        c,
                        x,
                        bot,
                        1,
                        2,
                        "rgba(0,0,0,.3)"
                    )
                    x = x + 1
                end
            end
        end
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({153, 1}, 2),
                __arrL({243, -1}, 2)
            },
            2
        ))) do
            local x0 = ____value[1]
            local sd = ____value[2]
            do
                local j = 0
                while j < 5 do
                    do
                        local x = 0
                        while x < 80 do
                            local k = x / 80
                            local ____temp_294
                            if sd > 0 then
                                ____temp_294 = 160 + math.floor(k * 7 + 0.5)
                            else
                                ____temp_294 = 166 - math.floor(k * 8 + 0.5)
                            end
                            local yy = ____temp_294 + j * 6
                            __L1:R(
                                c,
                                x0 + x,
                                yy,
                                2,
                                1,
                                sd > 0 and "#7c6385" or "#997ea1"
                            )
                            x = x + 2
                        end
                    end
                    j = j + 1
                end
            end
        end
        __L1:R(
            c,
            238,
            156,
            3,
            48,
            "#68546f"
        )
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({10, "#e8c84a", "#a8861f"}, 3),
                __arrL({455, "#d83a6a", "#8a1f40"}, 3)
            },
            2
        ))) do
            local x = ____value[1]
            local col = ____value[2]
            local dk = ____value[3]
            __L1:R(
                c,
                x,
                104,
                11,
                116,
                col
            )
            __L1:R(
                c,
                x,
                104,
                3,
                116,
                "rgba(255,255,255,.25)"
            )
            __L1:R(
                c,
                x + 8,
                104,
                3,
                116,
                dk
            )
            do
                local k = 0
                while k < 6 do
                    __L1:R(
                        c,
                        x + k,
                        104 - k * 2 - 2,
                        11 - k * 2,
                        2,
                        k > 3 and "#2a2a30" or "#e8cfa0"
                    )
                    k = k + 1
                end
            end
            __L1:R(
                c,
                x,
                200,
                11,
                4,
                "#b9c3bf"
            )
            __L1:R(
                c,
                x,
                204,
                11,
                16,
                "#e8a0b0"
            )
        end
        __L1:R(
            c,
            346,
            196,
            26,
            24,
            "#2a2040"
        )
        __L1:R(
            c,
            348,
            198,
            22,
            20,
            "#3a2e58"
        )
        __L1:R(
            c,
            350,
            204,
            18,
            12,
            "#e84a9a"
        )
        __L1:R(
            c,
            350,
            204,
            18,
            2,
            "#ff9ad0"
        )
        __L1:R(
            c,
            354,
            188,
            10,
            9,
            "#2a2040"
        )
        __L1:R(
            c,
            356,
            190,
            6,
            5,
            "#e84a9a"
        )
        __L1:ell(
            c,
            330,
            219,
            18,
            2.5,
            "#e84a9a"
        )
        __L1:ell(
            c,
            120,
            219,
            12,
            2,
            "#4ad8e8"
        )
        __L1:R(
            c,
            270,
            210,
            20,
            10,
            "#e8a0b0"
        )
        __L1:R(
            c,
            270,
            210,
            20,
            2,
            "#ffc8d8"
        )
        __L1:R(
            c,
            270,
            217,
            20,
            3,
            "#5a8ac8"
        )
        do
            local k = 0
            while k < 8 do
                __L1:R(
                    c,
                    262 + __L1:hash(k) * 40,
                    218,
                    2,
                    2,
                    "#e8a0b0"
                )
                k = k + 1
            end
        end
        __L1:board(
            c,
            120,
            60,
            240,
            22,
            "#d7c9d7",
            "#8a7a94"
        )
        for ____, x in __iterar((__arrL({126, 350}, 2))) do
            __L1:R(
                c,
                x,
                56,
                6,
                8,
                "rgba(240,230,170,.8)"
            )
        end
    end
    __L1.ARENA.marco = __ord(
        {
            layers = __arrL(
                {
                    __arrL({0.1, "marco-far", __L1.MAR_FAR}, 3),
                    __arrL({0.3, "marco-hills", __L1.MAR_HILLS}, 3),
                    __arrL({0.6, "marco-mid", __L1.MAR_MID}, 3),
                    __arrL({1, "marco-near", __L1.MAR_NEAR}, 3)
                },
                4
            ),
            mid = function(self, c, s, t, ox)
                do
                    local i = 0
                    while i < 16 do
                        local x = __mod(
                            __L1:hash(i + 3) * 520 + t * (3 + __L1:hash(i) * 4),
                            560
                        ) - 40
                        local yy = 30 + __L1:hash(i + 18) * 140 + math.sin(t + i) * 5
                        __L1:R(
                            c,
                            x,
                            yy,
                            3,
                            4,
                            "#d8c6dd"
                        )
                        __L1:R(
                            c,
                            x,
                            yy,
                            3,
                            1,
                            "#ffffff"
                        )
                        i = i + 1
                    end
                end
                local nx = ox
                do
                    local i = 0
                    while i < 6 do
                        local u = __mod(t * 0.45 + i / 6, 1)
                        __L1:R(
                            c,
                            358 + __mod(i, 3) * 3 + nx,
                            205 + u * 14,
                            1,
                            3,
                            "#e84a9a"
                        )
                        i = i + 1
                    end
                end
            end,
            text = function(self, c, t, ox)
                c:save()
                c:translate(ox * 2, 0)
                c.font = "16px Pixel, monospace"
                c.textAlign = "center"
                c.textBaseline = "middle"
                c.fillStyle = "#3a2848"
                c:fillText("RABISCOS À SOLTA", 480, 142)
                local ____t_297 = __t
                local ____opt_295 = window.Art
                if ____opt_295 ~= nil then
                    ____opt_295 = ____opt_295.drawDoodle
                end
                if ____t_297(____opt_295) then
                    do
                        local i = 0
                        while i < 5 do
                            local dx = math.sin(t * 0.55 + i * 1.7) * 26 + math.sin(t * 1.3 + i) * 6
                            local dy = math.sin(t * 1.05 + i * 2.3) * 14
                            local sc = 2.5 * (1 + math.sin(t * 2.2 + i) * 0.06)
                            c:save()
                            c:translate(
                                math.floor(70 + i * 203 + dx + 0.5),
                                math.floor(170 + __mod(i, 2) * 59 + dy + 0.5)
                            )
                            c:rotate(math.sin(t * 0.8 + i * 1.3) * 0.16)
                            c:scale(sc, sc)
                            do
                                pcall(function()
                                    window.Art:drawDoodle(
                                        c,
                                        0,
                                        0,
                                        __mod(i, 3),
                                        t * 0.35 + i,
                                        true
                                    )
                                end)
                            end
                            c:restore()
                            i = i + 1
                        end
                    end
                end
                c:restore()
            end,
            light = function(self, g, s, t)
                local p = 0.75 + 0.25 * math.sin(t * 2)
                __L1:bulbGlow(
                    g,
                    367,
                    208,
                    p,
                    "255,70,160",
                    38
                )
                __L1:bulbGlow(
                    g,
                    330,
                    219,
                    p * 0.6,
                    "255,70,160",
                    26
                )
                __L1:bulbGlow(
                    g,
                    120,
                    219,
                    p * 0.6,
                    "70,220,255",
                    26
                )
                __L1:bulbGlow(
                    g,
                    240,
                    172,
                    0.55 * p,
                    "170,120,255",
                    74
                )
                __L1:pool(
                    g,
                    240,
                    224,
                    0.8,
                    "170,120,255",
                    100
                )
            end
        },
        "layers,mid,text,light"
    )
    __L1.MEN_TUNNEL = function(____, c)
        __L1:R(
            c,
            __TS__Number(-__L1.AO),
            0,
            __L1.AW,
            __L1.LH,
            "#120e10"
        )
        do
            local i = 0
            while i < 7 do
                local w = 560 - i * 70
                local h = 210 - i * 24
                local x = 240 - w / 2
                local y = 205 - h
                local col = __L1:css(__L1:mix(
                    __arrL({0.36, 0.25, 0.22}, 3),
                    __arrL({0.07, 0.06, 0.06}, 3),
                    i / 6
                ))
                local mort = __L1:css(__L1:mix(
                    __arrL({0.24, 0.17, 0.15}, 3),
                    __arrL({0.05, 0.04, 0.04}, 3),
                    i / 6
                ))
                do
                    local yy = 0
                    while yy < h do
                        local r = math.min(1, yy / (w * 0.5))
                        local ____temp_298
                        if yy < w * 0.5 then
                            ____temp_298 = math.floor(math.sqrt(math.max(0, (w * 0.5) ^ 2 - (w * 0.5 - yy) ^ 2)) + 0.5)
                        else
                            ____temp_298 = w / 2
                        end
                        local half = ____temp_298
                        __L1:R(
                            c,
                            240 - half,
                            y + yy,
                            half * 2,
                            1,
                            col
                        )
                        yy = yy + 1
                    end
                end
                do
                    local yy = y
                    while yy < 205 do
                        do
                            local xx = x + __band(yy / 5, 1) * 5
                            while xx < x + w do
                                __L1:R(
                                    c,
                                    xx,
                                    yy,
                                    1,
                                    5,
                                    mort
                                )
                                xx = xx + 10
                            end
                        end
                        yy = yy + 5
                    end
                end
                do
                    local xx = x
                    while xx < x + w do
                        __L1:R(
                            c,
                            xx,
                            205,
                            1,
                            1,
                            mort
                        )
                        xx = xx + 2
                    end
                end
                i = i + 1
            end
        end
        do
            local yy = 0
            while yy < 26 do
                __L1:R(
                    c,
                    240 - 24 + yy * 0.3,
                    168 + yy,
                    48 - yy * 0.6,
                    1,
                    ("rgba(120,220,140," .. tostring(0.35 - yy * 0.01)) .. ")"
                )
                yy = yy + 1
            end
        end
        do
            local r2 = 0
            while r2 < 14 do
                local k = r2 / 13
                local w = 26 + k * 260
                local y = 180 + r2 * 2.6
                __L1:R(
                    c,
                    240 - w / 2,
                    y,
                    w,
                    3,
                    __L1:css(__L1:mix(
                        __arrL({0.12, 0.32, 0.24}, 3),
                        __arrL({0.18, 0.42, 0.3}, 3),
                        k
                    ))
                )
                r2 = r2 + 1
            end
        end
    end
    __L1.MEN_WALLS = function(____, c)
        for ____, ____value in __iterar((__arrL(
            {
                __arrL(
                    {
                        __TS__Number(-__L1.AO),
                        210
                    },
                    2
                ),
                __arrL({370, 260}, 2)
            },
            2
        ))) do
            local x0 = ____value[1]
            local w = ____value[2]
            __L1:R(
                c,
                x0,
                0,
                w,
                205,
                "#4a2e28"
            )
            do
                local y = 0
                while y < 205 do
                    do
                        local x = x0 + __band(y / 6, 1) * 6
                        while x < x0 + w do
                            __L1:R(
                                c,
                                x,
                                y,
                                11,
                                5,
                                __get(
                                    __arrL({"#5a3a30", "#6a4436", "#52342c"}, 3),
                                    __mod(x * 3 + y, 3)
                                )
                            )
                            __L1:R(
                                c,
                                x,
                                y,
                                11,
                                1,
                                "rgba(255,255,255,.07)"
                            )
                            x = x + 12
                        end
                    end
                    y = y + 6
                end
            end
            local ____L1_R_302 = __L1.R
            local ____c_301 = c
            local ____x0_300 = x0
            local ____temp_299
            if x0 < 0 then
                ____temp_299 = w - 2
            else
                ____temp_299 = 0
            end
            ____L1_R_302(
                __L1,
                ____c_301,
                ____x0_300 + ____temp_299,
                0,
                2,
                205,
                "#1c1210"
            )
        end
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({44, 9, "#6a7a72"}, 3),
                __arrL({64, 6, "#8a5a3a"}, 3)
            },
            2
        ))) do
            local y = ____value[1]
            local h = ____value[2]
            local col = ____value[3]
            __L1:R(
                c,
                __TS__Number(-__L1.AO),
                y,
                210,
                h,
                col
            )
            __L1:R(
                c,
                __TS__Number(-__L1.AO),
                y,
                210,
                2,
                "rgba(255,255,255,.25)"
            )
            __L1:R(
                c,
                __TS__Number(-__L1.AO),
                __add(y, h) - 2,
                210,
                2,
                "rgba(0,0,0,.3)"
            )
            __L1:R(
                c,
                370,
                y + 6,
                260,
                h,
                col
            )
            __L1:R(
                c,
                370,
                y + 6,
                260,
                2,
                "rgba(255,255,255,.25)"
            )
            do
                local x = __TS__Number(-__L1.AO) + 20
                while x < 60 do
                    __L1:R(
                        c,
                        x,
                        y - 1,
                        4,
                        h + 2,
                        "#3a4440"
                    )
                    x = x + 50
                end
            end
            do
                local x = 380
                while x < 630 do
                    __L1:R(
                        c,
                        x,
                        y + 5,
                        4,
                        h + 2,
                        "#3a4440"
                    )
                    x = x + 50
                end
            end
        end
        for ____, x in __iterar((__arrL({30, 420}, 2))) do
            __L1:R(
                c,
                x,
                0,
                10,
                205,
                "#5a6a64"
            )
            __L1:R(
                c,
                x,
                0,
                3,
                205,
                "#8a9a92"
            )
            __L1:R(
                c,
                x + 8,
                0,
                2,
                205,
                "#3a4440"
            )
            do
                local y = 20
                while y < 200 do
                    __L1:R(
                        c,
                        x - 2,
                        y,
                        14,
                        4,
                        "#3a4440"
                    )
                    y = y + 40
                end
            end
            __L1:ell(
                c,
                x + 5,
                120,
                8,
                8,
                "#a83a2a"
            )
            __L1:ell(
                c,
                x + 5,
                120,
                5,
                5,
                "#5a4a40"
            )
            __L1:ell(
                c,
                x + 5,
                120,
                2,
                2,
                "#a83a2a"
            )
        end
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({-60, 110, "#e8c84a"}, 3),
                __arrL({470, 130, "#3ad0c0"}, 3),
                __arrL({540, 90, "#e84a8a"}, 3)
            },
            3
        ))) do
            local x = ____value[1]
            local y = ____value[2]
            local col = ____value[3]
            do
                local k = 0
                while k < 26 do
                    __L1:R(
                        c,
                        x + k,
                        y + math.floor(math.sin(k * 0.7) * 3 + 0.5),
                        2,
                        2,
                        col
                    )
                    k = k + 1
                end
            end
            __L1:R(
                c,
                x + 2,
                y - 5,
                2,
                10,
                col
            )
            __L1:R(
                c,
                x + 12,
                y - 6,
                2,
                11,
                col
            )
            __L1:R(
                c,
                x + 21,
                y - 4,
                2,
                9,
                col
            )
        end
    end
    __L1.MEN_STAGE = function(____, c)
        for ____, sd in __iterar((__arrL({0, 1}, 2))) do
            local x0 = __t(sd) and 400 or -150
            local w = 230
            do
                local k = 0
                while k < w do
                    local col = __get(
                        __arrL({"#7b4252", "#8a4a4a", "#6a3a48", "#9a5a50"}, 4),
                        __mod(
                            __bor(k / 9, 0),
                            4
                        )
                    )
                    __L1:R(
                        c,
                        x0 + k,
                        20,
                        9,
                        186,
                        col
                    )
                    __L1:R(
                        c,
                        x0 + k,
                        20,
                        2,
                        186,
                        "rgba(255,255,255,.12)"
                    )
                    __L1:R(
                        c,
                        x0 + k + 7,
                        20,
                        2,
                        186,
                        "rgba(0,0,0,.25)"
                    )
                    if __mod(
                        __bor(k / 9, 0),
                        3
                    ) == 1 then
                        __L1:R(
                            c,
                            x0 + k + 2,
                            80 + __mod(k, 50),
                            5,
                            6,
                            "#c8a878"
                        )
                        __L1:R(
                            c,
                            x0 + k + 3,
                            81 + __mod(k, 50),
                            1,
                            4,
                            "#5a4030"
                        )
                    end
                    k = k + 9
                end
            end
            __L1:R(
                c,
                x0,
                20,
                w,
                3,
                "#3a2a20"
            )
            do
                local k = 0
                while k < w do
                    __L1:R(
                        c,
                        x0 + k,
                        204,
                        2,
                        3,
                        "#c39865"
                    )
                    k = k + 4
                end
            end
        end
        do
            local x = 80
            local i = 0
            while x < 400 do
                __L1:R(
                    c,
                    x,
                    20 + math.floor(math.sin(i * 0.2) * 2 + 0.5),
                    4,
                    1,
                    "#2a2220"
                )
                do
                    x = x + 4
                    i = i + 1
                end
            end
        end
        do
            local y = 32
            while y < 98 do
                local sag = math.floor(math.sin((y - 32) / 66 * math.pi) * 2 + 0.5)
                __L1:R(
                    c,
                    122 + sag,
                    y,
                    236 - sag * 2,
                    1,
                    __mod(y, 9) == 0 and "#cfc6b4" or "#e2dccd"
                )
                y = y + 1
            end
        end
        do
            local k = 0
            while k < 7 do
                __L1:R(
                    c,
                    128 + k * 34,
                    32,
                    1,
                    66,
                    "rgba(120,100,80,.18)"
                )
                k = k + 1
            end
        end
        do
            local k = 0
            while k < 236 do
                __L1:R(
                    c,
                    122 + k,
                    97 + __mod(k, 2),
                    2,
                    2,
                    "#e2dccd"
                )
                k = k + 3
            end
        end
        __L1:R(
            c,
            122,
            30,
            236,
            3,
            "#5a4a40"
        )
        for ____, x in __iterar((__arrL({126, 354}, 2))) do
            __L1:R(
                c,
                x,
                20,
                2,
                10,
                "#2a2220"
            )
        end
        for ____, x in __iterar((__arrL({53, 389}, 2))) do
            __L1:R(
                c,
                x - 1,
                142,
                43,
                64,
                "#101614"
            )
            __L1:R(
                c,
                x,
                143,
                41,
                62,
                "#263b37"
            )
            __L1:R(
                c,
                x,
                143,
                41,
                2,
                "#47605a"
            )
            for ____, cy in __iterar((__arrL({160, 188}, 2))) do
                __L1:ell(
                    c,
                    x + 20,
                    cy,
                    12,
                    12,
                    "#141c19"
                )
                __L1:ell(
                    c,
                    x + 20,
                    cy,
                    8,
                    8,
                    "#8b9978"
                )
                __L1:ell(
                    c,
                    x + 20,
                    cy,
                    3,
                    3,
                    "#3f5749"
                )
            end
        end
        __L1:R(
            c,
            __TS__Number(-__L1.AO),
            205,
            __L1.AW,
            15,
            "#68594e"
        )
        __L1:R(
            c,
            __TS__Number(-__L1.AO),
            205,
            __L1.AW,
            2,
            "#dbbd86"
        )
        do
            local x = __TS__Number(-__L1.AO)
            while x < __L1.AW - __L1.AO do
                __L1:R(
                    c,
                    x,
                    207,
                    1,
                    13,
                    "#9d8262"
                )
                x = x + 27
            end
        end
        do
            local x = __TS__Number(-__L1.AO) + 6
            while x < __L1.AW - __L1.AO do
                __L1:R(
                    c,
                    x,
                    212,
                    4,
                    4,
                    "#ffe1a0"
                )
                __L1:R(
                    c,
                    x + 1,
                    213,
                    2,
                    2,
                    "#fff3cf"
                )
                x = x + 14
            end
        end
        __L1:R(
            c,
            __TS__Number(-__L1.AO),
            __L1.FLOOR,
            __L1.AW,
            50,
            "#1c1416"
        )
        __L1:R(
            c,
            __TS__Number(-__L1.AO),
            __L1.FLOOR,
            __L1.AW,
            2,
            "#dbbd86"
        )
    end
    __L1.ARENA.menezes = __ord(
        {
            layers = __arrL(
                {
                    __arrL({0.15, "men-tunnel", __L1.MEN_TUNNEL}, 3),
                    __arrL({0.45, "men-walls", __L1.MEN_WALLS}, 3),
                    __arrL({1, "men-stage", __L1.MEN_STAGE}, 3)
                },
                3
            ),
            mid = function(self, c, s, t, ox)
                local tx = math.floor(ox * 0.15 + 0.5)
                do
                    local i = 0
                    while i < 18 do
                        local k = __mod(i, 9) / 8
                        local w = 30 + k * 220
                        local y = 182 + __mod(i, 9) * 2.4
                        local x = 240 - w / 2 + __mod(t * (8 + i) + i * 40, w) + tx
                        __L1:R(
                            c,
                            x,
                            y,
                            4 + k * 6,
                            1,
                            "rgba(150,255,190,.45)"
                        )
                        i = i + 1
                    end
                end
                local wx = math.floor(ox * 0.45 + 0.5)
                do
                    local i = 0
                    while i < 8 do
                        local ____temp_303
                        if i < 4 then
                            ____temp_303 = -120 + i * 50
                        else
                            ____temp_303 = 390 + (i - 4) * 55
                        end
                        local x = ____temp_303 + wx
                        local u = __mod(
                            t * 0.6 + __L1:hash(i),
                            1
                        )
                        __L1:R(
                            c,
                            x,
                            60 + u * 140,
                            1,
                            3,
                            "rgba(160,220,200,.7)"
                        )
                        i = i + 1
                    end
                end
                do
                    local x = __TS__Number(-__L1.AO) + 10
                    while x < __L1.AW - __L1.AO do
                        do
                            local sx = x + wx
                            local y = 30 + math.floor(math.sin(x * 0.1) * 3 + 0.5)
                            if __t(sx < -10 or sx > __L1.LW + 10) then
                                do x = x + 40 continue end
                            end
                            __L1:R(
                                c,
                                sx,
                                0,
                                1,
                                y,
                                "#2a2220"
                            )
                            __L1:R(
                                c,
                                sx - 2,
                                y,
                                5,
                                5,
                                "#ffd88a"
                            )
                        end
                        x = x + 40
                    end
                end
            end,
            near = function(self, c, s, t, ox)
                for ____, x in __iterar((__arrL({53, 389}, 2))) do
                    for ____, cy in __iterar((__arrL({160, 188}, 2))) do
                        local p = math.max(
                            0,
                            math.sin(t * 9 + x + cy)
                        )
                        __L1:ell(
                            c,
                            x + 20 + ox,
                            cy,
                            8 + p,
                            8 + p,
                            "#8b9978"
                        )
                        __L1:ell(
                            c,
                            x + 20 + ox,
                            cy,
                            3 + p * 0.8,
                            3 + p * 0.8,
                            "#3f5749"
                        )
                    end
                end
                do
                    local r2 = 0
                    while r2 < 3 do
                        do
                            local k = 0
                            while k < 40 do
                                do
                                    local x = __TS__Number(-__L1.AO) + 6 + k * 20 + __mod(r2, 2) * 10 + ox
                                    local y = 236 + r2 * 11
                                    if __t(__lt(x, -10) or __gt(x, __L1.LW + 10)) then
                                        do k = k + 1 continue end
                                    end
                                    local bob = math.floor(math.max(
                                        0,
                                        math.sin(t * 5 + k + r2 * 2)
                                    ) * 2 + 0.5)
                                    __L1:ell(
                                        c,
                                        x,
                                        y - bob,
                                        6,
                                        4,
                                        "#2a2228"
                                    )
                                    __L1:ell(
                                        c,
                                        x - 4,
                                        y - 4 - bob,
                                        2.5,
                                        2.5,
                                        "#3a2e34"
                                    )
                                    __L1:ell(
                                        c,
                                        x + 4,
                                        y - 4 - bob,
                                        2.5,
                                        2.5,
                                        "#3a2e34"
                                    )
                                    if math.sin(t * 0.7 + k * 3 + r2) > -0.85 then
                                        __L1:R(
                                            c,
                                            x - 2,
                                            y - 1 - bob,
                                            1,
                                            1,
                                            "#ff5a6a"
                                        )
                                        __L1:R(
                                            c,
                                            x + 2,
                                            y - 1 - bob,
                                            1,
                                            1,
                                            "#ff5a6a"
                                        )
                                    end
                                end
                                k = k + 1
                            end
                        end
                        r2 = r2 + 1
                    end
                end
            end,
            text = function(self, c, t, ox)
                c:save()
                c:translate(ox * 2, 0)
                c.font = "16px Pixel, monospace"
                c.textAlign = "center"
                c.textBaseline = "middle"
                c.fillStyle = "#a8322f"
                c:fillText("PALCO DA PROVOCAÇÃO", 480, 88)
                c.font = "8px Pixel, monospace"
                c.fillStyle = "#3a3a48"
                c:fillText("da roça poudiaaam", 420, 116)
                c:fillText("reeeis pouddiaaam", 545, 134)
                c:fillText("da roça pegou ar", 410, 152)
                c:fillText("teketeketeketeke", 550, 170)
                c:fillText("o pra ravid falando sozinho", 470, 186)
                c:restore()
            end,
            light = function(self, g, s, t)
                __L1:bulbGlow(
                    g,
                    240,
                    178,
                    0.5,
                    "120,240,160",
                    80
                )
                for ____, ____value in __iterar((__arrL(
                    {
                        __arrL({180, "255,120,150"}, 2),
                        __arrL({240, "255,240,200"}, 2),
                        __arrL({300, "120,180,255"}, 2)
                    },
                    3
                ))) do
                    local x = ____value[1]
                    local col = ____value[2]
                    local sw = math.sin(t * 0.7 + x) * 40
                    local cx = 240 + sw + (x - 240) * 0.4
                    local gr = g:createLinearGradient(0, 22, 0, 222)
                    gr:addColorStop(
                        0,
                        ("rgba(" .. tostring(col)) .. ",.3)"
                    )
                    gr:addColorStop(
                        1,
                        ("rgba(" .. tostring(col)) .. ",.04)"
                    )
                    g.fillStyle = gr
                    g:beginPath()
                    g:moveTo(x - 3, 22)
                    g:lineTo(x + 3, 22)
                    g:lineTo(cx + 30, 222)
                    g:lineTo(cx - 30, 222)
                    g:closePath()
                    __call(g, "fill")
                    __L1:pool(
                        g,
                        cx,
                        222,
                        0.9,
                        col,
                        42
                    )
                    __L1:bulbGlow(
                        g,
                        x,
                        22,
                        0.8,
                        col,
                        20
                    )
                end
                do
                    local x = __TS__Number(-__L1.AO) + 8
                    while x < __L1.AW - __L1.AO do
                        __L1:bulbGlow(
                            g,
                            x,
                            214,
                            0.4,
                            "255,210,130",
                            12
                        )
                        x = x + 28
                    end
                end
            end
        },
        "layers,mid,near,text,light"
    )
    __L1.NIK_FAR = function(____, c)
        do
            local i = 0
            while i < 16 do
                __L1:R(
                    c,
                    __TS__Number(-__L1.AO),
                    i * 8,
                    __L1.AW,
                    8,
                    __L1:css(__L1:mix(
                        __arrL({0.16, 0.22, 0.17}, 3),
                        __arrL({0.46, 0.5, 0.38}, 3),
                        (i / 15) ^ 1.2
                    ))
                )
                i = i + 1
            end
        end
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({-100, 60, "#c8a0b8"}, 3),
                __arrL({20, 80, "#d8b0c4"}, 3),
                __arrL({380, 70, "#c8a0b8"}, 3),
                __arrL({520, 90, "#d8b0c4"}, 3)
            },
            4
        ))) do
            local x = ____value[1]
            local h = ____value[2]
            local col = ____value[3]
            do
                local k = -46
                while k <= 46 do
                    local hh = math.floor(h * (1 - math.abs(k) / 46) + 0.5)
                    __L1:R(
                        c,
                        x + k,
                        128 - hh,
                        1,
                        hh,
                        col
                    )
                    if hh > h * 0.62 then
                        __L1:R(
                            c,
                            x + k,
                            128 - hh,
                            1,
                            math.min(6, hh - h * 0.6),
                            "#fff6ea"
                        )
                    end
                    k = k + 1
                end
            end
        end
        local cx = 240
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({120, 22, 128, "#c08a68"}, 4),
                __arrL({90, 20, 106, "#e8a8b8"}, 4),
                __arrL({60, 18, 86, "#c08a68"}, 4),
                __arrL({34, 14, 68, "#f6ecd0"}, 4)
            },
            4
        ))) do
            local w = ____value[1]
            local h = ____value[2]
            local y = ____value[3]
            local col = ____value[4]
            __L1:R(
                c,
                cx - w / 2,
                y - h,
                w,
                h,
                col
            )
            __L1:R(
                c,
                cx - w / 2,
                y - h,
                w,
                3,
                "#fff6ea"
            )
            do
                local k = 0
                while __lt(k, w) do
                    __L1:R(
                        c,
                        cx - w / 2 + k,
                        y - h + 3,
                        3,
                        2 + __mod(k, 3),
                        "#fff6ea"
                    )
                    k = k + 5
                end
            end
            do
                local k = 8
                while k < w - 6 do
                    __L1:R(
                        c,
                        cx - w / 2 + k,
                        y - h + 8,
                        4,
                        6,
                        "#3a2418"
                    )
                    __L1:R(
                        c,
                        cx - w / 2 + k + 1,
                        y - h + 9,
                        2,
                        4,
                        "#ffd88a"
                    )
                    k = k + 14
                end
            end
        end
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({175, 52}, 2),
                __arrL({305, 52}, 2),
                __arrL({205, 70}, 2),
                __arrL({275, 70}, 2)
            },
            4
        ))) do
            local x = ____value[1]
            local h = ____value[2]
            __L1:R(
                c,
                x - 5,
                128 - h,
                10,
                h,
                "#d8b0c4"
            )
            __L1:R(
                c,
                x - 5,
                128 - h,
                10,
                2,
                "#fff6ea"
            )
            do
                local k = 0
                while k < 6 do
                    __L1:R(
                        c,
                        x - 6 + k,
                        128 - h - k,
                        12 - k * 2,
                        1,
                        "#8a4a6a"
                    )
                    k = k + 1
                end
            end
            __L1:ell(
                c,
                x,
                128 - h - 8,
                2.5,
                2.5,
                "#e04a3a"
            )
        end
        __L1:ell(
            c,
            cx,
            50,
            4,
            4,
            "#e04a3a"
        )
        __L1:R(
            c,
            cx,
            42,
            1,
            5,
            "#4a7a3a"
        )
    end
    __L1.NIK_MID = function(____, c)
        __L1:R(
            c,
            __TS__Number(-__L1.AO),
            118,
            __L1.AW,
            12,
            "#5a3420"
        )
        do
            local x = __TS__Number(-__L1.AO)
            while x < __L1.AW - __L1.AO do
                __L1:R(
                    c,
                    x,
                    118,
                    3,
                    1,
                    "#8a5a3a"
                )
                x = x + 6
            end
        end
        do
            local i = 0
            while i < 12 do
                local x = -120 + i * 68 + __mod(i, 2) * 14
                local y = 122
                __L1:R(
                    c,
                    x,
                    y - 26,
                    2,
                    26,
                    "#f6ecd0"
                )
                do
                    local a = 0
                    while a < 70 do
                        local an = a / 70 * 6.28 * 2.2
                        local rr = 2 + a * 0.13
                        __L1:R(
                            c,
                            x + 1 + math.cos(an) * rr,
                            y - 34 + math.sin(an) * rr,
                            2,
                            2,
                            __get(
                                __arrL({"#e84a8a", "#f6ecd0", "#4ab8e8", "#f2d24a"}, 4),
                                __mod(i, 4)
                            )
                        )
                        a = a + 1
                    end
                end
                i = i + 1
            end
        end
        do
            local x = __TS__Number(-__L1.AO)
            while x < __L1.AW - __L1.AO do
                __L1:R(
                    c,
                    x,
                    120,
                    2,
                    10,
                    "#f6ecd0"
                )
                __L1:R(
                    c,
                    x,
                    120 + __band(x / 10, 1) * 4,
                    2,
                    3,
                    "#e04a3a"
                )
                x = x + 10
            end
        end
        do
            local i = 0
            while i < 16 do
                local x = __TS__Number(-__L1.AO) + 10 + i * 50
                local col = __get(
                    __arrL({"#e84a8a", "#6ad86a", "#f2d24a", "#8a5ae8"}, 4),
                    __mod(i, 4)
                )
                __L1:ell(
                    c,
                    x,
                    128,
                    6,
                    5,
                    col
                )
                __L1:ell(
                    c,
                    x - 2,
                    126,
                    2,
                    1.5,
                    "rgba(255,255,255,.6)"
                )
                i = i + 1
            end
        end
    end
    __L1.NIK_NEAR = function(____, c)
        __L1:R(
            c,
            __TS__Number(-__L1.AO),
            130,
            __L1.AW,
            90,
            "#9e7256"
        )
        __L1:R(
            c,
            __TS__Number(-__L1.AO),
            130,
            __L1.AW,
            3,
            "#d1a273"
        )
        do
            local i = 0
            while i < 360 do
                __L1:R(
                    c,
                    __TS__Number(-__L1.AO) + __L1:hash(i + 3) * __L1.AW,
                    134 + __L1:hash(i + 4) * 84,
                    1 + __L1:hash(i) * 2,
                    1,
                    __get(
                        __arrL({"#8a5e44", "#b88660", "#6a4632"}, 3),
                        __mod(i, 3)
                    )
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 50 do
                __L1:R(
                    c,
                    __TS__Number(-__L1.AO) + __L1:hash(i + 71) * __L1.AW,
                    136 + __L1:hash(i + 72) * 80,
                    2,
                    1,
                    __get(
                        __arrL({"#e84a8a", "#f2d24a", "#4ab8e8", "#6ad86a"}, 4),
                        __mod(i, 4)
                    )
                )
                i = i + 1
            end
        end
        __L1:R(
            c,
            105,
            73,
            270,
            23,
            "#6f4937"
        )
        __L1:R(
            c,
            100,
            70,
            280,
            8,
            "#e4bf83"
        )
        __L1:R(
            c,
            100,
            70,
            280,
            1,
            "#f6dca8"
        )
        do
            local i = 0
            while i < 12 do
                __L1:R(
                    c,
                    107 + i * 23,
                    79,
                    7,
                    8 + __mod(i, 3) * 3,
                    "#d8b17a"
                )
                __L1:R(
                    c,
                    107 + i * 23,
                    79,
                    2,
                    8 + __mod(i, 3) * 3,
                    "#f0d3a0"
                )
                i = i + 1
            end
        end
        do
            local x = 100
            while x < 380 do
                __L1:R(
                    c,
                    x,
                    96,
                    4,
                    2,
                    "#4a2e22"
                )
                x = x + 7
            end
        end
        for ____, x in __iterar((__arrL({113, 359}, 2))) do
            __L1:R(
                c,
                x,
                96,
                8,
                118,
                "#644634"
            )
            __L1:R(
                c,
                x,
                96,
                2,
                118,
                "#aa8055"
            )
            __L1:R(
                c,
                x + 6,
                96,
                2,
                118,
                "#3f2a1e"
            )
            do
                local k = 100
                while k < 210 do
                    __L1:R(
                        c,
                        x + 1,
                        k,
                        6,
                        2,
                        "#7a5a40"
                    )
                    k = k + 12
                end
            end
            __L1:R(
                c,
                x - 2,
                208,
                12,
                6,
                "#4a2e22"
            )
        end
        __L1:R(
            c,
            187,
            131,
            107,
            76,
            "#624937"
        )
        __L1:R(
            c,
            192,
            136,
            96,
            66,
            "#85a45d"
        )
        __L1:R(
            c,
            196,
            140,
            88,
            62,
            "#a8bd69"
        )
        __L1:R(
            c,
            196,
            140,
            88,
            2,
            "#c4d68a"
        )
        for ____, yy in __iterar((__arrL({150, 164, 178}, 3))) do
            __L1:R(
                c,
                205,
                yy,
                72,
                3,
                "#72994f"
            )
            __L1:R(
                c,
                205,
                yy,
                72,
                1,
                "#8fb468"
            )
        end
        local crown = __arrL(
            {
                __arrL({187, 133}, 2),
                __arrL({190, 117}, 2),
                __arrL({203, 129}, 2),
                __arrL({217, 111}, 2),
                __arrL({230, 127}, 2),
                __arrL({243, 106}, 2),
                __arrL({256, 127}, 2),
                __arrL({272, 114}, 2),
                __arrL({282, 129}, 2),
                __arrL({294, 118}, 2),
                __arrL({294, 136}, 2)
            },
            11
        )
        do
            local x = 187
            while x <= 294 do
                local top = 133
                do
                    local k = 0
                    while k < __len(crown) - 1 do
                        local a = __get(crown, k)
                        local b = __get(crown, k + 1)
                        if __t(x >= __get(a, 0) and x <= __get(b, 0)) then
                            top = __get(a, 1) + (__get(b, 1) - __get(a, 1)) * (x - __get(a, 0)) / (__get(b, 0) - __get(a, 0))
                        end
                        k = k + 1
                    end
                end
                __L1:R(
                    c,
                    x,
                    top,
                    1,
                    136 - top,
                    "#6b8d43"
                )
                __L1:R(
                    c,
                    x,
                    top,
                    1,
                    1,
                    "#9fc064"
                )
                x = x + 1
            end
        end
        for ____, x in __iterar((__arrL({178, 285}, 2))) do
            __L1:R(
                c,
                x,
                182,
                18,
                34,
                "#74643e"
            )
            __L1:R(
                c,
                x,
                180,
                17,
                6,
                "#b6c26b"
            )
        end
        for ____, x in __iterar((__arrL({64, 403}, 2))) do
            __L1:R(
                c,
                x - 24,
                186,
                48,
                29,
                "#704934"
            )
            __L1:R(
                c,
                x - 22,
                191,
                44,
                8,
                "#d0a66b"
            )
            __L1:R(
                c,
                x - 24,
                184,
                49,
                6,
                "#e5c58e"
            )
            __L1:cakeHD(c, x, 184)
        end
        __L1:board(
            c,
            165,
            84,
            150,
            12,
            "#6f4937",
            "#3f2a1e"
        )
        local L = __arrL(
            {
                __arrL({220, 6, "#6a3a22"}, 3),
                __arrL({226, 4, "#f6ecd0"}, 3),
                __arrL({230, 8, "#e8c070"}, 3),
                __arrL({238, 3, "#f0a0b8"}, 3),
                __arrL({241, 9, "#e8c070"}, 3),
                __arrL({250, 3, "#f6ecd0"}, 3),
                __arrL({253, 17, "#5a3020"}, 3)
            },
            7
        )
        for ____, ____value in __iterar((L)) do
            local y = ____value[1]
            local h = ____value[2]
            local col = ____value[3]
            __L1:R(
                c,
                __TS__Number(-__L1.AO),
                y,
                __L1.AW,
                h,
                col
            )
        end
        do
            local i = 0
            while i < 300 do
                __L1:R(
                    c,
                    __TS__Number(-__L1.AO) + __L1:hash(i + 91) * __L1.AW,
                    231 + __L1:hash(i + 92) * 18,
                    1,
                    1,
                    __t(__mod(i, 2)) and "#d8a050" or "#f8d890"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 70 do
                __L1:R(
                    c,
                    __TS__Number(-__L1.AO) + __L1:hash(i + 51) * __L1.AW,
                    255 + __L1:hash(i + 52) * 12,
                    2,
                    1,
                    __get(
                        __arrL({"#e84a8a", "#f2d24a", "#4ab8e8", "#6ad86a"}, 4),
                        __mod(i, 4)
                    )
                )
                i = i + 1
            end
        end
        do
            local x = __TS__Number(-__L1.AO)
            while x < __L1.AW - __L1.AO do
                __L1:R(
                    c,
                    x,
                    226 + 4,
                    4,
                    2 + __band(x / 9, 1) * 2,
                    "#f6ecd0"
                )
                x = x + 9
            end
        end
    end
    __L1.ARENA.nikolas = __ord(
        {
            layers = __arrL(
                {
                    __arrL({0.12, "nik-far", __L1.NIK_FAR}, 3),
                    __arrL({0.35, "nik-mid", __L1.NIK_MID}, 3),
                    __arrL({1, "nik-near", __L1.NIK_NEAR}, 3)
                },
                3
            ),
            back = function(self, c, s, t, ox)
            end,
            mid = function(self, c, s, t, ox)
                do
                    local i = 0
                    while i < 7 do
                        local x = __mod(
                            __L1:hash(i + 9) * 700 + t * (4 + i * 1.5),
                            760
                        ) - 140
                        local y = 8 + __L1:hash(i + 12) * 40
                        local w = 50 + __L1:hash(i + 14) * 50
                        __L1:R(
                            c,
                            x,
                            y,
                            w,
                            7,
                            "rgba(30,44,30,.75)"
                        )
                        __L1:R(
                            c,
                            x + 8,
                            y - 4,
                            w - 20,
                            4,
                            "rgba(30,44,30,.75)"
                        )
                        __L1:R(
                            c,
                            x + 4,
                            y + 7,
                            w - 10,
                            2,
                            "rgba(20,30,20,.6)"
                        )
                        i = i + 1
                    end
                end
                local rx = math.floor(ox * 0.35 + 0.5)
                do
                    local i = 0
                    while i < 20 do
                        local x = __mod(i * 41 + t * 12, __L1.AW) - __L1.AO + rx
                        __L1:R(
                            c,
                            x,
                            120 + __mod(i, 3) * 3,
                            6,
                            1,
                            "#8a5a3a"
                        )
                        i = i + 1
                    end
                end
            end,
            near = function(self, c, s, t, ox)
                do
                    local i = 0
                    while i < 9 do
                        local x = 108 + i * 31 + ox
                        local u = __mod(
                            t * 0.35 + __L1:hash(i + 5),
                            1
                        )
                        __L1:R(
                            c,
                            x,
                            98 + u * 40,
                            2,
                            3 + u * 4,
                            "#a8bd69"
                        )
                        __L1:ell(
                            c,
                            x + 1,
                            98 + u * 40 + 5 + u * 4,
                            2,
                            1.5,
                            "#a8bd69"
                        )
                        i = i + 1
                    end
                end
            end,
            text = function(self, c, t, ox)
                c:save()
                c:translate(ox * 2, 0)
                c.font = "16px Pixel, monospace"
                c.textAlign = "center"
                c.textBaseline = "middle"
                c.fillStyle = "#2a1a10"
                c:fillText("O TRONO DO BOLO ROUBADO", 482, 182)
                c.fillStyle = "#f7e4bc"
                c:fillText("O TRONO DO BOLO ROUBADO", 480, 180)
                c:restore()
            end,
            light = function(self, g, s, t)
                local sh = 0.5 + 0.5 * math.sin(t * 1.5)
                __L1:bulbGlow(
                    g,
                    240,
                    160,
                    0.35 + sh * 0.15,
                    "170,230,110",
                    62
                )
                for ____, ____value in __iterar((__arrL(
                    {
                        __arrL({240, 82}, 2),
                        __arrL({222, 102}, 2),
                        __arrL({258, 102}, 2)
                    },
                    3
                ))) do
                    local x = ____value[1]
                    local y = ____value[2]
                    __L1:bulbGlow(
                        g,
                        x,
                        y,
                        0.5,
                        "255,214,140",
                        14
                    )
                end
            end
        },
        "layers,back,mid,near,text,light"
    )
    __L1.ARENA.dede = __ord(
        {
            layers = __arrL(
                {
                    __arrL(
                        {
                            0.12,
                            "dede-far",
                            function(____, c)
                                do
                                    local i = 0
                                    while i < 14 do
                                        __L1:R(
                                            c,
                                            __TS__Number(-__L1.AO),
                                            i * 12,
                                            __L1.AW,
                                            12,
                                            __L1:css(__L1:mix(
                                                __arrL({0.07, 0.09, 0.15}, 3),
                                                __arrL({0.2, 0.24, 0.3}, 3),
                                                i / 13
                                            ))
                                        )
                                        i = i + 1
                                    end
                                end
                                __L1:hillLights(
                                    c,
                                    160,
                                    70,
                                    2.2,
                                    "#1a222c",
                                    900
                                )
                            end
                        },
                        3
                    ),
                    __arrL(
                        {
                            0.4,
                            "dede-mid",
                            function(____, c) return __L1:favRow(
                                c,
                                178,
                                34,
                                30,
                                70,
                                0.55,
                                0.45,
                                9,
                                true
                            ) end
                        },
                        3
                    ),
                    __arrL(
                        {
                            1,
                            "dede-near",
                            function(____, c)
                                __L1:R(
                                    c,
                                    __TS__Number(-__L1.AO),
                                    174,
                                    __L1.AW,
                                    46,
                                    "#5b6a6a"
                                )
                                __L1:R(
                                    c,
                                    __TS__Number(-__L1.AO),
                                    174,
                                    __L1.AW,
                                    2,
                                    "#a6bcb0"
                                )
                                do
                                    local x = __TS__Number(-__L1.AO)
                                    while x < __L1.AW - __L1.AO do
                                        __L1:R(
                                            c,
                                            x,
                                            176,
                                            1,
                                            44,
                                            "#4a5858"
                                        )
                                        x = x + 22
                                    end
                                end
                                do
                                    local i = 0
                                    while i < 300 do
                                        __L1:R(
                                            c,
                                            __TS__Number(-__L1.AO) + __L1:hash(i + 401) * __L1.AW,
                                            178 + __L1:hash(i + 402) * 40,
                                            2,
                                            1,
                                            __t(__mod(i, 2)) and "#52605f" or "#6a7a78"
                                        )
                                        i = i + 1
                                    end
                                end
                                do
                                    local x = __TS__Number(-__L1.AO)
                                    while x < __L1.AW - __L1.AO do
                                        __L1:R(
                                            c,
                                            x,
                                            156,
                                            2,
                                            18,
                                            "#7a8a86"
                                        )
                                        x = x + 18
                                    end
                                end
                                __L1:R(
                                    c,
                                    __TS__Number(-__L1.AO),
                                    156,
                                    __L1.AW,
                                    2,
                                    "#8a9a96"
                                )
                                __L1:R(
                                    c,
                                    __TS__Number(-__L1.AO),
                                    165,
                                    __L1.AW,
                                    1,
                                    "#6a7a76"
                                )
                                for ____, x in __iterar((__arrL({48, 392}, 2))) do
                                    __L1:R(
                                        c,
                                        x,
                                        62,
                                        37,
                                        112,
                                        "#4a3a36"
                                    )
                                    do
                                        local y = 62
                                        while y < 174 do
                                            do
                                                local k = __band(y / 5, 1) * 5
                                                while k < 37 do
                                                    __L1:R(
                                                        c,
                                                        x + k,
                                                        y,
                                                        9,
                                                        4,
                                                        __get(
                                                            __arrL({"#5a463e", "#6a5246", "#52403a"}, 3),
                                                            __mod(k + y, 3)
                                                        )
                                                    )
                                                    k = k + 10
                                                end
                                            end
                                            y = y + 5
                                        end
                                    end
                                    __L1:R(
                                        c,
                                        x - 5,
                                        54,
                                        47,
                                        9,
                                        "#2a2a2e"
                                    )
                                    __L1:R(
                                        c,
                                        x - 5,
                                        54,
                                        47,
                                        2,
                                        "#5a5a62"
                                    )
                                    __L1:R(
                                        c,
                                        x + 6,
                                        44,
                                        25,
                                        11,
                                        "#3a3a40"
                                    )
                                end
                                for ____, x in __iterar((__arrL({150, 300}, 2))) do
                                    __L1:R(
                                        c,
                                        x,
                                        138,
                                        22,
                                        18,
                                        "#2c5f94"
                                    )
                                    __L1:R(
                                        c,
                                        x,
                                        138,
                                        22,
                                        3,
                                        "#5a94c8"
                                    )
                                    __L1:R(
                                        c,
                                        x + 2,
                                        135,
                                        18,
                                        3,
                                        "#3a7ab8"
                                    )
                                    __L1:R(
                                        c,
                                        x + 4,
                                        156,
                                        2,
                                        4,
                                        "#3a3a40"
                                    )
                                    __L1:R(
                                        c,
                                        x + 16,
                                        156,
                                        2,
                                        4,
                                        "#3a3a40"
                                    )
                                end
                                __L1:R(
                                    c,
                                    128,
                                    88,
                                    224,
                                    22,
                                    "#14181e"
                                )
                                __L1:R(
                                    c,
                                    129,
                                    89,
                                    222,
                                    20,
                                    "#1e2630"
                                )
                                __L1:R(
                                    c,
                                    129,
                                    89,
                                    222,
                                    1,
                                    "#e84a9a"
                                )
                                __L1:R(
                                    c,
                                    129,
                                    108,
                                    222,
                                    1,
                                    "#e84a9a"
                                )
                                __L1:R(
                                    c,
                                    129,
                                    89,
                                    1,
                                    20,
                                    "#e84a9a"
                                )
                                __L1:R(
                                    c,
                                    350,
                                    89,
                                    1,
                                    20,
                                    "#e84a9a"
                                )
                                __L1:R(
                                    c,
                                    160,
                                    110,
                                    2,
                                    46,
                                    "#3a3a40"
                                )
                                __L1:R(
                                    c,
                                    318,
                                    110,
                                    2,
                                    46,
                                    "#3a3a40"
                                )
                                do
                                    local k = 0
                                    while k < 60 do
                                        __L1:R(
                                            c,
                                            182 + k * 2,
                                            132 + math.floor(math.sin(k * 0.2) * 4 + 0.5),
                                            2,
                                            1,
                                            "#3a3a3a"
                                        )
                                        k = k + 1
                                    end
                                end
                                do
                                    local j = 0
                                    while j < 5 do
                                        local x = 190 + j * 22
                                        __L1:R(
                                            c,
                                            x,
                                            134 + math.floor(math.sin((x - 182) / 2 * 0.2) * 4 + 0.5),
                                            12,
                                            14,
                                            __get(
                                                __arrL({
                                                    "#e0c17c",
                                                    "#6697ac",
                                                    "#dc8666",
                                                    "#d8d0a7",
                                                    "#9a5ac8"
                                                }, 5),
                                                j
                                            )
                                        )
                                        j = j + 1
                                    end
                                end
                            end
                        },
                        3
                    )
                },
                3
            ),
            mid = function(self, c, s, t, ox)
                do
                    local i = 0
                    while i < 9 do
                        local x = __mod(i * 130 + t * (6 + i * 1.3), 900) - 210
                        local y = 120 + __mod(i, 4) * 22 + math.sin(t * 0.5 + i) * 6
                        c.fillStyle = ("rgba(200,214,206," .. tostring(0.13 + __mod(i, 3) * 0.04)) .. ")"
                        __L1:ell(
                            c,
                            x,
                            y,
                            54 + __mod(i, 3) * 14,
                            10 + __mod(i, 2) * 5,
                            c.fillStyle
                        )
                        __L1:ell(
                            c,
                            x + 30,
                            y - 8,
                            30,
                            9,
                            c.fillStyle
                        )
                        i = i + 1
                    end
                end
            end,
            near = function(self, c, s, t, ox)
                for ____, x in __iterar((__arrL({48, 392}, 2))) do
                    do
                        local i = 0
                        while i < 8 do
                            local u = __mod(t * 0.28 + i / 8, 1)
                            local px = x + ox + 18 + math.sin(t + i * 1.7) * 6 * u + u * 18
                            local py = 42 - u * 52
                            local r = 4 + u * 13
                            __L1:ell(
                                c,
                                px,
                                py,
                                r,
                                r * 0.8,
                                ("rgba(210,220,214," .. tostring((1 - u) * 0.55)) .. ")"
                            )
                            i = i + 1
                        end
                    end
                end
            end,
            text = function(self, c, t, ox)
                c:save()
                c:translate(ox * 2, 0)
                c.font = "16px Pixel, monospace"
                c.textAlign = "center"
                c.textBaseline = "middle"
                c.fillStyle = "#ff7ac0"
                c:fillText("DEDÊ · ENTRE AS NUVENS", 480, 198)
                c:restore()
            end,
            light = function(self, g, s, t)
                local f = 0.85 + 0.15 * math.sin(t * 17) * math.sin(t * 5)
                __L1:bulbGlow(
                    g,
                    240,
                    99,
                    0.8 * f,
                    "255,90,170",
                    70
                )
                for ____, x in __iterar((__arrL({66, 410}, 2))) do
                    __L1:bulbGlow(
                        g,
                        x,
                        40,
                        0.3,
                        "255,180,120",
                        30
                    )
                end
            end
        },
        "layers,mid,near,text,light"
    )
    __L1.ARENA.nicolas = __ord(
        {
            layers = __arrL(
                {
                    __arrL(
                        {
                            0.08,
                            "nic-sky",
                            function(____, c)
                                do
                                    local i = 0
                                    while i < 16 do
                                        __L1:R(
                                            c,
                                            __TS__Number(-__L1.AO),
                                            i * 12,
                                            __L1.AW,
                                            12,
                                            __L1:css(__L1:mix(
                                                __arrL({0.05, 0.12, 0.24}, 3),
                                                __arrL({0.2, 0.45, 0.5}, 3),
                                                (i / 15) ^ 1.3
                                            ))
                                        )
                                        i = i + 1
                                    end
                                end
                                for ____, ____value in __iterar((__arrL(
                                    {
                                        __arrL({60, 60, 70, "rgba(120,80,200,.16)"}, 4),
                                        __arrL({420, 40, 80, "rgba(60,200,200,.12)"}, 4),
                                        __arrL({260, 120, 90, "rgba(240,200,120,.08)"}, 4)
                                    },
                                    3
                                ))) do
                                    local x = ____value[1]
                                    local y = ____value[2]
                                    local r = ____value[3]
                                    local col = ____value[4]
                                    do
                                        local k = 0
                                        while k < 6 do
                                            __L1:ell(
                                                c,
                                                x,
                                                y,
                                                r * (1 - k * 0.14),
                                                r * 0.5 * (1 - k * 0.14),
                                                col
                                            )
                                            k = k + 1
                                        end
                                    end
                                end
                                local pts = __arrL({}, 0)
                                do
                                    local i = 0
                                    while i < 90 do
                                        local x = __TS__Number(-__L1.AO) + __L1:hash(i + 501) * __L1.AW
                                        local y = 4 + __L1:hash(i + 502) * 150
                                        __call(
                                            pts,
                                            "push",
                                            __arrL({x, y}, 2)
                                        )
                                        __L1:R(
                                            c,
                                            x,
                                            y,
                                            1,
                                            1,
                                            __t(__mod(i, 4)) and "#e0f8d9" or "#f7e6aa"
                                        )
                                        if __mod(i, 9) == 0 then
                                            __L1:R(
                                                c,
                                                x - 2,
                                                y,
                                                5,
                                                1,
                                                "#a2dfd7"
                                            )
                                            __L1:R(
                                                c,
                                                x,
                                                y - 2,
                                                1,
                                                5,
                                                "#a2dfd7"
                                            )
                                        end
                                        i = i + 1
                                    end
                                end
                                do
                                    local i = 0
                                    while i < 40 do
                                        local a = __get(pts, i)
                                        local b = __get(pts, i + 1)
                                        if __hypot(
                                            __get(a, 0) - __get(b, 0),
                                            __get(a, 1) - __get(b, 1)
                                        ) < 120 then
                                            __L1:limb(
                                                c,
                                                __arrL({a, b}, 2),
                                                1,
                                                "rgba(160,220,215,.35)"
                                            )
                                        end
                                        i = i + 4
                                    end
                                end
                            end
                        },
                        3
                    ),
                    __arrL(
                        {
                            0.35,
                            "nic-isles",
                            function(____, c)
                                for ____, ____value in __iterar((__arrL(
                                    {
                                        __arrL({-90, 110, 60}, 3),
                                        __arrL({40, 70, 44}, 3),
                                        __arrL({330, 64, 50}, 3),
                                        __arrL({470, 104, 66}, 3),
                                        __arrL({200, 130, 30}, 3)
                                    },
                                    5
                                ))) do
                                    local x = ____value[1]
                                    local y = ____value[2]
                                    local w = ____value[3]
                                    do
                                        local r2 = 0
                                        while r2 < w * 0.5 do
                                            local k = r2 / (w * 0.5)
                                            local ww = w * (1 - k * k)
                                            __L1:R(
                                                c,
                                                x - ww / 2,
                                                y + r2,
                                                ww,
                                                1,
                                                __L1:css(__L1:mix(
                                                    __arrL({0.35, 0.42, 0.46}, 3),
                                                    __arrL({0.2, 0.26, 0.32}, 3),
                                                    k
                                                ))
                                            )
                                            r2 = r2 + 1
                                        end
                                    end
                                    __L1:R(
                                        c,
                                        x - w / 2,
                                        y - 3,
                                        w,
                                        4,
                                        "#6aa878"
                                    )
                                    __L1:R(
                                        c,
                                        x - w / 2,
                                        y - 3,
                                        w,
                                        1,
                                        "#a8e0a0"
                                    )
                                    do
                                        local k = 0
                                        while k < w do
                                            __L1:R(
                                                c,
                                                x - w / 2 + k,
                                                y - 6 - __mod(k, 3),
                                                2,
                                                3 + __mod(k, 3),
                                                "#5a9a6a"
                                            )
                                            k = k + 6
                                        end
                                    end
                                    __L1:R(
                                        c,
                                        x - 3,
                                        y - 18,
                                        6,
                                        15,
                                        "#e8e0c8"
                                    )
                                    __L1:R(
                                        c,
                                        x - 5,
                                        y - 20,
                                        10,
                                        3,
                                        "#e4ce8e"
                                    )
                                end
                            end
                        },
                        3
                    ),
                    __arrL(
                        {
                            1,
                            "nic-near",
                            function(____, c)
                                do
                                    local i = 0
                                    while i < 9 do
                                        local x = __TS__Number(-__L1.AO) + i * 92
                                        __L1:ell(
                                            c,
                                            x + 40,
                                            196,
                                            60,
                                            14,
                                            "#c8e0dc"
                                        )
                                        __L1:ell(
                                            c,
                                            x + 20,
                                            190,
                                            34,
                                            10,
                                            "#e8f4f0"
                                        )
                                        i = i + 1
                                    end
                                end
                                c:save()
                                c:translate(
                                    __TS__Number(-__L1.AO),
                                    0
                                )
                                __L1:tileFloor(
                                    c,
                                    __L1.AW,
                                    __L1.FLOOR,
                                    __arrL({"#e8eee6", "#9ac8c4", "#f4f8f2", "#b4dad4"}, 4),
                                    16
                                )
                                c:restore()
                                do
                                    local x = __TS__Number(-__L1.AO)
                                    while x < __L1.AW - __L1.AO do
                                        __L1:R(
                                            c,
                                            x,
                                            __L1.FLOOR + 1,
                                            1,
                                            50,
                                            "rgba(228,206,142,.5)"
                                        )
                                        x = x + 32
                                    end
                                end
                                for ____, x in __iterar((__arrL({-36, 54, 373, 460}, 4))) do
                                    __L1:R(
                                        c,
                                        x - 3,
                                        70,
                                        30,
                                        150,
                                        "#294c60"
                                    )
                                    __L1:R(
                                        c,
                                        x,
                                        74,
                                        24,
                                        140,
                                        "#e8e8dc"
                                    )
                                    do
                                        local k = 0
                                        while k < 24 do
                                            __L1:R(
                                                c,
                                                x + k,
                                                74,
                                                1,
                                                140,
                                                "rgba(120,140,140,.25)"
                                            )
                                            k = k + 4
                                        end
                                    end
                                    __L1:R(
                                        c,
                                        x,
                                        74,
                                        3,
                                        140,
                                        "#ffffff"
                                    )
                                    __L1:R(
                                        c,
                                        x + 20,
                                        74,
                                        4,
                                        140,
                                        "#b8c4bc"
                                    )
                                    __L1:R(
                                        c,
                                        x - 5,
                                        66,
                                        34,
                                        9,
                                        "#e4ce8e"
                                    )
                                    __L1:R(
                                        c,
                                        x - 5,
                                        66,
                                        34,
                                        2,
                                        "#fff2c0"
                                    )
                                    __L1:R(
                                        c,
                                        x - 7,
                                        60,
                                        38,
                                        7,
                                        "#a38b59"
                                    )
                                    __L1:R(
                                        c,
                                        x - 5,
                                        210,
                                        34,
                                        10,
                                        "#d6c28c"
                                    )
                                    do
                                        local j = 0
                                        while j < 4 do
                                            local yy = 92 + j * 30
                                            __L1:R(
                                                c,
                                                x + 10,
                                                yy,
                                                4,
                                                1,
                                                "#3ad0c0"
                                            )
                                            __L1:R(
                                                c,
                                                x + 11,
                                                yy - 3,
                                                1,
                                                7,
                                                "#3ad0c0"
                                            )
                                            __L1:R(
                                                c,
                                                x + 8,
                                                yy + 4,
                                                8,
                                                1,
                                                "#3ad0c0"
                                            )
                                            j = j + 1
                                        end
                                    end
                                end
                            end
                        },
                        3
                    )
                },
                3
            ),
            mid = function(self, c, s, t, ox)
                local cx = 240 + math.floor(ox * 0.35 + 0.5)
                local cy = 92
                local h = 47 + math.sin(t * 0.9) * 1.5
                do
                    local arm = 0
                    while arm < 6 do
                        do
                            local r = 26
                            while r < 190 do
                                local a = arm / 6 * math.pi * 2 + r * 0.028 - t * 0.7
                                local f = 1 - r / 190
                                local ____c_305 = c
                                local ____t_result_304
                                if __t(__mod(arm, 2)) then
                                    ____t_result_304 = ("rgba(255,222,120," .. tostring(0.55 * f)) .. ")"
                                else
                                    ____t_result_304 = ("rgba(120,240,230," .. tostring(0.45 * f)) .. ")"
                                end
                                ____c_305.fillStyle = ____t_result_304
                                c:fillRect(
                                    math.floor(cx + math.cos(a) * r + 0.5),
                                    math.floor(cy + math.sin(a) * r * 0.72 + 0.5),
                                    r > 120 and 1 or 2,
                                    r > 120 and 1 or 2
                                )
                                r = r + 2
                            end
                        end
                        arm = arm + 1
                    end
                end
                do
                    local k = 0
                    while k < 4 do
                        local r = __mod(t * 46 + k * 52, 208) + 40
                        local al = math.max(0, 1 - r / 248)
                        do
                            local a = 0
                            while a < 140 do
                                do
                                    local an = a / 140 * math.pi * 2
                                    if __mod(a, 3) == 0 then
                                        do a = a + 1 continue end
                                    end
                                    c.fillStyle = ("rgba(255,236,170," .. tostring(0.6 * al)) .. ")"
                                    c:fillRect(
                                        math.floor(cx + math.cos(an) * r + 0.5),
                                        math.floor(cy + math.sin(an) * r * 0.72 + 0.5),
                                        2,
                                        1
                                    )
                                end
                                a = a + 1
                            end
                        end
                        k = k + 1
                    end
                end
                __L1:ell(
                    c,
                    cx,
                    cy,
                    h + 8,
                    h + 8,
                    "rgba(115,155,140,.5)"
                )
                __L1:ell(
                    c,
                    cx,
                    cy,
                    h,
                    h,
                    "#d5c58a"
                )
                __L1:ell(
                    c,
                    cx,
                    cy,
                    h - 4,
                    h - 4,
                    "#346d7a"
                )
                __L1:ell(
                    c,
                    cx,
                    cy,
                    27,
                    27,
                    "#c4dcc0"
                )
                __L1:ell(
                    c,
                    cx,
                    cy,
                    22,
                    22,
                    "#f7e8af"
                )
                __L1:ell(
                    c,
                    cx - 5,
                    cy - 6,
                    8,
                    6,
                    "#fffbe0"
                )
                do
                    local i = 0
                    while i < 12 do
                        local a = i * math.pi / 6 + t * 0.07
                        local x = cx + math.cos(a) * (h + 2)
                        local y = cy + math.sin(a) * (h + 2)
                        do
                            local k = 0
                            while k < 4 do
                                __L1:R(
                                    c,
                                    x - k,
                                    y - 4 + k,
                                    k * 2 + 1,
                                    1,
                                    "#ffecb1"
                                )
                                k = k + 1
                            end
                        end
                        do
                            local k = 0
                            while k < 4 do
                                __L1:R(
                                    c,
                                    x - (3 - k),
                                    y + k,
                                    (3 - k) * 2 + 1,
                                    1,
                                    "#ffecb1"
                                )
                                k = k + 1
                            end
                        end
                        i = i + 1
                    end
                end
                for ____, ____value in __iterar((__arrL(
                    {
                        __arrL({40, 70}, 2),
                        __arrL({330, 64}, 2),
                        __arrL({470, 104}, 2)
                    },
                    3
                ))) do
                    local x = ____value[1]
                    local y = ____value[2]
                    local fx = x + math.floor(ox * 0.35 + 0.5)
                    do
                        local k = 0
                        while k < 6 do
                            local u = __mod(t * 0.5 + k / 6, 1)
                            __L1:R(
                                c,
                                fx + 4,
                                y + 20 + u * 60,
                                2,
                                4,
                                ("rgba(200,250,255," .. tostring(0.7 * (1 - u))) .. ")"
                            )
                            k = k + 1
                        end
                    end
                end
            end,
            near = function(self, c, s, t, ox)
                local fx = ox
                do
                    local a = 0
                    while a < 220 do
                        do
                            local an = a / 220 * math.pi * 2 + t * 0.4
                            local on = __mod(a, 11) < 7
                            if not __t(on) then
                                do a = a + 1 continue end
                            end
                            __L1:R(
                                c,
                                240 + fx + math.cos(an) * 150,
                                238 + math.sin(an) * 18,
                                2,
                                1,
                                __t(__mod(a, 2)) and "rgba(255,226,130,.75)" or "rgba(120,240,230,.7)"
                            )
                        end
                        a = a + 1
                    end
                end
                do
                    local a = 0
                    while a < 12 do
                        local an = a / 12 * math.pi * 2 - t * 0.6
                        local x = 240 + fx + math.cos(an) * 118
                        local y = 238 + math.sin(an) * 14
                        __L1:R(
                            c,
                            x - 2,
                            y,
                            5,
                            1,
                            "#ffe6a0"
                        )
                        __L1:R(
                            c,
                            x,
                            y - 2,
                            1,
                            5,
                            "#ffe6a0"
                        )
                        a = a + 1
                    end
                end
                do
                    local x = __TS__Number(-__L1.AO)
                    while x < __L1.AW - __L1.AO do
                        do
                            local sx = x + fx
                            if __t(__lt(sx, -6) or __gt(sx, __L1.LW + 6)) then
                                do x = x + 3 continue end
                            end
                            local h = 6 + math.max(
                                0,
                                math.sin(x * 0.09 + t * 3.2) * 9 + math.sin(x * 0.23 - t * 5.1) * 5 + math.sin(x * 0.031 + t) * 6
                            )
                            do
                                local k = 0
                                while k < h do
                                    local u = k / h
                                    __L1:R(
                                        c,
                                        sx + math.floor(math.sin(t * 6 + x + k * 0.4) * u * 1.5 + 0.5),
                                        __L1.FLOOR - k,
                                        2,
                                        1,
                                        u < 0.3 and "#fff6d0" or (u < 0.6 and "#ffd25a" or (u < 0.85 and "#5ae8d8" or "rgba(90,232,216,.4)"))
                                    )
                                    k = k + 1
                                end
                            end
                        end
                        x = x + 3
                    end
                end
                do
                    local i = 0
                    while i < 70 do
                        do
                            local u = __mod(
                                t * (0.18 + __L1:hash(i) * 0.2) + __L1:hash(i + 40),
                                1
                            )
                            local x = __TS__Number(-__L1.AO) + __L1:hash(i + 900) * __L1.AW + fx + math.sin(t * 2 + i) * 4
                            local y = __L1.FLOOR - u * 200
                            if __t(__lt(x, -2) or __gt(x, __L1.LW + 2)) then
                                do i = i + 1 continue end
                            end
                            local ____L1_R_308 = __L1.R
                            local ____array_307 = __TS__SparseArrayNew(
                                c,
                                x,
                                y,
                                __t(__mod(i, 4)) and 1 or 2,
                                __t(__mod(i, 4)) and 2 or 2
                            )
                            local ____t_result_306
                            if __t(__mod(i, 3)) then
                                ____t_result_306 = ("rgba(255,232,150," .. tostring(1 - u)) .. ")"
                            else
                                ____t_result_306 = ("rgba(140,250,240," .. tostring(1 - u)) .. ")"
                            end
                            __TS__SparseArrayPush(____array_307, ____t_result_306)
                            ____L1_R_308(
                                __L1,
                                __TS__SparseArraySpread(____array_307)
                            )
                        end
                        i = i + 1
                    end
                end
                for ____, x in __iterar((__arrL({-36, 54, 373, 460}, 4))) do
                    local sx = x + fx + 12
                    local p = 0.5 + 0.5 * math.sin(t * 2.4 + x)
                    do
                        local j = 0
                        while j < 4 do
                            local yy = 92 + j * 30
                            c.fillStyle = ("rgba(120,255,240," .. tostring(0.4 + 0.6 * p)) .. ")"
                            c:fillRect(sx - 2, yy, 4, 1)
                            c:fillRect(sx - 1, yy - 3, 1, 7)
                            c:fillRect(sx - 4, yy + 4, 8, 1)
                            j = j + 1
                        end
                    end
                end
            end,
            text = function(self, c, t, ox)
            end,
            light = function(self, g, s, t)
                local pulse = 0.5 + 0.5 * math.sin(t * 2.2)
                __L1:bulbGlow(
                    g,
                    240,
                    92,
                    0.65 + pulse * 0.2,
                    "255,236,170",
                    120
                )
                __L1:bulbGlow(
                    g,
                    240,
                    80,
                    0.28,
                    "120,240,230",
                    150
                )
                for ____, x in __iterar((__arrL({-24, 66, 385, 472}, 4))) do
                    local gr = g:createLinearGradient(0, 220, 0, 0)
                    gr:addColorStop(
                        0,
                        ("rgba(255,226,140," .. tostring(0.14 + pulse * 0.08)) .. ")"
                    )
                    gr:addColorStop(1, "rgba(120,240,230,0)")
                    g.fillStyle = gr
                    g:fillRect(x - 10, 0, 20, 220)
                end
                local fl = g:createLinearGradient(0, 160, 0, 225)
                fl:addColorStop(0, "rgba(255,214,90,0)")
                fl:addColorStop(
                    1,
                    ("rgba(255,214,90," .. tostring(0.12 + pulse * 0.08)) .. ")"
                )
                g.fillStyle = fl
                g:fillRect(
                    __TS__Number(-__L1.AO),
                    160,
                    __L1.AW,
                    65
                )
                __L1:pool(
                    g,
                    240,
                    238,
                    0.45,
                    "255,230,140",
                    170
                )
                for ____, sd in __iterar((__arrL({-1, 1}, 2))) do
                    local gx = sd < 0 and 0 or __L1.LW
                    local eg = g:createLinearGradient(gx, 0, gx - sd * 70, 0)
                    eg:addColorStop(
                        0,
                        ("rgba(255,214,110," .. tostring(0.22 + pulse * 0.1)) .. ")"
                    )
                    eg:addColorStop(1, "rgba(255,214,110,0)")
                    g.fillStyle = eg
                    g:fillRect(sd < 0 and 0 or __L1.LW - 70, 0, 70, __L1.LH)
                end
                do
                    local i = 0
                    while i < 10 do
                        local a = i / 10 * math.pi * 2 + t * 0.12
                        local gr = g:createLinearGradient(
                            240,
                            92,
                            240 + math.cos(a) * 260,
                            92 + math.sin(a) * 260
                        )
                        gr:addColorStop(0, "rgba(255,240,170,.16)")
                        gr:addColorStop(1, "rgba(255,240,170,0)")
                        g.fillStyle = gr
                        g:beginPath()
                        g:moveTo(240, 92)
                        g:lineTo(
                            240 + math.cos(a - 0.05) * 260,
                            92 + math.sin(a - 0.05) * 260
                        )
                        g:lineTo(
                            240 + math.cos(a + 0.05) * 260,
                            92 + math.sin(a + 0.05) * 260
                        )
                        g:closePath()
                        __call(g, "fill")
                        i = i + 1
                    end
                end
            end
        },
        "layers,mid,near,text,light"
    )
    __L1.ARENA.freddy = __ord(
        {
            layers = __arrL(
                {
                    __arrL(
                        {
                            0.1,
                            "fre-sky",
                            function(____, c)
                                do
                                    local i = 0
                                    while i < 18 do
                                        __L1:R(
                                            c,
                                            __TS__Number(-__L1.AO),
                                            i * 8,
                                            __L1.AW,
                                            8,
                                            __L1:css(__L1:mix(
                                                __L1:mix(
                                                    __arrL({0.43, 0.42, 0.57}, 3),
                                                    __arrL({0.76, 0.56, 0.57}, 3),
                                                    math.min(1, i / 9)
                                                ),
                                                __arrL({0.89, 0.7, 0.54}, 3),
                                                math.max(0, (i - 9) / 8)
                                            ))
                                        )
                                        i = i + 1
                                    end
                                end
                                do
                                    local k = 0
                                    while k < 6 do
                                        __L1:ell(
                                            c,
                                            364,
                                            92,
                                            40 - k * 4,
                                            40 - k * 4,
                                            ("rgba(255,214,160," .. tostring(0.08 + k * 0.03)) .. ")"
                                        )
                                        k = k + 1
                                    end
                                end
                                __L1:ell(
                                    c,
                                    364,
                                    92,
                                    21,
                                    21,
                                    "#f5d3a0"
                                )
                                for ____, y in __iterar((__arrL({88, 95, 101}, 3))) do
                                    __L1:R(
                                        c,
                                        340,
                                        y,
                                        48,
                                        1,
                                        "rgba(195,143,145,.6)"
                                    )
                                end
                                do
                                    local i = 0
                                    while i < 6 do
                                        local x = -100 + i * 140
                                        local y = 30 + __mod(i, 3) * 16
                                        __L1:R(
                                            c,
                                            x,
                                            y,
                                            60,
                                            4,
                                            "rgba(255,220,200,.55)"
                                        )
                                        __L1:R(
                                            c,
                                            x + 10,
                                            y - 3,
                                            34,
                                            3,
                                            "rgba(255,220,200,.55)"
                                        )
                                        i = i + 1
                                    end
                                end
                                __L1:hillLights(
                                    c,
                                    150,
                                    60,
                                    3.4,
                                    "#6a5a78",
                                    0
                                )
                            end
                        },
                        3
                    ),
                    __arrL(
                        {
                            0.4,
                            "fre-fav",
                            function(____, c) return __L1:favRow(
                                c,
                                176,
                                30,
                                26,
                                66,
                                0.3,
                                0.25,
                                30,
                                false
                            ) end
                        },
                        3
                    ),
                    __arrL(
                        {
                            1,
                            "fre-ring",
                            function(____, c)
                                __L1:R(
                                    c,
                                    __TS__Number(-__L1.AO),
                                    174,
                                    __L1.AW,
                                    46,
                                    "#5a555d"
                                )
                                __L1:R(
                                    c,
                                    __TS__Number(-__L1.AO),
                                    174,
                                    __L1.AW,
                                    3,
                                    "#c2987c"
                                )
                                do
                                    local x = __TS__Number(-__L1.AO)
                                    while x < __L1.AW - __L1.AO do
                                        __L1:R(
                                            c,
                                            x,
                                            177,
                                            1,
                                            43,
                                            "#8d7370"
                                        )
                                        x = x + 22
                                    end
                                end
                                __L1:arenaGround(
                                    c,
                                    "#77645e",
                                    "#685650",
                                    "#4d4e56",
                                    "#d7b38a",
                                    25.5
                                )
                                __L1:R(
                                    c,
                                    30,
                                    205,
                                    420,
                                    15,
                                    "#2a3a6a"
                                )
                                __L1:R(
                                    c,
                                    30,
                                    205,
                                    420,
                                    2,
                                    "#4a6aa8"
                                )
                                do
                                    local x = 30
                                    while x < 450 do
                                        __L1:R(
                                            c,
                                            x,
                                            208,
                                            7,
                                            8,
                                            __t(__mod(x, 28)) and "#24325a" or "#30427a"
                                        )
                                        x = x + 14
                                    end
                                end
                                for ____, x in __iterar((__arrL({30, 446}, 2))) do
                                    __L1:R(
                                        c,
                                        x,
                                        128,
                                        5,
                                        92,
                                        "#c8c8d0"
                                    )
                                    __L1:R(
                                        c,
                                        x,
                                        128,
                                        2,
                                        92,
                                        "#ffffff"
                                    )
                                    __L1:R(
                                        c,
                                        x - 2,
                                        126,
                                        9,
                                        4,
                                        "#a83a2a"
                                    )
                                end
                                for ____, ____value in __iterar((__arrL(
                                    {
                                        __arrL({140, "#e04a3a"}, 2),
                                        __arrL({156, "#f3f3f0"}, 2),
                                        __arrL({172, "#3a6ad8"}, 2)
                                    },
                                    3
                                ))) do
                                    local y = ____value[1]
                                    local col = ____value[2]
                                    __L1:R(
                                        c,
                                        35,
                                        y,
                                        411,
                                        2,
                                        col
                                    )
                                    __L1:R(
                                        c,
                                        35,
                                        y + 2,
                                        411,
                                        1,
                                        "rgba(0,0,0,.3)"
                                    )
                                end
                                __L1:speakerTower(c, 0)
                                __L1:speakerTower(c, 474)
                                __L1:board(
                                    c,
                                    122,
                                    75,
                                    236,
                                    23,
                                    "#77556b",
                                    "#3b4555"
                                )
                                __L1:board(
                                    c,
                                    176,
                                    154,
                                    128,
                                    9,
                                    "#263d49",
                                    "#14222a"
                                )
                                for ____, x in __iterar((__arrL({-60, 520}, 2))) do
                                    __L1:ell(
                                        c,
                                        x,
                                        160,
                                        12,
                                        6,
                                        "#d8dce0"
                                    )
                                    __L1:R(
                                        c,
                                        x - 1,
                                        160,
                                        2,
                                        14,
                                        "#8a96a0"
                                    )
                                end
                            end
                        },
                        3
                    )
                },
                3
            ),
            mid = function(self, c, s, t, ox)
                local mx = ox
                do
                    local k = 0
                    while k < 2 do
                        local y0 = 112 + k * 6
                        do
                            local i = 0
                            while i < 26 do
                                local x = __TS__Number(-__L1.AO) + i * 31 + mx
                                local wv = math.sin(t * 1.5 + i) * 1.5
                                __L1:R(
                                    c,
                                    x,
                                    y0 + math.floor(math.sin(i * 0.5) * 2 + 0.5),
                                    31,
                                    1,
                                    "#46505a"
                                )
                                if k == 0 then
                                    do
                                        local r2 = 0
                                        while r2 < 9 do
                                            __L1:R(
                                                c,
                                                x + 4 + r2 * 0.5 + wv * (r2 / 9),
                                                y0 + 2 + r2,
                                                12 - r2,
                                                1,
                                                __get(
                                                    __arrL({"#e3b887", "#8dc4bf", "#cb8e9f"}, 3),
                                                    __mod(i, 3)
                                                )
                                            )
                                            r2 = r2 + 1
                                        end
                                    end
                                else
                                    __L1:ell(
                                        c,
                                        x + 10,
                                        y0 + 3,
                                        1.5,
                                        2,
                                        __t(__mod(
                                            i + math.floor(t * 3),
                                            4
                                        )) and "#ffe1a0" or "#ffffff"
                                    )
                                end
                                i = i + 1
                            end
                        end
                        k = k + 1
                    end
                end
            end,
            text = function(self, c, t, ox)
                c:save()
                c:translate(ox * 2, 0)
                c.font = "16px Pixel, monospace"
                c.textAlign = "center"
                c.textBaseline = "middle"
                c.fillStyle = "#f5dca5"
                c:fillText("FREDDY · ÚLTIMO RECADO", 480, 173)
                c.font = "8px Pixel, monospace"
                c.fillStyle = "#e9ca9b"
                c:fillText("ÔÔÔ REEEIS, ASSISTE ESSA!", 480, 317)
                c:restore()
            end,
            light = function(self, g, s, t)
                __L1:bulbGlow(
                    g,
                    364,
                    92,
                    0.7,
                    "255,200,140",
                    90
                )
                do
                    local i = 0
                    while i < 26 do
                        __L1:bulbGlow(
                            g,
                            __TS__Number(-__L1.AO) + i * 31 + 10,
                            121,
                            0.25,
                            "255,220,150",
                            10
                        )
                        i = i + 1
                    end
                end
                __L1:pool(
                    g,
                    240,
                    214,
                    0.7,
                    "255,190,140",
                    140
                )
            end
        },
        "layers,mid,text,light"
    )
    __L1.ARENA.reeisBoss = __ord(
        {
            layers = __arrL(
                {
                    __arrL(
                        {
                            0.08,
                            "ree-sky",
                            function(____, c)
                                do
                                    local i = 0
                                    while i < 16 do
                                        __L1:R(
                                            c,
                                            __TS__Number(-__L1.AO),
                                            i * 10,
                                            __L1.AW,
                                            10,
                                            __L1:css(__L1:mix(
                                                __arrL({0.04, 0.07, 0.16}, 3),
                                                __arrL({0.16, 0.2, 0.34}, 3),
                                                i / 15
                                            ))
                                        )
                                        i = i + 1
                                    end
                                end
                                do
                                    local i = 0
                                    while i < 120 do
                                        __L1:R(
                                            c,
                                            __TS__Number(-__L1.AO) + __L1:hash(i + 601) * __L1.AW,
                                            __L1:hash(i + 602) * 120,
                                            1,
                                            1,
                                            __t(__mod(i, 5)) and "rgba(255,255,255,.7)" or "#ffe9b8"
                                        )
                                        i = i + 1
                                    end
                                end
                                do
                                    local k = 0
                                    while k < 6 do
                                        __L1:ell(
                                            c,
                                            90,
                                            48,
                                            30 - k * 3,
                                            30 - k * 3,
                                            ("rgba(220,230,255," .. tostring(0.04 + k * 0.02)) .. ")"
                                        )
                                        k = k + 1
                                    end
                                end
                                __L1:ell(
                                    c,
                                    90,
                                    48,
                                    13,
                                    13,
                                    "#f4f6ff"
                                )
                                __L1:R(
                                    c,
                                    84,
                                    44,
                                    4,
                                    4,
                                    "#d8deef"
                                )
                                __L1:R(
                                    c,
                                    92,
                                    52,
                                    5,
                                    3,
                                    "#d8deef"
                                )
                                __L1:hillLights(
                                    c,
                                    150,
                                    76,
                                    5.1,
                                    "#121a28",
                                    1300
                                )
                            end
                        },
                        3
                    ),
                    __arrL(
                        {
                            0.4,
                            "ree-fav",
                            function(____, c) return __L1:favRow(
                                c,
                                178,
                                32,
                                28,
                                74,
                                0.5,
                                0.55,
                                50,
                                true
                            ) end
                        },
                        3
                    ),
                    __arrL(
                        {
                            1,
                            "ree-plaza",
                            function(____, c)
                                __L1:R(
                                    c,
                                    __TS__Number(-__L1.AO),
                                    166,
                                    __L1.AW,
                                    54,
                                    "#765449"
                                )
                                __L1:R(
                                    c,
                                    __TS__Number(-__L1.AO),
                                    164,
                                    __L1.AW,
                                    6,
                                    "#c7a97a"
                                )
                                do
                                    local y = 172
                                    while y < 220 do
                                        do
                                            local x = __TS__Number(-__L1.AO) + __band(y / 8, 1) * 11
                                            while x < __L1.AW - __L1.AO do
                                                __L1:R(
                                                    c,
                                                    x,
                                                    y,
                                                    21,
                                                    7,
                                                    "#86604f"
                                                )
                                                __L1:R(
                                                    c,
                                                    x,
                                                    y,
                                                    21,
                                                    1,
                                                    "#9a705c"
                                                )
                                                x = x + 22
                                            end
                                        end
                                        y = y + 8
                                    end
                                end
                                __L1:arenaGround(
                                    c,
                                    "#746a60",
                                    "#665c54",
                                    "#514f4e",
                                    "#d4be8b",
                                    32
                                )
                                do
                                    local y = 170
                                    while y < 220 do
                                        local w = 36 + (y - 170) * 1.2
                                        __L1:R(
                                            c,
                                            240 - w / 2,
                                            y,
                                            w,
                                            1,
                                            __t(__mod(y, 4)) and "#a83a3a" or "#b84a44"
                                        )
                                        y = y + 1
                                    end
                                end
                                __L1:R(
                                    c,
                                    202,
                                    116,
                                    76,
                                    54,
                                    "#243d49"
                                )
                                __L1:R(
                                    c,
                                    206,
                                    120,
                                    68,
                                    46,
                                    "#587a6b"
                                )
                                __L1:R(
                                    c,
                                    210,
                                    123,
                                    60,
                                    40,
                                    "#718e6d"
                                )
                                __L1:R(
                                    c,
                                    210,
                                    123,
                                    60,
                                    2,
                                    "#8eae88"
                                )
                                __L1:R(
                                    c,
                                    201,
                                    152,
                                    78,
                                    9,
                                    "#a48c58"
                                )
                                __L1:R(
                                    c,
                                    201,
                                    152,
                                    78,
                                    2,
                                    "#e8cf88"
                                )
                                do
                                    local i = 0
                                    while i < 5 do
                                        local x = 209 + i * 13
                                        do
                                            local k = 0
                                            while k < 12 - __mod(i, 2) * 4 do
                                                __L1:R(
                                                    c,
                                                    x + k * 0.25,
                                                    120 - k,
                                                    7 - k * 0.5,
                                                    1,
                                                    "#d1b76f"
                                                )
                                                k = k + 1
                                            end
                                        end
                                        __L1:ell(
                                            c,
                                            x + 3,
                                            108 + __mod(i, 2) * 4,
                                            1.5,
                                            1.5,
                                            __t(__mod(i, 2)) and "#3ad0c0" or "#e04a3a"
                                        )
                                        i = i + 1
                                    end
                                end
                                for ____, x in __iterar((__arrL({196, 276}, 2))) do
                                    __L1:R(
                                        c,
                                        x,
                                        136,
                                        9,
                                        34,
                                        "#a48c58"
                                    )
                                    __L1:R(
                                        c,
                                        x,
                                        136,
                                        9,
                                        2,
                                        "#e8cf88"
                                    )
                                end
                                __L1:R(
                                    c,
                                    194,
                                    166,
                                    92,
                                    8,
                                    "#5a4436"
                                )
                                __L1:R(
                                    c,
                                    194,
                                    166,
                                    92,
                                    2,
                                    "#a48c58"
                                )
                                __L1:speakerTower(c, 25)
                                __L1:speakerTower(c, 450)
                                __L1:board(
                                    c,
                                    138,
                                    43,
                                    206,
                                    39,
                                    "#286577",
                                    "#153c54"
                                )
                            end
                        },
                        3
                    )
                },
                3
            ),
            mid = function(self, c, s, t, ox)
                local mx = ox
                do
                    local i = 0
                    while i < 16 do
                        local x = 65 + i * 23.5 + mx
                        local y = 92 + math.floor(math.sin(i) * 6 + 0.5)
                        local wv = math.sin(t * 1.4 + i) * 1.5
                        __L1:R(
                            c,
                            x,
                            y,
                            23,
                            1,
                            "#293f4b"
                        )
                        do
                            local r2 = 0
                            while r2 < 11 do
                                __L1:R(
                                    c,
                                    x + 1 + r2 * 0.5 + wv * (r2 / 11),
                                    y + 1 + r2,
                                    11 - r2,
                                    1,
                                    __t(__mod(i, 2)) and "#7fc6c6" or "#d8bd78"
                                )
                                r2 = r2 + 1
                            end
                        end
                        i = i + 1
                    end
                end
            end,
            text = function(self, c, t, ox)
                c:save()
                c:translate(ox * 2, 0)
                c.font = "16px Pixel, monospace"
                c.textAlign = "center"
                c.textBaseline = "middle"
                c.fillStyle = "#dfc372"
                c:fillText("O TRONO DO MORRO", 482, 116)
                c.font = "8px Pixel, monospace"
                c.fillStyle = "#a4e2d6"
                c:fillText("GABRIEL REEIS · RESPEITA O REI", 482, 144)
                c:restore()
            end,
            light = function(self, g, s, t)
                local p = 0.8 + 0.2 * math.sin(t * 2)
                local gr = g:createLinearGradient(0, 0, 0, 175)
                gr:addColorStop(0, "rgba(255,214,120,.28)")
                gr:addColorStop(1, "rgba(255,214,120,.04)")
                g.fillStyle = gr
                g:beginPath()
                g:moveTo(232, 0)
                g:lineTo(248, 0)
                g:lineTo(290, 175)
                g:lineTo(190, 175)
                g:closePath()
                __call(g, "fill")
                __L1:pool(
                    g,
                    240,
                    172,
                    p,
                    "255,214,120",
                    70
                )
                __L1:bulbGlow(
                    g,
                    241,
                    82,
                    0.5,
                    "120,220,210",
                    50
                )
                for ____, x in __iterar((__arrL({25, 450}, 2))) do
                    do
                        local j = 0
                        while j < 4 do
                            __L1:bulbGlow(
                                g,
                                x - 7 + j * 6,
                                68,
                                0.5,
                                "255,214,150",
                                10
                            )
                            j = j + 1
                        end
                    end
                end
            end
        },
        "layers,mid,text,light"
    )
    __L1.ARENA.giant = __ord(
        {
            layers = __arrL(
                {
                    __arrL(
                        {
                            0.08,
                            "gia-sky",
                            function(____, c)
                                do
                                    local i = 0
                                    while i < 16 do
                                        __L1:R(
                                            c,
                                            __TS__Number(-__L1.AO),
                                            i * 12,
                                            __L1.AW,
                                            12,
                                            __L1:css(__L1:mix(
                                                __arrL({0.06, 0.05, 0.13}, 3),
                                                __arrL({0.2, 0.16, 0.32}, 3),
                                                i / 15
                                            ))
                                        )
                                        i = i + 1
                                    end
                                end
                                do
                                    local i = 0
                                    while i < 70 do
                                        __L1:R(
                                            c,
                                            __TS__Number(-__L1.AO) + __L1:hash(i + 701) * __L1.AW,
                                            __L1:hash(i + 702) * 170,
                                            1,
                                            1,
                                            __t(__mod(i, 3)) and "#5a4a80" or "#b8a8e0"
                                        )
                                        i = i + 1
                                    end
                                end
                                for ____, ____value in __iterar((__arrL(
                                    {
                                        __arrL({
                                            -80,
                                            120,
                                            150,
                                            0.2,
                                            "#3a3256"
                                        }, 5),
                                        __arrL({
                                            130,
                                            160,
                                            120,
                                            -0.1,
                                            "#43395f"
                                        }, 5),
                                        __arrL({
                                            380,
                                            140,
                                            160,
                                            0.15,
                                            "#3a3256"
                                        }, 5)
                                    },
                                    3
                                ))) do
                                    local x = ____value[1]
                                    local w = ____value[2]
                                    local h = ____value[3]
                                    local tilt = ____value[4]
                                    local col = ____value[5]
                                    do
                                        local r2 = 0
                                        while __lt(r2, h) do
                                            __L1:R(
                                                c,
                                                x + r2 * tilt,
                                                190 - r2,
                                                w,
                                                1,
                                                col
                                            )
                                            r2 = r2 + 1
                                        end
                                    end
                                    do
                                        local j = 0
                                        while __lt(j, h) do
                                            __L1:R(
                                                c,
                                                x + j * tilt + 8,
                                                190 - j,
                                                w - 16,
                                                1,
                                                "rgba(160,140,200,.25)"
                                            )
                                            j = j + 9
                                        end
                                    end
                                    __L1:R(
                                        c,
                                        x + 10,
                                        190 - h,
                                        1,
                                        h,
                                        "rgba(220,120,160,.3)"
                                    )
                                end
                            end
                        },
                        3
                    ),
                    __arrL(
                        {
                            0.35,
                            "gia-pages",
                            function(____, c)
                                do
                                    local i = 0
                                    while i < 9 do
                                        local x = -40 + i * 64
                                        local y = 16 + __mod(i, 3) * 8
                                        do
                                            local r2 = 0
                                            while r2 < 70 do
                                                local ____temp_309
                                                if r2 > 64 then
                                                    ____temp_309 = __mod(r2 + i, 2) * 2
                                                else
                                                    ____temp_309 = 0
                                                end
                                                local edge = ____temp_309
                                                __L1:R(
                                                    c,
                                                    x + edge,
                                                    y + r2,
                                                    40 - edge * 2,
                                                    1,
                                                    "#9b86ad"
                                                )
                                                r2 = r2 + 1
                                            end
                                        end
                                        __L1:R(
                                            c,
                                            x,
                                            y,
                                            1,
                                            70,
                                            "rgba(255,255,255,.2)"
                                        )
                                        do
                                            local j = 0
                                            while j < 5 do
                                                __L1:R(
                                                    c,
                                                    x + 6,
                                                    y + 12 + j * 10,
                                                    28,
                                                    1,
                                                    "#655476"
                                                )
                                                j = j + 1
                                            end
                                        end
                                        i = i + 1
                                    end
                                end
                            end
                        },
                        3
                    ),
                    __arrL(
                        {
                            1,
                            "gia-near",
                            function(____, c)
                                __L1:R(
                                    c,
                                    __TS__Number(-__L1.AO),
                                    140,
                                    __L1.AW,
                                    80,
                                    "#2a2244"
                                )
                                do
                                    local i = 0
                                    while i < 300 do
                                        __L1:R(
                                            c,
                                            __TS__Number(-__L1.AO) + __L1:hash(i + 801) * __L1.AW,
                                            142 + __L1:hash(i + 802) * 76,
                                            2,
                                            1,
                                            __t(__mod(i, 2)) and "#352c54" or "#221c3a"
                                        )
                                        i = i + 1
                                    end
                                end
                                for ____, ____value in __iterar((__arrL(
                                    {
                                        __arrL({85, 238, "#c6b1cb", 1}, 4),
                                        __arrL({241, 395, "#e1cbd9", -1}, 4)
                                    },
                                    2
                                ))) do
                                    local x0 = ____value[1]
                                    local x1 = ____value[2]
                                    local col = ____value[3]
                                    local sd = ____value[4]
                                    do
                                        local x = x0
                                        while __lt(x, x1) do
                                            local k = (x - x0) / (x1 - x0)
                                            local ____gt_result_310
                                            if __gt(sd, 0) then
                                                ____gt_result_310 = 115 + math.floor(k * 17 + 0.5)
                                            else
                                                ____gt_result_310 = 132 - math.floor(k * 19 + 0.5)
                                            end
                                            local top = ____gt_result_310
                                            local ____gt_result_311
                                            if __gt(sd, 0) then
                                                ____gt_result_311 = 188 + math.floor(k * 20 + 0.5)
                                            else
                                                ____gt_result_311 = 208 - math.floor(k * 20 + 0.5)
                                            end
                                            local bot = ____gt_result_311
                                            __L1:R(
                                                c,
                                                x,
                                                top,
                                                1,
                                                bot - top,
                                                col
                                            )
                                            __L1:R(
                                                c,
                                                x,
                                                bot,
                                                1,
                                                3,
                                                "rgba(0,0,0,.35)"
                                            )
                                            x = x + 1
                                        end
                                    end
                                end
                                for ____, ____value in __iterar((__arrL(
                                    {
                                        __arrL({100, 1}, 2),
                                        __arrL({262, -1}, 2)
                                    },
                                    2
                                ))) do
                                    local x0 = ____value[1]
                                    local sd = ____value[2]
                                    do
                                        local j = 0
                                        while j < 7 do
                                            do
                                                local x = 0
                                                while x < 120 do
                                                    local k = x / 120
                                                    local ____temp_312
                                                    if sd > 0 then
                                                        ____temp_312 = 129 + math.floor(k * 14 + 0.5)
                                                    else
                                                        ____temp_312 = 145 - math.floor(k * 15 + 0.5)
                                                    end
                                                    local yy = ____temp_312 + j * 8
                                                    __L1:R(
                                                        c,
                                                        x0 + x,
                                                        yy,
                                                        2,
                                                        1,
                                                        sd > 0 and "#9a7ca9" or "#ae8dac"
                                                    )
                                                    x = x + 2
                                                end
                                            end
                                            j = j + 1
                                        end
                                    end
                                end
                                __L1:R(
                                    c,
                                    237,
                                    131,
                                    4,
                                    79,
                                    "#695578"
                                )
                                __L1:arenaGround(
                                    c,
                                    "#564669",
                                    "#4a3c5c",
                                    "#332f49",
                                    "#dec6d7",
                                    25.5
                                )
                                __L1:board(
                                    c,
                                    150,
                                    40,
                                    185,
                                    22,
                                    "#473652",
                                    "#2a2040"
                                )
                            end
                        },
                        3
                    )
                },
                3
            ),
            mid = function(self, c, s, t, ox)
                local nx = ox
                do
                    local i = 0
                    while i < 2 do
                        if __mod(t * 0.6 + i * 0.5, 3) < 0.12 then
                            local x = 80 + i * 300 + math.floor(ox * 0.08 + 0.5)
                            local y = 0
                            while y < 120 do
                                local nx2 = x + (__L1:hash(y + i + math.floor(t)) - 0.5) * 30
                                __L1:limb(
                                    c,
                                    __arrL(
                                        {
                                            __arrL({x, y}, 2),
                                            __arrL({nx2, y + 14}, 2)
                                        },
                                        2
                                    ),
                                    2,
                                    "#e8c0ff"
                                )
                                x = nx2
                                y = y + 14
                            end
                        end
                        i = i + 1
                    end
                end
            end,
            near = function(self, c, s, t, ox)
                do
                    local i = 0
                    while i < 13 do
                        local x = 25 + i * 37 + ox
                        local h = 22 + math.sin(t * 2 + i) * 6
                        do
                            local k = 0
                            while k < h do
                                __L1:R(
                                    c,
                                    x - (h - k) * 0.25,
                                    220 - k,
                                    (h - k) * 0.5 + 1,
                                    1,
                                    "#333049"
                                )
                                k = k + 1
                            end
                        end
                        __L1:R(
                            c,
                            x,
                            220 - h,
                            1,
                            3,
                            "#8a76b0"
                        )
                        i = i + 1
                    end
                end
            end,
            text = function(self, c, t, ox)
                c:save()
                c:translate(ox * 2, 0)
                c.font = "16px Pixel, monospace"
                c.textAlign = "center"
                c.textBaseline = "middle"
                c.fillStyle = "#f0cddd"
                c:fillText("O RABISCO COLOSSAL", 485, 102)
                c:restore()
            end,
            light = function(self, g, s, t)
                __L1:bulbGlow(
                    g,
                    240,
                    160,
                    0.5 + 0.1 * math.sin(t * 3),
                    "200,120,255",
                    120
                )
            end
        },
        "layers,mid,near,text,light"
    )
    __L1.ROOM_WIN = __arrL(
        {
            __ord({
                x = 74,
                y = 38,
                w = 58,
                h = 58,
                open = 22
            }, "x,y,w,h,open"),
            __ord({
                x = 348,
                y = 38,
                w = 58,
                h = 58,
                open = 22
            }, "x,y,w,h,open")
        },
        2
    )
    __L1.roomLayers = {}
    __L1.RSKIN = __arrL({"#edc5a0", "#9a6546", "#c18b60", "#e7b994"}, 4)
    __L1.RHAIR = __arrL({"#3d362d", "#705239", "#2d3330", "#b3945b"}, 4)
    __L1.ARENA_TYPES = __arrL({
        "arthur",
        "marco",
        "menezes",
        "nikolas",
        "dede",
        "nicolas",
        "freddy",
        "reeisBoss",
        "giant"
    }, 9)
    __L1.arenaHandles = function(____, ____type)
        local ____temp_316
        if type(____type) == "table" then
            local ____opt_result_315
            if ____type ~= nil then
                ____opt_result_315 = ____type.type
            end
            ____temp_316 = ____opt_result_315
        else
            ____temp_316 = ____type
        end
        ____type = ____temp_316
        local ____t_result_327
        local ____t_326 = __t
        local ____t_result_325
        local ____t_318 = __t
        local ____call_result_317 = __call(__L1.ARENA_TYPES, "includes", ____type)
        __O[320] = ____call_result_317
        if ____t_318(____call_result_317) then
            local ____t_324 = __t
            local ____opt_321 = window.Graphics
            if ____opt_321 ~= nil then
                ____opt_321 = ____opt_321.isLite
            end
            local ____opt_result_323
            if ____opt_321 ~= nil then
                ____opt_result_323 = ____opt_321(____opt_321)
            end
            ____t_result_325 = not ____t_324(____opt_result_323)
        else
            ____t_result_325 = __O[320]
        end
        __O[321] = ____t_result_325
        if ____t_326(____t_result_325) then
            ____t_result_327 = not not __t(window.DayTime)
        else
            ____t_result_327 = __O[321]
        end
        return ____t_result_327
    end
    __L1.MAPS = {
        ["0"] = __ord({draw = __L1.farm, text = __L1.farmText, lights = __L1.farmLights}, "draw,text,lights"),
        ["2"] = __ord({draw = __L1.gym, text = __L1.gymText, lights = __L1.gymLights, amb = __L1.gymAmb}, "draw,text,lights,amb"),
        ["3"] = __ord({draw = __L1.court, text = __L1.courtText, lights = __L1.courtLights}, "draw,text,lights"),
        ["7"] = __ord({draw = __L1.field, text = __L1.fieldText, lights = __L1.fieldLights}, "draw,text,lights"),
        ["5"] = __ord({draw = __L1.favela, text = __L1.favelaText, lights = __L1.favelaLights}, "draw,text,lights"),
        ["9"] = __ord({draw = __L1.patio, text = __L1.patioText, lights = __L1.patioLights}, "draw,text,lights"),
        ["1"] = __ord({draw = __L1.school, text = __L1.schoolText, lights = __L1.schoolLights}, "draw,text,lights"),
        ["4"] = __ord({draw = __L1.plaza, text = __L1.plazaText, lights = __L1.plazaLights}, "draw,text,lights"),
        ["6"] = __ord(
            {
                draw = __L1.ink,
                text = __L1.inkText,
                lights = __L1.inkLights,
                amb = function() return __arrL({1, 1, 1}, 3) end
            },
            "draw,text,lights,amb"
        ),
        ["8"] = __ord(
            {
                draw = __L1.bigodon,
                text = __L1.bigodonText,
                lights = __L1.bigodonLights,
                amb = __L1:roomAmb(0.62)
            },
            "draw,text,lights,amb"
        ),
        ["10"] = __ord(
            {
                draw = __L1.rayssa,
                text = __L1.rayssaText,
                lights = __L1.rayssaLights,
                amb = __L1:roomAmb(0.6)
            },
            "draw,text,lights,amb"
        )
    }
    __L1.handles = function(____, scene)
        local ____t_result_341
        local ____t_340 = __t
        local ____t_result_339
        local ____t_329 = __t
        local ____temp_328 = not not __t(__get(__L1.MAPS, scene))
        __O[323] = ____temp_328
        if ____t_329(____temp_328) then
            local ____t_result_338
            local ____t_331 = __t
            local ____get_result_always_330 = __get(__L1.MAPS, scene).always
            __O[322] = ____get_result_always_330
            if ____t_331(____get_result_always_330) then
                ____t_result_338 = __O[322]
            else
                local ____t_337 = __t
                local ____opt_334 = window.Graphics
                if ____opt_334 ~= nil then
                    ____opt_334 = ____opt_334.isLite
                end
                local ____opt_result_336
                if ____opt_334 ~= nil then
                    ____opt_result_336 = ____opt_334(____opt_334)
                end
                ____t_result_338 = not ____t_337(____opt_result_336)
            end
            ____t_result_339 = ____t_result_338
        else
            ____t_result_339 = __O[323]
        end
        __O[324] = ____t_result_339
        if ____t_340(____t_result_339) then
            ____t_result_341 = not not __t(window.DayTime)
        else
            ____t_result_341 = __O[324]
        end
        return ____t_result_341
    end
    __L1.kit = __ord(
        {
            LW = __L1.LW,
            LH = __L1.LH,
            FLOOR = __L1.FLOOR,
            R = __L1.R,
            ell = __L1.ell,
            mk = __L1.mk,
            hash = __L1.hash,
            cl = __L1.cl,
            css = __L1.css,
            mix = __L1.mix,
            dither = __L1.dither,
            limb = __L1.limb,
            sky = function(____, c, s, t, camL, arc) return __L1:sky(
                c,
                s,
                t,
                camL,
                arc
            ) end,
            haze = __L1.haze,
            tile = __L1.tile,
            tree = __L1.tree,
            bush = __L1.bush,
            fence = __L1.fence,
            slant = __L1.slant,
            sunInfo = __L1.sunInfo,
            sunWall = __L1.sunWall,
            board = __L1.board,
            win = __L1.win,
            bench = __L1.bench,
            lampPost = __L1.lampPost,
            lampGlow = __L1.lampGlow,
            paving = __L1.paving,
            city = __L1.city,
            buildFar = function()
                local ____t_result_343
                if __t(__L1.far) then
                    ____t_result_343 = __L1.far
                else
                    local ____temp_342 = __L1:buildFar()
                    __L1.far = ____temp_342
                    ____t_result_343 = ____temp_342
                end
                return ____t_result_343
            end,
            shadeAdd = function(____, a, b, k, l) return __L1:shadeAdd(a, b, k, l) end,
            lightAdd = function(____, x, top, a, reach) return __L1:lightAdd(x, top, a, reach) end
        },
        "LW,LH,FLOOR,R,ell,mk,hash,cl,css,mix,dither,limb,sky,haze,tile,tree,bush,fence,slant,sunInfo,sunWall,board,win,bench,lampPost,lampGlow,paving,city,buildFar,shadeAdd,lightAdd"
    )
    __L1.lastCam = 0
    __L1.lastT = 0
    __L1.CAMS = __ord(
        {
            M = 96,
            cv = nil,
            g = nil,
            luz = nil,
            lg = nil,
            ceu = nil,
            ceuG = nil,
            nevoas = __arrL({}, 0)
        },
        "M,cv,g,luz,lg,ceu,ceuG,nevoas"
    )
    __L1.podeCamadas = function(____, scene)
        local ____t_result_346
        local ____t_345 = __t
        local ____temp_344 = not not __t(__get(__L1.MAPS, scene)) and not __t(__get(__L1.MAPS, scene).always)
        __O[327] = ____temp_344
        if ____t_345(____temp_344) then
            ____t_result_346 = not not __t(window.DayTime)
        else
            ____t_result_346 = __O[327]
        end
        return ____t_result_346
    end
    __L1.ambienteDe = function(____, scene)
        do
            local function ____catch(e)
                return true, __arrL({1, 1, 1}, 3)
            end
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                local s = window.DayTime:state()
                local ____t_result_347
                if __t(__get(__L1.MAPS, scene).amb) then
                    ____t_result_347 = __get(__L1.MAPS, scene):amb(s)
                else
                    ____t_result_347 = s.amb
                end
                local a = ____t_result_347
                return true, __arrL(
                    {
                        __L1:cl(__get(a, 0)),
                        __L1:cl(__get(a, 1)),
                        __L1:cl(__get(a, 2))
                    },
                    3
                )
            end)
            if not ____try then
                ____hasReturned, ____returnValue = ____catch(____hasReturned)
            end
            if ____hasReturned then
                return ____returnValue
            end
        end
    end
    __L1.camadas = __ord(
        {
            pode = function(____, scene) return __L1:podeCamadas(__TS__Number(scene)) end,
            desenhar = __L1.desenharCamadas,
            margem = function() return __L1.CAMS.M end,
            texto = function(____, c, scene, camera)
                do
                    pcall(function()
                        local ____opt_354 = __get(
                            __L1.MAPS,
                            __TS__Number(scene)
                        )
                        if ____opt_354 ~= nil then
                            ____opt_354 = ____opt_354.text
                        end
                        if ____opt_354 ~= nil then
                            local ____c_352 = c
                            local ____t_result_351
                            local ____t_350 = __t
                            local ____TS__Number_result_349 = __TS__Number(camera)
                            __O[334] = ____TS__Number_result_349
                            if ____t_350(____TS__Number_result_349) then
                                ____t_result_351 = __O[334]
                            else
                                ____t_result_351 = 0
                            end
                            ____opt_354(____opt_354, ____c_352, ____t_result_351)
                        end
                    end)
                end
            end,
            ambiente = function(____, scene) return __L1:ambienteDe(__TS__Number(scene)) end,
            multiplicar = __L1.multiplicar
        },
        "pode,desenhar,margem,texto,ambiente,multiplicar"
    )
    window.HdMaps = __ord(
        {
            camadas = __L1.camadas,
            register = __L1.register,
            kit = __L1.kit,
            leaves = function() return {
                caindo = __len(__L1.LEAVES),
                balancando = __L1.RUSTLE.size
            } end,
            touch = function(____, scene, x, y, vx, vy)
                do
                    pcall(function()
                        local ____L1_touch_369 = __L1.touch
                        local ____TS__Number_result_368 = __TS__Number(scene)
                        local ____t_result_358
                        local ____t_357 = __t
                        local ____TS__Number_result_356 = __TS__Number(x)
                        __O[335] = ____TS__Number_result_356
                        if ____t_357(____TS__Number_result_356) then
                            ____t_result_358 = __O[335]
                        else
                            ____t_result_358 = 0
                        end
                        local ____t_result_361
                        local ____t_360 = __t
                        local ____TS__Number_result_359 = __TS__Number(y)
                        __O[336] = ____TS__Number_result_359
                        if ____t_360(____TS__Number_result_359) then
                            ____t_result_361 = __O[336]
                        else
                            ____t_result_361 = 0
                        end
                        local ____t_result_364
                        local ____t_363 = __t
                        local ____TS__Number_result_362 = __TS__Number(vx)
                        __O[337] = ____TS__Number_result_362
                        if ____t_363(____TS__Number_result_362) then
                            ____t_result_364 = __O[337]
                        else
                            ____t_result_364 = 0
                        end
                        local ____t_result_367
                        local ____t_366 = __t
                        local ____TS__Number_result_365 = __TS__Number(vy)
                        __O[338] = ____TS__Number_result_365
                        if ____t_366(____TS__Number_result_365) then
                            ____t_result_367 = __O[338]
                        else
                            ____t_result_367 = 0
                        end
                        ____L1_touch_369(
                            __L1,
                            ____TS__Number_result_368,
                            ____t_result_358,
                            ____t_result_361,
                            ____t_result_364,
                            ____t_result_367
                        )
                    end)
                end
            end,
            lightsAt = function(____, scene, x)
                do
                    local function ____catch(e)
                        return true, __arrL({}, 0)
                    end
                    local ____try, ____hasReturned, ____returnValue = pcall(function()
                        local ____L1_lightsAt_374 = __L1.lightsAt
                        local ____TS__Number_result_373 = __TS__Number(scene)
                        local ____t_result_372
                        local ____t_371 = __t
                        local ____TS__Number_result_370 = __TS__Number(x)
                        __O[339] = ____TS__Number_result_370
                        if ____t_371(____TS__Number_result_370) then
                            ____t_result_372 = __O[339]
                        else
                            ____t_result_372 = 0
                        end
                        return true, ____L1_lightsAt_374(__L1, ____TS__Number_result_373, ____t_result_372)
                    end)
                    if not ____try then
                        ____hasReturned, ____returnValue = ____catch(____hasReturned)
                    end
                    if ____hasReturned then
                        return ____returnValue
                    end
                end
            end,
            shadeAt = function(____, scene, x)
                do
                    local function ____catch(e)
                        return true, {k = 0, leaves = false}
                    end
                    local ____try, ____hasReturned, ____returnValue = pcall(function()
                        local ____L1_shadeAt_379 = __L1.shadeAt
                        local ____TS__Number_result_378 = __TS__Number(scene)
                        local ____t_result_377
                        local ____t_376 = __t
                        local ____TS__Number_result_375 = __TS__Number(x)
                        __O[340] = ____TS__Number_result_375
                        if ____t_376(____TS__Number_result_375) then
                            ____t_result_377 = __O[340]
                        else
                            ____t_result_377 = 0
                        end
                        return true, ____L1_shadeAt_379(__L1, ____TS__Number_result_378, ____t_result_377)
                    end)
                    if not ____try then
                        ____hasReturned, ____returnValue = ____catch(____hasReturned)
                    end
                    if ____hasReturned then
                        return ____returnValue
                    end
                end
            end,
            sun = function()
                do
                    local function ____catch(e)
                        return true, {lean = 0, str = 0}
                    end
                    local ____try, ____hasReturned, ____returnValue = pcall(function()
                        return true, __L1:sunInfo(window.DayTime:state())
                    end)
                    if not ____try then
                        ____hasReturned, ____returnValue = ____catch(____hasReturned)
                    end
                    if ____hasReturned then
                        return ____returnValue
                    end
                end
            end,
            drawRoom = function(____, c, id, t)
                do
                    local function ____catch(e)
                        window.__hdMapsError = e
                        return true, false
                    end
                    local ____try, ____hasReturned, ____returnValue = pcall(function()
                        local ____L1_drawRoom_385 = __L1.drawRoom
                        local ____c_383 = c
                        local ____id_384 = id
                        local ____t_result_382
                        local ____t_381 = __t
                        local ____TS__Number_result_380 = __TS__Number(t)
                        __O[341] = ____TS__Number_result_380
                        if ____t_381(____TS__Number_result_380) then
                            ____t_result_382 = __O[341]
                        else
                            ____t_result_382 = 0
                        end
                        return true, ____L1_drawRoom_385(__L1, ____c_383, ____id_384, ____t_result_382)
                    end)
                    if not ____try then
                        ____hasReturned, ____returnValue = ____catch(____hasReturned)
                    end
                    if ____hasReturned then
                        return ____returnValue
                    end
                end
            end,
            arenaHandles = __L1.arenaHandles,
            drawArena = function(____, c, ____type, camera, t, homeX)
                do
                    local function ____catch(e)
                        window.__hdMapsError = e
                        return true, false
                    end
                    local ____try, ____hasReturned, ____returnValue = pcall(function()
                        local ____L1_drawArena_397 = __L1.drawArena
                        local ____c_395 = c
                        local ____type_396 = ____type
                        local ____t_result_388
                        local ____t_387 = __t
                        local ____TS__Number_result_386 = __TS__Number(camera)
                        __O[342] = ____TS__Number_result_386
                        if ____t_387(____TS__Number_result_386) then
                            ____t_result_388 = __O[342]
                        else
                            ____t_result_388 = 0
                        end
                        local ____t_result_391
                        local ____t_390 = __t
                        local ____TS__Number_result_389 = __TS__Number(t)
                        __O[343] = ____TS__Number_result_389
                        if ____t_390(____TS__Number_result_389) then
                            ____t_result_391 = __O[343]
                        else
                            ____t_result_391 = 0
                        end
                        local ____t_result_394
                        local ____t_393 = __t
                        local ____TS__Number_result_392 = __TS__Number(homeX)
                        __O[344] = ____TS__Number_result_392
                        if ____t_393(____TS__Number_result_392) then
                            ____t_result_394 = __O[344]
                        else
                            ____t_result_394 = 0
                        end
                        ____L1_drawArena_397(
                            __L1,
                            ____c_395,
                            ____type_396,
                            ____t_result_388,
                            ____t_result_391,
                            ____t_result_394
                        )
                        return true, true
                    end)
                    if not ____try then
                        ____hasReturned, ____returnValue = ____catch(____hasReturned)
                    end
                    if ____hasReturned then
                        return ____returnValue
                    end
                end
            end,
            arenaFront = function(____, c, ____type, camera, t, homeX, blend)
                do
                    local function ____catch(e)
                        window.__hdMapsError = e
                    end
                    local ____try, ____hasReturned = pcall(function()
                        local ____L1_arenaFront_409 = __L1.arenaFront
                        local ____c_407 = c
                        local ____type_408 = ____type
                        local ____t_result_400
                        local ____t_399 = __t
                        local ____TS__Number_result_398 = __TS__Number(camera)
                        __O[345] = ____TS__Number_result_398
                        if ____t_399(____TS__Number_result_398) then
                            ____t_result_400 = __O[345]
                        else
                            ____t_result_400 = 0
                        end
                        local ____t_result_403
                        local ____t_402 = __t
                        local ____TS__Number_result_401 = __TS__Number(t)
                        __O[346] = ____TS__Number_result_401
                        if ____t_402(____TS__Number_result_401) then
                            ____t_result_403 = __O[346]
                        else
                            ____t_result_403 = 0
                        end
                        local ____t_result_406
                        local ____t_405 = __t
                        local ____TS__Number_result_404 = __TS__Number(homeX)
                        __O[347] = ____TS__Number_result_404
                        if ____t_405(____TS__Number_result_404) then
                            ____t_result_406 = __O[347]
                        else
                            ____t_result_406 = 0
                        end
                        ____L1_arenaFront_409(
                            __L1,
                            ____c_407,
                            ____type_408,
                            ____t_result_400,
                            ____t_result_403,
                            ____t_result_406,
                            blend
                        )
                    end)
                    if not ____try then
                        ____catch(____hasReturned)
                    end
                end
            end,
            handles = __L1.handles,
            darkness = function(____, c, scene, camera, t, hx, hy, facing)
                do
                    pcall(function()
                        local ____L1_darkness_424 = __L1.darkness
                        local ____c_422 = c
                        local ____TS__Number_result_423 = __TS__Number(scene)
                        local ____t_result_412
                        local ____t_411 = __t
                        local ____TS__Number_result_410 = __TS__Number(camera)
                        __O[348] = ____TS__Number_result_410
                        if ____t_411(____TS__Number_result_410) then
                            ____t_result_412 = __O[348]
                        else
                            ____t_result_412 = 0
                        end
                        local ____t_result_415
                        local ____t_414 = __t
                        local ____TS__Number_result_413 = __TS__Number(t)
                        __O[349] = ____TS__Number_result_413
                        if ____t_414(____TS__Number_result_413) then
                            ____t_result_415 = __O[349]
                        else
                            ____t_result_415 = 0
                        end
                        local ____t_result_418
                        local ____t_417 = __t
                        local ____TS__Number_result_416 = __TS__Number(hx)
                        __O[350] = ____TS__Number_result_416
                        if ____t_417(____TS__Number_result_416) then
                            ____t_result_418 = __O[350]
                        else
                            ____t_result_418 = 0
                        end
                        local ____t_result_421
                        local ____t_420 = __t
                        local ____TS__Number_result_419 = __TS__Number(hy)
                        __O[351] = ____TS__Number_result_419
                        if ____t_420(____TS__Number_result_419) then
                            ____t_result_421 = __O[351]
                        else
                            ____t_result_421 = 0
                        end
                        ____L1_darkness_424(
                            __L1,
                            ____c_422,
                            ____TS__Number_result_423,
                            ____t_result_412,
                            ____t_result_415,
                            ____t_result_418,
                            ____t_result_421,
                            facing
                        )
                    end)
                end
            end,
            draw = function(____, c, scene, camera, t)
                do
                    local function ____catch(e)
                        window.__hdMapsError = e
                        return true, false
                    end
                    local ____try, ____hasReturned, ____returnValue = pcall(function()
                        local ____L1_draw_433 = __L1.draw
                        local ____c_431 = c
                        local ____TS__Number_result_432 = __TS__Number(scene)
                        local ____t_result_427
                        local ____t_426 = __t
                        local ____TS__Number_result_425 = __TS__Number(camera)
                        __O[352] = ____TS__Number_result_425
                        if ____t_426(____TS__Number_result_425) then
                            ____t_result_427 = __O[352]
                        else
                            ____t_result_427 = 0
                        end
                        local ____t_result_430
                        local ____t_429 = __t
                        local ____TS__Number_result_428 = __TS__Number(t)
                        __O[353] = ____TS__Number_result_428
                        if ____t_429(____TS__Number_result_428) then
                            ____t_result_430 = __O[353]
                        else
                            ____t_result_430 = 0
                        end
                        return true, ____L1_draw_433(
                            __L1,
                            ____c_431,
                            ____TS__Number_result_432,
                            ____t_result_427,
                            ____t_result_430
                        )
                    end)
                    if not ____try then
                        ____hasReturned, ____returnValue = ____catch(____hasReturned)
                    end
                    if ____hasReturned then
                        return ____returnValue
                    end
                end
            end,
            finish = function(____, c, scene)
                do
                    pcall(function()
                        __L1:finish(
                            c,
                            __TS__Number(scene)
                        )
                    end)
                end
            end,
            maps = __call(
                __keys(__L1.MAPS),
                "map",
                __NumberV
            )
        },
        "camadas,register,kit,leaves,touch,lightsAt,shadeAt,sun,drawRoom,arenaHandles,drawArena,arenaFront,handles,darkness,draw,finish,maps"
    )
end)(nil)
return ____exports
