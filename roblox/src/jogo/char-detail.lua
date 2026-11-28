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
    local ____t_3 = __t
    local ____t_result_2
    local ____t_1 = __t
    local ____temp_0 = not __t(window.Art) or not __t(window.Art.drawCharacter)
    __O[686] = ____temp_0
    if ____t_1(____temp_0) then
        ____t_result_2 = __O[686]
    else
        ____t_result_2 = window.CharDetail
    end
    if ____t_3(____t_result_2) then
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
        local ____t_21 = __t
        local ____t_result_20
        local ____t_18 = __t
        local ____t_result_17
        local ____t_16 = __t
        local ____t_result_15
        local ____t_14 = __t
        local ____t_result_13
        local ____t_12 = __t
        local ____t_result_11
        local ____t_5 = __t
        local ____temp_4 = not __t(enabled)
        __O[687] = ____temp_4
        if ____t_5(____temp_4) then
            ____t_result_11 = __O[687]
        else
            local ____opt_8 = window.Graphics
            if ____opt_8 ~= nil then
                ____opt_8 = ____opt_8.isLite
            end
            local ____opt_result_10
            if ____opt_8 ~= nil then
                ____opt_result_10 = ____opt_8(____opt_8)
            end
            ____t_result_11 = ____opt_result_10
        end
        __O[688] = ____t_result_11
        if ____t_12(____t_result_11) then
            ____t_result_13 = __O[688]
        else
            ____t_result_13 = __call(SKIP, "has", ____type)
        end
        __O[689] = ____t_result_13
        if ____t_14(____t_result_13) then
            ____t_result_15 = __O[689]
        else
            ____t_result_15 = ____type == "nikolas" and __TS__Number(o.bossPhase) >= 2
        end
        __O[690] = ____t_result_15
        if ____t_16(____t_result_15) then
            ____t_result_17 = __O[690]
        else
            ____t_result_17 = ____type == "reeisBoss"
        end
        __O[691] = ____t_result_17
        if ____t_18(____t_result_17) then
            ____t_result_20 = __O[691]
        else
            local ____t_result_19
            if __t(o.transformed) then
                ____t_result_19 = ____type == "reeis"
            else
                ____t_result_19 = o.transformed
            end
            ____t_result_20 = ____t_result_19
        end
        if ____t_21(____t_result_20) then
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
        local ____hypot_result_23 = __hypot(m.a, m.b)
        local ____t_result_22
        if __t(o.scale) then
            ____t_result_22 = o.scale
        else
            ____t_result_22 = 1
        end
        local scale = ____hypot_result_23 * ____t_result_22
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
        local ____t_result_27
        local ____t_26 = __t
        local ____opt_24 = c.canvas
        if ____opt_24 ~= nil then
            ____opt_24 = ____opt_24.width
        end
        __O[692] = ____opt_24
        if ____t_26(____opt_24) then
            ____t_result_27 = __O[692]
        else
            ____t_result_27 = 960
        end
        local cw = ____t_result_27
        if __t(__lt(sx, -260) or __gt(sx, cw + 260)) then
            return
        end
        local ____gt_29 = __gt
        local ____t_result_28
        if __t(o.scale) then
            ____t_result_28 = o.scale
        else
            ____t_result_28 = 1
        end
        if ____gt_29(____t_result_28, 1.25) then
            return original(
                nil,
                c,
                ____type,
                x,
                y,
                o
            )
        end
        local ____t_result_54
        local ____t_39 = __t
        local ____t_result_38
        local ____t_37 = __t
        local ____t_result_36
        local ____t_35 = __t
        local ____t_result_34
        local ____t_33 = __t
        local ____t_result_32
        local ____t_31 = __t
        local ____t_result_30
        if __t(o.cache) then
            ____t_result_30 = math.abs(m.a - 1) < 0.01
        else
            ____t_result_30 = o.cache
        end
        __O[693] = ____t_result_30
        if ____t_31(____t_result_30) then
            ____t_result_32 = math.abs(m.d - 1) < 0.01
        else
            ____t_result_32 = __O[693]
        end
        __O[694] = ____t_result_32
        if ____t_33(____t_result_32) then
            ____t_result_34 = not __t(m.b)
        else
            ____t_result_34 = __O[694]
        end
        __O[695] = ____t_result_34
        if ____t_35(____t_result_34) then
            ____t_result_36 = not __t(m.c)
        else
            ____t_result_36 = __O[695]
        end
        __O[696] = ____t_result_36
        if ____t_37(____t_result_36) then
            ____t_result_38 = not __t(o.hit)
        else
            ____t_result_38 = __O[696]
        end
        if ____t_39(____t_result_38) then
            local ____add_53 = __add
            local ____add_50 = __add
            local ____add_49 = __add
            local ____add_44 = __add
            local ____add_43 = __add
            local ____add_result_42 = __add(____type, "|")
            local ____lt_41 = __lt
            local ____t_result_40
            if __t(o.facing) then
                ____t_result_40 = o.facing
            else
                ____t_result_40 = 1
            end
            local ____add_44_result_48 = ____add_44(
                ____add_43(
                    ____add_result_42,
                    ____lt_41(____t_result_40, 0) and -1 or 1
                ),
                "|"
            )
            local ____mod_47 = __mod
            local ____mod_46 = __mod
            local ____t_result_45
            if __t(o.frame) then
                ____t_result_45 = o.frame
            else
                ____t_result_45 = 0
            end
            local ____add_50_result_52 = ____add_50(
                ____add_49(
                    ____add_44_result_48,
                    ____mod_47(
                        ____mod_46(
                            math.floor(____t_result_45 * 3),
                            6
                        ) + 6,
                        6
                    )
                ),
                "|"
            )
            local ____t_result_51
            if __t(o.scale) then
                ____t_result_51 = o.scale
            else
                ____t_result_51 = 1
            end
            ____t_result_54 = ____add_53(____add_50_result_52, ____t_result_51)
        else
            ____t_result_54 = nil
        end
        local ck = ____t_result_54
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
            local ____assign_58 = __assign
            local ____temp_56 = {}
            local ____o_57 = o
            local ____t_result_55
            if __t(o.frame) then
                ____t_result_55 = o.frame
            else
                ____t_result_55 = 0
            end
            o = ____assign_58(
                ____temp_56,
                ____o_57,
                {frame = math.floor(____t_result_55 * 3) / 3}
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
        local ____lt_60 = __lt
        local ____t_result_59
        if __t(o.facing) then
            ____t_result_59 = o.facing
        else
            ____t_result_59 = 1
        end
        local face = ____lt_60(____t_result_59, 0) and -1 or 1
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
