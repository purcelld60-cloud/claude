--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __newExpr, __lt, __le, __gt, __ge, __getq, __callq, __mod, __ord, __arrL, __iterar, __t = __JSR.__newExpr, __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__getq, __JSR.__callq, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t
local __get, __set, __inc, __arr, __len, __call, __add, __new, __iter, __keys, __assign, __isArray = __JSR.__get, __JSR.__set, __JSR.__inc, __JSR.__arr, __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__new, __JSR.__iter, __JSR.__keys, __JSR.__assign, __JSR.__isArray
local __arrayFrom, __bor, __hypot, __getters, __re, __re_replace = __JSR.__arrayFrom, __JSR.__bor, __JSR.__hypot, __JSR.__getters, __JSR.__re, __JSR.__re_replace
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Spread = ____lualib.__TS__Spread
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local __TS__Number = ____lualib.__TS__Number
local __TS__Promise = ____lualib.__TS__Promise
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local __O = {};
(function()
    local __L1 = {}
    __L1.sfx = function(self, name)
        local ____t_3 = __t
        local ____t_result_2
        local ____t_1 = __t
        local ____t_result_0
        if __t(__L1.net) then
            ____t_result_0 = __L1.net.role == "host"
        else
            ____t_result_0 = __L1.net
        end
        __O[1100] = ____t_result_0
        if ____t_1(____t_result_0) then
            ____t_result_2 = __lt(
                __len(__L1.net.sfx),
                20
            )
        else
            ____t_result_2 = __O[1100]
        end
        if ____t_3(____t_result_2) then
            __call(__L1.net.sfx, "push", name)
        end
        if __t(__L1.tv) then
            __L1:tvBuzz(name)
        end
        if __t(__L1.muted) then
            return
        end
        do
            pcall(function()
                local ____t_result_6
                if __t(__L1.actx) then
                    ____t_result_6 = __L1.actx
                else
                    local ____newExpr_5 = __newExpr
                    local ____t_result_4
                    if __t(window.AudioContext) then
                        ____t_result_4 = window.AudioContext
                    else
                        ____t_result_4 = window.webkitAudioContext
                    end
                    ____t_result_6 = ____newExpr_5(____t_result_4)
                end
                __L1.actx = ____t_result_6
                if __L1.actx.state == "suspended" then
                    __L1.actx:resume()
                end
                local now = __L1.actx.currentTime
                local out = __L1.actx:createGain()
                local ____out_gain_13 = out.gain
                local ____opt_9 = window.DarocaAudio
                if ____opt_9 ~= nil then
                    ____opt_9 = ____opt_9.sfx
                end
                local ____opt_result_11
                if ____opt_9 ~= nil then
                    ____opt_result_11 = ____opt_9(____opt_9)
                end
                local ____opt_result_11_12 = ____opt_result_11
                if ____opt_result_11_12 == nil then
                    ____opt_result_11_12 = 1
                end
                ____out_gain_13.value = 0.045 * ____opt_result_11_12
                out:connect(__L1.actx.destination)
                local function tone(____, f, f2, d, ____type, at, vol)
                    if ____type == nil then
                        ____type = "square"
                    end
                    if at == nil then
                        at = 0
                    end
                    if vol == nil then
                        vol = 1
                    end
                    local o = __L1.actx:createOscillator()
                    local g = __L1.actx:createGain()
                    o.type = ____type
                    o.frequency:setValueAtTime(f, now + at)
                    if __t(f2) then
                        o.frequency:exponentialRampToValueAtTime(
                            math.max(30, f2),
                            __add(now + at, d)
                        )
                    end
                    g.gain:setValueAtTime(vol, now + at)
                    g.gain:exponentialRampToValueAtTime(
                        0.001,
                        __add(now + at, d)
                    )
                    o:connect(g)
                    g:connect(out)
                    o:start(now + at)
                    o:stop(__add(now + at, d) + 0.02)
                end
                local function noise(____, d, vol, at)
                    if vol == nil then
                        vol = 1
                    end
                    if at == nil then
                        at = 0
                    end
                    local len = math.floor(__L1.actx.sampleRate * d)
                    local buf = __L1.actx:createBuffer(1, len, __L1.actx.sampleRate)
                    local ch = buf:getChannelData(0)
                    do
                        local i = 0
                        while i < len do
                            __set(
                                ch,
                                i,
                                (math.random() * 2 - 1) * (1 - i / len)
                            )
                            i = i + 1
                        end
                    end
                    local s = __L1.actx:createBufferSource()
                    local g = __L1.actx:createGain()
                    s.buffer = buf
                    g.gain.value = vol
                    s:connect(g)
                    g:connect(out)
                    s:start(now + at)
                end
                local ____t_result_16
                local ____t_15 = __t
                local ____get_result_14 = __get(
                    {
                        pick = function()
                            tone(nil, 880, 1320, 0.08)
                            tone(
                                nil,
                                1320,
                                1760,
                                0.08,
                                "square",
                                0.06
                            )
                        end,
                        hit = function()
                            tone(nil, 220, 110, 0.12)
                            noise(nil, 0.06, 0.5)
                        end,
                        bounce = function() return tone(nil, 520, 480, 0.05) end,
                        ["break"] = function()
                            noise(nil, 0.12, 0.7)
                            tone(
                                nil,
                                330,
                                160,
                                0.1,
                                "triangle"
                            )
                        end,
                        lose = function()
                            tone(nil, 330, 220, 0.18)
                            tone(
                                nil,
                                220,
                                110,
                                0.3,
                                "square",
                                0.16
                            )
                        end,
                        win = function() return __call(
                            __arrL({523, 659, 784, 1046}, 4),
                            "forEach",
                            function(____, f, i) return tone(
                                nil,
                                f,
                                f,
                                0.16,
                                "square",
                                i * 0.1
                            ) end
                        ) end,
                        tick = function() return tone(nil, 660, 660, 0.05) end,
                        go = function() return tone(nil, 990, 990, 0.25) end,
                        move = function() return tone(
                            nil,
                            330,
                            330,
                            0.03,
                            "triangle",
                            0,
                            0.6
                        ) end,
                        pull = function() return tone(
                            nil,
                            180 + math.random() * 40,
                            120,
                            0.06,
                            "triangle"
                        ) end,
                        power = function() return __call(
                            __arrL({660, 880, 1100}, 3),
                            "forEach",
                            function(____, f, i) return tone(
                                nil,
                                f,
                                f * 1.1,
                                0.07,
                                "square",
                                i * 0.05
                            ) end
                        ) end,
                        crow = function()
                            tone(
                                nil,
                                520,
                                900,
                                0.18,
                                "sawtooth"
                            )
                            tone(
                                nil,
                                900,
                                700,
                                0.25,
                                "sawtooth",
                                0.2
                            )
                            tone(
                                nil,
                                760,
                                420,
                                0.5,
                                "sawtooth",
                                0.46
                            )
                        end,
                        fake = function()
                            tone(
                                nil,
                                400,
                                380,
                                0.08,
                                "sawtooth"
                            )
                            tone(
                                nil,
                                420,
                                360,
                                0.1,
                                "sawtooth",
                                0.12
                            )
                        end,
                        menu = function() return tone(nil, 440, 660, 0.06) end
                    },
                    name
                )
                __O[1101] = ____get_result_14
                if ____t_15(____get_result_14) then
                    ____t_result_16 = __O[1101]
                else
                    ____t_result_16 = function() return tone(nil, 500, 500, 0.05) end
                end
                ____t_result_16(nil)
            end)
        end
    end
    __L1.readPads = function(self)
        local out = __arr(nil, nil, nil, nil)
        do
            pcall(function()
                local ____call_24 = __call
                local ____arr_23 = __arr
                local ____iter_22 = __iter
                local ____t_result_21
                local ____t_20 = __t
                local ____this_18
                ____this_18 = window.navigator
                local ____opt_17 = ____this_18.getGamepads
                local ____temp_19 = ____opt_17 and ____opt_17(____this_18)
                __O[1103] = ____temp_19
                if ____t_20(____temp_19) then
                    ____t_result_21 = __O[1103]
                else
                    ____t_result_21 = __arrL({}, 0)
                end
                local pads = ____call_24(
                    ____arr_23(__TS__Spread(____iter_22(____t_result_21))),
                    "filter",
                    window.Boolean
                )
                __call(
                    __call(pads, "slice", 0, 4),
                    "forEach",
                    function(____, g, i)
                        local ____t_result_27
                        local ____t_26 = __t
                        local ____get_result_25 = __get(g.axes, 0)
                        __O[1104] = ____get_result_25
                        if ____t_26(____get_result_25) then
                            ____t_result_27 = __O[1104]
                        else
                            ____t_result_27 = 0
                        end
                        local ax = ____t_result_27
                        local ____t_result_30
                        local ____t_29 = __t
                        local ____get_result_28 = __get(g.axes, 1)
                        __O[1105] = ____get_result_28
                        if ____t_29(____get_result_28) then
                            ____t_result_30 = __O[1105]
                        else
                            ____t_result_30 = 0
                        end
                        local ay = ____t_result_30
                        local function bt(____, n)
                            local ____t_33 = __t
                            local ____opt_31 = __get(g.buttons, n)
                            if ____opt_31 ~= nil then
                                ____opt_31 = ____opt_31.pressed
                            end
                            return not not ____t_33(____opt_31)
                        end
                        local ____set_57 = __set
                        local ____i_56 = i
                        local ____t_result_42
                        local ____t_37 = __t
                        local ____t_result_36
                        local ____t_35 = __t
                        local ____temp_34 = ax < -0.4
                        __O[1106] = ____temp_34
                        if ____t_35(____temp_34) then
                            ____t_result_36 = __O[1106]
                        else
                            ____t_result_36 = bt(nil, 14)
                        end
                        if ____t_37(____t_result_36) then
                            ____t_result_42 = -1
                        else
                            local ____t_41 = __t
                            local ____t_result_40
                            local ____t_39 = __t
                            local ____temp_38 = ax > 0.4
                            __O[1107] = ____temp_38
                            if ____t_39(____temp_38) then
                                ____t_result_40 = __O[1107]
                            else
                                ____t_result_40 = bt(nil, 15)
                            end
                            ____t_result_42 = ____t_41(____t_result_40) and 1 or 0
                        end
                        local ____t_result_51
                        local ____t_46 = __t
                        local ____t_result_45
                        local ____t_44 = __t
                        local ____temp_43 = ay < -0.4
                        __O[1108] = ____temp_43
                        if ____t_44(____temp_43) then
                            ____t_result_45 = __O[1108]
                        else
                            ____t_result_45 = bt(nil, 12)
                        end
                        if ____t_46(____t_result_45) then
                            ____t_result_51 = -1
                        else
                            local ____t_50 = __t
                            local ____t_result_49
                            local ____t_48 = __t
                            local ____temp_47 = ay > 0.4
                            __O[1109] = ____temp_47
                            if ____t_48(____temp_47) then
                                ____t_result_49 = __O[1109]
                            else
                                ____t_result_49 = bt(nil, 13)
                            end
                            ____t_result_51 = ____t_50(____t_result_49) and 1 or 0
                        end
                        local ____bt_result_55 = bt(nil, 0)
                        local ____t_result_54
                        local ____t_53 = __t
                        local ____bt_result_52 = bt(nil, 1)
                        __O[1110] = ____bt_result_52
                        if ____t_53(____bt_result_52) then
                            ____t_result_54 = __O[1110]
                        else
                            ____t_result_54 = bt(nil, 2)
                        end
                        ____set_57(
                            out,
                            ____i_56,
                            {
                                x = ____t_result_42,
                                y = ____t_result_51,
                                a = ____bt_result_55,
                                b = ____t_result_54,
                                start = bt(nil, 9)
                            }
                        )
                    end
                )
            end)
        end
        return out
    end
    __L1.pollInput = function(self)
        local pads = __L1:readPads()
        do
            local i = 0
            while i < 4 do
                local p = __get(__L1.P, i)
                local ____temp_59
                if i == 0 then
                    ____temp_59 = __L1.K1
                else
                    local ____temp_58
                    if i == 1 then
                        ____temp_58 = __L1.K2
                    else
                        ____temp_58 = {}
                    end
                    ____temp_59 = ____temp_58
                end
                local k = ____temp_59
                local ____t_result_64
                local ____t_63 = __t
                local ____t_result_62
                local ____t_61 = __t
                local ____t_result_60
                if __t(__L1.solo) then
                    ____t_result_60 = __L1.solo
                else
                    ____t_result_60 = not not __t(__L1.net)
                end
                __O[1111] = ____t_result_60
                if ____t_61(____t_result_60) then
                    ____t_result_62 = __O[1111]
                else
                    ____t_result_62 = not not __t(__L1.tv)
                end
                __O[1112] = ____t_result_62
                if ____t_63(____t_result_62) then
                    ____t_result_64 = i == 0
                else
                    ____t_result_64 = __O[1112]
                end
                local both = ____t_result_64
                if i > 1 then
                    for ____, n in __iterar((__arrL({
                        "up",
                        "down",
                        "left",
                        "right",
                        "a",
                        "b"
                    }, 6))) do
                        local ____set_68 = __set
                        local ____t_result_67
                        local ____t_66 = __t
                        local ____get_result_65 = __get(k, n)
                        __O[1113] = ____get_result_65
                        if ____t_66(____get_result_65) then
                            ____t_result_67 = __O[1113]
                        else
                            ____t_result_67 = __arrL({}, 0)
                        end
                        ____set_68(k, n, ____t_result_67)
                    end
                end
                local function kk(____, n)
                    local ____t_result_72
                    local ____t_70 = __t
                    local ____temp_69 = __L1:held(__get(k, n))
                    __O[1114] = ____temp_69
                    if ____t_70(____temp_69) then
                        ____t_result_72 = __O[1114]
                    else
                        local ____t_result_71
                        if __t(both) then
                            ____t_result_71 = __L1:held(__get(__L1.K2, n))
                        else
                            ____t_result_71 = both
                        end
                        ____t_result_72 = ____t_result_71
                    end
                    return ____t_result_72
                end
                local pad = __get(pads, i)
                local t = __get(__L1.touch, i)
                local ____t_result_80
                local ____t_79 = __t
                local ____t_result_78
                local ____t_74 = __t
                local ____temp_73 = (__t(kk(nil, "left")) and -1 or 0) + (__t(kk(nil, "right")) and 1 or 0)
                __O[1115] = ____temp_73
                if ____t_74(____temp_73) then
                    ____t_result_78 = __O[1115]
                else
                    local ____opt_result_77
                    if pad ~= nil then
                        ____opt_result_77 = pad.x
                    end
                    ____t_result_78 = ____opt_result_77
                end
                __O[1116] = ____t_result_78
                if ____t_79(____t_result_78) then
                    ____t_result_80 = __O[1116]
                else
                    ____t_result_80 = t.x
                end
                local x = ____t_result_80
                local ____t_result_88
                local ____t_87 = __t
                local ____t_result_86
                local ____t_82 = __t
                local ____temp_81 = (__t(kk(nil, "up")) and -1 or 0) + (__t(kk(nil, "down")) and 1 or 0)
                __O[1117] = ____temp_81
                if ____t_82(____temp_81) then
                    ____t_result_86 = __O[1117]
                else
                    local ____opt_result_85
                    if pad ~= nil then
                        ____opt_result_85 = pad.y
                    end
                    ____t_result_86 = ____opt_result_85
                end
                __O[1118] = ____t_result_86
                if ____t_87(____t_result_86) then
                    ____t_result_88 = __O[1118]
                else
                    ____t_result_88 = t.y
                end
                local y = ____t_result_88
                local ____t_result_97
                local ____t_96 = __t
                local ____t_result_95
                local ____t_90 = __t
                local ____kk_result_89 = kk(nil, "a")
                __O[1119] = ____kk_result_89
                if ____t_90(____kk_result_89) then
                    ____t_result_95 = __O[1119]
                else
                    local ____t_94 = __t
                    local ____opt_result_93
                    if pad ~= nil then
                        ____opt_result_93 = pad.a
                    end
                    ____t_result_95 = not not ____t_94(____opt_result_93)
                end
                __O[1120] = ____t_result_95
                if ____t_96(____t_result_95) then
                    ____t_result_97 = __O[1120]
                else
                    ____t_result_97 = t.a
                end
                local a = ____t_result_97
                local ____t_result_106
                local ____t_105 = __t
                local ____t_result_104
                local ____t_99 = __t
                local ____kk_result_98 = kk(nil, "b")
                __O[1121] = ____kk_result_98
                if ____t_99(____kk_result_98) then
                    ____t_result_104 = __O[1121]
                else
                    local ____t_103 = __t
                    local ____opt_result_102
                    if pad ~= nil then
                        ____opt_result_102 = pad.b
                    end
                    ____t_result_104 = not not ____t_103(____opt_result_102)
                end
                __O[1122] = ____t_result_104
                if ____t_105(____t_result_104) then
                    ____t_result_106 = __O[1122]
                else
                    ____t_result_106 = t.b
                end
                local b = ____t_result_106
                if __t(__L1.tv) then
                    local r = __L1.tv:take(i)
                    if __t(r) then
                        local ____t_result_107
                        if __t(r.x) then
                            ____t_result_107 = r.x
                        else
                            ____t_result_107 = x
                        end
                        x = ____t_result_107
                        local ____t_result_108
                        if __t(r.y) then
                            ____t_result_108 = r.y
                        else
                            ____t_result_108 = y
                        end
                        y = ____t_result_108
                        local ____t_result_109
                        if __t(a) then
                            ____t_result_109 = a
                        else
                            ____t_result_109 = r.a
                        end
                        a = ____t_result_109
                        local ____t_result_110
                        if __t(b) then
                            ____t_result_110 = b
                        else
                            ____t_result_110 = r.b
                        end
                        b = ____t_result_110
                    end
                end
                local ____t_112 = __t
                local ____t_result_111
                if __t(__L1.net) then
                    ____t_result_111 = i == 1
                else
                    ____t_result_111 = __L1.net
                end
                if ____t_112(____t_result_111) then
                    local ____temp_114
                    if __L1.net.role == "host" then
                        local ____t_result_113
                        if __t(__len(__L1.net.queue)) then
                            ____t_result_113 = __call(__L1.net.queue, "shift")
                        else
                            ____t_result_113 = __L1.net.remote
                        end
                        ____temp_114 = ____t_result_113
                    else
                        ____temp_114 = {x = 0, y = 0, a = false, b = false}
                    end
                    local r = ____temp_114
                    x = r.x
                    y = r.y
                    a = r.a
                    b = r.b
                end
                local ____t_result_115
                if __t(a) then
                    ____t_result_115 = not __t(p.pa)
                else
                    ____t_result_115 = a
                end
                p.ap = ____t_result_115
                local ____t_result_116
                if __t(b) then
                    ____t_result_116 = not __t(p.pb)
                else
                    ____t_result_116 = b
                end
                p.bp = ____t_result_116
                local ____t_118 = __t
                local ____t_result_117
                if __t(x) then
                    ____t_result_117 = x ~= p.px
                else
                    ____t_result_117 = x
                end
                if ____t_118(____t_result_117) then
                    __call(
                        p.dirs,
                        "push",
                        __lt(x, 0) and "l" or "r"
                    )
                end
                local ____t_120 = __t
                local ____t_result_119
                if __t(y) then
                    ____t_result_119 = y ~= p.py
                else
                    ____t_result_119 = y
                end
                if ____t_120(____t_result_119) then
                    __call(
                        p.dirs,
                        "push",
                        __lt(y, 0) and "u" or "d"
                    )
                end
                if __len(p.dirs) > 3 then
                    __call(
                        p.dirs,
                        "splice",
                        0,
                        __len(p.dirs) - 3
                    )
                end
                p.x = x
                p.y = y
                p.a = a
                p.b = b
                p.px = x
                p.py = y
                p.pa = a
                p.pb = b
                i = i + 1
            end
        end
        __call(__L1.latch, "clear")
        local pad0 = __get(pads, 0)
        local ____L1_menuNav_125 = __L1.menuNav
        local ____t_124 = __t
        local ____opt_result_123
        if pad0 ~= nil then
            ____opt_result_123 = pad0.start
        end
        ____L1_menuNav_125.start = not not ____t_124(____opt_result_123) and not __t(__L1.menuNav.pstart)
        local ____L1_menuNav_130 = __L1.menuNav
        local ____t_129 = __t
        local ____opt_result_128
        if pad0 ~= nil then
            ____opt_result_128 = pad0.start
        end
        ____L1_menuNav_130.pstart = not not ____t_129(____opt_result_128)
    end
    __L1.txt = function(self, c, s, x, y, size, col, align, shadow)
        if size == nil then
            size = 16
        end
        if col == nil then
            col = "#fff1ca"
        end
        if align == nil then
            align = "center"
        end
        if shadow == nil then
            shadow = "#1b1410"
        end
        c.font = tostring(size) .. "px Pixel, monospace"
        c.textAlign = align
        c.textBaseline = "middle"
        if __t(shadow) then
            c.fillStyle = shadow
            c:fillText(
                s,
                math.floor(x + 0.5) + 2,
                math.floor(y + 0.5) + 2
            )
        end
        c.fillStyle = col
        c:fillText(
            s,
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
    end
    __L1.frame = function(self, c, x, y, w, h, fill, edge, inner)
        if fill == nil then
            fill = "#2a2018"
        end
        if edge == nil then
            edge = "#e8c27a"
        end
        if inner == nil then
            inner = "#5a4028"
        end
        __L1:R(
            c,
            x + 4,
            y,
            w - 8,
            h,
            edge
        )
        __L1:R(
            c,
            x,
            y + 4,
            w,
            h - 8,
            edge
        )
        __L1:R(
            c,
            x + 2,
            y + 2,
            w - 4,
            h - 4,
            edge
        )
        __L1:R(
            c,
            x + 4,
            y + 4,
            w - 8,
            h - 8,
            inner
        )
        __L1:R(
            c,
            x + 6,
            y + 6,
            w - 12,
            h - 12,
            fill
        )
    end
    __L1.hero = function(self, c, ____type, x, y, opt)
        if opt == nil then
            opt = {}
        end
        do
            pcall(function()
                local ____opt_133 = window.Art
                if ____opt_133 ~= nil then
                    ____opt_133 = ____opt_133.drawCharacter
                end
                if ____opt_133 ~= nil then
                    ____opt_133(
                        ____opt_133,
                        c,
                        ____type,
                        x,
                        y,
                        __assign({}, {facing = 1, frame = 0, scale = 1, grounded = true}, opt)
                    )
                end
            end)
        end
    end
    __L1.scoreBar = function(self, c, vals, label)
        local n = __len(vals)
        __call(
            vals,
            "forEach",
            function(____, v, i)
                local ____le_result_136
                if __le(n, 2) then
                    local ____t_result_135
                    if __t(i) then
                        ____t_result_135 = __L1.W - 70
                    else
                        ____t_result_135 = 20
                    end
                    ____le_result_136 = ____t_result_135
                else
                    ____le_result_136 = 20 + i * ((__L1.W - 90) / n)
                end
                local x = ____le_result_136
                local ____L1_txt_144 = __L1.txt
                local ____array_143 = __TS__SparseArrayNew(c)
                local ____add_138 = __add
                local ____t_result_137
                if __t(label) then
                    ____t_result_137 = label(nil, i)
                else
                    ____t_result_137 = __add(
                        __get(__L1.PLAYER_NAME, i),
                        " "
                    )
                end
                __TS__SparseArrayPush(
                    ____array_143,
                    ____add_138(____t_result_137, v),
                    x,
                    18,
                    __gt(n, 2) and 11 or 14,
                    __get(__L1.PLAYER_COL, i)
                )
                local ____t_142 = __t
                local ____t_result_141
                local ____t_140 = __t
                local ____le_result_139 = __le(n, 2)
                __O[1129] = ____le_result_139
                if ____t_140(____le_result_139) then
                    ____t_result_141 = i
                else
                    ____t_result_141 = __O[1129]
                end
                __TS__SparseArrayPush(
                    ____array_143,
                    ____t_142(____t_result_141) and "right" or "left"
                )
                ____L1_txt_144(
                    __L1,
                    __TS__SparseArraySpread(____array_143)
                )
            end
        )
    end
    __L1.feiraIcon = function(self, g, kind, x, y)
        local function p(____, a, b, w, h, col)
            return __L1:R(
                g,
                __add(x, a),
                __add(y, b),
                w,
                h,
                col
            )
        end
        repeat
            local ____switch57 = kind
            local ____cond57 = ____switch57 == "milho"
            if ____cond57 then
                p(
                    nil,
                    7,
                    2,
                    6,
                    14,
                    "#f6c445"
                )
                do
                    local i = 0
                    while i < 6 do
                        p(
                            nil,
                            8 + __mod(i, 2) * 2,
                            3 + i * 2,
                            1,
                            1,
                            "#fff2a0"
                        )
                        i = i + 1
                    end
                end
                p(
                    nil,
                    4,
                    8,
                    4,
                    10,
                    "#7ab84a"
                )
                p(
                    nil,
                    12,
                    9,
                    4,
                    9,
                    "#5a9a3a"
                )
                break
            end
            ____cond57 = ____cond57 or ____switch57 == "melancia"
            if ____cond57 then
                p(
                    nil,
                    2,
                    8,
                    16,
                    8,
                    "#2f7a3a"
                )
                p(
                    nil,
                    3,
                    8,
                    14,
                    6,
                    "#e84a5a"
                )
                p(
                    nil,
                    3,
                    8,
                    14,
                    1,
                    "#f0f0c0"
                )
                do
                    local i = 0
                    while i < 4 do
                        p(
                            nil,
                            5 + i * 3,
                            10 + __mod(i, 2),
                            1,
                            2,
                            "#1a1a1a"
                        )
                        i = i + 1
                    end
                end
                break
            end
            ____cond57 = ____cond57 or ____switch57 == "acai"
            if ____cond57 then
                p(
                    nil,
                    5,
                    6,
                    10,
                    12,
                    "#f0f0f0"
                )
                p(
                    nil,
                    6,
                    7,
                    8,
                    4,
                    "#5a1a5a"
                )
                p(
                    nil,
                    7,
                    4,
                    6,
                    3,
                    "#9a3a8a"
                )
                p(
                    nil,
                    11,
                    1,
                    1,
                    6,
                    "#e84a3a"
                )
                break
            end
            ____cond57 = ____cond57 or ____switch57 == "bolo"
            if ____cond57 then
                p(
                    nil,
                    3,
                    9,
                    14,
                    8,
                    "#7a4a2a"
                )
                p(
                    nil,
                    3,
                    7,
                    14,
                    3,
                    "#f0d0e0"
                )
                p(
                    nil,
                    9,
                    3,
                    2,
                    4,
                    "#f0f0f0"
                )
                p(
                    nil,
                    9,
                    2,
                    2,
                    1,
                    "#ffb347"
                )
                p(
                    nil,
                    3,
                    12,
                    14,
                    1,
                    "#f0d0e0"
                )
                break
            end
            ____cond57 = ____cond57 or ____switch57 == "chapeu"
            if ____cond57 then
                p(
                    nil,
                    2,
                    12,
                    16,
                    3,
                    "#c8a050"
                )
                p(
                    nil,
                    5,
                    6,
                    10,
                    7,
                    "#e0c070"
                )
                p(
                    nil,
                    5,
                    10,
                    10,
                    2,
                    "#7a4a2a"
                )
                break
            end
            ____cond57 = ____cond57 or ____switch57 == "chinelo"
            if ____cond57 then
                p(
                    nil,
                    6,
                    2,
                    8,
                    16,
                    "#2a5ad0"
                )
                p(
                    nil,
                    7,
                    3,
                    6,
                    14,
                    "#4a8af0"
                )
                p(
                    nil,
                    9,
                    5,
                    2,
                    5,
                    "#f0f0f0"
                )
                break
            end
            ____cond57 = ____cond57 or ____switch57 == "cafe"
            if ____cond57 then
                p(
                    nil,
                    4,
                    7,
                    10,
                    9,
                    "#f0f0f0"
                )
                p(
                    nil,
                    5,
                    8,
                    8,
                    3,
                    "#5a3a22"
                )
                p(
                    nil,
                    14,
                    9,
                    3,
                    4,
                    "#f0f0f0"
                )
                p(
                    nil,
                    6,
                    2,
                    1,
                    4,
                    "rgba(255,255,255,.6)"
                )
                p(
                    nil,
                    9,
                    3,
                    1,
                    3,
                    "rgba(255,255,255,.6)"
                )
                break
            end
            ____cond57 = ____cond57 or ____switch57 == "caderno"
            if ____cond57 then
                p(
                    nil,
                    4,
                    3,
                    12,
                    15,
                    "#3a6ad0"
                )
                p(
                    nil,
                    5,
                    4,
                    10,
                    13,
                    "#f0ead2"
                )
                do
                    local i = 0
                    while i < 4 do
                        p(
                            nil,
                            6,
                            6 + i * 3,
                            8,
                            1,
                            "#9ab8d8"
                        )
                        i = i + 1
                    end
                end
                p(
                    nil,
                    4,
                    3,
                    2,
                    15,
                    "#d03a3a"
                )
                break
            end
            ____cond57 = ____cond57 or ____switch57 == "galo"
            if ____cond57 then
                p(
                    nil,
                    5,
                    8,
                    9,
                    7,
                    "#f4f0e0"
                )
                p(
                    nil,
                    11,
                    4,
                    5,
                    5,
                    "#f4f0e0"
                )
                p(
                    nil,
                    12,
                    2,
                    3,
                    2,
                    "#e83a3a"
                )
                p(
                    nil,
                    16,
                    6,
                    2,
                    1,
                    "#e8a83a"
                )
                p(
                    nil,
                    2,
                    6,
                    4,
                    6,
                    "#2a5a3a"
                )
                p(
                    nil,
                    7,
                    15,
                    1,
                    3,
                    "#e8a83a"
                )
                p(
                    nil,
                    10,
                    15,
                    1,
                    3,
                    "#e8a83a"
                )
                break
            end
            ____cond57 = ____cond57 or ____switch57 == "bola"
            if ____cond57 then
                p(
                    nil,
                    4,
                    4,
                    12,
                    12,
                    "#f4f4f4"
                )
                p(
                    nil,
                    8,
                    7,
                    4,
                    4,
                    "#1a1a1a"
                )
                p(
                    nil,
                    4,
                    9,
                    3,
                    2,
                    "#1a1a1a"
                )
                p(
                    nil,
                    13,
                    9,
                    3,
                    2,
                    "#1a1a1a"
                )
                p(
                    nil,
                    8,
                    4,
                    4,
                    1,
                    "#1a1a1a"
                )
                break
            end
        until true
    end
    __L1.c_brilho = function(self, g, x, y, t)
        if __mod(
            math.floor(t * 4 + x),
            6
        ) == 0 then
            __L1:R(
                g,
                x + 4,
                y - 6,
                1,
                3,
                "#ffffff"
            )
            __L1:R(
                g,
                x + 3,
                y - 5,
                3,
                1,
                "#ffffff"
            )
        end
    end
    __L1.igorRosto = function(self, g, cx, cy, st)
        local perto = __call(
            st.pl,
            "some",
            function(____, p)
                local ____t_result_145
                if __t(p.mao) then
                    ____t_result_145 = __gt(p.x, 300)
                else
                    ____t_result_145 = p.mao
                end
                return ____t_result_145
            end
        )
        local mastiga = __gt(st.come, 0)
        local bravo = __gt(st.bravo, 0)
        local ____t_result_146
        if __t(mastiga) then
            ____t_result_146 = math.sin(st.t * 30) > 0 and 0.25 or 0.7
        else
            ____t_result_146 = __t(perto) and 1 or 0.55 + math.sin(st.t * 3) * 0.1
        end
        local abre = ____t_result_146
        local pele = __t(bravo) and "#e86a5a" or "#e7a079"
        local sombra = __t(bravo) and "#b8443a" or "#c07a58"
        __L1:R(
            g,
            cx - 30,
            cy + 64,
            60,
            30,
            "#1a4a78"
        )
        __L1:R(
            g,
            cx - 34,
            cy + 70,
            68,
            30,
            "#287eb8"
        )
        __L1:R(
            g,
            cx - 8,
            cy + 64,
            16,
            8,
            "#f2f2ea"
        )
        do
            local y = -58
            while y <= 58 do
                local w = math.floor(math.sqrt(math.max(0, 1 - (y / 60) ^ 2)) * 50 + 0.5)
                __L1:R(
                    g,
                    cx - w - 2,
                    cy + y,
                    w * 2 + 4,
                    1,
                    "#3a2418"
                )
                local ____L1_R_149 = __L1.R
                local ____array_148 = __TS__SparseArrayNew(
                    g,
                    cx - w,
                    cy + y,
                    w * 2,
                    1
                )
                local ____temp_147
                if y > 20 then
                    ____temp_147 = sombra
                else
                    ____temp_147 = pele
                end
                __TS__SparseArrayPush(____array_148, ____temp_147)
                ____L1_R_149(
                    __L1,
                    __TS__SparseArraySpread(____array_148)
                )
                y = y + 1
            end
        end
        for ____, s in __iterar((__arrL({-1, 1}, 2))) do
            __L1:R(
                g,
                cx + s * 52 - 4,
                cy - 6,
                8,
                16,
                pele
            )
            __L1:R(
                g,
                cx + s * 52 - 2,
                cy - 2,
                4,
                8,
                sombra
            )
        end
        __L1:R(
            g,
            cx - 46,
            cy - 60,
            92,
            22,
            "#3a2418"
        )
        do
            local k = 0
            while k < 9 do
                __L1:R(
                    g,
                    cx - 44 + k * 10,
                    cy - 40 + __mod(k, 2) * 4,
                    8,
                    6,
                    "#3a2418"
                )
                k = k + 1
            end
        end
        __L1:R(
            g,
            cx - 40,
            cy - 58,
            30,
            3,
            "#5a3a28"
        )
        for ____, s in __iterar((__arrL({-1, 1}, 2))) do
            local ex = cx + s * 20
            __L1:R(
                g,
                ex - 8,
                cy - 22,
                16,
                13,
                "#ffffff"
            )
            __L1:R(
                g,
                ex - 8,
                cy - 22,
                16,
                1,
                "#3a2418"
            )
            local ol = __t(perto) and 2 or 0
            __L1:R(
                g,
                ex - 3 + ol,
                cy - 19,
                7,
                8,
                "#3a2418"
            )
            __L1:R(
                g,
                ex - 2 + ol,
                cy - 18,
                2,
                2,
                "#ffffff"
            )
            local ____L1_R_154 = __L1.R
            local ____g_152 = g
            local ____temp_153 = ex - 10
            local ____temp_151 = cy - 30
            local ____t_result_150
            if __t(bravo) then
                ____t_result_150 = s > 0 and -3 or 3
            else
                ____t_result_150 = __t(perto) and 4 or 0
            end
            ____L1_R_154(
                __L1,
                ____g_152,
                ____temp_153,
                ____temp_151 - ____t_result_150,
                20,
                3,
                "#3a2418"
            )
            __L1:ell2(
                g,
                ex + s * 6,
                cy + 8,
                9,
                5,
                __t(bravo) and "#c83a3a" or "#f08a7a"
            )
        end
        __L1:R(
            g,
            cx - 4,
            cy - 8,
            8,
            10,
            sombra
        )
        __L1:R(
            g,
            cx - 2,
            cy - 2,
            4,
            3,
            pele
        )
        local mh = math.floor(8 + abre * 30 + 0.5)
        local mw = 34
        __L1:R(
            g,
            cx - mw / 2 - 2,
            cy + 14,
            mw + 4,
            mh + 4,
            "#3a1210"
        )
        __L1:R(
            g,
            cx - mw / 2,
            cy + 16,
            mw,
            mh,
            "#6a1a1a"
        )
        if abre > 0.4 then
            __L1:R(
                g,
                cx - mw / 2 + 2,
                cy + 16,
                mw - 4,
                5,
                "#f6f4ea"
            )
            do
                local k = 0
                while k < 6 do
                    __L1:R(
                        g,
                        cx - mw / 2 + 4 + k * 5,
                        cy + 21,
                        1,
                        2,
                        "#c8c4b8"
                    )
                    k = k + 1
                end
            end
            __L1:ell2(
                g,
                cx,
                cy + 16 + mh - 6,
                12,
                5,
                "#e86a7a"
            )
        end
        if __t(not __t(mastiga) and abre > 0.5) then
            local b = __mod(st.t * 0.8, 1)
            __L1:R(
                g,
                cx + 12,
                cy + 16 + mh,
                2,
                4 + b * 10,
                "#bfe8f0"
            )
        end
        if __t(bravo) then
            do
                local k = 0
                while k < 3 do
                    local u = __mod(st.t * 1.5 + k / 3, 1)
                    __L1:R(
                        g,
                        cx + 30 + k * 6,
                        cy - 50 - u * 20,
                        3,
                        3,
                        "#f2f2f2"
                    )
                    k = k + 1
                end
            end
        end
    end
    __L1.ell2 = function(self, g, x, y, rx, ry, cor)
        do
            local yy = __TS__Number(-ry)
            while __le(yy, ry) do
                local w = math.floor(math.sqrt(math.max(0, 1 - (yy / ry) ^ 2)) * rx + 0.5)
                __L1:R(
                    g,
                    x - w,
                    y + yy,
                    w * 2,
                    1,
                    cor
                )
                yy = yy + 1
            end
        end
    end
    __L1.startGame = function(self, gm, mode)
        __L1.game = gm
        __L1.solo = mode == "solo"
        local ____mode_160 = mode
        local ____temp_159
        if mode == "duo" then
            local ____t_result_158
            if __t(__L1.tv) then
                local ____L1_clamp_157 = __L1.clamp
                local ____temp_156 = __L1.tv:count()
                local ____t_result_155
                if __t(gm.max) then
                    ____t_result_155 = gm.max
                else
                    ____t_result_155 = 2
                end
                ____t_result_158 = ____L1_clamp_157(__L1, ____temp_156, 2, ____t_result_155)
            else
                ____t_result_158 = 2
            end
            ____temp_159 = ____t_result_158
        else
            ____temp_159 = 1
        end
        __L1.st = {
            mode = ____mode_160,
            np = ____temp_159,
            t = 0,
            score = __arrL({0, 0, 0, 0}, 4),
            pop = __arrL({}, 0),
            shake = 0,
            banner = nil,
            ended = nil
        }
        local ____assign_163 = __assign
        local ____L1_st_162 = __L1.st
        local ____t_result_161
        if __t(gm.extra) then
            ____t_result_161 = gm.extra
        else
            ____t_result_161 = {}
        end
        ____assign_163(____L1_st_162, ____t_result_161)
        __L1.st["end"] = function(____, r)
            if not __t(__L1.st.ended) then
                __L1.st.ended = r
                __L1.st.endT = 0
            end
        end
        gm:init(__L1.st)
        __L1.screen = "count"
        __L1.cd = 3.2
        __L1.paused = false
        __call(
            __L1.P,
            "forEach",
            function(____, p)
                local ____arrL_result_164 = __arrL({}, 0)
                p.dirs = ____arrL_result_164
                return ____arrL_result_164
            end
        )
        __L1:sfx("menu")
        local r = __L1:rec(gm.id)
        r.plays = r.plays + 1
        __L1:persist()
    end
    __L1.finish = function(self)
        local r = __L1:rec(__L1.game.id)
        local res = __L1.st.ended
        local fichas = 0
        local medal = 0
        local newMedal = false
        local qualifies = false
        if __t(__L1.st.mode == "solo" or __L1.game.duo == "coop") then
            local ____t_result_165
            if __t(res.score) then
                ____t_result_165 = res.score
            else
                ____t_result_165 = 0
            end
            local score = math.floor(____t_result_165 + 0.5)
            fichas = 1 + math.floor(score / 150)
            if __L1.st.mode == "solo" then
                medal = __len(__call(
                    __L1.game.medals,
                    "filter",
                    function(____, m) return __ge(score, m) end
                ))
                if __gt(medal, r.medal) then
                    r.medal = medal
                    newMedal = true
                    fichas = fichas + medal * 3
                end
            end
            local list = __get(r, __L1.st.mode)
            local ____t_result_168
            local ____t_167 = __t
            local ____temp_166 = score > 0
            __O[1198] = ____temp_166
            if ____t_167(____temp_166) then
                ____t_result_168 = __lt(
                    __len(list),
                    5
                ) or __gt(
                    score,
                    __get(
                        list,
                        __len(list) - 1
                    ).s
                )
            else
                ____t_result_168 = __O[1198]
            end
            qualifies = ____t_result_168
            res.score = score
        else
            fichas = 2
            if __t(res.winner ~= nil and res.winner ~= nil) then
                __inc(r.wins, res.winner, 1, true)
            end
        end
        local ____L1_data_169, ____fichas_170 = __L1.data, "fichas"
        ____L1_data_169[____fichas_170] = ____L1_data_169[____fichas_170] + fichas
        __L1:persist()
        __L1.screen = "over"
        __L1.overSel = 0
        local ____t_result_177
        if __t(qualifies) then
            local ____call_176 = __call
            local ____call_175 = __call
            local ____call_174 = __call
            local ____t_result_173
            local ____t_172 = __t
            local ____temp_171 = window.localStorage:getItem("daroca-fliperama-nome")
            __O[1199] = ____temp_171
            if ____t_172(____temp_171) then
                ____t_result_173 = __O[1199]
            else
                ____t_result_173 = "DRC"
            end
            ____t_result_177 = {
                s = ____call_176(
                    ____call_175(
                        ____call_174(____t_result_173, "slice", 0, 3),
                        "padEnd",
                        3,
                        "A"
                    ),
                    "split",
                    ""
                ),
                i = 0
            }
        else
            ____t_result_177 = nil
        end
        __L1.initials = ____t_result_177
        __L1.st.summary = {fichas = fichas, medal = medal, newMedal = newMedal}
        local ____L1_sfx_185 = __L1.sfx
        local ____t_184 = __t
        local ____t_result_183
        local ____t_179 = __t
        local ____temp_178 = res.win == false
        __O[1201] = ____temp_178
        if ____t_179(____temp_178) then
            ____t_result_183 = __O[1201]
        else
            local ____t_result_182
            local ____t_181 = __t
            local ____temp_180 = __L1.st.mode == "solo" and medal == 0
            __O[1200] = ____temp_180
            if ____t_181(____temp_180) then
                ____t_result_182 = not __t(res.win)
            else
                ____t_result_182 = __O[1200]
            end
            ____t_result_183 = ____t_result_182
        end
        ____L1_sfx_185(
            __L1,
            ____t_184(____t_result_183) and "lose" or "win"
        )
    end
    __L1.saveInitials = function(self)
        local name = __call(__L1.initials.s, "join", "")
        do
            pcall(function()
                window.localStorage:setItem("daroca-fliperama-nome", name)
            end)
        end
        local list = __get(
            __L1:rec(__L1.game.id),
            __L1.st.mode
        )
        __call(
            list,
            "push",
            {
                n = name,
                s = __L1.st.ended.score,
                d = window.Date:now()
            }
        )
        __call(
            list,
            "sort",
            function(____, a, b) return b.s - a.s end
        )
        __call(list, "splice", 5)
        __L1:persist()
        __L1.initials = nil
        __L1:sfx("pick")
    end
    __L1.shopAct = function(self, slot)
        local ____type, price = table.unpack(
            __get(__L1.SHOP, __L1.shopSel),
            1,
            2
        )
        if not __t(__call(__L1.data.unlocked, "includes", ____type)) then
            if slot == 1 then
                __L1.shopMsg = {s = "Compre primeiro com A", t = 1.6}
                __L1:sfx("fake")
                return
            end
            if __lt(__L1.data.fichas, price) then
                __L1.shopMsg = {
                    s = __add(
                        __add("Faltam ", price - __L1.data.fichas),
                        " fichas"
                    ),
                    t = 1.6
                }
                __L1:sfx("lose")
                return
            end
            local ____L1_data_186, ____fichas_187 = __L1.data, "fichas"
            ____L1_data_186[____fichas_187] = ____L1_data_186[____fichas_187] - price
            __call(__L1.data.unlocked, "push", ____type)
            __L1:persist()
            __L1.shopMsg = {
                s = __add(
                    __get(__L1.AV_NAMES, ____type),
                    " liberado!"
                ),
                t = 1.6
            }
            __L1:sfx("win")
            return
        end
        __set(__L1.data.avatar, slot, ____type)
        if __get(__L1.data.avatar, 1 - slot) == ____type then
            __set(
                __L1.data.avatar,
                1 - slot,
                __get(__L1.data.avatar, slot) == "daroca" and "reeis" or "daroca"
            )
        end
        __L1:persist()
        __L1.shopMsg = {
            s = __add(
                __add(
                    __get(__L1.AV_NAMES, ____type),
                    " é o P"
                ),
                slot + 1
            ),
            t = 1.4
        }
        __L1:sfx("pick")
    end
    __L1.openOnline = function(self)
        __L1.screen = "online"
        __L1.onlineSel = 0
        __L1:sfx("menu")
        local ____opt_190 = window.DarocaOnline
        if ____opt_190 ~= nil then
            ____opt_190 = ____opt_190.ready
        end
        if ____opt_190 ~= nil then
            ____opt_190["then"](
                ____opt_190,
                function()
                end
            )
        end
    end
    __L1.startNet = function(self, kind, code)
        if not __t(window.DarocaOnline) then
            return
        end
        if __t(__L1.net) then
            __L1:leaveNet("")
        end
        __L1.onlineSel = 0
        local ____self_195 = window.DarocaOnline
        local ____self_195_connect_196 = ____self_195.connect
        local ____t_result_194
        local ____t_193 = __t
        local ____temp_192 = window.localStorage:getItem("daroca-fliperama-nome")
        __O[1204] = ____temp_192
        if ____t_193(____temp_192) then
            ____t_result_194 = __O[1204]
        else
            ____t_result_194 = "DRC"
        end
        local conn = ____self_195_connect_196(
            ____self_195,
            {
                name = ____t_result_194,
                avatar = __get(__L1.data.avatar, 0)
            }
        )
        local ____conn_198 = conn
        local ____kind_199 = kind
        local ____arrL_result_200 = __arrL({}, 0)
        local ____temp_201 = {x = 0, y = 0, a = false, b = false}
        local ____arrL_result_202 = __arrL({}, 0)
        local ____arrL_result_203 = __arrL({}, 0)
        local ____temp_197
        if kind == "join" then
            ____temp_197 = __add(
                __add("Entrando na sala ", code),
                "…"
            )
        else
            ____temp_197 = "Conectando ao servidor…"
        end
        __L1.net = {
            conn = ____conn_198,
            kind = ____kind_199,
            code = nil,
            role = nil,
            live = false,
            peerOnline = false,
            players = ____arrL_result_200,
            av = nil,
            remote = ____temp_201,
            queue = ____arrL_result_202,
            sfx = ____arrL_result_203,
            seq = 0,
            sent = 0,
            last = "",
            snap = nil,
            msg = ____temp_197,
            joined = false,
            gotOver = false
        }
        conn:on(
            "welcome",
            function()
                local ____t_209 = __t
                local ____t_result_208
                local ____t_207 = __t
                local ____opt_204 = __L1.net
                if ____opt_204 ~= nil then
                    ____opt_204 = ____opt_204.conn
                end
                local ____temp_206 = ____opt_204 ~= conn
                __O[1205] = ____temp_206
                if ____t_207(____temp_206) then
                    ____t_result_208 = __O[1205]
                else
                    ____t_result_208 = __L1.net.joined
                end
                if ____t_209(____t_result_208) then
                    return
                end
                __L1.net.joined = true
                local ____conn_send_212 = conn.send
                local ____temp_211
                if kind == "join" then
                    ____temp_211 = {t = "join", code = code}
                else
                    local ____temp_210
                    if kind == "quick" then
                        ____temp_210 = {t = "quick", kind = "fliperama"}
                    else
                        ____temp_210 = {t = "create", kind = "fliperama", cap = 2}
                    end
                    ____temp_211 = ____temp_210
                end
                ____conn_send_212(conn, ____temp_211)
            end
        )
        conn:on(
            "room",
            function(____, m)
                local ____opt_213 = __L1.net
                if ____opt_213 ~= nil then
                    ____opt_213 = ____opt_213.conn
                end
                if ____opt_213 ~= conn then
                    return
                end
                __L1.net.code = m.code
                __L1.net.players = m.players
                __L1.net.role = m.hostId == conn.id and "host" or "guest"
                __L1.net.live = true
                local bySlot = __call(
                    __arrL({0, 1}, 2),
                    "map",
                    function(____, sl) return __call(
                        m.players,
                        "find",
                        function(____, p) return p.slot == sl end
                    ) end
                )
                local ____L1_net_224 = __L1.net
                local ____arrL_223 = __arrL
                local ____t_result_218
                local ____t_217 = __t
                local ____opt_215 = __get(bySlot, 0)
                if ____opt_215 ~= nil then
                    ____opt_215 = ____opt_215.avatar
                end
                __O[1206] = ____opt_215
                if ____t_217(____opt_215) then
                    ____t_result_218 = __O[1206]
                else
                    ____t_result_218 = "daroca"
                end
                local ____t_result_222
                local ____t_221 = __t
                local ____opt_219 = __get(bySlot, 1)
                if ____opt_219 ~= nil then
                    ____opt_219 = ____opt_219.avatar
                end
                __O[1207] = ____opt_219
                if ____t_221(____opt_219) then
                    ____t_result_222 = __O[1207]
                else
                    ____t_result_222 = "reeis"
                end
                ____L1_net_224.av = ____arrL_223({____t_result_218, ____t_result_222}, 2)
                if __get(__L1.net.av, 0) == __get(__L1.net.av, 1) then
                    __set(
                        __L1.net.av,
                        1,
                        __get(__L1.net.av, 0) == "reeis" and "daroca" or "reeis"
                    )
                end
                local was = __L1.net.peerOnline
                local ____L1_net_228 = __L1.net
                local ____t_result_227
                local ____t_226 = __t
                local ____ge_result_225 = __ge(
                    __len(m.players),
                    2
                )
                __O[1208] = ____ge_result_225
                if ____t_226(____ge_result_225) then
                    ____t_result_227 = __call(
                        m.players,
                        "every",
                        function(____, p) return p.online end
                    )
                else
                    ____t_result_227 = __O[1208]
                end
                ____L1_net_228.peerOnline = ____t_result_227
                local ____L1_net_230 = __L1.net
                local ____t_result_229
                if __t(__L1.net.peerOnline) then
                    ____t_result_229 = __L1.net.role == "host" and "Amigo conectado! Escolha o jogo." or "Conectado! O anfitrião escolhe o jogo."
                else
                    ____t_result_229 = __ge(
                        __len(m.players),
                        2
                    ) and "O amigo caiu. Esperando ele voltar…" or __add(
                        __add("Sala ", m.code),
                        " aberta. Passe o código para o amigo."
                    )
                end
                ____L1_net_230.msg = ____t_result_229
                local ____t_234 = __t
                local ____t_result_233
                local ____t_232 = __t
                local ____temp_231 = not __t(was)
                __O[1209] = ____temp_231
                if ____t_232(____temp_231) then
                    ____t_result_233 = __L1.net.peerOnline
                else
                    ____t_result_233 = __O[1209]
                end
                if ____t_234(____t_result_233) then
                    __L1:sfx("win")
                    if __t(__L1.net.role == "host" and __L1.screen == "online") then
                        __L1.screen = "menu"
                    end
                end
            end
        )
        conn:on(
            "input",
            function(____, m)
                local ____opt_235 = __L1.net
                if ____opt_235 ~= nil then
                    ____opt_235 = ____opt_235.conn
                end
                if ____opt_235 ~= conn then
                    return
                end
                __L1.net.lastIn = window.performance:now()
                __L1.net.remote = m.i
                if __lt(
                    __len(__L1.net.queue),
                    8
                ) then
                    __call(__L1.net.queue, "push", m.i)
                end
            end
        )
        conn:on(
            "state",
            function(____, m)
                local ____t_239 = __t
                local ____opt_237 = __L1.net
                if ____opt_237 ~= nil then
                    ____opt_237 = ____opt_237.conn
                end
                if ____t_239(____opt_237 ~= conn or __L1.net.role ~= "guest") then
                    return
                end
                __L1.net.lastIn = window.performance:now()
                __L1:applySnap(m.d)
            end
        )
        conn:on(
            "error",
            function(____, m)
                local ____opt_240 = __L1.net
                if ____opt_240 ~= nil then
                    ____opt_240 = ____opt_240.conn
                end
                if ____opt_240 ~= conn then
                    return
                end
                __L1.net.msg = m.m
                local ____t_243 = __t
                local ____t_result_242
                if __t(m.fatal) then
                    ____t_result_242 = m.fatal
                else
                    ____t_result_242 = m["end"]
                end
                if ____t_243(____t_result_242) then
                    local msg = m.m
                    __L1:leaveNet(msg)
                end
            end
        )
        conn:on(
            "status",
            function(____, m)
                local ____t_249 = __t
                local ____t_result_248
                local ____t_247 = __t
                local ____opt_244 = __L1.net
                if ____opt_244 ~= nil then
                    ____opt_244 = ____opt_244.conn
                end
                local ____temp_246 = ____opt_244 == conn and not __t(m.online)
                __O[1210] = ____temp_246
                if ____t_247(____temp_246) then
                    ____t_result_248 = __L1.net.live
                else
                    ____t_result_248 = __O[1210]
                end
                if ____t_249(____t_result_248) then
                    __L1.net.msg = "Reconectando…"
                end
            end
        )
    end
    __L1.leaveNet = function(self, msg)
        if not __t(__L1.net) then
            return
        end
        do
            pcall(function()
                __L1.net.conn:close()
            end)
        end
        __L1.net = nil
        __L1.solo = true
        if __L1.screen ~= "online" then
            __L1.screen = "menu"
        end
        if __t(msg) then
            __L1.shopMsg = {s = msg, t = 3}
            __L1.onlineMsg = msg
        end
    end
    __L1.askCode = function(self)
        if not __t(__L1.codeBox) then
            __L1.codeBox = window.document:createElement("form")
            __L1.codeBox.className = "fliperama-code"
            __L1.codeBox.innerHTML = "<label>CÓDIGO DA SALA<input maxlength=\"6\" autocomplete=\"off\" autocapitalize=\"characters\" spellcheck=\"false\" inputmode=\"text\"></label><button type=\"submit\">ENTRAR</button><button type=\"button\" class=\"fp-cancel\">VOLTAR</button>"
            __L1.root:append(__L1.codeBox)
            local inp = __L1.codeBox:querySelector("input")
            inp:addEventListener(
                "input",
                function()
                    inp.value = __call(
                        __re_replace(
                            __call(inp.value, "toUpperCase"),
                            __re("[^A-Z0-9]", "g"),
                            ""
                        ),
                        "slice",
                        0,
                        6
                    )
                end
            )
            inp:addEventListener(
                "keydown",
                function(____, e) return e:stopPropagation() end,
                true
            )
            __L1.codeBox:addEventListener(
                "submit",
                function(____, e)
                    e:preventDefault()
                    local v = inp.value
                    if __len(v) == 6 then
                        __L1.codeBox.hidden = true
                        __L1:startNet("join", v)
                        __L1.cv:focus()
                    end
                end
            )
            __L1.codeBox:querySelector(".fp-cancel"):addEventListener(
                "click",
                function()
                    __L1.codeBox.hidden = true
                    __L1.cv:focus()
                end
            )
        end
        __L1.codeBox.hidden = false
        local inp = __L1.codeBox:querySelector("input")
        inp.value = ""
        window:setTimeout(
            function() return inp:focus() end,
            30
        )
    end
    __L1.onlineAct = function(self, i)
        __L1:sfx("menu")
        __L1.onlineMsg = ""
        local ____t_251 = __t
        local ____t_result_250
        if __t(__L1.net) then
            ____t_result_250 = __L1.net.live
        else
            ____t_result_250 = __L1.net
        end
        if ____t_251(____t_result_250) then
            local ____t_255 = __t
            local ____t_result_254
            local ____t_253 = __t
            local ____temp_252 = i == 0 and __L1.net.role == "host"
            __O[1211] = ____temp_252
            if ____t_253(____temp_252) then
                ____t_result_254 = __L1.net.peerOnline
            else
                ____t_result_254 = __O[1211]
            end
            if ____t_255(____t_result_254) then
                __L1.screen = "menu"
            else
                __L1:leaveNet("")
            end
            return
        end
        if i == 0 then
            __L1:startNet("create")
        elseif i == 1 then
            __L1:askCode()
        elseif i == 2 then
            __L1:startNet("quick")
        elseif i == 3 then
            local ____t_result_262
            local ____t_261 = __t
            local ____opt_258 = window.DarocaOnline
            if ____opt_258 ~= nil then
                ____opt_258 = ____opt_258.configured
            end
            local ____opt_result_260
            if ____opt_258 ~= nil then
                ____opt_result_260 = ____opt_258(____opt_258)
            end
            __O[1212] = ____opt_result_260
            if ____t_261(____opt_result_260) then
                ____t_result_262 = __O[1212]
            else
                ____t_result_262 = ""
            end
            local cur = ____t_result_262
            local v = window:prompt("Endereço do servidor online (ex.: https://meu-servidor.fly.dev). Deixe vazio para usar o padrão.", cur)
            if v ~= nil then
                __callq(window.DarocaOnline, "set", v)
                __L1.onlineMsg = __t(v) and "Servidor salvo neste aparelho." or "Usando o servidor padrão."
            end
        else
            if __t(__L1.net) then
                __L1:leaveNet("")
            end
            __L1.screen = "menu"
        end
    end
    __L1.updateOnline = function(self, dirs, ap)
        local ____t_264 = __t
        local ____t_result_263
        if __t(__L1.codeBox) then
            ____t_result_263 = not __t(__L1.codeBox.hidden)
        else
            ____t_result_263 = __L1.codeBox
        end
        if ____t_264(____t_result_263) then
            return
        end
        local ____t_266 = __t
        local ____t_result_265
        if __t(__L1.net) then
            ____t_result_265 = __L1.net.live
        else
            ____t_result_265 = __L1.net
        end
        local n = ____t_266(____t_result_265) and 2 or __len(__L1.ONLINE_OPTS)
        for ____, d in __iterar((dirs)) do
            if __t(d == "u" or d == "l") then
                __L1.onlineSel = __mod(__L1.onlineSel + n - 1, n)
                __L1:sfx("move")
            end
            if __t(d == "d" or d == "r") then
                __L1.onlineSel = __mod(__L1.onlineSel + 1, n)
                __L1:sfx("move")
            end
        end
        if __t(ap) then
            __L1:onlineAct(__L1.onlineSel)
        end
    end
    __L1.drawOnline = function(self, c)
        __L1:R(
            c,
            0,
            0,
            __L1.W,
            __L1.H,
            "#14121c"
        )
        do
            local i = 0
            while i < 30 do
                __L1:R(
                    c,
                    __bor(
                        __L1:hash(i + 3) * __L1.W,
                        0
                    ),
                    __bor(
                        __L1:hash(i + 7) * __L1.H,
                        0
                    ),
                    2,
                    2,
                    ("rgba(160,220,255," .. tostring(0.2 + 0.3 * math.sin(__L1.t * 2 + i))) .. ")"
                )
                i = i + 1
            end
        end
        __L1:frame(
            c,
            230,
            18,
            500,
            64,
            "#102030",
            "#7ad1ff",
            "#2a4a6a"
        )
        __L1:txt(
            c,
            "FLIPERAMA ONLINE",
            __L1.W / 2,
            42,
            22,
            "#d8f0ff"
        )
        __L1:txt(
            c,
            "dupla pela internet · cada um no seu aparelho",
            __L1.W / 2,
            66,
            9,
            "#a8d0f0",
            "center",
            nil
        )
        local ____t_result_280
        local ____t_272 = __t
        local ____opt_269 = window.DarocaOnline
        if ____opt_269 ~= nil then
            ____opt_269 = ____opt_269.sameOrigin
        end
        local ____opt_result_271
        if ____opt_269 ~= nil then
            ____opt_result_271 = ____opt_269(____opt_269)
        end
        if ____t_272(____opt_result_271) then
            ____t_result_280 = "este site"
        else
            local ____t_result_279
            local ____t_278 = __t
            local ____opt_275 = window.DarocaOnline
            if ____opt_275 ~= nil then
                ____opt_275 = ____opt_275.configured
            end
            local ____opt_result_277
            if ____opt_275 ~= nil then
                ____opt_result_277 = ____opt_275(____opt_275)
            end
            __O[1213] = ____opt_result_277
            if ____t_278(____opt_result_277) then
                ____t_result_279 = __O[1213]
            else
                ____t_result_279 = "nenhum"
            end
            ____t_result_280 = ____t_result_279
        end
        local srv = ____t_result_280
        __L1:txt(
            c,
            __add(
                "SERVIDOR: ",
                __re_replace(
                    srv,
                    __re("^https?:\\/\\/", ""),
                    ""
                )
            ),
            __L1.W / 2,
            102,
            9,
            srv == "nenhum" and "#ff9a8a" or "#8ad070",
            "center",
            nil
        )
        local ____t_282 = __t
        local ____t_result_281
        if __t(__L1.net) then
            ____t_result_281 = __L1.net.live
        else
            ____t_result_281 = __L1.net
        end
        if ____t_282(____t_result_281) then
            __L1:frame(
                c,
                300,
                128,
                360,
                120,
                "#1e1a10",
                "#ffd75a",
                "#4a3a20"
            )
            __L1:txt(
                c,
                "CÓDIGO DA SALA",
                __L1.W / 2,
                152,
                10,
                "#e8d8b0"
            )
            local ____L1_txt_285 = __L1.txt
            local ____c_284 = c
            local ____t_result_283
            if __t(__L1.net.code) then
                ____t_result_283 = __L1.net.code
            else
                ____t_result_283 = "······"
            end
            ____L1_txt_285(
                __L1,
                ____c_284,
                ____t_result_283,
                __L1.W / 2,
                200,
                40,
                "#fff3a0",
                "center",
                "#6a4a10"
            )
            local ps = __call(
                __arrL({0, 1}, 2),
                "map",
                function(____, sl) return __call(
                    __L1.net.players,
                    "find",
                    function(____, p) return p.slot == sl end
                ) end
            )
            __call(
                ps,
                "forEach",
                function(____, pl, i)
                    local x = __t(i) and 640 or 320
                    local ____L1_hero_297 = __L1.hero
                    local ____c_296 = c
                    local ____t_result_288
                    local ____t_287 = __t
                    local ____getq_result_286 = __getq(__L1.net.av, i)
                    __O[1214] = ____getq_result_286
                    if ____t_287(____getq_result_286) then
                        ____t_result_288 = __O[1214]
                    else
                        ____t_result_288 = __t(i) and "reeis" or "daroca"
                    end
                    local ____L1_t_294 = __L1.t
                    local ____t_292 = __t
                    local ____opt_result_291
                    if pl ~= nil then
                        ____opt_result_291 = pl.online
                    end
                    local ____temp_295 = ____t_292(____opt_result_291) and "friend" or nil
                    local ____t_result_293
                    if __t(pl) then
                        ____t_result_293 = __t(pl.online) and 1 or 0.4
                    else
                        ____t_result_293 = 0.15
                    end
                    ____L1_hero_297(
                        __L1,
                        ____c_296,
                        ____t_result_288,
                        x,
                        370,
                        {scale = 1.3, frame = ____L1_t_294, emotion = ____temp_295, opacity = ____t_result_293}
                    )
                    local ____L1_txt_300 = __L1.txt
                    local ____c_299 = c
                    local ____t_result_298
                    if __t(pl) then
                        ____t_result_298 = __add(
                            i == 0 and "ANFITRIÃO" or "CONVIDADO",
                            __t(pl.online) and "" or " (caiu)"
                        )
                    else
                        ____t_result_298 = "esperando…"
                    end
                    ____L1_txt_300(
                        __L1,
                        ____c_299,
                        ____t_result_298,
                        x,
                        392,
                        10,
                        __get(__L1.PLAYER_COL, i)
                    )
                end
            )
            __L1:txt(
                c,
                __L1.net.msg,
                __L1.W / 2,
                420,
                12,
                "#fff"
            )
            local ____L1_button_306 = __L1.button
            local ____c_305 = c
            local ____t_304 = __t
            local ____t_result_303
            local ____t_302 = __t
            local ____temp_301 = __L1.net.role == "host"
            __O[1215] = ____temp_301
            if ____t_302(____temp_301) then
                ____t_result_303 = __L1.net.peerOnline
            else
                ____t_result_303 = __O[1215]
            end
            ____L1_button_306(
                __L1,
                ____c_305,
                ____t_304(____t_result_303) and "ESCOLHER JOGO" or "AGUARDANDO…",
                300,
                452,
                200,
                52,
                __L1.onlineSel == 0,
                function() return __L1:onlineAct(0) end
            )
            __L1:button(
                c,
                "SAIR DA SALA",
                520,
                452,
                160,
                52,
                __L1.onlineSel == 1,
                function() return __L1:onlineAct(1) end
            )
        else
            __call(
                __L1.ONLINE_OPTS,
                "forEach",
                function(____, l, i) return __L1:button(
                    c,
                    l,
                    330,
                    128 + i * 64,
                    300,
                    54,
                    __L1.onlineSel == i,
                    function()
                        __L1.onlineSel = i
                        __L1:onlineAct(i)
                    end
                ) end
            )
            local ____L1_txt_310 = __L1.txt
            local ____c_309 = c
            local ____t_result_308
            if __t(__L1.net) then
                ____t_result_308 = __L1.net.msg
            else
                local ____t_result_307
                if __t(__L1.onlineMsg) then
                    ____t_result_307 = __L1.onlineMsg
                else
                    ____t_result_307 = "Crie uma sala e passe o código, ou entre na sala do amigo."
                end
                ____t_result_308 = ____t_result_307
            end
            ____L1_txt_310(
                __L1,
                ____c_309,
                ____t_result_308,
                __L1.W / 2,
                466,
                11,
                "#e8d8b0",
                "center",
                nil
            )
            __L1:txt(
                c,
                "Sem servidor ainda? Veja docs/SERVIDOR-ONLINE.md para colocar um no ar de graça.",
                __L1.W / 2,
                500,
                9,
                "#8a8aa8",
                "center",
                nil
            )
        end
    end
    __L1.hostTick = function(self, now)
        local ____t_314 = __t
        local ____t_result_313
        local ____t_312 = __t
        local ____temp_311 = not __t(__L1.net) or not __t(__L1.net.live)
        __O[1216] = ____temp_311
        if ____t_312(____temp_311) then
            ____t_result_313 = __O[1216]
        else
            ____t_result_313 = now - __L1.net.sent < 33
        end
        if ____t_314(____t_result_313) then
            return
        end
        __L1.net.sent = now
        local ____t_result_321
        local ____t_320 = __t
        local ____t_result_319
        local ____t_318 = __t
        local ____t_result_317
        local ____t_316 = __t
        local ____temp_315 = __L1.screen == "play" or __L1.screen == "count"
        __O[1217] = ____temp_315
        if ____t_316(____temp_315) then
            ____t_result_317 = __O[1217]
        else
            ____t_result_317 = __L1.screen == "over"
        end
        __O[1218] = ____t_result_317
        if ____t_318(____t_result_317) then
            ____t_result_319 = __L1.st
        else
            ____t_result_319 = __O[1218]
        end
        __O[1219] = ____t_result_319
        if ____t_320(____t_result_319) then
            ____t_result_321 = __L1.game
        else
            ____t_result_321 = __O[1219]
        end
        local playing = ____t_result_321
        local d
        if __t(playing) then
            d = {
                scr = __L1.screen,
                g = __L1.game.id,
                m = __L1.st.mode,
                cd = __L1.cd,
                av = __L1.net.av,
                st = window.JSON:parse(window.JSON:stringify(
                    __L1.st,
                    function(____, k, v)
                        local ____t_result_329
                        local ____t_328 = __t
                        local ____t_result_327
                        local ____t_323 = __t
                        local ____temp_322 = type(v) == "function"
                        __O[1221] = ____temp_322
                        if ____t_323(____temp_322) then
                            ____t_result_327 = __O[1221]
                        else
                            local ____t_result_326
                            local ____t_325 = __t
                            local ____temp_324 = k == "fx" and __isArray(v)
                            __O[1220] = ____temp_324
                            if ____t_325(____temp_324) then
                                ____t_result_326 = __len(v) > 40
                            else
                                ____t_result_326 = __O[1220]
                            end
                            ____t_result_327 = ____t_result_326
                        end
                        if ____t_328(____t_result_327) then
                            ____t_result_329 = nil
                        else
                            ____t_result_329 = v
                        end
                        return ____t_result_329
                    end
                )),
                sfx = __call(__L1.net.sfx, "splice", 0),
                away = not __t(__L1:peerLive())
            }
        else
            local ____opt_330 = __get(__L1.GAMES, __L1.sel)
            if ____opt_330 ~= nil then
                ____opt_330 = ____opt_330.id
            end
            d = {
                scr = "wait",
                g = ____opt_330,
                what = __L1.screen,
                av = __L1.net.av,
                sfx = __call(__L1.net.sfx, "splice", 0)
            }
        end
        local ____self_335 = __L1.net.conn
        local ____self_335_send_336 = ____self_335.send
        local ____L1_net_332, ____seq_333 = __L1.net, "seq"
        local ____L1_net_seq_334 = ____L1_net_332[____seq_333] + 1
        ____L1_net_332[____seq_333] = ____L1_net_seq_334
        ____self_335_send_336(____self_335, {t = "state", s = ____L1_net_seq_334, d = d})
    end
    __L1.guestTick = function(self)
        local ____t_339 = __t
        local ____temp_338 = window.performance:now()
        local ____t_result_337
        if __t(__L1.net.lastIn) then
            ____t_result_337 = __L1.net.lastIn
        else
            ____t_result_337 = window.performance:now()
        end
        if ____t_339(____temp_338 - ____t_result_337 > 4000 and not __t(__L1.net.kicked)) then
            __L1.net.kicked = true
            __L1.net.stale = true
            local ____this_341
            ____this_341 = __L1.net.conn
            local ____opt_340 = ____this_341.kick
            if ____opt_340 ~= nil then
                ____opt_340(____this_341)
            end
            window:setTimeout(
                function()
                    if __t(__L1.net) then
                        __L1.net.kicked = false
                    end
                end,
                4000
            )
        end
        local p = __get(__L1.P, 0)
        local i = {x = p.x, y = p.y, a = p.a, b = p.b}
        local key = window.JSON:stringify(i)
        local now = window.performance:now()
        if __t(key ~= __L1.net.last or now - __L1.net.sent > 100) then
            __L1.net.last = key
            __L1.net.sent = now
            local ____self_345 = __L1.net.conn
            local ____self_345_send_346 = ____self_345.send
            local ____L1_net_342, ____seq_343 = __L1.net, "seq"
            local ____L1_net_seq_344 = ____L1_net_342[____seq_343] + 1
            ____L1_net_342[____seq_343] = ____L1_net_seq_344
            ____self_345_send_346(____self_345, {t = "input", s = ____L1_net_seq_344, i = i})
        end
        __call(
            __L1.P,
            "forEach",
            function(____, q)
                local ____arrL_result_347 = __arrL({}, 0)
                q.dirs = ____arrL_result_347
                return ____arrL_result_347
            end
        )
    end
    __L1.applySnap = function(self, d)
        if __t(not __t(d) or type(d) ~= "table") then
            return
        end
        __L1.net.snap = d
        if __isArray(d.av) then
            __L1.net.av = d.av
        end
        local ____iter_350 = __iter
        local ____call_349 = __call
        local ____t_result_348
        if __t(d.sfx) then
            ____t_result_348 = d.sfx
        else
            ____t_result_348 = __arrL({}, 0)
        end
        for ____, n in __TS__Iterator(____iter_350(____call_349(____t_result_348, "slice", 0, 8))) do
            local keep = __L1.net.role
            __L1.net.role = "x"
            __L1:sfx(tostring(n))
            __L1.net.role = keep
        end
        if __t(__L1.net.stale) then
            __L1.net.stale = false
        end
        if d.scr == "wait" then
            if __L1.screen ~= "online" then
                __L1.screen = "guestwait"
            end
            local ____t_result_353
            local ____t_352 = __t
            local ____t_result_351
            if __t(__L1.st) then
                ____t_result_351 = __L1.screen == "over"
            else
                ____t_result_351 = __L1.st
            end
            if ____t_352(____t_result_351) then
                ____t_result_353 = __L1.st
            else
                ____t_result_353 = __L1.st
            end
            __L1.st = ____t_result_353
            local ____t_result_356
            local ____t_355 = __t
            local ____call_result_354 = __call(
                __L1.GAMES,
                "find",
                function(____, g2) return g2.id == d.g end
            )
            __O[1222] = ____call_result_354
            if ____t_355(____call_result_354) then
                ____t_result_356 = __O[1222]
            else
                ____t_result_356 = __L1.game
            end
            __L1.game = ____t_result_356
            __L1.net.waitWhat = d.what
            __L1.net.gotOver = false
            return
        end
        local gm = __call(
            __L1.GAMES,
            "find",
            function(____, g2) return g2.id == d.g end
        )
        if __t(not __t(gm) or not __t(d.st)) then
            return
        end
        __L1.game = gm
        __L1.st = d.st
        __L1.st["end"] = function()
        end
        local ____L1_st_358 = __L1.st
        local ____t_result_357
        if __t(__L1.st.pop) then
            ____t_result_357 = __L1.st.pop
        else
            ____t_result_357 = __arrL({}, 0)
        end
        ____L1_st_358.pop = ____t_result_357
        local ____t_result_361
        local ____t_360 = __t
        local ____TS__Number_result_359 = __TS__Number(d.cd)
        __O[1223] = ____TS__Number_result_359
        if ____t_360(____TS__Number_result_359) then
            ____t_result_361 = __O[1223]
        else
            ____t_result_361 = 0
        end
        __L1.cd = ____t_result_361
        __L1.screen = d.scr
        __L1.paused = false
        __L1.solo = true
        if __t(d.scr == "over" and not __t(__L1.net.gotOver)) then
            __L1.net.gotOver = true
            local ____L1_data_362, ____fichas_363 = __L1.data, "fichas"
            ____L1_data_362[____fichas_363] = ____L1_data_362[____fichas_363] + 2
            __L1:persist()
        end
    end
    __L1.drawNetBar = function(self, c)
        local on = __L1.net.conn.online
        local ping = __L1.net.conn.ping
        c:save()
        c.fillStyle = "rgba(10,14,24,.75)"
        c:fillRect(__L1.W / 2 - 150, __L1.H - 22, 300, 20)
        local ____L1_txt_370 = __L1.txt
        local ____array_369 = __TS__SparseArrayNew(c)
        local ____add_367 = __add
        local ____t_result_364
        if __t(__L1.net.code) then
            ____t_result_364 = __add(
                __add("SALA ", __L1.net.code),
                " · "
            )
        else
            ____t_result_364 = ""
        end
        local ____t_result_366
        if __t(on) then
            local ____temp_365
            if ping ~= nil then
                ____temp_365 = __add(
                    __add("PING ", ping),
                    " ms"
                )
            else
                ____temp_365 = "ONLINE"
            end
            ____t_result_366 = ____temp_365
        else
            ____t_result_366 = "RECONECTANDO…"
        end
        __TS__SparseArrayPush(
            ____array_369,
            ____add_367(____t_result_364, ____t_result_366),
            __L1.W / 2,
            __L1.H - 12,
            9
        )
        local ____t_result_368
        if __t(on) then
            ____t_result_368 = __gt(ping, 180) and "#ffb347" or "#8ad070"
        else
            ____t_result_368 = "#ff9a8a"
        end
        __TS__SparseArrayPush(____array_369, ____t_result_368, "center", nil)
        ____L1_txt_370(
            __L1,
            __TS__SparseArraySpread(____array_369)
        )
        local ____t_380 = __t
        local ____t_result_379
        local ____t_378 = __t
        local ____t_result_377
        local ____t_376 = __t
        local ____t_result_375
        local ____t_374 = __t
        local ____t_result_373
        local ____t_372 = __t
        local ____temp_371 = __L1.net.role == "host"
        __O[1224] = ____temp_371
        if ____t_372(____temp_371) then
            ____t_result_373 = __L1.net.live
        else
            ____t_result_373 = __O[1224]
        end
        __O[1225] = ____t_result_373
        if ____t_374(____t_result_373) then
            ____t_result_375 = not __t(__L1:peerLive())
        else
            ____t_result_375 = __O[1225]
        end
        __O[1226] = ____t_result_375
        if ____t_376(____t_result_375) then
            ____t_result_377 = __ge(
                __len(__L1.net.players),
                2
            )
        else
            ____t_result_377 = __O[1226]
        end
        __O[1227] = ____t_result_377
        if ____t_378(____t_result_377) then
            ____t_result_379 = __L1.screen == "play" or __L1.screen == "count"
        else
            ____t_result_379 = __O[1227]
        end
        if ____t_380(____t_result_379) then
            c.fillStyle = "rgba(10,8,12,.6)"
            c:fillRect(0, 200, __L1.W, 90)
            __L1:txt(
                c,
                "O AMIGO CAIU · ESPERANDO ELE VOLTAR",
                __L1.W / 2,
                245,
                18,
                "#fff3a0"
            )
        end
        local ____t_393 = __t
        local ____t_result_392
        local ____t_382 = __t
        local ____temp_381 = __L1.net.role == "guest"
        __O[1230] = ____temp_381
        if ____t_382(____temp_381) then
            local ____t_result_391
            local ____t_385 = __t
            local ____opt_383 = __L1.net.snap
            if ____opt_383 ~= nil then
                ____opt_383 = ____opt_383.away
            end
            __O[1229] = ____opt_383
            if ____t_385(____opt_383) then
                ____t_result_391 = __O[1229]
            else
                local ____t_result_390
                local ____t_389 = __t
                local ____temp_387 = window.performance:now()
                local ____t_result_386
                if __t(__L1.net.lastIn) then
                    ____t_result_386 = __L1.net.lastIn
                else
                    ____t_result_386 = window.performance:now()
                end
                local ____temp_388 = ____temp_387 - ____t_result_386 > 1500
                __O[1228] = ____temp_388
                if ____t_389(____temp_388) then
                    ____t_result_390 = __L1.screen == "play" or __L1.screen == "count"
                else
                    ____t_result_390 = __O[1228]
                end
                ____t_result_391 = ____t_result_390
            end
            ____t_result_392 = ____t_result_391
        else
            ____t_result_392 = __O[1230]
        end
        if ____t_393(____t_result_392) then
            c.fillStyle = "rgba(10,8,12,.6)"
            c:fillRect(0, 200, __L1.W, 90)
            __L1:txt(
                c,
                "RECONECTANDO COM O ANFITRIÃO…",
                __L1.W / 2,
                245,
                18,
                "#fff3a0"
            )
        end
        c:restore()
    end
    __L1.tvTarget = function(self)
        local T = window.DAROCA_TV
        local ____t_395 = __t
        local ____t_result_394
        if __t(T) then
            ____t_result_394 = T.port
        else
            ____t_result_394 = T
        end
        if ____t_395(____t_result_394) then
            local ____add_result_398 = __add(
                __add("ws://127.0.0.1:", T.port),
                "/ws"
            )
            local ____add_397 = __add
            local ____t_result_396
            if __t(T.ip) then
                ____t_result_396 = __add(
                    __add(
                        __add("http://", T.ip),
                        ":"
                    ),
                    T.port
                )
            else
                ____t_result_396 = ""
            end
            return {
                ws = ____add_result_398,
                join = ____add_397(____t_result_396, "/controle.html")
            }
        end
        local O = window.DarocaOnline
        if not __t(O) then
            return nil
        end
        local ____t_result_399
        if __t(O:sameOrigin()) then
            ____t_result_399 = window.location.origin
        else
            ____t_result_399 = O:base()
        end
        local base = ____t_result_399
        if not __t(base) then
            return nil
        end
        return {
            ws = __add(
                __re_replace(
                    base,
                    __re("^http", ""),
                    "ws"
                ),
                "/ws"
            ),
            join = __add(base, "/controle.html")
        }
    end
    __L1.openTV = function(self)
        if __t(__L1.net) then
            __L1:leaveNet("")
        end
        __L1.screen = "tv"
        __L1:sfx("menu")
        if __t(__L1.tv) then
            return
        end
        local ____t_result_433
        local ____t_432 = __t
        local ____opt_430 = window.DarocaOnline
        if ____opt_430 ~= nil then
            ____opt_430 = ____opt_430.ready
        end
        __O[1231] = ____opt_430
        if ____t_432(____opt_430) then
            ____t_result_433 = __O[1231]
        else
            ____t_result_433 = __TS__Promise.resolve()
        end
        local ____self_429 = ____t_result_433
        ____self_429["then"](
            ____self_429,
            function()
                local target = __L1:tvTarget()
                if not __t(target) then
                    __L1.tvMsg = "Sem servidor: abra o jogo pelo app da Android TV ou configure o servidor online (docs/MODO-TV.md)."
                    return
                end
                local conn = window.DarocaOnline:connect({name = "TV", avatar = "daroca", url = target.ws})
                __L1.tv = {
                    conn = conn,
                    code = nil,
                    joinUrl = target.join,
                    phones = __arrL({}, 0),
                    av = __arrL({}, 0),
                    q = __arrL(
                        {
                            __arrL({}, 0),
                            __arrL({}, 0),
                            __arrL({}, 0),
                            __arrL({}, 0)
                        },
                        4
                    ),
                    last = __arr(nil, nil, nil, nil),
                    qr = nil,
                    sent = false,
                    count = function(self)
                        return math.max(
                            1,
                            __len(__call(
                                self.phones,
                                "filter",
                                function(____, p) return p.online end
                            ))
                        )
                    end,
                    take = function(self, i)
                        local q = __get(self.q, i)
                        if __t(__len(q)) then
                            __set(
                                self.last,
                                i,
                                __call(q, "shift")
                            )
                        end
                        return __get(self.last, i)
                    end,
                    send = function(self, e)
                        self.conn:send({t = "event", e = e})
                    end
                }
                conn:on(
                    "welcome",
                    function()
                        local ____t_405 = __t
                        local ____t_result_404
                        local ____t_403 = __t
                        local ____opt_400 = __L1.tv
                        if ____opt_400 ~= nil then
                            ____opt_400 = ____opt_400.conn
                        end
                        local ____temp_402 = ____opt_400 ~= conn
                        __O[1232] = ____temp_402
                        if ____t_403(____temp_402) then
                            ____t_result_404 = __O[1232]
                        else
                            ____t_result_404 = __L1.tv.sent
                        end
                        if ____t_405(____t_result_404) then
                            return
                        end
                        __L1.tv.sent = true
                        conn:send({t = "create", kind = "tv", cap = 5})
                    end
                )
                conn:on(
                    "room",
                    function(____, m)
                        local ____opt_406 = __L1.tv
                        if ____opt_406 ~= nil then
                            ____opt_406 = ____opt_406.conn
                        end
                        if ____opt_406 ~= conn then
                            return
                        end
                        __L1.tv.code = m.code
                        local before = __len(__L1.tv.phones)
                        __L1.tv.phones = __call(
                            __call(
                                __call(
                                    m.players,
                                    "filter",
                                    function(____, p) return p.id ~= m.hostId end
                                ),
                                "sort",
                                function(____, a, b) return a.slot - b.slot end
                            ),
                            "slice",
                            0,
                            4
                        )
                        __call(
                            __L1.tv.phones,
                            "forEach",
                            function(____, p, i)
                                p.index = i
                                if __t(not __t(__get(__L1.tv.av, i)) or not __t(__get(__L1.tv.av, i).fixed)) then
                                    local ____set_411 = __set
                                    local ____L1_tv_av_409 = __L1.tv.av
                                    local ____i_410 = i
                                    local ____t_result_408
                                    if __t(__get(__L1.AV_NAMES, p.avatar)) then
                                        ____t_result_408 = p.avatar
                                    else
                                        ____t_result_408 = __get(__L1.DEF_AV, i)
                                    end
                                    ____set_411(____L1_tv_av_409, ____i_410, {type = ____t_result_408})
                                end
                            end
                        )
                        __L1.tv.av = __call(
                            __L1.tv.av,
                            "slice",
                            0,
                            __len(__L1.tv.phones)
                        )
                        if __gt(
                            __len(__L1.tv.phones),
                            before
                        ) then
                            __L1:sfx("pick")
                        end
                        __call(
                            __L1.tv.phones,
                            "forEach",
                            function(____, p, i) return __L1.tv:send({
                                kind = "you",
                                to = p.id,
                                n = i + 1,
                                color = __get(__L1.PLAYER_COL, i),
                                avatar = __get(__L1.tv.av, i).type
                            }) end
                        )
                        __L1.tvMsg = __t(__len(__L1.tv.phones)) and "Aperte A no celular do P1 (ou OK no controle remoto) para escolher o jogo." or "Aponte a câmera do celular para o QR code."
                        local ____t_417 = __t
                        local ____t_result_416
                        local ____t_415 = __t
                        local ____t_result_414
                        local ____t_413 = __t
                        local ____temp_412 = not __t(__L1.tv.qr)
                        __O[1233] = ____temp_412
                        if ____t_413(____temp_412) then
                            ____t_result_414 = window.qrcode
                        else
                            ____t_result_414 = __O[1233]
                        end
                        __O[1234] = ____t_result_414
                        if ____t_415(____t_result_414) then
                            ____t_result_416 = __L1.tv.code
                        else
                            ____t_result_416 = __O[1234]
                        end
                        if ____t_417(____t_result_416) then
                            do
                                pcall(function()
                                    local q = window:qrcode(0, "M")
                                    q:addData(__add(
                                        __add(__L1.tv.joinUrl, "?sala="),
                                        __L1.tv.code
                                    ))
                                    q:make()
                                    __L1.tv.qr = q
                                end)
                            end
                        end
                    end
                )
                conn:on(
                    "input",
                    function(____, m)
                        local ____opt_418 = __L1.tv
                        if ____opt_418 ~= nil then
                            ____opt_418 = ____opt_418.conn
                        end
                        if ____opt_418 ~= conn then
                            return
                        end
                        local i = __call(
                            __L1.tv.phones,
                            "findIndex",
                            function(____, p) return p.id == m.from end
                        )
                        if __t(__ge(i, 0) and __lt(
                            __len(__get(__L1.tv.q, i)),
                            10
                        )) then
                            __call(
                                __get(__L1.tv.q, i),
                                "push",
                                m.i
                            )
                        end
                    end
                )
                conn:on(
                    "event",
                    function(____, m)
                        local ____t_422 = __t
                        local ____opt_420 = __L1.tv
                        if ____opt_420 ~= nil then
                            ____opt_420 = ____opt_420.conn
                        end
                        if ____t_422(____opt_420 ~= conn or not __t(m.e)) then
                            return
                        end
                        local i = __call(
                            __L1.tv.phones,
                            "findIndex",
                            function(____, p) return p.id == m.from end
                        )
                        local ____t_426 = __t
                        local ____t_result_425
                        local ____t_424 = __t
                        local ____temp_423 = __ge(i, 0) and m.e.kind == "pick"
                        __O[1235] = ____temp_423
                        if ____t_424(____temp_423) then
                            ____t_result_425 = __get(__L1.AV_NAMES, m.e.avatar)
                        else
                            ____t_result_425 = __O[1235]
                        end
                        if ____t_426(____t_result_425) then
                            __set(__L1.tv.av, i, {type = m.e.avatar, fixed = true})
                            __L1:sfx("move")
                            __L1.tv:send({
                                kind = "you",
                                to = m.from,
                                n = i + 1,
                                color = __get(__L1.PLAYER_COL, i),
                                avatar = m.e.avatar
                            })
                        end
                    end
                )
                conn:on(
                    "error",
                    function(____, m)
                        local ____opt_427 = __L1.tv
                        if ____opt_427 ~= nil then
                            ____opt_427 = ____opt_427.conn
                        end
                        if ____opt_427 == conn then
                            __L1.tvMsg = m.m
                        end
                    end
                )
            end
        )
    end
    __L1.closeTV = function(self)
        if not __t(__L1.tv) then
            return
        end
        do
            pcall(function()
                __L1.tv.conn:close()
            end)
        end
        __L1.tv = nil
        __L1.tvLastScreen = ""
    end
    __L1.tvBuzz = function(self, name)
        if __t(not __t(__L1.tv) or not __t(__len(__L1.tv.phones))) then
            return
        end
        local ms = __get(
            {
                hit = 60,
                lose = __arrL({80, 40, 80}, 3),
                win = __arrL({
                    30,
                    30,
                    30,
                    30,
                    60
                }, 5),
                power = 25
            },
            name
        )
        if __t(ms) then
            __L1.tv:send({kind = "buzz", ms = ms})
        end
    end
    __L1.tvSync = function(self)
        if not __t(__L1.tv) then
            return
        end
        local ____add_445 = __add
        local ____add_440 = __add
        local ____add_439 = __add
        local ____add_result_438 = __add(__L1.screen, "|")
        local ____t_result_437
        local ____t_436 = __t
        local ____opt_434 = __L1.game
        if ____opt_434 ~= nil then
            ____opt_434 = ____opt_434.id
        end
        __O[1236] = ____opt_434
        if ____t_436(____opt_434) then
            ____t_result_437 = __O[1236]
        else
            ____t_result_437 = ""
        end
        local ____add_440_result_444 = ____add_440(
            ____add_439(____add_result_438, ____t_result_437),
            "|"
        )
        local ____t_443 = __t
        local ____opt_441 = __L1.st
        if ____opt_441 ~= nil then
            ____opt_441 = ____opt_441.ended
        end
        local key = ____add_445(
            ____add_440_result_444,
            ____t_443(____opt_441) and 1 or 0
        )
        if key == __L1.tvLastScreen then
            return
        end
        __L1.tvLastScreen = key
        local ____t_result_456
        if __t(__L1.screen == "play" or __L1.screen == "count") then
            ____t_result_456 = __add("Jogando: ", __L1.game.name)
        else
            local ____temp_455
            if __L1.screen == "over" then
                local ____add_453 = __add
                local ____t_result_452
                local ____t_451 = __t
                local ____opt_448 = __L1.st
                if ____opt_448 ~= nil then
                    ____opt_448 = ____opt_448.ended
                end
                local ____opt_result_450
                if ____opt_448 ~= nil then
                    ____opt_result_450 = ____opt_448.text
                end
                __O[1237] = ____opt_result_450
                if ____t_451(____opt_result_450) then
                    ____t_result_452 = __O[1237]
                else
                    ____t_result_452 = ""
                end
                ____temp_455 = ____add_453("Fim de jogo! ", ____t_result_452)
            else
                local ____temp_454
                if __L1.screen == "mode" then
                    ____temp_454 = __add(
                        "Escolhendo: ",
                        __get(__L1.GAMES, __L1.sel).name
                    )
                else
                    ____temp_454 = "Escolhendo o jogo na TV…"
                end
                ____temp_455 = ____temp_454
            end
            ____t_result_456 = ____temp_455
        end
        local text = ____t_result_456
        __L1.tv:send({kind = "status", text = text, playing = __L1.screen == "play" or __L1.screen == "count"})
    end
    __L1.updateTV = function(self, ap)
        local ____t_460 = __t
        local ____t_result_459
        local ____t_458 = __t
        local ____t_result_457
        if __t(ap) then
            ____t_result_457 = __L1.tv
        else
            ____t_result_457 = ap
        end
        __O[1238] = ____t_result_457
        if ____t_458(____t_result_457) then
            ____t_result_459 = __len(__L1.tv.phones)
        else
            ____t_result_459 = __O[1238]
        end
        if ____t_460(____t_result_459) then
            __L1.screen = "menu"
            __L1:sfx("menu")
        end
    end
    __L1.drawTV = function(self, c)
        __L1:R(
            c,
            0,
            0,
            __L1.W,
            __L1.H,
            "#101826"
        )
        do
            local i = 0
            while i < 40 do
                __L1:R(
                    c,
                    __bor(
                        __L1:hash(i + 11) * __L1.W,
                        0
                    ),
                    __bor(
                        __L1:hash(i + 17) * __L1.H,
                        0
                    ),
                    2,
                    2,
                    ("rgba(160,220,255," .. tostring(0.15 + 0.25 * math.sin(__L1.t * 1.5 + i))) .. ")"
                )
                i = i + 1
            end
        end
        __L1:frame(
            c,
            210,
            14,
            540,
            66,
            "#102030",
            "#ffd75a",
            "#4a3a20"
        )
        __L1:txt(
            c,
            "📺 MODO TV",
            __L1.W / 2,
            38,
            22,
            "#fff3a0"
        )
        __L1:txt(
            c,
            "a TV mostra o jogo · o celular é o controle",
            __L1.W / 2,
            64,
            10,
            "#e8d8b0",
            "center",
            nil
        )
        if __t(not __t(__L1.tv) or not __t(__L1.tv.code)) then
            local ____L1_txt_463 = __L1.txt
            local ____c_462 = c
            local ____t_result_461
            if __t(__L1.tvMsg) then
                ____t_result_461 = __L1.tvMsg
            else
                ____t_result_461 = "Abrindo a sala…"
            end
            ____L1_txt_463(
                __L1,
                ____c_462,
                ____t_result_461,
                __L1.W / 2,
                260,
                13,
                "#fff"
            )
            __L1:button(
                c,
                "VOLTAR",
                410,
                440,
                140,
                52,
                false,
                function()
                    __L1:closeTV()
                    __L1.screen = "menu"
                end
            )
            return
        end
        __L1:frame(
            c,
            40,
            100,
            290,
            290,
            "#ffffff",
            "#ffd75a",
            "#4a3a20"
        )
        if __t(__L1.tv.qr) then
            local n = __L1.tv.qr:getModuleCount()
            local sz = math.floor(250 / n)
            local ox = 40 + 145 - n * sz / 2
            local oy = 100 + 145 - n * sz / 2
            c.fillStyle = "#111"
            do
                local y = 0
                while __lt(y, n) do
                    do
                        local x = 0
                        while __lt(x, n) do
                            if __t(__L1.tv.qr:isDark(y, x)) then
                                c:fillRect(ox + x * sz, oy + y * sz, sz, sz)
                            end
                            x = x + 1
                        end
                    end
                    y = y + 1
                end
            end
        end
        __L1:txt(
            c,
            "CÓDIGO DA SALA",
            540,
            116,
            11,
            "#e8d8b0"
        )
        __L1:txt(
            c,
            __L1.tv.code,
            540,
            160,
            48,
            "#fff3a0",
            "center",
            "#6a4a10"
        )
        __L1:txt(
            c,
            "No celular, abra:",
            360,
            206,
            10,
            "#c8d8e8",
            "left",
            nil
        )
        __L1:txt(
            c,
            __re_replace(
                __L1.tv.joinUrl,
                __re("^https?:\\/\\/", ""),
                ""
            ),
            360,
            228,
            11,
            "#7ad1ff",
            "left",
            nil
        )
        __L1:txt(
            c,
            "e digite o código, ou aponte a câmera para o QR.",
            360,
            250,
            10,
            "#c8d8e8",
            "left",
            nil
        )
        do
            local i = 0
            while i < 4 do
                local x = 380 + i * 140
                local y = 280
                local p = __get(__L1.tv.phones, i)
                local ____L1_frame_466 = __L1.frame
                local ____array_465 = __TS__SparseArrayNew(
                    c,
                    x - 60,
                    y,
                    124,
                    150,
                    __t(p) and "#1e2a1e" or "#161616"
                )
                local ____t_result_464
                if __t(p) then
                    ____t_result_464 = __get(__L1.PLAYER_COL, i)
                else
                    ____t_result_464 = "#444"
                end
                __TS__SparseArrayPush(____array_465, ____t_result_464, "#2a2a2a")
                ____L1_frame_466(
                    __L1,
                    __TS__SparseArraySpread(____array_465)
                )
                if __t(p) then
                    local ____L1_hero_472 = __L1.hero
                    local ____c_471 = c
                    local ____t_result_470
                    local ____t_469 = __t
                    local ____opt_467 = __get(__L1.tv.av, i)
                    if ____opt_467 ~= nil then
                        ____opt_467 = ____opt_467.type
                    end
                    __O[1239] = ____opt_467
                    if ____t_469(____opt_467) then
                        ____t_result_470 = __O[1239]
                    else
                        ____t_result_470 = __get(__L1.DEF_AV, i)
                    end
                    ____L1_hero_472(
                        __L1,
                        ____c_471,
                        ____t_result_470,
                        x + 2,
                        y + 112,
                        {
                            scale = 1,
                            frame = __L1.t,
                            emotion = "friend",
                            opacity = __t(p.online) and 1 or 0.4
                        }
                    )
                    local ____L1_txt_483 = __L1.txt
                    local ____c_482 = c
                    local ____add_481 = __add
                    local ____add_result_480 = __add(
                        __add("P", i + 1),
                        " · "
                    )
                    local ____t_result_479
                    local ____t_478 = __t
                    local ____get_476 = __get
                    local ____L1_AV_NAMES_475 = __L1.AV_NAMES
                    local ____opt_473 = __get(__L1.tv.av, i)
                    if ____opt_473 ~= nil then
                        ____opt_473 = ____opt_473.type
                    end
                    local ____get_476_result_477 = ____get_476(____L1_AV_NAMES_475, ____opt_473)
                    __O[1240] = ____get_476_result_477
                    if ____t_478(____get_476_result_477) then
                        ____t_result_479 = __O[1240]
                    else
                        ____t_result_479 = p.name
                    end
                    ____L1_txt_483(
                        __L1,
                        ____c_482,
                        ____add_481(____add_result_480, ____t_result_479),
                        x + 2,
                        y + 132,
                        8,
                        __get(__L1.PLAYER_COL, i)
                    )
                else
                    __L1:txt(
                        c,
                        __add(
                            __add("P", i + 1),
                            " livre"
                        ),
                        x + 2,
                        y + 75,
                        10,
                        "#666"
                    )
                end
                i = i + 1
            end
        end
        __L1:txt(
            c,
            __L1.tvMsg,
            __L1.W / 2,
            456,
            11,
            "#fff"
        )
        __L1:button(
            c,
            __t(__len(__L1.tv.phones)) and "ESCOLHER JOGO" or "ESPERANDO JOGADORES…",
            340,
            474,
            280,
            50,
            not not __t(__len(__L1.tv.phones)),
            function()
                if __t(__len(__L1.tv.phones)) then
                    __L1.screen = "menu"
                end
            end
        )
        __L1:button(
            c,
            "SAIR",
            24,
            474,
            120,
            50,
            false,
            function()
                __L1:closeTV()
                __L1.screen = "menu"
            end
        )
    end
    __L1.back = function(self)
        __L1:sfx("menu")
        local ____t_487 = __t
        local ____t_result_486
        local ____t_485 = __t
        local ____t_result_484
        if __t(__L1.net) then
            ____t_result_484 = __L1.net.live
        else
            ____t_result_484 = __L1.net
        end
        __O[1241] = ____t_result_484
        if ____t_485(____t_result_484) then
            ____t_result_486 = __L1.screen ~= "menu" or __L1.net.role == "guest"
        else
            ____t_result_486 = __O[1241]
        end
        if ____t_487(____t_result_486) then
            local ____t_493 = __t
            local ____t_result_492
            local ____t_491 = __t
            local ____t_result_490
            local ____t_489 = __t
            local ____temp_488 = __L1.net.role == "guest" or __L1.screen == "play"
            __O[1242] = ____temp_488
            if ____t_489(____temp_488) then
                ____t_result_490 = __O[1242]
            else
                ____t_result_490 = __L1.screen == "count"
            end
            __O[1243] = ____t_result_490
            if ____t_491(____t_result_490) then
                ____t_result_492 = __O[1243]
            else
                ____t_result_492 = __L1.screen == "over"
            end
            if ____t_493(____t_result_492) then
                __L1:leaveNet("Você saiu da sala online.")
                return
            end
        end
        if __L1.screen == "online" then
            if __t(__L1.net) then
                __L1:leaveNet("")
            end
            __L1.screen = "menu"
            return
        end
        if __L1.screen == "tv" then
            __L1:closeTV()
            __L1.screen = "menu"
            return
        end
        if __t(__L1.screen == "play" or __L1.screen == "count") then
            __L1.paused = not __t(__L1.paused)
            __L1.pauseSel = 0
            return
        end
        if __t(__L1.screen == "mode" or __L1.screen == "loja") then
            __L1.screen = "menu"
            return
        end
        if __L1.screen == "over" then
            __L1.screen = "menu"
            return
        end
        __L1:close()
    end
    __L1.updateScreens = function(self, dt)
        local p = __get(__L1.P, 0)
        local p2 = __get(__L1.P, 1)
        local ____t_result_496
        local ____t_495 = __t
        local ____t_result_494
        if __t(p.ap) then
            ____t_result_494 = p.ap
        else
            ____t_result_494 = p2.ap
        end
        __O[1244] = ____t_result_494
        if ____t_495(____t_result_494) then
            ____t_result_496 = __O[1244]
        else
            ____t_result_496 = __L1.menuNav.start
        end
        local ap = ____t_result_496
        local function nav(____, v)
            __L1:sfx("move")
            return v
        end
        local dirs = __call(
            __get(__L1.P, 0).dirs,
            "concat",
            __get(__L1.P, 1).dirs
        )
        __get(__L1.P, 0).dirs = __arrL({}, 0)
        __get(__L1.P, 1).dirs = __arrL({}, 0)
        if __t(__L1.paused) then
            for ____, d in __iterar((dirs)) do
                if __t(d == "u" or d == "d") then
                    __L1.pauseSel = nav(nil, 1 - __L1.pauseSel)
                end
            end
            if __t(ap) then
                if __L1.pauseSel == 0 then
                    __L1.paused = false
                else
                    __L1.paused = false
                    __L1.screen = "menu"
                end
                __L1:sfx("menu")
            end
            return
        end
        if __L1.screen == "menu" then
            local N = __len(__L1.GAMES)
            for ____, d in __iterar((dirs)) do
                if d == "l" then
                    __L1.sel = nav(
                        nil,
                        __mod(__L1.sel + N - 1, N)
                    )
                end
                if d == "r" then
                    __L1.sel = nav(
                        nil,
                        __mod(__L1.sel + 1, N)
                    )
                end
                if __t(d == "u" or d == "d") then
                    __L1.sel = __mod(
                        nav(
                            nil,
                            __mod(
                                __L1.sel + 5,
                                math.ceil(N / 5) * 5
                            )
                        ),
                        N
                    )
                end
            end
            if __t(ap) then
                __L1.screen = "mode"
                __L1.modeSel = 0
                __L1:sfx("menu")
            end
            local ____t_498 = __t
            local ____t_result_497
            if __t(p.bp) then
                ____t_result_497 = p.bp
            else
                ____t_result_497 = p2.bp
            end
            if ____t_498(____t_result_497) then
                __L1.screen = "loja"
                __L1.shopSel = 0
                __L1:sfx("menu")
            end
        elseif __L1.screen == "online" then
            __L1:updateOnline(dirs, ap, nav)
        elseif __L1.screen == "tv" then
            __L1:updateTV(ap)
        elseif __L1.screen == "loja" then
            for ____, d in __iterar((dirs)) do
                if d == "l" then
                    __L1.shopSel = nav(
                        nil,
                        __mod(
                            __L1.shopSel + __len(__L1.SHOP) - 1,
                            __len(__L1.SHOP)
                        )
                    )
                end
                if d == "r" then
                    __L1.shopSel = nav(
                        nil,
                        __mod(
                            __L1.shopSel + 1,
                            __len(__L1.SHOP)
                        )
                    )
                end
                if __t(d == "u" or d == "d") then
                    __L1.shopSel = nav(
                        nil,
                        __mod(
                            __L1.shopSel + 7,
                            __len(__L1.SHOP)
                        )
                    )
                end
            end
            if __t(ap) then
                __L1:shopAct(0)
            end
            local ____t_500 = __t
            local ____t_result_499
            if __t(p.bp) then
                ____t_result_499 = p.bp
            else
                ____t_result_499 = p2.bp
            end
            if ____t_500(____t_result_499) then
                __L1:shopAct(1)
            end
        elseif __L1.screen == "mode" then
            for ____, d in __iterar((dirs)) do
                local ____t_506 = __t
                local ____t_result_505
                local ____t_504 = __t
                local ____t_result_503
                local ____t_502 = __t
                local ____temp_501 = d == "l" or d == "r"
                __O[1245] = ____temp_501
                if ____t_502(____temp_501) then
                    ____t_result_503 = __O[1245]
                else
                    ____t_result_503 = d == "u"
                end
                __O[1246] = ____t_result_503
                if ____t_504(____t_result_503) then
                    ____t_result_505 = __O[1246]
                else
                    ____t_result_505 = d == "d"
                end
                if ____t_506(____t_result_505) then
                    __L1.modeSel = nav(nil, 1 - __L1.modeSel)
                end
            end
            local ____t_508 = __t
            local ____t_result_507
            if __t(__L1.net) then
                ____t_result_507 = __L1.net.live
            else
                ____t_result_507 = __L1.net
            end
            if ____t_508(____t_result_507) then
                if __t(ap) then
                    if __t(__L1.net.peerOnline) then
                        __L1:startGame(
                            __get(__L1.GAMES, __L1.sel),
                            "duo"
                        )
                    else
                        __L1:sfx("fake")
                    end
                end
                local ____t_510 = __t
                local ____t_result_509
                if __t(p.bp) then
                    ____t_result_509 = p.bp
                else
                    ____t_result_509 = p2.bp
                end
                if ____t_510(____t_result_509) then
                    __L1.screen = "menu"
                end
                return
            end
            if __t(__L1.tv) then
                if __t(ap) then
                    __L1:startGame(
                        __get(__L1.GAMES, __L1.sel),
                        __ge(
                            __L1.tv:count(),
                            2
                        ) and "duo" or "solo"
                    )
                end
                local ____t_512 = __t
                local ____t_result_511
                if __t(p.bp) then
                    ____t_result_511 = p.bp
                else
                    ____t_result_511 = p2.bp
                end
                if ____t_512(____t_result_511) then
                    __L1.screen = "menu"
                end
                return
            end
            if __t(ap) then
                __L1:startGame(
                    __get(__L1.GAMES, __L1.sel),
                    __t(__L1.modeSel) and "duo" or "solo"
                )
            end
            local ____t_514 = __t
            local ____t_result_513
            if __t(p.bp) then
                ____t_result_513 = p.bp
            else
                ____t_result_513 = p2.bp
            end
            if ____t_514(____t_result_513) then
                __L1.screen = "menu"
                __L1:sfx("menu")
            end
        elseif __L1.screen == "count" then
            local before = math.ceil(__L1.cd)
            __L1.cd = __L1.cd - dt
            if __t(math.ceil(__L1.cd) ~= before and __L1.cd > 0) then
                __L1:sfx("tick")
            end
            if __L1.cd <= 0 then
                __L1.screen = "play"
                __L1:sfx("go")
            end
            __L1.st.t = __add(__L1.st.t, dt)
        elseif __L1.screen == "play" then
            __L1.st.t = __add(__L1.st.t, dt)
            __L1.st.shake = math.max(0, __L1.st.shake - dt)
            for ____, q in __iterar((__L1.st.pop)) do
                q.t = __add(q.t, dt)
            end
            __L1.st.pop = __call(
                __L1.st.pop,
                "filter",
                function(____, q) return __lt(q.t, 0.9) end
            )
            if __t(__L1.st.banner) then
                local ____L1_st_banner_515, ____t_516 = __L1.st.banner, "t"
                ____L1_st_banner_515[____t_516] = ____L1_st_banner_515[____t_516] - dt
                if __le(__L1.st.banner.t, 0) then
                    __L1.st.banner = nil
                end
            end
            if not __t(__L1.st.ended) then
                __L1.game:update(__L1.st, dt)
            else
                __L1.st.endT = __add(__L1.st.endT, dt)
                if __gt(__L1.st.endT, 1.3) then
                    __L1:finish()
                end
            end
        elseif __L1.screen == "over" then
            if __t(__L1.initials) then
                for ____, d in __iterar((dirs)) do
                    local k = __call(
                        __L1.LETTERS,
                        "indexOf",
                        __get(__L1.initials.s, __L1.initials.i)
                    )
                    if d == "u" then
                        __set(
                            __L1.initials.s,
                            __L1.initials.i,
                            nav(
                                nil,
                                __get(
                                    __L1.LETTERS,
                                    __mod(
                                        k + 1,
                                        __len(__L1.LETTERS)
                                    )
                                )
                            )
                        )
                    end
                    if d == "d" then
                        __set(
                            __L1.initials.s,
                            __L1.initials.i,
                            nav(
                                nil,
                                __get(
                                    __L1.LETTERS,
                                    __mod(
                                        k + __len(__L1.LETTERS) - 1,
                                        __len(__L1.LETTERS)
                                    )
                                )
                            )
                        )
                    end
                    if d == "l" then
                        __L1.initials.i = nav(
                            nil,
                            math.max(0, __L1.initials.i - 1)
                        )
                    end
                    if d == "r" then
                        __L1.initials.i = nav(
                            nil,
                            math.min(2, __L1.initials.i + 1)
                        )
                    end
                end
                if __t(ap) then
                    if __lt(__L1.initials.i, 2) then
                        local ____L1_initials_517, ____i_518 = __L1.initials, "i"
                        ____L1_initials_517[____i_518] = ____L1_initials_517[____i_518] + 1
                        __L1:sfx("move")
                    else
                        __L1:saveInitials()
                    end
                end
                return
            end
            for ____, d in __iterar((dirs)) do
                local ____t_524 = __t
                local ____t_result_523
                local ____t_522 = __t
                local ____t_result_521
                local ____t_520 = __t
                local ____temp_519 = d == "l" or d == "r"
                __O[1247] = ____temp_519
                if ____t_520(____temp_519) then
                    ____t_result_521 = __O[1247]
                else
                    ____t_result_521 = d == "u"
                end
                __O[1248] = ____t_result_521
                if ____t_522(____t_result_521) then
                    ____t_result_523 = __O[1248]
                else
                    ____t_result_523 = d == "d"
                end
                if ____t_524(____t_result_523) then
                    __L1.overSel = nav(nil, 1 - __L1.overSel)
                end
            end
            if __t(ap) then
                if __L1.overSel == 0 then
                    local ____t_528 = __t
                    local ____t_result_527
                    local ____t_526 = __t
                    local ____temp_525 = not __t(__L1.net)
                    __O[1249] = ____temp_525
                    if ____t_526(____temp_525) then
                        ____t_result_527 = __O[1249]
                    else
                        ____t_result_527 = __L1.net.peerOnline
                    end
                    if ____t_528(____t_result_527) then
                        __L1:startGame(__L1.game, __L1.st.mode)
                    end
                else
                    __L1.screen = "menu"
                    __L1:sfx("menu")
                end
            end
            local ____t_530 = __t
            local ____t_result_529
            if __t(p.bp) then
                ____t_result_529 = p.bp
            else
                ____t_result_529 = p2.bp
            end
            if ____t_530(____t_result_529) then
                __L1.screen = "menu"
            end
        end
    end
    __L1.medalIcon = function(self, c, x, y, m, s)
        if s == nil then
            s = 1
        end
        if not __t(m) then
            return
        end
        __L1:R(
            c,
            x - 6 * s,
            y - 14 * s,
            4 * s,
            8 * s,
            "#3a6ad0"
        )
        __L1:R(
            c,
            x + 2 * s,
            y - 14 * s,
            4 * s,
            8 * s,
            "#d03a3a"
        )
        __L1:R(
            c,
            x - 7 * s,
            y - 7 * s,
            14 * s,
            14 * s,
            "#2a1a10"
        )
        __L1:R(
            c,
            x - 6 * s,
            y - 6 * s,
            12 * s,
            12 * s,
            __get(__L1.MEDAL_COL, m)
        )
        __L1:R(
            c,
            x - 3 * s,
            y - 4 * s,
            3 * s,
            3 * s,
            "rgba(255,255,255,.6)"
        )
    end
    __L1.gameIcon = function(self, c, gm, x, y)
        local s = 4
        local function px(____, a, b, w, h, col)
            return __L1:R(
                c,
                x + a * s,
                y + b * s,
                w * s,
                h * s,
                col
            )
        end
        if gm.id == "minhoca" then
            px(
                nil,
                0,
                6,
                3,
                3,
                "#ff8fb0"
            )
            px(
                nil,
                3,
                6,
                3,
                3,
                "#ff8fb0"
            )
            px(
                nil,
                6,
                3,
                3,
                3,
                "#ff8fb0"
            )
            px(
                nil,
                6,
                6,
                3,
                3,
                "#ff8fb0"
            )
            px(
                nil,
                9,
                3,
                3,
                3,
                "#e8507a"
            )
            px(
                nil,
                10,
                4,
                1,
                1,
                "#fff"
            )
            px(
                nil,
                13,
                4,
                2,
                3,
                "#b8242c"
            )
        end
        if gm.id == "pong" then
            px(
                nil,
                0,
                1,
                2,
                8,
                "#ffb347"
            )
            px(
                nil,
                13,
                2,
                2,
                8,
                "#7ad1ff"
            )
            px(
                nil,
                7,
                4,
                2,
                2,
                "#fff"
            )
            px(
                nil,
                5,
                6,
                1,
                1,
                "rgba(255,255,255,.4)"
            )
        end
        if gm.id == "quebra" then
            do
                local i = 0
                while i < 4 do
                    px(
                        nil,
                        i * 4,
                        0,
                        3,
                        2,
                        __get(
                            __arrL({"#d06a5a", "#e8a04a", "#7ab86a", "#5a9ad0"}, 4),
                            i
                        )
                    )
                    i = i + 1
                end
            end
            do
                local i = 0
                while i < 3 do
                    px(
                        nil,
                        2 + i * 4,
                        3,
                        3,
                        2,
                        __get(
                            __arrL({"#e8d04a", "#9a7ad0", "#d06a5a"}, 3),
                            i
                        )
                    )
                    i = i + 1
                end
            end
            px(
                nil,
                7,
                6,
                1,
                1,
                "#fff"
            )
            px(
                nil,
                4,
                9,
                8,
                1,
                "#e8c070"
            )
        end
        if gm.id == "cabo" then
            px(
                nil,
                0,
                5,
                15,
                1,
                "#c8a060"
            )
            px(
                nil,
                7,
                3,
                1,
                5,
                "#e84a3a"
            )
            px(
                nil,
                0,
                3,
                2,
                5,
                "#ffb347"
            )
            px(
                nil,
                13,
                3,
                2,
                5,
                "#c9a8ff"
            )
            px(
                nil,
                6,
                8,
                3,
                1,
                "#5a3a22"
            )
        end
        if gm.id == "chinelo" then
            px(
                nil,
                2,
                0,
                2,
                4,
                "#4a8af0"
            )
            px(
                nil,
                9,
                2,
                4,
                2,
                "#4a8af0"
            )
            px(
                nil,
                6,
                6,
                2,
                4,
                "#4a8af0"
            )
            px(
                nil,
                12,
                7,
                2,
                2,
                "#9a3a8a"
            )
            px(
                nil,
                0,
                9,
                15,
                1,
                "#9a8a6a"
            )
        end
        if gm.id == "memoria" then
            px(
                nil,
                0,
                1,
                4,
                5,
                "#c8a050"
            )
            px(
                nil,
                5,
                1,
                4,
                5,
                "#f4ecd0"
            )
            px(
                nil,
                6,
                2,
                2,
                3,
                "#e84a5a"
            )
            px(
                nil,
                10,
                1,
                4,
                5,
                "#f4ecd0"
            )
            px(
                nil,
                11,
                2,
                2,
                3,
                "#e84a5a"
            )
            px(
                nil,
                0,
                7,
                4,
                5,
                "#c8a050"
            )
            px(
                nil,
                5,
                7,
                4,
                5,
                "#c8a050"
            )
            px(
                nil,
                10,
                7,
                4,
                5,
                "#c8a050"
            )
        end
        if gm.id == "tiro" then
            px(
                nil,
                5,
                1,
                5,
                1,
                "#ff4a3a"
            )
            px(
                nil,
                5,
                9,
                5,
                1,
                "#ff4a3a"
            )
            px(
                nil,
                3,
                3,
                1,
                5,
                "#ff4a3a"
            )
            px(
                nil,
                11,
                3,
                1,
                5,
                "#ff4a3a"
            )
            px(
                nil,
                7,
                5,
                1,
                1,
                "#ff4a3a"
            )
            px(
                nil,
                12,
                8,
                2,
                3,
                "#c8c8c8"
            )
            px(
                nil,
                12,
                9,
                2,
                1,
                "#e84a3a"
            )
        end
        if gm.id == "corrida" then
            px(
                nil,
                3,
                0,
                9,
                11,
                "#b8946a"
            )
            px(
                nil,
                7,
                1,
                1,
                2,
                "#d8c09a"
            )
            px(
                nil,
                7,
                5,
                1,
                2,
                "#d8c09a"
            )
            px(
                nil,
                5,
                6,
                3,
                5,
                "#ffb347"
            )
            px(
                nil,
                5,
                7,
                3,
                1,
                "#bfe0f0"
            )
            px(
                nil,
                9,
                2,
                2,
                2,
                "#f4f0e0"
            )
        end
        if gm.id == "subida" then
            px(
                nil,
                1,
                9,
                5,
                1,
                "#9a9a8a"
            )
            px(
                nil,
                7,
                6,
                5,
                1,
                "#c8603a"
            )
            px(
                nil,
                3,
                3,
                5,
                1,
                "#e8e0d0"
            )
            px(
                nil,
                5,
                0,
                2,
                2,
                "#ffb347"
            )
            px(
                nil,
                0,
                11,
                15,
                1,
                "#5a3a22"
            )
        end
        if gm.id == "galo" then
            px(
                nil,
                4,
                3,
                5,
                4,
                "#f4f0e0"
            )
            px(
                nil,
                8,
                1,
                3,
                3,
                "#f4f0e0"
            )
            px(
                nil,
                9,
                0,
                2,
                1,
                "#e83a3a"
            )
            px(
                nil,
                11,
                2,
                2,
                1,
                "#e8a83a"
            )
            px(
                nil,
                2,
                2,
                2,
                3,
                "#2a5a3a"
            )
            px(
                nil,
                5,
                7,
                1,
                2,
                "#e8a83a"
            )
            px(
                nil,
                7,
                7,
                1,
                2,
                "#e8a83a"
            )
        end
    end
    __L1.button = function(self, c, label, x, y, w, h, on, act)
        __L1:frame(
            c,
            x,
            y,
            w,
            h,
            __t(on) and "#4a7a3a" or "#2a2018",
            __t(on) and "#fff3a0" or "#e8c27a"
        )
        __L1:txt(
            c,
            label,
            x + w / 2,
            y + h / 2 + 1,
            14,
            __t(on) and "#fff" or "#e8d8b0"
        )
        __call(__L1.clicks, "push", {
            x = x,
            y = y,
            w = w,
            h = h,
            act = act
        })
    end
    __L1.drawScreens = function(self, c)
        __L1.clicks = __arrL({}, 0)
        if __L1.screen == "online" then
            __L1:drawOnline(c)
            return
        end
        if __L1.screen == "tv" then
            __L1:drawTV(c)
            return
        end
        if __L1.screen == "guestwait" then
            __L1:R(
                c,
                0,
                0,
                __L1.W,
                __L1.H,
                "#14121c"
            )
            __L1:frame(
                c,
                230,
                150,
                500,
                220,
                "#102030",
                "#7ad1ff",
                "#2a4a6a"
            )
            local ____L1_txt_537 = __L1.txt
            local ____c_536 = c
            local ____add_535 = __add
            local ____t_result_534
            local ____t_533 = __t
            local ____opt_531 = __L1.net
            if ____opt_531 ~= nil then
                ____opt_531 = ____opt_531.code
            end
            __O[1250] = ____opt_531
            if ____t_533(____opt_531) then
                ____t_result_534 = __O[1250]
            else
                ____t_result_534 = ""
            end
            ____L1_txt_537(
                __L1,
                ____c_536,
                ____add_535("SALA ", ____t_result_534),
                __L1.W / 2,
                190,
                16,
                "#d8f0ff"
            )
            local gm = __call(
                __L1.GAMES,
                "find",
                function(____, g2)
                    local ____g2_id_543 = g2.id
                    local ____opt_540 = __L1.net
                    if ____opt_540 ~= nil then
                        ____opt_540 = ____opt_540.snap
                    end
                    local ____opt_result_542
                    if ____opt_540 ~= nil then
                        ____opt_result_542 = ____opt_540.g
                    end
                    return ____g2_id_543 == ____opt_result_542
                end
            )
            __L1:txt(
                c,
                "O anfitrião está escolhendo o jogo…",
                __L1.W / 2,
                240,
                12,
                "#fff"
            )
            if __t(gm) then
                __L1:txt(
                    c,
                    gm.name,
                    __L1.W / 2,
                    284,
                    14,
                    gm.color
                )
            end
            __L1:txt(
                c,
                "Esc: sair da sala",
                __L1.W / 2,
                340,
                9,
                "#8a8aa8",
                "center",
                nil
            )
            return
        end
        if __L1.screen == "menu" then
            __L1:R(
                c,
                0,
                0,
                __L1.W,
                __L1.H,
                "#1a1420"
            )
            do
                local i = 0
                while i < 40 do
                    __L1:R(
                        c,
                        __bor(
                            __L1:hash(i) * __L1.W,
                            0
                        ),
                        __bor(
                            __L1:hash(i + 9) * __L1.H,
                            0
                        ),
                        2,
                        2,
                        ("rgba(255,220,160," .. tostring(0.2 + 0.3 * math.sin(__L1.t * 2 + i))) .. ")"
                    )
                    i = i + 1
                end
            end
            __L1:frame(
                c,
                250,
                18,
                460,
                70,
                "#2a1030",
                "#ff6ab0",
                "#6a2a5a"
            )
            __L1:txt(
                c,
                "FLIPERAMA DA ROÇA",
                __L1.W / 2,
                46,
                26,
                math.sin(__L1.t * 6) > -0.8 and "#ffd0f0" or "#a06a90",
                "center",
                "#a02a6a"
            )
            __L1:txt(
                c,
                "SOZINHO OU EM DUPLA",
                __L1.W / 2,
                72,
                10,
                "#ffb0d8",
                "center",
                nil
            )
            __L1:txt(
                c,
                __add(
                    __add("◎ ", __L1.data.fichas),
                    " FICHAS"
                ),
                __L1.W - 70,
                30,
                12,
                "#ffd75a",
                "right"
            )
            __call(
                __L1.GAMES,
                "forEach",
                function(____, gm, i)
                    local col = __mod(i, 5)
                    local row = math.floor(i / 5)
                    local on = i == __L1.sel
                    local x = 22 + col * 186
                    local y = 104 + row * 178 + (__t(on) and -4 or 0)
                    local r = __L1:rec(gm.id)
                    local ____opt_544 = __get(r.solo, 0)
                    if ____opt_544 ~= nil then
                        ____opt_544 = ____opt_544.s
                    end
                    local best = ____opt_544
                    __L1:frame(
                        c,
                        x,
                        y,
                        172,
                        164,
                        __t(on) and "#3a2a40" or "#241a20",
                        __t(on) and "#fff3a0" or gm.color,
                        "#3a2a2a"
                    )
                    __L1:R(
                        c,
                        x + 14,
                        y + 14,
                        68,
                        48,
                        "#120c10"
                    )
                    __L1:gameIcon(c, gm, x + 18, y + 20)
                    __L1:medalIcon(
                        c,
                        x + 140,
                        y + 36,
                        r.medal,
                        2
                    )
                    local words = __call(gm.name, "split", " ")
                    local half = math.ceil(__len(words) / 2)
                    __L1:txt(
                        c,
                        __call(
                            __call(words, "slice", 0, half),
                            "join",
                            " "
                        ),
                        x + 86,
                        y + 82,
                        9,
                        __t(on) and "#fff" or "#f0e0c0"
                    )
                    __L1:txt(
                        c,
                        __call(
                            __call(words, "slice", half),
                            "join",
                            " "
                        ),
                        x + 86,
                        y + 98,
                        9,
                        __t(on) and "#fff" or "#f0e0c0"
                    )
                    local ____L1_txt_550 = __L1.txt
                    local ____c_549 = c
                    local ____add_548 = __add
                    local ____add_result_547 = __add(gm.duo == "coop" and "JUNTOS" or "CONTRA", " · ATÉ ")
                    local ____t_result_546
                    if __t(gm.max) then
                        ____t_result_546 = gm.max
                    else
                        ____t_result_546 = 2
                    end
                    ____L1_txt_550(
                        __L1,
                        ____c_549,
                        ____add_548(____add_result_547, ____t_result_546),
                        x + 86,
                        y + 120,
                        8,
                        gm.color,
                        "center",
                        nil
                    )
                    local ____L1_txt_553 = __L1.txt
                    local ____c_552 = c
                    local ____t_result_551
                    if __t(best) then
                        ____t_result_551 = __add("RECORDE ", best)
                    else
                        ____t_result_551 = "SEM RECORDE"
                    end
                    ____L1_txt_553(
                        __L1,
                        ____c_552,
                        ____t_result_551,
                        x + 86,
                        y + 140,
                        8,
                        "#c8b890",
                        "center",
                        nil
                    )
                    __call(
                        __L1.clicks,
                        "push",
                        {
                            x = x,
                            y = y,
                            w = 172,
                            h = 164,
                            act = function()
                                if __L1.sel == i then
                                    __L1.screen = "mode"
                                    __L1.modeSel = 0
                                else
                                    __L1.sel = i
                                end
                                __L1:sfx("menu")
                            end
                        }
                    )
                end
            )
            if __t(__L1.net) then
                __L1:txt(
                    c,
                    __get(__L1.GAMES, __L1.sel).sub,
                    __L1.W / 2,
                    498,
                    12,
                    "#e8d8b0",
                    "center",
                    nil
                )
            else
                __L1:txt(
                    c,
                    __get(__L1.GAMES, __L1.sel).sub,
                    __L1.W / 2,
                    96,
                    10,
                    "#e8d8b0",
                    "center",
                    nil
                )
            end
            __L1:button(
                c,
                "SAIR",
                24,
                476,
                120,
                50,
                false,
                __L1.close
            )
            if __t(not __t(__L1.net) and not __t(__L1.tv)) then
                __L1:button(
                    c,
                    "ONLINE (O)",
                    __L1.W / 2 - 170,
                    470,
                    160,
                    50,
                    false,
                    __L1.openOnline
                )
                __L1:button(
                    c,
                    "MODO TV (T)",
                    __L1.W / 2 + 10,
                    470,
                    160,
                    50,
                    false,
                    __L1.openTV
                )
            elseif __t(__L1.tv) then
                __L1:button(
                    c,
                    "SALA DA TV",
                    __L1.W / 2 - 80,
                    470,
                    160,
                    50,
                    false,
                    function()
                        __L1.screen = "tv"
                    end
                )
            end
            __L1:button(
                c,
                "LOJA (B)",
                __L1.W - 164,
                476,
                140,
                50,
                false,
                function()
                    __L1.screen = "loja"
                    __L1.shopSel = 0
                    __L1:sfx("menu")
                end
            )
            __L1:txt(
                c,
                "Setas/WASD escolhem · A abre o jogo · B abre a loja · Esc sai",
                __L1.W / 2,
                526,
                9,
                "#8a7a6a",
                "center",
                nil
            )
        elseif __L1.screen == "loja" then
            __L1:R(
                c,
                0,
                0,
                __L1.W,
                __L1.H,
                "#1a1420"
            )
            __L1:frame(
                c,
                250,
                14,
                460,
                60,
                "#2a1030",
                "#ffd75a",
                "#6a4a2a"
            )
            __L1:txt(
                c,
                "LOJA DE FICHAS",
                __L1.W / 2,
                38,
                20,
                "#fff3a0"
            )
            __L1:txt(
                c,
                "personagens para jogar no fliperama",
                __L1.W / 2,
                60,
                9,
                "#e8d8b0",
                "center",
                nil
            )
            __L1:txt(
                c,
                __add(
                    __add("◎ ", __L1.data.fichas),
                    " FICHAS"
                ),
                __L1.W - 70,
                30,
                12,
                "#ffd75a",
                "right"
            )
            __call(
                __L1.SHOP,
                "forEach",
                function(____, ____bindingPattern0, i)
                    local price
                    local ____type
                    ____type = ____bindingPattern0[1]
                    price = ____bindingPattern0[2]
                    local col = __mod(i, 7)
                    local row = math.floor(i / 7)
                    local x = 34 + col * 130
                    local y = 92 + row * 186
                    local on = i == __L1.shopSel
                    local has = __call(__L1.data.unlocked, "includes", ____type)
                    local tag = __get(__L1.data.avatar, 0) == ____type and "P1" or (__get(__L1.data.avatar, 1) == ____type and "P2" or "")
                    __L1:frame(
                        c,
                        x,
                        y,
                        118,
                        174,
                        __t(on) and "#3a2a40" or "#241a20",
                        __t(on) and "#fff3a0" or (__t(has) and "#8ad070" or "#7a6a5a"),
                        "#3a2a2a"
                    )
                    c:save()
                    c:beginPath()
                    c:rect(x + 6, y + 6, 106, 162)
                    c:clip()
                    if not __t(has) then
                        c.globalAlpha = 0.35
                    end
                    local ____L1_hero_556 = __L1.hero
                    local ____array_555 = __TS__SparseArrayNew(c, ____type, x + 59, y + 118)
                    local ____t_result_554
                    if __t(on) then
                        ____t_result_554 = __L1.t
                    else
                        ____t_result_554 = 0
                    end
                    __TS__SparseArrayPush(____array_555, {scale = 1, frame = ____t_result_554, moving = on})
                    ____L1_hero_556(
                        __L1,
                        __TS__SparseArraySpread(____array_555)
                    )
                    c:restore()
                    __L1:txt(
                        c,
                        __get(__L1.AV_NAMES, ____type),
                        x + 59,
                        y + 140,
                        9,
                        "#fff"
                    )
                    local ____L1_txt_561 = __L1.txt
                    local ____array_560 = __TS__SparseArrayNew(c)
                    local ____t_result_558
                    if __t(has) then
                        local ____t_result_557
                        if __t(tag) then
                            ____t_result_557 = tag
                        else
                            ____t_result_557 = "LIBERADO"
                        end
                        ____t_result_558 = ____t_result_557
                    else
                        ____t_result_558 = __add("◎ ", price)
                    end
                    __TS__SparseArrayPush(
                        ____array_560,
                        ____t_result_558,
                        x + 59,
                        y + 158,
                        9
                    )
                    local ____t_result_559
                    if __t(tag) then
                        ____t_result_559 = __get(__L1.PLAYER_COL, tag == "P1" and 0 or 1)
                    else
                        ____t_result_559 = __t(has) and "#8ad070" or "#ffd75a"
                    end
                    __TS__SparseArrayPush(____array_560, ____t_result_559, "center", nil)
                    ____L1_txt_561(
                        __L1,
                        __TS__SparseArraySpread(____array_560)
                    )
                    __call(
                        __L1.clicks,
                        "push",
                        {
                            x = x,
                            y = y,
                            w = 118,
                            h = 174,
                            act = function()
                                __L1.shopSel = i
                                __L1:sfx("move")
                            end
                        }
                    )
                end
            )
            local ____type = table.unpack(
                __get(__L1.SHOP, __L1.shopSel),
                1,
                1
            )
            local has = __call(__L1.data.unlocked, "includes", ____type)
            __L1:button(
                c,
                __t(has) and "P1 (A)" or "COMPRAR (A)",
                300,
                470,
                170,
                52,
                false,
                function() return __L1:shopAct(0) end
            )
            __L1:button(
                c,
                "P2 (B)",
                490,
                470,
                150,
                52,
                false,
                function() return __L1:shopAct(1) end
            )
            __L1:button(
                c,
                "VOLTAR",
                24,
                470,
                130,
                52,
                false,
                function()
                    __L1.screen = "menu"
                    __L1:sfx("menu")
                end
            )
            if __t(__L1.shopMsg) then
                local ____L1_shopMsg_562, ____t_563 = __L1.shopMsg, "t"
                ____L1_shopMsg_562[____t_563] = ____L1_shopMsg_562[____t_563] - 1 / 60
                __L1:txt(
                    c,
                    __L1.shopMsg.s,
                    __L1.W / 2,
                    452,
                    12,
                    "#fff3a0"
                )
                if __le(__L1.shopMsg.t, 0) then
                    __L1.shopMsg = nil
                end
            end
        elseif __L1.screen == "mode" then
            local gm = __get(__L1.GAMES, __L1.sel)
            local r = __L1:rec(gm.id)
            __L1:R(
                c,
                0,
                0,
                __L1.W,
                __L1.H,
                "#1a1420"
            )
            __L1:frame(
                c,
                30,
                20,
                900,
                500,
                "#2a2018",
                gm.color,
                "#3a2a2a"
            )
            __L1:R(
                c,
                60,
                50,
                92,
                68,
                "#120c10"
            )
            __L1:gameIcon(c, gm, 70, 58)
            __L1:txt(
                c,
                gm.name,
                172,
                70,
                22,
                "#fff",
                "left"
            )
            __L1:txt(
                c,
                gm.sub,
                172,
                100,
                11,
                gm.color,
                "left",
                nil
            )
            __L1:txt(
                c,
                "COMO JOGAR",
                60,
                150,
                13,
                "#ffd75a",
                "left"
            )
            local ____call_565 = __call
            local ____t_result_564
            if __t(__L1.modeSel) then
                ____t_result_564 = gm.rulesDuo
            else
                ____t_result_564 = gm.rules
            end
            ____call_565(
                ____t_result_564,
                "forEach",
                function(____, l, i) return __L1:txt(
                    c,
                    __add("• ", l),
                    60,
                    180 + i * 26,
                    10,
                    "#f0e0c0",
                    "left",
                    nil
                ) end
            )
            __L1:txt(
                c,
                "CONTROLES",
                60,
                270,
                13,
                "#ffd75a",
                "left"
            )
            local ____t_result_566
            if __t(__L1.modeSel) then
                ____t_result_566 = __arrL({"P1: WASD + J (A) / K (B)", "P2: setas + Enter (A) / Shift direito (B)", "Controles e toque também funcionam"}, 3)
            else
                ____t_result_566 = __arrL({"Setas ou WASD · A: J, Espaço ou Enter · B: K", "Controle (gamepad) e toque também funcionam"}, 2)
            end
            local ctrl = ____t_result_566
            __call(
                __call(gm.controls, "concat", ctrl),
                "forEach",
                function(____, l, i) return __L1:txt(
                    c,
                    l,
                    60,
                    298 + i * 22,
                    10,
                    "#d8c8a8",
                    "left",
                    nil
                ) end
            )
            __L1:frame(
                c,
                600,
                140,
                300,
                230,
                "#1e1612",
                "#a08060",
                "#3a2a2a"
            )
            local ____L1_txt_570 = __L1.txt
            local ____c_569 = c
            local ____add_568 = __add
            local ____t_result_567
            if __t(__L1.modeSel) then
                ____t_result_567 = gm.duo == "coop" and "DUPLA" or "VITÓRIAS"
            else
                ____t_result_567 = "SOZINHO"
            end
            ____L1_txt_570(
                __L1,
                ____c_569,
                ____add_568("RANKING ", ____t_result_567),
                750,
                166,
                11,
                "#ffd75a"
            )
            local ____t_572 = __t
            local ____t_result_571
            if __t(__L1.modeSel) then
                ____t_result_571 = gm.duo == "versus"
            else
                ____t_result_571 = __L1.modeSel
            end
            if ____t_572(____t_result_571) then
                __L1:txt(
                    c,
                    __add(
                        __add(
                            __get(__L1.PLAYER_NAME, 0),
                            "  "
                        ),
                        __get(r.wins, 0)
                    ),
                    750,
                    220,
                    14,
                    __get(__L1.PLAYER_COL, 0)
                )
                __L1:txt(
                    c,
                    __add(
                        __add(
                            __get(__L1.PLAYER_NAME, 1),
                            "  "
                        ),
                        __get(r.wins, 1)
                    ),
                    750,
                    256,
                    14,
                    __get(__L1.PLAYER_COL, 1)
                )
            else
                local list = __get(
                    r,
                    __t(__L1.modeSel) and "duo" or "solo"
                )
                if not __t(__len(list)) then
                    __L1:txt(
                        c,
                        "Ninguém ainda. Seja o primeiro!",
                        750,
                        250,
                        9,
                        "#a89878",
                        "center",
                        nil
                    )
                end
                __call(
                    list,
                    "forEach",
                    function(____, e, i)
                        __L1:txt(
                            c,
                            __add(
                                __add(i + 1, ". "),
                                e.n
                            ),
                            640,
                            200 + i * 30,
                            13,
                            __t(i) and "#e8d8b0" or "#ffd75a",
                            "left"
                        )
                        __L1:txt(
                            c,
                            tostring(e.s),
                            870,
                            200 + i * 30,
                            13,
                            __t(i) and "#e8d8b0" or "#ffd75a",
                            "right"
                        )
                    end
                )
            end
            if not __t(__L1.modeSel) then
                __L1:txt(
                    c,
                    __add(
                        "MEDALHAS: ",
                        __call(gm.medals, "join", " / ")
                    ),
                    750,
                    352,
                    9,
                    "#c8b890",
                    "center",
                    nil
                )
            end
            if __t(__L1.tv) then
                local n = __L1.tv:count()
                local ____ge_result_574
                if __ge(n, 2) then
                    local ____t_result_573
                    if __t(gm.max) then
                        ____t_result_573 = gm.max
                    else
                        ____t_result_573 = 2
                    end
                    ____ge_result_574 = math.min(n, ____t_result_573)
                else
                    ____ge_result_574 = 1
                end
                local k = ____ge_result_574
                __L1:button(
                    c,
                    __add(
                        __add(
                            __add("JOGAR NA TV · ", k),
                            k > 1 and " JOGADORES" or " JOGADOR"
                        ),
                        " (A)"
                    ),
                    260,
                    410,
                    440,
                    56,
                    true,
                    function() return __L1:startGame(
                        gm,
                        __ge(n, 2) and "duo" or "solo"
                    ) end
                )
                __L1:button(
                    c,
                    "VOLTAR",
                    60,
                    410,
                    140,
                    56,
                    false,
                    function()
                        __L1.screen = "menu"
                    end
                )
                local ____gt_576 = __gt
                local ____t_result_575
                if __t(gm.max) then
                    ____t_result_575 = gm.max
                else
                    ____t_result_575 = 2
                end
                if ____gt_576(n, ____t_result_575) then
                    local ____L1_txt_585 = __L1.txt
                    local ____c_584 = c
                    local ____add_583 = __add
                    local ____add_582 = __add
                    local ____add_579 = __add
                    local ____add_578 = __add
                    local ____t_result_577
                    if __t(gm.max) then
                        ____t_result_577 = gm.max
                    else
                        ____t_result_577 = 2
                    end
                    local ____add_579_result_581 = ____add_579(
                        ____add_578("Este jogo é para até ", ____t_result_577),
                        " jogadores: jogam P1"
                    )
                    local ____gt_result_580
                    if __gt(gm.max, 2) then
                        ____gt_result_580 = __add(" a P", gm.max)
                    else
                        ____gt_result_580 = " e P2"
                    end
                    ____L1_txt_585(
                        __L1,
                        ____c_584,
                        ____add_583(
                            ____add_582(____add_579_result_581, ____gt_result_580),
                            "."
                        ),
                        __L1.W / 2,
                        482,
                        9,
                        "#ffb347",
                        "center",
                        nil
                    )
                end
            else
                local ____t_587 = __t
                local ____t_result_586
                if __t(__L1.net) then
                    ____t_result_586 = __L1.net.live
                else
                    ____t_result_586 = __L1.net
                end
                if ____t_587(____t_result_586) then
                    __L1:button(
                        c,
                        __t(__L1.net.peerOnline) and "JOGAR ONLINE (A)" or "ESPERANDO O AMIGO…",
                        300,
                        410,
                        390,
                        56,
                        true,
                        function()
                            if __t(__L1.net.peerOnline) then
                                __L1:startGame(gm, "duo")
                            end
                        end
                    )
                    __L1:button(
                        c,
                        "VOLTAR",
                        60,
                        410,
                        140,
                        56,
                        false,
                        function()
                            __L1.screen = "menu"
                        end
                    )
                else
                    __L1:button(
                        c,
                        "SOZINHO",
                        300,
                        410,
                        170,
                        56,
                        __L1.modeSel == 0,
                        function()
                            if __L1.modeSel == 0 then
                                __L1:startGame(gm, "solo")
                            else
                                __L1.modeSel = 0
                                __L1:sfx("move")
                            end
                        end
                    )
                    __L1:button(
                        c,
                        gm.duo == "coop" and "DUPLA JUNTOS" or "DUPLA CONTRA",
                        490,
                        410,
                        200,
                        56,
                        __L1.modeSel == 1,
                        function()
                            if __L1.modeSel == 1 then
                                __L1:startGame(gm, "duo")
                            else
                                __L1.modeSel = 1
                                __L1:sfx("move")
                            end
                        end
                    )
                    __L1:button(
                        c,
                        "VOLTAR",
                        60,
                        410,
                        140,
                        56,
                        false,
                        function()
                            __L1.screen = "menu"
                            __L1:sfx("menu")
                        end
                    )
                end
            end
            __L1:txt(
                c,
                "Escolha com as setas e aperte A para começar",
                __L1.W / 2,
                490,
                9,
                "#8a7a6a",
                "center",
                nil
            )
        elseif __L1.screen == "over" then
            local res = __L1.st.ended
            local sm = __L1.st.summary
            c.fillStyle = "rgba(10,8,12,.78)"
            c:fillRect(0, 0, __L1.W, __L1.H)
            __L1:frame(
                c,
                180,
                40,
                600,
                460,
                "#2a2018",
                __L1.game.color,
                "#3a2a2a"
            )
            local versus = __L1.st.mode == "duo" and __L1.game.duo == "versus"
            __L1:txt(
                c,
                __t(versus) and "FIM DE JOGO" or (res.win == false and "NÃO FOI DESSA VEZ" or "FIM DE JOGO"),
                __L1.W / 2,
                84,
                24,
                "#fff"
            )
            local ____L1_txt_590 = __L1.txt
            local ____c_589 = c
            local ____t_result_588
            if __t(res.text) then
                ____t_result_588 = res.text
            else
                ____t_result_588 = ""
            end
            ____L1_txt_590(
                __L1,
                ____c_589,
                ____t_result_588,
                __L1.W / 2,
                120,
                11,
                "#e8d8b0",
                "center",
                nil
            )
            if __t(versus) then
                if __t(res.winner ~= nil and res.winner ~= nil) then
                    __L1:hero(
                        c,
                        __get(__L1.PLAYER_TYPES, res.winner),
                        __L1.W / 2,
                        260,
                        {scale = 1.6, emotion = "friend", frame = __L1.t}
                    )
                end
                __L1:txt(
                    c,
                    __t(res.winner == nil or res.winner == nil) and "EMPATE" or __add(
                        __get(__L1.PLAYER_NAME, res.winner),
                        " VENCEU!"
                    ),
                    __L1.W / 2,
                    296,
                    20,
                    __t(res.winner == nil or res.winner == nil) and "#fff" or __get(__L1.PLAYER_COL, res.winner)
                )
            else
                __L1:txt(
                    c,
                    tostring(res.score),
                    __L1.W / 2,
                    180,
                    40,
                    "#ffd75a"
                )
                __L1:txt(
                    c,
                    "PONTOS",
                    __L1.W / 2,
                    214,
                    11,
                    "#c8b890",
                    "center",
                    nil
                )
                if __t(sm.medal) then
                    __L1:medalIcon(
                        c,
                        __L1.W / 2,
                        262,
                        sm.medal,
                        3
                    )
                    __L1:txt(
                        c,
                        __add(
                            __add(
                                "MEDALHA DE ",
                                __get(__L1.MEDALS, sm.medal)
                            ),
                            __t(sm.newMedal) and " · NOVA!" or ""
                        ),
                        __L1.W / 2,
                        306,
                        12,
                        __get(__L1.MEDAL_COL, sm.medal)
                    )
                end
            end
            __L1:txt(
                c,
                __add(
                    __add(
                        __add(
                            __add("+", sm.fichas),
                            " FICHAS  (TOTAL "
                        ),
                        __L1.data.fichas
                    ),
                    ")"
                ),
                __L1.W / 2,
                336,
                12,
                "#ffd75a"
            )
            if __t(__L1.initials) then
                __L1:txt(
                    c,
                    "NOVO RECORDE! SUAS INICIAIS:",
                    __L1.W / 2,
                    372,
                    11,
                    "#fff"
                )
                __call(
                    __L1.initials.s,
                    "forEach",
                    function(____, ch, i)
                        local x = __L1.W / 2 - 60 + i * 60
                        __L1:frame(
                            c,
                            x - 22,
                            388,
                            44,
                            54,
                            i == __L1.initials.i and "#4a3a20" or "#1e1612",
                            i == __L1.initials.i and "#fff3a0" or "#a08060",
                            "#3a2a2a"
                        )
                        __L1:txt(
                            c,
                            ch,
                            x,
                            416,
                            22,
                            "#fff"
                        )
                        __call(
                            __L1.clicks,
                            "push",
                            {
                                x = x - 22,
                                y = 388,
                                w = 44,
                                h = 54,
                                act = function()
                                    if __L1.initials.i == i then
                                        __set(
                                            __L1.initials.s,
                                            i,
                                            __get(
                                                __L1.LETTERS,
                                                __mod(
                                                    __call(__L1.LETTERS, "indexOf", ch) + 1,
                                                    __len(__L1.LETTERS)
                                                )
                                            )
                                        )
                                    else
                                        __L1.initials.i = i
                                    end
                                    __L1:sfx("move")
                                end
                            }
                        )
                    end
                )
                __L1:button(
                    c,
                    "OK",
                    __L1.W / 2 + 120,
                    392,
                    80,
                    46,
                    false,
                    __L1.saveInitials
                )
                __L1:txt(
                    c,
                    "Cima/baixo troca a letra · A confirma",
                    __L1.W / 2,
                    466,
                    9,
                    "#8a7a6a",
                    "center",
                    nil
                )
            else
                local ____t_592 = __t
                local ____t_result_591
                if __t(__L1.net) then
                    ____t_result_591 = __L1.net.role == "guest"
                else
                    ____t_result_591 = __L1.net
                end
                if ____t_592(____t_result_591) then
                    __L1:txt(
                        c,
                        "O anfitrião escolhe o próximo jogo…",
                        __L1.W / 2,
                        420,
                        12,
                        "#e8d8b0"
                    )
                else
                    __L1:button(
                        c,
                        "DE NOVO",
                        300,
                        400,
                        170,
                        56,
                        __L1.overSel == 0,
                        function() return __L1:startGame(__L1.game, __L1.st.mode) end
                    )
                    __L1:button(
                        c,
                        "MENU",
                        490,
                        400,
                        170,
                        56,
                        __L1.overSel == 1,
                        function()
                            __L1.screen = "menu"
                            __L1:sfx("menu")
                        end
                    )
                end
            end
        end
    end
    __L1.drawPlay = function(self, c)
        local ____gt_result_593
        if __gt(__L1.st.shake, 0) then
            ____gt_result_593 = math.floor((math.random() - 0.5) * 8 / 2 + 0.5) * 2
        else
            ____gt_result_593 = 0
        end
        local sh = ____gt_result_593
        __L1.g:save()
        __L1.g.imageSmoothingEnabled = false
        __L1.g:clearRect(0, 0, __L1.LW, __L1.LH)
        __L1.game:drawLow(__L1.g, __L1.st)
        __L1.g:restore()
        c:save()
        c.imageSmoothingEnabled = false
        c.fillStyle = "#000"
        c:fillRect(0, 0, __L1.W, __L1.H)
        c:drawImage(
            __L1.low,
            sh,
            sh,
            __L1.W,
            __L1.H
        )
        __L1.game:drawMain(c, __L1.st)
        for ____, q in __iterar((__L1.st.pop)) do
            __L1:txt(
                c,
                q.s,
                q.x * 2,
                q.y * 2 - q.t * 40,
                14,
                "#fff3a0"
            )
        end
        if __t(__L1.st.banner) then
            __L1:txt(
                c,
                __L1.st.banner.s,
                __L1.W / 2,
                200,
                30,
                "#fff3a0"
            )
        end
        if __L1.screen == "count" then
            c.fillStyle = "rgba(10,8,12,.55)"
            c:fillRect(0, 0, __L1.W, __L1.H)
            local n = math.ceil(__L1.cd)
            local ____L1_txt_596 = __L1.txt
            local ____c_595 = c
            local ____temp_594
            if n > 0 then
                ____temp_594 = tostring(n)
            else
                ____temp_594 = "VAI!"
            end
            ____L1_txt_596(
                __L1,
                ____c_595,
                ____temp_594,
                __L1.W / 2,
                220,
                64,
                "#ffd75a"
            )
            __L1:frame(
                c,
                250,
                300,
                460,
                120,
                "#2a2018",
                __L1.game.color,
                "#3a2a2a"
            )
            __L1:txt(
                c,
                __L1.game.name,
                __L1.W / 2,
                326,
                13,
                "#fff"
            )
            __call(
                __L1.game.controls,
                "forEach",
                function(____, l, i) return __L1:txt(
                    c,
                    l,
                    __L1.W / 2,
                    354 + i * 22,
                    11,
                    "#e8d8b0",
                    "center",
                    nil
                ) end
            )
            if __L1.st.mode == "duo" then
                __L1:txt(
                    c,
                    "P1: WASD + J/K   ·   P2: setas + Enter/Shift",
                    __L1.W / 2,
                    400,
                    9,
                    "#c8b890",
                    "center",
                    nil
                )
            end
        end
        local ____t_598 = __t
        local ____t_result_597
        if __t(__L1.st.ended) then
            ____t_result_597 = __L1.screen == "play"
        else
            ____t_result_597 = __L1.st.ended
        end
        if ____t_598(____t_result_597) then
            __L1:txt(
                c,
                __t(__L1.st.mode == "duo" and __L1.game.duo == "versus") and "FIM!" or "FIM DE JOGO",
                __L1.W / 2,
                250,
                40,
                "#fff3a0"
            )
        end
        c:restore()
        __L1.clicks = __arrL({}, 0)
        if __t(__L1.paused) then
            c.fillStyle = "rgba(10,8,12,.7)"
            c:fillRect(0, 0, __L1.W, __L1.H)
            __L1:frame(
                c,
                330,
                160,
                300,
                220,
                "#2a2018",
                "#e8c27a"
            )
            __L1:txt(
                c,
                "PAUSA",
                __L1.W / 2,
                200,
                22,
                "#fff"
            )
            __L1:button(
                c,
                "CONTINUAR",
                380,
                230,
                200,
                50,
                __L1.pauseSel == 0,
                function()
                    __L1.paused = false
                end
            )
            __L1:button(
                c,
                "SAIR DO JOGO",
                380,
                296,
                200,
                50,
                __L1.pauseSel == 1,
                function()
                    __L1.paused = false
                    __L1.screen = "menu"
                end
            )
        end
    end
    __L1.loop = function(self, now)
        if not __t(__L1.open) then
            return
        end
        local ____t_result_601
        local ____t_600 = __t
        local ____temp_599 = (now - __L1.last) / 1000
        __O[1251] = ____temp_599
        if ____t_600(____temp_599) then
            ____t_result_601 = __O[1251]
        else
            ____t_result_601 = 0
        end
        local dt = math.min(0.05, ____t_result_601)
        __L1.last = now
        __L1.t = __L1.t + dt
        __L1:pollInput()
        local ____t_605 = __t
        local ____t_result_604
        local ____t_603 = __t
        local ____t_result_602
        if __t(__L1.net) then
            ____t_result_602 = __L1.net.role == "guest"
        else
            ____t_result_602 = __L1.net
        end
        __O[1252] = ____t_result_602
        if ____t_603(____t_result_602) then
            ____t_result_604 = __L1.net.live
        else
            ____t_result_604 = __O[1252]
        end
        if ____t_605(____t_result_604) then
            __L1:guestTick()
        else
            local ____t_result_612
            local ____t_611 = __t
            local ____t_result_610
            local ____t_609 = __t
            local ____t_result_608
            local ____t_607 = __t
            local ____t_result_606
            if __t(__L1.net) then
                ____t_result_606 = __L1.net.role == "host"
            else
                ____t_result_606 = __L1.net
            end
            __O[1253] = ____t_result_606
            if ____t_607(____t_result_606) then
                ____t_result_608 = __L1.net.live
            else
                ____t_result_608 = __O[1253]
            end
            __O[1254] = ____t_result_608
            if ____t_609(____t_result_608) then
                ____t_result_610 = not __t(__L1:peerLive())
            else
                ____t_result_610 = __O[1254]
            end
            __O[1255] = ____t_result_610
            if ____t_611(____t_result_610) then
                ____t_result_612 = __L1.screen == "play" or __L1.screen == "count"
            else
                ____t_result_612 = __O[1255]
            end
            local away = ____t_result_612
            local ____L1_updateScreens_615 = __L1.updateScreens
            local ____t_614 = __t
            local ____t_result_613
            if __t(__L1.paused) then
                ____t_result_613 = __L1.paused
            else
                ____t_result_613 = away
            end
            ____L1_updateScreens_615(
                __L1,
                ____t_614(____t_result_613) and 0 or dt
            )
            local ____t_617 = __t
            local ____t_result_616
            if __t(__L1.net) then
                ____t_result_616 = __L1.net.role == "host"
            else
                ____t_result_616 = __L1.net
            end
            if ____t_617(____t_result_616) then
                __L1:hostTick(now)
            end
        end
        __L1.ctx:save()
        __L1.ctx.imageSmoothingEnabled = false
        if __t(__L1.screen == "play" or __L1.screen == "count") then
            __L1:drawPlay(__L1.ctx)
        else
            local ____t_619 = __t
            local ____t_result_618
            if __t(__L1.st) then
                ____t_result_618 = __L1.screen == "over"
            else
                ____t_result_618 = __L1.st
            end
            if ____t_619(____t_result_618) then
                __L1:drawPlay(__L1.ctx)
            end
            __L1:drawScreens(__L1.ctx)
        end
        if __t(__L1.net) then
            __L1:drawNetBar(__L1.ctx)
        end
        if __t(__L1.tv) then
            __L1:tvSync()
            local ____t_623 = __t
            local ____t_result_622
            local ____t_621 = __t
            local ____temp_620 = __L1.screen ~= "tv"
            __O[1256] = ____temp_620
            if ____t_621(____temp_620) then
                ____t_result_622 = __L1.tv.code
            else
                ____t_result_622 = __O[1256]
            end
            if ____t_623(____t_result_622) then
                __L1.ctx:save()
                __L1.ctx.fillStyle = "rgba(10,14,24,.7)"
                __L1.ctx:fillRect(__L1.W - 230, __L1.H - 22, 226, 20)
                __L1:txt(
                    __L1.ctx,
                    __add(
                        __add(
                            __add(
                                __add(
                                    __add("TV · SALA ", __L1.tv.code),
                                    " · "
                                ),
                                __len(__L1.tv.phones)
                            ),
                            " CELULAR"
                        ),
                        __len(__L1.tv.phones) == 1 and "" or "ES"
                    ),
                    __L1.W - 117,
                    __L1.H - 12,
                    9,
                    "#ffd75a",
                    "center",
                    nil
                )
                __L1.ctx:restore()
            end
        end
        __L1.ctx:restore()
        if __t(__L1.touchUI) then
            local ____L1_touchUI_dataset_632 = __L1.touchUI.dataset
            local ____t_result_631
            if __t(__L1.tv) then
                ____t_result_631 = "menu"
            else
                local ____t_result_630
                local ____t_627 = __t
                local ____t_result_626
                local ____t_625 = __t
                local ____temp_624 = __L1.screen == "play" or __L1.screen == "count"
                __O[1257] = ____temp_624
                if ____t_625(____temp_624) then
                    ____t_result_626 = not __t(__L1.paused)
                else
                    ____t_result_626 = __O[1257]
                end
                if ____t_627(____t_result_626) then
                    local ____t_629 = __t
                    local ____t_result_628
                    if __t(__L1.solo) then
                        ____t_result_628 = __L1.solo
                    else
                        ____t_result_628 = __L1.net
                    end
                    ____t_result_630 = ____t_629(____t_result_628) and "solo" or "duo"
                else
                    ____t_result_630 = "menu"
                end
                ____t_result_631 = ____t_result_630
            end
            ____L1_touchUI_dataset_632.mode = ____t_result_631
        end
        __L1.raf = window:requestAnimationFrame(__L1.loop)
    end
    __L1.build = function(self)
        if __t(__L1.root) then
            return
        end
        __L1.root = window.document:createElement("div")
        __L1.root.id = "fliperama"
        __L1.root.className = "fliperama"
        __L1.root.hidden = true
        __L1.root:setAttribute("role", "dialog")
        __L1.root:setAttribute("aria-label", "Fliperama da Roça")
        __L1.cv = window.document:createElement("canvas")
        __L1.cv.width = __L1.W
        __L1.cv.height = __L1.H
        __L1.cv.className = "fliperama-canvas"
        __L1.cv.tabIndex = 0
        __L1.cv:setAttribute("aria-label", "Fliperama da Roça: use as setas e A para escolher")
        __L1.low = window.document:createElement("canvas")
        __L1.low.width = __L1.LW
        __L1.low.height = __L1.LH
        __L1.g = __L1.low:getContext("2d")
        __L1.ctx = __L1.cv:getContext("2d")
        local close = window.document:createElement("button")
        close.className = "fliperama-close"
        close.type = "button"
        close.textContent = "✕"
        close:setAttribute("aria-label", "Voltar")
        close:addEventListener("click", __L1.back)
        __L1.touchUI = window.document:createElement("div")
        __L1.touchUI.className = "fliperama-touch"
        __L1.touchUI.dataset.mode = "menu"
        local function pad(____, i, side)
            local box = window.document:createElement("div")
            box.className = __add(
                __add(
                    __add("fp-pad fp-", side),
                    " fp-p"
                ),
                i + 1
            )
            local dirs = __arrL(
                {
                    __arrL({"u", 0, -1, "▲"}, 4),
                    __arrL({"l", -1, 0, "◀"}, 4),
                    __arrL({"r", 1, 0, "▶"}, 4),
                    __arrL({"d", 0, 1, "▼"}, 4)
                },
                4
            )
            local dp = window.document:createElement("div")
            dp.className = "fp-dpad"
            for ____, ____value in __iterar((dirs)) do
                local n = ____value[1]
                local x = ____value[2]
                local y = ____value[3]
                local s = ____value[4]
                local b = window.document:createElement("button")
                b.type = "button"
                b.className = __add("fp-dir fp-", n)
                b.textContent = s
                __L1:bindHold(
                    b,
                    function(____, on)
                        if __t(x) then
                            local ____get_result_634 = __get(__L1.touch, i)
                            local ____t_result_633
                            if __t(on) then
                                ____t_result_633 = x
                            else
                                ____t_result_633 = __get(__L1.touch, i).x == x and 0 or __get(__L1.touch, i).x
                            end
                            ____get_result_634.x = ____t_result_633
                        end
                        if __t(y) then
                            local ____get_result_636 = __get(__L1.touch, i)
                            local ____t_result_635
                            if __t(on) then
                                ____t_result_635 = y
                            else
                                ____t_result_635 = __get(__L1.touch, i).y == y and 0 or __get(__L1.touch, i).y
                            end
                            ____get_result_636.y = ____t_result_635
                        end
                    end
                )
                dp:append(b)
            end
            local ab = window.document:createElement("div")
            ab.className = "fp-ab"
            for ____, n in __iterar((__arrL({"a", "b"}, 2))) do
                local b = window.document:createElement("button")
                b.type = "button"
                b.className = __add("fp-btn fp-", n)
                b.textContent = __call(n, "toUpperCase")
                __L1:bindHold(
                    b,
                    function(____, on)
                        __set(
                            __get(__L1.touch, i),
                            n,
                            on
                        )
                    end
                )
                ab:append(b)
            end
            if side == "left" then
                box:append(dp, ab)
            else
                box:append(ab, dp)
            end
            return box
        end
        __L1.touchUI:append(
            pad(nil, 0, "left"),
            pad(nil, 1, "right")
        )
        __L1.root:append(__L1.cv, __L1.touchUI, close)
        local ____t_result_639
        local ____t_638 = __t
        local ____temp_637 = window.document:getElementById("gameShell")
        __O[1258] = ____temp_637
        if ____t_638(____temp_637) then
            ____t_result_639 = __O[1258]
        else
            ____t_result_639 = window.document.body
        end
        ____t_result_639:append(__L1.root)
        __L1.cv:addEventListener(
            "pointerdown",
            function(____, e)
                local r = __L1.cv:getBoundingClientRect()
                local x = (e.clientX - r.left) / r.width * __L1.W
                local y = (e.clientY - r.top) / r.height * __L1.H
                local ____t_650 = __t
                local ____t_result_649
                local ____t_646 = __t
                local ____t_result_645
                local ____t_641 = __t
                local ____temp_640 = __L1.screen == "play" and not __t(__L1.paused)
                __O[1259] = ____temp_640
                if ____t_641(____temp_640) then
                    local ____t_644 = __t
                    local ____opt_642 = __L1.st
                    if ____opt_642 ~= nil then
                        ____opt_642 = ____opt_642.ended
                    end
                    ____t_result_645 = not ____t_644(____opt_642)
                else
                    ____t_result_645 = __O[1259]
                end
                __O[1260] = ____t_result_645
                if ____t_646(____t_result_645) then
                    local ____opt_647 = __L1.game
                    if ____opt_647 ~= nil then
                        ____opt_647 = ____opt_647.tap
                    end
                    ____t_result_649 = ____opt_647
                else
                    ____t_result_649 = __O[1260]
                end
                if ____t_650(____t_result_649) then
                    e:preventDefault()
                    __L1.game:tap(__L1.st, x / 2, y / 2)
                    return
                end
                for ____, k in __iterar((__call(
                    __call(__L1.clicks, "slice"),
                    "reverse"
                ))) do
                    local ____t_656 = __t
                    local ____t_result_655
                    local ____t_654 = __t
                    local ____t_result_653
                    local ____t_652 = __t
                    local ____temp_651 = __ge(x, k.x) and __le(
                        x,
                        __add(k.x, k.w)
                    )
                    __O[1261] = ____temp_651
                    if ____t_652(____temp_651) then
                        ____t_result_653 = __ge(y, k.y)
                    else
                        ____t_result_653 = __O[1261]
                    end
                    __O[1262] = ____t_result_653
                    if ____t_654(____t_result_653) then
                        ____t_result_655 = __le(
                            y,
                            __add(k.y, k.h)
                        )
                    else
                        ____t_result_655 = __O[1262]
                    end
                    if ____t_656(____t_result_655) then
                        e:preventDefault()
                        k:act()
                        return
                    end
                end
            end
        )
        window:addEventListener(
            "keydown",
            function(____, e)
                local ____t_660 = __t
                local ____temp_659 = not __t(__L1.open)
                if not ____temp_659 then
                    local ____opt_657 = e.target
                    ____temp_659 = (____opt_657 and ____opt_657.tagName) == "INPUT"
                end
                if ____t_660(____temp_659) then
                    return
                end
                if __t(e.code == "Escape" or e.code == "Backspace") then
                    e:preventDefault()
                    __L1:back()
                else
                    local ____t_664 = __t
                    local ____t_result_663
                    local ____t_662 = __t
                    local ____temp_661 = e.code == "KeyP"
                    __O[1263] = ____temp_661
                    if ____t_662(____temp_661) then
                        ____t_result_663 = __L1.screen == "play" or __L1.screen == "count"
                    else
                        ____t_result_663 = __O[1263]
                    end
                    if ____t_664(____t_result_663) then
                        __L1:back()
                    end
                end
                __set(__L1.keys, e.code, true)
                if not __t(e["repeat"]) then
                    __call(__L1.latch, "add", e.code)
                end
                local ____t_672 = __t
                local ____t_result_671
                local ____t_670 = __t
                local ____t_result_669
                local ____t_668 = __t
                local ____t_result_667
                local ____t_666 = __t
                local ____temp_665 = e.code == "KeyO" and __L1.screen == "menu"
                __O[1264] = ____temp_665
                if ____t_666(____temp_665) then
                    ____t_result_667 = not __t(__L1.net)
                else
                    ____t_result_667 = __O[1264]
                end
                __O[1265] = ____t_result_667
                if ____t_668(____t_result_667) then
                    ____t_result_669 = not __t(__L1.tv)
                else
                    ____t_result_669 = __O[1265]
                end
                __O[1266] = ____t_result_669
                if ____t_670(____t_result_669) then
                    ____t_result_671 = not __t(e["repeat"])
                else
                    ____t_result_671 = __O[1266]
                end
                if ____t_672(____t_result_671) then
                    __L1:openOnline()
                end
                local ____t_678 = __t
                local ____t_result_677
                local ____t_676 = __t
                local ____t_result_675
                local ____t_674 = __t
                local ____temp_673 = e.code == "KeyT" and __L1.screen == "menu"
                __O[1267] = ____temp_673
                if ____t_674(____temp_673) then
                    ____t_result_675 = not __t(__L1.net)
                else
                    ____t_result_675 = __O[1267]
                end
                __O[1268] = ____t_result_675
                if ____t_676(____t_result_675) then
                    ____t_result_677 = not __t(e["repeat"])
                else
                    ____t_result_677 = __O[1268]
                end
                if ____t_678(____t_result_677) then
                    __L1:openTV()
                end
                local ____t_684 = __t
                local ____t_result_683
                local ____t_682 = __t
                local ____t_result_681
                local ____t_680 = __t
                local ____call_result_679 = __call(e.code, "startsWith", "Arrow")
                __O[1269] = ____call_result_679
                if ____t_680(____call_result_679) then
                    ____t_result_681 = __O[1269]
                else
                    ____t_result_681 = e.code == "Space"
                end
                __O[1270] = ____t_result_681
                if ____t_682(____t_result_681) then
                    ____t_result_683 = __O[1270]
                else
                    ____t_result_683 = e.code == "Enter"
                end
                if ____t_684(____t_result_683) then
                    e:preventDefault()
                end
                e:stopImmediatePropagation()
            end,
            true
        )
        window:addEventListener(
            "keyup",
            function(____, e)
                __set(__L1.keys, e.code, false)
                if __t(__L1.open) then
                    e:stopImmediatePropagation()
                end
            end,
            true
        )
        window:addEventListener(
            "blur",
            function()
                for ____, k in __iterar((__keys(__L1.keys))) do
                    __set(__L1.keys, k, false)
                end
            end
        )
    end
    __L1.bindHold = function(self, b, fn)
        local function on(____, e)
            e:preventDefault()
            __call(b.classList, "add", "on")
            fn(nil, true)
            do
                pcall(function()
                    b:setPointerCapture(e.pointerId)
                end)
            end
        end
        local function off(____, e)
            b.classList:remove("on")
            fn(nil, false)
        end
        b:addEventListener("pointerdown", on)
        b:addEventListener("pointerup", off)
        b:addEventListener("pointercancel", off)
        b:addEventListener("lostpointercapture", off)
    end
    __L1.openUp = function(self, id, opts)
        if opts == nil then
            opts = {}
        end
        __L1:build()
        if __t(__L1.open) then
            return
        end
        local ____t_result_685
        if __t(opts.from) then
            ____t_result_685 = opts.from
        else
            ____t_result_685 = nil
        end
        __L1.from = ____t_result_685
        local ____t_result_689
        local ____t_688 = __t
        local ____opt_686 = window.Game
        if ____opt_686 ~= nil then
            ____opt_686 = ____opt_686.soundOn
        end
        if ____t_688(____opt_686) then
            ____t_result_689 = not __t(window.Game:soundOn()) and __L1.from ~= "title"
        else
            ____t_result_689 = false
        end
        __L1.muted = ____t_result_689
        __L1.open = true
        __L1.root.hidden = false
        __L1.screen = "menu"
        __L1.paused = false
        __L1.modeSel = 0
        local i = __call(
            __L1.GAMES,
            "findIndex",
            function(____, x) return x.id == id end
        )
        if i >= 0 then
            __L1.sel = i
            __L1.screen = "mode"
        end
        for ____, k in __iterar((__keys(__L1.keys))) do
            __set(__L1.keys, k, false)
        end
        __call(
            __L1.touch,
            "forEach",
            function(____, x) return __assign(x, {x = 0, y = 0, a = false, b = false}) end
        )
        window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {active = true}}))
        local ____callq_692 = __callq
        local ____opt_690 = window.document:getElementById("gameShell")
        ____callq_692(____opt_690 and ____opt_690.classList, "add", "is-fliperama")
        __L1.last = window.performance:now()
        __L1.raf = window:requestAnimationFrame(__L1.loop)
        window:setTimeout(
            function() return __L1.cv:focus() end,
            30
        )
    end
    __L1.close = function(self)
        if not __t(__L1.open) then
            return
        end
        __L1:closeTV()
        __L1.open = false
        __L1.root.hidden = true
        window:cancelAnimationFrame(__L1.raf)
        for ____, k in __iterar((__keys(__L1.keys))) do
            __set(__L1.keys, k, false)
        end
        window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {active = false}}))
        local ____opt_693 = window.document:getElementById("gameShell")
        if ____opt_693 ~= nil then
            ____opt_693.classList:remove("is-fliperama")
        end
        __L1:updateInventory()
        local ____opt_697 = window.document:getElementById("gameCanvas")
        local ____opt_695 = ____opt_697 and ____opt_697.focus
        if ____opt_695 ~= nil then
            ____opt_695(____opt_697)
        end
    end
    __L1.near = function(self, scene, x)
        local ____call_702 = __call
        local ____t_result_701
        local ____t_700 = __t
        local ____get_result_699 = __get(__L1.CABINETS, scene)
        __O[1271] = ____get_result_699
        if ____t_700(____get_result_699) then
            ____t_result_701 = __O[1271]
        else
            ____t_result_701 = __arrL({}, 0)
        end
        return ____call_702(
            ____t_result_701,
            "some",
            function(____, cx) return math.abs(cx - x) < 46 end
        )
    end
    __L1.drawCabinet = function(self, c, x, y, tm)
        local function P2(____, a, b, w, h, col)
            c.fillStyle = col
            c:fillRect(
                math.floor(__add(x, a) + 0.5),
                math.floor(__add(y, b) + 0.5),
                w,
                h
            )
        end
        P2(
            nil,
            -22,
            -2,
            44,
            4,
            "rgba(18,30,52,.35)"
        )
        P2(
            nil,
            -18,
            -92,
            36,
            92,
            "#2a1a3a"
        )
        P2(
            nil,
            -16,
            -90,
            32,
            88,
            "#5a2a6a"
        )
        P2(
            nil,
            -18,
            -100,
            36,
            12,
            "#1a1020"
        )
        P2(
            nil,
            -16,
            -98,
            32,
            8,
            math.sin(tm * 5) > -0.6 and "#ff6ab0" or "#a03a70"
        )
        c.fillStyle = "#fff"
        c.font = "6px Pixel, monospace"
        c.textAlign = "center"
        c.textBaseline = "middle"
        c:fillText("FLIPER", x, y - 94)
        P2(
            nil,
            -14,
            -84,
            28,
            24,
            "#0a0a14"
        )
        P2(
            nil,
            -12,
            -82,
            24,
            20,
            __get(
                __arrL({"#1a3a5a", "#3a1a5a", "#1a5a3a"}, 3),
                __mod(
                    math.floor(tm * 1.5),
                    3
                )
            )
        )
        do
            local i = 0
            while i < 4 do
                P2(
                    nil,
                    -10 + __mod(tm * 18 + i * 7, 20),
                    -78 + __mod(i * 5, 14),
                    2,
                    2,
                    __get(
                        __arrL({"#ffd75a", "#7ad1ff", "#ff8fb0", "#7af07a"}, 4),
                        i
                    )
                )
                i = i + 1
            end
        end
        P2(
            nil,
            -18,
            -58,
            36,
            10,
            "#3a1a4a"
        )
        P2(
            nil,
            -10,
            -56,
            4,
            4,
            "#e84a3a"
        )
        P2(
            nil,
            4,
            -56,
            4,
            4,
            "#4ae84a"
        )
        P2(
            nil,
            10,
            -55,
            3,
            3,
            "#e8e84a"
        )
        P2(
            nil,
            -8,
            -60,
            2,
            4,
            "#c8c8c8"
        )
        P2(
            nil,
            -12,
            -44,
            24,
            30,
            "#4a2058"
        )
        P2(
            nil,
            -6,
            -36,
            12,
            4,
            "#ffd75a"
        )
        P2(
            nil,
            -4,
            -30,
            8,
            2,
            "#1a1020"
        )
    end
    __L1.drawTrophies = function(self, c, x, y)
        local function P2(____, a, b, w, h, col)
            c.fillStyle = col
            c:fillRect(
                math.floor(__add(x, a) + 0.5),
                math.floor(__add(y, b) + 0.5),
                w,
                h
            )
        end
        P2(
            nil,
            -4,
            -2,
            92,
            4,
            "rgba(18,30,52,.35)"
        )
        P2(
            nil,
            0,
            -60,
            84,
            60,
            "#6a4a2a"
        )
        P2(
            nil,
            2,
            -58,
            80,
            56,
            "#8a6a3a"
        )
        P2(
            nil,
            0,
            -32,
            84,
            3,
            "#5a3a22"
        )
        P2(
            nil,
            0,
            -62,
            84,
            4,
            "#5a3a22"
        )
        __call(
            __call(__L1.GAMES, "slice", 0, 10),
            "forEach",
            function(____, gm, i)
                local m = __L1:rec(gm.id).medal
                local tx = 6 + __mod(i, 5) * 16
                local ty = i < 5 and -34 or -6
                local ____t_result_703
                if __t(m) then
                    ____t_result_703 = __get(__L1.MEDAL_COL, m)
                else
                    ____t_result_703 = "rgba(40,30,20,.45)"
                end
                local col = ____t_result_703
                P2(
                    nil,
                    tx + 2,
                    ty - 18,
                    10,
                    8,
                    col
                )
                P2(
                    nil,
                    tx + 5,
                    ty - 10,
                    4,
                    5,
                    col
                )
                P2(
                    nil,
                    tx + 3,
                    ty - 5,
                    8,
                    3,
                    col
                )
                if __t(m) then
                    P2(
                        nil,
                        tx + 3,
                        ty - 17,
                        2,
                        4,
                        "rgba(255,255,255,.6)"
                    )
                end
            end
        )
    end
    __L1.drawWorld = function(self, c, o)
        local ____t_705 = __t
        local ____t_result_704
        if __t(o.arena) then
            ____t_result_704 = o.arena
        else
            ____t_result_704 = o.room
        end
        if ____t_705(____t_result_704) then
            return
        end
        local list = __get(__L1.CABINETS, o.scene)
        if not __t(list) then
            return
        end
        for ____, x in __iterar((list)) do
            do
                if __t(x - o.camera < -60 or x - o.camera > 1020) then
                    continue
                end
                local ____L1_drawCabinet_708 = __L1.drawCabinet
                local ____c_707 = c
                local ____t_result_706
                if __t(o.time) then
                    ____t_result_706 = o.time
                else
                    ____t_result_706 = 0
                end
                ____L1_drawCabinet_708(
                    __L1,
                    ____c_707,
                    x,
                    440,
                    ____t_result_706
                )
                if o.scene == 0 then
                    __L1:drawTrophies(c, x + 60, 440)
                end
            end
        end
    end
    __L1.addEntries = function(self)
        local entries = window.document:querySelector("#startScreen .ranch-mode-entries")
        local ____t_710 = __t
        local ____t_result_709
        if __t(entries) then
            ____t_result_709 = not __t(entries:querySelector("[data-open-tv]"))
        else
            ____t_result_709 = entries
        end
        if ____t_710(____t_result_709) then
            local b = window.document:createElement("button")
            b.type = "button"
            b.dataset.openTv = "1"
            b.innerHTML = "<b>📺 MODO TV</b><small>a TV mostra · o celular é o controle · até 4</small>"
            b:addEventListener(
                "click",
                function()
                    __L1:openUp(nil, {from = "title"})
                    __L1:openTV()
                end
            )
            entries:append(b)
            if __t(window.DAROCA_TV) then
                entries:prepend(b)
            end
        end
        local ____t_712 = __t
        local ____t_result_711
        if __t(entries) then
            ____t_result_711 = not __t(entries:querySelector("[data-open-fliperama]"))
        else
            ____t_result_711 = entries
        end
        if ____t_712(____t_result_711) then
            local b = window.document:createElement("button")
            b.type = "button"
            b.dataset.openFliperama = "1"
            b.innerHTML = "<b>🕹 FLIPERAMA</b><small>10 minigames · sozinho ou em dupla</small>"
            b:addEventListener(
                "click",
                function() return __L1:openUp(nil, {from = "title"}) end
            )
            entries:append(b)
        end
        local modal = window.document:querySelector("#pauseScreen .game-modal")
        local ____t_714 = __t
        local ____t_result_713
        if __t(modal) then
            ____t_result_713 = not __t(modal:querySelector("[data-open-fliperama]"))
        else
            ____t_result_713 = modal
        end
        if ____t_714(____t_result_713) then
            local b = window.document:createElement("button")
            b.type = "button"
            b.className = "text-button"
            b.dataset.openFliperama = "1"
            b.textContent = "Fliperama da Roça"
            b:addEventListener(
                "click",
                function() return __L1:openUp(nil, {from = "pause"}) end
            )
            modal:append(b)
        end
        __L1:updateInventory()
    end
    __L1.updateInventory = function(self)
        local panel = window.document:getElementById("hudInvPanel")
        if not __t(panel) then
            return
        end
        local row = panel:querySelector(".hud-fliperama")
        if not __t(row) then
            row = window.document:createElement("div")
            row.className = "hud-row hud-fliperama"
            local btn = window.document:createElement("button")
            btn.type = "button"
            btn.className = "hud-fliperama-btn"
            btn.textContent = "JOGAR"
            btn:addEventListener(
                "click",
                function() return __L1:openUp(nil, {from = "inventory"}) end
            )
            row.innerHTML = "<span>🕹 FLIPERAMA</span><b class=\"hud-fp-count\"></b>"
            row:append(btn)
            panel:append(row)
        end
        local medals = __call(
            __call(
                __L1.GAMES,
                "map",
                function(____, gm) return __L1:rec(gm.id).medal end
            ),
            "filter",
            window.Boolean
        )
        local gold = __len(__call(
            medals,
            "filter",
            function(____, m) return m == 3 end
        ))
        local ____temp_718 = row:querySelector(".hud-fp-count")
        local ____add_717 = __add
        local ____add_result_716 = __add(
            __add(
                __add(
                    __add(
                        __add(__L1.data.fichas, " fichas · "),
                        __len(medals)
                    ),
                    "/"
                ),
                __len(__L1.GAMES)
            ),
            " medalhas"
        )
        local ____t_result_715
        if __t(gold) then
            ____t_result_715 = __add(
                __add(" (", gold),
                " ouro)"
            )
        else
            ____t_result_715 = ""
        end
        ____temp_718.textContent = ____add_717(____add_result_716, ____t_result_715)
    end
    local ____ = "use strict"
    if __t(window.Fliperama) then
        return
    end
    __L1.W = 960
    __L1.H = 540
    __L1.LW = 480
    __L1.LH = 270
    __L1.KEY = "daroca-fliperama-v1"
    __L1.clamp = function(____, v, a, b) return math.max(
        a,
        math.min(b, v)
    ) end
    __L1.rnd = function(____, a, b) return a + math.random() * (b - a) end
    __L1.irnd = function(____, a, b) return math.floor(__L1:rnd(a, b + 1)) end
    __L1.hash = function(____, n)
        local x = math.sin(n * 127.1 + 311.7) * 43758.5453
        return x - math.floor(x)
    end
    __L1.MEDALS = __arrL({"", "BRONZE", "PRATA", "OURO"}, 4)
    __L1.MEDAL_COL = __arrL({"#7a7a7a", "#c98a4a", "#cfd6dc", "#ffd75a"}, 4)
    __L1.data = __ord(
        {
            fichas = 0,
            games = {},
            unlocked = __arrL({"daroca", "reeis"}, 2),
            avatar = __arrL({"daroca", "reeis"}, 2)
        },
        "fichas,games,unlocked,avatar"
    )
    do
        pcall(function()
            local d = window.JSON:parse(window.localStorage:getItem(__L1.KEY))
            local ____t_720 = __t
            local ____t_result_719
            if __t(d) then
                ____t_result_719 = type(d) == "table"
            else
                ____t_result_719 = d
            end
            if ____t_720(____t_result_719) then
                local ____ord_729 = __ord
                local ____t_result_723
                local ____t_722 = __t
                local ____TS__Number_result_721 = __TS__Number(d.fichas)
                __O[1098] = ____TS__Number_result_721
                if ____t_722(____TS__Number_result_721) then
                    ____t_result_723 = __O[1098]
                else
                    ____t_result_723 = 0
                end
                local ____t_result_726
                local ____t_725 = __t
                local ____t_result_724
                if __t(d.games) then
                    ____t_result_724 = type(d.games) == "table"
                else
                    ____t_result_724 = d.games
                end
                if ____t_725(____t_result_724) then
                    ____t_result_726 = d.games
                else
                    ____t_result_726 = {}
                end
                local ____isArray_result_727
                if __isArray(d.unlocked) then
                    ____isArray_result_727 = d.unlocked
                else
                    ____isArray_result_727 = __arrL({"daroca", "reeis"}, 2)
                end
                local ____t_result_728
                if __t(__isArray(d.avatar) and __len(d.avatar) == 2) then
                    ____t_result_728 = d.avatar
                else
                    ____t_result_728 = __arrL({"daroca", "reeis"}, 2)
                end
                __L1.data = ____ord_729({fichas = ____t_result_723, games = ____t_result_726, unlocked = ____isArray_result_727, avatar = ____t_result_728}, "fichas,games,unlocked,avatar")
            end
        end)
    end
    __L1.persist = function()
        do
            pcall(function()
                window.localStorage:setItem(
                    __L1.KEY,
                    window.JSON:stringify(__L1.data)
                )
            end)
        end
    end
    __L1.rec = function(____, id)
        local ____set_735 = __set
        local ____L1_data_games_733 = __L1.data.games
        local ____id_734 = id
        local ____t_result_732
        local ____t_731 = __t
        local ____get_result_730 = __get(__L1.data.games, id)
        __O[1099] = ____get_result_730
        if ____t_731(____get_result_730) then
            ____t_result_732 = __O[1099]
        else
            ____t_result_732 = {
                solo = __arrL({}, 0),
                duo = __arrL({}, 0),
                medal = 0,
                plays = 0,
                wins = __arrL({0, 0}, 2)
            }
        end
        return ____set_735(____L1_data_games_733, ____id_734, ____t_result_732)
    end
    __L1.actx = nil
    __L1.muted = false
    __L1.keys = {}
    __L1.touch = __call(
        __arrL({0, 1, 2, 3}, 4),
        "map",
        function() return {x = 0, y = 0, a = false, b = false} end
    )
    __L1.P = __call(
        __arrL({0, 1, 2, 3}, 4),
        "map",
        function() return {
            x = 0,
            y = 0,
            a = false,
            b = false,
            ap = false,
            bp = false,
            dirs = __arrL({}, 0),
            px = 0,
            py = 0,
            pa = false,
            pb = false
        } end
    )
    __L1.solo = true
    __L1.anyPress = __ord({
        a = false,
        b = false,
        back = false,
        up = false,
        down = false,
        left = false,
        right = false
    }, "a,b,back,up,down,left,right")
    __L1.K1 = __ord(
        {
            up = __arrL({"KeyW"}, 1),
            down = __arrL({"KeyS"}, 1),
            left = __arrL({"KeyA"}, 1),
            right = __arrL({"KeyD"}, 1),
            a = __arrL({"KeyJ", "Space"}, 2),
            b = __arrL({"KeyK"}, 1)
        },
        "up,down,left,right,a,b"
    )
    __L1.K2 = __ord(
        {
            up = __arrL({"ArrowUp"}, 1),
            down = __arrL({"ArrowDown"}, 1),
            left = __arrL({"ArrowLeft"}, 1),
            right = __arrL({"ArrowRight"}, 1),
            a = __arrL({"Enter", "NumpadEnter", "Period", "Numpad0"}, 4),
            b = __arrL({"ShiftRight", "Comma", "Numpad1"}, 3)
        },
        "up,down,left,right,a,b"
    )
    __L1.latch = __TS__New(Set)
    __L1.held = function(____, list) return __call(
        list,
        "some",
        function(____, k)
            local ____t_result_738
            local ____t_737 = __t
            local ____get_result_736 = __get(__L1.keys, k)
            __O[1102] = ____get_result_736
            if ____t_737(____get_result_736) then
                ____t_result_738 = __O[1102]
            else
                ____t_result_738 = __call(__L1.latch, "has", k)
            end
            return ____t_result_738
        end
    ) end
    __L1.menuNav = __ord({start = false, pstart = false}, "start,pstart")
    __L1.root = nil
    __L1.cv = nil
    __L1.ctx = nil
    __L1.low = nil
    __L1.g = nil
    __L1.touchUI = nil
    __L1.R = function(____, c, x, y, w, h, col)
        c.fillStyle = col
        c:fillRect(
            math.floor(x + 0.5),
            math.floor(y + 0.5),
            math.floor(w + 0.5),
            math.floor(h + 0.5)
        )
    end
    __L1.AV_NAMES = __ord({
        daroca = "DA ROÇA",
        reeis = "REEIS",
        lucas = "LUCAS",
        nikolas = "NIKOLAS",
        aica = "AICA",
        ravile = "RAVILE",
        freddy = "FREDDY",
        dede = "DEDÉ",
        caleb = "CALEB",
        mota = "MOTA",
        menezes = "MENEZES",
        nicolas = "NICOLAS",
        rayssa = "RAYSSA",
        allef = "ALLEF"
    }, "daroca,reeis,lucas,nikolas,aica,ravile,freddy,dede,caleb,mota,menezes,nicolas,rayssa,allef")
    __L1.SHOP = __arrL(
        {
            __arrL({"daroca", 0}, 2),
            __arrL({"reeis", 0}, 2),
            __arrL({"lucas", 10}, 2),
            __arrL({"nikolas", 15}, 2),
            __arrL({"aica", 20}, 2),
            __arrL({"ravile", 20}, 2),
            __arrL({"freddy", 25}, 2),
            __arrL({"dede", 25}, 2),
            __arrL({"caleb", 30}, 2),
            __arrL({"mota", 30}, 2),
            __arrL({"menezes", 35}, 2),
            __arrL({"nicolas", 35}, 2),
            __arrL({"rayssa", 35}, 2),
            __arrL({"allef", 40}, 2)
        },
        14
    )
    __L1.DEF_AV = __arrL({"daroca", "reeis", "lucas", "aica"}, 4)
    __L1.avOf = function(____, i)
        local ____t_result_752
        local ____t_744 = __t
        local ____getq_743 = __getq
        local ____opt_741 = __L1.tv
        if ____opt_741 ~= nil then
            ____opt_741 = ____opt_741.av
        end
        local ____opt_739 = ____getq_743(____opt_741, i)
        if ____opt_739 ~= nil then
            ____opt_739 = ____opt_739.type
        end
        __O[1124] = ____opt_739
        if ____t_744(____opt_739) then
            ____t_result_752 = __O[1124]
        else
            local ____lt_result_751
            if __lt(i, 2) then
                local ____t_result_750
                local ____t_749 = __t
                local ____getq_747 = __getq
                local ____opt_745 = __L1.net
                if ____opt_745 ~= nil then
                    ____opt_745 = ____opt_745.av
                end
                local ____getq_747_result_748 = ____getq_747(____opt_745, i)
                __O[1123] = ____getq_747_result_748
                if ____t_749(____getq_747_result_748) then
                    ____t_result_750 = __O[1123]
                else
                    ____t_result_750 = __get(__L1.data.avatar, i)
                end
                ____lt_result_751 = ____t_result_750
            else
                ____lt_result_751 = __get(__L1.DEF_AV, i)
            end
            ____t_result_752 = ____lt_result_751
        end
        return ____t_result_752
    end
    __L1.PLAYER_TYPES = __getters(
        {},
        {
            [0] = function()
                return __L1:avOf(0)
            end,
            [1] = function()
                return __L1:avOf(1)
            end,
            [2] = function()
                return __L1:avOf(2)
            end,
            [3] = function()
                return __L1:avOf(3)
            end
        }
    )
    __L1.PLAYER_COL = __arrL({"#ffb347", "#7ad1ff", "#8ad070", "#ff8fb0"}, 4)
    __L1.PLAYER_NAME = __getters(
        {},
        {
            [0] = function()
                local ____t_result_755
                local ____t_754 = __t
                local ____get_result_753 = __get(
                    __L1.AV_NAMES,
                    __get(__L1.PLAYER_TYPES, 0)
                )
                __O[1125] = ____get_result_753
                if ____t_754(____get_result_753) then
                    ____t_result_755 = __O[1125]
                else
                    ____t_result_755 = "P1"
                end
                return ____t_result_755
            end,
            [1] = function()
                local ____t_result_758
                local ____t_757 = __t
                local ____get_result_756 = __get(
                    __L1.AV_NAMES,
                    __get(__L1.PLAYER_TYPES, 1)
                )
                __O[1126] = ____get_result_756
                if ____t_757(____get_result_756) then
                    ____t_result_758 = __O[1126]
                else
                    ____t_result_758 = "P2"
                end
                return ____t_result_758
            end,
            [2] = function()
                local ____t_result_761
                local ____t_760 = __t
                local ____get_result_759 = __get(
                    __L1.AV_NAMES,
                    __get(__L1.PLAYER_TYPES, 2)
                )
                __O[1127] = ____get_result_759
                if ____t_760(____get_result_759) then
                    ____t_result_761 = __O[1127]
                else
                    ____t_result_761 = "P3"
                end
                return ____t_result_761
            end,
            [3] = function()
                local ____t_result_764
                local ____t_763 = __t
                local ____get_result_762 = __get(
                    __L1.AV_NAMES,
                    __get(__L1.PLAYER_TYPES, 3)
                )
                __O[1128] = ____get_result_762
                if ____t_763(____get_result_762) then
                    ____t_result_764 = __O[1128]
                else
                    ____t_result_764 = "P4"
                end
                return ____t_result_764
            end
        }
    )
    __L1.NP = function(____, st)
        local ____t_result_765
        if __t(st.np) then
            ____t_result_765 = st.np
        else
            ____t_result_765 = st.mode == "duo" and 2 or 1
        end
        return ____t_result_765
    end
    __L1.cpuType = function() return __get(__L1.data.avatar, 0) == "nikolas" and "lucas" or "nikolas" end
    __L1.cpuName = function() return __get(
        __L1.AV_NAMES,
        __L1:cpuType()
    ) end
    __L1.GAMES = __arrL({}, 0)
    __call(
        __L1.GAMES,
        "push",
        __ord(
            {
                id = "minhoca",
                name = "MINHOCA DO CAFEZAL",
                sub = "Coma café, cresça e não se enrole.",
                color = "#e86a8a",
                duo = "versus",
                max = 4,
                medals = __arrL({120, 300, 600}, 3),
                rules = __arrL({"Coma os grãos de café para crescer (+10).", "O milho dourado vale +50, mas some rápido.", "Bateu na cerca ou no próprio corpo, acabou."}, 3),
                rulesDuo = __arrL({"Cada um tem sua minhoca e come o que achar.", "Quem bater em corpo ou cerca primeiro perde.", "Cabeça com cabeça: empate."}, 3),
                controls = __arrL({"Direcional: virar a minhoca"}, 1),
                init = function(self, st)
                    st.cols = 58
                    st.rows = 30
                    st.ox = 8
                    st.oy = 18
                    st.cell = 8
                    st.step = 0
                    st.food = __arrL({}, 0)
                    st.gold = nil
                    st.goldT = 10
                    local function mk(____, x, y, dx, col, head)
                        return {
                            body = __call(
                                __arrL({0, 1, 2, 3}, 4),
                                "map",
                                function(____, i) return {x = x - dx * i, y = y} end
                            ),
                            dir = {x = dx, y = 0},
                            q = __arrL({}, 0),
                            alive = true,
                            col = col,
                            head = head,
                            eat = 0
                        }
                    end
                    local starts = __arrL(
                        {
                            __arrL({
                                8,
                                8,
                                1,
                                "#ff8fb0",
                                "#e8507a"
                            }, 5),
                            __arrL({
                                49,
                                21,
                                -1,
                                "#8fe0ff",
                                "#3a9ad0"
                            }, 5),
                            __arrL({
                                8,
                                21,
                                1,
                                "#b8f08a",
                                "#5aa83a"
                            }, 5),
                            __arrL({
                                49,
                                8,
                                -1,
                                "#fff09a",
                                "#d0a830"
                            }, 5)
                        },
                        4
                    )
                    local ____st_767 = st
                    local ____temp_766
                    if st.mode == "duo" then
                        ____temp_766 = __call(
                            __call(
                                starts,
                                "slice",
                                0,
                                __L1:NP(st)
                            ),
                            "map",
                            function(____, a) return mk(
                                nil,
                                __TS__Spread(__iter(a))
                            ) end
                        )
                    else
                        ____temp_766 = __arrL(
                            {mk(
                                nil,
                                10,
                                15,
                                1,
                                "#ff8fb0",
                                "#e8507a"
                            )},
                            1
                        )
                    end
                    ____st_767.worms = ____temp_766
                    do
                        local i = 0
                        while i < 3 do
                            self:spawn(st)
                            i = i + 1
                        end
                    end
                end,
                free = function(self, st, x, y)
                    return not __t(__call(
                        st.worms,
                        "some",
                        function(____, w) return __call(
                            w.body,
                            "some",
                            function(____, b) return b.x == x and b.y == y end
                        ) end
                    )) and not __t(__call(
                        st.food,
                        "some",
                        function(____, f) return f.x == x and f.y == y end
                    ))
                end,
                spawn = function(self, st)
                    do
                        local k = 0
                        while k < 200 do
                            local x = __L1:irnd(1, st.cols - 2)
                            local y = __L1:irnd(1, st.rows - 2)
                            if __t(self:free(st, x, y)) then
                                __call(st.food, "push", {x = x, y = y})
                                return
                            end
                            k = k + 1
                        end
                    end
                end,
                update = function(self, st, dt)
                    __call(
                        st.worms,
                        "forEach",
                        function(____, w, i)
                            local p = __get(__L1.P, i)
                            while __t(__len(p.dirs)) do
                                do
                                    local d = __call(p.dirs, "shift")
                                    local v = __get(
                                        {
                                            u = __arrL({0, -1}, 2),
                                            d = __arrL({0, 1}, 2),
                                            l = __arrL({-1, 0}, 2),
                                            r = __arrL({1, 0}, 2)
                                        },
                                        d
                                    )
                                    local ____t_result_768
                                    if __t(__len(w.q)) then
                                        ____t_result_768 = __get(
                                            w.q,
                                            __len(w.q) - 1
                                        )
                                    else
                                        ____t_result_768 = w.dir
                                    end
                                    local last = ____t_result_768
                                    local ____t_772 = __t
                                    local ____t_result_771
                                    local ____t_770 = __t
                                    local ____temp_769 = __get(v, 0) == __TS__Number(-last.x) and __get(v, 1) == __TS__Number(-last.y)
                                    __O[1130] = ____temp_769
                                    if ____t_770(____temp_769) then
                                        ____t_result_771 = __O[1130]
                                    else
                                        ____t_result_771 = __get(v, 0) == last.x and __get(v, 1) == last.y
                                    end
                                    if ____t_772(____t_result_771) then
                                        continue
                                    end
                                    if __lt(
                                        __len(w.q),
                                        2
                                    ) then
                                        __call(
                                            w.q,
                                            "push",
                                            {
                                                x = __get(v, 0),
                                                y = __get(v, 1)
                                            }
                                        )
                                    end
                                end
                            end
                        end
                    )
                    st.goldT = st.goldT - dt
                    if __t(not __t(st.gold) and __le(st.goldT, 0)) then
                        do
                            local k = 0
                            while k < 100 do
                                local x = __L1:irnd(1, st.cols - 2)
                                local y = __L1:irnd(1, st.rows - 2)
                                if __t(self:free(st, x, y)) then
                                    st.gold = {x = x, y = y, life = 6}
                                    break
                                end
                                k = k + 1
                            end
                        end
                        st.goldT = 14
                    end
                    if __t(st.gold) then
                        local ____st_gold_773, ____life_774 = st.gold, "life"
                        ____st_gold_773[____life_774] = ____st_gold_773[____life_774] - dt
                        if __le(st.gold.life, 0) then
                            st.gold = nil
                        end
                    end
                    local len = math.max(__TS__Spread(__iter(__call(
                        st.worms,
                        "map",
                        function(____, w) return __len(w.body) end
                    ))))
                    local period = st.mode == "duo" and 0.1 or math.max(0.055, 0.12 - len * 0.0016)
                    st.step = __add(st.step, dt)
                    if __lt(st.step, period) then
                        return
                    end
                    st.step = 0
                    local heads = __call(
                        st.worms,
                        "map",
                        function(____, w)
                            if not __t(w.alive) then
                                return nil
                            end
                            if __t(__len(w.q)) then
                                w.dir = __call(w.q, "shift")
                            end
                            return {
                                x = __add(
                                    __get(w.body, 0).x,
                                    w.dir.x
                                ),
                                y = __add(
                                    __get(w.body, 0).y,
                                    w.dir.y
                                )
                            }
                        end
                    )
                    __call(
                        st.worms,
                        "forEach",
                        function(____, w, i)
                            local h = __get(heads, i)
                            if not __t(h) then
                                return
                            end
                            local ____t_result_779
                            local ____t_778 = __t
                            local ____t_result_777
                            local ____t_776 = __t
                            local ____temp_775 = __lt(h.x, 0) or __lt(h.y, 0)
                            __O[1131] = ____temp_775
                            if ____t_776(____temp_775) then
                                ____t_result_777 = __O[1131]
                            else
                                ____t_result_777 = __ge(h.x, st.cols)
                            end
                            __O[1132] = ____t_result_777
                            if ____t_778(____t_result_777) then
                                ____t_result_779 = __O[1132]
                            else
                                ____t_result_779 = __ge(h.y, st.rows)
                            end
                            local dead = ____t_result_779
                            for ____, o in __iterar((st.worms)) do
                                do
                                    local j = 0
                                    while j < __len(o.body) - (__t(o == w and not __t(w.eat)) and 1 or 0) do
                                        if __t(__get(o.body, j).x == h.x and __get(o.body, j).y == h.y) then
                                            dead = true
                                        end
                                        j = j + 1
                                    end
                                end
                            end
                            __call(
                                heads,
                                "forEach",
                                function(____, h2, k)
                                    local ____t_787 = __t
                                    local ____t_result_786
                                    local ____t_785 = __t
                                    local ____t_result_784
                                    local ____t_783 = __t
                                    local ____t_result_782
                                    local ____t_781 = __t
                                    local ____temp_780 = k ~= i
                                    __O[1133] = ____temp_780
                                    if ____t_781(____temp_780) then
                                        ____t_result_782 = h2
                                    else
                                        ____t_result_782 = __O[1133]
                                    end
                                    __O[1134] = ____t_result_782
                                    if ____t_783(____t_result_782) then
                                        ____t_result_784 = h2.x == h.x
                                    else
                                        ____t_result_784 = __O[1134]
                                    end
                                    __O[1135] = ____t_result_784
                                    if ____t_785(____t_result_784) then
                                        ____t_result_786 = h2.y == h.y
                                    else
                                        ____t_result_786 = __O[1135]
                                    end
                                    if ____t_787(____t_result_786) then
                                        dead = true
                                    end
                                end
                            )
                            if __t(dead) then
                                w.alive = false
                                w.deadAt = st.t
                            end
                        end
                    )
                    __call(
                        st.worms,
                        "forEach",
                        function(____, w, i)
                            local h = __get(heads, i)
                            if __t(not __t(h) or not __t(w.alive)) then
                                return
                            end
                            __call(w.body, "unshift", h)
                            if __gt(w.eat, 0) then
                                w.eat = w.eat - 1
                            else
                                __call(w.body, "pop")
                            end
                            local fi = __call(
                                st.food,
                                "findIndex",
                                function(____, f) return f.x == h.x and f.y == h.y end
                            )
                            if __ge(fi, 0) then
                                __call(st.food, "splice", fi, 1)
                                self:spawn(st)
                                w.eat = w.eat + 2
                                __set(
                                    st.score,
                                    i,
                                    __get(st.score, i) + 10
                                )
                                __L1:sfx("pick")
                                __call(st.pop, "push", {x = st.ox + h.x * 8 + 4, y = st.oy + h.y * 8, s = "+10", t = 0})
                            end
                            local ____t_791 = __t
                            local ____t_result_790
                            local ____t_789 = __t
                            local ____t_result_788
                            if __t(st.gold) then
                                ____t_result_788 = st.gold.x == h.x
                            else
                                ____t_result_788 = st.gold
                            end
                            __O[1136] = ____t_result_788
                            if ____t_789(____t_result_788) then
                                ____t_result_790 = st.gold.y == h.y
                            else
                                ____t_result_790 = __O[1136]
                            end
                            if ____t_791(____t_result_790) then
                                st.gold = nil
                                w.eat = w.eat + 4
                                __set(
                                    st.score,
                                    i,
                                    __get(st.score, i) + 50
                                )
                                __L1:sfx("power")
                                __call(st.pop, "push", {x = st.ox + h.x * 8 + 4, y = st.oy + h.y * 8, s = "+50", t = 0})
                            end
                        end
                    )
                    local dead = __len(__call(
                        st.worms,
                        "filter",
                        function(____, w) return not __t(w.alive) end
                    ))
                    if __t(dead) then
                        __L1:sfx("lose")
                        if st.mode == "solo" then
                            st["end"](
                                st,
                                {
                                    score = __get(st.score, 0),
                                    text = "A minhoca se enrolou!"
                                }
                            )
                        else
                            local alive = __call(
                                __call(
                                    st.worms,
                                    "map",
                                    function(____, w, k)
                                        local ____t_result_792
                                        if __t(w.alive) then
                                            ____t_result_792 = k
                                        else
                                            ____t_result_792 = -1
                                        end
                                        return ____t_result_792
                                    end
                                ),
                                "filter",
                                function(____, k) return __ge(k, 0) end
                            )
                            if __len(alive) == 0 then
                                st["end"](st, {winner = nil, text = "Bateram juntos: empate!"})
                            elseif __len(alive) == 1 then
                                st["end"](
                                    st,
                                    {
                                        winner = __get(alive, 0),
                                        text = __add(
                                            __get(
                                                __L1.PLAYER_NAME,
                                                __get(alive, 0)
                                            ),
                                            " venceu a corrida da minhoca!"
                                        )
                                    }
                                )
                            end
                        end
                    end
                end,
                drawLow = function(self, g, st)
                    __L1:R(
                        g,
                        0,
                        0,
                        __L1.LW,
                        __L1.LH,
                        "#5a3a22"
                    )
                    do
                        local y = 0
                        while __lt(y, st.rows) do
                            do
                                local x = 0
                                while __lt(x, st.cols) do
                                    local v = __L1:hash(x * 31 + y * 7)
                                    __L1:R(
                                        g,
                                        st.ox + x * 8,
                                        st.oy + y * 8,
                                        8,
                                        8,
                                        __t(__mod(x + y, 2)) and "#6e4a2c" or "#684528"
                                    )
                                    if v > 0.93 then
                                        __L1:R(
                                            g,
                                            st.ox + x * 8 + 3,
                                            st.oy + y * 8 + 3,
                                            2,
                                            1,
                                            "#8a6040"
                                        )
                                    end
                                    x = x + 1
                                end
                            end
                            y = y + 1
                        end
                    end
                    do
                        local x = 0
                        while __lt(x, st.cols) do
                            __L1:R(
                                g,
                                st.ox + x * 8 + 2,
                                st.oy - 6,
                                4,
                                5,
                                "#2f6b3c"
                            )
                            __L1:R(
                                g,
                                st.ox + x * 8,
                                st.oy - 4,
                                8,
                                2,
                                "#3f8a4a"
                            )
                            x = x + 6
                        end
                    end
                    __L1:R(
                        g,
                        st.ox - 4,
                        st.oy - 2,
                        st.cols * 8 + 8,
                        2,
                        "#a07848"
                    )
                    __L1:R(
                        g,
                        st.ox - 4,
                        st.oy + st.rows * 8,
                        st.cols * 8 + 8,
                        2,
                        "#a07848"
                    )
                    __L1:R(
                        g,
                        st.ox - 4,
                        st.oy,
                        2,
                        st.rows * 8,
                        "#a07848"
                    )
                    __L1:R(
                        g,
                        st.ox + st.cols * 8 + 2,
                        st.oy,
                        2,
                        st.rows * 8,
                        "#a07848"
                    )
                    for ____, f in __iterar((st.food)) do
                        local x = st.ox + f.x * 8
                        local y = st.oy + f.y * 8
                        __L1:R(
                            g,
                            x + 2,
                            y + 2,
                            4,
                            5,
                            "#b8242c"
                        )
                        __L1:R(
                            g,
                            x + 3,
                            y + 2,
                            2,
                            1,
                            "#ff7a6a"
                        )
                        __L1:R(
                            g,
                            x + 4,
                            y + 1,
                            1,
                            2,
                            "#3f8a4a"
                        )
                    end
                    if __t(st.gold) then
                        local x = st.ox + st.gold.x * 8
                        local y = st.oy + st.gold.y * 8
                        local ____t_result_795
                        local ____t_794 = __t
                        local ____lt_result_793 = __lt(st.gold.life, 2)
                        __O[1137] = ____lt_result_793
                        if ____t_794(____lt_result_793) then
                            ____t_result_795 = __mod(
                                math.floor(st.t * 8),
                                2
                            )
                        else
                            ____t_result_795 = __O[1137]
                        end
                        local bl = ____t_result_795
                        if not __t(bl) then
                            __L1:R(
                                g,
                                x + 2,
                                y + 1,
                                4,
                                7,
                                "#f6c445"
                            )
                            __L1:R(
                                g,
                                x + 3,
                                y + 2,
                                1,
                                1,
                                "#fff2a0"
                            )
                            __L1:R(
                                g,
                                x + 5,
                                y + 4,
                                1,
                                1,
                                "#fff2a0"
                            )
                            __L1:R(
                                g,
                                x + 1,
                                y + 5,
                                2,
                                3,
                                "#7ab84a"
                            )
                        end
                    end
                    __call(
                        st.worms,
                        "forEach",
                        function(____, w)
                            __call(
                                w.body,
                                "forEach",
                                function(____, b, j)
                                    local x = st.ox + b.x * 8
                                    local y = st.oy + b.y * 8
                                    local ____t_result_801
                                    local ____t_799 = __t
                                    local ____t_result_798
                                    local ____t_797 = __t
                                    local ____temp_796 = not __t(w.alive)
                                    __O[1138] = ____temp_796
                                    if ____t_797(____temp_796) then
                                        ____t_result_798 = __mod(
                                            math.floor(st.t * 10),
                                            2
                                        )
                                    else
                                        ____t_result_798 = __O[1138]
                                    end
                                    if ____t_799(____t_result_798) then
                                        ____t_result_801 = "#fff"
                                    else
                                        local ____temp_800
                                        if j == 0 then
                                            ____temp_800 = w.head
                                        else
                                            ____temp_800 = w.col
                                        end
                                        ____t_result_801 = ____temp_800
                                    end
                                    local col = ____t_result_801
                                    __L1:R(
                                        g,
                                        x + 1,
                                        y + 1,
                                        6,
                                        6,
                                        col
                                    )
                                    if __mod(j, 3) == 1 then
                                        __L1:R(
                                            g,
                                            x + 1,
                                            y + 3,
                                            6,
                                            1,
                                            w.head
                                        )
                                    end
                                end
                            )
                            local h = __get(w.body, 0)
                            local x = st.ox + h.x * 8
                            local y = st.oy + h.y * 8
                            __L1:R(
                                g,
                                x + 2 + math.max(0, w.dir.x) * 2,
                                y + 2 + math.max(0, w.dir.y) * 2,
                                2,
                                2,
                                "#fff"
                            )
                            __L1:R(
                                g,
                                x + 3 + math.max(0, w.dir.x) * 2,
                                y + 3 + math.max(0, w.dir.y) * 2,
                                1,
                                1,
                                "#000"
                            )
                        end
                    )
                end,
                drawMain = function(self, c, st)
                    if st.mode == "solo" then
                        __L1:txt(
                            c,
                            __add(
                                __add(
                                    __add(
                                        "PONTOS ",
                                        __get(st.score, 0)
                                    ),
                                    "   TAMANHO "
                                ),
                                __len(__get(st.worms, 0).body)
                            ),
                            __L1.W / 2,
                            16,
                            14
                        )
                    else
                        __L1:scoreBar(
                            c,
                            __call(
                                st.worms,
                                "map",
                                function(____, w, i)
                                    local ____t_result_802
                                    if __t(w.alive) then
                                        ____t_result_802 = __get(st.score, i)
                                    else
                                        ____t_result_802 = "✕"
                                    end
                                    return ____t_result_802
                                end
                            )
                        )
                    end
                end
            },
            "id,name,sub,color,duo,max,medals,rules,rulesDuo,controls,init,free,spawn,update,drawLow,drawMain"
        )
    )
    __call(
        __L1.GAMES,
        "push",
        __ord(
            {
                id = "pong",
                name = "PINGUE-PONGUE DO PÁTIO",
                sub = "Chinelo na mão, bolinha de papel no ar.",
                color = "#6ac8a0",
                duo = "versus",
                medals = __arrL({400, 800, 1200}, 3),
                rules = __arrL({"Rebata a bolinha com o chinelo. Quem fizer 7 pontos ganha.", "Bater com o chinelo em movimento dá efeito na bola.", "A cada rebatida a bola fica mais rápida."}, 3),
                rulesDuo = __arrL({"Um de cada lado da mesa.", "Quem fizer 7 pontos primeiro vence.", "Chinelo em movimento dá efeito na bola."}, 3),
                controls = __arrL({"Cima e baixo: mover o chinelo"}, 1),
                init = function(self, st)
                    st.pads = __arrL({{y = 135, vy = 0}, {y = 135, vy = 0}}, 2)
                    st.pts = __arrL({0, 0}, 2)
                    st.hits = 0
                    st:serve(
                        st,
                        math.random() < 0.5 and -1 or 1
                    )
                    st.trail = __arrL({}, 0)
                end,
                update = function(self, st, dt)
                    local b = st.ball
                    local ph = 34
                    __call(
                        st.pads,
                        "forEach",
                        function(____, p, i)
                            local want
                            if __t(i == 1 and st.mode == "solo") then
                                local ____st_805 = st
                                local ____add_804 = __add
                                local ____t_result_803
                                if __t(st.cpuLag) then
                                    ____t_result_803 = st.cpuLag
                                else
                                    ____t_result_803 = 0
                                end
                                local ____add_804_result_806 = ____add_804(____t_result_803, dt)
                                ____st_805.cpuLag = ____add_804_result_806
                                local lag = ____add_804_result_806
                                local ____gt_result_807
                                if __gt(b.vx, 0) then
                                    ____gt_result_807 = b.y + math.sin(st.t * 1.3) * 10
                                else
                                    ____gt_result_807 = 135
                                end
                                local target = ____gt_result_807
                                want = __L1:clamp((target - p.y) / 18, -1, 1)
                                local max = 0.62 + math.min(
                                    0.35,
                                    __get(st.pts, 0) * 0.05
                                )
                                want = __L1:clamp(want, -max, max)
                            else
                                want = __get(__L1.P, i).y
                            end
                            local nv = want * 210
                            p.vy = nv
                            p.y = __L1:clamp(p.y + nv * dt, 22 + ph / 2, __L1.LH - 6 - ph / 2)
                        end
                    )
                    if __gt(b.wait, 0) then
                        b.wait = b.wait - dt
                        return
                    end
                    b.x = b.x + b.vx * dt
                    b.y = b.y + b.vy * dt
                    b.vy = b.vy + b.spin * dt
                    b.spin = b.spin * 0.985
                    __call(st.trail, "push", {x = b.x, y = b.y})
                    if __gt(
                        __len(st.trail),
                        6
                    ) then
                        __call(st.trail, "shift")
                    end
                    if __t(__lt(b.y, 24) or __gt(b.y, __L1.LH - 8)) then
                        b.vy = __TS__Number(-b.vy)
                        b.y = __L1:clamp(b.y, 24, __L1.LH - 8)
                        __L1:sfx("bounce")
                    end
                    for ____, ____value in __iterar((__arrL(
                        {
                            __arrL({0, 22}, 2),
                            __arrL({1, __L1.LW - 22}, 2)
                        },
                        2
                    ))) do
                        local i = ____value[1]
                        local px = ____value[2]
                        local p = __get(st.pads, i)
                        local ____t_812 = __t
                        local ____t_result_811
                        local ____t_809 = __t
                        local ____temp_808 = math.abs(b.x - px) < 5 and math.abs(b.y - p.y) < ph / 2 + 3
                        __O[1139] = ____temp_808
                        if ____t_809(____temp_808) then
                            local ____temp_810
                            if i == 0 then
                                ____temp_810 = __lt(b.vx, 0)
                            else
                                ____temp_810 = __gt(b.vx, 0)
                            end
                            ____t_result_811 = ____temp_810
                        else
                            ____t_result_811 = __O[1139]
                        end
                        if ____t_812(____t_result_811) then
                            local off = (b.y - p.y) / (ph / 2)
                            local sp = math.min(
                                430,
                                __hypot(b.vx, b.vy) + 14
                            )
                            b.vx = (i == 0 and 1 or -1) * sp * math.cos(off * 0.8)
                            b.vy = sp * math.sin(off * 0.8)
                            b.spin = p.vy * 0.9
                            b.x = px + (i == 0 and 5 or -5)
                            st.hits = st.hits + 1
                            __L1:sfx("hit")
                            st.shake = 0.12
                        end
                    end
                    if __t(__lt(b.x, -10) or __gt(b.x, __L1.LW + 10)) then
                        local who = __lt(b.x, 0) and 1 or 0
                        __inc(st.pts, who, 1, true)
                        __L1:sfx(__t(who == 0 or st.mode == "duo") and "pick" or "lose")
                        if __ge(
                            __get(st.pts, who),
                            7
                        ) then
                            if st.mode == "solo" then
                                local sc = math.max(
                                    0,
                                    __get(st.pts, 0) * 100 - __get(st.pts, 1) * 30 + (who == 0 and 500 or 0) + st.hits * 5
                                )
                                st["end"](st, {score = sc, win = who == 0, text = who == 0 and "Você venceu o Nikolas!" or "Nikolas venceu desta vez."})
                            else
                                st["end"](
                                    st,
                                    {
                                        winner = who,
                                        text = __add(
                                            __add(
                                                __add(
                                                    __add(
                                                        __add(
                                                            __get(__L1.PLAYER_NAME, who),
                                                            " venceu por "
                                                        ),
                                                        __get(st.pts, who)
                                                    ),
                                                    " a "
                                                ),
                                                __get(st.pts, 1 - who)
                                            ),
                                            "!"
                                        )
                                    }
                                )
                            end
                        else
                            st:serve(st, who == 0 and 1 or -1)
                        end
                    end
                end,
                drawLow = function(self, g, st)
                    __L1:R(
                        g,
                        0,
                        0,
                        __L1.LW,
                        __L1.LH,
                        "#2c5a44"
                    )
                    do
                        local y = 20
                        while y < __L1.LH do
                            __L1:R(
                                g,
                                0,
                                y,
                                __L1.LW,
                                2,
                                "#2f6048"
                            )
                            y = y + 4
                        end
                    end
                    __L1:R(
                        g,
                        6,
                        20,
                        __L1.LW - 12,
                        2,
                        "#e8f0d8"
                    )
                    __L1:R(
                        g,
                        6,
                        __L1.LH - 4,
                        __L1.LW - 12,
                        2,
                        "#e8f0d8"
                    )
                    do
                        local y = 24
                        while y < __L1.LH - 4 do
                            __L1:R(
                                g,
                                __L1.LW / 2 - 1,
                                y,
                                2,
                                6,
                                "#c8d8b8"
                            )
                            y = y + 10
                        end
                    end
                    for ____, t in __iterar((st.trail)) do
                        __L1:R(
                            g,
                            t.x - 1,
                            t.y - 1,
                            2,
                            2,
                            "rgba(255,255,240,.35)"
                        )
                    end
                    local b = st.ball
                    local ____t_816 = __t
                    local ____t_result_815
                    local ____t_814 = __t
                    local ____gt_result_813 = __gt(b.wait, 0)
                    __O[1140] = ____gt_result_813
                    if ____t_814(____gt_result_813) then
                        ____t_result_815 = __mod(
                            math.floor(st.t * 8),
                            2
                        )
                    else
                        ____t_result_815 = __O[1140]
                    end
                    if not ____t_816(____t_result_815) then
                        __L1:R(
                            g,
                            b.x - 2,
                            b.y - 3,
                            5,
                            6,
                            "#f4f0e0"
                        )
                        __L1:R(
                            g,
                            b.x - 3,
                            b.y - 2,
                            7,
                            4,
                            "#f4f0e0"
                        )
                        __L1:R(
                            g,
                            b.x - 1,
                            b.y - 1,
                            2,
                            1,
                            "#b8b4a0"
                        )
                        __L1:R(
                            g,
                            b.x + 1,
                            b.y + 1,
                            1,
                            1,
                            "#b8b4a0"
                        )
                    end
                    __call(
                        __arrL(
                            {
                                __arrL({22, 0}, 2),
                                __arrL({__L1.LW - 22, 1}, 2)
                            },
                            2
                        ),
                        "forEach",
                        function(____, ____bindingPattern0)
                            local i
                            local x
                            x = ____bindingPattern0[1]
                            i = ____bindingPattern0[2]
                            local y = __get(st.pads, i).y
                            local col = __t(i) and "#3a9ad0" or "#e8823a"
                            __L1:R(
                                g,
                                x - 3,
                                y - 17,
                                6,
                                34,
                                col
                            )
                            __L1:R(
                                g,
                                x - 2,
                                y - 16,
                                4,
                                32,
                                __t(i) and "#7ad1ff" or "#ffb347"
                            )
                            __L1:R(
                                g,
                                x - 1,
                                y - 12,
                                2,
                                6,
                                "#fff3d0"
                            )
                            __L1:R(
                                g,
                                x - 3,
                                y + 6,
                                6,
                                2,
                                "#5a3a22"
                            )
                        end
                    )
                end,
                drawMain = function(self, c, st)
                    __L1:txt(
                        c,
                        tostring(__get(st.pts, 0)),
                        __L1.W / 2 - 60,
                        22,
                        28,
                        __get(__L1.PLAYER_COL, 0)
                    )
                    __L1:txt(
                        c,
                        tostring(__get(st.pts, 1)),
                        __L1.W / 2 + 60,
                        22,
                        28,
                        st.mode == "solo" and "#c9a8ff" or __get(__L1.PLAYER_COL, 1)
                    )
                    __L1:txt(
                        c,
                        __get(__L1.PLAYER_NAME, 0),
                        120,
                        22,
                        12,
                        __get(__L1.PLAYER_COL, 0)
                    )
                    local ____L1_txt_819 = __L1.txt
                    local ____c_818 = c
                    local ____temp_817
                    if st.mode == "solo" then
                        ____temp_817 = __L1:cpuName()
                    else
                        ____temp_817 = __get(__L1.PLAYER_NAME, 1)
                    end
                    ____L1_txt_819(
                        __L1,
                        ____c_818,
                        ____temp_817,
                        __L1.W - 120,
                        22,
                        12,
                        st.mode == "solo" and "#c9a8ff" or __get(__L1.PLAYER_COL, 1)
                    )
                end,
                extra = {serve = function(self, st, dir)
                    st.ball = {
                        x = __L1.LW / 2,
                        y = 135,
                        vx = 175 * dir,
                        vy = __L1:rnd(-60, 60),
                        spin = 0,
                        wait = 0.9
                    }
                end}
            },
            "id,name,sub,color,duo,medals,rules,rulesDuo,controls,init,update,drawLow,drawMain,extra"
        )
    )
    __call(
        __L1.GAMES,
        "push",
        __ord(
            {
                id = "quebra",
                name = "QUEBRA-CADERNO",
                sub = "Régua, bolinha de papel e um caderno inteiro.",
                color = "#f0c050",
                duo = "coop",
                medals = __arrL({800, 2000, 4000}, 3),
                rules = __arrL({"Rebata a bolinha com a régua e rasgue todas as páginas.", "Páginas manchadas de tinta precisam de 2 batidas.", "Itens: lápis (régua grande), borracha (3 bolas), cola (gruda), coração."}, 3),
                rulesDuo = __arrL({"Duas réguas, uma vida em conjunto.", "P1 na régua de baixo, P2 na de cima.", "Itens servem para os dois."}, 3),
                controls = __arrL({"Esquerda e direita: mover", "A: soltar a bolinha"}, 2),
                init = function(self, st)
                    st.lives = 3
                    st.level = 0
                    local ____st_823 = st
                    local ____call_822 = __call
                    local ____arrL_result_821 = __arrL({{x = 240, w = 52, y = 252}}, 1)
                    local ____temp_820
                    if st.mode == "duo" then
                        ____temp_820 = __arrL({{x = 240, w = 40, y = 232}}, 1)
                    else
                        ____temp_820 = __arrL({}, 0)
                    end
                    ____st_823.pads = ____call_822(____arrL_result_821, "concat", ____temp_820)
                    st.drops = __arrL({}, 0)
                    st.fx = __arrL({}, 0)
                    st.wide = 0
                    st.glue = 0
                    self:level(st)
                end,
                level = function(self, st)
                    local L = __mod(st.level, 4)
                    st.bricks = __arrL({}, 0)
                    do
                        local r = 0
                        while r < 6 do
                            do
                                local c = 0
                                while c < 12 do
                                    do
                                        local ____t_result_833
                                        local ____t_829 = __t
                                        local ____t_result_828
                                        local ____t_827 = __t
                                        local ____t_result_826
                                        local ____t_825 = __t
                                        local ____temp_824 = L == 0
                                        __O[1141] = ____temp_824
                                        if ____t_825(____temp_824) then
                                            ____t_result_826 = __O[1141]
                                        else
                                            ____t_result_826 = L == 1 and __mod(r + c, 2) == 0
                                        end
                                        __O[1142] = ____t_result_826
                                        if ____t_827(____t_result_826) then
                                            ____t_result_828 = __O[1142]
                                        else
                                            ____t_result_828 = L == 2 and math.abs(c - 5.5) < 6 - r
                                        end
                                        __O[1144] = ____t_result_828
                                        if ____t_829(____t_result_828) then
                                            ____t_result_833 = __O[1144]
                                        else
                                            local ____t_result_832
                                            local ____t_831 = __t
                                            local ____temp_830 = L == 3
                                            __O[1143] = ____temp_830
                                            if ____t_831(____temp_830) then
                                                ____t_result_832 = __mod(c, 3) ~= 1 or __mod(r, 2) == 0
                                            else
                                                ____t_result_832 = __O[1143]
                                            end
                                            ____t_result_833 = ____t_result_832
                                        end
                                        local on = ____t_result_833
                                        if not __t(on) then
                                            do c = c + 1 continue end
                                        end
                                        local ____t_837 = __t
                                        local ____t_result_836
                                        local ____t_835 = __t
                                        local ____temp_834 = r == 0
                                        __O[1145] = ____temp_834
                                        if ____t_835(____temp_834) then
                                            ____t_result_836 = __O[1145]
                                        else
                                            ____t_result_836 = L == 3 and r == 2
                                        end
                                        local hp = ____t_837(____t_result_836) and 2 or 1
                                        __call(st.bricks, "push", {
                                            x = 24 + c * 36,
                                            y = 34 + r * 13,
                                            w = 34,
                                            h = 11,
                                            hp = hp,
                                            row = r
                                        })
                                    end
                                    c = c + 1
                                end
                            end
                            r = r + 1
                        end
                    end
                    st.balls = __arrL({{
                        x = 240,
                        y = 240,
                        vx = 0,
                        vy = 0,
                        stuck = 0,
                        sp = 190 + st.level * 18
                    }}, 1)
                    st.wide = 0
                    st.glue = 0
                end,
                update = function(self, st, dt)
                    __call(
                        st.pads,
                        "forEach",
                        function(____, p, i)
                            p.w = (__t(i) and 40 or 52) + (__gt(st.wide, 0) and 26 or 0)
                            p.x = __L1:clamp(
                                p.x + __get(__L1.P, i).x * 250 * dt,
                                p.w / 2 + 6,
                                __L1.LW - 6 - p.w / 2
                            )
                        end
                    )
                    st.wide = math.max(0, st.wide - dt)
                    st.glue = math.max(0, st.glue - dt)
                    for ____, b in __iterar((st.balls)) do
                        do
                            local ____t_841 = __t
                            local ____t_result_840
                            local ____t_839 = __t
                            local ____temp_838 = b.stuck ~= false and b.stuck ~= nil
                            __O[1146] = ____temp_838
                            if ____t_839(____temp_838) then
                                ____t_result_840 = b.stuck ~= nil
                            else
                                ____t_result_840 = __O[1146]
                            end
                            if ____t_841(____t_result_840) then
                                local p = __get(st.pads, b.stuck)
                                local ____add_844 = __add
                                local ____p_x_843 = p.x
                                local ____t_result_842
                                if __t(b.off) then
                                    ____t_result_842 = b.off
                                else
                                    ____t_result_842 = 0
                                end
                                b.x = ____add_844(____p_x_843, ____t_result_842)
                                b.y = p.y - 5
                                local ____t_851 = __t
                                local ____t_result_850
                                local ____t_846 = __t
                                local ____get_result_ap_845 = __get(__L1.P, b.stuck).ap
                                __O[1148] = ____get_result_ap_845
                                if ____t_846(____get_result_ap_845) then
                                    ____t_result_850 = __O[1148]
                                else
                                    local ____t_result_849
                                    local ____t_848 = __t
                                    local ____temp_847 = st.mode == "solo"
                                    __O[1147] = ____temp_847
                                    if ____t_848(____temp_847) then
                                        ____t_result_849 = __get(__L1.P, 0).ap
                                    else
                                        ____t_result_849 = __O[1147]
                                    end
                                    ____t_result_850 = ____t_result_849
                                end
                                if ____t_851(____t_result_850) then
                                    local a = __L1:rnd(-0.5, 0.5)
                                    b.vx = math.sin(a) * b.sp
                                    b.vy = -math.cos(a) * b.sp
                                    b.stuck = nil
                                    __L1:sfx("bounce")
                                end
                                continue
                            end
                            b.x = b.x + b.vx * dt
                            b.y = b.y + b.vy * dt
                            if __lt(b.x, 6) then
                                b.x = 6
                                b.vx = math.abs(b.vx)
                                __L1:sfx("bounce")
                            end
                            if __gt(b.x, __L1.LW - 6) then
                                b.x = __L1.LW - 6
                                b.vx = -math.abs(b.vx)
                                __L1:sfx("bounce")
                            end
                            if __lt(b.y, 22) then
                                b.y = 22
                                b.vy = math.abs(b.vy)
                                __L1:sfx("bounce")
                            end
                            __call(
                                st.pads,
                                "forEach",
                                function(____, p, i)
                                    local ____t_857 = __t
                                    local ____t_result_856
                                    local ____t_855 = __t
                                    local ____t_result_854
                                    local ____t_853 = __t
                                    local ____temp_852 = __gt(b.vy, 0) and __gt(b.y, p.y - 5)
                                    __O[1149] = ____temp_852
                                    if ____t_853(____temp_852) then
                                        ____t_result_854 = __lt(b.y, p.y + 2)
                                    else
                                        ____t_result_854 = __O[1149]
                                    end
                                    __O[1150] = ____t_result_854
                                    if ____t_855(____t_result_854) then
                                        ____t_result_856 = math.abs(b.x - p.x) < p.w / 2 + 3
                                    else
                                        ____t_result_856 = __O[1150]
                                    end
                                    if ____t_857(____t_result_856) then
                                        local off = (b.x - p.x) / (p.w / 2)
                                        local sp = __hypot(b.vx, b.vy) * 1.01
                                        b.vx = math.sin(off * 1.05) * sp
                                        b.vy = -math.abs(math.cos(off * 1.05) * sp)
                                        b.y = p.y - 5
                                        if __gt(st.glue, 0) then
                                            b.stuck = i
                                            b.off = b.x - p.x
                                        end
                                        __L1:sfx("hit")
                                    end
                                end
                            )
                            for ____, k in __iterar((st.bricks)) do
                                do
                                    if __le(k.hp, 0) then
                                        continue
                                    end
                                    local ____t_863 = __t
                                    local ____t_result_862
                                    local ____t_861 = __t
                                    local ____t_result_860
                                    local ____t_859 = __t
                                    local ____temp_858 = __gt(b.x, k.x - 2) and __lt(
                                        b.x,
                                        __add(k.x, k.w) + 2
                                    )
                                    __O[1151] = ____temp_858
                                    if ____t_859(____temp_858) then
                                        ____t_result_860 = __gt(b.y, k.y - 2)
                                    else
                                        ____t_result_860 = __O[1151]
                                    end
                                    __O[1152] = ____t_result_860
                                    if ____t_861(____t_result_860) then
                                        ____t_result_862 = __lt(
                                            b.y,
                                            __add(k.y, k.h) + 2
                                        )
                                    else
                                        ____t_result_862 = __O[1152]
                                    end
                                    if ____t_863(____t_result_862) then
                                        local ox = math.min(
                                            b.x - k.x + 2,
                                            __add(k.x, k.w) + 2 - b.x
                                        )
                                        local oy = math.min(
                                            b.y - k.y + 2,
                                            __add(k.y, k.h) + 2 - b.y
                                        )
                                        if ox < oy then
                                            b.vx = __TS__Number(-b.vx)
                                        else
                                            b.vy = __TS__Number(-b.vy)
                                        end
                                        k.hp = k.hp - 1
                                        if __le(k.hp, 0) then
                                            __set(
                                                st.score,
                                                0,
                                                __get(st.score, 0) + (k.row == 0 and 25 or 10)
                                            )
                                            __L1:sfx("break")
                                            do
                                                local j = 0
                                                while j < 6 do
                                                    __call(
                                                        st.fx,
                                                        "push",
                                                        {
                                                            x = __add(
                                                                k.x,
                                                                __L1:rnd(0, k.w)
                                                            ),
                                                            y = __add(
                                                                k.y,
                                                                __L1:rnd(0, k.h)
                                                            ),
                                                            vx = __L1:rnd(-60, 60),
                                                            vy = __L1:rnd(-80, 10),
                                                            t = 0
                                                        }
                                                    )
                                                    j = j + 1
                                                end
                                            end
                                            if math.random() < 0.14 then
                                                __call(
                                                    st.drops,
                                                    "push",
                                                    {
                                                        x = k.x + k.w / 2,
                                                        y = k.y,
                                                        kind = __get(
                                                            __arrL({"lapis", "borracha", "cola", "coracao"}, 4),
                                                            math.random() < 0.1 and 3 or __L1:irnd(0, 2)
                                                        )
                                                    }
                                                )
                                            end
                                        else
                                            __L1:sfx("hit")
                                        end
                                        break
                                    end
                                end
                            end
                        end
                    end
                    st.balls = __call(
                        st.balls,
                        "filter",
                        function(____, b) return __lt(b.y, __L1.LH + 6) end
                    )
                    if not __t(__len(st.balls)) then
                        st.lives = st.lives - 1
                        __L1:sfx("lose")
                        st.shake = 0.3
                        if __le(st.lives, 0) then
                            st["end"](
                                st,
                                {
                                    score = __get(st.score, 0),
                                    text = "O caderno venceu desta vez."
                                }
                            )
                            return
                        end
                        st.balls = __arrL({{x = 240, y = 240, stuck = 0, sp = 190 + st.level * 18}}, 1)
                    end
                    for ____, d in __iterar((st.drops)) do
                        d.y = d.y + 70 * dt
                        __call(
                            st.pads,
                            "forEach",
                            function(____, p)
                                local ____t_867 = __t
                                local ____t_result_866
                                local ____t_865 = __t
                                local ____temp_864 = not __t(d.got) and math.abs(d.y - p.y) < 6
                                __O[1153] = ____temp_864
                                if ____t_865(____temp_864) then
                                    ____t_result_866 = math.abs(d.x - p.x) < p.w / 2 + 5
                                else
                                    ____t_result_866 = __O[1153]
                                end
                                if ____t_867(____t_result_866) then
                                    d.got = true
                                    __L1:sfx("power")
                                    if d.kind == "lapis" then
                                        st.wide = 12
                                    elseif d.kind == "cola" then
                                        st.glue = 10
                                    elseif d.kind == "coracao" then
                                        st.lives = math.min(5, st.lives + 1)
                                    else
                                        local ____t_result_870
                                        local ____t_869 = __t
                                        local ____call_result_868 = __call(
                                            st.balls,
                                            "find",
                                            function(____, b) return b.stuck == nil or b.stuck == nil end
                                        )
                                        __O[1154] = ____call_result_868
                                        if ____t_869(____call_result_868) then
                                            ____t_result_870 = __O[1154]
                                        else
                                            ____t_result_870 = __get(st.balls, 0)
                                        end
                                        local src = ____t_result_870
                                        if __t(src) then
                                            for ____, a in __iterar((__arrL({-0.5, 0.5}, 2))) do
                                                __call(
                                                    st.balls,
                                                    "push",
                                                    {
                                                        x = src.x,
                                                        y = src.y,
                                                        vx = math.sin(a) * src.sp,
                                                        vy = -math.cos(a) * src.sp,
                                                        sp = src.sp,
                                                        stuck = nil
                                                    }
                                                )
                                            end
                                        end
                                    end
                                end
                            end
                        )
                    end
                    st.drops = __call(
                        st.drops,
                        "filter",
                        function(____, d) return not __t(d.got) and __lt(d.y, __L1.LH) end
                    )
                    for ____, f in __iterar((st.fx)) do
                        f.t = __add(f.t, dt)
                        f.x = f.x + f.vx * dt
                        f.y = f.y + f.vy * dt
                        f.vy = f.vy + 200 * dt
                    end
                    st.fx = __call(
                        st.fx,
                        "filter",
                        function(____, f) return __lt(f.t, 0.7) end
                    )
                    if not __t(__call(
                        st.bricks,
                        "some",
                        function(____, k) return __gt(k.hp, 0) end
                    )) then
                        __set(
                            st.score,
                            0,
                            __get(st.score, 0) + 200
                        )
                        st.level = st.level + 1
                        __L1:sfx("win")
                        st.banner = {
                            s = __add("CADERNO ", st.level + 1),
                            t = 1.6
                        }
                        self:level(st)
                    end
                end,
                drawLow = function(self, g, st)
                    __L1:R(
                        g,
                        0,
                        0,
                        __L1.LW,
                        __L1.LH,
                        "#f2ead2"
                    )
                    do
                        local y = 26
                        while y < __L1.LH do
                            __L1:R(
                                g,
                                0,
                                y,
                                __L1.LW,
                                1,
                                "#bcd2e6"
                            )
                            y = y + 10
                        end
                    end
                    __L1:R(
                        g,
                        18,
                        18,
                        1,
                        __L1.LH,
                        "#e8a0a0"
                    )
                    local pal = __arrL({
                        "#d06a5a",
                        "#e8a04a",
                        "#e8d04a",
                        "#7ab86a",
                        "#5a9ad0",
                        "#9a7ad0"
                    }, 6)
                    for ____, k in __iterar((st.bricks)) do
                        do
                            if __le(k.hp, 0) then
                                continue
                            end
                            __L1:R(
                                g,
                                k.x,
                                k.y,
                                k.w,
                                k.h,
                                "#4a3a2a"
                            )
                            __L1:R(
                                g,
                                k.x + 1,
                                k.y + 1,
                                k.w - 2,
                                k.h - 2,
                                __gt(k.hp, 1) and "#3a3a6a" or __get(pal, k.row)
                            )
                            __L1:R(
                                g,
                                k.x + 2,
                                k.y + 2,
                                k.w - 4,
                                1,
                                "rgba(255,255,255,.5)"
                            )
                            if __gt(k.hp, 1) then
                                __L1:R(
                                    g,
                                    k.x + 6,
                                    k.y + 4,
                                    5,
                                    3,
                                    "#1a1a3a"
                                )
                                __L1:R(
                                    g,
                                    k.x + 20,
                                    k.y + 3,
                                    4,
                                    4,
                                    "#1a1a3a"
                                )
                            else
                                __L1:R(
                                    g,
                                    k.x + 4,
                                    k.y + 5,
                                    k.w - 8,
                                    1,
                                    "rgba(0,0,0,.18)"
                                )
                            end
                        end
                    end
                    for ____, d in __iterar((st.drops)) do
                        local col = __get({lapis = "#e8c23a", borracha = "#e88aa0", cola = "#f4f4f4", coracao = "#e84a5a"}, d.kind)
                        __L1:R(
                            g,
                            d.x - 5,
                            d.y - 4,
                            10,
                            8,
                            "#3a2a1a"
                        )
                        __L1:R(
                            g,
                            d.x - 4,
                            d.y - 3,
                            8,
                            6,
                            col
                        )
                    end
                    for ____, f in __iterar((st.fx)) do
                        __L1:R(
                            g,
                            f.x,
                            f.y,
                            2,
                            2,
                            "#c8b890"
                        )
                    end
                    __call(
                        st.pads,
                        "forEach",
                        function(____, p, i)
                            __L1:R(
                                g,
                                p.x - p.w / 2,
                                p.y,
                                p.w,
                                5,
                                "#6a4a2a"
                            )
                            __L1:R(
                                g,
                                p.x - p.w / 2 + 1,
                                p.y + 1,
                                p.w - 2,
                                3,
                                __t(i) and "#7ad1ff" or (__gt(st.glue, 0) and "#e0f0e0" or "#e8c070")
                            )
                            do
                                local x = 4
                                while x < p.w - 2 do
                                    __L1:R(
                                        g,
                                        p.x - p.w / 2 + x,
                                        p.y + 1,
                                        1,
                                        __t(__mod(x, 8)) and 1 or 2,
                                        "#6a4a2a"
                                    )
                                    x = x + 4
                                end
                            end
                        end
                    )
                    for ____, b in __iterar((st.balls)) do
                        __L1:R(
                            g,
                            b.x - 2,
                            b.y - 3,
                            5,
                            6,
                            "#fffaf0"
                        )
                        __L1:R(
                            g,
                            b.x - 3,
                            b.y - 2,
                            7,
                            4,
                            "#fffaf0"
                        )
                        __L1:R(
                            g,
                            b.x - 1,
                            b.y - 1,
                            2,
                            1,
                            "#a8a490"
                        )
                    end
                end,
                drawMain = function(self, c, st)
                    __L1:txt(
                        c,
                        __add(
                            "PONTOS ",
                            __get(st.score, 0)
                        ),
                        20,
                        16,
                        14,
                        "#fff1ca",
                        "left"
                    )
                    __L1:txt(
                        c,
                        __add("CADERNO ", st.level + 1),
                        __L1.W / 2,
                        16,
                        14
                    )
                    __L1:txt(
                        c,
                        __call(
                            "♥",
                            "repeat",
                            math.max(0, st.lives)
                        ),
                        __L1.W - 70,
                        16,
                        16,
                        "#ff6a7a",
                        "right"
                    )
                    if __t(__call(
                        st.balls,
                        "some",
                        function(____, b) return b.stuck ~= nil and b.stuck ~= nil end
                    )) then
                        __L1:txt(
                            c,
                            "APERTE A PARA SOLTAR",
                            __L1.W / 2,
                            420,
                            14,
                            "#3a2a1a",
                            "center",
                            nil
                        )
                    end
                end
            },
            "id,name,sub,color,duo,medals,rules,rulesDuo,controls,init,level,update,drawLow,drawMain"
        )
    )
    __call(
        __L1.GAMES,
        "push",
        __ord(
            {
                id = "cabo",
                name = "CABO DE GUERRA",
                sub = "Puxa que é de puxar!",
                color = "#e8823a",
                duo = "versus",
                medals = __arrL({500, 900, 1200}, 3),
                rules = __arrL({"Aperte A e B alternando, bem rápido, para puxar a corda.", "Apertar quando o círculo fica verde dá puxão dobrado.", "Leve a fita até o seu lado. Melhor de 3 contra o Nikolas."}, 3),
                rulesDuo = __arrL({"Cada um puxa para o seu lado alternando A e B.", "Círculo verde: puxão dobrado.", "Melhor de 3 rodadas."}, 3),
                controls = __arrL({"A e B alternados: puxar"}, 1),
                init = function(self, st)
                    st.rope = 0
                    st.v = 0
                    st.round = 1
                    st.wins = __arrL({0, 0}, 2)
                    st.last = __arr(nil, nil)
                    st.taps = __arrL({0, 0}, 2)
                    st.pulse = __arrL({0, 0.5}, 2)
                    st.cpuT = 0
                    st.pause = 1.2
                    st.mud = __arrL({}, 0)
                end,
                update = function(self, st, dt)
                    st.pulse = __call(
                        st.pulse,
                        "map",
                        function(____, p, i) return __mod(p + dt * (1.1 + i * 0.13), 1) end
                    )
                    if __gt(st.pause, 0) then
                        st.pause = st.pause - dt
                        return
                    end
                    local force = __arrL({0, 0}, 2)
                    do
                        local i = 0
                        while i < 2 do
                            do
                                local cpu = i == 1 and st.mode == "solo"
                                local press = nil
                                if __t(cpu) then
                                    st.cpuT = st.cpuT - dt
                                    if __le(st.cpuT, 0) then
                                        press = __get(st.last, 1) == "a" and "b" or "a"
                                        st.cpuT = 1 / (5.6 + st.round * 0.9 + math.sin(st.t * 2) * 1.2)
                                    end
                                else
                                    press = __t(__get(__L1.P, i).ap) and "a" or (__t(__get(__L1.P, i).bp) and "b" or nil)
                                end
                                if not __t(press) then
                                    do i = i + 1 continue end
                                end
                                local sweet = math.abs(__get(st.pulse, i) - 0.5) < 0.12
                                if press ~= __get(st.last, i) then
                                    __set(
                                        force,
                                        i,
                                        __get(force, i) + (__t(cpu) and 0.017 or 0.02) * (__t(sweet) and 2 or 1)
                                    )
                                    __inc(st.taps, i, 1, true)
                                    local ____t_872 = __t
                                    local ____t_result_871
                                    if __t(sweet) then
                                        ____t_result_871 = not __t(cpu)
                                    else
                                        ____t_result_871 = sweet
                                    end
                                    if ____t_872(____t_result_871) then
                                        __call(
                                            st.pop,
                                            "push",
                                            {
                                                x = __t(i) and 360 or 120,
                                                y = 70,
                                                s = "FORTE!",
                                                t = 0
                                            }
                                        )
                                    end
                                    __L1:sfx("pull")
                                else
                                    __set(
                                        force,
                                        i,
                                        __get(force, i) + 0.003
                                    )
                                end
                                __set(st.last, i, press)
                            end
                            i = i + 1
                        end
                    end
                    st.v = st.v + (__get(force, 1) - __get(force, 0)) * 6
                    st.v = st.v * 0.02 ^ dt
                    st.rope = __L1:clamp(st.rope + st.v * dt, -1.05, 1.05)
                    if math.abs(st.rope) >= 1 then
                        local w = __lt(st.rope, 0) and 0 or 1
                        __inc(st.wins, w, 1, true)
                        __L1:sfx(__t(w == 0 or st.mode == "duo") and "win" or "lose")
                        st.shake = 0.4
                        do
                            local j = 0
                            while j < 14 do
                                __call(
                                    st.mud,
                                    "push",
                                    {
                                        x = 240 + __L1:rnd(-20, 20),
                                        y = 214,
                                        vx = __L1:rnd(-90, 90),
                                        vy = __L1:rnd(-140, -40),
                                        t = 0
                                    }
                                )
                                j = j + 1
                            end
                        end
                        if __ge(
                            __get(st.wins, w),
                            2
                        ) then
                            if st.mode == "solo" then
                                st["end"](
                                    st,
                                    {
                                        score = __get(st.wins, 0) * 300 + (w == 0 and 400 or 0) + __get(st.taps, 0) * 2,
                                        win = w == 0,
                                        text = w == 0 and "Nikolas caiu na lama!" or "Você foi parar na lama!"
                                    }
                                )
                            else
                                local ____st_875 = st
                                local ____st_end_876 = st["end"]
                                local ____add_874 = __add
                                local ____t_result_873
                                if __t(w) then
                                    ____t_result_873 = __get(__L1.PLAYER_NAME, 1)
                                else
                                    ____t_result_873 = __get(__L1.PLAYER_NAME, 0)
                                end
                                ____st_end_876(
                                    ____st_875,
                                    {
                                        winner = w,
                                        text = ____add_874(____t_result_873, " venceu o cabo de guerra!")
                                    }
                                )
                            end
                        else
                            st.round = st.round + 1
                            st.rope = 0
                            st.v = 0
                            st.pause = 1.4
                            st.banner = {
                                s = __add("RODADA ", st.round),
                                t = 1.3
                            }
                        end
                    end
                    for ____, m in __iterar((st.mud)) do
                        m.t = __add(m.t, dt)
                        m.x = m.x + m.vx * dt
                        m.y = m.y + m.vy * dt
                        m.vy = m.vy + 300 * dt
                    end
                    st.mud = __call(
                        st.mud,
                        "filter",
                        function(____, m) return __lt(m.t, 1) end
                    )
                end,
                drawLow = function(self, g, st)
                    do
                        local i = 0
                        while i < 12 do
                            __L1:R(
                                g,
                                0,
                                i * 12,
                                __L1.LW,
                                12,
                                __get(
                                    __arrL({
                                        "#f3b06a",
                                        "#f0a060",
                                        "#e89058",
                                        "#e08050",
                                        "#d87850",
                                        "#c87050",
                                        "#b8684e",
                                        "#a8624e",
                                        "#98604e",
                                        "#885a4c",
                                        "#78544a",
                                        "#685048"
                                    }, 12),
                                    i
                                )
                            )
                            i = i + 1
                        end
                    end
                    __L1:R(
                        g,
                        0,
                        140,
                        __L1.LW,
                        70,
                        "#5a8a4a"
                    )
                    do
                        local x = 0
                        while x < __L1.LW do
                            __L1:R(
                                g,
                                x + (__t(__mod(x, 60)) and 0 or 8),
                                150 + __mod(x, 3) * 6,
                                20,
                                2,
                                "#6a9a52"
                            )
                            x = x + 30
                        end
                    end
                    __L1:R(
                        g,
                        0,
                        210,
                        __L1.LW,
                        60,
                        "#6a9a4a"
                    )
                    __L1:R(
                        g,
                        210,
                        208,
                        60,
                        10,
                        "#5a3a22"
                    )
                    __L1:R(
                        g,
                        214,
                        210,
                        52,
                        6,
                        "#7a4a2a"
                    )
                    do
                        local i = 0
                        while i < 6 do
                            __L1:R(
                                g,
                                216 + i * 9,
                                211 + __mod(i, 2) * 2,
                                4,
                                1,
                                "#9a6a3a"
                            )
                            i = i + 1
                        end
                    end
                    local off = st.rope * 150
                    local ry = 178
                    do
                        local x = 60
                        while x < 420 do
                            __L1:R(
                                g,
                                x + __mod(off, 4),
                                ry + math.floor(math.sin((x + st.t * 40) * 0.05) * (math.abs(st.v) * 2) + 0.5),
                                4,
                                3,
                                __t(__mod(x, 8)) and "#c8a060" or "#a88040"
                            )
                            x = x + 4
                        end
                    end
                    __L1:R(
                        g,
                        238 + off,
                        ry - 8,
                        4,
                        18,
                        "#e84a3a"
                    )
                    __L1:R(
                        g,
                        236 + off,
                        ry - 10,
                        8,
                        4,
                        "#ff7a5a"
                    )
                    __L1:R(
                        g,
                        240 - 150,
                        200,
                        2,
                        16,
                        "#fff"
                    )
                    __L1:R(
                        g,
                        240 + 150,
                        200,
                        2,
                        16,
                        "#fff"
                    )
                    for ____, m in __iterar((st.mud)) do
                        __L1:R(
                            g,
                            m.x,
                            m.y,
                            3,
                            3,
                            "#5a3a22"
                        )
                    end
                    do
                        local i = 0
                        while i < 2 do
                            do
                                local x = __t(i) and 400 or 80
                                local y = 60
                                local p = __get(st.pulse, i)
                                local r = 6 + math.abs(p - 0.5) * 22
                                local sweet = math.abs(p - 0.5) < 0.12
                                if __t(i == 1 and st.mode == "solo") then
                                    do i = i + 1 continue end
                                end
                                do
                                    local a = 0
                                    while a < 24 do
                                        local an = a / 24 * math.pi * 2
                                        __L1:R(
                                            g,
                                            x + math.cos(an) * r,
                                            y + math.sin(an) * r,
                                            2,
                                            2,
                                            __t(sweet) and "#7af07a" or "#fff3d0"
                                        )
                                        a = a + 1
                                    end
                                end
                                __L1:R(
                                    g,
                                    x - 1,
                                    y - 1,
                                    3,
                                    3,
                                    "#7af07a"
                                )
                            end
                            i = i + 1
                        end
                    end
                end,
                drawMain = function(self, c, st)
                    local off = st.rope * 300
                    local lean = math.min(
                        1,
                        math.abs(st.v) * 3
                    )
                    __L1:hero(
                        c,
                        "daroca",
                        300 + off - 70,
                        430,
                        {facing = 1, moving = lean > 0.2, frame = st.t * (1 + lean * 3), scale = 1.3}
                    )
                    local ____L1_hero_879 = __L1.hero
                    local ____c_878 = c
                    local ____temp_877
                    if st.mode == "solo" then
                        ____temp_877 = __L1:cpuType()
                    else
                        ____temp_877 = __get(__L1.PLAYER_TYPES, 1)
                    end
                    ____L1_hero_879(
                        __L1,
                        ____c_878,
                        ____temp_877,
                        660 + off + 70,
                        430,
                        {facing = -1, moving = lean > 0.2, frame = st.t * (1 + lean * 3), scale = 1.3}
                    )
                    __L1:txt(
                        c,
                        __add("RODADA ", st.round),
                        __L1.W / 2,
                        20,
                        14
                    )
                    __L1:txt(
                        c,
                        __add(
                            __call(
                                "● ",
                                "repeat",
                                __get(st.wins, 0)
                            ),
                            __call(
                                "○ ",
                                "repeat",
                                2 - __get(st.wins, 0)
                            )
                        ),
                        30,
                        20,
                        14,
                        __get(__L1.PLAYER_COL, 0),
                        "left"
                    )
                    __L1:txt(
                        c,
                        __add(
                            __call(
                                "○ ",
                                "repeat",
                                2 - __get(st.wins, 1)
                            ),
                            __call(
                                "● ",
                                "repeat",
                                __get(st.wins, 1)
                            )
                        ),
                        __L1.W - 70,
                        20,
                        14,
                        st.mode == "solo" and "#c9a8ff" or __get(__L1.PLAYER_COL, 1),
                        "right"
                    )
                    if __t(__gt(st.pause, 0) and __gt(st.t, 0.1)) then
                        __L1:txt(
                            c,
                            "PREPARA...",
                            __L1.W / 2,
                            250,
                            24,
                            "#fff3d0"
                        )
                    end
                end
            },
            "id,name,sub,color,duo,medals,rules,rulesDuo,controls,init,update,drawLow,drawMain"
        )
    )
    __call(
        __L1.GAMES,
        "push",
        __ord(
            {
                id = "chinelo",
                name = "CHUVA DE CHINELO",
                sub = "A mãe ficou brava. Corre!",
                color = "#7a9ae8",
                duo = "coop",
                max = 4,
                medals = __arrL({800, 2000, 4000}, 3),
                rules = __arrL({"Desvie dos chinelos que caem. A sombra mostra onde vão cair.", "Pegue os copos de açaí (+50). O coração devolve uma vida.", "O chinelo voador passa rasteiro: pule!"}, 3),
                rulesDuo = __arrL({"Os dois correm juntos e somam pontos.", "Cada um tem 3 vidas. Coração revive o parceiro.", "Acaba quando os dois caírem."}, 3),
                controls = __arrL({"Esquerda e direita: correr", "A: pular"}, 2),
                init = function(self, st)
                    local ____st_882 = st
                    local ____call_881 = __call
                    local ____temp_880
                    if st.mode == "duo" then
                        ____temp_880 = __get(
                            __arrL(
                                {
                                    __arrL({180, 300}, 2),
                                    __arrL({140, 240, 340}, 3),
                                    __arrL({120, 200, 280, 360}, 4)
                                },
                                3
                            ),
                            __L1:NP(st) - 2
                        )
                    else
                        ____temp_880 = __arrL({240}, 1)
                    end
                    ____st_882.pl = ____call_881(
                        ____temp_880,
                        "map",
                        function(____, x, i) return {
                            x = x,
                            y = 0,
                            vy = 0,
                            hp = 3,
                            inv = 0,
                            face = 1,
                            i = i
                        } end
                    )
                    st.items = __arrL({}, 0)
                    st.spawn = 0
                    st.flyT = 8
                    st.time = 0
                    st.acai = 0
                end,
                update = function(self, st, dt)
                    st.time = __add(st.time, dt)
                    local diff = math.min(1, st.time / 90)
                    __call(
                        st.pl,
                        "forEach",
                        function(____, p)
                            if __le(p.hp, 0) then
                                return
                            end
                            local i = p.i
                            p.x = __L1:clamp(
                                p.x + __get(__L1.P, i).x * 170 * dt,
                                12,
                                __L1.LW - 12
                            )
                            if __t(__get(__L1.P, i).x) then
                                p.face = __get(__L1.P, i).x
                            end
                            local ____t_886 = __t
                            local ____t_result_885
                            local ____t_884 = __t
                            local ____temp_883 = p.y == 0
                            __O[1155] = ____temp_883
                            if ____t_884(____temp_883) then
                                ____t_result_885 = __get(__L1.P, i).ap
                            else
                                ____t_result_885 = __O[1155]
                            end
                            if ____t_886(____t_result_885) then
                                p.vy = 230
                                __L1:sfx("bounce")
                            end
                            p.vy = p.vy - 620 * dt
                            p.y = math.max(0, p.y + p.vy * dt)
                            if p.y == 0 then
                                p.vy = 0
                            end
                            p.inv = math.max(0, p.inv - dt)
                        end
                    )
                    st.spawn = st.spawn - dt
                    if __le(st.spawn, 0) then
                        st.spawn = math.max(0.22, 0.85 - diff * 0.6)
                        local x = __L1:rnd(14, __L1.LW - 14)
                        local r = math.random()
                        __call(
                            st.items,
                            "push",
                            {
                                kind = r < 0.1 and "acai" or (r < 0.118 and "coracao" or "chinelo"),
                                x = x,
                                y = -30,
                                vy = 0,
                                warn = 0.7 - diff * 0.25,
                                rot = __L1:rnd(0, 6)
                            }
                        )
                    end
                    st.flyT = st.flyT - dt
                    if __le(st.flyT, 0) then
                        st.flyT = __L1:rnd(6, 11) - diff * 3
                        local dir = math.random() < 0.5 and 1 or -1
                        __call(st.items, "push", {
                            kind = "voador",
                            x = dir > 0 and -20 or __L1.LW + 20,
                            y = 232,
                            vx = dir * (190 + diff * 90),
                            warn = 0.8
                        })
                    end
                    for ____, it in __iterar((st.items)) do
                        do
                            if __gt(it.warn, 0) then
                                it.warn = it.warn - dt
                                continue
                            end
                            if it.kind == "voador" then
                                it.x = it.x + it.vx * dt
                            else
                                it.vy = it.vy + 520 * dt
                                it.y = it.y + it.vy * dt
                                it.rot = it.rot + dt * 8
                            end
                            for ____, p in __iterar((st.pl)) do
                                do
                                    local ____t_890 = __t
                                    local ____t_result_889
                                    local ____t_888 = __t
                                    local ____le_result_887 = __le(p.hp, 0)
                                    __O[1156] = ____le_result_887
                                    if ____t_888(____le_result_887) then
                                        ____t_result_889 = __O[1156]
                                    else
                                        ____t_result_889 = it.done
                                    end
                                    if ____t_890(____t_result_889) then
                                        continue
                                    end
                                    local py = 248 - p.y
                                    local ____temp_894
                                    if it.kind == "voador" then
                                        ____temp_894 = math.abs(it.x - p.x) < 10 and __lt(p.y, 14)
                                    else
                                        local ____t_result_893
                                        local ____t_892 = __t
                                        local ____temp_891 = math.abs(it.x - p.x) < 12 and __gt(it.y, py - 30)
                                        __O[1157] = ____temp_891
                                        if ____t_892(____temp_891) then
                                            ____t_result_893 = __lt(it.y, py)
                                        else
                                            ____t_result_893 = __O[1157]
                                        end
                                        ____temp_894 = ____t_result_893
                                    end
                                    local hit = ____temp_894
                                    if not __t(hit) then
                                        continue
                                    end
                                    if it.kind == "acai" then
                                        it.done = true
                                        st.acai = st.acai + 1
                                        __set(
                                            st.score,
                                            0,
                                            __get(st.score, 0) + 50
                                        )
                                        __L1:sfx("pick")
                                        __call(st.pop, "push", {x = it.x, y = py - 30, s = "+50", t = 0})
                                    elseif it.kind == "coracao" then
                                        it.done = true
                                        local dead = __call(
                                            st.pl,
                                            "find",
                                            function(____, q) return __le(q.hp, 0) end
                                        )
                                        if __t(dead) then
                                            dead.hp = 1
                                            dead.inv = 2
                                        else
                                            p.hp = math.min(3, p.hp + 1)
                                        end
                                        __L1:sfx("power")
                                    elseif __le(p.inv, 0) then
                                        p.hp = p.hp - 1
                                        p.inv = 1.3
                                        it.done = it.kind ~= "voador"
                                        __L1:sfx("hit")
                                        st.shake = 0.25
                                    end
                                end
                            end
                            if __t(it.kind ~= "voador" and __gt(it.y, 250)) then
                                it.done = true
                                if it.kind == "chinelo" then
                                    do
                                        local j = 0
                                        while j < 3 do
                                            __call(
                                                st.pop,
                                                "push",
                                                {
                                                    x = __add(
                                                        it.x,
                                                        __L1:rnd(-6, 6)
                                                    ),
                                                    y = 248,
                                                    s = "·",
                                                    t = 0
                                                }
                                            )
                                            j = j + 1
                                        end
                                    end
                                end
                            end
                            local ____t_898 = __t
                            local ____t_result_897
                            local ____t_896 = __t
                            local ____temp_895 = it.kind == "voador"
                            __O[1158] = ____temp_895
                            if ____t_896(____temp_895) then
                                ____t_result_897 = __lt(it.x, -40) or __gt(it.x, __L1.LW + 40)
                            else
                                ____t_result_897 = __O[1158]
                            end
                            if ____t_898(____t_result_897) then
                                it.done = true
                            end
                        end
                    end
                    st.items = __call(
                        st.items,
                        "filter",
                        function(____, it) return not __t(it.done) end
                    )
                    __set(
                        st.score,
                        0,
                        __get(st.score, 0) + dt * 10
                    )
                    if __t(__call(
                        st.pl,
                        "every",
                        function(____, p) return __le(p.hp, 0) end
                    )) then
                        __L1:sfx("lose")
                        st["end"](
                            st,
                            {
                                score = math.floor(__get(st.score, 0) + 0.5),
                                text = __add(
                                    __add(
                                        __add(
                                            __add(
                                                "Sobreviveu ",
                                                math.floor(st.time)
                                            ),
                                            " segundos e pegou "
                                        ),
                                        st.acai
                                    ),
                                    " açaí."
                                )
                            }
                        )
                    end
                end,
                drawLow = function(self, g, st)
                    __L1:R(
                        g,
                        0,
                        0,
                        __L1.LW,
                        250,
                        "#c4cca8"
                    )
                    do
                        local i = 0
                        while i < 10 do
                            __L1:R(
                                g,
                                0,
                                i * 20,
                                __L1.LW,
                                20,
                                __get(
                                    __arrL({
                                        "#8ec7e1",
                                        "#94cbe2",
                                        "#9ccfe2",
                                        "#a6d3e0",
                                        "#b0d6dc",
                                        "#bad8d6",
                                        "#c2d8cc",
                                        "#c8d6c0",
                                        "#c8d2b4",
                                        "#c4cca8"
                                    }, 10),
                                    i
                                )
                            )
                            i = i + 1
                        end
                    end
                    do
                        local i = 0
                        while i < 6 do
                            local x = i * 90 + 10
                            local h = 40 + __mod(i, 3) * 18
                            __L1:R(
                                g,
                                x,
                                250 - h - 20,
                                70,
                                h,
                                __get(
                                    __arrL({
                                        "#d4a06d",
                                        "#bf7956",
                                        "#c48b70",
                                        "#d98a8a",
                                        "#a8b29b",
                                        "#b7855e"
                                    }, 6),
                                    i
                                )
                            )
                            do
                                local w = 0
                                while w < 3 do
                                    __L1:R(
                                        g,
                                        x + 10 + w * 20,
                                        250 - h - 8,
                                        8,
                                        10,
                                        "#5a7a8a"
                                    )
                                    w = w + 1
                                end
                            end
                            __L1:R(
                                g,
                                x - 3,
                                250 - h - 22,
                                76,
                                4,
                                "#8a5a3a"
                            )
                            i = i + 1
                        end
                    end
                    __L1:R(
                        g,
                        0,
                        250,
                        __L1.LW,
                        20,
                        "#9a8a6a"
                    )
                    __L1:R(
                        g,
                        0,
                        250,
                        __L1.LW,
                        2,
                        "#b8a888"
                    )
                    do
                        local x = 0
                        while x < __L1.LW do
                            __L1:R(
                                g,
                                x,
                                258,
                                12,
                                1,
                                "#8a7a5a"
                            )
                            x = x + 24
                        end
                    end
                    for ____, it in __iterar((st.items)) do
                        do
                            if it.kind == "voador" then
                                if __gt(it.warn, 0) then
                                    if __t(__mod(
                                        math.floor(st.t * 10),
                                        2
                                    )) then
                                        __L1:txt(
                                            g,
                                            "!",
                                            __gt(it.vx, 0) and 10 or __L1.LW - 10,
                                            232,
                                            10,
                                            "#e84a3a",
                                            "center",
                                            nil
                                        )
                                    end
                                    continue
                                end
                                __L1:R(
                                    g,
                                    it.x - 10,
                                    it.y - 3,
                                    20,
                                    6,
                                    "#2a5ad0"
                                )
                                __L1:R(
                                    g,
                                    it.x - 8,
                                    it.y - 2,
                                    16,
                                    4,
                                    "#4a8af0"
                                )
                                __L1:R(
                                    g,
                                    it.x - 2,
                                    it.y - 5,
                                    4,
                                    3,
                                    "#f0f0f0"
                                )
                                continue
                            end
                            local sw = math.max(
                                4,
                                14 - math.max(0, 250 - it.y) / 25
                            )
                            __L1:R(
                                g,
                                it.x - sw,
                                249,
                                sw * 2,
                                2,
                                "rgba(20,20,30,.35)"
                            )
                            if __gt(it.warn, 0) then
                                continue
                            end
                            if it.kind == "chinelo" then
                                local v = __mod(
                                    math.floor(it.rot),
                                    2
                                )
                                if __t(v) then
                                    __L1:R(
                                        g,
                                        it.x - 4,
                                        it.y - 9,
                                        8,
                                        18,
                                        "#2a5ad0"
                                    )
                                    __L1:R(
                                        g,
                                        it.x - 3,
                                        it.y - 8,
                                        6,
                                        16,
                                        "#4a8af0"
                                    )
                                    __L1:R(
                                        g,
                                        it.x - 1,
                                        it.y - 6,
                                        2,
                                        5,
                                        "#f0f0f0"
                                    )
                                else
                                    __L1:R(
                                        g,
                                        it.x - 9,
                                        it.y - 4,
                                        18,
                                        8,
                                        "#2a5ad0"
                                    )
                                    __L1:R(
                                        g,
                                        it.x - 8,
                                        it.y - 3,
                                        16,
                                        6,
                                        "#4a8af0"
                                    )
                                    __L1:R(
                                        g,
                                        it.x - 4,
                                        it.y - 1,
                                        5,
                                        2,
                                        "#f0f0f0"
                                    )
                                end
                            elseif it.kind == "acai" then
                                __L1:R(
                                    g,
                                    it.x - 5,
                                    it.y - 8,
                                    10,
                                    10,
                                    "#f0f0f0"
                                )
                                __L1:R(
                                    g,
                                    it.x - 4,
                                    it.y - 7,
                                    8,
                                    4,
                                    "#5a1a5a"
                                )
                                __L1:R(
                                    g,
                                    it.x - 3,
                                    it.y - 9,
                                    6,
                                    2,
                                    "#9a3a8a"
                                )
                                __L1:R(
                                    g,
                                    it.x + 1,
                                    it.y - 13,
                                    1,
                                    5,
                                    "#e84a3a"
                                )
                            else
                                __L1:R(
                                    g,
                                    it.x - 5,
                                    it.y - 4,
                                    4,
                                    4,
                                    "#e84a5a"
                                )
                                __L1:R(
                                    g,
                                    it.x + 1,
                                    it.y - 4,
                                    4,
                                    4,
                                    "#e84a5a"
                                )
                                __L1:R(
                                    g,
                                    it.x - 5,
                                    it.y - 1,
                                    10,
                                    3,
                                    "#e84a5a"
                                )
                                __L1:R(
                                    g,
                                    it.x - 3,
                                    it.y + 2,
                                    6,
                                    2,
                                    "#e84a5a"
                                )
                            end
                        end
                    end
                end,
                drawMain = function(self, c, st)
                    __call(
                        st.pl,
                        "forEach",
                        function(____, p)
                            if __le(p.hp, 0) then
                                __L1:hero(
                                    c,
                                    __get(__L1.PLAYER_TYPES, p.i),
                                    p.x * 2,
                                    500,
                                    {facing = p.face, emotion = "sad", opacity = 0.4}
                                )
                                return
                            end
                            local ____t_902 = __t
                            local ____t_result_901
                            local ____t_900 = __t
                            local ____gt_result_899 = __gt(p.inv, 0)
                            __O[1159] = ____gt_result_899
                            if ____t_900(____gt_result_899) then
                                ____t_result_901 = __mod(
                                    math.floor(st.t * 14),
                                    2
                                )
                            else
                                ____t_result_901 = __O[1159]
                            end
                            if ____t_902(____t_result_901) then
                                return
                            end
                            __L1:hero(
                                c,
                                __get(__L1.PLAYER_TYPES, p.i),
                                p.x * 2,
                                500 - p.y * 2,
                                {
                                    facing = p.face,
                                    moving = math.abs(__get(__L1.P, p.i).x) > 0,
                                    frame = st.t * 1.5,
                                    grounded = p.y == 0,
                                    vy = __TS__Number(-p.vy)
                                }
                            )
                        end
                    )
                    __L1:txt(
                        c,
                        __add(
                            "PONTOS ",
                            math.floor(__get(st.score, 0) + 0.5)
                        ),
                        __L1.W / 2,
                        __gt(
                            __len(st.pl),
                            2
                        ) and 44 or 16,
                        14
                    )
                    if __gt(
                        __len(st.pl),
                        2
                    ) then
                        __L1:scoreBar(
                            c,
                            __call(
                                st.pl,
                                "map",
                                function(____, p)
                                    local ____t_result_905
                                    local ____t_904 = __t
                                    local ____call_result_903 = __call(
                                        "♥",
                                        "repeat",
                                        math.max(0, p.hp)
                                    )
                                    __O[1160] = ____call_result_903
                                    if ____t_904(____call_result_903) then
                                        ____t_result_905 = __O[1160]
                                    else
                                        ____t_result_905 = "✕"
                                    end
                                    return ____t_result_905
                                end
                            )
                        )
                    else
                        __call(
                            st.pl,
                            "forEach",
                            function(____, p, i)
                                local ____L1_txt_912 = __L1.txt
                                local ____c_910 = c
                                local ____add_908 = __add
                                local ____add_907 = __add
                                local ____temp_906
                                if st.mode == "duo" then
                                    ____temp_906 = __add(
                                        __get(__L1.PLAYER_NAME, i),
                                        " "
                                    )
                                else
                                    ____temp_906 = ""
                                end
                                local ____add_908_result_911 = ____add_908(
                                    ____add_907(
                                        ____temp_906,
                                        __call(
                                            "♥",
                                            "repeat",
                                            math.max(0, p.hp)
                                        )
                                    ),
                                    __call(
                                        "♡",
                                        "repeat",
                                        3 - math.max(0, p.hp)
                                    )
                                )
                                local ____t_result_909
                                if __t(i) then
                                    ____t_result_909 = __L1.W - 70
                                else
                                    ____t_result_909 = 20
                                end
                                return ____L1_txt_912(
                                    __L1,
                                    ____c_910,
                                    ____add_908_result_911,
                                    ____t_result_909,
                                    16,
                                    14,
                                    __get(__L1.PLAYER_COL, i),
                                    __t(i) and "right" or "left"
                                )
                            end
                        )
                    end
                end
            },
            "id,name,sub,color,duo,max,medals,rules,rulesDuo,controls,init,update,drawLow,drawMain"
        )
    )
    __call(
        __L1.GAMES,
        "push",
        __ord(
            {
                id = "galo",
                name = "REFLEXO DO GALO",
                sub = "Cocoricó! Quem aperta primeiro?",
                color = "#e8c050",
                duo = "versus",
                max = 4,
                medals = __arrL({1200, 1800, 2200}, 3),
                rules = __arrL({"Espere o galo cantar COCORICÓ! e aperte A o mais rápido que puder.", "Cuidado: a galinha e o pato também fazem barulho. Não caia!", "5 rodadas. Quanto mais rápido, mais pontos."}, 3),
                rulesDuo = __arrL({"Os dois esperam o COCORICÓ!", "Quem apertar primeiro ganha a rodada.", "Apertou antes da hora? O ponto vai para o outro. Vence quem fizer 3."}, 3),
                controls = __arrL({"A: apertar"}, 1),
                init = function(self, st)
                    st.round = 0
                    st.times = __arrL({}, 0)
                    st.pts = __arrL({0, 0, 0, 0}, 4)
                    st:next(st)
                end,
                update = function(self, st, dt)
                    local r = st.r
                    if r.state == "wait" then
                        r.wait = r.wait - dt
                        if __t(r.fakeAt ~= nil and __le(r.wait, r.fakeAt)) then
                            r.fake = {
                                s = math.random() < 0.5 and "COCÓ..." or "QUÉN!",
                                t = 0.8
                            }
                            r.fakeAt = nil
                            __L1:sfx("fake")
                        end
                        if __t(r.fake) then
                            local ____r_fake_913, ____t_914 = r.fake, "t"
                            ____r_fake_913[____t_914] = ____r_fake_913[____t_914] - dt
                            if __le(r.fake.t, 0) then
                                r.fake = nil
                            end
                        end
                        do
                            local i = 0
                            while __lt(
                                i,
                                __L1:NP(st)
                            ) do
                                local ____t_918 = __t
                                local ____t_result_917
                                local ____t_916 = __t
                                local ____get_result_ap_915 = __get(__L1.P, i).ap
                                __O[1161] = ____get_result_ap_915
                                if ____t_916(____get_result_ap_915) then
                                    ____t_result_917 = r.state == "wait"
                                else
                                    ____t_result_917 = __O[1161]
                                end
                                if ____t_918(____t_result_917) then
                                    r.state = "early"
                                    r.who = i
                                    r.t = 0
                                    __L1:sfx("lose")
                                    st.shake = 0.2
                                    if st.mode == "duo" then
                                        do
                                            local k = 0
                                            while __lt(
                                                k,
                                                __L1:NP(st)
                                            ) do
                                                if k ~= i then
                                                    __inc(st.pts, k, 1, true)
                                                end
                                                k = k + 1
                                            end
                                        end
                                    else
                                        __call(st.times, "push", 600)
                                    end
                                end
                                i = i + 1
                            end
                        end
                        if __t(r.state == "wait" and __le(r.wait, 0)) then
                            r.state = "go"
                            r.t = 0
                            __L1:sfx("crow")
                        end
                    elseif r.state == "go" then
                        r.t = __add(r.t, dt)
                        do
                            local i = 0
                            while __lt(
                                i,
                                __L1:NP(st)
                            ) do
                                local ____t_922 = __t
                                local ____t_result_921
                                local ____t_920 = __t
                                local ____get_result_ap_919 = __get(__L1.P, i).ap
                                __O[1162] = ____get_result_ap_919
                                if ____t_920(____get_result_ap_919) then
                                    ____t_result_921 = r.state == "go"
                                else
                                    ____t_result_921 = __O[1162]
                                end
                                if ____t_922(____t_result_921) then
                                    r.state = "hit"
                                    r.who = i
                                    r.ms = math.floor(r.t * 1000 + 0.5)
                                    r.t2 = 0
                                    __L1:sfx("pick")
                                    if st.mode == "duo" then
                                        __inc(st.pts, i, 1, true)
                                    else
                                        __call(st.times, "push", r.ms)
                                    end
                                end
                                i = i + 1
                            end
                        end
                        if __t(r.state == "go" and __gt(r.t, 2)) then
                            r.state = "hit"
                            r.who = nil
                            r.ms = 2000
                            r.t2 = 0
                            if st.mode == "solo" then
                                __call(st.times, "push", 1000)
                            end
                        end
                    else
                        local ____add_924 = __add
                        local ____t_result_923
                        if __t(r.t2) then
                            ____t_result_923 = r.t2
                        else
                            ____t_result_923 = 0
                        end
                        r.t2 = ____add_924(____t_result_923, dt)
                        local ____add_926 = __add
                        local ____t_result_925
                        if __t(r.t) then
                            ____t_result_925 = r.t
                        else
                            ____t_result_925 = 0
                        end
                        r.t = ____add_926(____t_result_925, dt)
                        local ____t_930 = __t
                        local ____t_result_929
                        local ____t_928 = __t
                        local ____temp_927 = __gt(r.t2, 1.6) and r.state == "hit"
                        __O[1163] = ____temp_927
                        if ____t_928(____temp_927) then
                            ____t_result_929 = __O[1163]
                        else
                            ____t_result_929 = r.state == "early" and __gt(r.t, 1.6)
                        end
                        if ____t_930(____t_result_929) then
                            local ____temp_931
                            if st.mode == "solo" then
                                ____temp_931 = __ge(
                                    __len(st.times),
                                    5
                                )
                            else
                                ____temp_931 = math.max(__TS__Spread(__iter(st.pts))) >= 3
                            end
                            local done = ____temp_931
                            if __t(done) then
                                if st.mode == "solo" then
                                    local sc = __call(
                                        st.times,
                                        "reduce",
                                        function(____, s, ms) return s + math.max(0, 800 - ms) end,
                                        0
                                    )
                                    local avg = math.floor(__call(
                                        st.times,
                                        "reduce",
                                        function(____, a, b) return __add(a, b) end,
                                        0
                                    ) / __len(st.times) + 0.5)
                                    st["end"](
                                        st,
                                        {
                                            score = sc,
                                            text = __add(
                                                __add("Tempo médio: ", avg),
                                                " ms"
                                            )
                                        }
                                    )
                                else
                                    local sc = __call(
                                        st.pts,
                                        "slice",
                                        0,
                                        __L1:NP(st)
                                    )
                                    local best = math.max(__TS__Spread(__iter(sc)))
                                    local ____gt_result_932
                                    if __gt(
                                        __len(__call(
                                            sc,
                                            "filter",
                                            function(____, v) return v == best end
                                        )),
                                        1
                                    ) then
                                        ____gt_result_932 = nil
                                    else
                                        ____gt_result_932 = __call(sc, "indexOf", best)
                                    end
                                    local w = ____gt_result_932
                                    st["end"](
                                        st,
                                        {
                                            winner = w,
                                            text = w == nil and "Empate de reflexos!" or __add(
                                                __get(__L1.PLAYER_NAME, w),
                                                " tem o reflexo mais rápido da roça!"
                                            )
                                        }
                                    )
                                end
                            else
                                st:next(st)
                            end
                        end
                    end
                end,
                drawLow = function(self, g, st)
                    local r = st.r
                    local go = r.state == "go" or r.state == "hit"
                    do
                        local i = 0
                        while i < 12 do
                            local ____L1_R_935 = __L1.R
                            local ____array_934 = __TS__SparseArrayNew(
                                g,
                                0,
                                i * 12,
                                __L1.LW,
                                12
                            )
                            local ____t_result_933
                            if __t(go) then
                                ____t_result_933 = __get(
                                    __arrL({
                                        "#f8d890",
                                        "#f8d088",
                                        "#f4c880",
                                        "#f0c078",
                                        "#ecb870",
                                        "#e8b068",
                                        "#e0a860",
                                        "#d8a058",
                                        "#d09850",
                                        "#c89048",
                                        "#c08840",
                                        "#b88038"
                                    }, 12),
                                    i
                                )
                            else
                                ____t_result_933 = __get(
                                    __arrL({
                                        "#2a3058",
                                        "#323862",
                                        "#3a406a",
                                        "#444870",
                                        "#4e5076",
                                        "#5a587a",
                                        "#66607c",
                                        "#72687e",
                                        "#7e7080",
                                        "#8a7880",
                                        "#968080",
                                        "#a08880"
                                    }, 12),
                                    i
                                )
                            end
                            __TS__SparseArrayPush(____array_934, ____t_result_933)
                            ____L1_R_935(
                                __L1,
                                __TS__SparseArraySpread(____array_934)
                            )
                            i = i + 1
                        end
                    end
                    __L1:R(
                        g,
                        0,
                        150,
                        __L1.LW,
                        120,
                        __t(go) and "#6a9a4a" or "#3a5a3a"
                    )
                    do
                        local x = 0
                        while x < __L1.LW do
                            __L1:R(
                                g,
                                x,
                                160,
                                4,
                                40,
                                "#7a5a3a"
                            )
                            x = x + 40
                        end
                    end
                    __L1:R(
                        g,
                        0,
                        168,
                        __L1.LW,
                        3,
                        "#8a6a4a"
                    )
                    __L1:R(
                        g,
                        0,
                        184,
                        __L1.LW,
                        3,
                        "#8a6a4a"
                    )
                    local bx = 240
                    local by = 168 - (__t(go) and 6 or 0)
                    __L1:R(
                        g,
                        bx - 10,
                        by - 18,
                        20,
                        16,
                        "#f4f0e0"
                    )
                    __L1:R(
                        g,
                        bx - 14,
                        by - 16,
                        6,
                        10,
                        "#2a5a3a"
                    )
                    __L1:R(
                        g,
                        bx - 16,
                        by - 22,
                        6,
                        10,
                        "#3a7a4a"
                    )
                    __L1:R(
                        g,
                        bx + 6,
                        by - 30,
                        10,
                        12,
                        "#f4f0e0"
                    )
                    __L1:R(
                        g,
                        bx + 8,
                        by - 34,
                        6,
                        4,
                        "#e83a3a"
                    )
                    __L1:R(
                        g,
                        bx + 16,
                        by - 26,
                        __t(go) and 6 or 4,
                        3,
                        "#e8a83a"
                    )
                    __L1:R(
                        g,
                        bx + 12,
                        by - 27,
                        2,
                        2,
                        "#1a1a1a"
                    )
                    __L1:R(
                        g,
                        bx + 10,
                        by - 20,
                        4,
                        4,
                        "#e83a3a"
                    )
                    __L1:R(
                        g,
                        bx - 4,
                        by - 2,
                        2,
                        4,
                        "#e8a83a"
                    )
                    __L1:R(
                        g,
                        bx + 3,
                        by - 2,
                        2,
                        4,
                        "#e8a83a"
                    )
                    if __t(go) then
                        do
                            local i = 0
                            while i < 8 do
                                local a = i / 8 * math.pi * 2 + st.t
                                __L1:R(
                                    g,
                                    bx + math.cos(a) * (40 + __mod(st.t * 60, 30)),
                                    by - 24 + math.sin(a) * (24 + __mod(st.t * 40, 20)),
                                    3,
                                    3,
                                    "#fff3a0"
                                )
                                i = i + 1
                            end
                        end
                    end
                    if __t(r.fake) then
                        __L1:R(
                            g,
                            90,
                            150,
                            14,
                            10,
                            "#e8d8c0"
                        )
                        __L1:R(
                            g,
                            100,
                            146,
                            6,
                            6,
                            "#e8d8c0"
                        )
                        __L1:R(
                            g,
                            106,
                            148,
                            3,
                            2,
                            "#e8a83a"
                        )
                    end
                end,
                drawMain = function(self, c, st)
                    local r = st.r
                    if r.state == "wait" then
                        local ____L1_txt_938 = __L1.txt
                        local ____c_937 = c
                        local ____t_result_936
                        if __t(r.fake) then
                            ____t_result_936 = r.fake.s
                        else
                            ____t_result_936 = "ESPERA..."
                        end
                        ____L1_txt_938(
                            __L1,
                            ____c_937,
                            ____t_result_936,
                            __L1.W / 2,
                            140,
                            __t(r.fake) and 26 or 22,
                            __t(r.fake) and "#ffd0a0" or "#c8c8e8"
                        )
                    end
                    if r.state == "go" then
                        __L1:txt(
                            c,
                            "COCORICÓ!",
                            __L1.W / 2,
                            140,
                            44,
                            "#fff3a0",
                            "center",
                            "#a04010"
                        )
                    end
                    if r.state == "early" then
                        local ____L1_txt_942 = __L1.txt
                        local ____c_941 = c
                        local ____add_940 = __add
                        local ____temp_939
                        if st.mode == "duo" then
                            ____temp_939 = __add(
                                __get(__L1.PLAYER_NAME, r.who),
                                " "
                            )
                        else
                            ____temp_939 = ""
                        end
                        ____L1_txt_942(
                            __L1,
                            ____c_941,
                            ____add_940(____temp_939, "APERTOU ANTES!"),
                            __L1.W / 2,
                            140,
                            26,
                            "#ff8a7a"
                        )
                    end
                    if r.state == "hit" then
                        local ____L1_txt_953 = __L1.txt
                        local ____c_951 = c
                        local ____temp_946
                        if r.who == nil then
                            ____temp_946 = "NINGUÉM APERTOU!"
                        else
                            local ____add_945 = __add
                            local ____add_944 = __add
                            local ____temp_943
                            if st.mode == "duo" then
                                ____temp_943 = __add(
                                    __get(__L1.PLAYER_NAME, r.who),
                                    " · "
                                )
                            else
                                ____temp_943 = ""
                            end
                            ____temp_946 = ____add_945(
                                ____add_944(____temp_943, r.ms),
                                " ms"
                            )
                        end
                        local ____temp_952 = __L1.W / 2
                        local ____temp_950
                        if r.who == nil then
                            ____temp_950 = "#ff8a7a"
                        else
                            local ____get_949 = __get
                            local ____L1_PLAYER_COL_948 = __L1.PLAYER_COL
                            local ____t_result_947
                            if __t(r.who) then
                                ____t_result_947 = r.who
                            else
                                ____t_result_947 = 0
                            end
                            ____temp_950 = ____get_949(____L1_PLAYER_COL_948, ____t_result_947)
                        end
                        ____L1_txt_953(
                            __L1,
                            ____c_951,
                            ____temp_946,
                            ____temp_952,
                            140,
                            32,
                            ____temp_950
                        )
                    end
                    local n = __L1:NP(st)
                    do
                        local i = 0
                        while __lt(i, n) do
                            local ____temp_955
                            if n == 1 then
                                ____temp_955 = __L1.W / 2
                            else
                                local ____temp_954
                                if n == 2 then
                                    ____temp_954 = __t(i) and 720 or 240
                                else
                                    ____temp_954 = 160 + i * (640 / (n - 1))
                                end
                                ____temp_955 = ____temp_954
                            end
                            local x = ____temp_955
                            local react = r.state == "hit" and r.who == i
                            __L1:hero(
                                c,
                                __get(__L1.PLAYER_TYPES, i),
                                x,
                                520,
                                {
                                    facing = __t(i) and -1 or 1,
                                    attack = react,
                                    attackProgress = 0.5,
                                    emotion = __t(r.state == "early" and r.who == i) and "embarrassed" or nil,
                                    frame = st.t,
                                    scale = 1.4
                                }
                            )
                            i = i + 1
                        end
                    end
                    if st.mode == "solo" then
                        __L1:txt(
                            c,
                            __add(
                                __add(
                                    "RODADA ",
                                    math.min(
                                        5,
                                        __len(st.times) + (__t(r.state == "wait" or r.state == "go") and 1 or 0)
                                    )
                                ),
                                " / 5"
                            ),
                            __L1.W / 2,
                            18,
                            14
                        )
                    else
                        __L1:scoreBar(
                            c,
                            __call(st.pts, "slice", 0, n)
                        )
                    end
                end,
                extra = {next = function(self, st)
                    st.round = st.round + 1
                    local wait = __L1:rnd(1.6, 4.4)
                    local ____st_958 = st
                    local ____wait_957 = wait
                    local ____temp_956
                    if math.random() < 0.55 then
                        ____temp_956 = __L1:rnd(0.6, wait - 0.5)
                    else
                        ____temp_956 = nil
                    end
                    ____st_958.r = {
                        state = "wait",
                        wait = ____wait_957,
                        fakeAt = ____temp_956,
                        fake = nil,
                        t = 0
                    }
                end}
            },
            "id,name,sub,color,duo,max,medals,rules,rulesDuo,controls,init,update,drawLow,drawMain,extra"
        )
    )
    __L1.FEIRA = __arrL({
        "milho",
        "melancia",
        "acai",
        "bolo",
        "chapeu",
        "chinelo",
        "cafe",
        "caderno",
        "galo",
        "bola"
    }, 10)
    __call(
        __L1.GAMES,
        "push",
        __ord(
            {
                id = "memoria",
                name = "MEMÓRIA DA FEIRA",
                sub = "Ache os pares da barraca.",
                color = "#c08ae8",
                duo = "versus",
                max = 4,
                medals = __arrL({600, 1000, 1300}, 3),
                rules = __arrL({"Vire duas cartas: se forem iguais, o par é seu.", "Menos jogadas e menos tempo dão mais pontos.", "Pares seguidos valem bônus de sequência."}, 3),
                rulesDuo = __arrL({"Cada um joga na sua vez.", "Acertou o par? Joga de novo.", "Quem juntar mais pares vence."}, 3),
                controls = __arrL({"Direcional: escolher carta", "A: virar (ou toque na carta)"}, 2),
                init = function(self, st)
                    local deck = __call(
                        __call(__L1.FEIRA, "concat", __L1.FEIRA),
                        "map",
                        function(____, k) return {k = k, up = false, done = false, flip = 0} end
                    )
                    do
                        local i = __len(deck) - 1
                        while i > 0 do
                            local j = __L1:irnd(0, i)
                            do
                                do
                                    __O[1164] = __iter(__arrL(
                                        {
                                            __get(deck, j),
                                            __get(deck, i)
                                        },
                                        2
                                    ))
                                    __set(
                                        deck,
                                        i,
                                        __get(__O[1164], 0)
                                    )
                                end
                                __set(
                                    deck,
                                    j,
                                    __get(__O[1164], 1)
                                )
                            end
                            local ____ = __O[1164]
                            i = i - 1
                        end
                    end
                    st.cards = deck
                    st.cur = 0
                    st.open = __arrL({}, 0)
                    st.wait = 0
                    st.moves = 0
                    st.combo = 0
                    st.best = 0
                    st.turn = 0
                    st.pairs = __arrL({0, 0, 0, 0}, 4)
                    st.time = 0
                end,
                pos = function(self, i)
                    return {
                        x = 98 + __mod(i, 5) * 58,
                        y = 34 + math.floor(i / 5) * 56
                    }
                end,
                flip = function(self, st, i)
                    local c = __get(st.cards, i)
                    local ____t_966 = __t
                    local ____t_result_965
                    local ____t_964 = __t
                    local ____t_result_963
                    local ____t_962 = __t
                    local ____t_result_961
                    local ____t_960 = __t
                    local ____gt_result_959 = __gt(st.wait, 0)
                    __O[1165] = ____gt_result_959
                    if ____t_960(____gt_result_959) then
                        ____t_result_961 = __O[1165]
                    else
                        ____t_result_961 = c.up
                    end
                    __O[1166] = ____t_result_961
                    if ____t_962(____t_result_961) then
                        ____t_result_963 = __O[1166]
                    else
                        ____t_result_963 = c.done
                    end
                    __O[1167] = ____t_result_963
                    if ____t_964(____t_result_963) then
                        ____t_result_965 = __O[1167]
                    else
                        ____t_result_965 = __ge(
                            __len(st.open),
                            2
                        )
                    end
                    if ____t_966(____t_result_965) then
                        return
                    end
                    c.up = true
                    c.flip = 1
                    __call(st.open, "push", i)
                    __L1:sfx("move")
                    if __len(st.open) == 2 then
                        st.moves = st.moves + 1
                        local a, b = table.unpack(
                            __call(
                                st.open,
                                "map",
                                function(____, k) return __get(st.cards, k) end
                            ),
                            1,
                            2
                        )
                        if a.k == b.k then
                            local ____a_967 = a
                            b.done = true
                            ____a_967.done = true
                            st.open = __arrL({}, 0)
                            st.combo = st.combo + 1
                            st.best = math.max(st.best, st.combo)
                            __inc(st.pairs, st.turn, 1, true)
                            __set(
                                st.score,
                                st.turn,
                                __get(st.score, st.turn) + (100 + (st.combo - 1) * 50)
                            )
                            __L1:sfx("pick")
                            local p = self:pos(__call(st.cards, "indexOf", a))
                            local ____call_972 = __call
                            local ____st_pop_971 = st.pop
                            local ____temp_969 = p.x + 26
                            local ____temp_970 = p.y + 10
                            local ____gt_result_968
                            if __gt(st.combo, 1) then
                                ____gt_result_968 = __add("SEQUÊNCIA x", st.combo)
                            else
                                ____gt_result_968 = "PAR!"
                            end
                            ____call_972(____st_pop_971, "push", {x = ____temp_969, y = ____temp_970, s = ____gt_result_968, t = 0})
                        else
                            st.wait = 0.9
                            st.combo = 0
                        end
                    end
                end,
                tap = function(self, st, x, y)
                    do
                        local i = 0
                        while __lt(
                            i,
                            __len(st.cards)
                        ) do
                            local p = self:pos(i)
                            local ____t_978 = __t
                            local ____t_result_977
                            local ____t_976 = __t
                            local ____t_result_975
                            local ____t_974 = __t
                            local ____temp_973 = __ge(x, p.x) and __lt(x, p.x + 52)
                            __O[1168] = ____temp_973
                            if ____t_974(____temp_973) then
                                ____t_result_975 = __ge(y, p.y)
                            else
                                ____t_result_975 = __O[1168]
                            end
                            __O[1169] = ____t_result_975
                            if ____t_976(____t_result_975) then
                                ____t_result_977 = __lt(y, p.y + 50)
                            else
                                ____t_result_977 = __O[1169]
                            end
                            if ____t_978(____t_result_977) then
                                st.cur = i
                                self:flip(st, i)
                                return
                            end
                            i = i + 1
                        end
                    end
                end,
                update = function(self, st, dt)
                    st.time = __add(st.time, dt)
                    for ____, c in __iterar((st.cards)) do
                        c.flip = math.max(0, c.flip - dt * 5)
                    end
                    if __gt(st.wait, 0) then
                        st.wait = st.wait - dt
                        if __le(st.wait, 0) then
                            for ____, i in __iterar((st.open)) do
                                __get(st.cards, i).up = false
                                __get(st.cards, i).flip = 1
                            end
                            st.open = __arrL({}, 0)
                            if st.mode == "duo" then
                                st.turn = __mod(
                                    st.turn + 1,
                                    __L1:NP(st)
                                )
                            end
                        end
                    end
                    local ____get_981 = __get
                    local ____L1_P_980 = __L1.P
                    local ____temp_979
                    if st.mode == "duo" then
                        ____temp_979 = st.turn
                    else
                        ____temp_979 = 0
                    end
                    local p = ____get_981(____L1_P_980, ____temp_979)
                    while __t(__len(p.dirs)) do
                        local d = __call(p.dirs, "shift")
                        local c = __mod(st.cur, 5)
                        local r = math.floor(st.cur / 5)
                        if d == "l" then
                            st.cur = r * 5 + __mod(c + 4, 5)
                        end
                        if d == "r" then
                            st.cur = r * 5 + __mod(c + 1, 5)
                        end
                        if d == "u" then
                            st.cur = __mod(r + 3, 4) * 5 + c
                        end
                        if d == "d" then
                            st.cur = __mod(r + 1, 4) * 5 + c
                        end
                    end
                    __call(
                        __L1.P,
                        "forEach",
                        function(____, q)
                            local ____arrL_result_982 = __arrL({}, 0)
                            q.dirs = ____arrL_result_982
                            return ____arrL_result_982
                        end
                    )
                    if __t(p.ap) then
                        self:flip(st, st.cur)
                    end
                    if __t(__call(
                        st.cards,
                        "every",
                        function(____, c) return c.done end
                    )) then
                        if st.mode == "solo" then
                            local sc = math.max(
                                100,
                                1500 - st.moves * 25 - math.floor(st.time) * 3 + st.best * 50
                            )
                            st["end"](
                                st,
                                {
                                    score = sc,
                                    text = __add(
                                        __add(
                                            __add(st.moves, " jogadas em "),
                                            math.floor(st.time)
                                        ),
                                        " segundos."
                                    )
                                }
                            )
                        else
                            local sc = __call(
                                st.pairs,
                                "slice",
                                0,
                                __L1:NP(st)
                            )
                            local best = math.max(__TS__Spread(__iter(sc)))
                            local ____gt_result_983
                            if __gt(
                                __len(__call(
                                    sc,
                                    "filter",
                                    function(____, v) return v == best end
                                )),
                                1
                            ) then
                                ____gt_result_983 = nil
                            else
                                ____gt_result_983 = __call(sc, "indexOf", best)
                            end
                            local w = ____gt_result_983
                            st["end"](
                                st,
                                {
                                    winner = w,
                                    text = __add(
                                        __call(sc, "join", " · "),
                                        " pares."
                                    )
                                }
                            )
                        end
                        __L1:sfx("win")
                    end
                end,
                drawLow = function(self, g, st)
                    __L1:R(
                        g,
                        0,
                        0,
                        __L1.LW,
                        __L1.LH,
                        "#6a4a2a"
                    )
                    do
                        local y = 0
                        while y < __L1.LH do
                            __L1:R(
                                g,
                                0,
                                y,
                                __L1.LW,
                                1,
                                "#5e4226"
                            )
                            y = y + 6
                        end
                    end
                    __L1:R(
                        g,
                        0,
                        0,
                        __L1.LW,
                        22,
                        "#c84a3a"
                    )
                    do
                        local x = 0
                        while x < __L1.LW do
                            __L1:R(
                                g,
                                x,
                                0,
                                12,
                                22,
                                "#f0e0c0"
                            )
                            x = x + 24
                        end
                    end
                    __L1:R(
                        g,
                        0,
                        22,
                        __L1.LW,
                        3,
                        "#4a3020"
                    )
                    __call(
                        st.cards,
                        "forEach",
                        function(____, c, i)
                            local p = self:pos(i)
                            local on = i == st.cur
                            local ____t_result_986
                            local ____t_985 = __t
                            local ____math_floor_result_984 = math.floor(math.abs(math.cos(c.flip * math.pi / 2)) * 26 + 0.5)
                            __O[1170] = ____math_floor_result_984
                            if ____t_985(____math_floor_result_984) then
                                ____t_result_986 = __O[1170]
                            else
                                ____t_result_986 = 2
                            end
                            local squash = ____t_result_986
                            local cx = p.x + 26
                            if __t(on) then
                                local ____L1_R_989 = __L1.R
                                local ____array_988 = __TS__SparseArrayNew(
                                    g,
                                    p.x - 3,
                                    p.y - 3,
                                    58,
                                    56
                                )
                                local ____temp_987
                                if st.mode == "duo" then
                                    ____temp_987 = __get(__L1.PLAYER_COL, st.turn)
                                else
                                    ____temp_987 = "#fff3a0"
                                end
                                __TS__SparseArrayPush(____array_988, ____temp_987)
                                ____L1_R_989(
                                    __L1,
                                    __TS__SparseArraySpread(____array_988)
                                )
                            end
                            if __t(c.done) then
                                __L1:R(
                                    g,
                                    cx - squash,
                                    p.y,
                                    squash * 2,
                                    50,
                                    "#d8cfa8"
                                )
                                __L1:feiraIcon(g, c.k, cx - 10, p.y + 15)
                                __L1:R(
                                    g,
                                    cx - squash,
                                    p.y,
                                    squash * 2,
                                    50,
                                    "rgba(255,255,255,.18)"
                                )
                                return
                            end
                            if __t(c.up) then
                                __L1:R(
                                    g,
                                    cx - squash,
                                    p.y,
                                    squash * 2,
                                    50,
                                    "#3a2a1a"
                                )
                                __L1:R(
                                    g,
                                    cx - squash + 1,
                                    p.y + 1,
                                    squash * 2 - 2,
                                    48,
                                    "#f4ecd0"
                                )
                                if squash > 18 then
                                    __L1:feiraIcon(g, c.k, cx - 10, p.y + 15)
                                end
                            else
                                __L1:R(
                                    g,
                                    cx - squash,
                                    p.y,
                                    squash * 2,
                                    50,
                                    "#3a2a1a"
                                )
                                __L1:R(
                                    g,
                                    cx - squash + 1,
                                    p.y + 1,
                                    squash * 2 - 2,
                                    48,
                                    "#c8a050"
                                )
                                do
                                    local y = 3
                                    while y < 48 do
                                        __L1:R(
                                            g,
                                            cx - squash + 2,
                                            p.y + y,
                                            squash * 2 - 4,
                                            1,
                                            "#b08840"
                                        )
                                        y = y + 4
                                    end
                                end
                                if squash > 18 then
                                    __L1:R(
                                        g,
                                        cx - 8,
                                        p.y + 19,
                                        16,
                                        12,
                                        "#7a4a2a"
                                    )
                                    __L1:txt(
                                        g,
                                        "DR",
                                        cx,
                                        p.y + 25,
                                        8,
                                        "#f0e0c0",
                                        "center",
                                        nil
                                    )
                                end
                            end
                        end
                    )
                end,
                drawMain = function(self, c, st)
                    if st.mode == "solo" then
                        __L1:txt(
                            c,
                            __add(
                                __add(
                                    __add(
                                        __add(
                                            __add(
                                                __add("JOGADAS ", st.moves),
                                                "   TEMPO "
                                            ),
                                            math.floor(st.time)
                                        ),
                                        "   PARES "
                                    ),
                                    __get(st.pairs, 0)
                                ),
                                "/10"
                            ),
                            __L1.W / 2,
                            520,
                            12
                        )
                    else
                        __L1:scoreBar(
                            c,
                            __call(
                                st.pairs,
                                "slice",
                                0,
                                __L1:NP(st)
                            )
                        )
                        __L1:txt(
                            c,
                            __add(
                                "VEZ DE ",
                                __get(__L1.PLAYER_NAME, st.turn)
                            ),
                            __L1.W / 2,
                            520,
                            13,
                            __get(__L1.PLAYER_COL, st.turn)
                        )
                    end
                end
            },
            "id,name,sub,color,duo,max,medals,rules,rulesDuo,controls,init,pos,flip,tap,update,drawLow,drawMain"
        )
    )
    __call(
        __L1.GAMES,
        "push",
        __ord(
            {
                id = "tiro",
                name = "TIRO AO ALVO NO AÇUDE",
                sub = "Estilingue de papel e muita mira.",
                color = "#e85a4a",
                duo = "versus",
                max = 4,
                medals = __arrL({350, 650, 950}, 3),
                rules = __arrL({"Mire e atire bolinhas de papel em 60 segundos.", "Lata +10, balão +15, pato +20, galinha dourada +50.", "Não acerte a vaca! (-30)"}, 3),
                rulesDuo = __arrL({"Cada um com sua mira, os alvos são os mesmos.", "Quem fizer mais pontos em 60 segundos vence.", "A vaca tira 30 pontos de quem acertar."}, 3),
                controls = __arrL({"Direcional: mover a mira", "A: atirar (ou toque no alvo)"}, 2),
                init = function(self, st)
                    st.time = 60
                    local ____st_992 = st
                    local ____call_991 = __call
                    local ____temp_990
                    if st.mode == "duo" then
                        ____temp_990 = __get(
                            __arrL(
                                {
                                    __arrL({160, 320}, 2),
                                    __arrL({120, 240, 360}, 3),
                                    __arrL({96, 192, 288, 384}, 4)
                                },
                                3
                            ),
                            __L1:NP(st) - 2
                        )
                    else
                        ____temp_990 = __arrL({240}, 1)
                    end
                    ____st_992.aim = ____call_991(
                        ____temp_990,
                        "map",
                        function(____, x) return {x = x, y = 130, cd = 0} end
                    )
                    st.shots = __arrL({}, 0)
                    st.cans = __arrayFrom(
                        {length = 8},
                        function(____, _, i) return {x = 70 + i * 46, up = true, t = 0} end
                    )
                    st.ducks = __arrL({}, 0)
                    st.balloons = __arrL({}, 0)
                    st.chick = nil
                    st.cow = nil
                    st.spawnD = 0
                    st.spawnB = 1
                    st.fx = __arrL({}, 0)
                end,
                shoot = function(self, st, i, x, y)
                    local a = __get(st.aim, i)
                    local ____t_996 = __t
                    local ____t_result_995
                    local ____t_994 = __t
                    local ____temp_993 = not __t(a) or __gt(a.cd, 0)
                    __O[1171] = ____temp_993
                    if ____t_994(____temp_993) then
                        ____t_result_995 = __O[1171]
                    else
                        ____t_result_995 = st.ended
                    end
                    if ____t_996(____t_result_995) then
                        return
                    end
                    a.cd = 0.28
                    local ____call_1000 = __call
                    local ____st_shots_999 = st.shots
                    local ____i_998 = i
                    local ____gt_result_997
                    if __gt(
                        __len(st.aim),
                        1
                    ) then
                        ____gt_result_997 = 60 + i * (360 / (__len(st.aim) - 1))
                    else
                        ____gt_result_997 = 240
                    end
                    ____call_1000(____st_shots_999, "push", {
                        i = ____i_998,
                        sx = ____gt_result_997,
                        x = x,
                        y = y,
                        t = 0
                    })
                    __L1:sfx("bounce")
                end,
                tap = function(self, st, x, y)
                    local a = __get(st.aim, 0)
                    a.x = x
                    a.y = y
                    self:shoot(st, 0, x, y)
                end,
                hit = function(self, st, s)
                    local function add(____, pts, x, y, label)
                        __set(
                            st.score,
                            s.i,
                            math.max(
                                0,
                                __add(
                                    __get(st.score, s.i),
                                    pts
                                )
                            )
                        )
                        local ____call_1006 = __call
                        local ____st_pop_1005 = st.pop
                        local ____x_1003 = x
                        local ____y_1004 = y
                        local ____t_result_1002
                        if __t(label) then
                            ____t_result_1002 = label
                        else
                            local ____gt_result_1001
                            if __gt(pts, 0) then
                                ____gt_result_1001 = __add("+", pts)
                            else
                                ____gt_result_1001 = tostring(pts)
                            end
                            ____t_result_1002 = ____gt_result_1001
                        end
                        ____call_1006(____st_pop_1005, "push", {x = ____x_1003, y = ____y_1004, s = ____t_result_1002, t = 0})
                        __L1:sfx(__gt(pts, 0) and "pick" or "lose")
                        do
                            local k = 0
                            while k < 6 do
                                __call(
                                    st.fx,
                                    "push",
                                    {
                                        x = x,
                                        y = y,
                                        vx = __L1:rnd(-60, 60),
                                        vy = __L1:rnd(-70, 20),
                                        t = 0
                                    }
                                )
                                k = k + 1
                            end
                        end
                    end
                    local ____t_1010 = __t
                    local ____t_result_1009
                    local ____t_1008 = __t
                    local ____t_result_1007
                    if __t(st.chick) then
                        ____t_result_1007 = math.abs(s.x - st.chick.x) < 10
                    else
                        ____t_result_1007 = st.chick
                    end
                    __O[1172] = ____t_result_1007
                    if ____t_1008(____t_result_1007) then
                        ____t_result_1009 = math.abs(s.y - st.chick.y) < 9
                    else
                        ____t_result_1009 = __O[1172]
                    end
                    if ____t_1010(____t_result_1009) then
                        add(nil, 50, st.chick.x, st.chick.y)
                        st.chick = nil
                        return
                    end
                    for ____, b in __iterar((st.balloons)) do
                        local ____t_1014 = __t
                        local ____t_result_1013
                        local ____t_1012 = __t
                        local ____temp_1011 = not __t(b.pop) and math.abs(s.x - b.x) < 8
                        __O[1173] = ____temp_1011
                        if ____t_1012(____temp_1011) then
                            ____t_result_1013 = math.abs(s.y - b.y) < 10
                        else
                            ____t_result_1013 = __O[1173]
                        end
                        if ____t_1014(____t_result_1013) then
                            b.pop = true
                            add(nil, 15, b.x, b.y)
                            return
                        end
                    end
                    for ____, d in __iterar((st.ducks)) do
                        local ____t_1018 = __t
                        local ____t_result_1017
                        local ____t_1016 = __t
                        local ____temp_1015 = not __t(d.down) and math.abs(s.x - d.x) < 10
                        __O[1174] = ____temp_1015
                        if ____t_1016(____temp_1015) then
                            ____t_result_1017 = math.abs(s.y - (d.y - 6)) < 9
                        else
                            ____t_result_1017 = __O[1174]
                        end
                        if ____t_1018(____t_result_1017) then
                            d.down = true
                            add(nil, 20, d.x, d.y - 8)
                            return
                        end
                    end
                    for ____, c in __iterar((st.cans)) do
                        local ____t_1024 = __t
                        local ____t_result_1023
                        local ____t_1022 = __t
                        local ____t_result_1021
                        local ____t_1020 = __t
                        local ____t_result_1019
                        if __t(c.up) then
                            ____t_result_1019 = math.abs(s.x - c.x) < 6
                        else
                            ____t_result_1019 = c.up
                        end
                        __O[1175] = ____t_result_1019
                        if ____t_1020(____t_result_1019) then
                            ____t_result_1021 = __gt(s.y, 100)
                        else
                            ____t_result_1021 = __O[1175]
                        end
                        __O[1176] = ____t_result_1021
                        if ____t_1022(____t_result_1021) then
                            ____t_result_1023 = __lt(s.y, 120)
                        else
                            ____t_result_1023 = __O[1176]
                        end
                        if ____t_1024(____t_result_1023) then
                            c.up = false
                            c.t = 3
                            add(nil, 10, c.x, 104)
                            return
                        end
                    end
                    local ____t_1028 = __t
                    local ____t_result_1027
                    local ____t_1026 = __t
                    local ____t_result_1025
                    if __t(st.cow) then
                        ____t_result_1025 = math.abs(s.x - st.cow.x) < 20
                    else
                        ____t_result_1025 = st.cow
                    end
                    __O[1177] = ____t_result_1025
                    if ____t_1026(____t_result_1025) then
                        ____t_result_1027 = math.abs(s.y - 150) < 14
                    else
                        ____t_result_1027 = __O[1177]
                    end
                    if ____t_1028(____t_result_1027) then
                        add(
                            nil,
                            -30,
                            st.cow.x,
                            140,
                            "MUUU! -30"
                        )
                        st.cow.hit = 0.6
                        return
                    end
                    __L1:sfx("hit")
                end,
                update = function(self, st, dt)
                    st.time = st.time - dt
                    __call(
                        st.aim,
                        "forEach",
                        function(____, a, i)
                            a.x = __L1:clamp(
                                a.x + __get(__L1.P, i).x * 210 * dt,
                                8,
                                __L1.LW - 8
                            )
                            a.y = __L1:clamp(
                                a.y + __get(__L1.P, i).y * 190 * dt,
                                30,
                                240
                            )
                            a.cd = a.cd - dt
                            if __t(__get(__L1.P, i).ap) then
                                self:shoot(st, i, a.x, a.y)
                            end
                        end
                    )
                    for ____, s in __iterar((st.shots)) do
                        s.t = __add(s.t, dt)
                        if __t(__ge(s.t, 0.14) and not __t(s.done)) then
                            s.done = true
                            self:hit(st, s)
                        end
                    end
                    st.shots = __call(
                        st.shots,
                        "filter",
                        function(____, s) return __lt(s.t, 0.2) end
                    )
                    for ____, c in __iterar((st.cans)) do
                        if not __t(c.up) then
                            c.t = c.t - dt
                            if __le(c.t, 0) then
                                c.up = true
                            end
                        end
                    end
                    st.spawnD = st.spawnD - dt
                    if __le(st.spawnD, 0) then
                        st.spawnD = __L1:rnd(1.2, 2.4)
                        local dir = math.random() < 0.5 and 1 or -1
                        __call(
                            st.ducks,
                            "push",
                            {
                                x = dir > 0 and -12 or __L1.LW + 12,
                                y = 206,
                                vx = dir * __L1:rnd(40, 80)
                            }
                        )
                    end
                    st.spawnB = st.spawnB - dt
                    if __le(st.spawnB, 0) then
                        st.spawnB = __L1:rnd(1.5, 3)
                        __call(
                            st.balloons,
                            "push",
                            {
                                x = __L1:rnd(30, __L1.LW - 30),
                                y = 280,
                                vy = __TS__Number(-__L1:rnd(28, 46)),
                                col = __get(
                                    __arrL({"#e84a5a", "#4a8af0", "#f6c445", "#7ab84a"}, 4),
                                    __L1:irnd(0, 3)
                                )
                            }
                        )
                    end
                    if __t(not __t(st.chick) and math.random() < dt * 0.08) then
                        local dir = math.random() < 0.5 and 1 or -1
                        st.chick = {x = dir > 0 and -10 or __L1.LW + 10, y = 44, vx = dir * 150}
                    end
                    if __t(st.chick) then
                        local ____st_chick_1029, ____x_1030 = st.chick, "x"
                        ____st_chick_1029[____x_1030] = ____st_chick_1029[____x_1030] + st.chick.vx * dt
                        if __t(__lt(st.chick.x, -20) or __gt(st.chick.x, __L1.LW + 20)) then
                            st.chick = nil
                        end
                    end
                    if __t(not __t(st.cow) and math.random() < dt * 0.1) then
                        local dir = math.random() < 0.5 and 1 or -1
                        st.cow = {x = dir > 0 and -30 or __L1.LW + 30, vx = dir * 30, hit = 0}
                    end
                    if __t(st.cow) then
                        local ____st_cow_1031, ____x_1032 = st.cow, "x"
                        ____st_cow_1031[____x_1032] = ____st_cow_1031[____x_1032] + st.cow.vx * dt
                        st.cow.hit = math.max(0, st.cow.hit - dt)
                        if __t(__lt(st.cow.x, -40) or __gt(st.cow.x, __L1.LW + 40)) then
                            st.cow = nil
                        end
                    end
                    for ____, d in __iterar((st.ducks)) do
                        if __t(d.down) then
                            d.y = d.y + 40 * dt
                        else
                            d.x = d.x + d.vx * dt
                        end
                    end
                    st.ducks = __call(
                        st.ducks,
                        "filter",
                        function(____, d)
                            local ____t_result_1035
                            local ____t_1034 = __t
                            local ____temp_1033 = __gt(d.x, -20) and __lt(d.x, __L1.LW + 20)
                            __O[1178] = ____temp_1033
                            if ____t_1034(____temp_1033) then
                                ____t_result_1035 = __lt(d.y, 226)
                            else
                                ____t_result_1035 = __O[1178]
                            end
                            return ____t_result_1035
                        end
                    )
                    for ____, b in __iterar((st.balloons)) do
                        b.y = b.y + b.vy * dt
                    end
                    st.balloons = __call(
                        st.balloons,
                        "filter",
                        function(____, b) return not __t(b.pop) and __gt(b.y, -20) end
                    )
                    for ____, f in __iterar((st.fx)) do
                        f.t = __add(f.t, dt)
                        f.x = f.x + f.vx * dt
                        f.y = f.y + f.vy * dt
                        f.vy = f.vy + 200 * dt
                    end
                    st.fx = __call(
                        st.fx,
                        "filter",
                        function(____, f) return __lt(f.t, 0.5) end
                    )
                    if __le(st.time, 0) then
                        st.time = 0
                        if st.mode == "solo" then
                            st["end"](
                                st,
                                {
                                    score = __get(st.score, 0),
                                    text = "Mira de respeito!"
                                }
                            )
                        else
                            local n = __len(st.aim)
                            local sc = __call(st.score, "slice", 0, n)
                            local best = math.max(__TS__Spread(__iter(sc)))
                            local tops = __len(__call(
                                sc,
                                "filter",
                                function(____, v) return v == best end
                            ))
                            local ____gt_result_1036
                            if __gt(tops, 1) then
                                ____gt_result_1036 = nil
                            else
                                ____gt_result_1036 = __call(sc, "indexOf", best)
                            end
                            local w = ____gt_result_1036
                            st["end"](
                                st,
                                {
                                    winner = w,
                                    text = __add(
                                        __call(sc, "join", " · "),
                                        " pontos."
                                    )
                                }
                            )
                        end
                        __L1:sfx("win")
                    end
                end,
                drawLow = function(self, g, st)
                    do
                        local i = 0
                        while i < 9 do
                            __L1:R(
                                g,
                                0,
                                i * 12,
                                __L1.LW,
                                12,
                                __get(
                                    __arrL({
                                        "#7ec0e0",
                                        "#86c4e0",
                                        "#90c8de",
                                        "#9accdc",
                                        "#a6d0d8",
                                        "#b2d2d0",
                                        "#bcd4c8",
                                        "#c4d4bc",
                                        "#c8d0b0"
                                    }, 9),
                                    i
                                )
                            )
                            i = i + 1
                        end
                    end
                    do
                        local x = 0
                        while x < __L1.LW do
                            __L1:R(
                                g,
                                x,
                                96 - math.floor(math.sin(x * 0.02) * 8 + math.sin(x * 0.05) * 4 + 0.5),
                                2,
                                20,
                                "#7aa860"
                            )
                            x = x + 2
                        end
                    end
                    __L1:R(
                        g,
                        0,
                        100,
                        __L1.LW,
                        82,
                        "#8ab868"
                    )
                    __L1:R(
                        g,
                        40,
                        118,
                        400,
                        3,
                        "#7a5a3a"
                    )
                    do
                        local x = 46
                        while x < 440 do
                            __L1:R(
                                g,
                                x,
                                112,
                                4,
                                30,
                                "#6a4a2a"
                            )
                            x = x + 46
                        end
                    end
                    for ____, c in __iterar((st.cans)) do
                        if __t(c.up) then
                            __L1:R(
                                g,
                                c.x - 4,
                                104,
                                8,
                                14,
                                "#c8c8c8"
                            )
                            __L1:R(
                                g,
                                c.x - 4,
                                108,
                                8,
                                5,
                                "#e84a3a"
                            )
                            __L1:R(
                                g,
                                c.x - 4,
                                104,
                                8,
                                1,
                                "#f0f0f0"
                            )
                        end
                    end
                    if __t(st.cow) then
                        local x = st.cow.x
                        local f = __gt(st.cow.vx, 0) and 1 or -1
                        local ____gt_result_1037
                        if __gt(st.cow.hit, 0) then
                            ____gt_result_1037 = math.floor(math.sin(st.t * 60) + 0.5)
                        else
                            ____gt_result_1037 = 0
                        end
                        local sh = ____gt_result_1037
                        __L1:R(
                            g,
                            x - 16 + sh,
                            142,
                            32,
                            14,
                            "#f0f0f0"
                        )
                        __L1:R(
                            g,
                            x - 8 + sh,
                            144,
                            8,
                            6,
                            "#2a2a2a"
                        )
                        __L1:R(
                            g,
                            x + 4 + sh,
                            148,
                            6,
                            5,
                            "#2a2a2a"
                        )
                        __L1:R(
                            g,
                            x + f * 16 - 4 + sh,
                            138,
                            9,
                            10,
                            "#f0f0f0"
                        )
                        __L1:R(
                            g,
                            x + f * 19 - 2 + sh,
                            144,
                            5,
                            4,
                            "#e8a0a0"
                        )
                        for ____, lx in __iterar((__arrL({-13, -6, 6, 12}, 4))) do
                            __L1:R(
                                g,
                                x + lx + sh,
                                156,
                                3,
                                8,
                                "#e0e0e0"
                            )
                        end
                    end
                    __L1:R(
                        g,
                        0,
                        180,
                        __L1.LW,
                        46,
                        "#4a8ab0"
                    )
                    do
                        local i = 0
                        while i < 30 do
                            __L1:R(
                                g,
                                __mod(i * 37 + st.t * 12, 500) - 10,
                                186 + __mod(i, 5) * 8,
                                10,
                                1,
                                "#7ab8d8"
                            )
                            i = i + 1
                        end
                    end
                    __L1:R(
                        g,
                        0,
                        226,
                        __L1.LW,
                        44,
                        "#7a9a4a"
                    )
                    do
                        local x = 0
                        while x < __L1.LW do
                            __L1:R(
                                g,
                                x,
                                224,
                                3,
                                4,
                                "#5a8a3a"
                            )
                            x = x + 9
                        end
                    end
                    for ____, d in __iterar((st.ducks)) do
                        local f = __gt(d.vx, 0) and 1 or -1
                        __L1:R(
                            g,
                            d.x - 7,
                            d.y - 6,
                            14,
                            6,
                            __t(d.down) and "#8a6a3a" or "#e8c040"
                        )
                        __L1:R(
                            g,
                            d.x + f * 4 - 2,
                            d.y - 12,
                            6,
                            6,
                            __t(d.down) and "#8a6a3a" or "#e8c040"
                        )
                        __L1:R(
                            g,
                            d.x + f * 8 - 1,
                            d.y - 10,
                            3,
                            2,
                            "#e8803a"
                        )
                        __L1:R(
                            g,
                            d.x + f * 5 - 1,
                            d.y - 11,
                            1,
                            1,
                            "#1a1a1a"
                        )
                        __L1:R(
                            g,
                            d.x - 1,
                            d.y,
                            2,
                            8,
                            "#6a4a2a"
                        )
                    end
                    for ____, b in __iterar((st.balloons)) do
                        __L1:R(
                            g,
                            b.x - 5,
                            b.y - 7,
                            10,
                            12,
                            b.col
                        )
                        __L1:R(
                            g,
                            b.x - 3,
                            b.y - 5,
                            2,
                            3,
                            "rgba(255,255,255,.6)"
                        )
                        __L1:R(
                            g,
                            b.x,
                            b.y + 5,
                            1,
                            10,
                            "#f0f0f0"
                        )
                    end
                    if __t(st.chick) then
                        local f = __gt(st.chick.vx, 0) and 1 or -1
                        __L1:R(
                            g,
                            st.chick.x - 6,
                            st.chick.y - 4,
                            12,
                            8,
                            "#ffd75a"
                        )
                        __L1:R(
                            g,
                            st.chick.x + f * 5,
                            st.chick.y - 7,
                            5,
                            5,
                            "#ffd75a"
                        )
                        __L1:R(
                            g,
                            st.chick.x + f * 9,
                            st.chick.y - 5,
                            2,
                            2,
                            "#e8803a"
                        )
                        __L1:R(
                            g,
                            st.chick.x - 4,
                            st.chick.y - 6 + math.floor(math.sin(st.t * 30) + 0.5) * 2,
                            6,
                            3,
                            "#fff3a0"
                        )
                    end
                    for ____, f in __iterar((st.fx)) do
                        __L1:R(
                            g,
                            f.x,
                            f.y,
                            2,
                            2,
                            "#f0f0e0"
                        )
                    end
                    for ____, s in __iterar((st.shots)) do
                        local k = math.min(1, s.t / 0.14)
                        local x = s.sx + (s.x - s.sx) * k
                        local y = 270 + (s.y - 270) * k - math.sin(k * math.pi) * 20
                        local r = math.max(1, 4 - k * 3)
                        __L1:R(
                            g,
                            x - r,
                            y - r,
                            r * 2,
                            r * 2,
                            "#fffaf0"
                        )
                    end
                    __call(
                        st.aim,
                        "forEach",
                        function(____, a, i)
                            local ____temp_1038
                            if st.mode == "duo" then
                                ____temp_1038 = __get(__L1.PLAYER_COL, i)
                            else
                                ____temp_1038 = "#ff4a3a"
                            end
                            local col = ____temp_1038
                            __L1:R(
                                g,
                                a.x - 8,
                                a.y,
                                5,
                                1,
                                col
                            )
                            __L1:R(
                                g,
                                a.x + 4,
                                a.y,
                                5,
                                1,
                                col
                            )
                            __L1:R(
                                g,
                                a.x,
                                a.y - 8,
                                1,
                                5,
                                col
                            )
                            __L1:R(
                                g,
                                a.x,
                                a.y + 4,
                                1,
                                5,
                                col
                            )
                            __L1:R(
                                g,
                                a.x - 1,
                                a.y - 1,
                                3,
                                3,
                                __gt(a.cd, 0) and "#8a8a8a" or col
                            )
                        end
                    )
                end,
                drawMain = function(self, c, st)
                    __L1:txt(
                        c,
                        __add(
                            math.ceil(st.time),
                            "s"
                        ),
                        __L1.W / 2,
                        __gt(
                            __len(st.aim),
                            2
                        ) and 44 or 18,
                        16,
                        __lt(st.time, 10) and "#ff8a7a" or "#fff1ca"
                    )
                    if st.mode == "solo" then
                        __L1:txt(
                            c,
                            __add(
                                "PONTOS ",
                                __get(st.score, 0)
                            ),
                            20,
                            18,
                            14,
                            "#fff1ca",
                            "left"
                        )
                    else
                        __L1:scoreBar(
                            c,
                            __call(
                                st.score,
                                "slice",
                                0,
                                __len(st.aim)
                            )
                        )
                    end
                end
            },
            "id,name,sub,color,duo,max,medals,rules,rulesDuo,controls,init,shoot,tap,hit,update,drawLow,drawMain"
        )
    )
    __call(
        __L1.GAMES,
        "push",
        __ord(
            {
                id = "corrida",
                name = "CORRIDA DA ESTRADINHA",
                sub = "Carro a gás, estrada de terra e galinha na pista.",
                color = "#ffbd66",
                duo = "versus",
                medals = __arrL({900, 1800, 2800}, 3),
                rules = __arrL({"Desvie de buracos, galinhas e carroças.", "O turbo (A) gasta gás. Pegue os galões para continuar.", "Acabou o gás, acabou a corrida: vale a distância."}, 3),
                rulesDuo = __arrL({"Cada um na sua estrada, com os mesmos obstáculos.", "Quem chegar primeiro aos 2500 m vence.", "Batida faz perder velocidade. Turbo gasta gás."}, 3),
                controls = __arrL({"Esquerda e direita: dirigir", "A: turbo"}, 2),
                init = function(self, st)
                    local duo = st.mode == "duo"
                    local seed = math.random() * 1000
                    st.goal = 2500
                    local ____st_1041 = st
                    local ____call_1040 = __call
                    local ____t_result_1039
                    if __t(duo) then
                        ____t_result_1039 = __arrL(
                            {
                                __arrL({16, 216}, 2),
                                __arrL({248, 216}, 2)
                            },
                            2
                        )
                    else
                        ____t_result_1039 = __arrL(
                            {__arrL({110, 260}, 2)},
                            1
                        )
                    end
                    ____st_1041.roads = ____call_1040(
                        ____t_result_1039,
                        "map",
                        function(____, ____bindingPattern0, i)
                            local w
                            local x0
                            x0 = ____bindingPattern0[1]
                            w = ____bindingPattern0[2]
                            return {
                                i = i,
                                x0 = x0,
                                w = w,
                                car = x0 + w / 2,
                                dist = 0,
                                speed = 110,
                                gas = 100,
                                crash = 0,
                                objs = __arrL({}, 0),
                                next = 120,
                                n = 0,
                                seed = seed,
                                done = false
                            }
                        end
                    )
                end,
                rng = function(self, r)
                    r.n = r.n + 1
                    return __L1:hash(r.seed + r.n * 1.37)
                end,
                update = function(self, st, dt)
                    for ____, r in __iterar((st.roads)) do
                        do
                            if __t(r.done) then
                                continue
                            end
                            local p = __get(__L1.P, r.i)
                            local ____t_result_1044
                            local ____t_1043 = __t
                            local ____t_result_1042
                            if __t(p.a) then
                                ____t_result_1042 = __gt(r.gas, 0)
                            else
                                ____t_result_1042 = p.a
                            end
                            __O[1179] = ____t_result_1042
                            if ____t_1043(____t_result_1042) then
                                ____t_result_1044 = __le(r.crash, 0)
                            else
                                ____t_result_1044 = __O[1179]
                            end
                            local turbo = ____t_result_1044
                            local target = __gt(r.crash, 0) and 40 or (__t(turbo) and 230 or 140 + math.min(40, r.dist / 400))
                            r.speed = r.speed + (target - r.speed) * math.min(1, dt * 2.5)
                            r.crash = math.max(0, r.crash - dt)
                            local ____temp_1046 = r.gas - dt * (st.mode == "solo" and 2.4 or 1.2)
                            local ____t_result_1045
                            if __t(turbo) then
                                ____t_result_1045 = dt * 14
                            else
                                ____t_result_1045 = 0
                            end
                            r.gas = math.max(0, ____temp_1046 - ____t_result_1045)
                            r.car = __L1:clamp(
                                r.car + p.x * 150 * dt,
                                r.x0 + 14,
                                __add(r.x0, r.w) - 14
                            )
                            r.dist = r.dist + r.speed * dt
                            while __lt(r.next, r.dist + 300) do
                                local k = self:rng(r)
                                local lane = r.x0 + 18 + self:rng(r) * (r.w - 36)
                                __call(
                                    r.objs,
                                    "push",
                                    {
                                        d = r.next,
                                        x = lane,
                                        kind = __lt(k, 0.3) and "buraco" or (__lt(k, 0.52) and "galinha" or (__lt(k, 0.7) and "carroca" or (__lt(k, 0.86) and "cone" or "gas"))),
                                        vx = __lt(
                                            self:rng(r),
                                            0.5
                                        ) and 40 or -40
                                    }
                                )
                                r.next = r.next + (70 + self:rng(r) * 90 - math.min(40, r.dist / 200))
                            end
                            for ____, o in __iterar((r.objs)) do
                                do
                                    if __t(o.got) then
                                        continue
                                    end
                                    if o.kind == "galinha" then
                                        do
                                            o.x = __L1:clamp(
                                                o.x + o.vx * dt,
                                                r.x0 + 8,
                                                __add(r.x0, r.w) - 8
                                            )
                                            local ____t_result_1050
                                            local ____t_1048 = __t
                                            local ____temp_1047 = __le(o.x, r.x0 + 8) or __ge(
                                                o.x,
                                                __add(r.x0, r.w) - 8
                                            )
                                            __O[1180] = ____temp_1047
                                            if ____t_1048(____temp_1047) then
                                                local ____TS__Number_result_1049 = __TS__Number(-o.vx)
                                                o.vx = ____TS__Number_result_1049
                                                ____t_result_1050 = ____TS__Number_result_1049
                                            else
                                                ____t_result_1050 = __O[1180]
                                            end
                                        end
                                    end
                                    if o.kind == "carroca" then
                                        o.d = o.d + 45 * dt
                                    end
                                    local dy = o.d - r.dist
                                    local hw = o.kind == "carroca" and 14 or (o.kind == "buraco" and 10 or 8)
                                    if __t(math.abs(dy) < 14 and math.abs(o.x - r.car) < hw + 6) then
                                        o.got = true
                                        if o.kind == "gas" then
                                            r.gas = math.min(100, r.gas + 30)
                                            __L1:sfx("power")
                                            __call(st.pop, "push", {x = r.car, y = 200, s = "+GÁS", t = 0})
                                        else
                                            r.crash = o.kind == "buraco" and 0.5 or (o.kind == "cone" and 0.4 or 0.9)
                                            __L1:sfx("hit")
                                            st.shake = 0.2
                                            __call(st.pop, "push", {x = r.car, y = 200, s = o.kind == "galinha" and "CÓÓ!" or (o.kind == "buraco" and "TUNC!" or "POW!"), t = 0})
                                        end
                                    end
                                end
                            end
                            r.objs = __call(
                                r.objs,
                                "filter",
                                function(____, o) return __gt(o.d, r.dist - 40) end
                            )
                            if __t(st.mode == "duo" and __ge(r.dist, st.goal)) then
                                r.done = true
                                st["end"](
                                    st,
                                    {
                                        winner = r.i,
                                        text = __add(
                                            __get(__L1.PLAYER_NAME, r.i),
                                            " cruzou a linha de chegada!"
                                        )
                                    }
                                )
                                __L1:sfx("win")
                            end
                            if __t(__le(r.gas, 0) and __lt(r.speed, 45)) then
                                if st.mode == "solo" then
                                    st["end"](
                                        st,
                                        {
                                            score = math.floor(r.dist / 10) * 1,
                                            text = __add(
                                                __add(
                                                    "O gás acabou em ",
                                                    math.floor(r.dist / 10)
                                                ),
                                                " m."
                                            )
                                        }
                                    )
                                    __L1:sfx("lose")
                                else
                                    r.gas = 6
                                    r.crash = 0.8
                                end
                            end
                        end
                    end
                end,
                drawLow = function(self, g, st)
                    __L1:R(
                        g,
                        0,
                        0,
                        __L1.LW,
                        __L1.LH,
                        "#6a9a4a"
                    )
                    for ____, r in __iterar((st.roads)) do
                        g:save()
                        g:beginPath()
                        g:rect(r.x0 - 10, 0, r.w + 20, __L1.LH)
                        g:clip()
                        __L1:R(
                            g,
                            r.x0 - 10,
                            0,
                            r.w + 20,
                            __L1.LH,
                            "#5a8a3a"
                        )
                        do
                            local i = 0
                            while i < 16 do
                                local y = __mod(i * 37 + r.dist, 300) - 20
                                __L1:R(
                                    g,
                                    r.x0 - 8,
                                    y,
                                    4,
                                    6,
                                    "#3f7a3a"
                                )
                                __L1:R(
                                    g,
                                    __add(r.x0, r.w) + 4,
                                    __mod(y + 140, 300) - 20,
                                    4,
                                    6,
                                    "#3f7a3a"
                                )
                                i = i + 1
                            end
                        end
                        __L1:R(
                            g,
                            r.x0,
                            0,
                            r.w,
                            __L1.LH,
                            "#b8946a"
                        )
                        __L1:R(
                            g,
                            r.x0,
                            0,
                            2,
                            __L1.LH,
                            "#8a6a4a"
                        )
                        __L1:R(
                            g,
                            __add(r.x0, r.w) - 2,
                            0,
                            2,
                            __L1.LH,
                            "#8a6a4a"
                        )
                        do
                            local y = -20
                            while y < __L1.LH + 20 do
                                __L1:R(
                                    g,
                                    r.x0 + r.w / 2 - 1,
                                    __mod(y + r.dist, 288) - 10,
                                    2,
                                    10,
                                    "#d8c09a"
                                )
                                y = y + 24
                            end
                        end
                        if st.mode == "duo" then
                            local fy = 220 - (st.goal - r.dist)
                            if __t(fy > -10 and fy < __L1.LH) then
                                do
                                    local x = 0
                                    while __lt(x, r.w) do
                                        __L1:R(
                                            g,
                                            r.x0 + x,
                                            fy,
                                            8,
                                            4,
                                            __t(__mod(x / 8, 2)) and "#fff" or "#1a1a1a"
                                        )
                                        __L1:R(
                                            g,
                                            r.x0 + x,
                                            fy + 4,
                                            8,
                                            4,
                                            __t(__mod(x / 8, 2)) and "#1a1a1a" or "#fff"
                                        )
                                        x = x + 8
                                    end
                                end
                            end
                        end
                        for ____, o in __iterar((r.objs)) do
                            do
                                if __t(o.got) then
                                    continue
                                end
                                local y = 220 - (o.d - r.dist)
                                if __t(y < -20 or y > __L1.LH + 20) then
                                    continue
                                end
                                if o.kind == "buraco" then
                                    __L1:R(
                                        g,
                                        o.x - 9,
                                        y - 5,
                                        18,
                                        10,
                                        "#6a4a2a"
                                    )
                                    __L1:R(
                                        g,
                                        o.x - 7,
                                        y - 3,
                                        14,
                                        6,
                                        "#4a3020"
                                    )
                                elseif o.kind == "galinha" then
                                    __L1:R(
                                        g,
                                        o.x - 5,
                                        y - 4,
                                        10,
                                        8,
                                        "#f4f0e0"
                                    )
                                    __L1:R(
                                        g,
                                        o.x + (__gt(o.vx, 0) and 3 or -6),
                                        y - 7,
                                        4,
                                        4,
                                        "#f4f0e0"
                                    )
                                    __L1:R(
                                        g,
                                        o.x + (__gt(o.vx, 0) and 4 or -5),
                                        y - 9,
                                        2,
                                        2,
                                        "#e83a3a"
                                    )
                                elseif o.kind == "carroca" then
                                    __L1:R(
                                        g,
                                        o.x - 12,
                                        y - 14,
                                        24,
                                        26,
                                        "#8a5a2a"
                                    )
                                    __L1:R(
                                        g,
                                        o.x - 10,
                                        y - 12,
                                        20,
                                        22,
                                        "#b07a3a"
                                    )
                                    __L1:R(
                                        g,
                                        o.x - 14,
                                        y - 10,
                                        3,
                                        8,
                                        "#2a2a2a"
                                    )
                                    __L1:R(
                                        g,
                                        o.x + 11,
                                        y - 10,
                                        3,
                                        8,
                                        "#2a2a2a"
                                    )
                                    __L1:R(
                                        g,
                                        o.x - 3,
                                        y - 26,
                                        6,
                                        12,
                                        "#7a5a3a"
                                    )
                                elseif o.kind == "cone" then
                                    __L1:R(
                                        g,
                                        o.x - 4,
                                        y - 2,
                                        8,
                                        6,
                                        "#e8823a"
                                    )
                                    __L1:R(
                                        g,
                                        o.x - 2,
                                        y - 8,
                                        4,
                                        6,
                                        "#e8823a"
                                    )
                                    __L1:R(
                                        g,
                                        o.x - 3,
                                        y - 4,
                                        6,
                                        1,
                                        "#fff"
                                    )
                                else
                                    __L1:R(
                                        g,
                                        o.x - 5,
                                        y - 7,
                                        10,
                                        12,
                                        "#d03a3a"
                                    )
                                    __L1:R(
                                        g,
                                        o.x - 2,
                                        y - 9,
                                        4,
                                        2,
                                        "#2a2a2a"
                                    )
                                    __L1:R(
                                        g,
                                        o.x - 3,
                                        y - 3,
                                        6,
                                        3,
                                        "#ffd75a"
                                    )
                                end
                            end
                        end
                        local cx = r.car
                        local cy = 220
                        local ____gt_result_1051
                        if __gt(r.crash, 0) then
                            ____gt_result_1051 = math.floor(math.sin(st.t * 50) * 2 + 0.5)
                        else
                            ____gt_result_1051 = 0
                        end
                        local sh = ____gt_result_1051
                        local col = __get(__L1.PLAYER_COL, r.i)
                        __L1:R(
                            g,
                            cx - 8 + sh,
                            cy - 12,
                            16,
                            26,
                            "#2a2a2a"
                        )
                        __L1:R(
                            g,
                            cx - 7 + sh,
                            cy - 11,
                            14,
                            24,
                            col
                        )
                        __L1:R(
                            g,
                            cx - 5 + sh,
                            cy - 7,
                            10,
                            6,
                            "#bfe0f0"
                        )
                        __L1:R(
                            g,
                            cx - 5 + sh,
                            cy + 6,
                            10,
                            4,
                            "#1a1a1a"
                        )
                        __L1:R(
                            g,
                            cx - 9 + sh,
                            cy - 9,
                            2,
                            6,
                            "#1a1a1a"
                        )
                        __L1:R(
                            g,
                            cx + 7 + sh,
                            cy - 9,
                            2,
                            6,
                            "#1a1a1a"
                        )
                        __L1:R(
                            g,
                            cx - 9 + sh,
                            cy + 5,
                            2,
                            6,
                            "#1a1a1a"
                        )
                        __L1:R(
                            g,
                            cx + 7 + sh,
                            cy + 5,
                            2,
                            6,
                            "#1a1a1a"
                        )
                        local ____t_1055 = __t
                        local ____t_result_1054
                        local ____t_1053 = __t
                        local ____get_result_a_1052 = __get(__L1.P, r.i).a
                        __O[1181] = ____get_result_a_1052
                        if ____t_1053(____get_result_a_1052) then
                            ____t_result_1054 = __gt(r.gas, 0)
                        else
                            ____t_result_1054 = __O[1181]
                        end
                        if ____t_1055(____t_result_1054) then
                            do
                                local k = 0
                                while k < 3 do
                                    __L1:R(
                                        g,
                                        cx - 3 + k * 2 + sh,
                                        cy + 14 + __mod(st.t * 40 + k * 4, 8),
                                        2,
                                        3,
                                        __t(__mod(k, 2)) and "#ffd75a" or "#ff8a3a"
                                    )
                                    k = k + 1
                                end
                            end
                        end
                        g:restore()
                    end
                end,
                drawMain = function(self, c, st)
                    __call(
                        st.roads,
                        "forEach",
                        function(____, r)
                            local cx = (r.x0 + r.w / 2) * 2
                            local ____L1_txt_1059 = __L1.txt
                            local ____c_1057 = c
                            local ____add_result_1058 = __add(
                                math.floor(r.dist / 10),
                                " m"
                            )
                            local ____temp_1056
                            if st.mode == "duo" then
                                ____temp_1056 = __get(__L1.PLAYER_COL, r.i)
                            else
                                ____temp_1056 = "#fff1ca"
                            end
                            ____L1_txt_1059(
                                __L1,
                                ____c_1057,
                                ____add_result_1058,
                                cx,
                                18,
                                14,
                                ____temp_1056
                            )
                            local gx = r.x0 * 2 + 16
                            local gw = r.w * 2 - 32
                            __L1:R(
                                c,
                                gx,
                                34,
                                gw,
                                10,
                                "#1a1a1a"
                            )
                            __L1:R(
                                c,
                                gx + 2,
                                36,
                                math.max(0, (gw - 4) * r.gas / 100),
                                6,
                                __lt(r.gas, 25) and "#e84a3a" or "#7af07a"
                            )
                            __L1:txt(
                                c,
                                "GÁS",
                                gx + 4,
                                54,
                                9,
                                "#e8d8b0",
                                "left",
                                nil
                            )
                            if st.mode == "duo" then
                                local k = math.min(1, r.dist / st.goal)
                                __L1:R(
                                    c,
                                    gx,
                                    64,
                                    gw,
                                    4,
                                    "#3a3a3a"
                                )
                                __L1:R(
                                    c,
                                    gx,
                                    64,
                                    gw * k,
                                    4,
                                    __get(__L1.PLAYER_COL, r.i)
                                )
                            end
                        end
                    )
                end
            },
            "id,name,sub,color,duo,medals,rules,rulesDuo,controls,init,rng,update,drawLow,drawMain"
        )
    )
    __call(
        __L1.GAMES,
        "push",
        __ord(
            {
                id = "subida",
                name = "SUBIDA DO MORRO",
                sub = "Pula de laje em laje antes da lama subir.",
                color = "#8ad070",
                duo = "coop",
                max = 4,
                medals = __arrL({250, 600, 1100}, 3),
                rules = __arrL({"Pule de laje em laje subindo o morro.", "Telha rachada quebra logo depois que você pisa. Varal anda!", "A lama sobe cada vez mais rápido. Pegue papéis (+20)."}, 3),
                rulesDuo = __arrL({"Subam juntos. A câmera segue quem estiver mais alto.", "Quem cair volta ao lado do parceiro (4 vidas em comum).", "A altura e os papéis dos dois somam."}, 3),
                controls = __arrL({"Esquerda e direita: andar", "A: pular"}, 2),
                init = function(self, st)
                    st.items = __arrL({}, 0)
                    st.plats = __arrL({{x = 0, y = 250, w = __L1.LW, kind = "chao"}}, 1)
                    st.top = 250
                    while __gt(st.top, -400) do
                        self:addPlat(st)
                    end
                    st.cam = 0
                    st.mud = 330
                    st.mudV = 6
                    st.lives = st.mode == "duo" and 4 or 3
                    st.best = 0
                    st.papers = 0
                    local ____st_1061 = st
                    local ____temp_1060
                    if st.mode == "duo" then
                        ____temp_1060 = __L1:NP(st) + 2
                    else
                        ____temp_1060 = 3
                    end
                    ____st_1061.lives = ____temp_1060
                    local ____st_1064 = st
                    local ____call_1063 = __call
                    local ____temp_1062
                    if st.mode == "duo" then
                        ____temp_1062 = __get(
                            __arrL(
                                {
                                    __arrL({200, 280}, 2),
                                    __arrL({180, 240, 300}, 3),
                                    __arrL({160, 220, 260, 320}, 4)
                                },
                                3
                            ),
                            __L1:NP(st) - 2
                        )
                    else
                        ____temp_1062 = __arrL({240}, 1)
                    end
                    ____st_1064.pl = ____call_1063(
                        ____temp_1062,
                        "map",
                        function(____, x, i) return {
                            i = i,
                            x = x,
                            y = 250,
                            vx = 0,
                            vy = 0,
                            ground = true,
                            face = 1,
                            out = 0,
                            inv = 0
                        } end
                    )
                end,
                addPlat = function(self, st)
                    st.top = st.top - __L1:rnd(34, 50)
                    local w = __L1:rnd(38, 70)
                    local kind = math.random() < 0.14 and "varal" or (math.random() < 0.18 and "telha" or "laje")
                    local ____call_1071 = __call
                    local ____st_plats_1070 = st.plats
                    local ____temp_1066 = __L1:rnd(10, __L1.LW - 10 - w)
                    local ____st_top_1067 = st.top
                    local ____w_1068 = w
                    local ____kind_1069 = kind
                    local ____temp_1065
                    if kind == "varal" then
                        ____temp_1065 = math.random() < 0.5 and 40 or -40
                    else
                        ____temp_1065 = 0
                    end
                    ____call_1071(____st_plats_1070, "push", {
                        x = ____temp_1066,
                        y = ____st_top_1067,
                        w = ____w_1068,
                        kind = ____kind_1069,
                        vx = ____temp_1065,
                        crack = 0
                    })
                    if math.random() < 0.3 then
                        __call(
                            st.items,
                            "push",
                            {
                                x = __L1:rnd(20, __L1.LW - 20),
                                y = st.top - 18
                            }
                        )
                    end
                end,
                update = function(self, st, dt)
                    for ____, pl in __iterar((st.plats)) do
                        if pl.kind == "varal" then
                            pl.x = pl.x + pl.vx * dt
                            if __t(__lt(pl.x, 6) or __gt(
                                __add(pl.x, pl.w),
                                __L1.LW - 6
                            )) then
                                pl.vx = __TS__Number(-pl.vx)
                            end
                        end
                        if __gt(pl.crack, 0) then
                            pl.crack = __add(pl.crack, dt)
                            if __gt(pl.crack, 0.55) then
                                pl.gone = true
                            end
                        end
                    end
                    st.plats = __call(
                        st.plats,
                        "filter",
                        function(____, p) return not __t(p.gone) and __lt(p.y, st.cam + 300) end
                    )
                    while __gt(st.top, st.cam - 300) do
                        self:addPlat(st)
                    end
                    __call(
                        st.pl,
                        "forEach",
                        function(____, p)
                            if __gt(p.out, 0) then
                                p.out = p.out - dt
                                if __le(p.out, 0) then
                                    local mate = __call(
                                        st.pl,
                                        "find",
                                        function(____, q) return q ~= p and __le(q.out, 0) end
                                    )
                                    local best = __get(
                                        __call(
                                            __call(
                                                st.plats,
                                                "filter",
                                                function(____, q)
                                                    local ____t_result_1074
                                                    local ____t_1073 = __t
                                                    local ____temp_1072 = __gt(q.y, st.cam + 20) and __lt(q.y, st.cam + 200)
                                                    __O[1182] = ____temp_1072
                                                    if ____t_1073(____temp_1072) then
                                                        ____t_result_1074 = q.kind ~= "telha"
                                                    else
                                                        ____t_result_1074 = __O[1182]
                                                    end
                                                    return ____t_result_1074
                                                end
                                            ),
                                            "sort",
                                            function(____, a, b) return a.y - b.y end
                                        ),
                                        0
                                    )
                                    local ____p_1077 = p
                                    local ____t_result_1076
                                    if __t(mate) then
                                        ____t_result_1076 = mate.x
                                    else
                                        local ____t_result_1075
                                        if __t(best) then
                                            ____t_result_1075 = best.x + best.w / 2
                                        else
                                            ____t_result_1075 = 240
                                        end
                                        ____t_result_1076 = ____t_result_1075
                                    end
                                    ____p_1077.x = ____t_result_1076
                                    local ____p_1080 = p
                                    local ____t_result_1079
                                    if __t(mate) then
                                        ____t_result_1079 = mate.y
                                    else
                                        local ____t_result_1078
                                        if __t(best) then
                                            ____t_result_1078 = best.y
                                        else
                                            ____t_result_1078 = st.cam + 100
                                        end
                                        ____t_result_1079 = ____t_result_1078
                                    end
                                    ____p_1080.y = ____t_result_1079 - 2
                                    p.vy = 0
                                    p.inv = 1.5
                                end
                                return
                            end
                            local c = __get(__L1.P, p.i)
                            p.vx = c.x * 130
                            if __t(c.x) then
                                p.face = c.x
                            end
                            p.x = __L1:clamp(p.x + p.vx * dt, 8, __L1.LW - 8)
                            p.inv = math.max(0, p.inv - dt)
                            local ____t_1082 = __t
                            local ____t_result_1081
                            if __t(p.ground) then
                                ____t_result_1081 = c.ap
                            else
                                ____t_result_1081 = p.ground
                            end
                            if ____t_1082(____t_result_1081) then
                                p.vy = -285
                                p.ground = false
                                __L1:sfx("bounce")
                            end
                            local oy = p.y
                            p.vy = p.vy + 760 * dt
                            p.y = p.y + p.vy * dt
                            p.ground = false
                            if __ge(p.vy, 0) then
                                for ____, pl in __iterar((st.plats)) do
                                    local ____t_1088 = __t
                                    local ____t_result_1087
                                    local ____t_1086 = __t
                                    local ____t_result_1085
                                    local ____t_1084 = __t
                                    local ____temp_1083 = __gt(p.x, pl.x - 4) and __lt(
                                        p.x,
                                        __add(pl.x, pl.w) + 4
                                    )
                                    __O[1183] = ____temp_1083
                                    if ____t_1084(____temp_1083) then
                                        ____t_result_1085 = __le(oy, pl.y + 2)
                                    else
                                        ____t_result_1085 = __O[1183]
                                    end
                                    __O[1184] = ____t_result_1085
                                    if ____t_1086(____t_result_1085) then
                                        ____t_result_1087 = __ge(p.y, pl.y)
                                    else
                                        ____t_result_1087 = __O[1184]
                                    end
                                    if ____t_1088(____t_result_1087) then
                                        p.y = pl.y
                                        p.vy = 0
                                        p.ground = true
                                        if __t(pl.kind == "telha" and not __t(pl.crack)) then
                                            pl.crack = 0.01
                                            __L1:sfx("break")
                                        end
                                        if pl.kind == "varal" then
                                            p.x = p.x + pl.vx * dt
                                        end
                                    end
                                end
                            end
                            for ____, it in __iterar((st.items)) do
                                local ____t_1092 = __t
                                local ____t_result_1091
                                local ____t_1090 = __t
                                local ____temp_1089 = not __t(it.got) and math.abs(it.x - p.x) < 10
                                __O[1185] = ____temp_1089
                                if ____t_1090(____temp_1089) then
                                    ____t_result_1091 = math.abs(it.y - (p.y - 16)) < 16
                                else
                                    ____t_result_1091 = __O[1185]
                                end
                                if ____t_1092(____t_result_1091) then
                                    it.got = true
                                    st.papers = st.papers + 1
                                    __set(
                                        st.score,
                                        0,
                                        __get(st.score, 0) + 20
                                    )
                                    __L1:sfx("pick")
                                    __call(st.pop, "push", {x = it.x, y = it.y, s = "+20", t = 0})
                                end
                            end
                            if __t(__gt(p.y, st.mud - 2) or __gt(p.y, st.cam + 290)) then
                                if __t(__gt(p.inv, 0) and __lt(p.y, st.mud)) then
                                    return
                                end
                                st.lives = st.lives - 1
                                __L1:sfx("lose")
                                st.shake = 0.3
                                p.out = 1.2
                            end
                            st.best = math.max(
                                st.best,
                                math.floor((250 - p.y) / 10 + 0.5)
                            )
                        end
                    )
                    local alive = __call(
                        st.pl,
                        "filter",
                        function(____, p) return __le(p.out, 0) end
                    )
                    local ____t_result_1093
                    if __t(__len(alive)) then
                        ____t_result_1093 = math.min(__TS__Spread(__iter(__call(
                            alive,
                            "map",
                            function(____, p) return p.y end
                        ))))
                    else
                        ____t_result_1093 = nil
                    end
                    local high = ____t_result_1093
                    if high ~= nil then
                        local want = math.min(st.cam, high - 130)
                        st.cam = st.cam + (want - st.cam) * math.min(1, dt * 3)
                    end
                    st.mudV = st.mudV + dt * 0.35
                    st.mud = math.min(st.mud - st.mudV * dt, st.cam + 330)
                    st.items = __call(
                        st.items,
                        "filter",
                        function(____, it) return not __t(it.got) and __lt(it.y, st.cam + 300) end
                    )
                    if __le(st.lives, 0) then
                        st["end"](
                            st,
                            {
                                score = st.best * 2 + st.papers * 20,
                                text = __add(
                                    __add(
                                        __add(
                                            __add("Subiu ", st.best),
                                            " m e pegou "
                                        ),
                                        st.papers
                                    ),
                                    " papéis."
                                )
                            }
                        )
                    end
                end,
                drawLow = function(self, g, st)
                    local sky = math.max(
                        0,
                        math.min(
                            1,
                            __TS__Number(-st.cam) / 3000
                        )
                    )
                    do
                        local i = 0
                        while i < 9 do
                            __L1:R(
                                g,
                                0,
                                i * 30,
                                __L1.LW,
                                30,
                                ((((("rgb(" .. tostring(math.floor(140 - sky * 100 + i * 6 + 0.5))) .. ",") .. tostring(math.floor(196 - sky * 120 + i * 4 + 0.5))) .. ",") .. tostring(math.floor(225 - sky * 90 + 0.5))) .. ")"
                            )
                            i = i + 1
                        end
                    end
                    do
                        local i = 0
                        while i < 8 do
                            local y = __mod(i * 70 - st.cam * 0.3, 560) - 40
                            local x = __bor(
                                __L1:hash(i) * 400,
                                0
                            )
                            __L1:R(
                                g,
                                x,
                                y,
                                70,
                                60,
                                __get(
                                    __arrL({
                                        "#d4a06d",
                                        "#bf7956",
                                        "#c48b70",
                                        "#d98a8a",
                                        "#a8b29b"
                                    }, 5),
                                    __mod(i, 5)
                                )
                            )
                            __L1:R(
                                g,
                                x + 10,
                                y + 12,
                                10,
                                10,
                                "#5a7a8a"
                            )
                            __L1:R(
                                g,
                                x + 40,
                                y + 12,
                                10,
                                10,
                                "#5a7a8a"
                            )
                            i = i + 1
                        end
                    end
                    g:save()
                    g:translate(
                        0,
                        -math.floor(st.cam + 0.5)
                    )
                    for ____, pl in __iterar((st.plats)) do
                        do
                            local ____t_result_1094
                            if __t(pl.crack) then
                                ____t_result_1094 = math.floor(math.sin(st.t * 60) + 0.5)
                            else
                                ____t_result_1094 = 0
                            end
                            local sh = ____t_result_1094
                            if pl.kind == "chao" then
                                __L1:R(
                                    g,
                                    0,
                                    pl.y,
                                    __L1.LW,
                                    40,
                                    "#7a5a3a"
                                )
                                continue
                            end
                            if pl.kind == "laje" then
                                __L1:R(
                                    g,
                                    pl.x,
                                    pl.y,
                                    pl.w,
                                    6,
                                    "#9a9a8a"
                                )
                                __L1:R(
                                    g,
                                    pl.x,
                                    pl.y,
                                    pl.w,
                                    2,
                                    "#c8c8b8"
                                )
                                __L1:R(
                                    g,
                                    pl.x + 3,
                                    pl.y + 6,
                                    3,
                                    8,
                                    "#7a7a6a"
                                )
                                __L1:R(
                                    g,
                                    __add(pl.x, pl.w) - 6,
                                    pl.y + 6,
                                    3,
                                    8,
                                    "#7a7a6a"
                                )
                            elseif pl.kind == "telha" then
                                do
                                    local x = 0
                                    while __lt(x, pl.w) do
                                        __L1:R(
                                            g,
                                            pl.x + x + sh,
                                            pl.y + (__t(__mod(x, 12)) and 1 or 0),
                                            6,
                                            5,
                                            "#c8603a"
                                        )
                                        x = x + 6
                                    end
                                end
                                if __t(pl.crack) then
                                    __L1:R(
                                        g,
                                        pl.x + pl.w / 2 + sh,
                                        pl.y,
                                        1,
                                        5,
                                        "#2a1a10"
                                    )
                                end
                            else
                                __L1:R(
                                    g,
                                    pl.x,
                                    pl.y,
                                    pl.w,
                                    2,
                                    "#e8e0d0"
                                )
                                do
                                    local x = 4
                                    while x < pl.w - 4 do
                                        __L1:R(
                                            g,
                                            pl.x + x,
                                            pl.y + 2,
                                            7,
                                            8,
                                            __get(
                                                __arrL({"#e86a8a", "#7ad1ff", "#ffd75a", "#8ad070"}, 4),
                                                __mod(
                                                    __bor(x / 10, 0),
                                                    4
                                                )
                                            )
                                        )
                                        x = x + 10
                                    end
                                end
                            end
                        end
                    end
                    for ____, it in __iterar((st.items)) do
                        __L1:R(
                            g,
                            it.x - 3,
                            it.y - 3,
                            6,
                            6,
                            "#fffaf0"
                        )
                        __L1:R(
                            g,
                            it.x - 1,
                            it.y - 1,
                            2,
                            1,
                            "#a8a490"
                        )
                    end
                    g:restore()
                    local my = math.floor(st.mud - st.cam + 0.5)
                    if my < __L1.LH then
                        __L1:R(
                            g,
                            0,
                            my,
                            __L1.LW,
                            __L1.LH - my,
                            "#5a3a22"
                        )
                        do
                            local x = 0
                            while x < __L1.LW do
                                __L1:R(
                                    g,
                                    x,
                                    my - math.floor(math.abs(math.sin(x * 0.2 + st.t * 3)) * 3 + 0.5),
                                    6,
                                    3,
                                    "#6a4a2a"
                                )
                                x = x + 6
                            end
                        end
                    end
                end,
                drawMain = function(self, c, st)
                    __call(
                        st.pl,
                        "forEach",
                        function(____, p)
                            local ____t_1101 = __t
                            local ____t_result_1100
                            local ____t_1096 = __t
                            local ____gt_result_1095 = __gt(p.out, 0)
                            __O[1187] = ____gt_result_1095
                            if ____t_1096(____gt_result_1095) then
                                ____t_result_1100 = __O[1187]
                            else
                                local ____t_result_1099
                                local ____t_1098 = __t
                                local ____gt_result_1097 = __gt(p.inv, 0)
                                __O[1186] = ____gt_result_1097
                                if ____t_1098(____gt_result_1097) then
                                    ____t_result_1099 = __mod(
                                        math.floor(st.t * 14),
                                        2
                                    )
                                else
                                    ____t_result_1099 = __O[1186]
                                end
                                ____t_result_1100 = ____t_result_1099
                            end
                            if ____t_1101(____t_result_1100) then
                                return
                            end
                            __L1:hero(
                                c,
                                __get(__L1.PLAYER_TYPES, p.i),
                                p.x * 2,
                                (p.y - st.cam) * 2,
                                {
                                    facing = p.face,
                                    moving = math.abs(p.vx) > 5,
                                    frame = st.t * 1.5,
                                    grounded = p.ground,
                                    vy = p.vy,
                                    scale = 0.8
                                }
                            )
                        end
                    )
                    __L1:txt(
                        c,
                        __add(st.best, " m"),
                        __L1.W / 2,
                        18,
                        16
                    )
                    __L1:txt(
                        c,
                        __call(
                            "♥",
                            "repeat",
                            math.max(0, st.lives)
                        ),
                        20,
                        18,
                        16,
                        "#ff6a7a",
                        "left"
                    )
                    __L1:txt(
                        c,
                        __add("◆ ", st.papers),
                        __L1.W - 70,
                        18,
                        14,
                        "#fffaf0",
                        "right"
                    )
                end
            },
            "id,name,sub,color,duo,max,medals,rules,rulesDuo,controls,init,addPlat,update,drawLow,drawMain"
        )
    )
    __L1.COMIDAS = __arrL(
        {
            __arrL({"COXINHA", "#d88a3a", "#f2b860"}, 3),
            __arrL({"PASTEL", "#e8c060", "#fff0a8"}, 3),
            __arrL({"ACARAJÉ", "#c8602a", "#f2a050"}, 3),
            __arrL({"CACAU", "#c8742a", "#f2c060"}, 3),
            __arrL({"PÃO DE QUEIJO", "#e8c070", "#fff2c0"}, 3),
            __arrL({"BANANA", "#f2d040", "#fff6a0"}, 3),
            __arrL({"AÇAÍ", "#5a1a5a", "#9a3a8a"}, 3)
        },
        7
    )
    __L1.RUINS = __arrL(
        {
            __arrL({"MEIA FEDIDA", "#e8e8e0", "#9aa0a6"}, 3),
            __arrL({"PEDRA", "#7a7a7a", "#a8a8a8"}, 3),
            __arrL({"PIMENTA", "#d8242c", "#ff7a6a"}, 3)
        },
        3
    )
    __call(
        __L1.GAMES,
        "push",
        __ord(
            {
                id = "igor",
                name = "IGOR COMILÃO",
                sub = "Ache a comida na feira e enche a barriga do Igor.",
                color = "#f0a050",
                duo = "coop",
                max = 4,
                medals = __arrL({1200, 2600, 4200}, 3),
                rules = __arrL({"Corra e pule pelas bancas para pegar a comida (só cabe uma na mão).", "Leve até a boca do Igor, no canto direito. Entregas seguidas fazem combo.", "Cuidado: meia, pedra e pimenta deixam o Igor bravo e gastam a fome.", "A barriga vai esvaziando: se a fome zerar ou o tempo acabar, fim."}, 4),
                rulesDuo = __arrL({"Todo mundo alimenta o mesmo Igor e soma os pontos.", "Cada um carrega uma comida por vez.", "Combine quem busca em cima e quem busca embaixo!"}, 3),
                controls = __arrL({"Esquerda e direita: correr", "A: pular", "B: largar o que está na mão"}, 3),
                init = function(self, st)
                    local ____st_1104 = st
                    local ____call_1103 = __call
                    local ____temp_1102
                    if st.mode == "duo" then
                        ____temp_1102 = __get(
                            __arrL(
                                {
                                    __arrL({120, 200}, 2),
                                    __arrL({90, 170, 250}, 3),
                                    __arrL({70, 140, 210, 280}, 4)
                                },
                                3
                            ),
                            __L1:NP(st) - 2
                        )
                    else
                        ____temp_1102 = __arrL({160}, 1)
                    end
                    ____st_1104.pl = ____call_1103(
                        ____temp_1102,
                        "map",
                        function(____, x, i) return {
                            x = x,
                            y = 0,
                            vy = 0,
                            face = 1,
                            i = i,
                            mao = nil
                        } end
                    )
                    st.bancas = __arrL({
                        {x = 40, y = 196, w = 90},
                        {x = 170, y = 164, w = 100},
                        {x = 60, y = 120, w = 80},
                        {x = 250, y = 108, w = 90},
                        {x = 150, y = 70, w = 70}
                    }, 5)
                    st.itens = __arrL({}, 0)
                    st.vem = 0.4
                    st.tempo = 75
                    st.fome = 1
                    st.combo = 0
                    st.comboT = 0
                    st.come = 0
                    st.bravo = 0
                    st.comeu = 0
                    st.migalha = __arrL({}, 0)
                end,
                novo = function(self, st)
                    local lugares = __arr(
                        {
                            x = __L1:rnd(20, 320),
                            y = 248
                        },
                        __TS__Spread(__iter(__call(
                            st.bancas,
                            "map",
                            function(____, b) return {
                                x = __L1:rnd(
                                    b.x + 8,
                                    __add(b.x, b.w) - 8
                                ),
                                y = b.y
                            } end
                        )))
                    )
                    local L = __get(
                        lugares,
                        __L1:irnd(
                            0,
                            __len(lugares) - 1
                        )
                    )
                    local ruim = math.random() < 0.22
                    local ____t_result_1105
                    if __t(ruim) then
                        ____t_result_1105 = __get(
                            __L1.RUINS,
                            __L1:irnd(
                                0,
                                __len(__L1.RUINS) - 1
                            )
                        )
                    else
                        ____t_result_1105 = __get(
                            __L1.COMIDAS,
                            __L1:irnd(
                                0,
                                __len(__L1.COMIDAS) - 1
                            )
                        )
                    end
                    local tipo = ____t_result_1105
                    __call(
                        st.itens,
                        "push",
                        {
                            x = L.x,
                            y = L.y,
                            tipo = tipo,
                            ruim = ruim,
                            vida = 9 + __L1:rnd(0, 4),
                            pisca = 0
                        }
                    )
                end,
                chao = function(self, st, p)
                    local py = 248 - p.y
                    for ____, b in __iterar((st.bancas)) do
                        local ____t_1111 = __t
                        local ____t_result_1110
                        local ____t_1109 = __t
                        local ____t_result_1108
                        local ____t_1107 = __t
                        local ____temp_1106 = __le(p.vy, 0) and __gt(p.x, b.x - 4)
                        __O[1188] = ____temp_1106
                        if ____t_1107(____temp_1106) then
                            ____t_result_1108 = __lt(
                                p.x,
                                __add(b.x, b.w) + 4
                            )
                        else
                            ____t_result_1108 = __O[1188]
                        end
                        __O[1189] = ____t_result_1108
                        if ____t_1109(____t_result_1108) then
                            ____t_result_1110 = math.abs(py - b.y) <= 4
                        else
                            ____t_result_1110 = __O[1189]
                        end
                        if ____t_1111(____t_result_1110) then
                            return 248 - b.y
                        end
                    end
                    return 0
                end,
                update = function(self, st, dt)
                    st.tempo = st.tempo - dt
                    st.fome = math.max(0, st.fome - dt * 0.018 * (1 + st.t / 90))
                    st.come = math.max(0, st.come - dt)
                    st.bravo = math.max(0, st.bravo - dt)
                    st.comboT = st.comboT - dt
                    if __le(st.comboT, 0) then
                        st.combo = 0
                    end
                    st.vem = st.vem - dt
                    if __t(__le(st.vem, 0) and __lt(
                        __len(st.itens),
                        6
                    )) then
                        st.vem = __L1:rnd(0.7, 1.4)
                        self:novo(st)
                    end
                    for ____, it in __iterar((st.itens)) do
                        it.vida = it.vida - dt
                    end
                    st.itens = __call(
                        st.itens,
                        "filter",
                        function(____, it)
                            local ____t_result_1114
                            local ____t_1113 = __t
                            local ____gt_result_1112 = __gt(it.vida, 0)
                            __O[1190] = ____gt_result_1112
                            if ____t_1113(____gt_result_1112) then
                                ____t_result_1114 = __O[1190]
                            else
                                ____t_result_1114 = it.mao
                            end
                            return ____t_result_1114
                        end
                    )
                    __call(
                        st.pl,
                        "forEach",
                        function(____, p)
                            local i = p.i
                            p.x = __L1:clamp(
                                p.x + __get(__L1.P, i).x * 160 * dt,
                                10,
                                372
                            )
                            if __t(__get(__L1.P, i).x) then
                                p.face = __get(__L1.P, i).x
                            end
                            local base = self:chao(st, p)
                            local ____t_1118 = __t
                            local ____t_result_1117
                            local ____t_1116 = __t
                            local ____get_result_ap_1115 = __get(__L1.P, i).ap
                            __O[1191] = ____get_result_ap_1115
                            if ____t_1116(____get_result_ap_1115) then
                                ____t_result_1117 = p.y == base or p.y == 0
                            else
                                ____t_result_1117 = __O[1191]
                            end
                            if ____t_1118(____t_result_1117) then
                                p.vy = 260
                                __L1:sfx("bounce")
                            end
                            p.vy = p.vy - 640 * dt
                            local ny = p.y + p.vy * dt
                            local pouso = 0
                            for ____, b in __iterar((st.bancas)) do
                                local top = 248 - b.y
                                local ____t_1126 = __t
                                local ____t_result_1125
                                local ____t_1124 = __t
                                local ____t_result_1123
                                local ____t_1122 = __t
                                local ____t_result_1121
                                local ____t_1120 = __t
                                local ____temp_1119 = __le(p.vy, 0) and __ge(p.y, top)
                                __O[1192] = ____temp_1119
                                if ____t_1120(____temp_1119) then
                                    ____t_result_1121 = __le(ny, top)
                                else
                                    ____t_result_1121 = __O[1192]
                                end
                                __O[1193] = ____t_result_1121
                                if ____t_1122(____t_result_1121) then
                                    ____t_result_1123 = __gt(p.x, b.x - 4)
                                else
                                    ____t_result_1123 = __O[1193]
                                end
                                __O[1194] = ____t_result_1123
                                if ____t_1124(____t_result_1123) then
                                    ____t_result_1125 = __lt(
                                        p.x,
                                        __add(b.x, b.w) + 4
                                    )
                                else
                                    ____t_result_1125 = __O[1194]
                                end
                                if ____t_1126(____t_result_1125) then
                                    pouso = math.max(pouso, top)
                                end
                            end
                            p.y = math.max(pouso, ny)
                            if p.y == pouso then
                                p.vy = math.max(0, p.vy)
                            end
                            local ____t_1130 = __t
                            local ____t_result_1129
                            local ____t_1128 = __t
                            local ____get_result_bp_1127 = __get(__L1.P, i).bp
                            __O[1195] = ____get_result_bp_1127
                            if ____t_1128(____get_result_bp_1127) then
                                ____t_result_1129 = p.mao
                            else
                                ____t_result_1129 = __O[1195]
                            end
                            if ____t_1130(____t_result_1129) then
                                __call(
                                    st.itens,
                                    "push",
                                    __assign({}, p.mao, {x = p.x, y = 248 - p.y, vida = 6})
                                )
                                p.mao = nil
                            end
                            if not __t(p.mao) then
                                local k = __call(
                                    st.itens,
                                    "findIndex",
                                    function(____, it) return math.abs(it.x - p.x) < 12 and math.abs(it.y - (248 - p.y)) < 16 end
                                )
                                if __ge(k, 0) then
                                    p.mao = __get(st.itens, k)
                                    __call(st.itens, "splice", k, 1)
                                    __L1:sfx("pick")
                                end
                            end
                            local ____t_1134 = __t
                            local ____t_result_1133
                            local ____t_1132 = __t
                            local ____t_result_1131
                            if __t(p.mao) then
                                ____t_result_1131 = __gt(p.x, 352)
                            else
                                ____t_result_1131 = p.mao
                            end
                            __O[1196] = ____t_result_1131
                            if ____t_1132(____t_result_1131) then
                                ____t_result_1133 = __lt(p.y, 120)
                            else
                                ____t_result_1133 = __O[1196]
                            end
                            if ____t_1134(____t_result_1133) then
                                local it = p.mao
                                p.mao = nil
                                if __t(it.ruim) then
                                    st.bravo = 1.2
                                    st.fome = math.max(0, st.fome - 0.15)
                                    st.combo = 0
                                    __L1:sfx("hit")
                                    st.shake = 0.3
                                    __call(
                                        st.pop,
                                        "push",
                                        {
                                            x = 410,
                                            y = 120,
                                            s = __add(
                                                "ECA! ",
                                                __get(it.tipo, 0)
                                            ),
                                            t = 0
                                        }
                                    )
                                else
                                    st.combo = st.combo + 1
                                    st.comboT = 4
                                    st.come = 0.8
                                    st.comeu = st.comeu + 1
                                    st.fome = math.min(1, st.fome + 0.12)
                                    local pts = 100 * math.min(5, st.combo)
                                    __set(
                                        st.score,
                                        0,
                                        __get(st.score, 0) + pts
                                    )
                                    __L1:sfx("power")
                                    local ____call_1139 = __call
                                    local ____st_pop_1138 = st.pop
                                    local ____add_1137 = __add
                                    local ____add_result_1136 = __add("+", pts)
                                    local ____gt_result_1135
                                    if __gt(st.combo, 1) then
                                        ____gt_result_1135 = __add(" x", st.combo)
                                    else
                                        ____gt_result_1135 = ""
                                    end
                                    ____call_1139(
                                        ____st_pop_1138,
                                        "push",
                                        {
                                            x = 410,
                                            y = 120,
                                            s = ____add_1137(____add_result_1136, ____gt_result_1135),
                                            t = 0
                                        }
                                    )
                                    do
                                        local k = 0
                                        while k < 8 do
                                            __call(
                                                st.migalha,
                                                "push",
                                                {
                                                    x = 415 + __L1:rnd(-8, 8),
                                                    y = 150,
                                                    vx = __L1:rnd(-40, 40),
                                                    vy = __L1:rnd(-60, -20),
                                                    t = 0,
                                                    cor = __get(it.tipo, 2)
                                                }
                                            )
                                            k = k + 1
                                        end
                                    end
                                end
                            end
                        end
                    )
                    for ____, m in __iterar((st.migalha)) do
                        m.t = __add(m.t, dt)
                        m.x = m.x + m.vx * dt
                        m.vy = m.vy + 300 * dt
                        m.y = m.y + m.vy * dt
                    end
                    st.migalha = __call(
                        st.migalha,
                        "filter",
                        function(____, m) return __lt(m.t, 1) end
                    )
                    if __t(__le(st.tempo, 0) or __le(st.fome, 0)) then
                        __L1:sfx(__le(st.fome, 0) and "lose" or "win")
                        local ____st_1142 = st
                        local ____st_end_1143 = st["end"]
                        local ____math_floor_result_1141 = math.floor(__get(st.score, 0) + 0.5)
                        local ____le_result_1140
                        if __le(st.fome, 0) then
                            ____le_result_1140 = ("O Igor ficou com fome e foi embora. Comeu " .. tostring(st.comeu)) .. " vezes."
                        else
                            ____le_result_1140 = ("Tempo! O Igor comeu " .. tostring(st.comeu)) .. " vezes e pediu sobremesa."
                        end
                        ____st_end_1143(____st_1142, {score = ____math_floor_result_1141, text = ____le_result_1140})
                    end
                end,
                drawLow = function(self, g, st)
                    do
                        local i = 0
                        while i < 12 do
                            __L1:R(
                                g,
                                0,
                                i * 6,
                                __L1.LW,
                                6,
                                __t(__mod(i, 2)) and "#e8d8b0" or "#c84a3a"
                            )
                            i = i + 1
                        end
                    end
                    __L1:R(
                        g,
                        0,
                        72,
                        __L1.LW,
                        178,
                        "#f0e2c0"
                    )
                    do
                        local y = 76
                        while y < 250 do
                            __L1:R(
                                g,
                                0,
                                y,
                                __L1.LW,
                                1,
                                "#e2d0a8"
                            )
                            y = y + 12
                        end
                    end
                    do
                        local k = 0
                        while k < 24 do
                            local x = k * 20 + 4
                            __L1:R(
                                g,
                                x,
                                76 + __mod(k, 2) * 2,
                                8,
                                6,
                                __get(
                                    __arrL({"#e86a8a", "#7ad1ff", "#ffd75a", "#8ad070"}, 4),
                                    __mod(k, 4)
                                )
                            )
                            k = k + 1
                        end
                    end
                    __L1:R(
                        g,
                        0,
                        248,
                        __L1.LW,
                        22,
                        "#9a7a52"
                    )
                    __L1:R(
                        g,
                        0,
                        248,
                        __L1.LW,
                        2,
                        "#b89a6a"
                    )
                    do
                        local x = 0
                        while x < __L1.LW do
                            __L1:R(
                                g,
                                x,
                                256 + (__t(__mod(x, 28)) and 0 or 4),
                                6,
                                2,
                                "#8a6a42"
                            )
                            x = x + 14
                        end
                    end
                    for ____, b in __iterar((st.bancas)) do
                        __L1:R(
                            g,
                            b.x,
                            b.y,
                            b.w,
                            5,
                            "#8a5a32"
                        )
                        __L1:R(
                            g,
                            b.x,
                            b.y,
                            b.w,
                            2,
                            "#b8844e"
                        )
                        __L1:R(
                            g,
                            b.x + 3,
                            b.y + 5,
                            3,
                            248 - b.y - 5,
                            "#6a4224"
                        )
                        __L1:R(
                            g,
                            __add(b.x, b.w) - 6,
                            b.y + 5,
                            3,
                            248 - b.y - 5,
                            "#6a4224"
                        )
                        do
                            local x = b.x + 4
                            while __lt(
                                x,
                                __add(b.x, b.w) - 6
                            ) do
                                __L1:R(
                                    g,
                                    x,
                                    b.y - 4,
                                    7,
                                    4,
                                    __get(
                                        __arrL({"#f2c94c", "#3c8a5a", "#e8433a", "#c8742a"}, 4),
                                        __mod(
                                            __bor(x / 9, 0),
                                            4
                                        )
                                    )
                                )
                                x = x + 9
                            end
                        end
                    end
                    for ____, it in __iterar((st.itens)) do
                        do
                            local ____t_1147 = __t
                            local ____t_result_1146
                            local ____t_1145 = __t
                            local ____lt_result_1144 = __lt(it.vida, 2)
                            __O[1197] = ____lt_result_1144
                            if ____t_1145(____lt_result_1144) then
                                ____t_result_1146 = __mod(
                                    math.floor(st.t * 10),
                                    2
                                )
                            else
                                ____t_result_1146 = __O[1197]
                            end
                            if ____t_1147(____t_result_1146) then
                                continue
                            end
                            local ____, c1, c2 = table.unpack(it.tipo, 1, 3)
                            local x = it.x
                            local y = it.y - 6
                            __L1:R(
                                g,
                                x - 5,
                                y - 4,
                                10,
                                8,
                                "#2a1a10"
                            )
                            __L1:R(
                                g,
                                x - 4,
                                y - 3,
                                8,
                                6,
                                c1
                            )
                            __L1:R(
                                g,
                                x - 3,
                                y - 3,
                                4,
                                2,
                                c2
                            )
                            if __t(it.ruim) then
                                __L1:R(
                                    g,
                                    x - 1,
                                    y - 9,
                                    2,
                                    3,
                                    "#7ad070"
                                )
                                __L1:R(
                                    g,
                                    x + 3,
                                    y - 11,
                                    2,
                                    3,
                                    "#7ad070"
                                )
                            else
                                __L1:c_brilho(g, x, y, st.t)
                            end
                        end
                    end
                    __L1:igorRosto(g, 424, 150, st)
                    for ____, m in __iterar((st.migalha)) do
                        __L1:R(
                            g,
                            m.x,
                            m.y,
                            2,
                            2,
                            m.cor
                        )
                    end
                    __L1:R(
                        g,
                        8,
                        6,
                        124,
                        10,
                        "#2a1a10"
                    )
                    __L1:R(
                        g,
                        10,
                        8,
                        120 * st.fome,
                        6,
                        __gt(st.fome, 0.35) and "#7ad070" or "#e84a3a"
                    )
                    __L1:R(
                        g,
                        10,
                        8,
                        120 * st.fome,
                        2,
                        "#ffffff55"
                    )
                end,
                drawMain = function(self, c, st)
                    __call(
                        st.pl,
                        "forEach",
                        function(____, p)
                            __L1:hero(
                                c,
                                __get(__L1.PLAYER_TYPES, p.i),
                                p.x * 2,
                                500 - p.y * 2,
                                {
                                    facing = p.face,
                                    moving = math.abs(__get(__L1.P, p.i).x) > 0,
                                    frame = st.t * 1.5,
                                    grounded = p.vy == 0
                                }
                            )
                            if __t(p.mao) then
                                local nome = table.unpack(p.mao.tipo, 1, 1)
                                __L1:txt(
                                    c,
                                    nome,
                                    p.x * 2,
                                    500 - p.y * 2 - 110,
                                    10,
                                    __t(p.mao.ruim) and "#ff8a7a" or "#fff6c8"
                                )
                            end
                        end
                    )
                    __L1:txt(
                        c,
                        "BARRIGA",
                        140,
                        46,
                        10,
                        "#2a1a10"
                    )
                    __L1:txt(
                        c,
                        __add(
                            "PONTOS ",
                            math.floor(__get(st.score, 0) + 0.5)
                        ),
                        __L1.W / 2,
                        18,
                        14
                    )
                    __L1:txt(
                        c,
                        __add(
                            "⏱ ",
                            math.max(
                                0,
                                math.ceil(st.tempo)
                            )
                        ),
                        __L1.W - 300,
                        18,
                        14,
                        __lt(st.tempo, 10) and "#ff6a5a" or "#fffaf0",
                        "right"
                    )
                    if __gt(st.combo, 1) then
                        __L1:txt(
                            c,
                            __add("COMBO x", st.combo),
                            __L1.W / 2,
                            46,
                            12,
                            "#ffd75a"
                        )
                    end
                end
            },
            "id,name,sub,color,duo,max,medals,rules,rulesDuo,controls,init,novo,chao,update,drawLow,drawMain"
        )
    )
    __L1.shopSel = 0
    __L1.shopMsg = nil
    __L1.open = false
    __L1.screen = "menu"
    __L1.sel = 0
    __L1.modeSel = 0
    __L1.st = nil
    __L1.game = nil
    __L1.cd = 0
    __L1.from = nil
    __L1.t = 0
    __L1.last = 0
    __L1.raf = 0
    __L1.clicks = __arrL({}, 0)
    __L1.initials = nil
    __L1.overSel = 0
    __L1.paused = false
    __L1.pauseSel = 0
    __L1.LETTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    __L1.net = nil
    __L1.onlineSel = 0
    __L1.codeBox = nil
    __L1.ONLINE_OPTS = __arrL({
        "CRIAR SALA",
        "ENTRAR COM CÓDIGO",
        "SALA RÁPIDA",
        "SERVIDOR",
        "VOLTAR"
    }, 5)
    __L1.peerLive = function()
        local ____t_result_1154
        local ____t_1151 = __t
        local ____t_result_1150
        local ____t_1149 = __t
        local ____temp_1148 = not not __t(__L1.net)
        __O[1202] = ____temp_1148
        if ____t_1149(____temp_1148) then
            ____t_result_1150 = __L1.net.peerOnline
        else
            ____t_result_1150 = __O[1202]
        end
        __O[1203] = ____t_result_1150
        if ____t_1151(____t_result_1150) then
            local ____temp_1153 = window.performance:now()
            local ____t_result_1152
            if __t(__L1.net.lastIn) then
                ____t_result_1152 = __L1.net.lastIn
            else
                ____t_result_1152 = 0
            end
            ____t_result_1154 = ____temp_1153 - ____t_result_1152 < 3000 or not __t(__L1.screen == "play" or __L1.screen == "count")
        else
            ____t_result_1154 = __O[1203]
        end
        return ____t_result_1154
    end
    __L1.onlineMsg = ""
    __L1.tv = nil
    __L1.tvMsg = ""
    __L1.tvLastScreen = ""
    __L1.CABINETS = {
        ["0"] = __arrL({2290}, 1),
        ["1"] = __arrL({3020}, 1),
        ["4"] = __arrL({2230}, 1),
        ["5"] = __arrL({1180}, 1),
        ["9"] = __arrL({1390}, 1),
        ["3"] = __arrL({760}, 1),
        ["7"] = __arrL({1060}, 1)
    }
    if window.document.readyState == "loading" then
        window.document:addEventListener("DOMContentLoaded", __L1.addEntries)
    else
        __L1:addEntries()
    end
    window:setTimeout(__L1.addEntries, 1500)
    window.Fliperama = __ord(
        {
            current = function()
                local ____t_result_1162
                local ____t_1161 = __t
                local ____t_result_1160
                local ____t_1156 = __t
                local ____t_result_1155
                if __t(__L1.open) then
                    ____t_result_1155 = __L1.game
                else
                    ____t_result_1155 = __L1.open
                end
                __O[1273] = ____t_result_1155
                if ____t_1156(____t_result_1155) then
                    local ____t_result_1159
                    local ____t_1158 = __t
                    local ____temp_1157 = __L1.screen == "play" or __L1.screen == "count"
                    __O[1272] = ____temp_1157
                    if ____t_1158(____temp_1157) then
                        ____t_result_1159 = __O[1272]
                    else
                        ____t_result_1159 = __L1.screen == "over"
                    end
                    ____t_result_1160 = ____t_result_1159
                else
                    ____t_result_1160 = __O[1273]
                end
                if ____t_1161(____t_result_1160) then
                    ____t_result_1162 = __L1.game.id
                else
                    ____t_result_1162 = nil
                end
                return ____t_result_1162
            end,
            open = __L1.openUp,
            openTV = function()
                __L1:openUp(nil, {from = "tv"})
                __L1:openTV()
            end,
            close = __L1.close,
            isOpen = function() return __L1.open end,
            near = __L1.near,
            drawWorld = __L1.drawWorld,
            games = function() return __call(
                __L1.GAMES,
                "map",
                function(____, gm) return {id = gm.id, name = gm.name, duo = gm.duo} end
            ) end,
            stats = function() return window.JSON:parse(window.JSON:stringify(__L1.data)) end,
            register = function(____, gm)
                local ____t_1166 = __t
                local ____t_result_1165
                local ____t_1164 = __t
                local ____t_result_1163
                if __t(gm) then
                    ____t_result_1163 = gm.id
                else
                    ____t_result_1163 = gm
                end
                __O[1274] = ____t_result_1163
                if ____t_1164(____t_result_1163) then
                    ____t_result_1165 = not __t(__call(
                        __L1.GAMES,
                        "some",
                        function(____, x) return x.id == gm.id end
                    ))
                else
                    ____t_result_1165 = __O[1274]
                end
                if ____t_1166(____t_result_1165) then
                    __call(__L1.GAMES, "push", gm)
                end
            end,
            debug = function() return {
                screen = __L1.screen,
                sel = __L1.sel,
                st = __L1.st,
                P = __L1.P,
                net = __L1.net,
                tv = __L1.tv
            } end
        },
        "current,open,openTV,close,isOpen,near,drawWorld,games,stats,register,debug"
    )
end)(nil)
return ____exports
