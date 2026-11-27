--!native
--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __le, __gt, __mod, __ord, __arrL, __iterar, __t, __get, __set, __len, __call = __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__len, __JSR.__call
local __add, __keys, __bor = __JSR.__add, __JSR.__keys, __JSR.__bor
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__Number = ____lualib.__TS__Number
local ____exports = {}
local __O = {};
(function()
    local spawnChaff, chaff, tip
    function spawnChaff(self, s, vx)
        local ____opt_45 = window.Graphics
        if ____opt_45 ~= nil then
            ____opt_45 = ____opt_45.profile
        end
        local ____opt_result_47
        if ____opt_45 ~= nil then
            ____opt_result_47 = ____opt_45(____opt_45)
        end
        local ____opt_result_48
        if ____opt_result_47 ~= nil then
            ____opt_result_48 = ____opt_result_47.particles
        end
        local ____opt_result_48_49 = ____opt_result_48
        if ____opt_result_48_49 == nil then
            ____opt_result_48_49 = 1
        end
        local max = math.floor(70 * ____opt_result_48_49 + 0.5)
        if __len(chaff) >= max then
            return
        end
        local top = tip(nil, s)
        __call(
            chaff,
            "push",
            {
                x = __get(top, 0),
                y = __get(top, 1),
                vx = vx * 0.25 + (math.random() - 0.5) * 40,
                vy = -40 - math.random() * 50,
                life = 0.9 + math.random() * 0.9,
                ph = math.random() * 6,
                c = if math.random() < 0.6 then "grain" else "awn"
            }
        )
    end
    local ____ = "use strict"
    if __t(window.Trigal) then
        return
    end
    local SCENE = 0
    local FLOOR = 440
    local FIELDS = __arrL(
        {
            __arrL({3714, 3996}, 2),
            __arrL({4506, 4772}, 2)
        },
        2
    )
    local function hash(____, i)
        local x = math.sin(i * 127.1 + 311.7) * 43758.5453
        return x - math.floor(x)
    end
    local function cl(____, v, a, b)
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
    local stalks = nil
    chaff = __arrL({}, 0)
    local lastT = 0
    local stepAcc = 0
    local lastSound = 0
    local function build(self)
        stalks = __arrL(
            {
                __arrL({}, 0),
                __arrL({}, 0)
            },
            2
        )
        local id = 0
        for ____, ____value in __iterar((FIELDS)) do
            local a = ____value[1]
            local b = ____value[2]
            for ____, row in __iterar((__arrL({0, 1}, 2))) do
                local gap = if __t(row) then 7 else 4.6
                do
                    local x = a + 2
                    while x < b - 2 do
                        id = id + 1
                        local r = hash(nil, id)
                        local r2 = hash(nil, id + 9000)
                        local edge = cl(
                            nil,
                            math.min(x - a, b - x) / 34
                        )
                        local h = if __t(row) then 26 + r * 14 else 40 + r * 20 * (0.55 + 0.45 * math.sqrt(edge))
                        __call(
                            __get(stalks, row),
                            "push",
                            {
                                x = x + (r2 - 0.5) * gap * 0.8,
                                base = if __t(row) then FLOOR + 4 + math.floor(r2 * 3 + 0.5) * 2 else FLOOR - 2 - math.floor(r * 3 + 0.5) * 2,
                                h = h,
                                ph = r * 6.28,
                                tone = r2,
                                a = 0,
                                w = 0,
                                flat = 0,
                                dir = 0
                            }
                        )
                        x = x + gap
                    end
                end
            end
        end
        for ____, row in __iterar((stalks)) do
            __call(
                row,
                "sort",
                function(____, p, q)
                    local ____t_1 = __t
                    local ____temp_0 = p.base - q.base
                    __O[346] = ____temp_0
                    return if ____t_1(____temp_0) then __O[346] else p.x - q.x
                end
            )
        end
    end
    local BASE = __ord(
        {
            stemD = __arrL({150, 110, 46}, 3),
            stemL = __arrL({212, 170, 82}, 3),
            green = __arrL({150, 156, 70}, 3),
            ear = __arrL({228, 186, 92}, 3),
            earD = __arrL({178, 132, 56}, 3),
            grain = __arrL({248, 224, 142}, 3),
            awn = __arrL({238, 212, 150}, 3),
            stemB = __arrL({128, 92, 40}, 3),
            earB = __arrL({150, 110, 48}, 3),
            massTop = __arrL({186, 142, 60}, 3),
            massBot = __arrL({104, 74, 34}, 3)
        },
        "stemD,stemL,green,ear,earD,grain,awn,stemB,earB,massTop,massBot"
    )
    local PAL = {}
    local function palette(self, scene)
        local ____opt_4 = window.DayTime
        if ____opt_4 ~= nil then
            ____opt_4 = ____opt_4.state
        end
        local ____opt_result_6
        if ____opt_4 ~= nil then
            ____opt_result_6 = ____opt_4(____opt_4)
        end
        local s = ____opt_result_6
        local ____t_12 = __t
        local ____opt_9 = window.Weather
        if ____opt_9 ~= nil then
            ____opt_9 = ____opt_9.state
        end
        local ____opt_result_11
        if ____opt_9 ~= nil then
            ____opt_result_11 = ____opt_9(____opt_9)
        end
        __O[347] = ____opt_result_11
        local w = if ____t_12(____opt_result_11) then __O[347] else {}
        local ____t_18 = __t
        local ____opt_15 = window.HdMaps
        if ____opt_15 ~= nil then
            ____opt_15 = ____opt_15.sun
        end
        local ____opt_result_17
        if ____opt_15 ~= nil then
            ____opt_result_17 = ____opt_15(____opt_15)
        end
        __O[348] = ____opt_result_17
        local sun = if ____t_18(____opt_result_17) then __O[348] else {lean = 0, str = 1}
        local ____t_24 = __t
        local ____opt_21 = window.HdMaps
        if ____opt_21 ~= nil then
            ____opt_21 = ____opt_21.handles
        end
        local ____opt_result_23
        if ____opt_21 ~= nil then
            ____opt_result_23 = ____opt_21(____opt_21, scene)
        end
        local selfLit = not not ____t_24(____opt_result_23)
        local amb = if __t(if __t(selfLit) then s else selfLit) then s.amb else __arrL({1, 1, 1}, 3)
        local wet = cl(nil, if __t(w.wet) then w.wet else 0)
        local gold = if __t(if __t(s) then s.sunT ~= nil else s) then cl(
            nil,
            1 - math.sin(s.sunT * math.pi) * 1.7
        ) * cl(nil, sun.str * 1.5) else 0
        local k = 1 - wet * 0.22
        local function mul(____, c, boost)
            if boost == nil then
                boost = 0
            end
            return ((((("rgb(" .. tostring(math.floor(cl(
                nil,
                __get(c, 0) * __get(amb, 0) * k + boost * 40,
                0,
                255
            ) + 0.5))) .. ",") .. tostring(math.floor(cl(
                nil,
                __get(c, 1) * __get(amb, 1) * k + boost * 18,
                0,
                255
            ) + 0.5))) .. ",") .. tostring(math.floor(cl(
                nil,
                __get(c, 2) * __get(amb, 2) * k - boost * 8,
                0,
                255
            ) + 0.5))) .. ")"
        end
        PAL = {}
        for ____, n in __iterar((__keys(BASE))) do
            __set(
                PAL,
                n,
                mul(
                    nil,
                    __get(BASE, n)
                )
            )
        end
        PAL.earHi = mul(
            nil,
            __arrL({255, 232, 160}, 3),
            gold
        )
        PAL.rim = ((((("rgba(255," .. tostring(math.floor(200 + 30 * (1 - gold) + 0.5))) .. ",") .. tostring(math.floor(120 + 60 * (1 - gold) + 0.5))) .. ",") .. tostring((0.25 + 0.55 * gold) * cl(nil, sun.str) * if __t(s) then 1 - s.night else 1)) .. ")"
        PAL.lean = sun.lean
        PAL.sunStr = cl(nil, sun.str) * if __t(s) then 1 - s.night else 1
        PAL.gold = gold
        PAL.snow = cl(nil, if __t(w.cover) then w.cover else 0 * 1.4)
        PAL.wet = wet
        local ____PAL_27 = PAL
        local ____t_26 = __t
        local ____TS__Number_result_25 = __TS__Number(w.wind)
        __O[349] = ____TS__Number_result_25
        ____PAL_27.wind = if ____t_26(____TS__Number_result_25) then __O[349] else 0.15
        PAL.night = if __t(s) then s.night else 0
        PAL.snowC = mul(
            nil,
            __arrL({248, 250, 255}, 3)
        )
    end
    local function update(self, o, dt)
        local p = if __t(o.player) then o.player else {}
        local ____t_29 = __t
        local ____TS__Number_result_28 = __TS__Number(p.x)
        __O[350] = ____TS__Number_result_28
        local px = if ____t_29(____TS__Number_result_28) then __O[350] else 0
        local ____t_31 = __t
        local ____TS__Number_result_30 = __TS__Number(p.y)
        __O[351] = ____TS__Number_result_30
        local py = if ____t_31(____TS__Number_result_30) then __O[351] else FLOOR
        local ____t_33 = __t
        local ____TS__Number_result_32 = __TS__Number(p.vx)
        __O[352] = ____TS__Number_result_32
        local vx = if ____t_33(____TS__Number_result_32) then __O[352] else 0
        local t = o.time
        local wind = PAL.wind
        local inField = __call(
            FIELDS,
            "some",
            function(____, ____bindingPattern0)
                local b
                local a
                a = ____bindingPattern0[1]
                b = ____bindingPattern0[2]
                return px > a - 10 and px < b + 10
            end
        )
        for ____, row in __iterar((stalks)) do
            for ____, s in __iterar((row)) do
                if math.abs(s.x - (o.camera + 480)) > 620 then
                    continue
                end
                local gust = math.sin(t * 1.6 - s.x * 0.045 + s.ph * 0.3) * 0.5 + math.sin(t * 0.7 - s.x * 0.012) * 0.5
                local target = wind * (0.18 + gust * 0.32) + math.sin(t * 2.3 + s.ph) * 0.03 * (1 + wind) + PAL.wet * 0.12 * (s.tone - 0.5)
                local d = s.x - px
                local R = 17
                if __t(math.abs(d) < R + 6 and py > s.base - s.h * 0.85) then
                    local f = cl(
                        nil,
                        1 - math.abs(d) / R
                    )
                    local side = if d > 1 then 1 else if d < -1 then -1 else if vx >= 0 then 1 else -1
                    if f > 0 then
                        target = side * (0.55 + 0.7 * math.sqrt(f)) + vx * 0.0011 * f
                        s.flat = math.min(1, s.flat + dt * 3 * f)
                        s.dir = side
                        if __t(math.abs(vx) > 90 and math.random() < dt * 9 * f) then
                            spawnChaff(nil, s, vx)
                        end
                    end
                else
                    s.flat = math.max(0, s.flat - dt * 0.22)
                end
                target = target + s.dir * s.flat * 0.45
                local acc = (target - s.a) * 70 - s.w * 7
                s.w = s.w + acc * dt
                s.a = cl(nil, s.a + s.w * dt, -1.35, 1.35)
            end
        end
        local ____t_36 = __t
        local ____t_35 = __t
        local ____temp_34 = if __t(inField) then math.abs(vx) > 60 else inField
        __O[353] = ____temp_34
        if ____t_36(if ____t_35(____temp_34) then py > FLOOR - 30 else __O[353]) then
            stepAcc = stepAcc + math.abs(vx) * dt
            if __t(stepAcc > 42 and t - lastSound > 0.16) then
                stepAcc = 0
                lastSound = t
                do
                    pcall(function()
                        local ____opt_39 = window.DarocaAudio
                        if ____opt_39 ~= nil then
                            ____opt_39 = ____opt_39.play
                        end
                        if ____opt_39 ~= nil then
                            ____opt_39(
                                ____opt_39,
                                "mato",
                                {volume = 0.45 + math.min(
                                    0.5,
                                    math.abs(vx) / 600
                                )}
                            )
                        end
                    end)
                end
            end
        else
            stepAcc = math.min(stepAcc, 30)
        end
        do
            local i = __len(chaff) - 1
            while i >= 0 do
                local c = __get(chaff, i)
                c.life = c.life - dt
                c.vy = c.vy + 40 * dt
                c.vx = c.vx + (wind * 60 - c.vx) * dt * 0.8
                c.x = c.x + (c.vx * dt + math.sin(t * 6 + c.ph) * 10 * dt)
                c.y = c.y + c.vy * dt
                if __t(__le(c.life, 0) or __gt(c.y, FLOOR + 6)) then
                    __call(chaff, "splice", i, 1)
                end
                i = i - 1
            end
        end
    end
    tip = function(____, s) return __arrL(
        {
            s.x + math.sin(s.a) * s.h,
            s.base - math.cos(s.a) * s.h
        },
        2
    ) end
    local function px2(____, v)
        return math.floor(v / 2 + 0.5) * 2
    end
    local function stalk(self, c, s, lite, back)
        local n = math.max(
            6,
            math.floor(s.h / 2 + 0.5)
        )
        local ear = math.min(
            8,
            math.floor(n * 0.3 + 0.5)
        )
        local ca = math.cos(s.a * 0.9)
        local lean = PAL.lean
        local stem = if __lt(s.tone, 0.15) then PAL.green else if __t(back) then if __gt(s.tone, 0.7) then PAL.stemD else PAL.stemB else if __gt(s.tone, 0.5) then PAL.stemL else PAL.stemD
        local runX = nil
        local runBot = 0
        local runTop = 0
        local function flush()
            if runX ~= nil then
                c:fillRect(runX, runTop, 2, runBot - runTop + 2)
            end
        end
        c.fillStyle = stem
        do
            local k = 0
            while k <= n do
                local u = k / n
                local off = math.sin(s.a) * s.h * u ^ 1.7
                local x = px2(nil, s.x + off)
                local y = px2(nil, s.base - k * 2 * ca)
                if k < n - ear then
                    if x == runX then
                        runTop = math.min(runTop, y)
                        continue
                    end
                    flush(nil)
                    if __t(runX ~= nil and math.abs(x - runX) > 2) then
                        c:fillRect(
                            math.min(x, runX) + 2,
                            y,
                            math.abs(x - runX) - 2,
                            2
                        )
                    end
                    runX = x
                    runBot = y
                    runTop = y
                    continue
                end
                if k == n - ear then
                    flush(nil)
                    runX = nil
                end
                local j = k - (n - ear)
                local ex = x + math.floor(s.a * 2 * (j / ear) + 0.5) * 2
                local side = if __t(__mod(
                    j + __bor(s.ph * 2, 0),
                    2
                )) then -2 else 2
                c.fillStyle = if __t(back) then PAL.earD else PAL.ear
                c:fillRect(ex, y, 2, 2)
                if __t(j > 0 and j < ear) then
                    c.fillStyle = if __mod(j, 3) == 1 then PAL.grain else if __t(back) then PAL.earB else PAL.earD
                    c:fillRect(ex + side, y, 2, 2)
                end
                local ____t_54 = __t
                local ____t_53 = __t
                local ____t_51 = __t
                local ____temp_50 = not __t(lite) and __gt(PAL.sunStr, 0.05)
                __O[354] = ____temp_50
                local ____temp_52 = if ____t_51(____temp_50) then j > 0 else __O[354]
                __O[355] = ____temp_52
                if ____t_54(if ____t_53(____temp_52) then side > 0 == __lt(lean, 0) else __O[355]) then
                    c.fillStyle = PAL.rim
                    c:fillRect(ex + side, y, 2, 2)
                end
                if k == n then
                    c.fillStyle = PAL.awn
                    local ax = ex + px2(
                        nil,
                        math.sin(s.a) * 4
                    )
                    if not __t(lite) then
                        c:fillRect(ax, y - 2, 2, 2)
                        if not __t(back) then
                            c:fillRect(
                                ax + px2(
                                    nil,
                                    math.sin(s.a) * 2
                                ),
                                y - 4,
                                2,
                                2
                            )
                        end
                    end
                    if __gt(PAL.snow, 0.08) then
                        c.globalAlpha = PAL.snow
                        c.fillStyle = PAL.snowC
                        c:fillRect(ex - 2, y - 2, 4, 2)
                        c.globalAlpha = 1
                    end
                    if __t(__gt(PAL.gold, 0.15) and not __t(lite)) then
                        c.fillStyle = PAL.earHi
                        c:fillRect(ex, y, 2, 2)
                    end
                end
                k = k + 1
            end
        end
    end
    local function mass(self, c, o)
        for ____, ____value in __iterar((FIELDS)) do
            local a = ____value[1]
            local b = ____value[2]
            if __t(b < o.camera - 40 or __gt(a, o.camera + 1000)) then
                continue
            end
            do
                local x = px2(nil, a)
                while x < b do
                    local edge = cl(
                        nil,
                        math.min(x - a, b - x) / 30
                    )
                    local p = if __t(o.player) then o.player else {}
                    local ____x_57 = x
                    local ____t_56 = __t
                    local ____TS__Number_result_55 = __TS__Number(p.x)
                    __O[356] = ____TS__Number_result_55
                    local d = math.abs(____x_57 - if ____t_56(____TS__Number_result_55) then __O[356] else -999)
                    local ____t_60 = __t
                    local ____t_59 = __t
                    local ____TS__Number_result_58 = __TS__Number(p.y)
                    __O[357] = ____TS__Number_result_58
                    local dip = if ____t_60(if ____t_59(____TS__Number_result_58) then __O[357] else FLOOR > FLOOR - 40 and d < 20) then (1 - d / 20) * 14 else 0
                    local wave = math.sin(o.time * 1.6 - x * 0.045) * 2 * PAL.wind
                    local h = math.max(
                        0,
                        (22 + hash(nil, x * 0.37) * 8) * math.sqrt(edge) - dip + wave
                    )
                    if h < 2 then
                        continue
                    end
                    local top = px2(nil, FLOOR - h)
                    c.fillStyle = PAL.massBot
                    c:fillRect(x, top, 2, FLOOR + 2 - top)
                    c.fillStyle = PAL.massTop
                    c:fillRect(
                        x,
                        top,
                        2,
                        math.max(
                            2,
                            px2(nil, h * 0.45)
                        )
                    )
                    if __mod(x / 2, 3) == 0 then
                        c.fillStyle = PAL.ear
                        c:fillRect(x, top - 2, 2, 2)
                    end
                    if __gt(PAL.snow, 0.08) then
                        c.globalAlpha = PAL.snow
                        c.fillStyle = PAL.snowC
                        c:fillRect(x, top - 2, 2, 2)
                        c.globalAlpha = 1
                    end
                    x = x + 2
                end
            end
            c.fillStyle = ("rgba(30,20,10," .. tostring(0.18 + 0.12 * (1 - PAL.night))) .. ")"
            c:fillRect(
                px2(nil, a),
                FLOOR,
                px2(nil, b - a),
                4
            )
        end
    end
    local function visible(____, o)
        local ____t_62 = __t
        local ____temp_61 = o.scene == SCENE and not __t(o.arena)
        __O[358] = ____temp_61
        return if ____t_62(____temp_61) then not __t(o.room) else __O[358]
    end
    local function onScreen(____, s, cam)
        return __gt(s.x, cam - 60) and __lt(s.x, cam + 1020)
    end
    local function drawBack(self, ctx, o)
        if not __t(visible(nil, o)) then
            return
        end
        if not __t(__call(
            FIELDS,
            "some",
            function(____, ____bindingPattern0)
                local b
                local a
                a = ____bindingPattern0[1]
                b = ____bindingPattern0[2]
                return b > o.camera - 60 and __lt(a, o.camera + 1020)
            end
        )) then
            return
        end
        if not __t(stalks) then
            build(nil)
        end
        local ____t_64 = __t
        local ____TS__Number_result_63 = __TS__Number(o.time)
        __O[359] = ____TS__Number_result_63
        local t = if ____t_64(____TS__Number_result_63) then __O[359] else 0
        local dt = math.max(
            0,
            math.min(0.05, t - lastT)
        )
        lastT = t
        palette(nil, o.scene)
        update(nil, o, dt)
        local ____t_70 = __t
        local ____opt_67 = window.Graphics
        if ____opt_67 ~= nil then
            ____opt_67 = ____opt_67.isLite
        end
        local ____opt_result_69
        if ____opt_67 ~= nil then
            ____opt_result_69 = ____opt_67(____opt_67)
        end
        local lite = not not ____t_70(____opt_result_69)
        ctx:save()
        ctx.imageSmoothingEnabled = false
        mass(nil, ctx, o)
        __call(
            __get(stalks, 0),
            "forEach",
            function(____, s, i)
                local ____t_73 = __t
                local ____t_72 = __t
                local ____temp_71 = not __t(lite) or __mod(i, 2) == 0
                __O[360] = ____temp_71
                if ____t_73(if ____t_72(____temp_71) then onScreen(nil, s, o.camera) else __O[360]) then
                    stalk(
                        nil,
                        ctx,
                        s,
                        lite,
                        true
                    )
                end
            end
        )
        ctx:restore()
    end
    local function drawFront(self, ctx, o)
        if __t(not __t(visible(nil, o)) or not __t(stalks)) then
            return
        end
        if not __t(__call(
            FIELDS,
            "some",
            function(____, ____bindingPattern0)
                local b
                local a
                a = ____bindingPattern0[1]
                b = ____bindingPattern0[2]
                return b > o.camera - 60 and __lt(a, o.camera + 1020)
            end
        )) then
            return
        end
        local ____t_79 = __t
        local ____opt_76 = window.Graphics
        if ____opt_76 ~= nil then
            ____opt_76 = ____opt_76.isLite
        end
        local ____opt_result_78
        if ____opt_76 ~= nil then
            ____opt_result_78 = ____opt_76(____opt_76)
        end
        local lite = not not ____t_79(____opt_result_78)
        ctx:save()
        ctx.imageSmoothingEnabled = false
        __call(
            __get(stalks, 1),
            "forEach",
            function(____, s, i)
                local ____t_82 = __t
                local ____t_81 = __t
                local ____temp_80 = not __t(lite) or __mod(i, 2) == 0
                __O[361] = ____temp_80
                if ____t_82(if ____t_81(____temp_80) then onScreen(nil, s, o.camera) else __O[361]) then
                    stalk(nil, ctx, s, lite)
                end
            end
        )
        for ____, c in __iterar((chaff)) do
            ctx.globalAlpha = cl(nil, c.life * 1.5)
            ctx.fillStyle = __get(PAL, c.c)
            ctx:fillRect(
                px2(nil, c.x),
                px2(nil, c.y),
                2,
                2
            )
        end
        ctx:restore()
    end
    window.Trigal = __ord(
        {
            drawBack = drawBack,
            drawFront = drawFront,
            fields = function() return __call(
                FIELDS,
                "map",
                function(____, f) return __call(f, "slice") end
            ) end,
            stats = function() return {
                pes = if __t(stalks) then __add(
                    __len(__get(stalks, 0)),
                    __len(__get(stalks, 1))
                ) else 0,
                palha = __len(chaff)
            } end
        },
        "drawBack,drawFront,fields,stats"
    )
end)(nil)
return ____exports
