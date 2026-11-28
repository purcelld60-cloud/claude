--!native
--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __callq, __mod, __ord, __arrL, __t, __get, __call, __add, __new, __hypot = __JSR.__callq, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__t, __JSR.__get, __JSR.__call, __JSR.__add, __JSR.__new, __JSR.__hypot
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local __TS__MathSign = ____lualib.__TS__MathSign
local ____exports = {}
local __O = {};
(function()
    local leave, active, ui
    function leave(self)
        if not __t(active) then
            return
        end
        active = false
        local ____t_result_18
        if __t(ui) then
            ui.hidden = true
            ____t_result_18 = true
        else
            ____t_result_18 = ui
        end
        do
            pcall(function()
                local ____opt_21 = window.DayTime
                if ____opt_21 ~= nil then
                    ____opt_21 = ____opt_21.force
                end
                if ____opt_21 ~= nil then
                    ____opt_21(____opt_21, nil)
                end
            end)
        end
        window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {active = false}}))
        local ____opt_23 = window.document:getElementById("gameShell")
        if ____opt_23 ~= nil then
            ____opt_23.classList:remove("is-balanco")
        end
        local ____opt_27 = window.document:getElementById("gameCanvas")
        local ____opt_25 = ____opt_27 and ____opt_27.focus
        if ____opt_25 ~= nil then
            ____opt_25(____opt_27)
        end
    end
    local ____ = "use strict"
    if __t(window.Balanco) then
        return
    end
    local SCENE = 0
    local AX = 2462
    local AY = 340
    local ROPE = 66
    local HALF = 13
    active = false
    local theta = 0.05
    local omega = 0
    local sitAt = 0
    local hour = 0
    local lastT = 0
    ui = nil
    local bars = 0
    local function near(____, scene, x)
        return scene == SCENE and math.abs(x - AX) < 44
    end
    local function sit(self)
        if __t(active) then
            return
        end
        active = true
        sitAt = window.performance:now()
        bars = 0
        local ____opt_2 = window.DayTime
        if ____opt_2 ~= nil then
            ____opt_2 = ____opt_2.hour
        end
        local ____opt_result_4
        if ____opt_2 ~= nil then
            ____opt_result_4 = ____opt_2(____opt_2)
        end
        local ____opt_result_4_5 = ____opt_result_4
        if ____opt_result_4_5 == nil then
            ____opt_result_4_5 = 17
        end
        hour = ____opt_result_4_5
        window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {active = true}}))
        local ____callq_8 = __callq
        local ____opt_6 = window.document:getElementById("gameShell")
        ____callq_8(____opt_6 and ____opt_6.classList, "add", "is-balanco")
        if not __t(ui) then
            ui = window.document:createElement("div")
            ui.className = "balanco-ui"
            ui.innerHTML = "<span class=\"bl-hora\"></span><button type=\"button\" class=\"bl-sair\">LEVANTAR</button>"
            ui:querySelector(".bl-sair"):addEventListener("click", leave)
            local ____t_result_13
            local ____t_12 = __t
            local ____t_result_11
            local ____t_10 = __t
            local ____temp_9 = window.document:getElementById("gameViewport")
            __O[363] = ____temp_9
            if ____t_10(____temp_9) then
                ____t_result_11 = __O[363]
            else
                ____t_result_11 = window.document:getElementById("gameShell")
            end
            __O[364] = ____t_result_11
            if ____t_12(____t_result_11) then
                ____t_result_13 = __O[364]
            else
                ____t_result_13 = window.document.body
            end
            ____t_result_13:append(ui)
        end
        ui.hidden = false
        do
            pcall(function()
                local ____opt_16 = window.DarocaAudio
                if ____opt_16 ~= nil then
                    ____opt_16 = ____opt_16.play
                end
                if ____opt_16 ~= nil then
                    ____opt_16(____opt_16, "porta", {volume = 0.4})
                end
            end)
        end
    end
    window:addEventListener(
        "keydown",
        function(____, e)
            if __t(not __t(active) or window.performance:now() - sitAt < 400) then
                return
            end
            if __t(__call(
                __arrL({
                    "KeyE",
                    "Escape",
                    "Space",
                    "Enter",
                    "KeyA",
                    "KeyD",
                    "KeyW",
                    "KeyS",
                    "ArrowLeft",
                    "ArrowRight",
                    "ArrowUp",
                    "ArrowDown"
                }, 12),
                "includes",
                e.code
            )) then
                e:preventDefault()
                e:stopImmediatePropagation()
                leave(nil)
            end
        end,
        true
    )
    local function lerp(____, a, b, k)
        return a + (b - a) * k
    end
    local function draw(self, ctx, o)
        local ____t_34 = __t
        local ____t_result_33
        local ____t_32 = __t
        local ____t_result_31
        local ____t_30 = __t
        local ____temp_29 = o.scene ~= SCENE
        __O[365] = ____temp_29
        if ____t_30(____temp_29) then
            ____t_result_31 = __O[365]
        else
            ____t_result_31 = o.arena
        end
        __O[366] = ____t_result_31
        if ____t_32(____t_result_31) then
            ____t_result_33 = __O[366]
        else
            ____t_result_33 = o.room
        end
        if ____t_34(____t_result_33) then
            if __t(active) then
                leave(nil)
            end
            return
        end
        local ____t_result_37
        local ____t_36 = __t
        local ____TS__Number_result_35 = __TS__Number(o.time)
        __O[367] = ____TS__Number_result_35
        if ____t_36(____TS__Number_result_35) then
            ____t_result_37 = __O[367]
        else
            ____t_result_37 = 0
        end
        local t = ____t_result_37
        local dt = math.max(
            0,
            math.min(0.05, t - lastT)
        )
        lastT = t
        local target = __t(active) and 0.42 or 0.04 + math.sin(t * 0.4) * 0.02
        local amp = math.abs(theta) + math.abs(omega) / 3.9
        omega = omega + -(9.8 / (ROPE / 40)) * math.sin(theta) * dt
        omega = omega * (__t(active) and 1 or 0.995)
        local ____t_41 = __t
        local ____t_result_40
        local ____t_39 = __t
        local ____temp_38 = amp < target and __TS__MathSign(omega) == __TS__MathSign(theta)
        __O[368] = ____temp_38
        if ____t_39(____temp_38) then
            ____t_result_40 = __O[368]
        else
            ____t_result_40 = amp < 0.02
        end
        if ____t_41(____t_result_40) then
            local ____t_result_42
            if __t(omega) then
                ____t_result_42 = omega
            else
                ____t_result_42 = 1
            end
            omega = omega + __TS__MathSign(____t_result_42) * 0.5 * dt
        end
        if amp > target + 0.05 then
            omega = omega * 0.99
        end
        theta = theta + omega * dt
        if math.abs(o.camera + 480 - AX) > 700 then
            return
        end
        local sx = AX + math.sin(theta) * ROPE
        local sy = AY + math.cos(theta) * ROPE
        local ca = math.cos(theta)
        local sa = math.sin(theta)
        local L1 = __arrL({sx - HALF * ca, sy + HALF * sa}, 2)
        local R1 = __arrL({sx + HALF * ca, sy - HALF * sa}, 2)
        ctx:save()
        ctx.imageSmoothingEnabled = false
        local function rope(____, x0, y0, x1, y1)
            local n = math.ceil(__hypot(x1 - x0, y1 - y0) / 2)
            do
                local i = 0
                while i <= n do
                    local k = i / n
                    ctx.fillStyle = __t(__mod(i, 3)) and "#e2cc96" or "#a8885a"
                    ctx:fillRect(
                        math.floor(lerp(nil, x0, x1, k) / 2 + 0.5) * 2,
                        math.floor(lerp(nil, y0, y1, k) / 2 + 0.5) * 2,
                        2,
                        2
                    )
                    i = i + 1
                end
            end
        end
        rope(
            nil,
            AX - 10,
            AY,
            __get(L1, 0),
            __get(L1, 1)
        )
        rope(
            nil,
            AX + 10,
            AY,
            __get(R1, 0),
            __get(R1, 1)
        )
        if __t(active) then
            local ida = math.max(
                -1,
                math.min(1, omega / 1.4)
            )
            local fi = (68 + ida * 26) * math.pi / 180
            local inclina = -ida * 0.16
            ctx:save()
            ctx:translate(
                math.floor(sx + 0.5),
                math.floor(sy + 0.5)
            )
            ctx:rotate(-theta)
            local function heroi(____, x, y)
                do
                    pcall(function()
                        local ____opt_45 = window.Art
                        if ____opt_45 ~= nil then
                            ____opt_45 = ____opt_45.drawCharacter
                        end
                        if ____opt_45 ~= nil then
                            ____opt_45(
                                ____opt_45,
                                ctx,
                                "daroca",
                                x,
                                y,
                                {
                                    facing = 1,
                                    frame = 0,
                                    scale = 1,
                                    grounded = true,
                                    moving = false
                                }
                            )
                        end
                    end)
                end
            end
            ctx:save()
            ctx:translate(1, -1)
            ctx:rotate(-fi)
            ctx:beginPath()
            ctx:rect(-14, 1, 28, 22)
            ctx:clip()
            heroi(nil, -1, 19)
            ctx:restore()
            ctx:save()
            ctx:rotate(inclina)
            ctx:beginPath()
            ctx:rect(-40, -90, 80, 89)
            ctx:clip()
            heroi(nil, 0, 17)
            ctx:restore()
            local function ombro(____, lado)
                local ox = lado * 9 + math.sin(inclina) * -20
                local oy = -20
                local mx = lado * HALF
                local my = -34
                do
                    local k2 = 0
                    while k2 <= 6 do
                        local q = k2 / 6
                        ctx.fillStyle = k2 < 3 and "#d9873a" or "#c98a5a"
                        ctx:fillRect(
                            math.floor(lerp(nil, ox, mx, q) + 0.5) - 1,
                            math.floor(lerp(nil, oy, my, q) + 0.5) - 1,
                            3,
                            3
                        )
                        k2 = k2 + 1
                    end
                end
                ctx.fillStyle = "#1b1614"
                ctx:fillRect(mx - 2, my - 2, 5, 5)
                ctx.fillStyle = "#d99a6a"
                ctx:fillRect(mx - 1, my - 1, 3, 3)
            end
            ombro(nil, -1)
            ombro(nil, 1)
            ctx:restore()
            hour = __mod(hour + dt * 0.25, 24)
            do
                pcall(function()
                    local ____opt_49 = window.DayTime
                    if ____opt_49 ~= nil then
                        ____opt_49 = ____opt_49.force
                    end
                    if ____opt_49 ~= nil then
                        ____opt_49(____opt_49, hour)
                    end
                end)
            end
            if __t(ui) then
                local h = math.floor(hour)
                local m = math.floor((hour - h) * 60)
                ui:querySelector(".bl-hora").textContent = __add(
                    __add(
                        __add(
                            "Apreciando a vista · ",
                            __call(
                                tostring(h),
                                "padStart",
                                2,
                                "0"
                            )
                        ),
                        ":"
                    ),
                    __call(
                        tostring(m),
                        "padStart",
                        2,
                        "0"
                    )
                )
            end
            bars = math.min(1, bars + dt * 1.5)
        else
            bars = math.max(0, bars - dt * 3)
        end
        ctx:save()
        ctx:translate(
            math.floor(sx + 0.5),
            math.floor(sy + 0.5)
        )
        ctx:rotate(-theta)
        ctx.fillStyle = "#3e2a18"
        ctx:fillRect(-HALF - 3, -3, HALF * 2 + 6, 7)
        ctx.fillStyle = "#9a6a3a"
        ctx:fillRect(-HALF - 2, -2, HALF * 2 + 4, 4)
        ctx.fillStyle = "#c08a50"
        ctx:fillRect(-HALF - 2, -2, HALF * 2 + 4, 1)
        ctx:restore()
        ctx.fillStyle = "#5a4026"
        ctx:fillRect(AX - 14, AY - 2, 28, 4)
        ctx:restore()
        if bars > 0 then
            ctx:save()
            ctx:translate(
                math.floor(o.camera + 0.5),
                0
            )
            local h = math.floor(46 * bars / 2 + 0.5) * 2
            ctx.fillStyle = "#05070a"
            ctx:fillRect(0, 0, 960, h)
            ctx:fillRect(0, 540 - h, 960, h)
            local g = ctx:createRadialGradient(
                480,
                270,
                240,
                480,
                270,
                620
            )
            g:addColorStop(0, "rgba(0,0,0,0)")
            g:addColorStop(
                1,
                ("rgba(10,6,4," .. tostring(0.45 * bars)) .. ")"
            )
            ctx.fillStyle = g
            ctx:fillRect(0, 0, 960, 540)
            ctx:restore()
        end
    end
    window.Balanco = __ord(
        {
            near = near,
            sit = sit,
            leave = leave,
            active = function() return active end,
            draw = draw
        },
        "near,sit,leave,active,draw"
    )
end)(nil)
return ____exports
