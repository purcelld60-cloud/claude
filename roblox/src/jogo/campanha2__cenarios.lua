--!native
--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __D = {}
local __lt, __le, __gt, __ge, __mod, __ord, __arrL, __iterar, __t, __get, __set, __len = __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__len
local __call, __add, __iter, __assign, __band, __shr, __hypot, __getters, __re, __re_test = __JSR.__call, __JSR.__add, __JSR.__iter, __JSR.__assign, __JSR.__band, __JSR.__shr, __JSR.__hypot, __JSR.__getters, __JSR.__re, __JSR.__re_test
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
    local LW, LH, FLOOR, R, ell, mk, hash, cl, mix, dither, limb, sky, haze, tile, tree, slant, sunInfo, sunWall, board, bench, lampPost, lampGlow, shadeAdd, lightAdd
    local __L1 = {}
    __L1.shadeHex = function(self, hex, k)
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
    __L1.drawMid = function(self, c, mid, camL, s, t)
        c:drawImage(
            mid,
            camL,
            0,
            LW,
            LH,
            0,
            0,
            LW,
            LH
        )
        local ____opt_2 = __L1:CAM()
        if ____opt_2 ~= nil then
            ____opt_2 = ____opt_2.sobre
        end
        if ____opt_2 ~= nil then
            ____opt_2(
                ____opt_2,
                __L1.CUR,
                c,
                s,
                t,
                camL
            )
        end
    end
    __L1.plaster = function(self, c, x, y, w, h, col, seed)
        if seed == nil then
            seed = 0
        end
        R(
            nil,
            c,
            x,
            y,
            w,
            h,
            col
        )
        local lt = __L1:shadeHex(col, 1.05)
        local dk = __L1:shadeHex(col, 0.93)
        do
            local i = 0
            while i < w * h / 16 do
                R(
                    nil,
                    c,
                    x + hash(nil, i * 3.1 + seed) * w,
                    y + hash(nil, i * 7.7 + seed + 1) * h,
                    1,
                    1,
                    if __t(__mod(i, 2)) then lt else dk
                )
                i = i + 1
            end
        end
        do
            local k = 0
            while __lt(k, w) do
                if __gt(
                    hash(nil, k * 1.7 + seed),
                    0.55
                ) then
                    R(
                        nil,
                        c,
                        x + k,
                        __add(y, h) - 2 - math.floor(hash(nil, k + seed) * 5 + 0.5),
                        1,
                        3,
                        __L1:shadeHex(col, 0.87)
                    )
                end
                k = k + 1
            end
        end
    end
    __L1.brick = function(self, c, x, y, w, h, col, seed)
        if col == nil then
            col = "#b0624a"
        end
        if seed == nil then
            seed = 0
        end
        R(
            nil,
            c,
            x,
            y,
            w,
            h,
            __L1:shadeHex(col, 0.7)
        )
        do
            local yy = 0
            while __lt(yy, h) do
                local off = if __t(__mod(yy / 4, 2)) then 0 else 4
                do
                    local xx = -off
                    while __lt(xx, w) do
                        local bx = math.max(x, x + xx)
                        local bw = math.min(
                            x + xx + 7,
                            __add(x, w)
                        ) - bx
                        if bw > 0 then
                            R(
                                nil,
                                c,
                                bx,
                                y + yy,
                                bw,
                                math.min(3, h - yy),
                                if __gt(
                                    hash(nil, xx * 1.3 + yy * 7 + seed),
                                    0.5
                                ) then col else __L1:shadeHex(col, 0.9)
                            )
                        end
                        xx = xx + 8
                    end
                end
                yy = yy + 4
            end
        end
    end
    __L1.azulejo = function(self, c, x, y, w, h, a, b)
        R(
            nil,
            c,
            x,
            y,
            w,
            h,
            a
        )
        do
            local yy = 0
            while __lt(yy, h) do
                do
                    local xx = __mod(yy / 4, 2) * 2
                    while __lt(xx, w) do
                        R(
                            nil,
                            c,
                            x + xx,
                            y + yy,
                            2,
                            2,
                            b
                        )
                        xx = xx + 4
                    end
                end
                yy = yy + 4
            end
        end
    end
    __L1.roofTiles = function(self, c, x, y, w, h, col)
        if col == nil then
            col = "#a8543c"
        end
        R(
            nil,
            c,
            x,
            y,
            w,
            h,
            __L1:shadeHex(col, 0.8)
        )
        do
            local yy = 0
            while __lt(yy, h) do
                do
                    local xx = __mod(yy / 3, 2) * 2
                    while __lt(xx, w) do
                        R(
                            nil,
                            c,
                            x + xx,
                            y + yy,
                            3,
                            2,
                            col
                        )
                        R(
                            nil,
                            c,
                            x + xx,
                            y + yy,
                            3,
                            1,
                            __L1:shadeHex(col, 1.15)
                        )
                        xx = xx + 4
                    end
                end
                yy = yy + 3
            end
        end
    end
    __L1.janela = function(self, c, x, y, w, h, kind, seed)
        R(
            nil,
            c,
            x - 1,
            y - 1,
            w + 2,
            h + 2,
            "#3a3a36"
        )
        R(
            nil,
            c,
            x,
            y,
            w,
            h,
            "#5f8496"
        )
        R(
            nil,
            c,
            x + 1,
            y + 1,
            w - 2,
            math.max(
                1,
                math.floor(h * 0.35 + 0.5)
            ),
            "#8fb4c2"
        )
        if __gt(
            hash(nil, seed),
            0.45
        ) then
            local cc = __L1:pick(__L1.CURT, seed + 1)
            R(
                nil,
                c,
                x,
                y,
                math.floor(w * 0.35 + 0.5),
                h,
                cc
            )
            R(
                nil,
                c,
                __add(x, w) - math.floor(w * 0.3 + 0.5),
                y,
                math.floor(w * 0.3 + 0.5),
                h,
                cc
            )
        end
        if kind == "grade" then
            do
                local k = 2
                while __lt(k, w) do
                    R(
                        nil,
                        c,
                        x + k,
                        y,
                        1,
                        h,
                        "#2a2a28"
                    )
                    k = k + 3
                end
            end
        end
        if kind == "veneziana" then
            local col = __L1:pick(
                __arrL({"#5a7a4a", "#8a5a3a", "#3c6a8a", "#7a3a3a"}, 4),
                seed + 2
            )
            R(
                nil,
                c,
                x - 3,
                y - 1,
                3,
                h + 2,
                col
            )
            R(
                nil,
                c,
                __add(x, w),
                y - 1,
                3,
                h + 2,
                col
            )
            do
                local k = 0
                while __lt(k, h) do
                    R(
                        nil,
                        c,
                        x - 3,
                        y + k,
                        3,
                        1,
                        __L1:shadeHex(col, 0.75)
                    )
                    R(
                        nil,
                        c,
                        __add(x, w),
                        y + k,
                        3,
                        1,
                        __L1:shadeHex(col, 0.75)
                    )
                    k = k + 2
                end
            end
        end
        if kind == "vidro" then
            R(
                nil,
                c,
                x + math.floor(w / 2 + 0.5),
                y,
                1,
                h,
                "#2c3a44"
            )
            R(
                nil,
                c,
                x + 2,
                y + 2,
                2,
                h - 4,
                "#c4e0e8"
            )
        end
        R(
            nil,
            c,
            x - 2,
            __add(y, h) + 1,
            w + 4,
            2,
            "#d8d2c0"
        )
        if __gt(
            hash(nil, seed + 3),
            0.7
        ) then
            R(
                nil,
                c,
                x + 1,
                __add(y, h) - 3,
                w - 2,
                4,
                "#7a4a2a"
            )
            do
                local k = 0
                while k < w - 2 do
                    R(
                        nil,
                        c,
                        x + 1 + k,
                        __add(y, h) - 6 - math.floor(hash(nil, k + seed) * 3 + 0.5),
                        2,
                        4,
                        if __gt(
                            hash(nil, k + seed + 9),
                            0.5
                        ) then "#4f8a3a" else "#e86a7a"
                    )
                    k = k + 3
                end
            end
        end
    end
    __L1.ac = function(self, c, x, y)
        R(
            nil,
            c,
            x,
            y,
            10,
            7,
            "#d8dcdc"
        )
        R(
            nil,
            c,
            x,
            y,
            10,
            1,
            "#f2f4f4"
        )
        do
            local k = 1
            while k < 6 do
                R(
                    nil,
                    c,
                    x + 1,
                    y + k,
                    6,
                    1,
                    "#9aa0a2"
                )
                k = k + 2
            end
        end
        R(
            nil,
            c,
            x + 8,
            y + 2,
            1,
            3,
            "#7a8082"
        )
        R(
            nil,
            c,
            x + 3,
            y + 7,
            1,
            4,
            "#5a5e60"
        )
    end
    __L1.caixaDagua = function(self, c, x, y, kind)
        if kind == nil then
            kind = 0
        end
        if __t(kind) then
            R(
                nil,
                c,
                x,
                y,
                14,
                10,
                "#3c6aa8"
            )
            R(
                nil,
                c,
                x,
                y,
                14,
                2,
                "#6a9ad0"
            )
            R(
                nil,
                c,
                x + 2,
                y - 2,
                10,
                2,
                "#2c5a98"
            )
        else
            ell(
                nil,
                c,
                x + 7,
                y + 5,
                7,
                5,
                "#5a8ab8"
            )
            R(
                nil,
                c,
                x,
                y + 4,
                14,
                6,
                "#3c6aa8"
            )
            R(
                nil,
                c,
                x + 1,
                y + 2,
                12,
                2,
                "#7aaad8"
            )
        end
        R(
            nil,
            c,
            x + 2,
            y + 10,
            2,
            4,
            "#6a6a66"
        )
        R(
            nil,
            c,
            x + 10,
            y + 10,
            2,
            4,
            "#6a6a66"
        )
    end
    __L1.antena = function(self, c, x, y)
        R(
            nil,
            c,
            x,
            y - 14,
            1,
            14,
            "#5a5a56"
        )
        do
            local k = 0
            while k < 4 do
                R(
                    nil,
                    c,
                    x - 4 + k,
                    y - 13 + k * 3,
                    9 - k * 2,
                    1,
                    "#5a5a56"
                )
                k = k + 1
            end
        end
    end
    __L1.parabolica = function(self, c, x, y)
        ell(
            nil,
            c,
            x + 4,
            y + 4,
            5,
            5,
            "#e8e8e4"
        )
        ell(
            nil,
            c,
            x + 4,
            y + 4,
            3,
            3,
            "#c8c8c4"
        )
        R(
            nil,
            c,
            x + 4,
            y + 4,
            4,
            1,
            "#5a5a56"
        )
        R(
            nil,
            c,
            x + 3,
            y + 8,
            2,
            4,
            "#5a5a56"
        )
    end
    __L1.varal = function(self, c, x0, x1, y, seed)
        do
            local x = x0
            while __le(x, x1) do
                R(
                    nil,
                    c,
                    x,
                    y + math.floor(math.sin((x - x0) / (x1 - x0) * math.pi) * 2 + 0.5),
                    2,
                    1,
                    "#4a4a46"
                )
                x = x + 2
            end
        end
        do
            local x = x0 + 3
            while __lt(x, x1 - 4) do
                local col = __L1:pick(
                    __arrL({
                        "#d9634a",
                        "#3c6aa8",
                        "#f2efe6",
                        "#e8c24c",
                        "#7cbf6a",
                        "#c86ab8",
                        "#5ab8c8"
                    }, 7),
                    __add(x, seed)
                )
                local yy = y + math.floor(math.sin((x - x0) / (x1 - x0) * math.pi) * 2 + 0.5) + 1
                if __gt(
                    hash(
                        nil,
                        __add(x, seed)
                    ),
                    0.5
                ) then
                    R(
                        nil,
                        c,
                        x,
                        yy,
                        6,
                        7,
                        col
                    )
                    R(
                        nil,
                        c,
                        x,
                        yy,
                        6,
                        1,
                        __L1:shadeHex(col, 0.8)
                    )
                else
                    R(
                        nil,
                        c,
                        x + 1,
                        yy,
                        4,
                        9,
                        col
                    )
                    R(
                        nil,
                        c,
                        x + 1,
                        yy + 4,
                        4,
                        1,
                        __L1:shadeHex(col, 0.8)
                    )
                end
                x = x + 7
            end
        end
    end
    __L1.gato = function(self, c, x, y, col)
        if col == nil then
            col = "#2a2a2a"
        end
        R(
            nil,
            c,
            x,
            y - 5,
            8,
            4,
            col
        )
        R(
            nil,
            c,
            x + 6,
            y - 8,
            4,
            4,
            col
        )
        R(
            nil,
            c,
            x + 6,
            y - 9,
            1,
            1,
            col
        )
        R(
            nil,
            c,
            x + 9,
            y - 9,
            1,
            1,
            col
        )
        R(
            nil,
            c,
            x + 8,
            y - 7,
            1,
            1,
            "#e8d84a"
        )
        R(
            nil,
            c,
            x - 3,
            y - 7,
            4,
            1,
            col
        )
        R(
            nil,
            c,
            x - 3,
            y - 9,
            1,
            2,
            col
        )
        R(
            nil,
            c,
            x + 1,
            y - 1,
            1,
            1,
            col
        )
        R(
            nil,
            c,
            x + 5,
            y - 1,
            1,
            1,
            col
        )
    end
    __L1.cachorro = function(self, c, x, y, col)
        if col == nil then
            col = "#c98a43"
        end
        R(
            nil,
            c,
            x,
            y - 7,
            14,
            5,
            col
        )
        R(
            nil,
            c,
            x + 12,
            y - 11,
            6,
            6,
            col
        )
        R(
            nil,
            c,
            x + 16,
            y - 8,
            3,
            3,
            __L1:shadeHex(col, 1.2)
        )
        R(
            nil,
            c,
            x + 14,
            y - 9,
            1,
            1,
            "#2a2a2a"
        )
        R(
            nil,
            c,
            x + 12,
            y - 12,
            2,
            3,
            __L1:shadeHex(col, 0.7)
        )
        R(
            nil,
            c,
            x - 3,
            y - 9,
            4,
            2,
            col
        )
        R(
            nil,
            c,
            x + 1,
            y - 2,
            2,
            2,
            col
        )
        R(
            nil,
            c,
            x + 10,
            y - 2,
            2,
            2,
            col
        )
        R(
            nil,
            c,
            x + 12,
            y - 6,
            2,
            2,
            "#c43c3a"
        )
    end
    __L1.plantaVaso = function(self, c, x, y, seed)
        R(
            nil,
            c,
            x,
            y - 7,
            9,
            7,
            "#a85a3a"
        )
        R(
            nil,
            c,
            x,
            y - 7,
            9,
            1,
            "#c8744a"
        )
        do
            local k = 0
            while k < 4 do
                ell(
                    nil,
                    c,
                    x + 2 + k * 2,
                    y - 10 - __mod(k, 2) * 3,
                    3,
                    3,
                    if __t(__mod(k, 2)) then "#4f8a3a" else "#5f9a46"
                )
                k = k + 1
            end
        end
        if __gt(
            hash(nil, seed),
            0.5
        ) then
            R(
                nil,
                c,
                x + 3,
                y - 14,
                3,
                2,
                __L1:pick(
                    __arrL({"#e86a7a", "#e8c24c", "#f2efe6", "#c86ab8"}, 4),
                    seed
                )
            )
        end
    end
    __L1.grafite = function(self, c, x, y, w, h, seed)
        local cols = __arrL({
            "#e8433a",
            "#f2c94c",
            "#3c9ad8",
            "#7ac85a",
            "#c86ab8",
            "#f08a24"
        }, 6)
        do
            local i = 0
            while i < w * h / 30 do
                local px = x + hash(nil, i + seed) * w
                local py = y + hash(nil, i * 3 + seed) * h
                ell(
                    nil,
                    c,
                    px,
                    py,
                    2 + hash(nil, i * 5 + seed) * 4,
                    2 + hash(nil, i * 7 + seed) * 3,
                    __L1:pick(cols, i + seed)
                )
                i = i + 1
            end
        end
        do
            local k = 0
            while __lt(k, w) do
                R(
                    nil,
                    c,
                    x + k,
                    y + h / 2 + math.floor(math.sin(k * 0.3 + seed) * h * 0.3 + 0.5),
                    2,
                    2,
                    "#1a1a1a"
                )
                k = k + 2
            end
        end
    end
    __L1.cartaz = function(self, c, x, y, seed)
        local bg = __L1:pick(
            __arrL({
                "#f2e8c8",
                "#e8c24c",
                "#f2efe6",
                "#e86a7a",
                "#7ac8e8"
            }, 5),
            seed
        )
        R(
            nil,
            c,
            x,
            y,
            12,
            15,
            bg
        )
        R(
            nil,
            c,
            x,
            y,
            12,
            1,
            __L1:shadeHex(bg, 0.8)
        )
        R(
            nil,
            c,
            x + 2,
            y + 2,
            8,
            2,
            "#2a2a2a"
        )
        R(
            nil,
            c,
            x + 2,
            y + 6,
            8,
            5,
            __L1:pick(
                __arrL({"#c43c3a", "#3c6aa8", "#3c8a5a"}, 3),
                seed + 1
            )
        )
        R(
            nil,
            c,
            x + 2,
            y + 12,
            6,
            1,
            "#2a2a2a"
        )
    end
    __L1.bandeirinhas = function(self, c, x0, x1, y, seed)
        if seed == nil then
            seed = 0
        end
        local cols = __arrL({
            "#e8433a",
            "#f2c94c",
            "#3c9ad8",
            "#7ac85a",
            "#c86ab8",
            "#f08a24",
            "#f2efe6"
        }, 7)
        do
            local x = x0
            while __le(x, x1) do
                R(
                    nil,
                    c,
                    x,
                    y + math.floor(math.sin((x - x0) / (x1 - x0) * math.pi) * 6 + 0.5),
                    2,
                    1,
                    "#3a3a36"
                )
                x = x + 2
            end
        end
        do
            local x = x0 + 2
            local i = 0
            while __lt(x, x1 - 4) do
                local yy = y + 1 + math.floor(math.sin((x - x0) / (x1 - x0) * math.pi) * 6 + 0.5)
                local col = __L1:pick(cols, i + seed)
                do
                    local k = 0
                    while k < 5 do
                        R(
                            nil,
                            c,
                            x + k,
                            yy + k,
                            if 6 - k * 2 > 0 then 6 - k * 2 else 1,
                            1,
                            col
                        )
                        k = k + 1
                    end
                end
                R(
                    nil,
                    c,
                    x,
                    yy,
                    6,
                    1,
                    col
                )
                do
                    x = x + 8
                    i = i + 1
                end
            end
        end
    end
    __L1.predio = function(self, c, x, w, floors, col, seed, o)
        if o == nil then
            o = {}
        end
        local fh = 26
        local top = __L1.GY - floors * fh - if __t(o.loja) then 4 else 0
        __L1:plaster(
            c,
            x,
            top,
            w,
            __L1.GY - top,
            col,
            seed
        )
        R(
            nil,
            c,
            x,
            top,
            w,
            2,
            __L1:shadeHex(col, 1.12)
        )
        R(
            nil,
            c,
            __add(x, w) - 3,
            top,
            3,
            __L1.GY - top,
            __L1:shadeHex(col, 0.85)
        )
        do
            local f = if __t(o.loja) then 1 else 0
            while __lt(f, floors) do
                local yy = __L1.GY - (f + 1) * fh + 5
                R(
                    nil,
                    c,
                    x,
                    yy + fh - 6,
                    w,
                    1,
                    __L1:shadeHex(col, 0.88)
                )
                local kind = __L1:pick(
                    __arrL({"grade", "veneziana", "vidro", "grade"}, 4),
                    seed + f
                )
                local n = math.max(
                    1,
                    math.floor((w - 6) / 18)
                )
                do
                    local k = 0
                    while k < n do
                        local wx = x + 5 + k * ((w - 10) / n)
                        __L1:janela(
                            c,
                            wx,
                            yy,
                            11,
                            13,
                            kind,
                            seed * 7 + f * 13 + k
                        )
                        if __gt(
                            hash(nil, seed + f * 3 + k),
                            0.78
                        ) then
                            __L1:ac(c, wx + 12, yy + 4)
                        end
                        k = k + 1
                    end
                end
                if __t(f > 0 and __gt(
                    hash(nil, seed + f * 11),
                    0.55
                )) then
                    local bw = math.min(w - 8, 40)
                    local bx = x + 4 + math.floor(hash(nil, seed + f) * (w - 8 - bw) + 0.5)
                    R(
                        nil,
                        c,
                        bx,
                        yy + 14,
                        bw,
                        2,
                        "#d8d2c0"
                    )
                    do
                        local k = 0
                        while k < bw do
                            R(
                                nil,
                                c,
                                bx + k,
                                yy + 9,
                                1,
                                5,
                                "#3a3a36"
                            )
                            k = k + 3
                        end
                    end
                    R(
                        nil,
                        c,
                        bx,
                        yy + 9,
                        bw,
                        1,
                        "#3a3a36"
                    )
                    if __gt(
                        hash(nil, seed + f * 5),
                        0.5
                    ) then
                        __L1:varal(
                            c,
                            bx + 2,
                            bx + bw - 2,
                            yy + 2,
                            seed + f
                        )
                    else
                        __L1:plantaVaso(c, bx + 3, yy + 14, seed + f)
                    end
                end
                f = f + 1
            end
        end
        if __t(o.telhado) then
            __L1:roofTiles(
                c,
                x - 3,
                top - 7,
                w + 6,
                7,
                o.telhado
            )
        else
            R(
                nil,
                c,
                x - 1,
                top - 3,
                w + 2,
                3,
                __L1:shadeHex(col, 0.8)
            )
            if __gt(
                hash(nil, seed + 31),
                0.3
            ) then
                __L1:caixaDagua(
                    c,
                    x + 4 + math.floor(hash(nil, seed + 32) * (w - 20) + 0.5),
                    top - 17,
                    if __gt(
                        hash(nil, seed + 33),
                        0.5
                    ) then 1 else 0
                )
            end
            if __gt(
                hash(nil, seed + 34),
                0.4
            ) then
                __L1:antena(
                    c,
                    __add(x, w) - 6,
                    top - 3
                )
            end
            if __gt(
                hash(nil, seed + 35),
                0.6
            ) then
                __L1:parabolica(c, x + 6, top - 15)
            end
        end
        return top
    end
    __L1.loja = function(self, c, x, w, signCol, a, b, seed)
        local ____call_6 = __call
        local ____t_5 = __t
        local ____get_result_4 = __get(__L1.LOJAS, __L1.CUR)
        __O[389] = ____get_result_4
        ____call_6(
            if ____t_5(____get_result_4) then __O[389] else __set(
                __L1.LOJAS,
                __L1.CUR,
                __arrL({}, 0)
            ),
            "push",
            __arrL({x, w, signCol}, 3)
        )
        R(
            nil,
            c,
            x,
            __L1.GY - 30,
            w,
            30,
            "#e8e2d2"
        )
        R(
            nil,
            c,
            x + 2,
            __L1.GY - 30,
            w - 4,
            9,
            signCol
        )
        R(
            nil,
            c,
            x + 2,
            __L1.GY - 30,
            w - 4,
            1,
            __L1:shadeHex(signCol, 1.3)
        )
        R(
            nil,
            c,
            x + 2,
            __L1.GY - 22,
            w - 4,
            1,
            __L1:shadeHex(signCol, 0.6)
        )
        do
            local k = 0
            while __lt(k, w) do
                R(
                    nil,
                    c,
                    x + k,
                    __L1.GY - 21,
                    6,
                    5,
                    if __t(__mod(k / 6, 2)) then a else b
                )
                R(
                    nil,
                    c,
                    x + k,
                    __L1.GY - 16,
                    6,
                    1,
                    "#00000033"
                )
                k = k + 6
            end
        end
        local dw = math.floor(w * 0.45 + 0.5)
        R(
            nil,
            c,
            x + 3,
            __L1.GY - 15,
            dw,
            15,
            "#7a8086"
        )
        do
            local k = 0
            while k < 8 do
                R(
                    nil,
                    c,
                    x + 3,
                    __L1.GY - 15 + k,
                    dw,
                    1,
                    "#5a6066"
                )
                k = k + 2
            end
        end
        R(
            nil,
            c,
            x + 3,
            __L1.GY - 7,
            dw,
            7,
            "#2a2c30"
        )
        R(
            nil,
            c,
            x + dw + 5,
            __L1.GY - 15,
            w - dw - 8,
            15,
            "#3c4c58"
        )
        R(
            nil,
            c,
            x + dw + 6,
            __L1.GY - 14,
            w - dw - 10,
            13,
            "#8fb4c2"
        )
        do
            local k = 0
            while k < 4 do
                R(
                    nil,
                    c,
                    x + dw + 8 + k * ((w - dw - 14) / 4),
                    __L1.GY - 7,
                    4,
                    7,
                    __L1:pick(
                        __arrL({
                            "#d9634a",
                            "#e8c24c",
                            "#5f9fd0",
                            "#7cbf6a",
                            "#c86ab8"
                        }, 5),
                        seed + k
                    )
                )
                k = k + 1
            end
        end
    end
    __L1.casa = function(self, c, x, w, col, seed, o)
        if o == nil then
            o = {}
        end
        local h = if __t(o.h) then o.h else 34
        local top = __L1.GY - h
        if __gt(
            hash(nil, seed + 7),
            0.5
        ) then
            __L1:brick(
                c,
                x,
                top,
                w,
                h,
                "#b0624a",
                seed
            )
        else
            __L1:plaster(
                c,
                x,
                top,
                w,
                h,
                col,
                seed
            )
        end
        __L1:roofTiles(
            c,
            x - 4,
            top - 8,
            w + 8,
            8,
            if __t(o.telhado) then o.telhado else __L1:pick(
                __arrL({"#a8543c", "#9a4a34", "#b8644a"}, 3),
                seed
            )
        )
        __L1:janela(
            c,
            x + 8,
            top + 8,
            14,
            13,
            if __gt(
                hash(nil, seed),
                0.4
            ) then "grade" else "veneziana",
            seed
        )
        if __gt(w, 60) then
            __L1:janela(
                c,
                __add(x, w) - 28,
                top + 8,
                14,
                13,
                "grade",
                seed + 5
            )
        end
        R(
            nil,
            c,
            x + math.floor(w / 2 + 0.5) - 6,
            top + 10,
            12,
            h - 10,
            "#6a4a32"
        )
        R(
            nil,
            c,
            x + math.floor(w / 2 + 0.5) - 5,
            top + 11,
            10,
            h - 12,
            "#8a6440"
        )
        R(
            nil,
            c,
            x + math.floor(w / 2 + 0.5) + 2,
            top + 24,
            2,
            2,
            "#e8c24c"
        )
        if __gt(
            hash(nil, seed + 21),
            0.5
        ) then
            __L1:caixaDagua(
                c,
                __add(x, w) - 20,
                top - 22,
                if __gt(
                    hash(nil, seed + 22),
                    0.5
                ) then 1 else 0
            )
        end
        if __gt(
            hash(nil, seed + 23),
            0.6
        ) then
            __L1:antena(c, x + 6, top - 8)
        end
        local mc = __L1:pick(
            __arrL({"#e8e2d2", "#d8e2d8", "#f0e0c8", "#e0d8e8"}, 4),
            seed + 3
        )
        __L1:plaster(
            c,
            x - 6,
            __L1.GY - 10,
            w + 12,
            10,
            mc,
            seed + 4
        )
        R(
            nil,
            c,
            x - 6,
            __L1.GY - 11,
            w + 12,
            2,
            __L1:shadeHex(mc, 1.08)
        )
        do
            local k = 0
            while __lt(k, w + 12) do
                R(
                    nil,
                    c,
                    x - 6 + k,
                    __L1.GY - 18,
                    1,
                    7,
                    "#2e2e2c"
                )
                k = k + 3
            end
        end
        R(
            nil,
            c,
            x - 6,
            __L1.GY - 18,
            w + 12,
            1,
            "#2e2e2c"
        )
        if __gt(
            hash(nil, seed + 11),
            0.6
        ) then
            __L1:gato(
                c,
                x + math.floor(hash(nil, seed + 12) * w + 0.5),
                __L1.GY - 11,
                __L1:pick(
                    __arrL({"#2a2a2a", "#d8a24a", "#f2efe6", "#7a7a7a"}, 4),
                    seed
                )
            )
        end
        if __gt(
            hash(nil, seed + 13),
            0.5
        ) then
            __L1:plantaVaso(c, x - 4, __L1.GY, seed)
        end
        if __gt(
            hash(nil, seed + 14),
            0.55
        ) then
            __L1:varal(
                c,
                x - 4,
                __add(x, w) + 4,
                top - 2,
                seed
            )
        end
        R(
            nil,
            c,
            x + 2,
            top + 2,
            6,
            4,
            "#3c6aa8"
        )
        R(
            nil,
            c,
            x + 3,
            top + 3,
            4,
            2,
            "#f2efe6"
        )
    end
    __L1.orelhao = function(self, c, x)
        R(
            nil,
            c,
            x + 4,
            __L1.GY - 26,
            2,
            26,
            "#5a5a56"
        )
        ell(
            nil,
            c,
            x + 5,
            __L1.GY - 30,
            9,
            8,
            "#2c6ab8"
        )
        ell(
            nil,
            c,
            x + 5,
            __L1.GY - 29,
            7,
            6,
            "#4a8ad8"
        )
        R(
            nil,
            c,
            x + 2,
            __L1.GY - 28,
            6,
            8,
            "#e8e8e4"
        )
        R(
            nil,
            c,
            x + 3,
            __L1.GY - 26,
            4,
            2,
            "#2a2a2a"
        )
        R(
            nil,
            c,
            x + 6,
            __L1.GY - 22,
            1,
            4,
            "#2a2a2a"
        )
    end
    __L1.banca = function(self, c, x)
        R(
            nil,
            c,
            x,
            __L1.GY - 34,
            44,
            34,
            "#2c5a8a"
        )
        R(
            nil,
            c,
            x - 2,
            __L1.GY - 38,
            48,
            5,
            "#1d4070"
        )
        R(
            nil,
            c,
            x + 2,
            __L1.GY - 30,
            40,
            24,
            "#e8e2d2"
        )
        do
            local k = 0
            while k < 12 do
                R(
                    nil,
                    c,
                    x + 3 + __mod(k, 6) * 6.5,
                    __L1.GY - 29 + math.floor(k / 6) * 11,
                    5,
                    9,
                    __L1:pick(
                        __arrL({
                            "#d9634a",
                            "#e8c24c",
                            "#3c8ad8",
                            "#7cbf6a",
                            "#c86ab8",
                            "#f2efe6"
                        }, 6),
                        k + x
                    )
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            x + 4,
            __L1.GY - 6,
            36,
            6,
            "#1d4070"
        )
    end
    __L1.ponto = function(self, c, x)
        R(
            nil,
            c,
            x,
            __L1.GY - 34,
            2,
            34,
            "#5a6066"
        )
        R(
            nil,
            c,
            x + 38,
            __L1.GY - 34,
            2,
            34,
            "#5a6066"
        )
        R(
            nil,
            c,
            x - 2,
            __L1.GY - 37,
            44,
            4,
            "#3c4a5a"
        )
        R(
            nil,
            c,
            x + 2,
            __L1.GY - 33,
            36,
            18,
            "rgba(160,200,220,.35)"
        )
        R(
            nil,
            c,
            x + 4,
            __L1.GY - 31,
            14,
            14,
            "#e8c24c"
        )
        R(
            nil,
            c,
            x + 6,
            __L1.GY - 29,
            10,
            4,
            "#c43c3a"
        )
        R(
            nil,
            c,
            x + 4,
            __L1.GY - 12,
            32,
            3,
            "#8a6a45"
        )
        R(
            nil,
            c,
            x + 44,
            __L1.GY - 30,
            2,
            30,
            "#5a6066"
        )
        R(
            nil,
            c,
            x + 41,
            __L1.GY - 36,
            8,
            8,
            "#2c6ab8"
        )
        R(
            nil,
            c,
            x + 43,
            __L1.GY - 34,
            4,
            4,
            "#f2efe6"
        )
    end
    __L1.lixeira = function(self, c, x, col)
        if col == nil then
            col = "#f08a24"
        end
        R(
            nil,
            c,
            x,
            __L1.GY - 13,
            9,
            11,
            col
        )
        R(
            nil,
            c,
            x,
            __L1.GY - 13,
            9,
            2,
            __L1:shadeHex(col, 1.2)
        )
        R(
            nil,
            c,
            x + 3,
            __L1.GY - 2,
            3,
            2,
            "#5a5a56"
        )
        R(
            nil,
            c,
            x + 2,
            __L1.GY - 9,
            5,
            1,
            __L1:shadeHex(col, 0.7)
        )
    end
    __L1.hidrante = function(self, c, x)
        R(
            nil,
            c,
            x,
            __L1.GY - 9,
            6,
            9,
            "#c43c3a"
        )
        R(
            nil,
            c,
            x - 1,
            __L1.GY - 10,
            8,
            2,
            "#d85a4a"
        )
        R(
            nil,
            c,
            x - 2,
            __L1.GY - 6,
            10,
            2,
            "#a82c2a"
        )
    end
    __L1.placaRua = function(self, c, x)
        R(
            nil,
            c,
            x,
            __L1.GY - 40,
            2,
            40,
            "#6a6a66"
        )
        R(
            nil,
            c,
            x - 14,
            __L1.GY - 46,
            30,
            8,
            "#1d4a8a"
        )
        R(
            nil,
            c,
            x - 13,
            __L1.GY - 45,
            28,
            6,
            "#2c5aa8"
        )
        R(
            nil,
            c,
            x - 11,
            __L1.GY - 43,
            24,
            1,
            "#f2efe6"
        )
        R(
            nil,
            c,
            x - 11,
            __L1.GY - 41,
            18,
            1,
            "#f2efe6"
        )
    end
    __L1.moto = function(self, c, x, col)
        if col == nil then
            col = "#c43c3a"
        end
        ell(
            nil,
            c,
            x + 3,
            __L1.GY - 3,
            3,
            3,
            "#1c1c1c"
        )
        ell(
            nil,
            c,
            x + 17,
            __L1.GY - 3,
            3,
            3,
            "#1c1c1c"
        )
        R(
            nil,
            c,
            x + 4,
            __L1.GY - 9,
            13,
            4,
            col
        )
        R(
            nil,
            c,
            x + 6,
            __L1.GY - 12,
            8,
            3,
            "#2a2a2a"
        )
        R(
            nil,
            c,
            x + 15,
            __L1.GY - 14,
            2,
            6,
            "#5a5a56"
        )
        R(
            nil,
            c,
            x + 14,
            __L1.GY - 15,
            5,
            1,
            "#5a5a56"
        )
        R(
            nil,
            c,
            x + 16,
            __L1.GY - 8,
            3,
            2,
            "#fff2b0"
        )
    end
    __L1.bike = function(self, c, x, col)
        if col == nil then
            col = "#3c8ad8"
        end
        ell(
            nil,
            c,
            x + 3,
            __L1.GY - 4,
            4,
            4,
            "#2a2a2a"
        )
        ell(
            nil,
            c,
            x + 3,
            __L1.GY - 4,
            2,
            2,
            "#c8c8c4"
        )
        ell(
            nil,
            c,
            x + 17,
            __L1.GY - 4,
            4,
            4,
            "#2a2a2a"
        )
        ell(
            nil,
            c,
            x + 17,
            __L1.GY - 4,
            2,
            2,
            "#c8c8c4"
        )
        limb(
            nil,
            c,
            __arrL(
                {
                    __arrL({x + 3, __L1.GY - 4}, 2),
                    __arrL({x + 9, __L1.GY - 10}, 2),
                    __arrL({x + 17, __L1.GY - 4}, 2)
                },
                3
            ),
            1,
            col
        )
        limb(
            nil,
            c,
            __arrL(
                {
                    __arrL({x + 9, __L1.GY - 10}, 2),
                    __arrL({x + 15, __L1.GY - 10}, 2),
                    __arrL({x + 17, __L1.GY - 4}, 2)
                },
                3
            ),
            1,
            col
        )
        R(
            nil,
            c,
            x + 7,
            __L1.GY - 12,
            4,
            1,
            "#2a2a2a"
        )
        R(
            nil,
            c,
            x + 15,
            __L1.GY - 13,
            1,
            3,
            "#5a5a56"
        )
    end
    __L1.carro = function(self, c, x, y, col, dir)
        if dir == nil then
            dir = 1
        end
        local w = 30
        R(
            nil,
            c,
            x,
            y - 8,
            w,
            7,
            col
        )
        R(
            nil,
            c,
            x + if dir > 0 then 7 else 4,
            y - 13,
            18,
            6,
            col
        )
        R(
            nil,
            c,
            x + if dir > 0 then 9 else 6,
            y - 12,
            14,
            4,
            "#9fc4d0"
        )
        R(
            nil,
            c,
            x + if dir > 0 then 16 else 13,
            y - 12,
            1,
            4,
            col
        )
        ell(
            nil,
            c,
            x + 6,
            y - 1,
            3,
            3,
            "#1c1c1c"
        )
        ell(
            nil,
            c,
            x + w - 6,
            y - 1,
            3,
            3,
            "#1c1c1c"
        )
        R(
            nil,
            c,
            if dir > 0 then x + w - 2 else x,
            y - 7,
            2,
            2,
            "#fff2b0"
        )
        R(
            nil,
            c,
            if dir > 0 then x else x + w - 2,
            y - 7,
            2,
            2,
            "#d8443a"
        )
        R(
            nil,
            c,
            x,
            y - 8,
            w,
            1,
            "rgba(255,255,255,.35)"
        )
        R(
            nil,
            c,
            x + 2,
            y - 4,
            w - 4,
            1,
            __L1:shadeHex(col, 0.7)
        )
    end
    __L1.poste = function(self, c, x)
        R(
            nil,
            c,
            x,
            52,
            3,
            __L1.GY - 52,
            "#7a756a"
        )
        R(
            nil,
            c,
            x,
            52,
            1,
            __L1.GY - 52,
            "#9a958a"
        )
        R(
            nil,
            c,
            x - 12,
            56,
            27,
            2,
            "#5a554a"
        )
        R(
            nil,
            c,
            x - 8,
            70,
            10,
            12,
            "#6a6a66"
        )
        R(
            nil,
            c,
            x - 7,
            71,
            8,
            2,
            "#8a8a86"
        )
        R(
            nil,
            c,
            x + 3,
            88,
            10,
            2,
            "#5a554a"
        )
        R(
            nil,
            c,
            x + 11,
            86,
            6,
            4,
            "#f2f0d8"
        )
    end
    __L1.fios = function(self, c, x0, x1, y0)
        do
            local x = x0
            while __lt(x, x1) do
                for ____, ____value in __iterar((__arrL(
                    {
                        __arrL({0, 9}, 2),
                        __arrL({5, 12}, 2),
                        __arrL({9, 7}, 2)
                    },
                    3
                ))) do
                    local dy = ____value[1]
                    local sag = ____value[2]
                    R(
                        nil,
                        c,
                        x,
                        y0 + dy + math.floor(math.sin((x - x0) / (x1 - x0) * math.pi) * sag + 0.5),
                        2,
                        1,
                        "#26262a"
                    )
                end
                x = x + 2
            end
        end
    end
    __L1.canteiro = function(self, c, x, w)
        R(
            nil,
            c,
            x,
            __L1.GY - 6,
            w,
            6,
            "#9a948a"
        )
        R(
            nil,
            c,
            x + 1,
            __L1.GY - 7,
            w - 2,
            2,
            "#6a4a32"
        )
        do
            local k = 2
            while k < w - 2 do
                R(
                    nil,
                    c,
                    x + k,
                    __L1.GY - 10 - math.floor(hash(nil, k + x) * 3 + 0.5),
                    2,
                    4,
                    "#4f8a3a"
                )
                if __gt(
                    hash(nil, k * 3 + x),
                    0.6
                ) then
                    R(
                        nil,
                        c,
                        x + k,
                        __L1.GY - 12,
                        2,
                        2,
                        __L1:pick(
                            __arrL({"#e86a7a", "#e8c24c", "#f2efe6", "#c86ab8"}, 4),
                            k + x
                        )
                    )
                end
                k = k + 3
            end
        end
    end
    __L1.ipe = function(self, c, x, base, col, seed, s)
        if s == nil then
            s = 1
        end
        R(
            nil,
            c,
            x - 2,
            base - 30 * s,
            4,
            30 * s,
            "#5a4232"
        )
        limb(
            nil,
            c,
            __arrL(
                {
                    __arrL({x, base - 22 * s}, 2),
                    __arrL({x - 10 * s, base - 34 * s}, 2)
                },
                2
            ),
            2,
            "#5a4232"
        )
        limb(
            nil,
            c,
            __arrL(
                {
                    __arrL({x, base - 24 * s}, 2),
                    __arrL({x + 11 * s, base - 36 * s}, 2)
                },
                2
            ),
            2,
            "#5a4232"
        )
        do
            local i = 0
            while i < 26 do
                local a = hash(nil, i + seed) * 6.28
                local r = hash(nil, i * 3 + seed) * 16 * s
                ell(
                    nil,
                    c,
                    x + math.cos(a) * r * 1.2,
                    base - 40 * s + math.sin(a) * r * 0.7,
                    4 * s,
                    3.5 * s,
                    if __t(__mod(i, 3)) then col else __L1:shadeHex(col, 0.8)
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 10 do
                R(
                    nil,
                    c,
                    x - 14 * s + hash(nil, i + seed * 2) * 28 * s,
                    base - 1 - hash(nil, i * 5 + seed) * 2,
                    2,
                    1,
                    col
                )
                i = i + 1
            end
        end
    end
    __L1.mesaBar = function(self, c, x)
        R(
            nil,
            c,
            x,
            __L1.GY - 9,
            14,
            2,
            "#e8e2d2"
        )
        R(
            nil,
            c,
            x + 6,
            __L1.GY - 7,
            2,
            7,
            "#8a8a86"
        )
        R(
            nil,
            c,
            x - 4,
            __L1.GY - 7,
            3,
            7,
            "#c43c3a"
        )
        R(
            nil,
            c,
            x + 15,
            __L1.GY - 7,
            3,
            7,
            "#c43c3a"
        )
        ell(
            nil,
            c,
            x + 7,
            __L1.GY - 22,
            12,
            4,
            "#e8c24c"
        )
        R(
            nil,
            c,
            x + 6,
            __L1.GY - 22,
            2,
            13,
            "#8a8a86"
        )
    end
    __L1.calcada = function(self, c, W, col)
        if col == nil then
            col = "#cfc8b6"
        end
        R(
            nil,
            c,
            0,
            204,
            W,
            16,
            col
        )
        do
            local x = 0
            while __lt(x, W) do
                R(
                    nil,
                    c,
                    x,
                    204,
                    1,
                    16,
                    __L1:shadeHex(col, 0.86)
                )
                if __gt(
                    hash(nil, x),
                    0.7
                ) then
                    limb(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({x + 3, 206}, 2),
                                __arrL({x + 6, 211}, 2),
                                __arrL({x + 5, 216}, 2)
                            },
                            3
                        ),
                        1,
                        __L1:shadeHex(col, 0.8)
                    )
                    R(
                        nil,
                        c,
                        x + 6,
                        217,
                        2,
                        2,
                        "#5f8a46"
                    )
                end
                x = x + 14
            end
        end
        R(
            nil,
            c,
            0,
            204,
            W,
            1,
            __L1:shadeHex(col, 1.1)
        )
        do
            local x = 0
            while __lt(x, W) do
                R(
                    nil,
                    c,
                    x,
                    218,
                    12,
                    2,
                    if __t(__mod(x / 24, 2)) then "#e8c24c" else "#2a2a2a"
                )
                x = x + 24
            end
        end
        R(
            nil,
            c,
            0,
            220,
            W,
            1,
            "#8a8478"
        )
    end
    __L1.asfalto = function(self, c, W, faixas)
        if faixas == nil then
            faixas = __arrL({}, 0)
        end
        R(
            nil,
            c,
            0,
            221,
            W,
            LH - 221,
            "#5b5f62"
        )
        do
            local i = 0
            while i < W * 6 do
                R(
                    nil,
                    c,
                    hash(nil, i * 1.3) * W,
                    222 + hash(nil, i * 2.7) * 48,
                    1,
                    1,
                    if __t(__mod(i, 2)) then "#6c7073" else "#4c5053"
                )
                i = i + 1
            end
        end
        do
            local x = 0
            while __lt(x, W) do
                R(
                    nil,
                    c,
                    x,
                    246,
                    20,
                    2,
                    "#e8dc8a"
                )
                x = x + 40
            end
        end
        R(
            nil,
            c,
            0,
            266,
            W,
            1,
            "#e8e4dc"
        )
        do
            local x = 60
            while __lt(x, W) do
                ell(
                    nil,
                    c,
                    x,
                    238,
                    6,
                    2,
                    "#3c4042"
                )
                R(
                    nil,
                    c,
                    x - 4,
                    237,
                    8,
                    1,
                    "#7a7e80"
                )
                x = x + 310
            end
        end
        for ____, fx in __iterar((faixas)) do
            do
                local k = 0
                while k < 6 do
                    R(
                        nil,
                        c,
                        fx + k * 8,
                        223,
                        5,
                        44,
                        "#e8e8e2"
                    )
                    k = k + 1
                end
            end
        end
    end
    __L1.pedraPortuguesa = function(self, c, W, y)
        if y == nil then
            y = 204
        end
        R(
            nil,
            c,
            0,
            y,
            W,
            LH - y,
            "#e4dfd2"
        )
        do
            local i = 0
            while i < W * 4 do
                R(
                    nil,
                    c,
                    hash(nil, i * 1.9) * W,
                    y + hash(nil, i * 3.3) * (LH - y),
                    1,
                    1,
                    if __t(__mod(i, 2)) then "#d2cdc0" else "#ece8de"
                )
                i = i + 1
            end
        end
        do
            local x = 0
            while __lt(x, W) do
                local yy = y + 14 + math.floor(math.sin(x * 0.07) * 3 + 0.5)
                R(
                    nil,
                    c,
                    x,
                    yy,
                    1,
                    1,
                    "#7a766c"
                )
                R(
                    nil,
                    c,
                    x,
                    yy + 22,
                    1,
                    1,
                    "#8a867c"
                )
                x = x + 1
            end
        end
        R(
            nil,
            c,
            0,
            y,
            W,
            1,
            "#f2eee4"
        )
    end
    __L1.pisoInterno = function(self, c, W, a, b, step)
        if a == nil then
            a = "#dedad0"
        end
        if b == nil then
            b = "#c8c4b8"
        end
        if step == nil then
            step = 20
        end
        R(
            nil,
            c,
            0,
            210,
            W,
            10,
            __L1:shadeHex(a, 0.92)
        )
        R(
            nil,
            c,
            0,
            210,
            W,
            2,
            "#f4f2ea"
        )
        R(
            nil,
            c,
            0,
            218,
            W,
            2,
            __L1:shadeHex(b, 0.85)
        )
        R(
            nil,
            c,
            0,
            220,
            W,
            LH - 220,
            a
        )
        do
            local x = 0
            while __lt(x, W) do
                R(
                    nil,
                    c,
                    x,
                    220,
                    1,
                    LH - 220,
                    b
                )
                x = x + step
            end
        end
        do
            local y = 232
            while __lt(y, LH) do
                R(
                    nil,
                    c,
                    0,
                    y,
                    W,
                    1,
                    b
                )
                y = y + 14
            end
        end
        do
            local x = 0
            while __lt(x, W) do
                R(
                    nil,
                    c,
                    x + 2,
                    222,
                    step - 4,
                    6,
                    "rgba(255,255,255,.18)"
                )
                x = x + step * 2
            end
        end
    end
    __L1.terra = function(self, c, W, a, b)
        if a == nil then
            a = "#6f8a46"
        end
        if b == nil then
            b = "#557038"
        end
        R(
            nil,
            c,
            0,
            220,
            W,
            LH - 220,
            "#7a5a3a"
        )
        R(
            nil,
            c,
            0,
            220,
            W,
            5,
            a
        )
        dither(
            nil,
            c,
            0,
            225,
            W,
            b
        )
        do
            local x = 0
            while __lt(x, W) do
                R(
                    nil,
                    c,
                    x,
                    217 - math.floor(hash(nil, x) * 4 + 0.5),
                    1,
                    4,
                    if __t(__mod(x, 2)) then a else "#8ab05a"
                )
                x = x + 3
            end
        end
        do
            local i = 0
            while i < W / 5 do
                R(
                    nil,
                    c,
                    hash(nil, i + 7) * W,
                    232 + hash(nil, i + 8) * 34,
                    3,
                    2,
                    "#8a6a46"
                )
                R(
                    nil,
                    c,
                    hash(nil, i + 17) * W,
                    230 + hash(nil, i + 18) * 36,
                    2,
                    1,
                    "#5a4228"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < W / 12 do
                R(
                    nil,
                    c,
                    hash(nil, i * 5) * W,
                    215 - hash(nil, i) * 2,
                    2,
                    2,
                    __L1:pick(
                        __arrL({"#e8c24c", "#f2efe6", "#c86ab8"}, 3),
                        i
                    )
                )
                i = i + 1
            end
        end
    end
    __L1.buildFar = function(self)
        local T = 964
        local ridge, cr = table.unpack(
            mk(nil, T, LH),
            1,
            2
        )
        local city, cc = table.unpack(
            mk(nil, T, LH),
            1,
            2
        )
        local near, cn = table.unpack(
            mk(nil, T, LH),
            1,
            2
        )
        local trees, ct = table.unpack(
            mk(nil, T, LH),
            1,
            2
        )
        local nCity, nc = table.unpack(
            mk(nil, T, LH),
            1,
            2
        )
        local nNear, nn = table.unpack(
            mk(nil, T, LH),
            1,
            2
        )
        local nRidge, nr = table.unpack(
            mk(nil, T, LH),
            1,
            2
        )
        do
            local x = 0
            while x < T do
                local h = 10 + math.sin(x * 0.009) * 5 + math.sin(x * 0.031) * 3 + if __t(x > 520 and x < 900) then math.sin((x - 520) / 380 * math.pi) * 22 else 0
                do
                    local y = 0
                    while y < h do
                        R(
                            nil,
                            cr,
                            x,
                            150 - h + y,
                            1,
                            1,
                            if y < 2 then "#c4d0d4" else __call(
                                __call(
                                    mix(
                                        nil,
                                        __arrL({0.62, 0.7, 0.74}, 3),
                                        __arrL({0.55, 0.64, 0.66}, 3),
                                        y / 30
                                    ),
                                    "map",
                                    function(____, v) return math.floor(v * 255 + 0.5) end
                                ),
                                "reduce",
                                function(____, s, v) return __add(
                                    s,
                                    __call(
                                        __call(v, "toString", 16),
                                        "padStart",
                                        2,
                                        "0"
                                    )
                                ) end,
                                "#"
                            )
                        )
                        y = y + 1
                    end
                end
                x = x + 1
            end
        end
        R(
            nil,
            cr,
            0,
            150,
            T,
            120,
            "#9aaea6"
        )
        for ____, ax in __iterar((__arrL({590, 640, 820}, 3))) do
            R(
                nil,
                cr,
                ax,
                110,
                1,
                22,
                "#7d8a88"
            )
            do
                local k = 0
                while k < 22 do
                    R(
                        nil,
                        cr,
                        ax - 1,
                        110 + k,
                        3,
                        1,
                        "#8d9a98"
                    )
                    k = k + 4
                end
            end
            R(
                nil,
                nr,
                ax,
                109,
                1,
                1,
                "#ff5a4a"
            )
        end
        R(
            nil,
            cr,
            708,
            112,
            1,
            14,
            "#6f7f7a"
        )
        R(
            nil,
            cr,
            704,
            115,
            9,
            1,
            "#6f7f7a"
        )
        ell(
            nil,
            cr,
            708,
            127,
            3,
            1,
            "#6f7f7a"
        )
        local pal = __arrL({
            "#ebe8de",
            "#e0d6c2",
            "#f3f0e8",
            "#d4cab6",
            "#e6ded0",
            "#dfe6ea",
            "#e8dcc8"
        }, 7)
        do
            local i = 0
            while i < 150 do
                local x = math.floor(hash(nil, i + 900) * T + 0.5)
                local w = 6 + math.floor(hash(nil, i + 901) * 10 + 0.5)
                local h = 8 + math.floor(hash(nil, i + 902) ^ 1.8 * 44 + 0.5)
                local y = 160 - h
                local col = __get(
                    pal,
                    __mod(
                        i,
                        __len(pal)
                    )
                )
                R(
                    nil,
                    cc,
                    x,
                    y,
                    w,
                    h + 4,
                    col
                )
                R(
                    nil,
                    cc,
                    x + w - 2,
                    y,
                    2,
                    h + 4,
                    __L1:shadeHex(col, 0.82)
                )
                R(
                    nil,
                    cc,
                    x,
                    y,
                    w,
                    1,
                    __L1:shadeHex(col, 1.06)
                )
                do
                    local yy = y + 3
                    while yy < 158 do
                        do
                            local xx = x + 1
                            while xx < x + w - 2 do
                                R(
                                    nil,
                                    cc,
                                    xx,
                                    yy,
                                    1,
                                    1,
                                    "#93a8b2"
                                )
                                if __gt(
                                    hash(nil, xx * 7 + yy),
                                    0.64
                                ) then
                                    R(
                                        nil,
                                        nc,
                                        xx,
                                        yy,
                                        1,
                                        1,
                                        __L1:pick(
                                            __arrL({"#ffd98a", "#ffe6b0", "#fff2d0"}, 3),
                                            xx + yy
                                        )
                                    )
                                end
                                xx = xx + 2
                            end
                        end
                        yy = yy + 3
                    end
                end
                if __gt(
                    hash(nil, i + 903),
                    0.4
                ) then
                    R(
                        nil,
                        cc,
                        x + 1,
                        y - 3,
                        4,
                        3,
                        "#4a7ab0"
                    )
                end
                if __gt(
                    hash(nil, i + 904),
                    0.6
                ) then
                    R(
                        nil,
                        cc,
                        x + w - 3,
                        y - 6,
                        1,
                        6,
                        "#7a7a76"
                    )
                end
                if __gt(
                    hash(nil, i + 905),
                    0.75
                ) then
                    R(
                        nil,
                        cc,
                        x,
                        y + math.floor(h * 0.3 + 0.5),
                        w,
                        1,
                        __L1:pick(
                            __arrL({"#3c8ad8", "#c4743a", "#3c9a6a"}, 3),
                            i
                        )
                    )
                end
                i = i + 1
            end
        end
        for ____, gx in __iterar((__arrL({210, 760}, 2))) do
            R(
                nil,
                cc,
                gx,
                92,
                2,
                68,
                "#e8a83a"
            )
            R(
                nil,
                cc,
                gx - 20,
                92,
                48,
                2,
                "#e8a83a"
            )
            R(
                nil,
                cc,
                gx + 22,
                94,
                1,
                18,
                "#5a5a56"
            )
            do
                local k = 92
                while k < 160 do
                    R(
                        nil,
                        cc,
                        gx - 1,
                        k,
                        4,
                        1,
                        "#c8882a"
                    )
                    k = k + 4
                end
            end
        end
        do
            local i = 0
            while i < 200 do
                local x = math.floor(hash(nil, i + 300) * T + 0.5)
                local y = 156 + math.floor(hash(nil, i + 301) * 8 + 0.5)
                R(
                    nil,
                    cc,
                    x,
                    y,
                    5,
                    2,
                    "#c4704f"
                )
                R(
                    nil,
                    cc,
                    x,
                    y + 2,
                    5,
                    3,
                    "#e6dccb"
                )
                if __gt(
                    hash(nil, i + 302),
                    0.55
                ) then
                    R(
                        nil,
                        nc,
                        x + 2,
                        y + 3,
                        1,
                        1,
                        "#ffcf7a"
                    )
                end
                i = i + 1
            end
        end
        R(
            nil,
            cc,
            0,
            164,
            T,
            106,
            "#a5b39a"
        )
        do
            local x = 0
            while x < T do
                R(
                    nil,
                    cc,
                    x,
                    164,
                    2,
                    1,
                    "#bac6ab"
                )
                x = x + 3
            end
        end
        do
            local i = 0
            while i < 46 do
                local x = math.floor(hash(nil, i + 1200) * T + 0.5)
                local w = 18 + math.floor(hash(nil, i + 1201) * 18 + 0.5)
                local h = 30 + math.floor(hash(nil, i + 1202) ^ 1.5 * 70 + 0.5)
                local y = 172 - h
                local col = __get(
                    pal,
                    __mod(
                        i + 3,
                        __len(pal)
                    )
                )
                R(
                    nil,
                    cn,
                    x - 1,
                    y - 1,
                    w + 2,
                    h + 1,
                    __L1:shadeHex(col, 0.7)
                )
                R(
                    nil,
                    cn,
                    x,
                    y,
                    w,
                    h,
                    col
                )
                R(
                    nil,
                    cn,
                    x + w - 3,
                    y,
                    3,
                    h,
                    __L1:shadeHex(col, 0.84)
                )
                do
                    local yy = y + 4
                    while yy < 168 do
                        R(
                            nil,
                            cn,
                            x + 1,
                            yy + 4,
                            w - 2,
                            1,
                            __L1:shadeHex(col, 0.9)
                        )
                        do
                            local xx = x + 3
                            while xx < x + w - 4 do
                                R(
                                    nil,
                                    cn,
                                    xx,
                                    yy,
                                    2,
                                    3,
                                    "#7f98a6"
                                )
                                R(
                                    nil,
                                    cn,
                                    xx,
                                    yy,
                                    2,
                                    1,
                                    "#a9c2cc"
                                )
                                if __gt(
                                    hash(nil, xx * 11 + yy),
                                    0.6
                                ) then
                                    R(
                                        nil,
                                        nn,
                                        xx,
                                        yy,
                                        2,
                                        3,
                                        __L1:pick(
                                            __arrL({"#ffd98a", "#ffe9b8", "#fff4dc", "#ffc870"}, 4),
                                            xx * 3 + yy
                                        )
                                    )
                                end
                                xx = xx + 4
                            end
                        end
                        if __gt(
                            hash(nil, i * 9 + yy),
                            0.82
                        ) then
                            R(
                                nil,
                                cn,
                                x + w - 6,
                                yy + 1,
                                3,
                                2,
                                "#d8dcdc"
                            )
                        end
                        yy = yy + 6
                    end
                end
                if __gt(
                    hash(nil, i + 1203),
                    0.3
                ) then
                    __L1:caixaDagua(cn, x + 3, y - 14, if __gt(
                        hash(nil, i + 1204),
                        0.5
                    ) then 1 else 0)
                end
                if __gt(
                    hash(nil, i + 1205),
                    0.5
                ) then
                    __L1:antena(cn, x + w - 4, y)
                end
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 90 do
                local x = math.floor(hash(nil, i + 1500) * T + 0.5)
                local w = 12 + math.floor(hash(nil, i + 1501) * 10 + 0.5)
                R(
                    nil,
                    cn,
                    x,
                    166,
                    w,
                    8,
                    __L1:pick(
                        __arrL({"#ece6d8", "#f0e2c8", "#e0d8e8", "#d8e4d0"}, 4),
                        i
                    )
                )
                __L1:roofTiles(
                    cn,
                    x - 1,
                    162,
                    w + 2,
                    4,
                    __L1:pick(
                        __arrL({"#b8644a", "#a8543c"}, 2),
                        i
                    )
                )
                if __gt(
                    hash(nil, i + 1502),
                    0.5
                ) then
                    R(
                        nil,
                        nn,
                        x + 3,
                        168,
                        2,
                        2,
                        "#ffcf7a"
                    )
                end
                i = i + 1
            end
        end
        R(
            nil,
            cn,
            0,
            174,
            T,
            96,
            "#98a98c"
        )
        do
            local i = 0
            while i < 120 do
                local x = hash(nil, i + 2000) * T
                local y = 176 + hash(nil, i + 2001) * 6
                local kind = hash(nil, i + 2002)
                ell(
                    nil,
                    ct,
                    x,
                    y,
                    8 + hash(nil, i) * 6,
                    6,
                    if __gt(kind, 0.82) then "#b86ac8" else if __gt(kind, 0.7) then "#e8c84a" else if __t(__mod(i, 2)) then "#4f7a46" else "#5f8a52"
                )
                ell(
                    nil,
                    ct,
                    x - 2,
                    y - 2,
                    5,
                    3,
                    if __gt(kind, 0.82) then "#d48ae0" else if __gt(kind, 0.7) then "#f6dc6a" else "#6f9a5c"
                )
                i = i + 1
            end
        end
        R(
            nil,
            ct,
            0,
            180,
            T,
            90,
            "#7a9a62"
        )
        return {
            ridge = ridge,
            city = city,
            near = near,
            trees = trees,
            nCity = nCity,
            nNear = nNear,
            nRidge = nRidge
        }
    end
    __L1.buildFog = function(self)
        local cv, c = table.unpack(
            mk(nil, 964, LH),
            1,
            2
        )
        do
            local i = 0
            while i < 70 do
                local x = hash(nil, i + 50) * 964
                local y = 120 + hash(nil, i + 51) * 120
                local rx = 30 + hash(nil, i + 52) * 60
                local ry = 6 + hash(nil, i + 53) * 10
                do
                    local k = 0
                    while k < 5 do
                        ell(
                            nil,
                            c,
                            x,
                            y,
                            rx * (1 - k * 0.15),
                            ry * (1 - k * 0.15),
                            ("rgba(236,240,244," .. tostring(0.07 + k * 0.03)) .. ")"
                        )
                        k = k + 1
                    end
                end
                i = i + 1
            end
        end
        return cv
    end
    __L1.fog = function(self, c, s, t, camL, amount)
        if __le(amount, 0.01) then
            return
        end
        if not __t(__L1.FOG) then
            __L1.FOG = __L1:buildFog()
        end
        local morning = if __t(__ge(s.h, 4.5) and __lt(s.h, 9.5)) then 1 - math.abs(s.h - 7) / 2.5 else 0
        local k = cl(nil, amount * (0.55 + morning * 0.8 + s.night * 0.25))
        c.globalAlpha = k * 0.85
        tile(nil, c, __L1.FOG, camL * 0.5 - t * 4)
        c.globalAlpha = k * 0.55
        tile(nil, c, __L1.FOG, camL * 0.8 + 300 - t * 7)
        c.globalAlpha = 1
        local g = c:createLinearGradient(0, 140, 0, 230)
        g:addColorStop(0, "rgba(230,236,240,0)")
        g:addColorStop(
            1,
            ("rgba(230,236,240," .. tostring(0.32 * k)) .. ")"
        )
        c.fillStyle = g
        c:fillRect(0, 140, LW, 90)
    end
    __L1.cityNight = function(self, c, s, img, off, dy)
        if dy == nil then
            dy = 0
        end
        local a = __L1:night(s)
        if __t(__lt(a, 0.03) or not __t(img)) then
            return
        end
        c:save()
        c:translate(0, dy)
        c.globalCompositeOperation = "lighter"
        c.globalAlpha = a
        tile(nil, c, img, off)
        tile(nil, c, img, off)
        c:restore()
    end
    __L1.passaros = function(self, c, t, camL, n, seed)
        if n == nil then
            n = 7
        end
        if seed == nil then
            seed = 0
        end
        do
            local g = 0
            while g < 2 do
                local bx = __mod(t * (12 + g * 5) + seed * 300 + g * 400 - camL * 0.1, 700) - 100
                local by = 40 + g * 26 + math.sin(t * 0.6 + g) * 6
                do
                    local i = 0
                    while i < n do
                        local x = bx - math.abs(i - n / 2) * 6
                        local y = by + math.abs(i - n / 2) * 3
                        local f = math.sin(t * 9 + i) > 0
                        R(
                            nil,
                            c,
                            x - 2,
                            y - if __t(f) then 1 else 0,
                            2,
                            1,
                            "#3a3a40"
                        )
                        R(
                            nil,
                            c,
                            x + 1,
                            y - if __t(f) then 1 else 0,
                            2,
                            1,
                            "#3a3a40"
                        )
                        R(
                            nil,
                            c,
                            x,
                            y,
                            1,
                            1,
                            "#3a3a40"
                        )
                        i = i + 1
                    end
                end
                g = g + 1
            end
        end
    end
    __L1.pipas = function(self, c, t, camL, seed)
        if seed == nil then
            seed = 0
        end
        do
            local i = 0
            while i < 3 do
                local x = __mod(
                    __mod(
                        hash(nil, i + seed) * 600 - camL * 0.3,
                        560
                    ) + 560,
                    560
                ) - 40
                local y = 30 + hash(nil, i * 3 + seed) * 50 + math.sin(t * 1.4 + i) * 5
                local col = __get(
                    __arrL({"#e8433a", "#3c9ad8", "#f2c94c"}, 3),
                    i
                )
                local sw = math.sin(t * 2 + i) * 2
                R(
                    nil,
                    c,
                    x + sw,
                    y,
                    5,
                    5,
                    col
                )
                R(
                    nil,
                    c,
                    x + 1 + sw,
                    y + 1,
                    3,
                    3,
                    __L1:shadeHex(col, 1.2)
                )
                do
                    local k = 0
                    while k < 8 do
                        R(
                            nil,
                            c,
                            x + 2 + sw + math.sin(t * 3 + k * 0.7 + i) * 2,
                            y + 5 + k * 2,
                            1,
                            1,
                            col
                        )
                        k = k + 1
                    end
                end
                do
                    local k = 0
                    while k < 40 do
                        R(
                            nil,
                            c,
                            x + 2 + k * 0.9,
                            y + 6 + k * 2.6,
                            1,
                            1,
                            "rgba(60,60,60,.45)"
                        )
                        k = k + 2
                    end
                end
                i = i + 1
            end
        end
    end
    __L1.aviao = function(self, c, s, t, camL)
        local per = 45
        local ph = __mod(t, per) / per
        if ph > 0.5 then
            return
        end
        local k = ph / 0.5
        local x = -40 + k * 560 - camL * 0.01
        local y = 36 + math.sin(k * 3) * 4
        do
            local i = 0
            while i < 40 do
                local a = (1 - i / 40) * 0.35 * (1 - s.night * 0.6)
                R(
                    nil,
                    c,
                    x - 4 - i * 3,
                    y + 1,
                    3,
                    1,
                    ("rgba(255,255,255," .. tostring(a)) .. ")"
                )
                i = i + 1
            end
        end
        R(
            nil,
            c,
            x,
            y,
            9,
            2,
            "#e8ecef"
        )
        R(
            nil,
            c,
            x + 2,
            y - 2,
            3,
            2,
            "#c8ced4"
        )
        R(
            nil,
            c,
            x + 3,
            y + 2,
            3,
            1,
            "#c8ced4"
        )
        if __t(__gt(s.night, 0.3) and math.sin(t * 8) > 0) then
            R(
                nil,
                c,
                x + 8,
                y,
                1,
                1,
                "#ff4a3a"
            )
        end
    end
    __L1.estradaLonge = function(self, c, s, t, camL)
        local y = 161
        local off = camL * 0.07
        local nt = __L1:night(s)
        R(
            nil,
            c,
            0,
            y + 2,
            LW,
            1,
            "rgba(90,96,100,.5)"
        )
        do
            local i = 0
            while i < 14 do
                local dir = if __t(__mod(i, 2)) then 1 else -1
                local x = __L1:wrap(
                    i * 73 + dir * t * (6 + __mod(i, 4) * 2) - off,
                    560
                ) - 40
                local col = __L1:pick(
                    __arrL({
                        "#c43c3a",
                        "#f2f2ee",
                        "#3c6aa8",
                        "#2a2a2a",
                        "#e8c24c"
                    }, 5),
                    i
                )
                R(
                    nil,
                    c,
                    x,
                    y,
                    4,
                    2,
                    col
                )
                if __gt(nt, 0.1) then
                    c:save()
                    c.globalCompositeOperation = "lighter"
                    c.globalAlpha = nt
                    R(
                        nil,
                        c,
                        if dir > 0 then x + 4 else x - 3,
                        y,
                        3,
                        1,
                        "#fff2b0"
                    )
                    R(
                        nil,
                        c,
                        if dir > 0 then x - 1 else x + 4,
                        y,
                        1,
                        1,
                        "#ff3a2a"
                    )
                    c:restore()
                end
                i = i + 1
            end
        end
    end
    __L1.guindastes = function(self, c, s, t, camL)
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({210, 68, 1}, 3),
                __arrL({760, 60, 2}, 3)
            },
            2
        ))) do
            local gx0 = ____value[1]
            local h = ____value[2]
            local sd = ____value[3]
            local x = __L1:wrap(gx0 - camL * 0.05) - 0
            local top = 160 - h
            local a = math.sin(t * 0.12 + sd * 2) * 0.9
            local len = 26
            if __t(x < -40 or __gt(x, LW + 40)) then
                continue
            end
            local ex = x + math.cos(a) * len
            local back = x - math.cos(a) * 10
            limb(
                nil,
                c,
                __arrL(
                    {
                        __arrL({back, top}, 2),
                        __arrL({ex, top}, 2)
                    },
                    2
                ),
                1,
                "#e8a83a"
            )
            R(
                nil,
                c,
                back - 2,
                top,
                4,
                3,
                "#8a8a86"
            )
            local hk = ex - math.sin(t * 0.9 + sd) * 2
            limb(
                nil,
                c,
                __arrL(
                    {
                        __arrL({ex - 2, top + 1}, 2),
                        __arrL({hk, top + 14}, 2)
                    },
                    2
                ),
                1,
                "#5a5a56"
            )
            R(
                nil,
                c,
                hk - 1,
                top + 14,
                3,
                2,
                "#5a5a56"
            )
        end
    end
    __L1.fumacas = function(self, c, s, t, camL)
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({120, 132}, 2),
                __arrL({430, 140}, 2),
                __arrL({690, 128}, 2)
            },
            3
        ))) do
            local x0 = ____value[1]
            local y0 = ____value[2]
            local x = __L1:wrap(x0 - camL * 0.05) - 0
            if __t(x < -20 or __gt(x, LW + 20)) then
                continue
            end
            do
                local i = 0
                while i < 6 do
                    local k = __mod(t * 0.12 + i / 6, 1)
                    R(
                        nil,
                        c,
                        x + math.sin(t * 0.5 + i) * 3 + k * 10,
                        y0 - k * 30,
                        2 + k * 5,
                        2 + k * 2,
                        ("rgba(225,228,230," .. tostring((1 - k) * 0.45)) .. ")"
                    )
                    i = i + 1
                end
            end
        end
    end
    __L1.bandeiras = function(self, c, s, t, camL)
        do
            local i = 0
            while i < 6 do
                local x = __L1:wrap(i * 161 + 40 - camL * 0.12)
                local y = 96 + __mod(i, 3) * 14
                if __gt(x, LW + 10) then
                    continue
                end
                R(
                    nil,
                    c,
                    x,
                    y,
                    1,
                    10,
                    "#6a6a66"
                )
                do
                    local k = 0
                    while k < 6 do
                        R(
                            nil,
                            c,
                            x + 1 + k,
                            y + math.floor(math.sin(t * 5 + k * 0.8 + i) * 1 + 0.5),
                            1,
                            4,
                            if __t(__mod(i, 2)) then if k < 3 then "#2c8a3a" else "#e8c24c" else if k < 2 then "#f2f2ee" else if k < 4 then "#c43c3a" else "#3c6aa8"
                        )
                        k = k + 1
                    end
                end
                i = i + 1
            end
        end
    end
    __L1.janelasPiscando = function(self, c, s, t, camL)
        local a = __L1:night(s)
        if __lt(a, 0.1) then
            return
        end
        c:save()
        c.globalCompositeOperation = "lighter"
        do
            local i = 0
            while i < 40 do
                local slot = math.floor(t / 3 + hash(nil, i) * 10)
                if __gt(
                    hash(nil, slot * 7 + i),
                    0.5
                ) then
                    continue
                end
                local x = __L1:wrap(hash(nil, i + 70) * 964 - camL * 0.12)
                local y = 110 + hash(nil, i + 71) * 58
                if __gt(x, LW) then
                    continue
                end
                R(
                    nil,
                    c,
                    x,
                    y,
                    2,
                    3,
                    ("rgba(255,214,140," .. tostring(0.8 * a)) .. ")"
                )
                i = i + 1
            end
        end
        c:restore()
    end
    __L1.antenasPiscando = function(self, c, s, t, camL)
        if math.sin(t * 2.6) < 0.2 then
            return
        end
        for ____, ax in __iterar((__arrL({590, 640, 820}, 3))) do
            local x = __L1:wrap(ax - camL * 0.02)
            if __gt(x, LW) then
                continue
            end
            R(
                nil,
                c,
                x - 1,
                108,
                3,
                3,
                ("rgba(255,70,60," .. tostring(0.5 + __L1:night(s) * 0.5)) .. ")"
            )
        end
    end
    __L1.conquistaBack = function(self, c, s, t, camL, o)
        if o == nil then
            o = {}
        end
        if not __t(__L1.FAR) then
            __L1.FAR = __L1:buildFar()
        end
        sky(
            nil,
            c,
            s,
            t,
            camL
        )
        __L1:aviao(c, s, t, camL)
        tile(nil, c, __L1.FAR.ridge, camL * 0.02)
        __L1:cityNight(c, s, __L1.FAR.nRidge, camL * 0.02)
        __L1:antenasPiscando(c, s, t, camL)
        haze(
            nil,
            c,
            s,
            t,
            camL,
            100,
            165
        )
        tile(nil, c, __L1.FAR.city, camL * 0.05)
        __L1:cityNight(c, s, __L1.FAR.nCity, camL * 0.05)
        __L1:guindastes(c, s, t, camL)
        __L1:fumacas(c, s, t, camL)
        __L1:estradaLonge(c, s, t, camL)
        if o.near ~= false then
            haze(
                nil,
                c,
                s,
                t,
                camL,
                130,
                180
            )
            tile(nil, c, __L1.FAR.near, camL * 0.12)
            __L1:cityNight(c, s, __L1.FAR.nNear, camL * 0.12)
            __L1:janelasPiscando(c, s, t, camL)
            __L1:bandeiras(c, s, t, camL)
        end
        if o.trees ~= false then
            tile(
                nil,
                c,
                __L1.FAR.trees,
                camL * 0.2 + math.sin(t * 0.8) * 1.2
            )
        end
        if o.birds ~= false then
            __L1:passaros(
                c,
                t,
                camL,
                7,
                if __t(o.seed) then o.seed else 0
            )
        end
        if __t(o.kites) then
            __L1:pipas(c, t, camL, if __t(o.seed) then o.seed else 0)
        end
        local ____opt_9 = __L1:CAM()
        if ____opt_9 ~= nil then
            ____opt_9 = ____opt_9.meio
        end
        if ____opt_9 ~= nil then
            ____opt_9(
                ____opt_9,
                __L1.CUR,
                c,
                s,
                t,
                camL
            )
        end
    end
    __L1.birdsOf = function(self, id)
        if __t(__get(__L1.BIRDS, id)) then
            return __get(__L1.BIRDS, id)
        end
        local F = __get(__L1.FIOS, id)
        local out = __arrL({}, 0)
        if not __t(F) then
            return out
        end
        do
            local i = 0
            while __lt(i, F.n) do
                do
                    local j = 0
                    while j < 3 do
                        if __lt(
                            hash(nil, i * 9 + j + id),
                            0.35
                        ) then
                            continue
                        end
                        local u = 0.2 + hash(nil, i * 3 + j * 7 + id) * 0.6
                        local px = F.x0 + i * F.step + u * F.step
                        local py = F.y0 + math.floor(math.sin(u * math.pi) * 9 + 0.5) - 1
                        __call(
                            out,
                            "push",
                            {
                                px = px,
                                py = py,
                                x = px,
                                y = py,
                                vx = 0,
                                vy = 0,
                                st = 0,
                                tm = 0,
                                col = __L1:pick(
                                    __arrL({"#3a3a40", "#5a4a3a", "#6a6f78"}, 3),
                                    i + j
                                )
                            }
                        )
                        j = j + 1
                    end
                end
                i = i + 1
            end
        end
        return __set(__L1.BIRDS, id, out)
    end
    __L1.passarinhosFio = function(self, c, id, t, camL)
        local L = __L1:birdsOf(id)
        if not __t(__len(L)) then
            return
        end
        local dt = math.max(
            0,
            math.min(0.05, t - __L1.birdT)
        )
        __L1.birdT = t
        local hx = __L1.HERO.x / 2
        local jumping = __L1.HERO.vy < -250
        for ____, b in __iterar((L)) do
            local d = math.abs(b.px - hx)
            local ____t_15 = __t
            local ____t_12 = __t
            local ____temp_11 = b.st == 0
            __O[391] = ____temp_11
            local ____t_14 = __t
            local ____temp_13 = d < 70
            __O[390] = ____temp_13
            if ____t_15(if ____t_12(____temp_11) then if ____t_14(____temp_13) then __O[390] else if __t(jumping) then d < 140 else jumping else __O[391]) then
                b.st = 1
                b.vx = if __ge(b.px, hx) then 1 else -1 * (40 + math.random() * 40)
                b.vy = -40 - math.random() * 20
                b.tm = 7 + math.random() * 6
            end
            if b.st == 1 then
                b.x = b.x + b.vx * dt
                b.y = b.y + b.vy * dt
                b.vy = b.vy - 4 * dt
                b.tm = b.tm - dt
                if __t(__le(b.tm, 0) and d > 160) then
                    b.st = 2
                end
            end
            if b.st == 2 then
                b.x = b.x + (b.px - b.x) * math.min(1, dt * 1.5)
                b.y = b.y + (b.py - b.y) * math.min(1, dt * 1.5)
                if __t(math.abs(b.x - b.px) < 1 and math.abs(b.y - b.py) < 1) then
                    b.st = 0
                    b.x = b.px
                    b.y = b.py
                end
            end
            local x = b.x - camL
            if __t(x < -10 or __gt(x, LW + 10)) then
                continue
            end
            if b.st == 0 then
                local bob = if math.sin(t * 2 + b.px) > 0.9 then 1 else 0
                R(
                    nil,
                    c,
                    x,
                    b.y - 3 + bob,
                    3,
                    3,
                    b.col
                )
                R(
                    nil,
                    c,
                    x + 2,
                    b.y - 4 + bob,
                    2,
                    2,
                    b.col
                )
                R(
                    nil,
                    c,
                    x + 3,
                    b.y - 3 + bob,
                    1,
                    1,
                    "#e8a83a"
                )
                R(
                    nil,
                    c,
                    x - 1,
                    b.y - 2,
                    1,
                    1,
                    b.col
                )
            else
                local f = math.sin(t * 18 + b.px) > 0
                R(
                    nil,
                    c,
                    x,
                    b.y,
                    3,
                    2,
                    b.col
                )
                R(
                    nil,
                    c,
                    x - 2,
                    b.y - if __t(f) then 2 else 0,
                    2,
                    1,
                    b.col
                )
                R(
                    nil,
                    c,
                    x + 3,
                    b.y - if __t(f) then 2 else 0,
                    2,
                    1,
                    b.col
                )
            end
        end
    end
    __L1.heroi = function(self, x, y, vy)
        local ____t_17 = __t
        local ____TS__Number_result_16 = __TS__Number(x)
        __O[392] = ____TS__Number_result_16
        local ____temp_22 = if ____t_17(____TS__Number_result_16) then __O[392] else -9999
        local ____t_19 = __t
        local ____TS__Number_result_18 = __TS__Number(y)
        __O[393] = ____TS__Number_result_18
        local ____temp_23 = if ____t_19(____TS__Number_result_18) then __O[393] else 440
        local ____t_21 = __t
        local ____TS__Number_result_20 = __TS__Number(vy)
        __O[394] = ____TS__Number_result_20
        __L1.HERO = {x = ____temp_22, y = ____temp_23, vy = if ____t_21(____TS__Number_result_20) then __O[394] else 0}
    end
    __L1.buildAir = function(self)
        local cv, c = table.unpack(
            mk(nil, __L1.AIR.W, LH),
            1,
            2
        )
        R(
            nil,
            c,
            0,
            0,
            __L1.AIR.TAR,
            30,
            "#d8dad6"
        )
        do
            local x = 12
            while x < __L1.AIR.TAR do
                R(
                    nil,
                    c,
                    x,
                    24,
                    28,
                    3,
                    "#fff6d8"
                )
                R(
                    nil,
                    c,
                    x,
                    27,
                    28,
                    1,
                    "#c8c4b0"
                )
                x = x + 52
            end
        end
        R(
            nil,
            c,
            0,
            30,
            __L1.AIR.TAR,
            3,
            "#9aa0a0"
        )
        __L1:plaster(
            c,
            0,
            33,
            __L1.AIR.TAR,
            177,
            "#ece8de",
            12
        )
        do
            local x = 0
            while x < __L1.AIR.TAR do
                c:clearRect(x + 14, 44, 118, 92)
                R(
                    nil,
                    c,
                    x + 12,
                    42,
                    122,
                    2,
                    "#2c4656"
                )
                R(
                    nil,
                    c,
                    x + 12,
                    136,
                    122,
                    3,
                    "#2c4656"
                )
                R(
                    nil,
                    c,
                    x + 12,
                    42,
                    2,
                    96,
                    "#2c4656"
                )
                R(
                    nil,
                    c,
                    x + 132,
                    42,
                    2,
                    96,
                    "#2c4656"
                )
                R(
                    nil,
                    c,
                    x + 72,
                    42,
                    2,
                    96,
                    "#2c4656"
                )
                R(
                    nil,
                    c,
                    x + 14,
                    44,
                    118,
                    3,
                    "rgba(200,230,240,.4)"
                )
                x = x + 150
            end
        end
        do
            local k = 0
            while k < 4 do
                local x = 40 + k * 112
                R(
                    nil,
                    c,
                    x,
                    168,
                    84,
                    42,
                    "#6f7f8c"
                )
                R(
                    nil,
                    c,
                    x,
                    168,
                    84,
                    4,
                    "#c9d2d8"
                )
                R(
                    nil,
                    c,
                    x + 4,
                    176,
                    76,
                    2,
                    "#5a6670"
                )
                R(
                    nil,
                    c,
                    x + 6,
                    148,
                    24,
                    16,
                    "#1d2a34"
                )
                R(
                    nil,
                    c,
                    x + 8,
                    150,
                    20,
                    12,
                    "#3c8ad8"
                )
                R(
                    nil,
                    c,
                    x + 10,
                    152,
                    16,
                    3,
                    "#f2efe6"
                )
                R(
                    nil,
                    c,
                    x + 17,
                    164,
                    2,
                    4,
                    "#4a5a64"
                )
                R(
                    nil,
                    c,
                    x + 46,
                    180,
                    30,
                    30,
                    "#4a5660"
                )
                R(
                    nil,
                    c,
                    x + 48,
                    182,
                    26,
                    3,
                    "#7a868e"
                )
                do
                    local j = 0
                    while j < 4 do
                        R(
                            nil,
                            c,
                            x + 50 + j * 6,
                            187,
                            4,
                            23,
                            "#3a444c"
                        )
                        j = j + 1
                    end
                end
                R(
                    nil,
                    c,
                    x + 88,
                    196,
                    12,
                    14,
                    __L1:pick(
                        __arrL({"#c43c3a", "#3c6aa8", "#e8c24c"}, 3),
                        k
                    )
                )
                R(
                    nil,
                    c,
                    x + 88,
                    196,
                    12,
                    2,
                    "#2a2a2a"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            32,
            112,
            460,
            18,
            "#1d4a7a"
        )
        R(
            nil,
            c,
            32,
            112,
            460,
            1,
            "#5a8ac0"
        )
        R(
            nil,
            c,
            36,
            116,
            10,
            10,
            "#f2c94c"
        )
        do
            local x = 28
            while x < 500 do
                R(
                    nil,
                    c,
                    x,
                    186,
                    2,
                    24,
                    "#8a8f92"
                )
                R(
                    nil,
                    c,
                    x - 1,
                    185,
                    4,
                    2,
                    "#c4c8ca"
                )
                x = x + 38
            end
        end
        do
            local x = 28
            while x < 490 do
                R(
                    nil,
                    c,
                    x,
                    191 + if __t(__mod(
                        math.floor(x / 38),
                        2
                    )) then 0 else 0,
                    2,
                    2,
                    "#c43c3a"
                )
                x = x + 2
            end
        end
        R(
            nil,
            c,
            500,
            150,
            70,
            60,
            "#c47a35"
        )
        R(
            nil,
            c,
            500,
            150,
            70,
            10,
            "#8a4a20"
        )
        R(
            nil,
            c,
            504,
            166,
            62,
            20,
            "#f2e8d0"
        )
        do
            local k = 0
            while k < 5 do
                R(
                    nil,
                    c,
                    508 + k * 12,
                    170,
                    8,
                    10,
                    __L1:pick(
                        __arrL({"#e8c24c", "#c4743a", "#f2efe6", "#7a4a2a"}, 4),
                        k
                    )
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            500,
            186,
            70,
            24,
            "#8a4a20"
        )
        ell(
            nil,
            c,
            535,
            145,
            10,
            4,
            "#f2c94c"
        )
        R(
            nil,
            c,
            582,
            186,
            10,
            24,
            "#c8ccce"
        )
        R(
            nil,
            c,
            582,
            184,
            10,
            3,
            "#e8eaea"
        )
        R(
            nil,
            c,
            585,
            190,
            4,
            2,
            "#3c8ad8"
        )
        for ____, px in __iterar((__arrL({10, 470, 600, 1020}, 4))) do
            __L1:plantaVaso(c, px, __L1.GY, px)
        end
        R(
            nil,
            c,
            340,
            50,
            60,
            70,
            "#5a3a24"
        )
        R(
            nil,
            c,
            342,
            52,
            56,
            66,
            "#c47a35"
        )
        ell(
            nil,
            c,
            370,
            80,
            14,
            20,
            "#7a4a2a"
        )
        ell(
            nil,
            c,
            370,
            80,
            10,
            16,
            "#a86a3a"
        )
        do
            local k = 0
            while k < 5 do
                R(
                    nil,
                    c,
                    364,
                    68 + k * 6,
                    12,
                    1,
                    "#5a3a20"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            346,
            106,
            48,
            8,
            "#f2e8d0"
        )
        R(
            nil,
            c,
            620,
            170,
            170,
            26,
            "#5a6670"
        )
        R(
            nil,
            c,
            620,
            196,
            170,
            4,
            "#2c3238"
        )
        do
            local k = 0
            while k < 170 do
                R(
                    nil,
                    c,
                    620 + k,
                    170,
                    3,
                    2,
                    "#3a444c"
                )
                k = k + 6
            end
        end
        R(
            nil,
            c,
            660,
            136,
            80,
            60,
            "#c4cad0"
        )
        R(
            nil,
            c,
            660,
            136,
            80,
            4,
            "#e2e6ea"
        )
        R(
            nil,
            c,
            666,
            146,
            68,
            34,
            "#1a2228"
        )
        do
            local k = 0
            while k < 6 do
                R(
                    nil,
                    c,
                    630 + k * 26,
                    162,
                    20,
                    8,
                    "#3c5a8a"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            600,
            110,
            32,
            22,
            "#1d2a34"
        )
        R(
            nil,
            c,
            602,
            112,
            28,
            18,
            "#2c4a5a"
        )
        R(
            nil,
            c,
            820,
            116,
            8,
            94,
            "#9aa4ac"
        )
        R(
            nil,
            c,
            884,
            116,
            8,
            94,
            "#9aa4ac"
        )
        R(
            nil,
            c,
            820,
            112,
            72,
            10,
            "#9aa4ac"
        )
        R(
            nil,
            c,
            828,
            120,
            56,
            2,
            "#5ae070"
        )
        R(
            nil,
            c,
            848,
            114,
            16,
            6,
            "#2a3238"
        )
        do
            local k = 0
            while k < 3 do
                do
                    local j = 0
                    while j < 5 do
                        local x = 910 + k * 44 + j * 8
                        R(
                            nil,
                            c,
                            x,
                            196,
                            7,
                            6,
                            "#3c6a9a"
                        )
                        R(
                            nil,
                            c,
                            x,
                            186,
                            7,
                            10,
                            "#4f80b0"
                        )
                        R(
                            nil,
                            c,
                            x + 1,
                            202,
                            1,
                            8,
                            "#555"
                        )
                        j = j + 1
                    end
                end
                k = k + 1
            end
        end
        R(
            nil,
            c,
            960,
            160,
            50,
            30,
            "#4a5a64"
        )
        R(
            nil,
            c,
            960,
            160,
            50,
            3,
            "#8a9aa4"
        )
        R(
            nil,
            c,
            1012,
            100,
            30,
            16,
            "#1d4a7a"
        )
        R(
            nil,
            c,
            1014,
            102,
            26,
            12,
            "#f2c94c"
        )
        __L1:pisoInterno(
            c,
            __L1.AIR.TAR,
            "#dcd8ce",
            "#c6c2b6",
            20
        )
        __L1:objetos(
            c,
            12,
            __L1.AIR.W,
            "interno",
            40,
            600,
            __arrL({90, 160}, 2)
        )
        R(
            nil,
            c,
            __L1.AIR.TAR,
            196,
            450,
            14,
            "#7f878c"
        )
        do
            local x = __L1.AIR.TAR
            while x < __L1.AIR.GR do
                R(
                    nil,
                    c,
                    x,
                    168,
                    1,
                    28,
                    "#8a949a"
                )
                x = x + 6
            end
        end
        R(
            nil,
            c,
            __L1.AIR.TAR,
            168,
            450,
            1,
            "#8a949a"
        )
        R(
            nil,
            c,
            __L1.AIR.TAR,
            182,
            450,
            1,
            "#8a949a"
        )
        R(
            nil,
            c,
            1140,
            120,
            3,
            76,
            "#9aa0a6"
        )
        R(
            nil,
            c,
            1440,
            70,
            26,
            56,
            "#e8e4dc"
        )
        R(
            nil,
            c,
            1436,
            60,
            34,
            12,
            "#2c4a5a"
        )
        R(
            nil,
            c,
            1438,
            62,
            30,
            8,
            "#7ac0d0"
        )
        R(
            nil,
            c,
            1446,
            126,
            14,
            70,
            "#d8d4cc"
        )
        do
            local k = 0
            while k < 4 do
                R(
                    nil,
                    c,
                    1240 + k * 30,
                    196,
                    26,
                    10,
                    "#3c6aa8"
                )
                R(
                    nil,
                    c,
                    1242 + k * 30,
                    190,
                    22,
                    8,
                    __L1:pick(
                        __arrL({"#c43c3a", "#e8c24c", "#4a8a5a", "#7a3a8a"}, 4),
                        k
                    )
                )
                ell(
                    nil,
                    c,
                    1246 + k * 30,
                    207,
                    3,
                    3,
                    "#1c1c1c"
                )
                ell(
                    nil,
                    c,
                    1260 + k * 30,
                    207,
                    3,
                    3,
                    "#1c1c1c"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            1214,
            192,
            26,
            14,
            "#f2c94c"
        )
        R(
            nil,
            c,
            1218,
            186,
            14,
            8,
            "#2c3a44"
        )
        do
            local x = __L1.AIR.TAR
            while x < __L1.AIR.GR do
                R(
                    nil,
                    c,
                    x,
                    220,
                    3,
                    LH - 220,
                    "#6f777c"
                )
                x = x + 3
            end
        end
        do
            local x = __L1.AIR.TAR + 20
            while x < __L1.AIR.GR do
                R(
                    nil,
                    c,
                    x,
                    240,
                    30,
                    3,
                    "#f2f2e6"
                )
                x = x + 60
            end
        end
        R(
            nil,
            c,
            __L1.AIR.TAR,
            228,
            450,
            1,
            "#e8c24c"
        )
        R(
            nil,
            c,
            __L1.AIR.GR,
            60,
            700,
            150,
            "#dfe3e4"
        )
        do
            local x = __L1.AIR.GR + 10
            while x < __L1.AIR.W - 10 do
                R(
                    nil,
                    c,
                    x,
                    74,
                    26,
                    116,
                    "#3c5f70"
                )
                R(
                    nil,
                    c,
                    x + 1,
                    75,
                    24,
                    114,
                    "#6f9cae"
                )
                R(
                    nil,
                    c,
                    x + 1,
                    75,
                    24,
                    26,
                    "#9cc4d2"
                )
                R(
                    nil,
                    c,
                    x + 4,
                    80,
                    2,
                    100,
                    "rgba(255,255,255,.35)"
                )
                R(
                    nil,
                    c,
                    x + 1,
                    150,
                    24,
                    40,
                    "#5a8496"
                )
                x = x + 28
            end
        end
        do
            local k = 0
            while k < 18 do
                local px = __L1.AIR.GR + 40 + k * 36
                R(
                    nil,
                    c,
                    px,
                    168,
                    4,
                    12,
                    "#2a3a4a"
                )
                R(
                    nil,
                    c,
                    px - 1,
                    162,
                    6,
                    6,
                    __L1:pick(
                        __arrL({"#e0b08a", "#9a6440", "#c88a60"}, 3),
                        k
                    )
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            1700,
            176,
            220,
            20,
            "#3c444a"
        )
        do
            local k = 0
            while k < 9 do
                R(
                    nil,
                    c,
                    1708 + k * 24,
                    170,
                    14,
                    8,
                    __L1:pick(
                        __arrL({"#c43c3a", "#3c6a9a", "#e8c24c", "#4a8a5a"}, 4),
                        k
                    )
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            1700,
            176,
            220,
            2,
            "#8a949a"
        )
        R(
            nil,
            c,
            1480,
            38,
            740,
            24,
            "#f8f8f4"
        )
        R(
            nil,
            c,
            1480,
            38,
            740,
            2,
            "#ffffff"
        )
        R(
            nil,
            c,
            1480,
            62,
            740,
            4,
            "#9aa4a8"
        )
        R(
            nil,
            c,
            1480,
            66,
            740,
            8,
            "rgba(60,70,80,.25)"
        )
        do
            local k = 0
            while k < 8 do
                local px = __L1.AIR.GR + 20 + k * 90
                R(
                    nil,
                    c,
                    px,
                    66,
                    6,
                    144,
                    "#8a949a"
                )
                R(
                    nil,
                    c,
                    px + 1,
                    66,
                    2,
                    144,
                    "#b4bcc0"
                )
                k = k + 1
            end
        end
        for ____, px in __iterar((__arrL({1520, 1640, 2080, 2160}, 4))) do
            R(
                nil,
                c,
                px,
                196,
                14,
                14,
                "#6a6a66"
            )
            R(
                nil,
                c,
                px + 1,
                196,
                12,
                2,
                "#8a8a86"
            )
            do
                local k = 0
                while k < 6 do
                    ell(
                        nil,
                        c,
                        px + 3 + k * 2,
                        186 - __mod(k, 2) * 6,
                        3,
                        5,
                        if __t(__mod(k, 2)) then "#4f8a3a" else "#5f9a46"
                    )
                    k = k + 1
                end
            end
        end
        __L1:pisoInterno(
            c,
            __L1.AIR.W,
            "#dcd8ce",
            "#c6c2b6",
            20
        )
        do
            local x = __L1.AIR.TAR
            while x < __L1.AIR.GR do
                R(
                    nil,
                    c,
                    x,
                    220,
                    3,
                    LH - 220,
                    "#6f777c"
                )
                x = x + 3
            end
        end
        do
            local x = __L1.AIR.TAR + 20
            while x < __L1.AIR.GR do
                R(
                    nil,
                    c,
                    x,
                    240,
                    30,
                    3,
                    "#f2f2e6"
                )
                x = x + 60
            end
        end
        return cv
    end
    __L1.aeroporto = function(self, c, s, t, camL)
        if not __t(__L1.airMid) then
            __L1.airMid = __L1:buildAir()
        end
        if not __t(__L1.FAR) then
            __L1.FAR = __L1:buildFar()
        end
        __L1:conquistaBack(
            c,
            s,
            t,
            camL,
            {near = false, trees = false}
        )
        do
            local px = __L1.AIR.TAR - 60 - camL * 0
            local ox = __TS__Number(-camL) * 0.35
            do
                local k = 0
                while k < 12 do
                    local x = __mod(
                        __mod(k * 140 + ox, 1680) + 1680,
                        1680
                    ) - 100
                    R(
                        nil,
                        c,
                        x,
                        150,
                        80,
                        50,
                        "#7f878c"
                    )
                    k = k + 1
                end
            end
            R(
                nil,
                c,
                0,
                150,
                LW,
                2,
                "#a8b0b4"
            )
            local ____ = px
            do
                local k = 0
                while k < 8 do
                    local x = __mod(
                        __mod(k * 230 - camL * 0.32, 1840) + 1840,
                        1840
                    ) - 120
                    R(
                        nil,
                        c,
                        x,
                        120,
                        2,
                        30,
                        "#6a5a3a"
                    )
                    do
                        local j = 0
                        while j < 5 do
                            limb(
                                nil,
                                c,
                                __arrL(
                                    {
                                        __arrL({x + 1, 120}, 2),
                                        __arrL(
                                            {
                                                x + 1 + (j - 2) * 6,
                                                114 + math.abs(j - 2) * 3
                                            },
                                            2
                                        )
                                    },
                                    2
                                ),
                                2,
                                "#4f8a3a"
                            )
                            j = j + 1
                        end
                    end
                    k = k + 1
                end
            end
        end
        do
            local ph = __mod(t * 0.05, 1)
            local x = -80 + ph * 640
            local y = 132 - math.max(0, ph - 0.4) * 140
            if ph < 0.9 then
                R(
                    nil,
                    c,
                    x,
                    y,
                    44,
                    7,
                    "#f2f4f6"
                )
                R(
                    nil,
                    c,
                    x + 40,
                    y + 1,
                    7,
                    5,
                    "#f2f4f6"
                )
                R(
                    nil,
                    c,
                    x - 4,
                    y - 8,
                    7,
                    10,
                    "#3c6aa8"
                )
                R(
                    nil,
                    c,
                    x + 14,
                    y + 4,
                    18,
                    3,
                    "#c9ced2"
                )
                do
                    local k = 0
                    while k < 6 do
                        R(
                            nil,
                            c,
                            x + 8 + k * 5,
                            y + 2,
                            2,
                            2,
                            "#3c4a5a"
                        )
                        k = k + 1
                    end
                end
            end
        end
        do
            local ax = 1110 - camL
            if __t(__L1:vis(ax, 420)) then
                R(
                    nil,
                    c,
                    ax,
                    118,
                    300,
                    34,
                    "#f2f4f6"
                )
                R(
                    nil,
                    c,
                    ax + 290,
                    122,
                    34,
                    26,
                    "#f2f4f6"
                )
                R(
                    nil,
                    c,
                    ax + 318,
                    128,
                    8,
                    14,
                    "#e8eaec"
                )
                R(
                    nil,
                    c,
                    ax - 22,
                    128,
                    26,
                    20,
                    "#f2f4f6"
                )
                R(
                    nil,
                    c,
                    ax - 34,
                    86,
                    28,
                    44,
                    "#3c6aa8"
                )
                R(
                    nil,
                    c,
                    ax - 30,
                    90,
                    6,
                    30,
                    "#5a8ad0"
                )
                R(
                    nil,
                    c,
                    ax + 110,
                    144,
                    130,
                    9,
                    "#c9ced2"
                )
                R(
                    nil,
                    c,
                    ax + 140,
                    152,
                    20,
                    12,
                    "#5a6670"
                )
                R(
                    nil,
                    c,
                    ax + 186,
                    152,
                    20,
                    12,
                    "#5a6670"
                )
                do
                    local k = 0
                    while k < 16 do
                        R(
                            nil,
                            c,
                            ax + 30 + k * 16,
                            126,
                            6,
                            6,
                            "#3c4a5a"
                        )
                        k = k + 1
                    end
                end
                R(
                    nil,
                    c,
                    ax,
                    140,
                    300,
                    3,
                    "#3c6aa8"
                )
                R(
                    nil,
                    c,
                    ax,
                    143,
                    300,
                    1,
                    "#f2c94c"
                )
                R(
                    nil,
                    c,
                    ax + 50,
                    132,
                    14,
                    20,
                    "#c8ced4"
                )
                do
                    local k = 0
                    while k < 9 do
                        R(
                            nil,
                            c,
                            ax + 40 + k * 3,
                            152 + k * 6,
                            14,
                            2,
                            "#9aa0a6"
                        )
                        k = k + 1
                    end
                end
                R(
                    nil,
                    c,
                    ax + 36,
                    152,
                    2,
                    58,
                    "#9aa0a6"
                )
                R(
                    nil,
                    c,
                    ax + 68,
                    152,
                    2,
                    58,
                    "#9aa0a6"
                )
                ell(
                    nil,
                    c,
                    ax + 120,
                    208,
                    5,
                    4,
                    "#1c1c1c"
                )
                ell(
                    nil,
                    c,
                    ax + 240,
                    208,
                    5,
                    4,
                    "#1c1c1c"
                )
                R(
                    nil,
                    c,
                    ax + 118,
                    196,
                    4,
                    12,
                    "#5a5a56"
                )
                R(
                    nil,
                    c,
                    ax + 238,
                    196,
                    4,
                    12,
                    "#5a5a56"
                )
            end
        end
        __L1:drawMid(
            c,
            __L1.airMid,
            camL,
            s,
            t
        )
        do
            local x = 300 - camL
            if __t(__L1:vis(x, 120)) then
                R(
                    nil,
                    c,
                    x - 4,
                    56,
                    128,
                    48,
                    "#14202a"
                )
                do
                    local k = 0
                    while k < 5 do
                        R(
                            nil,
                            c,
                            x + 2,
                            62 + k * 8,
                            56,
                            4,
                            "#f2c94c"
                        )
                        R(
                            nil,
                            c,
                            x + 62,
                            62 + k * 8,
                            30,
                            4,
                            "#c8d0d4"
                        )
                        R(
                            nil,
                            c,
                            x + 96,
                            62 + k * 8,
                            22,
                            4,
                            if __t(math.sin(t * 3 + k) > 0 or k > 1) then "#5ae070" else "#14202a"
                        )
                        k = k + 1
                    end
                end
            end
        end
        do
            local x = 666 - camL
            if __t(__L1:vis(x, 80)) then
                do
                    local k = 0
                    while k < 5 do
                        R(
                            nil,
                            c,
                            x + 6 + k * 12,
                            150 + math.floor(math.sin(t * 2 + k) * 2 + 0.5),
                            9,
                            22,
                            "#3a6a9a"
                        )
                        k = k + 1
                    end
                end
                R(
                    nil,
                    c,
                    x + 28,
                    152,
                    14,
                    10,
                    "#c8e8ff"
                )
                R(
                    nil,
                    c,
                    x + 30,
                    154,
                    3,
                    6,
                    "#ff5a4a"
                )
            end
        end
        do
            local k = 0
            while k < 6 do
                local x = __mod(k * 30 + t * 12, 180) + 620 - camL
                if __t(__L1:vis(x, 20)) then
                    R(
                        nil,
                        c,
                        x,
                        164,
                        16,
                        6,
                        __L1:pick(
                            __arrL({"#c43c3a", "#3c6aa8", "#e8c24c", "#4a8a5a"}, 4),
                            k
                        )
                    )
                end
                k = k + 1
            end
        end
        do
            local x = 1140 - camL
            if __t(__L1:vis(x, 40)) then
                local sw = math.sin(t * 2) * 2
                do
                    local k = 0
                    while k < 5 do
                        R(
                            nil,
                            c,
                            x + 3 + k * 4,
                            120 + k * 0.8 + sw * k * 0.3,
                            4,
                            5 - k * 0.6,
                            if __t(__mod(k, 2)) then "#f2f2ee" else "#f08a24"
                        )
                        k = k + 1
                    end
                end
            end
        end
        do
            local i = 0
            while i < 12 do
                local wx = 120 + i * 175 + math.sin(t * 0.3 + i) * 30
                local x = wx - camL
                local ____t_26 = __t
                local ____t_25 = __t
                local ____temp_24 = __L1:vis(x, 20)
                __O[395] = ____temp_24
                if ____t_26(if ____t_25(____temp_24) then wx < __L1.AIR.TAR or wx > __L1.AIR.GR else __O[395]) then
                    __L1:gente(c, x, __L1.GY, i)
                    R(
                        nil,
                        c,
                        x + 6,
                        __L1.GY - 8,
                        6,
                        8,
                        __L1:pick(
                            __arrL({"#c43c3a", "#2c4a6a", "#e8c24c"}, 3),
                            i
                        )
                    )
                    R(
                        nil,
                        c,
                        x + 8,
                        __L1.GY - 10,
                        2,
                        2,
                        "#2a2a2a"
                    )
                end
                i = i + 1
            end
        end
        do
            local x = 2120 - camL
            if __t(__L1:vis(x, 60)) then
                __L1:carro(
                    c,
                    x,
                    __L1.GY + 2,
                    "#e8c24c",
                    -1
                )
                R(
                    nil,
                    c,
                    x + 8,
                    __L1.GY - 16,
                    14,
                    3,
                    "#2a2a2a"
                )
            end
        end
        __L1:fog(
            c,
            s,
            t,
            camL,
            0.2
        )
    end
    __L1.aeroportoLights = function(self, g, s, t, camL)
        local a = __L1:night(s)
        do
            local x = 12
            while x < __L1.AIR.TAR do
                local sx = x + 14 - camL
                if __t(__L1:vis(sx)) then
                    lightAdd(
                        nil,
                        sx,
                        26,
                        0.3 + a * 0.4,
                        60
                    )
                end
                x = x + 52
            end
        end
        do
            local x = __L1.AIR.GR + 20
            while x < __L1.AIR.W do
                local sx = x - camL
                local ____t_29 = __t
                local ____t_28 = __t
                local ____temp_27 = __L1:vis(sx)
                __O[396] = ____temp_27
                if ____t_29(if ____t_28(____temp_27) then __gt(a, 0.05) else __O[396]) then
                    g.fillStyle = ("rgba(255,246,216," .. tostring(0.25 * a)) .. ")"
                    g:fillRect(sx - 20, 66, 40, 144)
                    lightAdd(
                        nil,
                        sx,
                        66,
                        a * 0.6,
                        70
                    )
                end
                x = x + 90
            end
        end
    end
    __L1.buildBairro = function(self)
        local cv, c = table.unpack(
            mk(nil, __L1.BAIRRO.W, LH),
            1,
            2
        )
        do
            local i = 0
            local x = 6
            while x < __L1.BAIRRO.W - 60 do
                if __t(x > __L1.BAIRRO.PEN - 70 and x < __L1.BAIRRO.PEN + 240) then
                    x = __L1.BAIRRO.PEN + 240
                    continue
                end
                if __t(x > 1110 and x < 1360) then
                    x = 1360
                    continue
                end
                local w = 62 + math.floor(hash(nil, i + 40) * 40 + 0.5)
                if __mod(i, 5) == 3 then
                    __L1:predio(
                        c,
                        x,
                        w,
                        2,
                        __L1:pick(
                            __arrL({
                                "#e9d8b4",
                                "#c9dcc8",
                                "#e8c4b4",
                                "#d4d8e8",
                                "#f0e2a8"
                            }, 5),
                            i
                        ),
                        i + 60,
                        {telhado = "#a8543c"}
                    )
                else
                    __L1:casa(
                        c,
                        x,
                        w,
                        __L1:pick(
                            __arrL({
                                "#e9d8b4",
                                "#c9dcc8",
                                "#e8c4b4",
                                "#d4d8e8",
                                "#f0e2a8",
                                "#d8c8e0"
                            }, 6),
                            i
                        ),
                        i + 40
                    )
                end
                x = x + (w + 16)
                i = i + 1
            end
        end
        local px = __L1.BAIRRO.PEN
        __L1:plaster(
            c,
            px,
            96,
            220,
            __L1.GY - 96,
            "#f2dfb0",
            77
        )
        __L1:roofTiles(
            c,
            px - 6,
            86,
            232,
            10,
            "#9a4a34"
        )
        do
            local k = 0
            while k < 6 do
                __L1:janela(
                    c,
                    px + 12 + k * 35,
                    108,
                    16,
                    18,
                    "veneziana",
                    80 + k
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            px + 4,
            128,
            212,
            3,
            "#d8c08a"
        )
        do
            local k = 0
            while k < 212 do
                R(
                    nil,
                    c,
                    px + 4 + k,
                    131,
                    1,
                    8,
                    "#3a3026"
                )
                k = k + 3
            end
        end
        R(
            nil,
            c,
            px + 4,
            131,
            212,
            1,
            "#3a3026"
        )
        do
            local k = 0
            while k < 7 do
                __L1:plantaVaso(c, px + 8 + k * 30, 140, 90 + k)
                k = k + 1
            end
        end
        R(
            nil,
            c,
            px,
            150,
            220,
            4,
            "#d8c08a"
        )
        do
            local k = 0
            while k < 3 do
                __L1:janela(
                    c,
                    px + 12 + k * 35,
                    162,
                    16,
                    18,
                    "grade",
                    100 + k
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            px + 130,
            158,
            28,
            52,
            "#6a3c24"
        )
        R(
            nil,
            c,
            px + 132,
            160,
            24,
            48,
            "#8a5a3c"
        )
        R(
            nil,
            c,
            px + 143,
            160,
            2,
            48,
            "#6a3c24"
        )
        R(
            nil,
            c,
            px + 152,
            184,
            2,
            3,
            "#e8c24c"
        )
        R(
            nil,
            c,
            px + 170,
            162,
            40,
            30,
            "#8a4a20"
        )
        R(
            nil,
            c,
            px + 172,
            164,
            36,
            26,
            "#f2e8d0"
        )
        do
            local k = 0
            while k < 4 do
                R(
                    nil,
                    c,
                    px + 175 + k * 8,
                    168,
                    6,
                    8,
                    __L1:pick(
                        __arrL({"#c43c3a", "#e8c24c", "#3c6aa8"}, 3),
                        k
                    )
                )
                k = k + 1
            end
        end
        board(
            nil,
            c,
            px + 40,
            140,
            140,
            10,
            "#f8f0d8",
            "#5a3c2a"
        )
        __L1:caixaDagua(c, px + 160, 64, 1)
        __L1:antena(c, px + 20, 86)
        __L1:parabolica(c, px + 60, 72)
        __L1:predio(
            c,
            1130,
            96,
            2,
            "#f0e6cc",
            140,
            {loja = true}
        )
        __L1:loja(
            c,
            1130,
            96,
            "#c47a35",
            "#c43c3a",
            "#f2efe6",
            141
        )
        __L1:predio(
            c,
            1240,
            110,
            2,
            "#dde8d4",
            150,
            {loja = true}
        )
        __L1:loja(
            c,
            1240,
            110,
            "#3c7a4a",
            "#3c7a4a",
            "#f2efe6",
            151
        )
        do
            local k = 0
            while k < 4 do
                R(
                    nil,
                    c,
                    1260 + k * 16,
                    __L1.GY - 10,
                    14,
                    10,
                    "#9a6a3a"
                )
                do
                    local j = 0
                    while j < 4 do
                        ell(
                            nil,
                            c,
                            1263 + k * 16 + j * 3,
                            __L1.GY - 11,
                            2,
                            2,
                            __L1:pick(
                                __arrL({"#e8c24c", "#d9634a", "#7cbf6a", "#f2a83a"}, 4),
                                k * 4 + j
                            )
                        )
                        j = j + 1
                    end
                end
                k = k + 1
            end
        end
        do
            local x = 40
            while x < __L1.BAIRRO.W do
                __L1:poste(c, x)
                x = x + 230
            end
        end
        do
            local x = 40
            while x < __L1.BAIRRO.W - 230 do
                __L1:fios(c, x + 1, x + 231, 58)
                x = x + 230
            end
        end
        __L1:orelhao(c, 1100)
        __L1:banca(c, 1500)
        __L1:ponto(c, 1700)
        __L1:placaRua(c, 720)
        __L1:lixeira(c, 1060)
        __L1:lixeira(c, 1820, "#3c8a5a")
        __L1:hidrante(c, 1580)
        __L1:plaster(
            c,
            1880,
            __L1.GY - 26,
            200,
            26,
            "#e8e2d2",
            190
        )
        __L1:grafite(
            c,
            1890,
            __L1.GY - 24,
            180,
            20,
            191
        )
        __L1:cartaz(c, 1900, __L1.GY - 44, 192)
        __L1:cartaz(c, 1916, __L1.GY - 44, 193)
        __L1:moto(c, 1020, "#c43c3a")
        __L1:bike(c, 1460, "#3c8ad8")
        __L1:cachorro(c, 1640, __L1.GY, "#c98a43")
        __L1:gato(c, 920, 96, "#d8a24a")
        __L1:bandeirinhas(
            c,
            1120,
            1360,
            70,
            3
        )
        __L1:objetos(c, 13, __L1.BAIRRO.W, "cidade")
        __L1:calcada(c, __L1.BAIRRO.W)
        __L1:asfalto(
            c,
            __L1.BAIRRO.W,
            __arrL({600, 1580}, 2)
        )
        __L1:chaoDetalhe(c, __L1.BAIRRO.W, "cidade")
        return cv
    end
    __L1.bairro = function(self, c, s, t, camL)
        if not __t(__L1.bairroMid) then
            __L1.bairroMid = __L1:buildBairro()
        end
        __L1:conquistaBack(
            c,
            s,
            t,
            camL,
            {kites = true, seed = 3}
        )
        __L1:drawMid(
            c,
            __L1.bairroMid,
            camL,
            s,
            t
        )
        __L1:passarinhosFio(c, 13, t, camL)
        local sun = sunInfo(nil, s)
        local reach = sun.lean * (12 + math.abs(sun.lean) * 26)
        local sh = ("rgba(14,24,50," .. tostring(0.22 * sun.str)) .. ")"
        for ____, x in __iterar((__arrL({
            130,
            560,
            1080,
            1430,
            1860
        }, 5))) do
            local sx = x - camL
            if __t(__L1:vis(sx, 80)) then
                if __gt(sun.str, 0.04) then
                    ell(
                        nil,
                        c,
                        sx + reach,
                        219,
                        18,
                        2.5,
                        sh
                    )
                end
                if __t(x == 560 or x == 1860) then
                    __L1:ipe(
                        c,
                        sx,
                        214,
                        if x == 560 then "#b86ac8" else "#e8c84a",
                        x
                    )
                else
                    tree(
                        nil,
                        c,
                        sx,
                        214,
                        0.8,
                        0,
                        t,
                        x
                    )
                end
            end
        end
        do
            local i = 0
            while i < 8 do
                local wx = 160 + i * 250 + math.sin(t * 0.2 + i * 2) * 60
                local sx = wx - camL
                if __t(__L1:vis(sx, 20)) then
                    __L1:gente(c, sx, 216, i)
                end
                i = i + 1
            end
        end
        if not __t(__L1:parado()) then
            local cx = __mod(t * 34, 2700) - 300 - camL
            if __t(__L1:vis(cx, 40)) then
                __L1:carro(
                    c,
                    cx,
                    242,
                    "#c43c3a",
                    1
                )
            end
            local cx2 = 2400 - __mod(t * 26, 2700) - camL
            if __t(__L1:vis(cx2, 40)) then
                __L1:carro(
                    c,
                    cx2,
                    256,
                    "#3c6aa8",
                    -1
                )
            end
        end
        do
            local x = 1170 - camL
            if __t(__L1:vis(x, 40)) then
                do
                    local i = 0
                    while i < 6 do
                        local k = __mod(t * 0.3 + i / 6, 1)
                        R(
                            nil,
                            c,
                            x + math.sin(t + i) * 3 * k,
                            150 - k * 34,
                            3 + k * 4,
                            2,
                            ("rgba(240,240,236," .. tostring((1 - k) * 0.5)) .. ")"
                        )
                        i = i + 1
                    end
                end
            end
        end
        do
            local x = 1640 - camL
            if __t(__L1:vis(x, 20)) then
                R(
                    nil,
                    c,
                    x - 3,
                    __L1.GY - 9 + math.floor(math.sin(t * 12) * 1.5 + 0.5),
                    4,
                    2,
                    "#c98a43"
                )
            end
        end
        __L1:fog(
            c,
            s,
            t,
            camL,
            0.5
        )
    end
    __L1.bairroLights = function(self, g, s, t, camL)
        local a = __L1:night(s)
        if __lt(a, 0.03) then
            return
        end
        do
            local x = 40
            while x < __L1.BAIRRO.W do
                lampGlow(
                    nil,
                    g,
                    x - camL + 14,
                    86,
                    a
                )
                x = x + 230
            end
        end
        do
            local k = 0
            while k < 6 do
                local sx = __L1.BAIRRO.PEN + 20 + k * 35 - camL
                local ____t_32 = __t
                local ____t_31 = __t
                local ____temp_30 = __L1:vis(sx)
                __O[397] = ____temp_30
                __D[1] = if ____t_32(if ____t_31(____temp_30) then __gt(
                    hash(nil, k + 9),
                    0.3
                ) else __O[397]) then
                    g.fillStyle = ("rgba(255,214,140," .. tostring(0.55 * a)) .. ")"
                    g:fillRect(sx - 6, 110, 12, 14)
                end
                k = k + 1
            end
        end
        for ____, bx in __iterar((__arrL({1130, 1240}, 2))) do
            local sx = bx + 50 - camL
            if __t(__L1:vis(sx)) then
                g.fillStyle = ("rgba(255,236,190," .. tostring(0.4 * a)) .. ")"
                g:fillRect(sx - 45, __L1.GY - 15, 90, 15)
            end
        end
    end
    __L1.cathedral = function(self, c, x)
        local wall = "#eedfb6"
        local white = "#f8f3e4"
        local sh = "#cdb98a"
        local dark = "#4f4636"
        local glass = "#5a6f86"
        local function ogive(____, gx, gy, w, h, col)
            if col == nil then
                col = glass
            end
            R(
                nil,
                c,
                gx,
                gy + 3,
                w,
                h - 3,
                white
            )
            R(
                nil,
                c,
                gx + 1,
                gy + 4,
                w - 2,
                h - 5,
                col
            )
            R(
                nil,
                c,
                gx + 1,
                gy + 2,
                w - 2,
                2,
                white
            )
            R(
                nil,
                c,
                gx + math.floor(w / 2) - 1,
                gy,
                2,
                2,
                white
            )
            R(
                nil,
                c,
                gx + math.floor(w / 2) - 1,
                gy + 2,
                2,
                2,
                col
            )
            if col == glass then
                R(
                    nil,
                    c,
                    gx + math.floor(w / 2) - 1,
                    gy + 4,
                    1,
                    h - 6,
                    white
                )
                R(
                    nil,
                    c,
                    gx + 2,
                    gy + 5,
                    1,
                    h - 8,
                    "#8aa4c0"
                )
            end
        end
        __L1:plaster(
            c,
            x + 90,
            120,
            190,
            90,
            wall,
            301
        )
        R(
            nil,
            c,
            x + 90,
            116,
            190,
            5,
            white
        )
        do
            local k = 0
            while k < 6 do
                local px = x + 100 + k * 30
                R(
                    nil,
                    c,
                    px,
                    118,
                    5,
                    92,
                    white
                )
                R(
                    nil,
                    c,
                    px + 1,
                    112,
                    3,
                    6,
                    white
                )
                ogive(
                    nil,
                    px + 11,
                    132,
                    10,
                    34
                )
                ogive(
                    nil,
                    px + 11,
                    176,
                    10,
                    22
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            x + 278,
            116,
            3,
            94,
            sh
        )
        __L1:plaster(
            c,
            x,
            110,
            92,
            100,
            wall,
            302
        )
        R(
            nil,
            c,
            x,
            108,
            92,
            3,
            white
        )
        do
            local k = 0
            while k < 14 do
                local w = 92 - 12 - k * 6.4
                if w > 2 then
                    R(
                        nil,
                        c,
                        x + 6 + k * 3.2,
                        108 - k,
                        w,
                        1,
                        if __t(__mod(k, 3)) then wall else white
                    )
                end
                k = k + 1
            end
        end
        for ____, px in __iterar((__arrL({x - 4, x + 88}, 2))) do
            R(
                nil,
                c,
                px,
                104,
                8,
                106,
                white
            )
            R(
                nil,
                c,
                px + 2,
                92,
                4,
                12,
                white
            )
            R(
                nil,
                c,
                px + 3,
                88,
                2,
                4,
                white
            )
        end
        ogive(
            nil,
            x + 34,
            150,
            24,
            60,
            "#5a3c28"
        )
        R(
            nil,
            c,
            x + 45,
            156,
            2,
            54,
            "#3c2818"
        )
        ogive(
            nil,
            x + 10,
            160,
            14,
            50,
            "#5a3c28"
        )
        ogive(
            nil,
            x + 68,
            160,
            14,
            50,
            "#5a3c28"
        )
        ogive(
            nil,
            x + 14,
            124,
            8,
            24
        )
        ogive(
            nil,
            x + 70,
            124,
            8,
            24
        )
        ogive(
            nil,
            x + 38,
            118,
            7,
            24
        )
        ogive(
            nil,
            x + 47,
            118,
            7,
            24
        )
        local tx = x + 28
        local tw = 36
        __L1:plaster(
            c,
            tx,
            40,
            tw,
            70,
            wall,
            303
        )
        R(
            nil,
            c,
            tx,
            40,
            tw,
            2,
            white
        )
        R(
            nil,
            c,
            tx - 2,
            40,
            3,
            70,
            white
        )
        R(
            nil,
            c,
            tx + tw - 1,
            40,
            3,
            70,
            white
        )
        R(
            nil,
            c,
            tx + tw - 4,
            42,
            3,
            68,
            sh
        )
        ogive(
            nil,
            tx + 9,
            82,
            8,
            22
        )
        ogive(
            nil,
            tx + 19,
            82,
            8,
            22
        )
        ogive(
            nil,
            tx + 9,
            52,
            8,
            20,
            dark
        )
        ogive(
            nil,
            tx + 19,
            52,
            8,
            20,
            dark
        )
        ell(
            nil,
            c,
            tx + 18,
            46,
            7,
            5,
            white
        )
        ell(
            nil,
            c,
            tx + 18,
            46,
            5,
            4,
            "#f4f0e2"
        )
        R(
            nil,
            c,
            tx + 18,
            43,
            1,
            3,
            dark
        )
        R(
            nil,
            c,
            tx + 18,
            46,
            3,
            1,
            dark
        )
        do
            local k = 0
            while k < 24 do
                local w = math.max(2, tw - 4 - k * 1.4)
                R(
                    nil,
                    c,
                    tx + tw / 2 - w / 2,
                    36 - k * 2.2,
                    w,
                    2.3,
                    if __mod(k, 4) == 0 then white else wall
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            tx + tw / 2 - 1,
            -24,
            2,
            10,
            "#5a5248"
        )
        R(
            nil,
            c,
            tx + tw / 2 - 4,
            -21,
            8,
            2,
            "#5a5248"
        )
        for ____, px in __iterar((__arrL({tx - 3, tx + tw - 1}, 2))) do
            R(
                nil,
                c,
                px,
                28,
                4,
                12,
                white
            )
            R(
                nil,
                c,
                px + 1,
                24,
                2,
                4,
                white
            )
        end
        R(
            nil,
            c,
            x - 20,
            198,
            320,
            2,
            "#2e2e2c"
        )
        do
            local k = 0
            while k < 320 do
                R(
                    nil,
                    c,
                    x - 20 + k,
                    198,
                    1,
                    12,
                    "#3a3a36"
                )
                R(
                    nil,
                    c,
                    x - 20 + k,
                    196,
                    1,
                    2,
                    "#3a3a36"
                )
                k = k + 4
            end
        end
        R(
            nil,
            c,
            x + 30,
            204,
            36,
            6,
            "#c9c1aa"
        )
        R(
            nil,
            c,
            x + 32,
            202,
            32,
            2,
            "#d8d0b8"
        )
    end
    __L1.buildCentro = function(self)
        local cv, c = table.unpack(
            mk(nil, __L1.CENTRO.W, LH),
            1,
            2
        )
        local x = __L1.CENTRO.CAT
        local sinal = __arrL({
            "#c43c3a",
            "#2c5a8a",
            "#3c7a4a",
            "#7a3a8a",
            "#c47a35",
            "#d84a3a",
            "#2a8a8a"
        }, 7)
        local toldo = __arrL(
            {
                __arrL({"#c43c3a", "#f2efe6"}, 2),
                __arrL({"#2c5a8a", "#f2efe6"}, 2),
                __arrL({"#e8c24c", "#3c7a4a"}, 2),
                __arrL({"#7a3a8a", "#f2efe6"}, 2),
                __arrL({"#c47a35", "#f2efe6"}, 2)
            },
            5
        )
        do
            local i = 0
            local sx = 10
            while sx < 880 do
                local w = 92 + math.floor(hash(nil, i + 400) * 30 + 0.5)
                __L1:predio(
                    c,
                    sx,
                    w,
                    3 + math.floor(hash(nil, i + 401) * 2 + 0.5),
                    __L1:pick(
                        __arrL({
                            "#e9e6dc",
                            "#ddd3bf",
                            "#e4dccb",
                            "#dfe6ea",
                            "#f0e6cc"
                        }, 5),
                        i
                    ),
                    400 + i,
                    {loja = true}
                )
                local tt = __get(
                    toldo,
                    __mod(i, 5)
                )
                __L1:loja(
                    c,
                    sx,
                    w,
                    __get(
                        sinal,
                        __mod(
                            i,
                            __len(sinal)
                        )
                    ),
                    __get(tt, 0),
                    __get(tt, 1),
                    410 + i
                )
                sx = sx + (w + 4)
                i = i + 1
            end
        end
        do
            local i = 0
            local sx = 1700
            while sx < __L1.CENTRO.W - 60 do
                local w = 92 + math.floor(hash(nil, i + 500) * 30 + 0.5)
                if i == 0 then
                    sx = sx + 180
                    continue
                end
                __L1:predio(
                    c,
                    sx,
                    w,
                    3 + math.floor(hash(nil, i + 501) * 2 + 0.5),
                    __L1:pick(
                        __arrL({"#ddd3bf", "#e9e6dc", "#cfc6b2", "#f0e6cc"}, 4),
                        i
                    ),
                    500 + i,
                    {loja = true}
                )
                local tt = __get(
                    toldo,
                    __mod(i + 2, 5)
                )
                __L1:loja(
                    c,
                    sx,
                    w,
                    __get(
                        sinal,
                        __mod(
                            i + 3,
                            __len(sinal)
                        )
                    ),
                    __get(tt, 0),
                    __get(tt, 1),
                    510 + i
                )
                sx = sx + (w + 4)
                i = i + 1
            end
        end
        __L1:plaster(
            c,
            1700,
            110,
            170,
            100,
            "#f2e8c8",
            600
        )
        __L1:roofTiles(
            c,
            1696,
            102,
            178,
            8,
            "#a8543c"
        )
        do
            local k = 0
            while k < 6 do
                __L1:janela(
                    c,
                    1710 + k * 27,
                    128,
                    14,
                    24,
                    "veneziana",
                    600 + k
                )
                R(
                    nil,
                    c,
                    1710 + k * 27,
                    168,
                    14,
                    32,
                    "#6a4a32"
                )
                R(
                    nil,
                    c,
                    1708 + k * 27,
                    166,
                    18,
                    3,
                    "#d8c8a0"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            900,
            194,
            700,
            16,
            "#5f8a46"
        )
        do
            local k = 900
            while k < 1600 do
                R(
                    nil,
                    c,
                    k,
                    192 - math.floor(hash(nil, k) * 2 + 0.5),
                    2,
                    3,
                    "#79a556"
                )
                k = k + 4
            end
        end
        do
            local k = 0
            while k < 40 do
                R(
                    nil,
                    c,
                    906 + k * 17,
                    197,
                    3,
                    3,
                    __L1:pick(
                        __arrL({"#e86a7a", "#e8c24c", "#f2efe6", "#c86ab8"}, 4),
                        k
                    )
                )
                k = k + 1
            end
        end
        __L1:cathedral(c, x)
        do
            local lx = 30
            while lx < __L1.CENTRO.W do
                __L1:poste(c, lx)
                lx = lx + 260
            end
        end
        do
            local lx = 30
            while lx < __L1.CENTRO.W - 260 do
                __L1:fios(c, lx + 1, lx + 261, 56)
                lx = lx + 260
            end
        end
        do
            local lx = 930
            while lx < 1600 do
                lampPost(nil, c, lx, 131)
                lx = lx + 110
            end
        end
        __L1:banca(c, 620)
        __L1:orelhao(c, 700)
        __L1:ponto(c, 1930)
        __L1:lixeira(c, 880)
        __L1:lixeira(c, 1620, "#3c8a5a")
        __L1:hidrante(c, 2100)
        __L1:placaRua(c, 860)
        for ____, cx in __iterar((__arrL({300, 2250}, 2))) do
            R(
                nil,
                c,
                cx,
                __L1.GY - 14,
                34,
                14,
                "#8a6a45"
            )
            R(
                nil,
                c,
                cx,
                __L1.GY - 14,
                34,
                2,
                "#c4955c"
            )
            do
                local k = 0
                while k < 8 do
                    R(
                        nil,
                        c,
                        cx + 2 + k * 4,
                        __L1.GY - 18,
                        3,
                        4,
                        __L1:pick(
                            __arrL({
                                "#d9634a",
                                "#e8c24c",
                                "#5f9fd0",
                                "#f2efe6",
                                "#2a2a2a"
                            }, 5),
                            k + cx
                        )
                    )
                    k = k + 1
                end
            end
            ell(
                nil,
                c,
                cx + 17,
                __L1.GY - 34,
                20,
                5,
                __L1:pick(
                    __arrL({"#e8433a", "#3c9ad8"}, 2),
                    cx
                )
            )
            R(
                nil,
                c,
                cx + 16,
                __L1.GY - 34,
                2,
                20,
                "#8a8a86"
            )
        end
        for ____, mx in __iterar((__arrL({560, 1990, 2010}, 3))) do
            __L1:moto(
                c,
                mx,
                __L1:pick(
                    __arrL({"#c43c3a", "#2a2a2a", "#3c6aa8"}, 3),
                    mx
                )
            )
        end
        __L1:bandeirinhas(
            c,
            930,
            1170,
            100,
            7
        )
        __L1:bandeirinhas(
            c,
            1470,
            1600,
            104,
            8
        )
        __L1:objetos(
            c,
            14,
            __L1.CENTRO.W,
            "cidade",
            30,
            880
        )
        __L1:objetos(
            c,
            14,
            __L1.CENTRO.W,
            "cidade",
            1640,
            __L1.CENTRO.W - 30
        )
        __L1:pedraPortuguesa(c, __L1.CENTRO.W, 204)
        __L1:asfalto(
            c,
            __L1.CENTRO.W,
            __arrL({880, 1660}, 2)
        )
        __L1:chaoDetalhe(c, __L1.CENTRO.W, "cidade")
        R(
            nil,
            c,
            0,
            220,
            __L1.CENTRO.W,
            1,
            "#8a8478"
        )
        do
            local fx = 860
            while fx < 920 do
                R(
                    nil,
                    c,
                    fx,
                    224,
                    3,
                    40,
                    "#e8c24c"
                )
                fx = fx + 6
            end
        end
        return cv
    end
    __L1.centro = function(self, c, s, t, camL)
        if not __t(__L1.centroMid) then
            __L1.centroMid = __L1:buildCentro()
        end
        __L1:conquistaBack(
            c,
            s,
            t,
            camL,
            {seed = 5}
        )
        __L1:drawMid(
            c,
            __L1.centroMid,
            camL,
            s,
            t
        )
        __L1:passarinhosFio(c, 14, t, camL)
        local sun = sunInfo(nil, s)
        local reach = sun.lean * (12 + math.abs(sun.lean) * 26)
        local sh = ("rgba(14,24,50," .. tostring(0.22 * sun.str)) .. ")"
        if __gt(sun.str, 0.04) then
            local cx = __L1.CENTRO.CAT - camL
            if __t(__L1:vis(cx, 300)) then
                slant(
                    nil,
                    c,
                    cx - 4,
                    cx + 282,
                    210,
                    reach * 1.6,
                    9,
                    sh
                )
                shadeAdd(nil, cx - 4 + reach, cx + 282 + reach, 1)
                sunWall(
                    nil,
                    c,
                    cx,
                    110,
                    92,
                    100,
                    sun.lean,
                    math.min(
                        1,
                        math.abs(sun.lean) * 1.4
                    ) * sun.str
                )
            end
        end
        for ____, x in __iterar((__arrL({950, 1050, 1500, 1590}, 4))) do
            local sx = x - camL
            if __t(__L1:vis(sx, 60)) then
                tree(
                    nil,
                    c,
                    sx,
                    212,
                    0.9,
                    1,
                    t,
                    x
                )
            end
        end
        for ____, x in __iterar((__arrL({1120, 1540}, 2))) do
            local sx = x - camL
            if __t(__L1:vis(sx, 60)) then
                __L1:ipe(
                    c,
                    sx,
                    212,
                    if x == 1120 then "#b86ac8" else "#e8c84a",
                    x,
                    0.9
                )
            end
        end
        for ____, x in __iterar((__arrL({990, 1440}, 2))) do
            local sx = x - camL
            if __t(__L1:vis(sx, 60)) then
                bench(
                    nil,
                    c,
                    sx,
                    212,
                    40,
                    "#8a6a45",
                    "#c4955c"
                )
            end
        end
        do
            local i = 0
            while i < 14 do
                local wx = 80 + i * 175 + math.sin(t * 0.25 + i) * 50
                local sx = wx - camL
                if __t(__L1:vis(sx, 20)) then
                    __L1:gente(c, sx, 216, i)
                end
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 9 do
                local bx = 1080 + i * 30
                local hop = math.max(
                    0,
                    math.sin(t * 3 + i * 2)
                ) * 2
                local sx = bx - camL + math.sin(t * 0.7 + i) * 3
                if __t(__L1:vis(sx, 10)) then
                    R(
                        nil,
                        c,
                        sx,
                        214 - hop,
                        4,
                        3,
                        "#8a8f98"
                    )
                    R(
                        nil,
                        c,
                        sx + 3,
                        212 - hop,
                        2,
                        2,
                        "#6a6f78"
                    )
                    R(
                        nil,
                        c,
                        sx + 3,
                        213 - hop,
                        1,
                        1,
                        "#3aa04a"
                    )
                end
                i = i + 1
            end
        end
        if not __t(__L1:parado()) then
            local bx = __mod(t * 40, 3000) - 300 - camL
            if __t(__L1:vis(bx, 60)) then
                R(
                    nil,
                    c,
                    bx,
                    228,
                    60,
                    20,
                    "#3c7aa8"
                )
                R(
                    nil,
                    c,
                    bx + 2,
                    230,
                    56,
                    7,
                    "#a9ccd8"
                )
                R(
                    nil,
                    c,
                    bx,
                    240,
                    60,
                    2,
                    "#f2efe6"
                )
                ell(
                    nil,
                    c,
                    bx + 10,
                    249,
                    4,
                    4,
                    "#1c1c1c"
                )
                ell(
                    nil,
                    c,
                    bx + 48,
                    249,
                    4,
                    4,
                    "#1c1c1c"
                )
            end
        end
        __L1:fog(
            c,
            s,
            t,
            camL,
            0.22
        )
    end
    __L1.centroLights = function(self, g, s, t, camL)
        local a = __L1:night(s)
        if __lt(a, 0.03) then
            return
        end
        do
            local x = 930
            while x < 1600 do
                lampGlow(
                    nil,
                    g,
                    x - camL,
                    130,
                    a
                )
                x = x + 110
            end
        end
        do
            local x = 30
            while x < __L1.CENTRO.W do
                lampGlow(
                    nil,
                    g,
                    x - camL + 14,
                    84,
                    a * 0.8
                )
                x = x + 260
            end
        end
        local cx = __L1.CENTRO.CAT - camL
        if __t(__L1:vis(cx, 260)) then
            local gr = g:createRadialGradient(
                cx + 70,
                160,
                10,
                cx + 70,
                160,
                170
            )
            gr:addColorStop(
                0,
                ("rgba(255,220,160," .. tostring(0.35 * a)) .. ")"
            )
            gr:addColorStop(1, "rgba(255,220,160,0)")
            g.fillStyle = gr
            g:fillRect(cx - 120, 0, 380, 220)
            lightAdd(
                nil,
                cx + 70,
                100,
                a * 0.6,
                160
            )
        end
    end
    __L1.cactus = function(self, c, x, y)
        ell(
            nil,
            c,
            x,
            y - 5,
            6,
            6,
            "#3f7a4a"
        )
        do
            local k = -4
            while k <= 4 do
                R(
                    nil,
                    c,
                    x + k,
                    y - 10,
                    1,
                    10,
                    "#2f5f38"
                )
                k = k + 2
            end
        end
        R(
            nil,
            c,
            x - 3,
            y - 13,
            7,
            3,
            "#c43c5a"
        )
        R(
            nil,
            c,
            x - 2,
            y - 14,
            5,
            1,
            "#e86a7a"
        )
        do
            local k = -3
            while k <= 3 do
                R(
                    nil,
                    c,
                    x + k,
                    y - 7,
                    1,
                    1,
                    "#f2efe6"
                )
                k = k + 3
            end
        end
    end
    __L1.rocha = function(self, c, x, y, w, h, seed)
        ell(
            nil,
            c,
            x,
            y,
            w,
            h,
            "#8a8a80"
        )
        ell(
            nil,
            c,
            x - w * 0.2,
            y - h * 0.3,
            w * 0.7,
            h * 0.55,
            "#a6a69a"
        )
        ell(
            nil,
            c,
            x + w * 0.3,
            y + h * 0.2,
            w * 0.5,
            h * 0.4,
            "#76766c"
        )
        do
            local i = 0
            while i < 6 do
                R(
                    nil,
                    c,
                    x - w * 0.6 + hash(nil, i + seed) * w * 1.2,
                    y - h * 0.3 + hash(nil, i * 3 + seed) * h * 0.8,
                    2,
                    1,
                    "#6a6a60"
                )
                i = i + 1
            end
        end
        if __gt(
            hash(nil, seed),
            0.5
        ) then
            R(
                nil,
                c,
                x - w * 0.3,
                y - h * 0.5,
                w * 0.4,
                1,
                "#5f8a46"
            )
        end
    end
    __L1.buildSerra = function(self)
        local cv, c = table.unpack(
            mk(nil, __L1.SERRA.W, LH),
            1,
            2
        )
        do
            local x = 0
            while x < __L1.SERRA.W do
                local h = 40 + math.sin(x * 0.006) * 18 + math.sin(x * 0.021) * 6 + x / __L1.SERRA.W * 34
                R(
                    nil,
                    c,
                    x,
                    __L1.GY - h,
                    1,
                    h,
                    "#86865f"
                )
                R(
                    nil,
                    c,
                    x,
                    __L1.GY - h,
                    1,
                    2,
                    "#a4a47e"
                )
                R(
                    nil,
                    c,
                    x,
                    __L1.GY - h + 2,
                    1,
                    3,
                    "#7a7a54"
                )
                x = x + 1
            end
        end
        do
            local i = 0
            while i < 2600 do
                local x = hash(nil, i + 4100) * __L1.SERRA.W
                local y = 140 + hash(nil, i + 4101) * 70
                R(
                    nil,
                    c,
                    x,
                    y,
                    2,
                    1,
                    if __t(__mod(i, 3)) then "#7a7a56" else "#95956c"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 80 do
                __L1:rocha(
                    c,
                    hash(nil, i + 600) * __L1.SERRA.W,
                    150 + hash(nil, i + 601) * 52,
                    8 + hash(nil, i + 602) * 22,
                    5 + hash(nil, i + 603) * 7,
                    i
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 200 do
                local x = hash(nil, i + 700) * __L1.SERRA.W
                local y = 158 + hash(nil, i + 701) * 50
                ell(
                    nil,
                    c,
                    x,
                    y,
                    3 + hash(nil, i) * 5,
                    3,
                    if __t(__mod(i, 2)) then "#5a7a3c" else "#6a8a44"
                )
                if __gt(
                    hash(nil, i + 702),
                    0.7
                ) then
                    R(
                        nil,
                        c,
                        x - 1,
                        y - 3,
                        2,
                        2,
                        __L1:pick(
                            __arrL({"#e8c24c", "#c86ab8", "#f2efe6"}, 3),
                            i
                        )
                    )
                end
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 40 do
                __L1:cactus(
                    c,
                    30 + hash(nil, i + 800) * (__L1.SERRA.W - 60),
                    204
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 16 do
                local x = 60 + hash(nil, i + 850) * (__L1.SERRA.W - 120)
                do
                    local k = 0
                    while k < 7 do
                        limb(
                            nil,
                            c,
                            __arrL(
                                {
                                    __arrL({x, 204}, 2),
                                    __arrL(
                                        {
                                            x + (k - 3) * 4,
                                            192 - math.abs(k - 3) * 2
                                        },
                                        2
                                    )
                                },
                                2
                            ),
                            1,
                            "#6a8a5a"
                        )
                        k = k + 1
                    end
                end
                i = i + 1
            end
        end
        for ____, x in __iterar((__arrL({520, 1340}, 2))) do
            R(
                nil,
                c,
                x,
                40,
                3,
                130,
                "#9a3a34"
            )
            do
                local k = 40
                while k < 170 do
                    R(
                        nil,
                        c,
                        x - 6,
                        k,
                        15,
                        1,
                        "#c8c8c0"
                    )
                    R(
                        nil,
                        c,
                        x - 6,
                        k,
                        1,
                        10,
                        "#c8c8c0"
                    )
                    R(
                        nil,
                        c,
                        x + 8,
                        k,
                        1,
                        10,
                        "#c8c8c0"
                    )
                    limb(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({x - 6, k}, 2),
                                __arrL({x + 8, k + 10}, 2)
                            },
                            2
                        ),
                        1,
                        "#b8b8b0"
                    )
                    k = k + 10
                end
            end
            R(
                nil,
                c,
                x,
                34,
                3,
                6,
                "#e8443a"
            )
            ell(
                nil,
                c,
                x - 6,
                60,
                5,
                3,
                "#e8e8e4"
            )
        end
        do
            local x = 0
            while x < __L1.SERRA.W do
                R(
                    nil,
                    c,
                    x,
                    205,
                    10,
                    3,
                    "#8a6a45"
                )
                x = x + 14
            end
        end
        for ____, px in __iterar((__arrL({200, 1000, 1900}, 3))) do
            R(
                nil,
                c,
                px,
                176,
                2,
                30,
                "#6a4a32"
            )
            R(
                nil,
                c,
                px - 16,
                168,
                34,
                12,
                "#6a4a32"
            )
            R(
                nil,
                c,
                px - 15,
                169,
                32,
                10,
                "#d8c49a"
            )
        end
        R(
            nil,
            c,
            2040,
            188,
            50,
            3,
            "#8a6a45"
        )
        R(
            nil,
            c,
            2042,
            191,
            2,
            13,
            "#6a4a32"
        )
        R(
            nil,
            c,
            2086,
            191,
            2,
            13,
            "#6a4a32"
        )
        do
            local k = 0
            while k < 50 do
                R(
                    nil,
                    c,
                    2040 + k,
                    180,
                    1,
                    8,
                    "#6a4a32"
                )
                k = k + 4
            end
        end
        R(
            nil,
            c,
            2040,
            180,
            50,
            1,
            "#6a4a32"
        )
        local x = __L1.SERRA.CRISTO
        local cc = "#a49c90"
        local cd = "#7f776c"
        R(
            nil,
            c,
            x - 6,
            168,
            14,
            38,
            cd
        )
        R(
            nil,
            c,
            x - 4,
            168,
            10,
            38,
            cc
        )
        ell(
            nil,
            c,
            x + 1,
            166,
            40,
            5,
            cd
        )
        ell(
            nil,
            c,
            x + 1,
            164,
            38,
            4,
            "#b8b0a4"
        )
        R(
            nil,
            c,
            x - 38,
            165,
            78,
            1,
            "#6f675c"
        )
        R(
            nil,
            c,
            x - 3,
            10,
            9,
            154,
            cd
        )
        R(
            nil,
            c,
            x - 2,
            10,
            7,
            154,
            cc
        )
        R(
            nil,
            c,
            x - 2,
            10,
            2,
            154,
            "#c4bcb0"
        )
        R(
            nil,
            c,
            x - 34,
            30,
            72,
            8,
            cd
        )
        R(
            nil,
            c,
            x - 34,
            31,
            72,
            6,
            cc
        )
        R(
            nil,
            c,
            x - 34,
            31,
            72,
            2,
            "#c4bcb0"
        )
        local fig = "#6a5a4a"
        local figL = "#9a8a76"
        ell(
            nil,
            c,
            x + 1,
            44,
            4,
            5,
            fig
        )
        R(
            nil,
            c,
            x - 2,
            49,
            7,
            30,
            fig
        )
        R(
            nil,
            c,
            x - 1,
            79,
            5,
            34,
            fig
        )
        R(
            nil,
            c,
            x - 2,
            112,
            7,
            5,
            fig
        )
        R(
            nil,
            c,
            x - 3,
            70,
            9,
            8,
            "#7a6a58"
        )
        do
            local k = 0
            while k < 15 do
                R(
                    nil,
                    c,
                    x - 32 + k * 2,
                    36 + math.floor(k * 0.6 + 0.5),
                    3,
                    4,
                    fig
                )
                R(
                    nil,
                    c,
                    x + 5 + k * 2,
                    45 - math.floor(k * 0.6 + 0.5),
                    3,
                    4,
                    fig
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            x - 1,
            50,
            1,
            28,
            figL
        )
        R(
            nil,
            c,
            x + 1,
            80,
            1,
            30,
            figL
        )
        R(
            nil,
            c,
            x - 34,
            35,
            3,
            3,
            figL
        )
        R(
            nil,
            c,
            x + 34,
            35,
            3,
            3,
            figL
        )
        for ____, hx in __iterar((__arrL({x - 130, x - 90, x + 70}, 3))) do
            __L1:plaster(
                c,
                hx,
                182,
                26,
                24,
                "#f2ece0",
                hx
            )
            __L1:roofTiles(
                c,
                hx - 2,
                176,
                30,
                6,
                "#b8644a"
            )
            R(
                nil,
                c,
                hx + 9,
                192,
                7,
                14,
                "#6a4a32"
            )
        end
        __L1:objetos(
            c,
            15,
            __L1.SERRA.W,
            "natureza",
            40,
            __L1.SERRA.W - 300,
            __arrL({80, 170}, 2)
        )
        __L1:terra(c, __L1.SERRA.W, "#7a8a4a", "#5f6e3a")
        __L1:chaoDetalhe(c, __L1.SERRA.W, "natureza")
        return cv
    end
    __L1.serra = function(self, c, s, t, camL)
        if not __t(__L1.serraMid) then
            __L1.serraMid = __L1:buildSerra()
        end
        if not __t(__L1.FAR) then
            __L1.FAR = __L1:buildFar()
        end
        sky(
            nil,
            c,
            s,
            t,
            camL
        )
        tile(nil, c, __L1.FAR.ridge, camL * 0.02)
        local ____opt_35 = __L1:CAM()
        if ____opt_35 ~= nil then
            ____opt_35 = ____opt_35.meio
        end
        if ____opt_35 ~= nil then
            ____opt_35(
                ____opt_35,
                __L1.CUR,
                c,
                s,
                t,
                camL
            )
        end
        c:save()
        c:translate(0, 22)
        tile(nil, c, __L1.FAR.city, camL * 0.05)
        c:restore()
        __L1:cityNight(
            c,
            s,
            __L1.FAR.nCity,
            camL * 0.05,
            22
        )
        c:save()
        c:translate(0, 26)
        tile(nil, c, __L1.FAR.near, camL * 0.1)
        c:restore()
        __L1:cityNight(
            c,
            s,
            __L1.FAR.nNear,
            camL * 0.1,
            26
        )
        haze(
            nil,
            c,
            s,
            t,
            camL,
            120,
            200
        )
        do
            local i = 0
            while i < 4 do
                local a = t * 0.4 + i * 1.6
                local x = 240 + math.cos(a) * (60 + i * 20) - __mod(camL * 0.15, 480)
                local y = 50 + math.sin(a) * 18 + i * 8
                R(
                    nil,
                    c,
                    x - 5,
                    y,
                    4,
                    1,
                    "#2a2622"
                )
                R(
                    nil,
                    c,
                    x + 2,
                    y,
                    4,
                    1,
                    "#2a2622"
                )
                R(
                    nil,
                    c,
                    x - 1,
                    y,
                    3,
                    2,
                    "#2a2622"
                )
                R(
                    nil,
                    c,
                    x - 6,
                    y - 1 + math.floor(math.sin(t * 2 + i) + 0.5),
                    1,
                    1,
                    "#2a2622"
                )
                i = i + 1
            end
        end
        __L1:drawMid(
            c,
            __L1.serraMid,
            camL,
            s,
            t
        )
        do
            local i = 0
            while i < 80 do
                local x = __mod(
                    __mod(i * 31 - camL, LW + 40) + LW + 40,
                    LW + 40
                ) - 20
                local sw = math.floor(math.sin(t * 4 + i) * 2 + 1 + 0.5)
                R(
                    nil,
                    c,
                    x + sw,
                    FLOOR - 7,
                    1,
                    7,
                    "#a4a46a"
                )
                R(
                    nil,
                    c,
                    x + 2 + sw,
                    FLOOR - 5,
                    1,
                    5,
                    "#8a8a52"
                )
                i = i + 1
            end
        end
        __L1:fog(
            c,
            s,
            t * 3,
            camL,
            0.55
        )
    end
    __L1.serraLights = function(self, g, s, t, camL)
        local a = __L1:night(s)
        if __lt(a, 0.03) then
            return
        end
        for ____, x in __iterar((__arrL({520, 1340}, 2))) do
            local sx = x - camL
            local ____t_39 = __t
            local ____t_38 = __t
            local ____temp_37 = __L1:vis(sx)
            __O[398] = ____temp_37
            if ____t_39(if ____t_38(____temp_37) then math.sin(t * 3) > 0 else __O[398]) then
                g.fillStyle = ("rgba(255,80,60," .. tostring(a)) .. ")"
                g:fillRect(sx - 1, 32, 5, 5)
            end
        end
        local cx = __L1.SERRA.CRISTO - camL
        if __t(__L1:vis(cx, 120)) then
            local gr = g:createRadialGradient(
                cx,
                90,
                4,
                cx,
                90,
                90
            )
            gr:addColorStop(
                0,
                ("rgba(255,236,200," .. tostring(0.35 * a)) .. ")"
            )
            gr:addColorStop(1, "rgba(255,236,200,0)")
            g.fillStyle = gr
            g:fillRect(cx - 90, 0, 180, 210)
            lightAdd(
                nil,
                cx,
                20,
                a * 0.7,
                120
            )
        end
    end
    __L1.buildAvenida = function(self)
        local cv, c = table.unpack(
            mk(nil, __L1.AVENIDA.W, LH),
            1,
            2
        )
        do
            local i = 0
            local x = 10
            while x < __L1.AVENIDA.W do
                local w = 70 + math.floor(hash(nil, i + 70) * 50 + 0.5)
                local ____t_42 = __t
                local ____t_41 = __t
                local ____temp_40 = math.abs(x + w / 2 - __L1.AVENIDA.INDIO) < 280
                __O[399] = ____temp_40
                if ____t_42(if ____t_41(____temp_40) then __O[399] else x > 280 and x < 480) then
                    x = x + (w + 30)
                    continue
                end
                __L1:predio(
                    c,
                    x,
                    w,
                    2 + math.floor(hash(nil, i + 71) * 4 + 0.5),
                    __L1:pick(
                        __arrL({
                            "#e9e6dc",
                            "#ddd3bf",
                            "#f2efe6",
                            "#cfd6dc",
                            "#e8dcc8"
                        }, 5),
                        i
                    ),
                    700 + i,
                    {loja = __gt(
                        hash(nil, i + 72),
                        0.4
                    )}
                )
                if __gt(
                    hash(nil, i + 72),
                    0.4
                ) then
                    __L1:loja(
                        c,
                        x,
                        w,
                        __L1:pick(
                            __arrL({"#c43c3a", "#2c5a8a", "#3c7a4a", "#c47a35"}, 4),
                            i
                        ),
                        __L1:pick(
                            __arrL({"#c43c3a", "#2c5a8a", "#e8c24c"}, 3),
                            i + 1
                        ),
                        "#f2efe6",
                        710 + i
                    )
                end
                x = x + (w + 20)
                i = i + 1
            end
        end
        R(
            nil,
            c,
            296,
            116,
            168,
            10,
            "#c43c3a"
        )
        R(
            nil,
            c,
            296,
            126,
            168,
            4,
            "#f2efe6"
        )
        for ____, k in __iterar((__arrL({306, 450}, 2))) do
            R(
                nil,
                c,
                k,
                130,
                6,
                80,
                "#9aa0a6"
            )
        end
        do
            local k = 0
            while k < 3 do
                R(
                    nil,
                    c,
                    340 + k * 34,
                    176,
                    16,
                    34,
                    "#e8e4dc"
                )
                R(
                    nil,
                    c,
                    342 + k * 34,
                    180,
                    12,
                    8,
                    "#2c3a44"
                )
                R(
                    nil,
                    c,
                    344 + k * 34,
                    182,
                    8,
                    3,
                    "#5ae070"
                )
                limb(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({356 + k * 34, 190}, 2),
                            __arrL({362 + k * 34, 200}, 2)
                        },
                        2
                    ),
                    1,
                    "#2a2a2a"
                )
                k = k + 1
            end
        end
        do
            local k = 0
            while k < 4 do
                do
                    local j = 0
                    while j < 3 - __mod(k, 2) do
                        ell(
                            nil,
                            c,
                            2600 + k * 14,
                            __L1.GY - 4 - j * 7,
                            6,
                            4,
                            "#1e1e1e"
                        )
                        ell(
                            nil,
                            c,
                            2600 + k * 14,
                            __L1.GY - 4 - j * 7,
                            3,
                            2,
                            "#3a3a3a"
                        )
                        j = j + 1
                    end
                end
                k = k + 1
            end
        end
        R(
            nil,
            c,
            2580,
            __L1.GY - 46,
            70,
            10,
            "#e8c24c"
        )
        R(
            nil,
            c,
            2582,
            __L1.GY - 44,
            66,
            6,
            "#2a2a2a"
        )
        do
            local k = 0
            while k < 4 do
                __L1:moto(
                    c,
                    820 + k * 22,
                    __L1:pick(
                        __arrL({"#c43c3a", "#f08a24", "#2a2a2a", "#3c6aa8"}, 4),
                        k
                    )
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            810,
            __L1.GY - 40,
            2,
            40,
            "#5a5e62"
        )
        R(
            nil,
            c,
            800,
            __L1.GY - 50,
            50,
            10,
            "#f08a24"
        )
        for ____, bx in __iterar((__arrL({620, 2140}, 2))) do
            R(
                nil,
                c,
                bx,
                56,
                120,
                54,
                "#2a2f34"
            )
            R(
                nil,
                c,
                bx + 3,
                59,
                114,
                48,
                if bx == 620 then "#e8c24c" else "#5f9fd0"
            )
            R(
                nil,
                c,
                bx + 50,
                110,
                4,
                100,
                "#5a5e62"
            )
            R(
                nil,
                c,
                bx + 66,
                110,
                4,
                100,
                "#5a5e62"
            )
        end
        R(
            nil,
            c,
            1990,
            92,
            120,
            8,
            "#9aa0a6"
        )
        R(
            nil,
            c,
            1990,
            90,
            120,
            2,
            "#c8ccce"
        )
        do
            local k = 0
            while k < 120 do
                R(
                    nil,
                    c,
                    1990 + k,
                    82,
                    1,
                    8,
                    "#7a7e80"
                )
                k = k + 4
            end
        end
        R(
            nil,
            c,
            1990,
            82,
            120,
            1,
            "#7a7e80"
        )
        R(
            nil,
            c,
            2000,
            100,
            6,
            110,
            "#8a8e90"
        )
        R(
            nil,
            c,
            2094,
            100,
            6,
            110,
            "#8a8e90"
        )
        local x = __L1.AVENIDA.INDIO
        ell(
            nil,
            c,
            x,
            204,
            130,
            9,
            "#4a7238"
        )
        ell(
            nil,
            c,
            x,
            202,
            126,
            8,
            "#5f8a46"
        )
        do
            local k = 0
            while k < 26 do
                R(
                    nil,
                    c,
                    x - 110 + k * 9,
                    198,
                    3,
                    3,
                    __L1:pick(
                        __arrL({"#e86a7a", "#e8c24c", "#f2efe6", "#c86ab8"}, 4),
                        k
                    )
                )
                k = k + 1
            end
        end
        __L1:brick(
            c,
            x - 24,
            146,
            48,
            54,
            "#8a8478",
            1500
        )
        R(
            nil,
            c,
            x - 24,
            146,
            48,
            3,
            "#b0aa9c"
        )
        R(
            nil,
            c,
            x - 28,
            196,
            56,
            6,
            "#6f6a60"
        )
        R(
            nil,
            c,
            x - 10,
            168,
            20,
            10,
            "#c9a24a"
        )
        R(
            nil,
            c,
            x - 8,
            170,
            16,
            6,
            "#e8d08a"
        )
        local b = "#5e4128"
        local bm = "#7a5634"
        local bh = "#a7804c"
        R(
            nil,
            c,
            x - 5,
            66,
            11,
            12,
            b
        )
        R(
            nil,
            c,
            x - 4,
            66,
            4,
            12,
            bm
        )
        R(
            nil,
            c,
            x - 1,
            70,
            2,
            2,
            "#3a2818"
        )
        do
            local k = 0
            while k < 7 do
                local a = -1.3 + k * 0.43
                local fx = x + math.cos(a) * 9
                local fy = 66 + math.sin(a) * 9
                R(
                    nil,
                    c,
                    fx - 1,
                    fy - 5,
                    3,
                    7,
                    __get(
                        __arrL({"#c9a24a", "#b8443a", "#3c7a4a"}, 3),
                        __mod(k, 3)
                    )
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            x - 8,
            64,
            17,
            3,
            "#8a4a2a"
        )
        R(
            nil,
            c,
            x - 3,
            78,
            7,
            4,
            b
        )
        R(
            nil,
            c,
            x - 11,
            82,
            23,
            8,
            b
        )
        R(
            nil,
            c,
            x - 11,
            82,
            23,
            2,
            bh
        )
        R(
            nil,
            c,
            x - 8,
            90,
            17,
            18,
            b
        )
        R(
            nil,
            c,
            x - 8,
            90,
            5,
            18,
            bm
        )
        R(
            nil,
            c,
            x - 2,
            92,
            1,
            12,
            "#4a3220"
        )
        R(
            nil,
            c,
            x - 9,
            106,
            19,
            7,
            "#8a6a3c"
        )
        do
            local k = 0
            while k < 5 do
                R(
                    nil,
                    c,
                    x - 8 + k * 4,
                    113,
                    3,
                    6,
                    "#7a5a34"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            x - 7,
            113,
            6,
            31,
            b
        )
        R(
            nil,
            c,
            x - 7,
            113,
            2,
            31,
            bm
        )
        R(
            nil,
            c,
            x + 2,
            113,
            6,
            31,
            b
        )
        R(
            nil,
            c,
            x + 6,
            113,
            2,
            31,
            "#4a3220"
        )
        R(
            nil,
            c,
            x - 9,
            142,
            9,
            4,
            b
        )
        R(
            nil,
            c,
            x + 1,
            142,
            9,
            4,
            b
        )
        limb(
            nil,
            c,
            __arrL(
                {
                    __arrL({x - 10, 84}, 2),
                    __arrL({x - 18, 92}, 2),
                    __arrL({x - 22, 86}, 2)
                },
                3
            ),
            4,
            b
        )
        limb(
            nil,
            c,
            __arrL(
                {
                    __arrL({x + 11, 84}, 2),
                    __arrL({x + 22, 86}, 2),
                    __arrL({x + 30, 84}, 2)
                },
                3
            ),
            4,
            b
        )
        do
            local k = 0
            while k <= 40 do
                local yy = 62 + k * 1.1
                local xx = x + 32 + math.floor(math.sin(k / 40 * math.pi) * 7 + 0.5)
                R(
                    nil,
                    c,
                    xx,
                    yy,
                    2,
                    2,
                    "#4a3220"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            x + 32,
            62,
            1,
            46,
            "#d8c8a0"
        )
        limb(
            nil,
            c,
            __arrL(
                {
                    __arrL({x - 22, 86}, 2),
                    __arrL({x + 34, 84}, 2)
                },
                2
            ),
            1,
            "#c8a46a"
        )
        R(
            nil,
            c,
            x + 33,
            83,
            4,
            3,
            "#9a9a9a"
        )
        R(
            nil,
            c,
            x - 11,
            82,
            1,
            8,
            bh
        )
        R(
            nil,
            c,
            x - 6,
            92,
            1,
            14,
            bh
        )
        R(
            nil,
            c,
            x - 5,
            115,
            1,
            26,
            bh
        )
        do
            local lx = 150
            while lx < __L1.AVENIDA.W do
                lampPost(nil, c, lx, 104)
                lx = lx + 300
            end
        end
        __L1:ponto(c, 1160)
        __L1:banca(c, 1830)
        __L1:orelhao(c, 1100)
        __L1:lixeira(c, 1220)
        __L1:lixeira(c, 1880, "#3c8a5a")
        __L1:hidrante(c, 2400)
        __L1:placaRua(c, 1050)
        __L1:bike(c, 2300, "#c43c3a")
        __L1:objetos(
            c,
            16,
            __L1.AVENIDA.W,
            "cidade",
            30,
            1300
        )
        __L1:objetos(
            c,
            16,
            __L1.AVENIDA.W,
            "cidade",
            1700,
            __L1.AVENIDA.W - 30
        )
        __L1:calcada(c, __L1.AVENIDA.W)
        __L1:asfalto(
            c,
            __L1.AVENIDA.W,
            __arrL({1340, 1640}, 2)
        )
        __L1:chaoDetalhe(c, __L1.AVENIDA.W, "cidade")
        return cv
    end
    __L1.avenida = function(self, c, s, t, camL)
        if not __t(__L1.aveMid) then
            __L1.aveMid = __L1:buildAvenida()
        end
        __L1:conquistaBack(
            c,
            s,
            t,
            camL,
            {seed = 9}
        )
        R(
            nil,
            c,
            0,
            184,
            LW,
            20,
            "#5d6164"
        )
        R(
            nil,
            c,
            0,
            193,
            LW,
            1,
            "#e8dc8a"
        )
        R(
            nil,
            c,
            0,
            184,
            LW,
            1,
            "#7a7e80"
        )
        do
            local i = 0
            while i < 11 do
                local dir = if __t(__mod(i, 2)) then 1 else -1
                local sp = 40 + __mod(i, 3) * 18
                local wx = __mod(
                    __mod(i * 337 + t * sp * dir, 3300) + 3300,
                    3300
                ) - 150
                local sx = wx - camL * 0.9
                if not __t(__L1:vis(sx, 60)) then
                    continue
                end
                if __mod(i, 4) == 3 then
                    R(
                        nil,
                        c,
                        sx,
                        172,
                        56,
                        18,
                        "#3c7aa8"
                    )
                    R(
                        nil,
                        c,
                        sx + 2,
                        174,
                        52,
                        6,
                        "#a9ccd8"
                    )
                    R(
                        nil,
                        c,
                        sx,
                        184,
                        56,
                        2,
                        "#f2efe6"
                    )
                    ell(
                        nil,
                        c,
                        sx + 8,
                        192,
                        3,
                        3,
                        "#1c1c1c"
                    )
                    ell(
                        nil,
                        c,
                        sx + 46,
                        192,
                        3,
                        3,
                        "#1c1c1c"
                    )
                elseif __mod(i, 3) == 2 then
                    ell(
                        nil,
                        c,
                        sx + 2,
                        191,
                        3,
                        3,
                        "#1c1c1c"
                    )
                    ell(
                        nil,
                        c,
                        sx + 12,
                        191,
                        3,
                        3,
                        "#1c1c1c"
                    )
                    R(
                        nil,
                        c,
                        sx + 2,
                        185,
                        11,
                        4,
                        __L1:pick(
                            __arrL({"#c43c3a", "#f08a24"}, 2),
                            i
                        )
                    )
                    R(
                        nil,
                        c,
                        sx + 5,
                        178,
                        5,
                        7,
                        __L1:pick(
                            __arrL({"#c43c3a", "#f08a24"}, 2),
                            i
                        )
                    )
                    R(
                        nil,
                        c,
                        sx + 5,
                        175,
                        5,
                        3,
                        "#c43c3a"
                    )
                else
                    __L1:carro(
                        c,
                        sx,
                        if dir > 0 then 192 else 200,
                        __L1:pick(
                            __arrL({
                                "#c43c3a",
                                "#f2f2ee",
                                "#3c6aa8",
                                "#2a2a2a",
                                "#9aa0a6",
                                "#e8c24c"
                            }, 6),
                            i
                        ),
                        dir
                    )
                end
                i = i + 1
            end
        end
        __L1:drawMid(
            c,
            __L1.aveMid,
            camL,
            s,
            t
        )
        for ____, x in __iterar((__arrL({600, 1200, 1800, 2400}, 4))) do
            local sx = x - camL
            if __t(__L1:vis(sx, 20)) then
                R(
                    nil,
                    c,
                    sx,
                    118,
                    3,
                    92,
                    "#3c4044"
                )
                R(
                    nil,
                    c,
                    sx - 3,
                    110,
                    9,
                    22,
                    "#2a2e30"
                )
                local ph = __mod(
                    math.floor((t + x) / 4),
                    3
                )
                __call(
                    __arrL({"#d8443a", "#e8c24c", "#4ac07a"}, 3),
                    "forEach",
                    function(____, col, k) return R(
                        nil,
                        c,
                        sx - 1,
                        112 + k * 6,
                        5,
                        4,
                        if ph == k then col else "#3a3a3a"
                    ) end
                )
            end
        end
        for ____, x in __iterar((__arrL({1360, 1640}, 2))) do
            local sx = x - camL
            if __t(__L1:vis(sx, 60)) then
                tree(
                    nil,
                    c,
                    sx,
                    204,
                    0.75,
                    1,
                    t,
                    x
                )
            end
        end
        for ____, x in __iterar((__arrL({700, 2250}, 2))) do
            local sx = x - camL
            if __t(__L1:vis(sx, 60)) then
                __L1:ipe(
                    c,
                    sx,
                    210,
                    if x == 700 then "#e8c84a" else "#b86ac8",
                    x,
                    0.85
                )
            end
        end
        do
            local i = 0
            while i < 10 do
                local wx = 100 + i * 290 + math.sin(t * 0.3 + i) * 40
                local sx = wx - camL
                if __t(__L1:vis(sx, 20)) then
                    __L1:gente(c, sx, 216, i)
                end
                i = i + 1
            end
        end
        do
            local i = 0
            while i < if __t(__L1:parado()) then 0 else 4 do
                local dir = if __t(__mod(i, 2)) then 1 else -1
                local wx = __mod(
                    __mod(i * 777 + t * (70 + i * 10) * dir, 3400) + 3400,
                    3400
                ) - 200
                local sx = wx - camL
                if __t(__L1:vis(sx, 40)) then
                    __L1:carro(
                        c,
                        sx,
                        if dir > 0 then 240 else 258,
                        __L1:pick(
                            __arrL({"#f2f2ee", "#2a2a2a", "#c43c3a", "#3c8a5a"}, 4),
                            i + 2
                        ),
                        dir
                    )
                end
                i = i + 1
            end
        end
        __L1:fog(
            c,
            s,
            t,
            camL,
            0.18
        )
    end
    __L1.avenidaLights = function(self, g, s, t, camL)
        local a = __L1:night(s)
        if __lt(a, 0.03) then
            return
        end
        do
            local x = 150
            while x < __L1.AVENIDA.W do
                lampGlow(
                    nil,
                    g,
                    x - camL + 1,
                    100,
                    a,
                    "255,210,150",
                    80
                )
                x = x + 300
            end
        end
        local ix = __L1.AVENIDA.INDIO - camL
        if __t(__L1:vis(ix, 120)) then
            local gr = g:createLinearGradient(0, 200, 0, 50)
            gr:addColorStop(
                0,
                ("rgba(255,220,150," .. tostring(0.4 * a)) .. ")"
            )
            gr:addColorStop(1, "rgba(255,220,150,0)")
            g.fillStyle = gr
            g:fillRect(ix - 30, 50, 60, 150)
        end
        for ____, bx in __iterar((__arrL({620, 2140}, 2))) do
            local sx = bx - camL
            if __t(__L1:vis(sx, 130)) then
                g.fillStyle = ("rgba(255,250,230," .. tostring(0.3 * a)) .. ")"
                g:fillRect(sx + 3, 59, 114, 48)
            end
        end
    end
    __L1.barraca = function(self, c, x, w, tarp, goods, seed)
        R(
            nil,
            c,
            x,
            116,
            2,
            94,
            "#6a5a44"
        )
        R(
            nil,
            c,
            __add(x, w) - 2,
            116,
            2,
            94,
            "#6a5a44"
        )
        do
            local k = 0
            while __lt(k, w) do
                local yy = 110 + math.floor(math.sin(k / w * math.pi) * -6 + 0.5)
                R(
                    nil,
                    c,
                    x + k,
                    yy,
                    1,
                    11,
                    tarp
                )
                if __mod(k, 6) < 3 then
                    R(
                        nil,
                        c,
                        x + k,
                        yy + 9,
                        1,
                        2,
                        __L1:shadeHex(tarp, 0.75)
                    )
                end
                k = k + 1
            end
        end
        R(
            nil,
            c,
            x,
            121,
            w,
            2,
            __L1:shadeHex(tarp, 0.65)
        )
        do
            local k = 0
            while k < w - 8 do
                limb(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x + 4 + k, 123}, 2),
                            __arrL({x + 4 + k, 128}, 2)
                        },
                        2
                    ),
                    1,
                    "#5a4a34"
                )
                if __gt(
                    hash(nil, k + seed),
                    0.5
                ) then
                    ell(
                        nil,
                        c,
                        x + 4 + k,
                        132,
                        3,
                        4,
                        __L1:pick(
                            __arrL({"#e8c24c", "#7cbf6a", "#d9634a"}, 3),
                            k + seed
                        )
                    )
                end
                k = k + 6
            end
        end
        R(
            nil,
            c,
            x + 2,
            166,
            w - 4,
            10,
            "#8a6a45"
        )
        R(
            nil,
            c,
            x + 2,
            166,
            w - 4,
            2,
            "#c4955c"
        )
        R(
            nil,
            c,
            x + 4,
            176,
            w - 8,
            34,
            "#6a4a32"
        )
        do
            local k = 0
            while k < w - 8 do
                R(
                    nil,
                    c,
                    x + 4 + k,
                    176,
                    1,
                    34,
                    "#5a3a22"
                )
                k = k + 8
            end
        end
        do
            local k = 0
            while k < (w - 8) / 7 do
                local gx = x + 6 + k * 7
                local g = __get(
                    goods,
                    __mod(
                        k + seed,
                        __len(goods)
                    )
                )
                ell(
                    nil,
                    c,
                    gx + 3,
                    162,
                    3.5,
                    3,
                    g
                )
                ell(
                    nil,
                    c,
                    gx + 3,
                    158,
                    2.5,
                    2,
                    g
                )
                R(
                    nil,
                    c,
                    gx + 2,
                    157,
                    2,
                    1,
                    "#ffffff66"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            x + 8,
            146,
            18,
            10,
            "#f2ece0"
        )
        R(
            nil,
            c,
            x + 10,
            149,
            12,
            1,
            "#c43c3a"
        )
        R(
            nil,
            c,
            x + 10,
            152,
            8,
            1,
            "#2a2a2a"
        )
        R(
            nil,
            c,
            __add(x, w) - 20,
            150,
            12,
            3,
            "#c8c8c4"
        )
        R(
            nil,
            c,
            __add(x, w) - 15,
            153,
            2,
            10,
            "#8a8a86"
        )
        R(
            nil,
            c,
            __add(x, w) - 18,
            163,
            8,
            3,
            "#8a8a86"
        )
        do
            local k = 0
            while k < 2 do
                R(
                    nil,
                    c,
                    x + 6 + k * 18,
                    __L1.GY - 12,
                    14,
                    12,
                    "#a87a48"
                )
                R(
                    nil,
                    c,
                    x + 6 + k * 18,
                    __L1.GY - 12,
                    14,
                    2,
                    "#c4955c"
                )
                do
                    local j = 0
                    while j < 3 do
                        ell(
                            nil,
                            c,
                            x + 9 + k * 18 + j * 4,
                            __L1.GY - 13,
                            2,
                            2,
                            __get(
                                goods,
                                __mod(
                                    j + k + seed,
                                    __len(goods)
                                )
                            )
                        )
                        j = j + 1
                    end
                end
                k = k + 1
            end
        end
    end
    __L1.buildFeira = function(self)
        local cv, c = table.unpack(
            mk(nil, __L1.FEIRA.W, LH),
            1,
            2
        )
        do
            local i = 0
            local x = 6
            while x < __L1.FEIRA.W do
                local w = 120 + math.floor(hash(nil, i + 900) * 40 + 0.5)
                __L1:predio(
                    c,
                    x,
                    w,
                    2 + math.floor(hash(nil, i + 901) * 2 + 0.5),
                    __L1:pick(
                        __arrL({"#ece4cf", "#dde4d4", "#f2e4d8", "#e4dccb"}, 4),
                        i
                    ),
                    900 + i
                )
                x = x + (w + 8)
                i = i + 1
            end
        end
        for ____, bx in __iterar((__L1.FEIRA.BISC)) do
            __L1:predio(
                c,
                bx,
                120,
                3,
                "#f6ecd0",
                bx,
                {loja = true}
            )
            __L1:loja(
                c,
                bx,
                120,
                "#c47a35",
                "#c47a35",
                "#f6ecd0",
                bx + 1
            )
            do
                local k = 0
                while k < 6 do
                    R(
                        nil,
                        c,
                        bx + 12 + k * 17,
                        __L1.GY - 26,
                        12,
                        16,
                        "#e8e4dc"
                    )
                    R(
                        nil,
                        c,
                        bx + 13 + k * 17,
                        __L1.GY - 22,
                        10,
                        11,
                        "#f2dfa8"
                    )
                    do
                        local j = 0
                        while j < 3 do
                            R(
                                nil,
                                c,
                                bx + 14 + k * 17 + j * 3,
                                __L1.GY - 20 + j * 3,
                                3,
                                2,
                                "#fff3cf"
                            )
                            j = j + 1
                        end
                    end
                    R(
                        nil,
                        c,
                        bx + 12 + k * 17,
                        __L1.GY - 27,
                        12,
                        2,
                        "#c43c3a"
                    )
                    k = k + 1
                end
            end
            R(
                nil,
                c,
                bx + 100,
                __L1.GY - 50,
                16,
                16,
                "#8a4a20"
            )
            ell(
                nil,
                c,
                bx + 108,
                __L1.GY - 42,
                5,
                5,
                "#ffb04a"
            )
        end
        local tarps = __arrL({
            "#3c6aa8",
            "#e8833a",
            "#e8c24c",
            "#3c8a5a",
            "#c43c3a",
            "#7a3a8a"
        }, 6)
        local goods = __arrL(
            {
                __arrL({"#e8c24c", "#7cbf6a", "#d9634a"}, 3),
                __arrL({"#f2a83a", "#e8d84c"}, 2),
                __arrL({"#7a3a2a", "#c49a6a", "#f2ece0"}, 3),
                __arrL({"#d9634a", "#3c8a3a"}, 2),
                __arrL({"#f2efe6", "#e8c24c", "#c49a6a"}, 3)
            },
            5
        )
        do
            local i = 0
            local x = 16
            while x < __L1.FEIRA.W - 60 do
                if __t(__call(
                    __L1.FEIRA.BISC,
                    "some",
                    function(____, b) return x > b - 74 and x < b + 124 end
                )) then
                    continue
                end
                __L1:barraca(
                    c,
                    x,
                    82,
                    __get(
                        tarps,
                        __mod(
                            i,
                            __len(tarps)
                        )
                    ),
                    __get(
                        goods,
                        __mod(
                            i,
                            __len(goods)
                        )
                    ),
                    i
                )
                do
                    i = i + 1
                    x = x + 92
                end
            end
        end
        for ____, gx in __iterar((__arrL({700, 1660}, 2))) do
            R(
                nil,
                c,
                gx,
                __L1.GY - 18,
                26,
                18,
                "#8a6a45"
            )
            do
                local k = 0
                while k < 26 do
                    R(
                        nil,
                        c,
                        gx + k,
                        __L1.GY - 18,
                        1,
                        18,
                        "#5a4a34"
                    )
                    k = k + 3
                end
            end
            do
                local k = 0
                while k < 3 do
                    R(
                        nil,
                        c,
                        gx + 3 + k * 8,
                        __L1.GY - 10,
                        5,
                        5,
                        "#f2efe6"
                    )
                    R(
                        nil,
                        c,
                        gx + 6 + k * 8,
                        __L1.GY - 12,
                        2,
                        2,
                        "#c43c3a"
                    )
                    k = k + 1
                end
            end
        end
        do
            local k = 0
            while k < 5 do
                local sx = 1100 + k * 12
                R(
                    nil,
                    c,
                    sx,
                    __L1.GY - 14,
                    11,
                    14,
                    "#d8c8a0"
                )
                R(
                    nil,
                    c,
                    sx + 1,
                    __L1.GY - 16,
                    9,
                    3,
                    "#c4b48c"
                )
                R(
                    nil,
                    c,
                    sx + 3,
                    __L1.GY - 8,
                    5,
                    2,
                    "#8a6a3a"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            1500,
            __L1.GY - 10,
            22,
            8,
            "#5a6a72"
        )
        ell(
            nil,
            c,
            1520,
            __L1.GY - 2,
            3,
            3,
            "#1c1c1c"
        )
        limb(
            nil,
            c,
            __arrL(
                {
                    __arrL({1500, __L1.GY - 8}, 2),
                    __arrL({1490, __L1.GY - 16}, 2)
                },
                2
            ),
            1,
            "#5a4a34"
        )
        __L1:gato(c, 1180, __L1.GY - 14, "#d8a24a")
        do
            local k = 0
            while k < 6 do
                __L1:bandeirinhas(
                    c,
                    20 + k * 360,
                    360 + k * 360,
                    96,
                    k
                )
                k = k + 1
            end
        end
        do
            local lx = 60
            while lx < __L1.FEIRA.W do
                __L1:poste(c, lx)
                lx = lx + 300
            end
        end
        __L1:pedraPortuguesa(c, __L1.FEIRA.W, 210)
        R(
            nil,
            c,
            0,
            210,
            __L1.FEIRA.W,
            2,
            "#c8c2b0"
        )
        __L1:chaoDetalhe(c, __L1.FEIRA.W, "cidade")
        return cv
    end
    __L1.feira = function(self, c, s, t, camL)
        if not __t(__L1.feiraMid) then
            __L1.feiraMid = __L1:buildFeira()
        end
        __L1:conquistaBack(
            c,
            s,
            t,
            camL,
            {seed = 11}
        )
        __L1:drawMid(
            c,
            __L1.feiraMid,
            camL,
            s,
            t
        )
        do
            local i = 0
            while i < 20 do
                local wx = 40 + i * 110 + math.sin(t * 0.4 + i * 1.7) * 40
                local sx = wx - camL
                if __t(__L1:vis(sx, 20)) then
                    __L1:gente(c, sx, 214, i)
                    if __mod(i, 3) == 0 then
                        R(
                            nil,
                            c,
                            sx + 6,
                            204,
                            5,
                            6,
                            "#f2efe6"
                        )
                        R(
                            nil,
                            c,
                            sx + 7,
                            205,
                            3,
                            2,
                            "#7cbf6a"
                        )
                    end
                end
                i = i + 1
            end
        end
        for ____, bx in __iterar((__L1.FEIRA.BISC)) do
            local x = bx + 108 - camL
            if not __t(__L1:vis(x, 80)) then
                continue
            end
            do
                local i = 0
                while i < 6 do
                    local k = __mod(t * 0.25 + i / 6, 1)
                    R(
                        nil,
                        c,
                        x - 6 + math.sin(t + i) * 3,
                        150 - k * 30,
                        3 + k * 3,
                        2,
                        ("rgba(255,248,232," .. tostring((1 - k) * 0.5)) .. ")"
                    )
                    i = i + 1
                end
            end
        end
        for ____, gx in __iterar((__arrL({700, 1660}, 2))) do
            local sx = gx - camL
            if __t(__L1:vis(sx, 30)) then
                do
                    local k = 0
                    while k < 3 do
                        R(
                            nil,
                            c,
                            sx + 6 + k * 8,
                            __L1.GY - 12 - if math.sin(t * 6 + k) > 0.7 then 1 else 0,
                            2,
                            2,
                            "#c43c3a"
                        )
                        k = k + 1
                    end
                end
            end
        end
        __L1:fog(
            c,
            s,
            t,
            camL,
            0.18
        )
    end
    __L1.feiraLights = function(self, g, s, t, camL)
        local a = __L1:night(s)
        if __lt(a, 0.03) then
            return
        end
        do
            local x = 58
            while x < __L1.FEIRA.W do
                local sx = x - camL
                if __t(__L1:vis(sx)) then
                    local gr = g:createRadialGradient(
                        sx,
                        128,
                        2,
                        sx,
                        140,
                        40
                    )
                    gr:addColorStop(
                        0,
                        ("rgba(255,220,150," .. tostring(0.3 * a)) .. ")"
                    )
                    gr:addColorStop(1, "rgba(255,220,150,0)")
                    g.fillStyle = gr
                    g:fillRect(sx - 40, 100, 80, 80)
                    lightAdd(
                        nil,
                        sx,
                        120,
                        a * 0.45,
                        56
                    )
                end
                x = x + 92
            end
        end
    end
    __L1.buildCafe = function(self)
        local cv, c = table.unpack(
            mk(nil, __L1.CAFE.W, LH),
            1,
            2
        )
        do
            local row = 0
            while row < 8 do
                local y = 112 + row * 11
                do
                    local x = 0
                    while x < __L1.CAFE.W do
                        local yy = y + math.floor(math.sin(x * 0.01 + row) * 3 + 0.5)
                        ell(
                            nil,
                            c,
                            x,
                            yy,
                            5,
                            5,
                            if __t(__mod(row, 2)) then "#2f5a34" else "#3a6a3c"
                        )
                        ell(
                            nil,
                            c,
                            x - 1,
                            yy - 2,
                            3,
                            2,
                            "#4f8a4a"
                        )
                        if __gt(
                            hash(nil, x + row * 99),
                            0.7
                        ) then
                            R(
                                nil,
                                c,
                                x + 1,
                                yy + 1,
                                2,
                                2,
                                "#c43c3a"
                            )
                        end
                        if __gt(
                            hash(nil, x + row * 77),
                            0.85
                        ) then
                            R(
                                nil,
                                c,
                                x - 2,
                                yy,
                                2,
                                2,
                                "#e8c24c"
                            )
                        end
                        x = x + 7
                    end
                end
                row = row + 1
            end
        end
        do
            local x = 10
            local i = 0
            while x < __L1.CAFE.W do
                local h = 40 + math.floor(hash(nil, i + 3001) * 34 + 0.5)
                local top = 116 - h
                R(
                    nil,
                    c,
                    x,
                    top,
                    2,
                    h,
                    "#d8ccb6"
                )
                R(
                    nil,
                    c,
                    x,
                    top,
                    1,
                    h,
                    "#b8ac96"
                )
                do
                    local k = 0
                    while k < 6 do
                        ell(
                            nil,
                            c,
                            x + 1 + (hash(nil, i * 7 + k) - 0.5) * 10,
                            top + 4 + k * 5,
                            4 + hash(nil, i * 3 + k) * 4,
                            4 + hash(nil, i + k) * 3,
                            if __t(__mod(k, 2)) then "#5a7a5a" else "#6f8f6a"
                        )
                        k = k + 1
                    end
                end
                ell(
                    nil,
                    c,
                    x - 1,
                    top + 2,
                    3,
                    3,
                    "#8aa682"
                )
                do
                    i = i + 1
                    x = x + (16 + math.floor(hash(nil, i + 3000) * 26 + 0.5))
                end
            end
        end
        local hx = 260
        __L1:plaster(
            c,
            hx,
            126,
            180,
            84,
            "#f2ece0",
            260
        )
        __L1:roofTiles(
            c,
            hx - 8,
            114,
            196,
            12,
            "#8a4430"
        )
        do
            local k = 0
            while k < 6 do
                R(
                    nil,
                    c,
                    hx + 10 + k * 28,
                    160,
                    4,
                    50,
                    "#8a6a45"
                )
                __L1:janela(
                    c,
                    hx + 14 + k * 28,
                    134,
                    12,
                    14,
                    "veneziana",
                    260 + k
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            hx,
            158,
            180,
            3,
            "#c4955c"
        )
        do
            local k = 0
            while k < 20 do
                R(
                    nil,
                    c,
                    hx + 60 + k * 2,
                    176 + math.floor(math.sin(k / 19 * math.pi) * 6 + 0.5),
                    2,
                    2,
                    "#c43c3a"
                )
                k = k + 1
            end
        end
        do
            local k = 0
            while k < 4 do
                __L1:plantaVaso(c, hx + 6 + k * 50, __L1.GY, k + 270)
                k = k + 1
            end
        end
        __L1:caixaDagua(c, hx + 140, 92, 1)
        R(
            nil,
            c,
            700,
            196,
            520,
            14,
            "#cfcac0"
        )
        do
            local k = 0
            while k < 520 do
                local yy = 198 + math.floor(math.sin(k * 0.2) * 2 + 0.5)
                R(
                    nil,
                    c,
                    700 + k,
                    yy,
                    2,
                    6,
                    if __mod(k, 8) < 4 then "#7a4a2a" else "#5a3420"
                )
                k = k + 2
            end
        end
        limb(
            nil,
            c,
            __arrL(
                {
                    __arrL({820, 196}, 2),
                    __arrL({840, 176}, 2)
                },
                2
            ),
            1,
            "#8a6a45"
        )
        R(
            nil,
            c,
            814,
            195,
            12,
            2,
            "#5a4a34"
        )
        do
            local k = 0
            while k < 6 do
                local sx = 1230 + __mod(k, 3) * 14
                local sy = __L1.GY - 14 - math.floor(k / 3) * 12
                R(
                    nil,
                    c,
                    sx,
                    sy,
                    13,
                    13,
                    "#d8c8a0"
                )
                R(
                    nil,
                    c,
                    sx + 1,
                    sy - 2,
                    11,
                    3,
                    "#c4b48c"
                )
                R(
                    nil,
                    c,
                    sx + 3,
                    sy + 4,
                    7,
                    3,
                    "#5a3420"
                )
                k = k + 1
            end
        end
        local gx = 1400
        R(
            nil,
            c,
            gx - 6,
            104,
            312,
            6,
            "#7a7f84"
        )
        do
            local k = 0
            while k < 312 do
                R(
                    nil,
                    c,
                    gx - 6 + k,
                    100,
                    6,
                    4,
                    "#9aa0a6"
                )
                k = k + 8
            end
        end
        R(
            nil,
            c,
            gx,
            110,
            4,
            100,
            "#7a7f84"
        )
        R(
            nil,
            c,
            gx + 296,
            110,
            4,
            100,
            "#7a7f84"
        )
        R(
            nil,
            c,
            gx + 30,
            150,
            110,
            44,
            "#4a5a64"
        )
        do
            local k = 0
            while k < 110 do
                R(
                    nil,
                    c,
                    gx + 30 + k,
                    150,
                    2,
                    44,
                    "#3a4852"
                )
                k = k + 8
            end
        end
        R(
            nil,
            c,
            gx + 30,
            150,
            110,
            3,
            "#8a9aa4"
        )
        R(
            nil,
            c,
            gx + 40,
            194,
            6,
            16,
            "#2a2a2a"
        )
        R(
            nil,
            c,
            gx + 124,
            194,
            6,
            16,
            "#2a2a2a"
        )
        R(
            nil,
            c,
            gx + 180,
            140,
            70,
            60,
            "#c47a35"
        )
        R(
            nil,
            c,
            gx + 184,
            144,
            62,
            20,
            "#e8a24c"
        )
        R(
            nil,
            c,
            gx + 196,
            120,
            14,
            22,
            "#9aa0a6"
        )
        R(
            nil,
            c,
            gx + 230,
            200,
            30,
            10,
            "#5a3420"
        )
        local tx = 1820
        R(
            nil,
            c,
            tx,
            178,
            40,
            16,
            "#c43c3a"
        )
        R(
            nil,
            c,
            tx + 26,
            164,
            16,
            16,
            "#c43c3a"
        )
        R(
            nil,
            c,
            tx + 28,
            166,
            12,
            8,
            "#9fc4d0"
        )
        R(
            nil,
            c,
            tx + 8,
            172,
            3,
            8,
            "#5a5a56"
        )
        ell(
            nil,
            c,
            tx + 34,
            198,
            11,
            11,
            "#1c1c1c"
        )
        ell(
            nil,
            c,
            tx + 34,
            198,
            5,
            5,
            "#e8c24c"
        )
        ell(
            nil,
            c,
            tx + 8,
            202,
            7,
            7,
            "#1c1c1c"
        )
        ell(
            nil,
            c,
            tx + 8,
            202,
            3,
            3,
            "#e8c24c"
        )
        R(
            nil,
            c,
            2060,
            184,
            26,
            26,
            "#9a948a"
        )
        R(
            nil,
            c,
            2058,
            182,
            30,
            4,
            "#b4aea2"
        )
        R(
            nil,
            c,
            2060,
            150,
            3,
            32,
            "#6a4a32"
        )
        R(
            nil,
            c,
            2083,
            150,
            3,
            32,
            "#6a4a32"
        )
        R(
            nil,
            c,
            2058,
            148,
            30,
            4,
            "#8a4430"
        )
        R(
            nil,
            c,
            2071,
            152,
            1,
            18,
            "#3a3a36"
        )
        R(
            nil,
            c,
            2068,
            170,
            7,
            6,
            "#8a6a45"
        )
        do
            local x = 2110
            while x < __L1.CAFE.W do
                R(
                    nil,
                    c,
                    x,
                    188,
                    3,
                    22,
                    "#8a6a45"
                )
                x = x + 16
            end
        end
        R(
            nil,
            c,
            2110,
            192,
            __L1.CAFE.W - 2110,
            2,
            "#a07a4a"
        )
        R(
            nil,
            c,
            2110,
            202,
            __L1.CAFE.W - 2110,
            2,
            "#a07a4a"
        )
        R(
            nil,
            c,
            2300,
            70,
            50,
            34,
            "#3c6aa8"
        )
        R(
            nil,
            c,
            2300,
            70,
            50,
            3,
            "#8ab4d8"
        )
        for ____, k in __iterar((__arrL({2304, 2342}, 2))) do
            R(
                nil,
                c,
                k,
                104,
                3,
                106,
                "#7a7f84"
            )
        end
        __L1:objetos(
            c,
            18,
            __L1.CAFE.W,
            "natureza",
            40,
            680,
            __arrL({70, 140}, 2)
        )
        __L1:objetos(
            c,
            18,
            __L1.CAFE.W,
            "natureza",
            2400,
            __L1.CAFE.W - 30,
            __arrL({60, 120}, 2)
        )
        __L1:terra(c, __L1.CAFE.W, "#6a8a46", "#577238")
        __L1:chaoDetalhe(c, __L1.CAFE.W, "natureza")
        return cv
    end
    __L1.cafe = function(self, c, s, t, camL)
        if not __t(__L1.cafeMid) then
            __L1.cafeMid = __L1:buildCafe()
        end
        if not __t(__L1.FAR) then
            __L1.FAR = __L1:buildFar()
        end
        sky(
            nil,
            c,
            s,
            t,
            camL
        )
        tile(nil, c, __L1.FAR.ridge, camL * 0.02)
        haze(
            nil,
            c,
            s,
            t,
            camL,
            100,
            160
        )
        tile(nil, c, __L1.FAR.trees, camL * 0.08)
        local ____opt_45 = __L1:CAM()
        if ____opt_45 ~= nil then
            ____opt_45 = ____opt_45.meio
        end
        if ____opt_45 ~= nil then
            ____opt_45(
                ____opt_45,
                __L1.CUR,
                c,
                s,
                t,
                camL
            )
        end
        __L1:passaros(
            c,
            t,
            camL,
            5,
            7
        )
        __L1:drawMid(
            c,
            __L1.cafeMid,
            camL,
            s,
            t
        )
        do
            local x = 1400 + 85 - camL
            if __t(__L1:vis(x, 80)) then
                do
                    local k = 0
                    while k < 6 do
                        local a = t * 2 + k
                        R(
                            nil,
                            c,
                            x + math.cos(a) * 18,
                            172 + math.sin(a) * 8,
                            3,
                            3,
                            "#c8d0d4"
                        )
                        k = k + 1
                    end
                end
            end
        end
        do
            local x = __mod(
                __mod(
                    __TS__Number(-camL),
                    40
                ) + 40,
                40
            ) - 40
            while __lt(x, LW + 40) do
                local wx = x + camL
                if __gt(
                    hash(
                        nil,
                        math.floor(wx / 40)
                    ),
                    0.55
                ) then
                    ell(
                        nil,
                        c,
                        x,
                        212,
                        10,
                        9,
                        "#2f5a34"
                    )
                    ell(
                        nil,
                        c,
                        x - 2,
                        208,
                        7,
                        6,
                        "#3f7a44"
                    )
                    do
                        local k = 0
                        while k < 4 do
                            R(
                                nil,
                                c,
                                x - 6 + k * 4,
                                210 - __mod(k, 2) * 4,
                                2,
                                2,
                                "#d8443a"
                            )
                            k = k + 1
                        end
                    end
                end
                x = x + 40
            end
        end
        do
            local i = 0
            while i < 5 do
                local wx = 760 + i * 120 + math.sin(t * 0.3 + i) * 30
                local sx = wx - camL
                if __t(__L1:vis(sx, 20)) then
                    __L1:gente(
                        c,
                        sx,
                        210,
                        i + 2,
                        false
                    )
                    R(
                        nil,
                        c,
                        sx + 5,
                        196,
                        1,
                        14,
                        "#8a6a45"
                    )
                    R(
                        nil,
                        c,
                        sx + 2,
                        196,
                        7,
                        2,
                        "#8a6a45"
                    )
                end
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 4 do
                local wx = 2160 + i * 40 + math.sin(t * 0.8 + i * 2) * 20
                local sx = wx - camL
                local hop = math.max(
                    0,
                    math.sin(t * 5 + i)
                ) * 2
                if __t(__L1:vis(sx, 10)) then
                    R(
                        nil,
                        c,
                        sx,
                        212 - hop,
                        6,
                        5,
                        "#f2efe6"
                    )
                    R(
                        nil,
                        c,
                        sx + 4,
                        209 - hop,
                        3,
                        3,
                        "#f2efe6"
                    )
                    R(
                        nil,
                        c,
                        sx + 5,
                        208 - hop,
                        2,
                        1,
                        "#c43c3a"
                    )
                    R(
                        nil,
                        c,
                        sx + 7,
                        210 - hop,
                        1,
                        1,
                        "#e8c24c"
                    )
                end
                i = i + 1
            end
        end
        __L1:fog(
            c,
            s,
            t,
            camL,
            0.45
        )
    end
    __L1.cafeLights = function(self, g, s, t, camL)
        local a = __L1:night(s)
        if __lt(a, 0.03) then
            return
        end
        do
            local k = 0
            while k < 6 do
                local sx = 260 + 20 + k * 28 - camL
                if __t(__L1:vis(sx)) then
                    g.fillStyle = ("rgba(255,214,140," .. tostring(0.55 * a)) .. ")"
                    g:fillRect(sx - 6, 134, 12, 14)
                    lightAdd(
                        nil,
                        sx,
                        140,
                        a * 0.4,
                        40
                    )
                end
                k = k + 1
            end
        end
    end
    __L1.buildCultura = function(self)
        local cv, c = table.unpack(
            mk(nil, __L1.CULTURA.W, LH),
            1,
            2
        )
        do
            local i = 0
            local x = 10
            while x < __L1.CULTURA.W do
                local w = 60 + math.floor(hash(nil, i + 170) * 40 + 0.5)
                __L1:predio(
                    c,
                    x,
                    w,
                    4 + math.floor(hash(nil, i + 171) * 3 + 0.5),
                    __L1:pick(
                        __arrL({"#e9e6dc", "#cfd6dc", "#ddd3bf"}, 3),
                        i
                    ),
                    170 + i
                )
                x = x + (w + 70)
                i = i + 1
            end
        end
        R(
            nil,
            c,
            110,
            106,
            250,
            104,
            "#8a9094"
        )
        R(
            nil,
            c,
            110,
            106,
            250,
            4,
            "#b8bec2"
        )
        do
            local k = 0
            while k < 250 do
                R(
                    nil,
                    c,
                    110 + k,
                    110,
                    2,
                    100,
                    "#7a8084"
                )
                k = k + 24
            end
        end
        R(
            nil,
            c,
            130,
            118,
            130,
            28,
            "#5f6569"
        )
        R(
            nil,
            c,
            230,
            170,
            60,
            40,
            "#2c3a44"
        )
        R(
            nil,
            c,
            232,
            172,
            56,
            36,
            "#9fc4d0"
        )
        do
            local k = 0
            while k < 3 do
                __L1:cartaz(c, 300 + k * 16, 150, 170 + k)
                k = k + 1
            end
        end
        local tx = __L1.CULTURA.TEATRO
        __L1:brick(
            c,
            tx,
            86,
            300,
            124,
            "#b08a5a",
            600
        )
        R(
            nil,
            c,
            tx - 10,
            138,
            320,
            12,
            "#3a2a2a"
        )
        do
            local k = 0
            while k < 4 do
                R(
                    nil,
                    c,
                    tx + 20 + k * 70,
                    158,
                    44,
                    52,
                    "#2a2a34"
                )
                R(
                    nil,
                    c,
                    tx + 22 + k * 70,
                    160,
                    40,
                    30,
                    __get(
                        __arrL({"#c43c3a", "#3c6aa8", "#e8c24c", "#7a3a8a"}, 4),
                        k
                    )
                )
                R(
                    nil,
                    c,
                    tx + 26 + k * 70,
                    164,
                    32,
                    6,
                    "#f2efe6"
                )
                R(
                    nil,
                    c,
                    tx + 26 + k * 70,
                    174,
                    22,
                    10,
                    __L1:shadeHex(
                        __get(
                            __arrL({"#c43c3a", "#3c6aa8", "#e8c24c", "#7a3a8a"}, 4),
                            k
                        ),
                        0.7
                    )
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            tx + 40,
            96,
            220,
            34,
            "#2a2a34"
        )
        R(
            nil,
            c,
            tx + 42,
            98,
            216,
            30,
            "#4a2a2a"
        )
        R(
            nil,
            c,
            tx + 130,
            190,
            40,
            20,
            "#c43c3a"
        )
        R(
            nil,
            c,
            tx + 134,
            192,
            32,
            8,
            "#f2e8d0"
        )
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({960, "#e8c24c"}, 2),
                __arrL({1080, "#c43c3a"}, 2)
            },
            2
        ))) do
            local fx = ____value[1]
            local col = ____value[2]
            R(
                nil,
                c,
                fx,
                166,
                80,
                38,
                col
            )
            R(
                nil,
                c,
                fx + 6,
                172,
                40,
                18,
                "#2a2a34"
            )
            R(
                nil,
                c,
                fx + 8,
                174,
                36,
                14,
                "#f2e8d0"
            )
            R(
                nil,
                c,
                fx,
                164,
                80,
                3,
                __L1:shadeHex(col, 1.2)
            )
            ell(
                nil,
                c,
                fx + 14,
                206,
                5,
                5,
                "#1c1c1c"
            )
            ell(
                nil,
                c,
                fx + 64,
                206,
                5,
                5,
                "#1c1c1c"
            )
            R(
                nil,
                c,
                fx + 52,
                170,
                22,
                6,
                "#f2efe6"
            )
        end
        local dx = __L1.CULTURA.DOME
        do
            local k = 0
            while k < 60 do
                local w = math.floor(math.sqrt(1 - (k / 60) ^ 2) * 110 + 0.5)
                R(
                    nil,
                    c,
                    dx - w,
                    150 - k,
                    w * 2,
                    1,
                    if __t(__mod(k, 6)) then "#eef0f2" else "#d8dce0"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            dx - 112,
            150,
            224,
            60,
            "#d8dce0"
        )
        do
            local k = 0
            while k < 24 do
                R(
                    nil,
                    c,
                    dx - 100 + k * 9,
                    160 + __mod(k, 3) * 9,
                    2,
                    2,
                    "#3c4a6a"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            dx - 20,
            176,
            40,
            34,
            "#2c3a44"
        )
        do
            local k = 0
            while k < 7 do
                local a = -math.pi + k * 0.5
                local rx = dx + math.cos(a) * 80
                local ry = 130 + math.sin(a) * 40
                R(
                    nil,
                    c,
                    rx,
                    ry,
                    3,
                    3,
                    "#f2c94c"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            1260,
            180,
            16,
            30,
            "#8a8478"
        )
        R(
            nil,
            c,
            1262,
            170,
            12,
            12,
            "#6a5a4a"
        )
        R(
            nil,
            c,
            1260,
            162,
            16,
            10,
            "#7a6a58"
        )
        for ____, bx in __iterar((__arrL({1820, 1960}, 2))) do
            __L1:canteiro(c, bx, 60)
        end
        do
            local lx = 100
            while lx < __L1.CULTURA.W do
                lampPost(nil, c, lx, 120)
                lx = lx + 260
            end
        end
        __L1:bandeirinhas(
            c,
            __L1.CULTURA.TEATRO - 20,
            __L1.CULTURA.TEATRO + 320,
            80,
            19
        )
        __L1:objetos(
            c,
            19,
            __L1.CULTURA.W,
            "cidade",
            1700,
            __L1.CULTURA.W - 30
        )
        __L1:pedraPortuguesa(c, __L1.CULTURA.W, 210)
        R(
            nil,
            c,
            0,
            210,
            __L1.CULTURA.W,
            2,
            "#c8c2b0"
        )
        __L1:chaoDetalhe(c, __L1.CULTURA.W, "cidade")
        return cv
    end
    __L1.cultura = function(self, c, s, t, camL)
        if not __t(__L1.culturaMid) then
            __L1.culturaMid = __L1:buildCultura()
        end
        __L1:conquistaBack(
            c,
            s,
            t,
            camL,
            {seed = 13}
        )
        local a = __L1:night(s)
        if __gt(a, 0.05) then
            do
                local i = 0
                while i < 50 do
                    local x = __mod(
                        hash(nil, i + 400) * 600 - camL * 0.02,
                        LW
                    )
                    local y = hash(nil, i + 401) * 100
                    if math.sin(t * 2 + i) > -0.2 then
                        R(
                            nil,
                            c,
                            x,
                            y,
                            1,
                            1,
                            ("rgba(255,255,240," .. tostring(a)) .. ")"
                        )
                    end
                    i = i + 1
                end
            end
        end
        __L1:drawMid(
            c,
            __L1.culturaMid,
            camL,
            s,
            t
        )
        do
            local tx = __L1.CULTURA.TEATRO - camL
            if __t(__L1:vis(tx, 340)) then
                do
                    local k = 0
                    while k < 320 do
                        R(
                            nil,
                            c,
                            tx - 8 + k,
                            142,
                            3,
                            3,
                            if __t(__mod(
                                math.floor(t * 6) + k / 8,
                                3
                            )) then "#ffe39a" else "#8a6a3a"
                        )
                        k = k + 8
                    end
                end
            end
        end
        for ____, x in __iterar((__arrL({640, 860}, 2))) do
            local sx = x - camL
            if __t(not __t(__L1:vis(sx, 120)) or __lt(a, 0.05)) then
                continue
            end
            local ang = math.sin(t * 0.6 + x) * 0.5
            c.fillStyle = ("rgba(255,250,220," .. tostring(0.08 * a)) .. ")"
            c:beginPath()
            c:moveTo(sx, 140)
            c:lineTo(
                sx + math.sin(ang) * 260 - 20,
                -10
            )
            c:lineTo(
                sx + math.sin(ang) * 260 + 20,
                -10
            )
            c:closePath()
            __call(c, "fill")
        end
        for ____, x in __iterar((__arrL({420, 1180, 1800}, 3))) do
            local sx = x - camL
            if __t(__L1:vis(sx, 60)) then
                tree(
                    nil,
                    c,
                    sx,
                    214,
                    0.85,
                    1,
                    t,
                    x
                )
            end
        end
        do
            local i = 0
            while i < 12 do
                local wx = 520 + i * 100 + math.sin(t * 0.3 + i) * 14
                local sx = wx - camL
                if __t(__L1:vis(sx, 20)) then
                    __L1:gente(c, sx, 214, i)
                end
                i = i + 1
            end
        end
        do
            local x = 1000 - camL
            if __t(__L1:vis(x, 40)) then
                do
                    local i = 0
                    while i < 4 do
                        local k = __mod(t * 0.5 + i / 4, 1)
                        R(
                            nil,
                            c,
                            x + math.sin(i * 2) * 4,
                            160 - k * 18,
                            2,
                            2,
                            ("rgba(255,250,220," .. tostring(1 - k)) .. ")"
                        )
                        i = i + 1
                    end
                end
            end
        end
    end
    __L1.culturaLights = function(self, g, s, t, camL)
        local a = math.max(
            0.35,
            __L1:night(s)
        )
        local tx = __L1.CULTURA.TEATRO - camL
        if __t(__L1:vis(tx, 340)) then
            g.fillStyle = ("rgba(255,227,154," .. tostring(0.45 * a)) .. ")"
            g:fillRect(tx - 10, 138, 320, 14)
            lightAdd(
                nil,
                tx + 150,
                140,
                a * 0.7,
                160
            )
            local gr = g:createLinearGradient(0, 150, 0, 214)
            gr:addColorStop(
                0,
                ("rgba(255,220,150," .. tostring(0.35 * a)) .. ")"
            )
            gr:addColorStop(1, "rgba(255,220,150,0)")
            g.fillStyle = gr
            g:fillRect(tx - 10, 150, 320, 64)
        end
        local dx = __L1.CULTURA.DOME - camL
        if __t(__L1:vis(dx, 140)) then
            local gr = g:createRadialGradient(
                dx,
                110,
                10,
                dx,
                110,
                130
            )
            gr:addColorStop(
                0,
                ("rgba(170,200,255," .. tostring(0.25 * a)) .. ")"
            )
            gr:addColorStop(1, "rgba(170,200,255,0)")
            g.fillStyle = gr
            g:fillRect(dx - 130, 0, 260, 214)
        end
        do
            local x = 100
            while x < __L1.CULTURA.W do
                lampGlow(
                    nil,
                    g,
                    x - camL,
                    120,
                    a
                )
                x = x + 260
            end
        end
        for ____, fx in __iterar((__arrL({960, 1080}, 2))) do
            local sx = fx + 26 - camL
            if __t(__L1:vis(sx)) then
                g.fillStyle = ("rgba(255,236,190," .. tostring(0.4 * a)) .. ")"
                g:fillRect(sx - 20, 172, 40, 18)
            end
        end
    end
    __L1.vgrad = function(self, c, x, y, w, h, a, b)
        do
            local k = 0
            while __lt(k, h) do
                R(
                    nil,
                    c,
                    x,
                    y + k,
                    w,
                    1,
                    __L1:lerpC(
                        a,
                        b,
                        k / math.max(1, h - 1)
                    )
                )
                k = k + 1
            end
        end
    end
    __L1.coluna = function(self, c, x, y0, y1, w)
        if w == nil then
            w = 10
        end
        local band = __arrL({
            "#8f8b82",
            "#b4b0a5",
            "#d8d4c8",
            "#f2efe6",
            "#fbf9f2",
            "#e6e2d6",
            "#c4c0b4",
            "#a09c92"
        }, 8)
        do
            local k = 0
            while k < w do
                R(
                    nil,
                    c,
                    x + k,
                    y0,
                    1,
                    y1 - y0,
                    __get(
                        band,
                        math.min(
                            __len(band) - 1,
                            math.floor(k / w * __len(band))
                        )
                    )
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            x - 2,
            y0,
            w + 4,
            3,
            "#f6f2e8"
        )
        R(
            nil,
            c,
            x - 2,
            y0 + 3,
            w + 4,
            1,
            "#9a968c"
        )
        R(
            nil,
            c,
            x - 2,
            y1 - 4,
            w + 4,
            4,
            "#dcd8cc"
        )
        R(
            nil,
            c,
            x - 2,
            y1 - 4,
            w + 4,
            1,
            "#f6f2e8"
        )
    end
    __L1.reflexo = function(self, c, x, y, w, h)
        do
            local k = 0
            while k < math.floor(h * 0.35 + 0.5) do
                R(
                    nil,
                    c,
                    x,
                    y + k,
                    w,
                    1,
                    ("rgba(255,255,255," .. tostring(0.16 * (1 - k / (h * 0.35)))) .. ")"
                )
                k = k + 1
            end
        end
        do
            local k = 6
            while __lt(
                k,
                __add(w, h)
            ) do
                limb(
                    nil,
                    c,
                    __call(
                        __arrL(
                            {
                                __arrL({x + k, y}, 2),
                                __arrL(
                                    {
                                        x + k - h * 0.6,
                                        __add(y, h)
                                    },
                                    2
                                )
                            },
                            2
                        ),
                        "map",
                        function(____, ____bindingPattern0)
                            local py
                            local px
                            px = ____bindingPattern0[1]
                            py = ____bindingPattern0[2]
                            return __arrL(
                                {
                                    math.max(
                                        x,
                                        math.min(
                                            __add(x, w) - 2,
                                            px
                                        )
                                    ),
                                    py
                                },
                                2
                            )
                        end
                    ),
                    3,
                    "rgba(255,255,255,.13)"
                )
                limb(
                    nil,
                    c,
                    __call(
                        __arrL(
                            {
                                __arrL({x + k + 6, y}, 2),
                                __arrL(
                                    {
                                        x + k + 6 - h * 0.6,
                                        __add(y, h)
                                    },
                                    2
                                )
                            },
                            2
                        ),
                        "map",
                        function(____, ____bindingPattern0)
                            local py
                            local px
                            px = ____bindingPattern0[1]
                            py = ____bindingPattern0[2]
                            return __arrL(
                                {
                                    math.max(
                                        x,
                                        math.min(
                                            __add(x, w) - 1,
                                            px
                                        )
                                    ),
                                    py
                                },
                                2
                            )
                        end
                    ),
                    1,
                    "rgba(255,255,255,.22)"
                )
                k = k + 34
            end
        end
    end
    __L1.pessoa = function(self, c, x, y, i)
        local sh = __get(
            __L1.SHIRT,
            __mod(
                i,
                __len(__L1.SHIRT)
            )
        )
        local sk = __get(
            __L1.SKIN,
            __mod(
                i,
                __len(__L1.SKIN)
            )
        )
        R(
            nil,
            c,
            x,
            y - 6,
            2,
            6,
            "#2a2f3a"
        )
        R(
            nil,
            c,
            x + 3,
            y - 6,
            2,
            6,
            "#232833"
        )
        R(
            nil,
            c,
            x - 1,
            y - 14,
            7,
            9,
            sh
        )
        R(
            nil,
            c,
            x + 4,
            y - 14,
            2,
            9,
            __L1:shadeHex(sh, 0.75)
        )
        R(
            nil,
            c,
            x - 1,
            y - 14,
            7,
            1,
            __L1:shadeHex(sh, 1.2)
        )
        R(
            nil,
            c,
            x,
            y - 19,
            5,
            5,
            sk
        )
        R(
            nil,
            c,
            x + 3,
            y - 18,
            2,
            4,
            __L1:shadeHex(sk, 0.85)
        )
        R(
            nil,
            c,
            x,
            y - 20,
            5,
            2,
            __L1:pick(
                __arrL({"#2a201a", "#4a3226", "#1a1a1a", "#c8a050"}, 4),
                i
            )
        )
        R(
            nil,
            c,
            x - 1,
            y,
            7,
            1,
            "rgba(0,0,0,.18)"
        )
        if __mod(i, 3) ~= 1 then
            R(
                nil,
                c,
                x + 6,
                y - 9,
                4,
                6,
                __L1:pick(
                    __arrL({
                        "#c43c3a",
                        "#2c5a9e",
                        "#e8c24c",
                        "#d84a7a",
                        "#f2efe6"
                    }, 5),
                    i
                )
            )
            R(
                nil,
                c,
                x + 7,
                y - 11,
                2,
                2,
                "#5a5a5a"
            )
        end
    end
    __L1.buildShopFar = function(self)
        local T = 964
        local cv, c = table.unpack(
            mk(nil, T, LH),
            1,
            2
        )
        __L1:vgrad(
            c,
            0,
            0,
            T,
            125,
            "#efe9dc",
            "#e2dbcc"
        )
        local LV = __arrL({{y = 26, h = 24}, {y = 55, h = 27}, {y = 87, h = 30}}, 3)
        __call(
            LV,
            "forEach",
            function(____, L, li)
                do
                    local x = 0
                    local i = 0
                    while x < T do
                        local w = 28 + math.floor(hash(nil, i * 3 + li * 50) * 18 + 0.5)
                        local sig = __L1:pick(__L1.SIGNS, i + li * 5)
                        R(
                            nil,
                            c,
                            x,
                            L.y,
                            w,
                            L.h,
                            "#5e626a"
                        )
                        R(
                            nil,
                            c,
                            x + 1,
                            L.y + 1,
                            w - 2,
                            4,
                            sig
                        )
                        R(
                            nil,
                            c,
                            x + 1,
                            L.y + 1,
                            w - 2,
                            1,
                            "#ffffff55"
                        )
                        __L1:vgrad(
                            c,
                            x + 2,
                            L.y + 6,
                            w - 4,
                            L.h - 7,
                            "#fff7e4",
                            "#e8dcc2"
                        )
                        local tipo = math.floor(hash(nil, i * 7 + li) * 3)
                        if tipo == 0 then
                            for ____, sy in __iterar((__arrL({L.y + 11, L.y + 17}, 2))) do
                                R(
                                    nil,
                                    c,
                                    x + 3,
                                    sy,
                                    w - 6,
                                    1,
                                    "#c8b89c"
                                )
                                do
                                    local k = 0
                                    while k < (w - 8) / 6 do
                                        if __gt(
                                            hash(nil, k + i * 5 + sy),
                                            0.35
                                        ) then
                                            R(
                                                nil,
                                                c,
                                                x + 4 + k * 6,
                                                sy - 3,
                                                3,
                                                3,
                                                __L1:pick(
                                                    __arrL({"#c88a6a", "#8aa0b8", "#d8c07a", "#8ab08a"}, 4),
                                                    k + i
                                                )
                                            )
                                        end
                                        k = k + 1
                                    end
                                end
                            end
                        elseif tipo == 1 then
                            R(
                                nil,
                                c,
                                x + 3,
                                L.y + 7,
                                w - 6,
                                L.h - 9,
                                "#8a9aa6"
                            )
                            R(
                                nil,
                                c,
                                x + 4,
                                L.y + 8,
                                w - 8,
                                3,
                                "#b8c8d0"
                            )
                            do
                                local k = 4
                                while k < w - 8 do
                                    R(
                                        nil,
                                        c,
                                        x + k,
                                        L.y + 13,
                                        4,
                                        6,
                                        __L1:pick(
                                            __arrL({"#d8c8b0", "#c8b8a0", "#e0d0b8"}, 3),
                                            k
                                        )
                                    )
                                    k = k + 9
                                end
                            end
                        else
                            do
                                local k = 0
                                while k < w - 4 do
                                    R(
                                        nil,
                                        c,
                                        x + 2 + k,
                                        L.y + 5,
                                        4,
                                        3,
                                        if __t(__mod(k / 4, 2)) then sig else "#f2efe6"
                                    )
                                    k = k + 4
                                end
                            end
                            do
                                local k = 0
                                while k < 2 do
                                    R(
                                        nil,
                                        c,
                                        x + 5 + k * (w - 16),
                                        L.y + 10,
                                        6,
                                        9,
                                        __L1:pick(
                                            __arrL({"#c88a6a", "#8aa0b8", "#b88aa0"}, 3),
                                            k + i
                                        )
                                    )
                                    k = k + 1
                                end
                            end
                        end
                        R(
                            nil,
                            c,
                            x + math.floor(w / 2 + 0.5) - 4,
                            L.y + L.h - 10,
                            8,
                            10,
                            "#3a3630"
                        )
                        R(
                            nil,
                            c,
                            x + math.floor(w / 2 + 0.5) - 3,
                            L.y + L.h - 9,
                            2,
                            9,
                            "#5a544a"
                        )
                        x = x + (w + 1)
                        if __mod(i, 4) == 3 then
                            __L1:coluna(
                                c,
                                x,
                                L.y - 2,
                                L.y + L.h + 4,
                                6
                            )
                            x = x + 8
                        end
                        i = i + 1
                    end
                end
                R(
                    nil,
                    c,
                    0,
                    L.y + L.h,
                    T,
                    3,
                    "#f6f3ec"
                )
                R(
                    nil,
                    c,
                    0,
                    L.y + L.h + 3,
                    T,
                    2,
                    "#aaa293"
                )
                R(
                    nil,
                    c,
                    0,
                    L.y + L.h - 7,
                    T,
                    7,
                    "rgba(185,222,234,.55)"
                )
                R(
                    nil,
                    c,
                    0,
                    L.y + L.h - 8,
                    T,
                    1,
                    "#e2e8ea"
                )
                do
                    local x = 0
                    while x < T do
                        R(
                            nil,
                            c,
                            x,
                            L.y + L.h - 7,
                            1,
                            7,
                            "#b8c4ca"
                        )
                        x = x + 10
                    end
                end
                do
                    local k = 0
                    while k < 18 do
                        local px = math.floor(hash(nil, k + li * 31) * T + 0.5)
                        local i = k + li
                        R(
                            nil,
                            c,
                            px,
                            L.y + L.h - 10,
                            3,
                            4,
                            __L1:pick(__L1.SHIRT, i)
                        )
                        R(
                            nil,
                            c,
                            px,
                            L.y + L.h - 12,
                            3,
                            2,
                            __L1:pick(__L1.SKIN, i)
                        )
                        k = k + 1
                    end
                end
            end
        )
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({160, 84, 54}, 3),
                __arrL({610, 84, 54}, 3),
                __arrL({380, 54, 28}, 3),
                __arrL({820, 54, 28}, 3)
            },
            4
        ))) do
            local ex = ____value[1]
            local y0 = ____value[2]
            local y1 = ____value[3]
            local n = y0 - y1
            do
                local k = 0
                while k <= n do
                    R(
                        nil,
                        c,
                        ex + k,
                        y0 - k,
                        5,
                        2,
                        "#b8c0c6"
                    )
                    R(
                        nil,
                        c,
                        ex + k,
                        y0 - k + 2,
                        5,
                        1,
                        "#7a848c"
                    )
                    k = k + 2
                end
            end
            limb(
                nil,
                c,
                __arrL(
                    {
                        __arrL({ex - 1, y0 - 3}, 2),
                        __arrL({ex + n - 1, y1 - 3}, 2)
                    },
                    2
                ),
                1,
                "#2a2a2a"
            )
            c.fillStyle = "rgba(185,222,234,.35)"
            c:beginPath()
            c:moveTo(ex, y0)
            c:lineTo(ex + n + 5, y1)
            c:lineTo(ex + n + 5, y1 + 6)
            c:lineTo(ex + 5, y0 + 4)
            c:closePath()
            __call(c, "fill")
        end
        c.fillStyle = "rgba(242,238,230,.30)"
        c:fillRect(0, 0, T, 125)
        R(
            nil,
            c,
            0,
            0,
            T,
            20,
            "#c9cfd4"
        )
        do
            local x = 0
            while x < T do
                c:clearRect(x + 2, 0, 28, 14)
                R(
                    nil,
                    c,
                    x + 2,
                    0,
                    28,
                    14,
                    "rgba(205,234,248,.30)"
                )
                R(
                    nil,
                    c,
                    x + 3,
                    1,
                    9,
                    12,
                    "rgba(255,255,255,.18)"
                )
                R(
                    nil,
                    c,
                    x,
                    0,
                    2,
                    16,
                    "#7f8c96"
                )
                x = x + 32
            end
        end
        R(
            nil,
            c,
            0,
            14,
            T,
            2,
            "#7a8892"
        )
        R(
            nil,
            c,
            0,
            21,
            T,
            2,
            "#7a8892"
        )
        do
            local x = 0
            while x < T do
                limb(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x, 16}, 2),
                            __arrL({x + 4, 21}, 2),
                            __arrL({x + 8, 16}, 2)
                        },
                        3
                    ),
                    1,
                    "#98a4ae"
                )
                x = x + 8
            end
        end
        return cv
    end
    __L1.produtos = function(self, c, kind, x, y, w, h, i)
        local function P(____, j)
            return __L1:pick(
                __arrL({
                    "#d9634a",
                    "#3c6aa8",
                    "#e8c24c",
                    "#3c8a5a",
                    "#c86ab8",
                    "#2a2a2a",
                    "#f2efe6",
                    "#e8833a"
                }, 8),
                i * 7 + j
            )
        end
        local function prateleira(____, yy)
            R(
                nil,
                c,
                x + 3,
                yy,
                w - 6,
                2,
                "#b8a48a"
            )
            R(
                nil,
                c,
                x + 3,
                yy + 2,
                w - 6,
                1,
                "#7a6a52"
            )
        end
        if kind == "MODA" then
            R(
                nil,
                c,
                x + 4,
                y + 4,
                w - 8,
                1,
                "#7a7a76"
            )
            do
                local j = 0
                while j < (w - 14) / 7 do
                    local gx = x + 6 + j * 7
                    local col = P(nil, j)
                    R(
                        nil,
                        c,
                        gx + 2,
                        y + 2,
                        1,
                        3,
                        "#7a7a76"
                    )
                    R(
                        nil,
                        c,
                        gx,
                        y + 5,
                        6,
                        15,
                        col
                    )
                    R(
                        nil,
                        c,
                        gx,
                        y + 5,
                        1,
                        15,
                        __L1:shadeHex(col, 1.25)
                    )
                    R(
                        nil,
                        c,
                        gx + 5,
                        y + 5,
                        1,
                        15,
                        __L1:shadeHex(col, 0.72)
                    )
                    R(
                        nil,
                        c,
                        gx,
                        y + 5,
                        6,
                        1,
                        __L1:shadeHex(col, 0.8)
                    )
                    j = j + 1
                end
            end
            for ____, mx in __iterar((__arrL(
                {
                    x + 10,
                    __add(x, w) - 22
                },
                2
            ))) do
                ell(
                    nil,
                    c,
                    mx + 6,
                    y + 26,
                    3,
                    4,
                    "#efe2d4"
                )
                R(
                    nil,
                    c,
                    mx + 1,
                    y + 30,
                    10,
                    16,
                    P(nil, mx)
                )
                R(
                    nil,
                    c,
                    mx + 1,
                    y + 30,
                    2,
                    16,
                    __L1:shadeHex(
                        P(nil, mx),
                        1.3
                    )
                )
                R(
                    nil,
                    c,
                    mx + 9,
                    y + 30,
                    2,
                    16,
                    __L1:shadeHex(
                        P(nil, mx),
                        0.7
                    )
                )
                R(
                    nil,
                    c,
                    mx + 3,
                    y + 46,
                    6,
                    10,
                    "#3a4a6a"
                )
                R(
                    nil,
                    c,
                    mx + 5,
                    y + 56,
                    2,
                    4,
                    "#8a8a86"
                )
                R(
                    nil,
                    c,
                    mx + 2,
                    y + 60,
                    8,
                    2,
                    "#5a5a56"
                )
            end
        end
        if kind == "GAMES" then
            R(
                nil,
                c,
                x + 6,
                y + 4,
                52,
                32,
                "#14161c"
            )
            R(
                nil,
                c,
                x + 8,
                y + 6,
                48,
                28,
                "#6ab4e8"
            )
            R(
                nil,
                c,
                x + 8,
                y + 24,
                48,
                10,
                "#5aa04a"
            )
            R(
                nil,
                c,
                x + 8,
                y + 24,
                48,
                2,
                "#7ac85a"
            )
            ell(
                nil,
                c,
                x + 40,
                y + 12,
                4,
                4,
                "#fff2a0"
            )
            R(
                nil,
                c,
                x + 20,
                y + 16,
                5,
                8,
                "#e8433a"
            )
            R(
                nil,
                c,
                x + 21,
                y + 14,
                3,
                3,
                "#f0c8a8"
            )
            R(
                nil,
                c,
                x + 30,
                y + 36,
                4,
                4,
                "#2a2a2a"
            )
            do
                local j = 0
                while j < 12 do
                    local bx = x + 64 + __mod(j, 4) * 13
                    local by = y + 4 + math.floor(j / 4) * 17
                    local col = P(nil, j)
                    R(
                        nil,
                        c,
                        bx,
                        by,
                        11,
                        15,
                        col
                    )
                    R(
                        nil,
                        c,
                        bx,
                        by,
                        11,
                        3,
                        "#1e1e24"
                    )
                    R(
                        nil,
                        c,
                        bx + 1,
                        by + 5,
                        9,
                        6,
                        __L1:shadeHex(col, 1.3)
                    )
                    R(
                        nil,
                        c,
                        bx + 10,
                        by,
                        1,
                        15,
                        __L1:shadeHex(col, 0.6)
                    )
                    j = j + 1
                end
            end
            R(
                nil,
                c,
                x + 10,
                y + 44,
                30,
                10,
                "#1e2026"
            )
            R(
                nil,
                c,
                x + 12,
                y + 46,
                26,
                2,
                "#3a3c46"
            )
            R(
                nil,
                c,
                x + 16,
                y + 49,
                4,
                3,
                "#2c5a9e"
            )
            R(
                nil,
                c,
                x + 30,
                y + 49,
                3,
                3,
                "#c43c3a"
            )
        end
        if __t(kind == "TÊNIS" or kind == "LIVROS") then
            do
                local r = 0
                while r < 4 do
                    prateleira(nil, y + 14 + r * 13)
                    r = r + 1
                end
            end
        end
        if kind == "TÊNIS" then
            do
                local r = 0
                while r < 4 do
                    do
                        local j = 0
                        while j < (w - 12) / 14 do
                            local sx = x + 6 + j * 14
                            local sy = y + 6 + r * 13
                            local col = P(nil, j + r * 3)
                            R(
                                nil,
                                c,
                                sx,
                                sy + 4,
                                11,
                                3,
                                col
                            )
                            R(
                                nil,
                                c,
                                sx + 5,
                                sy + 1,
                                6,
                                4,
                                col
                            )
                            R(
                                nil,
                                c,
                                sx,
                                sy + 7,
                                11,
                                2,
                                "#f6f4ee"
                            )
                            R(
                                nil,
                                c,
                                sx + 2,
                                sy + 5,
                                6,
                                1,
                                "#f6f4ee"
                            )
                            R(
                                nil,
                                c,
                                sx + 9,
                                sy + 1,
                                2,
                                2,
                                __L1:shadeHex(col, 0.7)
                            )
                            j = j + 1
                        end
                    end
                    r = r + 1
                end
            end
        end
        if kind == "LIVROS" then
            do
                local r = 0
                while r < 4 do
                    do
                        local k = x + 5
                        while __lt(
                            k,
                            __add(x, w) - 6
                        ) do
                            local hh = 7 + math.floor(hash(nil, k + r * 7) * 4 + 0.5)
                            local col = P(nil, k + r)
                            R(
                                nil,
                                c,
                                k,
                                y + 14 + r * 13 - hh,
                                3,
                                hh,
                                col
                            )
                            R(
                                nil,
                                c,
                                k,
                                y + 14 + r * 13 - hh,
                                1,
                                hh,
                                __L1:shadeHex(col, 1.3)
                            )
                            R(
                                nil,
                                c,
                                k,
                                y + 16 + r * 13 - hh,
                                3,
                                1,
                                "#f2e8c8"
                            )
                            k = k + 3
                        end
                    end
                    r = r + 1
                end
            end
        end
        if kind == "PERFUMES" then
            __L1:vgrad(
                c,
                x + 4,
                y + 2,
                w - 8,
                h - 6,
                "#fff8ee",
                "#f2dccc"
            )
            do
                local r = 0
                while r < 3 do
                    R(
                        nil,
                        c,
                        x + 6,
                        y + 20 + r * 17,
                        w - 12,
                        2,
                        "rgba(200,230,240,.8)"
                    )
                    R(
                        nil,
                        c,
                        x + 6,
                        y + 22 + r * 17,
                        w - 12,
                        1,
                        "#c8b8a8"
                    )
                    do
                        local j = 0
                        while j < (w - 16) / 11 do
                            local bx = x + 9 + j * 11
                            local col = __L1:pick(
                                __arrL({
                                    "#e8a8c8",
                                    "#a8c8e8",
                                    "#f2d898",
                                    "#c8e8b8",
                                    "#d8b8e8",
                                    "#f0b890"
                                }, 6),
                                j + r + i
                            )
                            R(
                                nil,
                                c,
                                bx,
                                y + 10 + r * 17,
                                7,
                                10,
                                col
                            )
                            R(
                                nil,
                                c,
                                bx + 1,
                                y + 11 + r * 17,
                                2,
                                7,
                                "rgba(255,255,255,.55)"
                            )
                            R(
                                nil,
                                c,
                                bx + 6,
                                y + 10 + r * 17,
                                1,
                                10,
                                __L1:shadeHex(col, 0.75)
                            )
                            R(
                                nil,
                                c,
                                bx + 2,
                                y + 7 + r * 17,
                                3,
                                3,
                                "#c8a24a"
                            )
                            R(
                                nil,
                                c,
                                bx + 2,
                                y + 7 + r * 17,
                                1,
                                3,
                                "#f2d898"
                            )
                            j = j + 1
                        end
                    end
                    r = r + 1
                end
            end
        end
        if kind == "CHOCOLATE" then
            do
                local r = 0
                while r < 3 do
                    prateleira(nil, y + 16 + r * 15)
                    do
                        local j = 0
                        while j < (w - 12) / 10 do
                            local bx = x + 6 + j * 10
                            local by = y + 6 + r * 15
                            local col = __L1:pick(
                                __arrL({
                                    "#5a2e1a",
                                    "#7a3e22",
                                    "#c43c3a",
                                    "#e8c24c",
                                    "#d84a7a"
                                }, 5),
                                j + r
                            )
                            R(
                                nil,
                                c,
                                bx,
                                by,
                                8,
                                10,
                                col
                            )
                            R(
                                nil,
                                c,
                                bx + 1,
                                by + 2,
                                6,
                                3,
                                "#f2e2c8"
                            )
                            R(
                                nil,
                                c,
                                bx,
                                by,
                                8,
                                1,
                                __L1:shadeHex(col, 1.3)
                            )
                            j = j + 1
                        end
                    end
                    r = r + 1
                end
            end
            ell(
                nil,
                c,
                __add(x, w) - 22,
                y + 50,
                12,
                8,
                "#c43c3a"
            )
            ell(
                nil,
                c,
                __add(x, w) - 22,
                y + 48,
                10,
                6,
                "#e84a4a"
            )
            R(
                nil,
                c,
                __add(x, w) - 23,
                y + 40,
                2,
                16,
                "#f2c94c"
            )
        end
        if kind == "ELETRO" then
            do
                local j = 0
                while j < 3 do
                    local tx = x + 6 + j * 40
                    R(
                        nil,
                        c,
                        tx,
                        y + 4,
                        34,
                        22,
                        "#14161c"
                    )
                    __L1:vgrad(
                        c,
                        tx + 2,
                        y + 6,
                        30,
                        18,
                        __L1:pick(
                            __arrL({"#5ab8e8", "#e8a83a", "#7ac85a"}, 3),
                            j
                        ),
                        "#1e2a3a"
                    )
                    R(
                        nil,
                        c,
                        tx + 15,
                        y + 26,
                        4,
                        3,
                        "#3a3a40"
                    )
                    j = j + 1
                end
            end
            do
                local j = 0
                while j < 3 do
                    local gx = x + 8 + j * 40
                    R(
                        nil,
                        c,
                        gx,
                        y + 34,
                        26,
                        26,
                        "#e8eaec"
                    )
                    R(
                        nil,
                        c,
                        gx,
                        y + 34,
                        26,
                        2,
                        "#ffffff"
                    )
                    ell(
                        nil,
                        c,
                        gx + 13,
                        y + 48,
                        8,
                        8,
                        "#9aa6ae"
                    )
                    ell(
                        nil,
                        c,
                        gx + 13,
                        y + 48,
                        6,
                        6,
                        "#c8e0ea"
                    )
                    R(
                        nil,
                        c,
                        gx + 18,
                        y + 36,
                        6,
                        2,
                        "#5ae070"
                    )
                    j = j + 1
                end
            end
        end
        if kind == "BRINQUEDOS" then
            do
                local r = 0
                while r < 2 do
                    prateleira(nil, y + 24 + r * 22)
                    do
                        local j = 0
                        while j < (w - 14) / 16 do
                            local px = x + 8 + j * 16
                            local py = y + 23 + r * 22
                            local col = P(nil, j + r * 4)
                            ell(
                                nil,
                                c,
                                px + 6,
                                py - 5,
                                6,
                                6,
                                col
                            )
                            ell(
                                nil,
                                c,
                                px + 6,
                                py - 13,
                                5,
                                5,
                                col
                            )
                            R(
                                nil,
                                c,
                                px + 2,
                                py - 18,
                                3,
                                3,
                                col
                            )
                            R(
                                nil,
                                c,
                                px + 8,
                                py - 18,
                                3,
                                3,
                                col
                            )
                            ell(
                                nil,
                                c,
                                px + 6,
                                py - 4,
                                3,
                                3,
                                __L1:shadeHex(col, 1.3)
                            )
                            R(
                                nil,
                                c,
                                px + 4,
                                py - 14,
                                1,
                                1,
                                "#1a1a1a"
                            )
                            R(
                                nil,
                                c,
                                px + 8,
                                py - 14,
                                1,
                                1,
                                "#1a1a1a"
                            )
                            R(
                                nil,
                                c,
                                px + 5,
                                py - 11,
                                3,
                                1,
                                __L1:shadeHex(col, 0.6)
                            )
                            j = j + 1
                        end
                    end
                    r = r + 1
                end
            end
            local ux = __add(x, w) - 34
            ell(
                nil,
                c,
                ux + 14,
                y + 52,
                13,
                12,
                "#b8864a"
            )
            ell(
                nil,
                c,
                ux + 14,
                y + 34,
                10,
                9,
                "#b8864a"
            )
            ell(
                nil,
                c,
                ux + 6,
                y + 26,
                4,
                4,
                "#b8864a"
            )
            ell(
                nil,
                c,
                ux + 22,
                y + 26,
                4,
                4,
                "#b8864a"
            )
            ell(
                nil,
                c,
                ux + 14,
                y + 37,
                5,
                4,
                "#e8c896"
            )
            ell(
                nil,
                c,
                ux + 14,
                y + 52,
                8,
                7,
                "#d8a86a"
            )
            R(
                nil,
                c,
                ux + 10,
                y + 31,
                2,
                2,
                "#1a1a1a"
            )
            R(
                nil,
                c,
                ux + 17,
                y + 31,
                2,
                2,
                "#1a1a1a"
            )
            R(
                nil,
                c,
                ux + 13,
                y + 35,
                3,
                2,
                "#3a2418"
            )
            R(
                nil,
                c,
                ux + 6,
                y + 42,
                16,
                3,
                "#c43c3a"
            )
        end
    end
    __L1.lojaFrente = function(self, c, x, w, kind, i)
        local top = __L1.SHOP.TOP
        local bot = 210
        local sig = __L1:pick(__L1.SIGNS, i + 2)
        R(
            nil,
            c,
            x,
            top,
            w,
            bot - top,
            "#454951"
        )
        do
            local k = 0
            while k < w * (bot - top) / 10 do
                R(
                    nil,
                    c,
                    x + hash(nil, k + i * 99) * w,
                    top + hash(nil, k * 3 + i) * (bot - top),
                    1,
                    1,
                    if __t(__mod(k, 3)) then "#52565e" else "#3a3e46"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            x,
            top,
            w,
            1,
            "#6a6e76"
        )
        R(
            nil,
            c,
            x + 3,
            top + 2,
            w - 6,
            16,
            "#1c1f24"
        )
        __L1:vgrad(
            c,
            x + 4,
            top + 3,
            w - 8,
            14,
            __L1:shadeHex(sig, 1.25),
            __L1:shadeHex(sig, 0.85)
        )
        R(
            nil,
            c,
            x + 4,
            top + 3,
            w - 8,
            1,
            "#ffffff66"
        )
        ell(
            nil,
            c,
            x + 13,
            top + 10,
            5,
            5,
            "#f6f2ea"
        )
        ell(
            nil,
            c,
            x + 13,
            top + 10,
            3,
            3,
            sig
        )
        R(
            nil,
            c,
            x + 4,
            top + 18,
            w - 8,
            2,
            "#fff2c8"
        )
        local gx = x + 5
        local gy = top + 22
        local gw = w - 10
        local gh = bot - 2 - gy
        local wall = __L1:pick(
            __arrL({
                "#f4ecdc",
                "#e8eef2",
                "#f2e6e8",
                "#eef2e6",
                "#f6eedc"
            }, 5),
            i
        )
        __L1:vgrad(
            c,
            gx,
            gy,
            gw,
            gh,
            "#fffaf0",
            wall
        )
        do
            local k = 0
            while k < gw - 8 do
                R(
                    nil,
                    c,
                    gx + 6 + k,
                    gy + 1,
                    8,
                    1,
                    "#fffef4"
                )
                do
                    local j = 0
                    while j < 4 do
                        R(
                            nil,
                            c,
                            gx + 4 + k,
                            gy + 2 + j,
                            12,
                            1,
                            ("rgba(255,248,220," .. tostring(0.3 - j * 0.07)) .. ")"
                        )
                        j = j + 1
                    end
                end
                k = k + 16
            end
        end
        R(
            nil,
            c,
            gx,
            gy + gh - 9,
            gw,
            9,
            "#d8cfbe"
        )
        do
            local k = 0
            while k < gw do
                R(
                    nil,
                    c,
                    gx + k,
                    gy + gh - 9 + __mod(k / 8, 2) * 4,
                    4,
                    4,
                    "#cfc4b0"
                )
                k = k + 8
            end
        end
        __L1:produtos(
            c,
            kind,
            gx,
            gy + 2,
            gw,
            gh - 10,
            i
        )
        R(
            nil,
            c,
            gx,
            gy,
            gw,
            2,
            "#2a2e34"
        )
        R(
            nil,
            c,
            gx,
            gy + gh - 2,
            gw,
            2,
            "#2a2e34"
        )
        R(
            nil,
            c,
            gx - 1,
            gy,
            2,
            gh,
            "#2a2e34"
        )
        R(
            nil,
            c,
            gx + gw - 1,
            gy,
            2,
            gh,
            "#2a2e34"
        )
        local dx = gx + math.floor(gw / 2 + 0.5) - 14
        R(
            nil,
            c,
            dx,
            gy,
            2,
            gh,
            "#2a2e34"
        )
        R(
            nil,
            c,
            dx + 28,
            gy,
            2,
            gh,
            "#2a2e34"
        )
        R(
            nil,
            c,
            dx + 12,
            gy + gh * 0.45,
            2,
            8,
            "#c8ccd0"
        )
        R(
            nil,
            c,
            dx + 16,
            gy + gh * 0.45,
            2,
            8,
            "#c8ccd0"
        )
        __L1:reflexo(
            c,
            gx + 1,
            gy + 2,
            gw - 2,
            gh - 4
        )
        if __gt(
            hash(nil, i + 77),
            0.45
        ) then
            R(
                nil,
                c,
                gx + gw - 22,
                gy + 6,
                16,
                9,
                "#e8433a"
            )
            R(
                nil,
                c,
                gx + gw - 20,
                gy + 8,
                12,
                2,
                "#f2efe6"
            )
            R(
                nil,
                c,
                gx + gw - 20,
                gy + 11,
                8,
                2,
                "#f2efe6"
            )
        end
        R(
            nil,
            c,
            x,
            bot - 2,
            w,
            2,
            "#c8ccd0"
        )
        R(
            nil,
            c,
            x,
            bot - 2,
            w,
            1,
            "#eef0f2"
        )
    end
    __L1.pracaAlimentacao = function(self, c, x0)
        local nomes = 3
        do
            local n = 0
            while n < nomes do
                local x = x0 + n * 130
                local w = 128
                local top = __L1.SHOP.TOP
                local col = __get(
                    __arrL({"#e8833a", "#c43c3a", "#7a3a8a"}, 3),
                    n
                )
                __L1:azulejo(
                    c,
                    x,
                    top,
                    w,
                    96,
                    "#f2efe6",
                    "#e0dcd2"
                )
                R(
                    nil,
                    c,
                    x,
                    top,
                    w,
                    1,
                    "#ffffff"
                )
                R(
                    nil,
                    c,
                    x + 4,
                    top + 3,
                    w - 8,
                    12,
                    "#1c1f24"
                )
                __L1:vgrad(
                    c,
                    x + 5,
                    top + 4,
                    w - 10,
                    10,
                    __L1:shadeHex(col, 1.2),
                    __L1:shadeHex(col, 0.85)
                )
                R(
                    nil,
                    c,
                    x + 5,
                    top + 4,
                    w - 10,
                    1,
                    "#ffffff66"
                )
                R(
                    nil,
                    c,
                    x + 6,
                    top + 18,
                    w - 12,
                    28,
                    "#14161c"
                )
                do
                    local k = 0
                    while k < 4 do
                        local px = x + 9 + k * 29
                        __L1:vgrad(
                            c,
                            px,
                            top + 20,
                            26,
                            18,
                            "#fff4dc",
                            "#f2d8a8"
                        )
                        if n == 0 then
                            ell(
                                nil,
                                c,
                                px + 13,
                                top + 30,
                                9,
                                3,
                                "#c47a35"
                            )
                            R(
                                nil,
                                c,
                                px + 5,
                                top + 28,
                                16,
                                2,
                                "#5ab040"
                            )
                            R(
                                nil,
                                c,
                                px + 5,
                                top + 30,
                                16,
                                2,
                                "#7a3a20"
                            )
                            ell(
                                nil,
                                c,
                                px + 13,
                                top + 26,
                                9,
                                3,
                                "#d89a4a"
                            )
                            R(
                                nil,
                                c,
                                px + 8,
                                top + 24,
                                2,
                                1,
                                "#f6e8c8"
                            )
                        end
                        if n == 1 then
                            ell(
                                nil,
                                c,
                                px + 13,
                                top + 31,
                                10,
                                5,
                                "#e8b85a"
                            )
                            R(
                                nil,
                                c,
                                px + 3,
                                top + 31,
                                20,
                                4,
                                "#f2d898"
                            )
                            do
                                local j = 0
                                while j < 4 do
                                    R(
                                        nil,
                                        c,
                                        px + 6 + j * 4,
                                        top + 30,
                                        2,
                                        1,
                                        "#c8883a"
                                    )
                                    j = j + 1
                                end
                            end
                        end
                        if n == 2 then
                            ell(
                                nil,
                                c,
                                px + 13,
                                top + 31,
                                9,
                                5,
                                "#7a2a6a"
                            )
                            R(
                                nil,
                                c,
                                px + 4,
                                top + 31,
                                18,
                                4,
                                "#5a1a4a"
                            )
                            do
                                local j = 0
                                while j < 5 do
                                    R(
                                        nil,
                                        c,
                                        px + 6 + j * 3,
                                        top + 27 + __mod(j, 2),
                                        2,
                                        2,
                                        __L1:pick(
                                            __arrL({"#e8c24c", "#f2efe6", "#d9634a"}, 3),
                                            j + k
                                        )
                                    )
                                    j = j + 1
                                end
                            end
                        end
                        R(
                            nil,
                            c,
                            px + 2,
                            top + 39,
                            22,
                            4,
                            "#f2c94c"
                        )
                        R(
                            nil,
                            c,
                            px + 4,
                            top + 40,
                            10,
                            2,
                            "#2a2a2a"
                        )
                        k = k + 1
                    end
                end
                R(
                    nil,
                    c,
                    x + 30,
                    top + 52,
                    12,
                    10,
                    "#efe2d0"
                )
                R(
                    nil,
                    c,
                    x + 28,
                    top + 50,
                    16,
                    3,
                    "#f6f4ee"
                )
                R(
                    nil,
                    c,
                    x + 30,
                    top + 62,
                    12,
                    8,
                    col
                )
                __L1:pessoa(c, x + 80, top + 70, n + 4)
                __L1:vgrad(
                    c,
                    x + 2,
                    top + 66,
                    w - 4,
                    30,
                    "#e2e6ea",
                    "#8a9298"
                )
                R(
                    nil,
                    c,
                    x + 2,
                    top + 66,
                    w - 4,
                    2,
                    "#f6f8fa"
                )
                R(
                    nil,
                    c,
                    x + 2,
                    top + 72,
                    w - 4,
                    3,
                    col
                )
                R(
                    nil,
                    c,
                    x + 2,
                    top + 75,
                    w - 4,
                    1,
                    __L1:shadeHex(col, 0.6)
                )
                do
                    local k = 12
                    while k < w - 4 do
                        R(
                            nil,
                            c,
                            x + k,
                            top + 70,
                            1,
                            26,
                            "rgba(255,255,255,.4)"
                        )
                        k = k + 26
                    end
                end
                R(
                    nil,
                    c,
                    x + 10,
                    top + 62,
                    18,
                    4,
                    "#c8ccd0"
                )
                R(
                    nil,
                    c,
                    x + 12,
                    top + 58,
                    4,
                    4,
                    "#3c8a5a"
                )
                R(
                    nil,
                    c,
                    x + 100,
                    top + 58,
                    10,
                    8,
                    "#2a2a2a"
                )
                R(
                    nil,
                    c,
                    x + 101,
                    top + 59,
                    8,
                    4,
                    "#5ae070"
                )
                n = n + 1
            end
        end
    end
    __L1.cinemaFrente = function(self, c, x, w)
        local top = __L1.SHOP.TOP
        R(
            nil,
            c,
            x,
            top,
            w,
            96,
            "#231b29"
        )
        do
            local k = 0
            while __lt(k, w) do
                R(
                    nil,
                    c,
                    x + k,
                    top,
                    1,
                    96,
                    "#2e2434"
                )
                R(
                    nil,
                    c,
                    x + k + 7,
                    top + 30,
                    1,
                    66,
                    "#1c1622"
                )
                k = k + 14
            end
        end
        R(
            nil,
            c,
            x + 6,
            top + 2,
            w - 12,
            24,
            "#c8a24a"
        )
        R(
            nil,
            c,
            x + 8,
            top + 4,
            w - 16,
            20,
            "#140f18"
        )
        R(
            nil,
            c,
            x + 6,
            top + 2,
            w - 12,
            1,
            "#f2d898"
        )
        R(
            nil,
            c,
            x + 6,
            top + 25,
            w - 12,
            1,
            "#8a6a2a"
        )
        do
            local k = 0
            while k < 4 do
                local px = x + 18 + k * 92
                local py = top + 32
                R(
                    nil,
                    c,
                    px - 2,
                    py - 2,
                    62,
                    50,
                    "#c8a24a"
                )
                R(
                    nil,
                    c,
                    px - 2,
                    py - 2,
                    62,
                    1,
                    "#f2d898"
                )
                local pc = __get(
                    __arrL({"#2c4a8a", "#8a2a2a", "#2a6a4a", "#c46a2a"}, 4),
                    k
                )
                __L1:vgrad(
                    c,
                    px,
                    py,
                    58,
                    46,
                    __L1:shadeHex(pc, 1.5),
                    __L1:shadeHex(pc, 0.55)
                )
                ell(
                    nil,
                    c,
                    px + 29,
                    py + 14,
                    10,
                    10,
                    __L1:shadeHex(pc, 1.9)
                )
                R(
                    nil,
                    c,
                    px + 18,
                    py + 22,
                    22,
                    18,
                    "#14101a"
                )
                ell(
                    nil,
                    c,
                    px + 29,
                    py + 20,
                    6,
                    6,
                    "#14101a"
                )
                R(
                    nil,
                    c,
                    px + 10,
                    py + 34,
                    8,
                    8,
                    "#14101a"
                )
                R(
                    nil,
                    c,
                    px + 42,
                    py + 30,
                    6,
                    12,
                    "#14101a"
                )
                R(
                    nil,
                    c,
                    px + 4,
                    py + 38,
                    50,
                    6,
                    "rgba(0,0,0,.55)"
                )
                R(
                    nil,
                    c,
                    px + 8,
                    py + 39,
                    42,
                    2,
                    "#f2efe6"
                )
                R(
                    nil,
                    c,
                    px + 14,
                    py + 42,
                    30,
                    1,
                    "#c8c4bc"
                )
                R(
                    nil,
                    c,
                    px,
                    py,
                    58,
                    10,
                    "rgba(255,255,255,.08)"
                )
                k = k + 1
            end
        end
        local ex = x + 150
        R(
            nil,
            c,
            ex,
            top + 84,
            80,
            12,
            "#a82a2a"
        )
        R(
            nil,
            c,
            ex,
            top + 84,
            80,
            1,
            "#d84a4a"
        )
        for ____, sx in __iterar((__arrL({ex - 6, ex + 84}, 2))) do
            R(
                nil,
                c,
                sx,
                top + 74,
                2,
                22,
                "#c8a24a"
            )
            ell(
                nil,
                c,
                sx + 1,
                top + 73,
                2,
                2,
                "#f2d898"
            )
        end
        do
            local k = 0
            while k < 20 do
                R(
                    nil,
                    c,
                    ex - 4 + k * 4.5,
                    top + 77 + math.floor(math.sin(k / 19 * math.pi) * 3 + 0.5),
                    3,
                    2,
                    "#c43c3a"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            x + 4,
            top + 82,
            26,
            14,
            "#3a2e40"
        )
        R(
            nil,
            c,
            x + 6,
            top + 84,
            22,
            8,
            "#d8eef4"
        )
        R(
            nil,
            c,
            x + 12,
            top + 86,
            8,
            6,
            "#f0c8a8"
        )
    end
    __L1.lanFrente = function(self, c, x, w)
        local top = __L1.SHOP.TOP
        R(
            nil,
            c,
            x,
            top,
            w,
            96,
            "#1a1d26"
        )
        __L1:vgrad(
            c,
            x + 6,
            top + 24,
            w - 12,
            70,
            "#151820",
            "#24283a"
        )
        R(
            nil,
            c,
            x + 4,
            top + 3,
            w - 8,
            16,
            "#0e1016"
        )
        R(
            nil,
            c,
            x + 4,
            top + 3,
            w - 8,
            1,
            "#5ae0d0"
        )
        R(
            nil,
            c,
            x + 4,
            top + 18,
            w - 8,
            1,
            "#e05a8a"
        )
        do
            local k = 0
            while k < 6 do
                local px = x + 14 + k * 58
                R(
                    nil,
                    c,
                    px,
                    top + 42,
                    40,
                    26,
                    "#0c0e14"
                )
                R(
                    nil,
                    c,
                    px + 2,
                    top + 44,
                    36,
                    22,
                    "#2a2c38"
                )
                R(
                    nil,
                    c,
                    px + 18,
                    top + 68,
                    4,
                    6,
                    "#3a3c48"
                )
                R(
                    nil,
                    c,
                    px - 2,
                    top + 74,
                    44,
                    3,
                    "#3a3c48"
                )
                R(
                    nil,
                    c,
                    px - 2,
                    top + 74,
                    44,
                    1,
                    "#5a5c68"
                )
                R(
                    nil,
                    c,
                    px + 4,
                    top + 72,
                    10,
                    2,
                    "#1e1e24"
                )
                R(
                    nil,
                    c,
                    px + 8,
                    top + 80,
                    22,
                    14,
                    "#c43c3a"
                )
                R(
                    nil,
                    c,
                    px + 10,
                    top + 70,
                    18,
                    12,
                    "#c43c3a"
                )
                R(
                    nil,
                    c,
                    px + 12,
                    top + 72,
                    14,
                    2,
                    "#2a2a2a"
                )
                R(
                    nil,
                    c,
                    px + 8,
                    top + 80,
                    2,
                    14,
                    "#8a2a2a"
                )
                __L1:pessoa(c, px + 15, top + 82, k + 2)
                k = k + 1
            end
        end
        do
            local k = 0
            while k < 3 do
                local px = __add(x, w) - 54 + __mod(k, 2) * 22
                local py = top + 26 + math.floor(k / 2) * 0 + k * 4
                R(
                    nil,
                    c,
                    px,
                    py,
                    18,
                    12,
                    __L1:pick(
                        __arrL({"#7a3a8a", "#c43c3a", "#2c5a9e"}, 3),
                        k
                    )
                )
                R(
                    nil,
                    c,
                    px + 2,
                    py + 2,
                    14,
                    4,
                    "#f2efe6"
                )
                k = k + 1
            end
        end
        __L1:reflexo(
            c,
            x + 6,
            top + 24,
            w - 12,
            70
        )
        R(
            nil,
            c,
            x + 6,
            top + 24,
            w - 12,
            1,
            "#5ae0d0"
        )
        R(
            nil,
            c,
            x + 6,
            top + 93,
            w - 12,
            1,
            "#e05a8a"
        )
    end
    __L1.paredeMarmore = function(self, c, x, w)
        local top = 11
        __L1:vgrad(
            c,
            x,
            top,
            w,
            199,
            "#ece6da",
            "#ddd5c6"
        )
        do
            local y = top + 30
            while y < 210 do
                R(
                    nil,
                    c,
                    x,
                    y,
                    w,
                    1,
                    "#cbc3b2"
                )
                y = y + 40
            end
        end
        do
            local k = 0
            while k < w * 2 do
                local vx = x + hash(nil, k + x) * w
                local vy = top + hash(nil, k * 3 + x) * 199
                R(
                    nil,
                    c,
                    vx,
                    vy,
                    3,
                    1,
                    "rgba(160,150,135,.35)"
                )
                k = k + 1
            end
        end
    end
    __L1.buildShop = function(self)
        local W = __L1.SHOP.W
        local cv, c = table.unpack(
            mk(nil, W, LH),
            1,
            2
        )
        local TOP = __L1.SHOP.TOP
        local MZ = __L1.SHOP.MZ
        __L1:paredeMarmore(c, __L1.SHOP.ESC, 120)
        __L1:paredeMarmore(c, __L1.SHOP.ELEV - 8, 132)
        c:clearRect(__L1.SHOP.ESC, 11, 120, MZ - 27)
        c:clearRect(__L1.SHOP.ELEV - 8, 11, 132, MZ - 27)
        R(
            nil,
            c,
            __L1.SHOP.ESC + 14,
            TOP + 8,
            46,
            30,
            "#1c1f24"
        )
        __L1:vgrad(
            c,
            __L1.SHOP.ESC + 16,
            TOP + 10,
            42,
            26,
            "#5ab8e8",
            "#2c5a9e"
        )
        R(
            nil,
            c,
            __L1.SHOP.ESC + 20,
            TOP + 14,
            34,
            3,
            "#f2efe6"
        )
        R(
            nil,
            c,
            __L1.SHOP.ESC + 20,
            TOP + 20,
            24,
            2,
            "#f2c94c"
        )
        R(
            nil,
            c,
            __L1.SHOP.ESC + 20,
            TOP + 26,
            30,
            2,
            "#f2efe6"
        )
        __call(
            __arrL(
                {
                    __arrL({"MODA", 0}, 2),
                    __arrL({"GAMES", 150}, 2),
                    __arrL({"TÊNIS", 300}, 2),
                    __arrL({"PERFUMES", 450}, 2)
                },
                4
            ),
            "forEach",
            function(____, ____bindingPattern0, i)
                local x
                local k
                k = ____bindingPattern0[1]
                x = ____bindingPattern0[2]
                return __L1:lojaFrente(
                    c,
                    x + 2,
                    146,
                    k,
                    i
                )
            end
        )
        __L1:pracaAlimentacao(c, __L1.SHOP.FOOD)
        __L1:cinemaFrente(c, __L1.SHOP.CINE, 380)
        __L1:lanFrente(c, __L1.SHOP.LAN, 370)
        __call(
            __arrL(
                {
                    __arrL({"LIVROS", 2014}, 2),
                    __arrL({"BRINQUEDOS", 2164}, 2)
                },
                2
            ),
            "forEach",
            function(____, ____bindingPattern0, i)
                local x
                local k
                k = ____bindingPattern0[1]
                x = ____bindingPattern0[2]
                return __L1:lojaFrente(
                    c,
                    x + 2,
                    146,
                    k,
                    i + 4
                )
            end
        )
        __L1:paredeMarmore(c, 2316, 84)
        c:clearRect(2316, 11, 84, MZ - 27)
        local mx = 2326
        R(
            nil,
            c,
            mx,
            150,
            32,
            60,
            "#d84a7a"
        )
        R(
            nil,
            c,
            mx,
            150,
            32,
            2,
            "#f08ab0"
        )
        R(
            nil,
            c,
            mx + 3,
            154,
            26,
            28,
            "#cfeaf2"
        )
        do
            local k = 0
            while k < 7 do
                ell(
                    nil,
                    c,
                    mx + 7 + __mod(k, 4) * 6,
                    178 - math.floor(k / 4) * 6,
                    3,
                    3,
                    __L1:pick(
                        __arrL({
                            "#f2c94c",
                            "#3c9ad8",
                            "#e8433a",
                            "#7ac85a",
                            "#c86ab8"
                        }, 5),
                        k
                    )
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            mx + 3,
            154,
            26,
            8,
            "rgba(255,255,255,.25)"
        )
        R(
            nil,
            c,
            mx + 4,
            186,
            24,
            16,
            "#b83a64"
        )
        R(
            nil,
            c,
            mx + 8,
            190,
            6,
            4,
            "#f2c94c"
        )
        ell(
            nil,
            c,
            mx + 22,
            192,
            3,
            3,
            "#c43c3a"
        )
        local kx = 2364
        R(
            nil,
            c,
            kx,
            196,
            30,
            12,
            "#2c5a9e"
        )
        __L1:vgrad(
            c,
            kx + 4,
            180,
            22,
            18,
            "#5ab8e8",
            "#3c8ad8"
        )
        R(
            nil,
            c,
            kx + 6,
            182,
            16,
            6,
            "#d8f0f8"
        )
        ell(
            nil,
            c,
            kx + 6,
            208,
            3,
            3,
            "#1c1c1c"
        )
        ell(
            nil,
            c,
            kx + 24,
            208,
            3,
            3,
            "#1c1c1c"
        )
        R(
            nil,
            c,
            kx + 2,
            194,
            26,
            2,
            "#f2c94c"
        )
        do
            local x0 = __L1.SHOP.ESC + 6
            local y0 = 210
            local x1 = __L1.SHOP.ESC + 112
            local y1 = MZ
            c.fillStyle = "rgba(185,222,234,.45)"
            c:beginPath()
            c:moveTo(x0, y0)
            c:lineTo(x1, y1)
            c:lineTo(x1, y1 + 16)
            c:lineTo(x0 + 10, y0)
            c:closePath()
            __call(c, "fill")
            do
                local k = 0
                while k <= 52 do
                    local u = k / 52
                    local sx = x0 + (x1 - x0) * u
                    local sy = y0 - (y0 - y1) * u
                    R(
                        nil,
                        c,
                        sx,
                        sy,
                        4,
                        3,
                        "#c4ccd2"
                    )
                    R(
                        nil,
                        c,
                        sx,
                        sy + 3,
                        4,
                        2,
                        "#7a848c"
                    )
                    k = k + 1
                end
            end
            limb(
                nil,
                c,
                __arrL(
                    {
                        __arrL({x0 - 2, y0 - 12}, 2),
                        __arrL({x1, y1 - 12}, 2)
                    },
                    2
                ),
                3,
                "#1e1e22"
            )
            limb(
                nil,
                c,
                __arrL(
                    {
                        __arrL({x0 - 2, y0 - 13}, 2),
                        __arrL({x1, y1 - 13}, 2)
                    },
                    2
                ),
                1,
                "#4a4a52"
            )
            R(
                nil,
                c,
                x0 - 8,
                y0 - 14,
                10,
                14,
                "#8a949a"
            )
            R(
                nil,
                c,
                x0 - 8,
                y0 - 14,
                10,
                2,
                "#c8ccd0"
            )
        end
        do
            local ex = __L1.SHOP.ELEV
            R(
                nil,
                c,
                ex,
                11,
                40,
                199,
                "rgba(180,220,232,.32)"
            )
            R(
                nil,
                c,
                ex,
                11,
                3,
                199,
                "#8a96a0"
            )
            R(
                nil,
                c,
                ex + 37,
                11,
                3,
                199,
                "#8a96a0"
            )
            R(
                nil,
                c,
                ex + 1,
                11,
                1,
                199,
                "#d8e0e4"
            )
            do
                local y = 30
                while y < 210 do
                    R(
                        nil,
                        c,
                        ex,
                        y,
                        40,
                        2,
                        "#9aa6ae"
                    )
                    y = y + 30
                end
            end
            R(
                nil,
                c,
                ex + 19,
                11,
                2,
                199,
                "#5a6066"
            )
        end
        do
            local fx = __L1.SHOP.FONTE + 32
            ell(
                nil,
                c,
                fx,
                207,
                30,
                6,
                "#7a848a"
            )
            ell(
                nil,
                c,
                fx,
                205,
                28,
                5,
                "#e6e0d4"
            )
            ell(
                nil,
                c,
                fx,
                204,
                25,
                4,
                "#4a9ac0"
            )
            ell(
                nil,
                c,
                fx,
                203,
                22,
                3,
                "#8ad0e8"
            )
            R(
                nil,
                c,
                fx - 3,
                186,
                6,
                17,
                "#d8d4c8"
            )
            R(
                nil,
                c,
                fx - 3,
                186,
                2,
                17,
                "#f6f2e8"
            )
            ell(
                nil,
                c,
                fx,
                186,
                8,
                2,
                "#d8d4c8"
            )
        end
        for ____, x in __iterar((__arrL({
            0,
            148,
            298,
            448,
            598,
            718,
            1110,
            1500,
            1630,
            2012,
            2162,
            2312
        }, 12))) do
            __L1:coluna(c, x - 5, 11, MZ - 15)
            __L1:coluna(c, x - 5, TOP, 210)
        end
        R(
            nil,
            c,
            0,
            MZ - 14,
            W,
            14,
            "rgba(188,226,238,.42)"
        )
        do
            local x = 0
            while x < W do
                R(
                    nil,
                    c,
                    x,
                    MZ - 14,
                    2,
                    14,
                    "#9aa6ae"
                )
                R(
                    nil,
                    c,
                    x,
                    MZ - 14,
                    1,
                    14,
                    "#e2e8ec"
                )
                x = x + 24
            end
        end
        do
            local x = 10
            while x < W do
                limb(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x, MZ - 1}, 2),
                            __arrL({x + 10, MZ - 13}, 2)
                        },
                        2
                    ),
                    2,
                    "rgba(255,255,255,.4)"
                )
                x = x + 60
            end
        end
        R(
            nil,
            c,
            0,
            MZ - 17,
            W,
            3,
            "#b8c2c8"
        )
        R(
            nil,
            c,
            0,
            MZ - 17,
            W,
            1,
            "#f6fafc"
        )
        R(
            nil,
            c,
            0,
            MZ - 14,
            W,
            1,
            "#7a868e"
        )
        R(
            nil,
            c,
            0,
            MZ,
            W,
            12,
            "#f6f4ee"
        )
        R(
            nil,
            c,
            0,
            MZ,
            W,
            1,
            "#ffffff"
        )
        R(
            nil,
            c,
            0,
            MZ + 8,
            W,
            1,
            "#dcd8cc"
        )
        R(
            nil,
            c,
            0,
            MZ + 11,
            W,
            1,
            "#a8a294"
        )
        __L1:vgrad(
            c,
            0,
            MZ + 12,
            W,
            6,
            "#aaa496",
            "#d6d0c4"
        )
        do
            local x = 20
            while x < W do
                R(
                    nil,
                    c,
                    x,
                    MZ + 12,
                    6,
                    2,
                    "#fff6d8"
                )
                do
                    local j = 0
                    while j < 4 do
                        R(
                            nil,
                            c,
                            x - j * 2,
                            MZ + 14 + j,
                            6 + j * 4,
                            1,
                            ("rgba(255,246,216," .. tostring(0.35 - j * 0.08)) .. ")"
                        )
                        j = j + 1
                    end
                end
                x = x + 50
            end
        end
        __L1:vgrad(
            c,
            0,
            0,
            W,
            9,
            "#f6f2ea",
            "#d6d0c4"
        )
        R(
            nil,
            c,
            0,
            9,
            W,
            2,
            "#8a8478"
        )
        do
            local x = 12
            while x < W do
                R(
                    nil,
                    c,
                    x,
                    3,
                    8,
                    4,
                    "#5a564e"
                )
                R(
                    nil,
                    c,
                    x + 1,
                    5,
                    6,
                    2,
                    "#fff6d8"
                )
                x = x + 40
            end
        end
        R(
            nil,
            c,
            0,
            210,
            W,
            3,
            "#6f6a60"
        )
        R(
            nil,
            c,
            0,
            210,
            W,
            1,
            "#a8a294"
        )
        __L1:vgrad(
            c,
            0,
            213,
            W,
            LH - 213,
            "#f2ede2",
            "#ddd6c8"
        )
        local rows = __arrL({
            213,
            218,
            224,
            232,
            243,
            257,
            270
        }, 7)
        do
            local r = 1
            while r < __len(rows) do
                R(
                    nil,
                    c,
                    0,
                    __get(rows, r),
                    W,
                    1,
                    "#cdc5b4"
                )
                local step = 26 + r * 10
                do
                    local x = __mod(r, 2) * step / 2
                    while x < W do
                        R(
                            nil,
                            c,
                            x,
                            __get(rows, r - 1) + 1,
                            1,
                            __get(rows, r) - __get(rows, r - 1) - 1,
                            "#d6cfbf"
                        )
                        x = x + step
                    end
                end
                r = r + 1
            end
        end
        do
            local i = 0
            while i < W / 4 do
                local vx = hash(nil, i * 1.7) * W
                local vy = 216 + hash(nil, i * 2.9) * 50
                limb(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({vx, vy}, 2),
                            __arrL(
                                {
                                    vx + 4 + hash(nil, i) * 6,
                                    vy + hash(nil, i * 5) * 3 - 1
                                },
                                2
                            )
                        },
                        2
                    ),
                    1,
                    "rgba(150,140,125,.28)"
                )
                i = i + 1
            end
        end
        do
            local H = LH - 213
            local tmp, tc = table.unpack(
                mk(nil, W, H),
                1,
                2
            )
            tc:drawImage(
                cv,
                0,
                210 - H,
                W,
                H,
                0,
                0,
                W,
                H
            )
            c:save()
            c.globalAlpha = 0.15
            c:translate(0, 213 + H)
            c:scale(1, -1)
            c:drawImage(tmp, 0, 0)
            c:restore()
            do
                local k = 0
                while k < H do
                    R(
                        nil,
                        c,
                        0,
                        213 + k,
                        W,
                        1,
                        ("rgba(238,233,222," .. tostring(k / H * 0.55)) .. ")"
                    )
                    k = k + 1
                end
            end
        end
        __L1.OBJ:pisoMolhado(c, 586, 0)
        return cv
    end
    __L1.shopping = function(self, c, s, t, camL)
        if not __t(__L1.shopMid) then
            __L1.shopMid = __L1:buildShop()
        end
        if not __t(__L1.SHOPFAR) then
            __L1.SHOPFAR = __L1:buildShopFar()
        end
        sky(
            nil,
            c,
            s,
            t,
            camL
        )
        tile(nil, c, __L1.SHOPFAR, camL * 0.4)
        if s.sunT ~= nil then
            local a = 0.08 * (1 - s.night)
            c.fillStyle = ("rgba(255,246,214," .. tostring(a)) .. ")"
            do
                local x = __L1:wrap(
                    __TS__Number(-camL) * 0.4,
                    128
                ) - 128
                while __lt(x, LW + 128) do
                    c:beginPath()
                    c:moveTo(x, 14)
                    c:lineTo(x + 40, 14)
                    c:lineTo(x + 90, 96)
                    c:lineTo(x + 30, 96)
                    c:closePath()
                    __call(c, "fill")
                    x = x + 128
                end
            end
        end
        do
            local i = 0
            while i < 11 do
                local wx = 30 + i * 220 + math.sin(t * 0.2 + i * 1.3) * 80
                local sx = wx - camL
                if __t(__L1:vis(sx, 20)) then
                    __L1:pessoa(c, sx, __L1.SHOP.MZ, i + 3)
                end
                i = i + 1
            end
        end
        do
            local x = 60
            while x < __L1.SHOP.W do
                local sx = x - camL
                local sw = math.floor(math.sin(t * 1.1 + x) * 1 + 0.5)
                if not __t(__L1:vis(sx, 40)) then
                    continue
                end
                R(
                    nil,
                    c,
                    sx + 8,
                    11,
                    1,
                    6,
                    "#5a6066"
                )
                R(
                    nil,
                    c,
                    sx + 26,
                    11,
                    1,
                    6,
                    "#5a6066"
                )
                __L1:vgrad(
                    c,
                    sx + 4 + sw,
                    17,
                    28,
                    44,
                    "#3c6ab0",
                    "#1d3a70"
                )
                R(
                    nil,
                    c,
                    sx + 4 + sw,
                    17,
                    28,
                    2,
                    "#7aa0d8"
                )
                do
                    local k = 0
                    while k < 4 do
                        R(
                            nil,
                            c,
                            sx + 5 + k * 7 + sw,
                            61,
                            5,
                            3 + __mod(k, 2) * 2,
                            "#1d3a70"
                        )
                        k = k + 1
                    end
                end
                do
                    local k = 0
                    while k < 3 do
                        local fy = 26 + k * 9
                        R(
                            nil,
                            c,
                            sx + 17 + sw,
                            fy,
                            2,
                            6,
                            "#f2f6fa"
                        )
                        R(
                            nil,
                            c,
                            sx + 15 + sw,
                            fy + 2,
                            6,
                            2,
                            "#f2f6fa"
                        )
                        k = k + 1
                    end
                end
                R(
                    nil,
                    c,
                    sx + 8 + sw,
                    55,
                    20,
                    2,
                    "#f2c94c"
                )
                x = x + 300
            end
        end
        do
            local x = 210
            while x < __L1.SHOP.W do
                local sx = x - camL + math.sin(t * 0.9 + x) * 1.5
                if not __t(__L1:vis(sx, 20)) then
                    continue
                end
                R(
                    nil,
                    c,
                    sx,
                    11,
                    1,
                    22,
                    "#5a6066"
                )
                R(
                    nil,
                    c,
                    sx - 6,
                    33,
                    13,
                    7,
                    "#b86a3a"
                )
                R(
                    nil,
                    c,
                    sx - 6,
                    33,
                    13,
                    2,
                    "#d88a4a"
                )
                do
                    local k = 0
                    while k < 7 do
                        R(
                            nil,
                            c,
                            sx - 7 + k * 2,
                            40 + __mod(k, 3) * 2,
                            2,
                            5 + __mod(k, 2) * 6,
                            if __t(__mod(k, 2)) then "#3f7a3c" else "#5f9a46"
                        )
                        k = k + 1
                    end
                end
                x = x + 300
            end
        end
        c:drawImage(
            __L1.shopMid,
            camL,
            0,
            LW,
            LH,
            0,
            0,
            LW,
            LH
        )
        do
            local x = __L1.SHOP.ELEV - camL
            if __t(__L1:vis(x, 60)) then
                local u = (math.sin(t * 0.35) + 1) / 2
                local y = 62 + u * 116
                R(
                    nil,
                    c,
                    x + 3,
                    y,
                    34,
                    32,
                    "rgba(206,236,246,.7)"
                )
                R(
                    nil,
                    c,
                    x + 3,
                    y,
                    34,
                    2,
                    "#c8ccce"
                )
                R(
                    nil,
                    c,
                    x + 3,
                    y + 30,
                    34,
                    2,
                    "#7a848c"
                )
                R(
                    nil,
                    c,
                    x + 3,
                    y,
                    2,
                    32,
                    "#9aa6ae"
                )
                R(
                    nil,
                    c,
                    x + 35,
                    y,
                    2,
                    32,
                    "#9aa6ae"
                )
                __L1:pessoa(c, x + 9, y + 30, 4)
                __L1:pessoa(c, x + 22, y + 30, 7)
                R(
                    nil,
                    c,
                    x + 19,
                    11,
                    2,
                    y - 11,
                    "#2a2a2a"
                )
            end
        end
        do
            local x0 = __L1.SHOP.ESC + 6
            local x1 = __L1.SHOP.ESC + 112
            local y0 = 210
            local y1 = __L1.SHOP.MZ
            do
                local k = 0
                while k < 26 do
                    local u = __mod(t * 0.16 + k / 26, 1)
                    local x = x0 + (x1 - x0) * u - camL
                    local y = y0 - (y0 - y1) * u
                    if __t(__L1:vis(x, 10)) then
                        R(
                            nil,
                            c,
                            x,
                            y - 1,
                            4,
                            1,
                            "#eef2f4"
                        )
                    end
                    k = k + 1
                end
            end
            do
                local i = 0
                while i < 2 do
                    local u = __mod(t * 0.16 + i * 0.5, 1)
                    local x = x0 + 4 + (x1 - x0) * u - camL
                    local y = y0 - 2 - (y0 - y1) * u
                    if __t(__L1:vis(x, 10)) then
                        __L1:pessoa(c, x, y, i + 5)
                    end
                    i = i + 1
                end
            end
        end
        do
            local fx = __L1.SHOP.FONTE + 32 - camL
            if __t(__L1:vis(fx, 40)) then
                do
                    local j = 0
                    while j < 5 do
                        local a = (j - 2) / 2
                        do
                            local k = 0
                            while k < 11 do
                                local u = k / 10
                                local px = fx + a * 20 * u
                                local py = 186 - math.sin(u * math.pi) * (14 - math.abs(a) * 4) + u * 17
                                R(
                                    nil,
                                    c,
                                    px,
                                    py,
                                    1,
                                    2,
                                    if __t(__mod(
                                        k + math.floor(t * 8),
                                        3
                                    )) then "#bfe8f0" else "#ffffff"
                                )
                                k = k + 1
                            end
                        end
                        j = j + 1
                    end
                end
            end
        end
        do
            local x = __L1.SHOP.CINE + 6 - camL
            local y = __L1.SHOP.TOP + 2
            if __t(__L1:vis(x, 380)) then
                do
                    local k = 0
                    while k < 368 do
                        local on = __mod(
                            math.floor(t * 6) + k / 6,
                            4
                        ) ~= 0
                        R(
                            nil,
                            c,
                            x + k,
                            y,
                            2,
                            2,
                            if __t(on) then "#fff2b0" else "#7a5a2a"
                        )
                        R(
                            nil,
                            c,
                            x + k,
                            y + 22,
                            2,
                            2,
                            if __t(on) then "#fff2b0" else "#7a5a2a"
                        )
                        k = k + 6
                    end
                end
            end
        end
        do
            local i = 0
            while i < 5 do
                local sx = __L1.SHOP.CINE + 40 + i * 13 - camL
                if __t(__L1:vis(sx, 20)) then
                    __L1:pessoa(c, sx, 210, i + 1)
                end
                i = i + 1
            end
        end
        do
            local lx = __L1.SHOP.LAN - camL
            if __t(__L1:vis(lx, 380)) then
                do
                    local k = 0
                    while k < 6 do
                        local px = lx + 16 + k * 58
                        R(
                            nil,
                            c,
                            px,
                            __L1.SHOP.TOP + 44,
                            36,
                            22,
                            __get(
                                __arrL({"#3c8ae0", "#5ae070", "#e05a8a", "#f2c94c"}, 4),
                                __mod(
                                    k + math.floor(t * 1.4),
                                    4
                                )
                            )
                        )
                        R(
                            nil,
                            c,
                            px + 2 + __mod(
                                math.floor(t * 9 + k * 3),
                                28
                            ),
                            __L1.SHOP.TOP + 54,
                            4,
                            4,
                            "#f2f2ee"
                        )
                        R(
                            nil,
                            c,
                            px + 4,
                            __L1.SHOP.TOP + 60,
                            28,
                            2,
                            "rgba(0,0,0,.25)"
                        )
                        k = k + 1
                    end
                end
                local hue = __mod(
                    math.floor(t * 3),
                    3
                )
                R(
                    nil,
                    c,
                    lx + 4,
                    __L1.SHOP.TOP + 3,
                    362,
                    1,
                    __get(
                        __arrL({"#5ae0d0", "#e05a8a", "#f2c94c"}, 3),
                        hue
                    )
                )
                R(
                    nil,
                    c,
                    lx + 4,
                    __L1.SHOP.TOP + 18,
                    362,
                    1,
                    __get(
                        __arrL({"#e05a8a", "#f2c94c", "#5ae0d0"}, 3),
                        hue
                    )
                )
                if __mod(t, 4) < 1.2 then
                    local gx = lx + 22 + __mod(
                        math.floor(t / 4),
                        6
                    ) * 58
                    R(
                        nil,
                        c,
                        gx,
                        __L1.SHOP.TOP + 34 - __mod(t, 4) * 6,
                        22,
                        10,
                        "#f2efe6"
                    )
                    R(
                        nil,
                        c,
                        gx + 2,
                        __L1.SHOP.TOP + 36 - __mod(t, 4) * 6,
                        18,
                        6,
                        "#3c8a5a"
                    )
                end
            end
        end
        do
            local x = 2326 - camL
            if __t(__L1:vis(x, 40)) then
                R(
                    nil,
                    c,
                    x + 2,
                    150,
                    28,
                    2,
                    if math.sin(t * 6) > 0 then "#f2c94c" else "#ffffff"
                )
                local gx = x + 10 + math.sin(t * 0.8) * 8
                R(
                    nil,
                    c,
                    gx,
                    156,
                    2,
                    6 + math.abs(math.sin(t * 0.5)) * 8,
                    "#8a8a86"
                )
                R(
                    nil,
                    c,
                    gx - 2,
                    162 + math.abs(math.sin(t * 0.5)) * 8,
                    6,
                    2,
                    "#8a8a86"
                )
            end
        end
        do
            local x = 2364 - camL
            if __t(__L1:vis(x, 40)) then
                local rock = math.floor(math.sin(t * 4) + 0.5)
                __L1:pessoa(c, x + 10, 196 + rock, 9)
                R(
                    nil,
                    c,
                    x + 2,
                    194,
                    26,
                    2,
                    if math.sin(t * 5) > 0 then "#f2c94c" else "#e05a8a"
                )
            end
        end
        do
            local x = 560 - camL + math.sin(t * 1.5) * 6
            if __t(__L1:vis(x, 30)) then
                __L1:pessoa(c, x, 214, 6)
                limb(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x + 5, 202}, 2),
                            __arrL({x + 13, 213}, 2)
                        },
                        2
                    ),
                    1,
                    "#8a6a45"
                )
                R(
                    nil,
                    c,
                    x + 9,
                    212,
                    10,
                    2,
                    "#5a5a5a"
                )
            end
        end
        do
            local x = 1495 - camL
            if __t(__L1:vis(x, 20)) then
                R(
                    nil,
                    c,
                    x - 1,
                    200,
                    7,
                    9,
                    "#1e1e24"
                )
                __L1:pessoa(c, x, 214, 2)
                R(
                    nil,
                    c,
                    x - 1,
                    200,
                    7,
                    7,
                    "#1e1e24"
                )
                R(
                    nil,
                    c,
                    x,
                    194,
                    5,
                    1,
                    "#1e1e24"
                )
            end
        end
        do
            local i = 0
            while i < 20 do
                local wx = 30 + i * 120 + math.sin(t * 0.35 + i * 2) * 50
                local sx = wx - camL
                if __t(__L1:vis(sx, 20)) then
                    __L1:pessoa(c, sx, 216, i)
                end
                i = i + 1
            end
        end
        do
            local k = 0
            while k < 6 do
                local mx = __L1.SHOP.FOOD + 14 + k * 64 - camL
                if __t(__L1:vis(mx, 30)) then
                    __L1:mesaBar(c, mx)
                    if __mod(k, 2) == 0 then
                        __L1:pessoa(c, mx - 4, 210, k + 2)
                    end
                end
                k = k + 1
            end
        end
    end
    __L1.shoppingLights = function(self, g, s, t, camL)
        do
            local x = 12
            while x < __L1.SHOP.W do
                local sx = x + 4 - camL
                if __t(__L1:vis(sx)) then
                    lightAdd(
                        nil,
                        sx,
                        6,
                        0.22,
                        50
                    )
                end
                x = x + 40
            end
        end
        local lx = __L1.SHOP.LAN - camL
        if __t(__L1:vis(lx, 380)) then
            g.fillStyle = "rgba(90,224,208,.10)"
            g:fillRect(lx, __L1.SHOP.TOP, 370, 96)
        end
        local cx = __L1.SHOP.CINE - camL
        if __t(__L1:vis(cx, 380)) then
            g.fillStyle = "rgba(255,227,154,.10)"
            g:fillRect(cx + 6, __L1.SHOP.TOP + 2, 368, 24)
        end
    end
    __L1.buildOlivia = function(self)
        local cv, c = table.unpack(
            mk(nil, __L1.OLIVIA.W, LH),
            1,
            2
        )
        do
            local i = 0
            local x = 10
            while x < __L1.OLIVIA.SESI - 40 do
                local w = 46 + math.floor(hash(nil, i + 270) * 24 + 0.5)
                __L1:predio(
                    c,
                    x,
                    w,
                    4 + math.floor(hash(nil, i + 271) * 3 + 0.5),
                    __L1:pick(
                        __arrL({"#f2efe6", "#e9e6dc", "#dfe4e6", "#ece4d4"}, 4),
                        i
                    ),
                    270 + i
                )
                x = x + (w + 16)
                i = i + 1
            end
        end
        R(
            nil,
            c,
            0,
            172,
            __L1.OLIVIA.SESI,
            6,
            "#5f8a46"
        )
        R(
            nil,
            c,
            0,
            178,
            __L1.OLIVIA.SESI,
            8,
            "#6f7376"
        )
        do
            local x = 0
            while x < __L1.OLIVIA.SESI do
                R(
                    nil,
                    c,
                    x,
                    181,
                    6,
                    1,
                    "#e8c24c"
                )
                x = x + 12
            end
        end
        R(
            nil,
            c,
            0,
            186,
            __L1.OLIVIA.SESI,
            6,
            "#5f8a46"
        )
        do
            local x = 0
            while x < __L1.OLIVIA.SESI do
                R(
                    nil,
                    c,
                    x + 4,
                    186,
                    2,
                    2,
                    __L1:pick(
                        __arrL({"#e86a7a", "#e8c24c", "#f2efe6"}, 3),
                        x
                    )
                )
                x = x + 40
            end
        end
        for ____, gx in __iterar((__arrL({300, 700}, 2))) do
            R(
                nil,
                c,
                gx,
                190,
                2,
                20,
                "#3c8ad8"
            )
            R(
                nil,
                c,
                gx + 20,
                190,
                2,
                20,
                "#3c8ad8"
            )
            R(
                nil,
                c,
                gx,
                190,
                22,
                2,
                "#3c8ad8"
            )
            R(
                nil,
                c,
                gx + 30,
                196,
                16,
                2,
                "#e8c24c"
            )
            R(
                nil,
                c,
                gx + 36,
                198,
                2,
                12,
                "#e8c24c"
            )
            ell(
                nil,
                c,
                gx + 56,
                202,
                6,
                6,
                "#c43c3a"
            )
            R(
                nil,
                c,
                gx + 55,
                196,
                2,
                14,
                "#c43c3a"
            )
        end
        local sx = __L1.OLIVIA.SESI
        __L1:plaster(
            c,
            sx,
            150,
            __L1.OLIVIA.W - sx,
            60,
            "#f2f2ee",
            1250
        )
        R(
            nil,
            c,
            sx,
            150,
            __L1.OLIVIA.W - sx,
            3,
            "#2c5a9e"
        )
        __L1:plaster(
            c,
            sx + 20,
            96,
            200,
            54,
            "#f2f2ee",
            1251
        )
        R(
            nil,
            c,
            sx + 20,
            96,
            200,
            6,
            "#2c5a9e"
        )
        do
            local k = 0
            while k < 6 do
                __L1:janela(
                    c,
                    sx + 30 + k * 32,
                    110,
                    20,
                    14,
                    "vidro",
                    1251 + k
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            sx + 30,
            128,
            40,
            20,
            "#c43c3a"
        )
        do
            local k = 0
            while k < 2 do
                R(
                    nil,
                    c,
                    sx + 230 + k * 20,
                    60,
                    2,
                    92,
                    "#8a8a86"
                )
                R(
                    nil,
                    c,
                    sx + 232 + k * 20,
                    62,
                    14,
                    9,
                    if __t(k) then "#2c8a3a" else "#2c8a3a"
                )
                R(
                    nil,
                    c,
                    sx + 236 + k * 20,
                    64,
                    6,
                    5,
                    if __t(k) then "#c43c3a" else "#e8c24c"
                )
                k = k + 1
            end
        end
        local q = sx + 300
        do
            local k = 0
            while k <= 280 do
                local h = math.floor(math.sin(k / 280 * math.pi) * 30 + 0.5)
                R(
                    nil,
                    c,
                    q + k,
                    90 - h,
                    1,
                    3,
                    "#9aa4ac"
                )
                if __mod(k, 20) == 0 then
                    limb(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({q + k, 90 - h}, 2),
                                __arrL({q + k, 92}, 2)
                            },
                            2
                        ),
                        1,
                        "#9aa4ac"
                    )
                end
                k = k + 1
            end
        end
        do
            local k = 0
            while k <= 280 do
                R(
                    nil,
                    c,
                    q + k,
                    90,
                    3,
                    120,
                    "#7a848c"
                )
                k = k + 40
            end
        end
        R(
            nil,
            c,
            q,
            160,
            280,
            50,
            "#3c7a5a"
        )
        R(
            nil,
            c,
            q + 10,
            162,
            260,
            2,
            "#f2f2ee"
        )
        R(
            nil,
            c,
            q + 139,
            162,
            2,
            48,
            "#f2f2ee"
        )
        ell(
            nil,
            c,
            q + 140,
            186,
            16,
            10,
            "#f2f2ee"
        )
        ell(
            nil,
            c,
            q + 140,
            186,
            14,
            8,
            "#3c7a5a"
        )
        for ____, hx in __iterar((__arrL({q + 4, q + 268}, 2))) do
            R(
                nil,
                c,
                hx,
                136,
                3,
                30,
                "#c43c3a"
            )
            R(
                nil,
                c,
                hx - 4,
                136,
                12,
                9,
                "#f2f2ee"
            )
            R(
                nil,
                c,
                hx - 2,
                145,
                8,
                3,
                "#e86a3a"
            )
        end
        local ad = sx + 650
        __L1:plaster(
            c,
            ad,
            110,
            180,
            100,
            "#e8e4dc",
            1900
        )
        R(
            nil,
            c,
            ad,
            110,
            180,
            6,
            "#2c5a9e"
        )
        R(
            nil,
            c,
            ad + 70,
            150,
            40,
            60,
            "#5a3c2a"
        )
        do
            local k = 0
            while k < 3 do
                __L1:janela(
                    c,
                    ad + 10 + k * 60,
                    122,
                    30,
                    16,
                    "vidro",
                    1900 + k
                )
                k = k + 1
            end
        end
        __L1:grafite(
            c,
            ad + 6,
            160,
            56,
            40,
            1910
        )
        local lab = sx + 880
        __L1:plaster(
            c,
            lab,
            110,
            220,
            100,
            "#f2f2ee",
            2130
        )
        R(
            nil,
            c,
            lab,
            110,
            220,
            6,
            "#2c5a9e"
        )
        do
            local k = 0
            while k < 5 do
                R(
                    nil,
                    c,
                    lab + 10 + k * 42,
                    124,
                    34,
                    26,
                    "#2c3a44"
                )
                R(
                    nil,
                    c,
                    lab + 12 + k * 42,
                    126,
                    30,
                    22,
                    "#9fc4d0"
                )
                R(
                    nil,
                    c,
                    lab + 18 + k * 42,
                    134,
                    10,
                    8,
                    "#3c8ae0"
                )
                R(
                    nil,
                    c,
                    lab + 30 + k * 42,
                    134,
                    10,
                    8,
                    "#3c8ae0"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            lab + 20,
            160,
            70,
            40,
            "#5a4a34"
        )
        R(
            nil,
            c,
            lab + 22,
            162,
            66,
            36,
            "#c4a46a"
        )
        do
            local k = 0
            while k < 6 do
                __L1:cartaz(
                    c,
                    lab + 25 + __mod(k, 3) * 20,
                    164 + math.floor(k / 3) * 17,
                    2140 + k
                )
                k = k + 1
            end
        end
        do
            local k = 0
            while k < 6 do
                R(
                    nil,
                    c,
                    lab + 120 + k * 14,
                    166,
                    12,
                    44,
                    "#3c6aa8"
                )
                R(
                    nil,
                    c,
                    lab + 121 + k * 14,
                    167,
                    10,
                    20,
                    "#4a7ab8"
                )
                R(
                    nil,
                    c,
                    lab + 128 + k * 14,
                    180,
                    2,
                    3,
                    "#c8c8c4"
                )
                k = k + 1
            end
        end
        do
            local x = sx
            while x < __L1.OLIVIA.W do
                R(
                    nil,
                    c,
                    x,
                    196,
                    1,
                    14,
                    "#2c5a9e"
                )
                x = x + 6
            end
        end
        R(
            nil,
            c,
            sx,
            196,
            __L1.OLIVIA.W - sx,
            1,
            "#2c5a9e"
        )
        do
            local lx = 100
            while lx < __L1.OLIVIA.SESI do
                lampPost(nil, c, lx, 120)
                lx = lx + 220
            end
        end
        __L1:ponto(c, 1100)
        __L1:lixeira(c, 1180)
        __L1:lixeira(c, 1500, "#3c8a5a")
        __L1:bike(c, 1300, "#e8c24c")
        __L1:bike(c, 1324, "#3c8ad8")
        __L1:bike(c, 1348, "#c43c3a")
        __L1:objetos(
            c,
            21,
            __L1.OLIVIA.W,
            "cidade",
            30,
            __L1.OLIVIA.SESI - 20,
            __arrL({90, 170}, 2)
        )
        __L1:calcada(c, __L1.OLIVIA.W, "#d6d0be")
        R(
            nil,
            c,
            0,
            221,
            __L1.OLIVIA.W,
            LH - 221,
            "#d6d0be"
        )
        do
            local x = 0
            while x < __L1.OLIVIA.W do
                R(
                    nil,
                    c,
                    x,
                    221,
                    1,
                    LH - 221,
                    "#bfb8a6"
                )
                x = x + 18
            end
        end
        do
            local y = 234
            while __lt(y, LH) do
                R(
                    nil,
                    c,
                    0,
                    y,
                    __L1.OLIVIA.W,
                    1,
                    "#bfb8a6"
                )
                y = y + 14
            end
        end
        return cv
    end
    __L1.olivia = function(self, c, s, t, camL)
        if not __t(__L1.oliviaMid) then
            __L1.oliviaMid = __L1:buildOlivia()
        end
        __L1:conquistaBack(
            c,
            s,
            t,
            camL,
            {seed = 15}
        )
        __L1:drawMid(
            c,
            __L1.oliviaMid,
            camL,
            s,
            t
        )
        do
            local i = 0
            while i < 6 do
                local dir = if __t(__mod(i, 2)) then 1 else -1
                local wx = __mod(
                    __mod(i * 431 + t * (50 + i * 6) * dir, 2900) + 2900,
                    2900
                ) - 200
                local sx = wx - camL
                local ____t_49 = __t
                local ____t_48 = __t
                local ____temp_47 = __L1:vis(sx, 40)
                __O[400] = ____temp_47
                if ____t_49(if ____t_48(____temp_47) then wx < __L1.OLIVIA.SESI else __O[400]) then
                    __L1:carro(
                        c,
                        sx,
                        if dir > 0 then 172 else 196,
                        __L1:pick(
                            __arrL({"#f2f2ee", "#3c6aa8", "#c43c3a", "#2a2a2a"}, 4),
                            i
                        ),
                        dir
                    )
                end
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 3 do
                local wx = __mod(i * 500 + t * 22, 1300)
                local sx = wx - camL
                local ____t_52 = __t
                local ____t_51 = __t
                local ____temp_50 = __L1:vis(sx, 20)
                __O[401] = ____temp_50
                if ____t_52(if ____t_51(____temp_50) then wx < __L1.OLIVIA.SESI else __O[401]) then
                    ell(
                        nil,
                        c,
                        sx + 1,
                        182,
                        2,
                        2,
                        "#1c1c1c"
                    )
                    ell(
                        nil,
                        c,
                        sx + 10,
                        182,
                        2,
                        2,
                        "#1c1c1c"
                    )
                    R(
                        nil,
                        c,
                        sx + 3,
                        177,
                        6,
                        2,
                        "#c43c3a"
                    )
                    R(
                        nil,
                        c,
                        sx + 5,
                        170,
                        3,
                        7,
                        __L1:pick(
                            __arrL({"#3c6aa8", "#e8c24c", "#3c8a5a"}, 3),
                            i
                        )
                    )
                    R(
                        nil,
                        c,
                        sx + 5,
                        167,
                        3,
                        3,
                        "#e0b08a"
                    )
                end
                i = i + 1
            end
        end
        do
            local x = 40
            while x < __L1.OLIVIA.SESI do
                local sx = x - camL
                if __t(__L1:vis(sx, 60)) then
                    tree(
                        nil,
                        c,
                        sx,
                        178,
                        0.75,
                        1,
                        t,
                        x
                    )
                end
                x = x + 110
            end
        end
        for ____, x in __iterar((__arrL({560, 980}, 2))) do
            local sx = x - camL
            if __t(__L1:vis(sx, 60)) then
                __L1:ipe(
                    c,
                    sx,
                    210,
                    if x == 560 then "#e8c84a" else "#b86ac8",
                    x,
                    0.8
                )
            end
        end
        do
            local i = 0
            while i < 5 do
                local wx = __mod(i * 300 + t * 30, 1250)
                local sx = wx - camL
                if __t(__L1:vis(sx, 20)) then
                    __L1:gente(
                        c,
                        sx,
                        216,
                        i + 4,
                        false
                    )
                    if i == 2 then
                        __L1:cachorro(c, sx + 12, 216, "#f2efe6")
                    end
                end
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 12 do
                local wx = __L1.OLIVIA.SESI + 60 + i * 110 + math.sin(t * 0.4 + i) * 30
                local sx = wx - camL
                if __t(__L1:vis(sx, 20)) then
                    __L1:gente(
                        c,
                        sx,
                        210,
                        i,
                        false
                    )
                    R(
                        nil,
                        c,
                        sx,
                        199,
                        5,
                        2,
                        "#2c5a9e"
                    )
                end
                i = i + 1
            end
        end
        do
            local bx = __L1.OLIVIA.SESI + 440 + math.sin(t * 1.3) * 60 - camL
            local by = 190 - math.abs(math.sin(t * 3)) * 18
            if __t(__L1:vis(bx, 20)) then
                ell(
                    nil,
                    c,
                    bx,
                    by,
                    3,
                    3,
                    "#e8833a"
                )
                R(
                    nil,
                    c,
                    bx - 1,
                    by - 1,
                    1,
                    1,
                    "#2a2a2a"
                )
            end
        end
        __L1:fog(
            c,
            s,
            t,
            camL,
            0.18
        )
    end
    __L1.oliviaLights = function(self, g, s, t, camL)
        local a = __L1:night(s)
        if __lt(a, 0.03) then
            return
        end
        do
            local x = 100
            while x < __L1.OLIVIA.SESI do
                lampGlow(
                    nil,
                    g,
                    x - camL + 1,
                    116,
                    a
                )
                x = x + 220
            end
        end
    end
    __L1.gente = function(self, c, x, y, i, cold)
        if cold == nil then
            cold = true
        end
        local coat = __get(
            __arrL({
                "#3a4a6a",
                "#7a3a3a",
                "#4a6a4a",
                "#5a4a6a",
                "#6a5a3a",
                "#2a3a4a",
                "#8a6a3a"
            }, 7),
            __mod(i, 7)
        )
        local skin = __get(
            __arrL({
                "#e0b08a",
                "#9a6440",
                "#c88a60",
                "#6a4430",
                "#f0c8a8"
            }, 5),
            __mod(i, 5)
        )
        local hair = __get(
            __arrL({
                "#2a201a",
                "#4a3226",
                "#1a1a1a",
                "#6a4a2a",
                "#c8a050"
            }, 5),
            __mod(i, 5)
        )
        R(
            nil,
            c,
            x,
            y - 13,
            6,
            8,
            coat
        )
        R(
            nil,
            c,
            x + 1,
            y - 18,
            4,
            5,
            skin
        )
        R(
            nil,
            c,
            x + 1,
            y - 19,
            4,
            2,
            hair
        )
        R(
            nil,
            c,
            x,
            y - 5,
            2,
            5,
            "#2a2f3a"
        )
        R(
            nil,
            c,
            x + 4,
            y - 5,
            2,
            5,
            "#2a2f3a"
        )
        R(
            nil,
            c,
            x - 1,
            y - 12,
            1,
            6,
            coat
        )
        R(
            nil,
            c,
            x + 6,
            y - 12,
            1,
            6,
            coat
        )
        if __t(cold) then
            R(
                nil,
                c,
                x,
                y - 13,
                6,
                2,
                __get(
                    __arrL({"#d9634a", "#e8c24c", "#5f9fd0", "#f2efe6"}, 4),
                    __mod(i, 4)
                )
            )
            if __mod(i, 3) == 0 then
                R(
                    nil,
                    c,
                    x + 1,
                    y - 21,
                    4,
                    2,
                    __get(
                        __arrL({"#c43c3a", "#3c6aa8", "#e8c24c"}, 3),
                        __mod(i, 3)
                    )
                )
            end
        end
    end
    __L1.objetos = function(self, c, id, W, set, from, to, gap)
        if from == nil then
            from = 30
        end
        if to == nil then
            to = W - 30
        end
        if gap == nil then
            gap = __arrL({70, 150}, 2)
        end
        do
            local x = from
            local i = 0
            while x < to do
                local kind = __L1:pick(
                    __get(__L1.SET, set),
                    id * 31 + i
                )
                __get(__L1.OBJ, kind)(
                    nil,
                    c,
                    math.floor(x + 0.5),
                    id * 17 + i
                )
                x = x + (__get(gap, 0) + hash(nil, id * 13 + i) * (__get(gap, 1) - __get(gap, 0)))
                i = i + 1
            end
        end
    end
    __L1.chaoDetalhe = function(self, c, W, kind)
        local n = W / 9
        do
            local i = 0
            while i < n do
                local x = hash(nil, i * 1.37 + W) * W
                local y = 224 + hash(nil, i * 2.71 + W) * 42
                local r = hash(nil, i * 3.3)
                if kind == "interno" then
                    if __gt(r, 0.85) then
                        R(
                            nil,
                            c,
                            x,
                            y,
                            6,
                            1,
                            "rgba(255,255,255,.35)"
                        )
                    end
                    continue
                end
                if __lt(r, 0.35) then
                    R(
                        nil,
                        c,
                        x,
                        y,
                        3,
                        2,
                        __L1:pick(
                            __arrL({"#c47a35", "#a85a2a", "#d8a24a", "#8a6a3a"}, 4),
                            i
                        )
                    )
                    R(
                        nil,
                        c,
                        x + 1,
                        y - 1,
                        1,
                        1,
                        "#6a4a2a"
                    )
                elseif __t(__lt(r, 0.5) and kind == "cidade") then
                    R(
                        nil,
                        c,
                        x,
                        y,
                        4,
                        3,
                        "#f2efe6"
                    )
                    R(
                        nil,
                        c,
                        x + 1,
                        y + 1,
                        2,
                        1,
                        "#9aa0a6"
                    )
                elseif __lt(r, 0.75) then
                    R(
                        nil,
                        c,
                        x,
                        y,
                        2,
                        1,
                        if kind == "natureza" then "#9a8a6a" else "#8a867c"
                    )
                elseif kind == "natureza" then
                    R(
                        nil,
                        c,
                        x,
                        y,
                        2,
                        2,
                        __L1:pick(
                            __arrL({"#e8c24c", "#f2efe6", "#c86ab8"}, 3),
                            i
                        )
                    )
                end
                i = i + 1
            end
        end
    end
    __L1.sombra = function(self, c, x, y, w)
        c.fillStyle = "rgba(16,22,30,.16)"
        c:fillRect(
            math.floor(x + 10 + 0.5),
            math.floor(y + 24 + 0.5),
            math.floor(w - 20 + 0.5),
            6
        )
    end
    __L1.concretoBase = function(self, c, x, y, w, h, top, face, seed)
        __L1:Q(
            c,
            x - 2,
            y - 2,
            w + 4,
            h + 4,
            "#3a3a38"
        )
        __L1:Q(
            c,
            x,
            y,
            w,
            h,
            face
        )
        __L1:Q(
            c,
            x,
            y,
            w,
            4,
            top
        )
        __L1:Q(
            c,
            x,
            y + 4,
            w,
            2,
            "#ffffff22"
        )
        do
            local i = 0
            while i < w * h / 26 do
                __L1:Q(
                    c,
                    x + hash(nil, i + seed) * w,
                    y + 6 + hash(nil, i * 3 + seed) * (h - 8),
                    2,
                    2,
                    if __t(__mod(i, 2)) then __L1:shadeHex(face, 0.9) else __L1:shadeHex(face, 1.06)
                )
                i = i + 1
            end
        end
        __L1:Q(
            c,
            x,
            __add(y, h) - 2,
            w,
            2,
            __L1:shadeHex(face, 0.75)
        )
    end
    __L1.ilhaTerra = function(self, c, x, y, w, t, sd, o)
        __L1:sombra(c, x, y, w)
        local function depthAt(____, k)
            local u = k / w
            return 14 + math.sin(u * math.pi) * 16 + math.sin(u * 7 + sd) * 3 + if __gt(
                hash(
                    nil,
                    math.floor(k / 14) + sd
                ),
                0.6
            ) then 5 * math.sin(__mod(k, 14) / 14 * math.pi) else 0
        end
        local light = __L1:shadeHex(o.soil, 1.18)
        local strata = __L1:shadeHex(o.soil, 0.82)
        do
            local k = 0
            while __lt(k, w) do
                local d = math.floor(depthAt(nil, k) / 2 + 0.5) * 2
                __L1:Q(
                    c,
                    x + k,
                    y + 4,
                    2,
                    d,
                    o.soil
                )
                __L1:Q(
                    c,
                    x + k,
                    y + 4,
                    2,
                    4,
                    light
                )
                do
                    local s = 10
                    while s < d - 2 do
                        __L1:Q(
                            c,
                            x + k,
                            y + 4 + s + math.floor(math.sin(k * 0.12 + s + sd) * 1.5 + 0.5),
                            2,
                            2,
                            strata
                        )
                        s = s + 7
                    end
                end
                __L1:Q(
                    c,
                    x + k,
                    y + 4 + d - 2,
                    2,
                    2,
                    o.dark
                )
                __L1:Q(
                    c,
                    x + k,
                    y + 4 + d,
                    2,
                    2,
                    "rgba(30,20,10,.35)"
                )
                k = k + 2
            end
        end
        __L1:Q(
            c,
            x - 2,
            y + 4,
            2,
            depthAt(nil, 0) * 0.6,
            o.dark
        )
        __L1:Q(
            c,
            __add(x, w),
            y + 4,
            2,
            depthAt(nil, w) * 0.6,
            o.dark
        )
        do
            local i = 0
            while i < w / 9 do
                local sx = x + 4 + hash(nil, i * 1.7 + sd) * (w - 8)
                local sy = y + 10 + hash(nil, i * 2.3 + sd) * (depthAt(nil, sx - x) - 12)
                __L1:Q(
                    c,
                    sx,
                    sy,
                    2,
                    2,
                    if __gt(
                        hash(nil, i + sd),
                        0.5
                    ) then o.dark else light
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < w / 34 do
                local rx = x + 10 + hash(nil, i + sd) * (w - 24)
                local ry = y + 12 + hash(nil, i * 3 + sd) * 8
                __L1:Q(
                    c,
                    rx,
                    ry,
                    10,
                    6,
                    o.rock
                )
                __L1:Q(
                    c,
                    rx + 2,
                    ry,
                    6,
                    2,
                    __L1:shadeHex(o.rock, 1.25)
                )
                __L1:Q(
                    c,
                    rx,
                    ry + 4,
                    10,
                    2,
                    __L1:shadeHex(o.rock, 0.8)
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < w / 36 do
                local rx = x + 14 + hash(nil, i * 5 + sd) * (w - 28)
                local base = y + 4 + depthAt(nil, rx - x)
                local len = 8 + hash(nil, i * 7 + sd) * 14
                do
                    local k = 0
                    while k < len do
                        __L1:Q(
                            c,
                            rx + math.sin(k * 0.4 + t * 1.2 + i) * 2,
                            base + k - 2,
                            2,
                            2,
                            if k > len - 4 then "#8a6a3a" else "#5a3a20"
                        )
                        k = k + 2
                    end
                end
                i = i + 1
            end
        end
        for ____, ex in __iterar((__arrL(
            {
                x - 2,
                __add(x, w) - 4
            },
            2
        ))) do
            do
                local k = 0
                while k < 10 do
                    __L1:Q(
                        c,
                        ex + math.sin(k + t) * 1,
                        y + 4 + k,
                        4,
                        2,
                        if k < 6 then o.top else __L1:shadeHex(o.top, 0.8)
                    )
                    k = k + 2
                end
            end
        end
        __L1:Q(
            c,
            x - 2,
            y,
            w + 4,
            6,
            o.top
        )
        __L1:Q(
            c,
            x - 2,
            y,
            w + 4,
            2,
            o.top2
        )
        __L1:Q(
            c,
            x - 2,
            y + 6,
            w + 4,
            2,
            __L1:shadeHex(o.top, 0.7)
        )
        do
            local k = 0
            while __lt(k, w) do
                local sw = math.floor(math.sin(t * 2.4 + k * 0.2 + sd) * 1 + 0.5)
                __L1:Q(
                    c,
                    x + k + sw,
                    y - 2 - math.floor(hash(nil, k + sd) * 5 + 0.5),
                    2,
                    4,
                    if __t(__mod(k, 2)) then o.top else o.top2
                )
                k = k + 3
            end
        end
        do
            local i = 0
            while i < w / 24 do
                local fx = x + 6 + hash(nil, i * 11 + sd) * (w - 12)
                __L1:Q(
                    c,
                    fx,
                    y - 8,
                    2,
                    4,
                    o.top
                )
                __L1:Q(
                    c,
                    fx - 2,
                    y - 10,
                    6,
                    4,
                    __L1:pick(
                        __arrL({"#e86a8a", "#f2c94c", "#f6f2ea", "#b86ad8"}, 4),
                        i + sd
                    )
                )
                __L1:Q(
                    c,
                    fx,
                    y - 10,
                    2,
                    2,
                    "#f2e06a"
                )
                i = i + 1
            end
        end
        __D[1] = if __t(if __t(o.cacto) then __gt(
            hash(nil, sd),
            0.4
        ) else o.cacto) then
            local cx = x + 12 + math.floor(hash(nil, sd + 3) * (w - 30) + 0.5)
            __L1:Q(
                c,
                cx,
                y - 10,
                12,
                10,
                "#3f7a4a"
            )
            do
                local k = 0
                while k < 12 do
                    __L1:Q(
                        c,
                        cx + k,
                        y - 10,
                        2,
                        10,
                        "#2a5a32"
                    )
                    k = k + 4
                end
            end
            __L1:Q(
                c,
                cx + 2,
                y - 14,
                8,
                4,
                "#c43c5a"
            )
        end
        if __t(o.cafe) then
            do
                local k = 12
                while k < w - 12 do
                    __L1:Q(
                        c,
                        x + k,
                        y - 12,
                        2,
                        10,
                        "#6a4a2a"
                    )
                    __L1:Q(
                        c,
                        x + k - 6,
                        y - 12,
                        14,
                        6,
                        "#2f5a34"
                    )
                    __L1:Q(
                        c,
                        x + k - 4,
                        y - 16,
                        10,
                        4,
                        "#3a6a3c"
                    )
                    __L1:Q(
                        c,
                        x + k - 2,
                        y - 8,
                        2,
                        2,
                        "#d8343a"
                    )
                    __L1:Q(
                        c,
                        x + k + 4,
                        y - 10,
                        2,
                        2,
                        "#c42a2a"
                    )
                    k = k + 30
                end
            end
        end
    end
    __L1.plataforma = function(self, c, scene, p, t)
        local f = __get(__L1.PLAT, scene)
        if not __t(f) then
            return false
        end
        local x, y, w = table.unpack(p, 1, 3)
        c:save()
        c.imageSmoothingEnabled = false
        local ____array_55 = __TS__SparseArrayNew(
            nil,
            c,
            x,
            y,
            w
        )
        local ____t_54 = __t
        local ____TS__Number_result_53 = __TS__Number(t)
        __O[402] = ____TS__Number_result_53
        __TS__SparseArrayPush(
            ____array_55,
            if ____t_54(____TS__Number_result_53) then __O[402] else 0,
            math.floor(x * 7 + y * 3 + 0.5)
        )
        f(__TS__SparseArraySpread(____array_55))
        c:restore()
        return true
    end
    __L1.holes = function(self, c, id, camL)
        local L = __get(__L1.LAYOUT, id)
        if __t(not __t(L) or not __t(__len(L.gaps))) then
            return
        end
        local t = window.performance:now() / 1000
        local ____opt_56 = __call(
            __L1.LIST,
            "find",
            function(____, d) return d.id == id end
        )
        if ____opt_56 ~= nil then
            ____opt_56 = ____opt_56.vao
        end
        local V = ____opt_56
        local H = LH - FLOOR
        local ____t_61 = __t
        local ____opt_result_60
        if V ~= nil then
            ____opt_result_60 = V.tipo
        end
        __O[403] = ____opt_result_60
        local ____t_65 = __t
        local ____opt_result_64
        if V ~= nil then
            ____opt_result_64 = V.borda
        end
        local tipo = if ____t_61(____opt_result_60) then __O[403] else if ____t_65(____opt_result_64 == "#7ac0b8" or id == 18) then "agua" else if id == 16 then "obra" else "terra"
        local ____t_69 = __t
        local ____opt_result_68
        if V ~= nil then
            ____opt_result_68 = V.fundo
        end
        __O[404] = ____opt_result_68
        local fundo = if ____t_69(____opt_result_68) then __O[404] else if tipo == "terra" then "#3a3024" else if tipo == "agua" then "#2c5a78" else "#2a2a2c"
        for ____, ____value in __iterar((L.gaps)) do
            local gx = ____value[1]
            local gw = ____value[2]
            local x = math.floor(gx / 2 - camL + 0.5)
            local w = math.floor(gw / 2 + 0.5)
            if not __t(__L1:vis(x, w + 20)) then
                continue
            end
            local parede = if tipo == "obra" then "#6a6a66" else if tipo == "agua" then "#5a5a52" else "#5a4430"
            local pw = math.max(
                4,
                math.floor(w * 0.09 + 0.5)
            )
            local seed = gx
            do
                local y = 0
                while y < H do
                    R(
                        nil,
                        c,
                        x,
                        FLOOR + y,
                        w,
                        2,
                        __L1:mixH(
                            fundo,
                            "#060606",
                            math.min(1, y / (H * 0.8))
                        )
                    )
                    y = y + 2
                end
            end
            do
                local y = 0
                while y < H do
                    local k = math.min(1, y / (H * 0.9))
                    local inc = math.floor(y * 0.18 + 0.5)
                    R(
                        nil,
                        c,
                        x,
                        FLOOR + y,
                        pw + inc,
                        2,
                        __L1:mixH(parede, "#0c0a08", k * 0.9)
                    )
                    R(
                        nil,
                        c,
                        x + w - pw - inc,
                        FLOOR + y,
                        pw + inc,
                        2,
                        __L1:mixH(
                            parede,
                            "#0c0a08",
                            math.min(1, k * 0.9 + 0.15)
                        )
                    )
                    y = y + 2
                end
            end
            if tipo == "terra" then
                do
                    local k = 0
                    while k < w * H / 40 do
                        local px = x + hash(nil, seed + k * 3.3) * w
                        local py = FLOOR + hash(nil, seed + k * 7.1) * H * 0.7
                        R(
                            nil,
                            c,
                            px,
                            py,
                            1 + __mod(k, 2),
                            1,
                            if __t(__mod(k, 3)) then "rgba(20,14,8,.35)" else "rgba(150,120,80,.25)"
                        )
                        k = k + 1
                    end
                end
            end
            if tipo == "terra" then
                do
                    local k = 0
                    while k < 5 do
                        local rx = x + 3 + hash(nil, seed + k) * (w - 6)
                        local ry = FLOOR + 2
                        do
                            local j = 0
                            while j < 6 + __mod(k, 4) do
                                R(
                                    nil,
                                    c,
                                    rx + math.floor(math.sin(j + k) * 1.5 + 0.5),
                                    ry,
                                    1,
                                    2,
                                    "#3a2a18"
                                )
                                ry = ry + 2
                                j = j + 1
                            end
                        end
                        k = k + 1
                    end
                end
            end
            if tipo == "obra" then
                do
                    local y = FLOOR + 6
                    while __lt(y, LH) do
                        do
                            local xx = x + pw
                            while xx < x + w - pw do
                                R(
                                    nil,
                                    c,
                                    xx + if __t(__mod(y / 7, 2)) then 6 else 0,
                                    y,
                                    10,
                                    1,
                                    "rgba(0,0,0,.25)"
                                )
                                xx = xx + 12
                            end
                        end
                        y = y + 7
                    end
                end
                do
                    local k = 0
                    while k < 4 do
                        local vx = x + 6 + k * (w - 12) / 3
                        R(
                            nil,
                            c,
                            vx,
                            FLOOR + 6,
                            1,
                            H * 0.5,
                            "#7a4a2a"
                        )
                        R(
                            nil,
                            c,
                            vx,
                            FLOOR + 6,
                            1,
                            2,
                            "#c8803a"
                        )
                        k = k + 1
                    end
                end
                do
                    local xx = 0
                    while xx < w do
                        R(
                            nil,
                            c,
                            x + xx,
                            FLOOR - 10,
                            math.min(3, w - xx),
                            2,
                            if __t(__mod(xx / 6, 2)) then "#1c1c1c" else "#f2c018"
                        )
                        xx = xx + 6
                    end
                end
                R(
                    nil,
                    c,
                    x - 2,
                    FLOOR - 12,
                    1,
                    12,
                    "#8a8a88"
                )
                R(
                    nil,
                    c,
                    x + w + 1,
                    FLOOR - 12,
                    1,
                    12,
                    "#8a8a88"
                )
            end
            if tipo == "agua" then
                local ny = FLOOR + 7
                R(
                    nil,
                    c,
                    x + 1,
                    ny,
                    w - 2,
                    LH - ny,
                    __L1:mixH(fundo, "#0a1a24", 0.25)
                )
                do
                    local y = ny + 2
                    while __lt(y, LH) do
                        R(
                            nil,
                            c,
                            x + 1,
                            y,
                            w - 2,
                            1,
                            ("rgba(0,0,0," .. tostring(math.min(0.5, (y - ny) / H * 0.6))) .. ")"
                        )
                        y = y + 3
                    end
                end
                R(
                    nil,
                    c,
                    x + 1,
                    ny,
                    w - 2,
                    1,
                    "rgba(200,240,255,.45)"
                )
                do
                    local k = 0
                    while k < w / 9 do
                        local ox = __mod(
                            k * 9 + t * 8 + hash(nil, seed + k) * 9,
                            w - 8
                        )
                        R(
                            nil,
                            c,
                            x + 3 + ox,
                            ny + 3 + __mod(k, 3) * 4,
                            4 + __mod(k, 2) * 2,
                            1,
                            "rgba(220,250,255,.35)"
                        )
                        k = k + 1
                    end
                end
                R(
                    nil,
                    c,
                    x,
                    FLOOR,
                    2,
                    ny - FLOOR,
                    "#4a4a44"
                )
                R(
                    nil,
                    c,
                    x + w - 2,
                    FLOOR,
                    2,
                    ny - FLOOR,
                    "#4a4a44"
                )
            end
            local ____t_73 = __t
            local ____opt_result_72
            if V ~= nil then
                ____opt_result_72 = V.borda
            end
            __O[405] = ____opt_result_72
            local borda = if ____t_73(____opt_result_72) then __O[405] else if tipo == "obra" then "#9a9a94" else if tipo == "agua" then "#7ac0b8" else "#5a7a3a"
            R(
                nil,
                c,
                x - 3,
                FLOOR,
                w + 6,
                2,
                borda
            )
            R(
                nil,
                c,
                x - 3,
                FLOOR + 2,
                w + 6,
                1,
                "rgba(0,0,0,.45)"
            )
            if tipo == "terra" then
                do
                    local k = 0
                    while k < w do
                        if __gt(
                            hash(nil, seed + k * 1.9),
                            0.55
                        ) then
                            R(
                                nil,
                                c,
                                x + k,
                                FLOOR + 2,
                                1,
                                1 + math.floor(hash(nil, seed + k) * 4 + 0.5),
                                "#4a6a30"
                            )
                        end
                        k = k + 2
                    end
                end
            end
            R(
                nil,
                c,
                x - 2,
                FLOOR,
                2,
                H,
                "rgba(0,0,0,.35)"
            )
            R(
                nil,
                c,
                x + w,
                FLOOR,
                2,
                H,
                "rgba(0,0,0,.35)"
            )
            if id == 16 then
                for ____, cx in __iterar((__arrL({x - 8, x + w + 2}, 2))) do
                    R(
                        nil,
                        c,
                        cx,
                        FLOOR - 9,
                        6,
                        9,
                        "#f08a24"
                    )
                    R(
                        nil,
                        c,
                        cx + 1,
                        FLOOR - 6,
                        4,
                        2,
                        "#f2f2ee"
                    )
                end
            end
        end
    end
    __L1.registrar = function(self, d, layout)
        if __t(layout) then
            __set(__L1.LAYOUT, d.id, layout)
        end
        if not __t(__get(__L1.LAYOUT, d.id)) then
            __set(
                __L1.LAYOUT,
                d.id,
                {
                    platforms = __arrL({}, 0),
                    gaps = __arrL({}, 0)
                }
            )
        end
        local draw = d.draw
        window.HdMaps:register(
            d.id,
            __assign(
                {},
                d,
                {
                    always = true,
                    text = __L1:textOf(d),
                    draw = function(____, c, s, t, camL)
                        __L1.CUR = d.id
                        local ____opt_76 = __L1:CAM()
                        if ____opt_76 ~= nil then
                            ____opt_76 = ____opt_76.entrar
                        end
                        if ____opt_76 ~= nil then
                            ____opt_76(____opt_76, d.id)
                        end
                        draw(
                            nil,
                            c,
                            s,
                            t,
                            camL
                        )
                        local ____opt_80 = __L1:CAM()
                        if ____opt_80 ~= nil then
                            ____opt_80 = ____opt_80.frente
                        end
                        if ____opt_80 ~= nil then
                            ____opt_80(
                                ____opt_80,
                                d.id,
                                c,
                                s,
                                t,
                                camL
                            )
                        end
                        __L1:holes(c, d.id, camL)
                    end,
                    lights = function(____, g, s, t, camL)
                        local ____this_83
                        ____this_83 = d
                        local ____opt_82 = ____this_83.lights
                        if ____opt_82 ~= nil then
                            ____opt_82(
                                ____this_83,
                                g,
                                s,
                                t,
                                camL
                            )
                        end
                        local ____opt_86 = __L1:CAM()
                        if ____opt_86 ~= nil then
                            ____opt_86 = ____opt_86.luzes
                        end
                        if ____opt_86 ~= nil then
                            ____opt_86(
                                ____opt_86,
                                d.id,
                                g,
                                s,
                                t,
                                camL
                            )
                        end
                    end
                }
            )
        )
        local ____opt_90 = window.Interact
        if ____opt_90 ~= nil then
            ____opt_90 = ____opt_90.addScene
        end
        if ____opt_90 ~= nil then
            ____opt_90(____opt_90, d.id, if __t(d.interact) then d.interact else __arrL({}, 0))
        end
        local i = __call(
            __L1.LIST,
            "findIndex",
            function(____, x) return x.id == d.id end
        )
        if i >= 0 then
            __set(__L1.LIST, i, d)
        else
            __call(__L1.LIST, "push", d)
        end
        local pub = {
            id = d.id,
            key = d.key,
            nome = d.nome,
            lugar = d.lugar,
            largura = d.width,
            noite = not not __t(d.noite),
            interno = not not __t(d.amb),
            plataformas = __get(__L1.LAYOUT, d.id).platforms,
            vaos = __get(__L1.LAYOUT, d.id).gaps,
            interativos = __len(if __t(d.interact) then d.interact else __arrL({}, 0)),
            grupo = if __t(d.grupo) then d.grupo else "cenario",
            limites = if __t(d.limites) then d.limites else nil
        }
        local j = __call(
            __L1.PUBLIC,
            "findIndex",
            function(____, x) return x.id == d.id end
        )
        if j >= 0 then
            __set(__L1.PUBLIC, j, pub)
        else
            __call(__L1.PUBLIC, "push", pub)
        end
        if __t(d.plat) then
            __set(__L1.PLAT, d.id, d.plat)
        end
    end
    local ____ = "use strict"
    local ____t_97 = __t
    local ____t_96 = __t
    local ____t_94 = __t
    local ____opt_92 = window.HdMaps
    if ____opt_92 ~= nil then
        ____opt_92 = ____opt_92.register
    end
    local ____temp_95 = if __t(window.CampanhaCenarios) then window.CampanhaCenarios else not ____t_94(____opt_92)
    __O[388] = ____temp_95
    if ____t_97(if ____t_96(____temp_95) then __O[388] else not __t(window.HdMaps.kit)) then
        return
    end
    __L1.K = window.HdMaps.kit
    local ____L1_K_98 = __L1.K
    LW = ____L1_K_98.LW
    LH = ____L1_K_98.LH
    FLOOR = ____L1_K_98.FLOOR
    R = ____L1_K_98.R
    ell = ____L1_K_98.ell
    mk = ____L1_K_98.mk
    hash = ____L1_K_98.hash
    cl = ____L1_K_98.cl
    mix = ____L1_K_98.mix
    dither = ____L1_K_98.dither
    limb = ____L1_K_98.limb
    sky = ____L1_K_98.sky
    haze = ____L1_K_98.haze
    tile = ____L1_K_98.tile
    tree = ____L1_K_98.tree
    slant = ____L1_K_98.slant
    sunInfo = ____L1_K_98.sunInfo
    sunWall = ____L1_K_98.sunWall
    board = ____L1_K_98.board
    bench = ____L1_K_98.bench
    lampPost = ____L1_K_98.lampPost
    lampGlow = ____L1_K_98.lampGlow
    shadeAdd = ____L1_K_98.shadeAdd
    lightAdd = ____L1_K_98.lightAdd
    __L1.GY = 210
    __L1.vis = function(____, x, m)
        if m == nil then
            m = 80
        end
        return __gt(x, -m) and __lt(x, LW + m)
    end
    __L1.night = function(____, s) return cl(nil, (s.night - 0.12) * 1.4) end
    __L1.text = function(____, c, str, x, y, size, col, align)
        if align == nil then
            align = "center"
        end
        c.font = tostring(size) .. "px Pixel, monospace"
        c.textAlign = align
        c.textBaseline = "middle"
        c.fillStyle = col
        c:fillText(str, x, y)
    end
    __L1.pick = function(____, arr, seed) return __get(
        arr,
        __mod(
            math.floor(hash(nil, seed) * __len(arr)),
            __len(arr)
        )
    ) end
    __L1.CUR = 0
    __L1.LOJAS = {}
    __L1.CAM = function() return window.CampanhaCamadas end
    __L1.parado = function()
        local ____t_104 = __t
        local ____opt_101 = __L1:CAM()
        if ____opt_101 ~= nil then
            ____opt_101 = ____opt_101.engarrafado
        end
        local ____opt_result_103
        if ____opt_101 ~= nil then
            ____opt_result_103 = ____opt_101(____opt_101, __L1.CUR)
        end
        return not not ____t_104(____opt_result_103)
    end
    __L1.CURT = __arrL({
        "#e8d8a8",
        "#c9d8e8",
        "#e8c4c4",
        "#d4e8c8",
        "#f2efe6",
        "#c8b8d8"
    }, 6)
    __L1.FAR = nil
    __L1.FOG = nil
    __L1.wrap = function(____, v, T)
        if T == nil then
            T = 964
        end
        return __mod(
            __mod(v, T) + T,
            T
        )
    end
    __L1.HERO = __ord({x = -9999, y = 440, vy = 0}, "x,y,vy")
    __L1.FIOS = {
        ["13"] = __ord({x0 = 41, step = 230, n = 8, y0 = 58}, "x0,step,n,y0"),
        ["14"] = __ord({x0 = 31, step = 260, n = 9, y0 = 56}, "x0,step,n,y0")
    }
    __L1.BIRDS = {}
    __L1.birdT = 0
    __L1.AIR = __ord({W = 2200, TAR = 1050, GR = 1500}, "W,TAR,GR")
    __L1.airMid = nil
    __L1.BAIRRO = __ord({W = 2100, PEN = 780}, "W,PEN")
    __L1.bairroMid = nil
    __L1.CENTRO = __ord({W = 2500, CAT = 1180}, "W,CAT")
    __L1.centroMid = nil
    __L1.SERRA = __ord({W = 2400, CRISTO = 2180}, "W,CRISTO")
    __L1.serraMid = nil
    __L1.AVENIDA = __ord({W = 3000, INDIO = 1500}, "W,INDIO")
    __L1.aveMid = nil
    __L1.FEIRA = __ord(
        {
            W = 2200,
            BISC = __arrL({380, 1240, 1900}, 3)
        },
        "W,BISC"
    )
    __L1.feiraMid = nil
    __L1.CAFE = {W = 2600}
    __L1.cafeMid = nil
    __L1.CULTURA = __ord({W = 2200, TEATRO = 600, DOME = 1500}, "W,TEATRO,DOME")
    __L1.culturaMid = nil
    __L1.SHOP = __ord({
        W = 2400,
        ESC = 600,
        FOOD = 720,
        CINE = 1120,
        ELEV = 1508,
        FONTE = 1556,
        LAN = 1640,
        MZ = 96,
        TOP = 114
    }, "W,ESC,FOOD,CINE,ELEV,FONTE,LAN,MZ,TOP")
    __L1.SIGNS = __arrL({
        "#c43c3a",
        "#2c5a9e",
        "#e8833a",
        "#7a3a8a",
        "#2f7a4a",
        "#1e2228",
        "#c8a24a",
        "#d84a7a"
    }, 8)
    __L1.SHIRT = __arrL({
        "#3a4a6a",
        "#7a3a3a",
        "#4a6a4a",
        "#5a4a6a",
        "#c47a35",
        "#2a3a4a",
        "#e8c24c",
        "#3c8ad8"
    }, 8)
    __L1.SKIN = __arrL({
        "#e0b08a",
        "#9a6440",
        "#c88a60",
        "#6a4430",
        "#f0c8a8"
    }, 5)
    __L1.hexRGB = function(____, h) return __arrL(
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
    __L1.lerpC = function(____, a, b, k) return __L1.K:css(mix(
        nil,
        __L1:hexRGB(a),
        __L1:hexRGB(b),
        cl(nil, k)
    )) end
    __L1.SHOPFAR = nil
    __L1.shopMid = nil
    __L1.OLIVIA = __ord({W = 2600, SESI = 1250}, "W,SESI")
    __L1.oliviaMid = nil
    __L1.indoor = function(____, k) return function(____, s) return mix(
        nil,
        s.amb,
        __arrL({1, 1, 1}, 3),
        k
    ) end end
    __L1.LIST = __arrL(
        {
            __ord(
                {
                    id = 12,
                    key = "aeroporto",
                    nome = "Aeroportos",
                    lugar = "Aeroporto de Itabuna → Aeroporto Glauber Rocha",
                    width = __L1.AIR.W * 2,
                    draw = __L1.aeroporto,
                    lights = __L1.aeroportoLights,
                    amb = __L1:indoor(0.55),
                    always = true,
                    labels = __arrL(
                        {
                            __arrL({
                                260,
                                121,
                                "AEROPORTO DE ITABUNA",
                                10,
                                "#f2f2e6"
                            }, 5),
                            __arrL({
                                370,
                                110,
                                "ITABUNA · TERRA DO CACAU",
                                6,
                                "#5a3a20"
                            }, 5),
                            __arrL({
                                535,
                                155,
                                "LANCHONETE",
                                6,
                                "#f2e8d0"
                            }, 5),
                            __arrL({
                                700,
                                125,
                                "RAIO-X",
                                8,
                                "#2c3a44"
                            }, 5),
                            __arrL({
                                1027,
                                108,
                                "PORTÃO 1",
                                6,
                                "#1d4a7a"
                            }, 5),
                            __arrL({
                                1850,
                                52,
                                "AEROPORTO GLAUBER ROCHA · VITÓRIA DA CONQUISTA",
                                11,
                                "#2a3aa8"
                            }, 5),
                            __arrL({
                                1850,
                                76,
                                "BEM-VINDO À SUÍÇA BAIANA. TRAGA CASACO.",
                                6,
                                "#c43c3a"
                            }, 5),
                            __arrL({
                                1810,
                                166,
                                "ESTEIRA 1",
                                6,
                                "#f2efe6"
                            }, 5)
                        },
                        8
                    ),
                    interact = __arrL(
                        {
                            __arrL({"trash", 520}, 2),
                            __arrL({"trash", 1900}, 2),
                            __arrL({"pot", 640}, 2),
                            __arrL({"pot", 3200}, 2),
                            __arrL({
                                "door",
                                3100,
                                60,
                                150,
                                "main"
                            }, 5),
                            __arrL({"cone", 2300}, 2),
                            __arrL({"cone", 2360}, 2),
                            __arrL({"cone", 2420}, 2),
                            __arrL({"crate", 2580}, 2),
                            __arrL({"crate", 2608, 1}, 3),
                            __arrL({"tire", 2700}, 2),
                            __arrL({"lever", 2200, "flood"}, 3),
                            __arrL({"puddle", 3600, 70}, 3)
                        },
                        13
                    )
                },
                "id,key,nome,lugar,width,draw,lights,amb,always,labels,interact"
            ),
            __ord(
                {
                    id = 13,
                    key = "bairro",
                    nome = "Bairro da pensão",
                    lugar = "Pensão de Dona Lurdes",
                    width = __L1.BAIRRO.W * 2,
                    draw = __L1.bairro,
                    lights = __L1.bairroLights,
                    always = true,
                    labels = __arrL(
                        {
                            __arrL({
                                __L1.BAIRRO.PEN + 110,
                                145,
                                "PENSÃO DONA LURDES · QUARTOS",
                                8,
                                "#5a3c2a"
                            }, 5),
                            __arrL({
                                1178,
                                184,
                                "PADARIA PÃO QUENTE",
                                6,
                                "#fff4dc"
                            }, 5),
                            __arrL({
                                1295,
                                184,
                                "MERCADINHO",
                                6,
                                "#eef6ea"
                            }, 5),
                            __arrL({
                                720,
                                167,
                                "R. DA PENSÃO",
                                5,
                                "#f2efe6"
                            }, 5),
                            __arrL({
                                __L1.BAIRRO.PEN + 190,
                                160,
                                "AVISOS",
                                5,
                                "#5a3c2a"
                            }, 5),
                            __arrL({
                                1980,
                                166,
                                "ALUGA-SE QUARTO · TRATAR C/ LURDES",
                                5,
                                "#2a2a2a"
                            }, 5)
                        },
                        6
                    ),
                    interact = __arrL(
                        {
                            __arrL({
                                "door",
                                __L1.BAIRRO.PEN * 2 + 262,
                                50,
                                100,
                                "house"
                            }, 5),
                            __arrL({"pot", 900}, 2),
                            __arrL({"pot", 3300}, 2),
                            __arrL({"trash", 2140}, 2),
                            __arrL({"bucket", 1800}, 2),
                            __arrL({"crate", 2520}, 2),
                            __arrL({"crate", 2548, 1}, 3),
                            __arrL({"ball", 3000}, 2),
                            __arrL({"puddle", 2700, 80}, 3),
                            __arrL({"lever", 2400, "party"}, 3),
                            __arrL({"grass", 3800, 200}, 3),
                            __arrL({"grill", 1500}, 2)
                        },
                        12
                    )
                },
                "id,key,nome,lugar,width,draw,lights,always,labels,interact"
            ),
            __ord(
                {
                    id = 14,
                    key = "centro",
                    nome = "Centro e Praça da Catedral",
                    lugar = "Catedral Nossa Senhora das Vitórias · Praça Tancredo Neves",
                    width = __L1.CENTRO.W * 2,
                    draw = __L1.centro,
                    lights = __L1.centroLights,
                    always = true,
                    labels = __arrL(
                        {
                            __arrL({
                                __L1.CENTRO.CAT + 140,
                                224,
                                "CATEDRAL NOSSA SENHORA DAS VITÓRIAS",
                                7,
                                "#5a5246"
                            }, 5),
                            __arrL({
                                1250,
                                188,
                                "PRAÇA TANCREDO NEVES",
                                7,
                                "#f2efe6"
                            }, 5),
                            __arrL({
                                1785,
                                106,
                                "MEMORIAL",
                                7,
                                "#5a3c2a"
                            }, 5),
                            __arrL({
                                860,
                                167,
                                "PÇA. TANCREDO NEVES",
                                5,
                                "#f2efe6"
                            }, 5)
                        },
                        4
                    ),
                    interact = __arrL(
                        {
                            __arrL({"pot", 1900}, 2),
                            __arrL({"pot", 3150}, 2),
                            __arrL({"trash", 1760}, 2),
                            __arrL({"trash", 3260}, 2),
                            __arrL({"crate", 620}, 2),
                            __arrL({"crate", 4520}, 2),
                            __arrL({"crate", 4548, 1}, 3),
                            __arrL({"ball", 2600}, 2),
                            __arrL({"puddle", 2200, 80}, 3),
                            __arrL({"lever", 2050, "party"}, 3),
                            __arrL({
                                "door",
                                __L1.CENTRO.CAT * 2 + 68,
                                48,
                                120,
                                "main"
                            }, 5),
                            __arrL({"cone", 3900}, 2)
                        },
                        12
                    )
                },
                "id,key,nome,lugar,width,draw,lights,always,labels,interact"
            ),
            __ord(
                {
                    id = 15,
                    key = "serra",
                    nome = "Serra do Periperi",
                    lugar = "Cristo de Mário Cravo",
                    width = __L1.SERRA.W * 2,
                    draw = __L1.serra,
                    lights = __L1.serraLights,
                    always = true,
                    labels = __arrL(
                        {
                            __arrL({
                                200,
                                174,
                                "TRILHA DO CRISTO",
                                5,
                                "#5a3c2a"
                            }, 5),
                            __arrL({
                                1000,
                                174,
                                "MIRANTE · 1.100 m",
                                5,
                                "#5a3c2a"
                            }, 5),
                            __arrL({
                                1900,
                                174,
                                "CUIDADO: VENTO",
                                5,
                                "#5a3c2a"
                            }, 5),
                            __arrL({
                                __L1.SERRA.CRISTO,
                                219,
                                "CRISTO DE MÁRIO CRAVO",
                                7,
                                "#3a3a34"
                            }, 5)
                        },
                        4
                    ),
                    interact = __arrL(
                        {
                            __arrL({"grass", 300, 260}, 3),
                            __arrL({"grass", 2200, 300}, 3),
                            __arrL({"grass", 3500, 240}, 3),
                            __arrL({"fence", 1200, 90}, 3),
                            __arrL({"crate", 2000}, 2),
                            __arrL({"crate", 2028, 1}, 3),
                            __arrL({"bucket", 3000}, 2),
                            __arrL({"hay", 4200}, 2),
                            __arrL({"ball", 1600}, 2)
                        },
                        9
                    )
                },
                "id,key,nome,lugar,width,draw,lights,always,labels,interact"
            ),
            __ord(
                {
                    id = 16,
                    key = "avenidas",
                    nome = "Monumento ao Índio",
                    lugar = "Avenidas e rotatória do Monumento ao Índio",
                    width = __L1.AVENIDA.W * 2,
                    draw = __L1.avenida,
                    lights = __L1.avenidaLights,
                    always = true,
                    labels = __arrL(
                        {
                            __arrL({
                                __L1.AVENIDA.INDIO,
                                180,
                                "MONUMENTO AO ÍNDIO",
                                7,
                                "#f2efe6"
                            }, 5),
                            __arrL({
                                380,
                                121,
                                "POSTO DO PLANALTO",
                                7,
                                "#f2efe6"
                            }, 5),
                            __arrL({
                                825,
                                155,
                                "MOTOTÁXI",
                                6,
                                "#2a2a2a"
                            }, 5),
                            __arrL({
                                2615,
                                169,
                                "BORRACHARIA",
                                6,
                                "#e8c24c"
                            }, 5)
                        },
                        4
                    ),
                    interact = __arrL(
                        {
                            __arrL({"tire", 5000}, 2),
                            __arrL({"tire", 5060}, 2),
                            __arrL({"tire", 1300}, 2),
                            __arrL({"barrel", 5200}, 2),
                            __arrL({"cone", 2500}, 2),
                            __arrL({"cone", 2560}, 2),
                            __arrL({"cone", 4200}, 2),
                            __arrL({"trash", 2440}, 2),
                            __arrL({"trash", 3760}, 2),
                            __arrL({"lever", 3100, "flood"}, 3),
                            __arrL({"puddle", 3400, 80}, 3),
                            __arrL({"crate", 1700}, 2)
                        },
                        12
                    )
                },
                "id,key,nome,lugar,width,draw,lights,always,labels,interact"
            ),
            __ord(
                {
                    id = 17,
                    key = "feira",
                    nome = "Feira e biscoitarias",
                    lugar = "Feira e biscoitos de polvilho",
                    width = __L1.FEIRA.W * 2,
                    draw = __L1.feira,
                    lights = __L1.feiraLights,
                    always = true,
                    labels = __arrL(
                        {
                            __arrL(
                                {
                                    __get(__L1.FEIRA.BISC, 0) + 60,
                                    184,
                                    "BISCOITOS DE POLVILHO",
                                    6,
                                    "#fff4dc"
                                },
                                5
                            ),
                            __arrL(
                                {
                                    __get(__L1.FEIRA.BISC, 1) + 60,
                                    184,
                                    "BISCOITARIA DA SERRA",
                                    6,
                                    "#fff4dc"
                                },
                                5
                            ),
                            __arrL(
                                {
                                    __get(__L1.FEIRA.BISC, 2) + 60,
                                    184,
                                    "BISCOITO QUENTINHO",
                                    6,
                                    "#fff4dc"
                                },
                                5
                            ),
                            __arrL({
                                240,
                                88,
                                "FEIRA DO PLANALTO",
                                10,
                                "#3c5a6a"
                            }, 5),
                            __arrL({
                                1700,
                                88,
                                "BISCOITO CURA TUDO (MENOS O FRIO)",
                                6,
                                "#3c5a6a"
                            }, 5)
                        },
                        5
                    ),
                    interact = __arrL(
                        {
                            __arrL({"melon", 600}, 2),
                            __arrL({"melon", 630}, 2),
                            __arrL({"melon", 2000}, 2),
                            __arrL({"melon", 3000}, 2),
                            __arrL({"crate", 1100}, 2),
                            __arrL({"crate", 1128, 1}, 3),
                            __arrL({"crate", 3500}, 2),
                            __arrL({"pot", 2300}, 2),
                            __arrL({"bucket", 1600}, 2),
                            __arrL({"trash", 4000}, 2),
                            __arrL({"barrel", 3300}, 2),
                            __arrL({"grill", 2600}, 2),
                            __arrL({"puddle", 1400, 70}, 3)
                        },
                        13
                    )
                },
                "id,key,nome,lugar,width,draw,lights,always,labels,interact"
            ),
            __ord(
                {
                    id = 18,
                    key = "cafe",
                    nome = "Fazendas de café",
                    lugar = "Planalto da Conquista",
                    width = __L1.CAFE.W * 2,
                    draw = __L1.cafe,
                    lights = __L1.cafeLights,
                    always = true,
                    labels = __arrL(
                        {
                            __arrL({
                                350,
                                110,
                                "FAZENDA CAFÉ DO PLANALTO",
                                8,
                                "#5a3c2a"
                            }, 5),
                            __arrL({
                                960,
                                190,
                                "TERREIRO DE SECAGEM",
                                7,
                                "#3a2a1a"
                            }, 5),
                            __arrL({
                                1550,
                                96,
                                "SECADOR · NÃO ENCOSTE (O BARÃO TÁ DE OLHO)",
                                6,
                                "#f2efe6"
                            }, 5),
                            __arrL({
                                1250,
                                186,
                                "CAFÉ",
                                5,
                                "#5a3420"
                            }, 5)
                        },
                        4
                    ),
                    interact = __arrL(
                        {
                            __arrL({"hay", 1300}, 2),
                            __arrL({"hay", 3900}, 2),
                            __arrL({"hay", 3940}, 2),
                            __arrL({"crate", 2500}, 2),
                            __arrL({"crate", 2528, 1}, 3),
                            __arrL({"bucket", 4200}, 2),
                            __arrL({"barrel", 3000}, 2),
                            __arrL({"fence", 4400, 120}, 3),
                            __arrL({"lever", 1700, "sprinkler"}, 3),
                            __arrL({"grass", 4700, 260}, 3),
                            __arrL({"puddle", 4100, 70}, 3)
                        },
                        11
                    )
                },
                "id,key,nome,lugar,width,draw,lights,always,labels,interact"
            ),
            __ord(
                {
                    id = 19,
                    key = "cultura",
                    nome = "Teatro e Planetário",
                    lugar = "Teatro Glauber Rocha · Centro de Cultura · Planetário",
                    width = __L1.CULTURA.W * 2,
                    draw = __L1.cultura,
                    lights = __L1.culturaLights,
                    noite = true,
                    always = true,
                    labels = __arrL(
                        {
                            __arrL({
                                195,
                                132,
                                "CENTRO DE CULTURA",
                                8,
                                "#f2efe6"
                            }, 5),
                            __arrL({
                                __L1.CULTURA.TEATRO + 150,
                                113,
                                "TEATRO GLAUBER ROCHA",
                                9,
                                "#ffe39a"
                            }, 5),
                            __arrL({
                                __L1.CULTURA.TEATRO + 150,
                                125,
                                "HOJE: BIA DO ARROCHA",
                                6,
                                "#f2efe6"
                            }, 5),
                            __arrL({
                                __L1.CULTURA.DOME,
                                168,
                                "PLANETÁRIO",
                                8,
                                "#2c3a44"
                            }, 5),
                            __arrL({
                                1000,
                                160,
                                "PIPOCA",
                                6,
                                "#2a2a2a"
                            }, 5),
                            __arrL({
                                1120,
                                160,
                                "DOGÃO",
                                6,
                                "#f2efe6"
                            }, 5),
                            __arrL({
                                __L1.CULTURA.TEATRO + 150,
                                196,
                                "BILHETERIA",
                                5,
                                "#2a2a2a"
                            }, 5)
                        },
                        7
                    ),
                    interact = __arrL(
                        {
                            __arrL({"lever", 1500, "party"}, 3),
                            __arrL({"lever", 3400, "flood"}, 3),
                            __arrL({"pot", 900}, 2),
                            __arrL({"pot", 3800}, 2),
                            __arrL({"trash", 2300}, 2),
                            __arrL({"crate", 2700}, 2),
                            __arrL({"grill", 2100}, 2)
                        },
                        7
                    )
                },
                "id,key,nome,lugar,width,draw,lights,noite,always,labels,interact"
            ),
            __ord(
                {
                    id = 20,
                    key = "shopping",
                    nome = "Shopping",
                    lugar = "Praça de alimentação, cinema e lan house",
                    width = __L1.SHOP.W * 2,
                    draw = __L1.shopping,
                    lights = __L1.shoppingLights,
                    amb = __L1:indoor(0.8),
                    always = true,
                    labels = __call(
                        __call(
                            __call(
                                __arrL(
                                    {
                                        __arrL({
                                            __L1.SHOP.CINE + 190,
                                            __L1.SHOP.TOP + 14,
                                            "CINEMA PLANALTO",
                                            10,
                                            "#ffe39a"
                                        }, 5),
                                        __arrL({
                                            __L1.SHOP.LAN + 185,
                                            __L1.SHOP.TOP + 11,
                                            "LAN HOUSE PLANALTO · 24H",
                                            8,
                                            "#5ae0d0"
                                        }, 5),
                                        __arrL({
                                            __L1.SHOP.CINE + 17,
                                            __L1.SHOP.TOP + 80,
                                            "BILHETERIA",
                                            4,
                                            "#f2d898"
                                        }, 5),
                                        __arrL({
                                            __L1.SHOP.ESC + 37,
                                            __L1.SHOP.TOP + 18,
                                            "SHOPPING",
                                            5,
                                            "#f2efe6"
                                        }, 5),
                                        __arrL({
                                            __L1.SHOP.ESC + 37,
                                            __L1.SHOP.TOP + 30,
                                            "CONQUISTA",
                                            5,
                                            "#f2efe6"
                                        }, 5),
                                        __arrL({
                                            2342,
                                            147,
                                            "PELÚCIA",
                                            4,
                                            "#f2efe6"
                                        }, 5),
                                        __arrL({
                                            __L1.SHOP.FONTE + 32,
                                            216,
                                            "JOGUE UMA MOEDA",
                                            4,
                                            "#5a6a72"
                                        }, 5)
                                    },
                                    7
                                ),
                                "concat",
                                __call(
                                    __arrL({
                                        60,
                                        360,
                                        660,
                                        960,
                                        1260,
                                        1560,
                                        1860,
                                        2160
                                    }, 8),
                                    "map",
                                    function(____, x) return __arrL({
                                        x + 18,
                                        66,
                                        "INVERNO",
                                        4,
                                        "#f2c94c"
                                    }, 5) end
                                )
                            ),
                            "concat",
                            __call(
                                __arrL({"BURGÃO", "PASTEL & CALDO", "AÇAÍ DA SERRA"}, 3),
                                "map",
                                function(____, n, i) return __arrL({
                                    __L1.SHOP.FOOD + 64 + i * 130,
                                    __L1.SHOP.TOP + 9,
                                    n,
                                    6,
                                    "#f2efe6"
                                }, 5) end
                            )
                        ),
                        "concat",
                        __call(
                            __arrL(
                                {
                                    __arrL({"MODA", 0}, 2),
                                    __arrL({"GAMES", 150}, 2),
                                    __arrL({"TÊNIS", 300}, 2),
                                    __arrL({"PERFUMES", 450}, 2),
                                    __arrL({"LIVROS", 2014}, 2),
                                    __arrL({"BRINQUEDOS", 2164}, 2)
                                },
                                6
                            ),
                            "map",
                            function(____, ____bindingPattern0)
                                local x
                                local n
                                n = ____bindingPattern0[1]
                                x = ____bindingPattern0[2]
                                return __arrL({
                                    x + 80,
                                    __L1.SHOP.TOP + 10,
                                    n,
                                    7,
                                    "#f6f2ea"
                                }, 5)
                            end
                        )
                    ),
                    interact = __arrL(
                        {
                            __arrL({"pot", 300}, 2),
                            __arrL({"pot", 4580}, 2),
                            __arrL({"trash", 1400}, 2),
                            __arrL({"trash", 3020}, 2),
                            __arrL({"ball", 2600}, 2),
                            __arrL({"crate", 4400}, 2),
                            __arrL({"crate", 4428, 1}, 3),
                            __arrL({"puddle", 1700, 70}, 3),
                            __arrL({"lever", 3200, "party"}, 3),
                            __arrL({"bucket", 1180}, 2)
                        },
                        10
                    )
                },
                "id,key,nome,lugar,width,draw,lights,amb,always,labels,interact"
            ),
            __ord(
                {
                    id = 21,
                    key = "olivia",
                    nome = "Olívia Flores e Escola SESI",
                    lugar = "Avenida Olívia Flores · Escola SESI",
                    width = __L1.OLIVIA.W * 2,
                    draw = __L1.olivia,
                    lights = __L1.oliviaLights,
                    always = true,
                    labels = __arrL(
                        {
                            __arrL({
                                600,
                                165,
                                "AVENIDA OLÍVIA FLORES",
                                9,
                                "#f2efe6"
                            }, 5),
                            __arrL({
                                750,
                                182,
                                "CICLOVIA",
                                6,
                                "#2a2a2a"
                            }, 5),
                            __arrL({
                                __L1.OLIVIA.SESI + 120,
                                92,
                                "ESCOLA SESI",
                                10,
                                "#2c5a9e"
                            }, 5),
                            __arrL({
                                __L1.OLIVIA.SESI + 440,
                                80,
                                "QUADRA COBERTA",
                                7,
                                "#2c3a44"
                            }, 5),
                            __arrL({
                                __L1.OLIVIA.SESI + 740,
                                104,
                                "AUDITÓRIO",
                                7,
                                "#2c5a9e"
                            }, 5),
                            __arrL({
                                __L1.OLIVIA.SESI + 990,
                                104,
                                "LABORATÓRIO DE INFORMÁTICA",
                                6,
                                "#2c5a9e"
                            }, 5),
                            __arrL({
                                __L1.OLIVIA.SESI + 935,
                                157,
                                "MURAL",
                                5,
                                "#2a2a2a"
                            }, 5)
                        },
                        7
                    ),
                    interact = __arrL(
                        {
                            __arrL({"ball", 3200}, 2),
                            __arrL({"ball", 3300}, 2),
                            __arrL({"ball", 3400}, 2),
                            __arrL({"cone", 3600}, 2),
                            __arrL({"cone", 3660}, 2),
                            __arrL({"trash", 2360}, 2),
                            __arrL({"trash", 3000}, 2),
                            __arrL({"pot", 2700}, 2),
                            __arrL({"lever", 3800, "bell"}, 3),
                            __arrL({
                                "door",
                                (__L1.OLIVIA.SESI + 720) * 2,
                                80,
                                120,
                                "class"
                            }, 5),
                            __arrL({"crate", 4700}, 2),
                            __arrL({"puddle", 1600, 70}, 3),
                            __arrL({"bucket", 4300}, 2)
                        },
                        13
                    )
                },
                "id,key,nome,lugar,width,draw,lights,always,labels,interact"
            )
        },
        10
    )
    __L1.LAYOUT = {
        ["12"] = __ord(
            {
                platforms = __arrL(
                    {
                        __arrL({1260, 384, 150}, 3),
                        __arrL({2100, 384, 150}, 3),
                        __arrL({2290, 328, 140}, 3),
                        __arrL({2480, 384, 150}, 3),
                        __arrL({3500, 384, 150}, 3)
                    },
                    5
                ),
                gaps = __arrL({}, 0)
            },
            "platforms,gaps"
        ),
        ["13"] = __ord(
            {
                platforms = __arrL(
                    {
                        __arrL({900, 384, 150}, 3),
                        __arrL({1100, 328, 140}, 3),
                        __arrL({2700, 384, 150}, 3),
                        __arrL({2900, 328, 140}, 3),
                        __arrL({3100, 384, 150}, 3)
                    },
                    5
                ),
                gaps = __arrL({}, 0)
            },
            "platforms,gaps"
        ),
        ["14"] = __ord(
            {
                platforms = __arrL(
                    {
                        __arrL({1300, 384, 150}, 3),
                        __arrL({1490, 328, 140}, 3),
                        __arrL({1680, 272, 140}, 3),
                        __arrL({2900, 384, 150}, 3),
                        __arrL({3090, 328, 140}, 3),
                        __arrL({4100, 384, 150}, 3)
                    },
                    6
                ),
                gaps = __arrL({}, 0)
            },
            "platforms,gaps"
        ),
        ["15"] = __ord(
            {
                platforms = __arrL(
                    {
                        __arrL({600, 384, 150}, 3),
                        __arrL({790, 320, 140}, 3),
                        __arrL({980, 256, 140}, 3),
                        __arrL({1170, 320, 140}, 3),
                        __arrL({1700, 384, 150}, 3),
                        __arrL({1890, 320, 140}, 3),
                        __arrL({2080, 256, 130}, 3),
                        __arrL({2270, 192, 130}, 3),
                        __arrL({2460, 256, 140}, 3),
                        __arrL({3100, 384, 150}, 3),
                        __arrL({3290, 320, 140}, 3),
                        __arrL({3480, 256, 140}, 3),
                        __arrL({3670, 320, 140}, 3),
                        __arrL({3860, 384, 150}, 3)
                    },
                    14
                ),
                gaps = __arrL(
                    {
                        __arrL({1420, 220}, 2),
                        __arrL({2730, 240}, 2),
                        __arrL({4060, 200}, 2)
                    },
                    3
                )
            },
            "platforms,gaps"
        ),
        ["16"] = __ord(
            {
                platforms = __arrL(
                    {
                        __arrL({1000, 384, 150}, 3),
                        __arrL({1900, 384, 150}, 3),
                        __arrL({2090, 328, 140}, 3),
                        __arrL({3500, 384, 150}, 3),
                        __arrL({3690, 328, 140}, 3),
                        __arrL({4700, 384, 150}, 3)
                    },
                    6
                ),
                gaps = __arrL(
                    {
                        __arrL({1400, 180}, 2),
                        __arrL({4300, 200}, 2)
                    },
                    2
                )
            },
            "platforms,gaps"
        ),
        ["17"] = __ord(
            {
                platforms = __arrL(
                    {
                        __arrL({700, 384, 150}, 3),
                        __arrL({890, 328, 140}, 3),
                        __arrL({1700, 384, 150}, 3),
                        __arrL({2700, 384, 150}, 3),
                        __arrL({2890, 328, 140}, 3),
                        __arrL({3080, 272, 140}, 3)
                    },
                    6
                ),
                gaps = __arrL({}, 0)
            },
            "platforms,gaps"
        ),
        ["18"] = __ord(
            {
                platforms = __arrL(
                    {
                        __arrL({900, 384, 150}, 3),
                        __arrL({1090, 328, 140}, 3),
                        __arrL({2200, 384, 150}, 3),
                        __arrL({2390, 320, 140}, 3),
                        __arrL({2580, 256, 140}, 3),
                        __arrL({3600, 384, 150}, 3),
                        __arrL({3790, 328, 140}, 3)
                    },
                    7
                ),
                gaps = __arrL(
                    {
                        __arrL({1500, 200}, 2),
                        __arrL({3200, 220}, 2)
                    },
                    2
                )
            },
            "platforms,gaps"
        ),
        ["19"] = __ord(
            {
                platforms = __arrL(
                    {
                        __arrL({800, 384, 150}, 3),
                        __arrL({990, 328, 140}, 3),
                        __arrL({1180, 272, 140}, 3),
                        __arrL({2400, 384, 150}, 3),
                        __arrL({2590, 320, 140}, 3),
                        __arrL({3500, 384, 150}, 3)
                    },
                    6
                ),
                gaps = __arrL({}, 0)
            },
            "platforms,gaps"
        ),
        ["20"] = __ord(
            {
                platforms = __arrL(
                    {
                        __arrL({700, 384, 150}, 3),
                        __arrL({890, 328, 140}, 3),
                        __arrL({1080, 272, 140}, 3),
                        __arrL({2600, 384, 150}, 3),
                        __arrL({2790, 328, 140}, 3),
                        __arrL({3500, 384, 150}, 3),
                        __arrL({4100, 384, 150}, 3),
                        __arrL({4290, 328, 140}, 3)
                    },
                    8
                ),
                gaps = __arrL({}, 0)
            },
            "platforms,gaps"
        ),
        ["21"] = __ord(
            {
                platforms = __arrL(
                    {
                        __arrL({1100, 384, 150}, 3),
                        __arrL({2700, 384, 150}, 3),
                        __arrL({2890, 328, 140}, 3),
                        __arrL({3080, 272, 140}, 3),
                        __arrL({3900, 384, 150}, 3),
                        __arrL({4090, 328, 140}, 3)
                    },
                    6
                ),
                gaps = __arrL({}, 0)
            },
            "platforms,gaps"
        )
    }
    __L1.OBJ = __ord(
        {
            banco = function(____, c, x)
                R(
                    nil,
                    c,
                    x,
                    __L1.GY - 9,
                    30,
                    3,
                    "#8a6a45"
                )
                R(
                    nil,
                    c,
                    x,
                    __L1.GY - 9,
                    30,
                    1,
                    "#c4955c"
                )
                R(
                    nil,
                    c,
                    x,
                    __L1.GY - 14,
                    30,
                    3,
                    "#8a6a45"
                )
                R(
                    nil,
                    c,
                    x,
                    __L1.GY - 14,
                    30,
                    1,
                    "#c4955c"
                )
                R(
                    nil,
                    c,
                    x + 2,
                    __L1.GY - 6,
                    4,
                    6,
                    "#8a8478"
                )
                R(
                    nil,
                    c,
                    x + 24,
                    __L1.GY - 6,
                    4,
                    6,
                    "#8a8478"
                )
            end,
            vaso = function(____, c, x, s)
                R(
                    nil,
                    c,
                    x,
                    __L1.GY - 14,
                    16,
                    14,
                    "#8a8478"
                )
                R(
                    nil,
                    c,
                    x,
                    __L1.GY - 14,
                    16,
                    2,
                    "#b4ae9e"
                )
                R(
                    nil,
                    c,
                    x + 2,
                    __L1.GY - 12,
                    12,
                    1,
                    "#5a4232"
                )
                do
                    local k = 0
                    while k < 7 do
                        ell(
                            nil,
                            c,
                            x + 3 + k * 1.7,
                            __L1.GY - 18 - __mod(k, 3) * 4,
                            3,
                            4,
                            if __t(__mod(k, 2)) then "#4f8a3a" else "#5f9a46"
                        )
                        k = k + 1
                    end
                end
                if __gt(
                    hash(nil, s),
                    0.4
                ) then
                    do
                        local k = 0
                        while k < 3 do
                            R(
                                nil,
                                c,
                                x + 3 + k * 4,
                                __L1.GY - 22 - __mod(k, 2) * 3,
                                2,
                                2,
                                __L1:pick(
                                    __arrL({"#e86a7a", "#f2c94c", "#f6f2ea", "#b86ad8"}, 4),
                                    s + k
                                )
                            )
                            k = k + 1
                        end
                    end
                end
            end,
            saco = function(____, c, x)
                ell(
                    nil,
                    c,
                    x + 5,
                    __L1.GY - 5,
                    6,
                    5,
                    "#1e1e22"
                )
                ell(
                    nil,
                    c,
                    x + 13,
                    __L1.GY - 4,
                    5,
                    4,
                    "#2a2a30"
                )
                R(
                    nil,
                    c,
                    x + 4,
                    __L1.GY - 11,
                    2,
                    2,
                    "#1e1e22"
                )
                R(
                    nil,
                    c,
                    x + 3,
                    __L1.GY - 7,
                    2,
                    1,
                    "#4a4a52"
                )
            end,
            caixa = function(____, c, x)
                R(
                    nil,
                    c,
                    x,
                    __L1.GY - 12,
                    16,
                    12,
                    "#b88a52"
                )
                R(
                    nil,
                    c,
                    x,
                    __L1.GY - 12,
                    16,
                    2,
                    "#d4a66a"
                )
                R(
                    nil,
                    c,
                    x + 7,
                    __L1.GY - 12,
                    2,
                    12,
                    "#9a6e3e"
                )
                R(
                    nil,
                    c,
                    x + 18,
                    __L1.GY - 8,
                    10,
                    8,
                    "#c49a62"
                )
                R(
                    nil,
                    c,
                    x + 18,
                    __L1.GY - 8,
                    10,
                    1,
                    "#dcb07a"
                )
            end,
            cavalete = function(____, c, x)
                limb(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x + 2, __L1.GY}, 2),
                            __arrL({x + 8, __L1.GY - 22}, 2)
                        },
                        2
                    ),
                    2,
                    "#4a3a2a"
                )
                limb(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x + 14, __L1.GY}, 2),
                            __arrL({x + 8, __L1.GY - 22}, 2)
                        },
                        2
                    ),
                    2,
                    "#4a3a2a"
                )
                R(
                    nil,
                    c,
                    x + 2,
                    __L1.GY - 21,
                    13,
                    16,
                    "#2a3a30"
                )
                R(
                    nil,
                    c,
                    x + 4,
                    __L1.GY - 19,
                    9,
                    2,
                    "#f2efe6"
                )
                R(
                    nil,
                    c,
                    x + 4,
                    __L1.GY - 15,
                    7,
                    1,
                    "#f2c94c"
                )
                R(
                    nil,
                    c,
                    x + 4,
                    __L1.GY - 12,
                    8,
                    1,
                    "#f2efe6"
                )
            end,
            pipoca = function(____, c, x)
                R(
                    nil,
                    c,
                    x,
                    __L1.GY - 26,
                    22,
                    18,
                    "#c43c3a"
                )
                R(
                    nil,
                    c,
                    x + 2,
                    __L1.GY - 24,
                    18,
                    10,
                    "#fff6d0"
                )
                do
                    local k = 0
                    while k < 8 do
                        R(
                            nil,
                            c,
                            x + 3 + __mod(k, 4) * 4,
                            __L1.GY - 22 + math.floor(k / 4) * 3,
                            2,
                            2,
                            "#f6e8a8"
                        )
                        k = k + 1
                    end
                end
                R(
                    nil,
                    c,
                    x - 2,
                    __L1.GY - 30,
                    26,
                    4,
                    "#f2c94c"
                )
                ell(
                    nil,
                    c,
                    x + 4,
                    __L1.GY - 3,
                    3,
                    3,
                    "#1c1c1c"
                )
                ell(
                    nil,
                    c,
                    x + 18,
                    __L1.GY - 3,
                    3,
                    3,
                    "#1c1c1c"
                )
                limb(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x + 22, __L1.GY - 12}, 2),
                            __arrL({x + 30, __L1.GY - 16}, 2)
                        },
                        2
                    ),
                    1,
                    "#5a5a56"
                )
            end,
            correio = function(____, c, x)
                R(
                    nil,
                    c,
                    x + 3,
                    __L1.GY - 8,
                    2,
                    8,
                    "#5a5a56"
                )
                R(
                    nil,
                    c,
                    x,
                    __L1.GY - 22,
                    9,
                    14,
                    "#f2c94c"
                )
                R(
                    nil,
                    c,
                    x,
                    __L1.GY - 22,
                    9,
                    3,
                    "#2c5aa8"
                )
                R(
                    nil,
                    c,
                    x + 2,
                    __L1.GY - 16,
                    5,
                    1,
                    "#2a2a2a"
                )
            end,
            cadeiras = function(____, c, x, s)
                local col = __L1:pick(
                    __arrL({"#f2f2ee", "#c43c3a", "#2c5aa8"}, 3),
                    s
                )
                do
                    local k = 0
                    while k < 2 do
                        local cx = x + k * 14
                        R(
                            nil,
                            c,
                            cx,
                            __L1.GY - 7,
                            9,
                            2,
                            col
                        )
                        R(
                            nil,
                            c,
                            cx,
                            __L1.GY - 14,
                            2,
                            7,
                            col
                        )
                        R(
                            nil,
                            c,
                            cx + 1,
                            __L1.GY - 5,
                            1,
                            5,
                            col
                        )
                        R(
                            nil,
                            c,
                            cx + 7,
                            __L1.GY - 5,
                            1,
                            5,
                            col
                        )
                        k = k + 1
                    end
                end
                R(
                    nil,
                    c,
                    x + 4,
                    __L1.GY - 12,
                    18,
                    2,
                    col
                )
                R(
                    nil,
                    c,
                    x + 12,
                    __L1.GY - 10,
                    2,
                    10,
                    col
                )
            end,
            pare = function(____, c, x)
                R(
                    nil,
                    c,
                    x + 4,
                    __L1.GY - 26,
                    2,
                    26,
                    "#8a8a86"
                )
                ell(
                    nil,
                    c,
                    x + 5,
                    __L1.GY - 30,
                    6,
                    6,
                    "#f2efe6"
                )
                ell(
                    nil,
                    c,
                    x + 5,
                    __L1.GY - 30,
                    5,
                    5,
                    "#c43c3a"
                )
                R(
                    nil,
                    c,
                    x + 2,
                    __L1.GY - 31,
                    7,
                    1,
                    "#f2efe6"
                )
            end,
            tronco = function(____, c, x)
                R(
                    nil,
                    c,
                    x,
                    __L1.GY - 8,
                    34,
                    8,
                    "#6a4a32"
                )
                R(
                    nil,
                    c,
                    x,
                    __L1.GY - 8,
                    34,
                    2,
                    "#8a6a45"
                )
                ell(
                    nil,
                    c,
                    x + 34,
                    __L1.GY - 4,
                    4,
                    4,
                    "#c8a06a"
                )
                ell(
                    nil,
                    c,
                    x + 34,
                    __L1.GY - 4,
                    2,
                    2,
                    "#9a7046"
                )
                R(
                    nil,
                    c,
                    x + 10,
                    __L1.GY - 10,
                    3,
                    2,
                    "#4f8a3a"
                )
                R(
                    nil,
                    c,
                    x + 22,
                    __L1.GY - 9,
                    2,
                    1,
                    "#5f9a46"
                )
            end,
            toco = function(____, c, x)
                R(
                    nil,
                    c,
                    x,
                    __L1.GY - 10,
                    12,
                    10,
                    "#6a4a32"
                )
                ell(
                    nil,
                    c,
                    x + 6,
                    __L1.GY - 10,
                    6,
                    2,
                    "#c8a06a"
                )
                R(
                    nil,
                    c,
                    x - 2,
                    __L1.GY - 2,
                    3,
                    2,
                    "#6a4a32"
                )
                R(
                    nil,
                    c,
                    x + 11,
                    __L1.GY - 2,
                    3,
                    2,
                    "#6a4a32"
                )
            end,
            pedras = function(____, c, x)
                ell(
                    nil,
                    c,
                    x + 6,
                    __L1.GY - 4,
                    7,
                    5,
                    "#8a8a80"
                )
                ell(
                    nil,
                    c,
                    x + 4,
                    __L1.GY - 6,
                    4,
                    2,
                    "#a6a69a"
                )
                ell(
                    nil,
                    c,
                    x + 16,
                    __L1.GY - 3,
                    5,
                    3,
                    "#7a7a70"
                )
            end,
            cupim = function(____, c, x)
                do
                    local k = 0
                    while k < 10 do
                        R(
                            nil,
                            c,
                            x + 8 - (10 - k) * 0.7,
                            __L1.GY - k * 2.2,
                            (10 - k) * 1.4 + 2,
                            3,
                            if __t(__mod(k, 2)) then "#b07a4a" else "#a06a3e"
                        )
                        k = k + 1
                    end
                end
            end,
            carrinhoMao = function(____, c, x)
                R(
                    nil,
                    c,
                    x + 4,
                    __L1.GY - 12,
                    20,
                    7,
                    "#3c6a8a"
                )
                R(
                    nil,
                    c,
                    x + 4,
                    __L1.GY - 12,
                    20,
                    1,
                    "#6a9ab8"
                )
                ell(
                    nil,
                    c,
                    x + 6,
                    __L1.GY - 3,
                    3,
                    3,
                    "#1c1c1c"
                )
                limb(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x + 24, __L1.GY - 10}, 2),
                            __arrL({x + 34, __L1.GY - 14}, 2)
                        },
                        2
                    ),
                    1,
                    "#6a4a32"
                )
                R(
                    nil,
                    c,
                    x + 22,
                    __L1.GY - 5,
                    2,
                    5,
                    "#6a6a66"
                )
            end,
            regador = function(____, c, x)
                R(
                    nil,
                    c,
                    x,
                    __L1.GY - 8,
                    10,
                    8,
                    "#3c8a5a"
                )
                limb(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x + 10, __L1.GY - 6}, 2),
                            __arrL({x + 15, __L1.GY - 10}, 2)
                        },
                        2
                    ),
                    1,
                    "#3c8a5a"
                )
                R(
                    nil,
                    c,
                    x + 2,
                    __L1.GY - 11,
                    6,
                    2,
                    "#3c8a5a"
                )
            end,
            placaTrilha = function(____, c, x)
                R(
                    nil,
                    c,
                    x + 6,
                    __L1.GY - 22,
                    2,
                    22,
                    "#6a4a32"
                )
                R(
                    nil,
                    c,
                    x,
                    __L1.GY - 24,
                    18,
                    7,
                    "#8a6a45"
                )
                R(
                    nil,
                    c,
                    x + 16,
                    __L1.GY - 23,
                    3,
                    5,
                    "#8a6a45"
                )
                R(
                    nil,
                    c,
                    x + 2,
                    __L1.GY - 22,
                    12,
                    1,
                    "#f2e8c8"
                )
            end,
            bagagem = function(____, c, x)
                R(
                    nil,
                    c,
                    x,
                    __L1.GY - 4,
                    30,
                    3,
                    "#8a949a"
                )
                ell(
                    nil,
                    c,
                    x + 4,
                    __L1.GY - 1,
                    2,
                    2,
                    "#1c1c1c"
                )
                ell(
                    nil,
                    c,
                    x + 26,
                    __L1.GY - 1,
                    2,
                    2,
                    "#1c1c1c"
                )
                R(
                    nil,
                    c,
                    x + 28,
                    __L1.GY - 22,
                    2,
                    18,
                    "#8a949a"
                )
                R(
                    nil,
                    c,
                    x + 2,
                    __L1.GY - 14,
                    12,
                    10,
                    "#c43c3a"
                )
                R(
                    nil,
                    c,
                    x + 14,
                    __L1.GY - 18,
                    12,
                    14,
                    "#3c6aa8"
                )
                R(
                    nil,
                    c,
                    x + 4,
                    __L1.GY - 20,
                    8,
                    6,
                    "#e8c24c"
                )
            end,
            pisoMolhado = function(____, c, x)
                limb(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x + 2, __L1.GY}, 2),
                            __arrL({x + 7, __L1.GY - 18}, 2)
                        },
                        2
                    ),
                    2,
                    "#f2c94c"
                )
                limb(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x + 12, __L1.GY}, 2),
                            __arrL({x + 7, __L1.GY - 18}, 2)
                        },
                        2
                    ),
                    2,
                    "#e8b83a"
                )
                R(
                    nil,
                    c,
                    x + 4,
                    __L1.GY - 12,
                    6,
                    4,
                    "#2a2a2a"
                )
                R(
                    nil,
                    c,
                    x + 6,
                    __L1.GY - 11,
                    2,
                    2,
                    "#f2c94c"
                )
            end,
            isopor = function(____, c, x)
                R(
                    nil,
                    c,
                    x,
                    __L1.GY - 11,
                    18,
                    11,
                    "#eef4f6"
                )
                R(
                    nil,
                    c,
                    x,
                    __L1.GY - 11,
                    18,
                    3,
                    "#3e7cc0"
                )
                R(
                    nil,
                    c,
                    x + 6,
                    __L1.GY - 7,
                    6,
                    2,
                    "#c43c3a"
                )
            end
        },
        "banco,vaso,saco,caixa,cavalete,pipoca,correio,cadeiras,pare,tronco,toco,pedras,cupim,carrinhoMao,regador,placaTrilha,bagagem,pisoMolhado,isopor"
    )
    __L1.SET = __ord(
        {
            cidade = __arrL({
                "banco",
                "vaso",
                "saco",
                "caixa",
                "cavalete",
                "pipoca",
                "correio",
                "cadeiras",
                "pare",
                "isopor"
            }, 10),
            natureza = __arrL({
                "tronco",
                "toco",
                "pedras",
                "cupim",
                "carrinhoMao",
                "regador",
                "placaTrilha",
                "pedras"
            }, 8),
            interno = __arrL({
                "bagagem",
                "pisoMolhado",
                "cadeiras",
                "vaso",
                "banco"
            }, 5)
        },
        "cidade,natureza,interno"
    )
    __L1.Q = function(____, c, x, y, w, h, col)
        c.fillStyle = col
        c:fillRect(
            math.floor(x / 2 + 0.5) * 2,
            math.floor(y / 2 + 0.5) * 2,
            math.max(
                2,
                math.floor(w / 2 + 0.5) * 2
            ),
            math.max(
                2,
                math.floor(h / 2 + 0.5) * 2
            )
        )
    end
    __L1.QL = function(____, c, pts, w, col)
        do
            local i = 1
            while __lt(
                i,
                __len(pts)
            ) do
                local a = __get(pts, i - 1)
                local b = __get(pts, i)
                local n = math.max(
                    1,
                    math.ceil(__hypot(
                        __get(b, 0) - __get(a, 0),
                        __get(b, 1) - __get(a, 1)
                    ) / 2)
                )
                do
                    local k = 0
                    while k <= n do
                        __L1:Q(
                            c,
                            __get(a, 0) + (__get(b, 0) - __get(a, 0)) * k / n - w / 2,
                            __get(a, 1) + (__get(b, 1) - __get(a, 1)) * k / n - w / 2,
                            w,
                            w,
                            col
                        )
                        k = k + 1
                    end
                end
                i = i + 1
            end
        end
    end
    __L1.PLAT = {
        ["12"] = function(____, c, x, y, w, t, sd)
            __L1:sombra(c, x, y, w)
            __L1:Q(
                c,
                x - 2,
                y - 2,
                w + 4,
                18,
                "#2a3036"
            )
            __L1:Q(
                c,
                x,
                y,
                w,
                6,
                "#9aa4ac"
            )
            do
                local k = 2
                while k < w - 2 do
                    do
                        local j = 0
                        while j < 4 do
                            __L1:Q(
                                c,
                                x + k,
                                y + 2 + j,
                                2,
                                2,
                                "#5a646c"
                            )
                            j = j + 4
                        end
                    end
                    k = k + 4
                end
            end
            __L1:Q(
                c,
                x,
                y,
                w,
                2,
                "#c8d0d6"
            )
            do
                local k = 0
                while __lt(k, w) do
                    __L1:Q(
                        c,
                        x + k,
                        y + 6,
                        4,
                        6,
                        "#f2c230"
                    )
                    __L1:Q(
                        c,
                        x + k + 4,
                        y + 6,
                        4,
                        6,
                        "#1e1e20"
                    )
                    k = k + 8
                end
            end
            __L1:Q(
                c,
                x,
                y + 12,
                w,
                4,
                "#5a646c"
            )
            do
                local k = 6
                while __lt(k, w) do
                    __L1:Q(
                        c,
                        x + k,
                        y + 13,
                        2,
                        2,
                        "#b8c0c6"
                    )
                    k = k + 20
                end
            end
            for ____, sx in __iterar((__arrL(
                {
                    x + 14,
                    __add(x, w) - 18
                },
                2
            ))) do
                __L1:QL(
                    c,
                    __arrL(
                        {
                            __arrL({sx, y + 16}, 2),
                            __arrL({sx + 6, y + 30}, 2)
                        },
                        2
                    ),
                    2,
                    "#4a545c"
                )
                __L1:QL(
                    c,
                    __arrL(
                        {
                            __arrL({sx + 6, y + 16}, 2),
                            __arrL({sx, y + 30}, 2)
                        },
                        2
                    ),
                    2,
                    "#4a545c"
                )
            end
            __L1:Q(
                c,
                x + math.floor(hash(nil, sd) * (w - 20) + 0.5),
                y + 14,
                6,
                2,
                "#8a4a2a"
            )
        end,
        ["13"] = function(____, c, x, y, w, t, sd)
            __L1:sombra(c, x, y, w)
            local pint = __L1:pick(
                __arrL({
                    "#e8a87a",
                    "#8ac0b0",
                    "#e8d07a",
                    "#c8a8d8",
                    "#9ac0e0"
                }, 5),
                sd
            )
            __L1:concretoBase(
                c,
                x,
                y,
                w,
                24,
                "#e2ded2",
                "#c8c2b4",
                sd
            )
            __L1:Q(
                c,
                x,
                y + 6,
                w,
                6,
                pint
            )
            __L1:Q(
                c,
                x,
                y + 6,
                w,
                2,
                __L1:shadeHex(pint, 1.15)
            )
            __L1:Q(
                c,
                x,
                y + 12,
                w,
                6,
                "#ece8de"
            )
            do
                local k = 0
                while __lt(k, w) do
                    __L1:Q(
                        c,
                        x + k,
                        y + 12 + __mod(k / 4, 2) * 2,
                        2,
                        2,
                        "#4a8ac0"
                    )
                    __L1:Q(
                        c,
                        x + k + 2,
                        y + 14 - __mod(k / 4, 2) * 2,
                        2,
                        2,
                        "#f2efe6"
                    )
                    k = k + 4
                end
            end
            __L1:Q(
                c,
                x,
                y + 18,
                w,
                2,
                "#9a948a"
            )
            for ____, ex in __iterar((__arrL(
                {
                    x - 6,
                    __add(x, w) + 2
                },
                2
            ))) do
                __L1:Q(
                    c,
                    ex,
                    y + 4,
                    4,
                    2,
                    "#8a5a3a"
                )
                __L1:Q(
                    c,
                    ex,
                    y + 10,
                    4,
                    2,
                    "#8a5a3a"
                )
            end
            local vx = x + 10 + math.floor(hash(nil, sd + 1) * (w - 40) + 0.5)
            __L1:Q(
                c,
                vx,
                y - 10,
                12,
                10,
                "#b8643a"
            )
            __L1:Q(
                c,
                vx,
                y - 10,
                12,
                2,
                "#d8844a"
            )
            do
                local k = 0
                while k < 4 do
                    __L1:Q(
                        c,
                        vx + 1 + k * 3,
                        y - 16 - __mod(k, 2) * 4,
                        4,
                        6,
                        if __t(__mod(k, 2)) then "#4f8a3a" else "#5f9a46"
                    )
                    k = k + 1
                end
            end
            __L1:Q(
                c,
                vx + 4,
                y - 20,
                4,
                4,
                __L1:pick(
                    __arrL({"#e86a7a", "#f2c94c", "#f6f2ea"}, 3),
                    sd
                )
            )
            __L1:Q(
                c,
                x + math.floor(hash(nil, sd + 2) * (w - 10) + 0.5),
                y + 14,
                2,
                6,
                "#9a948a"
            )
        end,
        ["14"] = function(____, c, x, y, w, t, sd)
            __L1:sombra(c, x, y, w)
            __L1:Q(
                c,
                x - 4,
                y - 2,
                w + 8,
                6,
                "#3a3630"
            )
            __L1:Q(
                c,
                x - 2,
                y + 14,
                w + 4,
                4,
                "rgba(40,32,20,.25)"
            )
            __L1:Q(
                c,
                x - 2,
                y,
                w + 4,
                4,
                "#efe6cf"
            )
            __L1:Q(
                c,
                x,
                y + 4,
                w,
                4,
                "#dcd0b4"
            )
            __L1:Q(
                c,
                x + 2,
                y + 8,
                w - 4,
                4,
                "#c8bc9e"
            )
            __L1:Q(
                c,
                x + 4,
                y + 12,
                w - 8,
                2,
                "#a89c80"
            )
            do
                local i = 0
                while i < w / 6 do
                    __L1:Q(
                        c,
                        x + hash(nil, i + sd) * w,
                        y + 4 + hash(nil, i * 3 + sd) * 8,
                        2,
                        2,
                        "#bfb398"
                    )
                    i = i + 1
                end
            end
            do
                local k = 10
                while k < w - 10 do
                    __L1:Q(
                        c,
                        x + k,
                        y + 14,
                        8,
                        6,
                        "#cfc3a6"
                    )
                    __L1:Q(
                        c,
                        x + k + 2,
                        y + 20,
                        4,
                        4,
                        "#bfb398"
                    )
                    __L1:Q(
                        c,
                        x + k + 2,
                        y + 16,
                        2,
                        2,
                        "#9a8e74"
                    )
                    k = k + 30
                end
            end
            if __gt(
                hash(nil, sd + 5),
                0.3
            ) then
                local px = x + 20 + math.floor(hash(nil, sd + 6) * (w - 40) + 0.5)
                local bob = math.floor(math.max(
                    0,
                    math.sin(t * 3 + sd)
                ) * 2 + 0.5)
                __L1:Q(
                    c,
                    px,
                    y - 8,
                    10,
                    6,
                    "#8a8f98"
                )
                __L1:Q(
                    c,
                    px + 8,
                    y - 12 + bob,
                    6,
                    6,
                    "#6a6f78"
                )
                __L1:Q(
                    c,
                    px + 12,
                    y - 10 + bob,
                    2,
                    2,
                    "#e8a83a"
                )
                __L1:Q(
                    c,
                    px + 8,
                    y - 8 + bob,
                    4,
                    2,
                    "#4aa05a"
                )
                __L1:Q(
                    c,
                    px + 2,
                    y - 2,
                    2,
                    2,
                    "#c87a6a"
                )
                __L1:Q(
                    c,
                    px + 6,
                    y - 2,
                    2,
                    2,
                    "#c87a6a"
                )
            end
        end,
        ["15"] = function(____, c, x, y, w, t, sd) return __L1:ilhaTerra(
            c,
            x,
            y,
            w,
            t,
            sd,
            {
                top = "#6f9a3a",
                top2 = "#9cc45a",
                soil = "#7a5a3a",
                dark = "#5a4028",
                rock = "#8a8a80",
                cacto = true
            }
        ) end,
        ["16"] = function(____, c, x, y, w, t, sd)
            __L1:sombra(c, x, y, w)
            __L1:Q(
                c,
                x - 2,
                y - 2,
                w + 4,
                22,
                "#3a3a38"
            )
            __L1:Q(
                c,
                x + 4,
                y,
                w - 8,
                8,
                "#c8c6be"
            )
            __L1:Q(
                c,
                x,
                y + 8,
                w,
                12,
                "#b4b2aa"
            )
            __L1:Q(
                c,
                x + 4,
                y,
                w - 8,
                2,
                "#e4e2da"
            )
            __L1:Q(
                c,
                x,
                y + 8,
                w,
                2,
                "#d0cec6"
            )
            do
                local k = 8
                while k < w - 8 do
                    __L1:Q(
                        c,
                        x + k,
                        y + 12,
                        8,
                        4,
                        "#f2c230"
                    )
                    __L1:Q(
                        c,
                        x + k,
                        y + 12,
                        8,
                        2,
                        "#fff2a0"
                    )
                    k = k + 24
                end
            end
            do
                local i = 0
                while i < w / 5 do
                    __L1:Q(
                        c,
                        x + hash(nil, i + sd) * w,
                        y + 4 + hash(nil, i * 3 + sd) * 14,
                        2,
                        2,
                        "#a4a29a"
                    )
                    i = i + 1
                end
            end
            local gx = x + 10 + math.floor(hash(nil, sd) * (w - 50) + 0.5)
            do
                local k = 0
                while k < 30 do
                    __L1:Q(
                        c,
                        gx + k,
                        y + 10 + math.floor(math.sin(k * 0.5 + sd) * 3 + 0.5),
                        2,
                        2,
                        __L1:pick(
                            __arrL({"#e8433a", "#3c9ad8", "#2a2a2a"}, 3),
                            sd
                        )
                    )
                    k = k + 2
                end
            end
        end,
        ["17"] = function(____, c, x, y, w, t, sd)
            __L1:sombra(c, x, y, w)
            do
                local k = 0
                while __lt(k, w) do
                    local cw = math.min(30, w - k)
                    __L1:Q(
                        c,
                        x + k,
                        y,
                        cw,
                        20,
                        "#5a3a22"
                    )
                    __L1:Q(
                        c,
                        x + k + 2,
                        y + 2,
                        cw - 4,
                        16,
                        "#b8864a"
                    )
                    do
                        local j = 0
                        while j < 3 do
                            __L1:Q(
                                c,
                                x + k + 2,
                                y + 4 + j * 5,
                                cw - 4,
                                2,
                                "#8a5a30"
                            )
                            j = j + 1
                        end
                    end
                    __L1:Q(
                        c,
                        x + k + 2,
                        y + 2,
                        cw - 4,
                        2,
                        "#d8a66a"
                    )
                    k = k + 30
                end
            end
            do
                local k = 4
                while k < w - 4 do
                    local col = __L1:pick(
                        __arrL({
                            "#f08a24",
                            "#e84a3a",
                            "#f2c94c",
                            "#7cbf6a",
                            "#c43c5a"
                        }, 5),
                        k + sd
                    )
                    __L1:Q(
                        c,
                        x + k,
                        y - 6,
                        6,
                        6,
                        col
                    )
                    __L1:Q(
                        c,
                        x + k + 2,
                        y - 6,
                        2,
                        2,
                        "#ffffff66"
                    )
                    k = k + 7
                end
            end
        end,
        ["18"] = function(____, c, x, y, w, t, sd) return __L1:ilhaTerra(
            c,
            x,
            y,
            w,
            t,
            sd,
            {
                top = "#5f8a3a",
                top2 = "#86b04a",
                soil = "#8a4a2e",
                dark = "#6a3620",
                rock = "#9a7a5a",
                cafe = true
            }
        ) end,
        ["19"] = function(____, c, x, y, w, t, sd)
            __L1:sombra(c, x, y, w)
            __L1:Q(
                c,
                x,
                y,
                w,
                6,
                "#1e1c22"
            )
            __L1:Q(
                c,
                x,
                y,
                w,
                2,
                "#3a3842"
            )
            __L1:Q(
                c,
                x,
                y + 8,
                w,
                2,
                "#c8ccd2"
            )
            __L1:Q(
                c,
                x,
                y + 20,
                w,
                2,
                "#c8ccd2"
            )
            do
                local k = 0
                while k < w - 6 do
                    __L1:QL(
                        c,
                        __arrL(
                            {
                                __arrL({x + k, y + 9}, 2),
                                __arrL({x + k + 6, y + 20}, 2)
                            },
                            2
                        ),
                        2,
                        "#a8aeb6"
                    )
                    __L1:QL(
                        c,
                        __arrL(
                            {
                                __arrL({x + k + 6, y + 20}, 2),
                                __arrL({x + k + 12, y + 9}, 2)
                            },
                            2
                        ),
                        2,
                        "#a8aeb6"
                    )
                    k = k + 12
                end
            end
            do
                local k = 6
                while k < w - 6 do
                    local on = __mod(
                        math.floor(t * 4) + k / 16,
                        3
                    ) ~= 0
                    __L1:Q(
                        c,
                        x + k,
                        y + 22,
                        4,
                        4,
                        if __t(on) then __L1:pick(
                            __arrL({"#ffe39a", "#ff6a8a", "#6ac8ff"}, 3),
                            k + sd
                        ) else "#5a5040"
                    )
                    k = k + 16
                end
            end
        end,
        ["20"] = function(____, c, x, y, w, t, sd)
            __L1:sombra(c, x, y, w)
            c.fillStyle = "rgba(160,214,232,.55)"
            c:fillRect(
                math.floor(x + 0.5),
                math.floor(y + 4 + 0.5),
                math.floor(w + 0.5),
                12
            )
            __L1:Q(
                c,
                x - 2,
                y,
                w + 4,
                4,
                "#dfe6ea"
            )
            __L1:Q(
                c,
                x - 2,
                y,
                w + 4,
                2,
                "#ffffff"
            )
            __L1:Q(
                c,
                x - 2,
                y + 16,
                w + 4,
                2,
                "#9aa6ae"
            )
            do
                local k = 12
                while __lt(k, w) do
                    __L1:QL(
                        c,
                        __arrL(
                            {
                                __arrL({x + k, y + 14}, 2),
                                __arrL({x + k + 8, y + 6}, 2)
                            },
                            2
                        ),
                        2,
                        "rgba(255,255,255,.7)"
                    )
                    k = k + 40
                end
            end
            for ____, px in __iterar((__arrL(
                {
                    x + 2,
                    __add(x, w) - 14
                },
                2
            ))) do
                __L1:Q(
                    c,
                    px,
                    y - 8,
                    12,
                    8,
                    "#5a6066"
                )
                do
                    local k = 0
                    while k < 4 do
                        __L1:Q(
                            c,
                            px + k * 3,
                            y - 14 - __mod(k, 2) * 4,
                            4,
                            6,
                            if __t(__mod(k, 2)) then "#4f8a3a" else "#5f9a46"
                        )
                        k = k + 1
                    end
                end
            end
        end,
        ["21"] = function(____, c, x, y, w, t, sd)
            __L1:sombra(c, x, y, w)
            __L1:concretoBase(
                c,
                x,
                y,
                w,
                18,
                "#e8e6de",
                "#d4d0c6",
                sd
            )
            __L1:Q(
                c,
                x,
                y + 8,
                w,
                4,
                "#2c5a9e"
            )
            __L1:Q(
                c,
                x,
                y + 12,
                w,
                2,
                "#f2f2ee"
            )
            do
                local k = 0
                while __lt(k, w) do
                    __L1:Q(
                        c,
                        x + k,
                        y - 2 - math.floor(hash(nil, k + sd) * 4 + 0.5),
                        2,
                        4,
                        if __t(__mod(k, 2)) then "#5f9a46" else "#79b04a"
                    )
                    k = k + 3
                end
            end
            __L1:Q(
                c,
                x,
                y,
                w,
                2,
                "#4f8a3a"
            )
        end
    }
    __L1.hx = function(____, h)
        local n = __TS__ParseInt(
            __call(
                tostring(h),
                "slice",
                1
            ),
            16
        )
        return __arrL(
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
        )
    end
    __L1.mixH = function(____, a, b, k)
        local A = __L1:hx(a)
        local B = __L1:hx(b)
        return ("rgb(" .. tostring(__call(
            __call(
                A,
                "map",
                function(____, v, i) return math.floor(v + (__get(B, i) - v) * k + 0.5) end
            ),
            "join",
            ","
        ))) .. ")"
    end
    __L1.textOf = function(____, d) return function(____, c, camera)
        c:save()
        c:translate(
            -math.floor(camera + 0.5),
            0
        )
        local ____iter_113 = __iter
        local ____call_112 = __call
        local ____temp_111 = if __t(d.labels) then d.labels else __arrL({}, 0)
        local ____t_110 = __t
        local ____opt_107 = __L1:CAM()
        if ____opt_107 ~= nil then
            ____opt_107 = ____opt_107.falas
        end
        local ____opt_result_109
        if ____opt_107 ~= nil then
            ____opt_result_109 = ____opt_107(____opt_107, d.id, camera)
        end
        __O[406] = ____opt_result_109
        for ____, lb in __TS__Iterator(____iter_113(____call_112(____temp_111, "concat", if ____t_110(____opt_result_109) then __O[406] else __arrL({}, 0)))) do
            local x, y, str, size, col = table.unpack(lb, 1, 5)
            local a = if __t(d.labelAlpha) then d:labelAlpha(lb) else 1
            if __le(a, 0.01) then
                continue
            end
            c.globalAlpha = a
            __L1:text(
                c,
                str,
                x * 2,
                y * 2,
                size,
                col
            )
        end
        c:restore()
    end end
    __L1.PUBLIC = __arrL({}, 0)
    for ____, d in __iterar((__call(__L1.LIST, "slice"))) do
        __L1:registrar(d)
    end
    local ____opt_114 = window.Art
    if ____opt_114 ~= nil then
        ____opt_114 = ____opt_114.drawScene
    end
    __L1.baseScene = ____opt_114
    if __t(__L1.baseScene) then
        window.Art.drawScene = function(self, c, scene, camera, t)
            if camera == nil then
                camera = 0
            end
            if t == nil then
                t = 0
            end
            local ____t_118 = __t
            local ____t_117 = __t
            local ____ge_result_116 = __ge(scene, 12)
            __O[407] = ____ge_result_116
            __D[1] = if not ____t_118(if ____t_117(____ge_result_116) then __call(
                __L1.LIST,
                "some",
                function(____, d) return d.id == scene end
            ) else __O[407]) then
                return __L1:baseScene(c, scene, camera, t)
            end
            c:save()
            c.imageSmoothingEnabled = false
            c:beginPath()
            c:rect(0, 0, 960, 540)
            c:clip()
            local ____t_126 = __t
            local ____self_124 = window.HdMaps
            local ____self_124_draw_125 = ____self_124.draw
            local ____array_123 = __TS__SparseArrayNew(c, scene)
            local ____t_120 = __t
            local ____TS__Number_result_119 = __TS__Number(camera)
            __O[408] = ____TS__Number_result_119
            __TS__SparseArrayPush(____array_123, if ____t_120(____TS__Number_result_119) then __O[408] else 0)
            local ____t_122 = __t
            local ____TS__Number_result_121 = __TS__Number(t)
            __O[409] = ____TS__Number_result_121
            __TS__SparseArrayPush(____array_123, if ____t_122(____TS__Number_result_121) then __O[409] else 0)
            if ____t_126(____self_124_draw_125(
                ____self_124,
                __TS__SparseArraySpread(____array_123)
            )) then
                window.HdMaps:finish(c, scene)
            end
            c:restore()
        end
    end
    __L1.arte = __ord(
        {
            K = __L1.K,
            GY = __L1.GY,
            R = R,
            ell = ell,
            mk = mk,
            hash = hash,
            cl = cl,
            mix = mix,
            dither = dither,
            limb = limb,
            sky = sky,
            haze = haze,
            tile = tile,
            tree = tree,
            slant = slant,
            sunInfo = sunInfo,
            sunWall = sunWall,
            board = board,
            bench = bench,
            lampPost = lampPost,
            lampGlow = lampGlow,
            shadeAdd = shadeAdd,
            lightAdd = lightAdd,
            vis = __L1.vis,
            night = __L1.night,
            text = __L1.text,
            shadeHex = __L1.shadeHex,
            pick = __L1.pick,
            plaster = __L1.plaster,
            brick = __L1.brick,
            azulejo = __L1.azulejo,
            roofTiles = __L1.roofTiles,
            janela = __L1.janela,
            ac = __L1.ac,
            caixaDagua = __L1.caixaDagua,
            antena = __L1.antena,
            parabolica = __L1.parabolica,
            varal = __L1.varal,
            gato = __L1.gato,
            cachorro = __L1.cachorro,
            plantaVaso = __L1.plantaVaso,
            grafite = __L1.grafite,
            cartaz = __L1.cartaz,
            bandeirinhas = __L1.bandeirinhas,
            predio = __L1.predio,
            loja = __L1.loja,
            casa = __L1.casa,
            orelhao = __L1.orelhao,
            banca = __L1.banca,
            ponto = __L1.ponto,
            lixeira = __L1.lixeira,
            hidrante = __L1.hidrante,
            placaRua = __L1.placaRua,
            moto = __L1.moto,
            bike = __L1.bike,
            carro = __L1.carro,
            poste = __L1.poste,
            fios = __L1.fios,
            canteiro = __L1.canteiro,
            ipe = __L1.ipe,
            mesaBar = __L1.mesaBar,
            calcada = __L1.calcada,
            asfalto = __L1.asfalto,
            pedraPortuguesa = __L1.pedraPortuguesa,
            pisoInterno = __L1.pisoInterno,
            terra = __L1.terra,
            conquistaBack = __L1.conquistaBack,
            fog = __L1.fog,
            cityNight = __L1.cityNight,
            passaros = __L1.passaros,
            pipas = __L1.pipas,
            gente = __L1.gente,
            pessoa = __L1.pessoa,
            coluna = __L1.coluna,
            reflexo = __L1.reflexo,
            vgrad = __L1.vgrad,
            lerpC = __L1.lerpC,
            produtos = __L1.produtos,
            lojaFrente = __L1.lojaFrente,
            OBJ = __L1.OBJ,
            objetos = __L1.objetos,
            chaoDetalhe = __L1.chaoDetalhe,
            ilhaTerra = __L1.ilhaTerra,
            sombra = function(____, c, x, y, w) return __L1:sombra(c, x, y, w) end,
            Q = __L1.Q,
            QL = __L1.QL,
            concretoBase = __L1.concretoBase,
            shopFar = function()
                local ____temp_127 = __L1:buildShopFar()
                __L1.SHOPFAR = ____temp_127
                return if __t(__L1.SHOPFAR) then __L1.SHOPFAR else ____temp_127
            end,
            SHOP = __L1.SHOP,
            heroiPos = function() return __L1.HERO end,
            lojas = function(____, id)
                local ____call_130 = __call
                local ____t_129 = __t
                local ____get_result_128 = __get(__L1.LOJAS, id)
                __O[410] = ____get_result_128
                return ____call_130(if ____t_129(____get_result_128) then __O[410] else __arrL({}, 0), "slice")
            end,
            FAR = function()
                local ____temp_131 = __L1:buildFar()
                __L1.FAR = ____temp_131
                return if __t(__L1.FAR) then __L1.FAR else ____temp_131
            end,
            cenaAtual = function() return __L1.CUR end,
            BAIRRO = __L1.BAIRRO,
            CENTRO = __L1.CENTRO,
            SERRA = __L1.SERRA,
            AVENIDA = __L1.AVENIDA,
            FEIRA = __L1.FEIRA,
            CAFE = __L1.CAFE,
            CULTURA = __L1.CULTURA,
            OLIVIA = __L1.OLIVIA,
            AIR = __L1.AIR,
            cathedral = __L1.cathedral,
            rocha = __L1.rocha,
            cactus = __L1.cactus,
            barraca = __L1.barraca,
            ac = __L1.ac
        },
        "K,GY,R,ell,mk,hash,cl,mix,dither,limb,sky,haze,tile,tree,slant,sunInfo,sunWall,board,bench,lampPost,lampGlow,shadeAdd,lightAdd,vis,night,text,shadeHex,pick,plaster,brick,azulejo,roofTiles,janela,ac,caixaDagua,antena,parabolica,varal,gato,cachorro,plantaVaso,grafite,cartaz,bandeirinhas,predio,loja,casa,orelhao,banca,ponto,lixeira,hidrante,placaRua,moto,bike,carro,poste,fios,canteiro,ipe,mesaBar,calcada,asfalto,pedraPortuguesa,pisoInterno,terra,conquistaBack,fog,cityNight,passaros,pipas,gente,pessoa,coluna,reflexo,vgrad,lerpC,produtos,lojaFrente,OBJ,objetos,chaoDetalhe,ilhaTerra,sombra,Q,QL,concretoBase,shopFar,SHOP,heroiPos,lojas,FAR,cenaAtual,BAIRRO,CENTRO,SERRA,AVENIDA,FEIRA,CAFE,CULTURA,OLIVIA,AIR,cathedral,rocha,cactus,barraca,ac"
    )
    window.CampanhaCenarios = __ord(
        __getters(
            {
                largura = function(____, id)
                    local ____t_134 = __t
                    local ____opt_132 = __call(
                        __L1.LIST,
                        "find",
                        function(____, d) return d.id == id end
                    )
                    if ____opt_132 ~= nil then
                        ____opt_132 = ____opt_132.width
                    end
                    __O[411] = ____opt_132
                    return if ____t_134(____opt_132) then __O[411] else 0
                end,
                layout = function(____, id)
                    local ____t_136 = __t
                    local ____get_result_135 = __get(__L1.LAYOUT, id)
                    __O[412] = ____get_result_135
                    return if ____t_136(____get_result_135) then __O[412] else nil
                end,
                plataforma = __L1.plataforma,
                heroi = __L1.heroi,
                registrar = __L1.registrar,
                arte = __L1.arte
            },
            {lista = function()
                return __call(__L1.PUBLIC, "slice")
            end}
        ),
        "lista,largura,layout,plataforma,heroi,registrar,arte"
    )
end)(nil)
return ____exports
