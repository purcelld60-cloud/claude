--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __hasOwnV, __fcall, __lt, __gt, __ge, __isFiniteN, __mod, __ord, __arrL, __iterar, __t, __get = __JSR.__hasOwnV, __JSR.__fcall, __JSR.__lt, __JSR.__gt, __JSR.__ge, __JSR.__isFiniteN, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get
local __arr, __len, __call, __add, __iter, __entries, __assign = __JSR.__arr, __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__iter, __JSR.__entries, __JSR.__assign
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__Number = ____lualib.__TS__Number
local __TS__Spread = ____lualib.__TS__Spread
local __TS__ObjectFromEntries = ____lualib.__TS__ObjectFromEntries
local ____exports = {}
local __O = {};
(function()
    local timeline, timelinePosition, INTRO, OUTRO, EXTRA, clamp, frameDuration
    function timeline(self, kind)
        if kind == nil then
            kind = "intro"
        end
        if __t(if __t(kind) then type(kind) == "table" else kind) then
            return timelinePosition(nil, kind)
        end
        local ____opt_42 = window.JorgeEpilogue
        if ____opt_42 ~= nil then
            ____opt_42 = ____opt_42.shots
        end
        local frames = if kind == "jorge_epilogue" then ____opt_42 else if kind == "intro" then INTRO else if kind == "outro" then OUTRO else __get(EXTRA, kind)
        if not __t(frames) then
            return nil
        end
        local start = 0
        local shots = __call(
            frames,
            "map",
            function(____, frame, index)
                local duration = frameDuration(nil, frame)
                local shot = {
                    id = if __t(frame.id) then frame.id else tostring(index),
                    index = index,
                    start = start,
                    duration = duration,
                    label = if __t(frame.title) then frame.title else __add("Quadro ", index + 1),
                    speaker = if __t(frame.speaker) then frame.speaker else "",
                    text = if __t(frame.text) then frame.text else ""
                }
                start = start + duration
                return shot
            end
        )
        return {
            id = kind,
            duration = math.floor(start * 100 + 0.5) / 100,
            manualDefault = kind ~= "jorge_epilogue",
            shots = shots
        }
    end
    function timelinePosition(self, s)
        if not __t(s) then
            return 0
        end
        local timing = timeline(nil, s.kind)
        if not __t(timing) then
            return 0
        end
        if __t(s.done) then
            return timing.duration
        end
        local ____t_45 = __t
        local ____TS__Number_result_44 = __TS__Number(s.index)
        __O[702] = ____TS__Number_result_44
        local index = clamp(
            nil,
            math.floor(if ____t_45(____TS__Number_result_44) then __O[702] else 0),
            0,
            __len(timing.shots) - 1
        )
        local shot = __get(timing.shots, index)
        local ____shot_start_48 = shot.start
        local ____t_47 = __t
        local ____TS__Number_result_46 = __TS__Number(s.time)
        __O[703] = ____TS__Number_result_46
        return clamp(
            nil,
            ____shot_start_48 + math.max(0, if ____t_47(____TS__Number_result_46) then __O[703] else 0),
            0,
            timing.duration
        )
    end
    local ____ = "use strict"
    INTRO = __arrL(
        {
            __ord({title = "ANTES DO PRIMEIRO FARELO", speaker = "Da Roça", text = "Eu e Nikolas? A gente era unha e carne. Dividia a resenha, a carona… e até o último pedaço de bolo."}, "title,speaker,text"),
            __ord({title = "PARCEIROS DE RECREIO", speaker = "Nikolas Arroganti", text = "Se alguém mexer com Da Roça, vai ter que mexer comigo! Amizade de verdade é assim, pô."}, "title,speaker,text"),
            __ord({title = "O BOLO QUE MUDOU TUDO", speaker = "Lucas · o Sapo", text = "Fiz um bolo de sapo de chocolate pra Da Roça! Pode olhar, Nikolas. Olhar ainda não engorda."}, "title,speaker,text"),
            __ord({title = "UMA FOME MUITO SUSPEITA", speaker = "Nikolas Arroganti", text = "Só um pedacinho… talvez metade… ou o bolo inteiro. Ih, meu estômago já está fazendo campanha."}, "title,speaker,text"),
            __ord({title = "UM NARIZ, UMA BATATA, UM PLANO", speaker = "Da Roça", text = "Ô, Nikolas! Para de esfregar essa batata aí. Tá tentando descascar o nariz ou esconder alguma coisa?"}, "title,speaker,text"),
            __ord({title = "A FOME QUEBROU A AMIZADE", speaker = "Nikolas Arroganti", text = "Foi mal, parceiro… minha fome falou mais alto! Esse bolo agora é meu! Nikolas poudi!"}, "title,speaker,text"),
            __ord({title = "UM AMIGO A MENOS. UMA MISSÃO A MAIS.", speaker = "Da Roça", text = "Trocou amizade por cobertura?! Lucas, bora consertar o carro do meu pai e buscar esse bolo!"}, "title,speaker,text")
        },
        7
    )
    OUTRO = __arrL(
        {
            __ord({title = "O BOLO VOLTOU PARA CASA", speaker = "Da Roça", text = "O bolo tá inteiro. Sua pose de chefão, não! Vai colher essa batata do nariz com uma enxada?"}, "title,speaker,text"),
            __ord({title = "O REI DO CATARRO PERDEU O TRONO", speaker = "Nikolas Arroganti", text = "Pô, Da Roça… eu só queria um pedacinho. E meu nariz não é uma batata! É… aerodinâmico."}, "title,speaker,text"),
            __ord({title = "BATATA ASSADA NA RESENHA", speaker = "Da Roça", text = "Aerodinâmico? Quando você espirra, a roça inteira pergunta se já é época de colher! Hahaha, ô batatão!"}, "title,speaker,text"),
            __ord({title = "UM PEDAÇO DE BOM SENSO", speaker = "Lucas · o Sapo", text = "Tem bolo pra turma toda. Nikolas, pede um pedaço da próxima vez. E lava essa mão que passou o jogo no nariz!"}, "title,speaker,text"),
            __ord({title = "A AMIZADE AINDA TEM COBERTURA", speaker = "Da Roça", text = "Toma um pedaço, nariz de batata. Amigo pede. Ladrão corre. Na próxima você vai lavar a forma, combinado?"}, "title,speaker,text"),
            __ord({title = "FIM… OU SÓ O PRIMEIRO PEDAÇO?", speaker = "Reeis", text = "OHHHH REEEEIS! O bolo é nosso! Agora corta logo antes que o batata entre na fase dois da fome!"}, "title,speaker,text")
        },
        6
    )
    EXTRA = __ord(
        {
            boss_dede = __arrL(
                {
                    __ord({title = "MAIS UM CAPANGA NA SUBIDA", speaker = "Dedé", text = "SEU GILÓ HOMI! Sou Dedé. Antes do Freddy, você ainda vai passar pela minha fumaça!"}, "title,speaker,text"),
                    __ord({title = "CADÊ A VISTA DO MORRO?", speaker = "Da Roça", text = "Dedé, teu olho tá mais vermelho que a brasa desse cigarro. Isso é arena ou máquina de neblina?"}, "title,speaker,text"),
                    __ord({title = "O GUARDA DA ÚLTIMA PASSAGEM", speaker = "Dedé", text = "O Reeis mandou segurar a entrada. Eu acendi um... depois outro... e agora o morro todo virou fumaça. Mistério, homi."}, "title,speaker,text"),
                    __ord({title = "VENTILAÇÃO DA ROÇA", speaker = "Da Roça", text = "Então abre uma janela, porque eu trouxe papel e uma ventilação movida a gás."}, "title,speaker,text")
                },
                4
            ),
            dede_defeat = __arrL(
                {
                    __ord({title = "A NEBLINA BAIXOU", speaker = "Dedé", text = "SEU GILÓ HOMI! A fumaça baixou e o chapéu me venceu. Não espalha essa resenha!"}, "title,speaker,text"),
                    __ord({title = "CAMINHO ABERTO PARA O REI", speaker = "Da Roça", text = "Meu papel venceu a névoa. E o bolo continua me esperando."}, "title,speaker,text"),
                    __ord({title = "NÃO ESPALHA ESSA RESENHA", speaker = "Dedé", text = "Vai lá. Acho que vou largar esse cigarro: perdi pro chapéu tossindo. Só não conta pro Freddy."}, "title,speaker,text")
                },
                3
            ),
            boss_arthur = __arrL(
                {
                    __ord({title = "A RESENHA PASSOU DO LIMITE", speaker = "Aica", text = "Aff veyr juro! Arthur puxou o cabelo dela. Bestaiado, você se passou! Da Roça, ajuda!"}, "title,speaker,text"),
                    __ord({title = "BRINCADEIRA TEM LIMITE", speaker = "Arthur", text = "Foi só uma brincadeira! Por que todo mundo tá olhando pra mim desse jeito?"}, "title,speaker,text"),
                    __ord({title = "RESPEITO ANTES DO DESAFIO", speaker = "Da Roça", text = "Se machucou alguém, não é brincadeira. Chega junto e pede desculpa."}, "title,speaker,text"),
                    __ord({title = "O DESAFIO DO PÁTIO", speaker = "Arthur", text = "Tá bom, mas primeiro quero ver esse chapéu me alcançar!"}, "title,speaker,text")
                },
                4
            ),
            arthur_revenge = __arrL(
                {
                    __ord({title = "RAVILE VOLTOU À RESENHA", speaker = "Ravile", text = "Aff veyr juro, Arthur. Idiota! Você se passou. Agora vem ouvir o recado bem de pertinho."}, "title,speaker,text"),
                    __ord({title = "O GRITO ECOOU NO PÁTIO", speaker = "Aica", text = "OPEEEESTIIIIIIIII"}, "title,speaker,text"),
                    __ord({title = "UM PEDIDO DE DESCULPA", speaker = "Arthur", text = "Ai! Entendi! Foi errado puxar seu cabelo. Desculpa, Ravile. Não vou fazer de novo."}, "title,speaker,text"),
                    __ord({title = "O PÁTIO FEZ AS PAZES", speaker = "Da Roça", text = "Pronto. Respeito aprendido. Agora só pode puxar conversa, cadeira e saco de farinha."}, "title,speaker,text")
                },
                4
            ),
            celebration = __arrL(
                {
                    __ord({title = "O BOLO E A TURMA INTEIRA", speaker = "Lucas · o Sapo", text = "O bolo voltou! A mesa é da turma inteira. Nikolas, corta um pedaço. Um pedaço, viu?"}, "title,speaker,text"),
                    __ord({title = "A AULA AGORA É NA MESA", speaker = "Professor Miqueias", text = "ALLRIGHT! Everybody is de parabéns! Bolo is recovered, amizade is strong e a dieta is amanhã!"}, "title,speaker,text"),
                    __ord({title = "HOJE NINGUÉM É INIMIGO DA SOBREMESA", speaker = "Freddy", text = "OPEESTY DA ROÇA! Ô REEEIS! Trouxe a turma toda. Hoje a única briga é pela colher!"}, "title,speaker,text"),
                    __ord({title = "TODO MUNDO CABE NESSA RESENHA", speaker = "Aica", text = "Aff veyr juro! Ravile tá bem, Arthur pediu desculpa e até o monstro trouxe guardanapo!"}, "title,speaker,text"),
                    __ord({title = "A RESENHA CHEGOU EM PESO", speaker = "Rayssa", text = "Aff veyr juro! Trouxe as meninas e o Allef. Se toca, menino: hoje o bolo é da turma inteira!"}, "title,speaker,text"),
                    __ord({title = "O PRÊMIO ESPECIAL DA QUARTA", speaker = "Da Roça", text = "AÇAÍ NA QUARTA-FEIRA! Bolo recuperado, vingança cumprida e colher na mão. Esse prêmio é meu!"}, "title,speaker,text"),
                    __ord({title = "A AVENTURA CONTINUA DE COLHER NA MÃO", speaker = "Reeis", text = "OHHHH REEEEIS! A quarta é nossa! Curta a festa, guarde o prêmio e bora explorar com a turma!"}, "title,speaker,text")
                },
                7
            ),
            boss_freddy = __arrL(
                {
                    __ord({title = "A ÚLTIMA ESCADARIA TEM DONO", speaker = "Freddy", text = "OPEESTY DA ROÇA! Ô REEEIS! Eu seguro a escadaria, você segura essa pose de chefe!"}, "title,speaker,text"),
                    __ord({title = "O PORTEIRO DA RESENHA", speaker = "Da Roça", text = "Cê é o último capanga ou o porteiro da resenha? Até a subida daqui tem fase dois!"}, "title,speaker,text"),
                    __ord({title = "O BRAÇO MAIS FORTE DO MORRO", speaker = "Freddy", text = "Sou Freddy, o braço mais forte do Reeis. E chamo ele de Reeeis sem pedir licença!"}, "title,speaker,text"),
                    __ord({title = "FREDDY ENTRA NA RODA", speaker = "Freddy", text = "Primeiro passa por mim. Depois cê sobe. Ô Reeeis, assiste e aprende!"}, "title,speaker,text")
                },
                4
            ),
            freddy_defeat = __arrL(
                {
                    __ord({title = "O CAPANGA PERDEU. A ZOEIRA NÃO.", speaker = "Freddy", text = "OPEESTY DA ROÇA! Esse papel veio com assinatura de concreto. Tá liberado, chapéu!"}, "title,speaker,text"),
                    __ord({title = "RESPEITO SEM PERDER A RESENHA", speaker = "Da Roça", text = "Você perdeu e ainda tá zoando o chefe? Essa amizade aí tem armadura própria!"}, "title,speaker,text"),
                    __ord({title = "O RECADO VAI SUBINDO", speaker = "Freddy", text = "REEEIS! Se perder pro chapéu também, amanhã o morro inteiro vai saber!"}, "title,speaker,text")
                },
                3
            ),
            boss_nicolas = __arrL(
                {
                    __ord({title = "O PROTAGONISTA DA PRAÇA", speaker = "Nicolas Carvalho", text = "Finalmente! O coadjuvante chegou. Sou Nicolas Carvalho, o protagonista definitivo de Camacan!"}, "title,speaker,text"),
                    __ord({title = "UM DISCURSO PARA A FONTE", speaker = "Da Roça", text = "Protagonista? Você tava treinando discurso no reflexo da fonte."}, "title,speaker,text"),
                    __ord({title = "DESPERTAR DA AURA SUPREMA", speaker = "Nicolas Carvalho", text = "Silêncio! Testemunhe a AURA SUPREMA! Até o céu pediu ingresso pra minha batalha final!"}, "title,speaker,text"),
                    __ord({title = "A LENDA QUE ELE ESCREVEU SOZINHO", speaker = "Nicolas Carvalho", text = "Os pilares despertaram. O tempo parou. Minha lenda começa AGORA!"}, "title,speaker,text"),
                    __ord({title = "O CHAPÉU CONTRA O COSMOS", speaker = "Da Roça", text = "Tá, lenda. Se esse brilho estragar meu chapéu, você vai pagar a lavanderia."}, "title,speaker,text")
                },
                5
            ),
            nicolas_reveal = __arrL(
                {
                    __ord({title = "A LENDA PERDEU O ROTEIRO", speaker = "Nicolas Carvalho", text = "Impossível! Minha aura suprema... meus mil anos de poder... meu roteiro!"}, "title,speaker,text"),
                    __ord({title = "O TROVÃO VEIO DA BOCA", speaker = "Da Roça", text = "Mil anos? Nicolas, você tá fazendo barulho de trovão com a boca."}, "title,speaker,text"),
                    __ord({title = "CORTE PARA A VIDA REAL", speaker = "Narrador", text = "Era tudo imaginação de Nicolas. Na Praça Camacan, ele só girava os braços. A fonte nem parou."}, "title,speaker,text"),
                    __ord({title = "UM HERÓI SEM TESTEMUNHAS", speaker = "Nicolas Carvalho", text = "Vocês viram? Derrubei um deus! O brilho sumiu porque minha aura entrou no modo discreto."}, "title,speaker,text"),
                    __ord({title = "A PRAÇA VOLTA À PROGRAMAÇÃO NORMAL", speaker = "Da Roça", text = "Vi sim. A lixeira venceu por nocaute e a fonte tá pedindo revanche."}, "title,speaker,text")
                },
                5
            ),
            boss_marco = __arrL(
                {
                    __ord({title = "O CADERNO NÃO ERA SÓ RASCUNHO", speaker = "Marco", text = "Você passou dos meus desenhos? Então vem conhecer o artista. Hoje a prova de artes vale a sua barra de vida!"}, "title,speaker,text"),
                    __ord({title = "RABISCO RUIM, IDEIA PIOR", speaker = "Da Roça", text = "Isso é um tomate de tênis ou um caderno pedindo socorro? Até meu papel ficou preocupado!"}, "title,speaker,text"),
                    __ord({title = "NÃO PISE NA PROVOCAÇÃO", speaker = "Marco", text = "Olhe onde pisa! Se o chão disser SARUÊ, meus brainrots vão sair do controle!"}, "title,speaker,text"),
                    __ord({title = "O ARTISTA ENTRA EM CENA", speaker = "Da Roça", text = "Então desenha uma saída, porque eu vou buscar meu bolo. E dessa vez eu trouxe borracha em forma de peido."}, "title,speaker,text")
                },
                4
            ),
            boss_menezes = __arrL(
                {
                    __ord({title = "O PALCO DA PROVOCAÇÃO", speaker = "Menezes · Rato", text = "Da roça poudiaaam! Reeeis pouddiaaam! Hoje minhas palavras vão ocupar a arena inteira!"}, "title,speaker,text"),
                    __ord({title = "UMA FRASE, TRÊS PROBLEMAS", speaker = "Da Roça", text = "Tem parede de palavra, eco e onda no chão? Menezes, você transformou a recuperação de português num chefão!"}, "title,speaker,text"),
                    __ord({title = "TEKETEKETEKETEKE", speaker = "Menezes · Rato", text = "Da Roça pegou ar! Pula a onda, procura o espaço e cuidado com a frase que volta. O eco também sabe provocar!"}, "title,speaker,text"),
                    __ord({title = "O SINAL TOCOU. A RESENHA NÃO.", speaker = "Da Roça", text = "Respira entre as provocações, Menezes. É nessa hora que meu papel vai te responder!"}, "title,speaker,text")
                },
                4
            ),
            boss_nikolas = __arrL(
                {
                    __ord({title = "UM AMIGO. UM BOLO. UM TRONO.", speaker = "Da Roça", text = "Nikolas… a gente dividia tudo. Você realmente trocou nossa amizade por cobertura e um trono de farelo?"}, "title,speaker,text"),
                    __ord({title = "A BATATA ESTÁ CARREGADA", speaker = "Nikolas Arroganti", text = "Eu ia dividir! Mas o primeiro pedaço era o bolo inteiro… e essa batata ainda tem força!"}, "title,speaker,text"),
                    __ord({title = "A ÚLTIMA ESFREGADA NO NARIZ", speaker = "Nikolas Arroganti", text = "Meu catarro já tem fases de fome que não acabam. Desvia se puder, Da Roça! Hoje a cobertura sou eu que mando!"}, "title,speaker,text"),
                    __ord({title = "AMIZADE NÃO SE ROUBA", speaker = "Da Roça", text = "Era só pedir um pedaço. Agora vou buscar o bolo e colher essa sua arrogância, batatão!"}, "title,speaker,text")
                },
                4
            ),
            boss_reeis = __arrL(
                {
                    __ord({title = "NO ALTO DA FAVELA", speaker = "Gabriel Reeis", text = "Eu sou Reeis, o rei do morro! Você veio falar de bolo ou testar seu fôlego?"}, "title,speaker,text"),
                    __ord({title = "O REI DA RESENHA", speaker = "Da Roça", text = "Vim pedir ajuda, parceiro. Mas pelo tamanho dessa recepção… tô vendo que primeiro vai ter prova prática."}, "title,speaker,text"),
                    __ord({title = "RESPEITO SE CONQUISTA", speaker = "Gabriel Reeis", text = "Mostra o reflexo! Desvie das rajadas. Se aguentar, a gente conversa sobre esse bolo."}, "title,speaker,text"),
                    __ord({title = "DA ROÇA NÃO VEIO PARA TRÁS", speaker = "Da Roça", text = "Fiz tarefa, parkour e consertei o carro do meu pai. Essa amizade ainda nem começou!"}, "title,speaker,text")
                },
                4
            ),
            boss_giant = __arrL(
                {
                    __ord({title = "ALGO SAIU DA MARGEM", speaker = "Da Roça", text = "Esse caderno tá respirando? Marco, você desenhou um monstro ou a conta de luz de um estádio?!"}, "title,speaker,text"),
                    __ord({title = "O GIGANTE DO CADERNO", speaker = "Monstro de Marco", text = "SIIIXXX… SEVEEEEN! RRRRÁÁÁ!"}, "title,speaker,text"),
                    __ord({title = "UM RABISCO QUE COBRE O CÉU", speaker = "Da Roça", text = "Mão no chão, papel no céu e bicho pra todo lado… vou ler os avisos antes de virar rodapé!"}, "title,speaker,text"),
                    __ord({title = "A BORRACHA É PEQUENA. A CORAGEM NÃO.", speaker = "Da Roça", text = "Reeis, segura essa página! Eu vou mostrar que até um monstro desse tamanho cabe num combo de peido bem dado."}, "title,speaker,text")
                },
                4
            ),
            marco_rage = __arrL(
                {
                    __ord({title = "O CHÃO FALOU SOZINHO", speaker = "Armadilha de tinta", text = "S A R U Ê !"}, "title,speaker,text"),
                    __ord({title = "VOCÊ PISOU NO NOME ERRADO", speaker = "Marco", text = "NÃO. ME. CHAMA. DE. SARUÊ! Nem o chão, nem você, nem esse chapéu de milho!"}, "title,speaker,text"),
                    __ord({title = "FÚRIA VERMELHA", speaker = "Da Roça", text = "Eu nem falei nada! Foi meu tênis! Ih… olho vermelho. Esse desenho virou problema!"}, "title,speaker,text"),
                    __ord({title = "SIX SEVEN DO CAOS", speaker = "Marco · em fúria", text = "SIX SEVEN! BRAINROTS, SAIAM DO CADERNO! Agora cada rabisco tem raiva, e cada número quer arrancar sua vida!"}, "title,speaker,text")
                },
                4
            ),
            reeis_recruit = __arrL(
                {
                    __ord({title = "DEPOIS DA ÚLTIMA RAJADA", speaker = "Gabriel Reeis", text = "Você aguentou a subida e a minha resenha. Que bolo é esse que vale tanta aventura?"}, "title,speaker,text"),
                    __ord({title = "UM PEDIDO DE AMIZADE", speaker = "Da Roça", text = "Nikolas era meu amigo e roubou o bolo que Lucas fez pra mim. Me ajuda a buscar de volta?"}, "title,speaker,text"),
                    __ord({title = "UM CRIME CONTRA O CHOCOLATE", speaker = "Gabriel Reeis", text = "Roubar bolo de amigo? Aí passou dos limites da resenha. Fechou, parceiro! Quando apertar, grita OHHHH REEEEIS!"}, "title,speaker,text"),
                    __ord({title = "O PODER DO GRITO", speaker = "Da Roça", text = "OHHHH REEEEIS! Agora sim! Um parceiro desse tamanho… Nikolas vai precisar de uma colheita inteira de batata!"}, "title,speaker,text"),
                    __ord({title = "NINGUÉM BUSCA UM BOLO SOZINHO", speaker = "Gabriel Reeis", text = "Use R! Eu chego correndo e viro grandão. Deixa meu fôlego voltar entre os gritos, parceiro!"}, "title,speaker,text")
                },
                5
            )
        },
        "boss_dede,dede_defeat,boss_arthur,arthur_revenge,celebration,boss_freddy,freddy_defeat,boss_nicolas,nicolas_reveal,boss_marco,boss_menezes,boss_nikolas,boss_reeis,boss_giant,marco_rage,reeis_recruit"
    )
    clamp = function(____, v, a, b) return math.max(
        a,
        math.min(b, v)
    ) end
    local function ease(____, v)
        return 1 - (1 - clamp(nil, v, 0, 1)) ^ 3
    end
    local function rect(self, c, x, y, w, h, color)
        c.fillStyle = color
        c:fillRect(
            math.floor(x + 0.5),
            math.floor(y + 0.5),
            math.max(
                0,
                math.floor(w + 0.5)
            ),
            math.max(
                0,
                math.floor(h + 0.5)
            )
        )
    end
    local function poly(self, c, points, color)
        c.fillStyle = color
        c:beginPath()
        __call(
            points,
            "forEach",
            function(____, p, i) return if __t(i) then c:lineTo(
                __get(p, 0),
                __get(p, 1)
            ) else c:moveTo(
                __get(p, 0),
                __get(p, 1)
            ) end
        )
        c:closePath()
        __call(c, "fill")
    end
    local function line(self, c, points, width, color)
        do
            local i = 1
            while __lt(
                i,
                __len(points)
            ) do
                local a = __get(points, i - 1)
                local b = __get(points, i)
                local steps = math.max(
                    1,
                    math.ceil(math.max(
                        math.abs(__get(b, 0) - __get(a, 0)),
                        math.abs(__get(b, 1) - __get(a, 1))
                    ) / 3)
                )
                do
                    local j = 0
                    while j <= steps do
                        local t = j / steps
                        rect(
                            nil,
                            c,
                            __get(a, 0) + (__get(b, 0) - __get(a, 0)) * t - width / 2,
                            __get(a, 1) + (__get(b, 1) - __get(a, 1)) * t - width / 2,
                            width,
                            width,
                            color
                        )
                        j = j + 1
                    end
                end
                i = i + 1
            end
        end
    end
    local function word(self, c, t, x, y, size, color, align)
        if size == nil then
            size = 14
        end
        if color == nil then
            color = "#fff1ca"
        end
        if align == nil then
            align = "center"
        end
        c:save()
        c.font = ("bold " .. tostring(size)) .. "px monospace"
        c.textAlign = align
        c.textBaseline = "middle"
        c.fillStyle = "#1c3028"
        c:fillText(t, x + 2, y + 2)
        c.fillStyle = color
        c:fillText(t, x, y)
        c:restore()
    end
    local function heart(self, c, x, y, s, broken, t)
        if s == nil then
            s = 1
        end
        if broken == nil then
            broken = false
        end
        if t == nil then
            t = 0
        end
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        c:scale(s, s)
        local split = if __t(broken) then math.min(13, t * 7) else 0
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-split, -4}, 2),
                    __arrL({-split - 5, -9}, 2),
                    __arrL({-split - 13, -9}, 2),
                    __arrL({-split - 18, -4}, 2),
                    __arrL({-split - 18, 3}, 2),
                    __arrL({-split - 2, 18}, 2),
                    __arrL({-split + 1, 11}, 2),
                    __arrL({-split - 3, 6}, 2),
                    __arrL({1 - split, 2}, 2)
                },
                9
            ),
            if __t(broken) then "#c97070" else "#f2979a"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({split, -4}, 2),
                    __arrL({split + 5, -9}, 2),
                    __arrL({split + 13, -9}, 2),
                    __arrL({split + 18, -4}, 2),
                    __arrL({split + 18, 3}, 2),
                    __arrL({split + 2, 18}, 2),
                    __arrL({split - 1, 11}, 2),
                    __arrL({split + 3, 6}, 2),
                    __arrL({-1 + split, 2}, 2)
                },
                9
            ),
            if __t(broken) then "#e4a49a" else "#edb1a4"
        )
        if __t(broken) then
            line(
                nil,
                c,
                __arrL(
                    {
                        __arrL({0, -10}, 2),
                        __arrL({-4, -1}, 2),
                        __arrL({3, 6}, 2),
                        __arrL({-2, 18}, 2)
                    },
                    4
                ),
                2,
                "#f9e1ad"
            )
        else
            rect(
                nil,
                c,
                -12,
                -5,
                6,
                3,
                "#ffe1c7"
            )
        end
        c:restore()
    end
    local function sparkle(self, c, x, y, t, s, color)
        if s == nil then
            s = 1
        end
        if color == nil then
            color = "#fff3a8"
        end
        local p = 2 + math.floor((0.5 + math.sin(t * 5) * 0.5) * 3 + 0.5)
        rect(
            nil,
            c,
            x - p * s,
            y - s,
            p * 2 * s,
            2 * s,
            color
        )
        rect(
            nil,
            c,
            x - s,
            y - p * s,
            2 * s,
            p * 2 * s,
            color
        )
    end
    local function confetti(self, c, t, amount)
        if amount == nil then
            amount = 35
        end
        do
            local i = 0
            while i < amount do
                local x = __mod(i * 113 + t * if __t(__mod(i, 2)) then 17 else -13 + 1800, 960)
                local y = 55 + __mod(
                    i * 29 + t * (20 + __mod(i, 8)),
                    340
                )
                rect(
                    nil,
                    c,
                    x,
                    y,
                    4 + __mod(i, 3),
                    3,
                    __get(
                        __arrL({"#e6c56b", "#e89a79", "#c6dd87", "#e3b4d6"}, 4),
                        __mod(i, 4)
                    )
                )
                i = i + 1
            end
        end
    end
    local function actor(self, c, ____type, x, y, t, options)
        if options == nil then
            options = {}
        end
        local ____t_2 = __t
        local ____opt_0 = window.Art
        if ____opt_0 ~= nil then
            ____opt_0 = ____opt_0.drawCharacter
        end
        if ____t_2(____opt_0) then
            window.Art:drawCharacter(
                c,
                ____type,
                x,
                y,
                __assign({}, {
                    facing = 1,
                    frame = t,
                    scale = 1.65,
                    grounded = true,
                    moving = false
                }, options)
            )
        else
            rect(
                nil,
                c,
                x - 15,
                y - 65,
                30,
                65,
                if ____type == "daroca" then "#e39d56" else "#93769e"
            )
        end
    end
    local function cake(self, c, x, y, scale)
        if scale == nil then
            scale = 1
        end
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        c:scale(scale, scale)
        local ____t_5 = __t
        local ____opt_3 = window.Art
        if ____opt_3 ~= nil then
            ____opt_3 = ____opt_3.drawCake
        end
        if ____t_5(____opt_3) then
            window.Art:drawCake(c, 0, 0)
        else
            rect(
                nil,
                c,
                -24,
                -28,
                48,
                28,
                "#78503c"
            )
            rect(
                nil,
                c,
                -26,
                -32,
                52,
                9,
                "#b98b65"
            )
        end
        c:restore()
    end
    local function bench(self, c, x, y)
        rect(
            nil,
            c,
            x - 116,
            y - 40,
            232,
            10,
            "#79573d"
        )
        rect(
            nil,
            c,
            x - 116,
            y - 75,
            232,
            11,
            "#a37a4c"
        )
        rect(
            nil,
            c,
            x - 116,
            y - 59,
            232,
            10,
            "#bd945c"
        )
        rect(
            nil,
            c,
            x - 105,
            y - 37,
            11,
            37,
            "#4c5040"
        )
        rect(
            nil,
            c,
            x + 94,
            y - 37,
            11,
            37,
            "#4c5040"
        )
    end
    local function ____table(self, c, x, y)
        rect(
            nil,
            c,
            x - 70,
            y - 41,
            140,
            12,
            "#77503b"
        )
        rect(
            nil,
            c,
            x - 74,
            y - 47,
            148,
            9,
            "#d0a16c"
        )
        rect(
            nil,
            c,
            x - 61,
            y - 29,
            11,
            53,
            "#71513b"
        )
        rect(
            nil,
            c,
            x + 50,
            y - 29,
            11,
            53,
            "#71513b"
        )
    end
    local PISO_CINE = 62
    local pisoAplicado = false
    local function backdrop(self, c, state, scene, camera)
        if scene == nil then
            scene = 0
        end
        if camera == nil then
            camera = 0
        end
        if __t(pisoAplicado) then
            c:translate(0, -PISO_CINE)
            pisoAplicado = false
        end
        local ____t_8 = __t
        local ____opt_6 = window.Art
        if ____opt_6 ~= nil then
            ____opt_6 = ____opt_6.drawScene
        end
        if ____t_8(____opt_6) then
            window.Art:drawScene(
                c,
                scene,
                camera + math.floor(math.sin(state.time * 0.35) * 8 + 0.5),
                state.time * 0.7 + state.index * 2
            )
        else
            rect(
                nil,
                c,
                0,
                0,
                960,
                540,
                "#8bc4e4"
            )
        end
        rect(
            nil,
            c,
            0,
            0,
            960,
            540,
            if __t(state.kind == "intro" and __lt(state.index, 2)) then "#f4d5a414" else "#0e29191c"
        )
        c:translate(0, PISO_CINE)
        pisoAplicado = true
    end
    local function stomach(self, c, x, y, t)
        local pulse = math.sin(t * 11) * 4
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({x - 27, y}, 2),
                    __arrL({x - 33 - pulse, y - 5}, 2),
                    __arrL({x - 28, y - 13}, 2)
                },
                3
            ),
            3,
            "#edc96f"
        )
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({x + 27, y}, 2),
                    __arrL({x + 33 + pulse, y - 5}, 2),
                    __arrL({x + 28, y - 13}, 2)
                },
                3
            ),
            3,
            "#edc96f"
        )
        if math.sin(t * 4) > 0.1 then
            word(
                nil,
                c,
                "GRRRR…",
                x,
                y - 37,
                14,
                "#ffe296"
            )
        end
    end
    local function intro(self, c, s)
        local t = s.time
        local i = s.index
        backdrop(
            nil,
            c,
            s,
            if i == 1 then 1 else 0,
            if i == 1 then 180 else 0
        )
        if i == 0 then
            bench(nil, c, 470, 390)
            local e = ease(nil, t / 1.1)
            actor(
                nil,
                c,
                "daroca",
                330 + e * 60,
                378,
                t,
                {
                    facing = 1,
                    moving = __lt(t, 1.1),
                    speed = if __lt(t, 1.1) then 80 else 0,
                    pose = if __ge(t, 1.1) then "fistbump" else nil,
                    emotion = "friend"
                }
            )
            actor(
                nil,
                c,
                "nikolas",
                590 - e * 80,
                378,
                t,
                {
                    facing = -1,
                    moving = __lt(t, 1.1),
                    speed = if __lt(t, 1.1) then 80 else 0,
                    pose = if __ge(t, 1.1) then "fistbump" else nil,
                    emotion = "friend"
                }
            )
            if __gt(t, 1.1) then
                sparkle(
                    nil,
                    c,
                    450,
                    301,
                    t,
                    2
                )
            end
            heart(
                nil,
                c,
                460,
                220 + math.sin(t * 2) * 4,
                1.3,
                false,
                t
            )
        elseif i == 1 then
            local sway = math.sin(t * 2) * 5
            actor(
                nil,
                c,
                "daroca",
                300 + sway,
                378,
                t,
                {facing = 1, moving = true, speed = 100, emotion = "friend"}
            )
            actor(
                nil,
                c,
                "nikolas",
                610 + sway,
                378,
                t,
                {facing = -1, moving = true, speed = 100, emotion = "friend"}
            )
            local px = 300 + (math.sin(t * 1.7) * 0.5 + 0.5) * 310
            rect(
                nil,
                c,
                px,
                270 - math.sin(t * 1.7) * 20,
                10,
                8,
                "#fff4d5"
            )
            do
                local k = 0
                while k < 3 do
                    rect(
                        nil,
                        c,
                        px - k * 13,
                        275 - math.sin(t * 1.7) * 20,
                        5,
                        2,
                        "#eee9cbb0"
                    )
                    k = k + 1
                end
            end
            heart(
                nil,
                c,
                460,
                200 + math.sin(t * 2.3) * 3,
                1,
                false,
                t
            )
        elseif i == 2 then
            ____table(nil, c, 480, 365)
            actor(
                nil,
                c,
                "lucas",
                160,
                378,
                t,
                {facing = 1, scale = 1.55}
            )
            actor(
                nil,
                c,
                "daroca",
                340,
                378,
                t,
                {facing = 1}
            )
            actor(
                nil,
                c,
                "nikolas",
                660,
                378,
                t,
                {facing = -1}
            )
            cake(
                nil,
                c,
                480,
                315,
                1.15
            )
            do
                local j = 0
                while j < 6 do
                    sparkle(
                        nil,
                        c,
                        420 + j * 23,
                        248 + math.sin(t * 2 + j) * 12,
                        t + j,
                        1
                    )
                    j = j + 1
                end
            end
        elseif i == 3 then
            ____table(nil, c, 410, 365)
            cake(
                nil,
                c,
                410,
                315,
                1.2
            )
            actor(
                nil,
                c,
                "daroca",
                185,
                378,
                t,
                {facing = 1, scale = 1.45}
            )
            actor(
                nil,
                c,
                "nikolas",
                647 - ease(nil, t / 3) * 35,
                379,
                t,
                {
                    facing = -1,
                    scale = 2.05,
                    emotion = "greed",
                    attack = true,
                    noseRub = true,
                    attackType = "slime",
                    attackProgress = 0.6
                }
            )
            stomach(
                nil,
                c,
                620,
                325,
                t
            )
            do
                local j = 0
                while j < 3 do
                    local u = __mod(t * 0.5 + j / 3, 1)
                    rect(
                        nil,
                        c,
                        505 + u * 55,
                        265 + math.sin(u * math.pi) * -18,
                        4,
                        4,
                        "#84513d"
                    )
                    j = j + 1
                end
            end
        elseif i == 4 then
            actor(
                nil,
                c,
                "daroca",
                265,
                378,
                t,
                {
                    facing = 1,
                    scale = 1.9,
                    attack = true,
                    attackType = "punch",
                    attackProgress = 0.48
                }
            )
            actor(
                nil,
                c,
                "nikolas",
                640,
                378,
                t,
                {
                    facing = -1,
                    scale = 2.2,
                    emotion = "taunted",
                    noseRub = true,
                    attack = true,
                    attackType = "slime",
                    attackProgress = 0.6
                }
            )
            local w = math.sin(t * 12) * 3
            line(
                nil,
                c,
                __arrL(
                    {
                        __arrL({595, 257}, 2),
                        __arrL({582 + w, 252}, 2),
                        __arrL({590, 242}, 2)
                    },
                    3
                ),
                3,
                "#f1d18c"
            )
            line(
                nil,
                c,
                __arrL(
                    {
                        __arrL({590, 271}, 2),
                        __arrL({578 - w, 268}, 2),
                        __arrL({585, 260}, 2)
                    },
                    3
                ),
                3,
                "#f1d18c"
            )
        elseif i == 5 then
            ____table(nil, c, 420, 365)
            local run = ease(nil, t / 2.4)
            local nx = 575 + run * 240
            actor(
                nil,
                c,
                "daroca",
                280,
                378,
                t,
                {facing = 1, scale = 1.85, recoil = 0.5, emotion = "sad"}
            )
            actor(
                nil,
                c,
                "nikolas",
                nx,
                378,
                t,
                {
                    facing = 1,
                    scale = 1.7,
                    moving = true,
                    speed = 260,
                    pose = "steal",
                    emotion = "greed",
                    noseRub = __lt(t, 0.4)
                }
            )
            cake(
                nil,
                c,
                nx + 42,
                337,
                1
            )
            heart(
                nil,
                c,
                450,
                230,
                1.5,
                true,
                t
            )
            do
                local j = 0
                while j < 10 do
                    local xx = 530 + j * 26 + __mod(t * 130, 40)
                    if xx < nx then
                        rect(
                            nil,
                            c,
                            xx,
                            375 - __mod(j, 3) * 7,
                            5,
                            3,
                            "#d6bd82"
                        )
                    end
                    j = j + 1
                end
            end
        else
            actor(
                nil,
                c,
                "daroca",
                360,
                378,
                t,
                {
                    facing = 1,
                    scale = 2,
                    attack = __mod(t, 3) < 1.5,
                    attackType = "paper",
                    attackProgress = __mod(t, 1.5) / 1.5
                }
            )
            actor(
                nil,
                c,
                "lucas",
                650,
                378,
                t,
                {facing = -1, scale = 1.55}
            )
            local ____t_11 = __t
            local ____opt_9 = window.Art
            if ____opt_9 ~= nil then
                ____opt_9 = ____opt_9.drawVehicle
            end
            if ____t_11(____opt_9) then
                window.Art:drawVehicle(c, 810, 389, t)
            end
            do
                local j = 0
                while j < 5 do
                    sparkle(
                        nil,
                        c,
                        310 + j * 31,
                        217 - math.sin(t * 3 + j) * 8,
                        t + j,
                        1,
                        "#d8eda4"
                    )
                    j = j + 1
                end
            end
        end
    end
    local function outro(self, c, s)
        local t = s.time
        local i = s.index
        local strong = not not __t(s.options.trained)
        backdrop(
            nil,
            c,
            s,
            3,
            1100
        )
        if __ge(i, 3) then
            backdrop(
                nil,
                c,
                s,
                0,
                0
            )
        end
        if i == 0 then
            actor(
                nil,
                c,
                "daroca",
                310,
                378,
                t,
                {facing = 1, scale = 1.8, muscular = strong}
            )
            actor(
                nil,
                c,
                "nikolas",
                650,
                378,
                t,
                {facing = -1, scale = 1.65, recoil = 0.7, emotion = "sad"}
            )
            cake(
                nil,
                c,
                470,
                379,
                1.25
            )
            confetti(nil, c, t, 25)
        elseif i == 1 then
            actor(
                nil,
                c,
                "daroca",
                290,
                378,
                t,
                {facing = 1, scale = 1.8, muscular = strong}
            )
            actor(
                nil,
                c,
                "nikolas",
                630,
                378,
                t,
                {
                    facing = -1,
                    scale = 2.2,
                    emotion = "taunted",
                    noseRub = true,
                    attack = true,
                    attackType = "slime",
                    attackProgress = 0.6
                }
            )
            line(
                nil,
                c,
                __arrL(
                    {
                        __arrL({487, 215}, 2),
                        __arrL({520, 236}, 2),
                        __arrL({580, 257}, 2)
                    },
                    3
                ),
                3,
                "#eed09b"
            )
        elseif i == 2 then
            actor(
                nil,
                c,
                "daroca",
                290,
                378,
                t,
                {
                    facing = 1,
                    scale = 2,
                    muscular = strong,
                    attack = true,
                    attackType = "punch",
                    attackProgress = 0.5
                }
            )
            actor(
                nil,
                c,
                "nikolas",
                652,
                378,
                t,
                {
                    facing = -1,
                    scale = 1.9,
                    recoil = 0.5,
                    noseRub = false,
                    emotion = "taunted"
                }
            )
            word(
                nil,
                c,
                "BATATA!",
                515,
                255 + math.sin(t * 6) * 4,
                23,
                "#ffda87"
            )
            do
                local k = 0
                while k < 3 do
                    local yy = 228 + k * 24
                    word(
                        nil,
                        c,
                        "HA",
                        402 + k * 19,
                        yy - math.sin(t * 5 + k) * 5,
                        13,
                        "#e5dfae"
                    )
                    k = k + 1
                end
            end
            local p = 0.5 + math.sin(t * 4) * 0.5
            sparkle(
                nil,
                c,
                675,
                292,
                t,
                1 + p
            )
        elseif i == 3 then
            actor(
                nil,
                c,
                "lucas",
                220,
                378,
                t,
                {facing = 1, scale = 1.7}
            )
            actor(
                nil,
                c,
                "daroca",
                378,
                390,
                t,
                {facing = 1, scale = 1.65, muscular = strong}
            )
            actor(
                nil,
                c,
                "nikolas",
                670,
                378,
                t,
                {
                    facing = -1,
                    scale = 1.6,
                    noseRub = __mod(t, 3) < 1
                }
            )
            ____table(nil, c, 520, 365)
            cake(
                nil,
                c,
                520,
                315,
                1.2
            )
            rect(
                nil,
                c,
                735,
                300,
                26,
                45,
                "#d5e5dd"
            )
            rect(
                nil,
                c,
                739,
                294,
                18,
                8,
                "#88c0b0"
            )
            rect(
                nil,
                c,
                745,
                308,
                7,
                15,
                "#80ada3"
            )
        elseif i == 4 then
            actor(
                nil,
                c,
                "daroca",
                330,
                378,
                t,
                {
                    facing = 1,
                    scale = 1.8,
                    muscular = strong,
                    pose = "offer",
                    emotion = "friend"
                }
            )
            actor(
                nil,
                c,
                "nikolas",
                625,
                378,
                t,
                {facing = -1, scale = 1.7, pose = "offer", emotion = "friend"}
            )
            local e = ease(nil, t / 1.6)
            cake(
                nil,
                c,
                380 + e * 196,
                330 - math.sin(e * math.pi) * 25,
                0.7
            )
            heart(
                nil,
                c,
                480,
                220 + math.sin(t * 2) * 4,
                1.1,
                false,
                t
            )
        else
            actor(
                nil,
                c,
                "lucas",
                190,
                378,
                t,
                {facing = 1, scale = 1.35}
            )
            actor(
                nil,
                c,
                "daroca",
                365,
                378,
                t,
                {facing = 1, scale = 1.6, muscular = strong}
            )
            actor(
                nil,
                c,
                "nikolas",
                610,
                378,
                t,
                {
                    facing = -1,
                    scale = 1.5,
                    noseRub = __mod(t, 4) < 0.7
                }
            )
            actor(
                nil,
                c,
                "reeis",
                805,
                378,
                t,
                {facing = -1, scale = 1.5}
            )
            ____table(nil, c, 490, 365)
            cake(
                nil,
                c,
                490,
                315,
                1.2
            )
            confetti(nil, c, t, 42)
            do
                local j = 0
                while j < 8 do
                    sparkle(
                        nil,
                        c,
                        190 + j * 84,
                        220 + math.sin(t * 2 + j) * 13,
                        t + j,
                        1,
                        "#f4e7a1"
                    )
                    j = j + 1
                end
            end
        end
    end
    local function battleBackdrop(self, c, s, ____type, scene)
        if scene == nil then
            scene = 1
        end
        local ____t_14 = __t
        local ____opt_12 = window.Art
        if ____opt_12 ~= nil then
            ____opt_12 = ____opt_12.drawArena
        end
        if ____t_14(____opt_12) then
            window.Art:drawArena(
                c,
                ____type,
                0,
                s.time,
                480
            )
        else
            backdrop(
                nil,
                c,
                s,
                scene,
                0
            )
        end
        rect(
            nil,
            c,
            0,
            0,
            960,
            413,
            "#071c191f"
        )
        local floorColors = {
            marco = "#514160",
            menezes = "#725b4a",
            nikolas = "#977151",
            reeisBoss = "#485460",
            giant = "#302c46",
            freddy = "#5d4c4b",
            nicolas = "#b4af90"
        }
        local ____rect_18 = rect
        local ____c_17 = c
        local ____t_16 = __t
        local ____get_result_15 = __get(floorColors, ____type)
        __O[698] = ____get_result_15
        ____rect_18(
            nil,
            ____c_17,
            0,
            378,
            960,
            35,
            if ____t_16(____get_result_15) then __O[698] else "#4d6250"
        )
        rect(
            nil,
            c,
            0,
            378,
            960,
            4,
            if ____type == "giant" then "#a99bbd" else "#bfba91"
        )
        do
            local i = 0
            while i < 12 do
                local x = __mod(i * 97 + s.time * if __t(__mod(i, 2)) then 23 else -19 + 1400, 1080) - 60
                local y = 77 + __mod(i * 37, 260)
                rect(
                    nil,
                    c,
                    x,
                    y,
                    3,
                    3,
                    if __t(__mod(i, 2)) then "#d4dca266" else "#fff2b633"
                )
                i = i + 1
            end
        end
    end
    local function streaks(self, c, t, color, intensity)
        if color == nil then
            color = "#f8e7b9"
        end
        if intensity == nil then
            intensity = 1
        end
        c:save()
        c.globalAlpha = c.globalAlpha * (0.32 * intensity)
        do
            local i = 0
            while i < 15 do
                local y = 50 + i * 23 + math.sin(t * 17 + i) * 8
                local side = __mod(i, 2)
                line(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({if __t(side) then 0 else 960, y}, 2),
                            __arrL(
                                {
                                    if __t(side) then 150 else 810,
                                    y + math.sin(i) * 12
                                },
                                2
                            )
                        },
                        2
                    ),
                    2,
                    color
                )
                i = i + 1
            end
        end
        c:restore()
    end
    local function shockRing(self, c, x, y, t, color, max)
        if color == nil then
            color = "#f6d383"
        end
        if max == nil then
            max = 170
        end
        local phase = __mod(t * 0.7, 1)
        local radius = 20 + phase * max
        c:save()
        c.globalAlpha = c.globalAlpha * (1 - phase)
        do
            local i = 0
            while i < 30 do
                local a = i / 30 * math.pi * 2
                rect(
                    nil,
                    c,
                    x + math.cos(a) * radius,
                    y + math.sin(a) * radius,
                    5,
                    3,
                    color
                )
                i = i + 1
            end
        end
        c:restore()
    end
    local function redAura(self, c, x, y, t, s)
        if s == nil then
            s = 1
        end
        c:save()
        c:translate(x, y)
        c:scale(s, s)
        local shake = math.sin(t * 25) * 2
        c.globalAlpha = c.globalAlpha * 0.43
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-35, 0}, 2),
                    __arrL({-44, -30}, 2),
                    __arrL({-29, -36}, 2),
                    __arrL({-37, -67}, 2),
                    __arrL({-20, -59}, 2),
                    __arrL({-16, -87}, 2),
                    __arrL({-4, -75}, 2),
                    __arrL({3 + shake, -104}, 2),
                    __arrL({12, -76}, 2),
                    __arrL({28, -92}, 2),
                    __arrL({24, -60}, 2),
                    __arrL({41, -68}, 2),
                    __arrL({30, -36}, 2),
                    __arrL({46, -29}, 2),
                    __arrL({35, 0}, 2)
                },
                15
            ),
            "#f64752"
        )
        c.globalAlpha = c.globalAlpha / 0.43
        c.globalAlpha = c.globalAlpha * 0.8
        for ____, side in __iterar((__arrL({-1, 1}, 2))) do
            line(
                nil,
                c,
                __arrL(
                    {
                        __arrL({side * 32, -10}, 2),
                        __arrL({side * 37, -24}, 2),
                        __arrL({side * 29, -35}, 2),
                        __arrL({side * 38, -49}, 2),
                        __arrL({side * 29, -65}, 2),
                        __arrL({side * 32, -82}, 2)
                    },
                    6
                ),
                2,
                "#ffb2aa"
            )
        end
        do
            local i = 0
            while i < 14 do
                local yy = __TS__Number(-__mod(t * 95 + i * 19, 112))
                local xx = math.sin(i * 2.3 + t) * 32
                rect(
                    nil,
                    c,
                    xx,
                    yy,
                    3,
                    6,
                    if __t(__mod(i, 3)) then "#ff4949" else "#ffd2ba"
                )
                i = i + 1
            end
        end
        c:restore()
    end
    local function sketchbook(self, c, x, y, t, open)
        if open == nil then
            open = 1
        end
        local spread = 42 + open * 22
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({x - spread, y - 25}, 2),
                    __arrL({x - 3, y - 13}, 2),
                    __arrL({x - 3, y + 41}, 2),
                    __arrL({x - spread, y + 26}, 2)
                },
                4
            ),
            "#b8a9c4"
        )
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({x + 3, y - 13}, 2),
                    __arrL({x + spread, y - 25}, 2),
                    __arrL({x + spread, y + 26}, 2),
                    __arrL({x + 3, y + 41}, 2)
                },
                4
            ),
            "#e1cedc"
        )
        rect(
            nil,
            c,
            x - 3,
            y - 14,
            6,
            55,
            "#514460"
        )
        do
            local i = 0
            while i < 4 do
                rect(
                    nil,
                    c,
                    x - spread + 8,
                    y - 11 + i * 10,
                    spread - 18,
                    2,
                    "#8d789c"
                )
                rect(
                    nil,
                    c,
                    x + 10,
                    y - 11 + i * 10,
                    spread - 18,
                    2,
                    "#a68fae"
                )
                i = i + 1
            end
        end
        sparkle(
            nil,
            c,
            x,
            y - 31 - math.sin(t * 3) * 5,
            t,
            1,
            "#f6d7ff"
        )
    end
    local function drawing(self, c, x, y, t, kind, scale)
        if kind == nil then
            kind = "brainrot"
        end
        if scale == nil then
            scale = 1
        end
        c:save()
        c:translate(x, y)
        c:scale(scale, scale)
        local ____t_21 = __t
        local ____opt_19 = window.Art
        if ____opt_19 ~= nil then
            ____opt_19 = ____opt_19.drawMinion
        end
        if ____t_21(____opt_19) then
            window.Art:drawMinion(
                c,
                0,
                0,
                if kind == "sixseven" then 3 else 1,
                t,
                {type = kind, moving = true, range = 20}
            )
        else
            local ____t_24 = __t
            local ____opt_22 = window.Art
            if ____opt_22 ~= nil then
                ____opt_22 = ____opt_22.drawDoodle
            end
            if ____t_24(____opt_22) then
                window.Art:drawDoodle(
                    c,
                    0,
                    -18,
                    if kind == "sixseven" then 2 else 1,
                    t,
                    true
                )
            else
                rect(
                    nil,
                    c,
                    -14,
                    -30,
                    28,
                    28,
                    "#bb93d2"
                )
                rect(
                    nil,
                    c,
                    -8,
                    -23,
                    5,
                    5,
                    "#fff6ce"
                )
                rect(
                    nil,
                    c,
                    5,
                    -23,
                    5,
                    5,
                    "#fff6ce"
                )
            end
        end
        c:restore()
    end
    local function phraseBlock(self, c, text, x, y, t, color)
        if color == nil then
            color = "#d49ab4"
        end
        local w = __len(text) * 10 + 22
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + math.sin(t * 3) * 4 + 0.5)
        )
        rect(
            nil,
            c,
            -w / 2,
            -15,
            w,
            29,
            "#2a263be6"
        )
        rect(
            nil,
            c,
            -w / 2,
            12,
            w,
            3,
            color
        )
        word(
            nil,
            c,
            text,
            0,
            0,
            16,
            color
        )
        c:restore()
    end
    local function giantShadow(self, c, t)
        local pulse = math.sin(t * 2) * 8
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({180, 374}, 2),
                    __arrL({190, 213}, 2),
                    __arrL({248, 188}, 2),
                    __arrL({260, 121}, 2),
                    __arrL({332, 118}, 2),
                    __arrL({364, 80}, 2),
                    __arrL({582, 80}, 2),
                    __arrL({624, 123}, 2),
                    __arrL({704, 140}, 2),
                    __arrL({730, 209}, 2),
                    __arrL({790, 241}, 2),
                    __arrL({779, 374}, 2)
                },
                12
            ),
            "#151d2b"
        )
        do
            local i = 0
            while i < 8 do
                rect(
                    nil,
                    c,
                    210 + i * 77,
                    330 - math.sin(t * 2 + i) * 13,
                    25,
                    56,
                    "#1f2238"
                )
                i = i + 1
            end
        end
        rect(
            nil,
            c,
            350,
            167,
            64,
            22,
            "#c4f173"
        )
        rect(
            nil,
            c,
            547,
            167,
            64,
            22,
            "#c4f173"
        )
        rect(
            nil,
            c,
            368,
            168,
            14,
            20,
            "#29322e"
        )
        rect(
            nil,
            c,
            565,
            168,
            14,
            20,
            "#29322e"
        )
        rect(
            nil,
            c,
            434,
            237 + pulse * 0.2,
            90,
            14,
            "#b679a5"
        )
    end
    local function celestialSeal(self, c, x, y, t, scale)
        if scale == nil then
            scale = 1
        end
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        c:scale(scale, scale)
        do
            local i = 0
            while i < 12 do
                local a = i / 12 * math.pi * 2 + t * 0.14
                local cs = math.cos(a)
                local sn = math.sin(a)
                local r = 83 + math.sin(t * 3 + i) * 5
                line(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({cs * r, sn * r * 0.58}, 2),
                            __arrL({cs * (r + 18), sn * (r + 18) * 0.58}, 2)
                        },
                        2
                    ),
                    3,
                    if __t(__mod(i, 2)) then "#8be8ee" else "#ffe09c"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 5 do
                local a = i / 5 * math.pi * 2 - t * 0.12
                local x = math.cos(a) * 113
                local y = math.sin(a) * 62
                line(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x - 6, y + 4}, 2),
                            __arrL({x, y - 7}, 2),
                            __arrL({x + 7, y + 4}, 2),
                            __arrL({x - 6, y + 4}, 2)
                        },
                        4
                    ),
                    2,
                    "#ffe8a6"
                )
                i = i + 1
            end
        end
        c:restore()
        shockRing(
            nil,
            c,
            x,
            y,
            t,
            "#8fe9e7",
            120 * scale
        )
    end
    local function supremeSky(self, c, t)
        c:save()
        c.globalAlpha = 0.28
        do
            local i = 0
            while i < 6 do
                local x = 90 + i * 159 + math.sin(t * 0.6 + i) * 13
                poly(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x, 205}, 2),
                            __arrL({x + 31, 205}, 2),
                            __arrL({x + 85, 378}, 2),
                            __arrL({x - 65, 378}, 2)
                        },
                        4
                    ),
                    if __t(__mod(i, 2)) then "#83e2e8" else "#ffe39a"
                )
                i = i + 1
            end
        end
        c:restore()
        do
            local i = 0
            while i < 14 do
                local x = 360 + math.sin(i * 2.7 + t * 0.7) * 285
                local y = 212 + __mod(
                    __mod(i * 29 - t * 32, 185) + 185,
                    185
                )
                rect(
                    nil,
                    c,
                    x,
                    y,
                    3,
                    6,
                    if __t(__mod(i, 2)) then "#c5faf3" else "#ffe5a1"
                )
                i = i + 1
            end
        end
    end
    local function realityBin(self, c, x, y)
        rect(
            nil,
            c,
            x - 20,
            y - 48,
            40,
            47,
            "#4a6c5f"
        )
        rect(
            nil,
            c,
            x - 23,
            y - 52,
            46,
            7,
            "#325148"
        )
        rect(
            nil,
            c,
            x - 12,
            y - 40,
            4,
            31,
            "#739481"
        )
        rect(
            nil,
            c,
            x + 8,
            y - 40,
            4,
            31,
            "#739481"
        )
        rect(
            nil,
            c,
            x - 9,
            y - 58,
            18,
            6,
            "#325148"
        )
    end
    local function freddyFilm(self, c, s)
        local t = s.time
        local i = s.index
        local strong = not not __t(s.options.trained)
        local defeat = s.kind == "freddy_defeat"
        battleBackdrop(
            nil,
            c,
            s,
            "freddy",
            5
        )
        actor(
            nil,
            c,
            "daroca",
            230 + if __t(defeat) then ease(nil, t) * 35 else 0,
            378,
            t,
            {
                facing = 1,
                scale = 1.7,
                muscular = strong,
                attack = not __t(defeat) and i == 1,
                attackType = "paper",
                attackProgress = 0.48
            }
        )
        local enter = if __t(not __t(defeat) and i == 0) then ease(nil, t / 1.1) else 1
        local fx = if __t(defeat) then 665 else 810 - enter * 140
        local ____actor_30 = actor
        local ____c_29 = c
        local ____temp_27 = if __t(if __t(defeat) then i == 2 else defeat) then 1 else -1
        local ____temp_28 = if __t(defeat) then 2 else 2.12
        local ____t_26 = __t
        local ____temp_25 = not __t(defeat) and i == 0
        __O[699] = ____temp_25
        ____actor_30(
            nil,
            ____c_29,
            "freddy",
            fx,
            378,
            t,
            {
                facing = ____temp_27,
                scale = ____temp_28,
                moving = if ____t_26(____temp_25) then __lt(t, 1.1) else __O[699],
                speed = 180,
                recoil = if __t(if __t(defeat) then i == 0 else defeat) then 0.6 else 0,
                attack = not __t(defeat) and i == 2,
                attackType = "punch",
                attackProgress = __mod(t * 0.6, 1),
                pose = if __t(if __t(defeat) then i == 1 else defeat) then "fistbump" else nil
            }
        )
        local ____t_35 = __t
        local ____t_34 = __t
        local ____t_32 = __t
        local ____temp_31 = not __t(defeat) and i == 0
        __O[700] = ____temp_31
        local ____temp_33 = if ____t_32(____temp_31) then __O[700] else not __t(defeat) and i == 3
        __O[701] = ____temp_33
        if ____t_35(if ____t_34(____temp_33) then __O[701] else if __t(defeat) then i == 2 else defeat) then
            word(
                nil,
                c,
                "Ô REEEIS!",
                550,
                210 + math.sin(t * 4) * 4,
                22,
                "#f8d19c"
            )
            do
                local j = 0
                while j < 3 do
                    line(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({740 + j * 19, 260 - j * 9}, 2),
                                __arrL({749 + j * 19, 253 - j * 9}, 2),
                                __arrL({744 + j * 19, 244 - j * 9}, 2)
                            },
                            3
                        ),
                        2,
                        "#f7d9a0"
                    )
                    j = j + 1
                end
            end
        end
        if __t(not __t(defeat) and i == 2) then
            shockRing(
                nil,
                c,
                fx,
                370,
                t,
                "#e4bb82",
                75
            )
            word(
                nil,
                c,
                "O MAIS FORTE DOS CAPANGAS",
                475,
                215,
                17,
                "#f1c69d"
            )
        end
        if __t(not __t(defeat) and i == 3) then
            streaks(
                nil,
                c,
                t,
                "#e9b48f",
                0.7
            )
            shockRing(
                nil,
                c,
                fx,
                372,
                t,
                "#efc08e",
                110
            )
        end
        if __t(if __t(defeat) then i == 0 else defeat) then
            rect(
                nil,
                c,
                fx - 53,
                310,
                12,
                8,
                "#fff1d4"
            )
            rect(
                nil,
                c,
                fx - 40,
                306,
                11,
                5,
                "#d1d9c9"
            )
        end
        if __t(if __t(defeat) then i == 1 else defeat) then
            heart(
                nil,
                c,
                475,
                235 + math.sin(t * 2) * 3,
                0.8,
                false,
                t
            )
        end
    end
    local function nicolasFilm(self, c, s)
        local t = s.time
        local i = s.index
        local strong = not not __t(s.options.trained)
        local reveal = s.kind == "nicolas_reveal"
        if not __t(reveal) then
            if __lt(i, 2) then
                backdrop(
                    nil,
                    c,
                    s,
                    4,
                    4700
                )
            else
                backdrop(
                    nil,
                    c,
                    s,
                    4,
                    4700
                )
                c:save()
                c.globalAlpha = if i == 2 then ease(nil, t / 1.15) else 1
                battleBackdrop(
                    nil,
                    c,
                    s,
                    "nicolas",
                    4
                )
                supremeSky(nil, c, t)
                c:restore()
            end
            local awakened = __ge(i, 2)
            local charge = i == 2 and __lt(t, 1.15)
            local hover = if __t(awakened) then math.sin(t * 2) * 3 else 0
            if __t(awakened) then
                celestialSeal(
                    nil,
                    c,
                    650,
                    302,
                    t,
                    1
                )
                streaks(
                    nil,
                    c,
                    t,
                    "#e3f6e5",
                    if i == 2 then 0.45 else 0.8
                )
            end
            actor(
                nil,
                c,
                "daroca",
                if i == 4 then 270 else 230,
                378,
                t,
                {
                    facing = 1,
                    scale = if i == 4 then 1.85 else 1.7,
                    muscular = strong,
                    recoil = if i == 2 then 0.4 else 0,
                    attack = i == 1 or i == 4,
                    attackType = if i == 1 then "punch" else "paper",
                    attackProgress = 0.5
                }
            )
            actor(
                nil,
                c,
                "nicolas",
                650,
                378 - hover,
                t,
                {
                    facing = -1,
                    scale = if __t(awakened) then 2.05 else 1.85,
                    supreme = awakened,
                    powered = awakened,
                    transformed = awakened,
                    energy = awakened,
                    charging = charge,
                    attack = i == 3,
                    attackType = "cast",
                    attackProgress = __mod(t * 0.5, 1)
                }
            )
            if i == 0 then
                word(
                    nil,
                    c,
                    "PROTAGONISTA",
                    650,
                    226 + math.sin(t * 2) * 3,
                    18,
                    "#e7d299"
                )
            end
            if i == 1 then
                rect(
                    nil,
                    c,
                    566,
                    363,
                    167,
                    8,
                    "#74b7ba"
                )
                rect(
                    nil,
                    c,
                    578,
                    367,
                    140,
                    4,
                    "#b8e4d8"
                )
                sparkle(
                    nil,
                    c,
                    641,
                    363,
                    t,
                    1,
                    "#d5f2eb"
                )
            end
            if __t(i == 2 and __gt(t, 1.15)) then
                shockRing(
                    nil,
                    c,
                    650,
                    312,
                    t - 1.15,
                    "#f9dc91",
                    200
                )
                word(
                    nil,
                    c,
                    "AURA SUPREMA",
                    480,
                    210,
                    24,
                    "#fff0ad"
                )
            end
            if i == 3 then
                do
                    local k = 0
                    while k < 3 do
                        local x = 350 + k * 122
                        local y = 240 + math.sin(t * 2 + k) * 17
                        line(
                            nil,
                            c,
                            __arrL(
                                {
                                    __arrL({x - 8, y}, 2),
                                    __arrL({x, y - 12}, 2),
                                    __arrL({x + 8, y}, 2),
                                    __arrL({x, y + 12}, 2),
                                    __arrL({x - 8, y}, 2)
                                },
                                5
                            ),
                            2,
                            if __t(__mod(k, 2)) then "#9cebef" else "#ffe5a2"
                        )
                        k = k + 1
                    end
                end
            end
        else
            local dissolve = if i == 1 then ease(nil, t / 1.2) else if __gt(i, 1) then 1 else 0
            backdrop(
                nil,
                c,
                s,
                4,
                4700
            )
            if dissolve < 1 then
                c:save()
                c.globalAlpha = 1 - dissolve
                battleBackdrop(
                    nil,
                    c,
                    s,
                    "nicolas",
                    4
                )
                supremeSky(nil, c, t)
                celestialSeal(
                    nil,
                    c,
                    650,
                    302,
                    t,
                    1
                )
                actor(
                    nil,
                    c,
                    "nicolas",
                    650,
                    378,
                    t,
                    {
                        facing = -1,
                        scale = 2.05,
                        supreme = true,
                        powered = true,
                        transformed = true,
                        energy = true,
                        recoil = 0.65
                    }
                )
                c:restore()
            end
            actor(
                nil,
                c,
                "daroca",
                265,
                378,
                t,
                {
                    facing = 1,
                    scale = 1.8,
                    muscular = strong,
                    attack = i == 1 or i == 4,
                    attackType = "punch",
                    attackProgress = 0.4
                }
            )
            if dissolve > 0 then
                c:save()
                c.globalAlpha = dissolve
                realityBin(nil, c, 760, 378)
                actor(
                    nil,
                    c,
                    "nicolas",
                    650,
                    378,
                    t,
                    {
                        facing = if i == 3 then 1 else -1,
                        scale = 1.8,
                        moving = i == 2,
                        speed = if i == 2 then 70 else 0,
                        attack = i == 2 or i == 3,
                        attackType = "punch",
                        attackProgress = __mod(t * 0.8, 1)
                    }
                )
                c:restore()
            end
            if i == 0 then
                do
                    local k = 0
                    while k < 10 do
                        local a = k / 10 * math.pi * 2
                        rect(
                            nil,
                            c,
                            650 + math.cos(a + t) * 100,
                            300 + math.sin(a + t) * 68,
                            7,
                            4,
                            if __t(__mod(k, 2)) then "#d3ffff" else "#fbe2a4"
                        )
                        k = k + 1
                    end
                end
                word(
                    nil,
                    c,
                    "ROTEIRO INTERROMPIDO",
                    480,
                    214,
                    18,
                    "#ffe6b5"
                )
            end
            if i == 1 then
                do
                    local k = 0
                    while k < 9 do
                        local x = 300 + k * 62
                        local y = 214 + __mod(t * 145 + k * 29, 160)
                        line(
                            nil,
                            c,
                            __arrL(
                                {
                                    __arrL({x - 7, y}, 2),
                                    __arrL({x + 8, y + 2}, 2),
                                    __arrL({x + 3, y + 17}, 2),
                                    __arrL({x - 7, y}, 2)
                                },
                                4
                            ),
                            2,
                            "#c1ece5"
                        )
                        k = k + 1
                    end
                end
            end
            if i == 2 then
                word(
                    nil,
                    c,
                    "VRUM! PÁ! CABUM!",
                    650,
                    222 + math.sin(t * 7) * 4,
                    17,
                    "#e5ce97"
                )
                local x = 650 + math.sin(t * 4) * 45
                line(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x + 28, 303}, 2),
                            __arrL({x + 43, 300}, 2)
                        },
                        2
                    ),
                    2,
                    "#d0b66e"
                )
            end
            if i == 3 then
                word(
                    nil,
                    c,
                    "FOI ÉPICO. EU TAVA LÁ.",
                    650,
                    225,
                    16,
                    "#eadcaa"
                )
                sparkle(
                    nil,
                    c,
                    648,
                    270,
                    t,
                    0.6,
                    "#e3d9a9"
                )
            end
            if i == 4 then
                local paperX = 690 + math.sin(t * 3) * 4
                rect(
                    nil,
                    c,
                    paperX,
                    361,
                    6,
                    5,
                    "#e7e3ce"
                )
                word(
                    nil,
                    c,
                    "…",
                    760,
                    304 + math.sin(t * 2) * 2,
                    24,
                    "#cee0c7"
                )
            end
        end
    end
    local function dedeFilm(self, c, s)
        local t = s.time
        local i = s.index
        local defeat = s.kind == "dede_defeat"
        battleBackdrop(
            nil,
            c,
            s,
            "dede",
            5
        )
        actor(
            nil,
            c,
            "daroca",
            245,
            378,
            t,
            {
                facing = 1,
                scale = 1.8,
                muscular = not not __t(s.options.trained),
                attack = not __t(defeat) and i == 3,
                attackType = "fart",
                attackProgress = __mod(t * 0.6, 1)
            }
        )
        actor(
            nil,
            c,
            "dede",
            665,
            378,
            t,
            {
                facing = -1,
                scale = 2,
                recoil = if __t(if __t(defeat) then i == 0 else defeat) then 0.5 else 0,
                attack = not __t(defeat) and i == 2,
                attackType = "cast",
                attackProgress = __mod(t * 0.6, 1),
                smoke = not __t(defeat)
            }
        )
        if not __t(defeat) then
            c:save()
            c.globalAlpha = 0.2
            do
                local k = 0
                while k < 8 do
                    local x = 510 + math.sin(t * 0.4 + k) * 90 + k * 25
                    local y = 288 - __mod(t * 19 + k * 27, 95)
                    rect(
                        nil,
                        c,
                        x,
                        y,
                        42 + __mod(k, 3) * 14,
                        17,
                        "#c5d1c6"
                    )
                    rect(
                        nil,
                        c,
                        x + 10,
                        y - 8,
                        23,
                        9,
                        "#d6ded0"
                    )
                    k = k + 1
                end
            end
            c:restore()
            if __t(i == 1 or i == 3) then
                do
                    local k = 0
                    while k < 5 do
                        local x = 300 + __mod(t * 155 + k * 47, 310)
                        line(
                            nil,
                            c,
                            __arrL(
                                {
                                    __arrL({x, 320 + k * 8}, 2),
                                    __arrL({x + 24, 315 + k * 8}, 2),
                                    __arrL({x + 39, 320 + k * 8}, 2)
                                },
                                3
                            ),
                            2,
                            "#d5e9b8"
                        )
                        k = k + 1
                    end
                end
            end
        else
            do
                local k = 0
                while k < 4 do
                    rect(
                        nil,
                        c,
                        690 + __mod(t * 24 + k * 32, 120),
                        288 - k * 21,
                        15,
                        3,
                        "#d2dbbf88"
                    )
                    k = k + 1
                end
            end
            if i == 2 then
                word(
                    nil,
                    c,
                    "O FREDDY NEM VAI FICAR SABENDO...",
                    480,
                    228,
                    13,
                    "#ecd2aa"
                )
            end
        end
    end
    local function arthurFilm(self, c, s)
        local t = s.time
        local i = s.index
        local revenge = s.kind == "arthur_revenge"
        backdrop(
            nil,
            c,
            s,
            9,
            1050
        )
        if not __t(revenge) then
            actor(
                nil,
                c,
                "daroca",
                155,
                378,
                t,
                {
                    facing = 1,
                    scale = 1.7,
                    muscular = not not __t(s.options.trained),
                    attack = i == 2,
                    attackType = "punch",
                    attackProgress = 0.4
                }
            )
            actor(
                nil,
                c,
                "ravile",
                380,
                378,
                t,
                {facing = 1, scale = 1.65, injured = true, fallen = true}
            )
            actor(
                nil,
                c,
                "aica",
                292,
                378,
                t,
                {facing = 1, scale = 1.7, helping = true}
            )
            actor(
                nil,
                c,
                "arthur",
                710,
                378,
                t,
                {
                    facing = -1,
                    scale = 1.9,
                    expressive = true,
                    moving = i == 3,
                    speed = if i == 3 then 70 else 0,
                    pose = if i == 1 then "offer" else nil
                }
            )
            if i == 0 then
                heart(
                    nil,
                    c,
                    350,
                    278,
                    0.65,
                    false,
                    t
                )
                word(
                    nil,
                    c,
                    "EI, CALMA!",
                    267,
                    249,
                    15,
                    "#f3d6a9"
                )
            end
            if i == 2 then
                line(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({190, 318}, 2),
                            __arrL({217, 312}, 2),
                            __arrL({233, 315}, 2)
                        },
                        3
                    ),
                    2,
                    "#f2dfaf"
                )
            end
            if i == 3 then
                streaks(
                    nil,
                    c,
                    t,
                    "#eee3b6",
                    0.45
                )
            end
        else
            actor(
                nil,
                c,
                "daroca",
                155,
                378,
                t,
                {
                    facing = 1,
                    scale = 1.7,
                    muscular = not not __t(s.options.trained)
                }
            )
            actor(
                nil,
                c,
                "aica",
                302,
                378,
                t,
                {
                    facing = 1,
                    scale = 1.75,
                    helping = i == 0,
                    attack = i == 1,
                    attackType = "punch",
                    attackProgress = 0.35
                }
            )
            if i == 1 then
                actor(
                    nil,
                    c,
                    "arthur",
                    575,
                    378,
                    t,
                    {
                        facing = -1,
                        scale = 1.7,
                        expressive = true,
                        pose = "earpulled",
                        recoil = 0.25
                    }
                )
                actor(
                    nil,
                    c,
                    "ravile",
                    500,
                    378,
                    t,
                    {facing = 1, scale = 1.7, pose = "earpull"}
                )
                do
                    local k = 0
                    while k < 3 do
                        line(
                            nil,
                            c,
                            __arrL(
                                {
                                    __arrL({562 + k * 9, 277 - k * 7}, 2),
                                    __arrL({566 + k * 9, 269 - k * 7}, 2)
                                },
                                2
                            ),
                            2,
                            "#f6d58f"
                        )
                        k = k + 1
                    end
                end
                word(
                    nil,
                    c,
                    "OPEEEESTIIIIIIIII",
                    480,
                    222 + math.sin(t * 4) * 2,
                    21,
                    "#ffe4ad"
                )
            else
                actor(
                    nil,
                    c,
                    "ravile",
                    480,
                    378,
                    t,
                    {facing = 1, scale = 1.7, pose = if i == 3 then "offer" else nil}
                )
                actor(
                    nil,
                    c,
                    "arthur",
                    655,
                    378,
                    t,
                    {
                        facing = -1,
                        scale = 1.8,
                        expressive = true,
                        pose = if __t(i == 2 or i == 3) then "offer" else nil,
                        recoil = if i == 0 then 0.2 else 0
                    }
                )
                if i == 3 then
                    heart(
                        nil,
                        c,
                        558,
                        245 + math.sin(t * 2) * 3,
                        0.95,
                        false,
                        t
                    )
                    sparkle(
                        nil,
                        c,
                        565,
                        320,
                        t,
                        1,
                        "#e1ebbc"
                    )
                end
            end
        end
    end
    local PARTY_GROUPS = __arrL(
        {
            __arrL({
                "daroca",
                "lucas",
                "reeis",
                "nikolas",
                "davi",
                "vitor"
            }, 6),
            __arrL({
                "mota",
                "caleb",
                "almiro",
                "miqueias",
                "kaua"
            }, 5),
            __arrL({
                "freddy",
                "dede",
                "marco",
                "menezes",
                "nicolas"
            }, 5),
            __arrL({
                "aica",
                "ravile",
                "arthur",
                "ravid",
                "giant"
            }, 5),
            __arrL({
                "allef",
                "eloisa",
                "giselle",
                "rayssa",
                "analaura",
                "amanda"
            }, 6)
        },
        5
    )
    local PARTY_CAST = __call(PARTY_GROUPS, "flat")
    local function acai(self, c, x, y, t, scale)
        if scale == nil then
            scale = 1
        end
        local ____t_38 = __t
        local ____opt_36 = window.Art
        if ____opt_36 ~= nil then
            ____opt_36 = ____opt_36.drawAcai
        end
        if ____t_38(____opt_36) then
            window.Art:drawAcai(
                c,
                x,
                y,
                t,
                {scale = scale}
            )
            return
        end
        c:save()
        c:translate(x, y)
        c:scale(scale, scale)
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({-26, -13}, 2),
                    __arrL({26, -13}, 2),
                    __arrL({18, 12}, 2),
                    __arrL({-18, 12}, 2)
                },
                4
            ),
            "#c2a56e"
        )
        rect(
            nil,
            c,
            -28,
            -19,
            56,
            10,
            "#563463"
        )
        rect(
            nil,
            c,
            -23,
            -19,
            46,
            3,
            "#926494"
        )
        do
            local j = 0
            while j < 3 do
                rect(
                    nil,
                    c,
                    -16 + j * 13,
                    -21,
                    9,
                    6,
                    "#ead7a0"
                )
                rect(
                    nil,
                    c,
                    -14 + j * 13,
                    -20,
                    4,
                    2,
                    "#c5ab70"
                )
                j = j + 1
            end
        end
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({17, -15}, 2),
                    __arrL({32, -41}, 2)
                },
                2
            ),
            4,
            "#e6e1c7"
        )
        c:restore()
    end
    local function partyBackdrop(self, c, s)
        backdrop(
            nil,
            c,
            s,
            4,
            3130
        )
        rect(
            nil,
            c,
            0,
            0,
            960,
            373,
            "#77506b14"
        )
        local t = s.time
        line(
            nil,
            c,
            __arrL(
                {
                    __arrL({0, 216}, 2),
                    __arrL({240, 235}, 2),
                    __arrL({480, 224}, 2),
                    __arrL({720, 235}, 2),
                    __arrL({960, 215}, 2)
                },
                5
            ),
            2,
            "#53604b"
        )
        do
            local j = 0
            while j < 15 do
                local x = 28 + j * 66
                local y = 218 + math.sin(j / 14 * math.pi) * 13
                poly(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x - 11, y}, 2),
                            __arrL({x + 11, y + 1}, 2),
                            __arrL({x, y + 17}, 2)
                        },
                        3
                    ),
                    __get(
                        __arrL({"#e6bc6f", "#b989b0", "#b7d28b", "#8cbec4"}, 4),
                        __mod(j, 4)
                    )
                )
                sparkle(
                    nil,
                    c,
                    x + 25,
                    y + 3,
                    t + j,
                    0.55,
                    if __t(__mod(j, 2)) then "#fae5a2" else "#dedda3"
                )
                j = j + 1
            end
        end
        rect(
            nil,
            c,
            0,
            378,
            960,
            32,
            "#6c7848"
        )
        rect(
            nil,
            c,
            0,
            378,
            960,
            4,
            "#b4c27c"
        )
        rect(
            nil,
            c,
            65,
            405,
            830,
            20,
            "#e4cba0"
        )
        rect(
            nil,
            c,
            65,
            405,
            830,
            5,
            "#f3deb2"
        )
        do
            local j = 0
            while j < 9 do
                rect(
                    nil,
                    c,
                    83 + j * 92,
                    410,
                    42,
                    4,
                    if __t(__mod(j, 2)) then "#b68bb0" else "#a6b97b"
                )
                j = j + 1
            end
        end
    end
    local function partyGuest(self, c, ____type, x, y, t, focus)
        if focus == nil then
            focus = false
        end
        local giant = ____type == "giant"
        actor(
            nil,
            c,
            ____type,
            x,
            y,
            t,
            {
                facing = if __lt(x, 480) then 1 else -1,
                scale = if __t(giant) then 0.48 else if __t(focus) then 1.65 else 1.35,
                muscular = ____type == "daroca",
                smoke = false,
                talking = ____type == "ravid",
                moving = false,
                pose = if math.sin(t * 1.6 + x) > 0.55 then "offer" else nil,
                emotion = "friend",
                frame = t + x * 0.012
            }
        )
    end
    local function celebration(self, c, s)
        local t = s.time
        local i = s.index
        partyBackdrop(nil, c, s)
        confetti(nil, c, t, 36)
        if __lt(
            i,
            __len(PARTY_GROUPS)
        ) then
            local group = __get(PARTY_GROUPS, i)
            local step = if __len(group) == 6 then 145 else 165
            local start = if __len(group) == 6 then 110 else 150
            __call(
                group,
                "forEach",
                function(____, ____type, j) return partyGuest(
                    nil,
                    c,
                    ____type,
                    start + j * step,
                    378 + math.sin(t * 2 + j) * 2,
                    t
                ) end
            )
            ____table(nil, c, 340, 414)
            ____table(nil, c, 655, 414)
            cake(
                nil,
                c,
                340,
                364,
                1.15
            )
            acai(
                nil,
                c,
                655,
                367,
                t,
                1.2
            )
            if i == 2 then
                word(
                    nil,
                    c,
                    "HOJE A ÚNICA BATALHA É PELA COLHER!",
                    480,
                    265,
                    14,
                    "#f8e5b6"
                )
            end
            if i == 3 then
                rect(
                    nil,
                    c,
                    828,
                    302,
                    15,
                    22,
                    "#eee7d0"
                )
                rect(
                    nil,
                    c,
                    830,
                    305,
                    11,
                    2,
                    "#c3c8ae"
                )
                word(
                    nil,
                    c,
                    "O MONSTRO TROUXE GUARDANAPO.",
                    480,
                    261,
                    13,
                    "#e8edc5"
                )
            end
        elseif i == __len(PARTY_GROUPS) then
            partyGuest(
                nil,
                c,
                "daroca",
                315,
                378,
                t,
                true
            )
            partyGuest(
                nil,
                c,
                "lucas",
                630,
                378,
                t,
                true
            )
            partyGuest(
                nil,
                c,
                "davi",
                795,
                378,
                t
            )
            partyGuest(
                nil,
                c,
                "vitor",
                130,
                378,
                t
            )
            ____table(nil, c, 490, 394)
            cake(
                nil,
                c,
                425,
                345,
                1
            )
            acai(
                nil,
                c,
                550,
                342,
                t,
                1.85
            )
            do
                local j = 0
                while j < 7 do
                    sparkle(
                        nil,
                        c,
                        465 + j * 23,
                        277 + math.sin(t * 3 + j) * 10,
                        t + j,
                        0.75,
                        "#ead3f1"
                    )
                    j = j + 1
                end
            end
            word(
                nil,
                c,
                "QUARTA-FEIRA · AÇAÍ DA VITÓRIA",
                480,
                238,
                19,
                "#f1d2ec"
            )
            heart(
                nil,
                c,
                480,
                281 + math.sin(t * 2) * 3,
                0.65,
                false,
                t
            )
        else
            local backgroundGuests = __call(
                PARTY_CAST,
                "filter",
                function(____, ____type) return ____type ~= "daroca" and ____type ~= "reeis" end
            )
            local offset = ease(nil, t / 4) * (__len(backgroundGuests) * 126 - 820)
            __call(
                backgroundGuests,
                "forEach",
                function(____, ____type, j)
                    local x = 90 + j * 126 - offset
                    if __t(x > -70 and x < 1030) then
                        partyGuest(
                            nil,
                            c,
                            ____type,
                            x,
                            364 + math.sin(t * 2 + j) * 2,
                            t
                        )
                    end
                end
            )
            rect(
                nil,
                c,
                0,
                397,
                960,
                18,
                "#e5c693"
            )
            rect(
                nil,
                c,
                0,
                397,
                960,
                4,
                "#f1ddae"
            )
            do
                local j = 0
                while j < 7 do
                    local x = __mod(j * 175 - offset * 0.6 + 2000, 1175) - 80
                    if __t(__mod(j, 2)) then
                        cake(
                            nil,
                            c,
                            x,
                            397,
                            0.6
                        )
                    else
                        acai(
                            nil,
                            c,
                            x,
                            398,
                            t,
                            0.72
                        )
                    end
                    j = j + 1
                end
            end
            partyGuest(
                nil,
                c,
                "daroca",
                150,
                411,
                t
            )
            partyGuest(
                nil,
                c,
                "reeis",
                730,
                411,
                t
            )
            word(
                nil,
                c,
                "BOLO RECUPERADO. RESENHA LIBERADA.",
                480,
                244,
                19,
                "#f7e6b9"
            )
            word(
                nil,
                c,
                "A QUARTA-FEIRA TEM GOSTO DE VITÓRIA!",
                480,
                272,
                13,
                "#e4c8ee"
            )
        end
    end
    local function bossFilm(self, c, s)
        local t = s.time
        local i = s.index
        local strong = not not __t(s.options.trained)
        if __t(s.kind == "boss_dede" or s.kind == "dede_defeat") then
            dedeFilm(nil, c, s)
        elseif __t(s.kind == "boss_arthur" or s.kind == "arthur_revenge") then
            arthurFilm(nil, c, s)
        elseif s.kind == "celebration" then
            celebration(nil, c, s)
        elseif __t(s.kind == "boss_freddy" or s.kind == "freddy_defeat") then
            freddyFilm(nil, c, s)
        elseif __t(s.kind == "boss_nicolas" or s.kind == "nicolas_reveal") then
            nicolasFilm(nil, c, s)
        elseif s.kind == "boss_marco" then
            battleBackdrop(
                nil,
                c,
                s,
                "marco",
                1
            )
            if i == 0 then
                sketchbook(
                    nil,
                    c,
                    515,
                    311,
                    t,
                    ease(nil, t)
                )
                actor(
                    nil,
                    c,
                    "marco",
                    650 - ease(nil, t) * 70,
                    378,
                    t,
                    {
                        facing = -1,
                        scale = 2.1,
                        attack = true,
                        attackType = "doodle",
                        attackProgress = __mod(t * 0.7, 1)
                    }
                )
                actor(
                    nil,
                    c,
                    "daroca",
                    220,
                    378,
                    t,
                    {facing = 1, scale = 1.65, muscular = strong}
                )
            elseif i == 1 then
                actor(
                    nil,
                    c,
                    "daroca",
                    260,
                    378,
                    t,
                    {facing = 1, scale = 1.85, muscular = strong, emotion = "taunted"}
                )
                drawing(
                    nil,
                    c,
                    505 + math.sin(t * 2) * 25,
                    341 - math.abs(math.sin(t * 3)) * 24,
                    t,
                    "brainrot",
                    1.6
                )
                drawing(
                    nil,
                    c,
                    730 + math.cos(t * 2) * 24,
                    352,
                    t,
                    "sixseven",
                    1.65
                )
                word(
                    nil,
                    c,
                    "6  7",
                    714,
                    205 + math.sin(t * 3) * 5,
                    29,
                    "#f0d68f"
                )
            elseif i == 2 then
                actor(
                    nil,
                    c,
                    "marco",
                    645,
                    378,
                    t,
                    {
                        facing = -1,
                        scale = 2.2,
                        attack = true,
                        attackType = "doodle",
                        attackProgress = 0.5
                    }
                )
                rect(
                    nil,
                    c,
                    338,
                    364,
                    174,
                    13,
                    "#9c669f"
                )
                rect(
                    nil,
                    c,
                    344,
                    367,
                    162,
                    4,
                    "#dcaddc"
                )
                word(
                    nil,
                    c,
                    "SARUÊ!",
                    425,
                    351,
                    20,
                    "#ecc4e8"
                )
                shockRing(
                    nil,
                    c,
                    425,
                    371,
                    t,
                    "#d2a7e5",
                    95
                )
                actor(
                    nil,
                    c,
                    "daroca",
                    210,
                    378,
                    t,
                    {facing = 1, scale = 1.75, muscular = strong}
                )
            else
                actor(
                    nil,
                    c,
                    "daroca",
                    270 + ease(nil, t / 1.4) * 35,
                    378,
                    t,
                    {
                        facing = 1,
                        scale = 1.9,
                        muscular = strong,
                        attack = true,
                        attackType = "paper",
                        attackProgress = __mod(t * 0.5, 1)
                    }
                )
                actor(
                    nil,
                    c,
                    "marco",
                    680,
                    378,
                    t,
                    {
                        facing = -1,
                        scale = 2.15,
                        attack = true,
                        attackType = "doodle",
                        attackProgress = __mod(t * 0.6, 1)
                    }
                )
                streaks(nil, c, t, "#e8c5ec")
            end
        elseif s.kind == "boss_menezes" then
            battleBackdrop(
                nil,
                c,
                s,
                "menezes",
                1
            )
            actor(
                nil,
                c,
                "daroca",
                220,
                378,
                t,
                {facing = 1, scale = 1.7, muscular = strong}
            )
            actor(
                nil,
                c,
                "menezes",
                690,
                378,
                t,
                {
                    facing = -1,
                    scale = if i == 2 then 2.3 else 2,
                    attack = true,
                    attackType = "word",
                    attackProgress = __mod(t * 0.9, 1)
                }
            )
            if i == 0 then
                phraseBlock(
                    nil,
                    c,
                    "DA ROÇA POUDIAAAM",
                    465 - ease(nil, t / 1.8) * 120,
                    233,
                    t
                )
                phraseBlock(
                    nil,
                    c,
                    "REEEIS POUDDIAAAM",
                    560 + ease(nil, t / 1.8) * 80,
                    286,
                    t + 2,
                    "#e5c78d"
                )
            elseif i == 1 then
                do
                    local k = 0
                    while k < 4 do
                        phraseBlock(
                            nil,
                            c,
                            if __t(__mod(k, 2)) then "PEGOU AR" else "POUDI",
                            560 + k * 8,
                            190 + k * 37,
                            t + k,
                            "#edb3ce"
                        )
                        k = k + 1
                    end
                end
                shockRing(
                    nil,
                    c,
                    660,
                    374,
                    t,
                    "#d1d89c",
                    240
                )
            elseif i == 2 then
                local x = 700 - __mod(t * 150, 680)
                phraseBlock(
                    nil,
                    c,
                    "TEKETEKETEKE",
                    x,
                    259,
                    t,
                    "#e7b7cf"
                )
                phraseBlock(
                    nil,
                    c,
                    "TEKETEKETEKE",
                    960 - x,
                    307,
                    t + 1,
                    "#aabddd"
                )
                do
                    local k = 0
                    while k < 8 do
                        rect(
                            nil,
                            c,
                            175 + k * 87,
                            365 + math.sin(t * 7 + k) * 8,
                            34,
                            5,
                            "#debc95"
                        )
                        k = k + 1
                    end
                end
            else
                streaks(nil, c, t, "#eed19b")
                actor(
                    nil,
                    c,
                    "daroca",
                    266,
                    378,
                    t,
                    {
                        facing = 1,
                        scale = 1.9,
                        muscular = strong,
                        attack = true,
                        attackType = "paper",
                        attackProgress = __mod(t * 0.7, 1)
                    }
                )
                phraseBlock(
                    nil,
                    c,
                    "VULNERÁVEL!",
                    665,
                    209,
                    t,
                    "#d9ebae"
                )
            end
        elseif s.kind == "boss_nikolas" then
            battleBackdrop(
                nil,
                c,
                s,
                "nikolas",
                3
            )
            actor(
                nil,
                c,
                "daroca",
                230,
                378,
                t,
                {facing = 1, scale = 1.8, muscular = strong}
            )
            actor(
                nil,
                c,
                "nikolas",
                665,
                378,
                t,
                {
                    facing = -1,
                    scale = if __t(i == 1 or i == 2) then 2.45 else 2.05,
                    attack = i ~= 0,
                    noseRub = i ~= 0,
                    attackType = "slime",
                    attackProgress = 0.6,
                    emotion = if i == 0 then "sad" else "greed"
                }
            )
            cake(
                nil,
                c,
                500,
                347,
                1.1
            )
            if i == 0 then
                c:save()
                c.globalAlpha = 0.22
                heart(
                    nil,
                    c,
                    475,
                    188,
                    1.7,
                    true,
                    t
                )
                c:restore()
            elseif i == 1 then
                stomach(
                    nil,
                    c,
                    650,
                    316,
                    t
                )
                word(
                    nil,
                    c,
                    "BATATA!",
                    480,
                    208 + math.sin(t * 3) * 5,
                    24,
                    "#f1d18c"
                )
            elseif i == 2 then
                do
                    local k = 0
                    while k < 9 do
                        local a = k / 9 * math.pi * 2
                        rect(
                            nil,
                            c,
                            651 + math.cos(a + t) * 82,
                            255 + math.sin(a + t) * 70,
                            7,
                            10,
                            "#c9e37b"
                        )
                        k = k + 1
                    end
                end
                streaks(
                    nil,
                    c,
                    t,
                    "#e5f2b1",
                    0.7
                )
            else
                actor(
                    nil,
                    c,
                    "daroca",
                    262,
                    378,
                    t,
                    {
                        facing = 1,
                        scale = 2,
                        muscular = strong,
                        attack = true,
                        attackType = "fart",
                        attackProgress = __mod(t * 0.6, 1)
                    }
                )
                shockRing(
                    nil,
                    c,
                    485,
                    340,
                    t,
                    "#f5d5a1",
                    210
                )
            end
        elseif s.kind == "boss_reeis" then
            battleBackdrop(
                nil,
                c,
                s,
                "reeisBoss",
                5
            )
            local enter = ease(nil, t / 1.2)
            actor(
                nil,
                c,
                "daroca",
                200 + enter * 35,
                378,
                t,
                {
                    facing = 1,
                    scale = 1.55,
                    muscular = strong,
                    moving = __lt(t, 1.2),
                    speed = 100
                }
            )
            actor(
                nil,
                c,
                "reeis",
                665,
                378,
                t,
                {
                    facing = -1,
                    scale = 1.35,
                    transformed = true,
                    powered = __gt(i, 1),
                    aura = __gt(i, 1),
                    charging = i == 2,
                    attack = i == 2,
                    attackType = "gun",
                    attackProgress = __mod(t * 0.8, 1)
                }
            )
            if i == 0 then
                do
                    local k = 0
                    while k < 7 do
                        rect(
                            nil,
                            c,
                            535 + k * 27,
                            126 + __mod(k, 2) * 7,
                            10,
                            3,
                            "#e3ce87"
                        )
                        k = k + 1
                    end
                end
            elseif i == 1 then
                word(
                    nil,
                    c,
                    "REI DO MORRO",
                    645,
                    160 + math.sin(t * 2) * 5,
                    20,
                    "#e7d392"
                )
                shockRing(
                    nil,
                    c,
                    655,
                    364,
                    t,
                    "#e4c07c",
                    160
                )
            elseif i == 2 then
                streaks(nil, c, t, "#fff0ae")
                do
                    local k = 0
                    while k < 5 do
                        local x = 610 - __mod(t * 190 + k * 69, 450)
                        rect(
                            nil,
                            c,
                            x,
                            285 + k * 12,
                            17,
                            5,
                            "#e5ce8c"
                        )
                        k = k + 1
                    end
                end
            else
                actor(
                    nil,
                    c,
                    "daroca",
                    285,
                    378,
                    t,
                    {
                        facing = 1,
                        scale = 1.9,
                        muscular = strong,
                        attack = true,
                        attackType = "paper",
                        attackProgress = __mod(t * 0.6, 1)
                    }
                )
                heart(
                    nil,
                    c,
                    433,
                    229 + math.sin(t * 3) * 4,
                    1,
                    false,
                    t
                )
            end
        elseif s.kind == "boss_giant" then
            battleBackdrop(
                nil,
                c,
                s,
                "giant",
                6
            )
            actor(
                nil,
                c,
                "daroca",
                175,
                378,
                t,
                {facing = 1, scale = 1.5, muscular = strong}
            )
            if i == 0 then
                giantShadow(nil, c, t)
                sketchbook(
                    nil,
                    c,
                    495,
                    352,
                    t,
                    1
                )
                do
                    local k = 0
                    while k < 12 do
                        rect(
                            nil,
                            c,
                            300 + k * 29,
                            320 - __mod(t * 60 + k * 11, 170),
                            5,
                            8,
                            "#d4b4e2"
                        )
                        k = k + 1
                    end
                end
                actor(
                    nil,
                    c,
                    "daroca",
                    165,
                    378,
                    t,
                    {facing = 1, scale = 1.5, muscular = strong}
                )
            elseif i == 1 then
                actor(
                    nil,
                    c,
                    "giant",
                    625,
                    383,
                    t,
                    {
                        facing = -1,
                        scale = 1.3,
                        attack = true,
                        attackType = "smash",
                        attackProgress = __mod(t * 0.65, 1)
                    }
                )
                word(
                    nil,
                    c,
                    "SIX… SEVEN!",
                    660,
                    70 + math.sin(t * 4) * 5,
                    26,
                    "#d8f39a"
                )
                streaks(nil, c, t, "#d9b4ed")
            elseif i == 2 then
                actor(
                    nil,
                    c,
                    "giant",
                    642,
                    383,
                    t,
                    {
                        facing = -1,
                        scale = 1.18,
                        attack = true,
                        attackType = "smash",
                        attackProgress = __mod(t * 0.7, 1)
                    }
                )
                shockRing(
                    nil,
                    c,
                    605,
                    373,
                    t,
                    "#d0a1df",
                    260
                )
                do
                    local k = 0
                    while k < 5 do
                        local yy = 95 + __mod(t * 82 + k * 39, 250)
                        rect(
                            nil,
                            c,
                            315 + k * 93,
                            yy,
                            25,
                            32,
                            "#dfcee2"
                        )
                        rect(
                            nil,
                            c,
                            320 + k * 93,
                            yy + 9,
                            15,
                            2,
                            "#9b83a6"
                        )
                        k = k + 1
                    end
                end
                drawing(
                    nil,
                    c,
                    383,
                    376,
                    t,
                    "sixseven",
                    1.3
                )
            else
                actor(
                    nil,
                    c,
                    "giant",
                    682,
                    383,
                    t,
                    {facing = -1, scale = 1.25, attack = false}
                )
                actor(
                    nil,
                    c,
                    "reeis",
                    320,
                    378,
                    t,
                    {
                        facing = 1,
                        scale = 1.15,
                        transformed = true,
                        powered = true,
                        aura = true
                    }
                )
                actor(
                    nil,
                    c,
                    "daroca",
                    175,
                    378,
                    t,
                    {
                        facing = 1,
                        scale = 1.6,
                        muscular = strong,
                        attack = true,
                        attackType = "fart",
                        attackProgress = __mod(t * 0.7, 1)
                    }
                )
                streaks(nil, c, t, "#f3dfb0")
            end
        elseif s.kind == "marco_rage" then
            battleBackdrop(
                nil,
                c,
                s,
                "marco",
                1
            )
            if i == 0 then
                local step = ease(nil, t / 0.85)
                rect(
                    nil,
                    c,
                    364,
                    366,
                    176,
                    13,
                    "#8c5d94"
                )
                word(
                    nil,
                    c,
                    "SARUÊ!",
                    452,
                    350,
                    25,
                    "#f3c8ee"
                )
                actor(
                    nil,
                    c,
                    "daroca",
                    210 + step * 186,
                    378,
                    t,
                    {
                        facing = 1,
                        scale = 1.8,
                        muscular = strong,
                        moving = __lt(t, 0.85),
                        speed = 160
                    }
                )
                actor(
                    nil,
                    c,
                    "marco",
                    690,
                    378,
                    t,
                    {facing = -1, scale = 1.8}
                )
                shockRing(
                    nil,
                    c,
                    452,
                    370,
                    t,
                    "#ed9ad4",
                    135
                )
            elseif i == 1 then
                redAura(
                    nil,
                    c,
                    615,
                    379,
                    t,
                    1.55
                )
                actor(
                    nil,
                    c,
                    "marco",
                    615,
                    378,
                    t,
                    {
                        facing = -1,
                        scale = 2.3,
                        rage = true,
                        angry = true,
                        charging = true,
                        attack = true,
                        attackType = "doodle",
                        attackProgress = 0.5
                    }
                )
                actor(
                    nil,
                    c,
                    "daroca",
                    200,
                    378,
                    t,
                    {facing = 1, scale = 1.65, muscular = strong, recoil = 0.5}
                )
                streaks(nil, c, t, "#ff8585")
            elseif i == 2 then
                redAura(
                    nil,
                    c,
                    615,
                    379,
                    t,
                    1.9
                )
                actor(
                    nil,
                    c,
                    "marco",
                    615,
                    378,
                    t,
                    {
                        facing = -1,
                        scale = 2.45,
                        rage = true,
                        angry = true,
                        charging = __lt(t, 1),
                        powered = __ge(t, 1),
                        attack = true,
                        attackType = "doodle",
                        attackProgress = __mod(t * 0.9, 1)
                    }
                )
                shockRing(
                    nil,
                    c,
                    615,
                    300,
                    t,
                    "#ff706f",
                    185
                )
                actor(
                    nil,
                    c,
                    "daroca",
                    183,
                    378,
                    t,
                    {facing = 1, scale = 1.6, muscular = strong, recoil = 0.5}
                )
            else
                redAura(
                    nil,
                    c,
                    650,
                    379,
                    t,
                    1.9
                )
                actor(
                    nil,
                    c,
                    "marco",
                    650,
                    378,
                    t,
                    {
                        facing = -1,
                        scale = 2.2,
                        rage = true,
                        angry = true,
                        powered = true,
                        attack = true,
                        attackType = "doodle",
                        attackProgress = __mod(t * 0.9, 1)
                    }
                )
                drawing(
                    nil,
                    c,
                    260 + math.sin(t * 2) * 18,
                    355 - math.abs(math.sin(t * 3)) * 20,
                    t,
                    "brainrot",
                    1.7
                )
                drawing(
                    nil,
                    c,
                    432,
                    363,
                    t,
                    "sixseven",
                    1.8
                )
                word(
                    nil,
                    c,
                    "SIX  SEVEN!",
                    406,
                    230 + math.sin(t * 4) * 4,
                    25,
                    "#ffc4ae"
                )
                streaks(nil, c, t, "#ff9b92")
            end
        elseif s.kind == "reeis_recruit" then
            battleBackdrop(
                nil,
                c,
                s,
                "reeisBoss",
                5
            )
            if i == 0 then
                actor(
                    nil,
                    c,
                    "daroca",
                    245,
                    378,
                    t,
                    {facing = 1, scale = 1.7, muscular = strong}
                )
                actor(
                    nil,
                    c,
                    "reeis",
                    675,
                    378,
                    t,
                    {facing = -1, scale = 1.9, recoil = 0.4}
                )
            elseif i == 1 then
                actor(
                    nil,
                    c,
                    "daroca",
                    315,
                    378,
                    t,
                    {
                        facing = 1,
                        scale = 1.9,
                        muscular = strong,
                        emotion = "sad",
                        pose = "offer"
                    }
                )
                actor(
                    nil,
                    c,
                    "reeis",
                    652,
                    378,
                    t,
                    {facing = -1, scale = 1.85}
                )
                cake(
                    nil,
                    c,
                    470,
                    289,
                    0.8
                )
                heart(
                    nil,
                    c,
                    473,
                    220,
                    1.2,
                    true,
                    t
                )
            elseif i == 2 then
                local e = ease(nil, t / 1.1)
                actor(
                    nil,
                    c,
                    "daroca",
                    325 + e * 40,
                    378,
                    t,
                    {
                        facing = 1,
                        scale = 1.85,
                        muscular = strong,
                        pose = "fistbump",
                        emotion = "friend"
                    }
                )
                actor(
                    nil,
                    c,
                    "reeis",
                    615 - e * 65,
                    378,
                    t,
                    {facing = -1, scale = 1.9, pose = "fistbump", emotion = "friend"}
                )
                heart(
                    nil,
                    c,
                    460,
                    220 + math.sin(t * 2) * 5,
                    1.4,
                    false,
                    t
                )
                if __gt(t, 1) then
                    sparkle(
                        nil,
                        c,
                        457,
                        303,
                        t,
                        2
                    )
                end
            elseif i == 3 then
                local run = __lt(t, 0.9)
                local charge = __ge(t, 0.9) and __lt(t, 1.8)
                local powered = __ge(t, 1.8)
                local x = if __t(run) then -90 + ease(nil, t / 0.9) * 605 else 515
                actor(
                    nil,
                    c,
                    "daroca",
                    245,
                    378,
                    t,
                    {facing = 1, scale = 1.7, muscular = strong}
                )
                actor(
                    nil,
                    c,
                    "reeis",
                    x,
                    378,
                    t,
                    {
                        facing = 1,
                        scale = if __t(powered) then 1.15 else 1.75,
                        moving = run,
                        speed = if __t(run) then 400 else 0,
                        charging = charge,
                        transformed = powered,
                        powered = powered,
                        aura = if __t(charge) then charge else powered
                    }
                )
                if __t(powered) then
                    shockRing(
                        nil,
                        c,
                        515,
                        303,
                        t - 1.8,
                        "#ffe59d",
                        210
                    )
                    streaks(nil, c, t, "#f7e4aa")
                end
                word(
                    nil,
                    c,
                    "OHHHH REEEEIS!",
                    650,
                    140 + math.sin(t * 5) * 3,
                    23,
                    "#ffe7a3"
                )
            else
                actor(
                    nil,
                    c,
                    "daroca",
                    330,
                    378,
                    t,
                    {facing = 1, scale = 1.8, muscular = strong, emotion = "friend"}
                )
                actor(
                    nil,
                    c,
                    "reeis",
                    615,
                    378,
                    t,
                    {facing = -1, scale = 1.8, emotion = "friend"}
                )
                confetti(nil, c, t, 26)
                heart(
                    nil,
                    c,
                    480,
                    224 + math.sin(t * 2) * 4,
                    1.3,
                    false,
                    t
                )
                do
                    local j = 0
                    while j < 5 do
                        sparkle(
                            nil,
                            c,
                            320 + j * 74,
                            190 + math.sin(t * 2 + j) * 12,
                            t + j,
                            1
                        )
                        j = j + 1
                    end
                end
            end
        end
    end
    local function isEpilogue(self, s)
        local ____opt_result_41
        if s ~= nil then
            ____opt_result_41 = s.kind
        end
        return ____opt_result_41 == "jorge_epilogue"
    end
    frameDuration = function(____, frame) return if __isFiniteN(frame.duration) then frame.duration else math.floor(clamp(
        nil,
        __len(if __t(frame.text) then frame.text else "") / 19 + 1.35,
        4.5,
        9
    ) * 100 + 0.5) / 100 end
    local function stateAt(self, kind, seconds, options)
        if seconds == nil then
            seconds = 0
        end
        if options == nil then
            options = {}
        end
        local timing = timeline(nil, kind)
        if not __t(timing) then
            return nil
        end
        local ____t_50 = __t
        local ____TS__Number_result_49 = __TS__Number(seconds)
        __O[704] = ____TS__Number_result_49
        local elapsed = clamp(nil, if ____t_50(____TS__Number_result_49) then __O[704] else 0, 0, timing.duration)
        local last = __len(timing.shots) - 1
        local index = __call(
            timing.shots,
            "findIndex",
            function(____, shot) return __lt(
                elapsed,
                __add(shot.start, shot.duration)
            ) end
        )
        if __lt(index, 0) then
            index = last
        end
        return {
            kind = kind,
            index = index,
            time = elapsed - __get(timing.shots, index).start,
            elapsed = elapsed,
            done = __ge(elapsed, timing.duration),
            options = __assign({}, options, {musicTimed = true})
        }
    end
    local function create(self, kind, options)
        if kind == nil then
            kind = "intro"
        end
        if options == nil then
            options = {}
        end
        if kind == "jorge_epilogue" then
            local ____t_53 = __t
            local ____opt_51 = window.JorgeEpilogue
            if ____opt_51 ~= nil then
                ____opt_51 = ____opt_51:create(options)
            end
            __O[705] = ____opt_51
            return if ____t_53(____opt_51) then __O[705] else {
                kind = kind,
                index = 0,
                time = 0,
                elapsed = 0,
                done = false,
                options = __assign({}, options)
            }
        end
        local ____t_56 = __t
        local ____t_55 = __t
        local ____temp_54 = kind == "outro"
        __O[706] = ____temp_54
        return {
            kind = if ____t_56(if ____t_55(____temp_54) then __O[706] else __fcall(__hasOwnV, EXTRA, kind)) then kind else "intro",
            index = 0,
            time = 0,
            elapsed = 0,
            done = false,
            options = __assign({}, options)
        }
    end
    local function list(self, s)
        local ____t_59 = __t
        local ____opt_57 = window.JorgeEpilogue
        if ____opt_57 ~= nil then
            ____opt_57 = ____opt_57.shots
        end
        __O[707] = ____opt_57
        local ____t_61 = __t
        local ____get_result_60 = __get(EXTRA, s.kind)
        __O[708] = ____get_result_60
        return if __t(isEpilogue(nil, s)) then if ____t_59(____opt_57) then __O[707] else __arrL({}, 0) else if ____t_61(____get_result_60) then __O[708] else if s.kind == "outro" then OUTRO else INTRO
    end
    local function beat(self, s)
        if not __t(s) then
            return nil
        end
        if __t(isEpilogue(nil, s)) then
            local ____t_64 = __t
            local ____opt_62 = window.JorgeEpilogue
            if ____opt_62 ~= nil then
                ____opt_62 = ____opt_62:beat(s)
            end
            __O[709] = ____opt_62
            return if ____t_64(____opt_62) then __O[709] else {
                index = 0,
                number = 1,
                total = 1,
                speaker = "",
                text = "JORGE",
                cinematic = true
            }
        end
        local beats = list(nil, s)
        local ____t_66 = __t
        local ____TS__Number_result_65 = __TS__Number(s.index)
        __O[710] = ____TS__Number_result_65
        local index = clamp(
            nil,
            math.floor(if ____t_66(____TS__Number_result_65) then __O[710] else 0),
            0,
            __len(beats) - 1
        )
        return __assign(
            {},
            __get(beats, index),
            {
                index = index,
                number = index + 1,
                total = __len(beats)
            }
        )
    end
    local function update(self, s, dt)
        local ____t_69 = __t
        local ____t_68 = __t
        local ____temp_67 = not __t(s)
        __O[711] = ____temp_67
        if ____t_69(if ____t_68(____temp_67) then __O[711] else s.done) then
            return
        end
        if __t(isEpilogue(nil, s)) then
            if __t(window.JorgeEpilogue) then
                window.JorgeEpilogue:update(s, dt)
            else
                s.done = true
            end
            return
        end
        local ____t_71 = __t
        local ____TS__Number_result_70 = __TS__Number(dt)
        __O[712] = ____TS__Number_result_70
        dt = clamp(nil, if ____t_71(____TS__Number_result_70) then __O[712] else 0, 0, 0.1)
        s.time = __add(s.time, dt)
        s.elapsed = __add(if __t(s.elapsed) then s.elapsed else 0, dt)
        local ____t_74 = __t
        local ____opt_72 = s.options
        if ____opt_72 ~= nil then
            ____opt_72 = ____opt_72.musicTimed
        end
        if ____t_74(____opt_72) then
            local timing = timeline(nil, s.kind)
            while __t(not __t(s.done) and __ge(
                s.time,
                __get(timing.shots, s.index).duration
            )) do
                local duration = __get(timing.shots, s.index).duration
                if __ge(
                    s.index + 1,
                    __len(timing.shots)
                ) then
                    s.done = true
                    s.time = duration
                    s.elapsed = timing.duration
                    break
                end
                s.time = s.time - duration
                s.index = s.index + 1
            end
            if not __t(s.done) then
                s.elapsed = timelinePosition(nil, s)
            end
        end
    end
    local function advance(self, s)
        local ____t_77 = __t
        local ____t_76 = __t
        local ____temp_75 = not __t(s)
        __O[713] = ____temp_75
        if ____t_77(if ____t_76(____temp_75) then __O[713] else s.done) then
            return false
        end
        if __t(isEpilogue(nil, s)) then
            if __t(window.JorgeEpilogue) then
                return window.JorgeEpilogue:advance(s)
            end
            s.done = true
            return false
        end
        if __ge(
            s.index + 1,
            __len(list(nil, s))
        ) then
            s.done = true
            return false
        end
        s.index = s.index + 1
        s.time = 0
        local ____t_80 = __t
        local ____opt_78 = s.options
        if ____opt_78 ~= nil then
            ____opt_78 = ____opt_78.musicTimed
        end
        if ____t_80(____opt_78) then
            s.elapsed = timelinePosition(nil, s)
        end
        return true
    end
    local function revengeAnchorX(self, s)
        return if __t(s.kind == "arthur_revenge" and s.index == 1) then 575 else if s.kind == "arthur_revenge" then 655 else 710
    end
    local function anchor(self, s)
        if not __t(s) then
            return {
                x = 285,
                y = 65,
                width = 410,
                tail = "left",
                speakerX = 300,
                speakerY = 290
            }
        end
        if __t(isEpilogue(nil, s)) then
            return {
                x = 480,
                y = 460,
                width = 700,
                speakerX = 480,
                speakerY = 270,
                cinematic = true
            }
        end
        local b = beat(nil, s)
        local i = s.index
        local ____t_82 = __t
        local ____TS__Number_result_81 = __TS__Number(s.time)
        __O[714] = ____TS__Number_result_81
        local t = if ____t_82(____TS__Number_result_81) then __O[714] else 0
        local ____t_86 = __t
        local ____opt_result_85
        if b ~= nil then
            ____opt_result_85 = b.speaker
        end
        __O[715] = ____opt_result_85
        local who = if ____t_86(____opt_result_85) then __O[715] else ""
        local actorX = if __t(__call(who, "includes", "Da Roça")) then 265 else if __t(__call(who, "includes", "Nikolas")) then 645 else if __t(__call(who, "includes", "Lucas")) then 190 else if __t(__call(who, "includes", "Reeis")) then 650 else if __t(__call(who, "includes", "Menezes")) then 690 else if __t(__call(who, "includes", "Marco")) then 635 else 452
        local actorY = if __t(__call(who, "includes", "Lucas")) then 322 else if __t(__call(who, "includes", "Monstro")) then 165 else if __t(__call(who, "includes", "Armadilha")) then 380 else 278
        if __t(__call(who, "includes", "Freddy")) then
            actorX = 670
        end
        if __t(__call(who, "includes", "Nicolas")) then
            actorX = 650
        end
        if who == "Narrador" then
            actorX = 265
            actorY = 278
        end
        if __t(__call(who, "includes", "Dedé")) then
            actorX = 665
        end
        if who == "Arthur" then
            actorX = revengeAnchorX(nil, s)
        end
        if who == "Aica" then
            actorX = 302
        end
        if who == "Ravile" then
            actorX = if s.kind == "boss_arthur" then 380 else 480
            actorY = if s.kind == "boss_arthur" then 354 else 278
        end
        if s.kind == "celebration" then
            local partySpeakers = __arrL({
                245,
                645,
                150,
                150,
                645,
                315,
                730
            }, 7)
            local ____t_88 = __t
            local ____get_result_87 = __get(partySpeakers, i)
            __O[716] = ____get_result_87
            actorX = if ____t_88(____get_result_87) then __O[716] else 315
            actorY = 290
        end
        if s.kind == "intro" then
            local ____t_91 = __t
            local ____t_90 = __t
            local ____temp_89 = i == 0
            __O[717] = ____temp_89
            if ____t_91(if ____t_90(____temp_89) then __call(who, "includes", "Da Roça") else __O[717]) then
                actorX = 330 + ease(nil, t / 1.1) * 60
            end
            local ____t_94 = __t
            local ____t_93 = __t
            local ____temp_92 = i == 1
            __O[718] = ____temp_92
            if ____t_94(if ____t_93(____temp_92) then __call(who, "includes", "Nikolas") else __O[718]) then
                actorX = 610 + math.sin(t * 2) * 5
            end
            local ____t_97 = __t
            local ____t_96 = __t
            local ____temp_95 = i == 2
            __O[719] = ____temp_95
            if ____t_97(if ____t_96(____temp_95) then __call(who, "includes", "Lucas") else __O[719]) then
                actorX = 160
            end
            local ____t_100 = __t
            local ____t_99 = __t
            local ____temp_98 = i == 3
            __O[720] = ____temp_98
            if ____t_100(if ____t_99(____temp_98) then __call(who, "includes", "Nikolas") else __O[720]) then
                actorX = 647 - ease(nil, t / 3) * 35
                actorY = 268
            end
            local ____t_103 = __t
            local ____t_102 = __t
            local ____temp_101 = i == 5
            __O[721] = ____temp_101
            if ____t_103(if ____t_102(____temp_101) then __call(who, "includes", "Nikolas") else __O[721]) then
                actorX = 575 + ease(nil, t / 2.4) * 240
            end
            local ____t_106 = __t
            local ____t_105 = __t
            local ____temp_104 = i == 6
            __O[722] = ____temp_104
            if ____t_106(if ____t_105(____temp_104) then __call(who, "includes", "Da Roça") else __O[722]) then
                actorX = 360
            end
        elseif s.kind == "outro" then
            local ____t_109 = __t
            local ____t_108 = __t
            local ____temp_107 = i == 5
            __O[723] = ____temp_107
            if ____t_109(if ____t_108(____temp_107) then __call(who, "includes", "Reeis") else __O[723]) then
                actorX = 805
            end
            local ____t_112 = __t
            local ____t_111 = __t
            local ____temp_110 = i == 3
            __O[724] = ____temp_110
            if ____t_112(if ____t_111(____temp_110) then __call(who, "includes", "Lucas") else __O[724]) then
                actorX = 220
            end
        end
        local large = s.kind == "boss_giant"
        local left = if __t(large) then large else actorX < 480
        return {
            x = if __t(large) then 245 else if __t(left) then 285 else 680,
            y = if __t(large) then 61 else 65,
            width = if __t(large) then 390 else 410,
            tail = if __t(if __t(left) then not __t(large) else left) then "left" else "right",
            speakerX = clamp(
                nil,
                actorX + math.floor(math.sin(t * 0.4) * 4 + 0.5),
                40,
                920
            ),
            speakerY = actorY + 30,
            safeBottom = if __t(large) then 194 else 235
        }
    end
    local function draw(self, c, s)
        if __t(not __t(c) or not __t(s)) then
            return
        end
        if __t(isEpilogue(nil, s)) then
            if __t(window.JorgeEpilogue) then
                window.JorgeEpilogue:draw(c, s)
            else
                c.fillStyle = "#000"
                c:fillRect(0, 0, 960, 540)
            end
            return
        end
        c:save()
        c.imageSmoothingEnabled = false
        c:clearRect(0, 0, 960, 540)
        rect(
            nil,
            c,
            0,
            0,
            960,
            540,
            if s.kind == "boss_giant" then "#25263b" else if __t(s.kind == "boss_nicolas" and __ge(s.index, 2)) then "#223647" else "#8ec7e1"
        )
        c:save()
        c:translate(
            math.floor(math.sin(s.time * 0.4) * 4 + 0.5),
            30
        )
        pisoAplicado = false
        if s.kind == "outro" then
            outro(nil, c, s)
        elseif __t(__get(EXTRA, s.kind)) then
            bossFilm(nil, c, s)
        else
            intro(nil, c, s)
        end
        c:restore()
        rect(
            nil,
            c,
            0,
            0,
            960,
            24,
            "#10241ff0"
        )
        rect(
            nil,
            c,
            0,
            520,
            960,
            20,
            "#10241fe0"
        )
        local fade = 1 - clamp(nil, s.time / 0.28, 0, 1)
        if fade > 0 then
            c.fillStyle = ("rgba(13,29,24," .. tostring(fade * 0.65)) .. ")"
            c:fillRect(0, 24, 960, 496)
        end
        c:restore()
    end
    local ____window_133 = window
    local ____ord_132 = __ord
    local ____create_122 = create
    local ____update_123 = update
    local ____advance_124 = advance
    local ____beat_125 = beat
    local ____draw_126 = draw
    local ____anchor_127 = anchor
    local ____timeline_128 = timeline
    local ____timelinePosition_129 = timelinePosition
    local ____stateAt_130 = stateAt
    local ____arr_result_131 = __arr(__TS__Spread(__iter(PARTY_CAST)))
    local ____ord_121 = __ord
    local ____assign_120 = __assign
    local ____temp_119 = {}
    local ____call_result_117 = __call(
        INTRO,
        "map",
        function(____, x) return __assign({}, x) end
    )
    local ____call_result_118 = __call(
        OUTRO,
        "map",
        function(____, x) return __assign({}, x) end
    )
    local ____call_116 = __call
    local ____t_115 = __t
    local ____opt_113 = window.JorgeEpilogue
    if ____opt_113 ~= nil then
        ____opt_113 = ____opt_113.shots
    end
    __O[725] = ____opt_113
    ____window_133.Cinematics = ____ord_132(
        {
            create = ____create_122,
            update = ____update_123,
            advance = ____advance_124,
            beat = ____beat_125,
            draw = ____draw_126,
            anchor = ____anchor_127,
            timeline = ____timeline_128,
            timelinePosition = ____timelinePosition_129,
            stateAt = ____stateAt_130,
            celebrationCast = ____arr_result_131,
            metadata = ____ord_121(
                ____assign_120(
                    ____temp_119,
                    {
                        intro = ____call_result_117,
                        outro = ____call_result_118,
                        jorge_epilogue = ____call_116(
                            if ____t_115(____opt_113) then __O[725] else __arrL({}, 0),
                            "map",
                            function(____, x) return __assign({}, x) end
                        )
                    },
                    __TS__ObjectFromEntries(__call(
                        __entries(EXTRA),
                        "map",
                        function(____, ____bindingPattern0)
                            local beats
                            local kind
                            kind = ____bindingPattern0[1]
                            beats = ____bindingPattern0[2]
                            return __arrL(
                                {
                                    kind,
                                    __call(
                                        beats,
                                        "map",
                                        function(____, x) return __assign({}, x) end
                                    )
                                },
                                2
                            )
                        end
                    ))
                ),
                "intro,outro,jorge_epilogue"
            )
        },
        "create,update,advance,beat,draw,anchor,timeline,timelinePosition,stateAt,celebrationCast,metadata"
    )
end)(nil)
return ____exports
