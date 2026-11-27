--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __le, __gt, __mod, __ord, __arrL, __iterar, __t, __get, __arr, __len, __call = __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__arr, __JSR.__len, __JSR.__call
local __add, __iter, __assign = __JSR.__add, __JSR.__iter, __JSR.__assign
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Spread = ____lualib.__TS__Spread
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local __TS__Number = ____lualib.__TS__Number
local ____exports = {}
local __O = {};
(function()
    local path, fill, line, oval, kneel
    function path(self, c, pts, close)
        if close == nil then
            close = true
        end
        c:beginPath()
        __call(
            pts,
            "forEach",
            function(____, p, i) return if __t(i) then c:lineTo(
                __get(p, 0),
                __get(p, 1)
            ) else c:moveTo(
                __get(p, 0),
                __get(p, 1)
            ) end
        )
        if __t(close) then
            c:closePath()
        end
    end
    function fill(self, c, pts, col)
        path(nil, c, pts)
        c.fillStyle = col
        __call(c, "fill")
    end
    function line(self, c, pts, col, w)
        if w == nil then
            w = 3
        end
        path(nil, c, pts, false)
        c.strokeStyle = col
        c.lineWidth = w
        c.lineCap = "round"
        c.lineJoin = "round"
        c:stroke()
    end
    function oval(self, c, x, y, rx, ry, col, rot)
        if rot == nil then
            rot = 0
        end
        c:beginPath()
        c:ellipse(
            x,
            y,
            math.max(0.1, rx),
            math.max(0.1, ry),
            rot,
            0,
            math.pi * 2
        )
        c.fillStyle = col
        __call(c, "fill")
    end
    function kneel(self, c, t)
        c:save()
        c:translate(480, 440)
        local breathe = math.sin(t * 1.4) * 2
        fill(
            nil,
            c,
            __arrL(
                {
                    __arrL({-60, 0}, 2),
                    __arrL({-50, -50}, 2),
                    __arrL({-20, -62}, 2),
                    __arrL({30, -62}, 2),
                    __arrL({60, -40}, 2),
                    __arrL({70, 0}, 2)
                },
                6
            ),
            "#0a0b14"
        )
        fill(
            nil,
            c,
            __arrL(
                {
                    __arrL({-40, -60}, 2),
                    __arrL({-46, -150 + breathe}, 2),
                    __arrL({-10, -170 + breathe}, 2),
                    __arrL({30, -165 + breathe}, 2),
                    __arrL({44, -120}, 2),
                    __arrL({40, -60}, 2)
                },
                6
            ),
            "#0e0f1c"
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({-46, -150 + breathe}, 2),
                    __arrL({-10, -170 + breathe}, 2),
                    __arrL({30, -165 + breathe}, 2)
                },
                3
            ),
            "#7a90c8",
            2
        )
        oval(
            nil,
            c,
            -6,
            -184 + breathe,
            22,
            20,
            "#0e0f1c"
        )
        oval(
            nil,
            c,
            -6,
            -196 + breathe,
            66,
            13,
            "#1a1622"
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({-72, -196 + breathe}, 2),
                    __arrL({-30, -207 + breathe}, 2),
                    __arrL({20, -207 + breathe}, 2),
                    __arrL({60, -196 + breathe}, 2)
                },
                4
            ),
            "#9fb4e8",
            2
        )
        fill(
            nil,
            c,
            __arrL(
                {
                    __arrL({-34, -202 + breathe}, 2),
                    __arrL({-28, -232 + breathe}, 2),
                    __arrL({18, -232 + breathe}, 2),
                    __arrL({24, -202 + breathe}, 2)
                },
                4
            ),
            "#1a1622"
        )
        fill(
            nil,
            c,
            __arrL(
                {
                    __arrL({-46, -140 + breathe}, 2),
                    __arrL({-70, -70}, 2),
                    __arrL({-60, -20}, 2),
                    __arrL({-50, -24}, 2),
                    __arrL({-56, -70}, 2),
                    __arrL({-34, -120}, 2)
                },
                6
            ),
            "#0e0f1c"
        )
        fill(
            nil,
            c,
            __arrL(
                {
                    __arrL({34, -140 + breathe}, 2),
                    __arrL({62, -70}, 2),
                    __arrL({56, -20}, 2),
                    __arrL({46, -24}, 2),
                    __arrL({48, -70}, 2),
                    __arrL({26, -120}, 2)
                },
                6
            ),
            "#0e0f1c"
        )
        c:restore()
    end
    local ____ = "use strict"
    local ____t_2 = __t
    local ____t_1 = __t
    local ____temp_0 = not __t(window.JorgeEpilogue)
    __O[1529] = ____temp_0
    if ____t_2(if ____t_1(____temp_0) then __O[1529] else window.JorgeAnime) then
        return
    end
    if not __t(window.CanvasRenderingContext2D.prototype.roundRect) then
        window.CanvasRenderingContext2D.prototype.roundRect = function(self, x, y, w, h, r)
            self:moveTo(
                __add(x, r),
                y
            )
            self:arcTo(
                __add(x, w),
                y,
                __add(x, w),
                __add(y, h),
                r
            )
            self:arcTo(
                __add(x, w),
                __add(y, h),
                x,
                __add(y, h),
                r
            )
            self:arcTo(
                x,
                __add(y, h),
                x,
                y,
                r
            )
            self:arcTo(
                x,
                y,
                __add(x, w),
                y,
                r
            )
            self:closePath()
        end
    end
    local W = 960
    local H = 540
    local INK = "#150f19"
    local function clamp(____, v, a, b)
        if a == nil then
            a = 0
        end
        if b == nil then
            b = 1
        end
        return math.max(
            a,
            math.min(b, v)
        )
    end
    local function smooth(____, v)
        v = clamp(nil, v)
        return v * v * (3 - 2 * v)
    end
    local function ease(____, v)
        return 1 - (1 - clamp(nil, v)) ^ 3
    end
    local function lerp(____, a, b, p)
        return a + (b - a) * p
    end
    local function rnd(____, n)
        local x = math.sin(n * 91.345 + 12.9898) * 43758.5453
        return x - math.floor(x)
    end
    local function circ(self, c, x, y, r, col)
        c:beginPath()
        c:arc(
            x,
            y,
            math.max(0.1, r),
            0,
            math.pi * 2
        )
        c.fillStyle = col
        __call(c, "fill")
    end
    local function glow(self, c, x, y, r, col, a)
        local g = c:createRadialGradient(
            x,
            y,
            1,
            x,
            y,
            r
        )
        g:addColorStop(
            0,
            __call(col, "replace", "A", a)
        )
        g:addColorStop(
            1,
            __call(col, "replace", "A", 0)
        )
        c:save()
        c.globalCompositeOperation = "screen"
        c.fillStyle = g
        c:fillRect(x - r, y - r, r * 2, r * 2)
        c:restore()
    end
    local function vgrad(self, c, stops, y0, y1)
        if y0 == nil then
            y0 = 0
        end
        if y1 == nil then
            y1 = H
        end
        local g = c:createLinearGradient(0, y0, 0, y1)
        __call(
            stops,
            "forEach",
            function(____, ____bindingPattern0)
                local col
                local o
                o = ____bindingPattern0[1]
                col = ____bindingPattern0[2]
                return g:addColorStop(o, col)
            end
        )
        c.fillStyle = g
        c:fillRect(0, y0, W, y1 - y0)
    end
    local function speedLines(self, c, cx, cy, n, inner, col, alpha, t, seed)
        if seed == nil then
            seed = 0
        end
        c:save()
        c.globalAlpha = alpha
        c.fillStyle = col
        do
            local i = 0
            while __lt(i, n) do
                local a = rnd(
                    nil,
                    i + seed + math.floor(t * 12) * 0.13
                ) * math.pi * 2
                local w = 0.004 + rnd(nil, i * 3 + seed) * 0.012
                local r0 = inner + rnd(
                    nil,
                    i * 7 + math.floor(t * 12)
                ) * 60
                c:beginPath()
                c:moveTo(
                    cx + math.cos(a - w) * r0,
                    cy + math.sin(a - w) * r0
                )
                c:lineTo(
                    cx + math.cos(a) * 1200,
                    cy + math.sin(a) * 1200
                )
                c:lineTo(
                    cx + math.cos(a + w) * r0,
                    cy + math.sin(a + w) * r0
                )
                c:closePath()
                __call(c, "fill")
                i = i + 1
            end
        end
        c:restore()
    end
    local function rain(self, c, t, n, alpha, slant)
        if slant == nil then
            slant = 0.18
        end
        c:save()
        c.globalAlpha = alpha
        c.strokeStyle = "#a9b8d8"
        c.lineWidth = 1.2
        c:beginPath()
        do
            local i = 0
            while __lt(i, n) do
                local x = __mod(
                    rnd(nil, i) * (W + 200) + t * 120 * slant * 4,
                    W + 200
                ) - 100
                local y = __mod(
                    rnd(nil, i * 5) * H + t * (900 + rnd(nil, i * 2) * 400),
                    H + 60
                ) - 30
                local l = 14 + rnd(nil, i * 9) * 18
                c:moveTo(x, y)
                c:lineTo(x - l * slant, y + l)
                i = i + 1
            end
        end
        c:stroke()
        c:restore()
    end
    local function stars(self, c, t, n, y1)
        do
            local i = 0
            while __lt(i, n) do
                local x = rnd(nil, i * 3) * W
                local y = rnd(nil, i * 7) * y1
                local tw = 0.4 + 0.6 * math.abs(math.sin(t * (1 + rnd(nil, i)) + i))
                c.globalAlpha = tw * (0.5 + rnd(nil, i * 11) * 0.5)
                c.fillStyle = "#f4f0ff"
                c:fillRect(x, y, if rnd(nil, i) > 0.9 then 2 else 1, if rnd(nil, i) > 0.9 then 2 else 1)
                i = i + 1
            end
        end
        c.globalAlpha = 1
    end
    local function bokeh(self, c, t, n, col, seed)
        if seed == nil then
            seed = 0
        end
        c:save()
        c.globalCompositeOperation = "screen"
        do
            local i = 0
            while __lt(i, n) do
                local x = rnd(nil, i + seed) * W + math.sin(t * 0.3 + i) * 20
                local y = rnd(nil, i * 4 + seed) * H + math.cos(t * 0.25 + i) * 14
                local r = 10 + rnd(nil, i * 6 + seed) * 34
                c.globalAlpha = 0.06 + rnd(nil, i * 8) * 0.1
                circ(
                    nil,
                    c,
                    x,
                    y,
                    r,
                    col
                )
                i = i + 1
            end
        end
        c:restore()
    end
    local function shake(self, c, amt, t)
        c:translate(
            math.sin(t * 61) * amt,
            math.cos(t * 47) * amt
        )
    end
    local function subtitle(self, c, speaker, text, a)
        if __t(__le(a, 0) or not __t(text)) then
            return
        end
        c:save()
        c.globalAlpha = a
        c.textAlign = "center"
        c.textBaseline = "middle"
        if __t(speaker) then
            c.font = "700 13px Space,Arial,sans-serif"
            c.fillStyle = "#ffd979"
            c:fillText(
                __call(speaker, "toUpperCase"),
                W / 2,
                H - 78
            )
        end
        c.font = "600 26px Space,Arial,sans-serif"
        c.lineWidth = 6
        c.lineJoin = "round"
        c.strokeStyle = "#000000cc"
        c:strokeText(text, W / 2, H - 52)
        c.fillStyle = "#ffffff"
        c:fillText(text, W / 2, H - 52)
        c:restore()
    end
    local function tracked(self, c, value, x, y, size, color, spacing)
        if spacing == nil then
            spacing = 4
        end
        c:save()
        c.font = ("700 " .. tostring(size)) .. "px Space,Arial,sans-serif"
        c.textBaseline = "middle"
        local chars = __arr(__TS__Spread(__iter(value)))
        local w = __call(
            chars,
            "reduce",
            function(____, n, l) return __add(
                n,
                c:measureText(l).width
            ) end,
            0
        ) + (__len(chars) - 1) * spacing
        local at = x - w / 2
        c.fillStyle = color
        for ____, l in __iterar((chars)) do
            c:fillText(l, at, y)
            at = at + (c:measureText(l).width + spacing)
        end
        c:restore()
    end
    local SKIN = "#c98a5e"
    local SKIN_SH = "#93583a"
    local SKIN_HI = "#e2a97b"
    local SHIRT = "#d9782f"
    local SHIRT_SH = "#9c4b1d"
    local function hat(self, c, s, t, tilt)
        if tilt == nil then
            tilt = 0
        end
        c:save()
        c:rotate(tilt)
        oval(
            nil,
            c,
            0,
            -52,
            160,
            34,
            "#7d5a26"
        )
        oval(
            nil,
            c,
            0,
            -56,
            156,
            30,
            "#d9b46a"
        )
        oval(
            nil,
            c,
            0,
            -52,
            120,
            18,
            "#a8823e"
        )
        path(
            nil,
            c,
            __arrL(
                {
                    __arrL({-70, -60}, 2),
                    __arrL({-62, -128}, 2),
                    __arrL({-30, -142}, 2),
                    __arrL({30, -142}, 2),
                    __arrL({62, -128}, 2),
                    __arrL({70, -60}, 2)
                },
                6
            )
        )
        c.fillStyle = "#e6c47a"
        __call(c, "fill")
        c.lineWidth = 3
        c.strokeStyle = INK
        c:stroke()
        path(
            nil,
            c,
            __arrL(
                {
                    __arrL({30, -142}, 2),
                    __arrL({62, -128}, 2),
                    __arrL({70, -60}, 2),
                    __arrL({40, -60}, 2)
                },
                4
            )
        )
        c.fillStyle = "#c29a54"
        __call(c, "fill")
        fill(
            nil,
            c,
            __arrL(
                {
                    __arrL({-70, -78}, 2),
                    __arrL({70, -78}, 2),
                    __arrL({69, -64}, 2),
                    __arrL({-69, -64}, 2)
                },
                4
            ),
            "#7a4a24"
        )
        c.globalAlpha = 0.35
        do
            local i = -6
            while i <= 6 do
                line(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({i * 10, -138}, 2),
                            __arrL({i * 11, -66}, 2)
                        },
                        2
                    ),
                    "#8d6a32",
                    1
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 12 do
                line(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({-150 + i * 26, -52}, 2),
                            __arrL({-140 + i * 24, -38}, 2)
                        },
                        2
                    ),
                    "#8d6a32",
                    1
                )
                i = i + 1
            end
        end
        c.globalAlpha = 1
        c:beginPath()
        c:ellipse(
            0,
            -56,
            156,
            30,
            0,
            0,
            math.pi * 2
        )
        c.lineWidth = 3
        c.strokeStyle = INK
        c:stroke()
        c:restore()
    end
    local function animeEye(self, c, x, y, side, o, t)
        local w = 25
        local ____o_open_3 = o.open
        if ____o_open_3 == nil then
            ____o_open_3 = 1
        end
        local open = ____o_open_3
        local h = 11 * open
        local lx = if __t(o.look) then o.look else 0 * 4
        local tr = if __t(o.tremble) then math.sin(t * 70) * 1 else 0
        local function shape()
            c:beginPath()
            c:moveTo(x - w, y + 2)
            c:bezierCurveTo(
                x - w * 0.55,
                y - h * 1.25,
                x + w * 0.45,
                y - h * 1.45,
                x + w,
                y - 3
            )
            c:bezierCurveTo(
                x + w * 0.45,
                y + h * 0.9,
                x - w * 0.45,
                y + h * 0.95,
                x - w,
                y + 2
            )
            c:closePath()
        end
        c:save()
        shape(nil)
        c.fillStyle = "#efe7dc"
        __call(c, "fill")
        c:save()
        c:clip()
        local ir = 10.5 * if __lt(o.pupil, 0.35) then 0.8 else 1
        local ix = x + lx + tr + side * 2
        local iy = y + 1
        local g = c:createRadialGradient(
            ix,
            iy - 3,
            1,
            ix,
            iy,
            ir
        )
        g:addColorStop(0, if __t(o.empty) then "#4a3428" else "#b07a42")
        g:addColorStop(0.7, if __t(o.empty) then "#2a1c16" else "#6a3c1c")
        g:addColorStop(1, "#1a0e08")
        c.fillStyle = g
        c:beginPath()
        c:arc(
            ix,
            iy,
            ir,
            0,
            math.pi * 2
        )
        __call(c, "fill")
        c.strokeStyle = "rgba(30,15,8,.45)"
        c.lineWidth = 0.8
        do
            local k = 0
            while k < 14 do
                local a = k / 14 * math.pi * 2
                c:beginPath()
                c:moveTo(
                    ix + math.cos(a) * 4,
                    iy + math.sin(a) * 4
                )
                c:lineTo(
                    ix + math.cos(a) * ir * 0.9,
                    iy + math.sin(a) * ir * 0.9
                )
                c:stroke()
                k = k + 1
            end
        end
        local ____circ_6 = circ
        local ____c_5 = c
        local ____o_pupil_4 = o.pupil
        if ____o_pupil_4 == nil then
            ____o_pupil_4 = 0.6
        end
        ____circ_6(
            nil,
            ____c_5,
            ix,
            iy,
            math.max(1.4, 5.5 * ____o_pupil_4),
            "#090505"
        )
        if not __t(o.empty) then
            circ(
                nil,
                c,
                ix - 4,
                iy - 5,
                2.8,
                "#ffffff"
            )
            circ(
                nil,
                c,
                ix + 4,
                iy + 3,
                1.3,
                "#ffffffbb"
            )
        end
        if __t(o.reflect) then
            c:save()
            c.globalCompositeOperation = "screen"
            c.globalAlpha = 0.5
            c.fillStyle = "#6a8cff"
            c:beginPath()
            c:roundRect(
                ix - 4,
                iy - 6,
                8,
                12,
                2
            )
            __call(c, "fill")
            c:restore()
        end
        local lid = c:createLinearGradient(0, y - h * 1.3, 0, y + 2)
        lid:addColorStop(0, "rgba(50,25,20,.6)")
        lid:addColorStop(1, "rgba(50,25,20,0)")
        c.fillStyle = lid
        c:fillRect(x - w, y - h * 1.4, w * 2, h * 1.4)
        c:restore()
        c:beginPath()
        c:moveTo(x - w - 1, y + 2)
        c:bezierCurveTo(
            x - w * 0.55,
            y - h * 1.3,
            x + w * 0.45,
            y - h * 1.5,
            x + w + 2,
            y - 3
        )
        c.lineWidth = 4.2
        c.strokeStyle = INK
        c.lineCap = "round"
        c:stroke()
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({x + side * w, y - 3}, 2),
                    __arrL({x + side * (w + 7), y - 8}, 2)
                },
                2
            ),
            INK,
            2.6
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({x + side * (w - 4), y - 1}, 2),
                    __arrL({x + side * (w + 3), y - 4}, 2)
                },
                2
            ),
            INK,
            1.6
        )
        c:beginPath()
        c:moveTo(x - w * 0.8, y - h * 1.25 - 5)
        c:quadraticCurveTo(x, y - h * 1.75 - 6, x + w * 0.85, y - h * 1.2 - 6)
        c.lineWidth = 1.5
        c.strokeStyle = "rgba(70,35,25,.75)"
        c:stroke()
        c:beginPath()
        c:moveTo(x - w * 0.6, y + h * 0.75)
        c:quadraticCurveTo(x, y + h * 1.05, x + w * 0.7, y + h * 0.55)
        c.lineWidth = 1
        c.strokeStyle = "rgba(74,42,34,.7)"
        c:stroke()
        c:beginPath()
        c:moveTo(x - w * 0.5, y + h + 6)
        c:quadraticCurveTo(x, y + h + 10, x + w * 0.55, y + h + 5)
        c.lineWidth = 1.2
        c.strokeStyle = "rgba(110,55,35,.55)"
        c:stroke()
        c:restore()
    end
    local function head(self, c, x, y, s, t, o)
        if o == nil then
            o = {}
        end
        c:save()
        c:translate(x, y)
        c:scale(s, s)
        c:rotate(if __t(o.tilt) then o.tilt else 0)
        fill(
            nil,
            c,
            __arrL(
                {
                    __arrL({-172, 270}, 2),
                    __arrL({-140, 160}, 2),
                    __arrL({-62, 122}, 2),
                    __arrL({62, 122}, 2),
                    __arrL({140, 160}, 2),
                    __arrL({172, 270}, 2)
                },
                6
            ),
            SHIRT
        )
        fill(
            nil,
            c,
            __arrL(
                {
                    __arrL({62, 122}, 2),
                    __arrL({140, 160}, 2),
                    __arrL({172, 270}, 2),
                    __arrL({80, 270}, 2)
                },
                4
            ),
            SHIRT_SH
        )
        fill(
            nil,
            c,
            __arrL(
                {
                    __arrL({-40, 128}, 2),
                    __arrL({0, 176}, 2),
                    __arrL({40, 128}, 2),
                    __arrL({26, 124}, 2),
                    __arrL({0, 150}, 2),
                    __arrL({-26, 124}, 2)
                },
                6
            ),
            "#b8612a"
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({-172, 270}, 2),
                    __arrL({-140, 160}, 2),
                    __arrL({-62, 122}, 2),
                    __arrL({62, 122}, 2),
                    __arrL({140, 160}, 2),
                    __arrL({172, 270}, 2)
                },
                6
            ),
            INK,
            4
        )
        fill(
            nil,
            c,
            __arrL(
                {
                    __arrL({-46, 60}, 2),
                    __arrL({46, 60}, 2),
                    __arrL({56, 126}, 2),
                    __arrL({0, 150}, 2),
                    __arrL({-56, 126}, 2)
                },
                5
            ),
            SKIN
        )
        fill(
            nil,
            c,
            __arrL(
                {
                    __arrL({10, 60}, 2),
                    __arrL({46, 60}, 2),
                    __arrL({56, 126}, 2),
                    __arrL({14, 140}, 2)
                },
                4
            ),
            SKIN_SH
        )
        fill(
            nil,
            c,
            __arrL(
                {
                    __arrL({-56, 126}, 2),
                    __arrL({-86, 132}, 2),
                    __arrL({-62, 122}, 2)
                },
                3
            ),
            SKIN_SH
        )
        fill(
            nil,
            c,
            __arrL(
                {
                    __arrL({56, 126}, 2),
                    __arrL({86, 132}, 2),
                    __arrL({62, 122}, 2)
                },
                3
            ),
            SKIN_SH
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({-46, 74}, 2),
                    __arrL({-56, 126}, 2)
                },
                2
            ),
            INK,
            3
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({46, 74}, 2),
                    __arrL({56, 126}, 2)
                },
                2
            ),
            INK,
            3
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({2, 110}, 2),
                    __arrL({6, 122}, 2)
                },
                2
            ),
            "rgba(90,45,30,.55)",
            2.2
        )
        local function facePath()
            c:beginPath()
            c:moveTo(-76, -64)
            c:lineTo(-80, 6)
            c:quadraticCurveTo(-80, 46, -66, 76)
            c:lineTo(-34, 108)
            c:quadraticCurveTo(0, 120, 34, 108)
            c:lineTo(66, 76)
            c:quadraticCurveTo(80, 46, 80, 6)
            c:lineTo(76, -64)
            c:closePath()
        end
        facePath(nil)
        c.fillStyle = SKIN
        __call(c, "fill")
        c:save()
        facePath(nil)
        c:clip()
        c:beginPath()
        c:moveTo(30, -80)
        c:quadraticCurveTo(50, 0, 40, 52)
        c:quadraticCurveTo(30, 96, 4, 124)
        c:lineTo(96, 124)
        c:lineTo(96, -80)
        c:closePath()
        c.fillStyle = SKIN_SH
        __call(c, "fill")
        local cb = c:createLinearGradient(0, 26, 0, 60)
        cb:addColorStop(0, "rgba(110,60,38,0)")
        cb:addColorStop(0.5, "rgba(110,60,38,.28)")
        cb:addColorStop(1, "rgba(110,60,38,0)")
        c.fillStyle = cb
        c:fillRect(-80, 26, 160, 34)
        c.globalAlpha = 0.35
        oval(
            nil,
            c,
            -46,
            14,
            16,
            8,
            SKIN_HI,
            -0.2
        )
        oval(
            nil,
            c,
            -6,
            -44,
            30,
            10,
            SKIN_HI
        )
        c.globalAlpha = 1
        local beard = c:createLinearGradient(0, 40, 0, 120)
        beard:addColorStop(0, "rgba(46,34,40,0)")
        beard:addColorStop(0.35, "rgba(46,34,40,.32)")
        beard:addColorStop(1, "rgba(46,34,40,.5)")
        c.fillStyle = beard
        c:beginPath()
        c:moveTo(-80, 40)
        c:quadraticCurveTo(-70, 70, -40, 70)
        c:quadraticCurveTo(-16, 56, 0, 60)
        c:quadraticCurveTo(16, 56, 40, 70)
        c:quadraticCurveTo(70, 70, 80, 40)
        c:lineTo(80, 124)
        c:lineTo(-80, 124)
        c:closePath()
        __call(c, "fill")
        c.fillStyle = "rgba(40,28,34,.35)"
        c:beginPath()
        c:moveTo(-22, 66)
        c:quadraticCurveTo(2, 58, 26, 66)
        c:quadraticCurveTo(2, 72, -22, 66)
        __call(c, "fill")
        c.fillStyle = "rgba(28,14,18,.5)"
        c:fillRect(-90, -90, 180, if __t(o.empty) then 82 else 30)
        if __t(o.empty) then
            local gg = c:createLinearGradient(0, -8, 0, 26)
            gg:addColorStop(0, "rgba(20,10,20,.55)")
            gg:addColorStop(1, "rgba(20,10,20,0)")
            c.fillStyle = gg
            c:fillRect(-90, -8, 180, 34)
        end
        c:restore()
        facePath(nil)
        c.lineWidth = 4.5
        c.strokeStyle = INK
        c:stroke()
        oval(
            nil,
            c,
            -82,
            4,
            11,
            22,
            SKIN_SH
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({-76, -16}, 2),
                    __arrL({-94, -6}, 2),
                    __arrL({-92, 22}, 2),
                    __arrL({-76, 30}, 2)
                },
                4
            ),
            INK,
            3
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({-86, -2}, 2),
                    __arrL({-88, 12}, 2),
                    __arrL({-82, 20}, 2)
                },
                3
            ),
            "#6a3b28",
            1.6
        )
        oval(
            nil,
            c,
            82,
            4,
            10,
            21,
            "#7e4a30"
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({76, -16}, 2),
                    __arrL({93, -6}, 2),
                    __arrL({91, 22}, 2),
                    __arrL({76, 30}, 2)
                },
                4
            ),
            INK,
            3
        )
        fill(
            nil,
            c,
            __arrL(
                {
                    __arrL({-78, -66}, 2),
                    __arrL({-64, -66}, 2),
                    __arrL({-70, 0}, 2),
                    __arrL({-80, -6}, 2)
                },
                4
            ),
            "#1a1216"
        )
        fill(
            nil,
            c,
            __arrL(
                {
                    __arrL({78, -66}, 2),
                    __arrL({64, -66}, 2),
                    __arrL({70, 0}, 2),
                    __arrL({80, -6}, 2)
                },
                4
            ),
            "#1a1216"
        )
        fill(
            nil,
            c,
            __arrL(
                {
                    __arrL({-66, -68}, 2),
                    __arrL({-50, -40}, 2),
                    __arrL({-38, -66}, 2),
                    __arrL({-20, -42}, 2),
                    __arrL({-6, -68}, 2),
                    __arrL({14, -44}, 2),
                    __arrL({26, -68}, 2),
                    __arrL({44, -42}, 2),
                    __arrL({56, -68}, 2)
                },
                9
            ),
            "#1a1216"
        )
        local bw = if o.mouth == "gasp" then -7 else if __t(o.empty) then 3 else 2
        fill(
            nil,
            c,
            __arrL(
                {
                    __arrL({-66, -24 + bw * 0.3}, 2),
                    __arrL({-40, -32 - bw}, 2),
                    __arrL({-12, -28}, 2),
                    __arrL({-12, -20}, 2),
                    __arrL({-40, -24 - bw}, 2),
                    __arrL({-64, -16}, 2)
                },
                6
            ),
            INK
        )
        fill(
            nil,
            c,
            __arrL(
                {
                    __arrL({12, -28}, 2),
                    __arrL({40, -33 - bw}, 2),
                    __arrL({66, -25 + bw * 0.3}, 2),
                    __arrL({64, -17}, 2),
                    __arrL({40, -25 - bw}, 2),
                    __arrL({12, -20}, 2)
                },
                6
            ),
            INK
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({-4, -26}, 2),
                    __arrL({-2, -16}, 2)
                },
                2
            ),
            "rgba(90,45,30,.55)",
            1.8
        )
        local ____animeEye_12 = animeEye
        local ____array_11 = __TS__SparseArrayNew(
            nil,
            c,
            -36,
            -6,
            -1
        )
        local ____assign_10 = __assign
        local ____temp_8 = {}
        local ____o_9 = o
        local ____o_open_7 = o.open
        if ____o_open_7 == nil then
            ____o_open_7 = 1
        end
        __TS__SparseArrayPush(
            ____array_11,
            ____assign_10(____temp_8, ____o_9, {open = ____o_open_7 * 0.8}),
            t
        )
        ____animeEye_12(__TS__SparseArraySpread(____array_11))
        local ____animeEye_19 = animeEye
        local ____c_17 = c
        local ____temp_18 = -7
        local ____assign_16 = __assign
        local ____temp_14 = {}
        local ____o_15 = o
        local ____o_open_13 = o.open
        if ____o_open_13 == nil then
            ____o_open_13 = 1
        end
        ____animeEye_19(
            nil,
            ____c_17,
            36,
            ____temp_18,
            1,
            ____assign_16(____temp_14, ____o_15, {open = ____o_open_13 * 0.8}),
            t
        )
        fill(
            nil,
            c,
            __arrL(
                {
                    __arrL({4, -12}, 2),
                    __arrL({18, 36}, 2),
                    __arrL({6, 44}, 2),
                    __arrL({0, 40}, 2)
                },
                4
            ),
            "rgba(120,64,40,.45)"
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({2, -12}, 2),
                    __arrL({8, 30}, 2),
                    __arrL({16, 40}, 2)
                },
                3
            ),
            "#6a3826",
            2.6
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({-10, 44}, 2),
                    __arrL({4, 50}, 2),
                    __arrL({20, 44}, 2)
                },
                3
            ),
            "#4a2418",
            2.6
        )
        circ(
            nil,
            c,
            -5,
            44,
            2.6,
            "#4a2418"
        )
        circ(
            nil,
            c,
            14,
            43,
            2.6,
            "#4a2418"
        )
        circ(
            nil,
            c,
            4,
            36,
            2.4,
            "#f0c08e"
        )
        local tr = if __t(o.tremble) then math.sin(t * 40) * 1.2 else 0
        if o.mouth == "gasp" then
            oval(
                nil,
                c,
                3,
                84 + tr,
                13,
                9 + tr,
                "#2a0e10"
            )
            oval(
                nil,
                c,
                3,
                89 + tr,
                8,
                3,
                "#8a3a3a"
            )
            line(
                nil,
                c,
                __arrL(
                    {
                        __arrL({-12, 80}, 2),
                        __arrL({18, 80}, 2)
                    },
                    2
                ),
                INK,
                2.4
            )
        elseif o.mouth == "open" then
            oval(
                nil,
                c,
                3,
                82,
                10,
                5,
                "#2a0e10"
            )
        else
            line(
                nil,
                c,
                __arrL(
                    {
                        __arrL({-20, 82}, 2),
                        __arrL({3, 81}, 2),
                        __arrL({26, 83}, 2)
                    },
                    3
                ),
                "#3a160f",
                3.4
            )
            line(
                nil,
                c,
                __arrL(
                    {
                        __arrL({-10, 90}, 2),
                        __arrL({14, 90}, 2)
                    },
                    2
                ),
                "rgba(90,45,30,.55)",
                2
            )
        end
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({-16, 50}, 2),
                    __arrL({-24, 70}, 2)
                },
                2
            ),
            "rgba(100,55,35,.45)",
            1.8
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({24, 48}, 2),
                    __arrL({30, 68}, 2)
                },
                2
            ),
            "rgba(80,40,28,.5)",
            1.8
        )
        if __t(o.sweat) then
            do
                local k = 0
                while k < 3 do
                    local p = __mod(t * 0.5 + k * 0.33, 1)
                    local sx = __get(
                        __arrL({58, -64, 48}, 3),
                        k
                    )
                    local sy = -24 + p * 70
                    fill(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({sx, sy - 8}, 2),
                                __arrL({sx - 4, sy + 2}, 2),
                                __arrL({sx, sy + 6}, 2),
                                __arrL({sx + 4, sy + 2}, 2)
                            },
                            4
                        ),
                        "#d8ecf6"
                    )
                    line(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({sx, sy - 8}, 2),
                                __arrL({sx - 4, sy + 2}, 2),
                                __arrL({sx, sy + 6}, 2),
                                __arrL({sx + 4, sy + 2}, 2),
                                __arrL({sx, sy - 8}, 2)
                            },
                            5
                        ),
                        "#5a7a9a",
                        1.2
                    )
                    k = k + 1
                end
            end
        end
        c:save()
        c:translate(0, -36)
        c:scale(1.04, 1)
        hat(
            nil,
            c,
            s,
            t,
            -0.03
        )
        c:restore()
        c:restore()
    end
    local function handBack(self, c)
        fill(
            nil,
            c,
            __arrL(
                {
                    __arrL({-120, 360}, 2),
                    __arrL({-110, 190}, 2),
                    __arrL({-70, 120}, 2),
                    __arrL({60, 110}, 2),
                    __arrL({118, 150}, 2),
                    __arrL({120, 360}, 2)
                },
                6
            ),
            SHIRT_SH
        )
        fill(
            nil,
            c,
            __arrL(
                {
                    __arrL({-104, 230}, 2),
                    __arrL({-96, 120}, 2),
                    __arrL({-40, 96}, 2),
                    __arrL({70, 92}, 2),
                    __arrL({112, 120}, 2),
                    __arrL({104, 236}, 2)
                },
                6
            ),
            SKIN_SH
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({-104, 230}, 2),
                    __arrL({-96, 120}, 2),
                    __arrL({-40, 96}, 2),
                    __arrL({70, 92}, 2),
                    __arrL({112, 120}, 2),
                    __arrL({104, 236}, 2)
                },
                6
            ),
            INK,
            4
        )
        fill(
            nil,
            c,
            __arrL(
                {
                    __arrL({-130, 360}, 2),
                    __arrL({-118, 260}, 2),
                    __arrL({118, 260}, 2),
                    __arrL({130, 360}, 2)
                },
                4
            ),
            SHIRT
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({-118, 260}, 2),
                    __arrL({118, 260}, 2)
                },
                2
            ),
            INK,
            4
        )
    end
    local function handFront(self, c)
        c:beginPath()
        c:moveTo(-120, 150)
        c:bezierCurveTo(
            -130,
            90,
            -112,
            40,
            -84,
            22
        )
        c:bezierCurveTo(
            -66,
            12,
            -58,
            30,
            -68,
            46
        )
        c:bezierCurveTo(
            -80,
            66,
            -88,
            100,
            -84,
            150
        )
        c:closePath()
        c.fillStyle = SKIN
        __call(c, "fill")
        c.lineWidth = 4
        c.strokeStyle = INK
        c:stroke()
        c:beginPath()
        c:moveTo(-82, 30)
        c:quadraticCurveTo(-70, 22, -68, 36)
        c:quadraticCurveTo(-76, 44, -82, 30)
        c.fillStyle = "#f2c7a6"
        __call(c, "fill")
        c.lineWidth = 1.5
        c:stroke()
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({-104, 98}, 2),
                    __arrL({-92, 92}, 2)
                },
                2
            ),
            "#7a4630",
            2
        )
        c:beginPath()
        c:moveTo(98, -44)
        c:bezierCurveTo(
            126,
            -46,
            142,
            -20,
            142,
            40
        )
        c:bezierCurveTo(
            142,
            120,
            132,
            176,
            104,
            200
        )
        c:lineTo(92, 170)
        c:closePath()
        c.fillStyle = SKIN_SH
        __call(c, "fill")
        c.lineWidth = 4
        c.strokeStyle = INK
        c:stroke()
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({128, -24}, 2),
                    __arrL({134, 150}, 2)
                },
                2
            ),
            "rgba(80,40,25,.55)",
            2
        )
        do
            local k = 0
            while k < 4 do
                local y = -18 + k * 44
                local len = if k == 3 then 30 else 40
                c:beginPath()
                c:moveTo(132, y - 16)
                c:bezierCurveTo(
                    108,
                    y - 20,
                    96 - len * 0.6,
                    y - 18,
                    96 - len,
                    y - 6
                )
                c:bezierCurveTo(
                    96 - len - 4,
                    y + 6,
                    96 - len + 4,
                    y + 14,
                    100 - len * 0.5,
                    y + 14
                )
                c:lineTo(132, y + 16)
                c:closePath()
                c.fillStyle = if __t(__mod(k, 2)) then SKIN else SKIN_HI
                __call(c, "fill")
                c.lineWidth = 3.6
                c.strokeStyle = INK
                c:stroke()
                c:beginPath()
                c:moveTo(96 - len + 6, y - 6)
                c:quadraticCurveTo(96 - len + 2, y + 4, 96 - len + 10, y + 8)
                c:quadraticCurveTo(96 - len + 14, y, 96 - len + 6, y - 6)
                c.fillStyle = "#f4cdb0"
                __call(c, "fill")
                c.lineWidth = 1.4
                c:stroke()
                line(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({108 - len * 0.2, y - 12}, 2),
                            __arrL({108 - len * 0.2, y + 10}, 2)
                        },
                        2
                    ),
                    "rgba(110,60,40,.7)",
                    1.6
                )
                k = k + 1
            end
        end
    end
    local SHOTS = window.JorgeEpilogue.shots
    local function afterglow(self, c, t, p)
        vgrad(
            nil,
            c,
            __arrL(
                {
                    __arrL({0, "#0b0f2a"}, 2),
                    __arrL({0.55, "#2a1f4a"}, 2),
                    __arrL({0.8, "#6b3a4a"}, 2),
                    __arrL({1, "#d98a4a"}, 2)
                },
                4
            ),
            0,
            380
        )
        stars(
            nil,
            c,
            t,
            120,
            300
        )
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({0.3, 220, 120, "#ffd979"}, 4),
                __arrL({1.6, 720, 90, "#ff8ab0"}, 4),
                __arrL({3.1, 470, 140, "#9fe0ff"}, 4)
            },
            3
        ))) do
            local ft = ____value[1]
            local fx = ____value[2]
            local fy = ____value[3]
            local col = ____value[4]
            local k = clamp(nil, (t - ft) / 2.4)
            if __t(k <= 0 or k >= 1) then
                continue
            end
            c:save()
            c.globalAlpha = (1 - k) * 0.9
            do
                local i = 0
                while i < 26 do
                    local a = i / 26 * math.pi * 2
                    local r = ease(nil, k) * 70
                    circ(
                        nil,
                        c,
                        fx + math.cos(a) * r,
                        fy + math.sin(a) * r + k * k * 30,
                        2,
                        col
                    )
                    i = i + 1
                end
            end
            c:restore()
        end
        c.fillStyle = "#120f22"
        path(
            nil,
            c,
            __arrL(
                {
                    __arrL({0, 380}, 2),
                    __arrL({0, 330}, 2),
                    __arrL({140, 300}, 2),
                    __arrL({300, 320}, 2),
                    __arrL({460, 290}, 2),
                    __arrL({640, 315}, 2),
                    __arrL({800, 295}, 2),
                    __arrL({960, 320}, 2),
                    __arrL({960, 380}, 2)
                },
                9
            )
        )
        __call(c, "fill")
        do
            local i = 0
            while i < 40 do
                c.fillStyle = if rnd(nil, i) > 0.5 then "#ffd27a" else "#ffb35a"
                c.globalAlpha = 0.5 + 0.5 * math.sin(t * 2 + i)
                c:fillRect(
                    rnd(nil, i * 3) * W,
                    320 + rnd(nil, i * 5) * 50,
                    2,
                    2
                )
                i = i + 1
            end
        end
        c.globalAlpha = 1
        vgrad(
            nil,
            c,
            __arrL(
                {
                    __arrL({0, "#1b1426"}, 2),
                    __arrL({1, "#07050c"}, 2)
                },
                2
            ),
            380,
            H
        )
        do
            local i = 0
            while i < 60 do
                c.fillStyle = __get(
                    __arrL({"#ff6b8a", "#ffd979", "#7ad3ff", "#9eea7a"}, 4),
                    __mod(i, 4)
                )
                c.globalAlpha = 0.55
                c:save()
                c:translate(
                    rnd(nil, i) * W,
                    400 + rnd(nil, i * 3) * 130
                )
                c:rotate(rnd(nil, i * 7) * 6)
                c:fillRect(-3, -1.5, 6, 3)
                c:restore()
                i = i + 1
            end
        end
        c.globalAlpha = 1
        local x = lerp(
            nil,
            520,
            470,
            smooth(nil, p)
        )
        local y = 470
        c:save()
        c:translate(x, y)
        c:scale(1.1, 1.1)
        fill(
            nil,
            c,
            __arrL(
                {
                    __arrL({-70, 0}, 2),
                    __arrL({-60, -120}, 2),
                    __arrL({-30, -150}, 2),
                    __arrL({30, -150}, 2),
                    __arrL({60, -120}, 2),
                    __arrL({70, 0}, 2)
                },
                6
            ),
            "#2a1a14"
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({-60, -120}, 2),
                    __arrL({-30, -150}, 2),
                    __arrL({30, -150}, 2),
                    __arrL({60, -120}, 2)
                },
                4
            ),
            "#ffb35a",
            3
        )
        fill(
            nil,
            c,
            __arrL(
                {
                    __arrL({-60, -120}, 2),
                    __arrL({-80, -60}, 2),
                    __arrL({-70, 0}, 2),
                    __arrL({-60, 0}, 2)
                },
                4
            ),
            "#3a2418"
        )
        oval(
            nil,
            c,
            0,
            -170,
            34,
            30,
            "#1d1418"
        )
        oval(
            nil,
            c,
            0,
            -196,
            92,
            18,
            "#3a2c18"
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({-92, -196}, 2),
                    __arrL({-40, -212}, 2),
                    __arrL({40, -212}, 2),
                    __arrL({92, -196}, 2)
                },
                4
            ),
            "#ffcf7a",
            2
        )
        fill(
            nil,
            c,
            __arrL(
                {
                    __arrL({-42, -200}, 2),
                    __arrL({-34, -240}, 2),
                    __arrL({34, -240}, 2),
                    __arrL({42, -200}, 2)
                },
                4
            ),
            "#4a3820"
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({-34, -240}, 2),
                    __arrL({34, -240}, 2)
                },
                2
            ),
            "#ffcf7a",
            2
        )
        c:restore()
        glow(
            nil,
            c,
            480,
            380,
            380,
            "rgba(255,150,90,A)",
            0.18
        )
        tracked(
            nil,
            c,
            "DEPOIS DO ÚLTIMO PEDAÇO",
            W / 2,
            60,
            10,
            "#c9b2d8",
            5
        )
        subtitle(
            nil,
            c,
            "Da Roça",
            "Pera… acabou?",
            smooth(nil, (t - 1.1) / 1)
        )
    end
    local function empty(self, c, t, p)
        vgrad(
            nil,
            c,
            __arrL(
                {
                    __arrL({0, "#0a0d24"}, 2),
                    __arrL({1, "#1a1030"}, 2)
                },
                2
            )
        )
        stars(
            nil,
            c,
            t,
            60,
            300
        )
        circ(
            nil,
            c,
            720,
            150,
            70,
            "#e8e6f6"
        )
        circ(
            nil,
            c,
            742,
            140,
            66,
            "#0f0f28"
        )
        glow(
            nil,
            c,
            700,
            160,
            220,
            "rgba(180,190,255,A)",
            0.2
        )
        do
            local i = 0
            while i < 24 do
                local k = __mod(
                    t * 0.12 + rnd(nil, i),
                    1
                )
                c:save()
                c:translate(
                    W + 40 - k * (W + 120),
                    60 + rnd(nil, i * 3) * 380 + math.sin(t * 2 + i) * 14
                )
                c:rotate(t * 2 + i)
                c.fillStyle = if __t(__mod(i, 3)) then "#f2e6d0" else "#ffd0d8"
                c.globalAlpha = 0.7
                c:fillRect(-5, -3, 10, 6)
                c:restore()
                i = i + 1
            end
        end
        head(
            nil,
            c,
            470,
            300 + math.sin(t * 0.8) * 3,
            lerp(
                nil,
                1.25,
                1.42,
                ease(nil, p)
            ),
            t,
            {
                empty = true,
                open = 0.8,
                pupil = 0.5,
                look = -0.4,
                tilt = -0.04
            }
        )
        c:save()
        c.globalCompositeOperation = "screen"
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({620, 200}, 2),
                    __arrL({640, 300}, 2),
                    __arrL({610, 420}, 2)
                },
                3
            ),
            "rgba(170,190,255,.5)",
            4
        )
        c:restore()
        subtitle(
            nil,
            c,
            "Da Roça",
            "Pq eu ainda me sinto vazio?",
            smooth(nil, (t - 0.5) / 1.2)
        )
    end
    local function vibration(self, c, t, p)
        local buzz = if math.abs(math.sin(t * 22)) > 0.4 then 1 else 0
        c:save()
        shake(nil, c, buzz * 2.5, t)
        vgrad(
            nil,
            c,
            __arrL(
                {
                    __arrL({0, "#1c2a52"}, 2),
                    __arrL({1, "#0e1530"}, 2)
                },
                2
            )
        )
        do
            local y = 0
            while y < H do
                c.fillStyle = if __t(__mod(y, 12)) then "#22325e" else "#1a2850"
                c:fillRect(0, y, W, 3)
                y = y + 6
            end
        end
        c:save()
        c.globalAlpha = 0.25
        do
            local x = 0
            while x < W do
                c.fillStyle = "#3a4c80"
                c:fillRect(x, 0, 1, H)
                x = x + 5
            end
        end
        c:restore()
        fill(
            nil,
            c,
            __arrL(
                {
                    __arrL({250, 120}, 2),
                    __arrL({720, 100}, 2),
                    __arrL({740, 470}, 2),
                    __arrL({230, 480}, 2)
                },
                4
            ),
            "#203060"
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({250, 120}, 2),
                    __arrL({720, 100}, 2),
                    __arrL({740, 470}, 2),
                    __arrL({230, 480}, 2),
                    __arrL({250, 120}, 2)
                },
                5
            ),
            "#d8a05a",
            3
        )
        do
            local i = 0
            while i < 26 do
                c.fillStyle = "#d8a05a"
                c:fillRect(260 + i * 18, 132 - i * 0.8, 8, 2)
                i = i + 1
            end
        end
        local lightA = 0.25 + 0.4 * buzz
        glow(
            nil,
            c,
            480,
            300,
            220,
            "rgba(140,180,255,A)",
            lightA
        )
        c:save()
        c.globalCompositeOperation = "screen"
        c.globalAlpha = 0.35 + 0.35 * buzz
        c.fillStyle = "#7fa6ff"
        c:beginPath()
        c:roundRect(
            418,
            196,
            124,
            220,
            18
        )
        __call(c, "fill")
        c.globalAlpha = 0.5
        c.fillStyle = "#cfe0ff"
        c:fillRect(452, 214, 56, 8)
        c:restore()
        c:save()
        c.globalAlpha = 0.45
        c.strokeStyle = "#0c1430"
        c.lineWidth = 2
        do
            local i = 0
            while i < 6 do
                c:beginPath()
                c:moveTo(420, 230 + i * 34)
                c:quadraticCurveTo(
                    480,
                    222 + i * 34 + math.sin(t * 30) * 2,
                    540,
                    232 + i * 34
                )
                c:stroke()
                i = i + 1
            end
        end
        c:restore()
        c:restore()
        for ____, side in __iterar((__arrL({-1, 1}, 2))) do
            do
                local i = 0
                while i < 3 do
                    local xx = 480 + side * (140 + i * 26 + buzz * 6)
                    line(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({xx, 230 + i * 10}, 2),
                                __arrL({xx + side * 14, 270}, 2),
                                __arrL({xx, 310}, 2),
                                __arrL({xx + side * 14, 350}, 2)
                            },
                            4
                        ),
                        "#ffffff",
                        3
                    )
                    i = i + 1
                end
            end
        end
        c:save()
        c:translate(480, 470)
        c:rotate(-0.06)
        c.font = "italic 900 64px Space,Arial,sans-serif"
        c.textAlign = "center"
        c.lineWidth = 8
        c.strokeStyle = INK
        c:strokeText("VRRR…", 0, 0)
        c.fillStyle = "#ffe36b"
        c:fillText("VRRR…", buzz * 3, 0)
        c:restore()
    end
    local function phoneBody(self, c, x, y, s, rot, t, o)
        if o == nil then
            o = {}
        end
        c:save()
        c:translate(x, y)
        c:rotate(rot)
        c:scale(s, s)
        glow(
            nil,
            c,
            0,
            0,
            260,
            "rgba(120,160,255,A)",
            0.35
        )
        if __t(o.held) then
            handBack(nil, c)
        end
        fill(
            nil,
            c,
            __arrL(
                {
                    __arrL({-92, -176}, 2),
                    __arrL({92, -176}, 2),
                    __arrL({92, 176}, 2),
                    __arrL({-92, 176}, 2)
                },
                4
            ),
            "#0e0f16"
        )
        c:beginPath()
        c:roundRect(
            -96,
            -180,
            192,
            360,
            22
        )
        c.lineWidth = 6
        c.strokeStyle = "#3a3e4c"
        c:stroke()
        local g = c:createLinearGradient(0, -160, 0, 160)
        g:addColorStop(0, "#2b3c74")
        g:addColorStop(1, "#141c38")
        c.fillStyle = g
        c:beginPath()
        c:roundRect(
            -84,
            -166,
            168,
            332,
            14
        )
        __call(c, "fill")
        c.fillStyle = "#0e0f16"
        c:beginPath()
        c:roundRect(
            -28,
            -160,
            56,
            12,
            6
        )
        __call(c, "fill")
        c.textAlign = "center"
        c.fillStyle = "#c8d4ff"
        c.font = "600 11px Space,Arial,sans-serif"
        c:fillText("CHAMADA RECEBIDA", 0, -118)
        c.fillStyle = "#ffffff"
        c.font = "800 38px Space,Arial,sans-serif"
        c:fillText(if __t(o.name) then o.name else "JORGE", 0, -76)
        circ(
            nil,
            c,
            0,
            0,
            34,
            "#3a4a80"
        )
        circ(
            nil,
            c,
            0,
            -8,
            12,
            "#c8d4ff"
        )
        oval(
            nil,
            c,
            0,
            20,
            20,
            12,
            "#c8d4ff"
        )
        local pulse = __mod(t * 1.6, 1)
        c:save()
        c.globalAlpha = 1 - pulse
        c.strokeStyle = "#9fc3ff"
        c.lineWidth = 2
        c:beginPath()
        c:arc(
            0,
            0,
            34 + pulse * 30,
            0,
            math.pi * 2
        )
        c:stroke()
        c:restore()
        circ(
            nil,
            c,
            -44,
            110,
            20,
            "#d8434a"
        )
        circ(
            nil,
            c,
            44,
            110,
            20,
            "#3fb07a"
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({-52, 114}, 2),
                    __arrL({-44, 106}, 2),
                    __arrL({-36, 114}, 2)
                },
                3
            ),
            "#fff",
            3
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({36, 106}, 2),
                    __arrL({44, 114}, 2),
                    __arrL({52, 106}, 2)
                },
                3
            ),
            "#fff",
            3
        )
        c:save()
        c.globalAlpha = 0.12
        fill(
            nil,
            c,
            __arrL(
                {
                    __arrL({-84, -60}, 2),
                    __arrL({84, -150}, 2),
                    __arrL({84, -110}, 2),
                    __arrL({-84, -20}, 2)
                },
                4
            ),
            "#ffffff"
        )
        c:restore()
        if __t(o.held) then
            handFront(nil, c)
        end
        if __t(o.crack) then
            c:save()
            c.globalAlpha = o.crack
            c.strokeStyle = "#e8f0ff"
            c.lineWidth = 1.6
            do
                local i = 0
                while i < 9 do
                    local a = i / 9 * math.pi * 2 + 0.3
                    c:beginPath()
                    c:moveTo(20, 40)
                    local px = 20
                    local py = 40
                    do
                        local k = 0
                        while k < 4 do
                            px = px + math.cos(a + (rnd(nil, i * 4 + k) - 0.5)) * 26
                            py = py + math.sin(a + (rnd(nil, i * 5 + k) - 0.5)) * 26
                            c:lineTo(px, py)
                            k = k + 1
                        end
                    end
                    c:stroke()
                    i = i + 1
                end
            end
            c:restore()
        end
        c:restore()
    end
    local function hand(self, c, x, y, s, rot)
    end
    local function reach(self, c, t, p)
        vgrad(
            nil,
            c,
            __arrL(
                {
                    __arrL({0, "#090b18"}, 2),
                    __arrL({1, "#121630"}, 2)
                },
                2
            )
        )
        bokeh(
            nil,
            c,
            t,
            18,
            "#6a8cff",
            3
        )
        local k = ease(nil, p * 1.15)
        local y = lerp(nil, 640, 260, k)
        c:save()
        c:translate(480, 270)
        c:rotate(-0.08)
        c:translate(-480, -270)
        phoneBody(
            nil,
            c,
            500,
            y,
            0.9,
            lerp(nil, 0.25, -0.06, k),
            t,
            {held = true}
        )
        c:restore()
        do
            local i = 0
            while i < 30 do
                local k2 = __mod(
                    t * 0.2 + rnd(nil, i),
                    1
                )
                c.globalAlpha = 0.5 * (1 - k2)
                c.fillStyle = "#bcd0ff"
                c:fillRect(
                    rnd(nil, i * 3) * W,
                    H - k2 * H,
                    2,
                    2
                )
                i = i + 1
            end
        end
        c.globalAlpha = 1
    end
    local function caller(self, c, t, p)
        vgrad(
            nil,
            c,
            __arrL(
                {
                    __arrL({0, "#06070f"}, 2),
                    __arrL({1, "#0c1020"}, 2)
                },
                2
            )
        )
        do
            local i = 0
            while i < 4 do
                local k = __mod(t * 0.6 + i / 4, 1)
                c:save()
                c.globalAlpha = (1 - k) * 0.4
                c.strokeStyle = "#8fb0ff"
                c.lineWidth = 3
                c:beginPath()
                c:ellipse(
                    480,
                    270,
                    140 + k * 360,
                    190 + k * 300,
                    0,
                    0,
                    math.pi * 2
                )
                c:stroke()
                c:restore()
                i = i + 1
            end
        end
        local z = lerp(
            nil,
            1.05,
            1.35,
            smooth(nil, (p - 0.65) / 0.35)
        )
        c:save()
        c:translate(480, 270)
        c:scale(z, z)
        c:translate(-480, -270)
        phoneBody(
            nil,
            c,
            480,
            280,
            1.15,
            0,
            t
        )
        c:save()
        c.globalAlpha = 0.1
        c:translate(500, 250)
        oval(
            nil,
            c,
            0,
            -40,
            60,
            12,
            "#ffffff"
        )
        fill(
            nil,
            c,
            __arrL(
                {
                    __arrL({-30, -44}, 2),
                    __arrL({-24, -80}, 2),
                    __arrL({24, -80}, 2),
                    __arrL({30, -44}, 2)
                },
                4
            ),
            "#ffffff"
        )
        oval(
            nil,
            c,
            0,
            0,
            34,
            44,
            "#ffffff"
        )
        c:restore()
        c:restore()
    end
    local function recognition(self, c, t, p)
        local impact = if __lt(t, 0.5) then clamp(nil, (t - 0.28) / 0.06) * (1 - clamp(nil, (t - 0.36) / 0.12)) else 0
        local shrink = smooth(nil, (t - 0.3) / 0.25)
        vgrad(
            nil,
            c,
            __arrL(
                {
                    __arrL({0, "#2a0610"}, 2),
                    __arrL({1, "#05020a"}, 2)
                },
                2
            )
        )
        speedLines(
            nil,
            c,
            480,
            270,
            140,
            200,
            "#ff5a6a",
            0.35 + 0.3 * shrink,
            t,
            4
        )
        c:save()
        if __gt(t, 0.3) then
            shake(
                nil,
                c,
                3 * (1 - clamp(nil, (t - 0.3) / 2)),
                t
            )
        end
        local bandTop = 120
        local bandH = 300
        c:save()
        c:beginPath()
        c:rect(0, bandTop, W, bandH)
        c:clip()
        c:translate(480, 270)
        c:scale(4.4, 4.4)
        local sk = c:createLinearGradient(-110, 0, 110, 0)
        sk:addColorStop(0, "#b97a50")
        sk:addColorStop(0.55, SKIN)
        sk:addColorStop(1, SKIN_SH)
        c.fillStyle = sk
        c:fillRect(-120, -40, 240, 80)
        fill(
            nil,
            c,
            __arrL(
                {
                    __arrL({62, -40}, 2),
                    __arrL({90, -40}, 2),
                    __arrL({80, 40}, 2),
                    __arrL({54, 40}, 2)
                },
                4
            ),
            "#8a5032"
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({58, -30}, 2),
                    __arrL({66, 34}, 2)
                },
                2
            ),
            "#6a3a24",
            1.4
        )
        fill(
            nil,
            c,
            __arrL(
                {
                    __arrL({-70, -30}, 2),
                    __arrL({-24, -40}, 2),
                    __arrL({30, -36}, 2),
                    __arrL({30, -31}, 2),
                    __arrL({-24, -34}, 2),
                    __arrL({-68, -24}, 2)
                },
                6
            ),
            INK
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({40, -34}, 2),
                    __arrL({44, -24}, 2)
                },
                2
            ),
            "rgba(90,45,30,.75)",
            1.2
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({48, -35}, 2),
                    __arrL({50, -25}, 2)
                },
                2
            ),
            "rgba(90,45,30,.75)",
            1.2
        )
        animeEye(
            nil,
            c,
            0,
            0,
            1,
            {
                open = 1.35,
                pupil = lerp(nil, 0.85, 0.18, shrink),
                look = 0,
                reflect = shrink > 0.5,
                tremble = shrink > 0.5
            },
            t
        )
        if shrink > 0.5 then
            c.fillStyle = "#cfe0ff"
            c.font = "800 2.6px Space,Arial,sans-serif"
            c.textAlign = "center"
            c.globalAlpha = 0.8
            c:fillText("JORGE", 2, 2)
            c.globalAlpha = 1
        end
        do
            local k = 0
            while k < 5 do
                fill(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({-120 + k * 10, -40}, 2),
                            __arrL({-112 + k * 10, -40}, 2),
                            __arrL(
                                {
                                    -100 + k * 11,
                                    -22 - __mod(k, 2) * 6
                                },
                                2
                            )
                        },
                        3
                    ),
                    "#1a1216"
                )
                k = k + 1
            end
        end
        local brim = c:createLinearGradient(0, -40, 0, -18)
        brim:addColorStop(0, "rgba(15,8,10,.7)")
        brim:addColorStop(1, "rgba(15,8,10,0)")
        c.fillStyle = brim
        c:fillRect(-120, -40, 240, 22)
        do
            local k = 0
            while k < 2 do
                local sx = 40 + k * 7
                local sy = -14 + __mod(t * 9 + k * 9, 24)
                fill(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({sx, sy - 5}, 2),
                            __arrL({sx - 3, sy + 1}, 2),
                            __arrL({sx, sy + 4}, 2),
                            __arrL({sx + 3, sy + 1}, 2)
                        },
                        4
                    ),
                    "#d8ecf6"
                )
                k = k + 1
            end
        end
        c:restore()
        c:restore()
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({0, bandTop}, 2),
                    __arrL({W, bandTop}, 2)
                },
                2
            ),
            "#000",
            3
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({0, bandTop + bandH}, 2),
                    __arrL({W, bandTop + bandH}, 2)
                },
                2
            ),
            "#000",
            3
        )
        if impact > 0 then
            c:save()
            c.globalAlpha = impact
            c.fillStyle = "#ffffff"
            c:fillRect(0, 0, W, H)
            c:restore()
        end
        subtitle(
            nil,
            c,
            "Da Roça",
            "JORGE…",
            smooth(nil, (t - 0.7) / 0.5)
        )
    end
    local function tremor(self, c, t, p)
        local beat = math.max(
            0,
            math.sin(t * 7.5)
        ) ^ 6
        vgrad(
            nil,
            c,
            __arrL(
                {
                    __arrL({0, "#14081a"}, 2),
                    __arrL({1, "#05030a"}, 2)
                },
                2
            )
        )
        c:save()
        c.globalAlpha = 0.18
        c.strokeStyle = "#6a3a8a"
        c.lineWidth = 1
        do
            local i = -20
            while i < 40 do
                c:beginPath()
                c:moveTo(
                    i * 30 + math.sin(t * 3 + i) * 6,
                    0
                )
                c:lineTo(i * 30 - 300, H)
                c:stroke()
                i = i + 1
            end
        end
        c:restore()
        c:save()
        shake(nil, c, 1.6 + beat * 2, t)
        head(
            nil,
            c,
            430,
            280,
            1.15,
            t,
            {
                open = 1.25,
                pupil = 0.16,
                sweat = true,
                mouth = "gasp",
                tremble = true,
                look = 0.2
            }
        )
        c:restore()
        c:save()
        local hx = 760 + math.sin(t * 55) * 4
        local hy = 470 + math.cos(t * 49) * 3
        phoneBody(
            nil,
            c,
            hx,
            hy - 110,
            0.5,
            -0.3 + math.sin(t * 40) * 0.03,
            t,
            {held = true}
        )
        c:restore()
        c:save()
        c.globalAlpha = 0.28 * beat
        local g = c:createRadialGradient(
            480,
            270,
            120,
            480,
            270,
            560
        )
        g:addColorStop(0, "rgba(160,0,30,0)")
        g:addColorStop(1, "rgba(160,0,30,1)")
        c.fillStyle = g
        c:fillRect(0, 0, W, H)
        c:restore()
    end
    local function falling(self, c, t, p)
        vgrad(
            nil,
            c,
            __arrL(
                {
                    __arrL({0, "#04050c"}, 2),
                    __arrL({1, "#0d0f1e"}, 2)
                },
                2
            )
        )
        local contact = 1.95
        local fall = clamp(nil, t / contact)
        local slow = if fall < 0.8 then fall * 0.7 else 0.56 + (fall - 0.8) * 2.2
        do
            local i = 0
            while i < 30 do
                c.globalAlpha = 0.4
                c.fillStyle = "#9fb8ff"
                c:fillRect(
                    rnd(nil, i) * W,
                    __mod(
                        rnd(nil, i * 4) * H - t * 20 * rnd(nil, i * 2),
                        H
                    ),
                    2,
                    2
                )
                i = i + 1
            end
        end
        c.globalAlpha = 1
        vgrad(
            nil,
            c,
            __arrL(
                {
                    __arrL({0, "#0b0d18"}, 2),
                    __arrL({1, "#141830"}, 2)
                },
                2
            ),
            440,
            H
        )
        c.fillStyle = "#1e2546"
        c:fillRect(0, 440, W, 2)
        do
            local knee = smooth(nil, (t - 0.9) / 1.4)
            c:save()
            c.globalAlpha = 0.55 + 0.4 * knee
            c:translate(
                -140,
                lerp(nil, -60, 0, knee)
            )
            c.filter = "none"
            kneel(nil, c, t)
            c:restore()
        end
        if __lt(t, contact) then
            local y = lerp(
                nil,
                60,
                410,
                math.min(1, slow)
            )
            local rot = t * 2.6
            do
                local i = 1
                while i < 6 do
                    c:save()
                    c.globalAlpha = 0.12 * (6 - i) / 6
                    phoneBody(
                        nil,
                        c,
                        620,
                        y - i * 26,
                        0.4,
                        rot - i * 0.18,
                        t
                    )
                    c:restore()
                    i = i + 1
                end
            end
            phoneBody(
                nil,
                c,
                620,
                y,
                0.4,
                rot,
                t
            )
            speedLines(
                nil,
                c,
                620,
                y,
                50,
                140,
                "#ffffff",
                0.12,
                t,
                9
            )
        else
            local k = clamp(nil, (t - contact) / 0.5)
            phoneBody(
                nil,
                c,
                620,
                420,
                0.4,
                math.pi / 2 + 0.1,
                t,
                {crack = smooth(nil, k * 2)}
            )
            if k < 1 then
                c:save()
                c.globalAlpha = 1 - k
                c.strokeStyle = "#d8e6ff"
                c.lineWidth = 3
                do
                    local i = 0
                    while i < 10 do
                        local a = math.pi + i / 9 * math.pi
                        line(
                            nil,
                            c,
                            __arrL(
                                {
                                    __arrL(
                                        {
                                            620 + math.cos(a) * 30 * (1 + k * 3),
                                            440 + math.sin(a) * 12 * (1 + k)
                                        },
                                        2
                                    ),
                                    __arrL(
                                        {
                                            620 + math.cos(a) * 60 * (1 + k * 3),
                                            440 + math.sin(a) * 24 * (1 + k)
                                        },
                                        2
                                    )
                                },
                                2
                            ),
                            "#d8e6ff",
                            3
                        )
                        i = i + 1
                    end
                end
                c:restore()
            end
            if t - contact < 0.08 then
                c.fillStyle = "#ffffff"
                c.globalAlpha = 0.8
                c:fillRect(0, 0, W, H)
                c.globalAlpha = 1
            end
        end
    end
    local function kneeling(self, c, t, p)
        vgrad(
            nil,
            c,
            __arrL(
                {
                    __arrL({0, "#0a0c18"}, 2),
                    __arrL({1, "#141a2e"}, 2)
                },
                2
            )
        )
        c:save()
        c.globalCompositeOperation = "screen"
        local g = c:createLinearGradient(0, 0, 0, H)
        g:addColorStop(0, "rgba(180,200,255,.22)")
        g:addColorStop(1, "rgba(180,200,255,0)")
        c.fillStyle = g
        path(
            nil,
            c,
            __arrL(
                {
                    __arrL({440, -10}, 2),
                    __arrL({520, -10}, 2),
                    __arrL({640, 470}, 2),
                    __arrL({320, 470}, 2)
                },
                4
            )
        )
        __call(c, "fill")
        c:restore()
        vgrad(
            nil,
            c,
            __arrL(
                {
                    __arrL({0, "#0b0e1c"}, 2),
                    __arrL({1, "#05060c"}, 2)
                },
                2
            ),
            440,
            H
        )
        c:save()
        c.globalAlpha = 0.35
        c:translate(0, 880)
        c:scale(1, -1)
        kneel(nil, c, t)
        c:restore()
        c.fillStyle = "rgba(10,12,24,.55)"
        c:fillRect(0, 442, W, H - 442)
        do
            local i = 0
            while i < 8 do
                local k = __mod(t * 0.7 + i / 8, 1)
                c:save()
                c.globalAlpha = (1 - k) * 0.5
                c.strokeStyle = "#9fb8e8"
                c.lineWidth = 1
                c:beginPath()
                c:ellipse(
                    rnd(nil, i) * W,
                    460 + rnd(nil, i * 3) * 70,
                    4 + k * 26,
                    1 + k * 5,
                    0,
                    0,
                    math.pi * 2
                )
                c:stroke()
                c:restore()
                i = i + 1
            end
        end
        kneel(nil, c, t)
        phoneBody(
            nil,
            c,
            690,
            450,
            0.3,
            math.pi / 2 + 0.1,
            t,
            {crack = 1}
        )
        rain(
            nil,
            c,
            t,
            260,
            0.5
        )
        local dark = smooth(nil, (t - 2.4) / 3.1)
        c.fillStyle = ("rgba(2,2,7," .. tostring(dark * 0.95)) .. ")"
        c:fillRect(0, 0, W, H)
    end
    local function eyes(self, c, t, p)
        c.fillStyle = "#020106"
        c:fillRect(0, 0, W, H)
        local flashT = __mod(t, 3.3)
        local ____t_21 = __t
        local ____temp_20 = flashT < 0.08
        __O[1530] = ____temp_20
        local flash = if ____t_21(____temp_20) then __O[1530] else flashT > 0.16 and flashT < 0.22
        if __t(flash) then
            c.fillStyle = "rgba(120,80,200,.35)"
            c:fillRect(0, 0, W, H)
            c:save()
            c.globalAlpha = 0.9
            c.fillStyle = "#010003"
            path(
                nil,
                c,
                __arrL(
                    {
                        __arrL({330, H}, 2),
                        __arrL({360, 260}, 2),
                        __arrL({420, 180}, 2),
                        __arrL({540, 180}, 2),
                        __arrL({600, 260}, 2),
                        __arrL({630, H}, 2)
                    },
                    6
                )
            )
            __call(c, "fill")
            oval(
                nil,
                c,
                480,
                160,
                50,
                46,
                "#010003"
            )
            oval(
                nil,
                c,
                480,
                128,
                140,
                22,
                "#010003"
            )
            c:restore()
            line(
                nil,
                c,
                __arrL(
                    {
                        __arrL({700, 0}, 2),
                        __arrL({660, 90}, 2),
                        __arrL({690, 120}, 2),
                        __arrL({620, 260}, 2)
                    },
                    4
                ),
                "#e6d8ff",
                3
            )
        end
        local open = smooth(nil, (t - 0.35) / 1.4)
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({330, 1}, 2),
                __arrL({630, -1}, 2)
            },
            2
        ))) do
            local x = ____value[1]
            local dir = ____value[2]
            c:save()
            c:translate(x, 190)
            glow(
                nil,
                c,
                0,
                0,
                170,
                "rgba(170,80,255,A)",
                0.35 * open
            )
            c.globalAlpha = 0.55 * open
            local lit = c:createRadialGradient(
                0,
                0,
                10,
                0,
                0,
                140
            )
            lit:addColorStop(0, "rgba(120,70,150,.9)")
            lit:addColorStop(1, "rgba(20,8,30,0)")
            c.fillStyle = lit
            c:fillRect(-150, -90, 300, 180)
            c.globalAlpha = 1
            fill(
                nil,
                c,
                __arrL(
                    {
                        __arrL({-110 * dir, -40}, 2),
                        __arrL({-20 * dir, -56}, 2),
                        __arrL({100 * dir, -30}, 2),
                        __arrL({96 * dir, -22}, 2),
                        __arrL({-20 * dir, -44}, 2),
                        __arrL({-104 * dir, -30}, 2)
                    },
                    6
                ),
                "#0c0612"
            )
            local h = 28 * open
            local function eyeShape()
                c:beginPath()
                c:moveTo(-92 * dir, 8)
                c:bezierCurveTo(
                    -50 * dir,
                    -h * 1.3,
                    40 * dir,
                    -h * 1.2,
                    94 * dir,
                    -10
                )
                c:bezierCurveTo(
                    50 * dir,
                    h * 0.9,
                    -40 * dir,
                    h * 0.8,
                    -92 * dir,
                    8
                )
                c:closePath()
            end
            eyeShape(nil)
            c.fillStyle = "#1e1028"
            __call(c, "fill")
            c:save()
            eyeShape(nil)
            c:clip()
            c.strokeStyle = "rgba(200,40,70,.55)"
            c.lineWidth = 1.2
            do
                local k = 0
                while k < 6 do
                    c:beginPath()
                    c:moveTo(-90 * dir, (k - 3) * 4)
                    c:quadraticCurveTo(-60 * dir, (k - 3) * 6 + 4, -36 * dir, (k - 3) * 3)
                    c:stroke()
                    k = k + 1
                end
            end
            local ir = c:createRadialGradient(
                0,
                0,
                2,
                0,
                0,
                42
            )
            ir:addColorStop(0, "#fff0ff")
            ir:addColorStop(0.25, "#d9a0ff")
            ir:addColorStop(0.7, "#8a3ae0")
            ir:addColorStop(1, "#2a0848")
            c.fillStyle = ir
            c:beginPath()
            c:arc(
                0,
                0,
                40,
                0,
                math.pi * 2
            )
            __call(c, "fill")
            c.strokeStyle = "rgba(60,10,100,.6)"
            c.lineWidth = 1.2
            do
                local k = 0
                while k < 24 do
                    local a = k / 24 * math.pi * 2
                    c:beginPath()
                    c:moveTo(
                        math.cos(a) * 12,
                        math.sin(a) * 12
                    )
                    c:lineTo(
                        math.cos(a) * 38,
                        math.sin(a) * 38
                    )
                    c:stroke()
                    k = k + 1
                end
            end
            c:beginPath()
            c:arc(
                0,
                0,
                40,
                0,
                math.pi * 2
            )
            c.lineWidth = 3
            c.strokeStyle = "#1a0430"
            c:stroke()
            local slit = math.sin(t * 0.6) * 4
            c.fillStyle = "#05000a"
            c:beginPath()
            c:ellipse(
                slit,
                0,
                4.5,
                h * 0.95,
                0,
                0,
                math.pi * 2
            )
            __call(c, "fill")
            circ(
                nil,
                c,
                -14 * dir,
                -12,
                5,
                "#ffffff"
            )
            circ(
                nil,
                c,
                12 * dir,
                10,
                2.2,
                "#ffffffaa"
            )
            c:restore()
            c:beginPath()
            c:moveTo(-96 * dir, 8)
            c:bezierCurveTo(
                -50 * dir,
                -h * 1.35,
                40 * dir,
                -h * 1.25,
                98 * dir,
                -12
            )
            c.lineWidth = 7
            c.strokeStyle = "#080310"
            c:stroke()
            do
                local k = 0
                while k < 3 do
                    line(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({(70 + k * 10) * dir, -16 + k * 4}, 2),
                                __arrL({(92 + k * 12) * dir, -30 + k * 6}, 2)
                            },
                            2
                        ),
                        "#080310",
                        3
                    )
                    k = k + 1
                end
            end
            c:beginPath()
            c:moveTo(-70 * dir, h * 0.55 + 2)
            c:quadraticCurveTo(0, h * 1 + 4, 70 * dir, h * 0.3)
            c.lineWidth = 2
            c.strokeStyle = "#3a1450"
            c:stroke()
            c:restore()
        end
        local words = smooth(nil, (t - 1.8) / 1.8)
        c:save()
        c.globalAlpha = words
        c.textAlign = "center"
        c.font = "800 40px Space,Arial,sans-serif"
        c.fillStyle = "#efe6ff"
        c:fillText("FIM DE JOGO", 480, 360)
        c.font = "400 18px Space,Arial,sans-serif"
        c.fillStyle = "#b39ad0"
        c:fillText("aguardando nova atualização…", 480, 400)
        tracked(
            nil,
            c,
            "UM NOVO CAPÍTULO VAI COMEÇAR",
            480,
            448,
            9,
            "#7a6690",
            4
        )
        c:restore()
    end
    local RENDER = __ord({
        afterglow = afterglow,
        empty = empty,
        vibration = vibration,
        reach = reach,
        caller = caller,
        recognition = recognition,
        tremor = tremor,
        falling = falling,
        kneeling = kneeling,
        eyes = eyes
    }, "afterglow,empty,vibration,reach,caller,recognition,tremor,falling,kneeling,eyes")
    local function draw(self, c, s)
        if __t(not __t(c) or not __t(s)) then
            return
        end
        local ____t_23 = __t
        local ____TS__Number_result_22 = __TS__Number(s.index)
        __O[1531] = ____TS__Number_result_22
        local index = clamp(
            nil,
            math.floor(if ____t_23(____TS__Number_result_22) then __O[1531] else 0),
            0,
            __len(SHOTS) - 1
        )
        local shot = __get(SHOTS, index)
        local ____t_25 = __t
        local ____TS__Number_result_24 = __TS__Number(s.time)
        __O[1532] = ____TS__Number_result_24
        local t = math.max(0, if ____t_25(____TS__Number_result_24) then __O[1532] else 0)
        local p = clamp(nil, t / shot.duration)
        c:save()
        c.imageSmoothingEnabled = true
        c.fillStyle = "#000"
        c:fillRect(0, 0, W, H)
        local ____t_27 = __t
        local ____get_result_26 = __get(RENDER, shot.id)
        __O[1533] = ____get_result_26
        if ____t_27(____get_result_26) then __O[1533] else eyes(nil, c, t, p)
        local fadeIn = 1 - smooth(nil, t / 0.25)
        if __t(fadeIn > 0 and index > 0) then
            c.fillStyle = ("rgba(0,0,0," .. tostring(fadeIn)) .. ")"
            c:fillRect(0, 0, W, H)
        end
        c:restore()
    end
    window.JorgeAnime = {draw = draw}
end)(nil)
return ____exports
