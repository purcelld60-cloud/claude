--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __ord, __arrL, __iterar, __t, __hypot = __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__hypot
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Iterator = ____lualib.__TS__Iterator
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local pad = window.document:getElementById("moveJoystick")
    if not __t(pad) then
        return
    end
    local knob = pad:querySelector(".joystick-knob")
    local pointer = nil
    local cx = 0
    local cy = 0
    local radius = 1
    local function render(self, x, y)
        if x == nil then
            x = 0
        end
        if y == nil then
            y = 0
        end
        knob.style.transform = ((("translate(" .. tostring(x * radius)) .. "px,") .. tostring(y * radius)) .. "px)"
        pad.classList:toggle(
            "engaged",
            not not __t(math.abs(x) + math.abs(y))
        )
        pad:setAttribute(
            "aria-valuenow",
            math.floor(x * 100 + 0.5)
        )
    end
    local function reset(self, send)
        if send == nil then
            send = true
        end
        local id = pointer
        pointer = nil
        if id ~= nil then
            do
                pcall(function()
                    if __t(pad:hasPointerCapture(id)) then
                        pad:releasePointerCapture(id)
                    end
                end)
            end
        end
        render(nil)
        if __t(send) then
            local ____opt_2 = window.Game
            if ____opt_2 ~= nil then
                ____opt_2 = ____opt_2.setJoystick
            end
            if ____opt_2 ~= nil then
                ____opt_2(____opt_2, 0, 0)
            end
        end
    end
    local function move(self, e)
        if e.pointerId ~= pointer then
            return
        end
        local x = (e.clientX - cx) / radius
        local y = (e.clientY - cy) / radius
        local mag = __hypot(x, y)
        if mag > 1 then
            x = x / mag
            y = y / mag
        end
        local ____opt_6 = window.Game
        if ____opt_6 ~= nil then
            ____opt_6 = ____opt_6.setJoystick
        end
        if ____opt_6 ~= nil then
            ____opt_6(____opt_6, x, y)
        end
        render(nil, x, y)
        if __t(e.cancelable) then
            e:preventDefault()
        end
    end
    pad:addEventListener(
        "pointerdown",
        function(____, e)
            local ____t_11 = __t
            local ____t_result_10
            local ____t_9 = __t
            local ____temp_8 = pointer ~= nil
            __O[2248] = ____temp_8
            if ____t_9(____temp_8) then
                ____t_result_10 = __O[2248]
            else
                ____t_result_10 = e.pointerType == "mouse" and e.button ~= 0
            end
            if ____t_11(____t_result_10) then
                return
            end
            local ____opt_12 = window.Game
            if ____opt_12 ~= nil then
                ____opt_12 = ____opt_12:getState()
            end
            local s = ____opt_12
            local ____t_33 = __t
            local ____t_result_32
            local ____t_31 = __t
            local ____t_result_30
            local ____t_29 = __t
            local ____t_result_28
            local ____t_27 = __t
            local ____t_result_26
            local ____t_23 = __t
            local ____t_result_22
            local ____t_21 = __t
            local ____t_result_20
            local ____t_19 = __t
            local ____t_17 = __t
            local ____opt_result_16
            if s ~= nil then
                ____opt_result_16 = s.started
            end
            local ____temp_18 = not ____t_17(____opt_result_16)
            __O[2249] = ____temp_18
            if ____t_19(____temp_18) then
                ____t_result_20 = __O[2249]
            else
                ____t_result_20 = s.paused
            end
            __O[2250] = ____t_result_20
            if ____t_21(____t_result_20) then
                ____t_result_22 = __O[2250]
            else
                ____t_result_22 = s.dialog
            end
            __O[2251] = ____t_result_22
            if ____t_23(____t_result_22) then
                ____t_result_26 = __O[2251]
            else
                local ____opt_24 = s.training
                if ____opt_24 ~= nil then
                    ____opt_24 = ____opt_24.active
                end
                ____t_result_26 = ____opt_24
            end
            __O[2252] = ____t_result_26
            if ____t_27(____t_result_26) then
                ____t_result_28 = __O[2252]
            else
                ____t_result_28 = s.defeated
            end
            __O[2253] = ____t_result_28
            if ____t_29(____t_result_28) then
                ____t_result_30 = __O[2253]
            else
                ____t_result_30 = s.won
            end
            __O[2254] = ____t_result_30
            if ____t_31(____t_result_30) then
                ____t_result_32 = __O[2254]
            else
                ____t_result_32 = s.cutscene
            end
            if ____t_33(____t_result_32) then
                return
            end
            if __t(e.cancelable) then
                e:preventDefault()
            end
            local rect = pad:getBoundingClientRect()
            cx = rect.left + rect.width / 2
            cy = rect.top + rect.height / 2
            radius = rect.width * 0.34
            pointer = e.pointerId
            do
                pcall(function()
                    pad:setPointerCapture(pointer)
                end)
            end
            move(nil, e)
        end
    )
    pad:addEventListener("pointermove", move)
    local function ____end(self, e)
        if e.pointerId == pointer then
            reset(nil)
        end
    end
    for ____, target in __iterar((__arrL({pad, window.document, window}, 3))) do
        for ____, ____type in __iterar((__arrL({"pointerup", "pointercancel", "lostpointercapture"}, 3))) do
            target:addEventListener(____type, ____end, true)
        end
    end
    pad:addEventListener(
        "touchstart",
        function(____, e)
            if __t(e.cancelable) then
                e:preventDefault()
            end
        end,
        {passive = false}
    )
    pad:addEventListener(
        "touchmove",
        function(____, e)
            if __t(e.cancelable) then
                e:preventDefault()
            end
        end,
        {passive = false}
    )
    window:addEventListener(
        "game-input-reset",
        function() return reset(nil, false) end
    )
    window:addEventListener(
        "blur",
        function() return reset(nil) end
    )
    window:addEventListener(
        "pagehide",
        function() return reset(nil) end
    )
    window:addEventListener(
        "orientationchange",
        function() return reset(nil) end
    )
    window.document:addEventListener(
        "visibilitychange",
        function()
            if __t(window.document.hidden) then
                reset(nil)
            end
        end
    )
    window.Joystick = __ord(
        {
            reset = function() return reset(nil) end,
            getState = function() return {pointerId = pointer} end
        },
        "reset,getState"
    )
end)(nil)
return ____exports
