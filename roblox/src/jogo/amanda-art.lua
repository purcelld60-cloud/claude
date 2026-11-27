--!native
--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __le, __gt, __ge, __isFiniteN, __mod, __ord, __arrL, __iterar, __t, __get, __len = __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__isFiniteN, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__len
local __call, __iter = __JSR.__call, __JSR.__iter
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Spread = ____lualib.__TS__Spread
local __TS__Number = ____lualib.__TS__Number
local __TS__Iterator = ____lualib.__TS__Iterator
local ____exports = {};
(function()
    local ____ = "use strict"
    local function rect(self, c, x, y, w, h, color)
        c.fillStyle = color
        c:fillRect(
            math.floor(x + 0.5),
            math.floor(y + 0.5),
            w,
            h
        )
    end
    local function shape(self, c, points, color)
        c.fillStyle = color
        local ys = __call(
            points,
            "map",
            function(____, p) return __get(p, 1) end
        )
        local bottom = math.max(__TS__Spread(__iter(ys)))
        do
            local y = math.min(__TS__Spread(__iter(ys)))
            while y < bottom do
                local cuts = __arrL({}, 0)
                do
                    local i = 0
                    while __lt(
                        i,
                        __len(points)
                    ) do
                        local a = __get(points, i)
                        local b = __get(
                            points,
                            __mod(
                                i + 1,
                                __len(points)
                            )
                        )
                        local mid = y + 0.5
                        if __gt(
                            __get(a, 1),
                            mid
                        ) ~= __gt(
                            __get(b, 1),
                            mid
                        ) then
                            __call(
                                cuts,
                                "push",
                                __get(a, 0) + (mid - __get(a, 1)) * (__get(b, 0) - __get(a, 0)) / (__get(b, 1) - __get(a, 1))
                            )
                        end
                        i = i + 1
                    end
                end
                __call(
                    cuts,
                    "sort",
                    function(____, a, b) return a - b end
                )
                do
                    local i = 0
                    while i + 1 < __len(cuts) do
                        c:fillRect(
                            math.floor(__get(cuts, i) + 0.5),
                            y,
                            math.floor(__get(cuts, i + 1) + 0.5) - math.floor(__get(cuts, i) + 0.5),
                            1
                        )
                        i = i + 2
                    end
                end
                y = y + 1
            end
        end
    end
    local function oval(self, c, x, y, rx, ry, color)
        c.fillStyle = color
        do
            local i = __TS__Number(-ry)
            while __le(i, ry) do
                local w = math.floor(rx * math.sqrt(1 - (i / ry) ^ 2) + 0.5)
                c:fillRect(
                    math.floor(x + 0.5) - w,
                    math.floor(y + 0.5) + i,
                    w * 2 + 1,
                    1
                )
                i = i + 1
            end
        end
    end
    local ink = "#2b1c30"
    local hair = "#352234"
    local sheen = "#654052"
    local gold = "#ffc768"
    local spots = __arrL(
        {
            __arrL({-9, -24}, 2),
            __arrL({-7, -20}, 2),
            __arrL({-9, -16}, 2),
            __arrL({-5, -13}, 2),
            __arrL({-4, -22}, 2),
            __arrL({-3, -17}, 2),
            __arrL({5, -23}, 2),
            __arrL({7, -20}, 2),
            __arrL({5, -16}, 2),
            __arrL({7, -12}, 2)
        },
        10
    )
    local function drawCharacter(self, c, x, y, o)
        if o == nil then
            o = {}
        end
        local t = if __t(o.frame) then o.frame else 0
        local sc = 2 * if __t(o.scale) then o.scale else 1
        local blink = __mod(t + 0.5, 3.7) < 0.14
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        c:scale(if __lt(o.facing, 0) then -sc else sc, sc)
        if __isFiniteN(o.opacity) then
            c.globalAlpha = c.globalAlpha * o.opacity
        end
        shape(
            nil,
            c,
            __arrL(
                {
                    __arrL({-7, -17}, 2),
                    __arrL({6, -17}, 2),
                    __arrL({8, -2}, 2),
                    __arrL({2, -2}, 2),
                    __arrL({0, -11}, 2),
                    __arrL({-2, -2}, 2),
                    __arrL({-9, -2}, 2)
                },
                7
            ),
            ink
        )
        shape(
            nil,
            c,
            __arrL(
                {
                    __arrL({-6, -16}, 2),
                    __arrL({-1, -16}, 2),
                    __arrL({-3, -3}, 2),
                    __arrL({-7, -3}, 2)
                },
                4
            ),
            "#584055"
        )
        shape(
            nil,
            c,
            __arrL(
                {
                    __arrL({1, -15}, 2),
                    __arrL({5, -16}, 2),
                    __arrL({7, -3}, 2),
                    __arrL({3, -3}, 2)
                },
                4
            ),
            "#493348"
        )
        rect(
            nil,
            c,
            -7,
            -9,
            1,
            5,
            "#916074"
        )
        rect(
            nil,
            c,
            -9,
            -3,
            7,
            3,
            ink
        )
        rect(
            nil,
            c,
            2,
            -3,
            9,
            3,
            ink
        )
        rect(
            nil,
            c,
            -7,
            -3,
            5,
            1,
            "#b56c72"
        )
        rect(
            nil,
            c,
            5,
            -3,
            4,
            1,
            "#d78b83"
        )
        c:translate(0, if math.sin(t * 2.2) > 0.66 then -1 else 0)
        shape(
            nil,
            c,
            __arrL(
                {
                    __arrL({-13, -15}, 2),
                    __arrL({-13, -20}, 2),
                    __arrL({-11, -25}, 2),
                    __arrL({-12, -30}, 2),
                    __arrL({-10, -39}, 2),
                    __arrL({-6, -43}, 2),
                    __arrL({2, -45}, 2),
                    __arrL({7, -43}, 2),
                    __arrL({10, -39}, 2),
                    __arrL({10, -31}, 2),
                    __arrL({8, -27}, 2),
                    __arrL({10, -22}, 2),
                    __arrL({8, -17}, 2),
                    __arrL({4, -15}, 2)
                },
                14
            ),
            ink
        )
        shape(
            nil,
            c,
            __arrL(
                {
                    __arrL({-12, -18}, 2),
                    __arrL({-9, -25}, 2),
                    __arrL({-10, -32}, 2),
                    __arrL({-8, -39}, 2),
                    __arrL({-3, -42}, 2),
                    __arrL({1, -42}, 2),
                    __arrL({-4, -36}, 2),
                    __arrL({-5, -29}, 2),
                    __arrL({-4, -22}, 2),
                    __arrL({-8, -16}, 2)
                },
                10
            ),
            hair
        )
        shape(
            nil,
            c,
            __arrL(
                {
                    __arrL({-11, -19}, 2),
                    __arrL({-8, -25}, 2),
                    __arrL({-9, -30}, 2),
                    __arrL({-7, -35}, 2),
                    __arrL({-7, -29}, 2),
                    __arrL({-6, -25}, 2),
                    __arrL({-9, -18}, 2)
                },
                7
            ),
            sheen
        )
        shape(
            nil,
            c,
            __arrL(
                {
                    __arrL({-7, -27}, 2),
                    __arrL({-1, -29}, 2),
                    __arrL({6, -27}, 2),
                    __arrL({10, -24}, 2),
                    __arrL({10, -13}, 2),
                    __arrL({8, -9}, 2),
                    __arrL({2, -10}, 2),
                    __arrL({-1, -12}, 2),
                    __arrL({-8, -9}, 2),
                    __arrL({-11, -12}, 2),
                    __arrL({-11, -21}, 2)
                },
                11
            ),
            ink
        )
        shape(
            nil,
            c,
            __arrL(
                {
                    __arrL({-6, -26}, 2),
                    __arrL({4, -27}, 2),
                    __arrL({6, -13}, 2),
                    __arrL({-5, -13}, 2)
                },
                4
            ),
            "#542a45"
        )
        rect(
            nil,
            c,
            -3,
            -15,
            8,
            2,
            "#261c2b"
        )
        rect(
            nil,
            c,
            0,
            -15,
            2,
            2,
            gold
        )
        shape(
            nil,
            c,
            __arrL(
                {
                    __arrL({-8, -26}, 2),
                    __arrL({-3, -27}, 2),
                    __arrL({-1, -24}, 2),
                    __arrL({-3, -18}, 2),
                    __arrL({-2, -12}, 2),
                    __arrL({-9, -10}, 2),
                    __arrL({-10, -13}, 2),
                    __arrL({-10, -22}, 2)
                },
                8
            ),
            "#c88846"
        )
        shape(
            nil,
            c,
            __arrL(
                {
                    __arrL({3, -27}, 2),
                    __arrL({8, -25}, 2),
                    __arrL({9, -22}, 2),
                    __arrL({8, -17}, 2),
                    __arrL({9, -11}, 2),
                    __arrL({5, -10}, 2),
                    __arrL({3, -15}, 2),
                    __arrL({4, -21}, 2)
                },
                8
            ),
            "#dfaa60"
        )
        shape(
            nil,
            c,
            __arrL(
                {
                    __arrL({-9, -25}, 2),
                    __arrL({-4, -27}, 2),
                    __arrL({-2, -25}, 2),
                    __arrL({-4, -22}, 2),
                    __arrL({-6, -23}, 2),
                    __arrL({-6, -21}, 2)
                },
                6
            ),
            "#f1c482"
        )
        shape(
            nil,
            c,
            __arrL(
                {
                    __arrL({4, -27}, 2),
                    __arrL({8, -25}, 2),
                    __arrL({6, -22}, 2),
                    __arrL({4, -21}, 2)
                },
                4
            ),
            "#f6d394"
        )
        for ____, ____value in __iterar((spots)) do
            local sx = ____value[1]
            local sy = ____value[2]
            rect(
                nil,
                c,
                sx,
                sy,
                2,
                1,
                "#633a38"
            )
            rect(
                nil,
                c,
                sx - 1,
                sy + 1,
                1,
                1,
                "#75443a"
            )
            rect(
                nil,
                c,
                sx + 1,
                sy + 1,
                1,
                1,
                "#8e543e"
            )
        end
        local gesture = if __t(o.talking) then o.talking else if __t(o.seated) then math.sin(t * 1.7) > 0.45 else o.seated
        shape(nil, c, if __t(gesture) then __arrL(
            {
                __arrL({7, -24}, 2),
                __arrL({10, -23}, 2),
                __arrL({11, -19}, 2),
                __arrL({14, -21}, 2),
                __arrL({15, -19}, 2),
                __arrL({12, -15}, 2),
                __arrL({8, -16}, 2),
                __arrL({6, -20}, 2)
            },
            8
        ) else __arrL(
            {
                __arrL({7, -24}, 2),
                __arrL({10, -23}, 2),
                __arrL({11, -18}, 2),
                __arrL({10, -14}, 2),
                __arrL({7, -15}, 2),
                __arrL({7, -19}, 2)
            },
            6
        ), "#c18a50")
        rect(
            nil,
            c,
            8,
            -22,
            2,
            1,
            "#56333a"
        )
        rect(
            nil,
            c,
            9,
            -19,
            2,
            1,
            "#633a38"
        )
        if __t(gesture) then
            rect(
                nil,
                c,
                12,
                -21,
                3,
                2,
                gold
            )
            rect(
                nil,
                c,
                13,
                -23,
                3,
                3,
                "#e6aa90"
            )
        else
            rect(
                nil,
                c,
                7,
                -15,
                4,
                1,
                gold
            )
            rect(
                nil,
                c,
                7,
                -14,
                3,
                3,
                "#d69a82"
            )
        end
        rect(
            nil,
            c,
            -1,
            -31,
            5,
            5,
            "#b97967"
        )
        rect(
            nil,
            c,
            0,
            -28,
            4,
            2,
            "#e9a98c"
        )
        shape(
            nil,
            c,
            __arrL(
                {
                    __arrL({-6, -38}, 2),
                    __arrL({-2, -41}, 2),
                    __arrL({5, -40}, 2),
                    __arrL({8, -37}, 2),
                    __arrL({8, -33}, 2),
                    __arrL({9, -32}, 2),
                    __arrL({8, -30}, 2),
                    __arrL({6, -28}, 2),
                    __arrL({2, -27}, 2),
                    __arrL({-4, -30}, 2),
                    __arrL({-6, -33}, 2)
                },
                11
            ),
            "#c88978"
        )
        shape(
            nil,
            c,
            __arrL(
                {
                    __arrL({-3, -37}, 2),
                    __arrL({2, -40}, 2),
                    __arrL({6, -38}, 2),
                    __arrL({7, -36}, 2),
                    __arrL({7, -32}, 2),
                    __arrL({8, -32}, 2),
                    __arrL({7, -30}, 2),
                    __arrL({4, -28}, 2),
                    __arrL({1, -29}, 2),
                    __arrL({-2, -31}, 2)
                },
                10
            ),
            "#efb498"
        )
        rect(
            nil,
            c,
            5,
            -33,
            2,
            1,
            "#ffd1ac"
        )
        rect(
            nil,
            c,
            1,
            -31,
            3,
            1,
            "#dc9786"
        )
        shape(
            nil,
            c,
            __arrL(
                {
                    __arrL({-9, -32}, 2),
                    __arrL({-10, -37}, 2),
                    __arrL({-7, -41}, 2),
                    __arrL({-2, -44}, 2),
                    __arrL({4, -43}, 2),
                    __arrL({8, -41}, 2),
                    __arrL({10, -38}, 2),
                    __arrL({7, -39}, 2),
                    __arrL({2, -39}, 2),
                    __arrL({-1, -36}, 2),
                    __arrL({-5, -35}, 2),
                    __arrL({-6, -30}, 2),
                    __arrL({-8, -27}, 2)
                },
                13
            ),
            hair
        )
        shape(
            nil,
            c,
            __arrL(
                {
                    __arrL({-8, -36}, 2),
                    __arrL({-6, -40}, 2),
                    __arrL({-1, -42}, 2),
                    __arrL({4, -42}, 2),
                    __arrL({0, -41}, 2),
                    __arrL({-4, -39}, 2)
                },
                6
            ),
            sheen
        )
        rect(
            nil,
            c,
            -5,
            -39,
            3,
            1,
            "#98616a"
        )
        rect(
            nil,
            c,
            -7,
            -33,
            1,
            4,
            "#86535f"
        )
        rect(
            nil,
            c,
            0,
            -36,
            4,
            1,
            "#563343"
        )
        rect(
            nil,
            c,
            6,
            -37,
            2,
            1,
            "#563343"
        )
        rect(
            nil,
            c,
            -1,
            -35,
            1,
            1,
            ink
        )
        rect(
            nil,
            c,
            0,
            -34,
            4,
            1,
            ink
        )
        rect(
            nil,
            c,
            6,
            -35,
            2,
            1,
            ink
        )
        if not __t(blink) then
            rect(
                nil,
                c,
                1,
                -33,
                3,
                1,
                "#fff0d3"
            )
            rect(
                nil,
                c,
                3,
                -33,
                1,
                1,
                "#675840"
            )
            rect(
                nil,
                c,
                6,
                -34,
                2,
                1,
                "#f5dfc3"
            )
            rect(
                nil,
                c,
                7,
                -34,
                1,
                1,
                ink
            )
        end
        rect(
            nil,
            c,
            4,
            -30,
            3,
            1,
            "#a44964"
        )
        if __t(gesture) then
            rect(
                nil,
                c,
                5,
                -29,
                2,
                1,
                "#d97a82"
            )
        end
        rect(
            nil,
            c,
            -5,
            -32,
            2,
            2,
            "#e1a38a"
        )
        rect(
            nil,
            c,
            -5,
            -30,
            1,
            3,
            gold
        )
        rect(
            nil,
            c,
            -4,
            -28,
            2,
            1,
            "#ffe49a"
        )
        rect(
            nil,
            c,
            -2,
            -30,
            1,
            2,
            "#d99945"
        )
        c:restore()
    end
    local function light(self, c, x, y, r, color)
        local g = c:createRadialGradient(
            x,
            y,
            0,
            x,
            y,
            r
        )
        g:addColorStop(0, color)
        g:addColorStop(1, "rgba(255,176,91,0)")
        c.fillStyle = g
        c:fillRect(x - r, y - r, 2 * r, 2 * r)
    end
    local function fern(self, c, x, y, flip)
        c:save()
        c:translate(x, y)
        c:scale(flip, 1)
        do
            local j = 0
            while j < 9 do
                local dx = (j - 4) * 5
                local h = 28 - math.abs(j - 4) * 3
                do
                    local n = 0
                    while n < 10 do
                        local k = n / 10
                        local px = math.floor(dx * k + 0.5)
                        local py = math.floor(-h * math.sin(k * 1.6) + 0.5)
                        rect(
                            nil,
                            c,
                            px,
                            py,
                            2,
                            3,
                            "#28433c"
                        )
                        if n > 2 then
                            rect(
                                nil,
                                c,
                                px - 3,
                                py - 1,
                                4,
                                2,
                                "#416755"
                            )
                            rect(
                                nil,
                                c,
                                px + 1,
                                py - 3,
                                4,
                                2,
                                "#628269"
                            )
                        end
                        n = n + 1
                    end
                end
                j = j + 1
            end
        end
        shape(
            nil,
            c,
            __arrL(
                {
                    __arrL({-10, 0}, 2),
                    __arrL({11, 0}, 2),
                    __arrL({8, 15}, 2),
                    __arrL({-7, 15}, 2)
                },
                4
            ),
            "#824352"
        )
        rect(
            nil,
            c,
            -11,
            -1,
            23,
            4,
            "#ca795d"
        )
        rect(
            nil,
            c,
            -6,
            5,
            2,
            7,
            "#ae6659"
        )
        c:restore()
    end
    local function city(self, c)
        local twilight = c:createLinearGradient(0, 18, 0, 142)
        twilight:addColorStop(0, "#24253e")
        twilight:addColorStop(0.46, "#564764")
        twilight:addColorStop(1, "#e69377")
        c.fillStyle = twilight
        c:fillRect(44, 0, 392, 149)
        do
            local i = 0
            while i < 55 do
                rect(
                    nil,
                    c,
                    53 + __mod(i * 167, 365),
                    9 + __mod(i * 37, 84),
                    if __t(__mod(i, 8)) then 1 else 2,
                    1,
                    if __t(__mod(i, 3)) then "#ae9db7" else "#eee1c5"
                )
                i = i + 1
            end
        end
        oval(
            nil,
            c,
            329,
            52,
            10,
            10,
            "#ffdda5"
        )
        oval(
            nil,
            c,
            333,
            49,
            9,
            9,
            "#453c56"
        )
        do
            local i = 0
            while i < 3 do
                local pts = __arrL(
                    {
                        __arrL({40, 150}, 2),
                        __arrL({40, 96 + i * 9}, 2)
                    },
                    2
                )
                do
                    local j = 0
                    while j <= 20 do
                        __call(
                            pts,
                            "push",
                            __arrL(
                                {
                                    42 + j * 20,
                                    math.floor(88 + i * 11 + math.sin(j * 0.88 + i) * 9 + math.cos(j * 1.32) * 4 + 0.5)
                                },
                                2
                            )
                        )
                        j = j + 1
                    end
                end
                __call(
                    pts,
                    "push",
                    __arrL({444, 150}, 2)
                )
                shape(
                    nil,
                    c,
                    pts,
                    __get(
                        __arrL({"#796785", "#635778", "#4a4867"}, 3),
                        i
                    )
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 24 do
                local x = 45 + i * 17
                local y = 123 - __mod(i * 13, 16)
                local h = 22 + __mod(i * 3, 9)
                rect(
                    nil,
                    c,
                    x,
                    y,
                    15,
                    h,
                    __get(
                        __arrL({"#654b58", "#82616a", "#785660"}, 3),
                        __mod(i, 3)
                    )
                )
                shape(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x - 2, y}, 2),
                            __arrL({x + 5, y - 6}, 2),
                            __arrL({x + 12, y - 6}, 2),
                            __arrL({x + 16, y}, 2)
                        },
                        4
                    ),
                    "#453c50"
                )
                do
                    local k = 0
                    while k < 2 do
                        rect(
                            nil,
                            c,
                            x + 3 + 7 * k,
                            y + 4,
                            2,
                            3,
                            if __t(__mod(i + k, 3)) then "#efb079" else "#49445a"
                        )
                        k = k + 1
                    end
                end
                i = i + 1
            end
        end
        rect(
            nil,
            c,
            148,
            96,
            10,
            34,
            "#b88a80"
        )
        rect(
            nil,
            c,
            150,
            91,
            6,
            8,
            "#ad8080"
        )
        shape(
            nil,
            c,
            __arrL(
                {
                    __arrL({147, 93}, 2),
                    __arrL({153, 82}, 2),
                    __arrL({160, 93}, 2)
                },
                3
            ),
            "#494358"
        )
        rect(
            nil,
            c,
            152,
            79,
            1,
            5,
            "#514858"
        )
        rect(
            nil,
            c,
            151,
            100,
            2,
            5,
            "#674f61"
        )
        rect(
            nil,
            c,
            155,
            100,
            1,
            5,
            "#674f61"
        )
        do
            local i = 0
            while i < 18 do
                oval(
                    nil,
                    c,
                    45 + i * 24,
                    140 - __mod(i * 3, 7),
                    15,
                    9,
                    if __t(__mod(i, 3)) then "#324849" else "#3d5150"
                )
                i = i + 1
            end
        end
    end
    local function curtain(self, c, x, flip)
        c:save()
        c:translate(x, 0)
        c:scale(flip, 1)
        shape(
            nil,
            c,
            __arrL(
                {
                    __arrL({0, 0}, 2),
                    __arrL({94, 0}, 2),
                    __arrL({86, 14}, 2),
                    __arrL({71, 31}, 2),
                    __arrL({46, 48}, 2),
                    __arrL({33, 66}, 2),
                    __arrL({21, 77}, 2),
                    __arrL({30, 127}, 2),
                    __arrL({26, 141}, 2),
                    __arrL({5, 142}, 2),
                    __arrL({0, 124}, 2)
                },
                11
            ),
            "#502e46"
        )
        shape(
            nil,
            c,
            __arrL(
                {
                    __arrL({3, 2}, 2),
                    __arrL({84, 2}, 2),
                    __arrL({67, 24}, 2),
                    __arrL({48, 39}, 2),
                    __arrL({29, 62}, 2),
                    __arrL({18, 73}, 2),
                    __arrL({22, 89}, 2),
                    __arrL({15, 104}, 2),
                    __arrL({17, 136}, 2),
                    __arrL({8, 138}, 2),
                    __arrL({4, 104}, 2)
                },
                11
            ),
            "#863f53"
        )
        shape(
            nil,
            c,
            __arrL(
                {
                    __arrL({19, 2}, 2),
                    __arrL({42, 2}, 2),
                    __arrL({32, 22}, 2),
                    __arrL({17, 42}, 2),
                    __arrL({12, 60}, 2),
                    __arrL({11, 53}, 2),
                    __arrL({15, 29}, 2)
                },
                7
            ),
            "#ac565d"
        )
        shape(
            nil,
            c,
            __arrL(
                {
                    __arrL({60, 2}, 2),
                    __arrL({75, 2}, 2),
                    __arrL({57, 24}, 2),
                    __arrL({38, 41}, 2),
                    __arrL({27, 55}, 2),
                    __arrL({34, 39}, 2)
                },
                6
            ),
            "#b86264"
        )
        rect(
            nil,
            c,
            11,
            73,
            14,
            3,
            "#dda264"
        )
        rect(
            nil,
            c,
            18,
            76,
            2,
            9,
            "#ba804d"
        )
        rect(
            nil,
            c,
            17,
            84,
            4,
            4,
            "#f1b672"
        )
        c:restore()
    end
    local backdrop
    local function makeBackdrop(self)
        local cv = window.document:createElement("canvas")
        cv.width = 480
        cv.height = 270
        local c = cv:getContext("2d")
        c.imageSmoothingEnabled = false
        rect(
            nil,
            c,
            0,
            0,
            480,
            270,
            "#935b52"
        )
        do
            local i = 0
            while i < 23 do
                rect(
                    nil,
                    c,
                    0,
                    i * 7,
                    480,
                    1,
                    if __t(__mod(i, 2)) then "#975f55" else "#a56a59"
                )
                i = i + 1
            end
        end
        rect(
            nil,
            c,
            32,
            0,
            416,
            148,
            "#4c3343"
        )
        rect(
            nil,
            c,
            36,
            0,
            408,
            145,
            "#bf805c"
        )
        city(nil, c)
        do
            local j = 0
            while j < 3 do
                local x = 40 + j * 133
                do
                    local k = 0
                    while k <= 132 do
                        local edge = math.abs((k - 66) / 66)
                        local y = math.floor(5 + edge ^ 3 * 46 + 0.5)
                        rect(
                            nil,
                            c,
                            x + k,
                            0,
                            1,
                            y,
                            "#6a4247"
                        )
                        rect(
                            nil,
                            c,
                            x + k,
                            y,
                            1,
                            3,
                            "#b57857"
                        )
                        rect(
                            nil,
                            c,
                            x + k,
                            y + 3,
                            1,
                            1,
                            "#edb77a"
                        )
                        k = k + 1
                    end
                end
                rect(
                    nil,
                    c,
                    x - 2,
                    39,
                    6,
                    104,
                    "#533d46"
                )
                rect(
                    nil,
                    c,
                    x,
                    41,
                    2,
                    100,
                    "#b77957"
                )
                j = j + 1
            end
        end
        rect(
            nil,
            c,
            437,
            35,
            5,
            107,
            "#61424a"
        )
        rect(
            nil,
            c,
            37,
            139,
            405,
            4,
            "#432f3b"
        )
        rect(
            nil,
            c,
            32,
            142,
            416,
            4,
            "#ce8b65"
        )
        rect(
            nil,
            c,
            33,
            146,
            414,
            2,
            "#ebaf78"
        )
        curtain(nil, c, 35, 1)
        curtain(nil, c, 444, -1)
        do
            local x = 41
            while x < 439 do
                local y = 18 + math.floor(15 * math.sin((x - 41) * math.pi / 198) ^ 2 + 0.5)
                rect(
                    nil,
                    c,
                    x,
                    y,
                    1,
                    1,
                    "#332b3a"
                )
                if __mod(x - 48, 23) == 0 then
                    rect(
                        nil,
                        c,
                        x,
                        y + 1,
                        2,
                        3,
                        "#6a4b46"
                    )
                    light(
                        nil,
                        c,
                        x + 1,
                        y + 5,
                        7,
                        "rgba(255,197,116,.23)"
                    )
                    rect(
                        nil,
                        c,
                        x,
                        y + 4,
                        3,
                        3,
                        "#ffe7a3"
                    )
                end
                x = x + 1
            end
        end
        for ____, x in __iterar((__arrL({12, 467}, 2))) do
            light(
                nil,
                c,
                x,
                65,
                28,
                "rgba(255,191,121,.48)"
            )
            rect(
                nil,
                c,
                x - 1,
                59,
                3,
                19,
                "#70494b"
            )
            rect(
                nil,
                c,
                x - 6,
                76,
                13,
                3,
                "#513945"
            )
            shape(
                nil,
                c,
                __arrL(
                    {
                        __arrL({x - 8, 66}, 2),
                        __arrL({x - 4, 57}, 2),
                        __arrL({x + 4, 57}, 2),
                        __arrL({x + 8, 66}, 2)
                    },
                    4
                ),
                "#f0b67b"
            )
            rect(
                nil,
                c,
                x - 6,
                66,
                12,
                2,
                "#ffe0a0"
            )
            rect(
                nil,
                c,
                x - 2,
                69,
                4,
                4,
                "#c28a61"
            )
        end
        rect(
            nil,
            c,
            0,
            150,
            480,
            47,
            "#694449"
        )
        rect(
            nil,
            c,
            0,
            149,
            480,
            2,
            "#dfa074"
        )
        do
            local x = 0
            while x < 480 do
                rect(
                    nil,
                    c,
                    x,
                    152,
                    2,
                    43,
                    "#4e353d"
                )
                rect(
                    nil,
                    c,
                    x + 3,
                    153,
                    1,
                    40,
                    "#86594e"
                )
                x = x + 22
            end
        end
        rect(
            nil,
            c,
            0,
            193,
            480,
            6,
            "#48343c"
        )
        rect(
            nil,
            c,
            0,
            199,
            480,
            71,
            "#a16b5a"
        )
        do
            local row = 0
            while row < 5 do
                do
                    local col = -1
                    while col < 14 do
                        local x = col * 38 + __mod(row, 2) * 19
                        local y = 199 + row * 15
                        shape(
                            nil,
                            c,
                            __arrL(
                                {
                                    __arrL({x, y}, 2),
                                    __arrL({x + 18, y + 7}, 2),
                                    __arrL({x, y + 14}, 2),
                                    __arrL({x - 18, y + 7}, 2)
                                },
                                4
                            ),
                            if __t(__mod(row + col, 2)) then "#81565a" else "#966366"
                        )
                        col = col + 1
                    end
                end
                row = row + 1
            end
        end
        rect(
            nil,
            c,
            74,
            136,
            332,
            47,
            "#372b39"
        )
        rect(
            nil,
            c,
            77,
            133,
            326,
            43,
            "#693749"
        )
        rect(
            nil,
            c,
            80,
            133,
            320,
            3,
            "#c88670"
        )
        do
            local x = 85
            while x < 397 do
                shape(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x, 140}, 2),
                            __arrL({x + 10, 146}, 2),
                            __arrL({x + 20, 140}, 2),
                            __arrL({x + 10, 149}, 2)
                        },
                        4
                    ),
                    "#844654"
                )
                rect(
                    nil,
                    c,
                    x + 9,
                    147,
                    2,
                    2,
                    "#c68069"
                )
                x = x + 22
            end
        end
        rect(
            nil,
            c,
            76,
            174,
            328,
            5,
            "#a65f5b"
        )
        rect(
            nil,
            c,
            79,
            179,
            322,
            10,
            "#53333d"
        )
        fern(
            nil,
            c,
            32,
            180,
            1
        )
        fern(
            nil,
            c,
            451,
            181,
            -1
        )
        return cv
    end
    local function glass(self, c, x, y)
        shape(
            nil,
            c,
            __arrL(
                {
                    __arrL({x - 4, y - 7}, 2),
                    __arrL({x + 5, y - 7}, 2),
                    __arrL({x + 4, y}, 2),
                    __arrL({x + 1, y + 2}, 2),
                    __arrL({x - 2, y}, 2)
                },
                5
            ),
            "#e1c0a3"
        )
        rect(
            nil,
            c,
            x - 3,
            y - 5,
            6,
            4,
            "#bd665d"
        )
        rect(
            nil,
            c,
            x - 2,
            y - 6,
            1,
            4,
            "#fff0c7"
        )
        rect(
            nil,
            c,
            x,
            y + 2,
            1,
            4,
            "#eacead"
        )
        rect(
            nil,
            c,
            x - 3,
            y + 6,
            7,
            1,
            "#f3d8b7"
        )
    end
    local function dinnerTable(self, c, course, t)
        shape(
            nil,
            c,
            __arrL(
                {
                    __arrL({128, 154}, 2),
                    __arrL({345, 154}, 2),
                    __arrL({373, 179}, 2),
                    __arrL({365, 189}, 2),
                    __arrL({114, 189}, 2),
                    __arrL({106, 179}, 2)
                },
                6
            ),
            "#392b38"
        )
        rect(
            nil,
            c,
            137,
            184,
            7,
            43,
            "#69434b"
        )
        rect(
            nil,
            c,
            340,
            184,
            7,
            43,
            "#69434b"
        )
        shape(
            nil,
            c,
            __arrL(
                {
                    __arrL({127, 152}, 2),
                    __arrL({345, 152}, 2),
                    __arrL({370, 173}, 2),
                    __arrL({357, 189}, 2),
                    __arrL({332, 185}, 2),
                    __arrL({309, 192}, 2),
                    __arrL({155, 192}, 2),
                    __arrL({134, 187}, 2),
                    __arrL({116, 192}, 2),
                    __arrL({108, 173}, 2)
                },
                10
            ),
            "#b36c65"
        )
        shape(
            nil,
            c,
            __arrL(
                {
                    __arrL({127, 152}, 2),
                    __arrL({345, 152}, 2),
                    __arrL({370, 173}, 2),
                    __arrL({107, 173}, 2)
                },
                4
            ),
            "#f0c89e"
        )
        rect(
            nil,
            c,
            111,
            173,
            255,
            3,
            "#ffdcad"
        )
        shape(
            nil,
            c,
            __arrL(
                {
                    __arrL({210, 152}, 2),
                    __arrL({253, 152}, 2),
                    __arrL({261, 172}, 2),
                    __arrL({260, 191}, 2),
                    __arrL({218, 191}, 2),
                    __arrL({218, 173}, 2)
                },
                6
            ),
            "#47655e"
        )
        rect(
            nil,
            c,
            220,
            175,
            2,
            15,
            "#99a583"
        )
        rect(
            nil,
            c,
            257,
            175,
            1,
            14,
            "#d8b98c"
        )
        do
            local x = 225
            while x < 256 do
                rect(
                    nil,
                    c,
                    x,
                    184,
                    3,
                    1,
                    "#d5be8e"
                )
                rect(
                    nil,
                    c,
                    x + 1,
                    183,
                    1,
                    3,
                    "#d5be8e"
                )
                x = x + 7
            end
        end
        for ____, x in __iterar((__arrL({179, 295}, 2))) do
            oval(
                nil,
                c,
                x,
                163,
                16,
                4,
                "#bb927c"
            )
            oval(
                nil,
                c,
                x,
                162,
                15,
                3,
                "#ffdfb3"
            )
            oval(
                nil,
                c,
                x,
                162,
                11,
                2,
                "#c8b49c"
            )
            rect(
                nil,
                c,
                x - 22,
                157,
                1,
                10,
                "#8a7776"
            )
            rect(
                nil,
                c,
                x - 24,
                157,
                1,
                3,
                "#8a7776"
            )
            rect(
                nil,
                c,
                x - 24,
                160,
                3,
                1,
                "#8a7776"
            )
            if course == 0 then
                oval(
                    nil,
                    c,
                    x - 3,
                    160,
                    6,
                    3,
                    "#b9764e"
                )
                rect(
                    nil,
                    c,
                    x - 5,
                    157,
                    6,
                    2,
                    "#ffe0a0"
                )
                rect(
                    nil,
                    c,
                    x + 4,
                    161,
                    3,
                    1,
                    "#6e7f54"
                )
            end
            if course == 1 then
                oval(
                    nil,
                    c,
                    x,
                    161,
                    10,
                    3,
                    "#784746"
                )
                oval(
                    nil,
                    c,
                    x,
                    159,
                    10,
                    3,
                    "#d7784c"
                )
                rect(
                    nil,
                    c,
                    x - 4,
                    158,
                    5,
                    2,
                    "#f4be63"
                )
                rect(
                    nil,
                    c,
                    x + 3,
                    158,
                    3,
                    2,
                    "#6e884b"
                )
            end
            if course == 2 then
                rect(
                    nil,
                    c,
                    x - 5,
                    156,
                    10,
                    6,
                    "#764452"
                )
                rect(
                    nil,
                    c,
                    x - 5,
                    157,
                    10,
                    1,
                    "#e7ae81"
                )
                rect(
                    nil,
                    c,
                    x - 5,
                    155,
                    10,
                    2,
                    "#533342"
                )
                rect(
                    nil,
                    c,
                    x,
                    153,
                    3,
                    2,
                    "#d87972"
                )
            end
        end
        glass(nil, c, 202, 156)
        glass(nil, c, 273, 156)
        oval(
            nil,
            c,
            237,
            160,
            7,
            2,
            "#b67d61"
        )
        rect(
            nil,
            c,
            235,
            145,
            4,
            15,
            "#ffe3b0"
        )
        rect(
            nil,
            c,
            238,
            147,
            1,
            12,
            "#d7a875"
        )
        local flicker = if math.sin(t * 4.5) > 0.25 then 1 else 0
        light(
            nil,
            c,
            237,
            142,
            15 + flicker,
            "rgba(255,191,112,.26)"
        )
        rect(
            nil,
            c,
            236,
            139 + flicker,
            2,
            5 - flicker,
            "#ffbc72"
        )
        rect(
            nil,
            c,
            236,
            142,
            2,
            2,
            "#fff4ba"
        )
        rect(
            nil,
            c,
            250,
            151,
            6,
            7,
            "#71958a"
        )
        rect(
            nil,
            c,
            251,
            150,
            3,
            1,
            "#b4bb92"
        )
        rect(
            nil,
            c,
            252,
            141,
            1,
            10,
            "#657453"
        )
        rect(
            nil,
            c,
            249,
            139,
            6,
            3,
            "#c85c72"
        )
        rect(
            nil,
            c,
            250,
            137,
            4,
            3,
            "#f2998a"
        )
        rect(
            nil,
            c,
            253,
            139,
            2,
            1,
            "#f8af92"
        )
    end
    local function drawDinner(self, c, s)
        if not __t(backdrop) then
            backdrop = makeBackdrop(nil)
        end
        c:save()
        c:scale(2, 2)
        c.imageSmoothingEnabled = false
        c:drawImage(backdrop, 0, 0)
        local t = s.time
        local nervous = s.phase == "breath"
        local speak = s.phase == "choice" or s.phase == "outcome"
        local lift = if __t(nervous) then math.floor(math.sin(t * 4) + 0.5) else 0
        window.Art:drawCharacter(
            c,
            "daroca",
            170,
            177 + lift,
            {
                frame = t,
                facing = 1,
                scale = 1.18,
                grounded = true,
                muscular = s.options.trained,
                talking = s.phase == "reply"
            }
        )
        window.Art:drawCharacter(
            c,
            "amanda",
            305,
            175,
            {
                frame = t,
                facing = -1,
                scale = 1.03,
                talking = speak,
                seated = true
            }
        )
        dinnerTable(nil, c, s.course, t)
        if __t(s.phase == "outcome" and __ge(s.score, 2)) then
            local y = 88 + math.floor(math.sin(t * 2) * 2 + 0.5)
            shape(
                nil,
                c,
                __arrL(
                    {
                        __arrL({234, y}, 2),
                        __arrL({237, y}, 2),
                        __arrL({239, y + 2}, 2),
                        __arrL({241, y}, 2),
                        __arrL({244, y}, 2),
                        __arrL({246, y + 2}, 2),
                        __arrL({246, y + 5}, 2),
                        __arrL({239, y + 11}, 2),
                        __arrL({232, y + 5}, 2),
                        __arrL({232, y + 2}, 2)
                    },
                    10
                ),
                "#f5ae9e"
            )
            rect(
                nil,
                c,
                234,
                y + 2,
                2,
                1,
                "#ffe5bf"
            )
        end
        c:restore()
    end
    window.AmandaArt = __ord({drawCharacter = drawCharacter, drawDinner = drawDinner}, "drawCharacter,drawDinner")
end)(nil)
return ____exports
