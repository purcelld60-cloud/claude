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
    local ____t_3 = __t
    local ____t_result_2
    local ____t_1 = __t
    local ____temp_0 = not __t(viewport) or not __t(canvas)
    __O[2460] = ____temp_0
    if ____t_1(____temp_0) then
        ____t_result_2 = __O[2460]
    else
        ____t_result_2 = not __t(normal)
    end
    if ____t_3(____t_result_2) then
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
                local ____t_9 = __t
                local ____t_result_8
                local ____t_7 = __t
                local ____t_result_6
                local ____t_5 = __t
                local ____temp_4 = not __t(__len(event.touches))
                __O[2461] = ____temp_4
                if ____t_5(____temp_4) then
                    ____t_result_6 = touch
                else
                    ____t_result_6 = __O[2461]
                end
                __O[2462] = ____t_result_6
                if ____t_7(____t_result_6) then
                    ____t_result_8 = button:contains(window.document:elementFromPoint(touch.clientX, touch.clientY))
                else
                    ____t_result_8 = __O[2462]
                end
                if ____t_9(____t_result_8) then
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
            local ____opt_12 = window.Game
            if ____opt_12 ~= nil then
                ____opt_12 = ____opt_12.advanceDialogue
            end
            local ____opt_result_14
            if ____opt_12 ~= nil then
                ____opt_result_14 = ____opt_12(____opt_12)
            end
            return ____opt_result_14
        end
    )
    bindControl(
        nil,
        close,
        function()
            local ____opt_17 = window.Game
            if ____opt_17 ~= nil then
                ____opt_17 = ____opt_17.closeDialogue
            end
            local ____opt_result_19
            if ____opt_17 ~= nil then
                ____opt_result_19 = ____opt_17(____opt_17, false)
            end
            return ____opt_result_19
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
        local ____t_result_20
        if __t(contain) then
            ____t_result_20 = math.min(r.width / 960, r.height / 540)
        else
            ____t_result_20 = r.width / 960
        end
        local scale = ____t_result_20
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
        local ____lt_22 = __lt
        local ____anchor_x_21 = anchor.x
        if ____anchor_x_21 == nil then
            ____anchor_x_21 = 480
        end
        local onLeft = ____lt_22(____anchor_x_21, 480)
        local ____t_result_23
        if __t(onLeft) then
            ____t_result_23 = leftGutter
        else
            ____t_result_23 = rightGutter
        end
        local gutter = ____t_result_23
        local ____t_result_26
        local ____t_25 = __t
        local ____t_result_24
        if __t(cinematic) then
            ____t_result_24 = vh < 280
        else
            ____t_result_24 = cinematic
        end
        __O[2463] = ____t_result_24
        if ____t_25(____t_result_24) then
            ____t_result_26 = gutter >= 200
        else
            ____t_result_26 = __O[2463]
        end
        local sideBalloon = ____t_result_26
        local ____t_result_27
        if __t(anchor.width) then
            ____t_result_27 = anchor.width
        else
            ____t_result_27 = 380
        end
        local wanted = ____t_result_27 * b.scale
        local ____t_result_28
        if __t(sideBalloon) then
            ____t_result_28 = math.min(230, gutter - 18)
        else
            ____t_result_28 = clamp(
                nil,
                wanted,
                math.min(210, vw - 24),
                math.min(370, vw * 0.67)
            )
        end
        local width = ____t_result_28
        local ____el_dataset_30 = el.dataset
        local ____t_result_29
        if __t(sideBalloon) then
            ____t_result_29 = __t(onLeft) and "gutter-left" or "gutter-right"
        else
            ____t_result_29 = "sky"
        end
        ____el_dataset_30.placement = ____t_result_29
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
        local ____t_result_34
        if __t(sideBalloon) then
            local ____t_result_31
            if __t(onLeft) then
                ____t_result_31 = leftGutter / 2
            else
                ____t_result_31 = vw - rightGutter / 2
            end
            ____t_result_34 = ____t_result_31
        else
            local ____b_ox_33 = b.ox
            local ____anchor_x_32 = anchor.x
            if ____anchor_x_32 == nil then
                ____anchor_x_32 = 480
            end
            ____t_result_34 = ____b_ox_33 + ____anchor_x_32 * b.scale
        end
        local x = ____t_result_34
        local ____t_result_39
        if __t(cinematic) then
            local ____b_oy_36 = b.oy
            local ____anchor_y_35 = anchor.y
            if ____anchor_y_35 == nil then
                ____anchor_y_35 = 65
            end
            ____t_result_39 = ____b_oy_36 + ____anchor_y_35 * b.scale
        else
            local ____b_oy_38 = b.oy
            local ____anchor_y_37 = anchor.y
            if ____anchor_y_37 == nil then
                ____anchor_y_37 = 330
            end
            ____t_result_39 = ____b_oy_38 + ____anchor_y_37 * b.scale - h - 18
        end
        local y = ____t_result_39
        local ____t_result_45
        if __t(cinematic) then
            local ____t_result_44
            local ____t_43 = __t
            local ____opt_40 = window.document:querySelector(".cinematic-heading")
            local ____temp_42 = ____opt_40 and ____opt_40:getBoundingClientRect().height
            __O[2464] = ____temp_42
            if ____t_43(____temp_42) then
                ____t_result_44 = __O[2464]
            else
                ____t_result_44 = 20
            end
            ____t_result_45 = ____t_result_44
        else
            ____t_result_45 = 0
        end
        local header = ____t_result_45
        local controlsSpace = __t(cinematic) and 47 or math.max(
            47,
            controls:getBoundingClientRect().height + 22
        )
        local ____t_47 = __t
        local ____t_result_46
        if __t(cinematic) then
            ____t_result_46 = b.oy > 30
        else
            ____t_result_46 = cinematic
        end
        if ____t_47(____t_result_46) then
            y = math.max(header + 22, b.oy - h - 12)
        end
        local ____y_49 = y
        local ____t_result_48
        if __t(cinematic) then
            ____t_result_48 = header + 18
        else
            ____t_result_48 = 10
        end
        y = clamp(
            nil,
            ____y_49,
            ____t_result_48,
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
        local ____b_ox_52 = b.ox
        local ____anchor_speakerX_50 = anchor.speakerX
        if ____anchor_speakerX_50 == nil then
            ____anchor_speakerX_50 = anchor.x
        end
        local ____anchor_speakerX_50_51 = ____anchor_speakerX_50
        if ____anchor_speakerX_50_51 == nil then
            ____anchor_speakerX_50_51 = 480
        end
        local speakerX = ____b_ox_52 + ____anchor_speakerX_50_51 * b.scale
        local ____b_oy_54 = b.oy
        local ____anchor_speakerY_53 = anchor.speakerY
        if ____anchor_speakerY_53 == nil then
            ____anchor_speakerY_53 = 300
        end
        local speakerY = ____b_oy_54 + ____anchor_speakerY_53 * b.scale
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
        local ____el_dataset_56 = el.dataset
        local ____t_result_55
        if __t(anchor.tail) then
            ____t_result_55 = anchor.tail
        else
            ____t_result_55 = speakerX < x and "left" or "right"
        end
        ____el_dataset_56.tail = ____t_result_55
        local ____el_dataset_60 = el.dataset
        local ____t_result_59
        local ____t_58 = __t
        local ____t_result_57
        if __t(anchor.type) then
            ____t_result_57 = anchor.type
        else
            ____t_result_57 = anchor.speaker
        end
        __O[2465] = ____t_result_57
        if ____t_58(____t_result_57) then
            ____t_result_59 = __O[2465]
        else
            ____t_result_59 = ""
        end
        ____el_dataset_60.speaker = ____t_result_59
    end
    local function tick(self)
        local ____t_73 = __t
        local ____t_result_72
        local ____t_66 = __t
        local ____opt_63 = window.Campanha2
        if ____opt_63 ~= nil then
            ____opt_63 = ____opt_63.aberto
        end
        local ____opt_result_65
        if ____opt_63 ~= nil then
            ____opt_result_65 = ____opt_63(____opt_63)
        end
        __O[2466] = ____opt_result_65
        if ____t_66(____opt_result_65) then
            ____t_result_72 = __O[2466]
        else
            local ____opt_69 = window.Fliperama
            if ____opt_69 ~= nil then
                ____opt_69 = ____opt_69.isOpen
            end
            local ____opt_result_71
            if ____opt_69 ~= nil then
                ____opt_result_71 = ____opt_69(____opt_69)
            end
            ____t_result_72 = ____opt_result_71
        end
        if ____t_73(____t_result_72) then
            window:requestAnimationFrame(tick)
            return
        end
        local ____t_result_85
        local ____t_79 = __t
        local ____opt_76 = window.Game
        if ____opt_76 ~= nil then
            ____opt_76 = ____opt_76.getDialogueView
        end
        local ____opt_result_78
        if ____opt_76 ~= nil then
            ____opt_result_78 = ____opt_76(____opt_76)
        end
        __O[2467] = ____opt_result_78
        if ____t_79(____opt_result_78) then
            ____t_result_85 = __O[2467]
        else
            local ____opt_82 = window.Game
            if ____opt_82 ~= nil then
                ____opt_82 = ____opt_82.getState
            end
            local ____opt_result_84
            if ____opt_82 ~= nil then
                ____opt_result_84 = ____opt_82(____opt_82)
            end
            ____t_result_85 = ____opt_result_84
        end
        local state = ____t_result_85
        if __t(state) then
            local ____t_result_88
            local ____t_87 = __t
            local ____temp_86 = not not __t(state.dialog) and not __t(state.paused)
            __O[2468] = ____temp_86
            if ____t_87(____temp_86) then
                ____t_result_88 = not __t(state.cutscene)
            else
                ____t_result_88 = __O[2468]
            end
            local active = ____t_result_88
            normal.hidden = not __t(active)
            controls.hidden = not __t(active)
            if __t(active) then
                local ____t_result_92
                local ____t_91 = __t
                local ____this_90
                ____this_90 = window.Game
                local ____opt_89 = ____this_90.getDialogueAnchor
                if ____opt_89 ~= nil then
                    ____opt_89 = ____opt_89(____this_90)
                end
                __O[2469] = ____opt_89
                if ____t_91(____opt_89) then
                    ____t_result_92 = __O[2469]
                else
                    ____t_result_92 = {x = 480, y = 300, speakerX = 480}
                end
                local a = ____t_result_92
                position(nil, normal, a, false)
            end
            local ____t_96 = __t
            local ____t_result_95
            local ____t_94 = __t
            local ____t_result_93
            if __t(film) then
                ____t_result_93 = state.cutscene
            else
                ____t_result_93 = film
            end
            __O[2470] = ____t_result_93
            if ____t_94(____t_result_93) then
                ____t_result_95 = not __t(state.paused)
            else
                ____t_result_95 = __O[2470]
            end
            if ____t_96(____t_result_95) then
                local ____t_result_103
                local ____t_102 = __t
                local ____opt_99 = window.Cinematics
                if ____opt_99 ~= nil then
                    ____opt_99 = ____opt_99.anchor
                end
                local ____opt_result_101
                if ____opt_99 ~= nil then
                    ____opt_result_101 = ____opt_99(____opt_99, state.cutscene)
                end
                __O[2471] = ____opt_result_101
                if ____t_102(____opt_result_101) then
                    ____t_result_103 = __O[2471]
                else
                    ____t_result_103 = {x = 300, y = 65, width = 400, speakerX = 300}
                end
                local a = ____t_result_103
                position(nil, film, a, true)
            end
            local ____add_107 = __add
            local ____temp_106 = __t(active) and "d" or ""
            local ____t_105 = __t
            local ____t_result_104
            if __t(state.cutscene) then
                ____t_result_104 = not __t(state.paused)
            else
                ____t_result_104 = state.cutscene
            end
            local key = ____add_107(
                ____temp_106,
                ____t_105(____t_result_104) and "c" or ""
            )
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
