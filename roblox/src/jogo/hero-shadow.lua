--!native
--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __gt, __ge, __mod, __ord, __arrL, __iterar, __t, __get, __len, __call, __add = __JSR.__lt, __JSR.__gt, __JSR.__ge, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__len, __JSR.__call, __JSR.__add
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local __TS__Iterator = ____lualib.__TS__Iterator
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    if __t(window.HeroShadow) then
        return
    end
    local OUTDOOR = {
        ["0"] = 1,
        ["1"] = 1,
        ["3"] = 1,
        ["4"] = 1,
        ["5"] = 1,
        ["7"] = 1,
        ["9"] = 1
    }
    local function clamp(____, v, a, b)
        return math.max(
            a,
            math.min(b, v)
        )
    end
    local function mk(____, w, h)
        local c = window.document:createElement("canvas")
        c.width = w
        c.height = h
        return c
    end
    local FW = 260
    local FH = 240
    local FX = 130
    local FY = 210
    local fig = nil
    local sil = nil
    local layer = nil
    local shadeNow = 0
    local lastLamps = __arrL({}, 0)
    local wet = 0
    local snowy = 0
    local lastT = 0
    local drips = __arrL({}, 0)
    local rimCv = nil
    local function rimMask(self)
        if not __t(rimCv) then
            rimCv = mk(nil, FW, FH)
        end
        local r = rimCv:getContext("2d")
        r.globalCompositeOperation = "source-over"
        r:clearRect(0, 0, FW, FH)
        r:drawImage(fig, 0, 0)
        r.globalCompositeOperation = "destination-out"
        r:drawImage(fig, 0, 3)
        r.globalCompositeOperation = "source-over"
        return rimCv
    end
    local function light(self, o)
        if __t(o.room) then
            return {lean = 0.12, str = 0.5, indoor = true}
        end
        if __t(not __t(__get(OUTDOOR, o.scene)) and not __t(o.arena)) then
            return {lean = 0.1, str = 0.5, indoor = true}
        end
        local ____t_result_6
        local ____t_5 = __t
        local ____opt_2 = window.HdMaps
        if ____opt_2 ~= nil then
            ____opt_2 = ____opt_2.sun
        end
        local ____opt_result_4
        if ____opt_2 ~= nil then
            ____opt_result_4 = ____opt_2(____opt_2)
        end
        __O[341] = ____opt_result_4
        if ____t_5(____opt_result_4) then
            ____t_result_6 = __O[341]
        else
            ____t_result_6 = {lean = 0.3, str = 0.8}
        end
        local s = ____t_result_6
        local ____t_result_16
        local ____t_15 = __t
        local ____opt_11 = window.Weather
        if ____opt_11 ~= nil then
            ____opt_11 = ____opt_11.state
        end
        local ____opt_result_13
        if ____opt_11 ~= nil then
            ____opt_result_13 = ____opt_11(____opt_11)
        end
        local ____opt_result_14
        if ____opt_result_13 ~= nil then
            ____opt_result_14 = ____opt_result_13.rain
        end
        __O[342] = ____opt_result_14
        if ____t_15(____opt_result_14) then
            ____t_result_16 = __O[342]
        else
            ____t_result_16 = 0
        end
        local rain = ____t_result_16
        local ____t_result_26
        local ____t_25 = __t
        local ____opt_21 = window.Weather
        if ____opt_21 ~= nil then
            ____opt_21 = ____opt_21.state
        end
        local ____opt_result_23
        if ____opt_21 ~= nil then
            ____opt_result_23 = ____opt_21(____opt_21)
        end
        local ____opt_result_24
        if ____opt_result_23 ~= nil then
            ____opt_result_24 = ____opt_result_23.snow
        end
        __O[343] = ____opt_result_24
        if ____t_25(____opt_result_24) then
            ____t_result_26 = __O[343]
        else
            ____t_result_26 = 0
        end
        local snow = ____t_result_26
        return {lean = s.lean, str = s.str * (1 - rain * 0.6) * (1 - snow * 0.3), indoor = false}
    end
    local function paintFigure(self, o)
        if not __t(fig) then
            fig = mk(nil, FW, FH)
        end
        local c = fig:getContext("2d")
        c:setTransform(
            1,
            0,
            0,
            1,
            0,
            0
        )
        c:clearRect(0, 0, FW, FH)
        c.imageSmoothingEnabled = false
        o:draw(c, FX, FY)
        return fig
    end
    local function silhouette(self)
        if not __t(sil) then
            sil = mk(nil, FW, FH)
        end
        local c = sil:getContext("2d")
        c.globalCompositeOperation = "source-over"
        c:clearRect(0, 0, FW, FH)
        c:drawImage(fig, 0, 0)
        c.globalCompositeOperation = "source-in"
        c.fillStyle = "rgb(18,30,52)"
        c:fillRect(0, 0, FW, FH)
        c.globalCompositeOperation = "source-over"
        return sil
    end
    local tmp = nil
    local function cast(self, g, k, d, a, ex, ey, fade)
        local LWd = layer.width
        local LHd = layer.height
        if not __t(tmp) then
            tmp = mk(nil, LWd, LHd)
        end
        local tg = tmp:getContext("2d")
        tg:setTransform(
            1,
            0,
            0,
            1,
            0,
            0
        )
        tg:clearRect(0, 0, LWd, LHd)
        tg.imageSmoothingEnabled = false
        tg.globalCompositeOperation = "source-over"
        tg:setTransform(
            0.5,
            0,
            __TS__Number(-k) * 0.5,
            d * 0.5,
            ex,
            ey
        )
        tg:drawImage(sil, -FX, -FY)
        tg:setTransform(
            1,
            0,
            0,
            1,
            0,
            0
        )
        if __gt(fade, 0) then
            local len = math.abs(k) * 40 + 10
            local dir = __lt(k, 0) and -1 or 1
            local ____lt_result_27
            if __lt(d, 0) then
                ____lt_result_27 = math.abs(d) * 40
            else
                ____lt_result_27 = 0
            end
            local down = ____lt_result_27
            local gr = tg:createLinearGradient(ex, ey, ex + dir * len, ey + down)
            gr:addColorStop(0, "rgba(0,0,0,1)")
            gr:addColorStop(
                1,
                ("rgba(0,0,0," .. tostring(1 - fade)) .. ")"
            )
            tg.globalCompositeOperation = "destination-in"
            tg.fillStyle = gr
            tg:fillRect(0, 0, LWd, LHd)
            tg.globalCompositeOperation = "source-over"
        end
        g.globalAlpha = clamp(nil, a, 0, 1)
        g:drawImage(tmp, 0, 0)
        g.globalAlpha = 1
    end
    local function ground(self, ctx, o, L)
        if __t(o.floor == nil or o.floor == nil) then
            return
        end
        local h = math.max(0, o.floor - o.y)
        local lift = clamp(nil, 1 - h / 260, 0.2, 1)
        local ____t_result_42
        local ____t_29 = __t
        local ____t_result_28
        if __t(o.arena) then
            ____t_result_28 = o.arena
        else
            ____t_result_28 = o.room
        end
        if ____t_29(____t_result_28) then
            ____t_result_42 = __arrL({}, 0)
        else
            local ____t_result_41
            local ____t_33 = __t
            local ____t_result_32
            local ____t_31 = __t
            local ____t_result_30
            if __t(L.indoor) then
                ____t_result_30 = not __t(__get(OUTDOOR, o.scene))
            else
                ____t_result_30 = L.indoor
            end
            __O[344] = ____t_result_30
            if ____t_31(____t_result_30) then
                ____t_result_32 = __O[344]
            else
                ____t_result_32 = not __t(L.indoor)
            end
            if ____t_33(____t_result_32) then
                local ____t_result_40
                local ____t_39 = __t
                local ____opt_36 = window.HdMaps
                if ____opt_36 ~= nil then
                    ____opt_36 = ____opt_36.lightsAt
                end
                local ____opt_result_38
                if ____opt_36 ~= nil then
                    ____opt_result_38 = ____opt_36(____opt_36, o.scene, o.x)
                end
                __O[345] = ____opt_result_38
                if ____t_39(____opt_result_38) then
                    ____t_result_40 = __O[345]
                else
                    ____t_result_40 = __arrL({}, 0)
                end
                ____t_result_41 = ____t_result_40
            else
                ____t_result_41 = __arrL({}, 0)
            end
            ____t_result_42 = ____t_result_41
        end
        local lamps = ____t_result_42
        lastLamps = lamps
        local ____t_result_43
        if __t(L.indoor) then
            ____t_result_43 = L.lean
        else
            ____t_result_43 = L.lean * (0.4 + 0.74 * math.abs(L.lean))
        end
        local k = ____t_result_43
        local d = __t(L.indoor) and 0.16 or 0.14 + 0.07 * (1 - math.min(
            1,
            math.abs(L.lean)
        ))
        local lampSum = __call(
            lamps,
            "reduce",
            function(____, s2, l) return __add(s2, l.a) end,
            0
        )
        local ____gt_result_44
        if __gt(L.str, 0.02) then
            ____gt_result_44 = 0.26 + 0.4 * clamp(nil, L.str, 0, 1)
        else
            ____gt_result_44 = 0
        end
        local ____temp_47 = ____gt_result_44 * lift
        local ____t_46 = __t
        local ____t_result_45
        if __t(L.indoor) then
            ____t_result_45 = __gt(lampSum, 0.2)
        else
            ____t_result_45 = L.indoor
        end
        local a = ____temp_47 * (____t_46(____t_result_45) and 0.35 or 1)
        if __t(a < 0.02 and not __t(__len(lamps))) then
            return
        end
        local LWd = 300
        local LHd = 80
        if not __t(layer) then
            layer = mk(nil, LWd, LHd)
        end
        local g = layer:getContext("2d")
        g:setTransform(
            1,
            0,
            0,
            1,
            0,
            0
        )
        g:clearRect(0, 0, LWd, LHd)
        g.imageSmoothingEnabled = false
        local ox = math.floor((o.x - 300) / 2 + 0.5) * 2
        local oy = math.floor((o.floor - 100) / 2 + 0.5) * 2
        local ey = (o.floor - oy) / 2
        if a >= 0.02 then
            cast(
                nil,
                g,
                k,
                d,
                a,
                (o.x + k * h - ox) / 2,
                ey,
                0
            )
        end
        for ____, l in __iterar((lamps)) do
            do
                local la = math.min(0.8, l.a * 1.8) * lift
                if la < 0.03 then
                    continue
                end
                cast(
                    nil,
                    g,
                    l.k * 0.9,
                    -0.3,
                    la,
                    (o.x + l.k * h - ox) / 2,
                    ey,
                    l.fade
                )
            end
        end
        local ____t_result_48
        if __t(__len(lamps)) then
            ____t_result_48 = math.min(
                0.6,
                __get(lamps, 0).a
            )
        else
            ____t_result_48 = 0
        end
        local ca = math.max(a, ____t_result_48) * 0.9 * clamp(nil, 1 - h / 90, 0, 1)
        if ca > 0.01 then
            g.globalAlpha = ca
            local cx = (o.x - ox) / 2
            local w = (__t(o.vehicle) and 30 or 13) * clamp(nil, 1 - h / 200, 0.5, 1)
            g.fillStyle = "rgb(18,30,52)"
            g:fillRect(
                math.floor(cx - w + 0.5),
                math.floor(ey + 0.5) - 1,
                math.floor(w * 2 + 0.5),
                2
            )
            g:fillRect(
                math.floor(cx - w * 0.7 + 0.5),
                math.floor(ey + 0.5),
                math.floor(w * 1.4 + 0.5),
                1
            )
            g.globalAlpha = 1
        end
        ctx:save()
        ctx.imageSmoothingEnabled = false
        ctx:drawImage(
            layer,
            ox,
            oy,
            LWd * 2,
            LHd * 2
        )
        ctx:restore()
    end
    local function shadeOn(self, o, L)
        local k = 0
        local leaves = false
        if __t(not __t(L.indoor) and __gt(L.str, 0.04)) then
            local ____t_result_55
            local ____t_54 = __t
            local ____opt_51 = window.HdMaps
            if ____opt_51 ~= nil then
                ____opt_51 = ____opt_51.shadeAt
            end
            local ____opt_result_53
            if ____opt_51 ~= nil then
                ____opt_result_53 = ____opt_51(____opt_51, o.scene, o.x)
            end
            __O[346] = ____opt_result_53
            if ____t_54(____opt_result_53) then
                ____t_result_55 = __O[346]
            else
                ____t_result_55 = {k = 0}
            end
            local r = ____t_result_55
            k = r.k * math.min(1, L.str)
            leaves = r.leaves
        end
        if __t(o.platforms) then
            for ____, p in __iterar((o.platforms)) do
                do
                    if __t(__lt(
                        o.x,
                        __get(p, 0) - 6
                    ) or __gt(
                        o.x,
                        __add(
                            __get(p, 0),
                            __get(p, 2)
                        ) + 6
                    )) then
                        continue
                    end
                    local gap = o.y - 70 - __get(p, 1)
                    if __t(__lt(
                        __get(p, 1),
                        o.y - 40
                    ) and gap < 150) then
                        local edge = math.min(
                            o.x - __get(p, 0),
                            __add(
                                __get(p, 0),
                                __get(p, 2)
                            ) - o.x
                        ) + 6
                        k = math.max(
                            k,
                            (__t(L.indoor) and 0.4 or 0.55 * math.min(1, L.str + 0.2)) * clamp(nil, edge / 18, 0, 1) * clamp(
                                nil,
                                1 - math.max(0, gap) / 150,
                                0,
                                1
                            )
                        )
                    end
                end
            end
        end
        return {
            k = clamp(nil, k, 0, 1),
            leaves = leaves
        }
    end
    local function body(self, ctx, o, L)
        local c = fig:getContext("2d")
        local sh = shadeOn(nil, o, L)
        shadeNow = shadeNow + (sh.k - shadeNow) * 0.25
        c:save()
        c.globalCompositeOperation = "source-atop"
        if __t(not __t(L.indoor) and __gt(L.str, 0.05)) then
            local side = __ge(L.lean, 0) and -1 or 1
            local s = math.min(
                1,
                math.abs(L.lean) * 1.3 + 0.25
            ) * math.min(1, L.str) * (1 - shadeNow)
            local grd = c:createLinearGradient(FX - 22, 0, FX + 22, 0)
            local lit = ("rgba(255,236,190," .. tostring(0.16 * s)) .. ")"
            local dark = ("rgba(24,30,60," .. tostring(0.2 * s)) .. ")"
            local ____grd_addColorStop_57 = grd.addColorStop
            local ____temp_56
            if side < 0 then
                ____temp_56 = lit
            else
                ____temp_56 = dark
            end
            ____grd_addColorStop_57(grd, 0, ____temp_56)
            grd:addColorStop(0.5, "rgba(0,0,0,0)")
            local ____grd_addColorStop_59 = grd.addColorStop
            local ____temp_58
            if side < 0 then
                ____temp_58 = dark
            else
                ____temp_58 = lit
            end
            ____grd_addColorStop_59(grd, 1, ____temp_58)
            c.fillStyle = grd
            c:fillRect(0, 0, FW, FH)
        end
        do
            local l = __call(
                lastLamps,
                "find",
                function(____, x) return x.lx ~= nil and __gt(x.a, 0.12) end
            )
            if __t(l) then
                local side = __gt(l.k, 0) and -1 or 1
                local s2 = math.min(1, l.a)
                local grd = c:createLinearGradient(FX - 22, 0, FX + 22, 0)
                local lit = ("rgba(255,226,160," .. tostring(0.22 * s2)) .. ")"
                local ____grd_addColorStop_61 = grd.addColorStop
                local ____temp_60
                if side < 0 then
                    ____temp_60 = lit
                else
                    ____temp_60 = "rgba(0,0,0,0)"
                end
                ____grd_addColorStop_61(grd, 0, ____temp_60)
                grd:addColorStop(0.55, "rgba(0,0,0,0)")
                grd:addColorStop(1, side < 0 and "rgba(0,0,0,0)" or lit)
                c.fillStyle = grd
                c:fillRect(0, 0, FW, FH)
            end
        end
        if shadeNow > 0.02 then
            c.fillStyle = ("rgba(18,30,52," .. tostring(0.42 * shadeNow)) .. ")"
            c:fillRect(0, 0, FW, FH)
            local ____t_63 = __t
            local ____t_result_62
            if __t(sh.leaves) then
                ____t_result_62 = shadeNow > 0.2
            else
                ____t_result_62 = sh.leaves
            end
            if ____t_63(____t_result_62) then
                local ____t_result_64
                if __t(o.time) then
                    ____t_result_64 = o.time
                else
                    ____t_result_64 = 0
                end
                local t = ____t_result_64
                c.fillStyle = ("rgba(255,236,170," .. tostring(0.3 * shadeNow)) .. ")"
                do
                    local i = 0
                    while i < 7 do
                        local x = FX - 20 + __mod(
                            __mod(
                                i * 13 + math.sin(t * 1.3 + i * 2.1) * 6 + o.x * 0.15,
                                40
                            ) + 40,
                            40
                        )
                        local y = FY - 78 + __mod(
                            __mod(
                                i * 23 + math.cos(t * 0.9 + i) * 5,
                                74
                            ) + 74,
                            74
                        )
                        c:fillRect(
                            math.floor(x / 2 + 0.5) * 2,
                            math.floor(y / 2 + 0.5) * 2,
                            4,
                            2
                        )
                        c:fillRect(
                            math.floor(x / 2 + 0.5) * 2 + 2,
                            math.floor(y / 2 + 0.5) * 2 + 2,
                            2,
                            2
                        )
                        i = i + 1
                    end
                end
            end
        end
        c:restore()
        local ____t_result_65
        if __t(o.time) then
            ____t_result_65 = o.time
        else
            ____t_result_65 = 0
        end
        local t = ____t_result_65
        local dt = math.max(
            0,
            math.min(0.1, t - lastT)
        )
        lastT = t
        local ____t_result_77
        local ____t_69 = __t
        local ____t_result_68
        local ____t_67 = __t
        local ____temp_66 = not __t(L.indoor) and not __t(o.room)
        __O[347] = ____temp_66
        if ____t_67(____temp_66) then
            ____t_result_68 = not __t(o.arena)
        else
            ____t_result_68 = __O[347]
        end
        if ____t_69(____t_result_68) then
            local ____t_result_76
            local ____t_75 = __t
            local ____opt_72 = window.Weather
            if ____opt_72 ~= nil then
                ____opt_72 = ____opt_72.state
            end
            local ____opt_result_74
            if ____opt_72 ~= nil then
                ____opt_result_74 = ____opt_72(____opt_72)
            end
            __O[348] = ____opt_result_74
            if ____t_75(____opt_result_74) then
                ____t_result_76 = __O[348]
            else
                ____t_result_76 = {}
            end
            ____t_result_77 = ____t_result_76
        else
            ____t_result_77 = {}
        end
        local wx = ____t_result_77
        local cover = shadeNow > 0.45 and 0.3 or 1
        local ____wet_81 = wet
        local ____gt_result_80
        local ____gt_79 = __gt
        local ____t_result_78
        if __t(wx.rain) then
            ____t_result_78 = wx.rain
        else
            ____t_result_78 = 0
        end
        if ____gt_79(____t_result_78, 0.15) then
            ____gt_result_80 = dt * 0.18 * wx.rain * cover
        else
            ____gt_result_80 = -dt * 0.025 * (1 + L.str)
        end
        wet = math.max(
            0,
            math.min(1, ____wet_81 + ____gt_result_80)
        )
        local ____snowy_85 = snowy
        local ____gt_result_84
        local ____gt_83 = __gt
        local ____t_result_82
        if __t(wx.snow) then
            ____t_result_82 = wx.snow
        else
            ____t_result_82 = 0
        end
        if ____gt_83(____t_result_82, 0.15) then
            ____gt_result_84 = dt * 0.08 * wx.snow * cover
        else
            ____gt_result_84 = -dt * 0.05
        end
        snowy = math.max(
            0,
            math.min(1, ____snowy_85 + ____gt_result_84)
        )
        if __t(wet > 0.02 or snowy > 0.02) then
            local rim = rimMask(nil)
            c:save()
            c.globalCompositeOperation = "source-atop"
            if wet > 0.02 then
                c.fillStyle = ("rgba(16,26,52," .. tostring(0.24 * wet)) .. ")"
                c:fillRect(0, 0, FW, FH)
                c.globalAlpha = 0.55 * wet
                c:drawImage(rim, 0, 1)
                c.globalAlpha = 1
            end
            c:restore()
            if wet > 0.02 then
                local g = rim:getContext("2d")
                g.globalCompositeOperation = "source-in"
                g.fillStyle = ("rgba(215,232,255," .. tostring(0.5 * wet)) .. ")"
                g:fillRect(0, 0, FW, FH)
                g.globalCompositeOperation = "source-over"
                c:drawImage(rim, 0, 0)
            end
            if snowy > 0.02 then
                local rim2 = rimMask(nil)
                local g = rim2:getContext("2d")
                g.globalCompositeOperation = "source-in"
                g.fillStyle = ("rgba(250,252,255," .. tostring(math.min(1, snowy * 1.2))) .. ")"
                g:fillRect(0, 0, FW, FH)
                g.globalCompositeOperation = "source-over"
                c:drawImage(rim2, 0, -1)
                c:drawImage(rim2, 0, 0)
            end
        end
        ctx:save()
        ctx.imageSmoothingEnabled = false
        ctx:drawImage(
            fig,
            math.floor(o.x + 0.5) - FX,
            math.floor(o.y + 0.5) - FY
        )
        ctx:restore()
        if __t(wet > 0.25 and math.random() < wet * 0.5) then
            __call(
                drips,
                "push",
                {
                    x = o.x + (math.random() - 0.5) * 30,
                    y = o.y - 30 - math.random() * 30,
                    vy = 40,
                    life = 0.8
                }
            )
        end
        if __len(drips) > 30 then
            __call(
                drips,
                "splice",
                0,
                __len(drips) - 30
            )
        end
        ctx:save()
        for ____, d in __iterar((drips)) do
            d.life = d.life - dt
            d.vy = d.vy + 600 * dt
            d.y = d.y + d.vy * dt
            local ____t_90 = __t
            local ____gt_result_89 = __gt(d.life, 0)
            if ____gt_result_89 then
                local ____lt_88 = __lt
                local ____d_y_87 = d.y
                local ____t_result_86
                if __t(o.floor) then
                    ____t_result_86 = o.floor
                else
                    ____t_result_86 = 440
                end
                ____gt_result_89 = ____lt_88(____d_y_87, ____t_result_86)
            end
            if ____t_90(____gt_result_89) then
                ctx.fillStyle = ("rgba(200,222,255," .. tostring(math.min(1, d.life * 1.5) * 0.8)) .. ")"
                ctx:fillRect(
                    math.floor(d.x / 2 + 0.5) * 2,
                    math.floor(d.y / 2 + 0.5) * 2,
                    2,
                    4
                )
            end
        end
        ctx:restore()
        drips = __call(
            drips,
            "filter",
            function(____, d)
                local ____gt_result_94 = __gt(d.life, 0)
                if ____gt_result_94 then
                    local ____lt_93 = __lt
                    local ____d_y_92 = d.y
                    local ____t_result_91
                    if __t(o.floor) then
                        ____t_result_91 = o.floor
                    else
                        ____t_result_91 = 440
                    end
                    ____gt_result_94 = ____lt_93(____d_y_92, ____t_result_91)
                end
                return ____gt_result_94
            end
        )
    end
    local function draw(self, ctx, o)
        local ____t_103 = __t
        local ____t_result_102
        local ____t_96 = __t
        local ____temp_95 = not __t(o) or type(o.draw) ~= "function"
        __O[349] = ____temp_95
        if ____t_96(____temp_95) then
            ____t_result_102 = __O[349]
        else
            local ____opt_99 = window.Graphics
            if ____opt_99 ~= nil then
                ____opt_99 = ____opt_99.isLite
            end
            local ____opt_result_101
            if ____opt_99 ~= nil then
                ____opt_result_101 = ____opt_99(____opt_99)
            end
            ____t_result_102 = ____opt_result_101
        end
        if ____t_103(____t_result_102) then
            return false
        end
        do
            local function ____catch(e)
                window.__heroShadowError = e
                return true, false
            end
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                local L = light(nil, o)
                paintFigure(nil, o)
                silhouette(nil)
                ground(nil, ctx, o, L)
                body(nil, ctx, o, L)
                return true, true
            end)
            if not ____try then
                ____hasReturned, ____returnValue = ____catch(____hasReturned)
            end
            if ____hasReturned then
                return ____returnValue
            end
        end
    end
    window.HeroShadow = __ord(
        {
            draw = draw,
            shade = function() return shadeNow end,
            wet = function() return wet end,
            snowy = function() return snowy end
        },
        "draw,shade,wet,snowy"
    )
end)(nil)
return ____exports
