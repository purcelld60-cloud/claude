--!native
--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __gt, __isFiniteN, __mod, __ord, __arrL, __iterar, __t, __get, __set, __len, __call = __JSR.__lt, __JSR.__gt, __JSR.__isFiniteN, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__len, __JSR.__call
local __add, __keys, __assign, __band, __shr, __getters, __re, __re_test, __re_exec = __JSR.__add, __JSR.__keys, __JSR.__assign, __JSR.__band, __JSR.__shr, __JSR.__getters, __JSR.__re, __JSR.__re_test, __JSR.__re_exec
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
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
            function(____, p, i) return if __t(i) then c:lineTo(
                __get(p, 0),
                __get(p, 1)
            ) else c:moveTo(
                __get(p, 0),
                __get(p, 1)
            ) end
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
            oval(
                nil,
                c,
                -13,
                -63,
                5,
                5,
                if __t(H.gray) then H.gray else col,
                2
            )
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
                    oval(
                        nil,
                        c,
                        -2 + math.cos(a) * 14,
                        -54 + math.sin(a) * 10,
                        5,
                        5,
                        if __t(__mod(i, 2)) then col else "#2e211b",
                        2
                    )
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
        local hi = if __t(H.hi) then H.hi else shadeHex(nil, col, 1.35)
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
                                -64 - if __t(i > 0 and i < 7) then 2 else 0,
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
                            oval(
                                nil,
                                c,
                                -12 + i * 3.8,
                                -64 - if __t(i > 0 and i < 7) then 2 else 0,
                                3,
                                3,
                                if __t(__mod(i, 2)) then col else hi,
                                2
                            )
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
                            oval(
                                nil,
                                c,
                                -12,
                                -53 + i * 3,
                                2,
                                2,
                                if __t(__mod(i, 2)) then hi else col,
                                2
                            )
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
                    local fade = if __t(H.fade) then H.fade else col
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
                            oval(
                                nil,
                                c,
                                xx,
                                yy,
                                rr,
                                rr,
                                if __mod(i, 3) == 1 then shadeHex(nil, col, 1.25) else col,
                                1
                            )
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
                r(
                    nil,
                    c,
                    -6,
                    -62,
                    10,
                    1,
                    if __t(H.gray) then H.gray else hi
                )
                r(
                    nil,
                    c,
                    2,
                    -61,
                    8,
                    1,
                    if __t(H.gray) then H.gray else hi
                )
                break
            end
            ____cond28 = ____cond28 or ____switch28 == "curlyShort"
            if ____cond28 then
                do
                    local i = 0
                    while i < 8 do
                        oval(
                            nil,
                            c,
                            -11 + i * 3.6,
                            -61 + __mod(i, 2) * 2,
                            3,
                            3,
                            if __t(__mod(i, 2)) then col else "#bdb8b0",
                            2
                        )
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
                        oval(
                            nil,
                            c,
                            -9 + i * 4.5,
                            -63,
                            3,
                            3,
                            if __t(__mod(i, 2)) then col else "#2e211b",
                            2
                        )
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
                    if math.sin(t * 6) > 0 then "#ff5a4a" else "#7a2a2a"
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
                        if __t(on) then "#fff6d0" else "#d8d0b0",
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
        local sc = if __t(o.scale) then o.scale else 1
        local hk = if __t(S.h) then S.h else 1
        c:scale(if __lt(o.facing, 0) then -1 else 1 * sc, sc * hk)
        if __isFiniteN(o.opacity) then
            c.globalAlpha = c.globalAlpha * math.max(
                0,
                math.min(1, o.opacity)
            )
        end
        local ____t_4 = __t
        local ____TS__Number_result_3 = __TS__Number(o.frame)
        __O[362] = ____TS__Number_result_3
        local t = if ____t_4(____TS__Number_result_3) then __O[362] else 0
        local moving = not not __t(o.moving) or __TS__Number(o.speed) > 8
        local air = o.grounded == false
        local walk = if __t(if __t(moving) then not __t(air) else moving) then math.sin(t * 9) else 0
        local bob = if __t(if __t(moving) then not __t(air) else moving) then math.floor(math.abs(math.cos(t * 9)) * 2 + 0.5) else math.floor(math.sin(t * 2) * 0.7 + 0.5)
        local attack = not not __t(o.attack)
        local strike = if __t(attack) then math.max(
            0,
            math.sin(if __isFiniteN(o.attackProgress) then o.attackProgress else 0.5 + math.sin(t * 7) * 0.5 * math.pi)
        ) else 0
        local belly = S.build == "belly"
        local strong = S.build == "strong"
        local slim = S.build == "slim"
        local chubby = S.build == "chubby"
        local wide = if __t(belly) then 18 else if __t(strong) then 17 else if __t(slim) then 10 else if __t(chubby) then 14 else 12
        local skin = S.skin
        local shade = S.shade
        local shiver = if __t(if __t(S.shiver) then S.shiver else o.cold) then math.floor(math.sin(t * 40) + 0.5) else 0
        local twitch = if __t(if __t(S.twitch) then math.sin(t * 13) > 0.85 else S.twitch) then 1 else 0
        local ____t_6 = __t
        local ____temp_5 = if __t(o.emotion) then o.emotion else S.mood
        __O[363] = ____temp_5
        local mood = if ____t_6(____temp_5) then __O[363] else ""
        if __t(not __t(o.duelo) or not __t(air)) then
            oval(
                nil,
                c,
                0,
                -1,
                if __t(belly) then 23 else if __t(strong) then 21 else if __t(chubby) then 19 else 17,
                3,
                "#2e433d",
                2
            )
        end
        local ____t_9 = __t
        local ____t_8 = __t
        local ____temp_7 = ____type == "c2_breno"
        __O[364] = ____temp_7
        if ____t_9(if __t(o.rage) then o.rage else if ____t_8(____temp_7) then o.powered else __O[364]) then
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
            local fy = if __t(if __t(moving) then not __t(air) else moving) then math.max(
                0,
                math.cos(t * 9 + if side > 0 then 0 else math.pi)
            ) * 6 else 0
            if __t(air) then
                fx = if side > 0 then 10 else -12
                fy = if side > 0 then 3 else 11
            end
            local legW = if __t(strong) then 11 else if __t(slim) then 7 else 9
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
                if __t(strong) then 7 else if __t(slim) then 4 else 5,
                if __t(S.skirt) then skin else if __t(S.pants) then S.pants else "#3d4852"
            )
            r(
                nil,
                c,
                fx - 4,
                -6 - fy,
                13,
                6,
                if __t(S.shoes) then S.shoes else "#26353a"
            )
            r(
                nil,
                c,
                fx - 3,
                -2 - fy,
                11,
                2,
                if __t(S.sole) then S.sole else "#b6b8a6"
            )
        end
        c:translate(if __t(o.dash) then 5 else math.floor(walk * 1.5 + 0.5) + shiver, -bob + if __t(S.hunch) then 2 else 0)
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
        local ____t_12 = __t
        local ____t_11 = __t
        local ____temp_10 = o.duelo == 2
        __O[365] = ____temp_10
        if ____t_12(if ____t_11(____temp_10) then attack else __O[365]) then
            Rh = if __t(air) then __arrL({wide + 9, -39}, 2) else __arrL({wide - 3, -25}, 2)
            L = if __t(air) then __arrL({-wide - 9, -38}, 2) else __arrL({-wide + 1, -24}, 2)
        else
            local ____t_15 = __t
            local ____t_14 = __t
            local ____temp_13 = o.duelo == 3
            __O[366] = ____temp_13
            if ____t_15(if ____t_14(____temp_13) then attack else __O[366]) then
                Rh = __arrL(
                    {
                        wide + 8 + math.floor(7 * strike + 0.5),
                        -41
                    },
                    2
                )
                L = __arrL({0, -43}, 2)
            elseif o.duelo == 4 then
                Rh = __arrL({wide + 6 + if __t(attack) then 8 else 0, if __t(attack) then -40 else -23}, 2)
                L = __arrL({-wide - 7, if __t(attack) then -36 else -26}, 2)
            elseif o.duelo == 5 then
                Rh = __arrL({wide + 2, -47}, 2)
                L = if __t(attack) then __arrL({wide + 4, -32}, 2) else __arrL({-wide - 3, -22}, 2)
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
        local armW = if __t(strong) then 11 else if __t(slim) then 6 else 8
        local armIn = if __t(strong) then 7 else if __t(slim) then 4 else 5
        local function hand(self, side)
            local ____end = if __gt(side, 0) then Rh else L
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
            limb(
                nil,
                c,
                __arrL({shoulder, elbow}, 2),
                armIn,
                if S.topKind == "tank" then skin else if __t(S.topKind == "apron" or S.topKind == "overall") then if __t(S.inner) then S.inner else S.top else S.top
            )
            limb(
                nil,
                c,
                __arrL({elbow, ____end}, 2),
                armIn,
                if __t(if __t(sleeveSkin) then sleeveSkin else S.topKind == "apron" and not __t(S.inner)) then skin else if S.topKind == "overall" then S.inner else S.top
            )
            if __t(if __t(S.tattoo) then __gt(side, 0) else S.tattoo) then
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
            r(
                nil,
                c,
                __get(____end, 0) - 3,
                __get(____end, 1) - 3,
                if __t(strong) then 8 else 6,
                if __t(strong) then 7 else 6,
                if __t(S.gloves) then S.gloves else skin
            )
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
        local bx = if __t(belly) then 16 else wide - 1
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
                        if __t(belly) then 22 else 19,
                        S.inner
                    )
                end
                r(
                    nil,
                    c,
                    -4,
                    -40,
                    1,
                    if __t(belly) then 22 else 19,
                    edge
                )
                r(
                    nil,
                    c,
                    4,
                    -40,
                    1,
                    if __t(belly) then 22 else 19,
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
                    if __t(belly) then 20 else 19,
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
        if __t(if __t(S.uniform) then S.uniform else o.uniform) then
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
            local ____c_20 = c
            local ____temp_21 = ey - 3
            local ____shadeHex_19 = shadeHex
            local ____t_18 = __t
            local ____opt_16 = S.hair
            if ____opt_16 ~= nil then
                ____opt_16 = ____opt_16.color
            end
            __O[367] = ____opt_16
            r(
                nil,
                ____c_20,
                1,
                ____temp_21,
                6,
                1,
                ____shadeHex_19(nil, if ____t_18(____opt_16) then __O[367] else "#3a2a20", 1)
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
        local mouthC = if __t(S.lipstick) then S.lipstick else "#855e43"
        local ____t_26 = __t
        local ____t_25 = __t
        local ____t_23 = __t
        local ____temp_22 = mood == "happy" or mood == "smug"
        __O[368] = ____temp_22
        local ____temp_24 = if ____t_23(____temp_22) then __O[368] else S.pose == "cocky"
        __O[369] = ____temp_24
        if ____t_26(if ____t_25(____temp_24) then __O[369] else S.pose == "sing") then
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
        local ____t_31 = __t
        local ____t_30 = __t
        local ____t_28 = __t
        local ____temp_27 = if __t(S.item) then not __t(attack) else S.item
        __O[370] = ____temp_27
        local ____temp_29 = if ____t_28(____temp_27) then not __t(o.reach) else __O[370]
        __O[371] = ____temp_29
        if ____t_31(if ____t_30(____temp_29) then o.item ~= false else __O[371]) then
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
        c:scale(if __lt(o.facing, 0) then -1 else 1 * if __t(o.scale) then o.scale else 1, if __t(o.scale) then o.scale else 1)
        local ____t_33 = __t
        local ____TS__Number_result_32 = __TS__Number(o.frame)
        __O[372] = ____TS__Number_result_32
        local t = if ____t_33(____TS__Number_result_32) then __O[372] else 0
        local moving = not not __t(o.moving) or __TS__Number(o.speed) > 8
        local run = if __t(moving) then math.sin(t * 12) else 0
        local wag = math.sin(t * if __t(moving) then 14 else 9) * 4
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
                local s = math.floor(run * 4 * if __t(__mod(i, 2)) then -1 else 1 + 0.5)
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
                    if i < 2 then dark else fur
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
        local ____t_36 = __t
        local ____t_35 = __t
        local ____temp_34 = o.emotion == "happy"
        __O[373] = ____temp_34
        if ____t_36(if ____t_35(____temp_34) then __O[373] else moving) then
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
        draw(
            nil,
            c,
            t,
            0,
            0,
            __assign({}, o, {look = if who == "daroca" then false else o.look})
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
        local m = __re_exec(
            __re("^(crianca|pre)_(daroca|reeis|jorge)$", ""),
            if __t(____type) then ____type else ""
        )
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
    local ____t_2 = __t
    local ____t_1 = __t
    local ____temp_0 = not __t(window.Art) or not __t(window.Art.drawCharacter)
    __O[361] = ____temp_0
    if ____t_2(if ____t_1(____temp_0) then __O[361] else window.CampanhaPersonagens) then
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
            local ____id_39 = id
            local ____get_result_name_40 = __get(SPEC, id).name
            local ____t_38 = __t
            local ____get_result_37 = __get(ROLE, id)
            __O[374] = ____get_result_37
            return {id = ____id_39, nome = ____get_result_name_40, papel = if ____t_38(____get_result_37) then __O[374] else ""}
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
        local ____t_43 = __t
        local ____t_42 = __t
        local ____temp_41 = not __t(id) or not __t(spec)
        __O[375] = ____temp_41
        if ____t_43(if ____t_42(____temp_41) then __O[375] else __get(SPEC, id)) then
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
                    local ____t_45 = __t
                    local ____temp_44 = not not __t(__get(SPEC, ____type)) or ____type == "c2_biscoito"
                    __O[376] = ____temp_44
                    return if ____t_45(____temp_44) then __O[376] else __re_test(
                        __re("^(crianca|pre)_(daroca|reeis|jorge)$", ""),
                        if __t(____type) then ____type else ""
                    )
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
