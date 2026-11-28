--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __t = __JSR.__t
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local panel = window.document:getElementById("startScreen")
    local canvas = window.document:getElementById("titleCanvas")
    if __t(not __t(panel) or not __t(canvas)) then
        return
    end
    local ctx = canvas:getContext("2d")
    ctx.imageSmoothingEnabled = false
    local last = 0
    local function tick(self, now)
        local ____t_13 = __t
        local ____t_result_12
        local ____t_11 = __t
        local ____t_result_10
        local ____t_3 = __t
        local ____t_result_2
        local ____t_1 = __t
        local ____temp_0 = not __t(panel.hidden) and panel.style.display ~= "none"
        __O[2446] = ____temp_0
        if ____t_1(____temp_0) then
            ____t_result_2 = not __t(window.document.hidden)
        else
            ____t_result_2 = __O[2446]
        end
        __O[2447] = ____t_result_2
        if ____t_3(____t_result_2) then
            local ____t_9 = __t
            local ____opt_6 = window.Campanha2
            if ____opt_6 ~= nil then
                ____opt_6 = ____opt_6.aberto
            end
            local ____opt_result_8
            if ____opt_6 ~= nil then
                ____opt_result_8 = ____opt_6(____opt_6)
            end
            ____t_result_10 = not ____t_9(____opt_result_8)
        else
            ____t_result_10 = __O[2447]
        end
        __O[2448] = ____t_result_10
        if ____t_11(____t_result_10) then
            ____t_result_12 = now - last > 31
        else
            ____t_result_12 = __O[2448]
        end
        if ____t_13(____t_result_12) then
            last = now
            ctx:clearRect(0, 0, 960, 540)
            local ____opt_16 = window.Art
            if ____opt_16 ~= nil then
                ____opt_16 = ____opt_16.drawTitleScene
            end
            if ____opt_16 ~= nil then
                ____opt_16(
                    ____opt_16,
                    ctx,
                    now / 1000,
                    960,
                    540
                )
            end
        end
        window:requestAnimationFrame(tick)
    end
    window:requestAnimationFrame(tick)
end)(nil)
return ____exports
