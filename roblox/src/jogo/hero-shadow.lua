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
        local ____t_5 = __t
        local ____opt_2 = window.HdMaps
        if ____opt_2 ~= nil then
            ____opt_2 = ____opt_2.sun
        end
        local ____opt_result_4
        if ____opt_2 ~= nil then
            ____opt_result_4 = ____opt_2(____opt_2)
        end
        __O[331] = ____opt_result_4
        local s = if ____t_5(____opt_result_4) then __O[331] else {lean = 0.3, str = 0.8}
        local ____t_14 = __t
        local ____opt_10 = window.Weather
        if ____opt_10 ~= nil then
            ____opt_10 = ____opt_10.state
        end
        local ____opt_result_12
        if ____opt_10 ~= nil then
            ____opt_result_12 = ____opt_10(____opt_10)
        end
        local ____opt_result_13
        if ____opt_result_12 ~= nil then
            ____opt_result_13 = ____opt_result_12.rain
        end
        __O[332] = ____opt_result_13
        local rain = if ____t_14(____opt_result_13) then __O[332] else 0
        local ____t_23 = __t
        local ____opt_19 = window.Weather
        if ____opt_19 ~= nil then
            ____opt_19 = ____opt_19.state
        end
        local ____opt_result_21
        if ____opt_19 ~= nil then
            ____opt_result_21 = ____opt_19(____opt_19)
        end
        local ____opt_result_22
        if ____opt_result_21 ~= nil then
            ____opt_result_22 = ____opt_result_21.snow
        end
        __O[333] = ____opt_result_22
        local snow = if ____t_23(____opt_result_22) then __O[333] else 0
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
            local dir = if __lt(k, 0) then -1 else 1
            local down = if __lt(d, 0) then math.abs(d) * 40 else 0
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
        local ____t_26 = __t
        local ____t_25 = __t
        local ____temp_24 = if __t(L.indoor) then not __t(__get(OUTDOOR, o.scene)) else L.indoor
        __O[334] = ____temp_24
        local ____t_32 = __t
        local ____opt_29 = window.HdMaps
        if ____opt_29 ~= nil then
            ____opt_29 = ____opt_29.lightsAt
        end
        local ____opt_result_31
        if ____opt_29 ~= nil then
            ____opt_result_31 = ____opt_29(____opt_29, o.scene, o.x)
        end
        __O[335] = ____opt_result_31
        local lamps = if __t(if __t(o.arena) then o.arena else o.room) then __arrL({}, 0) else if ____t_26(if ____t_25(____temp_24) then __O[334] else not __t(L.indoor)) then if ____t_32(____opt_result_31) then __O[335] else __arrL({}, 0) else __arrL({}, 0)
        lastLamps = lamps
        local k = if __t(L.indoor) then L.lean else L.lean * (0.4 + 0.74 * math.abs(L.lean))
        local d = if __t(L.indoor) then 0.16 else 0.14 + 0.07 * (1 - math.min(
            1,
            math.abs(L.lean)
        ))
        local lampSum = __call(
            lamps,
            "reduce",
            function(____, s2, l) return __add(s2, l.a) end,
            0
        )
        local a = if __gt(L.str, 0.02) then 0.26 + 0.4 * clamp(nil, L.str, 0, 1) else 0 * lift * if __t(if __t(L.indoor) then __gt(lampSum, 0.2) else L.indoor) then 0.35 else 1
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
        local ca = math.max(a, if __t(__len(lamps)) then math.min(
            0.6,
            __get(lamps, 0).a
        ) else 0) * 0.9 * clamp(nil, 1 - h / 90, 0, 1)
        if ca > 0.01 then
            g.globalAlpha = ca
            local cx = (o.x - ox) / 2
            local w = if __t(o.vehicle) then 30 else 13 * clamp(nil, 1 - h / 200, 0.5, 1)
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
            local ____t_38 = __t
            local ____opt_35 = window.HdMaps
            if ____opt_35 ~= nil then
                ____opt_35 = ____opt_35.shadeAt
            end
            local ____opt_result_37
            if ____opt_35 ~= nil then
                ____opt_result_37 = ____opt_35(____opt_35, o.scene, o.x)
            end
            __O[336] = ____opt_result_37
            local r = if ____t_38(____opt_result_37) then __O[336] else {k = 0}
            k = r.k * math.min(1, L.str)
            leaves = r.leaves
        end
        if __t(o.platforms) then
            for ____, p in __iterar((o.platforms)) do
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
                        if __t(L.indoor) then 0.4 else 0.55 * math.min(1, L.str + 0.2) * clamp(nil, edge / 18, 0, 1) * clamp(
                            nil,
                            1 - math.max(0, gap) / 150,
                            0,
                            1
                        )
                    )
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
            local side = if __ge(L.lean, 0) then -1 else 1
            local s = math.min(
                1,
                math.abs(L.lean) * 1.3 + 0.25
            ) * math.min(1, L.str) * (1 - shadeNow)
            local grd = c:createLinearGradient(FX - 22, 0, FX + 22, 0)
            local lit = ("rgba(255,236,190," .. tostring(0.16 * s)) .. ")"
            local dark = ("rgba(24,30,60," .. tostring(0.2 * s)) .. ")"
            grd:addColorStop(0, if side < 0 then lit else dark)
            grd:addColorStop(0.5, "rgba(0,0,0,0)")
            grd:addColorStop(1, if side < 0 then dark else lit)
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
                local side = if __gt(l.k, 0) then -1 else 1
                local s2 = math.min(1, l.a)
                local grd = c:createLinearGradient(FX - 22, 0, FX + 22, 0)
                local lit = ("rgba(255,226,160," .. tostring(0.22 * s2)) .. ")"
                grd:addColorStop(0, if side < 0 then lit else "rgba(0,0,0,0)")
                grd:addColorStop(0.55, "rgba(0,0,0,0)")
                grd:addColorStop(1, if side < 0 then "rgba(0,0,0,0)" else lit)
                c.fillStyle = grd
                c:fillRect(0, 0, FW, FH)
            end
        end
        if shadeNow > 0.02 then
            c.fillStyle = ("rgba(18,30,52," .. tostring(0.42 * shadeNow)) .. ")"
            c:fillRect(0, 0, FW, FH)
            if __t(if __t(sh.leaves) then shadeNow > 0.2 else sh.leaves) then
                local t = if __t(o.time) then o.time else 0
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
        local t = if __t(o.time) then o.time else 0
        local dt = math.max(
            0,
            math.min(0.1, t - lastT)
        )
        lastT = t
        local ____t_41 = __t
        local ____t_40 = __t
        local ____temp_39 = not __t(L.indoor) and not __t(o.room)
        __O[337] = ____temp_39
        local ____t_47 = __t
        local ____opt_44 = window.Weather
        if ____opt_44 ~= nil then
            ____opt_44 = ____opt_44.state
        end
        local ____opt_result_46
        if ____opt_44 ~= nil then
            ____opt_result_46 = ____opt_44(____opt_44)
        end
        __O[338] = ____opt_result_46
        local wx = if ____t_41(if ____t_40(____temp_39) then not __t(o.arena) else __O[337]) then if ____t_47(____opt_result_46) then __O[338] else {} else {}
        local cover = if shadeNow > 0.45 then 0.3 else 1
        wet = math.max(
            0,
            math.min(1, wet + if __gt(if __t(wx.rain) then wx.rain else 0, 0.15) then dt * 0.18 * wx.rain * cover else -dt * 0.025 * (1 + L.str))
        )
        snowy = math.max(
            0,
            math.min(1, snowy + if __gt(if __t(wx.snow) then wx.snow else 0, 0.15) then dt * 0.08 * wx.snow * cover else -dt * 0.05)
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
            if __t(__gt(d.life, 0) and __lt(d.y, if __t(o.floor) then o.floor else 440)) then
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
            function(____, d) return __gt(d.life, 0) and __lt(d.y, if __t(o.floor) then o.floor else 440) end
        )
    end
    local function draw(self, ctx, o)
        local ____t_55 = __t
        local ____t_49 = __t
        local ____temp_48 = not __t(o) or type(o.draw) ~= "function"
        __O[339] = ____temp_48
        local ____opt_52 = window.Graphics
        if ____opt_52 ~= nil then
            ____opt_52 = ____opt_52.isLite
        end
        local ____opt_result_54
        if ____opt_52 ~= nil then
            ____opt_result_54 = ____opt_52(____opt_52)
        end
        if ____t_55(if ____t_49(____temp_48) then __O[339] else ____opt_result_54) then
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
