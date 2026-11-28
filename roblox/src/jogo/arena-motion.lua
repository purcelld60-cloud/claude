--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __le, __gt, __ge, __isFiniteN, __ord, __arrL, __iterar, __t, __get, __set, __call = __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__isFiniteN, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__call
local __add, __assign = __JSR.__add, __JSR.__assign
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__MathSign = ____lualib.__TS__MathSign
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local function clamp(____, n, a, b)
        return math.max(
            a,
            math.min(b, n)
        )
    end
    local timers = __arrL({
        "dashTime",
        "dashCD",
        "inv",
        "stun",
        "slow",
        "dropThrough",
        "wallKick",
        "jumpAnim",
        "landTimer",
        "launch"
    }, 10)
    local function create(self, p)
        local ____p_11 = p
        local ____assign_10 = __assign
        local ____temp_9 = {}
        local ____t_result_0
        if __t(p.used) then
            ____t_result_0 = p.used
        else
            ____t_result_0 = {}
        end
        local ____t_result_4
        local ____t_3 = __t
        local ____opt_1 = p.used
        if ____opt_1 ~= nil then
            ____opt_1 = ____opt_1.jumpPress
        end
        __O[2805] = ____opt_1
        if ____t_3(____opt_1) then
            ____t_result_4 = __O[2805]
        else
            ____t_result_4 = 0
        end
        local ____t_result_8
        local ____t_7 = __t
        local ____opt_5 = p.used
        if ____opt_5 ~= nil then
            ____opt_5 = ____opt_5.dash
        end
        __O[2806] = ____opt_5
        if ____t_7(____opt_5) then
            ____t_result_8 = __O[2806]
        else
            ____t_result_8 = 0
        end
        ____p_11.used = ____assign_10(____temp_9, ____t_result_0, {jumpPress = ____t_result_4, dash = ____t_result_8})
        for ____, key in __iterar((timers)) do
            local ____set_16 = __set
            local ____p_15 = p
            local ____t_result_14
            local ____t_13 = __t
            local ____TS__Number_result_12 = __TS__Number(__get(p, key))
            __O[2807] = ____TS__Number_result_12
            if ____t_13(____TS__Number_result_12) then
                ____t_result_14 = __O[2807]
            else
                ____t_result_14 = 0
            end
            ____set_16(
                ____p_15,
                key,
                math.max(0, ____t_result_14)
            )
        end
        p.wallSide = 0
        local ____p_18 = p
        local ____isFiniteN_result_17
        if __isFiniteN(p.wallGrip) then
            ____isFiniteN_result_17 = p.wallGrip
        else
            ____isFiniteN_result_17 = 1.35
        end
        ____p_18.wallGrip = ____isFiniteN_result_17
        local ____p_22 = p
        local ____t_result_21
        local ____t_20 = __t
        local ____TS__Number_result_19 = __TS__Number(p.wallTouches)
        __O[2808] = ____TS__Number_result_19
        if ____t_20(____TS__Number_result_19) then
            ____t_result_21 = __O[2808]
        else
            ____t_result_21 = 0
        end
        ____p_22.wallTouches = ____t_result_21
        local ____p_24 = p
        local ____t_result_23
        if __t(p.motion) then
            ____t_result_23 = p.motion
        else
            ____t_result_23 = "idle"
        end
        ____p_24.motion = ____t_result_23
        local ____p_28 = p
        local ____t_result_27
        local ____t_26 = __t
        local ____TS__Number_result_25 = __TS__Number(p.motionTime)
        __O[2809] = ____TS__Number_result_25
        if ____t_26(____TS__Number_result_25) then
            ____t_result_27 = __O[2809]
        else
            ____t_result_27 = 0
        end
        ____p_28.motionTime = ____t_result_27
        return p
    end
    local function state(self, p, name, dt)
        if p.motion ~= name then
            p.motion = name
            p.motionTime = 0
        else
            local ____p_31 = p
            local ____add_30 = __add
            local ____t_result_29
            if __t(p.motionTime) then
                ____t_result_29 = p.motionTime
            else
                ____t_result_29 = 0
            end
            ____p_31.motionTime = ____add_30(____t_result_29, dt)
        end
    end
    local function step(self, p, i, dt, options)
        if options == nil then
            options = {}
        end
        local ____t_35 = __t
        local ____t_result_34
        local ____t_33 = __t
        local ____temp_32 = not __t(p) or __le(p.stocks, 0)
        __O[2810] = ____temp_32
        if ____t_33(____temp_32) then
            ____t_result_34 = __O[2810]
        else
            ____t_result_34 = __gt(p.respawn, 0)
        end
        if ____t_35(____t_result_34) then
            return p
        end
        local ____t_result_38
        local ____t_37 = __t
        local ____TS__Number_result_36 = __TS__Number(dt)
        __O[2811] = ____TS__Number_result_36
        if ____t_37(____TS__Number_result_36) then
            ____t_result_38 = __O[2811]
        else
            ____t_result_38 = 0
        end
        dt = clamp(nil, ____t_result_38, 0, 0.05)
        local ____t_result_39
        if __t(i) then
            ____t_result_39 = i
        else
            ____t_result_39 = {}
        end
        i = ____t_result_39
        local ____p_41 = p
        local ____t_result_40
        if __t(p.used) then
            ____t_result_40 = p.used
        else
            ____t_result_40 = {}
        end
        ____p_41.used = ____t_result_40
        for ____, key in __iterar((timers)) do
            local ____set_46 = __set
            local ____p_45 = p
            local ____t_result_44
            local ____t_43 = __t
            local ____get_result_42 = __get(p, key)
            __O[2812] = ____get_result_42
            if ____t_43(____get_result_42) then
                ____t_result_44 = __O[2812]
            else
                ____t_result_44 = 0
            end
            ____set_46(
                ____p_45,
                key,
                math.max(0, ____t_result_44 - dt)
            )
        end
        local previousY = p.y
        local previousX = p.x
        local wasGround = not not __t(p.ground)
        local ____t_result_49
        local ____t_48 = __t
        local ____TS__Number_result_47 = __TS__Number(i.x)
        __O[2813] = ____TS__Number_result_47
        if ____t_48(____TS__Number_result_47) then
            ____t_result_49 = __O[2813]
        else
            ____t_result_49 = 0
        end
        local x = clamp(nil, ____t_result_49, -1, 1)
        local ____t_result_52
        local ____t_51 = __t
        local ____TS__Number_result_50 = __TS__Number(i.y)
        __O[2814] = ____TS__Number_result_50
        if ____t_51(____TS__Number_result_50) then
            ____t_result_52 = __O[2814]
        else
            ____t_result_52 = 0
        end
        local y = clamp(nil, ____t_result_52, -1, 1)
        local ____t_result_53
        if __t(options.speed) then
            ____t_result_53 = options.speed
        else
            ____t_result_53 = 1
        end
        local ____temp_56 = 300 * ____t_result_53
        local ____gt_result_55
        if __gt(p.slow, 0) then
            local ____t_result_54
            if __t(p.slowFactor) then
                ____t_result_54 = p.slowFactor
            else
                ____t_result_54 = 0.7
            end
            ____gt_result_55 = ____t_result_54
        else
            ____gt_result_55 = 1
        end
        local speed = ____temp_56 * ____gt_result_55
        local ____t_result_61
        local ____t_60 = __t
        local ____t_result_59
        local ____t_58 = __t
        local ____TS__Number_result_57 = __TS__Number(i.response)
        __O[2815] = ____TS__Number_result_57
        if ____t_58(____TS__Number_result_57) then
            ____t_result_59 = __O[2815]
        else
            ____t_result_59 = options.response
        end
        __O[2816] = ____t_result_59
        if ____t_60(____t_result_59) then
            ____t_result_61 = __O[2816]
        else
            ____t_result_61 = 1
        end
        local response = clamp(nil, ____t_result_61, 0.5, 2)
        local ____t_result_62
        if __t(options.platforms) then
            ____t_result_62 = options.platforms
        else
            ____t_result_62 = __arrL({}, 0)
        end
        local stage = ____t_result_62
        p.landed = false
        local ____t_66 = __t
        local ____t_result_65
        local ____t_64 = __t
        local ____t_result_63
        if __t(x) then
            ____t_result_63 = __le(p.stun, 0)
        else
            ____t_result_63 = x
        end
        __O[2817] = ____t_result_63
        if ____t_64(____t_result_63) then
            ____t_result_65 = __le(p.wallKick, 0)
        else
            ____t_result_65 = __O[2817]
        end
        if ____t_66(____t_result_65) then
            p.facing = __TS__MathSign(x)
        end
        local ____t_70 = __t
        local ____t_result_69
        local ____t_68 = __t
        local ____temp_67 = __gt(p.launch, 0) and math.abs(p.vx) < speed * 0.55
        __O[2818] = ____temp_67
        if ____t_68(____temp_67) then
            ____t_result_69 = __le(p.stun, 0)
        else
            ____t_result_69 = __O[2818]
        end
        if ____t_70(____t_result_69) then
            p.launch = 0
        end
        if __gt(p.stun, 0) then
            p.vx = p.vx * math.exp(__TS__Number(-dt) * (__t(p.ground) and 5 or 0.6))
            p.vx = p.vx + x * 60 * dt
        elseif __t(__le(p.dashTime, 0) and __le(p.wallKick, 0)) then
            if __t(not __t(p.ground) and __gt(p.launch, 0)) then
                p.vx = p.vx * math.exp(__TS__Number(-dt) * 0.9)
                p.vx = p.vx + x * speed * 1.6 * dt
            else
                p.vx = p.vx + (x * speed - p.vx) * math.min(
                    1,
                    dt * (__t(p.ground) and 15 or 7) * response
                )
            end
        end
        local ____t_result_73
        local ____t_72 = __t
        local ____TS__Number_result_71 = __TS__Number(i.jumpPress)
        __O[2819] = ____TS__Number_result_71
        if ____t_72(____TS__Number_result_71) then
            ____t_result_73 = __O[2819]
        else
            ____t_result_73 = 0
        end
        local jumpPress = ____t_result_73
        local ____gt_75 = __gt
        local ____t_result_74
        if __t(p.used.jumpPress) then
            ____t_result_74 = p.used.jumpPress
        else
            ____t_result_74 = 0
        end
        if ____gt_75(jumpPress, ____t_result_74) then
            p.used.jumpPress = jumpPress
            local ____t_83 = __t
            local ____t_result_82
            local ____t_81 = __t
            local ____t_result_80
            local ____t_79 = __t
            local ____t_result_78
            local ____t_77 = __t
            local ____le_result_76 = __le(p.stun, 0)
            __O[2820] = ____le_result_76
            if ____t_77(____le_result_76) then
                ____t_result_78 = p.wallSide
            else
                ____t_result_78 = __O[2820]
            end
            __O[2821] = ____t_result_78
            if ____t_79(____t_result_78) then
                ____t_result_80 = __gt(p.wallGrip, 0)
            else
                ____t_result_80 = __O[2821]
            end
            __O[2822] = ____t_result_80
            if ____t_81(____t_result_80) then
                ____t_result_82 = __lt(p.wallTouches, 4)
            else
                ____t_result_82 = __O[2822]
            end
            if ____t_83(____t_result_82) then
                p.vx = __TS__Number(-p.wallSide) * 360
                p.vy = -435
                p.facing = __TS__Number(-p.wallSide)
                p.wallKick = 0.2
                p.jumpAnim = 0.24
                p.jumps = 1
                p.wallTouches = p.wallTouches + 1
                p.wallGrip = math.max(0, p.wallGrip - 0.22)
                p.wallSide = 0
                p.ground = false
                p.emote = 0
                local ____this_85
                ____this_85 = options
                local ____opt_84 = ____this_85.emit
                if ____opt_84 ~= nil then
                    ____opt_84(____this_85, "wallJump", p)
                end
            elseif __t(__le(p.stun, 0) and __lt(p.jumps, 3)) then
                local ____t_89 = __t
                local ____t_result_88
                local ____t_87 = __t
                local ____temp_86 = y > 0.5
                __O[2823] = ____temp_86
                if ____t_87(____temp_86) then
                    ____t_result_88 = p.ground
                else
                    ____t_result_88 = __O[2823]
                end
                if ____t_89(____t_result_88) then
                    p.dropThrough = 0.25
                    p.y = p.y + 5
                    p.vy = 100
                    p.ground = false
                else
                    p.vy = p.jumps == 0 and -470 or -430
                    p.jumps = p.jumps + 1
                    p.launch = 0
                    p.ground = false
                    p.emote = 0
                    p.jumpAnim = 0.24
                    local ____this_91
                    ____this_91 = options
                    local ____opt_90 = ____this_91.emit
                    if ____opt_90 ~= nil then
                        ____opt_90(
                            ____this_91,
                            __ge(p.jumps, 2) and "doubleJump" or "jump",
                            p
                        )
                    end
                end
            end
        end
        local ____t_result_94
        local ____t_93 = __t
        local ____TS__Number_result_92 = __TS__Number(i.dash)
        __O[2824] = ____TS__Number_result_92
        if ____t_93(____TS__Number_result_92) then
            ____t_result_94 = __O[2824]
        else
            ____t_result_94 = 0
        end
        local dashPress = ____t_result_94
        local ____gt_96 = __gt
        local ____t_result_95
        if __t(p.used.dash) then
            ____t_result_95 = p.used.dash
        else
            ____t_result_95 = 0
        end
        if ____gt_96(dashPress, ____t_result_95) then
            p.used.dash = dashPress
            if __t(__le(p.dashCD, 0) and __le(p.stun, 0)) then
                p.dashTime = 0.17
                p.dashCD = 1
                p.launch = 0
                local ____p_98 = p
                local ____t_result_97
                if __t(x) then
                    ____t_result_97 = x
                else
                    ____t_result_97 = p.facing
                end
                ____p_98.vx = ____t_result_97 * 610
                p.vy = y < -0.5 and -200 or p.vy * 0.3
                p.inv = math.max(p.inv, 0.26)
                p.wallSide = 0
                p.emote = 0
                local ____this_100
                ____this_100 = options
                local ____opt_99 = ____this_100.emit
                if ____opt_99 ~= nil then
                    ____opt_99(____this_100, "dash", p)
                end
            end
        end
        do
            local ____t_result_105
            local ____t_104 = __t
            local ____t_result_103
            local ____t_102 = __t
            local ____temp_101 = not __t(p.ground) and y > 0.55
            __O[2825] = ____temp_101
            if ____t_102(____temp_101) then
                ____t_result_103 = __gt(p.vy, -40)
            else
                ____t_result_103 = __O[2825]
            end
            __O[2826] = ____t_result_103
            if ____t_104(____t_result_103) then
                ____t_result_105 = __le(p.stun, 0)
            else
                ____t_result_105 = __O[2826]
            end
            local fast = ____t_result_105
            p.vy = math.min(
                __t(fast) and 1350 or 1080,
                p.vy + (__t(fast) and 2100 or 1180) * dt
            )
        end
        p.x = p.x + p.vx * dt
        p.y = p.y + p.vy * dt
        p.ground = false
        local main = __call(
            stage,
            "find",
            function(____, s) return s.main end
        )
        local wall = 0
        local ____t_109 = __t
        local ____t_result_108
        local ____t_107 = __t
        local ____t_result_106
        if __t(main) then
            ____t_result_106 = __gt(p.y, main.y + 12)
        else
            ____t_result_106 = main
        end
        __O[2827] = ____t_result_106
        if ____t_107(____t_result_106) then
            ____t_result_108 = __lt(p.y - 64, main.y + 170)
        else
            ____t_result_108 = __O[2827]
        end
        if ____t_109(____t_result_108) then
            local left = main.x
            local right = __add(main.x, main.w)
            if __t(__le(previousX + 17, left + 3) and __ge(p.x + 17, left)) then
                p.x = left - 17
                p.vx = math.min(0, p.vx)
                if x > 0.15 then
                    wall = 1
                end
            elseif __t(previousX - 17 >= right - 3 and __le(p.x - 17, right)) then
                p.x = right + 17
                p.vx = math.max(0, p.vx)
                if x < -0.15 then
                    wall = -1
                end
            end
        end
        local ____t_119 = __t
        local ____t_result_118
        local ____t_117 = __t
        local ____t_result_116
        local ____t_115 = __t
        local ____t_result_114
        local ____t_113 = __t
        local ____t_result_112
        local ____t_111 = __t
        local ____t_result_110
        if __t(wall) then
            ____t_result_110 = __le(p.stun, 0)
        else
            ____t_result_110 = wall
        end
        __O[2828] = ____t_result_110
        if ____t_111(____t_result_110) then
            ____t_result_112 = __le(p.wallKick, 0)
        else
            ____t_result_112 = __O[2828]
        end
        __O[2829] = ____t_result_112
        if ____t_113(____t_result_112) then
            ____t_result_114 = __gt(p.wallGrip, 0)
        else
            ____t_result_114 = __O[2829]
        end
        __O[2830] = ____t_result_114
        if ____t_115(____t_result_114) then
            ____t_result_116 = __lt(p.wallTouches, 4)
        else
            ____t_result_116 = __O[2830]
        end
        __O[2831] = ____t_result_116
        if ____t_117(____t_result_116) then
            ____t_result_118 = __le(p.dashTime, 0)
        else
            ____t_result_118 = __O[2831]
        end
        if ____t_119(____t_result_118) then
            p.wallSide = wall
            p.wallGrip = math.max(0, p.wallGrip - dt)
            p.vy = math.min(p.vy, 72)
            p.facing = wall
        else
            p.wallSide = 0
        end
        if __t(__le(p.dropThrough, 0) and __ge(p.vy, 0)) then
            for ____, platform in __iterar((stage)) do
                local ____t_125 = __t
                local ____t_result_124
                local ____t_123 = __t
                local ____t_result_122
                local ____t_121 = __t
                local ____temp_120 = __le(previousY, platform.y + 3) and __ge(p.y, platform.y)
                __O[2832] = ____temp_120
                if ____t_121(____temp_120) then
                    ____t_result_122 = __ge(p.x, platform.x - 10)
                else
                    ____t_result_122 = __O[2832]
                end
                __O[2833] = ____t_result_122
                if ____t_123(____t_result_122) then
                    ____t_result_124 = __le(
                        p.x,
                        __add(platform.x, platform.w) + 10
                    )
                else
                    ____t_result_124 = __O[2833]
                end
                if ____t_125(____t_result_124) then
                    p.y = platform.y
                    p.vy = 0
                    p.ground = true
                    p.jumps = 0
                    p.launch = 0
                    p.recoveryUsed = false
                    p.wallSide = 0
                    p.wallTouches = 0
                    p.wallGrip = 1.35
                    if not __t(wasGround) then
                        p.landTimer = 0.12
                        p.landed = true
                    end
                    break
                end
            end
        end
        local ____gt_result_130
        if __gt(p.wallKick, 0) then
            ____gt_result_130 = "wallJump"
        else
            local ____t_result_129
            if __t(p.wallSide) then
                ____t_result_129 = "wallSlide"
            else
                local ____gt_result_128
                if __gt(p.dashTime, 0) then
                    ____gt_result_128 = "dash"
                else
                    local ____gt_result_127
                    if __gt(p.landTimer, 0) then
                        ____gt_result_127 = "land"
                    else
                        local ____temp_126
                        if not __t(p.ground) then
                            ____temp_126 = __t(__gt(p.jumpAnim, 0) and __ge(p.jumps, 2)) and "doubleJump" or (__lt(p.vy, 0) and "jump" or "fall")
                        else
                            ____temp_126 = math.abs(p.vx) > 22 and "run" or "idle"
                        end
                        ____gt_result_127 = ____temp_126
                    end
                    ____gt_result_128 = ____gt_result_127
                end
                ____t_result_129 = ____gt_result_128
            end
            ____gt_result_130 = ____t_result_129
        end
        local motion = ____gt_result_130
        state(nil, p, motion, dt)
        return p
    end
    window.ArenaMotion = __ord({version = 2, create = create, step = step, timers = timers}, "version,create,step,timers")
end)(nil)
return ____exports
