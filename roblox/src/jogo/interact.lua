--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __le, __gt, __ge, __getq, __mod, __ord, __arrL, __iterar, __t, __get, __set = __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__getq, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set
local __del, __len, __call, __add, __isArray, __arrayFrom, __bor = __JSR.__del, __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__isArray, __JSR.__arrayFrom, __JSR.__bor
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__MathSign = ____lualib.__TS__MathSign
local WeakSet = ____lualib.WeakSet
local __TS__New = ____lualib.__TS__New
local WeakMap = ____lualib.WeakMap
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
                local ____opt_49 = window.DarocaAudio
                if ____opt_49 ~= nil then
                    ____opt_49 = ____opt_49.play
                end
                if ____opt_49 ~= nil then
                    ____opt_49(____opt_49, name)
                end
            end)
        end
    end
    function say(self, S, x, y, txt, col)
        if col == nil then
            col = "#fff0c4"
        end
        local ____t_56 = __t
        local ____opt_53 = window.Campanha2
        if ____opt_53 ~= nil then
            ____opt_53 = ____opt_53.aberto
        end
        local ____opt_result_55
        if ____opt_53 ~= nil then
            ____opt_result_55 = ____opt_53(____opt_53)
        end
        if not ____t_56(____opt_result_55) then
            __call(S.texts, "push", {
                x = x,
                y = y,
                txt = txt,
                col = col,
                life = 1.1
            })
        end
        local ____t_58 = __t
        local ____get_result_57 = __get(SOUND, txt)
        __O[65] = ____get_result_57
        local snd = if ____t_58(____get_result_57) then __O[65] else if __t(__call(
            tostring(txt),
            "startsWith",
            "LIGOU"
        )) then "alavanca" else nil
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
            local ____t_67 = __t
            local ____t_66 = __t
            local ____temp_65 = p.type == "grass" and __gt(x, p.x - r)
            __O[67] = ____temp_65
            if ____t_67(if ____t_66(____temp_65) then __lt(
                x,
                __add(
                    __add(p.x, p.w),
                    r
                )
            ) else __O[67]) then
                local ____gt_74 = __gt
                local ____t_73 = __t
                local ____opt_70 = window.Weather
                if ____opt_70 ~= nil then
                    ____opt_70 = ____opt_70.state
                end
                local ____opt_result_72
                if ____opt_70 ~= nil then
                    ____opt_result_72 = ____opt_70(____opt_70).rain
                end
                __O[68] = ____opt_result_72
                local wet = ____gt_74(if ____t_73(____opt_result_72) then __O[68] else 0, 0.35) or __gt(S.wet, 0)
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
        local ____t_17 = __t
        local ____t_10 = __t
        local ____getq_8 = __getq
        local ____opt_6 = window.WorldData
        if ____opt_6 ~= nil then
            ____opt_6 = ____opt_6.widths
        end
        local ____TS__Number_result_9 = __TS__Number(____getq_8(____opt_6, scene))
        __O[56] = ____TS__Number_result_9
        local ____opt_13 = window.CampanhaCenarios
        if ____opt_13 ~= nil then
            ____opt_13 = ____opt_13.largura
        end
        local ____opt_result_15
        if ____opt_13 ~= nil then
            ____opt_result_15 = ____opt_13(____opt_13, scene)
        end
        local ____temp_16 = if ____t_10(____TS__Number_result_9) then __O[56] else __TS__Number(____opt_result_15)
        __O[57] = ____temp_16
        return if ____t_17(____temp_16) then __O[57] else 4800
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
            local x = if __t(x0) then x0 else 0 + off
            if __t(__get(BREAK, ____type)) then
                __call(
                    out.props,
                    "push",
                    {
                        type = ____type,
                        x = x + if ____type == "fence" then 0 else 0,
                        w = if ____type == "fence" then __get(s, 2) else __get(
                            __get(BREAK, ____type),
                            0
                        ),
                        h = __get(
                            __get(BREAK, ____type),
                            1
                        ),
                        y = 0,
                        vy = 0,
                        hp = if ____type == "barrel" then 2 else 1,
                        broken = 0,
                        wob = 0,
                        stack = if __t(__get(s, 2) == 1 and ____type ~= "fence") then 1 else 0,
                        alpha = 1,
                        segs = if ____type == "fence" then __arrayFrom(
                            {length = math.floor(__get(s, 2) / 18 + 0.5)},
                            function() return 0 end
                        ) else nil
                    }
                )
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
                local ____call_25 = __call
                local ____out_props_24 = out.props
                local ____type_20 = ____type
                local ____x_21 = x
                local ____get_result_22 = __get(s, 2)
                local ____get_result_23 = __get(s, 3)
                local ____t_19 = __t
                local ____get_result_18 = __get(s, 4)
                __O[58] = ____get_result_18
                ____call_25(____out_props_24, "push", {
                    type = ____type_20,
                    x = ____x_21,
                    w = ____get_result_22,
                    h = ____get_result_23,
                    kind = if ____t_19(____get_result_18) then __O[58] else "house",
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
        local ____call_32 = __call
        local ____call_31 = __call
        local ____t_30 = __t
        local ____getq_28 = __getq
        local ____opt_26 = window.WorldData
        if ____opt_26 ~= nil then
            ____opt_26 = ____opt_26.platforms
        end
        local ____getq_28_result_29 = ____getq_28(____opt_26, scene)
        __O[59] = ____getq_28_result_29
        local ps = ____call_32(
            ____call_31(if ____t_30(____getq_28_result_29) then __O[59] else __arrL({}, 0), "slice"),
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
                    local ____t_36 = __t
                    local ____t_34 = __t
                    local ____temp_33 = __lt(
                        x,
                        __add(
                            __get(p, 0),
                            __get(p, 2)
                        ) + 30
                    ) and __gt(
                        __add(x, w),
                        __get(p, 0) - 30
                    )
                    __O[60] = ____temp_33
                    local ____temp_35 = if ____t_34(____temp_33) then __gt(
                        __get(p, 1),
                        y0 - 20
                    ) else __O[60]
                    __O[61] = ____temp_35
                    return if ____t_36(____temp_35) then __lt(
                        __get(p, 1),
                        y1 + 20
                    ) else __O[61]
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
                local ____t_39 = __t
                local ____t_38 = __t
                local ____gt_result_37 = __gt(x, 200)
                __O[62] = ____gt_result_37
                if ____t_39(if ____t_38(____gt_result_37) then free(
                    nil,
                    x,
                    70,
                    __get(top, 1) + 30,
                    FLOOR - 30
                ) else __O[62]) then
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
                local ____t_42 = __t
                local ____t_41 = __t
                local ____temp_40 = gap > 180 and gap < 1200
                __O[63] = ____temp_40
                if ____t_42(if ____t_41(____temp_40) then not __t(best) or gap > best.gap else __O[63]) then
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
            local ____set_46 = __set
            local ____build_45 = build
            local ____t_44 = __t
            local ____get_result_43 = __get(SPEC, o.scene)
            __O[64] = ____get_result_43
            ____set_46(
                sets,
                key,
                ____build_45(nil, key, if ____t_44(____get_result_43) then __O[64] else __arrL({}, 0))
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
                        col = if math.random() > 0.5 then "#bfe6f6" else "#e8f8ff",
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
                __call(
                    S.fx,
                    "push",
                    {
                        k = "spark",
                        x = x,
                        y = y,
                        vx = (math.random() - 0.5) * 300,
                        vy = -60 - math.random() * 260,
                        s = 2,
                        col = if __t(__mod(i, 3)) then col else "#fff6d0",
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
            local ____p_59, ____hp_60 = p, "hp"
            local ____p_hp_61 = ____p_59[____hp_60] - 1
            ____p_59[____hp_60] = ____p_hp_61
            if ____p_hp_61 > 0 then
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
            local cy = FLOOR - p.h / 2 - if __t(p.stack) then 28 else 0
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
                if __t(p.on) then "LIGOU!" else "DESLIGOU",
                if __t(p.on) then "#b8ff9a" else "#ffd0a0"
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
        local ____t_64 = __t
        local ____t_63 = __t
        local ____temp_62 = p.type == "trap"
        __O[66] = ____temp_62
        if ____t_64(if ____t_63(____temp_62) then p.armed else __O[66]) then
            snap(nil, S, p, t)
        end
    end
    local function shock(self, S, x, power, t)
        for ____, p in __iterar((S.props)) do
            local cx = p.x + if __t(p.w) then p.w else 0 / 2
            local d = math.abs(cx - x)
            if d > 300 then
                continue
            end
            local k = 1 - d / 300
            local ____t_77 = __t
            local ____t_76 = __t
            local ____get_result_75 = __get(BREAK, p.type)
            __O[69] = ____get_result_75
            if ____t_77(if ____t_76(____get_result_75) then not __t(p.broken) else __O[69]) then
                p.vy = -260 * k * power
                p.wob = 1
                if __t(k > 0.75 and __gt(power, 0.8)) then
                    local ____hitProp_81 = hitProp
                    local ____S_80 = S
                    local ____t_79 = __t
                    local ____TS__MathSign_result_78 = __TS__MathSign(cx - x)
                    __O[70] = ____TS__MathSign_result_78
                    ____hitProp_81(
                        nil,
                        ____S_80,
                        p,
                        if ____t_79(____TS__MathSign_result_78) then __O[70] else 1,
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
            local ____t_86 = __t
            local ____t_85 = __t
            local ____t_83 = __t
            local ____temp_82 = p.type == "trap"
            __O[71] = ____temp_82
            local ____temp_84 = if ____t_83(____temp_82) then p.armed else __O[71]
            __O[72] = ____temp_84
            if ____t_86(if ____t_85(____temp_84) then k > 0.5 else __O[72]) then
                snap(nil, S, p, t)
            end
            if p.type == "door" then
                p.open = math.min(1, p.open + 0.6 * k)
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
        local ____t_88 = __t
        local ____TS__Number_result_87 = __TS__Number(o.time)
        __O[73] = ____TS__Number_result_87
        local t = if ____t_88(____TS__Number_result_87) then __O[73] else 0
        local p = o.player
        dt = math.min(0.05, if __t(dt) then dt else 0.016)
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
        local W = if __t(o.arena) then 1000000000 else worldW(nil, o.scene)
        local f = if __lt(p.facing, 0) then -1 else 1
        if __t(__gt(p.attack, 0) and lastAttack <= 0) then
            attackId = attackId + 1
        end
        lastAttack = p.attack
        local atk = if __gt(p.attack, 0) then {
            x0 = math.min(p.x + f * 6, p.x + f * 90),
            x1 = math.max(p.x + f * 6, p.x + f * 90),
            y0 = p.y - 95,
            y1 = p.y + 6
        } else nil
        for ____, q in __iterar((S.props)) do
            local top = FLOOR - if __t(q.h) then q.h else 20 - if __t(q.stack) then 28 else 0 + if __t(q.y) then q.y else 0
            local x0 = q.x
            local x1 = __add(q.x, if __t(q.w) then q.w else 20)
            local ____t_101 = __t
            local ____t_98 = __t
            local ____t_96 = __t
            local ____t_94 = __t
            local ____t_92 = __t
            local ____t_90 = __t
            local ____temp_89 = if __t(atk) then q.hitBy ~= attackId else atk
            __O[74] = ____temp_89
            local ____temp_91 = if ____t_90(____temp_89) then __gt(atk.x1, x0) else __O[74]
            __O[75] = ____temp_91
            local ____temp_93 = if ____t_92(____temp_91) then __lt(atk.x0, x1) else __O[75]
            __O[76] = ____temp_93
            local ____temp_95 = if ____t_94(____temp_93) then __gt(atk.y1, top) else __O[76]
            __O[77] = ____temp_95
            local ____temp_97 = if ____t_96(____temp_95) then atk.y0 < FLOOR + 4 else __O[77]
            __O[79] = ____temp_97
            local ____t_100 = __t
            local ____temp_99 = q.type ~= "door" and q.type ~= "puddle"
            __O[78] = ____temp_99
            if ____t_101(if ____t_98(____temp_97) then if ____t_100(____temp_99) then q.type ~= "grass" else __O[78] else __O[79]) then
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
            for ____, s in __iterar((if __t(o.shots) then o.shots else __arrL({}, 0))) do
                local ____t_106 = __t
                local ____t_105 = __t
                local ____t_103 = __t
                local ____temp_102 = not __t(s)
                __O[80] = ____temp_102
                local ____temp_104 = if ____t_103(____temp_102) then __O[80] else __call(shotSeen, "has", s)
                __O[81] = ____temp_104
                if ____t_106(if ____t_105(____temp_104) then __O[81] else __gt(if __t(s.delay) then s.delay else 0, 0)) then
                    continue
                end
                local ____t_117 = __t
                local ____t_116 = __t
                local ____t_114 = __t
                local ____t_112 = __t
                local ____t_110 = __t
                local ____t_108 = __t
                local ____temp_107 = __gt(s.x, x0) and __lt(s.x, x1)
                __O[82] = ____temp_107
                local ____temp_109 = if ____t_108(____temp_107) then __gt(s.y, top - 4) else __O[82]
                __O[83] = ____temp_109
                local ____temp_111 = if ____t_110(____temp_109) then __lt(s.y, FLOOR + 4) else __O[83]
                __O[84] = ____temp_111
                local ____temp_113 = if ____t_112(____temp_111) then q.type ~= "door" else __O[84]
                __O[85] = ____temp_113
                local ____temp_115 = if ____t_114(____temp_113) then q.type ~= "puddle" else __O[85]
                __O[86] = ____temp_115
                if ____t_117(if ____t_116(____temp_115) then q.type ~= "grass" else __O[86]) then
                    __call(shotSeen, "add", s)
                    local ____hitProp_120 = hitProp
                    local ____t_119 = __t
                    local ____TS__MathSign_result_118 = __TS__MathSign(if __t(s.vx) then s.vx else f)
                    __O[87] = ____TS__MathSign_result_118
                    ____hitProp_120(
                        nil,
                        S,
                        q,
                        if ____t_119(____TS__MathSign_result_118) then __O[87] else f,
                        0.7,
                        t
                    )
                end
            end
        end
        local ____t_123 = __t
        local ____t_122 = __t
        local ____temp_121 = playerVy > 420
        __O[88] = ____temp_121
        if ____t_123(if ____t_122(____temp_121) then p.ground else __O[88]) then
            for ____, q in __iterar((S.props)) do
                if math.abs(q.x + if __t(q.w) then q.w else 0 / 2 - p.x) < 90 then
                    local ____t_126 = __t
                    local ____t_125 = __t
                    local ____temp_124 = q.type == "puddle" and __gt(p.x, q.x)
                    __O[89] = ____temp_124
                    if ____t_126(if ____t_125(____temp_124) then __lt(
                        p.x,
                        __add(q.x, q.w)
                    ) else __O[89]) then
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
                        local ____t_129 = __t
                        local ____t_128 = __t
                        local ____get_result_127 = __get(BREAK, q.type)
                        __O[90] = ____get_result_127
                        if ____t_129(if ____t_128(____get_result_127) then __O[90] else __get(PUSH, q.type)) then
                            q.vy = math.min(if __t(q.vy) then q.vy else 0, -90)
                            q.wob = 0.6
                        end
                    end
                end
            end
        end
        playerVy = if __t(p.vy) then p.vy else 0
        for ____, e in __iterar((if __t(o.enemies) then o.enemies else __arrL({}, 0))) do
            if __t(not __t(e) or __le(e.hp, 0)) then
                continue
            end
            local ____t_131 = __t
            local ____call_result_130 = __call(enemyVy, "get", e)
            __O[91] = ____call_result_130
            local pv = if ____t_131(____call_result_130) then __O[91] else 0
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
            local ____t_134 = __t
            local ____t_133 = __t
            local ____temp_132 = __gt(pv, 380) and math.abs(if __t(e.vy) then e.vy else 0) < 60
            __O[92] = ____temp_132
            if ____t_134(if ____t_133(____temp_132) then __ge(e.y, FLOOR - 6) else __O[92]) then
                shock(
                    nil,
                    S,
                    e.x,
                    if __t(big) then 1.2 else 0.7,
                    t
                )
            end
            __call(enemyVy, "set", e, if __t(e.vy) then e.vy else 0)
            for ____, q in __iterar((S.props)) do
                local x0 = q.x
                local x1 = __add(q.x, if __t(q.w) then q.w else 20)
                local ____t_137 = __t
                local ____t_136 = __t
                local ____temp_135 = __lt(e.x, x0 - 20) or __gt(e.x, x1 + 20)
                __O[93] = ____temp_135
                if ____t_137(if ____t_136(____temp_135) then __O[93] else __lt(e.y, FLOOR - 120)) then
                    continue
                end
                if __t(__get(PUSH, q.type)) then
                    q.vx = if __t(e.vx) then e.vx else 0 * 1.1
                end
                local ____t_140 = __t
                local ____t_139 = __t
                local ____get_result_138 = __get(BREAK, q.type)
                __O[94] = ____get_result_138
                if ____t_140(if ____t_139(____get_result_138) then math.abs(if __t(e.vx) then e.vx else 0) > 260 else __O[94]) then
                    local ____hitProp_143 = hitProp
                    local ____t_142 = __t
                    local ____TS__MathSign_result_141 = __TS__MathSign(e.vx)
                    __O[95] = ____TS__MathSign_result_141
                    ____hitProp_143(
                        nil,
                        S,
                        q,
                        if ____t_142(____TS__MathSign_result_141) then __O[95] else 1,
                        1,
                        t
                    )
                end
                if __t(q.type == "puddle" and math.random() < 0.2) then
                    __call(q.ripples, "push", {x = e.x, t = t})
                end
                local ____t_146 = __t
                local ____t_145 = __t
                local ____temp_144 = q.type == "trap"
                __O[96] = ____temp_144
                if ____t_146(if ____t_145(____temp_144) then q.armed else __O[96]) then
                    snap(nil, S, q, t)
                end
            end
        end
        for ____, m in __iterar((if __t(o.minions) then o.minions else __arrL({}, 0))) do
            local ____t_149 = __t
            local ____t_148 = __t
            local ____temp_147 = not __t(m)
            __O[97] = ____temp_147
            if ____t_149(if ____t_148(____temp_147) then __O[97] else m.dead) then
                continue
            end
            for ____, q in __iterar((S.props)) do
                local ____t_154 = __t
                local ____t_153 = __t
                local ____t_151 = __t
                local ____temp_150 = q.type == "trap"
                __O[98] = ____temp_150
                local ____temp_152 = if ____t_151(____temp_150) then q.armed else __O[98]
                __O[99] = ____temp_152
                if ____t_154(if ____t_153(____temp_152) then math.abs(m.x - q.x - 9) < 14 else __O[99]) then
                    snap(nil, S, q, t)
                end
            end
        end
        if __t(o.dashing) then
            for ____, q in __iterar((S.props)) do
                local ____t_157 = __t
                local ____t_156 = __t
                local ____get_result_155 = __get(PUSH, q.type)
                __O[100] = ____get_result_155
                if ____t_157(if ____t_156(____get_result_155) then math.abs(q.x - p.x) < 70 else __O[100]) then
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
                q.vy = if __t(q.vy) then q.vy else 0 + 900 * dt
                q.y = math.min(0, if __t(q.y) then q.y else 0 + q.vy * dt)
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
                if __t(if __t(q.broken) then t - q.broken > 28 else q.broken) then
                    local far = math.abs(q.x - (o.camera + 480)) > 560
                    if __t(if __t(far) then far else t - q.broken > 40) then
                        q.broken = 0
                        q.hp = if q.type == "barrel" then 2 else 1
                        q.alpha = 0
                        if __t(q.segs) then
                            __call(q.segs, "fill", 0)
                        end
                    end
                end
                local ____q_alpha_158 = q.alpha
                if ____q_alpha_158 == nil then
                    ____q_alpha_158 = 1
                end
                q.alpha = math.min(1, ____q_alpha_158 + dt * 2)
            end
            if __t(__get(PUSH, q.type)) then
                local ____t_160 = __t
                local ____temp_159 = __gt(p.x, q.x - 10) and __lt(
                    p.x,
                    __add(q.x, q.w) + 10
                )
                __O[101] = ____temp_159
                local near = if ____t_160(____temp_159) then __gt(p.y, FLOOR - 40) else __O[101]
                local ____t_163 = __t
                local ____t_162 = __t
                local ____temp_161 = if __t(near) then math.abs(if __t(p.vx) then p.vx else 0) > 30 else near
                __O[102] = ____temp_161
                if ____t_163(if ____t_162(____temp_161) then __TS__MathSign(p.vx) == __TS__MathSign(q.x + q.w / 2 - p.x) else __O[102]) then
                    q.vx = p.vx * 1.15
                    local ____t_166 = __t
                    local ____t_165 = __t
                    local ____temp_164 = q.type == "cone" and math.abs(p.vx) > 200
                    __O[103] = ____temp_164
                    if ____t_166(if ____t_165(____temp_164) then not __t(q.fall) else __O[103]) then
                        q.fall = 1
                    end
                end
                q.vy = if __t(q.vy) then q.vy else 0 + 1000 * dt
                q.y = math.min(0, if __t(q.y) then q.y else 0 + q.vy * dt)
                if __t(__ge(q.y, 0) and __gt(q.vy, 0)) then
                    q.vy = if __gt(q.vy, 140) then __TS__Number(-q.vy) * if q.type == "ball" then 0.62 else 0.25 else 0
                end
                q.x = q.x + q.vx * dt
                q.vx = q.vx * if __lt(q.y, 0) then 0.9 else if __t(q.type == "ball" or q.type == "tire") then 0.55 else 0.12 ^ dt
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
                local near = math.abs(p.x - (q.x + q.w / 2)) < if q.kind == "class" then 90 else 70 and __gt(p.y, FLOOR - 80)
                do
                    local was = q.open
                    q.open = q.open + (if __t(near) then 1 else 0 - q.open) * math.min(1, dt * 6)
                    if __t(__lt(was, 0.05) and __ge(q.open, 0.05)) then
                        sound(nil, "porta")
                    end
                end
            end
            if q.type == "lever" then
                q.flip = math.max(0, q.flip - dt * 3)
            end
            if q.type == "puddle" then
                local ____t_173 = __t
                local ____t_172 = __t
                local ____t_170 = __t
                local ____t_168 = __t
                local ____temp_167 = __gt(p.x, q.x) and __lt(
                    p.x,
                    __add(q.x, q.w)
                )
                __O[104] = ____temp_167
                local ____temp_169 = if ____t_168(____temp_167) then p.ground else __O[104]
                __O[105] = ____temp_169
                local ____temp_171 = if ____t_170(____temp_169) then math.abs(if __t(p.vx) then p.vx else 0) > 60 else __O[105]
                __O[106] = ____temp_171
                if ____t_173(if ____t_172(____temp_171) then math.random() < dt * 8 else __O[106]) then
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
                local ____t_179 = __t
                local ____opt_176 = window.Weather
                if ____opt_176 ~= nil then
                    ____opt_176 = ____opt_176.state
                end
                local ____opt_result_178
                if ____opt_176 ~= nil then
                    ____opt_result_178 = ____opt_176(____opt_176).rain
                end
                __O[107] = ____opt_result_178
                local rain = if ____t_179(____opt_result_178) then __O[107] else 0
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
                local ____t_182 = __t
                local ____t_181 = __t
                local ____temp_180 = if __t(q.armed) then math.abs(p.x - q.x - 9) < 12 else q.armed
                __O[108] = ____temp_180
                if ____t_182(if ____t_181(____temp_180) then p.ground else __O[108]) then
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
                local ____t_188 = __t
                local ____opt_185 = window.Weather
                if ____opt_185 ~= nil then
                    ____opt_185 = ____opt_185.state
                end
                local ____opt_result_187
                if ____opt_185 ~= nil then
                    ____opt_result_187 = ____opt_185(____opt_185).rain
                end
                __O[109] = ____opt_result_187
                local rain = if ____t_188(____opt_result_187) then __O[109] else 0
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
                                        local ____t_191 = __t
                                        local ____t_190 = __t
                                        local ____get_result_189 = __get(q.cells, j)
                                        __O[110] = ____get_result_189
                                        if ____t_191(if ____t_190(____get_result_189) then __get(q.cells, j).s == 0 else __O[110]) then
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
                                            col = if math.random() > 0.5 then "#ffb030" else "#ff6a20",
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
        S.wet = math.max(0, if __t(S.wet) then S.wet else 0 - dt)
        for ____, q in __iterar((S.props)) do
            local ____t_196 = __t
            local ____t_195 = __t
            local ____t_193 = __t
            local ____temp_192 = q.type == "lever"
            __O[111] = ____temp_192
            local ____temp_194 = if ____t_193(____temp_192) then q.on else __O[111]
            __O[112] = ____temp_194
            if ____t_196(if ____t_195(____temp_194) then q.effect == "sprinkler" else __O[112]) then
                S.wet = 2
            end
        end
        local ____opt_199 = window.Weather
        if ____opt_199 ~= nil then
            ____opt_199 = ____opt_199.state
        end
        local ____opt_result_201
        if ____opt_199 ~= nil then
            ____opt_result_201 = ____opt_199(____opt_199)
        end
        local wx = ____opt_result_201
        local ____t_204 = __t
        local ____t_203 = __t
        local ____temp_202 = if __t(wx) then __gt(wx.flash, 0.95) else wx
        __O[113] = ____temp_202
        if ____t_204(if ____t_203(____temp_202) then math.random() < 0.3 else __O[113]) then
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
            fx.vy = fx.vy + if fx.k == "puff" then -10 else if fx.k == "leaf" then 0 else if fx.k == "ember" then -40 else 900 * dt
            if fx.k == "leaf" then
                fx.vx = fx.vx + math.sin(t * 3 + fx.ph) * 40 * dt
            end
            fx.x = fx.x + fx.vx * dt
            fx.y = fx.y + fx.vy * dt
            local ____t_207 = __t
            local ____t_206 = __t
            local ____temp_205 = fx.k == "chunk" or fx.k == "drop"
            __O[114] = ____temp_205
            if ____t_207(if ____t_206(____temp_205) then __gt(fx.y, FLOOR - 2) else __O[114]) then
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
        local b = FLOOR + if __t(q.y) then q.y else 0 - if __t(q.stack) then 28 else 0
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
            local ____c_209 = c
            local ____q_alpha_208 = q.alpha
            if ____q_alpha_208 == nil then
                ____q_alpha_208 = 1
            end
            ____c_209.globalAlpha = ____q_alpha_208
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
                            if __t(__mod(k, 2)) then "#4f9a3f" else "#6fb24a"
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
                        if __t(__get(q.segs, k)) then
                            continue
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
                c:rotate(if __t(q.vx) then math.floor(q.rot * 4 + 0.5) / 4 else 0)
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
                    c:rotate(math.pi / 2 * __TS__MathSign(if __t(q.vx) then q.vx else 1))
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
            local top = FLOOR - q.h - if q.kind == "house" then 4 else 0
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
            local ____t_215 = __t
            local ____opt_212 = window.DayTime
            if ____opt_212 ~= nil then
                ____opt_212 = ____opt_212.state
            end
            local ____opt_result_214
            if ____opt_212 ~= nil then
                ____opt_result_214 = ____opt_212(____opt_212).night
            end
            __O[115] = ____opt_result_214
            local night = if ____t_215(____opt_result_214) then __O[115] else 0
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
            local col = if q.kind == "class" then "#7f9ba1" else if q.kind == "fav" then "#647b6f" else if q.kind == "main" then "#526661" else "#886641"
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
                if __t(q.on) then "#6ad86a" else "#d83a3a"
            )
            local ang = if __t(q.on) then -0.6 else 0.6 * (1 - q.flip * 0.3)
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
                local rr = if __t(r.small) then 10 else 24 * u + 2
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
                        if math.sin(t * 9 + k) > 0 then "#ff8a30" else "#ffd060"
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
            local ____t_218 = __t
            local ____t_217 = __t
            local ____temp_216 = q.type == "lever"
            __O[116] = ____temp_216
            if ____t_218(if ____t_217(____temp_216) then q.on else __O[116]) then
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
                            local side = if __t(__mod(j, 2)) then 1 else -1
                            local px = sx + side * u * (130 + __mod(j, 5) * 26) + math.sin(t * 2) * 24 * u
                            local py = FLOOR - 18 - math.sin(u * math.pi) * (90 + __mod(j, 3) * 20)
                            R(
                                nil,
                                c,
                                px,
                                py,
                                if __t(__mod(j, 4)) then 2 else 4,
                                4,
                                if __t(__mod(j, 3)) then "#7ac4ee" else "#e8f8ff"
                            )
                            j = j + 1
                        end
                    end
                    do
                        local j = 0
                        while j < 8 do
                            local u = __mod(t * 1.5 + j / 8, 1)
                            local px = sx + if __t(__mod(j, 2)) then 1 else -1 * (100 + j * 12)
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
                    local ____opt_221 = window.DayTime
                    if ____opt_221 ~= nil then
                        ____opt_221 = ____opt_221.state
                    end
                    local ____opt_result_223
                    if ____opt_221 ~= nil then
                        ____opt_result_223 = ____opt_221(____opt_221)
                    end
                    local sun = ____opt_result_223
                    local ____t_233 = __t
                    local ____t_225 = __t
                    local ____temp_224 = if __t(sun) then sun.sunT ~= nil else sun
                    __O[118] = ____temp_224
                    local ____lt_232 = __lt
                    local ____t_231 = __t
                    local ____opt_228 = window.Weather
                    if ____opt_228 ~= nil then
                        ____opt_228 = ____opt_228.state
                    end
                    local ____opt_result_230
                    if ____opt_228 ~= nil then
                        ____opt_result_230 = ____opt_228(____opt_228).rain
                    end
                    __O[117] = ____opt_result_230
                    if ____t_233(if ____t_225(____temp_224) then ____lt_232(if ____t_231(____opt_result_230) then __O[117] else 0, 0.3) else __O[118]) then
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
                                if __t(__mod(k, 8)) then "#bfe6f6" else "#ffffff"
                            )
                            k = k + 4
                        end
                    end
                    do
                        local j = 0
                        while j < 30 do
                            local u = __mod(t * 0.9 + j / 30, 1)
                            local side = if __t(__mod(j, 2)) then 1 else -1
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
                            R(
                                nil,
                                c,
                                px + 10,
                                py,
                                4,
                                6,
                                if __t(on) then __get(
                                    __arrL({"#ff4a8a", "#4ad8ff", "#ffe040", "#6aff6a"}, 4),
                                    __mod(k + 400, 4)
                                ) else "#5a4a40"
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
        for ____, fx in __iterar((S.fx)) do
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
            local ____t_236 = __t
            local ____o_235 = o
            local ____m_x_234 = m.x
            if ____m_x_234 == nil then
                ____m_x_234 = m.x0
            end
            if not ____t_236(vis(nil, ____o_235, ____m_x_234 - 40, 300)) then
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
    local function drawBack(self, c, o)
        local S = getSet(nil, o)
        if not __t(S) then
            return
        end
        drawPlatformRigs(nil, c, S, o)
        if __t(lite(nil)) then
            return
        end
        local ____t_238 = __t
        local ____TS__Number_result_237 = __TS__Number(o.time)
        __O[119] = ____TS__Number_result_237
        local t = if ____t_238(____TS__Number_result_237) then __O[119] else 0
        for ____, q in __iterar((S.props)) do
            local ____t_249 = __t
            local ____t_240 = __t
            local ____vis_result_239 = vis(nil, o, q.x, if __t(q.w) then q.w else 60)
            __O[124] = ____vis_result_239
            local ____t_248 = __t
            local ____t_246 = __t
            local ____t_244 = __t
            local ____t_242 = __t
            local ____temp_241 = q.type == "door" or q.type == "puddle"
            __O[120] = ____temp_241
            local ____temp_243 = if ____t_242(____temp_241) then __O[120] else q.type == "grass"
            __O[121] = ____temp_243
            local ____temp_245 = if ____t_244(____temp_243) then __O[121] else q.type == "lever"
            __O[122] = ____temp_245
            local ____temp_247 = if ____t_246(____temp_245) then __O[122] else q.type == "grill"
            __O[123] = ____temp_247
            if ____t_249(if ____t_240(____vis_result_239) then if ____t_248(____temp_247) then __O[123] else q.type == "trap" else __O[124]) then
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
            local ____t_254 = __t
            local ____t_251 = __t
            local ____vis_result_250 = vis(nil, o, q.x, if __t(q.w) then q.w else 60)
            __O[126] = ____vis_result_250
            local ____t_253 = __t
            local ____get_result_252 = __get(BREAK, q.type)
            __O[125] = ____get_result_252
            if ____t_254(if ____t_251(____vis_result_250) then if ____t_253(____get_result_252) then __O[125] else __get(PUSH, q.type) else __O[126]) then
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
        local ____t_257 = __t
        local ____t_256 = __t
        local ____temp_255 = not __t(S)
        __O[127] = ____temp_255
        if ____t_257(if ____t_256(____temp_255) then __O[127] else lite(nil)) then
            return
        end
        local ____drawEffects_261 = drawEffects
        local ____c_260 = c
        local ____t_259 = __t
        local ____TS__Number_result_258 = __TS__Number(o.time)
        __O[128] = ____TS__Number_result_258
        ____drawEffects_261(
            nil,
            ____c_260,
            S,
            if ____t_259(____TS__Number_result_258) then __O[128] else 0,
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
            function(____, m) return __arrL(
                {
                    math.floor(m.cx + 0.5),
                    math.floor(m.cy + 0.5),
                    m.w,
                    if __t(m.dx) then m.dx else 0
                },
                4
            ) end
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
                        update(nil, dt, if __t(o) then o else {})
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
                        drawBack(nil, c, if __t(o) then o else {})
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
                        drawFront(nil, c, if __t(o) then o else {})
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
                        return true, platforms(nil, if __t(o) then o else {})
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
                    shock(
                        nil,
                        cur,
                        x,
                        if __t(power) then power else 1,
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
