--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __D = {}
local __lt, __le, __gt, __ge, __isSafeInteger, __isFiniteN, __isInteger, __getq, __lenq, __callq, __mod, __ord = __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__isSafeInteger, __JSR.__isFiniteN, __JSR.__isInteger, __JSR.__getq, __JSR.__lenq, __JSR.__callq, __JSR.__mod, __JSR.__ord
local __arrL, __iterar, __t, __get, __set, __inc, __arr, __len, __call, __add, __new, __iter = __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__inc, __JSR.__arr, __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__new, __JSR.__iter
local __keys, __assign, __isArray, __hypot, __re, __re_test, __re_replace = __JSR.__keys, __JSR.__assign, __JSR.__isArray, __JSR.__hypot, __JSR.__re, __JSR.__re_test, __JSR.__re_replace
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
local __TS__Number = ____lualib.__TS__Number
local __TS__Spread = ____lualib.__TS__Spread
local __TS__MathSign = ____lualib.__TS__MathSign
local Map = ____lualib.Map
local Set = ____lualib.Set
local ____exports = {}
local __O = {};
(function()
    local __L1 = {}
    __L1.ensureUI = function(self)
        if __t(__L1.overlay) then
            return
        end
        __L1.overlay = window.document:createElement("section")
        __L1.overlay.id = "coopOverlay"
        __L1.overlay.className = "coop-overlay"
        __L1.overlay.hidden = true
        __L1.overlay.dataset.transport = "cloud"
        __L1.overlay:setAttribute("role", "dialog")
        __L1.overlay:setAttribute("aria-modal", "true")
        __L1.overlay:setAttribute("aria-labelledby", "coopHeading")
        __L1.overlay.innerHTML = ("<header class=\"coop-header\"><div><span class=\"coop-eyebrow\">DOIS CHAPÉUS, UMA RESENHA</span><h2 id=\"coopHeading\">Dupla online · chefões em equipe</h2></div><button type=\"button\" id=\"coopCloseBtn\" aria-label=\"Sair da dupla\">×</button></header><div id=\"coopLobby\" class=\"coop-lobby\"><div class=\"coop-adventure-sign\"><span>2 PARCEIROS</span><strong>UM BOLO.<br>TRÊS CHEFÕES.</strong><p>Marco, Menezes e Nikolas contra a dupla da roça.</p></div><p class=\"coop-lead\">Crie a sala no próprio celular e passe o código ao amigo. Cada um joga no seu aparelho pela internet.</p><label class=\"coop-name-label\" for=\"coopName\">SEU NOME NA RESENHA<input id=\"coopName\" maxlength=\"20\" autocomplete=\"nickname\" placeholder=\"Da Resenha\"></label><div class=\"coop-role-picker\"><button type=\"button\" id=\"coopHostBtn\">＋ CRIAR DUPLA ONLINE</button><button type=\"button\" id=\"coopJoinBtn\">ENTRAR COM CÓDIGO →</button></div><div id=\"coopPairing\" hidden><div class=\"coop-code-in\"><label for=\"coopCodeIn\">CÓDIGO DA SALA DO AMIGO</label><input id=\"coopCodeIn\" maxlength=\"6\" autocomplete=\"off\" autocapitalize=\"characters\" spellcheck=\"false\" placeholder=\"ROCA67\"><button type=\"button\" id=\"coopApplyBtn\">ENTRAR NA DUPLA</button></div></div><section id=\"coopRoom\" class=\"coop-room\" hidden><div class=\"coop-room-heading\"><div><label for=\"coopCodeOut\">PASSE ESTE CÓDIGO AO AMIGO</label><input id=\"coopCodeOut\" readonly aria-label=\"Código da dupla\"><button type=\"button\" id=\"coopCopyBtn\">COPIAR CÓDIGO</button></div><button type=\"button\" id=\"coopLeaveBtn\">SAIR DA SALA</button></div><div id=\"coopSeats\" class=\"coop-seats\"></div><div class=\"coop-room-actions\"><button type=\"button\" id=\"coopReadyBtn\">ESTOU PRONTO</button><button type=\"button\" id=\"coopStartBtn\">COMEÇAR A RESENHA</button></div><p class=\"coop-note\">Quem criou a sala mantém o jogo aberto. Os dois precisam estar prontos. Nenhum computador precisa ficar ligado.</p></section><p id=\"coopStatus\" class=\"coop-status\" role=\"status\" aria-live=\"polite\"></p><p class=\"coop-note\">Papel, peidão, voo e dash: ajudem o parceiro caído chegando perto dele. Este modo não altera os saves da campanha.</p><p id=\"coopPackageNote\" class=\"coop-note\" hidden>Este pacote antigo funciona só na rede local. Para a nova Dupla online, abra o jogo atualizado em <a href=\"" .. tostring(__L1.OFFICIAL)) .. "\" target=\"_blank\" rel=\"noopener\">Da Roça Adventure</a>.</p></div><div id=\"coopArena\" class=\"coop-arena\" hidden><canvas id=\"coopCanvas\" width=\"960\" height=\"540\" aria-label=\"Arena em dupla. Use seus controles configurados: andar, pular e voar, papel, peidão e dash.\" tabindex=\"0\"></canvas><div class=\"coop-game-hud\"><span id=\"coopRoleLabel\"></span><span id=\"coopWaveLabel\"></span><button type=\"button\" id=\"coopRestartBtn\" hidden>JOGAR NOVAMENTE</button></div><div class=\"coop-touch\" aria-label=\"Controles da dupla\"><div id=\"coopJoystick\" class=\"coop-joystick\" role=\"slider\" tabindex=\"0\" aria-label=\"Joystick de movimento\" aria-valuemin=\"-100\" aria-valuemax=\"100\" aria-valuenow=\"0\"><span class=\"coop-stick\"></span></div><div class=\"coop-action-buttons\"><button type=\"button\" data-coop-action=\"paper\" aria-label=\"Jogar papel\"><svg viewBox=\"0 0 24 24\" aria-hidden=\"true\" shape-rendering=\"crispEdges\"><path fill=\"currentColor\" d=\"M8 2h9v3h4v5h2v7h-5v4H7v-3H2V9h3V5h3z\"/><path fill=\"#fff4d1\" d=\"M9 5h6v3h4v7h-4v3H9v-3H5v-5h4z\"/></svg><small>PAPEL</small></button><button type=\"button\" data-coop-action=\"fart\" aria-label=\"Peido de ataque\"><svg viewBox=\"0 0 24 24\" aria-hidden=\"true\" shape-rendering=\"crispEdges\"><path fill=\"currentColor\" d=\"M2 12h4V9h3V5h6v3h4v3h4v6h-4v4H9v-3H5v-2H2z\"/></svg><small>PEIDÃO</small></button><button type=\"button\" data-coop-action=\"jump\" aria-label=\"Pular; segure para voar\"><svg viewBox=\"0 0 24 24\" aria-hidden=\"true\" shape-rendering=\"crispEdges\"><path fill=\"currentColor\" d=\"M11 1h2v2h2v2h2v2h-4v14h-2V7H7V5h2V3h2z\"/></svg><small>PULAR / VOAR</small></button><button type=\"button\" data-coop-action=\"dash\" aria-label=\"Dash\"><svg viewBox=\"0 0 24 24\" aria-hidden=\"true\" shape-rendering=\"crispEdges\"><path fill=\"currentColor\" d=\"M1 4h9v2H1zm2 6h6v2H3zm-2 6h8v2H1zM12 2h6v8h3v4h3v8H10v-5H7v-4h5z\"/></svg><small>DASH</small></button></div></div><p id=\"coopGameNotice\" class=\"coop-game-notice\" aria-live=\"polite\"></p></div>"
        __L1.shell:append(__L1.overlay)
        local ____L1__24_result_3 = __L1["$"](__L1, "coopName")
        local ____L1_clean_2 = __L1.clean
        local ____t_1 = __t
        local ____temp_0 = window.localStorage:getItem("daroca-coop-name")
        __O[3074] = ____temp_0
        ____L1__24_result_3.value = ____L1_clean_2(__L1, if ____t_1(____temp_0) then __O[3074] else window.localStorage:getItem("daroca-arena-name"))
        __L1["$"](__L1, "coopCloseBtn").onclick = __L1.close
        __L1["$"](__L1, "coopHostBtn").onclick = __L1.createHost
        __L1["$"](__L1, "coopJoinBtn").onclick = __L1.prepareGuest
        __L1["$"](__L1, "coopApplyBtn").onclick = __L1.applyCode
        __L1["$"](__L1, "coopCopyBtn").onclick = __L1.copyCode
        __L1["$"](__L1, "coopLeaveBtn").onclick = function() return __L1:leaveRoom() end
        __L1["$"](__L1, "coopReadyBtn").onclick = function()
            __L1.ready = not __t(__L1.ready)
            __L1.readyRevision = __L1.readyRevision + 1
            __L1:updateLobby()
            __L1:syncNow()
        end
        __L1["$"](__L1, "coopStartBtn").onclick = __L1.startMatch
        __L1["$"](__L1, "coopRestartBtn").onclick = function()
            local ____t_6 = __t
            local ____t_5 = __t
            local ____temp_4 = __L1.role == "host"
            __O[3075] = ____temp_4
            if ____t_6(if ____t_5(____temp_4) then __L1:isConnected() else __O[3075]) then
                __L1:startMatch()
            end
        end
        __L1["$"](__L1, "coopCodeIn"):addEventListener(
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
        __L1["$"](__L1, "coopCodeIn"):addEventListener(
            "keydown",
            function(____, e)
                if e.key == "Enter" then
                    __L1:applyCode()
                end
            end
        )
        __L1["$"](__L1, "coopPackageNote").hidden = window.DAROCA_LAN ~= true
        local stick = __L1["$"](__L1, "coopJoystick")
        stick:addEventListener(
            "pointerdown",
            function(____, e)
                if __t(__L1.joystickPointer ~= nil or not __t(__L1:arenaVisible())) then
                    return
                end
                e:preventDefault()
                __L1.joystickPointer = e.pointerId
                local r = stick:getBoundingClientRect()
                __L1.joyCenter = {x = r.left + r.width / 2, y = r.top + r.height / 2, r = r.width * 0.32}
                do
                    pcall(function()
                        stick:setPointerCapture(e.pointerId)
                    end)
                end
                __L1:moveStick(e)
            end
        )
        stick:addEventListener(
            "pointermove",
            function(____, e)
                if e.pointerId == __L1.joystickPointer then
                    e:preventDefault()
                    __L1:moveStick(e)
                end
            end
        )
        for ____, kind in __iterar((__arrL({"pointerup", "pointercancel", "lostpointercapture"}, 3))) do
            stick:addEventListener(
                kind,
                function(____, e)
                    if e.pointerId == __L1.joystickPointer then
                        __L1:resetStick()
                        __L1:changedInput()
                    end
                end
            )
        end
        __call(
            __L1.overlay:querySelectorAll("[data-coop-action]"),
            "forEach",
            function(____, el)
                el:addEventListener(
                    "pointerdown",
                    function(____, e)
                        local ____t_9 = __t
                        local ____t_8 = __t
                        local ____temp_7 = e.pointerType == "mouse" and e.button ~= 0
                        __O[3076] = ____temp_7
                        if ____t_9(if ____t_8(____temp_7) then __O[3076] else not __t(__L1:arenaVisible())) then
                            return
                        end
                        e:preventDefault()
                        local a = el.dataset.coopAction
                        __call(__L1.activePointers, "set", e.pointerId, {el = el, action = a})
                        do
                            pcall(function()
                                el:setPointerCapture(e.pointerId)
                            end)
                        end
                        __call(el.classList, "add", "pressed")
                        if a == "jump" then
                            if not __t(__L1.input.jump) then
                                local ____L1_input_10, ____jumpPress_11 = __L1.input, "jumpPress"
                                ____L1_input_10[____jumpPress_11] = ____L1_input_10[____jumpPress_11] + 1
                            end
                            __L1.input.jump = true
                            __L1:changedInput()
                        else
                            __L1:pulse(a)
                        end
                    end
                )
                for ____, kind in __iterar((__arrL({"pointerup", "pointercancel", "lostpointercapture"}, 3))) do
                    el:addEventListener(
                        kind,
                        function(____, e) return __L1:releasePointer(e.pointerId) end
                    )
                end
                el:addEventListener(
                    "click",
                    function(____, e)
                        local ____t_14 = __t
                        local ____t_13 = __t
                        local ____temp_12 = e.detail == 0 and not __t(e.pointerType)
                        __O[3077] = ____temp_12
                        if ____t_14(if ____t_13(____temp_12) then el.dataset.coopAction ~= "jump" else __O[3077]) then
                            __L1:pulse(el.dataset.coopAction)
                        end
                    end
                )
            end
        )
        local function stopGesture(____, e)
            if __t(e.cancelable) then
                e:preventDefault()
            end
        end
        for ____, kind in __iterar((__arrL({
            "gesturestart",
            "gesturechange",
            "gestureend",
            "dblclick",
            "contextmenu"
        }, 5))) do
            __L1.overlay:addEventListener(kind, stopGesture, {passive = false})
        end
        __L1.overlay:addEventListener(
            "touchmove",
            function(____, e)
                local ____t_17 = __t
                local ____t_16 = __t
                local ____temp_15 = __L1:arenaVisible()
                __O[3078] = ____temp_15
                if ____t_17(if ____t_16(____temp_15) then __O[3078] else __len(e.touches) > 1) then
                    stopGesture(nil, e)
                end
            end,
            {passive = false}
        )
    end
    __L1.arenaVisible = function(self)
        local ____t_19 = __t
        local ____temp_18 = if __t(__L1.opened) then not not __t(__L1.overlay) else __L1.opened
        __O[3079] = ____temp_18
        return if ____t_19(____temp_18) then not __t(__L1["$"](__L1, "coopArena").hidden) else __O[3079]
    end
    __L1.setStatus = function(self, message, ____error)
        if ____error == nil then
            ____error = false
        end
        if not __t(__L1["$"](__L1, "coopStatus")) then
            return
        end
        __L1["$"](__L1, "coopStatus").textContent = message
        __L1["$"](__L1, "coopStatus").classList:toggle("coop-error", ____error)
    end
    __L1.setArena = function(self, on)
        if not __t(__L1["$"](__L1, "coopArena")) then
            return
        end
        local changed = __L1["$"](__L1, "coopArena").hidden == on
        __L1["$"](__L1, "coopArena").hidden = not __t(on)
        __L1["$"](__L1, "coopLobby").hidden = on
        __L1.overlay.classList:toggle("is-playing", on)
        if __t(changed) then
            __L1:resetInputs()
            __L1.accumulator = 0
            if __t(on) then
                __L1["$"](__L1, "coopCanvas"):focus()
            end
        end
    end
    __L1.isConnected = function(self)
        local ____t_23 = __t
        local ____t_21 = __t
        local ____temp_20 = not not __t(__L1.credentials) and not not __t(__L1.room)
        __O[3080] = ____temp_20
        local ____temp_22 = if ____t_21(____temp_20) then __len(__L1.room.players) == 2 else __O[3080]
        __O[3081] = ____temp_22
        return if ____t_23(____temp_22) then __L1.room.hostConnected ~= false else __O[3081]
    end
    __L1.updateLobby = function(self)
        if not __t(__L1.overlay) then
            return
        end
        local connected = not not __t(__L1.credentials)
        for ____, id in __iterar((__arrL({
            "coopName",
            "coopHostBtn",
            "coopJoinBtn",
            "coopApplyBtn",
            "coopCodeIn"
        }, 5))) do
            __L1["$"](__L1, id).disabled = if __t(__L1.busy) then __L1.busy else connected
        end
        __L1["$"](__L1, "coopRoom").hidden = not __t(connected)
        if not __t(connected) then
            return
        end
        __L1["$"](__L1, "coopPairing").hidden = true
        __L1["$"](__L1, "coopCodeOut").value = __L1.room.code
        __L1["$"](__L1, "coopSeats"):replaceChildren()
        local players = __arrL(
            {
                __call(
                    __L1.room.players,
                    "find",
                    function(____, p) return p.id == __L1.room.hostPlayerId end
                ),
                __call(
                    __L1.room.players,
                    "find",
                    function(____, p) return p.id ~= __L1.room.hostPlayerId end
                )
            },
            2
        )
        __call(
            players,
            "forEach",
            function(____, p, index)
                local seat = window.document:createElement("div")
                local ____add_27 = __add
                local ____opt_result_26
                if p ~= nil then
                    ____opt_result_26 = p.id
                end
                seat.className = ____add_27("coop-seat", if ____opt_result_26 == __L1.credentials.playerId then " is-you" else "")
                local label = window.document:createElement("strong")
                local sub = window.document:createElement("small")
                label.textContent = if __t(p) then __add(p.name, if p.id == __L1.credentials.playerId then " · VOCÊ" else "") else "ESPERANDO O PARCEIRO"
                sub.textContent = if __t(p) then if __t(if p.id == __L1.credentials.playerId then __L1.ready else p.ready) then "✓ PRONTO PRA RESENHA" else if index == 0 then "CRIADOR DA DUPLA" else "PREPARANDO O PAPEL" else "PASSE O CÓDIGO ACIMA"
                seat:append(label, sub)
                __L1["$"](__L1, "coopSeats"):append(seat)
            end
        )
        __L1["$"](__L1, "coopReadyBtn").textContent = if __t(__L1.ready) then "✓ ESTOU PRONTO" else "ESTOU PRONTO"
        __L1["$"](__L1, "coopReadyBtn").classList:toggle("is-ready", __L1.ready)
        __L1["$"](__L1, "coopStartBtn").hidden = __L1.role ~= "host"
        local ____L1__24_result_30 = __L1["$"](__L1, "coopStartBtn")
        local ____t_29 = __t
        local ____temp_28 = if __t(__L1.busy) then __L1.busy else __len(__L1.room.players) ~= 2
        __O[3082] = ____temp_28
        ____L1__24_result_30.disabled = if ____t_29(____temp_28) then __O[3082] else not __t(__call(
            __L1.room.players,
            "every",
            function(____, p) return if p.id == __L1.credentials.playerId then __L1.ready else p.ready end
        ))
    end
    __L1.open = function(self)
        __L1:ensureUI()
        if __t(__L1.opened) then
            return
        end
        local ____opt_33 = window.Arena
        if ____opt_33 ~= nil then
            ____opt_33 = ____opt_33.close
        end
        if ____opt_33 ~= nil then
            ____opt_33(____opt_33)
        end
        local ____opt_37 = window.Party
        if ____opt_37 ~= nil then
            ____opt_37 = ____opt_37.close
        end
        if ____opt_37 ~= nil then
            ____opt_37(____opt_37)
        end
        local ____opt_41 = window.Game
        if ____opt_41 ~= nil then
            ____opt_41 = ____opt_41.getState
        end
        local ____opt_result_43
        if ____opt_41 ~= nil then
            ____opt_result_43 = ____opt_41(____opt_41)
        end
        local state = ____opt_result_43
        local ____t_52 = __t
        local ____t_51 = __t
        local ____t_49 = __t
        local ____t_47 = __t
        local ____opt_result_46
        if state ~= nil then
            ____opt_result_46 = state.started
        end
        __O[3083] = ____opt_result_46
        local ____temp_48 = if ____t_47(____opt_result_46) then not __t(state.paused) else __O[3083]
        __O[3084] = ____temp_48
        local ____temp_50 = if ____t_49(____temp_48) then not __t(state.won) else __O[3084]
        __O[3085] = ____temp_50
        __L1.resumeCampaign = not not ____t_52(if ____t_51(____temp_50) then not __t(state.defeated) else __O[3085])
        local ____opt_55 = window.Game
        if ____opt_55 ~= nil then
            ____opt_55 = ____opt_55.releaseInputs
        end
        if ____opt_55 ~= nil then
            ____opt_55(____opt_55)
        end
        if __t(__L1.resumeCampaign) then
            window.Game:pause()
        end
        __L1.opened = true
        __L1.overlay.hidden = false
        __L1:setArena(false)
        __L1["$"](__L1, "coopPairing").hidden = true
        __L1:setStatus("Um cria a sala, passa o código e os dois ficam prontos. Bora buscar esse bolo!")
        __L1:updateLobby()
        __L1["$"](__L1, "coopCloseBtn"):focus()
        local saved
        do
            pcall(function()
                local ____self_59 = window.JSON
                local ____self_59_parse_60 = ____self_59.parse
                local ____t_58 = __t
                local ____temp_57 = window.sessionStorage:getItem(__L1.SESSION)
                __O[3086] = ____temp_57
                saved = ____self_59_parse_60(____self_59, if ____t_58(____temp_57) then __O[3086] else "null")
            end)
        end
        local ____t_65 = __t
        local ____t_64 = __t
        local ____t_62 = __t
        local ____temp_61 = if __t(saved) then __re_test(
            __re("^[A-Z0-9]{6}$", ""),
            if __t(saved.code) then saved.code else ""
        ) else saved
        __O[3087] = ____temp_61
        local ____temp_63 = if ____t_62(____temp_61) then type(saved.token) == "string" else __O[3087]
        __O[3088] = ____temp_63
        if ____t_65(if ____t_64(____temp_63) then type(saved.playerId) == "string" else __O[3088]) then
            __L1.credentials = {
                token = saved.token,
                playerId = saved.playerId,
                isHost = not not __t(saved.isHost)
            }
            local ____temp_66 = if __t(saved.isHost) then "host" else "guest"
            __L1.currentRole = ____temp_66
            __L1.role = ____temp_66
            __L1.room = {
                code = saved.code,
                players = __arrL({}, 0),
                hostPlayerId = saved.hostPlayerId,
                status = "lobby"
            }
            __L1.restoring = true
            __L1:setStatus("Voltando para sua dupla…")
            __L1:syncNow()
        end
    end
    __L1.close = function(self)
        if not __t(__L1.opened) then
            return
        end
        __L1:leaveRoom("", true)
        __L1.opened = false
        __L1.overlay.hidden = true
        local ____opt_69 = window.Game
        if ____opt_69 ~= nil then
            ____opt_69 = ____opt_69.releaseInputs
        end
        if ____opt_69 ~= nil then
            ____opt_69(____opt_69)
        end
        local ____t_76 = __t
        local ____opt_73 = window.Game
        if ____opt_73 ~= nil then
            ____opt_73 = ____opt_73.getState
        end
        local ____opt_result_75
        if ____opt_73 ~= nil then
            ____opt_result_75 = ____opt_73(____opt_73).started
        end
        if ____t_76(if __t(__L1.resumeCampaign) then ____opt_result_75 else __L1.resumeCampaign) then
            window.Game:resume()
        end
        __L1.resumeCampaign = false
        __L1.button:focus()
    end
    __L1.clearConnection = function(self, message)
        if message == nil then
            message = ""
        end
        __L1.generation = __L1.generation + 1
        window:clearTimeout(__L1.pollTimer)
        local ____opt_79 = __L1.net
        if ____opt_79 ~= nil then
            ____opt_79 = ____opt_79.close
        end
        if ____opt_79 ~= nil then
            ____opt_79(____opt_79)
        end
        __L1.net = nil
        __L1.room = nil
        __L1.credentials = nil
        __L1.currentRole = nil
        __L1.role = nil
        __L1.targetWorld = nil
        __L1.world = nil
        __L1.predictionTarget = nil
        __L1.predicted = nil
        __L1.receivedMatch = nil
        __L1.smoothedPlayers = __arrL({}, 0)
        __L1.remoteInput = __L1:blankInput()
        __L1.remoteSequence = -1
        __L1.input = __L1:blankInput()
        __L1.stateSeq = 0
        __L1.inputSeq = 0
        __L1.ready = false
        __L1.restoring = false
        __L1.busy = false
        __L1.readyRevision = 0
        __L1.syncedReady = -1
        __L1.failures = 0
        __L1:resetInputs()
        do
            pcall(function()
                window.sessionStorage:removeItem(__L1.SESSION)
            end)
        end
        if __t(__L1.overlay) then
            __L1:setArena(false)
            __L1:updateLobby()
            __L1["$"](__L1, "coopRestartBtn").hidden = true
            if __t(message) then
                __L1:setStatus(message, true)
            end
        end
    end
    __L1.leaveRoom = function(self, message, closing)
        if message == nil then
            message = "Você saiu da dupla. Crie outra sala quando quiser."
        end
        if closing == nil then
            closing = false
        end
        return __TS__AsyncAwaiter(function(____awaiter_resolve)
            local old = if __t(if __t(__L1.credentials) then __L1.room else __L1.credentials) then {token = __L1.credentials.token, code = __L1.room.code} else nil
            __L1:resetInputs()
            if __t(old) then
                local ____try = __TS__AsyncAwaiter(function()
                    local options = {
                        method = "POST",
                        headers = {
                            ["Content-Type"] = "application/json",
                            Authorization = __add("Bearer ", old.token)
                        },
                        body = "{}"
                    }
                    local ____t_85 = __t
                    local ____t_82 = __t
                    local ____temp_81 = window.location.protocol == "file:"
                    __O[3089] = ____temp_81
                    local ____opt_83 = window.DaRocaNetwork
                    if ____opt_83 ~= nil then
                        ____opt_83 = ____opt_83.request
                    end
                    if ____t_85(if ____t_82(____temp_81) then ____opt_83 else __O[3089]) then
                        window.DaRocaNetwork:request(
                            __add(
                                __add("/api/arena/rooms/", old.code),
                                "/leave"
                            ),
                            options
                        ):catch(function()
                        end)
                    else
                        window:fetch(
                            __add(
                                __add(
                                    __add(if window.location.protocol == "file:" then __L1.OFFICIAL else "", "/api/arena/rooms/"),
                                    old.code
                                ),
                                "/leave"
                            ),
                            __assign({}, options, {keepalive = true, cache = "no-store", credentials = "omit"})
                        ):catch(function()
                        end)
                    end
                end)
                ____try = ____try.catch(
                    ____try,
                    function(____)
                        return __TS__AsyncAwaiter(function()
                        end)
                    end
                )
                __TS__Await(____try)
            end
            __L1:clearConnection(if __t(closing) then "" else message)
        end)
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
            __O[3090] = ____temp_89
            local ____opt_91 = window.DaRocaNetwork
            if ____opt_91 ~= nil then
                ____opt_91 = ____opt_91.request
            end
            if ____t_93(if ____t_90(____temp_89) then ____opt_91 else __O[3090]) then
                response = __TS__Await(window.DaRocaNetwork:request(path, {method = if __t(options.method) then options.method else "POST", headers = headers, body = if options.body == nil then nil else window.JSON:stringify(options.body)}))
            else
                local controller = __new("AbortController")
                local timer = window:setTimeout(
                    function() return controller:abort() end,
                    10000
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
            __O[3091] = ____temp_112
            local ____opt_result_116
            if data ~= nil then
                ____opt_result_116 = data.error
            end
            if ____t_117(if ____t_113(____temp_112) then __O[3091] else ____opt_result_116) then
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
                __O[3092] = ____opt_result_123
                local ____opt_result_127
                if data ~= nil then
                    ____opt_result_127 = data.message
                end
                local ____temp_128 = if ____t_124(____opt_result_123) then __O[3092] else ____opt_result_127
                __O[3093] = ____temp_128
                local ____opt_result_132
                if data ~= nil then
                    ____opt_result_132 = data.error
                end
                local ____error = __TS__New(____Error_133, if ____t_129(____temp_128) then __O[3093] else if type(____opt_result_132) == "string" then data.error else "A sala não respondeu. Confira a internet.")
                ____error.status = status
                error(____error, 0)
            end
            return ____awaiter_resolve(nil, data)
        end)
    end
    __L1.connect = function(self, kind)
        return __TS__AsyncAwaiter(function(____awaiter_resolve)
            if __t(if __t(__L1.busy) then __L1.busy else __L1.credentials) then
                return ____awaiter_resolve(nil)
            end
            local code = __L1["$"](__L1, "coopCodeIn").value
            local ____t_135 = __t
            local ____temp_134 = __L1:clean(__L1["$"](__L1, "coopName").value)
            __O[3094] = ____temp_134
            local name = if ____t_135(____temp_134) then __O[3094] else "Da Resenha"
            if __t(kind == "join" and not __re_test(
                __re("^[A-Z0-9]{6}$", ""),
                code
            )) then
                __L1:setStatus("Digite as seis letras e números da sala do amigo.", true)
                __L1["$"](__L1, "coopCodeIn"):focus()
                return ____awaiter_resolve(nil)
            end
            __L1.busy = true
            __L1:updateLobby()
            __L1:setStatus(if kind == "create" then "Criando a dupla na nuvem…" else "Entrando na dupla…")
            local ____L1_136, ____generation_137 = __L1, "generation"
            local ____L1_generation_138 = ____L1_136[____generation_137] + 1
            ____L1_136[____generation_137] = ____L1_generation_138
            local gen = ____L1_generation_138
            local ____hasReturned, ____returnValue
            local ____try = __TS__AsyncAwaiter(function()
                window.localStorage:setItem("daroca-coop-name", name)
                local data = __TS__Await(__L1:request(if kind == "create" then "/api/arena/rooms" else __add(
                    __add("/api/arena/rooms/", code),
                    "/join"
                ), {body = {
                    name = name,
                    character = "daroca",
                    mode = "coop",
                    protocol = __L1.PROTOCOL,
                    capacity = 2
                }}))
                if gen ~= __L1.generation then
                    ____hasReturned = true
                    return
                end
                local ____t_144 = __t
                local ____opt_139 = data.room
                if ____opt_139 ~= nil then
                    ____opt_139 = ____opt_139.mode
                end
                local ____temp_143 = ____opt_139 ~= "coop"
                if not ____temp_143 then
                    local ____opt_141 = data.room
                    if ____opt_141 ~= nil then
                        ____opt_141 = ____opt_141.protocol
                    end
                    ____temp_143 = ____opt_141 ~= __L1.PROTOCOL
                end
                if ____t_144(____temp_143) then
                    error(
                        Error(nil, "Atualize o jogo para entrar na nova Dupla online."),
                        0
                    )
                end
                __L1.credentials = {
                    token = data.token,
                    playerId = data.playerId,
                    isHost = not not __t(data.isHost)
                }
                local ____temp_145 = if __t(data.isHost) then "host" else "guest"
                __L1.currentRole = ____temp_145
                __L1.role = ____temp_145
                __L1.room = data.room
                __L1.ready = false
                __L1.readyRevision = __L1.readyRevision + 1
                window.sessionStorage:setItem(
                    __L1.SESSION,
                    window.JSON:stringify(__assign({}, __L1.credentials, {code = __L1.room.code, hostPlayerId = __L1.room.hostPlayerId}))
                )
                __L1:absorb(data)
                __L1:setStatus(__add(
                    __add("Dupla ", __L1.room.code),
                    " aberta. Passe o código e toquem em ESTOU PRONTO."
                ))
                __L1:scheduleSync(120)
            end)
            ____try = ____try.catch(
                ____try,
                function(____, ____error)
                    return __TS__AsyncAwaiter(function()
                        if gen == __L1.generation then
                            __L1:setStatus(if ____error.name == "AbortError" then "A internet demorou. Tente entrar novamente." else ____error.message, true)
                        end
                    end)
                end
            )
            ____try = ____try.finally(
                ____try,
                function()
                    return __TS__AsyncAwaiter(function()
                        if gen == __L1.generation then
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
    __L1.createHost = function(self)
        __L1:connect("create")
    end
    __L1.prepareGuest = function(self)
        if __t(__L1.credentials) then
            return
        end
        __L1["$"](__L1, "coopPairing").hidden = false
        __L1:setStatus("Peça o código da Dupla ao amigo. A Arena da Resenha usa outro tipo de sala.")
        __L1["$"](__L1, "coopCodeIn"):focus()
    end
    __L1.applyCode = function(self)
        __L1:connect("join")
    end
    __L1.copyCode = function(self)
        return __TS__AsyncAwaiter(function(____awaiter_resolve)
            local ____opt_146 = __L1.room
            if ____opt_146 ~= nil then
                ____opt_146 = ____opt_146.code
            end
            local value = ____opt_146
            if not __t(value) then
                return ____awaiter_resolve(nil)
            end
            local ____try = __TS__AsyncAwaiter(function()
                __TS__Await(window.navigator.clipboard:writeText(value))
                __L1:setStatus(__add(
                    __add("Código copiado! O amigo abre Dupla online e digita ", value),
                    "."
                ))
            end)
            ____try = ____try.catch(
                ____try,
                function(____)
                    return __TS__AsyncAwaiter(function()
                        __L1["$"](__L1, "coopCodeOut"):focus()
                        __L1["$"](__L1, "coopCodeOut"):select()
                        __L1:setStatus(__add(
                            __add("Código da dupla: ", value),
                            ". Selecione para copiar."
                        ))
                    end)
                end
            )
            __TS__Await(____try)
        end)
    end
    __L1.setupNet = function(self)
        local ____t_150 = __t
        local ____t_149 = __t
        local ____temp_148 = if __t(__L1.net) then __L1.net else not __t(__L1.credentials)
        __O[3095] = ____temp_148
        if ____t_150(if ____t_149(____temp_148) then __O[3095] else not __t(window.ArenaNet)) then
            return
        end
        __L1.net = window.ArenaNet:create({
            code = __L1.room.code,
            playerId = __L1.credentials.playerId,
            hostPlayerId = __L1.room.hostPlayerId,
            players = __L1.room.players,
            isHost = __L1.role == "host",
            request = __L1.request,
            onInput = function(____, id, command)
                if __L1.role == "host" then
                    __L1:acceptInput(id, command)
                end
            end,
            onState = function(____, state)
                if __L1.role == "guest" then
                    __L1:receiveState(state)
                end
            end
        })
    end
    __L1.wireInput = function(self)
        local ____local = __L1:getLocalInput()
        local ____L1_151, ____inputSeq_152 = __L1, "inputSeq"
        local ____L1_inputSeq_153 = ____L1_151[____inputSeq_152] + 1
        ____L1_151[____inputSeq_152] = ____L1_inputSeq_153
        return {
            seq = ____L1_inputSeq_153,
            x = if __t(____local.right) then 1 else 0 - if __t(____local.left) then 1 else 0,
            y = 0,
            jump = not not __t(____local.jump),
            jumpPress = ____local.jumpPress,
            attack = ____local.paper,
            special = ____local.fart,
            dash = ____local.dash,
            ultimate = 0,
            emote = 0,
            aim = 0
        }
    end
    __L1.decodeInput = function(self, i)
        return {
            seq = i.seq,
            left = __lt(i.x, -0.1),
            right = __gt(i.x, 0.1),
            jump = not not __t(i.jump),
            jumpPress = if __t(i.jumpPress) then i.jumpPress else 0,
            paper = if __t(i.attack) then i.attack else 0,
            fart = if __t(i.special) then i.special else 0,
            dash = if __t(i.dash) then i.dash else 0
        }
    end
    __L1.acceptInput = function(self, id, command)
        local ____t_167 = __t
        local ____t_166 = __t
        local ____t_160 = __t
        local ____t_155 = __t
        local ____temp_154 = not __t(command) or not __t(__L1:counter(command.seq))
        __O[3096] = ____temp_154
        local ____id_158 = id
        local ____opt_156 = __L1.room
        if ____opt_156 ~= nil then
            ____opt_156 = ____opt_156.hostPlayerId
        end
        local ____temp_159 = if ____t_155(____temp_154) then __O[3096] else ____id_158 == ____opt_156
        __O[3097] = ____temp_159
        local ____t_164 = __t
        local ____callq_163 = __callq
        local ____opt_161 = __L1.room
        if ____opt_161 ~= nil then
            ____opt_161 = ____opt_161.players
        end
        local ____temp_165 = if ____t_160(____temp_159) then __O[3097] else not ____t_164(____callq_163(
            ____opt_161,
            "some",
            function(____, p) return p.id == id end
        ))
        __O[3098] = ____temp_165
        if ____t_167(if ____t_166(____temp_165) then __O[3098] else __le(command.seq, __L1.remoteSequence)) then
            return
        end
        __L1.remoteSequence = command.seq
        __L1.remoteInput = __L1:decodeInput(command)
        __L1.inputAt = window.performance:now()
    end
    __L1.validWorld = function(self, w)
        local ____t_219 = __t
        local ____t_217 = __t
        local ____t_215 = __t
        local ____t_213 = __t
        local ____t_211 = __t
        local ____t_209 = __t
        local ____t_207 = __t
        local ____t_205 = __t
        local ____t_189 = __t
        local ____t_187 = __t
        local ____t_185 = __t
        local ____t_183 = __t
        local ____t_181 = __t
        local ____t_179 = __t
        local ____t_177 = __t
        local ____t_175 = __t
        local ____t_173 = __t
        local ____t_171 = __t
        local ____t_169 = __t
        local ____temp_168 = if __t(w) then w.v == __L1.PROTOCOL else w
        __O[3099] = ____temp_168
        local ____temp_170 = if ____t_169(____temp_168) then w.mode == "coop" else __O[3099]
        __O[3100] = ____temp_170
        local ____temp_172 = if ____t_171(____temp_170) then __L1:counter(w.seq) else __O[3100]
        __O[3101] = ____temp_172
        local ____temp_174 = if ____t_173(____temp_172) then type(w.matchId) == "string" else __O[3101]
        __O[3102] = ____temp_174
        local ____temp_176 = if ____t_175(____temp_174) then __L1:finite(w.time) else __O[3102]
        __O[3103] = ____temp_176
        local ____temp_178 = if ____t_177(____temp_176) then __isInteger(w.wave) else __O[3103]
        __O[3104] = ____temp_178
        local ____temp_180 = if ____t_179(____temp_178) then __ge(w.wave, 0) else __O[3104]
        __O[3105] = ____temp_180
        local ____temp_182 = if ____t_181(____temp_180) then __lt(w.wave, 3) else __O[3105]
        __O[3106] = ____temp_182
        local ____temp_184 = if ____t_183(____temp_182) then __call(
            __arrL({
                "countdown",
                "playing",
                "intermission",
                "victory",
                "defeat"
            }, 5),
            "includes",
            w.stage
        ) else __O[3106]
        __O[3107] = ____temp_184
        local ____temp_186 = if ____t_185(____temp_184) then __isArray(w.players) else __O[3107]
        __O[3108] = ____temp_186
        local ____temp_188 = if ____t_187(____temp_186) then __len(w.players) == 2 else __O[3108]
        __O[3116] = ____temp_188
        local ____temp_204 = if ____t_189(____temp_188) then __call(
            w.players,
            "every",
            function(____, p, id)
                local ____t_203 = __t
                local ____t_201 = __t
                local ____t_199 = __t
                local ____t_197 = __t
                local ____t_195 = __t
                local ____t_193 = __t
                local ____t_191 = __t
                local ____temp_190 = if __t(p) then p.id == id else p
                __O[3109] = ____temp_190
                local ____temp_192 = if ____t_191(____temp_190) then __call(
                    __arrL({
                        "x",
                        "y",
                        "vx",
                        "vy",
                        "hp",
                        "gas"
                    }, 6),
                    "every",
                    function(____, k) return __L1:finite(__get(p, k)) end
                ) else __O[3109]
                __O[3110] = ____temp_192
                local ____temp_194 = if ____t_193(____temp_192) then __ge(p.x, 0) else __O[3110]
                __O[3111] = ____temp_194
                local ____temp_196 = if ____t_195(____temp_194) then __le(p.x, 960) else __O[3111]
                __O[3112] = ____temp_196
                local ____temp_198 = if ____t_197(____temp_196) then __ge(p.y, 0) else __O[3112]
                __O[3113] = ____temp_198
                local ____temp_200 = if ____t_199(____temp_198) then __le(p.y, 540) else __O[3113]
                __O[3114] = ____temp_200
                local ____temp_202 = if ____t_201(____temp_200) then p.used else __O[3114]
                __O[3115] = ____temp_202
                return if ____t_203(____temp_202) then __call(
                    __arrL({"paper", "fart", "dash", "jumpPress"}, 4),
                    "every",
                    function(____, k) return __L1:counter(__get(p.used, k)) end
                ) else __O[3115]
            end
        ) else __O[3116]
        __O[3117] = ____temp_204
        local ____temp_206 = if ____t_205(____temp_204) then w.boss else __O[3117]
        __O[3118] = ____temp_206
        local ____temp_208 = if ____t_207(____temp_206) then __call(__L1.bossTypes, "includes", w.boss.type) else __O[3118]
        __O[3119] = ____temp_208
        local ____temp_210 = if ____t_209(____temp_208) then __call(
            __arrL({"x", "y", "hp", "max"}, 4),
            "every",
            function(____, k) return __L1:finite(__get(w.boss, k)) end
        ) else __O[3119]
        __O[3120] = ____temp_210
        local ____temp_212 = if ____t_211(____temp_210) then __isArray(w.shots) else __O[3120]
        __O[3121] = ____temp_212
        local ____temp_214 = if ____t_213(____temp_212) then __le(
            __len(w.shots),
            64
        ) else __O[3121]
        __O[3122] = ____temp_214
        local ____temp_216 = if ____t_215(____temp_214) then __call(
            w.shots,
            "every",
            function(____, s) return if __t(s) then __call(
                __arrL({"x", "y", "vx", "vy"}, 4),
                "every",
                function(____, k) return __L1:finite(__get(s, k)) end
            ) else s end
        ) else __O[3122]
        __O[3123] = ____temp_216
        local ____temp_218 = if ____t_217(____temp_216) then __isArray(w.hazards) else __O[3123]
        __O[3124] = ____temp_218
        return if ____t_219(____temp_218) then __le(
            __len(w.hazards),
            25
        ) else __O[3124]
    end
    __L1.absorb = function(self, data)
        local ____t_230 = __t
        local ____t_229 = __t
        local ____t_227 = __t
        local ____t_225 = __t
        local ____t_223 = __t
        local ____opt_result_222
        if data ~= nil then
            ____opt_result_222 = data.room
        end
        local ____temp_224 = not ____t_223(____opt_result_222) or data.room.mode ~= "coop"
        __O[3125] = ____temp_224
        local ____temp_226 = if ____t_225(____temp_224) then __O[3125] else data.room.protocol ~= __L1.PROTOCOL
        __O[3126] = ____temp_226
        local ____temp_228 = if ____t_227(____temp_226) then __O[3126] else data.room.capacity ~= 2
        __O[3127] = ____temp_228
        if ____t_230(if ____t_229(____temp_228) then __O[3127] else not __isArray(data.room.players)) then
            error(
                Error(nil, "Esta sala usa outro modo ou versão. Atualize e abra Dupla online."),
                0
            )
        end
        __L1.room = data.room
        __L1.credentials.isHost = __L1.room.hostPlayerId == __L1.credentials.playerId
        local ____temp_231 = if __t(__L1.credentials.isHost) then "host" else "guest"
        __L1.currentRole = ____temp_231
        __L1.role = ____temp_231
        for ____, entry in __iterar((if __t(data.inputs) then data.inputs else __arrL({}, 0))) do
            local ____t_234 = __t
            local ____t_233 = __t
            local ____temp_232 = entry.playerId ~= __L1.room.hostPlayerId
            __O[3128] = ____temp_232
            if ____t_234(if ____t_233(____temp_232) then entry.input else __O[3128]) then
                __L1:acceptInput(entry.playerId, entry.input)
            end
        end
        local ____t_237 = __t
        local ____t_236 = __t
        local ____temp_235 = __L1.role == "guest"
        __O[3129] = ____temp_235
        if ____t_237(if ____t_236(____temp_235) then __O[3129] else __L1.restoring) then
            __L1:receiveState(data.state)
        end
        if __t(__L1.restoring) then
            local own = __call(
                if __t(data.inputs) then data.inputs else __arrL({}, 0),
                "find",
                function(____, i) return i.playerId == __L1.credentials.playerId end
            )
            local ____getq_242 = __getq
            local ____opt_240 = __L1.world
            if ____opt_240 ~= nil then
                ____opt_240 = ____opt_240.players
            end
            local ____opt_238 = ____getq_242(
                ____opt_240,
                __L1:localSlot()
            )
            if ____opt_238 ~= nil then
                ____opt_238 = ____opt_238.used
            end
            local used = ____opt_238
            local ____L1_inputSeq_247 = __L1.inputSeq
            local ____t_246 = __t
            local ____opt_result_245
            if own ~= nil then
                ____opt_result_245 = own.seq
            end
            __O[3130] = ____opt_result_245
            __L1.inputSeq = math.max(____L1_inputSeq_247, if ____t_246(____opt_result_245) then __O[3130] else 0)
            for ____, ____value in __iterar((__arrL(
                {
                    __arrL({"paper", "attack"}, 2),
                    __arrL({"fart", "special"}, 2),
                    __arrL({"dash", "dash"}, 2),
                    __arrL({"jumpPress", "jumpPress"}, 2)
                },
                4
            ))) do
                local a = ____value[1]
                local b = ____value[2]
                local ____set_260 = __set
                local ____L1_input_258 = __L1.input
                local ____a_259 = a
                local ____get_result_256 = __get(__L1.input, a)
                local ____t_253 = __t
                local ____getq_251 = __getq
                local ____opt_result_250
                if own ~= nil then
                    ____opt_result_250 = own.input
                end
                local ____getq_251_result_252 = ____getq_251(____opt_result_250, b)
                __O[3131] = ____getq_251_result_252
                local ____temp_257 = if ____t_253(____getq_251_result_252) then __O[3131] else 0
                local ____t_255 = __t
                local ____getq_result_254 = __getq(used, a)
                __O[3132] = ____getq_result_254
                ____set_260(
                    ____L1_input_258,
                    ____a_259,
                    math.max(____get_result_256, ____temp_257, if ____t_255(____getq_result_254) then __O[3132] else 0)
                )
            end
            local ____t_263 = __t
            local ____opt_261 = __call(
                __L1.room.players,
                "find",
                function(____, p) return p.id == __L1.credentials.playerId end
            )
            if ____opt_261 ~= nil then
                ____opt_261 = ____opt_261.ready
            end
            __L1.ready = not not ____t_263(____opt_261)
            __L1.restoring = false
            __L1.readyRevision = __L1.readyRevision + 1
            __L1:setStatus("Você voltou à mesma dupla. A resenha continua.")
        end
        local ____t_266 = __t
        local ____t_265 = __t
        local ____lt_result_264 = __lt(
            __len(__L1.room.players),
            2
        )
        __O[3133] = ____lt_result_264
        if ____t_266(if ____t_265(____lt_result_264) then __L1.world else __O[3133]) then
            __L1.targetWorld = nil
            __L1.world = nil
            __L1.predicted = nil
            __L1:setArena(false)
            __L1:setStatus("O parceiro saiu. Passe o mesmo código para outro amigo e fiquem prontos.")
            __L1.ready = false
            __L1.readyRevision = __L1.readyRevision + 1
        end
        if not __t(__L1.room.hostConnected) then
            __L1:resetInputs()
            __L1:setStatus("Aguardando o celular que criou a dupla voltar…", true)
        elseif __t(__L1.failures) then
            __L1:setStatus("Conexão recuperada. A resenha continua.")
        end
        __L1:setupNet()
        local ____opt_269 = __L1.net
        if ____opt_269 ~= nil then
            ____opt_269 = ____opt_269.updateRoster
        end
        if ____opt_269 ~= nil then
            ____opt_269(____opt_269, __L1.room.players)
        end
        __L1:updateLobby()
        __L1.failures = 0
    end
    __L1.receiveState = function(self, incoming)
        local ____t_273 = __t
        local ____t_272 = __t
        local ____temp_271 = not __t(__L1:validWorld(incoming))
        __O[3134] = ____temp_271
        if ____t_273(if ____t_272(____temp_271) then __O[3134] else if __t(__L1.world) then __le(incoming.seq, __L1.world.seq) else __L1.world) then
            return
        end
        local changed = __L1.receivedMatch ~= incoming.matchId
        __L1.world = incoming
        __L1.world.fx = __arrL({}, 0)
        __L1.targetWorld = __L1.world
        __L1.stateSeq = math.max(__L1.stateSeq, incoming.seq)
        __L1.lastStateAt = window.performance:now()
        if __t(changed) then
            __L1.receivedMatch = __L1.world.matchId
            __L1.smoothedPlayers = __arrL({}, 0)
            __L1.predicted = nil
            __L1.predictionTarget = nil
            __L1:resetInputs()
        end
        if __L1.role == "guest" then
            __L1:reconcilePrediction(__get(__L1.world.players, 1))
        end
        if not __t(__L1:arenaVisible()) then
            __L1:setArena(true)
        end
        __L1["$"](__L1, "coopRoleLabel").textContent = if __L1.role == "host" then "VOCÊ · DA ROÇA 1" else "VOCÊ · PARCEIRO 2"
    end
    __L1.snapshot = function(self)
        if not __t(__L1.world) then
            return nil
        end
        local ____L1_world_277 = __L1.world
        local ____L1_274, ____stateSeq_275 = __L1, "stateSeq"
        local ____L1_stateSeq_276 = ____L1_274[____stateSeq_275] + 1
        ____L1_274[____stateSeq_275] = ____L1_stateSeq_276
        ____L1_world_277.seq = ____L1_stateSeq_276
        __L1.world.serverTime = __L1:serverNow()
        local snap = __assign(
            {},
            __L1.world,
            {
                players = __call(
                    __L1.world.players,
                    "map",
                    function(____, p) return __assign(
                        {},
                        p,
                        {used = __assign({}, p.used)}
                    ) end
                ),
                shots = __call(__L1.world.shots, "slice", -56),
                hazards = __call(__L1.world.hazards, "slice", -20),
                fx = __arrL({}, 0)
            }
        )
        return window.JSON:parse(window.JSON:stringify(
            snap,
            function(____, key, value) return if type(value) == "number" then math.floor(value * 1000 + 0.5) / 1000 else value end
        ))
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
                    125 - (window.performance:now() - __L1.lastRequestAt)
                )
            )
        end
    end
    __L1.syncNow = function(self)
        if not __t(__L1.credentials) then
            return
        end
        __L1.urgent = true
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
                __L1.urgent = true
                return ____awaiter_resolve(nil)
            end
            __L1.syncing = true
            __L1.urgent = false
            __L1.lastRequestAt = window.performance:now()
            local gen = __L1.generation
            local body = if __t(__L1.restoring) then {} else {input = __L1:wireInput()}
            local revision = __L1.readyRevision
            if __t(not __t(__L1.restoring) and __L1.syncedReady ~= revision) then
                body.ready = __L1.ready
            end
            if __t(__L1.role == "host" and not __t(__L1.restoring)) then
                if __t(__L1.world) then
                    body.state = __L1:snapshot()
                    body.status = if __t(__call(
                        __arrL({"victory", "defeat"}, 2),
                        "includes",
                        __L1.world.stage
                    )) then "finished" else "playing"
                else
                    body.status = "lobby"
                end
            end
            local started = window.performance:now()
            local wall = window.Date:now()
            local ____hasReturned, ____returnValue
            local ____try = __TS__AsyncAwaiter(function()
                local data = __TS__Await(__L1:request(
                    __add(
                        __add("/api/arena/rooms/", __L1.room.code),
                        "/sync"
                    ),
                    {body = body}
                ))
                if gen ~= __L1.generation then
                    ____hasReturned = true
                    return
                end
                local elapsed = window.performance:now() - started
                __L1.rttMs = if __t(__L1.rttMs) then __L1.rttMs * 0.7 + elapsed * 0.3 else elapsed
                if __t(__L1:finite(data.serverTime)) then
                    __L1.serverOffset = data.serverTime - (wall + window.Date:now()) / 2
                end
                if body.ready ~= nil then
                    __L1.syncedReady = revision
                end
                __L1:absorb(data)
            end)
            ____try = ____try.catch(
                ____try,
                function(____, ____error)
                    return __TS__AsyncAwaiter(function()
                        if gen ~= __L1.generation then
                            ____hasReturned = true
                            return
                        end
                        __L1.failures = __L1.failures + 1
                        if __t(__call(
                            __arrL({401, 403, 404, 410}, 4),
                            "includes",
                            ____error.status
                        )) then
                            __L1:clearConnection("A dupla foi encerrada ou expirou. Crie outra sala pelo celular.")
                            ____hasReturned = true
                            return
                        end
                        __L1:setStatus(if ____error.name == "AbortError" then "A internet demorou. Reconectando a dupla…" else if __t(____error.message) then ____error.message else "Conexão oscilando. Reconectando…", true)
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
            local ____t_280 = __t
            local ____t_279 = __t
            local ____temp_278 = gen == __L1.generation
            __O[3135] = ____temp_278
            if ____t_280(if ____t_279(____temp_278) then __L1.credentials else __O[3135]) then
                local ____opt_283 = __L1.net
                if ____opt_283 ~= nil then
                    ____opt_283 = ____opt_283.getStatus
                end
                local ____opt_result_285
                if ____opt_283 ~= nil then
                    ____opt_result_285 = ____opt_283(____opt_283)
                end
                local link = ____opt_result_285
                local ____ge_289 = __ge
                local ____opt_result_288
                if link ~= nil then
                    ____opt_result_288 = link.connected
                end
                local cadence = if not __t(__L1.world) then 500 else if ____ge_289(____opt_result_288, 1) then 500 else 180
                __L1:scheduleSync(if __t(__L1.urgent) then 0 else math.max(
                    0,
                    math.min(
                        cadence * math.max(1, __L1.failures),
                        2500
                    ) - (window.performance:now() - __L1.lastRequestAt)
                ))
            end
        end)
    end
    __L1.player = function(self, id, x)
        return {
            id = id,
            x = x,
            y = __L1.FLOOR,
            vx = 0,
            vy = 0,
            ground = true,
            facing = if id == 0 then 1 else -1,
            hp = 180,
            max = 180,
            gas = 100,
            paperCD = 0,
            fartCD = 0,
            dashCD = 0,
            dashTime = 0,
            inv = 1,
            attack = 0,
            attackKind = "paper",
            lastJump = false,
            used = {paper = 0, fart = 0, dash = 0, jumpPress = 0},
            ackSeq = 0,
            down = 0,
            anim = 0,
            moveX = 0
        }
    end
    __L1.boss = function(self, wave)
        local ____type = __get(__L1.bossTypes, wave)
        local max = __get(
            __arrL({1215, 1485, 1890}, 3),
            wave
        )
        return {
            type = ____type,
            x = 730,
            y = __L1.FLOOR,
            hp = max,
            max = max,
            phase = 1,
            state = "windup",
            timer = 1.15,
            duration = 1.15,
            pattern = 0,
            kind = "fan",
            targetX = 240,
            targetY = 410,
            dir = -1,
            hit = 0
        }
    end
    __L1.startMatch = function(self)
        local ____t_292 = __t
        local ____t_291 = __t
        local ____temp_290 = __L1.role ~= "host" or not __t(__L1:isConnected())
        __O[3136] = ____temp_290
        __D[1] = if ____t_292(if ____t_291(____temp_290) then __O[3136] else __call(
            __L1.room.players,
            "some",
            function(____, p) return if p.id == __L1.credentials.playerId then not __t(__L1.ready) else not __t(p.ready) end
        )) then
            return
        end
        __L1:resetInputs()
        local ____local = __L1:getLocalInput()
        local players = __arrL(
            {
                __L1:player(0, 210),
                __L1:player(1, 350)
            },
            2
        )
        for ____, p in __iterar((players)) do
            local command = if __t(p.id) then __L1.remoteInput else ____local
            for ____, a in __iterar((__arrL({"paper", "fart", "dash", "jumpPress"}, 4))) do
                local ____set_296 = __set
                local ____p_used_295 = p.used
                local ____t_294 = __t
                local ____get_result_293 = __get(command, a)
                __O[3137] = ____get_result_293
                ____set_296(____p_used_295, a, if ____t_294(____get_result_293) then __O[3137] else 0)
            end
        end
        local ____t_302 = __t
        local ____opt_299 = window.crypto
        local ____opt_297 = ____opt_299 and ____opt_299.randomUUID
        local ____temp_301 = ____opt_297 and ____opt_297(____opt_299)
        __O[3138] = ____temp_301
        local matchId = if ____t_302(____temp_301) then __O[3138] else __call(
            window.Date:now(),
            "toString",
            36
        )
        __L1.world = {
            v = __L1.PROTOCOL,
            mode = "coop",
            seq = __L1.stateSeq,
            matchId = matchId,
            serverTime = __L1:serverNow(),
            startAt = __L1:serverNow() + 3200,
            time = 0,
            tick = 0,
            wave = 0,
            stage = "countdown",
            stageTimer = 0,
            players = players,
            boss = __L1:boss(0),
            shots = __arrL({}, 0),
            hazards = __arrL({}, 0),
            fx = __arrL({}, 0),
            nextShot = 1
        }
        __L1.receivedMatch = matchId
        __L1.targetWorld = __L1.world
        __L1.smoothedPlayers = __arrL({}, 0)
        __L1.predicted = nil
        __L1.lastStateAt = window.performance:now()
        __L1:setArena(true)
        __L1["$"](__L1, "coopRoleLabel").textContent = "VOCÊ · DA ROÇA 1"
        local ____opt_305 = __L1.net
        if ____opt_305 ~= nil then
            ____opt_305 = ____opt_305.sendState
        end
        if ____opt_305 ~= nil then
            ____opt_305(
                ____opt_305,
                __L1:snapshot()
            )
        end
        __L1:syncNow()
    end
    __L1.resetStick = function(self)
        __L1.joystickPointer = nil
        __L1.joyCenter = nil
        __L1.joyX = 0
        if __t(__L1["$"](__L1, "coopJoystick")) then
            __L1["$"](__L1, "coopJoystick").style:setProperty("--stick-x", "0px")
            __L1["$"](__L1, "coopJoystick").style:setProperty("--stick-y", "0px")
            __L1["$"](__L1, "coopJoystick"):setAttribute("aria-valuenow", "0")
        end
    end
    __L1.moveStick = function(self, e)
        if not __t(__L1.joyCenter) then
            return
        end
        __L1.joyX = __L1:clamp((e.clientX - __L1.joyCenter.x) / __L1.joyCenter.r, -1, 1)
        if math.abs(__L1.joyX) < 0.15 then
            __L1.joyX = 0
        end
        __L1["$"](__L1, "coopJoystick").style:setProperty(
            "--stick-x",
            __add(__L1.joyX * __L1.joyCenter.r, "px")
        )
        __L1["$"](__L1, "coopJoystick").style:setProperty(
            "--stick-y",
            __add(
                __L1:clamp(
                    e.clientY - __L1.joyCenter.y,
                    __TS__Number(-__L1.joyCenter.r) * 0.3,
                    __L1.joyCenter.r * 0.3
                ),
                "px"
            )
        )
        __L1["$"](__L1, "coopJoystick"):setAttribute(
            "aria-valuenow",
            tostring(math.floor(__L1.joyX * 100 + 0.5))
        )
        __L1:changedInput()
    end
    __L1.actionHeld = function(self, action)
        return __call(
            __arr(__TS__Spread(__iter(__L1.pressedKeys))),
            "some",
            function(____, code) return __L1:keyMatches(action, code) end
        )
    end
    __L1.releasePointer = function(self, id)
        local p = __call(__L1.activePointers, "get", id)
        if not __t(p) then
            return
        end
        __call(__L1.activePointers, "delete", id)
        if not __t(__call(
            __arr(__TS__Spread(__iter(__call(__L1.activePointers, "values")))),
            "some",
            function(____, v) return v.el == p.el end
        )) then
            p.el.classList:remove("pressed")
        end
        if p.action == "jump" then
            local ____L1_input_309 = __L1.input
            local ____t_308 = __t
            local ____temp_307 = __L1:actionHeld("jump")
            __O[3139] = ____temp_307
            ____L1_input_309.jump = if ____t_308(____temp_307) then __O[3139] else __call(
                __arr(__TS__Spread(__iter(__call(__L1.activePointers, "values")))),
                "some",
                function(____, v) return v.action == "jump" end
            )
        end
        __L1:changedInput()
    end
    __L1.resetInputs = function(self)
        local ____L1_input_311 = __L1.input
        local ____L1_input_310 = __L1.input
        __L1.input.jump = false
        ____L1_input_310.right = false
        ____L1_input_311.left = false
        __call(__L1.pressedKeys, "clear")
        for ____, p in __iterar((__call(__L1.activePointers, "values"))) do
            p.el.classList:remove("pressed")
        end
        __call(__L1.activePointers, "clear")
        __L1:resetStick()
        __L1:changedInput()
    end
    __L1.changedInput = function(self)
        if __t(not __t(__L1.opened) or not __t(__L1.credentials)) then
            return
        end
        if __L1.role == "guest" then
            local ____opt_314 = __L1.net
            if ____opt_314 ~= nil then
                ____opt_314 = ____opt_314.sendInput
            end
            if ____opt_314 ~= nil then
                ____opt_314(
                    ____opt_314,
                    __L1:wireInput()
                )
            end
        end
        __L1:syncNow()
    end
    __L1.pulse = function(self, action)
        local ____t_320 = __t
        local ____t_317 = __t
        local ____temp_316 = not __t(__L1:arenaVisible()) or not __t(__call(
            __arrL({"paper", "fart", "dash"}, 3),
            "includes",
            action
        ))
        __O[3140] = ____temp_316
        local ____opt_318 = __L1.world
        if ____opt_318 ~= nil then
            ____opt_318 = ____opt_318.stage
        end
        if ____t_320(if ____t_317(____temp_316) then __O[3140] else ____opt_318 ~= "playing") then
            return
        end
        __inc(__L1.input, action, 1, true)
        __L1:changedInput()
    end
    __L1.getLocalInput = function(self)
        local ____assign_329 = __assign
        local ____temp_327 = {}
        local ____L1_input_328 = __L1.input
        local ____L1_inputSeq_325 = __L1.inputSeq
        local ____t_322 = __t
        local ____temp_321 = __L1.joyX < -0.15
        __O[3141] = ____temp_321
        local ____temp_326 = if ____t_322(____temp_321) then __O[3141] else __L1.input.left
        local ____t_324 = __t
        local ____temp_323 = __L1.joyX > 0.15
        __O[3142] = ____temp_323
        return ____assign_329(____temp_327, ____L1_input_328, {seq = ____L1_inputSeq_325, left = ____temp_326, right = if ____t_324(____temp_323) then __O[3142] else __L1.input.right})
    end
    __L1.keyMatches = function(self, action, code)
        local ____t_332 = __t
        local ____opt_330 = window.ControlSettings
        if ____opt_330 ~= nil then
            ____opt_330 = ____opt_330.matches
        end
        return if ____t_332(____opt_330) then window.ControlSettings:matches(action, code) else __callq(
            __get(__L1.defaults, action),
            "includes",
            code
        )
    end
    __L1.readHeld = function(self)
        __L1.input.left = __L1:actionHeld("left")
        __L1.input.right = __L1:actionHeld("right")
        local ____L1_input_335 = __L1.input
        local ____t_334 = __t
        local ____temp_333 = __L1:actionHeld("jump")
        __O[3143] = ____temp_333
        ____L1_input_335.jump = if ____t_334(____temp_333) then __O[3143] else __call(
            __arr(__TS__Spread(__iter(__call(__L1.activePointers, "values")))),
            "some",
            function(____, v) return v.action == "jump" end
        )
    end
    __L1.fx = function(self, x, y, color, n)
        if n == nil then
            n = 7
        end
        do
            local i = 0
            while i < n do
                __call(
                    __L1.world.fx,
                    "push",
                    {
                        x = x,
                        y = y,
                        vx = (math.random() - 0.5) * 140,
                        vy = -math.random() * 120,
                        life = 0.4 + math.random() * 0.3,
                        c = color
                    }
                )
                i = i + 1
            end
        end
        if __gt(
            __len(__L1.world.fx),
            48
        ) then
            __call(
                __L1.world.fx,
                "splice",
                0,
                __len(__L1.world.fx) - 48
            )
        end
    end
    __L1.damagePlayer = function(self, p, n, from)
        if __t(__le(p.hp, 0) or __gt(p.inv, 0)) then
            return
        end
        p.hp = math.max(0, p.hp - n)
        p.inv = 0.75
        p.vx = if __lt(p.x, from) then -1 else 1 * 130
        p.vy = -110
        p.ground = false
        __L1:fx(p.x, p.y - 30, "#e9a484", 9)
        if not __t(p.hp) then
            p.down = 8
            local ____p_336 = p
            p.vy = 0
            ____p_336.vx = 0
        end
    end
    __L1.damageBoss = function(self, n, from)
        local b = __L1.world.boss
        if __le(b.hp, 0) then
            return
        end
        b.hp = math.max(
            0,
            b.hp - math.floor(n * if b.state == "recover" then 1 else 0.5 + 0.5)
        )
        b.hit = 0.12
        __L1:fx(b.x, b.y - 38, if from == 0 then "#f7dda0" else "#b4ebdf", 5)
    end
    __L1.firePlayer = function(self, p)
        if __t(__gt(p.paperCD, 0) or __le(p.hp, 0)) then
            return
        end
        p.paperCD = 0.23
        p.attack = 0.24
        p.attackKind = "paper"
        local b = __L1.world.boss
        local aim = math.atan2(
            b.y - 38 - (p.y - 32),
            math.abs(b.x - p.x)
        )
        local ____call_341 = __call
        local ____L1_world_shots_340 = __L1.world.shots
        local ____L1_world_337, ____nextShot_338 = __L1.world, "nextShot"
        local ____L1_world_nextShot_339 = ____L1_world_337[____nextShot_338]
        ____L1_world_337[____nextShot_338] = ____L1_world_nextShot_339 + 1
        ____call_341(
            ____L1_world_shots_340,
            "push",
            {
                id = ____L1_world_nextShot_339,
                owner = p.id,
                x = p.x + p.facing * 25,
                y = p.y - 32,
                vx = p.facing * math.cos(aim) * 590,
                vy = math.sin(aim) * 590,
                life = 1.7,
                r = 7,
                damage = 24,
                type = "paper"
            }
        )
    end
    __L1.fart = function(self, p)
        local ____t_344 = __t
        local ____t_343 = __t
        local ____temp_342 = __gt(p.fartCD, 0) or __lt(p.gas, 20)
        __O[3146] = ____temp_342
        if ____t_344(if ____t_343(____temp_342) then __O[3146] else __le(p.hp, 0)) then
            return
        end
        p.gas = p.gas - 20
        p.fartCD = 0.85
        p.attack = 0.32
        p.attackKind = "fart"
        __L1:fx(p.x + p.facing * 25, p.y - 20, "#c8e391", 12)
        if __t(math.abs(p.x - __L1.world.boss.x) < 180 and math.abs(p.y - __L1.world.boss.y) < 140) then
            __L1:damageBoss(60, p.id)
        end
        __L1.world.shots = __call(
            __L1.world.shots,
            "filter",
            function(____, s) return s.owner ~= "enemy" or __hypot(s.x - p.x, s.y - (p.y - 20)) > 170 end
        )
    end
    __L1.dash = function(self, p)
        if __t(__gt(p.dashCD, 0) or __le(p.hp, 0)) then
            return
        end
        p.dashTime = 0.18
        p.dashCD = 1.15
        p.inv = math.max(p.inv, 0.25)
        p.vx = p.facing * 650
        __L1:fx(p.x, p.y - 24, if __t(p.id) then "#9bdcd8" else "#e9d9a0", 12)
    end
    __L1.advanceMotion = function(self, p, i, dt)
        for ____, timer in __iterar((__arrL({
            "inv",
            "paperCD",
            "fartCD",
            "dashCD",
            "dashTime",
            "attack"
        }, 6))) do
            local ____set_348 = __set
            local ____p_347 = p
            local ____t_346 = __t
            local ____get_result_345 = __get(p, timer)
            __O[3147] = ____get_result_345
            ____set_348(
                ____p_347,
                timer,
                math.max(0, if ____t_346(____get_result_345) then __O[3147] else 0 - dt)
            )
        end
        if __le(p.hp, 0) then
            return
        end
        local dir = if __t(i.right) then 1 else 0 - if __t(i.left) then 1 else 0
        p.moveX = dir
        if __t(dir) then
            p.facing = dir
        end
        local dashPressed = __gt(if __t(i.dash) then i.dash else 0, p.used.dash)
        if __t(dashPressed) then
            p.used.dash = i.dash
            if __le(p.dashCD, 0) then
                p.dashTime = 0.18
                p.dashCD = 1.15
                p.inv = math.max(p.inv, 0.25)
            end
        end
        if __gt(p.dashTime, 0) then
            p.vx = p.facing * 650
        else
            local target = dir * 280
            local step = if __t(dir) then 1700 else 2100 * dt
            p.vx = p.vx + __L1:clamp(target - p.vx, -step, step)
        end
        local jumpPressed = __gt(if __t(i.jumpPress) then i.jumpPress else 0, p.used.jumpPress)
        p.used.jumpPress = math.max(p.used.jumpPress, if __t(i.jumpPress) then i.jumpPress else 0)
        local ____t_351 = __t
        local ____t_350 = __t
        local ____temp_349 = if __t(jumpPressed) then jumpPressed else if __t(i.jump) then not __t(p.lastJump) else i.jump
        __O[3148] = ____temp_349
        if ____t_351(if ____t_350(____temp_349) then p.ground else __O[3148]) then
            p.vy = -370
            p.ground = false
        end
        local ____t_354 = __t
        local ____t_353 = __t
        local ____temp_352 = if __t(i.jump) then not __t(p.ground) else i.jump
        __O[3149] = ____temp_352
        if ____t_354(if ____t_353(____temp_352) then __gt(p.gas, 0) else __O[3149]) then
            if __gt(p.vy, -220) then
                p.vy = math.max(-220, p.vy - 1050 * dt)
            end
            p.gas = math.max(0, p.gas - 19 * dt)
        end
        p.lastJump = not not __t(i.jump)
        local oldY = p.y
        p.vy = p.vy + 850 * dt
        p.x = __L1:clamp(p.x + p.vx * dt, 30, 930)
        p.y = p.y + p.vy * dt
        p.ground = false
        if __ge(p.vy, 0) then
            for ____, ____value in __iterar((__L1.platforms)) do
                local x = ____value[1]
                local y = ____value[2]
                local w = ____value[3]
                local ____t_359 = __t
                local ____t_358 = __t
                local ____t_356 = __t
                local ____temp_355 = __gt(p.x, x - 10) and __lt(p.x, x + w + 10)
                __O[3150] = ____temp_355
                local ____temp_357 = if ____t_356(____temp_355) then __le(oldY, y + 3) else __O[3150]
                __O[3151] = ____temp_357
                if ____t_359(if ____t_358(____temp_357) then __ge(p.y, y) else __O[3151]) then
                    p.y = y
                    p.vy = 0
                    p.ground = true
                    break
                end
            end
        end
        if __ge(p.y, __L1.FLOOR) then
            p.y = __L1.FLOOR
            p.vy = 0
            p.ground = true
        end
        if __lt(p.y, 70) then
            p.y = 70
            p.vy = math.max(0, p.vy)
        end
        if __t(p.ground) then
            p.gas = math.min(100, p.gas + 24 * dt)
        end
        p.anim = p.anim + math.abs(p.vx) * dt / 48
        p.ackSeq = if __t(i.seq) then i.seq else 0
    end
    __L1.consume = function(self, p, i)
        for ____, action in __iterar((__arrL({"paper", "fart"}, 2))) do
            local ____t_361 = __t
            local ____get_result_360 = __get(i, action)
            __O[3152] = ____get_result_360
            local value = math.max(
                0,
                math.floor(if ____t_361(____get_result_360) then __O[3152] else 0)
            )
            if __gt(
                value,
                __get(p.used, action)
            ) then
                __set(p.used, action, value)
                if action == "paper" then
                    __L1:firePlayer(p)
                else
                    __L1:fart(p)
                end
            end
        end
    end
    __L1.move = function(self, p, i, dt)
        if __le(p.hp, 0) then
            local helper = __get(__L1.world.players, 1 - p.id)
            p.down = p.down - dt * if __t(__gt(helper.hp, 0) and math.abs(helper.x - p.x) < 100) then 2 else 1
            if __t(__le(p.down, 0) and __gt(helper.hp, 0)) then
                p.hp = 90
                p.inv = 2
                p.gas = 100
                p.y = __L1.FLOOR
                local ____p_362 = p
                p.vy = 0
                ____p_362.vx = 0
                p.ground = true
                __L1:fx(p.x, p.y - 25, "#c2ead8", 12)
            end
            return
        end
        local dashed = p.used.dash
        __L1:advanceMotion(p, i, dt)
        if __t(__gt(p.used.dash, dashed) and __gt(p.dashTime, 0)) then
            __L1:fx(p.x, p.y - 24, if __t(p.id) then "#9bdcd8" else "#e9d9a0", 6)
        end
        __L1:consume(p, i)
        local ____t_365 = __t
        local ____t_364 = __t
        local ____temp_363 = __gt(p.dashTime, 0) and math.abs(p.x - __L1.world.boss.x) < 50
        __O[3153] = ____temp_363
        if ____t_365(if ____t_364(____temp_363) then math.abs(p.y - __L1.world.boss.y) < 80 else __O[3153]) then
            __L1:damageBoss(15, p.id)
            p.dashTime = 0
        end
    end
    __L1.clonePlayer = function(self, p)
        return __assign(
            {},
            p,
            {used = __assign({}, p.used)}
        )
    end
    __L1.reconcilePrediction = function(self, authoritative)
        if not __t(authoritative) then
            return
        end
        local ____t_368 = __t
        local ____t_367 = __t
        local ____temp_366 = not __t(__L1.predicted) or __le(__L1.predicted.hp, 0) ~= __le(authoritative.hp, 0)
        __O[3154] = ____temp_366
        if ____t_368(if ____t_367(____temp_366) then __O[3154] else __hypot(__L1.predicted.x - authoritative.x, __L1.predicted.y - authoritative.y) > 300) then
            __L1.predicted = __L1:clonePlayer(authoritative)
            __L1.predictionTarget = nil
            return
        end
        local age = __L1:clamp(
            (__L1:serverNow() - if __t(__L1.world.serverTime) then __L1.world.serverTime else __L1:serverNow()) / 1000,
            0,
            0.3
        )
        local target = __L1:clonePlayer(authoritative)
        local command = __L1:getLocalInput()
        if __L1.world.stage == "playing" then
            do
                local t = 0
                while t < age do
                    __L1:advanceMotion(
                        target,
                        __assign({}, command, {jumpPress = target.used.jumpPress, dash = target.used.dash}),
                        math.min(__L1.STEP, age - t)
                    )
                    t = t + __L1.STEP
                end
            end
        end
        local pendingJump = __gt(command.jumpPress, authoritative.used.jumpPress)
        local pendingDash = __gt(command.dash, authoritative.used.dash)
        local direction = if __t(command.right) then 1 else 0 - if __t(command.left) then 1 else 0
        local ____t_370 = __t
        local ____TS__Number_result_369 = __TS__Number(authoritative.moveX)
        __O[3155] = ____TS__Number_result_369
        __L1.predictionTarget = {
            player = target,
            pendingMove = direction ~= if ____t_370(____TS__Number_result_369) then __O[3155] else 0,
            pendingJump = pendingJump,
            pendingDash = pendingDash,
            at = window.performance:now()
        }
        __L1.predicted.hp = authoritative.hp
        __L1.predicted.max = authoritative.max
        __L1.predicted.down = authoritative.down
        __L1.predicted.inv = math.max(__L1.predicted.inv, authoritative.inv)
        local ____L1_predicted_371, ____gas_372 = __L1.predicted, "gas"
        ____L1_predicted_371[____gas_372] = ____L1_predicted_371[____gas_372] + (authoritative.gas - __L1.predicted.gas) * 0.25
        for ____, action in __iterar((__arrL({"paper", "fart", "dash", "jumpPress"}, 4))) do
            __set(
                __L1.predicted.used,
                action,
                math.max(
                    __get(__L1.predicted.used, action),
                    __get(authoritative.used, action)
                )
            )
        end
    end
    __L1.predictStep = function(self, dt)
        local ____t_375 = __t
        local ____t_374 = __t
        local ____temp_373 = not __t(__L1.world) or __L1.role ~= "guest"
        __O[3156] = ____temp_373
        if ____t_375(if ____t_374(____temp_373) then __O[3156] else __L1.world.stage ~= "playing") then
            return
        end
        if not __t(__L1.predicted) then
            __L1.predicted = __L1:clonePlayer(__get(__L1.world.players, 1))
        end
        if __le(__L1.predicted.hp, 0) then
            return
        end
        local command = __L1:getLocalInput()
        __L1:advanceMotion(__L1.predicted, command, dt)
        if __gt(command.paper, __L1.predicted.used.paper) then
            __L1.predicted.used.paper = command.paper
            if __le(__L1.predicted.paperCD, 0) then
                __L1.predicted.paperCD = 0.23
                __L1.predicted.attack = 0.24
                __L1.predicted.attackKind = "paper"
            end
        end
        if __gt(command.fart, __L1.predicted.used.fart) then
            __L1.predicted.used.fart = command.fart
            if __t(__le(__L1.predicted.fartCD, 0) and __ge(__L1.predicted.gas, 20)) then
                __L1.predicted.fartCD = 0.85
                local ____L1_predicted_376, ____gas_377 = __L1.predicted, "gas"
                ____L1_predicted_376[____gas_377] = ____L1_predicted_376[____gas_377] - 20
                __L1.predicted.attack = 0.32
                __L1.predicted.attackKind = "fart"
            end
        end
        if __t(__L1.predictionTarget) then
            local correction = __L1.predictionTarget
            local t = correction.player
            __L1:advanceMotion(
                t,
                __assign({}, command, {jumpPress = t.used.jumpPress, dash = t.used.dash}),
                dt
            )
            local authority = __get(__L1.world.players, 1)
            local ____temp_380 = if __t(command.right) then 1 else 0 - if __t(command.left) then 1 else 0
            local ____t_379 = __t
            local ____TS__Number_result_378 = __TS__Number(authority.moveX)
            __O[3157] = ____TS__Number_result_378
            local pendingMove = ____temp_380 ~= if ____t_379(____TS__Number_result_378) then __O[3157] else 0
            local pendingJump = __gt(command.jumpPress, authority.used.jumpPress)
            local pendingDash = __gt(command.dash, authority.used.dash)
            local blend = 1 - math.exp(-8 * dt)
            local step = 80 * dt
            if __t(not __t(pendingMove) and not __t(pendingDash)) then
                local ____L1_predicted_381, ____x_382 = __L1.predicted, "x"
                ____L1_predicted_381[____x_382] = ____L1_predicted_381[____x_382] + __L1:clamp((t.x - __L1.predicted.x) * blend, -step, step)
            end
            if __t(not __t(pendingJump) and not __t(pendingDash)) then
                local ____L1_predicted_383, ____y_384 = __L1.predicted, "y"
                ____L1_predicted_383[____y_384] = ____L1_predicted_383[____y_384] + __L1:clamp((t.y - __L1.predicted.y) * blend, -step, step)
                if __t(math.abs(t.y - __L1.predicted.y) < 2 and math.abs(__L1.predicted.vy) < 30) then
                    __L1.predicted.ground = t.ground
                    __L1.predicted.vy = t.vy
                end
            end
        end
    end
    __L1.visiblePlayer = function(self, p, index, dt)
        if __L1.role ~= "guest" then
            return p
        end
        local ____t_389 = __t
        local ____t_388 = __t
        local ____t_386 = __t
        local ____temp_385 = index == 1
        __O[3158] = ____temp_385
        local ____temp_387 = if ____t_386(____temp_385) then __L1.predicted else __O[3158]
        __O[3159] = ____temp_387
        if ____t_389(if ____t_388(____temp_387) then __L1.world.stage == "playing" else __O[3159]) then
            return __assign({}, p, __L1.predicted)
        end
        local age = __L1:clamp(
            (window.performance:now() - __L1.lastStateAt) / 1000,
            0,
            0.18
        )
        local x = __L1:clamp(p.x + p.vx * age, 30, 930)
        local y = if __t(p.ground) then p.y else __L1:clamp(p.y + p.vy * age, 70, __L1.FLOOR)
        local ____t_391 = __t
        local ____get_result_390 = __get(__L1.smoothedPlayers, index)
        __O[3160] = ____get_result_390
        local old = if ____t_391(____get_result_390) then __O[3160] else {x = x, y = y}
        local amount = 1 - math.exp(-18 * dt)
        if __hypot(x - old.x, y - old.y) > 180 then
            old.x = x
            old.y = y
        else
            old.x = old.x + (x - old.x) * amount
            old.y = old.y + (y - old.y) * amount
        end
        __set(__L1.smoothedPlayers, index, old)
        return __assign({}, p, {x = old.x, y = old.y})
    end
    __L1.windup = function(self)
        local b = __L1.world.boss
        b.phase = if b.hp / b.max > 0.66 then 1 else if b.hp / b.max > 0.33 then 2 else 3
        local patterns = if __L1.world.wave == 0 then __arrL({"fan", "ring", "dash", "rain"}, 4) else if __L1.world.wave == 1 then __arrL({"ring", "fan", "teleport", "rain"}, 4) else __arrL({"fan", "rain", "dash", "ring"}, 4)
        local ____get_396 = __get
        local ____mod_395 = __mod
        local ____b_392, ____pattern_393 = b, "pattern"
        local ____b_pattern_394 = ____b_392[____pattern_393]
        ____b_392[____pattern_393] = ____b_pattern_394 + 1
        b.kind = ____get_396(
            patterns,
            ____mod_395(
                ____b_pattern_394,
                __len(patterns)
            )
        )
        local living = __call(
            __L1.world.players,
            "filter",
            function(____, p) return __gt(p.hp, 0) end
        )
        local ____t_398 = __t
        local ____get_result_397 = __get(
            living,
            __mod(
                b.pattern - 1,
                __len(living)
            )
        )
        __O[3161] = ____get_result_397
        local target = if ____t_398(____get_result_397) then __O[3161] else __get(__L1.world.players, 0)
        b.targetX = target.x
        b.targetY = target.y - 30
        local ____t_400 = __t
        local ____TS__MathSign_result_399 = __TS__MathSign(target.x - b.x)
        __O[3162] = ____TS__MathSign_result_399
        b.dir = if ____t_400(____TS__MathSign_result_399) then __O[3162] else -1
        b.state = "windup"
        b.timer = 1 - (b.phase - 1) * 0.12
        b.duration = b.timer
        if b.kind == "teleport" then
            b.exitX = if __lt(target.x, 480) then 780 else 180
        end
    end
    __L1.execute = function(self)
        local b = __L1.world.boss
        if b.kind == "dash" then
            b.state = "dash"
            b.timer = 0.48
            return
        end
        if b.kind == "teleport" then
            b.x = b.exitX
            b.state = "recover"
            b.timer = 1.05
            __L1:fx(b.x, b.y - 20, "#d3dfb5", 12)
            return
        end
        if b.kind == "fan" then
            local count = 3 + b.phase * 2
            local aim = math.atan2(b.targetY - (b.y - 42), b.targetX - b.x)
            do
                local i = 0
                while i < count do
                    local a = aim + (i - (count - 1) / 2) * 0.14
                    local ____call_405 = __call
                    local ____L1_world_shots_404 = __L1.world.shots
                    local ____L1_world_401, ____nextShot_402 = __L1.world, "nextShot"
                    local ____L1_world_nextShot_403 = ____L1_world_401[____nextShot_402]
                    ____L1_world_401[____nextShot_402] = ____L1_world_nextShot_403 + 1
                    ____call_405(
                        ____L1_world_shots_404,
                        "push",
                        {
                            id = ____L1_world_nextShot_403,
                            owner = "enemy",
                            x = b.x,
                            y = b.y - 42,
                            vx = math.cos(a) * ((210 + b.phase * 15) * 1.18),
                            vy = math.sin(a) * ((210 + b.phase * 15) * 1.18),
                            life = 4,
                            r = 9,
                            damage = 18,
                            type = if __L1.world.wave == 2 then "slime" else if __L1.world.wave == 1 then "word" else "ink"
                        }
                    )
                    i = i + 1
                end
            end
        end
        if b.kind == "rain" then
            do
                local i = -2
                while i <= 2 do
                    __call(
                        __L1.world.hazards,
                        "push",
                        {
                            x = __L1:clamp(b.targetX + i * 100, 55, 905),
                            r = 43,
                            delay = 0.85 + math.abs(i) * 0.1,
                            life = 0.5,
                            kind = "column",
                            damage = 23
                        }
                    )
                    i = i + 1
                end
            end
        end
        if b.kind == "ring" then
            __call(__L1.world.hazards, "push", {
                x = b.x,
                r = 0,
                delay = 0.6,
                life = 3,
                kind = "ring",
                damage = 21,
                speed = (235 + b.phase * 20) * 1.18
            })
        end
        b.state = "fire"
        b.timer = 0.32
    end
    __L1.simulate = function(self, dt)
        local w = __L1.world
        if not __t(w) then
            return
        end
        w.time = __add(w.time, dt)
        w.tick = w.tick + 1
        for ____, f in __iterar((w.fx)) do
            f.life = f.life - dt
            f.x = f.x + f.vx * dt
            f.y = f.y + f.vy * dt
            f.vy = f.vy + 180 * dt
        end
        w.fx = __call(
            w.fx,
            "filter",
            function(____, f) return __gt(f.life, 0) end
        )
        if w.stage == "countdown" then
            if __ge(
                __L1:serverNow(),
                w.startAt
            ) then
                w.stage = "playing"
                __L1:resetInputs()
                for ____, p in __iterar((w.players)) do
                    local command = if __t(p.id) then __L1.remoteInput else __L1:getLocalInput()
                    for ____, action in __iterar((__arrL({"paper", "fart", "dash", "jumpPress"}, 4))) do
                        local ____set_409 = __set
                        local ____p_used_408 = p.used
                        local ____t_407 = __t
                        local ____get_result_406 = __get(command, action)
                        __O[3163] = ____get_result_406
                        ____set_409(____p_used_408, action, if ____t_407(____get_result_406) then __O[3163] else 0)
                    end
                    p.lastJump = not not __t(command.jump)
                end
            end
            return
        end
        if __t(w.stage == "victory" or w.stage == "defeat") then
            return
        end
        if w.stage == "intermission" then
            w.stageTimer = w.stageTimer - dt
            if __le(w.stageTimer, 0) then
                w.wave = w.wave + 1
                w.boss = __L1:boss(w.wave)
                w.stage = "playing"
                w.shots = __arrL({}, 0)
                w.hazards = __arrL({}, 0)
                __call(
                    w.players,
                    "forEach",
                    function(____, p)
                        p.hp = p.max
                        p.gas = 100
                        p.inv = 2
                        p.down = 0
                        p.x = if __t(p.id) then 350 else 210
                        p.y = __L1.FLOOR
                        local ____p_410 = p
                        p.vy = 0
                        ____p_410.vx = 0
                    end
                )
            end
            return
        end
        local ____local = __L1:getLocalInput()
        local remote = if window.performance:now() - __L1.inputAt < 5000 then __L1.remoteInput else __assign({}, __L1.remoteInput, {left = false, right = false, jump = false})
        __L1:move(
            __get(w.players, 0),
            ____local,
            dt
        )
        __L1:move(
            __get(w.players, 1),
            remote,
            dt
        )
        if __t(__call(
            w.players,
            "every",
            function(____, p) return __le(p.hp, 0) end
        )) then
            w.stage = "defeat"
            w.shots = __arrL({}, 0)
            w.hazards = __arrL({}, 0)
            return
        end
        local b = w.boss
        b.hit = math.max(0, b.hit - dt)
        b.timer = b.timer - dt
        if __t(b.state == "windup" and __le(b.timer, 0)) then
            __L1:execute()
        elseif b.state == "dash" then
            b.x = __L1:clamp(b.x + b.dir * 732 * dt, 70, 890)
            if __le(b.timer, 0) then
                b.state = "recover"
                b.timer = 1.12 - (b.phase - 1) * 0.1
            end
        elseif __t(b.state == "fire" and __le(b.timer, 0)) then
            b.state = "recover"
            b.timer = 1.12 - (b.phase - 1) * 0.1
        elseif __t(b.state == "recover" and __le(b.timer, 0)) then
            __L1:windup()
        end
        for ____, p in __iterar((w.players)) do
            if __t(math.abs(p.x - b.x) < 42 and math.abs(p.y - b.y) < 65) then
                __L1:damagePlayer(p, if b.state == "dash" then 31 else 13, b.x)
            end
        end
        for ____, s in __iterar((w.shots)) do
            s.life = s.life - dt
            s.x = s.x + s.vx * dt
            s.y = s.y + s.vy * dt
            if s.owner == "enemy" then
                for ____, p in __iterar((w.players)) do
                    if __t(__gt(p.hp, 0) and __lt(
                        __hypot(s.x - p.x, s.y - (p.y - 30)),
                        s.r + 18
                    )) then
                        __L1:damagePlayer(p, s.damage, s.x)
                        s.life = 0
                        break
                    end
                end
            elseif __t(math.abs(s.x - b.x) < 38 and math.abs(s.y - (b.y - 35)) < 48) then
                __L1:damageBoss(s.damage, s.owner)
                s.life = 0
            end
        end
        w.shots = __call(
            __call(
                w.shots,
                "filter",
                function(____, s)
                    local ____t_416 = __t
                    local ____t_414 = __t
                    local ____t_412 = __t
                    local ____temp_411 = __gt(s.life, 0) and __gt(s.x, -30)
                    __O[3164] = ____temp_411
                    local ____temp_413 = if ____t_412(____temp_411) then __lt(s.x, 990) else __O[3164]
                    __O[3165] = ____temp_413
                    local ____temp_415 = if ____t_414(____temp_413) then __gt(s.y, -30) else __O[3165]
                    __O[3166] = ____temp_415
                    return if ____t_416(____temp_415) then __lt(s.y, 570) else __O[3166]
                end
            ),
            "slice",
            -56
        )
        for ____, h in __iterar((w.hazards)) do
            h.delay = h.delay - dt
            if __gt(h.delay, 0) then
                continue
            end
            h.life = h.life - dt
            if h.kind == "ring" then
                h.r = h.r + h.speed * dt
            end
            for ____, p in __iterar((w.players)) do
                if h.kind == "ring" then
                    if __t(math.abs(math.abs(p.x - h.x) - h.r) < 24 and __gt(p.y, __L1.FLOOR - 58)) then
                        __L1:damagePlayer(p, h.damage, h.x)
                    end
                elseif __lt(
                    math.abs(p.x - h.x),
                    h.r
                ) then
                    __L1:damagePlayer(p, h.damage, h.x)
                end
            end
        end
        w.hazards = __call(
            __call(
                w.hazards,
                "filter",
                function(____, h) return __gt(h.life, 0) end
            ),
            "slice",
            -20
        )
        if __le(b.hp, 0) then
            w.shots = __arrL({}, 0)
            w.hazards = __arrL({}, 0)
            __L1:fx(b.x, b.y - 40, "#ffe9a8", 24)
            if w.wave == 2 then
                w.stage = "victory"
            else
                w.stage = "intermission"
                w.stageTimer = 3.2
            end
        end
    end
    __L1.text = function(self, c, str, x, y, size, color, align)
        if size == nil then
            size = 14
        end
        if color == nil then
            color = "#fff0ca"
        end
        if align == nil then
            align = "center"
        end
        c.font = ("bold " .. tostring(size)) .. "px monospace"
        c.textAlign = align
        c.textBaseline = "middle"
        c.fillStyle = "#152d26"
        c:fillText(str, x + 2, y + 2)
        c.fillStyle = color
        c:fillText(str, x, y)
    end
    __L1.bar = function(self, c, x, y, w, h, fraction, fill, bg)
        if bg == nil then
            bg = "#243b33"
        end
        c.fillStyle = "#172b24"
        c:fillRect(x - 2, y - 2, w + 4, h + 4)
        c.fillStyle = bg
        c:fillRect(x, y, w, h)
        c.fillStyle = fill
        c:fillRect(
            x,
            y,
            w * __L1:clamp(fraction, 0, 1),
            h
        )
    end
    __L1.draw = function(self, renderDt)
        if renderDt == nil then
            renderDt = __L1.STEP
        end
        if not __t(__L1:arenaVisible()) then
            return
        end
        local c = __L1["$"](__L1, "coopCanvas"):getContext("2d")
        c.imageSmoothingEnabled = false
        c:clearRect(0, 0, 960, 540)
        if not __t(__L1.world) then
            c.fillStyle = "#17352d"
            c:fillRect(0, 0, 960, 540)
            __L1:text(
                c,
                "PREPARANDO A ARENA…",
                480,
                270,
                22
            )
            return
        end
        local w = __L1.world
        local b = w.boss
        local ____t_419 = __t
        local ____opt_417 = window.Art
        if ____opt_417 ~= nil then
            ____opt_417 = ____opt_417.drawArena
        end
        if ____t_419(____opt_417) then
            window.Art:drawArena(
                c,
                b.type,
                0,
                w.time,
                480
            )
        else
            c.fillStyle = "#6ba1b2"
            c:fillRect(0, 0, 960, 440)
            c.fillStyle = "#7d6849"
            c:fillRect(0, 440, 960, 100)
        end
        for ____, ____value in __iterar((__L1.platforms)) do
            local x = ____value[1]
            local y = ____value[2]
            local width = ____value[3]
            local ____t_422 = __t
            local ____opt_420 = window.Art
            if ____opt_420 ~= nil then
                ____opt_420 = ____opt_420.drawPlatform
            end
            if ____t_422(____opt_420) then
                window.Art:drawPlatform(
                    c,
                    x,
                    y,
                    width,
                    if w.wave == 0 then "doodles" else if w.wave == 1 then "words" else "court"
                )
            end
        end
        for ____, h in __iterar((w.hazards)) do
            if h.kind == "ring" then
                c:save()
                c.strokeStyle = if __gt(h.delay, 0) then "#f4c084" else "#f6e3a0"
                c.lineWidth = 6
                c.globalAlpha = if __gt(h.delay, 0) then 0.45 else 0.9
                c:beginPath()
                c:ellipse(
                    h.x,
                    __L1.FLOOR - 5,
                    math.max(8, h.r),
                    math.max(5, h.r * 0.08),
                    0,
                    0,
                    math.pi * 2
                )
                c:stroke()
                c:restore()
            else
                c:save()
                c.fillStyle = if __gt(h.delay, 0) then "#efb77866" else "#d4e58eaa"
                c:fillRect(h.x - h.r, if __gt(h.delay, 0) then __L1.FLOOR - 8 else 95, h.r * 2, if __gt(h.delay, 0) then 8 else __L1.FLOOR - 95)
                if __gt(h.delay, 0) then
                    __L1:text(
                        c,
                        "!",
                        h.x,
                        __L1.FLOOR - 28,
                        24,
                        "#ffe5a0"
                    )
                end
                c:restore()
            end
        end
        if __gt(b.hp, 0) then
            if b.state == "windup" then
                c:save()
                c.globalAlpha = 0.5
                c.strokeStyle = "#f3b17e"
                c.lineWidth = 3
                c:setLineDash(__arrL({8, 6}, 2))
                c:beginPath()
                c:moveTo(b.x, b.y - 35)
                c:lineTo(if b.kind == "teleport" then b.exitX else b.targetX, if __t(b.kind == "dash" or b.kind == "teleport") then __L1.FLOOR - 8 else b.targetY)
                c:stroke()
                c:restore()
                __L1:text(
                    c,
                    if b.kind == "ring" then "PULEM A ONDA!" else if b.kind == "rain" then "SAIAM DAS MARCAS!" else if b.kind == "teleport" then "OLHEM A SAÍDA!" else if b.kind == "dash" then "DASH PARA DESVIAR!" else "ATAQUE CARREGANDO!",
                    b.x,
                    b.y - 112,
                    13,
                    "#ffdda4"
                )
            end
            local ____t_425 = __t
            local ____opt_423 = window.Art
            if ____opt_423 ~= nil then
                ____opt_423 = ____opt_423.drawCharacter
            end
            if ____t_425(____opt_423) then
                window.Art:drawCharacter(
                    c,
                    b.type,
                    b.x,
                    b.y,
                    {
                        facing = if __lt(
                            __get(w.players, 0).x,
                            b.x
                        ) then -1 else 1,
                        frame = w.time,
                        scale = 1.25,
                        moving = b.state == "dash",
                        dash = b.state == "dash",
                        speed = if b.state == "dash" then 620 else 0,
                        attack = b.state == "windup" or b.state == "fire",
                        attackType = if b.type == "nikolas" then "slime" else if b.type == "marco" then "doodle" else "word",
                        attackProgress = __L1:clamp(1 - b.timer / b.duration, 0, 1),
                        hit = __gt(b.hit, 0),
                        noseRub = b.type == "nikolas"
                    }
                )
            end
        end
        for ____, s in __iterar((w.shots)) do
            c:save()
            if s.owner ~= "enemy" then
                c:translate(s.x, s.y)
                c:rotate(w.time * 8)
                c.fillStyle = if s.owner == 0 then "#fff0c5" else "#b7f2e7"
                c:fillRect(-6, -6, 12, 12)
                c.fillStyle = "#7a9080"
                c:fillRect(-3, -3, 5, 2)
            else
                c.fillStyle = if s.type == "slime" then "#c6df7d" else if s.type == "word" then "#e9bfd8" else "#cbace0"
                c:beginPath()
                c:arc(
                    s.x,
                    s.y,
                    s.r,
                    0,
                    math.pi * 2
                )
                __call(c, "fill")
                if s.type == "word" then
                    __L1:text(
                        c,
                        "AR!",
                        s.x,
                        s.y,
                        11,
                        "#fff3db"
                    )
                end
            end
            c:restore()
        end
        __call(
            w.players,
            "forEach",
            function(____, source, index)
                local p = __L1:visiblePlayer(source, index, renderDt)
                local x = p.x
                local y = p.y
                if __le(p.hp, 0) then
                    c:save()
                    c.globalAlpha = 0.6
                    local ____t_428 = __t
                    local ____opt_426 = window.Art
                    if ____opt_426 ~= nil then
                        ____opt_426 = ____opt_426.drawCharacter
                    end
                    if ____t_428(____opt_426) then
                        window.Art:drawCharacter(
                            c,
                            "daroca",
                            x,
                            y,
                            {
                                facing = p.facing,
                                frame = w.time,
                                scale = 0.85,
                                pose = "hurt",
                                recoil = 1
                            }
                        )
                    end
                    __L1:text(
                        c,
                        __add(
                            __add(
                                "VOLTA EM ",
                                math.max(
                                    1,
                                    math.ceil(p.down)
                                )
                            ),
                            "s"
                        ),
                        x,
                        y - 86,
                        12,
                        "#efc1aa"
                    )
                    c:restore()
                else
                    c:save()
                    local ____t_431 = __t
                    local ____t_430 = __t
                    local ____gt_result_429 = __gt(p.inv, 0)
                    __O[3167] = ____gt_result_429
                    __D[1] = if ____t_431(if ____t_430(____gt_result_429) then __mod(
                        math.floor(w.time * 14),
                        2
                    ) else __O[3167]) then
                        c.globalAlpha = 0.6
                    end
                    local ____t_434 = __t
                    local ____opt_432 = window.Art
                    if ____opt_432 ~= nil then
                        ____opt_432 = ____opt_432.drawCharacter
                    end
                    if ____t_434(____opt_432) then
                        local ____self_449 = window.Art
                        local ____self_449_drawCharacter_450 = ____self_449.drawCharacter
                        local ____x_447 = x
                        local ____y_448 = y
                        local ____p_facing_437 = p.facing
                        local ____p_anim_438 = p.anim
                        local ____temp_439 = math.abs(p.vx) > 8
                        local ____math_abs_result_440 = math.abs(p.vx)
                        local ____p_ground_441 = p.ground
                        local ____p_vy_442 = p.vy
                        local ____gt_result_443 = __gt(p.attack, 0)
                        local ____p_attackKind_444 = p.attackKind
                        local ____temp_445 = __L1:clamp(1 - p.attack / 0.24, 0, 1)
                        local ____gt_result_446 = __gt(p.dashTime, 0)
                        local ____t_436 = __t
                        local ____temp_435 = not __t(p.ground) and __gt(p.gas, 0)
                        __O[3168] = ____temp_435
                        ____self_449_drawCharacter_450(
                            ____self_449,
                            c,
                            "daroca",
                            ____x_447,
                            ____y_448,
                            {
                                facing = ____p_facing_437,
                                frame = ____p_anim_438,
                                scale = 1,
                                moving = ____temp_439,
                                speed = ____math_abs_result_440,
                                grounded = ____p_ground_441,
                                vy = ____p_vy_442,
                                attack = ____gt_result_443,
                                attackType = ____p_attackKind_444,
                                attackProgress = ____temp_445,
                                dash = ____gt_result_446,
                                flight = if ____t_436(____temp_435) then math.abs(p.vy) < 240 else __O[3168]
                            }
                        )
                    end
                    if __t(index) then
                        c.fillStyle = "#72c5cb"
                        c:fillRect(x - 15, y - 55, 28, 3)
                    end
                    c:restore()
                end
                __L1:text(
                    c,
                    if __t(index) then "PARCEIRO · 2" else "DA ROÇA · 1",
                    x,
                    y - 88,
                    11,
                    if __t(index) then "#b9f4ed" else "#ffe1a2"
                )
                __L1:bar(
                    c,
                    x - 32,
                    y - 76,
                    64,
                    5,
                    p.hp / p.max,
                    if __t(index) then "#89d8cf" else "#efb586"
                )
            end
        )
        for ____, f in __iterar((if __t(w.fx) then w.fx else __arrL({}, 0))) do
            c.globalAlpha = __L1:clamp(f.life * 2, 0, 1)
            c.fillStyle = f.c
            c:fillRect(f.x, f.y, 4, 4)
        end
        c.globalAlpha = 1
        c.fillStyle = "#102920e8"
        c:fillRect(205, 15, 550, 57)
        __L1:text(
            c,
            __get(__L1.bossNames, b.type),
            480,
            31,
            13,
            "#ffe2a9"
        )
        __L1:bar(
            c,
            226,
            48,
            508,
            9,
            b.hp / b.max,
            "#d78c78"
        )
        __L1:text(
            c,
            __add(
                __add(
                    math.ceil(b.hp),
                    " / "
                ),
                b.max
            ),
            480,
            63,
            10,
            "#f0dfbd"
        )
        if w.stage == "countdown" then
            local count = math.max(
                1,
                math.ceil((w.startAt - __L1:serverNow()) / 1000)
            )
            c.fillStyle = "#183c2ab3"
            c:fillRect(344, 156, 272, 166)
            __L1:text(
                c,
                "PREPAREM O PAPEL!",
                480,
                185,
                15,
                "#ffe2a9"
            )
            __L1:text(
                c,
                tostring(math.min(3, count)),
                480,
                255,
                76,
                "#fff0c2"
            )
        end
        if w.stage == "intermission" then
            c.fillStyle = "#10271abf"
            c:fillRect(190, 190, 580, 110)
            __L1:text(
                c,
                "CHEFÃO DERROTADO EM DUPLA!",
                480,
                224,
                22,
                "#e4edac"
            )
            __L1:text(
                c,
                "Respirem. A próxima resenha vem aí…",
                480,
                264,
                15
            )
        end
        if __t(w.stage == "victory" or w.stage == "defeat") then
            c.fillStyle = "#10271cce"
            c:fillRect(135, 170, 690, 155)
            __L1:text(
                c,
                if w.stage == "victory" then "A DUPLA DOMINOU A RESENHA!" else "A DUPLA CAIU JUNTO!",
                480,
                212,
                24,
                if w.stage == "victory" then "#e4eca8" else "#f0b39c"
            )
            __L1:text(
                c,
                if w.stage == "victory" then "Três chefões. Dois parceiros. Um papel de respeito." else "Cheguem perto do parceiro caído para ele voltar mais rápido.",
                480,
                253,
                13
            )
            __L1:text(
                c,
                if __L1.role == "host" then "Toque em JOGAR NOVAMENTE para outra rodada." else "O amigo que criou a dupla pode reiniciar a rodada.",
                480,
                288,
                13
            )
        end
        __L1["$"](__L1, "coopWaveLabel").textContent = __add(
            __add("CHEFÃO ", w.wave + 1),
            " / 3"
        )
        local ____L1__24_result_454 = __L1["$"](__L1, "coopRestartBtn")
        local ____t_453 = __t
        local ____t_452 = __t
        local ____temp_451 = __L1.role == "host"
        __O[3169] = ____temp_451
        ____L1__24_result_454.hidden = not ____t_453(if ____t_452(____temp_451) then __call(
            __arrL({"victory", "defeat"}, 2),
            "includes",
            w.stage
        ) else __O[3169])
        local stale = __L1.role == "guest" and window.performance:now() - __L1.lastStateAt > 2500
        __L1["$"](__L1, "coopGameNotice").textContent = if __t(stale) then "Aguardando o aparelho que criou a dupla…" else if w.stage == "playing" then "Chegue perto do parceiro caído para ele voltar mais rápido." else if w.stage == "intermission" then "Vida e gás renovados para a próxima luta." else "Esta rodada não altera o progresso da campanha."
    end
    __L1.loop = function(self, now)
        local dt = if __t(__L1.lastFrame) then __L1:clamp((now - __L1.lastFrame) / 1000, 0, 0.1) else 0
        __L1.lastFrame = now
        local ____t_457 = __t
        local ____t_456 = __t
        local ____temp_455 = __L1:arenaVisible()
        __O[3170] = ____temp_455
        if ____t_457(if ____t_456(____temp_455) then __L1.world else __O[3170]) then
            __L1.accumulator = math.min(__L1.accumulator + dt, __L1.STEP * 6)
            while __L1.accumulator >= __L1.STEP do
                local ____t_460 = __t
                local ____t_459 = __t
                local ____temp_458 = __L1.role == "host"
                __O[3171] = ____temp_458
                if ____t_460(if ____t_459(____temp_458) then __L1:isConnected() else __O[3171]) then
                    __L1:simulate(__L1.STEP)
                elseif __L1.role == "guest" then
                    __L1:predictStep(__L1.STEP)
                end
                __L1.accumulator = __L1.accumulator - __L1.STEP
            end
            if __t(if __t(__L1.credentials) then now - __L1.sendAt >= 1000 / 30 else __L1.credentials) then
                __L1.sendAt = now
                if __L1.role == "host" then
                    local ____opt_463 = __L1.net
                    if ____opt_463 ~= nil then
                        ____opt_463 = ____opt_463.sendState
                    end
                    if ____opt_463 ~= nil then
                        ____opt_463(
                            ____opt_463,
                            __L1:snapshot()
                        )
                    end
                else
                    local ____opt_467 = __L1.net
                    if ____opt_467 ~= nil then
                        ____opt_467 = ____opt_467.sendInput
                    end
                    if ____opt_467 ~= nil then
                        ____opt_467(
                            ____opt_467,
                            __L1:wireInput()
                        )
                    end
                end
            end
            __L1:draw(dt)
        end
        window:requestAnimationFrame(__L1.loop)
    end
    local ____ = "use strict"
    __L1.shell = window.document:getElementById("gameShell")
    __L1.menu = window.document:querySelector("#startScreen .start-menu")
    if __t(not __t(__L1.shell) or not __t(__L1.menu)) then
        return
    end
    __L1.PROTOCOL = 3
    __L1.FLOOR = 440
    __L1.WIDTH = 960
    __L1.STEP = 1 / 60
    __L1.OFFICIAL = "https://da-roca-adventure-jogo.davims99.chatgpt.site"
    __L1.SESSION = "daroca-coop-room-v2"
    __L1.bossTypes = __arrL({"marco", "menezes", "nikolas"}, 3)
    __L1.bossNames = __ord({marco = "MARCO · O CADERNO EM DUPLA", menezes = "MENEZES · PROVOCAÇÃO EM DOBRO", nikolas = "NIKOLAS · A ÚLTIMA FATIA"}, "marco,menezes,nikolas")
    __L1.clamp = function(____, v, a, b) return math.max(
        a,
        math.min(b, v)
    ) end
    __L1.finite = function(____, v) return __isFiniteN(v) end
    __L1.counter = function(____, v)
        local ____t_472 = __t
        local ____t_470 = __t
        local ____isSafeInteger_result_469 = __isSafeInteger(v)
        __O[3072] = ____isSafeInteger_result_469
        local ____temp_471 = if ____t_470(____isSafeInteger_result_469) then __ge(v, 0) else __O[3072]
        __O[3073] = ____temp_471
        return if ____t_472(____temp_471) then __le(v, 2147483647) else __O[3073]
    end
    __L1.blankInput = function() return {
        left = false,
        right = false,
        jump = false,
        jumpPress = 0,
        paper = 0,
        fart = 0,
        dash = 0,
        seq = 0
    } end
    __L1.opened = false
    __L1.resumeCampaign = false
    __L1.role = nil
    __L1.currentRole = nil
    __L1.world = nil
    __L1.targetWorld = nil
    __L1.room = nil
    __L1.credentials = nil
    __L1.net = nil
    __L1.busy = false
    __L1.ready = false
    __L1.restoring = false
    __L1.generation = 0
    __L1.pollTimer = 0
    __L1.syncing = false
    __L1.urgent = false
    __L1.lastRequestAt = 0
    __L1.failures = 0
    __L1.inputSeq = 0
    __L1.stateSeq = 0
    __L1.serverOffset = 0
    __L1.rttMs = 0
    __L1.lastStateAt = 0
    __L1.inputAt = 0
    __L1.lastFrame = 0
    __L1.sendAt = 0
    __L1.accumulator = 0
    __L1.input = __L1:blankInput()
    __L1.remoteInput = __L1:blankInput()
    __L1.remoteSequence = -1
    __L1.predicted = nil
    __L1.predictionTarget = nil
    __L1.smoothedPlayers = __arrL({}, 0)
    __L1.receivedMatch = nil
    __L1.readyRevision = 0
    __L1.syncedReady = -1
    __L1.activePointers = __TS__New(Map)
    __L1.pressedKeys = __TS__New(Set)
    __L1.joystickPointer = nil
    __L1.joyX = 0
    __L1.joyCenter = nil
    __L1["$"] = function(____, id) return window.document:getElementById(id) end
    __L1.serverNow = function() return window.Date:now() + __L1.serverOffset end
    __L1.localSlot = function() return if __L1.role == "host" then 0 else 1 end
    __L1.clean = function(____, value, max)
        if max == nil then
            max = 20
        end
        return __call(
            __call(
                __re_replace(
                    tostring(if __t(value) then value else ""),
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
    __L1.button = window.document:createElement("button")
    __L1.button.id = "coopOpenBtn"
    __L1.button.type = "button"
    __L1.button.className = "menu-coop-button"
    __L1.button.innerHTML = "<svg viewBox=\"0 0 24 24\" width=\"20\" height=\"20\" aria-hidden=\"true\" shape-rendering=\"crispEdges\"><path fill=\"currentColor\" d=\"M4 2h5v6H4zm11 0h5v6h-5zM1 10h11v8H9v6H4v-6H1zm12 0h10v8h-3v6h-5v-6h-2z\"/></svg><span>DUPLA ONLINE</span>"
    __L1.menu:append(__L1.button)
    __L1.defaults = __ord(
        {
            left = __arrL({"KeyA", "ArrowLeft"}, 2),
            right = __arrL({"KeyD", "ArrowRight"}, 2),
            jump = __arrL({"Space", "KeyW", "ArrowUp"}, 3),
            paper = __arrL({"KeyJ"}, 1),
            fart = __arrL({"KeyK"}, 1),
            dash = __arrL({"KeyL", "ShiftLeft", "ShiftRight"}, 3)
        },
        "left,right,jump,paper,fart,dash"
    )
    window.document:addEventListener(
        "keydown",
        function(____, e)
            if not __t(__L1.opened) then
                return
            end
            if e.code == "Escape" then
                e:preventDefault()
                e:stopImmediatePropagation()
                __L1:close()
                return
            end
            local ____t_477 = __t
            local ____t_474 = __t
            local ____temp_473 = not __t(__L1:arenaVisible())
            __O[3144] = ____temp_473
            local ____this_476
            ____this_476 = e.target
            local ____opt_475 = ____this_476.closest
            if ____opt_475 ~= nil then
                ____opt_475 = ____opt_475(____this_476, "textarea,input")
            end
            if ____t_477(if ____t_474(____temp_473) then __O[3144] else ____opt_475) then
                return
            end
            local actions = __call(
                __keys(__L1.defaults),
                "filter",
                function(____, a) return __L1:keyMatches(a, e.code) end
            )
            if not __t(__len(actions)) then
                return
            end
            e:preventDefault()
            e:stopImmediatePropagation()
            if __t(e["repeat"]) then
                return
            end
            local wasJump = __L1.input.jump
            __call(__L1.pressedKeys, "add", e.code)
            __L1:readHeld()
            if __t(if __t(__L1.input.jump) then not __t(wasJump) else __L1.input.jump) then
                local ____L1_input_478, ____jumpPress_479 = __L1.input, "jumpPress"
                ____L1_input_478[____jumpPress_479] = ____L1_input_478[____jumpPress_479] + 1
            end
            for ____, action in __iterar((actions)) do
                if __t(__call(
                    __arrL({"paper", "fart", "dash"}, 3),
                    "includes",
                    action
                )) then
                    __L1:pulse(action)
                end
            end
            __L1:changedInput()
        end,
        true
    )
    window.document:addEventListener(
        "keyup",
        function(____, e)
            local ____t_482 = __t
            local ____t_481 = __t
            local ____temp_480 = not __t(__L1.opened) or not __t(__L1:arenaVisible())
            __O[3145] = ____temp_480
            if ____t_482(if ____t_481(____temp_480) then __O[3145] else not __t(__call(__L1.pressedKeys, "has", e.code))) then
                return
            end
            e:preventDefault()
            e:stopImmediatePropagation()
            __call(__L1.pressedKeys, "delete", e.code)
            __L1:readHeld()
            __L1:changedInput()
        end,
        true
    )
    window:addEventListener("blur", __L1.resetInputs)
    window:addEventListener(
        "pagehide",
        function()
            __L1:resetInputs()
        end
    )
    window.document:addEventListener(
        "visibilitychange",
        function()
            if __t(window.document.hidden) then
                __L1:resetInputs()
            end
        end
    )
    window:addEventListener("orientationchange", __L1.resetInputs)
    window:addEventListener(
        "pointerup",
        function(____, e) return __L1:releasePointer(e.pointerId) end,
        true
    )
    window:addEventListener(
        "pointercancel",
        function(____, e) return __L1:releasePointer(e.pointerId) end,
        true
    )
    __L1.platforms = __arrL(
        {
            __arrL({190, 350, 125}, 3),
            __arrL({430, 290, 120}, 3),
            __arrL({665, 350, 120}, 3)
        },
        3
    )
    window:requestAnimationFrame(__L1.loop)
    __L1.button:addEventListener("click", __L1.open)
    __L1.pause = window.document:querySelector("#pauseScreen .game-modal")
    if __t(__L1.pause) then
        local p = window.document:createElement("button")
        p.type = "button"
        p.className = "text-button"
        p.id = "pauseCoopBtn"
        p.textContent = "Dupla online · chefões em equipe"
        p:addEventListener("click", __L1.open)
        __L1.pause:append(p)
    end
    window.CoopArena = __ord(
        {
            open = __L1.open,
            close = __L1.close,
            getStatus = function()
                local ____L1_opened_543 = __L1.opened
                local ____L1_currentRole_544 = __L1.currentRole
                local ____temp_545 = __L1:isConnected()
                local ____t_485 = __t
                local ____opt_483 = __L1.room
                if ____opt_483 ~= nil then
                    ____opt_483 = ____opt_483.code
                end
                __O[3172] = ____opt_483
                local ____temp_546 = if ____t_485(____opt_483) then __O[3172] else nil
                local ____t_488 = __t
                local ____opt_486 = __L1.credentials
                if ____opt_486 ~= nil then
                    ____opt_486 = ____opt_486.playerId
                end
                __O[3173] = ____opt_486
                local ____temp_547 = if ____t_488(____opt_486) then __O[3173] else nil
                local ____t_491 = __t
                local ____opt_489 = __L1.room
                if ____opt_489 ~= nil then
                    ____opt_489 = ____opt_489.hostPlayerId
                end
                __O[3174] = ____opt_489
                local ____temp_548 = if ____t_491(____opt_489) then __O[3174] else nil
                local ____gt_497 = __gt
                local ____opt_494 = __L1.net
                if ____opt_494 ~= nil then
                    ____opt_494 = ____opt_494.getStatus
                end
                local ____opt_result_496
                if ____opt_494 ~= nil then
                    ____opt_result_496 = ____opt_494(____opt_494).connected
                end
                local ____temp_549 = if ____gt_497(____opt_result_496, 0) then "webrtc+https" else "https-cloud"
                local ____temp_550 = if __t(__L1.credentials) then "connected" else "closed"
                local ____opt_500 = __L1.net
                if ____opt_500 ~= nil then
                    ____opt_500 = ____opt_500.getStatus
                end
                local ____opt_result_502
                if ____opt_500 ~= nil then
                    ____opt_result_502 = ____opt_500(____opt_500).pingMs
                end
                local ____opt_result_502_503 = ____opt_result_502
                if ____opt_result_502_503 == nil then
                    ____opt_result_502_503 = __L1.rttMs
                end
                local ____math_floor_result_551 = math.floor(____opt_result_502_503 + 0.5)
                local ____t_509 = __t
                local ____opt_506 = __L1.net
                if ____opt_506 ~= nil then
                    ____opt_506 = ____opt_506.getStatus
                end
                local ____opt_result_508
                if ____opt_506 ~= nil then
                    ____opt_result_508 = ____opt_506(____opt_506)
                end
                __O[3175] = ____opt_result_508
                local ____temp_552 = if ____t_509(____opt_result_508) then __O[3175] else nil
                local ____t_512 = __t
                local ____opt_510 = __L1.world
                if ____opt_510 ~= nil then
                    ____opt_510 = ____opt_510.stage
                end
                __O[3176] = ____opt_510
                local ____temp_553 = if ____t_512(____opt_510) then __O[3176] else nil
                local ____opt_513 = __L1.world
                if ____opt_513 ~= nil then
                    ____opt_513 = ____opt_513.wave
                end
                local ____opt_513_515 = ____opt_513
                if ____opt_513_515 == nil then
                    ____opt_513_515 = nil
                end
                local ____t_518 = __t
                local ____opt_516 = __L1.world
                if ____opt_516 ~= nil then
                    ____opt_516 = ____opt_516.matchId
                end
                __O[3177] = ____opt_516
                local ____temp_554 = if ____t_518(____opt_516) then __O[3177] else nil
                local ____opt_519 = __L1.world
                if ____opt_519 ~= nil then
                    ____opt_519 = ____opt_519.seq
                end
                local ____opt_519_521 = ____opt_519
                if ____opt_519_521 == nil then
                    ____opt_519_521 = nil
                end
                local ____t_529 = __t
                local ____callq_527 = __callq
                local ____opt_522 = __L1.world
                if ____opt_522 ~= nil then
                    ____opt_522 = ____opt_522.players
                end
                local ____callq_527_result_528 = ____callq_527(
                    ____opt_522,
                    "map",
                    function(____, p, index)
                        local ____t_526 = __t
                        local ____t_525 = __t
                        local ____temp_524 = __L1.role == "guest" and index == 1
                        __O[3178] = ____temp_524
                        local visible = if ____t_526(if ____t_525(____temp_524) then __L1.predicted else __O[3178]) then __L1.predicted else p
                        return {
                            id = p.id,
                            x = visible.x,
                            y = visible.y,
                            hp = p.hp,
                            gas = visible.gas,
                            ground = visible.ground,
                            used = __assign({}, p.used),
                            ackSeq = p.ackSeq
                        }
                    end
                )
                __O[3179] = ____callq_527_result_528
                local ____temp_555 = if ____t_529(____callq_527_result_528) then __O[3179] else __arrL({}, 0)
                local ____t_534 = __t
                local ____callq_532 = __callq
                local ____opt_530 = __L1.world
                if ____opt_530 ~= nil then
                    ____opt_530 = ____opt_530.players
                end
                local ____callq_532_result_533 = ____callq_532(
                    ____opt_530,
                    "map",
                    function(____, p) return {
                        id = p.id,
                        x = p.x,
                        y = p.y,
                        hp = p.hp,
                        gas = p.gas,
                        down = p.down
                    } end
                )
                __O[3180] = ____callq_532_result_533
                local ____temp_556 = if ____t_534(____callq_532_result_533) then __O[3180] else __arrL({}, 0)
                local ____t_537 = __t
                local ____opt_535 = __L1.world
                if ____opt_535 ~= nil then
                    ____opt_535 = ____opt_535.boss
                end
                local ____temp_557 = if ____t_537(____opt_535) then {type = __L1.world.boss.type, hp = __L1.world.boss.hp, max = __L1.world.boss.max, state = __L1.world.boss.state} else nil
                local ____t_542 = __t
                local ____lenq_540 = __lenq
                local ____opt_538 = __L1.world
                if ____opt_538 ~= nil then
                    ____opt_538 = ____opt_538.shots
                end
                local ____lenq_540_result_541 = ____lenq_540(____opt_538)
                __O[3181] = ____lenq_540_result_541
                return {
                    open = ____L1_opened_543,
                    role = ____L1_currentRole_544,
                    connected = ____temp_545,
                    roomCode = ____temp_546,
                    playerId = ____temp_547,
                    hostPlayerId = ____temp_548,
                    transport = ____temp_549,
                    connectionState = ____temp_550,
                    pingMs = ____math_floor_result_551,
                    network = ____temp_552,
                    stage = ____temp_553,
                    wave = ____opt_513_515,
                    matchId = ____temp_554,
                    stateSeq = ____opt_519_521,
                    players = ____temp_555,
                    authoritativePlayers = ____temp_556,
                    boss = ____temp_557,
                    shotCount = if ____t_542(____lenq_540_result_541) then __O[3181] else 0,
                    held = {left = __L1.input.left, right = __L1.input.right, jump = __L1.input.jump},
                    counters = {jumpPress = __L1.input.jumpPress, paper = __L1.input.paper, fart = __L1.input.fart, dash = __L1.input.dash},
                    snapshotBytes = if __t(__L1.world) then __len(window.JSON:stringify(__assign(
                        {},
                        __L1.world,
                        {fx = __arrL({}, 0)}
                    ))) else 0
                }
            end
        },
        "open,close,getStatus"
    )
end)(nil)
return ____exports
