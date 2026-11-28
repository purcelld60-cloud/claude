--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
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
        local ____L1__24_result_4 = __L1["$"](__L1, "coopName")
        local ____L1_clean_3 = __L1.clean
        local ____t_result_2
        local ____t_1 = __t
        local ____temp_0 = window.localStorage:getItem("daroca-coop-name")
        __O[3083] = ____temp_0
        if ____t_1(____temp_0) then
            ____t_result_2 = __O[3083]
        else
            ____t_result_2 = window.localStorage:getItem("daroca-arena-name")
        end
        ____L1__24_result_4.value = ____L1_clean_3(__L1, ____t_result_2)
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
            local ____t_8 = __t
            local ____t_result_7
            local ____t_6 = __t
            local ____temp_5 = __L1.role == "host"
            __O[3084] = ____temp_5
            if ____t_6(____temp_5) then
                ____t_result_7 = __L1:isConnected()
            else
                ____t_result_7 = __O[3084]
            end
            if ____t_8(____t_result_7) then
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
                        local ____t_12 = __t
                        local ____t_result_11
                        local ____t_10 = __t
                        local ____temp_9 = e.pointerType == "mouse" and e.button ~= 0
                        __O[3085] = ____temp_9
                        if ____t_10(____temp_9) then
                            ____t_result_11 = __O[3085]
                        else
                            ____t_result_11 = not __t(__L1:arenaVisible())
                        end
                        if ____t_12(____t_result_11) then
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
                                local ____L1_input_13, ____jumpPress_14 = __L1.input, "jumpPress"
                                ____L1_input_13[____jumpPress_14] = ____L1_input_13[____jumpPress_14] + 1
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
                        local ____t_18 = __t
                        local ____t_result_17
                        local ____t_16 = __t
                        local ____temp_15 = e.detail == 0 and not __t(e.pointerType)
                        __O[3086] = ____temp_15
                        if ____t_16(____temp_15) then
                            ____t_result_17 = el.dataset.coopAction ~= "jump"
                        else
                            ____t_result_17 = __O[3086]
                        end
                        if ____t_18(____t_result_17) then
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
                local ____t_22 = __t
                local ____t_result_21
                local ____t_20 = __t
                local ____temp_19 = __L1:arenaVisible()
                __O[3087] = ____temp_19
                if ____t_20(____temp_19) then
                    ____t_result_21 = __O[3087]
                else
                    ____t_result_21 = __len(e.touches) > 1
                end
                if ____t_22(____t_result_21) then
                    stopGesture(nil, e)
                end
            end,
            {passive = false}
        )
    end
    __L1.arenaVisible = function(self)
        local ____t_result_25
        local ____t_24 = __t
        local ____t_result_23
        if __t(__L1.opened) then
            ____t_result_23 = not not __t(__L1.overlay)
        else
            ____t_result_23 = __L1.opened
        end
        __O[3088] = ____t_result_23
        if ____t_24(____t_result_23) then
            ____t_result_25 = not __t(__L1["$"](__L1, "coopArena").hidden)
        else
            ____t_result_25 = __O[3088]
        end
        return ____t_result_25
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
        local ____t_result_30
        local ____t_29 = __t
        local ____t_result_28
        local ____t_27 = __t
        local ____temp_26 = not not __t(__L1.credentials) and not not __t(__L1.room)
        __O[3089] = ____temp_26
        if ____t_27(____temp_26) then
            ____t_result_28 = __len(__L1.room.players) == 2
        else
            ____t_result_28 = __O[3089]
        end
        __O[3090] = ____t_result_28
        if ____t_29(____t_result_28) then
            ____t_result_30 = __L1.room.hostConnected ~= false
        else
            ____t_result_30 = __O[3090]
        end
        return ____t_result_30
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
            local ____L1__24_result_32 = __L1["$"](__L1, id)
            local ____t_result_31
            if __t(__L1.busy) then
                ____t_result_31 = __L1.busy
            else
                ____t_result_31 = connected
            end
            ____L1__24_result_32.disabled = ____t_result_31
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
                local ____add_36 = __add
                local ____opt_result_35
                if p ~= nil then
                    ____opt_result_35 = p.id
                end
                seat.className = ____add_36("coop-seat", ____opt_result_35 == __L1.credentials.playerId and " is-you" or "")
                local label = window.document:createElement("strong")
                local sub = window.document:createElement("small")
                local ____t_result_37
                if __t(p) then
                    ____t_result_37 = __add(p.name, p.id == __L1.credentials.playerId and " · VOCÊ" or "")
                else
                    ____t_result_37 = "ESPERANDO O PARCEIRO"
                end
                label.textContent = ____t_result_37
                local ____t_result_40
                if __t(p) then
                    local ____t_39 = __t
                    local ____temp_38
                    if p.id == __L1.credentials.playerId then
                        ____temp_38 = __L1.ready
                    else
                        ____temp_38 = p.ready
                    end
                    ____t_result_40 = ____t_39(____temp_38) and "✓ PRONTO PRA RESENHA" or (index == 0 and "CRIADOR DA DUPLA" or "PREPARANDO O PAPEL")
                else
                    ____t_result_40 = "PASSE O CÓDIGO ACIMA"
                end
                sub.textContent = ____t_result_40
                seat:append(label, sub)
                __L1["$"](__L1, "coopSeats"):append(seat)
            end
        )
        __L1["$"](__L1, "coopReadyBtn").textContent = __t(__L1.ready) and "✓ ESTOU PRONTO" or "ESTOU PRONTO"
        __L1["$"](__L1, "coopReadyBtn").classList:toggle("is-ready", __L1.ready)
        __L1["$"](__L1, "coopStartBtn").hidden = __L1.role ~= "host"
        local ____L1__24_result_45 = __L1["$"](__L1, "coopStartBtn")
        local ____t_result_44
        local ____t_42 = __t
        local ____t_result_41
        if __t(__L1.busy) then
            ____t_result_41 = __L1.busy
        else
            ____t_result_41 = __len(__L1.room.players) ~= 2
        end
        __O[3091] = ____t_result_41
        if ____t_42(____t_result_41) then
            ____t_result_44 = __O[3091]
        else
            ____t_result_44 = not __t(__call(
                __L1.room.players,
                "every",
                function(____, p)
                    local ____temp_43
                    if p.id == __L1.credentials.playerId then
                        ____temp_43 = __L1.ready
                    else
                        ____temp_43 = p.ready
                    end
                    return ____temp_43
                end
            ))
        end
        ____L1__24_result_45.disabled = ____t_result_44
    end
    __L1.open = function(self)
        __L1:ensureUI()
        if __t(__L1.opened) then
            return
        end
        local ____opt_48 = window.Arena
        if ____opt_48 ~= nil then
            ____opt_48 = ____opt_48.close
        end
        if ____opt_48 ~= nil then
            ____opt_48(____opt_48)
        end
        local ____opt_52 = window.Party
        if ____opt_52 ~= nil then
            ____opt_52 = ____opt_52.close
        end
        if ____opt_52 ~= nil then
            ____opt_52(____opt_52)
        end
        local ____opt_56 = window.Game
        if ____opt_56 ~= nil then
            ____opt_56 = ____opt_56.getState
        end
        local ____opt_result_58
        if ____opt_56 ~= nil then
            ____opt_result_58 = ____opt_56(____opt_56)
        end
        local state = ____opt_result_58
        local ____t_68 = __t
        local ____t_result_67
        local ____t_66 = __t
        local ____t_result_65
        local ____t_64 = __t
        local ____t_result_63
        local ____t_62 = __t
        local ____opt_result_61
        if state ~= nil then
            ____opt_result_61 = state.started
        end
        __O[3092] = ____opt_result_61
        if ____t_62(____opt_result_61) then
            ____t_result_63 = not __t(state.paused)
        else
            ____t_result_63 = __O[3092]
        end
        __O[3093] = ____t_result_63
        if ____t_64(____t_result_63) then
            ____t_result_65 = not __t(state.won)
        else
            ____t_result_65 = __O[3093]
        end
        __O[3094] = ____t_result_65
        if ____t_66(____t_result_65) then
            ____t_result_67 = not __t(state.defeated)
        else
            ____t_result_67 = __O[3094]
        end
        __L1.resumeCampaign = not not ____t_68(____t_result_67)
        local ____opt_71 = window.Game
        if ____opt_71 ~= nil then
            ____opt_71 = ____opt_71.releaseInputs
        end
        if ____opt_71 ~= nil then
            ____opt_71(____opt_71)
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
                local ____self_76 = window.JSON
                local ____self_76_parse_77 = ____self_76.parse
                local ____t_result_75
                local ____t_74 = __t
                local ____temp_73 = window.sessionStorage:getItem(__L1.SESSION)
                __O[3095] = ____temp_73
                if ____t_74(____temp_73) then
                    ____t_result_75 = __O[3095]
                else
                    ____t_result_75 = "null"
                end
                saved = ____self_76_parse_77(____self_76, ____t_result_75)
            end)
        end
        local ____t_86 = __t
        local ____t_result_85
        local ____t_84 = __t
        local ____t_result_83
        local ____t_82 = __t
        local ____t_result_81
        if __t(saved) then
            local ____re_test_80 = __re_test
            local ____re_result_79 = __re("^[A-Z0-9]{6}$", "")
            local ____t_result_78
            if __t(saved.code) then
                ____t_result_78 = saved.code
            else
                ____t_result_78 = ""
            end
            ____t_result_81 = ____re_test_80(____re_result_79, ____t_result_78)
        else
            ____t_result_81 = saved
        end
        __O[3096] = ____t_result_81
        if ____t_82(____t_result_81) then
            ____t_result_83 = type(saved.token) == "string"
        else
            ____t_result_83 = __O[3096]
        end
        __O[3097] = ____t_result_83
        if ____t_84(____t_result_83) then
            ____t_result_85 = type(saved.playerId) == "string"
        else
            ____t_result_85 = __O[3097]
        end
        if ____t_86(____t_result_85) then
            __L1.credentials = {
                token = saved.token,
                playerId = saved.playerId,
                isHost = not not __t(saved.isHost)
            }
            local ____temp_87 = __t(saved.isHost) and "host" or "guest"
            __L1.currentRole = ____temp_87
            __L1.role = ____temp_87
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
        local ____opt_90 = window.Game
        if ____opt_90 ~= nil then
            ____opt_90 = ____opt_90.releaseInputs
        end
        if ____opt_90 ~= nil then
            ____opt_90(____opt_90)
        end
        local ____t_98 = __t
        local ____t_result_97
        if __t(__L1.resumeCampaign) then
            local ____opt_94 = window.Game
            if ____opt_94 ~= nil then
                ____opt_94 = ____opt_94.getState
            end
            local ____opt_result_96
            if ____opt_94 ~= nil then
                ____opt_result_96 = ____opt_94(____opt_94).started
            end
            ____t_result_97 = ____opt_result_96
        else
            ____t_result_97 = __L1.resumeCampaign
        end
        if ____t_98(____t_result_97) then
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
        local ____opt_101 = __L1.net
        if ____opt_101 ~= nil then
            ____opt_101 = ____opt_101.close
        end
        if ____opt_101 ~= nil then
            ____opt_101(____opt_101)
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
            local ____t_result_105
            local ____t_104 = __t
            local ____t_result_103
            if __t(__L1.credentials) then
                ____t_result_103 = __L1.room
            else
                ____t_result_103 = __L1.credentials
            end
            if ____t_104(____t_result_103) then
                ____t_result_105 = {token = __L1.credentials.token, code = __L1.room.code}
            else
                ____t_result_105 = nil
            end
            local old = ____t_result_105
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
                    local ____t_111 = __t
                    local ____t_result_110
                    local ____t_107 = __t
                    local ____temp_106 = window.location.protocol == "file:"
                    __O[3098] = ____temp_106
                    if ____t_107(____temp_106) then
                        local ____opt_108 = window.DaRocaNetwork
                        if ____opt_108 ~= nil then
                            ____opt_108 = ____opt_108.request
                        end
                        ____t_result_110 = ____opt_108
                    else
                        ____t_result_110 = __O[3098]
                    end
                    if ____t_111(____t_result_110) then
                        window.DaRocaNetwork:request(
                            __add(
                                __add("/api/arena/rooms/", old.code),
                                "/leave"
                            ),
                            options
                        ):catch(function()
                        end)
                    else
                        local ____window_116 = window
                        local ____window_fetch_117 = window.fetch
                        local ____add_115 = __add
                        local ____add_114 = __add
                        local ____add_113 = __add
                        local ____temp_112
                        if window.location.protocol == "file:" then
                            ____temp_112 = __L1.OFFICIAL
                        else
                            ____temp_112 = ""
                        end
                        ____window_fetch_117(
                            ____window_116,
                            ____add_115(
                                ____add_114(
                                    ____add_113(____temp_112, "/api/arena/rooms/"),
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
            __L1:clearConnection(__t(closing) and "" or message)
        end)
    end
    __L1.request = function(self, path, options)
        if options == nil then
            options = {}
        end
        return __TS__AsyncAwaiter(function(____awaiter_resolve)
            local ____assign_121 = __assign
            local ____temp_119 = {}
            local ____temp_120 = {["Content-Type"] = "application/json"}
            local ____t_result_118
            if __t(options.headers) then
                ____t_result_118 = options.headers
            else
                ____t_result_118 = {}
            end
            local headers = ____assign_121(____temp_119, ____temp_120, ____t_result_118)
            local ____t_124 = __t
            local ____opt_122 = __L1.credentials
            if ____opt_122 ~= nil then
                ____opt_122 = ____opt_122.token
            end
            if ____t_124(____opt_122) then
                headers.Authorization = __add("Bearer ", __L1.credentials.token)
            end
            local response
            local ____t_130 = __t
            local ____t_result_129
            local ____t_126 = __t
            local ____temp_125 = window.location.protocol == "file:"
            __O[3099] = ____temp_125
            if ____t_126(____temp_125) then
                local ____opt_127 = window.DaRocaNetwork
                if ____opt_127 ~= nil then
                    ____opt_127 = ____opt_127.request
                end
                ____t_result_129 = ____opt_127
            else
                ____t_result_129 = __O[3099]
            end
            if ____t_130(____t_result_129) then
                local ____self_135 = window.DaRocaNetwork
                local ____self_135_request_136 = ____self_135.request
                local ____path_134 = path
                local ____t_result_131
                if __t(options.method) then
                    ____t_result_131 = options.method
                else
                    ____t_result_131 = "POST"
                end
                local ____headers_133 = headers
                local ____temp_132
                if options.body == nil then
                    ____temp_132 = nil
                else
                    ____temp_132 = window.JSON:stringify(options.body)
                end
                response = __TS__Await(____self_135_request_136(____self_135, ____path_134, {method = ____t_result_131, headers = ____headers_133, body = ____temp_132}))
            else
                local controller = __new("AbortController")
                local timer = window:setTimeout(
                    function() return controller:abort() end,
                    10000
                )
                local ____try = __TS__AsyncAwaiter(function()
                    local ____window_143 = window
                    local ____window_fetch_144 = window.fetch
                    local ____add_138 = __add
                    local ____temp_137
                    if window.location.protocol == "file:" then
                        ____temp_137 = __L1.OFFICIAL
                    else
                        ____temp_137 = ""
                    end
                    local ____add_138_result_142 = ____add_138(____temp_137, path)
                    local ____t_result_139
                    if __t(options.method) then
                        ____t_result_139 = options.method
                    else
                        ____t_result_139 = "POST"
                    end
                    local ____headers_141 = headers
                    local ____temp_140
                    if options.body == nil then
                        ____temp_140 = nil
                    else
                        ____temp_140 = window.JSON:stringify(options.body)
                    end
                    response = __TS__Await(____window_fetch_144(____window_143, ____add_138_result_142, {
                        method = ____t_result_139,
                        headers = ____headers_141,
                        body = ____temp_140,
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
            local ____opt_result_147
            if response ~= nil then
                ____opt_result_147 = response.json
            end
            if type(____opt_result_147) == "function" then
                data = __TS__Await(response:json())
            else
                local ____opt_result_150
                if response ~= nil then
                    ____opt_result_150 = response.body
                end
                local ____opt_result_150_154 = ____opt_result_150
                if ____opt_result_150_154 == nil then
                    local ____opt_result_153
                    if response ~= nil then
                        ____opt_result_153 = response.data
                    end
                    ____opt_result_150_154 = ____opt_result_153
                end
                local ____opt_result_150_154_155 = ____opt_result_150_154
                if ____opt_result_150_154_155 == nil then
                    ____opt_result_150_154_155 = response
                end
                data = ____opt_result_150_154_155
                if type(data) == "string" then
                    data = window.JSON:parse(data)
                end
            end
            local ____opt_result_158
            if response ~= nil then
                ____opt_result_158 = response.status
            end
            local ____opt_result_158_159 = ____opt_result_158
            if ____opt_result_158_159 == nil then
                ____opt_result_158_159 = 200
            end
            local status = ____opt_result_158_159
            local ____t_169 = __t
            local ____t_result_168
            local ____t_164 = __t
            local ____opt_result_162
            if response ~= nil then
                ____opt_result_162 = response.ok
            end
            local ____temp_163 = ____opt_result_162 == false or __ge(status, 400)
            __O[3100] = ____temp_163
            if ____t_164(____temp_163) then
                ____t_result_168 = __O[3100]
            else
                local ____opt_result_167
                if data ~= nil then
                    ____opt_result_167 = data.error
                end
                ____t_result_168 = ____opt_result_167
            end
            if ____t_169(____t_result_168) then
                local ____Error_187 = Error
                local ____t_result_186
                local ____t_181 = __t
                local ____t_result_180
                local ____t_176 = __t
                local ____opt_result_174
                if data ~= nil then
                    ____opt_result_174 = data.error
                end
                local ____opt_result_175
                if ____opt_result_174 ~= nil then
                    ____opt_result_175 = ____opt_result_174.message
                end
                __O[3101] = ____opt_result_175
                if ____t_176(____opt_result_175) then
                    ____t_result_180 = __O[3101]
                else
                    local ____opt_result_179
                    if data ~= nil then
                        ____opt_result_179 = data.message
                    end
                    ____t_result_180 = ____opt_result_179
                end
                __O[3102] = ____t_result_180
                if ____t_181(____t_result_180) then
                    ____t_result_186 = __O[3102]
                else
                    local ____temp_185
                    local ____opt_result_184
                    if data ~= nil then
                        ____opt_result_184 = data.error
                    end
                    if type(____opt_result_184) == "string" then
                        ____temp_185 = data.error
                    else
                        ____temp_185 = "A sala não respondeu. Confira a internet."
                    end
                    ____t_result_186 = ____temp_185
                end
                local ____error = __TS__New(____Error_187, ____t_result_186)
                ____error.status = status
                error(____error, 0)
            end
            return ____awaiter_resolve(nil, data)
        end)
    end
    __L1.connect = function(self, kind)
        return __TS__AsyncAwaiter(function(____awaiter_resolve)
            local ____t_189 = __t
            local ____t_result_188
            if __t(__L1.busy) then
                ____t_result_188 = __L1.busy
            else
                ____t_result_188 = __L1.credentials
            end
            if ____t_189(____t_result_188) then
                return ____awaiter_resolve(nil)
            end
            local code = __L1["$"](__L1, "coopCodeIn").value
            local ____t_result_192
            local ____t_191 = __t
            local ____temp_190 = __L1:clean(__L1["$"](__L1, "coopName").value)
            __O[3103] = ____temp_190
            if ____t_191(____temp_190) then
                ____t_result_192 = __O[3103]
            else
                ____t_result_192 = "Da Resenha"
            end
            local name = ____t_result_192
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
            __L1:setStatus(kind == "create" and "Criando a dupla na nuvem…" or "Entrando na dupla…")
            local ____L1_193, ____generation_194 = __L1, "generation"
            local ____L1_generation_195 = ____L1_193[____generation_194] + 1
            ____L1_193[____generation_194] = ____L1_generation_195
            local gen = ____L1_generation_195
            local ____hasReturned, ____returnValue
            local ____try = __TS__AsyncAwaiter(function()
                window.localStorage:setItem("daroca-coop-name", name)
                local data = __TS__Await(__L1:request(
                    kind == "create" and "/api/arena/rooms" or __add(
                        __add("/api/arena/rooms/", code),
                        "/join"
                    ),
                    {body = {
                        name = name,
                        character = "daroca",
                        mode = "coop",
                        protocol = __L1.PROTOCOL,
                        capacity = 2
                    }}
                ))
                if gen ~= __L1.generation then
                    ____hasReturned = true
                    return
                end
                local ____t_201 = __t
                local ____opt_196 = data.room
                if ____opt_196 ~= nil then
                    ____opt_196 = ____opt_196.mode
                end
                local ____temp_200 = ____opt_196 ~= "coop"
                if not ____temp_200 then
                    local ____opt_198 = data.room
                    if ____opt_198 ~= nil then
                        ____opt_198 = ____opt_198.protocol
                    end
                    ____temp_200 = ____opt_198 ~= __L1.PROTOCOL
                end
                if ____t_201(____temp_200) then
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
                local ____temp_202 = __t(data.isHost) and "host" or "guest"
                __L1.currentRole = ____temp_202
                __L1.role = ____temp_202
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
                            __L1:setStatus(____error.name == "AbortError" and "A internet demorou. Tente entrar novamente." or ____error.message, true)
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
            local ____opt_203 = __L1.room
            if ____opt_203 ~= nil then
                ____opt_203 = ____opt_203.code
            end
            local value = ____opt_203
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
        local ____t_208 = __t
        local ____t_result_207
        local ____t_206 = __t
        local ____t_result_205
        if __t(__L1.net) then
            ____t_result_205 = __L1.net
        else
            ____t_result_205 = not __t(__L1.credentials)
        end
        __O[3104] = ____t_result_205
        if ____t_206(____t_result_205) then
            ____t_result_207 = __O[3104]
        else
            ____t_result_207 = not __t(window.ArenaNet)
        end
        if ____t_208(____t_result_207) then
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
        local ____L1_209, ____inputSeq_210 = __L1, "inputSeq"
        local ____L1_inputSeq_211 = ____L1_209[____inputSeq_210] + 1
        ____L1_209[____inputSeq_210] = ____L1_inputSeq_211
        return {
            seq = ____L1_inputSeq_211,
            x = (__t(____local.right) and 1 or 0) - (__t(____local.left) and 1 or 0),
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
        local ____i_seq_216 = i.seq
        local ____lt_result_217 = __lt(i.x, -0.1)
        local ____gt_result_218 = __gt(i.x, 0.1)
        local ____temp_219 = not not __t(i.jump)
        local ____t_result_212
        if __t(i.jumpPress) then
            ____t_result_212 = i.jumpPress
        else
            ____t_result_212 = 0
        end
        local ____t_result_213
        if __t(i.attack) then
            ____t_result_213 = i.attack
        else
            ____t_result_213 = 0
        end
        local ____t_result_214
        if __t(i.special) then
            ____t_result_214 = i.special
        else
            ____t_result_214 = 0
        end
        local ____t_result_215
        if __t(i.dash) then
            ____t_result_215 = i.dash
        else
            ____t_result_215 = 0
        end
        return {
            seq = ____i_seq_216,
            left = ____lt_result_217,
            right = ____gt_result_218,
            jump = ____temp_219,
            jumpPress = ____t_result_212,
            paper = ____t_result_213,
            fart = ____t_result_214,
            dash = ____t_result_215
        }
    end
    __L1.acceptInput = function(self, id, command)
        local ____t_234 = __t
        local ____t_result_233
        local ____t_232 = __t
        local ____t_result_231
        local ____t_226 = __t
        local ____t_result_225
        local ____t_221 = __t
        local ____temp_220 = not __t(command) or not __t(__L1:counter(command.seq))
        __O[3105] = ____temp_220
        if ____t_221(____temp_220) then
            ____t_result_225 = __O[3105]
        else
            local ____id_224 = id
            local ____opt_222 = __L1.room
            if ____opt_222 ~= nil then
                ____opt_222 = ____opt_222.hostPlayerId
            end
            ____t_result_225 = ____id_224 == ____opt_222
        end
        __O[3106] = ____t_result_225
        if ____t_226(____t_result_225) then
            ____t_result_231 = __O[3106]
        else
            local ____t_230 = __t
            local ____callq_229 = __callq
            local ____opt_227 = __L1.room
            if ____opt_227 ~= nil then
                ____opt_227 = ____opt_227.players
            end
            ____t_result_231 = not ____t_230(____callq_229(
                ____opt_227,
                "some",
                function(____, p) return p.id == id end
            ))
        end
        __O[3107] = ____t_result_231
        if ____t_232(____t_result_231) then
            ____t_result_233 = __O[3107]
        else
            ____t_result_233 = __le(command.seq, __L1.remoteSequence)
        end
        if ____t_234(____t_result_233) then
            return
        end
        __L1.remoteSequence = command.seq
        __L1.remoteInput = __L1:decodeInput(command)
        __L1.inputAt = window.performance:now()
    end
    __L1.validWorld = function(self, w)
        local ____t_result_289
        local ____t_288 = __t
        local ____t_result_287
        local ____t_286 = __t
        local ____t_result_285
        local ____t_283 = __t
        local ____t_result_282
        local ____t_281 = __t
        local ____t_result_280
        local ____t_279 = __t
        local ____t_result_278
        local ____t_277 = __t
        local ____t_result_276
        local ____t_275 = __t
        local ____t_result_274
        local ____t_273 = __t
        local ____t_result_272
        local ____t_256 = __t
        local ____t_result_255
        local ____t_254 = __t
        local ____t_result_253
        local ____t_252 = __t
        local ____t_result_251
        local ____t_250 = __t
        local ____t_result_249
        local ____t_248 = __t
        local ____t_result_247
        local ____t_246 = __t
        local ____t_result_245
        local ____t_244 = __t
        local ____t_result_243
        local ____t_242 = __t
        local ____t_result_241
        local ____t_240 = __t
        local ____t_result_239
        local ____t_238 = __t
        local ____t_result_237
        local ____t_236 = __t
        local ____t_result_235
        if __t(w) then
            ____t_result_235 = w.v == __L1.PROTOCOL
        else
            ____t_result_235 = w
        end
        __O[3108] = ____t_result_235
        if ____t_236(____t_result_235) then
            ____t_result_237 = w.mode == "coop"
        else
            ____t_result_237 = __O[3108]
        end
        __O[3109] = ____t_result_237
        if ____t_238(____t_result_237) then
            ____t_result_239 = __L1:counter(w.seq)
        else
            ____t_result_239 = __O[3109]
        end
        __O[3110] = ____t_result_239
        if ____t_240(____t_result_239) then
            ____t_result_241 = type(w.matchId) == "string"
        else
            ____t_result_241 = __O[3110]
        end
        __O[3111] = ____t_result_241
        if ____t_242(____t_result_241) then
            ____t_result_243 = __L1:finite(w.time)
        else
            ____t_result_243 = __O[3111]
        end
        __O[3112] = ____t_result_243
        if ____t_244(____t_result_243) then
            ____t_result_245 = __isInteger(w.wave)
        else
            ____t_result_245 = __O[3112]
        end
        __O[3113] = ____t_result_245
        if ____t_246(____t_result_245) then
            ____t_result_247 = __ge(w.wave, 0)
        else
            ____t_result_247 = __O[3113]
        end
        __O[3114] = ____t_result_247
        if ____t_248(____t_result_247) then
            ____t_result_249 = __lt(w.wave, 3)
        else
            ____t_result_249 = __O[3114]
        end
        __O[3115] = ____t_result_249
        if ____t_250(____t_result_249) then
            ____t_result_251 = __call(
                __arrL({
                    "countdown",
                    "playing",
                    "intermission",
                    "victory",
                    "defeat"
                }, 5),
                "includes",
                w.stage
            )
        else
            ____t_result_251 = __O[3115]
        end
        __O[3116] = ____t_result_251
        if ____t_252(____t_result_251) then
            ____t_result_253 = __isArray(w.players)
        else
            ____t_result_253 = __O[3116]
        end
        __O[3117] = ____t_result_253
        if ____t_254(____t_result_253) then
            ____t_result_255 = __len(w.players) == 2
        else
            ____t_result_255 = __O[3117]
        end
        __O[3125] = ____t_result_255
        if ____t_256(____t_result_255) then
            ____t_result_272 = __call(
                w.players,
                "every",
                function(____, p, id)
                    local ____t_result_271
                    local ____t_270 = __t
                    local ____t_result_269
                    local ____t_268 = __t
                    local ____t_result_267
                    local ____t_266 = __t
                    local ____t_result_265
                    local ____t_264 = __t
                    local ____t_result_263
                    local ____t_262 = __t
                    local ____t_result_261
                    local ____t_260 = __t
                    local ____t_result_259
                    local ____t_258 = __t
                    local ____t_result_257
                    if __t(p) then
                        ____t_result_257 = p.id == id
                    else
                        ____t_result_257 = p
                    end
                    __O[3118] = ____t_result_257
                    if ____t_258(____t_result_257) then
                        ____t_result_259 = __call(
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
                        )
                    else
                        ____t_result_259 = __O[3118]
                    end
                    __O[3119] = ____t_result_259
                    if ____t_260(____t_result_259) then
                        ____t_result_261 = __ge(p.x, 0)
                    else
                        ____t_result_261 = __O[3119]
                    end
                    __O[3120] = ____t_result_261
                    if ____t_262(____t_result_261) then
                        ____t_result_263 = __le(p.x, 960)
                    else
                        ____t_result_263 = __O[3120]
                    end
                    __O[3121] = ____t_result_263
                    if ____t_264(____t_result_263) then
                        ____t_result_265 = __ge(p.y, 0)
                    else
                        ____t_result_265 = __O[3121]
                    end
                    __O[3122] = ____t_result_265
                    if ____t_266(____t_result_265) then
                        ____t_result_267 = __le(p.y, 540)
                    else
                        ____t_result_267 = __O[3122]
                    end
                    __O[3123] = ____t_result_267
                    if ____t_268(____t_result_267) then
                        ____t_result_269 = p.used
                    else
                        ____t_result_269 = __O[3123]
                    end
                    __O[3124] = ____t_result_269
                    if ____t_270(____t_result_269) then
                        ____t_result_271 = __call(
                            __arrL({"paper", "fart", "dash", "jumpPress"}, 4),
                            "every",
                            function(____, k) return __L1:counter(__get(p.used, k)) end
                        )
                    else
                        ____t_result_271 = __O[3124]
                    end
                    return ____t_result_271
                end
            )
        else
            ____t_result_272 = __O[3125]
        end
        __O[3126] = ____t_result_272
        if ____t_273(____t_result_272) then
            ____t_result_274 = w.boss
        else
            ____t_result_274 = __O[3126]
        end
        __O[3127] = ____t_result_274
        if ____t_275(____t_result_274) then
            ____t_result_276 = __call(__L1.bossTypes, "includes", w.boss.type)
        else
            ____t_result_276 = __O[3127]
        end
        __O[3128] = ____t_result_276
        if ____t_277(____t_result_276) then
            ____t_result_278 = __call(
                __arrL({"x", "y", "hp", "max"}, 4),
                "every",
                function(____, k) return __L1:finite(__get(w.boss, k)) end
            )
        else
            ____t_result_278 = __O[3128]
        end
        __O[3129] = ____t_result_278
        if ____t_279(____t_result_278) then
            ____t_result_280 = __isArray(w.shots)
        else
            ____t_result_280 = __O[3129]
        end
        __O[3130] = ____t_result_280
        if ____t_281(____t_result_280) then
            ____t_result_282 = __le(
                __len(w.shots),
                64
            )
        else
            ____t_result_282 = __O[3130]
        end
        __O[3131] = ____t_result_282
        if ____t_283(____t_result_282) then
            ____t_result_285 = __call(
                w.shots,
                "every",
                function(____, s)
                    local ____t_result_284
                    if __t(s) then
                        ____t_result_284 = __call(
                            __arrL({"x", "y", "vx", "vy"}, 4),
                            "every",
                            function(____, k) return __L1:finite(__get(s, k)) end
                        )
                    else
                        ____t_result_284 = s
                    end
                    return ____t_result_284
                end
            )
        else
            ____t_result_285 = __O[3131]
        end
        __O[3132] = ____t_result_285
        if ____t_286(____t_result_285) then
            ____t_result_287 = __isArray(w.hazards)
        else
            ____t_result_287 = __O[3132]
        end
        __O[3133] = ____t_result_287
        if ____t_288(____t_result_287) then
            ____t_result_289 = __le(
                __len(w.hazards),
                25
            )
        else
            ____t_result_289 = __O[3133]
        end
        return ____t_result_289
    end
    __L1.absorb = function(self, data)
        local ____t_301 = __t
        local ____t_result_300
        local ____t_299 = __t
        local ____t_result_298
        local ____t_297 = __t
        local ____t_result_296
        local ____t_295 = __t
        local ____t_293 = __t
        local ____opt_result_292
        if data ~= nil then
            ____opt_result_292 = data.room
        end
        local ____temp_294 = not ____t_293(____opt_result_292) or data.room.mode ~= "coop"
        __O[3134] = ____temp_294
        if ____t_295(____temp_294) then
            ____t_result_296 = __O[3134]
        else
            ____t_result_296 = data.room.protocol ~= __L1.PROTOCOL
        end
        __O[3135] = ____t_result_296
        if ____t_297(____t_result_296) then
            ____t_result_298 = __O[3135]
        else
            ____t_result_298 = data.room.capacity ~= 2
        end
        __O[3136] = ____t_result_298
        if ____t_299(____t_result_298) then
            ____t_result_300 = __O[3136]
        else
            ____t_result_300 = not __isArray(data.room.players)
        end
        if ____t_301(____t_result_300) then
            error(
                Error(nil, "Esta sala usa outro modo ou versão. Atualize e abra Dupla online."),
                0
            )
        end
        __L1.room = data.room
        __L1.credentials.isHost = __L1.room.hostPlayerId == __L1.credentials.playerId
        local ____temp_302 = __t(__L1.credentials.isHost) and "host" or "guest"
        __L1.currentRole = ____temp_302
        __L1.role = ____temp_302
        local ____iter_308 = __iter
        local ____t_result_307
        if __t(data.inputs) then
            ____t_result_307 = data.inputs
        else
            ____t_result_307 = __arrL({}, 0)
        end
        for ____, entry in __TS__Iterator(____iter_308(____t_result_307)) do
            local ____t_306 = __t
            local ____t_result_305
            local ____t_304 = __t
            local ____temp_303 = entry.playerId ~= __L1.room.hostPlayerId
            __O[3137] = ____temp_303
            if ____t_304(____temp_303) then
                ____t_result_305 = entry.input
            else
                ____t_result_305 = __O[3137]
            end
            if ____t_306(____t_result_305) then
                __L1:acceptInput(entry.playerId, entry.input)
            end
        end
        local ____t_312 = __t
        local ____t_result_311
        local ____t_310 = __t
        local ____temp_309 = __L1.role == "guest"
        __O[3138] = ____temp_309
        if ____t_310(____temp_309) then
            ____t_result_311 = __O[3138]
        else
            ____t_result_311 = __L1.restoring
        end
        if ____t_312(____t_result_311) then
            __L1:receiveState(data.state)
        end
        if __t(__L1.restoring) then
            local ____call_314 = __call
            local ____t_result_313
            if __t(data.inputs) then
                ____t_result_313 = data.inputs
            else
                ____t_result_313 = __arrL({}, 0)
            end
            local own = ____call_314(
                ____t_result_313,
                "find",
                function(____, i) return i.playerId == __L1.credentials.playerId end
            )
            local ____getq_319 = __getq
            local ____opt_317 = __L1.world
            if ____opt_317 ~= nil then
                ____opt_317 = ____opt_317.players
            end
            local ____opt_315 = ____getq_319(
                ____opt_317,
                __L1:localSlot()
            )
            if ____opt_315 ~= nil then
                ____opt_315 = ____opt_315.used
            end
            local used = ____opt_315
            local ____L1_inputSeq_325 = __L1.inputSeq
            local ____t_result_324
            local ____t_323 = __t
            local ____opt_result_322
            if own ~= nil then
                ____opt_result_322 = own.seq
            end
            __O[3139] = ____opt_result_322
            if ____t_323(____opt_result_322) then
                ____t_result_324 = __O[3139]
            else
                ____t_result_324 = 0
            end
            __L1.inputSeq = math.max(____L1_inputSeq_325, ____t_result_324)
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
                local ____set_339 = __set
                local ____L1_input_337 = __L1.input
                local ____a_338 = a
                local ____get_result_336 = __get(__L1.input, a)
                local ____t_result_332
                local ____t_331 = __t
                local ____getq_329 = __getq
                local ____opt_result_328
                if own ~= nil then
                    ____opt_result_328 = own.input
                end
                local ____getq_329_result_330 = ____getq_329(____opt_result_328, b)
                __O[3140] = ____getq_329_result_330
                if ____t_331(____getq_329_result_330) then
                    ____t_result_332 = __O[3140]
                else
                    ____t_result_332 = 0
                end
                local ____t_result_335
                local ____t_334 = __t
                local ____getq_result_333 = __getq(used, a)
                __O[3141] = ____getq_result_333
                if ____t_334(____getq_result_333) then
                    ____t_result_335 = __O[3141]
                else
                    ____t_result_335 = 0
                end
                ____set_339(
                    ____L1_input_337,
                    ____a_338,
                    math.max(____get_result_336, ____t_result_332, ____t_result_335)
                )
            end
            local ____t_342 = __t
            local ____opt_340 = __call(
                __L1.room.players,
                "find",
                function(____, p) return p.id == __L1.credentials.playerId end
            )
            if ____opt_340 ~= nil then
                ____opt_340 = ____opt_340.ready
            end
            __L1.ready = not not ____t_342(____opt_340)
            __L1.restoring = false
            __L1.readyRevision = __L1.readyRevision + 1
            __L1:setStatus("Você voltou à mesma dupla. A resenha continua.")
        end
        local ____t_346 = __t
        local ____t_result_345
        local ____t_344 = __t
        local ____lt_result_343 = __lt(
            __len(__L1.room.players),
            2
        )
        __O[3142] = ____lt_result_343
        if ____t_344(____lt_result_343) then
            ____t_result_345 = __L1.world
        else
            ____t_result_345 = __O[3142]
        end
        if ____t_346(____t_result_345) then
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
        local ____opt_349 = __L1.net
        if ____opt_349 ~= nil then
            ____opt_349 = ____opt_349.updateRoster
        end
        if ____opt_349 ~= nil then
            ____opt_349(____opt_349, __L1.room.players)
        end
        __L1:updateLobby()
        __L1.failures = 0
    end
    __L1.receiveState = function(self, incoming)
        local ____t_355 = __t
        local ____t_result_354
        local ____t_352 = __t
        local ____temp_351 = not __t(__L1:validWorld(incoming))
        __O[3143] = ____temp_351
        if ____t_352(____temp_351) then
            ____t_result_354 = __O[3143]
        else
            local ____t_result_353
            if __t(__L1.world) then
                ____t_result_353 = __le(incoming.seq, __L1.world.seq)
            else
                ____t_result_353 = __L1.world
            end
            ____t_result_354 = ____t_result_353
        end
        if ____t_355(____t_result_354) then
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
        __L1["$"](__L1, "coopRoleLabel").textContent = __L1.role == "host" and "VOCÊ · DA ROÇA 1" or "VOCÊ · PARCEIRO 2"
    end
    __L1.snapshot = function(self)
        if not __t(__L1.world) then
            return nil
        end
        local ____L1_world_359 = __L1.world
        local ____L1_356, ____stateSeq_357 = __L1, "stateSeq"
        local ____L1_stateSeq_358 = ____L1_356[____stateSeq_357] + 1
        ____L1_356[____stateSeq_357] = ____L1_stateSeq_358
        ____L1_world_359.seq = ____L1_stateSeq_358
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
            function(____, key, value)
                local ____temp_360
                if type(value) == "number" then
                    ____temp_360 = math.floor(value * 1000 + 0.5) / 1000
                else
                    ____temp_360 = value
                end
                return ____temp_360
            end
        ))
    end
    __L1.scheduleSync = function(self, delay)
        if delay == nil then
            delay = 180
        end
        window:clearTimeout(__L1.pollTimer)
        local ____t_362 = __t
        local ____t_result_361
        if __t(__L1.opened) then
            ____t_result_361 = __L1.credentials
        else
            ____t_result_361 = __L1.opened
        end
        if ____t_362(____t_result_361) then
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
            local ____t_result_363
            if __t(__L1.restoring) then
                ____t_result_363 = {}
            else
                ____t_result_363 = {input = __L1:wireInput()}
            end
            local body = ____t_result_363
            local revision = __L1.readyRevision
            if __t(not __t(__L1.restoring) and __L1.syncedReady ~= revision) then
                body.ready = __L1.ready
            end
            if __t(__L1.role == "host" and not __t(__L1.restoring)) then
                if __t(__L1.world) then
                    body.state = __L1:snapshot()
                    body.status = __t(__call(
                        __arrL({"victory", "defeat"}, 2),
                        "includes",
                        __L1.world.stage
                    )) and "finished" or "playing"
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
                local ____t_result_364
                if __t(__L1.rttMs) then
                    ____t_result_364 = __L1.rttMs * 0.7 + elapsed * 0.3
                else
                    ____t_result_364 = elapsed
                end
                __L1.rttMs = ____t_result_364
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
                        local ____L1_setStatus_367 = __L1.setStatus
                        local ____temp_366
                        if ____error.name == "AbortError" then
                            ____temp_366 = "A internet demorou. Reconectando a dupla…"
                        else
                            local ____t_result_365
                            if __t(____error.message) then
                                ____t_result_365 = ____error.message
                            else
                                ____t_result_365 = "Conexão oscilando. Reconectando…"
                            end
                            ____temp_366 = ____t_result_365
                        end
                        ____L1_setStatus_367(__L1, ____temp_366, true)
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
            local ____t_371 = __t
            local ____t_result_370
            local ____t_369 = __t
            local ____temp_368 = gen == __L1.generation
            __O[3144] = ____temp_368
            if ____t_369(____temp_368) then
                ____t_result_370 = __L1.credentials
            else
                ____t_result_370 = __O[3144]
            end
            if ____t_371(____t_result_370) then
                local ____opt_374 = __L1.net
                if ____opt_374 ~= nil then
                    ____opt_374 = ____opt_374.getStatus
                end
                local ____opt_result_376
                if ____opt_374 ~= nil then
                    ____opt_result_376 = ____opt_374(____opt_374)
                end
                local link = ____opt_result_376
                local ____temp_381
                if not __t(__L1.world) then
                    ____temp_381 = 500
                else
                    local ____ge_380 = __ge
                    local ____opt_result_379
                    if link ~= nil then
                        ____opt_result_379 = link.connected
                    end
                    ____temp_381 = ____ge_380(____opt_result_379, 1) and 500 or 180
                end
                local cadence = ____temp_381
                __L1:scheduleSync(__t(__L1.urgent) and 0 or math.max(
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
            facing = id == 0 and 1 or -1,
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
        local ____t_386 = __t
        local ____t_result_385
        local ____t_383 = __t
        local ____temp_382 = __L1.role ~= "host" or not __t(__L1:isConnected())
        __O[3145] = ____temp_382
        if ____t_383(____temp_382) then
            ____t_result_385 = __O[3145]
        else
            ____t_result_385 = __call(
                __L1.room.players,
                "some",
                function(____, p)
                    local ____temp_384
                    if p.id == __L1.credentials.playerId then
                        ____temp_384 = not __t(__L1.ready)
                    else
                        ____temp_384 = not __t(p.ready)
                    end
                    return ____temp_384
                end
            )
        end
        if ____t_386(____t_result_385) then
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
            local ____t_result_387
            if __t(p.id) then
                ____t_result_387 = __L1.remoteInput
            else
                ____t_result_387 = ____local
            end
            local command = ____t_result_387
            for ____, a in __iterar((__arrL({"paper", "fart", "dash", "jumpPress"}, 4))) do
                local ____set_392 = __set
                local ____p_used_391 = p.used
                local ____t_result_390
                local ____t_389 = __t
                local ____get_result_388 = __get(command, a)
                __O[3146] = ____get_result_388
                if ____t_389(____get_result_388) then
                    ____t_result_390 = __O[3146]
                else
                    ____t_result_390 = 0
                end
                ____set_392(____p_used_391, a, ____t_result_390)
            end
        end
        local ____t_result_399
        local ____t_398 = __t
        local ____opt_395 = window.crypto
        local ____opt_393 = ____opt_395 and ____opt_395.randomUUID
        local ____temp_397 = ____opt_393 and ____opt_393(____opt_395)
        __O[3147] = ____temp_397
        if ____t_398(____temp_397) then
            ____t_result_399 = __O[3147]
        else
            ____t_result_399 = __call(
                window.Date:now(),
                "toString",
                36
            )
        end
        local matchId = ____t_result_399
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
        local ____opt_402 = __L1.net
        if ____opt_402 ~= nil then
            ____opt_402 = ____opt_402.sendState
        end
        if ____opt_402 ~= nil then
            ____opt_402(
                ____opt_402,
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
            local ____L1_input_407 = __L1.input
            local ____t_result_406
            local ____t_405 = __t
            local ____temp_404 = __L1:actionHeld("jump")
            __O[3148] = ____temp_404
            if ____t_405(____temp_404) then
                ____t_result_406 = __O[3148]
            else
                ____t_result_406 = __call(
                    __arr(__TS__Spread(__iter(__call(__L1.activePointers, "values")))),
                    "some",
                    function(____, v) return v.action == "jump" end
                )
            end
            ____L1_input_407.jump = ____t_result_406
        end
        __L1:changedInput()
    end
    __L1.resetInputs = function(self)
        local ____L1_input_409 = __L1.input
        local ____L1_input_408 = __L1.input
        __L1.input.jump = false
        ____L1_input_408.right = false
        ____L1_input_409.left = false
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
            local ____opt_412 = __L1.net
            if ____opt_412 ~= nil then
                ____opt_412 = ____opt_412.sendInput
            end
            if ____opt_412 ~= nil then
                ____opt_412(
                    ____opt_412,
                    __L1:wireInput()
                )
            end
        end
        __L1:syncNow()
    end
    __L1.pulse = function(self, action)
        local ____t_419 = __t
        local ____t_result_418
        local ____t_415 = __t
        local ____temp_414 = not __t(__L1:arenaVisible()) or not __t(__call(
            __arrL({"paper", "fart", "dash"}, 3),
            "includes",
            action
        ))
        __O[3149] = ____temp_414
        if ____t_415(____temp_414) then
            ____t_result_418 = __O[3149]
        else
            local ____opt_416 = __L1.world
            if ____opt_416 ~= nil then
                ____opt_416 = ____opt_416.stage
            end
            ____t_result_418 = ____opt_416 ~= "playing"
        end
        if ____t_419(____t_result_418) then
            return
        end
        __inc(__L1.input, action, 1, true)
        __L1:changedInput()
    end
    __L1.getLocalInput = function(self)
        local ____assign_429 = __assign
        local ____temp_427 = {}
        local ____L1_input_428 = __L1.input
        local ____L1_inputSeq_426 = __L1.inputSeq
        local ____t_result_422
        local ____t_421 = __t
        local ____temp_420 = __L1.joyX < -0.15
        __O[3150] = ____temp_420
        if ____t_421(____temp_420) then
            ____t_result_422 = __O[3150]
        else
            ____t_result_422 = __L1.input.left
        end
        local ____t_result_425
        local ____t_424 = __t
        local ____temp_423 = __L1.joyX > 0.15
        __O[3151] = ____temp_423
        if ____t_424(____temp_423) then
            ____t_result_425 = __O[3151]
        else
            ____t_result_425 = __L1.input.right
        end
        return ____assign_429(____temp_427, ____L1_input_428, {seq = ____L1_inputSeq_426, left = ____t_result_422, right = ____t_result_425})
    end
    __L1.keyMatches = function(self, action, code)
        local ____t_result_433
        local ____t_432 = __t
        local ____opt_430 = window.ControlSettings
        if ____opt_430 ~= nil then
            ____opt_430 = ____opt_430.matches
        end
        if ____t_432(____opt_430) then
            ____t_result_433 = window.ControlSettings:matches(action, code)
        else
            ____t_result_433 = __callq(
                __get(__L1.defaults, action),
                "includes",
                code
            )
        end
        return ____t_result_433
    end
    __L1.readHeld = function(self)
        __L1.input.left = __L1:actionHeld("left")
        __L1.input.right = __L1:actionHeld("right")
        local ____L1_input_437 = __L1.input
        local ____t_result_436
        local ____t_435 = __t
        local ____temp_434 = __L1:actionHeld("jump")
        __O[3152] = ____temp_434
        if ____t_435(____temp_434) then
            ____t_result_436 = __O[3152]
        else
            ____t_result_436 = __call(
                __arr(__TS__Spread(__iter(__call(__L1.activePointers, "values")))),
                "some",
                function(____, v) return v.action == "jump" end
            )
        end
        ____L1_input_437.jump = ____t_result_436
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
        p.vx = (__lt(p.x, from) and -1 or 1) * 130
        p.vy = -110
        p.ground = false
        __L1:fx(p.x, p.y - 30, "#e9a484", 9)
        if not __t(p.hp) then
            p.down = 8
            local ____p_438 = p
            p.vy = 0
            ____p_438.vx = 0
        end
    end
    __L1.damageBoss = function(self, n, from)
        local b = __L1.world.boss
        if __le(b.hp, 0) then
            return
        end
        b.hp = math.max(
            0,
            b.hp - math.floor(n * (b.state == "recover" and 1 or 0.5) + 0.5)
        )
        b.hit = 0.12
        __L1:fx(b.x, b.y - 38, from == 0 and "#f7dda0" or "#b4ebdf", 5)
    end
    __L1.firePlayer = function(self, p)
        if __t(__gt(p.paperCD, 0) or __le(p.hp, 0)) then
            return
        end
        p.paperCD = 0.23
        p.attack = 0.24
        p.attackKind = "paper"
        local b = __L1.world.boss
        local aim = math.atan(
            b.y - 38 - (p.y - 32),
            math.abs(b.x - p.x)
        )
        local ____call_443 = __call
        local ____L1_world_shots_442 = __L1.world.shots
        local ____L1_world_439, ____nextShot_440 = __L1.world, "nextShot"
        local ____L1_world_nextShot_441 = ____L1_world_439[____nextShot_440]
        ____L1_world_439[____nextShot_440] = ____L1_world_nextShot_441 + 1
        ____call_443(
            ____L1_world_shots_442,
            "push",
            {
                id = ____L1_world_nextShot_441,
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
        local ____t_447 = __t
        local ____t_result_446
        local ____t_445 = __t
        local ____temp_444 = __gt(p.fartCD, 0) or __lt(p.gas, 20)
        __O[3155] = ____temp_444
        if ____t_445(____temp_444) then
            ____t_result_446 = __O[3155]
        else
            ____t_result_446 = __le(p.hp, 0)
        end
        if ____t_447(____t_result_446) then
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
        __L1:fx(
            p.x,
            p.y - 24,
            __t(p.id) and "#9bdcd8" or "#e9d9a0",
            12
        )
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
            local ____set_452 = __set
            local ____p_451 = p
            local ____t_result_450
            local ____t_449 = __t
            local ____get_result_448 = __get(p, timer)
            __O[3156] = ____get_result_448
            if ____t_449(____get_result_448) then
                ____t_result_450 = __O[3156]
            else
                ____t_result_450 = 0
            end
            ____set_452(
                ____p_451,
                timer,
                math.max(0, ____t_result_450 - dt)
            )
        end
        if __le(p.hp, 0) then
            return
        end
        local dir = (__t(i.right) and 1 or 0) - (__t(i.left) and 1 or 0)
        p.moveX = dir
        if __t(dir) then
            p.facing = dir
        end
        local ____gt_454 = __gt
        local ____t_result_453
        if __t(i.dash) then
            ____t_result_453 = i.dash
        else
            ____t_result_453 = 0
        end
        local dashPressed = ____gt_454(____t_result_453, p.used.dash)
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
            local step = (__t(dir) and 1700 or 2100) * dt
            p.vx = p.vx + __L1:clamp(target - p.vx, -step, step)
        end
        local ____gt_456 = __gt
        local ____t_result_455
        if __t(i.jumpPress) then
            ____t_result_455 = i.jumpPress
        else
            ____t_result_455 = 0
        end
        local jumpPressed = ____gt_456(____t_result_455, p.used.jumpPress)
        local ____p_used_459 = p.used
        local ____p_used_jumpPress_458 = p.used.jumpPress
        local ____t_result_457
        if __t(i.jumpPress) then
            ____t_result_457 = i.jumpPress
        else
            ____t_result_457 = 0
        end
        ____p_used_459.jumpPress = math.max(____p_used_jumpPress_458, ____t_result_457)
        local ____t_464 = __t
        local ____t_result_463
        local ____t_462 = __t
        local ____t_result_461
        if __t(jumpPressed) then
            ____t_result_461 = jumpPressed
        else
            local ____t_result_460
            if __t(i.jump) then
                ____t_result_460 = not __t(p.lastJump)
            else
                ____t_result_460 = i.jump
            end
            ____t_result_461 = ____t_result_460
        end
        __O[3157] = ____t_result_461
        if ____t_462(____t_result_461) then
            ____t_result_463 = p.ground
        else
            ____t_result_463 = __O[3157]
        end
        if ____t_464(____t_result_463) then
            p.vy = -370
            p.ground = false
        end
        local ____t_468 = __t
        local ____t_result_467
        local ____t_466 = __t
        local ____t_result_465
        if __t(i.jump) then
            ____t_result_465 = not __t(p.ground)
        else
            ____t_result_465 = i.jump
        end
        __O[3158] = ____t_result_465
        if ____t_466(____t_result_465) then
            ____t_result_467 = __gt(p.gas, 0)
        else
            ____t_result_467 = __O[3158]
        end
        if ____t_468(____t_result_467) then
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
                local ____t_474 = __t
                local ____t_result_473
                local ____t_472 = __t
                local ____t_result_471
                local ____t_470 = __t
                local ____temp_469 = __gt(p.x, x - 10) and __lt(p.x, x + w + 10)
                __O[3159] = ____temp_469
                if ____t_470(____temp_469) then
                    ____t_result_471 = __le(oldY, y + 3)
                else
                    ____t_result_471 = __O[3159]
                end
                __O[3160] = ____t_result_471
                if ____t_472(____t_result_471) then
                    ____t_result_473 = __ge(p.y, y)
                else
                    ____t_result_473 = __O[3160]
                end
                if ____t_474(____t_result_473) then
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
        local ____p_476 = p
        local ____t_result_475
        if __t(i.seq) then
            ____t_result_475 = i.seq
        else
            ____t_result_475 = 0
        end
        ____p_476.ackSeq = ____t_result_475
    end
    __L1.consume = function(self, p, i)
        for ____, action in __iterar((__arrL({"paper", "fart"}, 2))) do
            local ____t_result_479
            local ____t_478 = __t
            local ____get_result_477 = __get(i, action)
            __O[3161] = ____get_result_477
            if ____t_478(____get_result_477) then
                ____t_result_479 = __O[3161]
            else
                ____t_result_479 = 0
            end
            local value = math.max(
                0,
                math.floor(____t_result_479)
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
            p.down = p.down - dt * (__t(__gt(helper.hp, 0) and math.abs(helper.x - p.x) < 100) and 2 or 1)
            if __t(__le(p.down, 0) and __gt(helper.hp, 0)) then
                p.hp = 90
                p.inv = 2
                p.gas = 100
                p.y = __L1.FLOOR
                local ____p_480 = p
                p.vy = 0
                ____p_480.vx = 0
                p.ground = true
                __L1:fx(p.x, p.y - 25, "#c2ead8", 12)
            end
            return
        end
        local dashed = p.used.dash
        __L1:advanceMotion(p, i, dt)
        if __t(__gt(p.used.dash, dashed) and __gt(p.dashTime, 0)) then
            __L1:fx(
                p.x,
                p.y - 24,
                __t(p.id) and "#9bdcd8" or "#e9d9a0",
                6
            )
        end
        __L1:consume(p, i)
        local ____t_484 = __t
        local ____t_result_483
        local ____t_482 = __t
        local ____temp_481 = __gt(p.dashTime, 0) and math.abs(p.x - __L1.world.boss.x) < 50
        __O[3162] = ____temp_481
        if ____t_482(____temp_481) then
            ____t_result_483 = math.abs(p.y - __L1.world.boss.y) < 80
        else
            ____t_result_483 = __O[3162]
        end
        if ____t_484(____t_result_483) then
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
        local ____t_488 = __t
        local ____t_result_487
        local ____t_486 = __t
        local ____temp_485 = not __t(__L1.predicted) or __le(__L1.predicted.hp, 0) ~= __le(authoritative.hp, 0)
        __O[3163] = ____temp_485
        if ____t_486(____temp_485) then
            ____t_result_487 = __O[3163]
        else
            ____t_result_487 = __hypot(__L1.predicted.x - authoritative.x, __L1.predicted.y - authoritative.y) > 300
        end
        if ____t_488(____t_result_487) then
            __L1.predicted = __L1:clonePlayer(authoritative)
            __L1.predictionTarget = nil
            return
        end
        local ____L1_clamp_491 = __L1.clamp
        local ____temp_490 = __L1:serverNow()
        local ____t_result_489
        if __t(__L1.world.serverTime) then
            ____t_result_489 = __L1.world.serverTime
        else
            ____t_result_489 = __L1:serverNow()
        end
        local age = ____L1_clamp_491(__L1, (____temp_490 - ____t_result_489) / 1000, 0, 0.3)
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
        local direction = (__t(command.right) and 1 or 0) - (__t(command.left) and 1 or 0)
        local ____t_result_494
        local ____t_493 = __t
        local ____TS__Number_result_492 = __TS__Number(authoritative.moveX)
        __O[3164] = ____TS__Number_result_492
        if ____t_493(____TS__Number_result_492) then
            ____t_result_494 = __O[3164]
        else
            ____t_result_494 = 0
        end
        __L1.predictionTarget = {
            player = target,
            pendingMove = direction ~= ____t_result_494,
            pendingJump = pendingJump,
            pendingDash = pendingDash,
            at = window.performance:now()
        }
        __L1.predicted.hp = authoritative.hp
        __L1.predicted.max = authoritative.max
        __L1.predicted.down = authoritative.down
        __L1.predicted.inv = math.max(__L1.predicted.inv, authoritative.inv)
        local ____L1_predicted_495, ____gas_496 = __L1.predicted, "gas"
        ____L1_predicted_495[____gas_496] = ____L1_predicted_495[____gas_496] + (authoritative.gas - __L1.predicted.gas) * 0.25
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
        local ____t_500 = __t
        local ____t_result_499
        local ____t_498 = __t
        local ____temp_497 = not __t(__L1.world) or __L1.role ~= "guest"
        __O[3165] = ____temp_497
        if ____t_498(____temp_497) then
            ____t_result_499 = __O[3165]
        else
            ____t_result_499 = __L1.world.stage ~= "playing"
        end
        if ____t_500(____t_result_499) then
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
                local ____L1_predicted_501, ____gas_502 = __L1.predicted, "gas"
                ____L1_predicted_501[____gas_502] = ____L1_predicted_501[____gas_502] - 20
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
            local ____temp_506 = (__t(command.right) and 1 or 0) - (__t(command.left) and 1 or 0)
            local ____t_result_505
            local ____t_504 = __t
            local ____TS__Number_result_503 = __TS__Number(authority.moveX)
            __O[3166] = ____TS__Number_result_503
            if ____t_504(____TS__Number_result_503) then
                ____t_result_505 = __O[3166]
            else
                ____t_result_505 = 0
            end
            local pendingMove = ____temp_506 ~= ____t_result_505
            local pendingJump = __gt(command.jumpPress, authority.used.jumpPress)
            local pendingDash = __gt(command.dash, authority.used.dash)
            local blend = 1 - math.exp(-8 * dt)
            local step = 80 * dt
            if __t(not __t(pendingMove) and not __t(pendingDash)) then
                local ____L1_predicted_507, ____x_508 = __L1.predicted, "x"
                ____L1_predicted_507[____x_508] = ____L1_predicted_507[____x_508] + __L1:clamp((t.x - __L1.predicted.x) * blend, -step, step)
            end
            if __t(not __t(pendingJump) and not __t(pendingDash)) then
                local ____L1_predicted_509, ____y_510 = __L1.predicted, "y"
                ____L1_predicted_509[____y_510] = ____L1_predicted_509[____y_510] + __L1:clamp((t.y - __L1.predicted.y) * blend, -step, step)
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
        local ____t_516 = __t
        local ____t_result_515
        local ____t_514 = __t
        local ____t_result_513
        local ____t_512 = __t
        local ____temp_511 = index == 1
        __O[3167] = ____temp_511
        if ____t_512(____temp_511) then
            ____t_result_513 = __L1.predicted
        else
            ____t_result_513 = __O[3167]
        end
        __O[3168] = ____t_result_513
        if ____t_514(____t_result_513) then
            ____t_result_515 = __L1.world.stage == "playing"
        else
            ____t_result_515 = __O[3168]
        end
        if ____t_516(____t_result_515) then
            return __assign({}, p, __L1.predicted)
        end
        local age = __L1:clamp(
            (window.performance:now() - __L1.lastStateAt) / 1000,
            0,
            0.18
        )
        local x = __L1:clamp(p.x + p.vx * age, 30, 930)
        local ____t_result_517
        if __t(p.ground) then
            ____t_result_517 = p.y
        else
            ____t_result_517 = __L1:clamp(p.y + p.vy * age, 70, __L1.FLOOR)
        end
        local y = ____t_result_517
        local ____t_result_520
        local ____t_519 = __t
        local ____get_result_518 = __get(__L1.smoothedPlayers, index)
        __O[3169] = ____get_result_518
        if ____t_519(____get_result_518) then
            ____t_result_520 = __O[3169]
        else
            ____t_result_520 = {x = x, y = y}
        end
        local old = ____t_result_520
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
        b.phase = b.hp / b.max > 0.66 and 1 or (b.hp / b.max > 0.33 and 2 or 3)
        local ____temp_522
        if __L1.world.wave == 0 then
            ____temp_522 = __arrL({"fan", "ring", "dash", "rain"}, 4)
        else
            local ____temp_521
            if __L1.world.wave == 1 then
                ____temp_521 = __arrL({"ring", "fan", "teleport", "rain"}, 4)
            else
                ____temp_521 = __arrL({"fan", "rain", "dash", "ring"}, 4)
            end
            ____temp_522 = ____temp_521
        end
        local patterns = ____temp_522
        local ____get_527 = __get
        local ____mod_526 = __mod
        local ____b_523, ____pattern_524 = b, "pattern"
        local ____b_pattern_525 = ____b_523[____pattern_524]
        ____b_523[____pattern_524] = ____b_pattern_525 + 1
        b.kind = ____get_527(
            patterns,
            ____mod_526(
                ____b_pattern_525,
                __len(patterns)
            )
        )
        local living = __call(
            __L1.world.players,
            "filter",
            function(____, p) return __gt(p.hp, 0) end
        )
        local ____t_result_530
        local ____t_529 = __t
        local ____get_result_528 = __get(
            living,
            __mod(
                b.pattern - 1,
                __len(living)
            )
        )
        __O[3170] = ____get_result_528
        if ____t_529(____get_result_528) then
            ____t_result_530 = __O[3170]
        else
            ____t_result_530 = __get(__L1.world.players, 0)
        end
        local target = ____t_result_530
        b.targetX = target.x
        b.targetY = target.y - 30
        local ____t_result_533
        local ____t_532 = __t
        local ____TS__MathSign_result_531 = __TS__MathSign(target.x - b.x)
        __O[3171] = ____TS__MathSign_result_531
        if ____t_532(____TS__MathSign_result_531) then
            ____t_result_533 = __O[3171]
        else
            ____t_result_533 = -1
        end
        b.dir = ____t_result_533
        b.state = "windup"
        b.timer = 1 - (b.phase - 1) * 0.12
        b.duration = b.timer
        if b.kind == "teleport" then
            b.exitX = __lt(target.x, 480) and 780 or 180
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
            local aim = math.atan(b.targetY - (b.y - 42), b.targetX - b.x)
            do
                local i = 0
                while i < count do
                    local a = aim + (i - (count - 1) / 2) * 0.14
                    local ____call_538 = __call
                    local ____L1_world_shots_537 = __L1.world.shots
                    local ____L1_world_534, ____nextShot_535 = __L1.world, "nextShot"
                    local ____L1_world_nextShot_536 = ____L1_world_534[____nextShot_535]
                    ____L1_world_534[____nextShot_535] = ____L1_world_nextShot_536 + 1
                    ____call_538(
                        ____L1_world_shots_537,
                        "push",
                        {
                            id = ____L1_world_nextShot_536,
                            owner = "enemy",
                            x = b.x,
                            y = b.y - 42,
                            vx = math.cos(a) * ((210 + b.phase * 15) * 1.18),
                            vy = math.sin(a) * ((210 + b.phase * 15) * 1.18),
                            life = 4,
                            r = 9,
                            damage = 18,
                            type = __L1.world.wave == 2 and "slime" or (__L1.world.wave == 1 and "word" or "ink")
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
                    local ____t_result_539
                    if __t(p.id) then
                        ____t_result_539 = __L1.remoteInput
                    else
                        ____t_result_539 = __L1:getLocalInput()
                    end
                    local command = ____t_result_539
                    for ____, action in __iterar((__arrL({"paper", "fart", "dash", "jumpPress"}, 4))) do
                        local ____set_544 = __set
                        local ____p_used_543 = p.used
                        local ____t_result_542
                        local ____t_541 = __t
                        local ____get_result_540 = __get(command, action)
                        __O[3172] = ____get_result_540
                        if ____t_541(____get_result_540) then
                            ____t_result_542 = __O[3172]
                        else
                            ____t_result_542 = 0
                        end
                        ____set_544(____p_used_543, action, ____t_result_542)
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
                        p.x = __t(p.id) and 350 or 210
                        p.y = __L1.FLOOR
                        local ____p_545 = p
                        p.vy = 0
                        ____p_545.vx = 0
                    end
                )
            end
            return
        end
        local ____local = __L1:getLocalInput()
        local ____temp_546
        if window.performance:now() - __L1.inputAt < 5000 then
            ____temp_546 = __L1.remoteInput
        else
            ____temp_546 = __assign({}, __L1.remoteInput, {left = false, right = false, jump = false})
        end
        local remote = ____temp_546
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
                __L1:damagePlayer(p, b.state == "dash" and 31 or 13, b.x)
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
                    local ____t_result_553
                    local ____t_552 = __t
                    local ____t_result_551
                    local ____t_550 = __t
                    local ____t_result_549
                    local ____t_548 = __t
                    local ____temp_547 = __gt(s.life, 0) and __gt(s.x, -30)
                    __O[3173] = ____temp_547
                    if ____t_548(____temp_547) then
                        ____t_result_549 = __lt(s.x, 990)
                    else
                        ____t_result_549 = __O[3173]
                    end
                    __O[3174] = ____t_result_549
                    if ____t_550(____t_result_549) then
                        ____t_result_551 = __gt(s.y, -30)
                    else
                        ____t_result_551 = __O[3174]
                    end
                    __O[3175] = ____t_result_551
                    if ____t_552(____t_result_551) then
                        ____t_result_553 = __lt(s.y, 570)
                    else
                        ____t_result_553 = __O[3175]
                    end
                    return ____t_result_553
                end
            ),
            "slice",
            -56
        )
        for ____, h in __iterar((w.hazards)) do
            do
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
        local ____t_556 = __t
        local ____opt_554 = window.Art
        if ____opt_554 ~= nil then
            ____opt_554 = ____opt_554.drawArena
        end
        if ____t_556(____opt_554) then
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
            local ____t_559 = __t
            local ____opt_557 = window.Art
            if ____opt_557 ~= nil then
                ____opt_557 = ____opt_557.drawPlatform
            end
            if ____t_559(____opt_557) then
                window.Art:drawPlatform(
                    c,
                    x,
                    y,
                    width,
                    w.wave == 0 and "doodles" or (w.wave == 1 and "words" or "court")
                )
            end
        end
        for ____, h in __iterar((w.hazards)) do
            if h.kind == "ring" then
                c:save()
                c.strokeStyle = __gt(h.delay, 0) and "#f4c084" or "#f6e3a0"
                c.lineWidth = 6
                c.globalAlpha = __gt(h.delay, 0) and 0.45 or 0.9
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
                c.fillStyle = __gt(h.delay, 0) and "#efb77866" or "#d4e58eaa"
                local ____c_fillRect_562 = c.fillRect
                local ____temp_561 = h.x - h.r
                local ____gt_result_560
                if __gt(h.delay, 0) then
                    ____gt_result_560 = __L1.FLOOR - 8
                else
                    ____gt_result_560 = 95
                end
                ____c_fillRect_562(
                    c,
                    ____temp_561,
                    ____gt_result_560,
                    h.r * 2,
                    __gt(h.delay, 0) and 8 or __L1.FLOOR - 95
                )
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
                local ____c_lineTo_565 = c.lineTo
                local ____temp_563
                if b.kind == "teleport" then
                    ____temp_563 = b.exitX
                else
                    ____temp_563 = b.targetX
                end
                local ____t_result_564
                if __t(b.kind == "dash" or b.kind == "teleport") then
                    ____t_result_564 = __L1.FLOOR - 8
                else
                    ____t_result_564 = b.targetY
                end
                ____c_lineTo_565(c, ____temp_563, ____t_result_564)
                c:stroke()
                c:restore()
                __L1:text(
                    c,
                    b.kind == "ring" and "PULEM A ONDA!" or (b.kind == "rain" and "SAIAM DAS MARCAS!" or (b.kind == "teleport" and "OLHEM A SAÍDA!" or (b.kind == "dash" and "DASH PARA DESVIAR!" or "ATAQUE CARREGANDO!"))),
                    b.x,
                    b.y - 112,
                    13,
                    "#ffdda4"
                )
            end
            local ____t_568 = __t
            local ____opt_566 = window.Art
            if ____opt_566 ~= nil then
                ____opt_566 = ____opt_566.drawCharacter
            end
            if ____t_568(____opt_566) then
                window.Art:drawCharacter(
                    c,
                    b.type,
                    b.x,
                    b.y,
                    {
                        facing = __lt(
                            __get(w.players, 0).x,
                            b.x
                        ) and -1 or 1,
                        frame = w.time,
                        scale = 1.25,
                        moving = b.state == "dash",
                        dash = b.state == "dash",
                        speed = b.state == "dash" and 620 or 0,
                        attack = b.state == "windup" or b.state == "fire",
                        attackType = b.type == "nikolas" and "slime" or (b.type == "marco" and "doodle" or "word"),
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
                c.fillStyle = s.owner == 0 and "#fff0c5" or "#b7f2e7"
                c:fillRect(-6, -6, 12, 12)
                c.fillStyle = "#7a9080"
                c:fillRect(-3, -3, 5, 2)
            else
                c.fillStyle = s.type == "slime" and "#c6df7d" or (s.type == "word" and "#e9bfd8" or "#cbace0")
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
                    local ____t_571 = __t
                    local ____opt_569 = window.Art
                    if ____opt_569 ~= nil then
                        ____opt_569 = ____opt_569.drawCharacter
                    end
                    if ____t_571(____opt_569) then
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
                    local ____t_575 = __t
                    local ____t_result_574
                    local ____t_573 = __t
                    local ____gt_result_572 = __gt(p.inv, 0)
                    __O[3176] = ____gt_result_572
                    if ____t_573(____gt_result_572) then
                        ____t_result_574 = __mod(
                            math.floor(w.time * 14),
                            2
                        )
                    else
                        ____t_result_574 = __O[3176]
                    end
                    if ____t_575(____t_result_574) then
                        c.globalAlpha = 0.6
                    end
                    local ____t_578 = __t
                    local ____opt_576 = window.Art
                    if ____opt_576 ~= nil then
                        ____opt_576 = ____opt_576.drawCharacter
                    end
                    if ____t_578(____opt_576) then
                        local ____self_594 = window.Art
                        local ____self_594_drawCharacter_595 = ____self_594.drawCharacter
                        local ____x_592 = x
                        local ____y_593 = y
                        local ____p_facing_582 = p.facing
                        local ____p_anim_583 = p.anim
                        local ____temp_584 = math.abs(p.vx) > 8
                        local ____math_abs_result_585 = math.abs(p.vx)
                        local ____p_ground_586 = p.ground
                        local ____p_vy_587 = p.vy
                        local ____gt_result_588 = __gt(p.attack, 0)
                        local ____p_attackKind_589 = p.attackKind
                        local ____temp_590 = __L1:clamp(1 - p.attack / 0.24, 0, 1)
                        local ____gt_result_591 = __gt(p.dashTime, 0)
                        local ____t_result_581
                        local ____t_580 = __t
                        local ____temp_579 = not __t(p.ground) and __gt(p.gas, 0)
                        __O[3177] = ____temp_579
                        if ____t_580(____temp_579) then
                            ____t_result_581 = math.abs(p.vy) < 240
                        else
                            ____t_result_581 = __O[3177]
                        end
                        ____self_594_drawCharacter_595(
                            ____self_594,
                            c,
                            "daroca",
                            ____x_592,
                            ____y_593,
                            {
                                facing = ____p_facing_582,
                                frame = ____p_anim_583,
                                scale = 1,
                                moving = ____temp_584,
                                speed = ____math_abs_result_585,
                                grounded = ____p_ground_586,
                                vy = ____p_vy_587,
                                attack = ____gt_result_588,
                                attackType = ____p_attackKind_589,
                                attackProgress = ____temp_590,
                                dash = ____gt_result_591,
                                flight = ____t_result_581
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
                    __t(index) and "PARCEIRO · 2" or "DA ROÇA · 1",
                    x,
                    y - 88,
                    11,
                    __t(index) and "#b9f4ed" or "#ffe1a2"
                )
                __L1:bar(
                    c,
                    x - 32,
                    y - 76,
                    64,
                    5,
                    p.hp / p.max,
                    __t(index) and "#89d8cf" or "#efb586"
                )
            end
        )
        local ____iter_597 = __iter
        local ____t_result_596
        if __t(w.fx) then
            ____t_result_596 = w.fx
        else
            ____t_result_596 = __arrL({}, 0)
        end
        for ____, f in __TS__Iterator(____iter_597(____t_result_596)) do
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
                w.stage == "victory" and "A DUPLA DOMINOU A RESENHA!" or "A DUPLA CAIU JUNTO!",
                480,
                212,
                24,
                w.stage == "victory" and "#e4eca8" or "#f0b39c"
            )
            __L1:text(
                c,
                w.stage == "victory" and "Três chefões. Dois parceiros. Um papel de respeito." or "Cheguem perto do parceiro caído para ele voltar mais rápido.",
                480,
                253,
                13
            )
            __L1:text(
                c,
                __L1.role == "host" and "Toque em JOGAR NOVAMENTE para outra rodada." or "O amigo que criou a dupla pode reiniciar a rodada.",
                480,
                288,
                13
            )
        end
        __L1["$"](__L1, "coopWaveLabel").textContent = __add(
            __add("CHEFÃO ", w.wave + 1),
            " / 3"
        )
        local ____L1__24_result_602 = __L1["$"](__L1, "coopRestartBtn")
        local ____t_601 = __t
        local ____t_result_600
        local ____t_599 = __t
        local ____temp_598 = __L1.role == "host"
        __O[3178] = ____temp_598
        if ____t_599(____temp_598) then
            ____t_result_600 = __call(
                __arrL({"victory", "defeat"}, 2),
                "includes",
                w.stage
            )
        else
            ____t_result_600 = __O[3178]
        end
        ____L1__24_result_602.hidden = not ____t_601(____t_result_600)
        local stale = __L1.role == "guest" and window.performance:now() - __L1.lastStateAt > 2500
        __L1["$"](__L1, "coopGameNotice").textContent = __t(stale) and "Aguardando o aparelho que criou a dupla…" or (w.stage == "playing" and "Chegue perto do parceiro caído para ele voltar mais rápido." or (w.stage == "intermission" and "Vida e gás renovados para a próxima luta." or "Esta rodada não altera o progresso da campanha."))
    end
    __L1.loop = function(self, now)
        local ____t_result_603
        if __t(__L1.lastFrame) then
            ____t_result_603 = __L1:clamp((now - __L1.lastFrame) / 1000, 0, 0.1)
        else
            ____t_result_603 = 0
        end
        local dt = ____t_result_603
        __L1.lastFrame = now
        local ____t_607 = __t
        local ____t_result_606
        local ____t_605 = __t
        local ____temp_604 = __L1:arenaVisible()
        __O[3179] = ____temp_604
        if ____t_605(____temp_604) then
            ____t_result_606 = __L1.world
        else
            ____t_result_606 = __O[3179]
        end
        if ____t_607(____t_result_606) then
            __L1.accumulator = math.min(__L1.accumulator + dt, __L1.STEP * 6)
            while __L1.accumulator >= __L1.STEP do
                local ____t_611 = __t
                local ____t_result_610
                local ____t_609 = __t
                local ____temp_608 = __L1.role == "host"
                __O[3180] = ____temp_608
                if ____t_609(____temp_608) then
                    ____t_result_610 = __L1:isConnected()
                else
                    ____t_result_610 = __O[3180]
                end
                if ____t_611(____t_result_610) then
                    __L1:simulate(__L1.STEP)
                elseif __L1.role == "guest" then
                    __L1:predictStep(__L1.STEP)
                end
                __L1.accumulator = __L1.accumulator - __L1.STEP
            end
            local ____t_613 = __t
            local ____t_result_612
            if __t(__L1.credentials) then
                ____t_result_612 = now - __L1.sendAt >= 1000 / 30
            else
                ____t_result_612 = __L1.credentials
            end
            if ____t_613(____t_result_612) then
                __L1.sendAt = now
                if __L1.role == "host" then
                    local ____opt_616 = __L1.net
                    if ____opt_616 ~= nil then
                        ____opt_616 = ____opt_616.sendState
                    end
                    if ____opt_616 ~= nil then
                        ____opt_616(
                            ____opt_616,
                            __L1:snapshot()
                        )
                    end
                else
                    local ____opt_620 = __L1.net
                    if ____opt_620 ~= nil then
                        ____opt_620 = ____opt_620.sendInput
                    end
                    if ____opt_620 ~= nil then
                        ____opt_620(
                            ____opt_620,
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
        local ____t_result_626
        local ____t_625 = __t
        local ____t_result_624
        local ____t_623 = __t
        local ____isSafeInteger_result_622 = __isSafeInteger(v)
        __O[3081] = ____isSafeInteger_result_622
        if ____t_623(____isSafeInteger_result_622) then
            ____t_result_624 = __ge(v, 0)
        else
            ____t_result_624 = __O[3081]
        end
        __O[3082] = ____t_result_624
        if ____t_625(____t_result_624) then
            ____t_result_626 = __le(v, 2147483647)
        else
            ____t_result_626 = __O[3082]
        end
        return ____t_result_626
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
    __L1.localSlot = function() return __L1.role == "host" and 0 or 1 end
    __L1.clean = function(____, value, max)
        if max == nil then
            max = 20
        end
        local ____call_630 = __call
        local ____call_629 = __call
        local ____re_replace_628 = __re_replace
        local ____t_result_627
        if __t(value) then
            ____t_result_627 = value
        else
            ____t_result_627 = ""
        end
        return ____call_630(
            ____call_629(
                ____re_replace_628(
                    tostring(____t_result_627),
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
            local ____t_636 = __t
            local ____t_result_635
            local ____t_632 = __t
            local ____temp_631 = not __t(__L1:arenaVisible())
            __O[3153] = ____temp_631
            if ____t_632(____temp_631) then
                ____t_result_635 = __O[3153]
            else
                local ____this_634
                ____this_634 = e.target
                local ____opt_633 = ____this_634.closest
                if ____opt_633 ~= nil then
                    ____opt_633 = ____opt_633(____this_634, "textarea,input")
                end
                ____t_result_635 = ____opt_633
            end
            if ____t_636(____t_result_635) then
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
            local ____t_638 = __t
            local ____t_result_637
            if __t(__L1.input.jump) then
                ____t_result_637 = not __t(wasJump)
            else
                ____t_result_637 = __L1.input.jump
            end
            if ____t_638(____t_result_637) then
                local ____L1_input_639, ____jumpPress_640 = __L1.input, "jumpPress"
                ____L1_input_639[____jumpPress_640] = ____L1_input_639[____jumpPress_640] + 1
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
            local ____t_644 = __t
            local ____t_result_643
            local ____t_642 = __t
            local ____temp_641 = not __t(__L1.opened) or not __t(__L1:arenaVisible())
            __O[3154] = ____temp_641
            if ____t_642(____temp_641) then
                ____t_result_643 = __O[3154]
            else
                ____t_result_643 = not __t(__call(__L1.pressedKeys, "has", e.code))
            end
            if ____t_644(____t_result_643) then
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
                local ____L1_opened_718 = __L1.opened
                local ____L1_currentRole_719 = __L1.currentRole
                local ____temp_720 = __L1:isConnected()
                local ____t_result_648
                local ____t_647 = __t
                local ____opt_645 = __L1.room
                if ____opt_645 ~= nil then
                    ____opt_645 = ____opt_645.code
                end
                __O[3181] = ____opt_645
                if ____t_647(____opt_645) then
                    ____t_result_648 = __O[3181]
                else
                    ____t_result_648 = nil
                end
                local ____t_result_652
                local ____t_651 = __t
                local ____opt_649 = __L1.credentials
                if ____opt_649 ~= nil then
                    ____opt_649 = ____opt_649.playerId
                end
                __O[3182] = ____opt_649
                if ____t_651(____opt_649) then
                    ____t_result_652 = __O[3182]
                else
                    ____t_result_652 = nil
                end
                local ____t_result_656
                local ____t_655 = __t
                local ____opt_653 = __L1.room
                if ____opt_653 ~= nil then
                    ____opt_653 = ____opt_653.hostPlayerId
                end
                __O[3183] = ____opt_653
                if ____t_655(____opt_653) then
                    ____t_result_656 = __O[3183]
                else
                    ____t_result_656 = nil
                end
                local ____gt_662 = __gt
                local ____opt_659 = __L1.net
                if ____opt_659 ~= nil then
                    ____opt_659 = ____opt_659.getStatus
                end
                local ____opt_result_661
                if ____opt_659 ~= nil then
                    ____opt_result_661 = ____opt_659(____opt_659).connected
                end
                local ____temp_721 = ____gt_662(____opt_result_661, 0) and "webrtc+https" or "https-cloud"
                local ____temp_722 = __t(__L1.credentials) and "connected" or "closed"
                local ____opt_665 = __L1.net
                if ____opt_665 ~= nil then
                    ____opt_665 = ____opt_665.getStatus
                end
                local ____opt_result_667
                if ____opt_665 ~= nil then
                    ____opt_result_667 = ____opt_665(____opt_665).pingMs
                end
                local ____opt_result_667_668 = ____opt_result_667
                if ____opt_result_667_668 == nil then
                    ____opt_result_667_668 = __L1.rttMs
                end
                local ____math_floor_result_723 = math.floor(____opt_result_667_668 + 0.5)
                local ____t_result_675
                local ____t_674 = __t
                local ____opt_671 = __L1.net
                if ____opt_671 ~= nil then
                    ____opt_671 = ____opt_671.getStatus
                end
                local ____opt_result_673
                if ____opt_671 ~= nil then
                    ____opt_result_673 = ____opt_671(____opt_671)
                end
                __O[3184] = ____opt_result_673
                if ____t_674(____opt_result_673) then
                    ____t_result_675 = __O[3184]
                else
                    ____t_result_675 = nil
                end
                local ____t_result_679
                local ____t_678 = __t
                local ____opt_676 = __L1.world
                if ____opt_676 ~= nil then
                    ____opt_676 = ____opt_676.stage
                end
                __O[3185] = ____opt_676
                if ____t_678(____opt_676) then
                    ____t_result_679 = __O[3185]
                else
                    ____t_result_679 = nil
                end
                local ____opt_680 = __L1.world
                if ____opt_680 ~= nil then
                    ____opt_680 = ____opt_680.wave
                end
                local ____opt_680_682 = ____opt_680
                if ____opt_680_682 == nil then
                    ____opt_680_682 = nil
                end
                local ____t_result_686
                local ____t_685 = __t
                local ____opt_683 = __L1.world
                if ____opt_683 ~= nil then
                    ____opt_683 = ____opt_683.matchId
                end
                __O[3186] = ____opt_683
                if ____t_685(____opt_683) then
                    ____t_result_686 = __O[3186]
                else
                    ____t_result_686 = nil
                end
                local ____opt_687 = __L1.world
                if ____opt_687 ~= nil then
                    ____opt_687 = ____opt_687.seq
                end
                local ____opt_687_689 = ____opt_687
                if ____opt_687_689 == nil then
                    ____opt_687_689 = nil
                end
                local ____t_result_700
                local ____t_699 = __t
                local ____callq_697 = __callq
                local ____opt_690 = __L1.world
                if ____opt_690 ~= nil then
                    ____opt_690 = ____opt_690.players
                end
                local ____callq_697_result_698 = ____callq_697(
                    ____opt_690,
                    "map",
                    function(____, p, index)
                        local ____t_result_696
                        local ____t_695 = __t
                        local ____t_result_694
                        local ____t_693 = __t
                        local ____temp_692 = __L1.role == "guest" and index == 1
                        __O[3187] = ____temp_692
                        if ____t_693(____temp_692) then
                            ____t_result_694 = __L1.predicted
                        else
                            ____t_result_694 = __O[3187]
                        end
                        if ____t_695(____t_result_694) then
                            ____t_result_696 = __L1.predicted
                        else
                            ____t_result_696 = p
                        end
                        local visible = ____t_result_696
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
                __O[3188] = ____callq_697_result_698
                if ____t_699(____callq_697_result_698) then
                    ____t_result_700 = __O[3188]
                else
                    ____t_result_700 = __arrL({}, 0)
                end
                local ____t_result_706
                local ____t_705 = __t
                local ____callq_703 = __callq
                local ____opt_701 = __L1.world
                if ____opt_701 ~= nil then
                    ____opt_701 = ____opt_701.players
                end
                local ____callq_703_result_704 = ____callq_703(
                    ____opt_701,
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
                __O[3189] = ____callq_703_result_704
                if ____t_705(____callq_703_result_704) then
                    ____t_result_706 = __O[3189]
                else
                    ____t_result_706 = __arrL({}, 0)
                end
                local ____t_result_710
                local ____t_709 = __t
                local ____opt_707 = __L1.world
                if ____opt_707 ~= nil then
                    ____opt_707 = ____opt_707.boss
                end
                if ____t_709(____opt_707) then
                    ____t_result_710 = {type = __L1.world.boss.type, hp = __L1.world.boss.hp, max = __L1.world.boss.max, state = __L1.world.boss.state}
                else
                    ____t_result_710 = nil
                end
                local ____t_result_716
                local ____t_715 = __t
                local ____lenq_713 = __lenq
                local ____opt_711 = __L1.world
                if ____opt_711 ~= nil then
                    ____opt_711 = ____opt_711.shots
                end
                local ____lenq_713_result_714 = ____lenq_713(____opt_711)
                __O[3190] = ____lenq_713_result_714
                if ____t_715(____lenq_713_result_714) then
                    ____t_result_716 = __O[3190]
                else
                    ____t_result_716 = 0
                end
                local ____temp_724 = {left = __L1.input.left, right = __L1.input.right, jump = __L1.input.jump}
                local ____temp_725 = {jumpPress = __L1.input.jumpPress, paper = __L1.input.paper, fart = __L1.input.fart, dash = __L1.input.dash}
                local ____t_result_717
                if __t(__L1.world) then
                    ____t_result_717 = __len(window.JSON:stringify(__assign(
                        {},
                        __L1.world,
                        {fx = __arrL({}, 0)}
                    )))
                else
                    ____t_result_717 = 0
                end
                return {
                    open = ____L1_opened_718,
                    role = ____L1_currentRole_719,
                    connected = ____temp_720,
                    roomCode = ____t_result_648,
                    playerId = ____t_result_652,
                    hostPlayerId = ____t_result_656,
                    transport = ____temp_721,
                    connectionState = ____temp_722,
                    pingMs = ____math_floor_result_723,
                    network = ____t_result_675,
                    stage = ____t_result_679,
                    wave = ____opt_680_682,
                    matchId = ____t_result_686,
                    stateSeq = ____opt_687_689,
                    players = ____t_result_700,
                    authoritativePlayers = ____t_result_706,
                    boss = ____t_result_710,
                    shotCount = ____t_result_716,
                    held = ____temp_724,
                    counters = ____temp_725,
                    snapshotBytes = ____t_result_717
                }
            end
        },
        "open,close,getStatus"
    )
end)(nil)
return ____exports
