--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __le, __gt, __ge, __getq, __mod, __ord, __arrL, __iterar, __t, __get, __set = __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__getq, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set
local __del, __len, __call, __add, __iter, __isArray, __arrayFrom, __bor = __JSR.__del, __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__iter, __JSR.__isArray, __JSR.__arrayFrom, __JSR.__bor
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__MathSign = ____lualib.__TS__MathSign
local WeakSet = ____lualib.WeakSet
local __TS__New = ____lualib.__TS__New
local WeakMap = ____lualib.WeakMap
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local ____exports = {}
local __O = {};
(function()
    local sound, say, snap, igniteNear, FLOOR, SOUND, lastSound
    function sound(self, name)
        local t = window.performance:now()
        if t - lastSound < 60 then
            return
        end
        lastSound = t
        do
            pcall(function()
                local ____opt_73 = window.DarocaAudio
                if ____opt_73 ~= nil then
                    ____opt_73 = ____opt_73.play
                end
                if ____opt_73 ~= nil then
                    ____opt_73(____opt_73, name)
                end
            end)
        end
    end
    function say(self, S, x, y, txt, col)
        if col == nil then
            col = "#fff0c4"
        end
        local ____t_80 = __t
        local ____opt_77 = window.Campanha2
        if ____opt_77 ~= nil then
            ____opt_77 = ____opt_77.aberto
        end
        local ____opt_result_79
        if ____opt_77 ~= nil then
            ____opt_result_79 = ____opt_77(____opt_77)
        end
        if not ____t_80(____opt_result_79) then
            __call(S.texts, "push", {
                x = x,
                y = y,
                txt = txt,
                col = col,
                life = 1.1
            })
        end
        local ____t_result_83
        local ____t_82 = __t
        local ____get_result_81 = __get(SOUND, txt)
        __O[65] = ____get_result_81
        if ____t_82(____get_result_81) then
            ____t_result_83 = __O[65]
        else
            ____t_result_83 = __t(__call(
                tostring(txt),
                "startsWith",
                "LIGOU"
            )) and "alavanca" or nil
        end
        local snd = ____t_result_83
        if __t(snd) then
            sound(nil, snd)
        end
    end
    function snap(self, S, p, t)
        p.armed = false
        p.t = t
        __call(
            S.fx,
            "push",
            {
                k = "chunk",
                x = p.x + 9,
                y = FLOOR - 6,
                vx = (math.random() - 0.5) * 120,
                vy = -320,
                s = 6,
                col = "#f2d24a",
                life = 1.4
            }
        )
        say(
            nil,
            S,
            p.x + 9,
            FLOOR - 30,
            "TÁC!"
        )
    end
    function igniteNear(self, S, x, r, t)
        for ____, p in __iterar((S.props)) do
            do
                local ____t_94 = __t
                local ____t_result_93
                local ____t_92 = __t
                local ____temp_91 = p.type == "grass" and __gt(x, p.x - r)
                __O[67] = ____temp_91
                if ____t_92(____temp_91) then
                    ____t_result_93 = __lt(
                        x,
                        __add(
                            __add(p.x, p.w),
                            r
                        )
                    )
                else
                    ____t_result_93 = __O[67]
                end
                if ____t_94(____t_result_93) then
                    local ____gt_102 = __gt
                    local ____t_result_101
                    local ____t_100 = __t
                    local ____opt_97 = window.Weather
                    if ____opt_97 ~= nil then
                        ____opt_97 = ____opt_97.state
                    end
                    local ____opt_result_99
                    if ____opt_97 ~= nil then
                        ____opt_result_99 = ____opt_97(____opt_97).rain
                    end
                    __O[68] = ____opt_result_99
                    if ____t_100(____opt_result_99) then
                        ____t_result_101 = __O[68]
                    else
                        ____t_result_101 = 0
                    end
                    local wet = ____gt_102(____t_result_101, 0.35) or __gt(S.wet, 0)
                    if __t(wet) then
                        continue
                    end
                    local i = math.max(
                        0,
                        math.min(
                            __len(p.cells) - 1,
                            math.floor((x - p.x) / 8 + 0.5)
                        )
                    )
                    if __get(p.cells, i).s == 0 then
                        __get(p.cells, i).s = 1
                        __get(p.cells, i).t = t
                    end
                end
            end
        end
    end
    local ____ = "use strict"
    if __t(window.Interact) then
        return
    end
    FLOOR = 440
    local OUT = __arrL({
        0,
        1,
        3,
        4,
        5,
        7,
        9
    }, 7)
    local function hash(____, n)
        local x = math.sin(n * 127.1 + 311.7) * 43758.5453
        return x - math.floor(x)
    end
    local function R(____, c, x, y, w, h, col)
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
    local function lite()
        local ____t_5 = __t
        local ____opt_2 = window.Graphics
        if ____opt_2 ~= nil then
            ____opt_2 = ____opt_2.isLite
        end
        local ____opt_result_4
        if ____opt_2 ~= nil then
            ____opt_result_4 = ____opt_2(____opt_2)
        end
        return not not ____t_5(____opt_result_4)
    end
    local function worldW(____, scene)
        local ____t_result_18
        local ____t_17 = __t
        local ____t_result_16
        local ____t_10 = __t
        local ____getq_8 = __getq
        local ____opt_6 = window.WorldData
        if ____opt_6 ~= nil then
            ____opt_6 = ____opt_6.widths
        end
        local ____TS__Number_result_9 = __TS__Number(____getq_8(____opt_6, scene))
        __O[56] = ____TS__Number_result_9
        if ____t_10(____TS__Number_result_9) then
            ____t_result_16 = __O[56]
        else
            local ____opt_13 = window.CampanhaCenarios
            if ____opt_13 ~= nil then
                ____opt_13 = ____opt_13.largura
            end
            local ____opt_result_15
            if ____opt_13 ~= nil then
                ____opt_result_15 = ____opt_13(____opt_13, scene)
            end
            ____t_result_16 = __TS__Number(____opt_result_15)
        end
        __O[57] = ____t_result_16
        if ____t_17(____t_result_16) then
            ____t_result_18 = __O[57]
        else
            ____t_result_18 = 4800
        end
        return ____t_result_18
    end
    local SPEC = {
        ["0"] = __arrL(
            {
                __arrL({"crate", 1000}, 2),
                __arrL({"crate", 1030, 1}, 3),
                __arrL({"crate", 2300}, 2),
                __arrL({"hay", 1500}, 2),
                __arrL({"hay", 2650}, 2),
                __arrL({"melon", 900}, 2),
                __arrL({"melon", 1950}, 2),
                __arrL({"melon", 1975}, 2),
                __arrL({"pot", 120}, 2),
                __arrL({"pot", 3480}, 2),
                __arrL({"bucket", 620}, 2),
                __arrL({"tire", 2100}, 2),
                __arrL({"door", 204, 42, 74}, 4),
                __arrL({"door", 3576, 42, 74}, 4),
                __arrL({"lever", 880, "sprinkler"}, 3),
                __arrL({"puddle", 1400, 70}, 3),
                __arrL({"puddle", 2500, 90}, 3),
                __arrL({"grass", 1600, 300}, 3),
                __arrL({"grass", 2720, 260}, 3),
                __arrL({"fence", 2200, 90}, 3),
                __arrL({"grill", 3300}, 2)
            },
            21
        ),
        ["1"] = __arrL(
            {
                __arrL({"crate", 1440}, 2),
                __arrL({"crate", 2640}, 2),
                __arrL({"pot", 700}, 2),
                __arrL({"pot", 3200}, 2),
                __arrL({"trash", 2100}, 2),
                __arrL({"lever", 1700, "bell"}, 3),
                __arrL({"puddle", 2800, 80}, 3),
                __arrL({
                    "door",
                    1324,
                    52,
                    150,
                    "class"
                }, 5),
                __arrL({
                    "door",
                    2324,
                    52,
                    150,
                    "class"
                }, 5),
                __arrL({
                    "door",
                    342,
                    76,
                    130,
                    "main"
                }, 5)
            },
            10
        ),
        ["3"] = __arrL(
            {
                __arrL({"ball", 900}, 2),
                __arrL({"ball", 2000}, 2),
                __arrL({"crate", 1300}, 2),
                __arrL({"crate", 1328, 1}, 3),
                __arrL({"cone", 1700}, 2),
                __arrL({"cone", 1760}, 2),
                __arrL({"lever", 2200, "flood"}, 3),
                __arrL({"puddle", 1550, 80}, 3),
                __arrL({"grill", 2440}, 2),
                __arrL({"grass", 2800, 300}, 3),
                __arrL({"trash", 3100}, 2)
            },
            11
        ),
        ["4"] = __arrL(
            {
                __arrL({"lever", 1180, "fountain"}, 3),
                __arrL({"pot", 800}, 2),
                __arrL({"pot", 2600}, 2),
                __arrL({"trash", 1600}, 2),
                __arrL({"puddle", 1400, 90}, 3),
                __arrL({"puddle", 3000, 70}, 3),
                __arrL({"crate", 2000}, 2),
                __arrL({"bucket", 2240}, 2)
            },
            8
        ),
        ["5"] = __arrL(
            {
                __arrL({"barrel", 900}, 2),
                __arrL({"barrel", 2600}, 2),
                __arrL({"crate", 1500}, 2),
                __arrL({"crate", 1528, 1}, 3),
                __arrL({"trap", 1200}, 2),
                __arrL({"trap", 3000}, 2),
                __arrL({"lever", 2000, "party"}, 3),
                __arrL({"grill", 1800}, 2),
                __arrL({"puddle", 2300, 80}, 3),
                __arrL({"puddle", 3400, 70}, 3),
                __arrL({"tire", 2900}, 2),
                __arrL({"grass", 3700, 260}, 3),
                __arrL({"favdoors"}, 1)
            },
            13
        ),
        ["7"] = __arrL(
            {
                __arrL({"ball", 1300}, 2),
                __arrL({"ball", 2600}, 2),
                __arrL({"crate", 900}, 2),
                __arrL({"cone", 1100}, 2),
                __arrL({"cone", 1160}, 2),
                __arrL({"cone", 1220}, 2),
                __arrL({"lever", 1600, "flood"}, 3),
                __arrL({"puddle", 2100, 90}, 3),
                __arrL({"bucket", 3000}, 2)
            },
            9
        ),
        ["9"] = __arrL(
            {
                __arrL({"pot", 400}, 2),
                __arrL({"pot", 1500}, 2),
                __arrL({"trash", 2300}, 2),
                __arrL({"lever", 1960, "party"}, 3),
                __arrL({"puddle", 2600, 80}, 3),
                __arrL({"crate", 3000}, 2),
                __arrL({"ball", 1100}, 2)
            },
            7
        )
    }
    local ARENA_SPEC = __arrL(
        {
            __arrL({"crate", -340}, 2),
            __arrL({"crate", -312, 1}, 3),
            __arrL({"pot", -390}, 2),
            __arrL({"crate", 340}, 2),
            __arrL({"pot", 390}, 2),
            __arrL({"barrel", 300}, 2)
        },
        6
    )
    local BREAK = __ord(
        {
            crate = __arrL({30, 28}, 2),
            pot = __arrL({18, 24}, 2),
            hay = __arrL({40, 26}, 2),
            melon = __arrL({22, 16}, 2),
            barrel = __arrL({26, 34}, 2),
            fence = __arrL({0, 34}, 2)
        },
        "crate,pot,hay,melon,barrel,fence"
    )
    local PUSH = __ord(
        {
            tire = __arrL({26, 26}, 2),
            bucket = __arrL({18, 20}, 2),
            trash = __arrL({22, 30}, 2),
            ball = __arrL({16, 16}, 2),
            cone = __arrL({14, 18}, 2)
        },
        "tire,bucket,trash,ball,cone"
    )
    local sets = {}
    local function build(self, key, spec, off)
        if off == nil then
            off = 0
        end
        local out = {
            props = __arrL({}, 0),
            fx = __arrL({}, 0),
            texts = __arrL({}, 0),
            plat = __arrL({}, 0),
            key = key
        }
        for ____, s in __iterar((spec)) do
            local ____type, x0 = table.unpack(s, 1, 2)
            local ____t_result_19
            if __t(x0) then
                ____t_result_19 = x0
            else
                ____t_result_19 = 0
            end
            local x = ____t_result_19 + off
            if __t(__get(BREAK, ____type)) then
                local ____call_28 = __call
                local ____out_props_27 = out.props
                local ____type_22 = ____type
                local ____temp_23 = x + (____type == "fence" and 0 or 0)
                local ____temp_20
                if ____type == "fence" then
                    ____temp_20 = __get(s, 2)
                else
                    ____temp_20 = __get(
                        __get(BREAK, ____type),
                        0
                    )
                end
                local ____get_result_24 = __get(
                    __get(BREAK, ____type),
                    1
                )
                local ____temp_25 = ____type == "barrel" and 2 or 1
                local ____temp_26 = __t(__get(s, 2) == 1 and ____type ~= "fence") and 1 or 0
                local ____temp_21
                if ____type == "fence" then
                    ____temp_21 = __arrayFrom(
                        {length = math.floor(__get(s, 2) / 18 + 0.5)},
                        function() return 0 end
                    )
                else
                    ____temp_21 = nil
                end
                ____call_28(____out_props_27, "push", {
                    type = ____type_22,
                    x = ____temp_23,
                    w = ____temp_20,
                    h = ____get_result_24,
                    y = 0,
                    vy = 0,
                    hp = ____temp_25,
                    broken = 0,
                    wob = 0,
                    stack = ____temp_26,
                    alpha = 1,
                    segs = ____temp_21
                })
            elseif __t(__get(PUSH, ____type)) then
                __call(
                    out.props,
                    "push",
                    {
                        type = ____type,
                        x = x,
                        home = x,
                        w = __get(
                            __get(PUSH, ____type),
                            0
                        ),
                        h = __get(
                            __get(PUSH, ____type),
                            1
                        ),
                        y = 0,
                        vx = 0,
                        vy = 0,
                        rot = 0
                    }
                )
            elseif ____type == "door" then
                local ____call_37 = __call
                local ____out_props_36 = out.props
                local ____type_32 = ____type
                local ____x_33 = x
                local ____get_result_34 = __get(s, 2)
                local ____get_result_35 = __get(s, 3)
                local ____t_result_31
                local ____t_30 = __t
                local ____get_result_29 = __get(s, 4)
                __O[58] = ____get_result_29
                if ____t_30(____get_result_29) then
                    ____t_result_31 = __O[58]
                else
                    ____t_result_31 = "house"
                end
                ____call_37(____out_props_36, "push", {
                    type = ____type_32,
                    x = ____x_33,
                    w = ____get_result_34,
                    h = ____get_result_35,
                    kind = ____t_result_31,
                    open = 0
                })
            elseif ____type == "lever" then
                __call(
                    out.props,
                    "push",
                    {
                        type = ____type,
                        x = x,
                        effect = __get(s, 2),
                        on = false,
                        flip = 0,
                        w = 14,
                        h = 24
                    }
                )
            elseif ____type == "puddle" then
                __call(
                    out.props,
                    "push",
                    {
                        type = ____type,
                        x = x,
                        w = __get(s, 2),
                        ripples = __arrL({}, 0)
                    }
                )
            elseif ____type == "trap" then
                __call(out.props, "push", {
                    type = ____type,
                    x = x,
                    w = 18,
                    armed = true,
                    t = 0
                })
            elseif ____type == "grill" then
                __call(out.props, "push", {type = ____type, x = x, w = 30, burst = 0})
            elseif ____type == "grass" then
                __call(
                    out.props,
                    "push",
                    {
                        type = ____type,
                        x = x,
                        w = __get(s, 2),
                        cells = __arrayFrom(
                            {length = math.floor(__get(s, 2) / 8 + 0.5)},
                            function() return {s = 0, t = 0} end
                        )
                    }
                )
            elseif ____type == "favdoors" then
                do
                    local i = 1
                    while i * 210 < 7000 do
                        __call(out.props, "push", {
                            type = "door",
                            x = i * 210 + 74,
                            w = 28,
                            h = 62,
                            kind = "fav",
                            open = 0
                        })
                        i = i + 3
                    end
                end
            end
        end
        return out
    end
    local function buildPlatforms(self, scene)
        local ____call_45 = __call
        local ____call_44 = __call
        local ____t_result_43
        local ____t_42 = __t
        local ____getq_40 = __getq
        local ____opt_38 = window.WorldData
        if ____opt_38 ~= nil then
            ____opt_38 = ____opt_38.platforms
        end
        local ____getq_40_result_41 = ____getq_40(____opt_38, scene)
        __O[59] = ____getq_40_result_41
        if ____t_42(____getq_40_result_41) then
            ____t_result_43 = __O[59]
        else
            ____t_result_43 = __arrL({}, 0)
        end
        local ps = ____call_45(
            ____call_44(____t_result_43, "slice"),
            "sort",
            function(____, a, b) return __get(a, 0) - __get(b, 0) end
        )
        local out = __arrL({}, 0)
        if not __t(__len(ps)) then
            return out
        end
        local function free(____, x, w, y0, y1)
            return not __t(__call(
                ps,
                "some",
                function(____, p)
                    local ____t_result_50
                    local ____t_49 = __t
                    local ____t_result_48
                    local ____t_47 = __t
                    local ____temp_46 = __lt(
                        x,
                        __add(
                            __get(p, 0),
                            __get(p, 2)
                        ) + 30
                    ) and __gt(
                        __add(x, w),
                        __get(p, 0) - 30
                    )
                    __O[60] = ____temp_46
                    if ____t_47(____temp_46) then
                        ____t_result_48 = __gt(
                            __get(p, 1),
                            y0 - 20
                        )
                    else
                        ____t_result_48 = __O[60]
                    end
                    __O[61] = ____t_result_48
                    if ____t_49(____t_result_48) then
                        ____t_result_50 = __lt(
                            __get(p, 1),
                            y1 + 20
                        )
                    else
                        ____t_result_50 = __O[61]
                    end
                    return ____t_result_50
                end
            ))
        end
        local tops = __call(
            __call(
                ps,
                "filter",
                function(____, p) return __le(
                    __get(p, 1),
                    330
                ) end
            ),
            "sort",
            function(____, a, b) return __get(a, 1) - __get(b, 1) end
        )
        local __rot1_search = 0
        for ____, top in __iterar((tops)) do
            do
                for ____, x in __iterar((__arrL(
                    {
                        __get(top, 0) - 90,
                        __add(
                            __get(top, 0),
                            __get(top, 2)
                        ) + 20,
                        __get(top, 0) - 170,
                        __add(
                            __get(top, 0),
                            __get(top, 2)
                        ) + 100
                    },
                    4
                ))) do
                    local ____t_54 = __t
                    local ____t_result_53
                    local ____t_52 = __t
                    local ____gt_result_51 = __gt(x, 200)
                    __O[62] = ____gt_result_51
                    if ____t_52(____gt_result_51) then
                        ____t_result_53 = free(
                            nil,
                            x,
                            70,
                            __get(top, 1) + 30,
                            FLOOR - 30
                        )
                    else
                        ____t_result_53 = __O[62]
                    end
                    if ____t_54(____t_result_53) then
                        __call(
                            out,
                            "push",
                            {
                                kind = "lift",
                                x = x,
                                w = 70,
                                y0 = FLOOR - 34,
                                y1 = __get(top, 1),
                                period = 7.5,
                                cx = x,
                                cy = FLOOR - 34,
                                dx = 0
                            }
                        )
                        do
                            __rot1_search = 1
                            break
                        end
                    end
                end
                if __rot1_search == 1 then
                    break
                end
                if __rot1_search == 2 then
                    __rot1_search = 0
                    continue
                end
            end
        end
        local best = nil
        do
            local i = 0
            while i < __len(ps) - 1 do
                local a = __get(ps, i)
                local b = __get(ps, i + 1)
                local gap = __get(b, 0) - __add(
                    __get(a, 0),
                    __get(a, 2)
                )
                local ____t_58 = __t
                local ____t_result_57
                local ____t_56 = __t
                local ____temp_55 = gap > 180 and gap < 1200
                __O[63] = ____temp_55
                if ____t_56(____temp_55) then
                    ____t_result_57 = not __t(best) or gap > best.gap
                else
                    ____t_result_57 = __O[63]
                end
                if ____t_58(____t_result_57) then
                    best = {a = a, b = b, gap = gap}
                end
                i = i + 1
            end
        end
        if __t(best) then
            local y = math.min(
                __get(best.a, 1),
                __get(best.b, 1)
            ) - 10
            __call(
                out,
                "push",
                {
                    kind = "ferry",
                    x0 = __add(
                        __get(best.a, 0),
                        __get(best.a, 2)
                    ) + 14,
                    x1 = __get(best.b, 0) - 84,
                    y = y,
                    w = 70,
                    period = 6 + best.gap / 160,
                    cx = __add(
                        __get(best.a, 0),
                        __get(best.a, 2)
                    ) + 14,
                    cy = y,
                    dx = 0
                }
            )
        end
        return out
    end
    local function getSet(self, o)
        if __t(o.room) then
            return nil
        end
        if __t(o.arena) then
            local key = __add(
                __add(
                    __add("arena:", o.arenaType),
                    ":"
                ),
                o.homeX
            )
            if not __t(__get(sets, key)) then
                __set(
                    sets,
                    key,
                    build(nil, key, ARENA_SPEC, o.homeX)
                )
            end
            return __get(sets, key)
        end
        if not __t(__call(OUT, "includes", o.scene)) then
            return nil
        end
        local key = __add("scene:", o.scene)
        if not __t(__get(sets, key)) then
            local ____set_63 = __set
            local ____build_62 = build
            local ____t_result_61
            local ____t_60 = __t
            local ____get_result_59 = __get(SPEC, o.scene)
            __O[64] = ____get_result_59
            if ____t_60(____get_result_59) then
                ____t_result_61 = __O[64]
            else
                ____t_result_61 = __arrL({}, 0)
            end
            ____set_63(
                sets,
                key,
                ____build_62(nil, key, ____t_result_61)
            )
            __get(sets, key).plat = buildPlatforms(nil, o.scene)
        end
        return __get(sets, key)
    end
    local function debris(self, S, x, y, cols, n, spread, up)
        if spread == nil then
            spread = 1
        end
        if up == nil then
            up = 1
        end
        do
            local i = 0
            while __lt(i, n) do
                __call(
                    S.fx,
                    "push",
                    {
                        k = "chunk",
                        x = x + (math.random() - 0.5) * 20,
                        y = y - math.random() * 16,
                        vx = (math.random() - 0.5) * 360 * spread,
                        vy = -(160 + math.random() * 260) * up,
                        s = 2 + __bor(
                            math.random() * 3,
                            0
                        ) * 2,
                        col = __get(
                            cols,
                            __mod(
                                i,
                                __len(cols)
                            )
                        ),
                        life = 1.2 + math.random() * 0.6,
                        rot = 0
                    }
                )
                i = i + 1
            end
        end
    end
    local function dust(self, S, x, y, n, col)
        if col == nil then
            col = "rgba(214,196,160,.8)"
        end
        do
            local i = 0
            while __lt(i, n) do
                __call(
                    S.fx,
                    "push",
                    {
                        k = "puff",
                        x = x + (math.random() - 0.5) * 26,
                        y = y - math.random() * 8,
                        vx = (math.random() - 0.5) * 90,
                        vy = -20 - math.random() * 40,
                        s = 4 + math.random() * 6,
                        col = col,
                        life = 0.7 + math.random() * 0.4,
                        max = 1.1
                    }
                )
                i = i + 1
            end
        end
    end
    local function drops(self, S, x, y, n, power)
        if power == nil then
            power = 1
        end
        do
            local i = 0
            while __lt(i, n) do
                __call(
                    S.fx,
                    "push",
                    {
                        k = "drop",
                        x = x + (math.random() - 0.5) * 16,
                        y = y,
                        vx = (math.random() - 0.5) * 220 * power,
                        vy = -(120 + math.random() * 200) * power,
                        s = 2,
                        col = math.random() > 0.5 and "#bfe6f6" or "#e8f8ff",
                        life = 0.9
                    }
                )
                i = i + 1
            end
        end
    end
    local function sparks(self, S, x, y, n, col)
        if col == nil then
            col = "#ffd27a"
        end
        do
            local i = 0
            while __lt(i, n) do
                local ____call_70 = __call
                local ____S_fx_69 = S.fx
                local ____x_65 = x
                local ____y_66 = y
                local ____temp_67 = (math.random() - 0.5) * 300
                local ____temp_68 = -60 - math.random() * 260
                local ____t_result_64
                if __t(__mod(i, 3)) then
                    ____t_result_64 = col
                else
                    ____t_result_64 = "#fff6d0"
                end
                ____call_70(
                    ____S_fx_69,
                    "push",
                    {
                        k = "spark",
                        x = ____x_65,
                        y = ____y_66,
                        vx = ____temp_67,
                        vy = ____temp_68,
                        s = 2,
                        col = ____t_result_64,
                        life = 0.5 + math.random() * 0.5
                    }
                )
                i = i + 1
            end
        end
    end
    SOUND = __ord({
        ["CRAC!"] = "quebra",
        ["CRÁS!"] = "quebra",
        ["BLAM!"] = "quebra",
        ["PLAFT!"] = "quebra",
        ["SPLOC!"] = "agua",
        ["TÁC!"] = "tac",
        ["FUFF!"] = "fogo",
        ["LIGOU!"] = "alavanca",
        DESLIGOU = "alavanca"
    }, "CRAC!,CRÁS!,BLAM!,PLAFT!,SPLOC!,TÁC!,FUFF!,LIGOU!,DESLIGOU")
    lastSound = 0
    local function leaves(self, S, x, n)
        do
            local i = 0
            while __lt(i, n) do
                __call(
                    S.fx,
                    "push",
                    {
                        k = "leaf",
                        x = x + (math.random() - 0.5) * 260,
                        y = 120 + math.random() * 140,
                        vx = (math.random() - 0.5) * 60,
                        vy = 30 + math.random() * 40,
                        s = 4,
                        col = __get(
                            __arrL({"#6aa850", "#c9a24a", "#a8c060", "#d8783a"}, 4),
                            __mod(i, 4)
                        ),
                        life = 2.6 + math.random(),
                        ph = math.random() * 6
                    }
                )
                i = i + 1
            end
        end
    end
    local function hitProp(self, S, p, dir, power, t)
        if __t(__get(BREAK, p.type)) then
            if __t(p.broken) then
                return
            end
            p.wob = 1
            p.vy = -120 * power
            local ____p_84, ____hp_85 = p, "hp"
            local ____p_hp_86 = ____p_84[____hp_85] - 1
            ____p_84[____hp_85] = ____p_hp_86
            if ____p_hp_86 > 0 then
                debris(
                    nil,
                    S,
                    p.x + p.w / 2,
                    FLOOR - p.h / 2,
                    __arrL({"#8a6238", "#5a4028"}, 2),
                    4
                )
                return
            end
            p.broken = t
            local cx = p.x + p.w / 2
            local cy = FLOOR - p.h / 2 - (__t(p.stack) and 28 or 0)
            if p.type == "crate" then
                debris(
                    nil,
                    S,
                    cx,
                    cy,
                    __arrL({"#a87a48", "#8a6238", "#c49a5c", "#5a4028"}, 4),
                    14
                )
                dust(
                    nil,
                    S,
                    cx,
                    FLOOR,
                    6
                )
                say(
                    nil,
                    S,
                    cx,
                    cy - 20,
                    "CRAC!"
                )
            end
            if p.type == "pot" then
                debris(
                    nil,
                    S,
                    cx,
                    cy,
                    __arrL({"#bf755a", "#a85a40", "#d99572"}, 3),
                    9
                )
                debris(
                    nil,
                    S,
                    cx,
                    cy,
                    __arrL({"#5a3a20", "#4a2e1a"}, 2),
                    6,
                    0.6
                )
                debris(
                    nil,
                    S,
                    cx,
                    cy - 10,
                    __arrL({"#4f9a3f", "#6fb24a"}, 2),
                    4,
                    0.8,
                    1.3
                )
                say(
                    nil,
                    S,
                    cx,
                    cy - 20,
                    "PLAFT!"
                )
            end
            if p.type == "hay" then
                debris(
                    nil,
                    S,
                    cx,
                    cy,
                    __arrL({"#dfbd6c", "#f4dc92", "#c79a56"}, 3),
                    22,
                    1.3
                )
                dust(
                    nil,
                    S,
                    cx,
                    FLOOR,
                    8,
                    "rgba(240,220,150,.8)"
                )
                say(
                    nil,
                    S,
                    cx,
                    cy - 20,
                    "FUFF!"
                )
            end
            if p.type == "melon" then
                debris(
                    nil,
                    S,
                    cx,
                    cy,
                    __arrL({"#e04a4a", "#ff7a6a", "#3a7a3a", "#1a1a1a"}, 4),
                    14,
                    1.1
                )
                say(
                    nil,
                    S,
                    cx,
                    cy - 16,
                    "SPLOC!",
                    "#ffb0a0"
                )
            end
            if p.type == "barrel" then
                debris(
                    nil,
                    S,
                    cx,
                    cy,
                    __arrL({"#8a6238", "#a87a48", "#4a4a4a"}, 3),
                    14
                )
                drops(
                    nil,
                    S,
                    cx,
                    cy,
                    16,
                    1.1
                )
                say(
                    nil,
                    S,
                    cx,
                    cy - 24,
                    "BLAM!"
                )
            end
            if p.type == "fence" then
                do
                    local k = 0
                    while __lt(
                        k,
                        __len(p.segs)
                    ) do
                        __set(p.segs, k, t)
                        k = k + 1
                    end
                end
                debris(
                    nil,
                    S,
                    cx,
                    FLOOR - 18,
                    __arrL({"#756c48", "#a38e5e", "#c1ae76"}, 3),
                    12
                )
                say(
                    nil,
                    S,
                    cx,
                    FLOOR - 50,
                    "CRÁS!"
                )
            end
            return
        end
        if __t(__get(PUSH, p.type)) then
            p.vx = dir * 380 * power
            p.vy = -200 * power
            return
        end
        if p.type == "lever" then
            p.on = not __t(p.on)
            p.flip = 1
            sparks(
                nil,
                S,
                p.x + 7,
                FLOOR - 40,
                6,
                "#ffe9a0"
            )
            say(
                nil,
                S,
                p.x + 7,
                FLOOR - 60,
                __t(p.on) and "LIGOU!" or "DESLIGOU",
                __t(p.on) and "#b8ff9a" or "#ffd0a0"
            )
            return
        end
        if p.type == "grill" then
            p.burst = 1
            sparks(
                nil,
                S,
                p.x + 15,
                FLOOR - 40,
                18,
                "#ffb030"
            )
            igniteNear(
                nil,
                S,
                p.x + 15,
                140,
                t
            )
            return
        end
        local ____t_90 = __t
        local ____t_result_89
        local ____t_88 = __t
        local ____temp_87 = p.type == "trap"
        __O[66] = ____temp_87
        if ____t_88(____temp_87) then
            ____t_result_89 = p.armed
        else
            ____t_result_89 = __O[66]
        end
        if ____t_90(____t_result_89) then
            snap(nil, S, p, t)
        end
    end
    local function shock(self, S, x, power, t)
        for ____, p in __iterar((S.props)) do
            do
                local ____p_x_104 = p.x
                local ____t_result_103
                if __t(p.w) then
                    ____t_result_103 = p.w
                else
                    ____t_result_103 = 0
                end
                local cx = ____p_x_104 + ____t_result_103 / 2
                local d = math.abs(cx - x)
                if d > 300 then
                    continue
                end
                local k = 1 - d / 300
                local ____t_108 = __t
                local ____t_result_107
                local ____t_106 = __t
                local ____get_result_105 = __get(BREAK, p.type)
                __O[69] = ____get_result_105
                if ____t_106(____get_result_105) then
                    ____t_result_107 = not __t(p.broken)
                else
                    ____t_result_107 = __O[69]
                end
                if ____t_108(____t_result_107) then
                    p.vy = -260 * k * power
                    p.wob = 1
                    if __t(k > 0.75 and __gt(power, 0.8)) then
                        local ____hitProp_113 = hitProp
                        local ____S_112 = S
                        local ____t_result_111
                        local ____t_110 = __t
                        local ____TS__MathSign_result_109 = __TS__MathSign(cx - x)
                        __O[70] = ____TS__MathSign_result_109
                        if ____t_110(____TS__MathSign_result_109) then
                            ____t_result_111 = __O[70]
                        else
                            ____t_result_111 = 1
                        end
                        ____hitProp_113(
                            nil,
                            ____S_112,
                            p,
                            ____t_result_111,
                            1,
                            t
                        )
                    end
                end
                if __t(__get(PUSH, p.type)) then
                    p.vy = -300 * k * power
                    p.vx = p.vx + __TS__MathSign(cx - x) * 160 * k * power
                end
                if p.type == "puddle" then
                    __call(
                        p.ripples,
                        "push",
                        {
                            x = math.max(
                                p.x,
                                math.min(
                                    __add(p.x, p.w),
                                    x
                                )
                            ),
                            t = t
                        }
                    )
                    drops(
                        nil,
                        S,
                        p.x + p.w / 2,
                        FLOOR,
                        math.floor(8 * k + 0.5),
                        1.2
                    )
                end
                local ____t_119 = __t
                local ____t_result_118
                local ____t_117 = __t
                local ____t_result_116
                local ____t_115 = __t
                local ____temp_114 = p.type == "trap"
                __O[71] = ____temp_114
                if ____t_115(____temp_114) then
                    ____t_result_116 = p.armed
                else
                    ____t_result_116 = __O[71]
                end
                __O[72] = ____t_result_116
                if ____t_117(____t_result_116) then
                    ____t_result_118 = k > 0.5
                else
                    ____t_result_118 = __O[72]
                end
                if ____t_119(____t_result_118) then
                    snap(nil, S, p, t)
                end
                if p.type == "door" then
                    p.open = math.min(1, p.open + 0.6 * k)
                end
            end
        end
        leaves(
            nil,
            S,
            x,
            math.floor(10 * power + 0.5)
        )
        dust(
            nil,
            S,
            x,
            FLOOR,
            math.floor(10 * power + 0.5)
        )
    end
    local lastAttack = 0
    local attackId = 0
    local lastT = 0
    local cur = nil
    local shotSeen = __TS__New(WeakSet)
    local enemyVy = __TS__New(WeakMap)
    local playerVy = 0
    local function update(self, dt, o)
        local S = getSet(nil, o)
        cur = S
        if not __t(S) then
            return
        end
        local ____t_result_122
        local ____t_121 = __t
        local ____TS__Number_result_120 = __TS__Number(o.time)
        __O[73] = ____TS__Number_result_120
        if ____t_121(____TS__Number_result_120) then
            ____t_result_122 = __O[73]
        else
            ____t_result_122 = 0
        end
        local t = ____t_result_122
        local p = o.player
        local ____t_result_123
        if __t(dt) then
            ____t_result_123 = dt
        else
            ____t_result_123 = 0.016
        end
        dt = math.min(0.05, ____t_result_123)
        for ____, m in __iterar((S.plat)) do
            local u = (math.sin(t * math.pi * 2 / m.period) + 1) / 2
            local e = u * u * (3 - 2 * u)
            if m.kind == "lift" then
                m.cx = m.x
                m.cy = m.y0 + (m.y1 - m.y0) * e
                m.dx = 0
            else
                local nx = m.x0 + (m.x1 - m.x0) * e
                m.dx = nx - m.cx
                m.cx = nx
                m.cy = m.y
            end
        end
        if __t(lite(nil)) then
            return
        end
        local W = __t(o.arena) and 1000000000 or worldW(nil, o.scene)
        local f = __lt(p.facing, 0) and -1 or 1
        if __t(__gt(p.attack, 0) and lastAttack <= 0) then
            attackId = attackId + 1
        end
        lastAttack = p.attack
        local ____gt_result_124
        if __gt(p.attack, 0) then
            ____gt_result_124 = {
                x0 = math.min(p.x + f * 6, p.x + f * 90),
                x1 = math.max(p.x + f * 6, p.x + f * 90),
                y0 = p.y - 95,
                y1 = p.y + 6
            }
        else
            ____gt_result_124 = nil
        end
        local atk = ____gt_result_124
        for ____, q in __iterar((S.props)) do
            local ____t_result_125
            if __t(q.h) then
                ____t_result_125 = q.h
            else
                ____t_result_125 = 20
            end
            local ____temp_127 = FLOOR - ____t_result_125 - (__t(q.stack) and 28 or 0)
            local ____t_result_126
            if __t(q.y) then
                ____t_result_126 = q.y
            else
                ____t_result_126 = 0
            end
            local top = ____temp_127 + ____t_result_126
            local x0 = q.x
            local ____add_130 = __add
            local ____q_x_129 = q.x
            local ____t_result_128
            if __t(q.w) then
                ____t_result_128 = q.w
            else
                ____t_result_128 = 20
            end
            local x1 = ____add_130(____q_x_129, ____t_result_128)
            local ____t_145 = __t
            local ____t_result_144
            local ____t_140 = __t
            local ____t_result_139
            local ____t_138 = __t
            local ____t_result_137
            local ____t_136 = __t
            local ____t_result_135
            local ____t_134 = __t
            local ____t_result_133
            local ____t_132 = __t
            local ____t_result_131
            if __t(atk) then
                ____t_result_131 = q.hitBy ~= attackId
            else
                ____t_result_131 = atk
            end
            __O[74] = ____t_result_131
            if ____t_132(____t_result_131) then
                ____t_result_133 = __gt(atk.x1, x0)
            else
                ____t_result_133 = __O[74]
            end
            __O[75] = ____t_result_133
            if ____t_134(____t_result_133) then
                ____t_result_135 = __lt(atk.x0, x1)
            else
                ____t_result_135 = __O[75]
            end
            __O[76] = ____t_result_135
            if ____t_136(____t_result_135) then
                ____t_result_137 = __gt(atk.y1, top)
            else
                ____t_result_137 = __O[76]
            end
            __O[77] = ____t_result_137
            if ____t_138(____t_result_137) then
                ____t_result_139 = atk.y0 < FLOOR + 4
            else
                ____t_result_139 = __O[77]
            end
            __O[79] = ____t_result_139
            if ____t_140(____t_result_139) then
                local ____t_result_143
                local ____t_142 = __t
                local ____temp_141 = q.type ~= "door" and q.type ~= "puddle"
                __O[78] = ____temp_141
                if ____t_142(____temp_141) then
                    ____t_result_143 = q.type ~= "grass"
                else
                    ____t_result_143 = __O[78]
                end
                ____t_result_144 = ____t_result_143
            else
                ____t_result_144 = __O[79]
            end
            if ____t_145(____t_result_144) then
                q.hitBy = attackId
                hitProp(
                    nil,
                    S,
                    q,
                    f,
                    1,
                    t
                )
            end
            local ____iter_172 = __iter
            local ____t_result_171
            if __t(o.shots) then
                ____t_result_171 = o.shots
            else
                ____t_result_171 = __arrL({}, 0)
            end
            for ____, s in __TS__Iterator(____iter_172(____t_result_171)) do
                do
                    local ____t_153 = __t
                    local ____t_result_152
                    local ____t_149 = __t
                    local ____t_result_148
                    local ____t_147 = __t
                    local ____temp_146 = not __t(s)
                    __O[80] = ____temp_146
                    if ____t_147(____temp_146) then
                        ____t_result_148 = __O[80]
                    else
                        ____t_result_148 = __call(shotSeen, "has", s)
                    end
                    __O[81] = ____t_result_148
                    if ____t_149(____t_result_148) then
                        ____t_result_152 = __O[81]
                    else
                        local ____gt_151 = __gt
                        local ____t_result_150
                        if __t(s.delay) then
                            ____t_result_150 = s.delay
                        else
                            ____t_result_150 = 0
                        end
                        ____t_result_152 = ____gt_151(____t_result_150, 0)
                    end
                    if ____t_153(____t_result_152) then
                        continue
                    end
                    local ____t_165 = __t
                    local ____t_result_164
                    local ____t_163 = __t
                    local ____t_result_162
                    local ____t_161 = __t
                    local ____t_result_160
                    local ____t_159 = __t
                    local ____t_result_158
                    local ____t_157 = __t
                    local ____t_result_156
                    local ____t_155 = __t
                    local ____temp_154 = __gt(s.x, x0) and __lt(s.x, x1)
                    __O[82] = ____temp_154
                    if ____t_155(____temp_154) then
                        ____t_result_156 = __gt(s.y, top - 4)
                    else
                        ____t_result_156 = __O[82]
                    end
                    __O[83] = ____t_result_156
                    if ____t_157(____t_result_156) then
                        ____t_result_158 = __lt(s.y, FLOOR + 4)
                    else
                        ____t_result_158 = __O[83]
                    end
                    __O[84] = ____t_result_158
                    if ____t_159(____t_result_158) then
                        ____t_result_160 = q.type ~= "door"
                    else
                        ____t_result_160 = __O[84]
                    end
                    __O[85] = ____t_result_160
                    if ____t_161(____t_result_160) then
                        ____t_result_162 = q.type ~= "puddle"
                    else
                        ____t_result_162 = __O[85]
                    end
                    __O[86] = ____t_result_162
                    if ____t_163(____t_result_162) then
                        ____t_result_164 = q.type ~= "grass"
                    else
                        ____t_result_164 = __O[86]
                    end
                    if ____t_165(____t_result_164) then
                        __call(shotSeen, "add", s)
                        local ____hitProp_170 = hitProp
                        local ____t_result_169
                        local ____t_168 = __t
                        local ____t_result_166
                        if __t(s.vx) then
                            ____t_result_166 = s.vx
                        else
                            ____t_result_166 = f
                        end
                        local ____TS__MathSign_result_167 = __TS__MathSign(____t_result_166)
                        __O[87] = ____TS__MathSign_result_167
                        if ____t_168(____TS__MathSign_result_167) then
                            ____t_result_169 = __O[87]
                        else
                            ____t_result_169 = f
                        end
                        ____hitProp_170(
                            nil,
                            S,
                            q,
                            ____t_result_169,
                            0.7,
                            t
                        )
                    end
                end
            end
        end
        local ____t_176 = __t
        local ____t_result_175
        local ____t_174 = __t
        local ____temp_173 = playerVy > 420
        __O[88] = ____temp_173
        if ____t_174(____temp_173) then
            ____t_result_175 = p.ground
        else
            ____t_result_175 = __O[88]
        end
        if ____t_176(____t_result_175) then
            for ____, q in __iterar((S.props)) do
                local ____q_x_178 = q.x
                local ____t_result_177
                if __t(q.w) then
                    ____t_result_177 = q.w
                else
                    ____t_result_177 = 0
                end
                if math.abs(____q_x_178 + ____t_result_177 / 2 - p.x) < 90 then
                    local ____t_182 = __t
                    local ____t_result_181
                    local ____t_180 = __t
                    local ____temp_179 = q.type == "puddle" and __gt(p.x, q.x)
                    __O[89] = ____temp_179
                    if ____t_180(____temp_179) then
                        ____t_result_181 = __lt(
                            p.x,
                            __add(q.x, q.w)
                        )
                    else
                        ____t_result_181 = __O[89]
                    end
                    if ____t_182(____t_result_181) then
                        __call(q.ripples, "push", {x = p.x, t = t})
                        drops(
                            nil,
                            S,
                            p.x,
                            FLOOR,
                            10,
                            1
                        )
                    else
                        local ____t_186 = __t
                        local ____t_result_185
                        local ____t_184 = __t
                        local ____get_result_183 = __get(BREAK, q.type)
                        __O[90] = ____get_result_183
                        if ____t_184(____get_result_183) then
                            ____t_result_185 = __O[90]
                        else
                            ____t_result_185 = __get(PUSH, q.type)
                        end
                        if ____t_186(____t_result_185) then
                            local ____t_result_187
                            if __t(q.vy) then
                                ____t_result_187 = q.vy
                            else
                                ____t_result_187 = 0
                            end
                            q.vy = math.min(____t_result_187, -90)
                            q.wob = 0.6
                        end
                    end
                end
            end
        end
        local ____t_result_188
        if __t(p.vy) then
            ____t_result_188 = p.vy
        else
            ____t_result_188 = 0
        end
        playerVy = ____t_result_188
        local ____iter_222 = __iter
        local ____t_result_221
        if __t(o.enemies) then
            ____t_result_221 = o.enemies
        else
            ____t_result_221 = __arrL({}, 0)
        end
        for ____, e in __TS__Iterator(____iter_222(____t_result_221)) do
            do
                if __t(not __t(e) or __le(e.hp, 0)) then
                    continue
                end
                local ____t_result_191
                local ____t_190 = __t
                local ____call_result_189 = __call(enemyVy, "get", e)
                __O[91] = ____call_result_189
                if ____t_190(____call_result_189) then
                    ____t_result_191 = __O[91]
                else
                    ____t_result_191 = 0
                end
                local pv = ____t_result_191
                local big = __call(
                    __arrL({
                        "giant",
                        "igor",
                        "reeisBoss",
                        "nikolas",
                        "freddy"
                    }, 5),
                    "includes",
                    e.type
                )
                local ____t_196 = __t
                local ____t_result_195
                local ____t_194 = __t
                local ____gt_result_193 = __gt(pv, 380)
                if ____gt_result_193 then
                    local ____t_result_192
                    if __t(e.vy) then
                        ____t_result_192 = e.vy
                    else
                        ____t_result_192 = 0
                    end
                    ____gt_result_193 = math.abs(____t_result_192) < 60
                end
                __O[92] = ____gt_result_193
                if ____t_194(____gt_result_193) then
                    ____t_result_195 = __ge(e.y, FLOOR - 6)
                else
                    ____t_result_195 = __O[92]
                end
                if ____t_196(____t_result_195) then
                    shock(
                        nil,
                        S,
                        e.x,
                        __t(big) and 1.2 or 0.7,
                        t
                    )
                end
                local ____call_199 = __call
                local ____enemyVy_198 = enemyVy
                local ____t_result_197
                if __t(e.vy) then
                    ____t_result_197 = e.vy
                else
                    ____t_result_197 = 0
                end
                ____call_199(____enemyVy_198, "set", e, ____t_result_197)
                for ____, q in __iterar((S.props)) do
                    do
                        local x0 = q.x
                        local ____add_202 = __add
                        local ____q_x_201 = q.x
                        local ____t_result_200
                        if __t(q.w) then
                            ____t_result_200 = q.w
                        else
                            ____t_result_200 = 20
                        end
                        local x1 = ____add_202(____q_x_201, ____t_result_200)
                        local ____t_206 = __t
                        local ____t_result_205
                        local ____t_204 = __t
                        local ____temp_203 = __lt(e.x, x0 - 20) or __gt(e.x, x1 + 20)
                        __O[93] = ____temp_203
                        if ____t_204(____temp_203) then
                            ____t_result_205 = __O[93]
                        else
                            ____t_result_205 = __lt(e.y, FLOOR - 120)
                        end
                        if ____t_206(____t_result_205) then
                            continue
                        end
                        if __t(__get(PUSH, q.type)) then
                            local ____t_result_207
                            if __t(e.vx) then
                                ____t_result_207 = e.vx
                            else
                                ____t_result_207 = 0
                            end
                            q.vx = ____t_result_207 * 1.1
                        end
                        local ____t_212 = __t
                        local ____t_result_211
                        local ____t_209 = __t
                        local ____get_result_208 = __get(BREAK, q.type)
                        __O[94] = ____get_result_208
                        if ____t_209(____get_result_208) then
                            local ____t_result_210
                            if __t(e.vx) then
                                ____t_result_210 = e.vx
                            else
                                ____t_result_210 = 0
                            end
                            ____t_result_211 = math.abs(____t_result_210) > 260
                        else
                            ____t_result_211 = __O[94]
                        end
                        if ____t_212(____t_result_211) then
                            local ____hitProp_216 = hitProp
                            local ____t_result_215
                            local ____t_214 = __t
                            local ____TS__MathSign_result_213 = __TS__MathSign(e.vx)
                            __O[95] = ____TS__MathSign_result_213
                            if ____t_214(____TS__MathSign_result_213) then
                                ____t_result_215 = __O[95]
                            else
                                ____t_result_215 = 1
                            end
                            ____hitProp_216(
                                nil,
                                S,
                                q,
                                ____t_result_215,
                                1,
                                t
                            )
                        end
                        if __t(q.type == "puddle" and math.random() < 0.2) then
                            __call(q.ripples, "push", {x = e.x, t = t})
                        end
                        local ____t_220 = __t
                        local ____t_result_219
                        local ____t_218 = __t
                        local ____temp_217 = q.type == "trap"
                        __O[96] = ____temp_217
                        if ____t_218(____temp_217) then
                            ____t_result_219 = q.armed
                        else
                            ____t_result_219 = __O[96]
                        end
                        if ____t_220(____t_result_219) then
                            snap(nil, S, q, t)
                        end
                    end
                end
            end
        end
        local ____iter_234 = __iter
        local ____t_result_233
        if __t(o.minions) then
            ____t_result_233 = o.minions
        else
            ____t_result_233 = __arrL({}, 0)
        end
        for ____, m in __TS__Iterator(____iter_234(____t_result_233)) do
            do
                local ____t_226 = __t
                local ____t_result_225
                local ____t_224 = __t
                local ____temp_223 = not __t(m)
                __O[97] = ____temp_223
                if ____t_224(____temp_223) then
                    ____t_result_225 = __O[97]
                else
                    ____t_result_225 = m.dead
                end
                if ____t_226(____t_result_225) then
                    continue
                end
                for ____, q in __iterar((S.props)) do
                    local ____t_232 = __t
                    local ____t_result_231
                    local ____t_230 = __t
                    local ____t_result_229
                    local ____t_228 = __t
                    local ____temp_227 = q.type == "trap"
                    __O[98] = ____temp_227
                    if ____t_228(____temp_227) then
                        ____t_result_229 = q.armed
                    else
                        ____t_result_229 = __O[98]
                    end
                    __O[99] = ____t_result_229
                    if ____t_230(____t_result_229) then
                        ____t_result_231 = math.abs(m.x - q.x - 9) < 14
                    else
                        ____t_result_231 = __O[99]
                    end
                    if ____t_232(____t_result_231) then
                        snap(nil, S, q, t)
                    end
                end
            end
        end
        if __t(o.dashing) then
            for ____, q in __iterar((S.props)) do
                local ____t_238 = __t
                local ____t_result_237
                local ____t_236 = __t
                local ____get_result_235 = __get(PUSH, q.type)
                __O[100] = ____get_result_235
                if ____t_236(____get_result_235) then
                    ____t_result_237 = math.abs(q.x - p.x) < 70
                else
                    ____t_result_237 = __O[100]
                end
                if ____t_238(____t_result_237) then
                    q.vx = f * 300
                end
            end
            if math.random() < 0.5 then
                __call(S.fx, "push", {
                    k = "leaf",
                    x = p.x - f * 20,
                    y = FLOOR - 10,
                    vx = -f * 120,
                    vy = -60,
                    s = 4,
                    col = "#a8c060",
                    life = 1.2,
                    ph = 0
                })
            end
        end
        for ____, q in __iterar((S.props)) do
            if __t(__get(BREAK, q.type)) then
                local ____t_result_239
                if __t(q.vy) then
                    ____t_result_239 = q.vy
                else
                    ____t_result_239 = 0
                end
                q.vy = ____t_result_239 + 900 * dt
                local ____t_result_240
                if __t(q.y) then
                    ____t_result_240 = q.y
                else
                    ____t_result_240 = 0
                end
                q.y = math.min(0, ____t_result_240 + q.vy * dt)
                if __t(__ge(q.y, 0) and __gt(q.vy, 0)) then
                    if __gt(q.vy, 160) then
                        q.vy = __TS__Number(-q.vy) * 0.3
                        dust(
                            nil,
                            S,
                            q.x + q.w / 2,
                            FLOOR,
                            2
                        )
                    else
                        q.vy = 0
                    end
                end
                q.wob = math.max(0, q.wob - dt * 2)
                local ____t_242 = __t
                local ____t_result_241
                if __t(q.broken) then
                    ____t_result_241 = t - q.broken > 28
                else
                    ____t_result_241 = q.broken
                end
                if ____t_242(____t_result_241) then
                    local far = math.abs(q.x - (o.camera + 480)) > 560
                    local ____t_244 = __t
                    local ____t_result_243
                    if __t(far) then
                        ____t_result_243 = far
                    else
                        ____t_result_243 = t - q.broken > 40
                    end
                    if ____t_244(____t_result_243) then
                        q.broken = 0
                        q.hp = q.type == "barrel" and 2 or 1
                        q.alpha = 0
                        if __t(q.segs) then
                            __call(q.segs, "fill", 0)
                        end
                    end
                end
                local ____q_alpha_245 = q.alpha
                if ____q_alpha_245 == nil then
                    ____q_alpha_245 = 1
                end
                q.alpha = math.min(1, ____q_alpha_245 + dt * 2)
            end
            if __t(__get(PUSH, q.type)) then
                local ____t_result_248
                local ____t_247 = __t
                local ____temp_246 = __gt(p.x, q.x - 10) and __lt(
                    p.x,
                    __add(q.x, q.w) + 10
                )
                __O[101] = ____temp_246
                if ____t_247(____temp_246) then
                    ____t_result_248 = __gt(p.y, FLOOR - 40)
                else
                    ____t_result_248 = __O[101]
                end
                local near = ____t_result_248
                local ____t_253 = __t
                local ____t_result_252
                local ____t_251 = __t
                local ____t_result_250
                if __t(near) then
                    local ____t_result_249
                    if __t(p.vx) then
                        ____t_result_249 = p.vx
                    else
                        ____t_result_249 = 0
                    end
                    ____t_result_250 = math.abs(____t_result_249) > 30
                else
                    ____t_result_250 = near
                end
                __O[102] = ____t_result_250
                if ____t_251(____t_result_250) then
                    ____t_result_252 = __TS__MathSign(p.vx) == __TS__MathSign(q.x + q.w / 2 - p.x)
                else
                    ____t_result_252 = __O[102]
                end
                if ____t_253(____t_result_252) then
                    q.vx = p.vx * 1.15
                    local ____t_257 = __t
                    local ____t_result_256
                    local ____t_255 = __t
                    local ____temp_254 = q.type == "cone" and math.abs(p.vx) > 200
                    __O[103] = ____temp_254
                    if ____t_255(____temp_254) then
                        ____t_result_256 = not __t(q.fall)
                    else
                        ____t_result_256 = __O[103]
                    end
                    if ____t_257(____t_result_256) then
                        q.fall = 1
                    end
                end
                local ____t_result_258
                if __t(q.vy) then
                    ____t_result_258 = q.vy
                else
                    ____t_result_258 = 0
                end
                q.vy = ____t_result_258 + 1000 * dt
                local ____t_result_259
                if __t(q.y) then
                    ____t_result_259 = q.y
                else
                    ____t_result_259 = 0
                end
                q.y = math.min(0, ____t_result_259 + q.vy * dt)
                if __t(__ge(q.y, 0) and __gt(q.vy, 0)) then
                    local ____gt_result_260
                    if __gt(q.vy, 140) then
                        ____gt_result_260 = __TS__Number(-q.vy) * (q.type == "ball" and 0.62 or 0.25)
                    else
                        ____gt_result_260 = 0
                    end
                    q.vy = ____gt_result_260
                end
                q.x = q.x + q.vx * dt
                q.vx = q.vx * (__lt(q.y, 0) and 0.9 or (__t(q.type == "ball" or q.type == "tire") and 0.55 or 0.12)) ^ dt
                if math.abs(q.vx) < 4 then
                    q.vx = 0
                end
                q.rot = q.rot + q.vx * dt / (q.w / 2)
                if __t(__lt(q.x, 20) or __gt(q.x, W - 40)) then
                    q.x = math.max(
                        20,
                        math.min(W - 40, q.x)
                    )
                    q.vx = __TS__Number(-q.vx) * 0.5
                end
            end
            if q.type == "door" then
                local near = math.abs(p.x - (q.x + q.w / 2)) < (q.kind == "class" and 90 or 70) and __gt(p.y, FLOOR - 80)
                do
                    local was = q.open
                    q.open = q.open + ((__t(near) and 1 or 0) - q.open) * math.min(1, dt * 6)
                    if __t(__lt(was, 0.05) and __ge(q.open, 0.05)) then
                        sound(nil, "porta")
                    end
                end
            end
            if q.type == "lever" then
                q.flip = math.max(0, q.flip - dt * 3)
            end
            if q.type == "puddle" then
                local ____t_269 = __t
                local ____t_result_268
                local ____t_267 = __t
                local ____t_result_266
                local ____t_264 = __t
                local ____t_result_263
                local ____t_262 = __t
                local ____temp_261 = __gt(p.x, q.x) and __lt(
                    p.x,
                    __add(q.x, q.w)
                )
                __O[104] = ____temp_261
                if ____t_262(____temp_261) then
                    ____t_result_263 = p.ground
                else
                    ____t_result_263 = __O[104]
                end
                __O[105] = ____t_result_263
                if ____t_264(____t_result_263) then
                    local ____t_result_265
                    if __t(p.vx) then
                        ____t_result_265 = p.vx
                    else
                        ____t_result_265 = 0
                    end
                    ____t_result_266 = math.abs(____t_result_265) > 60
                else
                    ____t_result_266 = __O[105]
                end
                __O[106] = ____t_result_266
                if ____t_267(____t_result_266) then
                    ____t_result_268 = math.random() < dt * 8
                else
                    ____t_result_268 = __O[106]
                end
                if ____t_269(____t_result_268) then
                    __call(q.ripples, "push", {x = p.x, t = t})
                    drops(
                        nil,
                        S,
                        p.x,
                        FLOOR,
                        2,
                        0.5
                    )
                end
                local ____t_result_276
                local ____t_275 = __t
                local ____opt_272 = window.Weather
                if ____opt_272 ~= nil then
                    ____opt_272 = ____opt_272.state
                end
                local ____opt_result_274
                if ____opt_272 ~= nil then
                    ____opt_result_274 = ____opt_272(____opt_272).rain
                end
                __O[107] = ____opt_result_274
                if ____t_275(____opt_result_274) then
                    ____t_result_276 = __O[107]
                else
                    ____t_result_276 = 0
                end
                local rain = ____t_result_276
                if __t(__gt(rain, 0.1) and math.random() < rain * dt * 10) then
                    __call(
                        q.ripples,
                        "push",
                        {
                            x = q.x + math.random() * q.w,
                            t = t,
                            small = 1
                        }
                    )
                end
                q.ripples = __call(
                    q.ripples,
                    "filter",
                    function(____, r) return t - r.t < 1.2 end
                )
            end
            if q.type == "trap" then
                local ____t_280 = __t
                local ____t_result_279
                local ____t_278 = __t
                local ____t_result_277
                if __t(q.armed) then
                    ____t_result_277 = math.abs(p.x - q.x - 9) < 12
                else
                    ____t_result_277 = q.armed
                end
                __O[108] = ____t_result_277
                if ____t_278(____t_result_277) then
                    ____t_result_279 = p.ground
                else
                    ____t_result_279 = __O[108]
                end
                if ____t_280(____t_result_279) then
                    snap(nil, S, q, t)
                end
                if __t(not __t(q.armed) and t - q.t > 8) then
                    q.armed = true
                end
            end
            if q.type == "grill" then
                q.burst = math.max(0, q.burst - dt * 1.5)
            end
            if q.type == "grass" then
                local ____t_result_287
                local ____t_286 = __t
                local ____opt_283 = window.Weather
                if ____opt_283 ~= nil then
                    ____opt_283 = ____opt_283.state
                end
                local ____opt_result_285
                if ____opt_283 ~= nil then
                    ____opt_result_285 = ____opt_283(____opt_283).rain
                end
                __O[109] = ____opt_result_285
                if ____t_286(____opt_result_285) then
                    ____t_result_287 = __O[109]
                else
                    ____t_result_287 = 0
                end
                local rain = ____t_result_287
                __call(
                    q.cells,
                    "forEach",
                    function(____, cell, i)
                        if cell.s == 1 then
                            if __gt(rain, 0.35) then
                                cell.s = 2
                                cell.t = t
                            else
                                if __t(t - cell.t > 0.35 and math.random() < dt * 3) then
                                    for ____, j in __iterar((__arrL({i - 1, i + 1}, 2))) do
                                        local ____t_291 = __t
                                        local ____t_result_290
                                        local ____t_289 = __t
                                        local ____get_result_288 = __get(q.cells, j)
                                        __O[110] = ____get_result_288
                                        if ____t_289(____get_result_288) then
                                            ____t_result_290 = __get(q.cells, j).s == 0
                                        else
                                            ____t_result_290 = __O[110]
                                        end
                                        if ____t_291(____t_result_290) then
                                            __get(q.cells, j).s = 1
                                            __get(q.cells, j).t = t
                                        end
                                    end
                                end
                                if t - cell.t > 2.6 then
                                    cell.s = 2
                                    cell.t = t
                                end
                                if math.random() < dt * 6 then
                                    __call(
                                        S.fx,
                                        "push",
                                        {
                                            k = "ember",
                                            x = q.x + i * 8 + 4,
                                            y = FLOOR - 10,
                                            vx = (math.random() - 0.5) * 30,
                                            vy = -60 - math.random() * 80,
                                            s = 2,
                                            col = math.random() > 0.5 and "#ffb030" or "#ff6a20",
                                            life = 0.9
                                        }
                                    )
                                end
                            end
                        elseif __t(cell.s == 2 and t - cell.t > 30) then
                            cell.s = 0
                        end
                    end
                )
            end
        end
        local ____t_result_292
        if __t(S.wet) then
            ____t_result_292 = S.wet
        else
            ____t_result_292 = 0
        end
        S.wet = math.max(0, ____t_result_292 - dt)
        for ____, q in __iterar((S.props)) do
            local ____t_298 = __t
            local ____t_result_297
            local ____t_296 = __t
            local ____t_result_295
            local ____t_294 = __t
            local ____temp_293 = q.type == "lever"
            __O[111] = ____temp_293
            if ____t_294(____temp_293) then
                ____t_result_295 = q.on
            else
                ____t_result_295 = __O[111]
            end
            __O[112] = ____t_result_295
            if ____t_296(____t_result_295) then
                ____t_result_297 = q.effect == "sprinkler"
            else
                ____t_result_297 = __O[112]
            end
            if ____t_298(____t_result_297) then
                S.wet = 2
            end
        end
        local ____opt_301 = window.Weather
        if ____opt_301 ~= nil then
            ____opt_301 = ____opt_301.state
        end
        local ____opt_result_303
        if ____opt_301 ~= nil then
            ____opt_result_303 = ____opt_301(____opt_301)
        end
        local wx = ____opt_result_303
        local ____t_307 = __t
        local ____t_result_306
        local ____t_305 = __t
        local ____t_result_304
        if __t(wx) then
            ____t_result_304 = __gt(wx.flash, 0.95)
        else
            ____t_result_304 = wx
        end
        __O[113] = ____t_result_304
        if ____t_305(____t_result_304) then
            ____t_result_306 = math.random() < 0.3
        else
            ____t_result_306 = __O[113]
        end
        if ____t_307(____t_result_306) then
            igniteNear(
                nil,
                S,
                o.camera + 200 + math.random() * 560,
                60,
                t
            )
        end
        for ____, fx in __iterar((S.fx)) do
            fx.life = fx.life - dt
            fx.vy = fx.vy + (fx.k == "puff" and -10 or (fx.k == "leaf" and 0 or (fx.k == "ember" and -40 or 900))) * dt
            if fx.k == "leaf" then
                fx.vx = fx.vx + math.sin(t * 3 + fx.ph) * 40 * dt
            end
            fx.x = fx.x + fx.vx * dt
            fx.y = fx.y + fx.vy * dt
            local ____t_311 = __t
            local ____t_result_310
            local ____t_309 = __t
            local ____temp_308 = fx.k == "chunk" or fx.k == "drop"
            __O[114] = ____temp_308
            if ____t_309(____temp_308) then
                ____t_result_310 = __gt(fx.y, FLOOR - 2)
            else
                ____t_result_310 = __O[114]
            end
            if ____t_311(____t_result_310) then
                fx.y = FLOOR - 2
                fx.vy = fx.vy * -0.25
                fx.vx = fx.vx * 0.6
                if fx.k == "drop" then
                    fx.life = math.min(fx.life, 0.1)
                end
            end
            if __t(fx.k == "leaf" and __gt(fx.y, FLOOR - 4)) then
                fx.y = FLOOR - 4
                fx.vy = 0
                fx.vx = fx.vx * 0.9
            end
        end
        S.fx = __call(
            __call(
                S.fx,
                "filter",
                function(____, fx) return __gt(fx.life, 0) end
            ),
            "slice",
            -420
        )
        __call(
            S.texts,
            "forEach",
            function(____, x)
                x.life = x.life - dt
                x.y = x.y - 30 * dt
            end
        )
        S.texts = __call(
            S.texts,
            "filter",
            function(____, x) return __gt(x.life, 0) end
        )
        lastT = t
    end
    local function vis(____, o, x, w)
        if w == nil then
            w = 100
        end
        return __gt(x + w, o.camera - 60) and __lt(x, o.camera + 1020)
    end
    local function drawProp(self, c, q, t, o)
        local ____t_result_312
        if __t(q.y) then
            ____t_result_312 = q.y
        else
            ____t_result_312 = 0
        end
        local b = FLOOR + ____t_result_312 - (__t(q.stack) and 28 or 0)
        local x = q.x
        if __t(__get(BREAK, q.type)) then
            if __t(q.broken) then
                if q.type ~= "fence" then
                    R(
                        nil,
                        c,
                        x + 2,
                        FLOOR - 4,
                        q.w - 4,
                        4,
                        "rgba(60,40,20,.35)"
                    )
                    R(
                        nil,
                        c,
                        x + 6,
                        FLOOR - 6,
                        6,
                        2,
                        "#8a6238"
                    )
                    R(
                        nil,
                        c,
                        __add(x, q.w) - 12,
                        FLOOR - 4,
                        8,
                        2,
                        "#5a4028"
                    )
                end
            end
            c:save()
            local ____c_314 = c
            local ____q_alpha_313 = q.alpha
            if ____q_alpha_313 == nil then
                ____q_alpha_313 = 1
            end
            ____c_314.globalAlpha = ____q_alpha_313
            local wob = math.floor(math.sin(t * 30) * q.wob * 2 + 0.5)
            if __t(q.type == "crate" and not __t(q.broken)) then
                R(
                    nil,
                    c,
                    x + wob,
                    b - 28,
                    30,
                    28,
                    "#5a4028"
                )
                R(
                    nil,
                    c,
                    x + 2 + wob,
                    b - 26,
                    26,
                    24,
                    "#a87a48"
                )
                do
                    local k = 0
                    while k < 3 do
                        R(
                            nil,
                            c,
                            x + 2 + wob,
                            b - 26 + k * 8,
                            26,
                            2,
                            "#8a6238"
                        )
                        k = k + 1
                    end
                end
                R(
                    nil,
                    c,
                    x + 2 + wob,
                    b - 26,
                    26,
                    2,
                    "#c49a5c"
                )
                R(
                    nil,
                    c,
                    x + 2 + wob,
                    b - 26,
                    2,
                    24,
                    "#c49a5c"
                )
                do
                    local k = 0
                    while k < 12 do
                        R(
                            nil,
                            c,
                            x + 4 + k * 2 + wob,
                            b - 24 + k * 2,
                            2,
                            2,
                            "#7a5430"
                        )
                        k = k + 1
                    end
                end
            end
            if __t(q.type == "pot" and not __t(q.broken)) then
                R(
                    nil,
                    c,
                    x + 1,
                    b - 14,
                    16,
                    14,
                    "#a85a40"
                )
                R(
                    nil,
                    c,
                    x + 1,
                    b - 14,
                    4,
                    14,
                    "#cf7a5a"
                )
                R(
                    nil,
                    c,
                    x - 1,
                    b - 16,
                    20,
                    4,
                    "#d99572"
                )
                do
                    local k = 0
                    while k < 4 do
                        local sw = math.floor(math.sin(t * 2 + k + x) * 1.5 + 0.5)
                        R(
                            nil,
                            c,
                            x + 3 + k * 4 + sw,
                            b - 26 + __mod(k, 2) * 3,
                            4,
                            10,
                            __t(__mod(k, 2)) and "#4f9a3f" or "#6fb24a"
                        )
                        k = k + 1
                    end
                end
                R(
                    nil,
                    c,
                    x + 7,
                    b - 30,
                    4,
                    4,
                    "#e86a8a"
                )
            end
            if __t(q.type == "hay" and not __t(q.broken)) then
                R(
                    nil,
                    c,
                    x,
                    b - 26,
                    40,
                    26,
                    "#a77c45"
                )
                R(
                    nil,
                    c,
                    x - 2,
                    b - 30,
                    44,
                    6,
                    "#dfbd6c"
                )
                do
                    local k = 0
                    while k < 40 do
                        R(
                            nil,
                            c,
                            x + k,
                            b - 24,
                            2,
                            22,
                            "#c79a56"
                        )
                        k = k + 4
                    end
                end
                R(
                    nil,
                    c,
                    x,
                    b - 18,
                    40,
                    2,
                    "#8a6238"
                )
                R(
                    nil,
                    c,
                    x,
                    b - 8,
                    40,
                    2,
                    "#8a6238"
                )
            end
            if __t(q.type == "melon" and not __t(q.broken)) then
                R(
                    nil,
                    c,
                    x,
                    b - 16,
                    22,
                    16,
                    "#2f7a3a"
                )
                R(
                    nil,
                    c,
                    x + 2,
                    b - 14,
                    18,
                    2,
                    "#5aaa5a"
                )
                do
                    local k = 0
                    while k < 4 do
                        R(
                            nil,
                            c,
                            x + 3 + k * 5,
                            b - 16,
                            2,
                            16,
                            "#1f5a2a"
                        )
                        k = k + 1
                    end
                end
                R(
                    nil,
                    c,
                    x + 10,
                    b - 18,
                    2,
                    2,
                    "#5a4028"
                )
            end
            if __t(q.type == "barrel" and not __t(q.broken)) then
                R(
                    nil,
                    c,
                    x + wob,
                    b - 34,
                    26,
                    34,
                    "#8a6238"
                )
                R(
                    nil,
                    c,
                    x + 2 + wob,
                    b - 34,
                    4,
                    34,
                    "#a87a48"
                )
                R(
                    nil,
                    c,
                    x + 20 + wob,
                    b - 34,
                    4,
                    34,
                    "#5a4028"
                )
                for ____, yy in __iterar((__arrL({6, 16, 28}, 3))) do
                    R(
                        nil,
                        c,
                        x + wob,
                        b - 34 + yy,
                        26,
                        2,
                        "#3a3a3a"
                    )
                end
                R(
                    nil,
                    c,
                    x + 2 + wob,
                    b - 36,
                    22,
                    2,
                    "#5a4028"
                )
            end
            if q.type == "fence" then
                do
                    local k = 0
                    while __lt(
                        k,
                        __len(q.segs)
                    ) do
                        do
                            if __t(__get(q.segs, k)) then
                                do k = k + 1 continue end
                            end
                            local fx = x + k * 18
                            R(
                                nil,
                                c,
                                fx,
                                b - 34,
                                6,
                                34,
                                "#756c48"
                            )
                            R(
                                nil,
                                c,
                                fx,
                                b - 34,
                                2,
                                34,
                                "#a38e5e"
                            )
                            R(
                                nil,
                                c,
                                fx,
                                b - 36,
                                6,
                                2,
                                "#c1ae76"
                            )
                            if __t(k < __len(q.segs) - 1 and not __t(__get(q.segs, k + 1))) then
                                R(
                                    nil,
                                    c,
                                    fx,
                                    b - 26,
                                    18,
                                    4,
                                    "#6c6945"
                                )
                                R(
                                    nil,
                                    c,
                                    fx,
                                    b - 14,
                                    18,
                                    4,
                                    "#6c6945"
                                )
                                R(
                                    nil,
                                    c,
                                    fx,
                                    b - 26,
                                    18,
                                    2,
                                    "#b7ab70"
                                )
                            end
                        end
                        k = k + 1
                    end
                end
            end
            c:restore()
            return
        end
        if __t(__get(PUSH, q.type)) then
            local cx = x + q.w / 2
            local cy = FLOOR + q.y - q.h / 2
            c:save()
            R(
                nil,
                c,
                x + 2,
                FLOOR - 2,
                q.w - 4,
                2,
                "rgba(0,0,0,.25)"
            )
            c:translate(
                math.floor(cx / 2 + 0.5) * 2,
                math.floor(cy / 2 + 0.5) * 2
            )
            if q.type == "tire" then
                c:rotate(math.floor(q.rot * 4 + 0.5) / 4)
                R(
                    nil,
                    c,
                    -13,
                    -13,
                    26,
                    26,
                    "#1e1e22"
                )
                R(
                    nil,
                    c,
                    -7,
                    -7,
                    14,
                    14,
                    "#4a4a4e"
                )
                R(
                    nil,
                    c,
                    -4,
                    -4,
                    8,
                    8,
                    "#2a2a2e"
                )
                do
                    local k = 0
                    while k < 4 do
                        c:rotate(math.pi / 2)
                        R(
                            nil,
                            c,
                            -2,
                            -13,
                            4,
                            3,
                            "#3a3a40"
                        )
                        k = k + 1
                    end
                end
            end
            if q.type == "ball" then
                c:rotate(math.floor(q.rot * 4 + 0.5) / 4)
                R(
                    nil,
                    c,
                    -8,
                    -6,
                    16,
                    12,
                    "#f4f4ea"
                )
                R(
                    nil,
                    c,
                    -6,
                    -8,
                    12,
                    16,
                    "#f4f4ea"
                )
                R(
                    nil,
                    c,
                    -2,
                    -2,
                    4,
                    4,
                    "#2a2a2a"
                )
                R(
                    nil,
                    c,
                    -8,
                    -2,
                    2,
                    4,
                    "#2a2a2a"
                )
                R(
                    nil,
                    c,
                    6,
                    -2,
                    2,
                    4,
                    "#2a2a2a"
                )
                R(
                    nil,
                    c,
                    -2,
                    -8,
                    4,
                    2,
                    "#2a2a2a"
                )
            end
            if q.type == "bucket" then
                local ____c_316 = c
                local ____c_rotate_317 = c.rotate
                local ____t_result_315
                if __t(q.vx) then
                    ____t_result_315 = math.floor(q.rot * 4 + 0.5) / 4
                else
                    ____t_result_315 = 0
                end
                ____c_rotate_317(____c_316, ____t_result_315)
                R(
                    nil,
                    c,
                    -9,
                    -10,
                    18,
                    20,
                    "#3a7ab8"
                )
                R(
                    nil,
                    c,
                    -9,
                    -10,
                    4,
                    20,
                    "#5a9ad8"
                )
                R(
                    nil,
                    c,
                    -10,
                    -12,
                    20,
                    3,
                    "#2a5a8a"
                )
                R(
                    nil,
                    c,
                    -8,
                    -16,
                    16,
                    2,
                    "#8a96a0"
                )
            end
            if q.type == "trash" then
                R(
                    nil,
                    c,
                    -11,
                    -15,
                    22,
                    30,
                    "#3f8a52"
                )
                R(
                    nil,
                    c,
                    -11,
                    -15,
                    4,
                    30,
                    "#57a86a"
                )
                R(
                    nil,
                    c,
                    -12,
                    -17,
                    24,
                    4,
                    "#2f6a3e"
                )
                R(
                    nil,
                    c,
                    -4,
                    -6,
                    8,
                    8,
                    "#e9f2e0"
                )
            end
            if q.type == "cone" then
                if __t(q.fall) then
                    local ____c_320 = c
                    local ____c_rotate_321 = c.rotate
                    local ____temp_319 = math.pi / 2
                    local ____t_result_318
                    if __t(q.vx) then
                        ____t_result_318 = q.vx
                    else
                        ____t_result_318 = 1
                    end
                    ____c_rotate_321(
                        ____c_320,
                        ____temp_319 * __TS__MathSign(____t_result_318)
                    )
                end
                R(
                    nil,
                    c,
                    -7,
                    6,
                    14,
                    3,
                    "#b05c18"
                )
                R(
                    nil,
                    c,
                    -5,
                    -4,
                    10,
                    10,
                    "#e8842a"
                )
                R(
                    nil,
                    c,
                    -3,
                    -9,
                    6,
                    6,
                    "#e8842a"
                )
                R(
                    nil,
                    c,
                    -5,
                    0,
                    10,
                    2,
                    "#ffffff"
                )
            end
            c:restore()
            return
        end
        if q.type == "door" then
            local op = math.max(
                0,
                math.min(1, q.open)
            )
            if op < 0.02 then
                return
            end
            local top = FLOOR - q.h - (q.kind == "house" and 4 or 0)
            local w = q.w
            R(
                nil,
                c,
                x,
                top,
                w,
                q.h,
                "#1a1410"
            )
            local ____t_result_328
            local ____t_327 = __t
            local ____opt_324 = window.DayTime
            if ____opt_324 ~= nil then
                ____opt_324 = ____opt_324.state
            end
            local ____opt_result_326
            if ____opt_324 ~= nil then
                ____opt_result_326 = ____opt_324(____opt_324).night
            end
            __O[115] = ____opt_result_326
            if ____t_327(____opt_result_326) then
                ____t_result_328 = __O[115]
            else
                ____t_result_328 = 0
            end
            local night = ____t_result_328
            if __gt(night, 0.1) then
                R(
                    nil,
                    c,
                    x + 2,
                    top + 2,
                    w - 4,
                    q.h - 4,
                    ("rgba(255,200,120," .. tostring(0.35 * night)) .. ")"
                )
            end
            R(
                nil,
                c,
                x + 4,
                FLOOR - 12,
                w - 8,
                4,
                "rgba(255,220,160,.12)"
            )
            local pw = math.floor(w * (1 - op * 0.82) + 0.5)
            local col = q.kind == "class" and "#7f9ba1" or (q.kind == "fav" and "#647b6f" or (q.kind == "main" and "#526661" or "#886641"))
            R(
                nil,
                c,
                x,
                top,
                pw,
                q.h,
                col
            )
            R(
                nil,
                c,
                x,
                top,
                2,
                q.h,
                "rgba(255,255,255,.2)"
            )
            R(
                nil,
                c,
                x + pw - 2,
                top,
                2,
                q.h,
                "rgba(0,0,0,.3)"
            )
            R(
                nil,
                c,
                x + pw - 6,
                top + q.h * 0.5,
                2,
                4,
                "#e4ba73"
            )
            return
        end
        if q.type == "lever" then
            R(
                nil,
                c,
                x - 2,
                FLOOR - 30,
                18,
                30,
                "#4a4a52"
            )
            R(
                nil,
                c,
                x,
                FLOOR - 28,
                14,
                26,
                "#6a6a74"
            )
            R(
                nil,
                c,
                x,
                FLOOR - 28,
                14,
                2,
                "#9a9aa8"
            )
            R(
                nil,
                c,
                x + 2,
                FLOOR - 24,
                10,
                4,
                __t(q.on) and "#6ad86a" or "#d83a3a"
            )
            local ang = (__t(q.on) and -0.6 or 0.6) * (1 - q.flip * 0.3)
            c:save()
            c:translate(x + 7, FLOOR - 12)
            c:rotate(ang)
            R(
                nil,
                c,
                -2,
                -20,
                4,
                20,
                "#2a2a2e"
            )
            R(
                nil,
                c,
                -4,
                -24,
                8,
                6,
                "#e04a3a"
            )
            c:restore()
            return
        end
        if q.type == "puddle" then
            local y = FLOOR + 6
            R(
                nil,
                c,
                x,
                y,
                q.w,
                6,
                "rgba(120,170,200,.45)"
            )
            R(
                nil,
                c,
                x + 6,
                y - 2,
                q.w - 12,
                2,
                "rgba(120,170,200,.45)"
            )
            R(
                nil,
                c,
                x + 6,
                y + 6,
                q.w - 12,
                2,
                "rgba(120,170,200,.35)"
            )
            R(
                nil,
                c,
                x + 10,
                y,
                q.w * 0.4,
                2,
                "rgba(230,245,255,.5)"
            )
            for ____, r in __iterar((q.ripples)) do
                local u = (t - r.t) / 1.2
                local rr = (__t(r.small) and 10 or 24) * u + 2
                c.fillStyle = ("rgba(230,245,255," .. tostring((1 - u) * 0.8)) .. ")"
                do
                    local a = 0
                    while a < 16 do
                        local an = a / 16 * math.pi * 2
                        local px = r.x + math.cos(an) * rr
                        local py = y + 3 + math.sin(an) * rr * 0.25
                        if __t(__gt(px, x) and __lt(
                            px,
                            __add(x, q.w)
                        )) then
                            c:fillRect(
                                math.floor(px / 2 + 0.5) * 2,
                                math.floor(py / 2 + 0.5) * 2,
                                2,
                                2
                            )
                        end
                        a = a + 1
                    end
                end
            end
            return
        end
        if q.type == "trap" then
            R(
                nil,
                c,
                x,
                FLOOR - 4,
                18,
                4,
                "#8a6238"
            )
            R(
                nil,
                c,
                x,
                FLOOR - 4,
                18,
                2,
                "#a87a48"
            )
            if __t(q.armed) then
                R(
                    nil,
                    c,
                    x + 2,
                    FLOOR - 8,
                    2,
                    4,
                    "#a8a8b0"
                )
                R(
                    nil,
                    c,
                    x + 2,
                    FLOOR - 8,
                    14,
                    2,
                    "#a8a8b0"
                )
                R(
                    nil,
                    c,
                    x + 12,
                    FLOOR - 8,
                    4,
                    4,
                    "#f2d24a"
                )
            else
                R(
                    nil,
                    c,
                    x + 2,
                    FLOOR - 6,
                    14,
                    2,
                    "#a8a8b0"
                )
            end
            return
        end
        if q.type == "grill" then
            R(
                nil,
                c,
                x,
                FLOOR - 22,
                30,
                4,
                "#2a2a2e"
            )
            R(
                nil,
                c,
                x + 2,
                FLOOR - 18,
                26,
                6,
                "#3a3a40"
            )
            R(
                nil,
                c,
                x + 4,
                FLOOR - 12,
                2,
                12,
                "#2a2a2e"
            )
            R(
                nil,
                c,
                x + 24,
                FLOOR - 12,
                2,
                12,
                "#2a2a2e"
            )
            do
                local k = 0
                while k < 6 do
                    R(
                        nil,
                        c,
                        x + 4 + k * 4,
                        FLOOR - 24,
                        2,
                        2,
                        math.sin(t * 9 + k) > 0 and "#ff8a30" or "#ffd060"
                    )
                    k = k + 1
                end
            end
            do
                local k = 0
                while k < 4 do
                    local u = __mod(t * 0.7 + k / 4, 1)
                    c.fillStyle = ("rgba(200,200,200," .. tostring((1 - u) * 0.45)) .. ")"
                    c:fillRect(
                        math.floor((x + 10 + math.sin(t + k) * 4 * u) / 2 + 0.5) * 2,
                        math.floor((FLOOR - 28 - u * 50) / 2 + 0.5) * 2,
                        4 + u * 6,
                        4 + u * 4
                    )
                    k = k + 1
                end
            end
            R(
                nil,
                c,
                x + 6,
                FLOOR - 26,
                8,
                2,
                "#c94f45"
            )
            R(
                nil,
                c,
                x + 16,
                FLOOR - 26,
                8,
                2,
                "#e8c070"
            )
            return
        end
        if q.type == "grass" then
            __call(
                q.cells,
                "forEach",
                function(____, cell, i)
                    local gx = x + i * 8
                    local sw = math.floor(math.sin(t * 2.5 + gx * 0.05) * 2 + 0.5)
                    if cell.s == 0 then
                        R(
                            nil,
                            c,
                            gx + sw,
                            FLOOR - 12,
                            2,
                            12,
                            "#c8b060"
                        )
                        R(
                            nil,
                            c,
                            gx + 4,
                            FLOOR - 9,
                            2,
                            9,
                            "#a89048"
                        )
                        R(
                            nil,
                            c,
                            gx + 2 + sw,
                            FLOOR - 15,
                            2,
                            4,
                            "#e0c878"
                        )
                    elseif cell.s == 2 then
                        R(
                            nil,
                            c,
                            gx,
                            FLOOR - 3,
                            6,
                            3,
                            "#2a2420"
                        )
                        if __mod(
                            i + math.floor(t),
                            5
                        ) == 0 then
                            R(
                                nil,
                                c,
                                gx + 2,
                                FLOOR - 5,
                                2,
                                2,
                                "#5a5048"
                            )
                        end
                    else
                        local fh = 22 + math.sin(t * 15 + i * 1.7) * 8 + math.sin(t * 23 + i) * 4
                        c:save()
                        c.globalAlpha = 0.35
                        R(
                            nil,
                            c,
                            gx - 6,
                            FLOOR - fh - 16,
                            20,
                            fh + 16,
                            "#ff9a30"
                        )
                        c:restore()
                        R(
                            nil,
                            c,
                            gx - 1,
                            FLOOR - fh,
                            10,
                            fh,
                            "#e8401a"
                        )
                        R(
                            nil,
                            c,
                            gx + 1,
                            FLOOR - fh * 0.8,
                            6,
                            fh * 0.8,
                            "#ff8a20"
                        )
                        R(
                            nil,
                            c,
                            gx + 2,
                            FLOOR - fh * 0.5,
                            4,
                            fh * 0.5,
                            "#ffd040"
                        )
                        R(
                            nil,
                            c,
                            gx + 3,
                            FLOOR - fh * 0.25,
                            2,
                            fh * 0.25,
                            "#fff6c0"
                        )
                        if __mod(
                            i + math.floor(t * 6),
                            3
                        ) == 0 then
                            R(
                                nil,
                                c,
                                gx + 2,
                                FLOOR - fh - 6,
                                2,
                                4,
                                "#ffb030"
                            )
                        end
                        local u = __mod(t * 0.8 + i * 0.37, 1)
                        c.fillStyle = ("rgba(70,64,60," .. tostring((1 - u) * 0.45)) .. ")"
                        c:fillRect(
                            math.floor((gx + math.sin(__add(t, i)) * 8 * u) / 2 + 0.5) * 2,
                            math.floor((FLOOR - fh - 10 - u * 70) / 2 + 0.5) * 2,
                            6 + u * 10,
                            6 + u * 8
                        )
                    end
                end
            )
            return
        end
    end
    local function drawEffects(self, c, S, t, o)
        for ____, q in __iterar((S.props)) do
            do
                local ____t_332 = __t
                local ____t_result_331
                local ____t_330 = __t
                local ____temp_329 = q.type == "lever"
                __O[116] = ____temp_329
                if ____t_330(____temp_329) then
                    ____t_result_331 = q.on
                else
                    ____t_result_331 = __O[116]
                end
                if ____t_332(____t_result_331) then
                    local x = q.x
                    if not __t(vis(nil, o, x - 300, 700)) then
                        continue
                    end
                    if q.effect == "sprinkler" then
                        local sx = x + 240
                        R(
                            nil,
                            c,
                            sx - 4,
                            FLOOR - 8,
                            8,
                            8,
                            "#5a6a72"
                        )
                        R(
                            nil,
                            c,
                            sx - 2,
                            FLOOR - 18,
                            4,
                            10,
                            "#5a6a72"
                        )
                        do
                            local j = 0
                            while j < 90 do
                                local u = __mod(t * 1.1 + j / 90, 1)
                                local side = __t(__mod(j, 2)) and 1 or -1
                                local px = sx + side * u * (130 + __mod(j, 5) * 26) + math.sin(t * 2) * 24 * u
                                local py = FLOOR - 18 - math.sin(u * math.pi) * (90 + __mod(j, 3) * 20)
                                R(
                                    nil,
                                    c,
                                    px,
                                    py,
                                    __t(__mod(j, 4)) and 2 or 4,
                                    4,
                                    __t(__mod(j, 3)) and "#7ac4ee" or "#e8f8ff"
                                )
                                j = j + 1
                            end
                        end
                        do
                            local j = 0
                            while j < 8 do
                                local u = __mod(t * 1.5 + j / 8, 1)
                                local px = sx + (__t(__mod(j, 2)) and 1 or -1) * (100 + j * 12)
                                c.fillStyle = ("rgba(230,245,255," .. tostring((1 - u) * 0.7)) .. ")"
                                c:fillRect(
                                    math.floor((px - u * 10) / 2 + 0.5) * 2,
                                    FLOOR - 2,
                                    math.floor((4 + u * 20) / 2 + 0.5) * 2,
                                    2
                                )
                                j = j + 1
                            end
                        end
                        local ____opt_335 = window.DayTime
                        if ____opt_335 ~= nil then
                            ____opt_335 = ____opt_335.state
                        end
                        local ____opt_result_337
                        if ____opt_335 ~= nil then
                            ____opt_result_337 = ____opt_335(____opt_335)
                        end
                        local sun = ____opt_result_337
                        local ____t_349 = __t
                        local ____t_result_348
                        local ____t_339 = __t
                        local ____t_result_338
                        if __t(sun) then
                            ____t_result_338 = sun.sunT ~= nil
                        else
                            ____t_result_338 = sun
                        end
                        __O[118] = ____t_result_338
                        if ____t_339(____t_result_338) then
                            local ____lt_347 = __lt
                            local ____t_result_346
                            local ____t_345 = __t
                            local ____opt_342 = window.Weather
                            if ____opt_342 ~= nil then
                                ____opt_342 = ____opt_342.state
                            end
                            local ____opt_result_344
                            if ____opt_342 ~= nil then
                                ____opt_result_344 = ____opt_342(____opt_342).rain
                            end
                            __O[117] = ____opt_result_344
                            if ____t_345(____opt_result_344) then
                                ____t_result_346 = __O[117]
                            else
                                ____t_result_346 = 0
                            end
                            ____t_result_348 = ____lt_347(____t_result_346, 0.3)
                        else
                            ____t_result_348 = __O[118]
                        end
                        if ____t_349(____t_result_348) then
                            c:save()
                            c.globalAlpha = 0.28
                            __call(
                                __arrL({
                                    "#ff4040",
                                    "#ffa030",
                                    "#ffe040",
                                    "#40d040",
                                    "#4080ff",
                                    "#9040e0"
                                }, 6),
                                "forEach",
                                function(____, col, k)
                                    do
                                        local a = 0
                                        while a <= 30 do
                                            local an = math.pi + a / 30 * math.pi
                                            local rr = 110 - k * 4
                                            R(
                                                nil,
                                                c,
                                                sx + math.cos(an) * rr,
                                                FLOOR - 20 + math.sin(an) * rr * 0.7,
                                                2,
                                                2,
                                                col
                                            )
                                            a = a + 1
                                        end
                                    end
                                end
                            )
                            c:restore()
                        end
                    end
                    if q.effect == "fountain" then
                        local fx = 1050
                        local h = 150 + math.sin(t * 3) * 20
                        do
                            local k = 0
                            while k < h do
                                local w = 6 + math.sin(k * 0.2 + t * 8) * 2
                                R(
                                    nil,
                                    c,
                                    fx - w / 2,
                                    FLOOR - 140 - k,
                                    w,
                                    4,
                                    __t(__mod(k, 8)) and "#bfe6f6" or "#ffffff"
                                )
                                k = k + 4
                            end
                        end
                        do
                            local j = 0
                            while j < 30 do
                                local u = __mod(t * 0.9 + j / 30, 1)
                                local side = __t(__mod(j, 2)) and 1 or -1
                                local px = fx + side * u * 80
                                local py = FLOOR - 140 - h + u * u * (h + 40) - math.sin(u * math.pi) * 30
                                R(
                                    nil,
                                    c,
                                    px,
                                    py,
                                    2,
                                    4,
                                    "#dff4ff"
                                )
                                j = j + 1
                            end
                        end
                    end
                    if q.effect == "party" then
                        local y0 = 230
                        do
                            local k = -10
                            while k < 40 do
                                local px = x - 300 + k * 24
                                local py = y0 + math.sin(k * 0.5) * 6
                                local on = __mod(
                                    k + math.floor(t * 8),
                                    3
                                ) == 0
                                R(
                                    nil,
                                    c,
                                    px,
                                    py - 2,
                                    24,
                                    2,
                                    "#2a2220"
                                )
                                local ____c_351 = c
                                local ____temp_352 = px + 10
                                local ____t_result_350
                                if __t(on) then
                                    ____t_result_350 = __get(
                                        __arrL({"#ff4a8a", "#4ad8ff", "#ffe040", "#6aff6a"}, 4),
                                        __mod(k + 400, 4)
                                    )
                                else
                                    ____t_result_350 = "#5a4a40"
                                end
                                R(
                                    nil,
                                    ____c_351,
                                    ____temp_352,
                                    py,
                                    4,
                                    6,
                                    ____t_result_350
                                )
                                k = k + 1
                            end
                        end
                        do
                            local j = 0
                            while j < 6 do
                                local u = __mod(t * 0.4 + j / 6, 1)
                                R(
                                    nil,
                                    c,
                                    x + 40 + j * 30 + math.sin(t * 2 + j) * 10,
                                    FLOOR - 60 - u * 120,
                                    4,
                                    6,
                                    "#fff0c4"
                                )
                                R(
                                    nil,
                                    c,
                                    x + 44 + j * 30 + math.sin(t * 2 + j) * 10,
                                    FLOOR - 66 - u * 120,
                                    2,
                                    8,
                                    "#fff0c4"
                                )
                                j = j + 1
                            end
                        end
                    end
                    if q.effect == "bell" then
                        local bx = x + 40
                        local by = 250
                        R(
                            nil,
                            c,
                            bx - 10,
                            by - 10,
                            20,
                            20,
                            "#c94f45"
                        )
                        R(
                            nil,
                            c,
                            bx - 6,
                            by - 6,
                            12,
                            12,
                            "#e8c84a"
                        )
                        local sh = math.floor(math.sin(t * 50) * 2 + 0.5)
                        R(
                            nil,
                            c,
                            bx - 2 + sh,
                            by - 2,
                            4,
                            4,
                            "#3a2a20"
                        )
                        do
                            local k = 0
                            while k < 3 do
                                local u = __mod(t * 1.5 + k / 3, 1)
                                local rr = 14 + u * 60
                                c.fillStyle = ("rgba(255,240,180," .. tostring((1 - u) * 0.7)) .. ")"
                                do
                                    local a = 0
                                    while a < 20 do
                                        local an = a / 20 * math.pi * 2
                                        c:fillRect(
                                            math.floor((bx + math.cos(an) * rr) / 2 + 0.5) * 2,
                                            math.floor((by + math.sin(an) * rr * 0.6) / 2 + 0.5) * 2,
                                            2,
                                            2
                                        )
                                        a = a + 1
                                    end
                                end
                                k = k + 1
                            end
                        end
                    end
                    if q.effect == "flood" then
                        c:save()
                        c.globalCompositeOperation = "lighter"
                        for ____, k in __iterar((__arrL({-1, 1}, 2))) do
                            local ox = x + k * 260
                            local ang = math.sin(t * 0.8 + k) * 0.4
                            local g = c:createLinearGradient(0, 120, 0, FLOOR)
                            g:addColorStop(0, "rgba(255,250,220,.35)")
                            g:addColorStop(1, "rgba(255,250,220,.02)")
                            c.fillStyle = g
                            c:beginPath()
                            c:moveTo(ox - 8, 120)
                            c:lineTo(ox + 8, 120)
                            c:lineTo(
                                ox + math.sin(ang) * 300 + 70,
                                FLOOR
                            )
                            c:lineTo(
                                ox + math.sin(ang) * 300 - 70,
                                FLOOR
                            )
                            c:closePath()
                            __call(c, "fill")
                        end
                        c:restore()
                    end
                end
            end
        end
        for ____, fx in __iterar((S.fx)) do
            do
                if not __t(vis(nil, o, fx.x, 10)) then
                    continue
                end
                local a = math.max(
                    0,
                    math.min(1, fx.life * 2)
                )
                c.globalAlpha = a
                if fx.k == "puff" then
                    local s = fx.s * (1.6 - fx.life)
                    R(
                        nil,
                        c,
                        fx.x - s / 2,
                        fx.y - s / 2,
                        s,
                        s,
                        fx.col
                    )
                elseif fx.k == "leaf" then
                    R(
                        nil,
                        c,
                        fx.x,
                        fx.y,
                        4,
                        2,
                        fx.col
                    )
                    R(
                        nil,
                        c,
                        fx.x + 2,
                        fx.y - 2,
                        2,
                        2,
                        fx.col
                    )
                else
                    R(
                        nil,
                        c,
                        fx.x,
                        fx.y,
                        fx.s,
                        fx.s,
                        fx.col
                    )
                end
            end
        end
        c.globalAlpha = 1
        c:save()
        c.font = "16px Pixel, monospace"
        c.textAlign = "center"
        c.textBaseline = "middle"
        for ____, x in __iterar((S.texts)) do
            c.globalAlpha = math.min(1, x.life * 2)
            c.fillStyle = "#2a1a10"
            c:fillText(x.txt, x.x + 2, x.y + 2)
            c.fillStyle = x.col
            c:fillText(x.txt, x.x, x.y)
        end
        c:restore()
    end
    local function drawPlatformRigs(self, c, S, o)
        for ____, m in __iterar((S.plat)) do
            do
                local ____t_355 = __t
                local ____o_354 = o
                local ____m_x_353 = m.x
                if ____m_x_353 == nil then
                    ____m_x_353 = m.x0
                end
                if not ____t_355(vis(nil, ____o_354, ____m_x_353 - 40, 300)) then
                    continue
                end
                if m.kind == "lift" then
                    local cx = m.x + 35
                    do
                        local y = 0
                        while __lt(y, m.cy) do
                            R(
                                nil,
                                c,
                                cx - 1,
                                y,
                                2,
                                4,
                                "#5a5a62"
                            )
                            y = y + 6
                        end
                    end
                    R(
                        nil,
                        c,
                        cx - 10,
                        m.cy - 10,
                        20,
                        8,
                        "#3a3a42"
                    )
                    R(
                        nil,
                        c,
                        m.x - 4,
                        m.cy + 12,
                        2,
                        FLOOR - m.cy - 12,
                        "rgba(90,90,98,.35)"
                    )
                    R(
                        nil,
                        c,
                        m.x + 72,
                        m.cy + 12,
                        2,
                        FLOOR - m.cy - 12,
                        "rgba(90,90,98,.35)"
                    )
                else
                    R(
                        nil,
                        c,
                        m.x0,
                        m.y - 8,
                        m.x1 - m.x0 + 70,
                        2,
                        "#5a5a62"
                    )
                    do
                        local x = m.x0
                        while __lt(x, m.x1 + 70) do
                            R(
                                nil,
                                c,
                                x,
                                m.y - 10,
                                2,
                                4,
                                "#3a3a42"
                            )
                            x = x + 30
                        end
                    end
                    local cx = m.cx + 35
                    R(
                        nil,
                        c,
                        cx - 1,
                        m.y - 8,
                        2,
                        8,
                        "#5a5a62"
                    )
                end
            end
        end
    end
    local function drawBack(self, c, o)
        local S = getSet(nil, o)
        if not __t(S) then
            return
        end
        drawPlatformRigs(nil, c, S, o)
        if __t(lite(nil)) then
            return
        end
        local ____t_result_358
        local ____t_357 = __t
        local ____TS__Number_result_356 = __TS__Number(o.time)
        __O[119] = ____TS__Number_result_356
        if ____t_357(____TS__Number_result_356) then
            ____t_result_358 = __O[119]
        else
            ____t_result_358 = 0
        end
        local t = ____t_result_358
        for ____, q in __iterar((S.props)) do
            local ____t_374 = __t
            local ____t_result_373
            local ____t_363 = __t
            local ____o_360 = o
            local ____q_x_361 = q.x
            local ____t_result_359
            if __t(q.w) then
                ____t_result_359 = q.w
            else
                ____t_result_359 = 60
            end
            local ____vis_result_362 = vis(nil, ____o_360, ____q_x_361, ____t_result_359)
            __O[124] = ____vis_result_362
            if ____t_363(____vis_result_362) then
                local ____t_result_372
                local ____t_371 = __t
                local ____t_result_370
                local ____t_369 = __t
                local ____t_result_368
                local ____t_367 = __t
                local ____t_result_366
                local ____t_365 = __t
                local ____temp_364 = q.type == "door" or q.type == "puddle"
                __O[120] = ____temp_364
                if ____t_365(____temp_364) then
                    ____t_result_366 = __O[120]
                else
                    ____t_result_366 = q.type == "grass"
                end
                __O[121] = ____t_result_366
                if ____t_367(____t_result_366) then
                    ____t_result_368 = __O[121]
                else
                    ____t_result_368 = q.type == "lever"
                end
                __O[122] = ____t_result_368
                if ____t_369(____t_result_368) then
                    ____t_result_370 = __O[122]
                else
                    ____t_result_370 = q.type == "grill"
                end
                __O[123] = ____t_result_370
                if ____t_371(____t_result_370) then
                    ____t_result_372 = __O[123]
                else
                    ____t_result_372 = q.type == "trap"
                end
                ____t_result_373 = ____t_result_372
            else
                ____t_result_373 = __O[124]
            end
            if ____t_374(____t_result_373) then
                drawProp(
                    nil,
                    c,
                    q,
                    t,
                    o
                )
            end
        end
        for ____, q in __iterar((S.props)) do
            local ____t_384 = __t
            local ____t_result_383
            local ____t_379 = __t
            local ____o_376 = o
            local ____q_x_377 = q.x
            local ____t_result_375
            if __t(q.w) then
                ____t_result_375 = q.w
            else
                ____t_result_375 = 60
            end
            local ____vis_result_378 = vis(nil, ____o_376, ____q_x_377, ____t_result_375)
            __O[126] = ____vis_result_378
            if ____t_379(____vis_result_378) then
                local ____t_result_382
                local ____t_381 = __t
                local ____get_result_380 = __get(BREAK, q.type)
                __O[125] = ____get_result_380
                if ____t_381(____get_result_380) then
                    ____t_result_382 = __O[125]
                else
                    ____t_result_382 = __get(PUSH, q.type)
                end
                ____t_result_383 = ____t_result_382
            else
                ____t_result_383 = __O[126]
            end
            if ____t_384(____t_result_383) then
                drawProp(
                    nil,
                    c,
                    q,
                    t,
                    o
                )
            end
        end
    end
    local function drawFront(self, c, o)
        local S = getSet(nil, o)
        local ____t_388 = __t
        local ____t_result_387
        local ____t_386 = __t
        local ____temp_385 = not __t(S)
        __O[127] = ____temp_385
        if ____t_386(____temp_385) then
            ____t_result_387 = __O[127]
        else
            ____t_result_387 = lite(nil)
        end
        if ____t_388(____t_result_387) then
            return
        end
        local ____drawEffects_393 = drawEffects
        local ____c_392 = c
        local ____t_result_391
        local ____t_390 = __t
        local ____TS__Number_result_389 = __TS__Number(o.time)
        __O[128] = ____TS__Number_result_389
        if ____t_390(____TS__Number_result_389) then
            ____t_result_391 = __O[128]
        else
            ____t_result_391 = 0
        end
        ____drawEffects_393(
            nil,
            ____c_392,
            S,
            ____t_result_391,
            o
        )
    end
    local function platforms(self, o)
        local S = getSet(nil, o)
        if not __t(S) then
            return __arrL({}, 0)
        end
        return __call(
            S.plat,
            "map",
            function(____, m)
                local ____arrL_396 = __arrL
                local ____array_395 = __TS__SparseArrayNew(
                    math.floor(m.cx + 0.5),
                    math.floor(m.cy + 0.5),
                    m.w
                )
                local ____t_result_394
                if __t(m.dx) then
                    ____t_result_394 = m.dx
                else
                    ____t_result_394 = 0
                end
                __TS__SparseArrayPush(____array_395, ____t_result_394)
                return ____arrL_396(
                    {__TS__SparseArraySpread(____array_395)},
                    4
                )
            end
        )
    end
    local function addScene(self, scene, list)
        scene = __TS__Number(scene)
        if __t(not __ge(scene, 12) or not __isArray(list)) then
            return false
        end
        __set(SPEC, scene, list)
        if not __t(__call(OUT, "includes", scene)) then
            __call(OUT, "push", scene)
        end
        __del(
            sets,
            __add("scene:", scene)
        )
        return true
    end
    window.Interact = __ord(
        {
            addScene = addScene,
            update = function(____, dt, o)
                do
                    local function ____catch(e)
                        window.__interactError = e
                    end
                    local ____try, ____hasReturned = pcall(function()
                        local ____update_399 = update
                        local ____dt_398 = dt
                        local ____t_result_397
                        if __t(o) then
                            ____t_result_397 = o
                        else
                            ____t_result_397 = {}
                        end
                        ____update_399(nil, ____dt_398, ____t_result_397)
                    end)
                    if not ____try then
                        ____catch(____hasReturned)
                    end
                end
            end,
            drawBack = function(____, c, o)
                do
                    local function ____catch(e)
                        window.__interactError = e
                    end
                    local ____try, ____hasReturned = pcall(function()
                        local ____drawBack_402 = drawBack
                        local ____c_401 = c
                        local ____t_result_400
                        if __t(o) then
                            ____t_result_400 = o
                        else
                            ____t_result_400 = {}
                        end
                        ____drawBack_402(nil, ____c_401, ____t_result_400)
                    end)
                    if not ____try then
                        ____catch(____hasReturned)
                    end
                end
            end,
            drawFront = function(____, c, o)
                do
                    local function ____catch(e)
                        window.__interactError = e
                    end
                    local ____try, ____hasReturned = pcall(function()
                        local ____drawFront_405 = drawFront
                        local ____c_404 = c
                        local ____t_result_403
                        if __t(o) then
                            ____t_result_403 = o
                        else
                            ____t_result_403 = {}
                        end
                        ____drawFront_405(nil, ____c_404, ____t_result_403)
                    end)
                    if not ____try then
                        ____catch(____hasReturned)
                    end
                end
            end,
            platforms = function(____, o)
                do
                    local function ____catch(e)
                        return true, __arrL({}, 0)
                    end
                    local ____try, ____hasReturned, ____returnValue = pcall(function()
                        local ____platforms_407 = platforms
                        local ____t_result_406
                        if __t(o) then
                            ____t_result_406 = o
                        else
                            ____t_result_406 = {}
                        end
                        return true, ____platforms_407(nil, ____t_result_406)
                    end)
                    if not ____try then
                        ____hasReturned, ____returnValue = ____catch(____hasReturned)
                    end
                    if ____hasReturned then
                        return ____returnValue
                    end
                end
            end,
            shock = function(____, x, power)
                if __t(cur) then
                    local ____shock_411 = shock
                    local ____cur_409 = cur
                    local ____x_410 = x
                    local ____t_result_408
                    if __t(power) then
                        ____t_result_408 = power
                    else
                        ____t_result_408 = 1
                    end
                    ____shock_411(
                        nil,
                        ____cur_409,
                        ____x_410,
                        ____t_result_408,
                        lastT
                    )
                end
            end,
            ignite = function(____, x)
                if __t(cur) then
                    igniteNear(
                        nil,
                        cur,
                        x,
                        12,
                        lastT
                    )
                end
            end,
            debug = function() return cur end
        },
        "addScene,update,drawBack,drawFront,platforms,shock,ignite,debug"
    )
end)(nil)
return ____exports
