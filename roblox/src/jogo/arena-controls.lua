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
                local ____t_7 = __t
                local ____t_6 = __t
                local ____t_4 = __t
                local ____opt_result_2
                if data ~= nil then
                    ____opt_result_2 = data.schema
                end
                local ____temp_3 = ____opt_result_2 == 1
                __O[2774] = ____temp_3
                local ____temp_5 = if ____t_4(____temp_3) then data.layouts else __O[2774]
                __O[2775] = ____temp_5
                if ____t_7(if ____t_6(____temp_5) then type(data.layouts) == "table" else __O[2775]) then
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
            local ____isFiniteN_15 = __isFiniteN
            local ____opt_result_14
            if record ~= nil then
                ____opt_result_14 = record.x
            end
            local ____temp_24 = if ____isFiniteN_15(____opt_result_14) then clamp(nil, record.x, 0, 1) else __get(base, 0)
            local ____isFiniteN_19 = __isFiniteN
            local ____opt_result_18
            if record ~= nil then
                ____opt_result_18 = record.y
            end
            local ____temp_25 = if ____isFiniteN_19(____opt_result_18) then clamp(nil, record.y, 0, 1) else __get(base, 1)
            local ____isFiniteN_23 = __isFiniteN
            local ____opt_result_22
            if record ~= nil then
                ____opt_result_22 = record.size
            end
            return {x = ____temp_24, y = ____temp_25, size = if ____isFiniteN_23(____opt_result_22) then clamp(nil, record.size, if id == "joystick" then 80 else 40, if id == "joystick" then 180 else 110) else __get(base, 2)}
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
            query(nil, "#arenaLayoutSaved").textContent = if __t(saved) then __add("SALVO NESTE APARELHO · ", if orientation == "landscape" then "TELA DEITADA" else "TELA EM PÉ") else "Armazenamento indisponível: vale até fechar o jogo."
        end
        function selectedUI(self)
            local s = setting(nil, selected)
            query(nil, "#arenaLayoutSelection").textContent = __get(NAMES, selected)
            local range = query(nil, "#arenaLayoutScale")
            range.min = if selected == "joystick" then "80" else "40"
            range.max = if selected == "joystick" then "180" else "110"
            range.value = s.size
            query(nil, "#arenaLayoutSize").textContent = __add(
                math.floor(s.size + 0.5),
                " px"
            )
            for ____, ____value in __iterar((targets)) do
                local id = ____value[1]
                local target = ____value[2]
                target.classList:toggle("layout-selected", if __t(editing) then id == selected else editing)
            end
        end
        function apply(self)
            local r = bounds(nil)
            if __t(r.w < 20 or r.h < 20) then
                return
            end
            orientation = if r.w >= r.h then "landscape" else "portrait"
            local style = window:getComputedStyle(screen)
            local safe = {}
            for ____, side in __iterar((__arrL({"top", "right", "bottom", "left"}, 4))) do
                local ____set_28 = __set
                local ____t_27 = __t
                local ____TS__ParseFloat_result_26 = __TS__ParseFloat(style:getPropertyValue(__add("--arena-safe-", side)))
                __O[2776] = ____TS__ParseFloat_result_26
                ____set_28(
                    safe,
                    side,
                    math.max(8, if ____t_27(____TS__ParseFloat_result_26) then __O[2776] else 0 + 8)
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
            local ____t_31 = __t
            local ____opt_29 = window.ControlSettings
            if ____opt_29 ~= nil then
                ____opt_29 = ____opt_29.transformJoystick
            end
            if ____t_31(____opt_29) then
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
            local ____opt_46 = window.ArenaArt
            if ____opt_46 ~= nil then
                ____opt_46 = ____opt_46.drawBackground
            end
            if ____opt_46 ~= nil then
                ____opt_46(
                    ____opt_46,
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
            query(nil, ".alc-note").textContent = if __t(state.practice) then "O treino está pausado. Arraste e redimensione os controles." else if __t(state.playing) then "A partida online continua. Seus comandos ficam parados enquanto você ajusta." else "Arraste os controles para testar a posição. O ajuste fica salvo para esta orientação."
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
        local ____opt_8 = screen:querySelector(".arena-header-actions")
        if ____opt_8 ~= nil then
            ____opt_8:prepend(entry)
        end
        local battleEntry = entry:cloneNode(true)
        battleEntry.id = "arenaBattleControlsBtn"
        battleEntry.textContent = "AJUSTAR"
        battleEntry:setAttribute("aria-label", "Ajustar joystick, botões e teclas")
        battleEntry:addEventListener(
            "click",
            function() return openEditor(nil) end
        )
        local ____opt_10 = screen:querySelector(".arena-match-top")
        if ____opt_10 ~= nil then
            ____opt_10:insertBefore(
                battleEntry,
                screen:querySelector("#arenaBattleLeave")
            )
        end
        query = function(____, s) return panel:querySelector(s) end
        local function put(self, id, values)
            do
                __O[2777] = layouts
                __O[2778] = orientation
            end
            local ____ = if __t(__get(__O[2777], __O[2778])) then __get(__O[2777], __O[2778]) else __set(__O[2777], __O[2778], {})
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
                    local ____t_36 = __t
                    local ____t_35 = __t
                    local ____t_33 = __t
                    local ____temp_32 = not __t(getState(nil).playing)
                    __O[2779] = ____temp_32
                    local ____temp_34 = if ____t_33(____temp_32) then __O[2779] else getState(nil).eliminated
                    __O[2780] = ____temp_34
                    if ____t_36(if ____t_35(____temp_34) then __O[2780] else target.disabled) then
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
                    local ____t_40 = __t
                    local ____opt_result_39
                    if pointer ~= nil then
                        ____opt_result_39 = pointer.id
                    end
                    if ____t_40(if __t(editing) then ____opt_result_39 == event.pointerId else editing) then
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
                local ____opt_result_43
                if pointer ~= nil then
                    ____opt_result_43 = pointer.id
                end
                if ____opt_result_43 == event.pointerId then
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
            if __t(if __t(preview) then not __t(getState(nil).hasWorld) else preview) then
                screen:querySelector("#arenaLobby").hidden = preview.lobbyHidden
                screen:querySelector("#arenaBattle").hidden = preview.battleHidden
                screen.classList:toggle("in-battle", preview.inBattle)
            end
            preview = nil
            for ____, target in __iterar((__call(targets, "values"))) do
                target.classList:remove("layout-selected")
            end
            onEditing(nil, false)
            local ____opt_48 = screen:querySelector("#arenaCanvas")
            if ____opt_48 ~= nil then
                ____opt_48:focus({preventScroll = true})
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
                local ____opt_52 = window.ControlSettingsUI
                if ____opt_52 ~= nil then
                    ____opt_52 = ____opt_52.open
                end
                if ____opt_52 ~= nil then
                    ____opt_52(____opt_52)
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
