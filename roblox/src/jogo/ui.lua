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
        local ____t_225 = __t
        local ____this_224
        ____this_224 = window.Campaign
        local ____opt_223 = ____this_224.sideQuestState
        if ____opt_223 ~= nil then
            ____opt_223 = ____opt_223(____this_224, q)
        end
        __O[2280] = ____opt_223
        local sideRows = if ____t_225(____opt_223) then __O[2280] else __arrL({}, 0)
        local signature = __add(
            __add(
                __call(
                    __call(
                        rows,
                        "map",
                        function(____, r) return if __t(r.complete) then "1" else "0" end
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
                    function(____, r) return if __t(r.complete) then "1" else "0" end
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
            local ____row_id_229 = row.id
            local ____opt_result_228
            if current ~= nil then
                ____opt_result_228 = current.id
            end
            li.className = if __t(row.complete) then "complete" else if ____row_id_229 == ____opt_result_228 then "current" else ""
            local n = window.document:createElement("span")
            n.textContent = if __t(row.complete) then "✓" else if __t(row.epilogue) then "✦" else __call(
                tostring(row.index),
                "padStart",
                2,
                "0"
            )
            local b = window.document:createElement("b")
            b.textContent = row.title
            local small = window.document:createElement("small")
            small.textContent = __add(
                __get(window.Campaign.sceneNames, row.scene),
                if __t(row.epilogue) then " · NO EPÍLOGO" else ""
            )
            li:append(n, b, small)
            list:append(li)
        end
        local sideList = window.document:getElementById("sideQuestSteps")
        if __t(sideList) then
            sideList:replaceChildren()
            for ____, row in __iterar((sideRows)) do
                local li = window.document:createElement("li")
                li.className = if __t(row.complete) then "complete" else "current"
                li.title = if __t(row.description) then row.description else ""
                local mark = window.document:createElement("span")
                mark.textContent = if __t(row.complete) then "✓" else "✦"
                local label = window.document:createElement("b")
                label.textContent = row.title
                local place = window.document:createElement("small")
                place.textContent = __add(
                    __get(window.Campaign.sceneNames, row.scene),
                    if __t(row.complete) then " · CONCLUÍDO" else " · EXPLORE"
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
        window.document:getElementById("campaignChapter").textContent = if __t(current) then __add(
            __add(
                __add("CAPÍTULO ", current.index),
                " / "
            ),
            __len(story)
        ) else "CAMPANHA CONCLUÍDA"
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
        local ____t_10 = __t
        local ____t_9 = __t
        local ____t_7 = __t
        local ____t_5 = __t
        local ____opt_result_4
        if state ~= nil then
            ____opt_result_4 = state.started
        end
        __O[2230] = ____opt_result_4
        local ____temp_6 = if ____t_5(____opt_result_4) then not __t(state.paused) else __O[2230]
        __O[2231] = ____temp_6
        local ____temp_8 = if ____t_7(____temp_6) then not __t(state.won) else __O[2231]
        __O[2232] = ____temp_8
        modalWasRunning = not not ____t_10(if ____t_9(____temp_8) then not __t(state.defeated) else __O[2232])
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
                        local ____t_15 = __t
                        local ____t_14 = __t
                        local ____t_12 = __t
                        local ____temp_11 = e.clientX < b.left or e.clientX > b.right
                        __O[2233] = ____temp_11
                        local ____temp_13 = if ____t_12(____temp_11) then __O[2233] else e.clientY < b.top
                        __O[2234] = ____temp_13
                        if ____t_15(if ____t_14(____temp_13) then __O[2234] else e.clientY > b.bottom) then
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
            c.fillStyle = if ____type == "nikolas" then "#4b3d50" else "#36482f"
            c:fillRect(0, 0, 240, 180)
        end
        local x = canvas.width / 2
        local y = canvas.height - 5
        local scale = if ____type == "giant" then if __t(detail) then 0.78 else 0.5 else if __t(detail) then 1.85 else if ____type == "lucas" then 1.55 else 1.25
        c.fillStyle = "#10241b45"
        c:fillRect(x - 30 * scale, y - 4, 60 * scale, 6)
        local ____self_22 = window.Art
        local ____self_22_drawCharacter_23 = ____self_22.drawCharacter
        local ____type_21 = ____type
        local ____scale_20 = scale
        local ____temp_19 = ____type == "daroca"
        if ____temp_19 then
            local ____t_18 = __t
            local ____opt_16 = window.Game
            if ____opt_16 ~= nil then
                ____opt_16 = ____opt_16:getState().q.trained
            end
            ____temp_19 = not not ____t_18(____opt_16)
        end
        ____self_22_drawCharacter_23(
            ____self_22,
            c,
            ____type_21,
            x,
            y,
            {facing = 1, frame = 0, scale = ____scale_20, muscular = ____temp_19}
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
            if __t(if __t(window.DAROCA_ROBLOX) then not __t(c:closest("#gameShell")) else window.DAROCA_ROBLOX) then
                return
            end
            portrait(nil, c, c.dataset.portrait)
        end
    )
    local mini = window.document:getElementById("miniPortrait")
    if __t(if __t(window.Art) then mini else window.Art) then
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
                local ____opt_24 = el:querySelector("span")
                if ____opt_24 ~= nil then
                    ____opt_24:remove()
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
    local ____t_27 = __t
    local ____re_test_result_26 = __re_test(
        __re("iPhone|iPad|iPod", ""),
        window.navigator.userAgent
    )
    __O[2235] = ____re_test_result_26
    local isIOS = if ____t_27(____re_test_result_26) then __O[2235] else window.navigator.platform == "MacIntel" and window.navigator.maxTouchPoints > 1
    local function standalone()
        local ____t_33 = __t
        local ____t_31 = __t
        local ____t_29 = __t
        local ____temp_28 = window.location.protocol == "file:"
        __O[2236] = ____temp_28
        local ____temp_30 = if ____t_29(____temp_28) then __O[2236] else __call(
            __new("URLSearchParams", window.location.search),
            "has",
            "native"
        )
        __O[2237] = ____temp_30
        local ____temp_32 = if ____t_31(____temp_30) then __O[2237] else window:matchMedia("(display-mode: standalone)").matches
        __O[2238] = ____temp_32
        return if ____t_33(____temp_32) then __O[2238] else not not __t(window.navigator.standalone)
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
    local ____t_35 = __t
    local ____temp_34 = not __t(isIOS)
    __O[2239] = ____temp_34
    iosHelp.hidden = if ____t_35(____temp_34) then __O[2239] else standalone(nil)
    fitTools:append(fitButton, iosHelp)
    shell:append(fitTools)
    local function fitImmersive(self)
        if not __t(immersive) then
            return
        end
        local vv = window.visualViewport
        local ____t_39 = __t
        local ____temp_38 = vv and vv.width
        __O[2240] = ____temp_38
        local width = math.floor(if ____t_39(____temp_38) then __O[2240] else window.innerWidth + 0.5)
        local ____t_43 = __t
        local ____temp_42 = vv and vv.height
        __O[2241] = ____temp_42
        local height = math.floor(if ____t_43(____temp_42) then __O[2241] else window.innerHeight + 0.5)
        shell.style:setProperty(
            "--visible-width",
            __add(width, "px")
        )
        shell.style:setProperty(
            "--visible-height",
            __add(height, "px")
        )
        local ____self_49 = shell.style
        local ____self_49_setProperty_50 = ____self_49.setProperty
        local ____add_48 = __add
        local ____t_47 = __t
        local ____temp_46 = vv and vv.offsetLeft
        __O[2242] = ____temp_46
        ____self_49_setProperty_50(
            ____self_49,
            "--visible-left",
            ____add_48(if __t(isNative(nil)) then 0 else if ____t_47(____temp_46) then __O[2242] else 0, "px")
        )
        local ____self_56 = shell.style
        local ____self_56_setProperty_57 = ____self_56.setProperty
        local ____add_55 = __add
        local ____t_54 = __t
        local ____temp_53 = vv and vv.offsetTop
        __O[2243] = ____temp_53
        ____self_56_setProperty_57(
            ____self_56,
            "--visible-top",
            ____add_55(if __t(isNative(nil)) then 0 else if ____t_54(____temp_53) then __O[2243] else 0, "px")
        )
        local wide = width > height and height < 700
        shell.classList:toggle("screen-wide", wide)
        local ____t_59 = __t
        local ____temp_58 = not __t(window.document:getElementById("startScreen").hidden)
        __O[2244] = ____temp_58
        local story = if ____t_59(____temp_58) then __O[2244] else __call(
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
        if shell.classList:contains("screen-story") ~= story then
            shell.classList:toggle("screen-story", story)
        end
        shell.classList:toggle("screen-fill", fillScreen)
        local ____self_62 = shell.classList
        local ____self_62_toggle_63 = ____self_62.toggle
        local ____t_61 = __t
        local ____temp_60 = if __t(wide) then width / height <= 3.2 else wide
        __O[2245] = ____temp_60
        ____self_62_toggle_63(____self_62, "screen-crop-safe", if ____t_61(____temp_60) then height >= 280 else __O[2245])
        local ____t_67 = __t
        local ____opt_64 = shell:querySelector(".game-topbar")
        local ____temp_66 = ____opt_64 and ____opt_64:getBoundingClientRect().height
        __O[2246] = ____temp_66
        local ____temp_72 = if ____t_67(____temp_66) then __O[2246] else 0
        local ____t_71 = __t
        local ____opt_68 = shell:querySelector(".progress-hud")
        local ____temp_70 = ____opt_68 and ____opt_68:getBoundingClientRect().height
        __O[2247] = ____temp_70
        local top = ____temp_72 + if ____t_71(____temp_70) then __O[2247] else 0
        shell.style:setProperty(
            "--screen-hud-height",
            __add(top, "px")
        )
        local style = window:getComputedStyle(shell)
        local function px(____, v)
            local ____t_74 = __t
            local ____TS__ParseFloat_result_73 = __TS__ParseFloat(v)
            __O[2248] = ____TS__ParseFloat_result_73
            return if ____t_74(____TS__ParseFloat_result_73) then __O[2248] else 0
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
        fitButton.textContent = if __t(fitButton.disabled) then "CENÁRIO INTEIRO" else if __t(fillScreen) then "ENQUADRAR" else "PREENCHER"
        fitButton:setAttribute(
            "aria-pressed",
            tostring(fillScreen)
        )
        fitButton:setAttribute("aria-label", if __t(fillScreen) then "Enquadrar todo o cenário" else "Preencher a tela durante o jogo")
        fitButton.title = if __t(fitButton.disabled) then "Esta proporção mantém o cenário inteiro visível." else "Alternar entre preencher a tela e mostrar todo o cenário"
        local ____t_78 = __t
        local ____t_76 = __t
        local ____temp_75 = not __t(isIOS)
        __O[2249] = ____temp_75
        local ____temp_77 = if ____t_76(____temp_75) then __O[2249] else standalone(nil)
        __O[2250] = ____temp_77
        iosHelp.hidden = if ____t_78(____temp_77) then __O[2250] else isNative(nil)
        local ____t_80 = __t
        local ____temp_79 = if __t(rotationDismissed) then rotationDismissed else height <= width
        __O[2252] = ____temp_79
        local ____t_83 = __t
        local ____t_82 = __t
        local ____table_matches_81 = window:matchMedia("(pointer: coarse)").matches
        __O[2251] = ____table_matches_81
        rotateHint.hidden = if ____t_80(____temp_79) then __O[2252] else not ____t_83(if ____t_82(____table_matches_81) then __O[2251] else width < 800)
    end
    local function baseGameShell()
        return window.document.body.classList:contains("shell-experience")
    end
    local function updateFullscreenButton(self)
        local native = isNative(nil)
        local active = if __t(baseGameShell(nil)) then native else immersive
        fullscreenBtn:setAttribute(
            "aria-pressed",
            tostring(active)
        )
        fullscreenBtn:setAttribute("aria-label", if __t(active) then "Sair da tela cheia" else "Jogar em tela cheia")
        fullscreenBtn.title = if __t(active) then "Sair da tela cheia" else "Jogar em tela cheia"
        fullscreenBtn.innerHTML = if __t(active) then "<svg viewBox=\"0 0 24 24\" width=\"20\" height=\"20\" aria-hidden=\"true\"><path fill=\"currentColor\" d=\"M7 3h3v7H3V7h4zm7 0h3v4h4v3h-7zM3 14h7v7H7v-4H3zm11 0h7v3h-4v4h-3z\"/></svg><small>SAIR</small>" else "<svg viewBox=\"0 0 24 24\" width=\"20\" height=\"20\" aria-hidden=\"true\"><path fill=\"currentColor\" d=\"M3 3h7v3H6v4H3zm11 0h7v7h-3V6h-4zM3 14h3v4h4v3H3zm15 0h3v7h-7v-3h4z\"/></svg><small>TELA CHEIA</small>"
    end
    local function leaveImmersive(self)
        local ____opt_86 = window.Game
        if ____opt_86 ~= nil then
            ____opt_86 = ____opt_86.releaseInputs
        end
        if ____opt_86 ~= nil then
            ____opt_86(____opt_86)
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
                local ____opt_90 = window.screen.orientation
                local ____opt_88 = ____opt_90 and ____opt_90.unlock
                if ____opt_88 ~= nil then
                    ____opt_88(____opt_90)
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
            local ____opt_96 = window.Game
            if ____opt_96 ~= nil then
                ____opt_96 = ____opt_96.releaseInputs
            end
            if ____opt_96 ~= nil then
                ____opt_96(____opt_96)
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
                    local ____t_100 = __t
                    local ____t_99 = __t
                    local ____temp_98 = not __t(standalone(nil))
                    __O[2253] = ____temp_98
                    if ____t_100(if ____t_99(____temp_98) then shell.requestFullscreen else __O[2253]) then
                        __TS__Await(shell:requestFullscreen({navigationUI = "hide"}))
                    else
                        local ____t_103 = __t
                        local ____t_102 = __t
                        local ____temp_101 = not __t(standalone(nil))
                        __O[2254] = ____temp_101
                        if ____t_103(if ____t_102(____temp_101) then shell.webkitRequestFullscreen else __O[2254]) then
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
                        local ____opt_106 = window.screen.orientation
                        local ____opt_104 = ____opt_106 and ____opt_106.lock
                        __TS__Await(____opt_104 and ____opt_104(____opt_106, "landscape"))
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
                        local ____this_109
                        ____this_109 = window.document
                        local ____opt_108 = ____this_109.webkitExitFullscreen
                        if ____opt_108 ~= nil then
                            ____opt_108(____this_109)
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
        function() return if __t(baseGameShell(nil)) then if __t(isNative(nil)) then exitImmersive(nil) else enterImmersive(nil) else if __t(immersive) then exitImmersive(nil) else enterImmersive(nil) end
    )
    __call(
        window.document:querySelectorAll("[data-enter-fullscreen]"),
        "forEach",
        function(____, b) return b:addEventListener("click", enterImmersive) end
    )
    fitButton:addEventListener(
        "click",
        function()
            local ____opt_112 = window.Game
            if ____opt_112 ~= nil then
                ____opt_112 = ____opt_112.releaseInputs
            end
            if ____opt_112 ~= nil then
                ____opt_112(____opt_112)
            end
            fillScreen = not __t(fillScreen)
            do
                pcall(function()
                    window.localStorage:setItem("daroca-screen-fit", if __t(fillScreen) then "fill" else "frame")
                end)
            end
            fitImmersive(nil)
        end
    )
    iosHelp:addEventListener(
        "click",
        function()
            local ____opt_116 = window.GameInstall
            if ____opt_116 ~= nil then
                ____opt_116 = ____opt_116.showGuide
            end
            local ____opt_result_118
            if ____opt_116 ~= nil then
                ____opt_result_118 = ____opt_116(____opt_116)
            end
            return ____opt_result_118
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
        elseif __t(if __t(wasNative) then immersive else wasNative) then
            leaveImmersive(nil)
        end
    end
    window.document:addEventListener("fullscreenchange", onFullscreenChange)
    window.document:addEventListener("webkitfullscreenchange", onFullscreenChange)
    window:addEventListener("resize", fitImmersive)
    local ____opt_119 = window.visualViewport
    if ____opt_119 ~= nil then
        ____opt_119:addEventListener("resize", fitImmersive)
    end
    local ____opt_121 = window.visualViewport
    if ____opt_121 ~= nil then
        ____opt_121:addEventListener("scroll", fitImmersive)
    end
    local function onOrientationChange()
        local ____opt_125 = window.Game
        if ____opt_125 ~= nil then
            ____opt_125 = ____opt_125.releaseInputs
        end
        if ____opt_125 ~= nil then
            ____opt_125(____opt_125)
        end
        fitImmersive(nil)
        window:requestAnimationFrame(fitImmersive)
        window:setTimeout(fitImmersive, 180)
        window:setTimeout(fitImmersive, 420)
    end
    local ____opt_129 = window.screen.orientation
    local ____opt_127 = ____opt_129 and ____opt_129.addEventListener
    if ____opt_127 ~= nil then
        ____opt_127(____opt_129, "change", onOrientationChange)
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
            local ____t_139 = __t
            local ____t_138 = __t
            local ____t_136 = __t
            local ____t_134 = __t
            local ____t_132 = __t
            local ____temp_131 = e.code == "Escape"
            __O[2255] = ____temp_131
            local ____temp_133 = if ____t_132(____temp_131) then immersive else __O[2255]
            __O[2256] = ____temp_133
            local ____temp_135 = if ____t_134(____temp_133) then not __t(baseGameShell(nil)) else __O[2256]
            __O[2257] = ____temp_135
            local ____temp_137 = if ____t_136(____temp_135) then not __t(isNative(nil)) else __O[2257]
            __O[2258] = ____temp_137
            if ____t_139(if ____t_138(____temp_137) then not __t(window.document:querySelector("dialog[open]")) else __O[2258]) then
                exitImmersive(nil)
            end
        end
    )
    local fillPan = nil
    local function followFill(self)
        local ____t_145 = __t
        local ____opt_142 = window.Campanha2
        if ____opt_142 ~= nil then
            ____opt_142 = ____opt_142.aberto
        end
        local ____opt_result_144
        if ____opt_142 ~= nil then
            ____opt_result_144 = ____opt_142(____opt_142)
        end
        if ____t_145(____opt_result_144) then
            window:requestAnimationFrame(followFill)
            return
        end
        local ____t_152 = __t
        local ____t_151 = __t
        local ____t_149 = __t
        local ____t_147 = __t
        local ____temp_146 = if __t(immersive) then shell.classList:contains("screen-wide") else immersive
        __O[2259] = ____temp_146
        local ____temp_148 = if ____t_147(____temp_146) then shell.classList:contains("screen-fill") else __O[2259]
        __O[2260] = ____temp_148
        local ____temp_150 = if ____t_149(____temp_148) then shell.classList:contains("screen-crop-safe") else __O[2260]
        __O[2261] = ____temp_150
        if ____t_152(if ____t_151(____temp_150) then not __t(shell.classList:contains("screen-story")) else __O[2261]) then
            local viewport = shell:querySelector(".viewport")
            local w = viewport.clientWidth
            local h = viewport.clientHeight
            local scale = w / 960
            local ____opt_155 = window.Game
            if ____opt_155 ~= nil then
                ____opt_155 = ____opt_155.getViewTarget
            end
            local ____opt_result_157
            if ____opt_155 ~= nil then
                ____opt_result_157 = ____opt_155(____opt_155).y
            end
            local ____opt_result_157_158 = ____opt_result_157
            if ____opt_result_157_158 == nil then
                ____opt_result_157_158 = 440
            end
            local playerY = ____opt_result_157_158
            local ____t_160 = __t
            local ____TS__ParseFloat_result_159 = __TS__ParseFloat(shell.style:getPropertyValue("--screen-hud-height"))
            __O[2262] = ____TS__ParseFloat_result_159
            local hud = if ____t_160(____TS__ParseFloat_result_159) then __O[2262] else 72
            local ____t_162 = __t
            local ____TS__ParseFloat_result_161 = __TS__ParseFloat(window:getComputedStyle(shell).paddingTop)
            __O[2263] = ____TS__ParseFloat_result_161
            local safeTop = if ____t_162(____TS__ParseFloat_result_161) then __O[2263] else 0
            local minFoot = hud + safeTop + math.min(64, 62 * scale) + 24
            local bottom = math.min(0, h - 540 * scale)
            local target = math.min(
                80,
                math.max(bottom, minFoot - playerY * scale)
            )
            fillPan = if fillPan == nil then target else fillPan + (target - fillPan) * 0.5
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
        hint.textContent = if not __t(state.started) then "Comece a aventura e converse com Lucas para consertar o carro." else if not __t(state.q.lucas) then "O carro do seu pai está quebrado. Busque as três peças na roça e leve tudo a Lucas." else if not __t(state.vehicle) then "Entre no carro a gás para escolher uma rota. É o carro do pai de Da Roça!" else "Motor ligado! Escolha o destino e deixe o carro a gás levar você."
        boardBtn.hidden = not not __t(state.vehicle)
        boardBtn.disabled = not __t(state.started) or not __t(state.q.lucas)
        __call(
            travelPanel:querySelectorAll("[data-route]"),
            "forEach",
            function(____, b)
                local n = __TS__Number(b.dataset.route)
                local ____self_164 = b.classList
                local ____self_164_toggle_165 = ____self_164.toggle
                local ____preferred_163 = preferred
                if ____preferred_163 == nil then
                    ____preferred_163 = state.scene
                end
                ____self_164_toggle_165(____self_164, "active", n == ____preferred_163)
                local ____t_168 = __t
                local ____opt_166 = window.Campaign
                if ____opt_166 ~= nil then
                    ____opt_166 = ____opt_166:canTravel(n, state.q)
                end
                __O[2264] = ____opt_166
                local gate = if ____t_168(____opt_166) then __O[2264] else {ok = true, reason = ""}
                b.classList:toggle(
                    "locked",
                    not __t(gate.ok)
                )
                b:setAttribute(
                    "aria-disabled",
                    tostring(not __t(gate.ok))
                )
                b.title = if __t(gate.reason) then gate.reason else "Escolher esta rota"
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
        local ____t_187 = __t
        local ____t_186 = __t
        local ____t_184 = __t
        local ____t_182 = __t
        local ____t_180 = __t
        local ____t_178 = __t
        local ____t_176 = __t
        local ____t_174 = __t
        local ____t_170 = __t
        local ____temp_169 = if __t(state.defeated) then state.defeated else state.won
        __O[2265] = ____temp_169
        local ____opt_171 = state.training
        if ____opt_171 ~= nil then
            ____opt_171 = ____opt_171.active
        end
        local ____temp_173 = if ____t_170(____temp_169) then __O[2265] else ____opt_171
        __O[2266] = ____temp_173
        local ____temp_175 = if ____t_174(____temp_173) then __O[2266] else state.activity
        __O[2267] = ____temp_175
        local ____temp_177 = if ____t_176(____temp_175) then __O[2267] else state.dialog
        __O[2268] = ____temp_177
        local ____temp_179 = if ____t_178(____temp_177) then __O[2268] else state.paused
        __O[2269] = ____temp_179
        local ____temp_181 = if ____t_180(____temp_179) then __O[2269] else state.activeBoss
        __O[2270] = ____temp_181
        local ____temp_183 = if ____t_182(____temp_181) then __O[2270] else state.routeTransition
        __O[2271] = ____temp_183
        local ____temp_185 = if ____t_184(____temp_183) then __O[2271] else state.cutscene
        __O[2272] = ____temp_185
        if ____t_187(if ____t_186(____temp_185) then __O[2272] else state.room) then
            return
        end
        local ____t_193 = __t
        local ____opt_190 = window.MapasJogo
        if ____opt_190 ~= nil then
            ____opt_190 = ____opt_190.abrirCampanha1
        end
        local ____opt_result_192
        if ____opt_190 ~= nil then
            ____opt_result_192 = ____opt_190(____opt_190, preferred)
        end
        if ____t_193(if __t(state.started) then ____opt_result_192 else state.started) then
            local ____this_195
            ____this_195 = window.Game
            local ____opt_194 = ____this_195.releaseInputs
            if ____opt_194 ~= nil then
                ____opt_194(____this_195)
            end
            return
        end
        local ____this_197
        ____this_197 = window.Game
        local ____opt_196 = ____this_197.releaseInputs
        if ____opt_196 ~= nil then
            ____opt_196(____this_197)
        end
        travelPanel.hidden = false
        travelBtn:setAttribute("aria-expanded", "true")
        __call(shell.classList, "add", "is-routing")
        refreshRoutes(nil, preferred)
    end
    travelBtn:addEventListener(
        "click",
        function() return if __t(travelPanel.hidden) then openTravel(nil) else closeTravel(nil) end
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
            local ____openTravel_200 = openTravel
            local ____opt_198 = e.detail
            if ____opt_198 ~= nil then
                ____opt_198 = ____opt_198.scene
            end
            return ____openTravel_200(nil, ____opt_198)
        end
    )
    window:addEventListener(
        "game-input-reset",
        function()
            local st = window.Game:getState()
            local ____t_213 = __t
            local ____t_212 = __t
            local ____t_210 = __t
            local ____t_208 = __t
            local ____t_204 = __t
            local ____t_202 = __t
            local ____temp_201 = if __t(st.paused) then st.paused else st.defeated
            __O[2273] = ____temp_201
            local ____temp_203 = if ____t_202(____temp_201) then __O[2273] else st.dialog
            __O[2274] = ____temp_203
            local ____opt_205 = st.training
            if ____opt_205 ~= nil then
                ____opt_205 = ____opt_205.active
            end
            local ____temp_207 = if ____t_204(____temp_203) then __O[2274] else ____opt_205
            __O[2275] = ____temp_207
            local ____temp_209 = if ____t_208(____temp_207) then __O[2275] else st.activity
            __O[2276] = ____temp_209
            local ____temp_211 = if ____t_210(____temp_209) then __O[2276] else st.cutscene
            __O[2277] = ____temp_211
            if ____t_213(if ____t_212(____temp_211) then __O[2277] else st.room) then
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
            local ____t_218 = __t
            local ____t_215 = __t
            local ____gt_result_214 = __gt(
                __len(e.touches),
                1
            )
            __O[2278] = ____gt_result_214
            local ____this_217
            ____this_217 = e.target
            local ____opt_216 = ____this_217.closest
            if ____opt_216 ~= nil then
                ____opt_216 = ____opt_216(____this_217, ".touch-controls,#gameCanvas,.training-action")
            end
            if ____t_218(if ____t_215(____gt_result_214) then __O[2278] else ____opt_216) then
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
            __add(if __t(p.infinito) then "∞" else p.points, " "),
            if p.points == 1 then "PONTO" else "PONTOS"
        )
        window.document:getElementById("xpLabel").textContent = if __t(p.nextXP) then __add(
            __add(
                __add(p.xp, " / "),
                p.nextXP
            ),
            " XP"
        ) else "NÍVEL MÁXIMO"
        window.document:getElementById("xpFill").style.width = __add(if __t(p.nextXP) then math.min(100, p.xp / p.nextXP * 100) else 100, "%")
        window.document:getElementById("statsBtn").classList:toggle(
            "has-points",
            __gt(p.points, 0)
        )
        window.document:getElementById("statsSummary").textContent = __add(
            __add(
                __add("Nível ", p.level),
                " · "
            ),
            if __t(p.infinito) then "∞ pontos (modo desenvolvedor)" else __add(p.points, " pontos disponíveis")
        )
        local function curto(____, n)
            local function d(____, v, u)
                return __add(if __lt(v, 10) then __call(
                    __call(
                        __call(v, "toFixed", 1),
                        "replace",
                        ".",
                        ","
                    ),
                    "replace",
                    ",0",
                    ""
                ) else tostring(math.floor(v)), u)
            end
            return if __lt(n, 1000) then tostring(n) else if __lt(n, 1000000) then d(nil, n / 1000, "K") else if __lt(n, 1000000000) then d(nil, n / 1000000, "M") else d(nil, n / 1000000000, "B")
        end
        for ____, stat in __iterar((__arrL({"vigor", "forca", "gas", "agilidade"}, 4))) do
            local el = window.document:getElementById(__add("stat-", stat))
            local v = __get(p.stats, stat)
            local t = curto(nil, v)
            el.textContent = t
            el.title = __call(v, "toLocaleString", "pt-BR")
            el.style.fontSize = if __gt(
                __len(t),
                3
            ) then "11px" else ""
        end
        __call(
            window.document:querySelectorAll("[data-spend-stat]"),
            "forEach",
            function(____, b)
                local ____b_221 = b
                local ____t_220 = __t
                local ____lt_result_219 = __lt(p.points, 1)
                __O[2279] = ____lt_result_219
                local ____temp_222 = if ____t_220(____lt_result_219) then __O[2279] else not not __t(p.teto) and __ge(
                    __get(p.stats, b.dataset.spendStat),
                    p.teto
                )
                ____b_221.disabled = ____temp_222
                return ____temp_222
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
        local ____t_232 = __t
        local ____opt_230 = window.Game
        if ____opt_230 ~= nil then
            ____opt_230 = ____opt_230.spendStat
        end
        if ____t_232(____opt_230) then
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
                upar(nil, b.dataset.spendStat, if repeticoes < 12 then 1 else if repeticoes < 30 then 10 else if repeticoes < 55 then 100 else 1000)
                timer = window:setTimeout(passo, if repeticoes < 12 then 110 else 70)
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
