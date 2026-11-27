--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __le, __gt, __ge, __isFiniteN, __isInteger, __getq, __callq, __mod, __ord, __arrL, __iterar = __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__isFiniteN, __JSR.__isInteger, __JSR.__getq, __JSR.__callq, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar
local __t, __get, __set, __arr, __len, __call, __add, __new, __iter, __entries, __assign, __isArray = __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__arr, __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__new, __JSR.__iter, __JSR.__entries, __JSR.__assign, __JSR.__isArray
local __re, __re_test, __re_replace = __JSR.__re, __JSR.__re_test, __JSR.__re_replace
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Delete = ____lualib.__TS__Delete
local __TS__Number = ____lualib.__TS__Number
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__MathSign = ____lualib.__TS__MathSign
local __TS__Spread = ____lualib.__TS__Spread
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local ____exports = {}
local __O = {};
(function()
    local __L1 = {}
    __L1.liberada = function(self)
        local ____t_2 = __t
        local ____t_1 = __t
        local ____re_test_result_0 = __re_test(
            __re("[?&]campanha2\\b", ""),
            window.location.search
        )
        __O[962] = ____re_test_result_0
        if ____t_2(if ____t_1(____re_test_result_0) then __O[962] else window.DAROCA_DEV) then
            return true
        end
        local ____t_14 = __t
        local ____temp_13 = __L1:safe(
            function()
                local ____t_12 = __t
                local ____self_9 = window.JSON
                local ____self_9_parse_10 = ____self_9.parse
                local ____t_8 = __t
                local ____temp_7 = window.localStorage:getItem("da-roca-adventure-v1")
                __O[963] = ____temp_7
                local ____opt_5 = ____self_9_parse_10(____self_9, if ____t_8(____temp_7) then __O[963] else "null")
                if ____opt_5 ~= nil then
                    ____opt_5 = ____opt_5.q
                end
                local ____opt_result_11
                if ____opt_5 ~= nil then
                    ____opt_result_11 = ____opt_5.jorgeSeen
                end
                return not not ____t_12(____opt_result_11)
            end,
            false
        )
        __O[964] = ____temp_13
        return if ____t_14(____temp_13) then __O[964] else __L1:safe(
            function() return window.localStorage:getItem("daroca-sandbox-v1") == "1" end,
            false
        )
    end
    __L1.carregar = function(self)
        local d = __L1:safe(
            function()
                local ____self_17 = window.JSON
                local ____self_17_parse_18 = ____self_17.parse
                local ____t_16 = __t
                local ____temp_15 = window.localStorage:getItem(__L1.KEY)
                __O[966] = ____temp_15
                return ____self_17_parse_18(____self_17, if ____t_16(____temp_15) then __O[966] else "null")
            end,
            nil
        )
        local ____t_23 = __t
        local ____t_22 = __t
        local ____t_20 = __t
        local ____temp_19 = not __t(d) or type(d) ~= "table"
        __O[967] = ____temp_19
        local ____temp_21 = if ____t_20(____temp_19) then __O[967] else d.v ~= 1
        __O[968] = ____temp_21
        if ____t_23(if ____t_22(____temp_21) then __O[968] else not __t(d.passo)) then
            return nil
        end
        local ____t_26 = __t
        local ____t_25 = __t
        local ____temp_24 = if __t(d.flags) then type(d.flags) == "table" else d.flags
        __O[969] = ____temp_24
        local flags = if ____t_26(if ____t_25(____temp_24) then not __isArray(d.flags) else __O[969]) then __assign({}, d.flags) else {}
        local S2 = __assign(
            {},
            __L1:novoSave(),
            d,
            {flags = flags}
        )
        if __t(not __t(__get(__L1.PASSOS, S2.passo)) and not __t(__call(
            __arrL({"bairro", "fim6b", "fim6c"}, 3),
            "includes",
            S2.passo
        ))) then
            local ordem = __arrL({
                "creuza",
                "tonhao",
                "valdomiro",
                "kaua",
                "barao",
                "breno",
                "gemeos",
                "fred",
                "jorge"
            }, 9)
            local ____t_28 = __t
            local ____call_result_27 = __call(
                ordem,
                "find",
                function(____, v) return not __t(__get(
                    flags,
                    __add("venceu_", v)
                )) end
            )
            __O[970] = ____call_result_27
            S2.passo = if __t(flags.zerou) then "zerou" else if ____t_28(____call_result_27) then __O[970] else "zerou"
            if not __t(__get(__L1.PASSOS, S2.passo)) then
                S2.passo = "creuza"
            end
            __TS__Delete(S2, "cena")
            __TS__Delete(S2, "x")
        end
        local ____t_30 = __t
        local ____isInteger_result_29 = __isInteger(S2.cena)
        __O[973] = ____isInteger_result_29
        local ____t_32 = __t
        local ____temp_31 = __ge(S2.cena, 0) and __le(S2.cena, 11)
        __O[972] = ____temp_31
        local ____call_36 = __call
        local ____t_35 = __t
        local ____opt_33 = window.CampanhaCenarios
        if ____opt_33 ~= nil then
            ____opt_33 = ____opt_33.lista
        end
        __O[971] = ____opt_33
        local cenaOk = if ____t_30(____isInteger_result_29) then if ____t_32(____temp_31) then __O[972] else ____call_36(
            if ____t_35(____opt_33) then __O[971] else __arrL({}, 0),
            "some",
            function(____, q) return q.id == S2.cena end
        ) else __O[973]
        if not __t(cenaOk) then
            __TS__Delete(S2, "cena")
            __TS__Delete(S2, "x")
        end
        if __t(S2.x ~= nil and not __isFiniteN(S2.x)) then
            __TS__Delete(S2, "x")
        end
        S2.hp = if __t(__isFiniteN(__TS__Number(S2.hp)) and __TS__Number(S2.hp) > 0) then math.min(
            9999,
            __TS__Number(S2.hp)
        ) else 100
        return S2
    end
    __L1.salvar = function(self, msg)
        if not __t(__L1.S) then
            return
        end
        __L1.S.cena = __L1.cenaId
        __L1.S.x = math.floor(__L1.P.x + 0.5)
        __L1.S.hp = math.floor(__L1.P.hp + 0.5)
        __L1.S.salvo = window.Date:now()
        __L1:safe(function() return window.localStorage:setItem(
            __L1.KEY,
            window.JSON:stringify(__L1.S)
        ) end)
        if __t(msg) then
            __L1:aviso(msg)
        end
    end
    __L1.cenaDef = function(self, id)
        if __ge(id, 12) then
            local ____t_38 = __t
            local ____call_result_37 = __call(
                __L1:CC().lista,
                "find",
                function(____, d) return d.id == id end
            )
            __O[975] = ____call_result_37
            return if ____t_38(____call_result_37) then __O[975] else __get(
                __L1:CC().lista,
                0
            )
        end
        local ____t_43 = __t
        local ____getq_41 = __getq
        local ____opt_39 = window.WorldData
        if ____opt_39 ~= nil then
            ____opt_39 = ____opt_39.widths
        end
        local ____TS__Number_result_42 = __TS__Number(____getq_41(____opt_39, id))
        __O[976] = ____TS__Number_result_42
        local w = if ____t_43(____TS__Number_result_42) then __O[976] else 4800
        local ____id_48 = id
        local ____t_45 = __t
        local ____get_result_44 = __get(
            __L1:NOMES_C1(),
            id
        )
        __O[977] = ____get_result_44
        local ____temp_49 = if ____t_45(____get_result_44) then __O[977] else "Itabuna"
        local ____arrL_result_50 = __arrL({}, 0)
        local ____t_47 = __t
        local ____get_result_46 = __get(__L1.EXTRA_PLAT, id)
        __O[978] = ____get_result_46
        return {
            id = ____id_48,
            nome = ____temp_49,
            largura = w,
            vaos = ____arrL_result_50,
            plataformas = if ____t_47(____get_result_46) then __O[978] else __arrL({}, 0),
            limites = __arrL({40, w - 40}, 2),
            itabuna = true
        }
    end
    __L1.passo = function(self, id)
        __L1.S.passo = id
        local p = __get(__L1.PASSOS, id)
        local ____t_54 = __t
        local ____opt_result_53
        if p ~= nil then
            ____opt_result_53 = p.obj
        end
        if ____t_54(____opt_result_53) then
            __L1:objetivoNovo(p.obj)
        end
        __L1:salvar()
    end
    __L1.caronaLucas = function(self)
        local raw = {
            id = "c2j_carona",
            titulo = "A carona",
            balao = true,
            substituir = true,
            trilha = "flashback",
            cenas = __arrL(
                {
                    {
                        titulo = "A CAMINHO DO AEROPORTO",
                        cenario = 0,
                        hora = 7.4,
                        duracao = 4.6,
                        camera = {de = {x = 4300, y = 420, zoom = 1.4}, para = {x = 4600, y = 300, zoom = 1.2}, tempo = 4.4},
                        atores = __arrL(
                            {{
                                quem = "carro",
                                x = 4480,
                                ate = 4800,
                                tempo = __arrL({0.6, 4.4}, 2),
                                anim = "voando"
                            }},
                            1
                        ),
                        efeitos = __arrL({"raios", {tipo = "saida", t = 3.6, dur = 1}}, 2),
                        sons = __arrL({{som = "whoosh", t = 0.6}}, 1)
                    },
                    {
                        titulo = "A CAMINHO DO AEROPORTO",
                        fundo = "preto",
                        duracao = 2.4,
                        efeitos = __arrL({{
                            tipo = "cartao",
                            texto = "AEROPORTO DE ITABUNA",
                            sub = "ALGUNS MINUTOS DEPOIS",
                            t = 0.2,
                            dur = 2.1
                        }}, 1)
                    }
                },
                2
            )
        }
        __L1:registrar(raw)
        __L1:tocar(
            "c2j_carona",
            function()
                __L1:irPara(12, 300)
                __L1:tocarParte(
                    "c2_aeroporto",
                    0,
                    3,
                    function() return __L1:passo("checkin") end
                )
            end
        )
    end
    __L1.minijogo = function(self, etapa)
        if etapa == "checkin" then
            __L1:escolher(
                "MIGUEL",
                "O que você entrega no balcão do check-in?",
                __arrL({{t = "O passaporte", ok = true, r = "Isso! Agora pega o cartão de embarque e não perde."}, {t = "A carteirinha do colégio", r = "Da Roça... isso aí só abre a cantina."}, {t = "O boleto do açaí", r = "BOLETO?! Tu tá devendo açaí até pra companhia aérea?"}}, 3),
                function()
                    __L1:item("CARTÃO DE EMBARQUE")
                    __L1:passo("raiox")
                end
            )
        end
        if etapa == "raiox" then
            __L1:escolher(
                "MIGUEL",
                "O alarme do raio-X apitou. O que você tira?",
                __arrL({{t = "O cinto", ok = true, r = "Fivela de metal apita, Da Roça. Pode passar."}, {t = "O chapéu de palha", r = "Palha não apita... mas a fila inteira tá rindo do teu chapéu."}, {t = "Prender o peido", r = "O raio-X não pega isso. Graças a Deus."}}, 3),
                function()
                    __L1:sfx("plim")
                    __L1:passo("portao")
                end
            )
        end
        if etapa == "portao" then
            __L1:tocarParte(
                "c2_aeroporto",
                3,
                99,
                function() return __L1:escolher(
                    "AVISO",
                    "Depois de embarcar, você não poderá voltar para Itabuna. Continuar?",
                    __arrL({{t = "EMBARCAR", ok = true}, {t = "Ainda não", voltar = true}}, 2),
                    function()
                        __L1.S.flags.embarcou = 1
                        __L1:salvar()
                        __L1:tocar(
                            "c2_voo",
                            function() return __L1:tocar(
                                "c2_chegada",
                                function()
                                    __L1:irPara(12, 3600)
                                    __L1:passo("taxi1")
                                end
                            ) end
                        )
                    end,
                    true
                ) end
            )
        end
    end
    __L1.ferir = function(self, n, de)
        local ____t_59 = __t
        local ____t_58 = __t
        local ____t_56 = __t
        local ____temp_55 = if __t(__L1.morto) then __L1.morto else __L1.cut
        __O[980] = ____temp_55
        local ____temp_57 = if ____t_56(____temp_55) then __O[980] else __gt(if __t(__L1.P.inv) then __L1.P.inv else 0, 0)
        __O[981] = ____temp_57
        if ____t_59(if ____t_58(____temp_57) then __O[981] else __L1.viagem) then
            return
        end
        local ____temp_66 = n * 1.5
        local ____t_65 = __t
        local ____opt_62 = window.Difficulty
        if ____opt_62 ~= nil then
            ____opt_62 = ____opt_62.getSettings
        end
        local ____opt_result_64
        if ____opt_62 ~= nil then
            ____opt_result_64 = ____opt_62(____opt_62).incomingDamage
        end
        __O[982] = ____opt_result_64
        n = math.floor(____temp_66 * if ____t_65(____opt_result_64) then __O[982] else 1 + 0.5)
        local ____opt_69 = window.CampanhaPoderes
        if ____opt_69 ~= nil then
            ____opt_69 = ____opt_69.filtrarDano
        end
        local ____opt_result_71
        if ____opt_69 ~= nil then
            ____opt_result_71 = ____opt_69(____opt_69, n)
        end
        local ____opt_result_71_72 = ____opt_result_71
        if ____opt_result_71_72 == nil then
            ____opt_result_71_72 = n
        end
        n = ____opt_result_71_72
        if not __t(n) then
            __L1:sfx("plim")
            return
        end
        __L1.P.hp = math.max(0, __L1.P.hp - n)
        __L1.P.inv = 0.85
        __L1.P.vy = -280
        __L1.P.ground = false
        local ____L1_P_73, ____x_74 = __L1.P, "x"
        ____L1_P_73[____x_74] = ____L1_P_73[____x_74] + if __lt(__L1.P.x, de) then -1 else 1 * 36
        __L1.tremor = math.max(__L1.tremor, 7)
        __L1:sfx("impacto")
        __call(
            __L1.dano,
            "push",
            {
                x = __L1.P.x,
                y = __L1.P.y - 80,
                s = __add("-", n),
                t = 0
            }
        )
        if __L1.P.hp <= 0 then
            __L1:desmaiar()
        end
    end
    __L1.desmaiar = function(self)
        __L1.morto = true
        __call(__L1.keys, "clear")
        local el = window.document:createElement("div")
        el.className = "pausa"
        el.innerHTML = "<h2>VOCÊ DESMAIOU...</h2><p>O frio de Conquista não perdoa. Respire fundo e tente de novo: você volta no último ponto de controle, com a vida cheia.</p><button type=\"button\" data-a=\"de-novo\">▶ TENTAR DE NOVO</button>"
        el:addEventListener(
            "click",
            function(____, e)
                if __t(e.target:closest("button")) then
                    el:remove()
                    __L1:voltarDoDesmaio()
                end
            end
        )
        __L1.box:querySelector(".tela"):appendChild(el)
        window:setTimeout(
            function()
                local ____opt_75 = el:querySelector("button")
                return ____opt_75 and ____opt_75:focus()
            end,
            30
        )
    end
    __L1.telaFim = function(self)
        __call(__L1.keys, "clear")
        local el = window.document:createElement("div")
        el.className = "pausa"
        el.innerHTML = "<h2>CAMPANHA 2 COMPLETA!</h2><p>Da Roça foi até Vitória da Conquista de chinelo, enfrentou oito vilões e um ex-melhor amigo... e trouxe o trio de volta.<br><br>Obrigado por jogar!</p><button type=\"button\" data-a=\"explorar\">▶ CONTINUAR EXPLORANDO</button><button type=\"button\" data-a=\"menu\">VOLTAR AO MENU</button>"
        el:addEventListener(
            "click",
            function(____, e)
                local ____opt_77 = e.target:closest("button")
                if ____opt_77 ~= nil then
                    ____opt_77 = ____opt_77.dataset.a
                end
                local a = ____opt_77
                if not __t(a) then
                    return
                end
                el:remove()
                if a == "menu" then
                    __L1:fechar()
                end
            end
        )
        __L1.box:querySelector(".tela"):appendChild(el)
        __L1:sfx("fanfarra")
        window:setTimeout(
            function()
                local ____opt_79 = el:querySelector("button")
                return ____opt_79 and ____opt_79:focus()
            end,
            30
        )
    end
    __L1.voltarDoDesmaio = function(self)
        __L1.morto = false
        __L1.P.hp = if __t(__L1.P.max) then __L1.P.max else 100
        __L1.P.inv = 1.5
        local ____opt_81 = __L1.fase
        if ____opt_81 ~= nil then
            ____opt_81:reiniciar()
        end
        local cp = __L1.S.flags.cp
        if __t(cp) then
            __L1:irPara(cp.cena, cp.x)
        else
            local ____L1_irPara_88 = __L1.irPara
            local ____L1_cenaId_87 = __L1.cenaId
            local ____t_86 = __t
            local ____t_85 = __t
            local ____opt_83 = __get(__L1.PASSOS, __L1.S.passo)
            if ____opt_83 ~= nil then
                ____opt_83 = ____opt_83.fase
            end
            __O[983] = ____opt_83
            ____L1_irPara_88(__L1, ____L1_cenaId_87, if ____t_86(if ____t_85(____opt_83) then __L1.fase else __O[983]) then __L1.fase.F.checkpoint - 400 else __L1.P.x)
        end
        __L1:salvar()
    end
    __L1.faseAtual = function(self)
        local ____get_94 = __get
        local ____L1_PASSOS_93 = __L1.PASSOS
        local ____opt_91 = __L1.S
        if ____opt_91 ~= nil then
            ____opt_91 = ____opt_91.passo
        end
        local ____opt_89 = ____get_94(____L1_PASSOS_93, ____opt_91)
        if ____opt_89 ~= nil then
            ____opt_89 = ____opt_89.fase
        end
        local slug = ____opt_89
        local ____getq_97 = __getq
        local ____opt_95 = window.CampanhaFases
        if ____opt_95 ~= nil then
            ____opt_95 = ____opt_95.FASES
        end
        local F = if __t(slug) then ____getq_97(____opt_95, slug) else slug
        local ____t_100 = __t
        local ____t_99 = __t
        local ____temp_98 = not __t(F) or F.cena ~= __L1.cenaId
        __O[984] = ____temp_98
        if ____t_100(if ____t_99(____temp_98) then __O[984] else __get(
            __L1.S.flags,
            __add("venceu_", slug)
        )) then
            if __t(if __t(__L1.fase) then not __t(F) or F.cena ~= __L1.cenaId else __L1.fase) then
                __L1.fase = nil
            end
            return nil
        end
        if __t(not __t(__L1.fase) or __L1.fase.slug ~= slug) then
            __L1.fase = window.CampanhaFases:criar(slug, __L1.apiFase)
        end
        if __t(not __t(__L1.S.flags.cp) or __L1.S.flags.cp.cena ~= __L1.cenaId) then
            if __gt(__L1.P.x, F.checkpoint) then
                __L1.S.flags.cp = {cena = __L1.cenaId, x = F.checkpoint}
                __L1:salvar()
                __L1:aviso("PONTO DE CONTROLE")
            end
        end
        return __L1.fase
    end
    __L1.tocarDeslocado = function(self, id, xChefe, tipo, depois)
        local sc = __callq(
            __L1:RT(),
            "get",
            id
        )
        local ____t_104 = __t
        local ____opt_result_103
        if sc ~= nil then
            ____opt_result_103 = sc.raw
        end
        if not ____t_104(____opt_result_103) then
            if depois ~= nil then
                depois(nil)
            end
            return
        end
        local raw = window.JSON:parse(window.JSON:stringify(sc.raw))
        local ref = nil
        for ____, c0 in __iterar((raw.cenas)) do
            if __t(c0.fundo) then
                continue
            end
            local a = __call(
                if __t(c0.atores) then c0.atores else __arrL({}, 0),
                "find",
                function(____, q)
                    local ____t_108 = __t
                    local ____temp_107 = q.quem == tipo
                    __O[985] = ____temp_107
                    return if ____t_108(____temp_107) then __O[985] else tipo == "c2_ryan" and q.quem == "c2_ryan"
                end
            )
            if __t(a) then
                ref = a.x
                break
            end
        end
        local dx = if ref == nil then 0 else math.floor(xChefe - ref + 0.5)
        for ____, c0 in __iterar((raw.cenas)) do
            if __t(c0.fundo) then
                continue
            end
            if __t(c0.camera) then
                for ____, k in __iterar((__arrL({"de", "para"}, 2))) do
                    if __t(__get(c0.camera, k)) then
                        local ____get_result_109, ____x_110 = __get(c0.camera, k), "x"
                        ____get_result_109[____x_110] = ____get_result_109[____x_110] + dx
                    end
                end
            end
            for ____, a in __iterar((if __t(c0.atores) then c0.atores else __arrL({}, 0))) do
                a.x = a.x + dx
                if a.ate ~= nil then
                    a.ate = a.ate + dx
                end
            end
        end
        raw.id = __add(id, "_jogo")
        raw.substituir = true
        __L1:registrar(raw)
        __L1:tocar(raw.id, depois)
    end
    __L1.registrar = function(self, raw)
        __L1:safe(function() return __L1:RT():register(raw, "campanha2") end)
    end
    __L1.tocar = function(self, id, depois)
        if not __t(__callq(
            __L1:RT(),
            "has",
            id
        )) then
            if depois ~= nil then
                depois(nil)
            end
            return
        end
        __call(__L1.keys, "clear")
        __L1.P.vx = 0
        window.__somCutscene = __L1.som
        local s = __L1:RT():create(id, {})
        s.preview = true
        __L1.cut = {s = s, depois = depois, id = id}
        __L1:hudVisivel(false)
    end
    __L1.tocarParte = function(self, id, de, ate, depois)
        local sc = __callq(
            __L1:RT(),
            "get",
            id
        )
        local ____t_116 = __t
        local ____opt_result_115
        if sc ~= nil then
            ____opt_result_115 = sc.raw
        end
        if not ____t_116(____opt_result_115) then
            if depois ~= nil then
                depois(nil)
            end
            return
        end
        local raw = __assign(
            {},
            sc.raw,
            {
                id = __add(
                    __add(id, "_p"),
                    de
                ),
                substituir = true,
                cenas = __call(sc.raw.cenas, "slice", de, ate)
            }
        )
        __L1:registrar(raw)
        __L1:tocar(raw.id, depois)
    end
    __L1.avancarCut = function(self)
        if __t(__L1.cut) then
            __L1:RT():advance(__L1.cut.s)
        end
    end
    __L1.pularCut = function(self)
        if not __t(__L1.cut) then
            return
        end
        local n = 0
        while true do
            local ____t_121 = __t
            local ____temp_120 = not __t(__L1.cut.s.done)
            if ____temp_120 then
                local ____n_119 = n
                n = ____n_119 + 1
                ____temp_120 = ____n_119 < 999
            end
            if not ____t_121(____temp_120) then
                break
            end
            __L1:RT():advance(__L1.cut.s)
        end
    end
    __L1.conversa = function(self, npc)
        local fx = if __lt(__L1.P.x, npc.x) then 1 else -1
        local meio = (__L1.P.x + npc.x) / 2
        local raw = {
            id = "c2j_conversa",
            titulo = "Conversa",
            balao = true,
            substituir = true,
            cenas = __arrL(
                {{
                    titulo = "",
                    cenario = __L1.cenaId,
                    hora = __L1:horaAtual(),
                    camera = {de = {x = meio, y = 420, zoom = 1.7}, para = {x = meio, y = 420, zoom = 1.85}, tempo = 6},
                    atores = __arrL(
                        {
                            {
                                quem = "daroca",
                                x = math.floor(__L1.P.x + 0.5),
                                olhando = fx
                            },
                            {quem = npc.quem, x = npc.x, olhando = -fx}
                        },
                        2
                    ),
                    falas = __call(
                        npc.falas,
                        "map",
                        function(____, ____bindingPattern0)
                            local e
                            local txt
                            local q
                            q = ____bindingPattern0[1]
                            txt = ____bindingPattern0[2]
                            e = ____bindingPattern0[3]
                            return __assign({}, {quem = q, texto = txt}, if __t(e) then {emocao = e} else {})
                        end
                    )
                }},
                1
            )
        }
        __L1:registrar(raw)
        __L1:tocar(
            "c2j_conversa",
            function()
                __set(
                    __L1.S.flags,
                    __add("falou_", npc.id),
                    1
                )
                local ____this_123
                ____this_123 = npc
                local ____opt_122 = ____this_123.fim
                if ____opt_122 ~= nil then
                    ____opt_122(____this_123)
                end
                __L1:salvar()
            end
        )
    end
    __L1.irPara = function(self, id, x)
        __L1.cenaId = id
        local d = __L1:D()
        local ____L1_P_128 = __L1.P
        local ____L1_clamp_127 = __L1.clamp
        local ____x_126 = x
        local ____getq_result_124 = __getq(d.limites, 0)
        if ____getq_result_124 == nil then
            ____getq_result_124 = 40
        end
        local ____getq_result_125 = __getq(d.limites, 1)
        if ____getq_result_125 == nil then
            ____getq_result_125 = d.largura - 40
        end
        ____L1_P_128.x = ____L1_clamp_127(__L1, ____x_126, ____getq_result_124, ____getq_result_125)
        __L1.P.y = __L1.FLOOR
        __L1.P.vy = 0
        __L1.P.vx = 0
        __L1.P.ground = true
        __L1.P.seguroX = __L1.P.x
        __L1.cam = __L1:clamp(
            __L1.P.x - 360,
            0,
            math.max(0, d.largura - __L1.W)
        )
        __L1.viagem = nil
        __L1.fade = 0
        local ____id_129 = id
        __L1.S.cena = ____id_129
        local ____ = if __t(__L1.S) then ____id_129 else __L1.S
    end
    __L1.usar = function(self)
        local ____t_134 = __t
        local ____t_133 = __t
        local ____t_131 = __t
        local ____temp_130 = if __t(__L1.viagem) then __L1.viagem else not __t(__L1.perto)
        __O[986] = ____temp_130
        local ____temp_132 = if ____t_131(____temp_130) then __O[986] else __L1.cut
        __O[987] = ____temp_132
        if ____t_134(if ____t_133(____temp_132) then __O[987] else __L1.pausado) then
            return
        end
        local p = __L1.perto
        __call(__L1.keys, "clear")
        if p.tipo == "npc" then
            if __t(p.npc.falas) then
                __L1:conversa(p.npc)
            else
                local ____this_136
                ____this_136 = p.npc
                local ____opt_135 = ____this_136.fim
                if ____opt_135 ~= nil then
                    ____opt_135(____this_136)
                end
            end
            return
        end
        if p.tipo == "estacao" then
            p.est:acao()
            return
        end
        if __t(p.tipo == "item" or p.tipo == "aliado") then
            p:acao()
            return
        end
        if p.tipo == "extra" then
            if p.id == "loja" then
                local ____opt_139 = window.CampanhaLoja
                if ____opt_139 ~= nil then
                    ____opt_139 = ____opt_139.abrir
                end
                if ____opt_139 ~= nil then
                    ____opt_139(____opt_139, {})
                end
            else
                local ____opt_145 = window.CampanhaTaxi
                if ____opt_145 ~= nil then
                    ____opt_145 = ____opt_145.abrir
                end
                if ____opt_145 ~= nil then
                    ____opt_145(
                        ____opt_145,
                        __L1.cenaId,
                        function(____, cena, x)
                            __L1:irPara(cena, x + 120)
                            if __t(__L1.S.passo == "taxi1" and cena == 13) then
                                __L1:passo("lurdes")
                            else
                                local ____opt_142 = __get(__L1.PASSOS, __L1.S.passo)
                                if ____opt_142 ~= nil then
                                    ____opt_142 = ____opt_142.ir
                                end
                                if ____opt_142 == cena then
                                    __L1:passo(__get(__L1.PASSOS, __L1.S.passo).prox)
                                end
                            end
                            __L1:salvar()
                        end,
                        {liberado = if __L1.S.passo == "taxi1" then function(____, L) return if L.id == "t13" then {ok = true} else {ok = false, motivo = "Primeiro, a pensão. Você nem tem onde dormir!"} end else nil}
                    )
                end
            end
            return
        end
        if p.tipo == "poderes" then
            local ____opt_149 = window.CampanhaPoderes
            if ____opt_149 ~= nil then
                ____opt_149 = ____opt_149.abrirMural
            end
            if ____opt_149 ~= nil then
                ____opt_149(____opt_149, {})
            end
            return
        end
        if p.tipo == "conversa" then
            local ____opt_153 = window.CampanhaMoradores
            if ____opt_153 ~= nil then
                ____opt_153 = ____opt_153.conversar
            end
            if ____opt_153 ~= nil then
                ____opt_153(____opt_153, p.id)
            end
            return
        end
        if p.tipo == "armario" then
            local ____opt_157 = window.DarocaLook
            if ____opt_157 ~= nil then
                ____opt_157 = ____opt_157.open
            end
            if ____opt_157 ~= nil then
                ____opt_157(____opt_157, {title = "ARMÁRIO DO QUARTO 4", line = "Escolha a roupa do Da Roça para hoje."})
            end
            return
        end
        if p.tipo == "pc" then
            local ____opt_161 = window.Fliperama
            if ____opt_161 ~= nil then
                ____opt_161 = ____opt_161.open
            end
            if ____opt_161 ~= nil then
                ____opt_161(____opt_161, nil, {from = "quarto"})
            end
            return
        end
        if p.tipo == "rolante" then
            __L1.viagem = {
                tipo = "rolante",
                t = 0,
                dur = 2.2,
                de = __arrL({__L1.P.x, __L1.P.y}, 2),
                ini = p.de,
                fim = p.ate,
                para = p.para
            }
            return
        end
        __L1.viagem = {tipo = "porta", t = 0, para = p.para}
    end
    __L1.procurarPerto = function(self)
        __L1.perto = nil
        if __t(if __t(__L1.viagem) then __L1.viagem else not __t(__L1.P.ground)) then
            return
        end
        local best = 1000000000
        local d = __L1:D()
        local cand = __arrL({}, 0)
        for ____, p in __iterar((__L1:portais(d.id))) do
            if p.tipo ~= "rampa" then
                __call(cand, "push", p)
            end
        end
        for ____, n in __iterar((__L1.NPC)) do
            local ____t_167 = __t
            local ____t_166 = __t
            local ____t_164 = __t
            local ____temp_163 = n.cena == d.id
            __O[988] = ____temp_163
            local ____temp_165 = if ____t_164(____temp_163) then __call(n.quando, "includes", __L1.S.passo) else __O[988]
            __O[989] = ____temp_165
            if ____t_167(if ____t_166(____temp_165) then not __t(n.semFala) else __O[989]) then
                local ____call_176 = __call
                local ____n_x_175 = n.x
                local ____add_174 = __add
                local ____n_rotulo_173 = n.rotulo
                local ____t_172 = __t
                local ____t_171 = __t
                local ____t_169 = __t
                local ____get_result_168 = __get(
                    __L1.S.flags,
                    __add("falou_", n.id)
                )
                __O[990] = ____get_result_168
                local ____temp_170 = if ____t_169(____get_result_168) then n.id ~= "lucas" else __O[990]
                __O[991] = ____temp_170
                ____call_176(
                    cand,
                    "push",
                    {
                        tipo = "npc",
                        npc = n,
                        x = ____n_x_175,
                        rotulo = ____add_174(____n_rotulo_173, if ____t_172(if ____t_171(____temp_170) then n.id ~= "lurdes" else __O[991]) then " ✓" else ""),
                        botao = "FALAR"
                    }
                )
            end
        end
        for ____, e in __iterar((__L1.ESTACOES)) do
            local ____t_179 = __t
            local ____t_178 = __t
            local ____temp_177 = e.cena == d.id
            __O[992] = ____temp_177
            if ____t_179(if ____t_178(____temp_177) then not __t(e.quando) or e.quando == __L1.S.passo else __O[992]) then
                __call(cand, "push", {
                    tipo = "estacao",
                    est = e,
                    x = e.x,
                    rotulo = e.rotulo,
                    botao = e.botao
                })
            end
        end
        local ____t_182 = __t
        local ____t_181 = __t
        local ____temp_180 = d.id == 0 and __L1.S.passo == "passaporte"
        __O[993] = ____temp_180
        if ____t_182(if ____t_181(____temp_180) then __L1.P.y < __L1.FLOOR - 100 else __O[993]) then
            __call(
                cand,
                "push",
                {
                    tipo = "item",
                    x = 3456,
                    rotulo = "PEGAR O PASSAPORTE",
                    botao = "PEGAR",
                    acao = function()
                        __L1:item("PASSAPORTE")
                        __L1:sfx("fanfarra")
                        __L1:passo("lucas")
                    end
                }
            )
        end
        if __ge(d.id, 12) then
            local ____opt_185 = window.CampanhaMoradores
            if ____opt_185 ~= nil then
                ____opt_185 = ____opt_185.perto
            end
            local ____opt_result_187
            if ____opt_185 ~= nil then
                ____opt_result_187 = ____opt_185(____opt_185, d.id, __L1.P.x)
            end
            local m = ____opt_result_187
            if __t(m) then
                __call(
                    cand,
                    "push",
                    {
                        tipo = "conversa",
                        id = m.id,
                        x = m.x,
                        rotulo = __add(
                            "CONVERSAR COM ",
                            __call(m.nome, "toUpperCase")
                        ),
                        botao = "FALAR"
                    }
                )
            end
            for ____, X in __iterar((__arrL({window.CampanhaTaxi, window.CampanhaLoja}, 2))) do
                local ____opt_result_192
                if X ~= nil then
                    ____opt_result_192 = X.perto
                end
                local ____opt_result_193
                if ____opt_result_192 ~= nil then
                    ____opt_result_193 = ____opt_result_192(X, d.id, __L1.P.x)
                end
                local e = ____opt_result_193
                if __t(e) then
                    __call(
                        cand,
                        "push",
                        __assign({}, {tipo = "extra"}, e)
                    )
                end
            end
        end
        local ____iter_200 = __iter
        local ____t_199 = __t
        local ____opt_196 = window.CampanhaAliados
        if ____opt_196 ~= nil then
            ____opt_196 = ____opt_196.candidatos
        end
        local ____opt_result_198
        if ____opt_196 ~= nil then
            ____opt_result_198 = ____opt_196(____opt_196, d.id)
        end
        __O[994] = ____opt_result_198
        for ____, a in __TS__Iterator(____iter_200(if ____t_199(____opt_result_198) then __O[994] else __arrL({}, 0))) do
            __call(cand, "push", a)
        end
        for ____, p in __iterar((cand)) do
            local dd = math.abs(p.x - __L1.P.x)
            if __t(dd < 70 and dd < best) then
                best = dd
                __L1.perto = p
            end
        end
    end
    __L1.fisica = function(self, dt)
        local ____opt_201 = __L1.fase
        if ____opt_201 ~= nil then
            ____opt_201 = ____opt_201.luta
        end
        local duelo = ____opt_201
        local percurso = window.ConquistaCombate:terreno(duelo)
        if __t(percurso) then
            percurso:avancar(duelo, dt, __L1.P)
        end
        local d = __L1:D()
        local ____t_204 = __t
        local ____temp_203 = if __t(__call(__L1.keys, "has", "right")) then 1 else 0 - if __t(__call(__L1.keys, "has", "left")) then 1 else 0
        __O[995] = ____temp_203
        local dir = if ____t_204(____temp_203) then __O[995] else __TS__MathSign(math.floor(__L1.joy * 2 + 0.5))
        if __t(dir) then
            __L1.P.facing = dir
        end
        local ____t_210 = __t
        local ____opt_207 = __L1:TR()
        if ____opt_207 ~= nil then
            ____opt_207 = ____opt_207.dashing
        end
        local ____opt_result_209
        if ____opt_207 ~= nil then
            ____opt_result_209 = ____opt_207(____opt_207)
        end
        if not ____t_210(____opt_result_209) then
            local ____t_216 = __t
            local ____opt_213 = __L1:TR()
            if ____opt_213 ~= nil then
                ____opt_213 = ____opt_213.bonus
            end
            local ____opt_result_215
            if ____opt_213 ~= nil then
                ____opt_result_215 = ____opt_213(____opt_213).moveSpeed
            end
            __O[996] = ____opt_result_215
            local ____temp_223 = dir * if ____t_216(____opt_result_215) then __O[996] else 280
            local ____t_222 = __t
            local ____opt_219 = __L1:TR()
            if ____opt_219 ~= nil then
                ____opt_219 = ____opt_219.velocidade
            end
            local ____opt_result_221
            if ____opt_219 ~= nil then
                ____opt_result_221 = ____opt_219(____opt_219)
            end
            __O[997] = ____opt_result_221
            local ____temp_230 = ____temp_223 * if ____t_222(____opt_result_221) then __O[997] else 1 * if __gt(if __t(__L1.P.atordoado) then __L1.P.atordoado else 0, 0) then 0.4 else 1
            local ____t_229 = __t
            local ____opt_226 = window.CampanhaAliados
            if ____opt_226 ~= nil then
                ____opt_226 = ____opt_226.velocidade
            end
            local ____opt_result_228
            if ____opt_226 ~= nil then
                ____opt_result_228 = ____opt_226(____opt_226)
            end
            __O[998] = ____opt_result_228
            local alvo = ____temp_230 * if ____t_229(____opt_result_228) then __O[998] else 1
            local ac = if __t(dir) then if __t(__L1.P.ground) then 1800 else 1150 else if __t(__L1.P.ground) then 2200 else 950
            local ____L1_P_231, ____vx_232 = __L1.P, "vx"
            ____L1_P_231[____vx_232] = ____L1_P_231[____vx_232] + __L1:clamp(alvo - __L1.P.vx, -ac * dt, ac * dt)
            if math.abs(__L1.P.vx) < 0.1 then
                __L1.P.vx = 0
            end
        end
        __L1.P.anim = if __t(__L1.P.anim) then __L1.P.anim else 0 + math.abs(__L1.P.vx) * dt / 18.3
        local lim = if __t(d.limites) then d.limites else __arrL({40, d.largura - 40}, 2)
        __L1.P.x = __L1:clamp(
            __L1.P.x + __L1.P.vx * dt,
            __get(lim, 0),
            __get(lim, 1)
        )
        local prevY = __L1.P.y
        local chao0 = __L1.P.ground
        __L1.P.vy = math.min(900, __L1.P.vy + 850 * dt)
        local ____L1_P_233, ____y_234 = __L1.P, "y"
        ____L1_P_233[____y_234] = ____L1_P_233[____y_234] + __L1.P.vy * dt
        __L1.P.ground = false
        if __L1.P.y < 95 then
            __L1.P.y = 95
            __L1.P.vy = math.max(0, __L1.P.vy)
        end
        if __t(percurso) then
            percurso:pousar(duelo, __L1.P, prevY, __L1.ferir)
            local ____t_237 = __t
            local ____t_236 = __t
            local ____temp_235 = not __t(chao0)
            __O[999] = ____temp_235
            if ____t_237(if ____t_236(____temp_235) then __L1.P.ground else __O[999]) then
                __L1.P.landTimer = 0.15
            end
            __L1.P.landTimer = math.max(0, if __t(__L1.P.landTimer) then __L1.P.landTimer else 0 - dt)
            return
        end
        if __L1.P.y > __L1.FLOOR + 2 then
            for ____, ____value in __iterar((if __t(d.vaos) then d.vaos else __arrL({}, 0))) do
                local gx = ____value[1]
                local gw = ____value[2]
                if __t(__gt(__L1.P.x, gx) and __lt(
                    __L1.P.x,
                    __add(gx, gw)
                )) then
                    __L1.P.x = __L1:clamp(
                        __L1.P.x,
                        gx + 11,
                        __add(gx, gw) - 11
                    )
                    local ____t_240 = __t
                    local ____t_239 = __t
                    local ____temp_238 = math.abs(__L1.P.vx) > 0
                    __O[1000] = ____temp_238
                    if ____t_240(if ____t_239(____temp_238) then __L1.P.x == gx + 11 or __L1.P.x == __add(gx, gw) - 11 else __O[1000]) then
                        __L1.P.vx = 0
                    end
                end
            end
        end
        local overGap = __call(
            if __t(d.vaos) then d.vaos else __arrL({}, 0),
            "some",
            function(____, ____bindingPattern0)
                local gw
                local gx
                gx = ____bindingPattern0[1]
                gw = ____bindingPattern0[2]
                return __gt(__L1.P.x, gx + 10) and __L1.P.x < __add(gx, gw) - 10
            end
        )
        for ____, r in __iterar((__L1:portais(d.id))) do
            local ____t_243 = __t
            local ____t_242 = __t
            local ____temp_241 = r.tipo == "rampa" and __ge(__L1.P.x, r.x0)
            __O[1001] = ____temp_241
            if ____t_243(if ____t_242(____temp_241) then __le(__L1.P.x, r.x1) else __O[1001]) then
                local ry = r.y0 + (r.y1 - r.y0) * (__L1.P.x - r.x0) / (r.x1 - r.x0)
                local ____t_246 = __t
                local ____t_245 = __t
                local ____temp_244 = __L1.P.vy >= 0 and __L1.P.y >= ry - 14
                __O[1002] = ____temp_244
                if ____t_246(if ____t_245(____temp_244) then __le(prevY, ry + 40) else __O[1002]) then
                    __L1.P.y = ry
                    __L1.P.vy = 0
                    __L1.P.ground = true
                end
                local ____t_251 = __t
                local ____t_250 = __t
                local ____t_248 = __t
                local ____temp_247 = __L1.P.x >= r.x1 - 4
                __O[1003] = ____temp_247
                local ____temp_249 = if ____t_248(____temp_247) then __L1.P.ground else __O[1003]
                __O[1004] = ____temp_249
                if ____t_251(if ____t_250(____temp_249) then dir > 0 else __O[1004]) then
                    __L1.viagem = {tipo = "porta", t = 0, para = r.para}
                end
            end
        end
        if __t(__L1.P.vy >= 0 and not __t(__L1.P.ground)) then
            for ____, ____value in __iterar((if __t(d.plataformas) then d.plataformas else __arrL({}, 0))) do
                local px = ____value[1]
                local py = ____value[2]
                local pw = ____value[3]
                local ____t_256 = __t
                local ____t_255 = __t
                local ____t_253 = __t
                local ____temp_252 = __L1.P.x > px - 6 and __lt(
                    __L1.P.x,
                    __add(px, pw) + 6
                )
                __O[1005] = ____temp_252
                local ____temp_254 = if ____t_253(____temp_252) then __le(prevY, py + 2) else __O[1005]
                __O[1006] = ____temp_254
                if ____t_256(if ____t_255(____temp_254) then __ge(__L1.P.y, py) else __O[1006]) then
                    __L1.P.y = py
                    __L1.P.vy = 0
                    __L1.P.ground = true
                end
            end
            local ____t_259 = __t
            local ____t_258 = __t
            local ____temp_257 = not __t(__L1.P.ground) and not __t(overGap)
            __O[1007] = ____temp_257
            if ____t_259(if ____t_258(____temp_257) then __L1.P.y >= __L1.FLOOR else __O[1007]) then
                __L1.P.y = __L1.FLOOR
                __L1.P.vy = 0
                __L1.P.ground = true
            end
        end
        local ____t_262 = __t
        local ____t_261 = __t
        local ____temp_260 = not __t(chao0)
        __O[1008] = ____temp_260
        if ____t_262(if ____t_261(____temp_260) then __L1.P.ground else __O[1008]) then
            __L1.P.landTimer = 0.15
        end
        __L1.P.landTimer = math.max(0, if __t(__L1.P.landTimer) then __L1.P.landTimer else 0 - dt)
        local ____t_265 = __t
        local ____t_264 = __t
        local ____temp_263 = if __t(__L1.P.ground) then not __t(overGap) else __L1.P.ground
        __O[1009] = ____temp_263
        if ____t_265(if ____t_264(____temp_263) then __L1.P.y >= __L1.FLOOR - 1 else __O[1009]) then
            __L1.P.seguroX = __L1.P.x
        end
        if __L1.P.y > 600 then
            local g = __call(
                if __t(d.vaos) then d.vaos else __arrL({}, 0),
                "find",
                function(____, ____bindingPattern0)
                    local gw
                    local gx
                    gx = ____bindingPattern0[1]
                    gw = ____bindingPattern0[2]
                    return __L1.P.x > gx - 20 and __lt(
                        __L1.P.x,
                        __add(gx, gw) + 20
                    )
                end
            )
            local ____L1_P_seguroX_266 = __L1.P.seguroX
            if ____L1_P_seguroX_266 == nil then
                ____L1_P_seguroX_266 = __L1.P.x - 260
            end
            local sx = ____L1_P_seguroX_266
            __L1.P.x = if __t(g) then if __le(
                sx,
                __get(g, 0) + __get(g, 1) / 2
            ) then __get(g, 0) - 40 else __add(
                __get(g, 0),
                __get(g, 1)
            ) + 40 else sx
            __L1.P.x = __L1:clamp(
                __L1.P.x,
                __get(lim, 0),
                __get(lim, 1)
            )
            __L1.P.y = __L1.FLOOR
            __L1.P.vy = 0
            __L1.P.vx = 0
            __L1.P.ground = true
            __L1.P.inv = math.max(if __t(__L1.P.inv) then __L1.P.inv else 0, 1)
            __L1.P.hp = math.max(1, __L1.P.hp - 10)
            __L1:aviso("Ai! Cuidado com o buraco.")
        end
    end
    __L1.andarViagem = function(self, dt)
        local v = __L1.viagem
        v.t = __add(v.t, dt)
        if v.tipo == "rolante" then
            local u = math.min(1, v.t / v.dur)
            local k = if u < 0.15 then 0 else (u - 0.15) / 0.85
            __L1.P.x = if k <= 0 then __get(v.de, 0) + (__get(v.ini, 0) - __get(v.de, 0)) * (u / 0.15) else __get(v.ini, 0) + (__get(v.fim, 0) - __get(v.ini, 0)) * k
            __L1.P.y = if k <= 0 then __L1.FLOOR else __get(v.ini, 1) + (__get(v.fim, 1) - __get(v.ini, 1)) * k
            __L1.P.facing = if __gt(
                __get(v.fim, 0),
                __get(v.ini, 0)
            ) then 1 else -1
            __L1.P.vx = 0
            __L1.P.ground = true
            __L1.fade = math.max(0, (u - 0.78) / 0.22)
            if u >= 1 then
                __L1:irPara(v.para.cena, v.para.x)
                __L1.viagem = {tipo = "chegada", t = 0}
            end
            return
        end
        if v.tipo == "porta" then
            __L1.fade = math.min(1, v.t / 0.35)
            __L1.P.vx = 0
            if __ge(v.t, 0.35) then
                __L1:irPara(v.para.cena, v.para.x)
                __L1.viagem = {tipo = "chegada", t = 0}
                __L1:salvar()
            end
            return
        end
        if v.tipo == "chegada" then
            __L1.fade = math.max(0, 1 - v.t / 0.35)
            if __ge(v.t, 0.35) then
                __L1.viagem = nil
                __L1.fade = 0
            end
        end
    end
    __L1.pular = function(self)
        local ____t_269 = __t
        local ____t_268 = __t
        local ____temp_267 = if __t(__L1.P.ground) then not __t(__L1.viagem) else __L1.P.ground
        __O[1010] = ____temp_267
        if ____t_269(if ____t_268(____temp_267) then not __t(__L1.cut) else __O[1010]) then
            local ____L1_P_276 = __L1.P
            local ____t_275 = __t
            local ____opt_272 = __L1.fase
            if ____opt_272 ~= nil then
                ____opt_272 = ____opt_272.luta
            end
            local ____opt_result_274
            if ____opt_272 ~= nil then
                ____opt_result_274 = ____opt_272.estrada
            end
            ____L1_P_276.vy = if ____t_275(____opt_result_274) then -405 else -365
            __L1.P.ground = false
            local ____opt_279 = __L1:TR()
            if ____opt_279 ~= nil then
                ____opt_279 = ____opt_279.som
            end
            if ____opt_279 ~= nil then
                ____opt_279(____opt_279, 320, 0.06, "triangle")
            end
        end
    end
    __L1.fardo = function(self, x, top, n)
        do
            local k = 0
            while __lt(k, n) do
                local y = __L1.FLOOR - (k + 1) * 28
                __L1.c.fillStyle = "#3a2a14"
                __L1.c:fillRect(x - 1, y - 1, 52, 30)
                __L1.c.fillStyle = "#d8b04a"
                __L1.c:fillRect(x, y, 50, 28)
                __L1.c.fillStyle = "#e8c86a"
                __L1.c:fillRect(x, y, 50, 4)
                do
                    local j = 4
                    while j < 50 do
                        __L1.c.fillStyle = "#b8902a"
                        __L1.c:fillRect(x + j, y + 6, 2, 20)
                        j = j + 6
                    end
                end
                __L1.c.fillStyle = "#7a4a2a"
                __L1.c:fillRect(x + 14, y, 3, 28)
                __L1.c:fillRect(x + 33, y, 3, 28)
                k = k + 1
            end
        end
    end
    __L1.desenharExtras = function(self)
        local d = __L1:D()
        if d.id == 0 then
            __L1:fardo(3280, 412, 1)
            __L1:fardo(3330, 384, 2)
            __L1:fardo(3380, 356, 3)
            __L1:fardo(3430, 328, 4)
            if __L1.S.passo == "passaporte" then
                local b = math.sin(__L1.t * 3) * 3
                local x = 3448
                local y = 290 + b
                __L1.c.fillStyle = "#2a1a3a"
                __L1.c:fillRect(x - 1, y - 1, 18, 24)
                __L1.c.fillStyle = "#3c3a8a"
                __L1.c:fillRect(x, y, 16, 22)
                __L1.c.fillStyle = "#e8c24c"
                __L1.c:fillRect(x + 4, y + 6, 8, 8)
                __L1.c:fillRect(x + 3, y + 16, 10, 2)
                do
                    local k = 0
                    while k < 4 do
                        if math.sin(__L1.t * 5 + k * 1.7) > 0.4 then
                            local sx = x + 8 + math.cos(k * 1.6 + __L1.t) * 20
                            local sy = y + 10 + math.sin(k * 2 + __L1.t) * 16
                            __L1.c.fillStyle = "#fff3a8"
                            __L1.c:fillRect(sx, sy - 3, 2, 8)
                            __L1.c:fillRect(sx - 3, sy, 8, 2)
                        end
                        k = k + 1
                    end
                end
            end
            if __L1.S.passo == "lucas" then
                __L1.c:save()
                __L1.c:translate(4640, 0)
                __L1.c:scale(-1, 1)
                __L1:safe(function() return window.Art:drawVehicle(__L1.c, 0, __L1.FLOOR, __L1.t) end)
                __L1.c:restore()
            end
        end
        for ____, n in __iterar((__L1.NPC)) do
            local ____t_283 = __t
            local ____t_282 = __t
            local ____temp_281 = n.cena == d.id
            __O[1011] = ____temp_281
            if ____t_283(if ____t_282(____temp_281) then __call(n.quando, "includes", __L1.S.passo) else __O[1011]) then
                __L1:safe(function() return window.Art:drawCharacter(
                    __L1.c,
                    n.quem,
                    n.x,
                    __L1.FLOOR,
                    {frame = __L1.t, facing = if __L1.P.x < n.x then -1 else 1, grounded = true, cache = true}
                ) end)
            end
        end
        local ____t_286 = __t
        local ____t_285 = __t
        local ____temp_284 = d.id == 12
        __O[1012] = ____temp_284
        if ____t_286(if ____t_285(____temp_284) then __call(
            __arrL({"checkin", "raiox", "portao"}, 3),
            "includes",
            __L1.S.passo
        ) else __O[1012]) then
            local e = __call(
                __L1.ESTACOES,
                "find",
                function(____, q) return q.quando == __L1.S.passo end
            )
            if __t(e) then
                local y = __L1.FLOOR - 128 + math.sin(__L1.t * 4) * 4
                __L1.c.fillStyle = "#ffd24a"
                __L1.c:beginPath()
                __L1.c:moveTo(e.x - 10, y - 12)
                __L1.c:lineTo(e.x + 10, y - 12)
                __L1.c:lineTo(e.x, y)
                __call(__L1.c, "fill")
            end
        end
    end
    __L1.setaObjetivo = function(self)
        local p = __get(__L1.PASSOS, __L1.S.passo)
        local ____t_289 = __t
        local ____t_288 = __t
        local ____temp_287 = not __t(p)
        __O[1013] = ____temp_287
        if ____t_289(if ____t_288(____temp_287) then __O[1013] else __L1.cut) then
            return
        end
        local alvo = if p.cena == __L1.cenaId then p.alvo else __getq(p.via, __L1.cenaId)
        if alvo == nil then
            return
        end
        local sx = alvo - __L1.cam
        local b = math.sin(__L1.t * 5) * 5
        if __t(sx > 30 and sx < __L1.W - 30) then
            local y = __L1.FLOOR - 170 + b
            __L1.c.fillStyle = "#2a1a10"
            __L1.c:beginPath()
            __L1.c:moveTo(sx - 14, y - 18)
            __L1.c:lineTo(sx + 14, y - 18)
            __L1.c:lineTo(sx, y + 2)
            __call(__L1.c, "fill")
            __L1.c.fillStyle = "#ffd24a"
            __L1.c:beginPath()
            __L1.c:moveTo(sx - 10, y - 15)
            __L1.c:lineTo(sx + 10, y - 15)
            __L1.c:lineTo(sx, y - 2)
            __call(__L1.c, "fill")
        else
            local dir = if sx < 0 then -1 else 1
            local x = if dir < 0 then 24 else __L1.W - 24
            local y = 300
            __L1.c.fillStyle = "#2a1a10"
            __L1.c:beginPath()
            __L1.c:moveTo(x + dir * (8 + b), y)
            __L1.c:lineTo(x - dir * (14 - b), y - 16)
            __L1.c:lineTo(x - dir * (14 - b), y + 16)
            __call(__L1.c, "fill")
            __L1.c.fillStyle = "#ffd24a"
            __L1.c:beginPath()
            __L1.c:moveTo(x + dir * (5 + b), y)
            __L1.c:lineTo(x - dir * (10 - b), y - 11)
            __L1.c:lineTo(x - dir * (10 - b), y + 11)
            __call(__L1.c, "fill")
        end
    end
    __L1.css = function(self)
        if __t(window.document:getElementById("c2jCss")) then
            return
        end
        do
            local txt = ""
            for ____, sh in __iterar((window.document.styleSheets)) do
                local rules
                do
                    local ____hasContinued
                    local function ____catch(e)
                        ____hasContinued = true
                        return
                    end
                    local ____try, ____hasReturned = pcall(function()
                        rules = sh.cssRules
                    end)
                    if not ____try then
                        ____catch(____hasReturned)
                    end
                    if ____hasContinued then
                        continue
                    end
                end
                for ____, r in __iterar((if __t(rules) then rules else __arrL({}, 0))) do
                    local sel = r.selectorText
                    local ____t_292 = __t
                    local ____t_291 = __t
                    local ____temp_290 = not __t(sel) or not __re_test(
                        __re("move-joystick|joystick-knob|joystick-directions", ""),
                        sel
                    )
                    __O[1014] = ____temp_290
                    if ____t_292(if ____t_291(____temp_290) then __O[1014] else __re_test(
                        __re("arena|\\.is-|immersive|engaged-off", ""),
                        sel
                    )) then
                        continue
                    end
                    txt = __add(
                        txt,
                        __add(
                            __call(
                                r.cssText,
                                "replace",
                                sel,
                                __call(
                                    __call(
                                        __call(sel, "split", ","),
                                        "map",
                                        function(____, x) return __add(
                                            ".c2j ",
                                            __call(
                                                __re_replace(
                                                    x,
                                                    __re("#gameShell\\s*|\\.crafted-controls\\s*|\\.touch-controls\\s*|\\.game-shell\\s*", "g"),
                                                    ""
                                                ),
                                                "trim"
                                            )
                                        ) end
                                    ),
                                    "join",
                                    ","
                                )
                            ),
                            "\n"
                        )
                    )
                end
            end
            local sj = window.document:createElement("style")
            sj.id = "c2jJoyCss"
            sj.textContent = __add(txt, ".c2j .move-joystick{width:102px;height:102px}")
            window.document.head:appendChild(sj)
        end
        local st = window.document:createElement("style")
        st.id = "c2jCss"
        st.textContent = ".c2j{position:fixed;inset:0;z-index:100000;background:#06080c;display:flex;align-items:center;justify-content:center;font-family:Pixel,monospace;color:#f6ead0;touch-action:none;user-select:none;-webkit-user-select:none}#c2Painel{display:block;overflow-y:auto;touch-action:pan-y;-webkit-overflow-scrolling:touch}#c2Painel .pausa{min-height:100%;box-sizing:border-box;padding:14px 0}@media (max-height:440px){#c2Painel .pausa{gap:6px!important;padding:8px 0}#c2Painel .pausa h2{margin:2px 0}#c2Painel .pausa p{margin:0 0 2px}}.c2j[hidden]{display:none}\n.c2j .tela{position:relative;width:min(100vw,177.78vh);aspect-ratio:16/9;max-height:100vh}.c2j canvas.mundo{width:100%;height:100%;display:block;image-rendering:pixelated}\n.c2j .hud{position:absolute;inset:0;pointer-events:none}.c2j .hud>*{pointer-events:auto}\n.c2j .vida{position:absolute;left:1.6%;top:2.4%;display:flex;flex-direction:column;gap:4px;background:#2a1e14e6;border:3px solid #8a6a3a;box-shadow:0 0 0 2px #120c08;padding:6px 8px}\n.c2j .vida .cor{display:flex;gap:3px}.c2j .vida .cor i{width:14px;height:12px;background:#5a2a24;clip-path:polygon(0 25%,25% 0,50% 25%,75% 0,100% 25%,100% 50%,50% 100%,0 50%)}.c2j .vida .cor i.on{background:#e8433a}.c2j .vida .cor i.meio{background:linear-gradient(90deg,#e8433a 50%,#5a2a24 50%)}\n.c2j .vida .gas{height:6px;width:96px;background:#1c1408;border:1px solid #6a5a3a}.c2j .vida .gas b{display:block;height:100%;background:linear-gradient(#9ae06a,#4a9a3a)}.c2j .vida .moedas{font-size:9px;color:#ffd24a}.c2j .vida .papeis{font-size:9px;color:#fff1bf}.c2j.c1-topo .hud .vida,.c2j.c1-topo .hud .menu{display:none!important}.c2j.c1-topo .obj{top:clamp(54px,13%,80px)!important}#c2GameShell .game-topbar{pointer-events:auto}#c2GameShell #travelBtn{display:none!important}.c2j.preencher{display:block}.c2j.preencher .tela{position:absolute;left:0;top:0;width:100vw;height:56.25vw;max-height:none;aspect-ratio:auto;top:var(--c2-pan,0px)}.c2j.preencher .tela>.hud,.c2j.preencher .tela>.pular,.c2j.preencher .tela>.pausa,.c2j.preencher .tela>.escolha,.c2j.preencher .tela>.c2-editor{position:fixed}\n.c2j .obj{position:absolute;left:50%;top:2.4%;transform:translateX(-50%);max-width:52%;background:#f2dc9ae8;color:#3a2412;border:3px solid #2a1a10;padding:6px 10px;font:clamp(9px,1.25vw,13px) Space,Arial,sans-serif;line-height:1.35;box-shadow:3px 4px 0 #0006}\n.c2j .obj b{display:block;font:clamp(7px,.8vw,9px) Pixel,monospace;color:#8a4a2a;margin-bottom:2px}.c2j .obj.novo{animation:c2jObj .8s cubic-bezier(.2,1.6,.4,1)}@keyframes c2jObj{from{transform:translateX(-50%) scale(.6);opacity:0}}\n.c2j .menu{position:absolute;right:1.6%;top:2.4%;width:42px;height:42px;font:16px Pixel,monospace;background:#4a3420;color:#f6ead0;border:3px solid #e8c66a;box-shadow:0 4px 0 #2a1a10;cursor:pointer}\n.c2j .entrar{position:absolute;right:3%;bottom:30%;font:12px Pixel,monospace;padding:12px 16px;background:#e8a83a;color:#1c1408;border:3px solid #fff2c8;border-radius:6px;cursor:pointer;box-shadow:0 4px 0 #8a5a1a}\n.c2j .avisos{position:absolute;left:50%;top:18%;transform:translateX(-50%);display:flex;flex-direction:column;gap:6px;align-items:center;pointer-events:none}.c2j .avisos div{background:#1c1408e8;border:2px solid #e8c66a;padding:8px 14px;font-size:10px;color:#ffe9a8;animation:c2jObj .5s}\n.c2j .item{position:absolute;left:50%;top:40%;transform:translate(-50%,-50%);background:#2a1e14f2;border:4px solid #ffd24a;box-shadow:0 0 0 4px #120c08,0 0 40px #ffd24a66;padding:16px 26px;text-align:center;animation:c2jObj .6s}.c2j .item small{display:block;font-size:9px;color:#c8b48a;margin-bottom:6px}.c2j .item b{font-size:16px;color:#ffd24a}\n.c2j .escolha{position:absolute;inset:0;background:#0008;display:flex;align-items:flex-end;justify-content:center;padding-bottom:6%}.c2j .escolha .cx{background:#fff6dc;color:#3a2412;border:4px solid #2a1a10;box-shadow:4px 6px 0 #0008;padding:14px 16px;width:min(560px,86%);font:14px Space,Arial,sans-serif;line-height:1.4}\n.c2j .escolha .cx b{display:inline-block;font:9px Pixel,monospace;background:#2c6ab8;color:#fff;padding:3px 7px;margin-bottom:8px}.c2j .escolha .ops{display:flex;flex-direction:column;gap:6px;margin-top:10px}.c2j .escolha button{font:12px Space,Arial,sans-serif;text-align:left;padding:9px 12px;background:#f2dc9a;color:#3a2412;border:3px solid #2a1a10;cursor:pointer}.c2j .escolha button:hover,.c2j .escolha button:focus-visible{background:#ffd24a;outline:none}.c2j .escolha .resp{margin-top:8px;color:#a8341a;min-height:1.4em}\n.c2j .pausa{position:absolute;inset:0;background:#06080cd8;display:flex;flex-direction:column;align-items:center;justify-content:center;gap:10px}.c2j .pausa h2{font-size:20px;color:#ffd98a;margin:0 0 6px}.c2j .pausa button{font:12px Pixel,monospace;min-width:240px;padding:12px;background:#4a3420;color:#f6ead0;border:3px solid #e8c66a;box-shadow:0 4px 0 #2a1a10;cursor:pointer}.c2j .pausa button:hover,.c2j .pausa button:focus-visible{background:#e8c66a;color:#2a1e14;outline:none}.c2j .pausa p{font-size:9px;color:#c8b48a;max-width:420px;text-align:center;line-height:1.7}\n.c2j .pular{position:absolute;right:1.6%;bottom:4%;font:10px Pixel,monospace;padding:8px 12px;background:#1c1408cc;color:#f6ead0;border:2px solid #e8c66a;cursor:pointer}\n.c2j .joy{position:absolute!important;left:3%;bottom:5%;touch-action:none}\n@media (pointer:fine){.c2j .joy{display:none}}\n.c2j .c2-treino-ctl{gap:6px!important}.c2j .c2-treino-ctl .touch-btn{width:clamp(40px,6.2vw,60px)!important;height:clamp(40px,6.2vw,60px)!important;min-width:0!important;min-height:0!important;padding:0!important}.c2j .c2-treino-ctl .touch-btn svg{width:46%!important;height:46%!important}.c2j .c2-treino-ctl .touch-btn small{font-size:clamp(5px,.75vw,8px)!important}\n.c2j .entrar{bottom:auto;top:24%;right:3%}"
        window.document.head:appendChild(st)
    end
    __L1.montar = function(self)
        __L1:css()
        __L1.box = window.document:createElement("div")
        __L1.box.className = "c2j"
        __L1.box.hidden = true
        __L1.box.innerHTML = "<div class=\"tela\"><canvas class=\"mundo\" width=\"960\" height=\"540\"></canvas><div class=\"hud\"><div class=\"vida\"><div class=\"cor\"></div><div class=\"gas\"><b></b></div><div class=\"moedas\"></div><div class=\"papeis\"></div></div><div class=\"obj\"><b>OBJETIVO</b><span></span></div><button type=\"button\" class=\"menu\" aria-label=\"Pausa\">☰</button><button type=\"button\" class=\"entrar\" hidden></button><div class=\"joy move-joystick\"><span class=\"joystick-directions\" aria-hidden=\"true\"></span><span class=\"joystick-knob\" aria-hidden=\"true\"><i></i></span></div></div><div class=\"avisos\"></div><button type=\"button\" class=\"pular\" hidden>PULAR CENA ▶▶</button></div>"
        window.document.body:appendChild(__L1.box)
        __L1.box:addEventListener("click", __L1.interceptarTopo, true)
        __L1.box:addEventListener("pointerdown", __L1.interceptarTopo, true)
        __L1.cv = __L1.box:querySelector("canvas.mundo")
        __L1.c = __L1.cv:getContext("2d", {alpha = false})
        __L1.c.imageSmoothingEnabled = false
        __L1.hud = __L1.box:querySelector(".hud")
        __L1.box:querySelector(".menu"):addEventListener(
            "click",
            function() return __L1:pausar(true) end
        )
        __L1.box:querySelector(".entrar"):addEventListener("click", __L1.usar)
        __L1.box:querySelector(".pular"):addEventListener(
            "click",
            function(____, e)
                e:stopPropagation()
                __L1:pularCut()
            end
        )
        __L1.cv:addEventListener(
            "pointerdown",
            function()
                if __t(__L1.cut) then
                    __L1:avancarCut()
                end
            end
        )
        __L1.box:addEventListener(
            "pointerdown",
            function(____, e)
                local ____t_297 = __t
                local ____t_294 = __t
                local ____temp_293 = not __t(__L1.cut) or e.target == __L1.cv
                __O[1015] = ____temp_293
                local ____this_296
                ____this_296 = e.target
                local ____opt_295 = ____this_296.closest
                if ____opt_295 ~= nil then
                    ____opt_295 = ____opt_295(____this_296, "button, .escolha, .pausa, input, a")
                end
                if ____t_297(if ____t_294(____temp_293) then __O[1015] else ____opt_295) then
                    return
                end
                __L1:avancarCut()
            end
        )
        do
            local pad = __L1.box:querySelector(".joy")
            local orig = window.document:querySelector("#moveJoystick .joystick-directions")
            if __t(orig) then
                pad:querySelector(".joystick-directions").innerHTML = orig.innerHTML
            end
            __L1:ligarJoy(pad)
        end
        local ____opt_300 = __L1:TR()
        if ____opt_300 ~= nil then
            ____opt_300 = ____opt_300.montarBarra
        end
        if ____opt_300 ~= nil then
            ____opt_300(
                ____opt_300,
                __L1.box:querySelector(".tela"),
                __L1.acionarBotao
            )
        end
        window:addEventListener("keydown", __L1.teclaDown, true)
        window:addEventListener("keyup", __L1.teclaUp, true)
    end
    __L1.ligarJoy = function(self, pad)
        local ____t_304 = __t
        local ____t_303 = __t
        local ____temp_302 = not __t(pad)
        __O[1016] = ____temp_302
        if ____t_304(if ____t_303(____temp_302) then __O[1016] else pad.dataset.c2Ligado) then
            return
        end
        pad.dataset.c2Ligado = "1"
        local knob = pad:querySelector(".joystick-knob")
        local pid = nil
        local function mover(____, e)
            if e.pointerId ~= pid then
                return
            end
            local r = pad:getBoundingClientRect()
            local x = (e.clientX - (r.left + r.width / 2)) / (r.width * 0.34)
            x = __L1:clamp(x, -1, 1)
            __L1.joy = if math.abs(x) > 0.25 then x else 0
            if __t(knob) then
                knob.style.transform = ("translateX(" .. tostring(x * r.width * 0.34)) .. "px)"
            end
        end
        pad:addEventListener(
            "pointerdown",
            function(____, e)
                pid = e.pointerId
                __call(pad.classList, "add", "engaged", "active")
                do
                    pcall(function()
                        pad:setPointerCapture(pid)
                    end)
                end
                mover(nil, e)
                e:preventDefault()
            end
        )
        pad:addEventListener("pointermove", mover)
        local function solta(____, e)
            if e.pointerId ~= pid then
                return
            end
            pid = nil
            __L1.joy = 0
            if __t(knob) then
                knob.style.transform = ""
            end
            pad.classList:remove("engaged", "active")
        end
        pad:addEventListener("pointerup", solta)
        pad:addEventListener("pointercancel", solta)
    end
    __L1.acionarBotao = function(self, id, down)
        if __t(__L1.cut) then
            if __t(down) then
                __L1:avancarCut()
            end
            return
        end
        if __t(__L1.pausado) then
            return
        end
        if __t(__L1:TR():acao(id, down, __L1.P)) then
            return
        end
        if id == "jump" then
            if __t(down) then
                __call(__L1.keys, "add", "jump")
                __L1:pular()
            else
                __call(__L1.keys, "delete", "jump")
            end
        end
        local ____t_307 = __t
        local ____t_306 = __t
        local ____temp_305 = id == "interact"
        __O[1017] = ____temp_305
        if ____t_307(if ____t_306(____temp_305) then down else __O[1017]) then
            __L1:usar()
        end
    end
    __L1.copiarCssC1 = function(self)
        if __t(__L1.cssC1) then
            return
        end
        __L1.cssC1 = true
        local rel = __re("touch|joystick|crafted|-btn|c2-poder|c2-controles|campaign-layout|topbar|hud-|player-info|gas-|ammo|paper-icon|inventory|weapon|location|pin-icon|game-actions|icon-button|fullscreen|progress|xp-|stats|hearts|miniPortrait|campaign-chapter|statsBtn|levelValue|pointsValue", "")
        local conv
        conv = function(____, r)
            if r.selectorText ~= nil then
                local ____t_310 = __t
                local ____t_309 = __t
                local ____call_result_308 = __call(r.selectorText, "includes", "#gameShell")
                __O[1018] = ____call_result_308
                return if ____t_310(if ____t_309(____call_result_308) then rel:test(r.selectorText) else __O[1018]) then __add(
                    __re_replace(
                        r.cssText,
                        __re("#gameShell", "g"),
                        "#c2GameShell"
                    ),
                    "\n"
                ) else ""
            end
            if __t(if __t(r.cssRules) then r.media else r.cssRules) then
                local i = ""
                for ____, q in __iterar((r.cssRules)) do
                    i = __add(
                        i,
                        conv(nil, q)
                    )
                end
                return if __t(i) then ((("@media " .. tostring(r.media.mediaText)) .. "{") .. i) .. "}\n" else ""
            end
            if __t(if __t(r.cssRules) then r.conditionText ~= nil else r.cssRules) then
                local i = ""
                for ____, q in __iterar((r.cssRules)) do
                    i = __add(
                        i,
                        conv(nil, q)
                    )
                end
                return if __t(i) then ((("@supports " .. tostring(r.conditionText)) .. "{") .. i) .. "}\n" else ""
            end
            return ""
        end
        local txt = ""
        for ____, sh in __iterar((window.document.styleSheets)) do
            local rules
            do
                local ____hasContinued
                local function ____catch(e)
                    ____hasContinued = true
                    return
                end
                local ____try, ____hasReturned = pcall(function()
                    rules = sh.cssRules
                end)
                if not ____try then
                    ____catch(____hasReturned)
                end
                if ____hasContinued then
                    continue
                end
            end
            for ____, r in __iterar((if __t(rules) then rules else __arrL({}, 0))) do
                do
                    pcall(function()
                        txt = __add(
                            txt,
                            conv(nil, r)
                        )
                    end)
                end
            end
        end
        txt = __add(txt, ".c2j>#c2GameShell.c2-c1-shell.game-shell{position:fixed!important;inset:0!important;width:auto!important;height:auto!important;min-height:0!important;max-width:none!important;max-height:none!important;margin:0!important;padding:0!important;border:0!important;background:none!important;box-shadow:none!important;outline:0!important;overflow:visible!important;pointer-events:none!important;z-index:4!important;transform:none!important;filter:none!important}\n.c2j>.c2-c1-shell .touch-controls{pointer-events:auto}.c2j>.c2-c1-shell .touch-controls,.c2j .c2-treino-ctl,.c2j .joy{transition:opacity .25s}.c2j.c2-dialogo>.c2-c1-shell .touch-controls,.c2j.c2-dialogo .c2-treino-ctl,.c2j.c2-dialogo .joy{opacity:0!important;pointer-events:none!important}.c2j.c2-dialogo>.c2-c1-shell .touch-controls *{pointer-events:none!important}.c2j.c1-botoes .c2-treino-ctl,.c2j.c1-botoes .joy{display:none!important}.c2j.c2-editando-c1 .c2-c1-shell .touch-controls{pointer-events:auto}")
        local st = window.document:createElement("style")
        st.id = "c2C1BotoesCss"
        st.textContent = txt
        window.document.head:appendChild(st)
    end
    __L1.controlesC1 = function(self)
        local tela = __L1.box:querySelector(".tela")
        __L1:devolverTopo()
        local ____opt_311 = __L1.box:querySelector(".c2-c1-shell")
        if ____opt_311 ~= nil then
            ____opt_311:remove()
        end
        __L1.box.classList:remove("c1-botoes")
        local shell = window.document:getElementById("gameShell")
        local orig = shell and shell:querySelector(".touch-controls")
        if not __t(orig) then
            return false
        end
        __L1:copiarCssC1()
        local w = window.document:createElement("div")
        w.className = __add(
            __call(
                __call(
                    __arr(__TS__Spread(__iter(shell.classList))),
                    "filter",
                    function(____, k) return not __t(__L1.FORA:test(k)) end
                ),
                "join",
                " "
            ),
            " game-shell c2-c1-shell c2-controles campaign-layout-ready campaign-layout-playable"
        )
        w.id = "c2GameShell"
        local est = shell:getAttribute("style")
        if __t(est) then
            w:setAttribute("style", est)
        end
        local cl = orig:cloneNode(true)
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({"vehicle", "poder1"}, 2),
                __arrL({"bivolt", "poder2"}, 2)
            },
            2
        ))) do
            local de = ____value[1]
            local para = ____value[2]
            local o = cl:querySelector(("[data-action=\"" .. tostring(de)) .. "\"]")
            local p = cl:querySelector(("[data-action=\"" .. tostring(para)) .. "\"]")
            if __t(not __t(o) or not __t(p)) then
                continue
            end
            local ____p_setAttribute_317 = p.setAttribute
            local ____t_316 = __t
            local ____temp_315 = o:getAttribute("style")
            __O[1019] = ____temp_315
            ____p_setAttribute_317(p, "style", if ____t_316(____temp_315) then __O[1019] else "")
            __call(p.classList, "add", "campaign-layout-target")
            if __t(o.dataset.campaignLayout) then
                p.dataset.campaignLayout = o.dataset.campaignLayout
            end
            o.parentNode:insertBefore(p, o)
        end
        __call(
            cl:querySelectorAll("[data-action=\"reeis\"],[data-action=\"vehicle\"],[data-action=\"taunt\"],[data-action=\"train\"],[data-action=\"activity\"],[data-action=\"bivolt\"]"),
            "forEach",
            function(____, e) return e:remove() end
        )
        __call(
            cl:querySelectorAll("[id]"),
            "forEach",
            function(____, e)
                e.dataset.c1Id = e.id
                e:removeAttribute("id")
            end
        )
        __call(
            cl:querySelectorAll(".pressed,.engaged,.active"),
            "forEach",
            function(____, e) return e.classList:remove("pressed", "engaged", "active") end
        )
        w:appendChild(cl)
        __L1.box:appendChild(w)
        __call(__L1.box.classList, "add", "c1-botoes")
        for ____, b in __iterar((cl:querySelectorAll("[data-action]"))) do
            local id = b.dataset.action
            b.dataset.acao = id
            local function down(____, e)
                e:preventDefault()
                __call(b.classList, "add", "pressed")
                __L1:acionarBotao(id, true)
            end
            local function up()
                if not __t(b.classList:contains("pressed")) then
                    return
                end
                b.classList:remove("pressed")
                __L1:acionarBotao(id, false)
            end
            b:addEventListener("pointerdown", down)
            b:addEventListener("pointerup", up)
            b:addEventListener("pointerleave", up)
            b:addEventListener("pointercancel", up)
            b:addEventListener(
                "contextmenu",
                function(____, e) return e:preventDefault() end
            )
        end
        __L1:ligarJoy(cl:querySelector(".move-joystick"))
        __L1:copiarPoderes(true)
        __L1:levarTopo(w)
        __L1:safe(function()
            local ____opt_320 = window.CampanhaBotoes
            if ____opt_320 ~= nil then
                ____opt_320 = ____opt_320.aplicar
            end
            local ____opt_result_322
            if ____opt_320 ~= nil then
                ____opt_result_322 = ____opt_320(____opt_320, tela)
            end
            return ____opt_result_322
        end)
        return true
    end
    __L1.interceptarTopo = function(self, e)
        if __t(not __t(__L1.topo) or not __t(__L1.topo.el:contains(e.target))) then
            return
        end
        local b = e.target:closest("#pauseBtn")
        if __t(b) then
            e:preventDefault()
            e:stopImmediatePropagation()
            if e.type == "click" then
                __L1:pausar(not __t(__L1.pausado))
            end
        end
    end
    __L1.copiarPoderes = function(self, ja)
        local agora = window.performance:now()
        if __t(not __t(ja) and agora - __L1.ultPoder < 150) then
            return
        end
        __L1.ultPoder = agora
        local ____opt_323 = __L1.box
        if ____opt_323 ~= nil then
            ____opt_323 = ____opt_323:querySelector(".c2-c1-shell")
        end
        local w = ____opt_323
        if not __t(w) then
            return
        end
        for ____, i in __iterar((__arrL({1, 2}, 2))) do
            local o = window.document:getElementById(__add("c2Poder", i))
            local k = w:querySelector(("[data-action=\"poder" .. tostring(i)) .. "\"]")
            if __t(not __t(o) or not __t(k)) then
                continue
            end
            if k.dataset.html ~= o.innerHTML then
                k.innerHTML = o.innerHTML
                k.dataset.html = o.innerHTML
            end
            k.classList:toggle(
                "vazio",
                o.classList:contains("vazio")
            )
        end
        local dv = w:querySelector("[data-c1-id=\"dashValue\"]")
        if __t(dv) then
            local ____t_330 = __t
            local ____opt_327 = __L1:TR()
            if ____opt_327 ~= nil then
                ____opt_327 = ____opt_327.dashFalta
            end
            local ____opt_result_329
            if ____opt_327 ~= nil then
                ____opt_result_329 = ____opt_327(____opt_327)
            end
            __O[1020] = ____opt_result_329
            local f = if ____t_330(____opt_result_329) then __O[1020] else 0
            local txt = if __gt(f, 0.05) then __add(
                __call(
                    __call(f, "toFixed", 1),
                    "replace",
                    ".",
                    ","
                ),
                "s"
            ) else "PRONTO"
            if dv.textContent ~= txt then
                dv.textContent = txt
            end
        end
    end
    __L1.teclaDown = function(self, e)
        local ____t_347 = __t
        local ____t_341 = __t
        local ____t_334 = __t
        local ____t_332 = __t
        local ____temp_331 = not __t(__L1.aberto)
        __O[1028] = ____temp_331
        local ____temp_333 = if ____t_332(____temp_331) then __O[1028] else __L1:coberto()
        __O[1029] = ____temp_333
        local ____opt_337 = window.CampanhaMoradores
        if ____opt_337 ~= nil then
            ____opt_337 = ____opt_337.aberto
        end
        local ____opt_result_339
        if ____opt_337 ~= nil then
            ____opt_result_339 = ____opt_337(____opt_337)
        end
        local ____temp_340 = if ____t_334(____temp_333) then __O[1029] else ____opt_result_339
        __O[1030] = ____temp_340
        local ____opt_344 = window.CampanhaAliados
        if ____opt_344 ~= nil then
            ____opt_344 = ____opt_344.ocupado
        end
        local ____opt_result_346
        if ____opt_344 ~= nil then
            ____opt_result_346 = ____opt_344(____opt_344)
        end
        if ____t_347(if ____t_341(____temp_340) then __O[1030] else ____opt_result_346) then
            return
        end
        local k = e.code
        if __t(__L1.box:querySelector(".escolha")) then
            if __re_test(
                __re("^Digit[1-3]$", ""),
                k
            ) then
                local ____opt_348 = __get(
                    __L1.box:querySelectorAll(".escolha .ops button"),
                    __TS__Number(__call(k, "slice", 5)) - 1
                )
                if ____opt_348 ~= nil then
                    ____opt_348:click()
                end
            end
            e:stopImmediatePropagation()
            return
        end
        if __t(__L1.cut) then
            local ____t_352 = __t
            local ____t_351 = __t
            local ____call_result_350 = __call(
                __arrL({"Space", "Enter", "KeyE", "ArrowRight"}, 4),
                "includes",
                k
            )
            __O[1031] = ____call_result_350
            if ____t_352(if ____t_351(____call_result_350) then not __t(e["repeat"]) else __O[1031]) then
                __L1:avancarCut()
            end
            if k == "Escape" then
                __L1:pularCut()
            end
            e:preventDefault()
            e:stopImmediatePropagation()
            return
        end
        if __t(__L1.morto) then
            e:stopImmediatePropagation()
            return
        end
        if k == "Escape" then
            __L1:pausar(not __t(__L1.pausado))
            e:preventDefault()
            e:stopImmediatePropagation()
            return
        end
        if __t(__L1.pausado) then
            e:stopImmediatePropagation()
            return
        end
        for ____, a in __iterar((__L1:acoesDaTecla(k))) do
            if __t(a == "left" or a == "right") then
                __call(__L1.keys, "add", a)
                continue
            end
            if __t(e["repeat"]) then
                continue
            end
            if a == "jump" then
                __call(__L1.keys, "add", "jump")
                __L1:pular()
                local ____opt_355 = __L1:TR()
                if ____opt_355 ~= nil then
                    ____opt_355 = ____opt_355.acao
                end
                if ____opt_355 ~= nil then
                    ____opt_355(____opt_355, "jump", true, __L1.P)
                end
            elseif a == "interact" then
                __L1:usar()
            else
                local ____opt_359 = __L1:TR()
                if ____opt_359 ~= nil then
                    ____opt_359 = ____opt_359.acao
                end
                if ____opt_359 ~= nil then
                    ____opt_359(____opt_359, a, true, __L1.P)
                end
            end
        end
        e:preventDefault()
        e:stopImmediatePropagation()
    end
    __L1.acoesDaTecla = function(self, k)
        local a = __arrL({}, 0)
        do
            local function ____catch(e)
                a = __arrL({}, 0)
            end
            local ____try, ____hasReturned = pcall(function()
                local ____t_366 = __t
                local ____opt_363 = window.ControlSettings
                if ____opt_363 ~= nil then
                    ____opt_363 = ____opt_363.getActionsForCode
                end
                local ____opt_result_365
                if ____opt_363 ~= nil then
                    ____opt_result_365 = ____opt_363(____opt_363, k)
                end
                __O[1032] = ____opt_result_365
                a = if ____t_366(____opt_result_365) then __O[1032] else __arrL({}, 0)
            end)
            if not ____try then
                ____catch(____hasReturned)
            end
        end
        a = __call(
            __call(
                a,
                "map",
                function(____, x)
                    local ____t_368 = __t
                    local ____get_result_367 = __get(__L1.DA_C1, x)
                    __O[1033] = ____get_result_367
                    return if ____t_368(____get_result_367) then __O[1033] else x
                end
            ),
            "filter",
            function(____, x) return __call(__L1.USADAS, "has", x) end
        )
        if __t(k == "KeyU" or k == "KeyI") then
            __call(
                a,
                "push",
                __get(
                    __get(__L1.TECLAS_PADRAO, k),
                    0
                )
            )
        end
        if __t(not __t(__len(a)) and not __t(window.ControlSettings)) then
            local ____t_370 = __t
            local ____get_result_369 = __get(__L1.TECLAS_PADRAO, k)
            __O[1034] = ____get_result_369
            a = if ____t_370(____get_result_369) then __O[1034] else __arrL({}, 0)
        end
        return __arr(__TS__Spread(__iter(__TS__New(Set, a))))
    end
    __L1.teclaUp = function(self, e)
        if not __t(__L1.aberto) then
            return
        end
        local k = e.code
        for ____, a in __iterar((__L1:acoesDaTecla(k))) do
            if __t(a == "left" or a == "right") then
                __call(__L1.keys, "delete", a)
            elseif a == "jump" then
                __call(__L1.keys, "delete", "jump")
                local ____opt_373 = __L1:TR()
                if ____opt_373 ~= nil then
                    ____opt_373 = ____opt_373.acao
                end
                if ____opt_373 ~= nil then
                    ____opt_373(____opt_373, "jump", false, __L1.P)
                end
            else
                local ____t_379 = __t
                local ____t_378 = __t
                local ____t_376 = __t
                local ____temp_375 = a == "paper" or a == "fart"
                __O[1035] = ____temp_375
                local ____temp_377 = if ____t_376(____temp_375) then __O[1035] else a == "poder1"
                __O[1036] = ____temp_377
                if ____t_379(if ____t_378(____temp_377) then __O[1036] else a == "poder2") then
                    local ____opt_382 = __L1:TR()
                    if ____opt_382 ~= nil then
                        ____opt_382 = ____opt_382.acao
                    end
                    if ____opt_382 ~= nil then
                        ____opt_382(____opt_382, a, false, __L1.P)
                    end
                end
            end
        end
    end
    __L1.hudVisivel = function(self, v)
        if __t(__L1.hud) then
            __L1.hud.style.visibility = if __t(v) then "visible" else "hidden"
        end
        local ____opt_384 = __L1.box
        if ____opt_384 ~= nil then
            ____opt_384 = ____opt_384:querySelector(".c2-treino-wrap")
        end
        local bar = ____opt_384
        if __t(bar) then
            bar.style.visibility = if __t(v) then "visible" else "hidden"
        end
        __L1.box:querySelector(".pular").hidden = v
    end
    __L1.objetivoNovo = function(self, txt)
        local ____opt_386 = __L1.box
        if ____opt_386 ~= nil then
            ____opt_386 = ____opt_386:querySelector(".obj")
        end
        local o = ____opt_386
        if not __t(o) then
            return
        end
        o:querySelector("span").textContent = txt
        o.classList:remove("novo")
        local ____ = o.offsetWidth
        __call(o.classList, "add", "novo")
        __L1:sfx("plim")
    end
    __L1.aviso = function(self, txt)
        local ____opt_388 = __L1.box
        if ____opt_388 ~= nil then
            ____opt_388 = ____opt_388:querySelector(".avisos")
        end
        local a = ____opt_388
        if not __t(a) then
            return
        end
        local d = window.document:createElement("div")
        d.textContent = txt
        a:appendChild(d)
        window:setTimeout(
            function() return d:remove() end,
            2600
        )
    end
    __L1.item = function(self, nome)
        local d = window.document:createElement("div")
        d.className = "item"
        d.innerHTML = ("<small>VOCÊ PEGOU</small><b>" .. tostring(nome)) .. "</b>"
        __L1.box:querySelector(".tela"):appendChild(d)
        window:setTimeout(
            function() return d:remove() end,
            1800
        )
    end
    __L1.escolher = function(self, quem, pergunta, ops, aoAcertar, semResposta)
        __call(__L1.keys, "clear")
        local el = window.document:createElement("div")
        el.className = "escolha"
        el.innerHTML = ((("<div class=\"cx\"><b>" .. tostring(quem)) .. "</b><div>") .. tostring(pergunta)) .. "</div><div class=\"ops\"></div><div class=\"resp\"></div></div>"
        local list = el:querySelector(".ops")
        __call(
            ops,
            "forEach",
            function(____, o, i)
                local b = window.document:createElement("button")
                b.type = "button"
                b.textContent = (tostring(i + 1) .. ". ") .. tostring(o.t)
                b:addEventListener(
                    "click",
                    function()
                        if __t(o.voltar) then
                            el:remove()
                            return
                        end
                        if __t(o.ok) then
                            if __t(if __t(o.r) then not __t(semResposta) else o.r) then
                                el:querySelector(".resp").style.color = "#2a7a3a"
                                el:querySelector(".resp").textContent = o.r
                                __L1:sfx("plim")
                                window:setTimeout(
                                    function()
                                        el:remove()
                                        aoAcertar(nil, o)
                                    end,
                                    1300
                                )
                            else
                                el:remove()
                                aoAcertar(nil, o)
                            end
                            return
                        end
                        el:querySelector(".resp").textContent = if __t(o.r) then o.r else "Não..."
                        __L1:sfx("risada")
                        b.disabled = true
                    end
                )
                list:appendChild(b)
            end
        )
        __L1.box:querySelector(".tela"):appendChild(el)
        window:setTimeout(
            function()
                local ____opt_390 = list:querySelector("button")
                return ____opt_390 and ____opt_390:focus()
            end,
            50
        )
    end
    __L1.pausar = function(self, v)
        __L1.pausado = v
        __call(__L1.keys, "clear")
        local ____opt_392 = __L1.box:querySelector(".pausa")
        if ____opt_392 ~= nil then
            ____opt_392:remove()
        end
        if not __t(v) then
            return
        end
        local el = window.document:createElement("div")
        el.className = "pausa"
        el.innerHTML = ("<h2>PAUSA</h2><button type=\"button\" data-a=\"voltar\">▶ CONTINUAR</button><button type=\"button\" data-a=\"opcoes\">⚙ OPÇÕES</button><button type=\"button\" data-a=\"missoes\">📜 MISSÕES</button><button type=\"button\" data-a=\"som\">♪ SOM: " .. if __t(__L1.som) then "LIGADO" else "DESLIGADO") .. "</button><button type=\"button\" data-a=\"sair\">SALVAR E SAIR</button><p>A/D ou setas andam · ESPAÇO pula (segure no ar para voar) · E fala e entra · J papel · K peido · L dash · U/I poderes · ESC pausa</p>"
        el:addEventListener(
            "click",
            function(____, e)
                local ____opt_394 = e.target:closest("button")
                if ____opt_394 ~= nil then
                    ____opt_394 = ____opt_394.dataset.a
                end
                local a = ____opt_394
                if a == "voltar" then
                    __L1:pausar(false)
                end
                if a == "som" then
                    __L1.som = not __t(__L1.som)
                    window.__somCutscene = __L1.som
                    __L1:pausar(true)
                end
                if a == "sair" then
                    __L1:salvar()
                    __L1:fechar()
                end
                if a == "missoes" then
                    __L1:diario()
                end
                if a == "opcoes" then
                    __L1:opcoes()
                end
            end
        )
        __L1.box:querySelector(".tela"):appendChild(el)
        window:setTimeout(
            function()
                local ____opt_396 = el:querySelector("button")
                return ____opt_396 and ____opt_396:focus()
            end,
            30
        )
    end
    __L1.opcoes = function(self)
        local ____opt_398 = __L1.box:querySelector(".pausa")
        if ____opt_398 ~= nil then
            ____opt_398:remove()
        end
        local el = window.document:createElement("div")
        el.className = "pausa"
        local DT = window.DayTime
        local WX = window.Weather
        local GX = window.Graphics
        local function linhas()
            local ____temp_411 = if __t(DT) then ("<button type=\"button\" data-o=\"hora\">HORA DO DIA: <span class=\"val\">" .. tostring(if DT:mode() == "auto" then "DA HISTÓRIA" else DT:label())) .. "</span></button>" else ""
            local ____temp_412 = if __t(WX) then ("<button type=\"button\" data-o=\"clima\">CLIMA: <span class=\"val\">" .. tostring(WX:label())) .. "</span></button>" else ""
            local ____temp_413 = if __t(GX) then ("<button type=\"button\" data-o=\"qualidade\">QUALIDADE: <span class=\"val\">" .. tostring(GX:label())) .. "</span></button>" else ""
            local ____opt_result_402
            if DT ~= nil then
                ____opt_result_402 = DT:mode()
            end
            local ____add_410 = __add
            local ____add_409 = __add
            local ____opt_result_407
            if DT ~= nil then
                ____opt_result_407 = DT.label
            end
            local ____opt_result_408
            if ____opt_result_407 ~= nil then
                ____opt_result_408 = ____opt_result_407(DT)
            end
            return ((((((((((("<h2>OPÇÕES</h2>\n      " .. ____temp_411) .. "\n      ") .. ____temp_412) .. "\n      ") .. ____temp_413) .. "\n      <button type=\"button\" data-o=\"botoes\">MUDAR BOTÕES DE LUGAR</button>\n      <button type=\"button\" data-o=\"voltar\">◀ VOLTAR</button>\n      <p>") .. tostring(if ____opt_result_402 == "auto" then "Hora do dia: segue a história." else ____add_410(
                ____add_409("Hora do dia fixa: ", ____opt_result_408),
                "."
            ))) .. " ") .. tostring(if __t(WX) then __add(
                "Clima: ",
                WX:describe()
            ) else "")) .. "<br>") .. tostring(if __t(GX) then __add(
                "Qualidade: ",
                GX:describe()
            ) else "")) .. "</p>"
        end
        local function desenhar(____, foco)
            el.innerHTML = linhas(nil)
            window:setTimeout(
                function()
                    local ____t_417 = __t
                    local ____temp_416 = el:querySelector(("[data-o=\"" .. tostring(foco)) .. "\"]")
                    __O[1037] = ____temp_416
                    local ____opt_414 = if ____t_417(____temp_416) then __O[1037] else el:querySelector("button")
                    if ____opt_414 ~= nil then
                        ____opt_414 = ____opt_414:focus()
                    end
                    return ____opt_414
                end,
                20
            )
        end
        el:addEventListener(
            "click",
            function(____, e)
                local ____opt_418 = e.target:closest("button")
                if ____opt_418 ~= nil then
                    ____opt_418 = ____opt_418.dataset.o
                end
                local o = ____opt_418
                if not __t(o) then
                    return
                end
                if o == "voltar" then
                    __L1:pausar(true)
                    return
                end
                if o == "hora" then
                    local ____opt_result_424
                    if DT ~= nil then
                        ____opt_result_424 = DT.next
                    end
                    if ____opt_result_424 ~= nil then
                        ____opt_result_424(DT)
                    end
                end
                if o == "clima" then
                    local ____opt_result_429
                    if WX ~= nil then
                        ____opt_result_429 = WX.next
                    end
                    if ____opt_result_429 ~= nil then
                        ____opt_result_429(WX)
                    end
                end
                if o == "qualidade" then
                    local ____opt_result_434
                    if GX ~= nil then
                        ____opt_result_434 = GX.toggle
                    end
                    if ____opt_result_434 ~= nil then
                        ____opt_result_434(GX)
                    end
                end
                if o == "botoes" then
                    el.hidden = true
                    __L1:hudVisivel(true)
                    local ____opt_437 = window.CampanhaBotoes
                    if ____opt_437 ~= nil then
                        ____opt_437 = ____opt_437.editar
                    end
                    if ____opt_437 ~= nil then
                        ____opt_437(
                            ____opt_437,
                            __L1.box:querySelector(".tela"),
                            function()
                                el.hidden = false
                                desenhar(nil, "botoes")
                            end
                        )
                    end
                    return
                end
                __L1:sfx("plim")
                desenhar(nil, o)
            end
        )
        desenhar(nil)
        __L1.box:querySelector(".tela"):appendChild(el)
    end
    __L1.diario = function(self)
        local ____opt_439 = __L1.box:querySelector(".pausa")
        if ____opt_439 ~= nil then
            ____opt_439:remove()
        end
        local el = window.document:createElement("div")
        el.className = "pausa"
        local ____t_446 = __t
        local ____opt_443 = window.CampanhaAliados
        if ____opt_443 ~= nil then
            ____opt_443 = ____opt_443.missoes
        end
        local ____opt_result_445
        if ____opt_443 ~= nil then
            ____opt_result_445 = ____opt_443(____opt_443)
        end
        __O[1038] = ____opt_result_445
        local L = if ____t_446(____opt_result_445) then __O[1038] else __arrL({}, 0)
        local ic = {feita = "✔", ativa = "▶", nova = "!"}
        local ____t_449 = __t
        local ____opt_447 = __get(__L1.PASSOS, __L1.S.passo)
        if ____opt_447 ~= nil then
            ____opt_447 = ____opt_447.obj
        end
        __O[1039] = ____opt_447
        el.innerHTML = ((("<h2>📜 MISSÕES</h2><div style=\"background:#f2dc9a;color:#3a2412;border:3px solid #2a1a10;padding:10px 14px;width:min(560px,86%);font:12px Space,Arial,sans-serif;line-height:1.5\"><b style=\"font:9px Pixel,monospace;color:#8a4a2a\">HISTÓRIA</b><br>" .. tostring(if ____t_449(____opt_447) then __O[1039] else "")) .. "</div>\n      <div style=\"background:#2a1e14e8;border:3px solid #8a6a3a;padding:8px 12px;width:min(560px,86%);font:11px Space,Arial,sans-serif;line-height:1.5;max-height:46vh;overflow:auto\">") .. tostring(__call(
            __call(
                L,
                "map",
                function(____, ____bindingPattern0)
                    local d
                    local st
                    local n
                    n = ____bindingPattern0[1]
                    st = ____bindingPattern0[2]
                    d = ____bindingPattern0[3]
                    return ((((((((("<div style=\"margin:5px 0;opacity:" .. tostring(if st == "feita" then 0.55 else 1)) .. "\"><b style=\"font:9px Pixel,monospace;color:") .. if st == "feita" then "#7af07a" else if st == "ativa" then "#ffd24a" else "#e8c66a") .. "\">") .. tostring(__get(ic, st))) .. " ") .. tostring(__call(n, "toUpperCase"))) .. "</b><br><span style=\"color:#e8dcc0\">") .. tostring(if st == "feita" then "Concluída!" else d)) .. "</span></div>"
                end
            ),
            "join",
            ""
        ))) .. "</div><button type=\"button\" data-a=\"voltar\">◀ VOLTAR</button>"
        el:addEventListener(
            "click",
            function(____, e)
                if __t(e.target:closest("button")) then
                    __L1:pausar(true)
                end
            end
        )
        __L1.box:querySelector(".tela"):appendChild(el)
        window:setTimeout(
            function()
                local ____opt_450 = el:querySelector("button")
                return ____opt_450 and ____opt_450:focus()
            end,
            30
        )
    end
    __L1.hudAtualizar = function(self)
        __L1:copiarPoderes()
        __L1:topoAtualizar()
        local cor = __L1.box:querySelector(".vida .cor")
        local n = math.floor(if __t(__L1.P.max) then __L1.P.max else 100 / 20 + 0.5)
        local hp = __L1:clamp(__L1.P.hp, 0, if __t(__L1.P.max) then __L1.P.max else 100) / 20
        local h = ""
        do
            local i = 0
            while i < n do
                h = __add(h, ("<i class=\"" .. if hp >= i + 1 then "on" else if hp > i + 0.3 then "meio" else "") .. "\"></i>")
                i = i + 1
            end
        end
        if cor.innerHTML ~= h then
            cor.innerHTML = h
        end
        local ____table_style_459 = __L1.box:querySelector(".vida .gas b").style
        local ____L1_clamp_458 = __L1.clamp
        local ____opt_454 = __L1:TR()
        if ____opt_454 ~= nil then
            ____opt_454 = ____opt_454.gas
        end
        local ____opt_result_456
        if ____opt_454 ~= nil then
            ____opt_result_456 = ____opt_454(____opt_454)
        end
        local ____opt_result_456_457 = ____opt_result_456
        if ____opt_result_456_457 == nil then
            ____opt_result_456_457 = 100
        end
        ____table_style_459.width = tostring(____L1_clamp_458(__L1, ____opt_result_456_457, 0, 100)) .. "%"
        local ____temp_466 = __L1.box:querySelector(".vida .moedas")
        local ____opt_462 = window.CampanhaLoja
        if ____opt_462 ~= nil then
            ____opt_462 = ____opt_462.moedas
        end
        local ____opt_result_464
        if ____opt_462 ~= nil then
            ____opt_result_464 = ____opt_462(____opt_462)
        end
        local ____opt_result_464_465 = ____opt_result_464
        if ____opt_result_464_465 == nil then
            ____opt_result_464_465 = 0
        end
        ____temp_466.textContent = "● " .. tostring(____opt_result_464_465)
        do
            local pp = __L1.box:querySelector(".vida .papeis")
            local ____opt_469 = __L1:TR()
            if ____opt_469 ~= nil then
                ____opt_469 = ____opt_469.papeis
            end
            local ____opt_result_471
            if ____opt_469 ~= nil then
                ____opt_result_471 = ____opt_469(____opt_469)
            end
            local ____opt_result_471_472 = ____opt_result_471
            if ____opt_result_471_472 == nil then
                ____opt_result_471_472 = 30
            end
            local tx = "◆ " .. tostring(____opt_result_471_472)
            if __t(if __t(pp) then pp.textContent ~= tx else pp) then
                pp.textContent = tx
            end
        end
        local e = __L1.box:querySelector(".entrar")
        e.hidden = not __t(__L1.perto) or not not __t(__L1.cut)
        if __t(__L1.perto) then
            e.textContent = if __t(__L1.perto.botao) then __L1.perto.botao else if __L1.perto.tipo == "poderes" then "PODERES" else if __L1.perto.tipo == "pc" then "USAR" else if __L1.perto.tipo == "armario" then "ABRIR" else if __L1.perto.tipo == "rolante" then if __lt(
                __get(__L1.perto.ate, 1),
                __L1.FLOOR
            ) then "SUBIR" else "DESCER" else if __re_test(
                __re("^SAIR|DESCER", ""),
                __L1.perto.rotulo
            ) then "SAIR" else "ENTRAR"
        end
    end
    __L1.lutaC1 = function(self, f)
        local K = if __t(f.F.chefe) then f.F.chefe else {}
        local ok = false
        do
            local function ____catch(e)
                ok = false
            end
            local ____try, ____hasReturned = pcall(function()
                local ____t_478 = __t
                local ____opt_475 = window.C2Luta
                if ____opt_475 ~= nil then
                    ____opt_475 = ____opt_475.iniciar
                end
                local ____opt_result_477
                if ____opt_475 ~= nil then
                    ____opt_result_477 = ____opt_475(
                        ____opt_475,
                        {
                            slug = f.slug,
                            tipo = if __t(f.chefe.tipo) then f.chefe.tipo else K.tipo,
                            nome = K.nome,
                            cena = __L1.cenaId,
                            hora = __L1:horaAtual(),
                            bossX = f.chefe.x
                        },
                        function(____, r) return __L1:voltarDaLuta(f, r) end
                    )
                end
                ok = not not ____t_478(____opt_result_477)
            end)
            if not ____try then
                ____catch(____hasReturned)
            end
        end
        if not __t(ok) then
            f:comecarLuta()
            return
        end
        __L1.emLuta = true
        __L1.aberto = false
        window:cancelAnimationFrame(__L1.raf)
        __call(__L1.keys, "clear")
        __L1.joy = 0
        __L1:devolverTopo()
        __L1.box.hidden = true
        __L1:salvarProgressao()
    end
    __L1.voltarDaLuta = function(self, f, r)
        __L1.emLuta = false
        __L1.aberto = true
        __L1.box.hidden = false
        __call(__L1.keys, "clear")
        __L1.joy = 0
        __L1:safe(__L1.controlesC1)
        __L1.last = window.performance:now()
        window:cancelAnimationFrame(__L1.raf)
        __L1.raf = window:requestAnimationFrame(__L1.frame)
        window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {active = true}}))
        if r == "venceu" then
            __L1.P.hp = math.max(
                __L1.P.hp,
                math.floor(if __t(__L1.P.max) then __L1.P.max else 100 * 0.5 + 0.5)
            )
            __L1:safe(function() return __L1.apiFase:vencer() end)
        elseif r == "recuou" then
            __L1:safe(function() return __L1:voltarDoDesmaio() end)
            __L1:aviso("Você saiu da arena. Respire e volte quando quiser.")
        else
            __L1:desmaiar()
        end
    end
    __L1.carregarC1 = function(self)
        local st = nil
        do
            pcall(function()
                local ____opt_481 = window.Game
                if ____opt_481 ~= nil then
                    ____opt_481 = ____opt_481.getState
                end
                local ____opt_result_483
                if ____opt_481 ~= nil then
                    ____opt_result_483 = ____opt_481(____opt_481)
                end
                st = ____opt_result_483
            end)
        end
        local ____t_487 = __t
        local ____opt_result_486
        if st ~= nil then
            ____opt_result_486 = st.started
        end
        if ____t_487(____opt_result_486) then
            local ____opt_498 = __L1:TR()
            if ____opt_498 ~= nil then
                ____opt_498 = ____opt_498.dadosC1
            end
            if ____opt_498 ~= nil then
                local ____temp_495 = if __t(st.weapon) then st.weapon else 0
                local ____t_491 = __t
                local ____opt_489 = st.q
                if ____opt_489 ~= nil then
                    ____opt_489 = ____opt_489.trained
                end
                local ____temp_496 = not not ____t_491(____opt_489)
                local ____t_494 = __t
                local ____opt_492 = st.q
                if ____opt_492 ~= nil then
                    ____opt_492 = ____opt_492.miqueias
                end
                ____opt_498(
                    ____opt_498,
                    {
                        weapon = ____temp_495,
                        trained = ____temp_496,
                        miqueias = not not ____t_494(____opt_492)
                    }
                )
            end
            return
        end
        local sv = __L1:save1()
        if __t(sv) then
            do
                pcall(function()
                    local ____opt_502 = window.Progression
                    if ____opt_502 ~= nil then
                        ____opt_502 = ____opt_502.getState
                    end
                    local ____opt_result_504
                    if ____opt_502 ~= nil then
                        ____opt_result_504 = ____opt_502(____opt_502)
                    end
                    local cur = ____opt_result_504
                    if __t(if __t(sv.progression) then not __t(cur) or __lt(if __t(cur.totalXP) then cur.totalXP else 0, if __t(sv.progression.totalXP) then sv.progression.totalXP else 0) else sv.progression) then
                        window.Progression:restore(sv.progression)
                    end
                end)
            end
            local ____opt_514 = __L1:TR()
            if ____opt_514 ~= nil then
                ____opt_514 = ____opt_514.dadosC1
            end
            if ____opt_514 ~= nil then
                local ____t_507 = __t
                local ____TS__Number_result_506 = __TS__Number(sv.weapon)
                __O[1041] = ____TS__Number_result_506
                local ____temp_511 = if ____t_507(____TS__Number_result_506) then __O[1041] else 0
                local ____temp_512 = if __t(sv.q) then not not __t(sv.q.trained) else true
                local ____t_510 = __t
                local ____opt_508 = sv.q
                if ____opt_508 ~= nil then
                    ____opt_508 = ____opt_508.miqueias
                end
                ____opt_514(
                    ____opt_514,
                    {
                        weapon = ____temp_511,
                        trained = ____temp_512,
                        miqueias = not not ____t_510(____opt_508)
                    }
                )
            end
        else
            local ____t_518 = __t
            local ____opt_516 = __L1.S
            if ____opt_516 ~= nil then
                ____opt_516 = ____opt_516.progressao
            end
            if ____t_518(____opt_516) then
                do
                    pcall(function()
                        local ____opt_521 = window.Progression
                        if ____opt_521 ~= nil then
                            ____opt_521 = ____opt_521.restore
                        end
                        if ____opt_521 ~= nil then
                            ____opt_521(____opt_521, __L1.S.progressao)
                        end
                    end)
                end
            end
        end
    end
    __L1.salvarProgressao = function(self)
        window:clearTimeout(__L1.tSalvarProg)
        __L1.tSalvarProg = window:setTimeout(
            function()
                local ____opt_525 = window.Progression
                if ____opt_525 ~= nil then
                    ____opt_525 = ____opt_525.serialize
                end
                local ____opt_result_527
                if ____opt_525 ~= nil then
                    ____opt_result_527 = ____opt_525(____opt_525)
                end
                local pr = ____opt_result_527
                if not __t(pr) then
                    return
                end
                local sv = __L1:save1()
                if __t(sv) then
                    sv.progression = pr
                    do
                        pcall(function()
                            window.localStorage:setItem(
                                __L1.SAVE1,
                                window.JSON:stringify(sv)
                            )
                        end)
                    end
                end
                if __t(__L1.S) then
                    __L1.S.progressao = pr
                    __L1:salvar()
                end
            end,
            400
        )
    end
    __L1.ganharXP = function(self, n, id, x, y)
        local ____t_536 = __t
        local ____opt_532 = window.Progression
        if ____opt_532 ~= nil then
            ____opt_532 = ____opt_532.getState
        end
        local ____opt_result_534
        if ____opt_532 ~= nil then
            ____opt_result_534 = ____opt_532(____opt_532)
        end
        local ____opt_result_535
        if ____opt_result_534 ~= nil then
            ____opt_result_535 = ____opt_result_534.level
        end
        __O[1042] = ____opt_result_535
        local antes = if ____t_536(____opt_result_535) then __O[1042] else 1
        local ____opt_539 = window.Progression
        if ____opt_539 ~= nil then
            ____opt_539 = ____opt_539.award
        end
        local ____opt_result_541
        if ____opt_539 ~= nil then
            ____opt_result_541 = ____opt_539(____opt_539, n, id)
        end
        local r = ____opt_result_541
        local ____t_545 = __t
        local ____opt_result_544
        if r ~= nil then
            ____opt_result_544 = r.awarded
        end
        if not ____t_545(____opt_result_544) then
            return r
        end
        if x ~= nil then
            __call(
                __L1.xpTxt,
                "push",
                {
                    x = x,
                    y = y,
                    s = __add(
                        __add("+", r.awarded),
                        " XP"
                    ),
                    t = 0
                }
            )
        end
        if __gt(if __t(r.level) then r.level else antes, antes) then
            __L1.P.hp = __L1:vidaMax()
            local ____opt_548 = __L1:TR()
            if ____opt_548 ~= nil then
                ____opt_548 = ____opt_548.encher
            end
            if ____opt_548 ~= nil then
                ____opt_548(____opt_548)
            end
            __L1:aviso(__add(
                __add("Nível ", r.level),
                "! Abra DADOS → ATRIBUTOS para distribuir seus pontos."
            ))
            __L1:sfx("fanfarra")
        end
        __L1:salvarProgressao()
        return r
    end
    __L1.levarTopo = function(self, w)
        local shell = window.document:getElementById("gameShell")
        local ____t_552 = __t
        local ____opt_550 = __L1.topo
        if ____opt_550 ~= nil then
            ____opt_550 = ____opt_550.el
        end
        __O[1045] = ____opt_550
        local bar = if ____t_552(____opt_550) then __O[1045] else shell and shell:querySelector(".game-topbar")
        if __t(not __t(bar) or not __t(w)) then
            return
        end
        if not __t(__L1.topo) then
            __L1.topo = {el = bar, pai = bar.parentNode, prox = bar.nextSibling, txt = {}}
            for ____, id in __iterar((__arrL({"hpValue", "paperValue", "gasPercent", "stageName"}, 4))) do
                local e = window.document:getElementById(id)
                if __t(e) then
                    __set(__L1.topo.txt, id, e.textContent)
                end
            end
            local ____L1_topo_559 = __L1.topo
            local ____t_558 = __t
            local ____opt_555 = window.document:getElementById("gasFill")
            local ____temp_557 = ____opt_555 and ____opt_555.style.width
            __O[1046] = ____temp_557
            ____L1_topo_559.gasW = if ____t_558(____temp_557) then __O[1046] else ""
        end
        w:appendChild(bar)
        __call(__L1.box.classList, "add", "c1-topo")
        __L1:topoAtualizar(true)
    end
    __L1.devolverTopo = function(self)
        if not __t(__L1.topo) then
            return
        end
        do
            local function ____catch(e)
                do
                    pcall(function()
                        __L1.topo.pai:appendChild(__L1.topo.el)
                    end)
                end
            end
            local ____try, ____hasReturned = pcall(function()
                __L1.topo.pai:insertBefore(__L1.topo.el, if __t(if __t(__L1.topo.prox) then __L1.topo.prox.parentNode == __L1.topo.pai else __L1.topo.prox) then __L1.topo.prox else nil)
            end)
            if not ____try then
                ____catch(____hasReturned)
            end
        end
        for ____, ____value in __iterar((__entries(__L1.topo.txt))) do
            local id = ____value[1]
            local v = ____value[2]
            local e = window.document:getElementById(id)
            if __t(e) then
                e.textContent = v
            end
        end
        local gf = window.document:getElementById("gasFill")
        if __t(gf) then
            gf.style.width = __L1.topo.gasW
        end
        local ____opt_562 = window.HudMinimal
        if ____opt_562 ~= nil then
            ____opt_562 = ____opt_562.close
        end
        if ____opt_562 ~= nil then
            ____opt_562(____opt_562)
        end
        __L1.topo = nil
        local ____opt_564 = __L1.box
        if ____opt_564 ~= nil then
            ____opt_564.classList:remove("c1-topo")
        end
    end
    __L1.topoAtualizar = function(self)
        if not __t(__L1.topo) then
            return
        end
        local max = if __t(__L1.P.max) then __L1.P.max else 100
        local h = __L1:clamp(
            math.ceil(__L1.P.hp / max * 5),
            0,
            5
        )
        __L1["pôr"](
            __L1,
            "hpValue",
            __call(
                __add(
                    __call("♥ ", "repeat", h),
                    __call("♡ ", "repeat", 5 - h)
                ),
                "trim"
            )
        )
        local ____L1_p_F4r_572 = __L1["pôr"]
        local ____opt_568 = __L1:TR()
        if ____opt_568 ~= nil then
            ____opt_568 = ____opt_568.papeis
        end
        local ____opt_result_570
        if ____opt_568 ~= nil then
            ____opt_result_570 = ____opt_568(____opt_568)
        end
        local ____opt_result_570_571 = ____opt_result_570
        if ____opt_result_570_571 == nil then
            ____opt_result_570_571 = 30
        end
        ____L1_p_F4r_572(
            __L1,
            "paperValue",
            tostring(____opt_result_570_571)
        )
        local ____opt_575 = __L1:TR()
        if ____opt_575 ~= nil then
            ____opt_575 = ____opt_575.gas
        end
        local ____opt_result_577
        if ____opt_575 ~= nil then
            ____opt_result_577 = ____opt_575(____opt_575)
        end
        local ____opt_result_577_578 = ____opt_result_577
        if ____opt_result_577_578 == nil then
            ____opt_result_577_578 = 100
        end
        local g = ____opt_result_577_578
        local ____t_584 = __t
        local ____opt_581 = __L1:TR()
        if ____opt_581 ~= nil then
            ____opt_581 = ____opt_581.gasMax
        end
        local ____opt_result_583
        if ____opt_581 ~= nil then
            ____opt_result_583 = ____opt_581(____opt_581)
        end
        __O[1047] = ____opt_result_583
        local gm = if ____t_584(____opt_result_583) then __O[1047] else 100
        local pct = math.floor(__L1:clamp(g / gm, 0, 1) * 100)
        __L1["pôr"](
            __L1,
            "gasPercent",
            __add(pct, "%")
        )
        local gf = window.document:getElementById("gasFill")
        if __t(if __t(gf) then gf.style.width ~= __add(pct, "%") else gf) then
            gf.style.width = __add(pct, "%")
        end
        local ____call_588 = __call
        local ____t_587 = __t
        local ____opt_585 = __L1:D()
        if ____opt_585 ~= nil then
            ____opt_585 = ____opt_585.nome
        end
        __O[1048] = ____opt_585
        local nome = ____call_588(if ____t_587(____opt_585) then __O[1048] else "", "toUpperCase")
        if __t(nome) then
            __L1["pôr"](__L1, "stageName", nome)
        end
    end
    __L1.enquadrar = function(self, dt)
        local shell = window.document:getElementById("gameShell")
        local w = window.innerWidth
        local h = window.innerHeight
        local sc = w / 960
        local ____t_590 = __t
        local ____temp_589 = w / h > 1.79 and not __t(__L1.cut)
        __O[1051] = ____temp_589
        local ____t_594 = __t
        local ____t_592 = __t
        local ____temp_591 = not __t(shell)
        __O[1049] = ____temp_591
        local ____temp_593 = if ____t_592(____temp_591) then __O[1049] else shell.classList:contains("screen-fill")
        __O[1050] = ____temp_593
        local quer = if ____t_590(____temp_589) then if ____t_594(____temp_593) then __O[1050] else not __t(shell.classList:contains("immersive")) else __O[1051]
        if quer ~= __L1.preenche then
            __L1.preenche = quer
            __L1.box.classList:toggle("preencher", quer)
            __L1.pan = nil
            if not __t(quer) then
                __L1.box:querySelector(".tela").style:removeProperty("--c2-pan")
            end
        end
        if not __t(quer) then
            return
        end
        local fundo = math.min(0, h - 540 * sc)
        local pe = 72 + math.min(64, 62 * sc) + 24
        local alvo = math.min(
            0,
            math.max(fundo, pe - __L1.P.y * sc)
        )
        __L1.pan = if __L1.pan == nil then alvo else __L1.pan + (alvo - __L1.pan) * math.min(1, dt * 12)
        local v = __add(
            __call(__L1.pan, "toFixed", 1),
            "px"
        )
        local tela = __L1.box:querySelector(".tela")
        if tela.style:getPropertyValue("--c2-pan") ~= v then
            tela.style:setProperty("--c2-pan", v)
        end
    end
    __L1.frame = function(self, now)
        if not __t(__L1.aberto) then
            return
        end
        __L1.raf = window:requestAnimationFrame(__L1.frame)
        local dt = math.min(
            0.05,
            math.max(0, (now - __L1.last) / 1000)
        )
        __L1.fpsMedio = __L1.fpsMedio + (if dt > 0 then 1 / math.max(dt, (now - __L1.last + 0.001) / 1000) else 60 - __L1.fpsMedio) * 0.05
        __L1.last = now
        local cob = __L1:coberto()
        __L1.box.style.visibility = if __t(cob) then "hidden" else "visible"
        if __t(cob) then
            return
        end
        local ____t_596 = __t
        local ____temp_595 = not not __t(__L1.cut) or not not __t(__L1.box:querySelector(".escolha"))
        __O[1052] = ____temp_595
        local ____t_602 = __t
        local ____opt_599 = window.CampanhaMoradores
        if ____opt_599 ~= nil then
            ____opt_599 = ____opt_599.aberto
        end
        local ____opt_result_601
        if ____opt_599 ~= nil then
            ____opt_result_601 = ____opt_599(____opt_599)
        end
        local dlg = if ____t_596(____temp_595) then __O[1052] else not not ____t_602(____opt_result_601)
        if dlg ~= __L1.box.classList:contains("c2-dialogo") then
            __L1.box.classList:toggle("c2-dialogo", dlg)
        end
        __L1.P.max = __L1:vidaMax()
        local ____t_608 = __t
        local ____opt_605 = window.CampanhaAliados
        if ____opt_605 ~= nil then
            ____opt_605 = ____opt_605.ocupado
        end
        local ____opt_result_607
        if ____opt_605 ~= nil then
            ____opt_result_607 = ____opt_605(____opt_605)
        end
        if ____t_608(____opt_result_607) then
            window.CampanhaAliados:atualizar(
                dt,
                __arrL({}, 0)
            )
            return
        end
        if __t(__L1.cut) then
            __L1:RT():update(__L1.cut.s, dt)
            if __t(__L1.cut.s.done) then
                local f = __L1.cut.depois
                __L1.cut = nil
                __L1:hudVisivel(true)
                do
                    pcall(function()
                        local ____opt_611 = window.DayTime
                        if ____opt_611 ~= nil then
                            ____opt_611 = ____opt_611.force
                        end
                        if ____opt_611 ~= nil then
                            ____opt_611(____opt_611, nil)
                        end
                    end)
                end
                if f ~= nil then
                    f(nil)
                end
            else
                __L1:safe(function() return __L1:enquadrar(dt) end)
                __L1.c:save()
                __L1:RT():draw(__L1.c, __L1.cut.s)
                __L1.c:restore()
                return
            end
        end
        if __t(if __t(__L1.pausado) then __L1.pausado else __L1:ocupado()) then
            __call(__L1.keys, "clear")
            __L1.P.vx = 0
        end
        __L1.t = __L1.t + dt
        local d = __L1:D()
        local F = if not __t(__L1.cut) then __L1:faseAtual() else __L1.fase
        local ____opt_617 = __L1:TR()
        if ____opt_617 ~= nil then
            ____opt_617 = ____opt_617.inimigos
        end
        if ____opt_617 ~= nil then
            ____opt_617(____opt_617, if __t(if __t(F) then not __t(__L1.cut) else F) then F:inimigos() else __arrL({}, 0))
        end
        if __t(not __t(__L1.pausado) and not __t(__L1.morto)) then
            __L1.P.inv = math.max(0, if __t(__L1.P.inv) then __L1.P.inv else 0 - dt)
            __L1.P.atordoado = math.max(0, if __t(__L1.P.atordoado) then __L1.P.atordoado else 0 - dt)
            local ____opt_632 = __L1:TR()
            if ____opt_632 ~= nil then
                ____opt_632 = ____opt_632.passo
            end
            if ____opt_632 ~= nil then
                local ____L1_P_630 = __L1.P
                local ____L1_cam_629 = __L1.cam
                local ____t_628 = __t
                local ____t_626 = __t
                local ____opt_result_624
                if F ~= nil then
                    ____opt_result_624 = F.luta
                end
                local ____opt_result_625
                if ____opt_result_624 ~= nil then
                    ____opt_result_625 = ____opt_result_624.estrada
                end
                local ____temp_627 = not ____t_626(____opt_result_625)
                __O[1053] = ____temp_627
                ____opt_632(____opt_632, dt, ____L1_P_630, {cam = ____L1_cam_629, segurandoPulo = if ____t_628(____temp_627) then __call(__L1.keys, "has", "jump") else __O[1053]})
            end
            if __t(__L1.viagem) then
                __L1:andarViagem(dt)
            else
                __L1:fisica(dt)
            end
            if __t(F) then
                F:update(dt)
            end
            __L1:safe(function()
                local ____opt_636 = window.CampanhaAliados
                if ____opt_636 ~= nil then
                    ____opt_636 = ____opt_636.atualizar
                end
                local ____opt_result_638
                if ____opt_636 ~= nil then
                    ____opt_result_638 = ____opt_636(____opt_636, dt, if __t(F) then F:inimigos() else __arrL({}, 0))
                end
                return ____opt_result_638
            end)
        end
        __L1.tremor = math.max(0, __L1.tremor - dt * 30)
        __L1.clarao = math.max(0, __L1.clarao - dt * 1.6)
        for ____, d0 in __iterar((__L1.dano)) do
            d0.t = d0.t + dt
        end
        while __t(if __t(__len(__L1.dano)) then __gt(
            __get(__L1.dano, 0).t,
            1
        ) else __len(__L1.dano)) do
            __call(__L1.dano, "shift")
        end
        __L1.cam = __L1.cam + (__L1:clamp(
            __L1.P.x - __L1.W * 0.36,
            0,
            math.max(0, d.largura - __L1.W)
        ) - __L1.cam) * math.min(1, dt * 8)
        __L1:safe(function() return __L1:enquadrar(dt) end)
        do
            pcall(function()
                local ____opt_641 = window.DayTime
                if ____opt_641 ~= nil then
                    ____opt_641 = ____opt_641.force
                end
                if ____opt_641 ~= nil then
                    ____opt_641(
                        ____opt_641,
                        __L1:horaAtual()
                    )
                end
            end)
        end
        local o = {
            scene = d.id,
            camera = __L1.cam,
            time = __L1.t,
            player = __L1.P,
            shots = __arrL({}, 0),
            enemies = __arrL({}, 0),
            minions = __arrL({}, 0)
        }
        local ____self_646 = window.ConquistaCombate
        local ____self_646_terreno_647 = ____self_646.terreno
        local ____opt_result_645
        if F ~= nil then
            ____opt_result_645 = F.luta
        end
        local percurso = ____self_646_terreno_647(____self_646, ____opt_result_645)
        if __t(percurso) then
            __L1.cam = (__add(F.luta.l, F.luta.r) - __L1.W) / 2
        else
            __L1:safe(function()
                local ____opt_650 = window.Interact
                if ____opt_650 ~= nil then
                    ____opt_650 = ____opt_650.update
                end
                local ____opt_result_652
                if ____opt_650 ~= nil then
                    ____opt_result_652 = ____opt_650(____opt_650, dt, o)
                end
                return ____opt_result_652
            end)
        end
        __L1:safe(function()
            local ____this_654
            ____this_654 = __L1:CC()
            local ____opt_653 = ____this_654.heroi
            if ____opt_653 ~= nil then
                ____opt_653 = ____opt_653(____this_654, __L1.P.x, __L1.P.y, __L1.P.vy)
            end
            return ____opt_653
        end)
        local ____t_657 = __t
        local ____t_656 = __t
        local ____temp_655 = not __t(percurso)
        __O[1054] = ____temp_655
        if ____t_657(if ____t_656(____temp_655) then __O[1054] else if __t(F.luta.ceu) then __lt(F.luta.ceu.tempo, 0.85) else F.luta.ceu) then
            window.Art:drawScene(__L1.c, d.id, __L1.cam, __L1.t)
        end
        if __t(percurso) then
            percurso:fundo(__L1.c, F.luta)
        end
        __L1.c:save()
        do
            local ____t_663 = __t
            local ____opt_660 = __L1:TR()
            if ____opt_660 ~= nil then
                ____opt_660 = ____opt_660.tremor
            end
            local ____opt_result_662
            if ____opt_660 ~= nil then
                ____opt_result_662 = ____opt_660(____opt_660)
            end
            __O[1055] = ____opt_result_662
            local sh = math.max(if ____t_663(____opt_result_662) then __O[1055] else 0, __L1.tremor)
            __L1.c:translate(
                -math.floor(__L1.cam + 0.5) + math.floor((math.random() - 0.5) * sh + 0.5),
                math.floor((math.random() - 0.5) * sh + 0.5)
            )
        end
        if not __t(percurso) then
            if __ge(d.id, 12) then
                for ____, pl in __iterar((if __t(d.plataformas) then d.plataformas else __arrL({}, 0))) do
                    if __t(__gt(
                        __add(
                            __get(pl, 0),
                            __get(pl, 2)
                        ),
                        __L1.cam - 20
                    ) and __lt(
                        __get(pl, 0),
                        __L1.cam + 980
                    )) then
                        __L1:safe(function() return __L1:CC():plataforma(__L1.c, d.id, pl, __L1.t) end)
                    end
                end
            end
            __L1:safe(function()
                local ____opt_666 = window.Interact
                if ____opt_666 ~= nil then
                    ____opt_666 = ____opt_666.drawBack
                end
                local ____opt_result_668
                if ____opt_666 ~= nil then
                    ____opt_result_668 = ____opt_666(____opt_666, __L1.c, o)
                end
                return ____opt_result_668
            end)
            if __ge(d.id, 12) then
                __L1:safe(function()
                    local ____opt_671 = window.CampanhaPlantas
                    if ____opt_671 ~= nil then
                        ____opt_671 = ____opt_671.drawBack
                    end
                    local ____opt_result_673
                    if ____opt_671 ~= nil then
                        ____opt_result_673 = ____opt_671(____opt_671, __L1.c, o)
                    end
                    return ____opt_result_673
                end)
                __L1:safe(function()
                    local ____opt_676 = window.CampanhaTaxi
                    if ____opt_676 ~= nil then
                        ____opt_676 = ____opt_676.desenhar
                    end
                    local ____opt_result_678
                    if ____opt_676 ~= nil then
                        ____opt_result_678 = ____opt_676(____opt_676, __L1.c, o)
                    end
                    return ____opt_result_678
                end)
                __L1:safe(function()
                    local ____opt_681 = window.CampanhaLoja
                    if ____opt_681 ~= nil then
                        ____opt_681 = ____opt_681.desenhar
                    end
                    local ____opt_result_683
                    if ____opt_681 ~= nil then
                        ____opt_result_683 = ____opt_681(____opt_681, __L1.c, o)
                    end
                    return ____opt_result_683
                end)
                __L1:safe(function()
                    local ____opt_686 = window.CampanhaMoradores
                    if ____opt_686 ~= nil then
                        ____opt_686 = ____opt_686.desenhar
                    end
                    local ____opt_result_688
                    if ____opt_686 ~= nil then
                        ____opt_result_688 = ____opt_686(____opt_686, __L1.c, o)
                    end
                    return ____opt_result_688
                end)
            end
            __L1:desenharExtras()
            __L1:safe(function()
                local ____opt_691 = window.CampanhaAliados
                if ____opt_691 ~= nil then
                    ____opt_691 = ____opt_691.desenhar
                end
                local ____opt_result_693
                if ____opt_691 ~= nil then
                    ____opt_result_693 = ____opt_691(____opt_691, __L1.c, d.id)
                end
                return ____opt_result_693
            end)
        end
        if __t(F) then
            F:desenhar(__L1.c)
        end
        if not __t(percurso) then
            local ____iter_700 = __iter
            local ____t_699 = __t
            local ____opt_696 = window.CampanhaAliados
            if ____opt_696 ~= nil then
                ____opt_696 = ____opt_696.alvos
            end
            local ____opt_result_698
            if ____opt_696 ~= nil then
                ____opt_result_698 = ____opt_696(____opt_696, d.id)
            end
            __O[1056] = ____opt_result_698
            for ____, ax in __TS__Iterator(____iter_700(if ____t_699(____opt_result_698) then __O[1056] else __arrL({}, 0))) do
                local y = __L1.FLOOR - 150 + math.sin(__L1.t * 4 + ax) * 4
                __L1.c.fillStyle = "#1c1408"
                __L1.c:fillRect(ax - 7, y - 7, 14, 14)
                __L1.c.fillStyle = "#7af07a"
                __L1.c:fillRect(ax - 5, y - 5, 10, 10)
                __L1.c.fillStyle = "#1c1408"
                __L1.c:fillRect(ax - 1, y - 4, 2, 5)
                __L1.c:fillRect(ax - 1, y + 2, 2, 2)
            end
        end
        __L1:safe(function()
            local ____opt_703 = __L1:TR()
            if ____opt_703 ~= nil then
                ____opt_703 = ____opt_703.desenharAtras
            end
            local ____opt_result_705
            if ____opt_703 ~= nil then
                ____opt_result_705 = ____opt_703(____opt_703, __L1.c, __L1.t)
            end
            return ____opt_result_705
        end)
        local at = if __t(__L1.P.attack) then __L1.P.attack else 0
        local dur = if __t(__L1.P.attackDuration) then __L1.P.attackDuration else 0.32
        local ____t_708 = __t
        local ____t_707 = __t
        local ____gt_result_706 = __gt(if __t(__L1.P.inv) then __L1.P.inv else 0, 0)
        __O[1057] = ____gt_result_706
        if not ____t_708(if ____t_707(____gt_result_706) then __mod(
            math.floor(__L1.t * 16),
            2
        ) else __O[1057]) then
            local ____self_753 = window.Art
            local ____self_753_drawCharacter_754 = ____self_753.drawCharacter
            local ____array_752 = __TS__SparseArrayNew(__L1.c, "daroca", __L1.P.x, __L1.P.y)
            local ____temp_740 = if math.abs(__L1.P.vx) > 8 then if __t(__L1.P.anim) then __L1.P.anim else 0 / 9 else __L1.t
            local ____math_abs_result_741 = math.abs(__L1.P.vx)
            local ____t_714 = __t
            local ____opt_711 = __L1:TR()
            if ____opt_711 ~= nil then
                ____opt_711 = ____opt_711.musculoso
            end
            local ____opt_result_713
            if ____opt_711 ~= nil then
                ____opt_result_713 = ____opt_711(____opt_711)
            end
            local ____temp_742 = not not ____t_714(____opt_result_713)
            local ____temp_743 = if __t(__L1.P.landTimer) then __L1.P.landTimer else 0 / 0.15
            local ____temp_744 = if __t(__L1.P.landTimer) then __L1.P.landTimer else 0
            local ____L1_P_facing_745 = __L1.P.facing
            local ____t_718 = __t
            local ____t_716 = __t
            local ____temp_715 = math.abs(__L1.P.vx) > 8
            __O[1058] = ____temp_715
            local ____temp_717 = if ____t_716(____temp_715) then __L1.P.ground else __O[1058]
            __O[1059] = ____temp_717
            local ____opt_719 = __L1.viagem
            if ____opt_719 ~= nil then
                ____opt_719 = ____opt_719.tipo
            end
            local ____temp_746 = if ____t_718(____temp_717) then __O[1059] else ____opt_719 == "porta"
            local ____L1_P_ground_747 = __L1.P.ground
            local ____L1_P_vy_748 = __L1.P.vy
            local ____temp_749 = at > 0
            local ____temp_750 = if __t(__L1.P.attackType) then __L1.P.attackType else "paper"
            local ____temp_751 = 1 - at / dur
            local ____t_726 = __t
            local ____opt_723 = __L1.fase
            if ____opt_723 ~= nil then
                ____opt_723 = ____opt_723.luta
            end
            local ____opt_result_725
            if ____opt_723 ~= nil then
                ____opt_result_725 = ____opt_723.estrada
            end
            local ____temp_733 = not ____t_726(____opt_result_725)
            if ____temp_733 then
                local ____t_732 = __t
                local ____opt_729 = __L1:TR()
                if ____opt_729 ~= nil then
                    ____opt_729 = ____opt_729.voandoAgora
                end
                local ____opt_result_731
                if ____opt_729 ~= nil then
                    ____opt_result_731 = ____opt_729(____opt_729)
                end
                ____temp_733 = not not ____t_732(____opt_result_731)
            end
            local ____t_739 = __t
            local ____opt_736 = __L1:TR()
            if ____opt_736 ~= nil then
                ____opt_736 = ____opt_736.dashing
            end
            local ____opt_result_738
            if ____opt_736 ~= nil then
                ____opt_result_738 = ____opt_736(____opt_736)
            end
            __TS__SparseArrayPush(
                ____array_752,
                {
                    frame = ____temp_740,
                    speed = ____math_abs_result_741,
                    muscular = ____temp_742,
                    land = ____temp_743,
                    landTimer = ____temp_744,
                    facing = ____L1_P_facing_745,
                    moving = ____temp_746,
                    grounded = ____L1_P_ground_747,
                    vy = ____L1_P_vy_748,
                    attack = ____temp_749,
                    attackType = ____temp_750,
                    attackProgress = ____temp_751,
                    attackObject = "paper",
                    flight = ____temp_733,
                    dash = not not ____t_739(____opt_result_738),
                    recoil = if __t(at > 0 and if __t(__L1.P.attackType) then __L1.P.attackType else "paper" == "paper") then math.max(0, 1 - (1 - at / dur) * 3) else 0
                }
            )
            ____self_753_drawCharacter_754(
                ____self_753,
                __TS__SparseArraySpread(____array_752)
            )
        end
        __L1:safe(function()
            local ____opt_757 = __L1:TR()
            if ____opt_757 ~= nil then
                ____opt_757 = ____opt_757.desenhar
            end
            local ____opt_result_759
            if ____opt_757 ~= nil then
                ____opt_result_759 = ____opt_757(____opt_757, __L1.c, __L1.t)
            end
            return ____opt_result_759
        end)
        if not __t(percurso) then
            __L1:safe(function()
                local ____opt_762 = window.Interact
                if ____opt_762 ~= nil then
                    ____opt_762 = ____opt_762.drawFront
                end
                local ____opt_result_764
                if ____opt_762 ~= nil then
                    ____opt_result_764 = ____opt_762(____opt_762, __L1.c, o)
                end
                return ____opt_result_764
            end)
        end
        if __t(not __t(percurso) and __ge(d.id, 12)) then
            __L1:safe(function()
                local ____opt_767 = window.CampanhaPlantas
                if ____opt_767 ~= nil then
                    ____opt_767 = ____opt_767.drawFront
                end
                local ____opt_result_769
                if ____opt_767 ~= nil then
                    ____opt_result_769 = ____opt_767(____opt_767, __L1.c, o)
                end
                return ____opt_result_769
            end)
            __L1:safe(function()
                local ____opt_772 = window.CampanhaCamadas
                if ____opt_772 ~= nil then
                    ____opt_772 = ____opt_772.primeiroPlano
                end
                local ____opt_result_774
                if ____opt_772 ~= nil then
                    ____opt_result_774 = ____opt_772(____opt_772, __L1.c, o)
                end
                return ____opt_result_774
            end)
        end
        __L1:procurarPerto()
        if __t(__L1.perto) then
            __L1.c.font = "11px Pixel, monospace"
            local w = __len(__L1.perto.rotulo) * 7.6 + 34
            local x = __L1.perto.x
            local y = __L1.FLOOR - 150
            __L1.c.fillStyle = "#1c342de8"
            __L1.c:fillRect(x - w / 2, y - 13, w, 26)
            __L1.c.strokeStyle = "#e8c66a"
            __L1.c:strokeRect(x - w / 2 + 0.5, y - 12.5, w - 1, 25)
            __L1.c.textAlign = "center"
            __L1.c.textBaseline = "middle"
            __L1.c.fillStyle = "#f3d89e"
            __L1.c:fillText(
                __add("[E] ", __L1.perto.rotulo),
                x,
                y + 1
            )
            __L1.c.textAlign = "left"
        end
        __L1.c.font = "13px Pixel, monospace"
        __L1.c.textAlign = "center"
        do
            local i = __len(__L1.xpTxt) - 1
            while i >= 0 do
                local x0 = __get(__L1.xpTxt, i)
                x0.t = x0.t + 1 / 60
                if __gt(x0.t, 1.2) then
                    __call(__L1.xpTxt, "splice", i, 1)
                    continue
                end
                __L1.c.globalAlpha = math.min(1, (1.2 - x0.t) * 2)
                __L1.c.fillStyle = "#2a1a08"
                __L1.c:fillText(x0.s, x0.x + 2, x0.y - x0.t * 30 + 2)
                __L1.c.fillStyle = "#ffec91"
                __L1.c:fillText(x0.s, x0.x, x0.y - x0.t * 30)
                i = i - 1
            end
        end
        __L1.c.globalAlpha = 1
        __L1.c.font = "16px Pixel, monospace"
        __L1.c.textAlign = "center"
        for ____, d0 in __iterar((__L1.dano)) do
            __L1.c.globalAlpha = 1 - d0.t
            __L1.c.fillStyle = "#2a0808"
            __L1.c:fillText(d0.s, d0.x + 2, d0.y - d0.t * 40 + 2)
            __L1.c.fillStyle = "#ff5a4a"
            __L1.c:fillText(d0.s, d0.x, d0.y - d0.t * 40)
        end
        __L1.c.globalAlpha = 1
        __L1.c.textAlign = "left"
        __L1.c:restore()
        if not __t(percurso) then
            __L1:safe(function()
                local ____opt_777 = window.CampanhaAmbientes
                if ____opt_777 ~= nil then
                    ____opt_777 = ____opt_777.cobrir
                end
                local ____opt_result_779
                if ____opt_777 ~= nil then
                    ____opt_result_779 = ____opt_777(____opt_777, __L1.c, d.id, __L1.cam)
                end
                return ____opt_result_779
            end)
        end
        local ____t_786 = __t
        local ____opt_result_784
        if F ~= nil then
            ____opt_result_784 = F.emArena
        end
        local ____opt_result_785
        if ____opt_result_784 ~= nil then
            ____opt_result_785 = ____opt_result_784(F)
        end
        if not ____t_786(____opt_result_785) then
            __L1:setaObjetivo()
        end
        if __t(F) then
            F:desenharTela(__L1.c, __L1.W)
        end
        do
            local ____opt_789 = window.CampanhaAliados
            if ____opt_789 ~= nil then
                ____opt_789 = ____opt_789.correndo
            end
            local ____opt_result_791
            if ____opt_789 ~= nil then
                ____opt_result_791 = ____opt_789(____opt_789)
            end
            local cr = ____opt_result_791
            if __t(cr) then
                local txt = if cr.fase == "contagem" then tostring(math.ceil(cr.cont)) else __add(
                    __call(
                        math.max(0, cr.lim - cr.t),
                        "toFixed",
                        1
                    ),
                    " s"
                )
                __L1.c.fillStyle = "#1c1408"
                __L1.c:fillRect(__L1.W / 2 - 70, 70, 140, 34)
                __L1.c.fillStyle = "#ffd24a"
                __L1.c:fillRect(__L1.W / 2 - 68, 72, 136, 30)
                __L1.c.font = "16px Pixel, monospace"
                __L1.c.textAlign = "center"
                __L1.c.textBaseline = "middle"
                __L1.c.fillStyle = "#1c1408"
                __L1.c:fillText(
                    __add("🛹 ", txt),
                    __L1.W / 2,
                    88
                )
                __L1.c.textAlign = "left"
            end
        end
        if __L1.clarao > 0 then
            __L1.c.globalAlpha = __L1.clarao
            __L1.c.fillStyle = __L1.claraoCor
            __L1.c:fillRect(0, 0, __L1.W, __L1.H)
            __L1.c.globalAlpha = 1
        end
        if __t(__L1.P.hp < 30 and not __t(__L1.cut)) then
            local a = 0.18 + math.sin(__L1.t * 6) * 0.08
            local g = __L1.c:createRadialGradient(
                __L1.W / 2,
                __L1.H / 2,
                200,
                __L1.W / 2,
                __L1.H / 2,
                600
            )
            g:addColorStop(0, "rgba(0,0,0,0)")
            g:addColorStop(
                1,
                ("rgba(140,0,10," .. tostring(a)) .. ")"
            )
            __L1.c.fillStyle = g
            __L1.c:fillRect(0, 0, __L1.W, __L1.H)
        end
        local ____table_style_799 = __L1.box:querySelector(".obj").style
        local ____t_798 = __t
        local ____opt_result_796
        if F ~= nil then
            ____opt_result_796 = F.emArena
        end
        local ____opt_result_797
        if ____opt_result_796 ~= nil then
            ____opt_result_797 = ____opt_result_796(F)
        end
        ____table_style_799.visibility = if ____t_798(____opt_result_797) then "hidden" else "visible"
        local ____t_805 = __t
        local ____opt_802 = window.Graphics
        if ____opt_802 ~= nil then
            ____opt_802 = ____opt_802.isShader
        end
        local ____opt_result_804
        if ____opt_802 ~= nil then
            ____opt_result_804 = ____opt_802(____opt_802)
        end
        if ____t_805(____opt_result_804) then
            __L1:safe(function()
                local ____opt_808 = window.Shader
                if ____opt_808 ~= nil then
                    ____opt_808 = ____opt_808.apply
                end
                local ____opt_result_810
                if ____opt_808 ~= nil then
                    ____opt_result_810 = ____opt_808(
                        ____opt_808,
                        __L1.cv,
                        {
                            scene = d.id,
                            camera = __L1.cam,
                            time = __L1.t,
                            outdoor = not __t(d.interno)
                        }
                    )
                end
                return ____opt_result_810
            end)
        end
        if __L1.fade > 0 then
            __L1.c.fillStyle = ("rgba(8,10,14," .. tostring(__L1.fade)) .. ")"
            __L1.c:fillRect(0, 0, __L1.W, __L1.H)
        end
        __L1:hudAtualizar()
    end
    __L1.abrir = function(self, o)
        if o == nil then
            o = {}
        end
        if not __t(__L1.box) then
            __L1:montar()
        end
        local ____t_814 = __t
        local ____t_812 = __t
        local ____temp_811 = not __t(o.novo)
        __O[1060] = ____temp_811
        local ____temp_813 = if ____t_812(____temp_811) then __L1:carregar() else __O[1060]
        __O[1061] = ____temp_813
        __L1.S = if ____t_814(____temp_813) then __O[1061] else __L1:novoSave()
        if __L1.S.passo == "bairro" then
            __L1.S.passo = "creuza"
        end
        if __L1.S.passo == "fim6b" then
            __L1.S.passo = "ir_barao"
        end
        if __L1.S.passo == "fim6c" then
            __L1.S.passo = "ir_centro"
        end
        __L1.fase = nil
        __L1.morto = false
        local ____opt_815 = __L1.box:querySelector(".pausa")
        if ____opt_815 ~= nil then
            ____opt_815:remove()
        end
        if __t(o.novo) then
            __L1:safe(function() return window.localStorage:removeItem(__L1.KEY) end)
        end
        __L1.aberto = true
        __L1.box.hidden = false
        __L1.pausado = false
        __L1.cut = nil
        __call(__L1.keys, "clear")
        __L1.P.hp = if __t(__L1.S.hp) then __L1.S.hp else 100
        local ____opt_819 = window.CampanhaAliados
        if ____opt_819 ~= nil then
            ____opt_819 = ____opt_819.ligar
        end
        if ____opt_819 ~= nil then
            ____opt_819(
                ____opt_819,
                {
                    P = __L1.P,
                    S = function() return __L1.S end,
                    salvar = function() return __L1:salvar() end,
                    item = __L1.item,
                    aviso = __L1.aviso,
                    sfx = __L1.sfx,
                    conversa = function(____, npc) return __L1:conversa(npc) end,
                    escolher = function(____, q, pg, ops, cb) return __L1:escolher(
                        q,
                        pg,
                        ops,
                        cb,
                        true
                    ) end,
                    tela = function() return __L1.box:querySelector(".tela") end,
                    cena = function() return __L1.cenaId end,
                    pausar = function(____, v)
                        __call(__L1.keys, "clear")
                        __L1:hudVisivel(not __t(v))
                        __L1.box:querySelector(".pular").hidden = true
                    end
                }
            )
        end
        local ____opt_823 = __L1:TR()
        if ____opt_823 ~= nil then
            ____opt_823 = ____opt_823.ligar
        end
        if ____opt_823 ~= nil then
            ____opt_823(____opt_823, true, __L1.P, {jogo = true})
        end
        __L1:safe(function()
            local ____opt_827 = window.CampanhaBotoes
            if ____opt_827 ~= nil then
                ____opt_827 = ____opt_827.aplicar
            end
            local ____opt_result_829
            if ____opt_827 ~= nil then
                ____opt_result_829 = ____opt_827(
                    ____opt_827,
                    __L1.box:querySelector(".tela")
                )
            end
            return ____opt_result_829
        end)
        __L1:safe(__L1.carregarC1)
        __L1:safe(function()
            local ____opt_832 = window.CampanhaPoderes
            if ____opt_832 ~= nil then
                ____opt_832 = ____opt_832.controles
            end
            local ____opt_result_834
            if ____opt_832 ~= nil then
                ____opt_result_834 = ____opt_832(____opt_832, true, {forcar = true})
            end
            return ____opt_result_834
        end)
        __L1:safe(__L1.controlesC1)
        window:dispatchEvent(__new("Event", "c2-controles"))
        window:requestAnimationFrame(function() return window:requestAnimationFrame(function()
            if __t(__L1.aberto) then
                __L1:safe(__L1.controlesC1)
            end
        end) end)
        if __L1.S.passo == "abertura" then
            __L1:irPara(0, 700)
            __L1:tocar("c2_abertura", __L1.PASSOS.abertura.depois)
        else
            local ____L1_irPara_838 = __L1.irPara
            local ____L1_S_cena_835 = __L1.S.cena
            if ____L1_S_cena_835 == nil then
                ____L1_S_cena_835 = __get(__L1.PASSO_INICIAL_DA_CENA, __L1.S.passo)
            end
            local ____L1_S_cena_835_836 = ____L1_S_cena_835
            if ____L1_S_cena_835_836 == nil then
                ____L1_S_cena_835_836 = 13
            end
            local ____L1_S_x_837 = __L1.S.x
            if ____L1_S_x_837 == nil then
                ____L1_S_x_837 = 300
            end
            ____L1_irPara_838(__L1, ____L1_S_cena_835_836, ____L1_S_x_837)
            local ____L1_objetivoNovo_842 = __L1.objetivoNovo
            local ____t_841 = __t
            local ____opt_839 = __get(__L1.PASSOS, __L1.S.passo)
            if ____opt_839 ~= nil then
                ____opt_839 = ____opt_839.obj
            end
            __O[1062] = ____opt_839
            ____L1_objetivoNovo_842(__L1, if ____t_841(____opt_839) then __O[1062] else "")
            __L1:hudVisivel(true)
        end
        __L1.last = window.performance:now()
        window:cancelAnimationFrame(__L1.raf)
        __L1.raf = window:requestAnimationFrame(__L1.frame)
        window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {active = true}}))
    end
    __L1.fechar = function(self)
        __L1:safe(__L1.devolverTopo)
        __L1:salvarProgressao()
        __L1.aberto = false
        window:cancelAnimationFrame(__L1.raf)
        if __t(__L1.box) then
            __L1.box.hidden = true
        end
        __L1.pausado = false
        local ____opt_845 = __L1.box
        if ____opt_845 ~= nil then
            ____opt_845 = ____opt_845:querySelector(".pausa")
        end
        if ____opt_845 ~= nil then
            ____opt_845:remove()
        end
        local ____opt_847 = __L1.box
        if ____opt_847 ~= nil then
            ____opt_847.classList:remove("c2-dialogo")
        end
        local ____opt_851 = __L1:TR()
        if ____opt_851 ~= nil then
            ____opt_851 = ____opt_851.ligar
        end
        if ____opt_851 ~= nil then
            ____opt_851(____opt_851, false, __L1.P)
        end
        __L1:safe(function()
            local ____opt_855 = window.CampanhaPoderes
            if ____opt_855 ~= nil then
                ____opt_855 = ____opt_855.controles
            end
            local ____opt_result_857
            if ____opt_855 ~= nil then
                ____opt_result_857 = ____opt_855(____opt_855, false, {forcar = false})
            end
            return ____opt_result_857
        end)
        __L1:safe(function()
            local ____opt_862 = window.CampanhaCutscenes
            if ____opt_862 ~= nil then
                ____opt_862 = ____opt_862.musica
            end
            local ____opt_result_864
            if ____opt_862 ~= nil then
                ____opt_result_864 = ____opt_862.parar
            end
            local ____opt_result_865
            if ____opt_result_864 ~= nil then
                ____opt_result_865 = ____opt_result_864(____opt_862)
            end
            return ____opt_result_865
        end)
        window.__somCutscene = false
        do
            pcall(function()
                local ____opt_868 = window.DayTime
                if ____opt_868 ~= nil then
                    ____opt_868 = ____opt_868.force
                end
                if ____opt_868 ~= nil then
                    ____opt_868(____opt_868, nil)
                end
            end)
        end
        window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {active = false}}))
    end
    __L1.painel = function(self)
        local ok = __L1:liberada()
        local el = window.document:getElementById("c2Painel")
        if not __t(el) then
            el = window.document:createElement("div")
            el.id = "c2Painel"
            el.className = "c2j"
            el.style.background = "#06080cdd"
            window.document.body:appendChild(el)
            __L1:css()
        end
        el.hidden = false
        el.innerHTML = ("<div class=\"pausa\" style=\"position:relative;background:none\"><h2>CAMPANHA 2 · VITÓRIA DA CONQUISTA</h2>" .. if __t(ok) then ((((("<p>" .. if __t(__L1:safe(
            function()
                local ____self_876 = window.JSON
                local ____self_876_parse_877 = ____self_876.parse
                local ____t_875 = __t
                local ____temp_874 = window.localStorage:getItem(__L1.KEY)
                __O[1063] = ____temp_874
                local ____opt_872 = ____self_876_parse_877(____self_876, if ____t_875(____temp_874) then __O[1063] else "null")
                if ____opt_872 ~= nil then
                    ____opt_872 = ____opt_872.flags
                end
                local ____opt_result_878
                if ____opt_872 ~= nil then
                    ____opt_result_878 = ____opt_872.zerou
                end
                return ____opt_result_878
            end,
            false
        )) then "✔ Campanha 2 completa: o trio voltou! Continue explorando Conquista." else "Um ano depois. O Jorge ligou... e desligou. Agora o Da Roça vai até Conquista olhar na cara dele.") .. "</p>") .. if __t(__L1:temSave()) then "<button type=\"button\" data-a=\"cont\">▶ CONTINUAR</button>" else "") .. "<button type=\"button\" data-a=\"novo\">") .. if __t(__L1:temSave()) then "COMEÇAR DE NOVO" else "▶ COMEÇAR") .. "</button>" else "<p>🔒 Termine a campanha principal (até a ligação do Jorge) para liberar a Campanha 2.</p>") .. "<button type=\"button\" data-a=\"fechar\">VOLTAR</button></div>"
        el.onclick = function(____, e)
            local ____opt_879 = e.target:closest("button")
            if ____opt_879 ~= nil then
                ____opt_879 = ____opt_879.dataset.a
            end
            local a = ____opt_879
            if not __t(a) then
                return
            end
            if a == "fechar" then
                el.hidden = true
            end
            if a == "cont" then
                el.hidden = true
                __L1:abrir({})
            end
            if a == "novo" then
                local function vai()
                    el.hidden = true
                    __L1:abrir({novo = true})
                end
                if not __t(__L1:temSave()) then
                    return vai(nil)
                end
                local pergunta = {titulo = "COMEÇAR A CAMPANHA 2 DO ZERO?", html = "Você já tem um save da Campanha 2.<br>Começar de novo <b>apaga todo o progresso dela</b> (vilões vencidos, cenários e itens da campanha 2).<br>A campanha principal, seu nível e atributos não mudam.<br><br>Tem certeza?", sim = "APAGAR E COMEÇAR", nao = "CANCELAR"}
                if __t(window.Confirmar) then
                    local ____self_881 = window:Confirmar(pergunta)
                    ____self_881["then"](
                        ____self_881,
                        function(____, ok)
                            if __t(ok) then
                                vai(nil)
                            end
                        end
                    )
                elseif __t(window:confirm("Começar a Campanha 2 de novo? O progresso dela será apagado.")) then
                    vai(nil)
                end
            end
        end
        window:setTimeout(
            function()
                local ____opt_882 = el:querySelector("button")
                return ____opt_882 and ____opt_882:focus()
            end,
            30
        )
    end
    __L1.botaoMenu = function(self)
        local lista = window.document:querySelector("#startScreen .ranch-mode-entries")
        local ____t_886 = __t
        local ____t_885 = __t
        local ____temp_884 = not __t(lista)
        __O[1064] = ____temp_884
        if ____t_886(if ____t_885(____temp_884) then __O[1064] else lista:querySelector("[data-open-campanha2]")) then
            return
        end
        local b = window.document:createElement("button")
        b.type = "button"
        b.dataset.openCampanha2 = ""
        b.innerHTML = ("<b>❄ CAMPANHA 2 · CONQUISTA</b><small>" .. if __t(__L1:liberada()) then "Um ano depois · a busca pelo Jorge" else "Complete a história para liberar") .. "</small>"
        b:addEventListener(
            "click",
            function(____, e)
                e:preventDefault()
                __L1:painel()
            end
        )
        lista:appendChild(b)
    end
    local ____ = "use strict"
    local ____t_889 = __t
    local ____t_888 = __t
    local ____temp_887 = if __t(window.Campanha2) then window.Campanha2 else not __t(window.CampanhaCenarios)
    __O[961] = ____temp_887
    if ____t_889(if ____t_888(____temp_887) then __O[961] else not __t(window.Art)) then
        return
    end
    __L1.W = 960
    __L1.H = 540
    __L1.FLOOR = 440
    __L1.KEY = "daroca-c2-save"
    __L1.CC = function() return window.CampanhaCenarios end
    __L1.RT = function() return window.Roteiro end
    __L1.TR = function() return window.CampanhaTreino end
    __L1.clamp = function(____, v, a, b) return math.max(
        a,
        math.min(b, v)
    ) end
    __L1.safe = function(____, f, d)
        do
            local function ____catch(e)
                return true, d
            end
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                return true, f(nil)
            end)
            if not ____try then
                ____hasReturned, ____returnValue = ____catch(____hasReturned)
            end
            if ____hasReturned then
                return ____returnValue
            end
        end
    end
    __L1.novoSave = function() return {
        v = 1,
        passo = "abertura",
        cena = 0,
        x = 700,
        hp = 100,
        flags = {},
        criado = window.Date:now(),
        salvo = 0
    } end
    __L1.S = nil
    __L1.temSave = function() return not not __t(__L1:safe(
        function()
            local ____self_894 = window.JSON
            local ____self_894_parse_895 = ____self_894.parse
            local ____t_893 = __t
            local ____temp_892 = window.localStorage:getItem(__L1.KEY)
            __O[965] = ____temp_892
            local ____opt_890 = ____self_894_parse_895(____self_894, if ____t_893(____temp_892) then __O[965] else "null")
            if ____opt_890 ~= nil then
                ____opt_890 = ____opt_890.passo
            end
            return ____opt_890
        end,
        false
    )) end
    __L1.NOMES_C1 = function()
        local ____t_898 = __t
        local ____opt_896 = window.Campaign
        if ____opt_896 ~= nil then
            ____opt_896 = ____opt_896.sceneNames
        end
        __O[974] = ____opt_896
        return if ____t_898(____opt_896) then __O[974] else __arrL({}, 0)
    end
    __L1.EXTRA_PLAT = {["0"] = __arrL(
        {
            __arrL({3280, 412, 50}, 3),
            __arrL({3330, 384, 50}, 3),
            __arrL({3380, 356, 50}, 3),
            __arrL({3430, 328, 54}, 3)
        },
        4
    )}
    __L1.PASSOS = __ord(
        {
            abertura = __ord(
                {
                    roteiro = "c2_abertura",
                    depois = function()
                        __L1:irPara(0, 700)
                        __L1:passo("passaporte")
                    end
                },
                "roteiro,depois"
            ),
            passaporte = __ord({obj = "Pegue seu passaporte. Ele ficou em cima dos fardos de feno, perto de casa, no fim da roça.", cena = 0, alvo = 3456, hora = 6.6}, "obj,cena,alvo,hora"),
            lucas = __ord({obj = "Despeça-se da turma (se quiser) e encontre o Lucas na trilha, no fim da roça.", cena = 0, alvo = 4560, hora = 7.2}, "obj,cena,alvo,hora"),
            checkin = __ord({obj = "Faça o check-in no balcão. O Miguel te explica.", cena = 12, alvo = 640, hora = 9}, "obj,cena,alvo,hora"),
            raiox = __ord({obj = "Passe pelo raio-X.", cena = 12, alvo = 1330, hora = 9.2}, "obj,cena,alvo,hora"),
            portao = __ord({obj = "Vá até o portão de embarque.", cena = 12, alvo = 1760, hora = 9.4}, "obj,cena,alvo,hora"),
            taxi1 = __ord({obj = "Pegue o táxi do Seu Zé no ponto do desembarque.", cena = 12, alvo = 4000, hora = 7.4}, "obj,cena,alvo,hora"),
            lurdes = __ord({obj = "Fale com a Dona Lurdes, na porta da pensão.", cena = 13, alvo = 1830, hora = 18.2}, "obj,cena,alvo,hora"),
            creuza = __ord({
                obj = "Saia da pensão e siga pela rua do bairro. Dizem que uma vizinha anda espalhando coisas sobre você...",
                cena = 13,
                alvo = 3520,
                hora = 9.5,
                fase = "creuza"
            }, "obj,cena,alvo,hora,fase"),
            ir_tonhao = __ord({
                obj = "Pegue o táxi do Seu Zé (em frente à pensão) até o Monumento ao Índio. Dica: na Feira, o Seu Lindomar já vende a FOFOCA CONFUSA.",
                cena = 13,
                alvo = 1500,
                hora = 12,
                ir = 16,
                prox = "tonhao"
            }, "obj,cena,alvo,hora,ir,prox"),
            tonhao = __ord({
                obj = "Atravesse a avenida. O Tonhão do Mototáxi espera depois da rotatória...",
                cena = 16,
                alvo = 5320,
                hora = 11,
                fase = "tonhao"
            }, "obj,cena,alvo,hora,fase"),
            ir_valdomiro = __ord({
                obj = "Volte ao ponto de táxi perto do Monumento e vá até a Feira do Planalto.",
                cena = 16,
                alvo = 2700,
                hora = 12,
                ir = 17,
                prox = "valdomiro"
            }, "obj,cena,alvo,hora,ir,prox"),
            valdomiro = __ord({
                obj = "Atravesse a Feira do Planalto. O chefão dela não gosta de forasteiro...",
                cena = 17,
                alvo = 3560,
                hora = 9,
                fase = "valdomiro"
            }, "obj,cena,alvo,hora,fase"),
            ir_kaua = __ord({
                obj = "Pegue o táxi na entrada da Feira e vá até a Trilha do Cristo, na Serra do Periperi.",
                cena = 17,
                alvo = 400,
                hora = 15,
                ir = 15,
                prox = "kaua"
            }, "obj,cena,alvo,hora,ir,prox"),
            kaua = __ord({
                obj = "Suba a Serra do Periperi até o Cristo. Cuidado com os buracos e com os urubus.",
                cena = 15,
                alvo = 4520,
                hora = 16.8,
                fase = "kaua"
            }, "obj,cena,alvo,hora,fase"),
            ir_barao = __ord({
                obj = "Volte ao ponto de táxi no pé da serra e vá até as Fazendas de Café. Dizem que o Barão quer a terra de todo mundo...",
                cena = 15,
                alvo = 300,
                hora = 17.5,
                ir = 18,
                prox = "barao"
            }, "obj,cena,alvo,hora,ir,prox"),
            barao = __ord({
                obj = "Atravesse o cafezal. Pule os canais de irrigação e cuidado com os capangas do Barão.",
                cena = 18,
                alvo = 4600,
                hora = 8,
                fase = "barao"
            }, "obj,cena,alvo,hora,fase"),
            ir_breno = __ord({
                obj = "Pegue o táxi na porteira da fazenda e vá ao Teatro e Planetário. Hoje tem Festival de Inverno... e um valentão.",
                cena = 18,
                alvo = 300,
                hora = 12,
                ir = 19,
                prox = "breno"
            }, "obj,cena,alvo,hora,ir,prox"),
            breno = __ord({
                obj = "Passe pelo Festival de Inverno. O Breno Pitbull espera depois do Planetário.",
                cena = 19,
                alvo = 3800,
                hora = 20.5,
                fase = "breno"
            }, "obj,cena,alvo,hora,fase"),
            ir_gemeos = __ord({
                obj = "Pegue o táxi na entrada do Teatro e vá até a frente do Shopping. Entre e encontre a LAN house.",
                cena = 19,
                alvo = 300,
                hora = 21,
                ir = 22,
                prox = "gemeos"
            }, "obj,cena,alvo,hora,ir,prox"),
            gemeos = __ord({
                obj = "Entre no shopping e vá até a LAN house no fim do corredor. Os gêmeos não sabem perder.",
                cena = 20,
                alvo = 3560,
                hora = 19,
                fase = "gemeos",
                via = {["22"] = 1360}
            }, "obj,cena,alvo,hora,fase,via"),
            ir_fred = __ord({
                obj = "Saia do shopping e pegue o táxi até a entrada da Escola SESI. Amanhã de manhã, o Jorge vai estar no pátio.",
                cena = 22,
                alvo = 1100,
                hora = 9.5,
                ir = 21,
                prox = "fred",
                via = {["20"] = 90}
            }, "obj,cena,alvo,hora,ir,prox,via"),
            fred = __ord({
                obj = "Entre na escola e suba a escada até o pátio do 2º andar. O Jorge está lá... e o Fred também.",
                cena = 27,
                alvo = 1560,
                hora = 10,
                fase = "fred",
                via = {["21"] = 3940, ["26"] = 1560}
            }, "obj,cena,alvo,hora,fase,via"),
            ir_centro = __ord({
                obj = "Hoje à noite o Jorge vai estar na praça da Catedral. Desça a escada, saia da escola e pegue o táxi até o Centro.",
                cena = 27,
                alvo = 58,
                hora = 18.5,
                via = {["26"] = 70, ["21"] = 3700},
                ir = 14,
                prox = "jorge"
            }, "obj,cena,alvo,hora,via,ir,prox"),
            jorge = __ord({
                obj = "Ande até a praça da Catedral. O Jorge está lá, com a turma nova.",
                cena = 14,
                alvo = 2640,
                hora = 21,
                fase = "jorge"
            }, "obj,cena,alvo,hora,fase"),
            zerou = __ord({obj = "Você zerou a Campanha 2! O trio voltou. Explore Conquista à vontade: táxi, feira, garrafadas e os moradores.", cena = 14, hora = 21.5}, "obj,cena,hora")
        },
        "abertura,passaporte,lucas,checkin,raiox,portao,taxi1,lurdes,creuza,ir_tonhao,tonhao,ir_valdomiro,valdomiro,ir_kaua,kaua,ir_barao,barao,ir_breno,breno,ir_gemeos,gemeos,ir_fred,fred,ir_centro,jorge,zerou"
    )
    __L1.APOS_VITORIA = __ord({
        creuza = "ir_tonhao",
        tonhao = "ir_valdomiro",
        valdomiro = "ir_kaua",
        kaua = "ir_barao",
        barao = "ir_breno",
        breno = "ir_gemeos",
        gemeos = "ir_fred",
        fred = "ir_centro",
        jorge = "zerou"
    }, "creuza,tonhao,valdomiro,kaua,barao,breno,gemeos,fred,jorge")
    __L1.PASSO_INICIAL_DA_CENA = __ord({
        passaporte = 0,
        lucas = 0,
        checkin = 12,
        raiox = 12,
        portao = 12,
        taxi1 = 12,
        lurdes = 13,
        creuza = 25,
        ir_tonhao = 13,
        tonhao = 16,
        ir_valdomiro = 16,
        valdomiro = 17,
        ir_kaua = 17,
        kaua = 15,
        ir_barao = 15,
        barao = 18,
        ir_breno = 18,
        breno = 19,
        ir_gemeos = 19,
        gemeos = 22,
        ir_fred = 20,
        fred = 21,
        ir_centro = 27,
        jorge = 14,
        zerou = 14
    }, "passaporte,lucas,checkin,raiox,portao,taxi1,lurdes,creuza,ir_tonhao,tonhao,ir_valdomiro,valdomiro,ir_kaua,kaua,ir_barao,barao,ir_breno,breno,ir_gemeos,gemeos,ir_fred,fred,ir_centro,jorge,zerou")
    __L1.NPC = __arrL(
        {
            __ord(
                {
                    id = "reeis",
                    quem = "reeis",
                    cena = 0,
                    x = 1020,
                    quando = __arrL({"passaporte", "lucas"}, 2),
                    rotulo = "FALAR COM O REEIS",
                    falas = __arrL(
                        {
                            __arrL({"reeis", "Vai mesmo, né? Atrás do Gordo.", "sad"}, 3),
                            __arrL({"daroca", "Vou. Alguém tem que olhar na cara dele."}, 2),
                            __arrL({"reeis", "Então olha por mim também. E traz biscoito de Conquista.", "friend"}, 3),
                            __arrL({"reeis", "...E traz ele de volta, tá? O trio é o trio. OOO REEEIS!", "friend"}, 3)
                        },
                        4
                    )
                },
                "id,quem,cena,x,quando,rotulo,falas"
            ),
            __ord(
                {
                    id = "caleb",
                    quem = "caleb",
                    cena = 0,
                    x = 2080,
                    quando = __arrL({"passaporte", "lucas"}, 2),
                    rotulo = "FALAR COM O CALEB",
                    falas = __arrL(
                        {
                            __arrL({"caleb", "Ouvi dizer que em Conquista faz frio de verdade."}, 2),
                            __arrL({"caleb", "Cuidado: músculo encolhe no frio. Faz flexão no avião."}, 2),
                            __arrL({"daroca", "Isso nem é verdade, Caleb."}, 2),
                            __arrL({"caleb", "Tudo é verdade se você acreditar com força."}, 2)
                        },
                        4
                    )
                },
                "id,quem,cena,x,quando,rotulo,falas"
            ),
            __ord(
                {
                    id = "mota",
                    quem = "mota",
                    cena = 0,
                    x = 2640,
                    quando = __arrL({"passaporte", "lucas"}, 2),
                    rotulo = "FALAR COM O MOTA",
                    falas = __arrL(
                        {
                            __arrL({"mota", "Vai viajar sem me chamar? Que feio, Da Roça."}, 2),
                            __arrL({"mota", "Pelo menos o dash você leva. Treinou comigo, então não tem desculpa."}, 2),
                            __arrL({"daroca", "O dash vai comigo pra onde eu for.", "friend"}, 3)
                        },
                        3
                    )
                },
                "id,quem,cena,x,quando,rotulo,falas"
            ),
            __ord(
                {
                    id = "kaua",
                    quem = "kaua",
                    cena = 0,
                    x = 3080,
                    quando = __arrL({"passaporte", "lucas"}, 2),
                    rotulo = "FALAR COM O KAUA",
                    falas = __arrL(
                        {
                            __arrL({"kaua", "Achei teu passaporte mais cedo. Botei em cima do feno pra galinha não comer."}, 2),
                            __arrL({"daroca", "Em cima do FENO?!"}, 2),
                            __arrL({"kaua", "Ué. Galinha não pula. Você pula."}, 2)
                        },
                        3
                    )
                },
                "id,quem,cena,x,quando,rotulo,falas"
            ),
            __ord(
                {
                    id = "lucas",
                    quem = "lucas",
                    cena = 0,
                    x = 4560,
                    quando = __arrL({"lucas"}, 1),
                    rotulo = "PEDIR CARONA PRO LUCAS",
                    fim = function() return __L1:caronaLucas() end,
                    falas = __arrL(
                        {
                            __arrL({"lucas", "Teu pai deixou eu te levar no carro a gás. Só até o aeroporto, hein!"}, 2),
                            __arrL({"daroca", "Ele deixou VOCÊ dirigir o carro dele?"}, 2),
                            __arrL({"lucas", "Deixou. Mais ou menos. Ele estava dormindo, mas eu acho que ele deixaria."}, 2),
                            __arrL({"daroca", "...Bora logo."}, 2)
                        },
                        4
                    )
                },
                "id,quem,cena,x,quando,rotulo,fim,falas"
            ),
            __ord(
                {
                    id = "miguel1",
                    quem = "miguel",
                    cena = 12,
                    x = 740,
                    quando = __arrL({"checkin"}, 1),
                    semFala = true
                },
                "id,quem,cena,x,quando,semFala"
            ),
            __ord(
                {
                    id = "miguel2",
                    quem = "miguel",
                    cena = 12,
                    x = 1420,
                    quando = __arrL({"raiox"}, 1),
                    semFala = true
                },
                "id,quem,cena,x,quando,semFala"
            ),
            __ord(
                {
                    id = "miguel3",
                    quem = "miguel",
                    cena = 12,
                    x = 1840,
                    quando = __arrL({"portao"}, 1),
                    semFala = true
                },
                "id,quem,cena,x,quando,semFala"
            ),
            __ord(
                {
                    id = "lurdes",
                    quem = "c2_lurdes",
                    cena = 13,
                    x = 1830,
                    quando = __arrL({"lurdes"}, 1),
                    rotulo = "FALAR COM A DONA LURDES",
                    fim = function() return __L1:tocar(
                        "c2_primeira_noite",
                        function()
                            __L1:irPara(25, 450)
                            __L1:passo("creuza")
                            __L1:salvar("JOGO SALVO · A CAMA DO QUARTO 4 SALVA E CURA")
                        end
                    ) end,
                    falas = nil
                },
                "id,quem,cena,x,quando,rotulo,fim,falas"
            )
        },
        9
    )
    __L1.ESTACOES = __arrL(
        {
            __ord(
                {
                    id = "checkin",
                    cena = 12,
                    x = 640,
                    quando = "checkin",
                    rotulo = "BALCÃO DE CHECK-IN",
                    botao = "CHECK-IN",
                    acao = function() return __L1:minijogo("checkin") end
                },
                "id,cena,x,quando,rotulo,botao,acao"
            ),
            __ord(
                {
                    id = "raiox",
                    cena = 12,
                    x = 1330,
                    quando = "raiox",
                    rotulo = "RAIO-X",
                    botao = "RAIO-X",
                    acao = function() return __L1:minijogo("raiox") end
                },
                "id,cena,x,quando,rotulo,botao,acao"
            ),
            __ord(
                {
                    id = "portao",
                    cena = 12,
                    x = 1760,
                    quando = "portao",
                    rotulo = "PORTÃO DE EMBARQUE",
                    botao = "EMBARCAR",
                    acao = function() return __L1:minijogo("portao") end
                },
                "id,cena,x,quando,rotulo,botao,acao"
            ),
            __ord(
                {
                    id = "cama",
                    cena = 25,
                    x = 624,
                    rotulo = "DORMIR (SALVA E CURA)",
                    botao = "DORMIR",
                    acao = function()
                        __L1.P.hp = if __t(__L1.P.max) then __L1.P.max else 100
                        __L1:salvar("JOGO SALVO · VIDA CHEIA")
                        __L1:sfx("sino")
                    end
                },
                "id,cena,x,rotulo,botao,acao"
            )
        },
        4
    )
    __L1.P = __ord({
        x = 700,
        y = __L1.FLOOR,
        vx = 0,
        vy = 0,
        ground = true,
        facing = 1,
        attack = 0,
        hp = 100
    }, "x,y,vx,vy,ground,facing,attack,hp")
    __L1.aberto = false
    __L1.cenaId = 0
    __L1.cam = 0
    __L1.t = 0
    __L1.last = 0
    __L1.raf = 0
    __L1.keys = __TS__New(Set)
    __L1.viagem = nil
    __L1.fade = 0
    __L1.perto = nil
    __L1.cut = nil
    __L1.pausado = false
    __L1.som = true
    __L1.joy = 0
    __L1.fpsMedio = 60
    __L1.box = nil
    __L1.cv = nil
    __L1.c = nil
    __L1.hud = nil
    __L1.objT = 0
    __L1.avisos = __arrL({}, 0)
    __L1.sfx = function(____, n)
        do
            pcall(function()
                local ____opt_901 = window.Roteiro
                if ____opt_901 ~= nil then
                    ____opt_901 = ____opt_901.sfx
                end
                if ____opt_901 ~= nil then
                    ____opt_901(____opt_901, n)
                end
            end)
        end
    end
    __L1.portais = function(____, id)
        local ____t_904 = __t
        local ____temp_903 = __L1:safe(
            function() return window.CampanhaAmbientes:portais(id) end,
            __arrL({}, 0)
        )
        __O[979] = ____temp_903
        return if ____t_904(____temp_903) then __O[979] else __arrL({}, 0)
    end
    __L1.D = function() return __L1:cenaDef(__L1.cenaId) end
    __L1.fase = nil
    __L1.tremor = 0
    __L1.clarao = 0
    __L1.claraoCor = "#ffffff"
    __L1.morto = false
    __L1.apiFase = __ord(
        {
            P = __L1.P,
            sfx = function(____, n) return __L1:sfx(n) end,
            tremer = function(____, n)
                __L1.tremor = math.max(__L1.tremor, n)
            end,
            flash = function(____, cor)
                __L1.clarao = 0.5
                __L1.claraoCor = if __t(cor) then cor else "#ffffff"
            end,
            ferir = function(____, n, de) return __L1:ferir(n, de) end,
            entrarArena = function()
                local f = __L1.fase
                __L1.S.flags.cp = {cena = __L1.cenaId, x = f.F.checkpoint}
                __L1:salvar()
                __L1:tocarDeslocado(
                    f.F.intro,
                    f.chefe.x,
                    f.chefe.tipo,
                    function() return __L1:lutaC1(f) end
                )
            end,
            vencer = function()
                local f = __L1.fase
                local slug = f.slug
                if __t(f.F.final) then
                    __L1:ganharXP(1200, "c2-chefe-jorge")
                    __L1:tocarDeslocado(
                        f.F.derrota,
                        f.chefe.x,
                        f.chefe.tipo,
                        function() return __L1:tocar(
                            "c2_creditos",
                            function()
                                __L1.S.flags.venceu_jorge = 1
                                __L1.S.flags.zerou = 1
                                __TS__Delete(__L1.S.flags, "cp")
                                __L1.fase = nil
                                __L1:passo("zerou")
                                __L1:salvar()
                                __L1:telaFim()
                            end
                        ) end
                    )
                    return
                end
                __L1:ganharXP(
                    600,
                    __add("c2-chefe-", slug)
                )
                __L1:tocarDeslocado(
                    f.F.derrota,
                    f.chefe.x,
                    f.chefe.tipo,
                    function()
                        local ____opt_907 = window.CampanhaTaxi
                        if ____opt_907 ~= nil then
                            ____opt_907 = ____opt_907.vencer
                        end
                        if ____opt_907 ~= nil then
                            ____opt_907(____opt_907, slug)
                        end
                        __set(
                            __L1.S.flags,
                            __add("venceu_", slug),
                            1
                        )
                        __TS__Delete(__L1.S.flags, "cp")
                        __L1.fase = nil
                        __L1:passo(__get(__L1.APOS_VITORIA, slug))
                        __L1:salvar("JOGO SALVO")
                    end
                )
            end
        },
        "P,sfx,tremer,flash,ferir,entrarArena,vencer"
    )
    __L1.dano = __arrL({}, 0)
    __L1.horaAtual = function()
        local ____opt_911 = window.DayTime
        if ____opt_911 ~= nil then
            ____opt_911 = ____opt_911.mode
        end
        local ____opt_result_913
        if ____opt_911 ~= nil then
            ____opt_result_913 = ____opt_911(____opt_911)
        end
        local m = ____opt_result_913
        if __t(if __t(m) then __get(__L1.HORAS, m) ~= nil else m) then
            return __get(__L1.HORAS, m)
        end
        local ____get_917 = __get
        local ____L1_PASSOS_916 = __L1.PASSOS
        local ____opt_914 = __L1.S
        if ____opt_914 ~= nil then
            ____opt_914 = ____opt_914.passo
        end
        local p = ____get_917(____L1_PASSOS_916, ____opt_914)
        if __t(__L1.cenaId == 25 or __L1.cenaId == 24) then
            local ____opt_918 = __L1.S
            if ____opt_918 ~= nil then
                ____opt_918 = ____opt_918.passo
            end
            return if ____opt_918 == "lurdes" then 21 else 8
        end
        local ____opt_result_922
        if p ~= nil then
            ____opt_result_922 = p.hora
        end
        local ____opt_result_922_923 = ____opt_result_922
        if ____opt_result_922_923 == nil then
            ____opt_result_922_923 = 12
        end
        return ____opt_result_922_923
    end
    __L1.FORA = __re("^(in-main-menu|is-paused|is-cutscene|is-dialog|is-chapter-ended|is-routing|is-training|is-activity|is-epilogue|is-ollyan-flight|campaign-layout-editing|is-room|is-arena|is-boss)$", "")
    __L1.cssC1 = false
    __L1.ultPoder = 0
    window:addEventListener(
        "resize",
        function()
            if __t(if __t(__L1.aberto) then __L1.box else __L1.aberto) then
                window:clearTimeout(window.__c2RecC1)
                window.__c2RecC1 = window:setTimeout(
                    function() return __L1:safe(__L1.controlesC1) end,
                    250
                )
            end
        end
    )
    __L1.coberto = function()
        local ____t_963 = __t
        local ____t_957 = __t
        local ____t_950 = __t
        local ____t_943 = __t
        local ____t_936 = __t
        local ____t_929 = __t
        local ____opt_926 = window.CampanhaOficina
        if ____opt_926 ~= nil then
            ____opt_926 = ____opt_926.aberta
        end
        local ____opt_result_928
        if ____opt_926 ~= nil then
            ____opt_result_928 = ____opt_926(____opt_926)
        end
        __O[1021] = ____opt_result_928
        local ____opt_932 = window.Fliperama
        if ____opt_932 ~= nil then
            ____opt_932 = ____opt_932.isOpen
        end
        local ____opt_result_934
        if ____opt_932 ~= nil then
            ____opt_result_934 = ____opt_932(____opt_932)
        end
        local ____temp_935 = if ____t_929(____opt_result_928) then __O[1021] else ____opt_result_934
        __O[1022] = ____temp_935
        local ____opt_939 = window.DarocaLook
        if ____opt_939 ~= nil then
            ____opt_939 = ____opt_939.isOpen
        end
        local ____opt_result_941
        if ____opt_939 ~= nil then
            ____opt_result_941 = ____opt_939(____opt_939)
        end
        local ____temp_942 = if ____t_936(____temp_935) then __O[1022] else ____opt_result_941
        __O[1023] = ____temp_942
        local ____opt_946 = window.CampanhaPoderes
        if ____opt_946 ~= nil then
            ____opt_946 = ____opt_946.muralAberto
        end
        local ____opt_result_948
        if ____opt_946 ~= nil then
            ____opt_result_948 = ____opt_946(____opt_946)
        end
        local ____temp_949 = if ____t_943(____temp_942) then __O[1023] else ____opt_result_948
        __O[1024] = ____temp_949
        local ____opt_953 = window.Mapa3D
        if ____opt_953 ~= nil then
            ____opt_953 = ____opt_953.aberto
        end
        local ____opt_result_955
        if ____opt_953 ~= nil then
            ____opt_result_955 = ____opt_953(____opt_953)
        end
        local ____temp_956 = if ____t_950(____temp_949) then __O[1024] else ____opt_result_955
        __O[1025] = ____temp_956
        local ____opt_960 = window.CampanhaLoja
        if ____opt_960 ~= nil then
            ____opt_960 = ____opt_960.aberta
        end
        local ____opt_result_962
        if ____opt_960 ~= nil then
            ____opt_result_962 = ____opt_960(____opt_960)
        end
        return not not ____t_963(if ____t_957(____temp_956) then __O[1025] else ____opt_result_962)
    end
    __L1.ocupado = function()
        local ____t_973 = __t
        local ____t_965 = __t
        local ____temp_964 = __L1:coberto()
        __O[1026] = ____temp_964
        local ____t_971 = __t
        local ____opt_968 = window.CampanhaMoradores
        if ____opt_968 ~= nil then
            ____opt_968 = ____opt_968.aberto
        end
        local ____opt_result_970
        if ____opt_968 ~= nil then
            ____opt_result_970 = ____opt_968(____opt_968)
        end
        local ____temp_972 = if ____t_965(____temp_964) then __O[1026] else not not ____t_971(____opt_result_970)
        __O[1027] = ____temp_972
        local ____t_976 = __t
        local ____opt_974 = __L1.box
        if ____opt_974 ~= nil then
            ____opt_974 = ____opt_974:querySelector(".escolha")
        end
        return if ____t_973(____temp_972) then __O[1027] else not not ____t_976(____opt_974)
    end
    __L1.TECLAS_PADRAO = __ord(
        {
            ArrowLeft = __arrL({"left"}, 1),
            KeyA = __arrL({"left"}, 1),
            ArrowRight = __arrL({"right"}, 1),
            KeyD = __arrL({"right"}, 1),
            Space = __arrL({"jump"}, 1),
            KeyW = __arrL({"jump"}, 1),
            ArrowUp = __arrL({"jump"}, 1),
            KeyJ = __arrL({"paper"}, 1),
            KeyK = __arrL({"fart"}, 1),
            KeyL = __arrL({"dash"}, 1),
            ShiftLeft = __arrL({"dash"}, 1),
            ShiftRight = __arrL({"dash"}, 1),
            KeyE = __arrL({"interact"}, 1),
            Enter = __arrL({"interact"}, 1),
            KeyU = __arrL({"poder1"}, 1),
            KeyI = __arrL({"poder2"}, 1)
        },
        "ArrowLeft,KeyA,ArrowRight,KeyD,Space,KeyW,ArrowUp,KeyJ,KeyK,KeyL,ShiftLeft,ShiftRight,KeyE,Enter,KeyU,KeyI"
    )
    __L1.DA_C1 = __ord({up = "jump", vehicle = "poder1", bivolt = "poder2"}, "up,vehicle,bivolt")
    __L1.USADAS = __TS__New(
        Set,
        __arrL({
            "left",
            "right",
            "jump",
            "paper",
            "fart",
            "dash",
            "interact",
            "poder1",
            "poder2"
        }, 9)
    )
    __L1.HORAS = __ord({manha = 8.2, tarde = 13.5, por = 17.7, noite = 22}, "manha,tarde,por,noite")
    __L1.emLuta = false
    __L1.SAVE1 = "da-roca-adventure-v1"
    __L1.save1 = function()
        do
            local function ____catch(e)
                return true, nil
            end
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                local ____self_979 = window.JSON
                local ____self_979_parse_980 = ____self_979.parse
                local ____t_978 = __t
                local ____temp_977 = window.localStorage:getItem(__L1.SAVE1)
                __O[1040] = ____temp_977
                return true, ____self_979_parse_980(____self_979, if ____t_978(____temp_977) then __O[1040] else "null")
            end)
            if not ____try then
                ____hasReturned, ____returnValue = ____catch(____hasReturned)
            end
            if ____hasReturned then
                return ____returnValue
            end
        end
    end
    __L1.tSalvarProg = 0
    __L1.xpTxt = __arrL({}, 0)
    __L1.vidaMax = function()
        local ____t_986 = __t
        local ____opt_983 = __L1:TR()
        if ____opt_983 ~= nil then
            ____opt_983 = ____opt_983.bonus
        end
        local ____opt_result_985
        if ____opt_983 ~= nil then
            ____opt_result_985 = ____opt_983(____opt_983).maxHP
        end
        __O[1043] = ____opt_result_985
        local ____temp_993 = if ____t_986(____opt_result_985) then __O[1043] else 100
        local ____t_992 = __t
        local ____opt_989 = window.CampanhaAliados
        if ____opt_989 ~= nil then
            ____opt_989 = ____opt_989.vidaMax
        end
        local ____opt_result_991
        if ____opt_989 ~= nil then
            ____opt_result_991 = ____opt_989(____opt_989)
        end
        __O[1044] = ____opt_result_991
        return math.floor(____temp_993 * (if ____t_992(____opt_result_991) then __O[1044] else 100 / 100) + 0.5)
    end
    window:addEventListener(
        "c2-atributo",
        function()
            if not __t(__L1.aberto) then
                return
            end
            local antes = if __t(__L1.P.max) then __L1.P.max else 100
            __L1.P.max = __L1:vidaMax()
            if __gt(__L1.P.max, antes) then
                __L1.P.hp = math.min(__L1.P.max, __L1.P.hp + (__L1.P.max - antes))
            end
            __L1:salvarProgressao()
        end
    )
    __L1.topo = nil
    __L1["pôr"] = function(____, id, v)
        local e = window.document:getElementById(id)
        if __t(if __t(e) then e.textContent ~= v else e) then
            e.textContent = v
        end
    end
    __L1.pan = nil
    __L1.preenche = false
    if window.document.readyState == "loading" then
        window.document:addEventListener("DOMContentLoaded", __L1.botaoMenu)
    else
        __L1:botaoMenu()
    end
    window.Campanha2 = __ord(
        {
            emLuta = function() return __L1.emLuta end,
            ganharXP = function(____, n, id, x, y) return __L1:ganharXP(n, id, x, y) end,
            aviso = function(____, txt) return __L1:aviso(txt) end,
            liberada = __L1.liberada,
            abrir = __L1.abrir,
            fechar = __L1.fechar,
            painel = __L1.painel,
            aberto = function() return __L1.aberto end,
            estado = function()
                local ____opt_994 = __L1.S
                if ____opt_994 ~= nil then
                    ____opt_994 = ____opt_994.passo
                end
                local ____L1_cenaId_1023 = __L1.cenaId
                local ____math_floor_result_1024 = math.floor(__L1.P.x + 0.5)
                local ____math_floor_result_1025 = math.floor(__L1.P.y + 0.5)
                local ____t_998 = __t
                local ____opt_996 = __L1.perto
                if ____opt_996 ~= nil then
                    ____opt_996 = ____opt_996.rotulo
                end
                __O[1065] = ____opt_996
                local ____temp_1026 = if ____t_998(____opt_996) then __O[1065] else nil
                local ____t_1001 = __t
                local ____opt_999 = __L1.cut
                if ____opt_999 ~= nil then
                    ____opt_999 = ____opt_999.id
                end
                __O[1066] = ____opt_999
                local ____temp_1027 = if ____t_1001(____opt_999) then __O[1066] else nil
                local ____t_1007 = __t
                local ____opt_1004 = __L1.fase
                if ____opt_1004 ~= nil then
                    ____opt_1004 = ____opt_1004.emArena
                end
                local ____opt_result_1006
                if ____opt_1004 ~= nil then
                    ____opt_result_1006 = ____opt_1004(____opt_1004)
                end
                local ____temp_1028 = if ____t_1007(____opt_result_1006) then __L1.fase.slug else nil
                local ____t_1017 = __t
                local ____t_1010 = __t
                local ____opt_1008 = __L1:D()
                if ____opt_1008 ~= nil then
                    ____opt_1008 = ____opt_1008.key
                end
                __O[1067] = ____opt_1008
                local ____callq_1015 = __callq
                local ____opt_1013 = window.CampanhaCenarios
                if ____opt_1013 ~= nil then
                    ____opt_1013 = ____opt_1013.lista
                end
                local ____opt_1011 = ____callq_1015(
                    ____opt_1013,
                    "find",
                    function(____, d) return d.id == __L1.cenaId end
                )
                if ____opt_1011 ~= nil then
                    ____opt_1011 = ____opt_1011.key
                end
                local ____temp_1016 = if ____t_1010(____opt_1008) then __O[1067] else ____opt_1011
                __O[1068] = ____temp_1016
                local ____temp_1029 = if ____t_1017(____temp_1016) then __O[1068] else nil
                local ____assign_1022 = __assign
                local ____temp_1021 = {}
                local ____t_1020 = __t
                local ____opt_1018 = __L1.S
                if ____opt_1018 ~= nil then
                    ____opt_1018 = ____opt_1018.flags
                end
                __O[1069] = ____opt_1018
                return {
                    passo = ____opt_994,
                    cena = ____L1_cenaId_1023,
                    x = ____math_floor_result_1024,
                    y = ____math_floor_result_1025,
                    perto = ____temp_1026,
                    cutscene = ____temp_1027,
                    luta = ____temp_1028,
                    chave = ____temp_1029,
                    flags = ____assign_1022(____temp_1021, if ____t_1020(____opt_1018) then __O[1069] else {})
                }
            end,
            _ir = function(____, id, x) return __L1:irPara(id, x) end,
            _fase = function() return if __t(__L1.fase) then {
                slug = __L1.fase.slug,
                chefe = {
                    st = __L1.fase.chefe.st,
                    hp = __L1.fase.chefe.hp,
                    fase = __L1.fase.chefe.fase,
                    x = math.floor(__L1.fase.chefe.x + 0.5)
                },
                arena = __L1.fase:emArena(),
                inimigos = __len(__L1.fase:inimigos())
            } else __L1.fase end,
            _hp = function(____, n)
                __L1.P.hp = n
            end,
            _bater = function(____, n)
                local f = __L1.fase
                local ____t_1033 = __t
                local ____opt_result_1032
                if f ~= nil then
                    ____opt_result_1032 = f.chefe
                end
                if ____t_1033(____opt_result_1032) then
                    f.chefe:onDano(n, "teste")
                end
            end,
            _pos = function(____, x, y)
                __L1.P.x = x
                __L1.P.y = y
                __L1.P.vy = 0
                __L1.P.ground = true
            end,
            _fps = function() return __L1.fpsMedio end,
            _passo = function(____, id) return __L1:passo(id) end,
            _usar = __L1.usar,
            _pular = __L1.pularCut
        },
        "emLuta,ganharXP,aviso,liberada,abrir,fechar,painel,aberto,estado,_ir,_fase,_hp,_bater,_pos,_fps,_passo,_usar,_pular"
    )
end)(nil)
return ____exports
