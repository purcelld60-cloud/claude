--!native
--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __mod, __arrL, __iterar, __t, __get, __set, __len, __call, __arrayFrom = __JSR.__mod, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__len, __JSR.__call, __JSR.__arrayFrom
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__Number = ____lualib.__TS__Number
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local ____t_3 = __t
    local ____t_result_2
    local ____t_1 = __t
    local ____temp_0 = not __t(window.Cinematics)
    __O[1569] = ____temp_0
    if ____t_1(____temp_0) then
        ____t_result_2 = __O[1569]
    else
        ____t_result_2 = window.CinemaFx
    end
    if ____t_3(____t_result_2) then
        return
    end
    local orig = window.Cinematics.draw
    local function clamp(____, v, a, b)
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
    local function smooth(____, v)
        v = clamp(nil, v)
        return v * v * (3 - 2 * v)
    end
    local function lite()
        local ____t_9 = __t
        local ____opt_6 = window.Graphics
        if ____opt_6 ~= nil then
            ____opt_6 = ____opt_6.isLite
        end
        local ____opt_result_8
        if ____opt_6 ~= nil then
            ____opt_result_8 = ____opt_6(____opt_6)
        end
        return not not ____t_9(____opt_result_8)
    end
    local calm = (function()
        do
            local function ____catch(e)
                return true, false
            end
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                return true, window:matchMedia("(prefers-reduced-motion: reduce)").matches
            end)
            if not ____try then
                ____hasReturned, ____returnValue = ____catch(____hasReturned)
            end
            if ____hasReturned then
                return ____returnValue
            end
        end
    end)(nil)
    local grainFrames = __arrL({}, 0)
    do
        local f = 0
        while f < 4 do
            local g = window.document:createElement("canvas")
            g.width = 240
            g.height = 135
            local x = g:getContext("2d")
            local img = x:createImageData(240, 135)
            do
                local i = 0
                while i < __len(img.data) do
                    local v = math.random() * 255
                    __set(
                        img.data,
                        i,
                        __set(
                            img.data,
                            i + 1,
                            __set(img.data, i + 2, v)
                        )
                    )
                    __set(
                        img.data,
                        i + 3,
                        math.random() < 0.5 and 22 or 0
                    )
                    i = i + 4
                end
            end
            x:putImageData(img, 0, 0)
            __call(grainFrames, "push", g)
            f = f + 1
        end
    end
    local motes = __arrayFrom(
        {length = 40},
        function(____, _, i) return {
            x = math.random(),
            y = math.random(),
            s = 0.3 + math.random() * 0.7,
            p = math.random() * 6
        } end
    )
    local function radial(self, c, x, y, r, color, alpha, mode)
        if mode == nil then
            mode = "screen"
        end
        local g = c:createRadialGradient(
            x,
            y,
            1,
            x,
            y,
            r
        )
        g:addColorStop(
            0,
            __call(color, "replace", "A", alpha)
        )
        g:addColorStop(
            1,
            __call(color, "replace", "A", 0)
        )
        c:save()
        c.globalCompositeOperation = mode
        c.fillStyle = g
        c:fillRect(x - r, y - r, r * 2, r * 2)
        c:restore()
    end
    local function spot(self, c, x, top, bottomW, alpha, t)
        c:save()
        c.globalCompositeOperation = "screen"
        local g = c:createLinearGradient(0, top, 0, 540)
        g:addColorStop(
            0,
            ("rgba(255,226,176," .. tostring(alpha)) .. ")"
        )
        g:addColorStop(1, "rgba(255,226,176,0)")
        c.fillStyle = g
        c:beginPath()
        c:moveTo(x - 40, top)
        c:lineTo(x + 40, top)
        c:lineTo(x + bottomW / 2, 540)
        c:lineTo(x - bottomW / 2, 540)
        c:closePath()
        __call(c, "fill")
        for ____, m in __iterar((motes)) do
            local mx = x + (m.x - 0.5) * bottomW * (0.3 + m.y * 0.7)
            local my = top + __mod(m.y * 540 + t * 8 * m.s, 540)
            local a = 0.25 + 0.25 * math.sin(t * 2 + m.p)
            c.fillStyle = ("rgba(255,236,200," .. tostring(a * alpha * 4)) .. ")"
            c:fillRect(
                math.floor(mx + math.sin(t * 0.7 + m.p) * 6 + 0.5),
                math.floor(my + 0.5),
                2,
                2
            )
        end
        c:restore()
    end
    local function grain(self, c, t, strength)
        c:save()
        c.globalAlpha = strength
        c.globalCompositeOperation = "overlay"
        c.imageSmoothingEnabled = false
        c:drawImage(
            __get(
                grainFrames,
                __mod(
                    math.floor(t * 24),
                    4
                )
            ),
            0,
            0,
            960,
            540
        )
        c:restore()
    end
    local function jorgeLight(self, c, shot, st, dur, total)
        local k = clamp(nil, st / dur)
        local pulse = 0.5 + 0.5 * math.sin(st * 9)
        repeat
            local ____switch21 = shot
            local ____cond21 = ____switch21 == "afterglow" or ____switch21 == "empty"
            if ____cond21 then
                spot(
                    nil,
                    c,
                    480,
                    -20,
                    620,
                    0.13,
                    total
                )
                radial(
                    nil,
                    c,
                    380,
                    160,
                    360,
                    "rgba(255,190,130,A)",
                    0.14,
                    "soft-light"
                )
                radial(
                    nil,
                    c,
                    640,
                    320,
                    360,
                    "rgba(60,80,160,A)",
                    0.2,
                    "soft-light"
                )
                break
            end
            ____cond21 = ____cond21 or ____switch21 == "vibration"
            if ____cond21 then
                radial(
                    nil,
                    c,
                    410,
                    330,
                    220,
                    "rgba(140,170,255,A)",
                    0.16 + 0.18 * math.abs(math.sin(st * 22)),
                    "screen"
                )
                break
            end
            ____cond21 = ____cond21 or ____switch21 == "reach"
            if ____cond21 then
                radial(
                    nil,
                    c,
                    620,
                    330,
                    260 + 40 * k,
                    "rgba(140,170,255,A)",
                    0.28 * smooth(nil, k * 1.4),
                    "screen"
                )
                break
            end
            ____cond21 = ____cond21 or ____switch21 == "caller"
            if ____cond21 then
                radial(
                    nil,
                    c,
                    482,
                    280,
                    340,
                    "rgba(130,160,255,A)",
                    0.3,
                    "screen"
                )
                radial(
                    nil,
                    c,
                    482,
                    280,
                    120,
                    "rgba(255,255,255,A)",
                    0.08 + 0.05 * pulse,
                    "screen"
                )
                break
            end
            ____cond21 = ____cond21 or ____switch21 == "recognition"
            if ____cond21 then
                radial(
                    nil,
                    c,
                    480,
                    600,
                    520,
                    "rgba(110,150,255,A)",
                    0.26,
                    "screen"
                )
                radial(
                    nil,
                    c,
                    480,
                    270,
                    520,
                    "rgba(10,10,30,A)",
                    0.25 * pulse,
                    "multiply"
                )
                break
            end
            ____cond21 = ____cond21 or ____switch21 == "tremor"
            if ____cond21 then
                do
                    local beat = math.max(
                        0,
                        math.sin(st * 7.5)
                    ) ^ 6
                    radial(
                        nil,
                        c,
                        760,
                        480,
                        380,
                        "rgba(120,150,255,A)",
                        0.3,
                        "screen"
                    )
                    c:save()
                    c.globalAlpha = 0.18 * beat
                    c.fillStyle = "#3a0010"
                    c:fillRect(0, 0, 960, 540)
                    c:restore()
                    break
                end
            end
            ____cond21 = ____cond21 or (____switch21 == "falling" or ____switch21 == "kneeling")
            if ____cond21 then
                local ____spot_13 = spot
                local ____c_11 = c
                local ____temp_12 = -40
                local ____temp_10
                if shot == "kneeling" then
                    ____temp_10 = 0.1 * (1 - smooth(nil, (st - 2.4) / 3.1))
                else
                    ____temp_10 = 0.12
                end
                ____spot_13(
                    nil,
                    ____c_11,
                    470,
                    ____temp_12,
                    380,
                    ____temp_10,
                    total
                )
                radial(
                    nil,
                    c,
                    722,
                    470,
                    160,
                    "rgba(120,150,255,A)",
                    0.22 + 0.1 * pulse,
                    "screen"
                )
                break
            end
            ____cond21 = ____cond21 or ____switch21 == "eyes"
            if ____cond21 then
                do
                    radial(
                        nil,
                        c,
                        480,
                        200,
                        520,
                        "rgba(150,70,255,A)",
                        0.22 + 0.1 * math.sin(st * 3),
                        "screen"
                    )
                    local ____t_result_16
                    local ____t_15 = __t
                    local ____temp_14 = __mod(st, 3.3) < 0.09
                    __O[1570] = ____temp_14
                    if ____t_15(____temp_14) then
                        ____t_result_16 = __O[1570]
                    else
                        ____t_result_16 = __mod(st, 3.3) > 0.18 and __mod(st, 3.3) < 0.24
                    end
                    local flash = ____t_result_16
                    local ____t_18 = __t
                    local ____t_result_17
                    if __t(flash) then
                        ____t_result_17 = not __t(calm)
                    else
                        ____t_result_17 = flash
                    end
                    if ____t_18(____t_result_17) then
                        c:save()
                        c.globalAlpha = 0.22
                        c.fillStyle = "#b48cff"
                        c:fillRect(0, 0, 960, 540)
                        c:restore()
                    end
                    c:save()
                    c.globalCompositeOperation = "screen"
                    do
                        local i = 0
                        while i < 6 do
                            local y = 420 + i * 18
                            local a = 0.05 + 0.03 * math.sin(st + i)
                            local g = c:createLinearGradient(0, y, 0, y + 40)
                            g:addColorStop(0, "rgba(120,80,180,0)")
                            g:addColorStop(
                                0.5,
                                ("rgba(120,80,180," .. tostring(a)) .. ")"
                            )
                            g:addColorStop(1, "rgba(120,80,180,0)")
                            c.fillStyle = g
                            c:fillRect(
                                __mod(
                                    st * 20 * (__t(__mod(i, 2)) and 1 or -1),
                                    200
                                ) - 200,
                                y,
                                1400,
                                40
                            )
                            i = i + 1
                        end
                    end
                    c:restore()
                    break
                end
            end
        until true
    end
    local function draw(self, c, s)
        local ____t_22 = __t
        local ____t_result_21
        local ____t_20 = __t
        local ____temp_19 = not __t(c) or not __t(s)
        __O[1571] = ____temp_19
        if ____t_20(____temp_19) then
            ____t_result_21 = __O[1571]
        else
            ____t_result_21 = lite(nil)
        end
        if ____t_22(____t_result_21) then
            return orig(nil, c, s)
        end
        local jorge = s.kind == "jorge_epilogue"
        local ____t_24 = __t
        local ____t_result_23
        if __t(jorge) then
            ____t_result_23 = window.JorgeAnime
        else
            ____t_result_23 = jorge
        end
        if ____t_24(____t_result_23) then
            window.JorgeAnime:draw(c, s)
            c.fillStyle = "#000"
            c:fillRect(0, 0, 960, 26)
            c:fillRect(0, 514, 960, 26)
            local ____grain_29 = grain
            local ____c_28 = c
            local ____t_result_27
            local ____t_26 = __t
            local ____TS__Number_result_25 = __TS__Number(s.elapsed)
            __O[1572] = ____TS__Number_result_25
            if ____t_26(____TS__Number_result_25) then
                ____t_result_27 = __O[1572]
            else
                ____t_result_27 = 0
            end
            ____grain_29(nil, ____c_28, ____t_result_27, 0.45)
            return
        end
        local ____t_result_35
        if __t(jorge) then
            local ____opt_32 = window.JorgeEpilogue
            if ____opt_32 ~= nil then
                ____opt_32 = ____opt_32.beat
            end
            local ____opt_result_34
            if ____opt_32 ~= nil then
                ____opt_result_34 = ____opt_32(____opt_32, s)
            end
            ____t_result_35 = ____opt_result_34
        else
            ____t_result_35 = nil
        end
        local b = ____t_result_35
        local ____opt_result_38
        if b ~= nil then
            ____opt_result_38 = b.id
        end
        local shot = ____opt_result_38
        local ____t_result_41
        local ____t_40 = __t
        local ____TS__Number_result_39 = __TS__Number(s.time)
        __O[1573] = ____TS__Number_result_39
        if ____t_40(____TS__Number_result_39) then
            ____t_result_41 = __O[1573]
        else
            ____t_result_41 = 0
        end
        local st = ____t_result_41
        local ____t_result_46
        local ____t_45 = __t
        local ____opt_result_44
        if b ~= nil then
            ____opt_result_44 = b.duration
        end
        __O[1574] = ____opt_result_44
        if ____t_45(____opt_result_44) then
            ____t_result_46 = __O[1574]
        else
            ____t_result_46 = 8
        end
        local dur = ____t_result_46
        local ____t_result_49
        local ____t_48 = __t
        local ____TS__Number_result_47 = __TS__Number(s.elapsed)
        __O[1575] = ____TS__Number_result_47
        if ____t_48(____TS__Number_result_47) then
            ____t_result_49 = __O[1575]
        else
            ____t_result_49 = st
        end
        local total = ____t_result_49
        local ____t_result_50
        if __t(jorge) then
            ____t_result_50 = clamp(nil, st / dur)
        else
            ____t_result_50 = __mod(st, 10) / 10
        end
        local k = ____t_result_50
        local zoom = 1.012 + (__t(jorge) and 0.03 or 0.02) * smooth(nil, k)
        local ____t_result_52
        if __t(calm) then
            ____t_result_52 = 0
        else
            local ____t_result_51
            if __t(jorge) then
                ____t_result_51 = shot == "tremor" and 3.2 or (shot == "recognition" and 2 or 1.1)
            else
                ____t_result_51 = 0.6
            end
            ____t_result_52 = ____t_result_51
        end
        local amp = ____t_result_52
        local hx = (math.sin(total * 1.3) + math.sin(total * 2.9) * 0.5) * amp
        local hy = (math.cos(total * 1.1) + math.sin(total * 3.7) * 0.4) * amp
        local rot = amp * 0.0012 * math.sin(total * 0.9)
        local py = __t(jorge) and 220 or 270
        c:save()
        c:translate(480 + hx, py + hy)
        c:rotate(rot)
        c:scale(zoom, zoom)
        c:translate(-480, -py)
        orig(nil, c, s)
        c:restore()
        if __t(jorge) then
            jorgeLight(
                nil,
                c,
                shot,
                st,
                dur,
                total
            )
            local bar = 26
            c.fillStyle = "#000"
            c:fillRect(0, 0, 960, bar)
            c:fillRect(0, 540 - bar, 960, bar)
            grain(nil, c, total, 0.55)
        else
            grain(nil, c, total, 0.3)
        end
    end
    window.Cinematics.draw = draw
    window.CinemaFx = {original = orig}
end)(nil)
return ____exports
