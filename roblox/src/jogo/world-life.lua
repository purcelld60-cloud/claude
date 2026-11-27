--!native
--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __gt, __ge, __isFiniteN, __getq, __mod, __ord, __arrL, __iterar, __t, __get, __set = __JSR.__lt, __JSR.__gt, __JSR.__ge, __JSR.__isFiniteN, __JSR.__getq, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set
local __arr, __len, __call, __add, __iter, __assign, __isArray, __arrayFrom = __JSR.__arr, __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__iter, __JSR.__assign, __JSR.__isArray, __JSR.__arrayFrom
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__Number = ____lualib.__TS__Number
local __TS__Spread = ____lualib.__TS__Spread
local ____exports = {}
local __O = {};
(function()
    local count, node, text, save, close, vendorPlan, prepareVendor, reward, activate, makeChoices, nextSequence, finish, pumpHit, choice, rect, label, drawModal, drawProp, clamp, FLOOR, order, modal, session, frame
    function count(self, value)
        local ____t_7 = __t
        local ____TS__Number_result_6 = __TS__Number(value)
        __O[1415] = ____TS__Number_result_6
        return clamp(
            nil,
            math.floor(if ____t_7(____TS__Number_result_6) then __O[1415] else 0),
            0,
            999999
        )
    end
    function node(self, id)
        return modal:querySelector(__add("#", id))
    end
    function text(self, id, value)
        node(nil, id).textContent = value
    end
    function save(self)
        local ____this_32
        local ____opt_33 = session
        if ____opt_33 ~= nil then
            ____this_32 = ____opt_33.api
            ____opt_33 = ____this_32.save
        end
        if ____opt_33 ~= nil then
            ____opt_33(____this_32)
        end
        local ____this_36
        local ____opt_37 = session
        if ____opt_37 ~= nil then
            ____this_36 = ____opt_37.api
            ____opt_37 = ____this_36.updateUI
        end
        if ____opt_37 ~= nil then
            ____opt_37(____this_36)
        end
    end
    function close(self)
        if not __t(session) then
            return false
        end
        local old = session
        session = nil
        window:cancelAnimationFrame(frame)
        if modal ~= nil then
            modal:close()
        end
        local ____opt_57 = window.Game
        if ____opt_57 ~= nil then
            ____opt_57 = ____opt_57.releaseInputs
        end
        if ____opt_57 ~= nil then
            ____opt_57(____opt_57)
        end
        if not __t(old.wasPaused) then
            local ____opt_61 = window.Game
            if ____opt_61 ~= nil then
                ____opt_61 = ____opt_61.resume
            end
            if ____opt_61 ~= nil then
                ____opt_61(____opt_61)
            end
        else
            local ____opt_63 = window.document:getElementById("pauseBtn")
            if ____opt_63 ~= nil then
                ____opt_63:focus({preventScroll = true})
            end
        end
        return true
    end
    function vendorPlan(self, s)
        return if s.prop.id == "zefa" then {
            id = "zefa",
            requirements = __arrL({"pump-roca", "fruit-roca"}, 2),
            xp = 230,
            items = 3,
            title = "Água e fruta para o pomar",
            intro = "Ô meu filho, voar no gás não rega o pomar! Resolve a bomba ali atrás e confere meu caixote de frutas. Depois te pago em experiência e material pra Kauã.",
            pending = "O pomar ainda precisa de você: conclua a bomba de água e confira o caixote de frutas. O chapéu não pode fazer tudo sozinho!",
            done = "Aí sim! Água no pomar, fruta no caixote e esse menino prestando serviço. Seu prêmio tá separado; o bolo continua por sua conta.",
            after = __arrL({"Esse chapéu pegou sol ou veio com iluminação própria, menino?", "O pomar tá em dia. Se Nikolas aparecer pedindo bolo, hoje só vendo goiaba!", "Quem voa no gás chega rápido, mas quem ajuda na roça sai com história."}, 3)
        } else {
            id = "tonico",
            requirements = __arrL({"switch-camacan", "sort-patio"}, 2),
            xp = 270,
            items = 4,
            title = "Circuito limpo, praça acesa",
            intro = "Sou Tonico, conserto de rádio a ideia torta. Me ajuda com as luzes da Praça Camacan e com o mutirão do pátio. A cidade precisa de brilho sem lixo no chão.",
            pending = "Tô esperando duas notícias: luzes da Camacan funcionando e coleta do pátio concluída. A resenha anda melhor com caminho limpo.",
            done = "Ligou as luzes e organizou o recreio? Rapaz, tu é bivolt até sem energético! Pega o pagamento e leva esses materiais pro inventor.",
            after = __arrL({"Davi corta cabelo; eu corto curto-circuito. Cada um com seu talento.", "Esse carro a gás tá fazendo barulho de geladeira tocando piseiro. Depois eu olho!", "Não conserto nariz de batata. Isso aí já é projeto do fabricante."}, 3)
        }
    end
    function prepareVendor(self)
        local s = session
        local p = vendorPlan(nil, s)
        local ____t_66 = __t
        local ____get_result_65 = __get(s.progress.quests, p.id)
        __O[1420] = ____get_result_65
        local quest = if ____t_66(____get_result_65) then __O[1420] else {}
        s.plan = p
        if __t(quest.done) then
            text(
                nil,
                "worldLifeInstructions",
                __get(
                    p.after,
                    __mod(
                        __get(s.progress.visits, s.prop.id) - 1,
                        __len(p.after)
                    )
                )
            )
            node(nil, "worldLifeAction").hidden = true
        elseif not __t(quest.accepted) then
            text(nil, "worldLifeInstructions", p.intro)
            text(
                nil,
                "worldLifeMessage",
                __add(
                    __add(
                        __add(
                            __add(
                                __add(p.title, " · "),
                                p.xp
                            ),
                            " XP + "
                        ),
                        p.items
                    ),
                    " materiais"
                )
            )
            node(nil, "worldLifeAction").textContent = "ACEITAR PEDIDO"
        else
            local done = __call(
                p.requirements,
                "filter",
                function(____, id)
                    local ____t_68 = __t
                    local ____get_result_67 = __get(s.progress.completed, id)
                    __O[1421] = ____get_result_67
                    return if ____t_68(____get_result_67) then __O[1421] else __get(s.progress.inspected, id)
                end
            )
            local ready = __len(done) == __len(p.requirements)
            text(nil, "worldLifeInstructions", if __t(ready) then p.done else p.pending)
            text(
                nil,
                "worldLifeMessage",
                __add(
                    __add(
                        __add(
                            __len(done),
                            " / "
                        ),
                        __len(p.requirements)
                    ),
                    " tarefas concluídas"
                )
            )
            node(nil, "worldLifeAction").hidden = not __t(ready)
            node(nil, "worldLifeAction").textContent = "RECEBER RECOMPENSA"
        end
    end
    function reward(self, xp, source, materials)
        if materials == nil then
            materials = 0
        end
        local s = session
        if not __t(s) then
            return
        end
        local ____this_70
        ____this_70 = s.api
        local ____opt_69 = ____this_70.awardXP
        if ____opt_69 ~= nil then
            ____opt_69(
                ____this_70,
                xp,
                __add("world-life-", source)
            )
        end
        do
            local i = 0
            while i < materials do
                local ____this_72
                ____this_72 = s.api
                local ____opt_71 = ____this_72.addItem
                if ____opt_71 ~= nil then
                    ____opt_71(
                        ____this_72,
                        __get(
                            __arrL({"pencil", "eraser", "clip"}, 3),
                            __mod(i, 3)
                        ),
                        1
                    )
                end
                i = i + 1
            end
        end
        save(nil)
    end
    function activate(self)
        local s = session
        if not __t(s) then
            return
        end
        if s.stage == "won" then
            close(nil)
            return
        end
        if s.stage == "lost" then
            s.stage = "intro"
        end
        if s.stage == "live" then
            if s.kind == "pump" then
                pumpHit(nil)
            end
            return
        end
        if s.kind == "vendor" then
            local p = s.plan
            local ____t_74 = __t
            local ____get_result_73 = __get(s.progress.quests, p.id)
            __O[1422] = ____get_result_73
            local quest = if ____t_74(____get_result_73) then __O[1422] else {}
            if not __t(quest.accepted) then
                __set(s.progress.quests, p.id, {accepted = true, done = false})
                save(nil)
                prepareVendor(nil)
                text(nil, "worldLifeMessage", "PEDIDO ACEITO · consulte este personagem quando terminar.")
            else
                local ____t_79 = __t
                local ____t_76 = __t
                local ____temp_75 = not __t(quest.done)
                __O[1424] = ____temp_75
                if ____t_79(if ____t_76(____temp_75) then __call(
                    p.requirements,
                    "every",
                    function(____, id)
                        local ____t_78 = __t
                        local ____get_result_77 = __get(s.progress.completed, id)
                        __O[1423] = ____get_result_77
                        return if ____t_78(____get_result_77) then __O[1423] else __get(s.progress.inspected, id)
                    end
                ) else __O[1424]) then
                    quest.done = true
                    reward(
                        nil,
                        p.xp,
                        __add("quest-", p.id),
                        p.items
                    )
                    local ____this_81
                    ____this_81 = s.api
                    local ____opt_80 = ____this_81.toast
                    if ____opt_80 ~= nil then
                        ____opt_80(
                            ____this_81,
                            __add(
                                __add(
                                    __add(p.xp, " XP e "),
                                    p.items
                                ),
                                " materiais recebidos!"
                            )
                        )
                    end
                    prepareVendor(nil)
                    text(
                        nil,
                        "worldLifeMessage",
                        __add(
                            __add(
                                __add(
                                    __add("RECOMPENSA ENTREGUE · ", p.xp),
                                    " XP + "
                                ),
                                p.items
                            ),
                            " materiais"
                        )
                    )
                end
            end
            return
        end
        if not __t(s.prop.game) then
            if not __t(__get(s.progress.inspected, s.prop.id)) then
                __set(s.progress.inspected, s.prop.id, true)
                reward(
                    nil,
                    20,
                    __add("inspect-", s.prop.id)
                )
                text(nil, "worldLifeMessage", "NOVO ACHADO NO CAMINHO · +20 XP")
            else
                text(nil, "worldLifeMessage", "Você já conhece este cantinho.")
            end
            node(nil, "worldLifeAction").hidden = true
            return
        end
        s.stage = "live"
        s.elapsed = 0
        s.score = 0
        s.errors = 0
        s.round = 0
        s.position = 0
        s.cursor = 0
        s.lastFrame = window.performance:now()
        text(nil, "worldLifeMessage", "")
        if s.kind == "pump" then
            s.target = 0.5
            node(nil, "worldLifeAction").textContent = "BOMBEAR · ESPAÇO"
            text(nil, "worldLifeInstructions", "Aperte BOMBEAR, toque no painel ou use Espaço quando o marcador entrar no verde. Acerte 5 antes de cometer 5 erros.")
        elseif s.kind == "memory" then
            makeChoices(
                nil,
                __arrL({"1 · SOL", "2 · LUA", "3 · RIO", "4 · FOLHA"}, 4)
            )
            node(nil, "worldLifeAction").hidden = true
            nextSequence(nil)
            text(nil, "worldLifeInstructions", "Observe as luzes; depois repita usando os quatro botões ou as teclas 1–4. Complete as sequências de 3, 4 e 5 luzes.")
        else
            makeChoices(
                nil,
                __arrL({"1 · PAPEL", "2 · METAL", "3 · PLÁSTICO"}, 3)
            )
            node(nil, "worldLifeAction").hidden = true
            s.cards = __call(
                __arr(__TS__Spread(__iter(order))),
                "sort",
                function() return math.random() - 0.5 end
            )
            text(nil, "worldLifeInstructions", "Separe cada objeto em papel, metal ou plástico. Use os botões ou 1–3. Faça pelo menos 10 acertos em 12 objetos.")
            text(
                nil,
                "worldLifeMessage",
                __get(s.cards, 0).name
            )
        end
    end
    function makeChoices(self, labels)
        node(nil, "worldLifeChoices"):replaceChildren(__TS__Spread(__iter(__call(
            labels,
            "map",
            function(____, label, i)
                local button = window.document:createElement("button")
                button.type = "button"
                button.className = "wl-choice"
                button.textContent = label
                button.dataset.choice = tostring(i)
                button:addEventListener(
                    "click",
                    function() return choice(nil, i) end
                )
                return button
            end
        ))))
    end
    function nextSequence(self)
        local s = session
        s.sequence = __arrayFrom(
            {length = 3 + s.round},
            function() return math.floor(math.random() * 4) end
        )
        s.position = 0
        s.showIndex = 0
        s.demoStart = s.elapsed
        s.flash = -1
        s.memoryPhase = "show"
        text(
            nil,
            "worldLifeMessage",
            __add(
                __add("OBSERVE A SEQUÊNCIA · RODADA ", s.round + 1),
                "/3"
            )
        )
    end
    function finish(self, won)
        local s = session
        if __t(not __t(s) or s.stage ~= "live") then
            return
        end
        s.stage = if __t(won) then "won" else "lost"
        s.flash = -1
        node(nil, "worldLifeChoices"):replaceChildren()
        node(nil, "worldLifeAction").hidden = false
        node(nil, "worldLifeAction").textContent = if __t(won) then "VOLTAR COM MORAL" else "TENTAR DE NOVO"
        if __t(won) then
            local first = not __t(__get(s.progress.completed, s.prop.id))
            __set(s.progress.completed, s.prop.id, true)
            __set(
                s.progress.best,
                s.prop.id,
                math.max(
                    count(
                        nil,
                        __get(s.progress.best, s.prop.id)
                    ),
                    s.score
                )
            )
            if __t(first) then
                reward(nil, s.prop.xp, s.prop.id, 2)
            else
                save(nil)
            end
            text(nil, "worldLifeMessage", if __t(first) then __add(
                __add("DESAFIO CONCLUÍDO! +", s.prop.xp),
                " XP e 2 materiais."
            ) else "PRÁTICA CONCLUÍDA! Seu primeiro prêmio já foi entregue.")
            local ____this_83
            ____this_83 = s.api
            local ____opt_82 = ____this_83.toast
            if ____opt_82 ~= nil then
                ____opt_82(____this_83, if __t(first) then __add(
                    __add("Boa! +", s.prop.xp),
                    " XP e materiais para Kauã."
                ) else "Treino concluído. Seu recorde ficou salvo.")
            end
        else
            text(nil, "worldLifeMessage", "Quase! Nenhuma recompensa foi gasta. Você pode tentar novamente.")
        end
    end
    function pumpHit(self)
        local s = session
        local ____t_86 = __t
        local ____t_85 = __t
        local ____temp_84 = not __t(s) or s.stage ~= "live"
        __O[1425] = ____temp_84
        if ____t_86(if ____t_85(____temp_84) then __O[1425] else s.kind ~= "pump") then
            return
        end
        local good = math.abs(s.cursor - s.target) <= 0.125
        if __t(good) then
            s.score = s.score + 1
            s.target = __get(
                __arrL({
                    0.3,
                    0.68,
                    0.44,
                    0.76,
                    0.5
                }, 5),
                __mod(s.score, 5)
            )
            text(
                nil,
                "worldLifeMessage",
                __add(
                    __add("BOA BOMBEADA! ", s.score),
                    "/5"
                )
            )
            if __ge(s.score, 5) then
                finish(nil, true)
            end
        else
            s.errors = s.errors + 1
            text(
                nil,
                "worldLifeMessage",
                __add(
                    __add("Fora do verde! ", s.errors),
                    "/5 erros."
                )
            )
            if __ge(s.errors, 5) then
                finish(nil, false)
            end
        end
    end
    function choice(self, index)
        local s = session
        if __t(not __t(s) or s.stage ~= "live") then
            return
        end
        if s.kind == "memory" then
            if __t(s.memoryPhase ~= "input" or __gt(index, 3)) then
                return
            end
            if index == __get(s.sequence, s.position) then
                s.position = s.position + 1
                s.flash = index
                s.flashUntil = s.elapsed + 0.22
                if s.position == __len(s.sequence) then
                    s.score = __add(
                        s.score,
                        __len(s.sequence)
                    )
                    s.round = s.round + 1
                    if __ge(s.round, 3) then
                        finish(nil, true)
                    else
                        nextSequence(nil)
                    end
                else
                    text(
                        nil,
                        "worldLifeMessage",
                        __add(
                            __add(
                                __add("ACERTOU · ", s.position),
                                "/"
                            ),
                            __len(s.sequence)
                        )
                    )
                end
            else
                s.errors = s.errors + 1
                if __ge(s.errors, 3) then
                    finish(nil, false)
                else
                    nextSequence(nil)
                    text(
                        nil,
                        "worldLifeMessage",
                        __add(
                            __add("Ops! Observe de novo · ", s.errors),
                            "/3 erros."
                        )
                    )
                end
            end
        elseif __t(s.kind == "sort" and __lt(index, 3)) then
            if index == __get(s.cards, s.position).bin then
                s.score = s.score + 1
            else
                s.errors = s.errors + 1
            end
            s.position = s.position + 1
            if __ge(s.errors, 3) then
                finish(nil, false)
            elseif __ge(
                s.position,
                __len(s.cards)
            ) then
                finish(
                    nil,
                    __ge(s.score, 10)
                )
            else
                text(
                    nil,
                    "worldLifeMessage",
                    __get(s.cards, s.position).name
                )
            end
        end
    end
    function rect(self, c, x, y, w, h, color)
        c.fillStyle = color
        c:fillRect(
            math.floor(x + 0.5),
            math.floor(y + 0.5),
            math.floor(w + 0.5),
            math.floor(h + 0.5)
        )
    end
    function label(self, c, value, x, y, size, color)
        if size == nil then
            size = 13
        end
        if color == nil then
            color = "#fff0c0"
        end
        c.fillStyle = color
        c.font = __add(
            __add("bold ", size),
            "px monospace"
        )
        c.textAlign = "center"
        c:fillText(value, x, y)
    end
    function drawModal(self, at)
        local ____t_92 = __t
        local ____temp_91 = not __t(session)
        if not ____temp_91 then
            local ____t_90 = __t
            local ____opt_result_89
            if modal ~= nil then
                ____opt_result_89 = modal.open
            end
            ____temp_91 = not ____t_90(____opt_result_89)
        end
        if ____t_92(____temp_91) then
            return
        end
        local s = session
        local c = node(nil, "worldLifeCanvas"):getContext("2d")
        local dt = math.min(
            0.1,
            math.max(0, (at - s.lastFrame) / 1000)
        )
        s.lastFrame = at
        if __t(s.stage == "live" and not __t(window.document.hidden)) then
            s.elapsed = s.elapsed + dt
            s.cursor = (math.sin(s.elapsed * (2.4 + s.score * 0.14)) + 1) / 2
            if __ge(s.elapsed, s.timeLimit) then
                finish(nil, false)
            end
            if __t(s.kind == "memory" and s.memoryPhase == "show") then
                local t = (s.elapsed - s.demoStart) / 0.85
                local i = math.floor(t)
                s.flash = if __t(__lt(
                    i,
                    __len(s.sequence)
                ) and t - i < 0.68) then __get(s.sequence, i) else -1
                if __ge(
                    i,
                    __len(s.sequence)
                ) then
                    s.memoryPhase = "input"
                    s.flash = -1
                    text(
                        nil,
                        "worldLifeMessage",
                        __add(
                            __add(
                                "SUA VEZ · REPITA AS ",
                                __len(s.sequence)
                            ),
                            " LUZES"
                        )
                    )
                end
            elseif __t(s.kind == "memory" and __lt(s.flashUntil, s.elapsed)) then
                s.flash = -1
            end
        end
        rect(
            nil,
            c,
            0,
            0,
            640,
            250,
            "#203e39"
        )
        rect(
            nil,
            c,
            6,
            6,
            628,
            238,
            "#31594b"
        )
        do
            local i = 0
            while i < 16 do
                rect(
                    nil,
                    c,
                    i * 47,
                    214 + __mod(i, 3) * 4,
                    30,
                    2,
                    "#4b7158"
                )
                i = i + 1
            end
        end
        if s.kind == "pump" then
            local fill = s.score / 5
            rect(
                nil,
                c,
                64,
                53,
                128,
                138,
                "#142d32"
            )
            rect(
                nil,
                c,
                69,
                58,
                118,
                128,
                "#91a8a1"
            )
            rect(
                nil,
                c,
                73,
                182 - fill * 118,
                110,
                fill * 118,
                "#54c9da"
            )
            do
                local j = 0
                while j < 5 do
                    rect(
                        nil,
                        c,
                        81 + j * 20,
                        148 - fill * 75 + math.sin(at / 260 + j) * 4,
                        11,
                        3,
                        "#dcfbf0"
                    )
                    j = j + 1
                end
            end
            rect(
                nil,
                c,
                212,
                86,
                26,
                106,
                "#456b61"
            )
            rect(
                nil,
                c,
                230,
                82,
                38,
                13,
                "#cfb16c"
            )
            rect(
                nil,
                c,
                250,
                54 + math.sin(at / 300) * 6,
                75,
                12,
                "#bf8660"
            )
            rect(
                nil,
                c,
                315,
                53 + math.sin(at / 300) * 6,
                12,
                25,
                "#694938"
            )
            label(
                nil,
                c,
                "ÁGUA DO POMAR",
                126,
                32,
                14
            )
            rect(
                nil,
                c,
                285,
                145,
                314,
                35,
                "#142e2a"
            )
            rect(
                nil,
                c,
                289 + s.target * 302 - 37,
                149,
                75,
                27,
                "#92cc69"
            )
            rect(
                nil,
                c,
                289 + s.cursor * 302 - 3,
                141,
                7,
                43,
                "#fff1b8"
            )
            label(
                nil,
                c,
                "ACERTE NO VERDE",
                443,
                120,
                18
            )
            label(
                nil,
                c,
                __add(s.score, " / 5 ACERTOS"),
                441,
                213,
                18
            )
        elseif s.kind == "memory" then
            local colors = __arrL({"#ffc75e", "#c7a2ed", "#6bcee0", "#a6d875"}, 4)
            do
                local i = 0
                while i < 4 do
                    local x = 76 + i * 132
                    local on = s.stage == "live" and s.flash == i
                    rect(
                        nil,
                        c,
                        x,
                        66,
                        94,
                        95,
                        if __t(on) then __get(colors, i) else "#193b34"
                    )
                    rect(
                        nil,
                        c,
                        x + 6,
                        72,
                        82,
                        83,
                        if __t(on) then "#fff2b5" else __add(
                            __get(colors, i),
                            "66"
                        )
                    )
                    label(
                        nil,
                        c,
                        __get(
                            __arrL({"SOL", "LUA", "RIO", "FOLHA"}, 4),
                            i
                        ),
                        x + 47,
                        123,
                        18,
                        if __t(on) then "#20352b" else "#f2deb0"
                    )
                    label(
                        nil,
                        c,
                        tostring(i + 1),
                        x + 47,
                        190,
                        18
                    )
                    i = i + 1
                end
            end
            label(
                nil,
                c,
                if s.memoryPhase == "show" then "OBSERVE" else "SUA VEZ",
                320,
                37,
                19
            )
        elseif s.kind == "sort" then
            local colors = __arrL({"#6baee1", "#f0cf59", "#dc706d"}, 3)
            do
                local i = 0
                while i < 3 do
                    local x = 90 + i * 175
                    rect(
                        nil,
                        c,
                        x,
                        104,
                        114,
                        94,
                        __get(colors, i)
                    )
                    rect(
                        nil,
                        c,
                        x - 6,
                        95,
                        126,
                        12,
                        "#162f2b"
                    )
                    rect(
                        nil,
                        c,
                        x + 44,
                        76,
                        26,
                        15,
                        "#162f2b"
                    )
                    rect(
                        nil,
                        c,
                        x + 14,
                        119,
                        86,
                        5,
                        "#ffffff33"
                    )
                    label(
                        nil,
                        c,
                        __get(
                            __arrL({"PAPEL", "METAL", "PLÁSTICO"}, 3),
                            i
                        ),
                        x + 57,
                        166,
                        15,
                        "#14352f"
                    )
                    label(
                        nil,
                        c,
                        tostring(i + 1),
                        x + 57,
                        225,
                        15
                    )
                    i = i + 1
                end
            end
            local ____label_96 = label
            local ____t_95 = __t
            local ____opt_93 = __getq(s.cards, s.position)
            if ____opt_93 ~= nil then
                ____opt_93 = ____opt_93.name
            end
            __O[1426] = ____opt_93
            ____label_96(
                nil,
                c,
                if ____t_95(____opt_93) then __O[1426] else "UM PÁTIO SEM BAGUNÇA",
                320,
                40,
                20
            )
        else
            drawProp(
                nil,
                c,
                __assign({}, s.prop, {x = 320}),
                at / 1000,
                0,
                s.q,
                206
            )
            label(
                nil,
                c,
                if s.kind == "vendor" then "MISSÕES DE QUEM FAZ A CIDADE" else "CADA CANTO TEM UMA HISTÓRIA",
                320,
                36,
                16
            )
        end
        if __t(s.stage == "won" or s.stage == "lost") then
            c.fillStyle = "#17342dbb"
            c:fillRect(0, 0, 640, 250)
            label(
                nil,
                c,
                if s.stage == "won" then "RESPEITA A ROÇA!" else "MAIS UMA TENTATIVA?",
                320,
                126,
                26,
                if s.stage == "won" then "#f6d479" else "#ffe0c0"
            )
        end
        if s.stage == "live" then
            text(nil, "worldLifeProgress", if s.kind == "pump" then __add(
                __add(
                    __add(s.score, "/5 ACERTOS · "),
                    s.errors
                ),
                "/5 ERROS"
            ) else if s.kind == "memory" then __add(
                __add(
                    __add(
                        __add("RODADA ", s.round + 1),
                        "/3 · "
                    ),
                    s.errors
                ),
                "/3 ERROS"
            ) else __add(
                __add(
                    __add(s.score, " ACERTOS · "),
                    s.position
                ),
                "/12 OBJETOS"
            ))
            text(
                nil,
                "worldLifeTime",
                __add(
                    math.max(
                        0,
                        math.ceil(s.timeLimit - s.elapsed)
                    ),
                    "s"
                )
            )
        end
        frame = window:requestAnimationFrame(drawModal)
    end
    function drawProp(self, c, p, t, camera, q, baseY)
        if baseY == nil then
            baseY = FLOOR
        end
        local x = p.x - camera
        local y = baseY
        local ____t_113 = __t
        local ____t_105 = __t
        local ____getq_103 = __getq
        local ____opt_result_101
        if q ~= nil then
            ____opt_result_101 = q.worldLife
        end
        local ____opt_result_102
        if ____opt_result_101 ~= nil then
            ____opt_result_102 = ____opt_result_101.completed
        end
        local ____getq_103_result_104 = ____getq_103(____opt_result_102, p.id)
        __O[1427] = ____getq_103_result_104
        local ____getq_112 = __getq
        local ____opt_result_110
        if q ~= nil then
            ____opt_result_110 = q.worldLife
        end
        local ____opt_result_111
        if ____opt_result_110 ~= nil then
            ____opt_result_111 = ____opt_result_110.inspected
        end
        local done = not not ____t_113(if ____t_105(____getq_103_result_104) then __O[1427] else ____getq_112(____opt_result_111, p.id))
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        c.imageSmoothingEnabled = false
        if p.type == "vendor" then
            local zefa = p.id == "zefa"
            local bob = math.floor(math.sin(t * 2) * 1 + 0.5)
            rect(
                nil,
                c,
                -19,
                -6,
                17,
                6,
                "#293c32"
            )
            rect(
                nil,
                c,
                6,
                -6,
                17,
                6,
                "#293c32"
            )
            rect(
                nil,
                c,
                -18,
                -42 + bob,
                36,
                34,
                if __t(zefa) then "#b64b62" else "#3f6584"
            )
            rect(
                nil,
                c,
                -13,
                -63 + bob,
                26,
                24,
                if __t(zefa) then "#b97b54" else "#c99971"
            )
            rect(
                nil,
                c,
                -15,
                -69 + bob,
                30,
                12,
                if __t(zefa) then "#4f352f" else "#d4d6b7"
            )
            if __t(zefa) then
                rect(
                    nil,
                    c,
                    -24,
                    -65 + bob,
                    48,
                    7,
                    "#e2b26b"
                )
                rect(
                    nil,
                    c,
                    -8,
                    -82 + bob,
                    17,
                    17,
                    "#d5a45b"
                )
                rect(
                    nil,
                    c,
                    -9,
                    -34,
                    18,
                    24,
                    "#f3d9aa"
                )
            else
                rect(
                    nil,
                    c,
                    -6,
                    -42,
                    12,
                    36,
                    "#d0bc80"
                )
                rect(
                    nil,
                    c,
                    -10,
                    -52 + bob,
                    6,
                    4,
                    "#233d39"
                )
                rect(
                    nil,
                    c,
                    5,
                    -52 + bob,
                    6,
                    4,
                    "#233d39"
                )
                rect(
                    nil,
                    c,
                    -4,
                    -50 + bob,
                    8,
                    2,
                    "#233d39"
                )
            end
            rect(
                nil,
                c,
                -25,
                -35 + math.sin(t * 3) * 3,
                8,
                23,
                "#b98661"
            )
            rect(
                nil,
                c,
                18,
                -36 - math.sin(t * 3) * 3,
                8,
                22,
                "#b98661"
            )
            rect(
                nil,
                c,
                -49,
                -18,
                24,
                18,
                "#8a5c37"
            )
            do
                local i = 0
                while i < 3 do
                    rect(
                        nil,
                        c,
                        -45 + i * 6,
                        -23,
                        6,
                        8,
                        if __t(zefa) then "#e89d54" else "#b4c6b8"
                    )
                    i = i + 1
                end
            end
        elseif p.type == "pump" then
            rect(
                nil,
                c,
                -20,
                -7,
                40,
                7,
                "#496a52"
            )
            rect(
                nil,
                c,
                -8,
                -63,
                16,
                60,
                "#72a994"
            )
            rect(
                nil,
                c,
                -12,
                -64,
                35,
                9,
                "#b6cb9d"
            )
            rect(
                nil,
                c,
                20,
                -56,
                8,
                17,
                "#72a994"
            )
            rect(
                nil,
                c,
                -1,
                -83 + math.sin(t * 2) * 3,
                37,
                7,
                "#b3885a"
            )
            rect(
                nil,
                c,
                31,
                -83 + math.sin(t * 2) * 3,
                7,
                17,
                "#6b4c35"
            )
            do
                local i = 0
                while i < 3 do
                    rect(
                        nil,
                        c,
                        22,
                        -24 + __mod(t * 22 + i * 12, 26),
                        3,
                        5,
                        "#75d6de"
                    )
                    i = i + 1
                end
            end
        elseif p.type == "bins" then
            do
                local i = 0
                while i < 3 do
                    rect(
                        nil,
                        c,
                        -44 + i * 30,
                        -38,
                        25,
                        36,
                        __get(
                            __arrL({"#579bd1", "#dbbd56", "#cc6968"}, 3),
                            i
                        )
                    )
                    rect(
                        nil,
                        c,
                        -47 + i * 30,
                        -43,
                        31,
                        6,
                        "#233f39"
                    )
                    rect(
                        nil,
                        c,
                        -37 + i * 30,
                        -33,
                        11,
                        3,
                        "#e6e4bc"
                    )
                    i = i + 1
                end
            end
        elseif __t(p.type == "fan" or p.type == "windmill") then
            rect(
                nil,
                c,
                -4,
                -54,
                8,
                49,
                "#788c75"
            )
            rect(
                nil,
                c,
                -21,
                -7,
                42,
                7,
                "#405f4c"
            )
            c:save()
            c:translate(0, -67)
            c:rotate(t * if __t(done) then 7 else 3)
            do
                local i = 0
                while i < 4 do
                    c:rotate(math.pi / 2)
                    rect(
                        nil,
                        c,
                        3,
                        -5,
                        30,
                        11,
                        if p.type == "fan" then "#78b2ac" else "#d6c795"
                    )
                    i = i + 1
                end
            end
            c:restore()
            rect(
                nil,
                c,
                -5,
                -72,
                10,
                10,
                "#e4ce95"
            )
        elseif p.type == "switch" then
            rect(
                nil,
                c,
                -35,
                -66,
                70,
                59,
                "#314a51"
            )
            rect(
                nil,
                c,
                -31,
                -62,
                62,
                51,
                "#6d827a"
            )
            do
                local i = 0
                while i < 4 do
                    rect(
                        nil,
                        c,
                        -24 + i * 14,
                        -53,
                        10,
                        12,
                        __get(
                            __arrL({"#f5ce67", "#c9a3e0", "#76c7d3", "#a8cb73"}, 4),
                            i
                        )
                    )
                    i = i + 1
                end
            end
            do
                local i = 0
                while i < 3 do
                    rect(
                        nil,
                        c,
                        -23 + i * 19,
                        -27,
                        13,
                        6,
                        if __t(__mod(
                            math.floor(t * 2 + i),
                            2
                        )) then "#d5dc9a" else "#405950"
                    )
                    i = i + 1
                end
            end
            rect(
                nil,
                c,
                -42,
                -8,
                84,
                8,
                "#3b5a4c"
            )
        elseif p.type == "radio" then
            rect(
                nil,
                c,
                -28,
                -42,
                56,
                39,
                "#563f3d"
            )
            rect(
                nil,
                c,
                -23,
                -37,
                46,
                9,
                "#d4bd74"
            )
            rect(
                nil,
                c,
                -21,
                -23,
                24,
                16,
                "#263c3c"
            )
            do
                local i = 0
                while i < 4 do
                    rect(
                        nil,
                        c,
                        -18 + i * 6,
                        -20,
                        2,
                        10,
                        "#6d8078"
                    )
                    i = i + 1
                end
            end
            rect(
                nil,
                c,
                12,
                -22,
                7,
                7,
                "#d5b474"
            )
            rect(
                nil,
                c,
                14,
                -66,
                3,
                24,
                "#9aa28b"
            )
            do
                local i = 0
                while i < 3 do
                    rect(
                        nil,
                        c,
                        34 + i * 7,
                        -47 + math.sin(t * 3 + i) * 4,
                        3,
                        9 - i * 2,
                        "#e4d49b"
                    )
                    i = i + 1
                end
            end
        elseif p.type == "water" then
            rect(
                nil,
                c,
                -29,
                -55,
                58,
                48,
                "#7badaf"
            )
            rect(
                nil,
                c,
                -25,
                -60,
                50,
                8,
                "#b9dad1"
            )
            rect(
                nil,
                c,
                -24,
                -17,
                48,
                10,
                "#63897e"
            )
            rect(
                nil,
                c,
                16,
                -45,
                12,
                6,
                "#decc93"
            )
            rect(
                nil,
                c,
                23,
                -38,
                3,
                22,
                "#75d0e0"
            )
            rect(
                nil,
                c,
                -30,
                -5,
                60,
                5,
                "#486f65"
            )
        elseif p.type == "telescope" then
            rect(
                nil,
                c,
                -4,
                -39,
                7,
                35,
                "#9ba697"
            )
            rect(
                nil,
                c,
                -29,
                -55,
                48,
                15,
                "#486979"
            )
            rect(
                nil,
                c,
                17,
                -57,
                9,
                19,
                "#bfd0b4"
            )
            rect(
                nil,
                c,
                -23,
                -3,
                45,
                4,
                "#627f67"
            )
        elseif p.type == "bell" then
            rect(
                nil,
                c,
                -4,
                -83,
                8,
                78,
                "#6a674d"
            )
            rect(
                nil,
                c,
                -23,
                -84,
                46,
                8,
                "#557b65"
            )
            rect(
                nil,
                c,
                -14,
                -74,
                29,
                28,
                "#d0ab54"
            )
            rect(
                nil,
                c,
                -21,
                -48,
                42,
                7,
                "#e1c272"
            )
            rect(
                nil,
                c,
                -2,
                -41,
                4,
                7,
                "#9f733f"
            )
        elseif p.type == "kite" then
            rect(
                nil,
                c,
                -3,
                -53,
                6,
                50,
                "#7b855c"
            )
            c:save()
            c:translate(
                0,
                -77 + math.sin(t * 2) * 3
            )
            c:rotate(math.sin(t) * 0.1)
            rect(
                nil,
                c,
                -17,
                -12,
                34,
                25,
                "#dd9b61"
            )
            rect(
                nil,
                c,
                -3,
                -25,
                6,
                49,
                "#d4c179"
            )
            rect(
                nil,
                c,
                -24,
                -3,
                48,
                6,
                "#efc17f"
            )
            c:restore()
        elseif p.type == "score" then
            rect(
                nil,
                c,
                -35,
                -70,
                70,
                46,
                "#244639"
            )
            rect(
                nil,
                c,
                -39,
                -74,
                78,
                5,
                "#8fa37e"
            )
            rect(
                nil,
                c,
                -27,
                -25,
                5,
                23,
                "#7f8c65"
            )
            rect(
                nil,
                c,
                22,
                -25,
                5,
                23,
                "#7f8c65"
            )
            label(
                nil,
                c,
                "1 × 0",
                0,
                -42,
                18
            )
        elseif p.type == "barber" then
            rect(
                nil,
                c,
                -15,
                -84,
                30,
                78,
                "#e8d9b0"
            )
            do
                local i = 0
                while i < 6 do
                    rect(
                        nil,
                        c,
                        -11,
                        -80 + i * 12 + math.sin(t * 3) * 2,
                        22,
                        6,
                        if __t(__mod(i, 2)) then "#e7867f" else "#6eafc5"
                    )
                    i = i + 1
                end
            end
            rect(
                nil,
                c,
                -19,
                -90,
                38,
                7,
                "#546f6c"
            )
            rect(
                nil,
                c,
                -19,
                -9,
                38,
                7,
                "#546f6c"
            )
        elseif p.type == "mail" then
            rect(
                nil,
                c,
                -4,
                -43,
                8,
                40,
                "#825f45"
            )
            rect(
                nil,
                c,
                -28,
                -68,
                56,
                29,
                "#81a59b"
            )
            rect(
                nil,
                c,
                -21,
                -61,
                42,
                4,
                "#254b48"
            )
            rect(
                nil,
                c,
                23,
                -70,
                5,
                17,
                "#b27759"
            )
            rect(
                nil,
                c,
                25,
                -70,
                13,
                7,
                "#e4bd65"
            )
        else
            rect(
                nil,
                c,
                -28,
                -36,
                56,
                33,
                "#9a7047"
            )
            rect(
                nil,
                c,
                -30,
                -39,
                60,
                6,
                "#cf9e62"
            )
            do
                local i = 0
                while i < 4 do
                    rect(
                        nil,
                        c,
                        -22 + i * 13,
                        -30,
                        3,
                        23,
                        "#624c35"
                    )
                    i = i + 1
                end
            end
            do
                local i = 0
                while i < 5 do
                    rect(
                        nil,
                        c,
                        -22 + i * 9,
                        -46 - math.sin(t * 2 + i) * 2,
                        9,
                        10,
                        if p.scene == 6 then "#a58cca" else "#dfb16c"
                    )
                    i = i + 1
                end
            end
        end
        c:restore()
    end
    local ____ = "use strict"
    clamp = function(____, n, a, b) return math.max(
        a,
        math.min(b, n)
    ) end
    FLOOR = 440
    local props = __arrL(
        {
            __ord({
                id = "pump-roca",
                scene = 0,
                x = 980,
                type = "pump",
                name = "Bomba do pomar",
                game = "pump",
                xp = 160,
                text = "A água sumiu do pomar. Acerte cinco bombeadas no verde para encher a caixa."
            }, "id,scene,x,type,name,game,xp,text"),
            __ord({
                id = "fruit-roca",
                scene = 0,
                x = 1560,
                type = "crate",
                name = "Caixote de Dona Zefa",
                text = "As frutas estão prontas. Dona Zefa deixou um bilhete: “Quem voa no gás também pode ajudar no pomar, viu?”"
            }, "id,scene,x,type,name,text"),
            __ord({
                id = "zefa",
                scene = 0,
                x = 2110,
                type = "vendor",
                name = "Dona Zefa · quitanda"
            }, "id,scene,x,type,name"),
            __ord({
                id = "sort-school",
                scene = 1,
                x = 600,
                type = "bins",
                name = "Coleta do corredor",
                game = "sort",
                xp = 160,
                text = "Papel, metal e plástico: cada rabisco vai para um lugar. Separe dez dos doze objetos."
            }, "id,scene,x,type,name,game,xp,text"),
            __ord({
                id = "bell-school",
                scene = 1,
                x = 3450,
                type = "bell",
                name = "Sino do recreio",
                text = "DING! O sino tocou, mas a fiscalização continua. O intervalo não te deixa invisível para Igor e Kaique."
            }, "id,scene,x,type,name,text"),
            __ord({
                id = "fan-gym",
                scene = 2,
                x = 870,
                type = "fan",
                name = "Ventilador do leg day",
                text = "Caleb pendurou um bilhete: “O ventilador faz cardio o dia inteiro e ainda não reclama do treino de perna.”"
            }, "id,scene,x,type,name,text"),
            __ord({
                id = "water-gym",
                scene = 2,
                x = 1710,
                type = "water",
                name = "Bebedouro da academia",
                text = "Água gelada, sombra e um lembrete: distribuir pontos em Vigor também faz parte do treino."
            }, "id,scene,x,type,name,text"),
            __ord({
                id = "score-court",
                scene = 3,
                x = 720,
                type = "score",
                name = "Placar da resenha",
                text = "DA ROÇA 1 × 0 FOME DE BOLO. Nikolas rasurou o resultado. O placar exige uma revanche."
            }, "id,scene,x,type,name,text"),
            __ord({
                id = "wind-court",
                scene = 3,
                x = 2820,
                type = "kite",
                name = "Pipa presa na quadra",
                text = "A pipa foi longe demais e ficou na trave. Nem toda coisa que voa precisa de um carro a gás."
            }, "id,scene,x,type,name,text"),
            __ord({
                id = "switch-camacan",
                scene = 4,
                x = 790,
                type = "switch",
                name = "Luzes da Praça Camacan",
                game = "memory",
                xp = 210,
                text = "A iluminação perdeu a ordem. Memorize as lâmpadas e repita três sequências para devolver as cores à praça."
            }, "id,scene,x,type,name,game,xp,text"),
            __ord({
                id = "river-camacan",
                scene = 4,
                x = 2200,
                type = "telescope",
                name = "Mirante do Cachoeira",
                text = "O reflexo do rio treme ao vento. Por um instante, até a busca pelo bolo parece caber numa tarde tranquila."
            }, "id,scene,x,type,name,text"),
            __ord({
                id = "radio-favela",
                scene = 5,
                x = 800,
                type = "radio",
                name = "Rádio do beco",
                text = "“Alô, morro! Freddy tá dizendo OPEESTY DA ROÇA de novo. Favor não transformar isso em senha de Wi-Fi.”"
            }, "id,scene,x,type,name,text"),
            __ord({
                id = "tank-favela",
                scene = 5,
                x = 2290,
                type = "water",
                name = "Caixa-d’água do beco",
                text = "A caixa está cheia. Dedé escreveu: “SEU GILÓ HOMI, fecha a torneira quando sair!”"
            }, "id,scene,x,type,name,text"),
            __ord({
                id = "ink-caderno",
                scene = 6,
                x = 810,
                type = "crate",
                name = "Estojo de tinta viva",
                text = "O nanquim se mexe sozinho. Um rascunho de Marco diz: “Se este desenho te zoar, a culpa é da caneta.”"
            }, "id,scene,x,type,name,text"),
            __ord({
                id = "clock-caderno",
                scene = 6,
                x = 2900,
                type = "windmill",
                name = "Moinho de papel",
                text = "As páginas giram ao contrário do vento. Tem uma assinatura de Marco até no parafuso."
            }, "id,scene,x,type,name,text"),
            __ord({
                id = "cones-campo",
                scene = 7,
                x = 1260,
                type = "score",
                name = "Prancheta do Mota",
                text = "Treino do dia: passe, chute, comemoração e não acertar a bola na Mavie. O último item está sublinhado três vezes."
            }, "id,scene,x,type,name,text"),
            __ord({
                id = "pump-campo",
                scene = 7,
                x = 2440,
                type = "pump",
                name = "Bomba das bolas",
                game = "pump",
                xp = 150,
                text = "As bolas perderam pressão. Encha a bomba com cinco acertos no verde. O Mota agradece!"
            }, "id,scene,x,type,name,game,xp,text"),
            __ord({
                id = "tonico",
                scene = 8,
                x = 1370,
                type = "vendor",
                name = "Seu Tonico · consertos"
            }, "id,scene,x,type,name"),
            __ord({
                id = "pole-bigodon",
                scene = 8,
                x = 1970,
                type = "barber",
                name = "Letreiro da Bigodon",
                text = "O letreiro voltou a girar. Davi garante: “Aqui o corte tem acabamento. A resenha, não.”"
            }, "id,scene,x,type,name,text"),
            __ord({
                id = "sort-patio",
                scene = 9,
                x = 1190,
                type = "bins",
                name = "Mutirão do recreio",
                game = "sort",
                xp = 190,
                text = "O pátio ficou cheio de objetos depois do recreio. Organize dez dos doze antes que o tempo acabe."
            }, "id,scene,x,type,name,game,xp,text"),
            __ord({
                id = "garden-patio",
                scene = 9,
                x = 2000,
                type = "crate",
                name = "Horta da escola",
                text = "Alguém plantou alface num balde com a frase: “É ou não é, beleza creuza?” A horta está concordando sem corda."
            }, "id,scene,x,type,name,text"),
            __ord({
                id = "fan-rayssa",
                scene = 10,
                x = 1880,
                type = "fan",
                name = "Ventilador da resenha",
                text = "“Aff veyr juro, esse ventilador trabalha mais que esse menino buscando bolo.” A fita no interruptor tem a letra da Rayssa."
            }, "id,scene,x,type,name,text"),
            __ord({
                id = "mail-rayssa",
                scene = 10,
                x = 2640,
                type = "mail",
                name = "Caixa de recados",
                text = "“Aff veyr juro, se toca: o Bivolt está nas prateleiras e a amizade não cabe num bilhete.” As garotas assinaram juntas."
            }, "id,scene,x,type,name,text"),
            __ord({
                id = "switch-baile",
                scene = 11,
                x = 1070,
                type = "switch",
                name = "Mesa de luz do baile",
                game = "memory",
                xp = 180,
                text = "O operador perdeu a sequência das luzes. Repita três combinações e devolva o show ao palco."
            }, "id,scene,x,type,name,game,xp,text"),
            __ord({
                id = "speaker-baile",
                scene = 11,
                x = 2340,
                type = "radio",
                name = "Caixa do DJ",
                text = "O DJ aponta para um aviso: “Se a orelha começar a bater no ritmo, afastem o Ollyan do palco.”"
            }, "id,scene,x,type,name,text")
        },
        25
    )
    local objects = __call(
        props,
        "map",
        function(____, p) return p end
    )
    order = __arrL(
        {
            __ord({name = "Folha de caderno", bin = 0}, "name,bin"),
            __ord({name = "Lata de Bivolt", bin = 1}, "name,bin"),
            __ord({name = "Garrafa vazia", bin = 2}, "name,bin"),
            __ord({name = "Bolinha de papel", bin = 0}, "name,bin"),
            __ord({name = "Clipe velho", bin = 1}, "name,bin"),
            __ord({name = "Tampa plástica", bin = 2}, "name,bin"),
            __ord({name = "Cartolina", bin = 0}, "name,bin"),
            __ord({name = "Mola de metal", bin = 1}, "name,bin"),
            __ord({name = "Pote vazio", bin = 2}, "name,bin"),
            __ord({name = "Jornal da escola", bin = 0}, "name,bin"),
            __ord({name = "Latinha de suco", bin = 1}, "name,bin"),
            __ord({name = "Embalagem plástica", bin = 2}, "name,bin")
        },
        12
    )
    modal = nil
    session = nil
    frame = 0
    local serial = 0
    local function state(self, q)
        if __t(not __t(q) or type(q) ~= "table") then
            return nil
        end
        local ____t_2 = __t
        local ____t_1 = __t
        local ____temp_0 = not __t(q.worldLife) or type(q.worldLife) ~= "table"
        __O[1413] = ____temp_0
        if ____t_2(if ____t_1(____temp_0) then __O[1413] else __isArray(q.worldLife)) then
            q.worldLife = {}
        end
        local value = q.worldLife
        for ____, key in __iterar((__arrL({
            "completed",
            "inspected",
            "quests",
            "visits",
            "best"
        }, 5))) do
            local ____t_5 = __t
            local ____t_4 = __t
            local ____temp_3 = not __t(__get(value, key)) or type(__get(value, key)) ~= "table"
            __O[1414] = ____temp_3
            if ____t_5(if ____t_4(____temp_3) then __O[1414] else __isArray(__get(value, key))) then
                __set(value, key, {})
            end
        end
        return value
    end
    local function ensureModal(self)
        if __t(modal) then
            return modal
        end
        modal = window.document:createElement("dialog")
        modal.id = "worldLifeDialog"
        modal.className = "world-life-dialog"
        modal:setAttribute("aria-labelledby", "worldLifeTitle")
        modal.innerHTML = "<div class=\"wl-nail wl-nail-left\" aria-hidden=\"true\"></div><div class=\"wl-nail wl-nail-right\" aria-hidden=\"true\"></div><div class=\"wl-heading\"><span class=\"wl-tag\">VIDA NA ROÇA · DESAFIO OPCIONAL</span><button class=\"wl-close\" type=\"button\" aria-label=\"Fechar desafio\">×</button></div><h2 id=\"worldLifeTitle\"></h2><p id=\"worldLifeInstructions\"></p><div class=\"wl-status\" aria-live=\"polite\"><b id=\"worldLifeProgress\"></b><span id=\"worldLifeTime\"></span></div><canvas id=\"worldLifeCanvas\" width=\"640\" height=\"250\" aria-label=\"Visual do desafio\"></canvas><div id=\"worldLifeChoices\" class=\"wl-choices\"></div><p id=\"worldLifeMessage\" class=\"wl-message\" role=\"status\"></p><div class=\"wl-footer\"><button id=\"worldLifeAction\" class=\"wl-primary\" type=\"button\">COMEÇAR</button><button id=\"worldLifeExit\" class=\"wl-secondary\" type=\"button\">VOLTAR AO CAMINHO</button></div>"
        window.document.body:append(modal)
        modal:querySelector(".wl-close"):addEventListener(
            "click",
            function() return close(nil) end
        )
        modal:querySelector("#worldLifeExit"):addEventListener(
            "click",
            function() return close(nil) end
        )
        modal:querySelector("#worldLifeAction"):addEventListener(
            "click",
            function() return activate(nil) end
        )
        modal:addEventListener(
            "cancel",
            function(____, e)
                e:preventDefault()
                close(nil)
            end
        )
        modal:querySelector("canvas"):addEventListener(
            "pointerdown",
            function(____, e)
                local ____t_11 = __t
                local ____opt_result_10
                if session ~= nil then
                    ____opt_result_10 = session.kind
                end
                if ____t_11(____opt_result_10 == "pump" and session.stage == "live") then
                    e:preventDefault()
                    pumpHit(nil)
                end
            end
        )
        modal:addEventListener(
            "keydown",
            function(____, e)
                if e.code == "Escape" then
                    return
                end
                if __t(e["repeat"]) then
                    e:preventDefault()
                    return
                end
                local ____t_24 = __t
                local ____t_16 = __t
                local ____opt_result_14
                if session ~= nil then
                    ____opt_result_14 = session.stage
                end
                local ____temp_15 = ____opt_result_14 == "live" and session.kind == "pump"
                __O[1417] = ____temp_15
                local ____t_18 = __t
                local ____call_result_17 = __call(
                    __arrL({"Space", "Enter"}, 2),
                    "includes",
                    e.code
                )
                __O[1416] = ____call_result_17
                local ____opt_21 = window.ControlSettings
                if ____opt_21 ~= nil then
                    ____opt_21 = ____opt_21.matches
                end
                local ____opt_result_23
                if ____opt_21 ~= nil then
                    ____opt_result_23 = ____opt_21(____opt_21, "interact", e.code)
                end
                if ____t_24(if ____t_16(____temp_15) then if ____t_18(____call_result_17) then __O[1416] else ____opt_result_23 else __O[1417]) then
                    e:preventDefault()
                    e:stopPropagation()
                    pumpHit(nil)
                else
                    local ____t_30 = __t
                    local ____t_29 = __t
                    local ____opt_result_27
                    if session ~= nil then
                        ____opt_result_27 = session.stage
                    end
                    local ____temp_28 = ____opt_result_27 == "live"
                    __O[1418] = ____temp_28
                    if ____t_30(if ____t_29(____temp_28) then __call(
                        __arrL({
                            "Digit1",
                            "Digit2",
                            "Digit3",
                            "Digit4",
                            "Numpad1",
                            "Numpad2",
                            "Numpad3",
                            "Numpad4"
                        }, 8),
                        "includes",
                        e.code
                    ) else __O[1418]) then
                        e:preventDefault()
                        e:stopPropagation()
                        choice(
                            nil,
                            __TS__Number(__call(e.code, "slice", -1)) - 1
                        )
                    end
                end
            end
        )
        return modal
    end
    local function open(self, prop, q, api)
        if api == nil then
            api = {}
        end
        ensureModal(nil)
        if __t(session) then
            return false
        end
        local progress = state(nil, q)
        if not __t(progress) then
            return false
        end
        local ____t_44 = __t
        local ____opt_41 = window.Game
        if ____opt_41 ~= nil then
            ____opt_41 = ____opt_41.getState
        end
        local ____opt_result_43
        if ____opt_41 ~= nil then
            ____opt_result_43 = ____opt_41(____opt_41)
        end
        __O[1419] = ____opt_result_43
        local gameState = if ____t_44(____opt_result_43) then __O[1419] else {}
        local wasPaused = not not __t(gameState.paused)
        local ____opt_47 = window.Game
        if ____opt_47 ~= nil then
            ____opt_47 = ____opt_47.releaseInputs
        end
        if ____opt_47 ~= nil then
            ____opt_47(____opt_47)
        end
        if not __t(wasPaused) then
            local ____opt_51 = window.Game
            if ____opt_51 ~= nil then
                ____opt_51 = ____opt_51.pause
            end
            if ____opt_51 ~= nil then
                ____opt_51(____opt_51)
            end
        end
        serial = serial + 1
        local id = serial
        session = {
            id = id,
            prop = prop,
            q = q,
            progress = progress,
            api = api,
            wasPaused = wasPaused,
            kind = if __t(prop.game) then prop.game else prop.type,
            stage = "intro",
            elapsed = 0,
            score = 0,
            errors = 0,
            round = 0,
            sequence = __arrL({}, 0),
            position = 0,
            flash = -1,
            showIndex = 0,
            completed = false,
            lastFrame = window.performance:now(),
            cursor = 0,
            target = 0.5,
            timeLimit = if prop.game == "memory" then 65 else if prop.game == "sort" then 40 else 35
        }
        __set(
            progress.visits,
            prop.id,
            count(
                nil,
                __get(progress.visits, prop.id)
            ) + 1
        )
        text(nil, "worldLifeTitle", prop.name)
        text(nil, "worldLifeInstructions", if __t(prop.text) then prop.text else "Uma conversa boa também faz parte do caminho.")
        text(nil, "worldLifeMessage", "")
        text(nil, "worldLifeProgress", if __t(prop.game) then if __t(__get(progress.completed, prop.id)) then "PRÁTICA · MELHORE SEU RECORDE" else __add(
            __add("MISSÃO EXTRA · ", prop.xp),
            " XP"
        ) else "UMA PAUSA NA RESENHA")
        text(nil, "worldLifeTime", "")
        node(nil, "worldLifeChoices"):replaceChildren()
        node(nil, "worldLifeAction").hidden = false
        node(nil, "worldLifeAction").textContent = if __t(prop.game) then "COMEÇAR DESAFIO" else "CONFERIR"
        if prop.type == "vendor" then
            prepareVendor(nil)
        end
        save(nil)
        modal:showModal()
        node(nil, "worldLifeAction"):focus({preventScroll = true})
        frame = window:requestAnimationFrame(drawModal)
        return true
    end
    local function draw(self, c, scene, camera, t, q, player)
        if __t(not __t(c) or not __isFiniteN(__TS__Number(scene))) then
            return
        end
        local ____t_116 = __t
        local ____opt_114 = c.canvas
        if ____opt_114 ~= nil then
            ____opt_114 = ____opt_114.width
        end
        __O[1428] = ____opt_114
        local width = if ____t_116(____opt_114) then __O[1428] else 960
        for ____, p in __iterar((objects)) do
            local ____t_119 = __t
            local ____t_118 = __t
            local ____temp_117 = p.scene ~= __TS__Number(scene) or p.x < camera - 90
            __O[1429] = ____temp_117
            if ____t_119(if ____t_118(____temp_117) then __O[1429] else __gt(
                p.x,
                __add(camera, width) + 90
            )) then
                continue
            end
            local ____drawProp_126 = drawProp
            local ____c_124 = c
            local ____t_121 = __t
            local ____TS__Number_result_120 = __TS__Number(t)
            __O[1430] = ____TS__Number_result_120
            local ____temp_125 = if ____t_121(____TS__Number_result_120) then __O[1430] else 0
            local ____t_123 = __t
            local ____TS__Number_result_122 = __TS__Number(camera)
            __O[1431] = ____TS__Number_result_122
            ____drawProp_126(
                nil,
                ____c_124,
                p,
                ____temp_125,
                if ____t_123(____TS__Number_result_122) then __O[1431] else 0,
                q
            )
            local ____t_129 = __t
            local ____t_128 = __t
            local ____temp_127 = if __t(player) then math.abs(player.x - p.x) < 90 else player
            __O[1432] = ____temp_127
            if ____t_129(if ____t_128(____temp_127) then math.abs(player.y - FLOOR) < 85 else __O[1432]) then
                local x = p.x - camera
                local y = FLOOR - 104 + math.sin(t * 3) * 2
                c:save()
                local ____t_138 = __t
                local ____getq_136 = __getq
                local ____opt_result_134
                if q ~= nil then
                    ____opt_result_134 = q.worldLife
                end
                local ____opt_result_135
                if ____opt_result_134 ~= nil then
                    ____opt_result_135 = ____opt_result_134.completed
                end
                local ____getq_136_result_137 = ____getq_136(____opt_result_135, p.id)
                __O[1433] = ____getq_136_result_137
                local ____getq_145 = __getq
                local ____opt_result_143
                if q ~= nil then
                    ____opt_result_143 = q.worldLife
                end
                local ____opt_result_144
                if ____opt_result_143 ~= nil then
                    ____opt_result_144 = ____opt_result_143.inspected
                end
                local finished = if ____t_138(____getq_136_result_137) then __O[1433] else ____getq_145(____opt_result_144, p.id)
                local labelValue = __add(
                    if __t(finished) then "✓ " else "E · ",
                    __get(
                        __call(p.name, "split", " ·"),
                        0
                    )
                )
                c.font = "bold 11px monospace"
                local w = c:measureText(labelValue).width + 18
                rect(
                    nil,
                    c,
                    x - w / 2,
                    y - 13,
                    w,
                    21,
                    "#173b35ee"
                )
                label(
                    nil,
                    c,
                    labelValue,
                    x,
                    y + 1,
                    11,
                    if __t(finished) then "#b7dc8c" else "#ffe3a0"
                )
                c:restore()
            end
        end
    end
    local function tryInteract(self, ____bindingPattern0, api)
        if ____bindingPattern0 == nil then
            ____bindingPattern0 = {}
        end
        if api == nil then
            api = {}
        end
        local q
        local player
        local scene
        scene = ____bindingPattern0.scene
        player = ____bindingPattern0.player
        q = ____bindingPattern0.q
        local ____t_148 = __t
        local ____t_147 = __t
        local ____temp_146 = not __t(player) or not __t(q)
        __O[1434] = ____temp_146
        if ____t_148(if ____t_147(____temp_146) then __O[1434] else math.abs(player.y - FLOOR) > 85) then
            return false
        end
        if __t(session) then
            return true
        end
        local prop = __get(
            __call(
                __call(
                    objects,
                    "filter",
                    function(____, p) return p.scene == __TS__Number(scene) and math.abs(p.x - player.x) < 85 end
                ),
                "sort",
                function(____, a, b) return math.abs(a.x - player.x) - math.abs(b.x - player.x) end
            ),
            0
        )
        if not __t(prop) then
            return false
        end
        return open(nil, prop, q, api)
    end
    local function getStatus(self)
        local s = session
        local ____s_prop_id_152 = s.prop.id
        local ____s_kind_153 = s.kind
        local ____s_stage_154 = s.stage
        local ____s_score_155 = s.score
        local ____s_errors_156 = s.errors
        local ____s_elapsed_157 = s.elapsed
        local ____s_round_158 = s.round
        local ____s_memoryPhase_159 = s.memoryPhase
        local ____s_position_160 = s.position
        local ____temp_161 = if __t(s.sequence) then __arr(__TS__Spread(__iter(s.sequence))) else __arrL({}, 0)
        local ____s_cursor_162 = s.cursor
        local ____s_target_163 = s.target
        local ____t_151 = __t
        local ____opt_149 = __getq(s.cards, s.position)
        if ____opt_149 ~= nil then
            ____opt_149 = ____opt_149.name
        end
        __O[1435] = ____opt_149
        return if __t(s) then {
            open = true,
            id = ____s_prop_id_152,
            kind = ____s_kind_153,
            stage = ____s_stage_154,
            score = ____s_score_155,
            errors = ____s_errors_156,
            elapsed = ____s_elapsed_157,
            round = ____s_round_158,
            memoryPhase = ____s_memoryPhase_159,
            position = ____s_position_160,
            sequence = ____temp_161,
            cursor = ____s_cursor_162,
            target = ____s_target_163,
            card = if ____t_151(____opt_149) then __O[1435] else nil
        } else {open = false}
    end
    window.WorldLife = __ord({
        version = 1,
        objects = objects,
        draw = draw,
        tryInteract = tryInteract,
        close = close,
        getStatus = getStatus
    }, "version,objects,draw,tryInteract,close,getStatus")
end)(nil)
return ____exports
