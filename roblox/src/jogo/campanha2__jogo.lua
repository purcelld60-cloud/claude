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
        local ____t_3 = __t
        local ____t_result_2
        local ____t_1 = __t
        local ____re_test_result_0 = __re_test(
            __re("[?&]campanha2\\b", ""),
            window.location.search
        )
        __O[980] = ____re_test_result_0
        if ____t_1(____re_test_result_0) then
            ____t_result_2 = __O[980]
        else
            ____t_result_2 = window.DAROCA_DEV
        end
        if ____t_3(____t_result_2) then
            return true
        end
        local ____t_result_17
        local ____t_16 = __t
        local ____temp_15 = __L1:safe(
            function()
                local ____t_14 = __t
                local ____self_11 = window.JSON
                local ____self_11_parse_12 = ____self_11.parse
                local ____t_result_10
                local ____t_9 = __t
                local ____temp_8 = window.localStorage:getItem("da-roca-adventure-v1")
                __O[981] = ____temp_8
                if ____t_9(____temp_8) then
                    ____t_result_10 = __O[981]
                else
                    ____t_result_10 = "null"
                end
                local ____opt_6 = ____self_11_parse_12(____self_11, ____t_result_10)
                if ____opt_6 ~= nil then
                    ____opt_6 = ____opt_6.q
                end
                local ____opt_result_13
                if ____opt_6 ~= nil then
                    ____opt_result_13 = ____opt_6.jorgeSeen
                end
                return not not ____t_14(____opt_result_13)
            end,
            false
        )
        __O[982] = ____temp_15
        if ____t_16(____temp_15) then
            ____t_result_17 = __O[982]
        else
            ____t_result_17 = __L1:safe(
                function() return window.localStorage:getItem("daroca-sandbox-v1") == "1" end,
                false
            )
        end
        return ____t_result_17
    end
    __L1.carregar = function(self)
        local d = __L1:safe(
            function()
                local ____self_21 = window.JSON
                local ____self_21_parse_22 = ____self_21.parse
                local ____t_result_20
                local ____t_19 = __t
                local ____temp_18 = window.localStorage:getItem(__L1.KEY)
                __O[984] = ____temp_18
                if ____t_19(____temp_18) then
                    ____t_result_20 = __O[984]
                else
                    ____t_result_20 = "null"
                end
                return ____self_21_parse_22(____self_21, ____t_result_20)
            end,
            nil
        )
        local ____t_28 = __t
        local ____t_result_27
        local ____t_26 = __t
        local ____t_result_25
        local ____t_24 = __t
        local ____temp_23 = not __t(d) or type(d) ~= "table"
        __O[985] = ____temp_23
        if ____t_24(____temp_23) then
            ____t_result_25 = __O[985]
        else
            ____t_result_25 = d.v ~= 1
        end
        __O[986] = ____t_result_25
        if ____t_26(____t_result_25) then
            ____t_result_27 = __O[986]
        else
            ____t_result_27 = not __t(d.passo)
        end
        if ____t_28(____t_result_27) then
            return nil
        end
        local ____t_result_33
        local ____t_32 = __t
        local ____t_result_31
        local ____t_30 = __t
        local ____t_result_29
        if __t(d.flags) then
            ____t_result_29 = type(d.flags) == "table"
        else
            ____t_result_29 = d.flags
        end
        __O[987] = ____t_result_29
        if ____t_30(____t_result_29) then
            ____t_result_31 = not __isArray(d.flags)
        else
            ____t_result_31 = __O[987]
        end
        if ____t_32(____t_result_31) then
            ____t_result_33 = __assign({}, d.flags)
        else
            ____t_result_33 = {}
        end
        local flags = ____t_result_33
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
            local ____t_result_37
            if __t(flags.zerou) then
                ____t_result_37 = "zerou"
            else
                local ____t_result_36
                local ____t_35 = __t
                local ____call_result_34 = __call(
                    ordem,
                    "find",
                    function(____, v) return not __t(__get(
                        flags,
                        __add("venceu_", v)
                    )) end
                )
                __O[988] = ____call_result_34
                if ____t_35(____call_result_34) then
                    ____t_result_36 = __O[988]
                else
                    ____t_result_36 = "zerou"
                end
                ____t_result_37 = ____t_result_36
            end
            S2.passo = ____t_result_37
            if not __t(__get(__L1.PASSOS, S2.passo)) then
                S2.passo = "creuza"
            end
            __TS__Delete(S2, "cena")
            __TS__Delete(S2, "x")
        end
        local ____t_result_48
        local ____t_39 = __t
        local ____isInteger_result_38 = __isInteger(S2.cena)
        __O[991] = ____isInteger_result_38
        if ____t_39(____isInteger_result_38) then
            local ____t_result_47
            local ____t_41 = __t
            local ____temp_40 = __ge(S2.cena, 0) and __le(S2.cena, 11)
            __O[990] = ____temp_40
            if ____t_41(____temp_40) then
                ____t_result_47 = __O[990]
            else
                local ____call_46 = __call
                local ____t_result_45
                local ____t_44 = __t
                local ____opt_42 = window.CampanhaCenarios
                if ____opt_42 ~= nil then
                    ____opt_42 = ____opt_42.lista
                end
                __O[989] = ____opt_42
                if ____t_44(____opt_42) then
                    ____t_result_45 = __O[989]
                else
                    ____t_result_45 = __arrL({}, 0)
                end
                ____t_result_47 = ____call_46(
                    ____t_result_45,
                    "some",
                    function(____, q) return q.id == S2.cena end
                )
            end
            ____t_result_48 = ____t_result_47
        else
            ____t_result_48 = __O[991]
        end
        local cenaOk = ____t_result_48
        if not __t(cenaOk) then
            __TS__Delete(S2, "cena")
            __TS__Delete(S2, "x")
        end
        if __t(S2.x ~= nil and not __isFiniteN(S2.x)) then
            __TS__Delete(S2, "x")
        end
        local ____t_result_49
        if __t(__isFiniteN(__TS__Number(S2.hp)) and __TS__Number(S2.hp) > 0) then
            ____t_result_49 = math.min(
                9999,
                __TS__Number(S2.hp)
            )
        else
            ____t_result_49 = 100
        end
        S2.hp = ____t_result_49
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
            local ____t_result_52
            local ____t_51 = __t
            local ____call_result_50 = __call(
                __L1:CC().lista,
                "find",
                function(____, d) return d.id == id end
            )
            __O[993] = ____call_result_50
            if ____t_51(____call_result_50) then
                ____t_result_52 = __O[993]
            else
                ____t_result_52 = __get(
                    __L1:CC().lista,
                    0
                )
            end
            return ____t_result_52
        end
        local ____t_result_58
        local ____t_57 = __t
        local ____getq_55 = __getq
        local ____opt_53 = window.WorldData
        if ____opt_53 ~= nil then
            ____opt_53 = ____opt_53.widths
        end
        local ____TS__Number_result_56 = __TS__Number(____getq_55(____opt_53, id))
        __O[994] = ____TS__Number_result_56
        if ____t_57(____TS__Number_result_56) then
            ____t_result_58 = __O[994]
        else
            ____t_result_58 = 4800
        end
        local w = ____t_result_58
        local ____id_65 = id
        local ____t_result_61
        local ____t_60 = __t
        local ____get_result_59 = __get(
            __L1:NOMES_C1(),
            id
        )
        __O[995] = ____get_result_59
        if ____t_60(____get_result_59) then
            ____t_result_61 = __O[995]
        else
            ____t_result_61 = "Itabuna"
        end
        local ____arrL_result_66 = __arrL({}, 0)
        local ____t_result_64
        local ____t_63 = __t
        local ____get_result_62 = __get(__L1.EXTRA_PLAT, id)
        __O[996] = ____get_result_62
        if ____t_63(____get_result_62) then
            ____t_result_64 = __O[996]
        else
            ____t_result_64 = __arrL({}, 0)
        end
        return {
            id = ____id_65,
            nome = ____t_result_61,
            largura = w,
            vaos = ____arrL_result_66,
            plataformas = ____t_result_64,
            limites = __arrL({40, w - 40}, 2),
            itabuna = true
        }
    end
    __L1.passo = function(self, id)
        __L1.S.passo = id
        local p = __get(__L1.PASSOS, id)
        local ____t_70 = __t
        local ____opt_result_69
        if p ~= nil then
            ____opt_result_69 = p.obj
        end
        if ____t_70(____opt_result_69) then
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
        local ____t_78 = __t
        local ____t_result_77
        local ____t_76 = __t
        local ____t_result_75
        local ____t_72 = __t
        local ____t_result_71
        if __t(__L1.morto) then
            ____t_result_71 = __L1.morto
        else
            ____t_result_71 = __L1.cut
        end
        __O[998] = ____t_result_71
        if ____t_72(____t_result_71) then
            ____t_result_75 = __O[998]
        else
            local ____gt_74 = __gt
            local ____t_result_73
            if __t(__L1.P.inv) then
                ____t_result_73 = __L1.P.inv
            else
                ____t_result_73 = 0
            end
            ____t_result_75 = ____gt_74(____t_result_73, 0)
        end
        __O[999] = ____t_result_75
        if ____t_76(____t_result_75) then
            ____t_result_77 = __O[999]
        else
            ____t_result_77 = __L1.viagem
        end
        if ____t_78(____t_result_77) then
            return
        end
        local ____temp_86 = n * 1.5
        local ____t_result_85
        local ____t_84 = __t
        local ____opt_81 = window.Difficulty
        if ____opt_81 ~= nil then
            ____opt_81 = ____opt_81.getSettings
        end
        local ____opt_result_83
        if ____opt_81 ~= nil then
            ____opt_result_83 = ____opt_81(____opt_81).incomingDamage
        end
        __O[1000] = ____opt_result_83
        if ____t_84(____opt_result_83) then
            ____t_result_85 = __O[1000]
        else
            ____t_result_85 = 1
        end
        n = math.floor(____temp_86 * ____t_result_85 + 0.5)
        local ____opt_89 = window.CampanhaPoderes
        if ____opt_89 ~= nil then
            ____opt_89 = ____opt_89.filtrarDano
        end
        local ____opt_result_91
        if ____opt_89 ~= nil then
            ____opt_result_91 = ____opt_89(____opt_89, n)
        end
        local ____opt_result_91_92 = ____opt_result_91
        if ____opt_result_91_92 == nil then
            ____opt_result_91_92 = n
        end
        n = ____opt_result_91_92
        if not __t(n) then
            __L1:sfx("plim")
            return
        end
        __L1.P.hp = math.max(0, __L1.P.hp - n)
        __L1.P.inv = 0.85
        __L1.P.vy = -280
        __L1.P.ground = false
        local ____L1_P_93, ____x_94 = __L1.P, "x"
        ____L1_P_93[____x_94] = ____L1_P_93[____x_94] + (__lt(__L1.P.x, de) and -1 or 1) * 36
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
                local ____opt_95 = el:querySelector("button")
                return ____opt_95 and ____opt_95:focus()
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
                local ____opt_97 = e.target:closest("button")
                if ____opt_97 ~= nil then
                    ____opt_97 = ____opt_97.dataset.a
                end
                local a = ____opt_97
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
                local ____opt_99 = el:querySelector("button")
                return ____opt_99 and ____opt_99:focus()
            end,
            30
        )
    end
    __L1.voltarDoDesmaio = function(self)
        __L1.morto = false
        local ____L1_P_102 = __L1.P
        local ____t_result_101
        if __t(__L1.P.max) then
            ____t_result_101 = __L1.P.max
        else
            ____t_result_101 = 100
        end
        ____L1_P_102.hp = ____t_result_101
        __L1.P.inv = 1.5
        local ____opt_103 = __L1.fase
        if ____opt_103 ~= nil then
            ____opt_103:reiniciar()
        end
        local cp = __L1.S.flags.cp
        if __t(cp) then
            __L1:irPara(cp.cena, cp.x)
        else
            local ____L1_irPara_112 = __L1.irPara
            local ____L1_cenaId_111 = __L1.cenaId
            local ____t_result_110
            local ____t_109 = __t
            local ____t_result_108
            local ____t_107 = __t
            local ____opt_105 = __get(__L1.PASSOS, __L1.S.passo)
            if ____opt_105 ~= nil then
                ____opt_105 = ____opt_105.fase
            end
            __O[1001] = ____opt_105
            if ____t_107(____opt_105) then
                ____t_result_108 = __L1.fase
            else
                ____t_result_108 = __O[1001]
            end
            if ____t_109(____t_result_108) then
                ____t_result_110 = __L1.fase.F.checkpoint - 400
            else
                ____t_result_110 = __L1.P.x
            end
            ____L1_irPara_112(__L1, ____L1_cenaId_111, ____t_result_110)
        end
        __L1:salvar()
    end
    __L1.faseAtual = function(self)
        local ____get_118 = __get
        local ____L1_PASSOS_117 = __L1.PASSOS
        local ____opt_115 = __L1.S
        if ____opt_115 ~= nil then
            ____opt_115 = ____opt_115.passo
        end
        local ____opt_113 = ____get_118(____L1_PASSOS_117, ____opt_115)
        if ____opt_113 ~= nil then
            ____opt_113 = ____opt_113.fase
        end
        local slug = ____opt_113
        local ____t_result_122
        if __t(slug) then
            local ____getq_121 = __getq
            local ____opt_119 = window.CampanhaFases
            if ____opt_119 ~= nil then
                ____opt_119 = ____opt_119.FASES
            end
            ____t_result_122 = ____getq_121(____opt_119, slug)
        else
            ____t_result_122 = slug
        end
        local F = ____t_result_122
        local ____t_126 = __t
        local ____t_result_125
        local ____t_124 = __t
        local ____temp_123 = not __t(F) or F.cena ~= __L1.cenaId
        __O[1002] = ____temp_123
        if ____t_124(____temp_123) then
            ____t_result_125 = __O[1002]
        else
            ____t_result_125 = __get(
                __L1.S.flags,
                __add("venceu_", slug)
            )
        end
        if ____t_126(____t_result_125) then
            local ____t_128 = __t
            local ____t_result_127
            if __t(__L1.fase) then
                ____t_result_127 = not __t(F) or F.cena ~= __L1.cenaId
            else
                ____t_result_127 = __L1.fase
            end
            if ____t_128(____t_result_127) then
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
        local ____t_132 = __t
        local ____opt_result_131
        if sc ~= nil then
            ____opt_result_131 = sc.raw
        end
        if not ____t_132(____opt_result_131) then
            if depois ~= nil then
                depois(nil)
            end
            return
        end
        local raw = window.JSON:parse(window.JSON:stringify(sc.raw))
        local ref = nil
        for ____, c0 in __iterar((raw.cenas)) do
            do
                if __t(c0.fundo) then
                    continue
                end
                local ____call_139 = __call
                local ____t_result_135
                if __t(c0.atores) then
                    ____t_result_135 = c0.atores
                else
                    ____t_result_135 = __arrL({}, 0)
                end
                local a = ____call_139(
                    ____t_result_135,
                    "find",
                    function(____, q)
                        local ____t_result_138
                        local ____t_137 = __t
                        local ____temp_136 = q.quem == tipo
                        __O[1003] = ____temp_136
                        if ____t_137(____temp_136) then
                            ____t_result_138 = __O[1003]
                        else
                            ____t_result_138 = tipo == "c2_ryan" and q.quem == "c2_ryan"
                        end
                        return ____t_result_138
                    end
                )
                if __t(a) then
                    ref = a.x
                    break
                end
            end
        end
        local dx = ref == nil and 0 or math.floor(xChefe - ref + 0.5)
        for ____, c0 in __iterar((raw.cenas)) do
            do
                if __t(c0.fundo) then
                    continue
                end
                if __t(c0.camera) then
                    for ____, k in __iterar((__arrL({"de", "para"}, 2))) do
                        if __t(__get(c0.camera, k)) then
                            local ____get_result_140, ____x_141 = __get(c0.camera, k), "x"
                            ____get_result_140[____x_141] = ____get_result_140[____x_141] + dx
                        end
                    end
                end
                local ____iter_143 = __iter
                local ____t_result_142
                if __t(c0.atores) then
                    ____t_result_142 = c0.atores
                else
                    ____t_result_142 = __arrL({}, 0)
                end
                for ____, a in __TS__Iterator(____iter_143(____t_result_142)) do
                    a.x = a.x + dx
                    if a.ate ~= nil then
                        a.ate = a.ate + dx
                    end
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
        local ____t_149 = __t
        local ____opt_result_148
        if sc ~= nil then
            ____opt_result_148 = sc.raw
        end
        if not ____t_149(____opt_result_148) then
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
            local ____t_154 = __t
            local ____temp_153 = not __t(__L1.cut.s.done)
            if ____temp_153 then
                local ____n_152 = n
                n = ____n_152 + 1
                ____temp_153 = ____n_152 < 999
            end
            if not ____t_154(____temp_153) then
                break
            end
            __L1:RT():advance(__L1.cut.s)
        end
    end
    __L1.conversa = function(self, npc)
        local fx = __lt(__L1.P.x, npc.x) and 1 or -1
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
                            local ____assign_158 = __assign
                            local ____temp_156 = {}
                            local ____temp_157 = {quem = q, texto = txt}
                            local ____t_result_155
                            if __t(e) then
                                ____t_result_155 = {emocao = e}
                            else
                                ____t_result_155 = {}
                            end
                            return ____assign_158(____temp_156, ____temp_157, ____t_result_155)
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
                local ____this_160
                ____this_160 = npc
                local ____opt_159 = ____this_160.fim
                if ____opt_159 ~= nil then
                    ____opt_159(____this_160)
                end
                __L1:salvar()
            end
        )
    end
    __L1.irPara = function(self, id, x)
        __L1.cenaId = id
        local d = __L1:D()
        local ____L1_P_165 = __L1.P
        local ____L1_clamp_164 = __L1.clamp
        local ____x_163 = x
        local ____getq_result_161 = __getq(d.limites, 0)
        if ____getq_result_161 == nil then
            ____getq_result_161 = 40
        end
        local ____getq_result_162 = __getq(d.limites, 1)
        if ____getq_result_162 == nil then
            ____getq_result_162 = d.largura - 40
        end
        ____L1_P_165.x = ____L1_clamp_164(__L1, ____x_163, ____getq_result_161, ____getq_result_162)
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
        local ____t_result_167
        if __t(__L1.S) then
            local ____id_166 = id
            __L1.S.cena = ____id_166
            ____t_result_167 = ____id_166
        else
            ____t_result_167 = __L1.S
        end
    end
    __L1.usar = function(self)
        local ____t_173 = __t
        local ____t_result_172
        local ____t_171 = __t
        local ____t_result_170
        local ____t_169 = __t
        local ____t_result_168
        if __t(__L1.viagem) then
            ____t_result_168 = __L1.viagem
        else
            ____t_result_168 = not __t(__L1.perto)
        end
        __O[1004] = ____t_result_168
        if ____t_169(____t_result_168) then
            ____t_result_170 = __O[1004]
        else
            ____t_result_170 = __L1.cut
        end
        __O[1005] = ____t_result_170
        if ____t_171(____t_result_170) then
            ____t_result_172 = __O[1005]
        else
            ____t_result_172 = __L1.pausado
        end
        if ____t_173(____t_result_172) then
            return
        end
        local p = __L1.perto
        __call(__L1.keys, "clear")
        if p.tipo == "npc" then
            if __t(p.npc.falas) then
                __L1:conversa(p.npc)
            else
                local ____this_175
                ____this_175 = p.npc
                local ____opt_174 = ____this_175.fim
                if ____opt_174 ~= nil then
                    ____opt_174(____this_175)
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
                local ____opt_178 = window.CampanhaLoja
                if ____opt_178 ~= nil then
                    ____opt_178 = ____opt_178.abrir
                end
                if ____opt_178 ~= nil then
                    ____opt_178(____opt_178, {})
                end
            else
                local ____opt_188 = window.CampanhaTaxi
                if ____opt_188 ~= nil then
                    ____opt_188 = ____opt_188.abrir
                end
                if ____opt_188 ~= nil then
                    local ____L1_cenaId_185 = __L1.cenaId
                    local function ____temp_186(____, cena, x)
                        __L1:irPara(cena, x + 120)
                        if __t(__L1.S.passo == "taxi1" and cena == 13) then
                            __L1:passo("lurdes")
                        else
                            local ____opt_181 = __get(__L1.PASSOS, __L1.S.passo)
                            if ____opt_181 ~= nil then
                                ____opt_181 = ____opt_181.ir
                            end
                            if ____opt_181 == cena then
                                __L1:passo(__get(__L1.PASSOS, __L1.S.passo).prox)
                            end
                        end
                        __L1:salvar()
                    end
                    local ____temp_184
                    if __L1.S.passo == "taxi1" then
                        ____temp_184 = function(____, L)
                            local ____temp_183
                            if L.id == "t13" then
                                ____temp_183 = {ok = true}
                            else
                                ____temp_183 = {ok = false, motivo = "Primeiro, a pensão. Você nem tem onde dormir!"}
                            end
                            return ____temp_183
                        end
                    else
                        ____temp_184 = nil
                    end
                    ____opt_188(____opt_188, ____L1_cenaId_185, ____temp_186, {liberado = ____temp_184})
                end
            end
            return
        end
        if p.tipo == "poderes" then
            local ____opt_192 = window.CampanhaPoderes
            if ____opt_192 ~= nil then
                ____opt_192 = ____opt_192.abrirMural
            end
            if ____opt_192 ~= nil then
                ____opt_192(____opt_192, {})
            end
            return
        end
        if p.tipo == "conversa" then
            local ____opt_196 = window.CampanhaMoradores
            if ____opt_196 ~= nil then
                ____opt_196 = ____opt_196.conversar
            end
            if ____opt_196 ~= nil then
                ____opt_196(____opt_196, p.id)
            end
            return
        end
        if p.tipo == "armario" then
            local ____opt_200 = window.DarocaLook
            if ____opt_200 ~= nil then
                ____opt_200 = ____opt_200.open
            end
            if ____opt_200 ~= nil then
                ____opt_200(____opt_200, {title = "ARMÁRIO DO QUARTO 4", line = "Escolha a roupa do Da Roça para hoje."})
            end
            return
        end
        if p.tipo == "pc" then
            local ____opt_204 = window.Fliperama
            if ____opt_204 ~= nil then
                ____opt_204 = ____opt_204.open
            end
            if ____opt_204 ~= nil then
                ____opt_204(____opt_204, nil, {from = "quarto"})
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
        local ____t_207 = __t
        local ____t_result_206
        if __t(__L1.viagem) then
            ____t_result_206 = __L1.viagem
        else
            ____t_result_206 = not __t(__L1.P.ground)
        end
        if ____t_207(____t_result_206) then
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
            local ____t_213 = __t
            local ____t_result_212
            local ____t_211 = __t
            local ____t_result_210
            local ____t_209 = __t
            local ____temp_208 = n.cena == d.id
            __O[1006] = ____temp_208
            if ____t_209(____temp_208) then
                ____t_result_210 = __call(n.quando, "includes", __L1.S.passo)
            else
                ____t_result_210 = __O[1006]
            end
            __O[1007] = ____t_result_210
            if ____t_211(____t_result_210) then
                ____t_result_212 = not __t(n.semFala)
            else
                ____t_result_212 = __O[1007]
            end
            if ____t_213(____t_result_212) then
                local ____call_223 = __call
                local ____n_x_222 = n.x
                local ____add_221 = __add
                local ____n_rotulo_220 = n.rotulo
                local ____t_219 = __t
                local ____t_result_218
                local ____t_217 = __t
                local ____t_result_216
                local ____t_215 = __t
                local ____get_result_214 = __get(
                    __L1.S.flags,
                    __add("falou_", n.id)
                )
                __O[1008] = ____get_result_214
                if ____t_215(____get_result_214) then
                    ____t_result_216 = n.id ~= "lucas"
                else
                    ____t_result_216 = __O[1008]
                end
                __O[1009] = ____t_result_216
                if ____t_217(____t_result_216) then
                    ____t_result_218 = n.id ~= "lurdes"
                else
                    ____t_result_218 = __O[1009]
                end
                ____call_223(
                    cand,
                    "push",
                    {
                        tipo = "npc",
                        npc = n,
                        x = ____n_x_222,
                        rotulo = ____add_221(
                            ____n_rotulo_220,
                            ____t_219(____t_result_218) and " ✓" or ""
                        ),
                        botao = "FALAR"
                    }
                )
            end
        end
        for ____, e in __iterar((__L1.ESTACOES)) do
            local ____t_227 = __t
            local ____t_result_226
            local ____t_225 = __t
            local ____temp_224 = e.cena == d.id
            __O[1010] = ____temp_224
            if ____t_225(____temp_224) then
                ____t_result_226 = not __t(e.quando) or e.quando == __L1.S.passo
            else
                ____t_result_226 = __O[1010]
            end
            if ____t_227(____t_result_226) then
                __call(cand, "push", {
                    tipo = "estacao",
                    est = e,
                    x = e.x,
                    rotulo = e.rotulo,
                    botao = e.botao
                })
            end
        end
        local ____t_231 = __t
        local ____t_result_230
        local ____t_229 = __t
        local ____temp_228 = d.id == 0 and __L1.S.passo == "passaporte"
        __O[1011] = ____temp_228
        if ____t_229(____temp_228) then
            ____t_result_230 = __L1.P.y < __L1.FLOOR - 100
        else
            ____t_result_230 = __O[1011]
        end
        if ____t_231(____t_result_230) then
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
            local ____opt_234 = window.CampanhaMoradores
            if ____opt_234 ~= nil then
                ____opt_234 = ____opt_234.perto
            end
            local ____opt_result_236
            if ____opt_234 ~= nil then
                ____opt_result_236 = ____opt_234(____opt_234, d.id, __L1.P.x)
            end
            local m = ____opt_result_236
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
                local ____opt_result_241
                if X ~= nil then
                    ____opt_result_241 = X.perto
                end
                local ____opt_result_242
                if ____opt_result_241 ~= nil then
                    ____opt_result_242 = ____opt_result_241(X, d.id, __L1.P.x)
                end
                local e = ____opt_result_242
                if __t(e) then
                    __call(
                        cand,
                        "push",
                        __assign({}, {tipo = "extra"}, e)
                    )
                end
            end
        end
        local ____iter_250 = __iter
        local ____t_result_249
        local ____t_248 = __t
        local ____opt_245 = window.CampanhaAliados
        if ____opt_245 ~= nil then
            ____opt_245 = ____opt_245.candidatos
        end
        local ____opt_result_247
        if ____opt_245 ~= nil then
            ____opt_result_247 = ____opt_245(____opt_245, d.id)
        end
        __O[1012] = ____opt_result_247
        if ____t_248(____opt_result_247) then
            ____t_result_249 = __O[1012]
        else
            ____t_result_249 = __arrL({}, 0)
        end
        for ____, a in __TS__Iterator(____iter_250(____t_result_249)) do
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
        local ____opt_251 = __L1.fase
        if ____opt_251 ~= nil then
            ____opt_251 = ____opt_251.luta
        end
        local duelo = ____opt_251
        local percurso = window.ConquistaCombate:terreno(duelo)
        if __t(percurso) then
            percurso:avancar(duelo, dt, __L1.P)
        end
        local d = __L1:D()
        local ____t_result_255
        local ____t_254 = __t
        local ____temp_253 = (__t(__call(__L1.keys, "has", "right")) and 1 or 0) - (__t(__call(__L1.keys, "has", "left")) and 1 or 0)
        __O[1013] = ____temp_253
        if ____t_254(____temp_253) then
            ____t_result_255 = __O[1013]
        else
            ____t_result_255 = __TS__MathSign(math.floor(__L1.joy * 2 + 0.5))
        end
        local dir = ____t_result_255
        if __t(dir) then
            __L1.P.facing = dir
        end
        local ____t_261 = __t
        local ____opt_258 = __L1:TR()
        if ____opt_258 ~= nil then
            ____opt_258 = ____opt_258.dashing
        end
        local ____opt_result_260
        if ____opt_258 ~= nil then
            ____opt_result_260 = ____opt_258(____opt_258)
        end
        if not ____t_261(____opt_result_260) then
            local ____t_result_268
            local ____t_267 = __t
            local ____opt_264 = __L1:TR()
            if ____opt_264 ~= nil then
                ____opt_264 = ____opt_264.bonus
            end
            local ____opt_result_266
            if ____opt_264 ~= nil then
                ____opt_result_266 = ____opt_264(____opt_264).moveSpeed
            end
            __O[1014] = ____opt_result_266
            if ____t_267(____opt_result_266) then
                ____t_result_268 = __O[1014]
            else
                ____t_result_268 = 280
            end
            local ____temp_276 = dir * ____t_result_268
            local ____t_result_275
            local ____t_274 = __t
            local ____opt_271 = __L1:TR()
            if ____opt_271 ~= nil then
                ____opt_271 = ____opt_271.velocidade
            end
            local ____opt_result_273
            if ____opt_271 ~= nil then
                ____opt_result_273 = ____opt_271(____opt_271)
            end
            __O[1015] = ____opt_result_273
            if ____t_274(____opt_result_273) then
                ____t_result_275 = __O[1015]
            else
                ____t_result_275 = 1
            end
            local ____temp_279 = ____temp_276 * ____t_result_275
            local ____gt_278 = __gt
            local ____t_result_277
            if __t(__L1.P.atordoado) then
                ____t_result_277 = __L1.P.atordoado
            else
                ____t_result_277 = 0
            end
            local ____temp_287 = ____temp_279 * (____gt_278(____t_result_277, 0) and 0.4 or 1)
            local ____t_result_286
            local ____t_285 = __t
            local ____opt_282 = window.CampanhaAliados
            if ____opt_282 ~= nil then
                ____opt_282 = ____opt_282.velocidade
            end
            local ____opt_result_284
            if ____opt_282 ~= nil then
                ____opt_result_284 = ____opt_282(____opt_282)
            end
            __O[1016] = ____opt_result_284
            if ____t_285(____opt_result_284) then
                ____t_result_286 = __O[1016]
            else
                ____t_result_286 = 1
            end
            local alvo = ____temp_287 * ____t_result_286
            local ____t_result_288
            if __t(dir) then
                ____t_result_288 = __t(__L1.P.ground) and 1800 or 1150
            else
                ____t_result_288 = __t(__L1.P.ground) and 2200 or 950
            end
            local ac = ____t_result_288
            local ____L1_P_289, ____vx_290 = __L1.P, "vx"
            ____L1_P_289[____vx_290] = ____L1_P_289[____vx_290] + __L1:clamp(alvo - __L1.P.vx, -ac * dt, ac * dt)
            if math.abs(__L1.P.vx) < 0.1 then
                __L1.P.vx = 0
            end
        end
        local ____L1_P_292 = __L1.P
        local ____t_result_291
        if __t(__L1.P.anim) then
            ____t_result_291 = __L1.P.anim
        else
            ____t_result_291 = 0
        end
        ____L1_P_292.anim = ____t_result_291 + math.abs(__L1.P.vx) * dt / 18.3
        local ____t_result_293
        if __t(d.limites) then
            ____t_result_293 = d.limites
        else
            ____t_result_293 = __arrL({40, d.largura - 40}, 2)
        end
        local lim = ____t_result_293
        __L1.P.x = __L1:clamp(
            __L1.P.x + __L1.P.vx * dt,
            __get(lim, 0),
            __get(lim, 1)
        )
        local prevY = __L1.P.y
        local chao0 = __L1.P.ground
        __L1.P.vy = math.min(900, __L1.P.vy + 850 * dt)
        local ____L1_P_294, ____y_295 = __L1.P, "y"
        ____L1_P_294[____y_295] = ____L1_P_294[____y_295] + __L1.P.vy * dt
        __L1.P.ground = false
        if __L1.P.y < 95 then
            __L1.P.y = 95
            __L1.P.vy = math.max(0, __L1.P.vy)
        end
        if __t(percurso) then
            percurso:pousar(duelo, __L1.P, prevY, __L1.ferir)
            local ____t_299 = __t
            local ____t_result_298
            local ____t_297 = __t
            local ____temp_296 = not __t(chao0)
            __O[1017] = ____temp_296
            if ____t_297(____temp_296) then
                ____t_result_298 = __L1.P.ground
            else
                ____t_result_298 = __O[1017]
            end
            if ____t_299(____t_result_298) then
                __L1.P.landTimer = 0.15
            end
            local ____L1_P_301 = __L1.P
            local ____t_result_300
            if __t(__L1.P.landTimer) then
                ____t_result_300 = __L1.P.landTimer
            else
                ____t_result_300 = 0
            end
            ____L1_P_301.landTimer = math.max(0, ____t_result_300 - dt)
            return
        end
        if __L1.P.y > __L1.FLOOR + 2 then
            local ____iter_307 = __iter
            local ____t_result_306
            if __t(d.vaos) then
                ____t_result_306 = d.vaos
            else
                ____t_result_306 = __arrL({}, 0)
            end
            for ____, ____value in __TS__Iterator(____iter_307(____t_result_306)) do
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
                    local ____t_305 = __t
                    local ____t_result_304
                    local ____t_303 = __t
                    local ____temp_302 = math.abs(__L1.P.vx) > 0
                    __O[1018] = ____temp_302
                    if ____t_303(____temp_302) then
                        ____t_result_304 = __L1.P.x == gx + 11 or __L1.P.x == __add(gx, gw) - 11
                    else
                        ____t_result_304 = __O[1018]
                    end
                    if ____t_305(____t_result_304) then
                        __L1.P.vx = 0
                    end
                end
            end
        end
        local ____call_309 = __call
        local ____t_result_308
        if __t(d.vaos) then
            ____t_result_308 = d.vaos
        else
            ____t_result_308 = __arrL({}, 0)
        end
        local overGap = ____call_309(
            ____t_result_308,
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
            local ____t_313 = __t
            local ____t_result_312
            local ____t_311 = __t
            local ____temp_310 = r.tipo == "rampa" and __ge(__L1.P.x, r.x0)
            __O[1019] = ____temp_310
            if ____t_311(____temp_310) then
                ____t_result_312 = __le(__L1.P.x, r.x1)
            else
                ____t_result_312 = __O[1019]
            end
            if ____t_313(____t_result_312) then
                local ry = r.y0 + (r.y1 - r.y0) * (__L1.P.x - r.x0) / (r.x1 - r.x0)
                local ____t_317 = __t
                local ____t_result_316
                local ____t_315 = __t
                local ____temp_314 = __L1.P.vy >= 0 and __L1.P.y >= ry - 14
                __O[1020] = ____temp_314
                if ____t_315(____temp_314) then
                    ____t_result_316 = __le(prevY, ry + 40)
                else
                    ____t_result_316 = __O[1020]
                end
                if ____t_317(____t_result_316) then
                    __L1.P.y = ry
                    __L1.P.vy = 0
                    __L1.P.ground = true
                end
                local ____t_323 = __t
                local ____t_result_322
                local ____t_321 = __t
                local ____t_result_320
                local ____t_319 = __t
                local ____temp_318 = __L1.P.x >= r.x1 - 4
                __O[1021] = ____temp_318
                if ____t_319(____temp_318) then
                    ____t_result_320 = __L1.P.ground
                else
                    ____t_result_320 = __O[1021]
                end
                __O[1022] = ____t_result_320
                if ____t_321(____t_result_320) then
                    ____t_result_322 = dir > 0
                else
                    ____t_result_322 = __O[1022]
                end
                if ____t_323(____t_result_322) then
                    __L1.viagem = {tipo = "porta", t = 0, para = r.para}
                end
            end
        end
        if __t(__L1.P.vy >= 0 and not __t(__L1.P.ground)) then
            local ____iter_331 = __iter
            local ____t_result_330
            if __t(d.plataformas) then
                ____t_result_330 = d.plataformas
            else
                ____t_result_330 = __arrL({}, 0)
            end
            for ____, ____value in __TS__Iterator(____iter_331(____t_result_330)) do
                local px = ____value[1]
                local py = ____value[2]
                local pw = ____value[3]
                local ____t_329 = __t
                local ____t_result_328
                local ____t_327 = __t
                local ____t_result_326
                local ____t_325 = __t
                local ____temp_324 = __L1.P.x > px - 6 and __lt(
                    __L1.P.x,
                    __add(px, pw) + 6
                )
                __O[1023] = ____temp_324
                if ____t_325(____temp_324) then
                    ____t_result_326 = __le(prevY, py + 2)
                else
                    ____t_result_326 = __O[1023]
                end
                __O[1024] = ____t_result_326
                if ____t_327(____t_result_326) then
                    ____t_result_328 = __ge(__L1.P.y, py)
                else
                    ____t_result_328 = __O[1024]
                end
                if ____t_329(____t_result_328) then
                    __L1.P.y = py
                    __L1.P.vy = 0
                    __L1.P.ground = true
                end
            end
            local ____t_335 = __t
            local ____t_result_334
            local ____t_333 = __t
            local ____temp_332 = not __t(__L1.P.ground) and not __t(overGap)
            __O[1025] = ____temp_332
            if ____t_333(____temp_332) then
                ____t_result_334 = __L1.P.y >= __L1.FLOOR
            else
                ____t_result_334 = __O[1025]
            end
            if ____t_335(____t_result_334) then
                __L1.P.y = __L1.FLOOR
                __L1.P.vy = 0
                __L1.P.ground = true
            end
        end
        local ____t_339 = __t
        local ____t_result_338
        local ____t_337 = __t
        local ____temp_336 = not __t(chao0)
        __O[1026] = ____temp_336
        if ____t_337(____temp_336) then
            ____t_result_338 = __L1.P.ground
        else
            ____t_result_338 = __O[1026]
        end
        if ____t_339(____t_result_338) then
            __L1.P.landTimer = 0.15
        end
        local ____L1_P_341 = __L1.P
        local ____t_result_340
        if __t(__L1.P.landTimer) then
            ____t_result_340 = __L1.P.landTimer
        else
            ____t_result_340 = 0
        end
        ____L1_P_341.landTimer = math.max(0, ____t_result_340 - dt)
        local ____t_345 = __t
        local ____t_result_344
        local ____t_343 = __t
        local ____t_result_342
        if __t(__L1.P.ground) then
            ____t_result_342 = not __t(overGap)
        else
            ____t_result_342 = __L1.P.ground
        end
        __O[1027] = ____t_result_342
        if ____t_343(____t_result_342) then
            ____t_result_344 = __L1.P.y >= __L1.FLOOR - 1
        else
            ____t_result_344 = __O[1027]
        end
        if ____t_345(____t_result_344) then
            __L1.P.seguroX = __L1.P.x
        end
        if __L1.P.y > 600 then
            local ____call_347 = __call
            local ____t_result_346
            if __t(d.vaos) then
                ____t_result_346 = d.vaos
            else
                ____t_result_346 = __arrL({}, 0)
            end
            local g = ____call_347(
                ____t_result_346,
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
            local ____L1_P_seguroX_348 = __L1.P.seguroX
            if ____L1_P_seguroX_348 == nil then
                ____L1_P_seguroX_348 = __L1.P.x - 260
            end
            local sx = ____L1_P_seguroX_348
            local ____L1_P_351 = __L1.P
            local ____t_result_350
            if __t(g) then
                local ____le_result_349
                if __le(
                    sx,
                    __get(g, 0) + __get(g, 1) / 2
                ) then
                    ____le_result_349 = __get(g, 0) - 40
                else
                    ____le_result_349 = __add(
                        __get(g, 0),
                        __get(g, 1)
                    ) + 40
                end
                ____t_result_350 = ____le_result_349
            else
                ____t_result_350 = sx
            end
            ____L1_P_351.x = ____t_result_350
            __L1.P.x = __L1:clamp(
                __L1.P.x,
                __get(lim, 0),
                __get(lim, 1)
            )
            __L1.P.y = __L1.FLOOR
            __L1.P.vy = 0
            __L1.P.vx = 0
            __L1.P.ground = true
            local ____L1_P_353 = __L1.P
            local ____t_result_352
            if __t(__L1.P.inv) then
                ____t_result_352 = __L1.P.inv
            else
                ____t_result_352 = 0
            end
            ____L1_P_353.inv = math.max(____t_result_352, 1)
            __L1.P.hp = math.max(1, __L1.P.hp - 10)
            __L1:aviso("Ai! Cuidado com o buraco.")
        end
    end
    __L1.andarViagem = function(self, dt)
        local v = __L1.viagem
        v.t = __add(v.t, dt)
        if v.tipo == "rolante" then
            local u = math.min(1, v.t / v.dur)
            local k = u < 0.15 and 0 or (u - 0.15) / 0.85
            local ____L1_P_355 = __L1.P
            local ____temp_354
            if k <= 0 then
                ____temp_354 = __get(v.de, 0) + (__get(v.ini, 0) - __get(v.de, 0)) * (u / 0.15)
            else
                ____temp_354 = __get(v.ini, 0) + (__get(v.fim, 0) - __get(v.ini, 0)) * k
            end
            ____L1_P_355.x = ____temp_354
            local ____L1_P_357 = __L1.P
            local ____temp_356
            if k <= 0 then
                ____temp_356 = __L1.FLOOR
            else
                ____temp_356 = __get(v.ini, 1) + (__get(v.fim, 1) - __get(v.ini, 1)) * k
            end
            ____L1_P_357.y = ____temp_356
            __L1.P.facing = __gt(
                __get(v.fim, 0),
                __get(v.ini, 0)
            ) and 1 or -1
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
        local ____t_361 = __t
        local ____t_result_360
        local ____t_359 = __t
        local ____t_result_358
        if __t(__L1.P.ground) then
            ____t_result_358 = not __t(__L1.viagem)
        else
            ____t_result_358 = __L1.P.ground
        end
        __O[1028] = ____t_result_358
        if ____t_359(____t_result_358) then
            ____t_result_360 = not __t(__L1.cut)
        else
            ____t_result_360 = __O[1028]
        end
        if ____t_361(____t_result_360) then
            local ____L1_P_368 = __L1.P
            local ____t_367 = __t
            local ____opt_364 = __L1.fase
            if ____opt_364 ~= nil then
                ____opt_364 = ____opt_364.luta
            end
            local ____opt_result_366
            if ____opt_364 ~= nil then
                ____opt_result_366 = ____opt_364.estrada
            end
            ____L1_P_368.vy = ____t_367(____opt_result_366) and -405 or -365
            __L1.P.ground = false
            local ____opt_371 = __L1:TR()
            if ____opt_371 ~= nil then
                ____opt_371 = ____opt_371.som
            end
            if ____opt_371 ~= nil then
                ____opt_371(____opt_371, 320, 0.06, "triangle")
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
            local ____t_376 = __t
            local ____t_result_375
            local ____t_374 = __t
            local ____temp_373 = n.cena == d.id
            __O[1029] = ____temp_373
            if ____t_374(____temp_373) then
                ____t_result_375 = __call(n.quando, "includes", __L1.S.passo)
            else
                ____t_result_375 = __O[1029]
            end
            if ____t_376(____t_result_375) then
                __L1:safe(function() return window.Art:drawCharacter(
                    __L1.c,
                    n.quem,
                    n.x,
                    __L1.FLOOR,
                    {frame = __L1.t, facing = __L1.P.x < n.x and -1 or 1, grounded = true, cache = true}
                ) end)
            end
        end
        local ____t_380 = __t
        local ____t_result_379
        local ____t_378 = __t
        local ____temp_377 = d.id == 12
        __O[1030] = ____temp_377
        if ____t_378(____temp_377) then
            ____t_result_379 = __call(
                __arrL({"checkin", "raiox", "portao"}, 3),
                "includes",
                __L1.S.passo
            )
        else
            ____t_result_379 = __O[1030]
        end
        if ____t_380(____t_result_379) then
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
        local ____t_384 = __t
        local ____t_result_383
        local ____t_382 = __t
        local ____temp_381 = not __t(p)
        __O[1031] = ____temp_381
        if ____t_382(____temp_381) then
            ____t_result_383 = __O[1031]
        else
            ____t_result_383 = __L1.cut
        end
        if ____t_384(____t_result_383) then
            return
        end
        local ____temp_385
        if p.cena == __L1.cenaId then
            ____temp_385 = p.alvo
        else
            ____temp_385 = __getq(p.via, __L1.cenaId)
        end
        local alvo = ____temp_385
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
            local dir = sx < 0 and -1 or 1
            local x = dir < 0 and 24 or __L1.W - 24
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
                do
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
                    local ____iter_391 = __iter
                    local ____t_result_390
                    if __t(rules) then
                        ____t_result_390 = rules
                    else
                        ____t_result_390 = __arrL({}, 0)
                    end
                    for ____, r in __TS__Iterator(____iter_391(____t_result_390)) do
                        do
                            local sel = r.selectorText
                            local ____t_389 = __t
                            local ____t_result_388
                            local ____t_387 = __t
                            local ____temp_386 = not __t(sel) or not __re_test(
                                __re("move-joystick|joystick-knob|joystick-directions", ""),
                                sel
                            )
                            __O[1032] = ____temp_386
                            if ____t_387(____temp_386) then
                                ____t_result_388 = __O[1032]
                            else
                                ____t_result_388 = __re_test(
                                    __re("arena|\\.is-|immersive|engaged-off", ""),
                                    sel
                                )
                            end
                            if ____t_389(____t_result_388) then
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
                local ____t_397 = __t
                local ____t_result_396
                local ____t_393 = __t
                local ____temp_392 = not __t(__L1.cut) or e.target == __L1.cv
                __O[1033] = ____temp_392
                if ____t_393(____temp_392) then
                    ____t_result_396 = __O[1033]
                else
                    local ____this_395
                    ____this_395 = e.target
                    local ____opt_394 = ____this_395.closest
                    if ____opt_394 ~= nil then
                        ____opt_394 = ____opt_394(____this_395, "button, .escolha, .pausa, input, a")
                    end
                    ____t_result_396 = ____opt_394
                end
                if ____t_397(____t_result_396) then
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
        local ____opt_400 = __L1:TR()
        if ____opt_400 ~= nil then
            ____opt_400 = ____opt_400.montarBarra
        end
        if ____opt_400 ~= nil then
            ____opt_400(
                ____opt_400,
                __L1.box:querySelector(".tela"),
                __L1.acionarBotao
            )
        end
        window:addEventListener("keydown", __L1.teclaDown, true)
        window:addEventListener("keyup", __L1.teclaUp, true)
    end
    __L1.ligarJoy = function(self, pad)
        local ____t_405 = __t
        local ____t_result_404
        local ____t_403 = __t
        local ____temp_402 = not __t(pad)
        __O[1034] = ____temp_402
        if ____t_403(____temp_402) then
            ____t_result_404 = __O[1034]
        else
            ____t_result_404 = pad.dataset.c2Ligado
        end
        if ____t_405(____t_result_404) then
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
            local ____temp_406
            if math.abs(x) > 0.25 then
                ____temp_406 = x
            else
                ____temp_406 = 0
            end
            __L1.joy = ____temp_406
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
        local ____t_410 = __t
        local ____t_result_409
        local ____t_408 = __t
        local ____temp_407 = id == "interact"
        __O[1035] = ____temp_407
        if ____t_408(____temp_407) then
            ____t_result_409 = down
        else
            ____t_result_409 = __O[1035]
        end
        if ____t_410(____t_result_409) then
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
                local ____t_result_415
                local ____t_414 = __t
                local ____t_result_413
                local ____t_412 = __t
                local ____call_result_411 = __call(r.selectorText, "includes", "#gameShell")
                __O[1036] = ____call_result_411
                if ____t_412(____call_result_411) then
                    ____t_result_413 = rel:test(r.selectorText)
                else
                    ____t_result_413 = __O[1036]
                end
                if ____t_414(____t_result_413) then
                    ____t_result_415 = __add(
                        __re_replace(
                            r.cssText,
                            __re("#gameShell", "g"),
                            "#c2GameShell"
                        ),
                        "\n"
                    )
                else
                    ____t_result_415 = ""
                end
                return ____t_result_415
            end
            local ____t_417 = __t
            local ____t_result_416
            if __t(r.cssRules) then
                ____t_result_416 = r.media
            else
                ____t_result_416 = r.cssRules
            end
            if ____t_417(____t_result_416) then
                local i = ""
                for ____, q in __iterar((r.cssRules)) do
                    i = __add(
                        i,
                        conv(nil, q)
                    )
                end
                local ____t_result_418
                if __t(i) then
                    ____t_result_418 = ((("@media " .. tostring(r.media.mediaText)) .. "{") .. i) .. "}\n"
                else
                    ____t_result_418 = ""
                end
                return ____t_result_418
            end
            local ____t_420 = __t
            local ____t_result_419
            if __t(r.cssRules) then
                ____t_result_419 = r.conditionText ~= nil
            else
                ____t_result_419 = r.cssRules
            end
            if ____t_420(____t_result_419) then
                local i = ""
                for ____, q in __iterar((r.cssRules)) do
                    i = __add(
                        i,
                        conv(nil, q)
                    )
                end
                local ____t_result_421
                if __t(i) then
                    ____t_result_421 = ((("@supports " .. tostring(r.conditionText)) .. "{") .. i) .. "}\n"
                else
                    ____t_result_421 = ""
                end
                return ____t_result_421
            end
            return ""
        end
        local txt = ""
        for ____, sh in __iterar((window.document.styleSheets)) do
            do
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
                local ____iter_423 = __iter
                local ____t_result_422
                if __t(rules) then
                    ____t_result_422 = rules
                else
                    ____t_result_422 = __arrL({}, 0)
                end
                for ____, r in __TS__Iterator(____iter_423(____t_result_422)) do
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
        local ____opt_424 = __L1.box:querySelector(".c2-c1-shell")
        if ____opt_424 ~= nil then
            ____opt_424:remove()
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
            do
                local o = cl:querySelector(("[data-action=\"" .. tostring(de)) .. "\"]")
                local p = cl:querySelector(("[data-action=\"" .. tostring(para)) .. "\"]")
                if __t(not __t(o) or not __t(p)) then
                    continue
                end
                local ____p_setAttribute_431 = p.setAttribute
                local ____t_result_430
                local ____t_429 = __t
                local ____temp_428 = o:getAttribute("style")
                __O[1037] = ____temp_428
                if ____t_429(____temp_428) then
                    ____t_result_430 = __O[1037]
                else
                    ____t_result_430 = ""
                end
                ____p_setAttribute_431(p, "style", ____t_result_430)
                __call(p.classList, "add", "campaign-layout-target")
                if __t(o.dataset.campaignLayout) then
                    p.dataset.campaignLayout = o.dataset.campaignLayout
                end
                o.parentNode:insertBefore(p, o)
            end
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
            local ____opt_434 = window.CampanhaBotoes
            if ____opt_434 ~= nil then
                ____opt_434 = ____opt_434.aplicar
            end
            local ____opt_result_436
            if ____opt_434 ~= nil then
                ____opt_result_436 = ____opt_434(____opt_434, tela)
            end
            return ____opt_result_436
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
        local ____opt_437 = __L1.box
        if ____opt_437 ~= nil then
            ____opt_437 = ____opt_437:querySelector(".c2-c1-shell")
        end
        local w = ____opt_437
        if not __t(w) then
            return
        end
        for ____, i in __iterar((__arrL({1, 2}, 2))) do
            do
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
        end
        local dv = w:querySelector("[data-c1-id=\"dashValue\"]")
        if __t(dv) then
            local ____t_result_445
            local ____t_444 = __t
            local ____opt_441 = __L1:TR()
            if ____opt_441 ~= nil then
                ____opt_441 = ____opt_441.dashFalta
            end
            local ____opt_result_443
            if ____opt_441 ~= nil then
                ____opt_result_443 = ____opt_441(____opt_441)
            end
            __O[1038] = ____opt_result_443
            if ____t_444(____opt_result_443) then
                ____t_result_445 = __O[1038]
            else
                ____t_result_445 = 0
            end
            local f = ____t_result_445
            local ____gt_result_446
            if __gt(f, 0.05) then
                ____gt_result_446 = __add(
                    __call(
                        __call(f, "toFixed", 1),
                        "replace",
                        ".",
                        ","
                    ),
                    "s"
                )
            else
                ____gt_result_446 = "PRONTO"
            end
            local txt = ____gt_result_446
            if dv.textContent ~= txt then
                dv.textContent = txt
            end
        end
    end
    __L1.teclaDown = function(self, e)
        local ____t_464 = __t
        local ____t_result_463
        local ____t_457 = __t
        local ____t_result_456
        local ____t_450 = __t
        local ____t_result_449
        local ____t_448 = __t
        local ____temp_447 = not __t(__L1.aberto)
        __O[1046] = ____temp_447
        if ____t_448(____temp_447) then
            ____t_result_449 = __O[1046]
        else
            ____t_result_449 = __L1:coberto()
        end
        __O[1047] = ____t_result_449
        if ____t_450(____t_result_449) then
            ____t_result_456 = __O[1047]
        else
            local ____opt_453 = window.CampanhaMoradores
            if ____opt_453 ~= nil then
                ____opt_453 = ____opt_453.aberto
            end
            local ____opt_result_455
            if ____opt_453 ~= nil then
                ____opt_result_455 = ____opt_453(____opt_453)
            end
            ____t_result_456 = ____opt_result_455
        end
        __O[1048] = ____t_result_456
        if ____t_457(____t_result_456) then
            ____t_result_463 = __O[1048]
        else
            local ____opt_460 = window.CampanhaAliados
            if ____opt_460 ~= nil then
                ____opt_460 = ____opt_460.ocupado
            end
            local ____opt_result_462
            if ____opt_460 ~= nil then
                ____opt_result_462 = ____opt_460(____opt_460)
            end
            ____t_result_463 = ____opt_result_462
        end
        if ____t_464(____t_result_463) then
            return
        end
        local k = e.code
        if __t(__L1.box:querySelector(".escolha")) then
            if __re_test(
                __re("^Digit[1-3]$", ""),
                k
            ) then
                local ____opt_465 = __get(
                    __L1.box:querySelectorAll(".escolha .ops button"),
                    __TS__Number(__call(k, "slice", 5)) - 1
                )
                if ____opt_465 ~= nil then
                    ____opt_465:click()
                end
            end
            e:stopImmediatePropagation()
            return
        end
        if __t(__L1.cut) then
            local ____t_470 = __t
            local ____t_result_469
            local ____t_468 = __t
            local ____call_result_467 = __call(
                __arrL({"Space", "Enter", "KeyE", "ArrowRight"}, 4),
                "includes",
                k
            )
            __O[1049] = ____call_result_467
            if ____t_468(____call_result_467) then
                ____t_result_469 = not __t(e["repeat"])
            else
                ____t_result_469 = __O[1049]
            end
            if ____t_470(____t_result_469) then
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
            do
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
                    local ____opt_473 = __L1:TR()
                    if ____opt_473 ~= nil then
                        ____opt_473 = ____opt_473.acao
                    end
                    if ____opt_473 ~= nil then
                        ____opt_473(____opt_473, "jump", true, __L1.P)
                    end
                elseif a == "interact" then
                    __L1:usar()
                else
                    local ____opt_477 = __L1:TR()
                    if ____opt_477 ~= nil then
                        ____opt_477 = ____opt_477.acao
                    end
                    if ____opt_477 ~= nil then
                        ____opt_477(____opt_477, a, true, __L1.P)
                    end
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
                local ____t_result_485
                local ____t_484 = __t
                local ____opt_481 = window.ControlSettings
                if ____opt_481 ~= nil then
                    ____opt_481 = ____opt_481.getActionsForCode
                end
                local ____opt_result_483
                if ____opt_481 ~= nil then
                    ____opt_result_483 = ____opt_481(____opt_481, k)
                end
                __O[1050] = ____opt_result_483
                if ____t_484(____opt_result_483) then
                    ____t_result_485 = __O[1050]
                else
                    ____t_result_485 = __arrL({}, 0)
                end
                a = ____t_result_485
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
                    local ____t_result_488
                    local ____t_487 = __t
                    local ____get_result_486 = __get(__L1.DA_C1, x)
                    __O[1051] = ____get_result_486
                    if ____t_487(____get_result_486) then
                        ____t_result_488 = __O[1051]
                    else
                        ____t_result_488 = x
                    end
                    return ____t_result_488
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
            local ____t_result_491
            local ____t_490 = __t
            local ____get_result_489 = __get(__L1.TECLAS_PADRAO, k)
            __O[1052] = ____get_result_489
            if ____t_490(____get_result_489) then
                ____t_result_491 = __O[1052]
            else
                ____t_result_491 = __arrL({}, 0)
            end
            a = ____t_result_491
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
                local ____opt_494 = __L1:TR()
                if ____opt_494 ~= nil then
                    ____opt_494 = ____opt_494.acao
                end
                if ____opt_494 ~= nil then
                    ____opt_494(____opt_494, "jump", false, __L1.P)
                end
            else
                local ____t_501 = __t
                local ____t_result_500
                local ____t_499 = __t
                local ____t_result_498
                local ____t_497 = __t
                local ____temp_496 = a == "paper" or a == "fart"
                __O[1053] = ____temp_496
                if ____t_497(____temp_496) then
                    ____t_result_498 = __O[1053]
                else
                    ____t_result_498 = a == "poder1"
                end
                __O[1054] = ____t_result_498
                if ____t_499(____t_result_498) then
                    ____t_result_500 = __O[1054]
                else
                    ____t_result_500 = a == "poder2"
                end
                if ____t_501(____t_result_500) then
                    local ____opt_504 = __L1:TR()
                    if ____opt_504 ~= nil then
                        ____opt_504 = ____opt_504.acao
                    end
                    if ____opt_504 ~= nil then
                        ____opt_504(____opt_504, a, false, __L1.P)
                    end
                end
            end
        end
    end
    __L1.hudVisivel = function(self, v)
        if __t(__L1.hud) then
            __L1.hud.style.visibility = __t(v) and "visible" or "hidden"
        end
        local ____opt_506 = __L1.box
        if ____opt_506 ~= nil then
            ____opt_506 = ____opt_506:querySelector(".c2-treino-wrap")
        end
        local bar = ____opt_506
        if __t(bar) then
            bar.style.visibility = __t(v) and "visible" or "hidden"
        end
        __L1.box:querySelector(".pular").hidden = v
    end
    __L1.objetivoNovo = function(self, txt)
        local ____opt_508 = __L1.box
        if ____opt_508 ~= nil then
            ____opt_508 = ____opt_508:querySelector(".obj")
        end
        local o = ____opt_508
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
        local ____opt_510 = __L1.box
        if ____opt_510 ~= nil then
            ____opt_510 = ____opt_510:querySelector(".avisos")
        end
        local a = ____opt_510
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
                            local ____t_513 = __t
                            local ____t_result_512
                            if __t(o.r) then
                                ____t_result_512 = not __t(semResposta)
                            else
                                ____t_result_512 = o.r
                            end
                            if ____t_513(____t_result_512) then
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
                        local ____temp_515 = el:querySelector(".resp")
                        local ____t_result_514
                        if __t(o.r) then
                            ____t_result_514 = o.r
                        else
                            ____t_result_514 = "Não..."
                        end
                        ____temp_515.textContent = ____t_result_514
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
                local ____opt_516 = list:querySelector("button")
                return ____opt_516 and ____opt_516:focus()
            end,
            50
        )
    end
    __L1.pausar = function(self, v)
        __L1.pausado = v
        __call(__L1.keys, "clear")
        local ____opt_518 = __L1.box:querySelector(".pausa")
        if ____opt_518 ~= nil then
            ____opt_518:remove()
        end
        if not __t(v) then
            return
        end
        local el = window.document:createElement("div")
        el.className = "pausa"
        el.innerHTML = ("<h2>PAUSA</h2><button type=\"button\" data-a=\"voltar\">▶ CONTINUAR</button><button type=\"button\" data-a=\"opcoes\">⚙ OPÇÕES</button><button type=\"button\" data-a=\"missoes\">📜 MISSÕES</button><button type=\"button\" data-a=\"som\">♪ SOM: " .. (__t(__L1.som) and "LIGADO" or "DESLIGADO")) .. "</button><button type=\"button\" data-a=\"sair\">SALVAR E SAIR</button><p>A/D ou setas andam · ESPAÇO pula (segure no ar para voar) · E fala e entra · J papel · K peido · L dash · U/I poderes · ESC pausa</p>"
        el:addEventListener(
            "click",
            function(____, e)
                local ____opt_520 = e.target:closest("button")
                if ____opt_520 ~= nil then
                    ____opt_520 = ____opt_520.dataset.a
                end
                local a = ____opt_520
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
                local ____opt_522 = el:querySelector("button")
                return ____opt_522 and ____opt_522:focus()
            end,
            30
        )
    end
    __L1.opcoes = function(self)
        local ____opt_524 = __L1.box:querySelector(".pausa")
        if ____opt_524 ~= nil then
            ____opt_524:remove()
        end
        local el = window.document:createElement("div")
        el.className = "pausa"
        local DT = window.DayTime
        local WX = window.Weather
        local GX = window.Graphics
        local function linhas()
            local ____t_result_526
            if __t(DT) then
                ____t_result_526 = ("<button type=\"button\" data-o=\"hora\">HORA DO DIA: <span class=\"val\">" .. tostring(DT:mode() == "auto" and "DA HISTÓRIA" or DT:label())) .. "</span></button>"
            else
                ____t_result_526 = ""
            end
            local ____t_result_527
            if __t(WX) then
                ____t_result_527 = ("<button type=\"button\" data-o=\"clima\">CLIMA: <span class=\"val\">" .. tostring(WX:label())) .. "</span></button>"
            else
                ____t_result_527 = ""
            end
            local ____t_result_528
            if __t(GX) then
                ____t_result_528 = ("<button type=\"button\" data-o=\"qualidade\">QUALIDADE: <span class=\"val\">" .. tostring(GX:label())) .. "</span></button>"
            else
                ____t_result_528 = ""
            end
            local ____temp_540
            local ____opt_result_531
            if DT ~= nil then
                ____opt_result_531 = DT:mode()
            end
            if ____opt_result_531 == "auto" then
                ____temp_540 = "Hora do dia: segue a história."
            else
                local ____add_539 = __add
                local ____add_538 = __add
                local ____opt_result_536
                if DT ~= nil then
                    ____opt_result_536 = DT.label
                end
                local ____opt_result_537
                if ____opt_result_536 ~= nil then
                    ____opt_result_537 = ____opt_result_536(DT)
                end
                ____temp_540 = ____add_539(
                    ____add_538("Hora do dia fixa: ", ____opt_result_537),
                    "."
                )
            end
            local ____t_result_541
            if __t(WX) then
                ____t_result_541 = __add(
                    "Clima: ",
                    WX:describe()
                )
            else
                ____t_result_541 = ""
            end
            local ____t_result_542
            if __t(GX) then
                ____t_result_542 = __add(
                    "Qualidade: ",
                    GX:describe()
                )
            else
                ____t_result_542 = ""
            end
            return ((((((((((("<h2>OPÇÕES</h2>\n      " .. ____t_result_526) .. "\n      ") .. ____t_result_527) .. "\n      ") .. ____t_result_528) .. "\n      <button type=\"button\" data-o=\"botoes\">MUDAR BOTÕES DE LUGAR</button>\n      <button type=\"button\" data-o=\"voltar\">◀ VOLTAR</button>\n      <p>") .. tostring(____temp_540)) .. " ") .. tostring(____t_result_541)) .. "<br>") .. tostring(____t_result_542)) .. "</p>"
        end
        local function desenhar(____, foco)
            el.innerHTML = linhas(nil)
            window:setTimeout(
                function()
                    local ____t_result_547
                    local ____t_546 = __t
                    local ____temp_545 = el:querySelector(("[data-o=\"" .. tostring(foco)) .. "\"]")
                    __O[1055] = ____temp_545
                    if ____t_546(____temp_545) then
                        ____t_result_547 = __O[1055]
                    else
                        ____t_result_547 = el:querySelector("button")
                    end
                    local ____opt_result_548
                    if ____t_result_547 ~= nil then
                        ____opt_result_548 = ____t_result_547:focus()
                    end
                    return ____opt_result_548
                end,
                20
            )
        end
        el:addEventListener(
            "click",
            function(____, e)
                local ____opt_549 = e.target:closest("button")
                if ____opt_549 ~= nil then
                    ____opt_549 = ____opt_549.dataset.o
                end
                local o = ____opt_549
                if not __t(o) then
                    return
                end
                if o == "voltar" then
                    __L1:pausar(true)
                    return
                end
                if o == "hora" then
                    local ____opt_result_555
                    if DT ~= nil then
                        ____opt_result_555 = DT.next
                    end
                    if ____opt_result_555 ~= nil then
                        ____opt_result_555(DT)
                    end
                end
                if o == "clima" then
                    local ____opt_result_560
                    if WX ~= nil then
                        ____opt_result_560 = WX.next
                    end
                    if ____opt_result_560 ~= nil then
                        ____opt_result_560(WX)
                    end
                end
                if o == "qualidade" then
                    local ____opt_result_565
                    if GX ~= nil then
                        ____opt_result_565 = GX.toggle
                    end
                    if ____opt_result_565 ~= nil then
                        ____opt_result_565(GX)
                    end
                end
                if o == "botoes" then
                    el.hidden = true
                    __L1:hudVisivel(true)
                    local ____opt_568 = window.CampanhaBotoes
                    if ____opt_568 ~= nil then
                        ____opt_568 = ____opt_568.editar
                    end
                    if ____opt_568 ~= nil then
                        ____opt_568(
                            ____opt_568,
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
        local ____opt_570 = __L1.box:querySelector(".pausa")
        if ____opt_570 ~= nil then
            ____opt_570:remove()
        end
        local el = window.document:createElement("div")
        el.className = "pausa"
        local ____t_result_578
        local ____t_577 = __t
        local ____opt_574 = window.CampanhaAliados
        if ____opt_574 ~= nil then
            ____opt_574 = ____opt_574.missoes
        end
        local ____opt_result_576
        if ____opt_574 ~= nil then
            ____opt_result_576 = ____opt_574(____opt_574)
        end
        __O[1056] = ____opt_result_576
        if ____t_577(____opt_result_576) then
            ____t_result_578 = __O[1056]
        else
            ____t_result_578 = __arrL({}, 0)
        end
        local L = ____t_result_578
        local ic = {feita = "✔", ativa = "▶", nova = "!"}
        local ____t_result_582
        local ____t_581 = __t
        local ____opt_579 = __get(__L1.PASSOS, __L1.S.passo)
        if ____opt_579 ~= nil then
            ____opt_579 = ____opt_579.obj
        end
        __O[1057] = ____opt_579
        if ____t_581(____opt_579) then
            ____t_result_582 = __O[1057]
        else
            ____t_result_582 = ""
        end
        el.innerHTML = ((("<h2>📜 MISSÕES</h2><div style=\"background:#f2dc9a;color:#3a2412;border:3px solid #2a1a10;padding:10px 14px;width:min(560px,86%);font:12px Space,Arial,sans-serif;line-height:1.5\"><b style=\"font:9px Pixel,monospace;color:#8a4a2a\">HISTÓRIA</b><br>" .. tostring(____t_result_582)) .. "</div>\n      <div style=\"background:#2a1e14e8;border:3px solid #8a6a3a;padding:8px 12px;width:min(560px,86%);font:11px Space,Arial,sans-serif;line-height:1.5;max-height:46vh;overflow:auto\">") .. tostring(__call(
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
                    return ((((((((("<div style=\"margin:5px 0;opacity:" .. tostring(st == "feita" and 0.55 or 1)) .. "\"><b style=\"font:9px Pixel,monospace;color:") .. (st == "feita" and "#7af07a" or (st == "ativa" and "#ffd24a" or "#e8c66a"))) .. "\">") .. tostring(__get(ic, st))) .. " ") .. tostring(__call(n, "toUpperCase"))) .. "</b><br><span style=\"color:#e8dcc0\">") .. tostring(st == "feita" and "Concluída!" or d)) .. "</span></div>"
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
                local ____opt_583 = el:querySelector("button")
                return ____opt_583 and ____opt_583:focus()
            end,
            30
        )
    end
    __L1.hudAtualizar = function(self)
        __L1:copiarPoderes()
        __L1:topoAtualizar()
        local cor = __L1.box:querySelector(".vida .cor")
        local ____t_result_585
        if __t(__L1.P.max) then
            ____t_result_585 = __L1.P.max
        else
            ____t_result_585 = 100
        end
        local n = math.floor(____t_result_585 / 20 + 0.5)
        local ____L1_clamp_588 = __L1.clamp
        local ____L1_P_hp_587 = __L1.P.hp
        local ____t_result_586
        if __t(__L1.P.max) then
            ____t_result_586 = __L1.P.max
        else
            ____t_result_586 = 100
        end
        local hp = ____L1_clamp_588(__L1, ____L1_P_hp_587, 0, ____t_result_586) / 20
        local h = ""
        do
            local i = 0
            while i < n do
                h = __add(h, ("<i class=\"" .. (hp >= i + 1 and "on" or (hp > i + 0.3 and "meio" or ""))) .. "\"></i>")
                i = i + 1
            end
        end
        if cor.innerHTML ~= h then
            cor.innerHTML = h
        end
        local ____table_style_596 = __L1.box:querySelector(".vida .gas b").style
        local ____L1_clamp_595 = __L1.clamp
        local ____opt_591 = __L1:TR()
        if ____opt_591 ~= nil then
            ____opt_591 = ____opt_591.gas
        end
        local ____opt_result_593
        if ____opt_591 ~= nil then
            ____opt_result_593 = ____opt_591(____opt_591)
        end
        local ____opt_result_593_594 = ____opt_result_593
        if ____opt_result_593_594 == nil then
            ____opt_result_593_594 = 100
        end
        ____table_style_596.width = tostring(____L1_clamp_595(__L1, ____opt_result_593_594, 0, 100)) .. "%"
        local ____temp_603 = __L1.box:querySelector(".vida .moedas")
        local ____opt_599 = window.CampanhaLoja
        if ____opt_599 ~= nil then
            ____opt_599 = ____opt_599.moedas
        end
        local ____opt_result_601
        if ____opt_599 ~= nil then
            ____opt_result_601 = ____opt_599(____opt_599)
        end
        local ____opt_result_601_602 = ____opt_result_601
        if ____opt_result_601_602 == nil then
            ____opt_result_601_602 = 0
        end
        ____temp_603.textContent = "● " .. tostring(____opt_result_601_602)
        do
            local pp = __L1.box:querySelector(".vida .papeis")
            local ____opt_606 = __L1:TR()
            if ____opt_606 ~= nil then
                ____opt_606 = ____opt_606.papeis
            end
            local ____opt_result_608
            if ____opt_606 ~= nil then
                ____opt_result_608 = ____opt_606(____opt_606)
            end
            local ____opt_result_608_609 = ____opt_result_608
            if ____opt_result_608_609 == nil then
                ____opt_result_608_609 = 30
            end
            local tx = "◆ " .. tostring(____opt_result_608_609)
            local ____t_611 = __t
            local ____t_result_610
            if __t(pp) then
                ____t_result_610 = pp.textContent ~= tx
            else
                ____t_result_610 = pp
            end
            if ____t_611(____t_result_610) then
                pp.textContent = tx
            end
        end
        local e = __L1.box:querySelector(".entrar")
        e.hidden = not __t(__L1.perto) or not not __t(__L1.cut)
        if __t(__L1.perto) then
            local ____t_result_616
            if __t(__L1.perto.botao) then
                ____t_result_616 = __L1.perto.botao
            else
                local ____temp_615
                if __L1.perto.tipo == "poderes" then
                    ____temp_615 = "PODERES"
                else
                    local ____temp_614
                    if __L1.perto.tipo == "pc" then
                        ____temp_614 = "USAR"
                    else
                        local ____temp_613
                        if __L1.perto.tipo == "armario" then
                            ____temp_613 = "ABRIR"
                        else
                            local ____temp_612
                            if __L1.perto.tipo == "rolante" then
                                ____temp_612 = __lt(
                                    __get(__L1.perto.ate, 1),
                                    __L1.FLOOR
                                ) and "SUBIR" or "DESCER"
                            else
                                ____temp_612 = __re_test(
                                    __re("^SAIR|DESCER", ""),
                                    __L1.perto.rotulo
                                ) and "SAIR" or "ENTRAR"
                            end
                            ____temp_613 = ____temp_612
                        end
                        ____temp_614 = ____temp_613
                    end
                    ____temp_615 = ____temp_614
                end
                ____t_result_616 = ____temp_615
            end
            e.textContent = ____t_result_616
        end
    end
    __L1.lutaC1 = function(self, f)
        local ____t_result_617
        if __t(f.F.chefe) then
            ____t_result_617 = f.F.chefe
        else
            ____t_result_617 = {}
        end
        local K = ____t_result_617
        local ok = false
        do
            local function ____catch(e)
                ok = false
            end
            local ____try, ____hasReturned = pcall(function()
                local ____t_625 = __t
                local ____opt_622 = window.C2Luta
                if ____opt_622 ~= nil then
                    ____opt_622 = ____opt_622.iniciar
                end
                local ____opt_result_624
                if ____opt_622 ~= nil then
                    local ____f_slug_620 = f.slug
                    local ____t_result_619
                    if __t(f.chefe.tipo) then
                        ____t_result_619 = f.chefe.tipo
                    else
                        ____t_result_619 = K.tipo
                    end
                    ____opt_result_624 = ____opt_622(
                        ____opt_622,
                        {
                            slug = ____f_slug_620,
                            tipo = ____t_result_619,
                            nome = K.nome,
                            cena = __L1.cenaId,
                            hora = __L1:horaAtual(),
                            bossX = f.chefe.x
                        },
                        function(____, r) return __L1:voltarDaLuta(f, r) end
                    )
                end
                ok = not not ____t_625(____opt_result_624)
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
            local ____L1_P_628 = __L1.P
            local ____L1_P_hp_627 = __L1.P.hp
            local ____t_result_626
            if __t(__L1.P.max) then
                ____t_result_626 = __L1.P.max
            else
                ____t_result_626 = 100
            end
            ____L1_P_628.hp = math.max(
                ____L1_P_hp_627,
                math.floor(____t_result_626 * 0.5 + 0.5)
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
                local ____opt_631 = window.Game
                if ____opt_631 ~= nil then
                    ____opt_631 = ____opt_631.getState
                end
                local ____opt_result_633
                if ____opt_631 ~= nil then
                    ____opt_result_633 = ____opt_631(____opt_631)
                end
                st = ____opt_result_633
            end)
        end
        local ____t_637 = __t
        local ____opt_result_636
        if st ~= nil then
            ____opt_result_636 = st.started
        end
        if ____t_637(____opt_result_636) then
            local ____opt_648 = __L1:TR()
            if ____opt_648 ~= nil then
                ____opt_648 = ____opt_648.dadosC1
            end
            if ____opt_648 ~= nil then
                local ____t_result_639
                if __t(st.weapon) then
                    ____t_result_639 = st.weapon
                else
                    ____t_result_639 = 0
                end
                local ____t_642 = __t
                local ____opt_640 = st.q
                if ____opt_640 ~= nil then
                    ____opt_640 = ____opt_640.trained
                end
                local ____temp_646 = not not ____t_642(____opt_640)
                local ____t_645 = __t
                local ____opt_643 = st.q
                if ____opt_643 ~= nil then
                    ____opt_643 = ____opt_643.miqueias
                end
                ____opt_648(
                    ____opt_648,
                    {
                        weapon = ____t_result_639,
                        trained = ____temp_646,
                        miqueias = not not ____t_645(____opt_643)
                    }
                )
            end
            return
        end
        local sv = __L1:save1()
        if __t(sv) then
            do
                pcall(function()
                    local ____opt_652 = window.Progression
                    if ____opt_652 ~= nil then
                        ____opt_652 = ____opt_652.getState
                    end
                    local ____opt_result_654
                    if ____opt_652 ~= nil then
                        ____opt_result_654 = ____opt_652(____opt_652)
                    end
                    local cur = ____opt_result_654
                    local ____t_660 = __t
                    local ____t_result_659
                    if __t(sv.progression) then
                        local ____temp_658 = not __t(cur)
                        if not ____temp_658 then
                            local ____lt_657 = __lt
                            local ____t_result_655
                            if __t(cur.totalXP) then
                                ____t_result_655 = cur.totalXP
                            else
                                ____t_result_655 = 0
                            end
                            local ____t_result_656
                            if __t(sv.progression.totalXP) then
                                ____t_result_656 = sv.progression.totalXP
                            else
                                ____t_result_656 = 0
                            end
                            ____temp_658 = ____lt_657(____t_result_655, ____t_result_656)
                        end
                        ____t_result_659 = ____temp_658
                    else
                        ____t_result_659 = sv.progression
                    end
                    if ____t_660(____t_result_659) then
                        window.Progression:restore(sv.progression)
                    end
                end)
            end
            local ____opt_670 = __L1:TR()
            if ____opt_670 ~= nil then
                ____opt_670 = ____opt_670.dadosC1
            end
            if ____opt_670 ~= nil then
                local ____t_result_664
                local ____t_663 = __t
                local ____TS__Number_result_662 = __TS__Number(sv.weapon)
                __O[1059] = ____TS__Number_result_662
                if ____t_663(____TS__Number_result_662) then
                    ____t_result_664 = __O[1059]
                else
                    ____t_result_664 = 0
                end
                local ____t_result_665
                if __t(sv.q) then
                    ____t_result_665 = not not __t(sv.q.trained)
                else
                    ____t_result_665 = true
                end
                local ____t_668 = __t
                local ____opt_666 = sv.q
                if ____opt_666 ~= nil then
                    ____opt_666 = ____opt_666.miqueias
                end
                ____opt_670(
                    ____opt_670,
                    {
                        weapon = ____t_result_664,
                        trained = ____t_result_665,
                        miqueias = not not ____t_668(____opt_666)
                    }
                )
            end
        else
            local ____t_674 = __t
            local ____opt_672 = __L1.S
            if ____opt_672 ~= nil then
                ____opt_672 = ____opt_672.progressao
            end
            if ____t_674(____opt_672) then
                do
                    pcall(function()
                        local ____opt_677 = window.Progression
                        if ____opt_677 ~= nil then
                            ____opt_677 = ____opt_677.restore
                        end
                        if ____opt_677 ~= nil then
                            ____opt_677(____opt_677, __L1.S.progressao)
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
                local ____opt_681 = window.Progression
                if ____opt_681 ~= nil then
                    ____opt_681 = ____opt_681.serialize
                end
                local ____opt_result_683
                if ____opt_681 ~= nil then
                    ____opt_result_683 = ____opt_681(____opt_681)
                end
                local pr = ____opt_result_683
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
        local ____t_result_693
        local ____t_692 = __t
        local ____opt_688 = window.Progression
        if ____opt_688 ~= nil then
            ____opt_688 = ____opt_688.getState
        end
        local ____opt_result_690
        if ____opt_688 ~= nil then
            ____opt_result_690 = ____opt_688(____opt_688)
        end
        local ____opt_result_691
        if ____opt_result_690 ~= nil then
            ____opt_result_691 = ____opt_result_690.level
        end
        __O[1060] = ____opt_result_691
        if ____t_692(____opt_result_691) then
            ____t_result_693 = __O[1060]
        else
            ____t_result_693 = 1
        end
        local antes = ____t_result_693
        local ____opt_696 = window.Progression
        if ____opt_696 ~= nil then
            ____opt_696 = ____opt_696.award
        end
        local ____opt_result_698
        if ____opt_696 ~= nil then
            ____opt_result_698 = ____opt_696(____opt_696, n, id)
        end
        local r = ____opt_result_698
        local ____t_702 = __t
        local ____opt_result_701
        if r ~= nil then
            ____opt_result_701 = r.awarded
        end
        if not ____t_702(____opt_result_701) then
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
        local ____gt_704 = __gt
        local ____t_result_703
        if __t(r.level) then
            ____t_result_703 = r.level
        else
            ____t_result_703 = antes
        end
        if ____gt_704(____t_result_703, antes) then
            __L1.P.hp = __L1:vidaMax()
            local ____opt_707 = __L1:TR()
            if ____opt_707 ~= nil then
                ____opt_707 = ____opt_707.encher
            end
            if ____opt_707 ~= nil then
                ____opt_707(____opt_707)
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
        local ____t_result_714
        local ____t_711 = __t
        local ____opt_709 = __L1.topo
        if ____opt_709 ~= nil then
            ____opt_709 = ____opt_709.el
        end
        __O[1063] = ____opt_709
        if ____t_711(____opt_709) then
            ____t_result_714 = __O[1063]
        else
            ____t_result_714 = shell and shell:querySelector(".game-topbar")
        end
        local bar = ____t_result_714
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
            local ____L1_topo_720 = __L1.topo
            local ____t_result_719
            local ____t_718 = __t
            local ____opt_715 = window.document:getElementById("gasFill")
            local ____temp_717 = ____opt_715 and ____opt_715.style.width
            __O[1064] = ____temp_717
            if ____t_718(____temp_717) then
                ____t_result_719 = __O[1064]
            else
                ____t_result_719 = ""
            end
            ____L1_topo_720.gasW = ____t_result_719
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
                local ____self_725 = __L1.topo.pai
                local ____self_725_insertBefore_726 = ____self_725.insertBefore
                local ____L1_topo_el_724 = __L1.topo.el
                local ____t_result_723
                local ____t_722 = __t
                local ____t_result_721
                if __t(__L1.topo.prox) then
                    ____t_result_721 = __L1.topo.prox.parentNode == __L1.topo.pai
                else
                    ____t_result_721 = __L1.topo.prox
                end
                if ____t_722(____t_result_721) then
                    ____t_result_723 = __L1.topo.prox
                else
                    ____t_result_723 = nil
                end
                ____self_725_insertBefore_726(____self_725, ____L1_topo_el_724, ____t_result_723)
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
        local ____opt_729 = window.HudMinimal
        if ____opt_729 ~= nil then
            ____opt_729 = ____opt_729.close
        end
        if ____opt_729 ~= nil then
            ____opt_729(____opt_729)
        end
        __L1.topo = nil
        local ____opt_731 = __L1.box
        if ____opt_731 ~= nil then
            ____opt_731.classList:remove("c1-topo")
        end
    end
    __L1.topoAtualizar = function(self)
        if not __t(__L1.topo) then
            return
        end
        local ____t_result_733
        if __t(__L1.P.max) then
            ____t_result_733 = __L1.P.max
        else
            ____t_result_733 = 100
        end
        local max = ____t_result_733
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
        local ____L1_p_F4r_740 = __L1["pôr"]
        local ____opt_736 = __L1:TR()
        if ____opt_736 ~= nil then
            ____opt_736 = ____opt_736.papeis
        end
        local ____opt_result_738
        if ____opt_736 ~= nil then
            ____opt_result_738 = ____opt_736(____opt_736)
        end
        local ____opt_result_738_739 = ____opt_result_738
        if ____opt_result_738_739 == nil then
            ____opt_result_738_739 = 30
        end
        ____L1_p_F4r_740(
            __L1,
            "paperValue",
            tostring(____opt_result_738_739)
        )
        local ____opt_743 = __L1:TR()
        if ____opt_743 ~= nil then
            ____opt_743 = ____opt_743.gas
        end
        local ____opt_result_745
        if ____opt_743 ~= nil then
            ____opt_result_745 = ____opt_743(____opt_743)
        end
        local ____opt_result_745_746 = ____opt_result_745
        if ____opt_result_745_746 == nil then
            ____opt_result_745_746 = 100
        end
        local g = ____opt_result_745_746
        local ____t_result_753
        local ____t_752 = __t
        local ____opt_749 = __L1:TR()
        if ____opt_749 ~= nil then
            ____opt_749 = ____opt_749.gasMax
        end
        local ____opt_result_751
        if ____opt_749 ~= nil then
            ____opt_result_751 = ____opt_749(____opt_749)
        end
        __O[1065] = ____opt_result_751
        if ____t_752(____opt_result_751) then
            ____t_result_753 = __O[1065]
        else
            ____t_result_753 = 100
        end
        local gm = ____t_result_753
        local pct = math.floor(__L1:clamp(g / gm, 0, 1) * 100)
        __L1["pôr"](
            __L1,
            "gasPercent",
            __add(pct, "%")
        )
        local gf = window.document:getElementById("gasFill")
        local ____t_755 = __t
        local ____t_result_754
        if __t(gf) then
            ____t_result_754 = gf.style.width ~= __add(pct, "%")
        else
            ____t_result_754 = gf
        end
        if ____t_755(____t_result_754) then
            gf.style.width = __add(pct, "%")
        end
        local ____call_760 = __call
        local ____t_result_759
        local ____t_758 = __t
        local ____opt_756 = __L1:D()
        if ____opt_756 ~= nil then
            ____opt_756 = ____opt_756.nome
        end
        __O[1066] = ____opt_756
        if ____t_758(____opt_756) then
            ____t_result_759 = __O[1066]
        else
            ____t_result_759 = ""
        end
        local nome = ____call_760(____t_result_759, "toUpperCase")
        if __t(nome) then
            __L1["pôr"](__L1, "stageName", nome)
        end
    end
    __L1.enquadrar = function(self, dt)
        local shell = window.document:getElementById("gameShell")
        local w = window.innerWidth
        local h = window.innerHeight
        local sc = w / 960
        local ____t_result_768
        local ____t_762 = __t
        local ____temp_761 = w / h > 1.79 and not __t(__L1.cut)
        __O[1069] = ____temp_761
        if ____t_762(____temp_761) then
            local ____t_result_767
            local ____t_766 = __t
            local ____t_result_765
            local ____t_764 = __t
            local ____temp_763 = not __t(shell)
            __O[1067] = ____temp_763
            if ____t_764(____temp_763) then
                ____t_result_765 = __O[1067]
            else
                ____t_result_765 = shell.classList:contains("screen-fill")
            end
            __O[1068] = ____t_result_765
            if ____t_766(____t_result_765) then
                ____t_result_767 = __O[1068]
            else
                ____t_result_767 = not __t(shell.classList:contains("immersive"))
            end
            ____t_result_768 = ____t_result_767
        else
            ____t_result_768 = __O[1069]
        end
        local quer = ____t_result_768
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
        local ____temp_769
        if __L1.pan == nil then
            ____temp_769 = alvo
        else
            ____temp_769 = __L1.pan + (alvo - __L1.pan) * math.min(1, dt * 12)
        end
        __L1.pan = ____temp_769
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
        local ____L1_771, ____fpsMedio_772 = __L1, "fpsMedio"
        local ____temp_770
        if dt > 0 then
            ____temp_770 = 1 / math.max(dt, (now - __L1.last + 0.001) / 1000)
        else
            ____temp_770 = 60
        end
        ____L1_771[____fpsMedio_772] = ____L1_771[____fpsMedio_772] + (____temp_770 - __L1.fpsMedio) * 0.05
        __L1.last = now
        local cob = __L1:coberto()
        __L1.box.style.visibility = __t(cob) and "hidden" or "visible"
        if __t(cob) then
            return
        end
        local ____t_result_781
        local ____t_774 = __t
        local ____temp_773 = not not __t(__L1.cut) or not not __t(__L1.box:querySelector(".escolha"))
        __O[1070] = ____temp_773
        if ____t_774(____temp_773) then
            ____t_result_781 = __O[1070]
        else
            local ____t_780 = __t
            local ____opt_777 = window.CampanhaMoradores
            if ____opt_777 ~= nil then
                ____opt_777 = ____opt_777.aberto
            end
            local ____opt_result_779
            if ____opt_777 ~= nil then
                ____opt_result_779 = ____opt_777(____opt_777)
            end
            ____t_result_781 = not not ____t_780(____opt_result_779)
        end
        local dlg = ____t_result_781
        if dlg ~= __L1.box.classList:contains("c2-dialogo") then
            __L1.box.classList:toggle("c2-dialogo", dlg)
        end
        __L1.P.max = __L1:vidaMax()
        local ____t_787 = __t
        local ____opt_784 = window.CampanhaAliados
        if ____opt_784 ~= nil then
            ____opt_784 = ____opt_784.ocupado
        end
        local ____opt_result_786
        if ____opt_784 ~= nil then
            ____opt_result_786 = ____opt_784(____opt_784)
        end
        if ____t_787(____opt_result_786) then
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
                        local ____opt_790 = window.DayTime
                        if ____opt_790 ~= nil then
                            ____opt_790 = ____opt_790.force
                        end
                        if ____opt_790 ~= nil then
                            ____opt_790(____opt_790, nil)
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
        local ____t_795 = __t
        local ____t_result_794
        if __t(__L1.pausado) then
            ____t_result_794 = __L1.pausado
        else
            ____t_result_794 = __L1:ocupado()
        end
        if ____t_795(____t_result_794) then
            __call(__L1.keys, "clear")
            __L1.P.vx = 0
        end
        __L1.t = __L1.t + dt
        local d = __L1:D()
        local ____temp_796
        if not __t(__L1.cut) then
            ____temp_796 = __L1:faseAtual()
        else
            ____temp_796 = __L1.fase
        end
        local F = ____temp_796
        local ____opt_802 = __L1:TR()
        if ____opt_802 ~= nil then
            ____opt_802 = ____opt_802.inimigos
        end
        if ____opt_802 ~= nil then
            local ____t_result_800
            local ____t_799 = __t
            local ____t_result_798
            if __t(F) then
                ____t_result_798 = not __t(__L1.cut)
            else
                ____t_result_798 = F
            end
            if ____t_799(____t_result_798) then
                ____t_result_800 = F:inimigos()
            else
                ____t_result_800 = __arrL({}, 0)
            end
            ____opt_802(____opt_802, ____t_result_800)
        end
        if __t(not __t(__L1.pausado) and not __t(__L1.morto)) then
            local ____L1_P_805 = __L1.P
            local ____t_result_804
            if __t(__L1.P.inv) then
                ____t_result_804 = __L1.P.inv
            else
                ____t_result_804 = 0
            end
            ____L1_P_805.inv = math.max(0, ____t_result_804 - dt)
            local ____L1_P_807 = __L1.P
            local ____t_result_806
            if __t(__L1.P.atordoado) then
                ____t_result_806 = __L1.P.atordoado
            else
                ____t_result_806 = 0
            end
            ____L1_P_807.atordoado = math.max(0, ____t_result_806 - dt)
            local ____opt_822 = __L1:TR()
            if ____opt_822 ~= nil then
                ____opt_822 = ____opt_822.passo
            end
            if ____opt_822 ~= nil then
                local ____L1_P_820 = __L1.P
                local ____L1_cam_819 = __L1.cam
                local ____t_result_818
                local ____t_817 = __t
                local ____t_815 = __t
                local ____opt_result_813
                if F ~= nil then
                    ____opt_result_813 = F.luta
                end
                local ____opt_result_814
                if ____opt_result_813 ~= nil then
                    ____opt_result_814 = ____opt_result_813.estrada
                end
                local ____temp_816 = not ____t_815(____opt_result_814)
                __O[1071] = ____temp_816
                if ____t_817(____temp_816) then
                    ____t_result_818 = __call(__L1.keys, "has", "jump")
                else
                    ____t_result_818 = __O[1071]
                end
                ____opt_822(____opt_822, dt, ____L1_P_820, {cam = ____L1_cam_819, segurandoPulo = ____t_result_818})
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
                local ____opt_827 = window.CampanhaAliados
                if ____opt_827 ~= nil then
                    ____opt_827 = ____opt_827.atualizar
                end
                local ____opt_result_829
                if ____opt_827 ~= nil then
                    local ____t_result_825
                    if __t(F) then
                        ____t_result_825 = F:inimigos()
                    else
                        ____t_result_825 = __arrL({}, 0)
                    end
                    ____opt_result_829 = ____opt_827(____opt_827, dt, ____t_result_825)
                end
                return ____opt_result_829
            end)
        end
        __L1.tremor = math.max(0, __L1.tremor - dt * 30)
        __L1.clarao = math.max(0, __L1.clarao - dt * 1.6)
        for ____, d0 in __iterar((__L1.dano)) do
            d0.t = d0.t + dt
        end
        while true do
            local ____t_831 = __t
            local ____t_result_830
            if __t(__len(__L1.dano)) then
                ____t_result_830 = __gt(
                    __get(__L1.dano, 0).t,
                    1
                )
            else
                ____t_result_830 = __len(__L1.dano)
            end
            if not ____t_831(____t_result_830) then
                break
            end
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
                local ____opt_834 = window.DayTime
                if ____opt_834 ~= nil then
                    ____opt_834 = ____opt_834.force
                end
                if ____opt_834 ~= nil then
                    ____opt_834(
                        ____opt_834,
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
        local ____self_839 = window.ConquistaCombate
        local ____self_839_terreno_840 = ____self_839.terreno
        local ____opt_result_838
        if F ~= nil then
            ____opt_result_838 = F.luta
        end
        local percurso = ____self_839_terreno_840(____self_839, ____opt_result_838)
        if __t(percurso) then
            __L1.cam = (__add(F.luta.l, F.luta.r) - __L1.W) / 2
        else
            __L1:safe(function()
                local ____opt_843 = window.Interact
                if ____opt_843 ~= nil then
                    ____opt_843 = ____opt_843.update
                end
                local ____opt_result_845
                if ____opt_843 ~= nil then
                    ____opt_result_845 = ____opt_843(____opt_843, dt, o)
                end
                return ____opt_result_845
            end)
        end
        __L1:safe(function()
            local ____this_847
            ____this_847 = __L1:CC()
            local ____opt_846 = ____this_847.heroi
            if ____opt_846 ~= nil then
                ____opt_846 = ____opt_846(____this_847, __L1.P.x, __L1.P.y, __L1.P.vy)
            end
            return ____opt_846
        end)
        local ____t_852 = __t
        local ____t_result_851
        local ____t_849 = __t
        local ____temp_848 = not __t(percurso)
        __O[1072] = ____temp_848
        if ____t_849(____temp_848) then
            ____t_result_851 = __O[1072]
        else
            local ____t_result_850
            if __t(F.luta.ceu) then
                ____t_result_850 = __lt(F.luta.ceu.tempo, 0.85)
            else
                ____t_result_850 = F.luta.ceu
            end
            ____t_result_851 = ____t_result_850
        end
        if ____t_852(____t_result_851) then
            window.Art:drawScene(__L1.c, d.id, __L1.cam, __L1.t)
        end
        if __t(percurso) then
            percurso:fundo(__L1.c, F.luta)
        end
        __L1.c:save()
        do
            local ____t_result_859
            local ____t_858 = __t
            local ____opt_855 = __L1:TR()
            if ____opt_855 ~= nil then
                ____opt_855 = ____opt_855.tremor
            end
            local ____opt_result_857
            if ____opt_855 ~= nil then
                ____opt_result_857 = ____opt_855(____opt_855)
            end
            __O[1073] = ____opt_result_857
            if ____t_858(____opt_result_857) then
                ____t_result_859 = __O[1073]
            else
                ____t_result_859 = 0
            end
            local sh = math.max(____t_result_859, __L1.tremor)
            __L1.c:translate(
                -math.floor(__L1.cam + 0.5) + math.floor((math.random() - 0.5) * sh + 0.5),
                math.floor((math.random() - 0.5) * sh + 0.5)
            )
        end
        if not __t(percurso) then
            if __ge(d.id, 12) then
                local ____iter_861 = __iter
                local ____t_result_860
                if __t(d.plataformas) then
                    ____t_result_860 = d.plataformas
                else
                    ____t_result_860 = __arrL({}, 0)
                end
                for ____, pl in __TS__Iterator(____iter_861(____t_result_860)) do
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
                local ____opt_864 = window.Interact
                if ____opt_864 ~= nil then
                    ____opt_864 = ____opt_864.drawBack
                end
                local ____opt_result_866
                if ____opt_864 ~= nil then
                    ____opt_result_866 = ____opt_864(____opt_864, __L1.c, o)
                end
                return ____opt_result_866
            end)
            if __ge(d.id, 12) then
                __L1:safe(function()
                    local ____opt_869 = window.CampanhaPlantas
                    if ____opt_869 ~= nil then
                        ____opt_869 = ____opt_869.drawBack
                    end
                    local ____opt_result_871
                    if ____opt_869 ~= nil then
                        ____opt_result_871 = ____opt_869(____opt_869, __L1.c, o)
                    end
                    return ____opt_result_871
                end)
                __L1:safe(function()
                    local ____opt_874 = window.CampanhaTaxi
                    if ____opt_874 ~= nil then
                        ____opt_874 = ____opt_874.desenhar
                    end
                    local ____opt_result_876
                    if ____opt_874 ~= nil then
                        ____opt_result_876 = ____opt_874(____opt_874, __L1.c, o)
                    end
                    return ____opt_result_876
                end)
                __L1:safe(function()
                    local ____opt_879 = window.CampanhaLoja
                    if ____opt_879 ~= nil then
                        ____opt_879 = ____opt_879.desenhar
                    end
                    local ____opt_result_881
                    if ____opt_879 ~= nil then
                        ____opt_result_881 = ____opt_879(____opt_879, __L1.c, o)
                    end
                    return ____opt_result_881
                end)
                __L1:safe(function()
                    local ____opt_884 = window.CampanhaMoradores
                    if ____opt_884 ~= nil then
                        ____opt_884 = ____opt_884.desenhar
                    end
                    local ____opt_result_886
                    if ____opt_884 ~= nil then
                        ____opt_result_886 = ____opt_884(____opt_884, __L1.c, o)
                    end
                    return ____opt_result_886
                end)
            end
            __L1:desenharExtras()
            __L1:safe(function()
                local ____opt_889 = window.CampanhaAliados
                if ____opt_889 ~= nil then
                    ____opt_889 = ____opt_889.desenhar
                end
                local ____opt_result_891
                if ____opt_889 ~= nil then
                    ____opt_result_891 = ____opt_889(____opt_889, __L1.c, d.id)
                end
                return ____opt_result_891
            end)
        end
        if __t(F) then
            F:desenhar(__L1.c)
        end
        if not __t(percurso) then
            local ____iter_899 = __iter
            local ____t_result_898
            local ____t_897 = __t
            local ____opt_894 = window.CampanhaAliados
            if ____opt_894 ~= nil then
                ____opt_894 = ____opt_894.alvos
            end
            local ____opt_result_896
            if ____opt_894 ~= nil then
                ____opt_result_896 = ____opt_894(____opt_894, d.id)
            end
            __O[1074] = ____opt_result_896
            if ____t_897(____opt_result_896) then
                ____t_result_898 = __O[1074]
            else
                ____t_result_898 = __arrL({}, 0)
            end
            for ____, ax in __TS__Iterator(____iter_899(____t_result_898)) do
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
            local ____opt_902 = __L1:TR()
            if ____opt_902 ~= nil then
                ____opt_902 = ____opt_902.desenharAtras
            end
            local ____opt_result_904
            if ____opt_902 ~= nil then
                ____opt_result_904 = ____opt_902(____opt_902, __L1.c, __L1.t)
            end
            return ____opt_result_904
        end)
        local ____t_result_905
        if __t(__L1.P.attack) then
            ____t_result_905 = __L1.P.attack
        else
            ____t_result_905 = 0
        end
        local at = ____t_result_905
        local ____t_result_906
        if __t(__L1.P.attackDuration) then
            ____t_result_906 = __L1.P.attackDuration
        else
            ____t_result_906 = 0.32
        end
        local dur = ____t_result_906
        local ____t_912 = __t
        local ____t_result_911
        local ____t_910 = __t
        local ____gt_908 = __gt
        local ____t_result_907
        if __t(__L1.P.inv) then
            ____t_result_907 = __L1.P.inv
        else
            ____t_result_907 = 0
        end
        local ____gt_908_result_909 = ____gt_908(____t_result_907, 0)
        __O[1075] = ____gt_908_result_909
        if ____t_910(____gt_908_result_909) then
            ____t_result_911 = __mod(
                math.floor(__L1.t * 16),
                2
            )
        else
            ____t_result_911 = __O[1075]
        end
        if not ____t_912(____t_result_911) then
            local ____self_964 = window.Art
            local ____self_964_drawCharacter_965 = ____self_964.drawCharacter
            local ____array_963 = __TS__SparseArrayNew(__L1.c, "daroca", __L1.P.x, __L1.P.y)
            local ____temp_914
            if math.abs(__L1.P.vx) > 8 then
                local ____t_result_913
                if __t(__L1.P.anim) then
                    ____t_result_913 = __L1.P.anim
                else
                    ____t_result_913 = 0
                end
                ____temp_914 = ____t_result_913 / 9
            else
                ____temp_914 = __L1.t
            end
            local ____math_abs_result_954 = math.abs(__L1.P.vx)
            local ____t_920 = __t
            local ____opt_917 = __L1:TR()
            if ____opt_917 ~= nil then
                ____opt_917 = ____opt_917.musculoso
            end
            local ____opt_result_919
            if ____opt_917 ~= nil then
                ____opt_result_919 = ____opt_917(____opt_917)
            end
            local ____temp_955 = not not ____t_920(____opt_result_919)
            local ____t_result_921
            if __t(__L1.P.landTimer) then
                ____t_result_921 = __L1.P.landTimer
            else
                ____t_result_921 = 0
            end
            local ____temp_956 = ____t_result_921 / 0.15
            local ____t_result_922
            if __t(__L1.P.landTimer) then
                ____t_result_922 = __L1.P.landTimer
            else
                ____t_result_922 = 0
            end
            local ____L1_P_facing_957 = __L1.P.facing
            local ____t_result_929
            local ____t_926 = __t
            local ____t_result_925
            local ____t_924 = __t
            local ____temp_923 = math.abs(__L1.P.vx) > 8
            __O[1076] = ____temp_923
            if ____t_924(____temp_923) then
                ____t_result_925 = __L1.P.ground
            else
                ____t_result_925 = __O[1076]
            end
            __O[1077] = ____t_result_925
            if ____t_926(____t_result_925) then
                ____t_result_929 = __O[1077]
            else
                local ____opt_927 = __L1.viagem
                if ____opt_927 ~= nil then
                    ____opt_927 = ____opt_927.tipo
                end
                ____t_result_929 = ____opt_927 == "porta"
            end
            local ____L1_P_ground_958 = __L1.P.ground
            local ____L1_P_vy_959 = __L1.P.vy
            local ____temp_960 = at > 0
            local ____t_result_930
            if __t(__L1.P.attackType) then
                ____t_result_930 = __L1.P.attackType
            else
                ____t_result_930 = "paper"
            end
            local ____temp_961 = 1 - at / dur
            local ____t_936 = __t
            local ____opt_933 = __L1.fase
            if ____opt_933 ~= nil then
                ____opt_933 = ____opt_933.luta
            end
            local ____opt_result_935
            if ____opt_933 ~= nil then
                ____opt_result_935 = ____opt_933.estrada
            end
            local ____temp_943 = not ____t_936(____opt_result_935)
            if ____temp_943 then
                local ____t_942 = __t
                local ____opt_939 = __L1:TR()
                if ____opt_939 ~= nil then
                    ____opt_939 = ____opt_939.voandoAgora
                end
                local ____opt_result_941
                if ____opt_939 ~= nil then
                    ____opt_result_941 = ____opt_939(____opt_939)
                end
                ____temp_943 = not not ____t_942(____opt_result_941)
            end
            local ____t_949 = __t
            local ____opt_946 = __L1:TR()
            if ____opt_946 ~= nil then
                ____opt_946 = ____opt_946.dashing
            end
            local ____opt_result_948
            if ____opt_946 ~= nil then
                ____opt_result_948 = ____opt_946(____opt_946)
            end
            local ____temp_962 = not not ____t_949(____opt_result_948)
            local ____t_result_953
            local ____t_952 = __t
            local ____temp_951 = at > 0
            if ____temp_951 then
                local ____t_result_950
                if __t(__L1.P.attackType) then
                    ____t_result_950 = __L1.P.attackType
                else
                    ____t_result_950 = "paper"
                end
                ____temp_951 = ____t_result_950 == "paper"
            end
            if ____t_952(____temp_951) then
                ____t_result_953 = math.max(0, 1 - (1 - at / dur) * 3)
            else
                ____t_result_953 = 0
            end
            __TS__SparseArrayPush(____array_963, {
                frame = ____temp_914,
                speed = ____math_abs_result_954,
                muscular = ____temp_955,
                land = ____temp_956,
                landTimer = ____t_result_922,
                facing = ____L1_P_facing_957,
                moving = ____t_result_929,
                grounded = ____L1_P_ground_958,
                vy = ____L1_P_vy_959,
                attack = ____temp_960,
                attackType = ____t_result_930,
                attackProgress = ____temp_961,
                attackObject = "paper",
                flight = ____temp_943,
                dash = ____temp_962,
                recoil = ____t_result_953
            })
            ____self_964_drawCharacter_965(
                ____self_964,
                __TS__SparseArraySpread(____array_963)
            )
        end
        __L1:safe(function()
            local ____opt_968 = __L1:TR()
            if ____opt_968 ~= nil then
                ____opt_968 = ____opt_968.desenhar
            end
            local ____opt_result_970
            if ____opt_968 ~= nil then
                ____opt_result_970 = ____opt_968(____opt_968, __L1.c, __L1.t)
            end
            return ____opt_result_970
        end)
        if not __t(percurso) then
            __L1:safe(function()
                local ____opt_973 = window.Interact
                if ____opt_973 ~= nil then
                    ____opt_973 = ____opt_973.drawFront
                end
                local ____opt_result_975
                if ____opt_973 ~= nil then
                    ____opt_result_975 = ____opt_973(____opt_973, __L1.c, o)
                end
                return ____opt_result_975
            end)
        end
        if __t(not __t(percurso) and __ge(d.id, 12)) then
            __L1:safe(function()
                local ____opt_978 = window.CampanhaPlantas
                if ____opt_978 ~= nil then
                    ____opt_978 = ____opt_978.drawFront
                end
                local ____opt_result_980
                if ____opt_978 ~= nil then
                    ____opt_result_980 = ____opt_978(____opt_978, __L1.c, o)
                end
                return ____opt_result_980
            end)
            __L1:safe(function()
                local ____opt_983 = window.CampanhaCamadas
                if ____opt_983 ~= nil then
                    ____opt_983 = ____opt_983.primeiroPlano
                end
                local ____opt_result_985
                if ____opt_983 ~= nil then
                    ____opt_result_985 = ____opt_983(____opt_983, __L1.c, o)
                end
                return ____opt_result_985
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
                do
                    local x0 = __get(__L1.xpTxt, i)
                    x0.t = x0.t + 1 / 60
                    if __gt(x0.t, 1.2) then
                        __call(__L1.xpTxt, "splice", i, 1)
                        do i = i - 1 continue end
                    end
                    __L1.c.globalAlpha = math.min(1, (1.2 - x0.t) * 2)
                    __L1.c.fillStyle = "#2a1a08"
                    __L1.c:fillText(x0.s, x0.x + 2, x0.y - x0.t * 30 + 2)
                    __L1.c.fillStyle = "#ffec91"
                    __L1.c:fillText(x0.s, x0.x, x0.y - x0.t * 30)
                end
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
                local ____opt_988 = window.CampanhaAmbientes
                if ____opt_988 ~= nil then
                    ____opt_988 = ____opt_988.cobrir
                end
                local ____opt_result_990
                if ____opt_988 ~= nil then
                    ____opt_result_990 = ____opt_988(____opt_988, __L1.c, d.id, __L1.cam)
                end
                return ____opt_result_990
            end)
        end
        local ____t_997 = __t
        local ____opt_result_995
        if F ~= nil then
            ____opt_result_995 = F.emArena
        end
        local ____opt_result_996
        if ____opt_result_995 ~= nil then
            ____opt_result_996 = ____opt_result_995(F)
        end
        if not ____t_997(____opt_result_996) then
            __L1:setaObjetivo()
        end
        if __t(F) then
            F:desenharTela(__L1.c, __L1.W)
        end
        do
            local ____opt_1000 = window.CampanhaAliados
            if ____opt_1000 ~= nil then
                ____opt_1000 = ____opt_1000.correndo
            end
            local ____opt_result_1002
            if ____opt_1000 ~= nil then
                ____opt_result_1002 = ____opt_1000(____opt_1000)
            end
            local cr = ____opt_result_1002
            if __t(cr) then
                local ____temp_1003
                if cr.fase == "contagem" then
                    ____temp_1003 = tostring(math.ceil(cr.cont))
                else
                    ____temp_1003 = __add(
                        __call(
                            math.max(0, cr.lim - cr.t),
                            "toFixed",
                            1
                        ),
                        " s"
                    )
                end
                local txt = ____temp_1003
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
        local ____table_style_1011 = __L1.box:querySelector(".obj").style
        local ____t_1010 = __t
        local ____opt_result_1008
        if F ~= nil then
            ____opt_result_1008 = F.emArena
        end
        local ____opt_result_1009
        if ____opt_result_1008 ~= nil then
            ____opt_result_1009 = ____opt_result_1008(F)
        end
        ____table_style_1011.visibility = ____t_1010(____opt_result_1009) and "hidden" or "visible"
        local ____t_1017 = __t
        local ____opt_1014 = window.Graphics
        if ____opt_1014 ~= nil then
            ____opt_1014 = ____opt_1014.isShader
        end
        local ____opt_result_1016
        if ____opt_1014 ~= nil then
            ____opt_result_1016 = ____opt_1014(____opt_1014)
        end
        if ____t_1017(____opt_result_1016) then
            __L1:safe(function()
                local ____opt_1020 = window.Shader
                if ____opt_1020 ~= nil then
                    ____opt_1020 = ____opt_1020.apply
                end
                local ____opt_result_1022
                if ____opt_1020 ~= nil then
                    ____opt_result_1022 = ____opt_1020(
                        ____opt_1020,
                        __L1.cv,
                        {
                            scene = d.id,
                            camera = __L1.cam,
                            time = __L1.t,
                            outdoor = not __t(d.interno)
                        }
                    )
                end
                return ____opt_result_1022
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
        local ____t_result_1027
        local ____t_1026 = __t
        local ____t_result_1025
        local ____t_1024 = __t
        local ____temp_1023 = not __t(o.novo)
        __O[1078] = ____temp_1023
        if ____t_1024(____temp_1023) then
            ____t_result_1025 = __L1:carregar()
        else
            ____t_result_1025 = __O[1078]
        end
        __O[1079] = ____t_result_1025
        if ____t_1026(____t_result_1025) then
            ____t_result_1027 = __O[1079]
        else
            ____t_result_1027 = __L1:novoSave()
        end
        __L1.S = ____t_result_1027
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
        local ____opt_1028 = __L1.box:querySelector(".pausa")
        if ____opt_1028 ~= nil then
            ____opt_1028:remove()
        end
        if __t(o.novo) then
            __L1:safe(function() return window.localStorage:removeItem(__L1.KEY) end)
        end
        __L1.aberto = true
        __L1.box.hidden = false
        __L1.pausado = false
        __L1.cut = nil
        __call(__L1.keys, "clear")
        local ____L1_P_1031 = __L1.P
        local ____t_result_1030
        if __t(__L1.S.hp) then
            ____t_result_1030 = __L1.S.hp
        else
            ____t_result_1030 = 100
        end
        ____L1_P_1031.hp = ____t_result_1030
        local ____opt_1034 = window.CampanhaAliados
        if ____opt_1034 ~= nil then
            ____opt_1034 = ____opt_1034.ligar
        end
        if ____opt_1034 ~= nil then
            ____opt_1034(
                ____opt_1034,
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
        local ____opt_1038 = __L1:TR()
        if ____opt_1038 ~= nil then
            ____opt_1038 = ____opt_1038.ligar
        end
        if ____opt_1038 ~= nil then
            ____opt_1038(____opt_1038, true, __L1.P, {jogo = true})
        end
        __L1:safe(function()
            local ____opt_1042 = window.CampanhaBotoes
            if ____opt_1042 ~= nil then
                ____opt_1042 = ____opt_1042.aplicar
            end
            local ____opt_result_1044
            if ____opt_1042 ~= nil then
                ____opt_result_1044 = ____opt_1042(
                    ____opt_1042,
                    __L1.box:querySelector(".tela")
                )
            end
            return ____opt_result_1044
        end)
        __L1:safe(__L1.carregarC1)
        __L1:safe(function()
            local ____opt_1047 = window.CampanhaPoderes
            if ____opt_1047 ~= nil then
                ____opt_1047 = ____opt_1047.controles
            end
            local ____opt_result_1049
            if ____opt_1047 ~= nil then
                ____opt_result_1049 = ____opt_1047(____opt_1047, true, {forcar = true})
            end
            return ____opt_result_1049
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
            local ____L1_irPara_1053 = __L1.irPara
            local ____L1_S_cena_1050 = __L1.S.cena
            if ____L1_S_cena_1050 == nil then
                ____L1_S_cena_1050 = __get(__L1.PASSO_INICIAL_DA_CENA, __L1.S.passo)
            end
            local ____L1_S_cena_1050_1051 = ____L1_S_cena_1050
            if ____L1_S_cena_1050_1051 == nil then
                ____L1_S_cena_1050_1051 = 13
            end
            local ____L1_S_x_1052 = __L1.S.x
            if ____L1_S_x_1052 == nil then
                ____L1_S_x_1052 = 300
            end
            ____L1_irPara_1053(__L1, ____L1_S_cena_1050_1051, ____L1_S_x_1052)
            local ____L1_objetivoNovo_1058 = __L1.objetivoNovo
            local ____t_result_1057
            local ____t_1056 = __t
            local ____opt_1054 = __get(__L1.PASSOS, __L1.S.passo)
            if ____opt_1054 ~= nil then
                ____opt_1054 = ____opt_1054.obj
            end
            __O[1080] = ____opt_1054
            if ____t_1056(____opt_1054) then
                ____t_result_1057 = __O[1080]
            else
                ____t_result_1057 = ""
            end
            ____L1_objetivoNovo_1058(__L1, ____t_result_1057)
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
        local ____opt_1061 = __L1.box
        if ____opt_1061 ~= nil then
            ____opt_1061 = ____opt_1061:querySelector(".pausa")
        end
        if ____opt_1061 ~= nil then
            ____opt_1061:remove()
        end
        local ____opt_1063 = __L1.box
        if ____opt_1063 ~= nil then
            ____opt_1063.classList:remove("c2-dialogo")
        end
        local ____opt_1067 = __L1:TR()
        if ____opt_1067 ~= nil then
            ____opt_1067 = ____opt_1067.ligar
        end
        if ____opt_1067 ~= nil then
            ____opt_1067(____opt_1067, false, __L1.P)
        end
        __L1:safe(function()
            local ____opt_1071 = window.CampanhaPoderes
            if ____opt_1071 ~= nil then
                ____opt_1071 = ____opt_1071.controles
            end
            local ____opt_result_1073
            if ____opt_1071 ~= nil then
                ____opt_result_1073 = ____opt_1071(____opt_1071, false, {forcar = false})
            end
            return ____opt_result_1073
        end)
        __L1:safe(function()
            local ____opt_1078 = window.CampanhaCutscenes
            if ____opt_1078 ~= nil then
                ____opt_1078 = ____opt_1078.musica
            end
            local ____opt_result_1080
            if ____opt_1078 ~= nil then
                ____opt_result_1080 = ____opt_1078.parar
            end
            local ____opt_result_1081
            if ____opt_result_1080 ~= nil then
                ____opt_result_1081 = ____opt_result_1080(____opt_1078)
            end
            return ____opt_result_1081
        end)
        window.__somCutscene = false
        do
            pcall(function()
                local ____opt_1084 = window.DayTime
                if ____opt_1084 ~= nil then
                    ____opt_1084 = ____opt_1084.force
                end
                if ____opt_1084 ~= nil then
                    ____opt_1084(____opt_1084, nil)
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
        local ____el_1097 = el
        local ____t_result_1096
        if __t(ok) then
            ____t_result_1096 = ((((("<p>" .. (__t(__L1:safe(
                function()
                    local ____self_1093 = window.JSON
                    local ____self_1093_parse_1094 = ____self_1093.parse
                    local ____t_result_1092
                    local ____t_1091 = __t
                    local ____temp_1090 = window.localStorage:getItem(__L1.KEY)
                    __O[1081] = ____temp_1090
                    if ____t_1091(____temp_1090) then
                        ____t_result_1092 = __O[1081]
                    else
                        ____t_result_1092 = "null"
                    end
                    local ____opt_1088 = ____self_1093_parse_1094(____self_1093, ____t_result_1092)
                    if ____opt_1088 ~= nil then
                        ____opt_1088 = ____opt_1088.flags
                    end
                    local ____opt_result_1095
                    if ____opt_1088 ~= nil then
                        ____opt_result_1095 = ____opt_1088.zerou
                    end
                    return ____opt_result_1095
                end,
                false
            )) and "✔ Campanha 2 completa: o trio voltou! Continue explorando Conquista." or "Um ano depois. O Jorge ligou... e desligou. Agora o Da Roça vai até Conquista olhar na cara dele.")) .. "</p>") .. (__t(__L1:temSave()) and "<button type=\"button\" data-a=\"cont\">▶ CONTINUAR</button>" or "")) .. "<button type=\"button\" data-a=\"novo\">") .. (__t(__L1:temSave()) and "COMEÇAR DE NOVO" or "▶ COMEÇAR")) .. "</button>"
        else
            ____t_result_1096 = "<p>🔒 Termine a campanha principal (até a ligação do Jorge) para liberar a Campanha 2.</p>"
        end
        ____el_1097.innerHTML = ("<div class=\"pausa\" style=\"position:relative;background:none\"><h2>CAMPANHA 2 · VITÓRIA DA CONQUISTA</h2>" .. ____t_result_1096) .. "<button type=\"button\" data-a=\"fechar\">VOLTAR</button></div>"
        el.onclick = function(____, e)
            local ____opt_1098 = e.target:closest("button")
            if ____opt_1098 ~= nil then
                ____opt_1098 = ____opt_1098.dataset.a
            end
            local a = ____opt_1098
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
                    local ____self_1100 = window:Confirmar(pergunta)
                    ____self_1100["then"](
                        ____self_1100,
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
                local ____opt_1101 = el:querySelector("button")
                return ____opt_1101 and ____opt_1101:focus()
            end,
            30
        )
    end
    __L1.botaoMenu = function(self)
        local lista = window.document:querySelector("#startScreen .ranch-mode-entries")
        local ____t_1106 = __t
        local ____t_result_1105
        local ____t_1104 = __t
        local ____temp_1103 = not __t(lista)
        __O[1082] = ____temp_1103
        if ____t_1104(____temp_1103) then
            ____t_result_1105 = __O[1082]
        else
            ____t_result_1105 = lista:querySelector("[data-open-campanha2]")
        end
        if ____t_1106(____t_result_1105) then
            return
        end
        local b = window.document:createElement("button")
        b.type = "button"
        b.dataset.openCampanha2 = ""
        b.innerHTML = ("<b>❄ CAMPANHA 2 · CONQUISTA</b><small>" .. (__t(__L1:liberada()) and "Um ano depois · a busca pelo Jorge" or "Complete a história para liberar")) .. "</small>"
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
    local ____t_1110 = __t
    local ____t_result_1109
    local ____t_1108 = __t
    local ____t_result_1107
    if __t(window.Campanha2) then
        ____t_result_1107 = window.Campanha2
    else
        ____t_result_1107 = not __t(window.CampanhaCenarios)
    end
    __O[979] = ____t_result_1107
    if ____t_1108(____t_result_1107) then
        ____t_result_1109 = __O[979]
    else
        ____t_result_1109 = not __t(window.Art)
    end
    if ____t_1110(____t_result_1109) then
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
            local ____self_1116 = window.JSON
            local ____self_1116_parse_1117 = ____self_1116.parse
            local ____t_result_1115
            local ____t_1114 = __t
            local ____temp_1113 = window.localStorage:getItem(__L1.KEY)
            __O[983] = ____temp_1113
            if ____t_1114(____temp_1113) then
                ____t_result_1115 = __O[983]
            else
                ____t_result_1115 = "null"
            end
            local ____opt_1111 = ____self_1116_parse_1117(____self_1116, ____t_result_1115)
            if ____opt_1111 ~= nil then
                ____opt_1111 = ____opt_1111.passo
            end
            return ____opt_1111
        end,
        false
    )) end
    __L1.NOMES_C1 = function()
        local ____t_result_1121
        local ____t_1120 = __t
        local ____opt_1118 = window.Campaign
        if ____opt_1118 ~= nil then
            ____opt_1118 = ____opt_1118.sceneNames
        end
        __O[992] = ____opt_1118
        if ____t_1120(____opt_1118) then
            ____t_result_1121 = __O[992]
        else
            ____t_result_1121 = __arrL({}, 0)
        end
        return ____t_result_1121
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
                        local ____L1_P_1123 = __L1.P
                        local ____t_result_1122
                        if __t(__L1.P.max) then
                            ____t_result_1122 = __L1.P.max
                        else
                            ____t_result_1122 = 100
                        end
                        ____L1_P_1123.hp = ____t_result_1122
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
                local ____opt_1126 = window.Roteiro
                if ____opt_1126 ~= nil then
                    ____opt_1126 = ____opt_1126.sfx
                end
                if ____opt_1126 ~= nil then
                    ____opt_1126(____opt_1126, n)
                end
            end)
        end
    end
    __L1.portais = function(____, id)
        local ____t_result_1130
        local ____t_1129 = __t
        local ____temp_1128 = __L1:safe(
            function() return window.CampanhaAmbientes:portais(id) end,
            __arrL({}, 0)
        )
        __O[997] = ____temp_1128
        if ____t_1129(____temp_1128) then
            ____t_result_1130 = __O[997]
        else
            ____t_result_1130 = __arrL({}, 0)
        end
        return ____t_result_1130
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
                local ____t_result_1131
                if __t(cor) then
                    ____t_result_1131 = cor
                else
                    ____t_result_1131 = "#ffffff"
                end
                __L1.claraoCor = ____t_result_1131
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
                        local ____opt_1134 = window.CampanhaTaxi
                        if ____opt_1134 ~= nil then
                            ____opt_1134 = ____opt_1134.vencer
                        end
                        if ____opt_1134 ~= nil then
                            ____opt_1134(____opt_1134, slug)
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
        local ____opt_1138 = window.DayTime
        if ____opt_1138 ~= nil then
            ____opt_1138 = ____opt_1138.mode
        end
        local ____opt_result_1140
        if ____opt_1138 ~= nil then
            ____opt_result_1140 = ____opt_1138(____opt_1138)
        end
        local m = ____opt_result_1140
        local ____t_1142 = __t
        local ____t_result_1141
        if __t(m) then
            ____t_result_1141 = __get(__L1.HORAS, m) ~= nil
        else
            ____t_result_1141 = m
        end
        if ____t_1142(____t_result_1141) then
            return __get(__L1.HORAS, m)
        end
        local ____get_1146 = __get
        local ____L1_PASSOS_1145 = __L1.PASSOS
        local ____opt_1143 = __L1.S
        if ____opt_1143 ~= nil then
            ____opt_1143 = ____opt_1143.passo
        end
        local p = ____get_1146(____L1_PASSOS_1145, ____opt_1143)
        if __t(__L1.cenaId == 25 or __L1.cenaId == 24) then
            local ____opt_1147 = __L1.S
            if ____opt_1147 ~= nil then
                ____opt_1147 = ____opt_1147.passo
            end
            return ____opt_1147 == "lurdes" and 21 or 8
        end
        local ____opt_result_1151
        if p ~= nil then
            ____opt_result_1151 = p.hora
        end
        local ____opt_result_1151_1152 = ____opt_result_1151
        if ____opt_result_1151_1152 == nil then
            ____opt_result_1151_1152 = 12
        end
        return ____opt_result_1151_1152
    end
    __L1.FORA = __re("^(in-main-menu|is-paused|is-cutscene|is-dialog|is-chapter-ended|is-routing|is-training|is-activity|is-epilogue|is-ollyan-flight|campaign-layout-editing|is-room|is-arena|is-boss)$", "")
    __L1.cssC1 = false
    __L1.ultPoder = 0
    window:addEventListener(
        "resize",
        function()
            local ____t_1154 = __t
            local ____t_result_1153
            if __t(__L1.aberto) then
                ____t_result_1153 = __L1.box
            else
                ____t_result_1153 = __L1.aberto
            end
            if ____t_1154(____t_result_1153) then
                window:clearTimeout(window.__c2RecC1)
                window.__c2RecC1 = window:setTimeout(
                    function() return __L1:safe(__L1.controlesC1) end,
                    250
                )
            end
        end
    )
    __L1.coberto = function()
        local ____t_1195 = __t
        local ____t_result_1194
        local ____t_1188 = __t
        local ____t_result_1187
        local ____t_1181 = __t
        local ____t_result_1180
        local ____t_1174 = __t
        local ____t_result_1173
        local ____t_1167 = __t
        local ____t_result_1166
        local ____t_1160 = __t
        local ____opt_1157 = window.CampanhaOficina
        if ____opt_1157 ~= nil then
            ____opt_1157 = ____opt_1157.aberta
        end
        local ____opt_result_1159
        if ____opt_1157 ~= nil then
            ____opt_result_1159 = ____opt_1157(____opt_1157)
        end
        __O[1039] = ____opt_result_1159
        if ____t_1160(____opt_result_1159) then
            ____t_result_1166 = __O[1039]
        else
            local ____opt_1163 = window.Fliperama
            if ____opt_1163 ~= nil then
                ____opt_1163 = ____opt_1163.isOpen
            end
            local ____opt_result_1165
            if ____opt_1163 ~= nil then
                ____opt_result_1165 = ____opt_1163(____opt_1163)
            end
            ____t_result_1166 = ____opt_result_1165
        end
        __O[1040] = ____t_result_1166
        if ____t_1167(____t_result_1166) then
            ____t_result_1173 = __O[1040]
        else
            local ____opt_1170 = window.DarocaLook
            if ____opt_1170 ~= nil then
                ____opt_1170 = ____opt_1170.isOpen
            end
            local ____opt_result_1172
            if ____opt_1170 ~= nil then
                ____opt_result_1172 = ____opt_1170(____opt_1170)
            end
            ____t_result_1173 = ____opt_result_1172
        end
        __O[1041] = ____t_result_1173
        if ____t_1174(____t_result_1173) then
            ____t_result_1180 = __O[1041]
        else
            local ____opt_1177 = window.CampanhaPoderes
            if ____opt_1177 ~= nil then
                ____opt_1177 = ____opt_1177.muralAberto
            end
            local ____opt_result_1179
            if ____opt_1177 ~= nil then
                ____opt_result_1179 = ____opt_1177(____opt_1177)
            end
            ____t_result_1180 = ____opt_result_1179
        end
        __O[1042] = ____t_result_1180
        if ____t_1181(____t_result_1180) then
            ____t_result_1187 = __O[1042]
        else
            local ____opt_1184 = window.Mapa3D
            if ____opt_1184 ~= nil then
                ____opt_1184 = ____opt_1184.aberto
            end
            local ____opt_result_1186
            if ____opt_1184 ~= nil then
                ____opt_result_1186 = ____opt_1184(____opt_1184)
            end
            ____t_result_1187 = ____opt_result_1186
        end
        __O[1043] = ____t_result_1187
        if ____t_1188(____t_result_1187) then
            ____t_result_1194 = __O[1043]
        else
            local ____opt_1191 = window.CampanhaLoja
            if ____opt_1191 ~= nil then
                ____opt_1191 = ____opt_1191.aberta
            end
            local ____opt_result_1193
            if ____opt_1191 ~= nil then
                ____opt_result_1193 = ____opt_1191(____opt_1191)
            end
            ____t_result_1194 = ____opt_result_1193
        end
        return not not ____t_1195(____t_result_1194)
    end
    __L1.ocupado = function()
        local ____t_result_1209
        local ____t_1205 = __t
        local ____t_result_1204
        local ____t_1197 = __t
        local ____temp_1196 = __L1:coberto()
        __O[1044] = ____temp_1196
        if ____t_1197(____temp_1196) then
            ____t_result_1204 = __O[1044]
        else
            local ____t_1203 = __t
            local ____opt_1200 = window.CampanhaMoradores
            if ____opt_1200 ~= nil then
                ____opt_1200 = ____opt_1200.aberto
            end
            local ____opt_result_1202
            if ____opt_1200 ~= nil then
                ____opt_result_1202 = ____opt_1200(____opt_1200)
            end
            ____t_result_1204 = not not ____t_1203(____opt_result_1202)
        end
        __O[1045] = ____t_result_1204
        if ____t_1205(____t_result_1204) then
            ____t_result_1209 = __O[1045]
        else
            local ____t_1208 = __t
            local ____opt_1206 = __L1.box
            if ____opt_1206 ~= nil then
                ____opt_1206 = ____opt_1206:querySelector(".escolha")
            end
            ____t_result_1209 = not not ____t_1208(____opt_1206)
        end
        return ____t_result_1209
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
                local ____self_1213 = window.JSON
                local ____self_1213_parse_1214 = ____self_1213.parse
                local ____t_result_1212
                local ____t_1211 = __t
                local ____temp_1210 = window.localStorage:getItem(__L1.SAVE1)
                __O[1058] = ____temp_1210
                if ____t_1211(____temp_1210) then
                    ____t_result_1212 = __O[1058]
                else
                    ____t_result_1212 = "null"
                end
                return true, ____self_1213_parse_1214(____self_1213, ____t_result_1212)
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
        local ____t_result_1221
        local ____t_1220 = __t
        local ____opt_1217 = __L1:TR()
        if ____opt_1217 ~= nil then
            ____opt_1217 = ____opt_1217.bonus
        end
        local ____opt_result_1219
        if ____opt_1217 ~= nil then
            ____opt_result_1219 = ____opt_1217(____opt_1217).maxHP
        end
        __O[1061] = ____opt_result_1219
        if ____t_1220(____opt_result_1219) then
            ____t_result_1221 = __O[1061]
        else
            ____t_result_1221 = 100
        end
        local ____t_result_1228
        local ____t_1227 = __t
        local ____opt_1224 = window.CampanhaAliados
        if ____opt_1224 ~= nil then
            ____opt_1224 = ____opt_1224.vidaMax
        end
        local ____opt_result_1226
        if ____opt_1224 ~= nil then
            ____opt_result_1226 = ____opt_1224(____opt_1224)
        end
        __O[1062] = ____opt_result_1226
        if ____t_1227(____opt_result_1226) then
            ____t_result_1228 = __O[1062]
        else
            ____t_result_1228 = 100
        end
        return math.floor(____t_result_1221 * (____t_result_1228 / 100) + 0.5)
    end
    window:addEventListener(
        "c2-atributo",
        function()
            if not __t(__L1.aberto) then
                return
            end
            local ____t_result_1229
            if __t(__L1.P.max) then
                ____t_result_1229 = __L1.P.max
            else
                ____t_result_1229 = 100
            end
            local antes = ____t_result_1229
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
        local ____t_1231 = __t
        local ____t_result_1230
        if __t(e) then
            ____t_result_1230 = e.textContent ~= v
        else
            ____t_result_1230 = e
        end
        if ____t_1231(____t_result_1230) then
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
                local ____opt_1232 = __L1.S
                if ____opt_1232 ~= nil then
                    ____opt_1232 = ____opt_1232.passo
                end
                local ____L1_cenaId_1266 = __L1.cenaId
                local ____math_floor_result_1267 = math.floor(__L1.P.x + 0.5)
                local ____math_floor_result_1268 = math.floor(__L1.P.y + 0.5)
                local ____t_result_1237
                local ____t_1236 = __t
                local ____opt_1234 = __L1.perto
                if ____opt_1234 ~= nil then
                    ____opt_1234 = ____opt_1234.rotulo
                end
                __O[1083] = ____opt_1234
                if ____t_1236(____opt_1234) then
                    ____t_result_1237 = __O[1083]
                else
                    ____t_result_1237 = nil
                end
                local ____t_result_1241
                local ____t_1240 = __t
                local ____opt_1238 = __L1.cut
                if ____opt_1238 ~= nil then
                    ____opt_1238 = ____opt_1238.id
                end
                __O[1084] = ____opt_1238
                if ____t_1240(____opt_1238) then
                    ____t_result_1241 = __O[1084]
                else
                    ____t_result_1241 = nil
                end
                local ____t_result_1248
                local ____t_1247 = __t
                local ____opt_1244 = __L1.fase
                if ____opt_1244 ~= nil then
                    ____opt_1244 = ____opt_1244.emArena
                end
                local ____opt_result_1246
                if ____opt_1244 ~= nil then
                    ____opt_result_1246 = ____opt_1244(____opt_1244)
                end
                if ____t_1247(____opt_result_1246) then
                    ____t_result_1248 = __L1.fase.slug
                else
                    ____t_result_1248 = nil
                end
                local ____t_result_1259
                local ____t_1258 = __t
                local ____t_result_1257
                local ____t_1251 = __t
                local ____opt_1249 = __L1:D()
                if ____opt_1249 ~= nil then
                    ____opt_1249 = ____opt_1249.key
                end
                __O[1085] = ____opt_1249
                if ____t_1251(____opt_1249) then
                    ____t_result_1257 = __O[1085]
                else
                    local ____callq_1256 = __callq
                    local ____opt_1254 = window.CampanhaCenarios
                    if ____opt_1254 ~= nil then
                        ____opt_1254 = ____opt_1254.lista
                    end
                    local ____opt_1252 = ____callq_1256(
                        ____opt_1254,
                        "find",
                        function(____, d) return d.id == __L1.cenaId end
                    )
                    if ____opt_1252 ~= nil then
                        ____opt_1252 = ____opt_1252.key
                    end
                    ____t_result_1257 = ____opt_1252
                end
                __O[1086] = ____t_result_1257
                if ____t_1258(____t_result_1257) then
                    ____t_result_1259 = __O[1086]
                else
                    ____t_result_1259 = nil
                end
                local ____assign_1265 = __assign
                local ____temp_1264 = {}
                local ____t_result_1263
                local ____t_1262 = __t
                local ____opt_1260 = __L1.S
                if ____opt_1260 ~= nil then
                    ____opt_1260 = ____opt_1260.flags
                end
                __O[1087] = ____opt_1260
                if ____t_1262(____opt_1260) then
                    ____t_result_1263 = __O[1087]
                else
                    ____t_result_1263 = {}
                end
                return {
                    passo = ____opt_1232,
                    cena = ____L1_cenaId_1266,
                    x = ____math_floor_result_1267,
                    y = ____math_floor_result_1268,
                    perto = ____t_result_1237,
                    cutscene = ____t_result_1241,
                    luta = ____t_result_1248,
                    chave = ____t_result_1259,
                    flags = ____assign_1265(____temp_1264, ____t_result_1263)
                }
            end,
            _ir = function(____, id, x) return __L1:irPara(id, x) end,
            _fase = function()
                local ____t_result_1269
                if __t(__L1.fase) then
                    ____t_result_1269 = {
                        slug = __L1.fase.slug,
                        chefe = {
                            st = __L1.fase.chefe.st,
                            hp = __L1.fase.chefe.hp,
                            fase = __L1.fase.chefe.fase,
                            x = math.floor(__L1.fase.chefe.x + 0.5)
                        },
                        arena = __L1.fase:emArena(),
                        inimigos = __len(__L1.fase:inimigos())
                    }
                else
                    ____t_result_1269 = __L1.fase
                end
                return ____t_result_1269
            end,
            _hp = function(____, n)
                __L1.P.hp = n
            end,
            _bater = function(____, n)
                local f = __L1.fase
                local ____t_1273 = __t
                local ____opt_result_1272
                if f ~= nil then
                    ____opt_result_1272 = f.chefe
                end
                if ____t_1273(____opt_result_1272) then
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
