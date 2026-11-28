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
    local ____t_7 = __t
    local ____t_result_6
    local ____t_5 = __t
    local ____t_result_4
    local ____t_3 = __t
    local ____temp_2 = not __t(shell) or not __t(layer)
    __O[3044] = ____temp_2
    if ____t_3(____temp_2) then
        ____t_result_4 = __O[3044]
    else
        ____t_result_4 = not __t(joystick)
    end
    __O[3045] = ____t_result_4
    if ____t_5(____t_result_4) then
        ____t_result_6 = __O[3045]
    else
        ____t_result_6 = window.CampaignControls
    end
    if ____t_7(____t_result_6) then
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
        local ____t_result_14
        local ____t_13 = __t
        local ____opt_10 = window.Game
        if ____opt_10 ~= nil then
            ____opt_10 = ____opt_10.getState
        end
        local ____opt_result_12
        if ____opt_10 ~= nil then
            ____opt_result_12 = ____opt_10(____opt_10)
        end
        __O[3046] = ____opt_result_12
        if ____t_13(____opt_result_12) then
            ____t_result_14 = __O[3046]
        else
            ____t_result_14 = {}
        end
        return ____t_result_14
    end
    local function otherMode()
        local ____t_34 = __t
        local ____t_result_33
        local ____t_27 = __t
        local ____t_result_26
        local ____t_20 = __t
        local ____opt_17 = window.Arena
        if ____opt_17 ~= nil then
            ____opt_17 = ____opt_17.isOpen
        end
        local ____opt_result_19
        if ____opt_17 ~= nil then
            ____opt_result_19 = ____opt_17(____opt_17)
        end
        __O[3047] = ____opt_result_19
        if ____t_20(____opt_result_19) then
            ____t_result_26 = __O[3047]
        else
            local ____opt_23 = window.CoopArena
            if ____opt_23 ~= nil then
                ____opt_23 = ____opt_23.getStatus
            end
            local ____opt_result_25
            if ____opt_23 ~= nil then
                ____opt_result_25 = ____opt_23(____opt_23).open
            end
            ____t_result_26 = ____opt_result_25
        end
        __O[3048] = ____t_result_26
        if ____t_27(____t_result_26) then
            ____t_result_33 = __O[3048]
        else
            local ____opt_30 = window.PartyGame
            if ____opt_30 ~= nil then
                ____opt_30 = ____opt_30.getStatus
            end
            local ____opt_result_32
            if ____opt_30 ~= nil then
                ____opt_result_32 = ____opt_30(____opt_30).open
            end
            ____t_result_33 = ____opt_result_32
        end
        return not not ____t_34(____t_result_33)
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
            local ____self_38 = window.JSON
            local ____self_38_parse_39 = ____self_38.parse
            local ____t_result_37
            local ____t_36 = __t
            local ____temp_35 = window.localStorage:getItem(KEY)
            __O[3049] = ____temp_35
            if ____t_36(____temp_35) then
                ____t_result_37 = __O[3049]
            else
                ____t_result_37 = "null"
            end
            local record = ____self_38_parse_39(____self_38, ____t_result_37)
            local ____t_50 = __t
            local ____t_result_49
            local ____t_48 = __t
            local ____t_result_47
            local ____t_46 = __t
            local ____t_result_45
            local ____t_44 = __t
            local ____opt_result_42
            if record ~= nil then
                ____opt_result_42 = record.schema
            end
            local ____temp_43 = ____opt_result_42 == 1
            __O[3050] = ____temp_43
            if ____t_44(____temp_43) then
                ____t_result_45 = record.layouts
            else
                ____t_result_45 = __O[3050]
            end
            __O[3051] = ____t_result_45
            if ____t_46(____t_result_45) then
                ____t_result_47 = type(record.layouts) == "table"
            else
                ____t_result_47 = __O[3051]
            end
            __O[3052] = ____t_result_47
            if ____t_48(____t_result_47) then
                ____t_result_49 = not __isArray(record.layouts)
            else
                ____t_result_49 = __O[3052]
            end
            if ____t_50(____t_result_49) then
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
        local ____t_result_53
        local ____t_52 = __t
        local ____get_result_51 = __get(
            __get(defaults, orientation),
            id
        )
        __O[3053] = ____get_result_51
        if ____t_52(____get_result_51) then
            ____t_result_53 = __O[3053]
        else
            ____t_result_53 = __get(defaults, orientation).paper
        end
        local base = ____t_result_53
        local record = __getq(
            __get(layouts, orientation),
            id
        )
        local ____isFiniteN_result_58
        local ____isFiniteN_57 = __isFiniteN
        local ____opt_result_56
        if record ~= nil then
            ____opt_result_56 = record.x
        end
        if ____isFiniteN_57(____opt_result_56) then
            ____isFiniteN_result_58 = clamp(nil, record.x, 0, 1)
        else
            ____isFiniteN_result_58 = __get(base, 0)
        end
        local ____isFiniteN_result_63
        local ____isFiniteN_62 = __isFiniteN
        local ____opt_result_61
        if record ~= nil then
            ____opt_result_61 = record.y
        end
        if ____isFiniteN_62(____opt_result_61) then
            ____isFiniteN_result_63 = clamp(nil, record.y, 0, 1)
        else
            ____isFiniteN_result_63 = __get(base, 1)
        end
        local ____isFiniteN_result_68
        local ____isFiniteN_67 = __isFiniteN
        local ____opt_result_66
        if record ~= nil then
            ____opt_result_66 = record.size
        end
        if ____isFiniteN_67(____opt_result_66) then
            ____isFiniteN_result_68 = clamp(nil, record.size, id == "joystick" and 80 or 40, id == "joystick" and 180 or 110)
        else
            ____isFiniteN_result_68 = __get(base, 2)
        end
        return {x = ____isFiniteN_result_58, y = ____isFiniteN_result_63, size = ____isFiniteN_result_68}
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
                __add(
                    __t(saved) and "SALVO NESTE APARELHO" or "VALE ATÉ FECHAR O JOGO",
                    " · "
                ),
                orientation == "landscape" and "TELA DEITADA" or "TELA EM PÉ"
            ),
            " · CAMPANHA PAUSADA"
        )
    end
    local function selectedUI(self)
        local value = setting(nil, selected)
        choose.value = selected
        range.min = selected == "joystick" and "80" or "40"
        range.max = selected == "joystick" and "180" or "110"
        range.value = value.size
        sizeLabel.textContent = __add(
            math.floor(value.size + 0.5),
            " px"
        )
        for ____, ____value in __iterar((targets)) do
            local id = ____value[1]
            local target = ____value[2]
            local ____self_70 = target.classList
            local ____self_70_toggle_71 = ____self_70.toggle
            local ____t_result_69
            if __t(editing) then
                ____t_result_69 = id == selected
            else
                ____t_result_69 = editing
            end
            ____self_70_toggle_71(____self_70, "campaign-layout-selected", ____t_result_69)
        end
    end
    local function readPlane(self)
        local rect = shell:getBoundingClientRect()
        local ____opt_72 = window.document:getElementById("gameCanvas")
        local canvas = ____opt_72 and ____opt_72:getBoundingClientRect()
        local ____opt_74 = shell:querySelector(".game-topbar")
        local hud = ____opt_74 and ____opt_74:getBoundingClientRect()
        local ____opt_76 = shell:querySelector(".progress-hud")
        local progress = ____opt_76 and ____opt_76:getBoundingClientRect()
        local ____t_result_80
        local ____t_79 = __t
        local ____temp_78 = shell.classList:contains("immersive")
        __O[3054] = ____temp_78
        if ____t_79(____temp_78) then
            ____t_result_80 = __O[3054]
        else
            ____t_result_80 = window.document.body.classList:contains("shell-experience")
        end
        local immersive = ____t_result_80
        local ____t_result_93
        if __t(immersive) then
            local ____t_result_83
            if __t(hud and hud.height) then
                ____t_result_83 = hud.bottom
            else
                ____t_result_83 = rect.top
            end
            local ____temp_87 = ____t_result_83 - rect.top
            local ____t_result_86
            if __t(progress and progress.height) then
                ____t_result_86 = progress.bottom
            else
                ____t_result_86 = rect.top
            end
            ____t_result_93 = math.max(0, ____temp_87, ____t_result_86 - rect.top)
        else
            local ____t_result_92
            local ____t_91 = __t
            local ____temp_90 = canvas and canvas.top
            __O[3055] = ____temp_90
            if ____t_91(____temp_90) then
                ____t_result_92 = __O[3055]
            else
                ____t_result_92 = rect.top
            end
            ____t_result_93 = math.max(0, ____t_result_92 - rect.top)
        end
        local top = ____t_result_93
        local ____top_100 = top
        local ____math_max_result_101 = math.max(1, rect.width)
        local ____t_result_99
        if __t(immersive) then
            ____t_result_99 = rect.height - top
        else
            local ____t_result_98
            local ____t_97 = __t
            local ____temp_96 = canvas and canvas.height
            __O[3056] = ____temp_96
            if ____t_97(____temp_96) then
                ____t_result_98 = __O[3056]
            else
                ____t_result_98 = rect.height - top
            end
            ____t_result_99 = ____t_result_98
        end
        plane = {
            left = 0,
            top = ____top_100,
            width = ____math_max_result_101,
            height = math.max(120, ____t_result_99)
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
        orientation = plane.width >= plane.height and "landscape" or "portrait"
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
            local ____set_105 = __set
            local ____t_result_104
            local ____t_103 = __t
            local ____TS__ParseFloat_result_102 = __TS__ParseFloat(style:getPropertyValue(__add("--ccl-safe-", side)))
            __O[3057] = ____TS__ParseFloat_result_102
            if ____t_103(____TS__ParseFloat_result_102) then
                ____t_result_104 = __O[3057]
            else
                ____t_result_104 = 0
            end
            ____set_105(
                safe,
                side,
                math.max(7, ____t_result_104 + 7)
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
        local ____t_109 = __t
        local ____t_result_108
        local ____t_107 = __t
        local ____temp_106 = not __t(__get(layouts, orientation)) or type(__get(layouts, orientation)) ~= "table"
        __O[3058] = ____temp_106
        if ____t_107(____temp_106) then
            ____t_result_108 = __O[3058]
        else
            ____t_result_108 = __isArray(__get(layouts, orientation))
        end
        if ____t_109(____t_result_108) then
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
        local ____t_115 = __t
        local ____opt_112 = window.Campanha2
        if ____opt_112 ~= nil then
            ____opt_112 = ____opt_112.aberto
        end
        local ____opt_result_114
        if ____opt_112 ~= nil then
            ____opt_result_114 = ____opt_112(____opt_112)
        end
        local c2 = not not ____t_115(____opt_result_114)
        local ____t_result_123
        if __t(c2) then
            ____t_result_123 = c2
        else
            local ____t_result_122
            local ____t_121 = __t
            local ____t_result_120
            local ____t_119 = __t
            local ____t_result_118
            local ____t_117 = __t
            local ____temp_116 = not not __t(s.started) and not __t(s.won)
            __O[3059] = ____temp_116
            if ____t_117(____temp_116) then
                ____t_result_118 = not __t(s.defeated)
            else
                ____t_result_118 = __O[3059]
            end
            __O[3060] = ____t_result_118
            if ____t_119(____t_result_118) then
                ____t_result_120 = not __t(s.chapterEnded)
            else
                ____t_result_120 = __O[3060]
            end
            __O[3061] = ____t_result_120
            if ____t_121(____t_result_120) then
                ____t_result_122 = not __t(otherMode(nil))
            else
                ____t_result_122 = __O[3061]
            end
            ____t_result_123 = ____t_result_122
        end
        local active = ____t_result_123
        local ____t_result_124
        if __t(active) then
            ____t_result_124 = active
        else
            ____t_result_124 = editing
        end
        local ready = ____t_result_124
        local ____t_result_138
        local ____t_137 = __t
        local ____t_result_136
        local ____t_132 = __t
        local ____t_result_131
        local ____t_130 = __t
        local ____t_result_129
        local ____t_128 = __t
        local ____t_result_127
        local ____t_126 = __t
        local ____t_result_125
        if __t(active) then
            ____t_result_125 = not __t(s.paused)
        else
            ____t_result_125 = active
        end
        __O[3062] = ____t_result_125
        if ____t_126(____t_result_125) then
            ____t_result_127 = not __t(s.dialog)
        else
            ____t_result_127 = __O[3062]
        end
        __O[3063] = ____t_result_127
        if ____t_128(____t_result_127) then
            ____t_result_129 = not __t(s.cutscene)
        else
            ____t_result_129 = __O[3063]
        end
        __O[3064] = ____t_result_129
        if ____t_130(____t_result_129) then
            ____t_result_131 = not __t(s.activity)
        else
            ____t_result_131 = __O[3064]
        end
        __O[3065] = ____t_result_131
        if ____t_132(____t_result_131) then
            local ____t_135 = __t
            local ____opt_133 = s.training
            if ____opt_133 ~= nil then
                ____opt_133 = ____opt_133.active
            end
            ____t_result_136 = not ____t_135(____opt_133)
        else
            ____t_result_136 = __O[3065]
        end
        __O[3066] = ____t_result_136
        if ____t_137(____t_result_136) then
            ____t_result_138 = not __t(s.routeTransition)
        else
            ____t_result_138 = __O[3066]
        end
        local playable = ____t_result_138
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
            local ____t_150 = __t
            local ____t_result_149
            local ____t_148 = __t
            local ____t_result_147
            local ____t_146 = __t
            local ____t_result_145
            local ____t_142 = __t
            local ____t_result_141
            local ____t_140 = __t
            local ____t_result_139
            if __t(s.dialog) then
                ____t_result_139 = s.dialog
            else
                ____t_result_139 = s.cutscene
            end
            __O[3067] = ____t_result_139
            if ____t_140(____t_result_139) then
                ____t_result_141 = __O[3067]
            else
                ____t_result_141 = s.activity
            end
            __O[3068] = ____t_result_141
            if ____t_142(____t_result_141) then
                ____t_result_145 = __O[3068]
            else
                local ____opt_143 = s.training
                if ____opt_143 ~= nil then
                    ____opt_143 = ____opt_143.active
                end
                ____t_result_145 = ____opt_143
            end
            __O[3069] = ____t_result_145
            if ____t_146(____t_result_145) then
                ____t_result_147 = __O[3069]
            else
                ____t_result_147 = s.routeTransition
            end
            __O[3070] = ____t_result_147
            if ____t_148(____t_result_147) then
                ____t_result_149 = __O[3070]
            else
                ____t_result_149 = otherMode(nil)
            end
            entry.disabled = not not ____t_150(____t_result_149)
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
        local ____opt_153 = window.Game
        if ____opt_153 ~= nil then
            ____opt_153 = ____opt_153.releaseInputs
        end
        if ____opt_153 ~= nil then
            ____opt_153(____opt_153)
        end
        local ____opt_157 = window.Joystick
        if ____opt_157 ~= nil then
            ____opt_157 = ____opt_157.reset
        end
        if ____opt_157 ~= nil then
            ____opt_157(____opt_157)
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
        local ____t_178 = __t
        local ____t_result_177
        local ____t_176 = __t
        local ____t_result_175
        local ____t_174 = __t
        local ____t_result_173
        local ____t_172 = __t
        local ____t_result_171
        local ____t_170 = __t
        local ____t_result_169
        local ____t_166 = __t
        local ____t_result_165
        local ____t_164 = __t
        local ____t_result_163
        local ____t_162 = __t
        local ____t_result_161
        local ____t_160 = __t
        local ____otherMode_result_159 = otherMode(nil)
        __O[3071] = ____otherMode_result_159
        if ____t_160(____otherMode_result_159) then
            ____t_result_161 = __O[3071]
        else
            ____t_result_161 = s.dialog
        end
        __O[3072] = ____t_result_161
        if ____t_162(____t_result_161) then
            ____t_result_163 = __O[3072]
        else
            ____t_result_163 = s.cutscene
        end
        __O[3073] = ____t_result_163
        if ____t_164(____t_result_163) then
            ____t_result_165 = __O[3073]
        else
            ____t_result_165 = s.activity
        end
        __O[3074] = ____t_result_165
        if ____t_166(____t_result_165) then
            ____t_result_169 = __O[3074]
        else
            local ____opt_167 = s.training
            if ____opt_167 ~= nil then
                ____opt_167 = ____opt_167.active
            end
            ____t_result_169 = ____opt_167
        end
        __O[3075] = ____t_result_169
        if ____t_170(____t_result_169) then
            ____t_result_171 = __O[3075]
        else
            ____t_result_171 = s.routeTransition
        end
        __O[3076] = ____t_result_171
        if ____t_172(____t_result_171) then
            ____t_result_173 = __O[3076]
        else
            ____t_result_173 = s.defeated
        end
        __O[3077] = ____t_result_173
        if ____t_174(____t_result_173) then
            ____t_result_175 = __O[3077]
        else
            ____t_result_175 = s.won
        end
        __O[3078] = ____t_result_175
        if ____t_176(____t_result_175) then
            ____t_result_177 = __O[3078]
        else
            ____t_result_177 = s.chapterEnded
        end
        if ____t_178(____t_result_177) then
            return false
        end
        if __t(window.document:querySelector("dialog[open]")) then
            return false
        end
        returnFocus = window.document.activeElement
        local ____t_180 = __t
        local ____t_result_179
        if __t(s.started) then
            ____t_result_179 = not __t(s.paused)
        else
            ____t_result_179 = s.started
        end
        resumeAfter = not not ____t_180(____t_result_179)
        if __t(resumeAfter) then
            local ____opt_183 = window.Game
            if ____opt_183 ~= nil then
                ____opt_183 = ____opt_183.pause
            end
            if ____opt_183 ~= nil then
                ____opt_183(____opt_183)
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
        local ____t_190 = __t
        local ____t_result_189
        local ____t_188 = __t
        local ____t_result_187
        if __t(resume) then
            ____t_result_187 = state(nil).started
        else
            ____t_result_187 = resume
        end
        __O[3079] = ____t_result_187
        if ____t_188(____t_result_187) then
            ____t_result_189 = not __t(window.document:querySelector("dialog[open]"))
        else
            ____t_result_189 = __O[3079]
        end
        if ____t_190(____t_result_189) then
            local ____opt_193 = window.Game
            if ____opt_193 ~= nil then
                ____opt_193 = ____opt_193.resume
            end
            if ____opt_193 ~= nil then
                ____opt_193(____opt_193)
            end
        end
        release(nil)
        window:requestAnimationFrame(function()
            local ____t_198 = __t
            local ____t_result_197
            local ____t_196 = __t
            local ____state_result_started_195 = state(nil).started
            __O[3080] = ____state_result_started_195
            if ____t_196(____state_result_started_195) then
                ____t_result_197 = not __t(state(nil).paused)
            else
                ____t_result_197 = __O[3080]
            end
            if ____t_198(____t_result_197) then
                local ____opt_199 = window.document:getElementById("gameCanvas")
                if ____opt_199 ~= nil then
                    ____opt_199:focus({preventScroll = true})
                end
            else
                local ____t_204 = __t
                local ____opt_result_203
                if returnFocus ~= nil then
                    ____opt_result_203 = returnFocus.isConnected
                end
                if ____t_204(____opt_result_203) then
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
            local ____opt_209 = window.ControlSettingsUI
            if ____opt_209 ~= nil then
                ____opt_209 = ____opt_209.close
            end
            if ____opt_209 ~= nil then
                ____opt_209(____opt_209)
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
    local ____t_result_217
    local ____t_214 = __t
    local ____opt_211 = window.document:getElementById("ranchControlsBtn")
    local ____temp_213 = ____opt_211 and ____opt_211:insertAdjacentElement("afterend", entry)
    __O[3081] = ____temp_213
    if ____t_214(____temp_213) then
        ____t_result_217 = __O[3081]
    else
        local ____opt_215 = window.document:querySelector("#pauseScreen .game-modal")
        ____t_result_217 = ____opt_215 and ____opt_215:append(entry)
    end
    settingsEntry = window.document:createElement("button")
    settingsEntry.id = "campaignLayoutSettingsBtn"
    settingsEntry.type = "button"
    settingsEntry.className = "controls-configure-link campaign-layout-settings-link"
    settingsEntry.innerHTML = "POSIÇÃO E TAMANHO DOS BOTÕES <span>↗</span>"
    settingsEntry:addEventListener("click", fromSettings)
    local ____opt_218 = window.document:querySelector("#controlSettingsModal .controls-tabs")
    if ____opt_218 ~= nil then
        ____opt_218:insertAdjacentElement("beforebegin", settingsEntry)
    end
    panel:querySelector("[data-ccl-collapse]"):addEventListener(
        "click",
        function(____, event)
            local collapsed = panel.classList:toggle("is-collapsed")
            event.currentTarget.textContent = __t(collapsed) and "+" or "−"
            event.currentTarget:setAttribute(
                "aria-expanded",
                tostring(not __t(collapsed))
            )
            event.currentTarget:setAttribute(
                "aria-label",
                __t(collapsed) and "Expandir painel de tamanho dos botões" or "Recolher painel para liberar os botões"
            )
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
            local ____opt_222 = window.ControlSettingsUI
            if ____opt_222 ~= nil then
                ____opt_222 = ____opt_222.open
            end
            if ____opt_222 ~= nil then
                ____opt_222(____opt_222)
            end
        end
    )
    local function intercept(self, event)
        local ____t_228 = __t
        local ____temp_227 = not __t(editing)
        if not ____temp_227 then
            local ____t_226 = __t
            local ____this_225
            ____this_225 = event.target
            local ____opt_224 = ____this_225.closest
            if ____opt_224 ~= nil then
                ____opt_224 = ____opt_224(____this_225, ".touch-controls")
            end
            ____temp_227 = not ____t_226(____opt_224)
        end
        if ____t_228(____temp_227) then
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
            local ____t_233 = __t
            local ____temp_232 = event.type == "pointermove"
            if ____temp_232 then
                local ____opt_result_231
                if pointer ~= nil then
                    ____opt_result_231 = pointer.id
                end
                ____temp_232 = ____opt_result_231 == event.pointerId
            end
            if ____t_233(____temp_232) then
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
                local ____t_240 = __t
                local ____t_result_239
                local ____t_235 = __t
                local ____call_result_234 = __call(
                    __arrL({"pointerup", "pointercancel", "lostpointercapture"}, 3),
                    "includes",
                    event.type
                )
                __O[3082] = ____call_result_234
                if ____t_235(____call_result_234) then
                    local ____opt_result_238
                    if pointer ~= nil then
                        ____opt_result_238 = pointer.id
                    end
                    ____t_result_239 = ____opt_result_238 == event.pointerId
                else
                    ____t_result_239 = __O[3082]
                end
                if ____t_240(____t_result_239) then
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
                        local ____t_result_243
                        local ____t_242 = __t
                        local ____temp_241 = not __t(e.hidden) and not __t(e.disabled)
                        __O[3083] = ____temp_241
                        if ____t_242(____temp_241) then
                            ____t_result_243 = __len(e:getClientRects())
                        else
                            ____t_result_243 = __O[3083]
                        end
                        return ____t_result_243
                    end
                )
                local first = __get(list, 0)
                local last = __get(
                    list,
                    __len(list) - 1
                )
                local ____t_245 = __t
                local ____t_result_244
                if __t(event.shiftKey) then
                    ____t_result_244 = window.document.activeElement == first
                else
                    ____t_result_244 = event.shiftKey
                end
                if ____t_245(____t_result_244) then
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
    local ____opt_246 = window.visualViewport
    if ____opt_246 ~= nil then
        ____opt_246:addEventListener("resize", schedule)
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
