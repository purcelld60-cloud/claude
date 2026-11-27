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
        local ____t_12 = __t
        local ____t_11 = __t
        local ____t_3 = __t
        local ____t_1 = __t
        local ____temp_0 = not __t(panel.hidden) and panel.style.display ~= "none"
        __O[2421] = ____temp_0
        local ____temp_2 = if ____t_1(____temp_0) then not __t(window.document.hidden) else __O[2421]
        __O[2422] = ____temp_2
        local ____t_9 = __t
        local ____opt_6 = window.Campanha2
        if ____opt_6 ~= nil then
            ____opt_6 = ____opt_6.aberto
        end
        local ____opt_result_8
        if ____opt_6 ~= nil then
            ____opt_result_8 = ____opt_6(____opt_6)
        end
        local ____temp_10 = if ____t_3(____temp_2) then not ____t_9(____opt_result_8) else __O[2422]
        __O[2423] = ____temp_10
        if ____t_12(if ____t_11(____temp_10) then now - last > 31 else __O[2423]) then
            last = now
            ctx:clearRect(0, 0, 960, 540)
            local ____opt_15 = window.Art
            if ____opt_15 ~= nil then
                ____opt_15 = ____opt_15.drawTitleScene
            end
            if ____opt_15 ~= nil then
                ____opt_15(
                    ____opt_15,
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
