--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __isFiniteN, __getq, __ord, __arrL, __iterar, __t, __get, __set, __del, __arr, __len, __call = __JSR.__isFiniteN, __JSR.__getq, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__del, __JSR.__arr, __JSR.__len, __JSR.__call
local __add, __new, __iter, __assign, __isArray = __JSR.__add, __JSR.__new, __JSR.__iter, __JSR.__assign, __JSR.__isArray
local ____lualib = require(script.Parent.lualib_bundle)
local Map = ____lualib.Map
local __TS__New = ____lualib.__TS__New
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__ParseFloat = ____lualib.__TS__ParseFloat
local __TS__Spread = ____lualib.__TS__Spread
local __TS__Number = ____lualib.__TS__Number
local __TS__ObjectFromEntries = ____lualib.__TS__ObjectFromEntries
local ____exports = {}
local __O = {};
(function()
    local entry, settingsEntry
    local ____ = "use strict"
    local shell = window.document:getElementById("gameShell")
    local layer = shell and shell:querySelector(".touch-controls")
    local joystick = window.document:getElementById("moveJoystick")
    local ____t_6 = __t
    local ____t_5 = __t
    local ____t_3 = __t
    local ____temp_2 = not __t(shell) or not __t(layer)
    __O[2999] = ____temp_2
    local ____temp_4 = if ____t_3(____temp_2) then __O[2999] else not __t(joystick)
    __O[3000] = ____temp_4
    if ____t_6(if ____t_5(____temp_4) then __O[3000] else window.CampaignControls) then
        return
    end
    local KEY = "daroca-campaign-layout-v1"
    local names = __ord({
        joystick = "Joystick",
        paper = "Papel",
        fart = "Peidão",
        jump = "Pular / voar",
        dash = "Dash",
        interact = "Conversar",
        reeis = "OOO REEEIS!",
        vehicle = "Carro a gás",
        taunt = "Batata!",
        bivolt = "Bivolt"
    }, "joystick,paper,fart,jump,dash,interact,reeis,vehicle,taunt,bivolt")
    local defaults = __ord(
        {
            landscape = __ord(
                {
                    joystick = __arrL({0.14, 0.81, 100}, 3),
                    paper = __arrL({0.79, 0.84, 54}, 3),
                    fart = __arrL({0.7, 0.84, 54}, 3),
                    jump = __arrL({0.89, 0.82, 58}, 3),
                    dash = __arrL({0.91, 0.61, 46}, 3),
                    interact = __arrL({0.81, 0.61, 46}, 3),
                    reeis = __arrL({0.72, 0.61, 44}, 3),
                    vehicle = __arrL({0.4, 0.87, 46}, 3),
                    taunt = __arrL({0.49, 0.87, 44}, 3),
                    bivolt = __arrL({0.58, 0.87, 44}, 3)
                },
                "joystick,paper,fart,jump,dash,interact,reeis,vehicle,taunt,bivolt"
            ),
            portrait = __ord(
                {
                    joystick = __arrL({0.2, 0.83, 106}, 3),
                    paper = __arrL({0.77, 0.86, 54}, 3),
                    fart = __arrL({0.6, 0.86, 54}, 3),
                    jump = __arrL({0.92, 0.86, 56}, 3),
                    dash = __arrL({0.92, 0.72, 44}, 3),
                    interact = __arrL({0.77, 0.72, 44}, 3),
                    reeis = __arrL({0.61, 0.72, 44}, 3),
                    vehicle = __arrL({0.38, 0.94, 44}, 3),
                    taunt = __arrL({0.55, 0.95, 42}, 3),
                    bivolt = __arrL({0.72, 0.96, 42}, 3)
                },
                "joystick,paper,fart,jump,dash,interact,reeis,vehicle,taunt,bivolt"
            )
        },
        "landscape,portrait"
    )
    local function clamp(____, v, a, b)
        return math.max(
            a,
            math.min(b, v)
        )
    end
    local function state()
        local ____t_12 = __t
        local ____opt_9 = window.Game
        if ____opt_9 ~= nil then
            ____opt_9 = ____opt_9.getState
        end
        local ____opt_result_11
        if ____opt_9 ~= nil then
            ____opt_result_11 = ____opt_9(____opt_9)
        end
        __O[3001] = ____opt_result_11
        return if ____t_12(____opt_result_11) then __O[3001] else {}
    end
    local function otherMode()
        local ____t_31 = __t
        local ____t_25 = __t
        local ____t_18 = __t
        local ____opt_15 = window.Arena
        if ____opt_15 ~= nil then
            ____opt_15 = ____opt_15.isOpen
        end
        local ____opt_result_17
        if ____opt_15 ~= nil then
            ____opt_result_17 = ____opt_15(____opt_15)
        end
        __O[3002] = ____opt_result_17
        local ____opt_21 = window.CoopArena
        if ____opt_21 ~= nil then
            ____opt_21 = ____opt_21.getStatus
        end
        local ____opt_result_23
        if ____opt_21 ~= nil then
            ____opt_result_23 = ____opt_21(____opt_21).open
        end
        local ____temp_24 = if ____t_18(____opt_result_17) then __O[3002] else ____opt_result_23
        __O[3003] = ____temp_24
        local ____opt_28 = window.PartyGame
        if ____opt_28 ~= nil then
            ____opt_28 = ____opt_28.getStatus
        end
        local ____opt_result_30
        if ____opt_28 ~= nil then
            ____opt_result_30 = ____opt_28(____opt_28).open
        end
        return not not ____t_31(if ____t_25(____temp_24) then __O[3003] else ____opt_result_30)
    end
    local layouts = {}
    local editing = false
    local orientation = "landscape"
    local selected = "joystick"
    local pointer = nil
    local resumeAfter = false
    local returnFocus = nil
    local saved = true
    local scheduled = false
    local plane = __ord({left = 0, top = 0, width = 1, height = 1}, "left,top,width,height")
    local previousInert = false
    do
        pcall(function()
            local ____self_34 = window.JSON
            local ____self_34_parse_35 = ____self_34.parse
            local ____t_33 = __t
            local ____temp_32 = window.localStorage:getItem(KEY)
            __O[3004] = ____temp_32
            local record = ____self_34_parse_35(____self_34, if ____t_33(____temp_32) then __O[3004] else "null")
            local ____t_45 = __t
            local ____t_44 = __t
            local ____t_42 = __t
            local ____t_40 = __t
            local ____opt_result_38
            if record ~= nil then
                ____opt_result_38 = record.schema
            end
            local ____temp_39 = ____opt_result_38 == 1
            __O[3005] = ____temp_39
            local ____temp_41 = if ____t_40(____temp_39) then record.layouts else __O[3005]
            __O[3006] = ____temp_41
            local ____temp_43 = if ____t_42(____temp_41) then type(record.layouts) == "table" else __O[3006]
            __O[3007] = ____temp_43
            if ____t_45(if ____t_44(____temp_43) then not __isArray(record.layouts) else __O[3007]) then
                layouts = record.layouts
            end
        end)
    end
    local targets = __TS__New(Map)
    local panel = window.document:createElement("section")
    panel.id = "campaignControlsEditor"
    panel.className = "campaign-controls-editor"
    panel.hidden = true
    panel:setAttribute("role", "dialog")
    panel:setAttribute("aria-modal", "true")
    panel:setAttribute("aria-labelledby", "campaignControlsHeading")
    panel.innerHTML = "<header><span>O CADERNO DA CAMPANHA</span><button type=\"button\" data-ccl-collapse aria-expanded=\"true\" aria-label=\"Recolher painel para liberar os botões\" title=\"Recolher painel para arrastar os botões abaixo dele\">−</button><button type=\"button\" data-ccl-done aria-label=\"Concluir ajuste dos botões\">×</button></header><h2 id=\"campaignControlsHeading\">CADA POLEGAR TEM SEU JEITO.</h2><p>Arraste os botões e o joystick. Toque em um para mudar o tamanho.</p><div class=\"ccl-selection\"><label for=\"campaignControlTarget\">AJUSTANDO<select id=\"campaignControlTarget\"></select></label><output id=\"campaignControlSize\" for=\"campaignControlScale\">100 px</output></div><input type=\"range\" id=\"campaignControlScale\" min=\"40\" max=\"180\" step=\"1\" aria-label=\"Tamanho do controle selecionado\"><div class=\"ccl-footer\"><button type=\"button\" data-ccl-keys>TECLAS DO PC</button><button type=\"button\" data-ccl-reset>RESTAURAR</button><button type=\"button\" data-ccl-done>PRONTO ✓</button></div><small id=\"campaignControlSaved\" role=\"status\" aria-live=\"polite\"></small>"
    shell:append(panel)
    local choose = panel:querySelector("#campaignControlTarget")
    local range = panel:querySelector("#campaignControlScale")
    local sizeLabel = panel:querySelector("#campaignControlSize")
    local saveLabel = panel:querySelector("#campaignControlSaved")
    local function setting(self, id)
        local ____t_47 = __t
        local ____get_result_46 = __get(
            __get(defaults, orientation),
            id
        )
        __O[3008] = ____get_result_46
        local base = if ____t_47(____get_result_46) then __O[3008] else __get(defaults, orientation).paper
        local record = __getq(
            __get(layouts, orientation),
            id
        )
        local ____isFiniteN_51 = __isFiniteN
        local ____opt_result_50
        if record ~= nil then
            ____opt_result_50 = record.x
        end
        local ____temp_60 = if ____isFiniteN_51(____opt_result_50) then clamp(nil, record.x, 0, 1) else __get(base, 0)
        local ____isFiniteN_55 = __isFiniteN
        local ____opt_result_54
        if record ~= nil then
            ____opt_result_54 = record.y
        end
        local ____temp_61 = if ____isFiniteN_55(____opt_result_54) then clamp(nil, record.y, 0, 1) else __get(base, 1)
        local ____isFiniteN_59 = __isFiniteN
        local ____opt_result_58
        if record ~= nil then
            ____opt_result_58 = record.size
        end
        return {x = ____temp_60, y = ____temp_61, size = if ____isFiniteN_59(____opt_result_58) then clamp(nil, record.size, if id == "joystick" then 80 else 40, if id == "joystick" then 180 else 110) else __get(base, 2)}
    end
    local function persist(self)
        do
            local function ____catch()
                saved = false
            end
            local ____try = pcall(function()
                window.localStorage:setItem(
                    KEY,
                    window.JSON:stringify({schema = 1, layouts = layouts})
                )
                saved = true
            end)
            if not ____try then
                ____catch()
            end
        end
        saveLabel.textContent = __add(
            __add(
                __add(if __t(saved) then "SALVO NESTE APARELHO" else "VALE ATÉ FECHAR O JOGO", " · "),
                if orientation == "landscape" then "TELA DEITADA" else "TELA EM PÉ"
            ),
            " · CAMPANHA PAUSADA"
        )
    end
    local function selectedUI(self)
        local value = setting(nil, selected)
        choose.value = selected
        range.min = if selected == "joystick" then "80" else "40"
        range.max = if selected == "joystick" then "180" else "110"
        range.value = value.size
        sizeLabel.textContent = __add(
            math.floor(value.size + 0.5),
            " px"
        )
        for ____, ____value in __iterar((targets)) do
            local id = ____value[1]
            local target = ____value[2]
            target.classList:toggle("campaign-layout-selected", if __t(editing) then id == selected else editing)
        end
    end
    local function readPlane(self)
        local rect = shell:getBoundingClientRect()
        local ____opt_62 = window.document:getElementById("gameCanvas")
        local canvas = ____opt_62 and ____opt_62:getBoundingClientRect()
        local ____opt_64 = shell:querySelector(".game-topbar")
        local hud = ____opt_64 and ____opt_64:getBoundingClientRect()
        local ____opt_66 = shell:querySelector(".progress-hud")
        local progress = ____opt_66 and ____opt_66:getBoundingClientRect()
        local ____t_69 = __t
        local ____temp_68 = shell.classList:contains("immersive")
        __O[3009] = ____temp_68
        local immersive = if ____t_69(____temp_68) then __O[3009] else window.document.body.classList:contains("shell-experience")
        local ____t_77 = __t
        local ____temp_76 = canvas and canvas.top
        __O[3010] = ____temp_76
        local top = if __t(immersive) then math.max(0, if __t(hud and hud.height) then hud.bottom else rect.top - rect.top, if __t(progress and progress.height) then progress.bottom else rect.top - rect.top) else math.max(0, if ____t_77(____temp_76) then __O[3010] else rect.top - rect.top)
        local ____top_82 = top
        local ____math_max_result_83 = math.max(1, rect.width)
        local ____t_81 = __t
        local ____temp_80 = canvas and canvas.height
        __O[3011] = ____temp_80
        plane = {
            left = 0,
            top = ____top_82,
            width = ____math_max_result_83,
            height = math.max(120, if __t(immersive) then rect.height - top else if ____t_81(____temp_80) then __O[3011] else rect.height - top)
        }
        layer.style:setProperty(
            "--ccl-left",
            __add(plane.left, "px")
        )
        layer.style:setProperty(
            "--ccl-top",
            __add(plane.top, "px")
        )
        layer.style:setProperty(
            "--ccl-width",
            __add(plane.width, "px")
        )
        layer.style:setProperty(
            "--ccl-height",
            __add(plane.height, "px")
        )
        orientation = if plane.width >= plane.height then "landscape" else "portrait"
        return rect
    end
    local function apply(self)
        if not __t(targets.size) then
            return
        end
        readPlane(nil)
        local style = window:getComputedStyle(shell)
        local safe = {}
        for ____, side in __iterar((__arrL({"left", "right", "bottom"}, 3))) do
            local ____set_86 = __set
            local ____t_85 = __t
            local ____TS__ParseFloat_result_84 = __TS__ParseFloat(style:getPropertyValue(__add("--ccl-safe-", side)))
            __O[3012] = ____TS__ParseFloat_result_84
            ____set_86(
                safe,
                side,
                math.max(7, if ____t_85(____TS__ParseFloat_result_84) then __O[3012] else 0 + 7)
            )
        end
        for ____, ____value in __iterar((targets)) do
            local id = ____value[1]
            local target = ____value[2]
            local value = setting(nil, id)
            local size = math.max(
                40,
                math.min(value.size, plane.width - safe.left - safe.right, plane.height - 14)
            )
            local x = clamp(nil, value.x * plane.width, size / 2 + safe.left, plane.width - size / 2 - safe.right)
            local y = clamp(nil, value.y * plane.height, size / 2 + 7, plane.height - size / 2 - safe.bottom)
            target.style:setProperty(
                "--ccl-x",
                __add(x, "px")
            )
            target.style:setProperty(
                "--ccl-y",
                __add(y, "px")
            )
            target.style:setProperty(
                "--ccl-size",
                __add(size, "px")
            )
        end
        selectedUI(nil)
    end
    local function put(self, id, value)
        local ____t_89 = __t
        local ____t_88 = __t
        local ____temp_87 = not __t(__get(layouts, orientation)) or type(__get(layouts, orientation)) ~= "table"
        __O[3013] = ____temp_87
        if ____t_89(if ____t_88(____temp_87) then __O[3013] else __isArray(__get(layouts, orientation))) then
            __set(layouts, orientation, {})
        end
        __set(
            __get(layouts, orientation),
            id,
            __assign(
                {},
                setting(nil, id),
                value
            )
        )
        apply(nil)
        persist(nil)
    end
    local function discover(self)
        local entries = __arr(
            __arrL({"joystick", joystick}, 2),
            __TS__Spread(__iter(__call(
                __call(
                    __arr(__TS__Spread(__iter(layer:querySelectorAll("button[data-action]")))),
                    "filter",
                    function(____, e) return __get(names, e.dataset.action) end
                ),
                "map",
                function(____, e) return __arrL({e.dataset.action, e}, 2) end
            )))
        )
        local changed = false
        for ____, ____value in __iterar((entries)) do
            local id = ____value[1]
            local target = ____value[2]
            if not __t(__call(targets, "has", id)) then
                __call(targets, "set", id, target)
                target.dataset.campaignLayoutId = id
                __call(target.classList, "add", "campaign-layout-target")
                local option = window.document:createElement("option")
                option.value = id
                option.textContent = __get(names, id)
                choose:append(option)
                changed = true
            end
        end
        return changed
    end
    local function sync(self)
        scheduled = false
        discover(nil)
        local s = state(nil)
        local ____t_95 = __t
        local ____opt_92 = window.Campanha2
        if ____opt_92 ~= nil then
            ____opt_92 = ____opt_92.aberto
        end
        local ____opt_result_94
        if ____opt_92 ~= nil then
            ____opt_result_94 = ____opt_92(____opt_92)
        end
        local c2 = not not ____t_95(____opt_result_94)
        local ____t_101 = __t
        local ____t_99 = __t
        local ____t_97 = __t
        local ____temp_96 = not not __t(s.started) and not __t(s.won)
        __O[3014] = ____temp_96
        local ____temp_98 = if ____t_97(____temp_96) then not __t(s.defeated) else __O[3014]
        __O[3015] = ____temp_98
        local ____temp_100 = if ____t_99(____temp_98) then not __t(s.chapterEnded) else __O[3015]
        __O[3016] = ____temp_100
        local active = if __t(c2) then c2 else if ____t_101(____temp_100) then not __t(otherMode(nil)) else __O[3016]
        local ready = if __t(active) then active else editing
        local ____t_114 = __t
        local ____t_109 = __t
        local ____t_107 = __t
        local ____t_105 = __t
        local ____t_103 = __t
        local ____temp_102 = if __t(active) then not __t(s.paused) else active
        __O[3017] = ____temp_102
        local ____temp_104 = if ____t_103(____temp_102) then not __t(s.dialog) else __O[3017]
        __O[3018] = ____temp_104
        local ____temp_106 = if ____t_105(____temp_104) then not __t(s.cutscene) else __O[3018]
        __O[3019] = ____temp_106
        local ____temp_108 = if ____t_107(____temp_106) then not __t(s.activity) else __O[3019]
        __O[3020] = ____temp_108
        local ____t_112 = __t
        local ____opt_110 = s.training
        if ____opt_110 ~= nil then
            ____opt_110 = ____opt_110.active
        end
        local ____temp_113 = if ____t_109(____temp_108) then not ____t_112(____opt_110) else __O[3020]
        __O[3021] = ____temp_113
        local playable = if ____t_114(____temp_113) then not __t(s.routeTransition) else __O[3021]
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({"campaign-layout-ready", ready}, 2),
                __arrL({"campaign-layout-playable", playable}, 2),
                __arrL({"campaign-layout-editing", editing}, 2)
            },
            3
        ))) do
            local name = ____value[1]
            local value = ____value[2]
            if shell.classList:contains(name) ~= value then
                shell.classList:toggle(name, value)
            end
        end
        if __t(ready) then
            apply(nil)
        end
        if not __t(editing) then
            local ____t_125 = __t
            local ____t_124 = __t
            local ____t_122 = __t
            local ____t_118 = __t
            local ____t_116 = __t
            local ____temp_115 = if __t(s.dialog) then s.dialog else s.cutscene
            __O[3022] = ____temp_115
            local ____temp_117 = if ____t_116(____temp_115) then __O[3022] else s.activity
            __O[3023] = ____temp_117
            local ____opt_119 = s.training
            if ____opt_119 ~= nil then
                ____opt_119 = ____opt_119.active
            end
            local ____temp_121 = if ____t_118(____temp_117) then __O[3023] else ____opt_119
            __O[3024] = ____temp_121
            local ____temp_123 = if ____t_122(____temp_121) then __O[3024] else s.routeTransition
            __O[3025] = ____temp_123
            entry.disabled = not not ____t_125(if ____t_124(____temp_123) then __O[3025] else otherMode(nil))
            settingsEntry.disabled = entry.disabled
        end
    end
    local function schedule(self)
        if __t(scheduled) then
            return
        end
        scheduled = true
        window:requestAnimationFrame(sync)
    end
    local function release(self)
        local ____opt_128 = window.Game
        if ____opt_128 ~= nil then
            ____opt_128 = ____opt_128.releaseInputs
        end
        if ____opt_128 ~= nil then
            ____opt_128(____opt_128)
        end
        local ____opt_132 = window.Joystick
        if ____opt_132 ~= nil then
            ____opt_132 = ____opt_132.reset
        end
        if ____opt_132 ~= nil then
            ____opt_132(____opt_132)
        end
    end
    local function capture(self, active)
        window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {active = active}}))
        release(nil)
    end
    local function open(self)
        if __t(editing) then
            return true
        end
        local s = state(nil)
        local ____t_152 = __t
        local ____t_151 = __t
        local ____t_149 = __t
        local ____t_147 = __t
        local ____t_145 = __t
        local ____t_141 = __t
        local ____t_139 = __t
        local ____t_137 = __t
        local ____t_135 = __t
        local ____otherMode_result_134 = otherMode(nil)
        __O[3026] = ____otherMode_result_134
        local ____temp_136 = if ____t_135(____otherMode_result_134) then __O[3026] else s.dialog
        __O[3027] = ____temp_136
        local ____temp_138 = if ____t_137(____temp_136) then __O[3027] else s.cutscene
        __O[3028] = ____temp_138
        local ____temp_140 = if ____t_139(____temp_138) then __O[3028] else s.activity
        __O[3029] = ____temp_140
        local ____opt_142 = s.training
        if ____opt_142 ~= nil then
            ____opt_142 = ____opt_142.active
        end
        local ____temp_144 = if ____t_141(____temp_140) then __O[3029] else ____opt_142
        __O[3030] = ____temp_144
        local ____temp_146 = if ____t_145(____temp_144) then __O[3030] else s.routeTransition
        __O[3031] = ____temp_146
        local ____temp_148 = if ____t_147(____temp_146) then __O[3031] else s.defeated
        __O[3032] = ____temp_148
        local ____temp_150 = if ____t_149(____temp_148) then __O[3032] else s.won
        __O[3033] = ____temp_150
        if ____t_152(if ____t_151(____temp_150) then __O[3033] else s.chapterEnded) then
            return false
        end
        if __t(window.document:querySelector("dialog[open]")) then
            return false
        end
        returnFocus = window.document.activeElement
        resumeAfter = not not __t(if __t(s.started) then not __t(s.paused) else s.started)
        if __t(resumeAfter) then
            local ____opt_155 = window.Game
            if ____opt_155 ~= nil then
                ____opt_155 = ____opt_155.pause
            end
            if ____opt_155 ~= nil then
                ____opt_155(____opt_155)
            end
        end
        editing = true
        panel.classList:remove("is-collapsed")
        panel:querySelector("[data-ccl-collapse]").textContent = "−"
        panel:querySelector("[data-ccl-collapse]"):setAttribute("aria-expanded", "true")
        local viewport = window.document:getElementById("gameViewport")
        previousInert = not not __t(viewport and viewport.inert)
        if __t(viewport) then
            viewport.inert = true
        end
        capture(nil, true)
        panel.hidden = false
        sync(nil)
        persist(nil)
        choose:focus({preventScroll = true})
        return true
    end
    local function close(self)
        if not __t(editing) then
            return
        end
        pointer = nil
        editing = false
        panel.hidden = true
        local viewport = window.document:getElementById("gameViewport")
        if __t(viewport) then
            viewport.inert = previousInert
        end
        capture(nil, false)
        local resume = resumeAfter
        resumeAfter = false
        sync(nil)
        local ____t_161 = __t
        local ____t_160 = __t
        local ____temp_159 = if __t(resume) then state(nil).started else resume
        __O[3034] = ____temp_159
        if ____t_161(if ____t_160(____temp_159) then not __t(window.document:querySelector("dialog[open]")) else __O[3034]) then
            local ____opt_164 = window.Game
            if ____opt_164 ~= nil then
                ____opt_164 = ____opt_164.resume
            end
            if ____opt_164 ~= nil then
                ____opt_164(____opt_164)
            end
        end
        release(nil)
        window:requestAnimationFrame(function()
            local ____t_168 = __t
            local ____t_167 = __t
            local ____state_result_started_166 = state(nil).started
            __O[3035] = ____state_result_started_166
            if ____t_168(if ____t_167(____state_result_started_166) then not __t(state(nil).paused) else __O[3035]) then
                local ____opt_169 = window.document:getElementById("gameCanvas")
                if ____opt_169 ~= nil then
                    ____opt_169:focus({preventScroll = true})
                end
            else
                local ____t_174 = __t
                local ____opt_result_173
                if returnFocus ~= nil then
                    ____opt_result_173 = returnFocus.isConnected
                end
                if ____t_174(____opt_result_173) then
                    returnFocus:focus({preventScroll = true})
                end
            end
        end)
    end
    local function fromSettings(self)
        if __t(otherMode(nil)) then
            return
        end
        local modal = window.document:getElementById("controlSettingsModal")
        if __t(modal and modal.open) then
            modal:addEventListener(
                "close",
                function() return open(nil) end,
                {once = true}
            )
            local ____opt_179 = window.ControlSettingsUI
            if ____opt_179 ~= nil then
                ____opt_179 = ____opt_179.close
            end
            if ____opt_179 ~= nil then
                ____opt_179(____opt_179)
            end
        else
            open(nil)
        end
    end
    entry = window.document:createElement("button")
    entry.id = "ranchTouchLayoutBtn"
    entry.type = "button"
    entry.className = "rp-action"
    entry.innerHTML = "<svg viewBox=\"0 0 32 32\" aria-hidden=\"true\"><path d=\"M4 4h9v9H4zm15 0h9v9h-9zM4 19h9v9H4zm15 0h9v9h-9z\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\"/><path d=\"m13 10 6 6-6 6m-3-9 6 6 6-6\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\"/></svg><span><b>BOTÕES DA CAMPANHA</b><small>Arraste, aumente e deixe do seu jeito.</small></span><i aria-hidden=\"true\">›</i>"
    entry:addEventListener("click", open)
    local ____t_184 = __t
    local ____opt_181 = window.document:getElementById("ranchControlsBtn")
    local ____temp_183 = ____opt_181 and ____opt_181:insertAdjacentElement("afterend", entry)
    __O[3036] = ____temp_183
    local ____opt_185 = window.document:querySelector("#pauseScreen .game-modal")
    local ____ = if ____t_184(____temp_183) then __O[3036] else ____opt_185 and ____opt_185:append(entry)
    settingsEntry = window.document:createElement("button")
    settingsEntry.id = "campaignLayoutSettingsBtn"
    settingsEntry.type = "button"
    settingsEntry.className = "controls-configure-link campaign-layout-settings-link"
    settingsEntry.innerHTML = "POSIÇÃO E TAMANHO DOS BOTÕES <span>↗</span>"
    settingsEntry:addEventListener("click", fromSettings)
    local ____opt_187 = window.document:querySelector("#controlSettingsModal .controls-tabs")
    if ____opt_187 ~= nil then
        ____opt_187:insertAdjacentElement("beforebegin", settingsEntry)
    end
    panel:querySelector("[data-ccl-collapse]"):addEventListener(
        "click",
        function(____, event)
            local collapsed = panel.classList:toggle("is-collapsed")
            event.currentTarget.textContent = if __t(collapsed) then "+" else "−"
            event.currentTarget:setAttribute(
                "aria-expanded",
                tostring(not __t(collapsed))
            )
            event.currentTarget:setAttribute("aria-label", if __t(collapsed) then "Expandir painel de tamanho dos botões" else "Recolher painel para liberar os botões")
        end
    )
    choose:addEventListener(
        "change",
        function()
            selected = choose.value
            selectedUI(nil)
        end
    )
    range:addEventListener(
        "input",
        function() return put(
            nil,
            selected,
            {size = __TS__Number(range.value)}
        ) end
    )
    __call(
        panel:querySelectorAll("[data-ccl-done]"),
        "forEach",
        function(____, button) return button:addEventListener("click", close) end
    )
    panel:querySelector("[data-ccl-reset]"):addEventListener(
        "click",
        function()
            __del(layouts, orientation)
            apply(nil)
            persist(nil)
        end
    )
    panel:querySelector("[data-ccl-keys]"):addEventListener(
        "click",
        function()
            close(nil)
            local ____opt_191 = window.ControlSettingsUI
            if ____opt_191 ~= nil then
                ____opt_191 = ____opt_191.open
            end
            if ____opt_191 ~= nil then
                ____opt_191(____opt_191)
            end
        end
    )
    local function intercept(self, event)
        local ____t_197 = __t
        local ____temp_196 = not __t(editing)
        if not ____temp_196 then
            local ____t_195 = __t
            local ____this_194
            ____this_194 = event.target
            local ____opt_193 = ____this_194.closest
            if ____opt_193 ~= nil then
                ____opt_193 = ____opt_193(____this_194, ".touch-controls")
            end
            ____temp_196 = not ____t_195(____opt_193)
        end
        if ____t_197(____temp_196) then
            return
        end
        local target = event.target:closest(".campaign-layout-target")
        if not __t(target) then
            return
        end
        event:preventDefault()
        event:stopImmediatePropagation()
        if event.type == "pointerdown" then
            if __t(event.pointerType == "mouse" and event.button ~= 0) then
                return
            end
            selected = target.dataset.campaignLayoutId
            selectedUI(nil)
            local rect = target:getBoundingClientRect()
            pointer = {id = event.pointerId, target = target, offsetX = event.clientX - rect.left - rect.width / 2, offsetY = event.clientY - rect.top - rect.height / 2}
            do
                pcall(function()
                    target:setPointerCapture(event.pointerId)
                end)
            end
        else
            local ____t_202 = __t
            local ____temp_201 = event.type == "pointermove"
            if ____temp_201 then
                local ____opt_result_200
                if pointer ~= nil then
                    ____opt_result_200 = pointer.id
                end
                ____temp_201 = ____opt_result_200 == event.pointerId
            end
            if ____t_202(____temp_201) then
                local bounds = layer:getBoundingClientRect()
                put(
                    nil,
                    selected,
                    {
                        x = clamp(nil, (event.clientX - bounds.left - pointer.offsetX) / plane.width, 0, 1),
                        y = clamp(nil, (event.clientY - bounds.top - pointer.offsetY) / plane.height, 0, 1)
                    }
                )
            else
                local ____t_208 = __t
                local ____t_204 = __t
                local ____call_result_203 = __call(
                    __arrL({"pointerup", "pointercancel", "lostpointercapture"}, 3),
                    "includes",
                    event.type
                )
                __O[3037] = ____call_result_203
                local ____opt_result_207
                if pointer ~= nil then
                    ____opt_result_207 = pointer.id
                end
                if ____t_208(if ____t_204(____call_result_203) then ____opt_result_207 == event.pointerId else __O[3037]) then
                    pointer = nil
                    persist(nil)
                end
            end
        end
    end
    for ____, ____type in __iterar((__arrL({
        "pointerdown",
        "pointermove",
        "pointerup",
        "pointercancel",
        "lostpointercapture",
        "click",
        "contextmenu",
        "touchstart",
        "touchmove",
        "touchend"
    }, 10))) do
        window.document:addEventListener(
            ____type,
            intercept,
            __ord({capture = true, passive = false}, "capture,passive")
        )
    end
    window:addEventListener(
        "keydown",
        function(____, event)
            if not __t(editing) then
                return
            end
            event:stopImmediatePropagation()
            if event.code == "Escape" then
                event:preventDefault()
                close(nil)
                return
            end
            if event.key == "Tab" then
                local list = __call(
                    __arr(__TS__Spread(__iter(panel:querySelectorAll("button,input,select")))),
                    "filter",
                    function(____, e)
                        local ____t_210 = __t
                        local ____temp_209 = not __t(e.hidden) and not __t(e.disabled)
                        __O[3038] = ____temp_209
                        return if ____t_210(____temp_209) then __len(e:getClientRects()) else __O[3038]
                    end
                )
                local first = __get(list, 0)
                local last = __get(
                    list,
                    __len(list) - 1
                )
                if __t(if __t(event.shiftKey) then window.document.activeElement == first else event.shiftKey) then
                    event:preventDefault()
                    last:focus()
                elseif __t(not __t(event.shiftKey) and window.document.activeElement == last) then
                    event:preventDefault()
                    first:focus()
                end
                return
            end
            if not __t(panel:contains(event.target)) then
                event:preventDefault()
            end
        end,
        true
    )
    window:addEventListener(
        "keyup",
        function(____, event)
            if __t(editing) then
                event:stopImmediatePropagation()
            end
        end,
        true
    )
    window:addEventListener(
        "blur",
        function()
            pointer = nil
            release(nil)
        end
    )
    window:addEventListener(
        "pagehide",
        function()
            pointer = nil
            release(nil)
        end
    )
    local observer = __new("MutationObserver", schedule)
    observer:observe(
        shell,
        __ord(
            {
                attributes = true,
                attributeFilter = __arrL({"class"}, 1)
            },
            "attributes,attributeFilter"
        )
    )
    observer:observe(
        window.document:getElementById("startScreen"),
        __ord(
            {
                attributes = true,
                attributeFilter = __arrL({"hidden"}, 1)
            },
            "attributes,attributeFilter"
        )
    )
    observer:observe(
        layer,
        __ord({childList = true, subtree = true}, "childList,subtree")
    )
    local resize = __new("ResizeObserver", schedule)
    resize:observe(shell)
    local hud = shell:querySelector(".game-topbar")
    if __t(hud) then
        resize:observe(hud)
    end
    local viewport = window.document:getElementById("gameViewport")
    if __t(viewport) then
        resize:observe(viewport)
    end
    window:addEventListener(
        "orientationchange",
        function()
            pointer = nil
            release(nil)
            schedule(nil)
        end
    )
    window:addEventListener("resize", schedule)
    window:addEventListener("c2-controles", schedule)
    local ____opt_211 = window.visualViewport
    if ____opt_211 ~= nil then
        ____opt_211:addEventListener("resize", schedule)
    end
    window.CampaignControls = __ord(
        {
            open = open,
            close = close,
            isOpen = function() return editing end,
            getStatus = function() return {
                editing = editing,
                orientation = orientation,
                selected = selected,
                saved = saved,
                key = KEY,
                plane = __assign({}, plane),
                layout = __TS__ObjectFromEntries(__call(
                    __arr(__TS__Spread(__iter(__call(targets, "keys")))),
                    "map",
                    function(____, id) return __arrL(
                        {
                            id,
                            setting(nil, id)
                        },
                        2
                    ) end
                )),
                targets = __arr(__TS__Spread(__iter(__call(targets, "keys"))))
            } end
        },
        "open,close,isOpen,getStatus"
    )
    discover(nil)
    schedule(nil)
end)(nil)
return ____exports
