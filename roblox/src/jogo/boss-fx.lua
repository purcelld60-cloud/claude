--!native
--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __le, __gt, __ge, __mod, __ord, __arrL, __iterar, __t, __get, __len, __call = __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__len, __JSR.__call
local __add = __JSR.__add
local ____lualib = require(script.Parent.lualib_bundle)
local WeakMap = ____lualib.WeakMap
local __TS__New = ____lualib.__TS__New
local __TS__Number = ____lualib.__TS__Number
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__MathSign = ____lualib.__TS__MathSign
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local FLOOR = 440
    local function clamp(____, v, a, b)
        return math.max(
            a,
            math.min(b, v)
        )
    end
    local function R(____, c, x, y, w, h, col)
        c.fillStyle = col
        c:fillRect(
            math.floor(x + 0.5),
            math.floor(y + 0.5),
            w,
            h
        )
    end
    local COLORS = __ord({
        igor = "#f2c14e",
        kaique = "#7fb6e8",
        arthur = "#f08a5d",
        dede = "#c9d3c4",
        freddy = "#f4a04a",
        reeisBoss = "#ffd166",
        marco = "#ef5d5d",
        giant = "#f0a35b",
        nicolas = "#fff0aa",
        menezes = "#efbfd3",
        nikolas = "#a6d05d"
    }, "igor,kaique,arthur,dede,freddy,reeisBoss,marco,giant,nicolas,menezes,nikolas")
    local mem = __TS__New(WeakMap)
    local shotTrails = __TS__New(WeakMap)
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
    local function color(____, e)
        local ____t_result_8
        local ____t_7 = __t
        local ____get_result_6 = __get(COLORS, e.type)
        __O[1562] = ____get_result_6
        if ____t_7(____get_result_6) then
            ____t_result_8 = __O[1562]
        else
            ____t_result_8 = "#ffe08b"
        end
        return ____t_result_8
    end
    local function headY(____, e)
        local ____e_y_12 = e.y
        local ____temp_11
        if e.type == "giant" then
            ____temp_11 = 205
        else
            local ____temp_10
            if e.type == "igor" then
                local ____t_result_9
                if __t(e.igorScale) then
                    ____t_result_9 = e.igorScale
                else
                    ____t_result_9 = 1
                end
                ____temp_10 = 92 * ____t_result_9
            else
                ____temp_10 = __t(e.type == "nikolas" and __ge(e.phase, 4)) and 230 or (__t(e.rage) and 130 or 100)
            end
            ____temp_11 = ____temp_10
        end
        return ____e_y_12 - ____temp_11
    end
    local function state(self, e)
        local m = __call(mem, "get", e)
        if not __t(m) then
            m = {
                last = e.state,
                age = 0,
                ghosts = __arrL({}, 0),
                motes = __arrL({}, 0),
                rings = __arrL({}, 0),
                ghostT = 0,
                prevY = e.y,
                jitter = 0
            }
            __call(mem, "set", e, m)
        end
        return m
    end
    local function update(self, dt, s)
        local ____t_result_15
        local ____t_14 = __t
        local ____TS__Number_result_13 = __TS__Number(dt)
        __O[1563] = ____TS__Number_result_13
        if ____t_14(____TS__Number_result_13) then
            ____t_result_15 = __O[1563]
        else
            ____t_result_15 = 0
        end
        dt = clamp(nil, ____t_result_15, 0, 0.05)
        local e = s.boss
        if __t(not __t(e) or __le(e.hp, 0)) then
            return
        end
        local m = state(nil, e)
        local full = not __t(lite(nil))
        if __t(m.last ~= e.state and e.type == "igor") then
            if e.state == "bellyAir" then
                m.takeoff = 0
                local ____opt_18 = window.SceneLife
                if ____opt_18 ~= nil then
                    ____opt_18 = ____opt_18.burst
                end
                if ____opt_18 ~= nil then
                    ____opt_18(
                        ____opt_18,
                        e.x,
                        FLOOR - 3,
                        "#d9c39a",
                        __t(full) and 14 or 5
                    )
                end
                __call(m.rings, "push", {
                    x = e.x,
                    y = FLOOR - 2,
                    age = 0,
                    life = 0.3,
                    size = 1.2,
                    col = "#d8c7a4",
                    dust = true
                })
            end
            if m.last == "bellyAir" then
                m.landed = 0
                m.crackX = e.x
                __call(m.rings, "push", {
                    x = e.x,
                    y = FLOOR - 2,
                    age = 0,
                    life = 0.5,
                    size = 2.4,
                    col = "#d8c7a4",
                    dust = true
                })
                local ____opt_22 = window.SceneLife
                if ____opt_22 ~= nil then
                    ____opt_22 = ____opt_22.impact
                end
                if ____opt_22 ~= nil then
                    ____opt_22(
                        ____opt_22,
                        e.x,
                        FLOOR - 8,
                        "#c9a87a",
                        40,
                        1
                    )
                end
                local ____opt_26 = window.SceneLife
                if ____opt_26 ~= nil then
                    ____opt_26 = ____opt_26.impact
                end
                if ____opt_26 ~= nil then
                    ____opt_26(
                        ____opt_26,
                        e.x,
                        FLOOR - 8,
                        "#c9a87a",
                        40,
                        -1
                    )
                end
                local ____opt_30 = window.SceneLife
                if ____opt_30 ~= nil then
                    ____opt_30 = ____opt_30.burst
                end
                if ____opt_30 ~= nil then
                    ____opt_30(
                        ____opt_30,
                        e.x,
                        FLOOR - 3,
                        "#d9c39a",
                        __t(full) and 22 or 8
                    )
                end
            end
            if e.state == "firing" then
                m.clap = 0
                __call(m.rings, "push", {
                    x = e.x,
                    y = FLOOR - 2,
                    age = 0,
                    life = 0.4,
                    size = 1.8,
                    col = "#f2c14e",
                    dust = true
                })
            end
        end
        if e.type == "igor" then
            if m.landed ~= nil then
                m.landed = __add(m.landed, dt)
            end
            if m.clap ~= nil then
                m.clap = __add(m.clap, dt)
            end
            if m.takeoff ~= nil then
                m.takeoff = __add(m.takeoff, dt)
            end
            local ____t_37 = __t
            local ____t_result_36
            local ____t_35 = __t
            local ____t_result_34
            local ____t_33 = __t
            local ____temp_32 = e.state == "bellyRolling"
            __O[1564] = ____temp_32
            if ____t_33(____temp_32) then
                ____t_result_34 = full
            else
                ____t_result_34 = __O[1564]
            end
            __O[1565] = ____t_result_34
            if ____t_35(____t_result_34) then
                ____t_result_36 = math.random() < 0.6
            else
                ____t_result_36 = __O[1565]
            end
            if ____t_37(____t_result_36) then
                local ____opt_42 = window.SceneLife
                if ____opt_42 ~= nil then
                    ____opt_42 = ____opt_42.burst
                end
                if ____opt_42 ~= nil then
                    local ____e_x_40 = e.x
                    local ____t_result_39
                    if __t(e.dashDir) then
                        ____t_result_39 = e.dashDir
                    else
                        ____t_result_39 = 1
                    end
                    ____opt_42(
                        ____opt_42,
                        ____e_x_40 - ____t_result_39 * 30,
                        FLOOR - 3,
                        "#d9c39a",
                        2
                    )
                end
            end
        end
        if m.last ~= e.state then
            m.last = e.state
            m.age = 0
            local ____t_47 = __t
            local ____t_result_46
            local ____t_45 = __t
            local ____temp_44 = e.state == "firing"
            __O[1566] = ____temp_44
            if ____t_45(____temp_44) then
                ____t_result_46 = full
            else
                ____t_result_46 = __O[1566]
            end
            if ____t_47(____t_result_46) then
                local ____call_52 = __call
                local ____m_rings_51 = m.rings
                local ____e_x_50 = e.x
                local ____t_49 = __t
                local ____t_result_48
                if __t(s.player) then
                    ____t_result_48 = __lt(s.player.x, e.x)
                else
                    ____t_result_48 = s.player
                end
                ____call_52(
                    ____m_rings_51,
                    "push",
                    {
                        x = ____e_x_50 + (____t_49(____t_result_48) and -30 or 30),
                        y = e.y - 42,
                        age = 0,
                        life = 0.25,
                        size = 0.6,
                        col = color(nil, e)
                    }
                )
            end
        else
            m.age = __add(m.age, dt)
        end
        local ____t_58 = __t
        local ____t_result_57
        local ____t_56 = __t
        local ____t_result_55
        local ____t_54 = __t
        local ____temp_53 = e.state == "windup"
        __O[1567] = ____temp_53
        if ____t_54(____temp_53) then
            ____t_result_55 = full
        else
            ____t_result_55 = __O[1567]
        end
        __O[1568] = ____t_result_55
        if ____t_56(____t_result_55) then
            ____t_result_57 = __lt(
                __len(m.motes),
                26
            )
        else
            ____t_result_57 = __O[1568]
        end
        if ____t_58(____t_result_57) then
            local a = math.random() * math.pi * 2
            local r = 70 + math.random() * 40
            __call(
                m.motes,
                "push",
                {
                    x = e.x + math.cos(a) * r,
                    y = e.y - 50 + math.sin(a) * r * 0.7,
                    life = 0.45
                }
            )
        end
        for ____, p in __iterar((m.motes)) do
            p.life = p.life - dt
            p.x = p.x + (e.x - p.x) * dt * 5
            p.y = p.y + (e.y - 50 - p.y) * dt * 5
        end
        m.motes = __call(
            m.motes,
            "filter",
            function(____, p) return __gt(p.life, 0) end
        )
        m.ghostT = m.ghostT - dt
        local ____t_64 = __t
        local ____t_result_63
        local ____t_62 = __t
        local ____t_result_61
        local ____t_60 = __t
        local ____temp_59 = e.state == "dashing" or e.state == "bellyRolling"
        __O[1569] = ____temp_59
        if ____t_60(____temp_59) then
            ____t_result_61 = __le(m.ghostT, 0)
        else
            ____t_result_61 = __O[1569]
        end
        __O[1570] = ____t_result_61
        if ____t_62(____t_result_61) then
            ____t_result_63 = full
        else
            ____t_result_63 = __O[1570]
        end
        if ____t_64(____t_result_63) then
            local ____call_70 = __call
            local ____m_ghosts_69 = m.ghosts
            local ____e_x_67 = e.x
            local ____e_y_68 = e.y
            local ____t_66 = __t
            local ____t_result_65
            if __t(s.player) then
                ____t_result_65 = __lt(s.player.x, e.x)
            else
                ____t_result_65 = s.player
            end
            ____call_70(
                ____m_ghosts_69,
                "push",
                {
                    x = ____e_x_67,
                    y = ____e_y_68,
                    face = ____t_66(____t_result_65) and -1 or 1,
                    life = 0.22
                }
            )
            m.ghostT = 0.045
            if __gt(
                __len(m.ghosts),
                5
            ) then
                __call(m.ghosts, "shift")
            end
        end
        for ____, g in __iterar((m.ghosts)) do
            g.life = g.life - dt
        end
        m.ghosts = __call(
            m.ghosts,
            "filter",
            function(____, g) return __gt(g.life, 0) end
        )
        if __t(__lt(m.prevY, FLOOR - 12) and __ge(e.y, FLOOR - 1)) then
            __call(m.rings, "push", {
                x = e.x,
                y = FLOOR - 2,
                age = 0,
                life = 0.35,
                size = e.type == "giant" and 1.6 or 1,
                col = "#d8c7a4",
                dust = true
            })
            local ____opt_73 = window.SceneLife
            if ____opt_73 ~= nil then
                ____opt_73 = ____opt_73.burst
            end
            if ____opt_73 ~= nil then
                ____opt_73(
                    ____opt_73,
                    e.x,
                    FLOOR - 3,
                    "#cdbb95",
                    __t(full) and 10 or 4
                )
            end
        end
        m.prevY = e.y
        for ____, r in __iterar((m.rings)) do
            r.age = __add(r.age, dt)
        end
        m.rings = __call(
            m.rings,
            "filter",
            function(____, r) return __lt(r.age, r.life) end
        )
    end
    local function transform(self, e, player)
        local ____t_78 = __t
        local ____t_result_77
        local ____t_76 = __t
        local ____temp_75 = not __t(e) or __le(e.hp, 0)
        __O[1571] = ____temp_75
        if ____t_76(____temp_75) then
            ____t_result_77 = __O[1571]
        else
            ____t_result_77 = e.state == "underground"
        end
        if ____t_78(____t_result_77) then
            return nil
        end
        local m = state(nil, e)
        local ____t_80 = __t
        local ____t_result_79
        if __t(player) then
            ____t_result_79 = __lt(player.x, e.x)
        else
            ____t_result_79 = player
        end
        local face = ____t_80(____t_result_79) and -1 or 1
        local sx = 1
        local sy = 1
        local dx = 0
        local rot = 0
        local py = 0
        if __t(e.type == "igor" and not __t(lite(nil))) then
            local ____t_result_81
            if __t(e.igorScale) then
                ____t_result_81 = e.igorScale
            else
                ____t_result_81 = 1
            end
            local sc = ____t_result_81
            local function jig(____, k, f)
                return math.sin(k * f) * math.exp(__TS__Number(-k) * 7)
            end
            py = 46 * sc
            if __t(e.state == "windup" and e.kind == "bellyBounce") then
                local ____t_result_82
                if __t(e.stateTimer) then
                    ____t_result_82 = e.stateTimer
                else
                    ____t_result_82 = 0
                end
                local ____t_result_83
                if __t(e.windupDuration) then
                    ____t_result_83 = e.windupDuration
                else
                    ____t_result_83 = 1
                end
                local k = clamp(nil, 1 - ____t_result_82 / ____t_result_83, 0, 1)
                sy = 1 - 0.2 * k
                sx = 1 + 0.16 * k
                dx = math.floor((math.random() - 0.5) * 3 * k + 0.5)
                return {
                    sx = sx,
                    sy = sy,
                    dx = dx,
                    rot = rot,
                    py = py
                }
            end
            if e.state == "bellyAir" then
                local ____t_result_84
                if __t(e.stateTimer) then
                    ____t_result_84 = e.stateTimer
                else
                    ____t_result_84 = 0
                end
                local ____t_result_85
                if __t(e.bellyDuration) then
                    ____t_result_85 = e.bellyDuration
                else
                    ____t_result_85 = 1
                end
                local k = clamp(nil, 1 - ____t_result_84 / ____t_result_85, 0, 1)
                local ____t_result_90
                local ____t_89 = __t
                local ____t_result_86
                if __t(e.bellyTo) then
                    ____t_result_86 = e.bellyTo
                else
                    ____t_result_86 = e.x
                end
                local ____t_result_87
                if __t(e.bellyFrom) then
                    ____t_result_87 = e.bellyFrom
                else
                    ____t_result_87 = e.x
                end
                local ____TS__MathSign_result_88 = __TS__MathSign(____t_result_86 - ____t_result_87)
                __O[1572] = ____TS__MathSign_result_88
                if ____t_89(____TS__MathSign_result_88) then
                    ____t_result_90 = __O[1572]
                else
                    ____t_result_90 = 1
                end
                local dir = ____t_result_90
                local ____ = dir
                if k < 0.25 then
                    sy = 1.18 - k * 0.7
                    sx = 0.88 + k * 0.45
                elseif k > 0.75 then
                    sy = 1.1
                    sx = 0.93
                end
                return {
                    sx = sx,
                    sy = sy,
                    dx = dx,
                    rot = rot,
                    py = py
                }
            end
            if __t(m.landed ~= nil and __lt(m.landed, 0.6)) then
                local k = m.landed
                sy = 1 - 0.3 * math.exp(__TS__Number(-k) * 9) + jig(nil, k, 30) * 0.08
                sx = 1 + 0.3 * math.exp(__TS__Number(-k) * 9) - jig(nil, k, 30) * 0.08
                return {
                    sx = sx,
                    sy = sy,
                    dx = dx,
                    rot = rot,
                    py = py
                }
            end
            if e.state == "bellyRolling" then
                sx = 1.05
                sy = 0.96
            else
                local ____t_94 = __t
                local ____t_result_93
                local ____t_92 = __t
                local ____temp_91 = e.state == "firing" and m.clap ~= nil
                __O[1573] = ____temp_91
                if ____t_92(____temp_91) then
                    ____t_result_93 = __lt(m.clap, 0.5)
                else
                    ____t_result_93 = __O[1573]
                end
                if ____t_94(____t_result_93) then
                    local k = m.clap
                    sx = 1 + 0.18 * math.exp(__TS__Number(-k) * 8) + jig(nil, k, 34) * 0.06
                    sy = 1 - 0.12 * math.exp(__TS__Number(-k) * 8)
                    return {
                        sx = sx,
                        sy = sy,
                        dx = dx,
                        rot = rot,
                        py = py
                    }
                elseif __t(e.state == "idle" or e.state == "recover") then
                    local b = math.sin(window.performance:now() / 380) * 0.02
                    sx = 1 + b
                    sy = 1 - b * 0.6
                end
            end
        end
        if e.state == "windup" then
            local ____t_result_95
            if __t(e.stateTimer) then
                ____t_result_95 = e.stateTimer
            else
                ____t_result_95 = 0
            end
            local ____t_result_96
            if __t(e.windupDuration) then
                ____t_result_96 = e.windupDuration
            else
                ____t_result_96 = 1
            end
            local k = clamp(nil, 1 - ____t_result_95 / ____t_result_96, 0, 1)
            sy = 1 - 0.07 * k
            sx = 1 + 0.05 * k
            dx = -face * math.floor(k * 2 + 0.5)
        elseif e.state == "dashing" then
            sx = 1.07
            sy = 0.95
        elseif __t(e.state == "firing" and __lt(m.age, 0.14)) then
            dx = -face * math.floor((1 - m.age / 0.14) * 4 + 0.5)
            sy = 1.03
            sx = 0.98
        end
        if __t(__gt(e.hit, 0) and not __t(lite(nil))) then
            dx = dx + math.floor((math.random() - 0.5) * 4 + 0.5)
        end
        local ____t_102 = __t
        local ____t_result_101
        local ____t_100 = __t
        local ____t_result_99
        local ____t_98 = __t
        local ____temp_97 = sx == 1 and sy == 1
        __O[1574] = ____temp_97
        if ____t_98(____temp_97) then
            ____t_result_99 = dx == 0
        else
            ____t_result_99 = __O[1574]
        end
        __O[1575] = ____t_result_99
        if ____t_100(____t_result_99) then
            ____t_result_101 = not __t(rot)
        else
            ____t_result_101 = __O[1575]
        end
        if ____t_102(____t_result_101) then
            return nil
        end
        return {
            sx = sx,
            sy = sy,
            dx = dx,
            rot = rot,
            py = py
        }
    end
    local function drawBack(self, c, e, t)
        if __t(not __t(e) or __le(e.hp, 0)) then
            return
        end
        local m = __call(mem, "get", e)
        if not __t(m) then
            return
        end
        local col = color(nil, e)
        local full = not __t(lite(nil))
        local ____t_106 = __t
        local ____t_result_105
        if __t(full) then
            local ____opt_103 = window.CharDetail
            if ____opt_103 ~= nil then
                ____opt_103 = ____opt_103.original
            end
            ____t_result_105 = ____opt_103
        else
            ____t_result_105 = full
        end
        if ____t_106(____t_result_105) then
            for ____, g in __iterar((m.ghosts)) do
                c:save()
                c.globalAlpha = g.life / 0.22 * 0.28
                local ____self_114 = window.CharDetail
                local ____self_114_original_115 = ____self_114.original
                local ____array_113 = __TS__SparseArrayNew(c, e.type, g.x, g.y)
                local ____g_face_109 = g.face
                local ____t_110 = t
                local ____ge_result_111 = __ge(g.y, FLOOR - 1)
                local ____e_phase_112 = e.phase
                local ____t_108 = __t
                local ____t_result_107
                if __t(e.rage) then
                    ____t_result_107 = e.type == "marco"
                else
                    ____t_result_107 = e.rage
                end
                __TS__SparseArrayPush(
                    ____array_113,
                    {
                        facing = ____g_face_109,
                        frame = ____t_110,
                        dash = true,
                        moving = true,
                        grounded = ____ge_result_111,
                        bossPhase = ____e_phase_112,
                        scale = ____t_108(____t_result_107) and 1.4 or 1
                    }
                )
                ____self_114_original_115(
                    ____self_114,
                    __TS__SparseArraySpread(____array_113)
                )
                c:restore()
            end
        end
        if e.state == "windup" then
            local ____t_result_116
            if __t(e.stateTimer) then
                ____t_result_116 = e.stateTimer
            else
                ____t_result_116 = 0
            end
            local ____t_result_117
            if __t(e.windupDuration) then
                ____t_result_117 = e.windupDuration
            else
                ____t_result_117 = 1
            end
            local k = clamp(nil, 1 - ____t_result_116 / ____t_result_117, 0, 1)
            local pulse = 0.5 + 0.5 * math.sin(t * 20)
            c:save()
            c.globalAlpha = 0.25 + 0.35 * k * pulse
            c.fillStyle = col
            local w = 26 + k * 22
            do
                local i = -w
                while i <= w do
                    local h = math.floor(math.sqrt(math.max(0, 1 - (i / w) ^ 2)) * 4 + 0.5)
                    c:fillRect(
                        math.floor(e.x + i + 0.5),
                        FLOOR - h,
                        3,
                        h * 2
                    )
                    i = i + 3
                end
            end
            c:restore()
        end
        local ____t_123 = __t
        local ____t_result_122
        local ____t_121 = __t
        local ____t_result_120
        local ____t_119 = __t
        local ____temp_118 = e.type == "igor" and m.landed ~= nil
        __O[1576] = ____temp_118
        if ____t_119(____temp_118) then
            ____t_result_120 = __lt(m.landed, 1.1)
        else
            ____t_result_120 = __O[1576]
        end
        __O[1577] = ____t_result_120
        if ____t_121(____t_result_120) then
            ____t_result_122 = m.crackX ~= nil
        else
            ____t_result_122 = __O[1577]
        end
        if ____t_123(____t_result_122) then
            local a = 1 - m.landed / 1.1
            c:save()
            c.globalAlpha = a
            c.fillStyle = "#3a2a1e"
            do
                local i = 0
                while i < 9 do
                    local ang = math.pi + i / 8 * math.pi
                    local len = 26 + __mod(i * 37, 40)
                    local x = m.crackX
                    local y = FLOOR - 1
                    do
                        local k = 0
                        while k < len do
                            x = x + (math.cos(ang) * 4 + (__mod(i * 13 + k, 3) - 1))
                            y = FLOOR - 1 + math.sin(ang) * k * 0.08
                            c:fillRect(
                                math.floor(x + 0.5),
                                math.floor(y + 0.5),
                                3,
                                2
                            )
                            k = k + 4
                        end
                    end
                    i = i + 1
                end
            end
            c:restore()
        end
        local ____t_127 = __t
        local ____t_result_126
        local ____t_125 = __t
        local ____temp_124 = e.type == "igor" and e.state == "bellyRolling"
        __O[1578] = ____temp_124
        if ____t_125(____temp_124) then
            ____t_result_126 = full
        else
            ____t_result_126 = __O[1578]
        end
        if ____t_127(____t_result_126) then
            c:save()
            c.globalAlpha = 0.5
            c.fillStyle = "#fff4d4"
            do
                local i = 0
                while i < 6 do
                    local yy = e.y - 20 - i * 14
                    local len = 30 + __mod(i * 23, 40)
                    local ____c_130 = c
                    local ____c_fillRect_131 = c.fillRect
                    local ____e_x_129 = e.x
                    local ____t_result_128
                    if __t(e.dashDir) then
                        ____t_result_128 = e.dashDir
                    else
                        ____t_result_128 = 1
                    end
                    ____c_fillRect_131(
                        ____c_130,
                        math.floor(____e_x_129 - ____t_result_128 * (60 + len) + 0.5),
                        yy,
                        len,
                        2
                    )
                    i = i + 1
                end
            end
            c:restore()
        end
        for ____, r in __iterar((m.rings)) do
            if __t(r.dust) then
                local k = r.age / r.life
                local w = (20 + k * 60) * r.size
                c:save()
                c.globalAlpha = (1 - k) * 0.7
                c.fillStyle = r.col
                do
                    local i = -8
                    while i <= 8 do
                        c:fillRect(
                            math.floor(r.x + i / 8 * w + 0.5),
                            math.floor(r.y - math.cos(i / 8 * math.pi / 2) * 6 * (1 - k) + 0.5),
                            3,
                            2
                        )
                        i = i + 1
                    end
                end
                c:restore()
            end
        end
    end
    local function drawFront(self, c, e, t)
        if __t(not __t(e) or __le(e.hp, 0)) then
            return
        end
        local m = __call(mem, "get", e)
        if not __t(m) then
            return
        end
        local col = color(nil, e)
        for ____, p in __iterar((m.motes)) do
            c.globalAlpha = clamp(nil, p.life * 3, 0, 1)
            R(
                nil,
                c,
                p.x,
                p.y,
                3,
                3,
                col
            )
            R(
                nil,
                c,
                p.x + 1,
                p.y + 1,
                1,
                1,
                "#ffffff"
            )
        end
        c.globalAlpha = 1
        for ____, r in __iterar((m.rings)) do
            if not __t(r.dust) then
                local k = r.age / r.life
                local rad = 8 + k * 26
                c:save()
                c.globalAlpha = 1 - k
                c.fillStyle = "#fff6d8"
                do
                    local i = 0
                    while i < 8 do
                        local a = i / 8 * math.pi * 2
                        local ____array_133 = __TS__SparseArrayNew(
                            nil,
                            c,
                            r.x + math.cos(a) * rad - 2,
                            r.y + math.sin(a) * rad - 2,
                            4,
                            4
                        )
                        local ____t_result_132
                        if __t(__mod(i, 2)) then
                            ____t_result_132 = col
                        else
                            ____t_result_132 = "#fff6d8"
                        end
                        __TS__SparseArrayPush(____array_133, ____t_result_132)
                        R(__TS__SparseArraySpread(____array_133))
                        i = i + 1
                    end
                end
                R(
                    nil,
                    c,
                    r.x - 5,
                    r.y - 5,
                    10,
                    10,
                    col
                )
                c:restore()
            end
        end
        if e.state == "recover" then
            local y = headY(nil, e) - 6
            do
                local i = 0
                while i < 3 do
                    local a = t * 5 + i * 2.09
                    local x = e.x + math.cos(a) * 18
                    local yy = y + math.sin(a) * 5
                    local s = math.sin(a) > 0 and 2 or 1
                    c.fillStyle = "#ffe36b"
                    c:fillRect(
                        math.floor(x + 0.5) - s,
                        math.floor(yy + 0.5),
                        s * 2 + 1,
                        1
                    )
                    c:fillRect(
                        math.floor(x + 0.5),
                        math.floor(yy + 0.5) - s,
                        1,
                        s * 2 + 1
                    )
                    i = i + 1
                end
            end
        end
    end
    local function drawShotTrails(self, c, shots)
        if __t(lite(nil)) then
            return
        end
        for ____, s in __iterar((shots)) do
            local mine = s.owner ~= "enemy"
            local tr = __call(shotTrails, "get", s)
            if not __t(tr) then
                tr = __arrL({}, 0)
                __call(shotTrails, "set", s, tr)
            end
            __call(
                tr,
                "push",
                __arrL({s.x, s.y}, 2)
            )
            if __gt(
                __len(tr),
                6
            ) then
                __call(tr, "shift")
            end
            do
                local i = 0
                while i < __len(tr) - 1 do
                    local a = (i + 1) / __len(tr)
                    c.globalAlpha = a * 0.45
                    local z = math.max(
                        2,
                        math.floor(a * 6 + 0.5)
                    )
                    local ____c_135 = c
                    local ____t_result_134
                    if __t(mine) then
                        ____t_result_134 = s.element == "electric" and "#a9e7f4" or (s.element == "fire" and "#ffb064" or "#fff6e0")
                    else
                        ____t_result_134 = __t(s.enraged) and "#ff8a7a" or "#fff1c4"
                    end
                    ____c_135.fillStyle = ____t_result_134
                    c:fillRect(
                        math.floor(__get(
                            __get(tr, i),
                            0
                        ) - z / 2 + 0.5),
                        math.floor(__get(
                            __get(tr, i),
                            1
                        ) - z / 2 + 0.5),
                        z,
                        z
                    )
                    i = i + 1
                end
            end
        end
        c.globalAlpha = 1
    end
    local function igorPose(self, e)
        local ____t_139 = __t
        local ____t_result_138
        local ____t_137 = __t
        local ____temp_136 = not __t(e) or e.type ~= "igor"
        __O[1579] = ____temp_136
        if ____t_137(____temp_136) then
            ____t_result_138 = __O[1579]
        else
            ____t_result_138 = lite(nil)
        end
        if ____t_139(____t_result_138) then
            return nil
        end
        local m = state(nil, e)
        if __t(e.state == "windup" and e.kind == "bellyBounce") then
            local ____t_result_140
            if __t(e.stateTimer) then
                ____t_result_140 = e.stateTimer
            else
                ____t_result_140 = 0
            end
            local ____t_result_141
            if __t(e.windupDuration) then
                ____t_result_141 = e.windupDuration
            else
                ____t_result_141 = 1
            end
            return {
                pose = "crouch",
                k = clamp(nil, 1 - ____t_result_140 / ____t_result_141, 0, 1)
            }
        end
        if e.state == "bellyAir" then
            local ____t_result_142
            if __t(e.stateTimer) then
                ____t_result_142 = e.stateTimer
            else
                ____t_result_142 = 0
            end
            local ____t_result_143
            if __t(e.bellyDuration) then
                ____t_result_143 = e.bellyDuration
            else
                ____t_result_143 = 1
            end
            local k = clamp(nil, 1 - ____t_result_142 / ____t_result_143, 0, 1)
            return {pose = k < 0.45 and "rise" or (k < 0.8 and "fall" or "land"), k = k}
        end
        if __t(m.landed ~= nil and __lt(m.landed, 0.3)) then
            return {pose = "land", k = 1}
        end
        return nil
    end
    window.BossFx = __ord({
        update = update,
        transform = transform,
        drawBack = drawBack,
        drawFront = drawFront,
        drawShotTrails = drawShotTrails,
        igorPose = igorPose
    }, "update,transform,drawBack,drawFront,drawShotTrails,igorPose")
end)(nil)
return ____exports
