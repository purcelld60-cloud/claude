--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __gt, __ge, __ord, __arrL, __iterar, __t, __get, __len, __call, __add, __new = __JSR.__lt, __JSR.__gt, __JSR.__ge, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__new
local __re, __re_test = __JSR.__re, __JSR.__re_test
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__ParseFloat = ____lualib.__TS__ParseFloat
local __TS__AsyncAwaiter = ____lualib.__TS__AsyncAwaiter
local __TS__Await = ____lualib.__TS__Await
local __TS__Number = ____lualib.__TS__Number
local __TS__Iterator = ____lualib.__TS__Iterator
local ____exports = {}
local __O = {};
(function()
    local updateJournal, shell, journalSignature
    function updateJournal(self)
        if __t(not __t(window.Campaign) or not __t(window.Game)) then
            return
        end
        local q = window.Game:getState().q
        local rows = window.Campaign:chapterState(q)
        local ____t_result_280
        local ____t_279 = __t
        local ____this_278
        ____this_278 = window.Campaign
        local ____opt_277 = ____this_278.sideQuestState
        if ____opt_277 ~= nil then
            ____opt_277 = ____opt_277(____this_278, q)
        end
        __O[2305] = ____opt_277
        if ____t_279(____opt_277) then
            ____t_result_280 = __O[2305]
        else
            ____t_result_280 = __arrL({}, 0)
        end
        local sideRows = ____t_result_280
        local signature = __add(
            __add(
                __call(
                    __call(
                        rows,
                        "map",
                        function(____, r) return __t(r.complete) and "1" or "0" end
                    ),
                    "join",
                    ""
                ),
                "|"
            ),
            __call(
                __call(
                    sideRows,
                    "map",
                    function(____, r) return __t(r.complete) and "1" or "0" end
                ),
                "join",
                ""
            )
        )
        if signature == journalSignature then
            return
        end
        journalSignature = signature
        local story = __call(
            rows,
            "filter",
            function(____, r) return not __t(r.epilogue) end
        )
        local current = __call(
            story,
            "find",
            function(____, r) return not __t(r.complete) end
        )
        local list = window.document:getElementById("campaignSteps")
        list:replaceChildren()
        for ____, row in __iterar((rows)) do
            local li = window.document:createElement("li")
            local ____t_result_285
            if __t(row.complete) then
                ____t_result_285 = "complete"
            else
                local ____row_id_284 = row.id
                local ____opt_result_283
                if current ~= nil then
                    ____opt_result_283 = current.id
                end
                ____t_result_285 = ____row_id_284 == ____opt_result_283 and "current" or ""
            end
            li.className = ____t_result_285
            local n = window.document:createElement("span")
            n.textContent = __t(row.complete) and "✓" or (__t(row.epilogue) and "✦" or __call(
                tostring(row.index),
                "padStart",
                2,
                "0"
            ))
            local b = window.document:createElement("b")
            b.textContent = row.title
            local small = window.document:createElement("small")
            small.textContent = __add(
                __get(window.Campaign.sceneNames, row.scene),
                __t(row.epilogue) and " · NO EPÍLOGO" or ""
            )
            li:append(n, b, small)
            list:append(li)
        end
        local sideList = window.document:getElementById("sideQuestSteps")
        if __t(sideList) then
            sideList:replaceChildren()
            for ____, row in __iterar((sideRows)) do
                local li = window.document:createElement("li")
                li.className = __t(row.complete) and "complete" or "current"
                local ____t_result_286
                if __t(row.description) then
                    ____t_result_286 = row.description
                else
                    ____t_result_286 = ""
                end
                li.title = ____t_result_286
                local mark = window.document:createElement("span")
                mark.textContent = __t(row.complete) and "✓" or "✦"
                local label = window.document:createElement("b")
                label.textContent = row.title
                local place = window.document:createElement("small")
                place.textContent = __add(
                    __get(window.Campaign.sceneNames, row.scene),
                    __t(row.complete) and " · CONCLUÍDO" or " · EXPLORE"
                )
                li:append(mark, label, place)
                sideList:append(li)
            end
        end
        window.document:getElementById("chapterCount").textContent = __add(
            __add(
                __add(
                    __len(__call(
                        story,
                        "filter",
                        function(____, r) return r.complete end
                    )),
                    " / "
                ),
                __len(story)
            ),
            " CONCLUÍDOS"
        )
        local ____temp_288 = window.document:getElementById("campaignChapter")
        local ____t_result_287
        if __t(current) then
            ____t_result_287 = __add(
                __add(
                    __add("CAPÍTULO ", current.index),
                    " / "
                ),
                __len(story)
            )
        else
            ____t_result_287 = "CAMPANHA CONCLUÍDA"
        end
        ____temp_288.textContent = ____t_result_287
    end
    local ____ = "use strict"
    local characters = __ord(
        {
            amanda = __ord({name = "Amanda", role = "PRAÇA CAMACAN", description = "Foi a própria Amanda quem pintou as manchas do casaco de onça. Perto da entrada da praça, ela tem um convite para Da Roça.", power = "No jantar, respire no ritmo e escute Amanda. Davi e Vitor guardam um presente para o casal na Bigodon."}, "name,role,description,power"),
            igor = __ord({name = "Igor", role = "MONITOR · O FISCAL DO LANCHE", description = "Careca, gordinho, de barbinha e pele laranja clara, Igor fiscaliza os corredores. Ele quer saber se Da Roça trouxe lanche. Esconda-se atrás dos armários e saia do cone de visão para passar sem uma luta.", power = "Sem lanche, a barriga vira arma! Igor cresce, salta, rola pelo chão e cria ondas. Observe os avisos, use as plataformas e ataque nas pausas."}, "name,role,description,power"),
            kaique = __ord({name = "Kaique", role = "MONITOR · VOLTA PRA SALA!", description = "Alto, magro e branco, de cabelo e barba curta pretos, Kaique quer que Da Roça volte à sala e entregue as bolinhas de papel. A patrulha substitui os rabiscos pequenos da escola.", power = "Rajadas de metralhadora cartunizada e pausas para recarregar. A armadilha IRACI deixa Kaique furioso. Evite a palavra no chão, use as coberturas e desvie do alvo travado."}, "name,role,description,power"),
            daroca = __ord({name = "Da Roça", role = "O PROTAGONISTA · O DONO DO BOLO", description = "Um garoto da roça com um grande coração e um tanque de gás natural. Quando Nikolas Arroganti rouba o bolo de sapo que Lucas preparou para ele, Da Roça junta os amigos e transforma a resenha numa missão.", power = "Voo com peido, combo de gás, bolinhas elementais e o carro a gás do seu pai. Ganhe níveis e distribua pontos para criar seu próprio estilo."}, "name,role,description,power"),
            reeis = __ord({name = "Gabriel Reeis", role = "O ALIADO · DIRETO DE ITABUNA", description = "Gabriel Reis vem das favelas de Itabuna e carrega a fama de “rei do crime”. Primeiro você terá de atravessar a favela e enfrentar o rei do morro. Depois da luta, peça sua ajuda para recuperar o bolo: ele se torna um aliado da turma.", power = "OHHHH REEEEIS! Seu aliado corre até você, carrega uma aura dourada e se transforma. Depois, entra na luta por alguns segundos. Aperte R depois de derrotá-lo e recrutá-lo na favela."}, "name,role,description,power"),
            nikolas = __ord({name = "Nikolas Arroganti", role = "O CHEFÃO · TAMBÉM CONHECIDO COMO NIKOLAS POUDI", description = "Já foi um grande amigo de Da Roça. Mas a fome de bolo de chocolate falou mais alto e ele roubou o presente do Lucas! Agora esfrega seu enorme nariz de batata para carregar o catarro e foge das zoeiras do antigo amigo.", power = "Cada esfregada no nariz aumenta a carga de catarro. Ao disparar uma rajada, ele gasta tudo e precisa começar de novo. Essa é sua chance!"}, "name,role,description,power"),
            menezes = __ord({name = "Menezes, o Rato", role = "O VILÃO SECUNDÁRIO · PROVOCAÇÃO EM PESSOA", description = "“Da Roça poudiaaam!”, “Reeeis pouddiaaam!”, “Da Roça pegou ar!”, “Teketeketeketeke!” e “Ó pra Ravid falando sozinho!”. Moreno, de cabelo preto cacheado e óculos, Menezes transforma essas provocações em palavras físicas que atravessam o pátio.", power = "Provocações viram projéteis. Desvie das paredes de palavras, pule as ondas de provocação e cuidado com os ecos que voltam. Ele mergulha em bueiros para reaparecer em outro lugar e chama um exército temporário de ratos. Observe as marcas no chão e ataque quando ele sair do esgoto!"}, "name,role,description,power"),
            lucas = __ord({name = "Lucas, o Sapo", role = "O ALIADO · MESTRE DOS BOLOS", description = "De cabelo preto, casaco cinza, calça azul-escura e tênis branco, Lucas é um confeiteiro de baixa estatura apelidado de Sapo, e o autor do bolo de chocolate que começou toda essa confusão. Está na roça esperando Da Roça para contar o que viu e ajudar a consertar o carro do seu pai.", power = "A melhor receita de bolo de sapo da região e as chaves do carro a gás do pai de Da Roça para viajar entre as missões."}, "name,role,description,power"),
            caleb = __ord({name = "Caleb", role = "O ALIADO · PROFESSOR DA ACADEMIA", description = "Branco, loiro e de olhos castanhos, Caleb prepara Da Roça com um desafio de reflexo e ritmo. Depois de derrotar Menezes, procure o treinador na academia para provar que você domina o gás.", power = "Minigame com 3 rodadas. Acerte o marcador na faixa verde com E, Espaço ou o botão ACERTAR! Se errar, tente de novo. Complete o treino para aumentar seus ataques."}, "name,role,description,power"),
            marco = __ord({name = "Marco", role = "O VILÃO TERCIÁRIO · DESENHISTA DO CAOS", description = "Branco e magro, de moletom preto e cabelo preto, Marco ocupa a área dos rabiscos da escola com um caderno cheio de criaturas horríveis. O problema é que tudo o que ele desenha ganha vida, sai do papel e persegue Da Roça. Desvie dos rabiscos ou devolva o ataque. Seu caderno agora cria mais criaturas e ataques de tinta.", power = "A armadilha SARUÊ fica no chão. Se você pisar, Marco carrega uma aura vermelha, os olhos ficam vermelhos e ele desenha brainrots e criaturas Six Seven. Cuidado onde pisa!"}, "name,role,description,power"),
            kaua = __ord({name = "Kaua", role = "O ALIADO · CRIADOR DE ARMAS", description = "A oficina do Kaua fica na roça. Ele transforma objetos simples e materiais escolares em armas de desenho poderosas. Colete lápis, borrachas e clipes pelo cenário e converse com ele para entregar os itens.", power = "3 itens criam o Lançador de Régua. Depois, outros 5 itens evoluem para o Canhão de Estojo. A arma aumenta o poder do seu ataque de papel (J)."}, "name,role,description,power"),
            almiro = __ord({name = "Professor Almiro", role = "NPC · PROFESSOR DA ESCOLA", description = "Moreno, sem óculos, de camisa azul, jeans escuro e tênis verde neon, Almiro fica na sua própria sala na escola e está sempre pronto para uma conversa com Da Roça. Ele pede ajuda para recuperar três cadernos e ensina o combo de gás quando você volta com tudo.", power = "Ajude com os cadernos. A recompensa é experiência e o combo de três peidos: acerte K em sequência, com ritmo."}, "name,role,description,power"),
            miqueias = __ord({name = "Professor Miqueias", role = "NPC · ENGLISH DO JEITINHO DELE", description = "ALLRIGHT! Branco, de barba ruiva bem cheia, óculos e uma barriguinha, o professor Miqueias dá aula em outra sala da escola e conversa num inglês bem malfeito, misturado com os bordões da resenha. Complete seu quiz para aprender as papaias elementais e seguir a campanha.", power = "“ALLRIGHT”, “é ou não é”, “beleza creuza”, “concorda ou sem corda”. Chegue perto e converse com E."}, "name,role,description,power"),
            mota = __ord({name = "Gabriel Mota", role = "MOTA · O CRAQUE DO COLÉGIO", description = "Branco, loiro e magro, Mota joga futebol pela escola e vai ensinar Da Roça a acertar a mira e a força do chute. Procure o atleta no Campo do Mota e enfrente o goleiro em um minigame de cinco chutes.", power = "Faça três gols para ganhar experiência e liberar o dash. Depois você pode repetir o futebol para continuar evoluindo."}, "name,role,description,power"),
            giant = __ord({name = "Colosso Six Seven", role = "O MONSTRO GIGANTE · SAIU DO CADERNO", description = "Marco desenhou um monstro que ficou grande demais para o próprio caderno. Atravesse o reino de papel e tinta para encarar o colosso, seus golpes no chão e a chuva de rabiscos.", power = "Uma arena própria, ataques de grande alcance e invocações. Ganhe níveis, melhore seus atributos e aprenda a ler os avisos antes dos golpes."}, "name,role,description,power"),
            allef = __ord({name = "Allef", role = "BIGODON · A RECEPÇÃO DA RESENHA", description = "Gordinho, negro e de cabelo cacheado para cima, Allef cuida da recepção da Bigodon. O Da Roça mal entra e o chapéu já vira assunto na fila.", power = "Converse mais de uma vez. Allef sempre tem outra provocação preparada para a sua chegada."}, "name,role,description,power"),
            eloisa = __ord({name = "Eloisa", role = "CASA DE RAYSSA · A RESENHA CHEGOU", description = "De pele clara levemente morena, cabelo liso e batom rosa, Eloisa usa camisa branca com faixa azul escura à esquerda e calça azul escura. Ela está na casa de Rayssa com as amigas.", power = "Cada conversa traz uma resenha diferente. Aff veyr juro: nem o chapéu de Da Roça escapa dos comentários."}, "name,role,description,power"),
            giselle = __ord({name = "Giselle", role = "CASA DE RAYSSA · COMENTÁRIO NA PONTA DA LÍNGUA", description = "Negra, de tranças estilo crochet, Giselle usa o uniforme branco e azul escuro da turma. Na casa de Rayssa, acompanha cada história com um comentário certeiro.", power = "Converse novamente para ouvir outra zoeira. O assunto muda; a resenha continua."}, "name,role,description,power"),
            rayssa = __ord({name = "Rayssa", role = "A DONA DA CASA · SEM BARRO NO TAPETE", description = "Negra, de cabelo preto cacheado, Rayssa recebe a turma com camisa branca, faixa azul escura à esquerda e calça azul escura. O sofá não faz parte do circuito de parkour.", power = "Visite a casa com o carro a gás e converse com as quatro amigas. A primeira visita rende experiência."}, "name,role,description,power"),
            analaura = __ord({name = "Ana Laura", role = "CASA DE RAYSSA · JÁ QUER SABER DO LANCHE", description = "Branca, de cachos longos e soltos, Ana Laura tem uma silhueta discretamente mais cheia. Usa a mesma camisa branca com faixa e calça azul escura das amigas.", power = "As conversas variam a cada visita. Prepare o bolo, o açaí e uma boa história para a turma."}, "name,role,description,power"),
            dede = __ord({name = "Dedé", role = "FAVELA DO REEIS · O CAPANGA DA FUMAÇA", description = "Moreno e magro, de cabelo curto levantado e aparelho nos dentes, Dedé transforma a fumaça que solta em parte da luta. Na favela, ele se esconde entre nuvens e usa o beco como uma cortina de fumaça. É mais um capanga de Reeis no caminho da resenha.", power = "Confronto opcional. Observe os avisos e saia das nuvens antes de elas se fecharem; ataque quando Dedé reaparecer. A ajuda de Reeis continua seguindo a campanha principal."}, "name,role,description,power"),
            aica = __ord({name = "Aica", role = "PÁTIO DA ESCOLA · A AMIGA QUE FICA JUNTO", description = "De pele morena clara e cabelo longo e liso, Aica está no pátio da escola ajudando Ravile, que caiu depois de Arthur puxar seu cabelo. Converse com as duas para entender o que aconteceu.", power = "Uma história secundária. Ajude a dupla e acompanhe a revanche depois do desafio de Arthur."}, "name,role,description,power"),
            ravile = __ord({name = "Ravile", role = "PÁTIO DA ESCOLA · PRECISANDO DE AJUDA", description = "Morena e magra, de cabelo longo e liso, Ravile está caída e com dor quando Da Roça chega ao pátio. Aica cuida dela, e Ravile conta que Arthur puxou seu cabelo.", power = "Converse com Ravile ou Aica para iniciar a missão. Enfrente Arthur e veja o que acontece quando Ravile vai cobrar uma explicação. A missão não bloqueia o final do bolo."}, "name,role,description,power"),
            arthur = __ord({name = "Arthur", role = "PÁTIO DA ESCOLA · O PODER DO TAPA", description = "Branco, de cabelo raspado bem curtinho e óculos, Arthur tem movimentos e gestos expressivos. Ele arrumou uma confusão ao puxar o cabelo de Ravile; agora Da Roça precisa ajudar a amiga.", power = "Vários tipos de tapa, incluindo ataques à distância. Espere os avisos, desvie das rajadas e encontre as pausas. Confronto de uma missão secundária, separado da busca pelo bolo."}, "name,role,description,power"),
            davi = __ord({name = "Davi Costa", role = "BIGODON · BARBEIRO DA RESENHA", description = "Gordinho, de moletom preto e cabelo castanho liso e curto, Davi Costa comanda a Bigodon. A barbearia é uma parada para descansar, trocar ideia e ouvir uma resenha que vem junto com o corte.", power = "Converse na Bigodon para recuperar a vida e o gás. A primeira visita também rende experiência. Depois, volte sempre que precisar de um descanso."}, "name,role,description,power"),
            vitor = __ord({name = "Vitor", role = "BIGODON · O AJUDANTE", description = "Branco, de moletom cinza, cabelo preto curtinho e óculos, Vitor ajuda Davi Costa na Bigodon. Cuida da barbearia e nunca deixa a resenha do chefe passar sem um comentário.", power = "Procure Vitor ao lado de Davi e converse. Conhecer a dupla rende experiência na primeira visita e novas falas para a turma."}, "name,role,description,power"),
            freddy = __ord({name = "Freddy", role = "FAVELA DO REEIS · O CAPANGA MAIS FORTE", description = "Negro, magro, de cabelo preto cacheado em corte tijela com franja encaracolada, Freddy é o capanga mais forte de Reeis. Nem o chefe escapa das zoeiras dele: “Ô REEEIS!”. Você vai encontrá-lo no alto da favela, antes da arena do rei.", power = "Uma luta própria, com golpes fortes e avisos antes dos ataques. Use o dash do Mota para desviar e ataque na recuperação. Derrote Freddy para continuar até Reeis."}, "name,role,description,power"),
            nicolas = __ord({name = "Nicolas Carvalho", role = "PRAÇA CAMACAN · O AUTOPROCLAMADO PROTAGONISTA", description = "Branco, de cabelo curto e liso, Nicolas Carvalho tem certeza de que o mundo gira em torno dele. No fim da Praça Camacan, desafie o garoto para descobrir até onde vai a sua aura suprema.", power = "Desafio opcional com fases, uma arena celestial e ataques dourados. Aprenda o dash do Mota, observe os avisos e encontre as brechas entre os golpes. A conclusão guarda uma boa resenha."}, "name,role,description,power"),
            ravid = __ord({name = "Ravid", role = "O NPC · CONVERSANDO COM A PAREDE", description = "Você pode tentar conversar com Ravid na escola. Ele vai escutar? Talvez. Vai responder olhando para você? Pouco provável. A parede parece estar no meio de um assunto muito importante.", power = "Uma conversa infinita consigo mesmo. Chegue perto, aperte E e tente acompanhar o raciocínio."}, "name,role,description,power")
        },
        "amanda,igor,kaique,daroca,reeis,nikolas,menezes,lucas,caleb,marco,kaua,almiro,miqueias,mota,giant,allef,eloisa,giselle,rayssa,analaura,dede,aica,ravile,arthur,davi,vitor,freddy,nicolas,ravid"
    )
    local modalWasRunning = false
    local function openModal(self, el)
        if not __t(shell:contains(el)) then
            shell:append(el)
        end
        local ____opt_0 = window.Game
        if ____opt_0 ~= nil then
            ____opt_0 = ____opt_0:getState()
        end
        local state = ____opt_0
        local ____t_11 = __t
        local ____t_result_10
        local ____t_9 = __t
        local ____t_result_8
        local ____t_7 = __t
        local ____t_result_6
        local ____t_5 = __t
        local ____opt_result_4
        if state ~= nil then
            ____opt_result_4 = state.started
        end
        __O[2255] = ____opt_result_4
        if ____t_5(____opt_result_4) then
            ____t_result_6 = not __t(state.paused)
        else
            ____t_result_6 = __O[2255]
        end
        __O[2256] = ____t_result_6
        if ____t_7(____t_result_6) then
            ____t_result_8 = not __t(state.won)
        else
            ____t_result_8 = __O[2256]
        end
        __O[2257] = ____t_result_8
        if ____t_9(____t_result_8) then
            ____t_result_10 = not __t(state.defeated)
        else
            ____t_result_10 = __O[2257]
        end
        modalWasRunning = not not ____t_11(____t_result_10)
        if __t(modalWasRunning) then
            window.Game:pause()
        end
        el:showModal()
    end
    local function closeModal(self, el)
        el:close()
    end
    __call(
        window.document:querySelectorAll("[data-open-help]"),
        "forEach",
        function(____, btn) return btn:addEventListener(
            "click",
            function() return openModal(
                nil,
                window.document:getElementById("helpModal")
            ) end
        ) end
    )
    __call(
        window.document:querySelectorAll("[data-close-modal]"),
        "forEach",
        function(____, btn) return btn:addEventListener(
            "click",
            function() return closeModal(
                nil,
                btn:closest("dialog")
            ) end
        ) end
    )
    __call(
        window.document:querySelectorAll("dialog"),
        "forEach",
        function(____, el)
            el:addEventListener(
                "close",
                function()
                    if __t(modalWasRunning) then
                        modalWasRunning = false
                        window.Game:resume()
                    end
                end
            )
            el:addEventListener(
                "click",
                function(____, e)
                    if e.target == el then
                        local b = el:getBoundingClientRect()
                        local ____t_17 = __t
                        local ____t_result_16
                        local ____t_15 = __t
                        local ____t_result_14
                        local ____t_13 = __t
                        local ____temp_12 = e.clientX < b.left or e.clientX > b.right
                        __O[2258] = ____temp_12
                        if ____t_13(____temp_12) then
                            ____t_result_14 = __O[2258]
                        else
                            ____t_result_14 = e.clientY < b.top
                        end
                        __O[2259] = ____t_result_14
                        if ____t_15(____t_result_14) then
                            ____t_result_16 = __O[2259]
                        else
                            ____t_result_16 = e.clientY > b.bottom
                        end
                        if ____t_17(____t_result_16) then
                            closeModal(nil, el)
                        end
                    end
                end
            )
        end
    )
    local function portrait(self, canvas, ____type, detail)
        if detail == nil then
            detail = false
        end
        if __t(not __t(window.Art) or not __t(canvas)) then
            return
        end
        local c = canvas:getContext("2d")
        c.imageSmoothingEnabled = false
        c:clearRect(0, 0, canvas.width, canvas.height)
        if __t(detail) then
            c.fillStyle = ____type == "nikolas" and "#4b3d50" or "#36482f"
            c:fillRect(0, 0, 240, 180)
        end
        local x = canvas.width / 2
        local y = canvas.height - 5
        local ____temp_18
        if ____type == "giant" then
            ____temp_18 = __t(detail) and 0.78 or 0.5
        else
            ____temp_18 = __t(detail) and 1.85 or (____type == "lucas" and 1.55 or 1.25)
        end
        local scale = ____temp_18
        c.fillStyle = "#10241b45"
        c:fillRect(x - 30 * scale, y - 4, 60 * scale, 6)
        local ____self_25 = window.Art
        local ____self_25_drawCharacter_26 = ____self_25.drawCharacter
        local ____type_24 = ____type
        local ____scale_23 = scale
        local ____temp_22 = ____type == "daroca"
        if ____temp_22 then
            local ____t_21 = __t
            local ____opt_19 = window.Game
            if ____opt_19 ~= nil then
                ____opt_19 = ____opt_19:getState().q.trained
            end
            ____temp_22 = not not ____t_21(____opt_19)
        end
        ____self_25_drawCharacter_26(
            ____self_25,
            c,
            ____type_24,
            x,
            y,
            {facing = 1, frame = 0, scale = ____scale_23, muscular = ____temp_22}
        )
    end
    __call(
        window.document:querySelectorAll("[data-character]"),
        "forEach",
        function(____, btn) return btn:addEventListener(
            "click",
            function()
                local id = btn.dataset.character
                local c = __get(characters, id)
                window.document:getElementById("detailName").textContent = c.name
                window.document:getElementById("detailRole").textContent = c.role
                window.document:getElementById("detailDescription").textContent = c.description
                window.document:getElementById("detailPower").textContent = c.power
                portrait(
                    nil,
                    window.document:getElementById("detailPortrait"),
                    id,
                    true
                )
                openModal(
                    nil,
                    window.document:getElementById("characterModal")
                )
            end
        ) end
    )
    __call(
        window.document:querySelectorAll("[data-portrait]"),
        "forEach",
        function(____, c)
            local ____t_28 = __t
            local ____t_result_27
            if __t(window.DAROCA_ROBLOX) then
                ____t_result_27 = not __t(c:closest("#gameShell"))
            else
                ____t_result_27 = window.DAROCA_ROBLOX
            end
            if ____t_28(____t_result_27) then
                return
            end
            portrait(nil, c, c.dataset.portrait)
        end
    )
    local mini = window.document:getElementById("miniPortrait")
    local ____t_30 = __t
    local ____t_result_29
    if __t(window.Art) then
        ____t_result_29 = mini
    else
        ____t_result_29 = window.Art
    end
    if ____t_30(____t_result_29) then
        local c = mini:getContext("2d")
        c.imageSmoothingEnabled = false
        window.Art:drawCharacter(
            c,
            "daroca",
            21,
            42,
            __ord({facing = 1, frame = 0, scale = 0.55}, "facing,frame,scale")
        )
    end
    if not __t(window.DAROCA_ROBLOX) then
        __call(
            window.document:querySelectorAll(".map-image"),
            "forEach",
            function(____, el, i)
                local ____opt_31 = el:querySelector("span")
                if ____opt_31 ~= nil then
                    ____opt_31:remove()
                end
                local c = window.document:createElement("canvas")
                c.width = 240
                c.height = 135
                local ctx = c:getContext("2d")
                ctx.imageSmoothingEnabled = false
                ctx:scale(0.25, 0.25)
                window.Art:drawScene(ctx, i, 0, 0)
                el:append(c)
            end
        )
    end
    shell = window.document:querySelector(".game-shell")
    shell.id = "gameShell"
    local fullscreenBtn = window.document:getElementById("fullscreenBtn")
    local rotateHint = window.document:getElementById("rotateHint")
    local immersive = false
    local wasNative = false
    local rotationDismissed = false
    local previousScroll = 0
    local travelWasRunning = false
    local ____t_result_35
    local ____t_34 = __t
    local ____re_test_result_33 = __re_test(
        __re("iPhone|iPad|iPod", ""),
        window.navigator.userAgent
    )
    __O[2260] = ____re_test_result_33
    if ____t_34(____re_test_result_33) then
        ____t_result_35 = __O[2260]
    else
        ____t_result_35 = window.navigator.platform == "MacIntel" and window.navigator.maxTouchPoints > 1
    end
    local isIOS = ____t_result_35
    local function standalone()
        local ____t_result_42
        local ____t_41 = __t
        local ____t_result_40
        local ____t_39 = __t
        local ____t_result_38
        local ____t_37 = __t
        local ____temp_36 = window.location.protocol == "file:"
        __O[2261] = ____temp_36
        if ____t_37(____temp_36) then
            ____t_result_38 = __O[2261]
        else
            ____t_result_38 = __call(
                __new("URLSearchParams", window.location.search),
                "has",
                "native"
            )
        end
        __O[2262] = ____t_result_38
        if ____t_39(____t_result_38) then
            ____t_result_40 = __O[2262]
        else
            ____t_result_40 = window:matchMedia("(display-mode: standalone)").matches
        end
        __O[2263] = ____t_result_40
        if ____t_41(____t_result_40) then
            ____t_result_42 = __O[2263]
        else
            ____t_result_42 = not not __t(window.navigator.standalone)
        end
        return ____t_result_42
    end
    local function isNative()
        return window.document.fullscreenElement == shell or window.document.webkitFullscreenElement == shell
    end
    local fillScreen = true
    do
        pcall(function()
            fillScreen = window.localStorage:getItem("daroca-screen-fit") ~= "frame"
        end)
    end
    local fitTools = window.document:createElement("div")
    fitTools.className = "screen-fit-tools"
    fitTools.hidden = true
    local fitButton = window.document:createElement("button")
    fitButton.id = "screenFitBtn"
    fitButton.type = "button"
    local iosHelp = window.document:createElement("button")
    iosHelp.id = "iphoneFullscreenHelp"
    iosHelp.type = "button"
    iosHelp.textContent = "SEM BARRAS?"
    iosHelp:setAttribute("aria-haspopup", "dialog")
    local ____t_result_45
    local ____t_44 = __t
    local ____temp_43 = not __t(isIOS)
    __O[2264] = ____temp_43
    if ____t_44(____temp_43) then
        ____t_result_45 = __O[2264]
    else
        ____t_result_45 = standalone(nil)
    end
    iosHelp.hidden = ____t_result_45
    fitTools:append(fitButton, iosHelp)
    shell:append(fitTools)
    local function fitImmersive(self)
        if not __t(immersive) then
            return
        end
        local vv = window.visualViewport
        local ____t_result_50
        local ____t_49 = __t
        local ____temp_48 = vv and vv.width
        __O[2265] = ____temp_48
        if ____t_49(____temp_48) then
            ____t_result_50 = __O[2265]
        else
            ____t_result_50 = window.innerWidth
        end
        local width = math.floor(____t_result_50 + 0.5)
        local ____t_result_55
        local ____t_54 = __t
        local ____temp_53 = vv and vv.height
        __O[2266] = ____temp_53
        if ____t_54(____temp_53) then
            ____t_result_55 = __O[2266]
        else
            ____t_result_55 = window.innerHeight
        end
        local height = math.floor(____t_result_55 + 0.5)
        shell.style:setProperty(
            "--visible-width",
            __add(width, "px")
        )
        shell.style:setProperty(
            "--visible-height",
            __add(height, "px")
        )
        local ____self_63 = shell.style
        local ____self_63_setProperty_64 = ____self_63.setProperty
        local ____add_62 = __add
        local ____t_result_61
        if __t(isNative(nil)) then
            ____t_result_61 = 0
        else
            local ____t_result_60
            local ____t_59 = __t
            local ____temp_58 = vv and vv.offsetLeft
            __O[2267] = ____temp_58
            if ____t_59(____temp_58) then
                ____t_result_60 = __O[2267]
            else
                ____t_result_60 = 0
            end
            ____t_result_61 = ____t_result_60
        end
        ____self_63_setProperty_64(
            ____self_63,
            "--visible-left",
            ____add_62(____t_result_61, "px")
        )
        local ____self_72 = shell.style
        local ____self_72_setProperty_73 = ____self_72.setProperty
        local ____add_71 = __add
        local ____t_result_70
        if __t(isNative(nil)) then
            ____t_result_70 = 0
        else
            local ____t_result_69
            local ____t_68 = __t
            local ____temp_67 = vv and vv.offsetTop
            __O[2268] = ____temp_67
            if ____t_68(____temp_67) then
                ____t_result_69 = __O[2268]
            else
                ____t_result_69 = 0
            end
            ____t_result_70 = ____t_result_69
        end
        ____self_72_setProperty_73(
            ____self_72,
            "--visible-top",
            ____add_71(____t_result_70, "px")
        )
        local wide = width > height and height < 700
        shell.classList:toggle("screen-wide", wide)
        local ____t_result_76
        local ____t_75 = __t
        local ____temp_74 = not __t(window.document:getElementById("startScreen").hidden)
        __O[2269] = ____temp_74
        if ____t_75(____temp_74) then
            ____t_result_76 = __O[2269]
        else
            ____t_result_76 = __call(
                __arrL({
                    "is-dialog",
                    "is-cutscene",
                    "is-training",
                    "is-activity",
                    "is-room",
                    "is-paused",
                    "is-ollyan-flight"
                }, 7),
                "some",
                function(____, c) return shell.classList:contains(c) end
            )
        end
        local story = ____t_result_76
        if shell.classList:contains("screen-story") ~= story then
            shell.classList:toggle("screen-story", story)
        end
        shell.classList:toggle("screen-fill", fillScreen)
        local ____self_80 = shell.classList
        local ____self_80_toggle_81 = ____self_80.toggle
        local ____t_result_79
        local ____t_78 = __t
        local ____t_result_77
        if __t(wide) then
            ____t_result_77 = width / height <= 3.2
        else
            ____t_result_77 = wide
        end
        __O[2270] = ____t_result_77
        if ____t_78(____t_result_77) then
            ____t_result_79 = height >= 280
        else
            ____t_result_79 = __O[2270]
        end
        ____self_80_toggle_81(____self_80, "screen-crop-safe", ____t_result_79)
        local ____t_result_86
        local ____t_85 = __t
        local ____opt_82 = shell:querySelector(".game-topbar")
        local ____temp_84 = ____opt_82 and ____opt_82:getBoundingClientRect().height
        __O[2271] = ____temp_84
        if ____t_85(____temp_84) then
            ____t_result_86 = __O[2271]
        else
            ____t_result_86 = 0
        end
        local ____t_result_91
        local ____t_90 = __t
        local ____opt_87 = shell:querySelector(".progress-hud")
        local ____temp_89 = ____opt_87 and ____opt_87:getBoundingClientRect().height
        __O[2272] = ____temp_89
        if ____t_90(____temp_89) then
            ____t_result_91 = __O[2272]
        else
            ____t_result_91 = 0
        end
        local top = ____t_result_86 + ____t_result_91
        shell.style:setProperty(
            "--screen-hud-height",
            __add(top, "px")
        )
        local style = window:getComputedStyle(shell)
        local function px(____, v)
            local ____t_result_94
            local ____t_93 = __t
            local ____TS__ParseFloat_result_92 = __TS__ParseFloat(v)
            __O[2273] = ____TS__ParseFloat_result_92
            if ____t_93(____TS__ParseFloat_result_92) then
                ____t_result_94 = __O[2273]
            else
                ____t_result_94 = 0
            end
            return ____t_result_94
        end
        local availW = shell.clientWidth - px(nil, style.paddingLeft) - px(nil, style.paddingRight)
        local availH = math.max(
            120,
            shell.clientHeight - top - px(nil, style.paddingTop) - px(nil, style.paddingBottom)
        )
        local w = math.min(availW, availH * 16 / 9)
        shell.style:setProperty(
            "--stage-width",
            __add(w, "px")
        )
        shell.style:setProperty(
            "--stage-height",
            __add(w * 9 / 16, "px")
        )
        fitTools.hidden = not __t(wide)
        fitButton.disabled = width / height > 3.2 or height < 280
        fitButton.textContent = __t(fitButton.disabled) and "CENÁRIO INTEIRO" or (__t(fillScreen) and "ENQUADRAR" or "PREENCHER")
        fitButton:setAttribute(
            "aria-pressed",
            tostring(fillScreen)
        )
        fitButton:setAttribute(
            "aria-label",
            __t(fillScreen) and "Enquadrar todo o cenário" or "Preencher a tela durante o jogo"
        )
        fitButton.title = __t(fitButton.disabled) and "Esta proporção mantém o cenário inteiro visível." or "Alternar entre preencher a tela e mostrar todo o cenário"
        local ____t_result_99
        local ____t_98 = __t
        local ____t_result_97
        local ____t_96 = __t
        local ____temp_95 = not __t(isIOS)
        __O[2274] = ____temp_95
        if ____t_96(____temp_95) then
            ____t_result_97 = __O[2274]
        else
            ____t_result_97 = standalone(nil)
        end
        __O[2275] = ____t_result_97
        if ____t_98(____t_result_97) then
            ____t_result_99 = __O[2275]
        else
            ____t_result_99 = isNative(nil)
        end
        iosHelp.hidden = ____t_result_99
        local ____t_result_106
        local ____t_101 = __t
        local ____t_result_100
        if __t(rotationDismissed) then
            ____t_result_100 = rotationDismissed
        else
            ____t_result_100 = height <= width
        end
        __O[2277] = ____t_result_100
        if ____t_101(____t_result_100) then
            ____t_result_106 = __O[2277]
        else
            local ____t_105 = __t
            local ____t_result_104
            local ____t_103 = __t
            local ____table_matches_102 = window:matchMedia("(pointer: coarse)").matches
            __O[2276] = ____table_matches_102
            if ____t_103(____table_matches_102) then
                ____t_result_104 = __O[2276]
            else
                ____t_result_104 = width < 800
            end
            ____t_result_106 = not ____t_105(____t_result_104)
        end
        rotateHint.hidden = ____t_result_106
    end
    local function baseGameShell()
        return window.document.body.classList:contains("shell-experience")
    end
    local function updateFullscreenButton(self)
        local native = isNative(nil)
        local ____t_result_107
        if __t(baseGameShell(nil)) then
            ____t_result_107 = native
        else
            ____t_result_107 = immersive
        end
        local active = ____t_result_107
        fullscreenBtn:setAttribute(
            "aria-pressed",
            tostring(active)
        )
        fullscreenBtn:setAttribute(
            "aria-label",
            __t(active) and "Sair da tela cheia" or "Jogar em tela cheia"
        )
        fullscreenBtn.title = __t(active) and "Sair da tela cheia" or "Jogar em tela cheia"
        fullscreenBtn.innerHTML = __t(active) and "<svg viewBox=\"0 0 24 24\" width=\"20\" height=\"20\" aria-hidden=\"true\"><path fill=\"currentColor\" d=\"M7 3h3v7H3V7h4zm7 0h3v4h4v3h-7zM3 14h7v7H7v-4H3zm11 0h7v3h-4v4h-3z\"/></svg><small>SAIR</small>" or "<svg viewBox=\"0 0 24 24\" width=\"20\" height=\"20\" aria-hidden=\"true\"><path fill=\"currentColor\" d=\"M3 3h7v3H6v4H3zm11 0h7v7h-3V6h-4zM3 14h3v4h4v3H3zm15 0h3v7h-7v-3h4z\"/></svg><small>TELA CHEIA</small>"
    end
    local function leaveImmersive(self)
        local ____opt_110 = window.Game
        if ____opt_110 ~= nil then
            ____opt_110 = ____opt_110.releaseInputs
        end
        if ____opt_110 ~= nil then
            ____opt_110(____opt_110)
        end
        wasNative = false
        if __t(baseGameShell(nil)) then
            updateFullscreenButton(nil)
            fitImmersive(nil)
            return
        end
        immersive = false
        rotationDismissed = false
        shell.classList:remove(
            "immersive",
            "screen-wide",
            "screen-fill",
            "screen-story",
            "screen-crop-safe"
        )
        window.document.body.classList:remove("game-immersive")
        fitTools.hidden = true
        updateFullscreenButton(nil)
        rotateHint.hidden = true
        do
            pcall(function()
                local ____opt_114 = window.screen.orientation
                local ____opt_112 = ____opt_114 and ____opt_114.unlock
                if ____opt_112 ~= nil then
                    ____opt_112(____opt_114)
                end
            end)
        end
        window:scrollTo(0, previousScroll)
    end
    local function enterImmersive(self, options)
        if options == nil then
            options = {}
        end
        return __TS__AsyncAwaiter(function(____awaiter_resolve)
            local pageOnly = (options and options.pageOnly) == true
            local ____opt_120 = window.Game
            if ____opt_120 ~= nil then
                ____opt_120 = ____opt_120.releaseInputs
            end
            if ____opt_120 ~= nil then
                ____opt_120(____opt_120)
            end
            if not __t(immersive) then
                previousScroll = window.scrollY
                immersive = true
                rotationDismissed = false
                __call(shell.classList, "add", "immersive")
                __call(window.document.body.classList, "add", "game-immersive")
            end
            fitImmersive(nil)
            if __t(not __t(pageOnly) and not __t(isNative(nil))) then
                local ____try = __TS__AsyncAwaiter(function()
                    local ____t_125 = __t
                    local ____t_result_124
                    local ____t_123 = __t
                    local ____temp_122 = not __t(standalone(nil))
                    __O[2278] = ____temp_122
                    if ____t_123(____temp_122) then
                        ____t_result_124 = shell.requestFullscreen
                    else
                        ____t_result_124 = __O[2278]
                    end
                    if ____t_125(____t_result_124) then
                        __TS__Await(shell:requestFullscreen({navigationUI = "hide"}))
                    else
                        local ____t_129 = __t
                        local ____t_result_128
                        local ____t_127 = __t
                        local ____temp_126 = not __t(standalone(nil))
                        __O[2279] = ____temp_126
                        if ____t_127(____temp_126) then
                            ____t_result_128 = shell.webkitRequestFullscreen
                        else
                            ____t_result_128 = __O[2279]
                        end
                        if ____t_129(____t_result_128) then
                            __TS__Await(shell:webkitRequestFullscreen())
                        end
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
            wasNative = isNative(nil)
            updateFullscreenButton(nil)
            if __t(immersive) then
                if not __t(pageOnly) then
                    local ____try = __TS__AsyncAwaiter(function()
                        local ____opt_132 = window.screen.orientation
                        local ____opt_130 = ____opt_132 and ____opt_132.lock
                        __TS__Await(____opt_130 and ____opt_130(____opt_132, "landscape"))
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
                fitImmersive(nil)
            end
        end)
    end
    local function exitImmersive(self)
        return __TS__AsyncAwaiter(function(____awaiter_resolve)
            if __t(isNative(nil)) then
                local ____try = __TS__AsyncAwaiter(function()
                    if __t(window.document.exitFullscreen) then
                        __TS__Await(window.document:exitFullscreen())
                    else
                        local ____this_135
                        ____this_135 = window.document
                        local ____opt_134 = ____this_135.webkitExitFullscreen
                        if ____opt_134 ~= nil then
                            ____opt_134(____this_135)
                        end
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
            if __t(immersive) then
                leaveImmersive(nil)
            end
        end)
    end
    fullscreenBtn:addEventListener(
        "click",
        function()
            local ____t_result_138
            if __t(baseGameShell(nil)) then
                local ____t_result_136
                if __t(isNative(nil)) then
                    ____t_result_136 = exitImmersive(nil)
                else
                    ____t_result_136 = enterImmersive(nil)
                end
                ____t_result_138 = ____t_result_136
            else
                local ____t_result_137
                if __t(immersive) then
                    ____t_result_137 = exitImmersive(nil)
                else
                    ____t_result_137 = enterImmersive(nil)
                end
                ____t_result_138 = ____t_result_137
            end
            return ____t_result_138
        end
    )
    __call(
        window.document:querySelectorAll("[data-enter-fullscreen]"),
        "forEach",
        function(____, b) return b:addEventListener("click", enterImmersive) end
    )
    fitButton:addEventListener(
        "click",
        function()
            local ____opt_141 = window.Game
            if ____opt_141 ~= nil then
                ____opt_141 = ____opt_141.releaseInputs
            end
            if ____opt_141 ~= nil then
                ____opt_141(____opt_141)
            end
            fillScreen = not __t(fillScreen)
            do
                pcall(function()
                    window.localStorage:setItem(
                        "daroca-screen-fit",
                        __t(fillScreen) and "fill" or "frame"
                    )
                end)
            end
            fitImmersive(nil)
        end
    )
    iosHelp:addEventListener(
        "click",
        function()
            local ____opt_145 = window.GameInstall
            if ____opt_145 ~= nil then
                ____opt_145 = ____opt_145.showGuide
            end
            local ____opt_result_147
            if ____opt_145 ~= nil then
                ____opt_result_147 = ____opt_145(____opt_145)
            end
            return ____opt_result_147
        end
    )
    window.document:getElementById("rotateDismissBtn"):addEventListener(
        "click",
        function()
            rotationDismissed = true
            rotateHint.hidden = true
        end
    )
    local function onFullscreenChange()
        if __t(isNative(nil)) then
            wasNative = true
            updateFullscreenButton(nil)
            fitImmersive(nil)
        else
            local ____t_149 = __t
            local ____t_result_148
            if __t(wasNative) then
                ____t_result_148 = immersive
            else
                ____t_result_148 = wasNative
            end
            if ____t_149(____t_result_148) then
                leaveImmersive(nil)
            end
        end
    end
    window.document:addEventListener("fullscreenchange", onFullscreenChange)
    window.document:addEventListener("webkitfullscreenchange", onFullscreenChange)
    window:addEventListener("resize", fitImmersive)
    local ____opt_150 = window.visualViewport
    if ____opt_150 ~= nil then
        ____opt_150:addEventListener("resize", fitImmersive)
    end
    local ____opt_152 = window.visualViewport
    if ____opt_152 ~= nil then
        ____opt_152:addEventListener("scroll", fitImmersive)
    end
    local function onOrientationChange()
        local ____opt_156 = window.Game
        if ____opt_156 ~= nil then
            ____opt_156 = ____opt_156.releaseInputs
        end
        if ____opt_156 ~= nil then
            ____opt_156(____opt_156)
        end
        fitImmersive(nil)
        window:requestAnimationFrame(fitImmersive)
        window:setTimeout(fitImmersive, 180)
        window:setTimeout(fitImmersive, 420)
    end
    local ____opt_160 = window.screen.orientation
    local ____opt_158 = ____opt_160 and ____opt_160.addEventListener
    if ____opt_158 ~= nil then
        ____opt_158(____opt_160, "change", onOrientationChange)
    end
    window:addEventListener("orientationchange", onOrientationChange)
    __new("MutationObserver", fitImmersive):observe(
        shell,
        __ord(
            {
                attributes = true,
                attributeFilter = __arrL({"class"}, 1)
            },
            "attributes,attributeFilter"
        )
    )
    __new("MutationObserver", fitImmersive):observe(
        window.document:getElementById("startScreen"),
        __ord(
            {
                attributes = true,
                attributeFilter = __arrL({"hidden"}, 1)
            },
            "attributes,attributeFilter"
        )
    )
    window.document:addEventListener(
        "keydown",
        function(____, e)
            local ____t_171 = __t
            local ____t_result_170
            local ____t_169 = __t
            local ____t_result_168
            local ____t_167 = __t
            local ____t_result_166
            local ____t_165 = __t
            local ____t_result_164
            local ____t_163 = __t
            local ____temp_162 = e.code == "Escape"
            __O[2280] = ____temp_162
            if ____t_163(____temp_162) then
                ____t_result_164 = immersive
            else
                ____t_result_164 = __O[2280]
            end
            __O[2281] = ____t_result_164
            if ____t_165(____t_result_164) then
                ____t_result_166 = not __t(baseGameShell(nil))
            else
                ____t_result_166 = __O[2281]
            end
            __O[2282] = ____t_result_166
            if ____t_167(____t_result_166) then
                ____t_result_168 = not __t(isNative(nil))
            else
                ____t_result_168 = __O[2282]
            end
            __O[2283] = ____t_result_168
            if ____t_169(____t_result_168) then
                ____t_result_170 = not __t(window.document:querySelector("dialog[open]"))
            else
                ____t_result_170 = __O[2283]
            end
            if ____t_171(____t_result_170) then
                exitImmersive(nil)
            end
        end
    )
    local fillPan = nil
    local function followFill(self)
        local ____t_177 = __t
        local ____opt_174 = window.Campanha2
        if ____opt_174 ~= nil then
            ____opt_174 = ____opt_174.aberto
        end
        local ____opt_result_176
        if ____opt_174 ~= nil then
            ____opt_result_176 = ____opt_174(____opt_174)
        end
        if ____t_177(____opt_result_176) then
            window:requestAnimationFrame(followFill)
            return
        end
        local ____t_185 = __t
        local ____t_result_184
        local ____t_183 = __t
        local ____t_result_182
        local ____t_181 = __t
        local ____t_result_180
        local ____t_179 = __t
        local ____t_result_178
        if __t(immersive) then
            ____t_result_178 = shell.classList:contains("screen-wide")
        else
            ____t_result_178 = immersive
        end
        __O[2284] = ____t_result_178
        if ____t_179(____t_result_178) then
            ____t_result_180 = shell.classList:contains("screen-fill")
        else
            ____t_result_180 = __O[2284]
        end
        __O[2285] = ____t_result_180
        if ____t_181(____t_result_180) then
            ____t_result_182 = shell.classList:contains("screen-crop-safe")
        else
            ____t_result_182 = __O[2285]
        end
        __O[2286] = ____t_result_182
        if ____t_183(____t_result_182) then
            ____t_result_184 = not __t(shell.classList:contains("screen-story"))
        else
            ____t_result_184 = __O[2286]
        end
        if ____t_185(____t_result_184) then
            local viewport = shell:querySelector(".viewport")
            local w = viewport.clientWidth
            local h = viewport.clientHeight
            local scale = w / 960
            local ____opt_188 = window.Game
            if ____opt_188 ~= nil then
                ____opt_188 = ____opt_188.getViewTarget
            end
            local ____opt_result_190
            if ____opt_188 ~= nil then
                ____opt_result_190 = ____opt_188(____opt_188).y
            end
            local ____opt_result_190_191 = ____opt_result_190
            if ____opt_result_190_191 == nil then
                ____opt_result_190_191 = 440
            end
            local playerY = ____opt_result_190_191
            local ____t_result_194
            local ____t_193 = __t
            local ____TS__ParseFloat_result_192 = __TS__ParseFloat(shell.style:getPropertyValue("--screen-hud-height"))
            __O[2287] = ____TS__ParseFloat_result_192
            if ____t_193(____TS__ParseFloat_result_192) then
                ____t_result_194 = __O[2287]
            else
                ____t_result_194 = 72
            end
            local hud = ____t_result_194
            local ____t_result_197
            local ____t_196 = __t
            local ____TS__ParseFloat_result_195 = __TS__ParseFloat(window:getComputedStyle(shell).paddingTop)
            __O[2288] = ____TS__ParseFloat_result_195
            if ____t_196(____TS__ParseFloat_result_195) then
                ____t_result_197 = __O[2288]
            else
                ____t_result_197 = 0
            end
            local safeTop = ____t_result_197
            local minFoot = hud + safeTop + math.min(64, 62 * scale) + 24
            local bottom = math.min(0, h - 540 * scale)
            local target = math.min(
                80,
                math.max(bottom, minFoot - playerY * scale)
            )
            local ____temp_198
            if fillPan == nil then
                ____temp_198 = target
            else
                ____temp_198 = fillPan + (target - fillPan) * 0.5
            end
            fillPan = ____temp_198
            shell.style:setProperty(
                "--fill-offset",
                __add(
                    __call(fillPan, "toFixed", 2),
                    "px"
                )
            )
        else
            fillPan = nil
        end
        window:requestAnimationFrame(followFill)
    end
    window:requestAnimationFrame(followFill)
    local travelPanel = window.document:getElementById("travelPanel")
    local travelBtn = window.document:getElementById("travelBtn")
    local boardBtn = window.document:getElementById("boardCarBtn")
    local function refreshRoutes(self, preferred)
        local state = window.Game:getState()
        local hint = window.document:getElementById("routeHint")
        hint.textContent = not __t(state.started) and "Comece a aventura e converse com Lucas para consertar o carro." or (not __t(state.q.lucas) and "O carro do seu pai está quebrado. Busque as três peças na roça e leve tudo a Lucas." or (not __t(state.vehicle) and "Entre no carro a gás para escolher uma rota. É o carro do pai de Da Roça!" or "Motor ligado! Escolha o destino e deixe o carro a gás levar você."))
        boardBtn.hidden = not not __t(state.vehicle)
        boardBtn.disabled = not __t(state.started) or not __t(state.q.lucas)
        __call(
            travelPanel:querySelectorAll("[data-route]"),
            "forEach",
            function(____, b)
                local n = __TS__Number(b.dataset.route)
                local ____self_200 = b.classList
                local ____self_200_toggle_201 = ____self_200.toggle
                local ____preferred_199 = preferred
                if ____preferred_199 == nil then
                    ____preferred_199 = state.scene
                end
                ____self_200_toggle_201(____self_200, "active", n == ____preferred_199)
                local ____t_result_205
                local ____t_204 = __t
                local ____opt_202 = window.Campaign
                if ____opt_202 ~= nil then
                    ____opt_202 = ____opt_202:canTravel(n, state.q)
                end
                __O[2289] = ____opt_202
                if ____t_204(____opt_202) then
                    ____t_result_205 = __O[2289]
                else
                    ____t_result_205 = {ok = true, reason = ""}
                end
                local gate = ____t_result_205
                b.classList:toggle(
                    "locked",
                    not __t(gate.ok)
                )
                b:setAttribute(
                    "aria-disabled",
                    tostring(not __t(gate.ok))
                )
                local ____b_207 = b
                local ____t_result_206
                if __t(gate.reason) then
                    ____t_result_206 = gate.reason
                else
                    ____t_result_206 = "Escolher esta rota"
                end
                ____b_207.title = ____t_result_206
            end
        )
    end
    local function closeTravel(self)
        travelPanel.hidden = true
        travelBtn:setAttribute("aria-expanded", "false")
        shell.classList:remove("is-routing")
    end
    local function openTravel(self, preferred)
        local state = window.Game:getState()
        local ____t_227 = __t
        local ____t_result_226
        local ____t_225 = __t
        local ____t_result_224
        local ____t_223 = __t
        local ____t_result_222
        local ____t_221 = __t
        local ____t_result_220
        local ____t_219 = __t
        local ____t_result_218
        local ____t_217 = __t
        local ____t_result_216
        local ____t_215 = __t
        local ____t_result_214
        local ____t_213 = __t
        local ____t_result_212
        local ____t_209 = __t
        local ____t_result_208
        if __t(state.defeated) then
            ____t_result_208 = state.defeated
        else
            ____t_result_208 = state.won
        end
        __O[2290] = ____t_result_208
        if ____t_209(____t_result_208) then
            ____t_result_212 = __O[2290]
        else
            local ____opt_210 = state.training
            if ____opt_210 ~= nil then
                ____opt_210 = ____opt_210.active
            end
            ____t_result_212 = ____opt_210
        end
        __O[2291] = ____t_result_212
        if ____t_213(____t_result_212) then
            ____t_result_214 = __O[2291]
        else
            ____t_result_214 = state.activity
        end
        __O[2292] = ____t_result_214
        if ____t_215(____t_result_214) then
            ____t_result_216 = __O[2292]
        else
            ____t_result_216 = state.dialog
        end
        __O[2293] = ____t_result_216
        if ____t_217(____t_result_216) then
            ____t_result_218 = __O[2293]
        else
            ____t_result_218 = state.paused
        end
        __O[2294] = ____t_result_218
        if ____t_219(____t_result_218) then
            ____t_result_220 = __O[2294]
        else
            ____t_result_220 = state.activeBoss
        end
        __O[2295] = ____t_result_220
        if ____t_221(____t_result_220) then
            ____t_result_222 = __O[2295]
        else
            ____t_result_222 = state.routeTransition
        end
        __O[2296] = ____t_result_222
        if ____t_223(____t_result_222) then
            ____t_result_224 = __O[2296]
        else
            ____t_result_224 = state.cutscene
        end
        __O[2297] = ____t_result_224
        if ____t_225(____t_result_224) then
            ____t_result_226 = __O[2297]
        else
            ____t_result_226 = state.room
        end
        if ____t_227(____t_result_226) then
            return
        end
        local ____t_234 = __t
        local ____t_result_233
        if __t(state.started) then
            local ____opt_230 = window.MapasJogo
            if ____opt_230 ~= nil then
                ____opt_230 = ____opt_230.abrirCampanha1
            end
            local ____opt_result_232
            if ____opt_230 ~= nil then
                ____opt_result_232 = ____opt_230(____opt_230, preferred)
            end
            ____t_result_233 = ____opt_result_232
        else
            ____t_result_233 = state.started
        end
        if ____t_234(____t_result_233) then
            local ____this_236
            ____this_236 = window.Game
            local ____opt_235 = ____this_236.releaseInputs
            if ____opt_235 ~= nil then
                ____opt_235(____this_236)
            end
            return
        end
        local ____this_238
        ____this_238 = window.Game
        local ____opt_237 = ____this_238.releaseInputs
        if ____opt_237 ~= nil then
            ____opt_237(____this_238)
        end
        travelPanel.hidden = false
        travelBtn:setAttribute("aria-expanded", "true")
        __call(shell.classList, "add", "is-routing")
        refreshRoutes(nil, preferred)
    end
    travelBtn:addEventListener(
        "click",
        function()
            local ____t_result_239
            if __t(travelPanel.hidden) then
                ____t_result_239 = openTravel(nil)
            else
                ____t_result_239 = closeTravel(nil)
            end
            return ____t_result_239
        end
    )
    window.document:getElementById("travelCloseBtn"):addEventListener("click", closeTravel)
    __call(
        travelPanel:querySelectorAll("[data-route]"),
        "forEach",
        function(____, b) return b:addEventListener(
            "click",
            function()
                if __t(window.Game:getState().paused) then
                    closeTravel(nil)
                    return
                end
                if __t(window.Game:travel(__TS__Number(b.dataset.route))) then
                    closeTravel(nil)
                else
                    refreshRoutes(
                        nil,
                        __TS__Number(b.dataset.route)
                    )
                end
            end
        ) end
    )
    __call(
        window.document:querySelectorAll("[data-scene]"),
        "forEach",
        function(____, b) return b:addEventListener(
            "click",
            function(____, e)
                e:preventDefault()
                e:stopImmediatePropagation()
                openTravel(
                    nil,
                    __TS__Number(b.dataset.scene)
                )
            end,
            true
        ) end
    )
    window:addEventListener(
        "car-route-request",
        function(____, e)
            local ____openTravel_242 = openTravel
            local ____opt_240 = e.detail
            if ____opt_240 ~= nil then
                ____opt_240 = ____opt_240.scene
            end
            return ____openTravel_242(nil, ____opt_240)
        end
    )
    window:addEventListener(
        "game-input-reset",
        function()
            local st = window.Game:getState()
            local ____t_256 = __t
            local ____t_result_255
            local ____t_254 = __t
            local ____t_result_253
            local ____t_252 = __t
            local ____t_result_251
            local ____t_250 = __t
            local ____t_result_249
            local ____t_246 = __t
            local ____t_result_245
            local ____t_244 = __t
            local ____t_result_243
            if __t(st.paused) then
                ____t_result_243 = st.paused
            else
                ____t_result_243 = st.defeated
            end
            __O[2298] = ____t_result_243
            if ____t_244(____t_result_243) then
                ____t_result_245 = __O[2298]
            else
                ____t_result_245 = st.dialog
            end
            __O[2299] = ____t_result_245
            if ____t_246(____t_result_245) then
                ____t_result_249 = __O[2299]
            else
                local ____opt_247 = st.training
                if ____opt_247 ~= nil then
                    ____opt_247 = ____opt_247.active
                end
                ____t_result_249 = ____opt_247
            end
            __O[2300] = ____t_result_249
            if ____t_250(____t_result_249) then
                ____t_result_251 = __O[2300]
            else
                ____t_result_251 = st.activity
            end
            __O[2301] = ____t_result_251
            if ____t_252(____t_result_251) then
                ____t_result_253 = __O[2301]
            else
                ____t_result_253 = st.cutscene
            end
            __O[2302] = ____t_result_253
            if ____t_254(____t_result_253) then
                ____t_result_255 = __O[2302]
            else
                ____t_result_255 = st.room
            end
            if ____t_256(____t_result_255) then
                closeTravel(nil)
            end
        end
    )
    window:addEventListener(
        "player-trained",
        function()
            __call(
                window.document:querySelectorAll("[data-portrait=\"daroca\"]"),
                "forEach",
                function(____, c) return portrait(nil, c, "daroca") end
            )
            local c = mini:getContext("2d")
            c:clearRect(0, 0, 42, 42)
            window.Art:drawCharacter(
                c,
                "daroca",
                21,
                42,
                {facing = 1, frame = 0, scale = 0.55, muscular = true}
            )
        end
    )
    window.GameView = __ord(
        {
            enterFullscreen = enterImmersive,
            exitFullscreen = exitImmersive,
            isFullscreen = function() return immersive end,
            isNativeFullscreen = isNative,
            fit = fitImmersive,
            openRoutes = openTravel,
            closeRoutes = closeTravel,
            openHelp = function() return openModal(
                nil,
                window.document:getElementById("helpModal")
            ) end
        },
        "enterFullscreen,exitFullscreen,isFullscreen,isNativeFullscreen,fit,openRoutes,closeRoutes,openHelp"
    )
    local function preventGesture(____, e)
        if __t(e.cancelable) then
            e:preventDefault()
        end
    end
    __call(
        __arrL({
            "gesturestart",
            "gesturechange",
            "gestureend",
            "dblclick",
            "contextmenu",
            "dragstart",
            "selectstart"
        }, 7),
        "forEach",
        function(____, ____type) return shell:addEventListener(____type, preventGesture, {passive = false}) end
    )
    __call(
        window.document:querySelectorAll("#gameShell [data-action]"),
        "forEach",
        function(____, btn)
            __call(
                __arrL({"touchstart", "touchmove", "touchend"}, 3),
                "forEach",
                function(____, ____type) return btn:addEventListener(____type, preventGesture, {passive = false}) end
            )
        end
    )
    shell:addEventListener(
        "touchmove",
        function(____, e)
            local ____t_262 = __t
            local ____t_result_261
            local ____t_258 = __t
            local ____gt_result_257 = __gt(
                __len(e.touches),
                1
            )
            __O[2303] = ____gt_result_257
            if ____t_258(____gt_result_257) then
                ____t_result_261 = __O[2303]
            else
                local ____this_260
                ____this_260 = e.target
                local ____opt_259 = ____this_260.closest
                if ____opt_259 ~= nil then
                    ____opt_259 = ____opt_259(____this_260, ".touch-controls,#gameCanvas,.training-action")
                end
                ____t_result_261 = ____opt_259
            end
            if ____t_262(____t_result_261) then
                preventGesture(nil, e)
            end
        end,
        {passive = false}
    )
    local function updateProgress(self)
        if not __t(window.Progression) then
            return
        end
        local p = window.Progression:getState()
        local bonus = window.Progression:bonuses()
        window.document:getElementById("levelValue").textContent = p.level
        window.document:getElementById("pointsValue").textContent = __add(
            __add(
                __t(p.infinito) and "∞" or p.points,
                " "
            ),
            p.points == 1 and "PONTO" or "PONTOS"
        )
        local ____temp_264 = window.document:getElementById("xpLabel")
        local ____t_result_263
        if __t(p.nextXP) then
            ____t_result_263 = __add(
                __add(
                    __add(p.xp, " / "),
                    p.nextXP
                ),
                " XP"
            )
        else
            ____t_result_263 = "NÍVEL MÁXIMO"
        end
        ____temp_264.textContent = ____t_result_263
        local ____table_style_267 = window.document:getElementById("xpFill").style
        local ____add_266 = __add
        local ____t_result_265
        if __t(p.nextXP) then
            ____t_result_265 = math.min(100, p.xp / p.nextXP * 100)
        else
            ____t_result_265 = 100
        end
        ____table_style_267.width = ____add_266(____t_result_265, "%")
        window.document:getElementById("statsBtn").classList:toggle(
            "has-points",
            __gt(p.points, 0)
        )
        window.document:getElementById("statsSummary").textContent = __add(
            __add(
                __add("Nível ", p.level),
                " · "
            ),
            __t(p.infinito) and "∞ pontos (modo desenvolvedor)" or __add(p.points, " pontos disponíveis")
        )
        local function curto(____, n)
            local function d(____, v, u)
                local ____add_269 = __add
                local ____lt_result_268
                if __lt(v, 10) then
                    ____lt_result_268 = __call(
                        __call(
                            __call(v, "toFixed", 1),
                            "replace",
                            ".",
                            ","
                        ),
                        "replace",
                        ",0",
                        ""
                    )
                else
                    ____lt_result_268 = tostring(math.floor(v))
                end
                return ____add_269(____lt_result_268, u)
            end
            local ____lt_result_272
            if __lt(n, 1000) then
                ____lt_result_272 = tostring(n)
            else
                local ____lt_result_271
                if __lt(n, 1000000) then
                    ____lt_result_271 = d(nil, n / 1000, "K")
                else
                    local ____lt_result_270
                    if __lt(n, 1000000000) then
                        ____lt_result_270 = d(nil, n / 1000000, "M")
                    else
                        ____lt_result_270 = d(nil, n / 1000000000, "B")
                    end
                    ____lt_result_271 = ____lt_result_270
                end
                ____lt_result_272 = ____lt_result_271
            end
            return ____lt_result_272
        end
        for ____, stat in __iterar((__arrL({"vigor", "forca", "gas", "agilidade"}, 4))) do
            local el = window.document:getElementById(__add("stat-", stat))
            local v = __get(p.stats, stat)
            local t = curto(nil, v)
            el.textContent = t
            el.title = __call(v, "toLocaleString", "pt-BR")
            el.style.fontSize = __gt(
                __len(t),
                3
            ) and "11px" or ""
        end
        __call(
            window.document:querySelectorAll("[data-spend-stat]"),
            "forEach",
            function(____, b)
                local ____b_276 = b
                local ____t_result_275
                local ____t_274 = __t
                local ____lt_result_273 = __lt(p.points, 1)
                __O[2304] = ____lt_result_273
                if ____t_274(____lt_result_273) then
                    ____t_result_275 = __O[2304]
                else
                    ____t_result_275 = not not __t(p.teto) and __ge(
                        __get(p.stats, b.dataset.spendStat),
                        p.teto
                    )
                end
                ____b_276.disabled = ____t_result_275
                return ____t_result_275
            end
        )
        local function num(____, n)
            return __call(
                math.floor(n + 0.5),
                "toLocaleString",
                "pt-BR"
            )
        end
        window.document:getElementById("statsBonuses").textContent = __add(
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
                                                    num(nil, bonus.maxHP),
                                                    " de vida · "
                                                ),
                                                num(nil, bonus.maxGas)
                                            ),
                                            " de gás · "
                                        ),
                                        num(nil, (bonus.damageMultiplier - 1) * 100)
                                    ),
                                    "% de dano extra · velocidade "
                                ),
                                num(nil, bonus.moveSpeed)
                            ),
                            " · dash a cada "
                        ),
                        __call(
                            __call(bonus.dashCooldown, "toFixed", 2),
                            "replace",
                            ".",
                            ","
                        )
                    ),
                    "s · recuperação "
                ),
                __call(
                    __call(bonus.gasRegen, "toFixed", 1),
                    "replace",
                    ".",
                    ","
                )
            ),
            " gás/s"
        )
        updateJournal(nil)
    end
    journalSignature = ""
    window.document:getElementById("statsBtn"):addEventListener(
        "click",
        function()
            updateProgress(nil)
            openModal(
                nil,
                window.document:getElementById("statsModal")
            )
        end
    )
    local function upar(____, stat, qtd)
        if qtd == nil then
            qtd = 1
        end
        local ____t_291 = __t
        local ____opt_289 = window.Game
        if ____opt_289 ~= nil then
            ____opt_289 = ____opt_289.spendStat
        end
        if ____t_291(____opt_289) then
            window.Game:spendStat(stat, qtd)
        else
            window.Progression:spend(stat, qtd)
        end
        updateProgress(nil)
    end
    __call(
        window.document:querySelectorAll("[data-spend-stat]"),
        "forEach",
        function(____, b)
            local timer = 0
            local repeticoes = 0
            local segurou = false
            local function parar()
                window:clearTimeout(timer)
                timer = 0
            end
            local passo
            passo = function()
                repeticoes = repeticoes + 1
                segurou = true
                upar(nil, b.dataset.spendStat, repeticoes < 12 and 1 or (repeticoes < 30 and 10 or (repeticoes < 55 and 100 or 1000)))
                timer = window:setTimeout(passo, repeticoes < 12 and 110 or 70)
            end
            b:addEventListener(
                "pointerdown",
                function(____, e)
                    if __t(not __t(window.DAROCA_DEV) or __gt(e.button, 0)) then
                        return
                    end
                    parar(nil)
                    repeticoes = 0
                    segurou = false
                    timer = window:setTimeout(passo, 380)
                end
            )
            b:addEventListener(
                "pointerup",
                function()
                    parar(nil)
                    window:setTimeout(
                        function()
                            segurou = false
                        end,
                        0
                    )
                end
            )
            for ____, ev in __iterar((__arrL({"pointerleave", "pointercancel", "blur"}, 3))) do
                b:addEventListener(
                    ev,
                    function()
                        parar(nil)
                        segurou = false
                    end
                )
            end
            b:addEventListener(
                "click",
                function()
                    parar(nil)
                    if __t(segurou) then
                        segurou = false
                        return
                    end
                    upar(nil, b.dataset.spendStat)
                end
            )
        end
    )
    window:addEventListener("progression-change", updateProgress)
    updateProgress(nil)
    window:setInterval(updateJournal, 800)
    window.Game:setSoundEnabled(window.Game:soundOn())
end)(nil)
return ____exports
