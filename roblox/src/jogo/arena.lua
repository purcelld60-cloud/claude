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
        if __t(if __t(__L1.opened) then __L1.credentials else __L1.opened) then
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
        local ____t_4 = __t
        local ____temp_3 = if __t(window.document.fullscreenElement) then window.document.fullscreenElement else window.document:getElementById("gameShell")
        __O[2814] = ____temp_3
        if ____t_4(____temp_3) then __O[2814] else window.document.body:append(__L1.screen)
        local headerActions = window.document:createElement("div")
        headerActions.className = "arena-header-actions"
        local sound = window.document:createElement("button")
        sound.id = "arenaSoundBtn"
        sound.className = "arena-small-button"
        sound.type = "button"
        sound.onclick = function()
            local ____opt_5 = window.document:getElementById("soundBtn")
            if ____opt_5 ~= nil then
                ____opt_5:click()
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
            button:setAttribute("aria-label", if dir == "up" then "Direcionar golpe para cima" else "Direcionar golpe para baixo ou descer plataforma")
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
        local ____L1__24_result_10 = __L1["$"](__L1, "arenaName")
        local ____L1_cleanText_9 = __L1.cleanText
        local ____t_8 = __t
        local ____temp_7 = window.localStorage:getItem("daroca-arena-name")
        __O[2815] = ____temp_7
        ____L1__24_result_10.value = ____L1_cleanText_9(__L1, if ____t_8(____temp_7) then __O[2815] else "", 20)
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
                    local ____self_14 = window.navigator.clipboard
                    local ____self_14_writeText_15 = ____self_14.writeText
                    local ____t_13 = __t
                    local ____opt_11 = __L1.room
                    if ____opt_11 ~= nil then
                        ____opt_11 = ____opt_11.code
                    end
                    __O[2816] = ____opt_11
                    __TS__Await(____self_14_writeText_15(____self_14, if ____t_13(____opt_11) then __O[2816] else ""))
                    __L1:notify("Código copiado. Mande para a turma!")
                end)
                ____try = ____try.catch(
                    ____try,
                    function(____)
                        return __TS__AsyncAwaiter(function()
                            local ____L1_notify_20 = __L1.notify
                            local ____add_19 = __add
                            local ____t_18 = __t
                            local ____opt_16 = __L1.room
                            if ____opt_16 ~= nil then
                                ____opt_16 = ____opt_16.code
                            end
                            __O[2817] = ____opt_16
                            ____L1_notify_20(
                                __L1,
                                ____add_19("Código da sala: ", if ____t_18(____opt_16) then __O[2817] else "")
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
        local ____t_23 = __t
        local ____opt_21 = window.ArenaControls
        if ____opt_21 ~= nil then
            ____opt_21 = ____opt_21.mount
        end
        if ____t_23(____opt_21) then
            __L1.controls = window.ArenaControls:mount({
                screen = __L1.screen,
                wrap = __L1.screen:querySelector(".arena-canvas-wrap"),
                getState = function()
                    local ____temp_28 = __L1:playing()
                    local ____L1_practice_29 = __L1.practice
                    local ____temp_30 = not not __t(__L1.world)
                    local ____temp_27 = not not __t(__L1.world)
                    if ____temp_27 then
                        local ____le_26 = __le
                        local ____opt_24 = __call(
                            __L1.world.players,
                            "find",
                            function(____, p) return p.id == __L1:localId() end
                        )
                        if ____opt_24 ~= nil then
                            ____opt_24 = ____opt_24.stocks
                        end
                        ____temp_27 = ____le_26(____opt_24, 0)
                    end
                    return {playing = ____temp_28, practice = ____L1_practice_29, hasWorld = ____temp_30, eliminated = ____temp_27}
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
                                local ____opt_31 = button.setPointerCapture
                                if ____opt_31 ~= nil then
                                    ____opt_31(button, e.pointerId)
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
        local ____opt_35 = window.GameMusic
        if ____opt_35 ~= nil then
            ____opt_35 = ____opt_35.getStatus
        end
        local ____opt_result_37
        if ____opt_35 ~= nil then
            ____opt_result_37 = ____opt_35(____opt_35).enabled
        end
        local ____opt_result_37_40 = ____opt_result_37
        if ____opt_result_37_40 == nil then
            local ____opt_38 = window.document:getElementById("soundBtn")
            ____opt_result_37_40 = (____opt_38 and ____opt_38:getAttribute("aria-pressed")) == "true"
        end
        local on = ____opt_result_37_40
        button.textContent = if __t(on) then "SOM LIGADO" else "LIGAR SOM"
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
        local height = if id == "giant" then 200 else if __t(id == "kaique" or id == "ollyan") then 112 else if id == "igor" then 90 else 80
        local width = if id == "giant" then 240 else if id == "ollyan" then 95 else if id == "igor" then 76 else 55
        local fit = math.min(scale, (canvas.height - 18) / height, (canvas.width - 10) / width)
        local ____t_43 = __t
        local ____opt_41 = window.Art
        if ____opt_41 ~= nil then
            ____opt_41 = ____opt_41.drawCharacter
        end
        if ____t_43(____opt_41) then
            window.Art:drawCharacter(
                c,
                id,
                canvas.width / 2,
                canvas.height - 10,
                {scale = fit, frame = t, bossPhase = if id == "nikolas" then 1 else nil, moving = false}
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
        local ____t_46 = __t
        local ____opt_44 = __L1:kit(id)
        if ____opt_44 ~= nil then
            ____opt_44 = ____opt_44.id
        end
        __O[2819] = ____opt_44
        __L1.selected = if ____t_46(____opt_44) then __O[2819] else "daroca"
        __L1.lobbyRevision = __L1.lobbyRevision + 1
        local k = __L1:kit(__L1.selected)
        if not __t(k) then
            return
        end
        local ____callq_49 = __callq
        local ____opt_47 = __L1.screen
        if ____opt_47 ~= nil then
            ____opt_47 = ____opt_47:querySelectorAll("[data-fighter]")
        end
        ____callq_49(
            ____opt_47,
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
        local ____t_52 = __t
        local ____opt_50 = __L1.room
        if ____opt_50 ~= nil then
            ____opt_50 = ____opt_50.status
        end
        if ____t_52(if __t(__L1.credentials) then ____opt_50 == "lobby" else __L1.credentials) then
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
            __L1["$"](__L1, id).disabled = if __t(__L1.busy) then __L1.busy else connected
        end
        if not __t(connected) then
            return
        end
        __L1["$"](__L1, "arenaCopyCode").textContent = __L1.room.code
        __L1["$"](__L1, "arenaSeats"):replaceChildren()
        do
            local i = 0
            while __lt(i, if __t(__L1.room.capacity) then __L1.room.capacity else 4) do
                local p = __get(__L1.room.players, i)
                local el = window.document:createElement("div")
                local ____add_56 = __add
                local ____opt_result_55
                if p ~= nil then
                    ____opt_result_55 = p.id
                end
                el.className = ____add_56("arena-seat", if ____opt_result_55 == __L1:localId() then " is-you" else "")
                if __t(p) then
                    local k = __L1:kit(p.character)
                    local dot = window.document:createElement("i")
                    local ____dot_style_61 = dot.style
                    local ____t_60 = __t
                    local ____opt_result_59
                    if k ~= nil then
                        ____opt_result_59 = k.color
                    end
                    __O[2820] = ____opt_result_59
                    ____dot_style_61.background = if ____t_60(____opt_result_59) then __O[2820] else "#d4be89"
                    local label = window.document:createElement("span")
                    label.textContent = __add(p.name, if p.id == __L1:localId() then " · VOCÊ" else "")
                    local sub = window.document:createElement("small")
                    local ____add_67 = __add
                    local ____add_66 = __add
                    local ____t_65 = __t
                    local ____opt_result_64
                    if k ~= nil then
                        ____opt_result_64 = k.name
                    end
                    __O[2821] = ____opt_result_64
                    sub.textContent = ____add_67(
                        ____add_66(if ____t_65(____opt_result_64) then __O[2821] else p.character, " · "),
                        if __t(p.ready) then "PRONTO" else if p.id == __L1.room.hostPlayerId then "CRIADOR DA SALA" else "ESCOLHENDO"
                    )
                    el:append(dot, label, sub)
                else
                    el.textContent = "＋ ESPERANDO A TURMA"
                end
                __L1["$"](__L1, "arenaSeats"):append(el)
                i = i + 1
            end
        end
        __L1["$"](__L1, "arenaReady").textContent = if __t(__L1.ready) then "✓ PRONTO!" else "ESTOU PRONTO"
        __L1["$"](__L1, "arenaReady").classList:toggle("is-ready", __L1.ready)
        __L1["$"](__L1, "arenaStart").hidden = not __t(__L1:isHost())
        __L1["$"](__L1, "arenaStart").disabled = __lt(
            __len(__L1.room.players),
            2
        ) or not __t(__call(
            __L1.room.players,
            "every",
            function(____, p) return if p.id == __L1:localId() then __L1.ready else p.ready end
        ))
        __L1["$"](__L1, "arenaStart").title = if __lt(
            __len(__L1.room.players),
            2
        ) then "Espere pelo menos mais uma pessoa" else "Todos precisam estar prontos"
    end
    __L1.showBattle = function(self, visible)
        local ____opt_70 = __L1.controls
        if ____opt_70 ~= nil then
            ____opt_70 = ____opt_70.closeEditor
        end
        if ____opt_70 ~= nil then
            ____opt_70(____opt_70)
        end
        __L1["$"](__L1, "arenaLobby").hidden = visible
        __L1["$"](__L1, "arenaBattle").hidden = not __t(visible)
        __L1["$"](__L1, "arenaResult").hidden = true
        __L1.screen.classList:toggle("in-battle", visible)
        if __t(visible) then
            local ____L1__24_result_76 = __L1["$"](__L1, "arenaMatchCode")
            local ____add_75 = __add
            local ____add_74 = __add
            local ____opt_72 = __L1.room
            if ____opt_72 ~= nil then
                ____opt_72 = ____opt_72.code
            end
            ____L1__24_result_76.textContent = if __t(__L1.practice) then "TREINO LOCAL · BOTS" else ____add_75(
                ____add_74("SALA ", ____opt_72),
                " · ONLINE"
            )
            __L1:updateSkillBar()
            window:setTimeout(
                function()
                    local ____opt_77 = __L1["$"](__L1, "arenaCanvas")
                    if ____opt_77 ~= nil then
                        ____opt_77 = ____opt_77:focus()
                    end
                    return ____opt_77
                end,
                0
            )
        end
    end
    __L1.updateSkillBar = function(self)
        local ____L1_kit_85 = __L1.kit
        local ____t_84 = __t
        local ____callq_83 = __callq
        local ____opt_81 = __L1.world
        if ____opt_81 ~= nil then
            ____opt_81 = ____opt_81.players
        end
        local ____opt_79 = ____callq_83(
            ____opt_81,
            "find",
            function(____, p) return p.id == __L1:localId() end
        )
        if ____opt_79 ~= nil then
            ____opt_79 = ____opt_79.character
        end
        __O[2822] = ____opt_79
        local k = ____L1_kit_85(__L1, if ____t_84(____opt_79) then __O[2822] else __L1.selected)
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
            local headers = __assign({}, {["Content-Type"] = "application/json"}, if __t(options.headers) then options.headers else {})
            local ____t_88 = __t
            local ____opt_86 = __L1.credentials
            if ____opt_86 ~= nil then
                ____opt_86 = ____opt_86.token
            end
            if ____t_88(____opt_86) then
                headers.Authorization = __add("Bearer ", __L1.credentials.token)
            end
            local response
            local ____t_93 = __t
            local ____t_90 = __t
            local ____temp_89 = window.location.protocol == "file:"
            __O[2823] = ____temp_89
            local ____opt_91 = window.DaRocaNetwork
            if ____opt_91 ~= nil then
                ____opt_91 = ____opt_91.request
            end
            if ____t_93(if ____t_90(____temp_89) then ____opt_91 else __O[2823]) then
                response = __TS__Await(window.DaRocaNetwork:request(path, {method = if __t(options.method) then options.method else "POST", headers = headers, body = if options.body == nil then nil else window.JSON:stringify(options.body)}))
            else
                local controller = __new("AbortController")
                local timer = window:setTimeout(
                    function() return controller:abort() end,
                    25000
                )
                local ____try = __TS__AsyncAwaiter(function()
                    response = __TS__Await(window:fetch(
                        __add(if window.location.protocol == "file:" then __L1.OFFICIAL else "", path),
                        {
                            method = if __t(options.method) then options.method else "POST",
                            headers = headers,
                            body = if options.body == nil then nil else window.JSON:stringify(options.body),
                            signal = controller.signal,
                            cache = "no-store",
                            credentials = "omit"
                        }
                    ))
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
            local ____opt_result_96
            if response ~= nil then
                ____opt_result_96 = response.json
            end
            if type(____opt_result_96) == "function" then
                data = __TS__Await(response:json())
            else
                local ____opt_result_99
                if response ~= nil then
                    ____opt_result_99 = response.body
                end
                local ____opt_result_99_103 = ____opt_result_99
                if ____opt_result_99_103 == nil then
                    local ____opt_result_102
                    if response ~= nil then
                        ____opt_result_102 = response.data
                    end
                    ____opt_result_99_103 = ____opt_result_102
                end
                local ____opt_result_99_103_104 = ____opt_result_99_103
                if ____opt_result_99_103_104 == nil then
                    ____opt_result_99_103_104 = response
                end
                data = ____opt_result_99_103_104
                if type(data) == "string" then
                    data = window.JSON:parse(data)
                end
            end
            local ____opt_result_107
            if response ~= nil then
                ____opt_result_107 = response.status
            end
            local ____opt_result_107_108 = ____opt_result_107
            if ____opt_result_107_108 == nil then
                ____opt_result_107_108 = 200
            end
            local status = ____opt_result_107_108
            local ____t_117 = __t
            local ____t_113 = __t
            local ____opt_result_111
            if response ~= nil then
                ____opt_result_111 = response.ok
            end
            local ____temp_112 = ____opt_result_111 == false or __ge(status, 400)
            __O[2824] = ____temp_112
            local ____opt_result_116
            if data ~= nil then
                ____opt_result_116 = data.error
            end
            if ____t_117(if ____t_113(____temp_112) then __O[2824] else ____opt_result_116) then
                local ____Error_133 = Error
                local ____t_129 = __t
                local ____t_124 = __t
                local ____opt_result_122
                if data ~= nil then
                    ____opt_result_122 = data.error
                end
                local ____opt_result_123
                if ____opt_result_122 ~= nil then
                    ____opt_result_123 = ____opt_result_122.message
                end
                __O[2825] = ____opt_result_123
                local ____opt_result_127
                if data ~= nil then
                    ____opt_result_127 = data.message
                end
                local ____temp_128 = if ____t_124(____opt_result_123) then __O[2825] else ____opt_result_127
                __O[2826] = ____temp_128
                local ____opt_result_132
                if data ~= nil then
                    ____opt_result_132 = data.error
                end
                local ____error = __TS__New(____Error_133, if ____t_129(____temp_128) then __O[2826] else if type(____opt_result_132) == "string" then data.error else "Não foi possível conectar à sala.")
                ____error.status = status
                error(____error, 0)
            end
            return ____awaiter_resolve(nil, data)
        end)
    end
    __L1.connect = function(self, mode)
        return __TS__AsyncAwaiter(function(____awaiter_resolve)
            if __t(if __t(__L1.busy) then __L1.busy else __L1.credentials) then
                return ____awaiter_resolve(nil)
            end
            local ____t_135 = __t
            local ____temp_134 = __L1:cleanText(
                __L1["$"](__L1, "arenaName").value,
                20
            )
            __O[2827] = ____temp_134
            local name = if ____t_135(____temp_134) then __O[2827] else "Da Resenha"
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
            __L1:notify(if mode == "create" then "Criando sua sala na nuvem…" else "Entrando na sala da turma…")
            local ____L1_136, ____generation_137 = __L1, "generation"
            local ____L1_generation_138 = ____L1_136[____generation_137] + 1
            ____L1_136[____generation_137] = ____L1_generation_138
            local thisGeneration = ____L1_generation_138
            local ____hasReturned, ____returnValue
            local ____try = __TS__AsyncAwaiter(function()
                local data = __TS__Await(__L1:request(if mode == "create" then "/api/arena/rooms" else __add(
                    __add("/api/arena/rooms/", code),
                    "/join"
                ), {body = {
                    name = name,
                    character = __L1.selected,
                    capacity = 4,
                    mode = "arena",
                    protocol = 3
                }}))
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
                            __L1:notify(if e.name == "AbortError" then "A conexão demorou. Confira a internet e tente novamente." else e.message, true)
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
        local ____t_143 = __t
        local ____t_142 = __t
        local ____opt_result_141
        if data ~= nil then
            ____opt_result_141 = data.room
        end
        if ____t_143(not ____t_142(____opt_result_141) or not __isArray(data.room.players)) then
            error(
                Error(nil, "A sala respondeu em um formato inválido."),
                0
            )
        end
        __L1.room = data.room
        __L1.credentials.isHost = not not __t(data.isHost)
        for ____, item in __iterar((if __t(data.inputs) then data.inputs else __arrL({}, 0))) do
            local previous = __call(__L1.inputs, "get", item.playerId)
            if __t(if __t(item.input) then not __t(previous) or __gt(item.seq, previous.seq) else item.input) then
                __call(
                    __L1.inputs,
                    "set",
                    item.playerId,
                    __assign(
                        {},
                        item.input,
                        {seenAt = window.performance:now() - math.max(0, if __t(data.serverTime) then data.serverTime else window.Date:now() - item.updatedAt)}
                    )
                )
            end
        end
        if __t(not __t(__L1:isHost()) or not __t(__L1.world)) then
            __L1:receiveState(data.state)
        end
        if __t(__L1.restoring) then
            local own = __call(
                if __t(data.inputs) then data.inputs else __arrL({}, 0),
                "find",
                function(____, i) return i.playerId == __L1:localId() end
            )
            local ____L1_inputSeq_148 = __L1.inputSeq
            local ____t_147 = __t
            local ____opt_result_146
            if own ~= nil then
                ____opt_result_146 = own.seq
            end
            __O[2828] = ____opt_result_146
            __L1.inputSeq = math.max(____L1_inputSeq_148, if ____t_147(____opt_result_146) then __O[2828] else 0)
            local ____t_151 = __t
            local ____opt_149 = __call(
                __L1.room.players,
                "find",
                function(____, p) return p.id == __L1:localId() end
            )
            if ____opt_149 ~= nil then
                ____opt_149 = ____opt_149.ready
            end
            __L1.ready = not not ____t_151(____opt_149)
            local ____callq_154 = __callq
            local ____opt_152 = __L1.world
            if ____opt_152 ~= nil then
                ____opt_152 = ____opt_152.players
            end
            local p = ____callq_154(
                ____opt_152,
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
                local ____set_169 = __set
                local ____L1_input_168 = __L1.input
                local ____get_result_167 = __get(__L1.input, action)
                local ____t_166 = __t
                local ____t_160 = __t
                local ____getq_158 = __getq
                local ____opt_result_157
                if p ~= nil then
                    ____opt_result_157 = p.used
                end
                local ____getq_158_result_159 = ____getq_158(____opt_result_157, action)
                __O[2829] = ____getq_158_result_159
                local ____getq_164 = __getq
                local ____opt_result_163
                if own ~= nil then
                    ____opt_result_163 = own.input
                end
                local ____temp_165 = if ____t_160(____getq_158_result_159) then __O[2829] else ____getq_164(____opt_result_163, action)
                __O[2830] = ____temp_165
                ____set_169(
                    ____L1_input_168,
                    action,
                    math.max(____get_result_167, if ____t_166(____temp_165) then __O[2830] else 0)
                )
            end
            __L1.restoring = false
        end
        local ____t_180 = __t
        local ____t_177 = __t
        local ____t_173 = __t
        local ____t_171 = __t
        local ____temp_170 = __L1.room.status == "lobby"
        __O[2831] = ____temp_170
        local ____temp_172 = if ____t_171(____temp_170) then __L1.world else __O[2831]
        __O[2832] = ____temp_172
        local ____opt_174 = data.state
        if ____opt_174 ~= nil then
            ____opt_174 = ____opt_174.matchId
        end
        local ____temp_176 = if ____t_173(____temp_172) then ____opt_174 == __L1.world.matchId else __O[2832]
        __O[2833] = ____temp_176
        local ____opt_178 = data.state
        if ____opt_178 ~= nil then
            ____opt_178 = ____opt_178.phase
        end
        if ____t_180(if ____t_177(____temp_176) then ____opt_178 == "finished" else __O[2833]) then
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
        local ____opt_183 = __L1.net
        if ____opt_183 ~= nil then
            ____opt_183 = ____opt_183.updateRoster
        end
        if ____opt_183 ~= nil then
            ____opt_183(____opt_183, __L1.room.players)
        end
        local ____t_188 = __t
        local ____temp_187 = not __t(__L1:isHost())
        if ____temp_187 then
            local ____opt_185 = __L1.world
            if ____opt_185 ~= nil then
                ____opt_185 = ____opt_185.phase
            end
            ____temp_187 = ____opt_185 == "finished"
        end
        if ____t_188(____temp_187) then
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
        if __t(if __t(__L1.world) then __le(incoming.seq, __L1.world.seq) else __L1.world) then
            return
        end
        local ____opt_189 = __L1.world
        if ____opt_189 ~= nil then
            ____opt_189 = ____opt_189.matchId
        end
        local previousMatch = ____opt_189
        local ____opt_191 = __L1.world
        if ____opt_191 ~= nil then
            ____opt_191 = ____opt_191.phase
        end
        local previousPhase = ____opt_191
        local ____callq_195 = __callq
        local ____opt_193 = __L1.world
        if ____opt_193 ~= nil then
            ____opt_193 = ____opt_193.players
        end
        local old = ____callq_195(
            ____opt_193,
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
        __L1.lastShotCounter = if __t(__L1.world.shotSerial) then __L1.world.shotSerial else 0
        if __L1.world.phase == "finished" then
            __L1:showResult()
        end
    end
    __L1.setupNet = function(self)
        local ____t_198 = __t
        local ____t_197 = __t
        local ____temp_196 = if __t(__L1.net) then __L1.net else not __t(__L1.credentials)
        __O[2834] = ____temp_196
        if ____t_198(if ____t_197(____temp_196) then __O[2834] else not __t(window.ArenaNet)) then
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
        if __t(if __t(__L1.opened) then __L1.credentials else __L1.opened) then
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
        local ____t_201 = __t
        local ____t_200 = __t
        local ____temp_199 = not __t(__L1.credentials)
        __O[2835] = ____temp_199
        if ____t_201(if ____t_200(____temp_199) then __O[2835] else __L1.busy) then
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
            local ____assign_206 = __assign
            local ____temp_205 = {}
            local ____L1_202, ____inputSeq_203 = __L1, "inputSeq"
            local ____L1_inputSeq_204 = ____L1_202[____inputSeq_203] + 1
            ____L1_202[____inputSeq_203] = ____L1_inputSeq_204
            local body = if __t(__L1.restoring) then {} else {input = ____assign_206(____temp_205, {seq = ____L1_inputSeq_204}, __L1.input)}
            local sentLobbyRevision = __L1.lobbyRevision
            local ____t_211 = __t
            local ____t_210 = __t
            local ____temp_209 = not __t(__L1.restoring)
            if ____temp_209 then
                local ____opt_207 = __L1.room
                if ____opt_207 ~= nil then
                    ____opt_207 = ____opt_207.status
                end
                ____temp_209 = ____opt_207 == "lobby"
            end
            __O[2836] = ____temp_209
            if ____t_211(if ____t_210(____temp_209) then __L1.lobbyRevision ~= __L1.syncedLobbyRevision else __O[2836]) then
                body.character = __L1.selected
                body.ready = __L1.ready
            end
            local ____t_214 = __t
            local ____t_213 = __t
            local ____temp_212 = __L1:isHost()
            __O[2837] = ____temp_212
            if ____t_214(if ____t_213(____temp_212) then __L1.world else __O[2837]) then
                body.state = __L1:snapshot()
                body.status = if __L1.world.phase == "finished" then "finished" else "playing"
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
                __L1.rttMs = if __t(__L1.rttMs) then __L1.rttMs * 0.7 + (window.performance:now() - requestClock) * 0.3 else window.performance:now() - requestClock
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
                        local ____t_218 = __t
                        local ____temp_217 = e.status == 409
                        if ____temp_217 then
                            local ____opt_215 = __L1.room
                            if ____opt_215 ~= nil then
                                ____opt_215 = ____opt_215.status
                            end
                            ____temp_217 = ____opt_215 == "lobby"
                        end
                        if ____t_218(____temp_217) then
                            __L1.room.status = "syncing"
                            __L1:notify("A turma começou! Sincronizando a arena…")
                        else
                            __L1:notify(if __t(__call(
                                __arrL({401, 403, 404, 410}, 4),
                                "includes",
                                e.status
                            )) then "Essa sala encerrou ou sua entrada expirou. Crie outra resenha." else "Conexão oscilando. Tentando reconectar…", true)
                        end
                        if __t(__call(
                            __arrL({401, 403, 404, 410}, 4),
                            "includes",
                            e.status
                        )) then
                            __L1:resetInput()
                            local ____opt_221 = __L1.net
                            if ____opt_221 ~= nil then
                                ____opt_221 = ____opt_221.close
                            end
                            if ____opt_221 ~= nil then
                                ____opt_221(____opt_221)
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
                local ____opt_225 = __L1.net
                if ____opt_225 ~= nil then
                    ____opt_225 = ____opt_225.getStatus
                end
                local ____opt_result_227
                if ____opt_225 ~= nil then
                    ____opt_result_227 = ____opt_225(____opt_225)
                end
                local link = ____opt_result_227
                local ____t_232 = __t
                local ____gt_231 = __gt
                local ____opt_result_230
                if link ~= nil then
                    ____opt_result_230 = link.connected
                end
                local cadence = if ____t_232(____gt_231(____opt_result_230, 0) and __ge(link.connected, link.total)) then 500 else 180
                __L1:scheduleSync(if __t(__L1.urgentSync) then 0 else math.max(
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
            local ____opt_233 = __L1.room
            if ____opt_233 ~= nil then
                ____opt_233 = ____opt_233.code
            end
            local code = ____opt_233
            __L1.generation = __L1.generation + 1
            window:clearTimeout(__L1.pollTimer)
            __L1:resetInput()
            local ____opt_237 = __L1.net
            if ____opt_237 ~= nil then
                ____opt_237 = ____opt_237.close
            end
            if ____opt_237 ~= nil then
                ____opt_237(____opt_237)
            end
            __L1.net = nil
            if __t(if __t(old) then code else old) then
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
        local ____t_241 = __t
        local ____t_240 = __t
        local ____temp_239 = not __t(__L1.practice)
        __O[2838] = ____temp_239
        if ____t_241(if ____t_240(____temp_239) then __L1:playing() else __O[2838]) then
            if not __t(window:confirm("Sair da partida e da sala online?")) then
                return
            end
        end
        __L1:leaveRoom()
    end
    __L1.startPractice = function(self)
        __L1:leaveRoom(true)
        __L1.practice = true
        local ____t_243 = __t
        local ____temp_242 = __L1:cleanText(
            __L1["$"](__L1, "arenaName").value,
            20
        )
        __O[2839] = ____temp_242
        local name = if ____t_243(____temp_242) then __O[2839] else "Você"
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
        local ____t_249 = __t
        local ____t_248 = __t
        local ____t_246 = __t
        local ____opt_244 = __L1.credentials
        if ____opt_244 ~= nil then
            ____opt_244 = ____opt_244.isHost
        end
        local ____temp_247 = not ____t_246(____opt_244) or __lt(
            __len(__L1.room.players),
            2
        )
        __O[2840] = ____temp_247
        if ____t_249(if ____t_248(____temp_247) then __O[2840] else not __t(__call(
            __L1.room.players,
            "every",
            function(____, p) return if p.id == __L1:localId() then __L1.ready else p.ready end
        ))) then
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
            facing = if __t(__mod(i, 2)) then -1 else 1,
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
        local ____L1_VERSION_258 = __L1.VERSION
        local ____L1_stateSeq_259 = __L1.stateSeq
        local ____t_253 = __t
        local ____this_251
        ____this_251 = window.crypto
        local ____opt_250 = ____this_251.randomUUID
        local ____temp_252 = ____opt_250 and ____opt_250(____this_251)
        __O[2841] = ____temp_252
        __L1.world = {
            v = ____L1_VERSION_258,
            seq = ____L1_stateSeq_259,
            matchId = if ____t_253(____temp_252) then __O[2841] else tostring(window.Date:now()),
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
                    local commands = if p.id == __L1:localId() then __L1.input else __call(__L1.inputs, "get", p.id)
                    for ____, a in __iterar((__L1.actions)) do
                        local ____set_257 = __set
                        local ____f_used_256 = f.used
                        local ____t_255 = __t
                        local ____getq_result_254 = __getq(commands, a)
                        __O[2842] = ____getq_result_254
                        ____set_257(____f_used_256, a, if ____t_255(____getq_result_254) then __O[2842] else 0)
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
        local ____assign_265 = __assign
        local ____temp_263 = {}
        local ____L1_world_264 = __L1.world
        local ____L1_260, ____stateSeq_261 = __L1, "stateSeq"
        local ____L1_stateSeq_262 = ____L1_260[____stateSeq_261] + 1
        ____L1_260[____stateSeq_261] = ____L1_stateSeq_262
        local s = ____assign_265(
            ____temp_263,
            ____L1_world_264,
            {
                seq = ____L1_stateSeq_262,
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
        local ____t_315 = __t
        local ____t_313 = __t
        local ____t_311 = __t
        local ____t_309 = __t
        local ____t_305 = __t
        local ____t_303 = __t
        local ____t_301 = __t
        local ____t_283 = __t
        local ____t_281 = __t
        local ____t_279 = __t
        local ____t_277 = __t
        local ____t_275 = __t
        local ____t_273 = __t
        local ____t_271 = __t
        local ____t_269 = __t
        local ____t_267 = __t
        local ____temp_266 = if __t(s) then s.v == __L1.VERSION else s
        __O[2843] = ____temp_266
        local ____temp_268 = if ____t_267(____temp_266) then __call(
            __arrL({"countdown", "playing", "finished"}, 3),
            "includes",
            s.phase
        ) else __O[2843]
        __O[2844] = ____temp_268
        local ____temp_270 = if ____t_269(____temp_268) then s.phase ~= "countdown" or __isFiniteN(s.startAt) else __O[2844]
        __O[2845] = ____temp_270
        local ____temp_272 = if ____t_271(____temp_270) then type(s.matchId) == "string" else __O[2845]
        __O[2846] = ____temp_272
        local ____temp_274 = if ____t_273(____temp_272) then __isFiniteN(s.time) else __O[2846]
        __O[2847] = ____temp_274
        local ____temp_276 = if ____t_275(____temp_274) then __isFiniteN(s.remaining) else __O[2847]
        __O[2848] = ____temp_276
        local ____temp_278 = if ____t_277(____temp_276) then __isArray(s.players) else __O[2848]
        __O[2849] = ____temp_278
        local ____temp_280 = if ____t_279(____temp_278) then __ge(
            __len(s.players),
            2
        ) else __O[2849]
        __O[2850] = ____temp_280
        local ____temp_282 = if ____t_281(____temp_280) then __le(
            __len(s.players),
            4
        ) else __O[2850]
        __O[2858] = ____temp_282
        local ____temp_300 = if ____t_283(____temp_282) then __call(
            s.players,
            "every",
            function(____, p)
                local ____t_299 = __t
                local ____t_297 = __t
                local ____t_295 = __t
                local ____t_293 = __t
                local ____t_291 = __t
                local ____t_289 = __t
                local ____t_287 = __t
                local ____opt_284 = __L1:kit(p.character)
                if ____opt_284 ~= nil then
                    ____opt_284 = ____opt_284.id
                end
                local ____temp_286 = if __t(p) then ____opt_284 == p.character else p
                __O[2851] = ____temp_286
                local ____temp_288 = if ____t_287(____temp_286) then type(p.id) == "string" else __O[2851]
                __O[2852] = ____temp_288
                local ____temp_290 = if ____t_289(____temp_288) then type(p.name) == "string" else __O[2852]
                __O[2853] = ____temp_290
                local ____temp_292 = if ____t_291(____temp_290) then __call(
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
                ) else __O[2853]
                __O[2854] = ____temp_292
                local ____temp_294 = if ____t_293(____temp_292) then math.abs(p.x) < 10000 else __O[2854]
                __O[2855] = ____temp_294
                local ____temp_296 = if ____t_295(____temp_294) then math.abs(p.y) < 10000 else __O[2855]
                __O[2856] = ____temp_296
                local ____temp_298 = if ____t_297(____temp_296) then __ge(p.stocks, 0) else __O[2856]
                __O[2857] = ____temp_298
                return if ____t_299(____temp_298) then __le(p.stocks, 3) else __O[2857]
            end
        ) else __O[2858]
        __O[2859] = ____temp_300
        local ____temp_302 = if ____t_301(____temp_300) then __isArray(s.shots) else __O[2859]
        __O[2860] = ____temp_302
        local ____temp_304 = if ____t_303(____temp_302) then __le(
            __len(s.shots),
            36
        ) else __O[2860]
        __O[2862] = ____temp_304
        local ____temp_308 = if ____t_305(____temp_304) then __call(
            s.shots,
            "every",
            function(____, p)
                local ____t_307 = __t
                local ____temp_306 = if __t(p) then __call(
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
                ) else p
                __O[2861] = ____temp_306
                return if ____t_307(____temp_306) then type(p.type) == "string" else __O[2861]
            end
        ) else __O[2862]
        __O[2863] = ____temp_308
        local ____temp_310 = if ____t_309(____temp_308) then __isArray(s.attacks) else __O[2863]
        __O[2864] = ____temp_310
        local ____temp_312 = if ____t_311(____temp_310) then __le(
            __len(s.attacks),
            12
        ) else __O[2864]
        __O[2865] = ____temp_312
        local ____temp_314 = if ____t_313(____temp_312) then __isArray(s.events) else __O[2865]
        __O[2866] = ____temp_314
        return if ____t_315(____temp_314) then __le(
            __len(s.events),
            12
        ) else __O[2866]
    end
    __L1.direction = function(self, i, p)
        local ____t_317 = __t
        local ____TS__Number_result_316 = __TS__Number(i.aim)
        __O[2867] = ____TS__Number_result_316
        local a = if ____t_317(____TS__Number_result_316) then __O[2867] else 0
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
        __L1.input.aim = if __L1.input.y < -0.35 then 3 else if __L1.input.y > 0.35 then 4 else if __L1.input.x < -0.25 then 1 else if __L1.input.x > 0.25 then 2 else 0
    end
    __L1.trigger = function(self, action)
        if not __t(__L1:playing()) then
            return
        end
        if action == "jump" then
            local ____L1_input_318, ____jumpPress_319 = __L1.input, "jumpPress"
            ____L1_input_318[____jumpPress_319] = ____L1_input_318[____jumpPress_319] + 1
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
            local ____t_322 = __t
            local ____t_321 = __t
            local ____temp_320 = not __t(__L1:isHost())
            __O[2868] = ____temp_320
            if ____t_322(if ____t_321(____temp_320) then __call(
                __arrL({"attack", "special", "ultimate"}, 3),
                "includes",
                action
            ) else __O[2868]) then
                local p = __call(
                    __L1.world.players,
                    "find",
                    function(____, p) return p.id == __L1:localId() end
                )
                if __t(if __t(p) then action ~= "ultimate" or __ge(p.comboHits, 3) else p) then
                    local kind = if action == "attack" then "physical" else if action == "special" then "ranged" else "combo"
                    local dir = __L1:direction(__L1.input, p)
                    local d = __L1:descriptor(p, kind, dir)
                    local total = math.max(
                        0.35,
                        __add(
                            __add(if __t(d.windup) then d.windup else 0.1, if __t(d.duration) then d.duration else 0.15),
                            if __t(d.recovery) then d.recovery else 0.2
                        )
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
        local ____L1_input_331 = __L1.input
        local ____L1_clamp_330 = __L1.clamp
        local ____t_329 = __t
        local ____opt_325 = window.ControlSettings
        if ____opt_325 ~= nil then
            ____opt_325 = ____opt_325.getState
        end
        local ____opt_result_327
        if ____opt_325 ~= nil then
            ____opt_result_327 = ____opt_325(____opt_325).sensitivity
        end
        local ____TS__Number_result_328 = __TS__Number(____opt_result_327)
        __O[2869] = ____TS__Number_result_328
        ____L1_input_331.response = ____L1_clamp_330(__L1, if ____t_329(____TS__Number_result_328) then __O[2869] else 1, 0.5, 2)
        local ____t_337 = __t
        local ____opt_334 = __L1.controls
        if ____opt_334 ~= nil then
            ____opt_334 = ____opt_334.isEditing
        end
        local ____opt_result_336
        if ____opt_334 ~= nil then
            ____opt_result_336 = ____opt_334(____opt_334)
        end
        if ____t_337(____opt_result_336) then
            __L1.input.x = 0
            __L1.input.y = 0
            __L1.input.jump = false
            return
        end
        local ____Set_340 = Set
        local ____arr_339 = __arr
        local ____array_338 = __TS__SparseArrayNew(__TS__Spread(__iter(__call(__L1.heldPointers, "values"))))
        __TS__SparseArrayPush(
            ____array_338,
            __TS__Spread(__iter(__L1.held))
        )
        local heldActions = __TS__New(
            ____Set_340,
            ____arr_339(__TS__SparseArraySpread(____array_338))
        )
        __L1.input.x = __L1:clamp(if __t(__call(heldActions, "has", "right")) then 1 else 0 - if __t(__call(heldActions, "has", "left")) then 1 else 0 + __L1.joystickInput.x, -1, 1)
        __L1.input.y = __L1:clamp(if __t(__call(heldActions, "has", "down")) then 1 else 0 - if __t(__call(heldActions, "has", "up")) then 1 else 0 + __L1.joystickInput.y, -1, 1)
        __L1.input.jump = __call(heldActions, "has", "jump")
        if __t(__L1.input.x) then
            __L1.aim = __L1.input.x
        end
        local ____t_343 = __t
        local ____t_342 = __t
        local ____call_result_341 = __call(heldActions, "has", "attack")
        __O[2870] = ____call_result_341
        if ____t_343(if ____t_342(____call_result_341) then window.performance:now() - __L1.inputAt > 330 else __O[2870]) then
            __L1:captureAim()
            local ____L1_input_344, ____attack_345 = __L1.input, "attack"
            ____L1_input_344[____attack_345] = ____L1_input_344[____attack_345] + 1
            __L1.inputAt = window.performance:now()
            __L1:syncNow()
        end
    end
    __L1.acceptInput = function(self, id, command)
        local ____t_352 = __t
        local ____t_347 = __t
        local ____temp_346 = not __t(command) or not __t(__isSafeInteger(command.seq))
        __O[2871] = ____temp_346
        local ____t_351 = __t
        local ____callq_350 = __callq
        local ____opt_348 = __L1.room
        if ____opt_348 ~= nil then
            ____opt_348 = ____opt_348.players
        end
        if ____t_352(if ____t_347(____temp_346) then __O[2871] else not ____t_351(____callq_350(
            ____opt_348,
            "some",
            function(____, p) return p.id == id end
        ))) then
            return
        end
        local previous = __call(__L1.inputs, "get", id)
        if __t(if __t(previous) then __ge(previous.seq, command.seq) else previous) then
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
                local ____t_354 = __t
                local ____isSafeInteger_result_353 = __isSafeInteger(__get(command, k))
                __O[2872] = ____isSafeInteger_result_353
                return if ____t_354(____isSafeInteger_result_353) then __ge(
                    __get(command, k),
                    0
                ) else __O[2872]
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
                local ____t_356 = __t
                local ____temp_355 = __gt(a.stocks, 0) and __le(a.respawn, 0)
                __O[2873] = ____temp_355
                return if ____t_356(____temp_355) then a.id ~= p.id else __O[2873]
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
        local ____t_358 = __t
        local ____call_result_357 = __call(
            __L1.STAGE,
            "find",
            function(____, s) return s.main end
        )
        __O[2874] = ____call_result_357
        local main = if ____t_358(____call_result_357) then __O[2874] else __get(__L1.STAGE, 0)
        local left = main.x + 14
        local right = main.x + main.w - 14
        local offstage = __lt(p.x, left) or __gt(p.x, right)
        local below = __gt(p.y, main.y + 6)
        local ____t_361 = __t
        local ____t_360 = __t
        local ____temp_359 = not __t(p.ground)
        __O[2875] = ____temp_359
        if ____t_361(if ____t_360(____temp_359) then if __t(offstage) then offstage else below else __O[2875]) then
            base.x = __TS__MathSign(main.x + main.w / 2 - p.x)
            local ____t_364 = __t
            local ____t_363 = __t
            local ____temp_362 = __le(p.stun, 0) and __gt(p.vy, -90)
            __O[2876] = ____temp_362
            if ____t_364(if ____t_363(____temp_362) then __ge(__L1.world.time, if __t(p.botJumpAt) then p.botJumpAt else 0) else __O[2876]) then
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
        local want = if math.abs(dx) > 54 then __TS__MathSign(dx) else 0
        local ____t_366 = __t
        local ____temp_365 = want < 0 and __lt(p.x, left + 30)
        __O[2877] = ____temp_365
        local edge = if ____t_366(____temp_365) then __O[2877] else want > 0 and __gt(p.x, right - 30)
        base.x = if __t(if __t(edge) then p.ground else edge) then 0 else want
        base.y = if dy < -75 then -1 else if dy > 80 then 1 else 0
        base.aim = if __lt(base.y, 0) then 3 else if __gt(base.y, 0) then 4 else if dx < 0 then 1 else 2
        local ____p_369 = p
        local ____t_368 = __t
        local ____TS__MathSign_result_367 = __TS__MathSign(dx)
        __O[2878] = ____TS__MathSign_result_367
        ____p_369.facing = if ____t_368(____TS__MathSign_result_367) then __O[2878] else p.facing
        if __ge(__L1.world.time, p.botNext) then
            local ____t_376 = __t
            local ____t_375 = __t
            local ____t_373 = __t
            local ____t_371 = __t
            local ____temp_370 = __gt(target.attackAnim, 0) and math.abs(dx) < 110
            __O[2879] = ____temp_370
            local ____temp_372 = if ____t_371(____temp_370) then math.abs(dy) < 90 else __O[2879]
            __O[2880] = ____temp_372
            local ____temp_374 = if ____t_373(____temp_372) then __le(p.dashCD, 0) else __O[2880]
            __O[2881] = ____temp_374
            if ____t_376(if ____t_375(____temp_374) then math.random() < 0.3 else __O[2881]) then
                base.dash = base.dash + 1
                local ____t_378 = __t
                local ____temp_377 = -__TS__MathSign(dx)
                __O[2882] = ____temp_377
                base.x = if ____t_378(____temp_377) then __O[2882] else 1
            else
                if __t(dy < -65 and __lt(p.jumps, 2)) then
                    base.jumpPress = base.jumpPress + 1
                end
                if __t(math.abs(dx) < 125 and math.abs(dy) < 100) then
                    base.attack = base.attack + 1
                elseif __le(p.skillCD, 0) then
                    base.special = base.special + 1
                end
                local ____t_381 = __t
                local ____t_380 = __t
                local ____temp_379 = __ge(p.comboHits, 3) and math.abs(dx) < 135
                __O[2883] = ____temp_379
                if ____t_381(if ____t_380(____temp_379) then math.abs(dy) < 100 else __O[2883]) then
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
        if __t(if __t(primary) then __len(__call(
            __L1.effectFrames,
            "filter",
            function(____, e) return e.type ~= "spark" end
        )) >= 8 else primary) then
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
                    life = if ____type == "ko" then 0.48 else if ____type == "combo" then 0.32 else 0.16,
                    maxLife = if ____type == "ko" then 0.48 else if ____type == "combo" then 0.32 else 0.16,
                    color = color,
                    type = ____type
                }, extra)
            )
        end
        local budget = if __L1.renderCost > 20 then 1 else if __t(primary) then 3 else math.min(3, count)
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
        local ____assign_386 = __assign
        local ____temp_385 = {}
        local ____L1_world_382, ____eventSerial_383 = __L1.world, "eventSerial"
        local ____L1_world_eventSerial_384 = ____L1_world_382[____eventSerial_383] + 1
        ____L1_world_382[____eventSerial_383] = ____L1_world_eventSerial_384
        local e = ____assign_386(____temp_385, {
            id = ____L1_world_eventSerial_384,
            name = name,
            x = x,
            y = y,
            color = if __t(extra.color) then extra.color else "#fff0bd"
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
        for ____, e in __iterar((if __t(__L1.world.events) then __L1.world.events else __arrL({}, 0))) do
            if __le(e.id, __L1.lastEventId) then
                continue
            end
            __L1.lastEventId = e.id
            local sound = if __t(e.sound) then e.sound else e.name
            local ____t_389 = __t
            local ____opt_387 = window.ArenaSound
            if ____opt_387 ~= nil then
                ____opt_387 = ____opt_387.play
            end
            if ____t_389(____opt_387) then
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
                local ____t_391 = __t
                local ____TS__Number_result_390 = __TS__Number(e.power)
                __O[2884] = ____TS__Number_result_390
                local power = if ____t_391(____TS__Number_result_390) then __O[2884] else 0
                local k = if __t(__L1.calmMotion) then 0.25 else 1
                if e.name == "ko" then
                    __L1.shakeAmount = math.max(__L1.shakeAmount, 16 * k)
                    __L1.flashAmount = 0.42 * k
                    __L1.flashColor = if __t(e.color) then e.color else "#fff7d6"
                else
                    __L1.shakeAmount = math.max(
                        __L1.shakeAmount,
                        math.min(13, if e.name == "combo" then 4 else 1.5 + power / 85) * k
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
                __L1:effects(
                    e.x,
                    e.y,
                    e.color,
                    if e.name == "ko" then 28 else if e.name == "combo" then 20 else 8,
                    e.name,
                    {text = if __t(e.text) then e.text else "", radius = if __t(e.radius) then e.radius else 30, shape = e.shape}
                )
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
                        local ____t_393 = __t
                        local ____temp_392 = __gt(q.stocks, 0) and __le(q.respawn, 0)
                        __O[2885] = ____temp_392
                        return if ____t_393(____temp_392) then q.id ~= p.id else __O[2885]
                    end
                ),
                "sort",
                function(____, a, b) return __hypot(a.x - p.x, a.y - p.y) - __hypot(b.x - p.x, b.y - p.y) end
            ),
            0
        )
    end
    __L1.descriptor = function(self, p, kind, dir)
        local ____t_399 = __t
        local ____opt_396 = window.ArenaCombat
        if ____opt_396 ~= nil then
            ____opt_396 = ____opt_396.attack
        end
        local ____opt_result_398
        if ____opt_396 ~= nil then
            ____opt_result_398 = ____opt_396(
                ____opt_396,
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
        __O[2887] = ____opt_result_398
        local ____assign_404 = __assign
        local ____temp_402 = {}
        local ____temp_403 = {
            id = kind,
            name = kind,
            kind = kind,
            direction = dir,
            damage = if kind == "physical" then 8 else if kind == "combo" then 28 else 7,
            knockback = if kind == "combo" then 700 else if kind == "physical" then 170 else 145,
            angle = if dir == "up" then -math.pi / 2 else if dir == "down" then math.pi / 2 else -0.25,
            reach = 62,
            radius = 26,
            windup = 0.1,
            duration = 0.14,
            recovery = 0.3,
            cooldown = if kind == "ranged" then 0.65 else 0.4,
            color = __L1:kit(p.character).color,
            shape = "fist"
        }
        local ____t_401 = __t
        local ____table_shot_400 = __L1:kit(p.character).shot
        __O[2886] = ____table_shot_400
        return if ____t_399(____opt_result_398) then __O[2887] else ____assign_404(____temp_402, ____temp_403, if kind == "ranged" then {projectile = {type = if ____t_401(____table_shot_400) then __O[2886] else "paper", speed = 500, life = 1.7}} else {})
    end
    __L1.startAttack = function(self, p, kind, i)
        local ____t_407 = __t
        local ____t_406 = __t
        local ____temp_405 = __gt(p.stun, 0) or __gt(p.respawn, 0)
        __O[2888] = ____temp_405
        if ____t_407(if ____t_406(____temp_405) then __O[2888] else __le(p.stocks, 0)) then
            return false
        end
        local ____t_410 = __t
        local ____t_409 = __t
        local ____temp_408 = kind == "physical" and __gt(p.cd, 0)
        __O[2889] = ____temp_408
        if ____t_410(if ____t_409(____temp_408) then __O[2889] else kind == "ranged" and __gt(p.skillCD, 0)) then
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
        local ____L1_world_411, ____shotSerial_412 = __L1.world, "shotSerial"
        local ____L1_world_shotSerial_413 = ____L1_world_411[____shotSerial_412] + 1
        ____L1_world_411[____shotSerial_412] = ____L1_world_shotSerial_413
        local id = ____L1_world_shotSerial_413
        local ____t_420 = __t
        local ____t_419 = __t
        local ____t_417 = __t
        local ____t_415 = __t
        local ____temp_414 = kind == "physical" and dir == "up"
        __O[2890] = ____temp_414
        local ____temp_416 = if ____t_415(____temp_414) then not __t(p.ground) else __O[2890]
        __O[2891] = ____temp_416
        local ____temp_418 = if ____t_417(____temp_416) then not __t(p.recoveryUsed) else __O[2891]
        __O[2892] = ____temp_418
        if ____t_420(if ____t_419(____temp_418) then __le(p.stun, 0) else __O[2892]) then
            p.recoveryUsed = true
            p.launch = 0
            p.vy = math.min(p.vy, -560)
        end
        p.emote = 0
        p.attackAnim = math.max(
            0.35,
            __add(
                __add(if __t(d.windup) then d.windup else 0.1, if __t(d.duration) then d.duration else 0.15),
                if __t(d.recovery) then d.recovery else 0.2
            )
        )
        p.attackTotal = p.attackAnim
        p.attackProgress = 0
        p.attackType = kind
        p.attackDirection = dir
        p.attackShape = if __t(d.shape) then d.shape else "fist"
        p.quote = if kind == "combo" then 2.5 else 0.65
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
            p.cd = if __t(d.cooldown) then d.cooldown else 0.43
        elseif kind == "ranged" then
            p.skillCD = if __t(d.cooldown) then d.cooldown else 0.72
        else
            p.comboHits = 0
            p.cd = math.max(p.cd, 0.9)
            p.skillCD = math.max(p.skillCD, 0.9)
        end
        if __t(d.transform) then
            p.transform = d.transform
            p.form = if __t(d.form) then d.form else "powered"
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
        local ____t_426 = __t
        local ____t_422 = __t
        local ____temp_421 = kind == "combo"
        __O[2893] = ____temp_421
        local ____lenq_425 = __lenq
        local ____opt_423 = d.finisher
        if ____opt_423 ~= nil then
            ____opt_423 = ____opt_423.hits
        end
        local hits = if ____t_426(if ____t_422(____temp_421) then ____lenq_425(____opt_423) else __O[2893]) then d.finisher.hits else __arrL({{
            delay = 0,
            damage = d.damage,
            knockback = d.knockback,
            angle = d.angle,
            dx = if __t(dir == "up" or dir == "down") then 0 else if __t(d.reach) then d.reach else 60 * 0.65,
            dy = if dir == "up" then -34 - if __t(d.reach) then d.reach else 60 * 0.6 else if dir == "down" then -34 + if __t(d.reach) then d.reach else 60 * 0.55 else -34,
            radius = if __t(d.radius) then d.radius else 26,
            shape = d.shape
        }}, 1)
        if __t(kind ~= "ranged" or not __t(d.projectile)) then
            do
                local index = 0
                while __lt(
                    index,
                    __len(hits)
                ) do
                    local h = __get(hits, index)
                    local ____call_448 = __call
                    local ____L1_world_queue_447 = __L1.world.queue
                    local ____assign_446 = __assign
                    local ____temp_444 = {}
                    local ____temp_445 = {
                        owner = p.id,
                        attackId = id,
                        kind = kind,
                        facing = p.facing,
                        at = __add(
                            __add(__L1.world.time, if __t(d.windup) then d.windup else 0.1),
                            if __t(h.delay) then h.delay else 0
                        ),
                        duration = 0.16,
                        stage = index,
                        targetId = nil
                    }
                    local ____h_damage_427 = h.damage
                    if ____h_damage_427 == nil then
                        ____h_damage_427 = d.damage
                    end
                    local ____h_knockback_428 = h.knockback
                    if ____h_knockback_428 == nil then
                        ____h_knockback_428 = d.knockback
                    end
                    local ____h_angle_429 = h.angle
                    if ____h_angle_429 == nil then
                        ____h_angle_429 = d.angle
                    end
                    local ____temp_439 = if __t(d.color) then d.color else __L1:kit(p.character).color
                    local ____t_432 = __t
                    local ____opt_430 = d.finisher
                    if ____opt_430 ~= nil then
                        ____opt_430 = ____opt_430.sound
                    end
                    __O[2894] = ____opt_430
                    local ____temp_440 = if index == __len(hits) - 1 then if ____t_432(____opt_430) then __O[2894] else d.sound else nil
                    local ____temp_441 = if __t(d.slow) then d.slow else 0
                    local ____temp_442 = if __t(d.slowFactor) then d.slowFactor else 0.7
                    local ____t_435 = __t
                    local ____opt_433 = d.finisher
                    if ____opt_433 ~= nil then
                        ____opt_433 = ____opt_433.grab
                    end
                    __O[2895] = ____opt_433
                    local ____temp_443 = if ____t_435(____opt_433) then __O[2895] else 0
                    local ____t_438 = __t
                    local ____opt_436 = d.finisher
                    if ____opt_436 ~= nil then
                        ____opt_436 = ____opt_436.summon
                    end
                    __O[2896] = ____opt_436
                    ____call_448(
                        ____L1_world_queue_447,
                        "push",
                        ____assign_446(____temp_444, ____temp_445, h, {
                            damage = ____h_damage_427,
                            knockback = ____h_knockback_428,
                            angle = ____h_angle_429,
                            color = ____temp_439,
                            sound = ____temp_440,
                            slow = ____temp_441,
                            slowFactor = ____temp_442,
                            grab = ____temp_443,
                            summon = if ____t_438(____opt_436) then __O[2896] else nil
                        })
                    )
                    index = index + 1
                end
            end
        end
        if __t(d.projectile) then
            local ____call_467 = __call
            local ____L1_world_queue_466 = __L1.world.queue
            local ____p_id_463 = p.id
            local ____kind_464 = kind
            local ____add_result_465 = __add(__L1.world.time, if __t(d.windup) then d.windup else 0.1)
            local ____assign_462 = __assign
            local ____temp_460 = {}
            local ____d_projectile_461 = d.projectile
            local ____d_projectile_damage_449 = d.projectile.damage
            if ____d_projectile_damage_449 == nil then
                ____d_projectile_damage_449 = d.damage
            end
            local ____d_projectile_knockback_450 = d.projectile.knockback
            if ____d_projectile_knockback_450 == nil then
                ____d_projectile_knockback_450 = d.knockback
            end
            local ____temp_459 = if __t(d.angle) then d.angle else 0
            local ____d_projectile_slow_451 = d.projectile.slow
            if ____d_projectile_slow_451 == nil then
                ____d_projectile_slow_451 = d.slow
            end
            local ____d_projectile_slow_451_452 = ____d_projectile_slow_451
            if ____d_projectile_slow_451_452 == nil then
                ____d_projectile_slow_451_452 = 0
            end
            local ____d_projectile_slowFactor_453 = d.projectile.slowFactor
            if ____d_projectile_slowFactor_453 == nil then
                ____d_projectile_slowFactor_453 = d.slowFactor
            end
            local ____d_projectile_slowFactor_453_454 = ____d_projectile_slowFactor_453
            if ____d_projectile_slowFactor_453_454 == nil then
                ____d_projectile_slowFactor_453_454 = 0.7
            end
            local ____d_projectile_boomerang_455 = d.projectile.boomerang
            if ____d_projectile_boomerang_455 == nil then
                ____d_projectile_boomerang_455 = d.boomerang
            end
            local ____d_projectile_boomerang_455_456 = ____d_projectile_boomerang_455
            if ____d_projectile_boomerang_455_456 == nil then
                ____d_projectile_boomerang_455_456 = false
            end
            local ____d_projectile_returnGain_457 = d.projectile.returnGain
            if ____d_projectile_returnGain_457 == nil then
                ____d_projectile_returnGain_457 = d.returnGain
            end
            local ____d_projectile_returnGain_457_458 = ____d_projectile_returnGain_457
            if ____d_projectile_returnGain_457_458 == nil then
                ____d_projectile_returnGain_457_458 = 0
            end
            ____call_467(
                ____L1_world_queue_466,
                "push",
                {
                    owner = ____p_id_463,
                    attackId = id,
                    kind = "projectile",
                    sourceKind = ____kind_464,
                    at = ____add_result_465,
                    config = ____assign_462(____temp_460, ____d_projectile_461, {
                        damage = ____d_projectile_damage_449,
                        knockback = ____d_projectile_knockback_450,
                        angle = ____temp_459,
                        slow = ____d_projectile_slow_451_452,
                        slowFactor = ____d_projectile_slowFactor_453_454,
                        boomerang = ____d_projectile_boomerang_455_456,
                        returnGain = ____d_projectile_returnGain_457_458,
                        color = if __t(d.color) then d.color else __L1:kit(p.character).color,
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
        local ____t_470 = __t
        local ____t_469 = __t
        local ____temp_468 = not __t(p) or __le(p.stocks, 0)
        __O[2897] = ____temp_468
        if ____t_470(if ____t_469(____temp_468) then __O[2897] else __gt(p.respawn, 0)) then
            return
        end
        if q.kind == "projectile" then
            local s = q.config
            local count = __L1:clamp(if __t(s.count) then s.count else 1, 1, 5)
            local dir = s.direction
            local angle = if __t(q.sourceKind == "physical" and s.motion == "wave") then 0 else if __isFiniteN(s.angle) then s.angle else if dir == "up" then -math.pi / 2 else if dir == "down" then math.pi / 2 else 0
            do
                local j = 0
                while j < count do
                    local a = angle + (j - (count - 1) / 2) * if __t(s.spread) then s.spread else 0.12
                    local speed = if __t(s.speed) then s.speed else 440
                    local ____call_495 = __call
                    local ____L1_world_shots_494 = __L1.world.shots
                    local ____L1_world_471, ____shotSerial_472 = __L1.world, "shotSerial"
                    local ____L1_world_shotSerial_473 = ____L1_world_471[____shotSerial_472] + 1
                    ____L1_world_471[____shotSerial_472] = ____L1_world_shotSerial_473
                    local ____p_id_477 = p.id
                    local ____q_attackId_478 = q.attackId
                    local ____temp_479 = if __t(s.type) then s.type else "paper"
                    local ____temp_480 = p.x + p.facing * 24
                    local ____temp_481 = if __t(q.sourceKind == "physical" and s.motion == "wave") then p.y - 8 else p.y - 33
                    local ____temp_482 = if __isFiniteN(s.vx) then s.vx * p.facing else math.cos(a) * speed * p.facing
                    local ____temp_483 = if __isFiniteN(s.vy) then s.vy else math.sin(a) * speed
                    local ____t_475 = __t
                    local ____temp_474 = if __t(s.radius) then s.radius else s.r
                    __O[2898] = ____temp_474
                    local ____temp_484 = if ____t_475(____temp_474) then __O[2898] else 11
                    local ____temp_485 = if __t(s.life) then s.life else 1.75
                    local ____temp_486 = if __t(s.life) then s.life else 1.75
                    local ____temp_487 = if __t(s.damage) then s.damage else 7
                    local ____temp_488 = if __t(s.knockback) then s.knockback else 150
                    local ____temp_489 = if __t(s.angle) then s.angle else -0.2
                    local ____temp_490 = if __t(s.gravity) then s.gravity else 0
                    local ____s_color_491 = s.color
                    local ____temp_492 = if __t(s.motion) then s.motion else "straight"
                    local ____temp_493 = not not __t(s.boomerang) or s.motion == "tether"
                    local ____s_returnAfter_476 = s.returnAfter
                    if ____s_returnAfter_476 == nil then
                        ____s_returnAfter_476 = if __t(s.life) then s.life else 1.75 * 0.43
                    end
                    ____call_495(
                        ____L1_world_shots_494,
                        "push",
                        {
                            id = ____L1_world_shotSerial_473,
                            owner = ____p_id_477,
                            attackId = ____q_attackId_478,
                            type = ____temp_479,
                            x = ____temp_480,
                            y = ____temp_481,
                            vx = ____temp_482,
                            vy = ____temp_483,
                            r = ____temp_484,
                            life = ____temp_485,
                            maxLife = ____temp_486,
                            damage = ____temp_487,
                            knockback = ____temp_488,
                            angle = ____temp_489,
                            gravity = ____temp_490,
                            color = ____s_color_491,
                            motion = ____temp_492,
                            boomerang = ____temp_493,
                            returnAfter = ____s_returnAfter_476,
                            returnGain = if __t(s.returnGain) then s.returnGain else 0,
                            slow = if __t(s.slow) then s.slow else 0,
                            slowFactor = if __t(s.slowFactor) then s.slowFactor else 0.7,
                            hitIds = __arrL({}, 0),
                            home = not not __t(s.homing),
                            returning = false,
                            startX = p.x,
                            startY = p.y - 33,
                            dir = p.facing,
                            text = if __t(s.text) then s.text else "",
                            variant = if __t(s.variant) then s.variant else ""
                        }
                    )
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
        local ____opt_result_498
        if a ~= nil then
            ____opt_result_498 = a.id
        end
        local locked = if ____opt_result_498 == q.attackId then a.targetId else nil
        local ____t_501 = __t
        local ____t_500 = __t
        local ____temp_499 = q.warp == "target"
        __O[2899] = ____temp_499
        if ____t_501(if ____t_500(____temp_499) then locked else __O[2899]) then
            local target = __call(
                __L1.world.players,
                "find",
                function(____, t)
                    local ____t_503 = __t
                    local ____temp_502 = t.id == locked and __gt(t.stocks, 0)
                    __O[2900] = ____temp_502
                    return if ____t_503(____temp_502) then __le(t.respawn, 0) else __O[2900]
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
        local ____q_dx_504 = q.dx
        if ____q_dx_504 == nil then
            ____q_dx_504 = 45
        end
        local dx = ____q_dx_504 * if __t(q.facing) then q.facing else p.facing
        local ____q_dy_505 = q.dy
        if ____q_dy_505 == nil then
            ____q_dy_505 = -33
        end
        local dy = ____q_dy_505
        local ____call_513 = __call
        local ____L1_world_attacks_512 = __L1.world.attacks
        local ____assign_511 = __assign
        local ____temp_509 = {}
        local ____q_510 = q
        local ____L1_world_506, ____shotSerial_507 = __L1.world, "shotSerial"
        local ____L1_world_shotSerial_508 = ____L1_world_506[____shotSerial_507] + 1
        ____L1_world_506[____shotSerial_507] = ____L1_world_shotSerial_508
        ____call_513(
            ____L1_world_attacks_512,
            "push",
            ____assign_511(
                ____temp_509,
                ____q_510,
                {
                    id = ____L1_world_shotSerial_508,
                    x = p.x + dx,
                    y = __add(p.y, dy),
                    dx = dx,
                    dy = dy,
                    r = if __t(q.radius) then q.radius else 29,
                    life = if __t(q.duration) then q.duration else 0.16,
                    hitIds = __arrL({}, 0),
                    follow = true,
                    trackTargetId = if __t(q.kind == "combo" and __gt(q.stage, 0)) then locked else nil
                }
            )
        )
        if __gt(
            __len(__L1.world.attacks),
            12
        ) then
            __call(__L1.world.attacks, "shift")
        end
        local ____opt_result_516
        if a ~= nil then
            ____opt_result_516 = a.id
        end
        if ____opt_result_516 == q.attackId then
            p.comboStage = if __t(q.stage) then q.stage else 0
        end
    end
    __L1.applyHit = function(self, target, hit, source)
        local ____t_519 = __t
        local ____t_518 = __t
        local ____temp_517 = __le(target.stocks, 0) or __gt(target.respawn, 0)
        __O[2901] = ____temp_517
        if ____t_519(if ____t_518(____temp_517) then __O[2901] else __gt(target.inv, 0)) then
            return false
        end
        local ____t_521 = __t
        local ____TS__Number_result_520 = __TS__Number(hit.damage)
        __O[2902] = ____TS__Number_result_520
        local amount = math.max(1, if ____t_521(____TS__Number_result_520) then __O[2902] else 7)
        target.damage = math.min(999, target.damage + amount)
        target.hit = 0.18
        target.emote = 0
        local grounded = not not __t(target.ground)
        target.ground = false
        target.stun = math.min(0.55, 0.12 + amount * 0.009)
        target.inv = if hit.kind == "combo" then 0.14 else 0.16
        target.slow = math.max(target.slow, if __t(hit.slow) then hit.slow else 0)
        target.slowFactor = if __t(hit.slowFactor) then hit.slowFactor else 0.7
        local ____t_523 = __t
        local ____table_weight_522 = __L1:kit(target.character).weight
        __O[2903] = ____table_weight_522
        local weight = if ____t_523(____table_weight_522) then __O[2903] else 1
        local base = if __t(hit.knockback) then hit.knockback else 170 * (0.7 + target.damage / 80) / weight
        local angle = if __isFiniteN(hit.angle) then hit.angle else -0.3
        local ____t_525 = __t
        local ____temp_524 = if __t(hit.facing) then hit.facing else hit.dir
        __O[2904] = ____temp_524
        local face = if ____t_525(____temp_524) then __O[2904] else if __t(source) then source.facing else if __gt(target.x, hit.x) then 1 else -1
        local ____t_528 = __t
        local ____t_527 = __t
        local ____gt_result_526 = __gt(angle, 0.3)
        __O[2905] = ____gt_result_526
        if ____t_528(if ____t_527(____gt_result_526) then grounded else __O[2905]) then
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
        target.launch = if base > 330 then math.min(1.6, 0.35 + base / 900) else 0
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
            local ____t_533 = __t
            local ____t_532 = __t
            local ____temp_531 = hit.kind == "combo"
            if ____temp_531 then
                local ____opt_529 = source.attackState
                if ____opt_529 ~= nil then
                    ____opt_529 = ____opt_529.id
                end
                ____temp_531 = ____opt_529 == hit.attackId
            end
            __O[2906] = ____temp_531
            if ____t_533(if ____t_532(____temp_531) then not __t(source.attackState.targetId) else __O[2906]) then
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
        local ____L1_emitEvent_540 = __L1.emitEvent
        local ____array_539 = __TS__SparseArrayNew(if hit.kind == "combo" then "combo" else "hit", target.x, target.y - 35)
        local ____L1_kit_538 = __L1.kit
        local ____t_537 = __t
        local ____opt_result_536
        if source ~= nil then
            ____opt_result_536 = source.character
        end
        __O[2907] = ____opt_result_536
        __TS__SparseArrayPush(
            ____array_539,
            {
                color = if __t(hit.color) then hit.color else ____L1_kit_538(__L1, if ____t_537(____opt_result_536) then __O[2907] else target.character).color,
                shape = if __t(hit.shape) then hit.shape else hit.type,
                sound = if __t(hit.sound) then hit.sound else "hit",
                text = if hit.kind == "combo" then "COMBO!" else nil,
                power = math.floor(base + 0.5)
            }
        )
        ____L1_emitEvent_540(
            __L1,
            __TS__SparseArraySpread(____array_539)
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
        p.respawn = if __t(p.eliminated) then 0 else 1.35
        if __t(if __t(p.lastAttacker) then __L1.world.time - if __t(p.lastHitAt) then p.lastHitAt else -99 < 10 else p.lastAttacker) then
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
                text = if __t(p.eliminated) then "FORA DA RESENHA" else "−1 VIDA",
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
                    local ____set_544 = __set
                    local ____p_used_543 = p.used
                    local ____t_542 = __t
                    local ____TS__Number_result_541 = __TS__Number(__get(command, action))
                    __O[2908] = ____TS__Number_result_541
                    ____set_544(____p_used_543, action, if ____t_542(____TS__Number_result_541) then __O[2908] else 0)
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
                local ____set_547 = __set
                local ____t_546 = __t
                local ____get_result_545 = __get(p, key)
                __O[2909] = ____get_result_545
                ____set_547(
                    p,
                    key,
                    math.max(0, if ____t_546(____get_result_545) then __O[2909] else 0 - dt)
                )
            end
            if __gt(p.attackAnim, 0) then
                p.attackProgress = __L1:clamp(1 - p.attackAnim / if __t(p.attackTotal) then p.attackTotal else 0.5, 0, 1)
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
                    p.x = 640 + if __t(__mod(
                        __call(w.players, "indexOf", p),
                        2
                    )) then 55 else -55
                    p.vy = 0
                    p.inv = 2.2
                    for ____, a in __iterar((__L1.actions)) do
                        local ____set_551 = __set
                        local ____p_used_550 = p.used
                        local ____t_549 = __t
                        local ____get_result_548 = __get(i, a)
                        __O[2910] = ____get_result_548
                        ____set_551(____p_used_550, a, if ____t_549(____get_result_548) then __O[2910] else __get(p.used, a))
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
            local ____t_555 = __t
            local ____t_553 = __t
            local ____TS__Number_result_552 = __TS__Number(i.seq)
            __O[2911] = ____TS__Number_result_552
            local ____temp_554 = if ____t_553(____TS__Number_result_552) then __O[2911] else p.ackInput
            __O[2912] = ____temp_554
            p.ackInput = if ____t_555(____temp_554) then __O[2912] else 0
            for ____, action in __iterar((__arrL({"attack", "special", "ultimate", "emote"}, 4))) do
                local ____t_557 = __t
                local ____TS__Number_result_556 = __TS__Number(__get(i, action))
                __O[2913] = ____TS__Number_result_556
                local counter = if ____t_557(____TS__Number_result_556) then __O[2913] else 0
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
                        p.emoteKind = if __t(__mod(counter, 2)) then "dance" else "taunt"
                        p.quote = 2.2
                    end
                end
            end
            local ____t_562 = __t
            local ____t_561 = __t
            local ____t_559 = __t
            local ____temp_558 = __lt(p.x, __L1.KO.left) or __gt(p.x, __L1.KO.right)
            __O[2914] = ____temp_558
            local ____temp_560 = if ____t_559(____temp_558) then __O[2914] else __lt(p.y, __L1.KO.top)
            __O[2915] = ____temp_560
            if ____t_562(if ____t_561(____temp_560) then __O[2915] else __gt(p.y, __L1.KO.bottom)) then
                __L1:knockOut(p)
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
            a.life = a.life - dt
            local owner = __call(
                w.players,
                "find",
                function(____, p) return p.id == a.owner end
            )
            local ____t_565 = __t
            local ____t_564 = __t
            local ____temp_563 = not __t(owner) or __le(owner.stocks, 0)
            __O[2916] = ____temp_563
            if ____t_565(if ____t_564(____temp_563) then __O[2916] else __gt(owner.respawn, 0)) then
                a.life = 0
                continue
            end
            if __t(a.follow) then
                a.x = __add(owner.x, a.dx)
                a.y = __add(owner.y, a.dy)
            end
            local locked = if __t(a.trackTargetId) then __call(
                w.players,
                "find",
                function(____, p)
                    local ____t_567 = __t
                    local ____temp_566 = p.id == a.trackTargetId and __gt(p.stocks, 0)
                    __O[2917] = ____temp_566
                    return if ____t_567(____temp_566) then __le(p.respawn, 0) else __O[2917]
                end
            ) else nil
            if __t(locked) then
                a.x = locked.x
                a.y = locked.y - 34
            end
            for ____, p in __iterar((w.players)) do
                local ____t_576 = __t
                local ____t_575 = __t
                local ____t_573 = __t
                local ____t_571 = __t
                local ____t_569 = __t
                local ____temp_568 = p.id ~= a.owner
                __O[2918] = ____temp_568
                local ____temp_570 = if ____t_569(____temp_568) then not __t(a.trackTargetId) or p.id == a.trackTargetId else __O[2918]
                __O[2919] = ____temp_570
                local ____temp_572 = if ____t_571(____temp_570) then not __t(__call(a.hitIds, "includes", p.id)) else __O[2919]
                __O[2920] = ____temp_572
                local ____temp_574 = if ____t_573(____temp_572) then __lt(
                    math.abs(p.x - a.x),
                    a.r + 17
                ) else __O[2920]
                __O[2921] = ____temp_574
                if ____t_576(if ____t_575(____temp_574) then __lt(
                    math.abs(p.y - 34 - a.y),
                    a.r + 31
                ) else __O[2921]) then
                    if __t(__L1:applyHit(p, a, owner)) then
                        __call(a.hitIds, "push", p.id)
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
            if __t(if __t(s.boomerang) then __ge(elapsed, s.returnAfter) else s.boomerang) then
                s.returning = true
            end
            if __t(s.returning) then
                local dx = owner.x - s.x
                local dy = owner.y - 33 - s.y
                local ____t_578 = __t
                local ____hypot_result_577 = __hypot(dx, dy)
                __O[2922] = ____hypot_result_577
                local distance = if ____t_578(____hypot_result_577) then __O[2922] else 1
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
            if __t(if __t(s.home) then not __t(s.returning) else s.home) then
                local t = __L1:nearest(owner)
                if __t(t) then
                    s.vx = s.vx + (__TS__MathSign(t.x - s.x) * 270 - s.vx) * dt * 1.5
                    s.vy = s.vy + __L1:clamp(t.y - 33 - s.y, -170, 170) * dt
                end
            end
            if not __t(s.returning) then
                s.vy = s.vy + if __t(s.gravity) then s.gravity else 0 * dt
            end
            s.x = s.x + s.vx * dt
            s.y = s.y + s.vy * dt
            for ____, p in __iterar((w.players)) do
                local ____t_583 = __t
                local ____t_582 = __t
                local ____t_580 = __t
                local ____temp_579 = p.id == s.owner
                __O[2923] = ____temp_579
                local ____temp_581 = if ____t_580(____temp_579) then __O[2923] else __call(s.hitIds, "includes", p.id)
                __O[2924] = ____temp_581
                if ____t_583(if ____t_582(____temp_581) then __O[2924] else __le(s.life, 0)) then
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
        w.shots = __call(
            w.shots,
            "filter",
            function(____, s)
                local ____t_587 = __t
                local ____t_585 = __t
                local ____temp_584 = __gt(s.life, 0) and __gt(s.x, __L1.KO.left - 150)
                __O[2925] = ____temp_584
                local ____temp_586 = if ____t_585(____temp_584) then __lt(s.x, __L1.KO.right + 150) else __O[2925]
                __O[2926] = ____temp_586
                return if ____t_587(____temp_586) then __lt(s.y, __L1.KO.bottom + 100) else __O[2926]
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
                    local ____t_591 = __t
                    local ____t_589 = __t
                    local ____temp_588 = b.stocks - a.stocks
                    __O[2927] = ____temp_588
                    local ____temp_590 = if ____t_589(____temp_588) then __O[2927] else a.damage - b.damage
                    __O[2928] = ____temp_590
                    return if ____t_591(____temp_590) then __O[2928] else b.kills - a.kills
                end
            )
            local ____opt_592 = __get(ranked, 0)
            if ____opt_592 ~= nil then
                ____opt_592 = ____opt_592.id
            end
            w.winner = if __len(alive) == 1 then __get(alive, 0).id else ____opt_592
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
        __L1["$"](__L1, "arenaWinner").textContent = if __t(winner) then if winner.id == __L1:localId() then "VOCÊ FICOU DE PÉ!" else __add(
            __call(winner.name, "toUpperCase"),
            " LEVOU A ARENA!"
        ) else "EMPATE NA RESENHA"
        __L1["$"](__L1, "arenaResultText").textContent = if __t(winner) then __add(
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
                        if winner.stocks == 1 then "" else "s"
                    ),
                    " restante"
                ),
                if winner.stocks == 1 then "" else "s"
            ),
            "."
        ) else "Ninguém quis deixar o bolo cair."
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
            local ____self_600 = card.style
            local ____self_600_setProperty_601 = ____self_600.setProperty
            local ____t_599 = __t
            local ____opt_596 = window.ArenaCombat
            if ____opt_596 ~= nil then
                ____opt_596 = ____opt_596.damageColor
            end
            local ____opt_result_598
            if ____opt_596 ~= nil then
                ____opt_result_598 = ____opt_596(____opt_596, p.damage)
            end
            __O[2929] = ____opt_result_598
            ____self_600_setProperty_601(____self_600, "--damage", if ____t_599(____opt_result_598) then __O[2929] else "#fffdf0")
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
            card:querySelector(".arena-combo-label").textContent = if __le(p.stocks, 0) then "ASSISTINDO" else if __gt(p.respawn, 0) then "VOLTANDO…" else if __ge(p.comboHits, 3) then "COMBO PRONTO" else __add(p.comboHits, "/3 ACERTOS")
        end
        local ____local = __call(
            __L1.world.players,
            "find",
            function(____, p) return p.id == __L1:localId() end
        )
        local ____t_603 = __t
        local ____temp_602 = not not __t(____local) and __gt(____local.stocks, 0)
        __O[2930] = ____temp_602
        local readyCombo = if ____t_603(____temp_602) then __ge(____local.comboHits, 3) else __O[2930]
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
        local ____assign_614 = __assign
        local ____temp_613 = {}
        local ____t_605 = __t
        local ____table_speed_604 = __L1:kit(p.character).speed
        __O[2931] = ____table_speed_604
        local ____temp_612 = if ____t_605(____table_speed_604) then __O[2931] else 1
        local ____t_611 = __t
        local ____opt_608 = window.ControlSettings
        if ____opt_608 ~= nil then
            ____opt_608 = ____opt_608.getState
        end
        local ____opt_result_610
        if ____opt_608 ~= nil then
            ____opt_result_610 = ____opt_608(____opt_608).sensitivity
        end
        __O[2932] = ____opt_result_610
        return ____assign_614(____temp_613, {speed = ____temp_612, response = if ____t_611(____opt_result_610) then __O[2932] else 1, platforms = __L1.STAGE}, if __t(emit) then {emit = function(____, name, actor) return __L1:emitEvent(
            name,
            actor.x,
            actor.y - 25,
            {
                color = __L1:kit(actor.character).color,
                sound = if __t(name == "wallJump" or name == "doubleJump") then "jump" else name
            }
        ) end} else {})
    end
    __L1.cloneMover = function(self, p)
        return if __t(p) then __assign(
            {},
            p,
            {used = __assign({}, p.used)}
        ) else nil
    end
    __L1.reconcilePrediction = function(self, p, old)
        if not __t(p) then
            return
        end
        local ____t_619 = __t
        local ____t_618 = __t
        local ____t_616 = __t
        local ____temp_615 = not __t(__L1:playing()) or __le(p.stocks, 0)
        __O[2933] = ____temp_615
        local ____temp_617 = if ____t_616(____temp_615) then __O[2933] else __gt(p.respawn, 0)
        __O[2934] = ____temp_617
        if ____t_619(if ____t_618(____temp_617) then __O[2934] else if __t(old) then old.stocks ~= p.stocks else old) then
            __L1.prediction = __L1:cloneMover(p)
            __L1.predictionHistory = __arrL({}, 0)
            __L1.predictionAccumulator = 0
            return
        end
        local ____t_621 = __t
        local ____TS__Number_result_620 = __TS__Number(p.ackInput)
        __O[2935] = ____TS__Number_result_620
        local ack = if ____t_621(____TS__Number_result_620) then __O[2935] else 0
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
        local ____t_631 = __t
        local ____t_625 = __t
        local ____t_623 = __t
        local ____temp_622 = __L1:isHost()
        __O[2936] = ____temp_622
        local ____temp_624 = if ____t_623(____temp_622) then __O[2936] else not __t(__L1:playing())
        __O[2937] = ____temp_624
        local ____opt_628 = __L1.controls
        if ____opt_628 ~= nil then
            ____opt_628 = ____opt_628.isEditing
        end
        local ____opt_result_630
        if ____opt_628 ~= nil then
            ____opt_result_630 = ____opt_628(____opt_628)
        end
        if ____t_631(if ____t_625(____temp_624) then __O[2937] else ____opt_result_630) then
            return
        end
        local p = __call(
            __L1.world.players,
            "find",
            function(____, p) return p.id == __L1:localId() end
        )
        local ____t_634 = __t
        local ____t_633 = __t
        local ____temp_632 = not __t(p) or __le(p.stocks, 0)
        __O[2938] = ____temp_632
        if ____t_634(if ____t_633(____temp_632) then __O[2938] else __gt(p.respawn, 0)) then
            return
        end
        if not __t(__L1.prediction) then
            __L1.prediction = __L1:cloneMover(p)
        end
        __L1.predictionAccumulator = __L1.predictionAccumulator + dt
        do
            local n = 0
            while __t(__L1.predictionAccumulator >= __L1.STEP and n < 4) do
                local ____assign_639 = __assign
                local ____temp_638 = {}
                local ____L1_635, ____inputSeq_636 = __L1, "inputSeq"
                local ____L1_inputSeq_637 = ____L1_635[____inputSeq_636] + 1
                ____L1_635[____inputSeq_636] = ____L1_inputSeq_637
                local command = ____assign_639(____temp_638, {seq = ____L1_inputSeq_637}, __L1.input)
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
        local ____t_648 = __t
        local ____t_647 = __t
        local ____t_645 = __t
        local ____t_643 = __t
        local ____t_641 = __t
        local ____temp_640 = p.id == __L1:localId()
        __O[2939] = ____temp_640
        local ____temp_642 = if ____t_641(____temp_640) then __L1.prediction else __O[2939]
        __O[2940] = ____temp_642
        local ____temp_644 = if ____t_643(____temp_642) then __gt(p.stocks, 0) else __O[2940]
        __O[2941] = ____temp_644
        local ____temp_646 = if ____t_645(____temp_644) then __le(p.respawn, 0) else __O[2941]
        __O[2942] = ____temp_646
        if ____t_648(if ____t_647(____temp_646) then __L1:playing() else __O[2942]) then
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
            elseif __t(if __t(shown.localAttackAt) then window.performance:now() - shown.localAttackAt < 1500 else shown.localAttackAt) then
                shown.attackAnim = 0
                shown.attackProgress = 0
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
        local ____callq_652 = __callq
        local ____opt_result_651
        if before ~= nil then
            ____opt_result_651 = before.players
        end
        local a = ____callq_652(
            ____opt_result_651,
            "find",
            function(____, v) return v.id == p.id end
        )
        local ____callq_656 = __callq
        local ____opt_result_655
        if after ~= nil then
            ____opt_result_655 = after.players
        end
        local b = ____callq_656(
            ____opt_result_655,
            "find",
            function(____, v) return v.id == p.id end
        )
        local x = p.x
        local y = p.y
        local ____t_665 = __t
        local ____t_664 = __t
        local ____t_662 = __t
        local ____t_660 = __t
        local ____t_658 = __t
        local ____temp_657 = if __t(a) then b else a
        __O[2943] = ____temp_657
        local ____temp_659 = if ____t_658(____temp_657) then a.stocks == b.stocks else __O[2943]
        __O[2944] = ____temp_659
        local ____temp_661 = if ____t_660(____temp_659) then __le(a.respawn, 0) else __O[2944]
        __O[2945] = ____temp_661
        local ____temp_663 = if ____t_662(____temp_661) then __le(b.respawn, 0) else __O[2945]
        __O[2946] = ____temp_663
        if ____t_665(if ____t_664(____temp_663) then __hypot(b.x - a.x, b.y - a.y) < 260 else __O[2946]) then
            local ____L1_clamp_669 = __L1.clamp
            local ____temp_668 = targetAt - before.at
            local ____t_667 = __t
            local ____temp_666 = after.at - before.at
            __O[2947] = ____temp_666
            local amount = ____L1_clamp_669(__L1, ____temp_668 / if ____t_667(____temp_666) then __O[2947] else 1, 0, 1)
            x = a.x + (b.x - a.x) * amount
            y = a.y + (b.y - a.y) * amount
        else
            local ____t_672 = __t
            local ____t_671 = __t
            local ____temp_670 = if __t(a) then not __t(b) else a
            __O[2948] = ____temp_670
            if ____t_672(if ____t_671(____temp_670) then __le(a.respawn, 0) else __O[2948]) then
                local age = __L1:clamp((targetAt - before.at) / 1000, 0, 0.15)
                x = a.x + a.vx * age
                y = a.y + a.vy * age
            end
        end
        local factor = if __hypot(x - shown.x, y - shown.y) > 250 then 1 else math.min(1, dt * 22)
        shown.x = shown.x + (x - shown.x) * factor
        shown.y = shown.y + (y - shown.y) * factor
        local ____t_674 = __t
        local ____TS__Number_result_673 = __TS__Number(p.motionTime)
        __O[2949] = ____TS__Number_result_673
        local sourcePoseTime = if ____t_674(____TS__Number_result_673) then __O[2949] else 0
        local ____t_676 = __t
        local ____temp_675 = shown.motion ~= p.motion or shown.visualStock ~= p.stocks
        __O[2950] = ____temp_675
        local poseChanged = if ____t_676(____temp_675) then __O[2950] else sourcePoseTime < if __t(shown.sourcePoseTime) then shown.sourcePoseTime else 0 - 0.08
        shown.motionTime = if __t(poseChanged) then sourcePoseTime else math.max(
            sourcePoseTime,
            __add(if __t(shown.motionTime) then shown.motionTime else 0, if __t(__L1:playing()) then dt else 0)
        )
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
        local ____opt_677 = p.attackState
        if ____opt_677 ~= nil then
            ____opt_677 = ____opt_677.id
        end
        local ____opt_677_679 = ____opt_677
        if ____opt_677_679 == nil then
            ____opt_677_679 = nil
        end
        local swing = ____opt_677_679
        local newSwing = shown.visualSwing ~= swing
        if __t(newSwing) then
            shown.visualSwing = swing
            local ____shown_682 = shown
            local ____t_681 = __t
            local ____TS__Number_result_680 = __TS__Number(p.attackAnim)
            __O[2951] = ____TS__Number_result_680
            ____shown_682.attackAnim = if ____t_681(____TS__Number_result_680) then __O[2951] else 0
        else
            local ____shown_685 = shown
            local ____t_684 = __t
            local ____TS__Number_result_683 = __TS__Number(p.attackAnim)
            __O[2952] = ____TS__Number_result_683
            ____shown_685.attackAnim = math.max(
                0,
                math.min(if ____t_684(____TS__Number_result_683) then __O[2952] else 0, if __t(shown.attackAnim) then shown.attackAnim else 0 - if __t(__L1:playing()) then dt else 0)
            )
        end
        shown.attackProgress = if __gt(shown.attackAnim, 0) then __L1:clamp(1 - shown.attackAnim / if __t(p.attackTotal) then p.attackTotal else 0.5, 0, 1) else 0
        return shown
    end
    __L1.cameraViewport = function(self)
        local top = __L1.safeInsets.top + if __L1.W < 421 then 91 else 51
        local bottom = __L1.safeInsets.bottom + if __t(window:matchMedia("(pointer:coarse)").matches) then __L1:clamp(__L1.H * 0.25, 56, 130) else 14
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
                local ____t_687 = __t
                local ____call_result_686 = __call(positions, "get", p.id)
                __O[2953] = ____call_result_686
                return if ____t_687(____call_result_686) then __O[2953] else p
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
        local zoom = math.min(if __L1.W > 900 then 1.3 else 1.65, fit)
        local targetX = (left + right) / 2
        local targetY = (top + bottom) / 2
        if zoom < __L1.camera.zoom then
            __L1.camera.zoom = zoom
        else
            local ____L1_camera_688, ____zoom_689 = __L1.camera, "zoom"
            ____L1_camera_688[____zoom_689] = ____L1_camera_688[____zoom_689] + (zoom - __L1.camera.zoom) * math.min(1, dt * 2.8)
        end
        local ____L1_camera_690, ____x_691 = __L1.camera, "x"
        ____L1_camera_690[____x_691] = ____L1_camera_690[____x_691] + (targetX - __L1.camera.x) * math.min(1, dt * 5)
        local ____L1_camera_692, ____y_693 = __L1.camera, "y"
        ____L1_camera_692[____y_693] = ____L1_camera_692[____y_693] + (targetY - __L1.camera.y) * math.min(1, dt * 5)
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
        __L1.pixelRatio = math.min(1.5, if __t(window.devicePixelRatio) then window.devicePixelRatio else 1)
        local width = math.floor(__L1.W * __L1.pixelRatio + 0.5)
        local height = math.floor(__L1.H * __L1.pixelRatio + 0.5)
        if __t(canvas.width ~= width or canvas.height ~= height) then
            canvas.width = width
            canvas.height = height
            local style = window:getComputedStyle(__L1.screen)
            for ____, side in __iterar((__arrL({"top", "right", "bottom", "left"}, 4))) do
                local ____set_697 = __set
                local ____L1_safeInsets_696 = __L1.safeInsets
                local ____t_695 = __t
                local ____TS__ParseFloat_result_694 = __TS__ParseFloat(style:getPropertyValue(__add("--arena-safe-", side)))
                __O[2954] = ____TS__ParseFloat_result_694
                ____set_697(____L1_safeInsets_696, side, if ____t_695(____TS__ParseFloat_result_694) then __O[2954] else 0)
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
        local ____t_706 = __t
        local ____t_699 = __t
        local ____temp_698 = __L1:playing()
        __O[2955] = ____temp_698
        local ____t_705 = __t
        local ____opt_702 = __L1.controls
        if ____opt_702 ~= nil then
            ____opt_702 = ____opt_702.isEditing
        end
        local ____opt_result_704
        if ____opt_702 ~= nil then
            ____opt_result_704 = ____opt_702(____opt_702)
        end
        if ____t_706(if ____t_699(____temp_698) then not ____t_705(if __t(__L1.practice) then ____opt_result_704 else __L1.practice) else __O[2955]) then
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
        local raw = if p.id == __L1:localId() then "Você" else if __t(__call(p.id, "startsWith", "bot-")) then __L1:kit(p.character).name else p.name
        local name = if __gt(
            __len(raw),
            11
        ) then __add(
            __call(raw, "slice", 0, 10),
            "…"
        ) else raw
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
        local ____t_709 = __t
        local ____opt_707 = window.ArenaArt
        if ____opt_707 ~= nil then
            ____opt_707 = ____opt_707.drawBackground
        end
        if ____t_709(____opt_707) then
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
        local ____t_712 = __t
        local ____opt_710 = window.ArenaArt
        if ____opt_710 ~= nil then
            ____opt_710 = ____opt_710.drawStage
        end
        if ____t_712(____opt_710) then
            window.ArenaArt:drawStage(c, __L1.STAGE, t)
        else
            for ____, s in __iterar((__L1.STAGE)) do
                c.fillStyle = if __t(s.main) then "#608c45" else "#c18a4c"
                c:fillRect(s.x, s.y, s.w, if __t(s.main) then 35 else 13)
            end
        end
        for ____, s in __iterar((w.shots)) do
            local ____t_715 = __t
            local ____opt_713 = window.ArenaArt
            if ____opt_713 ~= nil then
                ____opt_713 = ____opt_713.drawProjectile
            end
            if ____t_715(____opt_713) then
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
            if __t(__le(p.stocks, 0) or __gt(p.respawn, 0)) then
                continue
            end
            local pos = __call(positions, "get", p.id)
            local view = __assign({}, p, pos, {x = pos.x, y = pos.y})
            local ____t_718 = __t
            local ____opt_716 = window.ArenaArt
            if ____opt_716 ~= nil then
                ____opt_716 = ____opt_716.drawFighter
            end
            if ____t_718(____opt_716) then
                window.ArenaArt:drawFighter(c, view, t)
            else
                c.fillStyle = __L1:kit(p.character).color
                c:fillRect(view.x - 15, view.y - if p.character == "lucas" then 60 else 70, 30, if p.character == "lucas" then 60 else 70)
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
        for ____, e in __iterar((__L1.effectFrames)) do
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
                local ____t_721 = __t
                local ____opt_719 = window.ArenaArt
                if ____opt_719 ~= nil then
                    ____opt_719 = ____opt_719.drawEffect
                end
                if ____t_721(____opt_719) then
                    window.ArenaArt:drawEffect(c, e, t)
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
        local remaining = if __L1.world.phase == "countdown" then math.max(
            0,
            (__L1.world.startAt - window.Date:now() - __L1.serverOffset) / 1000
        ) else 0
        count.hidden = __L1.world.phase ~= "countdown" and window.performance:now() > __L1.goUntil
        if not __t(count.hidden) then
            count:querySelector(".arena-countdown-number").textContent = if remaining > 3 then "" else if remaining > 0 then math.ceil(remaining) else "VAI!"
            count:querySelector(".arena-countdown-label").textContent = if remaining > 3 then "PREPARE O CHAPÉU" else if remaining > 0 then "A RESENHA VAI COMEÇAR" else ""
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
        local ____opt_724 = __L1.net
        if ____opt_724 ~= nil then
            ____opt_724 = ____opt_724.getStatus
        end
        local ____opt_result_726
        if ____opt_724 ~= nil then
            ____opt_result_726 = ____opt_724(____opt_724)
        end
        local link = ____opt_result_726
        local ____L1__24_result_737 = __L1["$"](__L1, "arenaMatchCode")
        local ____add_736 = __add
        local ____add_730 = __add
        local ____add_729 = __add
        local ____opt_727 = __L1.room
        if ____opt_727 ~= nil then
            ____opt_727 = ____opt_727.code
        end
        local ____add_730_result_735 = ____add_730(
            ____add_729("SALA ", ____opt_727),
            " · "
        )
        local ____gt_734 = __gt
        local ____opt_result_733
        if link ~= nil then
            ____opt_result_733 = link.connected
        end
        ____L1__24_result_737.textContent = if __t(__L1.practice) then "TREINO · 3 VIDAS" else ____add_736(____add_730_result_735, if ____gt_734(____opt_result_733, 0) then "CONEXÃO DIRETA" else "ONLINE")
    end
    __L1.frame = function(self, now)
        if not __t(__L1.opened) then
            return
        end
        local dt = __L1:clamp(if __t(__L1.lastFrame) then (now - __L1.lastFrame) / 1000 else __L1.STEP, 0, 0.05)
        __L1.lastFrame = now
        __L1.renderDt = dt
        __L1:pumpInput()
        local ____t_752 = __t
        local ____t_749 = __t
        local ____t_741 = __t
        local ____t_739 = __t
        local ____temp_738 = __L1:isHost()
        __O[2956] = ____temp_738
        local ____temp_740 = if ____t_739(____temp_738) then __L1:inMatch() else __O[2956]
        __O[2957] = ____temp_740
        local ____t_747 = __t
        local ____opt_744 = __L1.controls
        if ____opt_744 ~= nil then
            ____opt_744 = ____opt_744.isEditing
        end
        local ____opt_result_746
        if ____opt_744 ~= nil then
            ____opt_result_746 = ____opt_744(____opt_744)
        end
        local ____temp_748 = if ____t_741(____temp_740) then not ____t_747(if __t(__L1.practice) then ____opt_result_746 else __L1.practice) else __O[2957]
        __O[2958] = ____temp_748
        local ____opt_750 = __L1.room
        if ____opt_750 ~= nil then
            ____opt_750 = ____opt_750.hostConnected
        end
        if ____t_752(if ____t_749(____temp_748) then if __t(__L1.practice) then __L1.practice else ____opt_750 ~= false else __O[2958]) then
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
        local ____t_755 = __t
        local ____t_754 = __t
        local ____temp_753 = if __t(__L1.net) then __L1.credentials else __L1.net
        __O[2959] = ____temp_753
        if ____t_755(if ____t_754(____temp_753) then now - __L1.lastNetAt > 50 else __O[2959]) then
            __L1.lastNetAt = now
            local ____t_758 = __t
            local ____t_757 = __t
            local ____temp_756 = __L1:isHost()
            __O[2960] = ____temp_756
            if ____t_758(if ____t_757(____temp_756) then __L1.world else __O[2960]) then
                local ____this_760
                ____this_760 = __L1.net
                local ____opt_759 = ____this_760.sendState
                if ____opt_759 ~= nil then
                    ____opt_759(
                        ____this_760,
                        __L1:snapshot()
                    )
                end
            else
                local ____this_767
                ____this_767 = __L1.net
                local ____opt_761 = ____this_767.sendInput
                if ____opt_761 ~= nil then
                    local ____assign_766 = __assign
                    local ____temp_765 = {}
                    local ____L1_762, ____inputSeq_763 = __L1, "inputSeq"
                    local ____L1_inputSeq_764 = ____L1_762[____inputSeq_763] + 1
                    ____L1_762[____inputSeq_763] = ____L1_inputSeq_764
                    ____opt_761(
                        ____this_767,
                        ____assign_766(____temp_765, {seq = ____L1_inputSeq_764}, __L1.input)
                    )
                end
            end
        end
        __L1:predict(dt)
        __L1:consumeEvents()
        for ____, e in __iterar((__L1.effectFrames)) do
            e.life = e.life - dt
            e.x = e.x + if __t(e.vx) then e.vx else 0 * dt
            e.y = e.y + if __t(e.vy) then e.vy else 0 * dt
            e.vy = if __t(e.vy) then e.vy else 0 + 180 * dt
        end
        __L1.effectFrames = __call(
            __L1.effectFrames,
            "filter",
            function(____, e) return __gt(e.life, 0) end
        )
        local drawAt = window.performance:now()
        __L1:draw()
        local ____t_773 = __t
        local ____opt_770 = window.Graphics
        if ____opt_770 ~= nil then
            ____opt_770 = ____opt_770.isShader
        end
        local ____opt_result_772
        if ____opt_770 ~= nil then
            ____opt_result_772 = ____opt_770(____opt_770)
        end
        if ____t_773(if __t(__L1.world) then ____opt_result_772 else __L1.world) then
            local ____opt_776 = window.Shader
            if ____opt_776 ~= nil then
                ____opt_776 = ____opt_776.apply
            end
            if ____opt_776 ~= nil then
                ____opt_776(
                    ____opt_776,
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
        local ____opt_780 = window.Game
        if ____opt_780 ~= nil then
            ____opt_780 = ____opt_780.getState
        end
        local ____opt_result_782
        if ____opt_780 ~= nil then
            ____opt_result_782 = ____opt_780(____opt_780)
        end
        local state = ____opt_result_782
        local ____t_790 = __t
        local ____t_788 = __t
        local ____t_786 = __t
        local ____opt_result_785
        if state ~= nil then
            ____opt_result_785 = state.started
        end
        local ____temp_787 = not not ____t_786(____opt_result_785) and not __t(state.paused)
        __O[2961] = ____temp_787
        local ____temp_789 = if ____t_788(____temp_787) then not __t(state.won) else __O[2961]
        __O[2962] = ____temp_789
        __L1.pausedCampaign = if ____t_790(____temp_789) then not __t(state.chapterEnded) else __O[2962]
        if __t(__L1.pausedCampaign) then
            window.Game:pause()
        end
        local ____opt_793 = window.Game
        if ____opt_793 ~= nil then
            ____opt_793 = ____opt_793.releaseInputs
        end
        if ____opt_793 ~= nil then
            ____opt_793(____opt_793)
        end
        local ____t_800 = __t
        local ____opt_797 = window.CoopArena
        if ____opt_797 ~= nil then
            ____opt_797 = ____opt_797.getStatus
        end
        local ____opt_result_799
        if ____opt_797 ~= nil then
            ____opt_result_799 = ____opt_797(____opt_797).open
        end
        __O[2963] = ____opt_result_799
        local ____ = if ____t_800(____opt_result_799) then window.CoopArena:close() else __O[2963]
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
                local ____self_803 = window.JSON
                local ____self_803_parse_804 = ____self_803.parse
                local ____t_802 = __t
                local ____temp_801 = window.sessionStorage:getItem("daroca-arena-room")
                __O[2964] = ____temp_801
                local saved = ____self_803_parse_804(____self_803, if ____t_802(____temp_801) then __O[2964] else "null")
                local ____t_811 = __t
                local ____t_810 = __t
                local ____t_808 = __t
                local ____opt_result_807
                if saved ~= nil then
                    ____opt_result_807 = saved.token
                end
                __O[2965] = ____opt_result_807
                local ____temp_809 = if ____t_808(____opt_result_807) then __re_test(
                    __re("^[A-Z0-9]{6}$", ""),
                    saved.code
                ) else __O[2965]
                __O[2966] = ____temp_809
                if ____t_811(if ____t_810(____temp_809) then saved.playerId else __O[2966]) then
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
        local ____opt_814 = __L1.controls
        if ____opt_814 ~= nil then
            ____opt_814 = ____opt_814.closeEditor
        end
        if ____opt_814 ~= nil then
            ____opt_814(____opt_814)
        end
        local ____t_818 = __t
        local ____t_817 = __t
        local ____temp_816 = if __t(__L1.credentials) then __L1:playing() else __L1.credentials
        __O[2967] = ____temp_816
        if ____t_818(if ____t_817(____temp_816) then not __t(window:confirm("Sair da arena e encerrar sua participação na sala?")) else __O[2967]) then
            return
        end
        __L1:leaveRoom(true)
        __L1.opened = false
        __L1.screen.hidden = true
        window.document.documentElement.classList:remove("arena-is-open")
        window:cancelAnimationFrame(__L1.frameHandle)
        local ____opt_821 = window.Game
        if ____opt_821 ~= nil then
            ____opt_821 = ____opt_821.releaseInputs
        end
        if ____opt_821 ~= nil then
            ____opt_821(____opt_821)
        end
        if __t(__L1.pausedCampaign) then
            local ____opt_825 = window.Game
            if ____opt_825 ~= nil then
                ____opt_825 = ____opt_825.resume
            end
            if ____opt_825 ~= nil then
                ____opt_825(____opt_825)
            end
        end
        __L1.pausedCampaign = false
        local ____t_829 = __t
        local ____opt_827 = __L1.priorFocus
        if ____opt_827 ~= nil then
            ____opt_827 = ____opt_827.isConnected
        end
        if ____t_829(____opt_827) then
            local ____this_831
            ____this_831 = __L1.priorFocus
            local ____opt_830 = ____this_831.focus
            if ____opt_830 ~= nil then
                ____opt_830(____this_831, {preventScroll = true})
            end
        end
        window:dispatchEvent(__new("CustomEvent", "arena-close"))
    end
    __L1.keyAction = function(self, code)
        local ____t_834 = __t
        local ____opt_832 = window.ControlSettings
        if ____opt_832 ~= nil then
            ____opt_832 = ____opt_832.matches
        end
        if ____t_834(____opt_832) then
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
        local ____t_837 = __t
        local ____opt_835 = window.ArenaRoster
        if ____opt_835 ~= nil then
            ____opt_835 = ____opt_835.all
        end
        __O[2811] = ____opt_835
        return if ____t_837(____opt_835) then __O[2811] else __arrL({}, 0)
    end
    __L1.kit = function(____, id)
        local ____t_839 = __t
        local ____callq_result_838 = __callq(window.ArenaRoster, "get", id)
        __O[2812] = ____callq_result_838
        return if ____t_839(____callq_result_838) then __O[2812] else __get(
            __L1:roster(),
            0
        )
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
        return __call(
            __call(
                __re_replace(
                    tostring(if __t(v) then v else ""),
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
        local ____t_842 = __t
        local ____opt_840 = __L1.credentials
        if ____opt_840 ~= nil then
            ____opt_840 = ____opt_840.playerId
        end
        __O[2813] = ____opt_840
        return if ____t_842(____opt_840) then __O[2813] else "practice-local"
    end
    __L1.isHost = function()
        local ____t_845 = __t
        local ____opt_843 = __L1.credentials
        if ____opt_843 ~= nil then
            ____opt_843 = ____opt_843.isHost
        end
        return if __t(__L1.practice) then __L1.practice else not not ____t_845(____opt_843)
    end
    __L1.playing = function()
        local ____opt_846 = __L1.world
        if ____opt_846 ~= nil then
            ____opt_846 = ____opt_846.phase
        end
        return ____opt_846 == "playing"
    end
    __L1.inMatch = function()
        local ____opt_848 = __L1.world
        if ____opt_848 ~= nil then
            ____opt_848 = ____opt_848.phase
        end
        local ____temp_852 = ____opt_848 == "playing"
        if not ____temp_852 then
            local ____opt_850 = __L1.world
            if ____opt_850 ~= nil then
                ____opt_850 = ____opt_850.phase
            end
            ____temp_852 = ____opt_850 == "countdown"
        end
        return ____temp_852
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
        local ____t_858 = __t
        local ____opt_855 = window.ControlSettings
        if ____opt_855 ~= nil then
            ____opt_855 = ____opt_855.getLabel
        end
        local ____opt_result_857
        if ____opt_855 ~= nil then
            ____opt_result_857 = ____opt_855(____opt_855, action)
        end
        __O[2818] = ____opt_result_857
        return if ____t_858(____opt_result_857) then __O[2818] else fallback
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
            local ____t_861 = __t
            local ____t_860 = __t
            local ____temp_859 = not __t(__L1.opened)
            __O[2968] = ____temp_859
            if ____t_861(if ____t_860(____temp_859) then __O[2968] else window.document:querySelector("dialog[open]")) then
                return
            end
            e:stopImmediatePropagation()
            if e.code == "Escape" then
                e:preventDefault()
                local ____t_867 = __t
                local ____opt_864 = __L1.controls
                if ____opt_864 ~= nil then
                    ____opt_864 = ____opt_864.isEditing
                end
                local ____opt_result_866
                if ____opt_864 ~= nil then
                    ____opt_result_866 = ____opt_864(____opt_864)
                end
                if ____t_867(____opt_result_866) then
                    __L1.controls:closeEditor()
                else
                    __L1:close()
                end
                return
            end
            local ____t_873 = __t
            local ____opt_870 = __L1.controls
            if ____opt_870 ~= nil then
                ____opt_870 = ____opt_870.isEditing
            end
            local ____opt_result_872
            if ____opt_870 ~= nil then
                ____opt_result_872 = ____opt_870(____opt_870)
            end
            if ____t_873(____opt_result_872) then
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
            local ____this_875
            ____this_875 = event.target
            local ____opt_874 = ____this_875.closest
            if ____opt_874 ~= nil then
                ____opt_874 = ____opt_874(____this_875, "[data-open-arena]")
            end
            local button = ____opt_874
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
            local ____t_878 = __t
            local ____t_877 = __t
            local ____temp_876 = if __t(__L1.opened) then window.document.hidden else __L1.opened
            __O[2969] = ____temp_876
            if ____t_878(if ____t_877(____temp_876) then __L1.credentials else __O[2969]) then
                __L1:notify(if __t(__L1:isHost()) then "Mantenha o jogo aberto para a sala continuar em tempo real." else "Você voltou? A arena reconecta automaticamente.")
            end
        end
    )
    window.Arena = __ord(
        {
            open = __L1.open,
            close = __L1.close,
            editControls = function()
                __L1:open()
                local ____opt_881 = __L1.controls
                if ____opt_881 ~= nil then
                    ____opt_881 = ____opt_881.openEditor
                end
                if ____opt_881 ~= nil then
                    ____opt_881(____opt_881)
                end
            end,
            getControlsStatus = function()
                local ____t_888 = __t
                local ____opt_885 = __L1.controls
                if ____opt_885 ~= nil then
                    ____opt_885 = ____opt_885.getStatus
                end
                local ____opt_result_887
                if ____opt_885 ~= nil then
                    ____opt_result_887 = ____opt_885(____opt_885)
                end
                __O[2970] = ____opt_result_887
                return if ____t_888(____opt_result_887) then __O[2970] else nil
            end,
            isOpen = function() return __L1.opened end,
            startPractice = function()
                __L1:open()
                __L1:startPractice()
            end,
            getStatus = function()
                local ____L1_opened_933 = __L1.opened
                local ____L1_VERSION_934 = __L1.VERSION
                local ____opt_889 = __L1.world
                if ____opt_889 ~= nil then
                    ____opt_889 = ____opt_889.phase
                end
                local ____opt_891 = __L1.world
                if ____opt_891 ~= nil then
                    ____opt_891 = ____opt_891.phase
                end
                local ____opt_893 = __L1.world
                if ____opt_893 ~= nil then
                    ____opt_893 = ____opt_893.phase
                end
                local ____temp_935 = if ____opt_889 == "finished" then "results" else if ____opt_891 == "playing" then "playing" else if ____opt_893 == "countdown" then "countdown" else if __t(__L1.room) then "lobby" else "menu"
                local ____temp_936 = not not __t(__L1.credentials)
                local ____L1_practice_937 = __L1.practice
                local ____temp_938 = __L1:isHost()
                local ____t_897 = __t
                local ____opt_895 = __L1.room
                if ____opt_895 ~= nil then
                    ____opt_895 = ____opt_895.code
                end
                __O[2971] = ____opt_895
                local ____temp_939 = if ____t_897(____opt_895) then __O[2971] else nil
                local ____temp_940 = __L1:localId()
                local ____t_904 = __t
                local ____t_900 = __t
                local ____opt_898 = __L1.world
                if ____opt_898 ~= nil then
                    ____opt_898 = ____opt_898.phase
                end
                __O[2972] = ____opt_898
                local ____opt_901 = __L1.room
                if ____opt_901 ~= nil then
                    ____opt_901 = ____opt_901.status
                end
                local ____temp_903 = if ____t_900(____opt_898) then __O[2972] else ____opt_901
                __O[2973] = ____temp_903
                local ____temp_941 = if ____t_904(____temp_903) then __O[2973] else "selection"
                local ____t_907 = __t
                local ____opt_905 = __L1.world
                if ____opt_905 ~= nil then
                    ____opt_905 = ____opt_905.matchId
                end
                __O[2974] = ____opt_905
                local ____temp_942 = if ____t_907(____opt_905) then __O[2974] else nil
                local ____opt_908 = __L1.world
                if ____opt_908 ~= nil then
                    ____opt_908 = ____opt_908.phase
                end
                local ____temp_943 = if ____opt_908 == "countdown" then math.max(
                    0,
                    (__L1.world.startAt - window.Date:now() - __L1.serverOffset) / 1000
                ) else 0
                local ____math_floor_result_944 = math.floor(__L1.rttMs + 0.5)
                local ____len_result_945 = __len(__L1.effectFrames)
                local ____assign_result_946 = __assign(
                    {},
                    __L1:cameraViewport(),
                    {
                        width = __L1.W,
                        height = __L1.H,
                        usableHeight = __L1:cameraViewport().height
                    }
                )
                local ____L1_visualClock_947 = __L1.visualClock
                local ____temp_948 = if __t(__L1.prediction) then {x = __L1.prediction.x, y = __L1.prediction.y, motion = __L1.prediction.motion, wallSide = __L1.prediction.wallSide} else nil
                local ____len_result_949 = __len(__L1:roster())
                local ____L1_notice_950 = __L1.notice
                local ____t_918 = __t
                local ____t_914 = __t
                local ____callq_912 = __callq
                local ____opt_910 = __L1.world
                if ____opt_910 ~= nil then
                    ____opt_910 = ____opt_910.players
                end
                local ____callq_912_result_913 = ____callq_912(
                    ____opt_910,
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
                __O[2975] = ____callq_912_result_913
                local ____opt_915 = __L1.room
                if ____opt_915 ~= nil then
                    ____opt_915 = ____opt_915.players
                end
                local ____temp_917 = if ____t_914(____callq_912_result_913) then __O[2975] else ____opt_915
                __O[2976] = ____temp_917
                local ____temp_951 = if ____t_918(____temp_917) then __O[2976] else __arrL({}, 0)
                local ____t_923 = __t
                local ____lenq_921 = __lenq
                local ____opt_919 = __L1.world
                if ____opt_919 ~= nil then
                    ____opt_919 = ____opt_919.shots
                end
                local ____lenq_921_result_922 = ____lenq_921(____opt_919)
                __O[2977] = ____lenq_921_result_922
                local ____temp_952 = if ____t_923(____lenq_921_result_922) then __O[2977] else 0
                local ____call_result_953 = __call(
                    __L1.STAGE,
                    "map",
                    function(____, p) return __assign({}, p) end
                )
                local ____assign_result_954 = __assign({}, __L1.KO)
                local ____assign_result_955 = __assign({}, __L1.camera)
                local ____t_926 = __t
                local ____opt_924 = __L1.world
                if ____opt_924 ~= nil then
                    ____opt_924 = ____opt_924.remaining
                end
                __O[2978] = ____opt_924
                local ____temp_956 = if ____t_926(____opt_924) then __O[2978] else 0
                local ____t_932 = __t
                local ____opt_929 = __L1.net
                if ____opt_929 ~= nil then
                    ____opt_929 = ____opt_929.getStatus
                end
                local ____opt_result_931
                if ____opt_929 ~= nil then
                    ____opt_result_931 = ____opt_929(____opt_929)
                end
                __O[2979] = ____opt_result_931
                return {
                    open = ____L1_opened_933,
                    version = ____L1_VERSION_934,
                    stage = ____temp_935,
                    connected = ____temp_936,
                    practice = ____L1_practice_937,
                    isHost = ____temp_938,
                    code = ____temp_939,
                    playerId = ____temp_940,
                    phase = ____temp_941,
                    matchId = ____temp_942,
                    countdown = ____temp_943,
                    pingMs = ____math_floor_result_944,
                    effectCount = ____len_result_945,
                    viewport = ____assign_result_946,
                    visualTime = ____L1_visualClock_947,
                    predicted = ____temp_948,
                    rosterCount = ____len_result_949,
                    notice = ____L1_notice_950,
                    players = ____temp_951,
                    shots = ____temp_952,
                    platforms = ____call_result_953,
                    bounds = ____assign_result_954,
                    camera = ____assign_result_955,
                    remaining = ____temp_956,
                    transport = if ____t_932(____opt_result_931) then __O[2979] else nil,
                    lastSync = math.floor(window.performance:now() - __L1.lastSync + 0.5)
                }
            end
        },
        "open,close,editControls,getControlsStatus,isOpen,startPractice,getStatus"
    )
end)(nil)
return ____exports
