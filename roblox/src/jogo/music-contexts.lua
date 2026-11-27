--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __ord, __arrL, __iterar, __t, __get, __arr, __call, __add, __iter, __assign, __re, __re_test = __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__arr, __JSR.__call, __JSR.__add, __JSR.__iter, __JSR.__assign, __JSR.__re, __JSR.__re_test
local __re_replace = __JSR.__re_replace
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__Spread = ____lualib.__TS__Spread
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local Map = ____lualib.Map
local __TS__New = ____lualib.__TS__New
local Set = ____lualib.Set
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local contexts = __arrL({}, 0)
    local function add(____, id, label, group)
        return __call(contexts, "push", {id = id, label = label, group = group})
    end
    add(nil, "characters.amanda", "Conversa · Amanda", "Personagens")
    add(nil, "activity.dinner", "Jantar com Amanda", "Desafios")
    add(nil, "characters.swift", "Conversa · Irmão de Clara Swift", "Personagens")
    add(nil, "minigames.fliperama", "Fliperama da Roça", "Minigames")
    for ____, ____value in __iterar((__arrL(
        {
            __arrL({"minhoca", "Minhoca do Cafezal"}, 2),
            __arrL({"pong", "Pingue-Pongue do Pátio"}, 2),
            __arrL({"quebra", "Quebra-Caderno"}, 2),
            __arrL({"cabo", "Cabo de Guerra"}, 2),
            __arrL({"chinelo", "Chuva de Chinelo"}, 2),
            __arrL({"galo", "Reflexo do Galo"}, 2),
            __arrL({"memoria", "Memória da Feira"}, 2),
            __arrL({"tiro", "Tiro ao Alvo no Açude"}, 2),
            __arrL({"corrida", "Corrida da Estradinha"}, 2),
            __arrL({"subida", "Subida do Morro"}, 2)
        },
        10
    ))) do
        local id = ____value[1]
        local name = ____value[2]
        add(
            nil,
            __add("minigames.fliperama.", id),
            __add("Fliperama · ", name),
            "Minigames"
        )
    end
    add(nil, "arena.menu", "Arena online · seleção e sala", "Arena online")
    add(nil, "arena.battle", "Arena online · confronto", "Arena online")
    add(nil, "arena.results", "Arena online · resultado", "Arena online")
    for ____, ____value in __iterar((__arrL(
        {
            __arrL({"pump", "Bombeamento · pomar e campo"}, 2),
            __arrL({"memory", "Memória · luzes da praça e do baile"}, 2),
            __arrL({"sort", "Reciclagem · escola e pátio"}, 2)
        },
        3
    ))) do
        local id = ____value[1]
        local label = ____value[2]
        add(
            nil,
            __add("activities.", id),
            label,
            "Minigames"
        )
    end
    local maps = __arrL(
        {
            __arrL({"roca", "A roça"}, 2),
            __arrL({"escola", "Colégio Adventista"}, 2),
            __arrL({"academia", "Academia do Caleb"}, 2),
            __arrL({"quadra", "Quadra da escola"}, 2),
            __arrL({"camacan", "Praça Camacan"}, 2),
            __arrL({"favela", "Favela do Reeis"}, 2),
            __arrL({"caderno", "Caderno do Caos"}, 2),
            __arrL({"campo", "Campo do Mota"}, 2),
            __arrL({"bigodon", "Bigodon"}, 2),
            __arrL({"patio", "Pátio da escola"}, 2),
            __arrL({"rayssa", "Casa de Rayssa"}, 2),
            __arrL({"baile", "Baile funk · noite da resenha"}, 2)
        },
        12
    )
    for ____, ____value in __iterar((maps)) do
        local id = ____value[1]
        local name = ____value[2]
        add(
            nil,
            __add("maps.", id),
            name,
            "Cenários"
        )
    end
    add(nil, "rooms.almiro", "Sala do professor Almiro", "Salas")
    add(nil, "rooms.miqueias", "Sala do professor Miqueias", "Salas")
    local characters = __arrL(
        {
            __arrL({"daroca", "Da Roça"}, 2),
            __arrL({"reeis", "Gabriel Reeis"}, 2),
            __arrL({"nikolas", "Nikolas Arroganti"}, 2),
            __arrL({"lucas", "Lucas, o Sapo"}, 2),
            __arrL({"menezes", "Menezes, o Rato"}, 2),
            __arrL({"caleb", "Caleb"}, 2),
            __arrL({"kaua", "Kaua"}, 2),
            __arrL({"marco", "Marco"}, 2),
            __arrL({"ravid", "Ravid"}, 2),
            __arrL({"mota", "Gabriel Mota"}, 2),
            __arrL({"giant", "Colosso Six Seven"}, 2),
            __arrL({"almiro", "Professor Almiro"}, 2),
            __arrL({"miqueias", "Professor Miqueias"}, 2),
            __arrL({"davi", "Davi Costa"}, 2),
            __arrL({"vitor", "Vitor"}, 2),
            __arrL({"freddy", "Freddy"}, 2),
            __arrL({"nicolas", "Nicolas Carvalho"}, 2),
            __arrL({"dede", "Dedé"}, 2),
            __arrL({"aica", "Aica"}, 2),
            __arrL({"ravile", "Ravile"}, 2),
            __arrL({"arthur", "Arthur"}, 2),
            __arrL({"allef", "Allef"}, 2),
            __arrL({"eloisa", "Eloisa"}, 2),
            __arrL({"giselle", "Giselle"}, 2),
            __arrL({"rayssa", "Rayssa"}, 2),
            __arrL({"analaura", "Ana Laura"}, 2),
            __arrL({"ollyan", "Ollyan · Orelhas ao Vento"}, 2)
        },
        27
    )
    for ____, ____value in __iterar((characters)) do
        local id = ____value[1]
        local name = ____value[2]
        add(
            nil,
            __add("characters.", id),
            __add("Conversa · ", name),
            "Personagens"
        )
    end
    for ____, ____value in __iterar((__arrL(
        {
            __arrL({"igor", "Igor"}, 2),
            __arrL({"kaique", "Kaique"}, 2)
        },
        2
    ))) do
        local id = ____value[1]
        local name = ____value[2]
        add(
            nil,
            __add("characters.", id),
            __add("Conversa · ", name),
            "Personagens"
        )
        add(
            nil,
            __add("battles.", id),
            __add("Batalha · ", name),
            "Batalhas"
        )
        add(
            nil,
            __add("events.boss_", id),
            __add("Apresentação · ", name),
            "Cenas e eventos"
        )
    end
    local bosses = __arrL(
        {
            __arrL({"marco", "Marco"}, 2),
            __arrL({"giant", "Colosso Six Seven"}, 2),
            __arrL({"menezes", "Menezes"}, 2),
            __arrL({"nikolas", "Nikolas Arroganti"}, 2),
            __arrL({"reeisBoss", "Reeis"}, 2),
            __arrL({"freddy", "Freddy"}, 2),
            __arrL({"nicolas", "Nicolas Carvalho"}, 2),
            __arrL({"dede", "Dedé"}, 2),
            __arrL({"arthur", "Arthur"}, 2),
            __arrL({"ollyan", "Ollyan · Orelhas ao Vento"}, 2)
        },
        10
    )
    for ____, ____value in __iterar((bosses)) do
        local id = ____value[1]
        local name = ____value[2]
        add(
            nil,
            __add("battles.", id),
            __add("Batalha · ", name),
            "Batalhas"
        )
        if id ~= "ollyan" then
            add(
                nil,
                __add("events.boss_", if id == "reeisBoss" then "reeis" else id),
                __add("Apresentação · ", name),
                "Cenas e eventos"
            )
        end
    end
    for ____, ____value in __iterar((__arrL(
        {
            __arrL({"intro", "A amizade e o bolo"}, 2),
            __arrL({"celebration", "Comemoração e açaí"}, 2),
            __arrL({"jorge_epilogue", "Epílogo · a ligação de Jorge"}, 2),
            __arrL({"reeis_transform", "Transformação do Reeis"}, 2),
            __arrL({"defeat", "Derrota"}, 2),
            __arrL({"chapter_end", "Fim do capítulo"}, 2)
        },
        6
    ))) do
        local id = ____value[1]
        local name = ____value[2]
        add(
            nil,
            __add("events.", id),
            name,
            "Cenas e eventos"
        )
    end
    local phaseNames = __ord(
        {
            nikolas = __arrL({"O duelo original", "Força bruta", "Aura do céu", "Gigante do catarro"}, 4),
            ollyan = __arrL({"Orelhas ao vento", "Plataformas nas nuvens", "Corrente de ar"}, 3)
        },
        "nikolas,ollyan"
    )
    local ____arr_6 = __arr
    local ____iter_5 = __iter
    local ____call_4 = __call
    local ____Map_3 = Map
    local ____call_2 = __call
    local ____arr_1 = __arr
    local ____array_0 = __TS__SparseArrayNew(
        __arrL({"igor", "Igor"}, 2),
        __arrL({"kaique", "Kaique"}, 2),
        __TS__Spread(__iter(__call(
            bosses,
            "filter",
            function(____, b) return __get(b, 0) ~= "giant" end
        )))
    )
    __TS__SparseArrayPush(
        ____array_0,
        __arrL({"ollyan", "Ollyan"}, 2)
    )
    local phaseBosses = ____arr_6(__TS__Spread(____iter_5(____call_4(
        __TS__New(
            ____Map_3,
            ____call_2(
                ____arr_1(__TS__SparseArraySpread(____array_0)),
                "map",
                function(____, b) return __arrL(
                    {
                        __get(b, 0),
                        b
                    },
                    2
                ) end
            )
        ),
        "values"
    ))))
    for ____, ____value in __iterar((phaseBosses)) do
        local id = ____value[1]
        local name = ____value[2]
        do
            local phase = 1
            while phase <= if id == "nikolas" then 4 else 3 do
                add(
                    nil,
                    __add(
                        __add(
                            __add("battles.", id),
                            ".phase"
                        ),
                        phase
                    ),
                    __add(
                        __add(
                            __add(
                                __add("Batalha · ", name),
                                " · Fase "
                            ),
                            phase
                        ),
                        if __t(__get(phaseNames, id)) then __add(
                            " · ",
                            __get(
                                __get(phaseNames, id),
                                phase - 1
                            )
                        ) else ""
                    ),
                    "Batalhas"
                )
                phase = phase + 1
            end
        end
    end
    add(nil, "menu.title", "Menu inicial", "Menus")
    add(nil, "menu.pause", "Menu de pausa", "Menus")
    add(nil, "activity.caleb", "Treino com Caleb", "Desafios")
    add(nil, "activity.mota", "Futebol com Mota", "Desafios")
    add(nil, "activity.english", "English do Miqueias", "Desafios")
    add(nil, "party.menu", "Festa 3D · recepção e sala Wi-Fi", "Festa 3D")
    add(nil, "party.board", "Festa 3D · tabuleiro", "Festa 3D")
    for ____, ____value in __iterar((__arrL(
        {
            __arrL({"collapse", "Piso SARUÊ"}, 2),
            __arrL({"race", "Carro a Gás GP"}, 2),
            __arrL({"football", "Quadra Caótica"}, 2),
            __arrL({"spotlight", "Não Acorde o Nariz"}, 2),
            __arrL({"pages", "Biblioteca em Fuga"}, 2),
            __arrL({"waves", "Ondas da Resenha"}, 2),
            __arrL({"harvest", "Mutirão do Sapo"}, 2),
            __arrL({"sketch", "Um Saruê Contra Todos"}, 2),
            __arrL({"raft", "Remada da Resenha"}, 2)
        },
        9
    ))) do
        local id = ____value[1]
        local name = ____value[2]
        add(
            nil,
            __add("party.", id),
            __add("Festa 3D · ", name),
            "Festa 3D"
        )
    end
    add(nil, "party.results", "Festa 3D · resultado da arena", "Festa 3D")
    add(nil, "party.ceremony", "Festa 3D · pódio final", "Festa 3D")
    add(nil, "coop.menu", "Dupla · recepção e conexão", "Arena em dupla")
    for ____, id in __iterar((__arrL({"marco", "menezes", "nikolas"}, 3))) do
        add(
            nil,
            __add("coop.", id),
            __add(
                "Dupla · ",
                __get(
                    __call(
                        bosses,
                        "find",
                        function(____, b) return __get(b, 0) == id end
                    ),
                    1
                )
            ),
            "Arena em dupla"
        )
    end
    local cutscenes = __arrL(
        {
            __arrL({"easy_finish", "Final Fácil · chupeta e Gugu dada"}, 2),
            __arrL({"intro", "A amizade e o bolo"}, 2),
            __arrL({"outro", "O bolo recuperado · revanche de Da Roça"}, 2),
            __arrL({"boss_dede", "Apresentação · Dedé"}, 2),
            __arrL({"dede_defeat", "Dedé derrotado · a fumaça baixou"}, 2),
            __arrL({"boss_freddy", "Apresentação · Freddy"}, 2),
            __arrL({"freddy_defeat", "Freddy derrotado · caminho liberado"}, 2),
            __arrL({"boss_reeis", "Apresentação · Reeis"}, 2),
            __arrL({"reeis_recruit", "Recrutamento e transformação do Reeis"}, 2),
            __arrL({"boss_marco", "Apresentação · Marco"}, 2),
            __arrL({"marco_rage", "Marco · fúria do SARUÊ"}, 2),
            __arrL({"boss_giant", "Apresentação · Colosso Six Seven"}, 2),
            __arrL({"boss_menezes", "Apresentação · Menezes"}, 2),
            __arrL({"boss_arthur", "Apresentação · Arthur"}, 2),
            __arrL({"arthur_revenge", "Ravile e Aica · a orelha de Arthur"}, 2),
            __arrL({"boss_nicolas", "Apresentação · aura suprema de Nicolas"}, 2),
            __arrL({"nicolas_reveal", "Nicolas · a aura era imaginação"}, 2),
            __arrL({"boss_nikolas", "Apresentação · Nikolas"}, 2),
            __arrL({"celebration", "Comemoração · bolo e açaí de quarta"}, 2),
            __arrL({"jorge_epilogue", "Epílogo · a ligação de Jorge"}, 2),
            __arrL({"ollyan_flight", "Ollyan · orelhas ao vento e perseguição no céu"}, 2)
        },
        21
    )
    for ____, ____value in __iterar((cutscenes)) do
        local kind = ____value[1]
        local label = ____value[2]
        add(
            nil,
            __add("cutscenes.", kind),
            label,
            "Cutscenes"
        )
        if not __t(__call(
            contexts,
            "some",
            function(____, c) return c.id == __add("events.", kind) end
        )) then
            add(
                nil,
                __add("events.", kind),
                __add(label, " · associação antiga"),
                "Cenas e eventos"
            )
        end
    end
    local kinds = __TS__New(
        Set,
        __call(
            cutscenes,
            "map",
            function(____, ____bindingPattern0)
                local kind
                kind = ____bindingPattern0[1]
                return kind
            end
        )
    )
    window.MusicCutscenes = __call(
        cutscenes,
        "map",
        function(____, ____bindingPattern0)
            local label
            local id
            id = ____bindingPattern0[1]
            label = ____bindingPattern0[2]
            return {id = id, label = label}
        end
    )
    window.MusicContexts = __call(
        contexts,
        "map",
        function(____, context)
            local kind = __re_replace(
                context.id,
                __re("^(?:cutscenes|events)\\.", ""),
                ""
            )
            local ____t_9 = __t
            local ____t_8 = __t
            local ____call_result_7 = __call(kinds, "has", kind)
            __O[2314] = ____call_result_7
            return if ____t_9(if ____t_8(____call_result_7) then __re_test(
                __re("^(?:cutscenes|events)\\.", ""),
                context.id
            ) else __O[2314]) then __assign({}, context, {previewKind = kind}) else context
        end
    )
end)(nil)
return ____exports
