--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __hasOwnV, __fcall, __lt, __le, __gt, __mod, __ord, __arrL, __iterar, __t, __get, __set = __JSR.__hasOwnV, __JSR.__fcall, __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set
local __arr, __len, __call, __add, __iter, __values, __entries, __assign, __re, __re_test, __re_replace = __JSR.__arr, __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__iter, __JSR.__values, __JSR.__entries, __JSR.__assign, __JSR.__re, __JSR.__re_test, __JSR.__re_replace
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__Spread = ____lualib.__TS__Spread
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local __TS__Number = ____lualib.__TS__Number
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    if __t(window.FavelaCasas) then
        return
    end
    local CENA = 5
    local function ROBLOX()
        local ____re_test_2 = __re_test
        local ____re_result_1 = __re("Roblox", "i")
        local ____t_result_0
        if __t(window.navigator.userAgent) then
            ____t_result_0 = window.navigator.userAgent
        else
            ____t_result_0 = ""
        end
        return ____re_test_2(____re_result_1, ____t_result_0) or not not __t(window.DAROCA_ROBLOX)
    end
    local CASAS = __ord(
        {
            casa_dalva = __ord({
                x = 510,
                nome = "Casa da Dona Dalva",
                porta = "CASA DA DONA DALVA",
                morador = "dona_dalva",
                npc = "Dona Dalva"
            }, "x,nome,porta,morador,npc"),
            casa_tiao = __ord({
                x = 3867,
                nome = "Barraco do Seu Tião",
                porta = "BARRACO DO SEU TIÃO",
                morador = "seu_tiao",
                npc = "Seu Tião"
            }, "x,nome,porta,morador,npc"),
            casa_kelly = __ord({
                x = 5967,
                nome = "Casa da Kelly",
                porta = "CASA DA KELLY",
                morador = "kelly_favela",
                npc = "Kelly"
            }, "x,nome,porta,morador,npc")
        },
        "casa_dalva,casa_tiao,casa_kelly"
    )
    local function ehCasa(____, id)
        return __fcall(__hasOwnV, CASAS, id)
    end
    local GENTE = __ord(
        {
            dona_dalva = __ord(
                {
                    name = "Dona Dalva",
                    skin = "#7a4a2e",
                    shade = "#55331f",
                    build = "belly",
                    h = 0.86,
                    top = "#d8708e",
                    topKind = "apron",
                    apron = "#f2e6c8",
                    skirt = "#4a5a8a",
                    hair = __ord({style = "bun", color = "#e8e4dc", gray = "#c8c2b8"}, "style,color,gray"),
                    glasses = "#4a3a2a",
                    pose = "talk"
                },
                "name,skin,shade,build,h,top,topKind,apron,skirt,hair,glasses,pose"
            ),
            seu_tiao = __ord(
                {
                    name = "Seu Tião",
                    skin = "#8a5a3a",
                    shade = "#62402a",
                    build = "slim",
                    h = 0.9,
                    top = "#e8e8e0",
                    topKind = "tank",
                    pants = "#3a5a7a",
                    hat = __ord({kind = "cap", color = "#2a6a3a", band = "#f2d24a"}, "kind,color,band"),
                    hair = __ord({style = "short", color = "#d8d4cc"}, "style,color"),
                    mustache = "#d8d4cc",
                    pose = "relaxed"
                },
                "name,skin,shade,build,h,top,topKind,pants,hat,hair,mustache,pose"
            ),
            kelly_favela = __ord(
                {
                    name = "Kelly",
                    skin = "#6a4028",
                    shade = "#4a2c1a",
                    build = "slim",
                    h = 0.88,
                    top = "#f24a8a",
                    skirt = "#1a1a24",
                    hair = __ord({style = "long", color = "#1a1210"}, "style,color"),
                    earrings = "#f2d24a",
                    pose = "hips"
                },
                "name,skin,shade,build,h,top,skirt,hair,earrings,pose"
            )
        },
        "dona_dalva,seu_tiao,kelly_favela"
    )
    local function registrar()
        local CP = window.CampanhaPersonagens
        local ____t_6 = __t
        local ____opt_result_5
        if CP ~= nil then
            ____opt_result_5 = CP.registrar
        end
        if not ____t_6(____opt_result_5) then
            return false
        end
        for ____, ____value in __iterar((__entries(GENTE))) do
            local id = ____value[1]
            local sp = ____value[2]
            CP:registrar(id, sp, "Morador (Favela do Reeis)")
        end
        return true
    end
    if not __t(registrar(nil)) then
        window:addEventListener("DOMContentLoaded", registrar, {once = true})
    end
    local function porPortas()
        local W = window.WorldData
        local ____t_10 = __t
        local ____opt_result_9
        if W ~= nil then
            ____opt_result_9 = W.doors
        end
        if not ____t_10(____opt_result_9) then
            return false
        end
        local novas = __call(
            __call(
                __entries(CASAS),
                "filter",
                function(____, ____bindingPattern0)
                    local id
                    id = ____bindingPattern0[1]
                    return not __t(__call(
                        W.doors,
                        "some",
                        function(____, d) return d.id == id end
                    ))
                end
            ),
            "map",
            function(____, ____bindingPattern0)
                local c
                local id
                id = ____bindingPattern0[1]
                c = ____bindingPattern0[2]
                return {
                    id = id,
                    scene = CENA,
                    x = c.x,
                    label = c.porta,
                    width = 960,
                    exitX = 90,
                    teacherX = 640,
                    casa = true
                }
            end
        )
        if not __t(__len(novas)) then
            return true
        end
        do
            local function ____catch(e)
                return true, false
            end
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                local ____window_15 = window
                local ____assign_14 = __assign
                local ____temp_13 = {}
                local ____arr_12 = __arr
                local ____array_11 = __TS__SparseArrayNew(__TS__Spread(__iter(W.doors)))
                __TS__SparseArrayPush(
                    ____array_11,
                    __TS__Spread(__iter(novas))
                )
                ____window_15.WorldData = ____assign_14(
                    ____temp_13,
                    W,
                    {doors = ____arr_12(__TS__SparseArraySpread(____array_11))}
                )
            end)
            if not ____try then
                ____hasReturned, ____returnValue = ____catch(____hasReturned)
            end
            if ____hasReturned then
                return ____returnValue
            end
        end
        return __len(window.WorldData.doors) == __len(W.doors) + __len(novas)
    end
    if not __t(porPortas(nil)) then
        window:addEventListener("DOMContentLoaded", porPortas, {once = true})
    end
    local DR = "Da Roça"
    local LENDAS = __ord(
        {
            casa_dalva = __arrL(
                {
                    function(____, n) return __arrL({{name = n, text = "Senta, meu filho. Quer café? Então escuta: o Reeis assaltou o banco da avenida num domingo de chuva."}, {name = n, text = "E dividiu TUDO com a favela. Cada casa ganhou um envelope com laço de fita, até a minha."}, {name = DR, text = "E a polícia, Dona Dalva?"}, {name = n, text = "Procuraram três semanas. Ele tava aqui, comendo o meu feijão. Guardo o envelope dentro da Bíblia até hoje."}}, 4) end,
                    function(____, n) return __arrL({{name = n, text = "Quando o gás subiu, o Reeis parou o caminhão do gás bem na entrada do morro."}, {name = n, text = "\"Botijão é de quem cozinha\", ele disse. Desceu um por casa. Nem as panelas acreditaram."}, {name = DR, text = "Esse homem pensava em tudo."}}, 3) end,
                    function(____, n) return __arrL({{name = n, text = "No Natal ele desceu a ladeira vestido de Papai Noel, com um saco cheio de brinquedo."}, {name = n, text = "Só que o saco era malote de carro-forte. Os meninos ganharam bicicleta e eu ganhei um ventilador."}, {name = n, text = "Esse aí que tá girando. Funciona até hoje!"}}, 3) end,
                    function(____, n) return __arrL({{name = n, text = "Aqui ninguém mexe com velho, com criança nem com cachorro de rua. Regra do Reeis."}, {name = n, text = "Quem quebrou a regra uma vez foi parar pendurado na caixa d'água pela cueca. De dia, pra todo mundo ver."}, {name = DR, text = "Anotado, Dona Dalva. Respeito acima de tudo."}}, 3) end
                },
                4
            ),
            casa_tiao = __arrL(
                {
                    function(____, n)
                        local ____t_result_16
                        if __t(ROBLOX(nil)) then
                            ____t_result_16 = __arrL({{name = n, text = "Conhece o Dedé Fumacinha? Uma noite o Reeis trouxe tanto doce de leite pro Dedé que ele comeu tudo e caiu duro no chão da laje."}, {name = n, text = "Ficou três horas olhando pro céu, jurando que as nuvens eram algodão doce."}, {name = n, text = "Quando acordou, pediu mais. O Reeis só falou: \"Fecha a conta, Dedé.\""}}, 3)
                        else
                            ____t_result_16 = __arrL({{name = n, text = "Conhece o Dedé Fumacinha? Uma noite o Reeis trouxe tanta maconha pro Dedé que ele deu duas tragadas e caiu duro no chão da laje."}, {name = n, text = "Ficou três horas olhando pro céu, jurando que as nuvens eram algodão doce."}, {name = n, text = "Quando acordou, pediu mais. O Reeis só falou: \"Fecha a conta, Dedé.\""}}, 3)
                        end
                        return ____t_result_16
                    end,
                    function(____, n) return __arrL({{name = n, text = "Uma vez a viatura cercou o morro inteiro. Sabe o que o Reeis fez? Fugiu pulando de laje em laje..."}, {name = n, text = "...com uma geladeira nas costas! Era da Dona Dalva, ele tava devolvendo do conserto."}, {name = DR, text = "E a geladeira?"}, {name = n, text = "Chegou gelando. A polícia é que chegou suando."}}, 4) end,
                    function(____, n) return __arrL({{name = n, text = "O Reeis empinou a moto da escadaria do beco até a pracinha lá de cima. Duzentos degraus."}, {name = n, text = "A moto chegou sem pneu. Ele chegou rindo e ainda deu carona pra minha sogra na volta."}}, 2) end,
                    function(____, n) return __arrL({{name = n, text = "Dizem que ele ganhou do Bigodon no dominó valendo o comando da rua."}, {name = n, text = "Bateu de carroça na última pedra. O Bigodon chorou e o Reeis pagou a cerveja dele, pra não humilhar."}, {name = DR, text = "Respeito até no dominó."}}, 3) end
                },
                4
            ),
            casa_kelly = __arrL(
                {
                    function(____, n) return __arrL({{name = n, text = "Quando cortaram a luz do morro, o Reeis subiu no poste e religou a favela inteira. No escuro!"}, {name = n, text = "Com uma mão só, porque a outra tava segurando o espetinho. Nem derrubou a farofa."}}, 2) end,
                    function(____, n) return __arrL({{name = n, text = "O baile de quinta é de graça porque o Reeis pagou o som pro ano todo."}, {name = DR, text = "Pagou com o quê?"}, {name = n, text = "Melhor você não perguntar, Da Roça. Só dança."}}, 3) end,
                    function(____, n) return __arrL({{name = n, text = "Uma madame humilhou a Dona Dalva na feira. No outro dia a bolsa dela sumiu."}, {name = n, text = "Voltou vazia, com um bilhete do Reeis dentro: \"Educação também é de graça.\""}}, 2) end,
                    function(____, n) return __arrL({{name = n, text = "O Reeis nunca terminou a escola, mas pagou a formatura da minha turma inteira."}, {name = n, text = "Teve DJ, salgadinho e fumaça de gelo seco. Eu entrei de vestido rosa com o nome dele bordado."}, {name = DR, text = "Esse cara é lenda mesmo."}, {name = n, text = "Lenda não. Aqui ele é o prefeito que ninguém votou e todo mundo respeita."}}, 4) end
                },
                4
            )
        },
        "casa_dalva,casa_tiao,casa_kelly"
    )
    local function falar(self, id, q, api)
        local c = __get(CASAS, id)
        if not __t(c) then
            return false
        end
        local ____q_20 = q
        local ____t_result_19
        local ____t_18 = __t
        local ____t_result_17
        if __t(q.lendasReeis) then
            ____t_result_17 = type(q.lendasReeis) == "table"
        else
            ____t_result_17 = q.lendasReeis
        end
        if ____t_18(____t_result_17) then
            ____t_result_19 = q.lendasReeis
        else
            ____t_result_19 = {}
        end
        ____q_20.lendasReeis = ____t_result_19
        local lista = __get(LENDAS, id)
        local ____mod_24 = __mod
        local ____t_result_23
        local ____t_22 = __t
        local ____TS__Number_result_21 = __TS__Number(__get(q.lendasReeis, id))
        __O[1342] = ____TS__Number_result_21
        if ____t_22(____TS__Number_result_21) then
            ____t_result_23 = __O[1342]
        else
            ____t_result_23 = 0
        end
        local i = ____mod_24(
            ____t_result_23,
            __len(lista)
        )
        __set(q.lendasReeis, id, i + 1)
        local ____opt_result_29
        if api ~= nil then
            ____opt_result_29 = api.say
        end
        if ____opt_result_29 ~= nil then
            ____opt_result_29(
                api,
                __get(lista, i)(nil, c.npc)
            )
        end
        local ____opt_result_34
        if api ~= nil then
            ____opt_result_34 = api.save
        end
        if ____opt_result_34 ~= nil then
            ____opt_result_34(api)
        end
        return true
    end
    local LW = 480
    local LH = 270
    local GY = 220
    local function hsh(____, n)
        local x = math.sin(n * 12.9898 + 78.233) * 43758.5453
        return x - math.floor(x)
    end
    local function R(____, c, x, y, w, h, cor)
        c.fillStyle = cor
        c:fillRect(
            math.floor(x + 0.5),
            math.floor(y + 0.5),
            math.max(
                1,
                math.floor(w + 0.5)
            ),
            math.max(
                1,
                math.floor(h + 0.5)
            )
        )
    end
    local function mk(____, w, h)
        local cv = window.document:createElement("canvas")
        cv.width = w
        cv.height = h
        local c = cv:getContext("2d")
        c.imageSmoothingEnabled = false
        return __arrL({cv, c}, 2)
    end
    local function disco(____, c, x, y, r, cor)
        do
            local yy = __TS__Number(-r)
            while __le(yy, r) do
                local w = math.floor(math.sqrt(math.max(0, r * r - yy * yy)) + 0.5)
                R(
                    nil,
                    c,
                    x - w,
                    y + yy,
                    w * 2 + 1,
                    1,
                    cor
                )
                yy = yy + 1
            end
        end
    end
    local function glow(____, c, x, y, r, cor, a)
        c:save()
        c.globalCompositeOperation = "lighter"
        c.globalAlpha = a
        local g = c:createRadialGradient(
            x,
            y,
            0,
            x,
            y,
            r
        )
        g:addColorStop(0, cor)
        g:addColorStop(1, "rgba(0,0,0,0)")
        c.fillStyle = g
        c:fillRect(x - r, y - r, r * 2, r * 2)
        c:restore()
    end
    local function noite()
        do
            local function ____catch(e)
                return true, 0
            end
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                local ____t_result_45
                local ____t_44 = __t
                local ____opt_39 = window.DayTime
                if ____opt_39 ~= nil then
                    ____opt_39 = ____opt_39.state
                end
                local ____opt_result_41
                if ____opt_39 ~= nil then
                    ____opt_result_41 = ____opt_39(____opt_39)
                end
                local ____opt_result_42
                if ____opt_result_41 ~= nil then
                    ____opt_result_42 = ____opt_result_41.night
                end
                local ____TS__Number_result_43 = __TS__Number(____opt_result_42)
                __O[1343] = ____TS__Number_result_43
                if ____t_44(____TS__Number_result_43) then
                    ____t_result_45 = __O[1343]
                else
                    ____t_result_45 = 0
                end
                return true, math.max(
                    0,
                    math.min(1, ____t_result_45)
                )
            end)
            if not ____try then
                ____hasReturned, ____returnValue = ____catch(____hasReturned)
            end
            if ____hasReturned then
                return ____returnValue
            end
        end
    end
    local function parede(self, c, x0, y0, x1, y1, base, claro, escuro, seed)
        R(
            nil,
            c,
            x0,
            y0,
            x1 - x0,
            y1 - y0,
            base
        )
        do
            local y = y0
            while __lt(y, y1) do
                do
                    local x = x0 + __mod(y / 2, 2)
                    while __lt(x, x1) do
                        local h = hsh(nil, x * 3.1 + y * 7.7 + seed)
                        if h > 0.93 then
                            R(
                                nil,
                                c,
                                x,
                                y,
                                1,
                                1,
                                claro
                            )
                        elseif h < 0.05 then
                            R(
                                nil,
                                c,
                                x,
                                y,
                                1,
                                1,
                                escuro
                            )
                        end
                        x = x + 2
                    end
                end
                y = y + 2
            end
        end
        do
            local x = x0
            while __lt(x, x1) do
                local h = 6 + hsh(
                    nil,
                    __add(x, seed)
                ) * 12
                c.globalAlpha = 0.18
                R(
                    nil,
                    c,
                    x,
                    y1 - h,
                    3,
                    h,
                    escuro
                )
                c.globalAlpha = 1
                x = x + 3
            end
        end
        do
            local k = 0
            while k < 4 do
                local bx = x0 + 70 + hsh(nil, k * 9 + seed) * (x1 - x0 - 160)
                local by = y0 + 24 + hsh(nil, k * 5 + seed) * (y1 - y0 - 80)
                local larg = __arrL({
                    3,
                    5,
                    6,
                    5,
                    3
                }, 5)
                do
                    local j = 0
                    while j < __len(larg) do
                        local w = __get(larg, j) * 5
                        local ox = bx - w / 2 + (hsh(nil, j + k * 3 + seed) - 0.5) * 4
                        R(
                            nil,
                            c,
                            ox - 1,
                            by + j * 4 - 1,
                            w + 2,
                            6,
                            escuro
                        )
                        do
                            local i = 0
                            while i < __get(larg, j) do
                                R(
                                    nil,
                                    c,
                                    ox + i * 5 + __mod(j, 2) * 2,
                                    by + j * 4,
                                    4,
                                    3,
                                    __t(__mod(i + j, 3)) and "#a8634a" or "#b8735a"
                                )
                                R(
                                    nil,
                                    c,
                                    ox + i * 5 + __mod(j, 2) * 2,
                                    by + j * 4,
                                    4,
                                    1,
                                    "#c88a6a"
                                )
                                i = i + 1
                            end
                        end
                        j = j + 1
                    end
                end
                R(
                    nil,
                    c,
                    bx - 12,
                    by - 2,
                    24,
                    1,
                    claro
                )
                k = k + 1
            end
        end
    end
    local function piso(self, c, cor1, cor2, junta)
        R(
            nil,
            c,
            0,
            GY,
            LW,
            LH - GY,
            cor1
        )
        local linhas = __arrL({
            GY,
            GY + 5,
            GY + 11,
            GY + 19,
            GY + 29,
            GY + 41,
            LH
        }, 7)
        do
            local r = 0
            while r < __len(linhas) - 1 do
                R(
                    nil,
                    c,
                    0,
                    __get(linhas, r),
                    LW,
                    1,
                    junta
                )
                local passo = 18 + r * 8
                do
                    local x = __mod(r, 2) * passo / 2
                    while x < LW do
                        R(
                            nil,
                            c,
                            x,
                            __get(linhas, r),
                            1,
                            __get(linhas, r + 1) - __get(linhas, r),
                            junta
                        )
                        if __mod(x / passo + r, 3) < 1 then
                            R(
                                nil,
                                c,
                                x + 1,
                                __get(linhas, r) + 1,
                                passo - 1,
                                __get(linhas, r + 1) - __get(linhas, r) - 1,
                                cor2
                            )
                        end
                        x = x + passo
                    end
                end
                r = r + 1
            end
        end
        do
            local x = 0
            while x < LW do
                if hsh(nil, x) > 0.7 then
                    R(
                        nil,
                        c,
                        x,
                        GY + 2 + hsh(nil, x * 3) * 40,
                        2,
                        1,
                        "rgba(255,255,255,.18)"
                    )
                end
                x = x + 7
            end
        end
    end
    local function rodape(self, c, cor)
        R(
            nil,
            c,
            0,
            GY - 4,
            LW,
            4,
            cor
        )
        R(
            nil,
            c,
            0,
            GY - 4,
            LW,
            1,
            "rgba(255,255,255,.25)"
        )
    end
    local function janela(self, c, x, y, w, h, n)
        R(
            nil,
            c,
            x - 3,
            y - 3,
            w + 6,
            h + 6,
            "#5a3a24"
        )
        R(
            nil,
            c,
            x - 3,
            __add(y, h) + 1,
            w + 6,
            2,
            "#7a5a3a"
        )
        local g = c:createLinearGradient(
            0,
            y,
            0,
            __add(y, h)
        )
        g:addColorStop(
            0,
            __gt(n, 0.5) and "#0e1430" or "#6aa8e0"
        )
        g:addColorStop(
            1,
            __gt(n, 0.5) and "#2a2a50" or "#bcdcf0"
        )
        c.fillStyle = g
        c:fillRect(x, y, w, h)
        do
            local i = 0
            while i < 6 do
                local bx = x + i * w / 6
                local bh = 8 + hsh(nil, i + x) * (h * 0.55)
                R(
                    nil,
                    c,
                    bx,
                    __add(y, h) - bh,
                    w / 6 + 1,
                    bh,
                    __gt(n, 0.5) and "#3a2a3a" or __get(
                        __arrL({"#c86a4a", "#d89a6a", "#b85a3a"}, 3),
                        __mod(i, 3)
                    )
                )
                if __t(__gt(n, 0.5) and hsh(nil, i * 3 + x) > 0.4) then
                    R(
                        nil,
                        c,
                        bx + 3,
                        __add(y, h) - bh + 3,
                        2,
                        2,
                        "#ffd27a"
                    )
                end
                i = i + 1
            end
        end
        do
            local k = 1
            while k < 4 do
                R(
                    nil,
                    c,
                    x + k * w / 4,
                    y,
                    1,
                    h,
                    "#2a2a2a"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            x,
            y + h / 2,
            w,
            1,
            "#2a2a2a"
        )
    end
    local function quadro(self, c, x, y, w, h, moldura, fundo, desenho)
        R(
            nil,
            c,
            x - 2,
            y - 2,
            w + 4,
            h + 4,
            moldura
        )
        R(
            nil,
            c,
            x,
            y,
            w,
            h,
            fundo
        )
        local ____t_result_46
        if __t(desenho) then
            ____t_result_46 = desenho(
                nil,
                c,
                x,
                y,
                w,
                h
            )
        else
            ____t_result_46 = desenho
        end
        R(
            nil,
            c,
            x - 2,
            y - 2,
            w + 4,
            1,
            "rgba(255,255,255,.3)"
        )
    end
    local function lampada(self, c, x, ytop, comp, acesa, t)
        R(
            nil,
            c,
            x,
            ytop,
            1,
            comp,
            "#2a2a2a"
        )
        R(
            nil,
            c,
            x - 2,
            __add(ytop, comp),
            5,
            3,
            "#8a8a7a"
        )
        disco(
            nil,
            c,
            x,
            __add(ytop, comp) + 5,
            3,
            __t(acesa) and "#fff2b8" or "#c8c0a8"
        )
    end
    local function salaDalva(self, c)
        parede(
            nil,
            c,
            0,
            0,
            LW,
            GY - 4,
            "#e8b8b4",
            "#f6d0cc",
            "#c0908c",
            11
        )
        R(
            nil,
            c,
            0,
            128,
            LW,
            3,
            "#b8746a"
        )
        do
            local x = 0
            while x < LW do
                R(
                    nil,
                    c,
                    x + 4,
                    129,
                    4,
                    1,
                    "#f2d2a2"
                )
                x = x + 12
            end
        end
        piso(
            nil,
            c,
            "#c8a07a",
            "#b8906a",
            "#8a6a4a"
        )
        rodape(nil, c, "#8a5a4a")
        janela(
            nil,
            c,
            300,
            52,
            64,
            44,
            0
        )
        R(
            nil,
            c,
            36,
            120,
            34,
            100,
            "#4a2e1a"
        )
        R(
            nil,
            c,
            39,
            123,
            28,
            97,
            "#f2e0b0"
        )
        R(
            nil,
            c,
            40,
            124,
            26,
            96,
            "#ffeec8"
        )
        R(
            nil,
            c,
            66,
            123,
            6,
            97,
            "#7a4a2a"
        )
        R(
            nil,
            c,
            92,
            120,
            34,
            100,
            "#e8ece8"
        )
        R(
            nil,
            c,
            92,
            120,
            34,
            2,
            "#ffffff"
        )
        R(
            nil,
            c,
            92,
            160,
            34,
            1,
            "#a8acaa"
        )
        R(
            nil,
            c,
            121,
            132,
            2,
            20,
            "#8a8e8c"
        )
        R(
            nil,
            c,
            121,
            166,
            2,
            30,
            "#8a8e8c"
        )
        do
            local k = 0
            while k < 6 do
                R(
                    nil,
                    c,
                    96 + __mod(k, 3) * 8,
                    126 + math.floor(k / 3) * 10,
                    5,
                    5,
                    __get(
                        __arrL({
                            "#e84a4a",
                            "#4a8ae8",
                            "#f2c24a",
                            "#4ac87a",
                            "#c84ae8",
                            "#f28a4a"
                        }, 6),
                        k
                    )
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            97,
            138,
            14,
            12,
            "#f6f2e8"
        )
        R(
            nil,
            c,
            99,
            141,
            10,
            1,
            "#4a4a4a"
        )
        R(
            nil,
            c,
            99,
            144,
            8,
            1,
            "#4a4a4a"
        )
        R(
            nil,
            c,
            150,
            150,
            80,
            70,
            "#6a4428"
        )
        R(
            nil,
            c,
            150,
            150,
            80,
            3,
            "#8a5a34"
        )
        R(
            nil,
            c,
            152,
            185,
            76,
            2,
            "#4a2e18"
        )
        R(
            nil,
            c,
            160,
            118,
            48,
            34,
            "#2a2a2a"
        )
        R(
            nil,
            c,
            162,
            120,
            44,
            28,
            "#3a4a5a"
        )
        R(
            nil,
            c,
            204,
            108,
            1,
            12,
            "#8a8a8a"
        )
        R(
            nil,
            c,
            196,
            104,
            1,
            14,
            "#8a8a8a"
        )
        R(
            nil,
            c,
            170,
            152,
            30,
            3,
            "#1a1a1a"
        )
        do
            local k = 0
            while k < 3 do
                R(
                    nil,
                    c,
                    158 + k * 22,
                    192,
                    14,
                    20,
                    __get(
                        __arrL({"#e8c24c", "#8a2a2a", "#3a6a9a"}, 3),
                        k
                    )
                )
                R(
                    nil,
                    c,
                    162 + k * 22,
                    196,
                    6,
                    8,
                    "#f6e8d0"
                )
                k = k + 1
            end
        end
        quadro(
            nil,
            c,
            238,
            70,
            26,
            32,
            "#c8a24a",
            "#e8d8b8",
            function(____, cc, x, y)
                disco(
                    nil,
                    cc,
                    x + 13,
                    y + 12,
                    6,
                    "#6a4028"
                )
                R(
                    nil,
                    cc,
                    x + 7,
                    y + 6,
                    12,
                    4,
                    "#1a1210"
                )
                R(
                    nil,
                    cc,
                    x + 6,
                    y + 19,
                    14,
                    13,
                    "#e8e4dc"
                )
                R(
                    nil,
                    cc,
                    x + 9,
                    y + 11,
                    2,
                    2,
                    "#1a1a1a"
                )
                R(
                    nil,
                    cc,
                    x + 15,
                    y + 11,
                    2,
                    2,
                    "#1a1a1a"
                )
            end
        )
        R(
            nil,
            c,
            232,
            104,
            38,
            6,
            "#f2e8d8"
        )
        do
            local k = 0
            while k < 3 do
                R(
                    nil,
                    c,
                    238 + k * 10,
                    92,
                    6,
                    12,
                    "#f2f0e8"
                )
                R(
                    nil,
                    c,
                    239 + k * 10,
                    88,
                    4,
                    4,
                    "#e8c8a8"
                )
                R(
                    nil,
                    c,
                    240 + k * 10,
                    84,
                    2,
                    4,
                    "#c8a24a"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            274,
            64,
            1,
            50,
            "#c8a24a"
        )
        disco(
            nil,
            c,
            274,
            62,
            2,
            "#c8a24a"
        )
        R(
            nil,
            c,
            372,
            70,
            26,
            36,
            "#f6f2e8"
        )
        R(
            nil,
            c,
            372,
            70,
            26,
            12,
            "#d84a3a"
        )
        do
            local k = 0
            while k < 15 do
                R(
                    nil,
                    c,
                    375 + __mod(k, 5) * 4,
                    86 + math.floor(k / 5) * 5,
                    2,
                    2,
                    "#4a4a4a"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            300,
            168,
            110,
            40,
            "#8a4a5a"
        )
        R(
            nil,
            c,
            300,
            150,
            110,
            22,
            "#9a5a6a"
        )
        R(
            nil,
            c,
            296,
            160,
            12,
            48,
            "#7a3a4a"
        )
        R(
            nil,
            c,
            402,
            160,
            12,
            48,
            "#7a3a4a"
        )
        do
            local x = 304
            while x < 404 do
                do
                    local y = 152
                    while y < 170 do
                        if __mod(x + y, 12) < 6 then
                            R(
                                nil,
                                c,
                                x,
                                y,
                                3,
                                3,
                                "#f2e8d8"
                            )
                        end
                        y = y + 6
                    end
                end
                x = x + 6
            end
        end
        R(
            nil,
            c,
            300,
            208,
            4,
            12,
            "#4a2e18"
        )
        R(
            nil,
            c,
            406,
            208,
            4,
            12,
            "#4a2e18"
        )
        R(
            nil,
            c,
            250,
            190,
            40,
            4,
            "#f2f2e8"
        )
        do
            local x = 250
            while x < 290 do
                R(
                    nil,
                    c,
                    x,
                    194,
                    2,
                    4,
                    "#e84a6a"
                )
                x = x + 4
            end
        end
        R(
            nil,
            c,
            254,
            198,
            3,
            22,
            "#6a4428"
        )
        R(
            nil,
            c,
            283,
            198,
            3,
            22,
            "#6a4428"
        )
        R(
            nil,
            c,
            262,
            172,
            8,
            18,
            "#c84a3a"
        )
        R(
            nil,
            c,
            263,
            170,
            6,
            3,
            "#f2f2e8"
        )
        R(
            nil,
            c,
            274,
            184,
            6,
            6,
            "#f2f2f2"
        )
        R(
            nil,
            c,
            280,
            185,
            2,
            3,
            "#f2f2f2"
        )
        do
            local x = 230
            while x < 430 do
                R(
                    nil,
                    c,
                    x,
                    GY + 8,
                    2,
                    6,
                    __mod(x / 2, 4) < 2 and "#c8a24a" or "#b8441a"
                )
                x = x + 2
            end
        end
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({436, "#5a9a3a"}, 2),
                __arrL({452, "#3a7a2a"}, 2)
            },
            2
        ))) do
            local x = ____value[1]
            local cor = ____value[2]
            R(
                nil,
                c,
                x,
                196,
                12,
                24,
                "#a8a8b0"
            )
            R(
                nil,
                c,
                x,
                199,
                12,
                3,
                "#d84a3a"
            )
            do
                local k = 0
                while k < 6 do
                    local ____array_48 = __TS__SparseArrayNew(
                        nil,
                        c,
                        x + 6 + math.floor(math.sin(k * 2) * 6 + 0.5),
                        186 - k * 4,
                        4
                    )
                    local ____t_result_47
                    if __t(__mod(k, 2)) then
                        ____t_result_47 = cor
                    else
                        ____t_result_47 = "#6aaa4a"
                    end
                    __TS__SparseArrayPush(____array_48, ____t_result_47)
                    disco(__TS__SparseArraySpread(____array_48))
                    k = k + 1
                end
            end
        end
        disco(
            nil,
            c,
            360,
            222,
            5,
            "#e8a24a"
        )
        R(
            nil,
            c,
            352,
            219,
            16,
            5,
            "#e8a24a"
        )
        R(
            nil,
            c,
            364,
            214,
            6,
            5,
            "#e8a24a"
        )
        R(
            nil,
            c,
            364,
            213,
            2,
            2,
            "#c8823a"
        )
        R(
            nil,
            c,
            368,
            213,
            2,
            2,
            "#c8823a"
        )
        R(
            nil,
            c,
            350,
            222,
            8,
            2,
            "#c8823a"
        )
    end
    local function animDalva(self, c, t, n)
        local f = __mod(
            math.floor(t * 3),
            4
        )
        R(
            nil,
            c,
            162,
            120,
            44,
            28,
            __get(
                __arrL({"#4a6a8a", "#5a7a6a", "#6a5a7a", "#4a6a8a"}, 4),
                f
            )
        )
        do
            local y = 120
            while y < 148 do
                c.globalAlpha = 0.18
                R(
                    nil,
                    c,
                    162,
                    y,
                    44,
                    1,
                    "#000"
                )
                c.globalAlpha = 1
                y = y + 2
            end
        end
        disco(
            nil,
            c,
            176 + math.floor(math.sin(t) * 3 + 0.5),
            134,
            5,
            "#e8b89a"
        )
        disco(
            nil,
            c,
            192 - math.floor(math.sin(t) * 3 + 0.5),
            134,
            5,
            "#7a4a2e"
        )
        glow(
            nil,
            c,
            184,
            134,
            40,
            "#6a8ac8",
            0.25
        )
        R(
            nil,
            c,
            140,
            186,
            2,
            32,
            "#6a6a6a"
        )
        R(
            nil,
            c,
            133,
            217,
            16,
            3,
            "#5a5a5a"
        )
        disco(
            nil,
            c,
            141,
            184,
            9,
            "rgba(220,230,240,.35)"
        )
        do
            local k = 0
            while k < 3 do
                local a = t * 18 + k * 2.09
                R(
                    nil,
                    c,
                    141 + math.floor(math.cos(a) * 6 + 0.5) - 2,
                    184 + math.floor(math.sin(a) * 6 + 0.5) - 1,
                    4,
                    3,
                    "#4a8ad8"
                )
                k = k + 1
            end
        end
        disco(
            nil,
            c,
            141,
            184,
            2,
            "#2a2a2a"
        )
        do
            local k = 0
            while k < 4 do
                local u = __mod(t * 0.5 + k / 4, 1)
                c.globalAlpha = (1 - u) * 0.5
                R(
                    nil,
                    c,
                    277 + math.sin(t * 2 + k) * 2,
                    182 - u * 18,
                    2,
                    2,
                    "#ffffff"
                )
                k = k + 1
            end
        end
        c.globalAlpha = 1
        local r = math.floor(math.sin(t * 2) + 0.5)
        R(
            nil,
            c,
            354,
            217 - r,
            12,
            2,
            "#f2b85a"
        )
        lampada(
            nil,
            c,
            230,
            0,
            26,
            true,
            t
        )
        glow(
            nil,
            c,
            230,
            36,
            120,
            "#ffd890",
            0.22 + n * 0.2
        )
    end
    local function salaTiao(self, c)
        R(
            nil,
            c,
            0,
            0,
            LW,
            GY - 4,
            "#a8603e"
        )
        do
            local y = 0
            local r = 0
            while y < GY - 4 do
                R(
                    nil,
                    c,
                    0,
                    y,
                    LW,
                    1,
                    "#7a4028"
                )
                do
                    local x = __mod(r, 2) * 9
                    while x < LW do
                        R(
                            nil,
                            c,
                            x,
                            y,
                            1,
                            7,
                            "#7a4028"
                        )
                        if hsh(nil, x * 7 + y) > 0.6 then
                            R(
                                nil,
                                c,
                                x + 2,
                                y + 2,
                                12,
                                4,
                                hsh(nil, x + y) > 0.5 and "#b8704a" or "#985030"
                            )
                        end
                        x = x + 18
                    end
                end
                do
                    y = y + 7
                    r = r + 1
                end
            end
        end
        parede(
            nil,
            c,
            120,
            30,
            330,
            GY - 4,
            "#d8d0b0",
            "#ece6cc",
            "#a8a080",
            23
        )
        piso(
            nil,
            c,
            "#8a8478",
            "#7a7468",
            "#5a554a"
        )
        rodape(nil, c, "#4a4438")
        janela(
            nil,
            c,
            200,
            50,
            56,
            40,
            0
        )
        R(
            nil,
            c,
            36,
            120,
            34,
            100,
            "#2a2a30"
        )
        R(
            nil,
            c,
            39,
            123,
            28,
            97,
            "#f2e0b0"
        )
        R(
            nil,
            c,
            40,
            124,
            26,
            96,
            "#ffeec8"
        )
        R(
            nil,
            c,
            66,
            123,
            6,
            97,
            "#4a5a6a"
        )
        R(
            nil,
            c,
            90,
            176,
            80,
            6,
            "#6a4428"
        )
        R(
            nil,
            c,
            92,
            182,
            4,
            38,
            "#4a2e18"
        )
        R(
            nil,
            c,
            164,
            182,
            4,
            38,
            "#4a2e18"
        )
        R(
            nil,
            c,
            96,
            200,
            68,
            3,
            "#4a2e18"
        )
        R(
            nil,
            c,
            92,
            120,
            76,
            40,
            "#8a6a4a"
        )
        do
            local k = 0
            while k < 6 do
                R(
                    nil,
                    c,
                    98 + k * 11,
                    126,
                    2,
                    14 + __mod(k, 3) * 4,
                    "#5a5a5a"
                )
                R(
                    nil,
                    c,
                    96 + k * 11,
                    124,
                    6,
                    3,
                    __get(
                        __arrL({"#d84a3a", "#3a6ad8", "#f2c24a"}, 3),
                        __mod(k, 3)
                    )
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            104,
            166,
            18,
            10,
            "#5a5a6a"
        )
        R(
            nil,
            c,
            140,
            168,
            12,
            8,
            "#c8a24a"
        )
        disco(
            nil,
            c,
            196,
            204,
            14,
            "#1a1a1a"
        )
        disco(
            nil,
            c,
            196,
            204,
            8,
            "#3a3a3a"
        )
        disco(
            nil,
            c,
            196,
            204,
            4,
            "#8a8a8a"
        )
        disco(
            nil,
            c,
            230,
            210,
            9,
            "#d8d0c0"
        )
        R(
            nil,
            c,
            222,
            210,
            18,
            8,
            "#d8d0c0"
        )
        R(
            nil,
            c,
            226,
            206,
            12,
            4,
            "#2a3a5a"
        )
        quadro(
            nil,
            c,
            270,
            60,
            34,
            44,
            "#e8e8e0",
            "#2a6a3a",
            function(____, cc, x, y)
                R(
                    nil,
                    cc,
                    x,
                    y + 8,
                    34,
                    6,
                    "#f2d24a"
                )
                do
                    local k = 0
                    while k < 5 do
                        disco(
                            nil,
                            cc,
                            x + 5 + k * 6,
                            y + 26,
                            2,
                            "#e8b89a"
                        )
                        R(
                            nil,
                            cc,
                            x + 3 + k * 6,
                            y + 29,
                            5,
                            8,
                            "#f2f2f2"
                        )
                        k = k + 1
                    end
                end
            end
        )
        R(
            nil,
            c,
            340,
            180,
            110,
            24,
            "#5a3a24"
        )
        R(
            nil,
            c,
            342,
            172,
            106,
            10,
            "#f2f2e8"
        )
        do
            local x = 342
            while x < 448 do
                do
                    local y = 182
                    while y < 200 do
                        R(
                            nil,
                            c,
                            x,
                            y,
                            4,
                            4,
                            __t(__mod((x + y) / 4, 2)) and "#c83a3a" or "#2a4a8a"
                        )
                        y = y + 4
                    end
                end
                x = x + 4
            end
        end
        R(
            nil,
            c,
            340,
            204,
            4,
            16,
            "#3a2414"
        )
        R(
            nil,
            c,
            446,
            204,
            4,
            16,
            "#3a2414"
        )
        R(
            nil,
            c,
            344,
            166,
            20,
            8,
            "#f6f2e8"
        )
        R(
            nil,
            c,
            300,
            196,
            18,
            24,
            "#3a5ab8"
        )
        R(
            nil,
            c,
            302,
            192,
            14,
            4,
            "#3a5ab8"
        )
        R(
            nil,
            c,
            306,
            188,
            6,
            4,
            "#8a8a8a"
        )
        R(
            nil,
            c,
            398,
            64,
            1,
            22,
            "#5a5a5a"
        )
        R(
            nil,
            c,
            386,
            86,
            26,
            30,
            "rgba(0,0,0,0)"
        )
        do
            local k = 0
            while k <= 6 do
                R(
                    nil,
                    c,
                    386 + k * 4,
                    86,
                    1,
                    30,
                    "#c8c0a8"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            386,
            86,
            26,
            2,
            "#c8c0a8"
        )
        R(
            nil,
            c,
            386,
            115,
            26,
            2,
            "#c8c0a8"
        )
    end
    local function animTiao(self, c, t, n)
        R(
            nil,
            c,
            120,
            34,
            210,
            1,
            "#e8e8e0"
        )
        do
            local k = 0
            while k < 5 do
                local sw = math.floor(math.sin(t * 2 + k) * 2 + 0.5)
                R(
                    nil,
                    c,
                    136 + k * 40 + sw,
                    35,
                    18,
                    20,
                    __get(
                        __arrL({
                            "#e84a6a",
                            "#4a8ad8",
                            "#f2f2e8",
                            "#f2c24a",
                            "#4ac87a"
                        }, 5),
                        k
                    )
                )
                R(
                    nil,
                    c,
                    136 + k * 40 + sw,
                    35,
                    18,
                    2,
                    "rgba(0,0,0,.15)"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            110,
            160,
            22,
            14,
            "#2a2a2a"
        )
        disco(
            nil,
            c,
            116,
            167,
            4,
            "#5a5a5a"
        )
        R(
            nil,
            c,
            124,
            163,
            6,
            2,
            "#f2c24a"
        )
        R(
            nil,
            c,
            128,
            150,
            1,
            10,
            "#8a8a8a"
        )
        do
            local k = 0
            while k < 3 do
                local u = __mod(t * 0.6 + k / 3, 1)
                c.globalAlpha = 1 - u
                R(
                    nil,
                    c,
                    120 + k * 6 + math.sin(t * 3 + k) * 4,
                    156 - u * 30,
                    3,
                    3,
                    "#f2d24a"
                )
                R(
                    nil,
                    c,
                    122 + k * 6 + math.sin(t * 3 + k) * 4,
                    150 - u * 30,
                    1,
                    6,
                    "#f2d24a"
                )
                k = k + 1
            end
        end
        c.globalAlpha = 1
        local pul = math.abs(math.floor(math.sin(t * 4) * 2 + 0.5))
        R(
            nil,
            c,
            396,
            100 - pul,
            6,
            10,
            "#3ac84a"
        )
        R(
            nil,
            c,
            400,
            98 - pul,
            4,
            4,
            "#3ac84a"
        )
        R(
            nil,
            c,
            403,
            99 - pul,
            2,
            2,
            "#f2c24a"
        )
        R(
            nil,
            c,
            398,
            108 - pul,
            4,
            4,
            "#e84a3a"
        )
        lampada(
            nil,
            c,
            250,
            0,
            22,
            true,
            t
        )
        glow(
            nil,
            c,
            250,
            32,
            110,
            "#ffe0a0",
            0.2 + n * 0.25
        )
    end
    local function salaKelly(self, c)
        parede(
            nil,
            c,
            0,
            0,
            LW,
            GY - 4,
            "#6a4a8a",
            "#8a6aaa",
            "#4a3068",
            37
        )
        piso(
            nil,
            c,
            "#d8c8b8",
            "#c8b8a8",
            "#a89888"
        )
        rodape(nil, c, "#3a2a4a")
        janela(
            nil,
            c,
            370,
            54,
            60,
            42,
            1
        )
        R(
            nil,
            c,
            36,
            120,
            34,
            100,
            "#3a2a4a"
        )
        R(
            nil,
            c,
            39,
            123,
            28,
            97,
            "#f2e0b0"
        )
        R(
            nil,
            c,
            40,
            124,
            26,
            96,
            "#ffeec8"
        )
        R(
            nil,
            c,
            66,
            123,
            6,
            97,
            "#8a3a6a"
        )
        quadro(
            nil,
            c,
            96,
            60,
            30,
            40,
            "#f2f2f2",
            "#1a1a2a",
            function(____, cc, x, y)
                disco(
                    nil,
                    cc,
                    x + 15,
                    y + 14,
                    7,
                    "#6a4028"
                )
                R(
                    nil,
                    cc,
                    x + 7,
                    y + 22,
                    16,
                    14,
                    "#f24a8a"
                )
                R(
                    nil,
                    cc,
                    x + 4,
                    y + 33,
                    22,
                    4,
                    "#f2d24a"
                )
            end
        )
        quadro(
            nil,
            c,
            136,
            52,
            36,
            26,
            "#f2f2f2",
            "#f2d24a",
            function(____, cc, x, y)
                R(
                    nil,
                    cc,
                    x + 4,
                    y + 6,
                    28,
                    4,
                    "#1a1a1a"
                )
                R(
                    nil,
                    cc,
                    x + 4,
                    y + 14,
                    20,
                    3,
                    "#e84a4a"
                )
            end
        )
        R(
            nil,
            c,
            190,
            92,
            50,
            60,
            "#e8d8c8"
        )
        R(
            nil,
            c,
            194,
            96,
            42,
            52,
            "#a8c8d8"
        )
        R(
            nil,
            c,
            196,
            98,
            10,
            40,
            "rgba(255,255,255,.35)"
        )
        R(
            nil,
            c,
            186,
            152,
            58,
            6,
            "#f2f2f2"
        )
        R(
            nil,
            c,
            190,
            158,
            4,
            62,
            "#d8d8d8"
        )
        R(
            nil,
            c,
            236,
            158,
            4,
            62,
            "#d8d8d8"
        )
        do
            local k = 0
            while k < 5 do
                R(
                    nil,
                    c,
                    196 + k * 9,
                    146,
                    4,
                    6,
                    __get(
                        __arrL({
                            "#f24a8a",
                            "#f2d24a",
                            "#4ac8f2",
                            "#f2f2f2",
                            "#c84af2"
                        }, 5),
                        k
                    )
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            262,
            150,
            40,
            70,
            "#1a1a1e"
        )
        R(
            nil,
            c,
            262,
            150,
            40,
            2,
            "#3a3a42"
        )
        disco(
            nil,
            c,
            282,
            172,
            11,
            "#2a2a30"
        )
        disco(
            nil,
            c,
            282,
            202,
            13,
            "#2a2a30"
        )
        R(
            nil,
            c,
            320,
            178,
            130,
            26,
            "#f2f2f2"
        )
        R(
            nil,
            c,
            320,
            190,
            130,
            14,
            "#f28ab8"
        )
        R(
            nil,
            c,
            320,
            204,
            4,
            16,
            "#4a3a5a"
        )
        R(
            nil,
            c,
            446,
            204,
            4,
            16,
            "#4a3a5a"
        )
        R(
            nil,
            c,
            318,
            150,
            6,
            54,
            "#4a3a5a"
        )
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({332, "#c8a07a"}, 2),
                __arrL({348, "#f2f2f2"}, 2),
                __arrL({364, "#f2c24a"}, 2)
            },
            3
        ))) do
            local x = ____value[1]
            local cor = ____value[2]
            disco(
                nil,
                c,
                x,
                172,
                6,
                cor
            )
            disco(
                nil,
                c,
                x - 4,
                166,
                2,
                cor
            )
            disco(
                nil,
                c,
                x + 4,
                166,
                2,
                cor
            )
            R(
                nil,
                c,
                x - 2,
                171,
                1,
                1,
                "#1a1a1a"
            )
            R(
                nil,
                c,
                x + 2,
                171,
                1,
                1,
                "#1a1a1a"
            )
        end
        R(
            nil,
            c,
            300,
            140,
            6,
            8,
            "#f2f2f2"
        )
        R(
            nil,
            c,
            302,
            148,
            1,
            22,
            "#f2f2f2"
        )
        R(
            nil,
            c,
            298,
            168,
            8,
            12,
            "#1a1a2a"
        )
        do
            local x = 240
            while x < 440 do
                R(
                    nil,
                    c,
                    x,
                    GY + 10 + (__mod(x, 4) == 0 and 1 or 0),
                    2,
                    6,
                    __t(__mod(x, 6)) and "#f2b8d8" or "#e8a0c8"
                )
                x = x + 2
            end
        end
    end
    local function animKelly(self, c, t, n)
        do
            local x = 0
            while x < LW do
                local h = __mod(x / 60 + t * 0.6, 1)
                local cor = ("hsl(" .. tostring(math.floor(h * 360 + 0.5))) .. ",90%,60%)"
                R(
                    nil,
                    c,
                    x,
                    10,
                    4,
                    2,
                    cor
                )
                x = x + 4
            end
        end
        glow(
            nil,
            c,
            240,
            12,
            160,
            "#c86ae8",
            0.18
        )
        do
            local k = 0
            while k < 16 do
                local x = 90 + k * 14
                local y = 40 + math.floor(math.sin(k * 0.8) * 4 + 0.5)
                local on = __mod(
                    math.floor(t * 3 + k),
                    3
                )
                R(
                    nil,
                    c,
                    x,
                    y,
                    2,
                    2,
                    __t(on) and "#fff2b8" or "#a89a6a"
                )
                if __t(on) then
                    glow(
                        nil,
                        c,
                        x + 1,
                        y + 1,
                        6,
                        "#ffe08a",
                        0.35
                    )
                end
                k = k + 1
            end
        end
        local b = math.abs(math.sin(t * 9)) > 0.7 and 1 or 0
        disco(
            nil,
            c,
            282,
            172,
            7 + b,
            "#4a4a56"
        )
        disco(
            nil,
            c,
            282,
            202,
            9 + b,
            "#4a4a56"
        )
        disco(
            nil,
            c,
            282,
            172,
            2,
            "#8a8a96"
        )
        disco(
            nil,
            c,
            282,
            202,
            3,
            "#8a8a96"
        )
        R(
            nil,
            c,
            266,
            156,
            3,
            3,
            __t(__mod(
                math.floor(t * 6),
                2
            )) and "#4af24a" or "#1a5a1a"
        )
        if __t(__mod(
            math.floor(t * 0.5),
            2
        )) then
            R(
                nil,
                c,
                299,
                169,
                6,
                10,
                "#6ac8f2"
            )
            glow(
                nil,
                c,
                302,
                174,
                10,
                "#6ac8f2",
                0.3
            )
        end
        lampada(
            nil,
            c,
            240,
            12,
            18,
            false,
            t
        )
    end
    local SALAS = __ord(
        {
            casa_dalva = __arrL({salaDalva, animDalva}, 2),
            casa_tiao = __arrL({salaTiao, animTiao}, 2),
            casa_kelly = __arrL({salaKelly, animKelly}, 2)
        },
        "casa_dalva,casa_tiao,casa_kelly"
    )
    local fixos = {}
    local tela = nil
    local tctx = nil
    local function degradeNasPontas(self, c)
        local faixas = 12
        local largura = 64
        do
            local i = 0
            while i < faixas do
                local a = (1 - i / faixas) ^ 1.4
                local x = i * (largura / faixas)
                local w = largura / faixas
                c.globalAlpha = a
                R(
                    nil,
                    c,
                    x,
                    0,
                    w,
                    LH,
                    "#000"
                )
                R(
                    nil,
                    c,
                    LW - x - w,
                    0,
                    w,
                    LH,
                    "#000"
                )
                c.globalAlpha = a * 0.6
                do
                    local y = __mod(i, 2)
                    while y < LH do
                        R(
                            nil,
                            c,
                            x + w,
                            y,
                            1,
                            1,
                            "#000"
                        )
                        R(
                            nil,
                            c,
                            LW - x - w - 1,
                            y,
                            1,
                            1,
                            "#000"
                        )
                        y = y + 2
                    end
                end
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 6 do
                c.globalAlpha = (1 - i / 6) * 0.6
                R(
                    nil,
                    c,
                    0,
                    i * 3,
                    LW,
                    3,
                    "#000"
                )
                i = i + 1
            end
        end
        c.globalAlpha = 1
    end
    local function desenhar(self, ctx, id, t)
        local s = __get(SALAS, id)
        if not __t(s) then
            return false
        end
        if not __t(__get(fixos, id)) then
            local cv, c = table.unpack(
                mk(nil, LW, LH),
                1,
                2
            )
            __get(s, 0)(nil, c)
            __set(fixos, id, cv)
        end
        if not __t(tela) then
            do
                do
                    __O[1344] = __iter(mk(nil, LW, LH))
                    tela = __get(__O[1344], 0)
                end
                tctx = __get(__O[1344], 1)
            end
            local ____ = __O[1344]
        end
        local n = noite(nil)
        tctx.globalAlpha = 1
        tctx.globalCompositeOperation = "source-over"
        tctx:clearRect(0, 0, LW, LH)
        tctx:drawImage(
            __get(fixos, id),
            0,
            0
        )
        local ____get_result_53 = __get(s, 1)
        local ____tctx_52 = tctx
        local ____t_result_51
        local ____t_50 = __t
        local ____TS__Number_result_49 = __TS__Number(t)
        __O[1345] = ____TS__Number_result_49
        if ____t_50(____TS__Number_result_49) then
            ____t_result_51 = __O[1345]
        else
            ____t_result_51 = 0
        end
        ____get_result_53(nil, ____tctx_52, ____t_result_51, n)
        if n > 0 then
            tctx.globalAlpha = n * 0.25
            R(
                nil,
                tctx,
                0,
                0,
                LW,
                LH,
                "#0a0a20"
            )
            tctx.globalAlpha = 1
        end
        degradeNasPontas(nil, tctx)
        ctx:save()
        ctx.imageSmoothingEnabled = false
        ctx:drawImage(
            tela,
            0,
            0,
            LW * 2,
            LH * 2
        )
        ctx:restore()
        return true
    end
    local function portas(self, ctx, cena, t)
        if cena ~= CENA then
            return
        end
        for ____, c in __iterar((__values(CASAS))) do
            local x = c.x
            local base = 440
            ctx:save()
            local ____ctx_57 = ctx
            local ____t_result_56
            local ____t_55 = __t
            local ____TS__Number_result_54 = __TS__Number(t)
            __O[1346] = ____TS__Number_result_54
            if ____t_55(____TS__Number_result_54) then
                ____t_result_56 = __O[1346]
            else
                ____t_result_56 = 0
            end
            ____ctx_57.globalAlpha = 0.55 + 0.1 * math.sin(____t_result_56 * 3 + x)
            ctx.fillStyle = "#ffd88a"
            ctx:fillRect(x + 6, base - 58, 6, 56)
            ctx.globalAlpha = 0.18
            ctx.fillStyle = "#ffd88a"
            ctx:fillRect(x - 4, base - 2, 34, 4)
            ctx.globalAlpha = 1
            ctx.fillStyle = "#8a3a2a"
            ctx:fillRect(x - 18, base - 2, 36, 4)
            ctx.fillStyle = "#c8a24a"
            ctx:fillRect(x - 16, base - 1, 32, 1)
            ctx:restore()
        end
    end
    local function nomeDe(____, id)
        local ____t_result_61
        local ____t_60 = __t
        local ____opt_58 = __get(CASAS, id)
        if ____opt_58 ~= nil then
            ____opt_58 = ____opt_58.nome
        end
        __O[1347] = ____opt_58
        if ____t_60(____opt_58) then
            ____t_result_61 = __O[1347]
        else
            ____t_result_61 = ""
        end
        return ____t_result_61
    end
    local function npcDe(____, id)
        local ____t_result_65
        local ____t_64 = __t
        local ____opt_62 = __get(CASAS, id)
        if ____opt_62 ~= nil then
            ____opt_62 = ____opt_62.npc
        end
        __O[1348] = ____opt_62
        if ____t_64(____opt_62) then
            ____t_result_65 = __O[1348]
        else
            ____t_result_65 = ""
        end
        return ____t_result_65
    end
    local function falante(____, id, norm)
        local n = __call(
            __re_replace(
                __call(
                    npcDe(nil, id),
                    "normalize",
                    "NFD"
                ),
                __re("[̀-ͯ]", "g"),
                ""
            ),
            "toLowerCase"
        )
        local ____t_result_68
        local ____t_67 = __t
        local ____temp_66 = not not __t(n)
        __O[1349] = ____temp_66
        if ____t_67(____temp_66) then
            ____t_result_68 = __call(
                norm,
                "includes",
                __re_replace(
                    n,
                    __re("^(dona|seu) ", ""),
                    ""
                )
            )
        else
            ____t_result_68 = __O[1349]
        end
        return ____t_result_68
    end
    window.FavelaCasas = __ord(
        {
            CASAS = CASAS,
            ehCasa = ehCasa,
            falar = falar,
            desenhar = desenhar,
            portas = portas,
            nome = nomeDe,
            nomeNpc = npcDe,
            morador = function(____, id)
                local ____t_result_72
                local ____t_71 = __t
                local ____opt_69 = __get(CASAS, id)
                if ____opt_69 ~= nil then
                    ____opt_69 = ____opt_69.morador
                end
                __O[1350] = ____opt_69
                if ____t_71(____opt_69) then
                    ____t_result_72 = __O[1350]
                else
                    ____t_result_72 = nil
                end
                return ____t_result_72
            end,
            falante = falante,
            LENDAS = LENDAS
        },
        "CASAS,ehCasa,falar,desenhar,portas,nome,nomeNpc,morador,falante,LENDAS"
    )
end)(nil)
return ____exports
