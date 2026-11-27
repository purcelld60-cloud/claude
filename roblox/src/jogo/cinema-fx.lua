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
    local ____t_2 = __t
    local ____t_1 = __t
    local ____temp_0 = not __t(window.Cinematics)
    __O[1535] = ____temp_0
    if ____t_2(if ____t_1(____temp_0) then __O[1535] else window.CinemaFx) then
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
        local ____t_8 = __t
        local ____opt_5 = window.Graphics
        if ____opt_5 ~= nil then
            ____opt_5 = ____opt_5.isLite
        end
        local ____opt_result_7
        if ____opt_5 ~= nil then
            ____opt_result_7 = ____opt_5(____opt_5)
        end
        return not not ____t_8(____opt_result_7)
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
                    __set(img.data, i + 3, if math.random() < 0.5 then 22 else 0)
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
                spot(
                    nil,
                    c,
                    470,
                    -40,
                    380,
                    if shot == "kneeling" then 0.1 * (1 - smooth(nil, (st - 2.4) / 3.1)) else 0.12,
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
                    local ____t_10 = __t
                    local ____temp_9 = __mod(st, 3.3) < 0.09
                    __O[1536] = ____temp_9
                    local flash = if ____t_10(____temp_9) then __O[1536] else __mod(st, 3.3) > 0.18 and __mod(st, 3.3) < 0.24
                    if __t(if __t(flash) then not __t(calm) else flash) then
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
                                __mod(st * 20 * if __t(__mod(i, 2)) then 1 else -1, 200) - 200,
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
        local ____t_13 = __t
        local ____t_12 = __t
        local ____temp_11 = not __t(c) or not __t(s)
        __O[1537] = ____temp_11
        if ____t_13(if ____t_12(____temp_11) then __O[1537] else lite(nil)) then
            return orig(nil, c, s)
        end
        local jorge = s.kind == "jorge_epilogue"
        if __t(if __t(jorge) then window.JorgeAnime else jorge) then
            window.JorgeAnime:draw(c, s)
            c.fillStyle = "#000"
            c:fillRect(0, 0, 960, 26)
            c:fillRect(0, 514, 960, 26)
            local ____grain_17 = grain
            local ____c_16 = c
            local ____t_15 = __t
            local ____TS__Number_result_14 = __TS__Number(s.elapsed)
            __O[1538] = ____TS__Number_result_14
            ____grain_17(nil, ____c_16, if ____t_15(____TS__Number_result_14) then __O[1538] else 0, 0.45)
            return
        end
        local ____opt_20 = window.JorgeEpilogue
        if ____opt_20 ~= nil then
            ____opt_20 = ____opt_20.beat
        end
        local ____opt_result_22
        if ____opt_20 ~= nil then
            ____opt_result_22 = ____opt_20(____opt_20, s)
        end
        local b = if __t(jorge) then ____opt_result_22 else nil
        local ____opt_result_25
        if b ~= nil then
            ____opt_result_25 = b.id
        end
        local shot = ____opt_result_25
        local ____t_27 = __t
        local ____TS__Number_result_26 = __TS__Number(s.time)
        __O[1539] = ____TS__Number_result_26
        local st = if ____t_27(____TS__Number_result_26) then __O[1539] else 0
        local ____t_31 = __t
        local ____opt_result_30
        if b ~= nil then
            ____opt_result_30 = b.duration
        end
        __O[1540] = ____opt_result_30
        local dur = if ____t_31(____opt_result_30) then __O[1540] else 8
        local ____t_33 = __t
        local ____TS__Number_result_32 = __TS__Number(s.elapsed)
        __O[1541] = ____TS__Number_result_32
        local total = if ____t_33(____TS__Number_result_32) then __O[1541] else st
        local k = if __t(jorge) then clamp(nil, st / dur) else __mod(st, 10) / 10
        local zoom = 1.012 + if __t(jorge) then 0.03 else 0.02 * smooth(nil, k)
        local amp = if __t(calm) then 0 else if __t(jorge) then if shot == "tremor" then 3.2 else if shot == "recognition" then 2 else 1.1 else 0.6
        local hx = (math.sin(total * 1.3) + math.sin(total * 2.9) * 0.5) * amp
        local hy = (math.cos(total * 1.1) + math.sin(total * 3.7) * 0.4) * amp
        local rot = amp * 0.0012 * math.sin(total * 0.9)
        local py = if __t(jorge) then 220 else 270
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
