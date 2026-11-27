--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __ge, __mod, __ord, __arrL, __iterar, __t, __get, __arr, __len, __call, __new = __JSR.__lt, __JSR.__ge, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__arr, __JSR.__len, __JSR.__call, __JSR.__new
local __iter, __assign, __re, __re_test = __JSR.__iter, __JSR.__assign, __JSR.__re, __JSR.__re_test
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Iterator = ____lualib.__TS__Iterator
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local __TS__Spread = ____lualib.__TS__Spread
local __TS__Number = ____lualib.__TS__Number
local ____exports = {}
local __O = {};
(function()
    local digitar, menu, tema, avancar, fechar, box, cur, fila, texto, shown, typing, onClose, modo, lidos
    function digitar(self, str)
        texto = str
        shown = 0
        window:clearInterval(typing)
        local el = box:querySelector(".c2m-txt")
        el.textContent = ""
        typing = window:setInterval(
            function()
                shown = math.min(
                    __len(texto),
                    shown + 2
                )
                el.textContent = __call(texto, "slice", 0, shown)
                if shown >= __len(texto) then
                    window:clearInterval(typing)
                    typing = nil
                    if not __t(__len(fila)) then
                        menu(nil)
                    end
                end
            end,
            18
        )
    end
    function menu(self)
        modo = "menu"
        local ops = box:querySelector(".c2m-ops")
        ops.innerHTML = ""
        __call(
            cur.temas,
            "forEach",
            function(____, ____bindingPattern0, i)
                local q
                q = ____bindingPattern0[1]
                local b = window.document:createElement("button")
                b.type = "button"
                b.textContent = ((tostring(i + 1) .. ". ") .. tostring(q)) .. if __t(__call(lidos, "has", i)) then " ✓" else ""
                if __t(__call(lidos, "has", i)) then
                    b.className = "lido"
                end
                b:addEventListener(
                    "click",
                    function() return tema(nil, i) end
                )
                ops:appendChild(b)
            end
        )
        local b = window.document:createElement("button")
        b.type = "button"
        b.textContent = tostring(__len(cur.temas) + 1) .. ". Tchau!"
        b:addEventListener("click", fechar)
        ops:appendChild(b)
        box:querySelector(".c2m-pass").textContent = "1 a 4 ou toque: escolher · E: próximo assunto · ESC: sair"
    end
    function tema(self, i)
        __call(lidos, "add", i)
        modo = "fala"
        fila = __call(
            __get(
                __get(cur.temas, i),
                1
            ),
            "slice"
        )
        box:querySelector(".c2m-ops").innerHTML = ""
        box:querySelector(".c2m-pass").textContent = "E / ENTER / toque: continuar · ESC: sair"
        digitar(
            nil,
            __call(fila, "shift")
        )
    end
    function avancar(self)
        if not __t(cur) then
            return
        end
        local el = box:querySelector(".c2m-txt")
        if __t(typing) then
            window:clearInterval(typing)
            typing = nil
            el.textContent = texto
            if not __t(__len(fila)) then
                menu(nil)
            end
            return
        end
        if __t(__len(fila)) then
            digitar(
                nil,
                __call(fila, "shift")
            )
            return
        end
        if modo ~= "menu" then
            menu(nil)
        end
    end
    function fechar(self)
        local ____t_24 = __t
        local ____t_23 = __t
        local ____temp_22 = not __t(box)
        __O[451] = ____temp_22
        if ____t_24(if ____t_23(____temp_22) then __O[451] else box.hidden) then
            return
        end
        window:clearInterval(typing)
        typing = nil
        box.hidden = true
        cur = nil
        window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {owner = "moradores", active = false}}))
        local f = onClose
        onClose = nil
        if f ~= nil then
            f(nil)
        end
    end
    local ____ = "use strict"
    local ____t_8 = __t
    local ____t_4 = __t
    local ____t_2 = __t
    local ____opt_0 = window.CampanhaPersonagens
    if ____opt_0 ~= nil then
        ____opt_0 = ____opt_0.registrar
    end
    local ____temp_3 = if __t(window.CampanhaMoradores) then window.CampanhaMoradores else not ____t_2(____opt_0)
    __O[446] = ____temp_3
    local ____t_7 = __t
    local ____opt_5 = window.Art
    if ____opt_5 ~= nil then
        ____opt_5 = ____opt_5.drawCharacter
    end
    if ____t_8(if ____t_4(____temp_3) then __O[446] else not ____t_7(____opt_5)) then
        return
    end
    local CP = window.CampanhaPersonagens
    local KEY = "daroca-c2-conhecidos"
    local FLOOR = 440
    local S = __ord(
        {
            claro = __arrL({"#efc6a9", "#c2977c"}, 2),
            trigo = __arrL({"#e3b48f", "#b58665"}, 2),
            moreno = __arrL({"#d9a57f", "#ac7856"}, 2),
            canela = __arrL({"#c48a60", "#956445"}, 2),
            jambo = __arrL({"#b67a52", "#875438"}, 2),
            cobre = __arrL({"#a96f48", "#7c4f33"}, 2),
            escuro = __arrL({"#8a5a3c", "#5f3d2a"}, 2),
            preto = __arrL({"#7c4f35", "#55362a"}, 2)
        },
        "claro,trigo,moreno,canela,jambo,cobre,escuro,preto"
    )
    local function pele(____, k)
        return {
            skin = __get(
                __get(S, k),
                0
            ),
            shade = __get(
                __get(S, k),
                1
            )
        }
    end
    local PERSONAGENS = __arrL(
        {
            __ord(
                {
                    id = "c2n_lucia",
                    nome = "Professora Lúcia",
                    papel = "professora de História da UESB",
                    cena = 31,
                    x = 2560,
                    spec = __ord(
                        __assign(
                            {},
                            pele(nil, "moreno"),
                            {
                                build = "normal",
                                h = 0.93,
                                top = "#5a6a8a",
                                topKind = "cardigan",
                                inner = "#f2ecda",
                                skirt = "#3a3f4a",
                                hair = __ord({style = "bun", color = "#d8d4cc", gray = "#a8a49c"}, "style,color,gray"),
                                glasses = "#3a2a1a",
                                scarf = "#c4743a",
                                item = "book",
                                pose = "read"
                            }
                        ),
                        "build,h,top,topKind,inner,skirt,hair,glasses,scarf,item,pose"
                    ),
                    oi = "Ah, um rosto novo no campus! Senta aí, meu filho. Professora de História não perde uma chance de contar história.",
                    temas = __arrL(
                        {
                            __arrL(
                                {
                                    "Quem é você?",
                                    __arrL({"Lúcia, professora de História aqui na UESB há mais de vinte anos. Já dei aula pra metade da cidade, incluindo uns três prefeitos e o rapaz da xerox.", "Meu orgulho é o acervo de fotos antigas da cidade que eu junto. Toda semana aparece alguém com uma caixa de sapato cheia de retrato do avô."}, 2)
                                },
                                2
                            ),
                            __arrL(
                                {
                                    "Me fala da cidade",
                                    __arrL({"Antes de tudo, esta terra era dos povos indígenas: os Mongoió, os Imboré, os Pataxó. O nome \"Conquista\" vem justamente da luta pela terra no século dezoito. É por isso que tem o Monumento ao Índio lá na avenida: pra ninguém esquecer.", "Depois a cidade já se chamou Imperial Vila da Vitória, passou a ser só Conquista e o nome de hoje juntou os dois. Cresceu com a Rio-Bahia passando no meio, com o café do planalto e virou a terceira maior cidade da Bahia.", "E não esquece: Glauber Rocha nasceu aqui. \"Uma câmera na mão e uma ideia na cabeça.\" Elomar também é daqui, cantando o sertão. Cidade fria, mas de gente quente."}, 3)
                                },
                                2
                            ),
                            __arrL(
                                {
                                    "E a sua história?",
                                    __arrL({"Eu vim da roça, igual a você. Estudei à luz de candeeiro e o primeiro livro que eu li inteiro foi um almanaque de farmácia.", "Quando a universidade abriu as portas, fui da primeira turma da minha família a pisar numa sala de aula de faculdade. Hoje eu digo pros meus alunos: o planalto é alto, mas dá pra subir."}, 2)
                                },
                                2
                            )
                        },
                        3
                    )
                },
                "id,nome,papel,cena,x,spec,oi,temas"
            ),
            __ord(
                {
                    id = "c2n_bene",
                    nome = "Seu Bené Engraxate",
                    papel = "engraxate da rodoviária há 40 anos",
                    cena = 30,
                    x = 560,
                    spec = __ord(
                        __assign(
                            {},
                            pele(nil, "preto"),
                            {
                                build = "slim",
                                h = 0.92,
                                hunch = true,
                                top = "#e8e2d0",
                                topKind = "polo",
                                sleeve = "short",
                                pattern = "#c8c2b0",
                                pants = "#4a4a42",
                                hat = __ord({kind = "cap", color = "#3a3a36"}, "kind,color"),
                                hair = __ord({style = "short", color = "#d0ccc4"}, "style,color"),
                                mustache = "#e0dcd4",
                                pose = "offer"
                            }
                        ),
                        "build,h,hunch,top,topKind,sleeve,pattern,pants,hat,hair,mustache,pose"
                    ),
                    oi = "Graxa, meu jovem? Bota o pé aqui. Ô, mas é botina de roça! Essa aí já viu muita estrada, hein?",
                    temas = __arrL(
                        {
                            __arrL(
                                {
                                    "Quem é você?",
                                    __arrL({"Benedito, mas ninguém me chama assim nem em velório. Bené. Engraxo sapato nessa rodoviária há quarenta anos. Já engraxei sapato de deputado, de noivo atrasado e de cantor de arrocha."}, 1)
                                },
                                2
                            ),
                            __arrL(
                                {
                                    "Me fala da cidade",
                                    __arrL({"Daqui eu vejo a cidade inteira chegar e partir. A Rio-Bahia passa aqui do lado: quem vai do Sul pro Nordeste passa por Conquista, querendo ou não.", "Ônibus pra Salvador, pra Itabuna, pra Jequié, pra São Paulo... Todo mundo que chega desce com cara de frio. Aí eu já sei: é gente nova na Suíça Baiana."}, 2)
                                },
                                2
                            ),
                            __arrL(
                                {
                                    "E a sua história?",
                                    __arrL({"Cheguei num ônibus de madrugada, com dezesseis anos, uma mala de papelão e uma lata de graxa que era do meu pai. Ia ficar uma semana. Tô aqui até hoje.", "Criei três filhos com essa escova. Uma é enfermeira, o outro é motorista de ônibus e passa por mim buzinando. O caçula é engraxate também, mas de tênis. Chama de \"customização\"."}, 2)
                                },
                                2
                            )
                        },
                        3
                    )
                },
                "id,nome,papel,cena,x,spec,oi,temas"
            ),
            __ord(
                {
                    id = "c2n_taina",
                    nome = "Tainá",
                    papel = "guia voluntária do Monumento ao Índio",
                    cena = 16,
                    x = 3260,
                    spec = __ord(
                        __assign(
                            {},
                            pele(nil, "cobre"),
                            {
                                build = "slim",
                                h = 0.94,
                                top = "#c4743a",
                                topKind = "tee",
                                sleeve = "short",
                                pants = "#2c3a4f",
                                hair = __ord({style = "long", color = "#14100c"}, "style,color"),
                                earrings = "#e8c24c",
                                item = "map",
                                pose = "offer"
                            }
                        ),
                        "build,h,top,topKind,sleeve,pants,hair,earrings,item,pose"
                    ),
                    oi = "Oi! Quer saber do monumento? Eu sou guia aqui nos fins de semana. A visita é de graça, mas ouvir até o fim é obrigatório.",
                    temas = __arrL(
                        {
                            __arrL(
                                {
                                    "Quem é você?",
                                    __arrL({"Tainá, estudante de Antropologia na UESB. Minha família tem raiz indígena aqui da região. Minha avó contava as histórias e eu resolvi contar também, só que pra mais gente."}, 1)
                                },
                                2
                            ),
                            __arrL(
                                {
                                    "Me fala da cidade",
                                    __arrL({"O monumento lembra os povos que viviam neste planalto antes da cidade existir, como os Mongoió e os Imboré. Eles conheciam cada nascente, cada serra e cada bicho daqui.", "Muita palavra que a gente usa veio deles e nem percebe. Quando você atravessar a rotatória, olha pro arco e lembra: a história desta terra é bem mais antiga que o asfalto."}, 2)
                                },
                                2
                            ),
                            __arrL(
                                {
                                    "E a sua história?",
                                    __arrL({"Na escola eu tinha vergonha de falar da minha família. Hoje eu tenho é orgulho, e um mapa cheio de lugares que a minha avó me ensinou.", "Meu sonho é montar um museu vivo, com língua, comida e música. Se precisar de ajuda pra achar alguma coisa nesta cidade, pode me chamar. Eu sei onde fica tudo, até o que não tá no mapa."}, 2)
                                },
                                2
                            )
                        },
                        3
                    )
                },
                "id,nome,papel,cena,x,spec,oi,temas"
            ),
            __ord(
                {
                    id = "c2n_ze_pandeiro",
                    nome = "Mestre Zé Pandeiro",
                    papel = "sanfoneiro e cantador da feira",
                    cena = 17,
                    x = 1640,
                    spec = __ord(
                        __assign(
                            {},
                            pele(nil, "escuro"),
                            {
                                build = "belly",
                                top = "#f2efe6",
                                topKind = "tee",
                                sleeve = "short",
                                print = "#c43c3a",
                                pants = "#3a4a5a",
                                hat = __ord({kind = "straw", color = "#d7b665"}, "kind,color"),
                                hair = __ord({style = "short", color = "#c8c4bc"}, "style,color"),
                                mustache = "#e0dcd4",
                                item = "mic",
                                pose = "sing"
                            }
                        ),
                        "build,top,topKind,sleeve,print,pants,hat,hair,mustache,item,pose"
                    ),
                    oi = "Ôôô, chegou mais um pra roda! Vem cá, menino. Na minha feira ninguém compra calado: tem que sair cantando.",
                    temas = __arrL(
                        {
                            __arrL(
                                {
                                    "Quem é você?",
                                    __arrL({"Zé Pandeiro! O nome é pandeiro, mas eu toco sanfona, triângulo, zabumba e, quando a pressão sobe, colher de pau. Canto na feira toda semana desde que o biscoito custava um tostão."}, 1)
                                },
                                2
                            ),
                            __arrL(
                                {
                                    "Me fala da cidade",
                                    __arrL({"Conquista no São João é outra coisa: fogueira na rua, forró pé de serra, quentão pra espantar o frio e licor de jenipapo, que é mais perigoso que cobra.", "E no inverno tem o Festival de Inverno, com show grande. Mas o melhor palco ainda é este aqui, entre a banca de banana e a de biscoito."}, 2)
                                },
                                2
                            ),
                            __arrL(
                                {
                                    "E a sua história?",
                                    __arrL({"Aprendi sanfona com meu pai num fole remendado com fita isolante. A primeira vez que toquei em público foi num casamento. O noivo fugiu, mas a festa foi boa.", "Tô ensinando os meninos da feira a tocar, de graça. Música de raiz não pode morrer. Se você souber um forró da roça, vem cantar comigo. Se não souber, eu te ensino."}, 2)
                                },
                                2
                            )
                        },
                        3
                    )
                },
                "id,nome,papel,cena,x,spec,oi,temas"
            ),
            __ord(
                {
                    id = "c2n_fabi",
                    nome = "Doutora Fabi",
                    papel = "veterinária da feira de adoção do Parcão",
                    cena = 33,
                    x = 4280,
                    spec = __ord(
                        __assign(
                            {},
                            pele(nil, "claro"),
                            {
                                build = "slim",
                                h = 0.95,
                                top = "#f6f6f2",
                                topKind = "coat",
                                pants = "#3a5a8a",
                                hair = __ord({style = "ponytail", color = "#6a3a1c"}, "style,color"),
                                glasses = "#3a6aa8",
                                item = "phone",
                                pose = "hips"
                            }
                        ),
                        "build,h,top,topKind,pants,hair,glasses,item,pose"
                    ),
                    oi = "Cuidado onde pisa! Brincadeira, o parcão é limpinho. Veio adotar um amigo de quatro patas? Já viu o Tripé? Ele corre mais que muito atleta.",
                    temas = __arrL(
                        {
                            __arrL(
                                {
                                    "Quem é você?",
                                    __arrL({"Fabiana, veterinária. Todo sábado eu faço feira de adoção aqui no Parcão e vacino bicho de graça. Domingo eu durmo. Às vezes."}, 1)
                                },
                                2
                            ),
                            __arrL(
                                {
                                    "Me fala da cidade",
                                    __arrL({"Conquista tem cachorro caramelo em todo canto: na praça, na rodoviária, até no campus da UESB, onde tem um que assiste aula de Filosofia.", "No frio, os bichinhos de rua sofrem. A gente faz campanha de cobertor velho no inverno. Se você tiver um sobrando, a cachorrada agradece."}, 2)
                                },
                                2
                            ),
                            __arrL(
                                {
                                    "E a sua história?",
                                    __arrL({"Quando eu era criança, achei um filhote na chuva e escondi no meu quarto por três semanas. Minha mãe só descobriu quando ele comeu o sofá.", "Ali eu soube o que queria ser. Já ajudei a adotar mais de mil bichos. O Tripé, aquele de três patas, foi o primeiro que eu não consegui doar. Ele me adotou primeiro."}, 2)
                                },
                                2
                            )
                        },
                        3
                    )
                },
                "id,nome,papel,cena,x,spec,oi,temas"
            ),
            __ord(
                {
                    id = "c2n_gabi",
                    nome = "Gabi do Voo Livre",
                    papel = "piloto de parapente da Serra do Marçal",
                    cena = 34,
                    x = 2940,
                    spec = __ord(
                        __assign(
                            {},
                            pele(nil, "jambo"),
                            {
                                build = "strong",
                                h = 0.97,
                                top = "#e8433a",
                                topKind = "puffer",
                                pants = "#2a3038",
                                hat = __ord({kind = "helmet", color = "#f2c94c", visor = "#2a3a46"}, "kind,color,visor"),
                                pose = "thumb",
                                mood = "happy"
                            }
                        ),
                        "build,h,top,topKind,pants,hat,pose,mood"
                    ),
                    oi = "E aí, vai voar hoje? O vento tá perfeito! Brincadeira, primeiro tem curso. Mas olha essa vista e me diz se não dá vontade.",
                    temas = __arrL(
                        {
                            __arrL(
                                {
                                    "Quem é você?",
                                    __arrL({"Gabriela, mas na rampa todo mundo me chama de Gabi. Sou instrutora de parapente aqui na Serra do Marçal. Já voei mais de mil vezes e ainda grito em todas."}, 1)
                                },
                                2
                            ),
                            __arrL(
                                {
                                    "Me fala da cidade",
                                    __arrL({"Daqui de cima a gente vê o planalto acabando e o vale começando lá embaixo. De manhã cedo as nuvens ficam abaixo da gente, tipo um mar branco. Parece que dá pra pisar.", "A estrada desce a serra cheia de curvas. Lá embaixo é mais quente: você desce de casaco e chega de camiseta."}, 2)
                                },
                                2
                            ),
                            __arrL(
                                {
                                    "E a sua história?",
                                    __arrL({"Eu era mototaxista e morria de medo de altura. Não subia nem em escada de dois degraus.", "Um dia trouxe um passageiro até aqui pra ele voar. Ele voltou chorando de alegria e eu pensei: \"eu quero isso\". Subi a rampa tremendo e voei. Hoje o medo vai junto, mas quem pilota sou eu."}, 2)
                                },
                                2
                            )
                        },
                        3
                    )
                },
                "id,nome,papel,cena,x,spec,oi,temas"
            ),
            __ord(
                {
                    id = "c2n_zefa",
                    nome = "Dona Zefa do Café",
                    papel = "cafeicultora mais antiga do planalto",
                    cena = 18,
                    x = 1180,
                    spec = __ord(
                        __assign(
                            {},
                            pele(nil, "cobre"),
                            {
                                build = "normal",
                                h = 0.9,
                                hunch = true,
                                top = "#7a8a4a",
                                topKind = "apron",
                                apron = "#e9dcc0",
                                skirt = "#5a4a3a",
                                hat = __ord({kind = "straw", color = "#d7b665"}, "kind,color"),
                                hair = __ord({style = "bun", color = "#c8c4bc"}, "style,color"),
                                item = "mug",
                                pose = "mug"
                            }
                        ),
                        "build,h,hunch,top,topKind,apron,skirt,hat,hair,item,pose"
                    ),
                    oi = "Chega, meu filho. Toma um cafezinho que acabou de passar no coador de pano. Coador de pano, viu? Não aceito máquina na minha cozinha.",
                    temas = __arrL(
                        {
                            __arrL(
                                {
                                    "Quem é você?",
                                    __arrL({"Josefa, mas é Zefa desde o batizado. Planto café neste planalto há sessenta safras. Conheço cada pé pelo nome, e alguns pelo apelido."}, 1)
                                },
                                2
                            ),
                            __arrL(
                                {
                                    "Me fala da cidade",
                                    __arrL({"O frio e a altura deixam o café daqui doce e encorpado. Tem gente de fora que vem só provar. O café de Conquista viaja o mundo e volta em pacote bonito, custando o triplo.", "Na colheita, a fazenda inteira vira festa: pano no chão, peneira, rodo no terreiro, e a molecada correndo atrás das galinhas."}, 2)
                                },
                                2
                            ),
                            __arrL(
                                {
                                    "E a sua história?",
                                    __arrL({"Teve um ano em que deu geada e queimou quase tudo. Meu marido queria vender a terra pro Barão. Eu disse: \"sobre o meu cadáver\". Replantei pé por pé, com as minhas mãos.", "O Barão do Café vive querendo comprar a minha terra até hoje. Ele tem dinheiro, mas eu tenho paciência, e café bom é feito de paciência."}, 2)
                                },
                                2
                            )
                        },
                        3
                    )
                },
                "id,nome,papel,cena,x,spec,oi,temas"
            ),
            __ord(
                {
                    id = "c2n_rafa",
                    nome = "Rafa Goleiro",
                    papel = "goleiro do Planalto FC",
                    cena = 29,
                    x = 2480,
                    spec = __ord(
                        __assign(
                            {},
                            pele(nil, "canela"),
                            {
                                build = "strong",
                                top = "#2c8a3a",
                                topKind = "tee",
                                sleeve = "short",
                                print = "#f2c94c",
                                pants = "#1e1e22",
                                hair = __ord({style = "buzz", color = "#1b1714"}, "style,color"),
                                gloves = "#f2c94c",
                                pose = "cocky"
                            }
                        ),
                        "build,top,topKind,sleeve,print,pants,hair,gloves,pose"
                    ),
                    oi = "Opa! Pode chegar, mas não pisa na linha da pista com o pé esquerdo, que dá azar. É sério. Eu levei um frango no dia que alguém pisou.",
                    temas = __arrL(
                        {
                            __arrL(
                                {
                                    "Quem é você?",
                                    __arrL({"Rafael, goleiro titular do Planalto FC. Fechei o gol em sete jogos seguidos. No oitavo, a bola bateu num pombo e entrou. O pombo tá bem, eu que não tô."}, 1)
                                },
                                2
                            ),
                            __arrL(
                                {
                                    "Me fala da cidade",
                                    __arrL({"Dia de jogo no Lomantão a cidade para. Tem espetinho na porta, buzinaço, criança com a cara pintada e o BODÃO, nosso mascote, dançando mais que o time joga.", "E o frio! Jogo de noite no inverno é luva, touca e torcida soltando fumaça pela boca. Parece que todo mundo tá fumando, mas é só o frio mesmo."}, 2)
                                },
                                2
                            ),
                            __arrL(
                                {
                                    "E a sua história?",
                                    __arrL({"Comecei no campinho de terra do bairro, defendendo com chinelo nas mãos porque luva era luxo. Minha mãe costurou a primeira com pano de prato.", "Meu sonho é jogar na Série A e levar o nome de Conquista. Até lá, entro em campo sempre com o pé direito, beijo a trave duas vezes e falo com a bola. Ela me entende."}, 2)
                                },
                                2
                            )
                        },
                        3
                    )
                },
                "id,nome,papel,cena,x,spec,oi,temas"
            ),
            __ord(
                {
                    id = "c2n_celeste",
                    nome = "Irmã Celeste",
                    papel = "freira da Catedral (e fã de heavy metal)",
                    cena = 14,
                    x = 2180,
                    spec = __ord(
                        __assign(
                            {},
                            pele(nil, "trigo"),
                            {
                                build = "normal",
                                h = 0.93,
                                top = "#2a2f3a",
                                topKind = "robe",
                                robeDots = "#2a2f3a",
                                pants = "#2a2f3a",
                                hair = __ord({style = "short", color = "#2a2f3a"}, "style,color"),
                                glasses = "#2a2a2a",
                                headset = "#c43c3a",
                                item = "book",
                                pose = "talk",
                                mood = "happy"
                            }
                        ),
                        "build,h,top,topKind,robeDots,pants,hair,glasses,headset,item,pose,mood"
                    ),
                    oi = "A paz, meu filho! Hã? Ah, os fones. É... um hino. Um hino bem animado. Com guitarra. E bateria dupla.",
                    temas = __arrL(
                        {
                            __arrL(
                                {
                                    "Quem é você?",
                                    __arrL({"Irmã Celeste. Cuido da cozinha solidária aqui da Catedral: sopa quente todo dia de inverno pra quem precisa. E nas horas vagas eu escuto heavy metal. Deus entende, ele fez o trovão."}, 1)
                                },
                                2
                            ),
                            __arrL(
                                {
                                    "Me fala da cidade",
                                    __arrL({"A Catedral Nossa Senhora das Vitórias é o coração do centro. A praça em volta junta todo mundo: aposentado, pombo, namorado, vendedor e turista perdido.", "No inverno, quando a neblina desce, a torre some lá em cima. Os mais velhos dizem que é a santa se cobrindo do frio."}, 2)
                                },
                                2
                            ),
                            __arrL(
                                {
                                    "E a sua história?",
                                    __arrL({"Antes de entrar pro convento, eu tocava bateria numa banda chamada \"Neblina Mortal\". A gente era horrível. Maravilhosamente horrível.", "Hoje eu toco bateria só no bazar beneficente, uma vez por ano. A fila é enorme. Metade vem pela caridade e a outra metade pelo solo de bateria."}, 2)
                                },
                                2
                            )
                        },
                        3
                    )
                },
                "id,nome,papel,cena,x,spec,oi,temas"
            ),
            __ord(
                {
                    id = "c2n_kiko",
                    nome = "Kiko do Pedalinho",
                    papel = "aluga pedalinho na Lagoa das Bateias",
                    cena = 32,
                    x = 3880,
                    spec = __ord(
                        __assign(
                            {},
                            pele(nil, "preto"),
                            {
                                build = "slim",
                                h = 0.88,
                                top = "#3c8ad8",
                                topKind = "tank",
                                pants = "#c47a35",
                                hat = __ord({kind = "capback", color = "#e8433a"}, "kind,color"),
                                hair = __ord({style = "short", color = "#14100c"}, "style,color"),
                                pose = "pockets",
                                mood = "happy"
                            }
                        ),
                        "build,h,top,topKind,pants,hat,hair,pose,mood"
                    ),
                    oi = "Ô, moço! Pedalinho de cisne, dez reais a meia hora. Se o cisne virar, o banho é cortesia. Brincadeira, nunca virou. Quase.",
                    temas = __arrL(
                        {
                            __arrL(
                                {
                                    "Quem é você?",
                                    __arrL({"Kiko, quinze anos, gerente, piloto de testes e único funcionário da Pedalinhos do Kiko. O dono é meu tio, mas quem manda nos cisnes sou eu."}, 1)
                                },
                                2
                            ),
                            __arrL(
                                {
                                    "Me fala da cidade",
                                    __arrL({"A Lagoa das Bateias é o lugar mais calmo da cidade: gente correndo na pista, garça pescando, pato desfilando com os filhotes. Bateia é aquela bacia de garimpar ouro.", "Dizem que antigamente tinha garimpo por aqui e que ainda tem uma pepita no fundo da lagoa. Eu já mergulhei três vezes. Achei um chinelo, uma moeda de dez centavos e um celular de 2009."}, 2)
                                },
                                2
                            ),
                            __arrL(
                                {
                                    "E a sua história?",
                                    __arrL({"Meu pai pescava aqui todo domingo e me trazia junto. Hoje quem pesca é o Seu Toninho, ali no píer, mas eu guardo o lugar do meu pai.", "Tô juntando dinheiro dos pedalinhos pra fazer faculdade de Biologia na UESB. Quero cuidar da lagoa e dos bichos dela. Os cisnes de plástico já tão aprovados no estágio."}, 2)
                                },
                                2
                            )
                        },
                        3
                    )
                },
                "id,nome,papel,cena,x,spec,oi,temas"
            )
        },
        10
    )
    local function M(____, id, nome, papel, cena, x, spec, oi, quem, cidade, historia)
        return {
            id = id,
            nome = nome,
            papel = papel,
            cena = cena,
            x = x,
            spec = spec,
            oi = oi,
            temas = __arrL(
                {
                    __arrL({"Quem é você?", quem}, 2),
                    __arrL({"Me fala da cidade", cidade}, 2),
                    __arrL({"E a sua história?", historia}, 2)
                },
                3
            )
        }
    end
    local MORADORES = __arrL(
        {
            M(
                nil,
                "c2m_agenor",
                "Seu Agenor",
                "aposentado do banco da praça",
                14,
                2060,
                __ord(
                    __assign(
                        {},
                        pele(nil, "canela"),
                        {
                            build = "belly",
                            h = 0.92,
                            top = "#7a5a3a",
                            topKind = "cardigan",
                            inner = "#e8e2d0",
                            pants = "#4a4a42",
                            hat = __ord({kind = "cap", color = "#5a4a3a"}, "kind,color"),
                            hair = __ord({style = "bald", color = "#c8c4bc"}, "style,color"),
                            mustache = "#e0dcd4",
                            item = "cane",
                            pose = "cane"
                        }
                    ),
                    "build,h,top,topKind,inner,pants,hat,hair,mustache,item,pose"
                ),
                "Bom dia, rapaz. Senta aqui no banco, que o sol tá batendo bonitinho. Em Conquista, sol de inverno é ouro.",
                __arrL({"Agenor, aposentado dos Correios. Hoje meu emprego é dar milho pros pombos e opinião pros outros. As duas coisas de graça."}, 1),
                __arrL({"Esta praça já viu de tudo: comício, procissão, desfile e namoro escondido atrás da árvore. Inclusive o meu, em 1968.", "Frio de verdade é em junho e julho. Tem dia que amanhece com neblina tão grossa que a gente cumprimenta poste achando que é gente."}, 2),
                __arrL({"Entreguei carta nesta cidade por trinta e cinco anos, a pé. Conheço o endereço de todo mundo. Se quiser achar alguém, me pergunta antes de perguntar pro celular."}, 1)
            ),
            M(
                nil,
                "c2m_neide",
                "Dona Neide",
                "dona da banca de revista",
                14,
                1320,
                __ord(
                    __assign(
                        {},
                        pele(nil, "moreno"),
                        {
                            build = "normal",
                            h = 0.93,
                            top = "#c43c6a",
                            topKind = "cardigan",
                            inner = "#f2e8d8",
                            skirt = "#4a3a5a",
                            hair = __ord({style = "curlyShort", color = "#6a3a2a"}, "style,color"),
                            glasses = "#c43c3a",
                            item = "book",
                            pose = "read"
                        }
                    ),
                    "build,h,top,topKind,inner,skirt,hair,glasses,item,pose"
                ),
                "Jornal, revista, figurinha, palavra cruzada? Ou só veio ler a capa de graça igual todo mundo?",
                __arrL({"Neide da banca. Tô aqui há trinta anos. Hoje vendo mais figurinha e chip de celular do que jornal, mas a banca continua firme."}, 1),
                __arrL({"O centro de Conquista é comércio de ponta a ponta. De manhã é buzina, à tarde é promoção e à noite é friozinho com cheiro de pipoca.", "Já reparou que as lojas daqui têm nome parecido com as de fora? CASAS BAIXA, PAGUE MAIS... É a criatividade do conquistense."}, 2),
                __arrL({"Minha mãe abriu esta banca com um caixote e três revistas. Eu cresci lendo gibi escondida debaixo do balcão. Hoje minha neta faz a mesma coisa e eu finjo que não vejo."}, 1)
            ),
            M(
                nil,
                "c2m_wellington",
                "Wellington",
                "mototaxista",
                16,
                1760,
                __ord(
                    __assign(
                        {},
                        pele(nil, "jambo"),
                        {
                            build = "normal",
                            top = "#3a3f44",
                            topKind = "vest",
                            vest = "#f08a24",
                            vestBand = "#e8f06a",
                            pants = "#2a3038",
                            hat = __ord({kind = "helmet", color = "#2c5a9e", visor = "#2a3a46"}, "kind,color,visor"),
                            pose = "thumb"
                        }
                    ),
                    "build,top,topKind,vest,vestBand,pants,hat,pose"
                ),
                "Corrida? Pra qualquer bairro, preço justo! Diferente de um certo Tonhão que eu não vou falar o nome... Ops.",
                __arrL({"Wellington, mototaxista há dez anos. Conheço todo atalho, buraco e lombada desta cidade. Os buracos, inclusive, têm nome."}, 1),
                __arrL({"Conquista cresceu muito, rapaz. Onde era mato agora é condomínio, e onde era condomínio agora é engarrafamento.", "Dica de mototaxista: no inverno, casaco por baixo do colete. O vento na Olívia Flores corta mais que faca de açougueiro."}, 2),
                __arrL({"Comprei minha primeira moto com o dinheiro de vender picolé no Lomantão. Hoje sustento minha família com ela. Ela chama Dona Cleide. Não me pergunte por quê."}, 1)
            ),
            M(
                nil,
                "c2m_lia",
                "Lia",
                "ciclista e entregadora",
                21,
                960,
                __ord(
                    __assign(
                        {},
                        pele(nil, "claro"),
                        {
                            build = "slim",
                            h = 0.93,
                            top = "#3c8a5a",
                            topKind = "hoodie",
                            inner = "#2a3a2c",
                            pants = "#22262c",
                            hair = __ord({style = "ponytail", color = "#c8a050"}, "style,color"),
                            pose = "hips"
                        }
                    ),
                    "build,h,top,topKind,inner,pants,hair,pose"
                ),
                "Ufa! Parei só pra respirar. Já pedalei vinte quilômetros hoje, mas a ciclovia da Olívia é a melhor parte.",
                __arrL({"Lia, entregadora de bike. Levo comida, documento e, uma vez, um papagaio. Ele não gostou da viagem e me xingou o caminho todo."}, 1),
                __arrL({"A Olívia Flores é a avenida mais bonita da cidade: canteiro verde, ciclovia, gente correndo de manhã e academia ao ar livre.", "Só cuidado com a subida perto da escola. Na bike ela parece o Everest."}, 2),
                __arrL({"Comecei a pedalar pra economizar a passagem. Virou paixão. Ano que vem vou tentar uma prova de ciclismo em Salvador. Vou de bike até lá? Não, aí também não."}, 1)
            ),
            M(
                nil,
                "c2m_cotinha",
                "Dona Cotinha",
                "dona da biscoitaria",
                17,
                470,
                __ord(
                    __assign(
                        {},
                        pele(nil, "canela"),
                        {
                            build = "belly",
                            h = 0.9,
                            top = "#c47a35",
                            topKind = "apron",
                            apron = "#f6ecd0",
                            skirt = "#6a4a3a",
                            hair = __ord({style = "bun", color = "#e0dcd4"}, "style,color"),
                            item = "biscuit",
                            pose = "offer"
                        }
                    ),
                    "build,h,top,topKind,apron,skirt,hair,item,pose"
                ),
                "Prova um biscoitinho, meu bem. Tá quentinho, saiu agora. Se não gostar, eu como de volta.",
                __arrL({"Cotinha, da biscoitaria. Faço biscoito de polvilho, sequilho e bolo de puba. A receita é da minha avó e o segredo vai comigo pro túmulo."}, 1),
                __arrL({"Biscoito em Conquista é coisa séria: tem no café da manhã, no lanche, na rodoviária e na bolsa da sua tia.", "No frio, um café com biscoito resolve quase tudo. O que não resolve, resolve com dois."}, 2),
                __arrL({"Comecei vendendo na porta de casa, em bacia. Hoje tenho loja, três fornos e uma fila que dobra a esquina no sábado. O Fusca do Seu Arlindo para aqui todo dia, por isso tem engarrafamento."}, 1)
            ),
            M(
                nil,
                "c2m_pedro",
                "Pedro",
                "estudante de Medicina",
                31,
                1500,
                __ord(
                    __assign(
                        {},
                        pele(nil, "escuro"),
                        {
                            build = "slim",
                            top = "#f6f6f2",
                            topKind = "coat",
                            pants = "#2c3646",
                            hair = __ord({style = "curly", color = "#14100c"}, "style,color"),
                            glasses = "#2a2a2a",
                            item = "book",
                            pose = "read",
                            mood = "sad"
                        }
                    ),
                    "build,top,topKind,pants,hair,glasses,item,pose,mood"
                ),
                "Desculpa, eu tô estudando pra prova de Anatomia. São 206 ossos e eu só lembro do fêmur. E mal.",
                __arrL({"Pedro, terceiro ano de Medicina. Durmo quatro horas por noite e o resto é café. Minha corrente sanguínea é sessenta por cento cafezinho."}, 1),
                __arrL({"Conquista é polo de saúde da região toda. Vem gente de muita cidade do sudoeste baiano se tratar aqui: hospital, clínica e universidade.", "E o RU é a salvação do estudante: almoço barato, bandeja cheia e fila que dá pra fazer amizade."}, 2),
                __arrL({"Sou o primeiro médico da minha família. Quer dizer, vou ser. Minha mãe já me apresenta como \"doutor\" desde o vestibular. A pressão é grande."}, 1)
            ),
            M(
                nil,
                "c2m_josue",
                "Josué",
                "segurança do shopping",
                20,
                520,
                __ord(
                    __assign(
                        {},
                        pele(nil, "preto"),
                        {
                            build = "strong",
                            top = "#1f2226",
                            topKind = "tee",
                            sleeve = "short",
                            pants = "#1f2226",
                            hair = __ord({style = "bald", color = "#1b1714"}, "style,color"),
                            shades = true,
                            pose = "hips"
                        }
                    ),
                    "build,top,topKind,sleeve,pants,hair,shades,pose"
                ),
                "Boa tarde, cidadão. Sem correr no shopping. E sem pular nas plataformas de vidro... Ah, deixa, você parece responsável.",
                __arrL({"Josué, segurança do shopping. Pareço bravo, mas choro em filme de cachorro. Não conta pra ninguém."}, 1),
                __arrL({"O shopping é o ponto de encontro da cidade: cinema, lan house, praça de alimentação e gente fugindo do frio.", "No Festival de Inverno fica lotado de turista. Todo mundo pergunta onde compra casaco. Eu aponto pra RIACHORRO."}, 2),
                __arrL({"Fui lutador de boxe amador. Perdi mais do que ganhei, mas aprendi a ficar de pé. Hoje treino a molecada do bairro de graça, nos domingos."}, 1)
            ),
            M(
                nil,
                "c2m_rosa",
                "Tia Rosa",
                "vendedora de acarajé",
                13,
                2760,
                __ord(
                    __assign(
                        {},
                        pele(nil, "preto"),
                        {
                            build = "belly",
                            h = 0.94,
                            top = "#f6f6f2",
                            topKind = "robe",
                            robeDots = "#e8c24c",
                            pants = "#f6f6f2",
                            hair = __ord({style = "bun", color = "#14100c"}, "style,color"),
                            earrings = "#e8c24c",
                            scarf = "#e8433a",
                            pose = "offer",
                            mood = "happy"
                        }
                    ),
                    "build,h,top,topKind,robeDots,pants,hair,earrings,scarf,pose,mood"
                ),
                "Acarajé quente ou frio? Quente quer dizer com pimenta, viu, meu filho? Já vi gente de fora chorar e pedir mais.",
                __arrL({"Rosa, baiana de acarajé. Tabuleiro na esquina há vinte e cinco anos, chova ou faça frio. E aqui faz frio."}, 1),
                __arrL({"Conquista é Bahia também, viu? Pode ser fria, mas o tempero é o mesmo. Acarajé, abará, vatapá e caruru: tem tudo.", "O bairro da pensão é bom de morar: vizinho que empresta açúcar, cachorro que cumprimenta e Dona Lurdes que sabe de tudo antes de acontecer."}, 2),
                __arrL({"Aprendi a fazer acarajé com minha mãe, em Salvador. Vim pra cá atrás do meu marido, que veio atrás de emprego. O emprego acabou, o marido também. O acarajé ficou."}, 1)
            ),
            M(
                nil,
                "c2m_marquinhos",
                "Marquinhos",
                "dono do lava-jato",
                16,
                5300,
                __ord(
                    __assign(
                        {},
                        pele(nil, "cobre"),
                        {
                            build = "normal",
                            top = "#3c6aa8",
                            topKind = "overall",
                            inner = "#e8e2d0",
                            pants = "#3c6aa8",
                            hat = __ord({kind = "capback", color = "#f2c94c"}, "kind,color"),
                            hair = __ord({style = "short", color = "#1c1714"}, "style,color"),
                            item = "wrench",
                            pose = "carry"
                        }
                    ),
                    "build,top,topKind,inner,pants,hat,hair,item,pose"
                ),
                "Lavagem completa por trinta! Mas se for o Fusca do Seu Arlindo, cobro cinquenta: aquilo tem biscoito até no motor.",
                __arrL({"Marquinhos, do lava-jato e borracharia. Conserto pneu, lavo carro e dou conselho amoroso. O conselho é de graça e geralmente errado."}, 1),
                __arrL({"Na Avenida passa o mundo inteiro: caminhão da Rio-Bahia, ônibus, moto e carro de som anunciando promoção de colchão.", "Quando chove, a poça da frente vira piscina. Já vi criança de boia ali."}, 2),
                __arrL({"Comecei com um balde e uma esponja na porta do posto. Hoje tenho dois funcionários e uma máquina de espuma que eu chamo de \"Nuvem\". Ela entende."}, 1)
            ),
            M(
                nil,
                "c2m_dalva",
                "Vó Dalva",
                "moradora mais antiga do bairro",
                13,
                1240,
                __ord(
                    __assign(
                        {},
                        pele(nil, "trigo"),
                        {
                            build = "normal",
                            h = 0.86,
                            hunch = true,
                            top = "#8a5aa0",
                            topKind = "cardigan",
                            inner = "#efe2c8",
                            skirt = "#5b4a62",
                            hair = __ord({style = "curlyShort", color = "#f2efe6"}, "style,color"),
                            glasses = "#8a7a6a",
                            scarf = "#3c6aa8",
                            item = "cane",
                            pose = "cane"
                        }
                    ),
                    "build,h,hunch,top,topKind,inner,skirt,hair,glasses,scarf,item,pose"
                ),
                "Chega mais perto, meu neto, que minha vista não é mais aquela. Ah, é o rapaz do chapéu! Lurdes falou de você.",
                __arrL({"Dalva, noventa e um anos. Moro nesta rua desde que ela era de barro. Já fui costureira, parteira e, por um verão, campeã de dominó."}, 1),
                __arrL({"Antigamente Conquista era pequenininha: uma igreja, umas ruas e muito boi. A Rio-Bahia veio e trouxe gente de todo lado. Hoje é cidade grande, mas o frio continua o mesmo.", "Teve inverno de geada branquinha no capim, parecendo açúcar. A criançada achava que era neve e saía correndo de pé descalço."}, 2),
                __arrL({"Fiz o parto de metade dos meninos desta rua, de lamparina na mão. Quando vejo um deles de terno, penso: esse aí eu segurei pelas perninhas."}, 1)
            ),
            M(
                nil,
                "c2m_caua",
                "Cauã",
                "menino da pipa",
                33,
                2560,
                __ord(
                    __assign(
                        {},
                        pele(nil, "jambo"),
                        {
                            build = "slim",
                            h = 0.78,
                            top = "#e8c24c",
                            topKind = "tee",
                            sleeve = "short",
                            pants = "#3c6aa8",
                            hair = __ord({style = "short", color = "#14100c"}, "style,color"),
                            pose = "thumb",
                            mood = "happy"
                        }
                    ),
                    "build,h,top,topKind,sleeve,pants,hair,pose,mood"
                ),
                "Olha minha pipa lá em cima! É a vermelha, a mais alta! As outras são da molecada da outra rua. Perdedores.",
                __arrL({"Cauã, nove anos, campeão de pipa do Parque da Cidade. Título dado por mim mesmo, mas tá valendo."}, 1),
                __arrL({"Agosto é mês de vento bom em Conquista. O céu fica cheio de pipa. Mas cerol é proibido, viu? Corta o pescoço dos motoqueiros. Pipa boa é com linha limpa.", "No parque tem tudo: balanço, skate, picolé e o trenzinho, que eu acho meio de bebê, mas eu ando escondido."}, 2),
                __arrL({"Meu avô me ensinou a fazer pipa com vareta de bambu e papel de seda. A minha dura mais que a da loja. Um dia vou fazer uma do tamanho de uma porta."}, 1)
            ),
            M(
                nil,
                "c2m_toninho",
                "Seu Toninho",
                "pescador do píer",
                32,
                1700,
                __ord(
                    __assign(
                        {},
                        pele(nil, "canela"),
                        {
                            build = "belly",
                            h = 0.94,
                            top = "#5a7a4a",
                            topKind = "vest",
                            vest = "#c8b48a",
                            vestBand = "#8a7a5a",
                            pants = "#4a4a42",
                            hat = __ord({kind = "straw", color = "#d7b665"}, "kind,color"),
                            hair = __ord({style = "short", color = "#c8c4bc"}, "style,color"),
                            mustache = "#c8c4bc",
                            pose = "relaxed"
                        }
                    ),
                    "build,h,top,topKind,vest,vestBand,pants,hat,hair,mustache,pose"
                ),
                "Psiu! Fala baixinho que o peixe escuta. Ontem eu peguei um deste tamanho. Tá, deste tamanho. Tá bom, era um lambari.",
                __arrL({"Antônio, pescador de fim de semana, contador de história de segunda a sexta. Aposentado da prefeitura."}, 1),
                __arrL({"A lagoa é o quintal de quem não tem quintal. Tem garça, pato, gente correndo e casal brigando no pedalinho.", "De manhã cedo a neblina fica em cima da água que nem fumaça. É a hora mais bonita, e a hora que o peixe morde."}, 2),
                __arrL({"Pescava aqui com o pai do Kiko, o menino dos pedalinhos. Grande amigo. Hoje eu ensino o Kiko a ter paciência. Ele não aprende, mas eu tenho paciência."}, 1)
            ),
            M(
                nil,
                "c2m_jurema",
                "Jurema",
                "vendedora de passagens",
                30,
                1160,
                __ord(
                    __assign(
                        {},
                        pele(nil, "moreno"),
                        {
                            build = "normal",
                            h = 0.94,
                            top = "#2c5a9e",
                            topKind = "tee",
                            sleeve = "short",
                            pants = "#2a2f3a",
                            hair = __ord({style = "long", color = "#3a2418"}, "style,color"),
                            earrings = "#e8c24c",
                            lipstick = "#c4384e",
                            item = "phone",
                            pose = "phone"
                        }
                    ),
                    "build,h,top,topKind,sleeve,pants,hair,earrings,lipstick,item,pose"
                ),
                "Próximo! Ah, não é cliente. Tudo bem, a fila tá vazia mesmo. Fica à vontade, só não senta na mala de ninguém.",
                __arrL({"Jurema, do guichê da Novo Horizontinho. Vendo passagem pra Salvador, Brumado, Jequié... e escuto cada história que dava novela."}, 1),
                __arrL({"A rodoviária é a porta da cidade. Gente chegando pra estudar na UESB, pra se tratar no hospital, pra visitar a avó ou fugindo de namorado.", "Sexta à noite é um formigueiro. Domingo à noite, todo mundo volta com sacola de biscoito e café pra família."}, 2),
                __arrL({"Já vendi passagem pra noivo fugindo do casamento e, uma hora depois, pra noiva indo atrás. Os dois voltaram casados. Eu fui madrinha."}, 1)
            ),
            M(
                nil,
                "c2m_beto",
                "Beto Taxista",
                "taxista do aeroporto",
                12,
                3900,
                __ord(
                    __assign(
                        {},
                        pele(nil, "claro"),
                        {
                            build = "belly",
                            top = "#e8e2d0",
                            topKind = "polo",
                            sleeve = "short",
                            pattern = "#c8c2b0",
                            pants = "#3a3f46",
                            hair = __ord({style = "side", color = "#6a5040"}, "style,color"),
                            mustache = "#6a5040",
                            item = "keys",
                            pose = "talk"
                        }
                    ),
                    "build,top,topKind,sleeve,pattern,pants,hair,mustache,item,pose"
                ),
                "Táxi? Ah, já tem o Seu Zé, né? Aquele lá rouba cliente com conversa. Eu roubo com desconto.",
                __arrL({"Roberto, taxista do aeroporto. Rival declarado do Seu Zé do Táxi. A gente briga por passageiro e depois toma café junto."}, 1),
                __arrL({"O aeroporto Glauber Rocha leva o nome do cineasta mais famoso da cidade. Quem desce do avião já sente o frio na escada e pergunta: \"isso aqui é Bahia mesmo?\"", "Do aeroporto ao centro é rapidinho. A não ser que o Seu Zé pegue o passageiro, aí ele dá um tour e cobra."}, 2),
                __arrL({"Era caminhoneiro na Rio-Bahia. Rodei o Brasil inteiro e escolhi parar aqui, por causa do clima. E de uma moça da padaria. Hoje ela é minha esposa e a padaria é nossa."}, 1)
            ),
            M(
                nil,
                "c2m_anaclara",
                "Ana Clara",
                "guia da trilha do Cristo",
                15,
                1260,
                __ord(
                    __assign(
                        {},
                        pele(nil, "trigo"),
                        {
                            build = "slim",
                            h = 0.95,
                            top = "#e8833a",
                            topKind = "puffer",
                            pants = "#3a4a3a",
                            hair = __ord({style = "ponytail", color = "#3a2418"}, "style,color"),
                            hat = __ord({kind = "cap", color = "#3c8a5a"}, "kind,color"),
                            item = "map",
                            pose = "offer"
                        }
                    ),
                    "build,h,top,topKind,pants,hair,hat,item,pose"
                ),
                "Oi! Subindo pro Cristo? Leva água e casaco. Lá em cima venta tanto que já vi peruca voando.",
                __arrL({"Ana Clara, guia de trilha. Subo a Serra do Periperi umas cinco vezes por semana. Minha panturrilha tem CPF próprio."}, 1),
                __arrL({"O Cristo daqui é diferente: alongado, de concreto, feito pelo artista Mário Cravo. Lá de cima dá pra ver a cidade inteira espalhada no planalto.", "Nascer do sol no mirante com neblina embaixo é a coisa mais bonita de Conquista. Vale acordar às quatro. Quase."}, 2),
                __arrL({"Comecei a fazer trilha depois de uma fase difícil. Cada subida foi me deixando mais forte. Hoje levo outras pessoas e vejo elas chegando lá em cima com a mesma cara que eu fiz."}, 1)
            ),
            M(
                nil,
                "c2m_ronaldo",
                "Ronaldo",
                "guarda-parque do Poço Escuro",
                28,
                4160,
                __ord(
                    __assign(
                        {},
                        pele(nil, "escuro"),
                        {
                            build = "strong",
                            top = "#4a6a3a",
                            topKind = "vest",
                            vest = "#5a7a3a",
                            vestBand = "#e8c24c",
                            pants = "#3a4a3a",
                            hat = __ord({kind = "rancher", color = "#6b5a3c", band = "#3a2a1a"}, "kind,color,band"),
                            hair = __ord({style = "short", color = "#1c1714"}, "style,color"),
                            pose = "hips"
                        }
                    ),
                    "build,top,topKind,vest,vestBand,pants,hat,hair,pose"
                ),
                "Bem-vindo à reserva! Regras: não jogue lixo, não alimente os saguis e não toque no sapo. Ele tem mais seguidor que eu.",
                __arrL({"Ronaldo, guarda-parque da Reserva do Poço Escuro. Cuido da mata, das trilhas e dos visitantes que se perdem a cinquenta metros da entrada."}, 1),
                __arrL({"É mata atlântica no meio da cidade, acredita? Tem nascente, sagui, tucano, bromélia e árvore com raiz em aba, a tal da sapopemba.", "Essa mata ajuda a segurar a água e o ar fresco de Conquista. Sem ela, a cidade ficava mais seca e mais quente."}, 2),
                __arrL({"Quando criança eu caçava passarinho de estilingue. Um dia vi um tucano de perto e larguei o estilingue no chão. Hoje passo o dia protegendo os passarinhos que eu tentava pegar."}, 1)
            ),
            M(
                nil,
                "c2m_tialourdinha",
                "Tia Lourdinha",
                "dona da cantina da UESB",
                31,
                1180,
                __ord(
                    __assign(
                        {},
                        pele(nil, "canela"),
                        {
                            build = "belly",
                            h = 0.92,
                            top = "#e8433a",
                            topKind = "apron",
                            apron = "#f6f2ea",
                            skirt = "#4a3a5a",
                            hair = __ord({style = "curlyShort", color = "#3a2418"}, "style,color"),
                            glasses = "#8a3a3a",
                            item = "mug",
                            pose = "mug",
                            mood = "happy"
                        }
                    ),
                    "build,h,top,topKind,apron,skirt,hair,glasses,item,pose,mood"
                ),
                "Pastel de queijo, de carne ou de vento? O de vento é pra quem tá no fim do mês. Esse eu dou de graça.",
                __arrL({"Lourdinha, a \"Tia da Cantina\". Alimento estudante há quinze anos. Já vi muito calouro virar doutor comendo meu pastel."}, 1),
                __arrL({"A UESB mudou a cidade: veio gente de toda a região estudar aqui, abriu república, xerox e cantina. Conquista ficou mais jovem.", "Semana do calouro é uma festa. Tem trote, tinta e calouro perdido procurando o módulo de aulas. Fica à direita, sempre."}, 2),
                __arrL({"Comecei vendendo pastel numa caixa de isopor na porta do campus. O reitor da época comprava todo dia. Foi ele que me deu a cantina. Até hoje guardo o primeiro isopor."}, 1)
            ),
            M(
                nil,
                "c2m_thiaguinho",
                "DJ Thiaguinho",
                "DJ do Festival de Inverno",
                19,
                1240,
                __ord(
                    __assign(
                        {},
                        pele(nil, "preto"),
                        {
                            build = "slim",
                            top = "#7a2a8a",
                            topKind = "hoodie",
                            inner = "#2a1a3a",
                            pants = "#1f2430",
                            hat = __ord({kind = "capback", color = "#1e1e22"}, "kind,color"),
                            hair = __ord({style = "short", color = "#14100c"}, "style,color"),
                            headset = "#f2c94c",
                            chain = "#e8c24c",
                            pose = "cocky"
                        }
                    ),
                    "build,top,topKind,inner,pants,hat,hair,headset,chain,pose"
                ),
                "Ôôô, o som tá passando agora, ouviu? Teste, teste... Esse grave é pra esquentar o frio, meu irmão!",
                __arrL({"Thiaguinho, DJ. Toco arrocha, pagode, forró e, se pedir com jeitinho, até valsa de quinze anos."}, 1),
                __arrL({"O Festival de Inverno é a época mais animada da cidade: palco grande, turista, roda-gigante e gente dançando de casaco e touca.", "E o Teatro Glauber Rocha traz peça, cinema e show o ano todo. Hoje mesmo tem Bia do Arrocha!"}, 2),
                __arrL({"Comecei com um som de carro e um pendrive emprestado, tocando em aniversário de bairro. Um dia o DJ principal do festival passou mal e me chamaram. Toquei por quatro horas. Desde então, todo ano."}, 1)
            ),
            M(
                nil,
                "c2m_zezinho",
                "Seu Zezinho",
                "colhedor de café",
                18,
                3000,
                __ord(
                    __assign(
                        {},
                        pele(nil, "cobre"),
                        {
                            build = "slim",
                            top = "#a8b48a",
                            topKind = "tee",
                            sleeve = "long",
                            pants = "#4a4a3a",
                            hat = __ord({kind = "straw", color = "#d7b665"}, "kind,color"),
                            hair = __ord({style = "short", color = "#2a231d"}, "style,color"),
                            pose = "carry"
                        }
                    ),
                    "build,top,topKind,sleeve,pants,hat,hair,pose"
                ),
                "Ê, chegou na hora boa: tá na época da colheita! Quer ajudar a derriçar o pé? Pago em café.",
                __arrL({"José, o Zezinho. Colho café na fazenda da Dona Zefa desde menino. Minhas mãos têm o cheiro do grão, nem sabão tira."}, 1),
                __arrL({"O café do planalto precisa do frio da noite e do sol do dia. É por isso que ele é bom: sofre um pouquinho, igual a gente.", "Depois de colhido, ele seca no terreiro e a gente vira com o rodo, devagar, o dia todo. Café bom é café paciente."}, 2),
                __arrL({"Meu pai colhia aqui, meu avô colhia aqui. Meu filho estuda Agronomia na UESB pra cuidar do cafezal com ciência. Eu ensino o resto: o jeito da mão."}, 1)
            ),
            M(
                nil,
                "c2m_marina",
                "Marina",
                "fotógrafa",
                34,
                1300,
                __ord(
                    __assign(
                        {},
                        pele(nil, "claro"),
                        {
                            build = "slim",
                            h = 0.94,
                            top = "#2c3a5a",
                            topKind = "puffer",
                            pants = "#3a3f46",
                            hair = __ord({style = "long", color = "#c8a050"}, "style,color"),
                            scarf = "#e8c24c",
                            item = "selfie",
                            pose = "selfie"
                        }
                    ),
                    "build,h,top,topKind,pants,hair,scarf,item,pose"
                ),
                "Shhh, espera... a nuvem tá chegando... AGORA! Ah, passou um caminhão. De novo.",
                __arrL({"Marina, fotógrafa de paisagem. Venho pra Serra do Marçal toda semana caçar a foto perfeita do mar de nuvens."}, 1),
                __arrL({"Conquista tem paisagem que pouca gente conhece: o mar de nuvens daqui, o pôr do sol no Cristo, a neblina na lagoa e as torres eólicas girando no fim da tarde.", "Inverno é a melhor época pra foto. O céu fica limpo e azul de dia e a neblina fica bonita de manhã."}, 2),
                __arrL({"Ganhei minha primeira câmera de presente da minha avó, que vendeu umas joias pra comprar. Toda foto que eu tiro, eu penso nela. A melhor ainda não saiu. Um dia sai."}, 1)
            )
        },
        20
    )
    local TODOS = __call(
        __call(
            PERSONAGENS,
            "map",
            function(____, p) return __assign({}, p, {tipo = "personagem"}) end
        ),
        "concat",
        __call(
            MORADORES,
            "map",
            function(____, p) return __assign({}, p, {tipo = "morador"}) end
        )
    )
    for ____, p in __iterar((TODOS)) do
        CP:registrar(
            p.id,
            __assign({}, {name = p.nome}, p.spec),
            if p.tipo == "personagem" then "personagem (2D)" else "morador"
        )
    end
    local conhecidos = __TS__New(Set)
    do
        local function ____catch(e)
            conhecidos = __TS__New(Set)
        end
        local ____try, ____hasReturned = pcall(function()
            local ____Set_13 = Set
            local ____self_11 = window.JSON
            local ____self_11_parse_12 = ____self_11.parse
            local ____t_10 = __t
            local ____temp_9 = window.localStorage:getItem(KEY)
            __O[447] = ____temp_9
            conhecidos = __TS__New(
                ____Set_13,
                ____self_11_parse_12(____self_11, if ____t_10(____temp_9) then __O[447] else "[]")
            )
        end)
        if not ____try then
            ____catch(____hasReturned)
        end
    end
    local function salvar()
        do
            pcall(function()
                window.localStorage:setItem(
                    KEY,
                    window.JSON:stringify(__arr(__TS__Spread(__iter(conhecidos))))
                )
            end)
        end
    end
    local function daCena(____, cena)
        return __call(
            TODOS,
            "filter",
            function(____, p) return p.cena == cena end
        )
    end
    local function desenhar(self, c, o)
        local L = daCena(
            nil,
            __TS__Number(o.scene)
        )
        if not __t(__len(L)) then
            return
        end
        local ____t_15 = __t
        local ____TS__Number_result_14 = __TS__Number(o.time)
        __O[448] = ____TS__Number_result_14
        local t = if ____t_15(____TS__Number_result_14) then __O[448] else 0
        local ____t_19 = __t
        local ____opt_16 = o.player
        if ____opt_16 ~= nil then
            ____opt_16 = ____opt_16.x
        end
        local ____TS__Number_result_18 = __TS__Number(____opt_16)
        __O[449] = ____TS__Number_result_18
        local hx = if ____t_19(____TS__Number_result_18) then __O[449] else -9999
        local ____t_21 = __t
        local ____TS__Number_result_20 = __TS__Number(o.camera)
        __O[450] = ____TS__Number_result_20
        local cam = if ____t_21(____TS__Number_result_20) then __O[450] else 0
        for ____, p in __iterar((L)) do
            if __t(p.x < cam - 80 or p.x > cam + 1040) then
                continue
            end
            local perto = math.abs(p.x - hx) < 160
            local facing = if __t(perto) then if hx > p.x then 1 else -1 else if __t(p.facing) then p.facing else if __t(__mod(p.x, 2)) then 1 else -1
            window.Art:drawCharacter(
                c,
                p.id,
                p.x,
                FLOOR,
                {
                    frame = t + p.x * 0.01,
                    facing = facing,
                    moving = false,
                    grounded = true,
                    vy = 0,
                    cache = true
                }
            )
            local novo = not __t(__call(conhecidos, "has", p.id))
            local y = FLOOR - 112 + math.floor(math.sin(t * 3 + p.x) * 2 + 0.5)
            if __t(if __t(novo) then novo else perto) then
                local col = if __t(novo) then if p.tipo == "personagem" then "#ffd24a" else "#8ae0ff" else "#f3d89e"
                local bx = math.floor(p.x + 0.5) - 10
                local by = y - 12
                c.fillStyle = "#2a1a14"
                c:fillRect(bx - 2, by - 2, 24, 22)
                c:fillRect(bx + 8, by + 20, 6, 4)
                c.fillStyle = col
                c:fillRect(bx, by, 20, 18)
                c:fillRect(bx + 10, by + 18, 2, 2)
                c.fillStyle = "#2a1a14"
                if __t(novo) then
                    c:fillRect(bx + 8, by + 3, 4, 8)
                    c:fillRect(bx + 8, by + 13, 4, 3)
                else
                    do
                        local k = 0
                        while k < 3 do
                            c:fillRect(bx + 3 + k * 6, by + 8, 3, 3)
                            k = k + 1
                        end
                    end
                end
            end
        end
    end
    local function perto(self, cena, x)
        local best = nil
        local d = 70
        for ____, p in __iterar((daCena(
            nil,
            __TS__Number(cena)
        ))) do
            local dd = math.abs(p.x - x)
            if dd < d then
                d = dd
                best = p
            end
        end
        return best
    end
    box = nil
    cur = nil
    fila = __arrL({}, 0)
    texto = ""
    shown = 0
    typing = nil
    onClose = nil
    modo = "menu"
    lidos = __TS__New(Set)
    local function css(self)
        if __t(window.document:getElementById("c2MoradoresCss")) then
            return
        end
        local st = window.document:createElement("style")
        st.id = "c2MoradoresCss"
        st.textContent = ".c2m-box{position:fixed;left:50%;bottom:max(14px,env(safe-area-inset-bottom));transform:translateX(-50%);width:min(920px,calc(100vw - 20px));z-index:2147483000;display:flex;gap:14px;align-items:stretch;background:#2a1e14;border:4px solid #e8c66a;box-shadow:0 0 0 4px #2a1e14,0 10px 30px rgba(0,0,0,.6);padding:12px;font-family:Pixel,monospace;color:#f6ead0;image-rendering:pixelated}\n.c2m-box[hidden]{display:none}.c2m-ret{flex:0 0 auto;width:120px;height:120px;background:linear-gradient(#5a7a8a,#2c3a44);border:3px solid #120c08;image-rendering:pixelated}\n.c2m-main{flex:1;display:flex;flex-direction:column;gap:8px;min-width:0}.c2m-nome{font-size:15px;color:#ffd98a;letter-spacing:1px}.c2m-papel{font-size:10px;color:#c8b48a;margin-left:8px}\n.c2m-txt{font-size:13px;line-height:1.55;min-height:62px;white-space:pre-wrap}.c2m-ops{display:flex;flex-wrap:wrap;gap:6px}.c2m-ops button{font:inherit;font-size:11px;padding:7px 10px;background:#4a3420;color:#f6ead0;border:2px solid #e8c66a;cursor:pointer}\n.c2m-ops button:hover,.c2m-ops button:focus{background:#e8c66a;color:#2a1e14;outline:none}.c2m-ops button.lido{opacity:.65}.c2m-dica{font-size:9px;color:#a8946a;display:flex;justify-content:space-between}\n@media (max-width:600px){.c2m-ret{width:72px;height:72px}.c2m-txt{font-size:11px}.c2m-ops button{font-size:10px;padding:6px 8px}}"
        window.document.head:appendChild(st)
    end
    local function montar(self)
        css(nil)
        box = window.document:createElement("div")
        box.className = "c2m-box"
        box.hidden = true
        box:setAttribute("role", "dialog")
        box.innerHTML = "<canvas class=\"c2m-ret\" width=\"60\" height=\"60\"></canvas><div class=\"c2m-main\"><div><span class=\"c2m-nome\"></span><span class=\"c2m-papel\"></span></div><div class=\"c2m-txt\" aria-live=\"polite\"></div><div class=\"c2m-ops\"></div><div class=\"c2m-dica\"><span class=\"c2m-pass\">E / ENTER: continuar · ESC: sair</span><span class=\"c2m-cad\"></span></div></div>"
        window.document.body:appendChild(box)
        box:addEventListener(
            "click",
            function(____, e)
                if __t(e.target:closest("button")) then
                    return
                end
                avancar(nil)
            end
        )
    end
    local function retrato(self)
        local cv = box:querySelector(".c2m-ret")
        local c = cv:getContext("2d")
        c.imageSmoothingEnabled = false
        c:clearRect(0, 0, 60, 60)
        c:save()
        c:translate(30, 68)
        window.Art:drawCharacter(
            c,
            cur.id,
            0,
            0,
            {
                frame = window.performance:now() / 1000,
                facing = 1,
                moving = false,
                grounded = true
            }
        )
        c:restore()
    end
    local function conversar(self, id, opts)
        if opts == nil then
            opts = {}
        end
        local p = __call(
            TODOS,
            "find",
            function(____, q) return q.id == id end
        )
        if not __t(p) then
            return false
        end
        if not __t(box) then
            montar(nil)
        end
        cur = p
        lidos = __TS__New(Set)
        onClose = if __t(opts.onClose) then opts.onClose else nil
        fila = __arrL({}, 0)
        local novo = not __t(__call(conhecidos, "has", id))
        __call(conhecidos, "add", id)
        salvar(nil)
        box:querySelector(".c2m-nome").textContent = __call(p.nome, "toUpperCase")
        box:querySelector(".c2m-papel").textContent = p.papel
        box:querySelector(".c2m-cad").textContent = (((("CADERNINHO: " .. tostring(conhecidos.size)) .. "/") .. tostring(__len(TODOS))) .. " conhecidos") .. if __t(novo) then " · NOVO!" else ""
        box:querySelector(".c2m-ops").innerHTML = ""
        box.hidden = false
        retrato(nil)
        modo = "oi"
        digitar(nil, p.oi)
        window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {owner = "moradores", active = true}}))
        return true
    end
    window:addEventListener(
        "keydown",
        function(____, e)
            local ____t_29 = __t
            local ____t_28 = __t
            local ____temp_27 = not __t(box)
            __O[452] = ____temp_27
            if ____t_29(if ____t_28(____temp_27) then __O[452] else box.hidden) then
                return
            end
            local k = e.key
            if k == "Escape" then
                fechar(nil)
            elseif __t(modo == "menu" and __re_test(
                __re("^[1-9]$", ""),
                k
            )) then
                local i = __TS__Number(k) - 1
                if __lt(
                    i,
                    __len(cur.temas)
                ) then
                    tema(nil, i)
                elseif i == __len(cur.temas) then
                    fechar(nil)
                end
            else
                local ____t_32 = __t
                local ____t_31 = __t
                local ____temp_30 = k == "Enter" or k == " "
                __O[453] = ____temp_30
                if ____t_32(if ____t_31(____temp_30) then __O[453] else __call(k, "toLowerCase") == "e") then
                    if modo == "menu" then
                        local i = __call(
                            cur.temas,
                            "findIndex",
                            function(____, _, j) return not __t(__call(lidos, "has", j)) end
                        )
                        if __ge(i, 0) then
                            tema(nil, i)
                        else
                            fechar(nil)
                        end
                    else
                        avancar(nil)
                    end
                end
            end
            e:preventDefault()
            e:stopImmediatePropagation()
        end,
        true
    )
    window.CampanhaMoradores = __ord(
        {
            desenhar = desenhar,
            perto = perto,
            conversar = conversar,
            fechar = fechar,
            aberto = function() return not not __t(box) and not __t(box.hidden) end,
            lista = function() return __call(
                TODOS,
                "map",
                function(____, ____bindingPattern0)
                    local tipo
                    local x
                    local cena
                    local papel
                    local nome
                    local id
                    id = ____bindingPattern0.id
                    nome = ____bindingPattern0.nome
                    papel = ____bindingPattern0.papel
                    cena = ____bindingPattern0.cena
                    x = ____bindingPattern0.x
                    tipo = ____bindingPattern0.tipo
                    return {
                        id = id,
                        nome = nome,
                        papel = papel,
                        cena = cena,
                        x = x,
                        tipo = tipo
                    }
                end
            ) end,
            conhecidos = function() return __arr(__TS__Spread(__iter(conhecidos))) end,
            esquecer = function()
                conhecidos = __TS__New(Set)
                salvar(nil)
            end
        },
        "desenhar,perto,conversar,fechar,aberto,lista,conhecidos,esquecer"
    )
end)(nil)
return ____exports
