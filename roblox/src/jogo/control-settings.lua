--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __gt, __getq, __lenq, __callq, __ord, __arrL, __iterar, __t, __get, __arr, __len, __call = __JSR.__gt, __JSR.__getq, __JSR.__lenq, __JSR.__callq, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__arr, __JSR.__len, __JSR.__call
local __add, __new, __assign = __JSR.__add, __JSR.__new, __JSR.__assign
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__Number = ____lualib.__TS__Number
local ____exports = {}
local __O = {};
(function()
    local saveMessage, keyButton, renderBindings, refreshFeel, updateHints, refresh, beginCapture, stopCapture, api, canvas, svg, groups, descriptions, capturing, conflict, resetRequested, persistenceAvailable, modal, grid, captureBox, captureTitle, captureCopy, swapButton, cancelCapture, status, resetButton, sensitivity, deadzone, actionName, codeLabel, actionKeys
    function saveMessage(self, message)
        if message == nil then
            message = "Alterações salvas neste dispositivo."
        end
        local ____t_result_25
        if __t(persistenceAvailable) then
            ____t_result_25 = message
        else
            ____t_result_25 = "Alterações nesta sessão. Permita o armazenamento do navegador para manter seus controles."
        end
        status.textContent = ____t_result_25
        modal.dataset.save = __t(persistenceAvailable) and "saved" or "temporary"
        resetRequested = false
        resetButton.textContent = "Restaurar padrões"
    end
    function keyButton(self, action, slot, code)
        local wrap = window.document:createElement("div")
        wrap.className = "controls-key-slot"
        local button = window.document:createElement("button")
        button.type = "button"
        button.className = "controls-key"
        button.dataset.bindingAction = action
        button.dataset.bindingSlot = slot
        button:setAttribute(
            "aria-label",
            __add(
                __add(
                    __add(
                        __add(
                            __add(
                                __add(
                                    actionName(nil, action),
                                    ", atalho "
                                ),
                                slot + 1
                            ),
                            ": "
                        ),
                        codeLabel(nil, code)
                    ),
                    ". "
                ),
                __t(action == "pause" and slot == 0) and "Escape é uma saída fixa." or "Clique para alterar."
            )
        )
        local fixed = action == "pause" and slot == 0
        button.disabled = fixed
        button.classList:toggle(
            "is-empty",
            not __t(code)
        )
        button.classList:toggle("is-fixed", fixed)
        button.title = __t(fixed) and "Escape sempre permite sair ou pausar" or (__t(code) and "Clique para trocar esta tecla" or "Adicionar outro atalho")
        local kbd = window.document:createElement("kbd")
        local ____t_result_26
        if __t(code) then
            ____t_result_26 = codeLabel(nil, code)
        else
            ____t_result_26 = "+"
        end
        kbd.textContent = ____t_result_26
        button:append(kbd)
        if not __t(code) then
            local add = window.document:createElement("small")
            add.textContent = "atalho"
            button:append(add)
        end
        if __t(fixed) then
            local lock = window.document:createElement("small")
            lock.textContent = "fixo"
            button:append(lock)
        end
        button:addEventListener(
            "click",
            function() return beginCapture(nil, action, slot) end
        )
        wrap:append(button)
        local ____t_35 = __t
        local ____t_result_34
        local ____t_28 = __t
        local ____t_result_27
        if __t(code) then
            ____t_result_27 = not __t(fixed)
        else
            ____t_result_27 = code
        end
        __O[2513] = ____t_result_27
        if ____t_28(____t_result_27) then
            local ____gt_33 = __gt
            local ____len_32 = __len
            local ____t_result_31
            local ____t_30 = __t
            local ____get_result_29 = __get(
                api:getState().bindings,
                action
            )
            __O[2512] = ____get_result_29
            if ____t_30(____get_result_29) then
                ____t_result_31 = __O[2512]
            else
                ____t_result_31 = __arrL({}, 0)
            end
            ____t_result_34 = ____gt_33(
                ____len_32(____t_result_31),
                1
            )
        else
            ____t_result_34 = __O[2513]
        end
        if ____t_35(____t_result_34) then
            local clear = window.document:createElement("button")
            clear.type = "button"
            clear.className = "controls-key-clear"
            clear.textContent = "×"
            clear:setAttribute(
                "aria-label",
                __add(
                    __add(
                        __add(
                            "Remover ",
                            codeLabel(nil, code)
                        ),
                        " de "
                    ),
                    actionName(nil, action)
                )
            )
            clear.title = "Remover este atalho"
            clear:addEventListener(
                "click",
                function()
                    stopCapture(nil)
                    local result = api:clearBinding(action, slot)
                    local ____opt_result_38
                    if result ~= nil then
                        ____opt_result_38 = result.ok
                    end
                    if ____opt_result_38 == false then
                        local ____saveMessage_40 = saveMessage
                        local ____t_result_39
                        if __t(result.message) then
                            ____t_result_39 = result.message
                        else
                            ____t_result_39 = "Mantenha pelo menos uma tecla para esta ação."
                        end
                        ____saveMessage_40(nil, ____t_result_39)
                    else
                        saveMessage(nil)
                    end
                    refresh(nil)
                end
            )
            wrap:append(clear)
        end
        return wrap
    end
    function renderBindings(self)
        local state = api:getState()
        grid:replaceChildren()
        for ____, group in __iterar((groups)) do
            local section = window.document:createElement("section")
            section.className = "controls-binding-group"
            local h = window.document:createElement("h3")
            h.innerHTML = svg(nil, group.icon)
            h:append(window.document:createTextNode(group.label))
            section:append(h)
            for ____, action in __iterar((group.actions)) do
                local row = window.document:createElement("div")
                row.className = "controls-binding-row"
                local copy = window.document:createElement("div")
                copy.className = "controls-action-copy"
                local title = window.document:createElement("b")
                title.textContent = actionName(nil, action)
                local note = window.document:createElement("small")
                local ____t_result_43
                local ____t_42 = __t
                local ____get_result_41 = __get(descriptions, action)
                __O[2514] = ____get_result_41
                if ____t_42(____get_result_41) then
                    ____t_result_43 = __O[2514]
                else
                    ____t_result_43 = ""
                end
                note.textContent = ____t_result_43
                copy:append(title, note)
                local slots = window.document:createElement("div")
                slots.className = "controls-key-slots"
                do
                    local slot = 0
                    while slot < 2 do
                        slots:append(keyButton(
                            nil,
                            action,
                            slot,
                            __getq(
                                __get(state.bindings, action),
                                slot
                            )
                        ))
                        slot = slot + 1
                    end
                end
                row:append(copy, slots)
                section:append(row)
            end
            grid:append(section)
        end
    end
    function refreshFeel(self)
        local state = api:getState()
        sensitivity.value = state.sensitivity
        deadzone.value = state.deadzone
        modal:querySelector("#controlSensitivityValue").textContent = __add(
            __call(
                __call(
                    __TS__Number(state.sensitivity),
                    "toFixed",
                    2
                ),
                "replace",
                ".",
                ","
            ),
            "×"
        )
        modal:querySelector("#controlDeadzoneValue").textContent = __add(
            math.floor(state.deadzone * 100 + 0.5),
            "%"
        )
        modal.style:setProperty(
            "--control-deadzone",
            __add(
                math.floor(10 + state.deadzone * 100 + 0.5),
                "%"
            )
        )
    end
    function updateHints(self)
        local barActions = __arr(
            nil,
            "jump",
            "paper",
            "fart",
            "interact",
            "reeis",
            "vehicle",
            "dash",
            "taunt"
        )
        __call(
            window.document:querySelectorAll(".controls-bar .control-hint"),
            "forEach",
            function(____, hint, index)
                local keys = hint:querySelectorAll("kbd")
                if index == 0 then
                    if __t(__get(keys, 0)) then
                        __get(keys, 0).textContent = api:getLabel("left")
                    end
                    if __t(__get(keys, 1)) then
                        __get(keys, 1).textContent = api:getLabel("right")
                    end
                    hint.title = __add(
                        __add(
                            actionKeys(nil, "left"),
                            " / "
                        ),
                        actionKeys(nil, "right")
                    )
                else
                    local ____t_47 = __t
                    local ____t_result_46
                    local ____t_45 = __t
                    local ____get_result_44 = __get(barActions, index)
                    __O[2515] = ____get_result_44
                    if ____t_45(____get_result_44) then
                        ____t_result_46 = __get(keys, 0)
                    else
                        ____t_result_46 = __O[2515]
                    end
                    if ____t_47(____t_result_46) then
                        __get(keys, 0).textContent = api:getLabel(__get(barActions, index))
                        hint.title = actionKeys(
                            nil,
                            __get(barActions, index)
                        )
                    end
                end
            end
        )
        local helpRows = window.document:querySelectorAll("#helpModal .help-grid>div")
        local helpActions = __arr(
            nil,
            "jump",
            "paper",
            "fart",
            "interact",
            "reeis",
            "vehicle",
            "dash",
            "taunt",
            "training",
            "pause"
        )
        __call(
            helpRows,
            "forEach",
            function(____, row, index)
                local keys = row:querySelectorAll("kbd")
                if index == 0 then
                    if __t(__get(keys, 0)) then
                        __get(keys, 0).textContent = api:getLabel("left")
                    end
                    if __t(__get(keys, 1)) then
                        __get(keys, 1).textContent = api:getLabel("right")
                    end
                    local copy = row:querySelector("span")
                    if __t(copy) then
                        copy.textContent = __add(
                            __add(
                                __add(
                                    "Andar · ",
                                    actionKeys(nil, "left")
                                ),
                                " / "
                            ),
                            actionKeys(nil, "right")
                        )
                    end
                else
                    local ____t_51 = __t
                    local ____t_result_50
                    local ____t_49 = __t
                    local ____get_result_48 = __get(keys, 0)
                    __O[2516] = ____get_result_48
                    if ____t_49(____get_result_48) then
                        ____t_result_50 = __get(helpActions, index)
                    else
                        ____t_result_50 = __O[2516]
                    end
                    if ____t_51(____t_result_50) then
                        local ____get_result_53 = __get(keys, 0)
                        local ____temp_52
                        if __get(helpActions, index) == "training" then
                            ____temp_52 = __add(
                                __add(
                                    api:getLabel("interact"),
                                    " / "
                                ),
                                api:getLabel("jump")
                            )
                        else
                            ____temp_52 = actionKeys(
                                nil,
                                __get(helpActions, index)
                            )
                        end
                        ____get_result_53.textContent = ____temp_52
                    end
                end
            end
        )
        local train = window.document:querySelector("#trainingHitBtn kbd")
        if __t(train) then
            train.textContent = __add(
                __add(
                    api:getLabel("interact"),
                    " / "
                ),
                api:getLabel("jump")
            )
        end
        __call(
            window.document:querySelectorAll(".touch-controls [data-action]"),
            "forEach",
            function(____, button)
                local action = button.dataset.action
                if not __t(__get(
                    api:getState().bindings,
                    action
                )) then
                    return
                end
                local ____t_result_56
                local ____t_55 = __t
                local ____get_result_54 = __get(descriptions, action)
                __O[2517] = ____get_result_54
                if ____t_55(____get_result_54) then
                    ____t_result_56 = __O[2517]
                else
                    ____t_result_56 = actionName(nil, action)
                end
                local label = ____t_result_56
                button:setAttribute(
                    "aria-label",
                    __add(
                        __add(label, " · teclado: "),
                        actionKeys(nil, action)
                    )
                )
            end
        )
        if __t(canvas) then
            canvas:setAttribute(
                "aria-label",
                __add(
                    __add(
                        __add(
                            __add(
                                __add(
                                    __add(
                                        __add(
                                            __add(
                                                __add(
                                                    __add(
                                                        __add(
                                                            __add(
                                                                __add(
                                                                    __add(
                                                                        "Da Roça Adventure. Andar: ",
                                                                        api:getLabel("left")
                                                                    ),
                                                                    " e "
                                                                ),
                                                                api:getLabel("right")
                                                            ),
                                                            ". Pular e voar: "
                                                        ),
                                                        actionKeys(nil, "jump")
                                                    ),
                                                    ". Papel: "
                                                ),
                                                actionKeys(nil, "paper")
                                            ),
                                            ". Peidão: "
                                        ),
                                        actionKeys(nil, "fart")
                                    ),
                                    ". Conversar: "
                                ),
                                actionKeys(nil, "interact")
                            ),
                            ". Pausar: "
                        ),
                        actionKeys(nil, "pause")
                    ),
                    ". Configure os controles no menu."
                )
            )
        end
        local intro = window.document:querySelector("#helpModal>p:not(.help-tip)")
        local tip = window.document:querySelector("#helpModal>.help-tip")
        if __t(intro) then
            local ____intro_dataset_58 = intro.dataset
            local ____intro_dataset_controlsOriginal_57 = intro.dataset.controlsOriginal
            if ____intro_dataset_controlsOriginal_57 == nil then
                ____intro_dataset_controlsOriginal_57 = intro.textContent
            end
            ____intro_dataset_58.controlsOriginal = ____intro_dataset_controlsOriginal_57
            intro.textContent = __call(
                intro.dataset.controlsOriginal,
                "replace",
                "Use E para",
                __add(
                    __add(
                        "Use ",
                        api:getLabel("interact")
                    ),
                    " para"
                )
            )
        end
        if __t(tip) then
            local ____tip_dataset_60 = tip.dataset
            local ____tip_dataset_controlsOriginal_59 = tip.dataset.controlsOriginal
            if ____tip_dataset_controlsOriginal_59 == nil then
                ____tip_dataset_controlsOriginal_59 = tip.textContent
            end
            ____tip_dataset_60.controlsOriginal = ____tip_dataset_controlsOriginal_59
            tip.textContent = __call(
                __call(
                    __call(
                        tip.dataset.controlsOriginal,
                        "replace",
                        "entre com V",
                        __add(
                            "entre com ",
                            api:getLabel("vehicle")
                        )
                    ),
                    "replace",
                    "com E junto",
                    __add(
                        __add(
                            "com ",
                            api:getLabel("interact")
                        ),
                        " junto"
                    )
                ),
                "replace",
                "B ou o botão",
                __add(
                    __add(
                        "",
                        api:getLabel("bivolt")
                    ),
                    " ou o botão"
                )
            )
        end
    end
    function refresh(self)
        renderBindings(nil)
        refreshFeel(nil)
        updateHints(nil)
    end
    function beginCapture(self, action, slot)
        stopCapture(nil)
        capturing = {action = action, slot = slot}
        local ____opt_63 = window.Game
        if ____opt_63 ~= nil then
            ____opt_63 = ____opt_63.releaseInputs
        end
        if ____opt_63 ~= nil then
            ____opt_63(____opt_63)
        end
        window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {active = true}}))
        local ____callq_67 = __callq
        local ____opt_65 = modal:querySelector(__add(
            __add(
                __add(
                    __add("[data-binding-action=\"", action),
                    "\"][data-binding-slot=\""
                ),
                slot
            ),
            "\"]"
        ))
        if ____opt_65 ~= nil then
            ____opt_65 = ____opt_65.classList
        end
        ____callq_67(____opt_65, "add", "is-listening")
        captureBox.hidden = false
        captureBox.dataset.state = "listening"
        captureTitle.textContent = __add(
            __add(
                "Pressione uma tecla para ",
                __call(
                    actionName(nil, action),
                    "toLowerCase"
                )
            ),
            "."
        )
        captureCopy.textContent = __add(
            __add("A próxima tecla será o atalho ", slot + 1),
            ". Esc cancela sem alterar nada."
        )
        swapButton.hidden = true
        cancelCapture.textContent = "CANCELAR"
        captureBox:scrollIntoView({block = "nearest", behavior = "instant"})
    end
    function stopCapture(self)
        capturing = nil
        conflict = nil
        captureBox.hidden = true
        swapButton.hidden = true
        __call(
            modal:querySelectorAll(".is-listening"),
            "forEach",
            function(____, el) return el.classList:remove("is-listening") end
        )
        window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {active = false}}))
        local ____opt_70 = window.Game
        if ____opt_70 ~= nil then
            ____opt_70 = ____opt_70.releaseInputs
        end
        if ____opt_70 ~= nil then
            ____opt_70(____opt_70)
        end
    end
    local ____ = "use strict"
    api = window.ControlSettings
    local shell = window.document:getElementById("gameShell")
    local ____t_3 = __t
    local ____t_result_2
    local ____t_1 = __t
    local ____temp_0 = not __t(api) or not __t(shell)
    __O[2506] = ____temp_0
    if ____t_1(____temp_0) then
        ____t_result_2 = __O[2506]
    else
        ____t_result_2 = window.ControlSettingsUI
    end
    if ____t_3(____t_result_2) then
        return
    end
    canvas = window.document:getElementById("gameCanvas")
    local icons = __ord({pad = "<path d=\"M5 5h14v2h3v12h-6l-3-3h-2l-3 3H2V7h3z\"/><path class=\"ink-light\" d=\"M6 8h2v3h3v2H8v3H6v-3H3v-2h3zm10 1h3v3h-3zm-3 4h3v3h-3z\"/>", boots = "<path d=\"M3 2h7v11h4v7H2v-5h1zm11 0h7v11h2v7h-7v-5h-2z\"/><path class=\"ink-light\" d=\"M5 5h3v8H5zm11 0h3v8h-3zM4 16h8v2H4zm14 0h3v2h-3z\"/>", paper = "<path d=\"M5 1h11l5 5v16H3V3h2zm10 2v5h4\"/><path class=\"ink-light\" d=\"M6 10h12v2H6zm0 4h12v2H6zm0 4h8v2H6z\"/>", leaf = "<path d=\"M12 1h3v5h5v3h3v4h-4v4h-5v6h-3V13H6V9H2V6h6v3h3z\"/><path class=\"ink-light\" d=\"M15 8h3v3h-3zm-3 3h3v2h-3z\"/>"}, "pad,boots,paper,leaf")
    svg = function(____, name)
        local ____add_8 = __add
        local ____add_7 = __add
        local ____t_result_6
        local ____t_5 = __t
        local ____get_result_4 = __get(icons, name)
        __O[2507] = ____get_result_4
        if ____t_5(____get_result_4) then
            ____t_result_6 = __O[2507]
        else
            ____t_result_6 = icons.pad
        end
        return ____add_8(
            ____add_7("<svg viewBox=\"0 0 24 24\" aria-hidden=\"true\" shape-rendering=\"crispEdges\">", ____t_result_6),
            "</svg>"
        )
    end
    groups = __arrL(
        {
            __ord(
                {
                    label = "PÉS NA ESTRADA",
                    icon = "boots",
                    actions = __arrL({
                        "left",
                        "right",
                        "up",
                        "down",
                        "jump"
                    }, 5)
                },
                "label,icon,actions"
            ),
            __ord(
                {
                    label = "NA HORA DA RESENHA",
                    icon = "paper",
                    actions = __arrL({
                        "paper",
                        "fart",
                        "dash",
                        "reeis",
                        "bivolt"
                    }, 5)
                },
                "label,icon,actions"
            ),
            __ord(
                {
                    label = "PELA AVENTURA",
                    icon = "leaf",
                    actions = __arrL({"interact", "vehicle", "taunt", "pause"}, 4)
                },
                "label,icon,actions"
            )
        },
        3
    )
    descriptions = __ord({
        left = "Andar para a esquerda",
        right = "Andar para a direita",
        up = "Subir durante o voo",
        down = "Descer durante o voo",
        jump = "Pular · segure no ar para voar",
        paper = "Bolinhas e papaias elementais",
        fart = "Peido de ataque e combo",
        dash = "Esquiva rápida após o treino do Mota",
        reeis = "Chamar o aliado depois de recrutá-lo",
        bivolt = "Energético após a missão das garotas",
        interact = "Conversar, abrir salas e confirmar desafios",
        vehicle = "Entrar e sair do carro a gás",
        taunt = "Chamar Nikolas de batata",
        pause = "Pausar e continuar a aventura"
    }, "left,right,up,down,jump,paper,fart,dash,reeis,bivolt,interact,vehicle,taunt,pause")
    local labels = __ord({
        left = "Esquerda",
        right = "Direita",
        up = "Subir",
        down = "Descer",
        jump = "Pular / voar",
        paper = "Papel",
        fart = "Peidão",
        dash = "Dash",
        reeis = "OOO REEEIS!",
        bivolt = "Bivolt",
        interact = "Interagir",
        vehicle = "Carro a gás",
        taunt = "Provocar",
        pause = "Pausa"
    }, "left,right,up,down,jump,paper,fart,dash,reeis,bivolt,interact,vehicle,taunt,pause")
    capturing = nil
    conflict = nil
    local resumeAfterClose = false
    local returnFocus = nil
    local tab = "keys"
    resetRequested = false
    persistenceAvailable = true
    modal = window.document:createElement("dialog")
    modal.id = "controlSettingsModal"
    modal.className = "control-settings-modal"
    modal:setAttribute("aria-labelledby", "controlSettingsTitle")
    modal.innerHTML = __add(
        __add(
            __add(
                __add(
                    __add(
                        __add(
                            "<header class=\"controls-notebook-header\"><span class=\"controls-stamp\">",
                            svg(nil, "pad")
                        ),
                        "</span><div><span class=\"controls-eyebrow\">O CADERNO DO AVENTUREIRO</span><h2 id=\"controlSettingsTitle\">Do seu jeito, da roça.</h2><p>Teclas e resposta dos controles</p></div><button type=\"button\" class=\"controls-close\" aria-label=\"Fechar configurações\">×</button></header><nav class=\"controls-tabs\" aria-label=\"Configurações de controle\" role=\"tablist\"><button type=\"button\" role=\"tab\" id=\"controlTabKeys\" aria-controls=\"controlKeysPage\" data-control-tab=\"keys\">TECLAS E ATAQUES</button><button type=\"button\" role=\"tab\" id=\"controlTabFeel\" aria-controls=\"controlFeelPage\" data-control-tab=\"feel\">SENSIBILIDADE</button></nav><div class=\"controls-pages\"><section id=\"controlKeysPage\" role=\"tabpanel\" aria-labelledby=\"controlTabKeys\"><p class=\"controls-instructions\">Clique numa tecla e pressione a nova. Cada ação aceita dois atalhos. <kbd>Esc</kbd> cancela a escolha.</p><p class=\"controls-mobile-note\">No celular, os botões de toque continuam disponíveis. Para trocar teclas, conecte um teclado.</p><div class=\"controls-binding-groups\"></div></section><section id=\"controlFeelPage\" role=\"tabpanel\" aria-labelledby=\"controlTabFeel\" hidden><div class=\"controls-feel-card\"><div class=\"controls-feel-heading\">"
                    ),
                    svg(nil, "boots")
                ),
                "<div><h3>Resposta do movimento</h3><p>Encontre o ponto certo pro seu passo.</p></div><output id=\"controlSensitivityValue\" for=\"controlSensitivity\">1,00×</output></div><label for=\"controlSensitivity\">Sensibilidade do joystick e da direção</label><input type=\"range\" id=\"controlSensitivity\" min=\"0.5\" max=\"2\" step=\"0.05\"><div class=\"controls-range-labels\"><span>Mais suave · 0,5×</span><span>Mais rápida · 2×</span></div><p class=\"controls-field-note\">Muda a resposta da direção. A velocidade máxima continua dependendo dos seus atributos; este ajuste não dá velocidade extra.</p></div><div class=\"controls-feel-card\"><div class=\"controls-feel-heading\">"
            ),
            svg(nil, "pad")
        ),
        "<div><h3>Zona morta do joystick</h3><p>Evite que o personagem ande sem querer.</p></div><output id=\"controlDeadzoneValue\" for=\"controlDeadzone\">12%</output></div><label for=\"controlDeadzone\">Área central sem movimento</label><input type=\"range\" id=\"controlDeadzone\" min=\"0\" max=\"0.4\" step=\"0.01\"><div class=\"controls-range-labels\"><span>0% · mais preciso</span><span>40% · centro maior</span></div><p class=\"controls-field-note\">Movimentos dentro dessa área são ignorados. Fora dela, a direção continua suave, sem salto de velocidade.</p><div class=\"controls-stick-example\" aria-hidden=\"true\"><span><i></i></span><small>O centro sombreado é a zona morta.</small></div></div></section></div><aside class=\"controls-capture\" hidden aria-live=\"polite\"><span class=\"controls-capture-title\"></span><p class=\"controls-capture-copy\"></p><div class=\"controls-capture-actions\"><button type=\"button\" id=\"controlSwapBtn\" hidden>TROCAR TECLAS</button><button type=\"button\" id=\"controlCancelCapture\">CANCELAR</button></div></aside><footer class=\"controls-footer\"><div><span class=\"controls-save-mark\" aria-hidden=\"true\">✓</span><p id=\"controlSaveStatus\" role=\"status\" aria-live=\"polite\">Salvo neste dispositivo · separado do progresso.</p></div><div class=\"controls-footer-actions\"><button type=\"button\" id=\"controlResetBtn\">Restaurar padrões</button><button type=\"button\" class=\"controls-done\">PRONTO <span>✓</span></button></div></footer>"
    )
    shell:append(modal)
    grid = modal:querySelector(".controls-binding-groups")
    captureBox = modal:querySelector(".controls-capture")
    captureTitle = modal:querySelector(".controls-capture-title")
    captureCopy = modal:querySelector(".controls-capture-copy")
    swapButton = modal:querySelector("#controlSwapBtn")
    cancelCapture = modal:querySelector("#controlCancelCapture")
    status = modal:querySelector("#controlSaveStatus")
    resetButton = modal:querySelector("#controlResetBtn")
    sensitivity = modal:querySelector("#controlSensitivity")
    deadzone = modal:querySelector("#controlDeadzone")
    actionName = function(____, id)
        local ____t_result_15
        local ____t_14 = __t
        local ____t_result_13
        local ____t_10 = __t
        local ____get_result_9 = __get(labels, id)
        __O[2508] = ____get_result_9
        if ____t_10(____get_result_9) then
            ____t_result_13 = __O[2508]
        else
            local ____opt_11 = __call(
                api.actions,
                "find",
                function(____, a) return a.id == id end
            )
            if ____opt_11 ~= nil then
                ____opt_11 = ____opt_11.label
            end
            ____t_result_13 = ____opt_11
        end
        __O[2509] = ____t_result_13
        if ____t_14(____t_result_13) then
            ____t_result_15 = __O[2509]
        else
            ____t_result_15 = id
        end
        return ____t_result_15
    end
    codeLabel = function(____, code)
        local ____t_result_16
        if __t(code) then
            ____t_result_16 = api:labelForCode(code)
        else
            ____t_result_16 = "Adicionar"
        end
        return ____t_result_16
    end
    actionKeys = function(____, id, separator)
        if separator == nil then
            separator = " / "
        end
        local ____t_result_24
        local ____t_23 = __t
        local ____call_21 = __call
        local ____call_20 = __call
        local ____t_result_19
        local ____t_18 = __t
        local ____get_result_17 = __get(
            api:getState().bindings,
            id
        )
        __O[2510] = ____get_result_17
        if ____t_18(____get_result_17) then
            ____t_result_19 = __O[2510]
        else
            ____t_result_19 = __arrL({}, 0)
        end
        local ____call_21_result_22 = ____call_21(
            ____call_20(____t_result_19, "map", codeLabel),
            "join",
            separator
        )
        __O[2511] = ____call_21_result_22
        if ____t_23(____call_21_result_22) then
            ____t_result_24 = __O[2511]
        else
            ____t_result_24 = "Sem tecla"
        end
        return ____t_result_24
    end
    local function selectTab(self, next)
        stopCapture(nil)
        tab = next
        __call(
            modal:querySelectorAll("[data-control-tab]"),
            "forEach",
            function(____, button)
                local on = button.dataset.controlTab == next
                button:setAttribute(
                    "aria-selected",
                    tostring(on)
                )
                button.tabIndex = __t(on) and 0 or -1
            end
        )
        modal:querySelector("#controlKeysPage").hidden = next ~= "keys"
        modal:querySelector("#controlFeelPage").hidden = next ~= "feel"
    end
    local function acceptKey(self, code)
        if not __t(capturing) then
            return
        end
        local target = __assign({}, capturing)
        local result = api:setBinding(target.action, code, target.slot)
        local ____opt_result_74
        if result ~= nil then
            ____opt_result_74 = result.ok
        end
        if ____opt_result_74 == false then
            captureBox.dataset.state = "conflict"
            captureTitle.textContent = __t(__lenq(result.conflicts)) and "Essa tecla já tem uma tarefa." or "Essa tecla não pode ser usada."
            local other = __getq(result.conflicts, 0)
            local oldCode = __getq(
                __get(
                    api:getState().bindings,
                    target.action
                ),
                target.slot
            )
            if __t(other) then
                local ____t_result_77
                local ____t_76 = __t
                local ____temp_75 = __len(result.conflicts) == 1 and not not __t(oldCode)
                __O[2518] = ____temp_75
                if ____t_76(____temp_75) then
                    ____t_result_77 = not __t(other.action == "pause" and other.slot == 0)
                else
                    ____t_result_77 = __O[2518]
                end
                local canSwap = ____t_result_77
                local ____add_80 = __add
                local ____add_result_79 = __add(
                    __add(
                        __add(
                            codeLabel(nil, code),
                            " está em "
                        ),
                        actionName(nil, other.action)
                    ),
                    ". "
                )
                local ____t_result_78
                if __t(canSwap) then
                    ____t_result_78 = __add(
                        __add(
                            __add(
                                __add(
                                    "Trocar coloca ",
                                    codeLabel(nil, oldCode)
                                ),
                                " em "
                            ),
                            actionName(nil, other.action)
                        ),
                        ", sem deixar ninguém sem atalho."
                    )
                else
                    ____t_result_78 = "Escolha uma tecla livre. Nenhum atalho foi removido."
                end
                captureCopy.textContent = ____add_80(____add_result_79, ____t_result_78)
                conflict = {target = target, code = code, other = other, oldCode = oldCode}
                swapButton.hidden = not __t(canSwap)
                capturing = nil
                __call(
                    modal:querySelectorAll(".is-listening"),
                    "forEach",
                    function(____, el) return el.classList:remove("is-listening") end
                )
                window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {active = false}}))
                local ____t_result_81
                if __t(canSwap) then
                    ____t_result_81 = swapButton
                else
                    ____t_result_81 = cancelCapture
                end
                ____t_result_81:focus({preventScroll = true})
            else
                local ____t_result_82
                if __t(result.message) then
                    ____t_result_82 = result.message
                else
                    ____t_result_82 = "Escolha outra tecla. Escape continua reservado para sair."
                end
                captureCopy.textContent = ____t_result_82
                swapButton.hidden = true
            end
            return
        end
        stopCapture(nil)
        saveMessage(
            nil,
            __add(
                __add(
                    __add(
                        actionName(nil, target.action),
                        ": "
                    ),
                    codeLabel(nil, code)
                ),
                ". Salvo neste dispositivo."
            )
        )
        refresh(nil)
        local ____opt_83 = modal:querySelector(__add(
            __add(
                __add(
                    __add("[data-binding-action=\"", target.action),
                    "\"][data-binding-slot=\""
                ),
                target.slot
            ),
            "\"]"
        ))
        if ____opt_83 ~= nil then
            ____opt_83:focus({preventScroll = true})
        end
    end
    local function open(self)
        if __t(modal.open) then
            return
        end
        local ____opt_85 = window.Game
        if ____opt_85 ~= nil then
            ____opt_85 = ____opt_85:getState()
        end
        local state = ____opt_85
        returnFocus = window.document.activeElement
        local ____t_100 = __t
        local ____t_result_99
        local ____t_98 = __t
        local ____t_result_97
        local ____t_96 = __t
        local ____t_result_95
        local ____t_94 = __t
        local ____t_result_93
        local ____t_92 = __t
        local ____t_result_91
        local ____t_90 = __t
        local ____opt_result_89
        if state ~= nil then
            ____opt_result_89 = state.started
        end
        __O[2519] = ____opt_result_89
        if ____t_90(____opt_result_89) then
            ____t_result_91 = not __t(state.paused)
        else
            ____t_result_91 = __O[2519]
        end
        __O[2520] = ____t_result_91
        if ____t_92(____t_result_91) then
            ____t_result_93 = not __t(state.won)
        else
            ____t_result_93 = __O[2520]
        end
        __O[2521] = ____t_result_93
        if ____t_94(____t_result_93) then
            ____t_result_95 = not __t(state.defeated)
        else
            ____t_result_95 = __O[2521]
        end
        __O[2522] = ____t_result_95
        if ____t_96(____t_result_95) then
            ____t_result_97 = not __t(state.chapterEnded)
        else
            ____t_result_97 = __O[2522]
        end
        __O[2523] = ____t_result_97
        if ____t_98(____t_result_97) then
            ____t_result_99 = not __t(window.document:querySelector("dialog[open]"))
        else
            ____t_result_99 = __O[2523]
        end
        resumeAfterClose = not not ____t_100(____t_result_99)
        local ____opt_103 = window.Game
        if ____opt_103 ~= nil then
            ____opt_103 = ____opt_103.releaseInputs
        end
        if ____opt_103 ~= nil then
            ____opt_103(____opt_103)
        end
        if __t(resumeAfterClose) then
            local ____opt_107 = window.Game
            if ____opt_107 ~= nil then
                ____opt_107 = ____opt_107.pause
            end
            if ____opt_107 ~= nil then
                ____opt_107(____opt_107)
            end
        end
        refresh(nil)
        selectTab(nil, tab)
        saveMessage(nil, "Salvo neste dispositivo · separado do progresso.")
        modal:showModal()
        local ____opt_109 = modal:querySelector(__add(
            __add("[data-control-tab=\"", tab),
            "\"]"
        ))
        if ____opt_109 ~= nil then
            ____opt_109:focus({preventScroll = true})
        end
    end
    local function close(self)
        if __t(modal.open) then
            modal:close()
        end
    end
    modal:addEventListener(
        "close",
        function()
            stopCapture(nil)
            local shouldResume = resumeAfterClose
            resumeAfterClose = false
            local ____t_112 = __t
            local ____t_result_111
            if __t(shouldResume) then
                ____t_result_111 = not __t(window.document:querySelector("dialog[open]"))
            else
                ____t_result_111 = shouldResume
            end
            if ____t_112(____t_result_111) then
                local ____opt_115 = window.Game
                if ____opt_115 ~= nil then
                    ____opt_115 = ____opt_115.resume
                end
                if ____opt_115 ~= nil then
                    ____opt_115(____opt_115)
                end
            end
            local ____opt_119 = window.Game
            if ____opt_119 ~= nil then
                ____opt_119 = ____opt_119.releaseInputs
            end
            if ____opt_119 ~= nil then
                ____opt_119(____opt_119)
            end
            window:requestAnimationFrame(function()
                local ____opt_121 = window.Game
                if ____opt_121 ~= nil then
                    ____opt_121 = ____opt_121:getState()
                end
                local state = ____opt_121
                local ____t_130 = __t
                local ____t_result_129
                local ____t_128 = __t
                local ____t_result_127
                local ____t_126 = __t
                local ____opt_result_125
                if state ~= nil then
                    ____opt_result_125 = state.started
                end
                __O[2524] = ____opt_result_125
                if ____t_126(____opt_result_125) then
                    ____t_result_127 = not __t(state.paused)
                else
                    ____t_result_127 = __O[2524]
                end
                __O[2525] = ____t_result_127
                if ____t_128(____t_result_127) then
                    ____t_result_129 = not __t(window.document:querySelector("dialog[open]"))
                else
                    ____t_result_129 = __O[2525]
                end
                if ____t_130(____t_result_129) then
                    if canvas ~= nil then
                        canvas:focus({preventScroll = true})
                    end
                else
                    local ____t_138 = __t
                    local ____t_result_137
                    local ____t_136 = __t
                    local ____opt_result_135
                    if returnFocus ~= nil then
                        ____opt_result_135 = returnFocus.isConnected
                    end
                    __O[2526] = ____opt_result_135
                    if ____t_136(____opt_result_135) then
                        ____t_result_137 = __len(returnFocus:getClientRects())
                    else
                        ____t_result_137 = __O[2526]
                    end
                    if ____t_138(____t_result_137) then
                        returnFocus:focus({preventScroll = true})
                    end
                end
            end)
        end
    )
    modal:addEventListener(
        "cancel",
        function(____, event)
            event:preventDefault()
            if __t(capturing) then
                stopCapture(nil)
            else
                close(nil)
            end
        end
    )
    modal:addEventListener(
        "click",
        function(____, event)
            if event.target ~= modal then
                return
            end
            local r = modal:getBoundingClientRect()
            local ____t_144 = __t
            local ____t_result_143
            local ____t_142 = __t
            local ____t_result_141
            local ____t_140 = __t
            local ____temp_139 = event.clientX < r.left or event.clientX > r.right
            __O[2527] = ____temp_139
            if ____t_140(____temp_139) then
                ____t_result_141 = __O[2527]
            else
                ____t_result_141 = event.clientY < r.top
            end
            __O[2528] = ____t_result_141
            if ____t_142(____t_result_141) then
                ____t_result_143 = __O[2528]
            else
                ____t_result_143 = event.clientY > r.bottom
            end
            if ____t_144(____t_result_143) then
                if __t(capturing) then
                    stopCapture(nil)
                else
                    close(nil)
                end
            end
        end
    )
    __call(
        modal:querySelectorAll(".controls-close,.controls-done"),
        "forEach",
        function(____, button) return button:addEventListener("click", close) end
    )
    __call(
        modal:querySelectorAll("[data-control-tab]"),
        "forEach",
        function(____, button) return button:addEventListener(
            "click",
            function() return selectTab(nil, button.dataset.controlTab) end
        ) end
    )
    modal:querySelector(".controls-tabs"):addEventListener(
        "keydown",
        function(____, event)
            if not __t(__call(
                __arrL({"ArrowLeft", "ArrowRight", "Home", "End"}, 4),
                "includes",
                event.key
            )) then
                return
            end
            event:preventDefault()
            local next = event.key == "Home" and "keys" or (event.key == "End" and "feel" or (tab == "keys" and "feel" or "keys"))
            selectTab(nil, next)
            modal:querySelector(__add(
                __add("[data-control-tab=\"", next),
                "\"]"
            )):focus()
        end
    )
    cancelCapture:addEventListener(
        "click",
        function()
            local ____t_result_148
            if __t(capturing) then
                ____t_result_148 = capturing
            else
                local ____opt_result_147
                if conflict ~= nil then
                    ____opt_result_147 = conflict.target
                end
                ____t_result_148 = ____opt_result_147
            end
            local last = ____t_result_148
            stopCapture(nil)
            if __t(last) then
                local ____opt_149 = modal:querySelector(__add(
                    __add(
                        __add(
                            __add("[data-binding-action=\"", last.action),
                            "\"][data-binding-slot=\""
                        ),
                        last.slot
                    ),
                    "\"]"
                ))
                if ____opt_149 ~= nil then
                    ____opt_149:focus({preventScroll = true})
                end
            end
        end
    )
    swapButton:addEventListener(
        "click",
        function()
            if not __t(conflict) then
                return
            end
            local ____conflict_151 = conflict
            local target = ____conflict_151.target
            local code = ____conflict_151.code
            local result = api:setBinding(target.action, code, target.slot, {swapConflicts = true})
            local ____opt_result_154
            if result ~= nil then
                ____opt_result_154 = result.ok
            end
            if ____opt_result_154 == false then
                local ____t_result_155
                if __t(result.message) then
                    ____t_result_155 = result.message
                else
                    ____t_result_155 = "A troca não pôde ser feita. Escolha outra tecla."
                end
                captureCopy.textContent = ____t_result_155
                return
            end
            stopCapture(nil)
            saveMessage(nil, "Teclas trocadas e salvas. Nenhuma ação ficou sem atalho.")
            refresh(nil)
            local ____opt_156 = modal:querySelector(__add(
                __add(
                    __add(
                        __add("[data-binding-action=\"", target.action),
                        "\"][data-binding-slot=\""
                    ),
                    target.slot
                ),
                "\"]"
            ))
            if ____opt_156 ~= nil then
                ____opt_156:focus({preventScroll = true})
            end
        end
    )
    resetButton:addEventListener(
        "click",
        function()
            stopCapture(nil)
            if not __t(resetRequested) then
                resetRequested = true
                resetButton.textContent = "Confirmar restauração"
                status.textContent = "Restaurar todas as teclas e a sensibilidade? Clique de novo para confirmar."
                return
            end
            api:reset()
            saveMessage(nil, "Teclas e sensibilidade restauradas. Seu progresso foi mantido.")
            refresh(nil)
        end
    )
    sensitivity:addEventListener(
        "input",
        function()
            api:setSensitivity(__TS__Number(sensitivity.value))
            refreshFeel(nil)
            saveMessage(nil)
        end
    )
    deadzone:addEventListener(
        "input",
        function()
            api:setDeadzone(__TS__Number(deadzone.value))
            refreshFeel(nil)
            saveMessage(nil)
        end
    )
    window:addEventListener(
        "keydown",
        function(____, event)
            if not __t(modal.open) then
                return
            end
            if __t(capturing) then
                event:preventDefault()
                event:stopImmediatePropagation()
                if __t(event["repeat"]) then
                    return
                end
                if event.code == "Escape" then
                    local last = capturing
                    stopCapture(nil)
                    local ____opt_158 = modal:querySelector(__add(
                        __add(
                            __add(
                                __add("[data-binding-action=\"", last.action),
                                "\"][data-binding-slot=\""
                            ),
                            last.slot
                        ),
                        "\"]"
                    ))
                    if ____opt_158 ~= nil then
                        ____opt_158:focus({preventScroll = true})
                    end
                    return
                end
                acceptKey(nil, event.code)
                return
            end
            if event.code == "Escape" then
                event:preventDefault()
                event:stopImmediatePropagation()
                if __t(conflict) then
                    stopCapture(nil)
                else
                    close(nil)
                end
                return
            end
            local ____t_164 = __t
            local ____t_result_163
            local ____t_162 = __t
            local ____this_161
            ____this_161 = event.target
            local ____opt_160 = ____this_161.closest
            if ____opt_160 ~= nil then
                ____opt_160 = ____opt_160(____this_161, "[data-control-tab]")
            end
            __O[2529] = ____opt_160
            if ____t_162(____opt_160) then
                ____t_result_163 = __call(
                    __arrL({"ArrowLeft", "ArrowRight", "Home", "End"}, 4),
                    "includes",
                    event.key
                )
            else
                ____t_result_163 = __O[2529]
            end
            if ____t_164(____t_result_163) then
                event:preventDefault()
                local next = event.key == "Home" and "keys" or (event.key == "End" and "feel" or (tab == "keys" and "feel" or "keys"))
                selectTab(nil, next)
                modal:querySelector(__add(
                    __add("[data-control-tab=\"", next),
                    "\"]"
                )):focus()
            end
            event:stopPropagation()
        end,
        true
    )
    window:addEventListener(
        "keyup",
        function(____, event)
            if __t(modal.open) then
                event:stopPropagation()
            end
        end,
        true
    )
    window:addEventListener(
        "controls-change",
        function(____, event)
            local ____opt_165 = event.detail
            if ____opt_165 ~= nil then
                ____opt_165 = ____opt_165.saved
            end
            if type(____opt_165) == "boolean" then
                persistenceAvailable = event.detail.saved
            end
            refreshFeel(nil)
            updateHints(nil)
            local ____t_168 = __t
            local ____t_result_167
            if __t(modal.open) then
                ____t_result_167 = not __t(capturing)
            else
                ____t_result_167 = modal.open
            end
            if ____t_168(____t_result_167) then
                renderBindings(nil)
            end
        end
    )
    local function settingsButton(self, id, className, text)
        local button = window.document:createElement("button")
        button.type = "button"
        button.id = id
        button.className = className
        button:setAttribute("aria-haspopup", "dialog")
        button:setAttribute("aria-controls", modal.id)
        button:setAttribute("aria-label", "Configurar controles e sensibilidade")
        button.title = "Configurar controles e sensibilidade"
        if __t(text) then
            button.textContent = text
        else
            button.innerHTML = svg(nil, "pad")
        end
        button:addEventListener("click", open)
        return button
    end
    local title = window.document:getElementById("startScreen")
    if __t(title) then
        title:append(settingsButton(nil, "titleControlsBtn", "title-controls"))
    end
    local help = window.document:getElementById("helpModal")
    if __t(help) then
        local button = settingsButton(nil, "helpControlsBtn", "controls-configure-link", "CONFIGURAR CONTROLES")
        local ____t_result_173
        local ____t_172 = __t
        local ____opt_169 = help:querySelector(".help-grid")
        local ____temp_171 = ____opt_169 and ____opt_169:insertAdjacentElement("beforebegin", button)
        __O[2530] = ____temp_171
        if ____t_172(____temp_171) then
            ____t_result_173 = __O[2530]
        else
            ____t_result_173 = help:append(button)
        end
    end
    window.ControlSettingsUI = __ord(
        {
            open = open,
            close = close,
            isOpen = function() return modal.open end,
            refresh = updateHints
        },
        "open,close,isOpen,refresh"
    )
    refresh(nil)
    selectTab(nil, "keys")
end)(nil)
return ____exports
