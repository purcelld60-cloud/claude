--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __isInteger, __getq, __ord, __arrL, __iterar, __t, __get, __len, __call, __add, __values, __assign = __JSR.__isInteger, __JSR.__getq, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__values, __JSR.__assign
local __isArray = __JSR.__isArray
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local __TS__Iterator = ____lualib.__TS__Iterator
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local sceneNames = __arrL({
        "A roça",
        "Colégio Adventista",
        "Academia do Caleb",
        "A quadra",
        "Praça Camacan",
        "Favela do Reeis",
        "Caderno do Caos",
        "Campo do Mota",
        "Bigodon",
        "Pátio da escola",
        "Casa de Rayssa",
        "Baile funk"
    }, 12)
    local chapters = __arrL(
        {
            __ord({
                id = "carro",
                flag = "lucas",
                scene = 0,
                title = "O carro do pai",
                description = "Busque três peças nos parkours da roça e leve tudo a Lucas para consertar o carro a gás."
            }, "id,flag,scene,title,description"),
            __ord({
                id = "futebol",
                flag = "mota",
                scene = 7,
                title = "Treino de craque",
                description = "Conheça Gabriel Mota no campo. Vença o desafio de futebol, ganhe experiência e libere o dash."
            }, "id,flag,scene,title,description"),
            __ord({
                id = "jantar-amanda",
                flag = "amandaDating",
                scene = 4,
                title = "Uma mesa para dois",
                description = "Encontre Amanda perto da entrada da Praça Camacan. Aceite o convite para jantar e encontre o seu ritmo à mesa."
            }, "id,flag,scene,title,description"),
            __ord({
                id = "cadernos",
                flag = "almiro",
                scene = 1,
                title = "Operação caderno",
                description = "Ajude Almiro a recuperar três cadernos nos corredores e plataformas do colégio."
            }, "id,flag,scene,title,description"),
            __ord({
                id = "english",
                flag = "miqueias",
                scene = 1,
                title = "English da resenha",
                description = "Entre na sala de Miqueias e passe pelo desafio de inglês para despertar as bolinhas elementais."
            }, "id,flag,scene,title,description"),
            __ord({
                id = "braco-forte",
                flag = "freddy",
                scene = 5,
                title = "O braço forte do Reeis",
                description = "Suba a favela e desafie Freddy no pátio antes do rei. O capanga mais forte ainda tira onda do próprio chefe."
            }, "id,flag,scene,title,description"),
            __ord({
                id = "rei-do-morro",
                flag = "reeis",
                scene = 5,
                title = "O rei do morro",
                description = "Atravesse os encontros da favela, enfrente Reeis e peça sua ajuda para resgatar o bolo."
            }, "id,flag,scene,title,description"),
            __ord({
                id = "desenhista",
                flag = "marco",
                scene = 1,
                title = "Rabiscos perigosos",
                description = "Volte ao colégio e enfrente Marco. Cuidado com a armadilha SARUÊ e a fúria vermelha."
            }, "id,flag,scene,title,description"),
            __ord({
                id = "monstro-gigante",
                flag = "giant",
                scene = 6,
                title = "O desenho ficou enorme",
                description = "Explore o Caderno do Caos e derrote o monstro gigante que Marco criou."
            }, "id,flag,scene,title,description"),
            __ord({
                id = "provocacao",
                flag = "menezes",
                scene = 1,
                title = "O palco da provocação",
                description = "Volte ao fim da escola para a luta contra Menezes, suas paredes de palavras e ondas de provocação."
            }, "id,flag,scene,title,description"),
            __ord({
                id = "shape",
                flag = "trained",
                scene = 2,
                title = "O treino do bolo",
                description = "Complete o treino de reflexo de Caleb para ficar bombado e preparar a luta final."
            }, "id,flag,scene,title,description"),
            __ord({
                id = "amizade-bolo",
                flag = "nikolas",
                scene = 3,
                title = "Um amigo e um bolo",
                description = "Leve o carro até a quadra, enfrente Nikolas e decida o futuro dessa amizade."
            }, "id,flag,scene,title,description")
        },
        12
    )
    local ____ord_4 = __ord
    local ____assign_3 = __assign
    local ____temp_2 = {}
    local ____opt_0 = window.WorldData
    if ____opt_0 ~= nil then
        ____opt_0 = ____opt_0.npcEntries
    end
    local npcEntries = ____ord_4(
        ____assign_3(
            ____temp_2,
            ____opt_0,
            {
                ollyan = __ord({name = "Ollyan · Orelhas ao Vento", scene = 11, x = 3260, y = 440}, "name,scene,x,y"),
                mota = __ord({name = "Gabriel Mota · craque", scene = 7, x = 500}, "name,scene,x"),
                davi = __ord({name = "Davi Costa · barbeiro", scene = 8, x = 520}, "name,scene,x"),
                vitor = __ord({name = "Vitor · ajudante", scene = 8, x = 850}, "name,scene,x"),
                freddy = __ord({name = "Freddy · braço forte do Reeis", scene = 5, x = 5680}, "name,scene,x"),
                nicolas = __ord({name = "Nicolas Carvalho", scene = 4, x = 5350}, "name,scene,x"),
                aica = __ord({name = "Aica", scene = 9, x = 500}, "name,scene,x"),
                ravile = __ord({name = "Ravile", scene = 9, x = 670}, "name,scene,x"),
                arthur = __ord({name = "Arthur", scene = 9, x = 2850}, "name,scene,x"),
                dede = __ord({name = "Dedé · capanga do Reeis", scene = 5, x = 5000}, "name,scene,x"),
                allef = __ord({name = "Allef · recepção da Bigodon", scene = 8, x = 240}, "name,scene,x"),
                eloisa = __ord({name = "Eloisa", scene = 10, x = 450}, "name,scene,x"),
                giselle = __ord({name = "Giselle", scene = 10, x = 820}, "name,scene,x"),
                rayssa = __ord({name = "Rayssa", scene = 10, x = 1220}, "name,scene,x"),
                analaura = __ord({name = "Ana Laura", scene = 10, x = 1580}, "name,scene,x")
            }
        ),
        "ollyan,mota,davi,vitor,freddy,nicolas,aica,ravile,arthur,dede,allef,eloisa,giselle,rayssa,analaura"
    )
    local sideQuests = __arrL(
        {
            __ord({
                id = "bigodon",
                flag = "bigodon",
                scene = 8,
                title = "Na régua da resenha",
                description = "Visite a Bigodon e converse com Davi Costa para dar uma pausa na aventura e recuperar o fôlego."
            }, "id,flag,scene,title,description"),
            __ord({
                id = "ajudante-bigodon",
                flag = "vitor",
                scene = 8,
                title = "O fiscal do degradê",
                description = "Conheça Vitor, o ajudante de óculos da Bigodon. Até conferir o corte rende uma boa resenha."
            }, "id,flag,scene,title,description"),
            __ord({
                id = "aura-suprema",
                flag = "nicolas",
                scene = 4,
                title = "O protagonista de Camacan",
                description = "Treine o dash com Mota e desafie Nicolas Carvalho no fim da praça. A aura suprema dele esconde uma surpresa."
            }, "id,flag,scene,title,description"),
            __ord({
                id = "ajuda-patio",
                flag = "arthur",
                scene = 9,
                title = "Ajuda no pátio",
                description = "Converse com Ravile e Aica no Pátio da escola. Arthur puxou o cabelo de Ravile; ajude a encerrar essa confusão."
            }, "id,flag,scene,title,description"),
            __ord({
                id = "fumaca-beco",
                flag = "dede",
                scene = 5,
                title = "Fumaça no beco",
                description = "Na favela, encontre Dedé antes da arena de Freddy e desfaça suas cortinas de fumaça. O confronto é opcional."
            }, "id,flag,scene,title,description"),
            __ord({
                id = "resenha-rayssa",
                flag = "rayssaVisit",
                scene = 10,
                title = "Aff, veyr, juro",
                description = "Visite a Casa de Rayssa para conhecer Eloisa, Giselle, Rayssa e Ana Laura. Uma primeira conversa conclui a visita; depois, volte para novas resenhas."
            }, "id,flag,scene,title,description"),
            __ord({
                id = "bivolt-rayssa",
                flag = "bivoltUnlocked",
                scene = 10,
                title = "Energia da resenha",
                description = "Converse com as garotas na Casa de Rayssa. Encontre os três ingredientes nas prateleiras e devolva tudo para liberar o energético Bivolt: dez segundos de atributos turbinados."
            }, "id,flag,scene,title,description"),
            __ord({
                id = "baile-ollyan",
                flag = "ollyan",
                scene = 11,
                title = "Orelhas ao vento",
                description = "Vá ao baile noturno com o carro a gás consertado. Ollyan perdeu o compasso; prepare-se para uma perseguição aérea de três fases. Nível 8 sugerido."
            }, "id,flag,scene,title,description")
        },
        8
    )
    local function ok()
        return {ok = true, reason = ""}
    end
    local function no(____, reason)
        return {ok = false, reason = reason}
    end
    local function has(self, q, key)
        return not not __t(__getq(q, key))
    end
    local function canTravel(self, scene, q)
        if q == nil then
            q = {}
        end
        local n = __TS__Number(scene)
        local ____t_10 = __t
        local ____opt_7 = window.LugaresC1
        if ____opt_7 ~= nil then
            ____opt_7 = ____opt_7.tem
        end
        local ____opt_result_9
        if ____opt_7 ~= nil then
            ____opt_result_9 = ____opt_7(____opt_7, n)
        end
        if ____t_10(____opt_result_9) then
            local ____t_result_11
            if __t(has(nil, q, "lucas")) then
                ____t_result_11 = ok(nil)
            else
                ____t_result_11 = no(nil, "O carro está quebrado! Colete as três peças na roça e entregue a Lucas.")
            end
            return ____t_result_11
        end
        local ____t_15 = __t
        local ____t_result_14
        local ____t_13 = __t
        local ____temp_12 = not __isInteger(n) or n < 0
        __O[33] = ____temp_12
        if ____t_13(____temp_12) then
            ____t_result_14 = __O[33]
        else
            ____t_result_14 = n >= __len(sceneNames)
        end
        if ____t_15(____t_result_14) then
            return no(nil, "Essa rota ainda não existe.")
        end
        if n == 0 then
            return ok(nil)
        end
        if not __t(has(nil, q, "lucas")) then
            return no(nil, "O carro está quebrado! Colete as três peças na roça e entregue a Lucas.")
        end
        if __t(__call(
            __arrL({
                1,
                4,
                7,
                8,
                9,
                10,
                11
            }, 7),
            "includes",
            n
        )) then
            return ok(nil)
        end
        if n == 5 then
            if not __t(has(nil, q, "mota")) then
                return no(nil, "Treine futebol com Mota para liberar o dash antes de subir o morro.")
            end
            if not __t(has(nil, q, "almiro")) then
                return no(nil, "Ajude Almiro com os três cadernos na primeira sala do colégio.")
            end
            if not __t(has(nil, q, "miqueias")) then
                return no(nil, "Complete o English da resenha com Miqueias na segunda sala.")
            end
            return ok(nil)
        end
        if n == 6 then
            local ____t_result_16
            if __t(has(nil, q, "marco")) then
                ____t_result_16 = ok(nil)
            else
                ____t_result_16 = no(nil, "Enfrente Marco no colégio para descobrir a entrada do Caderno do Caos.")
            end
            return ____t_result_16
        end
        if n == 2 then
            local ____t_result_17
            if __t(has(nil, q, "menezes")) then
                ____t_result_17 = ok(nil)
            else
                ____t_result_17 = no(nil, "Resolva a provocação de Menezes no fim do colégio antes do treino com Caleb.")
            end
            return ____t_result_17
        end
        if n == 3 then
            if not __t(has(nil, q, "giant")) then
                return no(nil, "O monstro gigante do Caderno do Caos ainda está solto!")
            end
            if not __t(has(nil, q, "menezes")) then
                return no(nil, "Derrote Menezes no fim do colégio antes de buscar Nikolas.")
            end
            if not __t(has(nil, q, "trained")) then
                return no(nil, "Caleb precisa terminar seu treino de reflexo na academia.")
            end
            if __t(not __t(q.amandaDating) and not __t(q.nikolas)) then
                return no(nil, "Antes da final, encontre Amanda na entrada da Praça Camacan e conclua o jantar.")
            end
            return ok(nil)
        end
        return ok(nil)
    end
    local function bossRequirement(self, ____type, q)
        if q == nil then
            q = {}
        end
        if ____type == "ollyan" then
            local ____t_result_18
            if __t(has(nil, q, "lucas")) then
                ____t_result_18 = ok(nil)
            else
                ____t_result_18 = no(nil, "Conserte o carro a gás com Lucas antes de perseguir Ollyan no céu.")
            end
            return ____t_result_18
        end
        if ____type == "arthur" then
            local ____t_result_19
            if __t(has(nil, q, "patioAccepted")) then
                ____t_result_19 = ok(nil)
            else
                ____t_result_19 = no(nil, "Converse com Ravile ou Aica na entrada do Pátio da escola para entender a confusão antes de enfrentar Arthur.")
            end
            return ____t_result_19
        end
        if ____type == "dede" then
            if not __t(has(nil, q, "mota")) then
                return no(nil, "Treine o dash com Mota antes de enfrentar a fumaça de Dedé.")
            end
            if __t(not __t(has(nil, q, "almiro")) or not __t(has(nil, q, "miqueias"))) then
                return no(nil, "Complete as missões dos professores para subir a favela e encarar Dedé.")
            end
            return ok(nil)
        end
        if ____type == "nicolas" then
            local ____t_result_20
            if __t(has(nil, q, "mota")) then
                ____t_result_20 = ok(nil)
            else
                ____t_result_20 = no(nil, "Aprenda o dash com Mota no campo de futebol antes de desafiar a aura suprema de Nicolas na Praça Camacan.")
            end
            return ____t_result_20
        end
        if ____type == "freddy" then
            if not __t(has(nil, q, "mota")) then
                return no(nil, "Treine o dash com Mota antes de enfrentar Freddy, o capanga mais forte do Reeis.")
            end
            if __t(not __t(has(nil, q, "almiro")) or not __t(has(nil, q, "miqueias"))) then
                return no(nil, "Complete as missões de Almiro e Miqueias no colégio antes de desafiar Freddy na favela.")
            end
            return ok(nil)
        end
        if __t(____type == "reeisBoss" or ____type == "reeis") then
            if not __t(has(nil, q, "mota")) then
                return no(nil, "Mota precisa ensinar o dash. Procure o craque no campo de futebol.")
            end
            if __t(not __t(has(nil, q, "almiro")) or not __t(has(nil, q, "miqueias"))) then
                return no(nil, "Termine as missões dos dois professores antes de enfrentar o rei do morro.")
            end
            if __t(not __t(has(nil, q, "reeis")) and not __t(has(nil, q, "freddy"))) then
                return no(nil, "Freddy guarda o caminho do rei. Vença o capanga mais forte no pátio anterior, antes de desafiar Reeis.")
            end
            return ok(nil)
        end
        if ____type == "marco" then
            if __t(not __t(has(nil, q, "almiro")) or not __t(has(nil, q, "miqueias"))) then
                return no(nil, "Ajude Almiro e Miqueias para preparar seus poderes contra Marco.")
            end
            if not __t(has(nil, q, "reeis")) then
                return no(nil, "Primeiro atravesse a favela e convença Reeis a ajudar na busca pelo bolo.")
            end
            return ok(nil)
        end
        if ____type == "giant" then
            local ____t_result_21
            if __t(has(nil, q, "marco")) then
                ____t_result_21 = ok(nil)
            else
                ____t_result_21 = no(nil, "Derrote Marco para entrar no desafio do monstro gigante.")
            end
            return ____t_result_21
        end
        if ____type == "menezes" then
            if not __t(has(nil, q, "marco")) then
                return no(nil, "Marco ainda está espalhando rabiscos no colégio. Enfrente ele primeiro.")
            end
            if not __t(has(nil, q, "giant")) then
                return no(nil, "O monstro gigante bloqueia a conclusão da missão! Vá ao Caderno do Caos.")
            end
            if __t(not __t(has(nil, q, "almiro")) or not __t(has(nil, q, "miqueias"))) then
                return no(nil, "Complete as duas missões dos professores antes da provocação final.")
            end
            return ok(nil)
        end
        if ____type == "nikolas" then
            return canTravel(nil, 3, q)
        end
        return ok(nil)
    end
    local function count(____, value, fallback)
        if fallback == nil then
            fallback = 0
        end
        local ____isArray_result_23
        if __isArray(value) then
            ____isArray_result_23 = __TS__New(Set, value).size
        else
            local ____temp_22
            if type(value) == "number" then
                ____temp_22 = math.max(
                    0,
                    math.floor(value)
                )
            else
                ____temp_22 = fallback
            end
            ____isArray_result_23 = ____temp_22
        end
        return ____isArray_result_23
    end
    local function currentQuest(self, q, extra)
        if q == nil then
            q = {}
        end
        if extra == nil then
            extra = {}
        end
        if not __t(q.lucas) then
            local parts = math.min(
                3,
                count(
                    nil,
                    q.carParts,
                    count(nil, extra.carParts)
                )
            )
            local ____temp_25
            if not __t(q.carMissionAccepted) then
                ____temp_25 = __arrL({"O carro não pega", "Fale com Lucas na roça. O carro a gás do seu pai precisa de três peças para voltar à aventura."}, 2)
            else
                local ____temp_24
                if parts < 3 then
                    ____temp_24 = __arrL(
                        {
                            "Peças pela roça",
                            tostring(parts) .. "/3 peças encontradas. Atravesse os parkours do pomar, da trilha alta e do riacho. Depois volte a Lucas."
                        },
                        2
                    )
                else
                    ____temp_24 = __arrL({"Chave na mão, gás no motor", "As três peças estão com você! Volte a Lucas na roça e conserte o carro a gás."}, 2)
                end
                ____temp_25 = ____temp_24
            end
            return ____temp_25
        end
        if not __t(q.mota) then
            return __arrL({"Mota, o craque da escola", "Entre no carro e vá ao Campo do Mota. Vença o treino de futebol para ganhar XP e liberar o dash."}, 2)
        end
        if __t(not __t(q.amandaDating) and not __t(q.nikolas)) then
            return __arrL(
                {
                    "Uma mesa para dois",
                    __t(q.amandaInvited) and "Amanda guardou a mesa. Volte à entrada da Praça Camacan para retomar o convite." or "Amanda espera perto da entrada da Praça Camacan. Vá de carro e fale com ela para jantar."
                },
                2
            )
        end
        if not __t(q.almiro) then
            local books = math.min(
                3,
                count(
                    nil,
                    q.notebooks,
                    count(nil, extra.notebooks)
                )
            )
            if books >= 3 then
                return __arrL({"Cadernos recuperados", "Volte à primeira sala do colégio e entregue os três cadernos ao professor Almiro."}, 2)
            end
            local ____temp_26
            if not __t(q.almiroAccepted) then
                ____temp_26 = __arrL({"Uma missão com Almiro", "No Colégio Adventista, entre na primeira sala com E e converse com Almiro."}, 2)
            else
                ____temp_26 = __arrL(
                    {
                        "Operação caderno",
                        tostring(books) .. "/3 cadernos recuperados. Explore as plataformas e corredores antes de Marco; devolva tudo na sala de Almiro."
                    },
                    2
                )
            end
            return ____temp_26
        end
        if not __t(q.miqueias) then
            return __arrL({"ALLRIGHT! Hora do English", "Entre na segunda sala do colégio e faça o desafio de Miqueias. Ele vai liberar seu poder elemental."}, 2)
        end
        if __t(not __t(q.reeis) and not __t(q.freddy)) then
            return __arrL({"Freddy segura a passagem", "Suba a Favela do Reeis e desafie Freddy no pátio antes do rei. O braço forte do chefe também é o primeiro a gritar REEEIS!"}, 2)
        end
        if not __t(q.reeis) then
            return __arrL({"Um reforço no alto do morro", "Use o carro para chegar à Favela do Reeis. Os inimigos ficam mais fortes no caminho; vença Reeis para pedir sua ajuda."}, 2)
        end
        if not __t(q.marco) then
            return __arrL({"O desenhista do caos", "Volte ao Colégio Adventista, atravesse os rabiscos e enfrente Marco. Pisar em SARUÊ desperta sua fúria vermelha!"}, 2)
        end
        if not __t(q.giant) then
            return __arrL({"Um monstro de outro tamanho", "Entre no carro e vá ao Caderno do Caos. No fim do caminho, enfrente o monstro gigante desenhado por Marco."}, 2)
        end
        if not __t(q.menezes) then
            return __arrL({"A provocação tem endereço", "Volte ao final do colégio e enfrente Menezes. Pule as ondas, desvie dos ecos e encontre as brechas nas paredes de palavras."}, 2)
        end
        if not __t(q.trained) then
            return __arrL(
                {
                    "Caleb vai cobrar esse treino",
                    __t(q.training) and "Retome o treino na academia: acerte o marcador na faixa verde em três rodadas para ganhar seu novo shape." or "Vá à academia e converse com Caleb. O treino de reflexo vai deixar Da Roça bombado para o confronto final."
                },
                2
            )
        end
        if not __t(q.nikolas) then
            return __arrL({"O último pedaço do bolo", "A quadra está liberada. Entre no carro, enfrente Nikolas e use o que aprendeu: dash, combos, bolinhas elementais e OHHHH REEEEIS!"}, 2)
        end
        if __t(q.jorgeSeen) then
            return __arrL({"Uma ligação. Um novo capítulo.", "JORGE ligou. O próximo capítulo aguarda uma nova atualização. Enquanto isso, explore os doze lugares, visite a Casa de Rayssa e reencontre a turma."}, 2)
        end
        return __arrL({"O bolo e a resenha voltaram", "O bolo voltou e o açaí de quarta-feira está garantido. Explore os doze lugares e visite a Casa de Rayssa; depois da festa, uma ligação muda a resenha."}, 2)
    end
    local function chapterDone(self, c, q)
        local ____t_result_29
        local ____t_28 = __t
        local ____temp_27 = not not __t(__get(q, c.flag))
        __O[34] = ____temp_27
        if ____t_28(____temp_27) then
            ____t_result_29 = __O[34]
        else
            ____t_result_29 = c.flag == "freddy" and not not __t(q.reeis)
        end
        return ____t_result_29
    end
    local function chapterState(self, q)
        if q == nil then
            q = {}
        end
        return __call(
            chapters,
            "map",
            function(____, c, index)
                local ____assign_37 = __assign
                local ____temp_35 = {}
                local ____c_36 = c
                local ____temp_33 = index + 1
                local ____chapterDone_result_34 = chapterDone(nil, c, q)
                local ____t_result_32
                local ____t_31 = __t
                local ____temp_30 = c.flag == "amandaDating" and not not __t(q.nikolas)
                __O[35] = ____temp_30
                if ____t_31(____temp_30) then
                    ____t_result_32 = not __t(q.amandaDating)
                else
                    ____t_result_32 = __O[35]
                end
                return ____assign_37(____temp_35, ____c_36, {index = ____temp_33, complete = ____chapterDone_result_34, epilogue = ____t_result_32})
            end
        )
    end
    local function sideQuestState(self, q)
        if q == nil then
            q = {}
        end
        local rows = __call(
            sideQuests,
            "map",
            function(____, c)
                local ____assign_46 = __assign
                local ____array_45 = __TS__SparseArrayNew(
                    {},
                    c,
                    {complete = not not __t(__get(q, c.flag))}
                )
                local ____t_result_44
                local ____t_43 = __t
                local ____t_result_42
                local ____t_41 = __t
                local ____t_result_40
                local ____t_39 = __t
                local ____temp_38 = c.flag == "arthur"
                __O[36] = ____temp_38
                if ____t_39(____temp_38) then
                    ____t_result_40 = q.patioAccepted
                else
                    ____t_result_40 = __O[36]
                end
                __O[37] = ____t_result_40
                if ____t_41(____t_result_40) then
                    ____t_result_42 = not __t(q.arthur)
                else
                    ____t_result_42 = __O[37]
                end
                if ____t_43(____t_result_42) then
                    ____t_result_44 = {description = "Ravile e Aica pediram ajuda. Encontre Arthur no fim do pátio e encerre a confusão sem puxar o cabelo de ninguém."}
                else
                    ____t_result_44 = {}
                end
                __TS__SparseArrayPush(____array_45, ____t_result_44)
                return ____assign_46(__TS__SparseArraySpread(____array_45))
            end
        )
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({"zefa", 0, "O pedido de Dona Zefa", "Fale com Dona Zefa, resolva a bomba do pomar, confira o caixote de frutas e volte à quitanda."}, 4),
                __arrL({"tonico", 8, "Circuito limpo, praça acesa", "Converse com Seu Tonico na Bigodon. Conserte as luzes da Camacan, complete a coleta do pátio e volte para receber seus materiais."}, 4)
            },
            2
        ))) do
            local id = ____value[1]
            local scene = ____value[2]
            local title = ____value[3]
            local description = ____value[4]
            local ____call_57 = __call
            local ____add_result_53 = __add("vida-", id)
            local ____scene_54 = scene
            local ____title_55 = title
            local ____description_56 = description
            local ____t_52 = __t
            local ____getq_51 = __getq
            local ____opt_49 = q.worldLife
            if ____opt_49 ~= nil then
                ____opt_49 = ____opt_49.quests
            end
            local ____opt_47 = ____getq_51(____opt_49, id)
            if ____opt_47 ~= nil then
                ____opt_47 = ____opt_47.done
            end
            ____call_57(
                rows,
                "push",
                {
                    id = ____add_result_53,
                    scene = ____scene_54,
                    title = ____title_55,
                    description = ____description_56,
                    complete = not not ____t_52(____opt_47)
                }
            )
        end
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({"pump-roca", 0, "Água para o pomar"}, 3),
                __arrL({"sort-school", 1, "Coleta no corredor"}, 3),
                __arrL({"switch-camacan", 4, "Acenda a Praça Camacan"}, 3),
                __arrL({"pump-campo", 7, "Bolas no ponto"}, 3),
                __arrL({"sort-patio", 9, "Mutirão do recreio"}, 3),
                __arrL({"switch-baile", 11, "Luzes para o show"}, 3)
            },
            6
        ))) do
            local id = ____value[1]
            local scene = ____value[2]
            local title = ____value[3]
            local ____call_65 = __call
            local ____add_result_62 = __add("vida-", id)
            local ____scene_63 = scene
            local ____title_64 = title
            local ____t_61 = __t
            local ____getq_60 = __getq
            local ____opt_58 = q.worldLife
            if ____opt_58 ~= nil then
                ____opt_58 = ____opt_58.completed
            end
            ____call_65(
                rows,
                "push",
                {
                    id = ____add_result_62,
                    scene = ____scene_63,
                    title = ____title_64,
                    description = "Encontre o objeto com este nome e complete o desafio. A primeira vitória dá XP e materiais; depois, pratique para melhorar seu recorde.",
                    complete = not not ____t_61(____getq_60(____opt_58, id))
                }
            )
        end
        return rows
    end
    local function completion(self, q)
        if q == nil then
            q = {}
        end
        local story = __call(
            chapterState(nil, q),
            "filter",
            function(____, c) return not __t(c.epilogue) end
        )
        return math.floor(__len(__call(
            story,
            "filter",
            function(____, c) return c.complete end
        )) / __len(story) * 100 + 0.5)
    end
    local rewards = __ord({
        amanda = 160,
        repair = 180,
        football = 220,
        footballReplay = 70,
        almiro = 240,
        miqueias = 240,
        bigodon = 120,
        vitor = 60,
        freddy = 420,
        nicolas = 700,
        arthur = 450,
        dede = 340,
        reeisBoss = 550,
        marco = 480,
        giant = 800,
        menezes = 600,
        training = 300,
        nikolas = 1000,
        rayssaVisit = 90,
        bivoltUnlocked = 180,
        ollyan = 700
    }, "amanda,repair,football,footballReplay,almiro,miqueias,bigodon,vitor,freddy,nicolas,arthur,dede,reeisBoss,marco,giant,menezes,training,nikolas,rayssaVisit,bivoltUnlocked,ollyan")
    local data = __ord(
        {
            version = "3.4.0",
            sceneNames = sceneNames,
            chapters = chapters,
            sideQuests = sideQuests,
            npcEntries = npcEntries,
            rewards = rewards,
            canTravel = canTravel,
            bossRequirement = bossRequirement,
            currentQuest = currentQuest,
            chapterState = chapterState,
            sideQuestState = sideQuestState,
            completion = completion,
            repairParts = __arrL({"fan", "pipe", "spark"}, 3),
            notebookIds = __arrL({"caderno-01", "caderno-02", "caderno-03"}, 3)
        },
        "version,sceneNames,chapters,sideQuests,npcEntries,rewards,canTravel,bossRequirement,currentQuest,chapterState,sideQuestState,completion,repairParts,notebookIds"
    )
    local function freeze(self, o)
        local ____t_67 = __t
        local ____t_result_66
        if __t(o) then
            ____t_result_66 = type(o) == "table"
        else
            ____t_result_66 = o
        end
        if ____t_67(____t_result_66) then
            __call(
                __values(o),
                "forEach",
                freeze
            )
            local ____ = o
        end
        return o
    end
    window.Campaign = freeze(nil, data)
end)(nil)
return ____exports
