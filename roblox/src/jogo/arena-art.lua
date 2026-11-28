--!native
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
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
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
            local ____lt_338 = __lt
            local ____t_result_337
            if __t(p.vy) then
                ____t_result_337 = p.vy
            else
                ____t_result_337 = 0
            end
            return ____lt_338(____t_result_337, -20) and "jump" or "fall"
        end
        local ____t_result_339
        if __t(p.vx) then
            ____t_result_339 = p.vx
        else
            ____t_result_339 = 0
        end
        return math.abs(____t_result_339) > 15 and "run" or "idle"
    end
    local ____ = "use strict"
    local TAU = math.pi * 2
    local INK = "#203c44"
    local CREAM = "#fff0be"
    local function clamp(____, n, a, b)
        local ____a_4 = a
        local ____b_3 = b
        local ____t_result_2
        local ____t_1 = __t
        local ____TS__Number_result_0 = __TS__Number(n)
        __O[2542] = ____TS__Number_result_0
        if ____t_1(____TS__Number_result_0) then
            ____t_result_2 = __O[2542]
        else
            ____t_result_2 = 0
        end
        return math.max(
            ____a_4,
            math.min(____b_3, ____t_result_2)
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
                local sx = x < ex and 1 or -1
                local sy = y < ey and 1 or -1
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
        local ____t_result_8
        local ____t_7 = __t
        local ____TS__Number_result_6 = __TS__Number(rx)
        __O[2543] = ____TS__Number_result_6
        if ____t_7(____TS__Number_result_6) then
            ____t_result_8 = __O[2543]
        else
            ____t_result_8 = 1
        end
        rx = math.max(1, ____t_result_8)
        local ____t_result_11
        local ____t_10 = __t
        local ____TS__Number_result_9 = __TS__Number(ry)
        __O[2544] = ____TS__Number_result_9
        if ____t_10(____TS__Number_result_9) then
            ____t_result_11 = __O[2544]
        else
            ____t_result_11 = 1
        end
        ry = math.max(1, ____t_result_11)
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
                local ____rect_14 = rect
                local ____array_13 = __TS__SparseArrayNew(
                    nil,
                    c,
                    n + d + i * 4,
                    -n + 7 + i * 8,
                    4,
                    4
                )
                local ____t_result_12
                if __t(__mod(i, 2)) then
                    ____t_result_12 = color
                else
                    ____t_result_12 = "#ffe45a"
                end
                __TS__SparseArrayPush(____array_13, ____t_result_12)
                ____rect_14(__TS__SparseArraySpread(____array_13))
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
        local ____t_result_17
        local ____t_16 = __t
        local ____callq_result_15 = __callq(window.ArenaRoster, "get", id)
        __O[2545] = ____callq_result_15
        if ____t_16(____callq_result_15) then
            ____t_result_17 = __O[2545]
        else
            ____t_result_17 = {color = "#e9c27c", name = id}
        end
        return ____t_result_17
    end
    local function bodyHeight(self, ____type)
        if __t(__call(heightCache, "has", ____type)) then
            return __call(heightCache, "get", ____type)
        end
        local ____t_result_20
        local ____t_19 = __t
        local ____get_result_18 = __get({
            igor = 90,
            kaique = 111,
            giant = 190,
            ollyan = 110,
            lucas = 54
        }, ____type)
        __O[2546] = ____get_result_18
        if ____t_19(____get_result_18) then
            ____t_result_20 = __O[2546]
        else
            ____t_result_20 = 70
        end
        local height = ____t_result_20
        do
            pcall(function()
                local canvas = window.document:createElement("canvas")
                canvas.width = 380
                canvas.height = 360
                local c = canvas:getContext("2d", {willReadFrequently = true})
                local ____opt_23 = window.Art
                if ____opt_23 ~= nil then
                    ____opt_23 = ____opt_23.drawCharacter
                end
                if ____opt_23 ~= nil then
                    ____opt_23(
                        ____opt_23,
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
                    __t(__mod(i, 2)) and "#e94b3d" or "#256cd8"
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
                __t(kind) and "#63bc3b" or "#45ab44"
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
                    __t(__mod(i, 2)) and "#86d343" or "#75cc56"
                )
                local ____t_26 = __t
                local ____t_result_25
                if __t(kind) then
                    ____t_result_25 = __mod(i, 2) == 0
                else
                    ____t_result_25 = kind
                end
                if ____t_26(____t_result_25) then
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
                    __t(__mod(i, 2)) and "#6ca7ce" or "#77b5d8"
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
                    __t(__mod(i, 3)) and "#6cb84a" or "#a1da61"
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
                    __t(__mod(i, 2)) and "#fff0cc" or "#eee8cf"
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
                    __t(__mod(i, 2)) and "#c14439" or "#2c69a0"
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
        local ____t_result_29
        local ____t_28 = __t
        local ____TS__Number_result_27 = __TS__Number(camera.x)
        __O[2547] = ____TS__Number_result_27
        if ____t_28(____TS__Number_result_27) then
            ____t_result_29 = __O[2547]
        else
            ____t_result_29 = 640
        end
        local x = ____t_result_29
        local ____t_result_32
        local ____t_31 = __t
        local ____TS__Number_result_30 = __TS__Number(camera.y)
        __O[2548] = ____TS__Number_result_30
        if ____t_31(____TS__Number_result_30) then
            ____t_result_32 = __O[2548]
        else
            ____t_result_32 = 340
        end
        local y = ____t_result_32
        local ____t_result_35
        local ____t_34 = __t
        local ____TS__Number_result_33 = __TS__Number(time)
        __O[2549] = ____TS__Number_result_33
        if ____t_34(____TS__Number_result_33) then
            ____t_result_35 = __O[2549]
        else
            ____t_result_35 = 0
        end
        local t = ____t_result_35
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
                    __mod(
                        i * 241 + t * (__t(__mod(i, 2)) and 2.1 or 3.2) - x * 0.065,
                        W + 240
                    ) + W + 240,
                    W + 240
                ) - 120
                cloud(
                    nil,
                    c,
                    xx,
                    35 + __mod(i, 4) * 36 - y * 0.017,
                    0.52 + __mod(i, 3) * 0.14,
                    __t(__mod(i, 2)) and "#e0f5ff" or "#ffffff"
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
                    __t(__mod(i, 2)) and "#298d3c" or "#81d94b",
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
                        __t(__mod(i, 2)) and "#7d7970" or "#989282"
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
        local ____rect_39 = rect
        local ____c_37 = c
        local ____temp_38 = __t(main) and 3 or 0
        local ____t_result_36
        if __t(main) then
            ____t_result_36 = w - 6
        else
            ____t_result_36 = w
        end
        ____rect_39(
            nil,
            ____c_37,
            ____temp_38,
            y,
            ____t_result_36,
            7,
            "#257b38"
        )
        local ____rect_42 = rect
        local ____array_41 = __TS__SparseArrayNew(
            nil,
            c,
            __t(main) and 4 or 1,
            y - 2
        )
        local ____t_result_40
        if __t(main) then
            ____t_result_40 = w - 8
        else
            ____t_result_40 = w - 2
        end
        __TS__SparseArrayPush(____array_41, ____t_result_40, 5, "#70ca43")
        ____rect_42(__TS__SparseArraySpread(____array_41))
        local ____rect_45 = rect
        local ____array_44 = __TS__SparseArrayNew(
            nil,
            c,
            __t(main) and 7 or 3,
            y - 3
        )
        local ____t_result_43
        if __t(main) then
            ____t_result_43 = w - 14
        else
            ____t_result_43 = w - 6
        end
        __TS__SparseArrayPush(____array_44, ____t_result_43, 2, "#c0ee78")
        ____rect_45(__TS__SparseArraySpread(____array_44))
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
                    __t(__mod(i, 3)) and "#8fda4d" or "#44a13b"
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
        local ____t_result_48
        local ____t_47 = __t
        local ____TS__Number_result_46 = __TS__Number(time)
        __O[2550] = ____TS__Number_result_46
        if ____t_47(____TS__Number_result_46) then
            ____t_result_48 = __O[2550]
        else
            ____t_result_48 = 0
        end
        local t = ____t_result_48
        c:save()
        c.imageSmoothingEnabled = false
        for ____, p in __iterar((platforms)) do
            local ____t_result_51
            local ____t_50 = __t
            local ____TS__Number_result_49 = __TS__Number(p.x)
            __O[2551] = ____TS__Number_result_49
            if ____t_50(____TS__Number_result_49) then
                ____t_result_51 = __O[2551]
            else
                ____t_result_51 = 0
            end
            local x = ____t_result_51
            local ____t_result_54
            local ____t_53 = __t
            local ____TS__Number_result_52 = __TS__Number(p.y)
            __O[2552] = ____TS__Number_result_52
            if ____t_53(____TS__Number_result_52) then
                ____t_result_54 = __O[2552]
            else
                ____t_result_54 = 0
            end
            local y = ____t_result_54
            local ____t_result_57
            local ____t_56 = __t
            local ____TS__Number_result_55 = __TS__Number(p.w)
            __O[2553] = ____TS__Number_result_55
            if ____t_56(____TS__Number_result_55) then
                ____t_result_57 = __O[2553]
            else
                ____t_result_57 = 100
            end
            local w = math.floor(____t_result_57 + 0.5)
            local main = not not __t(p.main)
            local key = __add(
                __t(main) and "m:" or "p:",
                w
            )
            local image = cachedCanvas(
                nil,
                platformCache,
                key,
                w + 2,
                __t(main) and 148 or 67,
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
                    local ____temp_58
                    if side < 0 then
                        ____temp_58 = x + 36
                    else
                        ____temp_58 = x + w - 44
                    end
                    local xx = ____temp_58
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
                do
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
                        __t(i) and "#ffcf3f" or "#f7694c"
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
            spread = id == "caleb" and 6 or 5,
            width = id == "caleb" and 7 or 6
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
        local ____temp_59
        if raw > 0.0001 then
            ____temp_59 = dx / raw
        else
            ____temp_59 = 0
        end
        local ux = ____temp_59
        local ____temp_60
        if raw > 0.0001 then
            ____temp_60 = dy / raw
        else
            ____temp_60 = 1
        end
        local uy = ____temp_60
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
        local ____t_result_63
        local ____t_62 = __t
        local ____TS__Number_result_61 = __TS__Number(time)
        __O[2554] = ____TS__Number_result_61
        if ____t_62(____TS__Number_result_61) then
            ____t_result_63 = __O[2554]
        else
            ____t_result_63 = 0
        end
        local ____t_result_66
        local ____t_65 = __t
        local ____get_result_64 = __get(gait, id)
        __O[2555] = ____get_result_64
        if ____t_65(____get_result_64) then
            ____t_result_66 = __O[2555]
        else
            ____t_result_66 = 10.7
        end
        local phase = ____t_result_63 * ____t_result_66
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
        local ____t_result_71
        local ____t_70 = __t
        local ____kinematics_motionTime_67 = kinematics.motionTime
        if ____kinematics_motionTime_67 == nil then
            ____kinematics_motionTime_67 = kinematics.mt
        end
        local ____kinematics_motionTime_67_68 = ____kinematics_motionTime_67
        if ____kinematics_motionTime_67_68 == nil then
            ____kinematics_motionTime_67_68 = time
        end
        local ____TS__Number_result_69 = __TS__Number(____kinematics_motionTime_67_68)
        __O[2556] = ____TS__Number_result_69
        if ____t_70(____TS__Number_result_69) then
            ____t_result_71 = __O[2556]
        else
            ____t_result_71 = 0
        end
        local mt = math.max(0, ____t_result_71)
        local ____t_result_74
        local ____t_73 = __t
        local ____TS__Number_result_72 = __TS__Number(kinematics.vy)
        __O[2557] = ____TS__Number_result_72
        if ____t_73(____TS__Number_result_72) then
            ____t_result_74 = __O[2557]
        else
            ____t_result_74 = 0
        end
        local vy = ____t_result_74
        local ____t_result_77
        local ____t_76 = __t
        local ____TS__Number_result_75 = __TS__Number(kinematics.wall)
        __O[2558] = ____TS__Number_result_75
        if ____t_76(____TS__Number_result_75) then
            ____t_result_77 = __O[2558]
        else
            ____t_result_77 = 1
        end
        local wall = ____t_result_77
        local ____t_result_80
        local ____t_79 = __t
        local ____TS__Number_result_78 = __TS__Number(kinematics.dx)
        __O[2559] = ____TS__Number_result_78
        if ____t_79(____TS__Number_result_78) then
            ____t_result_80 = __O[2559]
        else
            ____t_result_80 = 0
        end
        local bodyX = ____t_result_80
        local ____t_result_83
        local ____t_82 = __t
        local ____TS__Number_result_81 = __TS__Number(kinematics.dy)
        __O[2560] = ____TS__Number_result_81
        if ____t_82(____TS__Number_result_81) then
            ____t_result_83 = __O[2560]
        else
            ____t_result_83 = 0
        end
        local bodyY = ____t_result_83
        do
            local i = 0
            while i < 2 do
                local side = __t(i) and 1 or -1
                local ____t_result_84
                if __t(i) then
                    ____t_result_84 = math.pi
                else
                    ____t_result_84 = 0
                end
                local wave = math.sin(phase + ____t_result_84)
                local ____t_result_85
                if __t(i) then
                    ____t_result_85 = math.pi
                else
                    ____t_result_85 = 0
                end
                local lift = math.max(
                    0,
                    math.cos(phase + ____t_result_85)
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
                    __set(bends, i, wave > 0 and -1 or 1)
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
                    local ____set_92 = __set
                    local ____i_91 = i
                    local ____arrL_90 = __arrL
                    local ____get_result_87 = __get(
                        __get(hips, i),
                        0
                    )
                    local ____t_result_86
                    if __t(i) then
                        ____t_result_86 = L * 0.46
                    else
                        ____t_result_86 = -L * 0.44
                    end
                    local ____temp_89 = ____get_result_87 + ____t_result_86 * (1 - launch * 0.3)
                    local ____t_result_88
                    if __t(i) then
                        ____t_result_88 = -2 - L * (0.28 + rise * 0.45 + apex * 0.12)
                    else
                        ____t_result_88 = -0.5 - L * (0.1 + rise * 0.2)
                    end
                    ____set_92(
                        feet,
                        ____i_91,
                        ____arrL_90({____temp_89, ____t_result_88}, 2)
                    )
                    local ____t_94 = __t
                    local ____t_result_93
                    if __t(launch) then
                        ____t_result_93 = not __t(second)
                    else
                        ____t_result_93 = launch
                    end
                    if ____t_94(____t_result_93) then
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
                            ) + (__t(i) and 8 or 3) * launch
                        )
                    end
                    __set(
                        bends,
                        i,
                        __t(i) and -1 or 1
                    )
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
                                -L * (0.38 + tuck * 0.63) + (__t(i) and -3 or 1)
                            },
                            2
                        )
                    )
                    __set(
                        bends,
                        i,
                        __t(i) and -1 or 1
                    )
                elseif motion == "fall" then
                    local extend = smooth(nil, 30, 500, vy)
                    local ____set_100 = __set
                    local ____i_99 = i
                    local ____arrL_98 = __arrL
                    local ____temp_97 = __get(
                        __get(hips, i),
                        0
                    ) + side * L * (0.26 - 0.08 * extend)
                    local ____temp_96 = -L
                    local ____t_result_95
                    if __t(i) then
                        ____t_result_95 = 0.27 * (1 - extend) + 0.025
                    else
                        ____t_result_95 = 0.15 * (1 - extend) + 0.015
                    end
                    ____set_100(
                        feet,
                        ____i_99,
                        ____arrL_98({____temp_97, ____temp_96 * ____t_result_95}, 2)
                    )
                    __set(
                        bends,
                        i,
                        __t(i) and 1 or -1
                    )
                elseif motion == "dash" then
                    local ____set_107 = __set
                    local ____i_106 = i
                    local ____arrL_105 = __arrL
                    local ____get_result_102 = __get(
                        __get(hips, i),
                        0
                    )
                    local ____t_result_101
                    if __t(i) then
                        ____t_result_101 = L * 0.51
                    else
                        ____t_result_101 = -L * 0.85
                    end
                    local ____temp_104 = ____get_result_102 + ____t_result_101
                    local ____t_result_103
                    if __t(i) then
                        ____t_result_103 = -L * 0.61
                    else
                        ____t_result_103 = -L * 0.13
                    end
                    ____set_107(
                        feet,
                        ____i_106,
                        ____arrL_105({____temp_104, ____t_result_103}, 2)
                    )
                    __set(
                        bends,
                        i,
                        __t(i) and -1 or 1
                    )
                elseif motion == "wallSlide" then
                    __set(
                        feet,
                        i,
                        __arrL(
                            {
                                wall * L * (__t(i) and 0.91 or 0.61),
                                -L * (__t(i) and 0.16 or 0.52)
                            },
                            2
                        )
                    )
                    local ____set_110 = __set
                    local ____i_109 = i
                    local ____t_result_108
                    if __t(i) then
                        ____t_result_108 = __TS__Number(-wall)
                    else
                        ____t_result_108 = wall
                    end
                    ____set_110(bends, ____i_109, ____t_result_108)
                elseif motion == "wallJump" then
                    local push = 1 - smooth(nil, 0.02, 0.23, mt)
                    local ____set_115 = __set
                    local ____i_114 = i
                    local ____arrL_113 = __arrL
                    local ____get_result_112 = __get(
                        __get(hips, i),
                        0
                    )
                    local ____t_result_111
                    if __t(i) then
                        ____t_result_111 = L * (0.35 + push * 0.42)
                    else
                        ____t_result_111 = -L * 0.4
                    end
                    ____set_115(
                        feet,
                        ____i_114,
                        ____arrL_113(
                            {
                                ____get_result_112 + ____t_result_111,
                                -L * (__t(i) and 0.23 or 0.54)
                            },
                            2
                        )
                    )
                    __set(
                        bends,
                        i,
                        __t(i) and -1 or 1
                    )
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
        local ____t_119 = __t
        local ____t_result_118
        local ____t_117 = __t
        local ____temp_116 = progress > 0
        __O[2561] = ____temp_116
        if ____t_117(____temp_116) then
            ____t_result_118 = __call(girls, "has", id)
        else
            ____t_result_118 = __O[2561]
        end
        if ____t_119(____t_result_118) then
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
            local ____t_121 = __t
            local ____t_result_120
            if __t(combo) then
                ____t_result_120 = direction ~= "down"
            else
                ____t_result_120 = combo
            end
            if ____t_121(____t_result_120) then
                local thighAngle = math.pi / 2 - strike * (direction == "up" and 2.8 or (direction == "neutral" and 1.95 or 2.45))
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
                local ____temp_124
                if direction == "up" then
                    ____temp_124 = __arrL(
                        {
                            __get(h, 0) + L * 0.4,
                            __get(h, 1) - L * 0.91
                        },
                        2
                    )
                else
                    local ____temp_123
                    if direction == "down" then
                        ____temp_123 = __arrL(
                            {
                                __get(h, 0) + L * 0.68,
                                __get(h, 1) + L * 0.71
                            },
                            2
                        )
                    else
                        local ____temp_122
                        if direction == "neutral" then
                            ____temp_122 = __arrL(
                                {
                                    __get(h, 0) + L * 0.78,
                                    __get(h, 1) - L * 0.35
                                },
                                2
                            )
                        else
                            ____temp_122 = __arrL(
                                {
                                    __get(h, 0) + L * 0.98,
                                    __get(h, 1) - L * 0.12
                                },
                                2
                            )
                        end
                        ____temp_123 = ____temp_122
                    end
                    ____temp_124 = ____temp_123
                end
                target = ____temp_124
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
        local ____t_result_127
        local ____t_126 = __t
        local ____get_result_125 = __get(trouser, id)
        __O[2562] = ____get_result_125
        if ____t_126(____get_result_125) then
            ____t_result_127 = __O[2562]
        else
            ____t_result_127 = "#2b4662"
        end
        local colorPants = ____t_result_127
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
                __t(i) and "#5e7482" or "#526775",
                2
            )
            local ____t_133 = __t
            local ____t_result_132
            local ____t_131 = __t
            local ____t_result_130
            local ____t_129 = __t
            local ____call_result_128 = __call(girls, "has", id)
            __O[2563] = ____call_result_128
            if ____t_129(____call_result_128) then
                ____t_result_130 = kicking
            else
                ____t_result_130 = __O[2563]
            end
            __O[2564] = ____t_result_130
            if ____t_131(____t_result_130) then
                ____t_result_132 = i == 1
            else
                ____t_result_132 = __O[2564]
            end
            if ____t_133(____t_result_132) then
                local angle = math.atan(
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
                    id == "daroca" and "#b48b50" or (id == "almiro" and "#9ef13d" or (__t(id == "marco" or id == "dede") and "#748078" or "#e3e4ce"))
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
        local h = id == "lucas" and 60 or 70
        local s = h / bodyHeight(nil, id)
        local small = id == "lucas"
        local sx = s * (__t(small) and 0.84 or 1)
        local sy = s * (__t(small) and 0.78 or 1)
        local ____t_result_136
        local ____t_135 = __t
        local ____call_result_134 = __call(girls, "has", id)
        __O[2565] = ____call_result_134
        if ____t_135(____call_result_134) then
            ____t_result_136 = __O[2565]
        else
            ____t_result_136 = __call(
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
        end
        local social = ____t_result_136
        local ____temp_144
        if id == "caleb" then
            ____temp_144 = 20
        else
            local ____temp_143
            if id == "davi" then
                ____temp_143 = 19
            else
                local ____temp_142
                if id == "allef" then
                    ____temp_142 = 20
                else
                    local ____t_result_141
                    if __t(social) then
                        local ____t_140 = __t
                        local ____t_result_139
                        local ____t_138 = __t
                        local ____temp_137 = id == "freddy" or id == "dede"
                        __O[2566] = ____temp_137
                        if ____t_138(____temp_137) then
                            ____t_result_139 = __O[2566]
                        else
                            ____t_result_139 = id == "ravile"
                        end
                        ____t_result_141 = ____t_140(____t_result_139) and 10 or 12
                    else
                        ____t_result_141 = __t(id == "mota" or id == "marco") and 10 or 13
                    end
                    ____temp_142 = ____t_result_141
                end
                ____temp_143 = ____temp_142
            end
            ____temp_144 = ____temp_143
        end
        local wide = ____temp_144
        local ____temp_150 = (__t(social) and -36 or (id == "caleb" and -38 or -34)) * sy
        local ____temp_151 = wide * sx
        local ____temp_152 = (__t(social) and -43 or -42) * sy
        local ____temp_153 = (wide + 1) * sx
        local ____temp_154 = __t(small) and 7.5 or 9.5
        local ____temp_155 = __t(small) and 9 or 11.5
        local ____temp_149
        if id == "caleb" then
            ____temp_149 = 7
        else
            local ____t_148 = __t
            local ____t_result_147
            local ____t_146 = __t
            local ____temp_145 = id == "freddy" or id == "mota"
            __O[2567] = ____temp_145
            if ____t_146(____temp_145) then
                ____t_result_147 = __O[2567]
            else
                ____t_result_147 = id == "marco"
            end
            ____temp_149 = ____t_148(____t_result_147) and 4 or 5
        end
        local profile = {
            shoulderY = ____temp_150,
            shoulderX = ____temp_151,
            neckY = ____temp_152,
            coreHalf = ____temp_153,
            upper = ____temp_154,
            lower = ____temp_155,
            width = ____temp_149
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
        local ____opt_158 = window.Art
        if ____opt_158 ~= nil then
            ____opt_158 = ____opt_158.drawCharacter
        end
        if ____opt_158 ~= nil then
            ____opt_158(
                ____opt_158,
                g,
                id,
                ox,
                oy,
                {
                    scale = (id == "lucas" and 60 or 70) / bodyHeight(nil, id),
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
        local ____t_result_166
        if __t(__call(girls, "has", id)) then
            local ____Set_165 = Set
            local ____call_164 = __call
            local ____temp_163
            if id == "aica" then
                ____temp_163 = __arrL({"#4d392f", "#77573d"}, 2)
            else
                local ____temp_162
                if id == "ravile" then
                    ____temp_162 = __arrL({"#362f2b", "#65503a"}, 2)
                else
                    local ____temp_161
                    if id == "eloisa" then
                        ____temp_161 = __arrL({"#4d372c", "#76543b"}, 2)
                    else
                        local ____temp_160
                        if id == "analaura" then
                            ____temp_160 = __arrL({"#51362d", "#6a4734", "#7a543c", "#7d573e"}, 4)
                        else
                            ____temp_160 = __arrL({
                                "#232d2b",
                                "#25302e",
                                "#3a4238",
                                "#626151",
                                "#303b32",
                                "#455044",
                                "#31392f",
                                "#63614d"
                            }, 8)
                        end
                        ____temp_161 = ____temp_160
                    end
                    ____temp_162 = ____temp_161
                end
                ____temp_163 = ____temp_162
            end
            ____t_result_166 = __TS__New(
                ____Set_165,
                ____call_164(
                    ____temp_163,
                    "map",
                    function(____, value) return __TS__ParseInt(
                        __call(value, "slice", 1),
                        16
                    ) end
                )
            )
        else
            ____t_result_166 = nil
        end
        local hair = ____t_result_166
        do
            local y = 0
            while y < size do
                do
                    local x = 0
                    while x < size do
                        do
                            local i = (y * size + x) * 4
                            if not __t(__get(image.data, i + 3)) then
                                do x = x + 1 continue end
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
                            local ____t_result_169
                            local ____t_168 = __t
                            local ____callq_result_167 = __callq(hair, "has", color)
                            __O[2568] = ____callq_result_167
                            if ____t_168(____callq_result_167) then
                                ____t_result_169 = yy < hip + 7
                            else
                                ____t_result_169 = __O[2568]
                            end
                            local hairPixel = ____t_result_169
                            local ____t_result_176
                            local ____t_175 = __t
                            local ____t_result_174
                            local ____t_173 = __t
                            local ____t_result_172
                            local ____t_171 = __t
                            local ____temp_170 = id == "daroca" and xx < -10
                            __O[2569] = ____temp_170
                            if ____t_171(____temp_170) then
                                ____t_result_172 = yy > -39
                            else
                                ____t_result_172 = __O[2569]
                            end
                            __O[2570] = ____t_result_172
                            if ____t_173(____t_result_172) then
                                ____t_result_174 = yy < -14
                            else
                                ____t_result_174 = __O[2570]
                            end
                            __O[2571] = ____t_result_174
                            if ____t_175(____t_result_174) then
                                ____t_result_176 = __call(
                                    __arrL({6250561, 9273674, 11641442}, 3),
                                    "includes",
                                    color
                                )
                            else
                                ____t_result_176 = __O[2571]
                            end
                            local backpack = ____t_result_176
                            local half = profile.coreHalf
                            if __t(id == "igor" and yy > profile.neckY) then
                                local q = (yy + 33) / 28
                                half = math.max(
                                    8,
                                    profile.coreHalf * math.sqrt(math.max(0, 1 - q * q))
                                )
                            end
                            local torso = yy <= hip + (id == "igor" and 5 or 1) and math.abs(xx) <= half
                            local headHalf = id == "ollyan" and 37 or (id == "daroca" and 25 or (__t(__call(girls, "has", id)) and 27 or (id == "nikolas" and 28 or 18)))
                            local head = yy < profile.neckY and math.abs(xx) <= headHalf
                            local ____t_182 = __t
                            local ____t_result_181
                            local ____t_180 = __t
                            local ____t_result_179
                            local ____t_178 = __t
                            local ____t_result_177
                            if __t(head) then
                                ____t_result_177 = head
                            else
                                ____t_result_177 = torso
                            end
                            __O[2572] = ____t_result_177
                            if ____t_178(____t_result_177) then
                                ____t_result_179 = __O[2572]
                            else
                                ____t_result_179 = hairPixel
                            end
                            __O[2573] = ____t_result_179
                            if ____t_180(____t_result_179) then
                                ____t_result_181 = __O[2573]
                            else
                                ____t_result_181 = backpack
                            end
                            if not ____t_182(____t_result_181) then
                                __set(image.data, i + 3, 0)
                            end
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
        local ____t_result_185
        local ____t_184 = __t
        local ____TS__Number_result_183 = __TS__Number(p.motionTime)
        __O[2574] = ____TS__Number_result_183
        if ____t_184(____TS__Number_result_183) then
            ____t_result_185 = __O[2574]
        else
            ____t_result_185 = 0
        end
        local mt = math.max(0, ____t_result_185)
        local ____t_result_188
        local ____t_187 = __t
        local ____TS__Number_result_186 = __TS__Number(p.vy)
        __O[2575] = ____TS__Number_result_186
        if ____t_187(____TS__Number_result_186) then
            ____t_result_188 = __O[2575]
        else
            ____t_result_188 = 0
        end
        local vy = ____t_result_188
        local ____time_192 = time
        local ____t_result_191
        local ____t_190 = __t
        local ____get_result_189 = __get(gait, id)
        __O[2576] = ____get_result_189
        if ____t_190(____get_result_189) then
            ____t_result_191 = __O[2576]
        else
            ____t_result_191 = 10.7
        end
        local phase = ____time_192 * ____t_result_191
        local ____t_result_197
        local ____t_196 = __t
        local ____t_result_195
        local ____t_194 = __t
        local ____TS__Number_result_193 = __TS__Number(p.wallSide)
        __O[2577] = ____TS__Number_result_193
        if ____t_194(____TS__Number_result_193) then
            ____t_result_195 = __O[2577]
        else
            ____t_result_195 = __TS__Number(p.facing)
        end
        __O[2578] = ____t_result_195
        if ____t_196(____t_result_195) then
            ____t_result_197 = __O[2578]
        else
            ____t_result_197 = 1
        end
        local wall = ____t_result_197 * (__lt(p.facing, 0) and -1 or 1)
        local ____t_result_200
        local ____t_199 = __t
        local ____temp_198 = id == "igor" or id == "davi"
        __O[2579] = ____temp_198
        if ____t_199(____temp_198) then
            ____t_result_200 = __O[2579]
        else
            ____t_result_200 = id == "allef"
        end
        local heavy = ____t_result_200
        local quick = id == "lucas" or id == "menezes"
        local ____temp_201
        if motion == "land" then
            ____temp_201 = 1 - smooth(nil, 0.01, 0.13, mt)
        else
            ____temp_201 = 0
        end
        local land = ____temp_201
        local lean = 0
        local dx = 0
        local dy = 0
        local armLift = 0
        if motion == "run" then
            lean = __t(heavy) and 0.055 or (__t(quick) and 0.17 or 0.12)
            dy = -math.abs(math.sin(phase)) * 2.7
        elseif motion == "jump" then
            local launch = p.jumps == 2 and 0 or 1 - smooth(nil, 0.025, 0.15, mt)
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
            lean = (__t(heavy) and 0.22 or 0.39) * drive
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
            dy = land * (__t(heavy) and 5 or 6)
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
                local ____temp_202
                if side < 0 then
                    ____temp_202 = math.pi
                else
                    ____temp_202 = 0
                end
                local swing = math.sin(phase + ____temp_202)
                target = __arrL(
                    {
                        side * spread + swing * L * 0.86,
                        sy + L * (0.24 + 0.28 * (1 - math.abs(swing)))
                    },
                    2
                )
                bend = side < 0 and -1 or 1
            elseif m == "jump" then
                local launch = p.jumps == 2 and 0 or 1 - smooth(nil, 0.02, 0.16, mt)
                local rise = clamp(
                    nil,
                    (__TS__Number(-pose.vy) - 50) / 360,
                    0,
                    1
                )
                local ____temp_203
                if side > 0 then
                    ____temp_203 = __arrL({spread + L * 0.43, sy + L * (0.72 - launch * 1.13 - rise * 0.16)}, 2)
                else
                    ____temp_203 = __arrL({-spread - L * 0.38, sy + L * (0.7 - launch * 0.62)}, 2)
                end
                target = ____temp_203
            elseif m == "doubleJump" then
                local open = smooth(nil, 0.04, 0.2, mt)
                target = __arrL({side * (spread + L * (0.34 + open * 0.42)), sy - L * (0.75 - open * 0.62)}, 2)
            elseif m == "fall" then
                target = __arrL({side * (spread + L * (0.62 + pose.armLift * 0.12)), sy + L * (0.37 - pose.armLift * 0.44)}, 2)
            elseif m == "dash" then
                local ____temp_204
                if side < 0 then
                    ____temp_204 = __arrL({-spread - L * 0.9, sy + L * 0.16}, 2)
                else
                    ____temp_204 = __arrL({spread - L * 0.24, sy - L * 0.46}, 2)
                end
                target = ____temp_204
                bend = side < 0 and 1 or -1
            elseif m == "wallSlide" then
                target = __arrL({pose.wall * (spread + L * 0.48), sy - L * (side < 0 and 0.46 or 0.03)}, 2)
                bend = pose.wall
            elseif m == "wallJump" then
                local release = 1 - smooth(nil, 0.02, 0.2, mt)
                local ____temp_205
                if side < 0 then
                    ____temp_205 = __arrL({-spread - L * 0.52, sy - L * 0.42 * release}, 2)
                else
                    ____temp_205 = __arrL({spread + L * 0.54, sy + L * (0.22 - 0.64 * release)}, 2)
                end
                target = ____temp_205
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
        local ____t_result_208
        local ____t_207 = __t
        local ____get_result_206 = __get(sleeveColors, id)
        __O[2580] = ____get_result_206
        if ____t_207(____get_result_206) then
            ____t_result_208 = __O[2580]
        else
            ____t_result_208 = "#d9a763"
        end
        local shirt = ____t_result_208
        local ____t_result_211
        local ____t_210 = __t
        local ____get_result_209 = __get(skin, id)
        __O[2581] = ____get_result_209
        if ____t_210(____get_result_209) then
            ____t_result_211 = __O[2581]
        else
            ____t_result_211 = "#d5a478"
        end
        local flesh = ____t_result_211
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
        local ____line_215 = line
        local ____c_213 = c
        local ____arrL_result_214 = __arrL({arm.knee, arm.foot}, 2)
        local ____t_result_212
        if __t(long) then
            ____t_result_212 = shirt
        else
            ____t_result_212 = flesh
        end
        ____line_215(
            nil,
            ____c_213,
            ____arrL_result_214,
            ____t_result_212,
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
        local ____t_219 = __t
        local ____t_result_218
        local ____t_217 = __t
        local ____call_result_216 = __call(girls, "has", id)
        __O[2582] = ____call_result_216
        if ____t_217(____call_result_216) then
            ____t_result_218 = __lt(arm.side, 0)
        else
            ____t_result_218 = __O[2582]
        end
        if ____t_219(____t_result_218) then
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
            __get(arms.arms, id == "marco" and 0 or 1),
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
        local ____t_result_226
        local ____t_225 = __t
        local ____opt_222 = window.ArenaCombat
        if ____opt_222 ~= nil then
            ____opt_222 = ____opt_222.attack
        end
        local ____opt_result_224
        if ____opt_222 ~= nil then
            ____opt_result_224 = ____opt_222(
                ____opt_222,
                id,
                kind,
                dir,
                {facing = 1}
            )
        end
        __O[2583] = ____opt_result_224
        if ____t_225(____opt_result_224) then
            ____t_result_226 = __O[2583]
        else
            ____t_result_226 = {windup = 0.1, duration = 0.13, recovery = 0.2}
        end
        local d = ____t_result_226
        __call(attackVisualCache, "set", key, d)
        return d
    end
    local function attackPose(self, id, p)
        local ____t_result_227
        if __t(p.attackType) then
            ____t_result_227 = p.attackType
        else
            ____t_result_227 = "physical"
        end
        local kind = ____t_result_227
        local ____t_result_228
        if __t(p.attackDirection) then
            ____t_result_228 = p.attackDirection
        else
            ____t_result_228 = "side"
        end
        local dir = ____t_result_228
        local d = attackVisual(nil, id, kind, dir)
        local ____t_result_231
        local ____t_230 = __t
        local ____TS__Number_result_229 = __TS__Number(p.attackTotal)
        __O[2584] = ____TS__Number_result_229
        if ____t_230(____TS__Number_result_229) then
            ____t_result_231 = __O[2584]
        else
            ____t_result_231 = __add(
                __add(d.windup, d.duration),
                d.recovery
            )
        end
        local total = math.max(0.35, ____t_result_231)
        local ____t_result_234
        local ____t_233 = __t
        local ____TS__Number_result_232 = __TS__Number(p.attackProgress)
        __O[2585] = ____TS__Number_result_232
        if ____t_233(____TS__Number_result_232) then
            ____t_result_234 = __O[2585]
        else
            ____t_result_234 = 0
        end
        local progress = clamp(nil, ____t_result_234, 0, 1)
        local at = progress * total
        local ____temp_239
        if kind == "combo" then
            local ____t_result_238
            local ____t_237 = __t
            local ____opt_235 = d.finisher
            if ____opt_235 ~= nil then
                ____opt_235 = ____opt_235.hits
            end
            __O[2586] = ____opt_235
            if ____t_237(____opt_235) then
                ____t_result_238 = __O[2586]
            else
                ____t_result_238 = __arrL({{delay = 0}}, 1)
            end
            ____temp_239 = ____t_result_238
        else
            ____temp_239 = __arrL({{delay = 0}}, 1)
        end
        local beats = ____temp_239
        local beat = __get(beats, 0)
        local distance = math.huge
        for ____, h in __iterar((beats)) do
            local ____add_242 = __add
            local ____d_windup_241 = d.windup
            local ____t_result_240
            if __t(h.delay) then
                ____t_result_240 = h.delay
            else
                ____t_result_240 = 0
            end
            local diff = at - ____add_242(____d_windup_241, ____t_result_240)
            if math.abs(diff) < distance then
                beat = h
                distance = math.abs(diff)
            end
        end
        local ____add_245 = __add
        local ____d_windup_244 = d.windup
        local ____t_result_243
        if __t(beat.delay) then
            ____t_result_243 = beat.delay
        else
            ____t_result_243 = 0
        end
        local contact = ____add_245(____d_windup_244, ____t_result_243)
        local relative = at - contact
        local ____temp_246
        if relative < 0 then
            ____temp_246 = smooth(nil, -0.14, -0.025, relative)
        else
            ____temp_246 = 0
        end
        local wind = ____temp_246
        local drive = smooth(nil, -0.035, 0.025, relative) * (1 - smooth(nil, 0.09, 0.23, relative))
        local recover = smooth(nil, 0.035, 0.23, relative)
        local power = kind == "combo" and 1.15 or (kind == "ranged" and 0.75 or 1)
        local heavy = __call(
            __arrL({"igor", "caleb", "davi", "allef"}, 4),
            "includes",
            id
        )
        local ____t_result_253
        local ____t_252 = __t
        local ____t_result_251
        local ____t_250 = __t
        local ____t_result_249
        local ____t_248 = __t
        local ____call_result_247 = __call(girls, "has", id)
        __O[2587] = ____call_result_247
        if ____t_248(____call_result_247) then
            ____t_result_249 = __O[2587]
        else
            ____t_result_249 = id == "freddy"
        end
        __O[2588] = ____t_result_249
        if ____t_250(____t_result_249) then
            ____t_result_251 = __O[2588]
        else
            ____t_result_251 = id == "mota"
        end
        __O[2589] = ____t_result_251
        if ____t_252(____t_result_251) then
            ____t_result_253 = kind ~= "ranged"
        else
            ____t_result_253 = __O[2589]
        end
        local kick = ____t_result_253
        local angle = dir == "up" and -1.15 or (dir == "down" and 1.05 or 0)
        local ____kind_260 = kind
        local ____dir_261 = dir
        local ____d_262 = d
        local ____total_263 = total
        local ____at_264 = at
        local ____progress_265 = progress
        local ____relative_266 = relative
        local ____wind_267 = wind
        local ____drive_268 = drive
        local ____recover_269 = recover
        local ____power_270 = power
        local ____heavy_271 = heavy
        local ____kick_272 = kick
        local ____angle_273 = angle
        local ____smooth_result_274 = smooth(nil, total - 0.2, total, at)
        local ____smooth_result_275 = smooth(nil, 0, 0.065, at)
        local ____t_result_254
        if __t(beat.shape) then
            ____t_result_254 = beat.shape
        else
            ____t_result_254 = d.shape
        end
        local ____temp_276 = (drive * (__t(heavy) and 2.6 or 4.5) - wind * 2.5) * power
        local ____temp_256
        if dir == "down" then
            ____temp_256 = drive * 2.6
        else
            local ____temp_255
            if dir == "up" then
                ____temp_255 = -drive * 2
            else
                ____temp_255 = wind * 1.3
            end
            ____temp_256 = ____temp_255
        end
        local ____temp_277 = (dir == "up" and -0.1 or (dir == "down" and 0.14 or 0.12)) * drive * power - 0.075 * wind
        local ____t_result_259
        local ____t_258 = __t
        local ____temp_257 = kind == "ranged" and relative >= 0
        __O[2590] = ____temp_257
        if ____t_258(____temp_257) then
            ____t_result_259 = relative < 0.065
        else
            ____t_result_259 = __O[2590]
        end
        return {
            kind = ____kind_260,
            dir = ____dir_261,
            d = ____d_262,
            total = ____total_263,
            at = ____at_264,
            progress = ____progress_265,
            relative = ____relative_266,
            wind = ____wind_267,
            drive = ____drive_268,
            recover = ____recover_269,
            power = ____power_270,
            heavy = ____heavy_271,
            kick = ____kick_272,
            angle = ____angle_273,
            settle = ____smooth_result_274,
            guard = ____smooth_result_275,
            shape = ____t_result_254,
            dx = ____temp_276,
            dy = ____temp_256,
            lean = ____temp_277,
            release = ____t_result_259
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
                local ____t_281 = __t
                local ____t_result_280
                local ____t_279 = __t
                local ____temp_278 = pose.kind == "ranged"
                __O[2591] = ____temp_278
                if ____t_279(____temp_278) then
                    ____t_result_280 = __call(
                        __arrL({"reeis", "kaique"}, 2),
                        "includes",
                        id
                    )
                else
                    ____t_result_280 = __O[2591]
                end
                if ____t_281(____t_result_280) then
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
                local ____t_285 = __t
                local ____t_result_284
                local ____t_283 = __t
                local ____temp_282 = pose.kind == "ranged"
                __O[2592] = ____temp_282
                if ____t_283(____temp_282) then
                    ____t_result_284 = __call(
                        __arrL({"reeis", "kaique"}, 2),
                        "includes",
                        id
                    )
                else
                    ____t_result_284 = __O[2592]
                end
                if ____t_285(____t_result_284) then
                    target = __arrL({sx + L * (0.85 - pose.drive * 0.22), sy + L * 0.12}, 2)
                end
                local ____t_289 = __t
                local ____t_result_288
                local ____t_287 = __t
                local ____temp_286 = id == "nikolas" and pose.kind == "ranged"
                __O[2593] = ____temp_286
                if ____t_287(____temp_286) then
                    ____t_result_288 = pose.wind > 0
                else
                    ____t_result_288 = __O[2593]
                end
                if ____t_289(____t_result_288) then
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
            local ____firearm_294 = firearm
            local ____c_292 = c
            local ____t_result_290
            if __t(ranged) then
                ____t_result_290 = __TS__Number(-pose.drive) * 0.16
            else
                ____t_result_290 = turn * 0.45
            end
            local ____temp_293 = a + ____t_result_290
            local ____t_result_291
            if __t(ranged) then
                ____t_result_291 = pose.release
            else
                ____t_result_291 = ranged
            end
            ____firearm_294(
                nil,
                ____c_292,
                x,
                y,
                ____temp_293,
                ____t_result_291
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
        local ____t_298 = __t
        local ____t_result_297
        local ____t_296 = __t
        local ____temp_295 = id == "marco" or id == "kaua"
        __O[2594] = ____temp_295
        if ____t_296(____temp_295) then
            ____t_result_297 = __O[2594]
        else
            ____t_result_297 = id == "miqueias"
        end
        if ____t_298(____t_result_297) then
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
                id == "marco" and "#e8bd70" or (id == "kaua" and "#efc85d" or "#d2dcbd")
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
            local ____t_304 = __t
            local ____t_result_303
            local ____t_302 = __t
            local ____t_result_301
            local ____t_300 = __t
            local ____temp_299 = id == "marco"
            __O[2595] = ____temp_299
            if ____t_300(____temp_299) then
                ____t_result_301 = ranged
            else
                ____t_result_301 = __O[2595]
            end
            __O[2596] = ____t_result_301
            if ____t_302(____t_result_301) then
                ____t_result_303 = __gt(pose.wind, 0.1)
            else
                ____t_result_303 = __O[2596]
            end
            if ____t_304(____t_result_303) then
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
            local ____t_306 = __t
            local ____t_result_305
            if __t(ranged) then
                ____t_result_305 = hold
            else
                ____t_result_305 = ranged
            end
            if ____t_306(____t_result_305) then
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
                local ____ball_310 = ball
                local ____c_309 = c
                local ____t_result_307
                if __t(ranged) then
                    ____t_result_307 = x + 2
                else
                    ____t_result_307 = 15
                end
                local ____t_result_308
                if __t(ranged) then
                    ____t_result_308 = y
                else
                    ____t_result_308 = -9
                end
                ____ball_310(
                    nil,
                    ____c_309,
                    ____t_result_307,
                    ____t_result_308,
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
        local ____t_314 = __t
        local ____t_result_313
        local ____t_312 = __t
        local ____temp_311 = not __t(ranged)
        __O[2597] = ____temp_311
        if ____t_312(____temp_311) then
            ____t_result_313 = __call(
                __arrL({"arthur", "almiro", "allef"}, 3),
                "includes",
                id
            )
        else
            ____t_result_313 = __O[2597]
        end
        if ____t_314(____t_result_313) then
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
        local ____t_318 = __t
        local ____t_result_317
        local ____t_316 = __t
        local ____temp_315 = id == "ollyan" and not __t(ranged)
        __O[2598] = ____temp_315
        if ____t_316(____temp_315) then
            ____t_result_317 = __gt(pose.drive, 0.4)
        else
            ____t_result_317 = __O[2598]
        end
        if ____t_318(____t_result_317) then
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
                        __t(i) and "#84c9eb" or "#e8f6ee"
                    )
                    i = i + 1
                end
            end
            return
        end
        local ____t_322 = __t
        local ____t_result_321
        local ____t_320 = __t
        local ____temp_319 = id == "dede" and not __t(ranged)
        __O[2599] = ____temp_319
        if ____t_320(____temp_319) then
            ____t_result_321 = __gt(pose.drive, 0.5)
        else
            ____t_result_321 = __O[2599]
        end
        if ____t_322(____t_result_321) then
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
            local ____t_324 = __t
            local ____t_result_323
            if __t(ranged) then
                ____t_result_323 = __gt(pose.wind, 0.1)
            else
                ____t_result_323 = ranged
            end
            if ____t_324(____t_result_323) then
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
        local ____t_326 = __t
        local ____t_result_325
        if __t(ranged) then
            ____t_result_325 = hold
        else
            ____t_result_325 = ranged
        end
        if ____t_326(____t_result_325) then
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
        local ____t_result_327
        if __t(pose.kick) then
            ____t_result_327 = clamp(nil, 0.08 + pose.drive * 0.47, 0, 0.55)
        else
            ____t_result_327 = 0
        end
        local kickProgress = ____t_result_327
        local ____legPose_330 = legPose
        local ____id_329 = id
        local ____temp_328
        if p.ground == false then
            ____temp_328 = inferMotion(nil, p)
        else
            ____temp_328 = "idle"
        end
        local legs = ____legPose_330(
            nil,
            ____id_329,
            ____temp_328,
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
        local ____t_334 = __t
        local ____t_result_333
        local ____t_332 = __t
        local ____temp_331 = pose.kind ~= "ranged" and pose.drive > 0.6
        __O[2600] = ____temp_331
        if ____t_332(____temp_331) then
            ____t_result_333 = pose.relative < 0.095
        else
            ____t_result_333 = __O[2600]
        end
        if ____t_334(____t_result_333) then
            local ____t_result_335
            if __t(pose.kick) then
                ____t_result_335 = __get(legs.legs, 1).foot
            else
                ____t_result_335 = __get(arms.arms, 1).foot
            end
            local foot = ____t_result_335
            local x = __get(foot, 0) + (__t(pose.kick) and 0 or pose.dx)
            local y = __get(foot, 1) + (__t(pose.kick) and 0 or pose.dy)
            local ____t_result_336
            if __t(pose.kick) then
                ____t_result_336 = pose.dir == "up" and -1.4 or (pose.dir == "down" and 0.7 or 0)
            else
                ____t_result_336 = pose.angle
            end
            local a = ____t_result_336
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
        local ____t_343 = __t
        local ____t_result_342
        local ____t_341 = __t
        local ____temp_340 = not __t(p) or p.stocks == 0
        __O[2601] = ____temp_340
        if ____t_341(____temp_340) then
            ____t_result_342 = __O[2601]
        else
            ____t_result_342 = p.eliminated
        end
        if ____t_343(____t_result_342) then
            return
        end
        local ____t_result_344
        if __t(p.character) then
            ____t_result_344 = p.character
        else
            ____t_result_344 = "daroca"
        end
        local id = ____t_result_344
        local k = kit(nil, id)
        local face = __lt(p.facing, 0) and -1 or 1
        local ____t_result_347
        local ____t_346 = __t
        local ____TS__Number_result_345 = __TS__Number(time)
        __O[2602] = ____TS__Number_result_345
        if ____t_346(____TS__Number_result_345) then
            ____t_result_347 = __O[2602]
        else
            ____t_result_347 = 0
        end
        local t = ____t_result_347
        local height = id == "lucas" and 60 or 70
        local scale = height / bodyHeight(nil, id)
        local emoting = __gt(p.emote, 0)
        local ____t_result_350
        local ____t_349 = __t
        local ____gt_result_348 = __gt(p.attackAnim, 0)
        __O[2603] = ____gt_result_348
        if ____t_349(____gt_result_348) then
            ____t_result_350 = __O[2603]
        else
            ____t_result_350 = __gt(p.attackProgress, 0) and __lt(p.attackProgress, 1)
        end
        local attack = ____t_result_350
        local ____p_attackProgress_352 = p.attackProgress
        if ____p_attackProgress_352 == nil then
            local ____t_result_351
            if __t(p.attackAnim) then
                ____t_result_351 = p.attackAnim
            else
                ____t_result_351 = 0
            end
            ____p_attackProgress_352 = 1 - ____t_result_351 / 0.42
        end
        local progress = clamp(nil, ____p_attackProgress_352, 0, 1)
        local ____t_result_353
        if __t(attack) then
            ____t_result_353 = p.attackType ~= "ranged"
        else
            ____t_result_353 = attack
        end
        local physical = ____t_result_353
        local ____t_result_354
        if __t(attack) then
            ____t_result_354 = p.attackType == "combo"
        else
            ____t_result_354 = attack
        end
        local combo = ____t_result_354
        local ____t_result_355
        if __t(p.attackDirection) then
            ____t_result_355 = p.attackDirection
        else
            ____t_result_355 = "side"
        end
        local dir = ____t_result_355
        local ____t_result_356
        if __t(p.attackShape) then
            ____t_result_356 = p.attackShape
        else
            ____t_result_356 = ""
        end
        local shape = tostring(____t_result_356)
        local ____t_result_359
        local ____t_358 = __t
        local ____get_result_357 = __get(skin, id)
        __O[2604] = ____get_result_357
        if ____t_358(____get_result_357) then
            ____t_result_359 = __O[2604]
        else
            ____t_result_359 = "#d5a478"
        end
        local skinColor = ____t_result_359
        local motion = inferMotion(nil, p)
        local ____t_result_362
        local ____t_361 = __t
        local ____TS__Number_result_360 = __TS__Number(p.motionTime)
        __O[2605] = ____TS__Number_result_360
        if ____t_361(____TS__Number_result_360) then
            ____t_result_362 = __O[2605]
        else
            ____t_result_362 = 0
        end
        local mt = ____t_result_362
        local strike = smooth(nil, 0.16, 0.44, progress) * (1 - smooth(nil, 0.61, 1, progress))
        local ____t_result_365
        local ____t_364 = __t
        local ____t_result_363
        if __t(attack) then
            ____t_result_363 = progress > 0.2
        else
            ____t_result_363 = attack
        end
        __O[2606] = ____t_result_363
        if ____t_364(____t_result_363) then
            ____t_result_365 = progress < 0.8
        else
            ____t_result_365 = __O[2606]
        end
        local active = ____t_result_365
        local ____t_result_368
        local ____t_367 = __t
        local ____TS__Number_result_366 = __TS__Number(p.wallSide)
        __O[2607] = ____TS__Number_result_366
        if ____t_367(____TS__Number_result_366) then
            ____t_result_368 = __O[2607]
        else
            ____t_result_368 = face
        end
        local wallLocal = ____t_result_368 * face
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
                        __t(__mod(i, 2)) and "#fff3c6" or "#ffd265"
                    )
                    i = i + 1
                end
            end
        end
        local ____gt_370 = __gt
        local ____t_result_369
        if __t(p.transform) then
            ____t_result_369 = p.transform
        else
            ____t_result_369 = 0
        end
        if ____gt_370(____t_result_369, 0) then
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
        local ____t_374 = __t
        local ____t_result_373
        local ____t_372 = __t
        local ____temp_371 = motion == "doubleJump" or motion == "wallJump"
        __O[2608] = ____temp_371
        if ____t_372(____temp_371) then
            ____t_result_373 = mt < 0.18
        else
            ____t_result_373 = __O[2608]
        end
        if ____t_374(____t_result_373) then
            local q = mt / 0.18
            local ____temp_375
            if motion == "wallJump" then
                ____temp_375 = wallLocal * 21
            else
                ____temp_375 = 0
            end
            local xx = ____temp_375
            do
                local i = 0
                while i < 3 do
                    local ____rect_378 = rect
                    local ____array_377 = __TS__SparseArrayNew(
                        nil,
                        c,
                        xx + (i - 1) * (6 + q * 7),
                        -7 - q * (__t(__mod(i, 2)) and 6 or 2),
                        3,
                        3
                    )
                    local ____t_result_376
                    if __t(__mod(i, 2)) then
                        ____t_result_376 = k.color
                    else
                        ____t_result_376 = "#fff0b4"
                    end
                    __TS__SparseArrayPush(____array_377, ____t_result_376)
                    ____rect_378(__TS__SparseArraySpread(____array_377))
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
        local ____t_result_383
        local ____t_382 = __t
        local ____t_result_381
        local ____t_380 = __t
        local ____temp_379 = not __t(attack) and not __t(emoting)
        __O[2609] = ____temp_379
        if ____t_380(____temp_379) then
            ____t_result_381 = motion ~= "idle"
        else
            ____t_result_381 = __O[2609]
        end
        __O[2610] = ____t_result_381
        if ____t_382(____t_result_381) then
            ____t_result_383 = id ~= "giant"
        else
            ____t_result_383 = __O[2610]
        end
        local useMovementRig = ____t_result_383
        local ____t_385 = __t
        local ____t_result_384
        if __t(attack) then
            ____t_result_384 = id ~= "giant"
        else
            ____t_result_384 = attack
        end
        if ____t_385(____t_result_384) then
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
            local ____t_387 = __t
            local ____t_result_386
            if __t(emoting) then
                ____t_result_386 = p.emoteKind == "dance"
            else
                ____t_result_386 = emoting
            end
            if ____t_387(____t_result_386) then
                c:translate(
                    math.sin(t * 7) * 3,
                    -math.abs(math.sin(t * 7)) * (id == "lucas" and 7 or 3)
                )
                c:rotate(math.sin(t * 7) * 0.065)
            elseif __t(physical) then
                local ____temp_388
                if progress < 0.18 then
                    ____temp_388 = math.sin(progress / 0.18 * math.pi) * -3
                else
                    ____temp_388 = 0
                end
                local windup = ____temp_388
                local ____c_391 = c
                local ____c_translate_392 = c.translate
                local ____temp_390 = windup + strike * 3
                local ____temp_389
                if dir == "down" then
                    ____temp_389 = strike * 2
                else
                    ____temp_389 = 0
                end
                ____c_translate_392(____c_391, ____temp_390, ____temp_389)
                c:rotate((dir == "up" and -0.07 or (dir == "down" and 0.025 or 0.075)) * strike)
            elseif motion == "run" then
                local ____t_result_395
                local ____t_394 = __t
                local ____get_result_393 = __get(gait, id)
                __O[2611] = ____get_result_393
                if ____t_394(____get_result_393) then
                    ____t_result_395 = __O[2611]
                else
                    ____t_result_395 = 10.7
                end
                local phase = t * ____t_result_395
                c:translate(
                    0,
                    -math.abs(math.sin(phase)) * 1.8
                )
                c:rotate(id == "igor" and 0.035 or 0.07)
            elseif motion == "dash" then
                c:translate(3, -3)
                c:rotate(id == "igor" and 0.16 or 0.24)
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
            local ____t_result_405
            local ____t_401 = __t
            local ____t_result_400
            local ____t_399 = __t
            local ____t_result_398
            local ____t_397 = __t
            local ____call_result_396 = __call(girls, "has", id)
            __O[2612] = ____call_result_396
            if ____t_397(____call_result_396) then
                ____t_result_398 = __O[2612]
            else
                ____t_result_398 = id == "freddy"
            end
            __O[2613] = ____t_result_398
            if ____t_399(____t_result_398) then
                ____t_result_400 = physical
            else
                ____t_result_400 = __O[2613]
            end
            __O[2615] = ____t_result_400
            if ____t_401(____t_result_400) then
                ____t_result_405 = __O[2615]
            else
                local ____t_result_404
                local ____t_403 = __t
                local ____temp_402 = id == "mota"
                __O[2614] = ____temp_402
                if ____t_403(____temp_402) then
                    ____t_result_404 = attack
                else
                    ____t_result_404 = __O[2614]
                end
                ____t_result_405 = ____t_result_404
            end
            local kick = ____t_result_405
            local ____t_result_408
            local ____t_407 = __t
            local ____call_result_406 = __call(girls, "has", id)
            __O[2616] = ____call_result_406
            if ____t_407(____call_result_406) then
                ____t_result_408 = physical
            else
                ____t_result_408 = __O[2616]
            end
            local kickGuard = ____t_result_408
            local ____legPose_410 = legPose
            local ____t_result_409
            if __t(kick) then
                ____t_result_409 = progress
            else
                ____t_result_409 = 0
            end
            local pose = ____legPose_410(
                nil,
                id,
                motion,
                t,
                dir,
                ____t_result_409,
                combo
            )
            local armHalf = id == "igor" and 22 or 14
            local ____t_result_421
            local ____t_412 = __t
            local ____temp_411 = id ~= "giant"
            __O[2620] = ____temp_411
            if ____t_412(____temp_411) then
                local ____t_result_420
                local ____t_419 = __t
                local ____t_result_418
                local ____t_414 = __t
                local ____temp_413 = motion == "wallSlide" and not __t(attack)
                __O[2618] = ____temp_413
                if ____t_414(____temp_413) then
                    ____t_result_418 = __O[2618]
                else
                    local ____t_result_417
                    local ____t_416 = __t
                    local ____t_result_415
                    if __t(attack) then
                        ____t_result_415 = active
                    else
                        ____t_result_415 = attack
                    end
                    __O[2617] = ____t_result_415
                    if ____t_416(____t_result_415) then
                        ____t_result_417 = not __t(kick)
                    else
                        ____t_result_417 = __O[2617]
                    end
                    ____t_result_418 = ____t_result_417
                end
                __O[2619] = ____t_result_418
                if ____t_419(____t_result_418) then
                    ____t_result_420 = __O[2619]
                else
                    ____t_result_420 = kickGuard
                end
                ____t_result_421 = ____t_result_420
            else
                ____t_result_421 = __O[2620]
            end
            local replaceArm = ____t_result_421
            local aimX = dir == "up" and 9 or (dir == "down" and 17 or (dir == "neutral" and 23 or 29))
            local ____temp_422
            if dir == "up" then
                ____temp_422 = -height + 14
            else
                ____temp_422 = dir == "down" and -23 or -35
            end
            local aimY = ____temp_422
            local function drawBase()
                local ____opt_450 = window.Art
                if ____opt_450 ~= nil then
                    ____opt_450 = ____opt_450.drawCharacter
                end
                local ____opt_result_452
                if ____opt_450 ~= nil then
                    local ____c_448 = c
                    local ____scale_443 = scale
                    local ____t_result_427
                    if __t(emoting) then
                        ____t_result_427 = t * 1.65
                    else
                        local ____t_result_426
                        local ____t_425 = __t
                        local ____get_result_424 = __get(gait, id)
                        __O[2621] = ____get_result_424
                        if ____t_425(____get_result_424) then
                            ____t_result_426 = __O[2621]
                        else
                            ____t_result_426 = 10.7
                        end
                        ____t_result_427 = t * ____t_result_426 / 10.7
                    end
                    local ____temp_444 = not __t(__call(
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
                    local ____t_result_431
                    local ____t_429 = __t
                    local ____temp_428 = motion == "run" or motion == "dash"
                    __O[2622] = ____temp_428
                    if ____t_429(____temp_428) then
                        ____t_result_431 = __O[2622]
                    else
                        local ____t_result_430
                        if __t(emoting) then
                            ____t_result_430 = p.emoteKind == "dance"
                        else
                            ____t_result_430 = emoting
                        end
                        ____t_result_431 = ____t_result_430
                    end
                    local ____t_result_432
                    if __t(p.vx) then
                        ____t_result_432 = p.vx
                    else
                        ____t_result_432 = 0
                    end
                    local ____math_abs_result_445 = math.abs(____t_result_432)
                    local ____t_result_433
                    if __t(p.vy) then
                        ____t_result_433 = p.vy
                    else
                        ____t_result_433 = 0
                    end
                    local ____t_result_441
                    local ____t_437 = __t
                    local ____t_result_436
                    local ____t_435 = __t
                    local ____temp_434 = id == "nikolas"
                    __O[2623] = ____temp_434
                    if ____t_435(____temp_434) then
                        ____t_result_436 = emoting
                    else
                        ____t_result_436 = __O[2623]
                    end
                    __O[2625] = ____t_result_436
                    if ____t_437(____t_result_436) then
                        ____t_result_441 = __O[2625]
                    else
                        local ____t_result_440
                        local ____t_439 = __t
                        local ____temp_438 = not __t(attack) and not __t(emoting)
                        __O[2624] = ____temp_438
                        if ____t_439(____temp_438) then
                            ____t_result_440 = motion == "idle"
                        else
                            ____t_result_440 = __O[2624]
                        end
                        ____t_result_441 = ____t_result_440
                    end
                    local ____gt_result_446 = __gt(p.hit, 0)
                    local ____temp_447 = id == "arthur"
                    local ____t_result_442
                    if __t(emoting) then
                        ____t_result_442 = p.emoteKind == "taunt"
                    else
                        ____t_result_442 = emoting
                    end
                    ____opt_result_452 = ____opt_450(
                        ____opt_450,
                        ____c_448,
                        id,
                        0,
                        0,
                        {
                            scale = ____scale_443,
                            facing = 1,
                            frame = ____t_result_427,
                            grounded = ____temp_444,
                            moving = ____t_result_431,
                            speed = ____math_abs_result_445,
                            vy = ____t_result_433,
                            monitorBattle = true,
                            noseRub = ____t_result_441,
                            attack = false,
                            attackType = "paper",
                            attackProgress = progress,
                            hit = ____gt_result_446,
                            bossPhase = 1,
                            flight = false,
                            smoke = false,
                            bellyRolling = false,
                            expressive = ____temp_447,
                            talking = ____t_result_442,
                            injured = false
                        }
                    )
                end
                return ____opt_result_452
            end
            local ____t_455 = __t
            local ____opt_453 = window.Art
            if ____opt_453 ~= nil then
                ____opt_453 = ____opt_453.drawCharacter
            end
            if ____t_455(____opt_453) then
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
                        local ____temp_456
                        if motion == "wallSlide" then
                            ____temp_456 = wallLocal
                        else
                            ____temp_456 = 1
                        end
                        local side = ____temp_456
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
                    local ____t_460 = __t
                    local ____t_result_459
                    local ____t_458 = __t
                    local ____temp_457 = motion == "wallSlide" or motion == "wallJump"
                    __O[2626] = ____temp_457
                    if ____t_458(____temp_457) then
                        ____t_result_459 = wallLocal < 0
                    else
                        ____t_result_459 = __O[2626]
                    end
                    if ____t_460(____t_result_459) then
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
            local ____t_464 = __t
            local ____t_result_463
            local ____t_462 = __t
            local ____temp_461 = motion == "wallSlide" and not __t(attack)
            __O[2627] = ____temp_461
            if ____t_462(____temp_461) then
                ____t_result_463 = id ~= "giant"
            else
                ____t_result_463 = __O[2627]
            end
            if ____t_464(____t_result_463) then
                local wx = wallLocal * (id == "igor" and 29 or 21)
                local sx = wallLocal * (id == "igor" and 19 or 9)
                line(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({sx, -43}, 2),
                            __arrL({wallLocal * (id == "igor" and 26 or 16), -37}, 2),
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
                            __arrL({wallLocal * (id == "igor" and 26 or 16), -37}, 2),
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
                local lift = dir == "up" and 12 or (dir == "down" and 7 or 10)
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
            local ____t_470 = __t
            local ____t_result_469
            local ____t_468 = __t
            local ____t_result_467
            local ____t_466 = __t
            local ____t_result_465
            if __t(attack) then
                ____t_result_465 = active
            else
                ____t_result_465 = attack
            end
            __O[2628] = ____t_result_465
            if ____t_466(____t_result_465) then
                ____t_result_467 = not __t(kick)
            else
                ____t_result_467 = __O[2628]
            end
            __O[2629] = ____t_result_467
            if ____t_468(____t_result_467) then
                ____t_result_469 = id ~= "giant"
            else
                ____t_result_469 = __O[2629]
            end
            if ____t_470(____t_result_469) then
                local ____t_result_473
                local ____t_472 = __t
                local ____get_result_471 = __get({
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
                __O[2630] = ____get_result_471
                if ____t_472(____get_result_471) then
                    ____t_result_473 = __O[2630]
                else
                    ____t_result_473 = "#e4d8b7"
                end
                local sleeve = ____t_result_473
                local shoulder = __arrL({id == "igor" and 19 or 9, -42}, 2)
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
                local ____t_477 = __t
                local ____t_result_476
                local ____t_475 = __t
                local ____temp_474 = not __t(physical)
                __O[2631] = ____temp_474
                if ____t_475(____temp_474) then
                    ____t_result_476 = __call(girls, "has", id)
                else
                    ____t_result_476 = __O[2631]
                end
                if ____t_477(____t_result_476) then
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
            local ____t_485 = __t
            local ____t_result_484
            local ____t_483 = __t
            local ____t_result_482
            local ____t_481 = __t
            local ____t_result_480
            local ____t_479 = __t
            local ____temp_478 = id == "mota"
            __O[2632] = ____temp_478
            if ____t_479(____temp_478) then
                ____t_result_480 = attack
            else
                ____t_result_480 = __O[2632]
            end
            __O[2633] = ____t_result_480
            if ____t_481(____t_result_480) then
                ____t_result_482 = active
            else
                ____t_result_482 = __O[2633]
            end
            __O[2634] = ____t_result_482
            if ____t_483(____t_result_482) then
                ____t_result_484 = not __t(physical)
            else
                ____t_result_484 = __O[2634]
            end
            if ____t_485(____t_result_484) then
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
            local ____t_491 = __t
            local ____t_result_490
            local ____t_489 = __t
            local ____t_result_488
            local ____t_487 = __t
            local ____temp_486 = id == "mota" and not __t(attack)
            __O[2635] = ____temp_486
            if ____t_487(____temp_486) then
                ____t_result_488 = not __t(p.ballAway)
            else
                ____t_result_488 = __O[2635]
            end
            __O[2636] = ____t_result_488
            if ____t_489(____t_result_488) then
                ____t_result_490 = motion == "idle"
            else
                ____t_result_490 = __O[2636]
            end
            if ____t_491(____t_result_490) then
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
            local ____t_495 = __t
            local ____t_result_494
            local ____t_493 = __t
            local ____temp_492 = id == "caleb" and not __t(attack)
            __O[2637] = ____temp_492
            if ____t_493(____temp_492) then
                ____t_result_494 = not __t(emoting)
            else
                ____t_result_494 = __O[2637]
            end
            if ____t_495(____t_result_494) then
                weight(
                    nil,
                    c,
                    20,
                    -29,
                    0.05,
                    0.48
                )
            end
            local ____t_497 = __t
            local ____t_result_496
            if __t(physical) then
                ____t_result_496 = active
            else
                ____t_result_496 = physical
            end
            if ____t_497(____t_result_496) then
                local hitX = aimX
                local hitY = aimY
                local ____temp_499
                if dir == "up" then
                    ____temp_499 = -math.pi / 2
                else
                    local ____temp_498
                    if dir == "down" then
                        ____temp_498 = math.pi / 2
                    else
                        ____temp_498 = 0
                    end
                    ____temp_499 = ____temp_498
                end
                local hitAngle = ____temp_499
                local hitScale = 0.75 + 0.2 * strike
                c:save()
                c:translate(hitX, hitY)
                c:scale(hitScale, hitScale)
                local ____t_507 = __t
                local ____t_result_506
                local ____t_505 = __t
                local ____t_result_504
                local ____t_503 = __t
                local ____t_result_502
                local ____t_501 = __t
                local ____temp_500 = progress > 0.32 and progress < 0.57
                __O[2638] = ____temp_500
                if ____t_501(____temp_500) then
                    ____t_result_502 = not __t(__call(girls, "has", id))
                else
                    ____t_result_502 = __O[2638]
                end
                __O[2639] = ____t_result_502
                if ____t_503(____t_result_502) then
                    ____t_result_504 = id ~= "dede"
                else
                    ____t_result_504 = __O[2639]
                end
                __O[2640] = ____t_result_504
                if ____t_505(____t_result_504) then
                    ____t_result_506 = id ~= "ollyan"
                else
                    ____t_result_506 = __O[2640]
                end
                if ____t_507(____t_result_506) then
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
                        id == "marco" and "#e8bd70" or (id == "miqueias" and "#b8d7cd" or "#e6ad52")
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
                        progress < 0.5 and "6" or "7",
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
        local ____t_511 = __t
        local ____t_result_510
        local ____t_509 = __t
        local ____t_result_508
        if __t(combo) then
            ____t_result_508 = progress > 0.3
        else
            ____t_result_508 = combo
        end
        __O[2641] = ____t_result_508
        if ____t_509(____t_result_508) then
            ____t_result_510 = progress < 0.6
        else
            ____t_result_510 = __O[2641]
        end
        if ____t_511(____t_result_510) then
            local phrase = __t(__call(girls, "has", id)) and "BIURIFUL!" or (id == "mota" and "GOLAÇO!" or (id == "igor" and "REBATE!" or (id == "lucas" and "SAPO NINJA!" or (id == "menezes" and "POUDII!" or (id == "reeis" and "OOO REEEIS!" or "")))))
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
                    local ____opt_514 = window.Art
                    if ____opt_514 ~= nil then
                        ____opt_514 = ____opt_514.drawRat
                    end
                    if ____opt_514 ~= nil then
                        ____opt_514(
                            ____opt_514,
                            c,
                            24,
                            -1,
                            t,
                            {scale = 0.35, facing = -1}
                        )
                    end
                end
            else
                local phrase = __t(__call(girls, "has", id)) and "AFF VEYR JURO" or (id == "caleb" and "CADÊ O SHAPE?" or (id == "igor" and "TEM LANCHE?" or (id == "lucas" and "BAIXINHO LIGEIRO" or (id == "menezes" and "PEGOU AR?" or (id == "reeis" and "CHAMOU O REI?" or (id == "mota" and "SÓ EMBAIXADINHA" or "RESPEITA A ROÇA"))))))
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
        local ____call_521 = __call
        local ____t_result_520
        local ____t_519 = __t
        local ____t_result_518
        local ____t_517 = __t
        local ____t_result_516
        if __t(s.type) then
            ____t_result_516 = s.type
        else
            ____t_result_516 = s.shape
        end
        __O[2642] = ____t_result_516
        if ____t_517(____t_result_516) then
            ____t_result_518 = __O[2642]
        else
            ____t_result_518 = s.effect
        end
        __O[2643] = ____t_result_518
        if ____t_519(____t_result_518) then
            ____t_result_520 = __O[2643]
        else
            ____t_result_520 = "paper"
        end
        return ____call_521(
            tostring(____t_result_520),
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
        local ____t_result_526
        local ____t_525 = __t
        local ____t_result_524
        local ____t_523 = __t
        local ____TS__Number_result_522 = __TS__Number(s.r)
        __O[2644] = ____TS__Number_result_522
        if ____t_523(____TS__Number_result_522) then
            ____t_result_524 = __O[2644]
        else
            ____t_result_524 = __TS__Number(s.radius)
        end
        __O[2645] = ____t_result_524
        if ____t_525(____t_result_524) then
            ____t_result_526 = __O[2645]
        else
            ____t_result_526 = 9
        end
        local r = math.max(
            4,
            math.min(28, ____t_result_526)
        )
        local ____t_result_527
        if __t(s.color) then
            ____t_result_527 = s.color
        else
            ____t_result_527 = "#f3d28a"
        end
        local color = ____t_result_527
        local ____t_result_530
        local ____t_529 = __t
        local ____TS__Number_result_528 = __TS__Number(time)
        __O[2646] = ____TS__Number_result_528
        if ____t_529(____TS__Number_result_528) then
            ____t_result_530 = __O[2646]
        else
            ____t_result_530 = 0
        end
        local t = ____t_result_530
        local ____t_result_533
        local ____t_532 = __t
        local ____TS__Number_result_531 = __TS__Number(s.vx)
        __O[2647] = ____TS__Number_result_531
        if ____t_532(____TS__Number_result_531) then
            ____t_result_533 = __O[2647]
        else
            ____t_result_533 = 0
        end
        local vx = ____t_result_533
        local ____t_result_536
        local ____t_535 = __t
        local ____TS__Number_result_534 = __TS__Number(s.vy)
        __O[2648] = ____TS__Number_result_534
        if ____t_535(____TS__Number_result_534) then
            ____t_result_536 = __O[2648]
        else
            ____t_result_536 = 0
        end
        local vy = ____t_result_536
        local angle = math.atan(vy, vx)
        local ____t_result_537
        if __t(__isFiniteN(s.maxLife) and __isFiniteN(s.life)) then
            ____t_result_537 = math.max(0, s.maxLife - s.life)
        else
            ____t_result_537 = t
        end
        local age = ____t_result_537
        local spin = age * (__t(__call(____type, "includes", "weight")) and 7 or 10) * (vx < 0 and -1 or 1)
        c:save()
        c.imageSmoothingEnabled = false
        c:translate(
            math.floor(s.x + 0.5),
            math.floor(s.y + 0.5)
        )
        local ____t_541 = __t
        local ____t_result_540
        local ____t_539 = __t
        local ____temp_538 = __hypot(vx, vy) > 220 and __re_test(
            __re("paper|heel|shoe|weight|ball|bullet|pen|ink|stone|brush", ""),
            ____type
        )
        __O[2649] = ____temp_538
        if ____t_539(____temp_538) then
            ____t_result_540 = ____type ~= "67"
        else
            ____t_result_540 = __O[2649]
        end
        if ____t_541(____t_result_540) then
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
                        i == 0 and 2 or 1,
                        i == 0 and "#fff0c1" or color
                    )
                    i = i + 1
                end
            end
            c:restore()
        end
        local ____t_545 = __t
        local ____t_result_544
        local ____t_543 = __t
        local ____call_result_542 = __call(
            __arrL({"tongue", "tether"}, 2),
            "some",
            function(____, q) return __call(____type, "includes", q) end
        )
        __O[2650] = ____call_result_542
        if ____t_543(____call_result_542) then
            ____t_result_544 = __O[2650]
        else
            ____t_result_544 = s.motion == "tether"
        end
        if ____t_545(____t_result_544) then
            local ____isFiniteN_result_547
            if __isFiniteN(s.originX) then
                ____isFiniteN_result_547 = s.originX - s.x
            else
                local ____isFiniteN_result_546
                if __isFiniteN(s.startX) then
                    ____isFiniteN_result_546 = s.startX - s.x
                else
                    ____isFiniteN_result_546 = -math.cos(angle) * 32
                end
                ____isFiniteN_result_547 = ____isFiniteN_result_546
            end
            local ox = ____isFiniteN_result_547
            local ____isFiniteN_result_549
            if __isFiniteN(s.originY) then
                ____isFiniteN_result_549 = s.originY - s.y
            else
                local ____isFiniteN_result_548
                if __isFiniteN(s.startY) then
                    ____isFiniteN_result_548 = s.startY - s.y - 7
                else
                    ____isFiniteN_result_548 = -math.sin(angle) * 32
                end
                ____isFiniteN_result_549 = ____isFiniteN_result_548
            end
            local oy = ____isFiniteN_result_549
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
            local ____t_553 = __t
            local ____t_result_552
            local ____t_551 = __t
            local ____call_result_550 = __call(____type, "includes", "heel")
            __O[2651] = ____call_result_550
            if ____t_551(____call_result_550) then
                ____t_result_552 = __O[2651]
            else
                ____t_result_552 = __call(____type, "includes", "shoe")
            end
            if ____t_553(____t_result_552) then
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
                local ____t_561 = __t
                local ____t_result_560
                local ____t_559 = __t
                local ____t_result_558
                local ____t_557 = __t
                local ____t_result_556
                local ____t_555 = __t
                local ____call_result_554 = __call(____type, "includes", "weight")
                __O[2652] = ____call_result_554
                if ____t_555(____call_result_554) then
                    ____t_result_556 = __O[2652]
                else
                    ____t_result_556 = __call(____type, "includes", "dumbbell")
                end
                __O[2653] = ____t_result_556
                if ____t_557(____t_result_556) then
                    ____t_result_558 = __O[2653]
                else
                    ____t_result_558 = __call(____type, "includes", "plate")
                end
                __O[2654] = ____t_result_558
                if ____t_559(____t_result_558) then
                    ____t_result_560 = __O[2654]
                else
                    ____t_result_560 = __call(____type, "includes", "anilha")
                end
                if ____t_561(____t_result_560) then
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
                    local ____t_567 = __t
                    local ____t_result_566
                    local ____t_565 = __t
                    local ____t_result_564
                    local ____t_563 = __t
                    local ____call_result_562 = __call(____type, "includes", "ball")
                    __O[2655] = ____call_result_562
                    if ____t_563(____call_result_562) then
                        ____t_result_564 = __O[2655]
                    else
                        ____t_result_564 = __call(____type, "includes", "football")
                    end
                    __O[2656] = ____t_result_564
                    if ____t_565(____t_result_564) then
                        ____t_result_566 = __O[2656]
                    else
                        ____t_result_566 = __call(____type, "includes", "futebol")
                    end
                    if ____t_567(____t_result_566) then
                        ball(
                            nil,
                            c,
                            0,
                            0,
                            spin,
                            0.95
                        )
                    else
                        local ____t_579 = __t
                        local ____t_result_578
                        local ____t_577 = __t
                        local ____t_result_576
                        local ____t_575 = __t
                        local ____t_result_574
                        local ____t_573 = __t
                        local ____t_result_572
                        local ____t_571 = __t
                        local ____t_result_570
                        local ____t_569 = __t
                        local ____call_result_568 = __call(____type, "includes", "word")
                        __O[2657] = ____call_result_568
                        if ____t_569(____call_result_568) then
                            ____t_result_570 = __O[2657]
                        else
                            ____t_result_570 = __call(____type, "includes", "text")
                        end
                        __O[2658] = ____t_result_570
                        if ____t_571(____t_result_570) then
                            ____t_result_572 = __O[2658]
                        else
                            ____t_result_572 = __call(____type, "includes", "chalk")
                        end
                        __O[2659] = ____t_result_572
                        if ____t_573(____t_result_572) then
                            ____t_result_574 = __O[2659]
                        else
                            ____t_result_574 = ____type == "monologue"
                        end
                        __O[2660] = ____t_result_574
                        if ____t_575(____t_result_574) then
                            ____t_result_576 = __O[2660]
                        else
                            ____t_result_576 = ____type == "english"
                        end
                        __O[2661] = ____t_result_576
                        if ____t_577(____t_result_576) then
                            ____t_result_578 = __O[2661]
                        else
                            ____t_result_578 = ____type == "ticket"
                        end
                        if ____t_579(____t_result_578) then
                            local ____call_581 = __call
                            local ____t_result_580
                            if __t(s.text) then
                                ____t_result_580 = s.text
                            else
                                ____t_result_580 = ____type == "english" and "ALLRIGHT!" or (____type == "monologue" and "BLÁ BLÁ BLÁ" or (____type == "ticket" and "SENHA 67" or "POUDII!"))
                            end
                            local phrase = ____call_581(
                                tostring(____t_result_580),
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
                                ____type == "ticket" and "#eddbaf" or "#243c48"
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
                                ____type == "ticket" and "#3f4e42" or "#f5e5bc"
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
                            local ____t_585 = __t
                            local ____t_result_584
                            local ____t_583 = __t
                            local ____call_result_582 = __call(____type, "includes", "wave")
                            __O[2662] = ____call_result_582
                            if ____t_583(____call_result_582) then
                                ____t_result_584 = __O[2662]
                            else
                                ____t_result_584 = s.motion == "wave"
                            end
                            if ____t_585(____t_result_584) then
                                do
                                    local i = 0
                                    while i < 4 do
                                        local xx = -i * 10
                                        local ____poly_589 = poly
                                        local ____c_587 = c
                                        local ____arrL_result_588 = __arrL(
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
                                        )
                                        local ____t_result_586
                                        if __t(__mod(i, 2)) then
                                            ____t_result_586 = color
                                        else
                                            ____t_result_586 = "#e9dfaa"
                                        end
                                        ____poly_589(nil, ____c_587, ____arrL_result_588, ____t_result_586)
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
                                local ____t_595 = __t
                                local ____t_result_594
                                local ____t_593 = __t
                                local ____t_result_592
                                local ____t_591 = __t
                                local ____call_result_590 = __call(____type, "includes", "smoke")
                                __O[2663] = ____call_result_590
                                if ____t_591(____call_result_590) then
                                    ____t_result_592 = __O[2663]
                                else
                                    ____t_result_592 = __call(____type, "includes", "gas")
                                end
                                __O[2664] = ____t_result_592
                                if ____t_593(____t_result_592) then
                                    ____t_result_594 = __O[2664]
                                else
                                    ____t_result_594 = __call(____type, "includes", "fart")
                                end
                                if ____t_595(____t_result_594) then
                                    puff(
                                        nil,
                                        c,
                                        -5,
                                        2,
                                        r,
                                        __t(__call(____type, "includes", "smoke")) and "#aabed4" or "#9bcf47",
                                        __t(__call(____type, "includes", "smoke")) and "#e9f3ff" or "#dffa79"
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
                                    local ____t_601 = __t
                                    local ____t_result_600
                                    local ____t_599 = __t
                                    local ____t_result_598
                                    local ____t_597 = __t
                                    local ____call_result_596 = __call(____type, "includes", "goo")
                                    __O[2665] = ____call_result_596
                                    if ____t_597(____call_result_596) then
                                        ____t_result_598 = __O[2665]
                                    else
                                        ____t_result_598 = __call(____type, "includes", "slime")
                                    end
                                    __O[2666] = ____t_result_598
                                    if ____t_599(____t_result_598) then
                                        ____t_result_600 = __O[2666]
                                    else
                                        ____t_result_600 = __call(____type, "includes", "catarro")
                                    end
                                    if ____t_601(____t_result_600) then
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
                                        local ____t_607 = __t
                                        local ____t_result_606
                                        local ____t_605 = __t
                                        local ____t_result_604
                                        local ____t_603 = __t
                                        local ____call_result_602 = __call(____type, "includes", "pencil")
                                        __O[2667] = ____call_result_602
                                        if ____t_603(____call_result_602) then
                                            ____t_result_604 = __O[2667]
                                        else
                                            ____t_result_604 = __call(____type, "includes", "pen")
                                        end
                                        __O[2668] = ____t_result_604
                                        if ____t_605(____t_result_604) then
                                            ____t_result_606 = __O[2668]
                                        else
                                            ____t_result_606 = __call(____type, "includes", "ruler")
                                        end
                                        if ____t_607(____t_result_606) then
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
                                            local ____t_611 = __t
                                            local ____t_result_610
                                            local ____t_609 = __t
                                            local ____call_result_608 = __call(____type, "includes", "cake")
                                            __O[2669] = ____call_result_608
                                            if ____t_609(____call_result_608) then
                                                ____t_result_610 = __O[2669]
                                            else
                                                ____t_result_610 = __call(____type, "includes", "bolo")
                                            end
                                            if ____t_611(____t_result_610) then
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
                                                local ____t_615 = __t
                                                local ____t_result_614
                                                local ____t_613 = __t
                                                local ____call_result_612 = __call(____type, "includes", "comb")
                                                __O[2670] = ____call_result_612
                                                if ____t_613(____call_result_612) then
                                                    ____t_result_614 = __O[2670]
                                                else
                                                    ____t_result_614 = __call(____type, "includes", "pente")
                                                end
                                                if ____t_615(____t_result_614) then
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
                                                    local ____t_619 = __t
                                                    local ____t_result_618
                                                    local ____t_617 = __t
                                                    local ____call_result_616 = __call(____type, "includes", "six")
                                                    __O[2671] = ____call_result_616
                                                    if ____t_617(____call_result_616) then
                                                        ____t_result_618 = __O[2671]
                                                    else
                                                        ____t_result_618 = ____type == "67"
                                                    end
                                                    if ____t_619(____t_result_618) then
                                                        label(
                                                            nil,
                                                            c,
                                                            __t(__mod(
                                                                math.floor(t * 12),
                                                                2
                                                            )) and "6" or "7",
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
                                                        local ____t_625 = __t
                                                        local ____t_result_624
                                                        local ____t_623 = __t
                                                        local ____t_result_622
                                                        local ____t_621 = __t
                                                        local ____call_result_620 = __call(____type, "includes", "bullet")
                                                        __O[2672] = ____call_result_620
                                                        if ____t_621(____call_result_620) then
                                                            ____t_result_622 = __O[2672]
                                                        else
                                                            ____t_result_622 = __call(____type, "includes", "spark")
                                                        end
                                                        __O[2673] = ____t_result_622
                                                        if ____t_623(____t_result_622) then
                                                            ____t_result_624 = __O[2673]
                                                        else
                                                            ____t_result_624 = __call(____type, "includes", "shot")
                                                        end
                                                        if ____t_625(____t_result_624) then
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
                                                            local ____t_629 = __t
                                                            local ____t_result_628
                                                            local ____t_627 = __t
                                                            local ____call_result_626 = __call(____type, "includes", "ribbon")
                                                            __O[2674] = ____call_result_626
                                                            if ____t_627(____call_result_626) then
                                                                ____t_result_628 = __O[2674]
                                                            else
                                                                ____t_result_628 = __call(____type, "includes", "rope")
                                                            end
                                                            if ____t_629(____t_result_628) then
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
                                                                local ____t_633 = __t
                                                                local ____t_result_632
                                                                local ____t_631 = __t
                                                                local ____call_result_630 = __call(____type, "includes", "slap")
                                                                __O[2675] = ____call_result_630
                                                                if ____t_631(____call_result_630) then
                                                                    ____t_result_632 = __O[2675]
                                                                else
                                                                    ____t_result_632 = ____type == "palm"
                                                                end
                                                                if ____t_633(____t_result_632) then
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
                                                                    local ____t_639 = __t
                                                                    local ____t_result_638
                                                                    local ____t_637 = __t
                                                                    local ____t_result_636
                                                                    local ____t_635 = __t
                                                                    local ____call_result_634 = __call(____type, "includes", "ink")
                                                                    __O[2676] = ____call_result_634
                                                                    if ____t_635(____call_result_634) then
                                                                        ____t_result_636 = __O[2676]
                                                                    else
                                                                        ____t_result_636 = __call(____type, "includes", "drawing")
                                                                    end
                                                                    __O[2677] = ____t_result_636
                                                                    if ____t_637(____t_result_636) then
                                                                        ____t_result_638 = __O[2677]
                                                                    else
                                                                        ____t_result_638 = __call(____type, "includes", "brainrot")
                                                                    end
                                                                    if ____t_639(____t_result_638) then
                                                                        local n = __mod(
                                                                            math.floor(age * 8),
                                                                            3
                                                                        )
                                                                        local ____t_result_640
                                                                        if __t(s.variant) then
                                                                            ____t_result_640 = s.variant
                                                                        else
                                                                            ____t_result_640 = ""
                                                                        end
                                                                        local variant = tostring(____t_result_640)
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
                                                                                        __t(__mod(i, 2)) and "#f2d1a0" or color,
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
                local ____rect_644 = rect
                local ____c_642 = c
                local ____temp_643 = size + 2
                local ____t_result_641
                if __t(__mod(i, 2)) then
                    ____t_result_641 = color
                else
                    ____t_result_641 = "#fff0bf"
                end
                ____rect_644(
                    nil,
                    ____c_642,
                    x,
                    y,
                    ____temp_643,
                    size,
                    ____t_result_641
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
        local ____t_result_647
        local ____t_646 = __t
        local ____TS__Number_result_645 = __TS__Number(time)
        __O[2678] = ____TS__Number_result_645
        if ____t_646(____TS__Number_result_645) then
            ____t_result_647 = __O[2678]
        else
            ____t_result_647 = 0
        end
        local t = ____t_result_647
        local ____t_result_648
        if __t(e.type) then
            ____t_result_648 = e.type
        else
            ____t_result_648 = ""
        end
        local ____type = tostring(____t_result_648)
        local ____t_result_649
        if __t(e.shape) then
            ____t_result_649 = e.shape
        else
            ____t_result_649 = ""
        end
        local shape = tostring(____t_result_649)
        local ____t_result_654
        local ____t_653 = __t
        local ____t_result_652
        local ____t_651 = __t
        local ____TS__Number_result_650 = __TS__Number(e.maxLife)
        __O[2679] = ____TS__Number_result_650
        if ____t_651(____TS__Number_result_650) then
            ____t_result_652 = __O[2679]
        else
            ____t_result_652 = __TS__Number(e.duration)
        end
        __O[2680] = ____t_result_652
        if ____t_653(____t_result_652) then
            ____t_result_654 = __O[2680]
        else
            ____t_result_654 = 0.45
        end
        local max = math.max(0.001, ____t_result_654)
        local life = __TS__Number(e.life)
        local ____isFiniteN_result_656
        if __isFiniteN(e.progress) then
            ____isFiniteN_result_656 = clamp(nil, e.progress, 0, 1)
        else
            local ____isFiniteN_result_655
            if __isFiniteN(life) then
                ____isFiniteN_result_655 = 1 - clamp(nil, life / max, 0, 1)
            else
                ____isFiniteN_result_655 = 0.4
            end
            ____isFiniteN_result_656 = ____isFiniteN_result_655
        end
        local progress = ____isFiniteN_result_656
        local ____t_result_657
        if __t(e.color) then
            ____t_result_657 = e.color
        else
            ____t_result_657 = "#ffca3d"
        end
        local color = ____t_result_657
        c:save()
        c.imageSmoothingEnabled = false
        local ____c_665 = c
        local ____c_translate_666 = c.translate
        local ____t_result_660
        local ____t_659 = __t
        local ____TS__Number_result_658 = __TS__Number(e.x)
        __O[2681] = ____TS__Number_result_658
        if ____t_659(____TS__Number_result_658) then
            ____t_result_660 = __O[2681]
        else
            ____t_result_660 = 0
        end
        local ____math_floor_result_664 = math.floor(____t_result_660 + 0.5)
        local ____t_result_663
        local ____t_662 = __t
        local ____TS__Number_result_661 = __TS__Number(e.y)
        __O[2682] = ____TS__Number_result_661
        if ____t_662(____TS__Number_result_661) then
            ____t_result_663 = __O[2682]
        else
            ____t_result_663 = 0
        end
        ____c_translate_666(
            ____c_665,
            ____math_floor_result_664,
            math.floor(____t_result_663 + 0.5)
        )
        local face = __lt(e.facing, 0) and -1 or 1
        local ____t_result_677
        local ____t_670 = __t
        local ____t_result_669
        local ____t_668 = __t
        local ____call_result_667 = __call(shape, "includes", "upper")
        __O[2683] = ____call_result_667
        if ____t_668(____call_result_667) then
            ____t_result_669 = __O[2683]
        else
            ____t_result_669 = __call(shape, "includes", "-up")
        end
        if ____t_670(____t_result_669) then
            ____t_result_677 = -math.pi / 2
        else
            local ____t_result_676
            local ____t_674 = __t
            local ____t_result_673
            local ____t_672 = __t
            local ____call_result_671 = __call(shape, "includes", "-low")
            __O[2684] = ____call_result_671
            if ____t_672(____call_result_671) then
                ____t_result_673 = __O[2684]
            else
                ____t_result_673 = __call(shape, "includes", "-down")
            end
            if ____t_674(____t_result_673) then
                ____t_result_676 = math.pi / 2
            else
                local ____temp_675
                if face < 0 then
                    ____temp_675 = math.pi
                else
                    ____temp_675 = 0
                end
                ____t_result_676 = ____temp_675
            end
            ____t_result_677 = ____t_result_676
        end
        local angle = ____t_result_677
        local ____t_683 = __t
        local ____t_result_682
        local ____t_681 = __t
        local ____t_result_680
        local ____t_679 = __t
        local ____call_result_678 = __call(shape, "includes", "sewer")
        __O[2685] = ____call_result_678
        if ____t_679(____call_result_678) then
            ____t_result_680 = __O[2685]
        else
            ____t_result_680 = __call(shape, "includes", "burrow")
        end
        __O[2686] = ____t_result_680
        if ____t_681(____t_result_680) then
            ____t_result_682 = __O[2686]
        else
            ____t_result_682 = ____type == "sewer"
        end
        if ____t_683(____t_result_682) then
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
                        __t(__mod(i, 2)) and "#d18d51" or "#a9cbe0"
                    )
                    i = i + 1
                end
            end
        else
            local ____t_687 = __t
            local ____t_result_686
            local ____t_685 = __t
            local ____call_result_684 = __call(shape, "includes", "army")
            __O[2687] = ____call_result_684
            if ____t_685(____call_result_684) then
                ____t_result_686 = __O[2687]
            else
                ____t_result_686 = ____type == "army"
            end
            if ____t_687(____t_result_686) then
                do
                    local i = 0
                    while i < 4 do
                        local x = (i - 1.5) * 29
                        local y = math.sin(progress * math.pi) * -4
                        local ____opt_690 = window.Art
                        if ____opt_690 ~= nil then
                            ____opt_690 = ____opt_690.drawCharacter
                        end
                        if ____opt_690 ~= nil then
                            ____opt_690(
                                ____opt_690,
                                c,
                                "reeis",
                                x,
                                y,
                                {
                                    frame = t + i,
                                    facing = i < 2 and 1 or -1,
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
                            x + (i < 2 and 17 or -27),
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
                local ____t_695 = __t
                local ____t_result_694
                local ____t_693 = __t
                local ____call_result_692 = __call(shape, "includes", "rats")
                __O[2688] = ____call_result_692
                if ____t_693(____call_result_692) then
                    ____t_result_694 = __O[2688]
                else
                    ____t_result_694 = ____type == "rats"
                end
                if ____t_695(____t_result_694) then
                    do
                        local i = 0
                        while i < 5 do
                            local ____opt_698 = window.Art
                            if ____opt_698 ~= nil then
                                ____opt_698 = ____opt_698.drawRat
                            end
                            if ____opt_698 ~= nil then
                                ____opt_698(
                                    ____opt_698,
                                    c,
                                    (i - 2) * 20,
                                    math.sin(progress * math.pi) * -5,
                                    t + i,
                                    {
                                        scale = 0.65,
                                        facing = __t(__mod(i, 2)) and 1 or -1
                                    }
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
                                __t(__mod(i, 2)) and "#fff0bc" or color
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
                    local ____t_703 = __t
                    local ____t_result_702
                    local ____t_701 = __t
                    local ____call_result_700 = __call(shape, "includes", "football")
                    __O[2689] = ____call_result_700
                    if ____t_701(____call_result_700) then
                        ____t_result_702 = __O[2689]
                    else
                        ____t_result_702 = __call(shape, "includes", "juggle")
                    end
                    if ____t_703(____t_result_702) then
                        local ____t_result_706
                        local ____t_705 = __t
                        local ____call_result_704 = __call(shape, "includes", "lift")
                        __O[2690] = ____call_result_704
                        if ____t_705(____call_result_704) then
                            ____t_result_706 = __O[2690]
                        else
                            ____t_result_706 = __call(shape, "includes", "juggle")
                        end
                        local lift = ____t_result_706
                        local ____temp_708 = -12
                        local ____t_result_707
                        if __t(lift) then
                            ____t_result_707 = math.sin(progress * math.pi) * 40
                        else
                            ____t_result_707 = 0
                        end
                        local yy = ____temp_708 - ____t_result_707
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
                                    __t(__mod(i, 2)) and "#fff4b3" or "#55b6f0"
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
                                    -8 - math.sin(progress * math.pi) * (__t(__mod(i, 2)) and 18 or 4),
                                    20 - i * 2,
                                    __t(__mod(i, 2)) and "#b0d546" or "#7fb937",
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
                        local ____t_712 = __t
                        local ____t_result_711
                        local ____t_710 = __t
                        local ____call_result_709 = __call(shape, "includes", "tongue")
                        __O[2691] = ____call_result_709
                        if ____t_710(____call_result_709) then
                            ____t_result_711 = __O[2691]
                        else
                            ____t_result_711 = __call(shape, "includes", "frog-upper")
                        end
                        if ____t_712(____t_result_711) then
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
                                    local ____opt_715 = window.Art
                                    if ____opt_715 ~= nil then
                                        ____opt_715 = ____opt_715.drawRat
                                    end
                                    if ____opt_715 ~= nil then
                                        ____opt_715(
                                            ____opt_715,
                                            c,
                                            (i - 1) * 24,
                                            -progress * 16,
                                            t + i,
                                            {
                                                scale = 0.65,
                                                facing = __t(__mod(i, 2)) and -1 or 1
                                            }
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
                            local ____t_720 = __t
                            local ____t_result_719
                            local ____t_718 = __t
                            local ____call_result_717 = __call(shape, "includes", "slime")
                            __O[2692] = ____call_result_717
                            if ____t_718(____call_result_717) then
                                ____t_result_719 = __O[2692]
                            else
                                ____t_result_719 = __call(shape, "includes", "nose")
                            end
                            if ____t_720(____t_result_719) then
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
                                local ____t_730 = __t
                                local ____t_result_729
                                local ____t_728 = __t
                                local ____t_result_727
                                local ____t_726 = __t
                                local ____t_result_725
                                local ____t_724 = __t
                                local ____t_result_723
                                local ____t_722 = __t
                                local ____call_result_721 = __call(shape, "includes", "brainrot")
                                __O[2693] = ____call_result_721
                                if ____t_722(____call_result_721) then
                                    ____t_result_723 = __O[2693]
                                else
                                    ____t_result_723 = __call(shape, "includes", "sketch")
                                end
                                __O[2694] = ____t_result_723
                                if ____t_724(____t_result_723) then
                                    ____t_result_725 = __O[2694]
                                else
                                    ____t_result_725 = __call(shape, "includes", "sixseven")
                                end
                                __O[2695] = ____t_result_725
                                if ____t_726(____t_result_725) then
                                    ____t_result_727 = __O[2695]
                                else
                                    ____t_result_727 = __call(shape, "includes", "seven-smash")
                                end
                                __O[2696] = ____t_result_727
                                if ____t_728(____t_result_727) then
                                    ____t_result_729 = __O[2696]
                                else
                                    ____t_result_729 = __call(shape, "includes", "six-fist")
                                end
                                if ____t_730(____t_result_729) then
                                    local ____t_result_733
                                    local ____t_732 = __t
                                    local ____call_result_731 = __call(shape, "includes", "seven")
                                    __O[2697] = ____call_result_731
                                    if ____t_732(____call_result_731) then
                                        ____t_result_733 = __O[2697]
                                    else
                                        ____t_result_733 = __call(shape, "includes", "six")
                                    end
                                    local six = ____t_result_733
                                    if __t(six) then
                                        label(
                                            nil,
                                            c,
                                            __t(__call(shape, "includes", "seven")) and "67" or "6",
                                            0,
                                            -10,
                                            35,
                                            color
                                        )
                                    else
                                        local ____t_736 = __t
                                        local ____opt_734 = window.Art
                                        if ____opt_734 ~= nil then
                                            ____opt_734 = ____opt_734.drawMinion
                                        end
                                        if ____t_736(____opt_734) then
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
                                    local ____t_740 = __t
                                    local ____t_result_739
                                    local ____t_738 = __t
                                    local ____call_result_737 = __call(shape, "includes", "iraci")
                                    __O[2698] = ____call_result_737
                                    if ____t_738(____call_result_737) then
                                        ____t_result_739 = __O[2698]
                                    else
                                        ____t_result_739 = __call(shape, "includes", "confiscate")
                                    end
                                    if ____t_740(____t_result_739) then
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
                                            __t(__call(shape, "includes", "iraci")) and "IRACI!" or "CONFISCADO",
                                            0,
                                            -5,
                                            12,
                                            "#ae332e"
                                        )
                                        c:restore()
                                    else
                                        local ____t_744 = __t
                                        local ____t_result_743
                                        local ____t_742 = __t
                                        local ____call_result_741 = __call(shape, "includes", "smoke")
                                        __O[2699] = ____call_result_741
                                        if ____t_742(____call_result_741) then
                                            ____t_result_743 = __O[2699]
                                        else
                                            ____t_result_743 = __call(shape, "includes", "braces")
                                        end
                                        if ____t_744(____t_result_743) then
                                            do
                                                local i = 0
                                                while i < 3 do
                                                    puff(
                                                        nil,
                                                        c,
                                                        (i - 1) * (15 + progress * 10),
                                                        -12 - __mod(i, 2) * 17,
                                                        20,
                                                        __t(__mod(i, 2)) and "#a2b9d0" or "#c6daed",
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
                                            local ____t_750 = __t
                                            local ____t_result_749
                                            local ____t_748 = __t
                                            local ____t_result_747
                                            local ____t_746 = __t
                                            local ____call_result_745 = __call(shape, "includes", "divine")
                                            __O[2700] = ____call_result_745
                                            if ____t_746(____call_result_745) then
                                                ____t_result_747 = __O[2700]
                                            else
                                                ____t_result_747 = __call(shape, "includes", "aura-")
                                            end
                                            __O[2701] = ____t_result_747
                                            if ____t_748(____t_result_747) then
                                                ____t_result_749 = __O[2701]
                                            else
                                                ____t_result_749 = __call(shape, "includes", "protagonist")
                                            end
                                            if ____t_750(____t_result_749) then
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
                                                local ____t_754 = __t
                                                local ____t_result_753
                                                local ____t_752 = __t
                                                local ____call_result_751 = __call(shape, "includes", "palm")
                                                __O[2702] = ____call_result_751
                                                if ____t_752(____call_result_751) then
                                                    ____t_result_753 = __O[2702]
                                                else
                                                    ____t_result_753 = __call(shape, "includes", "slap")
                                                end
                                                if ____t_754(____t_result_753) then
                                                    c:save()
                                                    c:scale(
                                                        __t(__call(shape, "includes", "giant")) and 1.55 or 1,
                                                        __t(__call(shape, "includes", "giant")) and 1.55 or 1
                                                    )
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
                                                    local ____t_758 = __t
                                                    local ____t_result_757
                                                    local ____t_756 = __t
                                                    local ____call_result_755 = __call(shape, "includes", "wall-")
                                                    __O[2703] = ____call_result_755
                                                    if ____t_756(____call_result_755) then
                                                        ____t_result_757 = __O[2703]
                                                    else
                                                        ____t_result_757 = __call(shape, "includes", "monologue-wall")
                                                    end
                                                    if ____t_758(____t_result_757) then
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
                                                                            -24 + j * 25 + (__t(__mod(i, 2)) and 10 or 0),
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
                                                        local ____t_762 = __t
                                                        local ____t_result_761
                                                        local ____t_760 = __t
                                                        local ____call_result_759 = __call(shape, "includes", "beard")
                                                        __O[2704] = ____call_result_759
                                                        if ____t_760(____call_result_759) then
                                                            ____t_result_761 = __O[2704]
                                                        else
                                                            ____t_result_761 = __call(shape, "includes", "english")
                                                        end
                                                        if ____t_762(____t_result_761) then
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
                                                            local ____t_766 = __t
                                                            local ____t_result_765
                                                            local ____t_764 = __t
                                                            local ____call_result_763 = __call(shape, "includes", "towel")
                                                            __O[2705] = ____call_result_763
                                                            if ____t_764(____call_result_763) then
                                                                ____t_result_765 = __O[2705]
                                                            else
                                                                ____t_result_765 = __call(shape, "includes", "brush")
                                                            end
                                                            if ____t_766(____t_result_765) then
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
                                                                local ____t_772 = __t
                                                                local ____t_result_771
                                                                local ____t_770 = __t
                                                                local ____t_result_769
                                                                local ____t_768 = __t
                                                                local ____call_result_767 = __call(shape, "includes", "reception")
                                                                __O[2706] = ____call_result_767
                                                                if ____t_768(____call_result_767) then
                                                                    ____t_result_769 = __O[2706]
                                                                else
                                                                    ____t_result_769 = __call(shape, "includes", "queue")
                                                                end
                                                                __O[2707] = ____t_result_769
                                                                if ____t_770(____t_result_769) then
                                                                    ____t_result_771 = __O[2707]
                                                                else
                                                                    ____t_result_771 = __call(shape, "includes", "receipt")
                                                                end
                                                                if ____t_772(____t_result_771) then
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
                                                                    local ____t_776 = __t
                                                                    local ____t_result_775
                                                                    local ____t_774 = __t
                                                                    local ____call_result_773 = __call(shape, "includes", "pencil-case")
                                                                    __O[2708] = ____call_result_773
                                                                    if ____t_774(____call_result_773) then
                                                                        ____t_result_775 = __O[2708]
                                                                    else
                                                                        ____t_result_775 = __call(shape, "includes", "eraser")
                                                                    end
                                                                    if ____t_776(____t_result_775) then
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
                                                                        local ____t_780 = __t
                                                                        local ____t_result_779
                                                                        local ____t_778 = __t
                                                                        local ____call_result_777 = __call(shape, "includes", "claw")
                                                                        __O[2709] = ____call_result_777
                                                                        if ____t_778(____call_result_777) then
                                                                            ____t_result_779 = __O[2709]
                                                                        else
                                                                            ____t_result_779 = __call(shape, "includes", "scratch")
                                                                        end
                                                                        if ____t_780(____t_result_779) then
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
                                                                            local ____t_784 = __t
                                                                            local ____t_result_783
                                                                            local ____t_782 = __t
                                                                            local ____call_result_781 = __call(shape, "includes", "wave")
                                                                            __O[2710] = ____call_result_781
                                                                            if ____t_782(____call_result_781) then
                                                                                ____t_result_783 = __O[2710]
                                                                            else
                                                                                ____t_result_783 = __call(shape, "includes", "stomp")
                                                                            end
                                                                            if ____t_784(____t_result_783) then
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
                                                                                            __t(__mod(i, 2)) and "#98582f" or "#e4a35d"
                                                                                        )
                                                                                        i = i + 1
                                                                                    end
                                                                                end
                                                                            elseif ____type == "attack" then
                                                                                local ____t_790 = __t
                                                                                local ____t_result_789
                                                                                local ____t_788 = __t
                                                                                local ____t_result_787
                                                                                local ____t_786 = __t
                                                                                local ____call_result_785 = __call(shape, "includes", "weight")
                                                                                __O[2711] = ____call_result_785
                                                                                if ____t_786(____call_result_785) then
                                                                                    ____t_result_787 = __O[2711]
                                                                                else
                                                                                    ____t_result_787 = __call(shape, "includes", "dumbbell")
                                                                                end
                                                                                __O[2712] = ____t_result_787
                                                                                if ____t_788(____t_result_787) then
                                                                                    ____t_result_789 = __O[2712]
                                                                                else
                                                                                    ____t_result_789 = __call(shape, "includes", "supino")
                                                                                end
                                                                                if ____t_790(____t_result_789) then
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
                                                                                    local ____t_796 = __t
                                                                                    local ____t_result_795
                                                                                    local ____t_794 = __t
                                                                                    local ____t_result_793
                                                                                    local ____t_792 = __t
                                                                                    local ____call_result_791 = __call(shape, "includes", "heel")
                                                                                    __O[2713] = ____call_result_791
                                                                                    if ____t_792(____call_result_791) then
                                                                                        ____t_result_793 = __O[2713]
                                                                                    else
                                                                                        ____t_result_793 = __call(shape, "includes", "kick")
                                                                                    end
                                                                                    __O[2714] = ____t_result_793
                                                                                    if ____t_794(____t_result_793) then
                                                                                        ____t_result_795 = __O[2714]
                                                                                    else
                                                                                        ____t_result_795 = __call(shape, "includes", "capoeira")
                                                                                    end
                                                                                    if ____t_796(____t_result_795) then
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
                                                                                        local ____heel_800 = heel
                                                                                        local ____array_799 = __TS__SparseArrayNew(nil, c, face * 21, -1)
                                                                                        local ____t_result_798
                                                                                        if __t(__call(shape, "includes", "upper")) then
                                                                                            ____t_result_798 = -1.2
                                                                                        else
                                                                                            local ____temp_797
                                                                                            if face < 0 then
                                                                                                ____temp_797 = math.pi
                                                                                            else
                                                                                                ____temp_797 = 0
                                                                                            end
                                                                                            ____t_result_798 = ____temp_797
                                                                                        end
                                                                                        __TS__SparseArrayPush(____array_799, ____t_result_798, 0.85, color)
                                                                                        ____heel_800(__TS__SparseArraySpread(____array_799))
                                                                                    elseif __t(__call(shape, "includes", "tongue")) then
                                                                                        drawProjectile(nil, c, {
                                                                                            type = "tongue",
                                                                                            x = 0,
                                                                                            y = 0,
                                                                                            color = color,
                                                                                            vx = face
                                                                                        }, t)
                                                                                    elseif __t(__call(shape, "includes", "lowblow")) then
                                                                                        local ____glove_804 = glove
                                                                                        local ____c_802 = c
                                                                                        local ____temp_803 = face * 18
                                                                                        local ____temp_801
                                                                                        if face < 0 then
                                                                                            ____temp_801 = math.pi
                                                                                        else
                                                                                            ____temp_801 = 0
                                                                                        end
                                                                                        ____glove_804(
                                                                                            nil,
                                                                                            ____c_802,
                                                                                            ____temp_803,
                                                                                            11,
                                                                                            "#efc5a4",
                                                                                            ____temp_801
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
                                                                                        local ____t_808 = __t
                                                                                        local ____t_result_807
                                                                                        local ____t_806 = __t
                                                                                        local ____call_result_805 = __call(shape, "includes", "gun")
                                                                                        __O[2715] = ____call_result_805
                                                                                        if ____t_806(____call_result_805) then
                                                                                            ____t_result_807 = __O[2715]
                                                                                        else
                                                                                            ____t_result_807 = __call(shape, "includes", "stock")
                                                                                        end
                                                                                        if ____t_808(____t_result_807) then
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
                                                                                            local ____t_812 = __t
                                                                                            local ____t_result_811
                                                                                            local ____t_810 = __t
                                                                                            local ____call_result_809 = __call(shape, "includes", "ruler")
                                                                                            __O[2716] = ____call_result_809
                                                                                            if ____t_810(____call_result_809) then
                                                                                                ____t_result_811 = __O[2716]
                                                                                            else
                                                                                                ____t_result_811 = __call(shape, "includes", "tool")
                                                                                            end
                                                                                            if ____t_812(____t_result_811) then
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
                                                                                                local ____t_816 = __t
                                                                                                local ____t_result_815
                                                                                                local ____t_814 = __t
                                                                                                local ____call_result_813 = __call(shape, "includes", "ear")
                                                                                                __O[2717] = ____call_result_813
                                                                                                if ____t_814(____call_result_813) then
                                                                                                    ____t_result_815 = __O[2717]
                                                                                                else
                                                                                                    ____t_result_815 = __call(shape, "includes", "wind")
                                                                                                end
                                                                                                if ____t_816(____t_result_815) then
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
                                                                                                    local ____t_result_821
                                                                                                    local ____t_820 = __t
                                                                                                    local ____t_result_819
                                                                                                    local ____t_818 = __t
                                                                                                    local ____call_result_817 = __call(shape, "includes", "teacher")
                                                                                                    __O[2718] = ____call_result_817
                                                                                                    if ____t_818(____call_result_817) then
                                                                                                        ____t_result_819 = __O[2718]
                                                                                                    else
                                                                                                        ____t_result_819 = __call(shape, "includes", "point")
                                                                                                    end
                                                                                                    __O[2719] = ____t_result_819
                                                                                                    if ____t_820(____t_result_819) then
                                                                                                        ____t_result_821 = __O[2719]
                                                                                                    else
                                                                                                        ____t_result_821 = __call(shape, "includes", "receipt")
                                                                                                    end
                                                                                                    local palm = ____t_result_821
                                                                                                    smear(
                                                                                                        nil,
                                                                                                        c,
                                                                                                        -9,
                                                                                                        0,
                                                                                                        angle,
                                                                                                        progress,
                                                                                                        __t(palm) and "#ffe4b9" or color,
                                                                                                        8
                                                                                                    )
                                                                                                    local ____glove_824 = glove
                                                                                                    local ____array_823 = __TS__SparseArrayNew(
                                                                                                        nil,
                                                                                                        c,
                                                                                                        face * (14 + math.sin(progress * math.pi) * 12),
                                                                                                        -4,
                                                                                                        __t(palm) and "#e0b08a" or color
                                                                                                    )
                                                                                                    local ____temp_822
                                                                                                    if face < 0 then
                                                                                                        ____temp_822 = math.pi
                                                                                                    else
                                                                                                        ____temp_822 = 0
                                                                                                    end
                                                                                                    __TS__SparseArrayPush(____array_823, ____temp_822)
                                                                                                    ____glove_824(__TS__SparseArraySpread(____array_823))
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
                                                                                        local yy = (__t(__mod(i, 2)) and -1 or 1) * (13 + progress * 27)
                                                                                        rect(
                                                                                            nil,
                                                                                            c,
                                                                                            xx,
                                                                                            yy,
                                                                                            7,
                                                                                            11,
                                                                                            __t(__mod(i, 2)) and "#fff4bd" or "#ffcf3d"
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
                                                                                            __t(__mod(i, 2)) and "#f8f4bc" or color
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
                                                                                local ____contactImpact_829 = contactImpact
                                                                                local ____c_828 = c
                                                                                local ____t_result_827
                                                                                local ____t_826 = __t
                                                                                local ____TS__Number_result_825 = __TS__Number(e.radius)
                                                                                __O[2720] = ____TS__Number_result_825
                                                                                if ____t_826(____TS__Number_result_825) then
                                                                                    ____t_result_827 = __O[2720]
                                                                                else
                                                                                    ____t_result_827 = 22
                                                                                end
                                                                                ____contactImpact_829(
                                                                                    nil,
                                                                                    ____c_828,
                                                                                    progress,
                                                                                    ____t_result_827,
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
            normalizedHeight = function(____, ____type) return ____type == "lucas" and 60 or 70 end,
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
