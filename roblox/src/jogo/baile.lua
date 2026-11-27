--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __le, __gt, __ge, __isFiniteN, __mod, __ord, __arrL, __iterar, __t, __get, __set = __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__isFiniteN, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set
local __len, __setlen, __call, __add, __iter, __assign, __hypot = __JSR.__len, __JSR.__setlen, __JSR.__call, __JSR.__add, __JSR.__iter, __JSR.__assign, __JSR.__hypot
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__Spread = ____lualib.__TS__Spread
local ____exports = {}
local __O = {};
(function()
    local rect, oval, line, text, glow, dancerHD, drawOllyan, pixelPoly, drawOllyanClassic, ollyanNoBaile, event, setBonuses, burst, phaseChange, W, FLOOR, NPC_X, TAU, clamp, finite, palette, phases, isLite, BPM
    function rect(self, c, x, y, w, h, color)
        c.fillStyle = color
        c:fillRect(
            math.floor(x + 0.5),
            math.floor(y + 0.5),
            math.floor(w + 0.5),
            math.floor(h + 0.5)
        )
    end
    function oval(self, c, x, y, rx, ry, color)
        c.fillStyle = color
        c:beginPath()
        c:ellipse(
            math.floor(x + 0.5),
            math.floor(y + 0.5),
            rx,
            ry,
            0,
            0,
            TAU
        )
        __call(c, "fill")
    end
    function line(self, c, points, color, width)
        if width == nil then
            width = 2
        end
        c.strokeStyle = color
        c.lineWidth = width
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
        c:stroke()
    end
    function text(self, c, value, x, y, size, color, align)
        if size == nil then
            size = 14
        end
        if color == nil then
            color = "#f4e8bd"
        end
        if align == nil then
            align = "center"
        end
        c:save()
        c.font = __add(
            __add("bold ", size),
            "px monospace"
        )
        c.textAlign = align
        c.textBaseline = "middle"
        c.fillStyle = "#101a30"
        c:fillText(value, x + 1, y + 2)
        c.fillStyle = color
        c:fillText(value, x, y)
        c:restore()
    end
    function glow(self, c, x, y, r, color, alpha)
        if alpha == nil then
            alpha = 0.2
        end
        c:save()
        c.globalAlpha = c.globalAlpha * alpha
        local g = c:createRadialGradient(
            x,
            y,
            0,
            x,
            y,
            r
        )
        g:addColorStop(0, color)
        g:addColorStop(1, "#00000000")
        c.fillStyle = g
        c:fillRect(x - r, y - r, r * 2, r * 2)
        c:restore()
    end
    function dancerHD(self, c, x, y, t, seed, scale)
        if seed == nil then
            seed = 0
        end
        if scale == nil then
            scale = 1
        end
        local skin = __get(
            __arrL({
                "#8d583f",
                "#e4b596",
                "#b47c55",
                "#6f4838",
                "#eec9ae",
                "#5c3a2c"
            }, 6),
            __mod(seed, 6)
        )
        local skinSh = __get(
            __arrL({
                "#6d4231",
                "#c4937a",
                "#8f603f",
                "#55362a",
                "#cfa98e",
                "#43291f"
            }, 6),
            __mod(seed, 6)
        )
        local top = __get(
            __arrL({
                "#e2445c",
                "#2d9cdb",
                "#f2c94c",
                "#27ae60",
                "#9b51e0",
                "#f2f2f2",
                "#1d1d1d",
                "#ff7a45"
            }, 8),
            __mod(seed * 3, 8)
        )
        local bottom = __get(
            __arrL({
                "#29374c",
                "#3c3a55",
                "#1f2a36",
                "#5a3a2a",
                "#d6d0c4"
            }, 5),
            __mod(seed * 5, 5)
        )
        local hairC = __get(
            __arrL({
                "#1b1414",
                "#3a2418",
                "#6b3e22",
                "#c9a050",
                "#1b1414",
                "#7a2a4a"
            }, 6),
            __mod(seed * 7, 6)
        )
        local move = __mod(seed, 5)
        local beat = t * BPM * math.pi * 2 + seed
        local b = math.max(
            0,
            math.sin(beat)
        )
        local sw = math.sin(beat * 0.5) * 6
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        c:scale(scale, scale)
        oval(
            nil,
            c,
            0,
            0,
            14,
            3,
            "#0c101d70"
        )
        local hop = if move == 2 then b * 6 else b * 2.5
        local lean = if move == 3 then math.sin(beat * 0.5) * 0.12 else 0
        local fA = if move == 1 then math.sin(beat) * 9 else sw * 0.4
        local fB = if move == 1 then -math.sin(beat) * 9 else -sw * 0.4
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({-5, -24}, 2),
                    __arrL({-7 + fA * 0.4, -12}, 2),
                    __arrL({-8 + fA, -2}, 2)
                },
                3
            ),
            bottom,
            7
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({5, -24}, 2),
                    __arrL({7 + fB * 0.4, -12}, 2),
                    __arrL({8 + fB, -2}, 2)
                },
                3
            ),
            bottom,
            7
        )
        rect(
            nil,
            c,
            -13 + fA,
            -4,
            11,
            4,
            "#e9ecef"
        )
        rect(
            nil,
            c,
            4 + fB,
            -4,
            11,
            4,
            if __t(__mod(seed, 3)) then "#e9ecef" else "#ff5a5a"
        )
        c:translate(sw * 0.2, -hop)
        c:rotate(lean)
        rect(
            nil,
            c,
            -11,
            -48,
            22,
            26,
            "#151a28"
        )
        rect(
            nil,
            c,
            -9,
            -46,
            18,
            23,
            top
        )
        rect(
            nil,
            c,
            3,
            -46,
            6,
            23,
            "#00000022"
        )
        if __mod(seed, 4) == 0 then
            rect(
                nil,
                c,
                -9,
                -40,
                18,
                3,
                "#ffffff55"
            )
        end
        if __mod(seed, 6) == 1 then
            text(
                nil,
                c,
                tostring(__mod(seed, 90) + 10),
                0,
                -34,
                8,
                "#ffffff"
            )
        end
        local la
        local ra
        if move == 0 then
            la = __arrL(
                {
                    __arrL({-9, -44}, 2),
                    __arrL({-18, -56 + sw}, 2),
                    __arrL({-14, -70 + sw}, 2)
                },
                3
            )
            ra = __arrL(
                {
                    __arrL({9, -44}, 2),
                    __arrL({18, -58 - sw}, 2),
                    __arrL({13, -72 - sw}, 2)
                },
                3
            )
        elseif move == 1 then
            la = __arrL(
                {
                    __arrL({-9, -44}, 2),
                    __arrL({-18, -34}, 2),
                    __arrL({-12, -26}, 2)
                },
                3
            )
            ra = __arrL(
                {
                    __arrL({9, -44}, 2),
                    __arrL({19, -36}, 2),
                    __arrL({14, -28}, 2)
                },
                3
            )
        elseif move == 2 then
            la = __arrL(
                {
                    __arrL({-9, -44}, 2),
                    __arrL({-20, -52 - b * 6}, 2),
                    __arrL({-26, -60 - b * 8}, 2)
                },
                3
            )
            ra = __arrL(
                {
                    __arrL({9, -44}, 2),
                    __arrL({20, -52 - b * 6}, 2),
                    __arrL({26, -60 - b * 8}, 2)
                },
                3
            )
        elseif move == 3 then
            la = __arrL(
                {
                    __arrL({-9, -44}, 2),
                    __arrL({-16, -38 + sw}, 2),
                    __arrL({-22, -46 + sw}, 2)
                },
                3
            )
            ra = __arrL(
                {
                    __arrL({9, -44}, 2),
                    __arrL({16, -50}, 2),
                    __arrL({8, -62}, 2)
                },
                3
            )
        else
            la = __arrL(
                {
                    __arrL({-9, -44}, 2),
                    __arrL({-17, -36}, 2),
                    __arrL({-18, -28}, 2)
                },
                3
            )
            ra = __arrL(
                {
                    __arrL({9, -44}, 2),
                    __arrL({18, -54}, 2),
                    __arrL(
                        {
                            20,
                            -68 + math.sin(beat) * 4
                        },
                        2
                    )
                },
                3
            )
        end
        line(
            nil,
            c,
            la,
            skin,
            5
        )
        line(
            nil,
            c,
            ra,
            skin,
            5
        )
        if move == 3 then
            local hx = __get(
                __get(ra, 2),
                0
            )
            local hy = __get(
                __get(ra, 2),
                1
            )
            rect(
                nil,
                c,
                hx - 3,
                hy - 8,
                7,
                11,
                "#111"
            )
            rect(
                nil,
                c,
                hx - 2,
                hy - 7,
                5,
                8,
                "#9fd8ff"
            )
            glow(
                nil,
                c,
                hx,
                hy - 3,
                16,
                "#9fd8ff",
                0.25
            )
        end
        if __mod(seed, 7) == 2 then
            local hx = __get(
                __get(la, 2),
                0
            )
            local hy = __get(
                __get(la, 2),
                1
            )
            local col = __get(
                __arrL({"#7dff9a", "#ff7ad9", "#7adfff"}, 3),
                __mod(seed, 3)
            )
            line(
                nil,
                c,
                __arrL(
                    {
                        __arrL({hx, hy}, 2),
                        __arrL({hx - 4, hy - 14}, 2)
                    },
                    2
                ),
                col,
                3
            )
            glow(
                nil,
                c,
                hx - 2,
                hy - 7,
                14,
                col,
                0.35
            )
        end
        rect(
            nil,
            c,
            -8,
            -64,
            16,
            17,
            "#151a28"
        )
        rect(
            nil,
            c,
            -7,
            -63,
            14,
            15,
            skin
        )
        rect(
            nil,
            c,
            3,
            -63,
            4,
            15,
            skinSh
        )
        local style = __mod(seed * 11, 5)
        if style == 0 then
            oval(
                nil,
                c,
                0,
                -64,
                11,
                9,
                hairC
            )
        elseif style == 1 then
            rect(
                nil,
                c,
                -8,
                -66,
                16,
                5,
                hairC
            )
            rect(
                nil,
                c,
                -9,
                -62,
                3,
                14,
                hairC
            )
            rect(
                nil,
                c,
                6,
                -62,
                3,
                14,
                hairC
            )
        elseif style == 2 then
            rect(
                nil,
                c,
                -9,
                -66,
                18,
                5,
                __get(
                    __arrL({"#e2445c", "#1d1d1d", "#2d9cdb"}, 3),
                    __mod(seed, 3)
                )
            )
            rect(
                nil,
                c,
                0,
                -63,
                12,
                2,
                __get(
                    __arrL({"#e2445c", "#1d1d1d", "#2d9cdb"}, 3),
                    __mod(seed, 3)
                )
            )
        elseif style == 3 then
            rect(
                nil,
                c,
                -8,
                -66,
                16,
                5,
                hairC
            )
            for ____, bx in __iterar((__arrL({-10, -8, 7, 9}, 4))) do
                rect(
                    nil,
                    c,
                    bx,
                    -63,
                    2,
                    17,
                    hairC
                )
            end
        else
            rect(
                nil,
                c,
                -7,
                -65,
                14,
                3,
                hairC
            )
        end
        rect(
            nil,
            c,
            -4,
            -57,
            2,
            2,
            "#1b1414"
        )
        rect(
            nil,
            c,
            2,
            -57,
            2,
            2,
            "#1b1414"
        )
        rect(
            nil,
            c,
            -2,
            -52,
            5,
            2,
            if b > 0.5 then "#8b3a3a" else "#6a3a32"
        )
        c:restore()
    end
    function drawOllyan(self, c, x, y, t, o)
        if t == nil then
            t = 0
        end
        if o == nil then
            o = {}
        end
        local ____t_29 = __t
        local ____opt_26 = window.BailePixel
        if ____opt_26 ~= nil then
            ____opt_26 = ____opt_26.ollyan
        end
        local ____opt_result_28
        if ____opt_26 ~= nil then
            ____opt_result_28 = ____opt_26(
                ____opt_26,
                c,
                x,
                y,
                t,
                o
            )
        end
        if ____t_29(____opt_result_28) then
            return
        end
        if __t(if __t(o.flying) then o.flying else isLite(nil)) then
            if __t(if __t(o.flying) then not __t(isLite(nil)) else o.flying) then
                c:save()
                c:translate(
                    math.floor(x + 0.5),
                    math.floor(y + 0.5)
                )
                c:scale(0.84, 1.04)
                drawOllyanClassic(
                    nil,
                    c,
                    0,
                    0,
                    t,
                    o
                )
                c:restore()
                return
            end
            return drawOllyanClassic(
                nil,
                c,
                x,
                y,
                t,
                o
            )
        end
        local scale = finite(nil, o.scale, 1)
        local face = if o.facing == -1 then -1 else 1
        local skin = "#ebc4ab"
        local flush = "#e07a74"
        local ink = "#121722"
        local hood = "#262b38"
        local hoodSh = "#181c27"
        local sway = math.sin(t * 1.7) * 0.16 + math.sin(t * 3.1) * 0.05
        local lag = math.sin(t * 1.7 - 0.6) * 0.12
        local stepL = math.sin(t * 1.7) * 6
        local stepR = -math.sin(t * 1.7 + 0.8) * 5
        c:save()
        c.imageSmoothingEnabled = false
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        c:scale(face * scale, scale)
        oval(
            nil,
            c,
            0,
            0,
            16,
            4,
            "#0c101d80"
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({-4, -44}, 2),
                    __arrL({-6 + stepL * 0.5, -22}, 2),
                    __arrL({-7 + stepL, -2}, 2)
                },
                3
            ),
            skin,
            4
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({4, -44}, 2),
                    __arrL({6 + stepR * 0.5, -22}, 2),
                    __arrL({7 + stepR, -2}, 2)
                },
                3
            ),
            skin,
            4
        )
        rect(
            nil,
            c,
            -12 + stepL,
            -5,
            12,
            5,
            "#f2f2f2"
        )
        rect(
            nil,
            c,
            3 + stepR,
            -5,
            12,
            5,
            "#f2f2f2"
        )
        rect(
            nil,
            c,
            -12 + stepL,
            -1,
            12,
            2,
            "#c9ced6"
        )
        rect(
            nil,
            c,
            3 + stepR,
            -1,
            12,
            2,
            "#c9ced6"
        )
        pixelPoly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-10, -58}, 2),
                    __arrL({10, -58}, 2),
                    __arrL({11, -40}, 2),
                    __arrL({-11, -40}, 2)
                },
                4
            ),
            "#3a4766",
            2
        )
        rect(
            nil,
            c,
            -1,
            -58,
            2,
            18,
            "#2a3550"
        )
        c:rotate(sway)
        pixelPoly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-9, -96}, 2),
                    __arrL({9, -96}, 2),
                    __arrL({11, -58}, 2),
                    __arrL({-11, -58}, 2)
                },
                4
            ),
            ink,
            2
        )
        pixelPoly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-7, -94}, 2),
                    __arrL({7, -94}, 2),
                    __arrL({9, -60}, 2),
                    __arrL({-9, -60}, 2)
                },
                4
            ),
            hood,
            2
        )
        pixelPoly(
            nil,
            c,
            __arrL(
                {
                    __arrL({2, -94}, 2),
                    __arrL({7, -94}, 2),
                    __arrL({9, -60}, 2),
                    __arrL({3, -60}, 2)
                },
                4
            ),
            hoodSh,
            2
        )
        rect(
            nil,
            c,
            -3 + math.floor(lag * 10 + 0.5),
            -92,
            1,
            14,
            "#d9dde3"
        )
        rect(
            nil,
            c,
            3 + math.floor(lag * 10 + 0.5),
            -92,
            1,
            13,
            "#d9dde3"
        )
        rect(
            nil,
            c,
            -6,
            -72,
            12,
            6,
            "#1c2130"
        )
        local flail = math.sin(t * 2.6) * 10
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({-8, -90}, 2),
                    __arrL({-18, -78 + flail * 0.3}, 2),
                    __arrL({-26, -66 + flail}, 2)
                },
                3
            ),
            hood,
            4
        )
        rect(
            nil,
            c,
            -29,
            -68 + flail,
            5,
            5,
            skin
        )
        local cupX = 20
        local cupY = -74 + math.sin(t * 1.7) * 3
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({8, -90}, 2),
                    __arrL({16, -80}, 2),
                    __arrL({cupX - 2, cupY + 6}, 2)
                },
                3
            ),
            hood,
            4
        )
        rect(
            nil,
            c,
            cupX - 4,
            cupY + 3,
            5,
            5,
            skin
        )
        if o.cup ~= false then
            rect(
                nil,
                c,
                cupX - 2,
                cupY - 10,
                9,
                13,
                "#e8392e"
            )
            rect(
                nil,
                c,
                cupX - 2,
                cupY - 10,
                9,
                2,
                "#f4f4f4"
            )
            local slosh = math.sin(t * 3.4)
            if slosh > 0.7 then
                do
                    local i = 0
                    while i < 3 do
                        rect(
                            nil,
                            c,
                            cupX + 6 + i * 2,
                            cupY - 8 + i * 4 + math.floor((slosh - 0.7) * 20 + 0.5),
                            2,
                            2,
                            "#d8b25a"
                        )
                        i = i + 1
                    end
                end
            end
        end
        c:save()
        c:translate(0, -100)
        c:rotate(-lag * 1.4)
        for ____, side in __iterar((__arrL({-1, 1}, 2))) do
            pixelPoly(
                nil,
                c,
                __arrL(
                    {
                        __arrL({side * 9, -12}, 2),
                        __arrL({side * 24, -20}, 2),
                        __arrL({side * 30, -12}, 2),
                        __arrL({side * 24, -2}, 2),
                        __arrL({side * 10, -4}, 2)
                    },
                    5
                ),
                ink,
                2
            )
            pixelPoly(
                nil,
                c,
                __arrL(
                    {
                        __arrL({side * 11, -11}, 2),
                        __arrL({side * 22, -17}, 2),
                        __arrL({side * 26, -11}, 2),
                        __arrL({side * 21, -5}, 2),
                        __arrL({side * 12, -6}, 2)
                    },
                    5
                ),
                skin,
                2
            )
            rect(
                nil,
                c,
                if side > 0 then 14 else -20,
                -12,
                6,
                3,
                flush
            )
        end
        pixelPoly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-10, -22}, 2),
                    __arrL({10, -22}, 2),
                    __arrL({12, -6}, 2),
                    __arrL({6, 4}, 2),
                    __arrL({-6, 4}, 2),
                    __arrL({-12, -6}, 2)
                },
                6
            ),
            ink,
            2
        )
        pixelPoly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-8, -20}, 2),
                    __arrL({8, -20}, 2),
                    __arrL({10, -6}, 2),
                    __arrL({5, 2}, 2),
                    __arrL({-5, 2}, 2),
                    __arrL({-10, -6}, 2)
                },
                6
            ),
            skin,
            2
        )
        pixelPoly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-10, -22}, 2),
                    __arrL({0, -27}, 2),
                    __arrL({10, -22}, 2),
                    __arrL({11, -15}, 2),
                    __arrL({5, -17}, 2),
                    __arrL({0, -15}, 2),
                    __arrL({-6, -17}, 2),
                    __arrL({-11, -15}, 2)
                },
                8
            ),
            "#141a25",
            2
        )
        rect(
            nil,
            c,
            -9,
            -6,
            6,
            3,
            flush
        )
        rect(
            nil,
            c,
            4,
            -6,
            6,
            3,
            flush
        )
        rect(
            nil,
            c,
            -2,
            -10,
            4,
            4,
            "#f2a39a"
        )
        local lid = if math.sin(t * 0.9) > 0.85 then 1 else 0
        rect(
            nil,
            c,
            -7,
            -12,
            5,
            if __t(lid) then 1 else 3,
            "#f2e4d7"
        )
        rect(
            nil,
            c,
            3,
            -12,
            5,
            if __t(lid) then 1 else 3,
            "#f2e4d7"
        )
        if not __t(lid) then
            rect(
                nil,
                c,
                -6,
                -11,
                2,
                2,
                "#2a2230"
            )
            rect(
                nil,
                c,
                4,
                -11,
                2,
                2,
                "#2a2230"
            )
        end
        rect(
            nil,
            c,
            -8,
            -13,
            6,
            2,
            "#3a2a2e"
        )
        rect(
            nil,
            c,
            2,
            -13,
            6,
            2,
            "#3a2a2e"
        )
        rect(
            nil,
            c,
            -4,
            -2,
            8,
            2,
            "#6f4047"
        )
        rect(
            nil,
            c,
            2,
            -3,
            3,
            2,
            "#6f4047"
        )
        c:restore()
        if __t(o.hit) then
            c.globalAlpha = 0.25
            rect(
                nil,
                c,
                -18,
                -130,
                36,
                130,
                "#fff3d9"
            )
            c.globalAlpha = 1
        end
        c:restore()
        local hic = __mod(t * 0.45, 1)
        if __t(hic < 0.3 and o.cup ~= false) then
            c:save()
            c.globalAlpha = 1 - hic / 0.3
            text(
                nil,
                c,
                "hic!",
                x + face * 22,
                y - 150 - hic * 30,
                11,
                "#ffd0e0"
            )
            c:restore()
        end
    end
    function pixelPoly(self, c, points, color, unit)
        if unit == nil then
            unit = 2
        end
        local minX = math.floor(math.min(__TS__Spread(__iter(__call(
            points,
            "map",
            function(____, p) return __get(p, 0) end
        )))) / unit) * unit
        local maxX = math.ceil(math.max(__TS__Spread(__iter(__call(
            points,
            "map",
            function(____, p) return __get(p, 0) end
        )))) / unit) * unit
        local minY = math.floor(math.min(__TS__Spread(__iter(__call(
            points,
            "map",
            function(____, p) return __get(p, 1) end
        )))) / unit) * unit
        local maxY = math.ceil(math.max(__TS__Spread(__iter(__call(
            points,
            "map",
            function(____, p) return __get(p, 1) end
        )))) / unit) * unit
        c.fillStyle = color
        do
            local y = minY
            while y < maxY do
                do
                    local x = minX
                    while x < maxX do
                        local px = x + unit * 0.5
                        local py = y + unit * 0.5
                        local inside = false
                        do
                            local i = 0
                            local j = __len(points) - 1
                            while __lt(
                                i,
                                __len(points)
                            ) do
                                local a = __get(points, i)
                                local b = __get(points, j)
                                if __t(__gt(
                                    __get(a, 1),
                                    py
                                ) ~= __gt(
                                    __get(b, 1),
                                    py
                                ) and __lt(
                                    px,
                                    (__get(b, 0) - __get(a, 0)) * (py - __get(a, 1)) / (__get(b, 1) - __get(a, 1)) + __get(a, 0)
                                )) then
                                    inside = not __t(inside)
                                end
                                local ____i_36 = i
                                i = ____i_36 + 1
                                j = ____i_36
                            end
                        end
                        if __t(inside) then
                            c:fillRect(x, y, unit, unit)
                        end
                        x = x + unit
                    end
                end
                y = y + unit
            end
        end
    end
    function drawOllyanClassic(self, c, x, y, t, o)
        if t == nil then
            t = 0
        end
        if o == nil then
            o = {}
        end
        local flying = not not __t(o.flying)
        local flap = math.floor(math.sin(t * if __t(o.fast) then 15 else 10) * 4 + 0.5)
        local sway = if __t(flying) then math.sin(t * 2) * 0.018 else math.sin(t * 2.3) * 0.027
        local scale = finite(nil, o.scale, 1)
        local skin = "#e7c2a9"
        local shadow = "#c18e7d"
        c:save()
        c.imageSmoothingEnabled = false
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        c:scale(if o.facing == -1 then __TS__Number(-scale) else scale, scale)
        c:rotate(finite(nil, o.angle, 0) + sway)
        if __t(o.aura) then
            glow(
                nil,
                c,
                0,
                -44,
                97,
                o.aura,
                0.19
            )
            do
                local i = 0
                while i < 6 do
                    local a = t * 0.8 + i * TAU / 6
                    rect(
                        nil,
                        c,
                        math.cos(a) * 79,
                        -44 + math.sin(a) * 66,
                        3,
                        6,
                        o.aura
                    )
                    i = i + 1
                end
            end
        end
        for ____, side in __iterar((__arrL({-1, 1}, 2))) do
            c:save()
            c:scale(side, 1)
            if __t(flying) then
                pixelPoly(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({12, -80}, 2),
                            __arrL({28, -87 - flap}, 2),
                            __arrL({48, -91 - flap}, 2),
                            __arrL({72, -91 - flap * 2}, 2),
                            __arrL({98, -86 - flap * 2}, 2),
                            __arrL({128, -76 - flap}, 2),
                            __arrL({116, -64 + flap}, 2),
                            __arrL({92, -56 + flap}, 2),
                            __arrL({63, -55 + flap}, 2),
                            __arrL({39, -60}, 2),
                            __arrL({16, -62}, 2)
                        },
                        11
                    ),
                    palette.ink,
                    3
                )
                pixelPoly(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({17, -77}, 2),
                            __arrL({31, -82 - flap}, 2),
                            __arrL({50, -86 - flap}, 2),
                            __arrL({72, -86 - flap * 2}, 2),
                            __arrL({97, -81 - flap * 2}, 2),
                            __arrL({119, -75 - flap}, 2),
                            __arrL({110, -68 + flap}, 2),
                            __arrL({89, -62 + flap}, 2),
                            __arrL({64, -61 + flap}, 2),
                            __arrL({41, -65}, 2),
                            __arrL({18, -66}, 2)
                        },
                        11
                    ),
                    skin,
                    3
                )
                pixelPoly(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({26, -74}, 2),
                            __arrL({51, -79 - flap}, 2),
                            __arrL({77, -78 - flap}, 2),
                            __arrL({100, -74 - flap}, 2),
                            __arrL({82, -68 + flap}, 2),
                            __arrL({54, -67}, 2),
                            __arrL({31, -68}, 2)
                        },
                        7
                    ),
                    shadow,
                    3
                )
                rect(
                    nil,
                    c,
                    48,
                    -82 - flap,
                    15,
                    3,
                    "#f4d9bf"
                )
                rect(
                    nil,
                    c,
                    71,
                    -81 - flap * 2,
                    18,
                    3,
                    "#f2d7be"
                )
                rect(
                    nil,
                    c,
                    24,
                    -73,
                    10,
                    3,
                    "#bd8d7e"
                )
            else
                pixelPoly(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({11, -82}, 2),
                            __arrL({25, -88}, 2),
                            __arrL({41, -83}, 2),
                            __arrL({45, -74}, 2),
                            __arrL({38, -64}, 2),
                            __arrL({20, -61}, 2),
                            __arrL({11, -66}, 2)
                        },
                        7
                    ),
                    palette.ink,
                    2
                )
                pixelPoly(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({15, -78}, 2),
                            __arrL({25, -83}, 2),
                            __arrL({37, -80}, 2),
                            __arrL({39, -73}, 2),
                            __arrL({34, -68}, 2),
                            __arrL({21, -66}, 2),
                            __arrL({15, -69}, 2)
                        },
                        7
                    ),
                    skin,
                    2
                )
                rect(
                    nil,
                    c,
                    24,
                    -78,
                    9,
                    3,
                    shadow
                )
                rect(
                    nil,
                    c,
                    23,
                    -74,
                    3,
                    6,
                    shadow
                )
            end
            c:restore()
        end
        local leg = if __t(flying) then math.floor(math.sin(t * 7) * 2 + 0.5) else math.floor(math.sin(t * 3) * 2 + 0.5)
        pixelPoly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-10, -26}, 2),
                    __arrL({-2, -26}, 2),
                    __arrL({-4, -12}, 2),
                    __arrL({-7 + leg, -2}, 2),
                    __arrL({-14 + leg, -2}, 2)
                },
                5
            ),
            "#192538",
            2
        )
        pixelPoly(
            nil,
            c,
            __arrL(
                {
                    __arrL({3, -26}, 2),
                    __arrL({11, -26}, 2),
                    __arrL({14, -12}, 2),
                    __arrL({17 - leg, -2}, 2),
                    __arrL({9 - leg, -2}, 2)
                },
                5
            ),
            "#233046",
            2
        )
        rect(
            nil,
            c,
            -18 + leg,
            -4,
            13,
            6,
            "#bdc8d0"
        )
        rect(
            nil,
            c,
            7 - leg,
            -3,
            14,
            5,
            "#cbd2d5"
        )
        pixelPoly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-10, -60}, 2),
                    __arrL({-17, -55}, 2),
                    __arrL({-15, -31}, 2),
                    __arrL({-11, -24}, 2),
                    __arrL({10, -24}, 2),
                    __arrL({15, -31}, 2),
                    __arrL({17, -54}, 2),
                    __arrL({10, -60}, 2)
                },
                8
            ),
            "#111823",
            2
        )
        pixelPoly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-8, -57}, 2),
                    __arrL({-13, -52}, 2),
                    __arrL({-10, -30}, 2),
                    __arrL({10, -30}, 2),
                    __arrL({13, -51}, 2),
                    __arrL({8, -57}, 2)
                },
                6
            ),
            "#252a36",
            2
        )
        rect(
            nil,
            c,
            -7,
            -46,
            14,
            2,
            "#464957"
        )
        rect(
            nil,
            c,
            -7,
            -36,
            14,
            6,
            "#1c2330"
        )
        rect(
            nil,
            c,
            -3,
            -55,
            2,
            11,
            "#b7bcc4"
        )
        rect(
            nil,
            c,
            5,
            -55,
            2,
            11,
            "#b7bcc4"
        )
        local handY = if __t(flying) then -32 else -27
        pixelPoly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-15, -54}, 2),
                    __arrL({-20, -51}, 2),
                    __arrL({-23, -37}, 2),
                    __arrL({-24, handY}, 2),
                    __arrL({-18, handY + 2}, 2),
                    __arrL({-17, -36}, 2),
                    __arrL({-12, -49}, 2)
                },
                7
            ),
            "#111925",
            2
        )
        pixelPoly(
            nil,
            c,
            __arrL(
                {
                    __arrL({14, -54}, 2),
                    __arrL({19, -51}, 2),
                    __arrL({22, -37}, 2),
                    __arrL({25, handY - 2}, 2),
                    __arrL({19, handY + 1}, 2),
                    __arrL({16, -36}, 2),
                    __arrL({12, -49}, 2)
                },
                7
            ),
            "#172031",
            2
        )
        rect(
            nil,
            c,
            -26,
            handY - 3,
            7,
            8,
            skin
        )
        rect(
            nil,
            c,
            19,
            handY - 5,
            7,
            8,
            skin
        )
        if __t(not __t(flying) and o.cup ~= false) then
            rect(
                nil,
                c,
                21,
                handY - 11,
                9,
                13,
                "#dedfcf"
            )
            rect(
                nil,
                c,
                22,
                handY - 10,
                7,
                5,
                "#a68b63"
            )
            rect(
                nil,
                c,
                21,
                handY - 12,
                9,
                2,
                "#fff0cf"
            )
        end
        local head = __arrL(
            {
                __arrL({0, -96}, 2),
                __arrL({11, -91}, 2),
                __arrL({17, -80}, 2),
                __arrL({13, -68}, 2),
                __arrL({5, -59}, 2),
                __arrL({0, -56}, 2),
                __arrL({-6, -60}, 2),
                __arrL({-14, -69}, 2),
                __arrL({-17, -80}, 2),
                __arrL({-11, -91}, 2)
            },
            10
        )
        pixelPoly(
            nil,
            c,
            head,
            palette.ink,
            2
        )
        pixelPoly(
            nil,
            c,
            __arrL(
                {
                    __arrL({0, -92}, 2),
                    __arrL({9, -88}, 2),
                    __arrL({13, -79}, 2),
                    __arrL({10, -69}, 2),
                    __arrL({4, -62}, 2),
                    __arrL({0, -60}, 2),
                    __arrL({-5, -64}, 2),
                    __arrL({-11, -71}, 2),
                    __arrL({-13, -80}, 2),
                    __arrL({-9, -88}, 2)
                },
                10
            ),
            skin,
            2
        )
        pixelPoly(
            nil,
            c,
            __arrL(
                {
                    __arrL({7, -85}, 2),
                    __arrL({12, -78}, 2),
                    __arrL({9, -70}, 2),
                    __arrL({4, -64}, 2),
                    __arrL({0, -61}, 2),
                    __arrL({0, -67}, 2),
                    __arrL({5, -72}, 2)
                },
                7
            ),
            "#d3a38b",
            2
        )
        pixelPoly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-11, -91}, 2),
                    __arrL({0, -96}, 2),
                    __arrL({10, -91}, 2),
                    __arrL({15, -83}, 2),
                    __arrL({8, -82}, 2),
                    __arrL({5, -87}, 2),
                    __arrL({0, -85}, 2),
                    __arrL({-6, -86}, 2),
                    __arrL({-12, -82}, 2)
                },
                9
            ),
            "#141a25",
            2
        )
        rect(
            nil,
            c,
            -13,
            -82,
            3,
            6,
            "#171d27"
        )
        rect(
            nil,
            c,
            10,
            -82,
            3,
            6,
            "#171d27"
        )
        rect(
            nil,
            c,
            -11,
            -80,
            4,
            2,
            "#30262b"
        )
        rect(
            nil,
            c,
            -7,
            -78,
            4,
            2,
            "#30262b"
        )
        rect(
            nil,
            c,
            3,
            -78,
            4,
            2,
            "#30262b"
        )
        rect(
            nil,
            c,
            7,
            -80,
            4,
            2,
            "#30262b"
        )
        rect(
            nil,
            c,
            -10,
            -75,
            7,
            4,
            "#f2e4d7"
        )
        rect(
            nil,
            c,
            3,
            -75,
            7,
            4,
            "#f2e4d7"
        )
        rect(
            nil,
            c,
            -5,
            -75,
            2,
            4,
            "#222938"
        )
        rect(
            nil,
            c,
            3,
            -75,
            2,
            4,
            "#222938"
        )
        rect(
            nil,
            c,
            -1,
            -73,
            3,
            7,
            shadow
        )
        rect(
            nil,
            c,
            -4,
            -65,
            9,
            2,
            "#6f4047"
        )
        rect(
            nil,
            c,
            -2,
            -63,
            7,
            2,
            "#f4dfcd"
        )
        rect(
            nil,
            c,
            -10,
            -69,
            4,
            2,
            "#d79b91"
        )
        rect(
            nil,
            c,
            8,
            -69,
            3,
            2,
            "#d79b91"
        )
        if __t(o.hit) then
            c.globalAlpha = 0.25
            rect(
                nil,
                c,
                -18,
                -95,
                36,
                72,
                "#fff3d9"
            )
        end
        c:restore()
    end
    function ollyanNoBaile(self, c, camera, t, opts)
        local ____t_59 = __t
        local ____t_58 = __t
        local ____t_56 = __t
        local ____temp_55 = not __t(opts.hideOllyan) and not __t(opts.defeated)
        __O[1357] = ____temp_55
        local ____temp_57 = if ____t_56(____temp_55) then NPC_X - camera > -100 else __O[1357]
        __O[1358] = ____temp_57
        if ____t_59(if ____t_58(____temp_57) then NPC_X - camera < W + 100 else __O[1358]) then
            drawOllyan(
                nil,
                c,
                NPC_X - camera,
                FLOOR,
                t,
                {cup = true}
            )
            text(
                nil,
                c,
                "OLLYAN",
                NPC_X - camera,
                FLOOR - if __t(isLite(nil)) then 106 else 158,
                11,
                "#f4dca7"
            )
            if math.sin(t * 0.7) > 0.25 then
                text(
                    nil,
                    c,
                    "Ô, chapéu… qual foi?",
                    NPC_X - camera,
                    FLOOR - if __t(isLite(nil)) then 124 else 176,
                    10,
                    "#d8c4e6"
                )
            end
        end
        local ____t_62 = __t
        local ____t_61 = __t
        local ____temp_60 = if __t(opts.defeated) then NPC_X - camera > -100 else opts.defeated
        __O[1359] = ____temp_60
        if ____t_62(if ____t_61(____temp_60) then NPC_X - camera < W + 100 else __O[1359]) then
            drawOllyan(
                nil,
                c,
                NPC_X - camera,
                FLOOR,
                t,
                {cup = false}
            )
            text(
                nil,
                c,
                "OLLYAN · AGORA É SÓ DANÇA",
                NPC_X - camera,
                FLOOR - if __t(isLite(nil)) then 108 else 158,
                10,
                "#bfe5c7"
            )
        end
    end
    function event(self, s, ____type, detail)
        if detail == nil then
            detail = {}
        end
        __call(
            s.events,
            "push",
            __assign({}, {type = ____type}, detail)
        )
        if __gt(
            __len(s.events),
            40
        ) then
            __call(
                s.events,
                "splice",
                0,
                __len(s.events) - 40
            )
        end
    end
    function setBonuses(self, s, values)
        if values == nil then
            values = {}
        end
        if not __t(s) then
            return
        end
        local b = s.bonuses
        for ____, key in __iterar((__arrL({"damageMultiplier", "moveSpeed", "dashCooldown", "gasRegen"}, 4))) do
            if __get(values, key) ~= nil then
                __set(
                    b,
                    key,
                    math.max(
                        0.1,
                        finite(
                            nil,
                            __get(values, key),
                            __get(b, key)
                        )
                    )
                )
            end
        end
        if values.maxHP ~= nil then
            local ____s_player_80 = s.player
            local ____clamp_result_79 = clamp(
                nil,
                finite(nil, values.maxHP, b.maxHP),
                1,
                10000
            )
            b.maxHP = ____clamp_result_79
            ____s_player_80.maxHP = ____clamp_result_79
            s.player.hp = math.min(s.player.hp, s.player.maxHP)
        end
        if values.maxGas ~= nil then
            local ____s_player_82 = s.player
            local ____clamp_result_81 = clamp(
                nil,
                finite(nil, values.maxGas, b.maxGas),
                10,
                10000
            )
            b.maxGas = ____clamp_result_81
            ____s_player_82.maxGas = ____clamp_result_81
            s.player.gas = math.min(s.player.gas, s.player.maxGas)
        end
    end
    function burst(self, s, x, y, color, count, speed)
        if count == nil then
            count = 15
        end
        if speed == nil then
            speed = 100
        end
        do
            local i = 0
            while i < count do
                local a = (i + 0.3) * 2.399
                local r = speed * (0.35 + __mod(i, 7) / 10)
                __call(
                    s.particles,
                    "push",
                    {
                        x = x,
                        y = y,
                        vx = math.cos(a) * r,
                        vy = math.sin(a) * r,
                        life = 0.4 + __mod(i, 5) * 0.08,
                        maxLife = 0.8,
                        size = 2 + __mod(i, 3),
                        color = color
                    }
                )
                i = i + 1
            end
        end
        if __gt(
            __len(s.particles),
            160
        ) then
            __call(
                s.particles,
                "splice",
                0,
                __len(s.particles) - 160
            )
        end
    end
    function phaseChange(self, s, next)
        local p = s.player
        s.transitionStart = {x = p.x, y = p.y, mode = s.mode}
        s.transitionFrom = s.phase
        s.transitionTo = next
        s.phase = next
        s.mode = if next == 2 then "platform" else "car"
        s.boss.max = __get(s.phaseHPs, next - 1)
        s.boss.hp = s.boss.max
        s.stage = "transition"
        s.stageTime = 0
        s.shots = __arrL({}, 0)
        s.hazards = __arrL({}, 0)
        p.inv = 2.65
        s.boss.inv = 2.65
        s.boss.sequence = 0
        s.boss.state = "recover"
        s.boss.stateTime = 0.7
        s.shake = 7
        p.vx = 0
        p.vy = 0
        p.dash = 0
        p.jumpBuffer = 0
        p.jumpHeld = false
        if s.mode == "platform" then
            p.x = 230
            p.y = 416
            p.grounded = true
            p.coyote = 0.12
            p.facing = 1
        else
            p.x = 196
            p.y = 320
            p.grounded = false
            p.coyote = 0
        end
        burst(
            nil,
            s,
            s.boss.x,
            s.boss.y,
            "#e8c5ed",
            35,
            135
        )
        event(
            nil,
            s,
            "phase",
            {
                phase = next,
                name = __get(phases, next - 1).name,
                mode = s.mode,
                hp = s.boss.hp,
                max = s.boss.max
            }
        )
    end
    local ____ = "use strict"
    W = 960
    local H = 540
    FLOOR = 440
    local LENGTH = 4800
    NPC_X = 3260
    TAU = math.pi * 2
    clamp = function(____, n, a, b) return math.max(
        a,
        math.min(b, n)
    ) end
    local function mix(____, a, b, t)
        return a + (b - a) * t
    end
    local function smooth(____, t)
        t = clamp(nil, t, 0, 1)
        return t * t * (3 - 2 * t)
    end
    finite = function(____, n, f) return if __isFiniteN(__TS__Number(n)) then __TS__Number(n) else f end
    palette = __ord({
        ink = "#171d32",
        night = "#111b39",
        pink = "#eb84b3",
        cyan = "#7ed6e4",
        gold = "#f1cf87",
        mint = "#a3e4ba"
    }, "ink,night,pink,cyan,gold,mint")
    local INTRO = __arrL(
        {
            __ord({
                id = "dance",
                start = 0,
                duration = 3,
                label = "O baile virou perseguição",
                speaker = "Ollyan",
                text = "Ô, chapéu… eu tô é tonto! Tu tá rindo da minha orelha, véi?"
            }, "id,start,duration,label,speaker,text"),
            __ord({
                id = "ears",
                start = 3,
                duration = 3,
                label = "Orelhas no teto",
                speaker = "Da Roça",
                text = "Oxe! O cara ligou o ventilador na cabeça e furou o teto do baile!"
            }, "id,start,duration,label,speaker,text"),
            __ord({
                id = "chase",
                start = 6,
                duration = 3,
                label = "O carro a gás decola pelo buraco",
                speaker = "Da Roça",
                text = "Bora, carro do meu pai! Sobe pelo buraco que a lua tá chamando!"
            }, "id,start,duration,label,speaker,text")
        },
        3
    )
    phases = __arrL(
        {
            __ord(
                {
                    name = "ORELHAS AO VENTO",
                    attacks = __arrL({"earFan", "pulseRing", "swoop"}, 3),
                    windup = 1.1,
                    recover = 0.95,
                    speed = 1
                },
                "name,attacks,windup,recover,speed"
            ),
            __ord(
                {
                    name = "NUVENS SOB OS PÉS",
                    attacks = __arrL({"cloudGate", "earFan", "platformStorm", "gustRing"}, 4),
                    windup = 0.98,
                    recover = 0.79,
                    speed = 1.13
                },
                "name,attacks,windup,recover,speed"
            ),
            __ord(
                {
                    name = "O REI DA CORRENTE DE AR",
                    attacks = __arrL({
                        "moonBeam",
                        "crosswind",
                        "cometRain",
                        "earFan",
                        "swoop"
                    }, 5),
                    windup = 0.88,
                    recover = 0.66,
                    speed = 1.24
                },
                "name,attacks,windup,recover,speed"
            )
        },
        3
    )
    local SKY_PLATFORMS = __call(
        __arrL(
            {
                __ord({id = "carro", x = 55, y = 416, w = 245}, "id,x,y,w"),
                __ord({id = "meio", x = 348, y = 350, w = 190}, "id,x,y,w"),
                __ord({id = "frente", x = 600, y = 396, w = 205}, "id,x,y,w"),
                __ord({id = "alta", x = 746, y = 286, w = 150}, "id,x,y,w")
            },
            4
        ),
        "map",
        function(____, p) return p end
    )
    local attackNames = __ord({
        platformStorm = "NUVENS CARREGADAS! MUDE DE PLATAFORMA",
        earFan = "RAJADA DE ORELHA",
        pulseRing = "ONDA DE GRAVE",
        swoop = "MERGULHO! SAIA DA LINHA",
        cloudGate = "PROCURE O VÃO NAS NUVENS",
        cometRain = "CHUVA DE COMETAS",
        gustRing = "ESPIRAL DE VENTO",
        moonBeam = "LUAR CORTANTE! SAIA DA MIRA",
        crosswind = "VENTO CRUZADO! BUSQUE AS ABERTURAS"
    }, "platformStorm,earFan,pulseRing,swoop,cloudGate,cometRain,gustRing,moonBeam,crosswind")
    local serial = 0
    local function poly(self, c, points, color)
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
    local function noise(self, n)
        return __mod(
            math.sin(n * 12.9898 + 78.233) * 43758.5453,
            1
        )
    end
    local function cloud(self, c, x, y, scale, color, alpha)
        if scale == nil then
            scale = 1
        end
        if color == nil then
            color = "#c1cfe2"
        end
        if alpha == nil then
            alpha = 1
        end
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        c:scale(scale, scale)
        c.globalAlpha = c.globalAlpha * alpha
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({-29, 5, 20}, 3),
                __arrL({-8, -5, 25}, 3),
                __arrL({18, 0, 23}, 3),
                __arrL({39, 10, 17}, 3)
            },
            4
        ))) do
            local k = ____value[1]
            local yy = ____value[2]
            local r = ____value[3]
            oval(
                nil,
                c,
                k,
                yy,
                r,
                r * 0.54,
                color
            )
        end
        rect(
            nil,
            c,
            -38,
            9,
            88,
            10,
            color
        )
        c:restore()
    end
    local function dancer(self, c, x, y, t, seed, scale)
        if seed == nil then
            seed = 0
        end
        if scale == nil then
            scale = 1
        end
        local ____t_5 = __t
        local ____opt_2 = window.BailePixel
        if ____opt_2 ~= nil then
            ____opt_2 = ____opt_2.dancer
        end
        local ____opt_result_4
        if ____opt_2 ~= nil then
            ____opt_result_4 = ____opt_2(
                ____opt_2,
                c,
                x,
                y,
                t,
                seed,
                scale
            )
        end
        if ____t_5(____opt_result_4) then
            return
        end
        local ____t_11 = __t
        local ____opt_8 = window.Graphics
        if ____opt_8 ~= nil then
            ____opt_8 = ____opt_8.isLite
        end
        local ____opt_result_10
        if ____opt_8 ~= nil then
            ____opt_result_10 = ____opt_8(____opt_8)
        end
        if not ____t_11(____opt_result_10) then
            return dancerHD(
                nil,
                c,
                x,
                y,
                t,
                seed,
                scale
            )
        end
        local sw = math.sin(t * (2.3 + __mod(seed, 3) * 0.17) + seed) * 5
        local bounce = math.max(
            0,
            math.sin(t * 4 + seed)
        ) * 3
        local skin = __get(
            __arrL({
                "#8d583f",
                "#e4b596",
                "#b47c55",
                "#6f4838",
                "#eec9ae"
            }, 5),
            __mod(seed, 5)
        )
        local shirt = __get(
            __arrL({
                "#7a5f9c",
                "#e49a78",
                "#679fac",
                "#c0b56b",
                "#b46c88",
                "#dde0c8"
            }, 6),
            __mod(seed, 6)
        )
        local pants = __get(
            __arrL({"#29374c", "#3c3a55", "#26394a"}, 3),
            __mod(seed, 3)
        )
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        c:scale(scale, scale)
        oval(
            nil,
            c,
            0,
            0,
            13,
            3,
            "#13192d50"
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({-5, -17}, 2),
                    __arrL({-8 - sw * 0.3, -7}, 2),
                    __arrL({-9 - sw * 0.4, -2}, 2)
                },
                3
            ),
            pants,
            6
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({5, -17}, 2),
                    __arrL({8 + sw * 0.3, -8}, 2),
                    __arrL({9 + sw * 0.5, -2}, 2)
                },
                3
            ),
            pants,
            6
        )
        rect(
            nil,
            c,
            -15 - sw * 0.4,
            -4,
            11,
            4,
            "#cad1cd"
        )
        rect(
            nil,
            c,
            5 + sw * 0.5,
            -4,
            11,
            4,
            "#c2cad0"
        )
        c:translate(sw * 0.25, -bounce)
        rect(
            nil,
            c,
            -10,
            -39,
            20,
            24,
            palette.ink
        )
        rect(
            nil,
            c,
            -8,
            -37,
            16,
            21,
            shirt
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({-8, -34}, 2),
                    __arrL({-15, -24 + sw}, 2),
                    __arrL({-20, -30 + sw}, 2)
                },
                3
            ),
            skin,
            5
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({8, -34}, 2),
                    __arrL({15, -40 - sw}, 2),
                    __arrL({19, -48 - sw}, 2)
                },
                3
            ),
            skin,
            5
        )
        rect(
            nil,
            c,
            -9,
            -53,
            18,
            17,
            palette.ink
        )
        rect(
            nil,
            c,
            -7,
            -51,
            14,
            14,
            skin
        )
        rect(
            nil,
            c,
            -8,
            -54,
            16,
            6,
            if __mod(seed, 4) == 0 then "#54404a" else "#232534"
        )
        if __mod(seed, 3) == 0 then
            rect(
                nil,
                c,
                -10,
                -50,
                4,
                20,
                "#252333"
            )
            rect(
                nil,
                c,
                7,
                -49,
                4,
                20,
                "#252333"
            )
        end
        rect(
            nil,
            c,
            -4,
            -45,
            2,
            3,
            "#302c37"
        )
        rect(
            nil,
            c,
            3,
            -45,
            2,
            3,
            "#302c37"
        )
        rect(
            nil,
            c,
            -2,
            -39,
            5,
            2,
            "#8b514c"
        )
        if __mod(seed, 7) == 0 then
            rect(
                nil,
                c,
                -9,
                -47,
                8,
                4,
                "#293b55"
            )
            rect(
                nil,
                c,
                1,
                -47,
                8,
                4,
                "#293b55"
            )
        end
        c:restore()
    end
    isLite = function()
        local ____t_17 = __t
        local ____opt_14 = window.Graphics
        if ____opt_14 ~= nil then
            ____opt_14 = ____opt_14.isLite
        end
        local ____opt_result_16
        if ____opt_14 ~= nil then
            ____opt_result_16 = ____opt_14(____opt_14)
        end
        return not not ____t_17(____opt_result_16)
    end
    BPM = 2.15
    local function showFx(self, c, x, t)
        local ____t_23 = __t
        local ____opt_20 = window.BailePixel
        if ____opt_20 ~= nil then
            ____opt_20 = ____opt_20.fx
        end
        local ____opt_result_22
        if ____opt_20 ~= nil then
            ____opt_result_22 = ____opt_20(____opt_20, c, x, t)
        end
        if ____t_23(____opt_result_22) then
            return
        end
        local beat = t * BPM
        local b = math.max(
            0,
            math.sin(beat * math.pi * 2)
        ) ^ 3
        local bar = math.floor(beat / 4)
        c:save()
        c:translate(
            math.floor(x + 0.5),
            0
        )
        c:save()
        c.globalCompositeOperation = "lighter"
        do
            local i = 0
            while i < 8 do
                local a = -math.pi / 2 + math.sin(t * (0.6 + i * 0.07) + i * 1.3) * 0.9
                local col = __get(
                    __arrL({"#ff4fd8", "#4fd8ff", "#7dff6a", "#ffe14f"}, 4),
                    __mod(i + bar, 4)
                )
                c.globalAlpha = 0.16 + 0.14 * b
                c.strokeStyle = col
                c.lineWidth = 2
                c:beginPath()
                c:moveTo((i - 3.5) * 60, 200)
                c:lineTo(
                    (i - 3.5) * 60 + math.cos(a) * 900,
                    200 + math.sin(a) * 900
                )
                c:stroke()
                c.globalAlpha = 0.06
                c.lineWidth = 7
                c:stroke()
                i = i + 1
            end
        end
        c:restore()
        rect(
            nil,
            c,
            -140,
            150,
            280,
            44,
            "#0b0f1c"
        )
        do
            local i = 0
            while i < 28 do
                local h = 6 + math.abs(math.sin(t * 6 + i * 0.7)) * 24 * (0.5 + b * 0.6)
                do
                    local k = 0
                    while k < h do
                        rect(
                            nil,
                            c,
                            -136 + i * 10,
                            190 - k,
                            8,
                            3,
                            if k > 24 then "#ff4f6a" else if k > 14 then "#ffe14f" else "#4fd8ff"
                        )
                        k = k + 4
                    end
                end
                i = i + 1
            end
        end
        for ____, xx in __iterar((__arrL({-230, 220}, 2))) do
            for ____, yy in __iterar((__arrL({304, 364}, 2))) do
                oval(
                    nil,
                    c,
                    xx,
                    yy,
                    17 + b * 2,
                    18 + b * 2,
                    "#4a5b6c"
                )
                oval(
                    nil,
                    c,
                    xx,
                    yy,
                    7 + b * 2,
                    8 + b * 2,
                    "#1c2a3e"
                )
            end
        end
        do
            local i = 0
            while i < 9 do
                local fx = -260 + i * 65 + math.sin(t * 0.4 + i) * 20
                local fy = 400 + math.sin(t * 0.6 + i * 2) * 6
                c:save()
                c.globalAlpha = 0.16
                oval(
                    nil,
                    c,
                    fx,
                    fy,
                    60,
                    18,
                    "#cdb8ee"
                )
                c:restore()
                i = i + 1
            end
        end
        local cb = __mod(beat, 16) / 16
        if cb < 0.35 then
            local k = cb / 0.35
            do
                local i = 0
                while i < 40 do
                    local side = if __t(__mod(i, 2)) then 1 else -1
                    local a = -math.pi / 2 + side * (0.2 + __mod(i * 37, 50) / 100)
                    local v = 260 * (1 - k * 0.3)
                    c:save()
                    c.globalAlpha = 1 - k
                    c.fillStyle = __get(
                        __arrL({
                            "#ff4fd8",
                            "#4fd8ff",
                            "#7dff6a",
                            "#ffe14f",
                            "#ffffff"
                        }, 5),
                        __mod(i, 5)
                    )
                    c:fillRect(
                        side * 240 + math.cos(a) * v * k,
                        200 + math.sin(a) * v * k + k * k * 220,
                        4,
                        3
                    )
                    c:restore()
                    i = i + 1
                end
            end
        end
        c:restore()
        if __mod(beat, 8) < 0.06 then
            c:save()
            c.globalAlpha = 0.12
            c.fillStyle = "#ffffff"
            c:fillRect(0, 0, W, H)
            c:restore()
        end
    end
    local function stage(self, c, x, t)
        local ____t_35 = __t
        local ____opt_32 = window.BailePixel
        if ____opt_32 ~= nil then
            ____opt_32 = ____opt_32.palco
        end
        local ____opt_result_34
        if ____opt_32 ~= nil then
            ____opt_result_34 = ____opt_32(____opt_32, c, x, t)
        end
        if ____t_35(____opt_result_34) then
            return
        end
        c:save()
        c:translate(
            math.floor(x + 0.5),
            0
        )
        rect(
            nil,
            c,
            -290,
            200,
            580,
            240,
            "#1b2441"
        )
        rect(
            nil,
            c,
            -284,
            205,
            568,
            225,
            "#302c52"
        )
        rect(
            nil,
            c,
            -289,
            416,
            578,
            24,
            "#382e4d"
        )
        rect(
            nil,
            c,
            -296,
            413,
            590,
            5,
            "#eab78e"
        )
        for ____, xx in __iterar((__arrL({-283, 279}, 2))) do
            rect(
                nil,
                c,
                xx,
                147,
                7,
                267,
                "#7691a5"
            )
            do
                local y = 150
                while y < 405 do
                    line(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({xx, y}, 2),
                                __arrL({xx + 7, y + 13}, 2),
                                __arrL({xx, y + 25}, 2)
                            },
                            3
                        ),
                        "#b5c7d2",
                        1
                    )
                    y = y + 25
                end
            end
        end
        rect(
            nil,
            c,
            -286,
            146,
            574,
            8,
            "#7189a1"
        )
        do
            local xx = -274
            while xx < 275 do
                line(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({xx, 146}, 2),
                            __arrL({xx + 14, 154}, 2),
                            __arrL({xx + 28, 146}, 2)
                        },
                        3
                    ),
                    "#bfd0d6",
                    1
                )
                xx = xx + 28
            end
        end
        local glowLevel = 0.36 + math.sin(t * 0.9) * 0.08
        glow(
            nil,
            c,
            0,
            268,
            245,
            "#aa65dc",
            glowLevel
        )
        do
            local i = 0
            while i < 5 do
                local xx = -228 + i * 112
                local yy = 168
                local angle = math.sin(t * 0.55 + i) * 0.24 + i * 0.11 - 0.22
                c:save()
                c:translate(xx, yy)
                c:rotate(angle)
                c.globalAlpha = 0.065
                poly(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({0, 0}, 2),
                            __arrL({-105, 245}, 2),
                            __arrL({105, 245}, 2)
                        },
                        3
                    ),
                    __get(
                        __arrL({"#e3a8ee", "#91dbe3", "#eecb8c"}, 3),
                        __mod(i, 3)
                    )
                )
                c.globalAlpha = 1
                rect(
                    nil,
                    c,
                    -10,
                    -5,
                    20,
                    12,
                    "#374a6c"
                )
                rect(
                    nil,
                    c,
                    -7,
                    5,
                    14,
                    5,
                    __get(
                        __arrL({"#f4a8df", "#94dfeb", "#f8dc9b"}, 3),
                        __mod(i, 3)
                    )
                )
                c:restore()
                i = i + 1
            end
        end
        for ____, xx in __iterar((__arrL({-230, 220}, 2))) do
            rect(
                nil,
                c,
                xx - 31,
                272,
                62,
                137,
                "#141a2a"
            )
            rect(
                nil,
                c,
                xx - 26,
                279,
                52,
                122,
                "#354052"
            )
            for ____, yy in __iterar((__arrL({304, 364}, 2))) do
                oval(
                    nil,
                    c,
                    xx,
                    yy,
                    22,
                    23,
                    "#131e2d"
                )
                oval(
                    nil,
                    c,
                    xx,
                    yy,
                    17,
                    18,
                    "#4a5b6c"
                )
                oval(
                    nil,
                    c,
                    xx,
                    yy,
                    7,
                    8,
                    "#152136"
                )
            end
            rect(
                nil,
                c,
                xx - 27,
                405,
                55,
                5,
                "#6c7891"
            )
        end
        rect(
            nil,
            c,
            -151,
            196,
            302,
            43,
            "#172239"
        )
        rect(
            nil,
            c,
            -145,
            201,
            290,
            32,
            "#342b58"
        )
        text(
            nil,
            c,
            "BAILE DA ROÇA",
            0,
            217,
            19,
            "#efa7d6"
        )
        rect(
            nil,
            c,
            -113,
            248,
            226,
            7,
            "#edc296"
        )
        dancer(
            nil,
            c,
            -66,
            358,
            t,
            16,
            1.05
        )
        dancer(
            nil,
            c,
            65,
            356,
            t + 0.3,
            22,
            1.05
        )
        rect(
            nil,
            c,
            -108,
            337,
            218,
            48,
            "#1a263a"
        )
        rect(
            nil,
            c,
            -100,
            345,
            202,
            22,
            "#464b70"
        )
        do
            local i = 0
            while i < 10 do
                rect(
                    nil,
                    c,
                    -93 + i * 20,
                    349,
                    12,
                    3,
                    __get(
                        __arrL({"#bfcde1", "#95dfc8", "#e7bdd8"}, 3),
                        __mod(i, 3)
                    )
                )
                i = i + 1
            end
        end
        local hands = math.sin(t * 3.5) * 4
        rect(
            nil,
            c,
            -19,
            277,
            37,
            22,
            "#252735"
        )
        rect(
            nil,
            c,
            -15,
            281,
            29,
            20,
            "#c9977a"
        )
        rect(
            nil,
            c,
            -21,
            274,
            41,
            8,
            "#1b2135"
        )
        rect(
            nil,
            c,
            -26,
            282,
            5,
            18,
            "#718dab"
        )
        rect(
            nil,
            c,
            20,
            282,
            5,
            18,
            "#718dab"
        )
        rect(
            nil,
            c,
            -20,
            300,
            40,
            37,
            "#a886b5"
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({-15, 310}, 2),
                    __arrL({-30, 323 + hands}, 2),
                    __arrL({-41, 341}, 2)
                },
                3
            ),
            "#d7a98b",
            8
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({15, 311}, 2),
                    __arrL({30, 323 - hands}, 2),
                    __arrL({43, 341}, 2)
                },
                3
            ),
            "#d7a98b",
            8
        )
        for ____, xx in __iterar((__arrL({-151, 152}, 2))) do
            rect(
                nil,
                c,
                xx - 22,
                341,
                45,
                48,
                "#79516b"
            )
            oval(
                nil,
                c,
                xx,
                341,
                24,
                8,
                "#d9c9ae"
            )
            rect(
                nil,
                c,
                xx - 2,
                388,
                4,
                21,
                "#626b7f"
            )
            line(
                nil,
                c,
                __arrL(
                    {
                        __arrL({xx - 13, 345}, 2),
                        __arrL({xx - 18 + hands, 332}, 2)
                    },
                    2
                ),
                "#efdcb8",
                3
            )
        end
        do
            local i = 0
            while i < 9 do
                local h = 9 + math.sin(t * 2 + i * 0.8) * 7
                rect(
                    nil,
                    c,
                    -83 + i * 21,
                    378 - h,
                    10,
                    h,
                    "#83cdbb"
                )
                i = i + 1
            end
        end
        c:restore()
    end
    local function world(self, c, camera, t, opts)
        if camera == nil then
            camera = 0
        end
        if t == nil then
            t = 0
        end
        if opts == nil then
            opts = {}
        end
        c:save()
        c.imageSmoothingEnabled = false
        local ____t_42 = __t
        local ____opt_39 = window.BaileGalpao
        if ____opt_39 ~= nil then
            ____opt_39 = ____opt_39.draw
        end
        local ____opt_result_41
        if ____opt_39 ~= nil then
            ____opt_result_41 = ____opt_39(
                ____opt_39,
                c,
                camera,
                t,
                opts
            )
        end
        if ____t_42(____opt_result_41) then
            ollyanNoBaile(
                nil,
                c,
                camera,
                t,
                opts
            )
            c:restore()
            return
        end
        local sky = c:createLinearGradient(0, 0, 0, 440)
        sky:addColorStop(0, "#0b1330")
        sky:addColorStop(0.55, "#28325a")
        sky:addColorStop(1, "#71536e")
        c.fillStyle = sky
        c:fillRect(0, 0, W, H)
        do
            local i = 0
            while i < 70 do
                local xx = __mod(
                    __mod(i * 113.7 - camera * 0.035, 1050) + 1050,
                    1050
                )
                local yy = 18 + __mod(i * 47, 221)
                rect(
                    nil,
                    c,
                    xx,
                    yy,
                    if __mod(i, 7) == 0 then 2 else 1,
                    if __mod(i, 7) == 0 then 2 else 1,
                    "#cbd0e7"
                )
                i = i + 1
            end
        end
        glow(
            nil,
            c,
            810 - camera * 0.018,
            85,
            90,
            "#d5cdec",
            0.14
        )
        oval(
            nil,
            c,
            810 - camera * 0.018,
            85,
            29,
            29,
            "#e5dbdc"
        )
        oval(
            nil,
            c,
            819 - camera * 0.018,
            77,
            27,
            26,
            "#182144"
        )
        do
            local layer = 0
            while layer < 2 do
                local speed = if __t(layer) then 0.21 else 0.11
                do
                    local i = -2
                    while i < 18 do
                        local xx = i * 137 - __mod(camera * speed, 137)
                        local hh = 70 + __mod(i * i * 37 + layer * 31, 114)
                        local yy = 330 - hh + layer * 32
                        rect(
                            nil,
                            c,
                            xx,
                            yy,
                            127,
                            330 - yy,
                            if __t(layer) then "#24334b" else "#1c2845"
                        )
                        rect(
                            nil,
                            c,
                            xx + 7,
                            yy - 5,
                            113,
                            7,
                            if __t(layer) then "#3b4b61" else "#293450"
                        )
                        do
                            local row = 0
                            while row < 4 do
                                do
                                    local col = 0
                                    while col < 6 do
                                        if __mod(i + row + col + layer, 3) ~= 0 then
                                            rect(
                                                nil,
                                                c,
                                                xx + 12 + col * 17,
                                                yy + 15 + row * 22,
                                                7,
                                                9,
                                                if __t(layer) then "#948576" else "#5a6476"
                                            )
                                        end
                                        col = col + 1
                                    end
                                end
                                row = row + 1
                            end
                        end
                        if __mod(i, 3) == 0 then
                            rect(
                                nil,
                                c,
                                xx + 75,
                                yy - 26,
                                3,
                                23,
                                "#576980"
                            )
                            line(
                                nil,
                                c,
                                __arrL(
                                    {
                                        __arrL({xx + 57, yy - 26}, 2),
                                        __arrL({xx + 95, yy - 26}, 2)
                                    },
                                    2
                                ),
                                "#65788e",
                                2
                            )
                        end
                        i = i + 1
                    end
                end
                layer = layer + 1
            end
        end
        do
            local i = 0
            while i < 5 do
                local x = i * 1100 - camera * 0.55
                line(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x, 165}, 2),
                            __arrL({x + 330, 190}, 2),
                            __arrL({x + 680, 172}, 2),
                            __arrL({x + 1000, 186}, 2)
                        },
                        4
                    ),
                    "#283442",
                    3
                )
                do
                    local j = 0
                    while j < 18 do
                        local xx = x + j * 57
                        local yy = 174 + math.sin(j * 0.42) * 10 + math.sin(t * 0.8 + j) * 1.5
                        rect(
                            nil,
                            c,
                            xx,
                            yy,
                            5,
                            8,
                            __get(
                                __arrL({"#f5d78b", "#b3dce8", "#eeabd7", "#a9ddc1"}, 4),
                                __mod(j, 4)
                            )
                        )
                        if __mod(j, 3) == 0 then
                            glow(
                                nil,
                                c,
                                xx,
                                yy,
                                15,
                                "#d9bbdb",
                                0.075
                            )
                        end
                        j = j + 1
                    end
                end
                i = i + 1
            end
        end
        rect(
            nil,
            c,
            0,
            330,
            W,
            110,
            "#59445c"
        )
        do
            local i = 0
            while i < 14 do
                local xx = i * 95 - __mod(camera * 0.75, 95)
                rect(
                    nil,
                    c,
                    xx,
                    332,
                    66,
                    7,
                    "#75566d"
                )
                rect(
                    nil,
                    c,
                    xx + 12,
                    351,
                    48,
                    3,
                    "#493c56"
                )
                i = i + 1
            end
        end
        rect(
            nil,
            c,
            0,
            423,
            W,
            17,
            "#292e48"
        )
        rect(
            nil,
            c,
            0,
            440,
            W,
            100,
            "#30364e"
        )
        rect(
            nil,
            c,
            0,
            440,
            W,
            6,
            "#a18a8b"
        )
        do
            local i = -1
            while i < 20 do
                local xx = i * 64 - __mod(camera, 64)
                rect(
                    nil,
                    c,
                    xx,
                    451,
                    1,
                    89,
                    "#262b43"
                )
                rect(
                    nil,
                    c,
                    xx + 7,
                    477,
                    40,
                    2,
                    "#4d4e66"
                )
                rect(
                    nil,
                    c,
                    xx + 24,
                    514,
                    31,
                    2,
                    "#43465e"
                )
                i = i + 1
            end
        end
        stage(nil, c, 2240 - camera, t)
        if not __t(isLite(nil)) then
            showFx(nil, c, 2240 - camera, t)
        end
        local ____opt_45 = window.BailePixel
        if ____opt_45 ~= nil then
            ____opt_45 = ____opt_45.cenario
        end
        if ____opt_45 ~= nil then
            ____opt_45(____opt_45, c, camera, t)
        end
        do
            local row = 0
            while row < 2 do
                do
                    local i = 0
                    while i < 116 do
                        local wx = 60 + i * 41 + row * 23
                        local xx = wx - camera
                        local ____t_51 = __t
                        local ____t_48 = __t
                        local ____temp_47 = xx < -45 or xx > W + 45
                        __O[1355] = ____temp_47
                        local ____t_50 = __t
                        local ____temp_49 = row == 0 and wx > 1900
                        __O[1354] = ____temp_49
                        if ____t_51(if ____t_48(____temp_47) then __O[1355] else if ____t_50(____temp_49) then wx < 2560 else __O[1354]) then
                            continue
                        end
                        local yy = if row == 0 then 401 + __mod(i, 3) * 5 else 438 + __mod(i, 2) * 3
                        local scale = if row == 0 then 0.73 else 0.91
                        dancer(
                            nil,
                            c,
                            xx,
                            yy,
                            t + row * 0.33,
                            i + row * 7,
                            scale
                        )
                        i = i + 1
                    end
                end
                row = row + 1
            end
        end
        if not __t(isLite(nil)) then
            do
                local i = 0
                while i < 70 do
                    local wx = 40 + i * 67 + __mod(i * 29, 30)
                    local xx = wx - camera
                    local ____t_54 = __t
                    local ____t_53 = __t
                    local ____temp_52 = xx < -50 or xx > W + 50
                    __O[1356] = ____temp_52
                    if ____t_54(if ____t_53(____temp_52) then __O[1356] else math.abs(wx - 3260) < 90) then
                        continue
                    end
                    c:save()
                    c.globalAlpha = 0.92
                    dancer(
                        nil,
                        c,
                        xx,
                        486 + __mod(i, 3) * 9,
                        t + 0.6,
                        i * 5 + 3,
                        1.08
                    )
                    c:restore()
                    i = i + 1
                end
            end
        end
        for ____, wx in __iterar((__arrL({
            230,
            1000,
            2850,
            4070,
            4620
        }, 5))) do
            local xx = wx - camera
            if __t(xx < -100 or xx > W + 100) then
                continue
            end
            rect(
                nil,
                c,
                xx,
                203,
                8,
                237,
                "#293b54"
            )
            rect(
                nil,
                c,
                xx - 20,
                197,
                49,
                15,
                "#526278"
            )
            rect(
                nil,
                c,
                xx - 14,
                212,
                38,
                6,
                "#efc994"
            )
            glow(
                nil,
                c,
                xx + 5,
                236,
                76,
                "#e3b083",
                0.09
            )
        end
        do
            local i = 0
            while i < 21 do
                local xx = __mod(
                    i * 227 - camera * 0.35 + t * (4 + __mod(i, 3)),
                    W
                )
                local yy = 210 + __mod(i * 41, 190)
                rect(
                    nil,
                    c,
                    xx,
                    yy,
                    2,
                    2,
                    if __t(__mod(i, 2)) then "#c4b6d7" else "#a7dcd8"
                )
                i = i + 1
            end
        end
        local signs = __arrL({{x = 430, txt = "BAILE FUNK"}, {x = 1350, txt = "PISTA DA RESENHA"}, {x = 2970, txt = "VAI COM CALMA, VÉI"}, {x = 4300, txt = "ITABUNA NO RITMO"}}, 4)
        for ____, s in __iterar((signs)) do
            local xx = s.x - camera
            if __t(xx < -220 or xx > W + 220) then
                continue
            end
            rect(
                nil,
                c,
                xx - 124,
                258,
                248,
                34,
                "#25304b"
            )
            rect(
                nil,
                c,
                xx - 120,
                262,
                240,
                26,
                "#3c3556"
            )
            text(
                nil,
                c,
                s.txt,
                xx,
                276,
                12,
                "#e9b6d3"
            )
        end
        ollyanNoBaile(
            nil,
            c,
            camera,
            t,
            opts
        )
        c:restore()
    end
    local function sky(self, c, t, phase)
        if phase == nil then
            phase = 1
        end
        local g = c:createLinearGradient(0, 0, 0, H)
        g:addColorStop(0, if phase == 3 then "#16162e" else "#111e3c")
        g:addColorStop(0.53, if phase == 3 then "#5d355c" else "#304d74")
        g:addColorStop(1, "#ae7890")
        c.fillStyle = g
        c:fillRect(0, 0, W, H)
        do
            local i = 0
            while i < 58 do
                local x = __mod(
                    __mod(
                        i * 137 - t * (9 + __mod(i, 3) * 5),
                        1040
                    ) + 1040,
                    1040
                )
                local y = 18 + __mod(i * 61, 245)
                rect(
                    nil,
                    c,
                    x,
                    y,
                    if __mod(i, 8) == 0 then 2 else 1,
                    if __mod(i, 8) == 0 then 2 else 1,
                    "#d9d2e6"
                )
                i = i + 1
            end
        end
        glow(
            nil,
            c,
            791,
            122,
            110,
            if phase == 3 then "#a3c3e8" else "#c3badb",
            0.14
        )
        oval(
            nil,
            c,
            791,
            122,
            43,
            43,
            "#e9dfd4"
        )
        oval(
            nil,
            c,
            780,
            115,
            8,
            5,
            "#bfb9c8"
        )
        oval(
            nil,
            c,
            804,
            135,
            10,
            7,
            "#c8bfcb"
        )
        do
            local i = 0
            while i < 7 do
                local x = __mod(
                    __mod(
                        i * 217 - t * (21 + __mod(i, 3) * 5),
                        1400
                    ) + 1400,
                    1400
                ) - 180
                local y = 110 + __mod(i * 83, 340)
                cloud(
                    nil,
                    c,
                    x,
                    y,
                    0.9 + __mod(i, 3) * 0.34,
                    if __t(__mod(i, 2)) then "#7587a8" else "#a8a8c5",
                    0.19
                )
                i = i + 1
            end
        end
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({0, 490}, 2),
                    __arrL({65, 472}, 2),
                    __arrL({117, 485}, 2),
                    __arrL({178, 454}, 2),
                    __arrL({218, 472}, 2),
                    __arrL({276, 450}, 2),
                    __arrL({338, 478}, 2),
                    __arrL({402, 455}, 2),
                    __arrL({466, 483}, 2),
                    __arrL({531, 468}, 2),
                    __arrL({605, 479}, 2),
                    __arrL({681, 457}, 2),
                    __arrL({745, 482}, 2),
                    __arrL({821, 462}, 2),
                    __arrL({892, 479}, 2),
                    __arrL({960, 462}, 2),
                    __arrL({960, 540}, 2),
                    __arrL({0, 540}, 2)
                },
                18
            ),
            "#26334d"
        )
        do
            local i = 0
            while i < 22 do
                local x = i * 47 - 10 - __mod(t * 7, 47)
                local h = 12 + __mod(i * 37, 31)
                rect(
                    nil,
                    c,
                    x,
                    535 - h,
                    37,
                    h,
                    "#18263d"
                )
                if __t(__mod(i, 2)) then
                    rect(
                        nil,
                        c,
                        x + 8,
                        539 - h,
                        5,
                        5,
                        "#bda17e"
                    )
                end
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 6 do
                local xx = __mod(
                    __mod(i * 220 - t * 65, 1350) + 1350,
                    1350
                ) - 160
                cloud(
                    nil,
                    c,
                    xx,
                    518 + __mod(i, 2) * 12,
                    1.8,
                    "#8b88ab",
                    0.24
                )
                i = i + 1
            end
        end
    end
    local function pilot(self, c, x, y, t, options)
        if options == nil then
            options = {}
        end
        c:save()
        c:translate(x, y)
        c:rotate(finite(nil, options.angle, 0))
        if __t(__gt(options.inv, 0) and __mod(
            math.floor(t * 18),
            2
        ) == 0) then
            c.globalAlpha = 0.56
        end
        if __t(options.dash) then
            do
                local i = 0
                while i < 5 do
                    c:save()
                    c.globalAlpha = c.globalAlpha * (0.13 - i * 0.02)
                    rect(
                        nil,
                        c,
                        -85 - i * 19,
                        -17,
                        57,
                        17,
                        "#d9f2c8"
                    )
                    c:restore()
                    i = i + 1
                end
            end
        end
        local ____t_65 = __t
        local ____opt_63 = window.Art
        if ____opt_63 ~= nil then
            ____opt_63 = ____opt_63.drawVehicle
        end
        if ____t_65(____opt_63) then
            window.Art:drawVehicle(c, 0, 10, t)
        else
            rect(
                nil,
                c,
                -47,
                -19,
                95,
                31,
                "#7f975d"
            )
            rect(
                nil,
                c,
                -21,
                -39,
                44,
                24,
                "#b7c79e"
            )
            rect(
                nil,
                c,
                -38,
                12,
                20,
                8,
                "#314039"
            )
            rect(
                nil,
                c,
                21,
                12,
                20,
                8,
                "#314039"
            )
        end
        local ____t_68 = __t
        local ____opt_66 = window.Art
        if ____opt_66 ~= nil then
            ____opt_66 = ____opt_66.drawCharacter
        end
        if ____t_68(____opt_66) then
            window.Art:drawCharacter(
                c,
                "daroca",
                3,
                -7,
                {
                    frame = t,
                    scale = 0.65,
                    facing = 1,
                    muscular = not not __t(options.trained),
                    grounded = false,
                    flight = true
                }
            )
        else
            rect(
                nil,
                c,
                -8,
                -56,
                17,
                32,
                "#d49952"
            )
            rect(
                nil,
                c,
                -16,
                -60,
                34,
                5,
                "#e5ca8b"
            )
        end
        c:restore()
    end
    local function caption(self, c, speaker, content)
        rect(
            nil,
            c,
            88,
            467,
            784,
            56,
            "#111c32e8"
        )
        rect(
            nil,
            c,
            91,
            467,
            3,
            56,
            "#c7a3d8"
        )
        text(
            nil,
            c,
            __call(speaker, "toUpperCase"),
            109,
            482,
            10,
            "#e8c892",
            "left"
        )
        c:save()
        c.font = "12px monospace"
        c.fillStyle = "#eee5df"
        c.textBaseline = "middle"
        c.textAlign = "left"
        local words = __call(content, "split", " ")
        local value = ""
        local y = 501
        for ____, word in __iterar((words)) do
            if __gt(
                c:measureText(__add(
                    __add(value, " "),
                    word
                )).width,
                735
            ) then
                c:fillText(value, 109, y)
                y = y + 15
                value = word
            else
                value = __add(
                    value,
                    __add(if __t(value) then " " else "", word)
                )
            end
        end
        c:fillText(value, 109, y)
        c:restore()
    end
    local function drawIntro(self, c, seconds, options)
        if seconds == nil then
            seconds = 0
        end
        if options == nil then
            options = {}
        end
        local t = clamp(
            nil,
            finite(nil, seconds, 0),
            0,
            9
        )
        local index = math.min(
            2,
            math.floor(t / 3)
        )
        local ____local = t - index * 3
        c:save()
        c.imageSmoothingEnabled = false
        local G = window.BaileGalpao
        local tetoY = if __t(G) then G.TETO else 70
        if index < 2 then
            local sobe = if index == 1 then smooth(nil, ____local / 1.5) else 0
            local fura = if index == 1 then smooth(nil, (____local - 1.3) / 0.45) else 0
            local saiu = if index == 1 then smooth(nil, (____local - 1.55) / 0.9) else 0
            local ____t_71 = __t
            local ____t_70 = __t
            local ____temp_69 = index == 1 and ____local > 1.25
            __O[1360] = ____temp_69
            local tremor = if ____t_71(if ____t_70(____temp_69) then ____local < 1.9 else __O[1360]) then math.sin(t * 90) * 3 else 0
            c:save()
            c:translate(
                math.floor(tremor + 0.5),
                math.floor(tremor * 0.5 + 0.5)
            )
            world(
                nil,
                c,
                NPC_X - 535,
                t,
                {hideOllyan = true, rombo = if __t(G) then fura else nil}
            )
            rect(
                nil,
                c,
                0,
                0,
                W,
                H,
                "#11152d22"
            )
            local approach = if index == 0 then 535 - smooth(nil, ____local / 2.65) * 75 else 460 + sobe * 75
            local oy = if index == 0 then 440 else 440 - sobe * (440 - tetoY - 30) - saiu * 200
            drawOllyan(
                nil,
                c,
                approach + math.sin(t * 3) * 6,
                oy,
                t,
                {
                    scale = 1 + sobe * 0.08,
                    facing = -1,
                    flying = index == 1 and ____local > 0.25,
                    cup = index == 0,
                    fast = true,
                    angle = if index == 0 then math.sin(t * 3) * 0.08 else 0
                }
            )
            local ____t_74 = __t
            local ____opt_72 = window.Art
            if ____opt_72 ~= nil then
                ____opt_72 = ____opt_72.drawCharacter
            end
            if ____t_74(____opt_72) then
                window.Art:drawCharacter(
                    c,
                    "daroca",
                    315,
                    440,
                    {
                        frame = t,
                        facing = 1,
                        muscular = not not __t(options.trained)
                    }
                )
            else
                rect(
                    nil,
                    c,
                    303,
                    383,
                    24,
                    57,
                    "#dda05d"
                )
                rect(
                    nil,
                    c,
                    293,
                    376,
                    44,
                    6,
                    "#dbc589"
                )
            end
            if index == 1 then
                do
                    local i = 0
                    while i < 12 do
                        local q = __mod(t * 1.1 + i * 0.13, 1)
                        local xx = 535 + math.cos(i * 2.4) * q * 130
                        local yy = oy - 5 - q * 120
                        rect(
                            nil,
                            c,
                            xx,
                            yy,
                            4,
                            3,
                            "#dbd2e4"
                        )
                        i = i + 1
                    end
                end
                if fura > 0 then
                    do
                        local i = 0
                        while i < 14 do
                            local q = clamp(nil, ____local - 1.3 - i * 0.03, 0, 2)
                            local xx = 535 + (i - 7) * 14 + math.sin(i) * 20
                            local yy = tetoY + q * q * 260 + q * 40
                            if __lt(yy, 440) then
                                rect(
                                    nil,
                                    c,
                                    xx,
                                    yy,
                                    6 + __mod(i, 3) * 3,
                                    3,
                                    if __t(__mod(i, 2)) then "#4a4e60" else "#6a6e80"
                                )
                            end
                            i = i + 1
                        end
                    end
                end
            end
            c:restore()
        elseif ____local < 1 then
            local u = smooth(nil, ____local)
            world(
                nil,
                c,
                NPC_X - 535,
                t,
                {hideOllyan = true, rombo = if __t(G) then 1 else nil}
            )
            rect(
                nil,
                c,
                0,
                0,
                W,
                H,
                "#11152d22"
            )
            pilot(
                nil,
                c,
                520,
                430 - u * 470,
                t,
                {trained = options.trained, dash = true}
            )
        else
            sky(nil, c, t, 1)
            local chase = smooth(nil, (____local - 1) / 2)
            drawOllyan(
                nil,
                c,
                750 + math.sin(t * 4) * 5,
                190 - math.sin(t * 2) * 15,
                t,
                {scale = 1.25, flying = true, fast = true}
            )
            pilot(
                nil,
                c,
                150 + chase * 200,
                330 - chase * 72,
                t,
                {trained = options.trained, dash = true}
            )
            do
                local i = 0
                while i < 9 do
                    local xx = __mod(i * 143 - t * 260, 1100)
                    rect(
                        nil,
                        c,
                        xx,
                        130 + __mod(i * 43, 270),
                        40,
                        2,
                        "#ddd9e444"
                    )
                    i = i + 1
                end
            end
        end
        rect(
            nil,
            c,
            0,
            0,
            W,
            25,
            "#0b1122"
        )
        rect(
            nil,
            c,
            0,
            532,
            W,
            8,
            "#0b1122"
        )
        text(
            nil,
            c,
            if index == 2 then "CARRO A GÁS · PERSEGUIÇÃO NO CÉU" else "BAILE FUNK · O CÉU VIROU PISTA",
            480,
            13,
            10,
            "#d9cfdf"
        )
        caption(
            nil,
            c,
            __get(INTRO, index).speaker,
            __get(INTRO, index).text
        )
        c:restore()
    end
    local function renderIntro(self, canvasOrContext, seconds, options)
        if seconds == nil then
            seconds = 0
        end
        if options == nil then
            options = {}
        end
        if not __t(canvasOrContext) then
            return nil
        end
        local canvas = if type(canvasOrContext.getContext) == "function" then canvasOrContext else nil
        local c = if __t(canvas) then canvas:getContext("2d") else canvasOrContext
        if not __t(c) then
            return nil
        end
        if __t(canvas) then
            local scale = math.min(canvas.width / W, canvas.height / H)
            c:save()
            c:setTransform(
                1,
                0,
                0,
                1,
                0,
                0
            )
            rect(
                nil,
                c,
                0,
                0,
                canvas.width,
                canvas.height,
                "#0a1020"
            )
            c:translate((canvas.width - W * scale) / 2, (canvas.height - H * scale) / 2)
            c:scale(scale, scale)
            drawIntro(nil, c, seconds, options)
            c:restore()
        else
            drawIntro(nil, c, seconds, options)
        end
        return {
            id = "ollyan_flight",
            time = clamp(
                nil,
                finite(nil, seconds, 0),
                0,
                9
            ),
            duration = 9,
            index = math.min(
                2,
                math.floor(clamp(
                    nil,
                    finite(nil, seconds, 0),
                    0,
                    8.999
                ) / 3)
            )
        }
    end
    local function previewTimeline(self)
        return {
            id = "ollyan_flight",
            duration = 9,
            manualDefault = false,
            shots = __call(
                INTRO,
                "map",
                function(____, x) return __assign({}, x) end
            )
        }
    end
    local function create(self, options)
        if options == nil then
            options = {}
        end
        local maxHP = clamp(
            nil,
            finite(nil, options.maxHP, 100),
            1,
            10000
        )
        local maxGas = clamp(
            nil,
            finite(nil, options.maxGas, 100),
            10,
            10000
        )
        local bossHP = clamp(
            nil,
            finite(nil, options.bossHP, 2600),
            100,
            100000
        )
        local ____add_75 = __add
        serial = serial + 1
        return {
            kind = "ollyan",
            token = ____add_75("ollyan-flight-", serial),
            stage = "intro",
            stageTime = 0,
            time = 0,
            phase = 1,
            done = false,
            success = false,
            cancelled = false,
            events = __arrL({}, 0),
            options = __assign({}, options),
            player = {
                x = 196,
                y = 320,
                vx = 0,
                vy = 0,
                grounded = false,
                facing = 1,
                jumpHeld = false,
                jumpBuffer = 0,
                coyote = 0,
                attackTime = 0,
                lastAttack = "paper",
                hp = clamp(
                    nil,
                    finite(nil, options.hp, maxHP),
                    1,
                    maxHP
                ),
                maxHP = maxHP,
                gas = clamp(
                    nil,
                    finite(nil, options.gas, maxGas),
                    0,
                    maxGas
                ),
                maxGas = maxGas,
                inv = 1,
                dash = 0,
                dashX = 1,
                dashY = 0,
                paperCooldown = 0,
                fartCooldown = 0,
                dashCooldown = 0,
                tilt = 0
            },
            mode = "car",
            phaseHPs = __arrL(
                {
                    bossHP,
                    math.floor(bossHP * 1.25 + 0.5),
                    math.floor(bossHP * 1.5 + 0.5)
                },
                3
            ),
            platforms = __call(
                SKY_PLATFORMS,
                "map",
                function(____, p) return __assign({}, p) end
            ),
            parkedCar = {x = 142, y = 399},
            transitionStart = nil,
            playerInputX = 0,
            playerInputY = 0,
            boss = {
                x = 744,
                y = 246,
                hp = bossHP,
                max = bossHP,
                baseMax = bossHP,
                hit = 0,
                inv = 0,
                state = "recover",
                stateTime = 0.9,
                attack = "",
                attackId = 0,
                sequence = 0,
                targetX = 196,
                targetY = 320
            },
            shots = __arrL({}, 0),
            hazards = __arrL({}, 0),
            particles = __arrL({}, 0),
            shake = 0,
            transitionFrom = 1,
            transitionTo = 1,
            bonuses = {
                damageMultiplier = clamp(
                    nil,
                    finite(nil, options.damageMultiplier, 1),
                    0.1,
                    100
                ),
                moveSpeed = clamp(
                    nil,
                    finite(nil, options.moveSpeed, 280),
                    120,
                    900
                ),
                dashCooldown = clamp(
                    nil,
                    finite(nil, options.dashCooldown, 1.1),
                    0.35,
                    4
                ),
                gasRegen = clamp(
                    nil,
                    finite(nil, options.gasRegen, 13),
                    1,
                    150
                ),
                maxHP = maxHP,
                maxGas = maxGas
            },
            seed = finite(nil, options.seed, 1)
        }
    end
    local function setPlayer(self, s, values)
        if values == nil then
            values = {}
        end
        local ____t_78 = __t
        local ____t_77 = __t
        local ____temp_76 = not __t(s)
        __O[1361] = ____temp_76
        if ____t_78(if ____t_77(____temp_76) then __O[1361] else s.done) then
            return false
        end
        if __t(values.maxHP ~= nil or values.maxGas ~= nil) then
            setBonuses(nil, s, values)
        end
        if values.hp ~= nil then
            s.player.hp = clamp(
                nil,
                finite(nil, values.hp, s.player.hp),
                0,
                s.player.maxHP
            )
        end
        if values.gas ~= nil then
            s.player.gas = clamp(
                nil,
                finite(nil, values.gas, s.player.gas),
                0,
                s.player.maxGas
            )
        end
        return true
    end
    local function startFight(self, s)
        s.stage = "fight"
        s.stageTime = 0
        s.player.inv = math.max(s.player.inv, 1.25)
        s.boss.state = "recover"
        s.boss.stateTime = 0.65
        event(nil, s, "intro-end")
    end
    local function damagePlayer(self, s, damage, x)
        local ____t_85 = __t
        local ____t_84 = __t
        local ____temp_83 = s.stage ~= "fight" or __gt(s.player.inv, 0)
        __O[1362] = ____temp_83
        if ____t_85(if ____t_84(____temp_83) then __O[1362] else __le(s.player.hp, 0)) then
            return false
        end
        local value = math.max(
            1,
            math.floor(damage * clamp(
                nil,
                finite(nil, s.options.enemyDamageMultiplier, 1.5),
                0.2,
                6
            ) + 0.5)
        )
        s.player.hp = math.max(0, s.player.hp - value)
        s.player.inv = 1.05
        s.player.x = clamp(nil, s.player.x + if __lt(s.player.x, x) then -15 else 15, 65, 895)
        s.shake = 5
        burst(
            nil,
            s,
            s.player.x,
            s.player.y,
            "#f2d19c",
            13,
            100
        )
        event(nil, s, "hurt", {damage = value, hp = s.player.hp, sourceX = x})
        if __le(s.player.hp, 0) then
            s.stage = "defeat"
            s.stageTime = 0
            s.shots = __arrL({}, 0)
            s.hazards = __arrL({}, 0)
        end
        return true
    end
    local function damageBoss(self, s, damage, x, y)
        local ____t_88 = __t
        local ____t_87 = __t
        local ____temp_86 = s.stage ~= "fight" or __gt(s.boss.inv, 0)
        __O[1363] = ____temp_86
        if ____t_88(if ____t_87(____temp_86) then __O[1363] else __le(s.boss.hp, 0)) then
            return false
        end
        s.boss.hp = math.max(
            0,
            s.boss.hp - math.max(1, damage)
        )
        s.boss.hit = 0.11
        burst(
            nil,
            s,
            x,
            y,
            if s.phase == 3 then "#e9baee" else "#eddaa3",
            4,
            35
        )
        if __le(s.boss.hp, 0) then
            if __lt(s.phase, 3) then
                phaseChange(nil, s, s.phase + 1)
            else
                s.stage = "victory"
                s.stageTime = 0
                s.shots = __arrL({}, 0)
                s.hazards = __arrL({}, 0)
                s.player.inv = 10
                s.shake = 10
                burst(
                    nil,
                    s,
                    s.boss.x,
                    s.boss.y,
                    "#e8ce8f",
                    45,
                    150
                )
            end
        end
        return true
    end
    local function shot(self, s, x, y, vx, vy, ____type, damage, r, extra)
        if r == nil then
            r = 9
        end
        if extra == nil then
            extra = {}
        end
        __call(
            s.shots,
            "push",
            __assign({}, {
                x = x,
                y = y,
                vx = vx,
                vy = vy,
                type = ____type,
                damage = damage,
                r = r,
                life = 7,
                age = 0,
                owner = "enemy"
            }, extra)
        )
        if __gt(
            __len(s.shots),
            180
        ) then
            __call(
                s.shots,
                "splice",
                0,
                __len(s.shots) - 180
            )
        end
    end
    local function fan(self, s, count, speed, spread)
        if spread == nil then
            spread = 0.16
        end
        local b = s.boss
        local p = s.player
        local base = math.atan2(if s.mode == "platform" then p.y - 32 else p.y - b.y, p.x - b.x)
        local gap = if s.phase == 3 then 2 else 0
        do
            local i = 0
            while __lt(i, count) do
                if __t(if __t(gap) then i == math.floor(count / 2) else gap) then
                    continue
                end
                local a = base + (i - (count - 1) / 2) * spread
                shot(
                    nil,
                    s,
                    b.x - 35,
                    b.y,
                    math.cos(a) * speed,
                    math.sin(a) * speed,
                    "ear",
                    if s.phase == 3 then 16 else 12,
                    8,
                    {spin = if __t(__mod(i, 2)) then 1 else -1}
                )
                i = i + 1
            end
        end
    end
    local function ring(self, s, count, speed, rotate)
        if rotate == nil then
            rotate = 0
        end
        local b = s.boss
        local p = s.player
        local aim = math.atan2(if s.mode == "platform" then p.y - 32 else p.y - b.y, p.x - b.x)
        do
            local i = 0
            while __lt(i, count) do
                local a = i / count * TAU + rotate
                local delta = math.atan2(
                    math.sin(a - aim),
                    math.cos(a - aim)
                )
                if math.abs(delta) < 0.2 then
                    continue
                end
                shot(
                    nil,
                    s,
                    b.x,
                    b.y,
                    math.cos(a) * speed,
                    math.sin(a) * speed,
                    "pulse",
                    12,
                    8,
                    {spin = if __t(__mod(i, 2)) then 1 else -1}
                )
                i = i + 1
            end
        end
    end
    local function beginAttack(self, s)
        local p = __get(phases, s.phase - 1)
        local b = s.boss
        b.attack = __get(
            p.attacks,
            __mod(
                b.sequence,
                __len(p.attacks)
            )
        )
        b.sequence = b.sequence + 1
        b.attackId = b.attackId + 1
        b.targetX = s.player.x
        b.targetY = if s.mode == "platform" then s.player.y - 32 else s.player.y
        b.state = "windup"
        b.stateTime = (p.windup + if b.attack == "moonBeam" then 0.28 else 0) * clamp(
            nil,
            finite(nil, s.options.windupMultiplier, 1),
            0.4,
            2
        )
        event(
            nil,
            s,
            "telegraph",
            {
                attack = b.attack,
                label = __get(attackNames, b.attack),
                duration = b.stateTime
            }
        )
    end
    local function executeAttack(self, s)
        local b = s.boss
        local p = __get(phases, s.phase - 1)
        local speed = (200 + s.phase * 25) * p.speed
        if b.attack == "earFan" then
            fan(
                nil,
                s,
                3 + s.phase * 2,
                speed,
                0.18
            )
        elseif b.attack == "pulseRing" then
            ring(
                nil,
                s,
                13,
                158,
                s.time * 0.18
            )
        elseif b.attack == "gustRing" then
            ring(
                nil,
                s,
                18,
                180,
                s.time * 0.21
            )
            __call(s.hazards, "push", {
                type = "ringBurst",
                x = b.x,
                y = b.y,
                delay = 0.7,
                life = 0.2,
                done = false
            })
        elseif b.attack == "swoop" then
            b.state = "swoop"
            b.stateTime = 1.3
            b.swoopStartX = b.x
            b.swoopStartY = b.y
            b.swoopEndX = clamp(nil, b.targetX - 60, 100, 800)
            b.swoopEndY = clamp(nil, b.targetY, 130, 430)
            return
        elseif __t(b.attack == "cloudGate" or b.attack == "crosswind") then
            local gap = if s.mode == "platform" then __get(
                __arrL({315, 345, 270}, 3),
                __mod(b.sequence, 3)
            ) else clamp(
                nil,
                130 + __mod(b.sequence * 97, 285),
                144,
                405
            )
            __call(s.hazards, "push", {
                type = "gate",
                x = 1035,
                gapY = gap,
                gapSize = if s.mode == "platform" then 168 else if b.attack == "crosswind" then 114 else 136,
                delay = 0.45,
                life = 7,
                vx = -(158 + s.phase * 13),
                damage = 18
            })
            if b.attack == "crosswind" then
                __call(
                    s.hazards,
                    "push",
                    {
                        type = "gate",
                        x = 1035,
                        gapY = clamp(nil, 535 - gap, 143, 407),
                        gapSize = 122,
                        delay = 2.35,
                        life = 7,
                        vx = -195,
                        damage = 19
                    }
                )
            end
        elseif b.attack == "platformStorm" then
            local safe = __mod(b.sequence, 3)
            do
                local i = 0
                while i < 3 do
                    if i == safe then
                        continue
                    end
                    local platform = __get(s.platforms, i)
                    __call(s.hazards, "push", {
                        type = "cloudStorm",
                        x = platform.x + platform.w / 2,
                        y = platform.y - 12,
                        delay = 1.05 + i * 0.18,
                        life = 0.18,
                        damage = 16,
                        done = false
                    })
                    i = i + 1
                end
            end
        elseif b.attack == "cometRain" then
            do
                local i = 0
                while __lt(i, 5 + s.phase) do
                    local x = 310 + i * 91
                    local y = -50 - i * 31
                    shot(
                        nil,
                        s,
                        x,
                        y,
                        -74 - s.phase * 8,
                        186 + s.phase * 17,
                        "comet",
                        15,
                        10,
                        {delay = i * 0.1, life = 6, spin = if __t(__mod(i, 2)) then 1 else -1}
                    )
                    i = i + 1
                end
            end
            if s.phase == 3 then
                fan(
                    nil,
                    s,
                    3,
                    218,
                    0.19
                )
            end
        elseif b.attack == "moonBeam" then
            __call(s.hazards, "push", {
                type = "beam",
                x = b.x,
                y = b.y,
                tx = b.targetX,
                ty = b.targetY,
                delay = 0.3,
                life = 0.42,
                damage = 23,
                done = false
            })
        end
        b.state = "firing"
        b.stateTime = 0.38
        s.shake = math.max(s.shake, if b.attack == "moonBeam" then 5 else 2)
        burst(
            nil,
            s,
            b.x - 32,
            b.y - 20,
            "#d3bedf",
            12,
            55
        )
        event(nil, s, "attack", {attack = b.attack})
    end
    local function attack(self, s, ____type)
        if ____type == nil then
            ____type = "paper"
        end
        local ____t_93 = __t
        local ____t_92 = __t
        local ____t_90 = __t
        local ____temp_89 = not __t(s) or s.stage ~= "fight"
        __O[1364] = ____temp_89
        local ____temp_91 = if ____t_90(____temp_89) then __O[1364] else s.done
        __O[1365] = ____temp_91
        if ____t_93(if ____t_92(____temp_91) then __O[1365] else __le(s.player.hp, 0)) then
            return false
        end
        local p = s.player
        local damage = clamp(nil, s.bonuses.damageMultiplier, 0.1, 100)
        local b = s.boss
        local platform = s.mode == "platform"
        local py = if __t(platform) then p.y - 35 else p.y - 10
        if ____type == "dash" then
            if __t(__gt(p.dashCooldown, 0) or __lt(p.gas, 6)) then
                return false
            end
            p.gas = p.gas - 6
            p.dash = 0.19
            p.inv = math.max(p.inv, 0.28)
            p.dashCooldown = clamp(nil, s.bonuses.dashCooldown, 0.35, 4)
            if __t(platform) then
                p.dashX = if __t(p.facing) then p.facing else 1
                p.dashY = 0
            elseif __t(not __t(p.dashX) and not __t(p.dashY)) then
                p.dashX = 1
            end
            burst(
                nil,
                s,
                p.x - 32,
                if __t(platform) then p.y - 20 else p.y,
                "#c1edc7",
                17,
                150
            )
            event(nil, s, "dash")
            return true
        end
        local facing = if __t(platform) then if __ge(b.x, p.x) then 1 else -1 else 1
        if __t(platform) then
            p.facing = facing
        end
        local origin = p.x + if __t(platform) then 23 * facing else 48
        local angle = if __t(platform) then math.atan2(b.y - 12 - py, b.x - origin) else clamp(
            nil,
            math.atan2(
                b.y - p.y,
                math.max(70, b.x - p.x)
            ),
            -0.65,
            0.65
        )
        if __t(____type == "fart" or ____type == "gas") then
            if __t(__gt(p.fartCooldown, 0) or __lt(p.gas, 22)) then
                return false
            end
            p.gas = p.gas - 22
            p.fartCooldown = 1.05
            p.attackTime = 0.3
            p.lastAttack = "fart"
            s.shots = __call(
                s.shots,
                "filter",
                function(____, a) return a.owner == "player" or __hypot(a.x - p.x, a.y - py) > 105 end
            )
            shot(
                nil,
                s,
                origin,
                py,
                math.cos(angle) * 440,
                math.sin(angle) * 440,
                "gas",
                math.floor(61 * damage + 0.5),
                29,
                {owner = "player", life = 1.8, pierce = false}
            )
            burst(
                nil,
                s,
                origin,
                py,
                "#c4e993",
                15,
                100
            )
            event(nil, s, "fart")
            return true
        end
        if ____type == "jump" then
            if not __t(platform) then
                return false
            end
            p.jumpBuffer = 0.12
            return true
        end
        if __gt(p.paperCooldown, 0) then
            return false
        end
        p.paperCooldown = 0.21
        p.attackTime = 0.22
        p.lastAttack = "paper"
        shot(
            nil,
            s,
            origin,
            py,
            math.cos(angle) * 690,
            math.sin(angle) * 690,
            "paper",
            math.floor(14 * damage + 0.5),
            6,
            {owner = "player", life = 1.6}
        )
        event(nil, s, "paper")
        return true
    end
    local function circleEllipse(self, x, y, ex, ey, rx, ry, pad)
        if pad == nil then
            pad = 0
        end
        return ((x - ex) / (rx + pad)) ^ 2 + ((y - ey) / (ry + pad)) ^ 2 <= 1
    end
    local function pointSegment(self, px, py, x1, y1, x2, y2)
        local dx = x2 - x1
        local dy = y2 - y1
        local den = dx * dx + dy * dy
        if not __t(den) then
            return __hypot(px - x1, py - y1)
        end
        local k = clamp(nil, ((px - x1) * dx + (py - y1) * dy) / den, 0, 1)
        return __hypot(px - (x1 + k * dx), py - (y1 + k * dy))
    end
    local function updatePlatformPlayer(self, s, dt, input)
        local p = s.player
        local ix = clamp(
            nil,
            finite(nil, input.x, 0),
            -1,
            1
        )
        local speed = clamp(nil, s.bonuses.moveSpeed, 140, 700)
        local wasY = p.y
        p.jumpBuffer = math.max(0, p.jumpBuffer - dt)
        p.coyote = if __t(p.grounded) then 0.11 else math.max(0, p.coyote - dt)
        if __t(if __t(input.jump) then not __t(p.jumpHeld) else input.jump) then
            p.jumpBuffer = 0.13
        end
        p.jumpHeld = not not __t(input.jump)
        if math.abs(ix) > 0.05 then
            p.facing = if ix < 0 then -1 else 1
        end
        if __t(__gt(p.jumpBuffer, 0) and __gt(p.coyote, 0)) then
            p.vy = -540
            p.grounded = false
            p.coyote = 0
            p.jumpBuffer = 0
            event(nil, s, "jump")
            burst(
                nil,
                s,
                p.x,
                p.y,
                "#c9e5e4",
                8,
                55
            )
        end
        p.vx = if __gt(p.dash, 0) then p.dashX * 2.55 else ix * speed
        p.x = clamp(nil, p.x + p.vx * dt, 28, 932)
        p.vy = math.min(780, p.vy + 1200 * dt)
        p.y = p.y + p.vy * dt
        p.grounded = false
        if __ge(p.vy, 0) then
            for ____, platform in __iterar((s.platforms)) do
                local ____t_98 = __t
                local ____t_97 = __t
                local ____t_95 = __t
                local ____temp_94 = __gt(p.x, platform.x - 7) and __lt(
                    p.x,
                    __add(platform.x, platform.w) + 7
                )
                __O[1366] = ____temp_94
                local ____temp_96 = if ____t_95(____temp_94) then __le(wasY, platform.y + 1) else __O[1366]
                __O[1367] = ____temp_96
                if ____t_98(if ____t_97(____temp_96) then __ge(p.y, platform.y) else __O[1367]) then
                    p.y = platform.y
                    p.vy = 0
                    p.grounded = true
                    p.coyote = 0.11
                    break
                end
            end
        end
        if __gt(p.y, 590) then
            p.x = 230
            p.y = 416
            p.vy = 0
            p.vx = 0
            p.grounded = true
            p.coyote = 0.11
            local before = p.hp
            damagePlayer(
                nil,
                s,
                math.min(
                    27,
                    math.max(8, p.maxHP * 0.06)
                ),
                p.x + 1
            )
            p.inv = math.max(p.inv, 1.4)
            burst(
                nil,
                s,
                p.x,
                p.y - 12,
                "#c3dfe6",
                20,
                90
            )
            event(nil, s, "fall", {hp = p.hp, damage = before - p.hp})
        end
        s.playerInputX = ix
        s.playerInputY = 0
        p.tilt = 0
    end
    local function playerCenter(self, s)
        return {x = s.player.x, y = if s.mode == "platform" then s.player.y - 31 else s.player.y}
    end
    local function update(self, s, delta, input, bonuses)
        if input == nil then
            input = {}
        end
        if bonuses == nil then
            bonuses = {}
        end
        local ____t_101 = __t
        local ____t_100 = __t
        local ____temp_99 = not __t(s)
        __O[1368] = ____temp_99
        if ____t_101(if ____t_100(____temp_99) then __O[1368] else s.done) then
            return
        end
        setBonuses(nil, s, bonuses)
        local dt = clamp(
            nil,
            finite(nil, delta, 0),
            0,
            0.05
        )
        if not __t(dt) then
            return
        end
        s.time = s.time + dt
        s.stageTime = s.stageTime + dt
        s.shake = math.max(0, s.shake - dt * 18)
        for ____, part in __iterar((s.particles)) do
            part.life = part.life - dt
            part.x = part.x + part.vx * dt
            part.y = part.y + part.vy * dt
            part.vy = part.vy + 70 * dt
        end
        s.particles = __call(
            s.particles,
            "filter",
            function(____, p) return __gt(p.life, 0) end
        )
        local p = s.player
        local b = s.boss
        for ____, key in __iterar((__arrL({
            "inv",
            "dash",
            "paperCooldown",
            "fartCooldown",
            "dashCooldown",
            "attackTime"
        }, 6))) do
            __set(
                p,
                key,
                math.max(
                    0,
                    __get(p, key) - dt
                )
            )
        end
        b.hit = math.max(0, b.hit - dt)
        b.inv = math.max(0, b.inv - dt)
        if s.stage == "intro" then
            if __ge(s.stageTime, 9) then
                startFight(nil, s)
            end
            return
        end
        if s.stage == "victory" then
            b.y = b.y + dt * 45
            b.x = b.x + math.sin(s.time * 5) * dt * 13
            if __ge(s.stageTime, 2.6) then
                s.done = true
                s.success = true
                event(nil, s, "won", {hp = p.hp, gas = p.gas})
            end
            return
        end
        if s.stage == "defeat" then
            p.y = p.y + dt * 35
            if __ge(s.stageTime, 1.4) then
                s.done = true
                event(nil, s, "defeated", {hp = 0})
            end
            return
        end
        if s.stage == "transition" then
            b.x = b.x + (740 - b.x) * math.min(1, dt * 3)
            b.y = b.y + (242 - b.y) * math.min(1, dt * 3)
            if __ge(s.stageTime, 2.05) then
                s.stage = "fight"
                s.stageTime = 0
                b.inv = 0
                b.state = "recover"
                b.stateTime = 0.55
                p.inv = math.max(p.inv, 0.6)
            end
            return
        end
        if s.mode == "platform" then
            updatePlatformPlayer(nil, s, dt, input)
        else
            local ix = clamp(
                nil,
                finite(nil, input.x, 0),
                -1,
                1
            )
            local iy = clamp(
                nil,
                finite(nil, input.y, 0),
                -1,
                1
            )
            local len = __hypot(ix, iy)
            if len > 1 then
                ix = ix / len
                iy = iy / len
            end
            if len > 0.1 then
                p.dashX = ix
                p.dashY = iy
            end
            local speed = clamp(nil, s.bonuses.moveSpeed, 140, 700) * if __gt(p.dash, 0) then 2.55 else 1
            p.vx = if __gt(p.dash, 0) then p.dashX else ix * speed
            p.vy = if __gt(p.dash, 0) then p.dashY else iy * speed
            p.x = clamp(nil, p.x + p.vx * dt, 65, 895)
            p.y = clamp(nil, p.y + p.vy * dt, 104, 454)
            p.grounded = false
            p.tilt = p.tilt + (iy * 0.075 - p.tilt) * math.min(1, dt * 8)
            s.playerInputX = ix
            s.playerInputY = iy
        end
        p.gas = math.min(
            p.maxGas,
            p.gas + clamp(nil, s.bonuses.gasRegen, 1, 150) * dt
        )
        if s.stage ~= "fight" then
            return
        end
        if __t(if __t(input.fire) then input.fire else input.paper) then
            attack(nil, s, "paper")
        end
        if __t(if __t(input.fart) then input.fart else input.gasAttack) then
            attack(nil, s, "fart")
        end
        if __t(input.dash) then
            attack(nil, s, "dash")
        end
        local ph = __get(phases, s.phase - 1)
        b.stateTime = b.stateTime - dt
        if b.state == "swoop" then
            local q = clamp(nil, 1 - b.stateTime / 1.3, 0, 1)
            local arc = math.sin(q * math.pi)
            b.x = mix(nil, b.swoopStartX, b.swoopEndX, arc)
            b.y = mix(nil, b.swoopStartY, b.swoopEndY, arc) - math.sin(q * TAU) * 20
            if __le(b.stateTime, 0) then
                b.state = "recover"
                b.stateTime = (ph.recover + 1.05) * clamp(
                    nil,
                    finite(nil, s.options.recoveryMultiplier, 1),
                    0.4,
                    2
                )
            end
        else
            local targetX = 716 + math.sin(s.time * 0.65) * 28
            local targetY = if s.mode == "platform" then 205 + math.sin(s.time * 0.93) * 48 else 246 + math.sin(s.time * (0.78 + s.phase * 0.07)) * 94
            b.x = b.x + (targetX - b.x) * math.min(1, dt * 2)
            b.y = b.y + (targetY - b.y) * math.min(1, dt * 2)
            if __le(b.stateTime, 0) then
                if b.state == "windup" then
                    executeAttack(nil, s)
                elseif b.state == "firing" then
                    b.state = "recover"
                    b.stateTime = ph.recover * clamp(
                        nil,
                        finite(nil, s.options.recoveryMultiplier, 1),
                        0.4,
                        2
                    )
                else
                    beginAttack(nil, s)
                end
            end
        end
        local center = playerCenter(nil, s)
        local ____t_104 = __t
        local ____t_103 = __t
        local ____temp_102 = b.state == "swoop"
        __O[1369] = ____temp_102
        if ____t_104(if ____t_103(____temp_102) then circleEllipse(
            nil,
            center.x,
            center.y,
            b.x,
            b.y,
            48,
            62,
            if s.mode == "platform" then 16 else 22
        ) else __O[1369]) then
            damagePlayer(nil, s, 17, b.x)
        end
        for ____, a in __iterar((s.shots)) do
            a.age = a.age + dt
            if __gt(a.delay, 0) then
                a.delay = a.delay - dt
                continue
            end
            a.life = a.life - dt
            a.x = a.x + a.vx * dt
            a.y = a.y + a.vy * dt
            if a.type == "comet" then
                a.vx = a.vx - dt * 7
                a.y = a.y + math.sin(a.age * 4) * dt * 12
            end
            if a.owner == "player" then
                local ____t_107 = __t
                local ____t_106 = __t
                local ____circleEllipse_result_105 = circleEllipse(
                    nil,
                    a.x,
                    a.y,
                    b.x,
                    b.y - 18,
                    33 + s.phase * 3,
                    59 + s.phase * 3,
                    a.r
                )
                __O[1370] = ____circleEllipse_result_105
                if ____t_107(if ____t_106(____circleEllipse_result_105) then damageBoss(
                    nil,
                    s,
                    a.damage,
                    a.x,
                    a.y
                ) else __O[1370]) then
                    a.life = 0
                end
            elseif __t(circleEllipse(
                nil,
                a.x,
                a.y,
                center.x,
                center.y,
                if s.mode == "platform" then 13 else 29,
                if s.mode == "platform" then 27 else 15,
                a.r
            )) then
                if __t(damagePlayer(nil, s, a.damage, a.x)) then
                    a.life = 0
                end
            end
        end
        s.shots = __call(
            s.shots,
            "filter",
            function(____, a)
                local ____t_113 = __t
                local ____t_111 = __t
                local ____t_109 = __t
                local ____temp_108 = __gt(a.life, 0) and __gt(a.x, -100)
                __O[1371] = ____temp_108
                local ____temp_110 = if ____t_109(____temp_108) then __lt(a.x, 1110) else __O[1371]
                __O[1372] = ____temp_110
                local ____temp_112 = if ____t_111(____temp_110) then __gt(a.y, -180) else __O[1372]
                __O[1373] = ____temp_112
                return if ____t_113(____temp_112) then __lt(a.y, 690) else __O[1373]
            end
        )
        for ____, h in __iterar((s.hazards)) do
            if __gt(h.delay, 0) then
                h.delay = h.delay - dt
                continue
            end
            h.life = h.life - dt
            if __t(h.type == "cloudStorm" and not __t(h.done)) then
                h.done = true
                shot(
                    nil,
                    s,
                    h.x,
                    90,
                    0,
                    340,
                    "comet",
                    h.damage,
                    11,
                    {life = 2.1, spin = 1}
                )
            elseif __t(h.type == "ringBurst" and not __t(h.done)) then
                h.done = true
                ring(
                    nil,
                    s,
                    15,
                    190,
                    s.time * 0.3
                )
            elseif h.type == "gate" then
                h.x = h.x + h.vx * dt
                if __t(math.abs(center.x - h.x) < 38 and math.abs(center.y - h.gapY) > h.gapSize * 0.5 - if s.mode == "platform" then 23 else 11) then
                    damagePlayer(nil, s, h.damage, h.x)
                end
            elseif __t(h.type == "beam" and not __t(h.done)) then
                local dx = h.tx - h.x
                local dy = h.ty - h.y
                local ____t_115 = __t
                local ____hypot_result_114 = __hypot(dx, dy)
                __O[1374] = ____hypot_result_114
                local L = if ____t_115(____hypot_result_114) then __O[1374] else 1
                local ex = h.x + dx / L * 1200
                local ey = h.y + dy / L * 1200
                if pointSegment(
                    nil,
                    center.x,
                    center.y,
                    h.x,
                    h.y,
                    ex,
                    ey
                ) < if s.mode == "platform" then 25 else 30 then
                    if __t(damagePlayer(nil, s, h.damage, h.x)) then
                        h.done = true
                    end
                end
            end
        end
        s.hazards = __call(
            s.hazards,
            "filter",
            function(____, h)
                local ____t_117 = __t
                local ____gt_result_116 = __gt(h.life, 0)
                __O[1375] = ____gt_result_116
                return if ____t_117(____gt_result_116) then h.type ~= "gate" or __gt(h.x, -70) else __O[1375]
            end
        )
    end
    local function advance(self, s)
        local ____t_120 = __t
        local ____t_119 = __t
        local ____temp_118 = not __t(s)
        __O[1376] = ____temp_118
        if ____t_120(if ____t_119(____temp_118) then __O[1376] else s.done) then
            return false
        end
        if s.stage == "intro" then
            s.stageTime = math.min(
                9,
                (math.floor(s.stageTime / 3) + 1) * 3
            )
            if __ge(s.stageTime, 9) then
                startFight(nil, s)
            end
            return true
        end
        if s.stage == "victory" then
            s.stageTime = 2.6
            update(nil, s, 0.001)
            return true
        end
        if s.stage == "defeat" then
            s.stageTime = 1.4
            update(nil, s, 0.001)
            return true
        end
        return false
    end
    local function cancel(self, s)
        local ____t_123 = __t
        local ____t_122 = __t
        local ____temp_121 = not __t(s)
        __O[1377] = ____temp_121
        if ____t_123(if ____t_122(____temp_121) then __O[1377] else s.done) then
            return false
        end
        s.done = true
        s.cancelled = true
        s.stage = "retreat"
        s.shots = __arrL({}, 0)
        s.hazards = __arrL({}, 0)
        event(nil, s, "retreat", {hp = s.player.hp, gas = s.player.gas})
        return true
    end
    local function drainEvents(self, s)
        if not __t(s) then
            return __arrL({}, 0)
        end
        local out = __call(s.events, "slice")
        __setlen(s.events, 0)
        return out
    end
    local function getStatus(self, s)
        if not __t(s) then
            return nil
        end
        return {
            type = "ollyan",
            name = "Ollyan · Orelhas ao Vento",
            hp = s.boss.hp,
            max = s.boss.max,
            maxHP = s.boss.max,
            phase = s.phase,
            mode = s.mode,
            phaseHPs = __call(s.phaseHPs, "slice"),
            playerGrounded = not not __t(s.player.grounded),
            playerX = s.player.x,
            playerY = s.player.y,
            playerVY = s.player.vy,
            phaseName = __get(phases, s.phase - 1).name,
            phases = 3,
            stage = s.stage,
            time = s.time,
            stageTime = s.stageTime,
            active = s.stage == "fight" or s.stage == "transition",
            done = s.done,
            success = s.success,
            playerHP = s.player.hp,
            playerMaxHP = s.player.maxHP,
            gas = s.player.gas,
            maxGas = s.player.maxGas,
            dashCooldown = s.player.dashCooldown,
            fartCooldown = s.player.fartCooldown,
            telegraph = if s.boss.state == "windup" then __get(attackNames, s.boss.attack) else "",
            attack = s.boss.attack,
            shotCount = __len(s.shots),
            hazardCount = __len(s.hazards),
            recommendedLevel = 10
        }
    end
    local function getAudioState(self, s)
        if not __t(s) then
            return nil
        end
        return {
            cutscene = if s.stage == "intro" then "ollyan_flight" else nil,
            cutsceneElapsed = if s.stage == "intro" then s.stageTime else 0,
            cutsceneToken = s.token,
            cutsceneIndex = if s.stage == "intro" then math.min(
                2,
                math.floor(s.stageTime / 3)
            ) else 0,
            cutsceneTimed = s.stage == "intro",
            boss = if __t(__call(
                __arrL({"fight", "transition"}, 2),
                "includes",
                s.stage
            )) then "ollyan" else nil
        }
    end
    local function drawProjectile(self, c, a, t)
        local ____t_129 = __t
        local ____opt_126 = window.BailePixel
        if ____opt_126 ~= nil then
            ____opt_126 = ____opt_126.projetil
        end
        local ____opt_result_128
        if ____opt_126 ~= nil then
            ____opt_result_128 = ____opt_126(____opt_126, c, a, t)
        end
        if ____t_129(____opt_result_128) then
            return
        end
        c:save()
        c:translate(
            math.floor(a.x + 0.5),
            math.floor(a.y + 0.5)
        )
        if __gt(a.delay, 0) then
            c.globalAlpha = 0.28
        end
        if a.type == "paper" then
            c:rotate(t * 8)
            rect(
                nil,
                c,
                -6,
                -5,
                12,
                10,
                "#fff1d0"
            )
            rect(
                nil,
                c,
                -3,
                -3,
                5,
                2,
                "#cabfae"
            )
        elseif a.type == "gas" then
            oval(
                nil,
                c,
                0,
                0,
                27,
                20,
                "#94bc6999"
            )
            oval(
                nil,
                c,
                -6,
                -4,
                18,
                15,
                "#c5e399bb"
            )
            rect(
                nil,
                c,
                -4,
                -8,
                8,
                4,
                "#e0efb7"
            )
        elseif a.type == "ear" then
            c:rotate(t * 4 * a.spin)
            poly(
                nil,
                c,
                __arrL(
                    {
                        __arrL({-10, -4}, 2),
                        __arrL({-4, -12}, 2),
                        __arrL({8, -12}, 2),
                        __arrL({12, -3}, 2),
                        __arrL({6, 10}, 2),
                        __arrL({-5, 8}, 2)
                    },
                    6
                ),
                "#472e4c"
            )
            poly(
                nil,
                c,
                __arrL(
                    {
                        __arrL({-6, -4}, 2),
                        __arrL({-2, -8}, 2),
                        __arrL({6, -8}, 2),
                        __arrL({8, -2}, 2),
                        __arrL({3, 6}, 2),
                        __arrL({-3, 5}, 2)
                    },
                    6
                ),
                "#e5baac"
            )
            line(
                nil,
                c,
                __arrL(
                    {
                        __arrL({-2, -4}, 2),
                        __arrL({3, -3}, 2),
                        __arrL({0, 3}, 2)
                    },
                    3
                ),
                "#a8798f",
                2
            )
        elseif a.type == "comet" then
            c:rotate(-0.5)
            poly(
                nil,
                c,
                __arrL(
                    {
                        __arrL({3, 11}, 2),
                        __arrL({-9, -18}, 2),
                        __arrL({2, -12}, 2),
                        __arrL({9, -25}, 2),
                        __arrL({13, 0}, 2)
                    },
                    5
                ),
                "#b0cff188"
            )
            oval(
                nil,
                c,
                0,
                0,
                10,
                12,
                "#535b9c"
            )
            oval(
                nil,
                c,
                -2,
                -1,
                6,
                7,
                "#d2b5e7"
            )
            rect(
                nil,
                c,
                -3,
                -3,
                3,
                3,
                "#f3e3ef"
            )
        else
            oval(
                nil,
                c,
                0,
                0,
                9,
                9,
                "#9a7ca9"
            )
            oval(
                nil,
                c,
                0,
                0,
                5,
                5,
                "#e4c8e4"
            )
            rect(
                nil,
                c,
                -2,
                -3,
                3,
                3,
                "#f6e2e5"
            )
        end
        c:restore()
    end
    local function hazardDraw(self, c, h, t)
        local ____t_135 = __t
        local ____opt_132 = window.BailePixel
        if ____opt_132 ~= nil then
            ____opt_132 = ____opt_132.perigo
        end
        local ____opt_result_134
        if ____opt_132 ~= nil then
            ____opt_result_134 = ____opt_132(____opt_132, c, h, t)
        end
        if ____t_135(____opt_result_134) then
            return
        end
        c:save()
        if h.type == "gate" then
            local x = if __gt(h.delay, 0) then 930 else h.x
            local alpha = if __gt(h.delay, 0) then 0.45 else 1
            c.globalAlpha = c.globalAlpha * alpha
            do
                local yy = 90
                while yy < 494 do
                    if math.abs(yy - h.gapY) < h.gapSize * 0.5 then
                        continue
                    end
                    cloud(
                        nil,
                        c,
                        x,
                        yy,
                        0.55,
                        "#a7bed8",
                        0.9
                    )
                    line(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({x + 13, yy - 2}, 2),
                                __arrL({x - 8, yy + 2}, 2),
                                __arrL({x - 25, yy - 1}, 2)
                            },
                            3
                        ),
                        "#e2d7e9",
                        2
                    )
                    yy = yy + 29
                end
            end
            if __gt(h.delay, 0) then
                line(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({889, h.gapY - h.gapSize * 0.5}, 2),
                            __arrL({909, h.gapY - h.gapSize * 0.5}, 2),
                            __arrL({909, h.gapY + h.gapSize * 0.5}, 2),
                            __arrL({889, h.gapY + h.gapSize * 0.5}, 2)
                        },
                        4
                    ),
                    "#bcebc6",
                    3
                )
                text(
                    nil,
                    c,
                    "VÃO",
                    871,
                    h.gapY,
                    11,
                    "#c7efcc"
                )
            end
        elseif h.type == "cloudStorm" then
            c.globalAlpha = if __gt(h.delay, 0) then 0.7 else 0.3
            line(
                nil,
                c,
                __arrL(
                    {
                        __arrL({h.x, 88}, 2),
                        __arrL({h.x, h.y}, 2)
                    },
                    2
                ),
                "#edbc9e",
                2
            )
            oval(
                nil,
                c,
                h.x,
                h.y,
                35,
                8,
                "#dca9d266"
            )
            text(
                nil,
                c,
                "!",
                h.x,
                h.y - 17,
                19,
                "#f1d19e"
            )
        elseif h.type == "beam" then
            local dx = h.tx - h.x
            local dy = h.ty - h.y
            local ____t_137 = __t
            local ____hypot_result_136 = __hypot(dx, dy)
            __O[1378] = ____hypot_result_136
            local len = if ____t_137(____hypot_result_136) then __O[1378] else 1
            local ex = h.x + dx / len * 1200
            local ey = h.y + dy / len * 1200
            if __gt(h.delay, 0) then
                c:setLineDash(__arrL({12, 9}, 2))
                line(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({h.x, h.y}, 2),
                            __arrL({ex, ey}, 2)
                        },
                        2
                    ),
                    "#f5c8ad",
                    3
                )
                c:setLineDash(__arrL({}, 0))
            else
                line(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({h.x, h.y}, 2),
                            __arrL({ex, ey}, 2)
                        },
                        2
                    ),
                    "#79559199",
                    44
                )
                line(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({h.x, h.y}, 2),
                            __arrL({ex, ey}, 2)
                        },
                        2
                    ),
                    "#d3b5e2",
                    21
                )
                line(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({h.x, h.y}, 2),
                            __arrL({ex, ey}, 2)
                        },
                        2
                    ),
                    "#fcf0e7",
                    7
                )
            end
        elseif __t(h.type == "ringBurst" and __gt(h.delay, 0)) then
            c.globalAlpha = c.globalAlpha * 0.4
            oval(
                nil,
                c,
                h.x,
                h.y,
                36 + math.sin(t * 7) * 4,
                36 + math.sin(t * 7) * 4,
                "#bf94d155"
            )
        end
        c:restore()
    end
    local function skyPlatforms(self, c, s, alpha)
        if alpha == nil then
            alpha = 1
        end
        c:save()
        c.globalAlpha = c.globalAlpha * alpha
        for ____, p in __iterar((s.platforms)) do
            local y = p.y
            rect(
                nil,
                c,
                p.x + 6,
                y,
                p.w - 12,
                13,
                "#536e99"
            )
            rect(
                nil,
                c,
                p.x + 3,
                y - 5,
                p.w - 6,
                8,
                "#c4e1e7"
            )
            rect(
                nil,
                c,
                p.x + 11,
                y - 9,
                p.w - 22,
                6,
                "#eff1e2"
            )
            do
                local x = p.x + 8
                while __lt(
                    x,
                    __add(p.x, p.w) - 8
                ) do
                    rect(
                        nil,
                        c,
                        x,
                        y + 10,
                        21,
                        7,
                        "#6482ad"
                    )
                    rect(
                        nil,
                        c,
                        x + 4,
                        y + 16,
                        12,
                        4,
                        "#445f8c"
                    )
                    x = x + 29
                end
            end
            do
                local x = p.x + 15
                while __lt(
                    x,
                    __add(p.x, p.w) - 8
                ) do
                    rect(
                        nil,
                        c,
                        x,
                        y - 13,
                        25,
                        6,
                        "#dbe9e7"
                    )
                    x = x + 38
                end
            end
        end
        c:restore()
    end
    local function parkedVehicle(self, c, s, alpha)
        if alpha == nil then
            alpha = 1
        end
        c:save()
        c.globalAlpha = c.globalAlpha * alpha
        local ____t_140 = __t
        local ____opt_138 = window.Art
        if ____opt_138 ~= nil then
            ____opt_138 = ____opt_138.drawVehicle
        end
        if ____t_140(____opt_138) then
            window.Art:drawVehicle(c, s.parkedCar.x, s.parkedCar.y, s.time * 0.35)
        else
            rect(
                nil,
                c,
                s.parkedCar.x - 50,
                s.parkedCar.y - 21,
                100,
                28,
                "#758e5d"
            )
            rect(
                nil,
                c,
                s.parkedCar.x - 20,
                s.parkedCar.y - 42,
                40,
                24,
                "#b3c29b"
            )
        end
        c:restore()
    end
    local function onFoot(self, c, s, x, y, alpha)
        if x == nil then
            x = s.player.x
        end
        if y == nil then
            y = s.player.y
        end
        if alpha == nil then
            alpha = 1
        end
        local p = s.player
        c:save()
        c.globalAlpha = c.globalAlpha * alpha
        if __t(__gt(p.inv, 0) and __mod(
            math.floor(s.time * 18),
            2
        ) == 0) then
            c.globalAlpha = c.globalAlpha * 0.55
        end
        if __gt(p.dash, 0) then
            do
                local i = 0
                while i < 4 do
                    c:save()
                    c.globalAlpha = c.globalAlpha * (0.16 - i * 0.03)
                    rect(
                        nil,
                        c,
                        x - p.facing * (18 + i * 14) - 9,
                        y - 47,
                        18,
                        43,
                        "#ccedca"
                    )
                    c:restore()
                    i = i + 1
                end
            end
        end
        local ____t_143 = __t
        local ____opt_141 = window.Art
        if ____opt_141 ~= nil then
            ____opt_141 = ____opt_141.drawCharacter
        end
        if ____t_143(____opt_141) then
            window.Art:drawCharacter(
                c,
                "daroca",
                x,
                y,
                {
                    frame = s.time,
                    facing = p.facing,
                    muscular = not not __t(s.options.trained),
                    moving = math.abs(p.vx) > 10,
                    speed = math.abs(p.vx),
                    grounded = p.grounded,
                    vy = p.vy,
                    attack = __gt(p.attackTime, 0),
                    attackType = p.lastAttack,
                    attackProgress = 1 - p.attackTime / 0.3,
                    animation = if __t(p.grounded) then if math.abs(p.vx) > 10 then "run" else "idle" else if __lt(p.vy, 0) then "jump" else "fall"
                }
            )
        else
            rect(
                nil,
                c,
                x - 10,
                y - 49,
                20,
                35,
                "#d7924f"
            )
            rect(
                nil,
                c,
                x - 15,
                y - 57,
                30,
                7,
                "#dec28b"
            )
            rect(
                nil,
                c,
                x - 8,
                y - 14,
                6,
                14,
                "#31465a"
            )
            rect(
                nil,
                c,
                x + 3,
                y - 14,
                6,
                14,
                "#31465a"
            )
        end
        c:restore()
    end
    local function transitionPilot(self, c, s)
        local q = clamp(nil, s.stageTime / 2.05, 0, 1)
        local from = if __t(s.transitionStart) then s.transitionStart else {x = 196, y = 320, mode = "car"}
        local park = s.parkedCar
        if s.mode == "platform" then
            skyPlatforms(
                nil,
                c,
                s,
                smooth(nil, q / 0.6)
            )
            if q < 0.48 then
                local k = smooth(nil, q / 0.48)
                pilot(
                    nil,
                    c,
                    mix(nil, from.x, park.x, k),
                    mix(nil, from.y, park.y - 10, k),
                    s.time,
                    {trained = s.options.trained}
                )
            else
                parkedVehicle(nil, c, s)
                local k = smooth(nil, (q - 0.48) / 0.52)
                onFoot(
                    nil,
                    c,
                    s,
                    mix(nil, park.x + 8, s.player.x, k),
                    mix(nil, park.y - 17, s.player.y, k) - math.sin(k * math.pi) * 34
                )
            end
        else
            skyPlatforms(
                nil,
                c,
                s,
                1 - smooth(nil, (q - 0.52) / 0.48)
            )
            if q < 0.5 then
                local k = smooth(nil, q / 0.5)
                parkedVehicle(nil, c, s, 1 - k)
                local carX = mix(nil, park.x, from.x, k)
                local carY = mix(nil, park.y - 10, from.y - 25, k)
                pilot(
                    nil,
                    c,
                    carX,
                    carY,
                    s.time,
                    {trained = s.options.trained}
                )
                onFoot(
                    nil,
                    c,
                    s,
                    from.x,
                    from.y - k * 20,
                    1 - k
                )
            else
                local k = smooth(nil, (q - 0.5) / 0.5)
                pilot(
                    nil,
                    c,
                    mix(nil, from.x, s.player.x, k),
                    mix(nil, from.y - 25, s.player.y, k),
                    s.time,
                    {trained = s.options.trained, dash = true}
                )
            end
        end
    end
    local function draw(self, c, s, options)
        if options == nil then
            options = {}
        end
        if not __t(s) then
            return
        end
        if s.stage == "intro" then
            drawIntro(nil, c, s.stageTime, s.options)
            return
        end
        c:save()
        c.imageSmoothingEnabled = false
        sky(nil, c, s.time, s.phase)
        if __gt(s.shake, 0) then
            local a = s.shake / 7
            c:translate(
                math.sin(s.time * 55) * a * 2,
                math.cos(s.time * 43) * a * 1.6
            )
        end
        if __t(s.stage ~= "transition" and s.mode == "platform") then
            skyPlatforms(nil, c, s)
            parkedVehicle(nil, c, s)
        end
        for ____, h in __iterar((s.hazards)) do
            hazardDraw(nil, c, h, s.time)
        end
        local b = s.boss
        local p = s.player
        local scale = 1.37 + (s.phase - 1) * 0.09
        local aura = if s.phase == 3 then "#bda7e2" else if s.phase == 2 then "#9acbdf" else nil
        local ____opt_146 = window.BailePixel
        if ____opt_146 ~= nil then
            ____opt_146 = ____opt_146.antesChefe
        end
        if ____opt_146 ~= nil then
            ____opt_146(____opt_146, c, s)
        end
        if s.stage == "victory" then
            drawOllyan(
                nil,
                c,
                b.x,
                b.y + 63,
                s.time,
                {
                    scale = 1.23,
                    flying = true,
                    angle = math.sin(s.stageTime * 5) * 0.25,
                    cup = false
                }
            )
            do
                local i = 0
                while i < 14 do
                    local q = __mod(s.stageTime * 0.5 + i * 0.11, 1)
                    rect(
                        nil,
                        c,
                        b.x + math.sin(i * 2.2) * q * 150,
                        b.y - 100 + q * 180,
                        4,
                        4,
                        __get(
                            __arrL({"#e4cb8d", "#bddecb", "#c4b4df"}, 3),
                            __mod(i, 3)
                        )
                    )
                    i = i + 1
                end
            end
        else
            drawOllyan(
                nil,
                c,
                b.x,
                b.y + 63,
                s.time,
                {
                    scale = scale,
                    flying = true,
                    fast = b.state == "windup" or s.phase == 3,
                    hit = __gt(b.hit, 0),
                    aura = aura,
                    angle = if b.state == "swoop" then math.sin(s.time * 8) * 0.13 else 0
                }
            )
        end
        for ____, a in __iterar((s.shots)) do
            drawProjectile(nil, c, a, s.time)
        end
        if s.stage == "transition" then
            transitionPilot(nil, c, s)
        elseif s.mode == "platform" then
            onFoot(nil, c, s)
        else
            pilot(
                nil,
                c,
                p.x,
                p.y,
                s.time,
                {
                    angle = p.tilt,
                    inv = p.inv,
                    dash = __gt(p.dash, 0),
                    trained = s.options.trained
                }
            )
        end
        for ____, part in __iterar((s.particles)) do
            c:save()
            c.globalAlpha = clamp(nil, part.life / part.maxLife, 0, 1)
            rect(
                nil,
                c,
                part.x,
                part.y,
                part.size,
                part.size,
                part.color
            )
            c:restore()
        end
        c:restore()
        if options.hud ~= false then
            rect(
                nil,
                c,
                222,
                31,
                516,
                23,
                "#152139db"
            )
            text(
                nil,
                c,
                "OLLYAN",
                236,
                42,
                10,
                "#eedcb5",
                "left"
            )
            rect(
                nil,
                c,
                326,
                37,
                394,
                8,
                "#3b3c58"
            )
            rect(
                nil,
                c,
                326,
                37,
                394 * b.hp / b.max,
                8,
                if s.phase == 3 then "#bd91db" else if s.phase == 2 then "#9acdd5" else "#e0bb8e"
            )
            text(
                nil,
                c,
                __add(s.phase, "/3"),
                744,
                42,
                10,
                "#e5d5e5"
            )
        end
        if s.stage == "transition" then
            local alpha = smooth(
                nil,
                math.min(s.stageTime / 0.25, (2.05 - s.stageTime) / 0.25)
            )
            c:save()
            c.globalAlpha = alpha
            rect(
                nil,
                c,
                177,
                215,
                606,
                91,
                "#17223ee8"
            )
            rect(
                nil,
                c,
                181,
                219,
                598,
                2,
                "#cdb3dc"
            )
            text(
                nil,
                c,
                __add(
                    __add("FASE ", s.phase),
                    " / 3"
                ),
                480,
                239,
                12,
                "#edce9a"
            )
            text(
                nil,
                c,
                __get(phases, s.phase - 1).name,
                480,
                270,
                21,
                "#e2d3ee"
            )
            text(
                nil,
                c,
                if s.mode == "platform" then "SAIA DO CARRO · ANDE E PULE PELAS NUVENS" else "VOLTE AO CARRO A GÁS · O CÉU É SEU",
                480,
                296,
                10,
                "#cce8de"
            )
            c:restore()
        elseif __t(s.stage == "fight" and b.state == "windup") then
            local title = __get(attackNames, b.attack)
            rect(
                nil,
                c,
                480 - __len(title) * 3.9,
                66,
                __len(title) * 7.8,
                22,
                "#142440c9"
            )
            text(
                nil,
                c,
                title,
                480,
                77,
                11,
                if b.attack == "moonBeam" then "#f6cbab" else "#d5e6d5"
            )
            local ____t_153 = __t
            local ____opt_150 = window.BailePixel
            if ____opt_150 ~= nil then
                ____opt_150 = ____opt_150.telegrafa
            end
            local ____opt_result_152
            if ____opt_150 ~= nil then
                ____opt_result_152 = ____opt_150(____opt_150, c, s)
            end
            if not ____t_153(____opt_result_152) then
                if b.attack == "swoop" then
                    c:save()
                    c.globalAlpha = 0.35
                    line(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({b.x, b.y}, 2),
                                __arrL({b.targetX, b.targetY}, 2)
                            },
                            2
                        ),
                        "#eacfa2",
                        22
                    )
                    c:restore()
                    oval(
                        nil,
                        c,
                        b.targetX,
                        b.targetY,
                        19,
                        19,
                        "#f1d19844"
                    )
                    line(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({b.targetX - 14, b.targetY}, 2),
                                __arrL({b.targetX + 14, b.targetY}, 2)
                            },
                            2
                        ),
                        "#edc995",
                        2
                    )
                end
                if b.attack == "moonBeam" then
                    local dx = b.targetX - b.x
                    local dy = b.targetY - b.y
                    local ____t_155 = __t
                    local ____hypot_result_154 = __hypot(dx, dy)
                    __O[1379] = ____hypot_result_154
                    local len = if ____t_155(____hypot_result_154) then __O[1379] else 1
                    c:save()
                    c:setLineDash(__arrL({11, 8}, 2))
                    line(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({b.x, b.y}, 2),
                                __arrL({b.x + dx / len * 1200, b.y + dy / len * 1200}, 2)
                            },
                            2
                        ),
                        "#e5bfa2",
                        2
                    )
                    c:restore()
                end
            end
        end
        local ____t_158 = __t
        local ____t_157 = __t
        local ____temp_156 = s.stage == "fight"
        __O[1380] = ____temp_156
        if ____t_158(if ____t_157(____temp_156) then __lt(s.time, 15) or s.mode == "platform" else __O[1380]) then
            text(
                nil,
                c,
                if s.mode == "platform" then "A / D OU JOYSTICK: ANDAR · ESPAÇO / PULAR: SALTAR · PAPEL / PEIDO / DASH" else "VOE EM TODAS AS DIREÇÕES · PAPEL / PEIDO / DASH",
                480,
                508,
                10,
                "#d2d0df"
            )
        end
        if s.stage == "victory" then
            text(
                nil,
                c,
                "O CÉU FICOU PEQUENO PRA ESSA ORELHA!",
                480,
                144,
                20,
                "#f5d99b"
            )
            text(
                nil,
                c,
                "Ollyan: tá bom, véi… agora eu vou de carona.",
                480,
                173,
                12,
                "#e8d9df"
            )
        end
        if s.stage == "defeat" then
            rect(
                nil,
                c,
                0,
                0,
                W,
                H,
                "#101b3566"
            )
            text(
                nil,
                c,
                "O MOTOR PERDEU O FÔLEGO…",
                480,
                239,
                22,
                "#e8ccd9"
            )
            text(
                nil,
                c,
                "Invista nos atributos e tente outra rota entre as rajadas.",
                480,
                273,
                12,
                "#d2d9e4"
            )
        end
    end
    window.BaileWorld = __ord(
        {
            version = 1,
            draw = world,
            drawOllyan = drawOllyan,
            getLength = function() return LENGTH end,
            getCrowdCount = function() return 232 end,
            getNPC = function() return {
                id = "ollyan",
                name = "Ollyan · Orelhas ao Vento",
                scene = 11,
                x = NPC_X,
                y = FLOOR
            } end,
            drawForeground = function()
            end
        },
        "version,draw,drawOllyan,getLength,getCrowdCount,getNPC,drawForeground"
    )
    window.OllyanEncounter = __ord(
        {
            version = 1,
            create = create,
            update = update,
            draw = draw,
            attack = attack,
            advance = advance,
            cancel = cancel,
            retreat = cancel,
            setPlayer = setPlayer,
            setBonuses = setBonuses,
            getStatus = getStatus,
            getAudioState = getAudioState,
            drainEvents = drainEvents,
            isDone = function(____, s)
                local ____t_162 = __t
                local ____opt_result_161
                if s ~= nil then
                    ____opt_result_161 = s.done
                end
                return not not ____t_162(____opt_result_161)
            end,
            previewTimeline = previewTimeline,
            getIntroTimeline = previewTimeline,
            drawIntro = drawIntro,
            renderIntro = renderIntro,
            phases = phases
        },
        "version,create,update,draw,attack,advance,cancel,retreat,setPlayer,setBonuses,getStatus,getAudioState,drainEvents,isDone,previewTimeline,getIntroTimeline,drawIntro,renderIntro,phases"
    )
end)(nil)
return ____exports
