--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __t, __get, __len, __add = __JSR.__lt, __JSR.__t, __JSR.__get, __JSR.__len, __JSR.__add
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local viewport = window.document:getElementById("gameViewport")
    local canvas = window.document:getElementById("gameCanvas")
    local normal = window.document:getElementById("dialogBox")
    local film = window.document:querySelector(".cinematic-caption")
    local ____t_2 = __t
    local ____t_1 = __t
    local ____temp_0 = not __t(viewport) or not __t(canvas)
    __O[2427] = ____temp_0
    if ____t_2(if ____t_1(____temp_0) then __O[2427] else not __t(normal)) then
        return
    end
    local controls = window.document:getElementById("dialogControls")
    if not __t(controls) then
        controls = window.document:createElement("div")
        controls.id = "dialogControls"
        controls.className = "speech-controls"
        controls.hidden = true
        viewport:append(controls)
    end
    local next = window.document:getElementById("dialogNext")
    if not __t(next) then
        next = window.document:createElement("button")
        next.id = "dialogNext"
        next.className = "primary-btn"
        next.textContent = "Próximo"
        controls:append(next)
    end
    next.type = "button"
    next:setAttribute("aria-label", "Avançar ou concluir a conversa")
    local close = window.document:createElement("button")
    close.id = "dialogClose"
    close.type = "button"
    close.className = "dialog-close"
    close.textContent = "Fechar · Esc"
    close:setAttribute("aria-label", "Fechar a conversa sem confirmar ações")
    controls:prepend(close)
    local style = window.document:createElement("style")
    style.id = "dialogue-controls-style"
    style.textContent = "\n#gameShell #dialogControls{gap:8px;right:max(12px,env(safe-area-inset-right));bottom:max(8px,env(safe-area-inset-bottom));max-width:calc(100% - 24px);flex-wrap:nowrap;z-index:39}\n#gameShell #dialogControls button{min-width:0;min-height:42px;max-width:100%;touch-action:manipulation;user-select:none;-webkit-user-select:none}\n#gameShell #dialogControls #dialogClose{min-width:88px;padding:5px 10px;background:#e7ddbc;color:#796142;border-color:#9a8059;font:10px Space,Arial,sans-serif}\n#gameShell #dialogControls #dialogNext{min-width:min(180px,calc(100vw - 140px));max-width:calc(100vw - 140px);padding:5px 12px;white-space:normal;text-align:center;font-size:8px;line-height:1.5}\n@media(orientation:landscape) and (max-height:360px){#gameShell #dialogControls button{min-height:38px}#gameShell #dialogControls #dialogNext{font-size:7px}}\n"
    window.document.head:append(style)
    local function bindControl(self, button, activate)
        button:addEventListener(
            "touchend",
            function(____, event)
                if not __t(event.cancelable) then
                    return
                end
                event:preventDefault()
                local touch = __get(event.changedTouches, 0)
                local ____t_7 = __t
                local ____t_6 = __t
                local ____t_4 = __t
                local ____temp_3 = not __t(__len(event.touches))
                __O[2428] = ____temp_3
                local ____temp_5 = if ____t_4(____temp_3) then touch else __O[2428]
                __O[2429] = ____temp_5
                if ____t_7(if ____t_6(____temp_5) then button:contains(window.document:elementFromPoint(touch.clientX, touch.clientY)) else __O[2429]) then
                    activate(nil)
                end
            end,
            {passive = false}
        )
        button:addEventListener(
            "click",
            function(____, event)
                event:preventDefault()
                activate(nil)
            end
        )
        button:addEventListener(
            "contextmenu",
            function(____, event) return event:preventDefault() end
        )
    end
    bindControl(
        nil,
        next,
        function()
            local ____opt_10 = window.Game
            if ____opt_10 ~= nil then
                ____opt_10 = ____opt_10.advanceDialogue
            end
            local ____opt_result_12
            if ____opt_10 ~= nil then
                ____opt_result_12 = ____opt_10(____opt_10)
            end
            return ____opt_result_12
        end
    )
    bindControl(
        nil,
        close,
        function()
            local ____opt_15 = window.Game
            if ____opt_15 ~= nil then
                ____opt_15 = ____opt_15.closeDialogue
            end
            local ____opt_result_17
            if ____opt_15 ~= nil then
                ____opt_result_17 = ____opt_15(____opt_15, false)
            end
            return ____opt_result_17
        end
    )
    local prior = ""
    local function clamp(____, x, a, b)
        return math.max(
            a,
            math.min(b, x)
        )
    end
    local function bounds(self)
        local v = viewport:getBoundingClientRect()
        local r = canvas:getBoundingClientRect()
        local contain = window:getComputedStyle(canvas).objectFit == "contain"
        local scale = if __t(contain) then math.min(r.width / 960, r.height / 540) else r.width / 960
        local w = 960 * scale
        local h = 540 * scale
        return {v = v, scale = scale, ox = r.left - v.left + (r.width - w) / 2, oy = r.top - v.top + (r.height - h) / 2}
    end
    local function position(self, el, anchor, cinematic)
        local b = bounds(nil)
        local vw = b.v.width
        local vh = b.v.height
        local leftGutter = math.max(0, b.ox)
        local rightGutter = math.max(0, vw - b.ox - 960 * b.scale)
        local ____lt_19 = __lt
        local ____anchor_x_18 = anchor.x
        if ____anchor_x_18 == nil then
            ____anchor_x_18 = 480
        end
        local onLeft = ____lt_19(____anchor_x_18, 480)
        local gutter = if __t(onLeft) then leftGutter else rightGutter
        local ____t_21 = __t
        local ____temp_20 = if __t(cinematic) then vh < 280 else cinematic
        __O[2430] = ____temp_20
        local sideBalloon = if ____t_21(____temp_20) then gutter >= 200 else __O[2430]
        local wanted = if __t(anchor.width) then anchor.width else 380 * b.scale
        local width = if __t(sideBalloon) then math.min(230, gutter - 18) else clamp(
            nil,
            wanted,
            math.min(210, vw - 24),
            math.min(370, vw * 0.67)
        )
        el.dataset.placement = if __t(sideBalloon) then if __t(onLeft) then "gutter-left" else "gutter-right" else "sky"
        el.style.width = __add(
            math.floor(width + 0.5),
            "px"
        )
        el.style.maxWidth = "calc(100% - 24px)"
        el.style.left = "0px"
        el.style.top = "0px"
        el.style.bottom = "auto"
        el.style.right = "auto"
        local h = el:getBoundingClientRect().height
        local ____b_ox_23 = b.ox
        local ____anchor_x_22 = anchor.x
        if ____anchor_x_22 == nil then
            ____anchor_x_22 = 480
        end
        local x = if __t(sideBalloon) then if __t(onLeft) then leftGutter / 2 else vw - rightGutter / 2 else ____b_ox_23 + ____anchor_x_22 * b.scale
        local ____b_oy_25 = b.oy
        local ____anchor_y_24 = anchor.y
        if ____anchor_y_24 == nil then
            ____anchor_y_24 = 65
        end
        local ____b_oy_27 = b.oy
        local ____anchor_y_26 = anchor.y
        if ____anchor_y_26 == nil then
            ____anchor_y_26 = 330
        end
        local y = if __t(cinematic) then ____b_oy_25 + ____anchor_y_24 * b.scale else ____b_oy_27 + ____anchor_y_26 * b.scale - h - 18
        local ____t_31 = __t
        local ____opt_28 = window.document:querySelector(".cinematic-heading")
        local ____temp_30 = ____opt_28 and ____opt_28:getBoundingClientRect().height
        __O[2431] = ____temp_30
        local header = if __t(cinematic) then if ____t_31(____temp_30) then __O[2431] else 20 else 0
        local controlsSpace = if __t(cinematic) then 47 else math.max(
            47,
            controls:getBoundingClientRect().height + 22
        )
        if __t(if __t(cinematic) then b.oy > 30 else cinematic) then
            y = math.max(header + 22, b.oy - h - 12)
        end
        y = clamp(
            nil,
            y,
            if __t(cinematic) then header + 18 else 10,
            math.max(12, vh - h - controlsSpace)
        )
        x = clamp(nil, x, 8 + width / 2, vw - 8 - width / 2)
        el.style.left = __add(
            math.floor(x - width / 2 + 0.5),
            "px"
        )
        el.style.top = __add(
            math.floor(y + 0.5),
            "px"
        )
        local ____b_ox_34 = b.ox
        local ____anchor_speakerX_32 = anchor.speakerX
        if ____anchor_speakerX_32 == nil then
            ____anchor_speakerX_32 = anchor.x
        end
        local ____anchor_speakerX_32_33 = ____anchor_speakerX_32
        if ____anchor_speakerX_32_33 == nil then
            ____anchor_speakerX_32_33 = 480
        end
        local speakerX = ____b_ox_34 + ____anchor_speakerX_32_33 * b.scale
        local ____b_oy_36 = b.oy
        local ____anchor_speakerY_35 = anchor.speakerY
        if ____anchor_speakerY_35 == nil then
            ____anchor_speakerY_35 = 300
        end
        local speakerY = ____b_oy_36 + ____anchor_speakerY_35 * b.scale
        el.style:setProperty(
            "--tail-left",
            __add(
                math.floor(clamp(nil, speakerX - (x - width / 2), 20, width - 20) + 0.5),
                "px"
            )
        )
        el.style:setProperty(
            "--tail-top",
            __add(
                math.floor(clamp(nil, speakerY - y, 20, h - 20) + 0.5),
                "px"
            )
        )
        el.dataset.tail = if __t(anchor.tail) then anchor.tail else if speakerX < x then "left" else "right"
        local ____el_dataset_39 = el.dataset
        local ____t_38 = __t
        local ____temp_37 = if __t(anchor.type) then anchor.type else anchor.speaker
        __O[2432] = ____temp_37
        ____el_dataset_39.speaker = if ____t_38(____temp_37) then __O[2432] else ""
    end
    local function tick(self)
        local ____t_51 = __t
        local ____t_45 = __t
        local ____opt_42 = window.Campanha2
        if ____opt_42 ~= nil then
            ____opt_42 = ____opt_42.aberto
        end
        local ____opt_result_44
        if ____opt_42 ~= nil then
            ____opt_result_44 = ____opt_42(____opt_42)
        end
        __O[2433] = ____opt_result_44
        local ____opt_48 = window.Fliperama
        if ____opt_48 ~= nil then
            ____opt_48 = ____opt_48.isOpen
        end
        local ____opt_result_50
        if ____opt_48 ~= nil then
            ____opt_result_50 = ____opt_48(____opt_48)
        end
        if ____t_51(if ____t_45(____opt_result_44) then __O[2433] else ____opt_result_50) then
            window:requestAnimationFrame(tick)
            return
        end
        local ____t_57 = __t
        local ____opt_54 = window.Game
        if ____opt_54 ~= nil then
            ____opt_54 = ____opt_54.getDialogueView
        end
        local ____opt_result_56
        if ____opt_54 ~= nil then
            ____opt_result_56 = ____opt_54(____opt_54)
        end
        __O[2434] = ____opt_result_56
        local ____opt_60 = window.Game
        if ____opt_60 ~= nil then
            ____opt_60 = ____opt_60.getState
        end
        local ____opt_result_62
        if ____opt_60 ~= nil then
            ____opt_result_62 = ____opt_60(____opt_60)
        end
        local state = if ____t_57(____opt_result_56) then __O[2434] else ____opt_result_62
        if __t(state) then
            local ____t_64 = __t
            local ____temp_63 = not not __t(state.dialog) and not __t(state.paused)
            __O[2435] = ____temp_63
            local active = if ____t_64(____temp_63) then not __t(state.cutscene) else __O[2435]
            normal.hidden = not __t(active)
            controls.hidden = not __t(active)
            if __t(active) then
                local ____t_67 = __t
                local ____this_66
                ____this_66 = window.Game
                local ____opt_65 = ____this_66.getDialogueAnchor
                if ____opt_65 ~= nil then
                    ____opt_65 = ____opt_65(____this_66)
                end
                __O[2436] = ____opt_65
                local a = if ____t_67(____opt_65) then __O[2436] else {x = 480, y = 300, speakerX = 480}
                position(nil, normal, a, false)
            end
            local ____t_70 = __t
            local ____t_69 = __t
            local ____temp_68 = if __t(film) then state.cutscene else film
            __O[2437] = ____temp_68
            if ____t_70(if ____t_69(____temp_68) then not __t(state.paused) else __O[2437]) then
                local ____t_76 = __t
                local ____opt_73 = window.Cinematics
                if ____opt_73 ~= nil then
                    ____opt_73 = ____opt_73.anchor
                end
                local ____opt_result_75
                if ____opt_73 ~= nil then
                    ____opt_result_75 = ____opt_73(____opt_73, state.cutscene)
                end
                __O[2438] = ____opt_result_75
                local a = if ____t_76(____opt_result_75) then __O[2438] else {x = 300, y = 65, width = 400, speakerX = 300}
                position(nil, film, a, true)
            end
            local key = __add(if __t(active) then "d" else "", if __t(if __t(state.cutscene) then not __t(state.paused) else state.cutscene) then "c" else "")
            if key ~= prior then
                prior = key
                viewport.classList:toggle(
                    "has-speech",
                    not not __t(key)
                )
            end
        else
            normal.hidden = true
            controls.hidden = true
        end
        window:requestAnimationFrame(tick)
    end
    window:requestAnimationFrame(tick)
end)(nil)
return ____exports
