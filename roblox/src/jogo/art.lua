--!native
--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __gt, __ge, __isFiniteN, __getq, __callq, __mod, __ord, __arrL, __iterar, __t, __get = __JSR.__lt, __JSR.__gt, __JSR.__ge, __JSR.__isFiniteN, __JSR.__getq, __JSR.__callq, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get
local __set, __len, __call, __add, __assign, __bor, __band, __shr, __hypot, __re, __re_replace = __JSR.__set, __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__assign, __JSR.__bor, __JSR.__band, __JSR.__shr, __JSR.__hypot, __JSR.__re, __JSR.__re_replace
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__MathSign = ____lualib.__TS__MathSign
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local Map = ____lualib.Map
local __TS__New = ____lualib.__TS__New
local __TS__ParseInt = ____lualib.__TS__ParseInt
local Set = ____lualib.Set
local ____exports = {}
local __O = {};
(function()
    local __L1 = {}
    __L1.poly = function(self, c, points, color)
        c.fillStyle = color
        c:beginPath()
        __call(
            points,
            "forEach",
            function(____, p, i)
                local ____t_result_0
                if __t(i) then
                    ____t_result_0 = c:lineTo(
                        __get(p, 0),
                        __get(p, 1)
                    )
                else
                    ____t_result_0 = c:moveTo(
                        __get(p, 0),
                        __get(p, 1)
                    )
                end
                return ____t_result_0
            end
        )
        c:closePath()
        __call(c, "fill")
    end
    __L1.oval = function(self, c, x, y, rx, ry, color, p)
        if p == nil then
            p = 3
        end
        do
            local yy = __TS__Number(-ry)
            while __lt(yy, ry) do
                local ww = math.sqrt(math.max(0, 1 - yy / ry * (yy / ry))) * rx
                __L1:r(
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
    __L1.cloud = function(self, c, x, y, s, color)
        if s == nil then
            s = 1
        end
        if color == nil then
            color = "#fffef4"
        end
        __L1:r(
            c,
            x + 3 * s,
            y + 15 * s,
            66 * s,
            15 * s,
            "#b9d3e366"
        )
        __L1:r(
            c,
            x,
            y + 12 * s,
            66 * s,
            15 * s,
            color
        )
        __L1:r(
            c,
            x + 12 * s,
            y + 4 * s,
            38 * s,
            24 * s,
            color
        )
        __L1:r(
            c,
            x + 21 * s,
            y - 3 * s,
            22 * s,
            29 * s,
            color
        )
        __L1:r(
            c,
            x - 8 * s,
            y + 17 * s,
            85 * s,
            7 * s,
            color
        )
        __L1:r(
            c,
            x + 4 * s,
            y + 28 * s,
            56 * s,
            3 * s,
            "#d8e7e9"
        )
        __L1:r(
            c,
            x - 6 * s,
            y + 20 * s,
            81 * s,
            4 * s,
            "#e3edf1"
        )
        __L1:r(
            c,
            x + 22 * s,
            y - 2 * s,
            14 * s,
            3 * s,
            "#ffffff"
        )
        __L1:r(
            c,
            x + 14 * s,
            y + 5 * s,
            10 * s,
            2 * s,
            "#ffffff"
        )
    end
    __L1.steppedHill = function(self, c, x, y, w, h, color)
        __L1:poly(
            c,
            __arrL(
                {
                    __arrL(
                        {
                            x,
                            __add(y, h)
                        },
                        2
                    ),
                    __arrL({x, y + 75}, 2),
                    __arrL({x + w * 0.09, y + 75}, 2),
                    __arrL({x + w * 0.09, y + 55}, 2),
                    __arrL({x + w * 0.21, y + 55}, 2),
                    __arrL({x + w * 0.21, y + 31}, 2),
                    __arrL({x + w * 0.35, y + 31}, 2),
                    __arrL({x + w * 0.35, y + 12}, 2),
                    __arrL({x + w * 0.48, y + 12}, 2),
                    __arrL({x + w * 0.48, y}, 2),
                    __arrL({x + w * 0.6, y}, 2),
                    __arrL({x + w * 0.6, y + 16}, 2),
                    __arrL({x + w * 0.73, y + 16}, 2),
                    __arrL({x + w * 0.73, y + 39}, 2),
                    __arrL({x + w * 0.85, y + 39}, 2),
                    __arrL({x + w * 0.85, y + 66}, 2),
                    __arrL(
                        {
                            __add(x, w),
                            y + 66
                        },
                        2
                    ),
                    __arrL(
                        {
                            __add(x, w),
                            __add(y, h)
                        },
                        2
                    )
                },
                18
            ),
            color
        )
    end
    __L1.cachedLayer = function(self, key, w, h, paint)
        local layer = __call(__L1.remasterCache, "get", key)
        if __t(layer) then
            return layer
        end
        layer = window.document:createElement("canvas")
        layer.width = w
        layer.height = h
        local x = layer:getContext("2d")
        x.imageSmoothingEnabled = false
        paint(nil, x, w, h)
        __call(__L1.remasterCache, "set", key, layer)
        return layer
    end
    __L1.ditherRamp = function(self, key, w, h, stops, px)
        if px == nil then
            px = 2
        end
        return __L1:cachedLayer(
            key,
            w,
            h,
            function(____, x)
                local lw = math.ceil(w / px)
                local lh = math.ceil(h / px)
                local small = window.document:createElement("canvas")
                small.width = lw
                small.height = lh
                local sc = small:getContext("2d")
                local img = sc:createImageData(lw, lh)
                local cols = __call(stops, "map", __L1.hex)
                local n = __len(cols) - 1
                do
                    local yy = 0
                    while yy < lh do
                        local f = yy / (lh - 1) * n
                        local i = math.min(
                            n - 1,
                            math.floor(f)
                        )
                        local frac = f - i
                        do
                            local xx = 0
                            while xx < lw do
                                local ____temp_1
                                if frac * 16 > __get(
                                    __L1.BAYER,
                                    __band(yy, 3) * 4 + __band(xx, 3)
                                ) + 0.5 then
                                    ____temp_1 = __get(cols, i + 1)
                                else
                                    ____temp_1 = __get(cols, i)
                                end
                                local pick = ____temp_1
                                local o = (yy * lw + xx) * 4
                                __set(
                                    img.data,
                                    o,
                                    __get(pick, 0)
                                )
                                __set(
                                    img.data,
                                    o + 1,
                                    __get(pick, 1)
                                )
                                __set(
                                    img.data,
                                    o + 2,
                                    __get(pick, 2)
                                )
                                __set(img.data, o + 3, 255)
                                xx = xx + 1
                            end
                        end
                        yy = yy + 1
                    end
                end
                sc:putImageData(img, 0, 0)
                x:drawImage(
                    small,
                    0,
                    0,
                    lw * px,
                    lh * px
                )
            end
        )
    end
    __L1.ditherShade = function(self, key, w, h, color, alphaAt, px)
        if px == nil then
            px = 2
        end
        return __L1:cachedLayer(
            key,
            w,
            h,
            function(____, x)
                local lw = math.ceil(w / px)
                local lh = math.ceil(h / px)
                local small = window.document:createElement("canvas")
                small.width = lw
                small.height = lh
                local sc = small:getContext("2d")
                local img = sc:createImageData(lw, lh)
                local col = __L1:hex(color)
                do
                    local yy = 0
                    while yy < lh do
                        do
                            local xx = 0
                            while xx < lw do
                                local a = math.max(
                                    0,
                                    math.min(
                                        1,
                                        alphaAt(nil, xx / (lw - 1), yy / (lh - 1))
                                    )
                                )
                                local steps = a * 4
                                local base = math.floor(steps)
                                local ____temp_2
                                if (steps - base) * 16 > __get(
                                    __L1.BAYER,
                                    __band(yy, 3) * 4 + __band(xx, 3)
                                ) + 0.5 then
                                    ____temp_2 = base + 1
                                else
                                    ____temp_2 = base
                                end
                                local on = ____temp_2
                                local o = (yy * lw + xx) * 4
                                __set(
                                    img.data,
                                    o,
                                    __get(col, 0)
                                )
                                __set(
                                    img.data,
                                    o + 1,
                                    __get(col, 1)
                                )
                                __set(
                                    img.data,
                                    o + 2,
                                    __get(col, 2)
                                )
                                __set(
                                    img.data,
                                    o + 3,
                                    math.floor(on / 4 * 255 + 0.5)
                                )
                                xx = xx + 1
                            end
                        end
                        yy = yy + 1
                    end
                end
                sc:putImageData(img, 0, 0)
                x:drawImage(
                    small,
                    0,
                    0,
                    lw * px,
                    lh * px
                )
            end
        )
    end
    __L1.farRange = function(self, scene)
        local mood = __L1:skyFor(scene)
        local far = mood == "golden" and "#8a84a8" or (mood == "afternoon" and "#7d98bb" or "#78a3c6")
        local near = mood == "golden" and "#6f6b92" or (mood == "afternoon" and "#64819f" or "#5f8fb3")
        local snow = mood == "golden" and "#f0c9b0" or "#e6f0f4"
        return __L1:cachedLayer(
            __add("range-", mood),
            1920,
            190,
            function(____, x)
                for ____, ____value in __iterar((__arrL(
                    {
                        __arrL({far, 70, 40, 3}, 4),
                        __arrL({near, 48, 92, 9}, 4)
                    },
                    2
                ))) do
                    local col = ____value[1]
                    local amp = ____value[2]
                    local base = ____value[3]
                    local seed = ____value[4]
                    x.fillStyle = col
                    local h = base
                    do
                        local xx = 0
                        while xx < 1920 do
                            local n = math.sin((xx + seed * 91) / 151) * 0.55 + math.sin((xx + seed * 37) / 67) * 0.3 + math.sin((xx + seed * 13) / 29) * 0.15
                            h = math.floor((base + amp * (0.5 - n * 0.5)) / 3 + 0.5) * 3
                            x:fillRect(xx, h, 6, 190 - h)
                            if __t(col == far and __lt(h, base + 8)) then
                                x.fillStyle = snow
                                x:fillRect(xx, h, 6, 3)
                                x.fillStyle = col
                            end
                            xx = xx + 6
                        end
                    end
                end
                x:drawImage(
                    __L1:ditherShade(
                        __add("haze-", mood),
                        1920,
                        190,
                        mood == "golden" and "#f2d3a8" or "#e4eef0",
                        function(____, u, v) return __lt(v, 0.35) and 0 or ((v - 0.35) / 0.65) ^ 1.4 * 0.7 end,
                        2
                    ),
                    0,
                    0
                )
            end
        )
    end
    __L1.sunGlow = function(self, c, x, y, warm)
        local glow = __L1:cachedLayer(
            __add(
                "sun-",
                __t(warm) and "w" or "d"
            ),
            340,
            340,
            function(____, g)
                local gr = g:createRadialGradient(
                    170,
                    170,
                    10,
                    170,
                    170,
                    170
                )
                gr:addColorStop(
                    0,
                    __t(warm) and "rgba(255,214,150,.55)" or "rgba(255,248,214,.5)"
                )
                gr:addColorStop(
                    0.35,
                    __t(warm) and "rgba(255,200,140,.18)" or "rgba(255,250,224,.16)"
                )
                gr:addColorStop(1, "rgba(255,250,224,0)")
                g.fillStyle = gr
                g:fillRect(0, 0, 340, 340)
                do
                    local i = 0
                    while i < 3 do
                        g.globalAlpha = 0.16 - i * 0.04
                        __L1:oval(
                            g,
                            170,
                            170,
                            46 + i * 12,
                            46 + i * 12,
                            __t(warm) and "#ffe0b0" or "#fff7da",
                            3
                        )
                        i = i + 1
                    end
                end
            end
        )
        c:drawImage(
            glow,
            math.floor(x - 170 + 0.5),
            math.floor(y - 170 + 0.5)
        )
    end
    __L1.lightPass = function(self, c, scene, camera, t)
        local outdoor = __call(__L1.OUTDOOR, "has", scene)
        local ink = scene == 6
        local mood = __L1:skyFor(scene)
        if __t(__L1.liteNow) then
            return
        end
        c:drawImage(
            __L1:cachedLayer(
                __add(
                    "overlay-",
                    __t(ink) and "ink" or (__t(outdoor) and "out" or "in")
                ),
                960,
                540,
                function(____, x)
                    local g = x:createLinearGradient(0, 412, 0, 442)
                    g:addColorStop(0, "rgba(20,16,12,0)")
                    g:addColorStop(1, "rgba(20,16,12,.28)")
                    x.fillStyle = g
                    x:fillRect(0, 412, 960, 30)
                    local d = x:createLinearGradient(0, 452, 0, 540)
                    d:addColorStop(0, "rgba(20,14,10,0)")
                    d:addColorStop(
                        1,
                        __t(ink) and "rgba(20,10,40,.45)" or "rgba(20,14,10,.42)"
                    )
                    x.fillStyle = d
                    x:fillRect(0, 452, 960, 88)
                    if not __t(outdoor) then
                        x.fillStyle = __t(ink) and "rgba(40,20,70,.12)" or "rgba(40,34,28,.1)"
                        x:fillRect(0, 0, 960, 540)
                    end
                    local v = x:createRadialGradient(
                        480,
                        300,
                        180,
                        480,
                        300,
                        620
                    )
                    v:addColorStop(0, "rgba(12,16,14,0)")
                    v:addColorStop(
                        1,
                        __t(ink) and "rgba(20,10,38,.5)" or (__t(outdoor) and "rgba(12,16,14,.32)" or "rgba(12,16,14,.42)")
                    )
                    x.fillStyle = v
                    x:fillRect(0, 0, 960, 540)
                end
            ),
            0,
            0
        )
        if __t(__L1.liteNow) then
            return
        end
        if __t(outdoor) then
            local warm = mood ~= "day" and mood ~= "plaza"
            c:save()
            do
                local i = 0
                while i < 4 do
                    local sway = math.sin(t * 0.25 + i * 1.7) * 18
                    local x0 = 620 + i * 70 + sway - __mod(camera * 0.02, 60)
                    local a = __t(warm) and 0.07 or 0.055
                    local ____c_4 = c
                    local ____t_result_3
                    if __t(warm) then
                        ____t_result_3 = ("rgba(255,206,140," .. tostring(a)) .. ")"
                    else
                        ____t_result_3 = ("rgba(255,250,215," .. tostring(a)) .. ")"
                    end
                    ____c_4.fillStyle = ____t_result_3
                    c:beginPath()
                    c:moveTo(x0, 0)
                    c:lineTo(x0 + 60 + i * 10, 0)
                    c:lineTo(x0 - 260 + i * 40, 440)
                    c:lineTo(x0 - 380 + i * 30, 440)
                    c:closePath()
                    __call(c, "fill")
                    i = i + 1
                end
            end
            c:restore()
            c:save()
            do
                local i = 0
                while i < 18 do
                    local life = __mod(
                        __L1.animT * 0.05 + __L1:hash(i + 300),
                        1
                    )
                    local bx = 560 + __L1:hash(i + 310) * 330 - life * 170 + math.sin(__L1.animT * 0.9 + i) * 9
                    local by = 40 + __L1:hash(i + 320) * 360 - life * 60
                    local tw = 0.35 + 0.35 * math.sin(__L1.animT * 3 + i * 2.1)
                    c.globalAlpha = tw * (1 - math.abs(life - 0.5) * 2)
                    __L1:r(
                        c,
                        bx - (bx > 740 and 0 or 0),
                        by,
                        2,
                        2,
                        __t(warm) and "#ffe2b0" or "#fffbe2"
                    )
                    i = i + 1
                end
            end
            c:restore()
            c:save()
            do
                local i = 0
                while i < 3 do
                    local span = 2200
                    local cx = __mod(
                        __mod(i * 760 + t * 16 - camera * 0.85, span) + span,
                        span
                    ) - 500
                    local w = 260 + __L1:hash(i + 400) * 160
                    c:drawImage(
                        __L1:cachedLayer(
                            "cloud-shadow",
                            256,
                            256,
                            function(____, x)
                                local g = x:createRadialGradient(
                                    128,
                                    128,
                                    4,
                                    128,
                                    128,
                                    128
                                )
                                g:addColorStop(0, "rgba(60,70,90,.16)")
                                g:addColorStop(1, "rgba(60,70,90,0)")
                                x.fillStyle = g
                                x:fillRect(0, 0, 256, 256)
                            end
                        ),
                        cx - w,
                        470 - w * 0.32,
                        w * 2,
                        w * 0.64
                    )
                    i = i + 1
                end
            end
            c:restore()
            if __t(warm) then
                c:save()
                c.globalCompositeOperation = "soft-light"
                c.fillStyle = mood == "golden" and "rgba(255,170,90,.32)" or "rgba(255,200,130,.22)"
                c:fillRect(0, 0, 960, 440)
                c:restore()
            end
        end
    end
    __L1.hillDetail = function(self, c, x, y, w, near, seed)
        local steps = __arrL(
            {
                __arrL({0, 75, 0.09}, 3),
                __arrL({0.09, 55, 0.12}, 3),
                __arrL({0.21, 31, 0.14}, 3),
                __arrL({0.35, 12, 0.13}, 3),
                __arrL({0.48, 0, 0.12}, 3),
                __arrL({0.6, 16, 0.13}, 3),
                __arrL({0.73, 39, 0.12}, 3),
                __arrL({0.85, 66, 0.15}, 3)
            },
            8
        )
        local ____t_result_5
        if __t(near) then
            ____t_result_5 = __arrL({"#2f6b3a", "#3f8240", "#5c9c48"}, 3)
        else
            ____t_result_5 = __arrL({"#5f9a7c", "#6ea888", "#7fb595"}, 3)
        end
        local tree = ____t_result_5
        do
            local k = 0
            while k < __len(steps) do
                local fx, dy, fw = table.unpack(
                    __get(steps, k),
                    1,
                    3
                )
                local sx = x + w * fx
                local sy = y + dy
                local sw = w * fw
                __L1:r(
                    c,
                    sx,
                    sy,
                    sw,
                    2,
                    __t(near) and "#86bd62" or "#a9cbb5"
                )
                __L1:r(
                    c,
                    sx,
                    sy + 5,
                    sw,
                    3,
                    __t(near) and "#4f8f50" or "#7aa891"
                )
                local n = math.max(
                    1,
                    math.floor(sw / (__t(near) and 11 or 8))
                )
                do
                    local i = 0
                    while i < n do
                        do
                            local h = __L1:hash(seed * 31 + k * 7 + i)
                            if h < 0.35 then
                                do i = i + 1 continue end
                            end
                            local tx = sx + 3 + i * (sw - 6) / n
                            local ____t_7 = __t
                            local ____t_result_6
                            if __t(near) then
                                ____t_result_6 = h > 0.93
                            else
                                ____t_result_6 = near
                            end
                            if ____t_7(____t_result_6) then
                                __L1:r(
                                    c,
                                    tx - 5,
                                    sy - 7,
                                    11,
                                    7,
                                    "#efe2c4"
                                )
                                __L1:r(
                                    c,
                                    tx - 6,
                                    sy - 10,
                                    13,
                                    3,
                                    "#c2573e"
                                )
                                __L1:r(
                                    c,
                                    tx - 1,
                                    sy - 4,
                                    3,
                                    4,
                                    "#6b4a33"
                                )
                                __L1:r(
                                    c,
                                    tx + 2,
                                    sy - 13,
                                    2,
                                    3,
                                    "#8a5a40"
                                )
                                do
                                    local q = 0
                                    while q < 4 do
                                        local k = __mod(__L1.animT * 0.35 + q / 4 + h, 1)
                                        c.globalAlpha = (1 - k) * 0.55
                                        __L1:r(
                                            c,
                                            tx + 2 + math.floor(__L1:windAt(0) * 4 * k + k * 5 + 0.5),
                                            sy - 15 - k * 22,
                                            2 + math.floor(k * 3 + 0.5),
                                            2 + math.floor(k * 2 + 0.5),
                                            "#eef2f3"
                                        )
                                        q = q + 1
                                    end
                                end
                                c.globalAlpha = 1
                            else
                                local ____t_9 = __t
                                local ____t_result_8
                                if __t(near) then
                                    ____t_result_8 = h > 0.86
                                else
                                    ____t_result_8 = near
                                end
                                if ____t_9(____t_result_8) then
                                    __L1:r(
                                        c,
                                        tx - 4,
                                        sy - 5,
                                        8,
                                        4,
                                        h > 0.9 and "#f2efe6" or "#8a5a3a"
                                    )
                                    __L1:r(
                                        c,
                                        tx + 3,
                                        sy - 6,
                                        3,
                                        3,
                                        h > 0.9 and "#f2efe6" or "#8a5a3a"
                                    )
                                    __L1:r(
                                        c,
                                        tx - 3,
                                        sy - 1,
                                        1,
                                        2,
                                        "#3a3028"
                                    )
                                    __L1:r(
                                        c,
                                        tx + 2,
                                        sy - 1,
                                        1,
                                        2,
                                        "#3a3028"
                                    )
                                    __L1:r(
                                        c,
                                        tx - 2,
                                        sy - 4,
                                        2,
                                        2,
                                        "#2c2a28"
                                    )
                                else
                                    local ____t_11 = __t
                                    local ____t_result_10
                                    if __t(near) then
                                        ____t_result_10 = h > 0.8
                                    else
                                        ____t_result_10 = near
                                    end
                                    if ____t_11(____t_result_10) then
                                        __L1:r(
                                            c,
                                            tx,
                                            sy - 16,
                                            2,
                                            16,
                                            "#8a6a45"
                                        )
                                        __L1:r(
                                            c,
                                            tx - 5,
                                            sy - 18,
                                            12,
                                            2,
                                            "#3f8240"
                                        )
                                        __L1:r(
                                            c,
                                            tx - 3,
                                            sy - 20,
                                            8,
                                            2,
                                            "#5c9c48"
                                        )
                                        __L1:r(
                                            c,
                                            tx + 1,
                                            sy - 16,
                                            2,
                                            2,
                                            "#7a5a2a"
                                        )
                                    else
                                        local ____t_result_12
                                        if __t(near) then
                                            ____t_result_12 = 4 + math.floor(h * 4)
                                        else
                                            ____t_result_12 = 2 + math.floor(h * 2)
                                        end
                                        local z = ____t_result_12
                                        __L1:r(
                                            c,
                                            tx - z,
                                            sy - z * 1.6,
                                            z * 2,
                                            z * 1.6,
                                            __get(tree, 0)
                                        )
                                        __L1:r(
                                            c,
                                            tx - z + 1,
                                            sy - z * 1.6,
                                            z * 2 - 2,
                                            z * 0.8,
                                            __get(tree, 2)
                                        )
                                        __L1:r(
                                            c,
                                            tx - 1,
                                            sy - z * 0.6 + 1,
                                            1,
                                            z * 0.6,
                                            __t(near) and "#5a4030" or "#6f8f80"
                                        )
                                        local ____t_14 = __t
                                        local ____t_result_13
                                        if __t(near) then
                                            ____t_result_13 = h > 0.6
                                        else
                                            ____t_result_13 = near
                                        end
                                        if ____t_14(____t_result_13) then
                                            __L1:r(
                                                c,
                                                tx + z - 2,
                                                sy - z,
                                                2,
                                                2,
                                                "#d79a3a"
                                            )
                                        end
                                    end
                                end
                            end
                        end
                        i = i + 1
                    end
                end
                k = k + 1
            end
        end
        local ____t_16 = __t
        local ____t_result_15
        if __t(near) then
            ____t_result_15 = __L1:hash(seed + 5) > 0.5
        else
            ____t_result_15 = near
        end
        if ____t_16(____t_result_15) then
            __L1:r(
                c,
                x + w * 0.2,
                y + 60,
                w * 0.5,
                2,
                "#b9a273"
            )
            __L1:r(
                c,
                x + w * 0.25,
                y + 62,
                w * 0.4,
                1,
                "#9c8458"
            )
        end
        if __t(near) then
            do
                local i = 0
                while i < 3 do
                    local fx = x + w * (0.1 + i * 0.3)
                    do
                        local j = 0
                        while j < 5 do
                            __L1:r(
                                c,
                                fx + j * 8,
                                y + 86 - __L1:hash(seed + i) * 10,
                                1,
                                5,
                                "#7d6a48"
                            )
                            j = j + 1
                        end
                    end
                    __L1:r(
                        c,
                        fx,
                        y + 84 - __L1:hash(seed + i) * 10,
                        34,
                        1,
                        "#a08a60"
                    )
                    i = i + 1
                end
            end
        end
    end
    __L1.skyline = function(self, scene)
        return __L1:cachedLayer(
            "skyline",
            1920,
            170,
            function(____, x)
                local far = "#9fb3c4"
                local mid = "#8aa1b5"
                local win = "#d7e3ea"
                local lit = "#f3e0a0"
                local xx = 0
                local i = 0
                while xx < 1920 do
                    local h = 40 + math.floor(__L1:hash(i + 700) * 95)
                    local w = 26 + math.floor(__L1:hash(i + 701) * 46)
                    local col = __L1:hash(i + 702) > 0.5 and far or mid
                    local y = 170 - h
                    x.fillStyle = col
                    x:fillRect(xx, y, w, h)
                    x.fillStyle = "#b4c5d3"
                    x:fillRect(xx, y, w, 2)
                    do
                        local wy = y + 6
                        while wy < 166 do
                            do
                                local wx = xx + 3
                                while wx < xx + w - 3 do
                                    x.fillStyle = __L1:hash(i * 13 + wx + wy) > 0.86 and lit or win
                                    x.globalAlpha = 0.55
                                    x:fillRect(wx, wy, 3, 3)
                                    x.globalAlpha = 1
                                    wx = wx + 6
                                end
                            end
                            wy = wy + 7
                        end
                    end
                    if __L1:hash(i + 703) > 0.55 then
                        x.fillStyle = "#4f88b8"
                        x:fillRect(xx + w * 0.3, y - 7, 10, 7)
                        x.fillStyle = "#7fb0d8"
                        x:fillRect(xx + w * 0.3, y - 7, 10, 2)
                        x.fillStyle = "#6d7f8f"
                        x:fillRect(xx + w * 0.3 + 1, y - 1, 1, 2)
                        x:fillRect(xx + w * 0.3 + 8, y - 1, 1, 2)
                    end
                    if __L1:hash(i + 704) > 0.8 then
                        x.fillStyle = "#7f8f9e"
                        x:fillRect(xx + w - 6, y - 18, 1, 18)
                        x:fillRect(xx + w - 9, y - 14, 7, 1)
                        x.fillStyle = "#e05050"
                        x:fillRect(xx + w - 6, y - 19, 1, 1)
                    end
                    if i == 9 then
                        x.fillStyle = "#e8e2d4"
                        x:fillRect(xx + 4, y - 34, 14, 34)
                        x.fillStyle = "#c9c2b2"
                        x:fillRect(xx + 4, y - 34, 14, 2)
                        x.fillStyle = "#e8e2d4"
                        x:fillRect(xx + 9, y - 44, 4, 10)
                        x.fillStyle = "#8a7a60"
                        x:fillRect(xx + 10, y - 52, 2, 8)
                        x:fillRect(xx + 8, y - 49, 6, 2)
                    end
                    xx = xx + (w + 2 + math.floor(__L1:hash(i + 705) * 10))
                    i = i + 1
                end
                x:drawImage(
                    __L1:ditherShade(
                        "city-haze",
                        1920,
                        170,
                        "#dfeaf0",
                        function(____, u, v) return 0.55 - v * 0.45 end,
                        2
                    ),
                    0,
                    0
                )
            end
        )
    end
    __L1.favelaHill = function(self)
        return __L1:cachedLayer(
            "favela-hill",
            1920,
            190,
            function(____, x)
                x.fillStyle = "#7f8a6a"
                x:beginPath()
                x:moveTo(0, 190)
                do
                    local i = 0
                    while i <= 1920 do
                        x:lineTo(
                            i,
                            70 + math.sin(i / 260) * 40 + math.sin(i / 90) * 10
                        )
                        i = i + 40
                    end
                end
                x:lineTo(1920, 190)
                x:closePath()
                __call(x, "fill")
                local cols = __arrL({
                    "#c98a62",
                    "#d8b48a",
                    "#a8b7a2",
                    "#c9a4a0",
                    "#9fb2c4",
                    "#e0c08a",
                    "#b9765a",
                    "#d7d2c0"
                }, 8)
                do
                    local i = 0
                    while i < 520 do
                        local hx = __L1:hash(i + 900) * 1920
                        local top = 70 + math.sin(hx / 260) * 40 + math.sin(hx / 90) * 10
                        local hy = top + 6 + __L1:hash(i + 901) * 110
                        local w = 7 + math.floor(__L1:hash(i + 902) * 7)
                        local h = 5 + math.floor(__L1:hash(i + 903) * 5)
                        x.fillStyle = __get(
                            cols,
                            __mod(
                                i,
                                __len(cols)
                            )
                        )
                        x:fillRect(
                            math.floor(hx + 0.5),
                            math.floor(hy + 0.5),
                            w,
                            h
                        )
                        x.fillStyle = "#5a4a40"
                        x:fillRect(
                            math.floor(hx + 0.5) + 2,
                            math.floor(hy + 0.5) + 2,
                            2,
                            2
                        )
                        if w > 9 then
                            x:fillRect(
                                math.floor(hx + 0.5) + 6,
                                math.floor(hy + 0.5) + 2,
                                2,
                                2
                            )
                        end
                        x.fillStyle = "rgba(255,255,255,.25)"
                        x:fillRect(
                            math.floor(hx + 0.5),
                            math.floor(hy + 0.5),
                            w,
                            1
                        )
                        i = i + 1
                    end
                end
                x:drawImage(
                    __L1:ditherShade(
                        "favela-haze",
                        1920,
                        190,
                        "#e9c9a6",
                        function(____, u, v) return 0.5 - v * 0.3 end,
                        2
                    ),
                    0,
                    0
                )
            end
        )
    end
    __L1.materialTile = function(self, kind)
        return __L1:cachedLayer(
            __add("mat-", kind),
            512,
            440,
            function(____, x)
                local dark = kind == "ink" and "rgba(40,20,60," or "rgba(30,24,18,"
                local light = "rgba(255,252,240,"
                do
                    local i = 0
                    while i < 2600 do
                        local px = math.floor(__L1:hash(i + 5000) * 512)
                        local py = math.floor(__L1:hash(i + 5100) * 440)
                        local a = 0.04 + __L1:hash(i + 5200) * 0.07
                        local ____x_20 = x
                        local ____add_19 = __add
                        local ____add_18 = __add
                        local ____t_result_17
                        if __t(__mod(i, 3)) then
                            ____t_result_17 = dark
                        else
                            ____t_result_17 = light
                        end
                        ____x_20.fillStyle = ____add_19(
                            ____add_18(____t_result_17, a),
                            ")"
                        )
                        x:fillRect(
                            px,
                            py,
                            __L1:hash(i + 5300) > 0.8 and 2 or 1,
                            1
                        )
                        i = i + 1
                    end
                end
                do
                    local i = 0
                    while i < 46 do
                        local px = math.floor(__L1:hash(i + 5400) * 512)
                        local py = math.floor(__L1:hash(i + 5500) * 380)
                        local len = 12 + __L1:hash(i + 5600) * 60
                        local g = x:createLinearGradient(0, py, 0, py + len)
                        g:addColorStop(
                            0,
                            __add(dark, ".10)")
                        )
                        g:addColorStop(
                            1,
                            __add(dark, "0)")
                        )
                        x.fillStyle = g
                        x:fillRect(
                            px,
                            py,
                            1 + (__mod(i, 3) == 0 and 1 or 0),
                            len
                        )
                        i = i + 1
                    end
                end
                do
                    local i = 0
                    while i < 14 do
                        local cx = __L1:hash(i + 5700) * 512
                        local cy = __L1:hash(i + 5800) * 400
                        x.fillStyle = __add(dark, ".16)")
                        do
                            local k = 0
                            while k < 10 do
                                x:fillRect(
                                    math.floor(cx + 0.5),
                                    math.floor(cy + 0.5),
                                    1,
                                    2
                                )
                                cx = cx + (__L1:hash(i * 9 + k) > 0.5 and 1 or -1)
                                cy = cy + 2
                                k = k + 1
                            end
                        end
                        i = i + 1
                    end
                end
                local g = x:createLinearGradient(0, 380, 0, 440)
                g:addColorStop(
                    0,
                    __add(dark, "0)")
                )
                g:addColorStop(
                    1,
                    __add(dark, ".14)")
                )
                x.fillStyle = g
                x:fillRect(0, 380, 512, 60)
            end
        )
    end
    __L1.facadeTexture = function(self, c, scene, camera)
        local band = __get(__L1.TEX_BANDS, scene)
        if not __t(band) then
            return
        end
        local tile = __L1:materialTile(scene == 6 and "ink" or "std")
        local off = __mod(
            __mod(camera, 512) + 512,
            512
        )
        local y0, y1 = table.unpack(band, 1, 2)
        c:save()
        c:beginPath()
        c:rect(0, y0, 960, y1 - y0)
        c:clip()
        do
            local x = __TS__Number(-off)
            while x < 960 do
                c:drawImage(
                    tile,
                    math.floor(x + 0.5),
                    0
                )
                x = x + 512
            end
        end
        c:restore()
    end
    __L1.ac = function(self, c, x, y)
        __L1:r(
            c,
            x,
            y,
            26,
            15,
            "#c9cdd0"
        )
        __L1:r(
            c,
            x,
            y,
            26,
            2,
            "#eef0f1"
        )
        __L1:r(
            c,
            x + 2,
            y + 4,
            14,
            9,
            "#8e9599"
        )
        do
            local i = 0
            while i < 4 do
                __L1:r(
                    c,
                    x + 3,
                    y + 5 + i * 2,
                    12,
                    1,
                    "#5d6468"
                )
                i = i + 1
            end
        end
        __L1:r(
            c,
            x + 18,
            y + 5,
            6,
            6,
            "#a7adb1"
        )
        __L1:r(
            c,
            x + 20,
            y + 7,
            2,
            2,
            "#6c7377"
        )
        __L1:r(
            c,
            x + 24,
            y + 15,
            1,
            8,
            "#5e7f9a"
        )
        __L1:r(
            c,
            x + 3,
            y + 15,
            20,
            1,
            "#7d8488"
        )
    end
    __L1.poster = function(self, c, x, y, seed)
        local cols = __get(
            __arrL(
                {
                    __arrL({"#e9d27a", "#c0503e"}, 2),
                    __arrL({"#9fd0e0", "#2f5f86"}, 2),
                    __arrL({"#f1b0b8", "#7a3a5a"}, 2),
                    __arrL({"#cfe39a", "#3f6e3a"}, 2)
                },
                4
            ),
            __mod(seed, 4)
        )
        __L1:r(
            c,
            x,
            y,
            20,
            27,
            "#3a3530"
        )
        __L1:r(
            c,
            x + 1,
            y + 1,
            18,
            25,
            __get(cols, 0)
        )
        __L1:r(
            c,
            x + 3,
            y + 4,
            14,
            2,
            __get(cols, 1)
        )
        __L1:r(
            c,
            x + 3,
            y + 8,
            10,
            1,
            __get(cols, 1)
        )
        __L1:r(
            c,
            x + 4,
            y + 12,
            12,
            9,
            __get(cols, 1)
        )
        __L1:r(
            c,
            x + 6,
            y + 14,
            8,
            5,
            __get(cols, 0)
        )
        __L1:r(
            c,
            x + 17,
            y + 1,
            2,
            4,
            "#ffffff55"
        )
        if __mod(seed, 3) == 0 then
            __L1:r(
                c,
                x + 15,
                y + 20,
                4,
                6,
                "#ffffff"
            )
            __L1:r(
                c,
                x + 16,
                y + 21,
                3,
                5,
                __get(cols, 0)
            )
        end
    end
    __L1.tag = function(self, c, x, y, seed)
        local col = __get(
            __arrL({
                "#d8433a",
                "#2a8f6a",
                "#e0a020",
                "#7b3fb0",
                "#1d1d1d"
            }, 5),
            __mod(seed, 5)
        )
        do
            local i = 0
            while i < 5 do
                local h = 6 + __mod(seed * 7 + i * 3, 7)
                __L1:r(
                    c,
                    x + i * 6,
                    y + 10 - h,
                    3,
                    h,
                    col
                )
                __L1:r(
                    c,
                    x + i * 6 + 2,
                    y + 10 - h,
                    3,
                    2,
                    col
                )
                i = i + 1
            end
        end
        __L1:r(
            c,
            x - 2,
            y + 11,
            34,
            2,
            col
        )
        __L1:r(
            c,
            x + 30,
            y + 2,
            2,
            2,
            col
        )
        __L1:r(
            c,
            x + 31,
            y + 12,
            1,
            5,
            col
        )
    end
    __L1.pipe = function(self, c, x, y0, y1)
        __L1:r(
            c,
            x,
            y0,
            5,
            y1 - y0,
            "#8d9497"
        )
        __L1:r(
            c,
            x + 1,
            y0,
            1,
            y1 - y0,
            "#c7cdd0"
        )
        do
            local y = y0 + 20
            while __lt(y, y1) do
                __L1:r(
                    c,
                    x - 1,
                    y,
                    7,
                    3,
                    "#6d7477"
                )
                y = y + 40
            end
        end
    end
    __L1.dish = function(self, c, x, y)
        __L1:r(
            c,
            x + 5,
            y + 8,
            2,
            8,
            "#7d7d7d"
        )
        __L1:r(
            c,
            x,
            y,
            13,
            10,
            "#d9dcdd"
        )
        __L1:r(
            c,
            x + 2,
            y + 2,
            9,
            6,
            "#bfc3c5"
        )
        __L1:r(
            c,
            x + 5,
            y + 4,
            3,
            2,
            "#6d7377"
        )
        __L1:r(
            c,
            x + 11,
            y + 2,
            4,
            1,
            "#8a8f92"
        )
    end
    __L1.gasCan = function(self, c, x, y)
        __L1:r(
            c,
            x,
            y,
            10,
            15,
            "#3a6fc4"
        )
        __L1:r(
            c,
            x + 1,
            y + 1,
            3,
            12,
            "#6d9be0"
        )
        __L1:r(
            c,
            x + 3,
            y - 3,
            4,
            3,
            "#2a2a2a"
        )
        __L1:r(
            c,
            x - 1,
            y + 14,
            12,
            2,
            "#29519a"
        )
    end
    __L1.planter = function(self, c, x, y)
        __L1:r(
            c,
            x,
            y,
            20,
            6,
            "#a85e3e"
        )
        __L1:r(
            c,
            x,
            y,
            20,
            1,
            "#d48a62"
        )
        do
            local i = 0
            while i < 5 do
                local sw = math.floor(__L1:windAt(__L1:screenX(c, x)) * 1.2 + 0.5)
                __L1:r(
                    c,
                    x + 2 + i * 4 + sw,
                    y - 6 - __mod(i, 2) * 4,
                    3,
                    6 + __mod(i, 2) * 4,
                    __t(__mod(i, 2)) and "#4f9a40" or "#6fbf55"
                )
                if i == 2 then
                    __L1:r(
                        c,
                        x + 2 + i * 4 + sw,
                        y - 10,
                        3,
                        3,
                        "#f2a2b2"
                    )
                end
                i = i + 1
            end
        end
    end
    __L1.wallClock = function(self, c, x, y, t)
        __L1:r(
            c,
            x - 8,
            y - 8,
            16,
            16,
            "#3b3f43"
        )
        __L1:r(
            c,
            x - 7,
            y - 7,
            14,
            14,
            "#f4f1e6"
        )
        local a = t * 0.05
        local b = t * 0.6
        __L1:r(
            c,
            x,
            y,
            1,
            1,
            "#222"
        )
        do
            local i = 1
            while i < 5 do
                __L1:r(
                    c,
                    math.floor(x + math.sin(a) * i + 0.5),
                    math.floor(y - math.cos(a) * i + 0.5),
                    1,
                    1,
                    "#222"
                )
                i = i + 1
            end
        end
        do
            local i = 1
            while i < 6 do
                __L1:r(
                    c,
                    math.floor(x + math.sin(b) * i + 0.5),
                    math.floor(y - math.cos(b) * i + 0.5),
                    1,
                    1,
                    "#c0503e"
                )
                i = i + 1
            end
        end
    end
    __L1.wallDecor = function(self, c, scene, camera, t)
        local function vis(____, x, w)
            if w == nil then
                w = 60
            end
            return __gt(x + w, camera - 20) and __lt(x, camera + 980)
        end
        c:save()
        c:translate(
            -math.floor(camera + 0.5),
            0
        )
        if scene == 1 then
            do
                local i = 0
                while i < 12 do
                    do
                        local wx = 140 + i * 137
                        local gap = wx + 83
                        if wx >= 1750 then
                            break
                        end
                        local seed = i * 7 + 3
                        local ____t_24 = __t
                        local ____t_result_23
                        local ____t_22 = __t
                        local ____temp_21 = gap > 300 and gap < 500
                        __O[153] = ____temp_21
                        if ____t_22(____temp_21) then
                            ____t_result_23 = __O[153]
                        else
                            ____t_result_23 = gap > 960 and gap < 1130
                        end
                        if ____t_24(____t_result_23) then
                            do i = i + 1 continue end
                        end
                        if not __t(vis(nil, gap)) then
                            do i = i + 1 continue end
                        end
                        if __mod(i, 3) == 0 then
                            __L1:ac(c, gap + 14, 252)
                        elseif __mod(i, 3) == 1 then
                            __L1:poster(c, gap + 17, 292, seed)
                            if __t(__mod(i, 2)) then
                                __L1:poster(c, gap + 19, 262, seed + 1)
                            end
                        else
                            __L1:pipe(c, gap + 40, 237, 368)
                            if i == 5 then
                                __L1:wallClock(c, gap + 22, 262, t)
                            end
                        end
                        if __mod(i, 2) == 0 then
                            __L1:tag(c, gap + 6, 388, seed)
                        end
                        __L1:r(
                            c,
                            wx + 4,
                            346,
                            75,
                            1,
                            "#00000014"
                        )
                        do
                            local k = 0
                            while k < 4 do
                                __L1:r(
                                    c,
                                    wx + 12 + k * 19,
                                    346,
                                    1,
                                    10 + __mod(i + k, 3) * 6,
                                    "#20304018"
                                )
                                k = k + 1
                            end
                        end
                    end
                    i = i + 1
                end
            end
            if __t(vis(nil, 1800, 60)) then
                __L1:r(
                    c,
                    1812,
                    330,
                    12,
                    26,
                    "#c63c32"
                )
                __L1:r(
                    c,
                    1814,
                    326,
                    8,
                    4,
                    "#2a2a2a"
                )
                __L1:r(
                    c,
                    1815,
                    334,
                    6,
                    8,
                    "#f3ece0"
                )
            end
            do
                local x = 90
                while x < 1850 do
                    if __t(vis(nil, x, 320)) then
                        c.globalAlpha = 0.6
                        __L1:r(
                            c,
                            x,
                            232,
                            320,
                            1,
                            "#2a2a2a"
                        )
                        do
                            local k = 0
                            while k < 320 do
                                __L1:r(
                                    c,
                                    x + k,
                                    232 + math.floor(math.sin(k / 50) * 3 + 3 + 0.5),
                                    1,
                                    1,
                                    "#2a2a2a"
                                )
                                k = k + 8
                            end
                        end
                        c.globalAlpha = 1
                    end
                    x = x + 320
                end
            end
        end
        if scene == 9 then
            local width = __L1:worldWidth(9)
            do
                local x = 55
                local i = 0
                while x < width do
                    do
                        local gap = x + 101 + 18
                        if not __t(vis(nil, gap)) then
                            do do x = x + 187 i = i + 1 end continue end
                        end
                        if __mod(i, 3) == 0 then
                            __L1:ac(c, gap + 10, 232)
                        elseif __mod(i, 3) == 1 then
                            __L1:poster(c, gap + 14, 262, i + 2)
                        else
                            __L1:pipe(c, gap + 30, 221, 322)
                        end
                        if __t(__mod(i, 2)) then
                            __L1:tag(c, gap, 332, i)
                        end
                    end
                    do
                        x = x + 187
                        i = i + 1
                    end
                end
            end
        end
        if scene == 5 then
            local lo = math.floor((camera - 170) / 210)
            local hi = math.ceil((camera + 1180) / 210)
            do
                local i = lo
                while i < hi do
                    local x = i * 210
                    local yy = 272 + __mod(i, 2) * 29
                    local seed = math.abs(i + 100)
                    if __mod(seed, 2) == 0 then
                        __L1:dish(c, x + 150, yy - 22)
                    end
                    if __t(__mod(seed, 3) == 0 and not __t(__mod(
                        __mod(x + 120 - 870, 900) + 900,
                        900
                    ) < 132 or __mod(
                        __mod(x + 146 - 870, 900) + 900,
                        900
                    ) < 132)) then
                        __L1:ac(c, x + 120, yy + 14)
                    end
                    if __mod(seed, 3) == 1 then
                        __L1:planter(c, x + 16, yy + 64)
                    end
                    if __mod(seed, 4) == 2 then
                        do
                            local k = 0
                            while k < 6 do
                                do
                                    local j = 0
                                    while j < 3 do
                                        __L1:r(
                                            c,
                                            x + 60 + k * 9 + __mod(j, 2) * 4,
                                            yy + 86 + j * 6,
                                            8,
                                            5,
                                            __t(__mod(j, 2)) and "#9c4f36" or "#b5603f"
                                        )
                                        j = j + 1
                                    end
                                end
                                k = k + 1
                            end
                        end
                    end
                    if __mod(seed, 5) == 1 then
                        __L1:tag(
                            c,
                            x + 70,
                            yy + 122 - __mod(i, 2) * 29,
                            seed
                        )
                    end
                    if __mod(seed, 2) == 1 then
                        __L1:gasCan(
                            c,
                            x + 170,
                            yy + 148 - __mod(i, 2) * 29 + (__t(__mod(i, 2)) and 29 or 0) - 16
                        )
                    end
                    __L1:r(
                        c,
                        x + 4,
                        yy + 20,
                        2,
                        30,
                        "#3b3f43"
                    )
                    __L1:r(
                        c,
                        x + 3,
                        yy + 18,
                        4,
                        4,
                        "#565b60"
                    )
                    i = i + 1
                end
            end
        end
        if scene == 7 then
            do
                local x = 60
                while x < __L1:worldWidth(7) do
                    do
                        if not __t(vis(nil, x, 120)) then
                            do x = x + 520 continue end
                        end
                        local cols = __get(
                            __arrL(
                                {
                                    __arrL({"#21496c", "#f2c14e"}, 2),
                                    __arrL({"#c0392b", "#ffffff"}, 2),
                                    __arrL({"#2e7d32", "#fff3c4"}, 2)
                                },
                                3
                            ),
                            __mod(
                                __bor(x / 520, 0),
                                3
                            )
                        )
                        __L1:r(
                            c,
                            x,
                            300,
                            110,
                            22,
                            __get(cols, 0)
                        )
                        __L1:r(
                            c,
                            x + 4,
                            304,
                            102,
                            14,
                            __get(cols, 1)
                        )
                        __L1:r(
                            c,
                            x + 10,
                            308,
                            40,
                            6,
                            __get(cols, 0)
                        )
                        __L1:r(
                            c,
                            x + 56,
                            308,
                            44,
                            6,
                            __get(cols, 0)
                        )
                    end
                    x = x + 520
                end
            end
        end
        c:restore()
    end
    __L1.windowPerson = function(self, c, x, y, w, h, seed, t, hx, lean)
        local cx = x + w / 2
        local near = hx ~= nil and math.abs(hx - cx) < 140
        local dir = hx == nil and 0 or __TS__MathSign(hx - cx)
        local skin = __get(
            __L1.SKIN,
            __mod(
                seed,
                __len(__L1.SKIN)
            )
        )
        local shirt = __get(
            __L1.SHIRT,
            __mod(
                __shr(seed, 2),
                __len(__L1.SHIRT)
            )
        )
        local hair = __get(
            __arrL({
                "#1d1612",
                "#3b2a1e",
                "#6b4a2a",
                "#c9a050",
                "#1d1612"
            }, 5),
            __mod(
                __shr(seed, 1),
                5
            )
        )
        local bob = math.floor(math.sin(t * 1.7 + seed) * 1 + 0.5)
        local by = __add(y, h) - 2
        local head = by - 22 + bob - (__t(lean) and 4 or 0)
        __L1:r(
            c,
            cx - 9,
            by - 12 + bob,
            18,
            12,
            shirt
        )
        __L1:r(
            c,
            cx - 9,
            by - 12 + bob,
            18,
            2,
            "#ffffff22"
        )
        __L1:r(
            c,
            cx - 6,
            head,
            12,
            11,
            skin
        )
        __L1:r(
            c,
            cx - 7,
            head - 3,
            14,
            5,
            hair
        )
        if __mod(seed, 3) == 0 then
            __L1:r(
                c,
                cx - 7,
                head - 3,
                3,
                10,
                hair
            )
        end
        local ____t_result_25
        if __t(near) then
            ____t_result_25 = dir * 2
        else
            ____t_result_25 = math.floor(math.sin(t * 0.5 + seed) * 1.4 + 0.5)
        end
        local look = ____t_result_25
        __L1:r(
            c,
            cx - 3 + look,
            head + 4,
            2,
            2,
            "#1d1612"
        )
        __L1:r(
            c,
            cx + 2 + look,
            head + 4,
            2,
            2,
            "#1d1612"
        )
        if __t(near) then
            __L1:r(
                c,
                cx - 2 + look,
                head + 8,
                4,
                1,
                "#8a3a2a"
            )
            local wave = math.floor(math.sin(t * 12 + seed) * 3 + 0.5)
            local ax = cx + (dir >= 0 and 9 or -12)
            __L1:r(
                c,
                ax,
                by - 24 + bob + wave,
                3,
                12,
                shirt
            )
            __L1:r(
                c,
                ax - 1,
                by - 28 + bob + wave,
                5,
                5,
                skin
            )
        else
            __L1:r(
                c,
                cx - 1 + look,
                head + 8,
                3,
                1,
                "#8a5a4a"
            )
        end
    end
    __L1.liveBackground = function(self, c, scene, camera, t)
        local signs5 = __arrL({}, 0)
        if scene == 5 then
            do
                local x = 870
                while x < __L1:worldWidth(5) do
                    __call(signs5, "push", x)
                    x = x + 900
                end
            end
        end
        local ____opt_28 = window.SceneLife
        if ____opt_28 ~= nil then
            ____opt_28 = ____opt_28.hero
        end
        local ____opt_result_30
        if ____opt_28 ~= nil then
            ____opt_result_30 = ____opt_28(____opt_28)
        end
        local hero = ____opt_result_30
        local ____t_result_33
        local ____t_32 = __t
        local ____t_result_31
        if __t(hero) then
            ____t_result_31 = __isFiniteN(hero.x)
        else
            ____t_result_31 = hero
        end
        if ____t_32(____t_result_31) then
            ____t_result_33 = hero.x
        else
            ____t_result_33 = nil
        end
        local hx = ____t_result_33
        c:save()
        c:translate(
            -math.floor(camera + 0.5),
            0
        )
        local function vis(____, x, w)
            if w == nil then
                w = 100
            end
            return __gt(x + w, camera - 20) and __lt(x, camera + 980)
        end
        if scene == 1 then
            do
                local i = 0
                while i < 12 do
                    do
                        local x = 140 + i * 137
                        if __t(x >= 1750 or not __t(vis(nil, x))) then
                            do i = i + 1 continue end
                        end
                        local seed = i * 13 + 7
                        if __L1:hash(seed) < 0.5 then
                            do i = i + 1 continue end
                        end
                        c:save()
                        c:beginPath()
                        c:rect(x + 5, 272, 73, 68)
                        c:clip()
                        __L1:windowPerson(
                            c,
                            x + 5,
                            272,
                            34,
                            68,
                            seed,
                            t,
                            hx
                        )
                        c:restore()
                    end
                    i = i + 1
                end
            end
        end
        if scene == 9 then
            local width = __L1:worldWidth(9)
            do
                local x = 55
                local i = 0
                while x < width do
                    do
                        if not __t(vis(nil, x)) then
                            do do x = x + 187 i = i + 1 end continue end
                        end
                        local seed = i * 17 + 3
                        if __L1:hash(seed) < 0.45 then
                            do do x = x + 187 i = i + 1 end continue end
                        end
                        c:save()
                        c:beginPath()
                        c:rect(x + 5, 249, 91, 54)
                        c:clip()
                        __L1:windowPerson(
                            c,
                            x + 51,
                            249,
                            40,
                            54,
                            seed,
                            t,
                            hx
                        )
                        c:restore()
                    end
                    do
                        x = x + 187
                        i = i + 1
                    end
                end
            end
        end
        if scene == 5 then
            local lo = math.floor((camera - 170) / 210)
            local hi = math.ceil((camera + 1180) / 210)
            do
                local i = lo
                while i < hi do
                    do
                        local x = i * 210
                        local yy = 272 + __mod(i, 2) * 29
                        local seed = math.abs(i * 7 + 31)
                        if __L1:hash(seed) < 0.45 then
                            do i = i + 1 continue end
                        end
                        local wx = x + 13 + __mod(seed, 2) * (188 * 0.48)
                        local ww = math.min(30, 188 * 0.3)
                        local wh = math.min(
                            42,
                            163 - __mod(i, 2) * 29 - 27
                        )
                        if __t(__call(
                            signs5,
                            "some",
                            function(____, sx) return wx + ww > sx - 4 and wx < sx + 132 end
                        )) then
                            do i = i + 1 continue end
                        end
                        c:save()
                        c:beginPath()
                        c:rect(wx + 3, yy + 18 + 3, ww - 6, wh - 7)
                        c:clip()
                        __L1:windowPerson(
                            c,
                            wx + 3,
                            yy + 21,
                            ww - 6,
                            wh - 7,
                            seed,
                            t,
                            hx,
                            true
                        )
                        c:restore()
                    end
                    i = i + 1
                end
            end
        end
        c:restore()
        if __t(__call(
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
            local ph = __mod(t, 38) / 38
            if ph < 0.55 then
                local k = ph / 0.55
                local x = -80 + k * 1120
                local y = 58 + math.sin(scene) * 8
                c:save()
                c.globalAlpha = 0.55
                do
                    local i = 0
                    while i < 30 do
                        local tx = x - 14 - i * 9
                        if tx < -10 then
                            break
                        end
                        c.globalAlpha = 0.4 * (1 - i / 30)
                        __L1:r(
                            c,
                            tx,
                            y + 1,
                            9,
                            2,
                            "#ffffff"
                        )
                        i = i + 1
                    end
                end
                c:restore()
                __L1:r(
                    c,
                    x - 12,
                    y,
                    20,
                    3,
                    "#e9eef2"
                )
                __L1:r(
                    c,
                    x + 8,
                    y + 1,
                    3,
                    1,
                    "#9fb0bf"
                )
                __L1:r(
                    c,
                    x - 6,
                    y - 3,
                    6,
                    3,
                    "#c9d3dc"
                )
                __L1:r(
                    c,
                    x - 4,
                    y + 3,
                    8,
                    2,
                    "#b9c5cf"
                )
                __L1:r(
                    c,
                    x - 12,
                    y - 3,
                    3,
                    3,
                    "#c0503e"
                )
            end
            local pb = __mod(t, 23) / 23
            if pb < 0.6 then
                local k = pb / 0.6
                local bx = 1000 - k * 1150
                local by = 120 + math.sin(scene * 2) * 20
                do
                    local i = 0
                    while i < 7 do
                        local row = math.ceil(i / 2)
                        local side = __t(__mod(i, 2)) and 1 or -1
                        local x = bx + row * 11
                        local ____t_result_34
                        if __t(i) then
                            ____t_result_34 = side * row * 6
                        else
                            ____t_result_34 = 0
                        end
                        local y = by + ____t_result_34
                        local f = math.floor(math.sin(t * 10 + i) * 2 + 0.5)
                        __L1:r(
                            c,
                            x - 3,
                            y - f,
                            3,
                            1,
                            "#3d4f5a"
                        )
                        __L1:r(
                            c,
                            x,
                            y,
                            2,
                            1,
                            "#3d4f5a"
                        )
                        __L1:r(
                            c,
                            x + 2,
                            y - f,
                            3,
                            1,
                            "#3d4f5a"
                        )
                        i = i + 1
                    end
                end
            end
        end
    end
    __L1.sky = function(self, c, scene, camera, t)
        local ____t_40 = __t
        local ____t_result_39
        local ____t_38 = __t
        local ____t_result_37
        local ____t_36 = __t
        local ____temp_35 = scene == 2 or scene == 6
        __O[154] = ____temp_35
        if ____t_36(____temp_35) then
            ____t_result_37 = __O[154]
        else
            ____t_result_37 = scene == 8
        end
        __O[155] = ____t_result_37
        if ____t_38(____t_result_37) then
            ____t_result_39 = __O[155]
        else
            ____t_result_39 = scene == 10
        end
        if ____t_40(____t_result_39) then
            __L1:r(
                c,
                0,
                0,
                960,
                440,
                "#c9e7ec"
            )
            return
        end
        if __t(__L1.liteNow) then
            local ____temp_41
            if scene == 3 then
                ____temp_41 = __arrL({"#78a9d7", "#a7cbe4", "#d6e3dc"}, 3)
            else
                ____temp_41 = __arrL({"#74b8e7", "#96cef0", "#c9e7ec"}, 3)
            end
            local colors = ____temp_41
            __L1:r(
                c,
                0,
                0,
                960,
                120,
                __get(colors, 0)
            )
            __L1:r(
                c,
                0,
                120,
                960,
                120,
                __get(colors, 1)
            )
            __L1:r(
                c,
                0,
                240,
                960,
                200,
                __get(colors, 2)
            )
            local lx = scene == 3 and 762 or 734
            __L1:oval(
                c,
                lx - camera * 0.025,
                99,
                35,
                35,
                scene == 3 and "#fff0c4" or "#fff6cc",
                4
            )
            do
                local i = -1
                while i < 6 do
                    local x = __mod(i * 283 + t * 5 + 1800, 1800) - 283 - camera * 0.09
                    __L1:cloud(
                        c,
                        x,
                        50 + __L1:hash(i + 10) * 95,
                        0.8 + __L1:hash(i) * 0.6,
                        "#fffef5"
                    )
                    i = i + 1
                end
            end
            do
                local i = -2
                while i < 7 do
                    __L1:steppedHill(
                        c,
                        i * 318 - camera * 0.12,
                        197 + __L1:hash(i + 5) * 34,
                        422,
                        250,
                        scene == 3 and "#7eada0" or "#89b7a0"
                    )
                    i = i + 1
                end
            end
            do
                local i = -2
                while i < 8 do
                    __L1:steppedHill(
                        c,
                        i * 289 - camera * 0.25,
                        271 + __L1:hash(i + 21) * 25,
                        400,
                        190,
                        scene == 3 and "#5b937b" or "#64a068"
                    )
                    i = i + 1
                end
            end
            return
        end
        local mood = __L1:skyFor(scene)
        c:drawImage(
            __L1:ditherRamp(
                __add("sky-", mood),
                960,
                440,
                __get(__L1.SKIES, mood),
                2
            ),
            0,
            0
        )
        local sx = scene == 3 and 762 or 734
        local ____t_47 = __t
        local ____opt_44 = window.HdScene
        if ____opt_44 ~= nil then
            ____opt_44 = ____opt_44.sky
        end
        local ____opt_result_46
        if ____opt_44 ~= nil then
            ____opt_result_46 = ____opt_44(____opt_44, c, t, camera)
        end
        local hdSky = not not ____t_47(____opt_result_46)
        if not __t(hdSky) then
            __L1:sunGlow(c, sx - camera * 0.025, 99, mood == "golden" or mood == "afternoon")
        end
        do
            local range = __L1:farRange(scene)
            local off = __mod(
                __mod(camera * 0.05, 960) + 960,
                960
            )
            c:drawImage(
                range,
                __TS__Number(-off),
                150
            )
            c:drawImage(range, 960 - off, 150)
        end
        if not __t(hdSky) then
            __L1:oval(
                c,
                sx - camera * 0.025,
                99,
                35,
                35,
                scene == 3 and "#fff0c4" or "#fff6cc",
                4
            )
        end
        local ____t_53 = __t
        local ____t_result_52
        local ____t_51 = __t
        local ____t_result_50
        local ____t_49 = __t
        local ____temp_48 = scene == 1 or scene == 4
        __O[156] = ____temp_48
        if ____t_49(____temp_48) then
            ____t_result_50 = __O[156]
        else
            ____t_result_50 = scene == 7
        end
        __O[157] = ____t_result_50
        if ____t_51(____t_result_50) then
            ____t_result_52 = __O[157]
        else
            ____t_result_52 = scene == 9
        end
        if ____t_53(____t_result_52) then
            local sk = __L1:skyline(scene)
            local o = __mod(
                __mod(camera * 0.1, 1920) + 1920,
                1920
            )
            local sy = scene == 4 and 118 or (scene == 7 and 10 or (scene == 9 and 17 or 46))
            c:drawImage(
                sk,
                __TS__Number(-o),
                sy
            )
            c:drawImage(sk, 1920 - o, sy)
        end
        if scene == 5 then
            local fh = __L1:favelaHill()
            local o = __mod(
                __mod(camera * 0.08, 1920) + 1920,
                1920
            )
            c:drawImage(
                fh,
                __TS__Number(-o),
                40
            )
            c:drawImage(fh, 1920 - o, 40)
        end
        do
            local i = -1
            while i < 6 do
                local x = __mod(i * 283 + t * 5 + 1800, 1800) - 283 - camera * 0.09
                __L1:cloud(
                    c,
                    x,
                    50 + __L1:hash(i + 10) * 95,
                    0.8 + __L1:hash(i) * 0.6,
                    "#fffef5"
                )
                i = i + 1
            end
        end
        do
            local i = -2
            while i < 7 do
                local hx = i * 318 - camera * 0.12
                local hy = 197 + __L1:hash(i + 5) * 34
                __L1:steppedHill(
                    c,
                    hx,
                    hy,
                    422,
                    250,
                    scene == 3 and "#7eada0" or "#89b7a0"
                )
                if __t(hx > -430 and hx < 960) then
                    __L1:hillDetail(
                        c,
                        hx,
                        hy,
                        422,
                        false,
                        i + math.floor(camera * 0.12 / 318) * 0
                    )
                end
                i = i + 1
            end
        end
        do
            local i = -2
            while i < 8 do
                local hx = i * 289 - camera * 0.25
                local hy = 271 + __L1:hash(i + 21) * 25
                __L1:steppedHill(
                    c,
                    hx,
                    hy,
                    400,
                    190,
                    scene == 3 and "#5b937b" or "#64a068"
                )
                if __t(hx > -410 and hx < 960) then
                    __L1:hillDetail(
                        c,
                        hx,
                        hy,
                        400,
                        true,
                        i + 40
                    )
                end
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 7 do
                local x = __mod(
                    __mod(i * 179 - camera * 0.16 + t * 15, 1200) + 1200,
                    1200
                ) - 80
                local y = 90 + __L1:hash(i + 77) * 80
                local flap = math.floor(math.sin(t * 9 + i) * 3 + 0.5)
                __L1:r(
                    c,
                    x,
                    y,
                    3,
                    2,
                    "#4b6b73"
                )
                __L1:r(
                    c,
                    x - 4,
                    y - 2 + flap,
                    4,
                    2,
                    "#4b6b73"
                )
                __L1:r(
                    c,
                    x + 3,
                    y - 2 + flap,
                    4,
                    2,
                    "#4b6b73"
                )
                i = i + 1
            end
        end
    end
    __L1.tree = function(self, c, x, y, s, kind)
        if s == nil then
            s = 1
        end
        if kind == nil then
            kind = 0
        end
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        c:scale(s, s)
        if kind == 1 then
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({-5, 0}, 2),
                        __arrL({5, 0}, 2),
                        __arrL({12, -83}, 2),
                        __arrL({2, -83}, 2)
                    },
                    4
                ),
                "#79553b"
            )
            __L1:r(
                c,
                4,
                -78,
                6,
                28,
                "#98704b"
            )
            do
                local sw = math.floor(__L1:windAt(__L1:screenX(c, 0)) * 2.2 + 0.5)
                c:translate(
                    sw,
                    math.abs(sw) > 1 and 1 or 0
                )
            end
            do
                local i = 0
                while i < 7 do
                    local a = -math.pi + i * 0.48 + math.sin(__L1.animT * 1.7 + i) * 0.03
                    local ex = math.cos(a) * 61
                    local ey = -97 + math.sin(a) * 27
                    __L1:poly(
                        c,
                        __arrL(
                            {
                                __arrL({7, -84}, 2),
                                __arrL({ex, ey}, 2),
                                __arrL({ex + 13, ey + 12}, 2),
                                __arrL({15, -75}, 2)
                            },
                            4
                        ),
                        __t(__mod(i, 2)) and "#367c42" or "#64a147"
                    )
                    i = i + 1
                end
            end
            __L1:r(
                c,
                -4,
                -91,
                13,
                11,
                "#334f36"
            )
            __L1:r(
                c,
                6,
                -86,
                9,
                10,
                "#817744"
            )
        else
            __L1:r(
                c,
                -8,
                -104,
                17,
                104,
                "#674c36"
            )
            __L1:r(
                c,
                2,
                -91,
                7,
                91,
                "#896241"
            )
            __L1:r(
                c,
                -17,
                -62,
                13,
                10,
                "#674c36"
            )
            __L1:r(
                c,
                -22,
                -80,
                7,
                25,
                "#674c36"
            )
            __L1:r(
                c,
                7,
                -78,
                18,
                8,
                "#674c36"
            )
            __L1:r(
                c,
                21,
                -100,
                7,
                25,
                "#674c36"
            )
            do
                local sw = math.floor(__L1:windAt(__L1:screenX(c, 0)) * 1.6 + 0.5)
                c:translate(sw, 0)
            end
            __L1:oval(
                c,
                0,
                -127,
                64,
                51,
                "#285a38",
                4
            )
            __L1:oval(
                c,
                -27,
                -122,
                45,
                35,
                "#3b7c43",
                4
            )
            __L1:oval(
                c,
                26,
                -141,
                47,
                35,
                "#4c8b43",
                4
            )
            __L1:oval(
                c,
                -5,
                -160,
                40,
                23,
                "#6ba346",
                4
            )
            __L1:oval(
                c,
                -35,
                -145,
                24,
                21,
                "#88b54e",
                4
            )
            do
                local i = 0
                while i < 35 do
                    local xx = (__L1:hash(i + 6) - 0.5) * 103
                    local yy = -169 + __L1:hash(i + 30) * 67
                    __L1:r(
                        c,
                        xx,
                        yy,
                        6 + __L1:hash(i) * 8,
                        3,
                        __t(__mod(i, 3)) and "#7fac42" or "#2c633b"
                    )
                    i = i + 1
                end
            end
            do
                local i = 0
                while i < 6 do
                    __L1:r(
                        c,
                        (__L1:hash(i + 93) - 0.5) * 85,
                        -147 + __L1:hash(i + 6) * 53,
                        5,
                        5,
                        "#c9924e"
                    )
                    i = i + 1
                end
            end
        end
        c:restore()
    end
    __L1.bush = function(self, c, x, y, w, color)
        if w == nil then
            w = 46
        end
        if color == nil then
            color = "#4e7440"
        end
        __L1:oval(
            c,
            x,
            y - 10,
            w / 2,
            18,
            "#344e37",
            3
        )
        __L1:oval(
            c,
            x - 5,
            y - 17,
            w / 2 - 4,
            16,
            color,
            3
        )
        do
            local i = 0
            while i < 6 do
                __L1:r(
                    c,
                    x - w / 2 + __L1:hash(i + 2) * w,
                    y - 28 + __L1:hash(i + 3) * 20,
                    5,
                    3,
                    "#86a153"
                )
                i = i + 1
            end
        end
    end
    __L1.fence = function(self, c, x, y, w)
        __L1:r(
            c,
            x,
            y - 32,
            w,
            7,
            "#6c6945"
        )
        __L1:r(
            c,
            x,
            y - 16,
            w,
            6,
            "#6c6945"
        )
        __L1:r(
            c,
            x,
            y - 33,
            w,
            3,
            "#b7ab70"
        )
        do
            local xx = x
            while __lt(
                xx,
                __add(x, w)
            ) do
                __L1:r(
                    c,
                    xx,
                    y - 47,
                    8,
                    47,
                    "#756c48"
                )
                __L1:r(
                    c,
                    xx,
                    y - 49,
                    7,
                    4,
                    "#c1ae76"
                )
                __L1:r(
                    c,
                    xx + 2,
                    y - 45,
                    2,
                    39,
                    "#a38e5e"
                )
                xx = xx + 33
            end
        end
    end
    __L1.grass = function(self, c, x, y, seed)
        if seed == nil then
            seed = 1
        end
        local w = __L1:windAt(__L1:screenX(c, x))
        do
            local i = 0
            while i < 5 do
                local xx = x + i * 4
                local h = 5 + __L1:hash(i + seed) * 8
                local col = __t(__mod(i, 2)) and "#7dad42" or "#3e863d"
                local lean = math.floor(w * (1.4 + h * 0.18) + math.sin(__L1.animT * 3.1 + i + seed) * 0.4 + 0.5)
                __L1:r(
                    c,
                    xx,
                    y - h * 0.5 + 1,
                    3,
                    h * 0.5,
                    col
                )
                __L1:r(
                    c,
                    xx + math.floor(lean * 0.5 + 0.5),
                    y - h * 0.75 + 1,
                    3,
                    h * 0.3,
                    col
                )
                __L1:r(
                    c,
                    xx + lean,
                    y - h - __L1:hash(i + seed) * 1 + 1,
                    2,
                    h * 0.3,
                    __t(__mod(i, 2)) and "#a6c95a" or "#58a046"
                )
                i = i + 1
            end
        end
    end
    __L1.flower = function(self, c, x, y, col)
        if col == nil then
            col = "#f1c966"
        end
        local w = math.floor(__L1:windAt(__L1:screenX(c, x)) * 2 + 0.5)
        __L1:r(
            c,
            x,
            y - 5,
            2,
            7,
            "#456841"
        )
        __L1:r(
            c,
            x + math.floor(w / 2 + 0.5),
            y - 11,
            2,
            7,
            "#456841"
        )
        __L1:r(
            c,
            x - 3 + w,
            y - 13,
            8,
            4,
            col
        )
        __L1:r(
            c,
            x - 1 + w,
            y - 15,
            4,
            8,
            col
        )
        __L1:r(
            c,
            x + w,
            y - 12,
            2,
            2,
            "#ad6c3e"
        )
    end
    __L1.house = function(self, c, x, y)
        __L1:r(
            c,
            x - 6,
            y - 101,
            194,
            101,
            "#795846"
        )
        __L1:r(
            c,
            x,
            y - 112,
            182,
            112,
            "#efd5a0"
        )
        __L1:r(
            c,
            x,
            y - 27,
            182,
            27,
            "#d1ad79"
        )
        __L1:r(
            c,
            x + 8,
            y - 105,
            166,
            5,
            "#fff0bd"
        )
        __L1:poly(
            c,
            __arrL(
                {
                    __arrL({x - 19, y - 110}, 2),
                    __arrL({x + 16, y - 154}, 2),
                    __arrL({x + 152, y - 154}, 2),
                    __arrL({x + 202, y - 110}, 2)
                },
                4
            ),
            "#653e36"
        )
        do
            local row = 0
            while row < 4 do
                local start = x + 15 - row * 10
                local ____end = x + 151 + row * 13
                local yy = y - 150 + row * 10
                __L1:r(
                    c,
                    start,
                    yy,
                    ____end - start,
                    9,
                    __t(__mod(row, 2)) and "#c96545" or "#d9774d"
                )
                do
                    local xx = start
                    while __lt(xx, ____end) do
                        __L1:r(
                            c,
                            xx,
                            yy,
                            2,
                            8,
                            "#f0a56d"
                        )
                        xx = xx + 22
                    end
                end
                __L1:r(
                    c,
                    start,
                    yy + 8,
                    ____end - start,
                    2,
                    "#8f4739"
                )
                row = row + 1
            end
        end
        __L1:r(
            c,
            x - 22,
            y - 114,
            228,
            8,
            "#7b4737"
        )
        __L1:r(
            c,
            x - 18,
            y - 114,
            221,
            3,
            "#d18b59"
        )
        __L1:r(
            c,
            x + 74,
            y - 71,
            39,
            71,
            "#886641"
        )
        __L1:r(
            c,
            x + 79,
            y - 66,
            29,
            66,
            "#5c5140"
        )
        __L1:r(
            c,
            x + 82,
            y - 63,
            23,
            62,
            "#655d49"
        )
        __L1:r(
            c,
            x + 100,
            y - 32,
            4,
            4,
            "#e4ba73"
        )
        for ____, xx in __iterar((__arrL({x + 15, x + 132}, 2))) do
            __L1:r(
                c,
                xx,
                y - 81,
                38,
                39,
                "#ac7c52"
            )
            __L1:r(
                c,
                xx + 4,
                y - 77,
                30,
                31,
                "#536a62"
            )
            __L1:r(
                c,
                xx + 6,
                y - 74,
                12,
                12,
                "#8ba397"
            )
            __L1:r(
                c,
                xx + 20,
                y - 59,
                10,
                10,
                "#6e8b7f"
            )
            __L1:r(
                c,
                xx + 16,
                y - 77,
                3,
                31,
                "#c19969"
            )
            __L1:r(
                c,
                xx + 4,
                y - 63,
                30,
                3,
                "#c19969"
            )
            __L1:r(
                c,
                xx - 4,
                y - 40,
                46,
                5,
                "#b68657"
            )
        end
        __L1:r(
            c,
            x + 65,
            y - 2,
            57,
            5,
            "#bba27a"
        )
        __L1:r(
            c,
            x + 62,
            y + 3,
            63,
            5,
            "#d5bc86"
        )
        __L1:r(
            c,
            x + 145,
            y - 10,
            23,
            13,
            "#b05e40"
        )
        __L1:r(
            c,
            x + 142,
            y - 15,
            29,
            6,
            "#cf8253"
        )
        __L1:grass(c, x + 145, y - 15, 4)
        __L1:flower(c, x + 153, y - 26, "#e7ae62")
        __L1:r(
            c,
            x + 24,
            y - 128,
            50,
            13,
            "#573c31"
        )
        c.fillStyle = "#f3d595"
        c.font = "bold 8px monospace"
        c:fillText("DO SAPO", x + 29, y - 118)
        __L1:r(
            c,
            x + 153,
            y - 175,
            17,
            27,
            "#9a6647"
        )
        __L1:r(
            c,
            x + 150,
            y - 177,
            23,
            6,
            "#bf9367"
        )
    end
    __L1.ground = function(self, c, camera, scene)
        local farm = scene == 0
        local gym = scene == 2
        if __ge(scene, 4) then
            local palettes = {
                ["4"] = __arrL({"#aeb8b5", "#e0ded0", "#899c9b"}, 3),
                ["5"] = __arrL({"#887f7a", "#a6a49a", "#625c5c"}, 3),
                ["6"] = __arrL({"#6b577e", "#d9c4df", "#4d3c64"}, 3),
                ["7"] = __arrL({"#448646", "#a9cc70", "#2e623c"}, 3),
                ["8"] = __arrL({"#af9576", "#f6dec0", "#725b4a"}, 3),
                ["9"] = __arrL({"#c3ccca", "#f2f3df", "#9aaeb0"}, 3),
                ["10"] = __arrL({"#ab805b", "#f0d9b0", "#856747"}, 3)
            }
            local ____t_result_56
            local ____t_55 = __t
            local ____get_result_54 = __get(palettes, scene)
            __O[158] = ____get_result_54
            if ____t_55(____get_result_54) then
                ____t_result_56 = __O[158]
            else
                ____t_result_56 = __get(palettes, 4)
            end
            local p = ____t_result_56
            __L1:r(
                c,
                0,
                440,
                960,
                100,
                __get(p, 0)
            )
            __L1:r(
                c,
                0,
                440,
                960,
                6,
                __get(p, 1)
            )
            do
                local i = math.floor(camera / 53)
                while i < (camera + 960) / 53 do
                    local x = i * 53 - camera
                    __L1:r(
                        c,
                        x,
                        449,
                        1,
                        91,
                        __get(p, 2)
                    )
                    __L1:r(
                        c,
                        x + 5,
                        468 + __L1:hash(i) * 52,
                        22,
                        2,
                        __get(p, 2)
                    )
                    if scene == 7 then
                        __L1:grass(c, x + 15, 450, i)
                    end
                    i = i + 1
                end
            end
            __L1:r(
                c,
                0,
                498,
                960,
                1,
                __get(p, 2)
            )
            return
        end
        __L1:r(
            c,
            0,
            440,
            960,
            100,
            __t(farm) and "#a17349" or (__t(gym) and "#554b48" or "#97856e")
        )
        if __t(farm) then
            __L1:r(
                c,
                0,
                440,
                960,
                9,
                "#3f7f35"
            )
            __L1:r(
                c,
                0,
                440,
                960,
                4,
                "#9fc84d"
            )
            __L1:r(
                c,
                0,
                449,
                960,
                7,
                "#736a3a"
            )
            do
                local i = math.floor(camera / 17)
                while i < (camera + 960) / 17 do
                    local x = i * 17 - camera
                    __L1:r(
                        c,
                        x,
                        451 + __L1:hash(i) * 5,
                        7,
                        4,
                        "#b68b54"
                    )
                    i = i + 1
                end
            end
        else
            __L1:r(
                c,
                0,
                440,
                960,
                7,
                __t(gym) and "#8f8170" or "#c4b08a"
            )
            __L1:r(
                c,
                0,
                447,
                960,
                4,
                "#655c4d"
            )
        end
        do
            local i = math.floor(camera / 23)
            while i < (camera + 960) / 23 do
                local x = i * 23 - camera
                local y = 460 + __L1:hash(i + 4) * 75
                __L1:r(
                    c,
                    x,
                    y,
                    3 + __L1:hash(i + 5) * 10,
                    3,
                    scene == 2 and "#655956" or (__t(farm) and "#bb8c56" or "#a8977b")
                )
                if __mod(i, 3) == 0 then
                    __L1:r(
                        c,
                        x + 8,
                        y + 8,
                        3,
                        3,
                        "#756342"
                    )
                end
                i = i + 1
            end
        end
        if not __t(farm) then
            do
                local x = __mod(
                    __TS__Number(-camera),
                    96
                )
                while x < 960 do
                    __L1:r(
                        c,
                        x,
                        452,
                        1,
                        88,
                        scene == 2 and "#4c4240" or "#817460"
                    )
                    x = x + 96
                end
            end
            __L1:r(
                c,
                0,
                498,
                960,
                1,
                scene == 2 and "#4c4240" or "#817460"
            )
        end
    end
    __L1.farm = function(self, c, camera, t)
        c:save()
        c:translate(
            -math.floor(camera + 0.5),
            0
        )
        __L1:r(
            c,
            0,
            368,
            __L1:worldWidth(0),
            72,
            "#68a34b"
        )
        __L1:r(
            c,
            0,
            387,
            __L1:worldWidth(0),
            53,
            "#80b751"
        )
        __L1:fence(c, 0, 423, 112)
        __L1:fence(c, 332, 423, 315)
        __L1:fence(c, 786, 423, 214)
        __L1:fence(c, 1080, 423, 420)
        __L1:fence(c, 1570, 423, 680)
        __L1:tree(c, 53, 425, 1.25)
        __L1:tree(
            c,
            535,
            424,
            0.78,
            1
        )
        __L1:tree(c, 795, 425, 1.12)
        __L1:tree(
            c,
            1390,
            427,
            1.2,
            1
        )
        __L1:tree(c, 1810, 428, 1.2)
        __L1:tree(c, 2440, 430, 1.3)
        __L1:house(c, 132, 429)
        __L1:r(
            c,
            350,
            363,
            5,
            63,
            "#79664a"
        )
        __L1:r(
            c,
            487,
            357,
            5,
            69,
            "#79664a"
        )
        __L1:r(
            c,
            351,
            364,
            139,
            2,
            "#706246"
        )
        do
            local i = 0
            while i < 4 do
                local x = 366 + i * 29
                local wave = math.floor(math.sin(t * 3 + i) * 4 + 0.5)
                __L1:poly(
                    c,
                    __arrL(
                        {
                            __arrL({x, 365}, 2),
                            __arrL({x + 20, 365}, 2),
                            __arrL({x + 23 + wave, 389}, 2),
                            __arrL({x - 2 + wave, 389}, 2)
                        },
                        4
                    ),
                    __get(
                        __arrL({"#f0c27c", "#74afb9", "#d57555", "#f2dda2"}, 4),
                        i
                    )
                )
                __L1:r(
                    c,
                    x + 2,
                    365,
                    2,
                    4,
                    "#5e6141"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 22 do
                local x = 935 + i * 17
                local yy = 422 + __mod(i, 2) * 8
                local wave = math.floor(math.sin(t * 2 + i * 0.2) * 2 + 0.5)
                __L1:r(
                    c,
                    x,
                    yy - 36,
                    3,
                    36,
                    "#497f38"
                )
                __L1:poly(
                    c,
                    __arrL(
                        {
                            __arrL({x, yy - 18}, 2),
                            __arrL({x - 12 + wave, yy - 29}, 2),
                            __arrL({x - 16 + wave, yy - 26}, 2),
                            __arrL({x, yy - 9}, 2)
                        },
                        4
                    ),
                    "#438a39"
                )
                __L1:poly(
                    c,
                    __arrL(
                        {
                            __arrL({x + 2, yy - 23}, 2),
                            __arrL({x + 13 + wave, yy - 35}, 2),
                            __arrL({x + 17 + wave, yy - 29}, 2),
                            __arrL({x + 3, yy - 15}, 2)
                        },
                        4
                    ),
                    "#8bbb42"
                )
                __L1:r(
                    c,
                    x - 2,
                    yy - 34,
                    7,
                    17,
                    "#e7c94c"
                )
                __L1:r(
                    c,
                    x - 1,
                    yy - 37,
                    4,
                    5,
                    "#ffe17a"
                )
                __L1:r(
                    c,
                    x,
                    yy - 31,
                    2,
                    11,
                    "#f6df69"
                )
                i = i + 1
            end
        end
        __L1:r(
            c,
            1970,
            400,
            155,
            39,
            "#665b3e"
        )
        do
            local i = 0
            while i < 6 do
                __L1:r(
                    c,
                    1974 + i * 25,
                    404,
                    19,
                    33,
                    "#a27a49"
                )
                __L1:r(
                    c,
                    1974 + i * 25,
                    408,
                    19,
                    2,
                    "#d3a960"
                )
                i = i + 1
            end
        end
        __L1:r(
            c,
            1967,
            396,
            161,
            7,
            "#d0a96c"
        )
        __L1:r(
            c,
            660,
            375,
            7,
            65,
            "#6a583d"
        )
        __L1:r(
            c,
            627,
            370,
            79,
            23,
            "#72543b"
        )
        __L1:r(
            c,
            630,
            372,
            73,
            17,
            "#c6ab70"
        )
        c.fillStyle = "#4c4c36"
        c.font = "bold 10px monospace"
        c:fillText("ITABUNA →", 632, 384)
        do
            local i = 0
            while i < 75 do
                do
                    local x = __L1:hash(i + 67) * 2600
                    local y = 426 + __L1:hash(i + 44) * 12
                    if __t(x > 115 and x < 330) then
                        do i = i + 1 continue end
                    end
                    __L1:grass(c, x, y, i)
                    if __mod(i, 5) == 0 then
                        __L1:flower(
                            c,
                            x + 5,
                            y,
                            __get(
                                __arrL({"#efcf71", "#e3a67d", "#f4df9a"}, 3),
                                __mod(i, 3)
                            )
                        )
                    end
                end
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 8 do
                local x = 390 + i * 280 + math.sin(t * 0.8 + i) * 27
                local y = 351 + math.sin(t * 1.6 + i * 3) * 17
                local w = math.abs(math.sin(t * 9 + i)) * 4 + 1
                __L1:r(
                    c,
                    x - w - 1,
                    y - 2,
                    w,
                    4,
                    __t(__mod(i, 2)) and "#f0ce60" or "#e9a66d"
                )
                __L1:r(
                    c,
                    x + 1,
                    y - 2,
                    w,
                    4,
                    __t(__mod(i, 2)) and "#ffe5a1" or "#f5bf8c"
                )
                __L1:r(
                    c,
                    x,
                    y - 2,
                    1,
                    5,
                    "#4b6240"
                )
                i = i + 1
            end
        end
        c:restore()
    end
    __L1.school = function(self, c, camera, t)
        c:save()
        c:translate(
            -math.floor(camera + 0.5),
            0
        )
        __L1:r(
            c,
            0,
            392,
            __L1:worldWidth(1),
            48,
            "#b6b18a"
        )
        __L1:r(
            c,
            90,
            225,
            1760,
            215,
            "#173755"
        )
        __L1:r(
            c,
            100,
            222,
            1740,
            207,
            "#eef3f4"
        )
        __L1:r(
            c,
            90,
            215,
            1760,
            14,
            "#183a5e"
        )
        __L1:r(
            c,
            100,
            229,
            1740,
            8,
            "#ffffff"
        )
        __L1:r(
            c,
            100,
            368,
            1740,
            60,
            "#244a70"
        )
        __L1:r(
            c,
            100,
            368,
            1740,
            5,
            "#132d4a"
        )
        do
            local i = 0
            while i < 12 do
                local x = 140 + i * 137
                __L1:r(
                    c,
                    x,
                    267,
                    83,
                    78,
                    "#466c86"
                )
                __L1:r(
                    c,
                    x + 5,
                    272,
                    73,
                    68,
                    "#415e60"
                )
                __L1:r(
                    c,
                    x + 8,
                    275,
                    31,
                    29,
                    "#8faaa0"
                )
                __L1:r(
                    c,
                    x + 45,
                    309,
                    29,
                    27,
                    "#688b83"
                )
                __L1:r(
                    c,
                    x + 39,
                    272,
                    5,
                    68,
                    "#d7e7ec"
                )
                __L1:r(
                    c,
                    x + 5,
                    304,
                    73,
                    5,
                    "#d7e7ec"
                )
                __L1:r(
                    c,
                    x - 3,
                    345,
                    89,
                    7,
                    "#c7d9e0"
                )
                i = i + 1
            end
        end
        __L1:r(
            c,
            343,
            293,
            75,
            135,
            "#8f7657"
        )
        __L1:r(
            c,
            349,
            298,
            63,
            130,
            "#526661"
        )
        __L1:r(
            c,
            354,
            304,
            22,
            85,
            "#6e8980"
        )
        __L1:r(
            c,
            382,
            304,
            23,
            85,
            "#5e7770"
        )
        __L1:r(
            c,
            378,
            297,
            5,
            131,
            "#b49d75"
        )
        __L1:r(
            c,
            371,
            362,
            4,
            4,
            "#efd49a"
        )
        __L1:r(
            c,
            278,
            243,
            209,
            29,
            "#183c62"
        )
        c.fillStyle = "#f8fbfc"
        c.font = "bold 15px monospace"
        c:fillText("COLÉGIO ADVENTISTA", 291, 263)
        __L1:r(
            c,
            280,
            272,
            205,
            3,
            "#7fb4cf"
        )
        do
            local x = 120
            while x < 1840 do
                __L1:r(
                    c,
                    x,
                    237,
                    12,
                    192,
                    "#b3cbd8"
                )
                __L1:r(
                    c,
                    x + 2,
                    237,
                    3,
                    191,
                    "#f9fcff"
                )
                x = x + 275
            end
        end
        __L1:r(
            c,
            1885,
            280,
            423,
            153,
            "#d3c69a"
        )
        __L1:r(
            c,
            1885,
            280,
            423,
            8,
            "#867b5e"
        )
        do
            local j = 0
            while j < 4 do
                do
                    local i = 0
                    while i < 8 do
                        __L1:r(
                            c,
                            1892 + i * 51 + __mod(j, 2) * 23,
                            294 + j * 33,
                            42,
                            1,
                            "#b7a981"
                        )
                        i = i + 1
                    end
                end
                j = j + 1
            end
        end
        c.fillStyle = "#52766b"
        c.font = "bold 24px monospace"
        c:fillText("BEM-VINDOS", 1957, 345)
        c.fillStyle = "#b27857"
        c.font = "bold 11px monospace"
        c:fillText("AQUI ATÉ A PAREDE TEM HISTÓRIA.", 1923, 370)
        do
            local i = 0
            while i < 7 do
                local x = 620 + i * 210
                __L1:r(
                    c,
                    x,
                    409,
                    68,
                    9,
                    "#7a6148"
                )
                __L1:r(
                    c,
                    x + 6,
                    417,
                    7,
                    23,
                    "#58604b"
                )
                __L1:r(
                    c,
                    x + 54,
                    417,
                    7,
                    23,
                    "#58604b"
                )
                __L1:r(
                    c,
                    x,
                    386,
                    68,
                    7,
                    "#a58859"
                )
                __L1:r(
                    c,
                    x,
                    398,
                    68,
                    7,
                    "#a58859"
                )
                __L1:r(
                    c,
                    x + 5,
                    387,
                    5,
                    24,
                    "#6b6248"
                )
                __L1:r(
                    c,
                    x + 58,
                    387,
                    5,
                    24,
                    "#6b6248"
                )
                i = i + 1
            end
        end
        __L1:r(
            c,
            976,
            311,
            29,
            122,
            "#b9aa85"
        )
        __L1:r(
            c,
            976,
            311,
            8,
            122,
            "#f0dfb0"
        )
        __L1:r(
            c,
            984,
            317,
            20,
            111,
            "#dcc99b"
        )
        __L1:r(
            c,
            974,
            307,
            34,
            8,
            "#8f8c70"
        )
        __L1:r(
            c,
            976,
            398,
            29,
            35,
            "#ad7153"
        )
        __L1:r(
            c,
            986,
            326,
            11,
            1,
            "#b6a67f"
        )
        __L1:r(
            c,
            986,
            350,
            11,
            1,
            "#b6a67f"
        )
        __L1:r(
            c,
            986,
            375,
            11,
            1,
            "#b6a67f"
        )
        __L1:r(
            c,
            1012,
            322,
            108,
            59,
            "#6f8a72"
        )
        __L1:r(
            c,
            1016,
            326,
            100,
            51,
            "#e2d9ae"
        )
        c.fillStyle = "#54735f"
        c.font = "bold 8px monospace"
        c:fillText("A PAREDE ESCUTA", 1022, 341)
        c:fillText("MAIS DO QUE FALA.", 1020, 355)
        __L1:r(
            c,
            1059,
            361,
            10,
            2,
            "#8c9b6b"
        )
        __L1:tree(c, 40, 435, 0.9)
        __L1:tree(c, 2380, 435, 1.1)
        __L1:bush(c, 2320, 435, 90)
        __L1:bush(c, 65, 435, 56)
        __L1:r(
            c,
            1665,
            399,
            27,
            38,
            "#54735b"
        )
        __L1:r(
            c,
            1661,
            394,
            35,
            8,
            "#73906a"
        )
        __L1:r(
            c,
            1669,
            405,
            3,
            26,
            "#a3ad79"
        )
        c:restore()
    end
    __L1.gym = function(self, c, camera, t)
        __L1:r(
            c,
            0,
            0,
            960,
            440,
            "#3f5654"
        )
        __L1:r(
            c,
            0,
            0,
            960,
            28,
            "#293e3e"
        )
        __L1:r(
            c,
            0,
            28,
            960,
            8,
            "#71806c"
        )
        c:save()
        c:translate(
            -math.floor(camera + 0.5),
            0
        )
        do
            local i = 0
            while i < math.ceil(__L1:worldWidth(2) / 280) do
                local x = i * 280 + 46
                __L1:r(
                    c,
                    x,
                    65,
                    176,
                    181,
                    "#2a4141"
                )
                __L1:r(
                    c,
                    x + 6,
                    71,
                    164,
                    168,
                    "#d4be8f"
                )
                __L1:r(
                    c,
                    x + 12,
                    78,
                    152,
                    154,
                    "#9da98b"
                )
                __L1:r(
                    c,
                    x + 83,
                    73,
                    6,
                    164,
                    "#536b61"
                )
                __L1:r(
                    c,
                    x + 7,
                    148,
                    164,
                    6,
                    "#536b61"
                )
                __L1:r(
                    c,
                    x + 12,
                    77,
                    63,
                    62,
                    "#dbd19f"
                )
                __L1:r(
                    c,
                    x + 95,
                    156,
                    65,
                    70,
                    "#829b82"
                )
                __L1:r(
                    c,
                    x + 52,
                    27,
                    3,
                    24,
                    "#272f30"
                )
                __L1:r(
                    c,
                    x + 28,
                    50,
                    55,
                    7,
                    "#e1c78c"
                )
                __L1:r(
                    c,
                    x + 34,
                    57,
                    43,
                    5,
                    "#ffe5a1"
                )
                i = i + 1
            end
        end
        __L1:r(
            c,
            0,
            268,
            __L1:worldWidth(2),
            172,
            "#546960"
        )
        __L1:r(
            c,
            0,
            268,
            __L1:worldWidth(2),
            7,
            "#a19874"
        )
        __L1:r(
            c,
            0,
            415,
            __L1:worldWidth(2),
            25,
            "#30463e"
        )
        do
            local i = 0
            while i < math.ceil(__L1:worldWidth(2) / 565) do
                local x = 90 + i * 565
                __L1:r(
                    c,
                    x,
                    290,
                    168,
                    97,
                    "#879c8a"
                )
                __L1:r(
                    c,
                    x + 5,
                    295,
                    158,
                    87,
                    "#6d8580"
                )
                __L1:r(
                    c,
                    x + 8,
                    298,
                    71,
                    81,
                    "#78958c"
                )
                __L1:poly(
                    c,
                    __arrL(
                        {
                            __arrL({x + 18, 376}, 2),
                            __arrL({x + 81, 300}, 2),
                            __arrL({x + 106, 300}, 2),
                            __arrL({x + 41, 376}, 2)
                        },
                        4
                    ),
                    "#8aa699"
                )
                __L1:r(
                    c,
                    x + 81,
                    294,
                    4,
                    89,
                    "#a6af98"
                )
                __L1:r(
                    c,
                    x - 12,
                    369,
                    6,
                    71,
                    "#263d3b"
                )
                __L1:r(
                    c,
                    x + 176,
                    369,
                    6,
                    71,
                    "#263d3b"
                )
                __L1:r(
                    c,
                    x - 15,
                    376,
                    200,
                    5,
                    "#a6aba0"
                )
                __L1:r(
                    c,
                    x - 19,
                    365,
                    12,
                    28,
                    "#283b3a"
                )
                __L1:r(
                    c,
                    x + 174,
                    365,
                    12,
                    28,
                    "#283b3a"
                )
                __L1:r(
                    c,
                    x - 24,
                    369,
                    7,
                    20,
                    "#75897c"
                )
                __L1:r(
                    c,
                    x + 185,
                    369,
                    7,
                    20,
                    "#75897c"
                )
                __L1:r(
                    c,
                    x + 25,
                    413,
                    106,
                    9,
                    "#a56d48"
                )
                __L1:r(
                    c,
                    x + 30,
                    423,
                    7,
                    17,
                    "#293e3b"
                )
                __L1:r(
                    c,
                    x + 119,
                    423,
                    7,
                    17,
                    "#293e3b"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < math.ceil(__L1:worldWidth(2) / 790) do
                local x = 450 + i * 790
                local swing = math.sin(t * 1.5 + i) * 3
                __L1:r(
                    c,
                    x + 18,
                    95,
                    3,
                    188,
                    "#a6a18a"
                )
                __L1:r(
                    c,
                    x + 3 + swing,
                    282,
                    36,
                    96,
                    "#392f2c"
                )
                __L1:r(
                    c,
                    x + 6 + swing,
                    285,
                    30,
                    88,
                    "#a95f48"
                )
                __L1:r(
                    c,
                    x + 11 + swing,
                    290,
                    5,
                    75,
                    "#c37a55"
                )
                __L1:r(
                    c,
                    x + 5 + swing,
                    302,
                    32,
                    7,
                    "#7c493b"
                )
                __L1:r(
                    c,
                    x + 5 + swing,
                    352,
                    32,
                    6,
                    "#7c493b"
                )
                __L1:r(
                    c,
                    x + 9 + swing,
                    374,
                    23,
                    5,
                    "#2a3c35"
                )
                i = i + 1
            end
        end
        __L1:r(
            c,
            745,
            299,
            240,
            36,
            "#2c4440"
        )
        c.fillStyle = "#e6cc8d"
        c.font = "bold 19px monospace"
        c:fillText("CALEB — SEM DESCULPA", 754, 324)
        do
            local i = 0
            while i < 6 do
                local x = 1060 + i * 45
                __L1:r(
                    c,
                    x,
                    409,
                    33,
                    5,
                    "#9eac92"
                )
                __L1:r(
                    c,
                    x + 11,
                    402,
                    8,
                    8,
                    "#526b5f"
                )
                __L1:r(
                    c,
                    x + 2,
                    394,
                    8,
                    22,
                    "#233f3b"
                )
                __L1:r(
                    c,
                    x + 23,
                    394,
                    8,
                    22,
                    "#233f3b"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < math.ceil(__L1:worldWidth(2) / 790) do
                local fx = 347 + i * 790
                local fy = 113
                local angle = t * 9 + i
                c:save()
                c:translate(fx, fy)
                __L1:r(
                    c,
                    -2,
                    -79,
                    4,
                    77,
                    "#314644"
                )
                do
                    local blade = 0
                    while blade < 3 do
                        local a = angle + blade * math.pi * 2 / 3
                        local dx = math.cos(a)
                        local dy = math.sin(a) * 0.34
                        __L1:poly(
                            c,
                            __arrL(
                                {
                                    __arrL({dx * 4 - dy * 5, dy * 4 + dx * 3}, 2),
                                    __arrL({dx * 42 - dy * 5, dy * 42 + dx * 5}, 2),
                                    __arrL({dx * 43 + dy * 5, dy * 43 - dx * 5}, 2),
                                    __arrL({dx * 8 + dy * 5, dy * 8 - dx * 3}, 2)
                                },
                                4
                            ),
                            "#a8b6a0"
                        )
                        blade = blade + 1
                    end
                end
                __L1:oval(
                    c,
                    0,
                    0,
                    7,
                    5,
                    "#405951",
                    2
                )
                __L1:r(
                    c,
                    -2,
                    -3,
                    4,
                    3,
                    "#d6cfaa"
                )
                c:restore()
                i = i + 1
            end
        end
        __L1:r(
            c,
            1597,
            276,
            7,
            164,
            "#263f3b"
        )
        __L1:r(
            c,
            1666,
            276,
            7,
            164,
            "#263f3b"
        )
        __L1:r(
            c,
            1597,
            276,
            76,
            6,
            "#a4ad96"
        )
        __L1:r(
            c,
            1632,
            282,
            2,
            79,
            "#b6baa5"
        )
        local lift = math.floor((1 + math.sin(t * 1.8)) * 7 + 0.5)
        do
            local j = 0
            while j < 5 do
                __L1:r(
                    c,
                    1610,
                    371 + j * 9 - lift,
                    48,
                    7,
                    "#334a43"
                )
                __L1:r(
                    c,
                    1613,
                    372 + j * 9 - lift,
                    41,
                    2,
                    "#738773"
                )
                j = j + 1
            end
        end
        c:restore()
    end
    __L1.court = function(self, c, camera, t)
        c:save()
        c:translate(
            -math.floor(camera + 0.5),
            0
        )
        __L1:r(
            c,
            0,
            342,
            __L1:worldWidth(3),
            98,
            "#7f9a86"
        )
        __L1:r(
            c,
            0,
            381,
            __L1:worldWidth(3),
            59,
            "#a6795b"
        )
        __L1:r(
            c,
            0,
            437,
            __L1:worldWidth(3),
            3,
            "#d6c29a"
        )
        do
            local x = 0
            while x < __L1:worldWidth(3) do
                __L1:r(
                    c,
                    x,
                    240,
                    4,
                    154,
                    "#597a70"
                )
                __L1:r(
                    c,
                    x + 1,
                    240,
                    1,
                    152,
                    "#99a48a"
                )
                x = x + 65
            end
        end
        __L1:r(
            c,
            0,
            241,
            __L1:worldWidth(3),
            4,
            "#657e71"
        )
        __L1:r(
            c,
            0,
            390,
            __L1:worldWidth(3),
            4,
            "#557169"
        )
        c.strokeStyle = "#849786"
        c.lineWidth = 1
        do
            local x = -200
            while x < __L1:worldWidth(3) + 200 do
                c:beginPath()
                c:moveTo(x, 245)
                c:lineTo(x + 150, 392)
                c:stroke()
                c:beginPath()
                c:moveTo(x, 392)
                c:lineTo(x + 150, 245)
                c:stroke()
                x = x + 19
            end
        end
        for ____, x in __iterar((__arrL({300, 2200}, 2))) do
            __L1:r(
                c,
                x,
                231,
                10,
                207,
                "#425e58"
            )
            __L1:r(
                c,
                x - 7,
                229,
                24,
                7,
                "#d8cba9"
            )
            __L1:r(
                c,
                x - 61,
                217,
                73,
                52,
                "#d3d2b8"
            )
            __L1:r(
                c,
                x - 57,
                221,
                65,
                44,
                "#849e91"
            )
            __L1:r(
                c,
                x - 38,
                233,
                28,
                23,
                "#dae0bf"
            )
            __L1:r(
                c,
                x - 35,
                236,
                22,
                17,
                "#98afa0"
            )
            __L1:r(
                c,
                x - 29,
                260,
                35,
                5,
                "#c16f4e"
            )
            do
                local k = 0
                while k < 5 do
                    __L1:r(
                        c,
                        x - 27 + k * 7,
                        265,
                        1,
                        18,
                        "#c3c7ac"
                    )
                    k = k + 1
                end
            end
            __L1:r(
                c,
                x - 27,
                281,
                30,
                2,
                "#c3c7ac"
            )
        end
        for ____, x in __iterar((__arrL({85, 2450}, 2))) do
            __L1:r(
                c,
                x,
                122,
                8,
                318,
                "#4b6260"
            )
            __L1:r(
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
                    __L1:r(
                        c,
                        x - 11 + k * 11,
                        115,
                        8,
                        9,
                        "#e9d8a2"
                    )
                    k = k + 1
                end
            end
        end
        do
            local i = 0
            while i < 3 do
                __L1:r(
                    c,
                    760 - i * 24,
                    363 + i * 20,
                    270 + i * 48,
                    10,
                    "#a68c74"
                )
                __L1:r(
                    c,
                    768 - i * 24,
                    373 + i * 20,
                    6,
                    55 - i * 20,
                    "#4c675c"
                )
                __L1:r(
                    c,
                    1016 + i * 24,
                    373 + i * 20,
                    6,
                    55 - i * 20,
                    "#4c675c"
                )
                i = i + 1
            end
        end
        __L1:r(
            c,
            1250,
            393,
            620,
            3,
            "#d9c49b"
        )
        __L1:r(
            c,
            1558,
            393,
            3,
            47,
            "#d9c49b"
        )
        __L1:r(
            c,
            1280,
            424,
            565,
            3,
            "#d9c49b"
        )
        __L1:tree(c, 2530, 437, 0.8)
        __L1:bush(
            c,
            110,
            439,
            100,
            "#496758"
        )
        __L1:r(
            c,
            1090,
            198,
            970,
            2,
            "#586e65"
        )
        do
            local i = 0
            while i < 20 do
                local x = 1100 + i * 47
                __L1:poly(
                    c,
                    __arrL(
                        {
                            __arrL({x, 200}, 2),
                            __arrL({x + 23, 200}, 2),
                            __arrL(
                                {
                                    x + 12,
                                    222 + math.sin(t + i) * 2
                                },
                                2
                            )
                        },
                        3
                    ),
                    __t(__mod(i, 2)) and "#b87d59" or "#879c81"
                )
                i = i + 1
            end
        end
        local ballX = 1174 + math.sin(t * 0.65) * 31
        local ballY = 428 - math.abs(math.sin(t * 2.8)) * 38
        __L1:oval(
            c,
            ballX,
            ballY,
            8,
            8,
            "#6f4f35",
            2
        )
        __L1:oval(
            c,
            ballX,
            ballY - 1,
            6,
            6,
            "#e19d4e",
            2
        )
        __L1:r(
            c,
            ballX - 1,
            ballY - 7,
            2,
            13,
            "#875b38"
        )
        __L1:r(
            c,
            ballX - 6,
            ballY - 1,
            12,
            2,
            "#875b38"
        )
        c:restore()
    end
    __L1.football = function(self, c, x, y, size, t)
        if size == nil then
            size = 9
        end
        if t == nil then
            t = 0
        end
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        __L1:oval(
            c,
            0,
            0,
            size + 1,
            size + 1,
            "#263c3e",
            2
        )
        __L1:oval(
            c,
            0,
            -1,
            size,
            size,
            "#f2f2df",
            2
        )
        __L1:r(
            c,
            -3,
            -4,
            6,
            6,
            "#35494c"
        )
        __L1:r(
            c,
            -size + 1,
            -2,
            3,
            4,
            "#35494c"
        )
        __L1:r(
            c,
            size - 4,
            -1,
            3,
            5,
            "#35494c"
        )
        __L1:r(
            c,
            -2,
            size - 4,
            4,
            3,
            "#35494c"
        )
        __L1:r(
            c,
            0,
            -size + 1,
            4,
            3,
            "#35494c"
        )
        __L1:r(
            c,
            -size + 3,
            -size + 4,
            2,
            2,
            "#d5ded6"
        )
        c:restore()
    end
    __L1.backgroundCitizen = function(self, c, x, y, t, seed, seat)
        if t == nil then
            t = 0
        end
        if seed == nil then
            seed = 0
        end
        if seat == nil then
            seat = false
        end
        local skin = __get(
            __arrL({"#e4bd9b", "#a16b49", "#c59066", "#f0ceb0"}, 4),
            __mod(seed, 4)
        )
        local shirt = __get(
            __arrL({"#dce7df", "#3d6785", "#b5785b", "#6a8b68"}, 4),
            __mod(seed, 4)
        )
        local wave = math.floor(math.sin(t * 2 + seed) * 2 + 0.5)
        __L1:r(
            c,
            x - 4,
            y - 18,
            9,
            13,
            shirt
        )
        __L1:r(
            c,
            x - 3,
            y - 28,
            8,
            9,
            skin
        )
        __L1:r(
            c,
            x - 4,
            y - 30,
            9,
            4,
            __t(__mod(seed, 3)) and "#373c36" or "#835d37"
        )
        __L1:r(
            c,
            x - 4,
            y - 5,
            3,
            __t(seat) and 5 or 8,
            "#344e5c"
        )
        __L1:r(
            c,
            x + 2,
            y - 5,
            3,
            __t(seat) and 5 or 8,
            "#344e5c"
        )
        __L1:r(
            c,
            x + 5,
            y - 17 + wave,
            3,
            10,
            skin
        )
        __L1:r(
            c,
            x - 7,
            y - 17 - wave,
            3,
            10,
            skin
        )
    end
    __L1.plaza = function(self, c, camera, t)
        c:save()
        c:translate(
            -math.floor(camera * 0.28 + 0.5),
            0
        )
        do
            local i = -1
            while i < 25 do
                local x = i * 273
                local h = 70 + __L1:hash(i + 83) * 58
                __L1:r(
                    c,
                    x,
                    250 - h,
                    220,
                    h,
                    "#bfd3d2"
                )
                __L1:r(
                    c,
                    x + 6,
                    250 - h + 8,
                    208,
                    8,
                    "#e2ece6"
                )
                do
                    local k = 0
                    while k < 5 do
                        __L1:r(
                            c,
                            x + 19 + k * 39,
                            270 - h,
                            17,
                            26,
                            "#7b9da5"
                        )
                        __L1:r(
                            c,
                            x + 19 + k * 39,
                            273 - h,
                            8,
                            11,
                            "#b8d8dd"
                        )
                        if h > 105 then
                            __L1:r(
                                c,
                                x + 19 + k * 39,
                                308 - h,
                                17,
                                25,
                                "#83a8b0"
                            )
                        end
                        k = k + 1
                    end
                end
                __L1:r(
                    c,
                    x,
                    247,
                    220,
                    8,
                    "#8faeb0"
                )
                i = i + 1
            end
        end
        c:restore()
        __L1:r(
            c,
            0,
            260,
            960,
            99,
            "#63a8be"
        )
        __L1:r(
            c,
            0,
            262,
            960,
            7,
            "#badcdd"
        )
        do
            local i = 0
            while i < 40 do
                local x = __mod(
                    __mod(i * 71 - camera * 0.4 + t * 10, 1080) + 1080,
                    1080
                ) - 60
                local yy = 275 + __L1:hash(i + 51) * 76
                __L1:r(
                    c,
                    x,
                    yy,
                    19 + __L1:hash(i + 4) * 30,
                    2,
                    __t(__mod(i, 2)) and "#96d4dd" or "#83c0d1"
                )
                i = i + 1
            end
        end
        c:save()
        c:translate(
            -math.floor(camera + 0.5),
            0
        )
        __L1:r(
            c,
            0,
            354,
            __L1:worldWidth(4),
            86,
            "#cbd0bb"
        )
        __L1:r(
            c,
            0,
            353,
            __L1:worldWidth(4),
            6,
            "#edf0d7"
        )
        local lo = math.floor((camera - 200) / 320)
        local hi = math.ceil((camera + 1160) / 320)
        do
            local i = lo
            while i < hi do
                local x = i * 320
                __L1:r(
                    c,
                    x,
                    329,
                    5,
                    51,
                    "#697f79"
                )
                __L1:r(
                    c,
                    x,
                    331,
                    320,
                    4,
                    "#9aa995"
                )
                __L1:r(
                    c,
                    x,
                    349,
                    320,
                    4,
                    "#91a38e"
                )
                __L1:r(
                    c,
                    x,
                    370,
                    320,
                    5,
                    "#799783"
                )
                i = i + 1
            end
        end
        do
            local x = 160
            while x < __L1:worldWidth(4) do
                do
                    if __t(x < camera - 260 or __gt(x, camera + 1160)) then
                        do x = x + 570 continue end
                    end
                    __L1:tree(
                        c,
                        x,
                        430,
                        0.72,
                        1
                    )
                    __L1:bush(
                        c,
                        x + 75,
                        433,
                        75,
                        "#578b45"
                    )
                    __L1:r(
                        c,
                        x + 137,
                        401,
                        112,
                        8,
                        "#986c44"
                    )
                    __L1:r(
                        c,
                        x + 142,
                        409,
                        7,
                        30,
                        "#4c6d57"
                    )
                    __L1:r(
                        c,
                        x + 234,
                        409,
                        7,
                        30,
                        "#4c6d57"
                    )
                    __L1:r(
                        c,
                        x + 137,
                        378,
                        112,
                        7,
                        "#c39b65"
                    )
                    __L1:r(
                        c,
                        x + 137,
                        391,
                        112,
                        6,
                        "#b28856"
                    )
                    __L1:backgroundCitizen(
                        c,
                        x + 180,
                        404,
                        t,
                        math.floor(x / 570),
                        true
                    )
                end
                x = x + 570
            end
        end
        for ____, x in __iterar((__arrL({1050, 4230}, 2))) do
            do
                if __t(x < camera - 280 or __gt(x, camera + 1240)) then
                    continue
                end
                __L1:oval(
                    c,
                    x,
                    425,
                    111,
                    18,
                    "#698d89",
                    3
                )
                __L1:oval(
                    c,
                    x,
                    416,
                    103,
                    20,
                    "#d7d4b8",
                    3
                )
                __L1:oval(
                    c,
                    x,
                    409,
                    91,
                    15,
                    "#77bbca",
                    3
                )
                __L1:oval(
                    c,
                    x,
                    409,
                    74,
                    9,
                    "#a5dce2",
                    3
                )
                __L1:r(
                    c,
                    x - 8,
                    342,
                    17,
                    65,
                    "#d9d9bd"
                )
                __L1:oval(
                    c,
                    x,
                    341,
                    58,
                    9,
                    "#d9d9bd",
                    3
                )
                __L1:oval(
                    c,
                    x,
                    335,
                    50,
                    8,
                    "#82c6cf",
                    3
                )
                __L1:r(
                    c,
                    x - 4,
                    294,
                    8,
                    40,
                    "#ecedcf"
                )
                __L1:oval(
                    c,
                    x,
                    293,
                    21,
                    7,
                    "#e5e7cd",
                    2
                )
                do
                    local j = 0
                    while j < 5 do
                        local a = j * math.pi / 4 + math.pi * 0.1
                        local ex = math.cos(a) * 44
                        local ey = math.sin(a) * 24
                        __L1:limb(
                            c,
                            __arrL(
                                {
                                    __arrL({x, 291}, 2),
                                    __arrL({x + ex * 0.5, 259 - ey}, 2),
                                    __arrL({x + ex, 312}, 2)
                                },
                                3
                            ),
                            3,
                            "#b7eced"
                        )
                        __L1:r(
                            c,
                            x + ex,
                            306 + __mod(t * 55 + j * 11, 19),
                            3,
                            5,
                            "#edf8ee"
                        )
                        j = j + 1
                    end
                end
                do
                    local j = 0
                    while j < 12 do
                        local xx = x - 74 + j * 14
                        local yy = 409 - math.abs(math.sin(t * 3 + j)) * 7
                        __L1:r(
                            c,
                            xx,
                            yy,
                            4,
                            2,
                            "#d6f2e8"
                        )
                        j = j + 1
                    end
                end
            end
        end
        for ____, x in __iterar((__arrL({1970, 5030}, 2))) do
            do
                if __t(x < camera - 300 or __gt(x, camera + 1100)) then
                    continue
                end
                __L1:r(
                    c,
                    x,
                    314,
                    170,
                    124,
                    "#efdfb5"
                )
                __L1:r(
                    c,
                    x - 12,
                    306,
                    194,
                    16,
                    "#274d61"
                )
                __L1:r(
                    c,
                    x + 9,
                    326,
                    152,
                    14,
                    "#305a6c"
                )
                __L1:r(
                    c,
                    x + 15,
                    350,
                    139,
                    61,
                    "#4c898c"
                )
                __L1:r(
                    c,
                    x + 19,
                    354,
                    131,
                    52,
                    "#89b9b6"
                )
                __L1:r(
                    c,
                    x + 13,
                    412,
                    142,
                    9,
                    "#c79860"
                )
                c.fillStyle = "#f8ebc7"
                c.font = "bold 10px monospace"
                c:fillText("CACAU & RESENHA", x + 21, 337)
                do
                    local i = 0
                    while i < 3 do
                        __L1:r(
                            c,
                            x + 28 + i * 44,
                            374,
                            22,
                            31,
                            "#9b694b"
                        )
                        __L1:r(
                            c,
                            x + 31 + i * 44,
                            372,
                            15,
                            4,
                            "#d9ac69"
                        )
                        i = i + 1
                    end
                end
                __L1:backgroundCitizen(
                    c,
                    x + 82,
                    412,
                    t,
                    3
                )
            end
        end
        __L1:r(
            c,
            390,
            315,
            6,
            122,
            "#3c6a76"
        )
        __L1:r(
            c,
            354,
            296,
            215,
            43,
            "#214e66"
        )
        __L1:r(
            c,
            358,
            300,
            207,
            35,
            "#dbe8df"
        )
        c.fillStyle = "#285e76"
        c.font = "bold 15px monospace"
        c:fillText("PRAÇA CAMACAN", 370, 318)
        c.font = "bold 9px monospace"
        c:fillText("ITABUNA · RIO CACHOEIRA", 374, 332)
        do
            local i = 0
            while i < 9 do
                do
                    local x = 700 + i * 650
                    if __t(x < camera - 70 or __gt(x, camera + 1040)) then
                        do i = i + 1 continue end
                    end
                    __L1:r(
                        c,
                        x,
                        261,
                        5,
                        176,
                        "#476967"
                    )
                    __L1:r(
                        c,
                        x - 13,
                        251,
                        32,
                        13,
                        "#294e5a"
                    )
                    __L1:r(
                        c,
                        x - 8,
                        254,
                        22,
                        7,
                        "#fff0b4"
                    )
                end
                i = i + 1
            end
        end
        c:restore()
    end
    __L1.favelaHouse = function(self, c, x, y, w, h, seed, t, back)
        if back == nil then
            back = false
        end
        local colors = __arrL({
            "#bf7956",
            "#d4a06d",
            "#c48b70",
            "#a8b29b",
            "#b7855e",
            "#9b9fa0"
        }, 6)
        local pal = __get(
            colors,
            __mod(
                math.abs(seed),
                __len(colors)
            )
        )
        __L1:r(
            c,
            x,
            y,
            w,
            h,
            __t(back) and "#82949a" or "#513e38"
        )
        __L1:r(
            c,
            x + 3,
            y + 4,
            w - 6,
            h - 4,
            pal
        )
        __L1:r(
            c,
            x - 5,
            y - 7,
            w + 10,
            10,
            __t(back) and "#5b747b" or "#71645a"
        )
        __L1:r(
            c,
            x - 1,
            y - 8,
            w + 2,
            3,
            "#b2a58a"
        )
        do
            local row = 0
            while row < math.floor(h / 18) do
                do
                    local col = 0
                    while col < math.floor(w / 24) do
                        do
                            if __t(back) then
                                do col = col + 1 continue end
                            end
                            __L1:r(
                                c,
                                x + 4 + col * 24 + (__t(__mod(row, 2)) and 9 or 0),
                                y + 13 + row * 18,
                                17,
                                1,
                                "#a9654b"
                            )
                        end
                        col = col + 1
                    end
                end
                row = row + 1
            end
        end
        local wy = y + 18
        local wh = math.min(42, h - 27)
        do
            local k = 0
            while k < 2 do
                local wx = x + 13 + k * (w * 0.48)
                __L1:r(
                    c,
                    wx,
                    wy,
                    math.min(30, w * 0.3),
                    wh,
                    "#395462"
                )
                __L1:r(
                    c,
                    wx + 3,
                    wy + 3,
                    math.min(24, w * 0.3 - 6),
                    wh - 7,
                    __t(__mod(seed, 3)) and "#84b6c0" or "#e1c892"
                )
                __L1:r(
                    c,
                    wx + 12,
                    wy,
                    3,
                    wh,
                    "#dbd3b6"
                )
                k = k + 1
            end
        end
        if __t(not __t(back) and __gt(h, 88)) then
            __L1:r(
                c,
                x + w * 0.39,
                __add(y, h) - 61,
                28,
                61,
                "#4c5851"
            )
            __L1:r(
                c,
                x + w * 0.4,
                __add(y, h) - 59,
                20,
                58,
                "#647b6f"
            )
            __L1:r(
                c,
                x + w * 0.56,
                __add(y, h) - 31,
                3,
                3,
                "#d4b584"
            )
        end
        if not __t(back) then
            __L1:r(
                c,
                x + 8,
                y - 21,
                35,
                16,
                "#7e9297"
            )
            __L1:r(
                c,
                x + 12,
                y - 27,
                26,
                8,
                "#bdc3b0"
            )
            __L1:r(
                c,
                __add(x, w) - 22,
                y - 23,
                3,
                18,
                "#414d4c"
            )
            __L1:r(
                c,
                __add(x, w) - 35,
                y - 26,
                29,
                3,
                "#414d4c"
            )
            if __mod(seed, 3) == 0 then
                __L1:backgroundCitizen(
                    c,
                    x + 28,
                    y + wh + 17,
                    t,
                    seed
                )
            end
        end
    end
    __L1.favela = function(self, c, camera, t)
        c:save()
        c:translate(
            -math.floor(camera * 0.2 + 0.5),
            0
        )
        do
            local i = -1
            while i < 30 do
                local x = i * 181
                local yy = 95 + __mod(i, 4) * 30
                __L1:favelaHouse(
                    c,
                    x,
                    yy,
                    174,
                    115 + __mod(i, 3) * 17,
                    i + 20,
                    t,
                    true
                )
                i = i + 1
            end
        end
        c:restore()
        c:save()
        c:translate(
            -math.floor(camera * 0.48 + 0.5),
            0
        )
        do
            local i = -1
            while i < 40 do
                local x = i * 159
                local yy = 201 + __mod(i, 3) * 16
                __L1:favelaHouse(
                    c,
                    x,
                    yy,
                    151,
                    128,
                    i + 8,
                    t,
                    true
                )
                i = i + 1
            end
        end
        c:restore()
        c:save()
        c:translate(
            -math.floor(camera + 0.5),
            0
        )
        __L1:r(
            c,
            0,
            398,
            __L1:worldWidth(5),
            42,
            "#968a73"
        )
        local lo = math.floor((camera - 170) / 210)
        local hi = math.ceil((camera + 1180) / 210)
        do
            local i = lo
            while i < hi do
                local x = i * 210
                local yy = 272 + __mod(i, 2) * 29
                __L1:favelaHouse(
                    c,
                    x,
                    yy,
                    188,
                    163 - __mod(i, 2) * 29,
                    i + 100,
                    t
                )
                __L1:r(
                    c,
                    x + 190,
                    yy + 78,
                    16,
                    8,
                    "#b3a585"
                )
                __L1:r(
                    c,
                    x + 193,
                    yy + 86,
                    13,
                    8,
                    "#a69b81"
                )
                __L1:r(
                    c,
                    x + 196,
                    yy + 94,
                    10,
                    8,
                    "#958c78"
                )
                i = i + 1
            end
        end
        do
            local x = math.floor(camera / 390) * 390
            while __lt(x, camera + 1200) do
                __L1:r(
                    c,
                    x,
                    117,
                    6,
                    322,
                    "#4b5b56"
                )
                c.strokeStyle = "#394b4f"
                c.lineWidth = 2
                c:beginPath()
                c:moveTo(x - 387, 130)
                c:quadraticCurveTo(x - 190, 181, x + 4, 130)
                c:stroke()
                do
                    local j = 0
                    while j < 4 do
                        local xx = x - 293 + j * 47
                        local yy = 172 + math.sin(j) * 5
                        local wave = math.floor(math.sin(t * 3 + j) * 4 + 0.5)
                        __L1:poly(
                            c,
                            __arrL(
                                {
                                    __arrL({xx, yy}, 2),
                                    __arrL({xx + 24, yy + 2}, 2),
                                    __arrL({xx + 26 + wave, yy + 27}, 2),
                                    __arrL({xx - 2 + wave, yy + 26}, 2)
                                },
                                4
                            ),
                            __get(
                                __arrL({"#e0c17c", "#6697ac", "#dc8666", "#d8d0a7"}, 4),
                                j
                            )
                        )
                        j = j + 1
                    end
                end
                x = x + 390
            end
        end
        do
            local x = 870
            local i = 0
            while x < __L1:worldWidth(5) do
                do
                    if __t(x < camera - 260 or __gt(x, camera + 1100)) then
                        do do x = x + 900 i = i + 1 end continue end
                    end
                    __L1:r(
                        c,
                        x,
                        294,
                        128,
                        75,
                        "#3c5358"
                    )
                    __L1:r(
                        c,
                        x + 5,
                        299,
                        118,
                        65,
                        "#2a5b65"
                    )
                    c.fillStyle = "#b0dfc5"
                    c.font = "bold 12px monospace"
                    c:fillText(i > 4 and "ALTO DO MORRO" or "RESPEITA A RESENHA", x + 7, 322)
                    c.font = "bold 9px monospace"
                    c:fillText("GABRIEL REEIS", x + 12, 344)
                    __L1:r(
                        c,
                        x + 142,
                        393,
                        28,
                        45,
                        "#395f59"
                    )
                    __L1:r(
                        c,
                        x + 140,
                        387,
                        32,
                        7,
                        "#82a087"
                    )
                end
                do
                    x = x + 900
                    i = i + 1
                end
            end
        end
        do
            local i = 0
            while i < 10 do
                local x = camera + __mod(i * 133 + t * 2, 1040) - 40
                local y = 150 + __mod(i, 3) * 53
                __L1:r(
                    c,
                    x,
                    y,
                    2,
                    2,
                    "#f4d78c"
                )
                i = i + 1
            end
        end
        c:restore()
    end
    __L1.inkRealm = function(self, c, camera, t)
        __L1:r(
            c,
            0,
            0,
            960,
            440,
            "#292b49"
        )
        __L1:r(
            c,
            0,
            140,
            960,
            300,
            "#413b62"
        )
        do
            local i = 0
            while i < 28 do
                local x = __mod(
                    __mod(i * 97 - camera * 0.22 + t * 7, 1080) + 1080,
                    1080
                ) - 70
                local y = 35 + __mod(i * 43, 260)
                __L1:r(
                    c,
                    x,
                    y,
                    3,
                    3,
                    __t(__mod(i, 3)) and "#b5a2cf" or "#e3c7ed"
                )
                i = i + 1
            end
        end
        c:save()
        c:translate(
            -math.floor(camera * 0.3 + 0.5),
            0
        )
        do
            local i = -1
            while i < 32 do
                local x = i * 245
                local yy = 95 + __mod(i, 3) * 39
                c:save()
                c.globalAlpha = 0.3
                __L1:doodle(
                    c,
                    x + 90,
                    yy + 50,
                    __mod(i, 3),
                    t * 0.4 + i,
                    false
                )
                c:restore()
                __L1:poly(
                    c,
                    __arrL(
                        {
                            __arrL({x, 285}, 2),
                            __arrL({x + 35, 101}, 2),
                            __arrL({x + 145, 90}, 2),
                            __arrL({x + 174, 286}, 2)
                        },
                        4
                    ),
                    "#655579"
                )
                do
                    local j = 0
                    while j < 6 do
                        __L1:r(
                            c,
                            x + 53,
                            128 + j * 19,
                            88,
                            2,
                            "#9c8bac"
                        )
                        j = j + 1
                    end
                end
                i = i + 1
            end
        end
        c:restore()
        c:save()
        c:translate(
            -math.floor(camera + 0.5),
            0
        )
        __L1:r(
            c,
            0,
            361,
            __L1:worldWidth(6),
            79,
            "#68557f"
        )
        local lo = math.floor((camera - 170) / 180)
        local hi = math.ceil((camera + 1140) / 180)
        do
            local i = lo
            while i < hi do
                local x = i * 180
                local y = 235 + math.sin(t * 0.8 + i) * 12
                __L1:poly(
                    c,
                    __arrL(
                        {
                            __arrL({x, y}, 2),
                            __arrL({x + 132, y - 12}, 2),
                            __arrL({x + 143, y + 105}, 2),
                            __arrL({x + 118, y + 117}, 2),
                            __arrL({x + 92, y + 109}, 2),
                            __arrL({x + 70, y + 122}, 2),
                            __arrL({x + 43, y + 112}, 2),
                            __arrL({x + 13, y + 119}, 2)
                        },
                        8
                    ),
                    "#d7c9d7"
                )
                __L1:r(
                    c,
                    x + 17,
                    y + 15,
                    105,
                    2,
                    "#b395bd"
                )
                __L1:r(
                    c,
                    x + 18,
                    y + 32,
                    105,
                    2,
                    "#b395bd"
                )
                __L1:r(
                    c,
                    x + 19,
                    y + 49,
                    102,
                    2,
                    "#b395bd"
                )
                __L1:r(
                    c,
                    x + 20,
                    y + 66,
                    102,
                    2,
                    "#b395bd"
                )
                __L1:r(
                    c,
                    x + 19,
                    y + 14,
                    2,
                    81,
                    "#c28b9f"
                )
                if __mod(i, 3) == 0 then
                    c:save()
                    c:translate(x + 70, y + 80)
                    c:scale(1.3, 1.3)
                    __L1:doodle(
                        c,
                        0,
                        0,
                        __mod(i, 3),
                        t * 0.4,
                        false
                    )
                    c:restore()
                end
                i = i + 1
            end
        end
        do
            local x = 680
            local i = 0
            while x < __L1:worldWidth(6) do
                do
                    if __t(x < camera - 190 or __gt(x, camera + 1140)) then
                        do do x = x + 990 i = i + 1 end continue end
                    end
                    __L1:r(
                        c,
                        x,
                        109,
                        143,
                        39,
                        "#3c324f"
                    )
                    __L1:r(
                        c,
                        x + 4,
                        113,
                        135,
                        31,
                        "#876591"
                    )
                    c.fillStyle = "#f1d3e1"
                    c.font = "bold 11px monospace"
                    c:fillText(i > 3 and "O RABISCO GIGANTE" or "O CADERNO TEM FOME", x + 9, 132)
                end
                do
                    x = x + 990
                    i = i + 1
                end
            end
        end
        do
            local i = 0
            while i < 16 do
                local xx = camera + __mod(i * 89 + t * 18, 1060) - 50
                local yy = 65 + __mod(i * 61 + t * 23, 330)
                __L1:r(
                    c,
                    xx,
                    yy,
                    6,
                    3,
                    __t(__mod(i, 2)) and "#ddb8d0" or "#a5ca9c"
                )
                i = i + 1
            end
        end
        c:restore()
    end
    __L1.footballField = function(self, c, camera, t)
        c:save()
        c:translate(
            -math.floor(camera * 0.3 + 0.5),
            0
        )
        __L1:r(
            c,
            0,
            180,
            __L1:worldWidth(7) + 1200,
            147,
            "#e2ebeb"
        )
        __L1:r(
            c,
            0,
            180,
            __L1:worldWidth(7) + 1200,
            16,
            "#21496c"
        )
        do
            local x = 20
            while x < __L1:worldWidth(7) + 900 do
                __L1:r(
                    c,
                    x,
                    218,
                    78,
                    61,
                    "#87acb7"
                )
                __L1:r(
                    c,
                    x + 4,
                    222,
                    70,
                    53,
                    "#b3d5d9"
                )
                __L1:r(
                    c,
                    x + 37,
                    222,
                    4,
                    53,
                    "#ebf2e7"
                )
                x = x + 110
            end
        end
        c:restore()
        c:save()
        c:translate(
            -math.floor(camera + 0.5),
            0
        )
        __L1:r(
            c,
            0,
            326,
            __L1:worldWidth(7),
            114,
            "#438c4b"
        )
        do
            local i = 0
            while i < math.ceil(__L1:worldWidth(7) / 160) do
                __L1:r(
                    c,
                    i * 160,
                    327,
                    80,
                    110,
                    "#4e9752"
                )
                i = i + 1
            end
        end
        __L1:r(
            c,
            0,
            432,
            __L1:worldWidth(7),
            4,
            "#ecedd1"
        )
        __L1:r(
            c,
            0,
            342,
            __L1:worldWidth(7),
            3,
            "#dce9c8"
        )
        do
            local x = 190
            while x < __L1:worldWidth(7) do
                do
                    if __t(x < camera - 400 or __gt(x, camera + 1220)) then
                        do x = x + 960 continue end
                    end
                    do
                        local row = 0
                        while row < 3 do
                            __L1:r(
                                c,
                                x - row * 16,
                                264 + row * 20,
                                320 + row * 32,
                                7,
                                "#6b90a4"
                            )
                            do
                                local j = 0
                                while j < 15 do
                                    __L1:backgroundCitizen(
                                        c,
                                        x + 10 + j * 20,
                                        268 + row * 20,
                                        t,
                                        j + row * 5,
                                        true
                                    )
                                    j = j + 1
                                end
                            end
                            row = row + 1
                        end
                    end
                    __L1:r(
                        c,
                        x + 125,
                        258,
                        84,
                        4,
                        "#183e60"
                    )
                end
                x = x + 960
            end
        end
        for ____, x in __iterar((__arrL({740, 4410}, 2))) do
            do
                if __t(x < camera - 200 or __gt(x, camera + 1120)) then
                    continue
                end
                __L1:r(
                    c,
                    x,
                    283,
                    7,
                    154,
                    "#e9f2de"
                )
                __L1:r(
                    c,
                    x + 173,
                    283,
                    7,
                    154,
                    "#e9f2de"
                )
                __L1:r(
                    c,
                    x,
                    282,
                    180,
                    7,
                    "#faffeb"
                )
                do
                    local j = 0
                    while j < 10 do
                        __L1:r(
                            c,
                            x + 5 + j * 18,
                            290,
                            1,
                            145,
                            "#b1ceaf"
                        )
                        j = j + 1
                    end
                end
                do
                    local j = 0
                    while j < 8 do
                        __L1:r(
                            c,
                            x + 7,
                            291 + j * 18,
                            166,
                            1,
                            "#b1ceaf"
                        )
                        j = j + 1
                    end
                end
                __L1:r(
                    c,
                    x - 17,
                    434,
                    216,
                    3,
                    "#e6efcf"
                )
            end
        end
        do
            local x = 1250
            while x < __L1:worldWidth(7) do
                __L1:r(
                    c,
                    x,
                    345,
                    3,
                    94,
                    "#eff0d0"
                )
                __L1:oval(
                    c,
                    x,
                    392,
                    87,
                    38,
                    "#dcebc9",
                    3
                )
                __L1:oval(
                    c,
                    x,
                    392,
                    83,
                    34,
                    "#4c9450",
                    3
                )
                x = x + 2100
            end
        end
        do
            local x = 300
            while x < __L1:worldWidth(7) do
                __L1:r(
                    c,
                    x,
                    100,
                    7,
                    200,
                    "#40687b"
                )
                __L1:r(
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
                        __L1:r(
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
                x = x + 1300
            end
        end
        __L1:r(
            c,
            350,
            204,
            343,
            38,
            "#153a60"
        )
        c.fillStyle = "#eff5de"
        c.font = "bold 20px monospace"
        c:fillText("CAMPO DO MOTA · MOTA FC", 363, 230)
        __L1:football(
            c,
            1780 + math.sin(t * 0.7) * 22,
            423 - math.abs(math.sin(t * 2.8)) * 18,
            8,
            t
        )
        c:restore()
    end
    __L1.barberPole = function(self, c, x, y, t)
        if t == nil then
            t = 0
        end
        __L1:r(
            c,
            x - 4,
            y - 8,
            31,
            11,
            "#252d34"
        )
        __L1:r(
            c,
            x - 1,
            y - 5,
            25,
            6,
            "#ded4bf"
        )
        __L1:r(
            c,
            x,
            y,
            23,
            88,
            "#2a343d"
        )
        __L1:r(
            c,
            x + 3,
            y + 3,
            17,
            82,
            "#f0e6cf"
        )
        c:save()
        c:beginPath()
        c:rect(x + 3, y + 3, 17, 82)
        c:clip()
        do
            local i = -3
            while i < 8 do
                local yy = y + i * 24 + __mod(t * 16, 24)
                __L1:poly(
                    c,
                    __arrL(
                        {
                            __arrL({x + 3, yy}, 2),
                            __arrL({x + 20, yy - 14}, 2),
                            __arrL({x + 20, yy - 5}, 2),
                            __arrL({x + 3, yy + 9}, 2)
                        },
                        4
                    ),
                    __t(__mod(i, 2)) and "#bf5e51" or "#476e99"
                )
                i = i + 1
            end
        end
        c:restore()
        __L1:r(
            c,
            x + 4,
            y + 4,
            3,
            80,
            "#fff8e4aa"
        )
        __L1:r(
            c,
            x + 21,
            y + 3,
            2,
            82,
            "#647a80"
        )
        __L1:r(
            c,
            x - 4,
            y + 87,
            31,
            10,
            "#252d34"
        )
        __L1:r(
            c,
            x - 1,
            y + 89,
            25,
            4,
            "#beb8a7"
        )
    end
    __L1.barberChair = function(self, c, x, y, t, occupied)
        if t == nil then
            t = 0
        end
        if occupied == nil then
            occupied = false
        end
        __L1:oval(
            c,
            x,
            y - 2,
            39,
            7,
            "#464843",
            3
        )
        __L1:r(
            c,
            x - 25,
            y - 7,
            51,
            7,
            "#26343b"
        )
        __L1:r(
            c,
            x - 22,
            y - 8,
            44,
            3,
            "#b6bdb1"
        )
        __L1:r(
            c,
            x - 5,
            y - 48,
            11,
            39,
            "#434f50"
        )
        __L1:r(
            c,
            x - 3,
            y - 45,
            6,
            32,
            "#c5c5b4"
        )
        __L1:r(
            c,
            x - 33,
            y - 111,
            66,
            72,
            "#283138"
        )
        __L1:r(
            c,
            x - 29,
            y - 107,
            58,
            65,
            "#883e3f"
        )
        __L1:r(
            c,
            x - 25,
            y - 103,
            50,
            5,
            "#b66a5b"
        )
        __L1:r(
            c,
            x - 26,
            y - 62,
            52,
            4,
            "#66343c"
        )
        __L1:r(
            c,
            x - 19,
            y - 130,
            39,
            19,
            "#2e3439"
        )
        __L1:r(
            c,
            x - 16,
            y - 127,
            33,
            13,
            "#a45e50"
        )
        __L1:r(
            c,
            x - 36,
            y - 47,
            73,
            17,
            "#29343a"
        )
        __L1:r(
            c,
            x - 31,
            y - 45,
            63,
            10,
            "#9e4d47"
        )
        __L1:r(
            c,
            x - 31,
            y - 45,
            63,
            3,
            "#c98166"
        )
        for ____, side in __iterar((__arrL({-1, 1}, 2))) do
            __L1:r(
                c,
                x + side * 36 - 3,
                y - 80,
                7,
                39,
                "#8fa19b"
            )
            __L1:r(
                c,
                x + side * 36 - 9,
                y - 84,
                19,
                8,
                "#27363b"
            )
            __L1:r(
                c,
                x + side * 36 - 8,
                y - 84,
                17,
                3,
                "#baa78c"
            )
        end
        __L1:r(
            c,
            x + 20,
            y - 35,
            4,
            24,
            "#455351"
        )
        __L1:r(
            c,
            x + 21,
            y - 16,
            32,
            5,
            "#c2c4b1"
        )
        __L1:r(
            c,
            x + 47,
            y - 20,
            5,
            6,
            "#c2c4b1"
        )
        if __t(occupied) then
            local head = math.floor(math.sin(t * 0.8) * 1 + 0.5)
            __L1:r(
                c,
                x - 16,
                y - 117,
                32,
                25,
                "#c99270"
            )
            __L1:r(
                c,
                x - 17,
                y - 121,
                34,
                12,
                "#4a3530"
            )
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({x - 18, y - 95}, 2),
                        __arrL({x + 19, y - 95}, 2),
                        __arrL({x + 30, y - 46}, 2),
                        __arrL({x - 30, y - 46}, 2)
                    },
                    4
                ),
                "#d5d6c4"
            )
            __L1:r(
                c,
                x - 23,
                y - 84,
                45,
                3,
                "#b4b9ae"
            )
            __L1:r(
                c,
                x - 4,
                y - 114 + head,
                3,
                2,
                "#322e2d"
            )
            __L1:r(
                c,
                x + 8,
                y - 114 + head,
                3,
                2,
                "#322e2d"
            )
        end
    end
    __L1.bigodon = function(self, c, camera, t)
        __L1:r(
            c,
            0,
            0,
            960,
            440,
            "#d5bea1"
        )
        __L1:r(
            c,
            0,
            0,
            960,
            27,
            "#29373b"
        )
        __L1:r(
            c,
            0,
            27,
            960,
            7,
            "#a97444"
        )
        __L1:r(
            c,
            0,
            34,
            960,
            5,
            "#f1d3a0"
        )
        __L1:r(
            c,
            0,
            278,
            960,
            162,
            "#74513c"
        )
        __L1:r(
            c,
            0,
            278,
            960,
            6,
            "#c89b63"
        )
        __L1:r(
            c,
            0,
            418,
            960,
            22,
            "#3b4140"
        )
        c:save()
        c:translate(
            -math.floor(camera + 0.5),
            0
        )
        local width = __L1:worldWidth(8)
        do
            local xx = 0
            while xx < width do
                __L1:r(
                    c,
                    xx,
                    288,
                    3,
                    128,
                    "#4d3a31"
                )
                __L1:r(
                    c,
                    xx + 6,
                    290,
                    1,
                    124,
                    "#9e7350"
                )
                xx = xx + 33
            end
        end
        do
            local xx = 65
            local i = 0
            while xx < width do
                do
                    if __t(xx < camera - 420 or __gt(xx, camera + 1040)) then
                        do do xx = xx + 438 i = i + 1 end continue end
                    end
                    __L1:r(
                        c,
                        xx,
                        123,
                        213,
                        186,
                        "#303b3f"
                    )
                    __L1:r(
                        c,
                        xx + 5,
                        128,
                        203,
                        176,
                        "#b98b52"
                    )
                    __L1:r(
                        c,
                        xx + 11,
                        134,
                        191,
                        163,
                        "#576f75"
                    )
                    __L1:r(
                        c,
                        xx + 15,
                        138,
                        183,
                        153,
                        "#8dafb0"
                    )
                    __L1:poly(
                        c,
                        __arrL(
                            {
                                __arrL({xx + 22, 280}, 2),
                                __arrL({xx + 123, 140}, 2),
                                __arrL({xx + 149, 140}, 2),
                                __arrL({xx + 48, 280}, 2)
                            },
                            4
                        ),
                        "#a7cbcb"
                    )
                    __L1:poly(
                        c,
                        __arrL(
                            {
                                __arrL({xx + 124, 278}, 2),
                                __arrL({xx + 184, 194}, 2),
                                __arrL({xx + 197, 194}, 2),
                                __arrL({xx + 137, 278}, 2)
                            },
                            4
                        ),
                        "#9abfbd"
                    )
                    __L1:r(
                        c,
                        xx + 25,
                        143,
                        77,
                        2,
                        "#d2e1cc"
                    )
                    __L1:r(
                        c,
                        xx - 12,
                        309,
                        240,
                        14,
                        "#333f40"
                    )
                    __L1:r(
                        c,
                        xx - 9,
                        309,
                        234,
                        4,
                        "#b98a55"
                    )
                    __L1:r(
                        c,
                        xx - 6,
                        323,
                        226,
                        47,
                        "#a27a50"
                    )
                    __L1:r(
                        c,
                        xx - 6,
                        323,
                        226,
                        5,
                        "#76563c"
                    )
                    do
                        local d = 0
                        while d < 3 do
                            __L1:r(
                                c,
                                xx + 2 + d * 72,
                                332,
                                63,
                                27,
                                "#805a3f"
                            )
                            __L1:r(
                                c,
                                xx + 7 + d * 72,
                                335,
                                53,
                                2,
                                "#bd9561"
                            )
                            __L1:r(
                                c,
                                xx + 26 + d * 72,
                                342,
                                15,
                                3,
                                "#d3be86"
                            )
                            d = d + 1
                        end
                    end
                    local colors = __arrL({"#67888c", "#b96851", "#d5b677"}, 3)
                    do
                        local j = 0
                        while j < 5 do
                            local bx = xx + 4 + j * 27
                            __L1:r(
                                c,
                                bx,
                                286 - __mod(j, 2) * 7,
                                10,
                                23 + __mod(j, 2) * 7,
                                __get(
                                    colors,
                                    __mod(j, 3)
                                )
                            )
                            __L1:r(
                                c,
                                bx + 2,
                                281 - __mod(j, 2) * 7,
                                6,
                                6,
                                "#28393e"
                            )
                            __L1:r(
                                c,
                                bx + 3,
                                290 - __mod(j, 2) * 7,
                                4,
                                4,
                                "#f0e4bb"
                            )
                            j = j + 1
                        end
                    end
                    __L1:r(
                        c,
                        xx + 153,
                        297,
                        31,
                        11,
                        "#d4dbcd"
                    )
                    do
                        local j = 0
                        while j < 6 do
                            __L1:r(
                                c,
                                xx + 155 + j * 4,
                                294,
                                2,
                                11,
                                "#28383d"
                            )
                            j = j + 1
                        end
                    end
                    __L1:r(
                        c,
                        xx + 192,
                        290,
                        7,
                        18,
                        "#46616b"
                    )
                    __L1:r(
                        c,
                        xx + 190,
                        286,
                        11,
                        6,
                        "#bcc6b7"
                    )
                    __L1:r(
                        c,
                        xx + 93,
                        40,
                        3,
                        47,
                        "#3f4140"
                    )
                    __L1:r(
                        c,
                        xx + 64,
                        86,
                        63,
                        8,
                        "#3b3c36"
                    )
                    __L1:poly(
                        c,
                        __arrL(
                            {
                                __arrL({xx + 68, 92}, 2),
                                __arrL({xx + 123, 92}, 2),
                                __arrL({xx + 114, 105}, 2),
                                __arrL({xx + 77, 105}, 2)
                            },
                            4
                        ),
                        "#b68a53"
                    )
                    __L1:r(
                        c,
                        xx + 83,
                        102,
                        27,
                        5,
                        "#ffe8a4"
                    )
                    __L1:barberChair(
                        c,
                        xx + 102,
                        435,
                        t + i,
                        i == 3 or i == 5
                    )
                    do
                        local k = 0
                        while k < 7 do
                            local hx = xx + 70 + k * 11
                            __L1:poly(
                                c,
                                __arrL(
                                    {
                                        __arrL({hx, 434}, 2),
                                        __arrL({hx + 4, 432}, 2),
                                        __arrL({hx + 7, 435}, 2)
                                    },
                                    3
                                ),
                                __t(__mod(k, 2)) and "#53493e" or "#403b34"
                            )
                            k = k + 1
                        end
                    end
                end
                do
                    xx = xx + 438
                    i = i + 1
                end
            end
        end
        __L1:r(
            c,
            292,
            49,
            523,
            63,
            "#28373b"
        )
        __L1:r(
            c,
            298,
            55,
            511,
            51,
            "#e1b16b"
        )
        __L1:r(
            c,
            302,
            59,
            503,
            43,
            "#34484c"
        )
        c.fillStyle = "#fae3a8"
        c.font = "bold 29px monospace"
        c:fillText("BIGODON", 481, 90)
        c.font = "bold 8px monospace"
        c.fillStyle = "#a8c9bd"
        c:fillText("CORTE NA RÉGUA, RESENHA SEM MEDIDA", 502, 102)
        for ____, side in __iterar((__arrL({-1, 1}, 2))) do
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({418, 77}, 2),
                        __arrL({418 + side * 11, 65}, 2),
                        __arrL({418 + side * 24, 66}, 2),
                        __arrL({418 + side * 40, 80}, 2),
                        __arrL({418 + side * 57, 76}, 2),
                        __arrL({418 + side * 49, 88}, 2),
                        __arrL({418 + side * 32, 91}, 2),
                        __arrL({418 + side * 17, 84}, 2),
                        __arrL({418, 80}, 2)
                    },
                    9
                ),
                "#e9c984"
            )
        end
        __L1:barberPole(c, 246, 150, t)
        __L1:barberPole(c, 1140, 150, t + 0.6)
        __L1:r(
            c,
            154,
            339,
            163,
            18,
            "#293d40"
        )
        __L1:r(
            c,
            160,
            357,
            151,
            57,
            "#996b46"
        )
        __L1:r(
            c,
            164,
            361,
            143,
            4,
            "#c59a65"
        )
        __L1:r(
            c,
            167,
            409,
            137,
            6,
            "#4a4437"
        )
        __L1:r(
            c,
            184,
            327,
            45,
            12,
            "#d6dfcf"
        )
        __L1:r(
            c,
            188,
            330,
            37,
            2,
            "#667e75"
        )
        __L1:r(
            c,
            269,
            312,
            22,
            27,
            "#293b42"
        )
        __L1:r(
            c,
            272,
            315,
            16,
            17,
            "#84b7b1"
        )
        __L1:r(
            c,
            278,
            333,
            4,
            4,
            "#e4cd96"
        )
        c.fillStyle = "#f0d9a8"
        c.font = "bold 9px monospace"
        c:fillText("RECEPÇÃO", 199, 352)
        __L1:r(
            c,
            1285,
            231,
            229,
            22,
            "#2e4141"
        )
        do
            local j = 0
            while j < 5 do
                __L1:r(
                    c,
                    1293 + j * 41,
                    218,
                    33,
                    13,
                    "#ece1c4"
                )
                __L1:r(
                    c,
                    1296 + j * 41,
                    220,
                    27,
                    2,
                    "#fff5dd"
                )
                __L1:r(
                    c,
                    1296 + j * 41,
                    228,
                    27,
                    2,
                    "#b9bcae"
                )
                j = j + 1
            end
        end
        __L1:oval(
            c,
            1365,
            143,
            31,
            31,
            "#344549",
            3
        )
        __L1:oval(
            c,
            1365,
            143,
            25,
            25,
            "#f1dfb5",
            3
        )
        do
            local i = 0
            while i < 12 do
                local a = i * math.pi / 6
                __L1:r(
                    c,
                    1364 + math.cos(a) * 21,
                    142 + math.sin(a) * 21,
                    2,
                    2,
                    "#795a3d"
                )
                i = i + 1
            end
        end
        __L1:limb(
            c,
            __arrL(
                {
                    __arrL({1365, 143}, 2),
                    __arrL(
                        {
                            1365 + math.sin(t * 0.03) * 15,
                            143 - math.cos(t * 0.03) * 15
                        },
                        2
                    )
                },
                2
            ),
            2,
            "#5d4a37"
        )
        __L1:limb(
            c,
            __arrL(
                {
                    __arrL({1365, 143}, 2),
                    __arrL({1355, 137}, 2)
                },
                2
            ),
            3,
            "#5d4a37"
        )
        do
            local x = 1740
            while x < width - 130 do
                __L1:r(
                    c,
                    x,
                    366,
                    214,
                    57,
                    "#273a3d"
                )
                __L1:r(
                    c,
                    x + 5,
                    371,
                    204,
                    42,
                    "#986553"
                )
                __L1:r(
                    c,
                    x,
                    353,
                    214,
                    18,
                    "#a77158"
                )
                __L1:r(
                    c,
                    x + 5,
                    354,
                    204,
                    4,
                    "#cc9c76"
                )
                __L1:r(
                    c,
                    x + 10,
                    423,
                    9,
                    17,
                    "#344342"
                )
                __L1:r(
                    c,
                    x + 193,
                    423,
                    9,
                    17,
                    "#344342"
                )
                do
                    local j = 0
                    while j < 3 do
                        __L1:r(
                            c,
                            x + 15 + j * 64,
                            376,
                            53,
                            32,
                            "#875648"
                        )
                        __L1:r(
                            c,
                            x + 18 + j * 64,
                            378,
                            47,
                            3,
                            "#b78261"
                        )
                        j = j + 1
                    end
                end
                __L1:backgroundCitizen(
                    c,
                    x + 63,
                    388,
                    t,
                    math.floor(x / 650),
                    true
                )
                x = x + 650
            end
        end
        __L1:r(
            c,
            2920,
            117,
            228,
            105,
            "#303b3f"
        )
        __L1:r(
            c,
            2925,
            122,
            218,
            95,
            "#8c6247"
        )
        c.fillStyle = "#f2d69e"
        c.font = "bold 16px monospace"
        c:fillText("AQUI O PAPO", 2951, 151)
        c:fillText("RENDE MAIS", 2951, 176)
        c.font = "bold 11px monospace"
        c:fillText("QUE O DEGRADÊ.", 2970, 201)
        c:restore()
        local fanX = 760 - camera * 0.18
        local angle = t * 8
        c:save()
        c:translate(fanX, 82)
        __L1:r(
            c,
            -2,
            -82,
            4,
            80,
            "#3e4946"
        )
        do
            local i = 0
            while i < 3 do
                local a = angle + i * math.pi * 2 / 3
                local dx = math.cos(a)
                local dy = math.sin(a) * 0.34
                __L1:poly(
                    c,
                    __arrL(
                        {
                            __arrL({dx * 5 - dy * 4, dy * 5 + dx * 3}, 2),
                            __arrL({dx * 50 - dy * 4, dy * 50 + dx * 4}, 2),
                            __arrL({dx * 48 + dy * 5, dy * 48 - dx * 4}, 2),
                            __arrL({dx * 8 + dy * 4, dy * 8 - dx * 3}, 2)
                        },
                        4
                    ),
                    "#65736b"
                )
                i = i + 1
            end
        end
        __L1:oval(
            c,
            0,
            0,
            7,
            5,
            "#334344",
            2
        )
        c:restore()
        do
            local i = 0
            while i < 14 do
                local dx = __mod(
                    __mod(i * 113 + t * 4 - camera * 0.36, 1040) + 1040,
                    1040
                ) - 40
                local dy = 80 + __mod(i * 31 + t * 6, 290)
                __L1:r(
                    c,
                    dx,
                    dy,
                    2,
                    2,
                    __t(__mod(i, 2)) and "#f4d79b88" or "#f5e9be66"
                )
                i = i + 1
            end
        end
    end
    __L1.drawScene = function(self, c, scene, camera, t)
        if camera == nil then
            camera = 0
        end
        if t == nil then
            t = 0
        end
        c:save()
        c.imageSmoothingEnabled = false
        c:beginPath()
        c:rect(0, 0, 960, 540)
        c:clip()
        local ____t_result_59
        local ____t_58 = __t
        local ____TS__Number_result_57 = __TS__Number(camera)
        __O[159] = ____TS__Number_result_57
        if ____t_58(____TS__Number_result_57) then
            ____t_result_59 = __O[159]
        else
            ____t_result_59 = 0
        end
        camera = ____t_result_59
        local ____t_result_62
        local ____t_61 = __t
        local ____TS__Number_result_60 = __TS__Number(t)
        __O[160] = ____TS__Number_result_60
        if ____t_61(____TS__Number_result_60) then
            ____t_result_62 = __O[160]
        else
            ____t_result_62 = 0
        end
        t = ____t_result_62
        __L1.animT = t
        __L1.animCam = 0
        local ____t_68 = __t
        local ____opt_65 = window.Graphics
        if ____opt_65 ~= nil then
            ____opt_65 = ____opt_65.isLite
        end
        local ____opt_result_67
        if ____opt_65 ~= nil then
            ____opt_result_67 = ____opt_65(____opt_65)
        end
        __L1.liteNow = not not ____t_68(____opt_result_67)
        if scene == 11 then
            local ____t_71 = __t
            local ____opt_69 = window.BaileWorld
            if ____opt_69 ~= nil then
                ____opt_69 = ____opt_69.draw
            end
            if ____t_71(____opt_69) then
                window.BaileWorld:draw(c, camera, t, {hideOllyan = true})
            else
                __L1:r(
                    c,
                    0,
                    0,
                    960,
                    440,
                    "#111526"
                )
                __L1:r(
                    c,
                    0,
                    440,
                    960,
                    100,
                    "#31324d"
                )
                __L1:r(
                    c,
                    0,
                    440,
                    960,
                    5,
                    "#7892c3"
                )
            end
            c:restore()
            return
        end
        local ____t_80 = __t
        local ____t_result_79
        local ____t_73 = __t
        local ____temp_72 = not __t(__L1.liteNow) or __ge(scene, 40)
        __O[161] = ____temp_72
        if ____t_73(____temp_72) then
            local ____opt_76 = window.HdMaps
            if ____opt_76 ~= nil then
                ____opt_76 = ____opt_76.draw
            end
            local ____opt_result_78
            if ____opt_76 ~= nil then
                ____opt_result_78 = ____opt_76(
                    ____opt_76,
                    c,
                    scene,
                    camera,
                    t
                )
            end
            ____t_result_79 = ____opt_result_78
        else
            ____t_result_79 = __O[161]
        end
        if ____t_80(____t_result_79) then
            __L1:groundBridges(c, scene, camera, t)
            window.HdMaps:finish(c, scene)
            c:restore()
            return
        end
        __L1:sky(c, scene, camera, t)
        if scene == 1 then
            __L1:school(c, camera, t)
        elseif scene == 2 then
            __L1:gym(c, camera, t)
        elseif scene == 3 then
            __L1:court(c, camera, t)
        elseif scene == 4 then
            __L1:plaza(c, camera, t)
        elseif scene == 5 then
            __L1:favela(c, camera, t)
        elseif scene == 6 then
            __L1:inkRealm(c, camera, t)
        elseif scene == 7 then
            __L1:footballField(c, camera, t)
        elseif scene == 8 then
            __L1:bigodon(c, camera, t)
        elseif scene == 9 then
            __L1:courtyard(c, camera, t)
        elseif scene == 10 then
            __L1:rayssaHouse(c, camera, t)
        else
            __L1:farm(c, camera, t)
        end
        local ____t_84 = __t
        local ____t_result_83
        local ____t_82 = __t
        local ____temp_81 = scene ~= 2 and scene ~= 8
        __O[162] = ____temp_81
        if ____t_82(____temp_81) then
            ____t_result_83 = scene ~= 10
        else
            ____t_result_83 = __O[162]
        end
        if ____t_84(____t_result_83) then
            do
                local i = 0
                while i < 13 do
                    local lx = __mod(
                        __mod(i * 137 + t * 13 - camera * 0.65, 1120) + 1120,
                        1120
                    ) - 80
                    local ly = 158 + __mod(i * 43 + t * 15, 235)
                    __L1:r(
                        c,
                        lx,
                        ly,
                        5,
                        2,
                        __t(__mod(i, 2)) and "#8bb65a" or "#b2c56c"
                    )
                    __L1:r(
                        c,
                        lx + math.floor(math.sin(t * 5 + i) * 2 + 0.5),
                        ly + 2,
                        3,
                        2,
                        "#5e954c"
                    )
                    i = i + 1
                end
            end
        end
        if not __t(__L1.liteNow) then
            __L1:wallDecor(c, scene, camera, t)
            __L1:facadeTexture(c, scene, camera)
            __L1:liveBackground(c, scene, camera, t)
        end
        __L1:worldExtensions(c, scene, camera, t)
        __L1:ground(c, camera, scene)
        __L1:groundBridges(c, scene, camera, t)
        __L1:lightPass(c, scene, camera, t)
        c:restore()
    end
    __L1.woodenBridge = function(self, c, x, width, t, scene, feet, depth)
        if t == nil then
            t = 0
        end
        if scene == nil then
            scene = 0
        end
        if feet == nil then
            feet = 440
        end
        if depth == nil then
            depth = 100
        end
        local ink = scene == 6 and "#4b3559" or "#57422f"
        local wood = scene == 6 and "#95749f" or "#a87947"
        local lit = scene == 6 and "#d8b7c4" or "#e0b66f"
        local bottom = math.min(540, feet + depth)
        __L1:r(
            c,
            x,
            feet + 13,
            width,
            bottom - feet - 13,
            scene == 6 and "#4e416c" or "#3a7581"
        )
        do
            local i = 0
            while i < math.ceil(width / 36) + 1 do
                local xx = x + __mod(
                    i * 37 + t * 15,
                    math.max(1, width)
                )
                __L1:r(
                    c,
                    xx,
                    feet + 25 + __mod(i, 4) * 15,
                    math.min(
                        19,
                        __add(x, width) - xx
                    ),
                    2,
                    scene == 6 and "#a8a1c6" or "#8bc8cd"
                )
                i = i + 1
            end
        end
        do
            local xx = x - 6
            while __lt(
                xx,
                __add(x, width) + 10
            ) do
                __L1:r(
                    c,
                    xx,
                    feet - 40,
                    7,
                    44,
                    ink
                )
                __L1:r(
                    c,
                    xx + 1,
                    feet - 39,
                    2,
                    36,
                    lit
                )
                __L1:r(
                    c,
                    xx - 2,
                    feet - 43,
                    11,
                    5,
                    wood
                )
                xx = xx + 66
            end
        end
        __L1:r(
            c,
            x - 10,
            feet - 32,
            width + 20,
            7,
            ink
        )
        __L1:r(
            c,
            x - 9,
            feet - 32,
            width + 18,
            3,
            wood
        )
        __L1:r(
            c,
            x - 10,
            feet - 15,
            width + 20,
            5,
            ink
        )
        __L1:r(
            c,
            x - 9,
            feet - 15,
            width + 18,
            2,
            wood
        )
        __L1:r(
            c,
            x - 12,
            feet,
            width + 24,
            15,
            ink
        )
        __L1:r(
            c,
            x - 12,
            feet,
            width + 24,
            3,
            lit
        )
        do
            local xx = x - 8
            while __lt(
                xx,
                __add(x, width) + 9
            ) do
                local ww = math.min(
                    14,
                    __add(x, width) + 10 - xx
                )
                __L1:r(
                    c,
                    xx,
                    feet + 3,
                    ww,
                    9,
                    wood
                )
                __L1:r(
                    c,
                    xx + 1,
                    feet + 4,
                    math.max(1, ww - 2),
                    2,
                    lit
                )
                __L1:r(
                    c,
                    xx + 2,
                    feet + 8,
                    2,
                    2,
                    ink
                )
                xx = xx + 16
            end
        end
        __L1:r(
            c,
            x - 10,
            feet + 15,
            width + 20,
            7,
            ink
        )
        __L1:r(
            c,
            x - 9,
            feet + 16,
            width + 18,
            3,
            "#82603e"
        )
        do
            local xx = x + 10
            while __lt(
                xx,
                __add(x, width)
            ) do
                __L1:r(
                    c,
                    xx,
                    feet + 20,
                    9,
                    math.max(0, bottom - feet - 20),
                    ink
                )
                __L1:r(
                    c,
                    xx + 2,
                    feet + 22,
                    2,
                    math.max(0, bottom - feet - 22),
                    wood
                )
                __L1:poly(
                    c,
                    __arrL(
                        {
                            __arrL({xx + 7, feet + 23}, 2),
                            __arrL({xx + 40, feet + 23}, 2),
                            __arrL({xx + 7, feet + 56}, 2)
                        },
                        3
                    ),
                    "#6e5236"
                )
                xx = xx + 94
            end
        end
        __L1:r(
            c,
            x - 20,
            feet - 1,
            9,
            7,
            "#b49a65"
        )
        __L1:r(
            c,
            __add(x, width) + 12,
            feet - 1,
            9,
            7,
            "#b49a65"
        )
    end
    __L1.groundBridges = function(self, c, scene, camera, t)
        local ____t_result_90
        local ____t_89 = __t
        local ____getq_87 = __getq
        local ____opt_85 = window.WorldData
        if ____opt_85 ~= nil then
            ____opt_85 = ____opt_85.gaps
        end
        local ____getq_87_result_88 = ____getq_87(____opt_85, scene)
        __O[163] = ____getq_87_result_88
        if ____t_89(____getq_87_result_88) then
            ____t_result_90 = __O[163]
        else
            ____t_result_90 = __arrL({}, 0)
        end
        local gaps = ____t_result_90
        if not __t(__len(gaps)) then
            return
        end
        c:save()
        c:translate(
            -math.floor(camera + 0.5),
            0
        )
        for ____, g in __iterar((gaps)) do
            do
                local x = __TS__Number(__get(g, 0))
                local w = __TS__Number(__get(g, 1))
                local ____t_98 = __t
                local ____t_result_97
                local ____t_96 = __t
                local ____t_result_95
                local ____t_94 = __t
                local ____t_result_93
                local ____t_92 = __t
                local ____temp_91 = not __isFiniteN(x) or not __isFiniteN(w)
                __O[164] = ____temp_91
                if ____t_92(____temp_91) then
                    ____t_result_93 = __O[164]
                else
                    ____t_result_93 = w <= 0
                end
                __O[165] = ____t_result_93
                if ____t_94(____t_result_93) then
                    ____t_result_95 = __O[165]
                else
                    ____t_result_95 = x + w < camera - 25
                end
                __O[166] = ____t_result_95
                if ____t_96(____t_result_95) then
                    ____t_result_97 = __O[166]
                else
                    ____t_result_97 = __gt(x, camera + 985)
                end
                if ____t_98(____t_result_97) then
                    continue
                end
                __L1:woodenBridge(
                    c,
                    x,
                    w,
                    t,
                    scene
                )
            end
        end
        c:restore()
    end
    __L1.titleChicken = function(self, c, x, y, t, rooster)
        if t == nil then
            t = 0
        end
        if rooster == nil then
            rooster = false
        end
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        local step = math.floor(math.sin(t * 8) * 2 + 0.5)
        __L1:r(
            c,
            -6,
            0,
            3,
            5 + step,
            "#d89536"
        )
        __L1:r(
            c,
            5,
            0,
            3,
            5 - step,
            "#d89536"
        )
        __L1:r(
            c,
            -8,
            4 + step,
            6,
            2,
            "#bd742c"
        )
        __L1:r(
            c,
            4,
            4 - step,
            7,
            2,
            "#bd742c"
        )
        __L1:oval(
            c,
            0,
            -7,
            12,
            9,
            __t(rooster) and "#b27b4b" or "#fcf2d9",
            2
        )
        __L1:r(
            c,
            -13,
            -12,
            6,
            7,
            __t(rooster) and "#315e49" or "#d8d5bd"
        )
        __L1:r(
            c,
            -15,
            -15,
            5,
            5,
            __t(rooster) and "#28533d" or "#e8dfc2"
        )
        __L1:r(
            c,
            5,
            -20,
            9,
            14,
            __t(rooster) and "#d9aa64" or "#fff9e4"
        )
        __L1:r(
            c,
            7,
            -23,
            7,
            5,
            "#c75741"
        )
        __L1:r(
            c,
            12,
            -18,
            5,
            4,
            "#e1a039"
        )
        __L1:r(
            c,
            10,
            -18,
            2,
            2,
            "#483a32"
        )
        __L1:r(
            c,
            8,
            -8,
            4,
            5,
            "#c9513a"
        )
        __L1:r(
            c,
            -3,
            -11 + math.floor(math.sin(t * 3) + 0.5),
            9,
            6,
            __t(rooster) and "#8e603e" or "#e2ddc6"
        )
        __L1:r(
            c,
            -2,
            -10,
            7,
            2,
            __t(rooster) and "#c58b52" or "#fff8df"
        )
        c:restore()
    end
    __L1.titleWindmill = function(self, c, x, y, t)
        c:save()
        c:translate(x, y)
        __L1:poly(
            c,
            __arrL(
                {
                    __arrL({-24, 0}, 2),
                    __arrL({-18, -138}, 2),
                    __arrL({16, -138}, 2),
                    __arrL({29, 0}, 2)
                },
                4
            ),
            "#cbbd8b"
        )
        __L1:r(
            c,
            -18,
            -130,
            31,
            128,
            "#e7d9ae"
        )
        __L1:r(
            c,
            -11,
            -48,
            17,
            48,
            "#596954"
        )
        __L1:r(
            c,
            -6,
            -42,
            7,
            41,
            "#3d5647"
        )
        __L1:r(
            c,
            -12,
            -94,
            12,
            19,
            "#6b9794"
        )
        __L1:r(
            c,
            -10,
            -92,
            8,
            12,
            "#a8cdd0"
        )
        __L1:poly(
            c,
            __arrL(
                {
                    __arrL({-32, -134}, 2),
                    __arrL({0, -164}, 2),
                    __arrL({34, -134}, 2)
                },
                3
            ),
            "#9f6345"
        )
        __L1:r(
            c,
            -33,
            -135,
            68,
            7,
            "#704b36"
        )
        __L1:r(
            c,
            -26,
            -135,
            52,
            3,
            "#d39b61"
        )
        c:save()
        c:translate(0, -134)
        c:rotate(t * 0.28)
        do
            local i = 0
            while i < 4 do
                c:save()
                c:rotate(i * math.pi / 2)
                __L1:r(
                    c,
                    -3,
                    -85,
                    6,
                    90,
                    "#715e41"
                )
                __L1:r(
                    c,
                    3,
                    -82,
                    22,
                    54,
                    "#bea574"
                )
                __L1:r(
                    c,
                    5,
                    -79,
                    17,
                    46,
                    "#e0c693"
                )
                do
                    local yy = -76
                    while yy < -30 do
                        __L1:r(
                            c,
                            5,
                            yy,
                            18,
                            2,
                            "#8b7550"
                        )
                        yy = yy + 12
                    end
                end
                __L1:r(
                    c,
                    12,
                    -81,
                    2,
                    51,
                    "#8b7550"
                )
                c:restore()
                i = i + 1
            end
        end
        __L1:oval(
            c,
            0,
            0,
            9,
            9,
            "#634d36",
            2
        )
        __L1:oval(
            c,
            0,
            -1,
            5,
            5,
            "#d8b36b",
            2
        )
        c:restore()
        c:restore()
    end
    __L1.drawTitleScene = function(self, c, time, width, height)
        if time == nil then
            time = 0
        end
        if width == nil then
            width = 960
        end
        if height == nil then
            height = 540
        end
        c:save()
        c.imageSmoothingEnabled = false
        local ____t_result_101
        local ____t_100 = __t
        local ____TS__Number_result_99 = __TS__Number(time)
        __O[167] = ____TS__Number_result_99
        if ____t_100(____TS__Number_result_99) then
            ____t_result_101 = __O[167]
        else
            ____t_result_101 = 0
        end
        local t = ____t_result_101
        local ____c_109 = c
        local ____c_scale_110 = c.scale
        local ____t_result_104
        local ____t_103 = __t
        local ____TS__Number_result_102 = __TS__Number(width)
        __O[168] = ____TS__Number_result_102
        if ____t_103(____TS__Number_result_102) then
            ____t_result_104 = __O[168]
        else
            ____t_result_104 = 960
        end
        local ____temp_108 = ____t_result_104 / 960
        local ____t_result_107
        local ____t_106 = __t
        local ____TS__Number_result_105 = __TS__Number(height)
        __O[169] = ____TS__Number_result_105
        if ____t_106(____TS__Number_result_105) then
            ____t_result_107 = __O[169]
        else
            ____t_result_107 = 540
        end
        ____c_scale_110(____c_109, ____temp_108, ____t_result_107 / 540)
        __L1:r(
            c,
            0,
            0,
            960,
            115,
            "#6bb4e6"
        )
        __L1:r(
            c,
            0,
            115,
            960,
            115,
            "#8bcbea"
        )
        __L1:r(
            c,
            0,
            230,
            960,
            190,
            "#b9e3e8"
        )
        __L1:oval(
            c,
            801,
            73,
            38,
            38,
            "#fff4bd",
            3
        )
        __L1:oval(
            c,
            795,
            67,
            29,
            29,
            "#fff8d9",
            3
        )
        c:save()
        c.globalAlpha = 0.1
        __L1:poly(
            c,
            __arrL(
                {
                    __arrL({776, 57}, 2),
                    __arrL({768, 64}, 2),
                    __arrL({534, 423}, 2),
                    __arrL({629, 445}, 2)
                },
                4
            ),
            "#fff5c4"
        )
        __L1:poly(
            c,
            __arrL(
                {
                    __arrL({811, 67}, 2),
                    __arrL({803, 72}, 2),
                    __arrL({823, 452}, 2),
                    __arrL({939, 410}, 2)
                },
                4
            ),
            "#fff5c4"
        )
        c:restore()
        do
            local i = -1
            while i < 6 do
                local xx = __mod(
                    i * 237 + t * (2 + __mod(i, 2)) + 1500,
                    1500
                ) - 220
                __L1:cloud(
                    c,
                    xx,
                    48 + __mod(i, 3) * 34,
                    1.15 + __mod(i, 2) * 0.3,
                    "#fff8e4"
                )
                i = i + 1
            end
        end
        do
            local i = -1
            while i < 5 do
                __L1:steppedHill(
                    c,
                    i * 275 - 90,
                    220 + __L1:hash(i + 30) * 36,
                    410,
                    194,
                    "#82b6a5"
                )
                i = i + 1
            end
        end
        do
            local i = -1
            while i < 5 do
                __L1:steppedHill(
                    c,
                    i * 290 - 70,
                    282 + __L1:hash(i + 47) * 23,
                    430,
                    176,
                    "#51956c"
                )
                i = i + 1
            end
        end
        __L1:r(
            c,
            0,
            347,
            960,
            193,
            "#76b451"
        )
        __L1:r(
            c,
            0,
            365,
            960,
            51,
            "#8ac15b"
        )
        do
            local i = 0
            while i < 22 do
                local xx = i * 49 + math.sin(i) * 12
                __L1:tree(
                    c,
                    xx,
                    370,
                    0.27 + __mod(i, 3) * 0.035
                )
                i = i + 1
            end
        end
        __L1:r(
            c,
            0,
            382,
            960,
            17,
            "#85b552"
        )
        __L1:r(
            c,
            0,
            397,
            960,
            143,
            "#9bc260"
        )
        __L1:titleWindmill(c, 836, 375, t)
        __L1:house(c, 84, 433)
        __L1:r(
            c,
            108,
            437,
            130,
            5,
            "#a8bb61"
        )
        do
            local i = 0
            while i < 4 do
                local xx = 238 + math.sin(t * 0.3 + i) * 8
                local yy = 253 - __mod(t * 10 + i * 14, 57)
                __L1:oval(
                    c,
                    xx,
                    yy,
                    7 + i * 2,
                    4 + i * 2,
                    "#e5e7cb",
                    3
                )
                i = i + 1
            end
        end
        __L1:r(
            c,
            643,
            344,
            125,
            95,
            "#ab6b47"
        )
        __L1:r(
            c,
            648,
            348,
            115,
            90,
            "#ce8b55"
        )
        __L1:poly(
            c,
            __arrL(
                {
                    __arrL({631, 346}, 2),
                    __arrL({668, 302}, 2),
                    __arrL({735, 302}, 2),
                    __arrL({779, 346}, 2)
                },
                4
            ),
            "#8b4d3c"
        )
        do
            local row = 0
            while row < 4 do
                local xx = 666 - row * 9
                local ww = 71 + row * 21
                __L1:r(
                    c,
                    xx,
                    306 + row * 10,
                    ww,
                    8,
                    __t(__mod(row, 2)) and "#bd6547" or "#d47b4c"
                )
                do
                    local k = 0
                    while k < ww do
                        __L1:r(
                            c,
                            xx + k,
                            306 + row * 10,
                            2,
                            7,
                            "#efb06c"
                        )
                        k = k + 19
                    end
                end
                row = row + 1
            end
        end
        __L1:r(
            c,
            632,
            344,
            145,
            6,
            "#764b37"
        )
        __L1:r(
            c,
            682,
            369,
            46,
            70,
            "#654e38"
        )
        __L1:r(
            c,
            686,
            373,
            38,
            65,
            "#815738"
        )
        __L1:r(
            c,
            702,
            374,
            4,
            64,
            "#cda06a"
        )
        __L1:limb(
            c,
            __arrL(
                {
                    __arrL({688, 375}, 2),
                    __arrL({723, 432}, 2)
                },
                2
            ),
            4,
            "#cda06a"
        )
        __L1:limb(
            c,
            __arrL(
                {
                    __arrL({722, 375}, 2),
                    __arrL({687, 432}, 2)
                },
                2
            ),
            4,
            "#cda06a"
        )
        __L1:r(
            c,
            651,
            366,
            23,
            25,
            "#6b7970"
        )
        __L1:r(
            c,
            654,
            369,
            17,
            18,
            "#a9c9b1"
        )
        __L1:r(
            c,
            661,
            368,
            3,
            21,
            "#e8c98b"
        )
        __L1:r(
            c,
            651,
            378,
            23,
            3,
            "#e8c98b"
        )
        __L1:r(
            c,
            741,
            375,
            22,
            33,
            "#c7b47b"
        )
        do
            local i = 0
            while i < 2 do
                local xx = 615 + i * 27
                __L1:r(
                    c,
                    xx,
                    421,
                    25,
                    20,
                    "#a28b45"
                )
                __L1:r(
                    c,
                    xx + 2,
                    422,
                    21,
                    16,
                    "#d3b65c"
                )
                __L1:r(
                    c,
                    xx + 4,
                    425,
                    17,
                    3,
                    "#e7cd74"
                )
                __L1:r(
                    c,
                    xx + 10,
                    422,
                    3,
                    18,
                    "#8f783d"
                )
                i = i + 1
            end
        end
        __L1:poly(
            c,
            __arrL(
                {
                    __arrL({951, 346}, 2),
                    __arrL({960, 350}, 2),
                    __arrL({960, 540}, 2),
                    __arrL({724, 540}, 2),
                    __arrL({769, 484}, 2),
                    __arrL({798, 438}, 2),
                    __arrL({845, 396}, 2),
                    __arrL({889, 371}, 2)
                },
                8
            ),
            "#4d9eb0"
        )
        __L1:poly(
            c,
            __arrL(
                {
                    __arrL({956, 351}, 2),
                    __arrL({960, 351}, 2),
                    __arrL({960, 540}, 2),
                    __arrL({746, 540}, 2),
                    __arrL({789, 484}, 2),
                    __arrL({814, 441}, 2),
                    __arrL({860, 402}, 2),
                    __arrL({902, 375}, 2)
                },
                8
            ),
            "#7bc1cb"
        )
        do
            local i = 0
            while i < 30 do
                do
                    local xx = 780 + __L1:hash(i + 80) * 173
                    local yy = 383 + __L1:hash(i + 90) * 151 + math.sin(t * 1.2 + i) * 2
                    if __t(xx < 800 and yy < 471) then
                        do i = i + 1 continue end
                    end
                    __L1:r(
                        c,
                        xx,
                        yy,
                        10 + __L1:hash(i) * 17,
                        2,
                        __t(__mod(i, 3)) and "#b4e6df" or "#e8f7e5"
                    )
                end
                i = i + 1
            end
        end
        __L1:woodenBridge(
            c,
            787,
            110,
            t,
            0,
            450,
            90
        )
        __L1:poly(
            c,
            __arrL(
                {
                    __arrL({428, 389}, 2),
                    __arrL({498, 389}, 2),
                    __arrL({508, 417}, 2),
                    __arrL({549, 457}, 2),
                    __arrL({586, 540}, 2),
                    __arrL({349, 540}, 2),
                    __arrL({390, 471}, 2),
                    __arrL({418, 430}, 2)
                },
                8
            ),
            "#cbaa71"
        )
        __L1:poly(
            c,
            __arrL(
                {
                    __arrL({439, 392}, 2),
                    __arrL({483, 392}, 2),
                    __arrL({491, 420}, 2),
                    __arrL({529, 461}, 2),
                    __arrL({560, 540}, 2),
                    __arrL({378, 540}, 2),
                    __arrL({410, 474}, 2),
                    __arrL({437, 430}, 2)
                },
                8
            ),
            "#dfc28a"
        )
        do
            local i = 0
            while i < 42 do
                local yy = 408 + __L1:hash(i + 9) * 129
                local span = 27 + (yy - 400) * 0.46
                local xx = 463 + (__L1:hash(i + 14) - 0.5) * span * 2
                __L1:r(
                    c,
                    xx,
                    yy,
                    4 + __L1:hash(i) * 4,
                    2,
                    __t(__mod(i, 2)) and "#bca174" or "#ebd3a0"
                )
                i = i + 1
            end
        end
        __L1:fence(c, 16, 459, 286)
        __L1:fence(c, 574, 452, 173)
        do
            local row = 0
            while row < 3 do
                local yy = 481 + row * 23
                __L1:r(
                    c,
                    32,
                    yy,
                    282,
                    15,
                    "#9b703f"
                )
                __L1:r(
                    c,
                    34,
                    yy + 1,
                    278,
                    2,
                    "#c9954f"
                )
                do
                    local j = 0
                    while j < 14 do
                        local xx = 43 + j * 19
                        local wave = math.floor(math.sin(t * 1.6 + j * 0.4 + row) * 2 + 0.5)
                        __L1:r(
                            c,
                            xx,
                            yy - 17,
                            3,
                            18,
                            "#4a8338"
                        )
                        __L1:poly(
                            c,
                            __arrL(
                                {
                                    __arrL({xx, yy - 6}, 2),
                                    __arrL({xx - 7 + wave, yy - 15}, 2),
                                    __arrL({xx - 10 + wave, yy - 12}, 2),
                                    __arrL({xx, yy}, 2)
                                },
                                4
                            ),
                            "#3a833a"
                        )
                        __L1:poly(
                            c,
                            __arrL(
                                {
                                    __arrL({xx + 2, yy - 8}, 2),
                                    __arrL({xx + 9 + wave, yy - 18}, 2),
                                    __arrL({xx + 12 + wave, yy - 14}, 2),
                                    __arrL({xx + 2, yy - 2}, 2)
                                },
                                4
                            ),
                            "#8bbb43"
                        )
                        __L1:r(
                            c,
                            xx - 1,
                            yy - 22,
                            6,
                            11,
                            "#edcb5a"
                        )
                        __L1:r(
                            c,
                            xx,
                            yy - 21,
                            2,
                            7,
                            "#fff09b"
                        )
                        j = j + 1
                    end
                end
                row = row + 1
            end
        end
        do
            local i = 0
            while i < 48 do
                do
                    local xx = 14 + __L1:hash(i + 37) * 930
                    local yy = 443 + __L1:hash(i + 61) * 93
                    local ____t_114 = __t
                    local ____t_result_113
                    local ____t_112 = __t
                    local ____temp_111 = xx > 342 and xx < 581
                    __O[170] = ____temp_111
                    if ____t_112(____temp_111) then
                        ____t_result_113 = __O[170]
                    else
                        ____t_result_113 = xx > 760 and xx < 955
                    end
                    if ____t_114(____t_result_113) then
                        do i = i + 1 continue end
                    end
                    __L1:grass(c, xx, yy, i)
                    if __mod(i, 3) == 0 then
                        __L1:flower(
                            c,
                            xx + 6 + math.sin(t * 1.1 + i) * 1.6,
                            yy - 1,
                            __get(
                                __arrL({"#f2ce5b", "#f2e9b5", "#d88e89", "#b7b9de"}, 4),
                                __mod(i, 4)
                            )
                        )
                    end
                end
                i = i + 1
            end
        end
        __L1:titleChicken(
            c,
            585 + math.sin(t * 0.35) * 24,
            471,
            t,
            true
        )
        __L1:titleChicken(
            c,
            630 + math.sin(t * 0.28 + 1) * 28,
            481,
            t + 0.8,
            false
        )
        __L1:titleChicken(
            c,
            613 + math.sin(t * 0.25 + 2) * 30,
            452,
            t + 2,
            false
        )
        do
            local i = 0
            while i < 7 do
                local xx = 190 + i * 107 + math.sin(t * 0.7 + i) * 24
                local yy = 360 + math.sin(t * 1.1 + i * 2) * 17
                local wing = 1 + math.abs(math.sin(t * 8 + i)) * 4
                __L1:r(
                    c,
                    xx - wing - 1,
                    yy - 2,
                    wing,
                    4,
                    __t(__mod(i, 2)) and "#e8b15e" or "#e7a7aa"
                )
                __L1:r(
                    c,
                    xx + 1,
                    yy - 2,
                    wing,
                    4,
                    "#fff0af"
                )
                __L1:r(
                    c,
                    xx,
                    yy - 2,
                    1,
                    5,
                    "#597450"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 6 do
                local xx = __mod(i * 193 + t * 11, 1150) - 80
                local yy = 114 + __mod(i, 3) * 28
                local flap = math.floor(math.sin(t * 8 + i) * 3 + 0.5)
                __L1:r(
                    c,
                    xx,
                    yy,
                    3,
                    2,
                    "#577e87"
                )
                __L1:r(
                    c,
                    xx - 4,
                    yy - 2 + flap,
                    4,
                    2,
                    "#577e87"
                )
                __L1:r(
                    c,
                    xx + 3,
                    yy - 2 + flap,
                    4,
                    2,
                    "#577e87"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 19 do
                local xx = __mod(
                    i * 73 + t * (2 + __mod(i, 3)),
                    1020
                ) - 30
                local yy = 305 + __mod(i * 43 + t * 6, 228)
                __L1:r(
                    c,
                    xx,
                    yy,
                    2,
                    2,
                    __t(__mod(i, 2)) and "#f7e7a5" or "#b8d879"
                )
                i = i + 1
            end
        end
        __L1:tree(c, -18, 548, 1.45)
        __L1:tree(c, 976, 557, 1.5)
        __L1:bush(
            c,
            6,
            538,
            128,
            "#4b8a42"
        )
        __L1:bush(
            c,
            934,
            544,
            125,
            "#4c8c44"
        )
        c:restore()
    end
    __L1.limb = function(self, c, points, width, color)
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
                        __L1:r(
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
    __L1.energyAura = function(self, c, x, y, t, o)
        if t == nil then
            t = 0
        end
        if o == nil then
            o = {}
        end
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        local ____t_result_117
        local ____t_116 = __t
        local ____TS__Number_result_115 = __TS__Number(o.scale)
        __O[171] = ____TS__Number_result_115
        if ____t_116(____TS__Number_result_115) then
            ____t_result_117 = __O[171]
        else
            ____t_result_117 = 1
        end
        local s = ____t_result_117
        local ____t_result_120
        local ____t_119 = __t
        local ____TS__Number_result_118 = __TS__Number(o.intensity)
        __O[172] = ____TS__Number_result_118
        if ____t_119(____TS__Number_result_118) then
            ____t_result_120 = __O[172]
        else
            ____t_result_120 = 0.7
        end
        local intensity = math.max(
            0.15,
            math.min(1, ____t_result_120)
        )
        c:scale(s, s)
        local red = not not __t(o.red) or type(o.color) == "string"
        local ____t_result_121
        if __t(red) then
            ____t_result_121 = __arrL({
                "#f33b35",
                "#ff7162",
                "#ffd8b8",
                "#ff4a48",
                "#ff9b7c",
                "#fff1df"
            }, 6)
        else
            ____t_result_121 = __arrL({
                "#f39425",
                "#ffdd41",
                "#fff6ba",
                "#ffc435",
                "#ffce42",
                "#fff9dc"
            }, 6)
        end
        local glow = ____t_result_121
        local pulse = math.sin(t * 13) * 2
        local tip = -96 - pulse
        local alpha = c.globalAlpha
        local outer = __arrL(
            {
                __arrL({-30, 0}, 2),
                __arrL({-39, -24}, 2),
                __arrL({-27, -30}, 2),
                __arrL({-37, -58}, 2),
                __arrL({-20, -54}, 2),
                __arrL({-22, -79}, 2),
                __arrL({-9, -67}, 2),
                __arrL({0, tip}, 2),
                __arrL({10, -68}, 2),
                __arrL({25, -83}, 2),
                __arrL({21, -54}, 2),
                __arrL({37, -61}, 2),
                __arrL({28, -32}, 2),
                __arrL({39, -24}, 2),
                __arrL({29, 0}, 2)
            },
            15
        )
        c.globalAlpha = alpha * intensity * 0.4
        __L1:poly(
            c,
            outer,
            __get(glow, 0)
        )
        c.globalAlpha = alpha * intensity * 0.37
        __L1:poly(
            c,
            __arrL(
                {
                    __arrL({-23, -1}, 2),
                    __arrL({-31, -24}, 2),
                    __arrL({-20, -31}, 2),
                    __arrL({-27, -57}, 2),
                    __arrL({-13, -51}, 2),
                    __arrL({-15, -74}, 2),
                    __arrL({-4, -66}, 2),
                    __arrL({1, -87 - pulse}, 2),
                    __arrL({9, -63}, 2),
                    __arrL({18, -74}, 2),
                    __arrL({14, -48}, 2),
                    __arrL({28, -55}, 2),
                    __arrL({21, -27}, 2),
                    __arrL({30, -19}, 2),
                    __arrL({22, -1}, 2)
                },
                15
            ),
            __get(glow, 1)
        )
        c.globalAlpha = alpha * intensity * 0.16
        __L1:poly(
            c,
            __arrL(
                {
                    __arrL({-14, -2}, 2),
                    __arrL({-23, -27}, 2),
                    __arrL({-12, -44}, 2),
                    __arrL({-13, -62}, 2),
                    __arrL({0, -78}, 2),
                    __arrL({12, -61}, 2),
                    __arrL({11, -43}, 2),
                    __arrL({23, -25}, 2),
                    __arrL({13, -2}, 2)
                },
                9
            ),
            __get(glow, 2)
        )
        c.globalAlpha = alpha * intensity * 0.88
        __L1:limb(
            c,
            __call(outer, "slice", 0, 9),
            2,
            __get(glow, 3)
        )
        __L1:limb(
            c,
            __call(outer, "slice", 8),
            2,
            __get(glow, 4)
        )
        do
            local i = 0
            while i < 9 do
                local side = __t(__mod(i, 2)) and 1 or -1
                local yy = -8 - i * 10
                local xx = side * (21 + math.sin(t * 10 + i) * 5)
                local ____L1_limb_125 = __L1.limb
                local ____c_123 = c
                local ____arrL_result_124 = __arrL(
                    {
                        __arrL({xx + side * 3, yy + 5}, 2),
                        __arrL({xx - side * 3, yy - 3}, 2),
                        __arrL({xx + side * 2, yy - 10}, 2)
                    },
                    3
                )
                local ____t_result_122
                if __t(__mod(i, 3)) then
                    ____t_result_122 = __get(glow, 4)
                else
                    ____t_result_122 = __get(glow, 5)
                end
                ____L1_limb_125(
                    __L1,
                    ____c_123,
                    ____arrL_result_124,
                    2,
                    ____t_result_122
                )
                i = i + 1
            end
        end
        for ____, side in __iterar((__arrL({-1, 1}, 2))) do
            local j = math.floor(math.sin(t * 24 + side) * 3 + 0.5)
            local bx = side * (31 + j)
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL({bx, -16}, 2),
                        __arrL({bx - side * 6, -29}, 2),
                        __arrL({bx + side * 3, -39}, 2),
                        __arrL({bx - side * 4, -53}, 2),
                        __arrL({bx + side * 2, -69}, 2)
                    },
                    5
                ),
                3,
                __get(glow, 3)
            )
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL({bx, -16}, 2),
                        __arrL({bx - side * 6, -29}, 2),
                        __arrL({bx + side * 3, -39}, 2),
                        __arrL({bx - side * 4, -53}, 2),
                        __arrL({bx + side * 2, -69}, 2)
                    },
                    5
                ),
                1,
                __get(glow, 5)
            )
        end
        if __t(o.charging) then
            do
                local i = 0
                while i < 14 do
                    local yy = __TS__Number(-__mod(t * 105 + i * 17, 110))
                    local xx = (__L1:hash(i + 56) - 0.5) * 70
                    __L1:r(
                        c,
                        xx,
                        yy,
                        2,
                        __t(__mod(i, 3)) and 6 or 9,
                        __get(glow, 2)
                    )
                    i = i + 1
                end
            end
        else
            do
                local i = 0
                while i < 9 do
                    local xx = math.cos(t * 3 + i * 1.25) * 32
                    local yy = __TS__Number(-__mod(t * 82 + i * 19, 98))
                    __L1:r(
                        c,
                        xx,
                        yy,
                        3,
                        6,
                        __get(glow, 2)
                    )
                    i = i + 1
                end
            end
        end
        local ____t_131 = __t
        local ____opt_128 = window.Graphics
        if ____opt_128 ~= nil then
            ____opt_128 = ____opt_128.isLite
        end
        local ____opt_result_130
        if ____opt_128 ~= nil then
            ____opt_result_130 = ____opt_128(____opt_128)
        end
        if not ____t_131(____opt_result_130) then
            local a0 = c.globalAlpha
            do
                local i = 0
                while i < 12 do
                    local side = __t(__mod(i, 2)) and 1 or -1
                    local bx = side * (8 + __mod(i * 7, 26))
                    local life = __mod(
                        t * 1.6 + __L1:hash(i + 300),
                        1
                    )
                    local h = 26 + __L1:hash(i + 310) * 46
                    local yy = -12 - life * 90
                    local w = math.max(
                        2,
                        math.floor((1 - life) * 8 + 0.5)
                    )
                    c.globalAlpha = a0 * (1 - life) * 0.85
                    local ____L1_r_134 = __L1.r
                    local ____array_133 = __TS__SparseArrayNew(
                        c,
                        bx - w / 2 + math.sin(t * 9 + i) * 3,
                        yy - h * (1 - life) * 0.3,
                        w,
                        math.max(4, h * (1 - life) * 0.6)
                    )
                    local ____t_result_132
                    if __t(__mod(i, 3)) then
                        ____t_result_132 = __get(glow, 1)
                    else
                        ____t_result_132 = __get(glow, 2)
                    end
                    __TS__SparseArrayPush(____array_133, ____t_result_132)
                    ____L1_r_134(
                        __L1,
                        __TS__SparseArraySpread(____array_133)
                    )
                    __L1:r(
                        c,
                        bx - 1 + math.sin(t * 9 + i) * 3,
                        yy - h * (1 - life) * 0.3,
                        2,
                        math.max(2, h * (1 - life) * 0.3),
                        __get(glow, 5)
                    )
                    i = i + 1
                end
            end
            c.globalAlpha = a0
            do
                local i = 0
                while i < 10 do
                    local a = t * 4 + i * 0.63
                    local rr = 40 + math.sin(t * 6 + i) * 8
                    __L1:r(
                        c,
                        math.cos(a) * rr,
                        -48 + math.sin(a) * rr * 1.2,
                        2,
                        2,
                        __get(glow, 5)
                    )
                    i = i + 1
                end
            end
            if math.sin(t * 7) > 0.82 then
                c.strokeStyle = __get(glow, 4)
                c.lineWidth = 2
                c:beginPath()
                local x = -30 + __L1:hash(math.floor(t * 7)) * 60
                local y = -110
                c:moveTo(x, y)
                do
                    local k = 0
                    while k < 5 do
                        x = x + (__L1:hash(k + math.floor(t * 7)) - 0.5) * 24
                        y = y + 18
                        c:lineTo(x, y)
                        k = k + 1
                    end
                end
                c:stroke()
            end
        end
        c:restore()
    end
    __L1.supremeAura = function(self, c, t, o)
        if o == nil then
            o = {}
        end
        c:save()
        local alpha = c.globalAlpha
        local pulse = math.sin(t * 7) * 4
        c.globalAlpha = c.globalAlpha * 0.21
        __L1:oval(
            c,
            0,
            -49,
            57 + pulse,
            85,
            "#73d7e4",
            3
        )
        c.globalAlpha = c.globalAlpha * 1.9
        __L1:poly(
            c,
            __arrL(
                {
                    __arrL({-39, 1}, 2),
                    __arrL({-47, -32}, 2),
                    __arrL({-33, -46}, 2),
                    __arrL({-39, -68}, 2),
                    __arrL({-19, -62}, 2),
                    __arrL({-12, -102}, 2),
                    __arrL({0, -85}, 2),
                    __arrL({17, -107}, 2),
                    __arrL({22, -69}, 2),
                    __arrL({39, -79}, 2),
                    __arrL({33, -42}, 2),
                    __arrL({48, -29}, 2),
                    __arrL({34, 1}, 2)
                },
                13
            ),
            "#f3d27b"
        )
        c.globalAlpha = alpha
        do
            local i = 0
            while i < 8 do
                local a = t * 0.9 + i * math.pi / 4
                local xx = math.cos(a) * 48
                local yy = -48 + math.sin(a) * 59
                __L1:r(
                    c,
                    xx,
                    yy,
                    3,
                    3,
                    __t(__mod(i, 2)) and "#d3fbef" or "#f8d784"
                )
                __L1:r(
                    c,
                    xx - 3,
                    yy + 2,
                    9,
                    1,
                    "#8de3e0"
                )
                i = i + 1
            end
        end
        for ____, side in __iterar((__arrL({-1, 1}, 2))) do
            local xx = side * (40 + math.sin(t * 12 + side) * 3)
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL({xx, -7}, 2),
                        __arrL({xx - side * 9, -26}, 2),
                        __arrL({xx + side * 4, -41}, 2),
                        __arrL({xx - side * 5, -61}, 2),
                        __arrL({xx + side * 2, -80}, 2)
                    },
                    5
                ),
                2,
                "#98ebe7"
            )
        end
        if __t(o.charging) then
            do
                local i = 0
                while i < 14 do
                    local yy = __TS__Number(-__mod(t * 100 + i * 13, 120))
                    local xx = (__L1:hash(i + 43) - 0.5) * 100
                    __L1:r(
                        c,
                        xx,
                        yy,
                        2,
                        6,
                        __t(__mod(i, 2)) and "#ffe8a1" or "#98ebe7"
                    )
                    i = i + 1
                end
            end
        end
        c:restore()
    end
    __L1.newCharacter = function(self, c, ____type, x, y, o)
        if o == nil then
            o = {}
        end
        c:save()
        c.imageSmoothingEnabled = false
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        local ____c_139 = c
        local ____c_scale_140 = c.scale
        local ____temp_136 = __lt(o.facing, 0) and -1 or 1
        local ____t_result_135
        if __t(o.scale) then
            ____t_result_135 = o.scale
        else
            ____t_result_135 = 1
        end
        local ____temp_138 = ____temp_136 * ____t_result_135
        local ____t_result_137
        if __t(o.scale) then
            ____t_result_137 = o.scale
        else
            ____t_result_137 = 1
        end
        ____c_scale_140(____c_139, ____temp_138, ____t_result_137)
        if __isFiniteN(o.opacity) then
            c.globalAlpha = c.globalAlpha * math.max(
                0,
                math.min(1, o.opacity)
            )
        end
        local ____t_result_143
        local ____t_142 = __t
        local ____TS__Number_result_141 = __TS__Number(o.frame)
        __O[173] = ____TS__Number_result_141
        if ____t_142(____TS__Number_result_141) then
            ____t_result_143 = __O[173]
        else
            ____t_result_143 = 0
        end
        local t = ____t_result_143
        local moving = not not __t(o.moving) or __TS__Number(o.speed) > 8
        local ____t_result_144
        if __t(moving) then
            ____t_result_144 = math.sin(t * 9)
        else
            ____t_result_144 = 0
        end
        local walk = ____t_result_144
        local ____t_result_145
        if __t(moving) then
            ____t_result_145 = math.floor(math.abs(math.cos(t * 9)) * 2 + 0.5)
        else
            ____t_result_145 = math.floor(math.sin(t * 2) * 0.7 + 0.5)
        end
        local bob = ____t_result_145
        local ____temp_150 = ____type == "nicolas"
        if ____temp_150 then
            local ____t_149 = __t
            local ____t_result_148
            local ____t_147 = __t
            local ____t_result_146
            if __t(o.supreme) then
                ____t_result_146 = o.supreme
            else
                ____t_result_146 = o.powered
            end
            __O[174] = ____t_result_146
            if ____t_147(____t_result_146) then
                ____t_result_148 = __O[174]
            else
                ____t_result_148 = o.transformed
            end
            ____temp_150 = not not ____t_149(____t_result_148)
        end
        local supreme = ____temp_150
        local attack = not not __t(o.attack)
        local ____t_result_152
        if __t(attack) then
            local ____isFiniteN_result_151
            if __isFiniteN(o.attackProgress) then
                ____isFiniteN_result_151 = o.attackProgress
            else
                ____isFiniteN_result_151 = 0.5 + math.sin(t * 7) * 0.5
            end
            ____t_result_152 = math.max(
                0,
                math.sin(____isFiniteN_result_151 * math.pi)
            )
        else
            ____t_result_152 = 0
        end
        local strike = ____t_result_152
        local skins = {davi = "#ecc5ab", vitor = "#f1cfb8", freddy = "#815133", nicolas = "#f1cdb5"}
        local skin = __get(skins, ____type)
        local shade = ____type == "freddy" and "#52372a" or "#bd947b"
        local coats = {
            davi = "#252c31",
            vitor = "#a9afb1",
            freddy = "#34424a",
            nicolas = __t(supreme) and "#e0bc69" or "#e7e1c9"
        }
        local coat = __get(coats, ____type)
        local edge = ____type == "vitor" and "#737f85" or (____type == "nicolas" and "#8f6746" or "#18272e")
        local belly = ____type == "davi"
        local strong = false
        local slim = ____type == "freddy"
        local wide = __t(belly) and 18 or (__t(slim) and 9 or 12)
        local legCol = ____type == "davi" and "#3d4852" or (____type == "vitor" and "#384d61" or (____type == "freddy" and "#493d42" or "#3d5268"))
        if __t(supreme) then
            __L1:supremeAura(c, t, o)
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({-17, -44}, 2),
                        __arrL(
                            {
                                -35 - math.sin(t * 3) * 4,
                                -5
                            },
                            2
                        ),
                        __arrL({-21, 1}, 2),
                        __arrL({-13, -9}, 2),
                        __arrL({14, -8}, 2),
                        __arrL({27, 2}, 2),
                        __arrL(
                            {
                                40 + math.sin(t * 3) * 4,
                                -5
                            },
                            2
                        ),
                        __arrL({17, -44}, 2)
                    },
                    8
                ),
                "#245967"
            )
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({-17, -42}, 2),
                        __arrL({-29, -3}, 2),
                        __arrL({-17, -8}, 2),
                        __arrL({-10, -38}, 2)
                    },
                    4
                ),
                "#68b5bb"
            )
            __L1:r(
                c,
                -18,
                -41,
                38,
                4,
                "#f5d58a"
            )
        end
        __L1:oval(
            c,
            0,
            -1,
            __t(belly) and 23 or (__t(strong) and 21 or 17),
            3,
            "#2e433d",
            2
        )
        for ____, side in __iterar((__arrL({-1, 1}, 2))) do
            local fx = side * 7 + math.floor(walk * 12 * side + 0.5)
            local ____t_result_153
            if __t(moving) then
                ____t_result_153 = math.max(
                    0,
                    math.cos(t * 9 + (side > 0 and 0 or math.pi))
                ) * 6
            else
                ____t_result_153 = 0
            end
            local fy = ____t_result_153
            if o.grounded == false then
                fx = side > 0 and 10 or -12
                fy = side > 0 and 3 or 11
            end
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL({side * 7, -25}, 2),
                        __arrL({side * 7 + walk * side * 4, -12}, 2),
                        __arrL({fx, -4 - fy}, 2)
                    },
                    3
                ),
                __t(strong) and 11 or (__t(slim) and 7 or 9),
                "#27333a"
            )
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL({side * 7, -25}, 2),
                        __arrL({side * 7 + walk * side * 4, -12}, 2),
                        __arrL({fx, -4 - fy}, 2)
                    },
                    3
                ),
                __t(strong) and 7 or (__t(slim) and 4 or 5),
                legCol
            )
            __L1:r(
                c,
                fx - 4,
                -6 - fy,
                13,
                6,
                "#26353a"
            )
            __L1:r(
                c,
                fx - 3,
                -2 - fy,
                11,
                2,
                ____type == "nicolas" and "#ede8d7" or "#b6b8a6"
            )
            if __t(supreme) then
                __L1:r(
                    c,
                    fx - 3,
                    -5 - fy,
                    10,
                    2,
                    "#efce7b"
                )
            end
        end
        c:translate(
            __t(o.dash) and 5 or math.floor(walk * 1.5 + 0.5),
            -bob
        )
        local leftHand = __arrL(
            {
                -wide - 5 + math.floor(walk * 7 + 0.5),
                -18
            },
            2
        )
        local rightHand = __arrL(
            {
                wide + 5 - math.floor(walk * 7 + 0.5),
                -18
            },
            2
        )
        if __t(____type == "davi" and not __t(moving)) then
            rightHand = __arrL(
                {
                    wide + 17,
                    -29 + math.floor(math.sin(t * 3) * 3 + 0.5)
                },
                2
            )
            leftHand = __arrL({-wide - 7, -25}, 2)
        end
        if __t(____type == "vitor" and not __t(moving)) then
            rightHand = __arrL(
                {
                    wide + 12,
                    -27 + math.floor(math.sin(t * 2) * 2 + 0.5)
                },
                2
            )
            leftHand = __arrL({-wide - 2, -23}, 2)
        end
        if __t(____type == "freddy" and not __t(moving)) then
            leftHand = __arrL({-11, -34}, 2)
            rightHand = __arrL({25, -27}, 2)
        end
        if __t(____type == "nicolas" and not __t(moving)) then
            rightHand = __arrL(
                {
                    28,
                    -35 + math.floor(math.sin(t * 2) * 3 + 0.5)
                },
                2
            )
            leftHand = __arrL({-14, -21}, 2)
        end
        if __t(attack) then
            rightHand = __arrL({27 + strike * 19, -34 - strike * 12}, 2)
            leftHand = __arrL({-13, -36}, 2)
        end
        if __t(o.charging) then
            leftHand = __arrL({-27, -24}, 2)
            rightHand = __arrL({27, -24}, 2)
        end
        if __t(o.pose == "fistbump" or o.gesture == "fistbump") then
            rightHand = __arrL({38, -35}, 2)
        end
        local function hand(self, side, front)
            local ____gt_result_154
            if __gt(side, 0) then
                ____gt_result_154 = rightHand
            else
                ____gt_result_154 = leftHand
            end
            local ____end = ____gt_result_154
            local shoulder = __arrL({side * wide, -36}, 2)
            local elbow = __arrL(
                {
                    side * (wide + 5),
                    -27 + math.floor(walk * side * 3 + 0.5)
                },
                2
            )
            __L1:limb(
                c,
                __arrL({shoulder, elbow, ____end}, 3),
                __t(strong) and 11 or (__t(slim) and 6 or 8),
                "#243137"
            )
            __L1:limb(
                c,
                __arrL({shoulder, elbow}, 2),
                __t(strong) and 7 or (__t(slim) and 4 or 5),
                coat
            )
            local ____L1_limb_157 = __L1.limb
            local ____array_156 = __TS__SparseArrayNew(
                c,
                __arrL({elbow, ____end}, 2),
                __t(strong) and 7 or (__t(slim) and 4 or 5)
            )
            local ____temp_155
            if ____type == "freddy" then
                ____temp_155 = skin
            else
                ____temp_155 = coat
            end
            __TS__SparseArrayPush(____array_156, ____temp_155)
            ____L1_limb_157(
                __L1,
                __TS__SparseArraySpread(____array_156)
            )
            __L1:r(
                c,
                __get(____end, 0) - 3,
                __get(____end, 1) - 3,
                __t(strong) and 8 or 6,
                __t(strong) and 7 or 6,
                skin
            )
            if ____type == "freddy" then
                __L1:r(
                    c,
                    __get(____end, 0) - 4,
                    __get(____end, 1) - 2,
                    9,
                    3,
                    "#c4b690"
                )
            end
        end
        hand(nil, -1, false)
        if __t(belly) then
            __L1:oval(
                c,
                1,
                -30,
                23,
                20,
                "#202a31",
                2
            )
            __L1:oval(
                c,
                1,
                -31,
                20,
                17,
                coat,
                2
            )
            __L1:r(
                c,
                -14,
                -20,
                31,
                3,
                "#151f25"
            )
            __L1:r(
                c,
                -9,
                -28,
                22,
                9,
                "#303940"
            )
            __L1:r(
                c,
                -7,
                -27,
                18,
                2,
                "#47504f"
            )
        else
            __L1:poly(
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
            __L1:poly(
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
                coat
            )
            __L1:r(
                c,
                -wide + 3,
                -38,
                3,
                17,
                ____type == "vitor" and "#cdd0c9" or (____type == "freddy" and "#657273" or (__t(supreme) and "#ffe6a4" or "#f8f0d9"))
            )
            __L1:r(
                c,
                -wide + 2,
                -21,
                wide * 2 - 2,
                3,
                edge
            )
        end
        if __t(__call(
            __arrL({"davi", "vitor"}, 2),
            "includes",
            ____type
        )) then
            __L1:r(
                c,
                -7,
                -42,
                16,
                8,
                edge
            )
            __L1:r(
                c,
                -5,
                -40,
                12,
                5,
                ____type == "vitor" and "#c5c8c2" or "#3a4244"
            )
            __L1:r(
                c,
                -5,
                -35,
                2,
                12,
                "#d8d2bc"
            )
            __L1:r(
                c,
                6,
                -35,
                2,
                12,
                "#d8d2bc"
            )
        end
        if ____type == "freddy" then
            __L1:r(
                c,
                -12,
                -37,
                26,
                3,
                "#8b6753"
            )
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({-9, -38}, 2),
                        __arrL({-5, -31}, 2),
                        __arrL({5, -29}, 2),
                        __arrL({12, -36}, 2),
                        __arrL({10, -35}, 2),
                        __arrL({4, -32}, 2),
                        __arrL({-4, -34}, 2)
                    },
                    7
                ),
                "#c4a268"
            )
            __L1:r(
                c,
                1,
                -31,
                6,
                6,
                "#dfbb72"
            )
            __L1:r(
                c,
                3,
                -30,
                2,
                3,
                "#866745"
            )
            __L1:r(
                c,
                -9,
                -25,
                19,
                4,
                "#25343a"
            )
        end
        if ____type == "nicolas" then
            if __t(supreme) then
                __L1:poly(
                    c,
                    __arrL(
                        {
                            __arrL({-16, -41}, 2),
                            __arrL({-10, -46}, 2),
                            __arrL({0, -38}, 2),
                            __arrL({10, -46}, 2),
                            __arrL({17, -40}, 2),
                            __arrL({11, -26}, 2),
                            __arrL({0, -21}, 2),
                            __arrL({-11, -26}, 2)
                        },
                        8
                    ),
                    "#9c783b"
                )
                __L1:poly(
                    c,
                    __arrL(
                        {
                            __arrL({-12, -40}, 2),
                            __arrL({-8, -42}, 2),
                            __arrL({0, -35}, 2),
                            __arrL({8, -42}, 2),
                            __arrL({13, -40}, 2),
                            __arrL({8, -29}, 2),
                            __arrL({0, -25}, 2),
                            __arrL({-8, -29}, 2)
                        },
                        8
                    ),
                    "#eed28a"
                )
                __L1:r(
                    c,
                    -2,
                    -34,
                    5,
                    5,
                    "#8be0dc"
                )
                __L1:r(
                    c,
                    -15,
                    -42,
                    7,
                    5,
                    "#d8b469"
                )
                __L1:r(
                    c,
                    9,
                    -42,
                    7,
                    5,
                    "#f4dda0"
                )
            else
                __L1:r(
                    c,
                    -11,
                    -38,
                    5,
                    17,
                    "#647f96"
                )
                __L1:r(
                    c,
                    9,
                    -38,
                    4,
                    17,
                    "#647f96"
                )
                __L1:r(
                    c,
                    0,
                    -35,
                    4,
                    7,
                    "#c6944d"
                )
            end
        end
        hand(nil, 1, true)
        __L1:r(
            c,
            -4,
            -45,
            10,
            8,
            shade
        )
        __L1:r(
            c,
            -3,
            -45,
            8,
            8,
            skin
        )
        __L1:r(
            c,
            -12,
            -61,
            27,
            21,
            "#2c3030"
        )
        __L1:r(
            c,
            -10,
            -59,
            23,
            18,
            skin
        )
        __L1:r(
            c,
            -11,
            -55,
            3,
            12,
            shade
        )
        __L1:r(
            c,
            12,
            -53,
            4,
            6,
            skin
        )
        __L1:r(
            c,
            3,
            -53,
            3,
            3,
            "#2d3031"
        )
        __L1:r(
            c,
            12,
            -48,
            4,
            2,
            shade
        )
        __L1:r(
            c,
            2,
            -44,
            8,
            2,
            shade
        )
        if ____type == "freddy" then
            __L1:oval(
                c,
                0,
                -63,
                15,
                8,
                "#1c2528",
                2
            )
            __L1:r(
                c,
                -15,
                -63,
                30,
                8,
                "#1c2528"
            )
            do
                local i = 0
                while i < 8 do
                    local xx = -13 + i * 4
                    local yy = -57 + __mod(i, 2)
                    __L1:oval(
                        c,
                        xx,
                        yy,
                        3,
                        4,
                        __t(__mod(i, 2)) and "#28322e" or "#1b2427",
                        2
                    )
                    __L1:r(
                        c,
                        xx,
                        yy - 2,
                        1,
                        1,
                        "#485149"
                    )
                    i = i + 1
                end
            end
            __L1:r(
                c,
                -14,
                -58,
                4,
                10,
                "#1c2528"
            )
            __L1:r(
                c,
                11,
                -59,
                3,
                7,
                "#1c2528"
            )
            __L1:r(
                c,
                -2,
                -55,
                10,
                2,
                "#382b29"
            )
            __L1:r(
                c,
                1,
                -45,
                10,
                3,
                "#472e26"
            )
            __L1:r(
                c,
                3,
                -45,
                8,
                1,
                "#e2c6a5"
            )
        else
            local hair = ____type == "vitor" and "#20292e" or (____type == "davi" and "#634a37" or "#72533c")
            __L1:r(
                c,
                -12,
                -63,
                26,
                ____type == "vitor" and 7 or 10,
                hair
            )
            __L1:r(
                c,
                -9,
                -65,
                20,
                ____type == "vitor" and 3 or 5,
                hair
            )
            __L1:r(
                c,
                -12,
                -58,
                4,
                8,
                hair
            )
            __L1:r(
                c,
                11,
                -58,
                4,
                5,
                hair
            )
            __L1:r(
                c,
                -8,
                -62,
                14,
                2,
                ____type == "vitor" and "#3c4446" or (____type == "davi" and "#866548" or "#9a7650")
            )
            if ____type == "davi" then
                __L1:r(
                    c,
                    -4,
                    -65,
                    14,
                    2,
                    "#8c6847"
                )
            end
        end
        if ____type == "vitor" then
            __L1:r(
                c,
                -7,
                -55,
                11,
                7,
                "#28373f"
            )
            __L1:r(
                c,
                5,
                -55,
                11,
                7,
                "#28373f"
            )
            __L1:r(
                c,
                -5,
                -53,
                7,
                3,
                "#b8d2d3"
            )
            __L1:r(
                c,
                7,
                -53,
                7,
                3,
                "#b8d2d3"
            )
            __L1:r(
                c,
                3,
                -53,
                3,
                2,
                "#28373f"
            )
            __L1:r(
                c,
                -5,
                -54,
                3,
                1,
                "#f3eed7"
            )
            __L1:r(
                c,
                7,
                -54,
                3,
                1,
                "#f3eed7"
            )
        end
        if ____type == "davi" then
            __L1:r(
                c,
                -3,
                -44,
                13,
                3,
                "#80563f"
            )
            __L1:r(
                c,
                0,
                -44,
                8,
                1,
                "#f4dcc2"
            )
            local hx = __get(rightHand, 0)
            local hy = __get(rightHand, 1)
            __L1:r(
                c,
                hx + 1,
                hy - 12,
                9,
                16,
                "#17272d"
            )
            __L1:r(
                c,
                hx + 2,
                hy - 12,
                7,
                4,
                "#c7d2c9"
            )
            do
                local i = 0
                while i < 3 do
                    __L1:r(
                        c,
                        hx + 2 + i * 2,
                        hy - 15,
                        1,
                        4,
                        "#e2dfc8"
                    )
                    i = i + 1
                end
            end
            __L1:r(
                c,
                hx + 3,
                hy - 7,
                4,
                5,
                "#607d79"
            )
            __L1:r(
                c,
                -6,
                -33,
                12,
                4,
                "#6e8d88"
            )
        end
        if ____type == "vitor" then
            local hx = __get(rightHand, 0)
            local hy = __get(rightHand, 1)
            __L1:r(
                c,
                hx + 2,
                hy - 9,
                15,
                3,
                "#dac69a"
            )
            do
                local i = 0
                while i < 6 do
                    __L1:r(
                        c,
                        hx + 3 + i * 2,
                        hy - 6,
                        1,
                        5,
                        "#dac69a"
                    )
                    i = i + 1
                end
            end
            __L1:r(
                c,
                __get(leftHand, 0) - 4,
                __get(leftHand, 1),
                11,
                13,
                "#ede6d1"
            )
            __L1:r(
                c,
                __get(leftHand, 0) - 2,
                __get(leftHand, 1) + 2,
                2,
                9,
                "#b0beb8"
            )
        end
        if ____type == "nicolas" then
            __L1:r(
                c,
                -1,
                -56,
                10,
                2,
                "#805d40"
            )
            if __t(supreme) then
                __L1:r(
                    c,
                    0,
                    -52,
                    8,
                    2,
                    "#e5fff4"
                )
                __L1:r(
                    c,
                    2,
                    -52,
                    3,
                    2,
                    "#7ce6e1"
                )
                local orbit = math.sin(t * 3) * 3
                do
                    local i = 0
                    while i < 3 do
                        local xx = -13 + i * 12
                        __L1:r(
                            c,
                            xx,
                            -72 - orbit + __mod(i, 2) * 3,
                            7,
                            2,
                            "#f7d893"
                        )
                        __L1:r(
                            c,
                            xx + 2,
                            -76 - orbit + __mod(i, 2) * 3,
                            2,
                            9,
                            "#f7d893"
                        )
                        i = i + 1
                    end
                end
                __L1:r(
                    c,
                    -3,
                    -71 - orbit,
                    7,
                    2,
                    "#94ece6"
                )
            end
            if __t(o.emotion == "embarrassed" or o.emotion == "confused") then
                __L1:r(
                    c,
                    -7,
                    -47,
                    5,
                    2,
                    "#d99b8b"
                )
                __L1:r(
                    c,
                    9,
                    -47,
                    5,
                    2,
                    "#d99b8b"
                )
                __L1:r(
                    c,
                    1,
                    -43,
                    8,
                    2,
                    "#8e6551"
                )
            else
                __L1:r(
                    c,
                    2,
                    -44,
                    10,
                    2,
                    "#855e43"
                )
                __L1:r(
                    c,
                    4,
                    -44,
                    6,
                    1,
                    "#f9e7c9"
                )
            end
            local ____t_159 = __t
            local ____t_result_158
            if __t(attack) then
                ____t_result_158 = supreme
            else
                ____t_result_158 = attack
            end
            if ____t_159(____t_result_158) then
                local hx = __get(rightHand, 0)
                local hy = __get(rightHand, 1)
                __L1:oval(
                    c,
                    hx + 9,
                    hy - 2,
                    7 + strike * 6,
                    7 + strike * 6,
                    "#83d8d9",
                    2
                )
                __L1:oval(
                    c,
                    hx + 9,
                    hy - 2,
                    3 + strike * 3,
                    3 + strike * 3,
                    "#fff0b2",
                    2
                )
                do
                    local i = 0
                    while i < 3 do
                        __L1:r(
                            c,
                            hx + 18 + i * 5,
                            hy - 4 + i * 3,
                            3,
                            2,
                            "#c3f3e5"
                        )
                        i = i + 1
                    end
                end
            end
        end
        local ____t_161 = __t
        local ____t_result_160
        if __t(attack) then
            ____t_result_160 = ____type == "freddy"
        else
            ____t_result_160 = attack
        end
        if ____t_161(____t_result_160) then
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL({27, -48}, 2),
                        __arrL({39, -41}, 2),
                        __arrL({47, -32}, 2)
                    },
                    3
                ),
                2,
                "#efcb8a"
            )
            __L1:r(
                c,
                42,
                -33,
                10,
                2,
                "#ffe4a5"
            )
        end
        if __t(o.dash) then
            __L1:r(
                c,
                -39,
                -45,
                16,
                2,
                __t(supreme) and "#a1eeeb" or "#d7b184"
            )
            __L1:r(
                c,
                -48,
                -31,
                21,
                2,
                __t(supreme) and "#f9dfa0" or "#aa8a78"
            )
        end
        if __t(o.hit) then
            c:save()
            c.globalAlpha = c.globalAlpha * 0.5
            __L1:r(
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
    __L1.smokePuffs = function(self, c, x, y, t, intensity)
        if t == nil then
            t = 0
        end
        if intensity == nil then
            intensity = 1
        end
        c:save()
        local base = c.globalAlpha
        do
            local i = 0
            while i < 9 do
                local rise = __mod(t * 24 + i * 11, 103)
                local xx = x + math.sin(t * 0.8 + i * 1.7) * (8 + rise * 0.18)
                local yy = y - rise
                local sz = 6 + rise * 0.1
                c.globalAlpha = base * (0.12 + (1 - rise / 110) * 0.19) * intensity
                __L1:oval(
                    c,
                    xx,
                    yy,
                    sz * 1.5,
                    sz,
                    "#aac7c8",
                    3
                )
                __L1:oval(
                    c,
                    xx - 3,
                    yy - 3,
                    sz,
                    sz * 0.75,
                    "#e2ebda",
                    3
                )
                i = i + 1
            end
        end
        c:restore()
    end
    __L1.socialCharacter = function(self, c, ____type, x, y, o)
        if o == nil then
            o = {}
        end
        c:save()
        c.imageSmoothingEnabled = false
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        local ____c_166 = c
        local ____c_scale_167 = c.scale
        local ____temp_163 = __lt(o.facing, 0) and -1 or 1
        local ____t_result_162
        if __t(o.scale) then
            ____t_result_162 = o.scale
        else
            ____t_result_162 = 1
        end
        local ____temp_165 = ____temp_163 * ____t_result_162
        local ____t_result_164
        if __t(o.scale) then
            ____t_result_164 = o.scale
        else
            ____t_result_164 = 1
        end
        ____c_scale_167(____c_166, ____temp_165, ____t_result_164)
        if __isFiniteN(o.opacity) then
            c.globalAlpha = c.globalAlpha * math.max(
                0,
                math.min(1, o.opacity)
            )
        end
        local ____t_result_170
        local ____t_169 = __t
        local ____TS__Number_result_168 = __TS__Number(o.frame)
        __O[175] = ____TS__Number_result_168
        if ____t_169(____TS__Number_result_168) then
            ____t_result_170 = __O[175]
        else
            ____t_result_170 = 0
        end
        local t = ____t_result_170
        local moving = not not __t(o.moving) or __TS__Number(o.speed) > 8
        local ____t_result_171
        if __t(moving) then
            ____t_result_171 = math.sin(t * 8)
        else
            ____t_result_171 = 0
        end
        local walk = ____t_result_171
        local ____t_result_172
        if __t(moving) then
            ____t_result_172 = math.floor(math.abs(math.cos(t * 8)) * 2 + 0.5)
        else
            ____t_result_172 = math.floor(math.sin(t * 2) * 0.7 + 0.5)
        end
        local bob = ____t_result_172
        local receptionist = ____type == "allef"
        local skin = __get({
            allef = "#805136",
            eloisa = "#d9af90",
            giselle = "#795035",
            rayssa = "#815338",
            analaura = "#f2ccb2"
        }, ____type)
        local shade = __t(receptionist) and "#4e352a" or (____type == "eloisa" and "#b47e61" or (____type == "analaura" and "#be947b" or "#4c352c"))
        local hair = ____type == "eloisa" and "#4d372c" or (____type == "analaura" and "#51362d" or "#232d2b")
        local pants = "#203b60"
        local half = __t(receptionist) and 18 or 10
        __L1:oval(
            c,
            0,
            -1,
            __t(receptionist) and 23 or 17,
            3,
            "#39483e",
            2
        )
        if not __t(receptionist) then
            if ____type == "eloisa" then
                __L1:r(
                    c,
                    -14,
                    -64,
                    29,
                    43,
                    hair
                )
                __L1:r(
                    c,
                    -15,
                    -57,
                    5,
                    42,
                    hair
                )
                __L1:r(
                    c,
                    11,
                    -56,
                    5,
                    37,
                    hair
                )
                __L1:r(
                    c,
                    -14,
                    -20,
                    10,
                    3,
                    hair
                )
                __L1:r(
                    c,
                    8,
                    -22,
                    8,
                    3,
                    hair
                )
            elseif ____type == "giselle" then
                __L1:r(
                    c,
                    -14,
                    -63,
                    29,
                    25,
                    hair
                )
                do
                    local strand = 0
                    while strand < 7 do
                        local hx = -15 + strand * 5
                        local lean = math.sin(t * 1.7 + strand) * 0.7
                        do
                            local j = 0
                            while j < 12 do
                                local yy = -60 + j * 3
                                __L1:r(
                                    c,
                                    hx + lean + __mod(j, 2),
                                    yy,
                                    4,
                                    4,
                                    __t(__mod(j, 3)) and "#25302e" or "#3a4238"
                                )
                                __L1:r(
                                    c,
                                    hx + 1 + lean + __mod(j, 2),
                                    yy,
                                    1,
                                    2,
                                    "#626151"
                                )
                                j = j + 1
                            end
                        end
                        __L1:r(
                            c,
                            hx + 1,
                            -24 + __mod(strand, 2) * 3,
                            2,
                            3,
                            "#bca67e"
                        )
                        strand = strand + 1
                    end
                end
            else
                local long = ____type == "analaura"
                __L1:oval(
                    c,
                    0,
                    -57,
                    19,
                    __t(long) and 22 or 19,
                    hair,
                    2
                )
                for ____, side in __iterar((__arrL({-1, 1}, 2))) do
                    do
                        local i = 0
                        while i < (__t(long) and 10 or 6) do
                            local yy = -61 + i * 4
                            local xx = side * (14 + math.sin(i * 1.5 + t * 0.4) * 2)
                            local ____L1_oval_175 = __L1.oval
                            local ____c_174 = c
                            local ____temp_173
                            if __mod(i, 3) == 0 then
                                ____temp_173 = __t(long) and "#6a4734" or "#303b32"
                            else
                                ____temp_173 = hair
                            end
                            ____L1_oval_175(
                                __L1,
                                ____c_174,
                                xx,
                                yy,
                                5,
                                5,
                                ____temp_173,
                                2
                            )
                            if __mod(i, 2) == 0 then
                                __L1:r(
                                    c,
                                    xx - 1,
                                    yy - 2,
                                    2,
                                    2,
                                    __t(long) and "#7a543c" or "#455044"
                                )
                            end
                            i = i + 1
                        end
                    end
                end
                if __t(long) then
                    __L1:oval(
                        c,
                        -13,
                        -22,
                        6,
                        6,
                        hair,
                        2
                    )
                    __L1:oval(
                        c,
                        14,
                        -20,
                        6,
                        6,
                        hair,
                        2
                    )
                end
            end
        end
        for ____, side in __iterar((__arrL({-1, 1}, 2))) do
            local fx = side * (__t(receptionist) and 7 or 5) + math.floor(walk * 11 * side + 0.5)
            local ____t_result_176
            if __t(moving) then
                ____t_result_176 = math.max(
                    0,
                    math.cos(t * 8 + (side > 0 and 0 or math.pi))
                ) * 5
            else
                ____t_result_176 = 0
            end
            local fy = ____t_result_176
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL(
                            {
                                side * (__t(receptionist) and 7 or 4),
                                -23
                            },
                            2
                        ),
                        __arrL({side * 5, -13}, 2),
                        __arrL({fx, -4 - fy}, 2)
                    },
                    3
                ),
                __t(receptionist) and 10 or 8,
                "#263640"
            )
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL(
                            {
                                side * (__t(receptionist) and 7 or 4),
                                -23
                            },
                            2
                        ),
                        __arrL({side * 5, -13}, 2),
                        __arrL({fx, -4 - fy}, 2)
                    },
                    3
                ),
                __t(receptionist) and 6 or 4,
                pants
            )
            __L1:r(
                c,
                fx - 4,
                -5 - fy,
                12,
                5,
                "#e8e6d7"
            )
            __L1:r(
                c,
                fx - 3,
                -2 - fy,
                11,
                2,
                "#9dafb1"
            )
        end
        c:translate(
            math.floor(walk + 0.5),
            -bob
        )
        local leftHand = __arrL(
            {
                -half - 6 + math.floor(walk * 8 + 0.5),
                -19
            },
            2
        )
        local rightHand = __arrL(
            {
                half + 6 - math.floor(walk * 8 + 0.5),
                -19
            },
            2
        )
        if not __t(moving) then
            local ____t_result_177
            if __t(receptionist) then
                ____t_result_177 = __arrL({-22, -25}, 2)
            else
                ____t_result_177 = __arrL({-13, -22}, 2)
            end
            leftHand = ____t_result_177
            local ____t_result_178
            if __t(receptionist) then
                ____t_result_178 = __arrL(
                    {
                        31,
                        -33 + math.sin(t * 3) * 3
                    },
                    2
                )
            else
                ____t_result_178 = __arrL(
                    {
                        23,
                        -29 + math.sin(t * 2.5) * 3
                    },
                    2
                )
            end
            rightHand = ____t_result_178
        end
        if __t(o.talking) then
            rightHand = __arrL(
                {
                    __t(receptionist) and 34 or 29,
                    -31 + math.sin(t * 6) * 5
                },
                2
            )
            leftHand = __arrL(
                {
                    -half - 5,
                    -26 + math.sin(t * 3) * 2
                },
                2
            )
        end
        if o.pose == "offer" then
            rightHand = __arrL({36, -26}, 2)
        end
        if o.pose == "fistbump" then
            rightHand = __arrL({37, -35}, 2)
        end
        local function socialArm(self, side)
            local ____gt_result_179
            if __gt(side, 0) then
                ____gt_result_179 = rightHand
            else
                ____gt_result_179 = leftHand
            end
            local ____end = ____gt_result_179
            local elbow = __arrL({side * (half + 5), -29 + walk * side * 3}, 2)
            local shoulder = __arrL({side * half, -36}, 2)
            __L1:limb(
                c,
                __arrL({shoulder, elbow, ____end}, 3),
                __t(receptionist) and 10 or 7,
                "#28383d"
            )
            __L1:limb(
                c,
                __arrL({shoulder, elbow}, 2),
                __t(receptionist) and 6 or 4,
                __t(receptionist) and "#3b5260" or "#eeeedd"
            )
            __L1:limb(
                c,
                __arrL({elbow, ____end}, 2),
                __t(receptionist) and 6 or 4,
                skin
            )
            __L1:r(
                c,
                __get(____end, 0) - 3,
                __get(____end, 1) - 3,
                __t(receptionist) and 7 or 6,
                6,
                skin
            )
            if __t(__lt(side, 0) and not __t(receptionist)) then
                __L1:limb(
                    c,
                    __arrL(
                        {
                            __arrL(
                                {
                                    __get(shoulder, 0),
                                    __get(shoulder, 1) + 2
                                },
                                2
                            ),
                            __arrL(
                                {
                                    __get(elbow, 0) * 0.7 + __get(shoulder, 0) * 0.3,
                                    -32
                                },
                                2
                            )
                        },
                        2
                    ),
                    5,
                    "#22496d"
                )
            end
        end
        socialArm(nil, -1)
        if __t(receptionist) then
            __L1:oval(
                c,
                0,
                -29,
                23,
                19,
                "#263840",
                2
            )
            __L1:oval(
                c,
                0,
                -30,
                20,
                16,
                "#3b5260",
                2
            )
            __L1:r(
                c,
                -13,
                -22,
                28,
                4,
                "#283c47"
            )
            __L1:r(
                c,
                -7,
                -29,
                15,
                8,
                "#53717a"
            )
            __L1:r(
                c,
                -4,
                -27,
                8,
                2,
                "#a9b9a4"
            )
            __L1:r(
                c,
                -17,
                -39,
                34,
                3,
                "#6b8690"
            )
        else
            local extra = ____type == "analaura" and 1 or 0
            __L1:r(
                c,
                -12 - extra,
                -41,
                26 + extra,
                25,
                "#293e4b"
            )
            __L1:r(
                c,
                -10 - extra,
                -39,
                22 + extra,
                21,
                "#f1f0df"
            )
            __L1:r(
                c,
                -9 - extra,
                -37,
                4,
                17,
                "#234c73"
            )
            __L1:r(
                c,
                -10 - extra,
                -20,
                22 + extra,
                3,
                "#213e60"
            )
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({-6, -40}, 2),
                        __arrL({0, -35}, 2),
                        __arrL({7, -40}, 2),
                        __arrL({5, -34}, 2),
                        __arrL({0, -31}, 2),
                        __arrL({-5, -35}, 2)
                    },
                    6
                ),
                "#294f71"
            )
            __L1:r(
                c,
                5,
                -32,
                5,
                5,
                "#315d7c"
            )
            __L1:r(
                c,
                6,
                -31,
                3,
                2,
                "#c3d7d5"
            )
            __L1:r(
                c,
                0,
                -33,
                2,
                13,
                "#d2d9ce"
            )
        end
        socialArm(nil, 1)
        __L1:r(
            c,
            -4,
            -45,
            10,
            8,
            shade
        )
        __L1:r(
            c,
            -3,
            -45,
            8,
            8,
            skin
        )
        __L1:r(
            c,
            -12,
            -61,
            27,
            21,
            "#293431"
        )
        __L1:r(
            c,
            -10,
            -59,
            23,
            18,
            skin
        )
        __L1:r(
            c,
            -11,
            -55,
            3,
            12,
            shade
        )
        __L1:r(
            c,
            12,
            -52,
            4,
            6,
            skin
        )
        __L1:r(
            c,
            3,
            -53,
            3,
            3,
            "#29312e"
        )
        __L1:r(
            c,
            12,
            -48,
            3,
            2,
            shade
        )
        if __t(receptionist) then
            __L1:r(
                c,
                -12,
                -63,
                26,
                8,
                hair
            )
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({-12, -60}, 2),
                        __arrL({-13, -68}, 2),
                        __arrL({-8, -66}, 2),
                        __arrL({-4, -73}, 2),
                        __arrL({2, -69}, 2),
                        __arrL({6, -73}, 2),
                        __arrL({10, -67}, 2),
                        __arrL({14, -69}, 2),
                        __arrL({13, -59}, 2)
                    },
                    9
                ),
                hair
            )
            do
                local i = 0
                while i < 8 do
                    local hx = -11 + i * 3.5
                    local hy = -66 - (__mod(i, 3) == 1 and 7 or (__mod(i, 3) == 2 and 4 or 1))
                    __L1:oval(
                        c,
                        hx,
                        hy,
                        4,
                        5,
                        __mod(i, 3) == 0 and "#303b31" or hair,
                        2
                    )
                    __L1:r(
                        c,
                        hx - 1,
                        hy - 2,
                        2,
                        2,
                        "#424b3c"
                    )
                    i = i + 1
                end
            end
            __L1:r(
                c,
                -12,
                -58,
                4,
                7,
                hair
            )
            __L1:r(
                c,
                11,
                -58,
                4,
                5,
                hair
            )
            __L1:r(
                c,
                0,
                -45,
                12,
                __t(o.talking) and 5 or 3,
                "#47352d"
            )
            __L1:r(
                c,
                2,
                -45,
                8,
                2,
                "#ead4ae"
            )
            if __t(o.talking) then
                __L1:r(
                    c,
                    3,
                    -42,
                    7,
                    2,
                    "#8c6753"
                )
            end
            __L1:r(
                c,
                -2,
                -56,
                11,
                2,
                "#394033"
            )
        else
            if ____type == "eloisa" then
                __L1:r(
                    c,
                    -13,
                    -64,
                    28,
                    8,
                    hair
                )
                __L1:r(
                    c,
                    -10,
                    -67,
                    21,
                    5,
                    hair
                )
                __L1:r(
                    c,
                    -13,
                    -59,
                    5,
                    29,
                    hair
                )
                __L1:r(
                    c,
                    11,
                    -58,
                    5,
                    33,
                    hair
                )
                __L1:r(
                    c,
                    -8,
                    -63,
                    7,
                    2,
                    "#76543b"
                )
                __L1:r(
                    c,
                    4,
                    -63,
                    7,
                    2,
                    "#76543b"
                )
            elseif ____type == "giselle" then
                __L1:r(
                    c,
                    -13,
                    -64,
                    28,
                    7,
                    hair
                )
                do
                    local i = 0
                    while i < 6 do
                        local hx = -10 + i * 4
                        __L1:r(
                            c,
                            hx,
                            -65 + __mod(i, 2),
                            3,
                            7,
                            "#31392f"
                        )
                        __L1:r(
                            c,
                            hx + 1,
                            -64,
                            1,
                            2,
                            "#63614d"
                        )
                        i = i + 1
                    end
                end
                __L1:r(
                    c,
                    -13,
                    -58,
                    4,
                    17,
                    hair
                )
                __L1:r(
                    c,
                    12,
                    -58,
                    4,
                    23,
                    hair
                )
            else
                do
                    local i = 0
                    while i < 8 do
                        local hx = -12 + i * 3.5
                        local hy = -65 - (__mod(i, 3) == 1 and 3 or 0)
                        __L1:oval(
                            c,
                            hx,
                            hy,
                            5,
                            5,
                            hair,
                            2
                        )
                        i = i + 1
                    end
                end
                do
                    local i = 0
                    while i < 7 do
                        local hx = -11 + i * 4
                        local hy = -66 - (__mod(i, 3) == 1 and 3 or 0)
                        __L1:r(
                            c,
                            hx - 1,
                            hy - 1,
                            2,
                            2,
                            ____type == "analaura" and "#7d573e" or "#455044"
                        )
                        i = i + 1
                    end
                end
                __L1:r(
                    c,
                    -13,
                    -60,
                    5,
                    13,
                    hair
                )
                __L1:r(
                    c,
                    12,
                    -60,
                    5,
                    15,
                    hair
                )
            end
            __L1:r(
                c,
                1,
                -55,
                8,
                1,
                "#5c4033"
            )
            local lip = ____type == "eloisa" and "#d35e8c" or (____type == "analaura" and "#a96964" or "#a06655")
            __L1:r(
                c,
                1,
                -45,
                10,
                __t(o.talking) and 4 or 2,
                lip
            )
            __L1:r(
                c,
                3,
                -45,
                6,
                1,
                ____type == "eloisa" and "#f4a1c0" or "#e1bba2"
            )
            if __t(o.talking) then
                __L1:r(
                    c,
                    3,
                    -43,
                    6,
                    2,
                    "#674337"
                )
            end
        end
        if __t(o.hit) then
            c:save()
            c.globalAlpha = c.globalAlpha * 0.4
            __L1:r(
                c,
                -25,
                -76,
                52,
                76,
                "#f8e8c6"
            )
            c:restore()
        end
        c:restore()
    end
    __L1.rayssaHouse = function(self, c, camera, t)
        __L1:r(
            c,
            0,
            0,
            960,
            440,
            "#eddcbf"
        )
        __L1:r(
            c,
            0,
            0,
            960,
            28,
            "#40575a"
        )
        __L1:r(
            c,
            0,
            28,
            960,
            9,
            "#b18b63"
        )
        __L1:r(
            c,
            0,
            37,
            960,
            4,
            "#f8e6bc"
        )
        __L1:r(
            c,
            0,
            328,
            960,
            112,
            "#84aaa2"
        )
        __L1:r(
            c,
            0,
            328,
            960,
            6,
            "#416d70"
        )
        __L1:r(
            c,
            0,
            415,
            960,
            25,
            "#537579"
        )
        c:save()
        c:translate(
            -math.floor(camera + 0.5),
            0
        )
        local width = __L1:worldWidth(10)
        do
            local x = 0
            while x < width do
                __L1:r(
                    c,
                    x + 12,
                    37,
                    8,
                    290,
                    "#d2ba96"
                )
                __L1:r(
                    c,
                    x + 15,
                    39,
                    3,
                    286,
                    "#fff0ce"
                )
                __L1:r(
                    c,
                    x + 26,
                    104,
                    321,
                    5,
                    "#d8c49d"
                )
                x = x + 420
            end
        end
        do
            local x = 125
            local i = 0
            while x < width do
                do
                    if __t(x < camera - 300 or __gt(x, camera + 1120)) then
                        do do x = x + 660 i = i + 1 end continue end
                    end
                    __L1:r(
                        c,
                        x,
                        130,
                        206,
                        152,
                        "#80684d"
                    )
                    __L1:r(
                        c,
                        x + 6,
                        136,
                        194,
                        140,
                        "#d7e5cf"
                    )
                    __L1:r(
                        c,
                        x + 12,
                        142,
                        182,
                        128,
                        "#8fc7d4"
                    )
                    __L1:cloud(
                        c,
                        x + 27,
                        174,
                        0.8,
                        "#f9f2d6"
                    )
                    __L1:poly(
                        c,
                        __arrL(
                            {
                                __arrL({x + 14, 267}, 2),
                                __arrL({x + 46, 223}, 2),
                                __arrL({x + 90, 254}, 2),
                                __arrL({x + 137, 213}, 2),
                                __arrL({x + 193, 260}, 2),
                                __arrL({x + 193, 270}, 2),
                                __arrL({x + 14, 270}, 2)
                            },
                            7
                        ),
                        "#74a68b"
                    )
                    __L1:r(
                        c,
                        x + 98,
                        137,
                        6,
                        139,
                        "#f1e4c4"
                    )
                    __L1:r(
                        c,
                        x + 7,
                        208,
                        194,
                        5,
                        "#f1e4c4"
                    )
                    __L1:r(
                        c,
                        x - 5,
                        282,
                        216,
                        7,
                        "#b18b5d"
                    )
                    __L1:r(
                        c,
                        x - 13,
                        116,
                        233,
                        7,
                        "#705d48"
                    )
                    local flutter = math.floor(math.sin(t * 1.6 + i) * 3 + 0.5)
                    for ____, side in __iterar((__arrL({-1, 1}, 2))) do
                        local ____temp_180
                        if side < 0 then
                            ____temp_180 = x - 3
                        else
                            ____temp_180 = x + 179
                        end
                        local cx = ____temp_180
                        __L1:poly(
                            c,
                            __arrL(
                                {
                                    __arrL({cx, 123}, 2),
                                    __arrL({cx + 30, 123}, 2),
                                    __arrL({cx + 27 + flutter, 253}, 2),
                                    __arrL({cx + 7 + flutter, 262}, 2),
                                    __arrL({cx - 3, 244}, 2)
                                },
                                5
                            ),
                            __t(__mod(i, 2)) and "#d6a5a0" or "#b9b9cf"
                        )
                        do
                            local j = 0
                            while j < 3 do
                                __L1:r(
                                    c,
                                    cx + 4 + j * 8,
                                    127,
                                    2,
                                    116,
                                    "#f1d5bc"
                                )
                                j = j + 1
                            end
                        end
                    end
                end
                do
                    x = x + 660
                    i = i + 1
                end
            end
        end
        __L1:r(
            c,
            344,
            55,
            514,
            53,
            "#425c5e"
        )
        __L1:r(
            c,
            349,
            60,
            504,
            43,
            "#718c7d"
        )
        __L1:r(
            c,
            353,
            64,
            496,
            3,
            "#bbd2b0"
        )
        c.fillStyle = "#fff0c9"
        c.font = "bold 23px monospace"
        c:fillText("CASA DE RAYSSA", 406, 89)
        c.font = "bold 8px monospace"
        c.fillStyle = "#dce7bc"
        c:fillText("PORTA ABERTA · CAFÉ NA MESA · RESENHA EM DIA", 423, 101)
        do
            local x = 350
            local i = 0
            while x < 2050 do
                do
                    if __t(x < camera - 300 or __gt(x, camera + 1060)) then
                        do do x = x + 470 i = i + 1 end continue end
                    end
                    __L1:r(
                        c,
                        x - 18,
                        386,
                        258,
                        43,
                        "#5a5e50"
                    )
                    __L1:r(
                        c,
                        x - 13,
                        342,
                        248,
                        72,
                        __t(__mod(i, 2)) and "#b56e68" or "#bb8b5b"
                    )
                    __L1:r(
                        c,
                        x - 11,
                        340,
                        244,
                        8,
                        __t(__mod(i, 2)) and "#d99987" or "#e4b47a"
                    )
                    __L1:r(
                        c,
                        x - 27,
                        367,
                        21,
                        49,
                        __t(__mod(i, 2)) and "#a65e5c" or "#a7774d"
                    )
                    __L1:r(
                        c,
                        x + 229,
                        367,
                        21,
                        49,
                        __t(__mod(i, 2)) and "#a65e5c" or "#a7774d"
                    )
                    do
                        local j = 0
                        while j < 3 do
                            __L1:r(
                                c,
                                x + 3 + j * 73,
                                355,
                                66,
                                48,
                                __t(__mod(i, 2)) and "#c07b70" or "#d09e68"
                            )
                            __L1:r(
                                c,
                                x + 6 + j * 73,
                                357,
                                60,
                                4,
                                __t(__mod(i, 2)) and "#dda18d" or "#edc18a"
                            )
                            j = j + 1
                        end
                    end
                    __L1:r(
                        c,
                        x + 13,
                        415,
                        9,
                        25,
                        "#625844"
                    )
                    __L1:r(
                        c,
                        x + 210,
                        415,
                        9,
                        25,
                        "#625844"
                    )
                    __L1:r(
                        c,
                        x + 24,
                        352,
                        32,
                        31,
                        __t(__mod(i, 2)) and "#e4d59d" or "#8eafa3"
                    )
                    __L1:r(
                        c,
                        x + 28,
                        356,
                        24,
                        23,
                        __t(__mod(i, 2)) and "#f2e3af" or "#b7cfb4"
                    )
                    __L1:r(
                        c,
                        x + 186,
                        354,
                        30,
                        28,
                        "#d9b0b5"
                    )
                end
                do
                    x = x + 470
                    i = i + 1
                end
            end
        end
        for ____, x in __iterar((__arrL({
            70,
            705,
            1115,
            1710,
            2470,
            3200
        }, 6))) do
            do
                if __t(x < camera - 100 or __gt(x, camera + 1070)) then
                    continue
                end
                __L1:r(
                    c,
                    x,
                    395,
                    44,
                    45,
                    "#94704e"
                )
                __L1:r(
                    c,
                    x - 5,
                    389,
                    54,
                    9,
                    "#c29961"
                )
                __L1:r(
                    c,
                    x + 6,
                    404,
                    32,
                    2,
                    "#d8b47a"
                )
                __L1:r(
                    c,
                    x + 13,
                    372,
                    21,
                    17,
                    "#bf755a"
                )
                __L1:r(
                    c,
                    x + 10,
                    369,
                    27,
                    5,
                    "#d99572"
                )
                do
                    local j = 0
                    while j < 5 do
                        local xx = x + 22 + (j - 2) * 5
                        local yy = 354 - math.sin(t + j) * 2
                        __L1:limb(
                            c,
                            __arrL(
                                {
                                    __arrL({x + 23, 371}, 2),
                                    __arrL({xx, yy}, 2)
                                },
                                2
                            ),
                            2,
                            "#466e4a"
                        )
                        __L1:oval(
                            c,
                            xx + (__t(__mod(j, 2)) and 5 or -5),
                            yy - 2,
                            8,
                            4,
                            __t(__mod(j, 2)) and "#6f9c60" or "#91b374",
                            2
                        )
                        j = j + 1
                    end
                end
            end
        end
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({1000, "SE TOCA, MENINO", "#b08b9c"}, 3),
                __arrL({1640, "AFF VEYR JURO", "#85a9a6"}, 3),
                __arrL({2700, "AQUI TEM RESENHA", "#b39268"}, 3)
            },
            3
        ))) do
            local x = ____value[1]
            local label = ____value[2]
            local color = ____value[3]
            __L1:r(
                c,
                x,
                137,
                205,
                101,
                "#76624b"
            )
            __L1:r(
                c,
                x + 5,
                142,
                195,
                91,
                "#efdfbd"
            )
            __L1:r(
                c,
                x + 11,
                148,
                183,
                72,
                color
            )
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({x + 28, 205}, 2),
                        __arrL({x + 53, 169}, 2),
                        __arrL({x + 85, 199}, 2),
                        __arrL({x + 116, 163}, 2),
                        __arrL({x + 159, 205}, 2)
                    },
                    5
                ),
                "#ead5ae"
            )
            c.fillStyle = "#4b6257"
            c.font = "bold 11px monospace"
            c:fillText(label, x + 12, 231)
        end
        __L1:oval(
            c,
            2290,
            142,
            32,
            32,
            "#74614c",
            3
        )
        __L1:oval(
            c,
            2290,
            142,
            26,
            26,
            "#f0e3bb",
            3
        )
        do
            local j = 0
            while j < 12 do
                local a = j * math.pi / 6
                __L1:r(
                    c,
                    2289 + math.cos(a) * 22,
                    141 + math.sin(a) * 22,
                    2,
                    2,
                    "#8e7757"
                )
                j = j + 1
            end
        end
        __L1:limb(
            c,
            __arrL(
                {
                    __arrL({2290, 142}, 2),
                    __arrL(
                        {
                            2290 + math.sin(t * 0.03) * 16,
                            142 - math.cos(t * 0.03) * 16
                        },
                        2
                    )
                },
                2
            ),
            2,
            "#4e5e52"
        )
        __L1:limb(
            c,
            __arrL(
                {
                    __arrL({2290, 142}, 2),
                    __arrL({2278, 134}, 2)
                },
                2
            ),
            3,
            "#4e5e52"
        )
        __L1:r(
            c,
            2020,
            297,
            531,
            124,
            "#b3b49a"
        )
        do
            local i = 0
            while i < 6 do
                __L1:r(
                    c,
                    2026 + i * 86,
                    305,
                    79,
                    103,
                    "#d4c7a0"
                )
                __L1:r(
                    c,
                    2030 + i * 86,
                    309,
                    71,
                    3,
                    "#f3e3bb"
                )
                __L1:r(
                    c,
                    2055 + i * 86,
                    320,
                    20,
                    3,
                    "#7d8673"
                )
                i = i + 1
            end
        end
        __L1:r(
            c,
            2014,
            290,
            543,
            14,
            "#7c8572"
        )
        __L1:r(
            c,
            2016,
            290,
            539,
            4,
            "#e6dcc0"
        )
        __L1:r(
            c,
            2040,
            178,
            271,
            95,
            "#758b80"
        )
        do
            local i = 0
            while i < 3 do
                __L1:r(
                    c,
                    2045 + i * 89,
                    184,
                    81,
                    82,
                    "#c1c5ab"
                )
                __L1:r(
                    c,
                    2049 + i * 89,
                    188,
                    73,
                    3,
                    "#e8e3c6"
                )
                __L1:r(
                    c,
                    2077 + i * 89,
                    247,
                    19,
                    3,
                    "#728574"
                )
                i = i + 1
            end
        end
        __L1:r(
            c,
            2361,
            268,
            97,
            21,
            "#5c6c65"
        )
        __L1:oval(
            c,
            2410,
            270,
            39,
            9,
            "#a9bbb0",
            2
        )
        __L1:r(
            c,
            2408,
            247,
            5,
            26,
            "#b6c8bd"
        )
        __L1:r(
            c,
            2411,
            245,
            20,
            4,
            "#dbe4ce"
        )
        __L1:r(
            c,
            2155,
            267,
            35,
            21,
            "#736c64"
        )
        __L1:r(
            c,
            2153,
            263,
            39,
            6,
            "#c0b8a0"
        )
        do
            local i = 0
            while i < 4 do
                local yy = 256 - __mod(t * 13 + i * 8, 37)
                local xx = 2172 + math.sin(t + i) * 5
                __L1:oval(
                    c,
                    xx,
                    yy,
                    5,
                    3,
                    "#e1e6d19a",
                    2
                )
                i = i + 1
            end
        end
        __L1:r(
            c,
            2900,
            216,
            369,
            198,
            "#5f8780"
        )
        __L1:r(
            c,
            2907,
            223,
            355,
            184,
            "#a0c1ae"
        )
        __L1:r(
            c,
            2920,
            241,
            326,
            151,
            "#83aeaa"
        )
        do
            local j = 0
            while j < 5 do
                __L1:r(
                    c,
                    2923 + j * 65,
                    242,
                    4,
                    149,
                    "#d2dfc3"
                )
                j = j + 1
            end
        end
        __L1:r(
            c,
            2920,
            310,
            326,
            4,
            "#d2dfc3"
        )
        __L1:r(
            c,
            2887,
            209,
            395,
            12,
            "#3f6a68"
        )
        c:restore()
        local fanX = 785 - camera * 0.17
        c:save()
        c:translate(fanX, 76)
        __L1:r(
            c,
            -2,
            -77,
            4,
            75,
            "#58655a"
        )
        do
            local i = 0
            while i < 3 do
                local a = t * 5 + i * math.pi * 2 / 3
                local dx = math.cos(a)
                local dy = math.sin(a) * 0.32
                __L1:poly(
                    c,
                    __arrL(
                        {
                            __arrL({dx * 5 - dy * 4, dy * 5 + dx * 4}, 2),
                            __arrL({dx * 51 - dy * 4, dy * 51 + dx * 5}, 2),
                            __arrL({dx * 47 + dy * 5, dy * 47 - dx * 5}, 2),
                            __arrL({dx * 6 + dy * 3, dy * 6 - dx * 3}, 2)
                        },
                        4
                    ),
                    "#8d9e89"
                )
                i = i + 1
            end
        end
        __L1:oval(
            c,
            0,
            0,
            7,
            5,
            "#526c64",
            2
        )
        c:restore()
        do
            local i = 0
            while i < 12 do
                local dx = __mod(
                    __mod(i * 137 + t * 3 - camera * 0.2, 1080) + 1080,
                    1080
                ) - 40
                local dy = 75 + __mod(i * 33 + t * 4, 311)
                __L1:r(
                    c,
                    dx,
                    dy,
                    2,
                    2,
                    "#fff1c74d"
                )
                i = i + 1
            end
        end
    end
    __L1.storyCharacter = function(self, c, ____type, x, y, o)
        if o == nil then
            o = {}
        end
        c:save()
        c.imageSmoothingEnabled = false
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        local ____c_185 = c
        local ____c_scale_186 = c.scale
        local ____temp_182 = __lt(o.facing, 0) and -1 or 1
        local ____t_result_181
        if __t(o.scale) then
            ____t_result_181 = o.scale
        else
            ____t_result_181 = 1
        end
        local ____temp_184 = ____temp_182 * ____t_result_181
        local ____t_result_183
        if __t(o.scale) then
            ____t_result_183 = o.scale
        else
            ____t_result_183 = 1
        end
        ____c_scale_186(____c_185, ____temp_184, ____t_result_183)
        if __isFiniteN(o.opacity) then
            c.globalAlpha = c.globalAlpha * math.max(
                0,
                math.min(1, o.opacity)
            )
        end
        local ____t_result_189
        local ____t_188 = __t
        local ____TS__Number_result_187 = __TS__Number(o.frame)
        __O[176] = ____TS__Number_result_187
        if ____t_188(____TS__Number_result_187) then
            ____t_result_189 = __O[176]
        else
            ____t_result_189 = 0
        end
        local t = ____t_result_189
        local moving = not not __t(o.moving) or __TS__Number(o.speed) > 8
        local ____t_result_190
        if __t(moving) then
            ____t_result_190 = math.sin(t * 8)
        else
            ____t_result_190 = 0
        end
        local walk = ____t_result_190
        local ____t_result_191
        if __t(moving) then
            ____t_result_191 = math.floor(math.abs(math.sin(t * 8)) * 2 + 0.5)
        else
            ____t_result_191 = math.floor(math.sin(t * 2) * 0.7 + 0.5)
        end
        local bob = ____t_result_191
        local skin = __get({dede = "#b98b6c", aica = "#d8ad89", ravile = "#b17d57", arthur = "#f0cdb6"}, ____type)
        local shadow = ____type == "arthur" and "#c0947d" or (____type == "aica" and "#af805f" or "#815a42")
        local slim = ____type == "dede" or ____type == "ravile"
        local bodyHalf = __t(slim) and 8 or 11
        local coat = ____type == "dede" and "#516563" or (____type == "aica" and "#e5e7d6" or (____type == "ravile" and "#8fafbf" or "#6d99a0"))
        local pants = ____type == "dede" and "#3a434d" or "#2c435c"
        local ____t_result_195
        local ____t_193 = __t
        local ____temp_192 = ____type == "aica"
        __O[177] = ____temp_192
        if ____t_193(____temp_192) then
            local ____t_result_194
            if __t(o.helping) then
                ____t_result_194 = o.helping
            else
                ____t_result_194 = o.pose == "helping"
            end
            ____t_result_195 = ____t_result_194
        else
            ____t_result_195 = __O[177]
        end
        local helping = ____t_result_195
        local ____t_result_198
        local ____t_197 = __t
        local ____temp_196 = ____type == "ravile"
        __O[178] = ____temp_196
        if ____t_197(____temp_196) then
            ____t_result_198 = o.pose == "earpull" or o.gesture == "earpull"
        else
            ____t_result_198 = __O[178]
        end
        local earPull = ____t_result_198
        local ____t_result_201
        local ____t_200 = __t
        local ____temp_199 = ____type == "arthur"
        __O[179] = ____temp_199
        if ____t_200(____temp_199) then
            ____t_result_201 = o.pose == "earpulled" or o.gesture == "earpulled"
        else
            ____t_result_201 = __O[179]
        end
        local earPulled = ____t_result_201
        local attack = not not __t(o.attack)
        local ____isFiniteN_result_202
        if __isFiniteN(o.attackProgress) then
            ____isFiniteN_result_202 = math.max(
                0,
                math.min(1, o.attackProgress)
            )
        else
            ____isFiniteN_result_202 = 0.5 + 0.5 * math.sin(t * 6)
        end
        local progress = ____isFiniteN_result_202
        local ____t_result_203
        if __t(attack) then
            ____t_result_203 = math.sin(progress * math.pi)
        else
            ____t_result_203 = 0
        end
        local strike = ____t_result_203
        if __t(____type == "dede" and o.smoke ~= false) then
            __L1:smokePuffs(
                c,
                -20,
                -24,
                t,
                0.8
            )
            local ____t_209 = __t
            local ____t_result_208
            local ____t_207 = __t
            local ____t_result_206
            local ____t_205 = __t
            local ____t_result_204
            if __t(o.smoking) then
                ____t_result_204 = o.smoking
            else
                ____t_result_204 = o.smoke
            end
            __O[180] = ____t_result_204
            if ____t_205(____t_result_204) then
                ____t_result_206 = __O[180]
            else
                ____t_result_206 = o.charging
            end
            __O[181] = ____t_result_206
            if ____t_207(____t_result_206) then
                ____t_result_208 = __O[181]
            else
                ____t_result_208 = o.hiddenInSmoke
            end
            if ____t_209(____t_result_208) then
                __L1:smokePuffs(
                    c,
                    24,
                    -33,
                    t + 2,
                    __t(o.charging) and 1.3 or 0.8
                )
            end
        end
        __L1:oval(
            c,
            0,
            -1,
            __t(slim) and 14 or 17,
            3,
            "#35453d",
            2
        )
        local ____t_214 = __t
        local ____t_result_213
        local ____t_211 = __t
        local ____temp_210 = ____type == "ravile"
        __O[182] = ____temp_210
        if ____t_211(____temp_210) then
            local ____t_result_212
            if __t(o.injured) then
                ____t_result_212 = o.injured
            else
                ____t_result_212 = o.fallen
            end
            ____t_result_213 = ____t_result_212
        else
            ____t_result_213 = __O[182]
        end
        if ____t_214(____t_result_213) then
            __L1:r(
                c,
                -41,
                -20,
                26,
                25,
                "#3b302c"
            )
            __L1:r(
                c,
                -40,
                -24,
                21,
                20,
                "#49372d"
            )
            __L1:r(
                c,
                -35,
                -24,
                17,
                18,
                skin
            )
            __L1:r(
                c,
                -36,
                -20,
                3,
                12,
                shadow
            )
            __L1:r(
                c,
                -34,
                -13,
                7,
                1,
                "#4a392f"
            )
            __L1:r(
                c,
                -24,
                -13,
                5,
                1,
                "#4a392f"
            )
            __L1:r(
                c,
                -27,
                -7,
                6,
                2,
                "#7d503c"
            )
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({-21, -12}, 2),
                        __arrL({1, -15}, 2),
                        __arrL({18, -10}, 2),
                        __arrL({14, -4}, 2),
                        __arrL({-21, -4}, 2)
                    },
                    5
                ),
                "#2b3f4e"
            )
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({-20, -10}, 2),
                        __arrL({2, -13}, 2),
                        __arrL({14, -9}, 2),
                        __arrL({11, -5}, 2),
                        __arrL({-20, -5}, 2)
                    },
                    5
                ),
                coat
            )
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL({10, -6}, 2),
                        __arrL({22, -25}, 2),
                        __arrL({36, -8}, 2)
                    },
                    3
                ),
                6,
                "#263b4e"
            )
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL({10, -6}, 2),
                        __arrL({22, -25}, 2),
                        __arrL({36, -8}, 2)
                    },
                    3
                ),
                3,
                pants
            )
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL({9, -5}, 2),
                        __arrL({27, -3}, 2),
                        __arrL({44, -3}, 2)
                    },
                    3
                ),
                6,
                "#263b4e"
            )
            __L1:r(
                c,
                33,
                -9,
                14,
                7,
                "#ecdfc1"
            )
            __L1:r(
                c,
                40,
                -5,
                13,
                5,
                "#e8dfc8"
            )
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL({-11, -12}, 2),
                        __arrL({5, -22}, 2),
                        __arrL({22, -19}, 2)
                    },
                    3
                ),
                5,
                "#2b3c44"
            )
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL({-11, -12}, 2),
                        __arrL({5, -22}, 2)
                    },
                    2
                ),
                3,
                coat
            )
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL({5, -22}, 2),
                        __arrL({22, -19}, 2)
                    },
                    2
                ),
                3,
                skin
            )
            __L1:r(
                c,
                19,
                -22,
                6,
                6,
                skin
            )
            do
                local i = 0
                while i < 3 do
                    local xx = -33 + i * 12
                    local yy = -35 - math.sin(t * 2 + i) * 3
                    __L1:r(
                        c,
                        xx,
                        yy,
                        3,
                        3,
                        "#efd78a"
                    )
                    __L1:r(
                        c,
                        xx - 2,
                        yy + 1,
                        7,
                        1,
                        "#efd78a"
                    )
                    i = i + 1
                end
            end
            c:restore()
            return
        end
        local ____t_218 = __t
        local ____t_result_217
        local ____t_216 = __t
        local ____temp_215 = ____type == "dede"
        __O[183] = ____temp_215
        if ____t_216(____temp_215) then
            ____t_result_217 = o.hiddenInSmoke
        else
            ____t_result_217 = __O[183]
        end
        if ____t_218(____t_result_217) then
            c.globalAlpha = c.globalAlpha * 0.66
        end
        local ____temp_219
        if ____type == "arthur" then
            ____temp_219 = math.sin(t * (__t(moving) and 4 or 2)) * 2.3
        else
            ____temp_219 = 0
        end
        local hip = ____temp_219
        if __t(____type == "aica" or ____type == "ravile") then
            local hair = ____type == "aica" and "#4d392f" or "#362f2b"
            __L1:r(
                c,
                -15,
                -62,
                29,
                42,
                hair
            )
            __L1:r(
                c,
                -14,
                -56,
                5,
                39,
                hair
            )
            __L1:r(
                c,
                10,
                -53,
                5,
                35,
                hair
            )
            __L1:r(
                c,
                -13,
                -21,
                8,
                3,
                hair
            )
            __L1:r(
                c,
                7,
                -21,
                7,
                3,
                hair
            )
        end
        for ____, side in __iterar((__arrL({-1, 1}, 2))) do
            local footX = side * (__t(slim) and 5 or 6) + math.floor(walk * 11 * side + 0.5)
            local ____t_result_220
            if __t(moving) then
                ____t_result_220 = math.max(
                    0,
                    math.cos(t * 8 + (side > 0 and 0 or math.pi))
                ) * 5
            else
                ____t_result_220 = 0
            end
            local footY = ____t_result_220
            if o.grounded == false then
                footX = side > 0 and 11 or -9
                footY = side > 0 and 3 or 10
            end
            if __t(helping) then
                footX = side > 0 and 18 or -9
                footY = 0
                __L1:limb(
                    c,
                    __arrL(
                        {
                            __arrL({side * 5, -17}, 2),
                            __arrL({side > 0 and 11 or -15, -6}, 2),
                            __arrL({footX, -3}, 2)
                        },
                        3
                    ),
                    8,
                    "#263c4b"
                )
                __L1:limb(
                    c,
                    __arrL(
                        {
                            __arrL({side * 5, -17}, 2),
                            __arrL({side > 0 and 11 or -15, -6}, 2),
                            __arrL({footX, -3}, 2)
                        },
                        3
                    ),
                    5,
                    pants
                )
            else
                __L1:limb(
                    c,
                    __arrL(
                        {
                            __arrL(
                                {
                                    side * (__t(slim) and 4 or 5) + hip,
                                    -24
                                },
                                2
                            ),
                            __arrL(
                                {
                                    side * (__t(slim) and 4 or 5) + hip * 0.5,
                                    -13
                                },
                                2
                            ),
                            __arrL({footX, -4 - footY}, 2)
                        },
                        3
                    ),
                    __t(slim) and 6 or 9,
                    "#263a47"
                )
                __L1:limb(
                    c,
                    __arrL(
                        {
                            __arrL(
                                {
                                    side * (__t(slim) and 4 or 5) + hip,
                                    -24
                                },
                                2
                            ),
                            __arrL(
                                {
                                    side * (__t(slim) and 4 or 5) + hip * 0.5,
                                    -13
                                },
                                2
                            ),
                            __arrL({footX, -4 - footY}, 2)
                        },
                        3
                    ),
                    __t(slim) and 3 or 5,
                    pants
                )
            end
            __L1:r(
                c,
                footX - 4,
                -5 - footY,
                12,
                5,
                ____type == "dede" and "#26363b" or "#e8e4d5"
            )
            __L1:r(
                c,
                footX - 3,
                -2 - footY,
                11,
                2,
                ____type == "dede" and "#aab5a4" or "#98afb0"
            )
        end
        c:translate(
            (__t(o.dash) and 5 or walk) + hip,
            -bob + (__t(helping) and 16 or 0)
        )
        local dedeCiclo = __mod(t * 0.3, 1)
        local ____t_result_226
        local ____t_224 = __t
        local ____t_result_223
        local ____t_222 = __t
        local ____temp_221 = ____type == "dede" and not __t(moving)
        __O[184] = ____temp_221
        if ____t_222(____temp_221) then
            ____t_result_223 = not __t(attack)
        else
            ____t_result_223 = __O[184]
        end
        if ____t_224(____t_result_223) then
            local ____temp_225
            if dedeCiclo < 0.2 then
                ____temp_225 = math.sin(dedeCiclo / 0.2 * math.pi)
            else
                ____temp_225 = 0
            end
            ____t_result_226 = ____temp_225
        else
            ____t_result_226 = 0
        end
        local dedeTrago = ____t_result_226
        local ____t_230 = __t
        local ____t_result_229
        local ____t_228 = __t
        local ____temp_227 = ____type == "dede" and not __t(moving)
        __O[185] = ____temp_227
        if ____t_228(____temp_227) then
            ____t_result_229 = not __t(o.dash)
        else
            ____t_result_229 = __O[185]
        end
        if ____t_230(____t_result_229) then
            c:translate(
                math.floor(math.sin(t * 1.1) * 1.6 + 0.5),
                math.floor(math.max(
                    0,
                    math.sin(t * 0.55)
                ) * 1 + 0.5)
            )
        end
        local leftHand = __arrL({-16 + walk * 7, -19}, 2)
        local rightHand = __arrL({17 - walk * 7, -19}, 2)
        if ____type == "dede" then
            leftHand = __arrL(
                {
                    -13 + math.floor(math.sin(t * 1.1) * 2 + 0.5),
                    -19
                },
                2
            )
            rightHand = __arrL(
                {
                    math.floor(21 - dedeTrago * 9 + 0.5),
                    math.floor(-28 - dedeTrago * 15 + 0.5)
                },
                2
            )
        end
        if __t(____type == "aica" and not __t(moving)) then
            leftHand = __arrL({-11, -21}, 2)
            rightHand = __arrL(
                {
                    20,
                    -26 + math.sin(t * 2) * 2
                },
                2
            )
        end
        if __t(helping) then
            leftHand = __arrL({-12, -13}, 2)
            rightHand = __arrL({35, -15}, 2)
        end
        if __t(____type == "ravile" and not __t(moving)) then
            leftHand = __arrL({-13, -20}, 2)
            rightHand = __arrL({19, -24}, 2)
        end
        if __t(____type == "arthur" and not __t(moving)) then
            leftHand = __arrL({-9, -24}, 2)
            rightHand = __arrL(
                {
                    26 + math.sin(t * 2) * 3,
                    -35 + math.sin(t * 3) * 4
                },
                2
            )
        end
        local ____t_234 = __t
        local ____t_result_233
        local ____t_232 = __t
        local ____temp_231 = ____type == "arthur"
        __O[186] = ____temp_231
        if ____t_232(____temp_231) then
            ____t_result_233 = moving
        else
            ____t_result_233 = __O[186]
        end
        if ____t_234(____t_result_233) then
            leftHand = __arrL(
                {
                    -13 + walk * 10,
                    -27 + math.cos(t * 4) * 5
                },
                2
            )
            rightHand = __arrL(
                {
                    18 - walk * 8,
                    -30 - math.cos(t * 4) * 6
                },
                2
            )
        end
        if __t(attack) then
            local ____temp_235
            if ____type == "arthur" then
                ____temp_235 = __arrL({27 + strike * 20, -37 - strike * 5}, 2)
            else
                ____temp_235 = __arrL({27 + strike * 12, -35 - strike * 11}, 2)
            end
            rightHand = ____temp_235
            leftHand = __arrL({-13, -34}, 2)
        end
        local ____t_237 = __t
        local ____t_result_236
        if __t(o.charging) then
            ____t_result_236 = ____type == "dede"
        else
            ____t_result_236 = o.charging
        end
        if ____t_237(____t_result_236) then
            leftHand = __arrL({-28, -30}, 2)
            rightHand = __arrL({29, -35}, 2)
        end
        local ____t_239 = __t
        local ____t_result_238
        if __t(o.inhale) then
            ____t_result_238 = ____type == "dede"
        else
            ____t_result_238 = o.inhale
        end
        if ____t_239(____t_result_238) then
            leftHand = __arrL({-17, -26}, 2)
            rightHand = __arrL({12, -43}, 2)
        end
        if __t(earPull) then
            rightHand = __arrL({59, -53}, 2)
            leftHand = __arrL({-11, -25}, 2)
        end
        if __t(earPulled) then
            leftHand = __arrL({-17, -49}, 2)
            rightHand = __arrL({-6, -42}, 2)
        end
        local function arm(self, side)
            local ____gt_result_240
            if __gt(side, 0) then
                ____gt_result_240 = rightHand
            else
                ____gt_result_240 = leftHand
            end
            local ____end = ____gt_result_240
            local ____arrL_242 = __arrL
            local ____gt_result_241
            if __gt(side, 0) then
                ____gt_result_241 = __t(slim) and 15 or 18
            else
                ____gt_result_241 = -(__t(slim) and 14 or 17)
            end
            local elbow = ____arrL_242({____gt_result_241, -29 + walk * side * 3}, 2)
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL({side * bodyHalf, -36}, 2),
                        elbow,
                        ____end
                    },
                    3
                ),
                __t(slim) and 6 or 8,
                "#293a40"
            )
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL({side * bodyHalf, -36}, 2),
                        elbow
                    },
                    2
                ),
                __t(slim) and 3 or 5,
                coat
            )
            local ____L1_limb_245 = __L1.limb
            local ____array_244 = __TS__SparseArrayNew(
                c,
                __arrL({elbow, ____end}, 2),
                __t(slim) and 3 or 5
            )
            local ____temp_243
            if ____type == "dede" then
                ____temp_243 = coat
            else
                ____temp_243 = skin
            end
            __TS__SparseArrayPush(____array_244, ____temp_243)
            ____L1_limb_245(
                __L1,
                __TS__SparseArraySpread(____array_244)
            )
            __L1:r(
                c,
                __get(____end, 0) - 3,
                __get(____end, 1) - 3,
                6,
                6,
                skin
            )
        end
        arm(nil, -1)
        __L1:r(
            c,
            -bodyHalf - 2,
            -41,
            bodyHalf * 2 + 5,
            25,
            "#263b43"
        )
        __L1:r(
            c,
            -bodyHalf,
            -39,
            bodyHalf * 2 + 1,
            21,
            coat
        )
        __L1:r(
            c,
            -bodyHalf + 1,
            -36,
            2,
            13,
            ____type == "dede" and "#788b80" or "#d7e3dc"
        )
        __L1:r(
            c,
            -bodyHalf,
            -21,
            bodyHalf * 2 + 1,
            3,
            ____type == "dede" and "#334748" or "#325577"
        )
        if ____type == "dede" then
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({-9, -40}, 2),
                        __arrL({-3, -43}, 2),
                        __arrL({0, -29}, 2),
                        __arrL({-6, -34}, 2)
                    },
                    4
                ),
                "#9ba797"
            )
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({9, -40}, 2),
                        __arrL({3, -43}, 2),
                        __arrL({0, -29}, 2),
                        __arrL({6, -34}, 2)
                    },
                    4
                ),
                "#7c968d"
            )
            __L1:r(
                c,
                0,
                -28,
                2,
                9,
                "#c6c4a2"
            )
            __L1:r(
                c,
                -7,
                -27,
                5,
                1,
                "#bfd2ba"
            )
        else
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({-7, -40}, 2),
                        __arrL({0, -34}, 2),
                        __arrL({7, -40}, 2),
                        __arrL({5, -33}, 2),
                        __arrL({0, -30}, 2),
                        __arrL({-5, -33}, 2)
                    },
                    6
                ),
                "#214d6e"
            )
            __L1:r(
                c,
                5,
                -32,
                5,
                5,
                "#315c7e"
            )
            __L1:r(
                c,
                6,
                -31,
                3,
                2,
                "#b9d8d9"
            )
        end
        arm(nil, 1)
        __L1:r(
            c,
            -4,
            -45,
            10,
            8,
            shadow
        )
        __L1:r(
            c,
            -3,
            -45,
            8,
            8,
            skin
        )
        __L1:r(
            c,
            -12,
            -61,
            27,
            21,
            "#2b3435"
        )
        __L1:r(
            c,
            -10,
            -59,
            23,
            18,
            skin
        )
        __L1:r(
            c,
            -11,
            -55,
            3,
            12,
            shadow
        )
        __L1:r(
            c,
            12,
            -52,
            4,
            6,
            skin
        )
        __L1:r(
            c,
            3,
            -53,
            3,
            3,
            "#2d3334"
        )
        __L1:r(
            c,
            12,
            -48,
            3,
            2,
            shadow
        )
        __L1:r(
            c,
            2,
            -44,
            8,
            2,
            shadow
        )
        if ____type == "arthur" then
            __L1:oval(
                c,
                0,
                -60,
                12,
                9,
                skin,
                2
            )
            __L1:r(
                c,
                -9,
                -65,
                19,
                2,
                "#d2b89b"
            )
            do
                local i = 0
                while i < 12 do
                    __L1:r(
                        c,
                        -10 + __mod(i, 7) * 3,
                        -64 + math.floor(i / 7) * 3 + __mod(i, 2),
                        1,
                        1,
                        "#676758"
                    )
                    i = i + 1
                end
            end
            __L1:r(
                c,
                -12,
                -56,
                2,
                7,
                "#727566"
            )
            __L1:r(
                c,
                -7,
                -55,
                11,
                7,
                "#263d49"
            )
            __L1:r(
                c,
                5,
                -55,
                11,
                7,
                "#263d49"
            )
            __L1:r(
                c,
                -5,
                -53,
                7,
                3,
                "#c5d9d7"
            )
            __L1:r(
                c,
                7,
                -53,
                7,
                3,
                "#c5d9d7"
            )
            __L1:r(
                c,
                3,
                -53,
                3,
                2,
                "#263d49"
            )
            __L1:r(
                c,
                -4,
                -54,
                3,
                1,
                "#f6eed7"
            )
            __L1:r(
                c,
                8,
                -54,
                3,
                1,
                "#f6eed7"
            )
            local hx = __get(rightHand, 0)
            local hy = __get(rightHand, 1)
            if not __t(earPulled) then
                __L1:r(
                    c,
                    hx - 2,
                    hy - 5,
                    4,
                    9,
                    skin
                )
                do
                    local i = 0
                    while i < 3 do
                        __L1:r(
                            c,
                            hx + 1 + i * 2,
                            hy - 5 + i,
                            1,
                            5,
                            skin
                        )
                        i = i + 1
                    end
                end
                __L1:r(
                    c,
                    hx - 4,
                    hy - 1,
                    3,
                    2,
                    skin
                )
            end
            if __t(earPulled) then
                __L1:r(
                    c,
                    -17,
                    -55,
                    7,
                    7,
                    skin
                )
                __L1:r(
                    c,
                    -18,
                    -54,
                    3,
                    5,
                    "#d5967c"
                )
                __L1:r(
                    c,
                    0,
                    -44,
                    10,
                    4,
                    "#986549"
                )
                __L1:r(
                    c,
                    2,
                    -44,
                    6,
                    2,
                    "#f5e1c5"
                )
                __L1:r(
                    c,
                    5,
                    -42,
                    3,
                    2,
                    "#b78064"
                )
            end
            if __t(attack) then
                __L1:r(
                    c,
                    hx - 2,
                    hy - 6,
                    9,
                    12,
                    skin
                )
                do
                    local i = 0
                    while i < 4 do
                        __L1:r(
                            c,
                            hx - 3 + i * 3,
                            hy - 9,
                            2,
                            6,
                            skin
                        )
                        i = i + 1
                    end
                end
                __L1:limb(
                    c,
                    __arrL(
                        {
                            __arrL({hx + 4, hy - 17}, 2),
                            __arrL({hx + 15, hy - 10}, 2),
                            __arrL({hx + 20, hy + 2}, 2)
                        },
                        3
                    ),
                    2,
                    "#f8dba3"
                )
                __L1:limb(
                    c,
                    __arrL(
                        {
                            __arrL({hx + 10, hy - 19}, 2),
                            __arrL({hx + 22, hy - 10}, 2),
                            __arrL({hx + 26, hy + 1}, 2)
                        },
                        3
                    ),
                    2,
                    "#d68d85"
                )
            end
        elseif ____type == "dede" then
            __L1:r(
                c,
                -12,
                -63,
                25,
                7,
                "#252f2d"
            )
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({-11, -61}, 2),
                        __arrL({-11, -66}, 2),
                        __arrL({-7, -64}, 2),
                        __arrL({-6, -68}, 2),
                        __arrL({-2, -65}, 2),
                        __arrL({1, -70}, 2),
                        __arrL({4, -65}, 2),
                        __arrL({8, -68}, 2),
                        __arrL({10, -64}, 2),
                        __arrL({14, -66}, 2),
                        __arrL({13, -60}, 2)
                    },
                    11
                ),
                "#26322d"
            )
            __L1:r(
                c,
                -8,
                -64,
                6,
                2,
                "#465044"
            )
            __L1:r(
                c,
                2,
                -65,
                5,
                2,
                "#414c40"
            )
            __L1:r(
                c,
                -12,
                -57,
                4,
                6,
                "#252f2d"
            )
            __L1:r(
                c,
                10,
                -58,
                4,
                5,
                "#252f2d"
            )
            __L1:r(
                c,
                0,
                -46,
                12,
                5,
                "#78513e"
            )
            __L1:r(
                c,
                1,
                -46,
                10,
                4,
                "#f3e2c4"
            )
            __L1:r(
                c,
                1,
                -44,
                10,
                1,
                "#858e92"
            )
            do
                local j = 0
                while j < 3 do
                    __L1:r(
                        c,
                        2 + j * 3,
                        -45,
                        2,
                        2,
                        "#c6d8dc"
                    )
                    __L1:r(
                        c,
                        2 + j * 3,
                        -44,
                        1,
                        1,
                        "#5e7c8c"
                    )
                    j = j + 1
                end
            end
            __L1:r(
                c,
                2,
                -41,
                8,
                1,
                "#a66f51"
            )
            local pisca = __mod(t * 0.23, 1) < 0.06
            __L1:r(
                c,
                1,
                -56,
                9,
                7,
                skin
            )
            __L1:r(
                c,
                2,
                -54,
                6,
                3,
                "#e7b3a9"
            )
            __L1:r(
                c,
                2,
                -53,
                1,
                1,
                "#cf4f47"
            )
            __L1:r(
                c,
                7,
                -53,
                1,
                1,
                "#cf4f47"
            )
            __L1:r(
                c,
                4,
                -53,
                2,
                2,
                "#2f2622"
            )
            __L1:r(
                c,
                1,
                -56,
                8,
                __t(pisca) and 5 or 3,
                "#8d5c46"
            )
            __L1:r(
                c,
                1,
                __t(pisca) and -52 or -54,
                8,
                1,
                "#3e2a24"
            )
            __L1:r(
                c,
                2,
                -50,
                6,
                1,
                "#7f5248"
            )
            __L1:r(
                c,
                3,
                -49,
                4,
                1,
                "#9c6c5c"
            )
            __L1:r(
                c,
                0,
                -58,
                9,
                1,
                "#2c2a26"
            )
            local hx = __get(rightHand, 0)
            local hy = __get(rightHand, 1)
            local brilho = __t(o.inhale) and 1 or dedeTrago
            local ____t_249 = __t
            local ____t_result_248
            local ____t_247 = __t
            local ____temp_246 = not __t(attack) or progress < 0.32
            __O[187] = ____temp_246
            if ____t_247(____temp_246) then
                ____t_result_248 = __O[187]
            else
                ____t_result_248 = progress > 0.85
            end
            if ____t_249(____t_result_248) then
                __L1:r(
                    c,
                    hx + 1,
                    hy - 3,
                    3,
                    2,
                    "#d9953f"
                )
                __L1:r(
                    c,
                    hx + 4,
                    hy - 3,
                    6,
                    2,
                    "#f3efe2"
                )
                __L1:r(
                    c,
                    hx + 4,
                    hy - 2,
                    6,
                    1,
                    "#cfc8b8"
                )
                __L1:r(
                    c,
                    hx + 10,
                    hy - 3,
                    1,
                    2,
                    "#8f8c84"
                )
                __L1:r(
                    c,
                    hx + 11,
                    hy - 3,
                    2,
                    2,
                    brilho > 0.3 and "#ff7a2a" or "#c8401f"
                )
                if __t(brilho > 0.3 or math.sin(t * 5) > 0.6) then
                    __L1:r(
                        c,
                        hx + 12,
                        hy - 4,
                        1,
                        1,
                        "#ffd27a"
                    )
                end
                if brilho > 0.3 then
                    c:save()
                    c.globalAlpha = c.globalAlpha * (0.3 * brilho)
                    __L1:r(
                        c,
                        hx + 9,
                        hy - 6,
                        7,
                        7,
                        "#ff8a30"
                    )
                    c:restore()
                end
                if o.smoke ~= false then
                    c:save()
                    local base = c.globalAlpha
                    do
                        local i = 0
                        while i < 9 do
                            local k = __mod(t * 0.55 + i / 9, 1)
                            c.globalAlpha = base * (1 - k) * 0.7
                            __L1:r(
                                c,
                                hx + 12 + math.sin(t * 2.2 + k * 7) * k * 5,
                                hy - 5 - k * 34,
                                k > 0.5 and 2 or 1,
                                2,
                                k > 0.4 and "#c9d3cf" or "#e6ece6"
                            )
                            i = i + 1
                        end
                    end
                    c:restore()
                end
            end
            local ____t_255 = __t
            local ____t_result_254
            local ____t_253 = __t
            local ____t_result_252
            local ____t_251 = __t
            local ____temp_250 = o.smoke ~= false and not __t(moving)
            __O[188] = ____temp_250
            if ____t_251(____temp_250) then
                ____t_result_252 = dedeCiclo > 0.21
            else
                ____t_result_252 = __O[188]
            end
            __O[189] = ____t_result_252
            if ____t_253(____t_result_252) then
                ____t_result_254 = dedeCiclo < 0.46
            else
                ____t_result_254 = __O[189]
            end
            if ____t_255(____t_result_254) then
                local k = (dedeCiclo - 0.21) / 0.25
                c:save()
                local base = c.globalAlpha
                do
                    local i = 0
                    while i < 5 do
                        do
                            local kk = math.min(1, k * 1.3 - i * 0.08)
                            if kk <= 0 then
                                do i = i + 1 continue end
                            end
                            c.globalAlpha = base * (1 - kk) * 0.8
                            __L1:oval(
                                c,
                                14 + kk * 24 + i * 3,
                                -44 - kk * 14 - i * 2,
                                3 + kk * 6,
                                2 + kk * 4,
                                __t(__mod(i, 2)) and "#c6d1cd" or "#e4ebe4",
                                2
                            )
                        end
                        i = i + 1
                    end
                end
                c:restore()
            end
            if __t(o.inhale) then
                c:save()
                local base = c.globalAlpha
                do
                    local i = 0
                    while i < 8 do
                        local k = 1 - __mod(t * 1.8 + i / 8, 1)
                        c.globalAlpha = base * (1 - k) * 0.8
                        __L1:r(
                            c,
                            14 + math.cos(i * 0.8) * k * 40,
                            -44 + math.sin(i * 0.8) * k * 26,
                            2,
                            2,
                            "#dfe6e0"
                        )
                        i = i + 1
                    end
                end
                c:restore()
            end
        else
            local hair = ____type == "aica" and "#4d392f" or "#362f2b"
            __L1:r(
                c,
                -13,
                -64,
                28,
                9,
                hair
            )
            __L1:r(
                c,
                -10,
                -67,
                22,
                5,
                hair
            )
            __L1:r(
                c,
                -13,
                -59,
                5,
                26,
                hair
            )
            __L1:r(
                c,
                11,
                -58,
                4,
                32,
                hair
            )
            __L1:r(
                c,
                -9,
                -63,
                7,
                2,
                ____type == "aica" and "#77573d" or "#65503a"
            )
            __L1:r(
                c,
                6,
                -63,
                7,
                2,
                ____type == "aica" and "#77573d" or "#65503a"
            )
            __L1:r(
                c,
                -1,
                -55,
                9,
                1,
                "#624635"
            )
            __L1:r(
                c,
                2,
                -45,
                9,
                2,
                "#8b5b42"
            )
            __L1:r(
                c,
                4,
                -45,
                5,
                1,
                "#ebc7a7"
            )
            local ____t_259 = __t
            local ____t_result_258
            local ____t_257 = __t
            local ____temp_256 = ____type == "aica"
            __O[190] = ____temp_256
            if ____t_257(____temp_256) then
                ____t_result_258 = o.shouting
            else
                ____t_result_258 = __O[190]
            end
            if ____t_259(____t_result_258) then
                __L1:r(
                    c,
                    0,
                    -45,
                    12,
                    6,
                    "#774a3d"
                )
                __L1:r(
                    c,
                    2,
                    -45,
                    8,
                    2,
                    "#f5dac0"
                )
            end
            if __t(earPull) then
                __L1:r(
                    c,
                    56,
                    -56,
                    9,
                    7,
                    skin
                )
                __L1:r(
                    c,
                    62,
                    -56,
                    3,
                    5,
                    shadow
                )
                __L1:r(
                    c,
                    59,
                    -58,
                    6,
                    3,
                    skin
                )
            end
        end
        if __t(o.dash) then
            __L1:r(
                c,
                -34,
                -44,
                12,
                2,
                "#b9d4ca"
            )
            __L1:r(
                c,
                -43,
                -29,
                18,
                2,
                "#e0dfba"
            )
        end
        if __t(o.hit) then
            c:save()
            c.globalAlpha = c.globalAlpha * 0.45
            __L1:r(
                c,
                -18,
                -66,
                39,
                66,
                "#fff1cd"
            )
            c:restore()
        end
        c:restore()
    end
    __L1.courtyard = function(self, c, camera, t)
        c:save()
        c:translate(
            -math.floor(camera + 0.5),
            0
        )
        local width = __L1:worldWidth(9)
        __L1:r(
            c,
            0,
            352,
            width,
            88,
            "#cbd5cb"
        )
        __L1:r(
            c,
            0,
            352,
            width,
            6,
            "#f1f0da"
        )
        __L1:r(
            c,
            0,
            390,
            width,
            50,
            "#d9d8c3"
        )
        __L1:r(
            c,
            0,
            212,
            width,
            144,
            "#f0f4ef"
        )
        __L1:r(
            c,
            0,
            212,
            width,
            9,
            "#173e65"
        )
        __L1:r(
            c,
            0,
            223,
            width,
            4,
            "#ffffff"
        )
        __L1:r(
            c,
            0,
            322,
            width,
            34,
            "#254f75"
        )
        __L1:r(
            c,
            0,
            322,
            width,
            4,
            "#183d5d"
        )
        do
            local x = 55
            while x < width do
                do
                    if __t(x < camera - 180 or __gt(x, camera + 1150)) then
                        do x = x + 187 continue end
                    end
                    __L1:r(
                        c,
                        x,
                        244,
                        101,
                        64,
                        "#294e68"
                    )
                    __L1:r(
                        c,
                        x + 5,
                        249,
                        91,
                        54,
                        "#7bafb7"
                    )
                    __L1:r(
                        c,
                        x + 9,
                        253,
                        36,
                        20,
                        "#c2dfe0"
                    )
                    __L1:r(
                        c,
                        x + 51,
                        278,
                        40,
                        20,
                        "#9fc8c9"
                    )
                    __L1:r(
                        c,
                        x + 47,
                        249,
                        4,
                        54,
                        "#e6eee1"
                    )
                    __L1:r(
                        c,
                        x + 5,
                        275,
                        91,
                        4,
                        "#e6eee1"
                    )
                    __L1:r(
                        c,
                        x - 4,
                        308,
                        109,
                        5,
                        "#acbcb7"
                    )
                end
                x = x + 187
            end
        end
        __L1:r(
            c,
            10,
            187,
            width - 20,
            14,
            "#163e63"
        )
        __L1:r(
            c,
            10,
            187,
            width - 20,
            4,
            "#457c9d"
        )
        do
            local x = 22
            while x < width do
                __L1:r(
                    c,
                    x,
                    200,
                    11,
                    156,
                    "#becfcf"
                )
                __L1:r(
                    c,
                    x + 2,
                    201,
                    4,
                    153,
                    "#f7f9ec"
                )
                __L1:r(
                    c,
                    x - 4,
                    349,
                    19,
                    8,
                    "#7eaaad"
                )
                x = x + 365
            end
        end
        __L1:r(
            c,
            333,
            229,
            400,
            43,
            "#1b4467"
        )
        c.fillStyle = "#f0f4e6"
        c.font = "bold 18px monospace"
        c:fillText("COLÉGIO ADVENTISTA", 357, 255)
        c.font = "bold 9px monospace"
        c.fillStyle = "#a9d5da"
        c:fillText("PÁTIO · UM RECREIO DE MUITAS HISTÓRIAS", 356, 267)
        for ____, x in __iterar((__arrL({70, 1220, 2170, 3490}, 4))) do
            do
                if __t(x < camera - 150 or __gt(x, camera + 1120)) then
                    continue
                end
                __L1:tree(
                    c,
                    x,
                    428,
                    0.72,
                    1
                )
                __L1:oval(
                    c,
                    x,
                    432,
                    55,
                    8,
                    "#6e9b8b",
                    3
                )
                __L1:r(
                    c,
                    x - 49,
                    426,
                    97,
                    10,
                    "#436d72"
                )
                __L1:r(
                    c,
                    x - 46,
                    426,
                    91,
                    3,
                    "#b2d1bd"
                )
            end
        end
        for ____, x in __iterar((__arrL({90, 1460, 1980, 3370}, 4))) do
            do
                if __t(x < camera - 200 or __gt(x, camera + 1120)) then
                    continue
                end
                __L1:r(
                    c,
                    x,
                    396,
                    130,
                    10,
                    "#2c5e8e"
                )
                __L1:r(
                    c,
                    x + 4,
                    399,
                    122,
                    3,
                    "#6296b7"
                )
                __L1:r(
                    c,
                    x + 9,
                    406,
                    7,
                    33,
                    "#587e8d"
                )
                __L1:r(
                    c,
                    x + 113,
                    406,
                    7,
                    33,
                    "#587e8d"
                )
                __L1:r(
                    c,
                    x,
                    372,
                    130,
                    7,
                    "#386e9d"
                )
                __L1:r(
                    c,
                    x,
                    385,
                    130,
                    6,
                    "#386e9d"
                )
                do
                    local j = 0
                    while j < 2 do
                        __L1:backgroundCitizen(
                            c,
                            x + 40 + j * 43,
                            400,
                            t,
                            math.floor(x / 90) + j,
                            true
                        )
                        j = j + 1
                    end
                end
            end
        end
        do
            local x = 750
            while x < width do
                __L1:r(
                    c,
                    x,
                    165,
                    5,
                    188,
                    "#365f75"
                )
                __L1:r(
                    c,
                    x - 9,
                    152,
                    24,
                    15,
                    "#244b69"
                )
                __L1:r(
                    c,
                    x - 6,
                    155,
                    18,
                    7,
                    "#fff0b4"
                )
                x = x + 850
            end
        end
        __L1:r(
            c,
            1640,
            143,
            833,
            2,
            "#557e85"
        )
        do
            local i = 0
            while i < 18 do
                local xx = 1650 + i * 45
                __L1:poly(
                    c,
                    __arrL(
                        {
                            __arrL({xx, 145}, 2),
                            __arrL({xx + 22, 145}, 2),
                            __arrL(
                                {
                                    xx + 13,
                                    166 + math.sin(t * 2 + i) * 3
                                },
                                2
                            )
                        },
                        3
                    ),
                    __mod(i, 3) == 0 and "#659fbe" or (__mod(i, 3) == 1 and "#f1e4ba" or "#94bc9b")
                )
                i = i + 1
            end
        end
        local pigeonX = 1020 + math.sin(t * 0.8) * 5
        __L1:r(
            c,
            pigeonX,
            180,
            9,
            7,
            "#9caaa9"
        )
        __L1:r(
            c,
            pigeonX + 7,
            176,
            5,
            8,
            "#c6ccc3"
        )
        __L1:r(
            c,
            pigeonX + 10,
            178,
            2,
            1,
            "#3d5b62"
        )
        __L1:r(
            c,
            pigeonX + 12,
            181,
            3,
            1,
            "#ba9d60"
        )
        __L1:r(
            c,
            pigeonX + 1,
            187,
            2,
            3,
            "#b59872"
        )
        __L1:r(
            c,
            pigeonX + 6,
            187,
            2,
            3,
            "#b59872"
        )
        __L1:r(
            c,
            3770,
            282,
            190,
            50,
            "#32617b"
        )
        c.fillStyle = "#e8efdc"
        c.font = "bold 13px monospace"
        c:fillText("RESPEITO & RESENHA", 3780, 305)
        c.font = "bold 9px monospace"
        c:fillText("TODO MUNDO TEM VEZ.", 3799, 322)
        c:restore()
    end
    __L1.questArena = function(self, c, ____type, camera, t, homeX)
        c:save()
        local ____t_result_260
        if __t(homeX) then
            ____t_result_260 = homeX - camera
        else
            ____t_result_260 = 480
        end
        local center = ____t_result_260
        if ____type == "arthur" then
            __L1:sky(c, 9, 0, t)
            __L1:courtyard(
                c,
                math.max(0, homeX - 480),
                t
            )
            c:save()
            c:translate(
                math.floor(center - 480 + 0.5),
                0
            )
            __L1:r(
                c,
                217,
                118,
                528,
                46,
                "#16476a"
            )
            __L1:r(
                c,
                223,
                124,
                516,
                34,
                "#2d6686"
            )
            c.fillStyle = "#eff2d8"
            c.font = "bold 21px monospace"
            c:fillText("UM ACERTO NO PÁTIO", 354, 148)
            for ____, x in __iterar((__arrL({110, 809}, 2))) do
                __L1:r(
                    c,
                    x,
                    331,
                    49,
                    104,
                    "#315d7a"
                )
                __L1:r(
                    c,
                    x + 4,
                    335,
                    41,
                    96,
                    "#527c91"
                )
                __L1:r(
                    c,
                    x - 8,
                    326,
                    65,
                    9,
                    "#bed4cf"
                )
                __L1:r(
                    c,
                    x + 9,
                    348,
                    24,
                    2,
                    "#91b5b8"
                )
                __L1:r(
                    c,
                    x + 9,
                    367,
                    24,
                    2,
                    "#91b5b8"
                )
            end
            do
                local i = 0
                while i < 6 do
                    local xx = 191 + i * 112
                    local yy = 301 + math.sin(t + i) * 4
                    __L1:r(
                        c,
                        xx,
                        yy,
                        20,
                        2,
                        "#b6d8d5"
                    )
                    __L1:r(
                        c,
                        xx + 4,
                        yy - 7,
                        2,
                        7,
                        "#b6d8d5"
                    )
                    __L1:r(
                        c,
                        xx + 10,
                        yy - 9,
                        2,
                        9,
                        "#b6d8d5"
                    )
                    __L1:r(
                        c,
                        xx + 16,
                        yy - 6,
                        2,
                        6,
                        "#b6d8d5"
                    )
                    i = i + 1
                end
            end
            c:restore()
            __L1:r(
                c,
                0,
                440,
                960,
                100,
                "#bacbc7"
            )
            __L1:r(
                c,
                0,
                440,
                960,
                6,
                "#f3efcf"
            )
            do
                local i = 0
                while i < 18 do
                    __L1:r(
                        c,
                        i * 59,
                        451,
                        1,
                        89,
                        "#80a6aa"
                    )
                    __L1:r(
                        c,
                        i * 59 + 6,
                        479,
                        45,
                        2,
                        "#dfe7d4"
                    )
                    i = i + 1
                end
            end
            c:restore()
            return
        end
        __L1:r(
            c,
            0,
            0,
            960,
            440,
            "#254858"
        )
        __L1:r(
            c,
            0,
            155,
            960,
            285,
            "#537f84"
        )
        c:save()
        c:translate(
            math.floor(center - 480 + 0.5),
            0
        )
        do
            local i = -1
            while i < 9 do
                local xx = i * 139
                local hh = 103 + __L1:hash(i + 91) * 108
                __L1:favelaHouse(
                    c,
                    xx,
                    356 - hh,
                    128,
                    hh,
                    i + 9,
                    t,
                    true
                )
                __L1:r(
                    c,
                    xx + 9,
                    365 - hh,
                    22,
                    25,
                    "#b3c6aa"
                )
                __L1:r(
                    c,
                    xx + 13,
                    369 - hh,
                    13,
                    16,
                    "#f1d7a4"
                )
                i = i + 1
            end
        end
        __L1:r(
            c,
            -200,
            350,
            1360,
            90,
            "#536766"
        )
        __L1:r(
            c,
            -200,
            347,
            1360,
            9,
            "#a6bcb0"
        )
        do
            local i = 0
            while i < 20 do
                __L1:r(
                    c,
                    -150 + i * 69,
                    363,
                    2,
                    76,
                    "#8b9a8b"
                )
                i = i + 1
            end
        end
        for ____, x in __iterar((__arrL({95, 791}, 2))) do
            __L1:r(
                c,
                x,
                117,
                73,
                231,
                "#364e56"
            )
            __L1:r(
                c,
                x + 6,
                123,
                61,
                221,
                "#6c8582"
            )
            do
                local j = 0
                while j < 4 do
                    __L1:r(
                        c,
                        x + 8,
                        147 + j * 45,
                        56,
                        3,
                        "#455f65"
                    )
                    j = j + 1
                end
            end
            __L1:r(
                c,
                x - 8,
                107,
                89,
                16,
                "#b6b9a0"
            )
            __L1:smokePuffs(
                c,
                x + 36,
                103,
                t + x * 0.03,
                0.8
            )
        end
        __L1:r(
            c,
            257,
            177,
            451,
            43,
            "#263f4b"
        )
        c.fillStyle = "#dbe6ce"
        c.font = "bold 19px monospace"
        c:fillText("DEDÊ · ENTRE AS NUVENS", 285, 205)
        do
            local i = 0
            while i < 7 do
                c:save()
                c.globalAlpha = c.globalAlpha * 0.16
                local xx = -100 + __mod(i * 177 + t * 12, 1220)
                local yy = 220 + math.sin(t * 0.7 + i) * 25
                __L1:oval(
                    c,
                    xx,
                    yy,
                    75,
                    20,
                    "#c3d5cb",
                    4
                )
                __L1:oval(
                    c,
                    xx + 40,
                    yy - 16,
                    61,
                    25,
                    "#dce5d3",
                    4
                )
                c:restore()
                i = i + 1
            end
        end
        c:restore()
        __L1:r(
            c,
            0,
            440,
            960,
            100,
            "#5b7474"
        )
        __L1:r(
            c,
            0,
            440,
            960,
            6,
            "#bfd6c5"
        )
        do
            local i = 0
            while i < 18 do
                __L1:r(
                    c,
                    i * 59,
                    451,
                    1,
                    89,
                    "#3c5b65"
                )
                __L1:r(
                    c,
                    i * 59 + 6,
                    480,
                    33,
                    2,
                    "#90aaa1"
                )
                i = i + 1
            end
        end
        c:restore()
    end
    __L1.rat = function(self, c, x, y, t, o)
        if t == nil then
            t = 0
        end
        if o == nil then
            o = {}
        end
        c:save()
        c.imageSmoothingEnabled = false
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        local ____c_265 = c
        local ____c_scale_266 = c.scale
        local ____temp_262 = __lt(o.facing, 0) and -1 or 1
        local ____t_result_261
        if __t(o.scale) then
            ____t_result_261 = o.scale
        else
            ____t_result_261 = 1
        end
        local ____temp_264 = ____temp_262 * ____t_result_261
        local ____t_result_263
        if __t(o.scale) then
            ____t_result_263 = o.scale
        else
            ____t_result_263 = 1
        end
        ____c_scale_266(____c_265, ____temp_264, ____t_result_263)
        local step = math.sin(t * 18) * 3
        __L1:limb(
            c,
            __arrL(
                {
                    __arrL({-13, -8}, 2),
                    __arrL(
                        {
                            -25,
                            -12 + math.sin(t * 5) * 3
                        },
                        2
                    ),
                    __arrL(
                        {
                            -35,
                            -6 + math.cos(t * 4) * 3
                        },
                        2
                    )
                },
                3
            ),
            3,
            "#bd9c8c"
        )
        __L1:oval(
            c,
            -2,
            -10,
            18,
            10,
            "#3f4b4a",
            2
        )
        __L1:oval(
            c,
            -5,
            -13,
            13,
            6,
            "#69736c",
            2
        )
        __L1:poly(
            c,
            __arrL(
                {
                    __arrL({8, -18}, 2),
                    __arrL({21, -17}, 2),
                    __arrL({29, -6}, 2),
                    __arrL({21, -3}, 2),
                    __arrL({7, -7}, 2)
                },
                5
            ),
            "#4d5853"
        )
        __L1:oval(
            c,
            11,
            -20,
            6,
            6,
            "#3d4a45",
            2
        )
        __L1:oval(
            c,
            11,
            -20,
            3,
            3,
            "#ae8b83",
            2
        )
        __L1:r(
            c,
            21,
            -13,
            3,
            3,
            "#1f3337"
        )
        __L1:r(
            c,
            21,
            -13,
            1,
            1,
            "#f3e8c8"
        )
        __L1:r(
            c,
            27,
            -7,
            3,
            3,
            "#bc8c85"
        )
        for ____, side in __iterar((__arrL({-1, 1}, 2))) do
            __L1:r(
                c,
                -12 + side * 3,
                -2 - math.max(0, step * side),
                9,
                3,
                "#a99a82"
            )
            __L1:r(
                c,
                7 + side * 3,
                -2 - math.max(0, -step * side),
                9,
                3,
                "#a99a82"
            )
        end
        __L1:limb(
            c,
            __arrL(
                {
                    __arrL({23, -5}, 2),
                    __arrL({34, -9}, 2)
                },
                2
            ),
            1,
            "#d3c7aa"
        )
        __L1:limb(
            c,
            __arrL(
                {
                    __arrL({23, -5}, 2),
                    __arrL({35, -3}, 2)
                },
                2
            ),
            1,
            "#d3c7aa"
        )
        if __t(o.hit) then
            c.globalAlpha = c.globalAlpha * 0.5
            __L1:oval(
                c,
                0,
                -10,
                22,
                13,
                "#f5dfbd",
                2
            )
        end
        c:restore()
    end
    __L1.strangeMinion = function(self, c, x, y, t, kind, o)
        if t == nil then
            t = 0
        end
        if kind == nil then
            kind = "spindle"
        end
        if o == nil then
            o = {}
        end
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        c:scale(
            __lt(o.facing, 0) and -1 or 1,
            1
        )
        local bob = math.floor(math.sin(t * 6) * 3 + 0.5)
        __L1:oval(
            c,
            0,
            -1,
            24,
            4,
            "#37413b",
            2
        )
        c:translate(0, -bob)
        if kind == "spindle" then
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({-20, -42}, 2),
                        __arrL({0, -57}, 2),
                        __arrL({22, -42}, 2),
                        __arrL({12, -23}, 2),
                        __arrL({0, -10}, 2),
                        __arrL({-13, -24}, 2)
                    },
                    6
                ),
                "#333346"
            )
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({-16, -41}, 2),
                        __arrL({0, -52}, 2),
                        __arrL({17, -41}, 2),
                        __arrL({8, -25}, 2),
                        __arrL({0, -15}, 2),
                        __arrL({-9, -26}, 2)
                    },
                    6
                ),
                "#aa81b2"
            )
            __L1:r(
                c,
                -18,
                -40,
                37,
                5,
                "#e4b9c7"
            )
            __L1:r(
                c,
                -11,
                -31,
                23,
                3,
                "#e8d2b1"
            )
            __L1:r(
                c,
                -3,
                -56,
                6,
                8,
                "#739da4"
            )
            __L1:oval(
                c,
                0,
                -39,
                8,
                10,
                "#d7edc9",
                2
            )
            __L1:r(
                c,
                1,
                -41,
                3,
                6,
                "#42394b"
            )
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL({-13, -27}, 2),
                        __arrL({-31, -20}, 2),
                        __arrL({-27, -13}, 2)
                    },
                    3
                ),
                4,
                "#bca1c2"
            )
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL({13, -27}, 2),
                        __arrL({31, -34}, 2),
                        __arrL({34, -23}, 2)
                    },
                    3
                ),
                4,
                "#bca1c2"
            )
            do
                local i = 0
                while i < 3 do
                    __L1:r(
                        c,
                        -32 + i * 23,
                        -5 + __mod(i, 2) * 2,
                        15,
                        3,
                        "#a5c0bb"
                    )
                    i = i + 1
                end
            end
            if math.sin(t * 13) > 0 then
                __L1:r(
                    c,
                    -30,
                    -44,
                    8,
                    2,
                    "#d7bdcf"
                )
                __L1:r(
                    c,
                    24,
                    -23,
                    10,
                    2,
                    "#d7bdcf"
                )
            end
        elseif kind == "wobbler" then
            local sway = math.sin(t * 5) * 3
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({-21, -40}, 2),
                        __arrL({-13, -55}, 2),
                        __arrL({8, -55}, 2),
                        __arrL({22, -43}, 2),
                        __arrL({20, -13}, 2),
                        __arrL({3, -7}, 2),
                        __arrL({-18, -14}, 2)
                    },
                    7
                ),
                "#36443e"
            )
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({-18, -39}, 2),
                        __arrL({-10, -51}, 2),
                        __arrL({8, -51}, 2),
                        __arrL({18, -42}, 2),
                        __arrL({16, -15}, 2),
                        __arrL({2, -11}, 2),
                        __arrL({-15, -17}, 2)
                    },
                    7
                ),
                "#8ac29a"
            )
            __L1:r(
                c,
                -10,
                -48,
                17,
                3,
                "#c3e0ac"
            )
            do
                local i = 0
                while i < 3 do
                    __L1:oval(
                        c,
                        -11 + i * 10,
                        -34 - __mod(i, 2) * 8,
                        5,
                        7,
                        "#eef0c6",
                        2
                    )
                    __L1:r(
                        c,
                        -10 + i * 10,
                        -34 - __mod(i, 2) * 8,
                        2,
                        4,
                        "#3c4640"
                    )
                    i = i + 1
                end
            end
            __L1:r(
                c,
                -7,
                -22,
                17,
                5,
                "#466052"
            )
            __L1:r(
                c,
                0,
                -18,
                7,
                6,
                "#cb9e9a"
            )
            for ____, side in __iterar((__arrL({-1, 1}, 2))) do
                __L1:limb(
                    c,
                    __arrL(
                        {
                            __arrL({side * 15, -30}, 2),
                            __arrL({side * 29 + sway, -28}, 2),
                            __arrL({side * 31, -18}, 2)
                        },
                        3
                    ),
                    4,
                    "#9fc5a7"
                )
                __L1:r(
                    c,
                    side > 0 and 8 or -18,
                    -8,
                    13,
                    9,
                    "#627d74"
                )
                __L1:r(
                    c,
                    side > 0 and 11 or -17,
                    -2,
                    13,
                    4,
                    "#d8d6b2"
                )
            end
        else
            __L1:oval(
                c,
                0,
                -23,
                26,
                13,
                "#3d3b44",
                2
            )
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({-25, -24}, 2),
                        __arrL({25, -24}, 2),
                        __arrL({18, -8}, 2),
                        __arrL({8, -3}, 2),
                        __arrL({-9, -3}, 2),
                        __arrL({-19, -8}, 2)
                    },
                    6
                ),
                "#a66955"
            )
            __L1:oval(
                c,
                0,
                -25,
                24,
                8,
                "#d8bd84",
                2
            )
            do
                local i = 0
                while i < 10 do
                    local xx = -20 + i * 4
                    local yy = -29 - math.sin(t * 2 + i) * 2
                    __L1:limb(
                        c,
                        __arrL(
                            {
                                __arrL({xx, yy}, 2),
                                __arrL(
                                    {
                                        xx - 3,
                                        -39 - __mod(i, 3) * 3
                                    },
                                    2
                                ),
                                __arrL(
                                    {
                                        xx + 4,
                                        -45 + __mod(i, 3)
                                    },
                                    2
                                ),
                                __arrL({xx + 7, -35}, 2)
                            },
                            4
                        ),
                        3,
                        __t(__mod(i, 2)) and "#e3c780" or "#f4dfa1"
                    )
                    i = i + 1
                end
            end
            __L1:r(
                c,
                -12,
                -29,
                6,
                8,
                "#f5edd4"
            )
            __L1:r(
                c,
                6,
                -29,
                6,
                8,
                "#f5edd4"
            )
            __L1:r(
                c,
                -9,
                -27,
                2,
                4,
                "#493e3a"
            )
            __L1:r(
                c,
                8,
                -27,
                2,
                4,
                "#493e3a"
            )
            __L1:r(
                c,
                -6,
                -18,
                15,
                3,
                "#633e37"
            )
            __L1:r(
                c,
                -20,
                -5,
                12,
                7,
                "#3e5364"
            )
            __L1:r(
                c,
                10,
                -5,
                12,
                7,
                "#3e5364"
            )
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL({-20, -20}, 2),
                        __arrL({-33, -30}, 2),
                        __arrL({-31, -42}, 2)
                    },
                    3
                ),
                4,
                "#a0b6ae"
            )
            do
                local i = 0
                while i < 3 do
                    __L1:r(
                        c,
                        -35 + i * 3,
                        -48,
                        2,
                        10,
                        "#d4d7bd"
                    )
                    i = i + 1
                end
            end
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL({20, -19}, 2),
                        __arrL({31, -24}, 2),
                        __arrL({36, -16}, 2)
                    },
                    3
                ),
                4,
                "#a0b6ae"
            )
        end
        if __t(o.hit) then
            c:save()
            c.globalAlpha = c.globalAlpha * 0.45
            __L1:r(
                c,
                -28,
                -58,
                57,
                61,
                "#ffe5cb"
            )
            c:restore()
        end
        c:restore()
    end
    __L1.acai = function(self, c, x, y, t, o)
        if t == nil then
            t = 0
        end
        if o == nil then
            o = {}
        end
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        local ____c_269 = c
        local ____c_scale_270 = c.scale
        local ____t_result_267
        if __t(o.scale) then
            ____t_result_267 = o.scale
        else
            ____t_result_267 = 1
        end
        local ____t_result_268
        if __t(o.scale) then
            ____t_result_268 = o.scale
        else
            ____t_result_268 = 1
        end
        ____c_scale_270(____c_269, ____t_result_267, ____t_result_268)
        __L1:oval(
            c,
            0,
            -1,
            26,
            5,
            "#354c43",
            2
        )
        __L1:poly(
            c,
            __arrL(
                {
                    __arrL({-27, -24}, 2),
                    __arrL({27, -24}, 2),
                    __arrL({21, -5}, 2),
                    __arrL({10, 1}, 2),
                    __arrL({-11, 1}, 2),
                    __arrL({-22, -5}, 2)
                },
                6
            ),
            "#573b42"
        )
        __L1:poly(
            c,
            __arrL(
                {
                    __arrL({-23, -21}, 2),
                    __arrL({23, -21}, 2),
                    __arrL({18, -7}, 2),
                    __arrL({9, -3}, 2),
                    __arrL({-9, -3}, 2),
                    __arrL({-18, -7}, 2)
                },
                6
            ),
            "#b87155"
        )
        __L1:r(
            c,
            -14,
            -13,
            29,
            3,
            "#dbb27a"
        )
        __L1:oval(
            c,
            0,
            -25,
            28,
            10,
            "#e2c6a0",
            2
        )
        __L1:oval(
            c,
            0,
            -26,
            24,
            8,
            "#542c61",
            2
        )
        __L1:oval(
            c,
            -3,
            -29,
            17,
            5,
            "#744071",
            2
        )
        __L1:r(
            c,
            -18,
            -27,
            11,
            2,
            "#976489"
        )
        do
            local i = 0
            while i < 5 do
                local xx = -15 + i * 7
                local yy = -29 + __mod(i, 2) * 4
                __L1:oval(
                    c,
                    xx,
                    yy,
                    5,
                    3,
                    "#eee1a0",
                    1
                )
                __L1:r(
                    c,
                    xx - 1,
                    yy - 1,
                    2,
                    2,
                    "#b79c67"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 12 do
                local xx = (__L1:hash(i + 42) - 0.5) * 39
                local yy = -31 + __L1:hash(i + 61) * 11
                __L1:r(
                    c,
                    xx,
                    yy,
                    2,
                    2,
                    __t(__mod(i, 2)) and "#c99653" or "#efd09a"
                )
                i = i + 1
            end
        end
        __L1:limb(
            c,
            __arrL(
                {
                    __arrL({17, -28}, 2),
                    __arrL({31, -48}, 2)
                },
                2
            ),
            3,
            "#b7c9c0"
        )
        __L1:oval(
            c,
            33,
            -51,
            5,
            7,
            "#d8e2d3",
            2
        )
        __L1:r(
            c,
            32,
            -55,
            2,
            6,
            "#f4efdc"
        )
        c:restore()
    end
    __L1.schoolMonitor = function(self, c, ____type, x, y, o)
        if o == nil then
            o = {}
        end
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        local ____c_275 = c
        local ____c_scale_276 = c.scale
        local ____temp_272 = __lt(o.facing, 0) and -1 or 1
        local ____t_result_271
        if __t(o.scale) then
            ____t_result_271 = o.scale
        else
            ____t_result_271 = 1
        end
        local ____temp_274 = ____temp_272 * ____t_result_271
        local ____t_result_273
        if __t(o.scale) then
            ____t_result_273 = o.scale
        else
            ____t_result_273 = 1
        end
        ____c_scale_276(____c_275, ____temp_274, ____t_result_273)
        local ____t_result_279
        local ____t_278 = __t
        local ____TS__Number_result_277 = __TS__Number(o.frame)
        __O[191] = ____TS__Number_result_277
        if ____t_278(____TS__Number_result_277) then
            ____t_result_279 = __O[191]
        else
            ____t_result_279 = 0
        end
        local t = ____t_result_279
        local moving = not not __t(o.moving)
        local ____t_result_280
        if __t(moving) then
            ____t_result_280 = math.sin(t * 7) * 4
        else
            ____t_result_280 = 0
        end
        local walk = ____t_result_280
        local skin = ____type == "igor" and "#e7a079" or "#f0cbb4"
        local ink = "#34404b"
        __L1:oval(
            c,
            0,
            1,
            ____type == "igor" and 27 or 19,
            4,
            "#243b3c55",
            3
        )
        local ____t_284 = __t
        local ____t_result_283
        local ____t_282 = __t
        local ____temp_281 = ____type == "igor"
        __O[192] = ____temp_281
        if ____t_282(____temp_281) then
            ____t_result_283 = o.bellyRolling
        else
            ____t_result_283 = __O[192]
        end
        if ____t_284(____t_result_283) then
            c:translate(0, -36)
            local ____c_286 = c
            local ____c_rotate_287 = c.rotate
            local ____t_result_285
            if __t(o.rollAngle) then
                ____t_result_285 = o.rollAngle
            else
                ____t_result_285 = 0
            end
            ____c_rotate_287(____c_286, ____t_result_285)
            __L1:oval(
                c,
                0,
                0,
                35,
                36,
                ink,
                3
            )
            __L1:oval(
                c,
                0,
                1,
                32,
                33,
                __t(o.monitorBattle) and "#277ab8" or "#e3a47b",
                3
            )
            __L1:oval(
                c,
                3,
                4,
                24,
                24,
                __t(o.monitorBattle) and "#3a96ce" or "#efb38c",
                3
            )
            __L1:r(
                c,
                -3,
                -3,
                6,
                5,
                __t(o.monitorBattle) and "#1c5a91" or "#bb785b"
            )
            __L1:r(
                c,
                -13,
                -17,
                7,
                3,
                "#f4c9a0"
            )
            __L1:r(
                c,
                6,
                -17,
                7,
                3,
                "#f4c9a0"
            )
            __L1:r(
                c,
                -13,
                -14,
                3,
                4,
                ink
            )
            __L1:r(
                c,
                9,
                -14,
                3,
                4,
                ink
            )
            __L1:r(
                c,
                -9,
                14,
                18,
                4,
                "#765043"
            )
            __L1:r(
                c,
                -7,
                17,
                14,
                4,
                "#5d4237"
            )
            __L1:r(
                c,
                -36,
                -6,
                7,
                18,
                "#4f7391"
            )
            __L1:r(
                c,
                28,
                -6,
                7,
                18,
                "#4f7391"
            )
            c:restore()
            return
        end
        if ____type == "igor" then
            local IP = o.igorPose
            local ____o_igorPoseK_288 = o.igorPoseK
            if ____o_igorPoseK_288 == nil then
                ____o_igorPoseK_288 = 1
            end
            local ik = math.max(
                0,
                math.min(
                    1,
                    __TS__Number(____o_igorPoseK_288)
                )
            )
            if IP == "rise" then
                __L1:r(
                    c,
                    -17,
                    -29,
                    14,
                    16,
                    "#233a58"
                )
                __L1:r(
                    c,
                    4,
                    -29,
                    14,
                    16,
                    "#233a58"
                )
                __L1:r(
                    c,
                    -20,
                    -15,
                    19,
                    8,
                    "#edf0dd"
                )
                __L1:r(
                    c,
                    2,
                    -15,
                    19,
                    8,
                    "#edf0dd"
                )
            elseif IP == "crouch" then
                local sp = math.floor(ik * 5 + 0.5)
                __L1:r(
                    c,
                    -20 - sp,
                    -23,
                    14,
                    21,
                    "#233a58"
                )
                __L1:r(
                    c,
                    7 + sp,
                    -23,
                    14,
                    21,
                    "#233a58"
                )
                __L1:r(
                    c,
                    -23 - sp,
                    -8,
                    20,
                    8,
                    "#edf0dd"
                )
                __L1:r(
                    c,
                    5 + sp,
                    -8,
                    20,
                    8,
                    "#edf0dd"
                )
            else
                __L1:r(
                    c,
                    -18 + walk,
                    -23,
                    14,
                    21,
                    "#233a58"
                )
                __L1:r(
                    c,
                    5 - walk,
                    -23,
                    14,
                    21,
                    "#233a58"
                )
                __L1:r(
                    c,
                    -21 + walk,
                    -8,
                    20,
                    8,
                    "#edf0dd"
                )
                __L1:r(
                    c,
                    3 - walk,
                    -8,
                    20,
                    8,
                    "#edf0dd"
                )
            end
            __L1:oval(
                c,
                0,
                -40,
                31,
                32,
                ink,
                3
            )
            __L1:oval(
                c,
                0,
                -41,
                28,
                29,
                __t(o.monitorBattle) and "#226ca8" or "#7c8075",
                3
            )
            __L1:oval(
                c,
                5,
                -38,
                25,
                23,
                __t(o.monitorBattle) and "#318ac3" or skin,
                3
            )
            __L1:oval(
                c,
                8,
                -39,
                19,
                18,
                __t(o.monitorBattle) and "#45a0d2" or "#efb28b",
                3
            )
            __L1:r(
                c,
                6,
                -39,
                5,
                4,
                __t(o.monitorBattle) and "#246caa" or "#bc7b5d"
            )
            if __t(o.monitorBattle) then
                __L1:r(
                    c,
                    -17,
                    -25,
                    37,
                    4,
                    "#1d568c"
                )
                __L1:r(
                    c,
                    -2,
                    -50,
                    19,
                    3,
                    "#77c1e4"
                )
                __L1:r(
                    c,
                    11,
                    -29,
                    10,
                    3,
                    "#266da7"
                )
                __L1:r(
                    c,
                    -27,
                    -62,
                    12,
                    12,
                    "#2b7bb6"
                )
                __L1:r(
                    c,
                    19,
                    -62,
                    12,
                    12,
                    "#2b7bb6"
                )
            end
            __L1:r(
                c,
                -15,
                -61,
                10,
                17,
                "#d3d9cb"
            )
            __L1:r(
                c,
                -13,
                -58,
                6,
                11,
                "#e4c87c"
            )
            local AL = __arrL(
                {
                    __arrL({-25, -57}, 2),
                    __arrL({-33, -38 + walk}, 2),
                    __arrL({-29, -28 + walk}, 2)
                },
                3
            )
            local AR = __arrL(
                {
                    __arrL({25, -58}, 2),
                    __arrL({34, -39 - walk}, 2),
                    __arrL({29, -26 - walk}, 2)
                },
                3
            )
            if IP == "crouch" then
                AL = __arrL(
                    {
                        __arrL({-25, -57}, 2),
                        __arrL({-38, -46 + ik * 4}, 2),
                        __arrL({-46, -34 + ik * 8}, 2)
                    },
                    3
                )
                AR = __arrL(
                    {
                        __arrL({25, -58}, 2),
                        __arrL({16, -44 + ik * 2}, 2),
                        __arrL({4, -32 + ik * 6}, 2)
                    },
                    3
                )
            elseif IP == "rise" then
                AL = __arrL(
                    {
                        __arrL({-25, -57}, 2),
                        __arrL({-33, -77}, 2),
                        __arrL({-27, -97}, 2)
                    },
                    3
                )
                AR = __arrL(
                    {
                        __arrL({25, -58}, 2),
                        __arrL({33, -79}, 2),
                        __arrL({27, -99}, 2)
                    },
                    3
                )
            elseif IP == "fall" then
                AL = __arrL(
                    {
                        __arrL({-25, -57}, 2),
                        __arrL({-46, -63}, 2),
                        __arrL({-61, -58}, 2)
                    },
                    3
                )
                AR = __arrL(
                    {
                        __arrL({25, -58}, 2),
                        __arrL({46, -64}, 2),
                        __arrL({61, -59}, 2)
                    },
                    3
                )
            elseif IP == "land" then
                AL = __arrL(
                    {
                        __arrL({-25, -57}, 2),
                        __arrL({-44, -46}, 2),
                        __arrL({-54, -36}, 2)
                    },
                    3
                )
                AR = __arrL(
                    {
                        __arrL({25, -58}, 2),
                        __arrL({44, -47}, 2),
                        __arrL({54, -37}, 2)
                    },
                    3
                )
            end
            __L1:limb(c, AL, 9, ink)
            __L1:limb(c, AL, 6, skin)
            __L1:limb(c, AR, 9, ink)
            __L1:limb(c, AR, 6, skin)
            if __t(IP) then
                __L1:r(
                    c,
                    __get(
                        __get(AL, 2),
                        0
                    ) - 4,
                    __get(
                        __get(AL, 2),
                        1
                    ) - 4,
                    8,
                    8,
                    ink
                )
                __L1:r(
                    c,
                    __get(
                        __get(AL, 2),
                        0
                    ) - 3,
                    __get(
                        __get(AL, 2),
                        1
                    ) - 3,
                    6,
                    6,
                    skin
                )
                __L1:r(
                    c,
                    __get(
                        __get(AR, 2),
                        0
                    ) - 4,
                    __get(
                        __get(AR, 2),
                        1
                    ) - 4,
                    8,
                    8,
                    ink
                )
                __L1:r(
                    c,
                    __get(
                        __get(AR, 2),
                        0
                    ) - 3,
                    __get(
                        __get(AR, 2),
                        1
                    ) - 3,
                    6,
                    6,
                    skin
                )
            end
            __L1:oval(
                c,
                -1,
                -74,
                19,
                16,
                ink,
                3
            )
            __L1:oval(
                c,
                -1,
                -75,
                17,
                14,
                skin,
                3
            )
            __L1:r(
                c,
                -9,
                -88,
                12,
                3,
                "#ffd5ac"
            )
            __L1:r(
                c,
                -12,
                -77,
                7,
                2,
                "#72503e"
            )
            __L1:r(
                c,
                4,
                -77,
                7,
                2,
                "#72503e"
            )
            __L1:r(
                c,
                -10,
                -74,
                3,
                4,
                "#30353b"
            )
            __L1:r(
                c,
                5,
                -74,
                3,
                4,
                "#30353b"
            )
            __L1:r(
                c,
                -4,
                -70,
                7,
                4,
                "#c18462"
            )
            __L1:r(
                c,
                -10,
                -64,
                19,
                5,
                "#654c3e"
            )
            __L1:r(
                c,
                -6,
                -60,
                12,
                4,
                "#654c3e"
            )
            __L1:r(
                c,
                -5,
                -65,
                10,
                2,
                "#f3c4a4"
            )
        else
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL({-6, -39}, 2),
                        __arrL({-10 + walk, -20}, 2),
                        __arrL({-10 + walk, -5}, 2)
                    },
                    3
                ),
                8,
                ink
            )
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL({-6, -39}, 2),
                        __arrL({-10 + walk, -20}, 2),
                        __arrL({-10 + walk, -5}, 2)
                    },
                    3
                ),
                5,
                "#233b59"
            )
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL({6, -39}, 2),
                        __arrL({10 - walk, -19}, 2),
                        __arrL({10 - walk, -5}, 2)
                    },
                    3
                ),
                8,
                ink
            )
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL({6, -39}, 2),
                        __arrL({10 - walk, -19}, 2),
                        __arrL({10 - walk, -5}, 2)
                    },
                    3
                ),
                5,
                "#233b59"
            )
            __L1:r(
                c,
                -14 + walk,
                -6,
                14,
                6,
                "#dbe6df"
            )
            __L1:r(
                c,
                4 - walk,
                -6,
                14,
                6,
                "#dbe6df"
            )
            __L1:r(
                c,
                -12,
                -79,
                25,
                43,
                ink
            )
            __L1:r(
                c,
                -10,
                -77,
                21,
                39,
                "#edf0dd"
            )
            __L1:r(
                c,
                -10,
                -77,
                21,
                10,
                "#396b92"
            )
            __L1:r(
                c,
                -5,
                -67,
                3,
                25,
                "#2b5f86"
            )
            __L1:r(
                c,
                3,
                -65,
                7,
                9,
                "#d8ba6b"
            )
            __L1:r(
                c,
                -4,
                -85,
                8,
                10,
                skin
            )
            __L1:oval(
                c,
                0,
                -94,
                13,
                15,
                ink,
                2
            )
            __L1:oval(
                c,
                0,
                -94,
                11,
                13,
                skin,
                2
            )
            __L1:r(
                c,
                -12,
                -109,
                24,
                10,
                "#232930"
            )
            __L1:r(
                c,
                -12,
                -101,
                4,
                10,
                "#232930"
            )
            __L1:r(
                c,
                -8,
                -95,
                5,
                2,
                ink
            )
            __L1:r(
                c,
                4,
                -95,
                5,
                2,
                ink
            )
            __L1:r(
                c,
                -7,
                -92,
                3,
                3,
                __t(o.rage) and "#ec6668" or "#25313b"
            )
            __L1:r(
                c,
                5,
                -92,
                3,
                3,
                __t(o.rage) and "#ec6668" or "#25313b"
            )
            __L1:r(
                c,
                -7,
                -84,
                16,
                6,
                "#282d32"
            )
            __L1:r(
                c,
                -4,
                -84,
                9,
                2,
                "#e6bba2"
            )
            local aiming = o.monitorBattle
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL({-12, -72}, 2),
                        __arrL({-17, -57}, 2),
                        __arrL(
                            {
                                __t(aiming) and 18 or -13,
                                -50
                            },
                            2
                        )
                    },
                    3
                ),
                6,
                ink
            )
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL({-12, -72}, 2),
                        __arrL({-17, -57}, 2),
                        __arrL(
                            {
                                __t(aiming) and 18 or -13,
                                -50
                            },
                            2
                        )
                    },
                    3
                ),
                4,
                skin
            )
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL({12, -72}, 2),
                        __arrL({19, -57}, 2),
                        __arrL(
                            {
                                __t(aiming) and 33 or 19,
                                -50
                            },
                            2
                        )
                    },
                    3
                ),
                6,
                ink
            )
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL({12, -72}, 2),
                        __arrL({19, -57}, 2),
                        __arrL(
                            {
                                __t(aiming) and 33 or 19,
                                -50
                            },
                            2
                        )
                    },
                    3
                ),
                4,
                skin
            )
            if __t(aiming) then
                __L1:r(
                    c,
                    10,
                    -56,
                    38,
                    11,
                    "#34454a"
                )
                __L1:r(
                    c,
                    22,
                    -59,
                    21,
                    4,
                    "#4f6467"
                )
                __L1:r(
                    c,
                    35,
                    -54,
                    22,
                    5,
                    "#223338"
                )
                __L1:r(
                    c,
                    19,
                    -45,
                    9,
                    15,
                    "#34454a"
                )
                __L1:r(
                    c,
                    24,
                    -43,
                    9,
                    11,
                    "#667675"
                )
                __L1:r(
                    c,
                    7,
                    -53,
                    9,
                    5,
                    "#a58c66"
                )
                local ____t_290 = __t
                local ____t_result_289
                if __t(o.firing) then
                    ____t_result_289 = math.sin(t * 35) > 0.1
                else
                    ____t_result_289 = o.firing
                end
                if ____t_290(____t_result_289) then
                    __L1:poly(
                        c,
                        __arrL(
                            {
                                __arrL({57, -55}, 2),
                                __arrL({69, -60}, 2),
                                __arrL({65, -52}, 2),
                                __arrL({74, -49}, 2),
                                __arrL({62, -48}, 2)
                            },
                            5
                        ),
                        "#ffd888"
                    )
                end
            end
        end
        if __t(o.rage) then
            __L1:r(
                c,
                -10,
                ____type == "igor" and -74 or -93,
                4,
                3,
                "#f45c68"
            )
            __L1:r(
                c,
                5,
                ____type == "igor" and -74 or -93,
                4,
                3,
                "#f45c68"
            )
        end
        if __t(o.hit) then
            c.globalAlpha = c.globalAlpha * 0.45
            __L1:r(
                c,
                -32,
                ____type == "igor" and -90 or -112,
                66,
                ____type == "igor" and 90 or 112,
                "#fff3d5"
            )
        end
        c:restore()
    end
    __L1.nikolasPowerAura = function(self, c, t, phase, amount)
        if amount == nil then
            amount = 1
        end
        c:save()
        local p = math.max(
            0,
            math.min(1, amount)
        )
        if phase == 2 then
            __L1:energyAura(
                c,
                0,
                5,
                t,
                {scale = 1.85, intensity = 0.6 + p * 0.4, charging = p < 1, powered = true}
            )
        elseif phase == 3 then
            c.globalAlpha = c.globalAlpha * (0.16 + p * 0.15)
            local pulse = math.floor(math.sin(t * 7) * 3 + 0.5)
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({-25, 14}, 2),
                        __arrL({-62, 5}, 2),
                        __arrL({-62, -17}, 2),
                        __arrL({-89, -17}, 2),
                        __arrL({-89, -44}, 2),
                        __arrL({-111, -44}, 2),
                        __arrL({-111, -74}, 2),
                        __arrL({-126, -74}, 2),
                        __arrL({-126, -106}, 2),
                        __arrL({-112, -106}, 2),
                        __arrL({-112, -143}, 2),
                        __arrL({-85, -143}, 2),
                        __arrL({-85, -181}, 2),
                        __arrL({-52, -181}, 2),
                        __arrL({-52, -213}, 2),
                        __arrL({-23, -213}, 2),
                        __arrL({-23, -240 - pulse}, 2),
                        __arrL({2, -258 - pulse}, 2),
                        __arrL({25, -237}, 2),
                        __arrL({25, -211}, 2),
                        __arrL({56, -211}, 2),
                        __arrL({56, -178}, 2),
                        __arrL({89, -178}, 2),
                        __arrL({89, -140}, 2),
                        __arrL({113, -140}, 2),
                        __arrL({113, -106}, 2),
                        __arrL({125, -106}, 2),
                        __arrL({125, -71}, 2),
                        __arrL({107, -71}, 2),
                        __arrL({107, -40}, 2),
                        __arrL({84, -40}, 2),
                        __arrL({84, -15}, 2),
                        __arrL({57, -15}, 2),
                        __arrL({57, 6}, 2),
                        __arrL({23, 16}, 2)
                    },
                    35
                ),
                "#8c6add"
            )
            c.globalAlpha = c.globalAlpha / 1.4
            __L1:oval(
                c,
                0,
                -106,
                93,
                136,
                "#f8d779",
                5
            )
            c.globalAlpha = c.globalAlpha * 1.8
            for ____, side in __iterar((__arrL({-1, 1}, 2))) do
                local xx = side * (104 + math.floor(math.sin(t * 9 + side) * 5 + 0.5))
                __L1:limb(
                    c,
                    __arrL(
                        {
                            __arrL({xx, 0}, 2),
                            __arrL({xx - side * 13, -31}, 2),
                            __arrL({xx + side * 7, -61}, 2),
                            __arrL({xx - side * 9, -93}, 2),
                            __arrL({xx + side * 6, -129}, 2),
                            __arrL({xx - side * 15, -159}, 2),
                            __arrL({side * 64, -196}, 2),
                            __arrL({side * 49, -220}, 2)
                        },
                        8
                    ),
                    3,
                    "#e4d0ff"
                )
                __L1:limb(
                    c,
                    __arrL(
                        {
                            __arrL({xx, 0}, 2),
                            __arrL({xx - side * 13, -31}, 2),
                            __arrL({xx + side * 7, -61}, 2),
                            __arrL({xx - side * 9, -93}, 2),
                            __arrL({xx + side * 6, -129}, 2),
                            __arrL({xx - side * 15, -159}, 2),
                            __arrL({side * 64, -196}, 2)
                        },
                        7
                    ),
                    1,
                    "#fff1ba"
                )
            end
            c.globalAlpha = 1
            __L1:energyAura(
                c,
                0,
                7,
                t,
                {scale = 2.15, intensity = 0.76, charging = false, powered = true}
            )
            do
                local i = 0
                while i < 13 do
                    local xx = math.floor(math.sin(i * 2.1 + t * 0.6) * 106 + 0.5)
                    local yy = 20 - __mod(t * 65 + i * 23, 270)
                    __L1:r(
                        c,
                        xx,
                        yy,
                        3,
                        7,
                        __t(__mod(i, 3)) and "#d5b8ff" or "#fff1b7"
                    )
                    i = i + 1
                end
            end
        else
            c.globalAlpha = c.globalAlpha * (0.11 + p * 0.1)
            __L1:oval(
                c,
                0,
                -165,
                204,
                186,
                "#c55970",
                6
            )
            c.globalAlpha = c.globalAlpha * 1.6
            do
                local i = 0
                while i < 12 do
                    local xx = -194 + i * 35
                    local yy = -25 - __mod(t * 37 + i * 29, 321)
                    __L1:r(
                        c,
                        xx,
                        yy,
                        4,
                        12,
                        __t(__mod(i, 2)) and "#dc9fb8" or "#d7b8ef"
                    )
                    i = i + 1
                end
            end
            for ____, side in __iterar((__arrL({-1, 1}, 2))) do
                __L1:limb(
                    c,
                    __arrL(
                        {
                            __arrL({side * 161, -18}, 2),
                            __arrL({side * 188, -65}, 2),
                            __arrL({side * 171, -116}, 2),
                            __arrL({side * 199, -161}, 2),
                            __arrL({side * 179, -210}, 2),
                            __arrL({side * 158, -259}, 2),
                            __arrL({side * 121, -304}, 2)
                        },
                        7
                    ),
                    4,
                    "#d68ba7"
                )
            end
        end
        c:restore()
    end
    __L1.nikolasForm = function(self, c, x, y, o)
        if o == nil then
            o = {}
        end
        local ____t_result_293
        local ____t_292 = __t
        local ____TS__Number_result_291 = __TS__Number(o.bossPhase)
        __O[194] = ____TS__Number_result_291
        if ____t_292(____TS__Number_result_291) then
            ____t_result_293 = __O[194]
        else
            ____t_result_293 = 2
        end
        local phase = math.max(
            2,
            math.min(
                4,
                math.floor(____t_result_293)
            )
        )
        local ____t_result_296
        local ____t_295 = __t
        local ____TS__Number_result_294 = __TS__Number(o.frame)
        __O[195] = ____TS__Number_result_294
        if ____t_295(____TS__Number_result_294) then
            ____t_result_296 = __O[195]
        else
            ____t_result_296 = 0
        end
        local t = ____t_result_296
        local changing = not not __t(o.phaseChanging) or o.state == "phaseChange"
        local ____t_result_300
        if __t(changing) then
            local ____t_result_299
            local ____t_298 = __t
            local ____TS__Number_result_297 = __TS__Number(o.transformProgress)
            __O[196] = ____TS__Number_result_297
            if ____t_298(____TS__Number_result_297) then
                ____t_result_299 = __O[196]
            else
                ____t_result_299 = 0
            end
            ____t_result_300 = math.max(
                0,
                math.min(1, ____t_result_299)
            )
        else
            ____t_result_300 = 1
        end
        local p = ____t_result_300
        local function ease(____, v)
            return v * v * (3 - 2 * v)
        end
        local face = __lt(o.facing, 0) and -1 or 1
        c:save()
        c.imageSmoothingEnabled = false
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        if __isFiniteN(o.opacity) then
            c.globalAlpha = c.globalAlpha * math.max(
                0,
                math.min(1, o.opacity)
            )
        end
        local ____L1_nikolasPowerAura_303 = __L1.nikolasPowerAura
        local ____c_302 = c
        local ____temp_301
        if phase == 3 then
            ____temp_301 = math.max(0.1, p)
        else
            ____temp_301 = p
        end
        ____L1_nikolasPowerAura_303(
            __L1,
            ____c_302,
            t,
            phase,
            ____temp_301
        )
        local ____t_309 = __t
        local ____t_result_308
        local ____t_307 = __t
        local ____t_result_306
        local ____t_305 = __t
        local ____temp_304 = phase == 2
        __O[197] = ____temp_304
        if ____t_305(____temp_304) then
            ____t_result_306 = changing
        else
            ____t_result_306 = __O[197]
        end
        __O[198] = ____t_result_306
        if ____t_307(____t_result_306) then
            ____t_result_308 = p < 0.34
        else
            ____t_result_308 = __O[198]
        end
        if ____t_309(____t_result_308) then
            __L1:character(
                c,
                "nikolas",
                0,
                0,
                __assign(
                    {},
                    o,
                    {
                        bossPhase = 1,
                        scale = 1 + ease(nil, p / 0.34) * 0.16,
                        charging = true,
                        frame = t,
                        noseRub = false
                    }
                )
            )
            c:restore()
            return
        end
        local ____temp_311
        if phase == 4 then
            local ____t_result_310
            if __t(changing) then
                ____t_result_310 = 1.36 + (3.3 - 1.36) * ease(nil, p)
            else
                ____t_result_310 = 3.3
            end
            ____temp_311 = ____t_result_310
        else
            ____temp_311 = 1.36
        end
        local scale = ____temp_311
        local ____t_315 = __t
        local ____t_result_314
        local ____t_313 = __t
        local ____temp_312 = phase == 2
        __O[199] = ____temp_312
        if ____t_313(____temp_312) then
            ____t_result_314 = changing
        else
            ____t_result_314 = __O[199]
        end
        if ____t_315(____t_result_314) then
            scale = scale * (0.78 + 0.22 * ease(
                nil,
                math.max(0, (p - 0.34) / 0.66)
            ))
        end
        c:scale(face * scale, scale)
        local skin = "#e1b28a"
        local light = "#f6d1a3"
        local shade = "#a86c4e"
        local ink = "#352e34"
        local purple = phase == 4 and "#805579" or "#8c6594"
        local clothLight = "#b38bb7"
        local pants = "#423e59"
        local breath = math.floor(math.sin(t * 2.5) * 0.7 + 0.5)
        local ____t_result_318
        local ____t_317 = __t
        local ____temp_316 = not not __t(o.attack) or o.state == "windup"
        __O[200] = ____temp_316
        if ____t_317(____temp_316) then
            ____t_result_318 = __O[200]
        else
            ____t_result_318 = o.state == "firing"
        end
        local attack = ____t_result_318
        local ____t_result_319
        if __t(changing) then
            ____t_result_319 = changing
        else
            ____t_result_319 = o.charging
        end
        local charge = ____t_result_319
        c:translate(0, breath)
        __L1:r(
            c,
            -25,
            -27,
            22,
            25,
            ink
        )
        __L1:r(
            c,
            4,
            -27,
            22,
            25,
            ink
        )
        __L1:r(
            c,
            -22,
            -25,
            16,
            22,
            pants
        )
        __L1:r(
            c,
            7,
            -25,
            16,
            22,
            pants
        )
        __L1:r(
            c,
            -20,
            -23,
            4,
            16,
            "#655771"
        )
        __L1:r(
            c,
            8,
            -22,
            4,
            16,
            "#6b5a77"
        )
        __L1:r(
            c,
            -29,
            -6,
            26,
            6,
            ink
        )
        __L1:r(
            c,
            3,
            -6,
            27,
            6,
            ink
        )
        __L1:r(
            c,
            -28,
            -6,
            24,
            3,
            "#c3b8c3"
        )
        __L1:r(
            c,
            5,
            -6,
            24,
            3,
            "#c3b8c3"
        )
        __L1:r(
            c,
            -26,
            -2,
            22,
            2,
            "#e8d8d0"
        )
        __L1:r(
            c,
            6,
            -2,
            22,
            2,
            "#e8d8d0"
        )
        local backElbow = __arrL({-47, -49}, 2)
        local backHand = __arrL({-47, -29}, 2)
        local frontElbow = __arrL({49, -49}, 2)
        local frontHand = __arrL({45, -28}, 2)
        local noseX = o.view == "front" and 5 or 23
        local ____t_result_322
        local ____t_321 = __t
        local ____temp_320 = o.noseRub ~= false and not __t(attack)
        __O[201] = ____temp_320
        if ____t_321(____temp_320) then
            ____t_result_322 = not __t(charge)
        else
            ____t_result_322 = __O[201]
        end
        local rubbing = ____t_result_322
        if __t(charge) then
            backElbow = __arrL({-48, -59}, 2)
            backHand = __arrL({-38, -38}, 2)
            frontElbow = __arrL({49, -58}, 2)
            frontHand = __arrL({39, -38}, 2)
        elseif __t(rubbing) then
            frontElbow = __arrL({48, -62}, 2)
            frontHand = __arrL(
                {
                    noseX + 10,
                    -81 + math.floor(math.sin(t * 13) * 2 + 0.5)
                },
                2
            )
        elseif __t(attack) then
            local strike = math.max(
                0,
                math.sin(t * 8)
            )
            frontElbow = __arrL({46 + strike * 5, -57}, 2)
            frontHand = __arrL({61 + strike * 3, -49}, 2)
            backElbow = __arrL({-46, -53}, 2)
            backHand = __arrL({-54, -36}, 2)
        end
        local function powerArm(self, front)
            local ____t_result_323
            if __t(front) then
                ____t_result_323 = frontElbow
            else
                ____t_result_323 = backElbow
            end
            local elbow = ____t_result_323
            local ____t_result_324
            if __t(front) then
                ____t_result_324 = frontHand
            else
                ____t_result_324 = backHand
            end
            local hand = ____t_result_324
            local shoulder = __arrL(
                {
                    __t(front) and 31 or -31,
                    -67
                },
                2
            )
            __L1:limb(
                c,
                __arrL({shoulder, elbow, hand}, 3),
                18,
                ink
            )
            __L1:limb(
                c,
                __arrL({shoulder, elbow}, 2),
                14,
                skin
            )
            __L1:limb(
                c,
                __arrL({elbow, hand}, 2),
                12,
                skin
            )
            __L1:oval(
                c,
                (__get(shoulder, 0) + __get(elbow, 0)) * 0.5,
                (__get(shoulder, 1) + __get(elbow, 1)) * 0.5,
                9,
                11,
                skin,
                2
            )
            __L1:r(
                c,
                __get(elbow, 0) - 5,
                __get(elbow, 1) - 7,
                5,
                3,
                light
            )
            __L1:r(
                c,
                __get(elbow, 0) - 5,
                __get(elbow, 1) + 4,
                9,
                3,
                shade
            )
            __L1:r(
                c,
                __get(hand, 0) - 6,
                __get(hand, 1) - 6,
                13,
                12,
                ink
            )
            __L1:r(
                c,
                __get(hand, 0) - 5,
                __get(hand, 1) - 5,
                11,
                10,
                skin
            )
            __L1:r(
                c,
                __get(hand, 0) - 4,
                __get(hand, 1) - 4,
                8,
                2,
                light
            )
            if phase >= 3 then
                __L1:limb(
                    c,
                    __arrL(
                        {
                            __arrL(
                                {
                                    __get(elbow, 0) - 2,
                                    __get(elbow, 1) - 8
                                },
                                2
                            ),
                            __arrL(
                                {
                                    __get(elbow, 0) + 2,
                                    __get(elbow, 1) - 1
                                },
                                2
                            ),
                            __arrL(
                                {
                                    __get(hand, 0) - 2,
                                    __get(hand, 1) - 2
                                },
                                2
                            )
                        },
                        3
                    ),
                    1,
                    phase == 4 and "#db939c" or "#c2e7cf"
                )
            end
        end
        powerArm(nil, false)
        __L1:poly(
            c,
            __arrL(
                {
                    __arrL({-35, -74}, 2),
                    __arrL({35, -74}, 2),
                    __arrL({35, -66}, 2),
                    __arrL({32, -66}, 2),
                    __arrL({32, -51}, 2),
                    __arrL({27, -51}, 2),
                    __arrL({27, -39}, 2),
                    __arrL({20, -39}, 2),
                    __arrL({20, -22}, 2),
                    __arrL({-20, -22}, 2),
                    __arrL({-20, -39}, 2),
                    __arrL({-27, -39}, 2),
                    __arrL({-27, -51}, 2),
                    __arrL({-32, -51}, 2),
                    __arrL({-32, -66}, 2),
                    __arrL({-35, -66}, 2)
                },
                16
            ),
            ink
        )
        __L1:poly(
            c,
            __arrL(
                {
                    __arrL({-32, -72}, 2),
                    __arrL({32, -72}, 2),
                    __arrL({32, -65}, 2),
                    __arrL({29, -65}, 2),
                    __arrL({29, -50}, 2),
                    __arrL({24, -50}, 2),
                    __arrL({24, -38}, 2),
                    __arrL({17, -38}, 2),
                    __arrL({17, -24}, 2),
                    __arrL({-17, -24}, 2),
                    __arrL({-17, -38}, 2),
                    __arrL({-24, -38}, 2),
                    __arrL({-24, -50}, 2),
                    __arrL({-29, -50}, 2),
                    __arrL({-29, -65}, 2),
                    __arrL({-32, -65}, 2)
                },
                16
            ),
            purple
        )
        __L1:r(
            c,
            -26,
            -69,
            19,
            16,
            skin
        )
        __L1:r(
            c,
            7,
            -69,
            19,
            16,
            skin
        )
        __L1:r(
            c,
            -19,
            -57,
            38,
            8,
            skin
        )
        __L1:r(
            c,
            -17,
            -67,
            8,
            3,
            light
        )
        __L1:r(
            c,
            8,
            -67,
            11,
            3,
            light
        )
        __L1:r(
            c,
            -24,
            -54,
            17,
            3,
            shade
        )
        __L1:r(
            c,
            7,
            -54,
            17,
            3,
            shade
        )
        __L1:r(
            c,
            -11,
            -49,
            23,
            23,
            skin
        )
        __L1:r(
            c,
            -10,
            -47,
            8,
            7,
            "#cf946f"
        )
        __L1:r(
            c,
            3,
            -47,
            8,
            7,
            "#edbc90"
        )
        __L1:r(
            c,
            -9,
            -38,
            8,
            6,
            "#cf946f"
        )
        __L1:r(
            c,
            3,
            -38,
            7,
            6,
            "#edbc90"
        )
        __L1:r(
            c,
            -10,
            -41,
            21,
            2,
            shade
        )
        __L1:r(
            c,
            -8,
            -32,
            18,
            2,
            shade
        )
        __L1:r(
            c,
            -29,
            -72,
            5,
            16,
            clothLight
        )
        __L1:r(
            c,
            25,
            -72,
            5,
            16,
            clothLight
        )
        __L1:r(
            c,
            -18,
            -25,
            36,
            5,
            "#5c425f"
        )
        __L1:r(
            c,
            -7,
            -24,
            15,
            3,
            "#c6a7bc"
        )
        __L1:r(
            c,
            -10,
            -79,
            21,
            10,
            ink
        )
        __L1:r(
            c,
            -8,
            -78,
            17,
            9,
            skin
        )
        __L1:r(
            c,
            -6,
            -73,
            14,
            3,
            shade
        )
        __L1:r(
            c,
            -19,
            -100,
            40,
            30,
            ink
        )
        __L1:r(
            c,
            -17,
            -99,
            36,
            27,
            skin
        )
        __L1:r(
            c,
            -18,
            -92,
            5,
            16,
            shade
        )
        __L1:r(
            c,
            -13,
            -96,
            17,
            3,
            light
        )
        __L1:r(
            c,
            17,
            -88,
            7,
            10,
            skin
        )
        __L1:r(
            c,
            -19,
            -103,
            39,
            10,
            "#353334"
        )
        __L1:r(
            c,
            -10,
            -106,
            31,
            5,
            "#353334"
        )
        __L1:r(
            c,
            13,
            -100,
            11,
            10,
            "#353334"
        )
        __L1:r(
            c,
            -20,
            -96,
            7,
            15,
            "#353334"
        )
        __L1:r(
            c,
            -12,
            -102,
            9,
            2,
            "#5e4c51"
        )
        __L1:r(
            c,
            -11,
            -91,
            12,
            3,
            "#51373b"
        )
        __L1:r(
            c,
            8,
            -92,
            12,
            3,
            "#51373b"
        )
        __L1:r(
            c,
            -5,
            -88,
            6,
            5,
            "#f8e9d0"
        )
        __L1:r(
            c,
            12,
            -89,
            6,
            5,
            "#f8e9d0"
        )
        __L1:r(
            c,
            -2,
            -88,
            3,
            5,
            "#342c2d"
        )
        __L1:r(
            c,
            15,
            -89,
            3,
            5,
            "#342c2d"
        )
        if phase >= 3 then
            __L1:r(
                c,
                -1,
                -88,
                2,
                4,
                phase == 4 and "#f6a395" or "#f5d986"
            )
            __L1:r(
                c,
                16,
                -89,
                2,
                4,
                phase == 4 and "#f6a395" or "#f5d986"
            )
        end
        __L1:oval(
            c,
            noseX,
            -82,
            13,
            10,
            "#704536",
            2
        )
        __L1:oval(
            c,
            noseX,
            -83,
            11,
            8,
            "#edbd94",
            2
        )
        __L1:r(
            c,
            noseX - 5,
            -90,
            10,
            3,
            "#ffdbb3"
        )
        __L1:r(
            c,
            noseX + 4,
            -84,
            3,
            4,
            "#d69c77"
        )
        __L1:r(
            c,
            noseX - 5,
            -77,
            4,
            2,
            "#a56a55"
        )
        __L1:r(
            c,
            noseX + 3,
            -77,
            4,
            2,
            "#a56a55"
        )
        __L1:r(
            c,
            -4,
            -73,
            15,
            3,
            "#684638"
        )
        __L1:r(
            c,
            -2,
            -73,
            11,
            1,
            "#f9dfbd"
        )
        if phase >= 3 then
            __L1:r(
                c,
                noseX + 6,
                -73,
                3,
                6,
                "#a7b85f"
            )
            __L1:r(
                c,
                noseX + 5,
                -67,
                5,
                3,
                "#d0e48b"
            )
        end
        powerArm(nil, true)
        if phase == 3 then
            do
                local i = 0
                while i < 4 do
                    local yy = 4 + i * 9 + math.floor(math.sin(t * 8 + i) * 2 + 0.5)
                    local xx = (__t(__mod(i, 2)) and 1 or -1) * (13 + i * 3)
                    __L1:r(
                        c,
                        xx,
                        yy,
                        4,
                        6,
                        __t(__mod(i, 2)) and "#f7df88" or "#c7afea"
                    )
                    i = i + 1
                end
            end
        end
        local ____t_328 = __t
        local ____t_result_327
        local ____t_326 = __t
        local ____t_result_325
        if __t(changing) then
            ____t_result_325 = p > 0.31
        else
            ____t_result_325 = changing
        end
        __O[202] = ____t_result_325
        if ____t_326(____t_result_325) then
            ____t_result_327 = p < 0.44
        else
            ____t_result_327 = __O[202]
        end
        if ____t_328(____t_result_327) then
            c:save()
            c.globalAlpha = c.globalAlpha * (math.sin((p - 0.31) / 0.13 * math.pi) * 0.78)
            __L1:oval(
                c,
                0,
                -56,
                48,
                58,
                "#fff4c2",
                3
            )
            c:restore()
        end
        if __t(o.hit) then
            c:save()
            c.globalAlpha = c.globalAlpha * 0.38
            __L1:oval(
                c,
                0,
                -56,
                45,
                55,
                "#fff2d2",
                3
            )
            c:restore()
        end
        c:restore()
    end
    __L1.character = function(self, c, ____type, x, y, o)
        if o == nil then
            o = {}
        end
        if __t(____type == "nikolas" and __TS__Number(o.bossPhase) >= 2) then
            __L1:nikolasForm(c, x, y, o)
            return
        end
        if ____type == "amanda" then
            window.AmandaArt:drawCharacter(c, x, y, o)
            return
        end
        local ____t_334 = __t
        local ____t_result_333
        local ____t_330 = __t
        local ____temp_329 = ____type == "ollyan"
        __O[203] = ____temp_329
        if ____t_330(____temp_329) then
            local ____opt_331 = window.BaileWorld
            if ____opt_331 ~= nil then
                ____opt_331 = ____opt_331.drawOllyan
            end
            ____t_result_333 = ____opt_331
        else
            ____t_result_333 = __O[203]
        end
        if ____t_334(____t_result_333) then
            local ____self_339 = window.BaileWorld
            local ____self_339_drawOllyan_340 = ____self_339.drawOllyan
            local ____array_338 = __TS__SparseArrayNew(c, x, y)
            local ____t_result_337
            local ____t_336 = __t
            local ____TS__Number_result_335 = __TS__Number(o.frame)
            __O[204] = ____TS__Number_result_335
            if ____t_336(____TS__Number_result_335) then
                ____t_result_337 = __O[204]
            else
                ____t_result_337 = 0
            end
            __TS__SparseArrayPush(____array_338, ____t_result_337, o)
            ____self_339_drawOllyan_340(
                ____self_339,
                __TS__SparseArraySpread(____array_338)
            )
            return
        end
        if __t(____type == "igor" or ____type == "kaique") then
            __L1:schoolMonitor(
                c,
                ____type,
                x,
                y,
                o
            )
            return
        end
        if __t(__call(
            __arrL({
                "allef",
                "eloisa",
                "giselle",
                "rayssa",
                "analaura"
            }, 5),
            "includes",
            ____type
        )) then
            __L1:socialCharacter(
                c,
                ____type,
                x,
                y,
                o
            )
            return
        end
        if __t(__call(
            __arrL({"dede", "aica", "ravile", "arthur"}, 4),
            "includes",
            ____type
        )) then
            __L1:storyCharacter(
                c,
                ____type,
                x,
                y,
                o
            )
            return
        end
        if __t(__call(
            __arrL({"davi", "vitor", "freddy", "nicolas"}, 4),
            "includes",
            ____type
        )) then
            __L1:newCharacter(
                c,
                ____type,
                x,
                y,
                o
            )
            return
        end
        if ____type == "giant" then
            local ____L1_giant_345 = __L1.giant
            local ____array_344 = __TS__SparseArrayNew(c, x, y)
            local ____t_result_343
            local ____t_342 = __t
            local ____TS__Number_result_341 = __TS__Number(o.frame)
            __O[205] = ____TS__Number_result_341
            if ____t_342(____TS__Number_result_341) then
                ____t_result_343 = __O[205]
            else
                ____t_result_343 = 0
            end
            __TS__SparseArrayPush(____array_344, ____t_result_343, o)
            ____L1_giant_345(
                __L1,
                __TS__SparseArraySpread(____array_344)
            )
            return
        end
        if ____type == "thug" then
            local ____L1_thug_350 = __L1.thug
            local ____array_349 = __TS__SparseArrayNew(c, x, y)
            local ____t_result_348
            local ____t_347 = __t
            local ____TS__Number_result_346 = __TS__Number(o.frame)
            __O[206] = ____TS__Number_result_346
            if ____t_347(____TS__Number_result_346) then
                ____t_result_348 = __O[206]
            else
                ____t_result_348 = 0
            end
            __TS__SparseArrayPush(____array_349, ____t_result_348, o)
            ____L1_thug_350(
                __L1,
                __TS__SparseArraySpread(____array_349)
            )
            return
        end
        if ____type == "reeisBoss" then
            ____type = "reeis"
            o = __assign({}, o, {transformed = true, powered = true})
        end
        c:save()
        c.imageSmoothingEnabled = false
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        local face = __lt(o.facing, 0) and -1 or 1
        local ____t_result_351
        if __t(o.scale) then
            ____t_result_351 = o.scale
        else
            ____t_result_351 = 1
        end
        local scl = ____t_result_351
        c:scale(face * scl, scl)
        if __isFiniteN(o.opacity) then
            c.globalAlpha = c.globalAlpha * math.max(
                0,
                math.min(1, o.opacity)
            )
        end
        local ____t_result_354
        local ____t_353 = __t
        local ____TS__Number_result_352 = __TS__Number(o.frame)
        __O[207] = ____TS__Number_result_352
        if ____t_353(____TS__Number_result_352) then
            ____t_result_354 = __O[207]
        else
            ____t_result_354 = 0
        end
        local frame = ____t_result_354
        local rawPhase = frame * 9
        local ____t_result_366
        local ____t_356 = __t
        local ____t_result_355
        if __t(o.attack) then
            ____t_result_355 = o.attackType == "fart"
        else
            ____t_result_355 = o.attack
        end
        if ____t_356(____t_result_355) then
            ____t_result_366 = "fart"
        else
            local ____t_result_365
            local ____t_358 = __t
            local ____t_result_357
            if __t(o.attack) then
                ____t_result_357 = not __t(o.attackType) or o.attackType == "paper"
            else
                ____t_result_357 = o.attack
            end
            if ____t_358(____t_result_357) then
                ____t_result_365 = "paper"
            else
                local ____temp_364
                if __TS__Number(o.land) > 0 then
                    ____temp_364 = "land"
                else
                    local ____t_result_363
                    if __t(o.dash) then
                        ____t_result_363 = "dash"
                    else
                        local ____t_result_362
                        if __t(o.flight) then
                            ____t_result_362 = "flight"
                        else
                            local ____temp_361
                            if o.grounded == false then
                                ____temp_361 = __TS__Number(o.vy) < 0 and "jump" or "fall"
                            else
                                local ____t_360 = __t
                                local ____t_result_359
                                if __t(o.moving) then
                                    ____t_result_359 = o.moving
                                else
                                    ____t_result_359 = __TS__Number(o.speed) > 8
                                end
                                ____temp_361 = ____t_360(____t_result_359) and "walk" or "idle"
                            end
                            ____t_result_362 = ____temp_361
                        end
                        ____t_result_363 = ____t_result_362
                    end
                    ____temp_364 = ____t_result_363
                end
                ____t_result_365 = ____temp_364
            end
            ____t_result_366 = ____t_result_365
        end
        local inferred = ____t_result_366
        local ____t_result_375
        local ____t_373 = __t
        local ____t_result_372
        local ____t_368 = __t
        local ____temp_367 = ____type == "daroca"
        __O[208] = ____temp_367
        if ____t_368(____temp_367) then
            local ____get_371 = __get
            local ____L1_heroFrameCatalog_370 = __L1.heroFrameCatalog
            local ____t_result_369
            if __t(o.animation) then
                ____t_result_369 = o.animation
            else
                ____t_result_369 = inferred
            end
            ____t_result_372 = ____get_371(____L1_heroFrameCatalog_370, ____t_result_369)
        else
            ____t_result_372 = __O[208]
        end
        if ____t_373(____t_result_372) then
            local ____t_result_374
            if __t(o.animation) then
                ____t_result_374 = o.animation
            else
                ____t_result_374 = inferred
            end
            ____t_result_375 = ____t_result_374
        else
            ____t_result_375 = ""
        end
        local heroAnim = ____t_result_375
        local ____t_result_378
        local ____t_377 = __t
        local ____get_result_376 = __get(__L1.heroFrameCatalog, heroAnim)
        __O[209] = ____get_result_376
        if ____t_377(____get_result_376) then
            ____t_result_378 = __O[209]
        else
            ____t_result_378 = 1
        end
        local count = ____t_result_378
        local ____t_result_387
        if __t(heroAnim == "walk" or heroAnim == "dash") then
            ____t_result_387 = math.floor(rawPhase / (math.pi * 2) * count)
        else
            local ____t_result_386
            if __t(heroAnim == "paper" or heroAnim == "fart") then
                local ____t_result_381
                local ____t_380 = __t
                local ____TS__Number_result_379 = __TS__Number(o.attackProgress)
                __O[210] = ____TS__Number_result_379
                if ____t_380(____TS__Number_result_379) then
                    ____t_result_381 = __O[210]
                else
                    ____t_result_381 = 0
                end
                ____t_result_386 = math.floor(____t_result_381 * (count - 1) + 0.5)
            else
                local ____t_result_385
                if __t(heroAnim == "jump" or heroAnim == "fall") then
                    local ____t_result_384
                    local ____t_383 = __t
                    local ____TS__Number_result_382 = __TS__Number(o.vy)
                    __O[211] = ____TS__Number_result_382
                    if ____t_383(____TS__Number_result_382) then
                        ____t_result_384 = __O[211]
                    else
                        ____t_result_384 = 0
                    end
                    ____t_result_385 = math.min(
                        2,
                        math.floor(math.abs(____t_result_384) / 150)
                    )
                else
                    ____t_result_385 = math.floor(frame * 4)
                end
                ____t_result_386 = ____t_result_385
            end
            ____t_result_387 = ____t_result_386
        end
        local naturalIndex = ____t_result_387
        local ____isFiniteN_result_388
        if __isFiniteN(o.spriteFrame) then
            ____isFiniteN_result_388 = __mod(
                __mod(
                    math.floor(o.spriteFrame),
                    count
                ) + count,
                count
            )
        else
            ____isFiniteN_result_388 = __mod(
                __mod(naturalIndex, count) + count,
                count
            )
        end
        local poseIndex = ____isFiniteN_result_388
        local ____t_result_389
        if __t(heroAnim == "walk" or heroAnim == "dash") then
            ____t_result_389 = poseIndex / count * math.pi * 2
        else
            ____t_result_389 = rawPhase
        end
        local phase = ____t_result_389
        local ____t_result_394
        local ____t_393 = __t
        local ____t_result_392
        local ____t_391 = __t
        local ____temp_390 = o.moving == true or __TS__Number(o.speed) > 8
        __O[212] = ____temp_390
        if ____t_391(____temp_390) then
            ____t_result_392 = __O[212]
        else
            ____t_result_392 = heroAnim == "walk"
        end
        __O[213] = ____t_result_392
        if ____t_393(____t_result_392) then
            ____t_result_394 = __O[213]
        else
            ____t_result_394 = heroAnim == "dash"
        end
        local moving = ____t_result_394
        local ____t_result_395
        if __t(__call(
            __arrL({"jump", "fall", "flight"}, 3),
            "includes",
            heroAnim
        )) then
            ____t_result_395 = false
        else
            ____t_result_395 = o.grounded ~= false
        end
        local grounded = ____t_result_395
        local flight = not not __t(o.flight) or heroAnim == "flight"
        local air = not __t(grounded)
        local rising = heroAnim == "jump" or __TS__Number(o.vy) < -20
        local ____t_result_398
        local ____t_397 = __t
        local ____t_result_396
        if __t(moving) then
            ____t_result_396 = grounded
        else
            ____t_result_396 = moving
        end
        if ____t_397(____t_result_396) then
            ____t_result_398 = math.sin(phase)
        else
            ____t_result_398 = 0
        end
        local walk = ____t_result_398
        local hit = o.hit
        local ____t_result_401
        local ____t_400 = __t
        local ____TS__Number_result_399 = __TS__Number(o.recoil)
        __O[214] = ____TS__Number_result_399
        if ____t_400(____TS__Number_result_399) then
            ____t_result_401 = __O[214]
        else
            ____t_result_401 = __t(hit) and 0.6 or 0
        end
        local recoil = math.max(
            0,
            math.min(1, ____t_result_401)
        )
        local ____t_result_409
        local ____t_405 = __t
        local ____t_result_404
        local ____t_403 = __t
        local ____temp_402 = not not __t(o.attack) or heroAnim == "paper"
        __O[215] = ____temp_402
        if ____t_403(____temp_402) then
            ____t_result_404 = __O[215]
        else
            ____t_result_404 = heroAnim == "fart"
        end
        __O[217] = ____t_result_404
        if ____t_405(____t_result_404) then
            ____t_result_409 = __O[217]
        else
            local ____t_result_408
            local ____t_407 = __t
            local ____t_result_406
            if __t(o.attackType) then
                ____t_result_406 = __TS__Number(o.attackProgress) > 0
            else
                ____t_result_406 = o.attackType
            end
            __O[216] = ____t_result_406
            if ____t_407(____t_result_406) then
                ____t_result_408 = __TS__Number(o.attackProgress) < 1
            else
                ____t_result_408 = __O[216]
            end
            ____t_result_409 = ____t_result_408
        end
        local attackOn = ____t_result_409
        local ____t_result_413
        if __t(__isFiniteN(o.attackProgress) and not __isFiniteN(o.spriteFrame)) then
            ____t_result_413 = math.max(
                0,
                math.min(1, o.attackProgress)
            )
        else
            local ____t_result_412
            local ____t_411 = __t
            local ____t_result_410
            if __t(heroAnim) then
                ____t_result_410 = heroAnim == "paper" or heroAnim == "fart"
            else
                ____t_result_410 = heroAnim
            end
            if ____t_411(____t_result_410) then
                ____t_result_412 = poseIndex / (count - 1)
            else
                ____t_result_412 = 0.5 + math.sin(frame * 7) * 0.5
            end
            ____t_result_413 = ____t_result_412
        end
        local progress = ____t_result_413
        local ____t_result_415
        if __t(heroAnim == "paper" or heroAnim == "fart") then
            ____t_result_415 = heroAnim
        else
            local ____t_result_414
            if __t(o.attackType) then
                ____t_result_414 = o.attackType
            else
                ____t_result_414 = ____type == "reeis" and "gun" or (____type == "daroca" and "paper" or "cast")
            end
            ____t_result_415 = ____t_result_414
        end
        local attackType = ____t_result_415
        local ____t_result_416
        if __t(attackOn) then
            ____t_result_416 = math.max(
                0,
                1 - math.abs(progress - 0.48) / 0.26
            )
        else
            ____t_result_416 = 0
        end
        local strike = ____t_result_416
        local ____t_result_417
        if __t(attackOn) then
            ____t_result_417 = attackType == "fart"
        else
            ____t_result_417 = attackOn
        end
        local fart = ____t_result_417
        local ____t_result_421
        if __t(heroAnim == "land" and __isFiniteN(o.spriteFrame)) then
            ____t_result_421 = 1 - poseIndex / 2
        else
            local ____t_result_420
            local ____t_419 = __t
            local ____TS__Number_result_418 = __TS__Number(o.land)
            __O[218] = ____TS__Number_result_418
            if ____t_419(____TS__Number_result_418) then
                ____t_result_420 = __O[218]
            else
                ____t_result_420 = 0
            end
            ____t_result_421 = math.max(
                0,
                math.min(1, ____t_result_420)
            )
        end
        local landAmount = ____t_result_421
        local ____t_result_428
        if __t(fart) then
            local ____temp_423
            if progress < 0.28 then
                ____temp_423 = math.sin(progress / 0.28 * math.pi * 0.5) * 5
            else
                local ____temp_422
                if progress < 0.5 then
                    ____temp_422 = 5 * (1 - (progress - 0.28) / 0.22) - 3 * math.sin((progress - 0.28) / 0.22 * math.pi)
                else
                    ____temp_422 = -2 * (1 - (progress - 0.5) / 0.5)
                end
                ____temp_423 = ____temp_422
            end
            ____t_result_428 = math.floor(____temp_423 + 0.5)
        else
            local ____t_result_427
            if __t(landAmount) then
                ____t_result_427 = math.floor(landAmount * 6 + 0.5)
            else
                local ____t_result_426
                if __t(o.charging) then
                    ____t_result_426 = 4 + math.floor(math.sin(frame * 16) + 0.5)
                else
                    local ____t_425 = __t
                    local ____t_result_424
                    if __t(o.dash) then
                        ____t_result_424 = o.dash
                    else
                        ____t_result_424 = heroAnim == "dash"
                    end
                    ____t_result_426 = ____t_425(____t_result_424) and 3 or 0
                end
                ____t_result_427 = ____t_result_426
            end
            ____t_result_428 = ____t_result_427
        end
        local squat = ____t_result_428
        local ____temp_432
        if heroAnim == "idle" then
            ____temp_432 = __get(
                __arrL({0, -1, -2, -1}, 4),
                poseIndex
            )
        else
            local ____t_result_431
            local ____t_430 = __t
            local ____t_result_429
            if __t(moving) then
                ____t_result_429 = grounded
            else
                ____t_result_429 = moving
            end
            if ____t_430(____t_result_429) then
                ____t_result_431 = math.floor((1 - math.cos(phase * 2)) * 1.2 + 0.5)
            else
                ____t_result_431 = math.floor(math.sin(frame * 2.5) * 0.7 + 0.5)
            end
            ____temp_432 = ____t_result_431
        end
        local bob = ____temp_432
        local ____t_434 = __t
        local ____t_result_433
        if __t(o.dash) then
            ____t_result_433 = o.dash
        else
            ____t_result_433 = heroAnim == "dash"
        end
        local ____temp_438 = (____t_434(____t_result_433) and 8 or (__t(moving) and 2 or 0)) + (__t(flight) and 4 or 0) - recoil * 6
        local ____t_result_437
        local ____t_436 = __t
        local ____t_result_435
        if __t(attackOn) then
            ____t_result_435 = attackType == "paper"
        else
            ____t_result_435 = attackOn
        end
        if ____t_436(____t_result_435) then
            ____t_result_437 = progress < 0.32 and -3 or 4 * strike
        else
            ____t_result_437 = 0
        end
        local lean = math.floor(____temp_438 + ____t_result_437 + 0.5)
        local ____t_449 = __t
        local ____t_result_448
        local ____t_440 = __t
        local ____temp_439 = ____type == "reeis"
        __O[222] = ____temp_439
        if ____t_440(____temp_439) then
            local ____t_result_447
            local ____t_446 = __t
            local ____t_result_445
            local ____t_444 = __t
            local ____t_result_443
            local ____t_442 = __t
            local ____t_result_441
            if __t(o.transformed) then
                ____t_result_441 = o.transformed
            else
                ____t_result_441 = o.charging
            end
            __O[219] = ____t_result_441
            if ____t_442(____t_result_441) then
                ____t_result_443 = __O[219]
            else
                ____t_result_443 = o.powered
            end
            __O[220] = ____t_result_443
            if ____t_444(____t_result_443) then
                ____t_result_445 = __O[220]
            else
                ____t_result_445 = o.aura
            end
            __O[221] = ____t_result_445
            if ____t_446(____t_result_445) then
                ____t_result_447 = __O[221]
            else
                ____t_result_447 = o.energy
            end
            ____t_result_448 = ____t_result_447
        else
            ____t_result_448 = __O[222]
        end
        if ____t_449(____t_result_448) then
            __L1:energyAura(
                c,
                0,
                0,
                frame,
                {
                    scale = __t(o.transformed) and 1.75 or 1,
                    intensity = __t(o.charging) and 0.92 or 0.98,
                    charging = o.charging,
                    powered = o.powered
                }
            )
        end
        local ____t_454 = __t
        local ____t_result_453
        local ____t_451 = __t
        local ____temp_450 = ____type == "marco"
        __O[223] = ____temp_450
        if ____t_451(____temp_450) then
            local ____t_result_452
            if __t(o.angry) then
                ____t_result_452 = o.angry
            else
                ____t_result_452 = o.rage
            end
            ____t_result_453 = ____t_result_452
        else
            ____t_result_453 = __O[223]
        end
        if ____t_454(____t_result_453) then
            __L1:energyAura(
                c,
                0,
                0,
                frame,
                {scale = 1.15, intensity = 0.95, charging = o.charging, red = true}
            )
            c:save()
            c.globalAlpha = 0.28
            __L1:oval(
                c,
                0,
                -34,
                31 + math.sin(frame * 11) * 3,
                43,
                "#f26154",
                3
            )
            c:restore()
            do
                local i = 0
                while i < 9 do
                    local ax = math.floor(math.cos(i * 0.9 + frame * 0.8) * 25 + 0.5)
                    local ay = -35 + math.floor(math.sin(i * 0.9 + frame * 0.8) * 35 + 0.5)
                    __L1:r(
                        c,
                        ax,
                        ay,
                        5,
                        3,
                        __t(__mod(i, 2)) and "#ec715f" or "#a94249"
                    )
                    __L1:r(
                        c,
                        ax + 3,
                        ay - 4,
                        2,
                        5,
                        "#e59c73"
                    )
                    i = i + 1
                end
            end
        end
        __L1:oval(
            c,
            0,
            -1,
            __t(air) and 11 or (____type == "mota" and 14 or 17),
            3,
            "#304333",
            2
        )
        if ____type == "lucas" then
            c:scale(0.84, 0.78)
        end
        local ____t_458 = __t
        local ____t_result_457
        local ____t_456 = __t
        local ____temp_455 = ____type == "reeis"
        __O[224] = ____temp_455
        if ____t_456(____temp_455) then
            ____t_result_457 = o.transformed
        else
            ____t_result_457 = __O[224]
        end
        if ____t_458(____t_result_457) then
            c:scale(1.9, 1.75)
        end
        local skin = ____type == "reeis" and "#825033" or (____type == "caleb" and "#f0c9af" or (____type == "lucas" and "#efc9b0" or (____type == "menezes" and "#b47d54" or (____type == "marco" and "#f0cdb8" or (____type == "mota" and "#f1ccb4" or (____type == "nikolas" and "#e1b28a" or (____type == "miqueias" and "#f0cbb5" or (____type == "almiro" and "#b47b53" or "#d6a071"))))))))
        local ____temp_466
        if ____type == "reeis" then
            ____temp_466 = "#51382c"
        else
            local ____temp_465
            if ____type == "almiro" then
                ____temp_465 = "#8a573d"
            else
                local ____t_464 = __t
                local ____t_result_463
                local ____t_462 = __t
                local ____t_result_461
                local ____t_460 = __t
                local ____temp_459 = ____type == "caleb" or ____type == "miqueias"
                __O[225] = ____temp_459
                if ____t_460(____temp_459) then
                    ____t_result_461 = __O[225]
                else
                    ____t_result_461 = ____type == "mota"
                end
                __O[226] = ____t_result_461
                if ____t_462(____t_result_461) then
                    ____t_result_463 = __O[226]
                else
                    ____t_result_463 = ____type == "marco"
                end
                ____temp_465 = ____t_464(____t_result_463) and "#c3977f" or "#a86c4e"
            end
            ____temp_466 = ____temp_465
        end
        local shadow = ____temp_466
        local ____t_result_470
        if __t(____type == "daroca" and o.look ~= false) then
            local ____t_result_469
            local ____t_468 = __t
            local ____t_result_467
            if __t(o.look) then
                ____t_result_467 = o.look
            else
                ____t_result_467 = __callq(window.DarocaLook, "get")
            end
            __O[227] = ____t_result_467
            if ____t_468(____t_result_467) then
                ____t_result_469 = __O[227]
            else
                ____t_result_469 = nil
            end
            ____t_result_470 = ____t_result_469
        else
            ____t_result_470 = nil
        end
        local LK = ____t_result_470
        local ____opt_result_473
        if LK ~= nil then
            ____opt_result_473 = LK.costume
        end
        local lion = ____opt_result_473 == "jaglion"
        local ____opt_result_476
        if LK ~= nil then
            ____opt_result_476 = LK.costume
        end
        local jeg = ____opt_result_476 == "dajegue"
        local ____opt_result_479
        if LK ~= nil then
            ____opt_result_479 = LK.costume
        end
        local cai = ____opt_result_479 == "caipira"
        local ____opt_result_482
        if LK ~= nil then
            ____opt_result_482 = LK.costume
        end
        local far = ____opt_result_482 == "farda"
        local ____t_result_483
        if __t(lion) then
            ____t_result_483 = lion
        else
            ____t_result_483 = jeg
        end
        local kig = ____t_result_483
        local trajeLuz = __t(lion) and "#f3c766" or (__t(jeg) and "#aaa397" or (__t(far) and "#ffffff" or (__t(cai) and "#e2685a" or nil)))
        local ____t_result_494
        if __t(lion) then
            ____t_result_494 = "#e3a83f"
        else
            local ____t_result_493
            if __t(jeg) then
                ____t_result_493 = "#8f887d"
            else
                local ____t_result_492
                if __t(far) then
                    ____t_result_492 = "#f1f1ea"
                else
                    local ____t_result_491
                    if __t(cai) then
                        ____t_result_491 = "#c2392d"
                    else
                        local ____t_result_490
                        local ____t_489 = __t
                        local ____t_result_488
                        local ____t_487 = __t
                        local ____opt_result_486
                        if LK ~= nil then
                            ____opt_result_486 = LK.shirt
                        end
                        __O[228] = ____opt_result_486
                        if ____t_487(____opt_result_486) then
                            ____t_result_488 = __O[228]
                        else
                            ____t_result_488 = __get({
                                daroca = "#dc8c47",
                                lucas = "#9a9e9e",
                                reeis = "#4d7374",
                                nikolas = "#8c6594",
                                menezes = "#647c84",
                                caleb = "#e1b563",
                                ravid = "#7c93a1",
                                marco = "#222b30",
                                kaua = "#66888a",
                                almiro = "#367cba",
                                miqueias = "#617b70",
                                mota = "#1b4677"
                            }, ____type)
                        end
                        __O[229] = ____t_result_488
                        if ____t_489(____t_result_488) then
                            ____t_result_490 = __O[229]
                        else
                            ____t_result_490 = "#dc8c47"
                        end
                        ____t_result_491 = ____t_result_490
                    end
                    ____t_result_492 = ____t_result_491
                end
                ____t_result_493 = ____t_result_492
            end
            ____t_result_494 = ____t_result_493
        end
        local shirt = ____t_result_494
        local ____t_result_503
        if __t(lion) then
            ____t_result_503 = "#d39a36"
        else
            local ____t_result_502
            if __t(jeg) then
                ____t_result_502 = "#7b746a"
            else
                local ____t_result_501
                if __t(far) then
                    ____t_result_501 = "#1d2d58"
                else
                    local ____t_result_500
                    if __t(cai) then
                        ____t_result_500 = "#7a5636"
                    else
                        local ____t_result_499
                        local ____t_498 = __t
                        local ____opt_result_497
                        if LK ~= nil then
                            ____opt_result_497 = LK.pants
                        end
                        __O[230] = ____opt_result_497
                        if ____t_498(____opt_result_497) then
                            ____t_result_499 = __O[230]
                        else
                            ____t_result_499 = ____type == "marco" and "#2b353e" or (____type == "nikolas" and "#423e59" or (____type == "caleb" and "#564d3e" or (__t(____type == "almiro" or ____type == "lucas") and "#1e3355" or (____type == "miqueias" and "#354c53" or (____type == "mota" and "#1c3558" or "#455b62")))))
                        end
                        ____t_result_500 = ____t_result_499
                    end
                    ____t_result_501 = ____t_result_500
                end
                ____t_result_502 = ____t_result_501
            end
            ____t_result_503 = ____t_result_502
        end
        local pants = ____t_result_503
        local function leg(self, front)
            local sign = __t(front) and 1 or -1
            local ____t_result_504
            if __t(front) then
                ____t_result_504 = walk
            else
                ____t_result_504 = -walk
            end
            local swing = ____t_result_504
            local ____t_result_505
            if __t(moving) then
                ____t_result_505 = math.floor(swing * 13 + 0.5)
            else
                ____t_result_505 = sign * 6
            end
            local footX = ____t_result_505
            local ____t_result_508
            local ____t_507 = __t
            local ____t_result_506
            if __t(moving) then
                ____t_result_506 = grounded
            else
                ____t_result_506 = moving
            end
            if ____t_507(____t_result_506) then
                ____t_result_508 = math.floor(math.max(
                    0,
                    math.cos(phase + (__t(front) and 0 or math.pi))
                ) * 7 + 0.5)
            else
                ____t_result_508 = 0
            end
            local lift = ____t_result_508
            local footY = -lift
            local hipX = sign * 4 + math.floor(lean * 0.25 + 0.5)
            local hipY = -23 - bob + squat
            if __t(air) then
                local ____t_result_509
                if __t(front) then
                    ____t_result_509 = __t(flight) and -5 or (__t(rising) and 8 or 11)
                else
                    ____t_result_509 = __t(flight) and -18 or (__t(rising) and -8 or -5)
                end
                footX = ____t_result_509
                local ____t_result_510
                if __t(front) then
                    ____t_result_510 = __t(flight) and -3 or (__t(rising) and -7 or -1)
                else
                    ____t_result_510 = __t(flight) and -12 or (__t(rising) and -13 or -6)
                end
                footY = ____t_result_510
            end
            if heroAnim == "jump" then
                local ____t_result_511
                if __t(front) then
                    ____t_result_511 = poseIndex * 2
                else
                    ____t_result_511 = __TS__Number(-poseIndex) * 2
                end
                footX = footX + ____t_result_511
                local ____t_result_512
                if __t(front) then
                    ____t_result_512 = __get(
                        __arrL({0, 3, 5}, 3),
                        poseIndex
                    )
                else
                    ____t_result_512 = __get(
                        __arrL({0, 2, 0}, 3),
                        poseIndex
                    )
                end
                footY = footY - ____t_result_512
            end
            if heroAnim == "fall" then
                local ____t_result_513
                if __t(front) then
                    ____t_result_513 = poseIndex * 2
                else
                    ____t_result_513 = __TS__Number(-poseIndex)
                end
                footX = footX + ____t_result_513
                local ____t_result_514
                if __t(front) then
                    ____t_result_514 = __get(
                        __arrL({0, 1, 3}, 3),
                        poseIndex
                    )
                else
                    ____t_result_514 = __get(
                        __arrL({0, 2, 4}, 3),
                        poseIndex
                    )
                end
                footY = footY + ____t_result_514
            end
            if heroAnim == "flight" then
                footY = footY + math.floor(math.sin(poseIndex * math.pi * 0.5 + (__t(front) and 0 or 1)) * 3 + 0.5)
            end
            if __t(landAmount) then
                local ____t_result_515
                if __t(front) then
                    ____t_result_515 = math.floor(landAmount * 4 + 0.5)
                else
                    ____t_result_515 = -math.floor(landAmount * 4 + 0.5)
                end
                footX = footX + ____t_result_515
            end
            local ____t_521 = __t
            local ____t_result_520
            local ____t_519 = __t
            local ____t_result_518
            local ____t_517 = __t
            local ____temp_516 = ____type == "daroca"
            __O[231] = ____temp_516
            if ____t_517(____temp_516) then
                ____t_result_518 = attackOn
            else
                ____t_result_518 = __O[231]
            end
            __O[232] = ____t_result_518
            if ____t_519(____t_result_518) then
                ____t_result_520 = attackType == "paper"
            else
                ____t_result_520 = __O[232]
            end
            if ____t_521(____t_result_520) then
                local ____t_result_522
                if __t(front) then
                    ____t_result_522 = math.floor(strike * 3 + 0.5)
                else
                    ____t_result_522 = -math.floor(strike * 2 + 0.5)
                end
                footX = footX + ____t_result_522
            end
            local ____t_result_523
            if __t(air) then
                ____t_result_523 = footX - 5
            else
                ____t_result_523 = math.floor((footX + hipX) / 2 + 0.5) + (__t(front) and 2 or -2) - math.floor(squat * 0.7 + 0.5)
            end
            local kneeX = ____t_result_523
            local kneeY = -12 - bob + math.floor(squat * 0.7 + 0.5) - lift * 0.45
            local pts = __arrL(
                {
                    __arrL({hipX, hipY}, 2),
                    __arrL({kneeX, kneeY}, 2),
                    __arrL({footX, footY - 4}, 2)
                },
                3
            )
            __L1:limb(
                c,
                pts,
                __t(____type == "mota" or ____type == "marco") and 7 or 9,
                __L1.P.ink
            )
            local ____L1_limb_535 = __L1.limb
            local ____c_533 = c
            local ____temp_534 = __t(____type == "mota" or ____type == "marco") and 4 or 5
            local ____t_result_532
            if __t(front) then
                ____t_result_532 = pants
            else
                local ____t_result_531
                if __t(lion) then
                    ____t_result_531 = "#b8862e"
                else
                    local ____t_result_530
                    if __t(jeg) then
                        ____t_result_530 = "#665f56"
                    else
                        local ____t_result_529
                        if __t(far) then
                            ____t_result_529 = "#16234a"
                        else
                            local ____t_result_528
                            if __t(cai) then
                                ____t_result_528 = "#62452b"
                            else
                                local ____t_527 = __t
                                local ____t_result_526
                                local ____t_525 = __t
                                local ____temp_524 = ____type == "lucas" or ____type == "almiro"
                                __O[233] = ____temp_524
                                if ____t_525(____temp_524) then
                                    ____t_result_526 = __O[233]
                                else
                                    ____t_result_526 = ____type == "mota"
                                end
                                ____t_result_528 = ____t_527(____t_result_526) and "#17283e" or "#374a50"
                            end
                            ____t_result_529 = ____t_result_528
                        end
                        ____t_result_530 = ____t_result_529
                    end
                    ____t_result_531 = ____t_result_530
                end
                ____t_result_532 = ____t_result_531
            end
            ____L1_limb_535(
                __L1,
                ____c_533,
                pts,
                ____temp_534,
                ____t_result_532
            )
            local ____t_537 = __t
            local ____t_result_536
            if __t(far) then
                ____t_result_536 = front
            else
                ____t_result_536 = far
            end
            if ____t_537(____t_result_536) then
                __L1:limb(
                    c,
                    __call(
                        pts,
                        "map",
                        function(____, p) return __arrL(
                            {
                                __get(p, 0) + 1,
                                __get(p, 1)
                            },
                            2
                        ) end
                    ),
                    2,
                    "#6fb0e6"
                )
            end
            if __t(cai) then
                if __t(front) then
                    __L1:r(
                        c,
                        kneeX - 3,
                        kneeY - 2,
                        6,
                        5,
                        "#c9a24a"
                    )
                    __L1:r(
                        c,
                        kneeX - 2,
                        kneeY - 1,
                        1,
                        1,
                        "#5a3a20"
                    )
                    __L1:r(
                        c,
                        kneeX + 1,
                        kneeY + 1,
                        1,
                        1,
                        "#5a3a20"
                    )
                end
                __L1:r(
                    c,
                    footX - 4,
                    footY - 8,
                    11,
                    3,
                    __t(front) and "#9a7448" or "#7d5c38"
                )
            end
            local shoe = __t(lion) and "#e3a83f" or (__t(jeg) and "#3b332c" or (__t(cai) and "#5a3a22" or (__t(far) and "#1a1a1e" or (____type == "lucas" and "#f4f7f3" or (____type == "almiro" and "#9ef13d" or (____type == "mota" and "#18394d" or "#343b35"))))))
            __L1:r(
                c,
                footX - 4,
                footY - 5,
                12,
                5,
                shoe
            )
            __L1:r(
                c,
                footX - 3,
                footY - 2,
                11,
                2,
                ____type == "lucas" and "#bac6cd" or (____type == "almiro" and "#d1ff77" or (____type == "mota" and "#f1ede3" or (__t(front) and "#bba784" or "#8e8c70")))
            )
            if __t(lion) then
                __L1:r(
                    c,
                    footX - 4,
                    footY - 6,
                    12,
                    2,
                    "#f0c25a"
                )
                __L1:r(
                    c,
                    footX + 1,
                    footY - 4,
                    1,
                    3,
                    "#b8802a"
                )
                __L1:r(
                    c,
                    footX + 4,
                    footY - 4,
                    1,
                    3,
                    "#b8802a"
                )
                __L1:r(
                    c,
                    footX - 3,
                    footY - 1,
                    10,
                    1,
                    "#8a4a2a"
                )
            end
            if ____type == "mota" then
                do
                    local i = 0
                    while i < 3 do
                        __L1:r(
                            c,
                            footX - 3 + i * 4,
                            footY,
                            2,
                            2,
                            "#dbe4d7"
                        )
                        i = i + 1
                    end
                end
            end
        end
        leg(nil, false)
        leg(nil, true)
        c:translate(
            lean,
            __TS__Number(-bob) + squat + math.floor(recoil * 2 + 0.5)
        )
        local ____t_543 = __t
        local ____t_result_542
        local ____t_541 = __t
        local ____t_result_540
        local ____t_539 = __t
        local ____temp_538 = ____type == "daroca"
        __O[234] = ____temp_538
        if ____t_539(____temp_538) then
            ____t_result_540 = attackOn
        else
            ____t_result_540 = __O[234]
        end
        __O[235] = ____t_result_540
        if ____t_541(____t_result_540) then
            ____t_result_542 = attackType == "paper"
        else
            ____t_result_542 = __O[235]
        end
        if ____t_543(____t_result_542) then
            local ____c_545 = c
            local ____c_rotate_546 = c.rotate
            local ____temp_544
            if progress < 0.3 then
                ____temp_544 = -0.035 * math.sin(progress / 0.3 * math.pi * 0.5)
            else
                ____temp_544 = math.sin((progress - 0.3) / 0.7 * math.pi) * 0.045
            end
            ____c_rotate_546(____c_545, ____temp_544)
        end
        local ____t_result_557
        local ____t_553 = __t
        local ____t_result_552
        local ____t_548 = __t
        local ____temp_547 = ____type == "caleb"
        __O[237] = ____temp_547
        if ____t_548(____temp_547) then
            ____t_result_552 = __O[237]
        else
            local ____t_result_551
            local ____t_550 = __t
            local ____temp_549 = ____type == "reeis"
            __O[236] = ____temp_549
            if ____t_550(____temp_549) then
                ____t_result_551 = o.transformed
            else
                ____t_result_551 = __O[236]
            end
            ____t_result_552 = ____t_result_551
        end
        __O[239] = ____t_result_552
        if ____t_553(____t_result_552) then
            ____t_result_557 = __O[239]
        else
            local ____t_result_556
            local ____t_555 = __t
            local ____temp_554 = ____type == "daroca"
            __O[238] = ____temp_554
            if ____t_555(____temp_554) then
                ____t_result_556 = o.muscular
            else
                ____t_result_556 = __O[238]
            end
            ____t_result_557 = ____t_result_556
        end
        local muscular = ____t_result_557
        local ____t_result_560
        local ____t_559 = __t
        local ____temp_558 = ____type == "daroca"
        __O[240] = ____temp_558
        if ____t_559(____temp_558) then
            ____t_result_560 = o.muscular
        else
            ____t_result_560 = __O[240]
        end
        local heroStrong = ____t_result_560
        local slim = ____type == "mota" or ____type == "marco"
        local shoulder = __t(muscular) and 20 or (__t(slim) and 9 or 12)
        local ____t_result_562
        if __t(moving) then
            ____t_result_562 = 0
        else
            local ____temp_561
            if heroAnim == "idle" then
                ____temp_561 = __get(
                    __arrL({0, 1, 2, 0}, 4),
                    poseIndex
                )
            else
                ____temp_561 = math.floor(math.sin(frame * 2.4 + 1) * 2 + 0.5)
            end
            ____t_result_562 = ____temp_561
        end
        local gesture = ____t_result_562
        local backElbow = __arrL(
            {
                -(__t(muscular) and 23 or (__t(slim) and 12 or 15)) + math.floor(walk * 5 + 0.5),
                -27
            },
            2
        )
        local backHand = __arrL(
            {
                -(__t(muscular) and 23 or (__t(slim) and 12 or 14)) + math.floor(walk * 9 + 0.5),
                -18 - gesture
            },
            2
        )
        local frontElbow = __arrL(
            {
                (__t(muscular) and 23 or (__t(slim) and 12 or 15)) - math.floor(walk * 5 + 0.5),
                -27
            },
            2
        )
        local frontHand = __arrL(
            {
                (__t(muscular) and 23 or (__t(slim) and 12 or 15)) - math.floor(walk * 10 + 0.5),
                -18 + gesture
            },
            2
        )
        local ____t_569 = __t
        local ____t_result_568
        local ____t_564 = __t
        local ____temp_563 = ____type == "ravid"
        __O[242] = ____temp_563
        if ____t_564(____temp_563) then
            local ____t_result_567
            local ____t_566 = __t
            local ____temp_565 = not __t(moving)
            __O[241] = ____temp_565
            if ____t_566(____temp_565) then
                ____t_result_567 = __O[241]
            else
                ____t_result_567 = o.talking
            end
            ____t_result_568 = ____t_result_567
        else
            ____t_result_568 = __O[242]
        end
        if ____t_569(____t_result_568) then
            frontElbow = __arrL({22, -33}, 2)
            frontHand = __arrL(
                {
                    29 + math.floor(math.sin(frame * 3) * 4 + 0.5),
                    -43 + math.floor(math.sin(frame * 5) * 5 + 0.5)
                },
                2
            )
            backHand = __arrL({-17, -26 + gesture}, 2)
        end
        local ____t_573 = __t
        local ____t_result_572
        local ____t_571 = __t
        local ____temp_570 = ____type == "almiro" or ____type == "miqueias"
        __O[243] = ____temp_570
        if ____t_571(____temp_570) then
            ____t_result_572 = not __t(moving)
        else
            ____t_result_572 = __O[243]
        end
        if ____t_573(____t_result_572) then
            frontElbow = __arrL({18, -28}, 2)
            frontHand = __arrL(
                {
                    24,
                    -25 + math.floor(math.sin(frame * 2) * 4 + 0.5)
                },
                2
            )
        end
        if __t(air) then
            backElbow = __arrL({-18, -33}, 2)
            backHand = __arrL(
                {
                    __t(flight) and -26 or -20,
                    __t(flight) and -26 or (__t(rising) and -40 or -31)
                },
                2
            )
            frontElbow = __arrL({18, -34}, 2)
            frontHand = __arrL(
                {
                    __t(flight) and 25 or 20,
                    __t(flight) and -40 or (__t(rising) and -46 or -36)
                },
                2
            )
        end
        if heroAnim == "flight" then
            __set(
                frontHand,
                1,
                __get(frontHand, 1) + math.floor(math.sin(poseIndex * math.pi * 0.5) * 4 + 0.5)
            )
            __set(
                backHand,
                1,
                __get(backHand, 1) + math.floor(math.cos(poseIndex * math.pi * 0.5) * 3 + 0.5)
            )
        end
        if __t(landAmount) then
            backElbow = __arrL({-21, -30}, 2)
            backHand = __arrL({-27, -27 + landAmount * 3}, 2)
            frontElbow = __arrL({22, -30}, 2)
            frontHand = __arrL({28, -27 + landAmount * 3}, 2)
        end
        if __t(recoil) then
            backElbow = __arrL({-20, -36}, 2)
            backHand = __arrL({-18, -47}, 2)
            frontElbow = __arrL({13, -35}, 2)
            frontHand = __arrL({20, -41}, 2)
        end
        if __t(o.charging) then
            backElbow = __arrL({-27, -29}, 2)
            backHand = __arrL({-19, -24}, 2)
            frontElbow = __arrL({27, -29}, 2)
            frontHand = __arrL({19, -24}, 2)
        end
        local ____t_575 = __t
        local ____t_result_574
        if __t(o.dash) then
            ____t_result_574 = o.dash
        else
            ____t_result_574 = heroAnim == "dash"
        end
        if ____t_575(____t_result_574) then
            backElbow = __arrL({-24, -30}, 2)
            backHand = __arrL({-32, -32}, 2)
            frontElbow = __arrL({12, -41}, 2)
            frontHand = __arrL({22, -45}, 2)
        end
        if __t(o.pose == "fistbump" or o.gesture == "fistbump") then
            frontElbow = __arrL({23, -34}, 2)
            frontHand = __arrL({37, -35}, 2)
        end
        if __t(o.pose == "offer" or o.gesture == "offer") then
            frontElbow = __arrL({22, -26}, 2)
            frontHand = __arrL({36, -24}, 2)
        end
        if __t(o.pose == "steal" or o.gesture == "steal") then
            frontElbow = __arrL({25, -28}, 2)
            frontHand = __arrL({41, -26}, 2)
            backElbow = __arrL({-10, -29}, 2)
            backHand = __arrL({3, -25}, 2)
        end
        if __t(attackOn) then
            if attackType == "paper" then
                if progress < 0.3 then
                    local raw = progress / 0.3
                    local q = raw * raw * (3 - 2 * raw)
                    frontElbow = __arrL({11 - 13 * q, -30 - 12 * q}, 2)
                    frontHand = __arrL({13 - 21 * q, -24 - 28 * q}, 2)
                elseif progress < 0.55 then
                    local raw = (progress - 0.3) / 0.25
                    local q = raw * raw * (3 - 2 * raw)
                    frontElbow = __arrL({-2 + 25 * q, -42 + 6 * q}, 2)
                    frontHand = __arrL({-8 + 45 * q, -52 + 14 * q}, 2)
                else
                    local raw = (progress - 0.55) / 0.45
                    local q = raw * raw * (3 - 2 * raw)
                    frontElbow = __arrL({23 - 8 * q, -36 + 9 * q}, 2)
                    frontHand = __arrL({37 - 22 * q, -38 + 20 * q}, 2)
                end
                backElbow = __arrL({-17, -28}, 2)
                backHand = __arrL({-22, -19}, 2)
            elseif __t(fart) then
                backElbow = __arrL({-20, -30}, 2)
                backHand = __arrL({-25, -34}, 2)
                frontElbow = __arrL({19, -29}, 2)
                frontHand = __arrL({25, -34}, 2)
            else
                local ____t_579 = __t
                local ____t_result_578
                local ____t_577 = __t
                local ____temp_576 = ____type == "reeis" or ____type == "caleb"
                __O[244] = ____temp_576
                if ____t_577(____temp_576) then
                    ____t_result_578 = __O[244]
                else
                    ____t_result_578 = attackType == "punch"
                end
                if ____t_579(____t_result_578) then
                    frontElbow = __arrL({16 + strike * 9, -31 - strike * 3}, 2)
                    frontHand = __arrL({20 + strike * 20, -27 - strike * 9}, 2)
                    backElbow = __arrL({-16, -37}, 2)
                    backHand = __arrL({-7, -40}, 2)
                elseif ____type == "nikolas" then
                    frontElbow = __arrL({21, -39}, 2)
                    frontHand = __arrL(
                        {
                            21,
                            -49 + math.floor(math.sin(frame * 15) * 2 + 0.5)
                        },
                        2
                    )
                elseif ____type == "marco" then
                    frontElbow = __arrL({17, -37}, 2)
                    frontHand = __arrL({27 + strike * 3, -40 - strike * 7}, 2)
                    backHand = __arrL({-17, -23}, 2)
                else
                    frontElbow = __arrL({19, -34 - strike * 4}, 2)
                    frontHand = __arrL({27 + strike * 7, -37 - strike * 5}, 2)
                end
            end
        end
        local ____t_result_591
        local ____t_586 = __t
        local ____t_result_585
        local ____t_581 = __t
        local ____temp_580 = ____type == "nikolas"
        __O[246] = ____temp_580
        if ____t_581(____temp_580) then
            local ____t_result_584
            local ____t_583 = __t
            local ____temp_582 = o.noseRub ~= false
            __O[245] = ____temp_582
            if ____t_583(____temp_582) then
                ____t_result_584 = __O[245]
            else
                ____t_result_584 = attackOn
            end
            ____t_result_585 = ____t_result_584
        else
            ____t_result_585 = __O[246]
        end
        __O[247] = ____t_result_585
        if ____t_586(____t_result_585) then
            local ____t_590 = __t
            local ____call_589 = __call
            local ____arrL_result_588 = __arrL({"fistbump", "offer", "steal"}, 3)
            local ____t_result_587
            if __t(o.pose) then
                ____t_result_587 = o.pose
            else
                ____t_result_587 = o.gesture
            end
            ____t_result_591 = not ____t_590(____call_589(____arrL_result_588, "includes", ____t_result_587))
        else
            ____t_result_591 = __O[247]
        end
        local noseRubbing = ____t_result_591
        if __t(noseRubbing) then
            frontElbow = __arrL({22, -37}, 2)
            frontHand = __arrL(
                {
                    (o.view == "front" and 4 or 18) + 2,
                    -49 + math.floor(math.sin(frame * 13) * 3 + 0.5)
                },
                2
            )
        end
        local function arm(self, front)
            local ____t_result_592
            if __t(front) then
                ____t_result_592 = frontElbow
            else
                ____t_result_592 = backElbow
            end
            local elbow = ____t_result_592
            local ____t_result_593
            if __t(front) then
                ____t_result_593 = frontHand
            else
                ____t_result_593 = backHand
            end
            local hand = ____t_result_593
            local ____arrL_595 = __arrL
            local ____t_result_594
            if __t(front) then
                ____t_result_594 = shoulder
            else
                ____t_result_594 = -shoulder
            end
            local should = ____arrL_595(
                {
                    ____t_result_594,
                    __t(muscular) and -38 or -34
                },
                2
            )
            local ____t_599 = __t
            local ____t_result_598
            local ____t_597 = __t
            local ____temp_596 = ____type == "daroca"
            __O[248] = ____temp_596
            if ____t_597(____temp_596) then
                ____t_result_598 = attackOn
            else
                ____t_result_598 = __O[248]
            end
            if ____t_599(____t_result_598) then
                local upper = __t(muscular) and 14 or 11
                local lower = __t(muscular) and 15 or 12
                local dx = __get(hand, 0) - __get(should, 0)
                local dy = __get(hand, 1) - __get(should, 1)
                local distance = math.min(
                    upper + lower - 0.05,
                    math.max(
                        math.abs(upper - lower) + 0.05,
                        __hypot(dx, dy)
                    )
                )
                local angle = math.atan(dy, dx)
                local bend = (__t(front) and -1 or 1) * math.acos(math.max(
                    -1,
                    math.min(1, (upper * upper + distance * distance - lower * lower) / (2 * upper * distance))
                ))
                elbow = __arrL(
                    {
                        __get(should, 0) + math.cos(angle + bend) * upper,
                        __get(should, 1) + math.sin(angle + bend) * upper
                    },
                    2
                )
                hand = __arrL(
                    {
                        __get(should, 0) + math.cos(angle) * distance,
                        __get(should, 1) + math.sin(angle) * distance
                    },
                    2
                )
                if __t(front) then
                    frontHand = hand
                    frontElbow = elbow
                else
                    backHand = hand
                    backElbow = elbow
                end
            end
            __L1:limb(
                c,
                __arrL({should, elbow, hand}, 3),
                __t(muscular) and 13 or (__t(slim) and 6 or 8),
                __L1.P.ink
            )
            local ____L1_limb_604 = __L1.limb
            local ____array_603 = __TS__SparseArrayNew(
                c,
                __arrL({should, elbow}, 2),
                __t(muscular) and 9 or (__t(slim) and 4 or 5)
            )
            local ____t_result_602
            local ____t_601 = __t
            local ____t_result_600
            if __t(muscular) then
                ____t_result_600 = not __t(lion)
            else
                ____t_result_600 = muscular
            end
            if ____t_601(____t_result_600) then
                ____t_result_602 = skin
            else
                ____t_result_602 = shirt
            end
            __TS__SparseArrayPush(____array_603, ____t_result_602)
            ____L1_limb_604(
                __L1,
                __TS__SparseArraySpread(____array_603)
            )
            if __t(heroStrong) then
                __L1:limb(
                    c,
                    __arrL(
                        {
                            should,
                            __arrL(
                                {
                                    __get(should, 0) * 0.86,
                                    -33
                                },
                                2
                            )
                        },
                        2
                    ),
                    11,
                    shirt
                )
            end
            local ____L1_limb_615 = __L1.limb
            local ____array_614 = __TS__SparseArrayNew(
                c,
                __arrL({elbow, hand}, 2),
                __t(muscular) and 8 or (__t(slim) and 4 or 5)
            )
            local ____t_result_613
            local ____t_612 = __t
            local ____t_result_611
            local ____t_610 = __t
            local ____t_result_609
            local ____t_608 = __t
            local ____t_result_607
            local ____t_606 = __t
            local ____temp_605 = ____type == "marco"
            __O[249] = ____temp_605
            if ____t_606(____temp_605) then
                ____t_result_607 = __O[249]
            else
                ____t_result_607 = lion
            end
            __O[250] = ____t_result_607
            if ____t_608(____t_result_607) then
                ____t_result_609 = __O[250]
            else
                ____t_result_609 = jeg
            end
            __O[251] = ____t_result_609
            if ____t_610(____t_result_609) then
                ____t_result_611 = __O[251]
            else
                ____t_result_611 = cai
            end
            if ____t_612(____t_result_611) then
                ____t_result_613 = shirt
            else
                ____t_result_613 = skin
            end
            __TS__SparseArrayPush(____array_614, ____t_result_613)
            ____L1_limb_615(
                __L1,
                __TS__SparseArraySpread(____array_614)
            )
            __L1:r(
                c,
                __get(hand, 0) - 3,
                __get(hand, 1) - 3,
                __t(muscular) and 9 or (__t(slim) and 5 or 6),
                __t(muscular) and 8 or (__t(slim) and 5 or 6),
                __t(lion) and "#f0c25a" or (__t(jeg) and "#4a4139" or skin)
            )
            if __t(lion) then
                __L1:r(
                    c,
                    __get(hand, 0) - 4,
                    __get(hand, 1) - 4,
                    __t(muscular) and 11 or 8,
                    2,
                    __L1.P.ink
                )
                __L1:r(
                    c,
                    __get(hand, 0) - 1,
                    __get(hand, 1),
                    3,
                    2,
                    "#8a4a2a"
                )
                __L1:r(
                    c,
                    __get(hand, 0) - 2,
                    __get(hand, 1) - 2,
                    1,
                    1,
                    "#8a4a2a"
                )
                __L1:r(
                    c,
                    __get(hand, 0) + 2,
                    __get(hand, 1) - 2,
                    1,
                    1,
                    "#8a4a2a"
                )
            end
            if __t(muscular) then
                __L1:r(
                    c,
                    __get(elbow, 0) - 2,
                    __get(elbow, 1) - 4,
                    4,
                    2,
                    ____type == "reeis" and "#a26c45" or "#f5d8bb"
                )
                __L1:r(
                    c,
                    __get(elbow, 0) - 3,
                    __get(elbow, 1) + 2,
                    5,
                    2,
                    shadow
                )
            end
        end
        arm(nil, false)
        if __t(muscular) then
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({-22, -44}, 2),
                        __arrL({22, -44}, 2),
                        __arrL({20, -33}, 2),
                        __arrL({13, -18}, 2),
                        __arrL({-13, -18}, 2),
                        __arrL({-20, -33}, 2)
                    },
                    6
                ),
                __L1.P.ink
            )
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({-19, -42}, 2),
                        __arrL({19, -42}, 2),
                        __arrL({17, -32}, 2),
                        __arrL({11, -20}, 2),
                        __arrL({-11, -20}, 2),
                        __arrL({-17, -32}, 2)
                    },
                    6
                ),
                shirt
            )
            if __t(heroStrong) then
                __L1:r(
                    c,
                    -17,
                    -40,
                    13,
                    6,
                    "#edab59"
                )
                __L1:r(
                    c,
                    4,
                    -40,
                    13,
                    6,
                    "#edab59"
                )
                __L1:r(
                    c,
                    -12,
                    -31,
                    25,
                    2,
                    "#ad6b36"
                )
                __L1:r(
                    c,
                    -7,
                    -26,
                    15,
                    2,
                    "#bd783b"
                )
            else
                __L1:r(
                    c,
                    -15,
                    -42,
                    8,
                    12,
                    skin
                )
                __L1:r(
                    c,
                    8,
                    -42,
                    8,
                    12,
                    skin
                )
                __L1:r(
                    c,
                    -8,
                    -38,
                    17,
                    4,
                    skin
                )
                __L1:r(
                    c,
                    -7,
                    -27,
                    15,
                    3,
                    ____type == "reeis" and "#3b5b5b" or "#b18b51"
                )
            end
        elseif __t(slim) then
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({-10, -39}, 2),
                        __arrL({11, -39}, 2),
                        __arrL({10, -29}, 2),
                        __arrL({8, -17}, 2),
                        __arrL({-8, -17}, 2),
                        __arrL({-10, -29}, 2)
                    },
                    6
                ),
                __L1.P.ink
            )
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({-8, -37}, 2),
                        __arrL({9, -37}, 2),
                        __arrL({8, -28}, 2),
                        __arrL({6, -19}, 2),
                        __arrL({-6, -19}, 2),
                        __arrL({-8, -28}, 2)
                    },
                    6
                ),
                shirt
            )
        else
            local ____t_result_617
            if __t(fart) then
                local ____temp_616
                if progress < 0.32 then
                    ____temp_616 = math.floor(math.sin(progress / 0.32 * math.pi * 0.5) * 2 + 0.5)
                else
                    ____temp_616 = progress < 0.65 and -1 or 0
                end
                ____t_result_617 = ____temp_616
            else
                ____t_result_617 = 0
            end
            local broad = ____t_result_617
            __L1:r(
                c,
                -13 - broad,
                -39,
                27 + broad * 2,
                23,
                __L1.P.ink
            )
            __L1:r(
                c,
                -11 - broad,
                -38,
                23 + broad * 2,
                19,
                shirt
            )
            local ____L1_r_627 = __L1.r
            local ____array_626 = __TS__SparseArrayNew(
                c,
                -10,
                -35,
                3,
                12
            )
            local ____temp_625
            if ____type == "lucas" then
                ____temp_625 = "#c3c9c7"
            else
                local ____temp_624
                if ____type == "almiro" then
                    ____temp_624 = "#80b2dc"
                else
                    local ____t_result_623
                    local ____t_622 = __t
                    local ____t_result_621
                    if __t(trajeLuz) then
                        ____t_result_621 = trajeLuz
                    else
                        local ____opt_result_620
                        if LK ~= nil then
                            ____opt_result_620 = LK.shirtLight
                        end
                        ____t_result_621 = ____opt_result_620
                    end
                    __O[252] = ____t_result_621
                    if ____t_622(____t_result_621) then
                        ____t_result_623 = __O[252]
                    else
                        ____t_result_623 = "#e7ac65"
                    end
                    ____temp_624 = ____t_result_623
                end
                ____temp_625 = ____temp_624
            end
            __TS__SparseArrayPush(____array_626, ____temp_625)
            ____L1_r_627(
                __L1,
                __TS__SparseArraySpread(____array_626)
            )
            if __t(lion) then
                __L1:r(
                    c,
                    -7,
                    -36,
                    14,
                    16,
                    "#f6e0b0"
                )
                __L1:r(
                    c,
                    -8,
                    -33,
                    1,
                    10,
                    "#f6e0b0"
                )
                __L1:r(
                    c,
                    7,
                    -33,
                    1,
                    10,
                    "#f6e0b0"
                )
                __L1:r(
                    c,
                    0,
                    -38,
                    1,
                    19,
                    "#c9a050"
                )
                __L1:r(
                    c,
                    -1,
                    -38,
                    3,
                    2,
                    "#c9a050"
                )
            end
            if ____type == "miqueias" then
                __L1:oval(
                    c,
                    3,
                    -26,
                    18,
                    13,
                    __L1.P.ink,
                    2
                )
                __L1:oval(
                    c,
                    3,
                    -27,
                    16,
                    11,
                    shirt,
                    2
                )
                __L1:r(
                    c,
                    -10,
                    -30,
                    27,
                    2,
                    "#8aa498"
                )
                __L1:r(
                    c,
                    -8,
                    -21,
                    23,
                    2,
                    "#344e45"
                )
            end
        end
        arm(nil, true)
        __L1:r(
            c,
            -5,
            -43,
            12,
            7,
            __L1.P.ink
        )
        __L1:r(
            c,
            -4,
            -43,
            9,
            8,
            skin
        )
        __L1:r(
            c,
            -11,
            -59,
            24,
            19,
            __L1.P.ink
        )
        __L1:r(
            c,
            -10,
            -58,
            22,
            17,
            skin
        )
        __L1:r(
            c,
            -11,
            -54,
            3,
            10,
            shadow
        )
        __L1:r(
            c,
            11,
            -51,
            5,
            6,
            skin
        )
        __L1:r(
            c,
            4,
            -51,
            3,
            3,
            "#302f2c"
        )
        __L1:r(
            c,
            11,
            -47,
            4,
            2,
            shadow
        )
        __L1:r(
            c,
            3,
            -43,
            7,
            2,
            shadow
        )
        if ____type == "daroca" then
            local ____t_result_632
            local ____t_631 = __t
            local ____opt_result_630
            if LK ~= nil then
                ____opt_result_630 = LK.hairColor
            end
            __O[253] = ____opt_result_630
            if ____t_631(____opt_result_630) then
                ____t_result_632 = __O[253]
            else
                ____t_result_632 = "#5f4934"
            end
            local hairC = ____t_result_632
            local ____t_result_637
            local ____t_636 = __t
            local ____opt_result_635
            if LK ~= nil then
                ____opt_result_635 = LK.hairStyle
            end
            __O[254] = ____opt_result_635
            if ____t_636(____opt_result_635) then
                ____t_result_637 = __O[254]
            else
                ____t_result_637 = "curto"
            end
            local hs = ____t_result_637
            local ____t_result_645
            if __t(lion) then
                ____t_result_645 = "jaglion"
            else
                local ____t_result_644
                if __t(jeg) then
                    ____t_result_644 = "dajegue"
                else
                    local ____t_result_643
                    if __t(cai) then
                        ____t_result_643 = "caipira"
                    else
                        local ____t_result_642
                        local ____t_641 = __t
                        local ____opt_result_640
                        if LK ~= nil then
                            ____opt_result_640 = LK.hat
                        end
                        __O[255] = ____opt_result_640
                        if ____t_641(____opt_result_640) then
                            ____t_result_642 = __O[255]
                        else
                            ____t_result_642 = "palha"
                        end
                        ____t_result_643 = ____t_result_642
                    end
                    ____t_result_644 = ____t_result_643
                end
                ____t_result_645 = ____t_result_644
            end
            local hat = ____t_result_645
            if not __t(kig) then
                __L1:r(
                    c,
                    -12,
                    -59,
                    25,
                    6,
                    hairC
                )
                __L1:r(
                    c,
                    -9,
                    -57,
                    4,
                    4,
                    hairC
                )
                if hat == "sem" then
                    if hs == "curto" then
                        __L1:r(
                            c,
                            -12,
                            -63,
                            25,
                            6,
                            hairC
                        )
                        __L1:r(
                            c,
                            -10,
                            -65,
                            20,
                            3,
                            hairC
                        )
                        __L1:r(
                            c,
                            -6,
                            -66,
                            12,
                            2,
                            "rgba(255,255,255,.18)"
                        )
                    elseif hs == "black" then
                        __L1:r(
                            c,
                            -17,
                            -72,
                            35,
                            16,
                            __L1.P.ink
                        )
                        __L1:r(
                            c,
                            -16,
                            -71,
                            33,
                            15,
                            hairC
                        )
                        __L1:r(
                            c,
                            -14,
                            -74,
                            29,
                            4,
                            hairC
                        )
                        __L1:r(
                            c,
                            -18,
                            -64,
                            4,
                            10,
                            hairC
                        )
                        __L1:r(
                            c,
                            14,
                            -64,
                            4,
                            10,
                            hairC
                        )
                        __L1:r(
                            c,
                            -10,
                            -72,
                            8,
                            2,
                            "rgba(255,255,255,.18)"
                        )
                    elseif hs == "moicano" then
                        __L1:r(
                            c,
                            -12,
                            -61,
                            25,
                            3,
                            hairC
                        )
                        __L1:r(
                            c,
                            -3,
                            -72,
                            7,
                            13,
                            hairC
                        )
                        __L1:r(
                            c,
                            -1,
                            -75,
                            4,
                            4,
                            hairC
                        )
                        __L1:r(
                            c,
                            -2,
                            -71,
                            2,
                            8,
                            "rgba(255,255,255,.2)"
                        )
                    elseif hs == "raspado" then
                        __L1:r(
                            c,
                            -11,
                            -60,
                            23,
                            3,
                            hairC
                        )
                        __L1:r(
                            c,
                            -9,
                            -61,
                            19,
                            1,
                            "rgba(0,0,0,.15)"
                        )
                    elseif hs == "comprido" then
                        __L1:r(
                            c,
                            -13,
                            -64,
                            27,
                            7,
                            hairC
                        )
                        __L1:r(
                            c,
                            -14,
                            -58,
                            5,
                            20,
                            hairC
                        )
                        __L1:r(
                            c,
                            -11,
                            -62,
                            20,
                            2,
                            "rgba(255,255,255,.18)"
                        )
                    end
                elseif hs == "comprido" then
                    __L1:r(
                        c,
                        -14,
                        -58,
                        5,
                        18,
                        hairC
                    )
                elseif hs == "black" then
                    __L1:r(
                        c,
                        -15,
                        -60,
                        5,
                        10,
                        hairC
                    )
                    __L1:r(
                        c,
                        11,
                        -60,
                        4,
                        6,
                        hairC
                    )
                end
            end
            __L1:r(
                c,
                -7,
                -54,
                3,
                4,
                "#72513b"
            )
            __L1:r(
                c,
                1,
                -53,
                8,
                1,
                "#855b3d"
            )
            __L1:r(
                c,
                5,
                -51,
                2,
                3,
                "#252f2b"
            )
            __L1:r(
                c,
                3,
                -44,
                7,
                1,
                "#8e5e43"
            )
            __L1:r(
                c,
                4,
                -43,
                5,
                1,
                "#e9b684"
            )
            if __t(heroAnim == "idle" and poseIndex == 3) then
                __L1:r(
                    c,
                    3,
                    -52,
                    6,
                    4,
                    skin
                )
                __L1:r(
                    c,
                    3,
                    -50,
                    6,
                    1,
                    "#4a3e30"
                )
            end
            c:save()
            c:translate(
                __t(flight) and -2 or math.floor(-walk + 0.5),
                __t(flight) and -3 or math.floor(-math.abs(walk) + 0.5)
            )
            if hat == "palha" then
                __L1:r(
                    c,
                    -20,
                    -61,
                    41,
                    5,
                    "#6e5335"
                )
                __L1:r(
                    c,
                    -19,
                    -65,
                    39,
                    5,
                    "#dbb969"
                )
                __L1:r(
                    c,
                    -12,
                    -76,
                    27,
                    13,
                    "#a98045"
                )
                __L1:r(
                    c,
                    -10,
                    -76,
                    23,
                    10,
                    "#dfb96a"
                )
                __L1:r(
                    c,
                    -8,
                    -78,
                    19,
                    3,
                    "#f0ce7e"
                )
                __L1:r(
                    c,
                    -11,
                    -67,
                    25,
                    4,
                    "#8a5a3b"
                )
                __L1:r(
                    c,
                    -17,
                    -64,
                    34,
                    2,
                    "#f1cf7a"
                )
                __L1:r(
                    c,
                    -5,
                    -73,
                    3,
                    3,
                    "#f5d68b"
                )
            elseif hat == "bone" then
                local ____t_result_650
                local ____t_649 = __t
                local ____opt_result_648
                if LK ~= nil then
                    ____opt_result_648 = LK.hatColor
                end
                __O[256] = ____opt_result_648
                if ____t_649(____opt_result_648) then
                    ____t_result_650 = __O[256]
                else
                    ____t_result_650 = "#c0392b"
                end
                local bc = ____t_result_650
                __L1:r(
                    c,
                    -13,
                    -70,
                    27,
                    12,
                    __L1.P.ink
                )
                __L1:r(
                    c,
                    -12,
                    -69,
                    25,
                    10,
                    bc
                )
                __L1:r(
                    c,
                    -12,
                    -61,
                    34,
                    4,
                    __L1.P.ink
                )
                __L1:r(
                    c,
                    -11,
                    -61,
                    32,
                    3,
                    bc
                )
                __L1:r(
                    c,
                    -6,
                    -68,
                    8,
                    2,
                    "rgba(255,255,255,.3)"
                )
                __L1:r(
                    c,
                    0,
                    -71,
                    3,
                    2,
                    bc
                )
            elseif hat == "couro" then
                __L1:r(
                    c,
                    -22,
                    -61,
                    45,
                    5,
                    "#3e2a1a"
                )
                __L1:r(
                    c,
                    -21,
                    -64,
                    43,
                    4,
                    "#7a5232"
                )
                __L1:r(
                    c,
                    -12,
                    -77,
                    26,
                    15,
                    "#3e2a1a"
                )
                __L1:r(
                    c,
                    -11,
                    -76,
                    24,
                    13,
                    "#8a5e38"
                )
                __L1:r(
                    c,
                    -11,
                    -67,
                    24,
                    3,
                    "#c9a24a"
                )
                __L1:r(
                    c,
                    -21,
                    -66,
                    4,
                    3,
                    "#7a5232"
                )
                __L1:r(
                    c,
                    19,
                    -66,
                    4,
                    3,
                    "#7a5232"
                )
                __L1:r(
                    c,
                    -6,
                    -74,
                    3,
                    6,
                    "rgba(255,255,255,.15)"
                )
            elseif hat == "preto" then
                __L1:r(
                    c,
                    -20,
                    -61,
                    41,
                    5,
                    "#14161a"
                )
                __L1:r(
                    c,
                    -19,
                    -65,
                    39,
                    5,
                    "#2a2d33"
                )
                __L1:r(
                    c,
                    -12,
                    -76,
                    27,
                    13,
                    "#14161a"
                )
                __L1:r(
                    c,
                    -10,
                    -76,
                    23,
                    10,
                    "#2e3138"
                )
                __L1:r(
                    c,
                    -11,
                    -67,
                    25,
                    4,
                    "#b8322c"
                )
                __L1:r(
                    c,
                    -5,
                    -73,
                    3,
                    3,
                    "#4a4e57"
                )
            elseif hat == "jaglion" then
                local tuft = __arrL({"#7a3a12", "#9a4a18", "#b85e20", "#c9702a"}, 4)
                local cx = 1
                local cy = -56
                do
                    local i = 0
                    while i < 20 do
                        local a = i / 20 * math.pi * 2
                        local mx = math.floor(math.cos(a) * 19 + 0.5) + cx
                        local my = math.floor(math.sin(a) * 18 + 0.5) + cy
                        __L1:r(
                            c,
                            mx - 6,
                            my - 6,
                            12,
                            12,
                            __L1.P.ink
                        )
                        i = i + 1
                    end
                end
                do
                    local i = 0
                    while i < 20 do
                        local a = i / 20 * math.pi * 2
                        local mx = math.floor(math.cos(a) * 18 + 0.5) + cx
                        local my = math.floor(math.sin(a) * 17 + 0.5) + cy
                        __L1:r(
                            c,
                            mx - 5,
                            my - 5,
                            10,
                            10,
                            __get(
                                tuft,
                                __mod(i, 2)
                            )
                        )
                        __L1:r(
                            c,
                            mx - 3,
                            my - 4,
                            4,
                            3,
                            __get(
                                tuft,
                                2 + __mod(i, 2)
                            )
                        )
                        i = i + 1
                    end
                end
                __L1:r(
                    c,
                    -17,
                    -45,
                    36,
                    9,
                    __L1.P.ink
                )
                __L1:r(
                    c,
                    -16,
                    -44,
                    34,
                    7,
                    "#9a4a18"
                )
                do
                    local x = -15
                    while x < 17 do
                        __L1:r(
                            c,
                            x,
                            -40 + __band(x / 5, 1),
                            4,
                            4,
                            "#b85e20"
                        )
                        x = x + 5
                    end
                end
                __L1:r(
                    c,
                    -15,
                    -44,
                    30,
                    2,
                    "#c9702a"
                )
                __L1:r(
                    c,
                    -15,
                    -80,
                    10,
                    9,
                    __L1.P.ink
                )
                __L1:r(
                    c,
                    -14,
                    -79,
                    8,
                    7,
                    "#e3a83f"
                )
                __L1:r(
                    c,
                    -12,
                    -77,
                    4,
                    4,
                    "#f6e0b0"
                )
                __L1:r(
                    c,
                    7,
                    -80,
                    10,
                    9,
                    __L1.P.ink
                )
                __L1:r(
                    c,
                    8,
                    -79,
                    8,
                    7,
                    "#e3a83f"
                )
                __L1:r(
                    c,
                    10,
                    -77,
                    4,
                    4,
                    "#f6e0b0"
                )
                __L1:r(
                    c,
                    -13,
                    -76,
                    28,
                    35,
                    __L1.P.ink
                )
                __L1:r(
                    c,
                    -12,
                    -75,
                    26,
                    33,
                    "#e3a83f"
                )
                __L1:r(
                    c,
                    -11,
                    -75,
                    24,
                    2,
                    "#f0c25a"
                )
                __L1:r(
                    c,
                    -13,
                    -60,
                    3,
                    16,
                    "#d39a36"
                )
                __L1:r(
                    c,
                    -9,
                    -58,
                    21,
                    16,
                    __L1.P.ink
                )
                __L1:r(
                    c,
                    -8,
                    -57,
                    19,
                    14,
                    skin
                )
                __L1:r(
                    c,
                    -8,
                    -54,
                    2,
                    9,
                    shadow
                )
                __L1:r(
                    c,
                    4,
                    -52,
                    3,
                    3,
                    "#302f2c"
                )
                __L1:r(
                    c,
                    1,
                    -54,
                    8,
                    1,
                    "#855b3d"
                )
                __L1:r(
                    c,
                    3,
                    -45,
                    7,
                    1,
                    "#8e5e43"
                )
                __L1:r(
                    c,
                    4,
                    -44,
                    5,
                    1,
                    "#e9b684"
                )
                __L1:r(
                    c,
                    12,
                    -52,
                    3,
                    5,
                    skin
                )
                __L1:r(
                    c,
                    -9,
                    -58,
                    3,
                    2,
                    __L1.P.ink
                )
                __L1:r(
                    c,
                    -9,
                    -58,
                    2,
                    3,
                    __L1.P.ink
                )
                __L1:r(
                    c,
                    10,
                    -58,
                    3,
                    2,
                    __L1.P.ink
                )
                __L1:r(
                    c,
                    11,
                    -58,
                    2,
                    3,
                    __L1.P.ink
                )
                __L1:r(
                    c,
                    -9,
                    -44,
                    2,
                    2,
                    __L1.P.ink
                )
                __L1:r(
                    c,
                    11,
                    -44,
                    2,
                    2,
                    __L1.P.ink
                )
                __L1:r(
                    c,
                    -7,
                    -74,
                    3,
                    3,
                    "#1e1410"
                )
                __L1:r(
                    c,
                    -6,
                    -74,
                    1,
                    1,
                    "#ffffff"
                )
                __L1:r(
                    c,
                    6,
                    -74,
                    3,
                    3,
                    "#1e1410"
                )
                __L1:r(
                    c,
                    7,
                    -74,
                    1,
                    1,
                    "#ffffff"
                )
                __L1:r(
                    c,
                    -8,
                    -76,
                    5,
                    1,
                    "#b8802a"
                )
                __L1:r(
                    c,
                    5,
                    -76,
                    5,
                    1,
                    "#b8802a"
                )
                __L1:r(
                    c,
                    -4,
                    -70,
                    12,
                    6,
                    "#f6e0b0"
                )
                __L1:r(
                    c,
                    -1,
                    -71,
                    6,
                    3,
                    "#6a2a1a"
                )
                __L1:r(
                    c,
                    0,
                    -72,
                    4,
                    1,
                    "#8a3a2a"
                )
                __L1:r(
                    c,
                    1,
                    -68,
                    2,
                    2,
                    "#6a2a1a"
                )
                __L1:r(
                    c,
                    -2,
                    -66,
                    2,
                    1,
                    "#6a2a1a"
                )
                __L1:r(
                    c,
                    4,
                    -66,
                    2,
                    1,
                    "#6a2a1a"
                )
                __L1:r(
                    c,
                    -3,
                    -69,
                    1,
                    1,
                    "#b8802a"
                )
                __L1:r(
                    c,
                    -3,
                    -67,
                    1,
                    1,
                    "#b8802a"
                )
                __L1:r(
                    c,
                    7,
                    -69,
                    1,
                    1,
                    "#b8802a"
                )
                __L1:r(
                    c,
                    7,
                    -67,
                    1,
                    1,
                    "#b8802a"
                )
            elseif hat == "dajegue" then
                local sw = math.floor(math.sin(frame * 2.2) + 0.5)
                for ____, ____value in __iterar((__arrL(
                    {
                        __arrL({-11, -1}, 2),
                        __arrL({6, 1}, 2)
                    },
                    2
                ))) do
                    local ex = ____value[1]
                    local tl = ____value[2]
                    __L1:r(
                        c,
                        ex - 1,
                        -100 + sw * tl,
                        10,
                        27,
                        __L1.P.ink
                    )
                    __L1:r(
                        c,
                        ex,
                        -99 + sw * tl,
                        8,
                        25,
                        "#8f887d"
                    )
                    __L1:r(
                        c,
                        ex + 2,
                        -95 + sw * tl,
                        4,
                        18,
                        "#e2aeb0"
                    )
                    __L1:r(
                        c,
                        ex,
                        -99 + sw * tl,
                        8,
                        4,
                        "#4a4139"
                    )
                end
                __L1:r(
                    c,
                    -13,
                    -77,
                    28,
                    36,
                    __L1.P.ink
                )
                __L1:r(
                    c,
                    -12,
                    -76,
                    26,
                    34,
                    "#8f887d"
                )
                __L1:r(
                    c,
                    -11,
                    -76,
                    24,
                    2,
                    "#aaa397"
                )
                __L1:r(
                    c,
                    -13,
                    -61,
                    3,
                    17,
                    "#7b746a"
                )
                do
                    local i = 0
                    while i < 6 do
                        __L1:r(
                            c,
                            -9 + i * 4,
                            -81 + __mod(i, 2),
                            4,
                            6,
                            "#3e352e"
                        )
                        i = i + 1
                    end
                end
                __L1:r(
                    c,
                    -15,
                    -74,
                    3,
                    22,
                    "#3e352e"
                )
                __L1:r(
                    c,
                    -9,
                    -58,
                    21,
                    16,
                    __L1.P.ink
                )
                __L1:r(
                    c,
                    -8,
                    -57,
                    19,
                    14,
                    skin
                )
                __L1:r(
                    c,
                    -8,
                    -54,
                    2,
                    9,
                    shadow
                )
                __L1:r(
                    c,
                    4,
                    -52,
                    3,
                    3,
                    "#302f2c"
                )
                __L1:r(
                    c,
                    1,
                    -54,
                    8,
                    1,
                    "#855b3d"
                )
                __L1:r(
                    c,
                    3,
                    -45,
                    7,
                    1,
                    "#8e5e43"
                )
                __L1:r(
                    c,
                    4,
                    -44,
                    5,
                    1,
                    "#e9b684"
                )
                __L1:r(
                    c,
                    12,
                    -52,
                    3,
                    5,
                    skin
                )
                __L1:r(
                    c,
                    -7,
                    -74,
                    3,
                    3,
                    "#1e1814"
                )
                __L1:r(
                    c,
                    -6,
                    -74,
                    1,
                    1,
                    "#ffffff"
                )
                __L1:r(
                    c,
                    6,
                    -74,
                    3,
                    3,
                    "#1e1814"
                )
                __L1:r(
                    c,
                    7,
                    -74,
                    1,
                    1,
                    "#ffffff"
                )
                __L1:r(
                    c,
                    -5,
                    -70,
                    14,
                    7,
                    __L1.P.ink
                )
                __L1:r(
                    c,
                    -4,
                    -69,
                    12,
                    5,
                    "#d9d3c6"
                )
                __L1:r(
                    c,
                    -2,
                    -67,
                    2,
                    2,
                    "#4a4139"
                )
                __L1:r(
                    c,
                    4,
                    -67,
                    2,
                    2,
                    "#4a4139"
                )
                __L1:r(
                    c,
                    -3,
                    -64,
                    10,
                    1,
                    "#b8b0a2"
                )
            elseif hat == "caipira" then
                __L1:r(
                    c,
                    -22,
                    -61,
                    45,
                    5,
                    "#6e5335"
                )
                __L1:r(
                    c,
                    -21,
                    -65,
                    43,
                    5,
                    "#e2c070"
                )
                do
                    local x = -22
                    while x < 23 do
                        __L1:r(
                            c,
                            x,
                            -56,
                            2,
                            2 + __mod(x + 30, 2),
                            "#c9a24a"
                        )
                        x = x + 3
                    end
                end
                __L1:r(
                    c,
                    -11,
                    -75,
                    25,
                    12,
                    "#a98045"
                )
                __L1:r(
                    c,
                    -9,
                    -75,
                    21,
                    9,
                    "#e6c474"
                )
                __L1:r(
                    c,
                    -10,
                    -67,
                    23,
                    3,
                    "#c43a2e"
                )
                __L1:r(
                    c,
                    3,
                    -73,
                    6,
                    5,
                    "#b8902e"
                )
                __L1:r(
                    c,
                    4,
                    -72,
                    1,
                    1,
                    "#6e5335"
                )
                __L1:r(
                    c,
                    7,
                    -70,
                    1,
                    1,
                    "#6e5335"
                )
                __L1:r(
                    c,
                    -10,
                    -73,
                    5,
                    9,
                    "#f2c230"
                )
                __L1:r(
                    c,
                    -12,
                    -71,
                    9,
                    5,
                    "#f2c230"
                )
                __L1:r(
                    c,
                    -11,
                    -72,
                    7,
                    7,
                    "#e8a820"
                )
                __L1:r(
                    c,
                    -9,
                    -70,
                    3,
                    3,
                    "#6a3a12"
                )
                __L1:r(
                    c,
                    7,
                    -48,
                    1,
                    1,
                    "#6a3a22"
                )
                __L1:r(
                    c,
                    9,
                    -49,
                    1,
                    1,
                    "#6a3a22"
                )
                __L1:r(
                    c,
                    8,
                    -47,
                    1,
                    1,
                    "#6a3a22"
                )
                __L1:r(
                    c,
                    2,
                    -46,
                    8,
                    1,
                    "#3a2418"
                )
            end
            c:restore()
            if __t(lion) then
                local sw = math.floor(math.sin(frame * 3.5) * 2 + 0.5)
                local pts = __arrL(
                    {
                        __arrL({-13, -22}, 2),
                        __arrL({-19, -21}, 2),
                        __arrL({-24, -24 + sw}, 2),
                        __arrL({-27, -29 + sw}, 2),
                        __arrL({-28, -35 + sw * 2}, 2)
                    },
                    5
                )
                __L1:limb(c, pts, 6, __L1.P.ink)
                __L1:limb(c, pts, 3, "#d39a36")
                __L1:r(
                    c,
                    -33,
                    -44 + sw * 2,
                    10,
                    10,
                    __L1.P.ink
                )
                __L1:r(
                    c,
                    -32,
                    -43 + sw * 2,
                    8,
                    8,
                    "#7a3a12"
                )
                __L1:r(
                    c,
                    -30,
                    -43 + sw * 2,
                    3,
                    3,
                    "#9a4a18"
                )
            end
            if __t(jeg) then
                local sw = math.floor(math.sin(frame * 3) * 2 + 0.5)
                local pts = __arrL(
                    {
                        __arrL({-12, -22}, 2),
                        __arrL({-16, -18}, 2),
                        __arrL({-18, -11}, 2)
                    },
                    3
                )
                __L1:limb(c, pts, 5, __L1.P.ink)
                __L1:limb(c, pts, 2, "#7b746a")
                __L1:r(
                    c,
                    -22,
                    -13 + sw,
                    7,
                    9,
                    __L1.P.ink
                )
                __L1:r(
                    c,
                    -21,
                    -12 + sw,
                    5,
                    7,
                    "#3e352e"
                )
            end
            c:save()
            local ____c_653 = c
            local ____c_translate_654 = c.translate
            local ____t_result_651
            if __t(moving) then
                ____t_result_651 = math.floor(-walk * 2 + 0.5)
            else
                ____t_result_651 = 0
            end
            local ____t_result_652
            if __t(moving) then
                ____t_result_652 = math.floor(math.abs(walk) * 2 + 0.5)
            else
                ____t_result_652 = __t(flight) and -2 or 0
            end
            ____c_translate_654(____c_653, ____t_result_651, ____t_result_652)
            __L1:r(
                c,
                -17,
                -37,
                5,
                18,
                "#5f6041"
            )
            __L1:r(
                c,
                -20,
                -35,
                6,
                15,
                "#8d814a"
            )
            __L1:r(
                c,
                -19,
                -33,
                3,
                7,
                "#b1a262"
            )
            c:restore()
            __L1:r(
                c,
                3,
                -36,
                5,
                3,
                "#f4cf81"
            )
            __L1:r(
                c,
                -4,
                -20,
                8,
                3,
                "#b5814a"
            )
            local ____L1_r_661 = __L1.r
            local ____array_660 = __TS__SparseArrayNew(
                c,
                -9,
                -28,
                7,
                2
            )
            local ____t_result_659
            if __t(lion) then
                ____t_result_659 = "#b8802a"
            else
                local ____t_658 = __t
                local ____opt_result_657
                if LK ~= nil then
                    ____opt_result_657 = LK.shirt
                end
                ____t_result_659 = ____t_658(____opt_result_657) and "rgba(0,0,0,.22)" or "#bd7135"
            end
            __TS__SparseArrayPush(____array_660, ____t_result_659)
            ____L1_r_661(
                __L1,
                __TS__SparseArraySpread(____array_660)
            )
            local ____L1_r_671 = __L1.r
            local ____c_669 = c
            local ____temp_670 = -30
            local ____t_result_668
            if __t(lion) then
                ____t_result_668 = "#f6d68b"
            else
                local ____t_result_667
                local ____t_666 = __t
                local ____t_result_665
                if __t(trajeLuz) then
                    ____t_result_665 = trajeLuz
                else
                    local ____opt_result_664
                    if LK ~= nil then
                        ____opt_result_664 = LK.shirtLight
                    end
                    ____t_result_665 = ____opt_result_664
                end
                __O[257] = ____t_result_665
                if ____t_666(____t_result_665) then
                    ____t_result_667 = __O[257]
                else
                    ____t_result_667 = "#f0ab59"
                end
                ____t_result_668 = ____t_result_667
            end
            ____L1_r_671(
                __L1,
                ____c_669,
                4,
                ____temp_670,
                6,
                2,
                ____t_result_668
            )
            __L1:r(
                c,
                -11,
                -21,
                23,
                4,
                "#6e5339"
            )
            __L1:r(
                c,
                -2,
                -22,
                6,
                5,
                "#d7bb72"
            )
            __L1:r(
                c,
                0,
                -21,
                2,
                3,
                "#6d573a"
            )
            if __t(jeg) then
                __L1:r(
                    c,
                    -7,
                    -36,
                    14,
                    14,
                    "#d9d3c6"
                )
                __L1:r(
                    c,
                    -6,
                    -36,
                    12,
                    1,
                    "#ece8de"
                )
            end
            if __t(far) then
                __L1:r(
                    c,
                    2,
                    -38,
                    4,
                    17,
                    "#1f3a7a"
                )
                __L1:r(
                    c,
                    3,
                    -38,
                    1,
                    17,
                    "#2e4f98"
                )
                __L1:r(
                    c,
                    -11,
                    -38,
                    23,
                    2,
                    "#ffffff"
                )
                __L1:r(
                    c,
                    -8,
                    -35,
                    5,
                    5,
                    "#1f3a7a"
                )
                __L1:r(
                    c,
                    -7,
                    -34,
                    3,
                    3,
                    "#f2d36a"
                )
            end
            if __t(cai) then
                do
                    local y = -36
                    while y < -22 do
                        __L1:r(
                            c,
                            -11,
                            y,
                            23,
                            1,
                            "#f2e6d6"
                        )
                        y = y + 5
                    end
                end
                do
                    local x = -9
                    while x < 12 do
                        __L1:r(
                            c,
                            x,
                            -38,
                            1,
                            17,
                            "#f2e6d6"
                        )
                        x = x + 5
                    end
                end
                __L1:poly(
                    c,
                    __arrL(
                        {
                            __arrL({-7, -40}, 2),
                            __arrL({9, -40}, 2),
                            __arrL({1, -31}, 2)
                        },
                        3
                    ),
                    __L1.P.ink
                )
                __L1:poly(
                    c,
                    __arrL(
                        {
                            __arrL({-6, -40}, 2),
                            __arrL({8, -40}, 2),
                            __arrL({1, -32}, 2)
                        },
                        3
                    ),
                    "#d8342a"
                )
                __L1:r(
                    c,
                    -2,
                    -38,
                    1,
                    1,
                    "#fff"
                )
                __L1:r(
                    c,
                    3,
                    -38,
                    1,
                    1,
                    "#fff"
                )
                __L1:r(
                    c,
                    1,
                    -35,
                    1,
                    1,
                    "#fff"
                )
            end
        elseif ____type == "reeis" then
            local ____t_675 = __t
            local ____t_result_674
            local ____t_673 = __t
            local ____t_result_672
            if __t(o.transformed) then
                ____t_result_672 = o.transformed
            else
                ____t_result_672 = o.powered
            end
            __O[258] = ____t_result_672
            if ____t_673(____t_result_672) then
                ____t_result_674 = __O[258]
            else
                ____t_result_674 = o.charging
            end
            if ____t_675(____t_result_674) then
                c:save()
                if __t(o.charging) then
                    c.globalAlpha = c.globalAlpha * (0.7 + math.sin(frame * 18) * 0.15)
                end
                local crown = __arrL(
                    {
                        __arrL({-15, -60}, 2),
                        __arrL({-22, -75}, 2),
                        __arrL({-12, -71}, 2),
                        __arrL({-10, -84}, 2),
                        __arrL({-3, -75}, 2),
                        __arrL({4, -88}, 2),
                        __arrL({9, -73}, 2),
                        __arrL({20, -80}, 2),
                        __arrL({16, -65}, 2),
                        __arrL({20, -59}, 2)
                    },
                    10
                )
                __L1:poly(c, crown, "#c68125")
                __L1:poly(
                    c,
                    __arrL(
                        {
                            __arrL({-12, -62}, 2),
                            __arrL({-17, -72}, 2),
                            __arrL({-10, -68}, 2),
                            __arrL({-8, -78}, 2),
                            __arrL({-2, -70}, 2),
                            __arrL({4, -81}, 2),
                            __arrL({8, -68}, 2),
                            __arrL({16, -75}, 2),
                            __arrL({12, -63}, 2)
                        },
                        9
                    ),
                    "#ffda46"
                )
                __L1:r(
                    c,
                    -7,
                    -74,
                    2,
                    5,
                    "#fff2a3"
                )
                __L1:r(
                    c,
                    2,
                    -79,
                    2,
                    6,
                    "#fff4b7"
                )
                __L1:r(
                    c,
                    11,
                    -71,
                    2,
                    4,
                    "#fff0a1"
                )
                c:restore()
            end
            __L1:r(
                c,
                -12,
                -61,
                25,
                8,
                "#252b2b"
            )
            do
                local i = 0
                while i < 6 do
                    __L1:r(
                        c,
                        -11 + i * 4,
                        -63 + __mod(i, 2),
                        4,
                        4,
                        "#232b29"
                    )
                    i = i + 1
                end
            end
            __L1:r(
                c,
                -12,
                -55,
                4,
                5,
                "#252b2b"
            )
            __L1:r(
                c,
                -4,
                -37,
                10,
                3,
                "#d3b362"
            )
            __L1:r(
                c,
                0,
                -36,
                3,
                10,
                "#d3b362"
            )
            __L1:r(
                c,
                -2,
                -28,
                7,
                4,
                "#e7cb73"
            )
            if __t(o.transformed) then
                c:save()
                local ____c_678 = c
                local ____c_translate_679 = c.translate
                local ____t_result_676
                if __t(attackOn) then
                    ____t_result_676 = -math.floor(strike * 4 + 0.5)
                else
                    ____t_result_676 = 0
                end
                local ____t_result_677
                if __t(attackOn) then
                    ____t_result_677 = -math.floor(strike * 2 + 0.5)
                else
                    ____t_result_677 = 0
                end
                ____c_translate_679(____c_678, ____t_result_676, ____t_result_677)
                __L1:r(
                    c,
                    19,
                    -30,
                    33,
                    8,
                    "#242e30"
                )
                __L1:r(
                    c,
                    24,
                    -22,
                    9,
                    13,
                    "#293334"
                )
                __L1:r(
                    c,
                    21,
                    -33,
                    26,
                    3,
                    "#83918a"
                )
                __L1:r(
                    c,
                    47,
                    -29,
                    7,
                    5,
                    "#56635e"
                )
                __L1:r(
                    c,
                    17,
                    -23,
                    8,
                    5,
                    skin
                )
                local ____t_683 = __t
                local ____t_result_682
                local ____t_681 = __t
                local ____t_result_680
                if __t(attackOn) then
                    ____t_result_680 = progress > 0.34
                else
                    ____t_result_680 = attackOn
                end
                __O[259] = ____t_result_680
                if ____t_681(____t_result_680) then
                    ____t_result_682 = progress < 0.56
                else
                    ____t_result_682 = __O[259]
                end
                if ____t_683(____t_result_682) then
                    __L1:poly(
                        c,
                        __arrL(
                            {
                                __arrL({55, -30}, 2),
                                __arrL({63, -35}, 2),
                                __arrL({61, -29}, 2),
                                __arrL({68, -27}, 2),
                                __arrL({61, -24}, 2),
                                __arrL({63, -19}, 2),
                                __arrL({55, -23}, 2)
                            },
                            7
                        ),
                        "#f4d392"
                    )
                    __L1:r(
                        c,
                        54,
                        -28,
                        7,
                        3,
                        "#fff0ba"
                    )
                end
                c:restore()
            end
            local ____t_685 = __t
            local ____t_result_684
            if __t(o.powered) then
                ____t_result_684 = o.powered
            else
                ____t_result_684 = o.charging
            end
            if ____t_685(____t_result_684) then
                __L1:r(
                    c,
                    -9,
                    -51,
                    2,
                    7,
                    "#b78c50"
                )
                __L1:r(
                    c,
                    2,
                    -61,
                    8,
                    2,
                    "#a88f54"
                )
                __L1:r(
                    c,
                    16,
                    -38,
                    3,
                    9,
                    "#d2ac62"
                )
            end
        elseif ____type == "nikolas" then
            __L1:r(
                c,
                -12,
                -63,
                25,
                10,
                "#353334"
            )
            __L1:r(
                c,
                -6,
                -66,
                20,
                5,
                "#353334"
            )
            __L1:r(
                c,
                8,
                -61,
                8,
                6,
                "#353334"
            )
            __L1:r(
                c,
                -13,
                -55,
                5,
                9,
                "#353334"
            )
            __L1:r(
                c,
                0,
                -53,
                8,
                2,
                "#463835"
            )
            local noseX = o.view == "front" and 4 or 18
            __L1:oval(
                c,
                noseX,
                -49,
                10,
                8,
                "#6c4638",
                2
            )
            __L1:oval(
                c,
                noseX,
                -50,
                8,
                6,
                "#edbd94",
                2
            )
            __L1:r(
                c,
                noseX - 3,
                -55,
                7,
                2,
                "#ffdbb3"
            )
            __L1:r(
                c,
                noseX + 3,
                -51,
                2,
                3,
                "#d69c77"
            )
            __L1:r(
                c,
                noseX - 4,
                -46,
                3,
                2,
                "#b77c5e"
            )
            __L1:r(
                c,
                noseX + 2,
                -46,
                3,
                2,
                "#b77c5e"
            )
            if __t(noseRubbing) then
                __L1:r(
                    c,
                    __get(frontHand, 0) - 3,
                    __get(frontHand, 1) - 3,
                    6,
                    6,
                    skin
                )
                __L1:r(
                    c,
                    __get(frontHand, 0),
                    __get(frontHand, 1) - 2,
                    2,
                    1,
                    "#f3c79f"
                )
                __L1:r(
                    c,
                    noseX + 5,
                    -43,
                    3,
                    3,
                    "#a4b56a"
                )
            end
            __L1:r(
                c,
                -6,
                -35,
                15,
                3,
                "#b798b4"
            )
            if o.emotion == "friend" then
                __L1:limb(
                    c,
                    __arrL(
                        {
                            __arrL({1, -43}, 2),
                            __arrL({5, -41}, 2),
                            __arrL({10, -43}, 2)
                        },
                        3
                    ),
                    1,
                    "#80543d"
                )
                __L1:r(
                    c,
                    2,
                    -54,
                    6,
                    1,
                    "#73503a"
                )
            elseif o.emotion == "greed" then
                __L1:r(
                    c,
                    -1,
                    -56,
                    9,
                    2,
                    "#463835"
                )
                __L1:r(
                    c,
                    1,
                    -43,
                    12,
                    4,
                    "#654233"
                )
                __L1:r(
                    c,
                    3,
                    -43,
                    8,
                    2,
                    "#fff0c9"
                )
                __L1:r(
                    c,
                    6,
                    -40,
                    5,
                    1,
                    "#edb89a"
                )
            elseif o.emotion == "sad" then
                __L1:limb(
                    c,
                    __arrL(
                        {
                            __arrL({0, -53}, 2),
                            __arrL({4, -55}, 2),
                            __arrL({8, -54}, 2)
                        },
                        3
                    ),
                    2,
                    "#463835"
                )
                __L1:limb(
                    c,
                    __arrL(
                        {
                            __arrL({1, -41}, 2),
                            __arrL({6, -43}, 2),
                            __arrL({10, -41}, 2)
                        },
                        3
                    ),
                    1,
                    "#80543d"
                )
                __L1:r(
                    c,
                    7,
                    -48,
                    2,
                    3,
                    "#c4d9d1"
                )
            elseif o.emotion == "taunted" then
                __L1:limb(
                    c,
                    __arrL(
                        {
                            __arrL({0, -55}, 2),
                            __arrL({8, -52}, 2)
                        },
                        2
                    ),
                    2,
                    "#463835"
                )
                __L1:r(
                    c,
                    1,
                    -43,
                    11,
                    3,
                    "#714738"
                )
                __L1:r(
                    c,
                    3,
                    -43,
                    7,
                    1,
                    "#fff0cb"
                )
            end
        elseif ____type == "menezes" then
            __L1:r(
                c,
                -13,
                -64,
                29,
                12,
                "#252b2c"
            )
            do
                local i = 0
                while i < 7 do
                    __L1:oval(
                        c,
                        -10 + i * 4,
                        -64 - __mod(i, 2) * 2,
                        4,
                        4,
                        __t(__mod(i, 2)) and "#242a2b" or "#333b38",
                        2
                    )
                    i = i + 1
                end
            end
            __L1:r(
                c,
                -13,
                -56,
                5,
                9,
                "#252b2c"
            )
            __L1:r(
                c,
                11,
                -57,
                4,
                7,
                "#252b2c"
            )
            __L1:r(
                c,
                -7,
                -55,
                11,
                7,
                "#25383d"
            )
            __L1:r(
                c,
                6,
                -55,
                11,
                7,
                "#25383d"
            )
            __L1:r(
                c,
                -5,
                -53,
                7,
                3,
                "#b4c9cc"
            )
            __L1:r(
                c,
                8,
                -53,
                7,
                3,
                "#b4c9cc"
            )
            __L1:r(
                c,
                3,
                -53,
                4,
                2,
                "#25383d"
            )
            __L1:r(
                c,
                -1,
                -53,
                2,
                3,
                "#3d342b"
            )
            __L1:r(
                c,
                11,
                -53,
                2,
                3,
                "#3d342b"
            )
            __L1:r(
                c,
                -6,
                -54,
                4,
                1,
                "#f4efe0"
            )
            __L1:r(
                c,
                8,
                -54,
                4,
                1,
                "#f4efe0"
            )
            __L1:r(
                c,
                -1,
                -37,
                2,
                18,
                "#c0d1ca"
            )
            __L1:r(
                c,
                -7,
                -22,
                16,
                2,
                "#435b62"
            )
            __L1:r(
                c,
                -6,
                -33,
                4,
                4,
                "#a8b8a0"
            )
            __L1:r(
                c,
                4,
                -33,
                4,
                4,
                "#a8b8a0"
            )
            __L1:r(
                c,
                -2,
                -31,
                6,
                4,
                "#a8b8a0"
            )
            __L1:r(
                c,
                -1,
                -30,
                1,
                1,
                "#3c4b45"
            )
            __L1:r(
                c,
                3,
                -30,
                1,
                1,
                "#3c4b45"
            )
            if __t(attackOn) then
                __L1:r(
                    c,
                    0,
                    -44,
                    12,
                    4 + math.floor(strike * 3 + 0.5),
                    "#513a35"
                )
                __L1:r(
                    c,
                    2,
                    -44,
                    8,
                    2,
                    "#eee2c8"
                )
                do
                    local i = 0
                    while i < 3 do
                        __L1:r(
                            c,
                            20 + i * 5,
                            -46 + i * 3,
                            3,
                            2,
                            "#cab1cd"
                        )
                        i = i + 1
                    end
                end
            else
                __L1:r(
                    c,
                    3,
                    -43,
                    8,
                    1,
                    "#6a4738"
                )
            end
        elseif ____type == "caleb" then
            __L1:r(
                c,
                -11,
                -62,
                24,
                8,
                "#b78b43"
            )
            __L1:r(
                c,
                -9,
                -65,
                18,
                5,
                "#e4bc62"
            )
            __L1:r(
                c,
                -6,
                -67,
                12,
                3,
                "#f3d584"
            )
            __L1:r(
                c,
                -9,
                -58,
                5,
                5,
                "#d2a54f"
            )
            __L1:r(
                c,
                1,
                -62,
                10,
                3,
                "#f6d78b"
            )
            __L1:r(
                c,
                2,
                -52,
                7,
                4,
                "#eddfbf"
            )
            __L1:r(
                c,
                5,
                -52,
                3,
                4,
                "#80522e"
            )
            __L1:r(
                c,
                6,
                -51,
                1,
                2,
                "#392c27"
            )
            __L1:r(
                c,
                2,
                -54,
                8,
                2,
                "#a47c3e"
            )
            __L1:r(
                c,
                -8,
                -44,
                19,
                3,
                "#8f6942"
            )
            __L1:r(
                c,
                7,
                -48,
                3,
                2,
                "#46372f"
            )
        elseif ____type == "lucas" then
            __L1:r(
                c,
                -12,
                -63,
                25,
                8,
                "#242c30"
            )
            __L1:r(
                c,
                -8,
                -66,
                18,
                5,
                "#242c30"
            )
            __L1:r(
                c,
                -12,
                -58,
                5,
                7,
                "#242c30"
            )
            __L1:r(
                c,
                9,
                -58,
                5,
                5,
                "#30383a"
            )
            __L1:r(
                c,
                -7,
                -61,
                9,
                2,
                "#4b5456"
            )
            __L1:r(
                c,
                -10,
                -37,
                7,
                20,
                "#a8afae"
            )
            __L1:r(
                c,
                6,
                -37,
                7,
                20,
                "#7f8b8e"
            )
            __L1:r(
                c,
                -3,
                -37,
                8,
                19,
                "#e4e7dd"
            )
            __L1:r(
                c,
                0,
                -36,
                2,
                17,
                "#526473"
            )
            __L1:r(
                c,
                -10,
                -20,
                7,
                2,
                "#6f7d81"
            )
            __L1:r(
                c,
                7,
                -20,
                6,
                2,
                "#576a75"
            )
            __L1:r(
                c,
                3,
                -44,
                7,
                1,
                "#9e6f55"
            )
        elseif ____type == "mota" then
            __L1:r(
                c,
                -12,
                -63,
                26,
                9,
                "#a57832"
            )
            __L1:r(
                c,
                -10,
                -65,
                23,
                7,
                "#e3b64e"
            )
            __L1:r(
                c,
                -7,
                -68,
                17,
                5,
                "#edc966"
            )
            __L1:r(
                c,
                -3,
                -70,
                12,
                3,
                "#f6da84"
            )
            __L1:r(
                c,
                2,
                -65,
                12,
                3,
                "#f9e49a"
            )
            __L1:r(
                c,
                -11,
                -56,
                4,
                7,
                "#c19740"
            )
            __L1:r(
                c,
                -9,
                -61,
                4,
                5,
                "#e3b64e"
            )
            __L1:r(
                c,
                2,
                -43,
                9,
                2,
                "#7a5239"
            )
            __L1:r(
                c,
                1,
                -42,
                7,
                1,
                "#edcfad"
            )
            __L1:r(
                c,
                -8,
                -38,
                18,
                3,
                "#edf0e5"
            )
            __L1:r(
                c,
                -5,
                -34,
                2,
                14,
                "#f6f4e6"
            )
            __L1:r(
                c,
                5,
                -34,
                2,
                14,
                "#f6f4e6"
            )
            __L1:r(
                c,
                -1,
                -32,
                3,
                8,
                "#d8e6e4"
            )
            __L1:r(
                c,
                2,
                -32,
                3,
                8,
                "#d8e6e4"
            )
            __L1:r(
                c,
                -7,
                -19,
                15,
                3,
                "#133154"
            )
            __L1:football(
                c,
                -22,
                -10 + math.floor(math.sin(frame * 2) * 2 + 0.5),
                9
            )
        elseif ____type == "ravid" then
            __L1:r(
                c,
                -11,
                -62,
                25,
                9,
                "#5b4938"
            )
            __L1:r(
                c,
                -8,
                -65,
                20,
                5,
                "#5b4938"
            )
            __L1:r(
                c,
                -11,
                -56,
                5,
                8,
                "#5b4938"
            )
            __L1:r(
                c,
                -6,
                -37,
                15,
                5,
                "#c1c7ae"
            )
            __L1:r(
                c,
                6,
                -49,
                9,
                3,
                "#353c38"
            )
            __L1:r(
                c,
                0,
                -49,
                4,
                3,
                "#353c38"
            )
            __L1:r(
                c,
                4,
                -48,
                3,
                1,
                "#353c38"
            )
            local ____t_687 = __t
            local ____t_result_686
            if __t(o.talking) then
                ____t_result_686 = o.talking
            else
                ____t_result_686 = math.sin(frame * 5) > 0
            end
            if ____t_687(____t_result_686) then
                __L1:r(
                    c,
                    5,
                    -44,
                    7,
                    math.sin(frame * 11) > 0 and 4 or 2,
                    "#4e3c32"
                )
                __L1:r(
                    c,
                    7,
                    -44,
                    3,
                    1,
                    "#e4c7a0"
                )
            end
            local ____t_689 = __t
            local ____t_result_688
            if __t(o.talking) then
                ____t_result_688 = o.talking
            else
                ____t_result_688 = not __t(moving)
            end
            if ____t_689(____t_result_688) then
                __L1:r(
                    c,
                    __get(frontHand, 0) + 2,
                    __get(frontHand, 1) - 5,
                    2,
                    5,
                    skin
                )
                __L1:r(
                    c,
                    __get(frontHand, 0) + 3,
                    __get(frontHand, 1) - 7,
                    4,
                    2,
                    skin
                )
            end
        elseif ____type == "marco" then
            __L1:r(
                c,
                -12,
                -63,
                26,
                8,
                "#1c2429"
            )
            __L1:r(
                c,
                -9,
                -65,
                21,
                4,
                "#1c2429"
            )
            __L1:r(
                c,
                -12,
                -58,
                4,
                8,
                "#1c2429"
            )
            __L1:r(
                c,
                11,
                -59,
                3,
                6,
                "#1c2429"
            )
            __L1:r(
                c,
                -7,
                -62,
                13,
                1,
                "#424b4b"
            )
            __L1:r(
                c,
                3,
                -53,
                8,
                2,
                __t(o.angry) and "#9c3f45" or "#473a36"
            )
            local ____L1_r_694 = __L1.r
            local ____c_692 = c
            local ____temp_693 = -50
            local ____t_691 = __t
            local ____t_result_690
            if __t(o.angry) then
                ____t_result_690 = o.angry
            else
                ____t_result_690 = o.rage
            end
            ____L1_r_694(
                __L1,
                ____c_692,
                5,
                ____temp_693,
                3,
                2,
                ____t_691(____t_result_690) and "#ff302f" or "#3a3039"
            )
            local ____t_696 = __t
            local ____t_result_695
            if __t(o.angry) then
                ____t_result_695 = o.angry
            else
                ____t_result_695 = o.rage
            end
            if ____t_696(____t_result_695) then
                __L1:r(
                    c,
                    3,
                    -53,
                    8,
                    3,
                    "#ff392f"
                )
                __L1:r(
                    c,
                    5,
                    -52,
                    3,
                    1,
                    "#ffd1a2"
                )
                __L1:r(
                    c,
                    -6,
                    -53,
                    5,
                    3,
                    "#ec312f"
                )
            end
            __L1:r(
                c,
                -9,
                -41,
                20,
                5,
                "#151f26"
            )
            __L1:r(
                c,
                -6,
                -39,
                14,
                4,
                "#3b4446"
            )
            __L1:r(
                c,
                -5,
                -36,
                2,
                12,
                "#c2c6bb"
            )
            __L1:r(
                c,
                6,
                -36,
                2,
                11,
                "#c2c6bb"
            )
            __L1:r(
                c,
                -8,
                -22,
                18,
                3,
                "#141f25"
            )
            __L1:r(
                c,
                -3,
                -32,
                8,
                6,
                "#747d75"
            )
            __L1:r(
                c,
                -5,
                -34,
                3,
                4,
                "#747d75"
            )
            __L1:r(
                c,
                4,
                -34,
                3,
                4,
                "#747d75"
            )
            __L1:r(
                c,
                -1,
                -30,
                2,
                2,
                "#1c2429"
            )
            __L1:r(
                c,
                3,
                -30,
                2,
                2,
                "#1c2429"
            )
            __L1:r(
                c,
                14,
                -31,
                21,
                22,
                "#292a35"
            )
            __L1:r(
                c,
                16,
                -29,
                17,
                18,
                "#dccca9"
            )
            __L1:r(
                c,
                17,
                -27,
                2,
                14,
                "#7b6a65"
            )
            __L1:r(
                c,
                20,
                -25,
                9,
                2,
                "#8d7e7c"
            )
            __L1:r(
                c,
                22,
                -22,
                6,
                2,
                "#8d7e7c"
            )
            __L1:r(
                c,
                21,
                -20,
                10,
                2,
                "#8d7e7c"
            )
            __L1:r(
                c,
                24,
                -24,
                2,
                7,
                "#5d4d69"
            )
            __L1:r(
                c,
                13,
                -22,
                5,
                5,
                skin
            )
            if __t(attackOn) then
                c:save()
                c:translate(
                    math.floor(strike * 3 + 0.5),
                    -math.floor(strike * 6 + 0.5)
                )
                __L1:poly(
                    c,
                    __arrL(
                        {
                            __arrL({23, -37}, 2),
                            __arrL({36, -52}, 2),
                            __arrL({39, -49}, 2),
                            __arrL({26, -34}, 2)
                        },
                        4
                    ),
                    "#e4b861"
                )
                __L1:poly(
                    c,
                    __arrL(
                        {
                            __arrL({36, -52}, 2),
                            __arrL({41, -55}, 2),
                            __arrL({39, -49}, 2)
                        },
                        3
                    ),
                    "#e4d3ad"
                )
                __L1:r(
                    c,
                    39,
                    -55,
                    2,
                    2,
                    "#302c35"
                )
                local ink = __t(o.angry) and "#e67c68" or "#b59ac6"
                do
                    local i = 0
                    while i < 5 do
                        local xx = 34 + i * 5
                        local yy = -41 - math.floor(math.sin(frame * 7 + i) * 8 + 0.5)
                        __L1:r(
                            c,
                            xx,
                            yy,
                            4,
                            2,
                            ink
                        )
                        __L1:r(
                            c,
                            xx + 2,
                            yy - 3,
                            2,
                            5,
                            ink
                        )
                        i = i + 1
                    end
                end
                __L1:r(
                    c,
                    24,
                    -24,
                    5,
                    2,
                    ink
                )
                __L1:r(
                    c,
                    27,
                    -21,
                    3,
                    2,
                    ink
                )
                c:restore()
            else
                __L1:poly(
                    c,
                    __arrL(
                        {
                            __arrL({-15, -32}, 2),
                            __arrL({-13, -34}, 2),
                            __arrL({-3, -21}, 2),
                            __arrL({-5, -19}, 2)
                        },
                        4
                    ),
                    "#d5ac57"
                )
                __L1:r(
                    c,
                    -16,
                    -35,
                    3,
                    4,
                    "#a96c70"
                )
            end
        elseif ____type == "kaua" then
            __L1:r(
                c,
                -12,
                -62,
                25,
                8,
                "#694b36"
            )
            __L1:r(
                c,
                -9,
                -65,
                21,
                5,
                "#946a43"
            )
            __L1:r(
                c,
                -7,
                -67,
                10,
                4,
                "#bb8c51"
            )
            __L1:r(
                c,
                -10,
                -58,
                4,
                6,
                "#694b36"
            )
            __L1:r(
                c,
                -11,
                -54,
                26,
                7,
                "#363c3a"
            )
            __L1:r(
                c,
                -8,
                -53,
                8,
                5,
                "#95bcb0"
            )
            __L1:r(
                c,
                5,
                -53,
                8,
                5,
                "#95bcb0"
            )
            __L1:r(
                c,
                -6,
                -53,
                2,
                2,
                "#e4e7c4"
            )
            __L1:r(
                c,
                7,
                -53,
                2,
                2,
                "#e4e7c4"
            )
            __L1:r(
                c,
                0,
                -52,
                5,
                2,
                "#c4a773"
            )
            __L1:r(
                c,
                -8,
                -37,
                3,
                9,
                "#ba925d"
            )
            __L1:r(
                c,
                7,
                -37,
                3,
                9,
                "#ba925d"
            )
            __L1:r(
                c,
                -8,
                -29,
                19,
                14,
                "#a47d50"
            )
            __L1:r(
                c,
                -6,
                -27,
                15,
                9,
                "#bd9863"
            )
            __L1:r(
                c,
                -2,
                -25,
                9,
                5,
                "#7b6448"
            )
            __L1:r(
                c,
                0,
                -29,
                2,
                8,
                "#e2ba62"
            )
            __L1:r(
                c,
                3,
                -27,
                2,
                6,
                "#c78479"
            )
            __L1:r(
                c,
                -8,
                -17,
                20,
                3,
                "#674f3a"
            )
            c:save()
            local ____c_699 = c
            local ____c_translate_700 = c.translate
            local ____t_result_697
            if __t(attackOn) then
                ____t_result_697 = -math.floor(strike * 5 + 0.5)
            else
                ____t_result_697 = 0
            end
            local ____t_result_698
            if __t(attackOn) then
                ____t_result_698 = -math.floor(strike * 2 + 0.5)
            else
                ____t_result_698 = 0
            end
            ____c_translate_700(____c_699, ____t_result_697, ____t_result_698)
            __L1:r(
                c,
                15,
                -33,
                37,
                11,
                "#3e4c43"
            )
            __L1:r(
                c,
                18,
                -31,
                31,
                7,
                "#ceaf69"
            )
            do
                local i = 0
                while i < 6 do
                    __L1:r(
                        c,
                        20 + i * 5,
                        -31,
                        1,
                        __t(__mod(i, 2)) and 3 or 5,
                        "#705a3b"
                    )
                    i = i + 1
                end
            end
            __L1:r(
                c,
                21,
                -22,
                8,
                10,
                "#936c47"
            )
            __L1:r(
                c,
                24,
                -12,
                7,
                3,
                "#5b503c"
            )
            __L1:r(
                c,
                36,
                -40,
                11,
                8,
                "#414b43"
            )
            __L1:r(
                c,
                38,
                -39,
                7,
                6,
                "#d29392"
            )
            __L1:r(
                c,
                39,
                -39,
                5,
                2,
                "#ebbcaa"
            )
            __L1:r(
                c,
                50,
                -30,
                14,
                5,
                "#e2ba66"
            )
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({64, -30}, 2),
                        __arrL({71, -28}, 2),
                        __arrL({64, -25}, 2)
                    },
                    3
                ),
                "#eee1b7"
            )
            __L1:r(
                c,
                69,
                -29,
                3,
                2,
                "#3d4140"
            )
            __L1:r(
                c,
                15,
                -25,
                7,
                5,
                skin
            )
            __L1:r(
                c,
                31,
                -34,
                4,
                5,
                "#89ada0"
            )
            c:restore()
        elseif ____type == "almiro" then
            __L1:oval(
                c,
                0,
                -60,
                13,
                12,
                __L1.P.ink,
                2
            )
            __L1:oval(
                c,
                0,
                -60,
                11,
                10,
                skin,
                2
            )
            __L1:r(
                c,
                -8,
                -63,
                3,
                9,
                shadow
            )
            __L1:r(
                c,
                -4,
                -69,
                9,
                2,
                "#d7a77a"
            )
            __L1:r(
                c,
                -2,
                -68,
                8,
                2,
                "#e7bd8d"
            )
            local glint = math.sin(frame * 4.2)
            local glintX = 4 + math.floor(math.sin(frame * 2) * 2 + 0.5)
            local glintY = -69
            __L1:r(
                c,
                glintX - 4,
                glintY,
                9,
                2,
                "#fff2c8"
            )
            __L1:r(
                c,
                glintX,
                glintY - 4,
                2,
                9,
                "#fff2c8"
            )
            __L1:r(
                c,
                glintX,
                glintY,
                2,
                2,
                "#ffffff"
            )
            if glint > 0.25 then
                __L1:r(
                    c,
                    glintX + 6,
                    glintY - 5,
                    2,
                    2,
                    "#fff9e0"
                )
                __L1:r(
                    c,
                    glintX - 6,
                    glintY + 4,
                    2,
                    2,
                    "#fff0bc"
                )
            end
            __L1:r(
                c,
                -1,
                -55,
                16,
                8,
                skin
            )
            __L1:r(
                c,
                -1,
                -54,
                6,
                1,
                "#6e5038"
            )
            __L1:r(
                c,
                8,
                -54,
                5,
                1,
                "#6e5038"
            )
            __L1:r(
                c,
                1,
                -52,
                2,
                3,
                "#343f35"
            )
            __L1:r(
                c,
                10,
                -52,
                2,
                3,
                "#343f35"
            )
            __L1:r(
                c,
                1,
                -45,
                12,
                3,
                "#5c473a"
            )
            __L1:r(
                c,
                3,
                -46,
                7,
                2,
                "#765644"
            )
            __L1:r(
                c,
                5,
                -42,
                4,
                2,
                "#8e6b51"
            )
            __L1:r(
                c,
                -2,
                -38,
                3,
                18,
                "#c6d0b7"
            )
            do
                local i = 0
                while i < 3 do
                    __L1:r(
                        c,
                        -1,
                        -34 + i * 5,
                        1,
                        1,
                        "#526d73"
                    )
                    i = i + 1
                end
            end
            __L1:r(
                c,
                5,
                -34,
                5,
                4,
                "#546f78"
            )
            __L1:r(
                c,
                7,
                -36,
                1,
                4,
                "#dedcb6"
            )
            c:save()
            c:translate(0, gesture)
            __L1:r(
                c,
                -20,
                -28,
                13,
                17,
                "#384f54"
            )
            __L1:r(
                c,
                -18,
                -26,
                9,
                13,
                "#c8c2a0"
            )
            __L1:r(
                c,
                -16,
                -23,
                5,
                1,
                "#7d8d80"
            )
            __L1:r(
                c,
                -16,
                -20,
                5,
                1,
                "#7d8d80"
            )
            c:restore()
            __L1:r(
                c,
                __get(frontHand, 0) + 2,
                __get(frontHand, 1) - 4,
                7,
                3,
                "#f1ead0"
            )
        elseif ____type == "miqueias" then
            __L1:r(
                c,
                -12,
                -63,
                26,
                10,
                "#8d482b"
            )
            __L1:r(
                c,
                -9,
                -66,
                20,
                5,
                "#b25e32"
            )
            __L1:r(
                c,
                -6,
                -68,
                12,
                3,
                "#d17c42"
            )
            __L1:r(
                c,
                -12,
                -58,
                5,
                12,
                "#91492a"
            )
            __L1:r(
                c,
                10,
                -58,
                4,
                10,
                "#91492a"
            )
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({-11, -47}, 2),
                        __arrL({14, -47}, 2),
                        __arrL({18, -40}, 2),
                        __arrL({15, -31}, 2),
                        __arrL({8, -25}, 2),
                        __arrL({-2, -26}, 2),
                        __arrL({-10, -33}, 2),
                        __arrL({-13, -41}, 2)
                    },
                    8
                ),
                "#753b25"
            )
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({-9, -45}, 2),
                        __arrL({13, -45}, 2),
                        __arrL({15, -39}, 2),
                        __arrL({12, -32}, 2),
                        __arrL({6, -28}, 2),
                        __arrL({-1, -29}, 2),
                        __arrL({-8, -35}, 2)
                    },
                    7
                ),
                "#b85d2c"
            )
            __L1:r(
                c,
                -6,
                -44,
                18,
                3,
                "#d7803d"
            )
            __L1:r(
                c,
                1,
                -44,
                9,
                2,
                "#f1c8a1"
            )
            do
                local i = 0
                while i < 5 do
                    __L1:r(
                        c,
                        -5 + i * 4,
                        -38 + __mod(i, 2) * 2,
                        2,
                        7,
                        "#d47e3d"
                    )
                    i = i + 1
                end
            end
            __L1:r(
                c,
                0,
                -31,
                6,
                3,
                "#e0964c"
            )
            __L1:r(
                c,
                -5,
                -55,
                11,
                7,
                "#303b3a"
            )
            __L1:r(
                c,
                6,
                -55,
                11,
                7,
                "#303b3a"
            )
            __L1:r(
                c,
                -3,
                -53,
                6,
                3,
                "#cadce0"
            )
            __L1:r(
                c,
                8,
                -53,
                6,
                3,
                "#cadce0"
            )
            __L1:r(
                c,
                1,
                -53,
                2,
                3,
                "#514235"
            )
            __L1:r(
                c,
                11,
                -53,
                2,
                3,
                "#514235"
            )
            __L1:r(
                c,
                4,
                -53,
                3,
                2,
                "#303b3a"
            )
            __L1:r(
                c,
                -1,
                -54,
                3,
                1,
                "#f6f4e5"
            )
            __L1:r(
                c,
                9,
                -54,
                3,
                1,
                "#f6f4e5"
            )
            __L1:r(
                c,
                -12,
                -30,
                29,
                2,
                "#90a99a"
            )
            __L1:r(
                c,
                -10,
                -23,
                25,
                2,
                "#8aa398"
            )
            __L1:r(
                c,
                -6,
                -31,
                2,
                12,
                "#476453"
            )
            __L1:r(
                c,
                4,
                -29,
                2,
                10,
                "#476453"
            )
            __L1:r(
                c,
                12,
                -27,
                2,
                7,
                "#476453"
            )
            c:save()
            c:translate(
                0,
                __TS__Number(-gesture)
            )
            __L1:r(
                c,
                13,
                -34,
                18,
                25,
                "#2e4840"
            )
            __L1:r(
                c,
                15,
                -32,
                14,
                21,
                "#59816b"
            )
            __L1:r(
                c,
                15,
                -31,
                2,
                20,
                "#cdb87d"
            )
            __L1:r(
                c,
                18,
                -28,
                10,
                9,
                "#e3d5ab"
            )
            c.fillStyle = "#47624c"
            c.font = "bold 6px monospace"
            c:fillText("EN", 19, -21)
            __L1:r(
                c,
                19,
                -16,
                8,
                1,
                "#c5cfaa"
            )
            __L1:r(
                c,
                19,
                -13,
                6,
                1,
                "#c5cfaa"
            )
            __L1:r(
                c,
                13,
                -21,
                5,
                5,
                skin
            )
            c:restore()
        end
        local ____t_704 = __t
        local ____t_result_703
        local ____t_702 = __t
        local ____t_result_701
        if __t(attackOn) then
            ____t_result_701 = ____type == "daroca"
        else
            ____t_result_701 = attackOn
        end
        __O[260] = ____t_result_701
        if ____t_702(____t_result_701) then
            ____t_result_703 = attackType == "paper"
        else
            ____t_result_703 = __O[260]
        end
        if ____t_704(____t_result_703) then
            if progress < 0.5 then
                local hx = __get(frontHand, 0)
                local hy = __get(frontHand, 1)
                if o.attackObject == "ruler" then
                    __L1:r(
                        c,
                        hx - 12,
                        hy - 4,
                        25,
                        7,
                        "#725b43"
                    )
                    __L1:r(
                        c,
                        hx - 10,
                        hy - 3,
                        21,
                        4,
                        "#e6b76a"
                    )
                    do
                        local i = 0
                        while i < 5 do
                            __L1:r(
                                c,
                                hx - 8 + i * 4,
                                hy - 1,
                                1,
                                2,
                                "#7d663d"
                            )
                            i = i + 1
                        end
                    end
                elseif o.attackObject == "case" then
                    __L1:r(
                        c,
                        hx - 8,
                        hy - 5,
                        17,
                        11,
                        "#29494e"
                    )
                    __L1:r(
                        c,
                        hx - 6,
                        hy - 3,
                        13,
                        7,
                        "#6ab6b4"
                    )
                    __L1:r(
                        c,
                        hx - 5,
                        hy - 2,
                        11,
                        1,
                        "#c2e6d0"
                    )
                elseif o.attackObject == "papaia" then
                    __L1:poly(
                        c,
                        __arrL(
                            {
                                __arrL({hx - 6, hy - 4}, 2),
                                __arrL({hx + 2, hy - 6}, 2),
                                __arrL({hx + 7, hy}, 2),
                                __arrL({hx + 3, hy + 5}, 2),
                                __arrL({hx - 5, hy + 3}, 2)
                            },
                            5
                        ),
                        "#5c683a"
                    )
                    __L1:poly(
                        c,
                        __arrL(
                            {
                                __arrL({hx - 4, hy - 3}, 2),
                                __arrL({hx + 1, hy - 4}, 2),
                                __arrL({hx + 5, hy}, 2),
                                __arrL({hx + 2, hy + 3}, 2),
                                __arrL({hx - 4, hy + 2}, 2)
                            },
                            5
                        ),
                        o.attackElement == "electric" and "#b1e5e7" or "#f2b260"
                    )
                    __L1:r(
                        c,
                        hx + 2,
                        hy - 7,
                        5,
                        2,
                        "#75a04c"
                    )
                else
                    __L1:r(
                        c,
                        hx - 3,
                        hy - 5,
                        7,
                        7,
                        "#725b43"
                    )
                    __L1:r(
                        c,
                        hx - 2,
                        hy - 5,
                        5,
                        5,
                        "#efe0b3"
                    )
                    __L1:r(
                        c,
                        hx - 1,
                        hy - 4,
                        2,
                        2,
                        "#fff0c7"
                    )
                end
            end
            if __t(progress > 0.4 and progress < 0.7) then
                __L1:r(
                    c,
                    29,
                    -42,
                    11,
                    2,
                    "#f0c786"
                )
                __L1:r(
                    c,
                    35,
                    -37,
                    8,
                    2,
                    "#ebc07c"
                )
            end
        end
        local ____t_706 = __t
        local ____t_result_705
        if __t(flight) then
            ____t_result_705 = ____type == "daroca"
        else
            ____t_result_705 = flight
        end
        if ____t_706(____t_result_705) then
            __L1:r(
                c,
                -22,
                -57,
                8,
                2,
                "#e5cb94"
            )
            __L1:r(
                c,
                -29,
                -51,
                9,
                2,
                "#d1bd87"
            )
        end
        local ____t_715 = __t
        local ____t_result_714
        local ____t_708 = __t
        local ____t_result_707
        if __t(attackOn) then
            ____t_result_707 = strike > 0.5
        else
            ____t_result_707 = attackOn
        end
        __O[263] = ____t_result_707
        if ____t_708(____t_result_707) then
            local ____t_result_713
            local ____t_712 = __t
            local ____t_result_711
            local ____t_710 = __t
            local ____temp_709 = attackType == "punch"
            __O[261] = ____temp_709
            if ____t_710(____temp_709) then
                ____t_result_711 = __O[261]
            else
                ____t_result_711 = ____type == "reeis" and not __t(o.transformed)
            end
            __O[262] = ____t_result_711
            if ____t_712(____t_result_711) then
                ____t_result_713 = __O[262]
            else
                ____t_result_713 = ____type == "caleb"
            end
            ____t_result_714 = ____t_result_713
        else
            ____t_result_714 = __O[263]
        end
        if ____t_715(____t_result_714) then
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL({26, -49}, 2),
                        __arrL({35, -45}, 2),
                        __arrL({42, -37}, 2),
                        __arrL({43, -29}, 2)
                    },
                    4
                ),
                2,
                "#f6d68e"
            )
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL({30, -51}, 2),
                        __arrL({40, -44}, 2),
                        __arrL({46, -34}, 2)
                    },
                    3
                ),
                2,
                "#fff0b7"
            )
        end
        local ____t_717 = __t
        local ____t_result_716
        if __t(o.dash) then
            ____t_result_716 = o.dash
        else
            ____t_result_716 = heroAnim == "dash"
        end
        if ____t_717(____t_result_716) then
            __L1:r(
                c,
                -31,
                -39,
                11 + poseIndex,
                2,
                "#d2daba"
            )
            __L1:r(
                c,
                -39,
                -29,
                15 - poseIndex,
                2,
                "#e7e4b9"
            )
            __L1:r(
                c,
                -27,
                -51,
                8,
                2,
                "#e8d6a0"
            )
        end
        if __t(hit) then
            c.globalAlpha = 0.55
            __L1:r(
                c,
                -17,
                -63,
                35,
                61,
                "#ffe4bc"
            )
        end
        c:restore()
    end
    __L1.vehicle = function(self, c, x, y, t)
        if t == nil then
            t = 0
        end
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + math.sin(t * 5) * 2 + 0.5)
        )
        do
            local i = 0
            while i < 5 do
                c:save()
                c.globalAlpha = c.globalAlpha * (0.7 - i * 0.1)
                __L1:oval(
                    c,
                    -68 - i * 14,
                    -8 + math.sin(t * 12 - i) * 4,
                    5 + i * 2,
                    3 + i,
                    "#b9d774",
                    2
                )
                c:restore()
                i = i + 1
            end
        end
        __L1:r(
            c,
            -51,
            -25,
            103,
            29,
            __L1.P.ink
        )
        __L1:r(
            c,
            -47,
            -24,
            95,
            26,
            "#6c8651"
        )
        __L1:r(
            c,
            -44,
            -22,
            87,
            7,
            "#a2ac65"
        )
        __L1:r(
            c,
            -48,
            -7,
            97,
            8,
            "#3c5943"
        )
        __L1:poly(
            c,
            __arrL(
                {
                    __arrL({-28, -25}, 2),
                    __arrL({-20, -48}, 2),
                    __arrL({19, -48}, 2),
                    __arrL({34, -25}, 2)
                },
                4
            ),
            __L1.P.ink
        )
        __L1:poly(
            c,
            __arrL(
                {
                    __arrL({-23, -26}, 2),
                    __arrL({-16, -44}, 2),
                    __arrL({15, -44}, 2),
                    __arrL({27, -26}, 2)
                },
                4
            ),
            "#9cad92"
        )
        __L1:r(
            c,
            -4,
            -43,
            4,
            18,
            "#455e50"
        )
        __L1:r(
            c,
            -18,
            -41,
            10,
            12,
            "#d2d2a0"
        )
        __L1:r(
            c,
            -38,
            -2,
            20,
            13,
            "#2e3e35"
        )
        __L1:r(
            c,
            23,
            -2,
            20,
            13,
            "#2e3e35"
        )
        __L1:r(
            c,
            -33,
            1,
            10,
            7,
            "#9f9d71"
        )
        __L1:r(
            c,
            28,
            1,
            10,
            7,
            "#9f9d71"
        )
        __L1:r(
            c,
            45,
            -18,
            8,
            9,
            "#f2d78b"
        )
        __L1:r(
            c,
            -54,
            -16,
            8,
            9,
            "#b06c49"
        )
        __L1:r(
            c,
            -48,
            -43,
            13,
            18,
            "#a98e57"
        )
        __L1:r(
            c,
            -45,
            -48,
            7,
            6,
            "#806b42"
        )
        __L1:r(
            c,
            -47,
            -38,
            11,
            2,
            "#dec384"
        )
        __L1:r(
            c,
            -47,
            -29,
            11,
            2,
            "#dec384"
        )
        __L1:r(
            c,
            -33,
            -42,
            10,
            16,
            "#8caa98"
        )
        __L1:r(
            c,
            -30,
            -47,
            5,
            5,
            "#456b5b"
        )
        __L1:r(
            c,
            -32,
            -36,
            8,
            2,
            "#d6dfb4"
        )
        __L1:r(
            c,
            -32,
            -29,
            8,
            2,
            "#d6dfb4"
        )
        __L1:r(
            c,
            -51,
            -26,
            31,
            3,
            "#4d6752"
        )
        do
            local i = 0
            while i < 8 do
                __L1:r(
                    c,
                    -42 + i * 11,
                    -19,
                    2,
                    2,
                    "#c4ca8f"
                )
                i = i + 1
            end
        end
        __L1:r(
            c,
            -1,
            -20,
            3,
            20,
            "#4c6d50"
        )
        __L1:r(
            c,
            8,
            -13,
            5,
            2,
            "#3a5641"
        )
        local prop = math.sin(t * 38)
        local propY = math.cos(t * 38) * 17
        __L1:limb(
            c,
            __arrL(
                {
                    __arrL({-58 - prop * 3, -14 - propY}, 2),
                    __arrL({-58 + prop * 3, -14 + propY}, 2)
                },
                2
            ),
            4,
            "#d5dbc0"
        )
        __L1:r(
            c,
            -63,
            -18,
            9,
            7,
            "#3b5547"
        )
        __L1:r(
            c,
            -61,
            -17,
            5,
            4,
            "#a5b492"
        )
        __L1:r(
            c,
            5,
            -17,
            18,
            7,
            "#e0c581"
        )
        c.fillStyle = "#455d45"
        c.font = "bold 6px monospace"
        c:fillText("GÁS", 7, -11)
        do
            local i = 0
            while i < 4 do
                __L1:r(
                    c,
                    -25 + i * 19,
                    14 + math.sin(t * 12 + i) * 3,
                    10,
                    3,
                    "#b4c26e"
                )
                i = i + 1
            end
        end
        c:restore()
    end
    __L1.cake = function(self, c, x, y)
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        __L1:oval(
            c,
            0,
            0,
            20,
            4,
            "#dac99b",
            2
        )
        __L1:r(
            c,
            -17,
            -17,
            34,
            16,
            "#563d31"
        )
        __L1:r(
            c,
            -16,
            -12,
            32,
            4,
            "#b18a56"
        )
        __L1:r(
            c,
            -17,
            -19,
            34,
            7,
            "#744c35"
        )
        __L1:r(
            c,
            -14,
            -22,
            28,
            5,
            "#94613d"
        )
        __L1:r(
            c,
            -13,
            -18,
            4,
            6,
            "#ba8a55"
        )
        __L1:r(
            c,
            7,
            -18,
            5,
            5,
            "#ba8a55"
        )
        __L1:r(
            c,
            -8,
            -29,
            17,
            8,
            "#71904e"
        )
        __L1:r(
            c,
            -9,
            -33,
            6,
            7,
            "#91a65b"
        )
        __L1:r(
            c,
            3,
            -33,
            6,
            7,
            "#91a65b"
        )
        __L1:r(
            c,
            -7,
            -31,
            2,
            2,
            "#303d2c"
        )
        __L1:r(
            c,
            5,
            -31,
            2,
            2,
            "#303d2c"
        )
        __L1:r(
            c,
            -4,
            -25,
            10,
            2,
            "#435b36"
        )
        __L1:r(
            c,
            -13,
            -24,
            7,
            3,
            "#71904e"
        )
        __L1:r(
            c,
            7,
            -24,
            7,
            3,
            "#71904e"
        )
        c:restore()
    end
    __L1.doodle = function(self, c, x, y, variant, time, enraged)
        if variant == nil then
            variant = 0
        end
        if time == nil then
            time = 0
        end
        if enraged == nil then
            enraged = false
        end
        c:save()
        c.imageSmoothingEnabled = false
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        local ____mod_722 = __mod
        local ____mod_721 = __mod
        local ____t_result_720
        local ____t_719 = __t
        local ____TS__Number_result_718 = __TS__Number(variant)
        __O[264] = ____TS__Number_result_718
        if ____t_719(____TS__Number_result_718) then
            ____t_result_720 = __O[264]
        else
            ____t_result_720 = 0
        end
        local v = ____mod_722(
            ____mod_721(____t_result_720, 3) + 3,
            3
        )
        local ____t_result_725
        local ____t_724 = __t
        local ____TS__Number_result_723 = __TS__Number(time)
        __O[265] = ____TS__Number_result_723
        if ____t_724(____TS__Number_result_723) then
            ____t_result_725 = __O[265]
        else
            ____t_result_725 = 0
        end
        local t = ____t_result_725
        local wiggle = math.floor(math.sin(t * 13 + v) * 2 + 0.5)
        local ink = __t(enraged) and "#692f42" or "#3d354c"
        local edge = __t(enraged) and "#db7467" or "#9e84ac"
        local paper = "#f1dbad"
        if __t(enraged) then
            c:save()
            c.globalAlpha = 0.25
            __L1:oval(
                c,
                0,
                0,
                25,
                23,
                "#e47660",
                3
            )
            c:restore()
        end
        if v == 0 then
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({-6, -6}, 2),
                        __arrL({-23, -15}, 2),
                        __arrL({-21, -4}, 2),
                        __arrL({-15, -5}, 2),
                        __arrL({-12, 3}, 2),
                        __arrL({-5, 1}, 2)
                    },
                    6
                ),
                ink
            )
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({6, -6}, 2),
                        __arrL({23, -15}, 2),
                        __arrL({21, -4}, 2),
                        __arrL({15, -5}, 2),
                        __arrL({12, 3}, 2),
                        __arrL({5, 1}, 2)
                    },
                    6
                ),
                ink
            )
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({-12, -8}, 2),
                        __arrL({-13, -19}, 2),
                        __arrL({-5, -12}, 2),
                        __arrL({4, -12}, 2),
                        __arrL({12, -19}, 2),
                        __arrL({11, -8}, 2),
                        __arrL({14, 3}, 2),
                        __arrL({8, 12}, 2),
                        __arrL({-8, 12}, 2),
                        __arrL({-14, 3}, 2)
                    },
                    10
                ),
                ink
            )
            __L1:r(
                c,
                -8,
                -8,
                5,
                6,
                paper
            )
            __L1:r(
                c,
                3,
                -8,
                5,
                6,
                paper
            )
            __L1:r(
                c,
                -6,
                -7,
                2,
                4,
                __t(enraged) and "#c5484b" or "#61456f"
            )
            __L1:r(
                c,
                4,
                -7,
                2,
                4,
                __t(enraged) and "#c5484b" or "#61456f"
            )
            __L1:r(
                c,
                -5,
                2,
                10,
                4,
                "#201e2c"
            )
            __L1:r(
                c,
                -4,
                2,
                3,
                3,
                paper
            )
            __L1:r(
                c,
                2,
                2,
                3,
                3,
                paper
            )
            __L1:r(
                c,
                -11,
                10,
                5,
                4,
                edge
            )
            __L1:r(
                c,
                7,
                10,
                5,
                4,
                edge
            )
        elseif v == 1 then
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({-15, -7}, 2),
                        __arrL({-10, -11}, 2),
                        __arrL({-12, -17}, 2),
                        __arrL({-3, -13}, 2),
                        __arrL({2, -19}, 2),
                        __arrL({7, -12}, 2),
                        __arrL({16, -13}, 2),
                        __arrL({13, -4}, 2),
                        __arrL({18, 3}, 2),
                        __arrL({11, 11}, 2),
                        __arrL({3, 9}, 2),
                        __arrL({-3, 16}, 2),
                        __arrL({-9, 9}, 2),
                        __arrL({-16, 8}, 2),
                        __arrL({-12, 0}, 2)
                    },
                    15
                ),
                ink
            )
            __L1:r(
                c,
                -9,
                -7,
                18,
                10,
                edge
            )
            __L1:r(
                c,
                -7,
                -8,
                14,
                12,
                paper
            )
            __L1:r(
                c,
                -2,
                -7,
                6,
                10,
                __t(enraged) and "#b64b56" or "#705280"
            )
            __L1:r(
                c,
                0,
                -5,
                3,
                7,
                "#252435"
            )
            __L1:r(
                c,
                0,
                -6,
                2,
                2,
                "#fff0c6"
            )
            __L1:r(
                c,
                -8,
                7,
                15,
                2,
                "#c2a8c5"
            )
            __L1:r(
                c,
                -4,
                9,
                3,
                3,
                paper
            )
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({-12, 4}, 2),
                        __arrL({-23, 1}, 2),
                        __arrL({-24, 4}, 2),
                        __arrL({-13, 7}, 2)
                    },
                    4
                ),
                edge
            )
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({12, 4}, 2),
                        __arrL({23, 1}, 2),
                        __arrL({24, 4}, 2),
                        __arrL({13, 7}, 2)
                    },
                    4
                ),
                edge
            )
        else
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({-19, -4}, 2),
                        __arrL({-15, -12}, 2),
                        __arrL({-8, -11}, 2),
                        __arrL({-5, -17}, 2),
                        __arrL({2, -13}, 2),
                        __arrL({10, -16}, 2),
                        __arrL({14, -9}, 2),
                        __arrL({21, -7}, 2),
                        __arrL({17, 0}, 2),
                        __arrL({22, 7}, 2),
                        __arrL({15, 13}, 2),
                        __arrL({7, 10}, 2),
                        __arrL({0, 16}, 2),
                        __arrL({-5, 10}, 2),
                        __arrL({-16, 12}, 2),
                        __arrL({-19, 4}, 2)
                    },
                    16
                ),
                ink
            )
            __L1:r(
                c,
                -12,
                -7,
                5,
                5,
                paper
            )
            __L1:r(
                c,
                -2,
                -10,
                5,
                5,
                paper
            )
            __L1:r(
                c,
                8,
                -6,
                5,
                5,
                paper
            )
            __L1:r(
                c,
                -10,
                -6,
                2,
                3,
                "#6b4d79"
            )
            __L1:r(
                c,
                0,
                -9,
                2,
                3,
                "#6b4d79"
            )
            __L1:r(
                c,
                10,
                -5,
                2,
                3,
                "#6b4d79"
            )
            __L1:r(
                c,
                -12,
                2,
                25,
                6,
                "#242230"
            )
            do
                local i = 0
                while i < 4 do
                    __L1:r(
                        c,
                        -10 + i * 6,
                        2,
                        3,
                        3,
                        paper
                    )
                    __L1:r(
                        c,
                        -7 + i * 6,
                        5,
                        3,
                        3,
                        paper
                    )
                    i = i + 1
                end
            end
        end
        do
            local i = 0
            while i < 6 do
                local xx = math.floor(math.cos(i * 1.05 + t * 2) * 22 + 0.5)
                local yy = math.floor(math.sin(i * 1.05 + t * 2) * 18 + 0.5)
                __L1:r(
                    c,
                    xx,
                    yy + wiggle,
                    4,
                    2,
                    edge
                )
                if __t(__mod(i, 2)) then
                    __L1:r(
                        c,
                        xx + 2,
                        yy + wiggle - 3,
                        2,
                        3,
                        edge
                    )
                end
                i = i + 1
            end
        end
        c:restore()
    end
    __L1.material = function(self, c, x, y, ____type)
        if ____type == nil then
            ____type = "pencil"
        end
        c:save()
        c.imageSmoothingEnabled = false
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        local ____temp_726
        if type(____type) == "number" then
            ____temp_726 = __get(
                __arrL({"pencil", "eraser", "clip"}, 3),
                __mod(____type, 3)
            )
        else
            ____temp_726 = __re_replace(
                __call(
                    tostring(____type),
                    "toLowerCase"
                ),
                __re("s$", ""),
                ""
            )
        end
        local kind = ____temp_726
        if kind == "eraser" then
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({-11, 5}, 2),
                        __arrL({-2, -8}, 2),
                        __arrL({10, -5}, 2),
                        __arrL({10, 2}, 2),
                        __arrL({1, 11}, 2)
                    },
                    5
                ),
                "#563f43"
            )
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({-8, 4}, 2),
                        __arrL({-1, -5}, 2),
                        __arrL({8, -3}, 2),
                        __arrL({0, 7}, 2)
                    },
                    4
                ),
                "#db9b96"
            )
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({-8, 4}, 2),
                        __arrL({0, 7}, 2),
                        __arrL({0, 9}, 2),
                        __arrL({-8, 6}, 2)
                    },
                    4
                ),
                "#aa7477"
            )
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({0, 7}, 2),
                        __arrL({8, -3}, 2),
                        __arrL({8, 1}, 2),
                        __arrL({0, 10}, 2)
                    },
                    4
                ),
                "#f0c8af"
            )
            __L1:r(
                c,
                -1,
                -3,
                3,
                2,
                "#ebbbb0"
            )
        elseif kind == "clip" then
            c.strokeStyle = "#3c4e4c"
            c.lineWidth = 5
            c:beginPath()
            c:moveTo(-5, 9)
            c:lineTo(8, -4)
            c:lineTo(8, -8)
            c:lineTo(4, -11)
            c:lineTo(0, -10)
            c:lineTo(-10, 1)
            c:lineTo(-10, 5)
            c:lineTo(-6, 8)
            c:lineTo(-2, 7)
            c:lineTo(6, -2)
            c:lineTo(5, -5)
            c:lineTo(2, -5)
            c:lineTo(-5, 3)
            c:stroke()
            c.strokeStyle = "#b6c5af"
            c.lineWidth = 2
            c:stroke()
        else
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({-10, 8}, 2),
                        __arrL({6, -10}, 2),
                        __arrL({10, -7}, 2),
                        __arrL({-6, 11}, 2)
                    },
                    4
                ),
                "#5b4937"
            )
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({-8, 8}, 2),
                        __arrL({6, -8}, 2),
                        __arrL({8, -6}, 2),
                        __arrL({-6, 10}, 2)
                    },
                    4
                ),
                "#e1bc67"
            )
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({-8, 8}, 2),
                        __arrL({-6, 10}, 2),
                        __arrL({-12, 13}, 2)
                    },
                    3
                ),
                "#eadab2"
            )
            __L1:r(
                c,
                -12,
                11,
                2,
                2,
                "#36362f"
            )
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({6, -10}, 2),
                        __arrL({9, -13}, 2),
                        __arrL({13, -10}, 2),
                        __arrL({10, -7}, 2)
                    },
                    4
                ),
                "#d28e85"
            )
            __L1:r(
                c,
                6,
                -7,
                4,
                2,
                "#d5cfad"
            )
        end
        c:restore()
    end
    __L1.classroomDoor = function(self, c, x, id, t)
        if t == nil then
            t = 0
        end
        local english = id == "miqueias"
        local accent = __t(english) and "#796080" or "#527f93"
        __L1:r(
            c,
            x - 53,
            269,
            106,
            164,
            "#806d54"
        )
        __L1:r(
            c,
            x - 49,
            273,
            98,
            157,
            accent
        )
        __L1:r(
            c,
            x - 43,
            281,
            86,
            149,
            "#38595d"
        )
        __L1:r(
            c,
            x - 39,
            285,
            78,
            144,
            __t(english) and "#93868d" or "#7f9ba1"
        )
        __L1:r(
            c,
            x - 32,
            294,
            64,
            72,
            "#bccbd1"
        )
        __L1:r(
            c,
            x - 28,
            298,
            56,
            64,
            "#d8e3d9"
        )
        __L1:r(
            c,
            x - 2,
            294,
            4,
            72,
            accent
        )
        __L1:r(
            c,
            x - 31,
            330,
            62,
            4,
            accent
        )
        __L1:r(
            c,
            x + 27,
            386,
            5,
            5,
            "#f1d896"
        )
        __L1:r(
            c,
            x - 47,
            425,
            94,
            7,
            "#c9b792"
        )
        __L1:r(
            c,
            x - 76,
            241,
            152,
            25,
            accent
        )
        __L1:r(
            c,
            x - 73,
            244,
            146,
            19,
            __t(english) and "#a38ba8" or "#7fa0af"
        )
        c.fillStyle = "#fff1cb"
        c.font = "bold 11px monospace"
        c:fillText(
            __t(english) and "SALA · MIQUEIAS" or "SALA · ALMIRO",
            x - 66,
            258
        )
        c.fillStyle = "#c9ddbc"
        c.font = "bold 8px monospace"
        c:fillText(
            __t(english) and "ENGLISH IS VERY BOM" or "CIÊNCIAS DA ROÇA",
            x - 53,
            311
        )
        do
            local i = 0
            while i < 2 do
                __L1:r(
                    c,
                    x - 58 + i * 110,
                    276,
                    5,
                    154,
                    "#eddbb1"
                )
                __L1:r(
                    c,
                    x - 58 + i * 110,
                    276,
                    2,
                    152,
                    "#fff0c7"
                )
                i = i + 1
            end
        end
    end
    __L1.worldExtensions = function(self, c, scene, camera, t)
        local width = __L1:worldWidth(scene)
        c:save()
        c:translate(
            -math.floor(camera + 0.5),
            0
        )
        if scene == 0 then
            do
                local x = 2590
                local i = 0
                while x < width do
                    __L1:fence(c, x, 425, 223)
                    if __mod(i, 3) == 0 then
                        __L1:tree(
                            c,
                            x + 149,
                            430,
                            0.8 + __mod(i, 2) * 0.2,
                            __mod(i, 2)
                        )
                    else
                        __L1:bush(
                            c,
                            x + 145,
                            434,
                            83,
                            "#659347"
                        )
                    end
                    if __mod(i, 3) == 1 then
                        __L1:r(
                            c,
                            x + 10,
                            415,
                            68,
                            23,
                            "#a77c45"
                        )
                        __L1:r(
                            c,
                            x + 8,
                            410,
                            72,
                            7,
                            "#dfbd6c"
                        )
                        __L1:r(
                            c,
                            x + 14,
                            419,
                            61,
                            2,
                            "#d1a75d"
                        )
                        __L1:r(
                            c,
                            x + 14,
                            430,
                            61,
                            2,
                            "#d1a75d"
                        )
                    end
                    do
                        local j = 0
                        while j < 9 do
                            local xx = x + 15 + j * 22
                            __L1:grass(c, xx, 435, i + j)
                            if __mod(j + i, 5) == 0 then
                                __L1:flower(c, xx, 430, "#f7d265")
                            end
                            j = j + 1
                        end
                    end
                    do
                        x = x + 245
                        i = i + 1
                    end
                end
            end
            __L1:house(c, 3505, 430)
            __L1:r(
                c,
                4320,
                367,
                7,
                73,
                "#795b3e"
            )
            __L1:r(
                c,
                4280,
                358,
                89,
                25,
                "#c5a46a"
            )
            c.fillStyle = "#4a5e3b"
            c.font = "bold 10px monospace"
            c:fillText("TRILHA DA ROÇA", 4284, 375)
        elseif scene == 1 then
            __L1:r(
                c,
                1840,
                225,
                width - 1840,
                208,
                "#edf3f4"
            )
            __L1:r(
                c,
                1840,
                215,
                width - 1840,
                14,
                "#193b61"
            )
            __L1:r(
                c,
                1840,
                229,
                width - 1840,
                7,
                "#ffffff"
            )
            __L1:r(
                c,
                1840,
                368,
                width - 1840,
                65,
                "#244c73"
            )
            __L1:r(
                c,
                1840,
                368,
                width - 1840,
                5,
                "#16324f"
            )
            do
                local x = 1900
                while x < width - 100 do
                    __L1:r(
                        c,
                        x,
                        270,
                        92,
                        71,
                        "#4c6c80"
                    )
                    __L1:r(
                        c,
                        x + 4,
                        274,
                        84,
                        62,
                        "#749b9c"
                    )
                    __L1:r(
                        c,
                        x + 8,
                        278,
                        34,
                        24,
                        "#b5cfc6"
                    )
                    __L1:r(
                        c,
                        x + 47,
                        309,
                        36,
                        23,
                        "#8bb5aa"
                    )
                    __L1:r(
                        c,
                        x + 42,
                        275,
                        4,
                        61,
                        "#d8e8ec"
                    )
                    __L1:r(
                        c,
                        x + 4,
                        303,
                        84,
                        4,
                        "#d8e8ec"
                    )
                    __L1:r(
                        c,
                        x - 3,
                        341,
                        98,
                        6,
                        "#b9cfdc"
                    )
                    x = x + 180
                end
            end
            __L1:classroomDoor(c, 1350, "almiro", t)
            __L1:classroomDoor(c, 2350, "miqueias", t)
            do
                local i = 0
                while i < 5 do
                    local x = 2670 + i * 169
                    __L1:poly(
                        c,
                        __arrL(
                            {
                                __arrL({x - 57, 267}, 2),
                                __arrL({x + 51, 263}, 2),
                                __arrL({x + 58, 349}, 2),
                                __arrL({x + 38, 359}, 2),
                                __arrL({x + 16, 353}, 2),
                                __arrL({x - 9, 362}, 2),
                                __arrL({x - 56, 353}, 2)
                            },
                            7
                        ),
                        "#d4cfb5"
                    )
                    __L1:r(
                        c,
                        x - 40,
                        277,
                        75,
                        2,
                        "#a7a296"
                    )
                    c:save()
                    c:translate(x, 321)
                    c:scale(1.35, 1.35)
                    __L1:doodle(
                        c,
                        0,
                        0,
                        __mod(i, 3),
                        t * 0.35 + i,
                        false
                    )
                    c:restore()
                    c.fillStyle = "#675975"
                    c.font = "bold 8px monospace"
                    c:fillText(
                        __get(
                            __arrL({
                                "NÃO ABRA O CADERNO",
                                "ELES ESTÃO OLHANDO",
                                "SÓ UM RABISCO...",
                                "O PAPEL RESPIRA",
                                "MARCO ESTEVE AQUI"
                            }, 5),
                            i
                        ),
                        x - 53,
                        375
                    )
                    i = i + 1
                end
            end
            local phrases = __arrL({
                "da roça poudiaaam",
                "reeeis pouddiaaam",
                "da roça pegou ar",
                "teketeketeketeke",
                "o pra ravid falando sozinho"
            }, 5)
            do
                local i = 0
                while i < 5 do
                    local x = 4020 + i * 183
                    __L1:r(
                        c,
                        x,
                        263,
                        172,
                        103,
                        "#6e6951"
                    )
                    __L1:r(
                        c,
                        x + 5,
                        268,
                        162,
                        92,
                        "#77bcb6"
                    )
                    __L1:r(
                        c,
                        x + 10,
                        274,
                        152,
                        2,
                        "#a5e2da"
                    )
                    c.fillStyle = "#204f57"
                    c.font = __add(
                        __add("bold ", i == 4 and 9 or 11),
                        "px monospace"
                    )
                    local words = __call(
                        __get(phrases, i),
                        "split",
                        " "
                    )
                    local line = ""
                    local yy = 304
                    for ____, word in __iterar((words)) do
                        if __len(__add(line, word)) > (i == 4 and 21 or 18) then
                            c:fillText(
                                __call(line, "trim"),
                                x + 13,
                                yy
                            )
                            line = ""
                            yy = yy + 17
                        end
                        line = __add(
                            line,
                            __add(word, " ")
                        )
                    end
                    c:fillText(
                        __call(line, "trim"),
                        x + 13,
                        yy
                    )
                    __L1:r(
                        c,
                        x + 11,
                        352,
                        145,
                        3,
                        "#85977a"
                    )
                    i = i + 1
                end
            end
            do
                local x = 2700
                while x < width do
                    __L1:r(
                        c,
                        x,
                        402,
                        58,
                        8,
                        "#977343"
                    )
                    __L1:r(
                        c,
                        x + 6,
                        410,
                        6,
                        29,
                        "#536952"
                    )
                    __L1:r(
                        c,
                        x + 47,
                        410,
                        6,
                        29,
                        "#536952"
                    )
                    __L1:bush(c, x + 114, 435, 48)
                    x = x + 470
                end
            end
            __L1:r(
                c,
                width - 150,
                285,
                97,
                146,
                "#52736a"
            )
            __L1:r(
                c,
                width - 145,
                292,
                87,
                132,
                "#8ba997"
            )
            c.fillStyle = "#dfe6bb"
            c.font = "bold 10px monospace"
            c:fillText("SAÍDA →", width - 138, 314)
        elseif scene == 2 then
            do
                local x = 2680
                local i = 0
                while x < width do
                    __L1:r(
                        c,
                        x,
                        314,
                        130,
                        102,
                        "#263e3b"
                    )
                    __L1:r(
                        c,
                        x + 7,
                        321,
                        116,
                        89,
                        "#7d9889"
                    )
                    __L1:r(
                        c,
                        x + 15,
                        330,
                        42,
                        67,
                        "#99afa1"
                    )
                    __L1:r(
                        c,
                        x + 63,
                        328,
                        3,
                        74,
                        "#c5ccb0"
                    )
                    __L1:r(
                        c,
                        x - 15,
                        413,
                        152,
                        8,
                        "#293f39"
                    )
                    do
                        local j = 0
                        while j < 4 do
                            local xx = x + j * 33
                            __L1:r(
                                c,
                                xx,
                                396,
                                26,
                                5,
                                "#a6b69c"
                            )
                            __L1:r(
                                c,
                                xx + 2,
                                389,
                                6,
                                19,
                                "#304e43"
                            )
                            __L1:r(
                                c,
                                xx + 18,
                                389,
                                6,
                                19,
                                "#304e43"
                            )
                            j = j + 1
                        end
                    end
                    c.fillStyle = "#c0c99a"
                    c.font = "bold 12px monospace"
                    c:fillText(
                        __get(
                            __arrL({"FORÇA DA ROÇA", "UMA REPETIÇÃO A MAIS", "FOCO NO BOLO"}, 3),
                            __mod(i, 3)
                        ),
                        x - 5,
                        293
                    )
                    do
                        x = x + 350
                        i = i + 1
                    end
                end
            end
        elseif scene == 3 then
            do
                local x = 2700
                local i = 0
                while x < width do
                    __L1:r(
                        c,
                        x,
                        202,
                        7,
                        236,
                        "#4b7267"
                    )
                    __L1:r(
                        c,
                        x - 25,
                        193,
                        56,
                        13,
                        "#405c57"
                    )
                    do
                        local j = 0
                        while j < 4 do
                            __L1:r(
                                c,
                                x - 19 + j * 12,
                                196,
                                9,
                                7,
                                "#e1e8be"
                            )
                            j = j + 1
                        end
                    end
                    do
                        local j = 0
                        while j < 3 do
                            __L1:r(
                                c,
                                x + 64 - j * 9,
                                361 + j * 21,
                                190 + j * 18,
                                8,
                                "#b3997b"
                            )
                            __L1:r(
                                c,
                                x + 70 - j * 9,
                                369 + j * 21,
                                5,
                                61 - j * 21,
                                "#4b6d5b"
                            )
                            __L1:r(
                                c,
                                x + 239 + j * 9,
                                369 + j * 21,
                                5,
                                61 - j * 21,
                                "#4b6d5b"
                            )
                            j = j + 1
                        end
                    end
                    __L1:r(
                        c,
                        x + 76,
                        347,
                        142,
                        2,
                        "#78966f"
                    )
                    do
                        x = x + 420
                        i = i + 1
                    end
                end
            end
            __L1:r(
                c,
                3920,
                247,
                216,
                35,
                "#4d7263"
            )
            c.fillStyle = "#e2dab1"
            c.font = "bold 13px monospace"
            c:fillText("QUADRA · FINAL DO RECREIO", 3931, 270)
        end
        c:restore()
    end
    __L1.platform = function(self, c, x, y, w, theme)
        if theme == nil then
            theme = "wood"
        end
        local ____temp_728
        if type(theme) == "table" then
            local ____t_result_727
            if __t(theme.theme) then
                ____t_result_727 = theme.theme
            else
                ____t_result_727 = "wood"
            end
            ____temp_728 = ____t_result_727
        else
            ____temp_728 = theme
        end
        local kind = ____temp_728
        local colors = {
            house = __arrL({"#80634d", "#f0dbb4"}, 2),
            rayssa = __arrL({"#80634d", "#f0dbb4"}, 2),
            patio = __arrL({"#426d82", "#e7ede0"}, 2),
            bigodon = __arrL({"#5d4c3b", "#e5c28c"}, 2),
            barber = __arrL({"#5d4c3b", "#e5c28c"}, 2),
            favela = __arrL({"#70615b", "#d9b68d"}, 2),
            caderno = __arrL({"#6b567e", "#e6cddd"}, 2),
            campo = __arrL({"#44734a", "#c6dca6"}, 2),
            plaza = __arrL({"#738c91", "#dae5de"}, 2),
            wood = __arrL({"#77603f", "#c7a66a"}, 2),
            school = __arrL({"#7f8c80", "#d5d4ac"}, 2),
            doodles = __arrL({"#5a4c75", "#c6a9da"}, 2),
            words = __arrL({"#4e7059", "#dedcb3"}, 2),
            gym = __arrL({"#3e514c", "#a4b39c"}, 2),
            court = __arrL({"#6f7968", "#d7c39b"}, 2)
        }
        local ____t_result_731
        local ____t_730 = __t
        local ____get_result_729 = __get(colors, kind)
        __O[266] = ____get_result_729
        if ____t_730(____get_result_729) then
            ____t_result_731 = __O[266]
        else
            ____t_result_731 = colors.wood
        end
        local pal = ____t_result_731
        c:save()
        __L1:r(
            c,
            x - 2,
            y,
            w + 4,
            16,
            "#2c3b31"
        )
        __L1:r(
            c,
            x,
            y + 2,
            w,
            10,
            __get(pal, 0)
        )
        __L1:r(
            c,
            x,
            y,
            w,
            4,
            __get(pal, 1)
        )
        do
            local i = 8
            while __lt(i, w) do
                __L1:r(
                    c,
                    x + i,
                    y + 5,
                    2,
                    6,
                    __get(pal, 1)
                )
                __L1:r(
                    c,
                    x + i + 3,
                    y + 8,
                    8,
                    1,
                    "#334238"
                )
                i = i + 23
            end
        end
        __L1:r(
            c,
            x + 4,
            y + 14,
            w - 8,
            3,
            __get(pal, 0)
        )
        c:restore()
    end
    __L1.classroom = function(self, c, roomId, t)
        if t == nil then
            t = 0
        end
        c:save()
        c.imageSmoothingEnabled = false
        local en = roomId == "miqueias"
        __L1:r(
            c,
            0,
            0,
            960,
            540,
            __t(en) and "#e3eef0" or "#e9f2f3"
        )
        __L1:r(
            c,
            0,
            0,
            960,
            29,
            "#1c3f64"
        )
        __L1:r(
            c,
            0,
            29,
            960,
            9,
            "#e8dec1"
        )
        do
            local row = 0
            while row < 7 do
                do
                    local col = 0
                    while col < 17 do
                        local x = col * 62 + __mod(row, 2) * 31
                        __L1:r(
                            c,
                            x,
                            45 + row * 47,
                            54,
                            1,
                            __t(en) and "#c3b4a5" or "#9ab8c1"
                        )
                        __L1:r(
                            c,
                            x,
                            45 + row * 47,
                            1,
                            41,
                            __t(en) and "#c3b4a5" or "#9ab8c1"
                        )
                        col = col + 1
                    end
                end
                row = row + 1
            end
        end
        __L1:r(
            c,
            0,
            352,
            960,
            88,
            "#2d5278"
        )
        __L1:r(
            c,
            0,
            349,
            960,
            7,
            "#e8d8b2"
        )
        for ____, x in __iterar((__arrL({155, 803}, 2))) do
            __L1:r(
                c,
                x,
                81,
                111,
                113,
                "#6b817d"
            )
            __L1:r(
                c,
                x + 5,
                86,
                101,
                103,
                "#a4d2e5"
            )
            __L1:cloud(
                c,
                x + 12,
                116,
                0.7,
                "#fffdf0"
            )
            __L1:r(
                c,
                x + 52,
                86,
                4,
                103,
                "#eadfc0"
            )
            __L1:r(
                c,
                x + 5,
                135,
                101,
                4,
                "#eadfc0"
            )
            __L1:r(
                c,
                x - 4,
                194,
                119,
                7,
                "#7e8d7a"
            )
        end
        __L1:r(
            c,
            40,
            241,
            96,
            199,
            "#665d4c"
        )
        __L1:r(
            c,
            47,
            247,
            82,
            193,
            __t(en) and "#7b7a83" or "#6d8c97"
        )
        __L1:r(
            c,
            55,
            260,
            66,
            92,
            "#a9c5c8"
        )
        __L1:r(
            c,
            59,
            264,
            58,
            84,
            "#d3dfcf"
        )
        __L1:r(
            c,
            112,
            376,
            5,
            5,
            "#edcc86"
        )
        __L1:r(
            c,
            36,
            433,
            104,
            7,
            "#d1bd91"
        )
        __L1:r(
            c,
            48,
            213,
            81,
            22,
            "#3e665b"
        )
        c.fillStyle = "#f4eccb"
        c.font = "bold 12px monospace"
        c:fillText("← SAÍDA", 55, 229)
        __L1:r(
            c,
            294,
            65,
            488,
            169,
            "#8f7653"
        )
        __L1:r(
            c,
            301,
            72,
            474,
            154,
            "#78bfb8"
        )
        __L1:r(
            c,
            308,
            79,
            460,
            2,
            "#beeee4"
        )
        __L1:poly(
            c,
            __arrL(
                {
                    __arrL({332, 80}, 2),
                    __arrL({368, 80}, 2),
                    __arrL({497, 220}, 2),
                    __arrL({461, 220}, 2)
                },
                4
            ),
            "#9fded34d"
        )
        __L1:poly(
            c,
            __arrL(
                {
                    __arrL({612, 80}, 2),
                    __arrL({629, 80}, 2),
                    __arrL({757, 220}, 2),
                    __arrL({740, 220}, 2)
                },
                4
            ),
            "#d4f7ec45"
        )
        __L1:r(
            c,
            300,
            228,
            477,
            8,
            "#bd9f69"
        )
        c.fillStyle = "#1d5155"
        c.font = __add(
            __add(
                "bold ",
                __t(en) and 18 or 23
            ),
            "px monospace"
        )
        c:fillText(
            __t(en) and "MY ENGLISH IS VERY BOM TODAY!" or "CIÊNCIAS DA ROÇA",
            __t(en) and 315 or 331,
            107
        )
        c.font = "bold 14px monospace"
        c:fillText(
            __t(en) and "The bolo are disappear." or "Bolo + sapo = aventura",
            325,
            140
        )
        c:fillText(
            __t(en) and "You is ready? ALLRIGHT!" or "Hipótese: o bolo foi roubado.",
            325,
            163
        )
        c.font = "bold 12px monospace"
        c:fillText(
            __t(en) and "BELEZA CREUZA!  CONCORDA OU SEM CORDA?" or "Observação + amizade + muita coragem",
            325,
            192
        )
        __L1:r(
            c,
            311,
            219,
            20,
            3,
            "#eee9c7"
        )
        __L1:r(
            c,
            699,
            218,
            35,
            8,
            "#c6b37e"
        )
        __L1:r(
            c,
            702,
            215,
            29,
            4,
            "#85998b"
        )
        do
            local i = 0
            while i < 2 do
                local x = 160 + i * 644
                __L1:r(
                    c,
                    x,
                    224,
                    95,
                    61,
                    "#8b785d"
                )
                __L1:r(
                    c,
                    x + 3,
                    227,
                    89,
                    55,
                    "#f0dfb0"
                )
                c.fillStyle = __t(en) and "#74627f" or "#597687"
                c.font = "bold 9px monospace"
                local ____c_733 = c
                local ____c_fillText_734 = c.fillText
                local ____t_result_732
                if __t(en) then
                    ____t_result_732 = __t(i) and "HELLO, TURMA!" or "BOOK = LIVRO"
                else
                    ____t_result_732 = __t(i) and "AULA COM HUMOR" or "PENSE. OBSERVE."
                end
                ____c_fillText_734(____c_733, ____t_result_732, x + 8, 249)
                local ____c_736 = c
                local ____c_fillText_737 = c.fillText
                local ____t_result_735
                if __t(en) then
                    ____t_result_735 = __t(i) and "GOOD LANCHE!" or "CAKE = BOLO"
                else
                    ____t_result_735 = __t(i) and "E CURIOSIDADE!" or "FAÇA PERGUNTAS."
                end
                ____c_fillText_737(____c_736, ____t_result_735, x + 8, 267)
                i = i + 1
            end
        end
        local skins = __arrL({"#edc5a0", "#9a6546", "#c18b60", "#e7b994"}, 4)
        local hairs = __arrL({"#3d362d", "#705239", "#2d3330", "#b3945b"}, 4)
        do
            local row = 0
            while row < 3 do
                do
                    local col = 0
                    while col < 4 do
                        local i = row * 4 + col
                        local xx = 244 + col * 139
                        local yy = 259 + row * 47
                        local bob = math.floor(math.sin(t * 1.7 + i) * 0.8 + 0.5)
                        local skin = __get(
                            skins,
                            __mod(i, 4)
                        )
                        __L1:r(
                            c,
                            xx - 17,
                            yy + 15,
                            37,
                            22,
                            "#337ab3"
                        )
                        __L1:r(
                            c,
                            xx - 13,
                            yy + 21,
                            5,
                            18,
                            "#234d75"
                        )
                        __L1:r(
                            c,
                            xx + 10,
                            yy + 21,
                            5,
                            18,
                            "#234d75"
                        )
                        __L1:r(
                            c,
                            xx - 14,
                            yy - 2 + bob,
                            29,
                            25,
                            __mod(i, 3) == 0 and "#e3ebed" or "#244e7b"
                        )
                        __L1:r(
                            c,
                            xx - 9,
                            yy - 21 + bob,
                            21,
                            20,
                            "#4b4034"
                        )
                        __L1:r(
                            c,
                            xx - 8,
                            yy - 20 + bob,
                            19,
                            17,
                            skin
                        )
                        __L1:r(
                            c,
                            xx - 9,
                            yy - 23 + bob,
                            21,
                            7,
                            __get(
                                hairs,
                                __mod(i, 4)
                            )
                        )
                        __L1:r(
                            c,
                            xx - 9,
                            yy - 17 + bob,
                            4,
                            7,
                            __get(
                                hairs,
                                __mod(i, 4)
                            )
                        )
                        __L1:r(
                            c,
                            xx + 5,
                            yy - 13 + bob,
                            2,
                            2,
                            "#393c31"
                        )
                        if math.sin(t * 3 + i * 2) > 0.92 then
                            __L1:r(
                                c,
                                xx + 4,
                                yy - 13 + bob,
                                5,
                                1,
                                "#76513a"
                            )
                        end
                        __L1:r(
                            c,
                            xx - 18,
                            yy + 6,
                            6,
                            11,
                            skin
                        )
                        __L1:r(
                            c,
                            xx + 12,
                            yy + 5,
                            6,
                            11,
                            skin
                        )
                        __L1:r(
                            c,
                            xx + 14 + math.floor(math.sin(t * 3 + i) * 2 + 0.5),
                            yy + 13,
                            8,
                            4,
                            skin
                        )
                        __L1:r(
                            c,
                            xx - 39,
                            yy + 19,
                            80,
                            8,
                            "#8e714d"
                        )
                        __L1:r(
                            c,
                            xx - 38,
                            yy + 19,
                            78,
                            3,
                            "#d2b27a"
                        )
                        __L1:r(
                            c,
                            xx - 32,
                            yy + 27,
                            4,
                            19,
                            "#65735e"
                        )
                        __L1:r(
                            c,
                            xx + 30,
                            yy + 27,
                            4,
                            19,
                            "#65735e"
                        )
                        __L1:r(
                            c,
                            xx - 16,
                            yy + 16,
                            24,
                            4,
                            "#f0e5bb"
                        )
                        __L1:r(
                            c,
                            xx - 12,
                            yy + 15,
                            13,
                            1,
                            "#72908a"
                        )
                        __L1:r(
                            c,
                            xx + 19,
                            yy + 15,
                            11,
                            3,
                            "#cfb065"
                        )
                        col = col + 1
                    end
                end
                row = row + 1
            end
        end
        __L1:r(
            c,
            736,
            377,
            145,
            14,
            "#ac8756"
        )
        __L1:r(
            c,
            741,
            391,
            9,
            48,
            "#786846"
        )
        __L1:r(
            c,
            866,
            391,
            9,
            48,
            "#786846"
        )
        __L1:r(
            c,
            752,
            393,
            104,
            36,
            "#9b7c50"
        )
        __L1:r(
            c,
            785,
            402,
            5,
            4,
            "#d5bf87"
        )
        __L1:r(
            c,
            759,
            367,
            34,
            9,
            __t(en) and "#678b6f" or "#7b96a6"
        )
        __L1:r(
            c,
            763,
            365,
            29,
            3,
            "#e7deb7"
        )
        __L1:r(
            c,
            824,
            365,
            13,
            12,
            "#d4ba7d"
        )
        __L1:r(
            c,
            826,
            358,
            2,
            13,
            "#7c8460"
        )
        __L1:r(
            c,
            830,
            355,
            2,
            16,
            "#a8684b"
        )
        __L1:r(
            c,
            0,
            440,
            960,
            100,
            __t(en) and "#a58d70" or "#8e9384"
        )
        __L1:r(
            c,
            0,
            440,
            960,
            6,
            "#d2c5a0"
        )
        do
            local x = 0
            while x < 960 do
                __L1:r(
                    c,
                    x,
                    447,
                    1,
                    93,
                    "#747d6c"
                )
                x = x + 80
            end
        end
        __L1:r(
            c,
            0,
            495,
            960,
            1,
            "#747d6c"
        )
        c:restore()
    end
    __L1.newArena = function(self, c, ____type, camera, t, homeX)
        c:save()
        local ____t_result_738
        if __t(homeX) then
            ____t_result_738 = homeX - camera
        else
            ____t_result_738 = 480
        end
        local center = ____t_result_738
        c:translate(
            math.floor(center - 480 + 0.5),
            0
        )
        if ____type == "nicolas" then
            __L1:r(
                c,
                -500,
                0,
                1960,
                440,
                "#183650"
            )
            __L1:r(
                c,
                -500,
                155,
                1960,
                285,
                "#326975"
            )
            __L1:r(
                c,
                -500,
                280,
                1960,
                160,
                "#5a9795"
            )
            local halo = 94 + math.sin(t * 0.9) * 3
            __L1:oval(
                c,
                480,
                171,
                halo + 16,
                halo + 16,
                "#739b8c",
                4
            )
            __L1:oval(
                c,
                480,
                171,
                halo,
                halo,
                "#d5c58a",
                4
            )
            __L1:oval(
                c,
                480,
                171,
                halo - 7,
                halo - 7,
                "#346d7a",
                4
            )
            __L1:oval(
                c,
                480,
                171,
                54,
                54,
                "#c4dcc0",
                4
            )
            __L1:oval(
                c,
                480,
                171,
                44,
                44,
                "#f7e8af",
                4
            )
            do
                local i = 0
                while i < 12 do
                    local a = i * math.pi / 6 + t * 0.07
                    local xx = 480 + math.cos(a) * (halo + 3)
                    local yy = 171 + math.sin(a) * (halo + 3)
                    __L1:poly(
                        c,
                        __arrL(
                            {
                                __arrL({xx - 4, yy}, 2),
                                __arrL({xx, yy - 8}, 2),
                                __arrL({xx + 4, yy}, 2),
                                __arrL({xx, yy + 8}, 2)
                            },
                            4
                        ),
                        "#ffecb1"
                    )
                    i = i + 1
                end
            end
            do
                local i = 0
                while i < 8 do
                    local x = -65 + i * 158
                    local yy = 235 + math.sin(t * 0.8 + i) * 8
                    __L1:poly(
                        c,
                        __arrL(
                            {
                                __arrL({x, yy}, 2),
                                __arrL({x + 110, yy - 9}, 2),
                                __arrL({x + 80, yy + 16}, 2),
                                __arrL({x + 21, yy + 22}, 2)
                            },
                            4
                        ),
                        "#8abeb3"
                    )
                    __L1:r(
                        c,
                        x + 29,
                        yy + 22,
                        48,
                        8,
                        "#3d7580"
                    )
                    i = i + 1
                end
            end
            for ____, xx in __iterar((__arrL({-72, 109, 747, 920}, 4))) do
                __L1:r(
                    c,
                    xx,
                    149,
                    48,
                    283,
                    "#294c60"
                )
                __L1:r(
                    c,
                    xx + 6,
                    154,
                    36,
                    269,
                    "#aeb99b"
                )
                __L1:r(
                    c,
                    xx + 9,
                    157,
                    7,
                    264,
                    "#e0d3a2"
                )
                __L1:r(
                    c,
                    xx + 25,
                    158,
                    8,
                    263,
                    "#819c93"
                )
                __L1:r(
                    c,
                    xx - 7,
                    142,
                    62,
                    16,
                    "#e4ce8e"
                )
                __L1:r(
                    c,
                    xx - 11,
                    133,
                    70,
                    11,
                    "#a38b59"
                )
                __L1:r(
                    c,
                    xx - 8,
                    414,
                    64,
                    18,
                    "#d6c28c"
                )
                do
                    local j = 0
                    while j < 5 do
                        local yy = 182 + j * 39
                        __L1:r(
                            c,
                            xx + 19,
                            yy,
                            10,
                            3,
                            "#dbf5d7"
                        )
                        __L1:r(
                            c,
                            xx + 22,
                            yy - 4,
                            3,
                            11,
                            "#93dace"
                        )
                        j = j + 1
                    end
                end
            end
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({72, 295}, 2),
                        __arrL({123, 272}, 2),
                        __arrL({153, 286}, 2),
                        __arrL({166, 310}, 2),
                        __arrL({196, 299}, 2),
                        __arrL({209, 332}, 2),
                        __arrL({245, 313}, 2),
                        __arrL({272, 337}, 2)
                    },
                    8
                ),
                "#bcdbc1"
            )
            do
                local i = 0
                while i < 28 do
                    local xx = __L1:hash(i + 37) * 1160 - 100
                    local yy = 24 + __L1:hash(i + 53) * 290 + math.sin(t + i) * 7
                    __L1:r(
                        c,
                        xx,
                        yy,
                        2,
                        2,
                        __t(__mod(i, 2)) and "#e0f8d9" or "#f7e6aa"
                    )
                    if __mod(i, 4) == 0 then
                        __L1:r(
                            c,
                            xx - 3,
                            yy + 1,
                            8,
                            1,
                            "#a2dfd7"
                        )
                        __L1:r(
                            c,
                            xx + 1,
                            yy - 3,
                            1,
                            8,
                            "#a2dfd7"
                        )
                    end
                    i = i + 1
                end
            end
            __L1:r(
                c,
                -500,
                390,
                1960,
                50,
                "#446a74"
            )
            __L1:r(
                c,
                -500,
                389,
                1960,
                7,
                "#b7d0b8"
            )
            do
                local i = 0
                while i < 11 do
                    local xx = -110 + i * 111
                    __L1:r(
                        c,
                        xx,
                        408,
                        88,
                        3,
                        "#80aaa2"
                    )
                    __L1:r(
                        c,
                        xx + 23,
                        404,
                        3,
                        17,
                        "#80aaa2"
                    )
                    i = i + 1
                end
            end
            c:restore()
            __L1:r(
                c,
                0,
                440,
                960,
                100,
                "#657f7d"
            )
            __L1:r(
                c,
                0,
                440,
                960,
                6,
                "#f0dc9b"
            )
            __L1:r(
                c,
                0,
                447,
                960,
                4,
                "#315a65"
            )
            do
                local i = 0
                while i < 20 do
                    local xx = i * 57
                    __L1:r(
                        c,
                        xx,
                        450,
                        2,
                        90,
                        "#3f626b"
                    )
                    __L1:r(
                        c,
                        xx + 3,
                        493,
                        53,
                        2,
                        "#bad3b1"
                    )
                    if __mod(i, 3) == 0 then
                        __L1:r(
                            c,
                            xx + 21,
                            460,
                            3,
                            17,
                            "#abe9da"
                        )
                        __L1:r(
                            c,
                            xx + 15,
                            467,
                            15,
                            3,
                            "#ddedb6"
                        )
                    end
                    i = i + 1
                end
            end
            return
        end
        __L1:r(
            c,
            -500,
            0,
            1960,
            120,
            "#6d6c91"
        )
        __L1:r(
            c,
            -500,
            120,
            1960,
            135,
            "#c38f91"
        )
        __L1:r(
            c,
            -500,
            255,
            1960,
            185,
            "#e2b28a"
        )
        __L1:oval(
            c,
            728,
            175,
            45,
            45,
            "#f5d3a0",
            4
        )
        do
            local i = -2
            while i < 10 do
                local xx = i * 141
                local hh = 85 + __L1:hash(i + 13) * 100
                __L1:favelaHouse(
                    c,
                    xx,
                    360 - hh,
                    132,
                    hh,
                    i + 30,
                    t,
                    true
                )
                do
                    local j = 0
                    while j < 3 do
                        __L1:r(
                            c,
                            xx + 14 + j * 36,
                            341 - hh,
                            15,
                            23,
                            "#ebcc93"
                        )
                        j = j + 1
                    end
                end
                i = i + 1
            end
        end
        __L1:r(
            c,
            -500,
            348,
            1960,
            92,
            "#5a555d"
        )
        __L1:r(
            c,
            -500,
            347,
            1960,
            8,
            "#c2987c"
        )
        do
            local xx = -500
            while xx < 1460 do
                __L1:r(
                    c,
                    xx,
                    357,
                    2,
                    79,
                    "#8d7370"
                )
                __L1:r(
                    c,
                    xx + 9,
                    389,
                    28,
                    1,
                    "#9f8178"
                )
                xx = xx + 45
            end
        end
        for ____, xx in __iterar((__arrL({71, 842}, 2))) do
            __L1:r(
                c,
                xx,
                142,
                7,
                207,
                "#344a59"
            )
            __L1:r(
                c,
                xx - 19,
                132,
                47,
                15,
                "#263b4b"
            )
            do
                local j = 0
                while j < 4 do
                    __L1:r(
                        c,
                        xx - 14 + j * 10,
                        135,
                        7,
                        7,
                        "#f7d997"
                    )
                    j = j + 1
                end
            end
            __L1:r(
                c,
                xx - 24,
                270,
                58,
                78,
                "#293c47"
            )
            __L1:r(
                c,
                xx - 20,
                274,
                50,
                70,
                "#58636a"
            )
            __L1:oval(
                c,
                xx + 5,
                307,
                23,
                23,
                "#253c48",
                3
            )
            __L1:oval(
                c,
                xx + 5,
                307,
                14,
                14,
                "#a7b5aa",
                3
            )
        end
        __L1:r(
            c,
            245,
            151,
            470,
            46,
            "#3b4555"
        )
        __L1:r(
            c,
            250,
            156,
            460,
            36,
            "#77556b"
        )
        c.fillStyle = "#f5dca5"
        c.font = "bold 22px monospace"
        c:fillText("FREDDY · ÚLTIMO RECADO", 274, 182)
        __L1:r(
            c,
            -200,
            236,
            1360,
            2,
            "#46505a"
        )
        do
            local i = 0
            while i < 21 do
                local xx = -195 + i * 65
                local wave = math.sin(t * 1.5 + i) * 3
                __L1:poly(
                    c,
                    __arrL(
                        {
                            __arrL({xx, 238}, 2),
                            __arrL({xx + 26, 238}, 2),
                            __arrL({xx + 14, 259 + wave}, 2)
                        },
                        3
                    ),
                    __mod(i, 3) == 0 and "#e3b887" or (__mod(i, 3) == 1 and "#8dc4bf" or "#cb8e9f")
                )
                i = i + 1
            end
        end
        __L1:r(
            c,
            353,
            309,
            253,
            16,
            "#263d49"
        )
        c.fillStyle = "#e9ca9b"
        c.font = "bold 11px monospace"
        c:fillText("ÔÔÔ REEEIS, ASSISTE ESSA!", 374, 321)
        c:restore()
        __L1:r(
            c,
            0,
            440,
            960,
            100,
            "#77645e"
        )
        __L1:r(
            c,
            0,
            440,
            960,
            6,
            "#d7b38a"
        )
        do
            local i = 0
            while i < 20 do
                __L1:r(
                    c,
                    i * 51,
                    452,
                    1,
                    88,
                    "#4d4e56"
                )
                __L1:r(
                    c,
                    i * 51 + 8,
                    480,
                    26,
                    2,
                    "#a88a78"
                )
                i = i + 1
            end
        end
        __L1:r(
            c,
            0,
            499,
            960,
            2,
            "#b59880"
        )
    end
    __L1.monitorArena = function(self, c, ____type, camera, t, homeX)
        local ____t_result_739
        if __t(homeX) then
            ____t_result_739 = homeX - camera
        else
            ____t_result_739 = 480
        end
        local center = ____t_result_739
        __L1:r(
            c,
            0,
            0,
            960,
            540,
            "#dbe9e6"
        )
        __L1:r(
            c,
            0,
            292,
            960,
            148,
            "#225075"
        )
        __L1:r(
            c,
            0,
            288,
            960,
            8,
            "#f3f4e5"
        )
        c:save()
        c:translate(
            math.floor(center - 480 + 0.5),
            0
        )
        do
            local i = 0
            while i < 6 do
                local x = -80 + i * 200
                __L1:r(
                    c,
                    x,
                    126,
                    130,
                    135,
                    "#3a667f"
                )
                __L1:r(
                    c,
                    x + 6,
                    132,
                    118,
                    123,
                    "#96c9ce"
                )
                __L1:r(
                    c,
                    x + 62,
                    132,
                    5,
                    123,
                    "#eef1df"
                )
                __L1:r(
                    c,
                    x + 6,
                    191,
                    118,
                    5,
                    "#edf2de"
                )
                __L1:r(
                    c,
                    x - 6,
                    258,
                    142,
                    8,
                    "#c3d9ce"
                )
                i = i + 1
            end
        end
        __L1:r(
            c,
            125,
            45,
            710,
            45,
            "#f7f1da"
        )
        __L1:r(
            c,
            131,
            51,
            698,
            33,
            "#254e71"
        )
        c.fillStyle = "#fff0c4"
        c.font = "bold 21px monospace"
        c.textAlign = "center"
        c:fillText(____type == "igor" and "CANTINA · FISCALIZAÇÃO DO LANCHE" or "CORREDOR · FISCALIZAÇÃO MÁXIMA", 480, 75)
        if ____type == "igor" then
            __L1:r(
                c,
                65,
                319,
                210,
                121,
                "#b08c65"
            )
            __L1:r(
                c,
                59,
                308,
                222,
                15,
                "#edd9ad"
            )
            __L1:r(
                c,
                76,
                331,
                188,
                14,
                "#8c7356"
            )
            do
                local j = 0
                while j < 5 do
                    __L1:oval(
                        c,
                        89 + j * 35,
                        302,
                        13,
                        7,
                        "#d8a269",
                        3
                    )
                    __L1:r(
                        c,
                        82 + j * 35,
                        299,
                        14,
                        3,
                        "#efc68d"
                    )
                    j = j + 1
                end
            end
            __L1:r(
                c,
                695,
                324,
                190,
                116,
                "#668d99"
            )
            __L1:r(
                c,
                688,
                314,
                204,
                13,
                "#d4ddd0"
            )
            c.font = "bold 13px monospace"
            c.fillStyle = "#f0e8bd"
            c:fillText("LANCHES ACABARAM", 172, 363)
            c:fillText("BARRIGA EM SERVIÇO", 789, 361)
        else
            for ____, start in __iterar((__arrL({45, 760}, 2))) do
                do
                    local j = 0
                    while j < 3 do
                        local x = start + j * 52
                        __L1:r(
                            c,
                            x,
                            301,
                            45,
                            139,
                            "#5c8ca2"
                        )
                        __L1:r(
                            c,
                            x + 3,
                            306,
                            39,
                            132,
                            "#7aa6b2"
                        )
                        __L1:r(
                            c,
                            x + 6,
                            311,
                            33,
                            8,
                            "#31617e"
                        )
                        __L1:r(
                            c,
                            x + 7,
                            350,
                            8,
                            4,
                            "#e3dfc1"
                        )
                        j = j + 1
                    end
                end
            end
            __L1:r(
                c,
                350,
                140,
                260,
                100,
                "#75b5b4"
            )
            __L1:r(
                c,
                357,
                147,
                246,
                86,
                "#8bcac5"
            )
            c.font = "bold 16px monospace"
            c.fillStyle = "#295d68"
            c:fillText("BOLINHAS NO CESTO!", 480, 179)
            c.font = "bold 12px monospace"
            c:fillText("OLHE A MIRA. ATAQUE NA RECARGA.", 480, 210)
        end
        __L1:r(
            c,
            -300,
            440,
            1560,
            100,
            "#a7bcb9"
        )
        __L1:r(
            c,
            -300,
            440,
            1560,
            6,
            "#f2edcf"
        )
        do
            local x = -300
            while x < 1260 do
                __L1:r(
                    c,
                    x,
                    446,
                    2,
                    94,
                    "#8fa7a5"
                )
                __L1:r(
                    c,
                    x + 7,
                    479,
                    46,
                    2,
                    "#c7d4c8"
                )
                x = x + 64
            end
        end
        c:restore()
    end
    __L1.arena = function(self, c, bossType, camera, t, homeX)
        if camera == nil then
            camera = 0
        end
        if t == nil then
            t = 0
        end
        if homeX == nil then
            homeX = 0
        end
        c:save()
        c.imageSmoothingEnabled = false
        local ____temp_740
        if type(bossType) == "table" then
            ____temp_740 = bossType.type
        else
            ____temp_740 = bossType
        end
        local ____type = ____temp_740
        if __t(____type == "dede" or ____type == "arthur") then
            __L1:questArena(
                c,
                ____type,
                camera,
                t,
                homeX
            )
            c:restore()
            return
        end
        if __t(____type == "nicolas" or ____type == "freddy") then
            __L1:newArena(
                c,
                ____type,
                camera,
                t,
                homeX
            )
            c:restore()
            return
        end
        if __t(____type == "reeisBoss" or ____type == "giant") then
            __L1:specialArena(
                c,
                ____type,
                camera,
                t,
                homeX
            )
            c:restore()
            return
        end
        local ____t_result_741
        if __t(homeX) then
            ____t_result_741 = homeX - camera
        else
            ____t_result_741 = 480
        end
        local center = ____t_result_741
        if __t(____type == "igor" or ____type == "kaique") then
            __L1:monitorArena(
                c,
                ____type,
                camera,
                t,
                homeX
            )
            c:restore()
            return
        end
        local marco = ____type == "marco"
        local menezes = ____type == "menezes"
        __L1:r(
            c,
            0,
            0,
            960,
            540,
            __t(marco) and "#27233d" or (__t(menezes) and "#382b35" or "#8bb7d3")
        )
        c:save()
        c:translate(
            math.floor(center - 480 + 0.5),
            0
        )
        if __t(marco) then
            do
                local i = 0
                while i < 10 do
                    local x = -100 + i * 120
                    __L1:poly(
                        c,
                        __arrL(
                            {
                                __arrL({x, 0}, 2),
                                __arrL({x + 94, 0}, 2),
                                __arrL({x + 103, 237}, 2),
                                __arrL({x + 81, 229}, 2),
                                __arrL({x + 55, 244}, 2),
                                __arrL({x + 34, 230}, 2),
                                __arrL({x + 8, 239}, 2)
                            },
                            7
                        ),
                        __t(__mod(i, 2)) and "#69617d" or "#5a546e"
                    )
                    __L1:r(
                        c,
                        x + 16,
                        43,
                        62,
                        2,
                        "#a69bad"
                    )
                    __L1:r(
                        c,
                        x + 22,
                        61,
                        54,
                        2,
                        "#a69bad"
                    )
                    i = i + 1
                end
            end
            __L1:r(
                c,
                177,
                49,
                609,
                41,
                "#3f3653"
            )
            __L1:r(
                c,
                182,
                54,
                599,
                31,
                "#6c5677"
            )
            c.fillStyle = "#f2d8a6"
            c.font = "bold 22px monospace"
            c:fillText("RABISCOS À SOLTA", 332, 78)
            do
                local i = 0
                while i < 5 do
                    local x = 70 + i * 203
                    local y = 170 + __mod(i, 2) * 59
                    c:save()
                    c:translate(x, y)
                    c:scale(2.5, 2.5)
                    __L1:doodle(
                        c,
                        0,
                        0,
                        __mod(i, 3),
                        t * 0.35 + i,
                        true
                    )
                    c:restore()
                    i = i + 1
                end
            end
            do
                local i = 0
                while i < 13 do
                    local x = __L1:hash(i + 3) * 1000
                    local yy = 70 + __L1:hash(i + 18) * 230
                    __L1:r(
                        c,
                        x,
                        yy + math.sin(t + i) * 5,
                        4,
                        8,
                        "#d8c6dd"
                    )
                    i = i + 1
                end
            end
            __L1:r(
                c,
                -300,
                347,
                1560,
                93,
                "#4b3b60"
            )
            do
                local x = -300
                while x < 1260 do
                    __L1:r(
                        c,
                        x,
                        347,
                        3,
                        93,
                        "#76547f"
                    )
                    __L1:r(
                        c,
                        x + 17,
                        380,
                        18,
                        2,
                        "#9a6d94"
                    )
                    x = x + 49
                end
            end
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({302, 278}, 2),
                        __arrL({476, 292}, 2),
                        __arrL({477, 387}, 2),
                        __arrL({300, 369}, 2)
                    },
                    4
                ),
                "#b1a2bb"
            )
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({480, 292}, 2),
                        __arrL({654, 277}, 2),
                        __arrL({657, 369}, 2),
                        __arrL({481, 387}, 2)
                    },
                    4
                ),
                "#cfbfd0"
            )
            __L1:r(
                c,
                476,
                291,
                6,
                97,
                "#68546f"
            )
            do
                local j = 0
                while j < 5 do
                    __L1:r(
                        c,
                        323,
                        299 + j * 13,
                        116,
                        2,
                        "#7c6385"
                    )
                    __L1:r(
                        c,
                        513,
                        299 + j * 13,
                        116,
                        2,
                        "#997ea1"
                    )
                    j = j + 1
                end
            end
        elseif __t(menezes) then
            __L1:r(
                c,
                -300,
                27,
                1560,
                27,
                "#6c514b"
            )
            __L1:r(
                c,
                -300,
                54,
                1560,
                13,
                "#c1a16f"
            )
            do
                local side = 0
                while side < 2 do
                    local x = __t(side) and 817 or -200
                    __L1:r(
                        c,
                        x,
                        54,
                        345,
                        344,
                        "#7b4252"
                    )
                    do
                        local j = 0
                        while j < 12 do
                            __L1:r(
                                c,
                                x + j * 28,
                                60,
                                10,
                                330,
                                "#a85e61"
                            )
                            j = j + 1
                        end
                    end
                    __L1:poly(
                        c,
                        __arrL(
                            {
                                __arrL({x, 253}, 2),
                                __arrL({x + 344, 315}, 2),
                                __arrL({x + 344, 343}, 2),
                                __arrL({x, 286}, 2)
                            },
                            4
                        ),
                        "#c39865"
                    )
                    side = side + 1
                end
            end
            __L1:r(
                c,
                181,
                83,
                600,
                227,
                "#8c7552"
            )
            __L1:r(
                c,
                188,
                90,
                586,
                213,
                "#2f5147"
            )
            __L1:r(
                c,
                197,
                98,
                568,
                2,
                "#668168"
            )
            c.fillStyle = "#e7e2bd"
            c.font = "bold 22px monospace"
            c:fillText("PALCO DA PROVOCAÇÃO", 265, 129)
            c.font = "bold 19px monospace"
            c:fillText("da roça poudiaaam", 262, 170)
            c:fillText("reeeis pouddiaaam", 417, 199)
            c:fillText("da roça pegou ar", 250, 232)
            c.font = "bold 15px monospace"
            c:fillText("teketeketeketeke", 438, 261)
            c:fillText("o pra ravid falando sozinho", 229, 285)
            for ____, x in __iterar((__arrL({107, 779}, 2))) do
                __L1:r(
                    c,
                    x,
                    286,
                    81,
                    152,
                    "#263b37"
                )
                __L1:r(
                    c,
                    x + 5,
                    291,
                    71,
                    142,
                    "#47544c"
                )
                __L1:oval(
                    c,
                    x + 40,
                    326,
                    25,
                    25,
                    "#25342f",
                    3
                )
                __L1:oval(
                    c,
                    x + 40,
                    326,
                    17,
                    17,
                    "#8b9978",
                    3
                )
                __L1:oval(
                    c,
                    x + 40,
                    326,
                    7,
                    7,
                    "#3f5749",
                    2
                )
                __L1:oval(
                    c,
                    x + 40,
                    395,
                    28,
                    28,
                    "#25342f",
                    3
                )
                __L1:oval(
                    c,
                    x + 40,
                    395,
                    18,
                    18,
                    "#839572",
                    3
                )
                __L1:oval(
                    c,
                    x + 40,
                    395,
                    7,
                    7,
                    "#3f5749",
                    2
                )
            end
            __L1:r(
                c,
                0,
                398,
                960,
                42,
                "#68594e"
            )
            do
                local x = 0
                while x < 960 do
                    __L1:r(
                        c,
                        x,
                        400,
                        2,
                        40,
                        "#9d8262"
                    )
                    x = x + 53
                end
            end
        else
            __L1:cloud(
                c,
                64,
                63,
                1.6,
                "#fff4d6"
            )
            __L1:cloud(
                c,
                701,
                96,
                1.4,
                "#fff4d6"
            )
            __L1:oval(
                c,
                751,
                83,
                30,
                30,
                "#ffe7a8",
                4
            )
            __L1:r(
                c,
                -200,
                239,
                1360,
                201,
                "#9e7256"
            )
            __L1:r(
                c,
                -200,
                243,
                1360,
                9,
                "#d1a273"
            )
            __L1:r(
                c,
                211,
                154,
                541,
                45,
                "#6f4937"
            )
            __L1:r(
                c,
                202,
                147,
                558,
                15,
                "#e4bf83"
            )
            do
                local i = 0
                while i < 12 do
                    __L1:r(
                        c,
                        215 + i * 46,
                        159,
                        13,
                        15 + __mod(i, 3) * 6,
                        "#d8b17a"
                    )
                    i = i + 1
                end
            end
            for ____, x in __iterar((__arrL({227, 718}, 2))) do
                __L1:r(
                    c,
                    x,
                    192,
                    16,
                    237,
                    "#644634"
                )
                __L1:r(
                    c,
                    x + 4,
                    193,
                    5,
                    231,
                    "#aa8055"
                )
            end
            __L1:r(
                c,
                374,
                262,
                214,
                152,
                "#624937"
            )
            __L1:r(
                c,
                385,
                272,
                192,
                132,
                "#85a45d"
            )
            __L1:r(
                c,
                393,
                279,
                176,
                125,
                "#a8bd69"
            )
            __L1:r(
                c,
                410,
                300,
                143,
                7,
                "#72994f"
            )
            __L1:r(
                c,
                410,
                329,
                143,
                7,
                "#72994f"
            )
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({374, 267}, 2),
                        __arrL({380, 235}, 2),
                        __arrL({406, 258}, 2),
                        __arrL({434, 222}, 2),
                        __arrL({461, 254}, 2),
                        __arrL({486, 213}, 2),
                        __arrL({513, 255}, 2),
                        __arrL({544, 229}, 2),
                        __arrL({565, 259}, 2),
                        __arrL({588, 237}, 2),
                        __arrL({588, 272}, 2)
                    },
                    11
                ),
                "#6b8d43"
            )
            __L1:r(
                c,
                356,
                365,
                35,
                67,
                "#74643e"
            )
            __L1:r(
                c,
                570,
                365,
                35,
                67,
                "#74643e"
            )
            __L1:r(
                c,
                359,
                360,
                33,
                12,
                "#b6c26b"
            )
            __L1:r(
                c,
                570,
                360,
                33,
                12,
                "#b6c26b"
            )
            for ____, x in __iterar((__arrL({128, 806}, 2))) do
                __L1:r(
                    c,
                    x - 48,
                    372,
                    96,
                    58,
                    "#704934"
                )
                __L1:r(
                    c,
                    x - 44,
                    382,
                    88,
                    16,
                    "#d0a66b"
                )
                __L1:r(
                    c,
                    x - 49,
                    369,
                    98,
                    13,
                    "#e5c58e"
                )
                do
                    local i = 0
                    while i < 5 do
                        __L1:r(
                            c,
                            x - 43 + i * 19,
                            380,
                            7,
                            8 + __mod(i, 2) * 5,
                            "#e5c58e"
                        )
                        i = i + 1
                    end
                end
                __L1:cake(c, x, 369)
            end
            c.fillStyle = "#f7e4bc"
            c.font = "bold 18px monospace"
            c:fillText("O TRONO DO BOLO ROUBADO", 339, 183)
            do
                local i = 0
                while i < 10 do
                    local x = 116 + i * 78
                    __L1:oval(
                        c,
                        x,
                        433,
                        22,
                        5,
                        "#84a24e",
                        2
                    )
                    __L1:r(
                        c,
                        x + 4,
                        425 - math.abs(math.sin(t * 2 + i)) * 6,
                        3,
                        6,
                        "#bbcb6c"
                    )
                    i = i + 1
                end
            end
        end
        c:restore()
        __L1:r(
            c,
            0,
            440,
            960,
            100,
            __t(marco) and "#4c3a5e" or (__t(menezes) and "#755d47" or "#865c40")
        )
        __L1:r(
            c,
            0,
            440,
            960,
            6,
            __t(marco) and "#c19bc6" or (__t(menezes) and "#dbbd86" or "#d8ba7b")
        )
        do
            local i = 0
            while i < 20 do
                __L1:r(
                    c,
                    i * 53,
                    451,
                    1,
                    89,
                    __t(marco) and "#735780" or (__t(menezes) and "#a18461" or "#a98256")
                )
                __L1:r(
                    c,
                    i * 53 + 7,
                    473,
                    26,
                    2,
                    __t(marco) and "#8b6594" or (__t(menezes) and "#8f7255" or "#b2925c")
                )
                i = i + 1
            end
        end
        c:restore()
    end
    __L1.thug = function(self, c, x, y, t, o)
        if t == nil then
            t = 0
        end
        if o == nil then
            o = {}
        end
        c:save()
        c.imageSmoothingEnabled = false
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        c:scale(
            __lt(o.facing, 0) and -1 or 1,
            1
        )
        local ____t_result_744
        local ____t_743 = __t
        local ____TS__Number_result_742 = __TS__Number(o.scale)
        __O[267] = ____TS__Number_result_742
        if ____t_743(____TS__Number_result_742) then
            ____t_result_744 = __O[267]
        else
            ____t_result_744 = 1
        end
        local scale = ____t_result_744
        c:scale(scale, scale)
        local ____t_result_747
        local ____t_746 = __t
        local ____TS__Number_result_745 = __TS__Number(o.tier)
        __O[268] = ____TS__Number_result_745
        if ____t_746(____TS__Number_result_745) then
            ____t_result_747 = __O[268]
        else
            ____t_result_747 = 1
        end
        local tier = math.max(
            1,
            math.min(4, ____t_result_747)
        )
        local walking = o.moving ~= false
        local ____t_result_748
        if __t(walking) then
            ____t_result_748 = math.sin(t * 9) * 7
        else
            ____t_result_748 = 0
        end
        local step = ____t_result_748
        local ____t_result_749
        if __t(walking) then
            ____t_result_749 = math.floor(math.abs(math.sin(t * 9)) * 2 + 0.5)
        else
            ____t_result_749 = math.floor(math.sin(t * 2) + 0.5)
        end
        local bob = ____t_result_749
        __L1:oval(
            c,
            0,
            0,
            17,
            3,
            "#2a443b",
            2
        )
        for ____, side in __iterar((__arrL({-1, 1}, 2))) do
            local fx = side * 6 + math.floor(step * side + 0.5)
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL({side * 5, -22}, 2),
                        __arrL({side * 4, -12}, 2),
                        __arrL({fx, -4}, 2)
                    },
                    3
                ),
                9,
                "#2d3035"
            )
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL({side * 5, -22}, 2),
                        __arrL({side * 4, -12}, 2),
                        __arrL({fx, -4}, 2)
                    },
                    3
                ),
                5,
                __t(__mod(tier, 2)) and "#3e5267" or "#4f4b59"
            )
            __L1:r(
                c,
                fx - 4,
                -5,
                12,
                5,
                "#242f35"
            )
            __L1:r(
                c,
                fx - 3,
                -2,
                10,
                2,
                "#b1b59e"
            )
        end
        c:translate(0, -bob)
        local hood = __get(
            __arrL({"#567573", "#6b576e", "#7b634a", "#443f64"}, 4),
            tier - 1
        )
        local skin = __get(
            __arrL({"#a47550", "#d1aa84", "#bc8762", "#9a684b"}, 4),
            tier - 1
        )
        __L1:r(
            c,
            -15,
            -41,
            31,
            24,
            "#252b33"
        )
        __L1:r(
            c,
            -13,
            -40,
            27,
            21,
            hood
        )
        __L1:r(
            c,
            -2,
            -38,
            3,
            19,
            "#93aca4"
        )
        __L1:r(
            c,
            -14,
            -25,
            28,
            4,
            "#38494c"
        )
        __L1:r(
            c,
            -14,
            -60,
            29,
            22,
            "#282e36"
        )
        __L1:r(
            c,
            -13,
            -65,
            27,
            12,
            hood
        )
        __L1:r(
            c,
            -10,
            -59,
            21,
            17,
            skin
        )
        __L1:r(
            c,
            -11,
            -58,
            4,
            16,
            hood
        )
        __L1:r(
            c,
            9,
            -58,
            5,
            15,
            hood
        )
        __L1:r(
            c,
            -6,
            -54,
            6,
            2,
            "#27373a"
        )
        __L1:r(
            c,
            5,
            -54,
            6,
            2,
            "#27373a"
        )
        __L1:r(
            c,
            -8,
            -48,
            21,
            8,
            "#34484d"
        )
        __L1:r(
            c,
            -4,
            -45,
            12,
            1,
            "#657a79"
        )
        local ____t_result_750
        if __t(o.attack) then
            ____t_result_750 = math.floor((0.5 + 0.5 * math.sin(t * 25)) * 4 + 0.5)
        else
            ____t_result_750 = 0
        end
        local recoil = ____t_result_750
        local barrel = o.weapon == "carbine" and 37 or (o.weapon == "scatter" and 31 or 20)
        c:save()
        c:translate(-recoil, 0)
        __L1:limb(
            c,
            __arrL(
                {
                    __arrL({-11, -35}, 2),
                    __arrL({-7, -27}, 2),
                    __arrL({17, -28}, 2)
                },
                3
            ),
            8,
            "#26353a"
        )
        __L1:limb(
            c,
            __arrL(
                {
                    __arrL({-11, -35}, 2),
                    __arrL({-7, -27}, 2),
                    __arrL({17, -28}, 2)
                },
                3
            ),
            5,
            hood
        )
        __L1:limb(
            c,
            __arrL(
                {
                    __arrL({12, -36}, 2),
                    __arrL({20, -31}, 2),
                    __arrL({26, -29}, 2)
                },
                3
            ),
            8,
            "#26353a"
        )
        __L1:limb(
            c,
            __arrL(
                {
                    __arrL({12, -36}, 2),
                    __arrL({20, -31}, 2),
                    __arrL({26, -29}, 2)
                },
                3
            ),
            5,
            skin
        )
        __L1:r(
            c,
            15,
            -33,
            barrel,
            7,
            "#263b43"
        )
        __L1:r(
            c,
            18,
            -35,
            barrel - 6,
            3,
            "#9aabaa"
        )
        __L1:r(
            c,
            23,
            -26,
            7,
            10,
            "#52616a"
        )
        __L1:r(
            c,
            27,
            -17,
            8,
            3,
            "#253942"
        )
        if o.weapon == "scatter" then
            __L1:r(
                c,
                26,
                -30,
                18,
                3,
                "#ad8664"
            )
            __L1:r(
                c,
                20,
                -26,
                8,
                8,
                "#92714e"
            )
        elseif o.weapon == "carbine" then
            __L1:r(
                c,
                13,
                -31,
                7,
                7,
                "#5c6e68"
            )
            __L1:r(
                c,
                37,
                -29,
                5,
                7,
                "#849c91"
            )
            __L1:r(
                c,
                28,
                -40,
                9,
                4,
                "#354d56"
            )
        end
        local ____t_752 = __t
        local ____t_result_751
        if __t(o.attack) then
            ____t_result_751 = math.sin(t * 29) > 0.7
        else
            ____t_result_751 = o.attack
        end
        if ____t_752(____t_result_751) then
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({15 + barrel, -33}, 2),
                        __arrL({24 + barrel, -38}, 2),
                        __arrL({22 + barrel, -31}, 2),
                        __arrL({30 + barrel, -29}, 2),
                        __arrL({22 + barrel, -26}, 2),
                        __arrL({24 + barrel, -21}, 2),
                        __arrL({15 + barrel, -26}, 2)
                    },
                    7
                ),
                "#ffd593"
            )
        end
        c:restore()
        if tier > 1 then
            __L1:r(
                c,
                -8,
                -36,
                17,
                12,
                "#3c5158"
            )
            __L1:r(
                c,
                -6,
                -34,
                13,
                2,
                "#718a83"
            )
            do
                local i = 0
                while i < tier - 1 do
                    __L1:r(
                        c,
                        -5 + i * 4,
                        -29,
                        2,
                        2,
                        "#dab473"
                    )
                    i = i + 1
                end
            end
        end
        if __t(o.hit) then
            c.globalAlpha = c.globalAlpha * 0.55
            __L1:r(
                c,
                -15,
                -64,
                32,
                46,
                "#ffe4bf"
            )
        end
        c:restore()
    end
    __L1.giant = function(self, c, x, y, t, o)
        if t == nil then
            t = 0
        end
        if o == nil then
            o = {}
        end
        c:save()
        c.imageSmoothingEnabled = false
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        c:scale(
            __lt(o.facing, 0) and -1 or 1,
            1
        )
        local ____t_result_755
        local ____t_754 = __t
        local ____TS__Number_result_753 = __TS__Number(o.scale)
        __O[269] = ____TS__Number_result_753
        if ____t_754(____TS__Number_result_753) then
            ____t_result_755 = __O[269]
        else
            ____t_result_755 = 1
        end
        local size = ____t_result_755
        c:scale(size, size)
        local pulse = math.floor(math.sin(t * 3) * 3 + 0.5)
        local attack = not not __t(o.attack)
        local ____t_result_756
        if __t(attack) then
            ____t_result_756 = math.floor((0.5 + 0.5 * math.sin(t * 5)) * 30 + 0.5)
        else
            ____t_result_756 = 0
        end
        local raise = ____t_result_756
        __L1:oval(
            c,
            0,
            0,
            83,
            10,
            "#263b39",
            4
        )
        for ____, side in __iterar((__arrL({-1, 1}, 2))) do
            local ____t_result_757
            if __t(o.moving) then
                ____t_result_757 = math.max(
                    0,
                    math.sin(t * 5 + side)
                ) * 8
            else
                ____t_result_757 = 0
            end
            local lift = ____t_result_757
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({side * 18, -48}, 2),
                        __arrL({side * 49, -42}, 2),
                        __arrL({side * 61, -lift}, 2),
                        __arrL({side * 25, -lift}, 2)
                    },
                    4
                ),
                "#252039"
            )
            __L1:r(
                c,
                side > 0 and 23 or -62,
                -13 - lift,
                40,
                12,
                "#8c6aa1"
            )
            __L1:r(
                c,
                side > 0 and 27 or -57,
                -10 - lift,
                31,
                4,
                "#c4a2b8"
            )
        end
        __L1:poly(
            c,
            __arrL(
                {
                    __arrL({-59, -133}, 2),
                    __arrL({-34, -157}, 2),
                    __arrL({-15, -150}, 2),
                    __arrL({0, -169}, 2),
                    __arrL({20, -150}, 2),
                    __arrL({41, -159}, 2),
                    __arrL({63, -133}, 2),
                    __arrL({70, -78}, 2),
                    __arrL({53, -39}, 2),
                    __arrL({17, -27}, 2),
                    __arrL({-17, -26}, 2),
                    __arrL({-56, -44}, 2),
                    __arrL({-72, -81}, 2)
                },
                13
            ),
            "#211e37"
        )
        __L1:poly(
            c,
            __arrL(
                {
                    __arrL({-51, -129}, 2),
                    __arrL({-30, -149}, 2),
                    __arrL({-12, -139}, 2),
                    __arrL({1, -157}, 2),
                    __arrL({17, -140}, 2),
                    __arrL({37, -147}, 2),
                    __arrL({55, -125}, 2),
                    __arrL({59, -82}, 2),
                    __arrL({43, -47}, 2),
                    __arrL({15, -37}, 2),
                    __arrL({-15, -37}, 2),
                    __arrL({-47, -51}, 2),
                    __arrL({-60, -84}, 2)
                },
                13
            ),
            "#4a3c65"
        )
        __L1:poly(
            c,
            __arrL(
                {
                    __arrL({-52, -96}, 2),
                    __arrL({-40, -121}, 2),
                    __arrL({-15, -126}, 2),
                    __arrL({12, -123}, 2),
                    __arrL({44, -115}, 2),
                    __arrL({54, -89}, 2),
                    __arrL({31, -62}, 2),
                    __arrL({-8, -61}, 2),
                    __arrL({-41, -72}, 2)
                },
                9
            ),
            "#6d527f"
        )
        for ____, side in __iterar((__arrL({-1, 1}, 2))) do
            local ____temp_759 = -106 - raise
            local ____temp_758
            if side > 0 then
                ____temp_758 = pulse
            else
                ____temp_758 = -pulse
            end
            local yy = ____temp_759 + ____temp_758
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL({side * 48, -111}, 2),
                        __arrL({side * 83, yy}, 2),
                        __arrL({side * 98, yy + 45}, 2)
                    },
                    3
                ),
                31,
                "#211e37"
            )
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL({side * 48, -111}, 2),
                        __arrL({side * 83, yy}, 2),
                        __arrL({side * 98, yy + 45}, 2)
                    },
                    3
                ),
                22,
                "#655076"
            )
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({side * 84, yy + 29}, 2),
                        __arrL({side * 108, yy + 27}, 2),
                        __arrL({side * 117, yy + 49}, 2),
                        __arrL({side * 105, yy + 64}, 2),
                        __arrL({side * 82, yy + 56}, 2)
                    },
                    5
                ),
                "#29243f"
            )
            do
                local j = 0
                while j < 3 do
                    local ____L1_r_762 = __L1.r
                    local ____c_761 = c
                    local ____temp_760
                    if side > 0 then
                        ____temp_760 = 91 + j * 7
                    else
                        ____temp_760 = -112 + j * 7
                    end
                    ____L1_r_762(
                        __L1,
                        ____c_761,
                        ____temp_760,
                        yy + 46,
                        5,
                        15,
                        "#bca5b7"
                    )
                    j = j + 1
                end
            end
        end
        __L1:oval(
            c,
            -23,
            -116 + pulse,
            19,
            23,
            "#c8e0b3",
            3
        )
        __L1:oval(
            c,
            24,
            -118 - pulse,
            19,
            22,
            "#d3b8da",
            3
        )
        __L1:r(
            c,
            -33,
            -131 + pulse,
            17,
            4,
            "#293347"
        )
        __L1:r(
            c,
            -33,
            -128 + pulse,
            4,
            24,
            "#293347"
        )
        __L1:r(
            c,
            -33,
            -116 + pulse,
            16,
            4,
            "#293347"
        )
        __L1:r(
            c,
            -21,
            -115 + pulse,
            4,
            13,
            "#293347"
        )
        __L1:r(
            c,
            -32,
            -105 + pulse,
            14,
            4,
            "#293347"
        )
        __L1:r(
            c,
            15,
            -132 - pulse,
            20,
            4,
            "#3b2e4c"
        )
        __L1:limb(
            c,
            __arrL(
                {
                    __arrL({33, -128 - pulse}, 2),
                    __arrL({22, -105 - pulse}, 2)
                },
                2
            ),
            4,
            "#3b2e4c"
        )
        __L1:r(
            c,
            -27,
            -126 + pulse,
            4,
            4,
            "#f1f4cb"
        )
        __L1:r(
            c,
            24,
            -128 - pulse,
            4,
            4,
            "#f6e3ed"
        )
        local maw = __t(attack) and 23 or 15 + math.floor(math.sin(t * 2) * 2 + 0.5)
        __L1:r(
            c,
            -35,
            -87,
            73,
            maw,
            "#151a2b"
        )
        do
            local i = 0
            while i < 7 do
                __L1:r(
                    c,
                    -31 + i * 10,
                    -87,
                    6,
                    7 + __mod(i, 2) * 3,
                    "#d5c7cc"
                )
                __L1:r(
                    c,
                    -26 + i * 10,
                    -87 + maw - 6,
                    5,
                    6,
                    "#a0c5a0"
                )
                i = i + 1
            end
        end
        __L1:r(
            c,
            -17,
            -79,
            37,
            2,
            "#8d667d"
        )
        do
            local i = 0
            while i < 7 do
                local xx = -45 + i * 15
                local yy = -51 + __mod(i, 3) * 4
                __L1:r(
                    c,
                    xx,
                    yy,
                    5,
                    8 + __mod(t * 12 + i * 3, 11),
                    "#9ab276"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 9 do
                local xx = math.sin(t * 2 + i) * 78
                local yy = -22 - __mod(t * 32 + i * 19, 157)
                __L1:r(
                    c,
                    xx,
                    yy,
                    3,
                    6,
                    __t(__mod(i, 2)) and "#c6a1cb" or "#98ba8a"
                )
                i = i + 1
            end
        end
        if __t(o.hit) then
            c.globalAlpha = c.globalAlpha * 0.6
            __L1:oval(
                c,
                0,
                -95,
                67,
                67,
                "#f6d8df",
                4
            )
        end
        c:restore()
    end
    __L1.sarueTrap = function(self, c, x, y, t, active)
        if t == nil then
            t = 0
        end
        if active == nil then
            active = false
        end
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        local alpha = c.globalAlpha
        c.globalAlpha = c.globalAlpha * (__t(active) and 0.9 or 0.65)
        __L1:oval(
            c,
            0,
            -2,
            36,
            7,
            __t(active) and "#a13c45" or "#5d416b",
            2
        )
        __L1:r(
            c,
            -32,
            -7,
            65,
            10,
            __t(active) and "#e14b4b" or "#9e78a7"
        )
        __L1:r(
            c,
            -29,
            -6,
            59,
            6,
            __t(active) and "#582b40" or "#3a344f"
        )
        c.fillStyle = __t(active) and "#ffe1ca" or "#d9b9d8"
        c.font = "bold 9px monospace"
        c.textAlign = "center"
        c:fillText("SARUÊ!", 0, 1)
        c.textAlign = "left"
        if __t(active) then
            c.globalAlpha = alpha * 0.65
            do
                local i = 0
                while i < 8 do
                    local yy = __TS__Number(-__mod(t * 70 + i * 12, 60))
                    __L1:r(
                        c,
                        -27 + i * 8,
                        yy,
                        3,
                        7,
                        "#ef695e"
                    )
                    i = i + 1
                end
            end
        else
            __L1:r(
                c,
                -27,
                -8,
                3,
                2,
                "#b49ac1"
            )
            __L1:r(
                c,
                24,
                -8,
                3,
                2,
                "#b49ac1"
            )
        end
        c:restore()
    end
    __L1.specialArena = function(self, c, ____type, camera, t, homeX)
        c:save()
        local ____t_result_763
        if __t(homeX) then
            ____t_result_763 = homeX - camera
        else
            ____t_result_763 = 480
        end
        local center = ____t_result_763
        if ____type == "reeisBoss" then
            __L1:sky(c, 5, camera * 0.1, t)
            __L1:favela(c, camera * 0.24, t)
            __L1:r(
                c,
                0,
                0,
                960,
                440,
                "#18354f44"
            )
            c:save()
            c:translate(
                math.floor(center - 480 + 0.5),
                0
            )
            __L1:r(
                c,
                -150,
                332,
                1260,
                108,
                "#765449"
            )
            __L1:r(
                c,
                -150,
                329,
                1260,
                12,
                "#c7a97a"
            )
            do
                local x = -150
                while x < 1110 do
                    __L1:r(
                        c,
                        x,
                        344,
                        1,
                        95,
                        "#a97553"
                    )
                    __L1:r(
                        c,
                        x,
                        361,
                        34,
                        1,
                        "#a97553"
                    )
                    __L1:r(
                        c,
                        x + 17,
                        385,
                        24,
                        1,
                        "#a97553"
                    )
                    x = x + 43
                end
            end
            for ____, x in __iterar((__arrL({70, 842}, 2))) do
                __L1:r(
                    c,
                    x,
                    134,
                    9,
                    197,
                    "#293e45"
                )
                __L1:r(
                    c,
                    x - 22,
                    120,
                    53,
                    19,
                    "#304f5c"
                )
                do
                    local i = 0
                    while i < 4 do
                        __L1:r(
                            c,
                            x - 16 + i * 11,
                            124,
                            8,
                            9,
                            "#ffd99c"
                        )
                        i = i + 1
                    end
                end
                __L1:r(
                    c,
                    x - 25,
                    230,
                    60,
                    101,
                    "#253842"
                )
                __L1:r(
                    c,
                    x - 20,
                    234,
                    50,
                    94,
                    "#47606a"
                )
                do
                    local j = 0
                    while j < 2 do
                        __L1:oval(
                            c,
                            x + 5,
                            255 + j * 48,
                            20,
                            20,
                            "#1e303b",
                            3
                        )
                        __L1:oval(
                            c,
                            x + 5,
                            255 + j * 48,
                            12,
                            12,
                            "#849b91",
                            3
                        )
                        j = j + 1
                    end
                end
            end
            __L1:r(
                c,
                276,
                87,
                413,
                78,
                "#153c54"
            )
            __L1:r(
                c,
                284,
                95,
                397,
                62,
                "#286577"
            )
            c.fillStyle = "#dfc372"
            c.font = "bold 24px monospace"
            c:fillText("O TRONO DO MORRO", 332, 127)
            c.fillStyle = "#a4e2d6"
            c.font = "bold 12px monospace"
            c:fillText("GABRIEL REEIS · RESPEITA O REI", 343, 149)
            __L1:r(
                c,
                404,
                233,
                149,
                107,
                "#243d49"
            )
            __L1:r(
                c,
                413,
                240,
                131,
                91,
                "#587a6b"
            )
            __L1:r(
                c,
                420,
                245,
                117,
                80,
                "#718e6d"
            )
            __L1:r(
                c,
                402,
                304,
                153,
                17,
                "#a48c58"
            )
            do
                local i = 0
                while i < 5 do
                    __L1:poly(
                        c,
                        __arrL(
                            {
                                __arrL({418 + i * 26, 240}, 2),
                                __arrL(
                                    {
                                        430 + i * 26,
                                        216 - __mod(i, 2) * 9
                                    },
                                    2
                                ),
                                __arrL({443 + i * 26, 240}, 2)
                            },
                            3
                        ),
                        "#d1b76f"
                    )
                    i = i + 1
                end
            end
            do
                local i = 0
                while i < 14 do
                    local x = 130 + i * 47
                    local y = 174 + math.sin(i) * 13
                    __L1:r(
                        c,
                        x,
                        y,
                        23,
                        2,
                        "#293f4b"
                    )
                    __L1:poly(
                        c,
                        __arrL(
                            {
                                __arrL({x, y + 2}, 2),
                                __arrL({x + 23, y + 2}, 2),
                                __arrL({x + 11, y + 24}, 2)
                            },
                            3
                        ),
                        __t(__mod(i, 2)) and "#7fc6c6" or "#d8bd78"
                    )
                    i = i + 1
                end
            end
            c:restore()
            __L1:r(
                c,
                0,
                440,
                960,
                100,
                "#746a60"
            )
            __L1:r(
                c,
                0,
                440,
                960,
                6,
                "#d4be8b"
            )
            do
                local x = 0
                while x < 960 do
                    __L1:r(
                        c,
                        x,
                        448,
                        1,
                        92,
                        "#514f4e"
                    )
                    x = x + 64
                end
            end
        else
            __L1:inkRealm(c, camera * 0.22, t)
            __L1:r(
                c,
                0,
                0,
                960,
                440,
                "#201f37aa"
            )
            c:save()
            c:translate(
                math.floor(center - 480 + 0.5),
                0
            )
            do
                local i = 0
                while i < 9 do
                    local x = 36 + i * 112
                    local yy = 32 + math.sin(t + i) * 9
                    __L1:poly(
                        c,
                        __arrL(
                            {
                                __arrL({x, yy}, 2),
                                __arrL({x + 79, yy + 5}, 2),
                                __arrL({x + 84, yy + 139}, 2),
                                __arrL({x + 63, yy + 132}, 2),
                                __arrL({x + 45, yy + 143}, 2),
                                __arrL({x + 17, yy + 132}, 2)
                            },
                            6
                        ),
                        "#9b86ad"
                    )
                    do
                        local j = 0
                        while j < 5 do
                            __L1:r(
                                c,
                                x + 12,
                                yy + 23 + j * 18,
                                55,
                                2,
                                "#655476"
                            )
                            j = j + 1
                        end
                    end
                    i = i + 1
                end
            end
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({177, 230}, 2),
                        __arrL({474, 265}, 2),
                        __arrL({475, 416}, 2),
                        __arrL({171, 375}, 2)
                    },
                    4
                ),
                "#c6b1cb"
            )
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({480, 265}, 2),
                        __arrL({785, 227}, 2),
                        __arrL({790, 375}, 2),
                        __arrL({480, 416}, 2)
                    },
                    4
                ),
                "#e1cbd9"
            )
            __L1:r(
                c,
                474,
                263,
                8,
                155,
                "#695578"
            )
            do
                local i = 0
                while i < 7 do
                    __L1:r(
                        c,
                        206,
                        258 + i * 16,
                        215,
                        2,
                        "#9a7ca9"
                    )
                    __L1:r(
                        c,
                        535,
                        258 + i * 16,
                        215,
                        2,
                        "#ae8dac"
                    )
                    i = i + 1
                end
            end
            __L1:r(
                c,
                300,
                79,
                369,
                46,
                "#473652"
            )
            c.fillStyle = "#f0cddd"
            c.font = "bold 22px monospace"
            c:fillText("O RABISCO COLOSSAL", 354, 109)
            do
                local i = 0
                while i < 13 do
                    local xx = 50 + i * 74
                    local yy = 376 + math.sin(t * 2 + i) * 8
                    __L1:poly(
                        c,
                        __arrL(
                            {
                                __arrL({xx, 440}, 2),
                                __arrL({xx + 5, yy}, 2),
                                __arrL({xx + 14, yy - 8}, 2),
                                __arrL({xx + 22, yy}, 2),
                                __arrL({xx + 26, 440}, 2)
                            },
                            5
                        ),
                        "#333049"
                    )
                    i = i + 1
                end
            end
            c:restore()
            __L1:r(
                c,
                0,
                440,
                960,
                100,
                "#564669"
            )
            __L1:r(
                c,
                0,
                440,
                960,
                6,
                "#dec6d7"
            )
            do
                local x = 0
                while x < 960 do
                    __L1:r(
                        c,
                        x,
                        450,
                        1,
                        90,
                        "#332f49"
                    )
                    __L1:r(
                        c,
                        x + 5,
                        477,
                        35,
                        2,
                        "#856d96"
                    )
                    x = x + 51
                end
            end
        end
        c:restore()
    end
    __L1.memeMinion = function(self, c, x, y, t, kind, o)
        if t == nil then
            t = 0
        end
        if kind == nil then
            kind = "brainrot"
        end
        if o == nil then
            o = {}
        end
        c:save()
        c.imageSmoothingEnabled = false
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        c:scale(
            __lt(o.facing, 0) and -1 or 1,
            1
        )
        local bob = math.floor(math.sin(t * 7) * 3 + 0.5)
        __L1:oval(
            c,
            0,
            0,
            25,
            4,
            "#37403c",
            2
        )
        c:translate(0, -bob)
        if kind == "sixseven" then
            local green = "#a8d676"
            local purple = "#bc8fd3"
            __L1:r(
                c,
                -25,
                -44,
                21,
                6,
                "#2b343b"
            )
            __L1:r(
                c,
                -27,
                -40,
                6,
                30,
                "#2b343b"
            )
            __L1:r(
                c,
                -24,
                -27,
                20,
                5,
                "#2b343b"
            )
            __L1:r(
                c,
                -9,
                -26,
                6,
                17,
                "#2b343b"
            )
            __L1:r(
                c,
                -24,
                -11,
                20,
                6,
                "#2b343b"
            )
            __L1:r(
                c,
                -22,
                -41,
                17,
                3,
                green
            )
            __L1:r(
                c,
                -24,
                -38,
                3,
                27,
                green
            )
            __L1:r(
                c,
                -22,
                -24,
                15,
                3,
                green
            )
            __L1:r(
                c,
                -8,
                -23,
                3,
                12,
                green
            )
            __L1:r(
                c,
                -21,
                -9,
                15,
                3,
                green
            )
            __L1:r(
                c,
                2,
                -45,
                27,
                7,
                "#2b343b"
            )
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL({25, -40}, 2),
                        __arrL({9, -8}, 2)
                    },
                    2
                ),
                8,
                "#2b343b"
            )
            __L1:r(
                c,
                5,
                -42,
                20,
                3,
                purple
            )
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL({24, -37}, 2),
                        __arrL({10, -9}, 2)
                    },
                    2
                ),
                4,
                purple
            )
            __L1:r(
                c,
                -20,
                -3,
                11,
                5,
                "#b6c6d0"
            )
            __L1:r(
                c,
                8,
                -2,
                12,
                5,
                "#c8adba"
            )
            __L1:r(
                c,
                -18,
                -21,
                4,
                4,
                "#263c39"
            )
            __L1:r(
                c,
                7,
                -39,
                4,
                4,
                "#3d324b"
            )
            __L1:r(
                c,
                17,
                -39,
                4,
                4,
                "#3d324b"
            )
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL({-25, -24}, 2),
                        __arrL({-37, -20}, 2),
                        __arrL({-32, -13}, 2)
                    },
                    3
                ),
                4,
                green
            )
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL({26, -31}, 2),
                        __arrL({35, -22}, 2),
                        __arrL({31, -17}, 2)
                    },
                    3
                ),
                4,
                purple
            )
            __L1:r(
                c,
                -17,
                -13,
                7,
                2,
                "#faeccb"
            )
            if __t(o.attack) then
                c.fillStyle = "#f5d5e7"
                c.font = "bold 8px monospace"
                c.textAlign = "center"
                c:fillText("SIX SEVEN!", 0, -54)
                c.textAlign = "left"
            end
        else
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({-18, -28}, 2),
                        __arrL({-13, -42}, 2),
                        __arrL({-3, -48}, 2),
                        __arrL({12, -43}, 2),
                        __arrL({20, -31}, 2),
                        __arrL({18, -17}, 2),
                        __arrL({4, -11}, 2),
                        __arrL({-12, -15}, 2)
                    },
                    8
                ),
                "#402d45"
            )
            __L1:oval(
                c,
                1,
                -29,
                17,
                17,
                "#cf6a68",
                3
            )
            __L1:oval(
                c,
                -4,
                -33,
                9,
                10,
                "#e3987a",
                3
            )
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({-11, -42}, 2),
                        __arrL({-15, -50}, 2),
                        __arrL({-5, -47}, 2),
                        __arrL({0, -56}, 2),
                        __arrL({5, -47}, 2),
                        __arrL({15, -50}, 2),
                        __arrL({12, -42}, 2)
                    },
                    7
                ),
                "#7aa05e"
            )
            __L1:r(
                c,
                -10,
                -33,
                6,
                8,
                "#ede4c4"
            )
            __L1:r(
                c,
                1,
                -36,
                6,
                8,
                "#ede4c4"
            )
            __L1:r(
                c,
                10,
                -30,
                5,
                6,
                "#ede4c4"
            )
            __L1:r(
                c,
                -7,
                -31,
                2,
                4,
                "#49374f"
            )
            __L1:r(
                c,
                3,
                -34,
                2,
                4,
                "#49374f"
            )
            __L1:r(
                c,
                12,
                -29,
                2,
                3,
                "#49374f"
            )
            __L1:r(
                c,
                -4,
                -22,
                12,
                4,
                "#593746"
            )
            __L1:r(
                c,
                -2,
                -22,
                8,
                2,
                "#f8dfb9"
            )
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({-13, -12}, 2),
                        __arrL({-2, -9}, 2),
                        __arrL({16, -13}, 2),
                        __arrL({22, -6}, 2),
                        __arrL({29, -6}, 2),
                        __arrL({30, 1}, 2),
                        __arrL({-21, 1}, 2),
                        __arrL({-23, -5}, 2)
                    },
                    8
                ),
                "#e9dfcf"
            )
            __L1:r(
                c,
                -20,
                0,
                49,
                4,
                "#587a8c"
            )
            __L1:r(
                c,
                -13,
                -7,
                20,
                2,
                "#a5b8bd"
            )
            do
                local i = 0
                while i < 3 do
                    __L1:r(
                        c,
                        -8 + i * 5,
                        -11,
                        2,
                        6,
                        "#f9f1d7"
                    )
                    i = i + 1
                end
            end
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL({-15, -29}, 2),
                        __arrL({-29, -24}, 2),
                        __arrL({-26, -18}, 2)
                    },
                    3
                ),
                4,
                "#b8899c"
            )
            __L1:limb(
                c,
                __arrL(
                    {
                        __arrL({17, -28}, 2),
                        __arrL({29, -24}, 2),
                        __arrL({28, -18}, 2)
                    },
                    3
                ),
                4,
                "#b8899c"
            )
            __L1:r(
                c,
                -30,
                -22,
                8,
                6,
                "#ddbaad"
            )
            __L1:r(
                c,
                25,
                -21,
                8,
                6,
                "#ddbaad"
            )
        end
        if __t(o.hit) then
            c.globalAlpha = c.globalAlpha * 0.5
            __L1:r(
                c,
                -30,
                -55,
                61,
                58,
                "#fce7d8"
            )
        end
        c:restore()
    end
    __L1.minion = function(self, c, x, y, kind, t, o)
        if kind == nil then
            kind = 0
        end
        if t == nil then
            t = 0
        end
        if o == nil then
            o = {}
        end
        local ____t_result_769
        local ____t_765 = __t
        local ____t_result_764
        if __t(o.design) then
            ____t_result_764 = o.design
        else
            ____t_result_764 = o.variant
        end
        __O[270] = ____t_result_764
        if ____t_765(____t_result_764) then
            ____t_result_769 = __O[270]
        else
            local ____t_result_768
            local ____t_767 = __t
            local ____t_result_766
            if __t(o.type) then
                ____t_result_766 = o.type ~= "doodle"
            else
                ____t_result_766 = o.type
            end
            if ____t_767(____t_result_766) then
                ____t_result_768 = o.type
            else
                ____t_result_768 = kind
            end
            ____t_result_769 = ____t_result_768
        end
        local design = tostring(____t_result_769)
        if __t(__call(
            __arrL({"spindle", "wobbler", "pasta"}, 3),
            "includes",
            design
        )) then
            __L1:strangeMinion(
                c,
                x,
                y,
                t,
                design,
                o
            )
            return
        end
        if design == "rat" then
            __L1:rat(
                c,
                x,
                y,
                t,
                o
            )
            return
        end
        if __t(design == "brainrot" or design == "sixseven") then
            __L1:memeMinion(
                c,
                x,
                y,
                t,
                design,
                o
            )
            return
        end
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        c:scale(
            __lt(o.facing, 0) and -1 or 1,
            1
        )
        local ____t_result_772
        local ____t_771 = __t
        local ____TS__Number_result_770 = __TS__Number(kind)
        __O[271] = ____TS__Number_result_770
        if ____t_771(____TS__Number_result_770) then
            ____t_result_772 = __O[271]
        else
            ____t_result_772 = 0
        end
        local k = ____t_result_772
        local bob = o.moving == false and 0 or math.floor(math.sin(t * 9 + k) * 2 + 0.5)
        __L1:oval(
            c,
            0,
            0,
            18,
            3,
            "#314938",
            2
        )
        __L1:r(
            c,
            -13,
            -5,
            9,
            5,
            "#5f4d69"
        )
        __L1:r(
            c,
            5,
            -4,
            9,
            4,
            "#5f4d69"
        )
        __L1:doodle(
            c,
            0,
            -19 - bob,
            k,
            t,
            o.angry
        )
        if k == 1 then
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({-9, -32}, 2),
                        __arrL({-15, -54}, 2),
                        __arrL({-6, -49}, 2),
                        __arrL({-3, -33}, 2)
                    },
                    4
                ),
                "#735876"
            )
            __L1:poly(
                c,
                __arrL(
                    {
                        __arrL({5, -33}, 2),
                        __arrL({11, -53}, 2),
                        __arrL({17, -48}, 2),
                        __arrL({12, -30}, 2)
                    },
                    4
                ),
                "#735876"
            )
            __L1:r(
                c,
                -12,
                -48,
                3,
                10,
                "#bea1b0"
            )
            __L1:r(
                c,
                11,
                -47,
                3,
                10,
                "#bea1b0"
            )
        end
        if k == 2 then
            __L1:r(
                c,
                13,
                -22,
                9,
                8,
                "#5d4269"
            )
            __L1:r(
                c,
                18,
                -20,
                9,
                4,
                "#c29cab"
            )
            __L1:r(
                c,
                25,
                -19,
                2,
                3,
                "#2b2939"
            )
        end
        if __t(o.hit) then
            c:save()
            c.globalAlpha = c.globalAlpha * 0.65
            __L1:r(
                c,
                -16,
                -37,
                33,
                34,
                "#fff1c8"
            )
            c:restore()
        end
        c:restore()
    end
    local ____ = "use strict"
    __L1.P = __ord({
        ink = "#342d2b",
        earth = "#8f573d",
        dark = "#243c33",
        moss = "#3d6540",
        leaf = "#658746",
        lime = "#a5b952",
        cream = "#f4d49a",
        sun = "#ffdf94",
        clay = "#bd6244",
        teal = "#365e62"
    }, "ink,earth,dark,moss,leaf,lime,cream,sun,clay,teal")
    __L1.hash = function(____, i)
        local x = math.sin(i * 127.1 + 311.7) * 43758.5453
        return x - math.floor(x)
    end
    __L1.heroFrameCatalog = __ord({
        idle = 4,
        walk = 12,
        jump = 3,
        fall = 3,
        land = 3,
        dash = 4,
        paper = 6,
        fart = 6,
        flight = 4
    }, "idle,walk,jump,fall,land,dash,paper,fart,flight")
    __L1.worldWidth = function(____, scene)
        local ____t_result_780
        local ____t_779 = __t
        local ____t_result_778
        local ____t_777 = __t
        local ____getq_775 = __getq
        local ____opt_773 = window.WorldData
        if ____opt_773 ~= nil then
            ____opt_773 = ____opt_773.widths
        end
        local ____TS__Number_result_776 = __TS__Number(____getq_775(____opt_773, scene))
        __O[151] = ____TS__Number_result_776
        if ____t_777(____TS__Number_result_776) then
            ____t_result_778 = __O[151]
        else
            ____t_result_778 = __get(
                __arrL({
                    4800,
                    6200,
                    5000,
                    5200,
                    6000,
                    7200,
                    6600,
                    4800,
                    3600,
                    4200,
                    3600,
                    4800
                }, 12),
                scene
            )
        end
        __O[152] = ____t_result_778
        if ____t_779(____t_result_778) then
            ____t_result_780 = __O[152]
        else
            ____t_result_780 = 4800
        end
        return ____t_result_780
    end
    __L1.r = function(____, c, x, y, w, h, color)
        c.fillStyle = color
        c:fillRect(
            math.floor(x + 0.5),
            math.floor(y + 0.5),
            math.ceil(w),
            math.ceil(h)
        )
    end
    __L1.animT = 0
    __L1.animCam = 0
    __L1.liteNow = false
    __L1.windAt = function(____, screenX)
        if __t(__L1.liteNow) then
            return 0
        end
        local x = screenX + __L1.animCam
        local g = 0.55 + 0.45 * math.sin(__L1.animT * 0.31)
        return (math.sin(__L1.animT * 1.15 + x * 0.0042) * 0.62 + math.sin(__L1.animT * 2.4 + x * 0.013) * 0.38) * g
    end
    __L1.screenX = function(____, c, x)
        if __t(__L1.liteNow) then
            return x
        end
        do
            local function ____catch(e)
                return true, x
            end
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                local m = c:getTransform()
                local ____m_e_782 = m.e
                local ____t_result_781
                if __t(m.a) then
                    ____t_result_781 = m.a
                else
                    ____t_result_781 = 1
                end
                return true, ____m_e_782 / ____t_result_781 + x
            end)
            if not ____try then
                ____hasReturned, ____returnValue = ____catch(____hasReturned)
            end
            if ____hasReturned then
                return ____returnValue
            end
        end
    end
    __L1.BAYER = __arrL({
        0,
        8,
        2,
        10,
        12,
        4,
        14,
        6,
        3,
        11,
        1,
        9,
        15,
        7,
        13,
        5
    }, 16)
    __L1.remasterCache = __TS__New(Map)
    __L1.hex = function(____, h)
        local n = __TS__ParseInt(
            __call(h, "slice", 1),
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
    __L1.SKIES = __ord(
        {
            day = __arrL({
                "#2f7cc8",
                "#4a95d9",
                "#68abe3",
                "#8cc1ea",
                "#b0d5ee",
                "#d4e8ec",
                "#ecefdc"
            }, 7),
            afternoon = __arrL({
                "#3a6fb4",
                "#5b8cc8",
                "#83a9d6",
                "#aec4d9",
                "#d4d6cc",
                "#efdcb6"
            }, 6),
            golden = __arrL({
                "#35609f",
                "#5a82bd",
                "#8ea4c8",
                "#c7b9bd",
                "#ecc49b",
                "#f7d79a"
            }, 6),
            plaza = __arrL({
                "#2e86c9",
                "#4f9fdb",
                "#77b8e6",
                "#a2d0ee",
                "#cfe6ee",
                "#eef2e2"
            }, 6)
        },
        "day,afternoon,golden,plaza"
    )
    __L1.skyFor = function(____, scene) return scene == 3 and "afternoon" or (scene == 5 and "golden" or (scene == 4 and "plaza" or "day")) end
    __L1.OUTDOOR = __TS__New(
        Set,
        __arrL({
            0,
            1,
            3,
            4,
            5,
            7,
            9
        }, 7)
    )
    __L1.TEX_BANDS = {
        ["1"] = __arrL({212, 440}, 2),
        ["9"] = __arrL({212, 440}, 2),
        ["7"] = __arrL({180, 330}, 2),
        ["5"] = __arrL({95, 440}, 2),
        ["4"] = __arrL({362, 440}, 2),
        ["3"] = __arrL({330, 440}, 2),
        ["2"] = __arrL({0, 440}, 2),
        ["8"] = __arrL({0, 440}, 2),
        ["10"] = __arrL({0, 440}, 2),
        ["6"] = __arrL({0, 440}, 2)
    }
    __L1.SKIN = __arrL({
        "#f0c9a8",
        "#d6a071",
        "#a86c4e",
        "#7a4a33",
        "#e8b48e"
    }, 5)
    __L1.SHIRT = __arrL({
        "#d8433a",
        "#2f5f86",
        "#e0a020",
        "#3f6e3a",
        "#7b3fb0",
        "#f2f2f2",
        "#2a2a2a"
    }, 7)
    __L1.nikolasFormGeometry = {
        ["1"] = __ord({halfWidth = 24, height = 66, centerY = 33, visualHalfWidth = 30}, "halfWidth,height,centerY,visualHalfWidth"),
        ["2"] = __ord({halfWidth = 55, height = 140, centerY = 70, visualHalfWidth = 82}, "halfWidth,height,centerY,visualHalfWidth"),
        ["3"] = __ord({halfWidth = 55, height = 140, centerY = 70, visualHalfWidth = 82}, "halfWidth,height,centerY,visualHalfWidth"),
        ["4"] = __ord({halfWidth = 185, height = 340, centerY = 170, visualHalfWidth = 210}, "halfWidth,height,centerY,visualHalfWidth")
    }
    __L1.nikolasBounds = function(____, phase)
        local ____get_787 = __get
        local ____L1_nikolasFormGeometry_786 = __L1.nikolasFormGeometry
        local ____t_result_785
        local ____t_784 = __t
        local ____TS__Number_result_783 = __TS__Number(phase)
        __O[193] = ____TS__Number_result_783
        if ____t_784(____TS__Number_result_783) then
            ____t_result_785 = __O[193]
        else
            ____t_result_785 = 1
        end
        return ____get_787(
            ____L1_nikolasFormGeometry_786,
            math.max(
                1,
                math.min(
                    4,
                    math.floor(____t_result_785)
                )
            )
        )
    end
    window.Art = __ord({
        nikolasBounds = __L1.nikolasBounds,
        drawAcai = __L1.acai,
        drawRat = __L1.rat,
        drawTitleScene = __L1.drawTitleScene,
        drawGroundBridges = __L1.groundBridges,
        drawScene = __L1.drawScene,
        drawCharacter = __L1.character,
        drawVehicle = __L1.vehicle,
        drawCake = __L1.cake,
        drawDoodle = __L1.doodle,
        drawMaterial = __L1.material,
        drawEnergyAura = __L1.energyAura,
        heroFrameCatalog = __L1.heroFrameCatalog,
        drawClassroom = __L1.classroom,
        drawArena = __L1.arena,
        drawPlatform = __L1.platform,
        drawMinion = __L1.minion,
        drawThug = __L1.thug,
        drawSarueTrap = __L1.sarueTrap,
        drawFootball = __L1.football
    }, "nikolasBounds,drawAcai,drawRat,drawTitleScene,drawGroundBridges,drawScene,drawCharacter,drawVehicle,drawCake,drawDoodle,drawMaterial,drawEnergyAura,heroFrameCatalog,drawClassroom,drawArena,drawPlatform,drawMinion,drawThug,drawSarueTrap,drawFootball")
end)(nil)
return ____exports
