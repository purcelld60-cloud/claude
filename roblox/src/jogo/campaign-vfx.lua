--!native
--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __gt, __ge, __objCreate, __isFiniteN, __mod, __ord, __arrL, __iterar, __t, __get, __set = __JSR.__lt, __JSR.__gt, __JSR.__ge, __JSR.__objCreate, __JSR.__isFiniteN, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set
local __del, __len, __call, __add, __keys, __assign = __JSR.__del, __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__keys, __JSR.__assign
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local __TS__Iterator = ____lualib.__TS__Iterator
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local INK = "#263b42"
    local CREAM = "#fff1bf"
    local LIMIT = 18
    local history = __objCreate(nil)
    local events = __arrL({}, 0)
    local serial = 0
    local function clamp(____, v, a, b)
        local ____a_4 = a
        local ____b_3 = b
        local ____t_result_2
        local ____t_1 = __t
        local ____TS__Number_result_0 = __TS__Number(v)
        __O[1486] = ____TS__Number_result_0
        if ____t_1(____TS__Number_result_0) then
            ____t_result_2 = __O[1486]
        else
            ____t_result_2 = 0
        end
        return math.max(
            ____a_4,
            math.min(____b_3, ____t_result_2)
        )
    end
    local function rect(self, c, x, y, w, h, color)
        c.fillStyle = color
        c:fillRect(
            math.floor(x + 0.5),
            math.floor(y + 0.5),
            math.floor(w + 0.5),
            math.floor(h + 0.5)
        )
    end
    local function poly(self, c, points, color)
        c.fillStyle = color
        c:beginPath()
        __call(
            points,
            "forEach",
            function(____, p, i)
                local ____t_result_5
                if __t(i) then
                    ____t_result_5 = c:lineTo(
                        math.floor(__get(p, 0) + 0.5),
                        math.floor(__get(p, 1) + 0.5)
                    )
                else
                    ____t_result_5 = c:moveTo(
                        math.floor(__get(p, 0) + 0.5),
                        math.floor(__get(p, 1) + 0.5)
                    )
                end
                return ____t_result_5
            end
        )
        c:closePath()
        __call(c, "fill")
    end
    local function pixelLine(self, c, points, color, size)
        if size == nil then
            size = 2
        end
        c.fillStyle = color
        do
            local i = 1
            while __lt(
                i,
                __len(points)
            ) do
                local a = __get(points, i - 1)
                local b = __get(points, i)
                local n = math.max(
                    1,
                    math.ceil(math.max(
                        math.abs(__get(b, 0) - __get(a, 0)),
                        math.abs(__get(b, 1) - __get(a, 1))
                    ))
                )
                do
                    local j = 0
                    while j <= n do
                        c:fillRect(
                            math.floor(__get(a, 0) + (__get(b, 0) - __get(a, 0)) * j / n + 0.5),
                            math.floor(__get(a, 1) + (__get(b, 1) - __get(a, 1)) * j / n + 0.5),
                            size,
                            size
                        )
                        j = j + 1
                    end
                end
                i = i + 1
            end
        end
    end
    local function cloud(self, c, x, y, size, color, light)
        local k = math.max(
            2,
            math.floor(size / 5 + 0.5)
        )
        rect(
            nil,
            c,
            x - k * 3,
            y - k,
            k * 6,
            k * 3,
            INK
        )
        rect(
            nil,
            c,
            x - k * 2,
            y - k * 2,
            k * 4,
            k * 5,
            INK
        )
        rect(
            nil,
            c,
            x - k * 3 + 2,
            y - k + 2,
            k * 6 - 4,
            k * 3 - 4,
            color
        )
        rect(
            nil,
            c,
            x - k * 2 + 2,
            y - k * 2 + 2,
            k * 4 - 4,
            k * 5 - 4,
            color
        )
        local ____rect_8 = rect
        local ____array_7 = __TS__SparseArrayNew(
            nil,
            c,
            x - k,
            y - k * 2 + 3,
            k * 2,
            k
        )
        local ____t_result_6
        if __t(light) then
            ____t_result_6 = light
        else
            ____t_result_6 = CREAM
        end
        __TS__SparseArrayPush(____array_7, ____t_result_6)
        ____rect_8(__TS__SparseArraySpread(____array_7))
    end
    local function emit(self, ____type, data)
        if data == nil then
            data = {}
        end
        if __t(not __isFiniteN(data.x) or not __isFiniteN(data.y)) then
            return
        end
        local duration = ____type == "surge" and 0.62 or (____type == "gas" and 0.42 or (____type == "dash" and 0.28 or (____type == "cast" and 0.18 or 0.24)))
        local ____set_13 = __set
        local ____type_12 = ____type
        local ____t_result_11
        local ____t_10 = __t
        local ____get_result_9 = __get(history, ____type)
        __O[1487] = ____get_result_9
        if ____t_10(____get_result_9) then
            ____t_result_11 = __O[1487]
        else
            ____t_result_11 = 0
        end
        ____set_13(history, ____type_12, ____t_result_11 + 1)
        local ____assign_21 = __assign
        local ____temp_19 = {}
        local ____data_20 = data
        serial = serial + 1
        local ____serial_15 = serial
        local ____type_16 = ____type
        local ____duration_17 = duration
        local ____temp_18 = __lt(data.dir, 0) and -1 or 1
        local ____t_result_14
        if __t(data.stage) then
            ____t_result_14 = data.stage
        else
            ____t_result_14 = 1
        end
        local event = ____assign_21(
            ____temp_19,
            ____data_20,
            {
                id = ____serial_15,
                type = ____type_16,
                age = 0,
                duration = ____duration_17,
                dir = ____temp_18,
                stage = clamp(nil, ____t_result_14, 1, 3)
            }
        )
        if __len(events) >= LIMIT then
            __call(events, "shift")
        end
        __call(events, "push", event)
    end
    local function update(self, dt)
        dt = clamp(nil, dt, 0, 0.05)
        for ____, e in __iterar((events)) do
            e.age = __add(e.age, dt)
        end
        events = __call(
            events,
            "filter",
            function(____, e) return __lt(e.age, e.duration) end
        )
    end
    local function reset(self)
        events = __arrL({}, 0)
        for ____, k in __iterar((__keys(history))) do
            __del(history, k)
        end
        serial = 0
    end
    local function impact(self, c, e, p)
        local electric = e.element == "electric"
        local fire = e.element == "fire"
        local color = e.type == "enemyHit" and "#e79c79" or (__t(electric) and "#85e3f3" or (__t(fire) and "#f9b457" or (e.kind == "nikolas" and "#b7dc6b" or "#ffd376")))
        local n = (__ge(e.damage, 40) and 18 or 13) * (1 - p * 0.35)
        local ____t_result_22
        if __t(e.dir) then
            ____t_result_22 = e.dir
        else
            ____t_result_22 = 1
        end
        local angle = ____t_result_22 * 0.13
        c:rotate(angle)
        if __lt(p, 0.7) then
            poly(
                nil,
                c,
                __arrL(
                    {
                        __arrL({-n, -2}, 2),
                        __arrL({-n * 0.4, -n * 0.3}, 2),
                        __arrL({-n * 0.5, -n}, 2),
                        __arrL({1, -n * 0.5}, 2),
                        __arrL({n * 0.5, -n}, 2),
                        __arrL({n * 0.4, -n * 0.2}, 2),
                        __arrL({n, -1}, 2),
                        __arrL({n * 0.45, n * 0.3}, 2),
                        __arrL({n * 0.65, n * 0.8}, 2),
                        __arrL({n * 0.1, n * 0.4}, 2),
                        __arrL({-n * 0.15, n}, 2),
                        __arrL({-n * 0.3, n * 0.35}, 2),
                        __arrL({-n, n * 0.5}, 2),
                        __arrL({-n * 0.5, 1}, 2)
                    },
                    14
                ),
                INK
            )
            poly(
                nil,
                c,
                __arrL(
                    {
                        __arrL({-n + 4, -1}, 2),
                        __arrL({-n * 0.25, -n * 0.15}, 2),
                        __arrL({-n * 0.3, -n + 4}, 2),
                        __arrL({2, -n * 0.25}, 2),
                        __arrL({n * 0.3, -n + 5}, 2),
                        __arrL({n * 0.2, -n * 0.1}, 2),
                        __arrL({n - 4, 0}, 2),
                        __arrL({n * 0.25, n * 0.2}, 2),
                        __arrL({n * 0.3, n * 0.45}, 2),
                        __arrL({0, n * 0.2}, 2),
                        __arrL({-n * 0.08, n - 4}, 2),
                        __arrL({-n * 0.15, n * 0.15}, 2),
                        __arrL({-n + 5, n * 0.25}, 2)
                    },
                    13
                ),
                color
            )
            rect(
                nil,
                c,
                -3,
                -3,
                6,
                6,
                CREAM
            )
        end
        do
            local i = 0
            while i < 5 do
                local side = __t(__mod(i, 2)) and -1 or 1
                local x = side * (9 + p * (18 + i * 2))
                local y = (i - 2) * (3 + p * 3) - p * 8
                local ____rect_26 = rect
                local ____c_24 = c
                local ____temp_25 = __t(__mod(i, 2)) and 3 or 5
                local ____t_result_23
                if __t(__mod(i, 2)) then
                    ____t_result_23 = color
                else
                    ____t_result_23 = CREAM
                end
                ____rect_26(
                    nil,
                    ____c_24,
                    x,
                    y,
                    ____temp_25,
                    2,
                    ____t_result_23
                )
                i = i + 1
            end
        end
        local ____t_28 = __t
        local ____t_result_27
        if __t(electric) then
            ____t_result_27 = __lt(p, 0.68)
        else
            ____t_result_27 = electric
        end
        if ____t_28(____t_result_27) then
            pixelLine(
                nil,
                c,
                __arrL(
                    {
                        __arrL({-23, -8}, 2),
                        __arrL({-15, -13}, 2),
                        __arrL({-9, -4}, 2),
                        __arrL({-2, -11}, 2),
                        __arrL({7, 0}, 2),
                        __arrL({15, -7}, 2),
                        __arrL({23, -3}, 2)
                    },
                    7
                ),
                CREAM,
                2
            )
        end
        local ____t_30 = __t
        local ____t_result_29
        if __t(fire) then
            ____t_result_29 = __lt(p, 0.7)
        else
            ____t_result_29 = fire
        end
        if ____t_30(____t_result_29) then
            do
                local i = 0
                while i < 3 do
                    rect(
                        nil,
                        c,
                        (i - 1) * 8,
                        -14 - p * 14 - __mod(i, 2) * 4,
                        3,
                        5,
                        "#f7a33e"
                    )
                    i = i + 1
                end
            end
        end
    end
    local function draw(self, c, time, layer)
        if time == nil then
            time = 0
        end
        if layer == nil then
            layer = "front"
        end
        for ____, e in __iterar((events)) do
            do
                local ____t_34 = __t
                local ____t_result_33
                local ____t_32 = __t
                local ____temp_31 = e.type == "gas"
                __O[1488] = ____temp_31
                if ____t_32(____temp_31) then
                    ____t_result_33 = window.Golpes
                else
                    ____t_result_33 = __O[1488]
                end
                if ____t_34(____t_result_33) then
                    continue
                end
                local ____t_result_37
                local ____t_36 = __t
                local ____temp_35 = e.type == "gas" or e.type == "surge"
                __O[1489] = ____temp_35
                if ____t_36(____temp_35) then
                    ____t_result_37 = __O[1489]
                else
                    ____t_result_37 = e.type == "dash"
                end
                local back = ____t_result_37
                if layer == "back" ~= back then
                    continue
                end
                local p = clamp(nil, e.age / e.duration, 0, 1)
                c:save()
                c:translate(
                    math.floor(e.x + 0.5),
                    math.floor(e.y + 0.5)
                )
                local ____c_39, ____globalAlpha_40 = c, "globalAlpha"
                local ____temp_38
                if p > 0.7 then
                    ____temp_38 = (1 - p) / 0.3
                else
                    ____temp_38 = 1
                end
                ____c_39[____globalAlpha_40] = ____c_39[____globalAlpha_40] * ____temp_38
                if e.type == "gas" then
                    c:scale(e.dir, 1)
                    local ____t_result_41
                    if __t(e.radius) then
                        ____t_result_41 = e.radius
                    else
                        ____t_result_41 = 120
                    end
                    local reach = math.min(
                        185,
                        math.max(80, ____t_result_41)
                    )
                    do
                        local i = 0
                        while i < 4 do
                            local q = i / 3
                            local travel = 10 + p * reach * (0.35 + q * 0.65)
                            local yy = math.sin(i * 2.4) * 11 + p * (__t(__mod(i, 2)) and -9 or 5)
                            local size = (10 + e.stage * 2 + q * 7) * (1 - p * 0.3)
                            cloud(
                                nil,
                                c,
                                travel,
                                yy,
                                size,
                                __t(__mod(i, 2)) and "#9ecb4b" or "#bedc69",
                                "#e6ef9c"
                            )
                            i = i + 1
                        end
                    end
                    do
                        local i = 0
                        while i < 3 do
                            rect(
                                nil,
                                c,
                                8 + p * (38 + i * 14),
                                -12 + i * 10,
                                6,
                                2,
                                "#e3ef9a"
                            )
                            i = i + 1
                        end
                    end
                elseif e.type == "surge" then
                    do
                        local i = 0
                        while i < 5 do
                            local xx = (i - 2) * 14
                            local lift = math.sin(p * math.pi) * (30 + __mod(i, 2) * 16)
                            poly(
                                nil,
                                c,
                                __arrL(
                                    {
                                        __arrL({xx - 6, 22}, 2),
                                        __arrL({xx - 5, -lift}, 2),
                                        __arrL({xx + 1, -lift - 13}, 2),
                                        __arrL({xx + 6, -lift + 3}, 2),
                                        __arrL({xx + 4, 22}, 2)
                                    },
                                    5
                                ),
                                __t(__mod(i, 2)) and "#e8b83c" or "#fff0a0"
                            )
                            i = i + 1
                        end
                    end
                    do
                        local i = 0
                        while i < 4 do
                            rect(
                                nil,
                                c,
                                (i - 1.5) * 21,
                                -15 - p * (45 + __mod(i, 2) * 20),
                                3,
                                5,
                                CREAM
                            )
                            i = i + 1
                        end
                    end
                elseif e.type == "dash" then
                    c:scale(e.dir, 1)
                    do
                        local i = 0
                        while i < 3 do
                            local xx = -i * 13 - p * (16 + i * 7)
                            rect(
                                nil,
                                c,
                                xx,
                                -2 - __mod(i, 2) * 4,
                                9 - i * 2,
                                3,
                                "#d8cc9b"
                            )
                            rect(
                                nil,
                                c,
                                xx + 2,
                                -5 - __mod(i, 2) * 4,
                                4,
                                2,
                                CREAM
                            )
                            i = i + 1
                        end
                    end
                elseif e.type == "cast" then
                    c:scale(e.dir, 1)
                    poly(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({0, -2}, 2),
                                __arrL({12, -6}, 2),
                                __arrL({8, -2}, 2),
                                __arrL({19, 0}, 2),
                                __arrL({8, 3}, 2),
                                __arrL({11, 7}, 2),
                                __arrL({0, 2}, 2)
                            },
                            7
                        ),
                        e.element == "electric" and "#b5f4fb" or (e.element == "fire" and "#ffc66d" or (e.kind == "slime" and "#d0e78f" or (e.kind == "word" and "#e9bfd5" or (e.kind == "doodle" and "#dab6ef" or (e.kind == "smoke" and "#c3d0cc" or CREAM)))))
                    )
                else
                    impact(nil, c, e, p)
                end
                c:restore()
            end
        end
    end
    local function drawProjectile(self, c, s, t)
        if t == nil then
            t = 0
        end
        local ____t_45 = __t
        local ____t_result_44
        local ____t_43 = __t
        local ____temp_42 = not __t(s) or __gt(s.delay, 0)
        __O[1490] = ____temp_42
        if ____t_43(____temp_42) then
            ____t_result_44 = __O[1490]
        else
            ____t_result_44 = not __t(__call(
                __arrL({
                    "paper",
                    "ruler",
                    "case",
                    "reeis",
                    "papaia",
                    "enemyBullet",
                    "slime",
                    "inkBlade",
                    "smoke",
                    "bituca",
                    "astral",
                    "confetti",
                    "word"
                }, 13),
                "includes",
                s.type
            ))
        end
        if ____t_45(____t_result_44) then
            return false
        end
        c:save()
        c.imageSmoothingEnabled = false
        c:translate(
            math.floor(s.x + 0.5),
            math.floor(s.y + 0.5)
        )
        local ____t_result_48
        local ____t_47 = __t
        local ____TS__Number_result_46 = __TS__Number(s.vy)
        __O[1491] = ____TS__Number_result_46
        if ____t_47(____TS__Number_result_46) then
            ____t_result_48 = __O[1491]
        else
            ____t_result_48 = 0
        end
        local ____t_result_51
        local ____t_50 = __t
        local ____TS__Number_result_49 = __TS__Number(s.vx)
        __O[1492] = ____TS__Number_result_49
        if ____t_50(____TS__Number_result_49) then
            ____t_result_51 = __O[1492]
        else
            ____t_result_51 = 1
        end
        local angle = math.atan(____t_result_48, ____t_result_51)
        local color = s.element == "electric" and "#a0ebf4" or (s.element == "fire" and "#f6b152" or "#f5e2b2")
        if __t(__call(
            __arrL({
                "paper",
                "ruler",
                "case",
                "reeis",
                "papaia",
                "enemyBullet"
            }, 6),
            "includes",
            s.type
        )) then
            c:rotate(angle)
            if __t(s.type ~= "ruler" and s.type ~= "case") then
                rect(
                    nil,
                    c,
                    -21,
                    -1,
                    8,
                    2,
                    __t(s.type == "enemyBullet" or s.type == "reeis") and "#dcb56c" or color
                )
                rect(
                    nil,
                    c,
                    -31,
                    3,
                    5,
                    1,
                    s.type == "papaia" and "#f8d878" or "#e3dcc1"
                )
            end
            if s.type == "paper" then
                c:rotate(math.sin(t * 17) * 0.18)
                poly(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({-8, -3}, 2),
                            __arrL({-3, -7}, 2),
                            __arrL({5, -6}, 2),
                            __arrL({9, -1}, 2),
                            __arrL({6, 6}, 2),
                            __arrL({-2, 7}, 2),
                            __arrL({-8, 3}, 2)
                        },
                        7
                    ),
                    INK
                )
                poly(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({-6, -2}, 2),
                            __arrL({-2, -5}, 2),
                            __arrL({4, -4}, 2),
                            __arrL({7, 0}, 2),
                            __arrL({4, 4}, 2),
                            __arrL({-2, 5}, 2),
                            __arrL({-6, 2}, 2)
                        },
                        7
                    ),
                    "#fff2d2"
                )
                pixelLine(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({-5, 0}, 2),
                            __arrL({0, -2}, 2),
                            __arrL({3, 2}, 2),
                            __arrL({5, 0}, 2)
                        },
                        4
                    ),
                    "#c5b992",
                    1
                )
                rect(
                    nil,
                    c,
                    -2,
                    -4,
                    3,
                    2,
                    "#ffffff"
                )
            elseif s.type == "ruler" then
                rect(
                    nil,
                    c,
                    -15,
                    -5,
                    30,
                    10,
                    INK
                )
                rect(
                    nil,
                    c,
                    -13,
                    -4,
                    26,
                    7,
                    "#e3af58"
                )
                rect(
                    nil,
                    c,
                    -12,
                    -4,
                    25,
                    2,
                    "#ffe0a2"
                )
                do
                    local i = 0
                    while i < 7 do
                        rect(
                            nil,
                            c,
                            -11 + i * 4,
                            0,
                            1,
                            __t(__mod(i, 2)) and 2 or 3,
                            "#86683c"
                        )
                        i = i + 1
                    end
                end
            elseif s.type == "case" then
                rect(
                    nil,
                    c,
                    -12,
                    -6,
                    24,
                    12,
                    INK
                )
                rect(
                    nil,
                    c,
                    -10,
                    -4,
                    20,
                    8,
                    "#63b5b4"
                )
                rect(
                    nil,
                    c,
                    -9,
                    -3,
                    18,
                    2,
                    "#b0e5d2"
                )
                rect(
                    nil,
                    c,
                    -8,
                    1,
                    16,
                    1,
                    "#327a85"
                )
                rect(
                    nil,
                    c,
                    6,
                    -1,
                    3,
                    4,
                    "#f7d992"
                )
            elseif s.type == "papaia" then
                poly(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({-9, -4}, 2),
                            __arrL({-3, -8}, 2),
                            __arrL({6, -7}, 2),
                            __arrL({11, -1}, 2),
                            __arrL({8, 5}, 2),
                            __arrL({0, 8}, 2),
                            __arrL({-8, 4}, 2)
                        },
                        7
                    ),
                    INK
                )
                poly(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({-7, -3}, 2),
                            __arrL({-2, -6}, 2),
                            __arrL({5, -5}, 2),
                            __arrL({8, -1}, 2),
                            __arrL({6, 3}, 2),
                            __arrL({0, 5}, 2),
                            __arrL({-6, 3}, 2)
                        },
                        7
                    ),
                    color
                )
                rect(
                    nil,
                    c,
                    -3,
                    -4,
                    5,
                    2,
                    "#fff2b0"
                )
                rect(
                    nil,
                    c,
                    5,
                    -8,
                    7,
                    2,
                    "#568d44"
                )
                rect(
                    nil,
                    c,
                    8,
                    -11,
                    3,
                    4,
                    "#89bc4e"
                )
                if s.element == "electric" then
                    pixelLine(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({-17, -7}, 2),
                                __arrL({-10, -10}, 2),
                                __arrL({-12, -4}, 2),
                                __arrL({-7, -2}, 2)
                            },
                            4
                        ),
                        "#e7ffff",
                        2
                    )
                    pixelLine(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({0, 11}, 2),
                                __arrL({6, 8}, 2),
                                __arrL({4, 13}, 2),
                                __arrL({11, 9}, 2)
                            },
                            4
                        ),
                        "#e7ffff",
                        2
                    )
                else
                    poly(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({-10, 4}, 2),
                                __arrL({-24, 7}, 2),
                                __arrL({-19, 1}, 2),
                                __arrL({-30, -1}, 2),
                                __arrL({-16, -4}, 2)
                            },
                            5
                        ),
                        "#f5a34e"
                    )
                    rect(
                        nil,
                        c,
                        -21,
                        -2,
                        9,
                        3,
                        "#ffe09a"
                    )
                end
            else
                local gun = s.type == "reeis"
                rect(
                    nil,
                    c,
                    -8,
                    -3,
                    17,
                    6,
                    INK
                )
                rect(
                    nil,
                    c,
                    -7,
                    -2,
                    14,
                    4,
                    __t(gun) and "#ffe191" or "#e9bd62"
                )
                rect(
                    nil,
                    c,
                    4,
                    -1,
                    6,
                    2,
                    "#fff4bb"
                )
                rect(
                    nil,
                    c,
                    -16,
                    -1,
                    7,
                    2,
                    __t(gun) and "#f9dc7e" or "#edbb63"
                )
            end
        elseif s.type == "slime" then
            c:rotate(angle * 0.15)
            poly(
                nil,
                c,
                __arrL(
                    {
                        __arrL({-13, -4}, 2),
                        __arrL({-8, -9}, 2),
                        __arrL({4, -11}, 2),
                        __arrL({12, -5}, 2),
                        __arrL({15, 3}, 2),
                        __arrL({8, 9}, 2),
                        __arrL({-7, 8}, 2),
                        __arrL({-14, 3}, 2)
                    },
                    8
                ),
                "#416b39"
            )
            poly(
                nil,
                c,
                __arrL(
                    {
                        __arrL({-11, -3}, 2),
                        __arrL({-6, -7}, 2),
                        __arrL({3, -8}, 2),
                        __arrL({9, -4}, 2),
                        __arrL({11, 2}, 2),
                        __arrL({6, 6}, 2),
                        __arrL({-6, 5}, 2),
                        __arrL({-11, 2}, 2)
                    },
                    8
                ),
                "#a9cf63"
            )
            rect(
                nil,
                c,
                -5,
                -6,
                7,
                3,
                "#e4f4a0"
            )
            rect(
                nil,
                c,
                8,
                6,
                4,
                3,
                "#86b44d"
            )
            do
                local i = 0
                while i < 2 do
                    rect(
                        nil,
                        c,
                        -15 - i * 9,
                        3 + i * 4,
                        4 - i,
                        3,
                        "#b2cf70"
                    )
                    i = i + 1
                end
            end
        elseif s.type == "inkBlade" then
            c:rotate(t * 9)
            do
                local i = 0
                while i < 4 do
                    c:rotate(math.pi / 2)
                    poly(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({-3, -1}, 2),
                                __arrL({-7, -15}, 2),
                                __arrL({0, -25}, 2),
                                __arrL({6, -13}, 2),
                                __arrL({3, 1}, 2)
                            },
                            5
                        ),
                        INK
                    )
                    poly(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({-1, -3}, 2),
                                __arrL({-4, -14}, 2),
                                __arrL({0, -21}, 2),
                                __arrL({3, -12}, 2),
                                __arrL({1, -1}, 2)
                            },
                            5
                        ),
                        "#9d6ec7"
                    )
                    rect(
                        nil,
                        c,
                        0,
                        -19,
                        2,
                        11,
                        "#e6c6f5"
                    )
                    i = i + 1
                end
            end
            rect(
                nil,
                c,
                -4,
                -4,
                8,
                8,
                "#f6dfef"
            )
        elseif s.type == "smoke" then
            local base = c.globalAlpha
            local ____temp_53 = t * 7
            local ____t_result_52
            if __t(s.variant) then
                ____t_result_52 = s.variant
            else
                ____t_result_52 = 0
            end
            local w = math.sin(____temp_53 + ____t_result_52) * 1.5
            c:rotate(angle)
            do
                local i = 1
                while i <= 3 do
                    c.globalAlpha = base * (0.42 - i * 0.11)
                    cloud(
                        nil,
                        c,
                        -12 - i * 9,
                        math.sin(t * 5 + i) * 3,
                        7 - i,
                        "#8e9c9f",
                        "#c9d4d0"
                    )
                    i = i + 1
                end
            end
            c.globalAlpha = base * 0.9
            do
                local k = 0
                while k < 20 do
                    local a = k / 20 * math.pi * 2
                    local x = math.cos(a) * (8 + w * 0.4)
                    local y = math.sin(a) * (13 + w)
                    rect(
                        nil,
                        c,
                        x - 2,
                        y - 2,
                        4,
                        4,
                        "#7f8c8f"
                    )
                    k = k + 1
                end
            end
            do
                local k = 0
                while k < 20 do
                    local a = k / 20 * math.pi * 2
                    local x = math.cos(a) * (7 + w * 0.4)
                    local y = math.sin(a) * (11 + w)
                    rect(
                        nil,
                        c,
                        x - 1,
                        y - 1,
                        3,
                        3,
                        __t(a > math.pi * 0.9 and a < math.pi * 1.8) and "#eef3ec" or "#c3cfcb"
                    )
                    k = k + 1
                end
            end
        elseif s.type == "bituca" then
            local base = c.globalAlpha
            c:save()
            c:rotate(-angle)
            do
                local i = 1
                while i <= 4 do
                    c.globalAlpha = base * (0.36 - i * 0.07)
                    local ____rect_58 = rect
                    local ____c_56 = c
                    local ____t_result_54
                    if __t(s.vx) then
                        ____t_result_54 = s.vx
                    else
                        ____t_result_54 = 0
                    end
                    local ____temp_57 = __TS__Number(-____t_result_54) * 0.018 * i - 2
                    local ____t_result_55
                    if __t(s.vy) then
                        ____t_result_55 = s.vy
                    else
                        ____t_result_55 = 0
                    end
                    ____rect_58(
                        nil,
                        ____c_56,
                        ____temp_57,
                        __TS__Number(-____t_result_55) * 0.018 * i - 2 - i * 2,
                        5 - i * 0.6,
                        5 - i * 0.6,
                        "#b9c3c0"
                    )
                    i = i + 1
                end
            end
            c:restore()
            c.globalAlpha = base
            local ____c_60 = c
            local ____c_rotate_61 = c.rotate
            local ____t_result_59
            if __t(s.spin) then
                ____t_result_59 = s.spin
            else
                ____t_result_59 = 0
            end
            ____c_rotate_61(____c_60, ____t_result_59 + t * 13)
            c.globalAlpha = base * (0.25 + 0.15 * math.sin(t * 30))
            rect(
                nil,
                c,
                5,
                -5,
                9,
                9,
                "#ff8a30"
            )
            c.globalAlpha = base
            rect(
                nil,
                c,
                -9,
                -3,
                19,
                6,
                INK
            )
            rect(
                nil,
                c,
                -8,
                -2,
                6,
                4,
                "#d9953f"
            )
            rect(
                nil,
                c,
                -7,
                -2,
                2,
                1,
                "#f2c27a"
            )
            rect(
                nil,
                c,
                -2,
                -2,
                9,
                4,
                "#f4f0e4"
            )
            rect(
                nil,
                c,
                -2,
                1,
                9,
                1,
                "#c9c3b4"
            )
            rect(
                nil,
                c,
                7,
                -2,
                2,
                4,
                "#ff6a24"
            )
            rect(
                nil,
                c,
                8,
                -1,
                1,
                2,
                "#ffe08a"
            )
        elseif s.type == "astral" then
            c:rotate(t * 2)
            poly(
                nil,
                c,
                __arrL(
                    {
                        __arrL({0, -18}, 2),
                        __arrL({5, -5}, 2),
                        __arrL({17, 0}, 2),
                        __arrL({5, 5}, 2),
                        __arrL({0, 18}, 2),
                        __arrL({-5, 5}, 2),
                        __arrL({-17, 0}, 2),
                        __arrL({-5, -5}, 2)
                    },
                    8
                ),
                "#386c9a"
            )
            poly(
                nil,
                c,
                __arrL(
                    {
                        __arrL({0, -14}, 2),
                        __arrL({3, -3}, 2),
                        __arrL({13, 0}, 2),
                        __arrL({3, 3}, 2),
                        __arrL({0, 14}, 2),
                        __arrL({-3, 3}, 2),
                        __arrL({-13, 0}, 2),
                        __arrL({-3, -3}, 2)
                    },
                    8
                ),
                "#9de5ec"
            )
            rect(
                nil,
                c,
                -3,
                -3,
                6,
                6,
                "#fff0ac"
            )
        elseif s.type == "confetti" then
            c:rotate(t * 5)
            rect(
                nil,
                c,
                -7,
                -6,
                14,
                12,
                INK
            )
            rect(
                nil,
                c,
                -5,
                -4,
                10,
                8,
                "#e3a7cf"
            )
            rect(
                nil,
                c,
                -4,
                -4,
                4,
                2,
                "#ffe3b6"
            )
            rect(
                nil,
                c,
                3,
                1,
                3,
                2,
                "#c17cba"
            )
        elseif s.type == "word" then
            local ____t_result_62
            if __t(s.text) then
                ____t_result_62 = s.text
            else
                ____t_result_62 = "POUDI"
            end
            local value = tostring(____t_result_62)
            local w = math.min(
                220,
                __len(value) * 7 + 18
            )
            poly(
                nil,
                c,
                __arrL(
                    {
                        __arrL({-w / 2 - 2, -13}, 2),
                        __arrL({w / 2, -13}, 2),
                        __arrL({w / 2 + 5, 8}, 2),
                        __arrL({w / 2 - 1, 15}, 2),
                        __arrL({-w / 2, 15}, 2),
                        __arrL({-w / 2 - 5, -7}, 2)
                    },
                    6
                ),
                INK
            )
            rect(
                nil,
                c,
                -w / 2,
                -10,
                w,
                22,
                "#f0cfdb"
            )
            rect(
                nil,
                c,
                -w / 2 + 2,
                10,
                w - 4,
                3,
                "#a76795"
            )
            c.font = "bold 12px monospace"
            c.textAlign = "center"
            c.textBaseline = "middle"
            c.fillStyle = __t(s.echo) and "#315d79" or "#623950"
            c:fillText(value, 0, 1)
        end
        c:restore()
        return true
    end
    window.CampaignVfx = __ord(
        {
            version = 1,
            emit = emit,
            update = update,
            draw = draw,
            drawProjectile = drawProjectile,
            reset = reset,
            getStatus = function() return {
                active = __len(events),
                back = __len(__call(
                    events,
                    "filter",
                    function(____, e) return __call(
                        __arrL({"gas", "dash", "surge"}, 3),
                        "includes",
                        e.type
                    ) end
                )),
                front = __len(__call(
                    events,
                    "filter",
                    function(____, e) return not __t(__call(
                        __arrL({"gas", "dash", "surge"}, 3),
                        "includes",
                        e.type
                    )) end
                )),
                maxActive = LIMIT,
                emitted = __assign({}, history)
            } end
        },
        "version,emit,update,draw,drawProjectile,reset,getStatus"
    )
end)(nil)
return ____exports
