--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __le, __gt, __ge, __isSafeInteger, __isFiniteN, __getq, __lenq, __callq, __mod, __ord, __arrL = __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__isSafeInteger, __JSR.__isFiniteN, __JSR.__getq, __JSR.__lenq, __JSR.__callq, __JSR.__mod, __JSR.__ord, __JSR.__arrL
local __iterar, __t, __get, __set, __inc, __arr, __len, __call, __add, __new, __iter, __assign = __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__inc, __JSR.__arr, __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__new, __JSR.__iter, __JSR.__assign
local __isArray, __hypot, __re, __re_test, __re_replace = __JSR.__isArray, __JSR.__hypot, __JSR.__re, __JSR.__re_test, __JSR.__re_replace
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__AsyncAwaiter = ____lualib.__TS__AsyncAwaiter
local __TS__Await = ____lualib.__TS__Await
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__New = ____lualib.__TS__New
local __TS__ObjectFromEntries = ____lualib.__TS__ObjectFromEntries
local Map = ____lualib.Map
local __TS__Delete = ____lualib.__TS__Delete
local __TS__Number = ____lualib.__TS__Number
local Set = ____lualib.Set
local __TS__Spread = ____lualib.__TS__Spread
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local __TS__MathSign = ____lualib.__TS__MathSign
local __TS__ParseFloat = ____lualib.__TS__ParseFloat
local __TS__InstanceOf = ____lualib.__TS__InstanceOf
local ____exports = {}
local __O = {};
(function()
    local __L1 = {}
    __L1.resetInput = function(self)
        __call(__L1.held, "clear")
        __call(__L1.heldPointers, "clear")
        __L1.joystickInput = {x = 0, y = 0}
        __callq(__L1.controls, "clear")
        __L1.input.x = 0
        __L1.input.y = 0
        __L1.input.jump = false
        __L1.inputAt = 0
        local ____callq_2 = __callq
        local ____opt_0 = __L1.screen
        if ____opt_0 ~= nil then
            ____opt_0 = ____opt_0:querySelectorAll("[data-arena-input]")
        end
        ____callq_2(
            ____opt_0,
            "forEach",
            function(____, b) return b.classList:remove("pressed") end
        )
        local ____t_4 = __t
        local ____t_result_3
        if __t(__L1.opened) then
            ____t_result_3 = __L1.credentials
        else
            ____t_result_3 = __L1.opened
        end
        if ____t_4(____t_result_3) then
            __L1:syncNow()
        end
    end
    __L1.ensureUI = function(self)
        if __t(__L1.screen) then
            return
        end
        __L1.screen = window.document:createElement("section")
        __L1.screen.id = "arenaScreen"
        __L1.screen.className = "roca-arena"
        __L1.screen.hidden = true
        __L1.screen:setAttribute("role", "dialog")
        __L1.screen:setAttribute("aria-modal", "true")
        __L1.screen:setAttribute("aria-label", "Arena online da resenha")
        __L1.screen.innerHTML = "<div class=\"arena-shell\"><header class=\"arena-header\"><div><span class=\"arena-eyebrow\">DA ROÇA ADVENTURE · MODO SEPARADO</span><h2>ARENA <em>DA RESENHA</em></h2></div><button id=\"arenaClose\" class=\"arena-small-button\" aria-label=\"Sair da arena\">SAIR <span>×</span></button></header><div id=\"arenaLobby\" class=\"arena-lobby\"><div class=\"arena-intro\"><span class=\"arena-sign\">ATÉ 4 JOGADORES</span><h3>Escolha sua resenha.<br>Chame pra luta.</h3><p>Crie uma sala no celular e passe o código. Cada um joga no próprio aparelho, pela internet.</p></div><div class=\"arena-setup\"><label>SEU NOME<input id=\"arenaName\" maxlength=\"20\" autocomplete=\"nickname\" placeholder=\"Seu nome na resenha\"></label><div class=\"arena-mode-buttons\"><button id=\"arenaCreate\" class=\"arena-wood-button\">CRIAR SALA ONLINE <span>＋</span></button><button id=\"arenaPractice\" class=\"arena-paper-button\">TREINAR CONTRA BOTS <span>⚔</span></button></div><div class=\"arena-join\"><label>CÓDIGO DA SALA<input id=\"arenaCode\" inputmode=\"numeric\" maxlength=\"6\" placeholder=\"000000\" autocomplete=\"off\"></label><button id=\"arenaJoin\" class=\"arena-wood-button\">ENTRAR →</button></div><div id=\"arenaRoom\" class=\"arena-room\" hidden><div class=\"arena-room-heading\"><div><small>CÓDIGO DA SALA</small><button id=\"arenaCopyCode\" class=\"arena-room-code\" title=\"Copiar código\">------</button></div><button id=\"arenaLeave\" class=\"arena-small-button\">SAIR DA SALA</button></div><div id=\"arenaSeats\" class=\"arena-seats\"></div><div class=\"arena-room-actions\"><button id=\"arenaReady\" class=\"arena-paper-button\">ESTOU PRONTO</button><button id=\"arenaStart\" class=\"arena-wood-button\" hidden>COMEÇAR A RESENHA</button></div><p class=\"arena-network-note\">Quem cria a sala mantém o jogo aberto. A sala é online: nenhum computador precisa ficar ligado.</p></div></div><div class=\"arena-pick\"><div class=\"arena-roster-heading\"><h3>A TURMA TODA</h3><span id=\"arenaRosterCount\"></span></div><div id=\"arenaRoster\" class=\"arena-roster\" role=\"group\" aria-label=\"Escolher personagem\"></div><article id=\"arenaFighter\" class=\"arena-fighter\"><canvas id=\"arenaPortrait\" width=\"180\" height=\"172\" aria-hidden=\"true\"></canvas><div><span id=\"arenaFighterTitle\" class=\"arena-eyebrow\"></span><h3 id=\"arenaFighterName\"></h3><p id=\"arenaFighterQuote\"></p></div><dl id=\"arenaKit\"></dl></article></div></div><div id=\"arenaBattle\" class=\"arena-battle\" hidden><div class=\"arena-match-top\"><span id=\"arenaMatchCode\"></span><strong id=\"arenaRoundClock\">1:30</strong><button id=\"arenaBattleLeave\" class=\"arena-small-button\">SAIR</button></div><div class=\"arena-canvas-wrap\"><canvas id=\"arenaCanvas\" width=\"960\" height=\"540\" tabindex=\"0\" aria-label=\"Arena de combate. Setas ou WASD para andar, Espaço para pular, J ataque, K poder, L esquiva e R especial.\"></canvas><div id=\"arenaResult\" class=\"arena-result\" hidden><span class=\"arena-eyebrow\">A RESENHA TEM UM NOME</span><h3 id=\"arenaWinner\"></h3><p id=\"arenaResultText\"></p><button id=\"arenaAgain\" class=\"arena-wood-button\">PRÓXIMA RESENHA ↻</button></div><div class=\"arena-mobile-controls\"><div class=\"arena-pad\"><button data-arena-input=\"left\" aria-label=\"Andar para esquerda\">◀</button><button data-arena-input=\"right\" aria-label=\"Andar para direita\">▶</button></div><div class=\"arena-actions\"><button data-arena-input=\"dash\" class=\"arena-dash\" aria-label=\"Esquivar\">DASH</button><button data-arena-input=\"jump\" class=\"arena-jump\" aria-label=\"Pular\">PULO</button><button data-arena-input=\"attack\" aria-label=\"Ataque básico\">GOLPE</button><button data-arena-input=\"special\" class=\"arena-special\" aria-label=\"Poder do personagem\">PODER</button><button data-arena-input=\"ultimate\" class=\"arena-ultimate\" aria-label=\"Especial supremo\">SUPREMO</button></div></div></div><div id=\"arenaSkillBar\" class=\"arena-skillbar\"></div><div class=\"arena-key-hint\">WASD / SETAS: ANDAR · ESPAÇO: PULAR · J: GOLPE · K: PODER · L: DASH · R: SUPREMO · ESC: SAIR</div></div><p id=\"arenaNotice\" class=\"arena-notice\" role=\"status\" aria-live=\"polite\"></p></div>"
        local ____t_result_7
        local ____t_6 = __t
        local ____t_result_5
        if __t(window.document.fullscreenElement) then
            ____t_result_5 = window.document.fullscreenElement
        else
            ____t_result_5 = window.document:getElementById("gameShell")
        end
        __O[2837] = ____t_result_5
        if ____t_6(____t_result_5) then
            ____t_result_7 = __O[2837]
        else
            ____t_result_7 = window.document.body
        end
        ____t_result_7:append(__L1.screen)
        local headerActions = window.document:createElement("div")
        headerActions.className = "arena-header-actions"
        local sound = window.document:createElement("button")
        sound.id = "arenaSoundBtn"
        sound.className = "arena-small-button"
        sound.type = "button"
        sound.onclick = function()
            local ____opt_8 = window.document:getElementById("soundBtn")
            if ____opt_8 ~= nil then
                ____opt_8:click()
            end
            __L1:updateSoundButton()
        end
        headerActions:append(
            sound,
            __L1["$"](__L1, "arenaClose")
        )
        __L1.screen:querySelector(".arena-header"):append(headerActions)
        __L1:updateSoundButton()
        local rule = window.document:createElement("p")
        rule.className = "arena-lobby-rule"
        rule.textContent = "3 VIDAS · 3 PULOS · ↑+FÍSICO NO AR RECUPERA · DANO EMPURRA MAIS · COMBO APÓS 3 ACERTOS FÍSICOS"
        __L1.screen:querySelector(".arena-intro"):append(rule)
        local countdown = window.document:createElement("div")
        countdown.id = "arenaCountdown"
        countdown.className = "arena-countdown"
        countdown.hidden = true
        countdown:setAttribute("role", "status")
        countdown:setAttribute("aria-live", "polite")
        countdown.innerHTML = "<strong class=\"arena-countdown-number\"></strong><span class=\"arena-countdown-label\"></span>"
        __L1.screen:querySelector(".arena-canvas-wrap"):append(countdown)
        local hud = window.document:createElement("div")
        hud.id = "arenaHUD"
        hud.className = "arena-hud-overlay"
        local spectator = window.document:createElement("div")
        spectator.id = "arenaSpectator"
        spectator.className = "arena-spectator-banner"
        spectator.hidden = true
        spectator.textContent = "VOCÊ ESTÁ ASSISTINDO · A RESENHA CONTINUA"
        local comboReady = window.document:createElement("div")
        comboReady.id = "arenaComboReady"
        comboReady.className = "arena-combo-ready"
        comboReady.hidden = true
        __L1.screen:querySelector(".arena-canvas-wrap"):append(hud, spectator, comboReady)
        local pad = __L1.screen:querySelector(".arena-pad")
        for ____, dir in __iterar((__arrL({"up", "down"}, 2))) do
            local button = window.document:createElement("button")
            button.type = "button"
            button.dataset.arenaInput = dir
            button:setAttribute("aria-label", dir == "up" and "Direcionar golpe para cima" or "Direcionar golpe para baixo ou descer plataforma")
            pad:append(button)
        end
        for ____, dir in __iterar((__arrL({"left", "right", "up", "down"}, 4))) do
            local button = __L1.screen:querySelector(__add(
                __add("[data-arena-input=\"", dir),
                "\"]"
            ))
            button.textContent = ""
            local arrow = window.document:createElement("span")
            arrow.className = __add("arena-direction-icon ", dir)
            button:append(arrow)
        end
        local paths = {
            attack = "M4 10V7h3V5h3v2h3V5h3v3h3v7h-2v4H7v-3H4z",
            special = "M3 10h11V6l8 6-8 6v-4H3z",
            ultimate = "M13 1 4 14h6l-1 9 11-14h-7z",
            jump = "M12 2 3 11h6v11h6V11h6z",
            dash = "M2 5h9v3H2zm-2 6h8v3H0zm3 6h8v3H3zm11-14 9 9-9 9v-6H9V9h5z",
            emote = "M7 2h10v3H7zm-3 5h16v9h-4v6h-3v-7h-2v7H8v-6H4z"
        }
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({"attack", "FÍSICO"}, 2),
                __arrL({"special", "DISTÂNCIA"}, 2),
                __arrL({"ultimate", "COMBO"}, 2),
                __arrL({"jump", "PULO ×3"}, 2),
                __arrL({"dash", "DASH"}, 2)
            },
            5
        ))) do
            local action = ____value[1]
            local label = ____value[2]
            local button = __L1.screen:querySelector(__add(
                __add("[data-arena-input=\"", action),
                "\"]"
            ))
            button.innerHTML = __add(
                __add(
                    __add(
                        __add(
                            "<svg viewBox=\"0 0 24 24\" aria-hidden=\"true\"><path fill=\"currentColor\" d=\"",
                            __get(paths, action)
                        ),
                        "\"/></svg><span>"
                    ),
                    label
                ),
                "</span>"
            )
            button:setAttribute("aria-label", label)
            if action == "ultimate" then
                button.id = "arenaComboButton"
            end
        end
        local emote = window.document:createElement("button")
        emote.type = "button"
        emote.dataset.arenaInput = "emote"
        emote.className = "arena-emote"
        emote.innerHTML = __add(
            __add("<svg viewBox=\"0 0 24 24\" aria-hidden=\"true\"><path fill=\"currentColor\" d=\"", paths.emote),
            "\"/></svg><span>RESENHA</span>"
        )
        emote:setAttribute("aria-label", "Dançar ou fazer emote")
        __L1.screen:querySelector(".arena-actions"):append(emote)
        local ____L1__24_result_14 = __L1["$"](__L1, "arenaName")
        local ____L1_cleanText_13 = __L1.cleanText
        local ____t_result_12
        local ____t_11 = __t
        local ____temp_10 = window.localStorage:getItem("daroca-arena-name")
        __O[2838] = ____temp_10
        if ____t_11(____temp_10) then
            ____t_result_12 = __O[2838]
        else
            ____t_result_12 = ""
        end
        ____L1__24_result_14.value = ____L1_cleanText_13(__L1, ____t_result_12, 20)
        __L1["$"](__L1, "arenaClose").onclick = __L1.close
        __L1["$"](__L1, "arenaBattleLeave").onclick = function() return __L1:leaveMatch() end
        __L1["$"](__L1, "arenaLeave").onclick = function() return __L1:leaveRoom() end
        __L1["$"](__L1, "arenaCreate").onclick = function() return __L1:connect("create") end
        __L1["$"](__L1, "arenaJoin").onclick = function() return __L1:connect("join") end
        __L1["$"](__L1, "arenaPractice").onclick = __L1.startPractice
        __L1["$"](__L1, "arenaReady").onclick = function()
            __L1.ready = not __t(__L1.ready)
            __L1.lobbyRevision = __L1.lobbyRevision + 1
            __L1:updateLobby()
            __L1:syncNow()
        end
        __L1["$"](__L1, "arenaStart").onclick = __L1.startOnline
        __L1["$"](__L1, "arenaAgain").onclick = function()
            if __t(__L1.practice) then
                __L1:startPractice()
            elseif __t(__L1:isHost()) then
                __L1.world = nil
                __L1.displayWorld = nil
                __L1.pendingStatus = "lobby"
                __L1.ready = false
                __L1.lobbyRevision = __L1.lobbyRevision + 1
                __L1:resetInput()
                __L1:showBattle(false)
                __L1:syncNow()
            else
                __L1:notify("Aguarde quem criou a sala voltar ao salão.")
            end
        end
        __L1["$"](__L1, "arenaCopyCode").onclick = function()
            return __TS__AsyncAwaiter(function(____awaiter_resolve)
                local ____try = __TS__AsyncAwaiter(function()
                    local ____self_19 = window.navigator.clipboard
                    local ____self_19_writeText_20 = ____self_19.writeText
                    local ____t_result_18
                    local ____t_17 = __t
                    local ____opt_15 = __L1.room
                    if ____opt_15 ~= nil then
                        ____opt_15 = ____opt_15.code
                    end
                    __O[2839] = ____opt_15
                    if ____t_17(____opt_15) then
                        ____t_result_18 = __O[2839]
                    else
                        ____t_result_18 = ""
                    end
                    __TS__Await(____self_19_writeText_20(____self_19, ____t_result_18))
                    __L1:notify("Código copiado. Mande para a turma!")
                end)
                ____try = ____try.catch(
                    ____try,
                    function(____)
                        return __TS__AsyncAwaiter(function()
                            local ____L1_notify_26 = __L1.notify
                            local ____add_25 = __add
                            local ____t_result_24
                            local ____t_23 = __t
                            local ____opt_21 = __L1.room
                            if ____opt_21 ~= nil then
                                ____opt_21 = ____opt_21.code
                            end
                            __O[2840] = ____opt_21
                            if ____t_23(____opt_21) then
                                ____t_result_24 = __O[2840]
                            else
                                ____t_result_24 = ""
                            end
                            ____L1_notify_26(
                                __L1,
                                ____add_25("Código da sala: ", ____t_result_24)
                            )
                        end)
                    end
                )
                __TS__Await(____try)
            end)
        end
        __L1["$"](__L1, "arenaCode").inputMode = "text"
        __L1["$"](__L1, "arenaCode").placeholder = "ROCA67"
        __L1["$"](__L1, "arenaCode").autocapitalize = "characters"
        __L1["$"](__L1, "arenaCode"):addEventListener(
            "input",
            function(____, e)
                e.target.value = __call(
                    __re_replace(
                        __call(e.target.value, "toUpperCase"),
                        __re("[^A-Z0-9]", "g"),
                        ""
                    ),
                    "slice",
                    0,
                    6
                )
            end
        )
        __L1["$"](__L1, "arenaRosterCount").textContent = __add(
            __len(__L1:roster()),
            " PERSONAGENS"
        )
        for ____, character in __iterar((__L1:roster())) do
            local button = window.document:createElement("button")
            button.type = "button"
            button.className = "arena-roster-card"
            button.dataset.fighter = character.id
            button:setAttribute(
                "aria-label",
                __add("Jogar com ", character.name)
            )
            button.style:setProperty("--fighter", character.color)
            local canvas = window.document:createElement("canvas")
            canvas.width = 88
            canvas.height = 80
            canvas:setAttribute("aria-hidden", "true")
            local name = window.document:createElement("span")
            name.textContent = character.name
            button:append(canvas, name)
            button.onclick = function() return __L1:select(character.id) end
            __L1["$"](__L1, "arenaRoster"):append(button)
            __L1:drawPortrait(canvas, character.id, 0, 0.9)
        end
        local ____t_29 = __t
        local ____opt_27 = window.ArenaControls
        if ____opt_27 ~= nil then
            ____opt_27 = ____opt_27.mount
        end
        if ____t_29(____opt_27) then
            __L1.controls = window.ArenaControls:mount({
                screen = __L1.screen,
                wrap = __L1.screen:querySelector(".arena-canvas-wrap"),
                getState = function()
                    local ____temp_34 = __L1:playing()
                    local ____L1_practice_35 = __L1.practice
                    local ____temp_36 = not not __t(__L1.world)
                    local ____temp_33 = not not __t(__L1.world)
                    if ____temp_33 then
                        local ____le_32 = __le
                        local ____opt_30 = __call(
                            __L1.world.players,
                            "find",
                            function(____, p) return p.id == __L1:localId() end
                        )
                        if ____opt_30 ~= nil then
                            ____opt_30 = ____opt_30.stocks
                        end
                        ____temp_33 = ____le_32(____opt_30, 0)
                    end
                    return {playing = ____temp_34, practice = ____L1_practice_35, hasWorld = ____temp_36, eliminated = ____temp_33}
                end,
                onMove = function(____, x, y)
                    __L1.joystickInput = {x = x, y = y}
                    __L1:pumpInput()
                    __L1:syncNow()
                end,
                onPress = function(____, action, id)
                    if not __t(__L1:playing()) then
                        return
                    end
                    __call(__L1.heldPointers, "set", id, action)
                    __L1:pumpInput()
                    __L1:trigger(action)
                    __L1:syncNow()
                end,
                onRelease = function(____, action, id)
                    __call(__L1.heldPointers, "delete", id)
                    __L1:pumpInput()
                    __L1:syncNow()
                end,
                onEditing = function()
                    __L1:resetInput()
                    __L1.lastFrame = window.performance:now()
                    __L1.accumulator = 0
                end
            })
        else
            for ____, button in __iterar((__L1.screen:querySelectorAll("[data-arena-input]"))) do
                button:addEventListener(
                    "pointerdown",
                    function(____, e)
                        if not __t(__L1:playing()) then
                            return
                        end
                        e:preventDefault()
                        do
                            pcall(function()
                                local ____opt_37 = button.setPointerCapture
                                if ____opt_37 ~= nil then
                                    ____opt_37(button, e.pointerId)
                                end
                            end)
                        end
                        __call(__L1.heldPointers, "set", e.pointerId, button.dataset.arenaInput)
                        __call(button.classList, "add", "pressed")
                        __L1:pumpInput()
                        __L1:trigger(button.dataset.arenaInput)
                        __L1:syncNow()
                    end
                )
                local function release(____, e)
                    __call(__L1.heldPointers, "delete", e.pointerId)
                    button.classList:remove("pressed")
                    __L1:pumpInput()
                    __L1:syncNow()
                end
                button:addEventListener("pointerup", release)
                button:addEventListener("pointercancel", release)
                button:addEventListener("lostpointercapture", release)
            end
        end
        __L1:select(__L1.selected)
    end
    __L1.updateSoundButton = function(self)
        local button = __L1["$"](__L1, "arenaSoundBtn")
        if not __t(button) then
            return
        end
        local ____opt_41 = window.GameMusic
        if ____opt_41 ~= nil then
            ____opt_41 = ____opt_41.getStatus
        end
        local ____opt_result_43
        if ____opt_41 ~= nil then
            ____opt_result_43 = ____opt_41(____opt_41).enabled
        end
        local ____opt_result_43_46 = ____opt_result_43
        if ____opt_result_43_46 == nil then
            local ____opt_44 = window.document:getElementById("soundBtn")
            ____opt_result_43_46 = (____opt_44 and ____opt_44:getAttribute("aria-pressed")) == "true"
        end
        local on = ____opt_result_43_46
        button.textContent = __t(on) and "SOM LIGADO" or "LIGAR SOM"
        button:setAttribute(
            "aria-pressed",
            tostring(not not __t(on))
        )
        button.title = "Músicas e efeitos da arena"
    end
    __L1.drawPortrait = function(self, canvas, id, t, scale)
        if scale == nil then
            scale = 1.8
        end
        local c = canvas:getContext("2d")
        local k = __L1:kit(id)
        if not __t(k) then
            return
        end
        c.imageSmoothingEnabled = false
        c:clearRect(0, 0, canvas.width, canvas.height)
        c.fillStyle = __add(k.color, "22")
        c:fillRect(0, 0, canvas.width, canvas.height)
        c.fillStyle = "#203c3b"
        c:fillRect(0, canvas.height - 12, canvas.width, 12)
        local height = id == "giant" and 200 or (__t(id == "kaique" or id == "ollyan") and 112 or (id == "igor" and 90 or 80))
        local width = id == "giant" and 240 or (id == "ollyan" and 95 or (id == "igor" and 76 or 55))
        local fit = math.min(scale, (canvas.height - 18) / height, (canvas.width - 10) / width)
        local ____t_49 = __t
        local ____opt_47 = window.Art
        if ____opt_47 ~= nil then
            ____opt_47 = ____opt_47.drawCharacter
        end
        if ____t_49(____opt_47) then
            window.Art:drawCharacter(
                c,
                id,
                canvas.width / 2,
                canvas.height - 10,
                {scale = fit, frame = t, bossPhase = id == "nikolas" and 1 or nil, moving = false}
            )
        else
            c.fillStyle = k.color
            c:fillRect(canvas.width / 2 - 12, canvas.height - 53, 24, 40)
        end
    end
    __L1.select = function(self, id)
        if __t(__L1:playing()) then
            return
        end
        local ____t_result_53
        local ____t_52 = __t
        local ____opt_50 = __L1:kit(id)
        if ____opt_50 ~= nil then
            ____opt_50 = ____opt_50.id
        end
        __O[2842] = ____opt_50
        if ____t_52(____opt_50) then
            ____t_result_53 = __O[2842]
        else
            ____t_result_53 = "daroca"
        end
        __L1.selected = ____t_result_53
        __L1.lobbyRevision = __L1.lobbyRevision + 1
        local k = __L1:kit(__L1.selected)
        if not __t(k) then
            return
        end
        local ____callq_56 = __callq
        local ____opt_54 = __L1.screen
        if ____opt_54 ~= nil then
            ____opt_54 = ____opt_54:querySelectorAll("[data-fighter]")
        end
        ____callq_56(
            ____opt_54,
            "forEach",
            function(____, b)
                local on = b.dataset.fighter == __L1.selected
                b.classList:toggle("selected", on)
                b:setAttribute(
                    "aria-pressed",
                    tostring(on)
                )
            end
        )
        __L1["$"](__L1, "arenaFighterTitle").textContent = k.title
        __L1["$"](__L1, "arenaFighterName").textContent = k.name
        __L1["$"](__L1, "arenaFighterQuote").textContent = __add(
            __add("“", k.quote),
            "”"
        )
        __L1["$"](__L1, "arenaFighter").style:setProperty("--fighter", k.color)
        __L1["$"](__L1, "arenaKit"):replaceChildren()
        for ____, ____value in __iterar((__arrL(
            {
                __arrL(
                    {
                        "FÍSICO",
                        k.basic,
                        __L1:keyLabel("paper", "J")
                    },
                    3
                ),
                __arrL(
                    {
                        "DISTÂNCIA",
                        k.special,
                        __L1:keyLabel("fart", "K")
                    },
                    3
                ),
                __arrL(
                    {
                        "COMBO",
                        k.ultimate,
                        __L1:keyLabel("reeis", "R")
                    },
                    3
                )
            },
            3
        ))) do
            local label = ____value[1]
            local value = ____value[2]
            local key = ____value[3]
            local item = window.document:createElement("div")
            local dt = window.document:createElement("dt")
            dt.textContent = __add(
                __add(label, " · "),
                key
            )
            local dd = window.document:createElement("dd")
            dd.textContent = value
            item:append(dt, dd)
            __L1["$"](__L1, "arenaKit"):append(item)
        end
        __L1:drawPortrait(
            __L1["$"](__L1, "arenaPortrait"),
            __L1.selected,
            window.performance:now() / 1000
        )
        local ____t_60 = __t
        local ____t_result_59
        if __t(__L1.credentials) then
            local ____opt_57 = __L1.room
            if ____opt_57 ~= nil then
                ____opt_57 = ____opt_57.status
            end
            ____t_result_59 = ____opt_57 == "lobby"
        else
            ____t_result_59 = __L1.credentials
        end
        if ____t_60(____t_result_59) then
            __L1.ready = false
            __L1:syncNow()
        end
    end
    __L1.updateLobby = function(self)
        if not __t(__L1.screen) then
            return
        end
        local connected = not not __t(__L1.credentials)
        __L1.screen.classList:toggle("has-room", connected)
        __L1["$"](__L1, "arenaRoom").hidden = not __t(connected)
        for ____, id in __iterar((__arrL({
            "arenaCreate",
            "arenaJoin",
            "arenaPractice",
            "arenaName",
            "arenaCode"
        }, 5))) do
            local ____L1__24_result_62 = __L1["$"](__L1, id)
            local ____t_result_61
            if __t(__L1.busy) then
                ____t_result_61 = __L1.busy
            else
                ____t_result_61 = connected
            end
            ____L1__24_result_62.disabled = ____t_result_61
        end
        if not __t(connected) then
            return
        end
        __L1["$"](__L1, "arenaCopyCode").textContent = __L1.room.code
        __L1["$"](__L1, "arenaSeats"):replaceChildren()
        do
            local i = 0
            while true do
                local ____lt_82 = __lt
                local ____i_81 = i
                local ____t_result_80
                if __t(__L1.room.capacity) then
                    ____t_result_80 = __L1.room.capacity
                else
                    ____t_result_80 = 4
                end
                if not ____lt_82(____i_81, ____t_result_80) then
                    break
                end
                local p = __get(__L1.room.players, i)
                local el = window.document:createElement("div")
                local ____add_66 = __add
                local ____opt_result_65
                if p ~= nil then
                    ____opt_result_65 = p.id
                end
                el.className = ____add_66(
                    "arena-seat",
                    ____opt_result_65 == __L1:localId() and " is-you" or ""
                )
                if __t(p) then
                    local k = __L1:kit(p.character)
                    local dot = window.document:createElement("i")
                    local ____dot_style_72 = dot.style
                    local ____t_result_71
                    local ____t_70 = __t
                    local ____opt_result_69
                    if k ~= nil then
                        ____opt_result_69 = k.color
                    end
                    __O[2843] = ____opt_result_69
                    if ____t_70(____opt_result_69) then
                        ____t_result_71 = __O[2843]
                    else
                        ____t_result_71 = "#d4be89"
                    end
                    ____dot_style_72.background = ____t_result_71
                    local label = window.document:createElement("span")
                    label.textContent = __add(
                        p.name,
                        p.id == __L1:localId() and " · VOCÊ" or ""
                    )
                    local sub = window.document:createElement("small")
                    local ____add_79 = __add
                    local ____add_78 = __add
                    local ____t_result_77
                    local ____t_76 = __t
                    local ____opt_result_75
                    if k ~= nil then
                        ____opt_result_75 = k.name
                    end
                    __O[2844] = ____opt_result_75
                    if ____t_76(____opt_result_75) then
                        ____t_result_77 = __O[2844]
                    else
                        ____t_result_77 = p.character
                    end
                    sub.textContent = ____add_79(
                        ____add_78(____t_result_77, " · "),
                        __t(p.ready) and "PRONTO" or (p.id == __L1.room.hostPlayerId and "CRIADOR DA SALA" or "ESCOLHENDO")
                    )
                    el:append(dot, label, sub)
                else
                    el.textContent = "＋ ESPERANDO A TURMA"
                end
                __L1["$"](__L1, "arenaSeats"):append(el)
                i = i + 1
            end
        end
        __L1["$"](__L1, "arenaReady").textContent = __t(__L1.ready) and "✓ PRONTO!" or "ESTOU PRONTO"
        __L1["$"](__L1, "arenaReady").classList:toggle("is-ready", __L1.ready)
        __L1["$"](__L1, "arenaStart").hidden = not __t(__L1:isHost())
        __L1["$"](__L1, "arenaStart").disabled = __lt(
            __len(__L1.room.players),
            2
        ) or not __t(__call(
            __L1.room.players,
            "every",
            function(____, p)
                local ____temp_83
                if p.id == __L1:localId() then
                    ____temp_83 = __L1.ready
                else
                    ____temp_83 = p.ready
                end
                return ____temp_83
            end
        ))
        __L1["$"](__L1, "arenaStart").title = __lt(
            __len(__L1.room.players),
            2
        ) and "Espere pelo menos mais uma pessoa" or "Todos precisam estar prontos"
    end
    __L1.showBattle = function(self, visible)
        local ____opt_86 = __L1.controls
        if ____opt_86 ~= nil then
            ____opt_86 = ____opt_86.closeEditor
        end
        if ____opt_86 ~= nil then
            ____opt_86(____opt_86)
        end
        __L1["$"](__L1, "arenaLobby").hidden = visible
        __L1["$"](__L1, "arenaBattle").hidden = not __t(visible)
        __L1["$"](__L1, "arenaResult").hidden = true
        __L1.screen.classList:toggle("in-battle", visible)
        if __t(visible) then
            local ____L1__24_result_93 = __L1["$"](__L1, "arenaMatchCode")
            local ____t_result_92
            if __t(__L1.practice) then
                ____t_result_92 = "TREINO LOCAL · BOTS"
            else
                local ____add_91 = __add
                local ____add_90 = __add
                local ____opt_88 = __L1.room
                if ____opt_88 ~= nil then
                    ____opt_88 = ____opt_88.code
                end
                ____t_result_92 = ____add_91(
                    ____add_90("SALA ", ____opt_88),
                    " · ONLINE"
                )
            end
            ____L1__24_result_93.textContent = ____t_result_92
            __L1:updateSkillBar()
            window:setTimeout(
                function()
                    local ____opt_94 = __L1["$"](__L1, "arenaCanvas")
                    if ____opt_94 ~= nil then
                        ____opt_94 = ____opt_94:focus()
                    end
                    return ____opt_94
                end,
                0
            )
        end
    end
    __L1.updateSkillBar = function(self)
        local ____L1_kit_103 = __L1.kit
        local ____t_result_102
        local ____t_101 = __t
        local ____callq_100 = __callq
        local ____opt_98 = __L1.world
        if ____opt_98 ~= nil then
            ____opt_98 = ____opt_98.players
        end
        local ____opt_96 = ____callq_100(
            ____opt_98,
            "find",
            function(____, p) return p.id == __L1:localId() end
        )
        if ____opt_96 ~= nil then
            ____opt_96 = ____opt_96.character
        end
        __O[2845] = ____opt_96
        if ____t_101(____opt_96) then
            ____t_result_102 = __O[2845]
        else
            ____t_result_102 = __L1.selected
        end
        local k = ____L1_kit_103(__L1, ____t_result_102)
        if not __t(k) then
            return
        end
        local el = __L1["$"](__L1, "arenaSkillBar")
        el:replaceChildren()
        for ____, ____value in __iterar((__arrL(
            {
                __arrL(
                    {
                        __L1:keyLabel("paper", "J"),
                        k.basic
                    },
                    2
                ),
                __arrL(
                    {
                        __L1:keyLabel("fart", "K"),
                        k.special
                    },
                    2
                ),
                __arrL(
                    {
                        __L1:keyLabel("reeis", "R"),
                        k.ultimate
                    },
                    2
                )
            },
            3
        ))) do
            local label = ____value[1]
            local name = ____value[2]
            local span = window.document:createElement("span")
            local key = window.document:createElement("b")
            key.textContent = label
            span:append(
                key,
                window.document:createTextNode(name)
            )
            el:append(span)
        end
        local hint = __L1.screen:querySelector(".arena-key-hint")
        hint.textContent = __add(
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
                                                                    __L1:keyLabel("left", "A"),
                                                                    " / "
                                                                ),
                                                                __L1:keyLabel("right", "D")
                                                            ),
                                                            ": ANDAR · CIMA/BAIXO: DIREÇÃO DO GOLPE · "
                                                        ),
                                                        __L1:keyLabel("jump", "ESPAÇO")
                                                    ),
                                                    ": PULAR ×2 · "
                                                ),
                                                __L1:keyLabel("paper", "J")
                                            ),
                                            ": FÍSICO · "
                                        ),
                                        __L1:keyLabel("fart", "K")
                                    ),
                                    ": DISTÂNCIA · "
                                ),
                                __L1:keyLabel("dash", "L")
                            ),
                            ": DASH · "
                        ),
                        __L1:keyLabel("reeis", "R")
                    ),
                    ": COMBO · "
                ),
                __L1:keyLabel("taunt", "T")
            ),
            ": RESENHA · ESC: SAIR"
        )
        __L1["$"](__L1, "arenaCanvas"):setAttribute(
            "aria-label",
            __add("Arena de combate. ", hint.textContent)
        )
    end
    __L1.request = function(self, path, options)
        if options == nil then
            options = {}
        end
        return __TS__AsyncAwaiter(function(____awaiter_resolve)
            local ____assign_107 = __assign
            local ____temp_105 = {}
            local ____temp_106 = {["Content-Type"] = "application/json"}
            local ____t_result_104
            if __t(options.headers) then
                ____t_result_104 = options.headers
            else
                ____t_result_104 = {}
            end
            local headers = ____assign_107(____temp_105, ____temp_106, ____t_result_104)
            local ____t_110 = __t
            local ____opt_108 = __L1.credentials
            if ____opt_108 ~= nil then
                ____opt_108 = ____opt_108.token
            end
            if ____t_110(____opt_108) then
                headers.Authorization = __add("Bearer ", __L1.credentials.token)
            end
            local response
            local ____t_116 = __t
            local ____t_result_115
            local ____t_112 = __t
            local ____temp_111 = window.location.protocol == "file:"
            __O[2846] = ____temp_111
            if ____t_112(____temp_111) then
                local ____opt_113 = window.DaRocaNetwork
                if ____opt_113 ~= nil then
                    ____opt_113 = ____opt_113.request
                end
                ____t_result_115 = ____opt_113
            else
                ____t_result_115 = __O[2846]
            end
            if ____t_116(____t_result_115) then
                local ____self_121 = window.DaRocaNetwork
                local ____self_121_request_122 = ____self_121.request
                local ____path_120 = path
                local ____t_result_117
                if __t(options.method) then
                    ____t_result_117 = options.method
                else
                    ____t_result_117 = "POST"
                end
                local ____headers_119 = headers
                local ____temp_118
                if options.body == nil then
                    ____temp_118 = nil
                else
                    ____temp_118 = window.JSON:stringify(options.body)
                end
                response = __TS__Await(____self_121_request_122(____self_121, ____path_120, {method = ____t_result_117, headers = ____headers_119, body = ____temp_118}))
            else
                local controller = __new("AbortController")
                local timer = window:setTimeout(
                    function() return controller:abort() end,
                    25000
                )
                local ____try = __TS__AsyncAwaiter(function()
                    local ____window_129 = window
                    local ____window_fetch_130 = window.fetch
                    local ____add_124 = __add
                    local ____temp_123
                    if window.location.protocol == "file:" then
                        ____temp_123 = __L1.OFFICIAL
                    else
                        ____temp_123 = ""
                    end
                    local ____add_124_result_128 = ____add_124(____temp_123, path)
                    local ____t_result_125
                    if __t(options.method) then
                        ____t_result_125 = options.method
                    else
                        ____t_result_125 = "POST"
                    end
                    local ____headers_127 = headers
                    local ____temp_126
                    if options.body == nil then
                        ____temp_126 = nil
                    else
                        ____temp_126 = window.JSON:stringify(options.body)
                    end
                    response = __TS__Await(____window_fetch_130(____window_129, ____add_124_result_128, {
                        method = ____t_result_125,
                        headers = ____headers_127,
                        body = ____temp_126,
                        signal = controller.signal,
                        cache = "no-store",
                        credentials = "omit"
                    }))
                end)
                ____try = ____try.finally(
                    ____try,
                    function()
                        return __TS__AsyncAwaiter(function()
                            window:clearTimeout(timer)
                        end)
                    end
                )
                __TS__Await(____try)
            end
            local data
            local ____opt_result_133
            if response ~= nil then
                ____opt_result_133 = response.json
            end
            if type(____opt_result_133) == "function" then
                data = __TS__Await(response:json())
            else
                local ____opt_result_136
                if response ~= nil then
                    ____opt_result_136 = response.body
                end
                local ____opt_result_136_140 = ____opt_result_136
                if ____opt_result_136_140 == nil then
                    local ____opt_result_139
                    if response ~= nil then
                        ____opt_result_139 = response.data
                    end
                    ____opt_result_136_140 = ____opt_result_139
                end
                local ____opt_result_136_140_141 = ____opt_result_136_140
                if ____opt_result_136_140_141 == nil then
                    ____opt_result_136_140_141 = response
                end
                data = ____opt_result_136_140_141
                if type(data) == "string" then
                    data = window.JSON:parse(data)
                end
            end
            local ____opt_result_144
            if response ~= nil then
                ____opt_result_144 = response.status
            end
            local ____opt_result_144_145 = ____opt_result_144
            if ____opt_result_144_145 == nil then
                ____opt_result_144_145 = 200
            end
            local status = ____opt_result_144_145
            local ____t_155 = __t
            local ____t_result_154
            local ____t_150 = __t
            local ____opt_result_148
            if response ~= nil then
                ____opt_result_148 = response.ok
            end
            local ____temp_149 = ____opt_result_148 == false or __ge(status, 400)
            __O[2847] = ____temp_149
            if ____t_150(____temp_149) then
                ____t_result_154 = __O[2847]
            else
                local ____opt_result_153
                if data ~= nil then
                    ____opt_result_153 = data.error
                end
                ____t_result_154 = ____opt_result_153
            end
            if ____t_155(____t_result_154) then
                local ____Error_173 = Error
                local ____t_result_172
                local ____t_167 = __t
                local ____t_result_166
                local ____t_162 = __t
                local ____opt_result_160
                if data ~= nil then
                    ____opt_result_160 = data.error
                end
                local ____opt_result_161
                if ____opt_result_160 ~= nil then
                    ____opt_result_161 = ____opt_result_160.message
                end
                __O[2848] = ____opt_result_161
                if ____t_162(____opt_result_161) then
                    ____t_result_166 = __O[2848]
                else
                    local ____opt_result_165
                    if data ~= nil then
                        ____opt_result_165 = data.message
                    end
                    ____t_result_166 = ____opt_result_165
                end
                __O[2849] = ____t_result_166
                if ____t_167(____t_result_166) then
                    ____t_result_172 = __O[2849]
                else
                    local ____temp_171
                    local ____opt_result_170
                    if data ~= nil then
                        ____opt_result_170 = data.error
                    end
                    if type(____opt_result_170) == "string" then
                        ____temp_171 = data.error
                    else
                        ____temp_171 = "Não foi possível conectar à sala."
                    end
                    ____t_result_172 = ____temp_171
                end
                local ____error = __TS__New(____Error_173, ____t_result_172)
                ____error.status = status
                error(____error, 0)
            end
            return ____awaiter_resolve(nil, data)
        end)
    end
    __L1.connect = function(self, mode)
        return __TS__AsyncAwaiter(function(____awaiter_resolve)
            local ____t_175 = __t
            local ____t_result_174
            if __t(__L1.busy) then
                ____t_result_174 = __L1.busy
            else
                ____t_result_174 = __L1.credentials
            end
            if ____t_175(____t_result_174) then
                return ____awaiter_resolve(nil)
            end
            local ____t_result_178
            local ____t_177 = __t
            local ____temp_176 = __L1:cleanText(
                __L1["$"](__L1, "arenaName").value,
                20
            )
            __O[2850] = ____temp_176
            if ____t_177(____temp_176) then
                ____t_result_178 = __O[2850]
            else
                ____t_result_178 = "Da Resenha"
            end
            local name = ____t_result_178
            window.localStorage:setItem("daroca-arena-name", name)
            local code = __L1["$"](__L1, "arenaCode").value
            if __t(mode == "join" and not __re_test(
                __re("^[A-Z0-9]{6}$", ""),
                code
            )) then
                __L1:notify("Digite as seis letras e números da sala do amigo.", true)
                __L1["$"](__L1, "arenaCode"):focus()
                return ____awaiter_resolve(nil)
            end
            __L1.busy = true
            __L1:updateLobby()
            __L1:notify(mode == "create" and "Criando sua sala na nuvem…" or "Entrando na sala da turma…")
            local ____L1_179, ____generation_180 = __L1, "generation"
            local ____L1_generation_181 = ____L1_179[____generation_180] + 1
            ____L1_179[____generation_180] = ____L1_generation_181
            local thisGeneration = ____L1_generation_181
            local ____hasReturned, ____returnValue
            local ____try = __TS__AsyncAwaiter(function()
                local data = __TS__Await(__L1:request(
                    mode == "create" and "/api/arena/rooms" or __add(
                        __add("/api/arena/rooms/", code),
                        "/join"
                    ),
                    {body = {
                        name = name,
                        character = __L1.selected,
                        capacity = 4,
                        mode = "arena",
                        protocol = 3
                    }}
                ))
                if thisGeneration ~= __L1.generation then
                    ____hasReturned = true
                    return
                end
                __L1.credentials = {
                    token = data.token,
                    playerId = data.playerId,
                    isHost = not not __t(data.isHost)
                }
                __L1.room = data.room
                __L1.practice = false
                __L1.ready = false
                __call(__L1.inputs, "clear")
                __L1.stateSeq = 0
                __L1.inputSeq = 0
                __L1.networkFailures = 0
                window.sessionStorage:setItem(
                    "daroca-arena-room",
                    window.JSON:stringify(__assign({}, __L1.credentials, {code = __L1.room.code}))
                )
                __L1:absorb(data)
                __L1:notify(__add(
                    __add("Sala ", __L1.room.code),
                    " aberta. Escolha o personagem e toque em ESTOU PRONTO."
                ))
                __L1:scheduleSync(50)
            end)
            ____try = ____try.catch(
                ____try,
                function(____, e)
                    return __TS__AsyncAwaiter(function()
                        if thisGeneration == __L1.generation then
                            __L1:notify(e.name == "AbortError" and "A conexão demorou. Confira a internet e tente novamente." or e.message, true)
                        end
                    end)
                end
            )
            ____try = ____try.finally(
                ____try,
                function()
                    return __TS__AsyncAwaiter(function()
                        if thisGeneration == __L1.generation then
                            __L1.busy = false
                            __L1:updateLobby()
                        end
                    end)
                end
            )
            __TS__Await(____try)
            if ____hasReturned then
                return ____awaiter_resolve(nil, ____returnValue)
            end
        end)
    end
    __L1.absorb = function(self, data)
        local ____t_186 = __t
        local ____t_185 = __t
        local ____opt_result_184
        if data ~= nil then
            ____opt_result_184 = data.room
        end
        if ____t_186(not ____t_185(____opt_result_184) or not __isArray(data.room.players)) then
            error(
                Error(nil, "A sala respondeu em um formato inválido."),
                0
            )
        end
        __L1.room = data.room
        __L1.credentials.isHost = not not __t(data.isHost)
        local ____iter_198 = __iter
        local ____t_result_197
        if __t(data.inputs) then
            ____t_result_197 = data.inputs
        else
            ____t_result_197 = __arrL({}, 0)
        end
        for ____, item in __TS__Iterator(____iter_198(____t_result_197)) do
            local previous = __call(__L1.inputs, "get", item.playerId)
            local ____t_188 = __t
            local ____t_result_187
            if __t(item.input) then
                ____t_result_187 = not __t(previous) or __gt(item.seq, previous.seq)
            else
                ____t_result_187 = item.input
            end
            if ____t_188(____t_result_187) then
                local ____call_196 = __call
                local ____L1_inputs_194 = __L1.inputs
                local ____item_playerId_195 = item.playerId
                local ____assign_193 = __assign
                local ____temp_191 = {}
                local ____item_input_192 = item.input
                local ____temp_190 = window.performance:now()
                local ____t_result_189
                if __t(data.serverTime) then
                    ____t_result_189 = data.serverTime
                else
                    ____t_result_189 = window.Date:now()
                end
                ____call_196(
                    ____L1_inputs_194,
                    "set",
                    ____item_playerId_195,
                    ____assign_193(
                        ____temp_191,
                        ____item_input_192,
                        {seenAt = ____temp_190 - math.max(0, ____t_result_189 - item.updatedAt)}
                    )
                )
            end
        end
        if __t(not __t(__L1:isHost()) or not __t(__L1.world)) then
            __L1:receiveState(data.state)
        end
        if __t(__L1.restoring) then
            local ____call_200 = __call
            local ____t_result_199
            if __t(data.inputs) then
                ____t_result_199 = data.inputs
            else
                ____t_result_199 = __arrL({}, 0)
            end
            local own = ____call_200(
                ____t_result_199,
                "find",
                function(____, i) return i.playerId == __L1:localId() end
            )
            local ____L1_inputSeq_206 = __L1.inputSeq
            local ____t_result_205
            local ____t_204 = __t
            local ____opt_result_203
            if own ~= nil then
                ____opt_result_203 = own.seq
            end
            __O[2851] = ____opt_result_203
            if ____t_204(____opt_result_203) then
                ____t_result_205 = __O[2851]
            else
                ____t_result_205 = 0
            end
            __L1.inputSeq = math.max(____L1_inputSeq_206, ____t_result_205)
            local ____t_209 = __t
            local ____opt_207 = __call(
                __L1.room.players,
                "find",
                function(____, p) return p.id == __L1:localId() end
            )
            if ____opt_207 ~= nil then
                ____opt_207 = ____opt_207.ready
            end
            __L1.ready = not not ____t_209(____opt_207)
            local ____callq_212 = __callq
            local ____opt_210 = __L1.world
            if ____opt_210 ~= nil then
                ____opt_210 = ____opt_210.players
            end
            local p = ____callq_212(
                ____opt_210,
                "find",
                function(____, p) return p.id == __L1:localId() end
            )
            for ____, action in __iterar((__arrL({
                "attack",
                "special",
                "ultimate",
                "dash",
                "emote",
                "jumpPress"
            }, 6))) do
                local ____set_228 = __set
                local ____L1_input_227 = __L1.input
                local ____get_result_226 = __get(__L1.input, action)
                local ____t_result_225
                local ____t_224 = __t
                local ____t_result_223
                local ____t_218 = __t
                local ____getq_216 = __getq
                local ____opt_result_215
                if p ~= nil then
                    ____opt_result_215 = p.used
                end
                local ____getq_216_result_217 = ____getq_216(____opt_result_215, action)
                __O[2852] = ____getq_216_result_217
                if ____t_218(____getq_216_result_217) then
                    ____t_result_223 = __O[2852]
                else
                    local ____getq_222 = __getq
                    local ____opt_result_221
                    if own ~= nil then
                        ____opt_result_221 = own.input
                    end
                    ____t_result_223 = ____getq_222(____opt_result_221, action)
                end
                __O[2853] = ____t_result_223
                if ____t_224(____t_result_223) then
                    ____t_result_225 = __O[2853]
                else
                    ____t_result_225 = 0
                end
                ____set_228(
                    ____L1_input_227,
                    action,
                    math.max(____get_result_226, ____t_result_225)
                )
            end
            __L1.restoring = false
        end
        local ____t_240 = __t
        local ____t_result_239
        local ____t_236 = __t
        local ____t_result_235
        local ____t_232 = __t
        local ____t_result_231
        local ____t_230 = __t
        local ____temp_229 = __L1.room.status == "lobby"
        __O[2854] = ____temp_229
        if ____t_230(____temp_229) then
            ____t_result_231 = __L1.world
        else
            ____t_result_231 = __O[2854]
        end
        __O[2855] = ____t_result_231
        if ____t_232(____t_result_231) then
            local ____opt_233 = data.state
            if ____opt_233 ~= nil then
                ____opt_233 = ____opt_233.matchId
            end
            ____t_result_235 = ____opt_233 == __L1.world.matchId
        else
            ____t_result_235 = __O[2855]
        end
        __O[2856] = ____t_result_235
        if ____t_236(____t_result_235) then
            local ____opt_237 = data.state
            if ____opt_237 ~= nil then
                ____opt_237 = ____opt_237.phase
            end
            ____t_result_239 = ____opt_237 == "finished"
        else
            ____t_result_239 = __O[2856]
        end
        if ____t_240(____t_result_239) then
            __L1.world = nil
            __L1.displayWorld = nil
            __L1:showBattle(false)
            __L1:resetInput()
        end
        if not __t(__L1.room.hostConnected) then
            __L1:notify("O criador da sala perdeu a conexão. Aguardando o celular voltar…", true)
        elseif __L1.networkFailures > 0 then
            __L1:notify("Conexão recuperada. A resenha continua.")
        end
        __L1:setupNet()
        local ____opt_243 = __L1.net
        if ____opt_243 ~= nil then
            ____opt_243 = ____opt_243.updateRoster
        end
        if ____opt_243 ~= nil then
            ____opt_243(____opt_243, __L1.room.players)
        end
        local ____t_248 = __t
        local ____temp_247 = not __t(__L1:isHost())
        if ____temp_247 then
            local ____opt_245 = __L1.world
            if ____opt_245 ~= nil then
                ____opt_245 = ____opt_245.phase
            end
            ____temp_247 = ____opt_245 == "finished"
        end
        if ____t_248(____temp_247) then
            __L1:showResult()
        end
        __L1:updateLobby()
        __L1.lastSync = window.performance:now()
        __L1.networkFailures = 0
    end
    __L1.receiveState = function(self, incoming)
        if __t(not __t(incoming) or not __t(__L1:validWorld(incoming))) then
            return
        end
        local ____t_250 = __t
        local ____t_result_249
        if __t(__L1.world) then
            ____t_result_249 = __le(incoming.seq, __L1.world.seq)
        else
            ____t_result_249 = __L1.world
        end
        if ____t_250(____t_result_249) then
            return
        end
        local ____opt_251 = __L1.world
        if ____opt_251 ~= nil then
            ____opt_251 = ____opt_251.matchId
        end
        local previousMatch = ____opt_251
        local ____opt_253 = __L1.world
        if ____opt_253 ~= nil then
            ____opt_253 = ____opt_253.phase
        end
        local previousPhase = ____opt_253
        local ____callq_257 = __callq
        local ____opt_255 = __L1.world
        if ____opt_255 ~= nil then
            ____opt_255 = ____opt_255.players
        end
        local old = ____callq_257(
            ____opt_255,
            "find",
            function(____, p) return p.id == __L1:localId() end
        )
        __L1.world = incoming
        __L1.stateSeq = math.max(__L1.stateSeq, incoming.seq)
        __L1.snapshotAt = window.performance:now()
        if previousMatch ~= __L1.world.matchId then
            __L1.prediction = nil
            __L1.predictionHistory = __arrL({}, 0)
            __L1.predictionAccumulator = 0
            __L1.remoteFrames = __arrL({}, 0)
            __L1.localAttack = nil
            window:dispatchEvent(__new("CustomEvent", "arena-match", {detail = {matchId = __L1.world.matchId}}))
        end
        if __t(previousPhase == "countdown" and __L1.world.phase == "playing") then
            __L1.goUntil = window.performance:now() + 550
        end
        __call(
            __L1.remoteFrames,
            "push",
            {
                at = __L1.snapshotAt,
                players = __call(
                    __L1.world.players,
                    "map",
                    function(____, p) return {
                        id = p.id,
                        x = p.x,
                        y = p.y,
                        vx = p.vx,
                        vy = p.vy,
                        stocks = p.stocks,
                        respawn = p.respawn
                    } end
                )
            }
        )
        if __len(__L1.remoteFrames) > 12 then
            __call(__L1.remoteFrames, "shift")
        end
        __L1:reconcilePrediction(
            __call(
                __L1.world.players,
                "find",
                function(____, p) return p.id == __L1:localId() end
            ),
            old
        )
        if not __t(__L1["$"](__L1, "arenaLobby").hidden) then
            __L1:showBattle(true)
        end
        local ____t_result_258
        if __t(__L1.world.shotSerial) then
            ____t_result_258 = __L1.world.shotSerial
        else
            ____t_result_258 = 0
        end
        __L1.lastShotCounter = ____t_result_258
        if __L1.world.phase == "finished" then
            __L1:showResult()
        end
    end
    __L1.setupNet = function(self)
        local ____t_262 = __t
        local ____t_result_261
        local ____t_260 = __t
        local ____t_result_259
        if __t(__L1.net) then
            ____t_result_259 = __L1.net
        else
            ____t_result_259 = not __t(__L1.credentials)
        end
        __O[2857] = ____t_result_259
        if ____t_260(____t_result_259) then
            ____t_result_261 = __O[2857]
        else
            ____t_result_261 = not __t(window.ArenaNet)
        end
        if ____t_262(____t_result_261) then
            return
        end
        __L1.net = window.ArenaNet:create({
            code = __L1.room.code,
            roomCode = __L1.room.code,
            playerId = __L1:localId(),
            hostPlayerId = __L1.room.hostPlayerId,
            players = __L1.room.players,
            isHost = __L1:isHost(),
            request = __L1.request,
            onInput = function(____, id, command)
                if __t(__L1:isHost()) then
                    __L1:acceptInput(id, command)
                end
            end,
            onState = function(____, state)
                if not __t(__L1:isHost()) then
                    __L1:receiveState(state)
                end
            end,
            onStatus = function()
            end
        })
    end
    __L1.scheduleSync = function(self, delay)
        if delay == nil then
            delay = 180
        end
        window:clearTimeout(__L1.pollTimer)
        local ____t_264 = __t
        local ____t_result_263
        if __t(__L1.opened) then
            ____t_result_263 = __L1.credentials
        else
            ____t_result_263 = __L1.opened
        end
        if ____t_264(____t_result_263) then
            __L1.pollTimer = window:setTimeout(
                __L1.sync,
                math.max(
                    delay,
                    120 - (window.performance:now() - __L1.lastRequestAt)
                )
            )
        end
    end
    __L1.syncNow = function(self)
        local ____t_268 = __t
        local ____t_result_267
        local ____t_266 = __t
        local ____temp_265 = not __t(__L1.credentials)
        __O[2858] = ____temp_265
        if ____t_266(____temp_265) then
            ____t_result_267 = __O[2858]
        else
            ____t_result_267 = __L1.busy
        end
        if ____t_268(____t_result_267) then
            return
        end
        __L1.urgentSync = true
        if not __t(__L1.syncing) then
            __L1:scheduleSync(0)
        end
    end
    __L1.sync = function(self)
        return __TS__AsyncAwaiter(function(____awaiter_resolve)
            if __t(not __t(__L1.opened) or not __t(__L1.credentials)) then
                return ____awaiter_resolve(nil)
            end
            if __t(__L1.syncing) then
                __L1.urgentSync = true
                return ____awaiter_resolve(nil)
            end
            __L1.syncing = true
            __L1.urgentSync = false
            __L1.lastRequestAt = window.performance:now()
            local thisGeneration = __L1.generation
            local ____t_result_274
            if __t(__L1.restoring) then
                ____t_result_274 = {}
            else
                local ____assign_273 = __assign
                local ____temp_272 = {}
                local ____L1_269, ____inputSeq_270 = __L1, "inputSeq"
                local ____L1_inputSeq_271 = ____L1_269[____inputSeq_270] + 1
                ____L1_269[____inputSeq_270] = ____L1_inputSeq_271
                ____t_result_274 = {input = ____assign_273(____temp_272, {seq = ____L1_inputSeq_271}, __L1.input)}
            end
            local body = ____t_result_274
            local sentLobbyRevision = __L1.lobbyRevision
            local ____t_280 = __t
            local ____t_result_279
            local ____t_278 = __t
            local ____temp_277 = not __t(__L1.restoring)
            if ____temp_277 then
                local ____opt_275 = __L1.room
                if ____opt_275 ~= nil then
                    ____opt_275 = ____opt_275.status
                end
                ____temp_277 = ____opt_275 == "lobby"
            end
            __O[2859] = ____temp_277
            if ____t_278(____temp_277) then
                ____t_result_279 = __L1.lobbyRevision ~= __L1.syncedLobbyRevision
            else
                ____t_result_279 = __O[2859]
            end
            if ____t_280(____t_result_279) then
                body.character = __L1.selected
                body.ready = __L1.ready
            end
            local ____t_284 = __t
            local ____t_result_283
            local ____t_282 = __t
            local ____temp_281 = __L1:isHost()
            __O[2860] = ____temp_281
            if ____t_282(____temp_281) then
                ____t_result_283 = __L1.world
            else
                ____t_result_283 = __O[2860]
            end
            if ____t_284(____t_result_283) then
                body.state = __L1:snapshot()
                body.status = __L1.world.phase == "finished" and "finished" or "playing"
            end
            if __t(__L1.pendingStatus) then
                body.status = __L1.pendingStatus
            end
            local sentStatus = __L1.pendingStatus
            local requestWall = window.Date:now()
            local requestClock = window.performance:now()
            local ____hasReturned, ____returnValue
            local ____try = __TS__AsyncAwaiter(function()
                local data = __TS__Await(__L1:request(
                    __add(
                        __add("/api/arena/rooms/", __L1.room.code),
                        "/sync"
                    ),
                    {body = body}
                ))
                if thisGeneration ~= __L1.generation then
                    ____hasReturned = true
                    return
                end
                local ____t_result_285
                if __t(__L1.rttMs) then
                    ____t_result_285 = __L1.rttMs * 0.7 + (window.performance:now() - requestClock) * 0.3
                else
                    ____t_result_285 = window.performance:now() - requestClock
                end
                __L1.rttMs = ____t_result_285
                if __isFiniteN(data.serverTime) then
                    __L1.serverOffset = data.serverTime - (requestWall + window.Date:now()) / 2
                end
                if __t(body.character) then
                    __L1.syncedLobbyRevision = sentLobbyRevision
                end
                if __L1.pendingStatus == sentStatus then
                    __L1.pendingStatus = nil
                end
                __L1:absorb(data)
            end)
            ____try = ____try.catch(
                ____try,
                function(____, e)
                    return __TS__AsyncAwaiter(function()
                        if thisGeneration ~= __L1.generation then
                            ____hasReturned = true
                            return
                        end
                        __L1.networkFailures = __L1.networkFailures + 1
                        local ____t_289 = __t
                        local ____temp_288 = e.status == 409
                        if ____temp_288 then
                            local ____opt_286 = __L1.room
                            if ____opt_286 ~= nil then
                                ____opt_286 = ____opt_286.status
                            end
                            ____temp_288 = ____opt_286 == "lobby"
                        end
                        if ____t_289(____temp_288) then
                            __L1.room.status = "syncing"
                            __L1:notify("A turma começou! Sincronizando a arena…")
                        else
                            __L1:notify(
                                __t(__call(
                                    __arrL({401, 403, 404, 410}, 4),
                                    "includes",
                                    e.status
                                )) and "Essa sala encerrou ou sua entrada expirou. Crie outra resenha." or "Conexão oscilando. Tentando reconectar…",
                                true
                            )
                        end
                        if __t(__call(
                            __arrL({401, 403, 404, 410}, 4),
                            "includes",
                            e.status
                        )) then
                            __L1:resetInput()
                            local ____opt_292 = __L1.net
                            if ____opt_292 ~= nil then
                                ____opt_292 = ____opt_292.close
                            end
                            if ____opt_292 ~= nil then
                                ____opt_292(____opt_292)
                            end
                            __L1.net = nil
                            window.sessionStorage:removeItem("daroca-arena-room")
                            __L1.credentials = nil
                            __L1.room = nil
                            __L1.world = nil
                            __L1:showBattle(false)
                            __L1:updateLobby()
                            ____hasReturned = true
                            return
                        end
                    end)
                end
            )
            ____try = ____try.finally(
                ____try,
                function()
                    return __TS__AsyncAwaiter(function()
                        __L1.syncing = false
                    end)
                end
            )
            __TS__Await(____try)
            if ____hasReturned then
                return ____awaiter_resolve(nil, ____returnValue)
            end
            if thisGeneration == __L1.generation then
                local ____opt_296 = __L1.net
                if ____opt_296 ~= nil then
                    ____opt_296 = ____opt_296.getStatus
                end
                local ____opt_result_298
                if ____opt_296 ~= nil then
                    ____opt_result_298 = ____opt_296(____opt_296)
                end
                local link = ____opt_result_298
                local ____t_303 = __t
                local ____gt_302 = __gt
                local ____opt_result_301
                if link ~= nil then
                    ____opt_result_301 = link.connected
                end
                local cadence = ____t_303(____gt_302(____opt_result_301, 0) and __ge(link.connected, link.total)) and 500 or 180
                __L1:scheduleSync(__t(__L1.urgentSync) and 0 or math.max(
                    0,
                    math.min(
                        cadence * math.max(1, __L1.networkFailures),
                        2500
                    ) - (window.performance:now() - __L1.lastRequestAt)
                ))
            end
        end)
    end
    __L1.leaveRoom = function(self, silent)
        if silent == nil then
            silent = false
        end
        return __TS__AsyncAwaiter(function(____awaiter_resolve)
            local old = __L1.credentials
            local ____opt_304 = __L1.room
            if ____opt_304 ~= nil then
                ____opt_304 = ____opt_304.code
            end
            local code = ____opt_304
            __L1.generation = __L1.generation + 1
            window:clearTimeout(__L1.pollTimer)
            __L1:resetInput()
            local ____opt_308 = __L1.net
            if ____opt_308 ~= nil then
                ____opt_308 = ____opt_308.close
            end
            if ____opt_308 ~= nil then
                ____opt_308(____opt_308)
            end
            __L1.net = nil
            local ____t_311 = __t
            local ____t_result_310
            if __t(old) then
                ____t_result_310 = code
            else
                ____t_result_310 = old
            end
            if ____t_311(____t_result_310) then
                __L1:request(
                    __add(
                        __add("/api/arena/rooms/", code),
                        "/leave"
                    ),
                    {body = {}}
                ):catch(function()
                end)
            end
            window.sessionStorage:removeItem("daroca-arena-room")
            __L1.credentials = nil
            __L1.room = nil
            __L1.world = nil
            __L1.displayWorld = nil
            __L1.practice = false
            __L1.ready = false
            __L1.busy = false
            __L1.pendingStatus = nil
            __L1.restoring = false
            __L1.syncing = false
            __L1.syncedLobbyRevision = -1
            __call(__L1.inputs, "clear")
            if __t(__L1.screen) then
                __L1:showBattle(false)
                __L1:updateLobby()
                if not __t(silent) then
                    __L1:notify("Você saiu da sala. A próxima resenha está logo ali.")
                end
            end
        end)
    end
    __L1.leaveMatch = function(self)
        local ____t_315 = __t
        local ____t_result_314
        local ____t_313 = __t
        local ____temp_312 = not __t(__L1.practice)
        __O[2861] = ____temp_312
        if ____t_313(____temp_312) then
            ____t_result_314 = __L1:playing()
        else
            ____t_result_314 = __O[2861]
        end
        if ____t_315(____t_result_314) then
            if not __t(window:confirm("Sair da partida e da sala online?")) then
                return
            end
        end
        __L1:leaveRoom()
    end
    __L1.startPractice = function(self)
        __L1:leaveRoom(true)
        __L1.practice = true
        local ____t_result_318
        local ____t_317 = __t
        local ____temp_316 = __L1:cleanText(
            __L1["$"](__L1, "arenaName").value,
            20
        )
        __O[2862] = ____temp_316
        if ____t_317(____temp_316) then
            ____t_result_318 = __O[2862]
        else
            ____t_result_318 = "Você"
        end
        local name = ____t_result_318
        local others = __call(
            __L1:roster(),
            "filter",
            function(____, k) return k.id ~= __L1.selected end
        )
        local offset = math.floor(math.random() * __len(others))
        local players = __arrL(
            {{
                id = __L1:localId(),
                name = name,
                character = __L1.selected
            }},
            1
        )
        do
            local i = 0
            while i < 3 do
                __call(
                    players,
                    "push",
                    {
                        id = __add("bot-", i),
                        name = __get(
                            __arrL({"Bot da Roça", "Bot da Resenha", "Bot do Caos"}, 3),
                            i
                        ),
                        character = __get(
                            others,
                            __mod(
                                offset + i * 7,
                                __len(others)
                            )
                        ).id
                    }
                )
                i = i + 1
            end
        end
        __L1:makeWorld(players)
        __L1:showBattle(true)
        __L1:notify("TREINO LOCAL: você contra três bots. Os poderes são os mesmos da arena online.")
    end
    __L1.startOnline = function(self)
        local ____t_326 = __t
        local ____t_result_325
        local ____t_323 = __t
        local ____t_321 = __t
        local ____opt_319 = __L1.credentials
        if ____opt_319 ~= nil then
            ____opt_319 = ____opt_319.isHost
        end
        local ____temp_322 = not ____t_321(____opt_319) or __lt(
            __len(__L1.room.players),
            2
        )
        __O[2863] = ____temp_322
        if ____t_323(____temp_322) then
            ____t_result_325 = __O[2863]
        else
            ____t_result_325 = not __t(__call(
                __L1.room.players,
                "every",
                function(____, p)
                    local ____temp_324
                    if p.id == __L1:localId() then
                        ____temp_324 = __L1.ready
                    else
                        ____temp_324 = p.ready
                    end
                    return ____temp_324
                end
            ))
        end
        if ____t_326(____t_result_325) then
            __L1:notify("Espere a turma entrar e todos ficarem prontos.", true)
            return
        end
        __L1:makeWorld(__L1.room.players)
        __L1.pendingStatus = "playing"
        __L1:showBattle(true)
        __L1:notify("A arena está aberta! Boa resenha.")
        __L1:syncNow()
    end
    __L1.fighter = function(self, p, i, count)
        local k = __L1:kit(p.character)
        return window.ArenaMotion:create({
            id = p.id,
            name = p.name,
            character = k.id,
            x = 350 + i * (580 / (count - 1)),
            y = 470,
            vx = 0,
            vy = 0,
            facing = __t(__mod(i, 2)) and -1 or 1,
            ground = true,
            stocks = 3,
            damage = 0,
            energy = 0,
            comboHits = 0,
            cd = 0,
            skillCD = 0,
            dashCD = 0,
            dashTime = 0,
            inv = 1.8,
            stun = 0,
            slow = 0,
            slowFactor = 0.7,
            transform = 0,
            form = "",
            attackAnim = 0,
            attackProgress = 0,
            attackType = "physical",
            attackDirection = "neutral",
            attackShape = "fist",
            hit = 0,
            quote = 2.2,
            used = __TS__ObjectFromEntries(__call(
                __L1.actions,
                "map",
                function(____, a) return __arrL({a, 0}, 2) end
            )),
            jumps = 0,
            kills = 0,
            dealt = 0,
            botNext = 0,
            respawn = 0,
            eliminated = false,
            emote = 0,
            emoteKind = "dance",
            dropThrough = 0,
            attackState = nil,
            ackInput = 0
        })
    end
    __L1.makeWorld = function(self, players)
        __L1:resetInput()
        local ____L1_VERSION_338 = __L1.VERSION
        local ____L1_stateSeq_339 = __L1.stateSeq
        local ____t_result_331
        local ____t_330 = __t
        local ____this_328
        ____this_328 = window.crypto
        local ____opt_327 = ____this_328.randomUUID
        local ____temp_329 = ____opt_327 and ____opt_327(____this_328)
        __O[2864] = ____temp_329
        if ____t_330(____temp_329) then
            ____t_result_331 = __O[2864]
        else
            ____t_result_331 = tostring(window.Date:now())
        end
        __L1.world = {
            v = ____L1_VERSION_338,
            seq = ____L1_stateSeq_339,
            matchId = ____t_result_331,
            phase = "countdown",
            round = 1,
            time = 0,
            remaining = 240,
            startAt = window.Date:now() + __L1.serverOffset + 3600,
            countdown = 3,
            players = __call(
                players,
                "map",
                function(____, p, i)
                    local f = __L1:fighter(
                        p,
                        i,
                        __len(players)
                    )
                    local ____temp_332
                    if p.id == __L1:localId() then
                        ____temp_332 = __L1.input
                    else
                        ____temp_332 = __call(__L1.inputs, "get", p.id)
                    end
                    local commands = ____temp_332
                    for ____, a in __iterar((__L1.actions)) do
                        local ____set_337 = __set
                        local ____f_used_336 = f.used
                        local ____t_result_335
                        local ____t_334 = __t
                        local ____getq_result_333 = __getq(commands, a)
                        __O[2865] = ____getq_result_333
                        if ____t_334(____getq_result_333) then
                            ____t_result_335 = __O[2865]
                        else
                            ____t_result_335 = 0
                        end
                        ____set_337(____f_used_336, a, ____t_result_335)
                    end
                    return f
                end
            ),
            shots = __arrL({}, 0),
            attacks = __arrL({}, 0),
            queue = __arrL({}, 0),
            events = __arrL({}, 0),
            zones = __arrL({}, 0),
            winner = nil,
            shotSerial = 0,
            eventSerial = 0,
            scene = __L1.scene,
            platforms = __L1.STAGE,
            camera = __assign({}, __L1.camera)
        }
        __L1.displayWorld = __TS__New(Map)
        __L1.accumulator = 0
        __L1.effectFrames = __arrL({}, 0)
        __L1.lastFrame = window.performance:now()
        __L1.snapshotAt = window.performance:now()
        __L1.lastEventMatch = __L1.world.matchId
        __L1.lastEventId = 0
        __L1.prediction = nil
        __L1.predictionHistory = __arrL({}, 0)
        __L1.predictionAccumulator = 0
        __L1.remoteFrames = __arrL({}, 0)
        __L1.localAttack = nil
        __L1.goUntil = 0
        window:dispatchEvent(__new("CustomEvent", "arena-match", {detail = {matchId = __L1.world.matchId}}))
    end
    __L1.snapshot = function(self)
        local ____assign_345 = __assign
        local ____temp_343 = {}
        local ____L1_world_344 = __L1.world
        local ____L1_340, ____stateSeq_341 = __L1, "stateSeq"
        local ____L1_stateSeq_342 = ____L1_340[____stateSeq_341] + 1
        ____L1_340[____stateSeq_341] = ____L1_stateSeq_342
        local s = ____assign_345(
            ____temp_343,
            ____L1_world_344,
            {
                seq = ____L1_stateSeq_342,
                serverTime = window.Date:now() + __L1.serverOffset
            }
        )
        s.players = __call(
            __L1.world.players,
            "map",
            function(____, p)
                local copy = __assign({}, p)
                __TS__Delete(copy, "botNext")
                return copy
            end
        )
        s.shots = __call(
            __call(__L1.world.shots, "slice", -36),
            "map",
            function(____, s) return __assign({}, s) end
        )
        s.attacks = __call(
            __call(__L1.world.attacks, "slice", -12),
            "map",
            function(____, s) return __assign({}, s) end
        )
        s.queue = __call(
            __call(__L1.world.queue, "slice", -16),
            "map",
            function(____, s) return __assign({}, s) end
        )
        s.events = __call(
            __call(__L1.world.events, "slice", -12),
            "map",
            function(____, s) return __assign({}, s) end
        )
        return s
    end
    __L1.validWorld = function(self, s)
        local ____t_result_398
        local ____t_397 = __t
        local ____t_result_396
        local ____t_395 = __t
        local ____t_result_394
        local ____t_393 = __t
        local ____t_result_392
        local ____t_391 = __t
        local ____t_result_390
        local ____t_386 = __t
        local ____t_result_385
        local ____t_384 = __t
        local ____t_result_383
        local ____t_382 = __t
        local ____t_result_381
        local ____t_363 = __t
        local ____t_result_362
        local ____t_361 = __t
        local ____t_result_360
        local ____t_359 = __t
        local ____t_result_358
        local ____t_357 = __t
        local ____t_result_356
        local ____t_355 = __t
        local ____t_result_354
        local ____t_353 = __t
        local ____t_result_352
        local ____t_351 = __t
        local ____t_result_350
        local ____t_349 = __t
        local ____t_result_348
        local ____t_347 = __t
        local ____t_result_346
        if __t(s) then
            ____t_result_346 = s.v == __L1.VERSION
        else
            ____t_result_346 = s
        end
        __O[2866] = ____t_result_346
        if ____t_347(____t_result_346) then
            ____t_result_348 = __call(
                __arrL({"countdown", "playing", "finished"}, 3),
                "includes",
                s.phase
            )
        else
            ____t_result_348 = __O[2866]
        end
        __O[2867] = ____t_result_348
        if ____t_349(____t_result_348) then
            ____t_result_350 = s.phase ~= "countdown" or __isFiniteN(s.startAt)
        else
            ____t_result_350 = __O[2867]
        end
        __O[2868] = ____t_result_350
        if ____t_351(____t_result_350) then
            ____t_result_352 = type(s.matchId) == "string"
        else
            ____t_result_352 = __O[2868]
        end
        __O[2869] = ____t_result_352
        if ____t_353(____t_result_352) then
            ____t_result_354 = __isFiniteN(s.time)
        else
            ____t_result_354 = __O[2869]
        end
        __O[2870] = ____t_result_354
        if ____t_355(____t_result_354) then
            ____t_result_356 = __isFiniteN(s.remaining)
        else
            ____t_result_356 = __O[2870]
        end
        __O[2871] = ____t_result_356
        if ____t_357(____t_result_356) then
            ____t_result_358 = __isArray(s.players)
        else
            ____t_result_358 = __O[2871]
        end
        __O[2872] = ____t_result_358
        if ____t_359(____t_result_358) then
            ____t_result_360 = __ge(
                __len(s.players),
                2
            )
        else
            ____t_result_360 = __O[2872]
        end
        __O[2873] = ____t_result_360
        if ____t_361(____t_result_360) then
            ____t_result_362 = __le(
                __len(s.players),
                4
            )
        else
            ____t_result_362 = __O[2873]
        end
        __O[2881] = ____t_result_362
        if ____t_363(____t_result_362) then
            ____t_result_381 = __call(
                s.players,
                "every",
                function(____, p)
                    local ____t_result_380
                    local ____t_379 = __t
                    local ____t_result_378
                    local ____t_377 = __t
                    local ____t_result_376
                    local ____t_375 = __t
                    local ____t_result_374
                    local ____t_373 = __t
                    local ____t_result_372
                    local ____t_371 = __t
                    local ____t_result_370
                    local ____t_369 = __t
                    local ____t_result_368
                    local ____t_367 = __t
                    local ____t_result_366
                    if __t(p) then
                        local ____opt_364 = __L1:kit(p.character)
                        if ____opt_364 ~= nil then
                            ____opt_364 = ____opt_364.id
                        end
                        ____t_result_366 = ____opt_364 == p.character
                    else
                        ____t_result_366 = p
                    end
                    __O[2874] = ____t_result_366
                    if ____t_367(____t_result_366) then
                        ____t_result_368 = type(p.id) == "string"
                    else
                        ____t_result_368 = __O[2874]
                    end
                    __O[2875] = ____t_result_368
                    if ____t_369(____t_result_368) then
                        ____t_result_370 = type(p.name) == "string"
                    else
                        ____t_result_370 = __O[2875]
                    end
                    __O[2876] = ____t_result_370
                    if ____t_371(____t_result_370) then
                        ____t_result_372 = __call(
                            __arrL({
                                "x",
                                "y",
                                "vx",
                                "vy",
                                "stocks",
                                "damage",
                                "comboHits",
                                "energy",
                                "skillCD",
                                "dashCD",
                                "inv",
                                "respawn"
                            }, 12),
                            "every",
                            function(____, k) return __isFiniteN(__get(p, k)) end
                        )
                    else
                        ____t_result_372 = __O[2876]
                    end
                    __O[2877] = ____t_result_372
                    if ____t_373(____t_result_372) then
                        ____t_result_374 = math.abs(p.x) < 10000
                    else
                        ____t_result_374 = __O[2877]
                    end
                    __O[2878] = ____t_result_374
                    if ____t_375(____t_result_374) then
                        ____t_result_376 = math.abs(p.y) < 10000
                    else
                        ____t_result_376 = __O[2878]
                    end
                    __O[2879] = ____t_result_376
                    if ____t_377(____t_result_376) then
                        ____t_result_378 = __ge(p.stocks, 0)
                    else
                        ____t_result_378 = __O[2879]
                    end
                    __O[2880] = ____t_result_378
                    if ____t_379(____t_result_378) then
                        ____t_result_380 = __le(p.stocks, 3)
                    else
                        ____t_result_380 = __O[2880]
                    end
                    return ____t_result_380
                end
            )
        else
            ____t_result_381 = __O[2881]
        end
        __O[2882] = ____t_result_381
        if ____t_382(____t_result_381) then
            ____t_result_383 = __isArray(s.shots)
        else
            ____t_result_383 = __O[2882]
        end
        __O[2883] = ____t_result_383
        if ____t_384(____t_result_383) then
            ____t_result_385 = __le(
                __len(s.shots),
                36
            )
        else
            ____t_result_385 = __O[2883]
        end
        __O[2885] = ____t_result_385
        if ____t_386(____t_result_385) then
            ____t_result_390 = __call(
                s.shots,
                "every",
                function(____, p)
                    local ____t_result_389
                    local ____t_388 = __t
                    local ____t_result_387
                    if __t(p) then
                        ____t_result_387 = __call(
                            __arrL({
                                "x",
                                "y",
                                "vx",
                                "vy",
                                "r",
                                "life"
                            }, 6),
                            "every",
                            function(____, k) return __isFiniteN(__get(p, k)) end
                        )
                    else
                        ____t_result_387 = p
                    end
                    __O[2884] = ____t_result_387
                    if ____t_388(____t_result_387) then
                        ____t_result_389 = type(p.type) == "string"
                    else
                        ____t_result_389 = __O[2884]
                    end
                    return ____t_result_389
                end
            )
        else
            ____t_result_390 = __O[2885]
        end
        __O[2886] = ____t_result_390
        if ____t_391(____t_result_390) then
            ____t_result_392 = __isArray(s.attacks)
        else
            ____t_result_392 = __O[2886]
        end
        __O[2887] = ____t_result_392
        if ____t_393(____t_result_392) then
            ____t_result_394 = __le(
                __len(s.attacks),
                12
            )
        else
            ____t_result_394 = __O[2887]
        end
        __O[2888] = ____t_result_394
        if ____t_395(____t_result_394) then
            ____t_result_396 = __isArray(s.events)
        else
            ____t_result_396 = __O[2888]
        end
        __O[2889] = ____t_result_396
        if ____t_397(____t_result_396) then
            ____t_result_398 = __le(
                __len(s.events),
                12
            )
        else
            ____t_result_398 = __O[2889]
        end
        return ____t_result_398
    end
    __L1.direction = function(self, i, p)
        local ____t_result_401
        local ____t_400 = __t
        local ____TS__Number_result_399 = __TS__Number(i.aim)
        __O[2890] = ____TS__Number_result_399
        if ____t_400(____TS__Number_result_399) then
            ____t_result_401 = __O[2890]
        else
            ____t_result_401 = 0
        end
        local a = ____t_result_401
        if a == 3 then
            return "up"
        end
        if a == 4 then
            return "down"
        end
        if __t(a == 1 or a == 2) then
            return "side"
        end
        return "neutral"
    end
    __L1.captureAim = function(self)
        __L1.input.aim = __L1.input.y < -0.35 and 3 or (__L1.input.y > 0.35 and 4 or (__L1.input.x < -0.25 and 1 or (__L1.input.x > 0.25 and 2 or 0)))
    end
    __L1.trigger = function(self, action)
        if not __t(__L1:playing()) then
            return
        end
        if action == "jump" then
            local ____L1_input_402, ____jumpPress_403 = __L1.input, "jumpPress"
            ____L1_input_402[____jumpPress_403] = ____L1_input_402[____jumpPress_403] + 1
            __L1.input.jump = true
        elseif __t(__call(
            __arrL({
                "attack",
                "special",
                "ultimate",
                "dash",
                "emote"
            }, 5),
            "includes",
            action
        )) then
            __L1:captureAim()
            __inc(__L1.input, action, 1, true)
            if action == "attack" then
                __L1.inputAt = window.performance:now()
            end
            local ____t_407 = __t
            local ____t_result_406
            local ____t_405 = __t
            local ____temp_404 = not __t(__L1:isHost())
            __O[2891] = ____temp_404
            if ____t_405(____temp_404) then
                ____t_result_406 = __call(
                    __arrL({"attack", "special", "ultimate"}, 3),
                    "includes",
                    action
                )
            else
                ____t_result_406 = __O[2891]
            end
            if ____t_407(____t_result_406) then
                local p = __call(
                    __L1.world.players,
                    "find",
                    function(____, p) return p.id == __L1:localId() end
                )
                local ____t_409 = __t
                local ____t_result_408
                if __t(p) then
                    ____t_result_408 = action ~= "ultimate" or __ge(p.comboHits, 3)
                else
                    ____t_result_408 = p
                end
                if ____t_409(____t_result_408) then
                    local kind = action == "attack" and "physical" or (action == "special" and "ranged" or "combo")
                    local dir = __L1:direction(__L1.input, p)
                    local d = __L1:descriptor(p, kind, dir)
                    local ____add_415 = __add
                    local ____add_412 = __add
                    local ____t_result_410
                    if __t(d.windup) then
                        ____t_result_410 = d.windup
                    else
                        ____t_result_410 = 0.1
                    end
                    local ____t_result_411
                    if __t(d.duration) then
                        ____t_result_411 = d.duration
                    else
                        ____t_result_411 = 0.15
                    end
                    local ____add_412_result_414 = ____add_412(____t_result_410, ____t_result_411)
                    local ____t_result_413
                    if __t(d.recovery) then
                        ____t_result_413 = d.recovery
                    else
                        ____t_result_413 = 0.2
                    end
                    local total = math.max(
                        0.35,
                        ____add_415(____add_412_result_414, ____t_result_413)
                    )
                    __L1.localAttack = {
                        kind = kind,
                        dir = dir,
                        shape = d.shape,
                        total = total,
                        left = total
                    }
                    local shown = __callq(__L1.displayWorld, "get", p.id)
                    if __t(shown) then
                        shown.localAttackAt = window.performance:now()
                    end
                end
            end
        end
        __L1:syncNow()
    end
    __L1.pumpInput = function(self)
        local ____L1_input_425 = __L1.input
        local ____L1_clamp_424 = __L1.clamp
        local ____t_result_423
        local ____t_422 = __t
        local ____opt_418 = window.ControlSettings
        if ____opt_418 ~= nil then
            ____opt_418 = ____opt_418.getState
        end
        local ____opt_result_420
        if ____opt_418 ~= nil then
            ____opt_result_420 = ____opt_418(____opt_418).sensitivity
        end
        local ____TS__Number_result_421 = __TS__Number(____opt_result_420)
        __O[2892] = ____TS__Number_result_421
        if ____t_422(____TS__Number_result_421) then
            ____t_result_423 = __O[2892]
        else
            ____t_result_423 = 1
        end
        ____L1_input_425.response = ____L1_clamp_424(__L1, ____t_result_423, 0.5, 2)
        local ____t_431 = __t
        local ____opt_428 = __L1.controls
        if ____opt_428 ~= nil then
            ____opt_428 = ____opt_428.isEditing
        end
        local ____opt_result_430
        if ____opt_428 ~= nil then
            ____opt_result_430 = ____opt_428(____opt_428)
        end
        if ____t_431(____opt_result_430) then
            __L1.input.x = 0
            __L1.input.y = 0
            __L1.input.jump = false
            return
        end
        local ____Set_434 = Set
        local ____arr_433 = __arr
        local ____array_432 = __TS__SparseArrayNew(__TS__Spread(__iter(__call(__L1.heldPointers, "values"))))
        __TS__SparseArrayPush(
            ____array_432,
            __TS__Spread(__iter(__L1.held))
        )
        local heldActions = __TS__New(
            ____Set_434,
            ____arr_433(__TS__SparseArraySpread(____array_432))
        )
        __L1.input.x = __L1:clamp(
            (__t(__call(heldActions, "has", "right")) and 1 or 0) - (__t(__call(heldActions, "has", "left")) and 1 or 0) + __L1.joystickInput.x,
            -1,
            1
        )
        __L1.input.y = __L1:clamp(
            (__t(__call(heldActions, "has", "down")) and 1 or 0) - (__t(__call(heldActions, "has", "up")) and 1 or 0) + __L1.joystickInput.y,
            -1,
            1
        )
        __L1.input.jump = __call(heldActions, "has", "jump")
        if __t(__L1.input.x) then
            __L1.aim = __L1.input.x
        end
        local ____t_438 = __t
        local ____t_result_437
        local ____t_436 = __t
        local ____call_result_435 = __call(heldActions, "has", "attack")
        __O[2893] = ____call_result_435
        if ____t_436(____call_result_435) then
            ____t_result_437 = window.performance:now() - __L1.inputAt > 330
        else
            ____t_result_437 = __O[2893]
        end
        if ____t_438(____t_result_437) then
            __L1:captureAim()
            local ____L1_input_439, ____attack_440 = __L1.input, "attack"
            ____L1_input_439[____attack_440] = ____L1_input_439[____attack_440] + 1
            __L1.inputAt = window.performance:now()
            __L1:syncNow()
        end
    end
    __L1.acceptInput = function(self, id, command)
        local ____t_448 = __t
        local ____t_result_447
        local ____t_442 = __t
        local ____temp_441 = not __t(command) or not __t(__isSafeInteger(command.seq))
        __O[2894] = ____temp_441
        if ____t_442(____temp_441) then
            ____t_result_447 = __O[2894]
        else
            local ____t_446 = __t
            local ____callq_445 = __callq
            local ____opt_443 = __L1.room
            if ____opt_443 ~= nil then
                ____opt_443 = ____opt_443.players
            end
            ____t_result_447 = not ____t_446(____callq_445(
                ____opt_443,
                "some",
                function(____, p) return p.id == id end
            ))
        end
        if ____t_448(____t_result_447) then
            return
        end
        local previous = __call(__L1.inputs, "get", id)
        local ____t_450 = __t
        local ____t_result_449
        if __t(previous) then
            ____t_result_449 = __ge(previous.seq, command.seq)
        else
            ____t_result_449 = previous
        end
        if ____t_450(____t_result_449) then
            return
        end
        if __t(not __t(__call(
            __arrL({"x", "y"}, 2),
            "every",
            function(____, k) return __isFiniteN(__get(command, k)) and math.abs(__get(command, k)) <= 1 end
        )) or not __t(__call(
            __L1.actions,
            "every",
            function(____, k)
                local ____t_result_453
                local ____t_452 = __t
                local ____isSafeInteger_result_451 = __isSafeInteger(__get(command, k))
                __O[2895] = ____isSafeInteger_result_451
                if ____t_452(____isSafeInteger_result_451) then
                    ____t_result_453 = __ge(
                        __get(command, k),
                        0
                    )
                else
                    ____t_result_453 = __O[2895]
                end
                return ____t_result_453
            end
        ))) then
            return
        end
        __call(
            __L1.inputs,
            "set",
            id,
            __assign(
                {},
                command,
                {seenAt = window.performance:now()}
            )
        )
    end
    __L1.localInputFor = function(self, p)
        if p.id == __L1:localId() then
            return __assign({}, {seq = __L1.inputSeq}, __L1.input)
        end
        if __t(__L1.practice) then
            return __L1:botInput(p)
        end
        local remote = __call(__L1.inputs, "get", p.id)
        if __t(not __t(remote) or window.performance:now() - __TS__Number(remote.seenAt) > 5000) then
            return __assign({}, {x = 0, y = 0, jump = false, aim = 0}, p.used)
        end
        return remote
    end
    __L1.botInput = function(self, p)
        local alive = __call(
            __L1.world.players,
            "filter",
            function(____, a)
                local ____t_result_456
                local ____t_455 = __t
                local ____temp_454 = __gt(a.stocks, 0) and __le(a.respawn, 0)
                __O[2896] = ____temp_454
                if ____t_455(____temp_454) then
                    ____t_result_456 = a.id ~= p.id
                else
                    ____t_result_456 = __O[2896]
                end
                return ____t_result_456
            end
        )
        local target = __get(
            __call(
                alive,
                "sort",
                function(____, a, b) return __hypot(p.x - a.x, p.y - a.y) - __hypot(p.x - b.x, p.y - b.y) end
            ),
            0
        )
        local base = __assign({}, {x = 0, y = 0, jump = false, aim = 0}, p.used)
        local ____t_result_459
        local ____t_458 = __t
        local ____call_result_457 = __call(
            __L1.STAGE,
            "find",
            function(____, s) return s.main end
        )
        __O[2897] = ____call_result_457
        if ____t_458(____call_result_457) then
            ____t_result_459 = __O[2897]
        else
            ____t_result_459 = __get(__L1.STAGE, 0)
        end
        local main = ____t_result_459
        local left = main.x + 14
        local right = main.x + main.w - 14
        local offstage = __lt(p.x, left) or __gt(p.x, right)
        local below = __gt(p.y, main.y + 6)
        local ____t_464 = __t
        local ____t_result_463
        local ____t_461 = __t
        local ____temp_460 = not __t(p.ground)
        __O[2898] = ____temp_460
        if ____t_461(____temp_460) then
            local ____t_result_462
            if __t(offstage) then
                ____t_result_462 = offstage
            else
                ____t_result_462 = below
            end
            ____t_result_463 = ____t_result_462
        else
            ____t_result_463 = __O[2898]
        end
        if ____t_464(____t_result_463) then
            base.x = __TS__MathSign(main.x + main.w / 2 - p.x)
            local ____t_471 = __t
            local ____t_result_470
            local ____t_466 = __t
            local ____temp_465 = __le(p.stun, 0) and __gt(p.vy, -90)
            __O[2899] = ____temp_465
            if ____t_466(____temp_465) then
                local ____ge_469 = __ge
                local ____L1_world_time_468 = __L1.world.time
                local ____t_result_467
                if __t(p.botJumpAt) then
                    ____t_result_467 = p.botJumpAt
                else
                    ____t_result_467 = 0
                end
                ____t_result_470 = ____ge_469(____L1_world_time_468, ____t_result_467)
            else
                ____t_result_470 = __O[2899]
            end
            if ____t_471(____t_result_470) then
                if __lt(p.jumps, 3) then
                    base.jumpPress = base.jumpPress + 1
                    p.botJumpAt = __L1.world.time + 0.24
                elseif not __t(p.recoveryUsed) then
                    base.y = -1
                    base.aim = 3
                    base.attack = base.attack + 1
                    p.botJumpAt = __L1.world.time + 0.3
                elseif __le(p.dashCD, 0) then
                    base.y = -1
                    base.dash = base.dash + 1
                    p.botJumpAt = __L1.world.time + 0.3
                end
            end
            return base
        end
        if not __t(target) then
            return base
        end
        local dx = target.x - p.x
        local dy = target.y - p.y
        local ____temp_472
        if math.abs(dx) > 54 then
            ____temp_472 = __TS__MathSign(dx)
        else
            ____temp_472 = 0
        end
        local want = ____temp_472
        local ____t_result_475
        local ____t_474 = __t
        local ____temp_473 = want < 0 and __lt(p.x, left + 30)
        __O[2900] = ____temp_473
        if ____t_474(____temp_473) then
            ____t_result_475 = __O[2900]
        else
            ____t_result_475 = want > 0 and __gt(p.x, right - 30)
        end
        local edge = ____t_result_475
        local ____t_477 = __t
        local ____t_result_476
        if __t(edge) then
            ____t_result_476 = p.ground
        else
            ____t_result_476 = edge
        end
        base.x = ____t_477(____t_result_476) and 0 or want
        base.y = dy < -75 and -1 or (dy > 80 and 1 or 0)
        base.aim = __lt(base.y, 0) and 3 or (__gt(base.y, 0) and 4 or (dx < 0 and 1 or 2))
        local ____p_481 = p
        local ____t_result_480
        local ____t_479 = __t
        local ____TS__MathSign_result_478 = __TS__MathSign(dx)
        __O[2901] = ____TS__MathSign_result_478
        if ____t_479(____TS__MathSign_result_478) then
            ____t_result_480 = __O[2901]
        else
            ____t_result_480 = p.facing
        end
        ____p_481.facing = ____t_result_480
        if __ge(__L1.world.time, p.botNext) then
            local ____t_489 = __t
            local ____t_result_488
            local ____t_487 = __t
            local ____t_result_486
            local ____t_485 = __t
            local ____t_result_484
            local ____t_483 = __t
            local ____temp_482 = __gt(target.attackAnim, 0) and math.abs(dx) < 110
            __O[2902] = ____temp_482
            if ____t_483(____temp_482) then
                ____t_result_484 = math.abs(dy) < 90
            else
                ____t_result_484 = __O[2902]
            end
            __O[2903] = ____t_result_484
            if ____t_485(____t_result_484) then
                ____t_result_486 = __le(p.dashCD, 0)
            else
                ____t_result_486 = __O[2903]
            end
            __O[2904] = ____t_result_486
            if ____t_487(____t_result_486) then
                ____t_result_488 = math.random() < 0.3
            else
                ____t_result_488 = __O[2904]
            end
            if ____t_489(____t_result_488) then
                base.dash = base.dash + 1
                local ____t_result_492
                local ____t_491 = __t
                local ____temp_490 = -__TS__MathSign(dx)
                __O[2905] = ____temp_490
                if ____t_491(____temp_490) then
                    ____t_result_492 = __O[2905]
                else
                    ____t_result_492 = 1
                end
                base.x = ____t_result_492
            else
                if __t(dy < -65 and __lt(p.jumps, 2)) then
                    base.jumpPress = base.jumpPress + 1
                end
                if __t(math.abs(dx) < 125 and math.abs(dy) < 100) then
                    base.attack = base.attack + 1
                elseif __le(p.skillCD, 0) then
                    base.special = base.special + 1
                end
                local ____t_496 = __t
                local ____t_result_495
                local ____t_494 = __t
                local ____temp_493 = __ge(p.comboHits, 3) and math.abs(dx) < 135
                __O[2906] = ____temp_493
                if ____t_494(____temp_493) then
                    ____t_result_495 = math.abs(dy) < 100
                else
                    ____t_result_495 = __O[2906]
                end
                if ____t_496(____t_result_495) then
                    base.ultimate = base.ultimate + 1
                end
            end
            p.botNext = __L1.world.time + 0.22 + math.random() * 0.22
        end
        return base
    end
    __L1.effects = function(self, x, y, color, count, ____type, extra)
        if count == nil then
            count = 4
        end
        if ____type == nil then
            ____type = "spark"
        end
        if extra == nil then
            extra = {}
        end
        local primary = __call(
            __arrL({"hit", "combo", "ko"}, 3),
            "includes",
            ____type
        )
        local ____t_498 = __t
        local ____t_result_497
        if __t(primary) then
            ____t_result_497 = __len(__call(
                __L1.effectFrames,
                "filter",
                function(____, e) return e.type ~= "spark" end
            )) >= 8
        else
            ____t_result_497 = primary
        end
        if ____t_498(____t_result_497) then
            local oldest = __call(
                __L1.effectFrames,
                "findIndex",
                function(____, e) return e.type ~= "spark" end
            )
            if oldest >= 0 then
                __call(__L1.effectFrames, "splice", oldest, 1)
            end
        end
        if __t(primary) then
            __call(
                __L1.effectFrames,
                "push",
                __assign({}, {
                    x = x,
                    y = y,
                    vx = 0,
                    vy = 0,
                    life = ____type == "ko" and 0.48 or (____type == "combo" and 0.32 or 0.16),
                    maxLife = ____type == "ko" and 0.48 or (____type == "combo" and 0.32 or 0.16),
                    color = color,
                    type = ____type
                }, extra)
            )
        end
        local budget = __L1.renderCost > 20 and 1 or (__t(primary) and 3 or math.min(3, count))
        do
            local i = 0
            while i < budget do
                __call(
                    __L1.effectFrames,
                    "push",
                    {
                        x = x,
                        y = y,
                        vx = (math.random() - 0.5) * 105,
                        vy = -30 - math.random() * 55,
                        life = 0.14 + math.random() * 0.1,
                        maxLife = 0.24,
                        color = color,
                        type = "spark"
                    }
                )
                i = i + 1
            end
        end
        if __len(__L1.effectFrames) > 22 then
            __call(
                __L1.effectFrames,
                "splice",
                0,
                __len(__L1.effectFrames) - 22
            )
        end
    end
    __L1.emitEvent = function(self, name, x, y, extra)
        if extra == nil then
            extra = {}
        end
        local ____assign_507 = __assign
        local ____temp_506 = {}
        local ____L1_world_499, ____eventSerial_500 = __L1.world, "eventSerial"
        local ____L1_world_eventSerial_501 = ____L1_world_499[____eventSerial_500] + 1
        ____L1_world_499[____eventSerial_500] = ____L1_world_eventSerial_501
        local ____name_503 = name
        local ____x_504 = x
        local ____y_505 = y
        local ____t_result_502
        if __t(extra.color) then
            ____t_result_502 = extra.color
        else
            ____t_result_502 = "#fff0bd"
        end
        local e = ____assign_507(____temp_506, {
            id = ____L1_world_eventSerial_501,
            name = ____name_503,
            x = ____x_504,
            y = ____y_505,
            color = ____t_result_502
        }, extra)
        __call(__L1.world.events, "push", e)
        if __gt(
            __len(__L1.world.events),
            12
        ) then
            __call(__L1.world.events, "shift")
        end
        __L1:consumeEvents()
    end
    __L1.consumeEvents = function(self)
        if not __t(__L1.world) then
            return
        end
        if __L1.lastEventMatch ~= __L1.world.matchId then
            __L1.lastEventMatch = __L1.world.matchId
            __L1.lastEventId = 0
        end
        local ____iter_521 = __iter
        local ____t_result_520
        if __t(__L1.world.events) then
            ____t_result_520 = __L1.world.events
        else
            ____t_result_520 = __arrL({}, 0)
        end
        for ____, e in __TS__Iterator(____iter_521(____t_result_520)) do
            do
                if __le(e.id, __L1.lastEventId) then
                    continue
                end
                __L1.lastEventId = e.id
                local ____t_result_508
                if __t(e.sound) then
                    ____t_result_508 = e.sound
                else
                    ____t_result_508 = e.name
                end
                local sound = ____t_result_508
                local ____t_511 = __t
                local ____opt_509 = window.ArenaSound
                if ____opt_509 ~= nil then
                    ____opt_509 = ____opt_509.play
                end
                if ____t_511(____opt_509) then
                    window.ArenaSound:play(
                        sound,
                        {id = __add(
                            __add(__L1.world.matchId, ":"),
                            e.id
                        )}
                    )
                else
                    window:dispatchEvent(__new(
                        "CustomEvent",
                        "arena-sfx",
                        {detail = {
                            name = sound,
                            id = __add(
                                __add(__L1.world.matchId, ":"),
                                e.id
                            )
                        }}
                    ))
                end
                if __t(__call(
                    __arrL({"hit", "combo", "ko"}, 3),
                    "includes",
                    e.name
                )) then
                    local ____t_result_514
                    local ____t_513 = __t
                    local ____TS__Number_result_512 = __TS__Number(e.power)
                    __O[2907] = ____TS__Number_result_512
                    if ____t_513(____TS__Number_result_512) then
                        ____t_result_514 = __O[2907]
                    else
                        ____t_result_514 = 0
                    end
                    local power = ____t_result_514
                    local k = __t(__L1.calmMotion) and 0.25 or 1
                    if e.name == "ko" then
                        __L1.shakeAmount = math.max(__L1.shakeAmount, 16 * k)
                        __L1.flashAmount = 0.42 * k
                        local ____t_result_515
                        if __t(e.color) then
                            ____t_result_515 = e.color
                        else
                            ____t_result_515 = "#fff7d6"
                        end
                        __L1.flashColor = ____t_result_515
                    else
                        __L1.shakeAmount = math.max(
                            __L1.shakeAmount,
                            math.min(13, (e.name == "combo" and 4 or 1.5) + power / 85) * k
                        )
                        if power > 700 then
                            __L1.flashAmount = math.max(__L1.flashAmount, 0.18 * k)
                            __L1.flashColor = "#fff7d6"
                        end
                    end
                end
                if __t(__call(
                    __arrL({"hit", "combo", "ko"}, 3),
                    "includes",
                    e.name
                )) then
                    local ____L1_effects_519 = __L1.effects
                    local ____array_518 = __TS__SparseArrayNew(
                        e.x,
                        e.y,
                        e.color,
                        e.name == "ko" and 28 or (e.name == "combo" and 20 or 8),
                        e.name
                    )
                    local ____t_result_516
                    if __t(e.text) then
                        ____t_result_516 = e.text
                    else
                        ____t_result_516 = ""
                    end
                    local ____t_result_517
                    if __t(e.radius) then
                        ____t_result_517 = e.radius
                    else
                        ____t_result_517 = 30
                    end
                    __TS__SparseArrayPush(____array_518, {text = ____t_result_516, radius = ____t_result_517, shape = e.shape})
                    ____L1_effects_519(
                        __L1,
                        __TS__SparseArraySpread(____array_518)
                    )
                end
            end
        end
    end
    __L1.nearest = function(self, p)
        return __get(
            __call(
                __call(
                    __L1.world.players,
                    "filter",
                    function(____, q)
                        local ____t_result_524
                        local ____t_523 = __t
                        local ____temp_522 = __gt(q.stocks, 0) and __le(q.respawn, 0)
                        __O[2908] = ____temp_522
                        if ____t_523(____temp_522) then
                            ____t_result_524 = q.id ~= p.id
                        else
                            ____t_result_524 = __O[2908]
                        end
                        return ____t_result_524
                    end
                ),
                "sort",
                function(____, a, b) return __hypot(a.x - p.x, a.y - p.y) - __hypot(b.x - p.x, b.y - p.y) end
            ),
            0
        )
    end
    __L1.descriptor = function(self, p, kind, dir)
        local ____t_result_546
        local ____t_530 = __t
        local ____opt_527 = window.ArenaCombat
        if ____opt_527 ~= nil then
            ____opt_527 = ____opt_527.attack
        end
        local ____opt_result_529
        if ____opt_527 ~= nil then
            ____opt_result_529 = ____opt_527(
                ____opt_527,
                p.character,
                kind,
                dir,
                {
                    facing = p.facing,
                    airborne = not __t(p.ground),
                    time = __L1.world.time,
                    energy = p.energy,
                    comboReady = __ge(p.comboHits, 3)
                }
            )
        end
        __O[2910] = ____opt_result_529
        if ____t_530(____opt_result_529) then
            ____t_result_546 = __O[2910]
        else
            local ____assign_545 = __assign
            local ____temp_543 = {}
            local ____kind_533 = kind
            local ____kind_534 = kind
            local ____kind_535 = kind
            local ____dir_536 = dir
            local ____temp_537 = kind == "physical" and 8 or (kind == "combo" and 28 or 7)
            local ____temp_538 = kind == "combo" and 700 or (kind == "physical" and 170 or 145)
            local ____temp_532
            if dir == "up" then
                ____temp_532 = -math.pi / 2
            else
                local ____temp_531
                if dir == "down" then
                    ____temp_531 = math.pi / 2
                else
                    ____temp_531 = -0.25
                end
                ____temp_532 = ____temp_531
            end
            local ____temp_544 = {
                id = ____kind_533,
                name = ____kind_534,
                kind = ____kind_535,
                direction = ____dir_536,
                damage = ____temp_537,
                knockback = ____temp_538,
                angle = ____temp_532,
                reach = 62,
                radius = 26,
                windup = 0.1,
                duration = 0.14,
                recovery = 0.3,
                cooldown = kind == "ranged" and 0.65 or 0.4,
                color = __L1:kit(p.character).color,
                shape = "fist"
            }
            local ____temp_542
            if kind == "ranged" then
                local ____t_result_541
                local ____t_540 = __t
                local ____table_shot_539 = __L1:kit(p.character).shot
                __O[2909] = ____table_shot_539
                if ____t_540(____table_shot_539) then
                    ____t_result_541 = __O[2909]
                else
                    ____t_result_541 = "paper"
                end
                ____temp_542 = {projectile = {type = ____t_result_541, speed = 500, life = 1.7}}
            else
                ____temp_542 = {}
            end
            ____t_result_546 = ____assign_545(____temp_543, ____temp_544, ____temp_542)
        end
        return ____t_result_546
    end
    __L1.startAttack = function(self, p, kind, i)
        local ____t_550 = __t
        local ____t_result_549
        local ____t_548 = __t
        local ____temp_547 = __gt(p.stun, 0) or __gt(p.respawn, 0)
        __O[2911] = ____temp_547
        if ____t_548(____temp_547) then
            ____t_result_549 = __O[2911]
        else
            ____t_result_549 = __le(p.stocks, 0)
        end
        if ____t_550(____t_result_549) then
            return false
        end
        local ____t_554 = __t
        local ____t_result_553
        local ____t_552 = __t
        local ____temp_551 = kind == "physical" and __gt(p.cd, 0)
        __O[2912] = ____temp_551
        if ____t_552(____temp_551) then
            ____t_result_553 = __O[2912]
        else
            ____t_result_553 = kind == "ranged" and __gt(p.skillCD, 0)
        end
        if ____t_554(____t_result_553) then
            return false
        end
        if __t(kind == "combo" and __lt(p.comboHits, 3)) then
            if p.id == __L1:localId() then
                __L1:notify("Acerte três golpes físicos para liberar o combo!")
            end
            return false
        end
        local dir = __L1:direction(i, p)
        if __TS__Number(i.aim) == 1 then
            p.facing = -1
        end
        if __TS__Number(i.aim) == 2 then
            p.facing = 1
        end
        local d = __L1:descriptor(p, kind, dir)
        local ____L1_world_555, ____shotSerial_556 = __L1.world, "shotSerial"
        local ____L1_world_shotSerial_557 = ____L1_world_555[____shotSerial_556] + 1
        ____L1_world_555[____shotSerial_556] = ____L1_world_shotSerial_557
        local id = ____L1_world_shotSerial_557
        local ____t_565 = __t
        local ____t_result_564
        local ____t_563 = __t
        local ____t_result_562
        local ____t_561 = __t
        local ____t_result_560
        local ____t_559 = __t
        local ____temp_558 = kind == "physical" and dir == "up"
        __O[2913] = ____temp_558
        if ____t_559(____temp_558) then
            ____t_result_560 = not __t(p.ground)
        else
            ____t_result_560 = __O[2913]
        end
        __O[2914] = ____t_result_560
        if ____t_561(____t_result_560) then
            ____t_result_562 = not __t(p.recoveryUsed)
        else
            ____t_result_562 = __O[2914]
        end
        __O[2915] = ____t_result_562
        if ____t_563(____t_result_562) then
            ____t_result_564 = __le(p.stun, 0)
        else
            ____t_result_564 = __O[2915]
        end
        if ____t_565(____t_result_564) then
            p.recoveryUsed = true
            p.launch = 0
            p.vy = math.min(p.vy, -560)
        end
        p.emote = 0
        local ____p_572 = p
        local ____add_571 = __add
        local ____add_568 = __add
        local ____t_result_566
        if __t(d.windup) then
            ____t_result_566 = d.windup
        else
            ____t_result_566 = 0.1
        end
        local ____t_result_567
        if __t(d.duration) then
            ____t_result_567 = d.duration
        else
            ____t_result_567 = 0.15
        end
        local ____add_568_result_570 = ____add_568(____t_result_566, ____t_result_567)
        local ____t_result_569
        if __t(d.recovery) then
            ____t_result_569 = d.recovery
        else
            ____t_result_569 = 0.2
        end
        ____p_572.attackAnim = math.max(
            0.35,
            ____add_571(____add_568_result_570, ____t_result_569)
        )
        p.attackTotal = p.attackAnim
        p.attackProgress = 0
        p.attackType = kind
        p.attackDirection = dir
        local ____p_574 = p
        local ____t_result_573
        if __t(d.shape) then
            ____t_result_573 = d.shape
        else
            ____t_result_573 = "fist"
        end
        ____p_574.attackShape = ____t_result_573
        p.quote = kind == "combo" and 2.5 or 0.65
        p.attackState = {
            id = id,
            kind = kind,
            dir = dir,
            t = 0,
            targetId = nil,
            counted = false,
            name = d.name
        }
        if kind == "physical" then
            local ____p_576 = p
            local ____t_result_575
            if __t(d.cooldown) then
                ____t_result_575 = d.cooldown
            else
                ____t_result_575 = 0.43
            end
            ____p_576.cd = ____t_result_575
        elseif kind == "ranged" then
            local ____p_578 = p
            local ____t_result_577
            if __t(d.cooldown) then
                ____t_result_577 = d.cooldown
            else
                ____t_result_577 = 0.72
            end
            ____p_578.skillCD = ____t_result_577
        else
            p.comboHits = 0
            p.cd = math.max(p.cd, 0.9)
            p.skillCD = math.max(p.skillCD, 0.9)
        end
        if __t(d.transform) then
            p.transform = d.transform
            local ____p_580 = p
            local ____t_result_579
            if __t(d.form) then
                ____t_result_579 = d.form
            else
                ____t_result_579 = "powered"
            end
            ____p_580.form = ____t_result_579
        end
        if __t(d.self) then
            if __isFiniteN(d.self.vx) then
                p.vx = d.self.vx * p.facing
            end
            if __isFiniteN(d.self.vy) then
                p.vy = d.self.vy
                p.ground = false
            end
            if __t(d.self.inv) then
                p.inv = math.max(p.inv, d.self.inv)
            end
        end
        local ____t_result_601
        local ____t_587 = __t
        local ____t_result_586
        local ____t_582 = __t
        local ____temp_581 = kind == "combo"
        __O[2916] = ____temp_581
        if ____t_582(____temp_581) then
            local ____lenq_585 = __lenq
            local ____opt_583 = d.finisher
            if ____opt_583 ~= nil then
                ____opt_583 = ____opt_583.hits
            end
            ____t_result_586 = ____lenq_585(____opt_583)
        else
            ____t_result_586 = __O[2916]
        end
        if ____t_587(____t_result_586) then
            ____t_result_601 = d.finisher.hits
        else
            local ____arrL_600 = __arrL
            local ____d_damage_597 = d.damage
            local ____d_knockback_598 = d.knockback
            local ____d_angle_599 = d.angle
            local ____t_result_589
            if __t(dir == "up" or dir == "down") then
                ____t_result_589 = 0
            else
                local ____t_result_588
                if __t(d.reach) then
                    ____t_result_588 = d.reach
                else
                    ____t_result_588 = 60
                end
                ____t_result_589 = ____t_result_588 * 0.65
            end
            local ____temp_595
            if dir == "up" then
                local ____temp_591 = -34
                local ____t_result_590
                if __t(d.reach) then
                    ____t_result_590 = d.reach
                else
                    ____t_result_590 = 60
                end
                ____temp_595 = ____temp_591 - ____t_result_590 * 0.6
            else
                local ____temp_594
                if dir == "down" then
                    local ____temp_593 = -34
                    local ____t_result_592
                    if __t(d.reach) then
                        ____t_result_592 = d.reach
                    else
                        ____t_result_592 = 60
                    end
                    ____temp_594 = ____temp_593 + ____t_result_592 * 0.55
                else
                    ____temp_594 = -34
                end
                ____temp_595 = ____temp_594
            end
            local ____t_result_596
            if __t(d.radius) then
                ____t_result_596 = d.radius
            else
                ____t_result_596 = 26
            end
            ____t_result_601 = ____arrL_600({{
                delay = 0,
                damage = ____d_damage_597,
                knockback = ____d_knockback_598,
                angle = ____d_angle_599,
                dx = ____t_result_589,
                dy = ____temp_595,
                radius = ____t_result_596,
                shape = d.shape
            }}, 1)
        end
        local hits = ____t_result_601
        if __t(kind ~= "ranged" or not __t(d.projectile)) then
            do
                local index = 0
                while __lt(
                    index,
                    __len(hits)
                ) do
                    local h = __get(hits, index)
                    local ____call_634 = __call
                    local ____L1_world_queue_633 = __L1.world.queue
                    local ____assign_632 = __assign
                    local ____temp_630 = {}
                    local ____p_id_608 = p.id
                    local ____kind_609 = kind
                    local ____p_facing_610 = p.facing
                    local ____add_607 = __add
                    local ____add_604 = __add
                    local ____L1_world_time_603 = __L1.world.time
                    local ____t_result_602
                    if __t(d.windup) then
                        ____t_result_602 = d.windup
                    else
                        ____t_result_602 = 0.1
                    end
                    local ____add_604_result_606 = ____add_604(____L1_world_time_603, ____t_result_602)
                    local ____t_result_605
                    if __t(h.delay) then
                        ____t_result_605 = h.delay
                    else
                        ____t_result_605 = 0
                    end
                    local ____temp_631 = {
                        owner = ____p_id_608,
                        attackId = id,
                        kind = ____kind_609,
                        facing = ____p_facing_610,
                        at = ____add_607(____add_604_result_606, ____t_result_605),
                        duration = 0.16,
                        stage = index,
                        targetId = nil
                    }
                    local ____h_damage_611 = h.damage
                    if ____h_damage_611 == nil then
                        ____h_damage_611 = d.damage
                    end
                    local ____h_knockback_612 = h.knockback
                    if ____h_knockback_612 == nil then
                        ____h_knockback_612 = d.knockback
                    end
                    local ____h_angle_613 = h.angle
                    if ____h_angle_613 == nil then
                        ____h_angle_613 = d.angle
                    end
                    local ____t_result_614
                    if __t(d.color) then
                        ____t_result_614 = d.color
                    else
                        ____t_result_614 = __L1:kit(p.character).color
                    end
                    local ____temp_619
                    if index == __len(hits) - 1 then
                        local ____t_result_618
                        local ____t_617 = __t
                        local ____opt_615 = d.finisher
                        if ____opt_615 ~= nil then
                            ____opt_615 = ____opt_615.sound
                        end
                        __O[2917] = ____opt_615
                        if ____t_617(____opt_615) then
                            ____t_result_618 = __O[2917]
                        else
                            ____t_result_618 = d.sound
                        end
                        ____temp_619 = ____t_result_618
                    else
                        ____temp_619 = nil
                    end
                    local ____t_result_620
                    if __t(d.slow) then
                        ____t_result_620 = d.slow
                    else
                        ____t_result_620 = 0
                    end
                    local ____t_result_621
                    if __t(d.slowFactor) then
                        ____t_result_621 = d.slowFactor
                    else
                        ____t_result_621 = 0.7
                    end
                    local ____t_result_625
                    local ____t_624 = __t
                    local ____opt_622 = d.finisher
                    if ____opt_622 ~= nil then
                        ____opt_622 = ____opt_622.grab
                    end
                    __O[2918] = ____opt_622
                    if ____t_624(____opt_622) then
                        ____t_result_625 = __O[2918]
                    else
                        ____t_result_625 = 0
                    end
                    local ____t_result_629
                    local ____t_628 = __t
                    local ____opt_626 = d.finisher
                    if ____opt_626 ~= nil then
                        ____opt_626 = ____opt_626.summon
                    end
                    __O[2919] = ____opt_626
                    if ____t_628(____opt_626) then
                        ____t_result_629 = __O[2919]
                    else
                        ____t_result_629 = nil
                    end
                    ____call_634(
                        ____L1_world_queue_633,
                        "push",
                        ____assign_632(____temp_630, ____temp_631, h, {
                            damage = ____h_damage_611,
                            knockback = ____h_knockback_612,
                            angle = ____h_angle_613,
                            color = ____t_result_614,
                            sound = ____temp_619,
                            slow = ____t_result_620,
                            slowFactor = ____t_result_621,
                            grab = ____t_result_625,
                            summon = ____t_result_629
                        })
                    )
                    index = index + 1
                end
            end
        end
        if __t(d.projectile) then
            local ____call_657 = __call
            local ____L1_world_queue_656 = __L1.world.queue
            local ____p_id_653 = p.id
            local ____kind_654 = kind
            local ____add_637 = __add
            local ____L1_world_time_636 = __L1.world.time
            local ____t_result_635
            if __t(d.windup) then
                ____t_result_635 = d.windup
            else
                ____t_result_635 = 0.1
            end
            local ____add_637_result_655 = ____add_637(____L1_world_time_636, ____t_result_635)
            local ____assign_652 = __assign
            local ____temp_650 = {}
            local ____d_projectile_651 = d.projectile
            local ____d_projectile_damage_638 = d.projectile.damage
            if ____d_projectile_damage_638 == nil then
                ____d_projectile_damage_638 = d.damage
            end
            local ____d_projectile_knockback_639 = d.projectile.knockback
            if ____d_projectile_knockback_639 == nil then
                ____d_projectile_knockback_639 = d.knockback
            end
            local ____t_result_640
            if __t(d.angle) then
                ____t_result_640 = d.angle
            else
                ____t_result_640 = 0
            end
            local ____d_projectile_slow_641 = d.projectile.slow
            if ____d_projectile_slow_641 == nil then
                ____d_projectile_slow_641 = d.slow
            end
            local ____d_projectile_slow_641_642 = ____d_projectile_slow_641
            if ____d_projectile_slow_641_642 == nil then
                ____d_projectile_slow_641_642 = 0
            end
            local ____d_projectile_slowFactor_643 = d.projectile.slowFactor
            if ____d_projectile_slowFactor_643 == nil then
                ____d_projectile_slowFactor_643 = d.slowFactor
            end
            local ____d_projectile_slowFactor_643_644 = ____d_projectile_slowFactor_643
            if ____d_projectile_slowFactor_643_644 == nil then
                ____d_projectile_slowFactor_643_644 = 0.7
            end
            local ____d_projectile_boomerang_645 = d.projectile.boomerang
            if ____d_projectile_boomerang_645 == nil then
                ____d_projectile_boomerang_645 = d.boomerang
            end
            local ____d_projectile_boomerang_645_646 = ____d_projectile_boomerang_645
            if ____d_projectile_boomerang_645_646 == nil then
                ____d_projectile_boomerang_645_646 = false
            end
            local ____d_projectile_returnGain_647 = d.projectile.returnGain
            if ____d_projectile_returnGain_647 == nil then
                ____d_projectile_returnGain_647 = d.returnGain
            end
            local ____d_projectile_returnGain_647_648 = ____d_projectile_returnGain_647
            if ____d_projectile_returnGain_647_648 == nil then
                ____d_projectile_returnGain_647_648 = 0
            end
            local ____t_result_649
            if __t(d.color) then
                ____t_result_649 = d.color
            else
                ____t_result_649 = __L1:kit(p.character).color
            end
            ____call_657(
                ____L1_world_queue_656,
                "push",
                {
                    owner = ____p_id_653,
                    attackId = id,
                    kind = "projectile",
                    sourceKind = ____kind_654,
                    at = ____add_637_result_655,
                    config = ____assign_652(____temp_650, ____d_projectile_651, {
                        damage = ____d_projectile_damage_638,
                        knockback = ____d_projectile_knockback_639,
                        angle = ____t_result_640,
                        slow = ____d_projectile_slow_641_642,
                        slowFactor = ____d_projectile_slowFactor_643_644,
                        boomerang = ____d_projectile_boomerang_645_646,
                        returnGain = ____d_projectile_returnGain_647_648,
                        color = ____t_result_649,
                        direction = dir,
                        facing = p.facing
                    })
                }
            )
        end
        if __gt(
            __len(__L1.world.queue),
            16
        ) then
            __call(
                __L1.world.queue,
                "splice",
                0,
                __len(__L1.world.queue) - 16
            )
        end
        return true
    end
    __L1.spawnQueued = function(self, q)
        local p = __call(
            __L1.world.players,
            "find",
            function(____, p) return p.id == q.owner end
        )
        local ____t_661 = __t
        local ____t_result_660
        local ____t_659 = __t
        local ____temp_658 = not __t(p) or __le(p.stocks, 0)
        __O[2920] = ____temp_658
        if ____t_659(____temp_658) then
            ____t_result_660 = __O[2920]
        else
            ____t_result_660 = __gt(p.respawn, 0)
        end
        if ____t_661(____t_result_660) then
            return
        end
        if q.kind == "projectile" then
            local s = q.config
            local ____L1_clamp_663 = __L1.clamp
            local ____t_result_662
            if __t(s.count) then
                ____t_result_662 = s.count
            else
                ____t_result_662 = 1
            end
            local count = ____L1_clamp_663(__L1, ____t_result_662, 1, 5)
            local dir = s.direction
            local ____t_result_667
            if __t(q.sourceKind == "physical" and s.motion == "wave") then
                ____t_result_667 = 0
            else
                local ____isFiniteN_result_666
                if __isFiniteN(s.angle) then
                    ____isFiniteN_result_666 = s.angle
                else
                    local ____temp_665
                    if dir == "up" then
                        ____temp_665 = -math.pi / 2
                    else
                        local ____temp_664
                        if dir == "down" then
                            ____temp_664 = math.pi / 2
                        else
                            ____temp_664 = 0
                        end
                        ____temp_665 = ____temp_664
                    end
                    ____isFiniteN_result_666 = ____temp_665
                end
                ____t_result_667 = ____isFiniteN_result_666
            end
            local angle = ____t_result_667
            do
                local j = 0
                while j < count do
                    local ____temp_669 = j - (count - 1) / 2
                    local ____t_result_668
                    if __t(s.spread) then
                        ____t_result_668 = s.spread
                    else
                        ____t_result_668 = 0.12
                    end
                    local a = angle + ____temp_669 * ____t_result_668
                    local ____t_result_670
                    if __t(s.speed) then
                        ____t_result_670 = s.speed
                    else
                        ____t_result_670 = 440
                    end
                    local speed = ____t_result_670
                    local ____call_706 = __call
                    local ____L1_world_shots_705 = __L1.world.shots
                    local ____L1_world_671, ____shotSerial_672 = __L1.world, "shotSerial"
                    local ____L1_world_shotSerial_673 = ____L1_world_671[____shotSerial_672] + 1
                    ____L1_world_671[____shotSerial_672] = ____L1_world_shotSerial_673
                    local ____p_id_695 = p.id
                    local ____q_attackId_696 = q.attackId
                    local ____t_result_674
                    if __t(s.type) then
                        ____t_result_674 = s.type
                    else
                        ____t_result_674 = "paper"
                    end
                    local ____temp_697 = p.x + p.facing * 24
                    local ____t_result_675
                    if __t(q.sourceKind == "physical" and s.motion == "wave") then
                        ____t_result_675 = p.y - 8
                    else
                        ____t_result_675 = p.y - 33
                    end
                    local ____isFiniteN_result_676
                    if __isFiniteN(s.vx) then
                        ____isFiniteN_result_676 = s.vx * p.facing
                    else
                        ____isFiniteN_result_676 = math.cos(a) * speed * p.facing
                    end
                    local ____isFiniteN_result_677
                    if __isFiniteN(s.vy) then
                        ____isFiniteN_result_677 = s.vy
                    else
                        ____isFiniteN_result_677 = math.sin(a) * speed
                    end
                    local ____t_result_680
                    local ____t_679 = __t
                    local ____t_result_678
                    if __t(s.radius) then
                        ____t_result_678 = s.radius
                    else
                        ____t_result_678 = s.r
                    end
                    __O[2921] = ____t_result_678
                    if ____t_679(____t_result_678) then
                        ____t_result_680 = __O[2921]
                    else
                        ____t_result_680 = 11
                    end
                    local ____t_result_681
                    if __t(s.life) then
                        ____t_result_681 = s.life
                    else
                        ____t_result_681 = 1.75
                    end
                    local ____t_result_682
                    if __t(s.life) then
                        ____t_result_682 = s.life
                    else
                        ____t_result_682 = 1.75
                    end
                    local ____t_result_683
                    if __t(s.damage) then
                        ____t_result_683 = s.damage
                    else
                        ____t_result_683 = 7
                    end
                    local ____t_result_684
                    if __t(s.knockback) then
                        ____t_result_684 = s.knockback
                    else
                        ____t_result_684 = 150
                    end
                    local ____t_result_685
                    if __t(s.angle) then
                        ____t_result_685 = s.angle
                    else
                        ____t_result_685 = -0.2
                    end
                    local ____t_result_686
                    if __t(s.gravity) then
                        ____t_result_686 = s.gravity
                    else
                        ____t_result_686 = 0
                    end
                    local ____s_color_698 = s.color
                    local ____t_result_687
                    if __t(s.motion) then
                        ____t_result_687 = s.motion
                    else
                        ____t_result_687 = "straight"
                    end
                    local ____temp_699 = not not __t(s.boomerang) or s.motion == "tether"
                    local ____s_returnAfter_689 = s.returnAfter
                    if ____s_returnAfter_689 == nil then
                        local ____t_result_688
                        if __t(s.life) then
                            ____t_result_688 = s.life
                        else
                            ____t_result_688 = 1.75
                        end
                        ____s_returnAfter_689 = ____t_result_688 * 0.43
                    end
                    local ____t_result_690
                    if __t(s.returnGain) then
                        ____t_result_690 = s.returnGain
                    else
                        ____t_result_690 = 0
                    end
                    local ____t_result_691
                    if __t(s.slow) then
                        ____t_result_691 = s.slow
                    else
                        ____t_result_691 = 0
                    end
                    local ____t_result_692
                    if __t(s.slowFactor) then
                        ____t_result_692 = s.slowFactor
                    else
                        ____t_result_692 = 0.7
                    end
                    local ____arrL_result_700 = __arrL({}, 0)
                    local ____temp_701 = not not __t(s.homing)
                    local ____p_x_702 = p.x
                    local ____temp_703 = p.y - 33
                    local ____p_facing_704 = p.facing
                    local ____t_result_693
                    if __t(s.text) then
                        ____t_result_693 = s.text
                    else
                        ____t_result_693 = ""
                    end
                    local ____t_result_694
                    if __t(s.variant) then
                        ____t_result_694 = s.variant
                    else
                        ____t_result_694 = ""
                    end
                    ____call_706(____L1_world_shots_705, "push", {
                        id = ____L1_world_shotSerial_673,
                        owner = ____p_id_695,
                        attackId = ____q_attackId_696,
                        type = ____t_result_674,
                        x = ____temp_697,
                        y = ____t_result_675,
                        vx = ____isFiniteN_result_676,
                        vy = ____isFiniteN_result_677,
                        r = ____t_result_680,
                        life = ____t_result_681,
                        maxLife = ____t_result_682,
                        damage = ____t_result_683,
                        knockback = ____t_result_684,
                        angle = ____t_result_685,
                        gravity = ____t_result_686,
                        color = ____s_color_698,
                        motion = ____t_result_687,
                        boomerang = ____temp_699,
                        returnAfter = ____s_returnAfter_689,
                        returnGain = ____t_result_690,
                        slow = ____t_result_691,
                        slowFactor = ____t_result_692,
                        hitIds = ____arrL_result_700,
                        home = ____temp_701,
                        returning = false,
                        startX = ____p_x_702,
                        startY = ____temp_703,
                        dir = ____p_facing_704,
                        text = ____t_result_693,
                        variant = ____t_result_694
                    })
                    j = j + 1
                end
            end
            if __gt(
                __len(__L1.world.shots),
                36
            ) then
                __call(
                    __L1.world.shots,
                    "splice",
                    0,
                    __len(__L1.world.shots) - 36
                )
            end
            return
        end
        local a = p.attackState
        local ____temp_710
        local ____opt_result_709
        if a ~= nil then
            ____opt_result_709 = a.id
        end
        if ____opt_result_709 == q.attackId then
            ____temp_710 = a.targetId
        else
            ____temp_710 = nil
        end
        local locked = ____temp_710
        local ____t_714 = __t
        local ____t_result_713
        local ____t_712 = __t
        local ____temp_711 = q.warp == "target"
        __O[2922] = ____temp_711
        if ____t_712(____temp_711) then
            ____t_result_713 = locked
        else
            ____t_result_713 = __O[2922]
        end
        if ____t_714(____t_result_713) then
            local target = __call(
                __L1.world.players,
                "find",
                function(____, t)
                    local ____t_result_717
                    local ____t_716 = __t
                    local ____temp_715 = t.id == locked and __gt(t.stocks, 0)
                    __O[2923] = ____temp_715
                    if ____t_716(____temp_715) then
                        ____t_result_717 = __le(t.respawn, 0)
                    else
                        ____t_result_717 = __O[2923]
                    end
                    return ____t_result_717
                end
            )
            if __t(target) then
                p.x = target.x - p.facing * 50
                p.y = target.y
                p.vx = 0
                p.vy = 0
                p.inv = math.max(p.inv, 0.12)
            end
        end
        if __t(q.warp == "target" and not __t(locked)) then
            return
        end
        local ____q_dx_718 = q.dx
        if ____q_dx_718 == nil then
            ____q_dx_718 = 45
        end
        local ____t_result_719
        if __t(q.facing) then
            ____t_result_719 = q.facing
        else
            ____t_result_719 = p.facing
        end
        local dx = ____q_dx_718 * ____t_result_719
        local ____q_dy_720 = q.dy
        if ____q_dy_720 == nil then
            ____q_dy_720 = -33
        end
        local dy = ____q_dy_720
        local ____call_736 = __call
        local ____L1_world_attacks_735 = __L1.world.attacks
        local ____assign_734 = __assign
        local ____temp_732 = {}
        local ____q_733 = q
        local ____L1_world_721, ____shotSerial_722 = __L1.world, "shotSerial"
        local ____L1_world_shotSerial_723 = ____L1_world_721[____shotSerial_722] + 1
        ____L1_world_721[____shotSerial_722] = ____L1_world_shotSerial_723
        local ____temp_727 = p.x + dx
        local ____add_result_728 = __add(p.y, dy)
        local ____dx_729 = dx
        local ____dy_730 = dy
        local ____t_result_724
        if __t(q.radius) then
            ____t_result_724 = q.radius
        else
            ____t_result_724 = 29
        end
        local ____t_result_725
        if __t(q.duration) then
            ____t_result_725 = q.duration
        else
            ____t_result_725 = 0.16
        end
        local ____arrL_result_731 = __arrL({}, 0)
        local ____t_result_726
        if __t(q.kind == "combo" and __gt(q.stage, 0)) then
            ____t_result_726 = locked
        else
            ____t_result_726 = nil
        end
        ____call_736(
            ____L1_world_attacks_735,
            "push",
            ____assign_734(____temp_732, ____q_733, {
                id = ____L1_world_shotSerial_723,
                x = ____temp_727,
                y = ____add_result_728,
                dx = ____dx_729,
                dy = ____dy_730,
                r = ____t_result_724,
                life = ____t_result_725,
                hitIds = ____arrL_result_731,
                follow = true,
                trackTargetId = ____t_result_726
            })
        )
        if __gt(
            __len(__L1.world.attacks),
            12
        ) then
            __call(__L1.world.attacks, "shift")
        end
        local ____opt_result_739
        if a ~= nil then
            ____opt_result_739 = a.id
        end
        if ____opt_result_739 == q.attackId then
            local ____t_result_740
            if __t(q.stage) then
                ____t_result_740 = q.stage
            else
                ____t_result_740 = 0
            end
            p.comboStage = ____t_result_740
        end
    end
    __L1.applyHit = function(self, target, hit, source)
        local ____t_744 = __t
        local ____t_result_743
        local ____t_742 = __t
        local ____temp_741 = __le(target.stocks, 0) or __gt(target.respawn, 0)
        __O[2924] = ____temp_741
        if ____t_742(____temp_741) then
            ____t_result_743 = __O[2924]
        else
            ____t_result_743 = __gt(target.inv, 0)
        end
        if ____t_744(____t_result_743) then
            return false
        end
        local ____t_result_747
        local ____t_746 = __t
        local ____TS__Number_result_745 = __TS__Number(hit.damage)
        __O[2925] = ____TS__Number_result_745
        if ____t_746(____TS__Number_result_745) then
            ____t_result_747 = __O[2925]
        else
            ____t_result_747 = 7
        end
        local amount = math.max(1, ____t_result_747)
        target.damage = math.min(999, target.damage + amount)
        target.hit = 0.18
        target.emote = 0
        local grounded = not not __t(target.ground)
        target.ground = false
        target.stun = math.min(0.55, 0.12 + amount * 0.009)
        target.inv = hit.kind == "combo" and 0.14 or 0.16
        local ____target_750 = target
        local ____target_slow_749 = target.slow
        local ____t_result_748
        if __t(hit.slow) then
            ____t_result_748 = hit.slow
        else
            ____t_result_748 = 0
        end
        ____target_750.slow = math.max(____target_slow_749, ____t_result_748)
        local ____target_752 = target
        local ____t_result_751
        if __t(hit.slowFactor) then
            ____t_result_751 = hit.slowFactor
        else
            ____t_result_751 = 0.7
        end
        ____target_752.slowFactor = ____t_result_751
        local ____t_result_755
        local ____t_754 = __t
        local ____table_weight_753 = __L1:kit(target.character).weight
        __O[2926] = ____table_weight_753
        if ____t_754(____table_weight_753) then
            ____t_result_755 = __O[2926]
        else
            ____t_result_755 = 1
        end
        local weight = ____t_result_755
        local ____t_result_756
        if __t(hit.knockback) then
            ____t_result_756 = hit.knockback
        else
            ____t_result_756 = 170
        end
        local base = ____t_result_756 * (0.7 + target.damage / 80) / weight
        local ____isFiniteN_result_757
        if __isFiniteN(hit.angle) then
            ____isFiniteN_result_757 = hit.angle
        else
            ____isFiniteN_result_757 = -0.3
        end
        local angle = ____isFiniteN_result_757
        local ____t_result_761
        local ____t_759 = __t
        local ____t_result_758
        if __t(hit.facing) then
            ____t_result_758 = hit.facing
        else
            ____t_result_758 = hit.dir
        end
        __O[2927] = ____t_result_758
        if ____t_759(____t_result_758) then
            ____t_result_761 = __O[2927]
        else
            local ____t_result_760
            if __t(source) then
                ____t_result_760 = source.facing
            else
                ____t_result_760 = __gt(target.x, hit.x) and 1 or -1
            end
            ____t_result_761 = ____t_result_760
        end
        local face = ____t_result_761
        local ____t_765 = __t
        local ____t_result_764
        local ____t_763 = __t
        local ____gt_result_762 = __gt(angle, 0.3)
        __O[2928] = ____gt_result_762
        if ____t_763(____gt_result_762) then
            ____t_result_764 = grounded
        else
            ____t_result_764 = __O[2928]
        end
        if ____t_765(____t_result_764) then
            angle = -1.25
            base = base * 0.7
        elseif __t(__gt(angle, -0.45) and __le(angle, 0.3)) then
            angle = -0.62
        end
        target.vx = __L1:clamp(
            math.cos(angle) * base * face,
            -1500,
            1500
        )
        target.vy = __L1:clamp(
            math.sin(angle) * base,
            -1350,
            1100
        )
        target.stun = math.min(
            0.95,
            math.max(target.stun, 0.12 + base / 1500)
        )
        local ____target_767 = target
        local ____temp_766
        if base > 330 then
            ____temp_766 = math.min(1.6, 0.35 + base / 900)
        else
            ____temp_766 = 0
        end
        ____target_767.launch = ____temp_766
        target.recoveryUsed = false
        if __t(source) then
            source.dealt = source.dealt + amount
            source.energy = math.min(100, source.energy + amount * 0.6)
            target.lastAttacker = source.id
            target.lastHitAt = __L1.world.time
            if __t(hit.kind == "physical" and source.lastPhysicalAttack ~= hit.attackId) then
                source.lastPhysicalAttack = hit.attackId
                source.comboHits = math.min(3, source.comboHits + 1)
            end
            local ____t_773 = __t
            local ____t_result_772
            local ____t_771 = __t
            local ____temp_770 = hit.kind == "combo"
            if ____temp_770 then
                local ____opt_768 = source.attackState
                if ____opt_768 ~= nil then
                    ____opt_768 = ____opt_768.id
                end
                ____temp_770 = ____opt_768 == hit.attackId
            end
            __O[2929] = ____temp_770
            if ____t_771(____temp_770) then
                ____t_result_772 = not __t(source.attackState.targetId)
            else
                ____t_result_772 = __O[2929]
            end
            if ____t_773(____t_result_772) then
                source.attackState.targetId = target.id
            end
            if __t(hit.grab) then
                target.stun = math.max(target.stun, hit.grab)
                if __lt(hit.stage, 2) then
                    target.vx = target.vx * 0.35
                    target.vy = target.vy * 0.35
                end
            end
        end
        local ____L1_emitEvent_784 = __L1.emitEvent
        local ____array_783 = __TS__SparseArrayNew(hit.kind == "combo" and "combo" or "hit", target.x, target.y - 35)
        local ____t_result_780
        if __t(hit.color) then
            ____t_result_780 = hit.color
        else
            local ____L1_kit_779 = __L1.kit
            local ____t_result_778
            local ____t_777 = __t
            local ____opt_result_776
            if source ~= nil then
                ____opt_result_776 = source.character
            end
            __O[2930] = ____opt_result_776
            if ____t_777(____opt_result_776) then
                ____t_result_778 = __O[2930]
            else
                ____t_result_778 = target.character
            end
            ____t_result_780 = ____L1_kit_779(__L1, ____t_result_778).color
        end
        local ____t_result_781
        if __t(hit.shape) then
            ____t_result_781 = hit.shape
        else
            ____t_result_781 = hit.type
        end
        local ____t_result_782
        if __t(hit.sound) then
            ____t_result_782 = hit.sound
        else
            ____t_result_782 = "hit"
        end
        __TS__SparseArrayPush(
            ____array_783,
            {
                color = ____t_result_780,
                shape = ____t_result_781,
                sound = ____t_result_782,
                text = hit.kind == "combo" and "COMBO!" or nil,
                power = math.floor(base + 0.5)
            }
        )
        ____L1_emitEvent_784(
            __L1,
            __TS__SparseArraySpread(____array_783)
        )
        return true
    end
    __L1.knockOut = function(self, p, reason)
        if reason == nil then
            reason = "ko"
        end
        if __t(__le(p.stocks, 0) or __gt(p.respawn, 0)) then
            return
        end
        local oldX = p.x
        local oldY = p.y
        p.stocks = p.stocks - 1
        p.damage = 0
        p.comboHits = 0
        p.stun = 0
        p.emote = 0
        p.attackState = nil
        p.attackAnim = 0
        p.vx = 0
        p.vy = 0
        p.jumps = 0
        p.wallSide = 0
        p.wallGrip = 1.35
        p.wallTouches = 0
        p.motion = "fall"
        p.motionTime = 0
        p.inv = 2.3
        p.eliminated = p.stocks == 0
        p.respawn = __t(p.eliminated) and 0 or 1.35
        local ____t_788 = __t
        local ____t_result_787
        if __t(p.lastAttacker) then
            local ____L1_world_time_786 = __L1.world.time
            local ____t_result_785
            if __t(p.lastHitAt) then
                ____t_result_785 = p.lastHitAt
            else
                ____t_result_785 = -99
            end
            ____t_result_787 = ____L1_world_time_786 - ____t_result_785 < 10
        else
            ____t_result_787 = p.lastAttacker
        end
        if ____t_788(____t_result_787) then
            local owner = __call(
                __L1.world.players,
                "find",
                function(____, o) return o.id == p.lastAttacker end
            )
            if __t(owner) then
                owner.kills = owner.kills + 1
            end
        end
        __L1:emitEvent(
            "ko",
            __L1:clamp(oldX, -100, 1380),
            __L1:clamp(oldY, -300, 750),
            {
                color = __L1:kit(p.character).color,
                text = __t(p.eliminated) and "FORA DA RESENHA" or "−1 VIDA",
                shape = reason
            }
        )
        p.x = 640
        p.y = -90
        p.lastAttacker = nil
    end
    __L1.tick = function(self, dt)
        local w = __L1.world
        if not __t(w) then
            return
        end
        if w.phase == "countdown" then
            w.countdown = math.max(
                0,
                (w.startAt - window.Date:now() - __L1.serverOffset) / 1000
            )
            if __gt(w.countdown, 0) then
                return
            end
            w.phase = "playing"
            w.countdown = 0
            __L1.goUntil = window.performance:now() + 550
            for ____, p in __iterar((w.players)) do
                local command = __L1:localInputFor(p)
                for ____, action in __iterar((__L1.actions)) do
                    local ____set_793 = __set
                    local ____p_used_792 = p.used
                    local ____t_result_791
                    local ____t_790 = __t
                    local ____TS__Number_result_789 = __TS__Number(__get(command, action))
                    __O[2931] = ____TS__Number_result_789
                    if ____t_790(____TS__Number_result_789) then
                        ____t_result_791 = __O[2931]
                    else
                        ____t_result_791 = 0
                    end
                    ____set_793(____p_used_792, action, ____t_result_791)
                end
                p.inv = 0
            end
            __L1.prediction = nil
            __L1.predictionHistory = __arrL({}, 0)
            __L1.predictionAccumulator = 0
            __L1:emitEvent("start", 640, 320, {sound = "jump"})
            __L1:syncNow()
            return
        end
        if w.phase ~= "playing" then
            return
        end
        w.time = __add(w.time, dt)
        w.remaining = math.max(0, w.remaining - dt)
        for ____, p in __iterar((w.players)) do
            do
                if __le(p.stocks, 0) then
                    continue
                end
                for ____, key in __iterar((__arrL({
                    "cd",
                    "skillCD",
                    "transform",
                    "attackAnim",
                    "hit",
                    "quote",
                    "emote"
                }, 7))) do
                    local ____set_797 = __set
                    local ____t_result_796
                    local ____t_795 = __t
                    local ____get_result_794 = __get(p, key)
                    __O[2932] = ____get_result_794
                    if ____t_795(____get_result_794) then
                        ____t_result_796 = __O[2932]
                    else
                        ____t_result_796 = 0
                    end
                    ____set_797(
                        p,
                        key,
                        math.max(0, ____t_result_796 - dt)
                    )
                end
                if __gt(p.attackAnim, 0) then
                    local ____L1_clamp_800 = __L1.clamp
                    local ____p_attackAnim_799 = p.attackAnim
                    local ____t_result_798
                    if __t(p.attackTotal) then
                        ____t_result_798 = p.attackTotal
                    else
                        ____t_result_798 = 0.5
                    end
                    p.attackProgress = ____L1_clamp_800(__L1, 1 - ____p_attackAnim_799 / ____t_result_798, 0, 1)
                end
                if __t(p.attackState) then
                    p.attackState.t = __add(p.attackState.t, dt)
                end
                if __le(p.attackAnim, 0) then
                    p.attackState = nil
                end
                local i = __L1:localInputFor(p)
                if __gt(p.respawn, 0) then
                    p.respawn = math.max(0, p.respawn - dt)
                    if __le(p.respawn, 0) then
                        p.y = 140
                        p.x = 640 + (__t(__mod(
                            __call(w.players, "indexOf", p),
                            2
                        )) and 55 or -55)
                        p.vy = 0
                        p.inv = 2.2
                        for ____, a in __iterar((__L1.actions)) do
                            local ____set_805 = __set
                            local ____p_used_804 = p.used
                            local ____t_result_803
                            local ____t_802 = __t
                            local ____get_result_801 = __get(i, a)
                            __O[2933] = ____get_result_801
                            if ____t_802(____get_result_801) then
                                ____t_result_803 = __O[2933]
                            else
                                ____t_result_803 = __get(p.used, a)
                            end
                            ____set_805(____p_used_804, a, ____t_result_803)
                        end
                    end
                    continue
                end
                local iCommand = i
                window.ArenaMotion:step(
                    p,
                    iCommand,
                    dt,
                    __L1:motionOptions(p, true)
                )
                local ____t_result_810
                local ____t_809 = __t
                local ____t_result_808
                local ____t_807 = __t
                local ____TS__Number_result_806 = __TS__Number(i.seq)
                __O[2934] = ____TS__Number_result_806
                if ____t_807(____TS__Number_result_806) then
                    ____t_result_808 = __O[2934]
                else
                    ____t_result_808 = p.ackInput
                end
                __O[2935] = ____t_result_808
                if ____t_809(____t_result_808) then
                    ____t_result_810 = __O[2935]
                else
                    ____t_result_810 = 0
                end
                p.ackInput = ____t_result_810
                for ____, action in __iterar((__arrL({"attack", "special", "ultimate", "emote"}, 4))) do
                    local ____t_result_813
                    local ____t_812 = __t
                    local ____TS__Number_result_811 = __TS__Number(__get(i, action))
                    __O[2936] = ____TS__Number_result_811
                    if ____t_812(____TS__Number_result_811) then
                        ____t_result_813 = __O[2936]
                    else
                        ____t_result_813 = 0
                    end
                    local counter = ____t_result_813
                    if __gt(
                        counter,
                        __get(p.used, action)
                    ) then
                        __set(p.used, action, counter)
                        if action == "attack" then
                            __L1:startAttack(p, "physical", i)
                        end
                        if action == "special" then
                            __L1:startAttack(p, "ranged", i)
                        end
                        if action == "ultimate" then
                            __L1:startAttack(p, "combo", i)
                        end
                        if __t(action == "emote" and __le(p.stun, 0)) then
                            p.emote = 2.2
                            p.emoteKind = __t(__mod(counter, 2)) and "dance" or "taunt"
                            p.quote = 2.2
                        end
                    end
                end
                local ____t_819 = __t
                local ____t_result_818
                local ____t_817 = __t
                local ____t_result_816
                local ____t_815 = __t
                local ____temp_814 = __lt(p.x, __L1.KO.left) or __gt(p.x, __L1.KO.right)
                __O[2937] = ____temp_814
                if ____t_815(____temp_814) then
                    ____t_result_816 = __O[2937]
                else
                    ____t_result_816 = __lt(p.y, __L1.KO.top)
                end
                __O[2938] = ____t_result_816
                if ____t_817(____t_result_816) then
                    ____t_result_818 = __O[2938]
                else
                    ____t_result_818 = __gt(p.y, __L1.KO.bottom)
                end
                if ____t_819(____t_result_818) then
                    __L1:knockOut(p)
                end
            end
        end
        local due = __call(
            w.queue,
            "filter",
            function(____, q) return __le(q.at, w.time) end
        )
        w.queue = __call(
            w.queue,
            "filter",
            function(____, q) return __gt(q.at, w.time) end
        )
        for ____, q in __iterar((due)) do
            __L1:spawnQueued(q)
        end
        for ____, a in __iterar((w.attacks)) do
            do
                a.life = a.life - dt
                local owner = __call(
                    w.players,
                    "find",
                    function(____, p) return p.id == a.owner end
                )
                local ____t_823 = __t
                local ____t_result_822
                local ____t_821 = __t
                local ____temp_820 = not __t(owner) or __le(owner.stocks, 0)
                __O[2939] = ____temp_820
                if ____t_821(____temp_820) then
                    ____t_result_822 = __O[2939]
                else
                    ____t_result_822 = __gt(owner.respawn, 0)
                end
                if ____t_823(____t_result_822) then
                    a.life = 0
                    continue
                end
                if __t(a.follow) then
                    a.x = __add(owner.x, a.dx)
                    a.y = __add(owner.y, a.dy)
                end
                local ____t_result_827
                if __t(a.trackTargetId) then
                    ____t_result_827 = __call(
                        w.players,
                        "find",
                        function(____, p)
                            local ____t_result_826
                            local ____t_825 = __t
                            local ____temp_824 = p.id == a.trackTargetId and __gt(p.stocks, 0)
                            __O[2940] = ____temp_824
                            if ____t_825(____temp_824) then
                                ____t_result_826 = __le(p.respawn, 0)
                            else
                                ____t_result_826 = __O[2940]
                            end
                            return ____t_result_826
                        end
                    )
                else
                    ____t_result_827 = nil
                end
                local locked = ____t_result_827
                if __t(locked) then
                    a.x = locked.x
                    a.y = locked.y - 34
                end
                for ____, p in __iterar((w.players)) do
                    local ____t_837 = __t
                    local ____t_result_836
                    local ____t_835 = __t
                    local ____t_result_834
                    local ____t_833 = __t
                    local ____t_result_832
                    local ____t_831 = __t
                    local ____t_result_830
                    local ____t_829 = __t
                    local ____temp_828 = p.id ~= a.owner
                    __O[2941] = ____temp_828
                    if ____t_829(____temp_828) then
                        ____t_result_830 = not __t(a.trackTargetId) or p.id == a.trackTargetId
                    else
                        ____t_result_830 = __O[2941]
                    end
                    __O[2942] = ____t_result_830
                    if ____t_831(____t_result_830) then
                        ____t_result_832 = not __t(__call(a.hitIds, "includes", p.id))
                    else
                        ____t_result_832 = __O[2942]
                    end
                    __O[2943] = ____t_result_832
                    if ____t_833(____t_result_832) then
                        ____t_result_834 = __lt(
                            math.abs(p.x - a.x),
                            a.r + 17
                        )
                    else
                        ____t_result_834 = __O[2943]
                    end
                    __O[2944] = ____t_result_834
                    if ____t_835(____t_result_834) then
                        ____t_result_836 = __lt(
                            math.abs(p.y - 34 - a.y),
                            a.r + 31
                        )
                    else
                        ____t_result_836 = __O[2944]
                    end
                    if ____t_837(____t_result_836) then
                        if __t(__L1:applyHit(p, a, owner)) then
                            __call(a.hitIds, "push", p.id)
                        end
                    end
                end
            end
        end
        w.attacks = __call(
            w.attacks,
            "filter",
            function(____, a) return __gt(a.life, 0) end
        )
        for ____, s in __iterar((w.shots)) do
            do
                s.life = s.life - dt
                local owner = __call(
                    w.players,
                    "find",
                    function(____, p) return p.id == s.owner end
                )
                if __t(not __t(owner) or __le(owner.stocks, 0)) then
                    s.life = 0
                    continue
                end
                local elapsed = s.maxLife - s.life
                local ____t_839 = __t
                local ____t_result_838
                if __t(s.boomerang) then
                    ____t_result_838 = __ge(elapsed, s.returnAfter)
                else
                    ____t_result_838 = s.boomerang
                end
                if ____t_839(____t_result_838) then
                    s.returning = true
                end
                if __t(s.returning) then
                    local dx = owner.x - s.x
                    local dy = owner.y - 33 - s.y
                    local ____t_result_842
                    local ____t_841 = __t
                    local ____hypot_result_840 = __hypot(dx, dy)
                    __O[2945] = ____hypot_result_840
                    if ____t_841(____hypot_result_840) then
                        ____t_result_842 = __O[2945]
                    else
                        ____t_result_842 = 1
                    end
                    local distance = ____t_result_842
                    s.vx = dx / distance * 540
                    s.vy = dy / distance * 540
                    if distance < 27 then
                        owner.energy = math.min(
                            100,
                            __add(owner.energy, s.returnGain)
                        )
                        if __gt(s.returnGain, 0) then
                            owner.transform = math.max(owner.transform, 0.8)
                            owner.form = "aura"
                        end
                        s.life = 0
                        __L1:effects(s.x, s.y, s.color, 5)
                    end
                end
                local ____t_844 = __t
                local ____t_result_843
                if __t(s.home) then
                    ____t_result_843 = not __t(s.returning)
                else
                    ____t_result_843 = s.home
                end
                if ____t_844(____t_result_843) then
                    local t = __L1:nearest(owner)
                    if __t(t) then
                        s.vx = s.vx + (__TS__MathSign(t.x - s.x) * 270 - s.vx) * dt * 1.5
                        s.vy = s.vy + __L1:clamp(t.y - 33 - s.y, -170, 170) * dt
                    end
                end
                if not __t(s.returning) then
                    local ____s_846, ____vy_847 = s, "vy"
                    local ____t_result_845
                    if __t(s.gravity) then
                        ____t_result_845 = s.gravity
                    else
                        ____t_result_845 = 0
                    end
                    ____s_846[____vy_847] = ____s_846[____vy_847] + ____t_result_845 * dt
                end
                s.x = s.x + s.vx * dt
                s.y = s.y + s.vy * dt
                for ____, p in __iterar((w.players)) do
                    do
                        local ____t_853 = __t
                        local ____t_result_852
                        local ____t_851 = __t
                        local ____t_result_850
                        local ____t_849 = __t
                        local ____temp_848 = p.id == s.owner
                        __O[2946] = ____temp_848
                        if ____t_849(____temp_848) then
                            ____t_result_850 = __O[2946]
                        else
                            ____t_result_850 = __call(s.hitIds, "includes", p.id)
                        end
                        __O[2947] = ____t_result_850
                        if ____t_851(____t_result_850) then
                            ____t_result_852 = __O[2947]
                        else
                            ____t_result_852 = __le(s.life, 0)
                        end
                        if ____t_853(____t_result_852) then
                            continue
                        end
                        if __t(__lt(
                            math.abs(p.x - s.x),
                            s.r + 17
                        ) and __lt(
                            math.abs(p.y - 34 - s.y),
                            s.r + 31
                        )) then
                            if __t(__L1:applyHit(
                                p,
                                __assign({}, s, {kind = "ranged"}),
                                owner
                            )) then
                                __call(s.hitIds, "push", p.id)
                                if __t(not __t(s.boomerang) and not __t(s.pierce)) then
                                    s.life = 0
                                end
                            end
                        end
                    end
                end
            end
        end
        w.shots = __call(
            w.shots,
            "filter",
            function(____, s)
                local ____t_result_858
                local ____t_857 = __t
                local ____t_result_856
                local ____t_855 = __t
                local ____temp_854 = __gt(s.life, 0) and __gt(s.x, __L1.KO.left - 150)
                __O[2948] = ____temp_854
                if ____t_855(____temp_854) then
                    ____t_result_856 = __lt(s.x, __L1.KO.right + 150)
                else
                    ____t_result_856 = __O[2948]
                end
                __O[2949] = ____t_result_856
                if ____t_857(____t_result_856) then
                    ____t_result_858 = __lt(s.y, __L1.KO.bottom + 100)
                else
                    ____t_result_858 = __O[2949]
                end
                return ____t_result_858
            end
        )
        local alive = __call(
            w.players,
            "filter",
            function(____, p) return __gt(p.stocks, 0) end
        )
        if __t(__le(
            __len(alive),
            1
        ) or __le(w.remaining, 0)) then
            w.phase = "finished"
            local ranked = __call(
                __arr(__TS__Spread(__iter(w.players))),
                "sort",
                function(____, a, b)
                    local ____t_result_863
                    local ____t_862 = __t
                    local ____t_result_861
                    local ____t_860 = __t
                    local ____temp_859 = b.stocks - a.stocks
                    __O[2950] = ____temp_859
                    if ____t_860(____temp_859) then
                        ____t_result_861 = __O[2950]
                    else
                        ____t_result_861 = a.damage - b.damage
                    end
                    __O[2951] = ____t_result_861
                    if ____t_862(____t_result_861) then
                        ____t_result_863 = __O[2951]
                    else
                        ____t_result_863 = b.kills - a.kills
                    end
                    return ____t_result_863
                end
            )
            local ____temp_866
            if __len(alive) == 1 then
                ____temp_866 = __get(alive, 0).id
            else
                local ____opt_864 = __get(ranked, 0)
                if ____opt_864 ~= nil then
                    ____opt_864 = ____opt_864.id
                end
                ____temp_866 = ____opt_864
            end
            w.winner = ____temp_866
            __L1.pendingStatus = "finished"
            __L1:showResult()
            __L1:syncNow()
        end
    end
    __L1.showResult = function(self)
        if not __t(__L1.world) then
            return
        end
        local winner = __call(
            __L1.world.players,
            "find",
            function(____, p) return p.id == __L1.world.winner end
        )
        __L1["$"](__L1, "arenaResult").hidden = false
        local ____L1__24_result_868 = __L1["$"](__L1, "arenaWinner")
        local ____t_result_867
        if __t(winner) then
            ____t_result_867 = winner.id == __L1:localId() and "VOCÊ FICOU DE PÉ!" or __add(
                __call(winner.name, "toUpperCase"),
                " LEVOU A ARENA!"
            )
        else
            ____t_result_867 = "EMPATE NA RESENHA"
        end
        ____L1__24_result_868.textContent = ____t_result_867
        local ____L1__24_result_870 = __L1["$"](__L1, "arenaResultText")
        local ____t_result_869
        if __t(winner) then
            ____t_result_869 = __add(
                __add(
                    __add(
                        __add(
                            __add(
                                __add(
                                    __add(
                                        __L1:kit(winner.character).quote,
                                        " · "
                                    ),
                                    winner.stocks
                                ),
                                " vida"
                            ),
                            winner.stocks == 1 and "" or "s"
                        ),
                        " restante"
                    ),
                    winner.stocks == 1 and "" or "s"
                ),
                "."
            )
        else
            ____t_result_869 = "Ninguém quis deixar o bolo cair."
        end
        ____L1__24_result_870.textContent = ____t_result_869
        __L1["$"](__L1, "arenaAgain").hidden = not __t(__L1:isHost())
        __L1:resetInput()
        __L1:updateHUD()
    end
    __L1.updateHUD = function(self)
        if not __t(__L1.world) then
            return
        end
        local container = __L1["$"](__L1, "arenaHUD")
        if __t(__len(container.children) ~= __len(__L1.world.players) or container.dataset.match ~= __L1.world.matchId) then
            container:replaceChildren()
            container.dataset.match = __L1.world.matchId
            __call(
                __L1.world.players,
                "forEach",
                function(____, p, slot)
                    local card = window.document:createElement("div")
                    card.className = "arena-fighter-hud"
                    card.dataset.player = p.id
                    card.dataset.slot = tostring(slot)
                    card.dataset.you = tostring(p.id == __L1:localId())
                    card.style:setProperty(
                        "--fighter",
                        __L1:kit(p.character).color
                    )
                    local circle = window.document:createElement("div")
                    circle.className = "arena-life-circle"
                    local portrait = window.document:createElement("canvas")
                    portrait.className = "arena-hud-portrait"
                    portrait.width = 64
                    portrait.height = 64
                    __L1:drawPortrait(portrait, p.character, 0, 0.76)
                    local damage = window.document:createElement("strong")
                    damage.className = "arena-damage"
                    local count = window.document:createElement("strong")
                    count.className = "arena-stock-count"
                    circle:append(portrait, damage, count)
                    local name = window.document:createElement("b")
                    name.className = "arena-hud-name"
                    name.textContent = p.name
                    local char = window.document:createElement("small")
                    char.className = "arena-hud-character"
                    char.textContent = __L1:kit(p.character).name
                    local meter = window.document:createElement("div")
                    meter.className = "arena-combo-meter"
                    do
                        local j = 0
                        while j < 3 do
                            meter:append(window.document:createElement("i"))
                            j = j + 1
                        end
                    end
                    local label = window.document:createElement("small")
                    label.className = "arena-combo-label"
                    card:append(
                        circle,
                        name,
                        char,
                        meter,
                        label
                    )
                    container:append(card)
                end
            )
        end
        for ____, p in __iterar((__L1.world.players)) do
            do
                local card = __call(
                    __arr(__TS__Spread(__iter(container.children))),
                    "find",
                    function(____, c) return c.dataset.player == p.id end
                )
                if not __t(card) then
                    continue
                end
                card.dataset.eliminated = tostring(__le(p.stocks, 0))
                local damage = card:querySelector(".arena-damage")
                damage.textContent = __add(
                    math.floor(p.damage + 0.5),
                    "%"
                )
                damage.dataset.tier = tostring(math.min(
                    4,
                    math.floor(p.damage / 45)
                ))
                local ____self_878 = card.style
                local ____self_878_setProperty_879 = ____self_878.setProperty
                local ____t_result_877
                local ____t_876 = __t
                local ____opt_873 = window.ArenaCombat
                if ____opt_873 ~= nil then
                    ____opt_873 = ____opt_873.damageColor
                end
                local ____opt_result_875
                if ____opt_873 ~= nil then
                    ____opt_result_875 = ____opt_873(____opt_873, p.damage)
                end
                __O[2952] = ____opt_result_875
                if ____t_876(____opt_result_875) then
                    ____t_result_877 = __O[2952]
                else
                    ____t_result_877 = "#fffdf0"
                end
                ____self_878_setProperty_879(____self_878, "--damage", ____t_result_877)
                card:querySelector(".arena-stock-count").textContent = __add(
                    math.max(0, p.stocks),
                    "x"
                )
                card:setAttribute(
                    "aria-label",
                    __add(
                        __add(
                            __add(
                                __add(
                                    __add(p.name, ": "),
                                    p.stocks
                                ),
                                " vidas, "
                            ),
                            math.floor(p.damage + 0.5)
                        ),
                        "% de dano"
                    )
                )
                __call(
                    __arr(__TS__Spread(__iter(card:querySelectorAll(".arena-combo-meter i")))),
                    "forEach",
                    function(____, s, j) return s.classList:toggle(
                        "filled",
                        __lt(j, p.comboHits)
                    ) end
                )
                card:querySelector(".arena-combo-label").textContent = __le(p.stocks, 0) and "ASSISTINDO" or (__gt(p.respawn, 0) and "VOLTANDO…" or (__ge(p.comboHits, 3) and "COMBO PRONTO" or __add(p.comboHits, "/3 ACERTOS")))
            end
        end
        local ____local = __call(
            __L1.world.players,
            "find",
            function(____, p) return p.id == __L1:localId() end
        )
        local ____t_result_882
        local ____t_881 = __t
        local ____temp_880 = not not __t(____local) and __gt(____local.stocks, 0)
        __O[2953] = ____temp_880
        if ____t_881(____temp_880) then
            ____t_result_882 = __ge(____local.comboHits, 3)
        else
            ____t_result_882 = __O[2953]
        end
        local readyCombo = ____t_result_882
        __L1.screen.classList:toggle(
            "is-spectating",
            not not __t(____local) and __le(____local.stocks, 0)
        )
        __L1["$"](__L1, "arenaSpectator").hidden = not __t(____local) or __gt(____local.stocks, 0)
        __L1["$"](__L1, "arenaComboReady").hidden = not __t(readyCombo)
        __L1["$"](__L1, "arenaComboButton").classList:toggle(
            "locked",
            not __t(readyCombo)
        )
        __L1["$"](__L1, "arenaComboButton"):setAttribute(
            "aria-disabled",
            tostring(not __t(readyCombo))
        )
        __L1["$"](__L1, "arenaComboReady").textContent = __add(
            __L1:keyLabel("reeis", "R"),
            " · COMBO LIBERADO"
        )
    end
    __L1.motionOptions = function(self, p, emit)
        if emit == nil then
            emit = false
        end
        local ____assign_896 = __assign
        local ____temp_894 = {}
        local ____t_result_885
        local ____t_884 = __t
        local ____table_speed_883 = __L1:kit(p.character).speed
        __O[2954] = ____table_speed_883
        if ____t_884(____table_speed_883) then
            ____t_result_885 = __O[2954]
        else
            ____t_result_885 = 1
        end
        local ____t_result_892
        local ____t_891 = __t
        local ____opt_888 = window.ControlSettings
        if ____opt_888 ~= nil then
            ____opt_888 = ____opt_888.getState
        end
        local ____opt_result_890
        if ____opt_888 ~= nil then
            ____opt_result_890 = ____opt_888(____opt_888).sensitivity
        end
        __O[2955] = ____opt_result_890
        if ____t_891(____opt_result_890) then
            ____t_result_892 = __O[2955]
        else
            ____t_result_892 = 1
        end
        local ____temp_895 = {speed = ____t_result_885, response = ____t_result_892, platforms = __L1.STAGE}
        local ____t_result_893
        if __t(emit) then
            ____t_result_893 = {emit = function(____, name, actor) return __L1:emitEvent(
                name,
                actor.x,
                actor.y - 25,
                {
                    color = __L1:kit(actor.character).color,
                    sound = __t(name == "wallJump" or name == "doubleJump") and "jump" or name
                }
            ) end}
        else
            ____t_result_893 = {}
        end
        return ____assign_896(____temp_894, ____temp_895, ____t_result_893)
    end
    __L1.cloneMover = function(self, p)
        local ____t_result_897
        if __t(p) then
            ____t_result_897 = __assign(
                {},
                p,
                {used = __assign({}, p.used)}
            )
        else
            ____t_result_897 = nil
        end
        return ____t_result_897
    end
    __L1.reconcilePrediction = function(self, p, old)
        if not __t(p) then
            return
        end
        local ____t_904 = __t
        local ____t_result_903
        local ____t_901 = __t
        local ____t_result_900
        local ____t_899 = __t
        local ____temp_898 = not __t(__L1:playing()) or __le(p.stocks, 0)
        __O[2956] = ____temp_898
        if ____t_899(____temp_898) then
            ____t_result_900 = __O[2956]
        else
            ____t_result_900 = __gt(p.respawn, 0)
        end
        __O[2957] = ____t_result_900
        if ____t_901(____t_result_900) then
            ____t_result_903 = __O[2957]
        else
            local ____t_result_902
            if __t(old) then
                ____t_result_902 = old.stocks ~= p.stocks
            else
                ____t_result_902 = old
            end
            ____t_result_903 = ____t_result_902
        end
        if ____t_904(____t_result_903) then
            __L1.prediction = __L1:cloneMover(p)
            __L1.predictionHistory = __arrL({}, 0)
            __L1.predictionAccumulator = 0
            return
        end
        local ____t_result_907
        local ____t_906 = __t
        local ____TS__Number_result_905 = __TS__Number(p.ackInput)
        __O[2958] = ____TS__Number_result_905
        if ____t_906(____TS__Number_result_905) then
            ____t_result_907 = __O[2958]
        else
            ____t_result_907 = 0
        end
        local ack = ____t_result_907
        __L1.predictionHistory = __call(
            __L1.predictionHistory,
            "filter",
            function(____, frame) return __gt(frame.seq, ack) end
        )
        __L1.prediction = __L1:cloneMover(p)
        for ____, frame in __iterar((__L1.predictionHistory)) do
            window.ArenaMotion:step(
                __L1.prediction,
                frame.command,
                frame.dt,
                __L1:motionOptions(__L1.prediction)
            )
        end
    end
    __L1.predict = function(self, dt)
        local ____t_918 = __t
        local ____t_result_917
        local ____t_911 = __t
        local ____t_result_910
        local ____t_909 = __t
        local ____temp_908 = __L1:isHost()
        __O[2959] = ____temp_908
        if ____t_909(____temp_908) then
            ____t_result_910 = __O[2959]
        else
            ____t_result_910 = not __t(__L1:playing())
        end
        __O[2960] = ____t_result_910
        if ____t_911(____t_result_910) then
            ____t_result_917 = __O[2960]
        else
            local ____opt_914 = __L1.controls
            if ____opt_914 ~= nil then
                ____opt_914 = ____opt_914.isEditing
            end
            local ____opt_result_916
            if ____opt_914 ~= nil then
                ____opt_result_916 = ____opt_914(____opt_914)
            end
            ____t_result_917 = ____opt_result_916
        end
        if ____t_918(____t_result_917) then
            return
        end
        local p = __call(
            __L1.world.players,
            "find",
            function(____, p) return p.id == __L1:localId() end
        )
        local ____t_922 = __t
        local ____t_result_921
        local ____t_920 = __t
        local ____temp_919 = not __t(p) or __le(p.stocks, 0)
        __O[2961] = ____temp_919
        if ____t_920(____temp_919) then
            ____t_result_921 = __O[2961]
        else
            ____t_result_921 = __gt(p.respawn, 0)
        end
        if ____t_922(____t_result_921) then
            return
        end
        if not __t(__L1.prediction) then
            __L1.prediction = __L1:cloneMover(p)
        end
        __L1.predictionAccumulator = __L1.predictionAccumulator + dt
        do
            local n = 0
            while __t(__L1.predictionAccumulator >= __L1.STEP and n < 4) do
                local ____assign_927 = __assign
                local ____temp_926 = {}
                local ____L1_923, ____inputSeq_924 = __L1, "inputSeq"
                local ____L1_inputSeq_925 = ____L1_923[____inputSeq_924] + 1
                ____L1_923[____inputSeq_924] = ____L1_inputSeq_925
                local command = ____assign_927(____temp_926, {seq = ____L1_inputSeq_925}, __L1.input)
                window.ArenaMotion:step(
                    __L1.prediction,
                    command,
                    __L1.STEP,
                    __L1:motionOptions(__L1.prediction)
                )
                __call(__L1.predictionHistory, "push", {seq = command.seq, command = command, dt = __L1.STEP})
                __L1.predictionAccumulator = __L1.predictionAccumulator - __L1.STEP
                n = n + 1
            end
        end
        if __len(__L1.predictionHistory) > 240 then
            __call(
                __L1.predictionHistory,
                "splice",
                0,
                __len(__L1.predictionHistory) - 240
            )
        end
        if __t(__L1.localAttack) then
            __L1.localAttack.left = math.max(0, __L1.localAttack.left - dt)
            if __le(__L1.localAttack.left, 0) then
                __L1.localAttack = nil
            end
        end
    end
    __L1.visualPosition = function(self, p, dt)
        local shown = __call(__L1.displayWorld, "get", p.id)
        if not __t(shown) then
            shown = {x = p.x, y = p.y}
            __call(__L1.displayWorld, "set", p.id, shown)
        end
        if __t(__L1:isHost()) then
            __assign(shown, p)
            return shown
        end
        local ____t_937 = __t
        local ____t_result_936
        local ____t_935 = __t
        local ____t_result_934
        local ____t_933 = __t
        local ____t_result_932
        local ____t_931 = __t
        local ____t_result_930
        local ____t_929 = __t
        local ____temp_928 = p.id == __L1:localId()
        __O[2962] = ____temp_928
        if ____t_929(____temp_928) then
            ____t_result_930 = __L1.prediction
        else
            ____t_result_930 = __O[2962]
        end
        __O[2963] = ____t_result_930
        if ____t_931(____t_result_930) then
            ____t_result_932 = __gt(p.stocks, 0)
        else
            ____t_result_932 = __O[2963]
        end
        __O[2964] = ____t_result_932
        if ____t_933(____t_result_932) then
            ____t_result_934 = __le(p.respawn, 0)
        else
            ____t_result_934 = __O[2964]
        end
        __O[2965] = ____t_result_934
        if ____t_935(____t_result_934) then
            ____t_result_936 = __L1:playing()
        else
            ____t_result_936 = __O[2965]
        end
        if ____t_937(____t_result_936) then
            local ____error = __hypot(shown.x - __L1.prediction.x, shown.y - __L1.prediction.y)
            local snap = ____error > 230 or __gt(p.stun, 0)
            if __t(snap) then
                shown.x = __L1.prediction.x
                shown.y = __L1.prediction.y
            else
                local factor = math.min(1, dt * 32)
                shown.x = shown.x + (__L1.prediction.x - shown.x) * factor
                shown.y = shown.y + (__L1.prediction.y - shown.y) * factor
            end
            for ____, key in __iterar((__arrL({
                "vx",
                "vy",
                "ground",
                "jumps",
                "dashTime",
                "dashCD",
                "motion",
                "motionTime",
                "wallSide",
                "wallGrip",
                "wallKick",
                "jumpAnim",
                "landTimer",
                "landed",
                "facing"
            }, 15))) do
                __set(
                    shown,
                    key,
                    __get(__L1.prediction, key)
                )
            end
            if __t(__L1.localAttack) then
                shown.attackAnim = __L1.localAttack.left
                shown.attackType = __L1.localAttack.kind
                shown.attackShape = __L1.localAttack.shape
                shown.attackDirection = __L1.localAttack.dir
                shown.attackProgress = 1 - __L1.localAttack.left / __L1.localAttack.total
            else
                local ____t_939 = __t
                local ____t_result_938
                if __t(shown.localAttackAt) then
                    ____t_result_938 = window.performance:now() - shown.localAttackAt < 1500
                else
                    ____t_result_938 = shown.localAttackAt
                end
                if ____t_939(____t_result_938) then
                    shown.attackAnim = 0
                    shown.attackProgress = 0
                end
            end
            return shown
        end
        local targetAt = window.performance:now() - __L1:clamp(100 + __L1.rttMs * 0.2, 100, 220)
        local before = nil
        local after = nil
        for ____, frame in __iterar((__L1.remoteFrames)) do
            if __le(frame.at, targetAt) then
                before = frame
            else
                after = frame
                break
            end
        end
        local ____callq_943 = __callq
        local ____opt_result_942
        if before ~= nil then
            ____opt_result_942 = before.players
        end
        local a = ____callq_943(
            ____opt_result_942,
            "find",
            function(____, v) return v.id == p.id end
        )
        local ____callq_947 = __callq
        local ____opt_result_946
        if after ~= nil then
            ____opt_result_946 = after.players
        end
        local b = ____callq_947(
            ____opt_result_946,
            "find",
            function(____, v) return v.id == p.id end
        )
        local x = p.x
        local y = p.y
        local ____t_957 = __t
        local ____t_result_956
        local ____t_955 = __t
        local ____t_result_954
        local ____t_953 = __t
        local ____t_result_952
        local ____t_951 = __t
        local ____t_result_950
        local ____t_949 = __t
        local ____t_result_948
        if __t(a) then
            ____t_result_948 = b
        else
            ____t_result_948 = a
        end
        __O[2966] = ____t_result_948
        if ____t_949(____t_result_948) then
            ____t_result_950 = a.stocks == b.stocks
        else
            ____t_result_950 = __O[2966]
        end
        __O[2967] = ____t_result_950
        if ____t_951(____t_result_950) then
            ____t_result_952 = __le(a.respawn, 0)
        else
            ____t_result_952 = __O[2967]
        end
        __O[2968] = ____t_result_952
        if ____t_953(____t_result_952) then
            ____t_result_954 = __le(b.respawn, 0)
        else
            ____t_result_954 = __O[2968]
        end
        __O[2969] = ____t_result_954
        if ____t_955(____t_result_954) then
            ____t_result_956 = __hypot(b.x - a.x, b.y - a.y) < 260
        else
            ____t_result_956 = __O[2969]
        end
        if ____t_957(____t_result_956) then
            local ____L1_clamp_962 = __L1.clamp
            local ____temp_961 = targetAt - before.at
            local ____t_result_960
            local ____t_959 = __t
            local ____temp_958 = after.at - before.at
            __O[2970] = ____temp_958
            if ____t_959(____temp_958) then
                ____t_result_960 = __O[2970]
            else
                ____t_result_960 = 1
            end
            local amount = ____L1_clamp_962(__L1, ____temp_961 / ____t_result_960, 0, 1)
            x = a.x + (b.x - a.x) * amount
            y = a.y + (b.y - a.y) * amount
        else
            local ____t_966 = __t
            local ____t_result_965
            local ____t_964 = __t
            local ____t_result_963
            if __t(a) then
                ____t_result_963 = not __t(b)
            else
                ____t_result_963 = a
            end
            __O[2971] = ____t_result_963
            if ____t_964(____t_result_963) then
                ____t_result_965 = __le(a.respawn, 0)
            else
                ____t_result_965 = __O[2971]
            end
            if ____t_966(____t_result_965) then
                local age = __L1:clamp((targetAt - before.at) / 1000, 0, 0.15)
                x = a.x + a.vx * age
                y = a.y + a.vy * age
            end
        end
        local factor = __hypot(x - shown.x, y - shown.y) > 250 and 1 or math.min(1, dt * 22)
        shown.x = shown.x + (x - shown.x) * factor
        shown.y = shown.y + (y - shown.y) * factor
        local ____t_result_969
        local ____t_968 = __t
        local ____TS__Number_result_967 = __TS__Number(p.motionTime)
        __O[2972] = ____TS__Number_result_967
        if ____t_968(____TS__Number_result_967) then
            ____t_result_969 = __O[2972]
        else
            ____t_result_969 = 0
        end
        local sourcePoseTime = ____t_result_969
        local ____t_result_973
        local ____t_971 = __t
        local ____temp_970 = shown.motion ~= p.motion or shown.visualStock ~= p.stocks
        __O[2973] = ____temp_970
        if ____t_971(____temp_970) then
            ____t_result_973 = __O[2973]
        else
            local ____t_result_972
            if __t(shown.sourcePoseTime) then
                ____t_result_972 = shown.sourcePoseTime
            else
                ____t_result_972 = 0
            end
            ____t_result_973 = sourcePoseTime < ____t_result_972 - 0.08
        end
        local poseChanged = ____t_result_973
        local ____shown_978 = shown
        local ____t_result_977
        if __t(poseChanged) then
            ____t_result_977 = sourcePoseTime
        else
            local ____add_976 = __add
            local ____t_result_974
            if __t(shown.motionTime) then
                ____t_result_974 = shown.motionTime
            else
                ____t_result_974 = 0
            end
            local ____t_result_975
            if __t(__L1:playing()) then
                ____t_result_975 = dt
            else
                ____t_result_975 = 0
            end
            ____t_result_977 = math.max(
                sourcePoseTime,
                ____add_976(____t_result_974, ____t_result_975)
            )
        end
        ____shown_978.motionTime = ____t_result_977
        shown.sourcePoseTime = sourcePoseTime
        shown.visualStock = p.stocks
        for ____, key in __iterar((__arrL({
            "vx",
            "vy",
            "ground",
            "jumps",
            "dashTime",
            "dashCD",
            "motion",
            "wallSide",
            "wallGrip",
            "wallKick",
            "jumpAnim",
            "landTimer",
            "landed",
            "facing"
        }, 14))) do
            __set(
                shown,
                key,
                __get(p, key)
            )
        end
        local ____opt_979 = p.attackState
        if ____opt_979 ~= nil then
            ____opt_979 = ____opt_979.id
        end
        local ____opt_979_981 = ____opt_979
        if ____opt_979_981 == nil then
            ____opt_979_981 = nil
        end
        local swing = ____opt_979_981
        local newSwing = shown.visualSwing ~= swing
        if __t(newSwing) then
            shown.visualSwing = swing
            local ____shown_985 = shown
            local ____t_result_984
            local ____t_983 = __t
            local ____TS__Number_result_982 = __TS__Number(p.attackAnim)
            __O[2974] = ____TS__Number_result_982
            if ____t_983(____TS__Number_result_982) then
                ____t_result_984 = __O[2974]
            else
                ____t_result_984 = 0
            end
            ____shown_985.attackAnim = ____t_result_984
        else
            local ____shown_991 = shown
            local ____t_result_988
            local ____t_987 = __t
            local ____TS__Number_result_986 = __TS__Number(p.attackAnim)
            __O[2975] = ____TS__Number_result_986
            if ____t_987(____TS__Number_result_986) then
                ____t_result_988 = __O[2975]
            else
                ____t_result_988 = 0
            end
            local ____t_result_989
            if __t(shown.attackAnim) then
                ____t_result_989 = shown.attackAnim
            else
                ____t_result_989 = 0
            end
            local ____t_result_990
            if __t(__L1:playing()) then
                ____t_result_990 = dt
            else
                ____t_result_990 = 0
            end
            ____shown_991.attackAnim = math.max(
                0,
                math.min(____t_result_988, ____t_result_989 - ____t_result_990)
            )
        end
        local ____shown_996 = shown
        local ____gt_result_995
        if __gt(shown.attackAnim, 0) then
            local ____L1_clamp_994 = __L1.clamp
            local ____shown_attackAnim_993 = shown.attackAnim
            local ____t_result_992
            if __t(p.attackTotal) then
                ____t_result_992 = p.attackTotal
            else
                ____t_result_992 = 0.5
            end
            ____gt_result_995 = ____L1_clamp_994(__L1, 1 - ____shown_attackAnim_993 / ____t_result_992, 0, 1)
        else
            ____gt_result_995 = 0
        end
        ____shown_996.attackProgress = ____gt_result_995
        return shown
    end
    __L1.cameraViewport = function(self)
        local top = __L1.safeInsets.top + (__L1.W < 421 and 91 or 51)
        local ____L1_safeInsets_bottom_998 = __L1.safeInsets.bottom
        local ____t_result_997
        if __t(window:matchMedia("(pointer:coarse)").matches) then
            ____t_result_997 = __L1:clamp(__L1.H * 0.25, 56, 130)
        else
            ____t_result_997 = 14
        end
        local bottom = ____L1_safeInsets_bottom_998 + ____t_result_997
        return {
            top = top,
            bottom = bottom,
            height = math.max(100, __L1.H - top - bottom),
            center = (top + __L1.H - bottom) / 2
        }
    end
    __L1.updateCamera = function(self, dt, positions)
        local alive = __call(
            __L1.world.players,
            "filter",
            function(____, p) return __gt(p.stocks, 0) and __le(p.respawn, 0) end
        )
        if not __t(__len(alive)) then
            return
        end
        local points = __call(
            alive,
            "map",
            function(____, p)
                local ____t_result_1001
                local ____t_1000 = __t
                local ____call_result_999 = __call(positions, "get", p.id)
                __O[2976] = ____call_result_999
                if ____t_1000(____call_result_999) then
                    ____t_result_1001 = __O[2976]
                else
                    ____t_result_1001 = p
                end
                return ____t_result_1001
            end
        )
        local left = math.min(__TS__Spread(__iter(__call(
            points,
            "map",
            function(____, p) return p.x end
        )))) - 100
        local right = math.max(__TS__Spread(__iter(__call(
            points,
            "map",
            function(____, p) return p.x end
        )))) + 100
        local top = math.min(__TS__Spread(__iter(__call(
            points,
            "map",
            function(____, p) return p.y end
        )))) - 154
        local bottom = math.max(__TS__Spread(__iter(__call(
            points,
            "map",
            function(____, p) return p.y end
        )))) + 54
        local view = __L1:cameraViewport()
        local width = math.max(440, right - left)
        local height = math.max(235, bottom - top)
        local fit = math.min(__L1.W / width, view.height / height)
        local zoom = math.min(__L1.W > 900 and 1.3 or 1.65, fit)
        local targetX = (left + right) / 2
        local targetY = (top + bottom) / 2
        if zoom < __L1.camera.zoom then
            __L1.camera.zoom = zoom
        else
            local ____L1_camera_1002, ____zoom_1003 = __L1.camera, "zoom"
            ____L1_camera_1002[____zoom_1003] = ____L1_camera_1002[____zoom_1003] + (zoom - __L1.camera.zoom) * math.min(1, dt * 2.8)
        end
        local ____L1_camera_1004, ____x_1005 = __L1.camera, "x"
        ____L1_camera_1004[____x_1005] = ____L1_camera_1004[____x_1005] + (targetX - __L1.camera.x) * math.min(1, dt * 5)
        local ____L1_camera_1006, ____y_1007 = __L1.camera, "y"
        ____L1_camera_1006[____y_1007] = ____L1_camera_1006[____y_1007] + (targetY - __L1.camera.y) * math.min(1, dt * 5)
        local halfW = __L1.W / (2 * __L1.camera.zoom)
        local halfH = view.height / (2 * __L1.camera.zoom)
        local minCX = right - halfW
        local maxCX = left + halfW
        local minCY = bottom - halfH
        local maxCY = top + halfH
        if minCX <= maxCX then
            __L1.camera.x = __L1:clamp(__L1.camera.x, minCX, maxCX)
        end
        if minCY <= maxCY then
            __L1.camera.y = __L1:clamp(__L1.camera.y, minCY, maxCY)
        end
        __L1.world.camera = __assign({}, __L1.camera)
    end
    __L1.resizeCanvas = function(self)
        local canvas = __L1["$"](__L1, "arenaCanvas")
        local rect = canvas:getBoundingClientRect()
        __L1.W = math.max(
            240,
            math.floor(rect.width + 0.5)
        )
        __L1.H = math.max(
            150,
            math.floor(rect.height + 0.5)
        )
        local ____t_result_1008
        if __t(window.devicePixelRatio) then
            ____t_result_1008 = window.devicePixelRatio
        else
            ____t_result_1008 = 1
        end
        __L1.pixelRatio = math.min(1.5, ____t_result_1008)
        local width = math.floor(__L1.W * __L1.pixelRatio + 0.5)
        local height = math.floor(__L1.H * __L1.pixelRatio + 0.5)
        if __t(canvas.width ~= width or canvas.height ~= height) then
            canvas.width = width
            canvas.height = height
            local style = window:getComputedStyle(__L1.screen)
            for ____, side in __iterar((__arrL({"top", "right", "bottom", "left"}, 4))) do
                local ____set_1013 = __set
                local ____L1_safeInsets_1012 = __L1.safeInsets
                local ____t_result_1011
                local ____t_1010 = __t
                local ____TS__ParseFloat_result_1009 = __TS__ParseFloat(style:getPropertyValue(__add("--arena-safe-", side)))
                __O[2977] = ____TS__ParseFloat_result_1009
                if ____t_1010(____TS__ParseFloat_result_1009) then
                    ____t_result_1011 = __O[2977]
                else
                    ____t_result_1011 = 0
                end
                ____set_1013(____L1_safeInsets_1012, side, ____t_result_1011)
            end
        end
        local c = canvas:getContext("2d")
        c:setTransform(
            __L1.pixelRatio,
            0,
            0,
            __L1.pixelRatio,
            0,
            0
        )
        return c
    end
    __L1.renderTime = function(self)
        if __L1.visualMatch ~= __L1.world.matchId then
            __L1.visualMatch = __L1.world.matchId
            __L1.visualClock = __L1.world.time
        end
        local ____t_1024 = __t
        local ____t_result_1023
        local ____t_1015 = __t
        local ____temp_1014 = __L1:playing()
        __O[2978] = ____temp_1014
        if ____t_1015(____temp_1014) then
            local ____t_1022 = __t
            local ____t_result_1021
            if __t(__L1.practice) then
                local ____opt_1018 = __L1.controls
                if ____opt_1018 ~= nil then
                    ____opt_1018 = ____opt_1018.isEditing
                end
                local ____opt_result_1020
                if ____opt_1018 ~= nil then
                    ____opt_result_1020 = ____opt_1018(____opt_1018)
                end
                ____t_result_1021 = ____opt_result_1020
            else
                ____t_result_1021 = __L1.practice
            end
            ____t_result_1023 = not ____t_1022(____t_result_1021)
        else
            ____t_result_1023 = __O[2978]
        end
        if ____t_1024(____t_result_1023) then
            __L1.visualClock = math.max(__L1.world.time, __L1.visualClock + __L1.renderDt)
        else
            __L1.visualClock = __L1.world.time
        end
        return __L1.visualClock
    end
    __L1.drawText = function(self, c, text, x, y, size, color, align)
        if size == nil then
            size = 14
        end
        if color == nil then
            color = "#fff3d4"
        end
        if align == nil then
            align = "center"
        end
        c.fillStyle = color
        c.font = __add(
            __add("bold ", size),
            "px \"Trebuchet MS\",sans-serif"
        )
        c.textAlign = align
        c.textBaseline = "middle"
        c:fillText(text, x, y)
    end
    __L1.drawFighterName = function(self, c, p, x, y)
        local ____temp_1026
        if p.id == __L1:localId() then
            ____temp_1026 = "Você"
        else
            local ____t_result_1025
            if __t(__call(p.id, "startsWith", "bot-")) then
                ____t_result_1025 = __L1:kit(p.character).name
            else
                ____t_result_1025 = p.name
            end
            ____temp_1026 = ____t_result_1025
        end
        local raw = ____temp_1026
        local ____gt_result_1027
        if __gt(
            __len(raw),
            11
        ) then
            ____gt_result_1027 = __add(
                __call(raw, "slice", 0, 10),
                "…"
            )
        else
            ____gt_result_1027 = raw
        end
        local name = ____gt_result_1027
        local size = __L1:clamp(10 / __L1.camera.zoom, 6, 18)
        c.font = __add(
            __add("bold ", size),
            "px \"Trebuchet MS\",sans-serif"
        )
        c.textAlign = "center"
        c.textBaseline = "middle"
        c.lineWidth = 2 / __L1.camera.zoom
        c.strokeStyle = "#203d48cc"
        c:strokeText(name, x, y)
        c.fillStyle = "#fff4d1"
        c:fillText(name, x, y)
    end
    __L1.draw = function(self)
        if not __t(__L1.opened) then
            return
        end
        if not __t(__L1.world) then
            if __t(__L1["$"](__L1, "arenaPortrait")) then
                __L1:drawPortrait(
                    __L1["$"](__L1, "arenaPortrait"),
                    __L1.selected,
                    window.performance:now() / 1000
                )
            end
            return
        end
        local c = __L1:resizeCanvas()
        local w = __L1.world
        local t = __L1:renderTime()
        c.imageSmoothingEnabled = false
        if not __TS__InstanceOf(__L1.displayWorld, Map) then
            __L1.displayWorld = __TS__New(Map)
        end
        local positions = __TS__New(
            Map,
            __call(
                w.players,
                "map",
                function(____, p) return __arrL(
                    {
                        p.id,
                        __L1:visualPosition(p, __L1.renderDt)
                    },
                    2
                ) end
            )
        )
        __L1:updateCamera(__L1.renderDt, positions)
        local ____t_1030 = __t
        local ____opt_1028 = window.ArenaArt
        if ____opt_1028 ~= nil then
            ____opt_1028 = ____opt_1028.drawBackground
        end
        if ____t_1030(____opt_1028) then
            window.ArenaArt:drawBackground(
                c,
                __L1.camera,
                t,
                __L1.W,
                __L1.H
            )
        else
            local sky = c:createLinearGradient(0, 0, 0, __L1.H)
            sky:addColorStop(0, "#389ed8")
            sky:addColorStop(1, "#c5eacb")
            c.fillStyle = sky
            c:fillRect(0, 0, __L1.W, __L1.H)
        end
        c:save()
        do
            local sx = (math.random() - 0.5) * 2 * __L1.shakeAmount
            local sy = (math.random() - 0.5) * 2 * __L1.shakeAmount
            c:translate(
                math.floor(sx + 0.5),
                math.floor(sy + 0.5)
            )
        end
        c:translate(
            __L1.W / 2,
            __L1:cameraViewport().center
        )
        c:scale(__L1.camera.zoom, __L1.camera.zoom)
        c:translate(
            __TS__Number(-__L1.camera.x),
            __TS__Number(-__L1.camera.y)
        )
        local ____t_1033 = __t
        local ____opt_1031 = window.ArenaArt
        if ____opt_1031 ~= nil then
            ____opt_1031 = ____opt_1031.drawStage
        end
        if ____t_1033(____opt_1031) then
            window.ArenaArt:drawStage(c, __L1.STAGE, t)
        else
            for ____, s in __iterar((__L1.STAGE)) do
                c.fillStyle = __t(s.main) and "#608c45" or "#c18a4c"
                c:fillRect(
                    s.x,
                    s.y,
                    s.w,
                    __t(s.main) and 35 or 13
                )
            end
        end
        for ____, s in __iterar((w.shots)) do
            local ____t_1036 = __t
            local ____opt_1034 = window.ArenaArt
            if ____opt_1034 ~= nil then
                ____opt_1034 = ____opt_1034.drawProjectile
            end
            if ____t_1036(____opt_1034) then
                window.ArenaArt:drawProjectile(c, s, t)
            else
                c.fillStyle = s.color
                c:fillRect(s.x - 6, s.y - 6, 12, 12)
            end
        end
        for ____, p in __iterar((__call(
            __arr(__TS__Spread(__iter(w.players))),
            "sort",
            function(____, a, b) return a.y - b.y end
        ))) do
            do
                if __t(__le(p.stocks, 0) or __gt(p.respawn, 0)) then
                    continue
                end
                local pos = __call(positions, "get", p.id)
                local view = __assign({}, p, pos, {x = pos.x, y = pos.y})
                local ____t_1039 = __t
                local ____opt_1037 = window.ArenaArt
                if ____opt_1037 ~= nil then
                    ____opt_1037 = ____opt_1037.drawFighter
                end
                if ____t_1039(____opt_1037) then
                    window.ArenaArt:drawFighter(c, view, t)
                else
                    c.fillStyle = __L1:kit(p.character).color
                    c:fillRect(view.x - 15, view.y - (p.character == "lucas" and 60 or 70), 30, p.character == "lucas" and 60 or 70)
                end
                if p.id == __L1:localId() then
                    c.fillStyle = "#fff4c1"
                    c:beginPath()
                    c:moveTo(view.x - 7, view.y - 94)
                    c:lineTo(view.x + 7, view.y - 94)
                    c:lineTo(view.x, view.y - 85)
                    __call(c, "fill")
                end
                __L1:drawFighterName(c, p, view.x, view.y - 105)
            end
        end
        for ____, e in __iterar((__L1.effectFrames)) do
            do
                if __t(math.abs(e.x - __L1.camera.x) > __L1.W / __L1.camera.zoom * 0.65 + 130 or math.abs(e.y - __L1.camera.y) > __L1.H / __L1.camera.zoom * 0.7 + 130) then
                    continue
                end
                if e.type == "spark" then
                    c.fillStyle = e.color
                    c:fillRect(
                        math.floor(e.x + 0.5),
                        math.floor(e.y + 0.5),
                        3,
                        3
                    )
                else
                    local ____t_1042 = __t
                    local ____opt_1040 = window.ArenaArt
                    if ____opt_1040 ~= nil then
                        ____opt_1040 = ____opt_1040.drawEffect
                    end
                    if ____t_1042(____opt_1040) then
                        window.ArenaArt:drawEffect(c, e, t)
                    end
                end
            end
        end
        c:restore()
        if __L1.flashAmount > 0.01 then
            c:save()
            c.globalAlpha = math.min(0.5, __L1.flashAmount)
            c.fillStyle = __L1.flashColor
            c:fillRect(0, 0, __L1.W, __L1.H)
            c:restore()
        end
        __L1.shakeAmount = __L1.shakeAmount * math.exp(__TS__Number(-__L1.renderDt) * 14)
        if __L1.shakeAmount < 0.3 then
            __L1.shakeAmount = 0
        end
        __L1.flashAmount = __L1.flashAmount * math.exp(__TS__Number(-__L1.renderDt) * 9)
        local count = __L1["$"](__L1, "arenaCountdown")
        local ____temp_1043
        if __L1.world.phase == "countdown" then
            ____temp_1043 = math.max(
                0,
                (__L1.world.startAt - window.Date:now() - __L1.serverOffset) / 1000
            )
        else
            ____temp_1043 = 0
        end
        local remaining = ____temp_1043
        count.hidden = __L1.world.phase ~= "countdown" and window.performance:now() > __L1.goUntil
        if not __t(count.hidden) then
            local ____temp_1046 = count:querySelector(".arena-countdown-number")
            local ____temp_1045
            if remaining > 3 then
                ____temp_1045 = ""
            else
                local ____temp_1044
                if remaining > 0 then
                    ____temp_1044 = math.ceil(remaining)
                else
                    ____temp_1044 = "VAI!"
                end
                ____temp_1045 = ____temp_1044
            end
            ____temp_1046.textContent = ____temp_1045
            count:querySelector(".arena-countdown-label").textContent = remaining > 3 and "PREPARE O CHAPÉU" or (remaining > 0 and "A RESENHA VAI COMEÇAR" or "")
        end
        __L1:updateHUD()
        local seconds = math.ceil(w.remaining)
        __L1["$"](__L1, "arenaRoundClock").textContent = __add(
            __add(
                math.floor(seconds / 60),
                ":"
            ),
            __call(
                tostring(__mod(seconds, 60)),
                "padStart",
                2,
                "0"
            )
        )
        __L1["$"](__L1, "arenaRoundClock").classList:toggle(
            "urgent",
            __lt(w.remaining, 30)
        )
        local ____opt_1049 = __L1.net
        if ____opt_1049 ~= nil then
            ____opt_1049 = ____opt_1049.getStatus
        end
        local ____opt_result_1051
        if ____opt_1049 ~= nil then
            ____opt_result_1051 = ____opt_1049(____opt_1049)
        end
        local link = ____opt_result_1051
        local ____L1__24_result_1063 = __L1["$"](__L1, "arenaMatchCode")
        local ____t_result_1062
        if __t(__L1.practice) then
            ____t_result_1062 = "TREINO · 3 VIDAS"
        else
            local ____add_1061 = __add
            local ____add_1055 = __add
            local ____add_1054 = __add
            local ____opt_1052 = __L1.room
            if ____opt_1052 ~= nil then
                ____opt_1052 = ____opt_1052.code
            end
            local ____add_1055_result_1060 = ____add_1055(
                ____add_1054("SALA ", ____opt_1052),
                " · "
            )
            local ____gt_1059 = __gt
            local ____opt_result_1058
            if link ~= nil then
                ____opt_result_1058 = link.connected
            end
            ____t_result_1062 = ____add_1061(
                ____add_1055_result_1060,
                ____gt_1059(____opt_result_1058, 0) and "CONEXÃO DIRETA" or "ONLINE"
            )
        end
        ____L1__24_result_1063.textContent = ____t_result_1062
    end
    __L1.frame = function(self, now)
        if not __t(__L1.opened) then
            return
        end
        local ____L1_clamp_1065 = __L1.clamp
        local ____t_result_1064
        if __t(__L1.lastFrame) then
            ____t_result_1064 = (now - __L1.lastFrame) / 1000
        else
            ____t_result_1064 = __L1.STEP
        end
        local dt = ____L1_clamp_1065(__L1, ____t_result_1064, 0, 0.05)
        __L1.lastFrame = now
        __L1.renderDt = dt
        __L1:pumpInput()
        local ____t_1083 = __t
        local ____t_result_1082
        local ____t_1078 = __t
        local ____t_result_1077
        local ____t_1069 = __t
        local ____t_result_1068
        local ____t_1067 = __t
        local ____temp_1066 = __L1:isHost()
        __O[2979] = ____temp_1066
        if ____t_1067(____temp_1066) then
            ____t_result_1068 = __L1:inMatch()
        else
            ____t_result_1068 = __O[2979]
        end
        __O[2980] = ____t_result_1068
        if ____t_1069(____t_result_1068) then
            local ____t_1076 = __t
            local ____t_result_1075
            if __t(__L1.practice) then
                local ____opt_1072 = __L1.controls
                if ____opt_1072 ~= nil then
                    ____opt_1072 = ____opt_1072.isEditing
                end
                local ____opt_result_1074
                if ____opt_1072 ~= nil then
                    ____opt_result_1074 = ____opt_1072(____opt_1072)
                end
                ____t_result_1075 = ____opt_result_1074
            else
                ____t_result_1075 = __L1.practice
            end
            ____t_result_1077 = not ____t_1076(____t_result_1075)
        else
            ____t_result_1077 = __O[2980]
        end
        __O[2981] = ____t_result_1077
        if ____t_1078(____t_result_1077) then
            local ____t_result_1081
            if __t(__L1.practice) then
                ____t_result_1081 = __L1.practice
            else
                local ____opt_1079 = __L1.room
                if ____opt_1079 ~= nil then
                    ____opt_1079 = ____opt_1079.hostConnected
                end
                ____t_result_1081 = ____opt_1079 ~= false
            end
            ____t_result_1082 = ____t_result_1081
        else
            ____t_result_1082 = __O[2981]
        end
        if ____t_1083(____t_result_1082) then
            __L1.accumulator = __L1.accumulator + dt
            do
                local n = 0
                while __t(__L1.accumulator >= __L1.STEP and n < 4) do
                    __L1:tick(__L1.STEP)
                    __L1.accumulator = __L1.accumulator - __L1.STEP
                    n = n + 1
                end
            end
        end
        local ____t_1087 = __t
        local ____t_result_1086
        local ____t_1085 = __t
        local ____t_result_1084
        if __t(__L1.net) then
            ____t_result_1084 = __L1.credentials
        else
            ____t_result_1084 = __L1.net
        end
        __O[2982] = ____t_result_1084
        if ____t_1085(____t_result_1084) then
            ____t_result_1086 = now - __L1.lastNetAt > 50
        else
            ____t_result_1086 = __O[2982]
        end
        if ____t_1087(____t_result_1086) then
            __L1.lastNetAt = now
            local ____t_1091 = __t
            local ____t_result_1090
            local ____t_1089 = __t
            local ____temp_1088 = __L1:isHost()
            __O[2983] = ____temp_1088
            if ____t_1089(____temp_1088) then
                ____t_result_1090 = __L1.world
            else
                ____t_result_1090 = __O[2983]
            end
            if ____t_1091(____t_result_1090) then
                local ____this_1093
                ____this_1093 = __L1.net
                local ____opt_1092 = ____this_1093.sendState
                if ____opt_1092 ~= nil then
                    ____opt_1092(
                        ____this_1093,
                        __L1:snapshot()
                    )
                end
            else
                local ____this_1100
                ____this_1100 = __L1.net
                local ____opt_1094 = ____this_1100.sendInput
                if ____opt_1094 ~= nil then
                    local ____assign_1099 = __assign
                    local ____temp_1098 = {}
                    local ____L1_1095, ____inputSeq_1096 = __L1, "inputSeq"
                    local ____L1_inputSeq_1097 = ____L1_1095[____inputSeq_1096] + 1
                    ____L1_1095[____inputSeq_1096] = ____L1_inputSeq_1097
                    ____opt_1094(
                        ____this_1100,
                        ____assign_1099(____temp_1098, {seq = ____L1_inputSeq_1097}, __L1.input)
                    )
                end
            end
        end
        __L1:predict(dt)
        __L1:consumeEvents()
        for ____, e in __iterar((__L1.effectFrames)) do
            e.life = e.life - dt
            local ____e_1102, ____x_1103 = e, "x"
            local ____t_result_1101
            if __t(e.vx) then
                ____t_result_1101 = e.vx
            else
                ____t_result_1101 = 0
            end
            ____e_1102[____x_1103] = ____e_1102[____x_1103] + ____t_result_1101 * dt
            local ____e_1105, ____y_1106 = e, "y"
            local ____t_result_1104
            if __t(e.vy) then
                ____t_result_1104 = e.vy
            else
                ____t_result_1104 = 0
            end
            ____e_1105[____y_1106] = ____e_1105[____y_1106] + ____t_result_1104 * dt
            local ____t_result_1107
            if __t(e.vy) then
                ____t_result_1107 = e.vy
            else
                ____t_result_1107 = 0
            end
            e.vy = ____t_result_1107 + 180 * dt
        end
        __L1.effectFrames = __call(
            __L1.effectFrames,
            "filter",
            function(____, e) return __gt(e.life, 0) end
        )
        local drawAt = window.performance:now()
        __L1:draw()
        local ____t_1114 = __t
        local ____t_result_1113
        if __t(__L1.world) then
            local ____opt_1110 = window.Graphics
            if ____opt_1110 ~= nil then
                ____opt_1110 = ____opt_1110.isShader
            end
            local ____opt_result_1112
            if ____opt_1110 ~= nil then
                ____opt_result_1112 = ____opt_1110(____opt_1110)
            end
            ____t_result_1113 = ____opt_result_1112
        else
            ____t_result_1113 = __L1.world
        end
        if ____t_1114(____t_result_1113) then
            local ____opt_1117 = window.Shader
            if ____opt_1117 ~= nil then
                ____opt_1117 = ____opt_1117.apply
            end
            if ____opt_1117 ~= nil then
                ____opt_1117(
                    ____opt_1117,
                    __L1["$"](__L1, "arenaCanvas"),
                    {
                        sun = __arrL({0.76, 0.17}, 2),
                        outdoor = true,
                        time = now / 1000
                    }
                )
            end
        end
        __L1.renderCost = __L1.renderCost * 0.9 + (window.performance:now() - drawAt) * 0.1
        __L1.frameHandle = window:requestAnimationFrame(__L1.frame)
    end
    __L1.open = function(self)
        if __t(__L1.opened) then
            return
        end
        __L1:ensureUI()
        __L1.priorFocus = window.document.activeElement
        local ____opt_1121 = window.Game
        if ____opt_1121 ~= nil then
            ____opt_1121 = ____opt_1121.getState
        end
        local ____opt_result_1123
        if ____opt_1121 ~= nil then
            ____opt_result_1123 = ____opt_1121(____opt_1121)
        end
        local state = ____opt_result_1123
        local ____t_result_1132
        local ____t_1131 = __t
        local ____t_result_1130
        local ____t_1129 = __t
        local ____t_1127 = __t
        local ____opt_result_1126
        if state ~= nil then
            ____opt_result_1126 = state.started
        end
        local ____temp_1128 = not not ____t_1127(____opt_result_1126) and not __t(state.paused)
        __O[2984] = ____temp_1128
        if ____t_1129(____temp_1128) then
            ____t_result_1130 = not __t(state.won)
        else
            ____t_result_1130 = __O[2984]
        end
        __O[2985] = ____t_result_1130
        if ____t_1131(____t_result_1130) then
            ____t_result_1132 = not __t(state.chapterEnded)
        else
            ____t_result_1132 = __O[2985]
        end
        __L1.pausedCampaign = ____t_result_1132
        if __t(__L1.pausedCampaign) then
            window.Game:pause()
        end
        local ____opt_1135 = window.Game
        if ____opt_1135 ~= nil then
            ____opt_1135 = ____opt_1135.releaseInputs
        end
        if ____opt_1135 ~= nil then
            ____opt_1135(____opt_1135)
        end
        local ____t_result_1143
        local ____t_1142 = __t
        local ____opt_1139 = window.CoopArena
        if ____opt_1139 ~= nil then
            ____opt_1139 = ____opt_1139.getStatus
        end
        local ____opt_result_1141
        if ____opt_1139 ~= nil then
            ____opt_result_1141 = ____opt_1139(____opt_1139).open
        end
        __O[2986] = ____opt_result_1141
        if ____t_1142(____opt_result_1141) then
            ____t_result_1143 = window.CoopArena:close()
        else
            ____t_result_1143 = __O[2986]
        end
        __L1.opened = true
        __L1.screen.hidden = false
        __call(window.document.documentElement.classList, "add", "arena-is-open")
        __L1:resetInput()
        __L1:notify("Escolha um personagem. Online de 2 a 4 pessoas ou treino local com bots.")
        __L1["$"](__L1, "arenaClose"):focus()
        __L1.lastFrame = 0
        __L1.frameHandle = window:requestAnimationFrame(__L1.frame)
        window:dispatchEvent(__new("CustomEvent", "arena-open"))
        do
            local function ____catch()
                window.sessionStorage:removeItem("daroca-arena-room")
            end
            local ____try = pcall(function()
                local ____self_1147 = window.JSON
                local ____self_1147_parse_1148 = ____self_1147.parse
                local ____t_result_1146
                local ____t_1145 = __t
                local ____temp_1144 = window.sessionStorage:getItem("daroca-arena-room")
                __O[2987] = ____temp_1144
                if ____t_1145(____temp_1144) then
                    ____t_result_1146 = __O[2987]
                else
                    ____t_result_1146 = "null"
                end
                local saved = ____self_1147_parse_1148(____self_1147, ____t_result_1146)
                local ____t_1156 = __t
                local ____t_result_1155
                local ____t_1154 = __t
                local ____t_result_1153
                local ____t_1152 = __t
                local ____opt_result_1151
                if saved ~= nil then
                    ____opt_result_1151 = saved.token
                end
                __O[2988] = ____opt_result_1151
                if ____t_1152(____opt_result_1151) then
                    ____t_result_1153 = __re_test(
                        __re("^[A-Z0-9]{6}$", ""),
                        saved.code
                    )
                else
                    ____t_result_1153 = __O[2988]
                end
                __O[2989] = ____t_result_1153
                if ____t_1154(____t_result_1153) then
                    ____t_result_1155 = saved.playerId
                else
                    ____t_result_1155 = __O[2989]
                end
                if ____t_1156(____t_result_1155) then
                    __L1.credentials = {
                        token = saved.token,
                        playerId = saved.playerId,
                        isHost = not not __t(saved.isHost)
                    }
                    __L1.room = {
                        code = saved.code,
                        status = "lobby",
                        players = __arrL({}, 0),
                        capacity = 4
                    }
                    __L1.restoring = true
                    __L1:notify("Reconectando à sua sala…")
                    __L1:scheduleSync(0)
                end
            end)
            if not ____try then
                ____catch()
            end
        end
    end
    __L1.close = function(self)
        if not __t(__L1.opened) then
            return
        end
        local ____opt_1159 = __L1.controls
        if ____opt_1159 ~= nil then
            ____opt_1159 = ____opt_1159.closeEditor
        end
        if ____opt_1159 ~= nil then
            ____opt_1159(____opt_1159)
        end
        local ____t_1164 = __t
        local ____t_result_1163
        local ____t_1162 = __t
        local ____t_result_1161
        if __t(__L1.credentials) then
            ____t_result_1161 = __L1:playing()
        else
            ____t_result_1161 = __L1.credentials
        end
        __O[2990] = ____t_result_1161
        if ____t_1162(____t_result_1161) then
            ____t_result_1163 = not __t(window:confirm("Sair da arena e encerrar sua participação na sala?"))
        else
            ____t_result_1163 = __O[2990]
        end
        if ____t_1164(____t_result_1163) then
            return
        end
        __L1:leaveRoom(true)
        __L1.opened = false
        __L1.screen.hidden = true
        window.document.documentElement.classList:remove("arena-is-open")
        window:cancelAnimationFrame(__L1.frameHandle)
        local ____opt_1167 = window.Game
        if ____opt_1167 ~= nil then
            ____opt_1167 = ____opt_1167.releaseInputs
        end
        if ____opt_1167 ~= nil then
            ____opt_1167(____opt_1167)
        end
        if __t(__L1.pausedCampaign) then
            local ____opt_1171 = window.Game
            if ____opt_1171 ~= nil then
                ____opt_1171 = ____opt_1171.resume
            end
            if ____opt_1171 ~= nil then
                ____opt_1171(____opt_1171)
            end
        end
        __L1.pausedCampaign = false
        local ____t_1175 = __t
        local ____opt_1173 = __L1.priorFocus
        if ____opt_1173 ~= nil then
            ____opt_1173 = ____opt_1173.isConnected
        end
        if ____t_1175(____opt_1173) then
            local ____this_1177
            ____this_1177 = __L1.priorFocus
            local ____opt_1176 = ____this_1177.focus
            if ____opt_1176 ~= nil then
                ____opt_1176(____this_1177, {preventScroll = true})
            end
        end
        window:dispatchEvent(__new("CustomEvent", "arena-close"))
    end
    __L1.keyAction = function(self, code)
        local ____t_1180 = __t
        local ____opt_1178 = window.ControlSettings
        if ____opt_1178 ~= nil then
            ____opt_1178 = ____opt_1178.matches
        end
        if ____t_1180(____opt_1178) then
            for ____, ____value in __iterar((__arrL(
                {
                    __arrL({"left", "left"}, 2),
                    __arrL({"right", "right"}, 2),
                    __arrL({"up", "up"}, 2),
                    __arrL({"down", "down"}, 2),
                    __arrL({"jump", "jump"}, 2),
                    __arrL({"attack", "paper"}, 2),
                    __arrL({"special", "fart"}, 2),
                    __arrL({"dash", "dash"}, 2),
                    __arrL({"ultimate", "reeis"}, 2),
                    __arrL({"emote", "taunt"}, 2)
                },
                10
            ))) do
                local action = ____value[1]
                local source = ____value[2]
                if __t(window.ControlSettings:matches(source, code)) then
                    return action
                end
            end
            return nil
        end
        return __get(__L1.keyActions, code)
    end
    local ____ = "use strict"
    __L1.W = 960
    __L1.H = 540
    __L1.pixelRatio = 1
    __L1.FLOOR = 470
    __L1.VERSION = 3
    __L1.STEP = 1 / 60
    __L1.OFFICIAL = "https://da-roca-adventure-jogo.davims99.chatgpt.site"
    __L1["$"] = function(____, id) return window.document:getElementById(id) end
    __L1.clamp = function(____, v, a, b) return math.max(
        a,
        math.min(b, v)
    ) end
    __L1.roster = function()
        local ____t_result_1184
        local ____t_1183 = __t
        local ____opt_1181 = window.ArenaRoster
        if ____opt_1181 ~= nil then
            ____opt_1181 = ____opt_1181.all
        end
        __O[2834] = ____opt_1181
        if ____t_1183(____opt_1181) then
            ____t_result_1184 = __O[2834]
        else
            ____t_result_1184 = __arrL({}, 0)
        end
        return ____t_result_1184
    end
    __L1.kit = function(____, id)
        local ____t_result_1187
        local ____t_1186 = __t
        local ____callq_result_1185 = __callq(window.ArenaRoster, "get", id)
        __O[2835] = ____callq_result_1185
        if ____t_1186(____callq_result_1185) then
            ____t_result_1187 = __O[2835]
        else
            ____t_result_1187 = __get(
                __L1:roster(),
                0
            )
        end
        return ____t_result_1187
    end
    __L1.opened = false
    __L1.pausedCampaign = false
    __L1.priorFocus = nil
    __L1.screen = nil
    __L1.selected = "daroca"
    __L1.room = nil
    __L1.credentials = nil
    __L1.world = nil
    __L1.displayWorld = nil
    __L1.practice = false
    __L1.ready = false
    __L1.busy = false
    __L1.generation = 0
    __L1.pollTimer = 0
    __L1.lastFrame = 0
    __L1.accumulator = 0
    __L1.inputSeq = 0
    __L1.stateSeq = 0
    __L1.lastSync = 0
    __L1.lastRequestAt = 0
    __L1.urgentSync = false
    __L1.networkFailures = 0
    __L1.pendingStatus = nil
    __L1.frameHandle = 0
    __L1.notice = ""
    __L1.inputAt = 0
    __L1.scene = "school"
    __L1.restoring = false
    __L1.syncing = false
    __L1.lobbyRevision = 0
    __L1.syncedLobbyRevision = -1
    __L1.controls = nil
    __L1.joystickInput = __ord({x = 0, y = 0}, "x,y")
    __L1.prediction = nil
    __L1.predictionHistory = __arrL({}, 0)
    __L1.predictionAccumulator = 0
    __L1.remoteFrames = __arrL({}, 0)
    __L1.serverOffset = 0
    __L1.rttMs = 0
    __L1.renderCost = 0
    __L1.localAttack = nil
    __L1.goUntil = 0
    __L1.inputs = __TS__New(Map)
    __L1.held = __TS__New(Set)
    __L1.heldPointers = __TS__New(Map)
    __L1.effectFrames = __arrL({}, 0)
    __L1.snapshotAt = 0
    __L1.lastShotCounter = 0
    __L1.aim = 1
    __L1.input = __ord({
        x = 0,
        y = 0,
        jump = false,
        jumpPress = 0,
        aim = 0,
        attack = 0,
        special = 0,
        ultimate = 0,
        dash = 0,
        emote = 0
    }, "x,y,jump,jumpPress,aim,attack,special,ultimate,dash,emote")
    __L1.cleanText = function(____, v, max)
        if max == nil then
            max = 24
        end
        local ____call_1191 = __call
        local ____call_1190 = __call
        local ____re_replace_1189 = __re_replace
        local ____t_result_1188
        if __t(v) then
            ____t_result_1188 = v
        else
            ____t_result_1188 = ""
        end
        return ____call_1191(
            ____call_1190(
                ____re_replace_1189(
                    tostring(____t_result_1188),
                    __re("[<>\\u0000-\\u001f\\u007f]", "g"),
                    ""
                ),
                "trim"
            ),
            "slice",
            0,
            max
        )
    end
    __L1.localId = function()
        local ____t_result_1195
        local ____t_1194 = __t
        local ____opt_1192 = __L1.credentials
        if ____opt_1192 ~= nil then
            ____opt_1192 = ____opt_1192.playerId
        end
        __O[2836] = ____opt_1192
        if ____t_1194(____opt_1192) then
            ____t_result_1195 = __O[2836]
        else
            ____t_result_1195 = "practice-local"
        end
        return ____t_result_1195
    end
    __L1.isHost = function()
        local ____t_result_1199
        if __t(__L1.practice) then
            ____t_result_1199 = __L1.practice
        else
            local ____t_1198 = __t
            local ____opt_1196 = __L1.credentials
            if ____opt_1196 ~= nil then
                ____opt_1196 = ____opt_1196.isHost
            end
            ____t_result_1199 = not not ____t_1198(____opt_1196)
        end
        return ____t_result_1199
    end
    __L1.playing = function()
        local ____opt_1200 = __L1.world
        if ____opt_1200 ~= nil then
            ____opt_1200 = ____opt_1200.phase
        end
        return ____opt_1200 == "playing"
    end
    __L1.inMatch = function()
        local ____opt_1202 = __L1.world
        if ____opt_1202 ~= nil then
            ____opt_1202 = ____opt_1202.phase
        end
        local ____temp_1206 = ____opt_1202 == "playing"
        if not ____temp_1206 then
            local ____opt_1204 = __L1.world
            if ____opt_1204 ~= nil then
                ____opt_1204 = ____opt_1204.phase
            end
            ____temp_1206 = ____opt_1204 == "countdown"
        end
        return ____temp_1206
    end
    __L1.notify = function(____, message, ____error)
        if ____error == nil then
            ____error = false
        end
        __L1.notice = tostring(message)
        local el = __L1["$"](__L1, "arenaNotice")
        if __t(el) then
            el.textContent = __L1.notice
            el.classList:toggle("error", ____error)
        end
    end
    __L1.keyLabel = function(____, action, fallback)
        local ____t_result_1213
        local ____t_1212 = __t
        local ____opt_1209 = window.ControlSettings
        if ____opt_1209 ~= nil then
            ____opt_1209 = ____opt_1209.getLabel
        end
        local ____opt_result_1211
        if ____opt_1209 ~= nil then
            ____opt_result_1211 = ____opt_1209(____opt_1209, action)
        end
        __O[2841] = ____opt_result_1211
        if ____t_1212(____opt_result_1211) then
            ____t_result_1213 = __O[2841]
        else
            ____t_result_1213 = fallback
        end
        return ____t_result_1213
    end
    __L1.STAGE = __arrL(
        {
            __ord({
                id = "main",
                x = 210,
                y = 470,
                w = 860,
                main = true
            }, "id,x,y,w,main"),
            __ord({id = "left", x = 320, y = 315, w = 210}, "id,x,y,w"),
            __ord({id = "right", x = 750, y = 315, w = 210}, "id,x,y,w"),
            __ord({id = "top", x = 555, y = 205, w = 170}, "id,x,y,w")
        },
        4
    )
    __L1.KO = __ord({left = -160, right = 1440, top = -440, bottom = 820}, "left,right,top,bottom")
    __L1.camera = __ord({x = 640, y = 320, zoom = 0.8}, "x,y,zoom")
    __L1.lastEventMatch = nil
    __L1.lastEventId = 0
    __L1.net = nil
    __L1.lastNetAt = 0
    __L1.renderDt = __L1.STEP
    __L1.visualClock = 0
    __L1.visualMatch = nil
    __L1.safeInsets = __ord({top = 0, right = 0, bottom = 0, left = 0}, "top,right,bottom,left")
    __L1.actions = __arrL({
        "attack",
        "special",
        "ultimate",
        "dash",
        "emote",
        "jumpPress"
    }, 6)
    __L1.shakeAmount = 0
    __L1.flashAmount = 0
    __L1.flashColor = "#fff7d6"
    __L1.calmMotion = window:matchMedia("(prefers-reduced-motion: reduce)").matches
    __L1.keyActions = __ord({
        ArrowLeft = "left",
        KeyA = "left",
        ArrowRight = "right",
        KeyD = "right",
        Space = "jump",
        ArrowUp = "up",
        KeyW = "up",
        ArrowDown = "down",
        KeyS = "down",
        KeyJ = "attack",
        KeyK = "special",
        KeyR = "ultimate",
        KeyL = "dash",
        ShiftLeft = "dash",
        ShiftRight = "dash",
        KeyT = "emote"
    }, "ArrowLeft,KeyA,ArrowRight,KeyD,Space,ArrowUp,KeyW,ArrowDown,KeyS,KeyJ,KeyK,KeyR,KeyL,ShiftLeft,ShiftRight,KeyT")
    window:addEventListener(
        "keydown",
        function(____, e)
            local ____t_1217 = __t
            local ____t_result_1216
            local ____t_1215 = __t
            local ____temp_1214 = not __t(__L1.opened)
            __O[2991] = ____temp_1214
            if ____t_1215(____temp_1214) then
                ____t_result_1216 = __O[2991]
            else
                ____t_result_1216 = window.document:querySelector("dialog[open]")
            end
            if ____t_1217(____t_result_1216) then
                return
            end
            e:stopImmediatePropagation()
            if e.code == "Escape" then
                e:preventDefault()
                local ____t_1223 = __t
                local ____opt_1220 = __L1.controls
                if ____opt_1220 ~= nil then
                    ____opt_1220 = ____opt_1220.isEditing
                end
                local ____opt_result_1222
                if ____opt_1220 ~= nil then
                    ____opt_result_1222 = ____opt_1220(____opt_1220)
                end
                if ____t_1223(____opt_result_1222) then
                    __L1.controls:closeEditor()
                else
                    __L1:close()
                end
                return
            end
            local ____t_1229 = __t
            local ____opt_1226 = __L1.controls
            if ____opt_1226 ~= nil then
                ____opt_1226 = ____opt_1226.isEditing
            end
            local ____opt_result_1228
            if ____opt_1226 ~= nil then
                ____opt_result_1228 = ____opt_1226(____opt_1226)
            end
            if ____t_1229(____opt_result_1228) then
                return
            end
            if __t(not __t(__L1:playing()) or __re_test(
                __re("INPUT|TEXTAREA|SELECT", ""),
                e.target.tagName
            )) then
                return
            end
            local action = __L1:keyAction(e.code)
            if not __t(action) then
                return
            end
            e:preventDefault()
            local wasHeld = __call(__L1.held, "has", action)
            __call(__L1.held, "add", action)
            __L1:pumpInput()
            if __t(not __t(wasHeld) and not __t(e["repeat"])) then
                __L1:trigger(action)
            end
            __L1:syncNow()
        end,
        true
    )
    window:addEventListener(
        "keyup",
        function(____, e)
            if not __t(__L1.opened) then
                return
            end
            e:stopImmediatePropagation()
            local action = __L1:keyAction(e.code)
            if __t(action) then
                __call(__L1.held, "delete", action)
                __L1:pumpInput()
                __L1:syncNow()
                e:preventDefault()
            end
        end,
        true
    )
    window.document:addEventListener(
        "click",
        function(____, event)
            local ____this_1231
            ____this_1231 = event.target
            local ____opt_1230 = ____this_1231.closest
            if ____opt_1230 ~= nil then
                ____opt_1230 = ____opt_1230(____this_1231, "[data-open-arena]")
            end
            local button = ____opt_1230
            if __t(button) then
                event:preventDefault()
                __L1:open()
            end
        end
    )
    window:addEventListener(
        "controls-change",
        function()
            if not __t(__L1.screen) then
                return
            end
            if not __t(__L1.world) then
                __L1:select(__L1.selected)
            else
                __L1:updateSkillBar()
            end
        end
    )
    window:addEventListener("blur", __L1.resetInput)
    window.document:addEventListener(
        "visibilitychange",
        function()
            __L1:resetInput()
            local ____t_1235 = __t
            local ____t_result_1234
            local ____t_1233 = __t
            local ____t_result_1232
            if __t(__L1.opened) then
                ____t_result_1232 = window.document.hidden
            else
                ____t_result_1232 = __L1.opened
            end
            __O[2992] = ____t_result_1232
            if ____t_1233(____t_result_1232) then
                ____t_result_1234 = __L1.credentials
            else
                ____t_result_1234 = __O[2992]
            end
            if ____t_1235(____t_result_1234) then
                __L1:notify(__t(__L1:isHost()) and "Mantenha o jogo aberto para a sala continuar em tempo real." or "Você voltou? A arena reconecta automaticamente.")
            end
        end
    )
    window.Arena = __ord(
        {
            open = __L1.open,
            close = __L1.close,
            editControls = function()
                __L1:open()
                local ____opt_1238 = __L1.controls
                if ____opt_1238 ~= nil then
                    ____opt_1238 = ____opt_1238.openEditor
                end
                if ____opt_1238 ~= nil then
                    ____opt_1238(____opt_1238)
                end
            end,
            getControlsStatus = function()
                local ____t_result_1246
                local ____t_1245 = __t
                local ____opt_1242 = __L1.controls
                if ____opt_1242 ~= nil then
                    ____opt_1242 = ____opt_1242.getStatus
                end
                local ____opt_result_1244
                if ____opt_1242 ~= nil then
                    ____opt_result_1244 = ____opt_1242(____opt_1242)
                end
                __O[2993] = ____opt_result_1244
                if ____t_1245(____opt_result_1244) then
                    ____t_result_1246 = __O[2993]
                else
                    ____t_result_1246 = nil
                end
                return ____t_result_1246
            end,
            isOpen = function() return __L1.opened end,
            startPractice = function()
                __L1:open()
                __L1:startPractice()
            end,
            getStatus = function()
                local ____L1_opened_1302 = __L1.opened
                local ____L1_VERSION_1303 = __L1.VERSION
                local ____temp_1254
                local ____opt_1247 = __L1.world
                if ____opt_1247 ~= nil then
                    ____opt_1247 = ____opt_1247.phase
                end
                if ____opt_1247 == "finished" then
                    ____temp_1254 = "results"
                else
                    local ____temp_1253
                    local ____opt_1249 = __L1.world
                    if ____opt_1249 ~= nil then
                        ____opt_1249 = ____opt_1249.phase
                    end
                    if ____opt_1249 == "playing" then
                        ____temp_1253 = "playing"
                    else
                        local ____opt_1251 = __L1.world
                        if ____opt_1251 ~= nil then
                            ____opt_1251 = ____opt_1251.phase
                        end
                        ____temp_1253 = ____opt_1251 == "countdown" and "countdown" or (__t(__L1.room) and "lobby" or "menu")
                    end
                    ____temp_1254 = ____temp_1253
                end
                local ____temp_1304 = not not __t(__L1.credentials)
                local ____L1_practice_1305 = __L1.practice
                local ____temp_1306 = __L1:isHost()
                local ____t_result_1258
                local ____t_1257 = __t
                local ____opt_1255 = __L1.room
                if ____opt_1255 ~= nil then
                    ____opt_1255 = ____opt_1255.code
                end
                __O[2994] = ____opt_1255
                if ____t_1257(____opt_1255) then
                    ____t_result_1258 = __O[2994]
                else
                    ____t_result_1258 = nil
                end
                local ____temp_1307 = __L1:localId()
                local ____t_result_1266
                local ____t_1265 = __t
                local ____t_result_1264
                local ____t_1261 = __t
                local ____opt_1259 = __L1.world
                if ____opt_1259 ~= nil then
                    ____opt_1259 = ____opt_1259.phase
                end
                __O[2995] = ____opt_1259
                if ____t_1261(____opt_1259) then
                    ____t_result_1264 = __O[2995]
                else
                    local ____opt_1262 = __L1.room
                    if ____opt_1262 ~= nil then
                        ____opt_1262 = ____opt_1262.status
                    end
                    ____t_result_1264 = ____opt_1262
                end
                __O[2996] = ____t_result_1264
                if ____t_1265(____t_result_1264) then
                    ____t_result_1266 = __O[2996]
                else
                    ____t_result_1266 = "selection"
                end
                local ____t_result_1270
                local ____t_1269 = __t
                local ____opt_1267 = __L1.world
                if ____opt_1267 ~= nil then
                    ____opt_1267 = ____opt_1267.matchId
                end
                __O[2997] = ____opt_1267
                if ____t_1269(____opt_1267) then
                    ____t_result_1270 = __O[2997]
                else
                    ____t_result_1270 = nil
                end
                local ____temp_1273
                local ____opt_1271 = __L1.world
                if ____opt_1271 ~= nil then
                    ____opt_1271 = ____opt_1271.phase
                end
                if ____opt_1271 == "countdown" then
                    ____temp_1273 = math.max(
                        0,
                        (__L1.world.startAt - window.Date:now() - __L1.serverOffset) / 1000
                    )
                else
                    ____temp_1273 = 0
                end
                local ____math_floor_result_1308 = math.floor(__L1.rttMs + 0.5)
                local ____len_result_1309 = __len(__L1.effectFrames)
                local ____assign_result_1310 = __assign(
                    {},
                    __L1:cameraViewport(),
                    {
                        width = __L1.W,
                        height = __L1.H,
                        usableHeight = __L1:cameraViewport().height
                    }
                )
                local ____L1_visualClock_1311 = __L1.visualClock
                local ____t_result_1274
                if __t(__L1.prediction) then
                    ____t_result_1274 = {x = __L1.prediction.x, y = __L1.prediction.y, motion = __L1.prediction.motion, wallSide = __L1.prediction.wallSide}
                else
                    ____t_result_1274 = nil
                end
                local ____len_result_1312 = __len(__L1:roster())
                local ____L1_notice_1313 = __L1.notice
                local ____t_result_1284
                local ____t_1283 = __t
                local ____t_result_1282
                local ____t_1279 = __t
                local ____callq_1277 = __callq
                local ____opt_1275 = __L1.world
                if ____opt_1275 ~= nil then
                    ____opt_1275 = ____opt_1275.players
                end
                local ____callq_1277_result_1278 = ____callq_1277(
                    ____opt_1275,
                    "map",
                    function(____, p) return {
                        id = p.id,
                        name = p.name,
                        character = p.character,
                        x = p.x,
                        y = p.y,
                        vx = p.vx,
                        vy = p.vy,
                        stocks = p.stocks,
                        damage = p.damage,
                        comboHits = p.comboHits,
                        energy = p.energy,
                        skillCD = p.skillCD,
                        kills = p.kills,
                        respawn = p.respawn,
                        jumps = p.jumps,
                        ground = p.ground,
                        stun = p.stun,
                        motion = p.motion,
                        motionTime = p.motionTime,
                        wallSide = p.wallSide,
                        wallGrip = p.wallGrip,
                        ackInput = p.ackInput,
                        emote = p.emote,
                        eliminated = __le(p.stocks, 0),
                        attackType = p.attackType,
                        attackDirection = p.attackDirection,
                        attackShape = p.attackShape,
                        actions = __assign({}, p.used)
                    } end
                )
                __O[2998] = ____callq_1277_result_1278
                if ____t_1279(____callq_1277_result_1278) then
                    ____t_result_1282 = __O[2998]
                else
                    local ____opt_1280 = __L1.room
                    if ____opt_1280 ~= nil then
                        ____opt_1280 = ____opt_1280.players
                    end
                    ____t_result_1282 = ____opt_1280
                end
                __O[2999] = ____t_result_1282
                if ____t_1283(____t_result_1282) then
                    ____t_result_1284 = __O[2999]
                else
                    ____t_result_1284 = __arrL({}, 0)
                end
                local ____t_result_1290
                local ____t_1289 = __t
                local ____lenq_1287 = __lenq
                local ____opt_1285 = __L1.world
                if ____opt_1285 ~= nil then
                    ____opt_1285 = ____opt_1285.shots
                end
                local ____lenq_1287_result_1288 = ____lenq_1287(____opt_1285)
                __O[3000] = ____lenq_1287_result_1288
                if ____t_1289(____lenq_1287_result_1288) then
                    ____t_result_1290 = __O[3000]
                else
                    ____t_result_1290 = 0
                end
                local ____call_result_1314 = __call(
                    __L1.STAGE,
                    "map",
                    function(____, p) return __assign({}, p) end
                )
                local ____assign_result_1315 = __assign({}, __L1.KO)
                local ____assign_result_1316 = __assign({}, __L1.camera)
                local ____t_result_1294
                local ____t_1293 = __t
                local ____opt_1291 = __L1.world
                if ____opt_1291 ~= nil then
                    ____opt_1291 = ____opt_1291.remaining
                end
                __O[3001] = ____opt_1291
                if ____t_1293(____opt_1291) then
                    ____t_result_1294 = __O[3001]
                else
                    ____t_result_1294 = 0
                end
                local ____t_result_1301
                local ____t_1300 = __t
                local ____opt_1297 = __L1.net
                if ____opt_1297 ~= nil then
                    ____opt_1297 = ____opt_1297.getStatus
                end
                local ____opt_result_1299
                if ____opt_1297 ~= nil then
                    ____opt_result_1299 = ____opt_1297(____opt_1297)
                end
                __O[3002] = ____opt_result_1299
                if ____t_1300(____opt_result_1299) then
                    ____t_result_1301 = __O[3002]
                else
                    ____t_result_1301 = nil
                end
                return {
                    open = ____L1_opened_1302,
                    version = ____L1_VERSION_1303,
                    stage = ____temp_1254,
                    connected = ____temp_1304,
                    practice = ____L1_practice_1305,
                    isHost = ____temp_1306,
                    code = ____t_result_1258,
                    playerId = ____temp_1307,
                    phase = ____t_result_1266,
                    matchId = ____t_result_1270,
                    countdown = ____temp_1273,
                    pingMs = ____math_floor_result_1308,
                    effectCount = ____len_result_1309,
                    viewport = ____assign_result_1310,
                    visualTime = ____L1_visualClock_1311,
                    predicted = ____t_result_1274,
                    rosterCount = ____len_result_1312,
                    notice = ____L1_notice_1313,
                    players = ____t_result_1284,
                    shots = ____t_result_1290,
                    platforms = ____call_result_1314,
                    bounds = ____assign_result_1315,
                    camera = ____assign_result_1316,
                    remaining = ____t_result_1294,
                    transport = ____t_result_1301,
                    lastSync = math.floor(window.performance:now() - __L1.lastSync + 0.5)
                }
            end
        },
        "open,close,editControls,getControlsStatus,isOpen,startPractice,getStatus"
    )
end)(nil)
return ____exports
