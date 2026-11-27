--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __le, __gt, __isFiniteN, __callq, __mod, __ord, __arrL, __iterar, __t, __get, __set = __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__isFiniteN, __JSR.__callq, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set
local __len, __call, __add, __assign, __bor, __shl, __hypot, __re, __re_test = __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__assign, __JSR.__bor, __JSR.__shl, __JSR.__hypot, __JSR.__re, __JSR.__re_test
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local Map = ____lualib.Map
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__ParseInt = ____lualib.__TS__ParseInt
local ____exports = {}
local __O = {};
(function()
    local inferMotion
    function inferMotion(self, p)
        if __t(p.motion) then
            return p.motion
        end
        if __gt(p.dashTime, 0) then
            return "dash"
        end
        if p.ground == false then
            return if __lt(if __t(p.vy) then p.vy else 0, -20) then "jump" else "fall"
        end
        return if math.abs(if __t(p.vx) then p.vx else 0) > 15 then "run" else "idle"
    end
    local ____ = "use strict"
    local TAU = math.pi * 2
    local INK = "#203c44"
    local CREAM = "#fff0be"
    local function clamp(____, n, a, b)
        local ____a_3 = a
        local ____b_2 = b
        local ____t_1 = __t
        local ____TS__Number_result_0 = __TS__Number(n)
        __O[2470] = ____TS__Number_result_0
        return math.max(
            ____a_3,
            math.min(____b_2, if ____t_1(____TS__Number_result_0) then __O[2470] else 0)
        )
    end
    local girls = __TS__New(
        Set,
        __arrL({
            "aica",
            "ravile",
            "eloisa",
            "giselle",
            "rayssa",
            "analaura"
        }, 6)
    )
    local skin = __ord({
        daroca = "#d9a171",
        reeis = "#825033",
        nikolas = "#e1b28a",
        marco = "#f0cdb8",
        menezes = "#b47d54",
        ollyan = "#f0c9b3",
        igor = "#e7a079",
        kaique = "#f0cbb4",
        freddy = "#805137",
        dede = "#b98b6c",
        arthur = "#f0cdb6",
        nicolas = "#f0cdb6",
        caleb = "#f0c9af",
        lucas = "#efc9b0",
        kaua = "#b88361",
        mota = "#f1ccb4",
        ravid = "#c9976e",
        almiro = "#b47b53",
        miqueias = "#f0cbb5",
        davi = "#dab18e",
        vitor = "#edc9ae",
        allef = "#805136",
        aica = "#d8ad89",
        ravile = "#b17d57",
        eloisa = "#d9af90",
        giselle = "#795035",
        rayssa = "#815338",
        analaura = "#f2ccb2"
    }, "daroca,reeis,nikolas,marco,menezes,ollyan,igor,kaique,freddy,dede,arthur,nicolas,caleb,lucas,kaua,mota,ravid,almiro,miqueias,davi,vitor,allef,aica,ravile,eloisa,giselle,rayssa,analaura")
    local heightCache = __TS__New(Map)
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
            width = 2
        end
        local size = math.max(
            1,
            math.floor(width + 0.5)
        )
        c.fillStyle = color
        do
            local n = 1
            while __lt(
                n,
                __len(points)
            ) do
                local x = math.floor(__get(
                    __get(points, n - 1),
                    0
                ) + 0.5)
                local y = math.floor(__get(
                    __get(points, n - 1),
                    1
                ) + 0.5)
                local ex = math.floor(__get(
                    __get(points, n),
                    0
                ) + 0.5)
                local ey = math.floor(__get(
                    __get(points, n),
                    1
                ) + 0.5)
                local dx = math.abs(ex - x)
                local dy = -math.abs(ey - y)
                local sx = if x < ex then 1 else -1
                local sy = if y < ey then 1 else -1
                local err = dx + dy
                do
                    local guard = 0
                    while guard < 4000 do
                        c:fillRect(
                            x - math.floor(size / 2),
                            y - math.floor(size / 2),
                            size,
                            size
                        )
                        if __t(x == ex and y == ey) then
                            break
                        end
                        local e = 2 * err
                        if e >= dy then
                            err = err + dy
                            x = x + sx
                        end
                        if e <= dx then
                            err = err + dx
                            y = y + sy
                        end
                        guard = guard + 1
                    end
                end
                n = n + 1
            end
        end
    end
    local function pixelOval(self, c, x, y, rx, ry, color)
        local ____t_5 = __t
        local ____TS__Number_result_4 = __TS__Number(rx)
        __O[2471] = ____TS__Number_result_4
        rx = math.max(1, if ____t_5(____TS__Number_result_4) then __O[2471] else 1)
        local ____t_7 = __t
        local ____TS__Number_result_6 = __TS__Number(ry)
        __O[2472] = ____TS__Number_result_6
        ry = math.max(1, if ____t_7(____TS__Number_result_6) then __O[2472] else 1)
        local step = 3
        do
            local yy = __TS__Number(-ry)
            while __lt(yy, ry) do
                local mid = math.max(
                    -1,
                    math.min(1, (yy + step * 0.5) / ry)
                )
                local span = math.max(
                    step,
                    math.floor(rx * math.sqrt(math.max(0, 1 - mid * mid)) / step + 0.5) * step
                )
                rect(
                    nil,
                    c,
                    x - span,
                    y + yy,
                    span * 2,
                    math.min(step, ry - yy),
                    color
                )
                yy = yy + step
            end
        end
    end
    local function puff(self, c, x, y, size, color, accent)
        if accent == nil then
            accent = "#ffffff"
        end
        local n = math.max(
            2,
            math.floor(size / 4 + 0.5)
        )
        rect(
            nil,
            c,
            x - n * 3,
            y - n,
            n * 6,
            n * 3,
            INK
        )
        rect(
            nil,
            c,
            x - n * 2,
            y - n * 2,
            n * 4,
            n * 5,
            INK
        )
        rect(
            nil,
            c,
            x - n * 3 + 2,
            y - n + 2,
            n * 6 - 4,
            n * 3 - 4,
            color
        )
        rect(
            nil,
            c,
            x - n * 2 + 2,
            y - n * 2 + 2,
            n * 4 - 4,
            n * 5 - 4,
            color
        )
        rect(
            nil,
            c,
            x - n,
            y - n * 2 + 4,
            n * 2,
            n,
            accent
        )
    end
    local function impact(self, c, x, y, size, color, progress)
        if color == nil then
            color = CREAM
        end
        if progress == nil then
            progress = 0.5
        end
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        local n = math.max(
            8,
            math.floor(size + 0.5)
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-n, -3}, 2),
                    __arrL({-n * 0.35, -n * 0.3}, 2),
                    __arrL({-n * 0.55, -n}, 2),
                    __arrL({-2, -n * 0.55}, 2),
                    __arrL({n * 0.4, -n}, 2),
                    __arrL({n * 0.35, -n * 0.3}, 2),
                    __arrL({n, -n * 0.2}, 2),
                    __arrL({n * 0.5, 2}, 2),
                    __arrL({n * 0.8, n * 0.7}, 2),
                    __arrL({n * 0.2, n * 0.35}, 2),
                    __arrL({-n * 0.1, n}, 2),
                    __arrL({-n * 0.3, n * 0.35}, 2),
                    __arrL({-n, n * 0.5}, 2),
                    __arrL({-n * 0.5, n * 0.1}, 2)
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
                    __arrL({-n * 0.2, -n * 0.15}, 2),
                    __arrL({-n * 0.4, -n + 4}, 2),
                    __arrL({0, -n * 0.35}, 2),
                    __arrL({n * 0.25, -n + 5}, 2),
                    __arrL({n * 0.2, -n * 0.15}, 2),
                    __arrL({n - 5, -n * 0.1}, 2),
                    __arrL({n * 0.28, 2}, 2),
                    __arrL({n * 0.48, n * 0.45}, 2),
                    __arrL({n * 0.12, n * 0.2}, 2),
                    __arrL({-n * 0.08, n - 5}, 2),
                    __arrL({-n * 0.18, n * 0.15}, 2),
                    __arrL({-n + 5, n * 0.27}, 2),
                    __arrL({-n * 0.3, 0}, 2)
                },
                14
            ),
            color
        )
        rect(
            nil,
            c,
            -4,
            -4,
            8,
            8,
            "#ffffff"
        )
        do
            local i = 0
            while i < 3 do
                local d = 7 + progress * 18
                rect(
                    nil,
                    c,
                    n + d + i * 4,
                    -n + 7 + i * 8,
                    4,
                    4,
                    if __t(__mod(i, 2)) then color else "#ffe45a"
                )
                i = i + 1
            end
        end
        c:restore()
    end
    local function smear(self, c, x, y, angle, progress, color, width)
        if width == nil then
            width = 12
        end
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        c:rotate(angle)
        local travel = math.floor(math.sin(clamp(nil, progress, 0, 1) * math.pi) * 28 + 0.5)
        local length = 18 + travel
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-length, -width * 0.45}, 2),
                    __arrL({-length + 9, -width * 0.45}, 2),
                    __arrL({-length + 9, -width * 0.8}, 2),
                    __arrL({-6, -width * 0.8}, 2),
                    __arrL({-6, -width}, 2),
                    __arrL({11, -width}, 2),
                    __arrL({17, -4}, 2),
                    __arrL({23, -4}, 2),
                    __arrL({23, 4}, 2),
                    __arrL({14, 4}, 2),
                    __arrL({14, width}, 2),
                    __arrL({-7, width}, 2),
                    __arrL({-7, width * 0.7}, 2),
                    __arrL({-length, width * 0.4}, 2)
                },
                14
            ),
            color
        )
        rect(
            nil,
            c,
            -length + 12,
            -3,
            length - 3,
            6,
            "#fff7d2"
        )
        do
            local i = 0
            while i < 3 do
                rect(
                    nil,
                    c,
                    -length - 8 - i * 9,
                    -width + 3 + __mod(i, 2) * 9,
                    6,
                    4,
                    color
                )
                i = i + 1
            end
        end
        c:restore()
    end
    local function crack(self, c, x, y, progress, color)
        if color == nil then
            color = "#e9a24c"
        end
        local spread = 20 + progress * 55
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({x - spread, y + 4}, 2),
                    __arrL({x - spread * 0.65, y - 1}, 2),
                    __arrL({x - spread * 0.45, y + 6}, 2),
                    __arrL({x - 4, y - 2}, 2),
                    __arrL({x + 11, y + 8}, 2),
                    __arrL({x + spread * 0.45, y + 1}, 2),
                    __arrL({x + spread * 0.6, y + 6}, 2),
                    __arrL({x + spread, y + 1}, 2)
                },
                8
            ),
            INK,
            5
        )
        do
            local i = 0
            while i < 7 do
                local xx = x + (i - 3) * (8 + progress * 6)
                local yy = y - 6 - math.sin(progress * math.pi) * (9 + __mod(i, 3) * 6)
                rect(
                    nil,
                    c,
                    xx - 4,
                    yy,
                    9,
                    6,
                    "#67412e"
                )
                rect(
                    nil,
                    c,
                    xx - 3,
                    yy,
                    7,
                    3,
                    color
                )
                i = i + 1
            end
        end
    end
    local function label(self, c, value, x, y, size, color, align)
        if size == nil then
            size = 11
        end
        if color == nil then
            color = CREAM
        end
        if align == nil then
            align = "center"
        end
        c.font = __add(
            __add("bold ", size),
            "px monospace"
        )
        c.textAlign = align
        c.textBaseline = "middle"
        c.fillStyle = INK
        c:fillText(
            value,
            math.floor(x + 0.5) + 1,
            math.floor(y + 0.5) + 2
        )
        c.fillStyle = color
        c:fillText(
            value,
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
    end
    local function kit(self, id)
        local ____t_9 = __t
        local ____callq_result_8 = __callq(window.ArenaRoster, "get", id)
        __O[2473] = ____callq_result_8
        return if ____t_9(____callq_result_8) then __O[2473] else {color = "#e9c27c", name = id}
    end
    local function bodyHeight(self, ____type)
        if __t(__call(heightCache, "has", ____type)) then
            return __call(heightCache, "get", ____type)
        end
        local ____t_11 = __t
        local ____get_result_10 = __get({
            igor = 90,
            kaique = 111,
            giant = 190,
            ollyan = 110,
            lucas = 54
        }, ____type)
        __O[2474] = ____get_result_10
        local height = if ____t_11(____get_result_10) then __O[2474] else 70
        do
            pcall(function()
                local canvas = window.document:createElement("canvas")
                canvas.width = 380
                canvas.height = 360
                local c = canvas:getContext("2d", {willReadFrequently = true})
                local ____opt_14 = window.Art
                if ____opt_14 ~= nil then
                    ____opt_14 = ____opt_14.drawCharacter
                end
                if ____opt_14 ~= nil then
                    ____opt_14(
                        ____opt_14,
                        c,
                        ____type,
                        190,
                        320,
                        {
                            frame = 0,
                            facing = 1,
                            grounded = true,
                            monitorBattle = true,
                            noseRub = false,
                            scale = 1
                        }
                    )
                end
                local data = c:getImageData(0, 0, 380, 321).data
                local first = 320
                do
                    local y = 0
                    while y < 320 do
                        local found = false
                        do
                            local x = 0
                            while x < 380 do
                                if __get(data, (y * 380 + x) * 4 + 3) > 220 then
                                    first = y
                                    found = true
                                    break
                                end
                                x = x + 1
                            end
                        end
                        if __t(found) then
                            break
                        end
                        y = y + 1
                    end
                end
                if first < 320 then
                    height = 320 - first
                end
            end)
        end
        __call(
            heightCache,
            "set",
            ____type,
            math.max(36, height)
        )
        return math.max(36, height)
    end
    local function cloud(self, c, x, y, s, color)
        if s == nil then
            s = 1
        end
        if color == nil then
            color = "#ffffff"
        end
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        c:scale(s, s)
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({-43, 9, 112, 12}, 4),
                __arrL({-29, -3, 83, 18}, 4),
                __arrL({-9, -15, 42, 24}, 4),
                __arrL({-50, 15, 127, 8}, 4)
            },
            4
        ))) do
            local xx = ____value[1]
            local yy = ____value[2]
            local w = ____value[3]
            local h = ____value[4]
            rect(
                nil,
                c,
                xx,
                yy,
                w,
                h,
                color
            )
        end
        c:restore()
    end
    local function mountain(self, c, x, y, s, color)
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({x - 190 * s, y}, 2),
                    __arrL({x - 143 * s, y - 57 * s}, 2),
                    __arrL({x - 76 * s, y - 85 * s}, 2),
                    __arrL({x - 8 * s, y - 155 * s}, 2),
                    __arrL({x + 47 * s, y - 99 * s}, 2),
                    __arrL({x + 88 * s, y - 78 * s}, 2),
                    __arrL({x + 171 * s, y}, 2)
                },
                7
            ),
            color
        )
    end
    local function windmill(self, c, x, y, t, s)
        if s == nil then
            s = 1
        end
        c:save()
        c:translate(x, y)
        c:scale(s, s)
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-23, 0}, 2),
                    __arrL({-17, -76}, 2),
                    __arrL({18, -76}, 2),
                    __arrL({24, 0}, 2)
                },
                4
            ),
            "#fff0c5"
        )
        rect(
            nil,
            c,
            -16,
            -76,
            32,
            7,
            "#187ed1"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-24, -77}, 2),
                    __arrL({0, -100}, 2),
                    __arrL({25, -77}, 2)
                },
                3
            ),
            "#d63e33"
        )
        rect(
            nil,
            c,
            -7,
            -34,
            15,
            34,
            "#456e72"
        )
        rect(
            nil,
            c,
            -10,
            -59,
            20,
            12,
            "#6fa2ae"
        )
        rect(
            nil,
            c,
            -6,
            -56,
            4,
            8,
            "#d0e5cd"
        )
        c:save()
        c:translate(0, -76)
        c:rotate(t * 0.45)
        do
            local i = 0
            while i < 4 do
                c:rotate(math.pi / 2)
                rect(
                    nil,
                    c,
                    7,
                    -5,
                    52,
                    11,
                    "#704f37"
                )
                rect(
                    nil,
                    c,
                    19,
                    -10,
                    40,
                    20,
                    "#ffd04e"
                )
                do
                    local j = 0
                    while j < 5 do
                        rect(
                            nil,
                            c,
                            22 + j * 8,
                            -10,
                            2,
                            20,
                            "#b4782e"
                        )
                        j = j + 1
                    end
                end
                rect(
                    nil,
                    c,
                    19,
                    -1,
                    40,
                    2,
                    "#fff38a"
                )
                i = i + 1
            end
        end
        c:restore()
        pixelOval(
            nil,
            c,
            0,
            -76,
            6,
            6,
            "#2c4f80"
        )
        rect(
            nil,
            c,
            -2,
            -78,
            4,
            4,
            "#fff2a2"
        )
        c:restore()
    end
    local function village(self, c, x, y, t, s)
        if s == nil then
            s = 1
        end
        c:save()
        c:translate(x, y)
        c:scale(s, s)
        do
            local i = 0
            while i < 5 do
                local xx = i * 69
                local yy = __mod(i, 2) * 11
                rect(
                    nil,
                    c,
                    xx,
                    yy - 68,
                    59,
                    70,
                    __get(
                        __arrL({"#fff0d0", "#ffdb73", "#ffd8c9"}, 3),
                        __mod(i, 3)
                    )
                )
                poly(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({xx - 6, yy - 68}, 2),
                            __arrL({xx + 27, yy - 91}, 2),
                            __arrL({xx + 65, yy - 68}, 2)
                        },
                        3
                    ),
                    if __t(__mod(i, 2)) then "#e94b3d" else "#256cd8"
                )
                rect(
                    nil,
                    c,
                    xx + 8,
                    yy - 55,
                    14,
                    24,
                    "#278edb"
                )
                rect(
                    nil,
                    c,
                    xx + 35,
                    yy - 56,
                    14,
                    24,
                    "#278edb"
                )
                rect(
                    nil,
                    c,
                    xx + 25,
                    yy - 25,
                    17,
                    27,
                    "#95542e"
                )
                rect(
                    nil,
                    c,
                    xx + 8,
                    yy - 52,
                    3,
                    18,
                    "#e9fbff"
                )
                i = i + 1
            end
        end
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({0, -98}, 2),
                    __arrL({290, -98}, 2)
                },
                2
            ),
            "#8e5b35",
            2
        )
        do
            local i = 0
            while i < 12 do
                local xx = i * 25
                poly(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({xx, -98}, 2),
                            __arrL({xx + 13, -98}, 2),
                            __arrL(
                                {
                                    xx + 8,
                                    -81 + math.sin(t * 2 + i) * 2
                                },
                                2
                            )
                        },
                        3
                    ),
                    __get(
                        __arrL({"#ffce32", "#f0443d", "#2789ed", "#fff2bd"}, 4),
                        __mod(i, 4)
                    )
                )
                i = i + 1
            end
        end
        c:restore()
    end
    local sceneryCache = __TS__New(Map)
    local platformCache = __TS__New(Map)
    local function cachedCanvas(self, cache, key, w, h, paint, limit)
        if limit == nil then
            limit = 3
        end
        local canvas = __call(cache, "get", key)
        if __t(canvas) then
            __call(cache, "delete", key)
            __call(cache, "set", key, canvas)
            return canvas
        end
        canvas = window.document:createElement("canvas")
        canvas.width = math.ceil(w)
        canvas.height = math.ceil(h)
        local g = canvas:getContext("2d")
        g.imageSmoothingEnabled = false
        paint(nil, g)
        __call(cache, "set", key, canvas)
        while __gt(cache.size, limit) do
            __call(
                cache,
                "delete",
                __call(cache, "keys"):next().value
            )
        end
        return canvas
    end
    local function tree(self, c, x, y, s, kind)
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
        rect(
            nil,
            c,
            -7,
            -57,
            13,
            59,
            "#85522d"
        )
        rect(
            nil,
            c,
            -5,
            -56,
            4,
            55,
            "#b6783e"
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({0, -25}, 2),
                    __arrL({-18, -57}, 2)
                },
                2
            ),
            "#85522d",
            6
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({2, -37}, 2),
                    __arrL({20, -62}, 2)
                },
                2
            ),
            "#85522d",
            5
        )
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({-35, -89, 62, 24}, 4),
                __arrL({-43, -73, 84, 25}, 4),
                __arrL({-30, -54, 62, 20}, 4),
                __arrL({-19, -98, 40, 17}, 4)
            },
            4
        ))) do
            local xx = ____value[1]
            local yy = ____value[2]
            local ww = ____value[3]
            local hh = ____value[4]
            rect(
                nil,
                c,
                xx,
                yy,
                ww,
                hh,
                "#247f46"
            )
        end
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({-30, -85, 51, 20}, 4),
                __arrL({-36, -70, 64, 21}, 4),
                __arrL({-18, -94, 35, 19}, 4),
                __arrL({-21, -52, 35, 12}, 4)
            },
            4
        ))) do
            local xx = ____value[1]
            local yy = ____value[2]
            local ww = ____value[3]
            local hh = ____value[4]
            rect(
                nil,
                c,
                xx,
                yy,
                ww,
                hh,
                if __t(kind) then "#63bc3b" else "#45ab44"
            )
        end
        do
            local i = 0
            while i < 9 do
                local xx = -30 + __mod(i * 17, 62)
                local yy = -86 + __mod(i * 13, 41)
                rect(
                    nil,
                    c,
                    xx,
                    yy,
                    7,
                    3,
                    if __t(__mod(i, 2)) then "#86d343" else "#75cc56"
                )
                if __t(if __t(kind) then __mod(i, 2) == 0 else kind) then
                    rect(
                        nil,
                        c,
                        xx + 2,
                        yy + 5,
                        5,
                        6,
                        "#fa8b32"
                    )
                    rect(
                        nil,
                        c,
                        xx + 3,
                        yy + 5,
                        2,
                        2,
                        "#ffd55a"
                    )
                end
                i = i + 1
            end
        end
        rect(
            nil,
            c,
            -17,
            -1,
            35,
            3,
            "#519c39"
        )
        c:restore()
    end
    local function fence(self, c, x, y, w, s)
        if s == nil then
            s = 1
        end
        c:save()
        c:translate(x, y)
        c:scale(s, s)
        rect(
            nil,
            c,
            0,
            -19,
            w,
            5,
            "#e7bf75"
        )
        rect(
            nil,
            c,
            0,
            -7,
            w,
            4,
            "#b8884c"
        )
        rect(
            nil,
            c,
            0,
            -20,
            w,
            2,
            "#fff0ad"
        )
        do
            local xx = 0
            while __le(xx, w) do
                rect(
                    nil,
                    c,
                    xx - 3,
                    -27,
                    7,
                    33,
                    "#805936"
                )
                rect(
                    nil,
                    c,
                    xx - 2,
                    -27,
                    4,
                    31,
                    "#efcd89"
                )
                rect(
                    nil,
                    c,
                    xx - 2,
                    -27,
                    4,
                    3,
                    "#fff2ba"
                )
                rect(
                    nil,
                    c,
                    xx,
                    -17,
                    2,
                    2,
                    "#7b5734"
                )
                xx = xx + 35
            end
        end
        c:restore()
    end
    local function barn(self, c, x, y, s)
        if s == nil then
            s = 1
        end
        c:save()
        c:translate(x, y)
        c:scale(s, s)
        rect(
            nil,
            c,
            0,
            -83,
            133,
            83,
            "#a32d37"
        )
        rect(
            nil,
            c,
            6,
            -79,
            121,
            77,
            "#d94a3f"
        )
        do
            local i = 0
            while i < 11 do
                rect(
                    nil,
                    c,
                    8 + i * 11,
                    -78,
                    2,
                    75,
                    "#b43735"
                )
                i = i + 1
            end
        end
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-12, -81}, 2),
                    __arrL({58, -122}, 2),
                    __arrL({74, -122}, 2),
                    __arrL({145, -81}, 2)
                },
                4
            ),
            "#694644"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-10, -86}, 2),
                    __arrL({64, -127}, 2),
                    __arrL({144, -86}, 2),
                    __arrL({137, -78}, 2),
                    __arrL({65, -116}, 2),
                    __arrL({-5, -78}, 2)
                },
                6
            ),
            "#ef6b45"
        )
        do
            local i = 0
            while i < 6 do
                line(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({9 + i * 10, -95 - i * 5}, 2),
                            __arrL({68 + i * 10, -95 + i * 5}, 2)
                        },
                        2
                    ),
                    "#b24238",
                    2
                )
                i = i + 1
            end
        end
        rect(
            nil,
            c,
            45,
            -56,
            45,
            56,
            "#f2d5a0"
        )
        rect(
            nil,
            c,
            49,
            -53,
            37,
            53,
            "#6e4932"
        )
        rect(
            nil,
            c,
            52,
            -51,
            31,
            51,
            "#9d5c35"
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({52, -49}, 2),
                    __arrL({82, -2}, 2),
                    __arrL({52, -2}, 2),
                    __arrL({82, -49}, 2)
                },
                4
            ),
            "#e6c48f",
            4
        )
        rect(
            nil,
            c,
            66,
            -49,
            3,
            48,
            "#f5d8a5"
        )
        rect(
            nil,
            c,
            66,
            -101,
            16,
            18,
            "#e7c68e"
        )
        rect(
            nil,
            c,
            69,
            -98,
            10,
            12,
            "#365d72"
        )
        rect(
            nil,
            c,
            73,
            -98,
            2,
            12,
            "#b6e8ee"
        )
        rect(
            nil,
            c,
            69,
            -93,
            10,
            2,
            "#b6e8ee"
        )
        for ____, xx in __iterar((__arrL({12, 104}, 2))) do
            rect(
                nil,
                c,
                xx,
                -57,
                17,
                25,
                "#f2cf95"
            )
            rect(
                nil,
                c,
                xx + 3,
                -54,
                11,
                19,
                "#417f93"
            )
            rect(
                nil,
                c,
                xx + 7,
                -54,
                2,
                19,
                "#c1eff2"
            )
            rect(
                nil,
                c,
                xx + 3,
                -46,
                11,
                2,
                "#c1eff2"
            )
        end
        rect(
            nil,
            c,
            -7,
            -1,
            147,
            5,
            "#8a683b"
        )
        c:restore()
    end
    local function paintScenery(self, c, W, H)
        local sky = c:createLinearGradient(0, 0, 0, H)
        sky:addColorStop(0, "#238fe5")
        sky:addColorStop(0.54, "#91d9ff")
        sky:addColorStop(1, "#e4f5f1")
        c.fillStyle = sky
        c:fillRect(0, 0, W, H)
        local sx = W * 0.76
        local sy = H * 0.17
        rect(
            nil,
            c,
            sx - 19,
            sy - 27,
            38,
            54,
            "#ffcf36"
        )
        rect(
            nil,
            c,
            sx - 27,
            sy - 19,
            54,
            38,
            "#ffcf36"
        )
        rect(
            nil,
            c,
            sx - 23,
            sy - 23,
            46,
            46,
            "#fff185"
        )
        rect(
            nil,
            c,
            sx - 12,
            sy - 20,
            24,
            4,
            "#fff8bd"
        )
        do
            local i = -1
            while i < 8 do
                local xx = i * 216
                local yy = H * 0.68
                mountain(
                    nil,
                    c,
                    xx,
                    yy,
                    0.95,
                    if __t(__mod(i, 2)) then "#6ca7ce" else "#77b5d8"
                )
                poly(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({xx - 82, yy - 74}, 2),
                            __arrL({xx - 8, yy - 147}, 2),
                            __arrL({xx + 37, yy - 95}, 2),
                            __arrL({xx + 20, yy - 93}, 2),
                            __arrL({xx - 4, yy - 122}, 2),
                            __arrL({xx - 36, yy - 77}, 2)
                        },
                        6
                    ),
                    "#99c9e3"
                )
                poly(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({xx - 8, yy - 147}, 2),
                            __arrL({xx + 37, yy - 95}, 2),
                            __arrL({xx + 86, yy - 75}, 2),
                            __arrL({xx + 40, yy - 76}, 2)
                        },
                        4
                    ),
                    "#6198c4"
                )
                i = i + 1
            end
        end
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({0, H * 0.75}, 2),
                    __arrL({W * 0.12, H * 0.61}, 2),
                    __arrL({W * 0.27, H * 0.69}, 2),
                    __arrL({W * 0.43, H * 0.58}, 2),
                    __arrL({W * 0.6, H * 0.7}, 2),
                    __arrL({W * 0.81, H * 0.58}, 2),
                    __arrL({W, H * 0.71}, 2),
                    __arrL({W, H}, 2),
                    __arrL({0, H}, 2)
                },
                9
            ),
            "#4caa49"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({0, H * 0.84}, 2),
                    __arrL({W * 0.18, H * 0.72}, 2),
                    __arrL({W * 0.34, H * 0.81}, 2),
                    __arrL({W * 0.55, H * 0.7}, 2),
                    __arrL({W * 0.74, H * 0.79}, 2),
                    __arrL({W, H * 0.69}, 2),
                    __arrL({W, H}, 2),
                    __arrL({0, H}, 2)
                },
                8
            ),
            "#80c94c"
        )
        do
            local i = 0
            while i < 62 do
                local xx = __mod(i * 197 + 83, W)
                local yy = H * 0.7 + __mod(i * 37, H * 0.26)
                rect(
                    nil,
                    c,
                    xx,
                    yy,
                    15 + __mod(i, 4) * 7,
                    2,
                    if __t(__mod(i, 3)) then "#6cb84a" else "#a1da61"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 13 do
                tree(
                    nil,
                    c,
                    40 + i * (W - 80) / 12,
                    H * 0.77 + __mod(i, 3) * 7,
                    0.28 + __mod(i, 3) * 0.035,
                    __mod(i, 3) == 0
                )
                i = i + 1
            end
        end
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({W * 0.43, H * 0.77}, 2),
                    __arrL({W * 0.48, H * 0.77}, 2),
                    __arrL({W * 0.58, H}, 2),
                    __arrL({W * 0.37, H}, 2)
                },
                4
            ),
            "#c9df8b"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({W * 0.442, H * 0.77}, 2),
                    __arrL({W * 0.477, H * 0.77}, 2),
                    __arrL({W * 0.55, H}, 2),
                    __arrL({W * 0.39, H}, 2)
                },
                4
            ),
            "#27b1dc"
        )
        do
            local i = 0
            while i < 7 do
                rect(
                    nil,
                    c,
                    W * 0.438 + i * 2,
                    H * 0.8 + i * H * 0.03,
                    24 + i * 6,
                    2,
                    "#99e7ef"
                )
                i = i + 1
            end
        end
        local bx = W * 0.12
        local by = H * 0.91
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({bx - 68, by}, 2),
                    __arrL({bx + 102, by}, 2),
                    __arrL({bx + 180, H}, 2),
                    __arrL({bx - 120, H}, 2)
                },
                4
            ),
            "#d7b571"
        )
        do
            local i = 0
            while i < 4 do
                line(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({bx - 58 + i * 37, by + 3}, 2),
                            __arrL({bx - 111 + i * 71, H}, 2)
                        },
                        2
                    ),
                    "#ad864a",
                    3
                )
                i = i + 1
            end
        end
        barn(
            nil,
            c,
            bx,
            by,
            0.69
        )
        fence(
            nil,
            c,
            W * 0.015,
            H * 0.92,
            W * 0.23,
            0.76
        )
        fence(
            nil,
            c,
            W * 0.64,
            H * 0.91,
            W * 0.29,
            0.68
        )
        do
            local i = 0
            while i < 6 do
                local xx = W * 0.04 + i * 26
                local yy = H * 0.97 + __mod(i, 2) * 5
                rect(
                    nil,
                    c,
                    xx,
                    yy - 15,
                    23,
                    17,
                    "#d8a23d"
                )
                rect(
                    nil,
                    c,
                    xx + 2,
                    yy - 15,
                    19,
                    3,
                    "#f7d06c"
                )
                rect(
                    nil,
                    c,
                    xx + 5,
                    yy - 12,
                    2,
                    12,
                    "#b78230"
                )
                rect(
                    nil,
                    c,
                    xx + 16,
                    yy - 12,
                    2,
                    12,
                    "#b78230"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 5 do
                local xx = W * 0.66 + i * 58
                local yy = H * 0.92 + __mod(i, 2) * 10
                rect(
                    nil,
                    c,
                    xx,
                    yy - 44,
                    49,
                    45,
                    if __t(__mod(i, 2)) then "#fff0cc" else "#eee8cf"
                )
                rect(
                    nil,
                    c,
                    xx + 1,
                    yy - 7,
                    47,
                    8,
                    "#c5b48a"
                )
                poly(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({xx - 5, yy - 44}, 2),
                            __arrL({xx + 24, yy - 64}, 2),
                            __arrL({xx + 54, yy - 44}, 2)
                        },
                        3
                    ),
                    if __t(__mod(i, 2)) then "#c14439" else "#2c69a0"
                )
                rect(
                    nil,
                    c,
                    xx + 8,
                    yy - 34,
                    11,
                    15,
                    "#3d8ab1"
                )
                rect(
                    nil,
                    c,
                    xx + 32,
                    yy - 34,
                    10,
                    15,
                    "#3d8ab1"
                )
                rect(
                    nil,
                    c,
                    xx + 22,
                    yy - 21,
                    12,
                    22,
                    "#91613c"
                )
                rect(
                    nil,
                    c,
                    xx + 8,
                    yy - 33,
                    3,
                    11,
                    "#c0e9ed"
                )
                rect(
                    nil,
                    c,
                    xx + 32,
                    yy - 33,
                    3,
                    11,
                    "#c0e9ed"
                )
                rect(
                    nil,
                    c,
                    xx + 4,
                    yy - 3,
                    42,
                    2,
                    "#d9cf9f"
                )
                i = i + 1
            end
        end
        local fx = W * 0.86
        local fy = H * 0.98
        do
            local row = 0
            while row < 4 do
                line(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({fx - 110, fy + row * 11}, 2),
                            __arrL({fx + 130, fy + row * 11}, 2)
                        },
                        2
                    ),
                    "#9e743e",
                    3
                )
                do
                    local i = 0
                    while i < 12 do
                        local xx = fx - 105 + i * 21
                        local yy = fy + row * 11
                        rect(
                            nil,
                            c,
                            xx,
                            yy - 7,
                            3,
                            8,
                            "#347f3f"
                        )
                        rect(
                            nil,
                            c,
                            xx - 3,
                            yy - 5,
                            8,
                            3,
                            "#5caf41"
                        )
                        i = i + 1
                    end
                end
                row = row + 1
            end
        end
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({W * 0.015, H * 1.04, 0.9}, 3),
                __arrL({W * 0.965, H * 1.03, 0.92}, 3),
                __arrL({W * 0.59, H * 1.05, 0.49}, 3)
            },
            3
        ))) do
            local xx = ____value[1]
            local yy = ____value[2]
            local sz = ____value[3]
            tree(
                nil,
                c,
                xx,
                yy,
                sz,
                1
            )
        end
        local mx = W * 0.457
        local my = H * 0.87
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({mx - 31, my}, 2),
                    __arrL({mx + 45, my - 4}, 2),
                    __arrL({mx + 54, my + 7}, 2),
                    __arrL({mx - 37, my + 12}, 2)
                },
                4
            ),
            "#98613b"
        )
        do
            local i = 0
            while i < 10 do
                line(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({mx - 29 + i * 8, my}, 2),
                            __arrL({mx - 32 + i * 9, my + 9}, 2)
                        },
                        2
                    ),
                    "#e0b46a",
                    3
                )
                i = i + 1
            end
        end
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({mx - 32, my - 12}, 2),
                    __arrL({mx + 44, my - 16}, 2)
                },
                2
            ),
            "#f0d69a",
            3
        )
        for ____, dx in __iterar((__arrL({-32, 5, 44}, 3))) do
            rect(
                nil,
                c,
                mx + dx,
                my - 15,
                3,
                27,
                "#a57b43"
            )
        end
    end
    local function drawBackground(self, c, camera, time, W, H)
        if camera == nil then
            camera = {}
        end
        if time == nil then
            time = 0
        end
        if W == nil then
            W = 960
        end
        if H == nil then
            H = 540
        end
        W = math.max(
            1,
            math.floor(W + 0.5)
        )
        H = math.max(
            1,
            math.floor(H + 0.5)
        )
        local ____t_17 = __t
        local ____TS__Number_result_16 = __TS__Number(camera.x)
        __O[2475] = ____TS__Number_result_16
        local x = if ____t_17(____TS__Number_result_16) then __O[2475] else 640
        local ____t_19 = __t
        local ____TS__Number_result_18 = __TS__Number(camera.y)
        __O[2476] = ____TS__Number_result_18
        local y = if ____t_19(____TS__Number_result_18) then __O[2476] else 340
        local ____t_21 = __t
        local ____TS__Number_result_20 = __TS__Number(time)
        __O[2477] = ____TS__Number_result_20
        local t = if ____t_21(____TS__Number_result_20) then __O[2477] else 0
        local over = 256
        local shift = over / 2 + clamp(nil, (x - 640) * 0.045, -85, 85)
        local sy = clamp(nil, (y - 340) * 0.016, -8, 8)
        local bg = cachedCanvas(
            nil,
            sceneryCache,
            __add(
                __add(W, ":"),
                H
            ),
            W + over,
            H + 18,
            function(____, g) return paintScenery(nil, g, W + over, H + 18) end,
            2
        )
        c:save()
        c.imageSmoothingEnabled = false
        c:drawImage(
            bg,
            math.floor(shift + 0.5),
            9 + math.floor(sy + 0.5),
            W,
            H,
            0,
            0,
            W,
            H
        )
        do
            local i = 0
            while i < 6 do
                local xx = __mod(
                    __mod(i * 241 + t * if __t(__mod(i, 2)) then 2.1 else 3.2 - x * 0.065, W + 240) + W + 240,
                    W + 240
                ) - 120
                cloud(
                    nil,
                    c,
                    xx,
                    35 + __mod(i, 4) * 36 - y * 0.017,
                    0.52 + __mod(i, 3) * 0.14,
                    if __t(__mod(i, 2)) then "#e0f5ff" else "#ffffff"
                )
                i = i + 1
            end
        end
        windmill(
            nil,
            c,
            W * 0.2 - (x - 640) * 0.025,
            H * 0.88 - (y - 340) * 0.012,
            t,
            0.63
        )
        local bx = W * 0.69 - (x - 640) * 0.035
        local by = H * 0.88
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({bx - 15, by - 52}, 2),
                    __arrL({bx + 195, by - 52}, 2)
                },
                2
            ),
            "#7a6848",
            1
        )
        do
            local i = 0
            while i < 9 do
                local xx = bx + i * 23
                poly(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({xx, by - 52}, 2),
                            __arrL({xx + 12, by - 52}, 2),
                            __arrL(
                                {
                                    xx + 7,
                                    by - 39 + math.sin(t * 2.4 + i) * 2
                                },
                                2
                            )
                        },
                        3
                    ),
                    __get(
                        __arrL({"#ed5c41", "#ffd24b", "#348fd0", "#fff2c5"}, 4),
                        __mod(i, 4)
                    )
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 4 do
                local xx = W * 0.38 + math.sin(i * 1.9) * 23
                local yy = H * 0.87 + i * 18 + __mod(t * 7, 14)
                rect(
                    nil,
                    c,
                    xx,
                    yy,
                    21 + i * 6,
                    2,
                    "#c2f5f6"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 4 do
                local bx = __mod(
                    __mod(i * 233 + t * 10 - x * 0.11, W + 120) + W + 120,
                    W + 120
                ) - 60
                local by = 77 + __mod(i, 3) * 38 + math.sin(t * 0.7 + i) * 4
                local wing = math.floor(math.sin(t * 4 + i) * 3 + 0.5)
                line(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({bx - 5, by + wing}, 2),
                            __arrL({bx, by}, 2),
                            __arrL({bx + 5, by + wing}, 2)
                        },
                        3
                    ),
                    "#3679a2",
                    2
                )
                i = i + 1
            end
        end
        c:restore()
    end
    local function grass(self, c, x, y, t, seed)
        if seed == nil then
            seed = 0
        end
        do
            local i = 0
            while i < 4 do
                local px = x + i * 8
                local sway = math.floor(math.sin(t * 2 + seed + i) * 1.4 + 0.5)
                line(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({px, y}, 2),
                            __arrL(
                                {
                                    px + sway - 2,
                                    y - 5 - __mod(i, 2) * 3
                                },
                                2
                            )
                        },
                        2
                    ),
                    if __t(__mod(i, 2)) then "#298d3c" else "#81d94b",
                    2
                )
                i = i + 1
            end
        end
    end
    local function paintPlatform(self, c, w, main)
        local y = 8
        if __t(main) then
            poly(
                nil,
                c,
                __arrL(
                    {
                        __arrL({5, y + 8}, 2),
                        __arrL({w - 5, y + 8}, 2),
                        __arrL({w - 31, y + 42}, 2),
                        __arrL({w * 0.85, y + 58}, 2),
                        __arrL({w * 0.75, y + 99}, 2),
                        __arrL({w * 0.61, y + 86}, 2),
                        __arrL({w * 0.49, y + 124}, 2),
                        __arrL({w * 0.35, y + 92}, 2),
                        __arrL({w * 0.25, y + 109}, 2),
                        __arrL({w * 0.12, y + 64}, 2),
                        __arrL({28, y + 42}, 2)
                    },
                    11
                ),
                "#4b423b"
            )
            poly(
                nil,
                c,
                __arrL(
                    {
                        __arrL({8, y + 10}, 2),
                        __arrL({w - 9, y + 10}, 2),
                        __arrL({w - 37, y + 35}, 2),
                        __arrL({w * 0.83, y + 50}, 2),
                        __arrL({w * 0.74, y + 82}, 2),
                        __arrL({w * 0.61, y + 69}, 2),
                        __arrL({w * 0.48, y + 105}, 2),
                        __arrL({w * 0.35, y + 75}, 2),
                        __arrL({w * 0.25, y + 90}, 2),
                        __arrL({w * 0.14, y + 52}, 2),
                        __arrL({31, y + 34}, 2)
                    },
                    11
                ),
                "#a56f45"
            )
            do
                local i = 0
                while i < math.floor(w / 23) do
                    local xx = 15 + i * 23
                    local yy = y + 16 + __mod(i * 17, 39)
                    rect(
                        nil,
                        c,
                        xx,
                        yy,
                        14 + __mod(i, 3) * 4,
                        5,
                        __get(
                            __arrL({"#c98a4b", "#77523a", "#d8a368"}, 3),
                            __mod(i, 3)
                        )
                    )
                    rect(
                        nil,
                        c,
                        xx + 2,
                        yy + 5,
                        9,
                        2,
                        "#866044"
                    )
                    i = i + 1
                end
            end
            do
                local i = 0
                while i < 8 do
                    local xx = 35 + i * (w - 70) / 7
                    poly(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({xx, y + 13}, 2),
                                __arrL({xx + 24, y + 15}, 2),
                                __arrL({xx + 33, y + 38}, 2),
                                __arrL({xx + 10, y + 49}, 2),
                                __arrL({xx - 5, y + 31}, 2)
                            },
                            5
                        ),
                        if __t(__mod(i, 2)) then "#7d7970" else "#989282"
                    )
                    rect(
                        nil,
                        c,
                        xx + 2,
                        y + 17,
                        15,
                        4,
                        "#b0aa96"
                    )
                    rect(
                        nil,
                        c,
                        xx + 8,
                        y + 36,
                        13,
                        3,
                        "#5e645d"
                    )
                    i = i + 1
                end
            end
            do
                local i = 0
                while i < 8 do
                    local xx = 65 + i * (w - 130) / 7
                    line(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({xx, y + 25}, 2),
                                __arrL({xx - 5, y + 58}, 2),
                                __arrL({xx + 9, y + 77}, 2)
                            },
                            3
                        ),
                        "#725035",
                        5
                    )
                    line(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({xx - 4, y + 52}, 2),
                                __arrL({xx - 17, y + 61}, 2)
                            },
                            2
                        ),
                        "#725035",
                        3
                    )
                    i = i + 1
                end
            end
            local cx = w / 2
            line(
                nil,
                c,
                __arrL(
                    {
                        __arrL({cx - 62, y + 13}, 2),
                        __arrL({cx - 62, y + 35}, 2),
                        __arrL({cx + 62, y + 35}, 2),
                        __arrL({cx + 62, y + 13}, 2)
                    },
                    4
                ),
                "#59432e",
                2
            )
            rect(
                nil,
                c,
                cx - 74,
                y + 30,
                148,
                26,
                "#5b3d2b"
            )
            rect(
                nil,
                c,
                cx - 71,
                y + 33,
                142,
                20,
                "#b47a40"
            )
            rect(
                nil,
                c,
                cx - 69,
                y + 34,
                138,
                2,
                "#efbf6a"
            )
            do
                local i = 0
                while i < 3 do
                    rect(
                        nil,
                        c,
                        cx - 66 + i * 59,
                        y + 48,
                        41,
                        1,
                        "#8b5b33"
                    )
                    i = i + 1
                end
            end
            label(
                nil,
                c,
                "TERREIRO DA RESENHA",
                cx,
                y + 44,
                9,
                "#ffedbd"
            )
        else
            poly(
                nil,
                c,
                __arrL(
                    {
                        __arrL({0, y + 5}, 2),
                        __arrL({w, y + 5}, 2),
                        __arrL({w - 15, y + 23}, 2),
                        __arrL({w * 0.7, y + 30}, 2),
                        __arrL({w * 0.55, y + 45}, 2),
                        __arrL({w * 0.37, y + 33}, 2),
                        __arrL({14, y + 25}, 2)
                    },
                    7
                ),
                "#55433a"
            )
            poly(
                nil,
                c,
                __arrL(
                    {
                        __arrL({5, y + 8}, 2),
                        __arrL({w - 7, y + 8}, 2),
                        __arrL({w - 20, y + 19}, 2),
                        __arrL({w * 0.67, y + 23}, 2),
                        __arrL({w * 0.54, y + 34}, 2),
                        __arrL({w * 0.36, y + 24}, 2),
                        __arrL({17, y + 19}, 2)
                    },
                    7
                ),
                "#a97647"
            )
            rect(
                nil,
                c,
                0,
                y + 3,
                w,
                10,
                "#765237"
            )
            rect(
                nil,
                c,
                4,
                y + 4,
                w - 8,
                3,
                "#e0ac61"
            )
            rect(
                nil,
                c,
                8,
                y + 9,
                w - 16,
                2,
                "#b37c42"
            )
            do
                local i = 0
                while i < math.floor(w / 30) do
                    local xx = 12 + i * 30
                    rect(
                        nil,
                        c,
                        xx,
                        y + 5,
                        2,
                        6,
                        "#6b4e35"
                    )
                    rect(
                        nil,
                        c,
                        xx + 13,
                        y + 6,
                        2,
                        2,
                        "#354443"
                    )
                    i = i + 1
                end
            end
            for ____, xx in __iterar((__arrL({16, w - 36}, 2))) do
                poly(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({xx, y + 16}, 2),
                            __arrL({xx + 16, y + 13}, 2),
                            __arrL({xx + 25, y + 23}, 2),
                            __arrL({xx + 12, y + 31}, 2)
                        },
                        4
                    ),
                    "#8a8c7a"
                )
                rect(
                    nil,
                    c,
                    xx + 5,
                    y + 17,
                    10,
                    3,
                    "#c2bea0"
                )
            end
        end
        rect(
            nil,
            c,
            if __t(main) then 3 else 0,
            y,
            if __t(main) then w - 6 else w,
            7,
            "#257b38"
        )
        rect(
            nil,
            c,
            if __t(main) then 4 else 1,
            y - 2,
            if __t(main) then w - 8 else w - 2,
            5,
            "#70ca43"
        )
        rect(
            nil,
            c,
            if __t(main) then 7 else 3,
            y - 3,
            if __t(main) then w - 14 else w - 6,
            2,
            "#c0ee78"
        )
        do
            local i = 0
            while i < math.floor(w / 16) do
                local xx = 7 + i * 16
                rect(
                    nil,
                    c,
                    xx,
                    y + 1,
                    7,
                    2,
                    if __t(__mod(i, 3)) then "#8fda4d" else "#44a13b"
                )
                if __mod(i, 4) == 0 then
                    rect(
                        nil,
                        c,
                        xx,
                        y + 5,
                        5,
                        3,
                        "#419038"
                    )
                end
                i = i + 1
            end
        end
    end
    local function drawStage(self, c, platforms, time)
        if platforms == nil then
            platforms = __arrL({}, 0)
        end
        if time == nil then
            time = 0
        end
        local ____t_23 = __t
        local ____TS__Number_result_22 = __TS__Number(time)
        __O[2478] = ____TS__Number_result_22
        local t = if ____t_23(____TS__Number_result_22) then __O[2478] else 0
        c:save()
        c.imageSmoothingEnabled = false
        for ____, p in __iterar((platforms)) do
            local ____t_25 = __t
            local ____TS__Number_result_24 = __TS__Number(p.x)
            __O[2479] = ____TS__Number_result_24
            local x = if ____t_25(____TS__Number_result_24) then __O[2479] else 0
            local ____t_27 = __t
            local ____TS__Number_result_26 = __TS__Number(p.y)
            __O[2480] = ____TS__Number_result_26
            local y = if ____t_27(____TS__Number_result_26) then __O[2480] else 0
            local ____t_29 = __t
            local ____TS__Number_result_28 = __TS__Number(p.w)
            __O[2481] = ____TS__Number_result_28
            local w = math.floor(if ____t_29(____TS__Number_result_28) then __O[2481] else 100 + 0.5)
            local main = not not __t(p.main)
            local key = __add(if __t(main) then "m:" else "p:", w)
            local image = cachedCanvas(
                nil,
                platformCache,
                key,
                w + 2,
                if __t(main) then 148 else 67,
                function(____, g) return paintPlatform(nil, g, w, main) end,
                8
            )
            c:drawImage(
                image,
                math.floor(x + 0.5),
                math.floor(y + 0.5) - 8
            )
            if __t(main) then
                for ____, side in __iterar((__arrL({-1, 1}, 2))) do
                    local xx = if side < 0 then x + 36 else x + w - 44
                    rect(
                        nil,
                        c,
                        xx,
                        y + 33,
                        9,
                        108,
                        "#228fce"
                    )
                    rect(
                        nil,
                        c,
                        xx + 2,
                        y + 33,
                        4,
                        108,
                        "#6dd7f2"
                    )
                    do
                        local j = 0
                        while j < 4 do
                            rect(
                                nil,
                                c,
                                xx + 2,
                                y + 35 + __mod(t * 61 + j * 29, 104),
                                3,
                                8,
                                "#dbffff"
                            )
                            j = j + 1
                        end
                    end
                end
                do
                    local i = 0
                    while i < 5 do
                        local xx = x + 72 + i * (w - 144) / 4
                        line(
                            nil,
                            c,
                            __arrL(
                                {
                                    __arrL({xx, y + 32}, 2),
                                    __arrL({xx - 4, y + 56}, 2),
                                    __arrL(
                                        {
                                            xx + math.sin(t * 1.5 + i),
                                            y + 76
                                        },
                                        2
                                    )
                                },
                                3
                            ),
                            "#36733c",
                            2
                        )
                        rect(
                            nil,
                            c,
                            xx - 6,
                            y + 45,
                            7,
                            4,
                            "#62ab43"
                        )
                        rect(
                            nil,
                            c,
                            xx - 1,
                            y + 64,
                            7,
                            4,
                            "#8bc751"
                        )
                        i = i + 1
                    end
                end
            end
            grass(
                nil,
                c,
                x + 11,
                y - 3,
                t,
                x
            )
            if w > 160 then
                grass(
                    nil,
                    c,
                    x + w - 42,
                    y - 3,
                    t,
                    x + w
                )
            end
            for ____, ____value in __iterar((__call(
                __arrL({x + 26, x + w - 28}, 2),
                "entries"
            ))) do
                local i = ____value[1]
                local xx = ____value[2]
                if __t(not __t(main) and i == 0) then
                    continue
                end
                local sway = math.floor(math.sin(t * 2 + i) * 1 + 0.5)
                rect(
                    nil,
                    c,
                    xx + sway,
                    y - 11,
                    2,
                    9,
                    "#3e873b"
                )
                rect(
                    nil,
                    c,
                    xx + sway - 2,
                    y - 15,
                    6,
                    5,
                    if __t(i) then "#ffcf3f" else "#f7694c"
                )
                rect(
                    nil,
                    c,
                    xx + sway,
                    y - 14,
                    2,
                    2,
                    "#fff4b6"
                )
            end
        end
        c:restore()
    end
    local function glove(self, c, x, y, color, rotation)
        if rotation == nil then
            rotation = 0
        end
        c:save()
        c:translate(x, y)
        c:rotate(rotation)
        rect(
            nil,
            c,
            -6,
            -8,
            18,
            16,
            INK
        )
        rect(
            nil,
            c,
            -4,
            -6,
            14,
            12,
            color
        )
        rect(
            nil,
            c,
            -3,
            -6,
            4,
            3,
            "#ffe4be"
        )
        rect(
            nil,
            c,
            -10,
            1,
            7,
            6,
            color
        )
        rect(
            nil,
            c,
            9,
            -5,
            2,
            8,
            "#b67c62"
        )
        c:restore()
    end
    local function weight(self, c, x, y, r, s, color)
        if r == nil then
            r = 0
        end
        if s == nil then
            s = 1
        end
        if color == nil then
            color = "#8eabc0"
        end
        c:save()
        c:translate(x, y)
        c:rotate(r)
        c:scale(s, s)
        rect(
            nil,
            c,
            -18,
            -3,
            36,
            6,
            "#d0d9cd"
        )
        for ____, xx in __iterar((__arrL({-21, 13}, 2))) do
            rect(
                nil,
                c,
                xx,
                -11,
                8,
                22,
                INK
            )
            rect(
                nil,
                c,
                xx + 2,
                -9,
                4,
                18,
                color
            )
            rect(
                nil,
                c,
                xx - 4,
                -7,
                5,
                14,
                "#587487"
            )
        end
        rect(
            nil,
            c,
            -3,
            -2,
            6,
            2,
            "#f1eedb"
        )
        c:restore()
    end
    local function heel(self, c, x, y, r, s, color)
        if r == nil then
            r = 0
        end
        if s == nil then
            s = 1
        end
        if color == nil then
            color = "#e196af"
        end
        c:save()
        c:translate(x, y)
        c:rotate(r)
        c:scale(s, s)
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-14, -5}, 2),
                    __arrL({-6, -5}, 2),
                    __arrL({-2, 1}, 2),
                    __arrL({12, 3}, 2),
                    __arrL({15, 8}, 2),
                    __arrL({-11, 8}, 2),
                    __arrL({-14, 4}, 2)
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
                    __arrL({-12, -3}, 2),
                    __arrL({-7, -3}, 2),
                    __arrL({-3, 3}, 2),
                    __arrL({11, 5}, 2),
                    __arrL({12, 6}, 2),
                    __arrL({-10, 6}, 2)
                },
                6
            ),
            color
        )
        rect(
            nil,
            c,
            -13,
            5,
            4,
            13,
            INK
        )
        rect(
            nil,
            c,
            -11,
            8,
            2,
            9,
            color
        )
        rect(
            nil,
            c,
            -9,
            -2,
            4,
            3,
            "#ffe6d3"
        )
        c:restore()
    end
    local function ball(self, c, x, y, r, s)
        if r == nil then
            r = 0
        end
        if s == nil then
            s = 1
        end
        c:save()
        c:translate(x, y)
        c:rotate(r)
        c:scale(s, s)
        rect(
            nil,
            c,
            -9,
            -6,
            18,
            12,
            "#f7efcf"
        )
        rect(
            nil,
            c,
            -6,
            -9,
            12,
            18,
            "#f7efcf"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-3, -4}, 2),
                    __arrL({3, -4}, 2),
                    __arrL({5, 1}, 2),
                    __arrL({0, 5}, 2),
                    __arrL({-5, 1}, 2)
                },
                5
            ),
            "#283e4a"
        )
        rect(
            nil,
            c,
            -9,
            -3,
            4,
            6,
            "#283e4a"
        )
        rect(
            nil,
            c,
            5,
            -4,
            4,
            5,
            "#283e4a"
        )
        rect(
            nil,
            c,
            -3,
            6,
            5,
            3,
            "#283e4a"
        )
        c:restore()
    end
    local function claw(self, c, x, y, t, color)
        if color == nil then
            color = "#e8ebd8"
        end
        do
            local i = 0
            while i < 3 do
                line(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x - 12 + i * 8, y + 15}, 2),
                            __arrL({x - 4 + i * 8, y}, 2),
                            __arrL({x + 1 + i * 8, y - 13}, 2)
                        },
                        3
                    ),
                    color,
                    3
                )
                i = i + 1
            end
        end
    end
    local trouser = __ord({
        daroca = "#526251",
        reeis = "#294b68",
        nikolas = "#353a55",
        marco = "#252e34",
        menezes = "#3b5059",
        ollyan = "#384454",
        igor = "#216da6",
        kaique = "#243b53",
        freddy = "#293c50",
        dede = "#3a434d",
        arthur = "#2c435c",
        nicolas = "#34455d",
        caleb = "#344854",
        lucas = "#263f5b",
        kaua = "#455264",
        mota = "#23426a",
        ravid = "#40584a",
        almiro = "#263e5a",
        miqueias = "#4d5149",
        davi = "#30343c",
        vitor = "#414c53",
        allef = "#34424d"
    }, "daroca,reeis,nikolas,marco,menezes,ollyan,igor,kaique,freddy,dede,arthur,nicolas,caleb,lucas,kaua,mota,ravid,almiro,miqueias,davi,vitor,allef")
    local gait = __ord({
        igor = 7.7,
        lucas = 13.3,
        kaique = 10.4,
        freddy = 12.1,
        mota = 11.8,
        caleb = 9.2,
        menezes = 12.8,
        ollyan = 10.8
    }, "igor,lucas,kaique,freddy,mota,caleb,menezes,ollyan")
    local function smooth(____, a, b, v)
        local n = clamp(nil, (v - a) / (b - a), 0, 1)
        return n * n * (3 - 2 * n)
    end
    local function legProfile(self, id)
        if id == "igor" then
            return {
                hipY = -13,
                upper = 5.5,
                lower = 7.5,
                spread = 7,
                width = 7
            }
        end
        if id == "lucas" then
            return {
                hipY = -20,
                upper = 9,
                lower = 10,
                spread = 4,
                width = 6
            }
        end
        if id == "kaique" then
            return {
                hipY = -28,
                upper = 13,
                lower = 14,
                spread = 4,
                width = 5
            }
        end
        if __t(__call(girls, "has", id)) then
            return {
                hipY = -24,
                upper = 11,
                lower = 12,
                spread = 5,
                width = 6
            }
        end
        return {
            hipY = -24,
            upper = 11,
            lower = 12,
            spread = if id == "caleb" then 6 else 5,
            width = if id == "caleb" then 7 else 6
        }
    end
    local function solveLeg(self, hip, target, upper, lower, bend)
        if bend == nil then
            bend = 1
        end
        local dx = __get(target, 0) - __get(hip, 0)
        local dy = __get(target, 1) - __get(hip, 1)
        local raw = __hypot(dx, dy)
        local d = clamp(
            nil,
            raw,
            math.abs(upper - lower) + 0.01,
            __add(upper, lower) - 0.015
        )
        local ux = if raw > 0.0001 then dx / raw else 0
        local uy = if raw > 0.0001 then dy / raw else 1
        local a = (upper * upper - lower * lower + d * d) / (2 * d)
        local offset = math.sqrt(math.max(0, upper * upper - a * a))
        return {
            hip = __arrL(
                {
                    __get(hip, 0),
                    __get(hip, 1)
                },
                2
            ),
            knee = __arrL(
                {
                    __get(hip, 0) + ux * a - uy * offset * bend,
                    __get(hip, 1) + uy * a + ux * offset * bend
                },
                2
            ),
            foot = __arrL(
                {
                    __get(hip, 0) + ux * d,
                    __get(hip, 1) + uy * d
                },
                2
            )
        }
    end
    local function legPose(self, id, motion, time, direction, progress, combo, kinematics)
        if motion == nil then
            motion = "idle"
        end
        if time == nil then
            time = 0
        end
        if direction == nil then
            direction = "side"
        end
        if progress == nil then
            progress = 0
        end
        if combo == nil then
            combo = false
        end
        if kinematics == nil then
            kinematics = {}
        end
        local pr = legProfile(nil, id)
        local ____t_31 = __t
        local ____TS__Number_result_30 = __TS__Number(time)
        __O[2482] = ____TS__Number_result_30
        local ____temp_34 = if ____t_31(____TS__Number_result_30) then __O[2482] else 0
        local ____t_33 = __t
        local ____get_result_32 = __get(gait, id)
        __O[2483] = ____get_result_32
        local phase = ____temp_34 * if ____t_33(____get_result_32) then __O[2483] else 10.7
        local L = pr.upper + pr.lower
        local hips = __arrL(
            {
                __arrL({-pr.spread, pr.hipY}, 2),
                __arrL({pr.spread, pr.hipY}, 2)
            },
            2
        )
        local feet = __arrL(
            {
                __arrL({-pr.spread - 2, -1.5}, 2),
                __arrL({pr.spread + 2, -1.5}, 2)
            },
            2
        )
        local bends = __arrL({-1, 1}, 2)
        local strike = smooth(nil, 0.16, 0.44, progress) * (1 - smooth(nil, 0.61, 1, progress))
        local ____t_38 = __t
        local ____kinematics_motionTime_35 = kinematics.motionTime
        if ____kinematics_motionTime_35 == nil then
            ____kinematics_motionTime_35 = kinematics.mt
        end
        local ____kinematics_motionTime_35_36 = ____kinematics_motionTime_35
        if ____kinematics_motionTime_35_36 == nil then
            ____kinematics_motionTime_35_36 = time
        end
        local ____TS__Number_result_37 = __TS__Number(____kinematics_motionTime_35_36)
        __O[2484] = ____TS__Number_result_37
        local mt = math.max(0, if ____t_38(____TS__Number_result_37) then __O[2484] else 0)
        local ____t_40 = __t
        local ____TS__Number_result_39 = __TS__Number(kinematics.vy)
        __O[2485] = ____TS__Number_result_39
        local vy = if ____t_40(____TS__Number_result_39) then __O[2485] else 0
        local ____t_42 = __t
        local ____TS__Number_result_41 = __TS__Number(kinematics.wall)
        __O[2486] = ____TS__Number_result_41
        local wall = if ____t_42(____TS__Number_result_41) then __O[2486] else 1
        local ____t_44 = __t
        local ____TS__Number_result_43 = __TS__Number(kinematics.dx)
        __O[2487] = ____TS__Number_result_43
        local bodyX = if ____t_44(____TS__Number_result_43) then __O[2487] else 0
        local ____t_46 = __t
        local ____TS__Number_result_45 = __TS__Number(kinematics.dy)
        __O[2488] = ____TS__Number_result_45
        local bodyY = if ____t_46(____TS__Number_result_45) then __O[2488] else 0
        do
            local i = 0
            while i < 2 do
                local side = if __t(i) then 1 else -1
                local wave = math.sin(phase + if __t(i) then math.pi else 0)
                local lift = math.max(
                    0,
                    math.cos(phase + if __t(i) then math.pi else 0)
                )
                if motion == "run" then
                    __set(
                        feet,
                        i,
                        __arrL(
                            {
                                __get(
                                    __get(hips, i),
                                    0
                                ) + wave * L * 0.78,
                                -1.5 - lift * L * 0.5
                            },
                            2
                        )
                    )
                    __set(bends, i, if wave > 0 then -1 else 1)
                elseif motion == "jump" then
                    local launch = 1 - smooth(nil, 0.02, 0.14, mt)
                    local rise = clamp(
                        nil,
                        (__TS__Number(-vy) - 50) / 370,
                        0,
                        1
                    )
                    local apex = 1 - clamp(
                        nil,
                        math.abs(vy) / 100,
                        0,
                        1
                    )
                    local second = kinematics.jumps == 2
                    __set(
                        feet,
                        i,
                        __arrL(
                            {
                                __get(
                                    __get(hips, i),
                                    0
                                ) + if __t(i) then L * 0.46 else -L * 0.44 * (1 - launch * 0.3),
                                if __t(i) then -2 - L * (0.28 + rise * 0.45 + apex * 0.12) else -0.5 - L * (0.1 + rise * 0.2)
                            },
                            2
                        )
                    )
                    if __t(if __t(launch) then not __t(second) else launch) then
                        __set(
                            __get(feet, i),
                            0,
                            __get(
                                __get(hips, i),
                                0
                            ) + side * L * 0.2
                        )
                        __set(
                            __get(feet, i),
                            1,
                            __get(
                                __get(feet, i),
                                1
                            ) + if __t(i) then 8 else 3 * launch
                        )
                    end
                    __set(bends, i, if __t(i) then -1 else 1)
                elseif motion == "doubleJump" then
                    local tuck = math.sin(clamp(nil, mt / 0.26, 0, 1) * math.pi)
                    __set(
                        feet,
                        i,
                        __arrL(
                            {
                                __get(
                                    __get(hips, i),
                                    0
                                ) + side * L * (0.27 + tuck * 0.33),
                                -L * (0.38 + tuck * 0.63) + if __t(i) then -3 else 1
                            },
                            2
                        )
                    )
                    __set(bends, i, if __t(i) then -1 else 1)
                elseif motion == "fall" then
                    local extend = smooth(nil, 30, 500, vy)
                    __set(
                        feet,
                        i,
                        __arrL(
                            {
                                __get(
                                    __get(hips, i),
                                    0
                                ) + side * L * (0.26 - 0.08 * extend),
                                -L * if __t(i) then 0.27 * (1 - extend) + 0.025 else 0.15 * (1 - extend) + 0.015
                            },
                            2
                        )
                    )
                    __set(bends, i, if __t(i) then 1 else -1)
                elseif motion == "dash" then
                    __set(
                        feet,
                        i,
                        __arrL(
                            {
                                __get(
                                    __get(hips, i),
                                    0
                                ) + if __t(i) then L * 0.51 else -L * 0.85,
                                if __t(i) then -L * 0.61 else -L * 0.13
                            },
                            2
                        )
                    )
                    __set(bends, i, if __t(i) then -1 else 1)
                elseif motion == "wallSlide" then
                    __set(
                        feet,
                        i,
                        __arrL({wall * L * if __t(i) then 0.91 else 0.61, -L * if __t(i) then 0.16 else 0.52}, 2)
                    )
                    __set(bends, i, if __t(i) then __TS__Number(-wall) else wall)
                elseif motion == "wallJump" then
                    local push = 1 - smooth(nil, 0.02, 0.23, mt)
                    __set(
                        feet,
                        i,
                        __arrL(
                            {
                                __get(
                                    __get(hips, i),
                                    0
                                ) + if __t(i) then L * (0.35 + push * 0.42) else -L * 0.4,
                                -L * if __t(i) then 0.23 else 0.54
                            },
                            2
                        )
                    )
                    __set(bends, i, if __t(i) then -1 else 1)
                elseif motion == "land" then
                    local squat = 1 - smooth(nil, 0.01, 0.13, mt)
                    __set(
                        feet,
                        i,
                        __arrL(
                            {
                                __get(
                                    __get(hips, i),
                                    0
                                ) + side * L * (0.1 + squat * 0.37),
                                -1.5
                            },
                            2
                        )
                    )
                    __set(bends, i, side)
                end
                __set(
                    __get(hips, i),
                    0,
                    __get(
                        __get(hips, i),
                        0
                    ) + bodyX
                )
                __set(
                    __get(hips, i),
                    1,
                    __get(
                        __get(hips, i),
                        1
                    ) + bodyY
                )
                if not __t(__call(
                    __arrL({"run", "land", "idle"}, 3),
                    "includes",
                    motion
                )) then
                    __set(
                        __get(feet, i),
                        0,
                        __get(
                            __get(feet, i),
                            0
                        ) + bodyX
                    )
                    __set(
                        __get(feet, i),
                        1,
                        __get(
                            __get(feet, i),
                            1
                        ) + bodyY
                    )
                end
                i = i + 1
            end
        end
        local ____t_49 = __t
        local ____t_48 = __t
        local ____temp_47 = progress > 0
        __O[2489] = ____temp_47
        if ____t_49(if ____t_48(____temp_47) then __call(girls, "has", id) else __O[2489]) then
            __set(
                __get(hips, 0),
                1,
                __get(
                    __get(hips, 0),
                    1
                ) + strike * 1.2
            )
            __set(
                __get(feet, 0),
                0,
                __get(
                    __get(feet, 0),
                    0
                ) - strike * 1.6
            )
        end
        local legs = __call(
            hips,
            "map",
            function(____, h, i) return solveLeg(
                nil,
                h,
                __get(feet, i),
                pr.upper,
                pr.lower,
                __get(bends, i)
            ) end
        )
        if __t(progress > 0 and strike > 0) then
            local h = __get(hips, 1)
            local target
            if __t(if __t(combo) then direction ~= "down" else combo) then
                local thighAngle = math.pi / 2 - strike * if direction == "up" then 2.8 else if direction == "neutral" then 1.95 else 2.45
                local knee = __arrL(
                    {
                        __get(h, 0) + math.cos(thighAngle) * pr.upper,
                        __get(h, 1) + math.sin(thighAngle) * pr.upper
                    },
                    2
                )
                local shinAngle = math.pi / 2 + strike * 0.75
                __set(
                    legs,
                    1,
                    {
                        hip = h,
                        knee = knee,
                        foot = __arrL(
                            {
                                __get(knee, 0) + math.cos(shinAngle) * pr.lower,
                                __get(knee, 1) + math.sin(shinAngle) * pr.lower
                            },
                            2
                        )
                    }
                )
            else
                local idle = __arrL({pr.spread + 2, -1.5}, 2)
                target = if direction == "up" then __arrL(
                    {
                        __get(h, 0) + L * 0.4,
                        __get(h, 1) - L * 0.91
                    },
                    2
                ) else if direction == "down" then __arrL(
                    {
                        __get(h, 0) + L * 0.68,
                        __get(h, 1) + L * 0.71
                    },
                    2
                ) else if direction == "neutral" then __arrL(
                    {
                        __get(h, 0) + L * 0.78,
                        __get(h, 1) - L * 0.35
                    },
                    2
                ) else __arrL(
                    {
                        __get(h, 0) + L * 0.98,
                        __get(h, 1) - L * 0.12
                    },
                    2
                )
                target = __arrL(
                    {
                        __get(idle, 0) + (__get(target, 0) - __get(idle, 0)) * strike,
                        __get(idle, 1) + (__get(target, 1) - __get(idle, 1)) * strike
                    },
                    2
                )
                __set(
                    legs,
                    1,
                    solveLeg(
                        nil,
                        h,
                        target,
                        pr.upper,
                        pr.lower,
                        -1
                    )
                )
            end
        end
        return {
            hipY = pr.hipY,
            upper = pr.upper,
            lower = pr.lower,
            width = pr.width,
            legs = legs
        }
    end
    local function drawLegs(self, c, id, pose, kicking, color)
        local ____t_51 = __t
        local ____get_result_50 = __get(trouser, id)
        __O[2490] = ____get_result_50
        local colorPants = if ____t_51(____get_result_50) then __O[2490] else "#2b4662"
        for ____, ____value in __iterar((__call(pose.legs, "entries"))) do
            local i = ____value[1]
            local l = ____value[2]
            line(
                nil,
                c,
                __arrL({l.hip, l.knee, l.foot}, 3),
                INK,
                pose.width + 3
            )
            line(
                nil,
                c,
                __arrL({l.hip, l.knee, l.foot}, 3),
                colorPants,
                pose.width
            )
            line(
                nil,
                c,
                __arrL(
                    {
                        __arrL(
                            {
                                __get(l.hip, 0) - 1,
                                __get(l.hip, 1) + 2
                            },
                            2
                        ),
                        __arrL(
                            {
                                __get(l.knee, 0) - 1,
                                __get(l.knee, 1)
                            },
                            2
                        )
                    },
                    2
                ),
                if __t(i) then "#5e7482" else "#526775",
                2
            )
            local ____t_56 = __t
            local ____t_55 = __t
            local ____t_53 = __t
            local ____call_result_52 = __call(girls, "has", id)
            __O[2491] = ____call_result_52
            local ____temp_54 = if ____t_53(____call_result_52) then kicking else __O[2491]
            __O[2492] = ____temp_54
            if ____t_56(if ____t_55(____temp_54) then i == 1 else __O[2492]) then
                local angle = math.atan2(
                    __get(l.foot, 1) - __get(l.knee, 1),
                    __get(l.foot, 0) - __get(l.knee, 0)
                ) - math.pi / 2
                heel(
                    nil,
                    c,
                    __get(l.foot, 0) + 1,
                    __get(l.foot, 1) - 3,
                    angle * 0.28,
                    0.43,
                    color
                )
            else
                rect(
                    nil,
                    c,
                    __get(l.foot, 0) - 4,
                    __get(l.foot, 1) - 2,
                    11,
                    4,
                    if id == "daroca" then "#b48b50" else if id == "almiro" then "#9ef13d" else if __t(id == "marco" or id == "dede") then "#748078" else "#e3e4ce"
                )
                rect(
                    nil,
                    c,
                    __get(l.foot, 0) - 4,
                    __get(l.foot, 1) + 1,
                    12,
                    2,
                    "#516b69"
                )
                rect(
                    nil,
                    c,
                    __get(l.foot, 0) - 2,
                    __get(l.foot, 1) - 2,
                    5,
                    1,
                    "#fff4d4"
                )
            end
        end
    end
    local sleeveColors = __ord({
        daroca = "#dc8c47",
        reeis = "#4d7374",
        nikolas = "#8c6594",
        marco = "#222b30",
        menezes = "#647c84",
        ollyan = "#252a36",
        igor = "#287eb8",
        kaique = "#edf0dd",
        freddy = "#34424a",
        dede = "#516563",
        arthur = "#6d99a0",
        nicolas = "#e7e1c9",
        caleb = "#f0c9af",
        lucas = "#9a9e9e",
        kaua = "#66888a",
        mota = "#1b4677",
        ravid = "#7c93a1",
        almiro = "#367cba",
        miqueias = "#617b70",
        davi = "#252c31",
        vitor = "#a9afb1",
        allef = "#3b5260",
        aica = "#e5e7d6",
        ravile = "#8fafbf",
        eloisa = "#f1f0df",
        giselle = "#f1f0df",
        rayssa = "#f1f0df",
        analaura = "#f1f0df"
    }, "daroca,reeis,nikolas,marco,menezes,ollyan,igor,kaique,freddy,dede,arthur,nicolas,caleb,lucas,kaua,mota,ravid,almiro,miqueias,davi,vitor,allef,aica,ravile,eloisa,giselle,rayssa,analaura")
    local longSleeves = __TS__New(
        Set,
        __arrL({
            "marco",
            "ollyan",
            "dede",
            "davi",
            "vitor"
        }, 5)
    )
    local motionBodyCache = __TS__New(Map)
    local function rigProfile(self, id)
        local h = if id == "lucas" then 60 else 70
        local s = h / bodyHeight(nil, id)
        local small = id == "lucas"
        local sx = s * if __t(small) then 0.84 else 1
        local sy = s * if __t(small) then 0.78 else 1
        local ____t_58 = __t
        local ____call_result_57 = __call(girls, "has", id)
        __O[2493] = ____call_result_57
        local social = if ____t_58(____call_result_57) then __O[2493] else __call(
            __arrL({
                "allef",
                "arthur",
                "dede",
                "davi",
                "vitor",
                "freddy",
                "nicolas"
            }, 7),
            "includes",
            id
        )
        local ____t_61 = __t
        local ____t_60 = __t
        local ____temp_59 = id == "freddy" or id == "dede"
        __O[2494] = ____temp_59
        local wide = if id == "caleb" then 20 else if id == "davi" then 19 else if id == "allef" then 20 else if __t(social) then if ____t_61(if ____t_60(____temp_59) then __O[2494] else id == "ravile") then 10 else 12 else if __t(id == "mota" or id == "marco") then 10 else 13
        local ____temp_65 = if __t(social) then -36 else if id == "caleb" then -38 else -34 * sy
        local ____temp_66 = wide * sx
        local ____temp_67 = if __t(social) then -43 else -42 * sy
        local ____temp_68 = (wide + 1) * sx
        local ____temp_69 = if __t(small) then 7.5 else 9.5
        local ____temp_70 = if __t(small) then 9 else 11.5
        local ____t_64 = __t
        local ____t_63 = __t
        local ____temp_62 = id == "freddy" or id == "mota"
        __O[2495] = ____temp_62
        local profile = {
            shoulderY = ____temp_65,
            shoulderX = ____temp_66,
            neckY = ____temp_67,
            coreHalf = ____temp_68,
            upper = ____temp_69,
            lower = ____temp_70,
            width = if id == "caleb" then 7 else if ____t_64(if ____t_63(____temp_62) then __O[2495] else id == "marco") then 4 else 5
        }
        if id == "igor" then
            profile = {
                shoulderY = -57 * s,
                shoulderX = 25 * s,
                neckY = -63 * s,
                coreHalf = 29 * s,
                upper = 11,
                lower = 12,
                width = 6
            }
        end
        if id == "kaique" then
            profile = {
                shoulderY = -72 * s,
                shoulderX = 12 * s,
                neckY = -84 * s,
                coreHalf = 12 * s,
                upper = 10,
                lower = 11,
                width = 4
            }
        end
        if id == "ollyan" then
            profile = {
                shoulderY = -52 * s,
                shoulderX = 15 * s,
                neckY = -59 * s,
                coreHalf = 14 * s,
                upper = 9,
                lower = 11,
                width = 4
            }
        end
        return profile
    end
    local function motionBody(self, id)
        if __t(__call(motionBodyCache, "has", id)) then
            return __call(motionBodyCache, "get", id)
        end
        local size = 144
        local ox = 72
        local oy = 116
        local canvas = window.document:createElement("canvas")
        canvas.height = size
        canvas.width = size
        local g = canvas:getContext("2d", {willReadFrequently = true})
        g.imageSmoothingEnabled = false
        local ____opt_73 = window.Art
        if ____opt_73 ~= nil then
            ____opt_73 = ____opt_73.drawCharacter
        end
        if ____opt_73 ~= nil then
            ____opt_73(
                ____opt_73,
                g,
                id,
                ox,
                oy,
                {
                    scale = if id == "lucas" then 60 else 70 / bodyHeight(nil, id),
                    facing = 1,
                    frame = 0,
                    grounded = true,
                    moving = false,
                    speed = 0,
                    vy = 0,
                    noseRub = false,
                    monitorBattle = true,
                    cup = false,
                    smoke = false
                }
            )
        end
        local profile = rigProfile(nil, id)
        local hip = legProfile(nil, id).hipY
        local image = g:getImageData(0, 0, size, size)
        local hair = if __t(__call(girls, "has", id)) then __TS__New(
            Set,
            __call(
                if id == "aica" then __arrL({"#4d392f", "#77573d"}, 2) else if id == "ravile" then __arrL({"#362f2b", "#65503a"}, 2) else if id == "eloisa" then __arrL({"#4d372c", "#76543b"}, 2) else if id == "analaura" then __arrL({"#51362d", "#6a4734", "#7a543c", "#7d573e"}, 4) else __arrL({
                    "#232d2b",
                    "#25302e",
                    "#3a4238",
                    "#626151",
                    "#303b32",
                    "#455044",
                    "#31392f",
                    "#63614d"
                }, 8),
                "map",
                function(____, value) return __TS__ParseInt(
                    __call(value, "slice", 1),
                    16
                ) end
            )
        ) else nil
        do
            local y = 0
            while y < size do
                do
                    local x = 0
                    while x < size do
                        local i = (y * size + x) * 4
                        if not __t(__get(image.data, i + 3)) then
                            continue
                        end
                        local xx = x - ox
                        local yy = y - oy
                        local color = __bor(
                            __bor(
                                __shl(
                                    __get(image.data, i),
                                    16
                                ),
                                __shl(
                                    __get(image.data, i + 1),
                                    8
                                )
                            ),
                            __get(image.data, i + 2)
                        )
                        local ____t_76 = __t
                        local ____callq_result_75 = __callq(hair, "has", color)
                        __O[2496] = ____callq_result_75
                        local hairPixel = if ____t_76(____callq_result_75) then yy < hip + 7 else __O[2496]
                        local ____t_82 = __t
                        local ____t_80 = __t
                        local ____t_78 = __t
                        local ____temp_77 = id == "daroca" and xx < -10
                        __O[2497] = ____temp_77
                        local ____temp_79 = if ____t_78(____temp_77) then yy > -39 else __O[2497]
                        __O[2498] = ____temp_79
                        local ____temp_81 = if ____t_80(____temp_79) then yy < -14 else __O[2498]
                        __O[2499] = ____temp_81
                        local backpack = if ____t_82(____temp_81) then __call(
                            __arrL({6250561, 9273674, 11641442}, 3),
                            "includes",
                            color
                        ) else __O[2499]
                        local half = profile.coreHalf
                        if __t(id == "igor" and yy > profile.neckY) then
                            local q = (yy + 33) / 28
                            half = math.max(
                                8,
                                profile.coreHalf * math.sqrt(math.max(0, 1 - q * q))
                            )
                        end
                        local torso = yy <= hip + if id == "igor" then 5 else 1 and math.abs(xx) <= half
                        local headHalf = if id == "ollyan" then 37 else if id == "daroca" then 25 else if __t(__call(girls, "has", id)) then 27 else if id == "nikolas" then 28 else 18
                        local head = yy < profile.neckY and math.abs(xx) <= headHalf
                        local ____t_87 = __t
                        local ____t_86 = __t
                        local ____t_84 = __t
                        local ____temp_83 = if __t(head) then head else torso
                        __O[2500] = ____temp_83
                        local ____temp_85 = if ____t_84(____temp_83) then __O[2500] else hairPixel
                        __O[2501] = ____temp_85
                        if not ____t_87(if ____t_86(____temp_85) then __O[2501] else backpack) then
                            __set(image.data, i + 3, 0)
                        end
                        x = x + 1
                    end
                end
                y = y + 1
            end
        end
        g:putImageData(image, 0, 0)
        local part = {canvas = canvas, ox = ox, oy = oy, profile = profile}
        __call(motionBodyCache, "set", id, part)
        return part
    end
    local function movementPose(self, id, p, time)
        local motion = inferMotion(nil, p)
        local ____t_89 = __t
        local ____TS__Number_result_88 = __TS__Number(p.motionTime)
        __O[2502] = ____TS__Number_result_88
        local mt = math.max(0, if ____t_89(____TS__Number_result_88) then __O[2502] else 0)
        local ____t_91 = __t
        local ____TS__Number_result_90 = __TS__Number(p.vy)
        __O[2503] = ____TS__Number_result_90
        local vy = if ____t_91(____TS__Number_result_90) then __O[2503] else 0
        local ____time_94 = time
        local ____t_93 = __t
        local ____get_result_92 = __get(gait, id)
        __O[2504] = ____get_result_92
        local phase = ____time_94 * if ____t_93(____get_result_92) then __O[2504] else 10.7
        local ____t_98 = __t
        local ____t_96 = __t
        local ____TS__Number_result_95 = __TS__Number(p.wallSide)
        __O[2505] = ____TS__Number_result_95
        local ____temp_97 = if ____t_96(____TS__Number_result_95) then __O[2505] else __TS__Number(p.facing)
        __O[2506] = ____temp_97
        local wall = if ____t_98(____temp_97) then __O[2506] else 1 * if __lt(p.facing, 0) then -1 else 1
        local ____t_100 = __t
        local ____temp_99 = id == "igor" or id == "davi"
        __O[2507] = ____temp_99
        local heavy = if ____t_100(____temp_99) then __O[2507] else id == "allef"
        local quick = id == "lucas" or id == "menezes"
        local land = if motion == "land" then 1 - smooth(nil, 0.01, 0.13, mt) else 0
        local lean = 0
        local dx = 0
        local dy = 0
        local armLift = 0
        if motion == "run" then
            lean = if __t(heavy) then 0.055 else if __t(quick) then 0.17 else 0.12
            dy = -math.abs(math.sin(phase)) * 2.7
        elseif motion == "jump" then
            local launch = if p.jumps == 2 then 0 else 1 - smooth(nil, 0.025, 0.15, mt)
            lean = -0.07 + launch * 0.08
            dy = launch * 1.8
            armLift = clamp(
                nil,
                (__TS__Number(-vy) - 80) / 340,
                0,
                1
            )
        elseif motion == "doubleJump" then
            local tuck = math.sin(clamp(nil, mt / 0.24, 0, 1) * math.pi)
            lean = -0.12 + tuck * 0.21
            dy = -tuck * 2
            armLift = 1
        elseif motion == "fall" then
            lean = 0.055
            armLift = clamp(nil, (vy - 70) / 430, 0, 1)
        elseif motion == "dash" then
            local drive = smooth(nil, 0, 0.035, mt) * (1 - smooth(nil, 0.12, 0.19, mt))
            lean = if __t(heavy) then 0.22 else 0.39 * drive
            dx = drive * 5
            dy = -1.5
        elseif motion == "wallSlide" then
            lean = -wall * 0.1
            dx = -wall * 2
        elseif motion == "wallJump" then
            local push = 1 - smooth(nil, 0.02, 0.22, mt)
            lean = -0.22 * push
            dx = -push * 2
            armLift = push
        elseif motion == "land" then
            dy = land * if __t(heavy) then 5 else 6
            lean = -0.07 * land
        end
        return {
            motion = motion,
            mt = mt,
            vy = vy,
            phase = phase,
            wall = wall,
            heavy = heavy,
            quick = quick,
            land = land,
            lean = lean,
            dx = dx,
            dy = dy,
            armLift = armLift
        }
    end
    local function movementArms(self, id, p, time, pose)
        if pose == nil then
            pose = movementPose(nil, id, p, time)
        end
        local pr = rigProfile(nil, id)
        local m = pose.motion
        local phase = pose.phase
        local mt = pose.mt
        local sy = pr.shoulderY
        local spread = pr.shoulderX
        local L = pr.upper + pr.lower
        local arms = __arrL({}, 0)
        for ____, side in __iterar((__arrL({-1, 1}, 2))) do
            local shoulder = __arrL({side * spread, sy}, 2)
            local target = __arrL({side * (spread + 3), sy + L * 0.91}, 2)
            local bend = side
            if m == "run" then
                local swing = math.sin(phase + if side < 0 then math.pi else 0)
                target = __arrL(
                    {
                        side * spread + swing * L * 0.86,
                        sy + L * (0.24 + 0.28 * (1 - math.abs(swing)))
                    },
                    2
                )
                bend = if side < 0 then -1 else 1
            elseif m == "jump" then
                local launch = if p.jumps == 2 then 0 else 1 - smooth(nil, 0.02, 0.16, mt)
                local rise = clamp(
                    nil,
                    (__TS__Number(-pose.vy) - 50) / 360,
                    0,
                    1
                )
                target = if side > 0 then __arrL({spread + L * 0.43, sy + L * (0.72 - launch * 1.13 - rise * 0.16)}, 2) else __arrL({-spread - L * 0.38, sy + L * (0.7 - launch * 0.62)}, 2)
            elseif m == "doubleJump" then
                local open = smooth(nil, 0.04, 0.2, mt)
                target = __arrL({side * (spread + L * (0.34 + open * 0.42)), sy - L * (0.75 - open * 0.62)}, 2)
            elseif m == "fall" then
                target = __arrL({side * (spread + L * (0.62 + pose.armLift * 0.12)), sy + L * (0.37 - pose.armLift * 0.44)}, 2)
            elseif m == "dash" then
                target = if side < 0 then __arrL({-spread - L * 0.9, sy + L * 0.16}, 2) else __arrL({spread - L * 0.24, sy - L * 0.46}, 2)
                bend = if side < 0 then 1 else -1
            elseif m == "wallSlide" then
                target = __arrL({pose.wall * (spread + L * 0.48), sy - L * if side < 0 then 0.46 else 0.03}, 2)
                bend = pose.wall
            elseif m == "wallJump" then
                local release = 1 - smooth(nil, 0.02, 0.2, mt)
                target = if side < 0 then __arrL({-spread - L * 0.52, sy - L * 0.42 * release}, 2) else __arrL({spread + L * 0.54, sy + L * (0.22 - 0.64 * release)}, 2)
            elseif m == "land" then
                target = __arrL({side * (spread + L * (0.15 + pose.land * 0.55)), sy + L * (0.88 - pose.land * 0.4)}, 2)
            end
            if __t(id == "mota" and m == "run") then
                __set(
                    target,
                    1,
                    __get(target, 1) - 4
                )
            end
            if __t(id == "menezes" and m == "run") then
                __set(
                    target,
                    1,
                    __get(target, 1) - 3
                )
            end
            if __t(id == "arthur" and m == "run") then
                __set(
                    target,
                    1,
                    __get(target, 1) + side * 2
                )
            end
            __call(
                arms,
                "push",
                __assign(
                    {},
                    {side = side},
                    solveLeg(
                        nil,
                        shoulder,
                        target,
                        pr.upper,
                        pr.lower,
                        bend
                    )
                )
            )
        end
        return {arms = arms, upper = pr.upper, lower = pr.lower, width = pr.width}
    end
    local function drawMovementArm(self, c, id, arm, width, back)
        if back == nil then
            back = false
        end
        local ____t_102 = __t
        local ____get_result_101 = __get(sleeveColors, id)
        __O[2508] = ____get_result_101
        local shirt = if ____t_102(____get_result_101) then __O[2508] else "#d9a763"
        local ____t_104 = __t
        local ____get_result_103 = __get(skin, id)
        __O[2509] = ____get_result_103
        local flesh = if ____t_104(____get_result_103) then __O[2509] else "#d5a478"
        local long = __call(longSleeves, "has", id)
        local outline = width + 3
        c:save()
        if __t(back) then
            c.globalAlpha = c.globalAlpha * 0.93
        end
        line(
            nil,
            c,
            __arrL({arm.hip, arm.knee, arm.foot}, 3),
            INK,
            outline
        )
        line(
            nil,
            c,
            __arrL({arm.hip, arm.knee}, 2),
            shirt,
            width
        )
        line(
            nil,
            c,
            __arrL({arm.knee, arm.foot}, 2),
            if __t(long) then shirt else flesh,
            width
        )
        rect(
            nil,
            c,
            __get(arm.foot, 0) - 2,
            __get(arm.foot, 1) - 2,
            width + 1,
            width + 1,
            flesh
        )
        local ____t_107 = __t
        local ____t_106 = __t
        local ____call_result_105 = __call(girls, "has", id)
        __O[2510] = ____call_result_105
        if ____t_107(if ____t_106(____call_result_105) then __lt(arm.side, 0) else __O[2510]) then
            line(
                nil,
                c,
                __arrL(
                    {
                        arm.hip,
                        __arrL(
                            {
                                __add(
                                    __get(arm.hip, 0),
                                    __get(arm.knee, 0)
                                ) * 0.5,
                                __add(
                                    __get(arm.hip, 1),
                                    __get(arm.knee, 1)
                                ) * 0.5
                            },
                            2
                        )
                    },
                    2
                ),
                "#244d74",
                math.max(2, width - 1)
            )
        end
        c:restore()
    end
    local function movementProp(self, c, id, arm, time)
        local x = __get(arm.foot, 0)
        local y = __get(arm.foot, 1)
        if __t(id == "reeis" or id == "kaique") then
            rect(
                nil,
                c,
                x - 5,
                y - 3,
                21,
                6,
                "#263d45"
            )
            rect(
                nil,
                c,
                x - 2,
                y + 2,
                5,
                8,
                "#263d45"
            )
            rect(
                nil,
                c,
                x - 3,
                y - 2,
                15,
                2,
                "#8ca6a4"
            )
        elseif id == "marco" then
            rect(
                nil,
                c,
                x - 7,
                y - 3,
                13,
                17,
                "#3a4040"
            )
            rect(
                nil,
                c,
                x - 5,
                y - 2,
                9,
                14,
                "#ded2a5"
            )
            line(
                nil,
                c,
                __arrL(
                    {
                        __arrL({x - 3, y + 2}, 2),
                        __arrL({x + 2, y + 3}, 2),
                        __arrL({x - 1, y + 6}, 2),
                        __arrL({x + 2, y + 9}, 2)
                    },
                    4
                ),
                "#755583",
                1
            )
        elseif id == "caleb" then
            weight(
                nil,
                c,
                x,
                y,
                math.sin(time * 8) * 0.13,
                0.43,
                "#9eb9c2"
            )
        elseif id == "kaua" then
            rect(
                nil,
                c,
                x - 1,
                y - 5,
                3,
                14,
                "#e9b452"
            )
            rect(
                nil,
                c,
                x - 1,
                y - 5,
                3,
                3,
                "#f5deb3"
            )
        end
    end
    local function drawMovementRig(self, c, id, p, time)
        local pose = movementPose(nil, id, p, time)
        local part = motionBody(nil, id)
        local legs = legPose(
            nil,
            id,
            pose.motion,
            time,
            "side",
            0,
            false,
            __assign({}, p, pose)
        )
        local arms = movementArms(
            nil,
            id,
            p,
            time,
            pose
        )
        local hip = legProfile(nil, id).hipY
        c:save()
        c:translate(pose.dx, pose.dy)
        c:translate(0, hip)
        c:rotate(pose.lean)
        c:translate(0, -hip)
        drawMovementArm(
            nil,
            c,
            id,
            __get(arms.arms, 0),
            arms.width,
            true
        )
        c:drawImage(
            part.canvas,
            __TS__Number(-part.ox),
            __TS__Number(-part.oy)
        )
        drawMovementArm(
            nil,
            c,
            id,
            __get(arms.arms, 1),
            arms.width
        )
        movementProp(
            nil,
            c,
            id,
            __get(arms.arms, if id == "marco" then 0 else 1),
            time
        )
        c:restore()
        drawLegs(
            nil,
            c,
            id,
            legs,
            false,
            kit(nil, id).color
        )
    end
    local attackVisualCache = __TS__New(Map)
    local function attackVisual(self, id, kind, dir)
        local key = __add(
            __add(
                __add(
                    __add(id, ":"),
                    kind
                ),
                ":"
            ),
            dir
        )
        if __t(__call(attackVisualCache, "has", key)) then
            return __call(attackVisualCache, "get", key)
        end
        local ____t_113 = __t
        local ____opt_110 = window.ArenaCombat
        if ____opt_110 ~= nil then
            ____opt_110 = ____opt_110.attack
        end
        local ____opt_result_112
        if ____opt_110 ~= nil then
            ____opt_result_112 = ____opt_110(
                ____opt_110,
                id,
                kind,
                dir,
                {facing = 1}
            )
        end
        __O[2511] = ____opt_result_112
        local d = if ____t_113(____opt_result_112) then __O[2511] else {windup = 0.1, duration = 0.13, recovery = 0.2}
        __call(attackVisualCache, "set", key, d)
        return d
    end
    local function attackPose(self, id, p)
        local kind = if __t(p.attackType) then p.attackType else "physical"
        local dir = if __t(p.attackDirection) then p.attackDirection else "side"
        local d = attackVisual(nil, id, kind, dir)
        local ____t_115 = __t
        local ____TS__Number_result_114 = __TS__Number(p.attackTotal)
        __O[2512] = ____TS__Number_result_114
        local total = math.max(0.35, if ____t_115(____TS__Number_result_114) then __O[2512] else __add(
            __add(d.windup, d.duration),
            d.recovery
        ))
        local ____t_117 = __t
        local ____TS__Number_result_116 = __TS__Number(p.attackProgress)
        __O[2513] = ____TS__Number_result_116
        local progress = clamp(nil, if ____t_117(____TS__Number_result_116) then __O[2513] else 0, 0, 1)
        local at = progress * total
        local ____t_120 = __t
        local ____opt_118 = d.finisher
        if ____opt_118 ~= nil then
            ____opt_118 = ____opt_118.hits
        end
        __O[2514] = ____opt_118
        local beats = if kind == "combo" then if ____t_120(____opt_118) then __O[2514] else __arrL({{delay = 0}}, 1) else __arrL({{delay = 0}}, 1)
        local beat = __get(beats, 0)
        local distance = math.huge
        for ____, h in __iterar((beats)) do
            local diff = at - __add(d.windup, if __t(h.delay) then h.delay else 0)
            if math.abs(diff) < distance then
                beat = h
                distance = math.abs(diff)
            end
        end
        local contact = __add(d.windup, if __t(beat.delay) then beat.delay else 0)
        local relative = at - contact
        local wind = if relative < 0 then smooth(nil, -0.14, -0.025, relative) else 0
        local drive = smooth(nil, -0.035, 0.025, relative) * (1 - smooth(nil, 0.09, 0.23, relative))
        local recover = smooth(nil, 0.035, 0.23, relative)
        local power = if kind == "combo" then 1.15 else if kind == "ranged" then 0.75 else 1
        local heavy = __call(
            __arrL({"igor", "caleb", "davi", "allef"}, 4),
            "includes",
            id
        )
        local ____t_126 = __t
        local ____t_124 = __t
        local ____t_122 = __t
        local ____call_result_121 = __call(girls, "has", id)
        __O[2515] = ____call_result_121
        local ____temp_123 = if ____t_122(____call_result_121) then __O[2515] else id == "freddy"
        __O[2516] = ____temp_123
        local ____temp_125 = if ____t_124(____temp_123) then __O[2516] else id == "mota"
        __O[2517] = ____temp_125
        local kick = if ____t_126(____temp_125) then kind ~= "ranged" else __O[2517]
        local angle = if dir == "up" then -1.15 else if dir == "down" then 1.05 else 0
        local ____kind_129 = kind
        local ____dir_130 = dir
        local ____d_131 = d
        local ____total_132 = total
        local ____at_133 = at
        local ____progress_134 = progress
        local ____relative_135 = relative
        local ____wind_136 = wind
        local ____drive_137 = drive
        local ____recover_138 = recover
        local ____power_139 = power
        local ____heavy_140 = heavy
        local ____kick_141 = kick
        local ____angle_142 = angle
        local ____smooth_result_143 = smooth(nil, total - 0.2, total, at)
        local ____smooth_result_144 = smooth(nil, 0, 0.065, at)
        local ____temp_145 = if __t(beat.shape) then beat.shape else d.shape
        local ____temp_146 = (drive * if __t(heavy) then 2.6 else 4.5 - wind * 2.5) * power
        local ____temp_147 = if dir == "down" then drive * 2.6 else if dir == "up" then -drive * 2 else wind * 1.3
        local ____temp_148 = if dir == "up" then -0.1 else if dir == "down" then 0.14 else 0.12 * drive * power - 0.075 * wind
        local ____t_128 = __t
        local ____temp_127 = kind == "ranged" and relative >= 0
        __O[2518] = ____temp_127
        return {
            kind = ____kind_129,
            dir = ____dir_130,
            d = ____d_131,
            total = ____total_132,
            at = ____at_133,
            progress = ____progress_134,
            relative = ____relative_135,
            wind = ____wind_136,
            drive = ____drive_137,
            recover = ____recover_138,
            power = ____power_139,
            heavy = ____heavy_140,
            kick = ____kick_141,
            angle = ____angle_142,
            settle = ____smooth_result_143,
            guard = ____smooth_result_144,
            shape = ____temp_145,
            dx = ____temp_146,
            dy = ____temp_147,
            lean = ____temp_148,
            release = if ____t_128(____temp_127) then relative < 0.065 else __O[2518]
        }
    end
    local function attackArms(self, id, p, pose)
        if pose == nil then
            pose = attackPose(nil, id, p)
        end
        local pr = rigProfile(nil, id)
        local sx = pr.shoulderX
        local sy = pr.shoulderY
        local L = pr.upper + pr.lower
        local arms = __arrL({}, 0)
        for ____, side in __iterar((__arrL({-1, 1}, 2))) do
            local shoulder = __arrL({side * sx, sy}, 2)
            local target
            local bend = side
            if side < 0 then
                target = __arrL({-sx - L * (0.2 + pose.wind * 0.25), sy + L * (0.38 - pose.drive * 0.26)}, 2)
                local ____t_151 = __t
                local ____t_150 = __t
                local ____temp_149 = pose.kind == "ranged"
                __O[2519] = ____temp_149
                if ____t_151(if ____t_150(____temp_149) then __call(
                    __arrL({"reeis", "kaique"}, 2),
                    "includes",
                    id
                ) else __O[2519]) then
                    target = __arrL({sx * 0.16, sy + L * 0.22}, 2)
                end
            elseif __t(pose.kick) then
                target = __arrL({sx + L * (0.28 - pose.drive * 0.51), sy + L * (0.54 - pose.drive * 0.68)}, 2)
                bend = -1
            else
                local reach = L * (0.66 + 0.32 * pose.drive)
                local start = __arrL({sx + L * 0.12 - pose.wind * L * 0.54, sy + L * 0.71 - pose.wind * L * 0.76}, 2)
                local ____end = __arrL(
                    {
                        sx + math.cos(pose.angle) * reach,
                        sy + math.sin(pose.angle) * reach + L * 0.05
                    },
                    2
                )
                target = __arrL(
                    {
                        __get(start, 0) + (__get(____end, 0) - __get(start, 0)) * pose.drive,
                        __get(start, 1) + (__get(____end, 1) - __get(start, 1)) * pose.drive
                    },
                    2
                )
                bend = -1
                local ____t_154 = __t
                local ____t_153 = __t
                local ____temp_152 = pose.kind == "ranged"
                __O[2520] = ____temp_152
                if ____t_154(if ____t_153(____temp_152) then __call(
                    __arrL({"reeis", "kaique"}, 2),
                    "includes",
                    id
                ) else __O[2520]) then
                    target = __arrL({sx + L * (0.85 - pose.drive * 0.22), sy + L * 0.12}, 2)
                end
                local ____t_157 = __t
                local ____t_156 = __t
                local ____temp_155 = id == "nikolas" and pose.kind == "ranged"
                __O[2521] = ____temp_155
                if ____t_157(if ____t_156(____temp_155) then pose.wind > 0 else __O[2521]) then
                    target = __arrL(
                        {
                            __get(target, 0) + (21 - __get(target, 0)) * pose.wind,
                            __get(target, 1) + (-50 - __get(target, 1)) * pose.wind
                        },
                        2
                    )
                end
                if __t(id == "daroca" and pose.kind ~= "ranged") then
                    target = __arrL({sx + L * (0.15 + pose.drive * 0.43) - pose.wind * 6, sy + L * (0.32 - pose.drive * 0.2)}, 2)
                end
                if __t(id == "menezes" and pose.kind ~= "ranged") then
                    __set(
                        target,
                        1,
                        __get(target, 1) - pose.wind * 4
                    )
                end
                if __t(id == "lucas" and pose.kind == "physical") then
                    __set(
                        target,
                        1,
                        __get(target, 1) + 8 * pose.drive
                    )
                end
            end
            local blend = pose.guard * (1 - pose.settle)
            local rest = __arrL({side * (sx + 3), sy + L * 0.91}, 2)
            target = __arrL(
                {
                    __get(rest, 0) + (__get(target, 0) - __get(rest, 0)) * blend,
                    __get(rest, 1) + (__get(target, 1) - __get(rest, 1)) * blend
                },
                2
            )
            __call(
                arms,
                "push",
                __assign(
                    {},
                    {side = side},
                    solveLeg(
                        nil,
                        shoulder,
                        target,
                        pr.upper,
                        pr.lower,
                        bend
                    )
                )
            )
        end
        return {arms = arms, upper = pr.upper, lower = pr.lower, width = pr.width}
    end
    local function firearm(self, c, x, y, angle, flash)
        if angle == nil then
            angle = 0
        end
        if flash == nil then
            flash = false
        end
        c:save()
        c:translate(x, y)
        c:rotate(angle)
        rect(
            nil,
            c,
            -6,
            -6,
            28,
            10,
            INK
        )
        rect(
            nil,
            c,
            -4,
            -4,
            23,
            4,
            "#8fa9ad"
        )
        rect(
            nil,
            c,
            0,
            3,
            6,
            11,
            INK
        )
        rect(
            nil,
            c,
            19,
            -4,
            10,
            5,
            "#c1d4cb"
        )
        rect(
            nil,
            c,
            -3,
            -5,
            17,
            2,
            "#d4e2d5"
        )
        if __t(flash) then
            poly(
                nil,
                c,
                __arrL(
                    {
                        __arrL({29, -3}, 2),
                        __arrL({33, -8}, 2),
                        __arrL({35, -4}, 2),
                        __arrL({44, -4}, 2),
                        __arrL({40, 0}, 2),
                        __arrL({43, 4}, 2),
                        __arrL({34, 3}, 2),
                        __arrL({31, 7}, 2)
                    },
                    8
                ),
                "#ffe36c"
            )
            rect(
                nil,
                c,
                30,
                -2,
                8,
                4,
                "#fff9d5"
            )
        end
        c:restore()
    end
    local function heldProp(self, c, id, hand, pose, time)
        local x = __get(hand.foot, 0)
        local y = __get(hand.foot, 1)
        local a = pose.angle
        local color = kit(nil, id).color
        local ranged = pose.kind == "ranged"
        local hold = not __t(ranged) or __lt(pose.relative, 0.015)
        local turn = __TS__Number(-pose.wind) * 0.9 + pose.drive * 0.65
        if __t(__call(
            __arrL({"reeis", "kaique"}, 2),
            "includes",
            id
        )) then
            firearm(
                nil,
                c,
                x,
                y,
                a + if __t(ranged) then __TS__Number(-pose.drive) * 0.16 else turn * 0.45,
                if __t(ranged) then pose.release else ranged
            )
            return
        end
        if id == "caleb" then
            if __t(hold) then
                weight(
                    nil,
                    c,
                    x + 4,
                    y,
                    a + turn,
                    0.57,
                    color
                )
            end
            return
        end
        local ____t_160 = __t
        local ____t_159 = __t
        local ____temp_158 = id == "marco" or id == "kaua"
        __O[2522] = ____temp_158
        if ____t_160(if ____t_159(____temp_158) then __O[2522] else id == "miqueias") then
            c:save()
            c:translate(x, y)
            c:rotate(a - 0.65 + turn)
            rect(
                nil,
                c,
                -3,
                -23,
                6,
                33,
                INK
            )
            rect(
                nil,
                c,
                -2,
                -21,
                4,
                29,
                if id == "marco" then "#e8bd70" else if id == "kaua" then "#efc85d" else "#d2dcbd"
            )
            do
                local i = 0
                while i < 4 do
                    rect(
                        nil,
                        c,
                        -2,
                        -17 + i * 6,
                        2,
                        1,
                        "#916b42"
                    )
                    i = i + 1
                end
            end
            poly(
                nil,
                c,
                __arrL(
                    {
                        __arrL({-3, 10}, 2),
                        __arrL({3, 10}, 2),
                        __arrL({0, 17}, 2)
                    },
                    3
                ),
                "#f5db9a"
            )
            rect(
                nil,
                c,
                -1,
                14,
                2,
                4,
                INK
            )
            c:restore()
            local ____t_165 = __t
            local ____t_164 = __t
            local ____t_162 = __t
            local ____temp_161 = id == "marco"
            __O[2523] = ____temp_161
            local ____temp_163 = if ____t_162(____temp_161) then ranged else __O[2523]
            __O[2524] = ____temp_163
            if ____t_165(if ____t_164(____temp_163) then __gt(pose.wind, 0.1) else __O[2524]) then
                line(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x + 8, y - 6}, 2),
                            __arrL({x + 16, y - 12}, 2),
                            __arrL({x + 23, y - 4}, 2),
                            __arrL({x + 16, y + 1}, 2),
                            __arrL({x + 8, y - 6}, 2)
                        },
                        5
                    ),
                    "#c69ad6",
                    2
                )
                rect(
                    nil,
                    c,
                    x + 12,
                    y - 8,
                    2,
                    3,
                    "#f6ebc9"
                )
            end
            return
        end
        if id == "davi" then
            if __t(hold) then
                c:save()
                c:translate(x, y)
                c:rotate(a + turn * 0.3)
                rect(
                    nil,
                    c,
                    -6,
                    -13,
                    12,
                    23,
                    INK
                )
                rect(
                    nil,
                    c,
                    -4,
                    -10,
                    8,
                    17,
                    "#a1bec5"
                )
                do
                    local i = 0
                    while i < 4 do
                        rect(
                            nil,
                            c,
                            -6 + i * 4,
                            -17,
                            2,
                            6,
                            "#e2e8d2"
                        )
                        i = i + 1
                    end
                end
                rect(
                    nil,
                    c,
                    -2,
                    -7,
                    3,
                    7,
                    "#e9dbb6"
                )
                c:restore()
            end
            return
        end
        if id == "vitor" then
            if __t(hold) then
                c:save()
                c:translate(x, y)
                c:rotate(a + turn * 0.6)
                rect(
                    nil,
                    c,
                    -12,
                    -5,
                    30,
                    11,
                    "#e5ecdc"
                )
                rect(
                    nil,
                    c,
                    -10,
                    -4,
                    25,
                    3,
                    "#9ebeb1"
                )
                do
                    local i = 0
                    while i < 4 do
                        rect(
                            nil,
                            c,
                            18,
                            -4 + i * 3,
                            4,
                            1,
                            "#a7c7bd"
                        )
                        i = i + 1
                    end
                end
                c:restore()
            end
            return
        end
        if __t(__call(girls, "has", id)) then
            if __t(if __t(ranged) then hold else ranged) then
                heel(
                    nil,
                    c,
                    x + 3,
                    y,
                    a - 0.3,
                    0.42,
                    color
                )
            end
            return
        end
        if id == "mota" then
            if __t(hold) then
                ball(
                    nil,
                    c,
                    if __t(ranged) then x + 2 else 15,
                    if __t(ranged) then y else -9,
                    time * 3 + pose.drive * 2,
                    0.63
                )
            end
            return
        end
        if id == "menezes" then
            if __t(not __t(ranged) and __gt(pose.drive, 0.12)) then
                c:save()
                c:translate(x + 2, y)
                c:rotate(a - 0.5 + pose.drive)
                do
                    local i = 0
                    while i < 3 do
                        line(
                            nil,
                            c,
                            __arrL(
                                {
                                    __arrL({i * 4 - 3, 4}, 2),
                                    __arrL({i * 4 + 1, -5}, 2),
                                    __arrL({i * 4 + 2, -8}, 2)
                                },
                                3
                            ),
                            "#e5e8cf",
                            2
                        )
                        i = i + 1
                    end
                end
                c:restore()
            end
            return
        end
        local ____t_168 = __t
        local ____t_167 = __t
        local ____temp_166 = not __t(ranged)
        __O[2525] = ____temp_166
        if ____t_168(if ____t_167(____temp_166) then __call(
            __arrL({"arthur", "almiro", "allef"}, 3),
            "includes",
            id
        ) else __O[2525]) then
            c:save()
            c:translate(x, y)
            c:rotate(a + turn * 0.2)
            rect(
                nil,
                c,
                -3,
                -5,
                8,
                10,
                __get(skin, id)
            )
            do
                local i = 0
                while i < 4 do
                    rect(
                        nil,
                        c,
                        i * 3 - 3,
                        -11 - __mod(i, 2) * 2,
                        2,
                        10,
                        __get(skin, id)
                    )
                    i = i + 1
                end
            end
            rect(
                nil,
                c,
                -6,
                -1,
                4,
                3,
                __get(skin, id)
            )
            if id == "allef" then
                rect(
                    nil,
                    c,
                    3,
                    -6,
                    10,
                    14,
                    "#f4e6b8"
                )
                do
                    local i = 0
                    while i < 3 do
                        rect(
                            nil,
                            c,
                            5,
                            -3 + i * 4,
                            6,
                            1,
                            "#99784b"
                        )
                        i = i + 1
                    end
                end
            end
            c:restore()
            return
        end
        if __t(id == "ravid" and not __t(ranged)) then
            line(
                nil,
                c,
                __arrL(
                    {
                        __arrL({x, y}, 2),
                        __arrL({x + 8, y - 3}, 2)
                    },
                    2
                ),
                __get(skin, id),
                3
            )
            rect(
                nil,
                c,
                x + 6,
                y - 5,
                5,
                3,
                __get(skin, id)
            )
            return
        end
        local ____t_171 = __t
        local ____t_170 = __t
        local ____temp_169 = id == "ollyan" and not __t(ranged)
        __O[2526] = ____temp_169
        if ____t_171(if ____t_170(____temp_169) then __gt(pose.drive, 0.4) else __O[2526]) then
            do
                local i = 0
                while i < 2 do
                    poly(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({x - 16 - i * 6, y - 6 + i * 8}, 2),
                                __arrL({x - 4 - i * 6, y - 11 + i * 8}, 2),
                                __arrL({x + 7, y - 4 + i * 8}, 2),
                                __arrL({x - 4, y - 3 + i * 8}, 2)
                            },
                            4
                        ),
                        if __t(i) then "#84c9eb" else "#e8f6ee"
                    )
                    i = i + 1
                end
            end
            return
        end
        local ____t_174 = __t
        local ____t_173 = __t
        local ____temp_172 = id == "dede" and not __t(ranged)
        __O[2527] = ____temp_172
        if ____t_174(if ____t_173(____temp_172) then __gt(pose.drive, 0.5) else __O[2527]) then
            puff(
                nil,
                c,
                x + 3,
                y,
                6,
                "#9cb1be",
                "#dce9e6"
            )
            return
        end
        if id == "lucas" then
            if __t(if __t(ranged) then __gt(pose.wind, 0.1) else ranged) then
                rect(
                    nil,
                    c,
                    11,
                    -40,
                    8,
                    3,
                    "#e49aa4"
                )
            end
            return
        end
        if __t(if __t(ranged) then hold else ranged) then
            if id == "daroca" then
                poly(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x - 5, y - 5}, 2),
                            __arrL({x + 4, y - 6}, 2),
                            __arrL({x + 7, y}, 2),
                            __arrL({x + 2, y + 6}, 2),
                            __arrL({x - 6, y + 3}, 2)
                        },
                        5
                    ),
                    "#f7eed0"
                )
                line(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x - 3, y - 2}, 2),
                            __arrL({x + 2, y}, 2),
                            __arrL({x - 1, y + 3}, 2)
                        },
                        3
                    ),
                    "#a9b6a1",
                    1
                )
            elseif id == "nikolas" then
                pixelOval(
                    nil,
                    c,
                    x,
                    y,
                    7,
                    5,
                    "#9cbb5e"
                )
                rect(
                    nil,
                    c,
                    x - 3,
                    y - 3,
                    4,
                    2,
                    "#def1a9"
                )
            elseif id == "freddy" then
                poly(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x - 6, y - 3}, 2),
                            __arrL({x, y - 7}, 2),
                            __arrL({x + 7, y - 2}, 2),
                            __arrL({x + 5, y + 5}, 2),
                            __arrL({x - 4, y + 4}, 2)
                        },
                        5
                    ),
                    "#8c9e8e"
                )
                rect(
                    nil,
                    c,
                    x - 3,
                    y - 4,
                    5,
                    2,
                    "#c4cfb5"
                )
            elseif __t(__call(
                __arrL({"ravid", "almiro", "allef"}, 3),
                "includes",
                id
            )) then
                rect(
                    nil,
                    c,
                    x - 5,
                    y - 6,
                    11,
                    14,
                    "#f3eac8"
                )
                rect(
                    nil,
                    c,
                    x - 3,
                    y - 3,
                    7,
                    1,
                    "#7c8a72"
                )
                rect(
                    nil,
                    c,
                    x - 3,
                    y,
                    5,
                    1,
                    "#7c8a72"
                )
            elseif id == "dede" then
                puff(
                    nil,
                    c,
                    x,
                    y,
                    7,
                    "#a2b6bf",
                    "#e1e8de"
                )
            elseif id == "nicolas" then
                poly(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x, y - 8}, 2),
                            __arrL({x + 3, y - 2}, 2),
                            __arrL({x + 8, y}, 2),
                            __arrL({x + 3, y + 2}, 2),
                            __arrL({x, y + 8}, 2),
                            __arrL({x - 3, y + 2}, 2),
                            __arrL({x - 8, y}, 2),
                            __arrL({x - 3, y - 2}, 2)
                        },
                        8
                    ),
                    "#f8dc87"
                )
            end
        end
    end
    local function drawAttackRig(self, c, id, p, time)
        local pose = attackPose(nil, id, p)
        local part = motionBody(nil, id)
        local arms = attackArms(nil, id, p, pose)
        local kickProgress = if __t(pose.kick) then clamp(nil, 0.08 + pose.drive * 0.47, 0, 0.55) else 0
        local legs = legPose(
            nil,
            id,
            if p.ground == false then inferMotion(nil, p) else "idle",
            time,
            pose.dir,
            kickProgress,
            pose.kind == "combo",
            __assign({}, p, {dx = pose.dx, dy = pose.dy})
        )
        local hip = legProfile(nil, id).hipY
        c:save()
        c:translate(pose.dx, pose.dy)
        c:translate(0, hip)
        c:rotate(pose.lean)
        c:translate(0, -hip)
        drawMovementArm(
            nil,
            c,
            id,
            __get(arms.arms, 0),
            arms.width,
            true
        )
        if __t(id == "igor" and pose.kind == "combo") then
            local squeeze = pose.drive * 0.065
            c:save()
            c:translate(0, -13)
            c:scale(1 + squeeze, 1 - squeeze * 0.75)
            c:translate(0, 13)
            c:drawImage(
                part.canvas,
                __TS__Number(-part.ox),
                __TS__Number(-part.oy)
            )
            c:restore()
        else
            c:drawImage(
                part.canvas,
                __TS__Number(-part.ox),
                __TS__Number(-part.oy)
            )
        end
        drawMovementArm(
            nil,
            c,
            id,
            __get(arms.arms, 1),
            arms.width
        )
        heldProp(
            nil,
            c,
            id,
            __get(arms.arms, 1),
            pose,
            time
        )
        c:restore()
        drawLegs(
            nil,
            c,
            id,
            legs,
            pose.kick,
            kit(nil, id).color
        )
        local ____t_177 = __t
        local ____t_176 = __t
        local ____temp_175 = pose.kind ~= "ranged" and pose.drive > 0.6
        __O[2528] = ____temp_175
        if ____t_177(if ____t_176(____temp_175) then pose.relative < 0.095 else __O[2528]) then
            local foot = if __t(pose.kick) then __get(legs.legs, 1).foot else __get(arms.arms, 1).foot
            local x = __get(foot, 0) + if __t(pose.kick) then 0 else pose.dx
            local y = __get(foot, 1) + if __t(pose.kick) then 0 else pose.dy
            local a = if __t(pose.kick) then if pose.dir == "up" then -1.4 else if pose.dir == "down" then 0.7 else 0 else pose.angle
            c:save()
            c:translate(x, y)
            c:rotate(a)
            poly(
                nil,
                c,
                __arrL(
                    {
                        __arrL({-19, -4}, 2),
                        __arrL({-11, -6}, 2),
                        __arrL({-5, -4}, 2),
                        __arrL({3, -2}, 2),
                        __arrL({2, 2}, 2),
                        __arrL({-8, 3}, 2),
                        __arrL({-17, 1}, 2)
                    },
                    7
                ),
                "#f6e5bc"
            )
            rect(
                nil,
                c,
                -25,
                -1,
                5,
                2,
                kit(nil, id).color
            )
            c:restore()
        end
    end
    local function drawFighter(self, c, p, time)
        if time == nil then
            time = 0
        end
        local ____t_180 = __t
        local ____t_179 = __t
        local ____temp_178 = not __t(p) or p.stocks == 0
        __O[2529] = ____temp_178
        if ____t_180(if ____t_179(____temp_178) then __O[2529] else p.eliminated) then
            return
        end
        local id = if __t(p.character) then p.character else "daroca"
        local k = kit(nil, id)
        local face = if __lt(p.facing, 0) then -1 else 1
        local ____t_182 = __t
        local ____TS__Number_result_181 = __TS__Number(time)
        __O[2530] = ____TS__Number_result_181
        local t = if ____t_182(____TS__Number_result_181) then __O[2530] else 0
        local height = if id == "lucas" then 60 else 70
        local scale = height / bodyHeight(nil, id)
        local emoting = __gt(p.emote, 0)
        local ____t_184 = __t
        local ____gt_result_183 = __gt(p.attackAnim, 0)
        __O[2531] = ____gt_result_183
        local attack = if ____t_184(____gt_result_183) then __O[2531] else __gt(p.attackProgress, 0) and __lt(p.attackProgress, 1)
        local ____p_attackProgress_185 = p.attackProgress
        if ____p_attackProgress_185 == nil then
            ____p_attackProgress_185 = 1 - if __t(p.attackAnim) then p.attackAnim else 0 / 0.42
        end
        local progress = clamp(nil, ____p_attackProgress_185, 0, 1)
        local physical = if __t(attack) then p.attackType ~= "ranged" else attack
        local combo = if __t(attack) then p.attackType == "combo" else attack
        local dir = if __t(p.attackDirection) then p.attackDirection else "side"
        local shape = tostring(if __t(p.attackShape) then p.attackShape else "")
        local ____t_187 = __t
        local ____get_result_186 = __get(skin, id)
        __O[2532] = ____get_result_186
        local skinColor = if ____t_187(____get_result_186) then __O[2532] else "#d5a478"
        local motion = inferMotion(nil, p)
        local ____t_189 = __t
        local ____TS__Number_result_188 = __TS__Number(p.motionTime)
        __O[2533] = ____TS__Number_result_188
        local mt = if ____t_189(____TS__Number_result_188) then __O[2533] else 0
        local strike = smooth(nil, 0.16, 0.44, progress) * (1 - smooth(nil, 0.61, 1, progress))
        local ____t_191 = __t
        local ____temp_190 = if __t(attack) then progress > 0.2 else attack
        __O[2534] = ____temp_190
        local active = if ____t_191(____temp_190) then progress < 0.8 else __O[2534]
        local ____t_193 = __t
        local ____TS__Number_result_192 = __TS__Number(p.wallSide)
        __O[2535] = ____TS__Number_result_192
        local wallLocal = if ____t_193(____TS__Number_result_192) then __O[2535] else face * face
        c:save()
        c.imageSmoothingEnabled = false
        c:translate(
            math.floor(p.x + 0.5),
            math.floor(p.y + 0.5)
        )
        c:scale(face, 1)
        local function say(____, value, x, y, size, color)
            c:save()
            c:scale(face, 1)
            label(
                nil,
                c,
                value,
                x * face,
                y,
                size,
                color
            )
            c:restore()
        end
        if __gt(p.respawn, 0) then
            do
                local i = 0
                while i < 3 do
                    rect(
                        nil,
                        c,
                        -13 + i * 12,
                        -height - 5 + __mod(t * 40 + i * 13, 18),
                        3,
                        6,
                        if __t(__mod(i, 2)) then "#fff3c6" else "#ffd265"
                    )
                    i = i + 1
                end
            end
        end
        if __gt(if __t(p.transform) then p.transform else 0, 0) then
            do
                local i = 0
                while i < 4 do
                    local xx = -20 + i * 14
                    local yy = -8 - __mod(t * 46 + i * 17, height + 15)
                    rect(
                        nil,
                        c,
                        xx,
                        yy,
                        3,
                        8,
                        k.color
                    )
                    rect(
                        nil,
                        c,
                        xx,
                        yy - 3,
                        2,
                        3,
                        "#fff3bd"
                    )
                    i = i + 1
                end
            end
        end
        if motion == "dash" then
            do
                local i = 0
                while i < 2 do
                    rect(
                        nil,
                        c,
                        -24 - i * 8,
                        -5 + i * 3,
                        7 - i * 2,
                        3,
                        "#f1dca6"
                    )
                    rect(
                        nil,
                        c,
                        -19 - i * 12,
                        -13 + i * 4,
                        6,
                        2,
                        "#fff0c7"
                    )
                    i = i + 1
                end
            end
        end
        local ____t_196 = __t
        local ____t_195 = __t
        local ____temp_194 = motion == "doubleJump" or motion == "wallJump"
        __O[2536] = ____temp_194
        if ____t_196(if ____t_195(____temp_194) then mt < 0.18 else __O[2536]) then
            local q = mt / 0.18
            local xx = if motion == "wallJump" then wallLocal * 21 else 0
            do
                local i = 0
                while i < 3 do
                    rect(
                        nil,
                        c,
                        xx + (i - 1) * (6 + q * 7),
                        -7 - q * if __t(__mod(i, 2)) then 6 else 2,
                        3,
                        3,
                        if __t(__mod(i, 2)) then k.color else "#fff0b4"
                    )
                    i = i + 1
                end
            end
        end
        if __t(motion == "wallSlide" and __gt(p.wallGrip, 0)) then
            rect(
                nil,
                c,
                wallLocal * 23,
                -27 + __mod(t * 35, 18),
                2,
                4,
                "#e7cf9a"
            )
        end
        c:save()
        local ____t_200 = __t
        local ____t_198 = __t
        local ____temp_197 = not __t(attack) and not __t(emoting)
        __O[2537] = ____temp_197
        local ____temp_199 = if ____t_198(____temp_197) then motion ~= "idle" else __O[2537]
        __O[2538] = ____temp_199
        local useMovementRig = if ____t_200(____temp_199) then id ~= "giant" else __O[2538]
        if __t(if __t(attack) then id ~= "giant" else attack) then
            drawAttackRig(
                nil,
                c,
                id,
                p,
                t
            )
        elseif __t(useMovementRig) then
            drawMovementRig(
                nil,
                c,
                id,
                p,
                t
            )
        else
            if __t(if __t(emoting) then p.emoteKind == "dance" else emoting) then
                c:translate(
                    math.sin(t * 7) * 3,
                    -math.abs(math.sin(t * 7)) * if id == "lucas" then 7 else 3
                )
                c:rotate(math.sin(t * 7) * 0.065)
            elseif __t(physical) then
                local windup = if progress < 0.18 then math.sin(progress / 0.18 * math.pi) * -3 else 0
                c:translate(windup + strike * 3, if dir == "down" then strike * 2 else 0)
                c:rotate(if dir == "up" then -0.07 else if dir == "down" then 0.025 else 0.075 * strike)
            elseif motion == "run" then
                local ____t_202 = __t
                local ____get_result_201 = __get(gait, id)
                __O[2539] = ____get_result_201
                local phase = t * if ____t_202(____get_result_201) then __O[2539] else 10.7
                c:translate(
                    0,
                    -math.abs(math.sin(phase)) * 1.8
                )
                c:rotate(if id == "igor" then 0.035 else 0.07)
            elseif motion == "dash" then
                c:translate(3, -3)
                c:rotate(if id == "igor" then 0.16 else 0.24)
                c:scale(1.03, 0.94)
            elseif motion == "doubleJump" then
                c:translate(0, -2)
                c:rotate(-0.16 + math.sin(clamp(nil, mt / 0.28, 0, 1) * math.pi) * 0.34)
            elseif motion == "jump" then
                c:rotate(-0.06)
                c:scale(0.98, 1.02)
            elseif motion == "fall" then
                c:rotate(0.045)
            elseif motion == "wallSlide" then
                c:translate(-wallLocal * 2, 0)
                c:rotate(-wallLocal * 0.08)
            elseif motion == "wallJump" then
                c:rotate(wallLocal * 0.17)
                c:translate(-wallLocal * 2, -2)
            elseif motion == "land" then
                local squash = 1 - clamp(nil, mt / 0.12, 0, 1)
                c:scale(1 + squash * 0.035, 1 - squash * 0.065)
            end
            local ____t_208 = __t
            local ____t_206 = __t
            local ____t_204 = __t
            local ____call_result_203 = __call(girls, "has", id)
            __O[2540] = ____call_result_203
            local ____temp_205 = if ____t_204(____call_result_203) then __O[2540] else id == "freddy"
            __O[2541] = ____temp_205
            local ____temp_207 = if ____t_206(____temp_205) then physical else __O[2541]
            __O[2543] = ____temp_207
            local ____t_210 = __t
            local ____temp_209 = id == "mota"
            __O[2542] = ____temp_209
            local kick = if ____t_208(____temp_207) then __O[2543] else if ____t_210(____temp_209) then attack else __O[2542]
            local ____t_212 = __t
            local ____call_result_211 = __call(girls, "has", id)
            __O[2544] = ____call_result_211
            local kickGuard = if ____t_212(____call_result_211) then physical else __O[2544]
            local pose = legPose(
                nil,
                id,
                motion,
                t,
                dir,
                if __t(kick) then progress else 0,
                combo
            )
            local armHalf = if id == "igor" then 22 else 14
            local ____t_214 = __t
            local ____temp_213 = id ~= "giant"
            __O[2548] = ____temp_213
            local ____t_220 = __t
            local ____t_216 = __t
            local ____temp_215 = motion == "wallSlide" and not __t(attack)
            __O[2546] = ____temp_215
            local ____t_218 = __t
            local ____temp_217 = if __t(attack) then active else attack
            __O[2545] = ____temp_217
            local ____temp_219 = if ____t_216(____temp_215) then __O[2546] else if ____t_218(____temp_217) then not __t(kick) else __O[2545]
            __O[2547] = ____temp_219
            local replaceArm = if ____t_214(____temp_213) then if ____t_220(____temp_219) then __O[2547] else kickGuard else __O[2548]
            local aimX = if dir == "up" then 9 else if dir == "down" then 17 else if dir == "neutral" then 23 else 29
            local aimY = if dir == "up" then -height + 14 else if dir == "down" then -23 else -35
            local function drawBase()
                local ____opt_240 = window.Art
                if ____opt_240 ~= nil then
                    ____opt_240 = ____opt_240.drawCharacter
                end
                local ____opt_result_242
                if ____opt_240 ~= nil then
                    local ____c_238 = c
                    local ____scale_232 = scale
                    local ____t_223 = __t
                    local ____get_result_222 = __get(gait, id)
                    __O[2549] = ____get_result_222
                    local ____temp_233 = if __t(emoting) then t * 1.65 else t * if ____t_223(____get_result_222) then __O[2549] else 10.7 / 10.7
                    local ____temp_234 = not __t(__call(
                        __arrL({
                            "jump",
                            "doubleJump",
                            "fall",
                            "wallSlide",
                            "wallJump"
                        }, 5),
                        "includes",
                        motion
                    ))
                    local ____t_225 = __t
                    local ____temp_224 = motion == "run" or motion == "dash"
                    __O[2550] = ____temp_224
                    local ____temp_235 = if ____t_225(____temp_224) then __O[2550] else if __t(emoting) then p.emoteKind == "dance" else emoting
                    local ____math_abs_result_236 = math.abs(if __t(p.vx) then p.vx else 0)
                    local ____temp_237 = if __t(p.vy) then p.vy else 0
                    local ____t_229 = __t
                    local ____t_227 = __t
                    local ____temp_226 = id == "nikolas"
                    __O[2551] = ____temp_226
                    local ____temp_228 = if ____t_227(____temp_226) then emoting else __O[2551]
                    __O[2553] = ____temp_228
                    local ____t_231 = __t
                    local ____temp_230 = not __t(attack) and not __t(emoting)
                    __O[2552] = ____temp_230
                    ____opt_result_242 = ____opt_240(
                        ____opt_240,
                        ____c_238,
                        id,
                        0,
                        0,
                        {
                            scale = ____scale_232,
                            facing = 1,
                            frame = ____temp_233,
                            grounded = ____temp_234,
                            moving = ____temp_235,
                            speed = ____math_abs_result_236,
                            vy = ____temp_237,
                            monitorBattle = true,
                            noseRub = if ____t_229(____temp_228) then __O[2553] else if ____t_231(____temp_230) then motion == "idle" else __O[2552],
                            attack = false,
                            attackType = "paper",
                            attackProgress = progress,
                            hit = __gt(p.hit, 0),
                            bossPhase = 1,
                            flight = false,
                            smoke = false,
                            bellyRolling = false,
                            expressive = id == "arthur",
                            talking = if __t(emoting) then p.emoteKind == "taunt" else emoting,
                            injured = false
                        }
                    )
                end
                return ____opt_result_242
            end
            local ____t_245 = __t
            local ____opt_243 = window.Art
            if ____opt_243 ~= nil then
                ____opt_243 = ____opt_243.drawCharacter
            end
            if ____t_245(____opt_243) then
                if id == "giant" then
                    drawBase(nil)
                else
                    c:save()
                    c:beginPath()
                    c:rect(-110, -150, 220, 150 + pose.hipY + 1)
                    if pose.hipY < -12 then
                        c:rect(-110, pose.hipY, 95, -12 - pose.hipY)
                        c:rect(15, pose.hipY, 95, -12 - pose.hipY)
                    end
                    c:clip()
                    if __t(replaceArm) then
                        local side = if motion == "wallSlide" then wallLocal else 1
                        c:beginPath()
                        c:rect(-110, -150, 220, 106)
                        if side > 0 then
                            c:rect(-110, -44, 110 + armHalf, 44)
                        else
                            c:rect(-armHalf, -44, 110 + armHalf, 44)
                        end
                        c:clip()
                    end
                    drawBase(nil)
                    c:restore()
                    local ____t_248 = __t
                    local ____t_247 = __t
                    local ____temp_246 = motion == "wallSlide" or motion == "wallJump"
                    __O[2554] = ____temp_246
                    if ____t_248(if ____t_247(____temp_246) then wallLocal < 0 else __O[2554]) then
                        for ____, leg in __iterar((pose.legs)) do
                            for ____, joint in __iterar((__arrL({"hip", "knee", "foot"}, 3))) do
                                __set(
                                    __get(leg, joint),
                                    0,
                                    __get(
                                        __get(leg, joint),
                                        0
                                    ) * -1
                                )
                            end
                        end
                    end
                    drawLegs(
                        nil,
                        c,
                        id,
                        pose,
                        kick,
                        k.color
                    )
                end
            else
                rect(
                    nil,
                    c,
                    -13,
                    -height,
                    26,
                    height,
                    skinColor
                )
                rect(
                    nil,
                    c,
                    -12,
                    -height + 25,
                    24,
                    30,
                    k.color
                )
            end
            local ____t_251 = __t
            local ____t_250 = __t
            local ____temp_249 = motion == "wallSlide" and not __t(attack)
            __O[2555] = ____temp_249
            if ____t_251(if ____t_250(____temp_249) then id ~= "giant" else __O[2555]) then
                local wx = wallLocal * if id == "igor" then 29 else 21
                local sx = wallLocal * if id == "igor" then 19 else 9
                line(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({sx, -43}, 2),
                            __arrL({wallLocal * if id == "igor" then 26 else 16, -37}, 2),
                            __arrL({wx, -47}, 2)
                        },
                        3
                    ),
                    INK,
                    6
                )
                line(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({sx, -43}, 2),
                            __arrL({wallLocal * if id == "igor" then 26 else 16, -37}, 2),
                            __arrL({wx, -47}, 2)
                        },
                        3
                    ),
                    skinColor,
                    3
                )
                rect(
                    nil,
                    c,
                    wx - 2,
                    -50,
                    5,
                    6,
                    skinColor
                )
            end
            if __t(kickGuard) then
                local lift = if dir == "up" then 12 else if dir == "down" then 7 else 10
                local guard = solveLeg(
                    nil,
                    __arrL({9, -42}, 2),
                    __arrL({18 - strike * 14, -22 - strike * lift}, 2),
                    9,
                    11,
                    -1
                )
                line(
                    nil,
                    c,
                    __arrL({guard.hip, guard.knee, guard.foot}, 3),
                    INK,
                    7
                )
                line(
                    nil,
                    c,
                    __arrL({guard.hip, guard.knee}, 2),
                    "#e4ece2",
                    4
                )
                line(
                    nil,
                    c,
                    __arrL({guard.knee, guard.foot}, 2),
                    skinColor,
                    4
                )
                rect(
                    nil,
                    c,
                    __get(guard.foot, 0) - 2,
                    __get(guard.foot, 1) - 2,
                    5,
                    5,
                    skinColor
                )
            end
            local ____t_256 = __t
            local ____t_255 = __t
            local ____t_253 = __t
            local ____temp_252 = if __t(attack) then active else attack
            __O[2556] = ____temp_252
            local ____temp_254 = if ____t_253(____temp_252) then not __t(kick) else __O[2556]
            __O[2557] = ____temp_254
            if ____t_256(if ____t_255(____temp_254) then id ~= "giant" else __O[2557]) then
                local ____t_258 = __t
                local ____get_result_257 = __get({
                    daroca = "#c4934e",
                    reeis = "#49818e",
                    nikolas = "#87689b",
                    marco = "#30363b",
                    menezes = "#779097",
                    ollyan = "#252f3b",
                    igor = "#287eb8",
                    kaique = "#b8dce3",
                    dede = "#516563",
                    arthur = "#6d99a0",
                    davi = "#252b34",
                    vitor = "#a3adb0",
                    almiro = "#3288c7",
                    miqueias = "#d8ca9c",
                    allef = "#2a333a"
                }, id)
                __O[2558] = ____get_result_257
                local sleeve = if ____t_258(____get_result_257) then __O[2558] else "#e4d8b7"
                local shoulder = __arrL({if id == "igor" then 19 else 9, -42}, 2)
                local hand = solveLeg(
                    nil,
                    shoulder,
                    __arrL({aimX, aimY}, 2),
                    10,
                    12,
                    -1
                )
                line(
                    nil,
                    c,
                    __arrL({hand.hip, hand.knee, hand.foot}, 3),
                    INK,
                    7
                )
                line(
                    nil,
                    c,
                    __arrL({hand.hip, hand.knee}, 2),
                    sleeve,
                    4
                )
                line(
                    nil,
                    c,
                    __arrL({hand.knee, hand.foot}, 2),
                    skinColor,
                    4
                )
                rect(
                    nil,
                    c,
                    __get(hand.foot, 0) - 3,
                    __get(hand.foot, 1) - 3,
                    6,
                    6,
                    skinColor
                )
                local ____t_261 = __t
                local ____t_260 = __t
                local ____temp_259 = not __t(physical)
                __O[2559] = ____temp_259
                if ____t_261(if ____t_260(____temp_259) then __call(girls, "has", id) else __O[2559]) then
                    heel(
                        nil,
                        c,
                        __get(hand.foot, 0) + 2,
                        __get(hand.foot, 1),
                        -0.5,
                        0.38,
                        k.color
                    )
                end
            end
            local ____t_268 = __t
            local ____t_267 = __t
            local ____t_265 = __t
            local ____t_263 = __t
            local ____temp_262 = id == "mota"
            __O[2560] = ____temp_262
            local ____temp_264 = if ____t_263(____temp_262) then attack else __O[2560]
            __O[2561] = ____temp_264
            local ____temp_266 = if ____t_265(____temp_264) then active else __O[2561]
            __O[2562] = ____temp_266
            if ____t_268(if ____t_267(____temp_266) then not __t(physical) else __O[2562]) then
                local foot = __get(pose.legs, 1).foot
                ball(
                    nil,
                    c,
                    __get(foot, 0) + 6,
                    __get(foot, 1) - 4,
                    t * 8,
                    0.65
                )
            end
            local ____t_273 = __t
            local ____t_272 = __t
            local ____t_270 = __t
            local ____temp_269 = id == "mota" and not __t(attack)
            __O[2563] = ____temp_269
            local ____temp_271 = if ____t_270(____temp_269) then not __t(p.ballAway) else __O[2563]
            __O[2564] = ____temp_271
            if ____t_273(if ____t_272(____temp_271) then motion == "idle" else __O[2564]) then
                local by = -8 - math.abs(math.sin(t * 4)) * 20
                ball(
                    nil,
                    c,
                    19,
                    by,
                    t * 3,
                    0.55
                )
            end
            local ____t_276 = __t
            local ____t_275 = __t
            local ____temp_274 = id == "caleb" and not __t(attack)
            __O[2565] = ____temp_274
            if ____t_276(if ____t_275(____temp_274) then not __t(emoting) else __O[2565]) then
                weight(
                    nil,
                    c,
                    20,
                    -29,
                    0.05,
                    0.48
                )
            end
            if __t(if __t(physical) then active else physical) then
                local hitX = aimX
                local hitY = aimY
                local hitAngle = if dir == "up" then -math.pi / 2 else if dir == "down" then math.pi / 2 else 0
                local hitScale = 0.75 + 0.2 * strike
                c:save()
                c:translate(hitX, hitY)
                c:scale(hitScale, hitScale)
                local ____t_283 = __t
                local ____t_282 = __t
                local ____t_280 = __t
                local ____t_278 = __t
                local ____temp_277 = progress > 0.32 and progress < 0.57
                __O[2566] = ____temp_277
                local ____temp_279 = if ____t_278(____temp_277) then not __t(__call(girls, "has", id)) else __O[2566]
                __O[2567] = ____temp_279
                local ____temp_281 = if ____t_280(____temp_279) then id ~= "dede" else __O[2567]
                __O[2568] = ____temp_281
                if ____t_283(if ____t_282(____temp_281) then id ~= "ollyan" else __O[2568]) then
                    c:save()
                    c:rotate(hitAngle)
                    rect(
                        nil,
                        c,
                        -19,
                        -3,
                        13,
                        3,
                        k.color
                    )
                    rect(
                        nil,
                        c,
                        -26,
                        3,
                        9,
                        2,
                        "#fff0bb"
                    )
                    c:restore()
                end
                if id == "menezes" then
                    claw(
                        nil,
                        c,
                        2,
                        -2,
                        t,
                        "#f2e7c8"
                    )
                elseif id == "caleb" then
                    weight(
                        nil,
                        c,
                        7,
                        0,
                        hitAngle - 0.35 + strike * 0.6,
                        0.65,
                        k.color
                    )
                elseif __t(id == "reeis" or id == "kaique") then
                    c:rotate(hitAngle - 0.18)
                    rect(
                        nil,
                        c,
                        -15,
                        -7,
                        33,
                        11,
                        "#203841"
                    )
                    rect(
                        nil,
                        c,
                        -12,
                        -4,
                        26,
                        5,
                        "#769193"
                    )
                    rect(
                        nil,
                        c,
                        -8,
                        4,
                        7,
                        11,
                        "#263d45"
                    )
                    rect(
                        nil,
                        c,
                        14,
                        -4,
                        9,
                        4,
                        "#bec3ab"
                    )
                    rect(
                        nil,
                        c,
                        -11,
                        -6,
                        21,
                        2,
                        "#a4b2a4"
                    )
                elseif __t(__call(
                    __arrL({"marco", "kaua", "miqueias"}, 3),
                    "includes",
                    id
                )) then
                    c:rotate(hitAngle - 0.9 + strike * 0.5)
                    rect(
                        nil,
                        c,
                        -3,
                        -22,
                        6,
                        39,
                        "#283940"
                    )
                    rect(
                        nil,
                        c,
                        -2,
                        -20,
                        4,
                        30,
                        if id == "marco" then "#e8bd70" else if id == "miqueias" then "#b8d7cd" else "#e6ad52"
                    )
                    do
                        local i = 0
                        while i < 4 do
                            rect(
                                nil,
                                c,
                                -2,
                                -16 + i * 6,
                                3,
                                1,
                                "#68715c"
                            )
                            i = i + 1
                        end
                    end
                    poly(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({-3, 10}, 2),
                                __arrL({3, 10}, 2),
                                __arrL({0, 20}, 2)
                            },
                            3
                        ),
                        "#fae6b6"
                    )
                    rect(
                        nil,
                        c,
                        -1,
                        17,
                        2,
                        4,
                        "#29323b"
                    )
                elseif id == "davi" then
                    rect(
                        nil,
                        c,
                        -6,
                        -12,
                        13,
                        24,
                        "#263d46"
                    )
                    rect(
                        nil,
                        c,
                        -4,
                        -9,
                        9,
                        15,
                        "#b3bdb4"
                    )
                    do
                        local i = 0
                        while i < 4 do
                            rect(
                                nil,
                                c,
                                -6 + i * 4,
                                -16,
                                2,
                                5,
                                "#e7e9d0"
                            )
                            i = i + 1
                        end
                    end
                    rect(
                        nil,
                        c,
                        -2,
                        -8,
                        3,
                        7,
                        "#f2e2b7"
                    )
                elseif id == "vitor" then
                    c:rotate(hitAngle + strike * 1.2 - 0.6)
                    rect(
                        nil,
                        c,
                        -17,
                        -7,
                        37,
                        13,
                        "#e5e9d6"
                    )
                    rect(
                        nil,
                        c,
                        -15,
                        -5,
                        32,
                        3,
                        "#9bbab0"
                    )
                    rect(
                        nil,
                        c,
                        -14,
                        3,
                        31,
                        1,
                        "#718e89"
                    )
                    do
                        local i = 0
                        while i < 5 do
                            rect(
                                nil,
                                c,
                                18,
                                -6 + i * 3,
                                5,
                                1,
                                "#c5d4c0"
                            )
                            i = i + 1
                        end
                    end
                elseif id == "almiro" then
                    glove(
                        nil,
                        c,
                        3,
                        0,
                        skinColor,
                        hitAngle
                    )
                    if __t(progress > 0.35 and progress < 0.55) then
                        line(
                            nil,
                            c,
                            __arrL(
                                {
                                    __arrL({-5, -height + 35}, 2),
                                    __arrL({-5, -height + 22}, 2)
                                },
                                2
                            ),
                            "#fff1b0",
                            2
                        )
                        line(
                            nil,
                            c,
                            __arrL(
                                {
                                    __arrL({-12, -height + 29}, 2),
                                    __arrL({3, -height + 29}, 2)
                                },
                                2
                            ),
                            "#fff1b0",
                            2
                        )
                    end
                elseif __t(id == "ravid" or id == "allef") then
                    glove(
                        nil,
                        c,
                        3,
                        0,
                        skinColor,
                        hitAngle
                    )
                elseif id == "ollyan" then
                    c:rotate(hitAngle)
                    poly(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({-16, -6}, 2),
                                __arrL({2, -13}, 2),
                                __arrL({18, -3}, 2),
                                __arrL({6, 7}, 2),
                                __arrL({-20, 5}, 2),
                                __arrL({-2, 0}, 2)
                            },
                            6
                        ),
                        "#d9eff7"
                    )
                    rect(
                        nil,
                        c,
                        -9,
                        -4,
                        18,
                        3,
                        "#81b9ea"
                    )
                elseif id == "mota" then
                    ball(
                        nil,
                        c,
                        6,
                        6,
                        t * 7,
                        0.75
                    )
                elseif id == "lucas" then
                    glove(
                        nil,
                        c,
                        -3,
                        14,
                        k.color,
                        hitAngle - 0.15
                    )
                elseif id == "igor" then
                    glove(
                        nil,
                        c,
                        5,
                        2,
                        skinColor,
                        0.1 + hitAngle
                    )
                    if __t(combo) then
                        rect(
                            nil,
                            c,
                            -10,
                            -4,
                            24 + strike * 5,
                            18,
                            "#2e8dd0"
                        )
                        rect(
                            nil,
                            c,
                            -8,
                            -3,
                            21 + strike * 4,
                            3,
                            "#7bc8eb"
                        )
                        rect(
                            nil,
                            c,
                            -10,
                            11,
                            23 + strike * 5,
                            3,
                            "#25609b"
                        )
                    end
                elseif id == "giant" then
                    say(
                        nil,
                        if progress < 0.5 then "6" else "7",
                        11,
                        0,
                        22,
                        k.color
                    )
                elseif id == "nicolas" then
                    glove(
                        nil,
                        c,
                        5,
                        0,
                        "#e6c56e",
                        hitAngle - 0.15
                    )
                    if __t(progress > 0.35 and progress < 0.55) then
                        rect(
                            nil,
                            c,
                            -2,
                            -16,
                            2,
                            7,
                            "#fff1c0"
                        )
                        rect(
                            nil,
                            c,
                            -5,
                            -13,
                            8,
                            2,
                            "#fff1c0"
                        )
                    end
                elseif id == "dede" then
                    glove(
                        nil,
                        c,
                        5,
                        0,
                        skinColor,
                        hitAngle
                    )
                    puff(
                        nil,
                        c,
                        -7,
                        3,
                        7,
                        "#91a5b5",
                        "#d6e4e9"
                    )
                elseif not __t(__call(girls, "has", id)) then
                    glove(
                        nil,
                        c,
                        4,
                        0,
                        skinColor,
                        hitAngle - 0.15
                    )
                end
                c:restore()
            end
        end
        c:restore()
        local ____t_286 = __t
        local ____t_285 = __t
        local ____temp_284 = if __t(combo) then progress > 0.3 else combo
        __O[2569] = ____temp_284
        if ____t_286(if ____t_285(____temp_284) then progress < 0.6 else __O[2569]) then
            local phrase = if __t(__call(girls, "has", id)) then "BIURIFUL!" else if id == "mota" then "GOLAÇO!" else if id == "igor" then "REBATE!" else if id == "lucas" then "SAPO NINJA!" else if id == "menezes" then "POUDII!" else if id == "reeis" then "OOO REEEIS!" else ""
            if __t(phrase) then
                say(
                    nil,
                    phrase,
                    0,
                    -height - 13,
                    8,
                    k.color
                )
            end
        end
        if __t(emoting) then
            local dance = p.emoteKind == "dance"
            if __t(dance) then
                do
                    local i = 0
                    while i < 2 do
                        local xx = -23 + i * 45
                        local yy = -height - 5 - math.sin(t * 5 + i) * 4
                        rect(
                            nil,
                            c,
                            xx,
                            yy,
                            2,
                            7,
                            k.color
                        )
                        rect(
                            nil,
                            c,
                            xx,
                            yy - 1,
                            6,
                            2,
                            k.color
                        )
                        rect(
                            nil,
                            c,
                            xx - 2,
                            yy + 6,
                            4,
                            3,
                            k.color
                        )
                        i = i + 1
                    end
                end
                if id == "caleb" then
                    weight(
                        nil,
                        c,
                        0,
                        -height - 11 + math.sin(t * 7) * 5,
                        0,
                        0.65
                    )
                end
                if id == "mota" then
                    ball(
                        nil,
                        c,
                        23,
                        -18 - math.abs(math.sin(t * 5)) * 32,
                        t * 5,
                        0.55
                    )
                end
                if id == "menezes" then
                    local ____opt_289 = window.Art
                    if ____opt_289 ~= nil then
                        ____opt_289 = ____opt_289.drawRat
                    end
                    if ____opt_289 ~= nil then
                        ____opt_289(
                            ____opt_289,
                            c,
                            24,
                            -1,
                            t,
                            {scale = 0.35, facing = -1}
                        )
                    end
                end
            else
                local phrase = if __t(__call(girls, "has", id)) then "AFF VEYR JURO" else if id == "caleb" then "CADÊ O SHAPE?" else if id == "igor" then "TEM LANCHE?" else if id == "lucas" then "BAIXINHO LIGEIRO" else if id == "menezes" then "PEGOU AR?" else if id == "reeis" then "CHAMOU O REI?" else if id == "mota" then "SÓ EMBAIXADINHA" else "RESPEITA A ROÇA"
                local w = __len(phrase) * 4.8 + 12
                rect(
                    nil,
                    c,
                    -w / 2,
                    -height - 29,
                    w,
                    18,
                    "#fff0c9"
                )
                poly(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({-4, -height - 11}, 2),
                            __arrL({3, -height - 11}, 2),
                            __arrL({0, -height - 7}, 2)
                        },
                        3
                    ),
                    "#fff0c9"
                )
                say(
                    nil,
                    phrase,
                    0,
                    -height - 20,
                    8,
                    "#31534b"
                )
                if id == "ravid" then
                    rect(
                        nil,
                        c,
                        25,
                        -51,
                        15,
                        49,
                        "#9cb5a9"
                    )
                    do
                        local i = 0
                        while i < 4 do
                            rect(
                                nil,
                                c,
                                26,
                                -48 + i * 11,
                                13,
                                1,
                                "#64847c"
                            )
                            i = i + 1
                        end
                    end
                end
            end
        end
        c:restore()
    end
    local function projectileType(self, s)
        local ____call_295 = __call
        local ____t_294 = __t
        local ____t_292 = __t
        local ____temp_291 = if __t(s.type) then s.type else s.shape
        __O[2570] = ____temp_291
        local ____temp_293 = if ____t_292(____temp_291) then __O[2570] else s.effect
        __O[2571] = ____temp_293
        return ____call_295(
            tostring(if ____t_294(____temp_293) then __O[2571] else "paper"),
            "toLowerCase"
        )
    end
    local function drawProjectile(self, c, s, time)
        if time == nil then
            time = 0
        end
        if not __t(s) then
            return
        end
        local ____type = projectileType(nil, s)
        local ____t_299 = __t
        local ____t_297 = __t
        local ____TS__Number_result_296 = __TS__Number(s.r)
        __O[2572] = ____TS__Number_result_296
        local ____temp_298 = if ____t_297(____TS__Number_result_296) then __O[2572] else __TS__Number(s.radius)
        __O[2573] = ____temp_298
        local r = math.max(
            4,
            math.min(28, if ____t_299(____temp_298) then __O[2573] else 9)
        )
        local color = if __t(s.color) then s.color else "#f3d28a"
        local ____t_301 = __t
        local ____TS__Number_result_300 = __TS__Number(time)
        __O[2574] = ____TS__Number_result_300
        local t = if ____t_301(____TS__Number_result_300) then __O[2574] else 0
        local ____t_303 = __t
        local ____TS__Number_result_302 = __TS__Number(s.vx)
        __O[2575] = ____TS__Number_result_302
        local vx = if ____t_303(____TS__Number_result_302) then __O[2575] else 0
        local ____t_305 = __t
        local ____TS__Number_result_304 = __TS__Number(s.vy)
        __O[2576] = ____TS__Number_result_304
        local vy = if ____t_305(____TS__Number_result_304) then __O[2576] else 0
        local angle = math.atan2(vy, vx)
        local age = if __t(__isFiniteN(s.maxLife) and __isFiniteN(s.life)) then math.max(0, s.maxLife - s.life) else t
        local spin = age * if __t(__call(____type, "includes", "weight")) then 7 else 10 * if vx < 0 then -1 else 1
        c:save()
        c.imageSmoothingEnabled = false
        c:translate(
            math.floor(s.x + 0.5),
            math.floor(s.y + 0.5)
        )
        local ____t_308 = __t
        local ____t_307 = __t
        local ____temp_306 = __hypot(vx, vy) > 220 and __re_test(
            __re("paper|heel|shoe|weight|ball|bullet|pen|ink|stone|brush", ""),
            ____type
        )
        __O[2577] = ____temp_306
        if ____t_308(if ____t_307(____temp_306) then ____type ~= "67" else __O[2577]) then
            c:save()
            c:rotate(angle)
            do
                local i = 0
                while i < 3 do
                    local len = 7 - i * 2
                    rect(
                        nil,
                        c,
                        -r - 8 - i * 8,
                        -2 + __mod(i, 2) * 4,
                        len,
                        if i == 0 then 2 else 1,
                        if i == 0 then "#fff0c1" else color
                    )
                    i = i + 1
                end
            end
            c:restore()
        end
        local ____t_311 = __t
        local ____t_310 = __t
        local ____call_result_309 = __call(
            __arrL({"tongue", "tether"}, 2),
            "some",
            function(____, q) return __call(____type, "includes", q) end
        )
        __O[2578] = ____call_result_309
        if ____t_311(if ____t_310(____call_result_309) then __O[2578] else s.motion == "tether") then
            local ox = if __isFiniteN(s.originX) then s.originX - s.x else if __isFiniteN(s.startX) then s.startX - s.x else -math.cos(angle) * 32
            local oy = if __isFiniteN(s.originY) then s.originY - s.y else if __isFiniteN(s.startY) then s.startY - s.y - 7 else -math.sin(angle) * 32
            line(
                nil,
                c,
                __arrL(
                    {
                        __arrL({ox, oy}, 2),
                        __arrL(
                            {
                                -math.cos(angle) * 12,
                                math.sin(t * 14) * 4
                            },
                            2
                        ),
                        __arrL({0, 0}, 2)
                    },
                    3
                ),
                "#9d5c69",
                7
            )
            line(
                nil,
                c,
                __arrL(
                    {
                        __arrL({ox, oy}, 2),
                        __arrL(
                            {
                                -math.cos(angle) * 12,
                                math.sin(t * 14) * 4
                            },
                            2
                        ),
                        __arrL({0, 0}, 2)
                    },
                    3
                ),
                "#eda0ab",
                4
            )
            pixelOval(
                nil,
                c,
                0,
                0,
                7,
                5,
                "#f5b0b7"
            )
        else
            local ____t_314 = __t
            local ____t_313 = __t
            local ____call_result_312 = __call(____type, "includes", "heel")
            __O[2579] = ____call_result_312
            if ____t_314(if ____t_313(____call_result_312) then __O[2579] else __call(____type, "includes", "shoe")) then
                heel(
                    nil,
                    c,
                    0,
                    0,
                    spin,
                    0.82,
                    color
                )
                if __t(s.returning) then
                    c:save()
                    c:rotate(angle)
                    rect(
                        nil,
                        c,
                        -24,
                        -6,
                        8,
                        4,
                        "#fff2bd"
                    )
                    rect(
                        nil,
                        c,
                        -32,
                        1,
                        6,
                        3,
                        color
                    )
                    c:restore()
                end
            else
                local ____t_321 = __t
                local ____t_320 = __t
                local ____t_318 = __t
                local ____t_316 = __t
                local ____call_result_315 = __call(____type, "includes", "weight")
                __O[2580] = ____call_result_315
                local ____temp_317 = if ____t_316(____call_result_315) then __O[2580] else __call(____type, "includes", "dumbbell")
                __O[2581] = ____temp_317
                local ____temp_319 = if ____t_318(____temp_317) then __O[2581] else __call(____type, "includes", "plate")
                __O[2582] = ____temp_319
                if ____t_321(if ____t_320(____temp_319) then __O[2582] else __call(____type, "includes", "anilha")) then
                    weight(
                        nil,
                        c,
                        0,
                        0,
                        spin,
                        0.8,
                        color
                    )
                else
                    local ____t_326 = __t
                    local ____t_325 = __t
                    local ____t_323 = __t
                    local ____call_result_322 = __call(____type, "includes", "ball")
                    __O[2583] = ____call_result_322
                    local ____temp_324 = if ____t_323(____call_result_322) then __O[2583] else __call(____type, "includes", "football")
                    __O[2584] = ____temp_324
                    if ____t_326(if ____t_325(____temp_324) then __O[2584] else __call(____type, "includes", "futebol")) then
                        ball(
                            nil,
                            c,
                            0,
                            0,
                            spin,
                            0.95
                        )
                    else
                        local ____t_337 = __t
                        local ____t_336 = __t
                        local ____t_334 = __t
                        local ____t_332 = __t
                        local ____t_330 = __t
                        local ____t_328 = __t
                        local ____call_result_327 = __call(____type, "includes", "word")
                        __O[2585] = ____call_result_327
                        local ____temp_329 = if ____t_328(____call_result_327) then __O[2585] else __call(____type, "includes", "text")
                        __O[2586] = ____temp_329
                        local ____temp_331 = if ____t_330(____temp_329) then __O[2586] else __call(____type, "includes", "chalk")
                        __O[2587] = ____temp_331
                        local ____temp_333 = if ____t_332(____temp_331) then __O[2587] else ____type == "monologue"
                        __O[2588] = ____temp_333
                        local ____temp_335 = if ____t_334(____temp_333) then __O[2588] else ____type == "english"
                        __O[2589] = ____temp_335
                        if ____t_337(if ____t_336(____temp_335) then __O[2589] else ____type == "ticket") then
                            local phrase = __call(
                                tostring(if __t(s.text) then s.text else if ____type == "english" then "ALLRIGHT!" else if ____type == "monologue" then "BLÁ BLÁ BLÁ" else if ____type == "ticket" then "SENHA 67" else "POUDII!"),
                                "slice",
                                0,
                                18
                            )
                            local w = __len(phrase) * 6 + 14
                            rect(
                                nil,
                                c,
                                -w / 2,
                                -12,
                                w,
                                24,
                                if ____type == "ticket" then "#eddbaf" else "#243c48"
                            )
                            rect(
                                nil,
                                c,
                                -w / 2,
                                -12,
                                3,
                                24,
                                color
                            )
                            if ____type == "ticket" then
                                do
                                    local i = 0
                                    while i < 6 do
                                        rect(
                                            nil,
                                            c,
                                            -w / 2 + i * w / 6,
                                            -13,
                                            3,
                                            3,
                                            INK
                                        )
                                        i = i + 1
                                    end
                                end
                            end
                            label(
                                nil,
                                c,
                                phrase,
                                0,
                                1,
                                11,
                                if ____type == "ticket" then "#3f4e42" else "#f5e5bc"
                            )
                        elseif ____type == "wind" then
                            smear(
                                nil,
                                c,
                                0,
                                0,
                                angle,
                                0.6,
                                "#e9fbff",
                                12
                            )
                            rect(
                                nil,
                                c,
                                -8,
                                -6,
                                17,
                                4,
                                "#81d7ff"
                            )
                            rect(
                                nil,
                                c,
                                -5,
                                3,
                                21,
                                3,
                                color
                            )
                        elseif ____type == "light" then
                            c:rotate(angle)
                            poly(
                                nil,
                                c,
                                __arrL(
                                    {
                                        __arrL({-21, 0}, 2),
                                        __arrL({-9, -5}, 2),
                                        __arrL({-1, -12}, 2),
                                        __arrL({6, -5}, 2),
                                        __arrL({17, 0}, 2),
                                        __arrL({6, 5}, 2),
                                        __arrL({-1, 12}, 2),
                                        __arrL({-9, 5}, 2)
                                    },
                                    8
                                ),
                                "#f0ce74"
                            )
                            poly(
                                nil,
                                c,
                                __arrL(
                                    {
                                        __arrL({-12, 0}, 2),
                                        __arrL({-2, -6}, 2),
                                        __arrL({9, 0}, 2),
                                        __arrL({-2, 6}, 2)
                                    },
                                    4
                                ),
                                "#fff6c2"
                            )
                            rect(
                                nil,
                                c,
                                -33,
                                -1,
                                10,
                                2,
                                color
                            )
                        elseif ____type == "stone" then
                            c:rotate(spin * 0.5)
                            poly(
                                nil,
                                c,
                                __arrL(
                                    {
                                        __arrL({-10, -8}, 2),
                                        __arrL({1, -12}, 2),
                                        __arrL({11, -5}, 2),
                                        __arrL({10, 6}, 2),
                                        __arrL({0, 12}, 2),
                                        __arrL({-12, 5}, 2)
                                    },
                                    6
                                ),
                                "#677b78"
                            )
                            poly(
                                nil,
                                c,
                                __arrL(
                                    {
                                        __arrL({-8, -6}, 2),
                                        __arrL({0, -9}, 2),
                                        __arrL({7, -4}, 2),
                                        __arrL({1, 1}, 2),
                                        __arrL({-8, 1}, 2)
                                    },
                                    5
                                ),
                                "#9eb4a4"
                            )
                            rect(
                                nil,
                                c,
                                2,
                                5,
                                5,
                                2,
                                "#3f5a59"
                            )
                        else
                            local ____t_340 = __t
                            local ____t_339 = __t
                            local ____call_result_338 = __call(____type, "includes", "wave")
                            __O[2590] = ____call_result_338
                            if ____t_340(if ____t_339(____call_result_338) then __O[2590] else s.motion == "wave") then
                                do
                                    local i = 0
                                    while i < 4 do
                                        local xx = -i * 10
                                        poly(
                                            nil,
                                            c,
                                            __arrL(
                                                {
                                                    __arrL({xx - 8, 12}, 2),
                                                    __arrL(
                                                        {
                                                            xx - 2,
                                                            -8 - __mod(i, 2) * 8
                                                        },
                                                        2
                                                    ),
                                                    __arrL(
                                                        {
                                                            xx + 6,
                                                            -17 - __mod(i, 2) * 6
                                                        },
                                                        2
                                                    ),
                                                    __arrL({xx + 11, 12}, 2)
                                                },
                                                4
                                            ),
                                            if __t(__mod(i, 2)) then color else "#e9dfaa"
                                        )
                                        i = i + 1
                                    end
                                end
                                rect(
                                    nil,
                                    c,
                                    -40,
                                    12,
                                    52,
                                    3,
                                    color
                                )
                            else
                                local ____t_345 = __t
                                local ____t_344 = __t
                                local ____t_342 = __t
                                local ____call_result_341 = __call(____type, "includes", "smoke")
                                __O[2591] = ____call_result_341
                                local ____temp_343 = if ____t_342(____call_result_341) then __O[2591] else __call(____type, "includes", "gas")
                                __O[2592] = ____temp_343
                                if ____t_345(if ____t_344(____temp_343) then __O[2592] else __call(____type, "includes", "fart")) then
                                    puff(
                                        nil,
                                        c,
                                        -5,
                                        2,
                                        r,
                                        if __t(__call(____type, "includes", "smoke")) then "#aabed4" else "#9bcf47",
                                        if __t(__call(____type, "includes", "smoke")) then "#e9f3ff" else "#dffa79"
                                    )
                                    puff(
                                        nil,
                                        c,
                                        7,
                                        -5,
                                        r * 0.7,
                                        color,
                                        "#effac7"
                                    )
                                    rect(
                                        nil,
                                        c,
                                        -25,
                                        -5,
                                        9,
                                        4,
                                        color
                                    )
                                    rect(
                                        nil,
                                        c,
                                        -29,
                                        5,
                                        7,
                                        4,
                                        color
                                    )
                                else
                                    local ____t_350 = __t
                                    local ____t_349 = __t
                                    local ____t_347 = __t
                                    local ____call_result_346 = __call(____type, "includes", "goo")
                                    __O[2593] = ____call_result_346
                                    local ____temp_348 = if ____t_347(____call_result_346) then __O[2593] else __call(____type, "includes", "slime")
                                    __O[2594] = ____temp_348
                                    if ____t_350(if ____t_349(____temp_348) then __O[2594] else __call(____type, "includes", "catarro")) then
                                        c:rotate(angle)
                                        poly(
                                            nil,
                                            c,
                                            __arrL(
                                                {
                                                    __arrL({-r - 6, 0}, 2),
                                                    __arrL({-r, -r * 0.65}, 2),
                                                    __arrL({r * 0.4, -r}, 2),
                                                    __arrL({r, 0}, 2),
                                                    __arrL({r * 0.3, r}, 2),
                                                    __arrL({-r, r * 0.5}, 2)
                                                },
                                                6
                                            ),
                                            "#79974c"
                                        )
                                        rect(
                                            nil,
                                            c,
                                            -r * 0.3,
                                            -r * 0.4,
                                            r,
                                            r * 0.5,
                                            "#d2e693"
                                        )
                                    else
                                        local ____t_355 = __t
                                        local ____t_354 = __t
                                        local ____t_352 = __t
                                        local ____call_result_351 = __call(____type, "includes", "pencil")
                                        __O[2595] = ____call_result_351
                                        local ____temp_353 = if ____t_352(____call_result_351) then __O[2595] else __call(____type, "includes", "pen")
                                        __O[2596] = ____temp_353
                                        if ____t_355(if ____t_354(____temp_353) then __O[2596] else __call(____type, "includes", "ruler")) then
                                            c:rotate(angle)
                                            rect(
                                                nil,
                                                c,
                                                -19,
                                                -4,
                                                33,
                                                8,
                                                INK
                                            )
                                            rect(
                                                nil,
                                                c,
                                                -17,
                                                -3,
                                                29,
                                                6,
                                                "#dfbc6b"
                                            )
                                            rect(
                                                nil,
                                                c,
                                                -13,
                                                -2,
                                                23,
                                                2,
                                                "#fff0b6"
                                            )
                                            poly(
                                                nil,
                                                c,
                                                __arrL(
                                                    {
                                                        __arrL({12, -4}, 2),
                                                        __arrL({22, 0}, 2),
                                                        __arrL({12, 4}, 2)
                                                    },
                                                    3
                                                ),
                                                "#f2d69d"
                                            )
                                            rect(
                                                nil,
                                                c,
                                                19,
                                                -1,
                                                4,
                                                2,
                                                INK
                                            )
                                        else
                                            local ____t_358 = __t
                                            local ____t_357 = __t
                                            local ____call_result_356 = __call(____type, "includes", "cake")
                                            __O[2597] = ____call_result_356
                                            if ____t_358(if ____t_357(____call_result_356) then __O[2597] else __call(____type, "includes", "bolo")) then
                                                c:rotate(spin * 0.25)
                                                rect(
                                                    nil,
                                                    c,
                                                    -12,
                                                    -5,
                                                    24,
                                                    15,
                                                    "#ac7750"
                                                )
                                                rect(
                                                    nil,
                                                    c,
                                                    -13,
                                                    -8,
                                                    26,
                                                    6,
                                                    "#f4dfba"
                                                )
                                                rect(
                                                    nil,
                                                    c,
                                                    -8,
                                                    -13,
                                                    16,
                                                    5,
                                                    "#728d56"
                                                )
                                                rect(
                                                    nil,
                                                    c,
                                                    -7,
                                                    1,
                                                    4,
                                                    3,
                                                    "#e7c897"
                                                )
                                                rect(
                                                    nil,
                                                    c,
                                                    3,
                                                    1,
                                                    4,
                                                    3,
                                                    "#e7c897"
                                                )
                                            else
                                                local ____t_361 = __t
                                                local ____t_360 = __t
                                                local ____call_result_359 = __call(____type, "includes", "comb")
                                                __O[2598] = ____call_result_359
                                                if ____t_361(if ____t_360(____call_result_359) then __O[2598] else __call(____type, "includes", "pente")) then
                                                    c:rotate(spin)
                                                    rect(
                                                        nil,
                                                        c,
                                                        -18,
                                                        -5,
                                                        36,
                                                        7,
                                                        "#e3b77a"
                                                    )
                                                    do
                                                        local i = 0
                                                        while i < 8 do
                                                            rect(
                                                                nil,
                                                                c,
                                                                -17 + i * 5,
                                                                2,
                                                                3,
                                                                10,
                                                                INK
                                                            )
                                                            i = i + 1
                                                        end
                                                    end
                                                elseif ____type == "brush" then
                                                    c:rotate(spin)
                                                    rect(
                                                        nil,
                                                        c,
                                                        -18,
                                                        -3,
                                                        18,
                                                        6,
                                                        "#a8c8c0"
                                                    )
                                                    rect(
                                                        nil,
                                                        c,
                                                        -2,
                                                        -10,
                                                        23,
                                                        20,
                                                        "#805e4a"
                                                    )
                                                    rect(
                                                        nil,
                                                        c,
                                                        1,
                                                        -8,
                                                        17,
                                                        16,
                                                        "#d4b77a"
                                                    )
                                                    do
                                                        local i = 0
                                                        while i < 4 do
                                                            rect(
                                                                nil,
                                                                c,
                                                                1 + i * 5,
                                                                -13,
                                                                2,
                                                                6,
                                                                INK
                                                            )
                                                            i = i + 1
                                                        end
                                                    end
                                                else
                                                    local ____t_364 = __t
                                                    local ____t_363 = __t
                                                    local ____call_result_362 = __call(____type, "includes", "six")
                                                    __O[2599] = ____call_result_362
                                                    if ____t_364(if ____t_363(____call_result_362) then __O[2599] else ____type == "67") then
                                                        label(
                                                            nil,
                                                            c,
                                                            if __t(__mod(
                                                                math.floor(t * 12),
                                                                2
                                                            )) then "6" else "7",
                                                            0,
                                                            0,
                                                            26,
                                                            color
                                                        )
                                                        rect(
                                                            nil,
                                                            c,
                                                            -18,
                                                            15,
                                                            36,
                                                            2,
                                                            "#e9efb3"
                                                        )
                                                    else
                                                        local ____t_369 = __t
                                                        local ____t_368 = __t
                                                        local ____t_366 = __t
                                                        local ____call_result_365 = __call(____type, "includes", "bullet")
                                                        __O[2600] = ____call_result_365
                                                        local ____temp_367 = if ____t_366(____call_result_365) then __O[2600] else __call(____type, "includes", "spark")
                                                        __O[2601] = ____temp_367
                                                        if ____t_369(if ____t_368(____temp_367) then __O[2601] else __call(____type, "includes", "shot")) then
                                                            c:rotate(angle)
                                                            rect(
                                                                nil,
                                                                c,
                                                                -12,
                                                                -3,
                                                                23,
                                                                6,
                                                                "#e9bc75"
                                                            )
                                                            rect(
                                                                nil,
                                                                c,
                                                                -6,
                                                                -2,
                                                                15,
                                                                3,
                                                                "#fff2c8"
                                                            )
                                                            rect(
                                                                nil,
                                                                c,
                                                                -23,
                                                                -1,
                                                                8,
                                                                2,
                                                                color
                                                            )
                                                        else
                                                            local ____t_372 = __t
                                                            local ____t_371 = __t
                                                            local ____call_result_370 = __call(____type, "includes", "ribbon")
                                                            __O[2602] = ____call_result_370
                                                            if ____t_372(if ____t_371(____call_result_370) then __O[2602] else __call(____type, "includes", "rope")) then
                                                                line(
                                                                    nil,
                                                                    c,
                                                                    __arrL(
                                                                        {
                                                                            __arrL({-18, -3}, 2),
                                                                            __arrL(
                                                                                {
                                                                                    -8,
                                                                                    math.sin(t * 15) * 8
                                                                                },
                                                                                2
                                                                            ),
                                                                            __arrL({3, -5}, 2),
                                                                            __arrL({16, 2}, 2)
                                                                        },
                                                                        4
                                                                    ),
                                                                    color,
                                                                    5
                                                                )
                                                                line(
                                                                    nil,
                                                                    c,
                                                                    __arrL(
                                                                        {
                                                                            __arrL({-18, -4}, 2),
                                                                            __arrL(
                                                                                {
                                                                                    -8,
                                                                                    math.sin(t * 15) * 8 - 1
                                                                                },
                                                                                2
                                                                            ),
                                                                            __arrL({3, -6}, 2),
                                                                            __arrL({16, 1}, 2)
                                                                        },
                                                                        4
                                                                    ),
                                                                    "#fff0c5",
                                                                    1
                                                                )
                                                            else
                                                                local ____t_375 = __t
                                                                local ____t_374 = __t
                                                                local ____call_result_373 = __call(____type, "includes", "slap")
                                                                __O[2603] = ____call_result_373
                                                                if ____t_375(if ____t_374(____call_result_373) then __O[2603] else ____type == "palm") then
                                                                    glove(
                                                                        nil,
                                                                        c,
                                                                        0,
                                                                        0,
                                                                        color,
                                                                        angle - 0.2
                                                                    )
                                                                    do
                                                                        local i = 0
                                                                        while i < 3 do
                                                                            rect(
                                                                                nil,
                                                                                c,
                                                                                -7 + i * 5,
                                                                                -17,
                                                                                4,
                                                                                12,
                                                                                color
                                                                            )
                                                                            i = i + 1
                                                                        end
                                                                    end
                                                                else
                                                                    local ____t_380 = __t
                                                                    local ____t_379 = __t
                                                                    local ____t_377 = __t
                                                                    local ____call_result_376 = __call(____type, "includes", "ink")
                                                                    __O[2604] = ____call_result_376
                                                                    local ____temp_378 = if ____t_377(____call_result_376) then __O[2604] else __call(____type, "includes", "drawing")
                                                                    __O[2605] = ____temp_378
                                                                    if ____t_380(if ____t_379(____temp_378) then __O[2605] else __call(____type, "includes", "brainrot")) then
                                                                        local n = __mod(
                                                                            math.floor(age * 8),
                                                                            3
                                                                        )
                                                                        local variant = tostring(if __t(s.variant) then s.variant else "")
                                                                        if variant == "spindle" then
                                                                            poly(
                                                                                nil,
                                                                                c,
                                                                                __arrL(
                                                                                    {
                                                                                        __arrL({-4, -r - 8}, 2),
                                                                                        __arrL({4, -r - 8}, 2),
                                                                                        __arrL({r * 0.6, r * 0.5}, 2),
                                                                                        __arrL({-r * 0.6, r * 0.5}, 2)
                                                                                    },
                                                                                    4
                                                                                ),
                                                                                color
                                                                            )
                                                                            line(
                                                                                nil,
                                                                                c,
                                                                                __arrL(
                                                                                    {
                                                                                        __arrL({-3, 6}, 2),
                                                                                        __arrL({-8, 17}, 2),
                                                                                        __arrL({-13, 18}, 2)
                                                                                    },
                                                                                    3
                                                                                ),
                                                                                INK,
                                                                                3
                                                                            )
                                                                            line(
                                                                                nil,
                                                                                c,
                                                                                __arrL(
                                                                                    {
                                                                                        __arrL({3, 6}, 2),
                                                                                        __arrL({9, 15}, 2),
                                                                                        __arrL({14, 15}, 2)
                                                                                    },
                                                                                    3
                                                                                ),
                                                                                INK,
                                                                                3
                                                                            )
                                                                        elseif variant == "pasta" then
                                                                            do
                                                                                local i = 0
                                                                                while i < 3 do
                                                                                    local xx = (i - 1) * 7
                                                                                    line(
                                                                                        nil,
                                                                                        c,
                                                                                        __arrL(
                                                                                            {
                                                                                                __arrL({xx, -r}, 2),
                                                                                                __arrL({xx - 3, -4}, 2),
                                                                                                __arrL({xx + 3, 5}, 2),
                                                                                                __arrL({xx, 15 + n}, 2)
                                                                                            },
                                                                                            4
                                                                                        ),
                                                                                        INK,
                                                                                        6
                                                                                    )
                                                                                    line(
                                                                                        nil,
                                                                                        c,
                                                                                        __arrL(
                                                                                            {
                                                                                                __arrL({xx, -r}, 2),
                                                                                                __arrL({xx - 3, -4}, 2),
                                                                                                __arrL({xx + 3, 5}, 2),
                                                                                                __arrL({xx, 15 + n}, 2)
                                                                                            },
                                                                                            4
                                                                                        ),
                                                                                        if __t(__mod(i, 2)) then "#f2d1a0" else color,
                                                                                        3
                                                                                    )
                                                                                    i = i + 1
                                                                                end
                                                                            end
                                                                        else
                                                                            poly(
                                                                                nil,
                                                                                c,
                                                                                __arrL(
                                                                                    {
                                                                                        __arrL({-r, -r}, 2),
                                                                                        __arrL({r * 0.2, -r - 4}, 2),
                                                                                        __arrL({r, r * 0.2}, 2),
                                                                                        __arrL({r * 0.5, r}, 2),
                                                                                        __arrL({-r * 0.7, r * 0.7}, 2)
                                                                                    },
                                                                                    5
                                                                                ),
                                                                                color
                                                                            )
                                                                            if variant == "ink" then
                                                                                do
                                                                                    local i = 0
                                                                                    while i < 3 do
                                                                                        rect(
                                                                                            nil,
                                                                                            c,
                                                                                            -r - 3 + i * 9,
                                                                                            r - 3 + __mod(i, 2) * 4,
                                                                                            4,
                                                                                            6,
                                                                                            color
                                                                                        )
                                                                                        i = i + 1
                                                                                    end
                                                                                end
                                                                            end
                                                                        end
                                                                        rect(
                                                                            nil,
                                                                            c,
                                                                            -7,
                                                                            -5,
                                                                            5,
                                                                            7,
                                                                            "#fff2d2"
                                                                        )
                                                                        rect(
                                                                            nil,
                                                                            c,
                                                                            3,
                                                                            -5,
                                                                            5,
                                                                            7,
                                                                            "#fff2d2"
                                                                        )
                                                                        rect(
                                                                            nil,
                                                                            c,
                                                                            -5,
                                                                            -3,
                                                                            2,
                                                                            4,
                                                                            INK
                                                                        )
                                                                        rect(
                                                                            nil,
                                                                            c,
                                                                            5,
                                                                            -3,
                                                                            2,
                                                                            4,
                                                                            INK
                                                                        )
                                                                        rect(
                                                                            nil,
                                                                            c,
                                                                            -4,
                                                                            7,
                                                                            10,
                                                                            2,
                                                                            INK
                                                                        )
                                                                        do
                                                                            local i = 0
                                                                            while i < 3 do
                                                                                rect(
                                                                                    nil,
                                                                                    c,
                                                                                    -r - 6 + i * 7,
                                                                                    -r - 7 - n,
                                                                                    4,
                                                                                    2,
                                                                                    color
                                                                                )
                                                                                i = i + 1
                                                                            end
                                                                        end
                                                                    else
                                                                        c:rotate(spin)
                                                                        poly(
                                                                            nil,
                                                                            c,
                                                                            __arrL(
                                                                                {
                                                                                    __arrL({-r, -r * 0.65}, 2),
                                                                                    __arrL({r * 0.4, -r}, 2),
                                                                                    __arrL({r, r * 0.2}, 2),
                                                                                    __arrL({r * 0.5, r}, 2),
                                                                                    __arrL({-r, r * 0.7}, 2)
                                                                                },
                                                                                5
                                                                            ),
                                                                            "#eaf0d6"
                                                                        )
                                                                        rect(
                                                                            nil,
                                                                            c,
                                                                            -4,
                                                                            -3,
                                                                            8,
                                                                            3,
                                                                            color
                                                                        )
                                                                        rect(
                                                                            nil,
                                                                            c,
                                                                            -6,
                                                                            4,
                                                                            9,
                                                                            2,
                                                                            "#b3bba7"
                                                                        )
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        c:restore()
    end
    local function sewer(self, c, x, y, amount)
        if amount == nil then
            amount = 1
        end
        c:save()
        c:translate(x, y)
        local lift = clamp(nil, amount, 0, 1)
        rect(
            nil,
            c,
            -37,
            -10,
            74,
            25,
            "#584b45"
        )
        rect(
            nil,
            c,
            -33,
            -7,
            66,
            21,
            "#c47842"
        )
        rect(
            nil,
            c,
            -27,
            -4,
            54,
            17,
            "#172d40"
        )
        do
            local i = 0
            while i < 5 do
                rect(
                    nil,
                    c,
                    -23 + i * 10,
                    -2,
                    5,
                    13,
                    "#5686a5"
                )
                i = i + 1
            end
        end
        c:save()
        c:translate(-31, -7)
        c:rotate(-lift * 0.9)
        rect(
            nil,
            c,
            0,
            -9,
            64,
            10,
            "#263f59"
        )
        rect(
            nil,
            c,
            3,
            -7,
            58,
            4,
            "#8ba8bd"
        )
        do
            local i = 0
            while i < 5 do
                rect(
                    nil,
                    c,
                    7 + i * 10,
                    -6,
                    4,
                    5,
                    "#35536a"
                )
                i = i + 1
            end
        end
        c:restore()
        do
            local i = 0
            while i < 3 do
                rect(
                    nil,
                    c,
                    -39 + i * 28,
                    15,
                    23,
                    4,
                    "#f3bb71"
                )
                i = i + 1
            end
        end
        c:restore()
    end
    local function contactImpact(self, c, progress, radius, color, angle)
        if angle == nil then
            angle = 0
        end
        local burst = smooth(nil, 0, 0.09, progress) * (1 - smooth(nil, 0.11, 0.62, progress))
        local r = math.min(
            24,
            math.max(10, radius * 0.6)
        ) * (0.55 + burst * 0.45)
        c:save()
        c:rotate(angle)
        if __lt(progress, 0.62) then
            poly(
                nil,
                c,
                __arrL(
                    {
                        __arrL({-r, -2}, 2),
                        __arrL({-r * 0.34, -r * 0.22}, 2),
                        __arrL({-r * 0.2, -r * 0.8}, 2),
                        __arrL({2, -r * 0.31}, 2),
                        __arrL({r * 0.78, -r * 0.6}, 2),
                        __arrL({r * 0.55, -2}, 2),
                        __arrL({r, 2}, 2),
                        __arrL({r * 0.3, r * 0.18}, 2),
                        __arrL({r * 0.48, r * 0.75}, 2),
                        __arrL({0, r * 0.35}, 2),
                        __arrL({-r * 0.58, r * 0.64}, 2),
                        __arrL({-r * 0.32, 2}, 2)
                    },
                    12
                ),
                INK
            )
            poly(
                nil,
                c,
                __arrL(
                    {
                        __arrL({-r + 3, -1}, 2),
                        __arrL({-r * 0.2, -r * 0.1}, 2),
                        __arrL({-r * 0.1, -r * 0.5}, 2),
                        __arrL({2, -r * 0.14}, 2),
                        __arrL({r * 0.45, -r * 0.28}, 2),
                        __arrL({r * 0.3, 0}, 2),
                        __arrL({r - 4, 2}, 2),
                        __arrL({r * 0.12, r * 0.06}, 2),
                        __arrL({r * 0.2, r * 0.4}, 2),
                        __arrL({0, r * 0.18}, 2),
                        __arrL({-r * 0.3, r * 0.28}, 2),
                        __arrL({-r * 0.1, 1}, 2)
                    },
                    12
                ),
                color
            )
            rect(
                nil,
                c,
                -2,
                -2,
                5,
                5,
                "#fff8db"
            )
        end
        local distance = 8 + progress * 30
        local size = math.max(
            1,
            math.floor(4 * (1 - progress) + 0.5)
        )
        do
            local i = 0
            while i < 4 do
                local a = -0.9 + i * 0.6
                local x = math.cos(a) * distance
                local y = math.sin(a) * distance * 0.75
                rect(
                    nil,
                    c,
                    x,
                    y,
                    size + 2,
                    size,
                    if __t(__mod(i, 2)) then color else "#fff0bf"
                )
                i = i + 1
            end
        end
        c:restore()
    end
    local function drawEffect(self, c, e, time)
        if time == nil then
            time = 0
        end
        if not __t(e) then
            return
        end
        local ____t_382 = __t
        local ____TS__Number_result_381 = __TS__Number(time)
        __O[2606] = ____TS__Number_result_381
        local t = if ____t_382(____TS__Number_result_381) then __O[2606] else 0
        local ____type = tostring(if __t(e.type) then e.type else "")
        local shape = tostring(if __t(e.shape) then e.shape else "")
        local ____t_386 = __t
        local ____t_384 = __t
        local ____TS__Number_result_383 = __TS__Number(e.maxLife)
        __O[2607] = ____TS__Number_result_383
        local ____temp_385 = if ____t_384(____TS__Number_result_383) then __O[2607] else __TS__Number(e.duration)
        __O[2608] = ____temp_385
        local max = math.max(0.001, if ____t_386(____temp_385) then __O[2608] else 0.45)
        local life = __TS__Number(e.life)
        local progress = if __isFiniteN(e.progress) then clamp(nil, e.progress, 0, 1) else if __isFiniteN(life) then 1 - clamp(nil, life / max, 0, 1) else 0.4
        local color = if __t(e.color) then e.color else "#ffca3d"
        c:save()
        c.imageSmoothingEnabled = false
        local ____c_392 = c
        local ____c_translate_393 = c.translate
        local ____t_388 = __t
        local ____TS__Number_result_387 = __TS__Number(e.x)
        __O[2609] = ____TS__Number_result_387
        local ____math_floor_result_391 = math.floor(if ____t_388(____TS__Number_result_387) then __O[2609] else 0 + 0.5)
        local ____t_390 = __t
        local ____TS__Number_result_389 = __TS__Number(e.y)
        __O[2610] = ____TS__Number_result_389
        ____c_translate_393(
            ____c_392,
            ____math_floor_result_391,
            math.floor(if ____t_390(____TS__Number_result_389) then __O[2610] else 0 + 0.5)
        )
        local face = if __lt(e.facing, 0) then -1 else 1
        local ____t_396 = __t
        local ____t_395 = __t
        local ____call_result_394 = __call(shape, "includes", "upper")
        __O[2611] = ____call_result_394
        local ____t_399 = __t
        local ____t_398 = __t
        local ____call_result_397 = __call(shape, "includes", "-low")
        __O[2612] = ____call_result_397
        local angle = if ____t_396(if ____t_395(____call_result_394) then __O[2611] else __call(shape, "includes", "-up")) then -math.pi / 2 else if ____t_399(if ____t_398(____call_result_397) then __O[2612] else __call(shape, "includes", "-down")) then math.pi / 2 else if face < 0 then math.pi else 0
        local ____t_404 = __t
        local ____t_403 = __t
        local ____t_401 = __t
        local ____call_result_400 = __call(shape, "includes", "sewer")
        __O[2613] = ____call_result_400
        local ____temp_402 = if ____t_401(____call_result_400) then __O[2613] else __call(shape, "includes", "burrow")
        __O[2614] = ____temp_402
        if ____t_404(if ____t_403(____temp_402) then __O[2614] else ____type == "sewer") then
            sewer(
                nil,
                c,
                0,
                0,
                math.sin(progress * math.pi)
            )
            do
                local i = 0
                while i < 5 do
                    local xx = (i - 2) * (9 + progress * 5)
                    local yy = -8 - math.sin(progress * math.pi) * (10 + __mod(i, 2) * 8)
                    rect(
                        nil,
                        c,
                        xx,
                        yy,
                        7,
                        5,
                        if __t(__mod(i, 2)) then "#d18d51" else "#a9cbe0"
                    )
                    i = i + 1
                end
            end
        else
            local ____t_407 = __t
            local ____t_406 = __t
            local ____call_result_405 = __call(shape, "includes", "army")
            __O[2615] = ____call_result_405
            if ____t_407(if ____t_406(____call_result_405) then __O[2615] else ____type == "army") then
                do
                    local i = 0
                    while i < 4 do
                        local x = (i - 1.5) * 29
                        local y = math.sin(progress * math.pi) * -4
                        local ____opt_410 = window.Art
                        if ____opt_410 ~= nil then
                            ____opt_410 = ____opt_410.drawCharacter
                        end
                        if ____opt_410 ~= nil then
                            ____opt_410(
                                ____opt_410,
                                c,
                                "reeis",
                                x,
                                y,
                                {
                                    frame = t + i,
                                    facing = if i < 2 then 1 else -1,
                                    scale = 0.62,
                                    grounded = true,
                                    attack = true,
                                    attackType = "gun",
                                    attackProgress = progress
                                }
                            )
                        end
                        rect(
                            nil,
                            c,
                            x + if i < 2 then 17 else -27,
                            y - 27,
                            12,
                            4,
                            "#ffdf48"
                        )
                        i = i + 1
                    end
                end
                label(
                    nil,
                    c,
                    "O EXÉRCITO CHEGOU!",
                    0,
                    -69,
                    10,
                    color
                )
            else
                local ____t_414 = __t
                local ____t_413 = __t
                local ____call_result_412 = __call(shape, "includes", "rats")
                __O[2616] = ____call_result_412
                if ____t_414(if ____t_413(____call_result_412) then __O[2616] else ____type == "rats") then
                    do
                        local i = 0
                        while i < 5 do
                            local ____opt_417 = window.Art
                            if ____opt_417 ~= nil then
                                ____opt_417 = ____opt_417.drawRat
                            end
                            if ____opt_417 ~= nil then
                                ____opt_417(
                                    ____opt_417,
                                    c,
                                    (i - 2) * 20,
                                    math.sin(progress * math.pi) * -5,
                                    t + i,
                                    {scale = 0.65, facing = if __t(__mod(i, 2)) then 1 else -1}
                                )
                            end
                            i = i + 1
                        end
                    end
                elseif __t(__call(shape, "includes", "belly")) then
                    local rebound = math.sin(progress * math.pi)
                    impact(
                        nil,
                        c,
                        face * (7 + rebound * 14),
                        -24,
                        17 + rebound * 3,
                        "#ffe251",
                        progress
                    )
                    do
                        local i = 0
                        while i < 3 do
                            rect(
                                nil,
                                c,
                                -23 - i * 9,
                                -39 + __mod(i, 2) * 16,
                                7,
                                4,
                                "#43aeed"
                            )
                            rect(
                                nil,
                                c,
                                30 + i * 9,
                                -30 + __mod(i, 2) * 11,
                                6,
                                4,
                                "#8edfff"
                            )
                            i = i + 1
                        end
                    end
                    label(
                        nil,
                        c,
                        "REBATE!",
                        0,
                        -62,
                        11,
                        "#fff0b0"
                    )
                elseif __t(__call(shape, "includes", "knee")) then
                    impact(
                        nil,
                        c,
                        face * 9,
                        -26,
                        19,
                        "#ffdc60",
                        progress
                    )
                    do
                        local i = 0
                        while i < 3 do
                            rect(
                                nil,
                                c,
                                -25 - i * 8,
                                -22 + i * 7,
                                6,
                                4,
                                if __t(__mod(i, 2)) then "#fff0bc" else color
                            )
                            i = i + 1
                        end
                    end
                    label(
                        nil,
                        c,
                        "BIURIFUL!",
                        0,
                        -69,
                        14,
                        color
                    )
                else
                    local ____t_421 = __t
                    local ____t_420 = __t
                    local ____call_result_419 = __call(shape, "includes", "football")
                    __O[2617] = ____call_result_419
                    if ____t_421(if ____t_420(____call_result_419) then __O[2617] else __call(shape, "includes", "juggle")) then
                        local ____t_423 = __t
                        local ____call_result_422 = __call(shape, "includes", "lift")
                        __O[2618] = ____call_result_422
                        local lift = if ____t_423(____call_result_422) then __O[2618] else __call(shape, "includes", "juggle")
                        local yy = -12 - if __t(lift) then math.sin(progress * math.pi) * 40 else 0
                        ball(
                            nil,
                            c,
                            math.sin(progress * math.pi) * 17,
                            yy,
                            t * 12,
                            1.1
                        )
                        do
                            local i = 0
                            while i < 4 do
                                rect(
                                    nil,
                                    c,
                                    -18 - i * 7,
                                    yy - 2 + __mod(i, 2) * 6,
                                    5,
                                    4,
                                    if __t(__mod(i, 2)) then "#fff4b3" else "#55b6f0"
                                )
                                i = i + 1
                            end
                        end
                        if __t(__call(shape, "includes", "bicycle")) then
                            label(
                                nil,
                                c,
                                "GOLAÇO!",
                                0,
                                -65,
                                12,
                                color
                            )
                        end
                    elseif __t(__call(shape, "includes", "gas-burst")) then
                        do
                            local i = 0
                            while i < 3 do
                                puff(
                                    nil,
                                    c,
                                    (i - 1) * (17 + progress * 15),
                                    -8 - math.sin(progress * math.pi) * if __t(__mod(i, 2)) then 18 else 4,
                                    20 - i * 2,
                                    if __t(__mod(i, 2)) then "#b0d546" else "#7fb937",
                                    "#eeff9d"
                                )
                                i = i + 1
                            end
                        end
                        rect(
                            nil,
                            c,
                            -6,
                            -9,
                            6,
                            5,
                            "#fbffd2"
                        )
                    else
                        local ____t_426 = __t
                        local ____t_425 = __t
                        local ____call_result_424 = __call(shape, "includes", "tongue")
                        __O[2619] = ____call_result_424
                        if ____t_426(if ____t_425(____call_result_424) then __O[2619] else __call(shape, "includes", "frog-upper")) then
                            do
                                local i = 0
                                while i < 3 do
                                    local yy = -10 - i * 13
                                    line(
                                        nil,
                                        c,
                                        __arrL(
                                            {
                                                __arrL({-22, yy + 5}, 2),
                                                __arrL({-22, yy - 4}, 2),
                                                __arrL({20, yy - 4}, 2),
                                                __arrL({24, yy + 3}, 2),
                                                __arrL({17, yy + 6}, 2),
                                                __arrL({-16, yy + 6}, 2)
                                            },
                                            6
                                        ),
                                        "#9d4e6e",
                                        7
                                    )
                                    line(
                                        nil,
                                        c,
                                        __arrL(
                                            {
                                                __arrL({-20, yy + 3}, 2),
                                                __arrL({-20, yy - 3}, 2),
                                                __arrL({18, yy - 3}, 2),
                                                __arrL({20, yy + 2}, 2)
                                            },
                                            4
                                        ),
                                        "#f395b2",
                                        3
                                    )
                                    i = i + 1
                                end
                            end
                            if __t(__call(shape, "includes", "upper")) then
                                impact(
                                    nil,
                                    c,
                                    10,
                                    -44,
                                    18,
                                    "#ffed7d",
                                    progress
                                )
                            end
                        elseif __t(__call(shape, "includes", "rat-")) then
                            do
                                local i = 0
                                while i < 3 do
                                    local ____opt_429 = window.Art
                                    if ____opt_429 ~= nil then
                                        ____opt_429 = ____opt_429.drawRat
                                    end
                                    if ____opt_429 ~= nil then
                                        ____opt_429(
                                            ____opt_429,
                                            c,
                                            (i - 1) * 24,
                                            -progress * 16,
                                            t + i,
                                            {scale = 0.65, facing = if __t(__mod(i, 2)) then -1 else 1}
                                        )
                                    end
                                    i = i + 1
                                end
                            end
                            label(
                                nil,
                                c,
                                "POUDII!",
                                0,
                                -43,
                                11,
                                color
                            )
                        else
                            local ____t_433 = __t
                            local ____t_432 = __t
                            local ____call_result_431 = __call(shape, "includes", "slime")
                            __O[2620] = ____call_result_431
                            if ____t_433(if ____t_432(____call_result_431) then __O[2620] else __call(shape, "includes", "nose")) then
                                do
                                    local i = 0
                                    while i < 4 do
                                        local a = i * 2.1
                                        drawProjectile(
                                            nil,
                                            c,
                                            {
                                                x = math.cos(a) * progress * 40,
                                                y = math.sin(a) * progress * 33,
                                                type = "goo",
                                                vx = math.cos(a),
                                                vy = math.sin(a),
                                                r = 9,
                                                color = color
                                            },
                                            t
                                        )
                                        i = i + 1
                                    end
                                end
                                if __t(__call(shape, "includes", "nose")) then
                                    pixelOval(
                                        nil,
                                        c,
                                        0,
                                        -15,
                                        19,
                                        14,
                                        "#e2b286"
                                    )
                                    rect(
                                        nil,
                                        c,
                                        -7,
                                        -21,
                                        8,
                                        4,
                                        "#ffdbad"
                                    )
                                end
                            elseif __t(__call(shape, "includes", "sketch-cage")) then
                                local h = 28 + math.sin(progress * math.pi) * 24
                                rect(
                                    nil,
                                    c,
                                    -31,
                                    -h,
                                    62,
                                    h + 8,
                                    "#171f39"
                                )
                                rect(
                                    nil,
                                    c,
                                    -27,
                                    -h + 4,
                                    54,
                                    h,
                                    "#f3ddbb"
                                )
                                do
                                    local i = 0
                                    while i < 5 do
                                        rect(
                                            nil,
                                            c,
                                            -24 + i * 11,
                                            -h + 5,
                                            4,
                                            h - 3,
                                            "#51354e"
                                        )
                                        i = i + 1
                                    end
                                end
                                rect(
                                    nil,
                                    c,
                                    -31,
                                    -h,
                                    62,
                                    5,
                                    "#f74850"
                                )
                                rect(
                                    nil,
                                    c,
                                    -31,
                                    3,
                                    62,
                                    5,
                                    "#f74850"
                                )
                                do
                                    local i = 0
                                    while i < 3 do
                                        rect(
                                            nil,
                                            c,
                                            35 + i * 8,
                                            -h + 12 + i * 7,
                                            6,
                                            4,
                                            "#ffd044"
                                        )
                                        i = i + 1
                                    end
                                end
                            else
                                local ____t_442 = __t
                                local ____t_441 = __t
                                local ____t_439 = __t
                                local ____t_437 = __t
                                local ____t_435 = __t
                                local ____call_result_434 = __call(shape, "includes", "brainrot")
                                __O[2621] = ____call_result_434
                                local ____temp_436 = if ____t_435(____call_result_434) then __O[2621] else __call(shape, "includes", "sketch")
                                __O[2622] = ____temp_436
                                local ____temp_438 = if ____t_437(____temp_436) then __O[2622] else __call(shape, "includes", "sixseven")
                                __O[2623] = ____temp_438
                                local ____temp_440 = if ____t_439(____temp_438) then __O[2623] else __call(shape, "includes", "seven-smash")
                                __O[2624] = ____temp_440
                                if ____t_442(if ____t_441(____temp_440) then __O[2624] else __call(shape, "includes", "six-fist")) then
                                    local ____t_444 = __t
                                    local ____call_result_443 = __call(shape, "includes", "seven")
                                    __O[2625] = ____call_result_443
                                    local six = if ____t_444(____call_result_443) then __O[2625] else __call(shape, "includes", "six")
                                    if __t(six) then
                                        label(
                                            nil,
                                            c,
                                            if __t(__call(shape, "includes", "seven")) then "67" else "6",
                                            0,
                                            -10,
                                            35,
                                            color
                                        )
                                    else
                                        local ____t_447 = __t
                                        local ____opt_445 = window.Art
                                        if ____opt_445 ~= nil then
                                            ____opt_445 = ____opt_445.drawMinion
                                        end
                                        if ____t_447(____opt_445) then
                                            window.Art:drawMinion(
                                                c,
                                                0,
                                                0,
                                                1,
                                                t,
                                                {design = "brainrot", variant = "brainrot", facing = 1}
                                            )
                                        else
                                            label(
                                                nil,
                                                c,
                                                "RABISCO!",
                                                0,
                                                -12,
                                                14,
                                                color
                                            )
                                        end
                                    end
                                    do
                                        local i = 0
                                        while i < 5 do
                                            rect(
                                                nil,
                                                c,
                                                math.cos(i * 2) * 34 * progress,
                                                -15 + math.sin(i * 2) * 30 * progress,
                                                5,
                                                8,
                                                color
                                            )
                                            i = i + 1
                                        end
                                    end
                                else
                                    local ____t_450 = __t
                                    local ____t_449 = __t
                                    local ____call_result_448 = __call(shape, "includes", "iraci")
                                    __O[2626] = ____call_result_448
                                    if ____t_450(if ____t_449(____call_result_448) then __O[2626] else __call(shape, "includes", "confiscate")) then
                                        c:save()
                                        c:rotate(-0.12)
                                        rect(
                                            nil,
                                            c,
                                            -43,
                                            -22,
                                            86,
                                            32,
                                            "#ffe4a4"
                                        )
                                        rect(
                                            nil,
                                            c,
                                            -40,
                                            -19,
                                            80,
                                            26,
                                            "#f4bd59"
                                        )
                                        label(
                                            nil,
                                            c,
                                            if __t(__call(shape, "includes", "iraci")) then "IRACI!" else "CONFISCADO",
                                            0,
                                            -5,
                                            12,
                                            "#ae332e"
                                        )
                                        c:restore()
                                    else
                                        local ____t_453 = __t
                                        local ____t_452 = __t
                                        local ____call_result_451 = __call(shape, "includes", "smoke")
                                        __O[2627] = ____call_result_451
                                        if ____t_453(if ____t_452(____call_result_451) then __O[2627] else __call(shape, "includes", "braces")) then
                                            do
                                                local i = 0
                                                while i < 3 do
                                                    puff(
                                                        nil,
                                                        c,
                                                        (i - 1) * (15 + progress * 10),
                                                        -12 - __mod(i, 2) * 17,
                                                        20,
                                                        if __t(__mod(i, 2)) then "#a2b9d0" else "#c6daed",
                                                        "#f0faff"
                                                    )
                                                    i = i + 1
                                                end
                                            end
                                            if __t(__call(shape, "includes", "braces")) then
                                                rect(
                                                    nil,
                                                    c,
                                                    -24,
                                                    -21,
                                                    48,
                                                    21,
                                                    INK
                                                )
                                                rect(
                                                    nil,
                                                    c,
                                                    -21,
                                                    -18,
                                                    42,
                                                    15,
                                                    "#ffffff"
                                                )
                                                do
                                                    local i = 0
                                                    while i < 6 do
                                                        rect(
                                                            nil,
                                                            c,
                                                            -18 + i * 7,
                                                            -16,
                                                            4,
                                                            10,
                                                            "#789cbb"
                                                        )
                                                        i = i + 1
                                                    end
                                                end
                                                rect(
                                                    nil,
                                                    c,
                                                    -21,
                                                    -11,
                                                    42,
                                                    3,
                                                    "#324d68"
                                                )
                                            end
                                        else
                                            local ____t_458 = __t
                                            local ____t_457 = __t
                                            local ____t_455 = __t
                                            local ____call_result_454 = __call(shape, "includes", "divine")
                                            __O[2628] = ____call_result_454
                                            local ____temp_456 = if ____t_455(____call_result_454) then __O[2628] else __call(shape, "includes", "aura-")
                                            __O[2629] = ____temp_456
                                            if ____t_458(if ____t_457(____temp_456) then __O[2629] else __call(shape, "includes", "protagonist")) then
                                                poly(
                                                    nil,
                                                    c,
                                                    __arrL(
                                                        {
                                                            __arrL({-8, -12}, 2),
                                                            __arrL({-3, -43}, 2),
                                                            __arrL({4, -43}, 2),
                                                            __arrL({8, -12}, 2),
                                                            __arrL({31, -8}, 2),
                                                            __arrL({31, -2}, 2),
                                                            __arrL({8, 3}, 2),
                                                            __arrL({4, 28}, 2),
                                                            __arrL({-3, 28}, 2),
                                                            __arrL({-8, 3}, 2),
                                                            __arrL({-31, -2}, 2),
                                                            __arrL({-31, -8}, 2)
                                                        },
                                                        12
                                                    ),
                                                    "#ffe356"
                                                )
                                                poly(
                                                    nil,
                                                    c,
                                                    __arrL(
                                                        {
                                                            __arrL({-4, -8}, 2),
                                                            __arrL({0, -28}, 2),
                                                            __arrL({4, -8}, 2),
                                                            __arrL({18, -4}, 2),
                                                            __arrL({4, 0}, 2),
                                                            __arrL({0, 16}, 2),
                                                            __arrL({-4, 0}, 2),
                                                            __arrL({-18, -4}, 2)
                                                        },
                                                        8
                                                    ),
                                                    "#fff9c6"
                                                )
                                                do
                                                    local i = 0
                                                    while i < 4 do
                                                        rect(
                                                            nil,
                                                            c,
                                                            -36 + i * 23,
                                                            -44 + __mod(i, 2) * 70,
                                                            5,
                                                            8,
                                                            "#fff2a6"
                                                        )
                                                        i = i + 1
                                                    end
                                                end
                                            else
                                                local ____t_461 = __t
                                                local ____t_460 = __t
                                                local ____call_result_459 = __call(shape, "includes", "palm")
                                                __O[2630] = ____call_result_459
                                                if ____t_461(if ____t_460(____call_result_459) then __O[2630] else __call(shape, "includes", "slap")) then
                                                    c:save()
                                                    c:scale(if __t(__call(shape, "includes", "giant")) then 1.55 else 1, if __t(__call(shape, "includes", "giant")) then 1.55 else 1)
                                                    glove(
                                                        nil,
                                                        c,
                                                        0,
                                                        -9,
                                                        color,
                                                        -0.15
                                                    )
                                                    do
                                                        local i = 0
                                                        while i < 4 do
                                                            rect(
                                                                nil,
                                                                c,
                                                                -8 + i * 5,
                                                                -30,
                                                                4,
                                                                16,
                                                                color
                                                            )
                                                            i = i + 1
                                                        end
                                                    end
                                                    c:restore()
                                                    if progress > 0.3 then
                                                        impact(
                                                            nil,
                                                            c,
                                                            23,
                                                            -10,
                                                            14,
                                                            "#ffdd6b",
                                                            progress
                                                        )
                                                    end
                                                else
                                                    local ____t_464 = __t
                                                    local ____t_463 = __t
                                                    local ____call_result_462 = __call(shape, "includes", "wall-")
                                                    __O[2631] = ____call_result_462
                                                    if ____t_464(if ____t_463(____call_result_462) then __O[2631] else __call(shape, "includes", "monologue-wall")) then
                                                        rect(
                                                            nil,
                                                            c,
                                                            -31,
                                                            -51,
                                                            62,
                                                            57,
                                                            "#e8d1a3"
                                                        )
                                                        do
                                                            local i = 0
                                                            while i < 5 do
                                                                rect(
                                                                    nil,
                                                                    c,
                                                                    -31,
                                                                    -48 + i * 11,
                                                                    62,
                                                                    2,
                                                                    "#b17a4a"
                                                                )
                                                                do
                                                                    local j = 0
                                                                    while j < 3 do
                                                                        rect(
                                                                            nil,
                                                                            c,
                                                                            -24 + j * 25 + if __t(__mod(i, 2)) then 10 else 0,
                                                                            -47 + i * 11,
                                                                            2,
                                                                            9,
                                                                            "#b17a4a"
                                                                        )
                                                                        j = j + 1
                                                                    end
                                                                end
                                                                i = i + 1
                                                            end
                                                        end
                                                        rect(
                                                            nil,
                                                            c,
                                                            -25,
                                                            -35,
                                                            50,
                                                            20,
                                                            "#275f9b"
                                                        )
                                                        label(
                                                            nil,
                                                            c,
                                                            "BLÁ BLÁ",
                                                            0,
                                                            -24,
                                                            11,
                                                            "#fff3bd"
                                                        )
                                                    elseif __t(__call(shape, "includes", "bald")) then
                                                        pixelOval(
                                                            nil,
                                                            c,
                                                            0,
                                                            -23,
                                                            22,
                                                            18,
                                                            "#e9b581"
                                                        )
                                                        rect(
                                                            nil,
                                                            c,
                                                            -10,
                                                            -31,
                                                            13,
                                                            5,
                                                            "#fff8c6"
                                                        )
                                                        impact(
                                                            nil,
                                                            c,
                                                            -8,
                                                            -31,
                                                            13,
                                                            "#fff28c",
                                                            progress
                                                        )
                                                    else
                                                        local ____t_467 = __t
                                                        local ____t_466 = __t
                                                        local ____call_result_465 = __call(shape, "includes", "beard")
                                                        __O[2632] = ____call_result_465
                                                        if ____t_467(if ____t_466(____call_result_465) then __O[2632] else __call(shape, "includes", "english")) then
                                                            rect(
                                                                nil,
                                                                c,
                                                                -42,
                                                                -23,
                                                                84,
                                                                30,
                                                                "#173f7a"
                                                            )
                                                            rect(
                                                                nil,
                                                                c,
                                                                -39,
                                                                -20,
                                                                78,
                                                                24,
                                                                "#5ab5ea"
                                                            )
                                                            label(
                                                                nil,
                                                                c,
                                                                "ALLRIGHT!",
                                                                0,
                                                                -8,
                                                                13,
                                                                "#fff0bf"
                                                            )
                                                            if __t(__call(shape, "includes", "beard")) then
                                                                poly(
                                                                    nil,
                                                                    c,
                                                                    __arrL(
                                                                        {
                                                                            __arrL({-17, -36}, 2),
                                                                            __arrL({-13, -17}, 2),
                                                                            __arrL({0, -9}, 2),
                                                                            __arrL({15, -18}, 2),
                                                                            __arrL({19, -36}, 2)
                                                                        },
                                                                        5
                                                                    ),
                                                                    "#b76a42"
                                                                )
                                                            end
                                                        elseif __t(__call(shape, "includes", "barber")) then
                                                            rect(
                                                                nil,
                                                                c,
                                                                -24,
                                                                -37,
                                                                48,
                                                                33,
                                                                "#4f91c2"
                                                            )
                                                            rect(
                                                                nil,
                                                                c,
                                                                -27,
                                                                -7,
                                                                54,
                                                                11,
                                                                "#a8d9ef"
                                                            )
                                                            rect(
                                                                nil,
                                                                c,
                                                                -17,
                                                                -42,
                                                                35,
                                                                10,
                                                                "#253d47"
                                                            )
                                                            rect(
                                                                nil,
                                                                c,
                                                                -5,
                                                                4,
                                                                10,
                                                                21,
                                                                "#4c6768"
                                                            )
                                                            rect(
                                                                nil,
                                                                c,
                                                                -23,
                                                                23,
                                                                46,
                                                                5,
                                                                "#8da596"
                                                            )
                                                            do
                                                                local i = 0
                                                                while i < 3 do
                                                                    rect(
                                                                        nil,
                                                                        c,
                                                                        32 + i * 8,
                                                                        -35 + i * 5,
                                                                        5,
                                                                        14,
                                                                        "#ffdc78"
                                                                    )
                                                                    i = i + 1
                                                                end
                                                            end
                                                        else
                                                            local ____t_470 = __t
                                                            local ____t_469 = __t
                                                            local ____call_result_468 = __call(shape, "includes", "towel")
                                                            __O[2633] = ____call_result_468
                                                            if ____t_470(if ____t_469(____call_result_468) then __O[2633] else __call(shape, "includes", "brush")) then
                                                                c:save()
                                                                c:rotate(progress * TAU)
                                                                rect(
                                                                    nil,
                                                                    c,
                                                                    -38,
                                                                    -11,
                                                                    76,
                                                                    22,
                                                                    "#f8ffff"
                                                                )
                                                                rect(
                                                                    nil,
                                                                    c,
                                                                    -34,
                                                                    -8,
                                                                    68,
                                                                    5,
                                                                    "#8fc8e7"
                                                                )
                                                                do
                                                                    local i = 0
                                                                    while i < 6 do
                                                                        rect(
                                                                            nil,
                                                                            c,
                                                                            -44,
                                                                            -9 + i * 4,
                                                                            7,
                                                                            2,
                                                                            "#cedce9"
                                                                        )
                                                                        rect(
                                                                            nil,
                                                                            c,
                                                                            37,
                                                                            -9 + i * 4,
                                                                            7,
                                                                            2,
                                                                            "#cedce9"
                                                                        )
                                                                        i = i + 1
                                                                    end
                                                                end
                                                                c:restore()
                                                            else
                                                                local ____t_475 = __t
                                                                local ____t_474 = __t
                                                                local ____t_472 = __t
                                                                local ____call_result_471 = __call(shape, "includes", "reception")
                                                                __O[2634] = ____call_result_471
                                                                local ____temp_473 = if ____t_472(____call_result_471) then __O[2634] else __call(shape, "includes", "queue")
                                                                __O[2635] = ____temp_473
                                                                if ____t_475(if ____t_474(____temp_473) then __O[2635] else __call(shape, "includes", "receipt")) then
                                                                    rect(
                                                                        nil,
                                                                        c,
                                                                        -25,
                                                                        -33,
                                                                        50,
                                                                        38,
                                                                        "#fff0bc"
                                                                    )
                                                                    do
                                                                        local i = 0
                                                                        while i < 5 do
                                                                            rect(
                                                                                nil,
                                                                                c,
                                                                                -20,
                                                                                -26 + i * 6,
                                                                                35 - __mod(i, 2) * 12,
                                                                                2,
                                                                                "#99704c"
                                                                            )
                                                                            i = i + 1
                                                                        end
                                                                    end
                                                                    label(
                                                                        nil,
                                                                        c,
                                                                        "67",
                                                                        0,
                                                                        -49,
                                                                        21,
                                                                        color
                                                                    )
                                                                    if __t(__call(shape, "includes", "bell")) then
                                                                        pixelOval(
                                                                            nil,
                                                                            c,
                                                                            0,
                                                                            -16,
                                                                            22,
                                                                            12,
                                                                            "#ffd23d"
                                                                        )
                                                                        rect(
                                                                            nil,
                                                                            c,
                                                                            -24,
                                                                            -10,
                                                                            48,
                                                                            6,
                                                                            "#8d6835"
                                                                        )
                                                                        rect(
                                                                            nil,
                                                                            c,
                                                                            -3,
                                                                            -33,
                                                                            6,
                                                                            9,
                                                                            "#ce883c"
                                                                        )
                                                                    end
                                                                else
                                                                    local ____t_478 = __t
                                                                    local ____t_477 = __t
                                                                    local ____call_result_476 = __call(shape, "includes", "pencil-case")
                                                                    __O[2636] = ____call_result_476
                                                                    if ____t_478(if ____t_477(____call_result_476) then __O[2636] else __call(shape, "includes", "eraser")) then
                                                                        if __t(__call(shape, "includes", "eraser")) then
                                                                            c:save()
                                                                            c:rotate(-0.4)
                                                                            rect(
                                                                                nil,
                                                                                c,
                                                                                -24,
                                                                                -15,
                                                                                48,
                                                                                29,
                                                                                "#f2a8bf"
                                                                            )
                                                                            rect(
                                                                                nil,
                                                                                c,
                                                                                -24,
                                                                                0,
                                                                                48,
                                                                                14,
                                                                                "#63bde3"
                                                                            )
                                                                            rect(
                                                                                nil,
                                                                                c,
                                                                                -21,
                                                                                -12,
                                                                                35,
                                                                                3,
                                                                                "#ffe3ea"
                                                                            )
                                                                            c:restore()
                                                                        else
                                                                            rect(
                                                                                nil,
                                                                                c,
                                                                                -25,
                                                                                -21,
                                                                                50,
                                                                                31,
                                                                                "#258cc6"
                                                                            )
                                                                            rect(
                                                                                nil,
                                                                                c,
                                                                                -25,
                                                                                -20,
                                                                                50,
                                                                                6,
                                                                                "#86d9ff"
                                                                            )
                                                                            rect(
                                                                                nil,
                                                                                c,
                                                                                -10,
                                                                                -16,
                                                                                20,
                                                                                26,
                                                                                "#d3f2ff"
                                                                            )
                                                                            do
                                                                                local i = 0
                                                                                while i < 4 do
                                                                                    rect(
                                                                                        nil,
                                                                                        c,
                                                                                        27 + i * 8,
                                                                                        -11 + __mod(i, 2) * 7,
                                                                                        6,
                                                                                        4,
                                                                                        "#ffdf68"
                                                                                    )
                                                                                    i = i + 1
                                                                                end
                                                                            end
                                                                        end
                                                                    else
                                                                        local ____t_481 = __t
                                                                        local ____t_480 = __t
                                                                        local ____call_result_479 = __call(shape, "includes", "claw")
                                                                        __O[2637] = ____call_result_479
                                                                        if ____t_481(if ____t_480(____call_result_479) then __O[2637] else __call(shape, "includes", "scratch")) then
                                                                            claw(
                                                                                nil,
                                                                                c,
                                                                                0,
                                                                                0,
                                                                                t,
                                                                                "#244956"
                                                                            )
                                                                            claw(
                                                                                nil,
                                                                                c,
                                                                                2,
                                                                                -1,
                                                                                t,
                                                                                "#fff0ba"
                                                                            )
                                                                            do
                                                                                local i = 0
                                                                                while i < 3 do
                                                                                    rect(
                                                                                        nil,
                                                                                        c,
                                                                                        -20 + i * 17,
                                                                                        21,
                                                                                        7,
                                                                                        4,
                                                                                        color
                                                                                    )
                                                                                    i = i + 1
                                                                                end
                                                                            end
                                                                        else
                                                                            local ____t_484 = __t
                                                                            local ____t_483 = __t
                                                                            local ____call_result_482 = __call(shape, "includes", "wave")
                                                                            __O[2638] = ____call_result_482
                                                                            if ____t_484(if ____t_483(____call_result_482) then __O[2638] else __call(shape, "includes", "stomp")) then
                                                                                crack(
                                                                                    nil,
                                                                                    c,
                                                                                    0,
                                                                                    0,
                                                                                    progress,
                                                                                    "#ffc65c"
                                                                                )
                                                                                do
                                                                                    local i = 0
                                                                                    while i < 5 do
                                                                                        local xx = (i - 2) * (13 + progress * 11)
                                                                                        poly(
                                                                                            nil,
                                                                                            c,
                                                                                            __arrL(
                                                                                                {
                                                                                                    __arrL({xx - 7, 4}, 2),
                                                                                                    __arrL(
                                                                                                        {
                                                                                                            xx - 3,
                                                                                                            -12 - math.sin(progress * math.pi) * 14
                                                                                                        },
                                                                                                        2
                                                                                                    ),
                                                                                                    __arrL(
                                                                                                        {
                                                                                                            xx + 3,
                                                                                                            -17 - math.sin(progress * math.pi) * 12
                                                                                                        },
                                                                                                        2
                                                                                                    ),
                                                                                                    __arrL({xx + 8, 4}, 2)
                                                                                                },
                                                                                                4
                                                                                            ),
                                                                                            if __t(__mod(i, 2)) then "#98582f" else "#e4a35d"
                                                                                        )
                                                                                        i = i + 1
                                                                                    end
                                                                                end
                                                                            elseif ____type == "attack" then
                                                                                local ____t_489 = __t
                                                                                local ____t_488 = __t
                                                                                local ____t_486 = __t
                                                                                local ____call_result_485 = __call(shape, "includes", "weight")
                                                                                __O[2639] = ____call_result_485
                                                                                local ____temp_487 = if ____t_486(____call_result_485) then __O[2639] else __call(shape, "includes", "dumbbell")
                                                                                __O[2640] = ____temp_487
                                                                                if ____t_489(if ____t_488(____temp_487) then __O[2640] else __call(shape, "includes", "supino")) then
                                                                                    smear(
                                                                                        nil,
                                                                                        c,
                                                                                        -7,
                                                                                        -2,
                                                                                        angle,
                                                                                        progress,
                                                                                        "#b4d8e9",
                                                                                        9
                                                                                    )
                                                                                    weight(
                                                                                        nil,
                                                                                        c,
                                                                                        face * 19,
                                                                                        -6,
                                                                                        t * 7,
                                                                                        0.8,
                                                                                        "#4b87be"
                                                                                    )
                                                                                else
                                                                                    local ____t_494 = __t
                                                                                    local ____t_493 = __t
                                                                                    local ____t_491 = __t
                                                                                    local ____call_result_490 = __call(shape, "includes", "heel")
                                                                                    __O[2641] = ____call_result_490
                                                                                    local ____temp_492 = if ____t_491(____call_result_490) then __O[2641] else __call(shape, "includes", "kick")
                                                                                    __O[2642] = ____temp_492
                                                                                    if ____t_494(if ____t_493(____temp_492) then __O[2642] else __call(shape, "includes", "capoeira")) then
                                                                                        smear(
                                                                                            nil,
                                                                                            c,
                                                                                            -2,
                                                                                            -3,
                                                                                            angle,
                                                                                            progress,
                                                                                            "#ffe1a3",
                                                                                            10
                                                                                        )
                                                                                        heel(
                                                                                            nil,
                                                                                            c,
                                                                                            face * 21,
                                                                                            -1,
                                                                                            if __t(__call(shape, "includes", "upper")) then -1.2 else if face < 0 then math.pi else 0,
                                                                                            0.85,
                                                                                            color
                                                                                        )
                                                                                    elseif __t(__call(shape, "includes", "tongue")) then
                                                                                        drawProjectile(nil, c, {
                                                                                            type = "tongue",
                                                                                            x = 0,
                                                                                            y = 0,
                                                                                            color = color,
                                                                                            vx = face
                                                                                        }, t)
                                                                                    elseif __t(__call(shape, "includes", "lowblow")) then
                                                                                        glove(
                                                                                            nil,
                                                                                            c,
                                                                                            face * 18,
                                                                                            11,
                                                                                            "#efc5a4",
                                                                                            if face < 0 then math.pi else 0
                                                                                        )
                                                                                        impact(
                                                                                            nil,
                                                                                            c,
                                                                                            face * 29,
                                                                                            9,
                                                                                            12,
                                                                                            "#ffe66c",
                                                                                            progress
                                                                                        )
                                                                                    else
                                                                                        local ____t_497 = __t
                                                                                        local ____t_496 = __t
                                                                                        local ____call_result_495 = __call(shape, "includes", "gun")
                                                                                        __O[2643] = ____call_result_495
                                                                                        if ____t_497(if ____t_496(____call_result_495) then __O[2643] else __call(shape, "includes", "stock")) then
                                                                                            c:save()
                                                                                            c:scale(face, 1)
                                                                                            rect(
                                                                                                nil,
                                                                                                c,
                                                                                                -8,
                                                                                                -9,
                                                                                                42,
                                                                                                11,
                                                                                                INK
                                                                                            )
                                                                                            rect(
                                                                                                nil,
                                                                                                c,
                                                                                                -5,
                                                                                                -7,
                                                                                                32,
                                                                                                5,
                                                                                                "#7199b2"
                                                                                            )
                                                                                            rect(
                                                                                                nil,
                                                                                                c,
                                                                                                1,
                                                                                                2,
                                                                                                8,
                                                                                                16,
                                                                                                INK
                                                                                            )
                                                                                            rect(
                                                                                                nil,
                                                                                                c,
                                                                                                28,
                                                                                                -6,
                                                                                                13,
                                                                                                5,
                                                                                                "#aec9d8"
                                                                                            )
                                                                                            c:restore()
                                                                                            smear(
                                                                                                nil,
                                                                                                c,
                                                                                                -8,
                                                                                                1,
                                                                                                angle,
                                                                                                progress,
                                                                                                "#8bafc7",
                                                                                                6
                                                                                            )
                                                                                        else
                                                                                            local ____t_500 = __t
                                                                                            local ____t_499 = __t
                                                                                            local ____call_result_498 = __call(shape, "includes", "ruler")
                                                                                            __O[2644] = ____call_result_498
                                                                                            if ____t_500(if ____t_499(____call_result_498) then __O[2644] else __call(shape, "includes", "tool")) then
                                                                                                c:save()
                                                                                                c:rotate(angle - 0.7)
                                                                                                rect(
                                                                                                    nil,
                                                                                                    c,
                                                                                                    -4,
                                                                                                    -27,
                                                                                                    9,
                                                                                                    48,
                                                                                                    "#633f27"
                                                                                                )
                                                                                                rect(
                                                                                                    nil,
                                                                                                    c,
                                                                                                    -2,
                                                                                                    -25,
                                                                                                    5,
                                                                                                    43,
                                                                                                    "#ffce5d"
                                                                                                )
                                                                                                do
                                                                                                    local i = 0
                                                                                                    while i < 7 do
                                                                                                        rect(
                                                                                                            nil,
                                                                                                            c,
                                                                                                            -2,
                                                                                                            -20 + i * 6,
                                                                                                            3,
                                                                                                            2,
                                                                                                            "#7e552e"
                                                                                                        )
                                                                                                        i = i + 1
                                                                                                    end
                                                                                                end
                                                                                                c:restore()
                                                                                            elseif __t(__call(shape, "includes", "clipper")) then
                                                                                                rect(
                                                                                                    nil,
                                                                                                    c,
                                                                                                    -9,
                                                                                                    -20,
                                                                                                    18,
                                                                                                    32,
                                                                                                    INK
                                                                                                )
                                                                                                rect(
                                                                                                    nil,
                                                                                                    c,
                                                                                                    -6,
                                                                                                    -17,
                                                                                                    12,
                                                                                                    23,
                                                                                                    "#8ec2dc"
                                                                                                )
                                                                                                do
                                                                                                    local i = 0
                                                                                                    while i < 5 do
                                                                                                        rect(
                                                                                                            nil,
                                                                                                            c,
                                                                                                            -9 + i * 4,
                                                                                                            -26,
                                                                                                            2,
                                                                                                            8,
                                                                                                            "#effaff"
                                                                                                        )
                                                                                                        i = i + 1
                                                                                                    end
                                                                                                end
                                                                                            else
                                                                                                local ____t_503 = __t
                                                                                                local ____t_502 = __t
                                                                                                local ____call_result_501 = __call(shape, "includes", "ear")
                                                                                                __O[2645] = ____call_result_501
                                                                                                if ____t_503(if ____t_502(____call_result_501) then __O[2645] else __call(shape, "includes", "wind")) then
                                                                                                    smear(
                                                                                                        nil,
                                                                                                        c,
                                                                                                        0,
                                                                                                        0,
                                                                                                        angle,
                                                                                                        progress,
                                                                                                        "#d8f6ff",
                                                                                                        14
                                                                                                    )
                                                                                                    rect(
                                                                                                        nil,
                                                                                                        c,
                                                                                                        -11,
                                                                                                        -6,
                                                                                                        22,
                                                                                                        4,
                                                                                                        "#84d5ff"
                                                                                                    )
                                                                                                else
                                                                                                    local ____t_507 = __t
                                                                                                    local ____t_505 = __t
                                                                                                    local ____call_result_504 = __call(shape, "includes", "teacher")
                                                                                                    __O[2646] = ____call_result_504
                                                                                                    local ____temp_506 = if ____t_505(____call_result_504) then __O[2646] else __call(shape, "includes", "point")
                                                                                                    __O[2647] = ____temp_506
                                                                                                    local palm = if ____t_507(____temp_506) then __O[2647] else __call(shape, "includes", "receipt")
                                                                                                    smear(
                                                                                                        nil,
                                                                                                        c,
                                                                                                        -9,
                                                                                                        0,
                                                                                                        angle,
                                                                                                        progress,
                                                                                                        if __t(palm) then "#ffe4b9" else color,
                                                                                                        8
                                                                                                    )
                                                                                                    glove(
                                                                                                        nil,
                                                                                                        c,
                                                                                                        face * (14 + math.sin(progress * math.pi) * 12),
                                                                                                        -4,
                                                                                                        if __t(palm) then "#e0b08a" else color,
                                                                                                        if face < 0 then math.pi else 0
                                                                                                    )
                                                                                                end
                                                                                            end
                                                                                        end
                                                                                    end
                                                                                end
                                                                            elseif ____type == "ko" then
                                                                                local n = 16 + progress * 38
                                                                                impact(
                                                                                    nil,
                                                                                    c,
                                                                                    0,
                                                                                    0,
                                                                                    n,
                                                                                    color,
                                                                                    progress
                                                                                )
                                                                                do
                                                                                    local i = 0
                                                                                    while i < 7 do
                                                                                        local xx = (i - 3) * (12 + progress * 13)
                                                                                        local yy = if __t(__mod(i, 2)) then -1 else 1 * (13 + progress * 27)
                                                                                        rect(
                                                                                            nil,
                                                                                            c,
                                                                                            xx,
                                                                                            yy,
                                                                                            7,
                                                                                            11,
                                                                                            if __t(__mod(i, 2)) then "#fff4bd" else "#ffcf3d"
                                                                                        )
                                                                                        i = i + 1
                                                                                    end
                                                                                end
                                                                                label(
                                                                                    nil,
                                                                                    c,
                                                                                    "POW!",
                                                                                    0,
                                                                                    -n - 18,
                                                                                    16,
                                                                                    "#fff1b2"
                                                                                )
                                                                            elseif ____type == "respawn" then
                                                                                rect(
                                                                                    nil,
                                                                                    c,
                                                                                    -24,
                                                                                    9,
                                                                                    48,
                                                                                    8,
                                                                                    "#71472c"
                                                                                )
                                                                                rect(
                                                                                    nil,
                                                                                    c,
                                                                                    -21,
                                                                                    6,
                                                                                    42,
                                                                                    5,
                                                                                    "#ffce64"
                                                                                )
                                                                                do
                                                                                    local i = 0
                                                                                    while i < 5 do
                                                                                        local yy = -5 - __mod(progress * 60 + i * 13, 75)
                                                                                        rect(
                                                                                            nil,
                                                                                            c,
                                                                                            -24 + i * 12,
                                                                                            yy,
                                                                                            5,
                                                                                            10,
                                                                                            if __t(__mod(i, 2)) then "#f8f4bc" else color
                                                                                        )
                                                                                        i = i + 1
                                                                                    end
                                                                                end
                                                                            elseif ____type == "combo" then
                                                                                contactImpact(
                                                                                    nil,
                                                                                    c,
                                                                                    progress,
                                                                                    32,
                                                                                    color,
                                                                                    angle
                                                                                )
                                                                                label(
                                                                                    nil,
                                                                                    c,
                                                                                    "3 ACERTOS!",
                                                                                    0,
                                                                                    -39,
                                                                                    10,
                                                                                    "#fff0bf"
                                                                                )
                                                                            elseif __t(____type == "hit" or ____type == "spark") then
                                                                                local ____contactImpact_511 = contactImpact
                                                                                local ____c_510 = c
                                                                                local ____t_509 = __t
                                                                                local ____TS__Number_result_508 = __TS__Number(e.radius)
                                                                                __O[2648] = ____TS__Number_result_508
                                                                                ____contactImpact_511(
                                                                                    nil,
                                                                                    ____c_510,
                                                                                    progress,
                                                                                    if ____t_509(____TS__Number_result_508) then __O[2648] else 22,
                                                                                    color,
                                                                                    angle
                                                                                )
                                                                            else
                                                                                rect(
                                                                                    nil,
                                                                                    c,
                                                                                    -4,
                                                                                    -4,
                                                                                    8,
                                                                                    8,
                                                                                    color
                                                                                )
                                                                                rect(
                                                                                    nil,
                                                                                    c,
                                                                                    -9,
                                                                                    -2,
                                                                                    18,
                                                                                    4,
                                                                                    "#fff0b5"
                                                                                )
                                                                            end
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        if __t(e.text) then
            label(
                nil,
                c,
                __call(
                    tostring(e.text),
                    "slice",
                    0,
                    34
                ),
                0,
                -27 - progress * 18,
                12,
                color
            )
        end
        c:restore()
    end
    window.ArenaArt = __ord(
        {
            drawBackground = drawBackground,
            drawStage = drawStage,
            drawFighter = drawFighter,
            drawProjectile = drawProjectile,
            drawEffect = drawEffect,
            bodyHeight = bodyHeight,
            legPose = legPose,
            normalizedHeight = function(____, ____type) return if ____type == "lucas" then 60 else 70 end,
            movementPose = movementPose,
            movementArms = movementArms,
            attackPose = attackPose,
            attackArms = attackArms,
            version = 5
        },
        "drawBackground,drawStage,drawFighter,drawProjectile,drawEffect,bodyHeight,legPose,normalizedHeight,movementPose,movementArms,attackPose,attackArms,version"
    )
end)(nil)
return ____exports
