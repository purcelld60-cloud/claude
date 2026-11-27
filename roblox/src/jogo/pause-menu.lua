--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __mod, __ord, __arrL, __iterar, __t, __get, __arr, __call, __add, __new, __iter = __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__arr, __JSR.__call, __JSR.__add, __JSR.__new, __JSR.__iter
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__Spread = ____lualib.__TS__Spread
local __TS__Number = ____lualib.__TS__Number
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local ____exports = {}
local __O = {};
(function()
    local gameState, unlock, isSandboxUnlocked, mostrarPagina, drawPortraits, openSandbox, chooseBoss, render, modal, UNLOCK_KEY, SAVE_KEY, bosses, resume, heading, resultBanner, audio, sandboxButton, retryButton, returnButton, note, paginaInicio, paginaOpcoes, optionsButton, sandbox, bossGrid, resumeAfterSandbox, previousFocus, endingButton
    function gameState(self)
        do
            local function ____catch()
                return true, {}
            end
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                local ____t_14 = __t
                local ____opt_11 = window.Game
                if ____opt_11 ~= nil then
                    ____opt_11 = ____opt_11.getState
                end
                local ____opt_result_13
                if ____opt_11 ~= nil then
                    ____opt_result_13 = ____opt_11(____opt_11)
                end
                __O[2959] = ____opt_result_13
                return true, if ____t_14(____opt_result_13) then __O[2959] else {}
            end)
            if not ____try then
                ____hasReturned, ____returnValue = ____catch()
            end
            if ____hasReturned then
                return ____returnValue
            end
        end
    end
    function unlock(self)
        do
            pcall(function()
                window.localStorage:setItem(UNLOCK_KEY, "1")
            end)
        end
        return true
    end
    function isSandboxUnlocked(self)
        local ____t_17 = __t
        local ____opt_15 = gameState(nil).q
        if ____opt_15 ~= nil then
            ____opt_15 = ____opt_15.jorgeSeen
        end
        if ____t_17(____opt_15) then
            return unlock(nil)
        end
        do
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                if window.localStorage:getItem(UNLOCK_KEY) == "1" then
                    return true, true
                end
                local ____self_20 = window.JSON
                local ____self_20_parse_21 = ____self_20.parse
                local ____t_19 = __t
                local ____temp_18 = window.localStorage:getItem(SAVE_KEY)
                __O[2960] = ____temp_18
                local saved = ____self_20_parse_21(____self_20, if ____t_19(____temp_18) then __O[2960] else "null")
                local ____t_28 = __t
                local ____opt_result_26
                if saved ~= nil then
                    ____opt_result_26 = saved.q
                end
                local ____opt_result_27
                if ____opt_result_26 ~= nil then
                    ____opt_result_27 = ____opt_result_26.jorgeSeen
                end
                if ____t_28(____opt_result_27) then
                    return true, unlock(nil)
                end
            end)
            if ____try and ____hasReturned then
                return ____returnValue
            end
        end
        return false
    end
    function mostrarPagina(self, nome)
        paginaInicio.hidden = nome ~= "inicio"
        paginaOpcoes.hidden = nome ~= "opcoes"
        modal.classList:toggle("na-opcoes", nome == "opcoes")
        local mover = window.document:querySelector("#ranchTouchLayoutBtn b")
        if __t(mover) then
            mover.textContent = "MUDAR BOTÕES DE LUGAR"
        end
        heading:querySelector("#ranchPauseTitle").textContent = if nome == "opcoes" then "OPÇÕES" else "PAUSA"
        modal.scrollTop = 0
        window:requestAnimationFrame(function()
            local alvo = if nome == "opcoes" then paginaOpcoes:querySelector("button:not([hidden])") else if __t(resume) then resume else optionsButton
            local ____opt_101 = alvo and alvo.focus
            if ____opt_101 ~= nil then
                ____opt_101(alvo, {preventScroll = true})
            end
        end)
    end
    function drawPortraits(self)
        local ____t_107 = __t
        local ____opt_105 = window.Art
        if ____opt_105 ~= nil then
            ____opt_105 = ____opt_105.drawCharacter
        end
        if not ____t_107(____opt_105) then
            return
        end
        for ____, boss in __iterar((bosses)) do
            local canvas = bossGrid:querySelector(__add(
                __add("[data-sandbox-boss=\"", boss.id),
                "\"] canvas"
            ))
            local ctx = canvas:getContext("2d")
            ctx.imageSmoothingEnabled = false
            ctx:clearRect(0, 0, 128, 112)
            ctx.fillStyle = if boss.id == "nikolas" then "#5c3854" else if boss.id == "menezes" then "#5b5660" else if boss.id == "marco" then "#564772" else "#425d54"
            ctx:fillRect(0, 0, 128, 112)
            ctx.fillStyle = "#f2dba511"
            do
                local i = 0
                while i < 12 do
                    ctx:fillRect(
                        __mod(i * 37, 128),
                        __mod(i * 19, 112),
                        3,
                        3
                    )
                    i = i + 1
                end
            end
            ctx.fillStyle = "#182c2970"
            ctx:fillRect(25, 100, 78, 6)
            window.Art:drawCharacter(
                ctx,
                boss.art,
                64,
                106,
                {facing = 1, frame = 0, scale = if boss.id == "giant" then 0.43 else if boss.id == "reeisBoss" then 0.8 else 0.94}
            )
        end
    end
    function openSandbox(self)
        if not __t(isSandboxUnlocked(nil)) then
            return false
        end
        if __t(sandbox.open) then
            return true
        end
        previousFocus = window.document.activeElement
        local state = gameState(nil)
        local ____t_114 = __t
        local ____t_113 = __t
        local ____t_111 = __t
        local ____t_109 = __t
        local ____temp_108 = if __t(state.started) then not __t(state.paused) else state.started
        __O[2964] = ____temp_108
        local ____temp_110 = if ____t_109(____temp_108) then not __t(state.won) else __O[2964]
        __O[2965] = ____temp_110
        local ____temp_112 = if ____t_111(____temp_110) then not __t(state.defeated) else __O[2965]
        __O[2966] = ____temp_112
        resumeAfterSandbox = not not ____t_114(if ____t_113(____temp_112) then not __t(state.chapterEnded) else __O[2966])
        local ____opt_117 = window.Game
        if ____opt_117 ~= nil then
            ____opt_117 = ____opt_117.releaseInputs
        end
        if ____opt_117 ~= nil then
            ____opt_117(____opt_117)
        end
        if __t(resumeAfterSandbox) then
            local ____opt_121 = window.Game
            if ____opt_121 ~= nil then
                ____opt_121 = ____opt_121.pause
            end
            if ____opt_121 ~= nil then
                ____opt_121(____opt_121)
            end
        end
        sandbox:querySelector("#ranchSandboxFeedback").textContent = ""
        render(nil)
        drawPortraits(nil)
        sandbox:showModal()
        sandbox:querySelector("#ranchSandboxClose"):focus()
        return true
    end
    function chooseBoss(self, ____type)
        if not __t(isSandboxUnlocked(nil)) then
            return
        end
        local ____opt_123 = window.Game
        if ____opt_123 ~= nil then
            ____opt_123 = ____opt_123.startSandboxBoss
        end
        if type(____opt_123) ~= "function" then
            sandbox:querySelector("#ranchSandboxFeedback").textContent = "A arena ainda está carregando. Tente novamente em um instante."
            return
        end
        local wasResume = resumeAfterSandbox
        resumeAfterSandbox = false
        sandbox:close()
        local result = window.Game:startSandboxBoss(____type)
        local ____t_129 = __t
        local ____temp_128 = result == false
        if not ____temp_128 then
            local ____opt_result_127
            if result ~= nil then
                ____opt_result_127 = result.ok
            end
            ____temp_128 = ____opt_result_127 == false
        end
        if ____t_129(____temp_128) then
            resumeAfterSandbox = wasResume
            sandbox:showModal()
            local ____temp_134 = sandbox:querySelector("#ranchSandboxFeedback")
            local ____t_133 = __t
            local ____opt_result_132
            if result ~= nil then
                ____opt_result_132 = result.error
            end
            __O[2967] = ____opt_result_132
            ____temp_134.textContent = if ____t_133(____opt_result_132) then __O[2967] else "Termine a conversa, cena ou desafio atual antes de começar a revanche."
        end
        render(nil)
    end
    function render(self)
        local state = gameState(nil)
        local unlocked = isSandboxUnlocked(nil)
        local ____t_168 = __t
        local ____opt_165 = window.Difficulty
        if ____opt_165 ~= nil then
            ____opt_165 = ____opt_165.getMode
        end
        local ____opt_result_167
        if ____opt_165 ~= nil then
            ____opt_result_167 = ____opt_165(____opt_165)
        end
        __O[2971] = ____opt_result_167
        local selected = if ____t_168(____opt_result_167) then __O[2971] else "normal"
        local ____opt_171 = window.Difficulty
        if ____opt_171 ~= nil then
            ____opt_171 = ____opt_171.getSettings
        end
        local ____opt_result_173
        if ____opt_171 ~= nil then
            ____opt_result_173 = ____opt_171(____opt_171, selected)
        end
        local settings = ____opt_result_173
        local ____t_179 = __t
        local ____opt_176 = window.Difficulty
        if ____opt_176 ~= nil then
            ____opt_176 = ____opt_176.isLocked
        end
        local ____opt_result_178
        if ____opt_176 ~= nil then
            ____opt_result_178 = ____opt_176(____opt_176)
        end
        local easyLocked = not not ____t_179(____opt_result_178)
        for ____, button in __iterar((window.document:querySelectorAll("[data-rp-difficulty]"))) do
            button:setAttribute(
                "aria-pressed",
                tostring(button.dataset.rpDifficulty == selected)
            )
            button.disabled = if __t(easyLocked) then button.dataset.rpDifficulty ~= "easy" else easyLocked
            button.title = if __t(button.disabled) then "Fácil travado neste save. Só uma nova aventura permite trocar." else ""
        end
        local description = window.document:getElementById("ranchDifficultyDescription")
        if __t(description) then
            local ____t_183 = __t
            local ____opt_result_182
            if settings ~= nil then
                ____opt_result_182 = settings.description
            end
            __O[2972] = ____opt_result_182
            description.textContent = if ____t_183(____opt_result_182) then __O[2972] else "A receita original do desafio."
        end
        local ____t_187 = __t
        local ____opt_result_186
        if settings ~= nil then
            ____opt_result_186 = settings.label
        end
        __O[2973] = ____opt_result_186
        local modeLabel = if ____t_187(____opt_result_186) then __O[2973] else "NORMAL"
        sandbox:querySelector("#ranchSandboxDifficulty").textContent = __add("DIFICULDADE ", modeLabel)
        local noteText = if __t(if __t(state.activeBoss) then state.activeBoss else state.ollyan) then "A escolha vale no próximo confronto. A luta atual mantém a dificuldade do início." else "A dificuldade vale nos próximos confrontos. Seus atributos e seu progresso continuam iguais."
        note.textContent = if __t(easyLocked) then "FÁCIL TRAVADO NESTE SAVE · Para mudar de dificuldade, crie uma nova aventura." else noteText
        local ____opt_190 = window.CampaignRun
        if ____opt_190 ~= nil then
            ____opt_190 = ____opt_190.render
        end
        if ____opt_190 ~= nil then
            ____opt_190(____opt_190)
        end
        local ____t_204 = __t
        local ____t_194 = __t
        local ____opt_192 = state.progression
        if ____opt_192 ~= nil then
            ____opt_192 = ____opt_192.level
        end
        __O[2974] = ____opt_192
        local ____opt_199 = window.Progression
        if ____opt_199 ~= nil then
            ____opt_199 = ____opt_199.getState
        end
        local ____opt_result_201
        if ____opt_199 ~= nil then
            ____opt_result_201 = ____opt_199(____opt_199)
        end
        local ____opt_result_202
        if ____opt_result_201 ~= nil then
            ____opt_result_202 = ____opt_result_201.level
        end
        local ____temp_203 = if ____t_194(____opt_192) then __O[2974] else ____opt_result_202
        __O[2975] = ____temp_203
        local level = if ____t_204(____temp_203) then __O[2975] else 1
        local ____t_208 = __t
        local ____opt_205 = window.document:getElementById("stageName")
        local ____temp_207 = ____opt_205 and ____opt_205.textContent
        __O[2976] = ____temp_207
        local stage = if ____t_208(____temp_207) then __O[2976] else "A roça"
        heading:querySelector("#ranchPauseLocation").textContent = __add(
            __add(
                __add(if __t(state.sandbox) then "SANDBOX · " else "", stage),
                " · NÍVEL "
            ),
            level
        )
        sandboxButton.disabled = not __t(unlocked)
        sandboxButton:querySelector("small").textContent = if __t(unlocked) then "Sandbox: escolha uma revanche." else "Libere após concluir a história de Jorge."
        sandboxButton:setAttribute("aria-label", if __t(unlocked) then "Abrir sandbox e escolher um chefe" else "Sandbox bloqueado: conclua a história de Jorge")
        returnButton.hidden = not __t(state.sandbox)
        retryButton.hidden = not __t(state.sandbox)
        local ____t_211 = __t
        local ____opt_209 = state.sandbox
        if ____opt_209 ~= nil then
            ____opt_209 = ____opt_209.result
        end
        resultBanner.hidden = not ____t_211(____opt_209)
        local ____opt_212 = state.sandbox
        if ____opt_212 ~= nil then
            ____opt_212 = ____opt_212.result
        end
        local ____t_216 = __t
        local ____opt_214 = state.sandbox
        if ____opt_214 ~= nil then
            ____opt_214 = ____opt_214.result
        end
        resultBanner.textContent = if ____opt_212 == "won" then "REVANCHE VENCIDA! O bolo tá vingado de novo." else if ____t_216(____opt_214) then "A POEIRA BAIXOU. Ajuste o shape e tente outra vez." else ""
        for ____, button in __iterar((window.document:querySelectorAll("[data-open-sandbox]"))) do
            button.disabled = not __t(unlocked)
            button:setAttribute("aria-label", if __t(unlocked) then "Sandbox: escolher um chefe" else "Sandbox bloqueado: conclua a história de Jorge")
        end
        endingButton.hidden = not __t(unlocked)
        local ____opt_217 = window.document:getElementById("soundBtn")
        local sound = (____opt_217 and ____opt_217:getAttribute("aria-pressed")) == "true"
        audio:querySelector("b").textContent = if __t(sound) then "SOM LIGADO" else "SOM DESLIGADO"
        audio:setAttribute(
            "aria-pressed",
            tostring(sound)
        )
    end
    local ____ = "use strict"
    local shell = window.document:getElementById("gameShell")
    local screen = window.document:getElementById("pauseScreen")
    modal = screen and screen:querySelector(".game-modal")
    local ____t_4 = __t
    local ____t_3 = __t
    local ____temp_2 = not __t(shell) or not __t(screen)
    __O[2957] = ____temp_2
    if ____t_4(if ____t_3(____temp_2) then __O[2957] else not __t(modal)) then
        return
    end
    UNLOCK_KEY = "daroca-sandbox-v1"
    SAVE_KEY = "da-roca-adventure-v1"
    bosses = __call(
        __arrL(
            {
                __ord({
                    id = "igor",
                    art = "igor",
                    name = "Igor",
                    subtitle = "O fiscal do lanche",
                    stage = "Colégio Adventista",
                    phases = 3
                }, "id,art,name,subtitle,stage,phases"),
                __ord({
                    id = "kaique",
                    art = "kaique",
                    name = "Kaique",
                    subtitle = "Volta pra sala, véi!",
                    stage = "Colégio Adventista",
                    phases = 3
                }, "id,art,name,subtitle,stage,phases"),
                __ord({
                    id = "arthur",
                    art = "arthur",
                    name = "Arthur",
                    subtitle = "O poder do tapa",
                    stage = "Pátio da escola",
                    phases = 3
                }, "id,art,name,subtitle,stage,phases"),
                __ord({
                    id = "dede",
                    art = "dede",
                    name = "Dedé",
                    subtitle = "SEU GILÓ HOMI!",
                    stage = "Beco da fumaça",
                    phases = 3
                }, "id,art,name,subtitle,stage,phases"),
                __ord({
                    id = "freddy",
                    art = "freddy",
                    name = "Freddy",
                    subtitle = "OPEESTY DA ROÇA!",
                    stage = "Favela do Reeis",
                    phases = 3
                }, "id,art,name,subtitle,stage,phases"),
                __ord({
                    id = "reeisBoss",
                    art = "reeis",
                    name = "REEEIS",
                    subtitle = "O rei da favela",
                    stage = "Morro do Rei",
                    phases = 3
                }, "id,art,name,subtitle,stage,phases"),
                __ord({
                    id = "marco",
                    art = "marco",
                    name = "Marco",
                    subtitle = "O caderno do caos",
                    stage = "Pátio dos rabiscos",
                    phases = 3
                }, "id,art,name,subtitle,stage,phases"),
                __ord({
                    id = "giant",
                    art = "giant",
                    name = "Colosso 67",
                    subtitle = "SIX SEVEN!",
                    stage = "Mundo de papel",
                    phases = 1
                }, "id,art,name,subtitle,stage,phases"),
                __ord({
                    id = "nicolas",
                    art = "nicolas",
                    name = "Nicolas Carvalho",
                    subtitle = "A aura suprema",
                    stage = "Praça Camacan",
                    phases = 3
                }, "id,art,name,subtitle,stage,phases"),
                __ord({
                    id = "menezes",
                    art = "menezes",
                    name = "Menezes",
                    subtitle = "Rei dos ratos",
                    stage = "Esgoto da provocação",
                    phases = 3
                }, "id,art,name,subtitle,stage,phases"),
                __ord({
                    id = "ollyan",
                    art = "ollyan",
                    name = "Ollyan",
                    subtitle = "Orelhas ao vento",
                    stage = "Céu do baile",
                    phases = 3
                }, "id,art,name,subtitle,stage,phases"),
                __ord({
                    id = "nikolas",
                    art = "nikolas",
                    name = "Nikolas Arroganti",
                    subtitle = "O titã do catarro",
                    stage = "A última fatia",
                    phases = 4
                }, "id,art,name,subtitle,stage,phases")
            },
            12
        ),
        "map",
        function(____, row) return row end
    )
    local modes = __arrL(
        {
            __arrL({"easy", "FÁCIL", "Mais fôlego"}, 3),
            __arrL({"normal", "NORMAL", "A receita original"}, 3),
            __arrL({"hard", "DIFÍCIL", "Sem colher de chá"}, 3)
        },
        3
    )
    local icons = __ord({
        resume = "<path d=\"M10 6v20l17-10z\" fill=\"currentColor\"/>",
        controls = "<path d=\"M7 9h18l4 15-5 2-5-6h-6l-5 6-5-2z\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\"/><path d=\"M11 12v8m-4-4h8m8-2h2m-4 5h2\" stroke=\"currentColor\" stroke-width=\"2\"/>",
        sandbox = "<path d=\"m7 5 17 19m1-19L8 24M5 20l7 8m8 0 7-8\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"3\"/><path d=\"m7 5 1 7 5-4m12-3-1 7-5-4\" fill=\"currentColor\"/>",
        sound = "<path d=\"M7 12h5l8-6v20l-8-6H7z\" fill=\"currentColor\"/><path d=\"M23 11q7 5 0 10m2-14q12 9 0 18\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\"/>",
        exit = "<path d=\"M15 5H6v22h9m1-11h13m-6-6 6 6-6 6\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2.5\"/>",
        book = "<path d=\"M3 6h10l3 3 3-3h10v20H19l-3 3-3-3H3z\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\"/><path d=\"M16 10v16M7 12h5m-5 5h5m8-5h5m-5 5h5\" stroke=\"currentColor\" stroke-width=\"2\"/>",
        story = "<path d=\"M5 4h22v24H5zM5 10h22M10 4v6m12-6v6\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\"/><path d=\"m13 14 8 5-8 5z\" fill=\"currentColor\"/>"
    }, "resume,controls,sandbox,sound,exit,book,story")
    local function icon(self, name)
        local ____add_8 = __add
        local ____add_7 = __add
        local ____t_6 = __t
        local ____get_result_5 = __get(icons, name)
        __O[2958] = ____get_result_5
        return ____add_8(
            ____add_7("<svg viewBox=\"0 0 32 32\" aria-hidden=\"true\">", if ____t_6(____get_result_5) then __O[2958] else icons.book),
            "</svg>"
        )
    end
    local function makeButton(self, id, title, description, kind, handler)
        local button = window.document:createElement("button")
        button.id = id
        button.type = "button"
        button.className = "rp-action"
        button.innerHTML = __add(
            icon(nil, kind),
            "<span><b></b><small></small></span><i aria-hidden=\"true\">›</i>"
        )
        button:querySelector("b").textContent = title
        button:querySelector("small").textContent = description
        if __t(handler) then
            button:addEventListener("click", handler)
        end
        return button
    end
    local function labelButton(self, button, title, description, kind)
        if not __t(button) then
            return nil
        end
        __call(button.classList, "add", "rp-action")
        button.innerHTML = __add(
            icon(nil, kind),
            "<span><b></b><small></small></span><i aria-hidden=\"true\">›</i>"
        )
        button:querySelector("b").textContent = title
        button:querySelector("small").textContent = description
        return button
    end
    local function difficultyPicker(self, id)
        local field = window.document:createElement("fieldset")
        field.className = "rp-difficulty"
        local legend = window.document:createElement("legend")
        legend.textContent = "QUAL É O TAMANHO DA RESENHA?"
        field:append(legend)
        local row = window.document:createElement("div")
        row.className = "rp-difficulty-row"
        field:append(row)
        for ____, ____value in __iterar((modes)) do
            local mode = ____value[1]
            local name = ____value[2]
            local subtitle = ____value[3]
            local button = window.document:createElement("button")
            button.type = "button"
            button.dataset.rpDifficulty = mode
            button.innerHTML = __add(
                __add(
                    __add(
                        __add(
                            __add(
                                __add("<span aria-hidden=\"true\">", if mode == "easy" then "♧" else if mode == "hard" then "⚡" else "✦"),
                                "</span><b>"
                            ),
                            name
                        ),
                        "</b><small>"
                    ),
                    subtitle
                ),
                "</small>"
            )
            button:addEventListener(
                "click",
                function()
                    local ____opt_31 = window.Difficulty
                    if ____opt_31 ~= nil then
                        ____opt_31 = ____opt_31.setMode
                    end
                    if ____opt_31 ~= nil then
                        ____opt_31(____opt_31, mode)
                    end
                    render(nil)
                end
            )
            row:append(button)
        end
        local description = window.document:createElement("p")
        description.id = id
        description.className = "rp-mode-description"
        description:setAttribute("aria-live", "polite")
        field:append(description)
        return field
    end
    resume = window.document:getElementById("resumeBtn")
    local story = window.document:getElementById("replayIntroBtn")
    local book = window.document:getElementById("pauseInfoBtn")
    local home = window.document:getElementById("mainMenuBtn")
    local oldHelp = modal:querySelector("[data-open-help]")
    local extraButtons = __call(
        __arr(__TS__Spread(__iter(modal:querySelectorAll("button")))),
        "filter",
        function(____, button) return not __t(__call(
            __arrL({
                resume,
                story,
                book,
                home,
                oldHelp
            }, 5),
            "includes",
            button
        )) end
    )
    __call(modal.classList, "add", "ranch-pause", "roca-pausa")
    modal:setAttribute("aria-labelledby", "ranchPauseTitle")
    heading = window.document:createElement("header")
    heading.className = "rp-header"
    heading.innerHTML = "<h2 id=\"ranchPauseTitle\">PAUSA</h2><p id=\"ranchPauseLocation\">A resenha pode esperar um cadinho.</p>"
    local body = window.document:createElement("div")
    body.className = "rp-body"
    resultBanner = window.document:createElement("p")
    resultBanner.id = "ranchSandboxResult"
    resultBanner.className = "rp-sandbox-result"
    resultBanner:setAttribute("role", "status")
    resultBanner.hidden = true
    local mainActions = window.document:createElement("div")
    mainActions.className = "rp-main-actions"
    if __t(resume) then
        mainActions:append(labelButton(
            nil,
            resume,
            "▶ CONTINUAR",
            "O bolo não vai se recuperar sozinho.",
            "resume"
        ))
    end
    local controls = makeButton(
        nil,
        "ranchControlsBtn",
        "CONTROLES E TECLAS",
        "Teclas, resposta e joystick.",
        "controls",
        function()
            local ____t_35 = __t
            local ____opt_33 = window.ControlSettingsUI
            if ____opt_33 ~= nil then
                ____opt_33 = ____opt_33.open
            end
            if ____t_35(____opt_33) then
                window.ControlSettingsUI:open()
            else
                local ____t_38 = __t
                local ____opt_36 = window.ControlSettingsPanel
                if ____opt_36 ~= nil then
                    ____opt_36 = ____opt_36.open
                end
                if ____t_38(____opt_36) then
                    window.ControlSettingsPanel:open()
                else
                    local ____opt_41 = window.GameView
                    if ____opt_41 ~= nil then
                        ____opt_41 = ____opt_41.openHelp
                    end
                    if ____opt_41 ~= nil then
                        ____opt_41(____opt_41)
                    end
                end
            end
        end
    )
    mainActions:append(controls)
    audio = makeButton(
        nil,
        "ranchAudioBtn",
        "SOM DA ROÇA",
        "Músicas e efeitos do jogo.",
        "sound",
        function()
            local ____opt_43 = window.document:getElementById("soundBtn")
            if ____opt_43 ~= nil then
                ____opt_43:click()
            end
            render(nil)
        end
    )
    mainActions:append(audio)
    if __t(window.DarocaAudio) then
        local A = window.DarocaAudio
        local box = window.document:createElement("div")
        box.className = "rp-volume"
        box:setAttribute("role", "group")
        box:setAttribute("aria-label", "Volume")
        local function row(____, label, get, set)
            local l = window.document:createElement("label")
            l.className = "rp-vol-row"
            local b = window.document:createElement("b")
            local r = window.document:createElement("input")
            r.type = "range"
            r.min = "0"
            r.max = "100"
            r.step = "5"
            r.value = tostring(math.floor(get(nil) * 100 + 0.5))
            local v = window.document:createElement("span")
            local function show()
                b.textContent = label
                v.textContent = __add(r.value, "%")
            end
            r:addEventListener(
                "input",
                function()
                    set(
                        nil,
                        __TS__Number(r.value) / 100
                    )
                    show(nil)
                end
            )
            r:addEventListener(
                "keydown",
                function(____, e) return e:stopPropagation() end
            )
            show(nil)
            A:onChange(function()
                local now = tostring(math.floor(get(nil) * 100 + 0.5))
                if r.value ~= now then
                    r.value = now
                    show(nil)
                end
            end)
            l:append(b, r, v)
            return l
        end
        local amb = window.document:createElement("label")
        amb.className = "rp-vol-row rp-vol-check"
        local cb = window.document:createElement("input")
        cb.type = "checkbox"
        cb.checked = A:ambientOn()
        cb:addEventListener(
            "change",
            function() return A:setAmbient(cb.checked) end
        )
        local ab = window.document:createElement("b")
        ab.textContent = "SOM DE AMBIENTE"
        local as = window.document:createElement("span")
        as.textContent = "passarinhos, rio, torcida…"
        amb:append(cb, ab, as)
        box:append(
            row(nil, "MÚSICA", A.music, A.setMusic),
            row(nil, "EFEITOS", A.sfx, A.setSfx),
            amb
        )
        mainActions:append(box)
    end
    local gfx
    local ____makeButton_63 = makeButton
    local ____add_51 = __add
    local ____t_50 = __t
    local ____opt_47 = window.Graphics
    if ____opt_47 ~= nil then
        ____opt_47 = ____opt_47.label
    end
    local ____opt_result_49
    if ____opt_47 ~= nil then
        ____opt_result_49 = ____opt_47(____opt_47)
    end
    __O[2961] = ____opt_result_49
    local ____add_51_result_62 = ____add_51("QUALIDADE: ", if ____t_50(____opt_result_49) then __O[2961] else "MÉDIA")
    local ____t_57 = __t
    local ____opt_54 = window.Graphics
    if ____opt_54 ~= nil then
        ____opt_54 = ____opt_54.describe
    end
    local ____opt_result_56
    if ____opt_54 ~= nil then
        ____opt_result_56 = ____opt_54(____opt_54)
    end
    __O[2962] = ____opt_result_56
    gfx = ____makeButton_63(
        nil,
        "ranchGraphicsBtn",
        ____add_51_result_62,
        if ____t_57(____opt_result_56) then __O[2962] else "Cenário vivo, luz e partículas.",
        "controls",
        function()
            local ____opt_60 = window.Graphics
            if ____opt_60 ~= nil then
                ____opt_60 = ____opt_60.toggle
            end
            if ____opt_60 ~= nil then
                ____opt_60(____opt_60)
            end
            gfx:querySelector("b").textContent = __add(
                "QUALIDADE: ",
                window.Graphics:label()
            )
            gfx:querySelector("small").textContent = window.Graphics:describe()
        end
    )
    mainActions:append(gfx)
    local ____opt_66 = window.Graphics
    if ____opt_66 ~= nil then
        ____opt_66 = ____opt_66.onChange
    end
    if ____opt_66 ~= nil then
        ____opt_66(
            ____opt_66,
            function()
                gfx:querySelector("b").textContent = __add(
                    "QUALIDADE: ",
                    window.Graphics:label()
                )
                gfx:querySelector("small").textContent = window.Graphics:describe()
            end
        )
    end
    if __t(window.Weather) then
        local wx
        wx = makeButton(
            nil,
            "ranchWeatherBtn",
            __add(
                "CLIMA: ",
                window.Weather:label()
            ),
            window.Weather:describe(),
            "controls",
            function()
                window.Weather:next()
                wx:querySelector("b").textContent = __add(
                    "CLIMA: ",
                    window.Weather:label()
                )
                wx:querySelector("small").textContent = window.Weather:describe()
            end
        )
        mainActions:append(wx)
    end
    if __t(window.DayTime) then
        local day
        day = makeButton(
            nil,
            "ranchDayTimeBtn",
            __add(
                "HORA DO DIA: ",
                window.DayTime:label()
            ),
            window.DayTime:describe(),
            "controls",
            function()
                window.DayTime:next()
                day:querySelector("b").textContent = __add(
                    "HORA DO DIA: ",
                    window.DayTime:label()
                )
                day:querySelector("small").textContent = window.DayTime:describe()
            end
        )
        mainActions:append(day)
    end
    sandboxButton = makeButton(
        nil,
        "ranchSandboxBtn",
        "TERREIRO DOS CHEFES",
        "Sandbox: escolha uma revanche.",
        "sandbox",
        function() return openSandbox(nil) end
    )
    mainActions:append(sandboxButton)
    retryButton = makeButton(
        nil,
        "ranchRetrySandboxBtn",
        "TENTAR DE NOVO",
        "Reinicie esta revanche com vida cheia.",
        "sandbox",
        function()
            local state = gameState(nil)
            local ____t_70 = __t
            local ____opt_68 = window.Game
            if ____opt_68 ~= nil then
                ____opt_68 = ____opt_68.retrySandboxBoss
            end
            if ____t_70(____opt_68) then
                window.Game:retrySandboxBoss()
            else
                local ____t_73 = __t
                local ____opt_71 = state.sandbox
                if ____opt_71 ~= nil then
                    ____opt_71 = ____opt_71.type
                end
                if ____t_73(____opt_71) then
                    local ____opt_76 = window.Game
                    if ____opt_76 ~= nil then
                        ____opt_76 = ____opt_76.startSandboxBoss
                    end
                    if ____opt_76 ~= nil then
                        ____opt_76(____opt_76, state.sandbox.type)
                    end
                end
            end
            render(nil)
        end
    )
    retryButton.hidden = true
    mainActions:append(retryButton)
    returnButton = makeButton(
        nil,
        "ranchExitSandboxBtn",
        "VOLTAR À CAMPANHA",
        "Encerre o treino e recupere sua aventura.",
        "exit",
        function()
            local ____opt_80 = window.Game
            if ____opt_80 ~= nil then
                ____opt_80 = ____opt_80.exitSandbox
            end
            if ____opt_80 ~= nil then
                ____opt_80(____opt_80)
            end
            render(nil)
        end
    )
    returnButton.hidden = true
    mainActions:append(returnButton)
    local difficulty = difficultyPicker(nil, "ranchDifficultyDescription")
    note = window.document:createElement("p")
    note.id = "ranchDifficultyNote"
    note.className = "rp-note"
    local utility = window.document:createElement("div")
    utility.className = "rp-utility"
    if __t(book) then
        utility:append(labelButton(
            nil,
            book,
            "DIÁRIO E TURMA",
            "Missões, personagens e instalação.",
            "book"
        ))
    else
        utility:append(makeButton(
            nil,
            "ranchBookBtn",
            "DIÁRIO E TURMA",
            "Missões, personagens e instalação.",
            "book",
            function()
                local ____opt_84 = window.AdventureMenu
                if ____opt_84 ~= nil then
                    ____opt_84 = ____opt_84.openInfo
                end
                local ____opt_result_86
                if ____opt_84 ~= nil then
                    ____opt_result_86 = ____opt_84(____opt_84)
                end
                return ____opt_result_86
            end
        ))
    end
    if __t(story) then
        utility:append(labelButton(
            nil,
            story,
            "REVER A HISTÓRIA",
            "A amizade antes da última fatia.",
            "story"
        ))
    end
    if __t(home) then
        utility:append(labelButton(
            nil,
            home,
            "MENU PRINCIPAL",
            "Seu progresso continua guardado.",
            "exit"
        ))
    else
        utility:append(makeButton(
            nil,
            "ranchHomeBtn",
            "MENU PRINCIPAL",
            "Seu progresso continua guardado.",
            "exit",
            function()
                local ____opt_89 = window.Game
                if ____opt_89 ~= nil then
                    ____opt_89 = ____opt_89.returnToMenu
                end
                local ____opt_result_91
                if ____opt_89 ~= nil then
                    ____opt_result_91 = ____opt_89(____opt_89)
                end
                return ____opt_result_91
            end
        ))
    end
    utility:append(makeButton(
        nil,
        "ranchArenaBtn",
        "ARENA ONLINE",
        "Crie uma sala pelo celular.",
        "sandbox",
        function()
            local ____opt_94 = window.Arena
            if ____opt_94 ~= nil then
                ____opt_94 = ____opt_94.open
            end
            local ____opt_result_96
            if ____opt_94 ~= nil then
                ____opt_result_96 = ____opt_94(____opt_94)
            end
            return ____opt_result_96
        end
    ))
    local function preserveExtra(self, button)
        local isCoop = button.id == "pauseCoopBtn"
        local title = if __t(isCoop) then "DUPLA LOCAL" else __call(button.textContent, "trim")
        utility:append(labelButton(
            nil,
            button,
            title,
            if __t(isCoop) then "O modo clássico de rede local." else "Mais uma parada da resenha.",
            "controls"
        ))
    end
    __call(extraButtons, "forEach", preserveExtra)
    local footer = window.document:createElement("footer")
    footer.className = "rp-footer"
    footer.innerHTML = "<span aria-hidden=\"true\">✦</span> CULTIVE O SHAPE. COLHA A VITÓRIA. <span aria-hidden=\"true\">✦</span>"
    paginaInicio = window.document:createElement("div")
    paginaInicio.className = "roca-pagina"
    paginaInicio.dataset.pagina = "inicio"
    paginaOpcoes = window.document:createElement("div")
    paginaOpcoes.className = "roca-pagina"
    paginaOpcoes.dataset.pagina = "opcoes"
    paginaOpcoes.hidden = true
    optionsButton = makeButton(
        nil,
        "ranchOptionsBtn",
        "⚙ OPÇÕES",
        "Hora do dia, clima, qualidade, som e botões.",
        "controls",
        function() return mostrarPagina(nil, "opcoes") end
    )
    local optionsBack = makeButton(
        nil,
        "ranchOptionsBackBtn",
        "◀ VOLTAR",
        "Voltar ao menu de pausa.",
        "exit",
        function() return mostrarPagina(nil, "inicio") end
    )
    local function pick(____, id)
        local ____t_98 = __t
        local ____temp_97 = window.document:getElementById(id)
        __O[2963] = ____temp_97
        return if ____t_98(____temp_97) then __O[2963] else mainActions:querySelector(__add("#", id))
    end
    paginaOpcoes:append(__TS__Spread(__iter(__call(
        __call(
            __arrL({"ranchDayTimeBtn", "ranchWeatherBtn", "ranchGraphicsBtn", "ranchAudioBtn"}, 4),
            "map",
            pick
        ),
        "filter",
        window.Boolean
    ))))
    local volume = mainActions:querySelector(".rp-volume")
    if __t(volume) then
        paginaOpcoes:append(volume)
    end
    paginaOpcoes:append(controls, difficulty, note, optionsBack)
    local homeButton = utility:querySelector("#mainMenuBtn,#ranchHomeBtn")
    local ____paginaInicio_append_100 = paginaInicio.append
    local ____array_99 = __TS__SparseArrayNew(__TS__Spread(__iter(__call(
        __arrL({
            resume,
            optionsButton,
            sandboxButton,
            retryButton,
            returnButton
        }, 5),
        "filter",
        window.Boolean
    ))))
    __TS__SparseArrayPush(____array_99, utility)
    ____paginaInicio_append_100(
        paginaInicio,
        __TS__SparseArraySpread(____array_99)
    )
    local fim = window.document:createElement("div")
    fim.className = "rp-utility"
    if __t(homeButton) then
        fim:append(homeButton)
    end
    paginaInicio:append(fim)
    body:append(resultBanner, paginaInicio, paginaOpcoes)
    modal:replaceChildren(heading, body, footer)
    __new(
        "MutationObserver",
        function(____, records)
            for ____, record in __iterar((records)) do
                for ____, node in __iterar((record.addedNodes)) do
                    if __t(node.nodeType == 1 and node.tagName == "BUTTON") then
                        preserveExtra(nil, node)
                    end
                end
            end
        end
    ):observe(modal, {childList = true})
    if __t(oldHelp) then
        oldHelp.hidden = true
        body:append(oldHelp)
    end
    sandbox = window.document:createElement("dialog")
    sandbox.id = "ranchSandboxDialog"
    sandbox.className = "ranch-sandbox"
    sandbox:setAttribute("aria-labelledby", "ranchSandboxTitle")
    sandbox.innerHTML = "<header class=\"rs-heading\"><div><span class=\"rp-eyebrow\">O BOLO VOLTOU. A REVANCHE TAMBÉM.</span><h2 id=\"ranchSandboxTitle\">TERREIRO DOS CHEFES</h2></div><button type=\"button\" id=\"ranchSandboxClose\" aria-label=\"Fechar seleção de chefes\">×</button></header><p class=\"rs-intro\">Escolha um chefe e vá direto para a luta. Seu nível e suas habilidades acompanham você; missões, experiência e inventário da campanha ficam guardados.</p><div class=\"rs-top\"><span id=\"ranchSandboxDifficulty\"></span><span>SOLO · TREINO LIVRE</span></div><div class=\"rs-bosses\" id=\"ranchSandboxBosses\"></div><p class=\"rs-feedback\" id=\"ranchSandboxFeedback\" role=\"status\"></p><footer class=\"rs-footer\"><span>12 REVANCHES. UM CHAPÉU. NENHUMA DESCULPA.</span><button type=\"button\" id=\"ranchSandboxBack\">VOLTAR À VARANDA</button></footer>"
    shell:append(sandbox)
    bossGrid = sandbox:querySelector("#ranchSandboxBosses")
    for ____, boss in __iterar((bosses)) do
        local button = window.document:createElement("button")
        button.type = "button"
        button.className = "rs-boss"
        button.dataset.sandboxBoss = boss.id
        button.innerHTML = __add(
            __add("<span class=\"rs-portrait\"><canvas width=\"128\" height=\"112\" aria-hidden=\"true\"></canvas><i>", if boss.phases == 1 then "67" else __add(boss.phases, " FASES")),
            "</i></span><span class=\"rs-copy\"><small></small><b></b><span></span></span><span class=\"rs-challenge\" aria-hidden=\"true\">DESAFIAR →</span>"
        )
        button:querySelector(".rs-copy small").textContent = boss.stage
        button:querySelector(".rs-copy b").textContent = boss.name
        button:querySelector(".rs-copy span").textContent = boss.subtitle
        button:setAttribute(
            "aria-label",
            __add(
                __add("Enfrentar ", boss.name),
                " no sandbox"
            )
        )
        button:addEventListener(
            "click",
            function() return chooseBoss(nil, boss.id) end
        )
        bossGrid:append(button)
    end
    resumeAfterSandbox = false
    previousFocus = nil
    local function closeSandbox(self)
        if __t(sandbox.open) then
            sandbox:close()
        end
    end
    sandbox:querySelector("#ranchSandboxClose"):addEventListener("click", closeSandbox)
    sandbox:querySelector("#ranchSandboxBack"):addEventListener("click", closeSandbox)
    sandbox:addEventListener(
        "close",
        function()
            if __t(sandbox.open) then
                return
            end
            local ____opt_137 = window.Game
            if ____opt_137 ~= nil then
                ____opt_137 = ____opt_137.releaseInputs
            end
            if ____opt_137 ~= nil then
                ____opt_137(____opt_137)
            end
            if __t(resumeAfterSandbox) then
                resumeAfterSandbox = false
                local ____opt_141 = window.Game
                if ____opt_141 ~= nil then
                    ____opt_141 = ____opt_141.resume
                end
                if ____opt_141 ~= nil then
                    ____opt_141(____opt_141)
                end
            end
            local ____t_150 = __t
            local ____t_146 = __t
            local ____opt_result_145
            if previousFocus ~= nil then
                ____opt_result_145 = previousFocus.isConnected
            end
            __O[2968] = ____opt_result_145
            local ____t_149 = __t
            local ____this_148
            ____this_148 = previousFocus
            local ____opt_147 = ____this_148.closest
            if ____opt_147 ~= nil then
                ____opt_147 = ____opt_147(____this_148, "[hidden]")
            end
            if ____t_150(if ____t_146(____opt_result_145) then not ____t_149(____opt_147) else __O[2968]) then
                previousFocus:focus()
            end
        end
    )
    sandbox:addEventListener(
        "click",
        function(____, event)
            if event.target ~= sandbox then
                return
            end
            local r = sandbox:getBoundingClientRect()
            local ____t_155 = __t
            local ____t_154 = __t
            local ____t_152 = __t
            local ____temp_151 = event.clientX < r.left or event.clientX > r.right
            __O[2969] = ____temp_151
            local ____temp_153 = if ____t_152(____temp_151) then __O[2969] else event.clientY < r.top
            __O[2970] = ____temp_153
            if ____t_155(if ____t_154(____temp_153) then __O[2970] else event.clientY > r.bottom) then
                closeSandbox(nil)
            end
        end
    )
    local titleButton = window.document:querySelector("#startScreen [data-open-sandbox]")
    if not __t(titleButton) then
        titleButton = window.document:createElement("button")
        titleButton.type = "button"
        titleButton.id = "titleSandboxBtn"
        titleButton.className = "menu-book-button"
        titleButton.innerHTML = __add(
            icon(nil, "sandbox"),
            "<span>TERREIRO DOS CHEFES</span>"
        )
        titleButton.dataset.openSandbox = ""
        local ____opt_156 = window.document:querySelector("#startScreen .start-menu")
        if ____opt_156 ~= nil then
            ____opt_156:append(titleButton)
        end
    end
    window.document:addEventListener(
        "click",
        function(____, event)
            local ____t_160 = __t
            local ____this_159
            ____this_159 = event.target
            local ____opt_158 = ____this_159.closest
            if ____opt_158 ~= nil then
                ____opt_158 = ____opt_158(____this_159, "[data-open-sandbox]")
            end
            if ____t_160(____opt_158) then
                event:preventDefault()
                openSandbox(nil)
            end
        end
    )
    endingButton = window.document:createElement("button")
    endingButton.type = "button"
    endingButton.id = "endingSandboxBtn"
    endingButton.textContent = "SANDBOX · DESAFIAR CHEFES"
    endingButton:addEventListener(
        "click",
        function() return openSandbox(nil) end
    )
    local ____opt_161 = window.document:querySelector("#chapterEndScreen .ending-options")
    if ____opt_161 ~= nil then
        ____opt_161:append(endingButton)
    end
    local function open(self)
        local ____opt_221 = window.Game
        if ____opt_221 ~= nil then
            ____opt_221 = ____opt_221.pause
        end
        if ____opt_221 ~= nil then
            ____opt_221(____opt_221)
        end
        render(nil)
    end
    local function close(self)
        local ____opt_225 = window.Game
        if ____opt_225 ~= nil then
            ____opt_225 = ____opt_225.resume
        end
        if ____opt_225 ~= nil then
            ____opt_225(____opt_225)
        end
    end
    __new(
        "MutationObserver",
        function()
            if not __t(screen.hidden) then
                mostrarPagina(nil, "inicio")
            end
            render(nil)
            if __t(not __t(screen.hidden) and not __t(window.document:querySelector("dialog[open]"))) then
                window:requestAnimationFrame(function() return resume and resume:focus() end)
            end
        end
    ):observe(
        screen,
        __ord(
            {
                attributes = true,
                attributeFilter = __arrL({"hidden"}, 1)
            },
            "attributes,attributeFilter"
        )
    )
    local start = window.document:getElementById("startScreen")
    if __t(start) then
        __new("MutationObserver", render):observe(
            start,
            __ord(
                {
                    attributes = true,
                    attributeFilter = __arrL({"hidden"}, 1)
                },
                "attributes,attributeFilter"
            )
        )
    end
    window:addEventListener("difficulty-change", render)
    window:addEventListener(
        "chapter-ended",
        function()
            unlock(nil)
            render(nil)
        end
    )
    window:addEventListener("sandbox-change", render)
    local ____opt_229 = window.document:getElementById("soundBtn")
    if ____opt_229 ~= nil then
        ____opt_229:addEventListener(
            "click",
            function() return window:requestAnimationFrame(render) end
        )
    end
    render(nil)
    window.RanchPause = __ord({
        open = open,
        close = close,
        render = render,
        mostrarPagina = mostrarPagina,
        openSandbox = openSandbox,
        closeSandbox = closeSandbox,
        isSandboxUnlocked = isSandboxUnlocked,
        bosses = bosses
    }, "open,close,render,mostrarPagina,openSandbox,closeSandbox,isSandboxUnlocked,bosses")
end)(nil)
return ____exports
