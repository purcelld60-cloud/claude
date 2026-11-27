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
        status.textContent = if __t(persistenceAvailable) then message else "Alterações nesta sessão. Permita o armazenamento do navegador para manter seus controles."
        modal.dataset.save = if __t(persistenceAvailable) then "saved" else "temporary"
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
                if __t(action == "pause" and slot == 0) then "Escape é uma saída fixa." else "Clique para alterar."
            )
        )
        local fixed = action == "pause" and slot == 0
        button.disabled = fixed
        button.classList:toggle(
            "is-empty",
            not __t(code)
        )
        button.classList:toggle("is-fixed", fixed)
        button.title = if __t(fixed) then "Escape sempre permite sair ou pausar" else if __t(code) then "Clique para trocar esta tecla" else "Adicionar outro atalho"
        local kbd = window.document:createElement("kbd")
        kbd.textContent = if __t(code) then codeLabel(nil, code) else "+"
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
        local ____t_25 = __t
        local ____t_20 = __t
        local ____temp_19 = if __t(code) then not __t(fixed) else code
        __O[2464] = ____temp_19
        local ____gt_24 = __gt
        local ____len_23 = __len
        local ____t_22 = __t
        local ____get_result_21 = __get(
            api:getState().bindings,
            action
        )
        __O[2463] = ____get_result_21
        if ____t_25(if ____t_20(____temp_19) then ____gt_24(
            ____len_23(if ____t_22(____get_result_21) then __O[2463] else __arrL({}, 0)),
            1
        ) else __O[2464]) then
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
                    local ____opt_result_28
                    if result ~= nil then
                        ____opt_result_28 = result.ok
                    end
                    if ____opt_result_28 == false then
                        saveMessage(nil, if __t(result.message) then result.message else "Mantenha pelo menos uma tecla para esta ação.")
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
                local ____t_30 = __t
                local ____get_result_29 = __get(descriptions, action)
                __O[2465] = ____get_result_29
                note.textContent = if ____t_30(____get_result_29) then __O[2465] else ""
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
                    local ____t_33 = __t
                    local ____t_32 = __t
                    local ____get_result_31 = __get(barActions, index)
                    __O[2466] = ____get_result_31
                    if ____t_33(if ____t_32(____get_result_31) then __get(keys, 0) else __O[2466]) then
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
                    local ____t_36 = __t
                    local ____t_35 = __t
                    local ____get_result_34 = __get(keys, 0)
                    __O[2467] = ____get_result_34
                    if ____t_36(if ____t_35(____get_result_34) then __get(helpActions, index) else __O[2467]) then
                        __get(keys, 0).textContent = if __get(helpActions, index) == "training" then __add(
                            __add(
                                api:getLabel("interact"),
                                " / "
                            ),
                            api:getLabel("jump")
                        ) else actionKeys(
                            nil,
                            __get(helpActions, index)
                        )
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
                local ____t_38 = __t
                local ____get_result_37 = __get(descriptions, action)
                __O[2468] = ____get_result_37
                local label = if ____t_38(____get_result_37) then __O[2468] else actionName(nil, action)
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
            local ____intro_dataset_40 = intro.dataset
            local ____intro_dataset_controlsOriginal_39 = intro.dataset.controlsOriginal
            if ____intro_dataset_controlsOriginal_39 == nil then
                ____intro_dataset_controlsOriginal_39 = intro.textContent
            end
            ____intro_dataset_40.controlsOriginal = ____intro_dataset_controlsOriginal_39
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
            local ____tip_dataset_42 = tip.dataset
            local ____tip_dataset_controlsOriginal_41 = tip.dataset.controlsOriginal
            if ____tip_dataset_controlsOriginal_41 == nil then
                ____tip_dataset_controlsOriginal_41 = tip.textContent
            end
            ____tip_dataset_42.controlsOriginal = ____tip_dataset_controlsOriginal_41
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
        local ____opt_45 = window.Game
        if ____opt_45 ~= nil then
            ____opt_45 = ____opt_45.releaseInputs
        end
        if ____opt_45 ~= nil then
            ____opt_45(____opt_45)
        end
        window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {active = true}}))
        local ____callq_49 = __callq
        local ____opt_47 = modal:querySelector(__add(
            __add(
                __add(
                    __add("[data-binding-action=\"", action),
                    "\"][data-binding-slot=\""
                ),
                slot
            ),
            "\"]"
        ))
        if ____opt_47 ~= nil then
            ____opt_47 = ____opt_47.classList
        end
        ____callq_49(____opt_47, "add", "is-listening")
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
        local ____opt_52 = window.Game
        if ____opt_52 ~= nil then
            ____opt_52 = ____opt_52.releaseInputs
        end
        if ____opt_52 ~= nil then
            ____opt_52(____opt_52)
        end
    end
    local ____ = "use strict"
    api = window.ControlSettings
    local shell = window.document:getElementById("gameShell")
    local ____t_2 = __t
    local ____t_1 = __t
    local ____temp_0 = not __t(api) or not __t(shell)
    __O[2457] = ____temp_0
    if ____t_2(if ____t_1(____temp_0) then __O[2457] else window.ControlSettingsUI) then
        return
    end
    canvas = window.document:getElementById("gameCanvas")
    local icons = __ord({pad = "<path d=\"M5 5h14v2h3v12h-6l-3-3h-2l-3 3H2V7h3z\"/><path class=\"ink-light\" d=\"M6 8h2v3h3v2H8v3H6v-3H3v-2h3zm10 1h3v3h-3zm-3 4h3v3h-3z\"/>", boots = "<path d=\"M3 2h7v11h4v7H2v-5h1zm11 0h7v11h2v7h-7v-5h-2z\"/><path class=\"ink-light\" d=\"M5 5h3v8H5zm11 0h3v8h-3zM4 16h8v2H4zm14 0h3v2h-3z\"/>", paper = "<path d=\"M5 1h11l5 5v16H3V3h2zm10 2v5h4\"/><path class=\"ink-light\" d=\"M6 10h12v2H6zm0 4h12v2H6zm0 4h8v2H6z\"/>", leaf = "<path d=\"M12 1h3v5h5v3h3v4h-4v4h-5v6h-3V13H6V9H2V6h6v3h3z\"/><path class=\"ink-light\" d=\"M15 8h3v3h-3zm-3 3h3v2h-3z\"/>"}, "pad,boots,paper,leaf")
    svg = function(____, name)
        local ____add_6 = __add
        local ____add_5 = __add
        local ____t_4 = __t
        local ____get_result_3 = __get(icons, name)
        __O[2458] = ____get_result_3
        return ____add_6(
            ____add_5("<svg viewBox=\"0 0 24 24\" aria-hidden=\"true\" shape-rendering=\"crispEdges\">", if ____t_4(____get_result_3) then __O[2458] else icons.pad),
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
        local ____t_12 = __t
        local ____t_8 = __t
        local ____get_result_7 = __get(labels, id)
        __O[2459] = ____get_result_7
        local ____opt_9 = __call(
            api.actions,
            "find",
            function(____, a) return a.id == id end
        )
        if ____opt_9 ~= nil then
            ____opt_9 = ____opt_9.label
        end
        local ____temp_11 = if ____t_8(____get_result_7) then __O[2459] else ____opt_9
        __O[2460] = ____temp_11
        return if ____t_12(____temp_11) then __O[2460] else id
    end
    codeLabel = function(____, code) return if __t(code) then api:labelForCode(code) else "Adicionar" end
    actionKeys = function(____, id, separator)
        if separator == nil then
            separator = " / "
        end
        local ____t_18 = __t
        local ____call_16 = __call
        local ____call_15 = __call
        local ____t_14 = __t
        local ____get_result_13 = __get(
            api:getState().bindings,
            id
        )
        __O[2461] = ____get_result_13
        local ____call_16_result_17 = ____call_16(
            ____call_15(if ____t_14(____get_result_13) then __O[2461] else __arrL({}, 0), "map", codeLabel),
            "join",
            separator
        )
        __O[2462] = ____call_16_result_17
        return if ____t_18(____call_16_result_17) then __O[2462] else "Sem tecla"
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
                button.tabIndex = if __t(on) then 0 else -1
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
        local ____opt_result_56
        if result ~= nil then
            ____opt_result_56 = result.ok
        end
        if ____opt_result_56 == false then
            captureBox.dataset.state = "conflict"
            captureTitle.textContent = if __t(__lenq(result.conflicts)) then "Essa tecla já tem uma tarefa." else "Essa tecla não pode ser usada."
            local other = __getq(result.conflicts, 0)
            local oldCode = __getq(
                __get(
                    api:getState().bindings,
                    target.action
                ),
                target.slot
            )
            if __t(other) then
                local ____t_58 = __t
                local ____temp_57 = __len(result.conflicts) == 1 and not not __t(oldCode)
                __O[2469] = ____temp_57
                local canSwap = if ____t_58(____temp_57) then not __t(other.action == "pause" and other.slot == 0) else __O[2469]
                captureCopy.textContent = __add(
                    __add(
                        __add(
                            __add(
                                codeLabel(nil, code),
                                " está em "
                            ),
                            actionName(nil, other.action)
                        ),
                        ". "
                    ),
                    if __t(canSwap) then __add(
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
                    ) else "Escolha uma tecla livre. Nenhum atalho foi removido."
                )
                conflict = {target = target, code = code, other = other, oldCode = oldCode}
                swapButton.hidden = not __t(canSwap)
                capturing = nil
                __call(
                    modal:querySelectorAll(".is-listening"),
                    "forEach",
                    function(____, el) return el.classList:remove("is-listening") end
                )
                window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {active = false}}))
                if __t(canSwap) then swapButton else cancelCapture:focus({preventScroll = true})
            else
                captureCopy.textContent = if __t(result.message) then result.message else "Escolha outra tecla. Escape continua reservado para sair."
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
        local ____opt_59 = modal:querySelector(__add(
            __add(
                __add(
                    __add("[data-binding-action=\"", target.action),
                    "\"][data-binding-slot=\""
                ),
                target.slot
            ),
            "\"]"
        ))
        if ____opt_59 ~= nil then
            ____opt_59:focus({preventScroll = true})
        end
    end
    local function open(self)
        if __t(modal.open) then
            return
        end
        local ____opt_61 = window.Game
        if ____opt_61 ~= nil then
            ____opt_61 = ____opt_61:getState()
        end
        local state = ____opt_61
        returnFocus = window.document.activeElement
        local ____t_75 = __t
        local ____t_74 = __t
        local ____t_72 = __t
        local ____t_70 = __t
        local ____t_68 = __t
        local ____t_66 = __t
        local ____opt_result_65
        if state ~= nil then
            ____opt_result_65 = state.started
        end
        __O[2470] = ____opt_result_65
        local ____temp_67 = if ____t_66(____opt_result_65) then not __t(state.paused) else __O[2470]
        __O[2471] = ____temp_67
        local ____temp_69 = if ____t_68(____temp_67) then not __t(state.won) else __O[2471]
        __O[2472] = ____temp_69
        local ____temp_71 = if ____t_70(____temp_69) then not __t(state.defeated) else __O[2472]
        __O[2473] = ____temp_71
        local ____temp_73 = if ____t_72(____temp_71) then not __t(state.chapterEnded) else __O[2473]
        __O[2474] = ____temp_73
        resumeAfterClose = not not ____t_75(if ____t_74(____temp_73) then not __t(window.document:querySelector("dialog[open]")) else __O[2474])
        local ____opt_78 = window.Game
        if ____opt_78 ~= nil then
            ____opt_78 = ____opt_78.releaseInputs
        end
        if ____opt_78 ~= nil then
            ____opt_78(____opt_78)
        end
        if __t(resumeAfterClose) then
            local ____opt_82 = window.Game
            if ____opt_82 ~= nil then
                ____opt_82 = ____opt_82.pause
            end
            if ____opt_82 ~= nil then
                ____opt_82(____opt_82)
            end
        end
        refresh(nil)
        selectTab(nil, tab)
        saveMessage(nil, "Salvo neste dispositivo · separado do progresso.")
        modal:showModal()
        local ____opt_84 = modal:querySelector(__add(
            __add("[data-control-tab=\"", tab),
            "\"]"
        ))
        if ____opt_84 ~= nil then
            ____opt_84:focus({preventScroll = true})
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
            if __t(if __t(shouldResume) then not __t(window.document:querySelector("dialog[open]")) else shouldResume) then
                local ____opt_88 = window.Game
                if ____opt_88 ~= nil then
                    ____opt_88 = ____opt_88.resume
                end
                if ____opt_88 ~= nil then
                    ____opt_88(____opt_88)
                end
            end
            local ____opt_92 = window.Game
            if ____opt_92 ~= nil then
                ____opt_92 = ____opt_92.releaseInputs
            end
            if ____opt_92 ~= nil then
                ____opt_92(____opt_92)
            end
            window:requestAnimationFrame(function()
                local ____opt_94 = window.Game
                if ____opt_94 ~= nil then
                    ____opt_94 = ____opt_94:getState()
                end
                local state = ____opt_94
                local ____t_102 = __t
                local ____t_101 = __t
                local ____t_99 = __t
                local ____opt_result_98
                if state ~= nil then
                    ____opt_result_98 = state.started
                end
                __O[2475] = ____opt_result_98
                local ____temp_100 = if ____t_99(____opt_result_98) then not __t(state.paused) else __O[2475]
                __O[2476] = ____temp_100
                if ____t_102(if ____t_101(____temp_100) then not __t(window.document:querySelector("dialog[open]")) else __O[2476]) then
                    if canvas ~= nil then
                        canvas:focus({preventScroll = true})
                    end
                else
                    local ____t_109 = __t
                    local ____t_108 = __t
                    local ____opt_result_107
                    if returnFocus ~= nil then
                        ____opt_result_107 = returnFocus.isConnected
                    end
                    __O[2477] = ____opt_result_107
                    if ____t_109(if ____t_108(____opt_result_107) then __len(returnFocus:getClientRects()) else __O[2477]) then
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
            local ____t_114 = __t
            local ____t_113 = __t
            local ____t_111 = __t
            local ____temp_110 = event.clientX < r.left or event.clientX > r.right
            __O[2478] = ____temp_110
            local ____temp_112 = if ____t_111(____temp_110) then __O[2478] else event.clientY < r.top
            __O[2479] = ____temp_112
            if ____t_114(if ____t_113(____temp_112) then __O[2479] else event.clientY > r.bottom) then
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
            local next = if event.key == "Home" then "keys" else if event.key == "End" then "feel" else if tab == "keys" then "feel" else "keys"
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
            local ____opt_result_117
            if conflict ~= nil then
                ____opt_result_117 = conflict.target
            end
            local last = if __t(capturing) then capturing else ____opt_result_117
            stopCapture(nil)
            if __t(last) then
                local ____opt_118 = modal:querySelector(__add(
                    __add(
                        __add(
                            __add("[data-binding-action=\"", last.action),
                            "\"][data-binding-slot=\""
                        ),
                        last.slot
                    ),
                    "\"]"
                ))
                if ____opt_118 ~= nil then
                    ____opt_118:focus({preventScroll = true})
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
            local ____conflict_120 = conflict
            local target = ____conflict_120.target
            local code = ____conflict_120.code
            local result = api:setBinding(target.action, code, target.slot, {swapConflicts = true})
            local ____opt_result_123
            if result ~= nil then
                ____opt_result_123 = result.ok
            end
            if ____opt_result_123 == false then
                captureCopy.textContent = if __t(result.message) then result.message else "A troca não pôde ser feita. Escolha outra tecla."
                return
            end
            stopCapture(nil)
            saveMessage(nil, "Teclas trocadas e salvas. Nenhuma ação ficou sem atalho.")
            refresh(nil)
            local ____opt_124 = modal:querySelector(__add(
                __add(
                    __add(
                        __add("[data-binding-action=\"", target.action),
                        "\"][data-binding-slot=\""
                    ),
                    target.slot
                ),
                "\"]"
            ))
            if ____opt_124 ~= nil then
                ____opt_124:focus({preventScroll = true})
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
                    local ____opt_126 = modal:querySelector(__add(
                        __add(
                            __add(
                                __add("[data-binding-action=\"", last.action),
                                "\"][data-binding-slot=\""
                            ),
                            last.slot
                        ),
                        "\"]"
                    ))
                    if ____opt_126 ~= nil then
                        ____opt_126:focus({preventScroll = true})
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
            local ____t_131 = __t
            local ____t_130 = __t
            local ____this_129
            ____this_129 = event.target
            local ____opt_128 = ____this_129.closest
            if ____opt_128 ~= nil then
                ____opt_128 = ____opt_128(____this_129, "[data-control-tab]")
            end
            __O[2480] = ____opt_128
            if ____t_131(if ____t_130(____opt_128) then __call(
                __arrL({"ArrowLeft", "ArrowRight", "Home", "End"}, 4),
                "includes",
                event.key
            ) else __O[2480]) then
                event:preventDefault()
                local next = if event.key == "Home" then "keys" else if event.key == "End" then "feel" else if tab == "keys" then "feel" else "keys"
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
            local ____opt_132 = event.detail
            if ____opt_132 ~= nil then
                ____opt_132 = ____opt_132.saved
            end
            if type(____opt_132) == "boolean" then
                persistenceAvailable = event.detail.saved
            end
            refreshFeel(nil)
            updateHints(nil)
            if __t(if __t(modal.open) then not __t(capturing) else modal.open) then
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
        local ____t_137 = __t
        local ____opt_134 = help:querySelector(".help-grid")
        local ____temp_136 = ____opt_134 and ____opt_134:insertAdjacentElement("beforebegin", button)
        __O[2481] = ____temp_136
        local ____ = if ____t_137(____temp_136) then __O[2481] else help:append(button)
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
