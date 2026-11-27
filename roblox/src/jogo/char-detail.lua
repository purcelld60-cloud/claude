--!native
--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __gt, __mod, __ord, __arrL, __t, __get, __call, __add, __assign, __hypot = __JSR.__lt, __JSR.__gt, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__t, __JSR.__get, __JSR.__call, __JSR.__add, __JSR.__assign, __JSR.__hypot
local ____lualib = require(script.Parent.lualib_bundle)
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local Map = ____lualib.Map
local __TS__Number = ____lualib.__TS__Number
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local ____t_2 = __t
    local ____t_1 = __t
    local ____temp_0 = not __t(window.Art) or not __t(window.Art.drawCharacter)
    __O[658] = ____temp_0
    if ____t_2(if ____t_1(____temp_0) then __O[658] else window.CharDetail) then
        return
    end
    local original = window.Art.drawCharacter
    local W = 200
    local H = 230
    local OX = 100
    local OY = 196
    local function make()
        local c = window.document:createElement("canvas")
        c.width = W
        c.height = H
        local x = c:getContext("2d")
        x.imageSmoothingEnabled = false
        return __arrL({c, x}, 2)
    end
    local spriteC, sprite = table.unpack(
        make(nil),
        1,
        2
    )
    local tintC, tint = table.unpack(
        make(nil),
        1,
        2
    )
    local outC, out = table.unpack(
        make(nil),
        1,
        2
    )
    local SKIP = __TS__New(
        Set,
        __arrL({"giant", "dede"}, 2)
    )
    local enabled = true
    local CACHE = __TS__New(Map)
    local function tinted(self, color)
        tint.globalCompositeOperation = "source-over"
        tint:clearRect(0, 0, W, H)
        tint:drawImage(spriteC, 0, 0)
        tint.globalCompositeOperation = "source-in"
        tint.fillStyle = color
        tint:fillRect(0, 0, W, H)
        tint.globalCompositeOperation = "source-over"
        return tintC
    end
    local function detailed(self, c, ____type, x, y, o)
        if o == nil then
            o = {}
        end
        local ____t_18 = __t
        local ____t_17 = __t
        local ____t_15 = __t
        local ____t_13 = __t
        local ____t_11 = __t
        local ____t_4 = __t
        local ____temp_3 = not __t(enabled)
        __O[659] = ____temp_3
        local ____opt_7 = window.Graphics
        if ____opt_7 ~= nil then
            ____opt_7 = ____opt_7.isLite
        end
        local ____opt_result_9
        if ____opt_7 ~= nil then
            ____opt_result_9 = ____opt_7(____opt_7)
        end
        local ____temp_10 = if ____t_4(____temp_3) then __O[659] else ____opt_result_9
        __O[660] = ____temp_10
        local ____temp_12 = if ____t_11(____temp_10) then __O[660] else __call(SKIP, "has", ____type)
        __O[661] = ____temp_12
        local ____temp_14 = if ____t_13(____temp_12) then __O[661] else ____type == "nikolas" and __TS__Number(o.bossPhase) >= 2
        __O[662] = ____temp_14
        local ____temp_16 = if ____t_15(____temp_14) then __O[662] else ____type == "reeisBoss"
        __O[663] = ____temp_16
        if ____t_18(if ____t_17(____temp_16) then __O[663] else if __t(o.transformed) then ____type == "reeis" else o.transformed) then
            return original(
                nil,
                c,
                ____type,
                x,
                y,
                o
            )
        end
        local m
        do
            local function ____catch(e)
                return true, original(
                    nil,
                    c,
                    ____type,
                    x,
                    y,
                    o
                )
            end
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                m = c:getTransform()
            end)
            if not ____try then
                ____hasReturned, ____returnValue = ____catch(____hasReturned)
            end
            if ____hasReturned then
                return ____returnValue
            end
        end
        local scale = __hypot(m.a, m.b) * if __t(o.scale) then o.scale else 1
        if scale < 0.55 then
            return original(
                nil,
                c,
                ____type,
                x,
                y,
                o
            )
        end
        local sx = m.a * x + m.c * y + m.e
        local ____t_21 = __t
        local ____opt_19 = c.canvas
        if ____opt_19 ~= nil then
            ____opt_19 = ____opt_19.width
        end
        __O[664] = ____opt_19
        local cw = if ____t_21(____opt_19) then __O[664] else 960
        if __t(__lt(sx, -260) or __gt(sx, cw + 260)) then
            return
        end
        if __gt(if __t(o.scale) then o.scale else 1, 1.25) then
            return original(
                nil,
                c,
                ____type,
                x,
                y,
                o
            )
        end
        local ____t_30 = __t
        local ____t_29 = __t
        local ____t_27 = __t
        local ____t_25 = __t
        local ____t_23 = __t
        local ____temp_22 = if __t(o.cache) then math.abs(m.a - 1) < 0.01 else o.cache
        __O[665] = ____temp_22
        local ____temp_24 = if ____t_23(____temp_22) then math.abs(m.d - 1) < 0.01 else __O[665]
        __O[666] = ____temp_24
        local ____temp_26 = if ____t_25(____temp_24) then not __t(m.b) else __O[666]
        __O[667] = ____temp_26
        local ____temp_28 = if ____t_27(____temp_26) then not __t(m.c) else __O[667]
        __O[668] = ____temp_28
        local ck = if ____t_30(if ____t_29(____temp_28) then not __t(o.hit) else __O[668]) then __add(
            __add(
                __add(
                    __add(
                        __add(
                            __add(____type, "|"),
                            if __lt(if __t(o.facing) then o.facing else 1, 0) then -1 else 1
                        ),
                        "|"
                    ),
                    __mod(
                        __mod(
                            math.floor(if __t(o.frame) then o.frame else 0 * 3),
                            6
                        ) + 6,
                        6
                    )
                ),
                "|"
            ),
            if __t(o.scale) then o.scale else 1
        ) else nil
        if __t(ck) then
            local hit = __call(CACHE, "get", ck)
            if __t(hit) then
                c:save()
                c.imageSmoothingEnabled = false
                c:drawImage(
                    hit.cv,
                    math.floor(x + 0.5) - OX + hit.x0,
                    math.floor(y + 0.5) - OY + hit.y0
                )
                c:restore()
                return
            end
            o = __assign(
                {},
                o,
                {frame = math.floor(if __t(o.frame) then o.frame else 0 * 3) / 3}
            )
        end
        sprite:setTransform(
            1,
            0,
            0,
            1,
            0,
            0
        )
        sprite.globalAlpha = 1
        sprite.globalCompositeOperation = "source-over"
        sprite:clearRect(0, 0, W, H)
        original(
            nil,
            sprite,
            ____type,
            OX,
            OY,
            o
        )
        sprite.globalCompositeOperation = "source-atop"
        local g = sprite:createLinearGradient(0, OY - 110, 0, OY)
        g:addColorStop(0, "rgba(255,244,214,.10)")
        g:addColorStop(0.45, "rgba(0,0,0,0)")
        g:addColorStop(1, "rgba(24,18,28,.20)")
        sprite.fillStyle = g
        sprite:fillRect(0, 0, W, H)
        local face = if __lt(if __t(o.facing) then o.facing else 1, 0) then -1 else 1
        local key = sprite:createRadialGradient(
            OX + face * 16,
            OY - 96,
            4,
            OX + face * 16,
            OY - 96,
            92
        )
        key:addColorStop(0, "rgba(255,238,204,.24)")
        key:addColorStop(0.55, "rgba(255,230,190,.07)")
        key:addColorStop(1, "rgba(255,230,190,0)")
        sprite.fillStyle = key
        sprite:fillRect(0, 0, W, H)
        local back = sprite:createLinearGradient(OX - face * 26, 0, OX + face * 6, 0)
        back:addColorStop(0, "rgba(18,14,34,.26)")
        back:addColorStop(1, "rgba(18,14,34,0)")
        sprite.fillStyle = back
        sprite:fillRect(0, 0, W, H)
        sprite.globalCompositeOperation = "source-over"
        out.globalCompositeOperation = "source-over"
        out:clearRect(0, 0, W, H)
        do
            local cs = out:createRadialGradient(
                OX,
                OY,
                2,
                OX,
                OY,
                30
            )
            cs:addColorStop(0, "rgba(10,12,8,.32)")
            cs:addColorStop(1, "rgba(10,12,8,0)")
            out:save()
            out:translate(0, OY)
            out:scale(1, 0.22)
            out:translate(0, -OY)
            out.fillStyle = cs
            out:fillRect(OX - 32, OY - 32, 64, 64)
            out:restore()
        end
        local ink = tinted(nil, "#1b1714")
        out.globalAlpha = 0.9
        out:drawImage(ink, -1, 0)
        out:drawImage(ink, 1, 0)
        out:drawImage(ink, 0, -1)
        out:drawImage(ink, 0, 1)
        out.globalAlpha = 1
        out:drawImage(spriteC, 0, 0)
        local rim = tinted(nil, "#fff3cf")
        tint.globalCompositeOperation = "destination-out"
        tint:drawImage(spriteC, 0, 2)
        tint.globalCompositeOperation = "source-over"
        out.globalAlpha = 0.38
        out:drawImage(rim, 0, 0)
        local sh = tinted(nil, "#120c18")
        tint.globalCompositeOperation = "destination-out"
        tint:drawImage(spriteC, 0, -2)
        tint.globalCompositeOperation = "source-over"
        out.globalAlpha = 0.32
        out:drawImage(sh, 0, 0)
        out.globalAlpha = 1
        c:save()
        c.imageSmoothingEnabled = false
        c:drawImage(
            outC,
            math.floor(x + 0.5) - OX,
            math.floor(y + 0.5) - OY
        )
        c:restore()
        if __t(ck) then
            do
                pcall(function()
                    local d = out:getImageData(0, 0, W, H).data
                    local x0 = W
                    local y0 = H
                    local x1 = -1
                    local y1 = -1
                    do
                        local yy = 0
                        while yy < H do
                            do
                                local xx = 0
                                while xx < W do
                                    if __gt(
                                        __get(d, (yy * W + xx) * 4 + 3),
                                        8
                                    ) then
                                        if xx < x0 then
                                            x0 = xx
                                        end
                                        if xx > x1 then
                                            x1 = xx
                                        end
                                        if yy < y0 then
                                            y0 = yy
                                        end
                                        if yy > y1 then
                                            y1 = yy
                                        end
                                    end
                                    xx = xx + 1
                                end
                            end
                            yy = yy + 1
                        end
                    end
                    if x1 >= x0 then
                        local cv = window.document:createElement("canvas")
                        cv.width = x1 - x0 + 1
                        cv.height = y1 - y0 + 1
                        cv:getContext("2d"):drawImage(outC, -x0, -y0)
                        __call(CACHE, "set", ck, {cv = cv, x0 = x0, y0 = y0})
                        if CACHE.size > 260 then
                            __call(
                                CACHE,
                                "delete",
                                __call(CACHE, "keys"):next().value
                            )
                        end
                    end
                end)
            end
        end
    end
    window.Art.drawCharacter = detailed
    window.CharDetail = __ord(
        {
            setEnabled = function(____, v)
                enabled = not not __t(v)
            end,
            original = original
        },
        "setEnabled,original"
    )
end)(nil)
return ____exports
