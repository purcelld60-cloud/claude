--!native
--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __gt, __isFiniteN, __mod, __ord, __arrL, __iterar, __t, __get, __set, __len, __call = __JSR.__lt, __JSR.__gt, __JSR.__isFiniteN, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__len, __JSR.__call
local __add, __keys, __assign, __band, __shr, __getters, __re, __re_test, __re_exec = __JSR.__add, __JSR.__keys, __JSR.__assign, __JSR.__band, __JSR.__shr, __JSR.__getters, __JSR.__re, __JSR.__re_test, __JSR.__re_exec
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__ParseInt = ____lualib.__TS__ParseInt
local ____exports = {}
local __O = {};
(function()
    local poly, oval, limb, hairBack, hairFront, hat, item, shadeHex, person, biscoito, aged, draw, base, r, OUT, LINE, LEGLINE, SPEC, AGES, KID
    function poly(self, c, points, color)
        c.fillStyle = color
        c:beginPath()
        __call(
            points,
            "forEach",
            function(____, p, i)
                local ____t_result_4
                if __t(i) then
                    ____t_result_4 = c:lineTo(
                        __get(p, 0),
                        __get(p, 1)
                    )
                else
                    ____t_result_4 = c:moveTo(
                        __get(p, 0),
                        __get(p, 1)
                    )
                end
                return ____t_result_4
            end
        )
        c:closePath()
        __call(c, "fill")
    end
    function oval(self, c, x, y, rx, ry, color, p)
        if p == nil then
            p = 3
        end
        do
            local yy = __TS__Number(-ry)
            while __lt(yy, ry) do
                local ww = math.sqrt(math.max(0, 1 - yy / ry * (yy / ry))) * rx
                r(
                    nil,
                    c,
                    x - ww,
                    y + yy,
                    ww * 2,
                    p,
                    color
                )
                yy = yy + p
            end
        end
    end
    function limb(self, c, points, width, color)
        do
            local i = 1
            while __lt(
                i,
                __len(points)
            ) do
                local a = __get(points, i - 1)
                local b = __get(points, i)
                local steps = math.max(
                    1,
                    math.ceil(math.max(
                        math.abs(__get(b, 0) - __get(a, 0)),
                        math.abs(__get(b, 1) - __get(a, 1))
                    ) / 2)
                )
                do
                    local j = 0
                    while j <= steps do
                        local q = j / steps
                        r(
                            nil,
                            c,
                            math.floor((__get(a, 0) + (__get(b, 0) - __get(a, 0)) * q) / 2 + 0.5) * 2 - width / 2,
                            math.floor((__get(a, 1) + (__get(b, 1) - __get(a, 1)) * q) / 2 + 0.5) * 2 - width / 2,
                            width,
                            width,
                            color
                        )
                        j = j + 1
                    end
                end
                i = i + 1
            end
        end
    end
    function hairBack(self, c, S)
        local H = S.hair
        if not __t(H) then
            return
        end
        local col = H.color
        if H.style == "mullet" then
            r(
                nil,
                c,
                -17,
                -60,
                10,
                27,
                OUT
            )
            r(
                nil,
                c,
                -16,
                -60,
                9,
                26,
                col
            )
            r(
                nil,
                c,
                -16,
                -40,
                4,
                6,
                col
            )
            r(
                nil,
                c,
                -11,
                -38,
                4,
                5,
                col
            )
            r(
                nil,
                c,
                -14,
                -56,
                2,
                14,
                "#2a3036"
            )
        end
        if H.style == "long" then
            r(
                nil,
                c,
                -15,
                -60,
                9,
                26,
                OUT
            )
            r(
                nil,
                c,
                -14,
                -60,
                8,
                25,
                col
            )
            r(
                nil,
                c,
                -13,
                -38,
                6,
                3,
                col
            )
        end
        if H.style == "ponytail" then
            r(
                nil,
                c,
                -17,
                -60,
                6,
                6,
                OUT
            )
            r(
                nil,
                c,
                -16,
                -59,
                5,
                5,
                col
            )
            limb(
                nil,
                c,
                __arrL(
                    {
                        __arrL({-15, -56}, 2),
                        __arrL({-19, -48}, 2),
                        __arrL({-17, -40}, 2)
                    },
                    3
                ),
                5,
                OUT
            )
            limb(
                nil,
                c,
                __arrL(
                    {
                        __arrL({-15, -56}, 2),
                        __arrL({-19, -48}, 2),
                        __arrL({-17, -40}, 2)
                    },
                    3
                ),
                3,
                col
            )
            r(
                nil,
                c,
                -17,
                -58,
                3,
                2,
                "#c94b6a"
            )
        end
        if H.style == "bun" then
            oval(
                nil,
                c,
                -13,
                -63,
                6,
                6,
                OUT,
                2
            )
            local ____oval_7 = oval
            local ____array_6 = __TS__SparseArrayNew(
                nil,
                c,
                -13,
                -63,
                5,
                5
            )
            local ____t_result_5
            if __t(H.gray) then
                ____t_result_5 = H.gray
            else
                ____t_result_5 = col
            end
            __TS__SparseArrayPush(____array_6, ____t_result_5, 2)
            ____oval_7(__TS__SparseArraySpread(____array_6))
            r(
                nil,
                c,
                -15,
                -66,
                3,
                2,
                col
            )
        end
        if H.style == "curlyBig" then
            do
                local i = 0
                while i < 7 do
                    local a = -math.pi * 0.95 + i * 0.5
                    oval(
                        nil,
                        c,
                        -2 + math.cos(a) * 15,
                        -54 + math.sin(a) * 11,
                        6,
                        6,
                        OUT,
                        2
                    )
                    i = i + 1
                end
            end
            do
                local i = 0
                while i < 7 do
                    local a = -math.pi * 0.95 + i * 0.5
                    local ____oval_10 = oval
                    local ____array_9 = __TS__SparseArrayNew(
                        nil,
                        c,
                        -2 + math.cos(a) * 14,
                        -54 + math.sin(a) * 10,
                        5,
                        5
                    )
                    local ____t_result_8
                    if __t(__mod(i, 2)) then
                        ____t_result_8 = col
                    else
                        ____t_result_8 = "#2e211b"
                    end
                    __TS__SparseArrayPush(____array_9, ____t_result_8, 2)
                    ____oval_10(__TS__SparseArraySpread(____array_9))
                    i = i + 1
                end
            end
            r(
                nil,
                c,
                -16,
                -50,
                6,
                14,
                col
            )
        end
    end
    function hairFront(self, c, S, t)
        local H = S.hair
        if not __t(H) then
            return
        end
        local col = H.color
        local ____t_result_11
        if __t(H.hi) then
            ____t_result_11 = H.hi
        else
            ____t_result_11 = shadeHex(nil, col, 1.35)
        end
        local hi = ____t_result_11
        repeat
            local ____switch28 = H.style
            local ____cond28 = ____switch28 == "bowl"
            if ____cond28 then
                do
                    do
                        local i = 0
                        while i < 8 do
                            oval(
                                nil,
                                c,
                                -12 + i * 3.8,
                                -64 - (__t(i > 0 and i < 7) and 2 or 0),
                                4,
                                4,
                                OUT,
                                2
                            )
                            i = i + 1
                        end
                    end
                    r(
                        nil,
                        c,
                        -15,
                        -62,
                        31,
                        8,
                        OUT
                    )
                    r(
                        nil,
                        c,
                        -15,
                        -56,
                        6,
                        9,
                        OUT
                    )
                    do
                        local i = 0
                        while i < 8 do
                            local ____oval_14 = oval
                            local ____array_13 = __TS__SparseArrayNew(
                                nil,
                                c,
                                -12 + i * 3.8,
                                -64 - (__t(i > 0 and i < 7) and 2 or 0),
                                3,
                                3
                            )
                            local ____t_result_12
                            if __t(__mod(i, 2)) then
                                ____t_result_12 = col
                            else
                                ____t_result_12 = hi
                            end
                            __TS__SparseArrayPush(____array_13, ____t_result_12, 2)
                            ____oval_14(__TS__SparseArraySpread(____array_13))
                            i = i + 1
                        end
                    end
                    r(
                        nil,
                        c,
                        -14,
                        -62,
                        29,
                        6,
                        col
                    )
                    r(
                        nil,
                        c,
                        -14,
                        -56,
                        5,
                        8,
                        col
                    )
                    do
                        local i = 0
                        while i < 3 do
                            local ____oval_17 = oval
                            local ____array_16 = __TS__SparseArrayNew(
                                nil,
                                c,
                                -12,
                                -53 + i * 3,
                                2,
                                2
                            )
                            local ____t_result_15
                            if __t(__mod(i, 2)) then
                                ____t_result_15 = hi
                            else
                                ____t_result_15 = col
                            end
                            __TS__SparseArrayPush(____array_16, ____t_result_15, 2)
                            ____oval_17(__TS__SparseArraySpread(____array_16))
                            i = i + 1
                        end
                    end
                    r(
                        nil,
                        c,
                        -9,
                        -57,
                        24,
                        2,
                        col
                    )
                    do
                        local i = 0
                        while i < 6 do
                            r(
                                nil,
                                c,
                                -8 + i * 4,
                                -55,
                                3,
                                1,
                                col
                            )
                            i = i + 1
                        end
                    end
                    local dk = shadeHex(nil, col, 0.62)
                    do
                        local yy = -64
                        while yy <= -58 do
                            do
                                local xx = -12 + __band(yy / 3, 1) * 2
                                while xx < 14 do
                                    r(
                                        nil,
                                        c,
                                        xx,
                                        yy,
                                        2,
                                        1,
                                        hi
                                    )
                                    r(
                                        nil,
                                        c,
                                        xx + 1,
                                        yy + 1,
                                        1,
                                        1,
                                        dk
                                    )
                                    xx = xx + 4
                                end
                            end
                            yy = yy + 3
                        end
                    end
                    do
                        local yy = -54
                        while yy < -48 do
                            r(
                                nil,
                                c,
                                -13,
                                yy,
                                2,
                                1,
                                hi
                            )
                            r(
                                nil,
                                c,
                                -11,
                                yy + 1,
                                1,
                                1,
                                dk
                            )
                            yy = yy + 3
                        end
                    end
                    break
                end
            end
            ____cond28 = ____cond28 or ____switch28 == "curly"
            if ____cond28 then
                do
                    local dk = shadeHex(nil, col, 0.35)
                    local hl = shadeHex(nil, col, 2.6)
                    local ____t_result_18
                    if __t(H.fade) then
                        ____t_result_18 = H.fade
                    else
                        ____t_result_18 = col
                    end
                    local fade = ____t_result_18
                    r(
                        nil,
                        c,
                        -12,
                        -60,
                        4,
                        12,
                        fade
                    )
                    r(
                        nil,
                        c,
                        -12,
                        -60,
                        1,
                        12,
                        shadeHex(nil, fade, 0.8)
                    )
                    r(
                        nil,
                        c,
                        11,
                        -58,
                        3,
                        3,
                        fade
                    )
                    local curls = __arrL(
                        {
                            __arrL({-4, -70, 4}, 3),
                            __arrL({3, -71, 4}, 3),
                            __arrL({10, -69, 4}, 3),
                            __arrL({-11, -66, 4}, 3),
                            __arrL({-4, -65, 4}, 3),
                            __arrL({3, -66, 4}, 3),
                            __arrL({10, -64, 4}, 3),
                            __arrL({-12, -61, 3}, 3),
                            __arrL({15, -61, 3}, 3),
                            __arrL({-1, -59, 3}, 3),
                            __arrL({4, -58, 3}, 3),
                            __arrL({9, -59, 3}, 3),
                            __arrL({14, -57, 3}, 3)
                        },
                        13
                    )
                    for ____, ____value in __iterar((curls)) do
                        local xx = ____value[1]
                        local yy = ____value[2]
                        local rr = ____value[3]
                        oval(
                            nil,
                            c,
                            xx,
                            yy,
                            rr + 1,
                            rr + 1,
                            OUT,
                            1
                        )
                    end
                    r(
                        nil,
                        c,
                        -11,
                        -64,
                        25,
                        6,
                        col
                    )
                    __call(
                        curls,
                        "forEach",
                        function(____, ____bindingPattern0, i)
                            local rr
                            local yy
                            local xx
                            xx = ____bindingPattern0[1]
                            yy = ____bindingPattern0[2]
                            rr = ____bindingPattern0[3]
                            local ____oval_21 = oval
                            local ____array_20 = __TS__SparseArrayNew(
                                nil,
                                c,
                                xx,
                                yy,
                                rr,
                                rr
                            )
                            local ____temp_19
                            if __mod(i, 3) == 1 then
                                ____temp_19 = shadeHex(nil, col, 1.25)
                            else
                                ____temp_19 = col
                            end
                            __TS__SparseArrayPush(____array_20, ____temp_19, 1)
                            ____oval_21(__TS__SparseArraySpread(____array_20))
                            r(
                                nil,
                                c,
                                xx - 1,
                                yy - 1,
                                2,
                                2,
                                dk
                            )
                            r(
                                nil,
                                c,
                                xx - rr + 1,
                                yy - rr + 1,
                                2,
                                1,
                                hl
                            )
                            r(
                                nil,
                                c,
                                xx + rr - 2,
                                yy + 1,
                                1,
                                2,
                                hl
                            )
                        end
                    )
                    r(
                        nil,
                        c,
                        2,
                        -55,
                        1,
                        1,
                        col
                    )
                    r(
                        nil,
                        c,
                        12,
                        -54,
                        1,
                        2,
                        col
                    )
                    break
                end
            end
            ____cond28 = ____cond28 or ____switch28 == "wavy"
            if ____cond28 then
                do
                    local hl = "#46505a"
                    local dk = "#07090b"
                    r(
                        nil,
                        c,
                        -13,
                        -65,
                        28,
                        10,
                        OUT
                    )
                    r(
                        nil,
                        c,
                        -12,
                        -64,
                        26,
                        8,
                        col
                    )
                    r(
                        nil,
                        c,
                        -12,
                        -58,
                        4,
                        9,
                        col
                    )
                    r(
                        nil,
                        c,
                        11,
                        -58,
                        3,
                        3,
                        col
                    )
                    poly(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({5, -64}, 2),
                                __arrL({9, -69}, 2),
                                __arrL({15, -68}, 2),
                                __arrL({16, -63}, 2),
                                __arrL({10, -62}, 2)
                            },
                            5
                        ),
                        OUT
                    )
                    poly(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({6, -64}, 2),
                                __arrL({9, -68}, 2),
                                __arrL({14, -67}, 2),
                                __arrL({15, -63}, 2),
                                __arrL({10, -63}, 2)
                            },
                            5
                        ),
                        col
                    )
                    do
                        local k = 0
                        while k < 3 do
                            r(
                                nil,
                                c,
                                -10 + k * 7,
                                -62 + __mod(k, 2),
                                4,
                                1,
                                hl
                            )
                            r(
                                nil,
                                c,
                                -7 + k * 7,
                                -61 + __mod(k, 2),
                                3,
                                1,
                                dk
                            )
                            k = k + 1
                        end
                    end
                    r(
                        nil,
                        c,
                        9,
                        -67,
                        3,
                        1,
                        hl
                    )
                    r(
                        nil,
                        c,
                        2,
                        -57,
                        10,
                        2,
                        col
                    )
                    r(
                        nil,
                        c,
                        4,
                        -55,
                        2,
                        1,
                        col
                    )
                    r(
                        nil,
                        c,
                        -11,
                        -55,
                        2,
                        1,
                        hl
                    )
                    break
                end
            end
            ____cond28 = ____cond28 or ____switch28 == "side"
            if ____cond28 then
                r(
                    nil,
                    c,
                    -13,
                    -64,
                    28,
                    9,
                    OUT
                )
                r(
                    nil,
                    c,
                    -12,
                    -63,
                    26,
                    7,
                    col
                )
                r(
                    nil,
                    c,
                    -12,
                    -58,
                    4,
                    7,
                    col
                )
                r(
                    nil,
                    c,
                    11,
                    -58,
                    3,
                    3,
                    col
                )
                poly(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({-4, -63}, 2),
                            __arrL({16, -60}, 2),
                            __arrL({16, -57}, 2),
                            __arrL({4, -58}, 2),
                            __arrL({-2, -57}, 2)
                        },
                        5
                    ),
                    col
                )
                r(
                    nil,
                    c,
                    -8,
                    -62,
                    16,
                    1,
                    hi
                )
                r(
                    nil,
                    c,
                    2,
                    -60,
                    10,
                    1,
                    hi
                )
                break
            end
            ____cond28 = ____cond28 or ____switch28 == "mullet"
            if ____cond28 then
                r(
                    nil,
                    c,
                    -13,
                    -65,
                    28,
                    10,
                    OUT
                )
                r(
                    nil,
                    c,
                    -12,
                    -64,
                    26,
                    8,
                    col
                )
                r(
                    nil,
                    c,
                    -12,
                    -58,
                    5,
                    12,
                    col
                )
                r(
                    nil,
                    c,
                    6,
                    -58,
                    9,
                    3,
                    col
                )
                r(
                    nil,
                    c,
                    -8,
                    -63,
                    14,
                    1,
                    "#3a4046"
                )
                r(
                    nil,
                    c,
                    -11,
                    -56,
                    1,
                    9,
                    "#30363b"
                )
                break
            end
            ____cond28 = ____cond28 or ____switch28 == "short"
            if ____cond28 then
                r(
                    nil,
                    c,
                    -12,
                    -63,
                    26,
                    9,
                    col
                )
                r(
                    nil,
                    c,
                    -9,
                    -65,
                    20,
                    4,
                    col
                )
                r(
                    nil,
                    c,
                    -12,
                    -58,
                    4,
                    8,
                    col
                )
                r(
                    nil,
                    c,
                    11,
                    -58,
                    4,
                    4,
                    col
                )
                r(
                    nil,
                    c,
                    -8,
                    -62,
                    14,
                    2,
                    hi
                )
                break
            end
            ____cond28 = ____cond28 or ____switch28 == "fringe"
            if ____cond28 then
                r(
                    nil,
                    c,
                    -13,
                    -64,
                    28,
                    9,
                    OUT
                )
                r(
                    nil,
                    c,
                    -12,
                    -63,
                    26,
                    8,
                    col
                )
                r(
                    nil,
                    c,
                    -12,
                    -58,
                    4,
                    8,
                    col
                )
                r(
                    nil,
                    c,
                    2,
                    -57,
                    12,
                    3,
                    col
                )
                r(
                    nil,
                    c,
                    -7,
                    -62,
                    13,
                    1,
                    hi
                )
                break
            end
            ____cond28 = ____cond28 or ____switch28 == "buzz"
            if ____cond28 then
                r(
                    nil,
                    c,
                    -12,
                    -62,
                    26,
                    5,
                    col
                )
                r(
                    nil,
                    c,
                    -12,
                    -58,
                    3,
                    6,
                    col
                )
                r(
                    nil,
                    c,
                    -8,
                    -61,
                    14,
                    1,
                    hi
                )
                break
            end
            ____cond28 = ____cond28 or ____switch28 == "bald"
            if ____cond28 then
                r(
                    nil,
                    c,
                    -12,
                    -55,
                    3,
                    7,
                    col
                )
                r(
                    nil,
                    c,
                    -9,
                    -57,
                    3,
                    3,
                    col
                )
                r(
                    nil,
                    c,
                    -4,
                    -61,
                    12,
                    2,
                    "#f0d2b8"
                )
                break
            end
            ____cond28 = ____cond28 or ____switch28 == "long"
            if ____cond28 then
                r(
                    nil,
                    c,
                    -12,
                    -64,
                    27,
                    9,
                    OUT
                )
                r(
                    nil,
                    c,
                    -11,
                    -63,
                    25,
                    8,
                    col
                )
                r(
                    nil,
                    c,
                    -12,
                    -58,
                    5,
                    16,
                    col
                )
                r(
                    nil,
                    c,
                    3,
                    -58,
                    12,
                    3,
                    col
                )
                r(
                    nil,
                    c,
                    -6,
                    -62,
                    12,
                    1,
                    hi
                )
                break
            end
            ____cond28 = ____cond28 or ____switch28 == "ponytail"
            if ____cond28 then
                r(
                    nil,
                    c,
                    -12,
                    -63,
                    26,
                    8,
                    col
                )
                r(
                    nil,
                    c,
                    -12,
                    -58,
                    4,
                    9,
                    col
                )
                r(
                    nil,
                    c,
                    4,
                    -57,
                    10,
                    2,
                    col
                )
                r(
                    nil,
                    c,
                    -7,
                    -62,
                    13,
                    1,
                    hi
                )
                break
            end
            ____cond28 = ____cond28 or ____switch28 == "bun"
            if ____cond28 then
                r(
                    nil,
                    c,
                    -12,
                    -63,
                    26,
                    8,
                    col
                )
                r(
                    nil,
                    c,
                    -12,
                    -58,
                    4,
                    8,
                    col
                )
                r(
                    nil,
                    c,
                    10,
                    -58,
                    4,
                    3,
                    col
                )
                local ____array_23 = __TS__SparseArrayNew(
                    nil,
                    c,
                    -6,
                    -62,
                    10,
                    1
                )
                local ____t_result_22
                if __t(H.gray) then
                    ____t_result_22 = H.gray
                else
                    ____t_result_22 = hi
                end
                __TS__SparseArrayPush(____array_23, ____t_result_22)
                r(__TS__SparseArraySpread(____array_23))
                local ____c_25 = c
                local ____temp_26 = -61
                local ____t_result_24
                if __t(H.gray) then
                    ____t_result_24 = H.gray
                else
                    ____t_result_24 = hi
                end
                r(
                    nil,
                    ____c_25,
                    2,
                    ____temp_26,
                    8,
                    1,
                    ____t_result_24
                )
                break
            end
            ____cond28 = ____cond28 or ____switch28 == "curlyShort"
            if ____cond28 then
                do
                    local i = 0
                    while i < 8 do
                        local ____oval_29 = oval
                        local ____array_28 = __TS__SparseArrayNew(
                            nil,
                            c,
                            -11 + i * 3.6,
                            -61 + __mod(i, 2) * 2,
                            3,
                            3
                        )
                        local ____t_result_27
                        if __t(__mod(i, 2)) then
                            ____t_result_27 = col
                        else
                            ____t_result_27 = "#bdb8b0"
                        end
                        __TS__SparseArrayPush(____array_28, ____t_result_27, 2)
                        ____oval_29(__TS__SparseArraySpread(____array_28))
                        i = i + 1
                    end
                end
                r(
                    nil,
                    c,
                    -13,
                    -58,
                    4,
                    8,
                    col
                )
                do
                    local i = 0
                    while i < 3 do
                        oval(
                            nil,
                            c,
                            -12,
                            -56 + i * 3,
                            2,
                            2,
                            col,
                            2
                        )
                        i = i + 1
                    end
                end
                break
            end
            ____cond28 = ____cond28 or ____switch28 == "curlyBig"
            if ____cond28 then
                r(
                    nil,
                    c,
                    -12,
                    -63,
                    26,
                    7,
                    col
                )
                do
                    local i = 0
                    while i < 6 do
                        local ____oval_32 = oval
                        local ____array_31 = __TS__SparseArrayNew(
                            nil,
                            c,
                            -9 + i * 4.5,
                            -63,
                            3,
                            3
                        )
                        local ____t_result_30
                        if __t(__mod(i, 2)) then
                            ____t_result_30 = col
                        else
                            ____t_result_30 = "#2e211b"
                        end
                        __TS__SparseArrayPush(____array_31, ____t_result_30, 2)
                        ____oval_32(__TS__SparseArraySpread(____array_31))
                        i = i + 1
                    end
                end
                r(
                    nil,
                    c,
                    5,
                    -58,
                    9,
                    3,
                    col
                )
                break
            end
            ____cond28 = ____cond28 or ____switch28 == "curlers"
            if ____cond28 then
                r(
                    nil,
                    c,
                    -12,
                    -63,
                    26,
                    8,
                    col
                )
                r(
                    nil,
                    c,
                    -12,
                    -58,
                    4,
                    8,
                    col
                )
                do
                    local i = 0
                    while i < 4 do
                        r(
                            nil,
                            c,
                            -10 + i * 7,
                            -66,
                            6,
                            4,
                            OUT
                        )
                        r(
                            nil,
                            c,
                            -9 + i * 7,
                            -65,
                            4,
                            2,
                            H.curler
                        )
                        i = i + 1
                    end
                end
                r(
                    nil,
                    c,
                    -13,
                    -60,
                    2,
                    4,
                    H.curler
                )
                break
            end
            ____cond28 = ____cond28 or ____switch28 == "quiff"
            if ____cond28 then
                r(
                    nil,
                    c,
                    -12,
                    -62,
                    26,
                    7,
                    col
                )
                r(
                    nil,
                    c,
                    -12,
                    -58,
                    3,
                    6,
                    col
                )
                poly(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({-6, -62}, 2),
                            __arrL({2, -71}, 2),
                            __arrL({14, -69}, 2),
                            __arrL({15, -63}, 2),
                            __arrL({6, -62}, 2)
                        },
                        5
                    ),
                    col
                )
                poly(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({3, -70}, 2),
                            __arrL({13, -69}, 2),
                            __arrL({14, -66}, 2),
                            __arrL({6, -66}, 2)
                        },
                        4
                    ),
                    H.tips
                )
                r(
                    nil,
                    c,
                    -10,
                    -60,
                    4,
                    2,
                    "#8a8a8a"
                )
                break
            end
        until true
    end
    function hat(self, c, S)
        local H = S.hat
        if not __t(H) then
            return
        end
        if H.kind == "cap" then
            r(
                nil,
                c,
                -13,
                -66,
                28,
                9,
                OUT
            )
            r(
                nil,
                c,
                -12,
                -65,
                26,
                7,
                H.color
            )
            r(
                nil,
                c,
                8,
                -59,
                13,
                3,
                OUT
            )
            r(
                nil,
                c,
                9,
                -59,
                11,
                2,
                H.color
            )
            if __t(H.band) then
                r(
                    nil,
                    c,
                    -12,
                    -60,
                    26,
                    2,
                    H.band
                )
            end
            r(
                nil,
                c,
                -6,
                -64,
                10,
                1,
                "#ffffff55"
            )
        end
        if H.kind == "capback" then
            r(
                nil,
                c,
                -13,
                -66,
                28,
                9,
                OUT
            )
            r(
                nil,
                c,
                -12,
                -65,
                26,
                7,
                H.color
            )
            r(
                nil,
                c,
                -20,
                -60,
                10,
                3,
                OUT
            )
            r(
                nil,
                c,
                -19,
                -60,
                8,
                2,
                H.color
            )
            r(
                nil,
                c,
                2,
                -64,
                6,
                2,
                "#ffffff66"
            )
        end
        if H.kind == "helmet" then
            oval(
                nil,
                c,
                0,
                -57,
                17,
                13,
                OUT,
                2
            )
            oval(
                nil,
                c,
                0,
                -58,
                16,
                12,
                H.color,
                2
            )
            r(
                nil,
                c,
                -16,
                -55,
                7,
                13,
                H.color
            )
            r(
                nil,
                c,
                -9,
                -64,
                14,
                2,
                "#ffffff55"
            )
            r(
                nil,
                c,
                6,
                -59,
                12,
                3,
                H.visor
            )
            r(
                nil,
                c,
                -2,
                -66,
                6,
                2,
                "#f2f2f2"
            )
        end
        if H.kind == "straw" then
            r(
                nil,
                c,
                -20,
                -59,
                42,
                4,
                "#5a4a2a"
            )
            r(
                nil,
                c,
                -19,
                -60,
                40,
                3,
                H.color
            )
            r(
                nil,
                c,
                -12,
                -70,
                25,
                11,
                "#5a4a2a"
            )
            r(
                nil,
                c,
                -11,
                -69,
                23,
                10,
                H.color
            )
            r(
                nil,
                c,
                -11,
                -62,
                23,
                2,
                "#8a5a3a"
            )
            do
                local i = 0
                while i < 6 do
                    r(
                        nil,
                        c,
                        -9 + i * 4,
                        -68,
                        1,
                        6,
                        "#c4a050"
                    )
                    i = i + 1
                end
            end
        end
        if H.kind == "rancher" then
            r(
                nil,
                c,
                -22,
                -59,
                46,
                4,
                OUT
            )
            r(
                nil,
                c,
                -21,
                -59,
                44,
                3,
                H.color
            )
            r(
                nil,
                c,
                -12,
                -71,
                25,
                13,
                OUT
            )
            r(
                nil,
                c,
                -11,
                -70,
                23,
                12,
                H.color
            )
            r(
                nil,
                c,
                -4,
                -71,
                8,
                2,
                shadeHex(nil, H.color, 0.7)
            )
            r(
                nil,
                c,
                -11,
                -62,
                23,
                2,
                H.band
            )
        end
    end
    function item(self, c, S, hx, hy, t, o)
        repeat
            local ____switch70 = S.item
            local ____cond70 = ____switch70 == "phone"
            if ____cond70 then
                r(
                    nil,
                    c,
                    hx - 1,
                    hy - 10,
                    6,
                    11,
                    OUT
                )
                r(
                    nil,
                    c,
                    hx,
                    hy - 9,
                    4,
                    9,
                    "#3f5f7a"
                )
                r(
                    nil,
                    c,
                    hx + 1,
                    hy - 8,
                    2,
                    3,
                    "#9fd4e6"
                )
                break
            end
            ____cond70 = ____cond70 or ____switch70 == "keys"
            if ____cond70 then
                r(
                    nil,
                    c,
                    hx + 2,
                    hy + 2,
                    2,
                    6,
                    "#c8c4b4"
                )
                r(
                    nil,
                    c,
                    hx,
                    hy + 6,
                    6,
                    3,
                    "#d9b347"
                )
                break
            end
            ____cond70 = ____cond70 or ____switch70 == "map"
            if ____cond70 then
                r(
                    nil,
                    c,
                    hx,
                    hy - 8,
                    15,
                    11,
                    "#5a4a32"
                )
                r(
                    nil,
                    c,
                    hx + 1,
                    hy - 7,
                    13,
                    9,
                    "#efe2b8"
                )
                r(
                    nil,
                    c,
                    hx + 3,
                    hy - 5,
                    4,
                    2,
                    "#7cb86a"
                )
                r(
                    nil,
                    c,
                    hx + 8,
                    hy - 3,
                    4,
                    3,
                    "#6aa2c8"
                )
                r(
                    nil,
                    c,
                    hx + 5,
                    hy - 6,
                    1,
                    7,
                    "#c4504a"
                )
                break
            end
            ____cond70 = ____cond70 or ____switch70 == "cooler"
            if ____cond70 then
                r(
                    nil,
                    c,
                    hx - 6,
                    hy - 2,
                    18,
                    13,
                    OUT
                )
                r(
                    nil,
                    c,
                    hx - 5,
                    hy - 1,
                    16,
                    11,
                    "#eef4f6"
                )
                r(
                    nil,
                    c,
                    hx - 5,
                    hy - 1,
                    16,
                    3,
                    "#3e7cc0"
                )
                r(
                    nil,
                    c,
                    hx - 1,
                    hy + 3,
                    8,
                    2,
                    "#d8504a"
                )
                break
            end
            ____cond70 = ____cond70 or ____switch70 == "skate"
            if ____cond70 then
                r(
                    nil,
                    c,
                    hx - 4,
                    hy - 16,
                    6,
                    30,
                    OUT
                )
                r(
                    nil,
                    c,
                    hx - 3,
                    hy - 15,
                    4,
                    28,
                    "#c8763a"
                )
                r(
                    nil,
                    c,
                    hx - 6,
                    hy - 12,
                    2,
                    3,
                    "#e8e2d0"
                )
                r(
                    nil,
                    c,
                    hx + 2,
                    hy - 12,
                    2,
                    3,
                    "#e8e2d0"
                )
                r(
                    nil,
                    c,
                    hx - 6,
                    hy + 8,
                    2,
                    3,
                    "#e8e2d0"
                )
                r(
                    nil,
                    c,
                    hx + 2,
                    hy + 8,
                    2,
                    3,
                    "#e8e2d0"
                )
                break
            end
            ____cond70 = ____cond70 or ____switch70 == "cane"
            if ____cond70 then
                limb(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({hx + 1, hy}, 2),
                            __arrL({hx + 3, hy + 22}, 2)
                        },
                        2
                    ),
                    3,
                    "#5a3a24"
                )
                r(
                    nil,
                    c,
                    hx - 2,
                    hy - 2,
                    6,
                    3,
                    "#5a3a24"
                )
                break
            end
            ____cond70 = ____cond70 or ____switch70 == "wrench"
            if ____cond70 then
                r(
                    nil,
                    c,
                    hx + 1,
                    hy - 14,
                    3,
                    15,
                    "#9aa3a6"
                )
                r(
                    nil,
                    c,
                    hx - 1,
                    hy - 17,
                    7,
                    4,
                    "#9aa3a6"
                )
                r(
                    nil,
                    c,
                    hx + 1,
                    hy - 16,
                    3,
                    2,
                    OUT
                )
                break
            end
            ____cond70 = ____cond70 or ____switch70 == "book"
            if ____cond70 then
                r(
                    nil,
                    c,
                    hx - 2,
                    hy - 10,
                    14,
                    11,
                    "#3a2430"
                )
                r(
                    nil,
                    c,
                    hx - 1,
                    hy - 9,
                    12,
                    9,
                    "#7a3a4a"
                )
                r(
                    nil,
                    c,
                    hx + 4,
                    hy - 9,
                    1,
                    9,
                    "#f0e4c8"
                )
                break
            end
            ____cond70 = ____cond70 or ____switch70 == "gadget"
            if ____cond70 then
                r(
                    nil,
                    c,
                    hx - 2,
                    hy - 8,
                    11,
                    9,
                    OUT
                )
                r(
                    nil,
                    c,
                    hx - 1,
                    hy - 7,
                    9,
                    7,
                    "#7a7f74"
                )
                r(
                    nil,
                    c,
                    hx + 3,
                    hy - 15,
                    1,
                    8,
                    "#9aa3a6"
                )
                r(
                    nil,
                    c,
                    hx + 2,
                    hy - 17,
                    3,
                    3,
                    math.sin(t * 6) > 0 and "#ff5a4a" or "#7a2a2a"
                )
                r(
                    nil,
                    c,
                    hx,
                    hy - 5,
                    3,
                    2,
                    "#f2c94c"
                )
                break
            end
            ____cond70 = ____cond70 or ____switch70 == "mic"
            if ____cond70 then
                r(
                    nil,
                    c,
                    hx + 1,
                    hy - 4,
                    3,
                    9,
                    "#2a2a30"
                )
                oval(
                    nil,
                    c,
                    hx + 2,
                    hy - 7,
                    4,
                    4,
                    "#b8bcc4",
                    2
                )
                r(
                    nil,
                    c,
                    hx,
                    hy - 9,
                    2,
                    1,
                    "#ffffff"
                )
                break
            end
            ____cond70 = ____cond70 or ____switch70 == "biscuit"
            if ____cond70 then
                r(
                    nil,
                    c,
                    hx - 2,
                    hy - 2,
                    14,
                    12,
                    "#7a5a3a"
                )
                r(
                    nil,
                    c,
                    hx - 1,
                    hy - 1,
                    12,
                    10,
                    "#e9d6a8"
                )
                do
                    local i = 0
                    while i < 3 do
                        oval(
                            nil,
                            c,
                            hx + 2 + i * 3,
                            hy - 3,
                            2,
                            2,
                            "#fff3cf",
                            2
                        )
                        i = i + 1
                    end
                end
                break
            end
            ____cond70 = ____cond70 or ____switch70 == "selfie"
            if ____cond70 then
                do
                    limb(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({hx + 2, hy}, 2),
                                __arrL({hx + 12, hy - 18}, 2)
                            },
                            2
                        ),
                        2,
                        "#2a2a30"
                    )
                    r(
                        nil,
                        c,
                        hx + 9,
                        hy - 28,
                        9,
                        12,
                        OUT
                    )
                    r(
                        nil,
                        c,
                        hx + 10,
                        hy - 27,
                        7,
                        10,
                        "#2c3a4a"
                    )
                    local on = math.sin(t * 4) > 0.2
                    oval(
                        nil,
                        c,
                        hx + 13,
                        hy - 22,
                        9,
                        9,
                        __t(on) and "#fff6d0" or "#d8d0b0",
                        2
                    )
                    oval(
                        nil,
                        c,
                        hx + 13,
                        hy - 22,
                        6,
                        6,
                        "#2c3a4a",
                        2
                    )
                    r(
                        nil,
                        c,
                        hx + 11,
                        hy - 25,
                        5,
                        6,
                        "#3f6f9a"
                    )
                    break
                end
            end
            ____cond70 = ____cond70 or ____switch70 == "mug"
            if ____cond70 then
                r(
                    nil,
                    c,
                    hx - 1,
                    hy - 7,
                    9,
                    9,
                    OUT
                )
                r(
                    nil,
                    c,
                    hx,
                    hy - 6,
                    7,
                    7,
                    "#e8e2d4"
                )
                r(
                    nil,
                    c,
                    hx + 7,
                    hy - 4,
                    3,
                    4,
                    "#e8e2d4"
                )
                r(
                    nil,
                    c,
                    hx + 1,
                    hy - 6,
                    5,
                    2,
                    "#5a3624"
                )
                do
                    local i = 0
                    while i < 2 do
                        r(
                            nil,
                            c,
                            hx + 1 + i * 3,
                            hy - 11 - math.floor(math.sin(t * 3 + i) * 2 + 0.5),
                            1,
                            3,
                            "#e8f0f0aa"
                        )
                        i = i + 1
                    end
                end
                break
            end
            ____cond70 = ____cond70 or ____switch70 == "pad"
            if ____cond70 then
                r(
                    nil,
                    c,
                    hx - 6,
                    hy - 3,
                    14,
                    7,
                    OUT
                )
                r(
                    nil,
                    c,
                    hx - 5,
                    hy - 2,
                    12,
                    5,
                    "#3a3f48"
                )
                r(
                    nil,
                    c,
                    hx - 3,
                    hy - 1,
                    2,
                    2,
                    "#e8e2d0"
                )
                r(
                    nil,
                    c,
                    hx + 3,
                    hy - 1,
                    2,
                    2,
                    S.top
                )
                break
            end
        until true
    end
    function shadeHex(self, hex, k)
        if not __re_test(
            __re("^#[0-9a-f]{6}$", "i"),
            hex
        ) then
            return hex
        end
        local n = __TS__ParseInt(
            __call(hex, "slice", 1),
            16
        )
        local function f(____, v)
            return math.max(
                0,
                math.min(
                    255,
                    math.floor(v * k + 0.5)
                )
            )
        end
        return __add(
            "#",
            __call(
                __call(
                    __arrL(
                        {
                            __band(
                                __shr(n, 16),
                                255
                            ),
                            __band(
                                __shr(n, 8),
                                255
                            ),
                            __band(n, 255)
                        },
                        3
                    ),
                    "map",
                    function(____, v) return __call(
                        __call(
                            f(nil, v),
                            "toString",
                            16
                        ),
                        "padStart",
                        2,
                        "0"
                    ) end
                ),
                "join",
                ""
            )
        )
    end
    function person(self, c, ____type, S, x, y, o)
        c:save()
        c.imageSmoothingEnabled = false
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        local ____t_result_33
        if __t(o.scale) then
            ____t_result_33 = o.scale
        else
            ____t_result_33 = 1
        end
        local sc = ____t_result_33
        local ____t_result_34
        if __t(S.h) then
            ____t_result_34 = S.h
        else
            ____t_result_34 = 1
        end
        local hk = ____t_result_34
        c:scale(
            (__lt(o.facing, 0) and -1 or 1) * sc,
            sc * hk
        )
        if __isFiniteN(o.opacity) then
            c.globalAlpha = c.globalAlpha * math.max(
                0,
                math.min(1, o.opacity)
            )
        end
        local ____t_result_37
        local ____t_36 = __t
        local ____TS__Number_result_35 = __TS__Number(o.frame)
        __O[386] = ____TS__Number_result_35
        if ____t_36(____TS__Number_result_35) then
            ____t_result_37 = __O[386]
        else
            ____t_result_37 = 0
        end
        local t = ____t_result_37
        local moving = not not __t(o.moving) or __TS__Number(o.speed) > 8
        local air = o.grounded == false
        local ____t_result_40
        local ____t_39 = __t
        local ____t_result_38
        if __t(moving) then
            ____t_result_38 = not __t(air)
        else
            ____t_result_38 = moving
        end
        if ____t_39(____t_result_38) then
            ____t_result_40 = math.sin(t * 9)
        else
            ____t_result_40 = 0
        end
        local walk = ____t_result_40
        local ____t_result_43
        local ____t_42 = __t
        local ____t_result_41
        if __t(moving) then
            ____t_result_41 = not __t(air)
        else
            ____t_result_41 = moving
        end
        if ____t_42(____t_result_41) then
            ____t_result_43 = math.floor(math.abs(math.cos(t * 9)) * 2 + 0.5)
        else
            ____t_result_43 = math.floor(math.sin(t * 2) * 0.7 + 0.5)
        end
        local bob = ____t_result_43
        local attack = not not __t(o.attack)
        local ____t_result_45
        if __t(attack) then
            local ____isFiniteN_result_44
            if __isFiniteN(o.attackProgress) then
                ____isFiniteN_result_44 = o.attackProgress
            else
                ____isFiniteN_result_44 = 0.5 + math.sin(t * 7) * 0.5
            end
            ____t_result_45 = math.max(
                0,
                math.sin(____isFiniteN_result_44 * math.pi)
            )
        else
            ____t_result_45 = 0
        end
        local strike = ____t_result_45
        local belly = S.build == "belly"
        local strong = S.build == "strong"
        local slim = S.build == "slim"
        local chubby = S.build == "chubby"
        local wide = __t(belly) and 18 or (__t(strong) and 17 or (__t(slim) and 10 or (__t(chubby) and 14 or 12)))
        local skin = S.skin
        local shade = S.shade
        local ____t_result_48
        local ____t_47 = __t
        local ____t_result_46
        if __t(S.shiver) then
            ____t_result_46 = S.shiver
        else
            ____t_result_46 = o.cold
        end
        if ____t_47(____t_result_46) then
            ____t_result_48 = math.floor(math.sin(t * 40) + 0.5)
        else
            ____t_result_48 = 0
        end
        local shiver = ____t_result_48
        local ____t_50 = __t
        local ____t_result_49
        if __t(S.twitch) then
            ____t_result_49 = math.sin(t * 13) > 0.85
        else
            ____t_result_49 = S.twitch
        end
        local twitch = ____t_50(____t_result_49) and 1 or 0
        local ____t_result_53
        local ____t_52 = __t
        local ____t_result_51
        if __t(o.emotion) then
            ____t_result_51 = o.emotion
        else
            ____t_result_51 = S.mood
        end
        __O[387] = ____t_result_51
        if ____t_52(____t_result_51) then
            ____t_result_53 = __O[387]
        else
            ____t_result_53 = ""
        end
        local mood = ____t_result_53
        if __t(not __t(o.duelo) or not __t(air)) then
            oval(
                nil,
                c,
                0,
                -1,
                __t(belly) and 23 or (__t(strong) and 21 or (__t(chubby) and 19 or 17)),
                3,
                "#2e433d",
                2
            )
        end
        local ____t_58 = __t
        local ____t_result_57
        if __t(o.rage) then
            ____t_result_57 = o.rage
        else
            local ____t_result_56
            local ____t_55 = __t
            local ____temp_54 = ____type == "c2_breno"
            __O[388] = ____temp_54
            if ____t_55(____temp_54) then
                ____t_result_56 = o.powered
            else
                ____t_result_56 = __O[388]
            end
            ____t_result_57 = ____t_result_56
        end
        if ____t_58(____t_result_57) then
            c:save()
            c.globalAlpha = c.globalAlpha * 0.3
            oval(
                nil,
                c,
                0,
                -34,
                30 + math.sin(t * 11) * 3,
                42,
                "#f26154",
                3
            )
            c:restore()
        end
        for ____, side in __iterar((__arrL({-1, 1}, 2))) do
            local fx = side * 7 + math.floor(walk * 12 * side + 0.5)
            local ____t_result_61
            local ____t_60 = __t
            local ____t_result_59
            if __t(moving) then
                ____t_result_59 = not __t(air)
            else
                ____t_result_59 = moving
            end
            if ____t_60(____t_result_59) then
                ____t_result_61 = math.max(
                    0,
                    math.cos(t * 9 + (side > 0 and 0 or math.pi))
                ) * 6
            else
                ____t_result_61 = 0
            end
            local fy = ____t_result_61
            if __t(air) then
                fx = side > 0 and 10 or -12
                fy = side > 0 and 3 or 11
            end
            local legW = __t(strong) and 11 or (__t(slim) and 7 or 9)
            limb(
                nil,
                c,
                __arrL(
                    {
                        __arrL({side * 7, -25}, 2),
                        __arrL({side * 7 + walk * side * 4, -12}, 2),
                        __arrL({fx, -4 - fy}, 2)
                    },
                    3
                ),
                legW,
                LEGLINE
            )
            local ____limb_65 = limb
            local ____array_64 = __TS__SparseArrayNew(
                nil,
                c,
                __arrL(
                    {
                        __arrL({side * 7, -25}, 2),
                        __arrL({side * 7 + walk * side * 4, -12}, 2),
                        __arrL({fx, -4 - fy}, 2)
                    },
                    3
                ),
                __t(strong) and 7 or (__t(slim) and 4 or 5)
            )
            local ____t_result_63
            if __t(S.skirt) then
                ____t_result_63 = skin
            else
                local ____t_result_62
                if __t(S.pants) then
                    ____t_result_62 = S.pants
                else
                    ____t_result_62 = "#3d4852"
                end
                ____t_result_63 = ____t_result_62
            end
            __TS__SparseArrayPush(____array_64, ____t_result_63)
            ____limb_65(__TS__SparseArraySpread(____array_64))
            local ____array_67 = __TS__SparseArrayNew(
                nil,
                c,
                fx - 4,
                -6 - fy,
                13,
                6
            )
            local ____t_result_66
            if __t(S.shoes) then
                ____t_result_66 = S.shoes
            else
                ____t_result_66 = "#26353a"
            end
            __TS__SparseArrayPush(____array_67, ____t_result_66)
            r(__TS__SparseArraySpread(____array_67))
            local ____array_69 = __TS__SparseArrayNew(
                nil,
                c,
                fx - 3,
                -2 - fy,
                11,
                2
            )
            local ____t_result_68
            if __t(S.sole) then
                ____t_result_68 = S.sole
            else
                ____t_result_68 = "#b6b8a6"
            end
            __TS__SparseArrayPush(____array_69, ____t_result_68)
            r(__TS__SparseArraySpread(____array_69))
        end
        c:translate(
            (__t(o.dash) and 5 or math.floor(walk * 1.5 + 0.5)) + shiver,
            -bob + (__t(S.hunch) and 2 or 0)
        )
        if __t(S.hunch) then
            c:rotate(0.06)
        end
        local L = __arrL(
            {
                -wide - 5 + math.floor(walk * 7 + 0.5),
                -18
            },
            2
        )
        local Rh = __arrL(
            {
                wide + 5 - math.floor(walk * 7 + 0.5),
                -18
            },
            2
        )
        if __t(not __t(moving) and not __t(attack)) then
            local p = S.pose
            if __t(p == "phone" and o.item ~= false) then
                Rh = __arrL({wide + 2, -47}, 2)
                L = __arrL({-wide - 3, -22}, 2)
            end
            if p == "thumb" then
                Rh = __arrL(
                    {
                        wide + 12,
                        -32 + math.floor(math.sin(t * 2) + 0.5)
                    },
                    2
                )
                L = __arrL({-wide - 4, -22}, 2)
            end
            if p == "cocky" then
                Rh = __arrL({wide + 2, -30}, 2)
                L = __arrL({-wide + 2, -30}, 2)
            end
            if p == "talk" then
                Rh = __arrL(
                    {
                        wide + 13,
                        -30 + math.floor(math.sin(t * 5) * 3 + 0.5)
                    },
                    2
                )
                L = __arrL({-wide - 4, -21}, 2)
            end
            if p == "hips" then
                Rh = __arrL({wide + 6, -26}, 2)
                L = __arrL({-wide - 6, -26}, 2)
            end
            if p == "offer" then
                Rh = __arrL({wide + 15, -29}, 2)
                L = __arrL({-wide - 4, -22}, 2)
            end
            if p == "carry" then
                Rh = __arrL({wide + 8, -24}, 2)
                L = __arrL({-wide - 4, -21}, 2)
            end
            if p == "cane" then
                Rh = __arrL({wide + 9, -22}, 2)
                L = __arrL({-wide - 3, -22}, 2)
            end
            if p == "read" then
                Rh = __arrL({wide + 6, -32}, 2)
                L = __arrL({wide - 2, -30}, 2)
            end
            if p == "sing" then
                Rh = __arrL(
                    {
                        wide + 4,
                        -44 + math.floor(math.sin(t * 3) * 2 + 0.5)
                    },
                    2
                )
                L = __arrL(
                    {
                        -wide - 12,
                        -36 + math.floor(math.sin(t * 3 + 1) * 3 + 0.5)
                    },
                    2
                )
            end
            if p == "pockets" then
                Rh = __arrL({wide - 3, -22}, 2)
                L = __arrL({-wide + 3, -22}, 2)
            end
            if p == "selfie" then
                Rh = __arrL({wide + 8, -38}, 2)
                L = __arrL({-wide - 2, -30}, 2)
            end
            if p == "mug" then
                Rh = __arrL({wide + 8, -33}, 2)
                L = __arrL({-wide - 4, -22}, 2)
            end
            if p == "fists" then
                Rh = __arrL(
                    {
                        wide + 8,
                        -34 + math.floor(math.sin(t * 4) * 2 + 0.5)
                    },
                    2
                )
                L = __arrL({wide - 2, -36}, 2)
            end
            if p == "game" then
                Rh = __arrL({wide + 2, -29}, 2)
                L = __arrL({wide - 6, -29}, 2)
            end
            if p == "relaxed" then
                Rh = __arrL({wide + 4, -20}, 2)
                L = __arrL({-wide - 3, -20}, 2)
            end
        end
        if __t(attack) then
            Rh = __arrL(
                {
                    wide + 10 + math.floor(strike * 12 + 0.5),
                    -34 - math.floor(strike * 6 + 0.5)
                },
                2
            )
            L = __arrL({-wide + 1, -34}, 2)
        end
        local ____t_73 = __t
        local ____t_result_72
        local ____t_71 = __t
        local ____temp_70 = o.duelo == 2
        __O[389] = ____temp_70
        if ____t_71(____temp_70) then
            ____t_result_72 = attack
        else
            ____t_result_72 = __O[389]
        end
        if ____t_73(____t_result_72) then
            local ____t_result_74
            if __t(air) then
                ____t_result_74 = __arrL({wide + 9, -39}, 2)
            else
                ____t_result_74 = __arrL({wide - 3, -25}, 2)
            end
            Rh = ____t_result_74
            local ____t_result_75
            if __t(air) then
                ____t_result_75 = __arrL({-wide - 9, -38}, 2)
            else
                ____t_result_75 = __arrL({-wide + 1, -24}, 2)
            end
            L = ____t_result_75
        else
            local ____t_79 = __t
            local ____t_result_78
            local ____t_77 = __t
            local ____temp_76 = o.duelo == 3
            __O[390] = ____temp_76
            if ____t_77(____temp_76) then
                ____t_result_78 = attack
            else
                ____t_result_78 = __O[390]
            end
            if ____t_79(____t_result_78) then
                Rh = __arrL(
                    {
                        wide + 8 + math.floor(7 * strike + 0.5),
                        -41
                    },
                    2
                )
                L = __arrL({0, -43}, 2)
            elseif o.duelo == 4 then
                Rh = __arrL(
                    {
                        wide + 6 + (__t(attack) and 8 or 0),
                        __t(attack) and -40 or -23
                    },
                    2
                )
                L = __arrL(
                    {
                        -wide - 7,
                        __t(attack) and -36 or -26
                    },
                    2
                )
            elseif o.duelo == 5 then
                Rh = __arrL({wide + 2, -47}, 2)
                local ____t_result_80
                if __t(attack) then
                    ____t_result_80 = __arrL({wide + 4, -32}, 2)
                else
                    ____t_result_80 = __arrL({-wide - 3, -22}, 2)
                end
                L = ____t_result_80
            end
        end
        if __t(o.charging) then
            L = __arrL({-27, -24}, 2)
            Rh = __arrL({27, -24}, 2)
        end
        if __t(o.reach) then
            Rh = __arrL({wide + 22, -32}, 2)
        end
        local sleeveSkin = S.sleeve == "short" or S.topKind == "tank"
        local armW = __t(strong) and 11 or (__t(slim) and 6 or 8)
        local armIn = __t(strong) and 7 or (__t(slim) and 4 or 5)
        local function hand(self, side)
            local ____gt_result_81
            if __gt(side, 0) then
                ____gt_result_81 = Rh
            else
                ____gt_result_81 = L
            end
            local ____end = ____gt_result_81
            local shoulder = __arrL({side * wide, -36}, 2)
            local elbow = __arrL(
                {
                    side * (wide + 5),
                    -27 + math.floor(walk * side * 3 + 0.5)
                },
                2
            )
            limb(
                nil,
                c,
                __arrL({shoulder, elbow, ____end}, 3),
                armW,
                LINE
            )
            local ____limb_87 = limb
            local ____c_85 = c
            local ____arrL_result_86 = __arrL({shoulder, elbow}, 2)
            local ____temp_84
            if S.topKind == "tank" then
                ____temp_84 = skin
            else
                local ____t_result_83
                if __t(S.topKind == "apron" or S.topKind == "overall") then
                    local ____t_result_82
                    if __t(S.inner) then
                        ____t_result_82 = S.inner
                    else
                        ____t_result_82 = S.top
                    end
                    ____t_result_83 = ____t_result_82
                else
                    ____t_result_83 = S.top
                end
                ____temp_84 = ____t_result_83
            end
            ____limb_87(
                nil,
                ____c_85,
                ____arrL_result_86,
                armIn,
                ____temp_84
            )
            local ____limb_94 = limb
            local ____c_92 = c
            local ____arrL_result_93 = __arrL({elbow, ____end}, 2)
            local ____t_result_91
            local ____t_89 = __t
            local ____t_result_88
            if __t(sleeveSkin) then
                ____t_result_88 = sleeveSkin
            else
                ____t_result_88 = S.topKind == "apron" and not __t(S.inner)
            end
            if ____t_89(____t_result_88) then
                ____t_result_91 = skin
            else
                local ____temp_90
                if S.topKind == "overall" then
                    ____temp_90 = S.inner
                else
                    ____temp_90 = S.top
                end
                ____t_result_91 = ____temp_90
            end
            ____limb_94(
                nil,
                ____c_92,
                ____arrL_result_93,
                armIn,
                ____t_result_91
            )
            local ____t_96 = __t
            local ____t_result_95
            if __t(S.tattoo) then
                ____t_result_95 = __gt(side, 0)
            else
                ____t_result_95 = S.tattoo
            end
            if ____t_96(____t_result_95) then
                r(
                    nil,
                    c,
                    __get(elbow, 0) - 2,
                    __get(elbow, 1) - 2,
                    4,
                    4,
                    S.tattoo
                )
            end
            local ____array_98 = __TS__SparseArrayNew(
                nil,
                c,
                __get(____end, 0) - 3,
                __get(____end, 1) - 3,
                __t(strong) and 8 or 6,
                __t(strong) and 7 or 6
            )
            local ____t_result_97
            if __t(S.gloves) then
                ____t_result_97 = S.gloves
            else
                ____t_result_97 = skin
            end
            __TS__SparseArrayPush(____array_98, ____t_result_97)
            r(__TS__SparseArraySpread(____array_98))
        end
        hand(nil, -1)
        hairBack(nil, c, S)
        local top = S.top
        local edge = shadeHex(nil, top, 0.62)
        if __t(belly) then
            oval(
                nil,
                c,
                1,
                -30,
                23,
                20,
                "#202a31",
                2
            )
            oval(
                nil,
                c,
                1,
                -31,
                20,
                17,
                top,
                2
            )
            r(
                nil,
                c,
                -14,
                -20,
                31,
                3,
                shadeHex(nil, top, 0.55)
            )
        elseif __t(chubby) then
            poly(
                nil,
                c,
                __arrL(
                    {
                        __arrL({-wide - 1, -42}, 2),
                        __arrL({wide + 2, -42}, 2),
                        __arrL({wide + 4, -30}, 2),
                        __arrL({wide + 2, -17}, 2),
                        __arrL({-wide, -17}, 2),
                        __arrL({-wide - 2, -30}, 2)
                    },
                    6
                ),
                "#243037"
            )
            poly(
                nil,
                c,
                __arrL(
                    {
                        __arrL({-wide + 1, -40}, 2),
                        __arrL({wide, -40}, 2),
                        __arrL({wide + 2, -30}, 2),
                        __arrL({wide, -19}, 2),
                        __arrL({-wide + 2, -19}, 2),
                        __arrL({-wide, -30}, 2)
                    },
                    6
                ),
                top
            )
            r(
                nil,
                c,
                -wide + 2,
                -21,
                wide * 2,
                3,
                edge
            )
            r(
                nil,
                c,
                wide - 2,
                -31,
                3,
                8,
                shadeHex(nil, top, 1.35)
            )
        else
            poly(
                nil,
                c,
                __arrL(
                    {
                        __arrL({-wide - 1, -42}, 2),
                        __arrL({wide + 2, -42}, 2),
                        __arrL({wide, -17}, 2),
                        __arrL({-wide, -17}, 2)
                    },
                    4
                ),
                "#243037"
            )
            poly(
                nil,
                c,
                __arrL(
                    {
                        __arrL({-wide + 1, -40}, 2),
                        __arrL({wide, -40}, 2),
                        __arrL({wide - 2, -19}, 2),
                        __arrL({-wide + 2, -19}, 2)
                    },
                    4
                ),
                top
            )
            r(
                nil,
                c,
                -wide + 2,
                -21,
                wide * 2 - 2,
                3,
                edge
            )
        end
        local bx = __t(belly) and 16 or wide - 1
        repeat
            local ____switch117 = S.topKind
            local ____cond117 = ____switch117 == "jacket" or ____switch117 == "hoodie" or ____switch117 == "puffer" or ____switch117 == "cardigan" or ____switch117 == "coat"
            if ____cond117 then
                if __t(S.inner) then
                    r(
                        nil,
                        c,
                        -3,
                        -40,
                        7,
                        __t(belly) and 22 or 19,
                        S.inner
                    )
                end
                r(
                    nil,
                    c,
                    -4,
                    -40,
                    1,
                    __t(belly) and 22 or 19,
                    edge
                )
                r(
                    nil,
                    c,
                    4,
                    -40,
                    1,
                    __t(belly) and 22 or 19,
                    edge
                )
                if S.topKind == "hoodie" then
                    r(
                        nil,
                        c,
                        -bx + 1,
                        -43,
                        9,
                        5,
                        edge
                    )
                    r(
                        nil,
                        c,
                        -bx + 2,
                        -42,
                        7,
                        3,
                        top
                    )
                    r(
                        nil,
                        c,
                        0,
                        -33,
                        1,
                        7,
                        "#e8e2d0"
                    )
                    r(
                        nil,
                        c,
                        3,
                        -33,
                        1,
                        6,
                        "#e8e2d0"
                    )
                end
                if S.topKind == "puffer" then
                    do
                        local k = 0
                        while k < 3 do
                            r(
                                nil,
                                c,
                                -bx + 1,
                                -37 + k * 6,
                                bx * 2 - 2,
                                1,
                                shadeHex(nil, top, 0.8)
                            )
                            k = k + 1
                        end
                    end
                end
                if S.topKind == "coat" then
                    r(
                        nil,
                        c,
                        -wide,
                        -19,
                        wide * 2,
                        5,
                        top
                    )
                    r(
                        nil,
                        c,
                        -wide,
                        -15,
                        wide * 2,
                        1,
                        edge
                    )
                end
                break
            end
            ____cond117 = ____cond117 or ____switch117 == "pullover"
            if ____cond117 then
                r(
                    nil,
                    c,
                    -bx + 1,
                    -44,
                    10,
                    5,
                    edge
                )
                r(
                    nil,
                    c,
                    -bx + 2,
                    -43,
                    8,
                    3,
                    shadeHex(nil, top, 1.6)
                )
                r(
                    nil,
                    c,
                    0,
                    -40,
                    1,
                    6,
                    "#e8e2d0"
                )
                r(
                    nil,
                    c,
                    4,
                    -40,
                    1,
                    5,
                    "#e8e2d0"
                )
                r(
                    nil,
                    c,
                    -bx + 4,
                    -25,
                    bx * 2 - 7,
                    5,
                    shadeHex(nil, top, 1.5)
                )
                r(
                    nil,
                    c,
                    -bx + 5,
                    -24,
                    bx * 2 - 9,
                    3,
                    top
                )
                if S.print == "pizza" then
                    poly(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({-8, -38}, 2),
                                __arrL({9, -38}, 2),
                                __arrL({1, -26}, 2)
                            },
                            3
                        ),
                        "#f4f1e8"
                    )
                    poly(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({-6, -37}, 2),
                                __arrL({7, -37}, 2),
                                __arrL({1, -28}, 2)
                            },
                            3
                        ),
                        "#f2c14e"
                    )
                    r(
                        nil,
                        c,
                        -6,
                        -37,
                        13,
                        2,
                        "#c47a35"
                    )
                    r(
                        nil,
                        c,
                        -2,
                        -34,
                        2,
                        2,
                        "#c8382f"
                    )
                    r(
                        nil,
                        c,
                        2,
                        -33,
                        2,
                        2,
                        "#c8382f"
                    )
                    r(
                        nil,
                        c,
                        0,
                        -30,
                        2,
                        2,
                        "#c8382f"
                    )
                end
                break
            end
            ____cond117 = ____cond117 or ____switch117 == "polo"
            if ____cond117 then
                r(
                    nil,
                    c,
                    -4,
                    -41,
                    9,
                    4,
                    shadeHex(nil, top, 0.85)
                )
                r(
                    nil,
                    c,
                    0,
                    -38,
                    1,
                    6,
                    edge
                )
                if __t(S.pattern) then
                    do
                        local k = 0
                        while k < 6 do
                            r(
                                nil,
                                c,
                                -bx + 3 + __mod(k, 3) * 9,
                                -36 + math.floor(k / 3) * 8,
                                3,
                                3,
                                S.pattern
                            )
                            k = k + 1
                        end
                    end
                end
                break
            end
            ____cond117 = ____cond117 or ____switch117 == "tank"
            if ____cond117 then
                r(
                    nil,
                    c,
                    -bx + 4,
                    -40,
                    5,
                    3,
                    skin
                )
                r(
                    nil,
                    c,
                    bx - 8,
                    -40,
                    5,
                    3,
                    skin
                )
                break
            end
            ____cond117 = ____cond117 or ____switch117 == "apron"
            if ____cond117 then
                r(
                    nil,
                    c,
                    -bx + 4,
                    -38,
                    bx * 2 - 8,
                    __t(belly) and 20 or 19,
                    S.apron
                )
                r(
                    nil,
                    c,
                    -2,
                    -42,
                    1,
                    4,
                    S.apron
                )
                r(
                    nil,
                    c,
                    2,
                    -42,
                    1,
                    4,
                    S.apron
                )
                r(
                    nil,
                    c,
                    -bx + 6,
                    -30,
                    bx * 2 - 12,
                    4,
                    shadeHex(nil, S.apron, 0.85)
                )
                r(
                    nil,
                    c,
                    3,
                    -29,
                    4,
                    2,
                    "#7a9a5a"
                )
                break
            end
            ____cond117 = ____cond117 or ____switch117 == "overall"
            if ____cond117 then
                r(
                    nil,
                    c,
                    -bx + 4,
                    -32,
                    bx * 2 - 8,
                    14,
                    S.pants
                )
                r(
                    nil,
                    c,
                    -bx + 4,
                    -40,
                    3,
                    9,
                    S.pants
                )
                r(
                    nil,
                    c,
                    bx - 7,
                    -40,
                    3,
                    9,
                    S.pants
                )
                r(
                    nil,
                    c,
                    -2,
                    -29,
                    5,
                    3,
                    "#9aa3a6"
                )
                if __t(S.grease) then
                    r(
                        nil,
                        c,
                        -bx + 6,
                        -24,
                        4,
                        2,
                        "#1d1d1d"
                    )
                    r(
                        nil,
                        c,
                        5,
                        -36,
                        3,
                        2,
                        "#1d1d1d"
                    )
                end
                break
            end
            ____cond117 = ____cond117 or ____switch117 == "vest"
            if ____cond117 then
                r(
                    nil,
                    c,
                    -bx + 2,
                    -40,
                    7,
                    21,
                    S.vest
                )
                r(
                    nil,
                    c,
                    bx - 9,
                    -40,
                    7,
                    21,
                    S.vest
                )
                r(
                    nil,
                    c,
                    -bx + 2,
                    -30,
                    7,
                    2,
                    S.vestBand
                )
                r(
                    nil,
                    c,
                    bx - 9,
                    -30,
                    7,
                    2,
                    S.vestBand
                )
                break
            end
            ____cond117 = ____cond117 or ____switch117 == "robe"
            if ____cond117 then
                r(
                    nil,
                    c,
                    -3,
                    -40,
                    2,
                    20,
                    shadeHex(nil, top, 0.7)
                )
                do
                    local k = 0
                    while k < 5 do
                        r(
                            nil,
                            c,
                            -bx + 3 + __mod(k * 7, bx * 2 - 6),
                            -37 + k * 4,
                            2,
                            2,
                            S.robeDots
                        )
                        k = k + 1
                    end
                end
                r(
                    nil,
                    c,
                    -wide,
                    -19,
                    wide * 2,
                    6,
                    top
                )
                break
            end
            ____cond117 = ____cond117 or ____switch117 == "uniform"
            if ____cond117 then
                r(
                    nil,
                    c,
                    -bx + 2,
                    -40,
                    bx * 2 - 4,
                    3,
                    "#2f5f9e"
                )
                r(
                    nil,
                    c,
                    -3,
                    -37,
                    7,
                    4,
                    "#2f5f9e"
                )
                break
            end
            ____cond117 = ____cond117 or ____switch117 == "tee"
            do
                if __t(S.print) then
                    r(
                        nil,
                        c,
                        -4,
                        -34,
                        10,
                        8,
                        S.print
                    )
                    r(
                        nil,
                        c,
                        -2,
                        -32,
                        6,
                        1,
                        "#f2e8e0"
                    )
                    r(
                        nil,
                        c,
                        -2,
                        -29,
                        4,
                        1,
                        "#f2e8e0"
                    )
                end
                if __t(S.sparkle) then
                    do
                        local k = 0
                        while k < 4 do
                            if math.sin(t * 6 + k * 2) > 0.4 then
                                r(
                                    nil,
                                    c,
                                    -bx + 4 + k * 6,
                                    -37 + __mod(k, 2) * 7,
                                    2,
                                    2,
                                    "#ffe4f4"
                                )
                            end
                            k = k + 1
                        end
                    end
                end
            end
        until true
        local ____t_100 = __t
        local ____t_result_99
        if __t(S.uniform) then
            ____t_result_99 = S.uniform
        else
            ____t_result_99 = o.uniform
        end
        if ____t_100(____t_result_99) then
            r(
                nil,
                c,
                -bx + 2,
                -40,
                bx * 2 - 4,
                3,
                "#2f5f9e"
            )
            r(
                nil,
                c,
                -3,
                -37,
                7,
                4,
                "#2f5f9e"
            )
        end
        if __t(S.strap) then
            limb(
                nil,
                c,
                __arrL(
                    {
                        __arrL({-wide + 2, -41}, 2),
                        __arrL({wide - 3, -20}, 2)
                    },
                    2
                ),
                3,
                S.strap
            )
        end
        if __t(S.bag) then
            limb(
                nil,
                c,
                __arrL(
                    {
                        __arrL({wide - 2, -41}, 2),
                        __arrL({-wide + 3, -24}, 2)
                    },
                    2
                ),
                2,
                S.bag
            )
            r(
                nil,
                c,
                -wide - 1,
                -26,
                8,
                7,
                S.bag
            )
        end
        if __t(S.chain) then
            r(
                nil,
                c,
                -5,
                -40,
                12,
                1,
                S.chain
            )
            r(
                nil,
                c,
                -3,
                -39,
                8,
                2,
                S.chain
            )
            r(
                nil,
                c,
                0,
                -37,
                3,
                3,
                S.chain
            )
        end
        if __t(S.collar) then
            local cc = S.collar
            poly(
                nil,
                c,
                __arrL(
                    {
                        __arrL({-7, -42}, 2),
                        __arrL({0, -42}, 2),
                        __arrL({-1, -37}, 2),
                        __arrL({-5, -38}, 2)
                    },
                    4
                ),
                cc
            )
            poly(
                nil,
                c,
                __arrL(
                    {
                        __arrL({1, -42}, 2),
                        __arrL({8, -42}, 2),
                        __arrL({6, -38}, 2),
                        __arrL({2, -37}, 2)
                    },
                    4
                ),
                cc
            )
            r(
                nil,
                c,
                0,
                -37,
                1,
                17,
                shadeHex(nil, S.top, 0.8)
            )
            for ____, yb in __iterar((__arrL({-35, -30, -25}, 3))) do
                r(
                    nil,
                    c,
                    1,
                    yb,
                    1,
                    1,
                    "#f6f6f0"
                )
            end
        end
        if __t(S.skirt) then
            poly(
                nil,
                c,
                __arrL(
                    {
                        __arrL({-wide, -21}, 2),
                        __arrL({wide, -21}, 2),
                        __arrL({wide + 4, -10}, 2),
                        __arrL({-wide - 4, -10}, 2)
                    },
                    4
                ),
                OUT
            )
            poly(
                nil,
                c,
                __arrL(
                    {
                        __arrL({-wide + 1, -20}, 2),
                        __arrL({wide - 1, -20}, 2),
                        __arrL({wide + 2, -11}, 2),
                        __arrL({-wide - 2, -11}, 2)
                    },
                    4
                ),
                S.skirt
            )
        end
        r(
            nil,
            c,
            -4,
            -45,
            10,
            8,
            shade
        )
        r(
            nil,
            c,
            -3,
            -45,
            8,
            8,
            skin
        )
        if __t(S.scarf) then
            r(
                nil,
                c,
                -9,
                -45,
                20,
                6,
                shadeHex(nil, S.scarf, 0.7)
            )
            r(
                nil,
                c,
                -8,
                -45,
                18,
                4,
                S.scarf
            )
            r(
                nil,
                c,
                -10,
                -41,
                5,
                9,
                S.scarf
            )
            r(
                nil,
                c,
                -9,
                -36,
                3,
                1,
                "#f2e8d8"
            )
        end
        r(
            nil,
            c,
            -12,
            -61 + twitch,
            27,
            21,
            OUT
        )
        r(
            nil,
            c,
            -10,
            -59 + twitch,
            23,
            18,
            skin
        )
        r(
            nil,
            c,
            -11,
            -55,
            3,
            12,
            shade
        )
        r(
            nil,
            c,
            12,
            -53,
            4,
            6,
            skin
        )
        r(
            nil,
            c,
            12,
            -48,
            4,
            2,
            shade
        )
        local ey = -53 + twitch
        if mood == "angry" then
            r(
                nil,
                c,
                1,
                ey - 3,
                8,
                2,
                "#2d3031"
            )
            r(
                nil,
                c,
                3,
                ey,
                3,
                3,
                "#2d3031"
            )
        elseif mood == "cry" then
            r(
                nil,
                c,
                2,
                ey + 1,
                5,
                2,
                "#2d3031"
            )
            r(
                nil,
                c,
                3,
                ey + 3,
                2,
                6 + math.floor(math.sin(t * 4) * 2 + 0.5),
                "#8fd0ea"
            )
        elseif mood == "shock" then
            r(
                nil,
                c,
                2,
                ey - 1,
                5,
                5,
                "#f4f2ec"
            )
            r(
                nil,
                c,
                4,
                ey + 1,
                2,
                2,
                "#2d3031"
            )
        elseif mood == "sad" then
            r(
                nil,
                c,
                3,
                ey,
                3,
                3,
                "#2d3031"
            )
            local ____c_106 = c
            local ____temp_107 = ey - 3
            local ____shadeHex_105 = shadeHex
            local ____t_result_104
            local ____t_103 = __t
            local ____opt_101 = S.hair
            if ____opt_101 ~= nil then
                ____opt_101 = ____opt_101.color
            end
            __O[391] = ____opt_101
            if ____t_103(____opt_101) then
                ____t_result_104 = __O[391]
            else
                ____t_result_104 = "#3a2a20"
            end
            r(
                nil,
                ____c_106,
                1,
                ____temp_107,
                6,
                1,
                ____shadeHex_105(nil, ____t_result_104, 1)
            )
        else
            r(
                nil,
                c,
                3,
                ey,
                3,
                3,
                "#2d3031"
            )
            if __t(twitch) then
                r(
                    nil,
                    c,
                    2,
                    ey - 1,
                    5,
                    1,
                    "#2d3031"
                )
            end
        end
        if __t(S.glasses) then
            r(
                nil,
                c,
                -1,
                -56,
                12,
                7,
                S.glasses
            )
            r(
                nil,
                c,
                0,
                -55,
                10,
                5,
                "#d8eef4"
            )
            r(
                nil,
                c,
                3,
                -54,
                3,
                3,
                "#2d3031"
            )
            r(
                nil,
                c,
                1,
                -55,
                3,
                1,
                "#ffffff"
            )
            r(
                nil,
                c,
                -9,
                -54,
                10,
                1,
                S.glasses
            )
        end
        if __t(S.stubble) then
            r(
                nil,
                c,
                4,
                -47,
                9,
                1,
                S.stubble
            )
            r(
                nil,
                c,
                6,
                -42,
                5,
                2,
                S.stubble
            )
            r(
                nil,
                c,
                12,
                -44,
                2,
                2,
                S.stubble
            )
        end
        if __t(S.shades) then
            r(
                nil,
                c,
                -1,
                -55,
                13,
                5,
                "#14181c"
            )
            r(
                nil,
                c,
                1,
                -54,
                3,
                1,
                "#5a7a9a"
            )
            r(
                nil,
                c,
                -9,
                -54,
                10,
                1,
                "#14181c"
            )
        end
        if __t(S.goggles) then
            r(
                nil,
                c,
                -12,
                -62,
                27,
                3,
                "#3a3a34"
            )
            r(
                nil,
                c,
                1,
                -63,
                7,
                5,
                S.goggles
            )
            r(
                nil,
                c,
                9,
                -63,
                6,
                5,
                S.goggles
            )
        end
        local ____t_result_108
        if __t(S.lipstick) then
            ____t_result_108 = S.lipstick
        else
            ____t_result_108 = "#855e43"
        end
        local mouthC = ____t_result_108
        local ____t_114 = __t
        local ____t_result_113
        local ____t_112 = __t
        local ____t_result_111
        local ____t_110 = __t
        local ____temp_109 = mood == "happy" or mood == "smug"
        __O[392] = ____temp_109
        if ____t_110(____temp_109) then
            ____t_result_111 = __O[392]
        else
            ____t_result_111 = S.pose == "cocky"
        end
        __O[393] = ____t_result_111
        if ____t_112(____t_result_111) then
            ____t_result_113 = __O[393]
        else
            ____t_result_113 = S.pose == "sing"
        end
        if ____t_114(____t_result_113) then
            r(
                nil,
                c,
                2,
                -45,
                10,
                2,
                mouthC
            )
            r(
                nil,
                c,
                4,
                -45,
                6,
                1,
                "#f9e7c9"
            )
        elseif __t(mood == "sad" or mood == "cry") then
            r(
                nil,
                c,
                3,
                -44,
                7,
                1,
                mouthC
            )
            r(
                nil,
                c,
                2,
                -43,
                2,
                1,
                mouthC
            )
            r(
                nil,
                c,
                9,
                -43,
                2,
                1,
                mouthC
            )
        elseif mood == "angry" then
            r(
                nil,
                c,
                2,
                -45,
                10,
                3,
                "#4a2a22"
            )
            r(
                nil,
                c,
                3,
                -45,
                8,
                1,
                "#f2efe6"
            )
        elseif mood == "shock" then
            r(
                nil,
                c,
                4,
                -46,
                5,
                4,
                "#4a2a22"
            )
        else
            r(
                nil,
                c,
                2,
                -44,
                8,
                2,
                mouthC
            )
        end
        if __t(S.lipstick) then
            r(
                nil,
                c,
                3,
                -45,
                7,
                1,
                S.lipstick
            )
        end
        if __t(S.mustache) then
            r(
                nil,
                c,
                3,
                -48,
                11,
                3,
                S.mustache
            )
            r(
                nil,
                c,
                2,
                -46,
                3,
                2,
                S.mustache
            )
        end
        if __t(S.goatee) then
            r(
                nil,
                c,
                3,
                -42,
                8,
                3,
                S.goatee
            )
            r(
                nil,
                c,
                4,
                -39,
                6,
                2,
                S.goatee
            )
        end
        if __t(S.beard) then
            r(
                nil,
                c,
                -9,
                -50,
                6,
                9,
                S.beard
            )
            r(
                nil,
                c,
                -4,
                -44,
                18,
                4,
                S.beard
            )
            r(
                nil,
                c,
                1,
                -47,
                12,
                2,
                S.beard
            )
            r(
                nil,
                c,
                3,
                -45,
                7,
                1,
                "#7a4a3a"
            )
        end
        if __t(S.earrings) then
            r(
                nil,
                c,
                -9,
                -50,
                3,
                4,
                S.earrings
            )
        end
        hairFront(nil, c, S, t)
        hat(nil, c, S)
        if __t(S.thinGlasses) then
            local g = S.thinGlasses
            r(
                nil,
                c,
                -1,
                -55,
                13,
                2,
                g
            )
            r(
                nil,
                c,
                -1,
                -55,
                1,
                5,
                g
            )
            r(
                nil,
                c,
                11,
                -55,
                1,
                4,
                g
            )
            r(
                nil,
                c,
                0,
                -53,
                11,
                4,
                "#d8eef433"
            )
            r(
                nil,
                c,
                1,
                -53,
                2,
                1,
                "#ffffffaa"
            )
            r(
                nil,
                c,
                -9,
                -54,
                8,
                1,
                g
            )
            r(
                nil,
                c,
                3,
                -53,
                3,
                3,
                "#2d3031"
            )
        end
        if __t(S.headset) then
            r(
                nil,
                c,
                -14,
                -63,
                28,
                3,
                S.headset
            )
            r(
                nil,
                c,
                -15,
                -58,
                5,
                9,
                S.headset
            )
            limb(
                nil,
                c,
                __arrL(
                    {
                        __arrL({-12, -51}, 2),
                        __arrL({-2, -45}, 2),
                        __arrL({6, -44}, 2)
                    },
                    3
                ),
                2,
                S.headset
            )
            r(
                nil,
                c,
                5,
                -45,
                3,
                2,
                "#5ae0d0"
            )
        end
        hand(nil, 1)
        local ____t_120 = __t
        local ____t_result_119
        local ____t_118 = __t
        local ____t_result_117
        local ____t_116 = __t
        local ____t_result_115
        if __t(S.item) then
            ____t_result_115 = not __t(attack)
        else
            ____t_result_115 = S.item
        end
        __O[394] = ____t_result_115
        if ____t_116(____t_result_115) then
            ____t_result_117 = not __t(o.reach)
        else
            ____t_result_117 = __O[394]
        end
        __O[395] = ____t_result_117
        if ____t_118(____t_result_117) then
            ____t_result_119 = o.item ~= false
        else
            ____t_result_119 = __O[395]
        end
        if ____t_120(____t_result_119) then
            item(
                nil,
                c,
                S,
                __get(Rh, 0),
                __get(Rh, 1),
                t,
                o
            )
        end
        if __t(o.dash) then
            r(
                nil,
                c,
                -39,
                -45,
                16,
                2,
                "#d7b184"
            )
            r(
                nil,
                c,
                -48,
                -31,
                21,
                2,
                "#aa8a78"
            )
        end
        if __t(o.hit) then
            c:save()
            c.globalAlpha = c.globalAlpha * 0.5
            r(
                nil,
                c,
                -wide - 6,
                -66,
                wide * 2 + 13,
                65,
                "#ffe7bd"
            )
            c:restore()
        end
        c:restore()
    end
    function biscoito(self, c, x, y, o)
        c:save()
        c.imageSmoothingEnabled = false
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        local ____c_125 = c
        local ____c_scale_126 = c.scale
        local ____temp_122 = __lt(o.facing, 0) and -1 or 1
        local ____t_result_121
        if __t(o.scale) then
            ____t_result_121 = o.scale
        else
            ____t_result_121 = 1
        end
        local ____temp_124 = ____temp_122 * ____t_result_121
        local ____t_result_123
        if __t(o.scale) then
            ____t_result_123 = o.scale
        else
            ____t_result_123 = 1
        end
        ____c_scale_126(____c_125, ____temp_124, ____t_result_123)
        local ____t_result_129
        local ____t_128 = __t
        local ____TS__Number_result_127 = __TS__Number(o.frame)
        __O[396] = ____TS__Number_result_127
        if ____t_128(____TS__Number_result_127) then
            ____t_result_129 = __O[396]
        else
            ____t_result_129 = 0
        end
        local t = ____t_result_129
        local moving = not not __t(o.moving) or __TS__Number(o.speed) > 8
        local ____t_result_130
        if __t(moving) then
            ____t_result_130 = math.sin(t * 12)
        else
            ____t_result_130 = 0
        end
        local run = ____t_result_130
        local wag = math.sin(t * (__t(moving) and 14 or 9)) * 4
        local fur = "#c98a43"
        local dark = "#9a6330"
        local light = "#efc58c"
        oval(
            nil,
            c,
            0,
            -1,
            17,
            3,
            "#2e433d",
            2
        )
        __call(
            __arrL(
                {
                    __arrL({-11, 1}, 2),
                    __arrL({-6, -1}, 2),
                    __arrL({7, 1}, 2),
                    __arrL({12, -1}, 2)
                },
                4
            ),
            "forEach",
            function(____, ____bindingPattern0, i)
                local ph
                local lx
                lx = ____bindingPattern0[1]
                ph = ____bindingPattern0[2]
                local s = math.floor(run * 4 * (__t(__mod(i, 2)) and -1 or 1) + 0.5)
                r(
                    nil,
                    c,
                    lx + s - 1,
                    -12,
                    6,
                    12,
                    OUT
                )
                r(
                    nil,
                    c,
                    lx + s,
                    -12,
                    4,
                    10,
                    i < 2 and dark or fur
                )
                r(
                    nil,
                    c,
                    lx + s - 1,
                    -3,
                    6,
                    3,
                    light
                )
                local ____ = ph
            end
        )
        limb(
            nil,
            c,
            __arrL(
                {
                    __arrL({-15, -18}, 2),
                    __arrL({-20, -24 + wag}, 2),
                    __arrL({-22, -30 + wag}, 2)
                },
                3
            ),
            5,
            OUT
        )
        limb(
            nil,
            c,
            __arrL(
                {
                    __arrL({-15, -18}, 2),
                    __arrL({-20, -24 + wag}, 2),
                    __arrL({-22, -30 + wag}, 2)
                },
                3
            ),
            3,
            fur
        )
        r(
            nil,
            c,
            -17,
            -24,
            32,
            14,
            OUT
        )
        r(
            nil,
            c,
            -16,
            -23,
            30,
            12,
            fur
        )
        r(
            nil,
            c,
            -12,
            -14,
            22,
            3,
            light
        )
        r(
            nil,
            c,
            -14,
            -23,
            26,
            2,
            "#dba25c"
        )
        r(
            nil,
            c,
            10,
            -27,
            6,
            13,
            "#c43c3a"
        )
        r(
            nil,
            c,
            12,
            -18,
            3,
            3,
            "#f2c94c"
        )
        r(
            nil,
            c,
            10,
            -38,
            18,
            16,
            OUT
        )
        r(
            nil,
            c,
            11,
            -37,
            16,
            14,
            fur
        )
        r(
            nil,
            c,
            22,
            -31,
            9,
            8,
            OUT
        )
        r(
            nil,
            c,
            23,
            -30,
            8,
            6,
            light
        )
        r(
            nil,
            c,
            28,
            -31,
            3,
            3,
            "#2a1a14"
        )
        r(
            nil,
            c,
            19,
            -34,
            3,
            3,
            "#2d3031"
        )
        r(
            nil,
            c,
            20,
            -34,
            1,
            1,
            "#ffffff"
        )
        r(
            nil,
            c,
            10,
            -41,
            6,
            9,
            OUT
        )
        r(
            nil,
            c,
            11,
            -40,
            4,
            8,
            dark
        )
        local ____t_134 = __t
        local ____t_result_133
        local ____t_132 = __t
        local ____temp_131 = o.emotion == "happy"
        __O[397] = ____temp_131
        if ____t_132(____temp_131) then
            ____t_result_133 = __O[397]
        else
            ____t_result_133 = moving
        end
        if ____t_134(____t_result_133) then
            r(
                nil,
                c,
                24,
                -24,
                4,
                4,
                "#e86a7a"
            )
        end
        if __t(o.bark) then
            do
                local i = 0
                while i < 3 do
                    r(
                        nil,
                        c,
                        34 + i * 4,
                        -38 + i * 3,
                        3,
                        2,
                        "#f2efe6"
                    )
                    i = i + 1
                end
            end
        end
        if __t(o.hit) then
            c:save()
            c.globalAlpha = c.globalAlpha * 0.5
            r(
                nil,
                c,
                -18,
                -42,
                50,
                42,
                "#ffe7bd"
            )
            c:restore()
        end
        c:restore()
    end
    function aged(self, c, age, who, x, y, o)
        local A = __get(AGES, age)
        local t = __get(KID, who)
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        c:scale(A.sx, A.sy)
        local ____draw_140 = draw
        local ____c_139 = c
        local ____assign_138 = __assign
        local ____temp_136 = {}
        local ____o_137 = o
        local ____temp_135
        if who == "daroca" then
            ____temp_135 = false
        else
            ____temp_135 = o.look
        end
        ____draw_140(
            nil,
            ____c_139,
            t,
            0,
            0,
            ____assign_138(____temp_136, ____o_137, {look = ____temp_135})
        )
        c:restore()
    end
    function draw(self, c, ____type, x, y, o)
        if o == nil then
            o = {}
        end
        if __t(__get(SPEC, ____type)) then
            return person(
                nil,
                c,
                ____type,
                __get(SPEC, ____type),
                x,
                y,
                o
            )
        end
        if ____type == "c2_biscoito" then
            return biscoito(
                nil,
                c,
                x,
                y,
                o
            )
        end
        local ____re_exec_143 = __re_exec
        local ____re_result_142 = __re("^(crianca|pre)_(daroca|reeis|jorge)$", "")
        local ____t_result_141
        if __t(____type) then
            ____t_result_141 = ____type
        else
            ____t_result_141 = ""
        end
        local m = ____re_exec_143(____re_result_142, ____t_result_141)
        if __t(m) then
            return aged(
                nil,
                c,
                __get(m, 1),
                __get(m, 2),
                x,
                y,
                o
            )
        end
        return base(
            nil,
            c,
            ____type,
            x,
            y,
            o
        )
    end
    local ____ = "use strict"
    local ____t_3 = __t
    local ____t_result_2
    local ____t_1 = __t
    local ____temp_0 = not __t(window.Art) or not __t(window.Art.drawCharacter)
    __O[385] = ____temp_0
    if ____t_1(____temp_0) then
        ____t_result_2 = __O[385]
    else
        ____t_result_2 = window.CampanhaPersonagens
    end
    if ____t_3(____t_result_2) then
        return
    end
    base = window.Art.drawCharacter
    r = function(____, c, x, y, w, h, color)
        c.fillStyle = color
        c:fillRect(
            math.floor(x + 0.5),
            math.floor(y + 0.5),
            math.ceil(w),
            math.ceil(h)
        )
    end
    OUT = "#2c3030"
    LINE = "#243137"
    LEGLINE = "#27333a"
    SPEC = __ord(
        {
            jorge_gordo = __ord(
                {
                    name = "Jorge (época do trio)",
                    skin = "#dcaa82",
                    shade = "#b07e5c",
                    build = "chubby",
                    top = "#1c1e22",
                    topKind = "pullover",
                    print = "pizza",
                    pants = "#3b4b63",
                    hair = __ord({style = "curly", color = "#22170f", fade = "#5a4436"}, "style,color,fade"),
                    thinGlasses = "#26221f",
                    pose = "relaxed"
                },
                "name,skin,shade,build,top,topKind,print,pants,hair,thinGlasses,pose"
            ),
            jorge = __ord(
                {
                    name = "Jorge",
                    skin = "#dcaa82",
                    shade = "#b07e5c",
                    build = "slim",
                    top = "#4b3428",
                    topKind = "tee",
                    sleeve = "short",
                    pants = "#2c3a4f",
                    hair = __ord({style = "curly", color = "#22170f", fade = "#5a4436"}, "style,color,fade"),
                    thinGlasses = "#26221f",
                    stubble = "#7a5640",
                    pose = "relaxed"
                },
                "name,skin,shade,build,top,topKind,sleeve,pants,hair,thinGlasses,stubble,pose"
            ),
            jorge_celular = nil,
            miguel = __ord(
                {
                    name = "Miguel",
                    skin = "#f0c9af",
                    shade = "#c3977f",
                    build = "strong",
                    top = "#2c4f78",
                    topKind = "tee",
                    sleeve = "short",
                    pants = "#3f4a52",
                    hair = __ord({style = "side", color = "#4a3426"}, "style,color"),
                    glasses = "#2f78c8",
                    strap = "#5d4a3a",
                    pose = "thumb"
                },
                "name,skin,shade,build,top,topKind,sleeve,pants,hair,glasses,strap,pose"
            ),
            fred_conquista = __ord(
                {
                    name = "Fred",
                    skin = "#f1cfb6",
                    shade = "#c49b80",
                    build = "slim",
                    top = "#1d1f26",
                    topKind = "tee",
                    sleeve = "short",
                    print = "#c63d4a",
                    pants = "#34404f",
                    hair = __ord({style = "wavy", color = "#121518"}, "style,color"),
                    chain = "#c9ccc4",
                    pose = "cocky"
                },
                "name,skin,shade,build,top,topKind,sleeve,print,pants,hair,chain,pose"
            ),
            c2_ze_taxi = __ord(
                {
                    name = "Seu Zé do Táxi",
                    skin = "#c99068",
                    shade = "#9a6849",
                    build = "belly",
                    top = "#dccb98",
                    topKind = "polo",
                    sleeve = "short",
                    pattern = "#b9a26a",
                    pants = "#4a4a42",
                    hair = __ord({style = "bald", color = "#b8b2a6"}, "style,color"),
                    mustache = "#d6d0c4",
                    item = "keys",
                    pose = "talk"
                },
                "name,skin,shade,build,top,topKind,sleeve,pattern,pants,hair,mustache,item,pose"
            ),
            c2_lurdes = __ord(
                {
                    name = "Dona Lurdes",
                    skin = "#d9a57f",
                    shade = "#ac7856",
                    build = "normal",
                    h = 0.94,
                    top = "#7a5a8c",
                    topKind = "apron",
                    apron = "#efe6d2",
                    skirt = "#5d4672",
                    hair = __ord({style = "bun", color = "#3a312c", gray = "#9a938a"}, "style,color,gray"),
                    glasses = "#7a5a3a",
                    scarf = "#b9524a",
                    pose = "hips"
                },
                "name,skin,shade,build,h,top,topKind,apron,skirt,hair,glasses,scarf,pose"
            ),
            c2_mel = __ord(
                {
                    name = "Mel",
                    skin = "#b67a52",
                    shade = "#875438",
                    build = "slim",
                    h = 0.92,
                    top = "#d96f8a",
                    topKind = "puffer",
                    pants = "#384b6a",
                    hair = __ord({style = "long", color = "#2b1d17"}, "style,color"),
                    bag = "#7c5a3a",
                    item = "map",
                    pose = "offer"
                },
                "name,skin,shade,build,h,top,topKind,pants,hair,bag,item,pose"
            ),
            c2_picole = __ord(
                {
                    name = "Tio do Picolé",
                    skin = "#c58c63",
                    shade = "#966446",
                    build = "normal",
                    top = "#f0efe6",
                    topKind = "coat",
                    pants = "#41505a",
                    hat = __ord({kind = "cap", color = "#e8e6dc", band = "#3e7cc0"}, "kind,color,band"),
                    hair = __ord({style = "short", color = "#6c665e"}, "style,color"),
                    scarf = "#3e7cc0",
                    item = "cooler",
                    pose = "carry",
                    shiver = true
                },
                "name,skin,shade,build,top,topKind,pants,hat,hair,scarf,item,pose,shiver"
            ),
            c2_nando = __ord(
                {
                    name = "Nando Skatista",
                    skin = "#9c6644",
                    shade = "#704630",
                    build = "slim",
                    top = "#4f8a52",
                    topKind = "hoodie",
                    inner = "#2b3a2c",
                    pants = "#22262c",
                    hat = __ord({kind = "capback", color = "#d9b347"}, "kind,color"),
                    hair = __ord({style = "short", color = "#1d1a18"}, "style,color"),
                    item = "skate",
                    pose = "carry"
                },
                "name,skin,shade,build,top,topKind,inner,pants,hat,hair,item,pose"
            ),
            c2_vo_cida = __ord(
                {
                    name = "Vó Cida",
                    skin = "#d8a985",
                    shade = "#ab7d5d",
                    build = "normal",
                    h = 0.88,
                    hunch = true,
                    top = "#8a5aa0",
                    topKind = "cardigan",
                    inner = "#efe2c8",
                    skirt = "#5b4a62",
                    hair = __ord({style = "curlyShort", color = "#d9d6d0"}, "style,color"),
                    glasses = "#8a7a6a",
                    item = "cane",
                    pose = "cane"
                },
                "name,skin,shade,build,h,hunch,top,topKind,inner,skirt,hair,glasses,item,pose"
            ),
            c2_juninho = __ord(
                {
                    name = "Juninho Mecânico",
                    skin = "#8a5a3c",
                    shade = "#5f3d2a",
                    build = "normal",
                    top = "#2f5d8c",
                    topKind = "overall",
                    inner = "#c9c3b0",
                    pants = "#2f5d8c",
                    hat = __ord({kind = "cap", color = "#c0443c"}, "kind,color"),
                    hair = __ord({style = "short", color = "#1c1714"}, "style,color"),
                    grease = true,
                    item = "wrench",
                    pose = "carry"
                },
                "name,skin,shade,build,top,topKind,inner,pants,hat,hair,grease,item,pose"
            ),
            c2_larissa = __ord(
                {
                    name = "Larissa da Biblioteca",
                    skin = "#efc6a9",
                    shade = "#c2977c",
                    build = "slim",
                    h = 0.95,
                    top = "#c99a3a",
                    topKind = "cardigan",
                    inner = "#f2ecda",
                    skirt = "#4a5a6c",
                    hair = __ord({style = "ponytail", color = "#3b2620"}, "style,color"),
                    glasses = "#a8443c",
                    item = "book",
                    pose = "read"
                },
                "name,skin,shade,build,h,top,topKind,inner,skirt,hair,glasses,item,pose"
            ),
            c2_gugu = __ord(
                {
                    name = "Gugu do Ferro-Velho",
                    skin = "#b07a52",
                    shade = "#82563a",
                    build = "belly",
                    top = "#6f6a5c",
                    topKind = "tank",
                    pants = "#3f4a3c",
                    hair = __ord({style = "buzz", color = "#2a231d"}, "style,color"),
                    beard = "#2a231d",
                    goggles = "#86c8d0",
                    gloves = "#b38a3c",
                    item = "gadget",
                    pose = "carry"
                },
                "name,skin,shade,build,top,topKind,pants,hair,beard,goggles,gloves,item,pose"
            ),
            c2_bia = __ord(
                {
                    name = "Bia do Arrocha",
                    skin = "#7c4f35",
                    shade = "#55362a",
                    build = "slim",
                    h = 0.95,
                    top = "#d94a9a",
                    topKind = "tee",
                    sleeve = "short",
                    sparkle = true,
                    skirt = "#2a2a3c",
                    hair = __ord({style = "curlyBig", color = "#1e1512"}, "style,color"),
                    earrings = "#f2cf5b",
                    item = "mic",
                    pose = "sing"
                },
                "name,skin,shade,build,h,top,topKind,sleeve,sparkle,skirt,hair,earrings,item,pose"
            ),
            c2_fatima = __ord(
                {
                    name = "Dona Fátima das Fantasias",
                    skin = "#c48a62",
                    shade = "#93613f",
                    build = "normal",
                    h = 0.93,
                    top = "#d8452f",
                    topKind = "apron",
                    apron = "#f2e6c8",
                    skirt = "#2f5f8a",
                    hat = __ord({kind = "straw", color = "#e2c070"}, "kind,color"),
                    hair = __ord({style = "long", color = "#3a2a20"}, "style,color"),
                    earrings = "#f2c230",
                    scarf = "#f2c230",
                    item = "map",
                    pose = "offer"
                },
                "name,skin,shade,build,h,top,topKind,apron,skirt,hat,hair,earrings,scarf,item,pose"
            ),
            c2_carlinhos = __ord(
                {
                    name = "Carlinhos",
                    skin = "#e8bf9f",
                    shade = "#bb9277",
                    build = "slim",
                    top = "#7d8590",
                    topKind = "hoodie",
                    inner = "#4d5560",
                    pants = "#2c3646",
                    hair = __ord({style = "short", color = "#5a3f2c"}, "style,color"),
                    pose = "pockets",
                    mood = "sad"
                },
                "name,skin,shade,build,top,topKind,inner,pants,hair,pose,mood"
            ),
            c2_creuza = __ord(
                {
                    name = "Dona Creuza Fofoqueira",
                    skin = "#e0ae8b",
                    shade = "#b38163",
                    build = "normal",
                    h = 0.94,
                    top = "#e48fb0",
                    topKind = "robe",
                    robeDots = "#f6d3df",
                    pants = "#e48fb0",
                    hair = __ord({style = "curlers", color = "#6a3d2c", curler = "#7cc7d8"}, "style,color,curler"),
                    lipstick = "#c4384e",
                    item = "phone",
                    pose = "phone"
                },
                "name,skin,shade,build,h,top,topKind,robeDots,pants,hair,lipstick,item,pose"
            ),
            c2_tonhao = __ord(
                {
                    name = "Tonhão do Mototáxi",
                    skin = "#a96f48",
                    shade = "#7c4f33",
                    build = "strong",
                    top = "#3a3f44",
                    topKind = "vest",
                    vest = "#f08a24",
                    vestBand = "#e8f06a",
                    pants = "#2a3038",
                    hat = __ord({kind = "helmet", color = "#c9372f", visor = "#2a3a46"}, "kind,color,visor"),
                    mustache = "#231b16",
                    item = "keys",
                    pose = "hips"
                },
                "name,skin,shade,build,top,topKind,vest,vestBand,pants,hat,mustache,item,pose"
            ),
            c2_valdomiro = __ord(
                {
                    name = "Seu Valdomiro da Feira",
                    skin = "#c48a60",
                    shade = "#956445",
                    build = "belly",
                    top = "#4e7d5a",
                    topKind = "apron",
                    apron = "#e9dcc0",
                    pants = "#4f4a3e",
                    hat = __ord({kind = "straw", color = "#d7b665"}, "kind,color"),
                    mustache = "#6f665c",
                    hair = __ord({style = "short", color = "#8a847a"}, "style,color"),
                    item = "biscuit",
                    pose = "offer"
                },
                "name,skin,shade,build,top,topKind,apron,pants,hat,mustache,hair,item,pose"
            ),
            c2_kaua_influencer = __ord(
                {
                    name = "Kauã Influencer",
                    skin = "#d9a985",
                    shade = "#ab7c5e",
                    build = "slim",
                    top = "#f2f1ec",
                    topKind = "puffer",
                    pants = "#1f2430",
                    hair = __ord({style = "quiff", color = "#3a2a22", tips = "#f0d36a"}, "style,color,tips"),
                    shades = true,
                    item = "selfie",
                    pose = "selfie"
                },
                "name,skin,shade,build,top,topKind,pants,hair,shades,item,pose"
            ),
            c2_barao = __ord(
                {
                    name = "Barão do Café",
                    skin = "#d8a27a",
                    shade = "#a97556",
                    build = "belly",
                    top = "#f1ece0",
                    topKind = "vest",
                    vest = "#5a3a24",
                    vestBand = "#7a5236",
                    pants = "#3c2f26",
                    hat = __ord({kind = "rancher", color = "#6b4a2c", band = "#2c1e14"}, "kind,color,band"),
                    mustache = "#3a2a20",
                    item = "mug",
                    pose = "mug",
                    twitch = true
                },
                "name,skin,shade,build,top,topKind,vest,vestBand,pants,hat,mustache,item,pose,twitch"
            ),
            c2_breno = __ord(
                {
                    name = "Breno Pitbull",
                    skin = "#b98258",
                    shade = "#8a5c3c",
                    build = "strong",
                    top = "#1f2226",
                    topKind = "tank",
                    pants = "#2a3442",
                    hair = __ord({style = "buzz", color = "#1b1714"}, "style,color"),
                    chain = "#e8c24c",
                    tattoo = "#3f4b5a",
                    pose = "fists",
                    mood = "angry"
                },
                "name,skin,shade,build,top,topKind,pants,hair,chain,tattoo,pose,mood"
            ),
            c2_ryan = __ord(
                {
                    name = "Ryan",
                    skin = "#e9c2a3",
                    shade = "#bb9275",
                    build = "slim",
                    top = "#2f6fb5",
                    topKind = "hoodie",
                    inner = "#1d2a3c",
                    pants = "#25303f",
                    hair = __ord({style = "fringe", color = "#2a1d16"}, "style,color"),
                    headset = "#20262c",
                    item = "pad",
                    pose = "game"
                },
                "name,skin,shade,build,top,topKind,inner,pants,hair,headset,item,pose"
            ),
            c2_bryan = __ord(
                {
                    name = "Bryan",
                    skin = "#e9c2a3",
                    shade = "#bb9275",
                    build = "slim",
                    top = "#c23f3a",
                    topKind = "hoodie",
                    inner = "#3c1d1d",
                    pants = "#25303f",
                    hair = __ord({style = "fringe", color = "#2a1d16"}, "style,color"),
                    headset = "#20262c",
                    item = "pad",
                    pose = "game",
                    mirrored = true
                },
                "name,skin,shade,build,top,topKind,inner,pants,hair,headset,item,pose,mirrored"
            ),
            c2_cleiton = __ord(
                {
                    name = "Cleiton do Ubé",
                    skin = "#b47a50",
                    shade = "#86583a",
                    build = "normal",
                    top = "#2e6ea8",
                    topKind = "polo",
                    sleeve = "short",
                    pattern = "#245a8c",
                    pants = "#3a3f46",
                    hat = __ord({kind = "cap", color = "#1e2a36", band = "#e8c24c"}, "kind,color,band"),
                    hair = __ord({style = "short", color = "#1c1612"}, "style,color"),
                    mustache = "#1c1612",
                    item = "keys",
                    pose = "fists",
                    mood = "angry"
                },
                "name,skin,shade,build,top,topKind,sleeve,pattern,pants,hat,hair,mustache,item,pose,mood"
            ),
            c2_rosilda = __ord(
                {
                    name = "Dona Rosilda",
                    skin = "#e3b48f",
                    shade = "#b58665",
                    build = "belly",
                    h = 0.9,
                    top = "#3f8a6a",
                    topKind = "cardigan",
                    inner = "#f2e6c8",
                    skirt = "#6a4a5a",
                    hair = __ord({style = "curlers", color = "#7a4a34", curler = "#f08ab0"}, "style,color,curler"),
                    glasses = "#5a3a8a",
                    item = "phone",
                    pose = "hips",
                    mood = "angry"
                },
                "name,skin,shade,build,h,top,topKind,inner,skirt,hair,glasses,item,pose,mood"
            )
        },
        "jorge_gordo,jorge,jorge_celular,miguel,fred_conquista,c2_ze_taxi,c2_lurdes,c2_mel,c2_picole,c2_nando,c2_vo_cida,c2_juninho,c2_larissa,c2_gugu,c2_bia,c2_fatima,c2_carlinhos,c2_creuza,c2_tonhao,c2_valdomiro,c2_kaua_influencer,c2_barao,c2_breno,c2_ryan,c2_bryan,c2_cleiton,c2_rosilda"
    )
    SPEC.jorge_celular = __ord(
        __assign({}, SPEC.jorge, {name = "Jorge (no celular)", item = "phone", pose = "phone"}),
        "name,item,pose"
    )
    SPEC.jorge_farpas = __ord(
        __assign({}, SPEC.jorge, {
            name = "Jorge das farpas",
            topKind = "jacket",
            top = "#872f51",
            inner = "#302840",
            scarf = "#dd939c",
            pose = "cocky"
        }),
        "name,topKind,top,inner,scarf,pose"
    )
    SPEC.jorge_aura = __ord(
        __assign({}, SPEC.jorge, {
            name = "Jorge do céu",
            topKind = "coat",
            top = "#354d84",
            inner = "#93cdd6",
            scarf = "#acdfea",
            pants = "#384466",
            pose = "fists"
        }),
        "name,topKind,top,inner,scarf,pants,pose"
    )
    SPEC.jorge_promessa = __ord(
        __assign({}, SPEC.jorge_celular, {
            name = "Jorge da última chamada",
            topKind = "jacket",
            top = "#e4c99c",
            inner = "#38576b",
            pants = "#34485a",
            shoes = "#664b41"
        }),
        "name,topKind,top,inner,pants,shoes"
    )
    local ROLE = __ord({
        jorge_gordo = "trio",
        jorge = "trio",
        jorge_celular = "trio",
        miguel = "amigo",
        fred_conquista = "vilão final antes do Jorge",
        c2_ze_taxi = "aliado",
        c2_lurdes = "aliado",
        c2_mel = "aliado",
        c2_biscoito = "aliado",
        c2_picole = "aliado",
        c2_nando = "aliado",
        c2_vo_cida = "aliado",
        c2_juninho = "aliado",
        c2_larissa = "aliado",
        c2_gugu = "aliado",
        c2_bia = "aliado",
        c2_carlinhos = "aliado",
        c2_fatima = "aliado",
        c2_creuza = "vilão 1",
        c2_tonhao = "vilão 2",
        c2_valdomiro = "vilão 3",
        c2_kaua_influencer = "vilão 4",
        c2_barao = "vilão 5",
        c2_breno = "vilão 6",
        c2_ryan = "vilão 7",
        c2_bryan = "vilão 7",
        c2_cleiton = "NPC (engarrafamento)",
        c2_rosilda = "NPC (engarrafamento)"
    }, "jorge_gordo,jorge,jorge_celular,miguel,fred_conquista,c2_ze_taxi,c2_lurdes,c2_mel,c2_biscoito,c2_picole,c2_nando,c2_vo_cida,c2_juninho,c2_larissa,c2_gugu,c2_bia,c2_carlinhos,c2_fatima,c2_creuza,c2_tonhao,c2_valdomiro,c2_kaua_influencer,c2_barao,c2_breno,c2_ryan,c2_bryan,c2_cleiton,c2_rosilda")
    AGES = __ord(
        {
            crianca = __ord({sx = 0.7, sy = 0.64}, "sx,sy"),
            pre = __ord({sx = 0.84, sy = 0.82}, "sx,sy")
        },
        "crianca,pre"
    )
    KID = __ord({daroca = "daroca", reeis = "reeis", jorge = "jorge_gordo"}, "daroca,reeis,jorge")
    window.Art.drawCharacter = draw
    local lista = __call(
        __keys(SPEC),
        "map",
        function(____, id)
            local ____id_147 = id
            local ____get_result_name_148 = __get(SPEC, id).name
            local ____t_result_146
            local ____t_145 = __t
            local ____get_result_144 = __get(ROLE, id)
            __O[398] = ____get_result_144
            if ____t_145(____get_result_144) then
                ____t_result_146 = __O[398]
            else
                ____t_result_146 = ""
            end
            return {id = ____id_147, nome = ____get_result_name_148, papel = ____t_result_146}
        end
    )
    __call(
        lista,
        "splice",
        __call(
            lista,
            "findIndex",
            function(____, p) return p.id == "c2_picole" end
        ),
        0,
        __ord({id = "c2_biscoito", nome = "Biscoito (cachorro caramelo)", papel = "aliado"}, "id,nome,papel")
    )
    local function registrar(self, id, spec, papel)
        if papel == nil then
            papel = ""
        end
        local ____t_152 = __t
        local ____t_result_151
        local ____t_150 = __t
        local ____temp_149 = not __t(id) or not __t(spec)
        __O[399] = ____temp_149
        if ____t_150(____temp_149) then
            ____t_result_151 = __O[399]
        else
            ____t_result_151 = __get(SPEC, id)
        end
        if ____t_152(____t_result_151) then
            return false
        end
        __set(SPEC, id, spec)
        __set(ROLE, id, papel)
        __call(lista, "push", {id = id, nome = spec.name, papel = papel})
        return true
    end
    window.CampanhaPersonagens = __ord(
        __getters(
            {
                registrar = registrar,
                idades = __arrL({
                    "crianca_daroca",
                    "crianca_reeis",
                    "crianca_jorge",
                    "pre_daroca",
                    "pre_reeis",
                    "pre_jorge"
                }, 6),
                has = function(____, ____type)
                    local ____t_result_158
                    local ____t_154 = __t
                    local ____temp_153 = not not __t(__get(SPEC, ____type)) or ____type == "c2_biscoito"
                    __O[400] = ____temp_153
                    if ____t_154(____temp_153) then
                        ____t_result_158 = __O[400]
                    else
                        local ____re_test_157 = __re_test
                        local ____re_result_156 = __re("^(crianca|pre)_(daroca|reeis|jorge)$", "")
                        local ____t_result_155
                        if __t(____type) then
                            ____t_result_155 = ____type
                        else
                            ____t_result_155 = ""
                        end
                        ____t_result_158 = ____re_test_157(____re_result_156, ____t_result_155)
                    end
                    return ____t_result_158
                end
            },
            {lista = function()
                return __call(lista, "slice")
            end}
        ),
        "lista,registrar,idades,has"
    )
end)(nil)
return ____exports
