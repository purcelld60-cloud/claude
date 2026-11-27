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
            local ____t_10 = __t
            local ____t_9 = __t
            local ____temp_8 = pointer ~= nil
            __O[2224] = ____temp_8
            if ____t_10(if ____t_9(____temp_8) then __O[2224] else e.pointerType == "mouse" and e.button ~= 0) then
                return
            end
            local ____opt_11 = window.Game
            if ____opt_11 ~= nil then
                ____opt_11 = ____opt_11:getState()
            end
            local s = ____opt_11
            local ____t_31 = __t
            local ____t_30 = __t
            local ____t_28 = __t
            local ____t_26 = __t
            local ____t_22 = __t
            local ____t_20 = __t
            local ____t_18 = __t
            local ____t_16 = __t
            local ____opt_result_15
            if s ~= nil then
                ____opt_result_15 = s.started
            end
            local ____temp_17 = not ____t_16(____opt_result_15)
            __O[2225] = ____temp_17
            local ____temp_19 = if ____t_18(____temp_17) then __O[2225] else s.paused
            __O[2226] = ____temp_19
            local ____temp_21 = if ____t_20(____temp_19) then __O[2226] else s.dialog
            __O[2227] = ____temp_21
            local ____opt_23 = s.training
            if ____opt_23 ~= nil then
                ____opt_23 = ____opt_23.active
            end
            local ____temp_25 = if ____t_22(____temp_21) then __O[2227] else ____opt_23
            __O[2228] = ____temp_25
            local ____temp_27 = if ____t_26(____temp_25) then __O[2228] else s.defeated
            __O[2229] = ____temp_27
            local ____temp_29 = if ____t_28(____temp_27) then __O[2229] else s.won
            __O[2230] = ____temp_29
            if ____t_31(if ____t_30(____temp_29) then __O[2230] else s.cutscene) then
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
