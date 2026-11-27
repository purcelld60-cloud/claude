--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __ord, __arrL, __iterar, __t, __get, __arr, __len, __call, __add, __iter, __keys, __entries = __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__arr, __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__iter, __JSR.__keys, __JSR.__entries
local __assign, __isArray = __JSR.__assign, __JSR.__isArray
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Iterator = ____lualib.__TS__Iterator
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local __TS__Spread = ____lualib.__TS__Spread
local __TS__Number = ____lualib.__TS__Number
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    if __t(window.MissaoFarda) then
        return
    end
    local SCENE = 9
    local FLOOR = 440
    local NPCS = __ord(
        {
            tia_ana = __ord({name = "Tia Ana · secretaria", scene = SCENE, x = 1060}, "name,scene,x"),
            aluno_caio = __ord({name = "Caio · 6º ano", scene = SCENE, x = 1480}, "name,scene,x"),
            aluna_lara = __ord({name = "Lara · 7º ano", scene = SCENE, x = 2010}, "name,scene,x"),
            aluno_theo = __ord({name = "Theo · 5º ano", scene = SCENE, x = 3720}, "name,scene,x")
        },
        "tia_ana,aluno_caio,aluna_lara,aluno_theo"
    )
    local ITENS = __ord(
        {
            aluno_caio = __ord({item = "estojo com adesivo de foguete", curto = "ESTOJO", cor = "#3a6ad0"}, "item,curto,cor"),
            aluna_lara = __ord({item = "garrafinha roxa de unicórnio", curto = "GARRAFINHA", cor = "#9a5ad8"}, "item,curto,cor"),
            aluno_theo = __ord({item = "casaco azul do colégio", curto = "CASACO", cor = "#1f3a7a"}, "item,curto,cor")
        },
        "aluno_caio,aluna_lara,aluno_theo"
    )
    local farda = __ord({top = "#f1f1ea", pants = "#1d2d58", shoes = "#1a1a1e"}, "top,pants,shoes")
    local GENTE = __ord(
        {
            tia_ana = __ord(
                {
                    name = "Tia Ana da secretaria",
                    skin = "#f2d4c0",
                    shade = "#d4ab94",
                    build = "normal",
                    h = 0.93,
                    top = "#a8cff0",
                    collar = "#e4f2fc",
                    skirt = "#d8c8a0",
                    hair = __ord({style = "bun", color = "#f2f2ee", gray = "#d8d8d2"}, "style,color,gray"),
                    glasses = "#5a6a7a",
                    item = "book",
                    pose = "talk"
                },
                "name,skin,shade,build,h,top,collar,skirt,hair,glasses,item,pose"
            ),
            aluno_caio = __ord(
                __assign(
                    {},
                    {
                        name = "Caio",
                        skin = "#c48a62",
                        shade = "#93613f",
                        build = "slim",
                        h = 0.82
                    },
                    farda,
                    {
                        hair = __ord({style = "short", color = "#2a1d16"}, "style,color"),
                        pose = "pockets",
                        mood = "sad"
                    }
                ),
                "name,skin,shade,build,h,hair,pose,mood"
            ),
            aluna_lara = __ord(
                {
                    name = "Lara",
                    skin = "#e8bf9f",
                    shade = "#bb9277",
                    build = "slim",
                    h = 0.84,
                    top = "#f1f1ea",
                    skirt = "#1d2d58",
                    hair = __ord({style = "ponytail", color = "#5a3a22"}, "style,color"),
                    earrings = "#9a5ad8",
                    pose = "hips",
                    mood = "sad"
                },
                "name,skin,shade,build,h,top,skirt,hair,earrings,pose,mood"
            ),
            aluno_theo = __ord(
                __assign(
                    {},
                    {
                        name = "Theo",
                        skin = "#7a4a2e",
                        shade = "#55331f",
                        build = "slim",
                        h = 0.78
                    },
                    farda,
                    {
                        hair = __ord({style = "curlyBig", color = "#121010"}, "style,color"),
                        pose = "relaxed",
                        mood = "sad"
                    }
                ),
                "name,skin,shade,build,h,hair,pose,mood"
            )
        },
        "tia_ana,aluno_caio,aluna_lara,aluno_theo"
    )
    local function registrar()
        local CP = window.CampanhaPersonagens
        local ____t_3 = __t
        local ____opt_result_2
        if CP ~= nil then
            ____opt_result_2 = CP.registrar
        end
        if not ____t_3(____opt_result_2) then
            return false
        end
        for ____, ____value in __iterar((__entries(GENTE))) do
            local id = ____value[1]
            local sp = ____value[2]
            CP:registrar(id, sp, "NPC (Colégio Adventista)")
        end
        return true
    end
    if not __t(registrar(nil)) then
        window:addEventListener("DOMContentLoaded", registrar, {once = true})
    end
    local ALUNOS = __keys(ITENS)
    local function entregues(____, q)
        local ____Set_9 = Set
        local ____call_8 = __call
        local ____isArray_7 = __isArray
        local ____opt_result_6
        if q ~= nil then
            ____opt_result_6 = q.achados
        end
        return __TS__New(
            ____Set_9,
            ____call_8(
                if ____isArray_7(____opt_result_6) then q.achados else __arrL({}, 0),
                "filter",
                function(____, id) return __call(ALUNOS, "includes", id) end
            )
        )
    end
    local function fala(____, name, text, actionLabel)
        return if __t(actionLabel) then {name = name, text = text, actionLabel = actionLabel} else {name = name, text = text}
    end
    local function estado(self, q)
        if __t(not __t(q) or type(q) ~= "table") then
            return "nova"
        end
        if __t(q.fardaFeita) then
            return "feita"
        end
        if not __t(q.fardaAceita) then
            return "nova"
        end
        return if entregues(nil, q).size >= __len(ALUNOS) then "entregar" else "ativa"
    end
    local function falar(self, id, q, api)
        local st = estado(nil, q)
        local ____t_12 = __t
        local ____opt_10 = __get(NPCS, id)
        if ____opt_10 ~= nil then
            ____opt_10 = ____opt_10.name
        end
        __O[1317] = ____opt_10
        local N = if ____t_12(____opt_10) then __O[1317] else id
        if id == "tia_ana" then
            if st == "nova" then
                api:say(
                    __arrL(
                        {
                            fala(nil, N, "Da Roça, meu filho! Me ajuda? A caixa de ACHADOS E PERDIDOS da secretaria tá transbordando."),
                            fala(nil, N, "O Caio esqueceu o estojo do foguete, a Lara deixou a garrafinha roxa e o Theo largou o casaco do colégio na quadra."),
                            fala(nil, N, "Eles estão aqui no pátio. Entrega pra cada um e volta aqui que eu tenho uma surpresa da secretaria pra você."),
                            fala(nil, "Da Roça", "Pode deixar, Tia Ana. Entregador oficial do Colégio Adventista!", "Pegar a caixa")
                        },
                        4
                    ),
                    function()
                        q.fardaAceita = true
                        q.achados = __arrL({}, 0)
                        api:toast("Achados e perdidos: entregue o estojo do Caio, a garrafinha da Lara e o casaco do Theo.")
                        api:save()
                    end
                )
                return
            end
            if st == "ativa" then
                local falta = __call(
                    __call(
                        ALUNOS,
                        "filter",
                        function(____, a) return not __t(__call(
                            entregues(nil, q),
                            "has",
                            a
                        )) end
                    ),
                    "map",
                    function(____, a) return __get(
                        __call(
                            __get(NPCS, a).name,
                            "split",
                            " ·"
                        ),
                        0
                    ) end
                )
                api:say(__arrL(
                    {fala(
                        nil,
                        N,
                        ("Ainda falta entregar pro " .. tostring(__call(falta, "join", ", pra "))) .. ". Eles estão espalhados pelo pátio, olha lá no fundo também!"
                    )},
                    1
                ))
                return
            end
            if st == "entregar" then
                api:say(
                    __arrL(
                        {
                            fala(nil, "Da Roça", "Caixa vazia, Tia Ana! Estojo, garrafinha e casaco: tudo com os donos."),
                            fala(nil, N, "Que menino prestativo! A secretaria guardou isso pra você: a FARDA nova do colégio."),
                            fala(nil, N, "Camisa branca com a listra azul no peito e calça com a listra do lado. Vai no espelho e veste!", "Receber a farda")
                        },
                        3
                    ),
                    function()
                        q.fardaFeita = true
                        local ____opt_15 = window.DarocaLook
                        if ____opt_15 ~= nil then
                            ____opt_15 = ____opt_15.ganhar
                        end
                        if ____opt_15 ~= nil then
                            ____opt_15(____opt_15, "farda")
                        end
                        api:xp(150, "side-farda")
                        api:toast("FARDA DA ESCOLA no espelho! Abra em INVENTÁRIO › ESPELHO.")
                        api:save()
                    end
                )
                return
            end
            api:say(__arrL(
                {fala(nil, N, "Os meninos não param de falar do entregador de chapéu. Obrigada, viu? E a farda ficou linda em você!")},
                1
            ))
            return
        end
        local I = __get(ITENS, id)
        if not __t(I) then
            return
        end
        local ____t_22 = __t
        local ____t_18 = __t
        local ____call_result_17 = __call(
            entregues(nil, q),
            "has",
            id
        )
        __O[1318] = ____call_result_17
        local ____opt_result_21
        if q ~= nil then
            ____opt_result_21 = q.fardaFeita
        end
        if ____t_22(if ____t_18(____call_result_17) then __O[1318] else ____opt_result_21) then
            api:say(__arrL(
                {fala(nil, N, "Valeu de novo, Da Roça! Agora eu não esqueço mais nada... acho.")},
                1
            ))
            return
        end
        local ____t_26 = __t
        local ____opt_result_25
        if q ~= nil then
            ____opt_result_25 = q.fardaAceita
        end
        if not ____t_26(____opt_result_25) then
            api:say(__arrL(
                {fala(
                    nil,
                    N,
                    ("Ai, perdi meu " .. tostring(I.item)) .. "... Será que a Tia Ana, da secretaria, guardou?"
                )},
                1
            ))
            return
        end
        api:say(
            __arrL(
                {
                    fala(
                        nil,
                        "Da Roça",
                        ("Ó, achei teu " .. tostring(I.item)) .. " na caixa de achados e perdidos!"
                    ),
                    fala(
                        nil,
                        N,
                        __add(
                            __add("MEU ", I.curto),
                            "! Valeu demais, Da Roça! Achei que tinha perdido pra sempre."
                        )
                    )
                },
                2
            ),
            function()
                local e = entregues(nil, q)
                __call(e, "add", id)
                q.achados = __arr(__TS__Spread(__iter(e)))
                api:xp(
                    30,
                    __add("achado-", id)
                )
                api:toast(if e.size >= __len(ALUNOS) then "Achados e perdidos 3/3! Volte à Tia Ana, perto da entrada do pátio." else ((tostring(I.curto) .. " entregue · ") .. tostring(e.size)) .. "/3")
                api:save()
            end
        )
    end
    local function alvo(self, q, scene)
        if __TS__Number(scene) ~= SCENE then
            return nil
        end
        local st = estado(nil, q)
        if st == "ativa" then
            local e = entregues(nil, q)
            local prox = __call(
                ALUNOS,
                "find",
                function(____, a) return not __t(__call(e, "has", a)) end
            )
            return if __t(prox) then __get(NPCS, prox).x else NPCS.tia_ana.x
        end
        return if st == "entregar" then NPCS.tia_ana.x else nil
    end
    local function objetivo(self, q, scene)
        if __TS__Number(scene) ~= SCENE then
            return nil
        end
        local st = estado(nil, q)
        if st == "ativa" then
            return __arrL(
                {
                    "Achados e perdidos",
                    tostring(entregues(nil, q).size) .. "/3 itens devolvidos aos alunos. Depois volte à Tia Ana."
                },
                2
            )
        end
        if st == "entregar" then
            return __arrL({"Achados e perdidos", "Tudo entregue! Volte à Tia Ana, perto da entrada do pátio."}, 2)
        end
        return nil
    end
    local function R(____, c, x, y, w, h, cor)
        c.fillStyle = cor
        c:fillRect(
            math.floor(x + 0.5),
            math.floor(y + 0.5),
            w,
            h
        )
    end
    local function desenhar(self, c, t, q, scene)
        if __t(__TS__Number(scene) ~= SCENE or estado(nil, q) ~= "ativa") then
            return
        end
        local e = entregues(nil, q)
        for ____, id in __iterar((ALUNOS)) do
            if __t(__call(e, "has", id)) then
                continue
            end
            local I = __get(ITENS, id)
            local x = __get(NPCS, id).x + 18
            local y = FLOOR - 118 + math.sin(t * 3 + x) * 3
            R(
                nil,
                c,
                x - 14,
                y - 12,
                28,
                22,
                "#263b42"
            )
            R(
                nil,
                c,
                x - 13,
                y - 11,
                26,
                20,
                "#f6f4ea"
            )
            R(
                nil,
                c,
                x - 6,
                y + 9,
                4,
                4,
                "#f6f4ea"
            )
            R(
                nil,
                c,
                x - 9,
                y + 13,
                3,
                3,
                "#f6f4ea"
            )
            if id == "aluno_caio" then
                R(
                    nil,
                    c,
                    x - 9,
                    y - 5,
                    18,
                    9,
                    I.cor
                )
                R(
                    nil,
                    c,
                    x - 9,
                    y - 5,
                    18,
                    2,
                    "#6a9af0"
                )
                R(
                    nil,
                    c,
                    x + 2,
                    y - 3,
                    4,
                    5,
                    "#f2f2ee"
                )
                R(
                    nil,
                    c,
                    x + 3,
                    y - 4,
                    2,
                    1,
                    "#e8433a"
                )
            elseif id == "aluna_lara" then
                R(
                    nil,
                    c,
                    x - 3,
                    y - 8,
                    6,
                    15,
                    I.cor
                )
                R(
                    nil,
                    c,
                    x - 2,
                    y - 10,
                    4,
                    2,
                    "#f2f2ee"
                )
                R(
                    nil,
                    c,
                    x - 1,
                    y - 4,
                    2,
                    4,
                    "#ffd0f0"
                )
            else
                R(
                    nil,
                    c,
                    x - 9,
                    y - 6,
                    18,
                    13,
                    I.cor
                )
                R(
                    nil,
                    c,
                    x - 12,
                    y - 6,
                    4,
                    10,
                    I.cor
                )
                R(
                    nil,
                    c,
                    x + 8,
                    y - 6,
                    4,
                    10,
                    I.cor
                )
                R(
                    nil,
                    c,
                    x - 1,
                    y - 6,
                    2,
                    13,
                    "#f2f2ee"
                )
            end
        end
    end
    window.MissaoFarda = __ord(
        {
            SCENE = SCENE,
            npcs = NPCS,
            ehNpc = function(____, id) return not not __t(__get(NPCS, id)) end,
            estado = estado,
            falar = falar,
            alvo = alvo,
            objetivo = objetivo,
            desenhar = desenhar,
            coletar = function() return nil end
        },
        "SCENE,npcs,ehNpc,estado,falar,alvo,objetivo,desenhar,coletar"
    )
end)(nil)
return ____exports
