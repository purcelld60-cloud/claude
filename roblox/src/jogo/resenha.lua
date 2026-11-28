--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __isFiniteN, __mod, __ord, __arrL, __t, __get, __len, __call, __values, __isArray = __JSR.__isFiniteN, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__t, __JSR.__get, __JSR.__len, __JSR.__call, __JSR.__values, __JSR.__isArray
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local ____exports = {};
(function()
    local ____ = "use strict"
    local names = __ord({
        eloisa = "Eloisa",
        giselle = "Giselle",
        rayssa = "Rayssa",
        analaura = "Ana Laura",
        aica = "Aica",
        ravile = "Ravile",
        allef = "Allef",
        dede = "Dedé",
        freddy = "Freddy"
    }, "eloisa,giselle,rayssa,analaura,aica,ravile,allef,dede,freddy")
    local signatureLines = __ord({girls = "aff veyr juro", dede = "SEU GILÓ HOMI", freddy = "OPEESTY DA ROÇA"}, "girls,dede,freddy")
    local bank = __ord(
        {
            eloisa = __arrL(
                {
                    __arrL({"aff veyr juro, você entrou de chapéu até na sala? O sol tá do lado de fora, menino.", "Se toca: aqui a única cobertura disputada é a do bolo."}, 2),
                    __arrL({"aff veyr juro, essa pose é pra farmar aura ou pra espantar pombo?", "O Nicolas tentou isso. A fonte ganhou mais destaque que ele."}, 2),
                    __arrL({"aff veyr juro, eu pedi uma foto e você fez propaganda de botijão.", "Fica quietinho dois segundos. O gás também pode sair de férias."}, 2),
                    __arrL({"aff veyr juro, esse drama pelo bolo virou uma série de quarenta temporadas.", "Pode recuperar a sobremesa; a trilha de terra no tapete você limpa depois."}, 2),
                    __arrL({"aff veyr juro, você se passou! Nem meu batom rosa chama mais atenção que esse chapéu.", "Mas tá bonito o esforço. Nota oito pro look, zero pro cheiro da entrada."}, 2),
                    __arrL({"aff veyr juro, chegou o protagonista rural. Cadê o discurso olhando pro horizonte?", "Pode respirar, menino. A gente só perguntou se você quer suco."}, 2)
                },
                6
            ),
            giselle = __arrL(
                {
                    __arrL({"aff veyr juro, da porta eu já ouvi o motor. Ou era você?", "Essa chegada teve mais efeito sonoro que a luta da praça."}, 2),
                    __arrL({"aff veyr juro, esse chapéu pega Wi-Fi? Tô precisando mandar um áudio.", "Se cair a conexão, não resolve soprando gás no roteador."}, 2),
                    __arrL({"aff veyr juro, o Nicolas disse que partiu o céu. O céu nem visualizou.", "Deixa ele cozinhar... mas alguém tira o fogão da fanfic."}, 2),
                    __arrL({"aff veyr juro, você tá farmando aura ou farmando milho dentro de casa?", "A Rayssa acabou de varrer, menino. Se toca."}, 2),
                    __arrL({"aff veyr juro, seu ataque é uma bolinha de papel? Eu devia ter guardado as provas.", "Esse colégio fabrica armamento com recuperação de matemática."}, 2),
                    __arrL({"aff veyr juro, eu fiquei gag quando você chamou o carro de transporte discreto.", "Discreto igual a um trio elétrico atravessando a cozinha."}, 2)
                },
                6
            ),
            rayssa = __arrL(
                {
                    __arrL({"aff veyr juro, pode entrar, mas tira o barro do tênis. A casa não é fase de parkour.", "E o carro a gás estaciona fora. A varanda não tem pista de pouso."}, 2),
                    __arrL({"aff veyr juro, você pulou meu sofá pra pegar experiência?", "Aqui o único chefão é quem vai lavar a louça depois do lanche."}, 2),
                    __arrL({"aff veyr juro, eu disse pra trazer uma história. Você trouxe a trilogia do bolo.", "Senta, menino. Pelo menos essa resenha veio com sobremesa."}, 2),
                    __arrL({"aff veyr juro, se toca: o ventilador tá ligado, não precisa ajudar com peido.", "Ele tem três velocidades. A sua quarta tá proibida na sala."}, 2),
                    __arrL({"aff veyr juro, sua missão agora é simples: não derrubar nada.", "Pelo jeito que olhou pra mesa, já vai pedir tutorial."}, 2),
                    __arrL({"aff veyr juro, vocês se passaram. Bolo, aura suprema e um rei gritando o próprio nome?", "Meu grupo da sala perdeu pra essa fofoca por goleada."}, 2)
                },
                6
            ),
            analaura = __arrL(
                {
                    __arrL({"aff veyr juro, você trouxe bolo ou só o resumo da aventura?", "Porque pra história eu tenho paciência. Pra colher vazia, nem tanto."}, 2),
                    __arrL({"aff veyr juro, o açaí é de quarta e você tá ansioso desde segunda?", "Calma, menino. Até a banana tem tempo de amadurecer."}, 2),
                    __arrL({"aff veyr juro, essa corrida toda e você ainda chega perguntando do lanche.", "Tem água ali. Não desbloqueia poder nenhum, mas hidrata."}, 2),
                    __arrL({"aff veyr juro, se você contar de novo que voa com gás, eu cobro passagem.", "A casa da Rayssa não virou aeroporto, não."}, 2),
                    __arrL({"aff veyr juro, o Nicolas falou que venceu um deus. Foi o deus da lixeira?", "Eu vi a praça inteira. Só ele ouviu aquela música de batalha."}, 2),
                    __arrL({"aff veyr juro, você se passou pulando o portão. Tava aberto, criatura.", "Depois diz que a missão é difícil. O inimigo era a maçaneta."}, 2)
                },
                6
            ),
            aica = __ord(
                {
                    before = __arrL(
                        {
                            __arrL({"aff veyr juro, Arthur se passou! Puxou o cabelo da Ravile e ela caiu.", "Bestaiado demais. Da Roça, ajuda a gente a fazer ele parar."}, 2),
                            __arrL({"aff veyr juro, olha a cena que esse idiota arrumou. A Ravile tá com dor.", "Arthur tá lá na frente. Vai cobrar uma explicação desse bestaiado."}, 2),
                            __arrL({"aff veyr juro, menino sem noção! Cabelo dos outros não é alavanca.", "Fica com a gente um instante e depois encontra Arthur no fim do pátio."}, 2),
                            __arrL({"aff veyr juro, ele chamou isso de brincadeira. Arthur, você se passou foi muito.", "Da Roça, resolve esse desafio. Eu fico aqui ajudando a Ravile."}, 2)
                        },
                        4
                    ),
                    active = __arrL(
                        {
                            __arrL({"aff veyr juro, o bestaiado tá lá no fim do pátio dando showzinho.", "Encontra Arthur e aperta DESAFIAR. Eu cuido da Ravile."}, 2),
                            __arrL({"aff veyr juro, Arthur treina tapa como se isso apagasse o vacilo.", "Desvia das mãos e faz esse idiota aprender a pedir desculpa."}, 2),
                            __arrL({"aff veyr juro, se passou e ainda quer plateia. A coragem veio com defeito.", "Vai lá, Da Roça. A Ravile tá esperando essa conversa acabar."}, 2),
                            __arrL({"aff veyr juro, ele tá ensaiando pose. Podia ensaiar um pedido de desculpa.", "Arthur fica depois das plataformas. Cuidado com as rajadas de tapa."}, 2)
                        },
                        4
                    ),
                    after = __arrL(
                        {
                            __arrL({"aff veyr juro, OPEEEESTIIIIIIIII! A orelha do bestaiado ouviu direitinho.", "Agora ele só pode puxar conversa. E olha lá."}, 2),
                            __arrL({"aff veyr juro, Arthur se passou e voltou puxado pela própria orelha.", "A Ravile tá bem. O pedido de desculpa finalmente saiu."}, 2),
                            __arrL({"aff veyr juro, aquele idiota ganhou uma aula sem quadro nem giz.", "Foi respeito aplicado. A professora foi a Ravile."}, 2),
                            __arrL({"aff veyr juro, o show de tapas acabou. Já posso voltar a falar da minha vida?", "Obrigada, Da Roça. Seu chapéu hoje prestou serviço público."}, 2)
                        },
                        4
                    )
                },
                "before,active,after"
            ),
            ravile = __ord(
                {
                    before = __arrL(
                        {
                            __arrL({"aff veyr juro... Arthur puxou meu cabelo. Aí eu caí e fiquei com essa dor.", "Esse bestaiado se passou. A Aica tá me ajudando; fala com ele por mim."}, 2),
                            __arrL({"aff veyr juro, o idiota achou que meu cabelo era corda de sino.", "Da Roça, eu tô tentando levantar. Encontra Arthur lá na frente."}, 2),
                            __arrL({"aff veyr juro, cabelo puxado não tem graça. Arthur se passou demais.", "Aica fica comigo. Você pode fazer ele parar com essa história de tapa?"}, 2),
                            __arrL({"aff veyr juro... tô com dor ainda. Esse bestaiado estragou o intervalo.", "Preciso de ajuda. Arthur foi pro fim do pátio bancar o valentão."}, 2)
                        },
                        4
                    ),
                    active = __arrL(
                        {
                            __arrL({"aff veyr juro, o bestaiado ainda tá fazendo pose? Ele se passou e nem percebeu.", "Enfrenta Arthur. Quero ouvir esse pedido de desculpa de perto."}, 2),
                            __arrL({"aff veyr juro, tô melhorando. O idiota é que tá devendo uma explicação.", "Vai com cuidado, Da Roça. Ele ataca de longe também."}, 2),
                            __arrL({"aff veyr juro, esse menino tá muito delulu se acha que foi engraçado.", "Arthur fica lá na frente. Resolve a luta que eu resolvo a conversa."}, 2),
                            __arrL({"aff veyr juro, a Aica já contou a história três vezes e eu ainda tô indignada.", "Quando o desafio acabar, manda o bestaiado vir falar comigo."}, 2)
                        },
                        4
                    ),
                    after = __arrL(
                        {
                            __arrL({"aff veyr juro, a orelha dele escutou o que a cabeça não queria entender.", "Bestaiado. Se passou comigo e agora vai aprender a respeitar."}, 2),
                            __arrL({"aff veyr juro, tô bem agora. Arthur pediu desculpa sem efeito especial.", "Milagre: o idiota descobriu que dá pra conversar sem puxar cabelo."}, 2),
                            __arrL({"aff veyr juro, ele falou que a orelha ficou quente. Imagina meu cabelo, né?", "Acabou a confusão. Agora só quero um intervalo normal."}, 2),
                            __arrL({"aff veyr juro, aquele bestaiado quase transformou o recreio numa novela.", "Obrigada, Da Roça. A próxima missão é ninguém encostar no meu cabelo."}, 2)
                        },
                        4
                    )
                },
                "before,active,after"
            ),
            allef = __arrL(
                {
                    __arrL({"Ó o Da Roça! Seu chapéu chegou primeiro e já pegou a senha da recepção.", "Quer corte, acabamento ou calibrar esse tanque de gás?"}, 2),
                    __arrL({"Costa! Chegou um cliente com cobertura de palha e escapamento esportivo!", "Senta aí, Da Roça. Só não transforma a cadeira em foguete."}, 2),
                    __arrL({"Teu chapéu tem mais área que a barbearia. Vai pagar IPTU ou só o pezinho?", "Tô zoando, homi! Mas o pé sujo fica longe do balcão."}, 2),
                    __arrL({"A senha de hoje é 02. Você é o 01 e seu cheiro já é o 03.", "A fila anda. O ventilador também, graças a Deus."}, 2),
                    __arrL({"Da Roça, esse chapéu pega Wi-Fi? O sistema da recepção travou.", "Se pegar, a senha é SEMPEIDONASALA. Tudo junto."}, 2),
                    __arrL({"O Costa tá na tesoura, o Vitor no pente e você no combustível.", "A equipe tá completa. Agora falta só você parar quieto!"}, 2)
                },
                6
            ),
            dede = __arrL(
                {
                    __arrL({"SEU GILÓ HOMI! Achei que você ia se perder dentro da minha fumaça.", "Chegou farejando bolo até no beco. Que nariz treinado, Da Roça!"}, 2),
                    __arrL({"SEU GILÓ HOMI! Minha névoa é técnica. A sua vem com barulho de motor.", "O Reeis podia contratar nós dois pra esconder o morro."}, 2),
                    __arrL({"SEU GILÓ HOMI! Não olha meu aparelho como se fosse arma do Kaua.", "É pra alinhar o sorriso, não pra lançar clipe em ninguém."}, 2),
                    __arrL({"SEU GILÓ HOMI! Falaram que seu carro voa. Ele estaciona ou cria raiz?", "Vai lá, chapéu. Só não espalha que a minha fumaça tomou papelada."}, 2)
                },
                4
            ),
            freddy = __arrL(
                {
                    __arrL({"OPEESTY DA ROÇA! Ô REEEIS! O chapéu voltou pra revisão da resenha!", "Eu sou o capanga mais forte. Na zoeira com o chefe eu sou o titular."}, 2),
                    __arrL({"OPEESTY DA ROÇA! Quem me derrotou foi você ou um caderno arremessado?", "REEEIS! Anota a estratégia: o papel dele veio rebocado."}, 2),
                    __arrL({"OPEESTY DA ROÇA! Esse carro faz mais barulho que o Reeis pedindo respeito.", "O chefe ouviu? Melhor. Já economizei o grito."}, 2),
                    __arrL({"OPEESTY DA ROÇA! Ô REEEIS, a fama do chapéu tá subindo mais que a gente!", "Se o bolo der entrevista, eu quero aparecer atrás fazendo pose."}, 2)
                },
                4
            )
        },
        "eloisa,giselle,rayssa,analaura,aica,ravile,allef,dede,freddy"
    )
    local references = __arrL(
        {
            __ord({title = "O Imparcial — gírias e cultura digital", date = "2026-06-08", url = "https://oimparcial.com.br/noticias/2026/06/farmar-aura-ficou-gag-tankar-entenda-as-principais-girias-usadas-pelas-novas-geracoes/"}, "title,date,url"),
            __ord({title = "UOL Tilt — glossário de gírias da internet", date = "2025-06-01", url = "https://www.uol.com.br/tilt/noticias/redacao/2025/06/01/glossario-de-girias-da-internet.htm"}, "title,date,url"),
            __ord({title = "StudioBinder — extreme close-up", date = nil, url = "https://www.studiobinder.com/camera-shots/shot-size/extreme-close-up-shot/"}, "title,date,url"),
            __ord({title = "Crunchyroll — BLUELOCK e enquadramentos de emoção", date = "2022-10-15", url = "https://www.crunchyroll.com/news/features/2022/10/15/impressions-bluelock-episode-1-puts-the-i-in-team-and-i-love-it"}, "title,date,url"),
            __ord({title = "Crunchyroll — Mecha-Ude e mistura de 2D/3D", date = "2024-11-17", url = "https://www.crunchyroll.com/news/features/2024/11/17/mecha-ude-mechanical-arms-original-anime-worth-watching"}, "title,date,url")
        },
        5
    )
    local function talk(self, id, visit, q)
        if visit == nil then
            visit = 0
        end
        if q == nil then
            q = {}
        end
        local pools = __get(bank, id)
        if not __t(pools) then
            return nil
        end
        if not __isArray(pools) then
            pools = __get(
                pools,
                __t(q.arthur) and "after" or (__t(q.patioAccepted) and "active" or "before")
            )
        end
        local number = __TS__Number(visit)
        local ____mod_1 = __mod
        local ____isFiniteN_result_0
        if __isFiniteN(number) then
            ____isFiniteN_result_0 = math.max(
                0,
                math.floor(number)
            )
        else
            ____isFiniteN_result_0 = 0
        end
        local index = ____mod_1(
            ____isFiniteN_result_0,
            __len(pools)
        )
        return __call(
            __get(pools, index),
            "map",
            function(____, text) return {
                name = __get(names, id),
                text = text
            } end
        )
    end
    local function freeze(self, value)
        local ____t_3 = __t
        local ____t_result_2
        if __t(value) then
            ____t_result_2 = type(value) == "table"
        else
            ____t_result_2 = value
        end
        if ____t_3(____t_result_2) then
            __call(
                __values(value),
                "forEach",
                freeze
            )
            local ____ = value
        end
        return value
    end
    window.Resenha = freeze(
        nil,
        __ord({talk = talk, bank = bank, signatureLines = signatureLines, references = references}, "talk,bank,signatureLines,references")
    )
end)(nil)
return ____exports
