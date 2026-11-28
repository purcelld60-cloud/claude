--!native
--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __D = {}
local __fapply, __lt, __le, __gt, __callq, __mod, __ord, __arrL, __iterar, __t, __get, __set = __JSR.__fapply, __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__callq, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set
local __len, __call, __add, __keys, __band = __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__keys, __JSR.__band
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__ParseInt = ____lualib.__TS__ParseInt
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__Number = ____lualib.__TS__Number
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local ____t_2 = __t
    local ____t_1 = __t
    local ____temp_0 = not __t(window.Art) or not __t(window.Art.drawArena)
    __O[281] = ____temp_0
    if ____t_2(if ____t_1(____temp_0) then __O[281] else window.HdScene) then
        return
    end
    local orig = window.Art.drawArena
    local LW = 480
    local LH = 270
    local WORLD = 780
    local OFF = 150
    local FLOOR = 220
    local HANDLED = __ord({igor = true, kaique = true}, "igor,kaique")
    local function mk(____, w, h)
        local cv = window.document:createElement("canvas")
        cv.width = w
        cv.height = h
        local c = cv:getContext("2d")
        c.imageSmoothingEnabled = false
        return __arrL({cv, c}, 2)
    end
    local function hash(____, n)
        local x = math.sin(n * 127.1 + 311.7) * 43758.5453
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
    local function css(____, v, a)
        local s = (((tostring(math.floor(math.max(
            0,
            math.min(
                1,
                __get(v, 0)
            )
        ) * 255 + 0.5)) .. ",") .. tostring(math.floor(math.max(
            0,
            math.min(
                1,
                __get(v, 1)
            )
        ) * 255 + 0.5))) .. ",") .. tostring(math.floor(math.max(
            0,
            math.min(
                1,
                __get(v, 2)
            )
        ) * 255 + 0.5))
        return if a == nil then ("rgb(" .. s) .. ")" else ((("rgba(" .. s) .. ",") .. tostring(a)) .. ")"
    end
    local function hex(____, h)
        return __arrL(
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
        )
    end
    local function mix(____, a, b, k)
        return __arrL(
            {
                __get(a, 0) + (__get(b, 0) - __get(a, 0)) * k,
                __get(a, 1) + (__get(b, 1) - __get(a, 1)) * k,
                __get(a, 2) + (__get(b, 2) - __get(a, 2)) * k
            },
            3
        )
    end
    local function mul(____, a, b)
        return __arrL(
            {
                __get(a, 0) * __get(b, 0),
                __get(a, 1) * __get(b, 1),
                __get(a, 2) * __get(b, 2)
            },
            3
        )
    end
    local function active(____, ____type)
        local ____t_15 = __t
        local ____t_7 = __t
        local ____get_6 = __get
        local ____opt_result_5
        if ____type ~= nil then
            ____opt_result_5 = ____type.type
        end
        local ____temp_14 = not not ____t_7(____get_6(HANDLED, if type(____type) == "table" then ____opt_result_5 else ____type))
        if ____temp_14 then
            local ____t_13 = __t
            local ____opt_10 = window.Graphics
            if ____opt_10 ~= nil then
                ____opt_10 = ____opt_10.isLite
            end
            local ____opt_result_12
            if ____opt_10 ~= nil then
                ____opt_result_12 = ____opt_10(____opt_10)
            end
            ____temp_14 = not ____t_13(____opt_result_12)
        end
        __O[282] = ____temp_14
        return if ____t_15(____temp_14) then not not __t(window.DayTime) else __O[282]
    end
    local WINS = __ord(
        {
            igor = __arrL({}, 0),
            kaique = __arrL({}, 0)
        },
        "igor,kaique"
    )
    do
        local i = 0
        while i < 7 do
            __call(
                WINS.igor,
                "push",
                __ord({x = OFF - 40 + i * 100, y = 60, w = 65, h = 72}, "x,y,w,h")
            )
            i = i + 1
        end
    end
    do
        local i = -1
        while i < 7 do
            if i ~= 2 then
                __call(
                    WINS.kaique,
                    "push",
                    __ord({x = OFF + 10 + i * 100, y = 60, w = 65, h = 72}, "x,y,w,h")
                )
            end
            i = i + 1
        end
    end
    local CLOCK = __ord({igor = 241, kaique = 92}, "igor,kaique")
    local TITLE = __ord({igor = "CANTINA · FISCALIZAÇÃO DO LANCHE", kaique = "CORREDOR · FISCALIZAÇÃO MÁXIMA"}, "igor,kaique")
    local WIN = WINS.igor
    local cur = "igor"
    local function use(____, ____type)
        cur = if __t(__get(HANDLED, ____type)) then ____type else "igor"
        WIN = __get(WINS, cur)
    end
    local TUBES = __call(
        __arrL({
            -70,
            50,
            170,
            290,
            410,
            530
        }, 6),
        "map",
        function(____, x) return OFF + x end
    )
    local FANS = __arrL({OFF + 120, OFF + 360}, 2)
    local FRIDGE = __ord({x = OFF + 418, y = 124, w = 30, h = 96}, "x,y,w,h")
    local walls = {}
    local function buildWall(self, ____type)
        local cv, c = table.unpack(
            mk(nil, WORLD, LH),
            1,
            2
        )
        R(
            nil,
            c,
            0,
            0,
            WORLD,
            148,
            "#e4d9bd"
        )
        R(
            nil,
            c,
            0,
            13,
            WORLD,
            5,
            "#cfc3a3"
        )
        R(
            nil,
            c,
            0,
            18,
            WORLD,
            3,
            "#dacfb1"
        )
        do
            local i = 0
            while i < 1100 do
                R(
                    nil,
                    c,
                    hash(nil, i) * WORLD,
                    14 + hash(nil, i + 0.5) * 130,
                    1,
                    1,
                    if hash(nil, i * 3) > 0.5 then "#d8ccae" else "#ede4cb"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 9 do
                local x = hash(nil, i + 40) * WORLD
                local y = 22 + hash(nil, i + 60) * 90
                do
                    local k = 0
                    while k < 9 do
                        R(
                            nil,
                            c,
                            x,
                            y,
                            1,
                            1,
                            "#bfb291"
                        )
                        x = x + if hash(nil, i * 9 + k) > 0.5 then 1 else -1
                        y = y + 1
                        k = k + 1
                    end
                end
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 6 do
                local x = hash(nil, i + 80) * WORLD
                local y = 100 + hash(nil, i + 90) * 30
                c.fillStyle = "rgba(150,135,100,.10)"
                c:fillRect(
                    math.floor(x + 0.5),
                    math.floor(y + 0.5),
                    14 + math.floor(hash(nil, i) * 18 + 0.5),
                    10 + math.floor(hash(nil, i + 5) * 8 + 0.5)
                )
                i = i + 1
            end
        end
        R(
            nil,
            c,
            0,
            0,
            WORLD,
            10,
            "#2e3d47"
        )
        R(
            nil,
            c,
            0,
            10,
            WORLD,
            3,
            "#445762"
        )
        R(
            nil,
            c,
            0,
            13,
            WORLD,
            1,
            "#1f2a31"
        )
        do
            local x = 10
            while x < WORLD do
                R(
                    nil,
                    c,
                    x,
                    0,
                    6,
                    13,
                    "#243038"
                )
                R(
                    nil,
                    c,
                    x,
                    0,
                    1,
                    13,
                    "#3a4c57"
                )
                x = x + 60
            end
        end
        R(
            nil,
            c,
            0,
            148,
            WORLD,
            72,
            "#2b5b82"
        )
        local T = __arrL({"#2b5b82", "#2f6189", "#27557a", "#2d5e86"}, 4)
        do
            local ty = 0
            while ty < 9 do
                do
                    local tx = 0
                    while tx < WORLD / 8 do
                        local x = tx * 8
                        local y = 148 + ty * 8
                        local n = tx * 31 + ty * 17
                        R(
                            nil,
                            c,
                            x,
                            y,
                            8,
                            8,
                            __get(
                                T,
                                math.floor(hash(nil, n) * 4)
                            )
                        )
                        R(
                            nil,
                            c,
                            x,
                            y,
                            8,
                            1,
                            "#3d73a0"
                        )
                        R(
                            nil,
                            c,
                            x,
                            y,
                            1,
                            8,
                            "#376a94"
                        )
                        R(
                            nil,
                            c,
                            x + 7,
                            y,
                            1,
                            8,
                            "#1e4566"
                        )
                        R(
                            nil,
                            c,
                            x,
                            y + 7,
                            8,
                            1,
                            "#1e4566"
                        )
                        if hash(nil, n + 7) > 0.93 then
                            R(
                                nil,
                                c,
                                x + 2,
                                y + 2,
                                3,
                                1,
                                "#5c8fb8"
                            )
                        end
                        if hash(nil, n + 3) > 0.975 then
                            R(
                                nil,
                                c,
                                x + 4,
                                y + 4,
                                3,
                                3,
                                "#1b3d59"
                            )
                            R(
                                nil,
                                c,
                                x + 5,
                                y + 3,
                                1,
                                1,
                                "#1b3d59"
                            )
                        end
                        tx = tx + 1
                    end
                end
                ty = ty + 1
            end
        end
        do
            local tx = 0
            while tx < WORLD / 8 do
                local x = tx * 8
                R(
                    nil,
                    c,
                    x,
                    156,
                    8,
                    8,
                    if __t(__mod(tx, 2)) then "#e9dfc0" else "#d79a4a"
                )
                R(
                    nil,
                    c,
                    x,
                    156,
                    8,
                    1,
                    if __t(__mod(tx, 2)) then "#fff8e0" else "#eab768"
                )
                R(
                    nil,
                    c,
                    x + 7,
                    156,
                    1,
                    8,
                    if __t(__mod(tx, 2)) then "#bdb18f" else "#a8722f"
                )
                R(
                    nil,
                    c,
                    x,
                    163,
                    8,
                    1,
                    if __t(__mod(tx, 2)) then "#bdb18f" else "#a8722f"
                )
                tx = tx + 1
            end
        end
        R(
            nil,
            c,
            0,
            143,
            WORLD,
            1,
            "#fffbe6"
        )
        R(
            nil,
            c,
            0,
            144,
            WORLD,
            4,
            "#f1ead0"
        )
        R(
            nil,
            c,
            0,
            148,
            WORLD,
            1,
            "#b9ad8c"
        )
        R(
            nil,
            c,
            0,
            213,
            WORLD,
            7,
            "#1d3f5c"
        )
        R(
            nil,
            c,
            0,
            213,
            WORLD,
            1,
            "#3a6f98"
        )
        local rows = __arrL({
            5,
            6,
            8,
            9,
            10,
            12
        }, 6)
        local fy = FLOOR
        __call(
            rows,
            "forEach",
            function(____, rh, r)
                local tw = 22 + r * 5
                local mid = WORLD / 2
                local n0 = -math.ceil(mid / tw) - 1
                do
                    local k = n0
                    while k <= -n0 do
                        local x = mid + k * tw
                        local light = __band(k + r, 1)
                        local shade = r / 5
                        R(
                            nil,
                            c,
                            x,
                            fy,
                            tw,
                            rh,
                            if __t(light) then css(
                                nil,
                                mix(
                                    nil,
                                    hex(nil, "#b4c3bc"),
                                    hex(nil, "#d2ddd4"),
                                    shade
                                )
                            ) else css(
                                nil,
                                mix(
                                    nil,
                                    hex(nil, "#8ea39d"),
                                    hex(nil, "#a9bbb5"),
                                    shade
                                )
                            )
                        )
                        R(
                            nil,
                            c,
                            x,
                            fy,
                            tw,
                            1,
                            if __t(light) then "#dfe8df" else "#b5c5bf"
                        )
                        R(
                            nil,
                            c,
                            x,
                            fy,
                            1,
                            rh,
                            "#7f948f"
                        )
                        if hash(nil, k * 13 + r * 7) > 0.86 then
                            R(
                                nil,
                                c,
                                x + 3 + hash(nil, k + r) * (tw - 8),
                                fy + 2,
                                3,
                                1,
                                "rgba(60,80,76,.35)"
                            )
                        end
                        k = k + 1
                    end
                end
                fy = fy + rh
            end
        )
        R(
            nil,
            c,
            0,
            FLOOR,
            WORLD,
            1,
            "#eef0dc"
        )
        do
            local i = 0
            while i < 4 do
                c.fillStyle = ("rgba(20,36,44," .. tostring(0.22 - i * 0.05)) .. ")"
                c:fillRect(0, FLOOR + 1 + i, WORLD, 1)
                i = i + 1
            end
        end
        for ____, w in __iterar((WIN)) do
            R(
                nil,
                c,
                w.x - 5,
                w.y - 5,
                w.w + 10,
                w.h + 10,
                "#1f3f50"
            )
            R(
                nil,
                c,
                w.x - 4,
                w.y - 4,
                w.w + 8,
                w.h + 8,
                "#3b6c80"
            )
            R(
                nil,
                c,
                w.x - 4,
                w.y - 4,
                w.w + 8,
                1,
                "#5b93a8"
            )
            R(
                nil,
                c,
                w.x - 4,
                w.y - 4,
                1,
                w.h + 8,
                "#4f8498"
            )
            R(
                nil,
                c,
                w.x - 1,
                w.y - 1,
                w.w + 2,
                w.h + 2,
                "#16303c"
            )
            c:clearRect(w.x, w.y, w.w, w.h)
            do
                local yy = 0
                while __lt(yy, w.h) do
                    c.fillStyle = "rgba(255,255,255,.10)"
                    c:fillRect(
                        w.x + 8 + math.floor((w.h - yy) * 0.35 + 0.5),
                        w.y + yy,
                        7,
                        1
                    )
                    c.fillStyle = "rgba(255,255,255,.07)"
                    c:fillRect(
                        w.x + 22 + math.floor((w.h - yy) * 0.35 + 0.5),
                        w.y + yy,
                        3,
                        1
                    )
                    yy = yy + 1
                end
            end
            R(
                nil,
                c,
                w.x + 31,
                w.y,
                3,
                w.h,
                "#e9ecd8"
            )
            R(
                nil,
                c,
                w.x + 33,
                w.y,
                1,
                w.h,
                "#b3bdaa"
            )
            R(
                nil,
                c,
                w.x,
                w.y + 24,
                w.w,
                3,
                "#e9ecd8"
            )
            R(
                nil,
                c,
                w.x,
                w.y + 26,
                w.w,
                1,
                "#b3bdaa"
            )
            do
                local k = 0
                while __lt(k, w.w) do
                    local red = __band(k / 3, 1)
                    R(
                        nil,
                        c,
                        w.x + k,
                        w.y,
                        3,
                        3,
                        if __t(red) then "#c9473d" else "#f3ead6"
                    )
                    R(
                        nil,
                        c,
                        w.x + k,
                        w.y + 3,
                        3,
                        3,
                        if __t(red) then "#f3ead6" else "#c9473d"
                    )
                    R(
                        nil,
                        c,
                        w.x + k,
                        w.y + 6,
                        3,
                        if __mod(k / 3, 4) < 2 then 2 else 1,
                        if __t(red) then "#a8362e" else "#d9cfb8"
                    )
                    k = k + 3
                end
            end
            R(
                nil,
                c,
                w.x - 8,
                __add(w.y, w.h) + 5,
                w.w + 16,
                4,
                "#eef0dc"
            )
            R(
                nil,
                c,
                w.x - 8,
                __add(w.y, w.h) + 5,
                w.w + 16,
                1,
                "#ffffff"
            )
            R(
                nil,
                c,
                w.x - 8,
                __add(w.y, w.h) + 9,
                w.w + 16,
                2,
                "#a9b3a0"
            )
            c.fillStyle = "rgba(0,0,0,.13)"
            c:fillRect(
                w.x - 6,
                __add(w.y, w.h) + 11,
                w.w + 12,
                2
            )
        end
        local POST = __arrL(
            {
                __arrL({"#e8c25a", "#b5533c"}, 2),
                __arrL({"#8fc0a0", "#2d6a55"}, 2),
                __arrL({"#e9e2c8", "#3b6c96"}, 2),
                __arrL({"#d9c8e8", "#5a3f8c"}, 2),
                __arrL({"#f0b9a0", "#8c3f4f"}, 2),
                __arrL({"#b9d3e8", "#34577a"}, 2)
            },
            6
        )
        __call(
            POST,
            "forEach",
            function(____, p, i)
                if __t(not __t(__get(WIN, i + 1)) or __get(WIN, i + 1).x - __get(WIN, i).x > 110) then
                    return
                end
                local gx = __add(
                    __get(WIN, i).x,
                    __get(WIN, i).w
                ) + 17 - OFF
                if math.abs(gx - __get(CLOCK, ____type)) < 14 then
                    return
                end
                local x = __add(
                    __get(WIN, i).x,
                    __get(WIN, i).w
                ) + 9
                local y = 76 + __mod(i, 2) * 5
                R(
                    nil,
                    c,
                    x - 1,
                    y - 1,
                    19,
                    27,
                    "#8a7d62"
                )
                R(
                    nil,
                    c,
                    x,
                    y,
                    17,
                    25,
                    __get(p, 0)
                )
                R(
                    nil,
                    c,
                    x + 2,
                    y + 2,
                    13,
                    3,
                    __get(p, 1)
                )
                do
                    local k = 0
                    while k < 4 do
                        R(
                            nil,
                            c,
                            x + 2,
                            y + 8 + k * 4,
                            6 + math.floor(hash(nil, i * 5 + k) * 7 + 0.5),
                            1,
                            __get(p, 1)
                        )
                        k = k + 1
                    end
                end
                R(
                    nil,
                    c,
                    x + 6,
                    y + 19,
                    5,
                    4,
                    __get(p, 1)
                )
                R(
                    nil,
                    c,
                    x + 8,
                    y - 2,
                    1,
                    2,
                    "#c94f45"
                )
            end
        )
        local sx = OFF + 62
        for ____, cx in __iterar((__arrL({sx + 24, sx + 330}, 2))) do
            do
                local y = 13
                while y < 21 do
                    R(
                        nil,
                        c,
                        cx,
                        y,
                        1,
                        1,
                        "#8b98a0"
                    )
                    y = y + 2
                end
            end
        end
        R(
            nil,
            c,
            sx - 3,
            19,
            361,
            30,
            "#16324c"
        )
        R(
            nil,
            c,
            sx - 2,
            20,
            359,
            28,
            "#f5efd6"
        )
        R(
            nil,
            c,
            sx,
            22,
            355,
            24,
            "#1f4467"
        )
        R(
            nil,
            c,
            sx,
            22,
            355,
            1,
            "#3b6c96"
        )
        R(
            nil,
            c,
            sx,
            45,
            355,
            1,
            "#16324c"
        )
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({sx + 2, 24}, 2),
                __arrL({sx + 351, 24}, 2),
                __arrL({sx + 2, 42}, 2),
                __arrL({sx + 351, 42}, 2)
            },
            4
        ))) do
            local bx = ____value[1]
            local by = ____value[2]
            R(
                nil,
                c,
                bx,
                by,
                2,
                2,
                "#d7b45a"
            )
        end
        for ____, x in __iterar((TUBES)) do
            R(
                nil,
                c,
                x - 2,
                12,
                48,
                4,
                "#55656e"
            )
            R(
                nil,
                c,
                x - 2,
                12,
                48,
                1,
                "#738790"
            )
            R(
                nil,
                c,
                x + 4,
                9,
                1,
                3,
                "#1f2a31"
            )
            R(
                nil,
                c,
                x + 39,
                9,
                1,
                3,
                "#1f2a31"
            )
        end
        if ____type == "igor" then
            local bx = OFF + 32
            R(
                nil,
                c,
                bx,
                160,
                105,
                60,
                "#a8845c"
            )
            do
                local k = 0
                while k < 105 do
                    R(
                        nil,
                        c,
                        bx + k,
                        160,
                        1,
                        60,
                        "#8a6a47"
                    )
                    R(
                        nil,
                        c,
                        bx + k + 1,
                        160,
                        1,
                        60,
                        "#b99468"
                    )
                    k = k + 7
                end
            end
            do
                local i = 0
                while i < 26 do
                    R(
                        nil,
                        c,
                        bx + 2 + hash(nil, i + 200) * 100,
                        162 + hash(nil, i + 220) * 54,
                        2 + math.floor(hash(nil, i) * 3 + 0.5),
                        1,
                        "#92714d"
                    )
                    i = i + 1
                end
            end
            R(
                nil,
                c,
                bx - 3,
                153,
                111,
                7,
                "#ecdcb0"
            )
            R(
                nil,
                c,
                bx - 3,
                153,
                111,
                1,
                "#fff6d6"
            )
            R(
                nil,
                c,
                bx - 3,
                159,
                111,
                1,
                "#b7a57a"
            )
            c.fillStyle = "rgba(0,0,0,.20)"
            c:fillRect(bx, 160, 105, 3)
            R(
                nil,
                c,
                bx + 5,
                168,
                95,
                13,
                "#6f573c"
            )
            R(
                nil,
                c,
                bx + 6,
                169,
                93,
                11,
                "#7c6348"
            )
            R(
                nil,
                c,
                bx + 6,
                169,
                93,
                1,
                "#927757"
            )
            R(
                nil,
                c,
                bx + 8,
                131,
                66,
                22,
                "#cfd8d0"
            )
            R(
                nil,
                c,
                bx + 9,
                132,
                64,
                20,
                "#3a4a4c"
            )
            R(
                nil,
                c,
                bx + 9,
                132,
                64,
                1,
                "#eef4ee"
            )
            R(
                nil,
                c,
                bx + 10,
                141,
                62,
                1,
                "#9aa7a0"
            )
            do
                local k = 0
                while k < 7 do
                    local px = bx + 12 + k * 9
                    R(
                        nil,
                        c,
                        px,
                        135,
                        6,
                        5,
                        "#d8943f"
                    )
                    R(
                        nil,
                        c,
                        px + 1,
                        134,
                        4,
                        1,
                        "#e9b25e"
                    )
                    R(
                        nil,
                        c,
                        px + 2,
                        133,
                        2,
                        1,
                        "#e9b25e"
                    )
                    R(
                        nil,
                        c,
                        px + 1,
                        139,
                        4,
                        1,
                        "#a9692a"
                    )
                    R(
                        nil,
                        c,
                        px,
                        144,
                        7,
                        4,
                        if __t(__mod(k, 2)) then "#e2c27a" else "#c98a4a"
                    )
                    R(
                        nil,
                        c,
                        px,
                        144,
                        7,
                        1,
                        "#f1dca0"
                    )
                    k = k + 1
                end
            end
            c.fillStyle = "rgba(210,235,240,.22)"
            c:fillRect(bx + 9, 132, 64, 20)
            c.fillStyle = "rgba(255,255,255,.25)"
            do
                local yy = 0
                while yy < 20 do
                    c:fillRect(
                        bx + 16 + math.floor((20 - yy) * 0.5 + 0.5),
                        132 + yy,
                        3,
                        1
                    )
                    yy = yy + 1
                end
            end
            R(
                nil,
                c,
                bx + 80,
                143,
                4,
                10,
                "#c5382f"
            )
            R(
                nil,
                c,
                bx + 81,
                141,
                2,
                2,
                "#e8e0d0"
            )
            R(
                nil,
                c,
                bx + 86,
                143,
                4,
                10,
                "#e2b93a"
            )
            R(
                nil,
                c,
                bx + 87,
                141,
                2,
                2,
                "#e8e0d0"
            )
            R(
                nil,
                c,
                bx + 93,
                146,
                9,
                7,
                "#dfe6e2"
            )
            R(
                nil,
                c,
                bx + 94,
                144,
                7,
                2,
                "#f7faf6"
            )
            local rx = OFF + 347
            R(
                nil,
                c,
                rx,
                162,
                70,
                58,
                "#6a909c"
            )
            R(
                nil,
                c,
                rx,
                162,
                70,
                1,
                "#8fb3be"
            )
            do
                local k = 0
                while k < 70 do
                    R(
                        nil,
                        c,
                        rx + k,
                        163,
                        1,
                        57,
                        "#557985"
                    )
                    k = k + 23
                end
            end
            R(
                nil,
                c,
                rx + 4,
                168,
                62,
                13,
                "#4c6f7b"
            )
            R(
                nil,
                c,
                rx + 5,
                169,
                60,
                11,
                "#5b818d"
            )
            R(
                nil,
                c,
                rx - 3,
                155,
                76,
                7,
                "#d9e1d6"
            )
            R(
                nil,
                c,
                rx - 3,
                155,
                76,
                1,
                "#ffffff"
            )
            R(
                nil,
                c,
                rx - 3,
                161,
                76,
                1,
                "#96a39c"
            )
            c.fillStyle = "rgba(0,0,0,.20)"
            c:fillRect(rx, 162, 70, 3)
            for ____, ____value in __iterar((__arrL(
                {
                    __arrL({rx + 8, "#e8973a", "#f4bd6a"}, 3),
                    __arrL({rx + 26, "#8e4aa8", "#b77fd0"}, 3)
                },
                2
            ))) do
                local jx = ____value[1]
                local col = ____value[2]
                local col2 = ____value[3]
                R(
                    nil,
                    c,
                    jx,
                    150,
                    14,
                    5,
                    "#39464c"
                )
                R(
                    nil,
                    c,
                    jx + 1,
                    130,
                    12,
                    20,
                    "#cfe3e6"
                )
                R(
                    nil,
                    c,
                    jx + 2,
                    135,
                    10,
                    15,
                    col
                )
                R(
                    nil,
                    c,
                    jx + 2,
                    135,
                    10,
                    1,
                    col2
                )
                R(
                    nil,
                    c,
                    jx + 3,
                    131,
                    2,
                    18,
                    "rgba(255,255,255,.45)"
                )
                R(
                    nil,
                    c,
                    jx,
                    127,
                    14,
                    3,
                    "#39464c"
                )
                R(
                    nil,
                    c,
                    jx + 6,
                    151,
                    2,
                    3,
                    "#aab6ba"
                )
            end
            do
                local k = 0
                while k < 4 do
                    R(
                        nil,
                        c,
                        rx + 46 + k * 5,
                        149 - __mod(k, 2),
                        4,
                        6 + __mod(k, 2),
                        if __t(__mod(k, 2)) then "#e9e2c8" else "#c9dfe6"
                    )
                    k = k + 1
                end
            end
            local f = FRIDGE
            R(
                nil,
                c,
                f.x - 1,
                f.y - 1,
                f.w + 2,
                f.h + 1,
                "#27343a"
            )
            R(
                nil,
                c,
                f.x,
                f.y,
                f.w,
                f.h,
                "#dfe6e2"
            )
            R(
                nil,
                c,
                f.x,
                f.y,
                f.w,
                9,
                "#c2433a"
            )
            R(
                nil,
                c,
                f.x,
                f.y + 8,
                f.w,
                1,
                "#8e2c26"
            )
            R(
                nil,
                c,
                f.x + 3,
                f.y + 12,
                f.w - 6,
                f.h - 26,
                "#10222a"
            )
            do
                local s = 0
                while s < 4 do
                    local yy = f.y + 14 + s * 17
                    R(
                        nil,
                        c,
                        f.x + 3,
                        yy + 14,
                        f.w - 6,
                        1,
                        "#8fa1a6"
                    )
                    do
                        local k = 0
                        while k < 5 do
                            local col = __get(
                                __arrL({
                                    "#e04a3a",
                                    "#3aa655",
                                    "#e8b33a",
                                    "#3a7fd0",
                                    "#e07a2a"
                                }, 5),
                                __mod(k + s, 5)
                            )
                            R(
                                nil,
                                c,
                                f.x + 5 + k * 4,
                                yy + 4,
                                3,
                                10,
                                col
                            )
                            R(
                                nil,
                                c,
                                f.x + 6 + k * 4,
                                yy + 2,
                                1,
                                2,
                                "#e9eef0"
                            )
                            R(
                                nil,
                                c,
                                f.x + 5 + k * 4,
                                yy + 8,
                                3,
                                2,
                                "#f1efe2"
                            )
                            k = k + 1
                        end
                    end
                    s = s + 1
                end
            end
            c.fillStyle = "rgba(190,235,245,.16)"
            c:fillRect(f.x + 3, f.y + 12, f.w - 6, f.h - 26)
            R(
                nil,
                c,
                f.x + f.w - 5,
                f.y + 40,
                2,
                16,
                "#f7faf6"
            )
            R(
                nil,
                c,
                f.x,
                f.y + f.h - 12,
                f.w,
                12,
                "#b9c3bf"
            )
            do
                local k = 0
                while k < 6 do
                    R(
                        nil,
                        c,
                        f.x + 4,
                        f.y + f.h - 10 + k * 2,
                        f.w - 8,
                        1,
                        "#7d8a86"
                    )
                    k = k + 1
                end
            end
        else
            local function locker(____, x, n)
                R(
                    nil,
                    c,
                    x - 1,
                    149,
                    28,
                    71,
                    "#22394a"
                )
                R(
                    nil,
                    c,
                    x,
                    150,
                    26,
                    70,
                    "#5c8ca2"
                )
                R(
                    nil,
                    c,
                    x,
                    150,
                    26,
                    1,
                    "#86b4c6"
                )
                R(
                    nil,
                    c,
                    x,
                    150,
                    1,
                    70,
                    "#7aa6b8"
                )
                R(
                    nil,
                    c,
                    x + 25,
                    150,
                    1,
                    70,
                    "#3f6a80"
                )
                R(
                    nil,
                    c,
                    x + 3,
                    154,
                    20,
                    62,
                    "#6f9db0"
                )
                R(
                    nil,
                    c,
                    x + 3,
                    154,
                    20,
                    1,
                    "#8fbccb"
                )
                R(
                    nil,
                    c,
                    x + 22,
                    154,
                    1,
                    62,
                    "#4f7f94"
                )
                do
                    local v = 0
                    while v < 4 do
                        R(
                            nil,
                            c,
                            x + 6,
                            158 + v * 3,
                            14,
                            1,
                            "#31566b"
                        )
                        v = v + 1
                    end
                end
                R(
                    nil,
                    c,
                    x + 8,
                    173,
                    10,
                    5,
                    "#e3dfc1"
                )
                R(
                    nil,
                    c,
                    x + 9,
                    174,
                    8,
                    1,
                    "#8a8468"
                )
                R(
                    nil,
                    c,
                    x + 19,
                    186,
                    2,
                    7,
                    "#d9e1d6"
                )
                R(
                    nil,
                    c,
                    x + 19,
                    192,
                    2,
                    1,
                    "#8fa1a6"
                )
                if __mod(n, 3) == 0 then
                    R(
                        nil,
                        c,
                        x + 6,
                        198,
                        6,
                        6,
                        "#e8c23a"
                    )
                    R(
                        nil,
                        c,
                        x + 7,
                        199,
                        4,
                        1,
                        "#fff3a8"
                    )
                end
                if __mod(n, 3) == 1 then
                    R(
                        nil,
                        c,
                        x + 12,
                        201,
                        7,
                        5,
                        "#e04a3a"
                    )
                    R(
                        nil,
                        c,
                        x + 13,
                        202,
                        2,
                        2,
                        "#ffffff"
                    )
                end
                if __mod(n, 4) == 2 then
                    do
                        local d = 0
                        while d < 5 do
                            R(
                                nil,
                                c,
                                x + 5 + d * 3,
                                208 + __mod(d, 2),
                                2,
                                1,
                                "#3f6a80"
                            )
                            d = d + 1
                        end
                    end
                end
            end
            do
                local n = 0
                while n < 3 do
                    locker(nil, OFF + 22 + n * 27, n)
                    locker(nil, OFF + 378 + n * 27, n + 3)
                    n = n + 1
                end
            end
            R(
                nil,
                c,
                OFF + 30,
                141,
                12,
                8,
                "#c9573f"
            )
            R(
                nil,
                c,
                OFF + 30,
                141,
                12,
                1,
                "#e88a6a"
            )
            R(
                nil,
                c,
                OFF + 44,
                143,
                14,
                6,
                "#3b6c96"
            )
            R(
                nil,
                c,
                OFF + 44,
                143,
                14,
                1,
                "#6a9cc4"
            )
            R(
                nil,
                c,
                OFF + 430,
                139,
                10,
                10,
                "#e07a2a"
            )
            R(
                nil,
                c,
                OFF + 432,
                141,
                6,
                1,
                "#2a1e18"
            )
            R(
                nil,
                c,
                OFF + 434,
                139,
                1,
                10,
                "#2a1e18"
            )
            local qx = OFF + 177
            R(
                nil,
                c,
                qx - 3,
                59,
                136,
                78,
                "#5a4030"
            )
            R(
                nil,
                c,
                qx - 2,
                60,
                134,
                76,
                "#8a6a47"
            )
            R(
                nil,
                c,
                qx - 2,
                60,
                134,
                1,
                "#b08a5c"
            )
            R(
                nil,
                c,
                qx,
                62,
                130,
                72,
                "#2f5f4a"
            )
            R(
                nil,
                c,
                qx,
                62,
                130,
                1,
                "#244a3a"
            )
            do
                local i = 0
                while i < 160 do
                    R(
                        nil,
                        c,
                        qx + 2 + hash(nil, i + 900) * 126,
                        64 + hash(nil, i + 910) * 68,
                        2,
                        1,
                        if hash(nil, i) > 0.5 then "#3a705a" else "#295442"
                    )
                    i = i + 1
                end
            end
            R(
                nil,
                c,
                qx + 6,
                126,
                16,
                3,
                "#f3f0e2"
            )
            R(
                nil,
                c,
                qx + 26,
                127,
                8,
                2,
                "#f0c8d0"
            )
            R(
                nil,
                c,
                qx + 104,
                125,
                18,
                5,
                "#c9b28a"
            )
            R(
                nil,
                c,
                qx + 105,
                126,
                16,
                2,
                "#e8dcc0"
            )
            R(
                nil,
                c,
                qx + 58,
                48,
                14,
                9,
                "#3a2a2a"
            )
            R(
                nil,
                c,
                qx + 60,
                44,
                10,
                6,
                "#7a1a1a"
            )
            for ____, bx2 in __iterar((__arrL({OFF + 150, OFF + 322}, 2))) do
                R(
                    nil,
                    c,
                    bx2,
                    200,
                    16,
                    20,
                    "#39464c"
                )
                do
                    local k = 0
                    while k < 16 do
                        R(
                            nil,
                            c,
                            bx2 + k,
                            201,
                            1,
                            18,
                            "#6f8088"
                        )
                        k = k + 3
                    end
                end
                R(
                    nil,
                    c,
                    bx2 - 1,
                    199,
                    18,
                    2,
                    "#8fa1a6"
                )
                R(
                    nil,
                    c,
                    bx2 + 3,
                    195,
                    5,
                    5,
                    "#f1ecdf"
                )
                R(
                    nil,
                    c,
                    bx2 + 9,
                    196,
                    4,
                    4,
                    "#e3ddcc"
                )
            end
        end
        R(
            nil,
            c,
            OFF + 4,
            198,
            14,
            22,
            "#3f8a52"
        )
        R(
            nil,
            c,
            OFF + 3,
            195,
            16,
            4,
            "#57a86a"
        )
        R(
            nil,
            c,
            OFF + 8,
            204,
            6,
            6,
            "#e9f2e0"
        )
        R(
            nil,
            c,
            OFF + 462,
            176,
            12,
            44,
            "#cfd8dc"
        )
        R(
            nil,
            c,
            OFF + 462,
            176,
            12,
            1,
            "#ffffff"
        )
        R(
            nil,
            c,
            OFF + 463,
            160,
            10,
            16,
            "#7ec3e6"
        )
        R(
            nil,
            c,
            OFF + 464,
            162,
            2,
            12,
            "#c9ecfa"
        )
        R(
            nil,
            c,
            OFF + 466,
            190,
            4,
            3,
            "#39464c"
        )
        c.fillStyle = "rgba(15,30,36,.25)"
        for ____, ____value in __iterar((if ____type == "igor" then __arrL(
            {
                __arrL({OFF + 30, 109}, 2),
                __arrL({OFF + 345, 74}, 2),
                __arrL({FRIDGE.x - 2, FRIDGE.w + 4}, 2),
                __arrL({OFF + 3, 16}, 2),
                __arrL({OFF + 461, 14}, 2)
            },
            5
        ) else __arrL(
            {
                __arrL({OFF + 21, 83}, 2),
                __arrL({OFF + 377, 83}, 2),
                __arrL({OFF + 3, 16}, 2),
                __arrL({OFF + 461, 14}, 2),
                __arrL({OFF + 149, 18}, 2),
                __arrL({OFF + 321, 18}, 2)
            },
            6
        ))) do
            local x0 = ____value[1]
            local w0 = ____value[2]
            c:fillRect(x0, FLOOR, w0, 2)
            c:fillRect(x0 + 2, FLOOR + 2, w0 - 4, 1)
        end
        return cv
    end
    local function wallLayer(self)
        local s = __callq(
            window.Sprites,
            "get",
            __add(
                __add("arena-", cur),
                "-parede"
            )
        )
        if __t(s) then
            return s.img
        end
        if not __t(__get(walls, cur)) then
            __set(
                walls,
                cur,
                buildWall(nil, cur)
            )
        end
        return __get(walls, cur)
    end
    local SKIN = __arrL({
        "#f0c8a0",
        "#c8946a",
        "#8a5a3c",
        "#e0aa80",
        "#6e452e"
    }, 5)
    local HAIR = __arrL({
        "#2a1e18",
        "#4a2e1c",
        "#161616",
        "#7a4a24",
        "#d8b25a"
    }, 5)
    local SHIRT = __arrL({
        "#e04a3a",
        "#3a7fd0",
        "#e8c23a",
        "#3aa655",
        "#f0f0f0",
        "#9a5ac8"
    }, 6)
    local function pixelDisc(self, c, cx, cy, r, col)
        c.fillStyle = col
        do
            local y = __TS__Number(-r)
            while __le(y, r) do
                local w = math.floor(math.sqrt(r * r - y * y) + 0.5)
                c:fillRect(
                    math.floor(cx - w + 0.5),
                    math.floor(cy + y + 0.5),
                    w * 2 + 1,
                    1
                )
                y = y + 1
            end
        end
    end
    local function outdoor(self, c, s, t, ox)
        local function pre(____, v)
            return __arrL(
                {
                    math.min(
                        1,
                        __get(v, 0) / __get(s.amb, 0)
                    ),
                    math.min(
                        1,
                        __get(v, 1) / __get(s.amb, 1)
                    ),
                    math.min(
                        1,
                        __get(v, 2) / __get(s.amb, 2)
                    )
                },
                3
            )
        end
        local day = 1 - s.night
        local light = mix(
            nil,
            __arrL({0.34, 0.4, 0.62}, 3),
            __arrL({1, 1, 1}, 3),
            day
        )
        do
            local i = 0
            while i < 18 do
                local k = i / 17
                local col = pre(
                    nil,
                    mix(nil, s.top, s.bot, k * k * 0.4 + k * 0.6)
                )
                R(
                    nil,
                    c,
                    0,
                    50 + i * 5,
                    LW,
                    5,
                    css(nil, col)
                )
                i = i + 1
            end
        end
        if __gt(s.night, 0.25) then
            do
                local i = 0
                while i < 70 do
                    local tw = 0.5 + 0.5 * math.sin(t * (1 + hash(nil, i) * 2) + i)
                    c.fillStyle = ("rgba(255,255,255," .. tostring((s.night - 0.25) * 1.3 * (0.4 + 0.6 * tw) * (0.5 + hash(nil, i + 9) * 0.5))) .. ")"
                    c:fillRect(
                        math.floor(__mod(
                            hash(nil, i + 300) * 520 + ox * 0.04,
                            480
                        ) + 0.5),
                        52 + math.floor(hash(nil, i + 400) * 62 + 0.5),
                        1,
                        1
                    )
                    i = i + 1
                end
            end
        end
        if s.sunT ~= nil then
            local x = 30 + s.sunT * 420 + ox * 0.05
            local y = 136 - math.sin(s.sunT * math.pi) * 70
            pixelDisc(
                nil,
                c,
                x,
                y,
                13,
                css(
                    nil,
                    pre(nil, s.sun),
                    0.18
                )
            )
            pixelDisc(
                nil,
                c,
                x,
                y,
                10,
                css(
                    nil,
                    pre(nil, s.sun),
                    0.35
                )
            )
            pixelDisc(
                nil,
                c,
                x,
                y,
                7,
                css(
                    nil,
                    pre(
                        nil,
                        mix(
                            nil,
                            s.sun,
                            __arrL({1, 1, 1}, 3),
                            0.55
                        )
                    )
                )
            )
        end
        if s.moonT ~= nil then
            local x = 40 + s.moonT * 400 + ox * 0.05
            local y = 128 - math.sin(s.moonT * math.pi) * 58
            pixelDisc(
                nil,
                c,
                x,
                y,
                9,
                "rgba(200,215,255,.16)"
            )
            pixelDisc(
                nil,
                c,
                x,
                y,
                6,
                "#ffffff"
            )
            R(
                nil,
                c,
                x - 3,
                y - 2,
                2,
                2,
                "#c9d4f0"
            )
            R(
                nil,
                c,
                x + 1,
                y + 2,
                2,
                1,
                "#c9d4f0"
            )
            R(
                nil,
                c,
                x + 2,
                y - 3,
                1,
                1,
                "#c9d4f0"
            )
        end
        local cloud = pre(
            nil,
            mix(
                nil,
                mix(
                    nil,
                    s.bot,
                    __arrL({1, 1, 1}, 3),
                    0.55 * day + 0.1
                ),
                s.top,
                s.night * 0.5
            )
        )
        do
            local i = 0
            while i < 6 do
                local x = __mod(
                    hash(nil, i + 20) * 620 + t * (2 + hash(nil, i) * 3),
                    620
                ) - 70 + ox * 0.08
                local y = 58 + hash(nil, i + 30) * 40
                local w = 28 + hash(nil, i + 31) * 26
                c.fillStyle = css(nil, cloud, 0.85)
                c:fillRect(
                    math.floor(x + 0.5),
                    math.floor(y + 0.5),
                    math.floor(w + 0.5),
                    4
                )
                c:fillRect(
                    math.floor(x + 5 + 0.5),
                    math.floor(y - 3 + 0.5),
                    math.floor(w - 12 + 0.5),
                    3
                )
                c:fillRect(
                    math.floor(x + 10 + 0.5),
                    math.floor(y - 5 + 0.5),
                    math.floor(w * 0.4 + 0.5),
                    2
                )
                c.fillStyle = css(
                    nil,
                    mul(
                        nil,
                        cloud,
                        __arrL({0.86, 0.88, 0.95}, 3)
                    ),
                    0.85
                )
                c:fillRect(
                    math.floor(x + 3 + 0.5),
                    math.floor(y + 4 + 0.5),
                    math.floor(w - 8 + 0.5),
                    1
                )
                i = i + 1
            end
        end
        local far = pre(
            nil,
            mix(
                nil,
                s.bot,
                mul(
                    nil,
                    __arrL({0.28, 0.34, 0.5}, 3),
                    light
                ),
                0.6
            )
        )
        do
            local i = 0
            while i < 34 do
                local bw = 12 + math.floor(hash(nil, i + 50) * 16 + 0.5)
                local bh = 14 + math.floor(hash(nil, i + 60) * 34 + 0.5)
                local x = math.floor(i * 19 - 80 + ox * 0.15 + 0.5)
                local y = 133 - bh
                R(
                    nil,
                    c,
                    x,
                    y,
                    bw,
                    bh,
                    css(nil, far)
                )
                R(
                    nil,
                    c,
                    x,
                    y,
                    1,
                    bh,
                    css(
                        nil,
                        mix(
                            nil,
                            far,
                            pre(nil, s.sun),
                            0.25 * day
                        )
                    )
                )
                if hash(nil, i + 70) > 0.6 then
                    R(
                        nil,
                        c,
                        x + 3,
                        y - 4,
                        1,
                        4,
                        css(nil, far)
                    )
                end
                do
                    local wy = 3
                    while wy < bh - 3 do
                        do
                            local wx = 2
                            while wx < bw - 2 do
                                local lit = hash(nil, i * 31 + wx * 7 + wy) > 0.55
                                if __t(if __t(lit) then __gt(s.night, 0.3) else lit) then
                                    R(
                                        nil,
                                        c,
                                        x + wx,
                                        y + wy,
                                        2,
                                        2,
                                        ((("rgba(255," .. tostring(200 + math.floor(hash(nil, wx + wy) * 50 + 0.5))) .. ",120,") .. tostring(math.min(1, (s.night - 0.3) * 2))) .. ")"
                                    )
                                else
                                    R(
                                        nil,
                                        c,
                                        x + wx,
                                        y + wy,
                                        2,
                                        2,
                                        css(
                                            nil,
                                            mul(
                                                nil,
                                                far,
                                                __arrL({0.82, 0.86, 0.92}, 3)
                                            )
                                        )
                                    )
                                end
                                wx = wx + 4
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
            while i < 12 do
                local x = math.floor(i * 52 - 60 + ox * 0.35 + hash(nil, i + 90) * 20 + 0.5)
                local sway = math.floor(math.sin(t * 1.3 + i * 1.7) * 1.5 + 0.5)
                local g = pre(
                    nil,
                    mul(
                        nil,
                        hex(nil, if __t(__mod(i, 2)) then "#3f7a45" else "#4f8f4a"),
                        light
                    )
                )
                local g2 = pre(
                    nil,
                    mul(
                        nil,
                        hex(nil, "#6aa85a"),
                        light
                    )
                )
                local g3 = pre(
                    nil,
                    mul(
                        nil,
                        hex(nil, "#2c5a36"),
                        light
                    )
                )
                R(
                    nil,
                    c,
                    x + 9,
                    112,
                    3,
                    22,
                    css(
                        nil,
                        pre(
                            nil,
                            mul(
                                nil,
                                hex(nil, "#5a4030"),
                                light
                            )
                        )
                    )
                )
                pixelDisc(
                    nil,
                    c,
                    x + 10 + sway,
                    104,
                    12,
                    css(nil, g)
                )
                pixelDisc(
                    nil,
                    c,
                    x + 3 + sway,
                    110,
                    8,
                    css(nil, g3)
                )
                pixelDisc(
                    nil,
                    c,
                    x + 17 + sway,
                    109,
                    8,
                    css(nil, g)
                )
                pixelDisc(
                    nil,
                    c,
                    x + 7 + sway * 1.5,
                    99,
                    6,
                    css(nil, g2)
                )
                i = i + 1
            end
        end
        local wallCol = pre(
            nil,
            mul(
                nil,
                hex(nil, "#b9a98a"),
                light
            )
        )
        R(
            nil,
            c,
            0,
            122,
            LW,
            12,
            css(nil, wallCol)
        )
        R(
            nil,
            c,
            0,
            122,
            LW,
            1,
            css(
                nil,
                mul(
                    nil,
                    wallCol,
                    __arrL({1.1, 1.1, 1.1}, 3)
                )
            )
        )
        do
            local x = __mod(
                __TS__Number(-(__mod(ox * 0.35, 16) + 16)),
                16
            )
            while x < LW do
                R(
                    nil,
                    c,
                    x,
                    123,
                    1,
                    11,
                    css(
                        nil,
                        mul(
                            nil,
                            wallCol,
                            __arrL({0.82, 0.82, 0.84}, 3)
                        )
                    )
                )
                x = x + 16
            end
        end
        do
            local i = 0
            while i < __len(WIN) do
                local w = __get(WIN, i)
                do
                    local k = 0
                    while k < 4 do
                        local n = i * 7 + k
                        local px = w.x - OFF + ox + 4 + k * 15 + math.floor(hash(nil, n + 110) * 4 + 0.5)
                        local bob = math.floor(math.max(
                            0,
                            math.sin(t * (4.5 + hash(nil, n) * 2) + n * 1.9)
                        ) * 3 + 0.5)
                        local py = __add(w.y, w.h) - 14 - math.floor(hash(nil, n + 120) * 6 + 0.5) - bob
                        if __t(__lt(px, -16) or __gt(px, LW + 4)) then
                            continue
                        end
                        local skin = css(
                            nil,
                            pre(
                                nil,
                                mul(
                                    nil,
                                    hex(
                                        nil,
                                        __get(
                                            SKIN,
                                            __mod(n, 5)
                                        )
                                    ),
                                    light
                                )
                            )
                        )
                        local hair = css(
                            nil,
                            pre(
                                nil,
                                mul(
                                    nil,
                                    hex(
                                        nil,
                                        __get(
                                            HAIR,
                                            __mod(n * 3, 5)
                                        )
                                    ),
                                    light
                                )
                            )
                        )
                        local shirt = css(
                            nil,
                            pre(
                                nil,
                                mul(
                                    nil,
                                    hex(
                                        nil,
                                        __get(
                                            SHIRT,
                                            __mod(n * 5, 6)
                                        )
                                    ),
                                    light
                                )
                            )
                        )
                        R(
                            nil,
                            c,
                            px - 2,
                            py + 10,
                            14,
                            30,
                            shirt
                        )
                        R(
                            nil,
                            c,
                            px,
                            py,
                            10,
                            10,
                            skin
                        )
                        R(
                            nil,
                            c,
                            px,
                            py - 2,
                            10,
                            4,
                            hair
                        )
                        R(
                            nil,
                            c,
                            px - 1,
                            py,
                            1,
                            5,
                            hair
                        )
                        R(
                            nil,
                            c,
                            px + 2,
                            py + 5,
                            1,
                            2,
                            "#1c1c22"
                        )
                        R(
                            nil,
                            c,
                            px + 6,
                            py + 5,
                            1,
                            2,
                            "#1c1c22"
                        )
                        if __mod(
                            n + math.floor(t * 2),
                            5
                        ) == 0 then
                            R(
                                nil,
                                c,
                                px + 3,
                                py + 8,
                                4,
                                1,
                                "#5a2a2a"
                            )
                        end
                        if __mod(
                            n + math.floor(t * 1.5),
                            4
                        ) == 0 then
                            R(
                                nil,
                                c,
                                px + 11,
                                py - 6 - bob,
                                3,
                                14,
                                skin
                            )
                            R(
                                nil,
                                c,
                                px + 10,
                                py - 9 - bob,
                                5,
                                4,
                                skin
                            )
                        end
                        k = k + 1
                    end
                end
                i = i + 1
            end
        end
    end
    local low, lc = table.unpack(
        mk(nil, LW, LH),
        1,
        2
    )
    local lightCv, lg = table.unpack(
        mk(nil, LW, LH),
        1,
        2
    )
    local lampFlicker = 1
    local function back(self, c, ____type, camera, t, homeX)
        use(nil, ____type)
        local s = window.DayTime:state()
        local center = if __t(homeX) then homeX - camera else 480
        local ox = math.floor((center - 480) / 2 + 0.5)
        lc:clearRect(0, 0, LW, LH)
        R(
            nil,
            lc,
            0,
            0,
            LW,
            LH,
            "#101820"
        )
        outdoor(
            nil,
            lc,
            s,
            t,
            ox
        )
        lc:drawImage(
            wallLayer(nil),
            ox - OFF,
            0
        )
        local kx = ox + __get(CLOCK, cur)
        local ky = 90
        pixelDisc(
            nil,
            lc,
            kx,
            ky,
            10,
            "#2a3840"
        )
        pixelDisc(
            nil,
            lc,
            kx,
            ky,
            8,
            "#f3efdf"
        )
        do
            local i = 0
            while i < 12 do
                R(
                    nil,
                    lc,
                    kx + math.floor(math.sin(i / 6 * math.pi) * 7 + 0.5),
                    ky - math.floor(math.cos(i / 6 * math.pi) * 7 + 0.5),
                    1,
                    1,
                    if __t(__mod(i, 3)) then "#9aa39c" else "#2a3840"
                )
                i = i + 1
            end
        end
        local function hand(____, ang, len, col)
            do
                local k = 0
                while __le(k, len) do
                    R(
                        nil,
                        lc,
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
        hand(nil, s.h / 12 * math.pi * 2, 4, "#1f2a31")
        hand(
            nil,
            __mod(s.h, 1) * math.pi * 2,
            6,
            "#c94f45"
        )
        R(
            nil,
            lc,
            kx,
            ky,
            1,
            1,
            "#1f2a31"
        )
        lampFlicker = if hash(
            nil,
            math.floor(t * 14)
        ) > 0.9 then 0.35 else 1
        __call(
            TUBES,
            "forEach",
            function(____, x, i)
                local on = math.max(
                    0,
                    math.min(1, (s.night - 0.15) * 2)
                ) * if i == 2 then lampFlicker else 1
                R(
                    nil,
                    lc,
                    ox - OFF + x,
                    14,
                    44,
                    2,
                    css(
                        nil,
                        mix(
                            nil,
                            __arrL({0.62, 0.68, 0.7}, 3),
                            __arrL(
                                {
                                    1.6 / __get(s.amb, 0),
                                    1.5 / __get(s.amb, 1),
                                    1.2 / __get(s.amb, 2)
                                },
                                3
                            ),
                            on
                        )
                    )
                )
            end
        )
        for ____, fx in __iterar((FANS)) do
            local x = ox - OFF + fx
            local wv = math.floor(math.abs(math.cos(t * 9 + fx)) * 17 + 0.5) + 2
            R(
                nil,
                lc,
                x,
                13,
                2,
                5,
                "#1f2a31"
            )
            R(
                nil,
                lc,
                x - 2,
                18,
                6,
                3,
                "#55656e"
            )
            R(
                nil,
                lc,
                x - wv,
                19,
                wv * 2 + 2,
                1,
                "#8a6a47"
            )
            R(
                nil,
                lc,
                x - math.floor(wv * 0.5 + 0.5),
                20,
                wv + 2,
                1,
                "#6f573c"
            )
        end
        if cur == "igor" then
            do
                local i = 0
                while i < 9 do
                    local k = __mod(
                        t * 0.35 + hash(nil, i + 500),
                        1
                    )
                    local x = ox + 44 + hash(nil, i + 510) * 56 + math.sin(t * 2 + i) * 3
                    lc.fillStyle = ("rgba(255,255,255," .. tostring((1 - k) * 0.3)) .. ")"
                    lc:fillRect(
                        math.floor(x + 0.5),
                        math.floor(130 - k * 26 + 0.5),
                        2 + math.floor(k * 2 + 0.5),
                        2
                    )
                    i = i + 1
                end
            end
            do
                local i = 0
                while i < 6 do
                    local k = __mod(
                        t * 0.8 + hash(nil, i + 600),
                        1
                    )
                    local jx = ox + 347 + if __t(__mod(i, 2)) then 26 else 8 + 3 + math.floor(hash(nil, i + 610) * 7 + 0.5)
                    lc.fillStyle = "rgba(255,255,255,.55)"
                    lc:fillRect(
                        jx,
                        math.floor(149 - k * 13 + 0.5),
                        1,
                        1
                    )
                    i = i + 1
                end
            end
        else
            local on = math.sin(t * 6) > 0
            R(
                nil,
                lc,
                ox + 237,
                44,
                10,
                6,
                if __t(on) then "#ff4a3a" else "#7a1a1a"
            )
            if __t(on) then
                R(
                    nil,
                    lc,
                    ox + 239,
                    45,
                    3,
                    2,
                    "#ffd0c0"
                )
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
        c:translate(ox * 2, 0)
        c.textAlign = "center"
        c.textBaseline = "middle"
        c.font = "16px Pixel, monospace"
        c.fillStyle = "#0f2a44"
        c:fillText(
            __get(TITLE, cur),
            482,
            70
        )
        c.fillStyle = "#fff0c4"
        c:fillText(
            __get(TITLE, cur),
            480,
            68
        )
        if cur == "igor" then
            c.fillStyle = "#f0e2b8"
            c:fillText("SEM LANCHE", 170, 351)
            c.fillStyle = "#e4f0f0"
            c:fillText("SUCOS", 764, 351)
        else
            c.fillStyle = "#f3f0e2"
            c:fillText("BOLINHAS NO CESTO!", 484, 152)
            c.fillStyle = "#f7e08a"
            c:fillText("OLHE A MIRA.", 484, 186)
            c:fillText("ATAQUE NA", 484, 210)
            c:fillText("RECARGA.", 484, 234)
        end
        c:restore()
    end
    local function quad(self, g, pts, c0, c1, y0, y1)
        local gr = g:createLinearGradient(0, y0, 0, y1)
        gr:addColorStop(0, c0)
        gr:addColorStop(1, c1)
        g.fillStyle = gr
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
            while __lt(
                i,
                __len(pts)
            ) do
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
    local function glow(self, g, x, y, rx, ry, col, a)
        g:save()
        g:translate(x, y)
        g:scale(1, ry / rx)
        local gr = g:createRadialGradient(
            0,
            0,
            0,
            0,
            0,
            rx
        )
        gr:addColorStop(
            0,
            css(nil, col, a)
        )
        gr:addColorStop(
            1,
            css(nil, col, 0)
        )
        g.fillStyle = gr
        g:fillRect(
            __TS__Number(-rx),
            __TS__Number(-rx),
            rx * 2,
            rx * 2
        )
        g:restore()
    end
    local function front(self, c, ____type, camera, t, homeX, blend)
        if blend == nil then
            blend = 1
        end
        if not __t(active(nil, ____type)) then
            return
        end
        use(nil, if type(____type) == "table" then ____type.type else ____type)
        local s = window.DayTime:state()
        local center = if __t(homeX) then homeX - camera else 480
        local ox = math.floor((center - 480) / 2 + 0.5)
        local b = math.max(
            0,
            math.min(1, blend)
        )
        c:save()
        c.globalCompositeOperation = "multiply"
        c.fillStyle = css(
            nil,
            mix(
                nil,
                __arrL({1, 1, 1}, 3),
                s.amb,
                b
            )
        )
        c:fillRect(-40, -40, 1040, 620)
        lg:clearRect(0, 0, LW, LH)
        local T = if s.sunT ~= nil then s.sunT else s.moonT
        local str = if s.sunT ~= nil then math.min(
            1,
            math.sin(s.sunT * math.pi) * 1.6 + 0.25
        ) else if s.moonT ~= nil then 0.45 * math.sin(s.moonT * math.pi) else 0
        if __t(T ~= nil and str > 0.02) then
            local col = if s.sunT ~= nil then s.sun else __arrL({0.6, 0.7, 1}, 3)
            local lean = (T - 0.5) * 2
            local skew = lean * 62
            local reach = 20 + math.abs(lean) * 30
            for ____, w in __iterar((WIN)) do
                local x = w.x - OFF + ox
                if __t(x > LW + 90 or __lt(x + w.w, -90)) then
                    continue
                end
                quad(
                    nil,
                    lg,
                    __arrL(
                        {
                            __arrL({x, w.y}, 2),
                            __arrL({x + w.w, w.y}, 2),
                            __arrL({x + w.w + skew * 0.55, FLOOR + 1}, 2),
                            __arrL({x + skew * 0.55, FLOOR + 1}, 2)
                        },
                        4
                    ),
                    css(nil, col, 0.11 * str),
                    css(nil, col, 0.04 * str),
                    w.y,
                    FLOOR
                )
                quad(
                    nil,
                    lg,
                    __arrL(
                        {
                            __arrL({x + skew * 0.55, FLOOR + 1}, 2),
                            __arrL({x + w.w + skew * 0.55, FLOOR + 1}, 2),
                            __arrL({x + w.w + skew + 8, FLOOR + 1 + reach}, 2),
                            __arrL({x + skew - 8, FLOOR + 1 + reach}, 2)
                        },
                        4
                    ),
                    css(nil, col, 0.3 * str),
                    css(nil, col, 0),
                    FLOOR,
                    FLOOR + reach
                )
                do
                    local i = 0
                    while i < 5 do
                        local k = __mod(
                            t * 0.12 + hash(nil, i + w.x),
                            1
                        )
                        local mx = x + hash(nil, i * 3 + w.x) * w.w + skew * 0.55 * k
                        local my = w.y + k * (FLOOR - w.y)
                        lg.fillStyle = css(
                            nil,
                            col,
                            0.5 * str * (0.5 + 0.5 * math.sin(t * 3 + i + w.x))
                        )
                        lg:fillRect(
                            math.floor(mx + 0.5),
                            math.floor(my + 0.5),
                            1,
                            1
                        )
                        i = i + 1
                    end
                end
            end
        end
        local lamp = math.max(
            0,
            math.min(1, (s.night - 0.15) * 2)
        )
        if lamp > 0.01 then
            __call(
                TUBES,
                "forEach",
                function(____, tx, i)
                    local x = tx - OFF + ox + 22
                    local a = lamp * if i == 2 then lampFlicker else 1
                    if __t(x < -120 or x > LW + 120) then
                        return
                    end
                    quad(
                        nil,
                        lg,
                        __arrL(
                            {
                                __arrL({x - 22, 16}, 2),
                                __arrL({x + 22, 16}, 2),
                                __arrL({x + 62, LH}, 2),
                                __arrL({x - 62, LH}, 2)
                            },
                            4
                        ),
                        ("rgba(255,236,190," .. tostring(0.26 * a)) .. ")",
                        ("rgba(255,236,190," .. tostring(0.05 * a)) .. ")",
                        16,
                        LH
                    )
                    glow(
                        nil,
                        lg,
                        x,
                        FLOOR + 14,
                        58,
                        16,
                        __arrL({1, 0.93, 0.75}, 3),
                        0.3 * a
                    )
                    glow(
                        nil,
                        lg,
                        x,
                        15,
                        34,
                        12,
                        __arrL({1, 0.95, 0.82}, 3),
                        0.55 * a
                    )
                    do
                        local m = 0
                        while m < 2 do
                            local ang = t * (3 + m) + i * 2 + m * 3
                            lg.fillStyle = ("rgba(255,250,220," .. tostring(0.8 * a)) .. ")"
                            lg:fillRect(
                                math.floor(x + math.cos(ang) * (10 + m * 6) + 0.5),
                                math.floor(24 + math.sin(ang * 1.3) * 5 + 0.5),
                                1,
                                1
                            )
                            m = m + 1
                        end
                    end
                end
            )
        end
        if cur == "igor" then
            glow(
                nil,
                lg,
                FRIDGE.x - OFF + ox + FRIDGE.w / 2,
                FRIDGE.y + 44,
                40,
                48,
                __arrL({0.55, 0.9, 1}, 3),
                0.1 + s.night * 0.3
            )
            glow(
                nil,
                lg,
                ox + 73,
                142,
                44,
                20,
                __arrL({1, 0.8, 0.5}, 3),
                0.06 + s.night * 0.26
            )
        else
            local pulse = 0.5 + 0.5 * math.sin(t * 6)
            glow(
                nil,
                lg,
                ox + 242,
                47,
                60,
                34,
                __arrL({1, 0.2, 0.15}, 3),
                (0.1 + s.night * 0.16) * pulse
            )
        end
        c.globalCompositeOperation = "lighter"
        c.globalAlpha = b
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
    local function sky(self, c, t, camera)
        local ____t_22 = __t
        local ____t_21 = __t
        local ____opt_18 = window.Graphics
        if ____opt_18 ~= nil then
            ____opt_18 = ____opt_18.isLite
        end
        local ____opt_result_20
        if ____opt_18 ~= nil then
            ____opt_result_20 = ____opt_18(____opt_18)
        end
        __O[283] = ____opt_result_20
        if ____t_22(if ____t_21(____opt_result_20) then __O[283] else not __t(window.DayTime)) then
            return false
        end
        local s = window.DayTime:state()
        local function pre(____, v)
            return __arrL(
                {
                    math.min(
                        1,
                        __get(v, 0) / __get(s.amb, 0)
                    ),
                    math.min(
                        1,
                        __get(v, 1) / __get(s.amb, 1)
                    ),
                    math.min(
                        1,
                        __get(v, 2) / __get(s.amb, 2)
                    )
                },
                3
            )
        end
        local away = math.min(
            1,
            (3 - __get(s.amb, 0) - __get(s.amb, 1) - __get(s.amb, 2)) * 2.2 + s.night
        )
        if away > 0.02 then
            c:save()
            c.globalAlpha = away
            do
                local i = 0
                while i < 44 do
                    local k = i / 43
                    R(
                        nil,
                        c,
                        0,
                        i * 10,
                        960,
                        10,
                        css(
                            nil,
                            pre(
                                nil,
                                mix(nil, s.top, s.bot, k * k * 0.5 + k * 0.5)
                            )
                        )
                    )
                    i = i + 1
                end
            end
            c:restore()
        end
        if __gt(s.night, 0.25) then
            do
                local i = 0
                while i < 110 do
                    local tw = 0.5 + 0.5 * math.sin(t * (1 + hash(nil, i) * 2) + i)
                    c.fillStyle = ("rgba(255,255,255," .. tostring((s.night - 0.25) * 1.3 * (0.35 + 0.65 * tw) * (0.4 + hash(nil, i + 9) * 0.6))) .. ")"
                    c:fillRect(
                        math.floor(__mod(
                            __mod(
                                hash(nil, i + 300) * 1100 - camera * 0.01,
                                960
                            ) + 960,
                            960
                        ) / 2 + 0.5) * 2,
                        math.floor(hash(nil, i + 400) * 150 + 0.5) * 2,
                        2,
                        2
                    )
                    i = i + 1
                end
            end
        end
        local function disc(____, x, y, r, col)
            c.fillStyle = col
            do
                local yy = __TS__Number(-r)
                while __le(yy, r) do
                    local w = math.floor(math.sqrt(r * r - yy * yy) / 2 + 0.5) * 2
                    c:fillRect(
                        math.floor(x / 2 + 0.5) * 2 - w,
                        math.floor((y + yy) / 2 + 0.5) * 2,
                        w * 2,
                        2
                    )
                    yy = yy + 2
                end
            end
        end
        if s.sunT ~= nil then
            local x = 80 + s.sunT * 800 - camera * 0.025
            local y = 300 - math.sin(s.sunT * math.pi) * 215
            disc(
                nil,
                x,
                y,
                64,
                css(
                    nil,
                    pre(nil, s.sun),
                    0.12
                )
            )
            disc(
                nil,
                x,
                y,
                46,
                css(
                    nil,
                    pre(nil, s.sun),
                    0.22
                )
            )
            disc(
                nil,
                x,
                y,
                34,
                css(
                    nil,
                    pre(
                        nil,
                        mix(
                            nil,
                            s.sun,
                            __arrL({1, 1, 1}, 3),
                            0.5
                        )
                    )
                )
            )
        end
        if s.moonT ~= nil then
            local x = 100 + s.moonT * 760 - camera * 0.025
            local y = 280 - math.sin(s.moonT * math.pi) * 190
            disc(
                nil,
                x,
                y,
                40,
                "rgba(200,215,255,.14)"
            )
            disc(
                nil,
                x,
                y,
                24,
                "#ffffff"
            )
            R(
                nil,
                c,
                x - 10,
                y - 8,
                6,
                6,
                "#c9d4f0"
            )
            R(
                nil,
                c,
                x + 4,
                y + 6,
                8,
                4,
                "#c9d4f0"
            )
            R(
                nil,
                c,
                x + 8,
                y - 12,
                4,
                4,
                "#c9d4f0"
            )
        end
        return true
    end
    local function ambient(self, c, t, hx, hy, selfLit)
        local ____t_29 = __t
        local ____t_28 = __t
        local ____opt_25 = window.Graphics
        if ____opt_25 ~= nil then
            ____opt_25 = ____opt_25.isLite
        end
        local ____opt_result_27
        if ____opt_25 ~= nil then
            ____opt_result_27 = ____opt_25(____opt_25)
        end
        __O[284] = ____opt_result_27
        if ____t_29(if ____t_28(____opt_result_27) then __O[284] else not __t(window.DayTime)) then
            return
        end
        local s = window.DayTime:state()
        local ____t_34 = __t
        local ____t_31 = __t
        local ____le_result_30 = __le(s.night, 0.2)
        __O[286] = ____le_result_30
        local ____t_33 = __t
        local ____temp_32 = __gt(
            __get(s.amb, 0),
            0.995
        ) and __gt(
            __get(s.amb, 1),
            0.995
        )
        __O[285] = ____temp_32
        __D[1] = if ____t_34(if ____t_31(____le_result_30) then if __t(selfLit) then selfLit else if ____t_33(____temp_32) then __gt(
            __get(s.amb, 2),
            0.995
        ) else __O[285] else __O[286]) then
            return
        end
        c:save()
        if not __t(selfLit) then
            c.globalCompositeOperation = "multiply"
            c.fillStyle = css(nil, s.amb)
            c:fillRect(-40, -40, 1040, 620)
        end
        if __gt(s.night, 0.2) then
            local a = (s.night - 0.2) * 1.25
            lg:clearRect(0, 0, LW, LH)
            glow(
                nil,
                lg,
                hx / 2,
                hy / 2 - 30,
                64,
                34,
                __arrL({1, 0.86, 0.6}, 3),
                0.3 * a
            )
            do
                local i = 0
                while i < 16 do
                    local x = __mod(
                        hash(nil, i + 700) * 520 + math.sin(t * 0.4 + i) * 14,
                        480
                    )
                    local y = 150 + hash(nil, i + 710) * 62 + math.sin(t * 0.7 + i * 2) * 6
                    local on = math.max(
                        0,
                        math.sin(t * 1.6 + i * 2.3)
                    )
                    lg.fillStyle = ("rgba(210,255,140," .. tostring(on * a * 0.9)) .. ")"
                    lg:fillRect(
                        math.floor(x + 0.5),
                        math.floor(y + 0.5),
                        1,
                        1
                    )
                    lg.fillStyle = ("rgba(210,255,140," .. tostring(on * a * 0.25)) .. ")"
                    lg:fillRect(
                        math.floor(x + 0.5) - 1,
                        math.floor(y + 0.5) - 1,
                        3,
                        3
                    )
                    i = i + 1
                end
            end
            c.globalCompositeOperation = "lighter"
            c.imageSmoothingEnabled = false
            c:drawImage(
                lightCv,
                0,
                0,
                960,
                540
            )
        end
        c:restore()
    end
    window.Art.drawArena = function(self, ...)
        local __args = {...}
        local c, ____type, camera, t, homeX = table.unpack(__args, 1, 5)
        if camera == nil then
            camera = 0
        end
        if t == nil then
            t = 0
        end
        if homeX == nil then
            homeX = 0
        end
        if not __t(active(nil, ____type)) then
            return __fapply(orig, self, __args)
        end
        do
            local function ____catch(e)
                return true, __fapply(orig, self, __args)
            end
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                local ____back_42 = back
                local ____array_41 = __TS__SparseArrayNew(nil, c, if type(____type) == "table" then ____type.type else ____type)
                local ____t_36 = __t
                local ____TS__Number_result_35 = __TS__Number(camera)
                __O[287] = ____TS__Number_result_35
                __TS__SparseArrayPush(____array_41, if ____t_36(____TS__Number_result_35) then __O[287] else 0)
                local ____t_38 = __t
                local ____TS__Number_result_37 = __TS__Number(t)
                __O[288] = ____TS__Number_result_37
                __TS__SparseArrayPush(____array_41, if ____t_38(____TS__Number_result_37) then __O[288] else 0)
                local ____t_40 = __t
                local ____TS__Number_result_39 = __TS__Number(homeX)
                __O[289] = ____TS__Number_result_39
                __TS__SparseArrayPush(____array_41, if ____t_40(____TS__Number_result_39) then __O[289] else 0)
                ____back_42(__TS__SparseArraySpread(____array_41))
            end)
            if not ____try then
                ____hasReturned, ____returnValue = ____catch(____hasReturned)
            end
            if ____hasReturned then
                return ____returnValue
            end
        end
    end
    window.HdScene = __ord(
        {
            active = active,
            sky = function(____, c, t, camera)
                do
                    local function ____catch(e)
                        return true, false
                    end
                    local ____try, ____hasReturned, ____returnValue = pcall(function()
                        local ____sky_49 = sky
                        local ____c_47 = c
                        local ____t_44 = __t
                        local ____TS__Number_result_43 = __TS__Number(t)
                        __O[290] = ____TS__Number_result_43
                        local ____temp_48 = if ____t_44(____TS__Number_result_43) then __O[290] else 0
                        local ____t_46 = __t
                        local ____TS__Number_result_45 = __TS__Number(camera)
                        __O[291] = ____TS__Number_result_45
                        return true, ____sky_49(nil, ____c_47, ____temp_48, if ____t_46(____TS__Number_result_45) then __O[291] else 0)
                    end)
                    if not ____try then
                        ____hasReturned, ____returnValue = ____catch(____hasReturned)
                    end
                    if ____hasReturned then
                        return ____returnValue
                    end
                end
            end,
            drawAmbient = function(____, c, t, hx, hy, scene)
                do
                    pcall(function()
                        local ____ambient_63 = ambient
                        local ____array_62 = __TS__SparseArrayNew(nil, c)
                        local ____t_51 = __t
                        local ____TS__Number_result_50 = __TS__Number(t)
                        __O[292] = ____TS__Number_result_50
                        __TS__SparseArrayPush(____array_62, if ____t_51(____TS__Number_result_50) then __O[292] else 0)
                        local ____t_53 = __t
                        local ____TS__Number_result_52 = __TS__Number(hx)
                        __O[293] = ____TS__Number_result_52
                        __TS__SparseArrayPush(____array_62, if ____t_53(____TS__Number_result_52) then __O[293] else 480)
                        local ____t_55 = __t
                        local ____TS__Number_result_54 = __TS__Number(hy)
                        __O[294] = ____TS__Number_result_54
                        __TS__SparseArrayPush(____array_62, if ____t_55(____TS__Number_result_54) then __O[294] else 440)
                        local ____t_61 = __t
                        local ____opt_58 = window.HdMaps
                        if ____opt_58 ~= nil then
                            ____opt_58 = ____opt_58.handles
                        end
                        local ____opt_result_60
                        if ____opt_58 ~= nil then
                            ____opt_result_60 = ____opt_58(
                                ____opt_58,
                                __TS__Number(scene)
                            )
                        end
                        __TS__SparseArrayPush(
                            ____array_62,
                            not not ____t_61(____opt_result_60)
                        )
                        ____ambient_63(__TS__SparseArraySpread(____array_62))
                    end)
                end
            end,
            drawFront = function(____, c, ____type, camera, t, homeX, blend)
                do
                    pcall(function()
                        local ____front_71 = front
                        local ____array_70 = __TS__SparseArrayNew(nil, c, ____type)
                        local ____t_65 = __t
                        local ____TS__Number_result_64 = __TS__Number(camera)
                        __O[295] = ____TS__Number_result_64
                        __TS__SparseArrayPush(____array_70, if ____t_65(____TS__Number_result_64) then __O[295] else 0)
                        local ____t_67 = __t
                        local ____TS__Number_result_66 = __TS__Number(t)
                        __O[296] = ____TS__Number_result_66
                        __TS__SparseArrayPush(____array_70, if ____t_67(____TS__Number_result_66) then __O[296] else 0)
                        local ____t_69 = __t
                        local ____TS__Number_result_68 = __TS__Number(homeX)
                        __O[297] = ____TS__Number_result_68
                        __TS__SparseArrayPush(____array_70, if ____t_69(____TS__Number_result_68) then __O[297] else 0, blend)
                        ____front_71(__TS__SparseArraySpread(____array_70))
                    end)
                end
            end,
            scenes = __keys(HANDLED)
        },
        "active,sky,drawAmbient,drawFront,scenes"
    )
end)(nil)
return ____exports
