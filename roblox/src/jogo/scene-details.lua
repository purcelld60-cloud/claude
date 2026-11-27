--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __getq, __mod, __ord, __arrL, __iterar, __t, __get, __call, __add, __assign = __JSR.__lt, __JSR.__getq, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__call, __JSR.__add, __JSR.__assign
local ____lualib = require(script.Parent.lualib_bundle)
local Map = ____lualib.Map
local __TS__New = ____lualib.__TS__New
local __TS__Number = ____lualib.__TS__Number
local __TS__Iterator = ____lualib.__TS__Iterator
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local ____t_2 = __t
    local ____t_1 = __t
    local ____temp_0 = not __t(window.Art)
    __O[2688] = ____temp_0
    if ____t_2(if ____t_1(____temp_0) then __O[2688] else window.SceneDetails) then
        return
    end
    local art = window.Art
    local arena = window.ArenaArt
    local cache = __TS__New(Map)
    local CACHE_LIMIT = 28
    local ____this_4
    ____this_4 = window
    local ____opt_3 = ____this_4.matchMedia
    local reduced = ____opt_3 and ____opt_3(____this_4, "(prefers-reduced-motion: reduce)")
    local function clamp(____, n, a, b)
        local ____a_8 = a
        local ____b_7 = b
        local ____t_6 = __t
        local ____TS__Number_result_5 = __TS__Number(n)
        __O[2689] = ____TS__Number_result_5
        return math.max(
            ____a_8,
            math.min(____b_7, if ____t_6(____TS__Number_result_5) then __O[2689] else 0)
        )
    end
    local function hash(____, n)
        local x = math.sin(n * 127.1 + 93.7) * 43758.5453
        return x - math.floor(x)
    end
    local function rect(____, c, x, y, w, h, color)
        c.fillStyle = color
        c:fillRect(
            math.floor(x + 0.5),
            math.floor(y + 0.5),
            math.ceil(w),
            math.ceil(h)
        )
    end
    local function poly(self, c, points, color)
        c.fillStyle = color
        c:beginPath()
        __call(
            points,
            "forEach",
            function(____, p, i) return if __t(i) then c:lineTo(
                math.floor(__get(p, 0) + 0.5),
                math.floor(__get(p, 1) + 0.5)
            ) else c:moveTo(
                math.floor(__get(p, 0) + 0.5),
                math.floor(__get(p, 1) + 0.5)
            ) end
        )
        c:closePath()
        __call(c, "fill")
    end
    local function line(self, c, points, color, width)
        if width == nil then
            width = 1
        end
        c.strokeStyle = color
        c.lineWidth = width
        c:beginPath()
        __call(
            points,
            "forEach",
            function(____, p, i) return if __t(i) then c:lineTo(
                math.floor(__get(p, 0) + 0.5),
                math.floor(__get(p, 1) + 0.5)
            ) else c:moveTo(
                math.floor(__get(p, 0) + 0.5),
                math.floor(__get(p, 1) + 0.5)
            ) end
        )
        c:stroke()
    end
    local function cached(self, key, w, h, paint)
        local v = __call(cache, "get", key)
        if __t(v) then
            __call(cache, "delete", key)
            __call(cache, "set", key, v)
            return v
        end
        v = window.document:createElement("canvas")
        v.width = w
        v.height = h
        local c = v:getContext("2d")
        c.imageSmoothingEnabled = false
        paint(nil, c)
        __call(cache, "set", key, v)
        while cache.size > CACHE_LIMIT do
            __call(
                cache,
                "delete",
                __call(cache, "keys"):next().value
            )
        end
        return v
    end
    local function time(self, t)
        local ____t_12 = __t
        local ____TS__Number_result_11 = __TS__Number(t)
        __O[2690] = ____TS__Number_result_11
        return if __t(reduced and reduced.matches) then 0 else if ____t_12(____TS__Number_result_11) then __O[2690] else 0
    end
    local function sceneAllowed(self)
        do
            local function ____catch()
                return true, true
            end
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                local ____opt_15 = window.Game
                if ____opt_15 ~= nil then
                    ____opt_15 = ____opt_15.getAudioState
                end
                local ____opt_result_17
                if ____opt_15 ~= nil then
                    ____opt_result_17 = ____opt_15(____opt_15)
                end
                local s = ____opt_result_17
                local ____t_21 = __t
                local ____opt_result_20
                if s ~= nil then
                    ____opt_result_20 = s.cutscene
                end
                local ____temp_26 = not ____t_21(____opt_result_20)
                if ____temp_26 then
                    local ____t_25 = __t
                    local ____opt_result_24
                    if s ~= nil then
                        ____opt_result_24 = s.activity
                    end
                    ____temp_26 = not ____t_25(____opt_result_24)
                end
                return true, ____temp_26
            end)
            if not ____try then
                ____hasReturned, ____returnValue = ____catch()
            end
            if ____hasReturned then
                return ____returnValue
            end
        end
    end
    local function cloud(self, c, x, y, s)
        if s == nil then
            s = 1
        end
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        c:scale(s, s)
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-55, 12}, 2),
                    __arrL({-43, 12}, 2),
                    __arrL({-43, 2}, 2),
                    __arrL({-25, 2}, 2),
                    __arrL({-25, -11}, 2),
                    __arrL({-5, -11}, 2),
                    __arrL({-5, -22}, 2),
                    __arrL({19, -22}, 2),
                    __arrL({19, -11}, 2),
                    __arrL({39, -11}, 2),
                    __arrL({39, 1}, 2),
                    __arrL({58, 1}, 2),
                    __arrL({58, 13}, 2),
                    __arrL({73, 13}, 2),
                    __arrL({73, 25}, 2),
                    __arrL({-55, 25}, 2)
                },
                16
            ),
            "#afd4e7"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-54, 9}, 2),
                    __arrL({-39, 9}, 2),
                    __arrL({-39, -1}, 2),
                    __arrL({-21, -1}, 2),
                    __arrL({-21, -13}, 2),
                    __arrL({0, -13}, 2),
                    __arrL({0, -24}, 2),
                    __arrL({18, -24}, 2),
                    __arrL({18, -13}, 2),
                    __arrL({35, -13}, 2),
                    __arrL({35, -2}, 2),
                    __arrL({53, -2}, 2),
                    __arrL({53, 10}, 2),
                    __arrL({67, 10}, 2),
                    __arrL({67, 18}, 2),
                    __arrL({-54, 18}, 2)
                },
                16
            ),
            "#e8f6fa"
        )
        rect(
            nil,
            c,
            -21,
            -11,
            51,
            13,
            "#ffffff"
        )
        rect(
            nil,
            c,
            2,
            -22,
            14,
            15,
            "#ffffff"
        )
        rect(
            nil,
            c,
            -37,
            0,
            71,
            8,
            "#fbffff"
        )
        rect(
            nil,
            c,
            -43,
            20,
            94,
            3,
            "#c6e3ed"
        )
        rect(
            nil,
            c,
            -26,
            25,
            65,
            2,
            "#cce7ed"
        )
        c:restore()
    end
    local function sky(self, c, scene, camera, t)
        if not __t(__call(
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
            scene
        )) then
            return
        end
        if __t(scene == 4 or scene == 5) then
            do
                local i = 0
                while i < 2 do
                    cloud(
                        nil,
                        c,
                        __mod(i * 423 + t * 1.8 - camera * 0.06 + 1200, 1200) - 100,
                        31 + i * 12,
                        0.38 + i * 0.06
                    )
                    i = i + 1
                end
            end
            return
        end
        local ____t_32 = __t
        local ____opt_29 = window.Graphics
        if ____opt_29 ~= nil then
            ____opt_29 = ____opt_29.isLite
        end
        local ____opt_result_31
        if ____opt_29 ~= nil then
            ____opt_result_31 = ____opt_29(____opt_29)
        end
        if ____t_32(____opt_result_31) then
            local h = if scene == 9 then 140 else 180
            local bg = cached(
                nil,
                __add("sky:", scene),
                960,
                h,
                function(____, g)
                    local grad = g:createLinearGradient(0, 0, 0, h)
                    grad:addColorStop(0, if scene == 3 then "#3f99d5" else "#3199df")
                    grad:addColorStop(0.64, "#7fc9ee")
                    grad:addColorStop(1, if h < 120 then "#74b8e7" else "#96cef0")
                    g.fillStyle = grad
                    g:fillRect(0, 0, 960, h)
                    do
                        local i = 0
                        while i < 9 do
                            rect(
                                nil,
                                g,
                                0,
                                h - 15 + i * 2,
                                960,
                                1,
                                "#acd9ee0a"
                            )
                            i = i + 1
                        end
                    end
                end
            )
            c:drawImage(bg, 0, 0)
            c:save()
            c:beginPath()
            c:rect(0, 0, 960, h)
            c:clip()
            local sx = 734 - camera * 0.025
            local sy = if h < 120 then 38 else 80
            do
                local i = 3
                while i > 0 do
                    rect(
                        nil,
                        c,
                        sx - 27 - i * 8,
                        sy - 22 - i * 6,
                        54 + i * 16,
                        44 + i * 12,
                        "#fff5b00b"
                    )
                    i = i - 1
                end
            end
            poly(
                nil,
                c,
                __arrL(
                    {
                        __arrL({sx - 21, sy - 29}, 2),
                        __arrL({sx + 17, sy - 29}, 2),
                        __arrL({sx + 17, sy - 22}, 2),
                        __arrL({sx + 27, sy - 22}, 2),
                        __arrL({sx + 27, sy + 18}, 2),
                        __arrL({sx + 19, sy + 18}, 2),
                        __arrL({sx + 19, sy + 27}, 2),
                        __arrL({sx - 20, sy + 27}, 2),
                        __arrL({sx - 20, sy + 18}, 2),
                        __arrL({sx - 28, sy + 18}, 2),
                        __arrL({sx - 28, sy - 19}, 2),
                        __arrL({sx - 21, sy - 19}, 2)
                    },
                    12
                ),
                "#ffe69b"
            )
            rect(
                nil,
                c,
                sx - 20,
                sy - 23,
                34,
                41,
                "#fff7ce"
            )
            rect(
                nil,
                c,
                sx - 15,
                sy - 20,
                26,
                4,
                "#fffdf0"
            )
            do
                local i = 0
                while i < 5 do
                    local x = __mod(
                        i * 257 + t * (2.2 + __mod(i, 2)) - camera * 0.06 + 1500,
                        1500
                    ) - 190
                    cloud(
                        nil,
                        c,
                        x,
                        36 + __mod(i, 3) * 37,
                        0.57 + __mod(i, 3) * 0.17
                    )
                    i = i + 1
                end
            end
            do
                local i = 0
                while i < 3 do
                    local x = __mod(i * 379 + t * 9 - camera * 0.1 + 1130, 1130) - 70
                    local y = 31 + __mod(i, 2) * 34
                    local flap = math.floor(math.sin(t * 5 + i) * 2 + 0.5)
                    line(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({x - 5, y + flap}, 2),
                                __arrL({x, y}, 2),
                                __arrL({x + 5, y + flap}, 2)
                            },
                            3
                        ),
                        "#4687a8",
                        1
                    )
                    i = i + 1
                end
            end
            c:restore()
        end
        if scene == 3 then
            for ____, wx in __iterar((__arrL({85, 2450}, 2))) do
                local x = wx - camera
                if __t(x < -30 or x > 990) then
                    continue
                end
                rect(
                    nil,
                    c,
                    x,
                    122,
                    8,
                    58,
                    "#4b6260"
                )
                rect(
                    nil,
                    c,
                    x + 1,
                    122,
                    2,
                    58,
                    "#9eb9b8"
                )
                rect(
                    nil,
                    c,
                    x - 16,
                    112,
                    41,
                    16,
                    "#3e5354"
                )
                do
                    local k = 0
                    while k < 3 do
                        rect(
                            nil,
                            c,
                            x - 11 + k * 11,
                            115,
                            8,
                            9,
                            "#f9e5ac"
                        )
                        k = k + 1
                    end
                end
            end
        end
        if scene == 7 then
            do
                local wx = 300
                while __lt(wx, camera + 1000) do
                    local x = wx - camera
                    if __t(x < -30 or x > 990) then
                        continue
                    end
                    rect(
                        nil,
                        c,
                        x,
                        100,
                        7,
                        80,
                        "#40687b"
                    )
                    rect(
                        nil,
                        c,
                        x + 1,
                        100,
                        2,
                        80,
                        "#9bbecb"
                    )
                    rect(
                        nil,
                        c,
                        x - 18,
                        89,
                        43,
                        17,
                        "#1f425c"
                    )
                    do
                        local j = 0
                        while j < 3 do
                            rect(
                                nil,
                                c,
                                x - 13 + j * 12,
                                93,
                                9,
                                8,
                                "#fff2b6"
                            )
                            j = j + 1
                        end
                    end
                    wx = wx + 1300
                end
            end
        end
    end
    local palettes = __arrL(
        {
            __arrL({"#d3ab6d", "#725339", "#e5c887"}, 3),
            __arrL({"#e2e7dc", "#7c999e", "#f8f5df"}, 3),
            __arrL({"#a2ada6", "#394d4b", "#d1cdb6"}, 3),
            __arrL({"#dcac7d", "#805b44", "#edd2a3"}, 3),
            __arrL({"#e8e5d5", "#879e9b", "#f9f3de"}, 3),
            __arrL({"#b9a18a", "#665d58", "#d0bc9f"}, 3),
            __arrL({"#bda4c6", "#4f4166", "#e9d9e8"}, 3),
            __arrL({"#79b75b", "#397f47", "#b4d17f"}, 3),
            __arrL({"#ddbc87", "#624b3d", "#f1d9aa"}, 3),
            __arrL({"#edf1e2", "#8ba6aa", "#ffffff"}, 3),
            __arrL({"#e9c598", "#94734f", "#f9e3bc"}, 3),
            __arrL({"#8199b6", "#26374c", "#b1d2de"}, 3)
        },
        12
    )
    local function groundTexture(self, c, scene, camera)
        local ____t_34 = __t
        local ____get_result_33 = __get(palettes, scene)
        __O[2691] = ____get_result_33
        local pal = if ____t_34(____get_result_33) then __O[2691] else __get(palettes, 0)
        local start = math.floor(camera / 256)
        do
            local chunk = start
            while chunk <= start + 4 do
                local seed = __mod(
                    __mod(chunk, 7) + 7,
                    7
                )
                local layer = cached(
                    nil,
                    __add(
                        __add(
                            __add("ground:", scene),
                            ":"
                        ),
                        seed
                    ),
                    256,
                    96,
                    function(____, g)
                        do
                            local i = 0
                            while i < 36 do
                                local x = hash(nil, i + seed * 71) * 250
                                local y = 8 + hash(nil, i + seed * 13 + 87) * 84
                                if scene == 0 then
                                    rect(
                                        nil,
                                        g,
                                        x,
                                        y,
                                        4 + hash(nil, i + 6) * 9,
                                        2,
                                        if __t(__mod(i, 3)) then __get(pal, 0) else __get(pal, 1)
                                    )
                                    if __mod(i, 4) == 0 then
                                        rect(
                                            nil,
                                            g,
                                            x + 3,
                                            y + 4,
                                            5,
                                            2,
                                            __get(pal, 2)
                                        )
                                        rect(
                                            nil,
                                            g,
                                            x + 2,
                                            y + 4,
                                            2,
                                            1,
                                            "#fff0b1"
                                        )
                                    end
                                elseif scene == 7 then
                                    rect(
                                        nil,
                                        g,
                                        x,
                                        y,
                                        2,
                                        3,
                                        if __t(__mod(i, 3)) then __get(pal, 0) else __get(pal, 1)
                                    )
                                    rect(
                                        nil,
                                        g,
                                        x + 2,
                                        y - 1,
                                        2,
                                        2,
                                        __get(pal, 0)
                                    )
                                else
                                    rect(
                                        nil,
                                        g,
                                        x,
                                        y,
                                        11 + hash(nil, i + 4) * 14,
                                        1,
                                        if __t(__mod(i, 3)) then __get(pal, 0) else __get(pal, 1)
                                    )
                                    if __mod(i, 5) == 0 then
                                        rect(
                                            nil,
                                            g,
                                            x + 4,
                                            y + 2,
                                            9,
                                            1,
                                            __get(pal, 2)
                                        )
                                    end
                                end
                                i = i + 1
                            end
                        end
                        if __t(scene ~= 0 and scene ~= 7) then
                            do
                                local x = 0
                                while x < 256 do
                                    rect(
                                        nil,
                                        g,
                                        x,
                                        4,
                                        1,
                                        92,
                                        __add(
                                            __get(pal, 1),
                                            "44"
                                        )
                                    )
                                    rect(
                                        nil,
                                        g,
                                        x + 2,
                                        5,
                                        1,
                                        36,
                                        __add(
                                            __get(pal, 2),
                                            "55"
                                        )
                                    )
                                    x = x + 64
                                end
                            end
                            rect(
                                nil,
                                g,
                                0,
                                48,
                                256,
                                1,
                                __add(
                                    __get(pal, 1),
                                    "44"
                                )
                            )
                            rect(
                                nil,
                                g,
                                0,
                                49,
                                256,
                                1,
                                __add(
                                    __get(pal, 2),
                                    "44"
                                )
                            )
                        end
                    end
                )
                local worldX = chunk * 256
                local ____t_39 = __t
                local ____getq_37 = __getq
                local ____opt_35 = window.WorldData
                if ____opt_35 ~= nil then
                    ____opt_35 = ____opt_35.gaps
                end
                local ____getq_37_result_38 = ____getq_37(____opt_35, scene)
                __O[2692] = ____getq_37_result_38
                local gaps = if ____t_39(____getq_37_result_38) then __O[2692] else __arrL({}, 0)
                c:save()
                c:beginPath()
                local cursor = worldX
                for ____, gap in __iterar((gaps)) do
                    local a = __TS__Number(__get(gap, 0))
                    local b = a + __TS__Number(__get(gap, 1))
                    if __t(b <= worldX or a >= worldX + 256) then
                        continue
                    end
                    if a > cursor then
                        c:rect(cursor - camera, 444, a - cursor, 96)
                    end
                    cursor = math.max(cursor, b)
                end
                if cursor < worldX + 256 then
                    c:rect(cursor - camera, 444, worldX + 256 - cursor, 96)
                end
                c:clip()
                c:drawImage(
                    layer,
                    math.floor(worldX - camera + 0.5),
                    444
                )
                c:restore()
                chunk = chunk + 1
            end
        end
    end
    local function groundLife(self, c, scene, camera, t)
        local outdoor = __call(
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
            scene
        )
        local start = math.floor(camera / 190)
        if __t(outdoor) then
            do
                local i = start
                while i <= start + 6 do
                    local x = i * 190 + hash(nil, i + 9) * 74 - camera
                    local yy = if __t(scene == 0 or scene == 7) then 524 else 530
                    if __t(scene == 0 or scene == 7) then
                        do
                            local j = 0
                            while j < 4 do
                                local sway = math.floor(math.sin(t * 1.5 + i + j) * 2 + 0.5)
                                local gx = x + j * 7
                                line(
                                    nil,
                                    c,
                                    __arrL(
                                        {
                                            __arrL({gx, yy}, 2),
                                            __arrL(
                                                {
                                                    gx - 3 + sway,
                                                    yy - 10 - __mod(j, 2) * 5
                                                },
                                                2
                                            )
                                        },
                                        2
                                    ),
                                    if __t(__mod(j, 2)) then "#7fbb48" else "#3c823e",
                                    2
                                )
                                line(
                                    nil,
                                    c,
                                    __arrL(
                                        {
                                            __arrL({gx, yy - 3}, 2),
                                            __arrL({gx + 5 + sway, yy - 10}, 2)
                                        },
                                        2
                                    ),
                                    "#a9d16b",
                                    2
                                )
                                j = j + 1
                            end
                        end
                        if __mod(i, 3) == 0 then
                            rect(
                                nil,
                                c,
                                x + 5,
                                yy - 17,
                                6,
                                4,
                                "#f2d176"
                            )
                            rect(
                                nil,
                                c,
                                x + 7,
                                yy - 19,
                                2,
                                8,
                                "#f2d176"
                            )
                        end
                    else
                        rect(
                            nil,
                            c,
                            x,
                            yy,
                            29,
                            3,
                            "#5f7e7044"
                        )
                        if __mod(i, 3) == 0 then
                            rect(
                                nil,
                                c,
                                x + 6,
                                yy - 3,
                                9,
                                3,
                                "#cec0a1"
                            )
                            rect(
                                nil,
                                c,
                                x + 7,
                                yy - 4,
                                6,
                                2,
                                "#eee0bb"
                            )
                        end
                    end
                    i = i + 1
                end
            end
        end
        if scene == 4 then
            do
                local i = 0
                while i < 10 do
                    local x = __mod(i * 113 + t * 6 - camera * 0.4 + 1100, 1100) - 70
                    local y = 281 + __mod(i * 29, 63)
                    rect(
                        nil,
                        c,
                        x,
                        y,
                        17 + __mod(i, 3) * 9,
                        1,
                        "#d3f3ee"
                    )
                    rect(
                        nil,
                        c,
                        x + 4,
                        y + 3,
                        10,
                        1,
                        "#b4e6e8"
                    )
                    i = i + 1
                end
            end
        end
        if scene == 5 then
            do
                local i = 0
                while i < 3 do
                    local wx = math.floor(camera / 430) * 430 + i * 430 + 197
                    local x = wx - camera
                    rect(
                        nil,
                        c,
                        x,
                        482,
                        57,
                        5,
                        "#4a65674d"
                    )
                    rect(
                        nil,
                        c,
                        x + 5,
                        483,
                        44,
                        1,
                        "#9fb6ad88"
                    )
                    rect(
                        nil,
                        c,
                        x + 16 + math.sin(t + i) * 4,
                        486,
                        13,
                        1,
                        "#d8ded1aa"
                    )
                    i = i + 1
                end
            end
        end
        if scene == 6 then
            do
                local i = 0
                while i < 9 do
                    local x = __mod(i * 137 + t * 5 - camera * 0.14 + 1080, 1080) - 60
                    local y = 25 + __mod(i * 39, 290)
                    rect(
                        nil,
                        c,
                        x,
                        y,
                        2,
                        2,
                        "#ede0ff"
                    )
                    if __mod(i, 3) == 0 then
                        rect(
                            nil,
                            c,
                            x - 3,
                            y + 1,
                            8,
                            1,
                            "#bb97d0"
                        )
                        rect(
                            nil,
                            c,
                            x + 1,
                            y - 3,
                            1,
                            8,
                            "#bb97d0"
                        )
                    end
                    i = i + 1
                end
            end
        end
    end
    local function interiorLight(self, c, scene, camera, t)
        if not __t(__call(
            __arrL({2, 8, 10}, 3),
            "includes",
            scene
        )) then
            return
        end
        local spacing = if scene == 2 then 280 else if scene == 8 then 438 else 660
        local start = math.floor(camera / spacing) - 1
        c:save()
        do
            local i = start
            while i < start + 6 do
                local x = i * spacing - camera + if scene == 2 then 84 else if scene == 8 then 130 else 175
                if __t(x < -180 or x > 1140) then
                    continue
                end
                poly(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x, if scene == 8 then 105 else 155}, 2),
                            __arrL({x + 35, if scene == 8 then 105 else 155}, 2),
                            __arrL({x + 137, 432}, 2),
                            __arrL({x - 83, 432}, 2)
                        },
                        4
                    ),
                    if scene == 8 then "#ffe3a909" else "#f9f5d20a"
                )
                do
                    local j = 0
                    while j < 4 do
                        local dx = x - 20 + j * 32
                        local yy = 460 + j * 8
                        rect(
                            nil,
                            c,
                            dx,
                            yy,
                            86 - j * 10,
                            2,
                            if scene == 8 then "#ffe3a918" else "#e6efda1a"
                        )
                        j = j + 1
                    end
                end
                if scene == 8 then
                    rect(
                        nil,
                        c,
                        x - 42,
                        135,
                        2,
                        131,
                        "#e5f7ef44"
                    )
                    rect(
                        nil,
                        c,
                        x - 42,
                        135,
                        72,
                        1,
                        "#e5f7ef66"
                    )
                end
                if scene == 2 then
                    rect(
                        nil,
                        c,
                        x + 8,
                        307,
                        2,
                        52,
                        "#cee6d633"
                    )
                    rect(
                        nil,
                        c,
                        x - 13,
                        307,
                        21,
                        1,
                        "#cee6d655"
                    )
                end
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 8 do
                local x = __mod(i * 157 + t * 3 - camera * 0.2 + 1100, 1100) - 70
                local y = 89 + __mod(i * 31, 195) + math.sin(t * 0.7 + i) * 4
                rect(
                    nil,
                    c,
                    x,
                    y,
                    1,
                    1,
                    "#fff7df99"
                )
                i = i + 1
            end
        end
        c:restore()
    end
    local function roofDetails(self, c, scene, camera, t)
        if __t(scene == 1 or scene == 9) then
            local y = if scene == 1 then 222 else 212
            local start = math.floor(camera / 187)
            do
                local i = start
                while i <= start + 6 do
                    local x = i * 187 - camera + 40
                    rect(
                        nil,
                        c,
                        x,
                        y + 10,
                        71,
                        2,
                        "#ffffff66"
                    )
                    rect(
                        nil,
                        c,
                        x,
                        y + 13,
                        71,
                        1,
                        "#7a9eb833"
                    )
                    i = i + 1
                end
            end
        end
        if scene == 11 then
            c:save()
            do
                local i = 0
                while i < 10 do
                    local x = __mod(i * 107 - camera * 0.16 + 1100, 1100) - 70
                    local y = 22 + __mod(i * 47, 165)
                    local a = 0.18 + 0.18 * math.sin(t * 1.1 + i)
                    c.globalAlpha = a
                    rect(
                        nil,
                        c,
                        x,
                        y,
                        2,
                        2,
                        if __t(__mod(i, 2)) then "#99d9f2" else "#ffe7ba"
                    )
                    i = i + 1
                end
            end
            c:restore()
        end
    end
    local function campaign(self, c, scene, camera, t)
        if not __t(sceneAllowed(nil)) then
            return
        end
        t = time(nil, t)
        c:save()
        c.imageSmoothingEnabled = false
        c:beginPath()
        c:rect(0, 0, 960, 540)
        c:clip()
        sky(
            nil,
            c,
            scene,
            camera,
            t
        )
        roofDetails(
            nil,
            c,
            scene,
            camera,
            t
        )
        groundTexture(nil, c, scene, camera)
        groundLife(
            nil,
            c,
            scene,
            camera,
            t
        )
        interiorLight(
            nil,
            c,
            scene,
            camera,
            t
        )
        c:restore()
    end
    local function classroom(self, c, id, t)
        if not __t(sceneAllowed(nil)) then
            return
        end
        t = time(nil, t)
        c:save()
        rect(
            nil,
            c,
            307,
            78,
            455,
            2,
            "#e3fff2"
        )
        rect(
            nil,
            c,
            307,
            81,
            2,
            135,
            "#c2e6da"
        )
        rect(
            nil,
            c,
            308,
            220,
            449,
            1,
            "#2f8b8955"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({719, 84}, 2),
                    __arrL({731, 84}, 2),
                    __arrL({756, 111}, 2),
                    __arrL({756, 124}, 2)
                },
                4
            ),
            "#e3fff52e"
        )
        rect(
            nil,
            c,
            304,
            231,
            466,
            2,
            "#ebd9ab"
        )
        for ____, x in __iterar((__arrL({155, 803}, 2))) do
            rect(
                nil,
                c,
                x + 7,
                87,
                2,
                97,
                "#e4f6f5"
            )
            rect(
                nil,
                c,
                x + 8,
                88,
                43,
                1,
                "#ffffff"
            )
            poly(
                nil,
                c,
                __arrL(
                    {
                        __arrL({x + 10, 89}, 2),
                        __arrL({x + 19, 89}, 2),
                        __arrL({x + 46, 130}, 2),
                        __arrL({x + 38, 130}, 2)
                    },
                    4
                ),
                "#f2ffff55"
            )
        end
        do
            local x = 0
            while x < 960 do
                rect(
                    nil,
                    c,
                    x + 2,
                    447,
                    1,
                    91,
                    "#d6decc33"
                )
                rect(
                    nil,
                    c,
                    x + 5,
                    450,
                    58,
                    1,
                    "#eff0db55"
                )
                x = x + 80
            end
        end
        do
            local i = 0
            while i < 7 do
                local x = 179 + i * 97 + math.sin(t * 0.4 + i) * 3
                local y = 46 + __mod(i * 37, 163)
                rect(
                    nil,
                    c,
                    x,
                    y,
                    1,
                    1,
                    "#f9f6d9aa"
                )
                i = i + 1
            end
        end
        for ____, x in __iterar((__arrL({190, 815}, 2))) do
            poly(
                nil,
                c,
                __arrL(
                    {
                        __arrL({x, 449}, 2),
                        __arrL({x + 55, 449}, 2),
                        __arrL({x + 88, 520}, 2),
                        __arrL({x - 6, 520}, 2)
                    },
                    4
                ),
                "#e2ecdc18"
            )
            rect(
                nil,
                c,
                x + 27,
                449,
                2,
                71,
                "#709b9918"
            )
            rect(
                nil,
                c,
                x + 1,
                481,
                69,
                2,
                "#71969422"
            )
        end
        c:restore()
    end
    local function boss(self, c, ____type, camera, t, homeX)
        if not __t(sceneAllowed(nil)) then
            return
        end
        t = time(nil, t)
        ____type = if type(____type) == "table" then ____type.type else ____type
        local ____t_45 = __t
        local ____opt_42 = window.HdScene
        if ____opt_42 ~= nil then
            ____opt_42 = ____opt_42.active
        end
        local ____opt_result_44
        if ____opt_42 ~= nil then
            ____opt_result_44 = ____opt_42(____opt_42, ____type)
        end
        if ____t_45(____opt_result_44) then
            return
        end
        local center = if __t(homeX) then homeX - camera else 480
        c:save()
        local dark = __call(
            __arrL({"marco", "menezes", "giant", "dede"}, 4),
            "includes",
            ____type
        )
        local color = if __t(dark) then "#d8a9d555" else "#f3dfae66"
        do
            local i = 0
            while i < 7 do
                local x = __mod(i * 167 + t * 4 + center * 0.07 + 1120, 1120) - 80
                local y = 27 + __mod(i * 43, 200)
                rect(
                    nil,
                    c,
                    x,
                    y,
                    1,
                    2,
                    color
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 19 do
                local x = i * 53 + math.sin(i) * 9
                rect(
                    nil,
                    c,
                    x,
                    453 + __mod(i, 3) * 29,
                    24 + __mod(i, 2) * 13,
                    1,
                    if __t(dark) then "#b391b133" else "#f2d7b433"
                )
                if __mod(i, 3) == 0 then
                    rect(
                        nil,
                        c,
                        x + 6,
                        455 + __mod(i, 3) * 29,
                        12,
                        1,
                        if __t(dark) then "#352c4922" else "#5a493622"
                    )
                end
                i = i + 1
            end
        end
        if ____type == "menezes" then
            for ____, side in __iterar((__arrL({-1, 1}, 2))) do
                local x = center + side * 356
                rect(
                    nil,
                    c,
                    x - 22,
                    69,
                    45,
                    2,
                    "#f1ca8b44"
                )
                rect(
                    nil,
                    c,
                    x - 21,
                    73,
                    2,
                    171,
                    "#eecb9122"
                )
            end
        end
        if __t(____type == "marco" or ____type == "giant") then
            do
                local i = 0
                while i < 4 do
                    local x = center - 350 + i * 230
                    local y = 48 + __mod(i, 2) * 120
                    line(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({x, y}, 2),
                                __arrL({x + 13, y - 4}, 2),
                                __arrL({x + 19, y + 3}, 2)
                            },
                            3
                        ),
                        "#d6b9df44",
                        1
                    )
                    i = i + 1
                end
            end
        end
        c:restore()
    end
    local function arenaBackdrop(self, c, camera, t, W, H)
        t = time(nil, t)
        c:save()
        c.imageSmoothingEnabled = false
        local cap = math.floor(math.max(
            45,
            math.min(H * 0.66, H * 0.88 - 100)
        ))
        local ____t_50 = __t
        local ____opt_result_48
        if camera ~= nil then
            ____opt_result_48 = camera.x
        end
        local ____TS__Number_result_49 = __TS__Number(____opt_result_48)
        __O[2693] = ____TS__Number_result_49
        local pan = if ____t_50(____TS__Number_result_49) then __O[2693] else 640
        local fade = math.min(
            24,
            math.floor(cap / 4)
        )
        local ratio = c.canvas.width / W
        local edge = cached(
            nil,
            __add(
                __add(
                    __add("arena-edge:", W),
                    ":"
                ),
                fade
            ),
            math.ceil(W),
            fade,
            function()
            end
        )
        local ec = edge:getContext("2d")
        ec:clearRect(0, 0, W, fade)
        ec:drawImage(
            c.canvas,
            0,
            (cap - fade) * ratio,
            W * ratio,
            fade * ratio,
            0,
            0,
            W,
            fade
        )
        c:save()
        c:beginPath()
        c:rect(0, 0, W, cap)
        c:clip()
        local atmosphere = cached(
            nil,
            __add(
                __add(
                    __add("arena-sky:", W),
                    ":"
                ),
                H
            ),
            math.ceil(W),
            math.ceil(cap),
            function(____, g)
                local sky = g:createLinearGradient(
                    0,
                    0,
                    0,
                    math.max(1, cap)
                )
                sky:addColorStop(0, "#268ed9")
                sky:addColorStop(0.45, "#69bced")
                sky:addColorStop(1, "#b1dded")
                g.fillStyle = sky
                g:fillRect(0, 0, W, cap)
            end
        )
        c:drawImage(atmosphere, 0, 0)
        local sunX = W * 0.76 - (pan - 640) * 0.006
        local sunY = H * 0.17
        do
            local i = 3
            while i > 0 do
                rect(
                    nil,
                    c,
                    sunX - 22 - i * 10,
                    sunY - 22 - i * 8,
                    44 + i * 20,
                    44 + i * 16,
                    "#fff3b00c"
                )
                i = i - 1
            end
        end
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({sunX - 19, sunY - 29}, 2),
                    __arrL({sunX + 18, sunY - 29}, 2),
                    __arrL({sunX + 18, sunY - 22}, 2),
                    __arrL({sunX + 27, sunY - 22}, 2),
                    __arrL({sunX + 27, sunY + 18}, 2),
                    __arrL({sunX + 18, sunY + 18}, 2),
                    __arrL({sunX + 18, sunY + 27}, 2),
                    __arrL({sunX - 20, sunY + 27}, 2),
                    __arrL({sunX - 20, sunY + 18}, 2),
                    __arrL({sunX - 28, sunY + 18}, 2),
                    __arrL({sunX - 28, sunY - 19}, 2),
                    __arrL({sunX - 19, sunY - 19}, 2)
                },
                12
            ),
            "#ffe699"
        )
        rect(
            nil,
            c,
            sunX - 18,
            sunY - 23,
            32,
            41,
            "#fff6c6"
        )
        rect(
            nil,
            c,
            sunX - 13,
            sunY - 20,
            24,
            3,
            "#fffde4"
        )
        do
            local layer = 0
            while layer < 3 do
                local step = math.max(93, W / (7 - layer))
                local shift = __mod((pan - 640) * (0.02 + layer * 0.023), step)
                local base = cap * (0.71 + layer * 0.13)
                local points = __arrL(
                    {__arrL({-step, cap + 20}, 2)},
                    1
                )
                do
                    local i = -1
                    while i <= math.ceil(W / step) + 1 do
                        local x = i * step - shift
                        local peak = base - (0.1 + layer * 0.015) * cap * (0.45 + hash(nil, i + layer * 13))
                        __call(
                            points,
                            "push",
                            __arrL({x, base + cap * 0.03}, 2),
                            __arrL({x + step * 0.21, peak + 8}, 2),
                            __arrL({x + step * 0.41, peak - 9}, 2),
                            __arrL({x + step * 0.55, peak - 13}, 2),
                            __arrL({x + step * 0.72, peak + 3}, 2),
                            __arrL({x + step * 0.89, base + cap * 0.02}, 2)
                        )
                        i = i + 1
                    end
                end
                __call(
                    points,
                    "push",
                    __arrL({W + step, cap + 20}, 2)
                )
                poly(
                    nil,
                    c,
                    points,
                    __get(
                        __arrL({"#a5cbdf", "#86b9d1", "#6ca9c6"}, 3),
                        layer
                    )
                )
                if layer == 1 then
                    do
                        local i = 0
                        while i < 7 do
                            local x = i * step - shift + step * 0.45
                            local yy = base - cap * 0.11
                            poly(
                                nil,
                                c,
                                __arrL(
                                    {
                                        __arrL({x - 9, yy}, 2),
                                        __arrL({x + 7, yy - 6}, 2),
                                        __arrL({x + 20, yy + 12}, 2),
                                        __arrL({x + 7, yy + 6}, 2)
                                    },
                                    4
                                ),
                                "#bedce7"
                            )
                            i = i + 1
                        end
                    end
                end
                layer = layer + 1
            end
        end
        do
            local i = 0
            while i < 5 do
                local x = __mod(
                    i * (W + 220) / 5 + t * (1.7 + __mod(i, 2)) - pan * 0.025 + W + 220,
                    W + 220
                ) - 110
                local y = H * 0.08 + __mod(i, 3) * H * 0.075
                cloud(
                    nil,
                    c,
                    x,
                    y,
                    0.48 + __mod(i, 3) * 0.11
                )
                i = i + 1
            end
        end
        c:restore()
        c:save()
        do
            local i = 0
            while i < 8 do
                c.globalAlpha = (i + 1) / 8
                c:drawImage(
                    edge,
                    0,
                    i * fade / 8,
                    W,
                    fade / 8,
                    0,
                    cap - fade + i * fade / 8,
                    W,
                    fade / 8
                )
                i = i + 1
            end
        end
        c:restore()
        local ground = H - 4
        for ____, side in __iterar((__arrL({1, -1}, 2))) do
            local x = if side > 0 then 8 else W - 8
            do
                local i = 0
                while i < 4 do
                    local sway = math.sin(t * 1.3 + i) * 2
                    poly(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({x, ground}, 2),
                                __arrL({x + side * (16 + i * 8), ground - 25 - i * 13}, 2),
                                __arrL({x + side * (24 + i * 8 + sway), ground - 29 - i * 13}, 2),
                                __arrL({x + side * (13 + i * 7 + sway), ground - 6}, 2)
                            },
                            4
                        ),
                        if __t(__mod(i, 2)) then "#328f4688" else "#75bb4b88"
                    )
                    i = i + 1
                end
            end
        end
        do
            local i = 0
            while i < 3 do
                local ____mod_56 = __mod
                local ____temp_55 = i * 317 + t * 8
                local ____t_54 = __t
                local ____opt_result_53
                if camera ~= nil then
                    ____opt_result_53 = camera.x
                end
                __O[2694] = ____opt_result_53
                local x = ____mod_56(____temp_55 - if ____t_54(____opt_result_53) then __O[2694] else 0 * 0.09 + W + 140, W + 140) - 70
                local y = H * 0.2 + i * 19 + math.sin(t * 0.4 + i) * 3
                local wing = math.floor(math.sin(t * 4 + i) * 2 + 0.5)
                line(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x - 4, y + wing}, 2),
                            __arrL({x, y}, 2),
                            __arrL({x + 4, y + wing}, 2)
                        },
                        3
                    ),
                    "#ecfaffbb",
                    1
                )
                i = i + 1
            end
        end
        local sx = W * 0.76
        local sy = H * 0.17
        rect(
            nil,
            c,
            sx - 14,
            sy - 21,
            24,
            3,
            "#fffbd999"
        )
        rect(
            nil,
            c,
            sx - 21,
            sy - 12,
            3,
            19,
            "#fffbd966"
        )
        c:restore()
    end
    local function arenaSurface(self, c, platforms, t)
        t = time(nil, t)
        c:save()
        c.imageSmoothingEnabled = false
        for ____, p in __iterar((if __t(platforms) then platforms else __arrL({}, 0))) do
            local ____t_58 = __t
            local ____TS__Number_result_57 = __TS__Number(p.x)
            __O[2695] = ____TS__Number_result_57
            local x = if ____t_58(____TS__Number_result_57) then __O[2695] else 0
            local ____t_60 = __t
            local ____TS__Number_result_59 = __TS__Number(p.y)
            __O[2696] = ____TS__Number_result_59
            local y = if ____t_60(____TS__Number_result_59) then __O[2696] else 0
            local ____t_62 = __t
            local ____TS__Number_result_61 = __TS__Number(p.w)
            __O[2697] = ____TS__Number_result_61
            local w = if ____t_62(____TS__Number_result_61) then __O[2697] else 0
            if w < 30 then
                continue
            end
            rect(
                nil,
                c,
                x + 8,
                y + 8,
                w - 16,
                2,
                "#302e2933"
            )
            do
                local i = 0
                while i < math.min(
                    9,
                    math.floor(w / 35)
                ) do
                    local xx = x + 13 + i * (w - 28) / math.max(
                        1,
                        math.min(
                            9,
                            math.floor(w / 35)
                        )
                    )
                    rect(
                        nil,
                        c,
                        xx,
                        y + 3,
                        7,
                        1,
                        "#e2f3ac"
                    )
                    rect(
                        nil,
                        c,
                        xx + 3,
                        y + 10,
                        5,
                        1,
                        "#f0cf8b66"
                    )
                    i = i + 1
                end
            end
            if __t(p.main) then
                for ____, side in __iterar((__arrL({-1, 1}, 2))) do
                    local xx = if side < 0 then x + 56 else x + w - 57
                    local sway = math.floor(math.sin(t * 1.4 + xx) * 2 + 0.5)
                    line(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({xx, y + 31}, 2),
                                __arrL({xx + sway, y + 49}, 2),
                                __arrL({xx - 4 + sway, y + 64}, 2)
                            },
                            3
                        ),
                        "#2f713e",
                        2
                    )
                    do
                        local j = 0
                        while j < 3 do
                            poly(
                                nil,
                                c,
                                __arrL(
                                    {
                                        __arrL({xx + sway, y + 39 + j * 9}, 2),
                                        __arrL({xx - 6 + sway, y + 36 + j * 9}, 2),
                                        __arrL({xx - 8 + sway, y + 40 + j * 9}, 2),
                                        __arrL({xx - 1 + sway, y + 44 + j * 9}, 2)
                                    },
                                    4
                                ),
                                if __t(__mod(j, 2)) then "#83bc55" else "#5ba149"
                            )
                            j = j + 1
                        end
                    end
                end
            end
        end
        c:restore()
    end
    local originalScene = art.drawScene
    local originalRoom = art.drawClassroom
    local originalBoss = art.drawArena
    art.drawScene = function(self, c, scene, camera, t)
        if camera == nil then
            camera = 0
        end
        if t == nil then
            t = 0
        end
        originalScene(
            nil,
            c,
            scene,
            camera,
            t
        )
        local ____t_68 = __t
        local ____opt_65 = window.HdMaps
        if ____opt_65 ~= nil then
            ____opt_65 = ____opt_65.handles
        end
        local ____opt_result_67
        if ____opt_65 ~= nil then
            ____opt_result_67 = ____opt_65(
                ____opt_65,
                __TS__Number(scene)
            )
        end
        if ____t_68(____opt_result_67) then
            return
        end
        local ____campaign_73 = campaign
        local ____c_71 = c
        local ____TS__Number_result_72 = __TS__Number(scene)
        local ____t_70 = __t
        local ____TS__Number_result_69 = __TS__Number(camera)
        __O[2698] = ____TS__Number_result_69
        ____campaign_73(
            nil,
            ____c_71,
            ____TS__Number_result_72,
            if ____t_70(____TS__Number_result_69) then __O[2698] else 0,
            t
        )
    end
    art.drawClassroom = function(self, c, id, t)
        if t == nil then
            t = 0
        end
        local ____t_79 = __t
        local ____opt_76 = window.HdMaps
        if ____opt_76 ~= nil then
            ____opt_76 = ____opt_76.drawRoom
        end
        local ____opt_result_78
        if ____opt_76 ~= nil then
            ____opt_result_78 = ____opt_76(____opt_76, c, id, t)
        end
        if ____t_79(____opt_result_78) then
            return
        end
        originalRoom(nil, c, id, t)
        classroom(nil, c, id, t)
    end
    art.drawArena = function(self, c, ____type, camera, t, homeX)
        if camera == nil then
            camera = 0
        end
        if t == nil then
            t = 0
        end
        if homeX == nil then
            homeX = 0
        end
        originalBoss(
            nil,
            c,
            ____type,
            camera,
            t,
            homeX
        )
        boss(
            nil,
            c,
            ____type,
            camera,
            t,
            homeX
        )
    end
    if __t(arena) then
        local background = arena.drawBackground
        local stage = arena.drawStage
        window.ArenaArt = __ord(
            __assign(
                {},
                arena,
                {
                    drawBackground = function(self, c, camera, t, W, H)
                        if W == nil then
                            W = 960
                        end
                        if H == nil then
                            H = 540
                        end
                        background(
                            nil,
                            c,
                            camera,
                            t,
                            W,
                            H
                        )
                        arenaBackdrop(
                            nil,
                            c,
                            camera,
                            t,
                            W,
                            H
                        )
                    end,
                    drawStage = function(self, c, platforms, t)
                        stage(nil, c, platforms, t)
                        arenaSurface(nil, c, platforms, t)
                    end
                }
            ),
            "drawBackground,drawStage"
        )
    end
    window.SceneDetails = __ord(
        {
            version = 1,
            getStatus = function() return {
                cacheEntries = cache.size,
                cacheLimit = CACHE_LIMIT,
                reducedMotion = not not __t(reduced and reduced.matches)
            } end,
            clearCache = function() return __call(cache, "clear") end
        },
        "version,getStatus,clearCache"
    )
end)(nil)
return ____exports
