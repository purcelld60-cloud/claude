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
                local ____t_result_17
                local ____t_16 = __t
                local ____opt_13 = window.Game
                if ____opt_13 ~= nil then
                    ____opt_13 = ____opt_13.getState
                end
                local ____opt_result_15
                if ____opt_13 ~= nil then
                    ____opt_result_15 = ____opt_13(____opt_13)
                end
                __O[3026] = ____opt_result_15
                if ____t_16(____opt_result_15) then
                    ____t_result_17 = __O[3026]
                else
                    ____t_result_17 = {}
                end
                return true, ____t_result_17
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
        local ____t_20 = __t
        local ____opt_18 = gameState(nil).q
        if ____opt_18 ~= nil then
            ____opt_18 = ____opt_18.jorgeSeen
        end
        if ____t_20(____opt_18) then
            return unlock(nil)
        end
        do
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                if window.localStorage:getItem(UNLOCK_KEY) == "1" then
                    return true, true
                end
                local ____self_24 = window.JSON
                local ____self_24_parse_25 = ____self_24.parse
                local ____t_result_23
                local ____t_22 = __t
                local ____temp_21 = window.localStorage:getItem(SAVE_KEY)
                __O[3027] = ____temp_21
                if ____t_22(____temp_21) then
                    ____t_result_23 = __O[3027]
                else
                    ____t_result_23 = "null"
                end
                local saved = ____self_24_parse_25(____self_24, ____t_result_23)
                local ____t_32 = __t
                local ____opt_result_30
                if saved ~= nil then
                    ____opt_result_30 = saved.q
                end
                local ____opt_result_31
                if ____opt_result_30 ~= nil then
                    ____opt_result_31 = ____opt_result_30.jorgeSeen
                end
                if ____t_32(____opt_result_31) then
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
        heading:querySelector("#ranchPauseTitle").textContent = nome == "opcoes" and "OPÇÕES" or "PAUSA"
        modal.scrollTop = 0
        window:requestAnimationFrame(function()
            local ____temp_109
            if nome == "opcoes" then
                ____temp_109 = paginaOpcoes:querySelector("button:not([hidden])")
            else
                local ____t_result_108
                if __t(resume) then
                    ____t_result_108 = resume
                else
                    ____t_result_108 = optionsButton
                end
                ____temp_109 = ____t_result_108
            end
            local alvo = ____temp_109
            local ____opt_110 = alvo and alvo.focus
            if ____opt_110 ~= nil then
                ____opt_110(alvo, {preventScroll = true})
            end
        end)
    end
    function drawPortraits(self)
        local ____t_116 = __t
        local ____opt_114 = window.Art
        if ____opt_114 ~= nil then
            ____opt_114 = ____opt_114.drawCharacter
        end
        if not ____t_116(____opt_114) then
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
            ctx.fillStyle = boss.id == "nikolas" and "#5c3854" or (boss.id == "menezes" and "#5b5660" or (boss.id == "marco" and "#564772" or "#425d54"))
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
                {facing = 1, frame = 0, scale = boss.id == "giant" and 0.43 or (boss.id == "reeisBoss" and 0.8 or 0.94)}
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
        local ____t_124 = __t
        local ____t_result_123
        local ____t_122 = __t
        local ____t_result_121
        local ____t_120 = __t
        local ____t_result_119
        local ____t_118 = __t
        local ____t_result_117
        if __t(state.started) then
            ____t_result_117 = not __t(state.paused)
        else
            ____t_result_117 = state.started
        end
        __O[3031] = ____t_result_117
        if ____t_118(____t_result_117) then
            ____t_result_119 = not __t(state.won)
        else
            ____t_result_119 = __O[3031]
        end
        __O[3032] = ____t_result_119
        if ____t_120(____t_result_119) then
            ____t_result_121 = not __t(state.defeated)
        else
            ____t_result_121 = __O[3032]
        end
        __O[3033] = ____t_result_121
        if ____t_122(____t_result_121) then
            ____t_result_123 = not __t(state.chapterEnded)
        else
            ____t_result_123 = __O[3033]
        end
        resumeAfterSandbox = not not ____t_124(____t_result_123)
        local ____opt_127 = window.Game
        if ____opt_127 ~= nil then
            ____opt_127 = ____opt_127.releaseInputs
        end
        if ____opt_127 ~= nil then
            ____opt_127(____opt_127)
        end
        if __t(resumeAfterSandbox) then
            local ____opt_131 = window.Game
            if ____opt_131 ~= nil then
                ____opt_131 = ____opt_131.pause
            end
            if ____opt_131 ~= nil then
                ____opt_131(____opt_131)
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
        local ____opt_133 = window.Game
        if ____opt_133 ~= nil then
            ____opt_133 = ____opt_133.startSandboxBoss
        end
        if type(____opt_133) ~= "function" then
            sandbox:querySelector("#ranchSandboxFeedback").textContent = "A arena ainda está carregando. Tente novamente em um instante."
            return
        end
        local wasResume = resumeAfterSandbox
        resumeAfterSandbox = false
        sandbox:close()
        local result = window.Game:startSandboxBoss(____type)
        local ____t_139 = __t
        local ____temp_138 = result == false
        if not ____temp_138 then
            local ____opt_result_137
            if result ~= nil then
                ____opt_result_137 = result.ok
            end
            ____temp_138 = ____opt_result_137 == false
        end
        if ____t_139(____temp_138) then
            resumeAfterSandbox = wasResume
            sandbox:showModal()
            local ____temp_145 = sandbox:querySelector("#ranchSandboxFeedback")
            local ____t_result_144
            local ____t_143 = __t
            local ____opt_result_142
            if result ~= nil then
                ____opt_result_142 = result.error
            end
            __O[3034] = ____opt_result_142
            if ____t_143(____opt_result_142) then
                ____t_result_144 = __O[3034]
            else
                ____t_result_144 = "Termine a conversa, cena ou desafio atual antes de começar a revanche."
            end
            ____temp_145.textContent = ____t_result_144
        end
        render(nil)
    end
    function render(self)
        local state = gameState(nil)
        local unlocked = isSandboxUnlocked(nil)
        local ____t_result_182
        local ____t_181 = __t
        local ____opt_178 = window.Difficulty
        if ____opt_178 ~= nil then
            ____opt_178 = ____opt_178.getMode
        end
        local ____opt_result_180
        if ____opt_178 ~= nil then
            ____opt_result_180 = ____opt_178(____opt_178)
        end
        __O[3038] = ____opt_result_180
        if ____t_181(____opt_result_180) then
            ____t_result_182 = __O[3038]
        else
            ____t_result_182 = "normal"
        end
        local selected = ____t_result_182
        local ____opt_185 = window.Difficulty
        if ____opt_185 ~= nil then
            ____opt_185 = ____opt_185.getSettings
        end
        local ____opt_result_187
        if ____opt_185 ~= nil then
            ____opt_result_187 = ____opt_185(____opt_185, selected)
        end
        local settings = ____opt_result_187
        local ____t_193 = __t
        local ____opt_190 = window.Difficulty
        if ____opt_190 ~= nil then
            ____opt_190 = ____opt_190.isLocked
        end
        local ____opt_result_192
        if ____opt_190 ~= nil then
            ____opt_result_192 = ____opt_190(____opt_190)
        end
        local easyLocked = not not ____t_193(____opt_result_192)
        for ____, button in __iterar((window.document:querySelectorAll("[data-rp-difficulty]"))) do
            button:setAttribute(
                "aria-pressed",
                tostring(button.dataset.rpDifficulty == selected)
            )
            local ____t_result_194
            if __t(easyLocked) then
                ____t_result_194 = button.dataset.rpDifficulty ~= "easy"
            else
                ____t_result_194 = easyLocked
            end
            button.disabled = ____t_result_194
            button.title = __t(button.disabled) and "Fácil travado neste save. Só uma nova aventura permite trocar." or ""
        end
        local description = window.document:getElementById("ranchDifficultyDescription")
        if __t(description) then
            local ____t_result_199
            local ____t_198 = __t
            local ____opt_result_197
            if settings ~= nil then
                ____opt_result_197 = settings.description
            end
            __O[3039] = ____opt_result_197
            if ____t_198(____opt_result_197) then
                ____t_result_199 = __O[3039]
            else
                ____t_result_199 = "A receita original do desafio."
            end
            description.textContent = ____t_result_199
        end
        local ____t_result_204
        local ____t_203 = __t
        local ____opt_result_202
        if settings ~= nil then
            ____opt_result_202 = settings.label
        end
        __O[3040] = ____opt_result_202
        if ____t_203(____opt_result_202) then
            ____t_result_204 = __O[3040]
        else
            ____t_result_204 = "NORMAL"
        end
        local modeLabel = ____t_result_204
        sandbox:querySelector("#ranchSandboxDifficulty").textContent = __add("DIFICULDADE ", modeLabel)
        local ____t_206 = __t
        local ____t_result_205
        if __t(state.activeBoss) then
            ____t_result_205 = state.activeBoss
        else
            ____t_result_205 = state.ollyan
        end
        local noteText = ____t_206(____t_result_205) and "A escolha vale no próximo confronto. A luta atual mantém a dificuldade do início." or "A dificuldade vale nos próximos confrontos. Seus atributos e seu progresso continuam iguais."
        note.textContent = __t(easyLocked) and "FÁCIL TRAVADO NESTE SAVE · Para mudar de dificuldade, crie uma nova aventura." or noteText
        local ____opt_209 = window.CampaignRun
        if ____opt_209 ~= nil then
            ____opt_209 = ____opt_209.render
        end
        if ____opt_209 ~= nil then
            ____opt_209(____opt_209)
        end
        local ____t_result_224
        local ____t_223 = __t
        local ____t_result_222
        local ____t_213 = __t
        local ____opt_211 = state.progression
        if ____opt_211 ~= nil then
            ____opt_211 = ____opt_211.level
        end
        __O[3041] = ____opt_211
        if ____t_213(____opt_211) then
            ____t_result_222 = __O[3041]
        else
            local ____opt_218 = window.Progression
            if ____opt_218 ~= nil then
                ____opt_218 = ____opt_218.getState
            end
            local ____opt_result_220
            if ____opt_218 ~= nil then
                ____opt_result_220 = ____opt_218(____opt_218)
            end
            local ____opt_result_221
            if ____opt_result_220 ~= nil then
                ____opt_result_221 = ____opt_result_220.level
            end
            ____t_result_222 = ____opt_result_221
        end
        __O[3042] = ____t_result_222
        if ____t_223(____t_result_222) then
            ____t_result_224 = __O[3042]
        else
            ____t_result_224 = 1
        end
        local level = ____t_result_224
        local ____t_result_229
        local ____t_228 = __t
        local ____opt_225 = window.document:getElementById("stageName")
        local ____temp_227 = ____opt_225 and ____opt_225.textContent
        __O[3043] = ____temp_227
        if ____t_228(____temp_227) then
            ____t_result_229 = __O[3043]
        else
            ____t_result_229 = "A roça"
        end
        local stage = ____t_result_229
        heading:querySelector("#ranchPauseLocation").textContent = __add(
            __add(
                __add(
                    __t(state.sandbox) and "SANDBOX · " or "",
                    stage
                ),
                " · NÍVEL "
            ),
            level
        )
        sandboxButton.disabled = not __t(unlocked)
        sandboxButton:querySelector("small").textContent = __t(unlocked) and "Sandbox: escolha uma revanche." or "Libere após concluir a história de Jorge."
        sandboxButton:setAttribute(
            "aria-label",
            __t(unlocked) and "Abrir sandbox e escolher um chefe" or "Sandbox bloqueado: conclua a história de Jorge"
        )
        returnButton.hidden = not __t(state.sandbox)
        retryButton.hidden = not __t(state.sandbox)
        local ____t_232 = __t
        local ____opt_230 = state.sandbox
        if ____opt_230 ~= nil then
            ____opt_230 = ____opt_230.result
        end
        resultBanner.hidden = not ____t_232(____opt_230)
        local ____temp_238
        local ____opt_233 = state.sandbox
        if ____opt_233 ~= nil then
            ____opt_233 = ____opt_233.result
        end
        if ____opt_233 == "won" then
            ____temp_238 = "REVANCHE VENCIDA! O bolo tá vingado de novo."
        else
            local ____t_237 = __t
            local ____opt_235 = state.sandbox
            if ____opt_235 ~= nil then
                ____opt_235 = ____opt_235.result
            end
            ____temp_238 = ____t_237(____opt_235) and "A POEIRA BAIXOU. Ajuste o shape e tente outra vez." or ""
        end
        resultBanner.textContent = ____temp_238
        for ____, button in __iterar((window.document:querySelectorAll("[data-open-sandbox]"))) do
            button.disabled = not __t(unlocked)
            button:setAttribute(
                "aria-label",
                __t(unlocked) and "Sandbox: escolher um chefe" or "Sandbox bloqueado: conclua a história de Jorge"
            )
        end
        endingButton.hidden = not __t(unlocked)
        local ____opt_239 = window.document:getElementById("soundBtn")
        local sound = (____opt_239 and ____opt_239:getAttribute("aria-pressed")) == "true"
        audio:querySelector("b").textContent = __t(sound) and "SOM LIGADO" or "SOM DESLIGADO"
        audio:setAttribute(
            "aria-pressed",
            tostring(sound)
        )
    end
    local ____ = "use strict"
    local shell = window.document:getElementById("gameShell")
    local screen = window.document:getElementById("pauseScreen")
    modal = screen and screen:querySelector(".game-modal")
    local ____t_5 = __t
    local ____t_result_4
    local ____t_3 = __t
    local ____temp_2 = not __t(shell) or not __t(screen)
    __O[3024] = ____temp_2
    if ____t_3(____temp_2) then
        ____t_result_4 = __O[3024]
    else
        ____t_result_4 = not __t(modal)
    end
    if ____t_5(____t_result_4) then
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
        local ____add_10 = __add
        local ____add_9 = __add
        local ____t_result_8
        local ____t_7 = __t
        local ____get_result_6 = __get(icons, name)
        __O[3025] = ____get_result_6
        if ____t_7(____get_result_6) then
            ____t_result_8 = __O[3025]
        else
            ____t_result_8 = icons.book
        end
        return ____add_10(
            ____add_9("<svg viewBox=\"0 0 32 32\" aria-hidden=\"true\">", ____t_result_8),
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
                                __add("<span aria-hidden=\"true\">", mode == "easy" and "♧" or (mode == "hard" and "⚡" or "✦")),
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
                    local ____opt_35 = window.Difficulty
                    if ____opt_35 ~= nil then
                        ____opt_35 = ____opt_35.setMode
                    end
                    if ____opt_35 ~= nil then
                        ____opt_35(____opt_35, mode)
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
            local ____t_39 = __t
            local ____opt_37 = window.ControlSettingsUI
            if ____opt_37 ~= nil then
                ____opt_37 = ____opt_37.open
            end
            if ____t_39(____opt_37) then
                window.ControlSettingsUI:open()
            else
                local ____t_42 = __t
                local ____opt_40 = window.ControlSettingsPanel
                if ____opt_40 ~= nil then
                    ____opt_40 = ____opt_40.open
                end
                if ____t_42(____opt_40) then
                    window.ControlSettingsPanel:open()
                else
                    local ____opt_45 = window.GameView
                    if ____opt_45 ~= nil then
                        ____opt_45 = ____opt_45.openHelp
                    end
                    if ____opt_45 ~= nil then
                        ____opt_45(____opt_45)
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
            local ____opt_47 = window.document:getElementById("soundBtn")
            if ____opt_47 ~= nil then
                ____opt_47:click()
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
    local ____makeButton_69 = makeButton
    local ____add_56 = __add
    local ____t_result_55
    local ____t_54 = __t
    local ____opt_51 = window.Graphics
    if ____opt_51 ~= nil then
        ____opt_51 = ____opt_51.label
    end
    local ____opt_result_53
    if ____opt_51 ~= nil then
        ____opt_result_53 = ____opt_51(____opt_51)
    end
    __O[3028] = ____opt_result_53
    if ____t_54(____opt_result_53) then
        ____t_result_55 = __O[3028]
    else
        ____t_result_55 = "MÉDIA"
    end
    local ____add_56_result_68 = ____add_56("QUALIDADE: ", ____t_result_55)
    local ____t_result_63
    local ____t_62 = __t
    local ____opt_59 = window.Graphics
    if ____opt_59 ~= nil then
        ____opt_59 = ____opt_59.describe
    end
    local ____opt_result_61
    if ____opt_59 ~= nil then
        ____opt_result_61 = ____opt_59(____opt_59)
    end
    __O[3029] = ____opt_result_61
    if ____t_62(____opt_result_61) then
        ____t_result_63 = __O[3029]
    else
        ____t_result_63 = "Cenário vivo, luz e partículas."
    end
    gfx = ____makeButton_69(
        nil,
        "ranchGraphicsBtn",
        ____add_56_result_68,
        ____t_result_63,
        "controls",
        function()
            local ____opt_66 = window.Graphics
            if ____opt_66 ~= nil then
                ____opt_66 = ____opt_66.toggle
            end
            if ____opt_66 ~= nil then
                ____opt_66(____opt_66)
            end
            gfx:querySelector("b").textContent = __add(
                "QUALIDADE: ",
                window.Graphics:label()
            )
            gfx:querySelector("small").textContent = window.Graphics:describe()
        end
    )
    mainActions:append(gfx)
    local ____opt_72 = window.Graphics
    if ____opt_72 ~= nil then
        ____opt_72 = ____opt_72.onChange
    end
    if ____opt_72 ~= nil then
        ____opt_72(
            ____opt_72,
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
            local ____t_76 = __t
            local ____opt_74 = window.Game
            if ____opt_74 ~= nil then
                ____opt_74 = ____opt_74.retrySandboxBoss
            end
            if ____t_76(____opt_74) then
                window.Game:retrySandboxBoss()
            else
                local ____t_79 = __t
                local ____opt_77 = state.sandbox
                if ____opt_77 ~= nil then
                    ____opt_77 = ____opt_77.type
                end
                if ____t_79(____opt_77) then
                    local ____opt_82 = window.Game
                    if ____opt_82 ~= nil then
                        ____opt_82 = ____opt_82.startSandboxBoss
                    end
                    if ____opt_82 ~= nil then
                        ____opt_82(____opt_82, state.sandbox.type)
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
            local ____opt_86 = window.Game
            if ____opt_86 ~= nil then
                ____opt_86 = ____opt_86.exitSandbox
            end
            if ____opt_86 ~= nil then
                ____opt_86(____opt_86)
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
                local ____opt_90 = window.AdventureMenu
                if ____opt_90 ~= nil then
                    ____opt_90 = ____opt_90.openInfo
                end
                local ____opt_result_92
                if ____opt_90 ~= nil then
                    ____opt_result_92 = ____opt_90(____opt_90)
                end
                return ____opt_result_92
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
                local ____opt_95 = window.Game
                if ____opt_95 ~= nil then
                    ____opt_95 = ____opt_95.returnToMenu
                end
                local ____opt_result_97
                if ____opt_95 ~= nil then
                    ____opt_result_97 = ____opt_95(____opt_95)
                end
                return ____opt_result_97
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
            local ____opt_100 = window.Arena
            if ____opt_100 ~= nil then
                ____opt_100 = ____opt_100.open
            end
            local ____opt_result_102
            if ____opt_100 ~= nil then
                ____opt_result_102 = ____opt_100(____opt_100)
            end
            return ____opt_result_102
        end
    ))
    local function preserveExtra(self, button)
        local isCoop = button.id == "pauseCoopBtn"
        local title = __t(isCoop) and "DUPLA LOCAL" or __call(button.textContent, "trim")
        utility:append(labelButton(
            nil,
            button,
            title,
            __t(isCoop) and "O modo clássico de rede local." or "Mais uma parada da resenha.",
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
        local ____t_result_105
        local ____t_104 = __t
        local ____temp_103 = window.document:getElementById(id)
        __O[3030] = ____temp_103
        if ____t_104(____temp_103) then
            ____t_result_105 = __O[3030]
        else
            ____t_result_105 = mainActions:querySelector(__add("#", id))
        end
        return ____t_result_105
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
    local ____paginaInicio_append_107 = paginaInicio.append
    local ____array_106 = __TS__SparseArrayNew(__TS__Spread(__iter(__call(
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
    __TS__SparseArrayPush(____array_106, utility)
    ____paginaInicio_append_107(
        paginaInicio,
        __TS__SparseArraySpread(____array_106)
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
            __add(
                "<span class=\"rs-portrait\"><canvas width=\"128\" height=\"112\" aria-hidden=\"true\"></canvas><i>",
                boss.phases == 1 and "67" or __add(boss.phases, " FASES")
            ),
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
            local ____opt_148 = window.Game
            if ____opt_148 ~= nil then
                ____opt_148 = ____opt_148.releaseInputs
            end
            if ____opt_148 ~= nil then
                ____opt_148(____opt_148)
            end
            if __t(resumeAfterSandbox) then
                resumeAfterSandbox = false
                local ____opt_152 = window.Game
                if ____opt_152 ~= nil then
                    ____opt_152 = ____opt_152.resume
                end
                if ____opt_152 ~= nil then
                    ____opt_152(____opt_152)
                end
            end
            local ____t_162 = __t
            local ____t_result_161
            local ____t_157 = __t
            local ____opt_result_156
            if previousFocus ~= nil then
                ____opt_result_156 = previousFocus.isConnected
            end
            __O[3035] = ____opt_result_156
            if ____t_157(____opt_result_156) then
                local ____t_160 = __t
                local ____this_159
                ____this_159 = previousFocus
                local ____opt_158 = ____this_159.closest
                if ____opt_158 ~= nil then
                    ____opt_158 = ____opt_158(____this_159, "[hidden]")
                end
                ____t_result_161 = not ____t_160(____opt_158)
            else
                ____t_result_161 = __O[3035]
            end
            if ____t_162(____t_result_161) then
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
            local ____t_168 = __t
            local ____t_result_167
            local ____t_166 = __t
            local ____t_result_165
            local ____t_164 = __t
            local ____temp_163 = event.clientX < r.left or event.clientX > r.right
            __O[3036] = ____temp_163
            if ____t_164(____temp_163) then
                ____t_result_165 = __O[3036]
            else
                ____t_result_165 = event.clientY < r.top
            end
            __O[3037] = ____t_result_165
            if ____t_166(____t_result_165) then
                ____t_result_167 = __O[3037]
            else
                ____t_result_167 = event.clientY > r.bottom
            end
            if ____t_168(____t_result_167) then
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
        local ____opt_169 = window.document:querySelector("#startScreen .start-menu")
        if ____opt_169 ~= nil then
            ____opt_169:append(titleButton)
        end
    end
    window.document:addEventListener(
        "click",
        function(____, event)
            local ____t_173 = __t
            local ____this_172
            ____this_172 = event.target
            local ____opt_171 = ____this_172.closest
            if ____opt_171 ~= nil then
                ____opt_171 = ____opt_171(____this_172, "[data-open-sandbox]")
            end
            if ____t_173(____opt_171) then
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
    local ____opt_174 = window.document:querySelector("#chapterEndScreen .ending-options")
    if ____opt_174 ~= nil then
        ____opt_174:append(endingButton)
    end
    local function open(self)
        local ____opt_243 = window.Game
        if ____opt_243 ~= nil then
            ____opt_243 = ____opt_243.pause
        end
        if ____opt_243 ~= nil then
            ____opt_243(____opt_243)
        end
        render(nil)
    end
    local function close(self)
        local ____opt_247 = window.Game
        if ____opt_247 ~= nil then
            ____opt_247 = ____opt_247.resume
        end
        if ____opt_247 ~= nil then
            ____opt_247(____opt_247)
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
    local ____opt_251 = window.document:getElementById("soundBtn")
    if ____opt_251 ~= nil then
        ____opt_251:addEventListener(
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
