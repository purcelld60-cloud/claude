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
        local ____p_10 = p
        local ____assign_9 = __assign
        local ____temp_7 = {}
        local ____temp_8 = if __t(p.used) then p.used else {}
        local ____t_2 = __t
        local ____opt_0 = p.used
        if ____opt_0 ~= nil then
            ____opt_0 = ____opt_0.jumpPress
        end
        __O[2800] = ____opt_0
        local ____temp_6 = if ____t_2(____opt_0) then __O[2800] else 0
        local ____t_5 = __t
        local ____opt_3 = p.used
        if ____opt_3 ~= nil then
            ____opt_3 = ____opt_3.dash
        end
        __O[2801] = ____opt_3
        ____p_10.used = ____assign_9(____temp_7, ____temp_8, {jumpPress = ____temp_6, dash = if ____t_5(____opt_3) then __O[2801] else 0})
        for ____, key in __iterar((timers)) do
            local ____set_14 = __set
            local ____p_13 = p
            local ____t_12 = __t
            local ____TS__Number_result_11 = __TS__Number(__get(p, key))
            __O[2802] = ____TS__Number_result_11
            ____set_14(
                ____p_13,
                key,
                math.max(0, if ____t_12(____TS__Number_result_11) then __O[2802] else 0)
            )
        end
        p.wallSide = 0
        p.wallGrip = if __isFiniteN(p.wallGrip) then p.wallGrip else 1.35
        local ____p_17 = p
        local ____t_16 = __t
        local ____TS__Number_result_15 = __TS__Number(p.wallTouches)
        __O[2803] = ____TS__Number_result_15
        ____p_17.wallTouches = if ____t_16(____TS__Number_result_15) then __O[2803] else 0
        p.motion = if __t(p.motion) then p.motion else "idle"
        local ____p_20 = p
        local ____t_19 = __t
        local ____TS__Number_result_18 = __TS__Number(p.motionTime)
        __O[2804] = ____TS__Number_result_18
        ____p_20.motionTime = if ____t_19(____TS__Number_result_18) then __O[2804] else 0
        return p
    end
    local function state(self, p, name, dt)
        if p.motion ~= name then
            p.motion = name
            p.motionTime = 0
        else
            p.motionTime = __add(if __t(p.motionTime) then p.motionTime else 0, dt)
        end
    end
    local function step(self, p, i, dt, options)
        if options == nil then
            options = {}
        end
        local ____t_23 = __t
        local ____t_22 = __t
        local ____temp_21 = not __t(p) or __le(p.stocks, 0)
        __O[2805] = ____temp_21
        if ____t_23(if ____t_22(____temp_21) then __O[2805] else __gt(p.respawn, 0)) then
            return p
        end
        local ____t_25 = __t
        local ____TS__Number_result_24 = __TS__Number(dt)
        __O[2806] = ____TS__Number_result_24
        dt = clamp(nil, if ____t_25(____TS__Number_result_24) then __O[2806] else 0, 0, 0.05)
        i = if __t(i) then i else {}
        p.used = if __t(p.used) then p.used else {}
        for ____, key in __iterar((timers)) do
            local ____set_29 = __set
            local ____p_28 = p
            local ____t_27 = __t
            local ____get_result_26 = __get(p, key)
            __O[2807] = ____get_result_26
            ____set_29(
                ____p_28,
                key,
                math.max(0, if ____t_27(____get_result_26) then __O[2807] else 0 - dt)
            )
        end
        local previousY = p.y
        local previousX = p.x
        local wasGround = not not __t(p.ground)
        local ____t_31 = __t
        local ____TS__Number_result_30 = __TS__Number(i.x)
        __O[2808] = ____TS__Number_result_30
        local x = clamp(nil, if ____t_31(____TS__Number_result_30) then __O[2808] else 0, -1, 1)
        local ____t_33 = __t
        local ____TS__Number_result_32 = __TS__Number(i.y)
        __O[2809] = ____TS__Number_result_32
        local y = clamp(nil, if ____t_33(____TS__Number_result_32) then __O[2809] else 0, -1, 1)
        local speed = 300 * if __t(options.speed) then options.speed else 1 * if __gt(p.slow, 0) then if __t(p.slowFactor) then p.slowFactor else 0.7 else 1
        local ____t_37 = __t
        local ____t_35 = __t
        local ____TS__Number_result_34 = __TS__Number(i.response)
        __O[2810] = ____TS__Number_result_34
        local ____temp_36 = if ____t_35(____TS__Number_result_34) then __O[2810] else options.response
        __O[2811] = ____temp_36
        local response = clamp(nil, if ____t_37(____temp_36) then __O[2811] else 1, 0.5, 2)
        local stage = if __t(options.platforms) then options.platforms else __arrL({}, 0)
        p.landed = false
        local ____t_40 = __t
        local ____t_39 = __t
        local ____temp_38 = if __t(x) then __le(p.stun, 0) else x
        __O[2812] = ____temp_38
        if ____t_40(if ____t_39(____temp_38) then __le(p.wallKick, 0) else __O[2812]) then
            p.facing = __TS__MathSign(x)
        end
        local ____t_43 = __t
        local ____t_42 = __t
        local ____temp_41 = __gt(p.launch, 0) and math.abs(p.vx) < speed * 0.55
        __O[2813] = ____temp_41
        if ____t_43(if ____t_42(____temp_41) then __le(p.stun, 0) else __O[2813]) then
            p.launch = 0
        end
        if __gt(p.stun, 0) then
            p.vx = p.vx * math.exp(__TS__Number(-dt) * if __t(p.ground) then 5 else 0.6)
            p.vx = p.vx + x * 60 * dt
        elseif __t(__le(p.dashTime, 0) and __le(p.wallKick, 0)) then
            if __t(not __t(p.ground) and __gt(p.launch, 0)) then
                p.vx = p.vx * math.exp(__TS__Number(-dt) * 0.9)
                p.vx = p.vx + x * speed * 1.6 * dt
            else
                p.vx = p.vx + (x * speed - p.vx) * math.min(1, dt * if __t(p.ground) then 15 else 7 * response)
            end
        end
        local ____t_45 = __t
        local ____TS__Number_result_44 = __TS__Number(i.jumpPress)
        __O[2814] = ____TS__Number_result_44
        local jumpPress = if ____t_45(____TS__Number_result_44) then __O[2814] else 0
        if __gt(jumpPress, if __t(p.used.jumpPress) then p.used.jumpPress else 0) then
            p.used.jumpPress = jumpPress
            local ____t_52 = __t
            local ____t_51 = __t
            local ____t_49 = __t
            local ____t_47 = __t
            local ____le_result_46 = __le(p.stun, 0)
            __O[2815] = ____le_result_46
            local ____temp_48 = if ____t_47(____le_result_46) then p.wallSide else __O[2815]
            __O[2816] = ____temp_48
            local ____temp_50 = if ____t_49(____temp_48) then __gt(p.wallGrip, 0) else __O[2816]
            __O[2817] = ____temp_50
            if ____t_52(if ____t_51(____temp_50) then __lt(p.wallTouches, 4) else __O[2817]) then
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
                local ____this_54
                ____this_54 = options
                local ____opt_53 = ____this_54.emit
                if ____opt_53 ~= nil then
                    ____opt_53(____this_54, "wallJump", p)
                end
            elseif __t(__le(p.stun, 0) and __lt(p.jumps, 3)) then
                local ____t_57 = __t
                local ____t_56 = __t
                local ____temp_55 = y > 0.5
                __O[2818] = ____temp_55
                if ____t_57(if ____t_56(____temp_55) then p.ground else __O[2818]) then
                    p.dropThrough = 0.25
                    p.y = p.y + 5
                    p.vy = 100
                    p.ground = false
                else
                    p.vy = if p.jumps == 0 then -470 else -430
                    p.jumps = p.jumps + 1
                    p.launch = 0
                    p.ground = false
                    p.emote = 0
                    p.jumpAnim = 0.24
                    local ____this_59
                    ____this_59 = options
                    local ____opt_58 = ____this_59.emit
                    if ____opt_58 ~= nil then
                        ____opt_58(____this_59, if __ge(p.jumps, 2) then "doubleJump" else "jump", p)
                    end
                end
            end
        end
        local ____t_61 = __t
        local ____TS__Number_result_60 = __TS__Number(i.dash)
        __O[2819] = ____TS__Number_result_60
        local dashPress = if ____t_61(____TS__Number_result_60) then __O[2819] else 0
        if __gt(dashPress, if __t(p.used.dash) then p.used.dash else 0) then
            p.used.dash = dashPress
            if __t(__le(p.dashCD, 0) and __le(p.stun, 0)) then
                p.dashTime = 0.17
                p.dashCD = 1
                p.launch = 0
                p.vx = if __t(x) then x else p.facing * 610
                p.vy = if y < -0.5 then -200 else p.vy * 0.3
                p.inv = math.max(p.inv, 0.26)
                p.wallSide = 0
                p.emote = 0
                local ____this_63
                ____this_63 = options
                local ____opt_62 = ____this_63.emit
                if ____opt_62 ~= nil then
                    ____opt_62(____this_63, "dash", p)
                end
            end
        end
        do
            local ____t_67 = __t
            local ____t_65 = __t
            local ____temp_64 = not __t(p.ground) and y > 0.55
            __O[2820] = ____temp_64
            local ____temp_66 = if ____t_65(____temp_64) then __gt(p.vy, -40) else __O[2820]
            __O[2821] = ____temp_66
            local fast = if ____t_67(____temp_66) then __le(p.stun, 0) else __O[2821]
            p.vy = math.min(if __t(fast) then 1350 else 1080, p.vy + if __t(fast) then 2100 else 1180 * dt)
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
        local ____t_70 = __t
        local ____t_69 = __t
        local ____temp_68 = if __t(main) then __gt(p.y, main.y + 12) else main
        __O[2822] = ____temp_68
        if ____t_70(if ____t_69(____temp_68) then __lt(p.y - 64, main.y + 170) else __O[2822]) then
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
        local ____t_79 = __t
        local ____t_78 = __t
        local ____t_76 = __t
        local ____t_74 = __t
        local ____t_72 = __t
        local ____temp_71 = if __t(wall) then __le(p.stun, 0) else wall
        __O[2823] = ____temp_71
        local ____temp_73 = if ____t_72(____temp_71) then __le(p.wallKick, 0) else __O[2823]
        __O[2824] = ____temp_73
        local ____temp_75 = if ____t_74(____temp_73) then __gt(p.wallGrip, 0) else __O[2824]
        __O[2825] = ____temp_75
        local ____temp_77 = if ____t_76(____temp_75) then __lt(p.wallTouches, 4) else __O[2825]
        __O[2826] = ____temp_77
        if ____t_79(if ____t_78(____temp_77) then __le(p.dashTime, 0) else __O[2826]) then
            p.wallSide = wall
            p.wallGrip = math.max(0, p.wallGrip - dt)
            p.vy = math.min(p.vy, 72)
            p.facing = wall
        else
            p.wallSide = 0
        end
        if __t(__le(p.dropThrough, 0) and __ge(p.vy, 0)) then
            for ____, platform in __iterar((stage)) do
                local ____t_84 = __t
                local ____t_83 = __t
                local ____t_81 = __t
                local ____temp_80 = __le(previousY, platform.y + 3) and __ge(p.y, platform.y)
                __O[2827] = ____temp_80
                local ____temp_82 = if ____t_81(____temp_80) then __ge(p.x, platform.x - 10) else __O[2827]
                __O[2828] = ____temp_82
                if ____t_84(if ____t_83(____temp_82) then __le(
                    p.x,
                    __add(platform.x, platform.w) + 10
                ) else __O[2828]) then
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
        local motion = if __gt(p.wallKick, 0) then "wallJump" else if __t(p.wallSide) then "wallSlide" else if __gt(p.dashTime, 0) then "dash" else if __gt(p.landTimer, 0) then "land" else if not __t(p.ground) then if __t(__gt(p.jumpAnim, 0) and __ge(p.jumps, 2)) then "doubleJump" else if __lt(p.vy, 0) then "jump" else "fall" else if math.abs(p.vx) > 22 then "run" else "idle"
        state(nil, p, motion, dt)
        return p
    end
    window.ArenaMotion = __ord({version = 2, create = create, step = step, timers = timers}, "version,create,step,timers")
end)(nil)
return ____exports
