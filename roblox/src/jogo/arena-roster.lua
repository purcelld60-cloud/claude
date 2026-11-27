--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __ord, __arrL, __t, __get, __call = __JSR.__ord, __JSR.__arrL, __JSR.__t, __JSR.__get, __JSR.__call
local ____lualib = require(script.Parent.lualib_bundle)
local Map = ____lualib.Map
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local rows = __arrL(
        {
            __arrL({
                "daroca",
                "Da Roça",
                "Gás no talo",
                "#e8a35d",
                "Cotovelada do chapéu",
                "Papel propulsor",
                "Trinca do feijão",
                "Meu combustível é caseiro, pô!",
                "elbow",
                "paper",
                "gascombo",
                "chapeu",
                "passinho"
            }, 13),
            __arrL({
                "reeis",
                "Gabriel REEEIS",
                "O rei chegou",
                "#67d5ce",
                "Coronhada do rei",
                "Rajada da favela",
                "Bonde do REEEIS",
                "OHHHH REEEEIS! Chamou, chegou!",
                "gunbutt",
                "bullet",
                "army",
                "rei",
                "ombro"
            }, 13),
            __arrL({
                "nikolas",
                "Nikolas Arroganti",
                "Fome de bolo",
                "#c6a4ee",
                "Soco da arrogância",
                "Catarro de batata",
                "Fome de gigante",
                "O bolo tava dando sopa, Da Roça!",
                "nosepunch",
                "goo",
                "muscle",
                "nariz",
                "arrogante"
            }, 13),
            __arrL({
                "marco",
                "Marco",
                "Rabisco do caos",
                "#fa7978",
                "Régua do desenhista",
                "Brainrot de bolso",
                "SARUÊ EM FÚRIA",
                "Chamou de saruê? Agora segura o desenho!",
                "ruler",
                "brainrot",
                "sketch",
                "desenho",
                "rabisco"
            }, 13),
            __arrL({
                "menezes",
                "Menezes",
                "Provocação física",
                "#9fd4ae",
                "Arranhão do rato",
                "Palavra que pega ar",
                "Atalho do esgoto",
                "Da Roça pegou ar! Teketeketeke!",
                "claw",
                "words",
                "sewer",
                "rato",
                "teketeke"
            }, 13),
            __arrL({
                "ollyan",
                "Ollyan",
                "Turbina de orelha",
                "#b4a5ff",
                "Orelhada cruzada",
                "Rajada de vento",
                "Ventilador nervoso",
                "Sai da frente que a orelha decolou!",
                "ear",
                "wind",
                "earspin",
                "orelha",
                "ventilador"
            }, 13),
            __arrL({
                "igor",
                "Igor",
                "O fiscal do lanche",
                "#73b8f6",
                "Soco sem merenda",
                "Ondão da barriga",
                "Rebate na barriga",
                "Cadê o lanche, pivete? Fortalece o pai!",
                "punch",
                "bellywave",
                "bellybounce",
                "lanche",
                "barriga"
            }, 13),
            __arrL({
                "kaique",
                "Kaique",
                "Fiscal da sala",
                "#b8d3df",
                "Coronhada fiscal",
                "Rajada confiscada",
                "IRACI, VOLTA PRA SALA!",
                "Ô pivete, entrega essas bolinhas aí, moral!",
                "stock",
                "bullet",
                "inspection",
                "sala",
                "fiscal"
            }, 13),
            __arrL({
                "freddy",
                "Freddy",
                "O capanga ligeiro",
                "#efb56e",
                "Cotovelada OPEESTY",
                "Pedrada do capanga",
                "Passinho da pancada",
                "OPEESTY DA ROÇA! Bora ver se é ligeiro!",
                "capoeira",
                "stone",
                "freddyspin",
                "opeesty",
                "capanga"
            }, 13),
            __arrL({
                "dede",
                "Dédé",
                "Nuvem de resenha",
                "#b7b1c6",
                "Tapa esfumaçado",
                "Anel de fumaça",
                "SEU GILÓ HOMI!",
                "SEU GILÓ HOMI! Perdeu na fumaça, foi?",
                "smokepalm",
                "smoke",
                "smokelift",
                "aparelho",
                "fumaca"
            }, 13),
            __arrL({
                "arthur",
                "Arthur",
                "Mestre do tapa",
                "#efb1c5",
                "Tapa atravessado",
                "Tapão de vento",
                "Sequência bestaiada",
                "Eu só encostei, veyr!",
                "slap",
                "palm",
                "slapcombo",
                "pose",
                "passinho"
            }, 13),
            __arrL({
                "nicolas",
                "Nicolas Carvalho",
                "Protagonista supremo",
                "#f4d981",
                "Punho do protagonista",
                "Faísca da aura",
                "Cena principal",
                "Essa luta já tava no meu roteiro!",
                "divinepunch",
                "light",
                "divine",
                "aura",
                "protagonista"
            }, 13),
            __arrL({
                "giant",
                "Monstro 67",
                "Do caderno à arena",
                "#b0ed76",
                "Soco SIX",
                "SEVEN voador",
                "SIX… SEVEN!",
                "SIX... SEVEN!",
                "stonefist",
                "six",
                "sixtyseven",
                "sixseven",
                "sixseven"
            }, 13),
            __arrL({
                "caleb",
                "Caleb",
                "Shape de respeito",
                "#ffd083",
                "Supino de mão",
                "Anilha voadora",
                "Leg day sísmico",
                "Esse cardio tá com cheiro de peido, meu filho!",
                "dumbbell",
                "weight",
                "stomp",
                "shape",
                "supino"
            }, 13),
            __arrL({
                "lucas",
                "Lucas Sapo",
                "Baixinho, língua longa",
                "#b4c6d5",
                "Golpe baixo do Sapo",
                "Língua de sapo",
                "Bolo no ponto baixo",
                "Foi golpe baixo? Eu já sou baixo, pô!",
                "lowblow",
                "tongue",
                "frogcombo",
                "sapo",
                "pulinho"
            }, 13),
            __arrL({
                "kaua",
                "Kaua",
                "Oficina escolar",
                "#82cdb7",
                "Réguada da oficina",
                "Caneta propulsora",
                "Estojo sem limite",
                "Ummhumhumm... Oprai Da Roça!",
                "rulertool",
                "pen",
                "schoolarsenal",
                "inventor",
                "oficina"
            }, 13),
            __arrL({
                "mota",
                "Mota",
                "Craque da quadra",
                "#a8d1ff",
                "Chute de primeira",
                "Bola que volta",
                "Domínio e golaço",
                "Foi mal, a bola voltou pro pé porque tem contrato!",
                "footballkick",
                "ball",
                "juggle",
                "embaixadinha",
                "futebol"
            }, 13),
            __arrL({
                "ravid",
                "Ravid",
                "Conversa com a parede",
                "#b3d5df",
                "Gestão de monólogo",
                "Assunto atravessado",
                "Debate com a parede",
                "Eu tava falando aqui comigo mesmo…",
                "point",
                "monologue",
                "wallrant",
                "parede",
                "conversa"
            }, 13),
            __arrL({
                "almiro",
                "Professor Almiro",
                "Careca reluzente",
                "#8fcdff",
                "Chamada na palma",
                "Giz reluzente",
                "Reflexo da careca",
                "Ahahaha, Da Roça sacana é com cerveja!",
                "teacherpalm",
                "chalk",
                "baldflash",
                "careca",
                "recreio"
            }, 13),
            __arrL({
                "miqueias",
                "Professor Miqueias",
                "English do jeito dele",
                "#efad76",
                "Réguada ALLRIGHT",
                "Concorda ou sem corda",
                "BEAUTIFUL, beleza Creuza",
                "You is pronto for the surra? É ou não é?",
                "teacheruler",
                "english",
                "englishcombo",
                "allright",
                "english"
            }, 13),
            __arrL({
                "davi",
                "Davi Costa",
                "Corte da resenha",
                "#a5c9df",
                "Máquina na régua",
                "Pente bumerangue",
                "Degradê giratório",
                "Senta que esse corte agora é na tua marra!",
                "clipper",
                "comb",
                "barberchair",
                "degrade",
                "tesourinha"
            }, 13),
            __arrL({
                "vitor",
                "Vitor",
                "Ajudante ligeiro",
                "#b9c5d7",
                "Toalhada certeira",
                "Escova que retorna",
                "Acabamento expresso",
                "Já marquei teu horário pra tomar essa resenha!",
                "towel",
                "brush",
                "towelspin",
                "oculos",
                "escova"
            }, 13),
            __arrL({
                "allef",
                "Allef",
                "Recepção sem filtro",
                "#ffca88",
                "Tapão da senha",
                "Ficha da provocação",
                "A FILA ANDOU",
                "Teu chapéu pegou senha e perdeu a vez!",
                "receiptslap",
                "ticket",
                "queue",
                "recepcao",
                "fila"
            }, 13),
            __arrL({
                "aica",
                "Aica",
                "Não se passa",
                "#ffc5cd",
                "Chute se toca",
                "Salto que volta",
                "Joelhada OPEEESTI",
                "Se toca, bestaiado! Aff veyr juro!",
                "heelkick",
                "heel",
                "girlknee",
                "deboche",
                "deboche"
            }, 13),
            __arrL({
                "ravile",
                "Ravile",
                "Resenha com troco",
                "#e7b4ea",
                "Pernada você se passou",
                "Salto do troco",
                "Joelhada da revanche",
                "Idiota, você se passou! Aff veyr juro!",
                "roundkick",
                "heel",
                "girlknee",
                "deboche",
                "deboche"
            }, 13),
            __arrL({
                "eloisa",
                "Eloisa",
                "Comentário certeiro",
                "#ffa5cf",
                "Salto no argumento",
                "Salto rosa bumerangue",
                "Joelhada se toca",
                "Aff veyr juro, menino, se toca!",
                "highkick",
                "heel",
                "girlknee",
                "deboche",
                "deboche"
            }, 13),
            __arrL({
                "giselle",
                "Giselle",
                "Trança e presença",
                "#c8a2fc",
                "Giro de perna",
                "Salto crochet",
                "Joelhada sem filtro",
                "Aff veyr juro, você se passou bonito!",
                "spinkick",
                "heel",
                "girlknee",
                "deboche",
                "deboche"
            }, 13),
            __arrL({
                "rayssa",
                "Rayssa",
                "Dona da resenha",
                "#8ee5c3",
                "Pernada da dona da casa",
                "Salto da varanda",
                "Joelhada da casa",
                "Na minha casa a vergonha tem limite. Aff veyr juro!",
                "sidekick",
                "heel",
                "girlknee",
                "deboche",
                "deboche"
            }, 13),
            __arrL({
                "analaura",
                "Ana Laura",
                "Riso com resposta",
                "#e8bddf",
                "Salto no deboche",
                "Salto sem paciência",
                "Joelhada aff veyr",
                "Aff veyr juro… foi isso tudo pra errar?",
                "backkick",
                "heel",
                "girlknee",
                "deboche",
                "deboche"
            }, 13)
        },
        29
    )
    local kits = __call(
        rows,
        "map",
        function(____, ____bindingPattern0)
            local dance
            local emote
            local comboStyle
            local shot
            local style
            local quote
            local combo
            local ranged
            local physical
            local color
            local title
            local name
            local id
            id = ____bindingPattern0[1]
            name = ____bindingPattern0[2]
            title = ____bindingPattern0[3]
            color = ____bindingPattern0[4]
            physical = ____bindingPattern0[5]
            ranged = ____bindingPattern0[6]
            combo = ____bindingPattern0[7]
            quote = ____bindingPattern0[8]
            style = ____bindingPattern0[9]
            shot = ____bindingPattern0[10]
            comboStyle = ____bindingPattern0[11]
            emote = ____bindingPattern0[12]
            dance = ____bindingPattern0[13]
            return {
                id = id,
                name = name,
                title = title,
                color = color,
                physical = physical,
                ranged = ranged,
                combo = combo,
                basic = physical,
                special = ranged,
                ultimate = combo,
                quote = quote,
                style = style,
                shot = shot,
                comboStyle = comboStyle,
                skill = style,
                superSkill = comboStyle,
                speed = if id == "lucas" then 1.08 else 1,
                health = 1,
                weight = 1,
                renderHeight = if id == "lucas" then 60 else 70,
                hitbox = {w = 34, h = if id == "lucas" then 60 else 70},
                emote = {id = emote, text = if id == "mota" then "FARMANDO AURA" else quote, duration = 1.8},
                dance = {id = dance, text = if id == "menezes" then "TEKETEKETEKE" else if id == "mota" then "OLHA O DOMÍNIO" else if id == "caleb" then "CARDIO DO SHAPE" else "PASSINHO DA RESENHA", duration = 3}
            }
        end
    )
    local byId = __TS__New(
        Map,
        __call(
            kits,
            "map",
            function(____, k) return __arrL({k.id, k}, 2) end
        )
    )
    window.ArenaRoster = __ord(
        {
            version = 2,
            all = kits,
            get = function(____, id)
                local ____t_1 = __t
                local ____call_result_0 = __call(byId, "get", id)
                __O[2485] = ____call_result_0
                return if ____t_1(____call_result_0) then __O[2485] else __get(kits, 0)
            end
        },
        "version,all,get"
    )
end)(nil)
return ____exports
