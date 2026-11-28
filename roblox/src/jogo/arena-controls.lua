--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __isFiniteN, __getq, __ord, __arrL, __iterar, __t, __get, __set, __arr, __call, __add = __JSR.__lt, __JSR.__isFiniteN, __JSR.__getq, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__arr, __JSR.__call, __JSR.__add
local __new, __iter, __assign, __hypot = __JSR.__new, __JSR.__iter, __JSR.__assign, __JSR.__hypot
local ____lualib = require(script.Parent.lualib_bundle)
local Map = ____lualib.Map
local __TS__New = ____lualib.__TS__New
local __TS__Spread = ____lualib.__TS__Spread
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__ParseFloat = ____lualib.__TS__ParseFloat
local __TS__Number = ____lualib.__TS__Number
local __TS__ObjectFromEntries = ____lualib.__TS__ObjectFromEntries
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local KEY = "daroca-arena-layout-v1"
    local ACTIONS = __arrL({
        "attack",
        "special",
        "ultimate",
        "jump",
        "dash",
        "emote"
    }, 6)
    local NAMES = __ord({
        joystick = "Joystick",
        attack = "Golpe físico",
        special = "Ataque à distância",
        ultimate = "Combo",
        jump = "Pulo",
        dash = "Dash",
        emote = "Resenha"
    }, "joystick,attack,special,ultimate,jump,dash,emote")
    local function clamp(____, v, a, b)
        return math.max(
            a,
            math.min(b, v)
        )
    end
    local defaults = __ord(
        {
            landscape = __ord(
                {
                    joystick = __arrL({0.14, 0.84, 104}, 3),
                    attack = __arrL({0.89, 0.86, 58}, 3),
                    special = __arrL({0.92, 0.64, 50}, 3),
                    ultimate = __arrL({0.83, 0.64, 48}, 3),
                    jump = __arrL({0.8, 0.86, 56}, 3),
                    dash = __arrL({0.71, 0.88, 44}, 3),
                    emote = __arrL({0.73, 0.64, 42}, 3)
                },
                "joystick,attack,special,ultimate,jump,dash,emote"
            ),
            portrait = __ord(
                {
                    joystick = __arrL({0.21, 0.87, 108}, 3),
                    attack = __arrL({0.84, 0.89, 60}, 3),
                    special = __arrL({0.88, 0.75, 50}, 3),
                    ultimate = __arrL({0.71, 0.75, 48}, 3),
                    jump = __arrL({0.66, 0.89, 56}, 3),
                    dash = __arrL({0.49, 0.91, 44}, 3),
                    emote = __arrL({0.55, 0.76, 42}, 3)
                },
                "joystick,attack,special,ultimate,jump,dash,emote"
            )
        },
        "landscape,portrait"
    )
    local function read(self)
        do
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                local data = window.JSON:parse(window.localStorage:getItem(KEY))
                local ____t_8 = __t
                local ____t_result_7
                local ____t_6 = __t
                local ____t_result_5
                local ____t_4 = __t
                local ____opt_result_2
                if data ~= nil then
                    ____opt_result_2 = data.schema
                end
                local ____temp_3 = ____opt_result_2 == 1
                __O[2798] = ____temp_3
                if ____t_4(____temp_3) then
                    ____t_result_5 = data.layouts
                else
                    ____t_result_5 = __O[2798]
                end
                __O[2799] = ____t_result_5
                if ____t_6(____t_result_5) then
                    ____t_result_7 = type(data.layouts) == "table"
                else
                    ____t_result_7 = __O[2799]
                end
                if ____t_8(____t_result_7) then
                    return true, data.layouts
                end
            end)
            if ____try and ____hasReturned then
                return ____returnValue
            end
        end
        return {}
    end
    local function mount(self, ____bindingPattern0)
        local getState
        local onEditing
        local onRelease
        local onPress
        local onMove
        local wrap
        local screen
        screen = ____bindingPattern0.screen
        wrap = ____bindingPattern0.wrap
        onMove = ____bindingPattern0.onMove
        if onMove == nil then
            onMove = function()
            end
        end
        onPress = ____bindingPattern0.onPress
        if onPress == nil then
            onPress = function()
            end
        end
        onRelease = ____bindingPattern0.onRelease
        if onRelease == nil then
            onRelease = function()
            end
        end
        onEditing = ____bindingPattern0.onEditing
        if onEditing == nil then
            onEditing = function()
            end
        end
        getState = ____bindingPattern0.getState
        if getState == nil then
            getState = function() return {} end
        end
        local bounds, setting, persist, selectedUI, apply, setJoy, clear, updateStick, paintPreview, openEditor, layouts, editing, selected, joyPointer, joy, preview, clearing, orientation, saved, targets, held, joystick, panel, query
        function bounds(self)
            local r = wrap:getBoundingClientRect()
            return {
                left = r.left,
                top = r.top,
                w = math.max(1, r.width),
                h = math.max(1, r.height)
            }
        end
        function setting(self, id)
            local base = __get(
                __get(defaults, orientation),
                id
            )
            local record = __getq(
                __get(layouts, orientation),
                id
            )
            local ____isFiniteN_result_17
            local ____isFiniteN_16 = __isFiniteN
            local ____opt_result_15
            if record ~= nil then
                ____opt_result_15 = record.x
            end
            if ____isFiniteN_16(____opt_result_15) then
                ____isFiniteN_result_17 = clamp(nil, record.x, 0, 1)
            else
                ____isFiniteN_result_17 = __get(base, 0)
            end
            local ____isFiniteN_result_22
            local ____isFiniteN_21 = __isFiniteN
            local ____opt_result_20
            if record ~= nil then
                ____opt_result_20 = record.y
            end
            if ____isFiniteN_21(____opt_result_20) then
                ____isFiniteN_result_22 = clamp(nil, record.y, 0, 1)
            else
                ____isFiniteN_result_22 = __get(base, 1)
            end
            local ____isFiniteN_result_27
            local ____isFiniteN_26 = __isFiniteN
            local ____opt_result_25
            if record ~= nil then
                ____opt_result_25 = record.size
            end
            if ____isFiniteN_26(____opt_result_25) then
                ____isFiniteN_result_27 = clamp(nil, record.size, id == "joystick" and 80 or 40, id == "joystick" and 180 or 110)
            else
                ____isFiniteN_result_27 = __get(base, 2)
            end
            return {x = ____isFiniteN_result_17, y = ____isFiniteN_result_22, size = ____isFiniteN_result_27}
        end
        function persist(self)
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
            local ____query_result_29 = query(nil, "#arenaLayoutSaved")
            local ____t_result_28
            if __t(saved) then
                ____t_result_28 = __add("SALVO NESTE APARELHO · ", orientation == "landscape" and "TELA DEITADA" or "TELA EM PÉ")
            else
                ____t_result_28 = "Armazenamento indisponível: vale até fechar o jogo."
            end
            ____query_result_29.textContent = ____t_result_28
        end
        function selectedUI(self)
            local s = setting(nil, selected)
            query(nil, "#arenaLayoutSelection").textContent = __get(NAMES, selected)
            local range = query(nil, "#arenaLayoutScale")
            range.min = selected == "joystick" and "80" or "40"
            range.max = selected == "joystick" and "180" or "110"
            range.value = s.size
            query(nil, "#arenaLayoutSize").textContent = __add(
                math.floor(s.size + 0.5),
                " px"
            )
            for ____, ____value in __iterar((targets)) do
                local id = ____value[1]
                local target = ____value[2]
                local ____self_31 = target.classList
                local ____self_31_toggle_32 = ____self_31.toggle
                local ____t_result_30
                if __t(editing) then
                    ____t_result_30 = id == selected
                else
                    ____t_result_30 = editing
                end
                ____self_31_toggle_32(____self_31, "layout-selected", ____t_result_30)
            end
        end
        function apply(self)
            local r = bounds(nil)
            if __t(r.w < 20 or r.h < 20) then
                return
            end
            orientation = r.w >= r.h and "landscape" or "portrait"
            local style = window:getComputedStyle(screen)
            local safe = {}
            for ____, side in __iterar((__arrL({"top", "right", "bottom", "left"}, 4))) do
                local ____set_36 = __set
                local ____t_result_35
                local ____t_34 = __t
                local ____TS__ParseFloat_result_33 = __TS__ParseFloat(style:getPropertyValue(__add("--arena-safe-", side)))
                __O[2800] = ____TS__ParseFloat_result_33
                if ____t_34(____TS__ParseFloat_result_33) then
                    ____t_result_35 = __O[2800]
                else
                    ____t_result_35 = 0
                end
                ____set_36(
                    safe,
                    side,
                    math.max(8, ____t_result_35 + 8)
                )
            end
            for ____, ____value in __iterar((targets)) do
                local id = ____value[1]
                local target = ____value[2]
                local s = setting(nil, id)
                local size = math.min(s.size, r.w - safe.left - safe.right, r.h - safe.top - safe.bottom)
                local x = clamp(nil, s.x * r.w, size / 2 + safe.left, r.w - size / 2 - safe.right)
                local y = clamp(nil, s.y * r.h, size / 2 + safe.top, r.h - size / 2 - safe.bottom)
                target.style.width = __add(size, "px")
                target.style.height = __add(size, "px")
                target.style.left = __add(x, "px")
                target.style.top = __add(y, "px")
                target.style:setProperty(
                    "--control-size",
                    __add(size, "px")
                )
            end
            selectedUI(nil)
            if __t(editing) then
                persist(nil)
            end
            if __t(preview) then
                paintPreview(nil)
            end
        end
        function setJoy(self, x, y)
            local ____t_40 = __t
            local ____opt_38 = window.ControlSettings
            if ____opt_38 ~= nil then
                ____opt_38 = ____opt_38.transformJoystick
            end
            if ____t_40(____opt_38) then
                local result = window.ControlSettings:transformJoystick(x, y)
                x = result.x
                y = result.y
            else
                local length = __hypot(x, y)
                if length < 0.15 then
                    y = 0
                    x = y
                else
                    local magnitude = math.min(1, (length - 0.15) / 0.85)
                    x = x / length * magnitude
                    y = y / length * magnitude
                end
            end
            joy = {x = x, y = y}
            joystick.style:setProperty("--joy-x", x)
            joystick.style:setProperty("--joy-y", y)
            joystick:setAttribute(
                "aria-valuenow",
                tostring(math.floor(x * 100 + 0.5))
            )
            joystick:setAttribute(
                "aria-valuetext",
                __add(
                    __add(
                        __add(
                            math.floor(x * 100 + 0.5),
                            " horizontal, "
                        ),
                        math.floor(y * 100 + 0.5)
                    ),
                    " vertical"
                )
            )
            onMove(nil, x, y)
        end
        function clear(self)
            if __t(clearing) then
                return
            end
            clearing = true
            for ____, ____value in __iterar((held)) do
                local id = ____value[1]
                local action = ____value[2]
                onRelease(nil, action, id)
            end
            __call(held, "clear")
            joyPointer = nil
            setJoy(nil, 0, 0)
            for ____, target in __iterar((__call(targets, "values"))) do
                target.classList:remove("pressed")
            end
            clearing = false
        end
        function updateStick(self, event)
            local r = joystick:getBoundingClientRect()
            local travel = r.width * 0.32
            setJoy(nil, (event.clientX - r.left - r.width / 2) / travel, (event.clientY - r.top - r.height / 2) / travel)
        end
        function paintPreview(self)
            local canvas = screen:querySelector("#arenaCanvas")
            if not __t(canvas) then
                return
            end
            local r = canvas:getBoundingClientRect()
            if __t(__lt(r.width, 20) or __lt(r.height, 20)) then
                return
            end
            canvas.width = math.floor(r.width + 0.5)
            canvas.height = math.floor(r.height + 0.5)
            local c = canvas:getContext("2d")
            c.imageSmoothingEnabled = false
            local ____opt_57 = window.ArenaArt
            if ____opt_57 ~= nil then
                ____opt_57 = ____opt_57.drawBackground
            end
            if ____opt_57 ~= nil then
                ____opt_57(
                    ____opt_57,
                    c,
                    {x = 640, y = 320, zoom = 0.6},
                    0,
                    canvas.width,
                    canvas.height
                )
            end
            c.fillStyle = "#493921"
            c.font = "bold 14px monospace"
            c.textAlign = "center"
            c:fillText("PRÉVIA DOS CONTROLES", canvas.width / 2, canvas.height / 2)
        end
        function openEditor(self)
            if __t(editing) then
                return
            end
            clear(nil)
            editing = true
            __call(screen.classList, "add", "arena-layout-editing")
            local state = getState(nil)
            if not __t(state.hasWorld) then
                preview = {
                    lobbyHidden = screen:querySelector("#arenaLobby").hidden,
                    battleHidden = screen:querySelector("#arenaBattle").hidden,
                    inBattle = screen.classList:contains("in-battle")
                }
                screen:querySelector("#arenaLobby").hidden = true
                screen:querySelector("#arenaBattle").hidden = false
                __call(screen.classList, "add", "in-battle", "arena-layout-preview")
            end
            panel.hidden = false
            query(nil, ".alc-note").textContent = __t(state.practice) and "O treino está pausado. Arraste e redimensione os controles." or (__t(state.playing) and "A partida online continua. Seus comandos ficam parados enquanto você ajusta." or "Arraste os controles para testar a posição. O ajuste fica salvo para esta orientação.")
            onEditing(nil, true)
            apply(nil)
            persist(nil)
            query(nil, "[data-alc-done]"):focus()
        end
        local layer = screen:querySelector(".arena-mobile-controls")
        if not __t(layer) then
            return nil
        end
        layouts = read(nil)
        editing = false
        selected = "joystick"
        local pointer = nil
        joyPointer = nil
        joy = {x = 0, y = 0}
        preview = nil
        clearing = false
        orientation = "landscape"
        saved = true
        targets = __TS__New(Map)
        held = __TS__New(Map)
        joystick = window.document:createElement("div")
        joystick.id = "arenaJoystick"
        joystick.className = "arena-joystick arena-layout-target"
        joystick.dataset.layoutId = "joystick"
        joystick:setAttribute("role", "slider")
        joystick:setAttribute("aria-label", "Joystick: andar e direcionar golpes")
        joystick:setAttribute("aria-valuemin", "-100")
        joystick:setAttribute("aria-valuemax", "100")
        joystick:setAttribute("aria-valuenow", "0")
        joystick.innerHTML = "<span class=\"arena-joystick-rim\" aria-hidden=\"true\"></span><span class=\"arena-joystick-knob\" aria-hidden=\"true\"><i></i></span><small>MOVER · MIRAR</small>"
        __call(targets, "set", "joystick", joystick)
        local buttons = __call(
            __call(
                ACTIONS,
                "map",
                function(____, action)
                    local b = screen:querySelector(__add(
                        __add("[data-arena-input=\"", action),
                        "\"]"
                    ))
                    if __t(b) then
                        __call(b.classList, "add", "arena-layout-target")
                        b.dataset.layoutId = action
                        __call(targets, "set", action, b)
                    end
                    return b
                end
            ),
            "filter",
            window.Boolean
        )
        layer:replaceChildren(
            joystick,
            __TS__Spread(__iter(buttons))
        )
        __call(layer.classList, "add", "arena-custom-controls")
        panel = window.document:createElement("section")
        panel.id = "arenaLayoutEditor"
        panel.className = "arena-layout-editor"
        panel.hidden = true
        panel:setAttribute("aria-label", "Editar os controles da arena")
        panel.innerHTML = "<div class=\"alc-heading\"><span>O CADERNO DOS CONTROLES</span><button type=\"button\" data-alc-close aria-label=\"Concluir edição\">×</button></div><h3>DO SEU JEITO, DA ROÇA.</h3><p class=\"alc-note\">Arraste os controles. Toque em um para ajustar o tamanho.</p><div class=\"alc-selected\"><b id=\"arenaLayoutSelection\">Joystick</b><output id=\"arenaLayoutSize\">104 px</output></div><input id=\"arenaLayoutScale\" type=\"range\" min=\"40\" max=\"180\" step=\"1\" aria-label=\"Tamanho do controle selecionado\"><div class=\"alc-footer\"><button type=\"button\" data-alc-keys>TECLAS DO PC</button><button type=\"button\" data-alc-reset>RESTAURAR</button><button type=\"button\" data-alc-done>PRONTO ✓</button></div><small id=\"arenaLayoutSaved\" role=\"status\"></small>"
        wrap:append(panel)
        local entry = window.document:createElement("button")
        entry.type = "button"
        entry.id = "arenaControlsBtn"
        entry.className = "arena-small-button arena-controls-entry"
        entry.textContent = "CONTROLES"
        entry.title = "Teclas, joystick e posição dos botões"
        entry:addEventListener(
            "click",
            function() return openEditor(nil) end
        )
        local ____opt_9 = screen:querySelector(".arena-header-actions")
        if ____opt_9 ~= nil then
            ____opt_9:prepend(entry)
        end
        local battleEntry = entry:cloneNode(true)
        battleEntry.id = "arenaBattleControlsBtn"
        battleEntry.textContent = "AJUSTAR"
        battleEntry:setAttribute("aria-label", "Ajustar joystick, botões e teclas")
        battleEntry:addEventListener(
            "click",
            function() return openEditor(nil) end
        )
        local ____opt_11 = screen:querySelector(".arena-match-top")
        if ____opt_11 ~= nil then
            ____opt_11:insertBefore(
                battleEntry,
                screen:querySelector("#arenaBattleLeave")
            )
        end
        query = function(____, s) return panel:querySelector(s) end
        local function put(self, id, values)
            do
                __O[2801] = layouts
                __O[2802] = orientation
            end
            local ____t_result_37
            if __t(__get(__O[2801], __O[2802])) then
                ____t_result_37 = __get(__O[2801], __O[2802])
            else
                ____t_result_37 = __set(__O[2801], __O[2802], {})
            end
            __set(
                __get(layouts, orientation),
                id,
                __assign(
                    {},
                    setting(nil, id),
                    values
                )
            )
            apply(nil)
            persist(nil)
        end
        local function choose(self, id)
            selected = id
            selectedUI(nil)
        end
        local function beginDrag(self, event, id, target)
            event:preventDefault()
            event:stopImmediatePropagation()
            choose(nil, id)
            local r = target:getBoundingClientRect()
            pointer = {
                id = event.pointerId,
                target = target,
                idName = id,
                offsetX = event.clientX - (r.left + r.width / 2),
                offsetY = event.clientY - (r.top + r.height / 2)
            }
            do
                pcall(function()
                    target:setPointerCapture(event.pointerId)
                end)
            end
        end
        for ____, ____value in __iterar((targets)) do
            local id = ____value[1]
            local target = ____value[2]
            target:addEventListener(
                "pointerdown",
                function(____, event)
                    if __t(editing) then
                        beginDrag(nil, event, id, target)
                        return
                    end
                    local ____t_46 = __t
                    local ____t_result_45
                    local ____t_44 = __t
                    local ____t_result_43
                    local ____t_42 = __t
                    local ____temp_41 = not __t(getState(nil).playing)
                    __O[2803] = ____temp_41
                    if ____t_42(____temp_41) then
                        ____t_result_43 = __O[2803]
                    else
                        ____t_result_43 = getState(nil).eliminated
                    end
                    __O[2804] = ____t_result_43
                    if ____t_44(____t_result_43) then
                        ____t_result_45 = __O[2804]
                    else
                        ____t_result_45 = target.disabled
                    end
                    if ____t_46(____t_result_45) then
                        return
                    end
                    event:preventDefault()
                    do
                        pcall(function()
                            target:setPointerCapture(event.pointerId)
                        end)
                    end
                    if id == "joystick" then
                        if joyPointer ~= nil then
                            return
                        end
                        joyPointer = event.pointerId
                        updateStick(nil, event)
                    else
                        __call(held, "set", event.pointerId, id)
                        __call(target.classList, "add", "pressed")
                        onPress(nil, id, event.pointerId)
                    end
                end,
                true
            )
            target:addEventListener(
                "pointermove",
                function(____, event)
                    local ____t_51 = __t
                    local ____t_result_50
                    if __t(editing) then
                        local ____opt_result_49
                        if pointer ~= nil then
                            ____opt_result_49 = pointer.id
                        end
                        ____t_result_50 = ____opt_result_49 == event.pointerId
                    else
                        ____t_result_50 = editing
                    end
                    if ____t_51(____t_result_50) then
                        event:preventDefault()
                        local r = bounds(nil)
                        local size = target:getBoundingClientRect().width
                        local x = clamp(nil, event.clientX - r.left - pointer.offsetX, size / 2 + 5, r.w - size / 2 - 5)
                        local y = clamp(nil, event.clientY - r.top - pointer.offsetY, size / 2 + 5, r.h - size / 2 - 5)
                        put(nil, id, {x = x / r.w, y = y / r.h})
                        return
                    end
                    if __t(id == "joystick" and joyPointer == event.pointerId) then
                        event:preventDefault()
                        updateStick(nil, event)
                    end
                end
            )
            local function release(____, event)
                local ____opt_result_54
                if pointer ~= nil then
                    ____opt_result_54 = pointer.id
                end
                if ____opt_result_54 == event.pointerId then
                    pointer = nil
                    persist(nil)
                end
                if joyPointer == event.pointerId then
                    joyPointer = nil
                    setJoy(nil, 0, 0)
                end
                local action = __call(held, "get", event.pointerId)
                if __t(action) then
                    __call(held, "delete", event.pointerId)
                    onRelease(nil, action, event.pointerId)
                end
                target.classList:remove("pressed")
            end
            target:addEventListener("pointerup", release)
            target:addEventListener("pointercancel", release)
            target:addEventListener("lostpointercapture", release)
            target:addEventListener(
                "click",
                function(____, event)
                    if __t(editing) then
                        event:preventDefault()
                        event:stopImmediatePropagation()
                        choose(nil, id)
                    end
                end,
                true
            )
        end
        local function closeEditor(self)
            if not __t(editing) then
                return
            end
            clear(nil)
            editing = false
            pointer = nil
            panel.hidden = true
            screen.classList:remove("arena-layout-editing", "arena-layout-preview")
            local ____t_60 = __t
            local ____t_result_59
            if __t(preview) then
                ____t_result_59 = not __t(getState(nil).hasWorld)
            else
                ____t_result_59 = preview
            end
            if ____t_60(____t_result_59) then
                screen:querySelector("#arenaLobby").hidden = preview.lobbyHidden
                screen:querySelector("#arenaBattle").hidden = preview.battleHidden
                screen.classList:toggle("in-battle", preview.inBattle)
            end
            preview = nil
            for ____, target in __iterar((__call(targets, "values"))) do
                target.classList:remove("layout-selected")
            end
            onEditing(nil, false)
            local ____opt_61 = screen:querySelector("#arenaCanvas")
            if ____opt_61 ~= nil then
                ____opt_61:focus({preventScroll = true})
            end
        end
        query(nil, "#arenaLayoutScale"):addEventListener(
            "input",
            function(____, event) return put(
                nil,
                selected,
                {size = __TS__Number(event.target.value)}
            ) end
        )
        query(nil, "[data-alc-reset]"):addEventListener(
            "click",
            function()
                __set(layouts, orientation, {})
                apply(nil)
                persist(nil)
            end
        )
        for ____, s in __iterar((__arrL({"[data-alc-close]", "[data-alc-done]"}, 2))) do
            query(nil, s):addEventListener("click", closeEditor)
        end
        query(nil, "[data-alc-keys]"):addEventListener(
            "click",
            function()
                clear(nil)
                local ____opt_65 = window.ControlSettingsUI
                if ____opt_65 ~= nil then
                    ____opt_65 = ____opt_65.open
                end
                if ____opt_65 ~= nil then
                    ____opt_65(____opt_65)
                end
            end
        )
        local observer = __new("ResizeObserver", apply)
        observer:observe(wrap)
        window:addEventListener("orientationchange", clear)
        window:addEventListener("blur", clear)
        window.document:addEventListener(
            "visibilitychange",
            function()
                if __t(window.document.hidden) then
                    clear(nil)
                end
            end
        )
        apply(nil)
        return {
            clear = clear,
            openEditor = openEditor,
            closeEditor = closeEditor,
            isEditing = function() return editing end,
            refresh = apply,
            getVector = function() return __assign({}, joy) end,
            getStatus = function() return {
                editing = editing,
                selected = selected,
                orientation = orientation,
                saved = saved,
                vector = __assign({}, joy),
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
                ))
            } end,
            destroy = function()
                closeEditor(nil)
                clear(nil)
                observer:disconnect()
                panel:remove()
                entry:remove()
                battleEntry:remove()
            end
        }
    end
    window.ArenaControls = __ord({mount = mount, storageKey = KEY}, "mount,storageKey")
end)(nil)
return ____exports
