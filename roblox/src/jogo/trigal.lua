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
        local ____opt_78 = window.Graphics
        if ____opt_78 ~= nil then
            ____opt_78 = ____opt_78.profile
        end
        local ____opt_result_80
        if ____opt_78 ~= nil then
            ____opt_result_80 = ____opt_78(____opt_78)
        end
        local ____opt_result_81
        if ____opt_result_80 ~= nil then
            ____opt_result_81 = ____opt_result_80.particles
        end
        local ____opt_result_81_82 = ____opt_result_81
        if ____opt_result_81_82 == nil then
            ____opt_result_81_82 = 1
        end
        local max = math.floor(70 * ____opt_result_81_82 + 0.5)
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
                c = math.random() < 0.6 and "grain" or "awn"
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
                local gap = __t(row) and 7 or 4.6
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
                        local ____t_result_0
                        if __t(row) then
                            ____t_result_0 = 26 + r * 14
                        else
                            ____t_result_0 = 40 + r * 20
                        end
                        local h = ____t_result_0 * (0.55 + 0.45 * math.sqrt(edge))
                        local ____call_4 = __call
                        local ____get_result_3 = __get(stalks, row)
                        local ____temp_2 = x + (r2 - 0.5) * gap * 0.8
                        local ____t_result_1
                        if __t(row) then
                            ____t_result_1 = FLOOR + 4 + math.floor(r2 * 3 + 0.5) * 2
                        else
                            ____t_result_1 = FLOOR - 2 - math.floor(r * 3 + 0.5) * 2
                        end
                        ____call_4(____get_result_3, "push", {
                            x = ____temp_2,
                            base = ____t_result_1,
                            h = h,
                            ph = r * 6.28,
                            tone = r2,
                            a = 0,
                            w = 0,
                            flat = 0,
                            dir = 0
                        })
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
                    local ____t_result_7
                    local ____t_6 = __t
                    local ____temp_5 = p.base - q.base
                    __O[356] = ____temp_5
                    if ____t_6(____temp_5) then
                        ____t_result_7 = __O[356]
                    else
                        ____t_result_7 = p.x - q.x
                    end
                    return ____t_result_7
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
        local ____opt_10 = window.DayTime
        if ____opt_10 ~= nil then
            ____opt_10 = ____opt_10.state
        end
        local ____opt_result_12
        if ____opt_10 ~= nil then
            ____opt_result_12 = ____opt_10(____opt_10)
        end
        local s = ____opt_result_12
        local ____t_result_19
        local ____t_18 = __t
        local ____opt_15 = window.Weather
        if ____opt_15 ~= nil then
            ____opt_15 = ____opt_15.state
        end
        local ____opt_result_17
        if ____opt_15 ~= nil then
            ____opt_result_17 = ____opt_15(____opt_15)
        end
        __O[357] = ____opt_result_17
        if ____t_18(____opt_result_17) then
            ____t_result_19 = __O[357]
        else
            ____t_result_19 = {}
        end
        local w = ____t_result_19
        local ____t_result_26
        local ____t_25 = __t
        local ____opt_22 = window.HdMaps
        if ____opt_22 ~= nil then
            ____opt_22 = ____opt_22.sun
        end
        local ____opt_result_24
        if ____opt_22 ~= nil then
            ____opt_result_24 = ____opt_22(____opt_22)
        end
        __O[358] = ____opt_result_24
        if ____t_25(____opt_result_24) then
            ____t_result_26 = __O[358]
        else
            ____t_result_26 = {lean = 0, str = 1}
        end
        local sun = ____t_result_26
        local ____t_32 = __t
        local ____opt_29 = window.HdMaps
        if ____opt_29 ~= nil then
            ____opt_29 = ____opt_29.handles
        end
        local ____opt_result_31
        if ____opt_29 ~= nil then
            ____opt_result_31 = ____opt_29(____opt_29, scene)
        end
        local selfLit = not not ____t_32(____opt_result_31)
        local ____t_result_35
        local ____t_34 = __t
        local ____t_result_33
        if __t(selfLit) then
            ____t_result_33 = s
        else
            ____t_result_33 = selfLit
        end
        if ____t_34(____t_result_33) then
            ____t_result_35 = s.amb
        else
            ____t_result_35 = __arrL({1, 1, 1}, 3)
        end
        local amb = ____t_result_35
        local ____t_result_36
        if __t(w.wet) then
            ____t_result_36 = w.wet
        else
            ____t_result_36 = 0
        end
        local wet = cl(nil, ____t_result_36)
        local ____t_result_39
        local ____t_38 = __t
        local ____t_result_37
        if __t(s) then
            ____t_result_37 = s.sunT ~= nil
        else
            ____t_result_37 = s
        end
        if ____t_38(____t_result_37) then
            ____t_result_39 = cl(
                nil,
                1 - math.sin(s.sunT * math.pi) * 1.7
            ) * cl(nil, sun.str * 1.5)
        else
            ____t_result_39 = 0
        end
        local gold = ____t_result_39
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
        local ____PAL_44 = PAL
        local ____math_floor_result_42 = math.floor(200 + 30 * (1 - gold) + 0.5)
        local ____math_floor_result_43 = math.floor(120 + 60 * (1 - gold) + 0.5)
        local ____temp_41 = (0.25 + 0.55 * gold) * cl(nil, sun.str)
        local ____t_result_40
        if __t(s) then
            ____t_result_40 = 1 - s.night
        else
            ____t_result_40 = 1
        end
        ____PAL_44.rim = ((((("rgba(255," .. tostring(____math_floor_result_42)) .. ",") .. tostring(____math_floor_result_43)) .. ",") .. tostring(____temp_41 * ____t_result_40)) .. ")"
        PAL.lean = sun.lean
        local ____PAL_47 = PAL
        local ____cl_result_46 = cl(nil, sun.str)
        local ____t_result_45
        if __t(s) then
            ____t_result_45 = 1 - s.night
        else
            ____t_result_45 = 1
        end
        ____PAL_47.sunStr = ____cl_result_46 * ____t_result_45
        PAL.gold = gold
        local ____PAL_49 = PAL
        local ____t_result_48
        if __t(w.cover) then
            ____t_result_48 = w.cover
        else
            ____t_result_48 = 0
        end
        ____PAL_49.snow = cl(nil, ____t_result_48 * 1.4)
        PAL.wet = wet
        local ____PAL_53 = PAL
        local ____t_result_52
        local ____t_51 = __t
        local ____TS__Number_result_50 = __TS__Number(w.wind)
        __O[359] = ____TS__Number_result_50
        if ____t_51(____TS__Number_result_50) then
            ____t_result_52 = __O[359]
        else
            ____t_result_52 = 0.15
        end
        ____PAL_53.wind = ____t_result_52
        local ____PAL_55 = PAL
        local ____t_result_54
        if __t(s) then
            ____t_result_54 = s.night
        else
            ____t_result_54 = 0
        end
        ____PAL_55.night = ____t_result_54
        PAL.snowC = mul(
            nil,
            __arrL({248, 250, 255}, 3)
        )
    end
    local function update(self, o, dt)
        local ____t_result_56
        if __t(o.player) then
            ____t_result_56 = o.player
        else
            ____t_result_56 = {}
        end
        local p = ____t_result_56
        local ____t_result_59
        local ____t_58 = __t
        local ____TS__Number_result_57 = __TS__Number(p.x)
        __O[360] = ____TS__Number_result_57
        if ____t_58(____TS__Number_result_57) then
            ____t_result_59 = __O[360]
        else
            ____t_result_59 = 0
        end
        local px = ____t_result_59
        local ____t_result_62
        local ____t_61 = __t
        local ____TS__Number_result_60 = __TS__Number(p.y)
        __O[361] = ____TS__Number_result_60
        if ____t_61(____TS__Number_result_60) then
            ____t_result_62 = __O[361]
        else
            ____t_result_62 = FLOOR
        end
        local py = ____t_result_62
        local ____t_result_65
        local ____t_64 = __t
        local ____TS__Number_result_63 = __TS__Number(p.vx)
        __O[362] = ____TS__Number_result_63
        if ____t_64(____TS__Number_result_63) then
            ____t_result_65 = __O[362]
        else
            ____t_result_65 = 0
        end
        local vx = ____t_result_65
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
                do
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
                        local side = d > 1 and 1 or (d < -1 and -1 or (vx >= 0 and 1 or -1))
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
        end
        local ____t_69 = __t
        local ____t_result_68
        local ____t_67 = __t
        local ____t_result_66
        if __t(inField) then
            ____t_result_66 = math.abs(vx) > 60
        else
            ____t_result_66 = inField
        end
        __O[363] = ____t_result_66
        if ____t_67(____t_result_66) then
            ____t_result_68 = py > FLOOR - 30
        else
            ____t_result_68 = __O[363]
        end
        if ____t_69(____t_result_68) then
            stepAcc = stepAcc + math.abs(vx) * dt
            if __t(stepAcc > 42 and t - lastSound > 0.16) then
                stepAcc = 0
                lastSound = t
                do
                    pcall(function()
                        local ____opt_72 = window.DarocaAudio
                        if ____opt_72 ~= nil then
                            ____opt_72 = ____opt_72.play
                        end
                        if ____opt_72 ~= nil then
                            ____opt_72(
                                ____opt_72,
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
        local ____lt_result_86
        if __lt(s.tone, 0.15) then
            ____lt_result_86 = PAL.green
        else
            local ____t_result_85
            if __t(back) then
                local ____gt_result_83
                if __gt(s.tone, 0.7) then
                    ____gt_result_83 = PAL.stemD
                else
                    ____gt_result_83 = PAL.stemB
                end
                ____t_result_85 = ____gt_result_83
            else
                local ____gt_result_84
                if __gt(s.tone, 0.5) then
                    ____gt_result_84 = PAL.stemL
                else
                    ____gt_result_84 = PAL.stemD
                end
                ____t_result_85 = ____gt_result_84
            end
            ____lt_result_86 = ____t_result_85
        end
        local stem = ____lt_result_86
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
                do
                    local u = k / n
                    local off = math.sin(s.a) * s.h * u ^ 1.7
                    local x = px2(nil, s.x + off)
                    local y = px2(nil, s.base - k * 2 * ca)
                    if k < n - ear then
                        if x == runX then
                            runTop = math.min(runTop, y)
                            do k = k + 1 continue end
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
                        do k = k + 1 continue end
                    end
                    if k == n - ear then
                        flush(nil)
                        runX = nil
                    end
                    local j = k - (n - ear)
                    local ex = x + math.floor(s.a * 2 * (j / ear) + 0.5) * 2
                    local side = __t(__mod(
                        j + __bor(s.ph * 2, 0),
                        2
                    )) and -2 or 2
                    local ____c_88 = c
                    local ____t_result_87
                    if __t(back) then
                        ____t_result_87 = PAL.earD
                    else
                        ____t_result_87 = PAL.ear
                    end
                    ____c_88.fillStyle = ____t_result_87
                    c:fillRect(ex, y, 2, 2)
                    if __t(j > 0 and j < ear) then
                        local ____c_91 = c
                        local ____temp_90
                        if __mod(j, 3) == 1 then
                            ____temp_90 = PAL.grain
                        else
                            local ____t_result_89
                            if __t(back) then
                                ____t_result_89 = PAL.earB
                            else
                                ____t_result_89 = PAL.earD
                            end
                            ____temp_90 = ____t_result_89
                        end
                        ____c_91.fillStyle = ____temp_90
                        c:fillRect(ex + side, y, 2, 2)
                    end
                    local ____t_97 = __t
                    local ____t_result_96
                    local ____t_95 = __t
                    local ____t_result_94
                    local ____t_93 = __t
                    local ____temp_92 = not __t(lite) and __gt(PAL.sunStr, 0.05)
                    __O[364] = ____temp_92
                    if ____t_93(____temp_92) then
                        ____t_result_94 = j > 0
                    else
                        ____t_result_94 = __O[364]
                    end
                    __O[365] = ____t_result_94
                    if ____t_95(____t_result_94) then
                        ____t_result_96 = side > 0 == __lt(lean, 0)
                    else
                        ____t_result_96 = __O[365]
                    end
                    if ____t_97(____t_result_96) then
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
                end
                k = k + 1
            end
        end
    end
    local function mass(self, c, o)
        for ____, ____value in __iterar((FIELDS)) do
            local a = ____value[1]
            local b = ____value[2]
            do
                if __t(b < o.camera - 40 or __gt(a, o.camera + 1000)) then
                    continue
                end
                do
                    local x = px2(nil, a)
                    while x < b do
                        do
                            local edge = cl(
                                nil,
                                math.min(x - a, b - x) / 30
                            )
                            local ____t_result_98
                            if __t(o.player) then
                                ____t_result_98 = o.player
                            else
                                ____t_result_98 = {}
                            end
                            local p = ____t_result_98
                            local ____x_102 = x
                            local ____t_result_101
                            local ____t_100 = __t
                            local ____TS__Number_result_99 = __TS__Number(p.x)
                            __O[366] = ____TS__Number_result_99
                            if ____t_100(____TS__Number_result_99) then
                                ____t_result_101 = __O[366]
                            else
                                ____t_result_101 = -999
                            end
                            local d = math.abs(____x_102 - ____t_result_101)
                            local ____t_result_107
                            local ____t_106 = __t
                            local ____t_result_105
                            local ____t_104 = __t
                            local ____TS__Number_result_103 = __TS__Number(p.y)
                            __O[367] = ____TS__Number_result_103
                            if ____t_104(____TS__Number_result_103) then
                                ____t_result_105 = __O[367]
                            else
                                ____t_result_105 = FLOOR
                            end
                            if ____t_106(____t_result_105 > FLOOR - 40 and d < 20) then
                                ____t_result_107 = (1 - d / 20) * 14
                            else
                                ____t_result_107 = 0
                            end
                            local dip = ____t_result_107
                            local wave = math.sin(o.time * 1.6 - x * 0.045) * 2 * PAL.wind
                            local h = math.max(
                                0,
                                (22 + hash(nil, x * 0.37) * 8) * math.sqrt(edge) - dip + wave
                            )
                            if h < 2 then
                                do x = x + 2 continue end
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
    end
    local function visible(____, o)
        local ____t_result_110
        local ____t_109 = __t
        local ____temp_108 = o.scene == SCENE and not __t(o.arena)
        __O[368] = ____temp_108
        if ____t_109(____temp_108) then
            ____t_result_110 = not __t(o.room)
        else
            ____t_result_110 = __O[368]
        end
        return ____t_result_110
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
        local ____t_result_113
        local ____t_112 = __t
        local ____TS__Number_result_111 = __TS__Number(o.time)
        __O[369] = ____TS__Number_result_111
        if ____t_112(____TS__Number_result_111) then
            ____t_result_113 = __O[369]
        else
            ____t_result_113 = 0
        end
        local t = ____t_result_113
        local dt = math.max(
            0,
            math.min(0.05, t - lastT)
        )
        lastT = t
        palette(nil, o.scene)
        update(nil, o, dt)
        local ____t_119 = __t
        local ____opt_116 = window.Graphics
        if ____opt_116 ~= nil then
            ____opt_116 = ____opt_116.isLite
        end
        local ____opt_result_118
        if ____opt_116 ~= nil then
            ____opt_result_118 = ____opt_116(____opt_116)
        end
        local lite = not not ____t_119(____opt_result_118)
        ctx:save()
        ctx.imageSmoothingEnabled = false
        mass(nil, ctx, o)
        __call(
            __get(stalks, 0),
            "forEach",
            function(____, s, i)
                local ____t_123 = __t
                local ____t_result_122
                local ____t_121 = __t
                local ____temp_120 = not __t(lite) or __mod(i, 2) == 0
                __O[370] = ____temp_120
                if ____t_121(____temp_120) then
                    ____t_result_122 = onScreen(nil, s, o.camera)
                else
                    ____t_result_122 = __O[370]
                end
                if ____t_123(____t_result_122) then
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
        local ____t_129 = __t
        local ____opt_126 = window.Graphics
        if ____opt_126 ~= nil then
            ____opt_126 = ____opt_126.isLite
        end
        local ____opt_result_128
        if ____opt_126 ~= nil then
            ____opt_result_128 = ____opt_126(____opt_126)
        end
        local lite = not not ____t_129(____opt_result_128)
        ctx:save()
        ctx.imageSmoothingEnabled = false
        __call(
            __get(stalks, 1),
            "forEach",
            function(____, s, i)
                local ____t_133 = __t
                local ____t_result_132
                local ____t_131 = __t
                local ____temp_130 = not __t(lite) or __mod(i, 2) == 0
                __O[371] = ____temp_130
                if ____t_131(____temp_130) then
                    ____t_result_132 = onScreen(nil, s, o.camera)
                else
                    ____t_result_132 = __O[371]
                end
                if ____t_133(____t_result_132) then
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
            stats = function()
                local ____t_result_134
                if __t(stalks) then
                    ____t_result_134 = __add(
                        __len(__get(stalks, 0)),
                        __len(__get(stalks, 1))
                    )
                else
                    ____t_result_134 = 0
                end
                return {
                    pes = ____t_result_134,
                    palha = __len(chaff)
                }
            end
        },
        "drawBack,drawFront,fields,stats"
    )
end)(nil)
return ____exports
