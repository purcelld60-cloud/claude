--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __ge, __getq, __mod, __ord, __arrL, __iterar, __t, __get, __arr, __len, __call = __JSR.__lt, __JSR.__ge, __JSR.__getq, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__arr, __JSR.__len, __JSR.__call
local __add, __iter, __assign, __hypot, __re, __re_test = __JSR.__add, __JSR.__iter, __JSR.__assign, __JSR.__hypot, __JSR.__re, __JSR.__re_test
local ____lualib = require(script.Parent.lualib_bundle)
local Map = ____lualib.Map
local __TS__New = ____lualib.__TS__New
local __TS__Spread = ____lualib.__TS__Spread
local __TS__Number = ____lualib.__TS__Number
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__MathSign = ____lualib.__TS__MathSign
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local combate = window.ConquistaCombate
    local function P(____, c, x, y, w, h, cor)
        c.fillStyle = cor
        c:fillRect(
            math.floor(x + 0.5),
            math.floor(y + 0.5),
            math.floor(w + 0.5),
            math.floor(h + 0.5)
        )
    end
    local tinta = "#221d31"
    local branco = "#fff4d8"
    local desenhos = __ord(
        {
            jornal = __arrL({"#737988 #e1ddc7 #fff3ce #c34853", "..########## .#333333332# #3334444332# #3322233222# #3313133312# #3313131312# .#222222222# ..##########"}, 2),
            pregador = __arrL({"#7c563f #cf9763 #ffe1a2 #88929c", "...###.### ...#3#.#2# ...#3#.#2# ...#33#22# ....#343# ....#244# ....#232# ...#32#22# ...#32#22# ...###.###"}, 2),
            fone = __arrL({"#714263 #b9608b #ffb6c5 #543b5e", "..#######. .#3322222# #322###222# #32#...#22# #22#...#11# .###....###"}, 2),
            pneu = __arrL({"#384358 #566373 #bdc3ae #d68c3e", "...######... ..#323232#.. .#22244222#. #3224##4222# #224#33#422# #224#33#422# #2224##4223# .#22244222#. ..#232323#.. ...######..."}, 2),
            capacete = __arrL({"#925433 #e77e37 #ffe098 #365268", "...######... ..#332222#.. .#33222222#. #3224444444# #2224443334# #2222444444# .#2222211#.. ..#11111#... ...#####...."}, 2),
            rolo = __arrL({"#965c39 #d19963 #ffe3a5 #6b4131", "....########.... ...#33333332#... ####32222222#### #44323232322244# ####21111111#### ...##########..."}, 2),
            forma = __arrL({"#5b687a #91a2aa #e4dcab #b57d47", "..##########.. .#3333333333#. #234434434432# #234434434432# #322222222222# .#1111111111#. ..##########.."}, 2),
            carimbo = __arrL({"#664b42 #b37446 #ffe3aa #ab4b4a", "...######... ..#332222#.. ..#222222#.. ...#2222#... ....#11#.... ..##2222##.. .#33333332#. #4444444444# .##########."}, 2),
            voto = __arrL({"#57417a #a576c8 #f4e5fd #5bbcca", "..########... .#33333332#.. #3222222222#. #3222222222#. .#222222222#. ..###222###.. .....##......"}, 2),
            tesoura = __arrL({"#9c4557 #cb6473 #e6eadb #76939c", ".......###... ....###33#... .###333##.... #222####..... #2#24#....... .##224###.... #2#2#.433##.. #222#..##33## .###.....####"}, 2),
            camera = __arrL({"#36435f #617688 #e0eece #ef6569", "....####..... ...#3333#.### .########.#3# #22332222#33# #22442222#23# #22442222#2## #22222222#... .########...."}, 2),
            gota = __arrL({"#346d79 #67b7bb #d7f3cf #719daa", ".....#.... ....#2#... ....#3#... ...#32#... ..#3322#.. .#332222#. #32222222# #22222112# .#211112#. ..######.."}, 2),
            moenda = __arrL({"#594c47 #936b51 #deb27e #a5b0a1", "....##..##.... ..##22##22##.. .#2333222232#. #232222422223# #222244442222# .#2241144222#. #222244442222# #222222222223# .#2222222122#. ..##22##22##.. ....##..##...."}, 2),
            rodo = __arrL({"#714c39 #a7724d #eac797 #466661", ".........###.. ........#32#.. .......#32#... ......#32#.... .....#32#..... .###########.. #33333333332#. #44444444444#. .###########.."}, 2),
            roteiro = __arrL({"#967b65 #ddc69f #fff2ca #ba555e", "..########. .#33333332# #334443332# #333333332# #311313332# #333313112# #311333332# .#23223232# ..##.##.##."}, 2),
            mascara = __arrL({"#874558 #c87c76 #ffdda4 #4b3852", "########### #322222223# #334222433# #344424443# #322222222# .#3244422#. .#2422242#. ..#22222#.. ...#211#... ....###...."}, 2),
            lustre = __arrL({"#7f5a46 #c79057 #ffdc87 #ecad5f", ".....###..... .....#2#..... .#...#2#...#. #3#..#2#..#3# #4#.#33#..#4# .#222222222#. ..##22222##.. ....#333#.... .....###....."}, 2),
            tecla = __arrL({"#365368 #708ba0 #c6f5db #5bd4c3", "..########.. .#33333332#. #3222222222# #3222222222# #3222222222# .#211111112# ..##########"}, 2),
            invasor = __arrL({"#31536b #63cbaa #b4ffcd #df88b5", "..#.....#.. ...#...#... ..#22222#.. .#2242422#. #332222233# #2#22222#2# #2#.....#2# ...##.##..."}, 2),
            cartucho = __arrL({"#66526d #938099 #facedb #58baa8", "..#########. .#333333332# #2233333222# #2244444222# #2243344222# #2244444222# #2222222212# .#13131313#. ..#########."}, 2),
            convite = __arrL({"#83616c #d39b96 #ffdeaf #ab5466", "############ #3222222223# #3322222232# #2233223322# #2223443222# #2233443322# #3322222232# ############"}, 2),
            pulseira = __arrL({"#97664a #d69c5a #ffe0a3 #db7c98", "...#######... ..#3434343#.. .#34#####43#. #34#.....#43# #43#.....#34# #34#.....#43# .#43#####34#. ..#3434343#.. ...#######..."}, 2),
            broche = __arrL({"#9e6740 #dbad56 #ffeab0 #bb6272", "....###.... ..##323##.. .#3322233#. #322333222# #322232222# .#2222222#. ..##323##.. ..#44#44#.. .#44#.#44#. .###...###."}, 2),
            tenis = __arrL({"#63546a #de9b64 #fff0af #a86251", "....#####... ...#22223#.. ..#224433#.. .#2234433##. #2222222222# #3333333333# .##########."}, 2),
            coracao = __arrL({"#8c4464 #d76883 #ffd2b6 #4b3c63", ".###..###. #332##222# #33224222# #22242222# .#222422#. ..#2422#.. ...#42#... ....##...."}, 2),
            vitral = __arrL({"#4768a0 #73bad0 #d7fff0 #c098da", ".....#..... ....#3#.... ...#324#... ..#32244#.. .#3224444#. #332244444# .#3224444#. ..#32444#.. ...#324#... ....#2#.... .....#....."}, 2),
            audio = __arrL({"#914176 #ef82ae #fff1d8 #694371", "..##########. .#3333333333# #322222222223# #323232323223# #323232323223# .#3333333333#. ..##2#######. ..##........."}, 2),
            balao = __arrL({"#934370 #ef8fb8 #ffefda #753255", "..##########. .#3333333333# #333333333333# #334334334333# #334334334333# .#3333333333#. ..###22#####. ....#2#...... ....##......."}, 2),
            moto = __arrL({"#783b30 #f58326 #ffeea7 #91bbbd", "..............###..... ..........####33#..... ...#####..#22#.##..... ...#111#####22#4#..... ....#22222222#44##.... ..####2222221142###... .#444#22211###44444#.. #44114#11##..#41114#.. #414114#..#..#41414#.. .#4444#.......#4444#.. ..####.........####..."}, 2),
            recibo = __arrL({"#a58457 #efd6a0 #fff4d6 #c86531", "..########.. ..#333333#.. ..#344443#.. ..#333333#.. ..#311133#.. ..#311313#.. ..#333333#.. ..#344443#.. ..#232323#.. ..##.#.##..."}, 2),
            cone = __arrL({"#ac4527 #f48031 #fff1ca #d4592a", "....##.... ...#22#... ...#33#... ..#3333#.. ..#2222#.. .#222222#. #11111111#"}, 2),
            biscoito = __arrL({"#aa6d37 #e9b65c #ffe8a0 #c88d4d", "...######... ..#322223#.. .#32244223#. #322#..#222# #322....222# #222....242# #242#..#222# .#22222221#. ..#211121#.. ...######..."}, 2),
            saco = __arrL({"#97724e #dcb584 #fff0bd #a15132", "...#2#2#... ....#4#.... ...#222#... ..#33322#.. .#3332222#. #222344322# #223444322# #223443222# #222222221# .#1111111#. ..#######.."}, 2),
            prato = __arrL({"#72645a #b0b9ad #fff1ae #bd8d43", ".....###..... .....#2#..... ....#...#.... ...#.....#... ..#.......#.. .#.........#. #33333333333# .#222222222#. ..#1111111#.. ...#######..."}, 2),
            like = __arrL({"#9c315d #f14f85 #ffd9c8 #dc3c78", "..###..###.. .#332##222#. #3322222222# #3222222222# .#22222221#. ..#222221#.. ...#2221#... ....#21#.... .....##....."}, 2),
            grao = __arrL({"#673e2b #9a6037 #f5c479 #65322f", "....#####... ..##33222#.. .#33224222#. #3222422222# #3224422222# #2224222221# .#24222221#. ..#222221#.. ...######..."}, 2),
            bule = __arrL({"#315276 #639d9d #ffe294 #d79043", ".....####...... ....#3333#..... .##.######.###. #22#333222#..2# .#22333222#..2# ..#2332222###2# ...#222222#..## ...#222244#.... ....#1144#..... .....####......"}, 2),
            peso = __arrL({"#573e52 #8b7180 #f4b763 #e07943", "....###.... ....#2#.... ...#333#... ..#22222#.. .#2222222#. #244222442# #224424422# #222444222# #222242221# .#1111111#. ..#######.."}, 2),
            tabua = __arrL({"#84462e #b77341 #ffd087 #62404a", "..############.. .#332222222222#. #44422211222444# .#222222222221#. ..############.."}, 2),
            luva = __arrL({"#833545 #ef644e #ffb980 #fcda88", "....######.. ..##322322#. .#322222222# #3322222222# #32222222##. .#22222221#. ..#111111#.. ..#444444#.. ...######..."}, 2),
            controle1 = __arrL({"#17525b #30b9c5 #bbfff1 #fbdb72", "...###..###... ..#222##222#.. .#3332222222#. #222322224422# #223332242422# #222322224422# #2211####1122# .###......###."}, 2),
            controle2 = __arrL({"#6b3c76 #db6eb2 #ffcee2 #8ef4f0", "...###..###... ..#222##222#.. .#3332222222#. #222322224422# #223332242422# #222322224422# #2211####1122# .###......###."}, 2),
            plug1 = __arrL({"#214d68 #54b8c8 #d1fff2 #ffbd6c", "..#########. ..#3333333#. ##22244222## #2222222222# ##111111111# ..##44####.. ...####....."}, 2),
            plug2 = __arrL({"#754465 #dc74ae #ffe3ec #a6f6ed", "..#########. ..#3333333#. ##22244222## #2222222222# ##111111111# ..##44####.. ...####....."}, 2),
            pao = __arrL({"#9c5d32 #eaa655 #ffe19a #d18c46", "....####.... ..##3333##.. .#33323332#. #3322233322# #3322224222# #2224222242# .#22222221#. ..#111111#.. ...######..."}, 2),
            pente = __arrL({"#644051 #ad5572 #ffda8a #f7a85d", "..###########. .#33333333333# #222222222222# .#2#2#2#2#2##. .#2#2#2#2#2#.. .#2#2#2#2#2#.. .#.#.#.#.#.#.."}, 2),
            palma = __arrL({"#a46d44 #e9a85c #ffe0a3 #ed8d52", ".....##...... ...###3###... ..#32#3#32##. ..#32#3#32#2# ..#3222222#2# ##.222222222# #32#22222222# .#3222222221# ..#22222221#. ...#211111#.. ....######..."}, 2),
            bilhete = __arrL({"#7c88a1 #adc2d5 #fff1d4 #ca727b", "###########. #3333333322# #3344443322# #3333333322# #3311113322# #3333333322# #3322222222# .##########."}, 2),
            carteira = __arrL({"#805233 #ba8250 #f7ce80 #a7bfbd", "..##########. .#333333333# #3333333333# .#22222222## ..####4##4#. ...#..4##4.. ...#..4##4.. ...##.4##4.. ....##4##4.. ......##.##."}, 2),
            giz = __arrL({"#658c83 #a8cbb1 #f7ffdb #669b8f", "..###########. .#33333333333# #222222222223# .############."}, 2),
            borracha = __arrL({"#844e70 #ce6995 #ffc7c1 #778da9", "....#########.. ...#333222222#. ..#3332222221#. .#3332222221##. #4444444411##.. .#44444441##... ..#########...."}, 2),
            telefone = __arrL({"#4c4268 #8d78c2 #e7d7ff #7ef1c5", "...######... ..#233332#.. ..#111111#.. ..#144441#.. ..#143341#.. ..#144441#.. ..#111111#.. ..#143341#.. ..#111111#.. ..#223322#.. ...######..."}, 2),
            passagem = __arrL({"#66567f #c6a1ce #fff1cb #85516f", "..###########. .#33333333332# #343444344332# .#33333333332# #344434433332# .#33333333332# ..###########."}, 2)
        },
        "jornal,pregador,fone,pneu,capacete,rolo,forma,carimbo,voto,tesoura,camera,gota,moenda,rodo,roteiro,mascara,lustre,tecla,invasor,cartucho,convite,pulseira,broche,tenis,coracao,vitral,audio,balao,moto,recibo,cone,biscoito,saco,prato,like,grao,bule,peso,tabua,luva,controle1,controle2,plug1,plug2,pao,pente,palma,bilhete,carteira,giz,borracha,telefone,passagem"
    )
    local cache = __TS__New(Map)
    local function imagem(self, chave)
        if __t(__call(cache, "has", chave)) then
            return __call(cache, "get", chave)
        end
        local paleta, mapa = table.unpack(
            __get(desenhos, chave),
            1,
            2
        )
        local linhas = __call(mapa, "split", " ")
        local cores = __arr(
            tinta,
            __TS__Spread(__iter(__call(paleta, "split", " ")))
        )
        local img = window.document:createElement("canvas")
        img.width = math.max(__TS__Spread(__iter(__call(
            linhas,
            "map",
            function(____, l) return __len(l) end
        ))))
        img.height = __len(linhas)
        local q = img:getContext("2d")
        __call(
            linhas,
            "forEach",
            function(____, l, y)
                do
                    local x = 0
                    while __lt(
                        x,
                        __len(l)
                    ) do
                        if __get(l, x) ~= "." then
                            P(
                                nil,
                                q,
                                x,
                                y,
                                1,
                                1,
                                __get(
                                    cores,
                                    __get(l, x) == "#" and 0 or __TS__Number(__get(l, x))
                                )
                            )
                        end
                        x = x + 1
                    end
                end
            end
        )
        __call(cache, "set", chave, img)
        return img
    end
    local function selo(self, c, chave, x, y, w, h, dir)
        if dir == nil then
            dir = 1
        end
        local img = imagem(nil, chave)
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        c:scale(dir, 1)
        c.imageSmoothingEnabled = false
        c:drawImage(
            img,
            -math.floor(w / 2 + 0.5),
            -math.floor(h / 2 + 0.5),
            w,
            h
        )
        c:restore()
    end
    local function texto(self, c, s, x, y, cor, px)
        if px == nil then
            px = 12
        end
        c:save()
        c.textAlign = "center"
        c.textBaseline = "middle"
        c.font = __add(
            __add("bold ", px),
            "px monospace"
        )
        c.lineWidth = 3
        c.strokeStyle = tinta
        c:strokeText(s, x, y)
        c.fillStyle = cor
        c:fillText(s, x, y)
        c:restore()
    end
    local function cantos(self, c, x, y, w, h, cor, ponta)
        if ponta == nil then
            ponta = 9
        end
        for ____, dx in __iterar((__arrL({-1, 1}, 2))) do
            for ____, dy in __iterar((__arrL({-1, 1}, 2))) do
                local ex = x + dx * w / 2
                local ey = y + dy * h / 2
                local ____c_1 = c
                local ____temp_0
                if dx > 0 then
                    ____temp_0 = ponta
                else
                    ____temp_0 = 0
                end
                P(
                    nil,
                    ____c_1,
                    ex - ____temp_0,
                    ey,
                    ponta,
                    3,
                    cor
                )
                local ____c_3 = c
                local ____temp_2
                if dy > 0 then
                    ____temp_2 = ponta
                else
                    ____temp_2 = 0
                end
                P(
                    nil,
                    ____c_3,
                    ex,
                    ey - ____temp_2,
                    3,
                    ponta,
                    cor
                )
            end
        end
    end
    local function risco(self, c, pts, cor, grossura)
        if grossura == nil then
            grossura = 3
        end
        c:beginPath()
        __call(
            pts,
            "forEach",
            function(____, ____bindingPattern0, i)
                local y
                local x
                x = ____bindingPattern0[1]
                y = ____bindingPattern0[2]
                local ____t_result_4
                if __t(i) then
                    ____t_result_4 = c:lineTo(
                        math.floor(x + 0.5),
                        math.floor(y + 0.5)
                    )
                else
                    ____t_result_4 = c:moveTo(
                        math.floor(x + 0.5),
                        math.floor(y + 0.5)
                    )
                end
                return ____t_result_4
            end
        )
        c.strokeStyle = cor
        c.lineWidth = grossura
        c:stroke()
    end
    local function retrato(self, c, x, y, w, h, lado)
        if lado == nil then
            lado = 0
        end
        c:save()
        c:translate(x, y)
        c:scale(w / 50, h / 44)
        if __t(lado) then
            c:beginPath()
            c:moveTo(0, -22)
            c:lineTo(-3, -12)
            c:lineTo(2, -4)
            c:lineTo(-2, 4)
            c:lineTo(2, 12)
            c:lineTo(0, 22)
            c:lineTo(lado * 25, 22)
            c:lineTo(lado * 25, -22)
            c:closePath()
            c:clip()
        end
        P(
            nil,
            c,
            -25,
            -22,
            50,
            44,
            tinta
        )
        P(
            nil,
            c,
            -23,
            -20,
            46,
            40,
            "#fff0cf"
        )
        P(
            nil,
            c,
            -20,
            -17,
            40,
            29,
            "#dfae7d"
        )
        P(
            nil,
            c,
            -20,
            5,
            40,
            7,
            "#9b8261"
        )
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({-13, "#c68453", "#71a774"}, 3),
                __arrL({0, "#89593e", "#8ea4d1"}, 3),
                __arrL({13, "#c99167", "#aa7aa5"}, 3)
            },
            3
        ))) do
            local bx = ____value[1]
            local pele = ____value[2]
            local roupa = ____value[3]
            P(
                nil,
                c,
                bx - 5,
                2,
                10,
                9,
                roupa
            )
            P(
                nil,
                c,
                bx - 4,
                -9,
                8,
                11,
                pele
            )
            P(
                nil,
                c,
                bx - 4,
                -10,
                8,
                3,
                "#4c3840"
            )
        end
        P(
            nil,
            c,
            -20,
            -10,
            14,
            2,
            "#926c46"
        )
        P(
            nil,
            c,
            -17,
            -13,
            8,
            4,
            "#d9af6f"
        )
        P(
            nil,
            c,
            -12,
            15,
            24,
            1,
            "#b9987e"
        )
        c:restore()
    end
    local function movel(self, c, o, p, t, cor)
        local ____p_5 = p
        local x = ____p_5.x
        local y = ____p_5.y
        local dir = __ge(o.x1, o.x0) and 1 or -1
        local w = o.rx * 2
        local h = o.ry * 2
        local ____t_7 = __t
        local ____t_result_6
        if __t(o.corpo) then
            ____t_result_6 = o.corpo
        else
            ____t_result_6 = o.art == "motoTonhao"
        end
        if ____t_7(____t_result_6) then
            return
        end
        if o.art == "farpa" then
            P(
                nil,
                c,
                x - o.rx,
                y - 14,
                w,
                25,
                tinta
            )
            P(
                nil,
                c,
                x - o.rx + 2,
                y - 12,
                w - 4,
                21,
                "#722e51"
            )
            P(
                nil,
                c,
                x - o.rx + 3,
                y - 12,
                w - 6,
                2,
                "#f6b2bd"
            )
            risco(
                nil,
                c,
                __arrL(
                    {
                        __arrL({x - o.rx + 8, y + 10}, 2),
                        __arrL({x - o.rx + 8, y + 16}, 2),
                        __arrL({x - o.rx + 15, y + 10}, 2)
                    },
                    3
                ),
                "#722e51",
                4
            )
            texto(
                nil,
                c,
                o.palavra,
                x,
                y - 1,
                "#fff1df",
                12
            )
            return
        end
        if __t(o.art == "metade1" or o.art == "metade2") then
            local lado = o.art == "metade1" and -1 or 1
            retrato(
                nil,
                c,
                x - lado * w / 2,
                y,
                w * 2,
                h,
                lado
            )
            return
        end
        if __t(o.art == "peso" or o.art == "prato") then
            risco(
                nil,
                c,
                __arrL(
                    {
                        __arrL({x, y - h / 2}, 2),
                        __arrL({x + 2, y - 52}, 2),
                        __arrL({x + 2, o.y0 - 33}, 2)
                    },
                    3
                ),
                "#3e3037",
                3
            )
            if o.art == "prato" then
                risco(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x - 15, y - 7}, 2),
                            __arrL({x, y - 31}, 2),
                            __arrL({x + 15, y - 7}, 2)
                        },
                        3
                    ),
                    "#e4c78f",
                    2
                )
            end
        end
        if __re_test(
            __re("^(controle|plug)", ""),
            o.art
        ) then
            local cabo = __arrL({}, 0)
            do
                local i = 0
                while i <= 12 do
                    local q = i / 12
                    __call(
                        cabo,
                        "push",
                        __arrL(
                            {
                                o.x0 + (x - o.x0) * q,
                                o.y0 + (y - o.y0) * q + 18 * math.sin(q * math.pi) + 4 * math.sin(6 * q + t * 5) * math.sin(q * math.pi)
                            },
                            2
                        )
                    )
                    i = i + 1
                end
            end
            risco(
                nil,
                c,
                cabo,
                tinta,
                4
            )
            risco(
                nil,
                c,
                cabo,
                __t(__call(o.art, "endsWith", "2")) and "#ee85b9" or "#5fcbd1",
                2
            )
        end
        if __t(o.art == "pneu" or o.art == "moenda") then
            c:save()
            c:translate(
                math.floor(x + 0.5),
                math.floor(y + 0.5)
            )
            c:rotate(math.floor(dir * t * 24 + 0.5) * math.pi / 12)
            selo(
                nil,
                c,
                o.art,
                0,
                0,
                w,
                h
            )
            c:restore()
            return
        end
        if o.art == "lustre" then
            risco(
                nil,
                c,
                __arrL(
                    {
                        __arrL(
                            {
                                __add(o.x0, o.x1) / 2,
                                o.y0 - 64
                            },
                            2
                        ),
                        __arrL({x, y - h / 2}, 2)
                    },
                    2
                ),
                "#d6ac80",
                3
            )
        end
        selo(
            nil,
            c,
            o.art,
            x,
            y,
            w,
            h,
            dir
        )
        if __t(o.art == "tecla" or o.art == "voto") then
            local ____texto_10 = texto
            local ____c_9 = c
            local ____t_result_8
            if __t(o.letra) then
                ____t_result_8 = o.letra
            else
                ____t_result_8 = "ESC"
            end
            ____texto_10(
                nil,
                ____c_9,
                ____t_result_8,
                x,
                y - 1,
                branco,
                11
            )
        end
        if o.art == "moto" then
            do
                local i = 1
                while i <= 4 do
                    P(
                        nil,
                        c,
                        x - dir * (32 + i * 8),
                        y + 12 - __mod(i, 2) * 4,
                        6,
                        3,
                        __t(__mod(i, 2)) and "#efd6a4" or "#8b7974"
                    )
                    i = i + 1
                end
            end
        elseif __t(o.art == "audio" or o.art == "telefone") then
            for ____, s in __iterar((__arrL({-1, 1}, 2))) do
                local q = x + s * (w / 2 + 4)
                risco(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({q, y - 6}, 2),
                            __arrL({q + s * 3, y - 3}, 2),
                            __arrL({q + s * 3, y + 3}, 2),
                            __arrL({q, y + 6}, 2)
                        },
                        4
                    ),
                    cor,
                    2
                )
            end
        elseif o.art == "borracha" then
            do
                local i = 1
                while i <= 4 do
                    P(
                        nil,
                        c,
                        x - dir * (23 + i * 8),
                        y + __mod(i, 2) * 4,
                        6,
                        2,
                        "#f4c4bb"
                    )
                    i = i + 1
                end
            end
        elseif o.art == "bule" then
            do
                local i = 0
                while i < 3 do
                    risco(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({x - 8 + i * 7, y - 13}, 2),
                                __arrL({x - 10 + i * 7, y - 19}, 2),
                                __arrL(
                                    {
                                        x - 7 + i * 7,
                                        y - 22 - __mod(i, 2) * 3
                                    },
                                    2
                                )
                            },
                            3
                        ),
                        "#f9dbac",
                        2
                    )
                    i = i + 1
                end
            end
        end
    end
    local function zona(self, c, o, u, cor)
        local x = o.x0
        local bot = __add(o.y0, o.ry)
        local top = o.y0 - o.ry
        local w = o.rx * 2
        local h = o.ry * 2
        local l = x - o.rx
        local pulsa = math.sin(math.pi * u)
        P(
            nil,
            c,
            l,
            bot - 4,
            w,
            4,
            cor
        )
        cantos(
            nil,
            c,
            x,
            o.y0,
            w - 2,
            h - 3,
            cor,
            7
        )
        c:save()
        c.globalAlpha = c.globalAlpha * (0.14 + 0.1 * pulsa)
        P(
            nil,
            c,
            l,
            top,
            w,
            h,
            cor
        )
        c:restore()
        repeat
            local ____switch49 = o.art
            local ____cond49 = ____switch49 == "fratura"
            if ____cond49 then
                do
                    local k = -2
                    while k <= 2 do
                        risco(
                            nil,
                            c,
                            __arrL(
                                {
                                    __arrL({x + k * w * 0.17 - 3, bot}, 2),
                                    __arrL(
                                        {
                                            x + k * w * 0.17,
                                            top - 3 - math.sin(u * math.pi) * 7
                                        },
                                        2
                                    ),
                                    __arrL({x + k * w * 0.17 + 4, bot}, 2)
                                },
                                3
                            ),
                            "#ffe3a7",
                            2
                        )
                        k = k + 1
                    end
                end
                break
            end
            ____cond49 = ____cond49 or ____switch49 == "blitz"
            if ____cond49 then
                do
                    local k = -1
                    while k <= 1 do
                        selo(
                            nil,
                            c,
                            "cone",
                            x + k * w * 0.31,
                            bot - 18,
                            25,
                            34
                        )
                        k = k + 1
                    end
                end
                do
                    local k = 0
                    while k < 7 do
                        local dx = l + k * w / 7
                        local y = top + 8 + math.sin(u * 12 + k * 0.65) * 3
                        P(
                            nil,
                            c,
                            dx,
                            y,
                            w / 7 + 1,
                            7,
                            __t(__mod(k, 2)) and "#473940" or "#ffce72"
                        )
                        k = k + 1
                    end
                end
                break
            end
            ____cond49 = ____cond49 or ____switch49 == "oleo"
            if ____cond49 then
                P(
                    nil,
                    c,
                    l + 5,
                    bot - 9,
                    w - 10,
                    7,
                    "#302d44"
                )
                P(
                    nil,
                    c,
                    l + 13,
                    bot - 14,
                    w - 27,
                    6,
                    "#50455f"
                )
                do
                    local i = 0
                    while i < 4 do
                        local salto = __mod(u * 1.7 + i * 0.25, 1)
                        local dx = l + 12 + i * w * 0.19
                        P(
                            nil,
                            c,
                            dx,
                            bot - 10 - __mod(i, 2) * 4,
                            9,
                            2,
                            __t(__mod(i, 2)) and "#a1a9b7" or "#947e9c"
                        )
                        local yy = bot - 9 - 4 * salto * (1 - salto) * (h - 11)
                        P(
                            nil,
                            c,
                            dx + 9 * salto,
                            yy,
                            5,
                            6,
                            "#413b53"
                        )
                        P(
                            nil,
                            c,
                            dx + 9 * salto,
                            yy,
                            3,
                            2,
                            "#afa3b8"
                        )
                        i = i + 1
                    end
                end
                break
            end
            ____cond49 = ____cond49 or ____switch49 == "vapor"
            if ____cond49 then
                selo(
                    nil,
                    c,
                    "forma",
                    x,
                    bot - 5,
                    w * 0.92,
                    13
                )
                do
                    local i = 0
                    while i < 3 do
                        local xx = x + (i - 1) * 13
                        risco(
                            nil,
                            c,
                            __arrL(
                                {
                                    __arrL({xx, bot - 9}, 2),
                                    __arrL({xx - 5, bot - h * 0.32}, 2),
                                    __arrL({xx + 4, bot - h * 0.59}, 2),
                                    __arrL({xx - 3, top + 7 + i * 3}, 2)
                                },
                                4
                            ),
                            __t(__mod(i, 2)) and "#ecc998" or "#ffead1",
                            4
                        )
                        i = i + 1
                    end
                end
                break
            end
            ____cond49 = ____cond49 or ____switch49 == "janela"
            if ____cond49 then
                do
                    local y = top + 5
                    local aba = math.max(
                        5,
                        math.floor(w * (0.25 - 0.17 * pulsa) + 0.5)
                    )
                    P(
                        nil,
                        c,
                        l,
                        y,
                        w,
                        5,
                        "#753f50"
                    )
                    P(
                        nil,
                        c,
                        l + 2,
                        y + 6,
                        aba,
                        h * 0.54,
                        "#91566f"
                    )
                    P(
                        nil,
                        c,
                        l + w - aba - 2,
                        y + 6,
                        aba,
                        h * 0.54,
                        "#91566f"
                    )
                    do
                        local i = 0
                        while i < 4 do
                            P(
                                nil,
                                c,
                                l + 4,
                                y + 10 + i * 9,
                                aba - 3,
                                2,
                                "#ffbeaa"
                            )
                            P(
                                nil,
                                c,
                                l + w - aba,
                                y + 10 + i * 9,
                                aba - 3,
                                2,
                                "#ffbeaa"
                            )
                            i = i + 1
                        end
                    end
                    selo(
                        nil,
                        c,
                        "balao",
                        x,
                        top + h * 0.48,
                        38,
                        28
                    )
                    texto(
                        nil,
                        c,
                        "PSIU!",
                        x,
                        bot - 19,
                        "#ffeacb",
                        12
                    )
                    break
                end
            end
            ____cond49 = ____cond49 or ____switch49 == "farinha"
            if ____cond49 then
                do
                    local i = 0
                    while i < 11 do
                        local a = i * math.pi / 10
                        local r = 0.45 + 0.55 * pulsa
                        P(
                            nil,
                            c,
                            x + math.cos(a) * o.rx * r - 4,
                            bot - math.sin(a) * (h - 7) * r,
                            8,
                            7,
                            __t(__mod(i, 2)) and "#ffeac4" or "#dbb688"
                        )
                        i = i + 1
                    end
                end
                break
            end
            ____cond49 = ____cond49 or ____switch49 == "visor"
            if ____cond49 then
                do
                    cantos(
                        nil,
                        c,
                        x,
                        o.y0,
                        w - 9,
                        h - 10,
                        "#dafbff",
                        14
                    )
                    P(
                        nil,
                        c,
                        l + 9,
                        top + 11,
                        6,
                        6,
                        "#ff5262"
                    )
                    texto(
                        nil,
                        c,
                        "REC",
                        l + 27,
                        top + 15,
                        branco,
                        10
                    )
                    local y = top + 9 + (h - 20) * u
                    P(
                        nil,
                        c,
                        l + 6,
                        y,
                        w - 12,
                        3,
                        "#a6f4ff"
                    )
                    P(
                        nil,
                        c,
                        x - 8,
                        o.y0,
                        16,
                        2,
                        "#defbff"
                    )
                    P(
                        nil,
                        c,
                        x,
                        o.y0 - 7,
                        2,
                        14,
                        "#defbff"
                    )
                    break
                end
            end
            ____cond49 = ____cond49 or ____switch49 == "cafeeiro"
            if ____cond49 then
                do
                    local alto = h * (0.7 + 0.3 * pulsa)
                    risco(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({x, bot}, 2),
                                __arrL({x - 5, bot - alto * 0.3}, 2),
                                __arrL({x + 3, bot - alto * 0.63}, 2),
                                __arrL({x, bot - alto}, 2)
                            },
                            4
                        ),
                        "#614631",
                        6
                    )
                    do
                        local i = 1
                        while i <= 5 do
                            local s = __t(__mod(i, 2)) and 1 or -1
                            local yy = bot - i * alto / 6
                            risco(
                                nil,
                                c,
                                __arrL(
                                    {
                                        __arrL({x, yy + 8}, 2),
                                        __arrL({x + s * 12, yy}, 2),
                                        __arrL({x + s * (o.rx - 6), yy - 9}, 2)
                                    },
                                    3
                                ),
                                "#477746",
                                4
                            )
                            P(
                                nil,
                                c,
                                x + s * 14 - 5,
                                yy - 8,
                                12,
                                6,
                                "#86b75b"
                            )
                            P(
                                nil,
                                c,
                                x + s * 8 - 3,
                                yy + 2,
                                6,
                                7,
                                "#e6744e"
                            )
                            P(
                                nil,
                                c,
                                x + s * 16 - 3,
                                yy - 10,
                                5,
                                4,
                                "#fde5a0"
                            )
                            i = i + 1
                        end
                    end
                    break
                end
            end
            ____cond49 = ____cond49 or ____switch49 == "refletor"
            if ____cond49 then
                c:save()
                c.fillStyle = "#ffdf8673"
                c:beginPath()
                c:moveTo(x - 8, top + 10)
                c:lineTo(x + 8, top + 10)
                c:lineTo(l + w - 1, bot)
                c:lineTo(l + 1, bot)
                __call(c, "fill")
                c:restore()
                P(
                    nil,
                    c,
                    x - 15,
                    top,
                    30,
                    12,
                    tinta
                )
                P(
                    nil,
                    c,
                    x - 10,
                    top + 9,
                    20,
                    5,
                    "#ffdf81"
                )
                P(
                    nil,
                    c,
                    l + 6,
                    bot - 9,
                    w - 12,
                    3,
                    "#fff0a9"
                )
                break
            end
            ____cond49 = ____cond49 or ____switch49 == "cortina"
            if ____cond49 then
                do
                    local i = 0
                    while i < 6 do
                        local ww = w / 6
                        P(
                            nil,
                            c,
                            l + i * ww,
                            top,
                            ww,
                            h - 8 + __mod(i, 2) * 7,
                            __t(__mod(i, 2)) and "#b93e54" or "#872c45"
                        )
                        P(
                            nil,
                            c,
                            l + i * ww + 2,
                            top,
                            2,
                            h - 13,
                            "#e47772"
                        )
                        i = i + 1
                    end
                end
                P(
                    nil,
                    c,
                    l,
                    top,
                    w,
                    7,
                    "#edb86e"
                )
                break
            end
            ____cond49 = ____cond49 or ____switch49 == "checkpoint"
            if ____cond49 then
                risco(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x - 13, bot - 3}, 2),
                            __arrL({x - 13, top + 14}, 2)
                        },
                        2
                    ),
                    "#8ae6db",
                    4
                )
                P(
                    nil,
                    c,
                    x - 11,
                    top + 14,
                    27,
                    22,
                    "#2b6268"
                )
                do
                    local i = 0
                    while i < 3 do
                        P(
                            nil,
                            c,
                            x - 10 + i * 9,
                            top + 17 + __mod(i, 2) * 8,
                            8,
                            8,
                            "#9bf5dd"
                        )
                        i = i + 1
                    end
                end
                texto(
                    nil,
                    c,
                    "2P",
                    x,
                    bot - 18,
                    "#ffd3fd"
                )
                break
            end
            ____cond49 = ____cond49 or ____switch49 == "palma"
            if ____cond49 then
                selo(
                    nil,
                    c,
                    "palma",
                    x,
                    o.y0,
                    w * 0.78,
                    h * 0.68
                )
                for ____, s in __iterar((__arrL({-1, 1}, 2))) do
                    risco(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({x + s * 17, top + 12}, 2),
                                __arrL({x + s * 24, top + 5}, 2)
                            },
                            2
                        ),
                        "#fff0ad",
                        3
                    )
                end
                break
            end
            ____cond49 = ____cond49 or ____switch49 == "lousa"
            if ____cond49 then
                P(
                    nil,
                    c,
                    l + 4,
                    top + 4,
                    w - 8,
                    h - 10,
                    "#835c46"
                )
                P(
                    nil,
                    c,
                    l + 8,
                    top + 8,
                    w - 16,
                    h - 19,
                    "#285854"
                )
                do
                    local i = 0
                    while i < 3 do
                        local y = top + 25 + i * 20
                        risco(
                            nil,
                            c,
                            __arrL(
                                {
                                    __arrL({l + 15, y}, 2),
                                    __arrL({x - 5, y - 3}, 2),
                                    __arrL({x + 9, y + 1}, 2),
                                    __arrL({l + w - 14, y - 3}, 2)
                                },
                                4
                            ),
                            "#c6dfa9",
                            2
                        )
                        i = i + 1
                    end
                end
                P(
                    nil,
                    c,
                    l + 11,
                    bot - 13,
                    w - 22,
                    3,
                    "#f0c18d"
                )
                break
            end
            ____cond49 = ____cond49 or ____switch49 == "revelacao"
            if ____cond49 then
                retrato(
                    nil,
                    c,
                    x,
                    o.y0,
                    w * 0.88,
                    h * 0.58
                )
                for ____, s in __iterar((__arrL({-1, 1}, 2))) do
                    do
                        local i = 0
                        while i < 6 do
                            P(
                                nil,
                                c,
                                x + s * (o.rx - 5) - 2,
                                top + 8 + i * (h - 18) / 6,
                                4,
                                7,
                                "#f4d191"
                            )
                            i = i + 1
                        end
                    end
                end
                break
            end
            ____cond49 = ____cond49 or ____switch49 == "sinal"
            if ____cond49 then
                do
                    selo(
                        nil,
                        c,
                        "telefone",
                        x,
                        top + 29,
                        28,
                        42
                    )
                    local pts = __arrL({}, 0)
                    do
                        local i = 0
                        while i <= 12 do
                            __call(
                                pts,
                                "push",
                                __arrL(
                                    {
                                        l + 4 + (w - 8) * i / 12,
                                        bot - 28 - math.abs(math.sin(i * 1.7 + u * 5)) * (h * 0.33)
                                    },
                                    2
                                )
                            )
                            i = i + 1
                        end
                    end
                    risco(
                        nil,
                        c,
                        pts,
                        "#dfbaff",
                        4
                    )
                    texto(
                        nil,
                        c,
                        "TRIO",
                        x,
                        bot - 13,
                        "#ffdda6"
                    )
                    break
                end
            end
        until true
    end
    local function aviso(self, c, o, cor, pct)
        if o.art == "fratura" then
            return
        end
        if __t(o.area) then
            local w = o.rx * 2
            local h = o.ry * 2
            cantos(
                nil,
                c,
                o.x0,
                o.y0,
                w,
                h,
                cor
            )
            P(
                nil,
                c,
                o.x0 - o.rx,
                __add(o.y0, o.ry) - 4,
                w,
                4,
                tinta
            )
            P(
                nil,
                c,
                o.x0 - o.rx,
                __add(o.y0, o.ry) - 4,
                w * pct,
                3,
                cor
            )
            for ____, lado in __iterar((__arrL({-1, 1}, 2))) do
                local x = o.x0 + lado * (o.rx - 3)
                local y = __add(o.y0, o.ry) - 11
                risco(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x - lado * 8, y - 4}, 2),
                            __arrL({x, y}, 2),
                            __arrL({x - lado * 8, y + 4}, 2)
                        },
                        3
                    ),
                    tinta,
                    5
                )
                risco(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x - lado * 8, y - 4}, 2),
                            __arrL({x, y}, 2),
                            __arrL({x - lado * 8, y + 4}, 2)
                        },
                        3
                    ),
                    cor,
                    2
                )
            end
            if o.art == "visor" then
                P(
                    nil,
                    c,
                    o.x0 - o.rx + 7,
                    o.y0 - o.ry + 8,
                    5,
                    5,
                    "#ff5b74"
                )
                texto(
                    nil,
                    c,
                    "REC",
                    o.x0 - o.rx + 25,
                    o.y0 - o.ry + 11,
                    cor,
                    9
                )
            end
            return
        end
        do
            local i = 1
            while i <= 8 do
                local pt = combate:ponto(o, i / 9)
                P(
                    nil,
                    c,
                    pt.x - 2,
                    pt.y - 2,
                    4,
                    4,
                    tinta
                )
                P(
                    nil,
                    c,
                    pt.x - 1,
                    pt.y - 1,
                    3,
                    2,
                    cor
                )
                i = i + 1
            end
        end
        local ____t_12 = __t
        local ____t_result_11
        if __t(o.corpo) then
            ____t_result_11 = o.corpo
        else
            ____t_result_11 = o.art == "motoTonhao"
        end
        if ____t_12(____t_result_11) then
            local ____add_15 = __add
            local ____o_y1_14 = o.y1
            local ____t_result_13
            if __t(o.corpo) then
                ____t_result_13 = o.corpo
            else
                ____t_result_13 = 14
            end
            local pe = ____add_15(____o_y1_14, ____t_result_13)
            for ____, lado in __iterar((__arrL({-1, 1}, 2))) do
                risco(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({o.x1 + lado * 9, pe - 2}, 2),
                            __arrL({o.x1 + lado * 23, pe - 2}, 2),
                            __arrL({o.x1 + lado * 28, pe - 8}, 2)
                        },
                        3
                    ),
                    cor,
                    3
                )
            end
            return
        end
        local vertical = math.abs(o.x1 - o.x0) < 20
        if __t(vertical) then
            cantos(
                nil,
                c,
                o.x1,
                o.y1,
                o.rx * 2,
                math.min(15, o.ry * 2),
                cor,
                5
            )
        else
            local s = __TS__MathSign(o.x1 - o.x0)
            risco(
                nil,
                c,
                __arrL(
                    {
                        __arrL({o.x1 - s * 7, o.y1 - 4}, 2),
                        __arrL({o.x1, o.y1}, 2),
                        __arrL({o.x1 - s * 7, o.y1 + 4}, 2)
                    },
                    3
                ),
                cor,
                2
            )
        end
        local pos = combate:ponto(o, 0)
        c:save()
        c.globalAlpha = c.globalAlpha * 0.65
        movel(
            nil,
            c,
            o,
            pos,
            0,
            cor
        )
        c:restore()
    end
    local function virada(self, c, f)
        local cap = combate:capitulo(f)
        local t = f.tempo / f.dur
        local a = math.min(1, t * 6, (1 - t) * 5)
        if __t(not __t(cap) or a <= 0) then
            return
        end
        local x = math.max(
            f.l + 100,
            math.min(f.r - 100, f.x)
        )
        local y = f.piso - 183
        c:save()
        c.globalAlpha = c.globalAlpha * a
        c:translate(
            math.floor(x + 0.5),
            math.floor(y - 7 * math.sin(t * math.pi) + 0.5)
        )
        if __get(cap, 1) == "foto" then
            retrato(
                nil,
                c,
                0,
                0,
                102,
                82
            )
        elseif __get(cap, 1) == "telefone" then
            P(
                nil,
                c,
                -38,
                -56,
                76,
                100,
                tinta
            )
            P(
                nil,
                c,
                -35,
                -53,
                70,
                93,
                "#58486e"
            )
            P(
                nil,
                c,
                -30,
                -43,
                60,
                70,
                "#241e38"
            )
            for ____, s in __iterar((__arrL({-1, 1}, 2))) do
                P(
                    nil,
                    c,
                    s * 12 - 6,
                    -29,
                    12,
                    4,
                    "#a171df"
                )
                P(
                    nil,
                    c,
                    s * 12 - 2,
                    -26,
                    6,
                    3,
                    "#e8b2ff"
                )
            end
            texto(
                nil,
                c,
                "ITABUNA",
                0,
                -3,
                "#fff0c9",
                11
            )
            P(
                nil,
                c,
                -10,
                13,
                20,
                4,
                "#84d3ac"
            )
            P(
                nil,
                c,
                -6,
                32,
                12,
                3,
                "#d9bfd8"
            )
            for ____, s in __iterar((__arrL({-1, 1}, 2))) do
                local d = 45 + __mod(
                    math.floor(t * 10),
                    3
                )
                risco(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({s * d, -19}, 2),
                            __arrL({s * (d + 5), -11}, 2),
                            __arrL({s * (d + 5), 4}, 2),
                            __arrL({s * d, 11}, 2)
                        },
                        4
                    ),
                    __get(cap, 2),
                    3
                )
            end
        else
            selo(
                nil,
                c,
                __get(cap, 1),
                0,
                0,
                56,
                49
            )
        end
        texto(
            nil,
            c,
            __get(cap, 0),
            0,
            63,
            __get(cap, 2),
            14
        )
        c:restore()
    end
    local function impacto(self, c, slug, m, cor)
        local u = m.idade / 0.28
        local d = 5 + 17 * u
        c:save()
        c:translate(
            math.floor(m.x + 0.5),
            math.floor(m.y + 0.5)
        )
        c.globalAlpha = c.globalAlpha * (1 - u)
        repeat
            local ____switch107 = slug
            local ____cond107 = ____switch107 == "creuza"
            if ____cond107 then
                for ____, s in __iterar((__arrL({-1, 1}, 2))) do
                    risco(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({s * d, -10}, 2),
                                __arrL({s * (d + 4), -6}, 2),
                                __arrL({s * (d + 4), 3}, 2),
                                __arrL({s * d, 7}, 2)
                            },
                            4
                        ),
                        cor,
                        2
                    )
                end
                break
            end
            ____cond107 = ____cond107 or ____switch107 == "tonhao"
            if ____cond107 then
                do
                    local i = -2
                    while i <= 2 do
                        risco(
                            nil,
                            c,
                            __arrL(
                                {
                                    __arrL({i * d / 2 - 2, -4}, 2),
                                    __arrL(
                                        {
                                            i * d / 2 + 2,
                                            -9 - __mod(i, 2) * 3
                                        },
                                        2
                                    )
                                },
                                2
                            ),
                            __t(__mod(i, 2)) and "#ffc77d" or "#775c56",
                            3
                        )
                        i = i + 1
                    end
                end
                break
            end
            ____cond107 = ____cond107 or (____switch107 == "valdomiro" or ____switch107 == "fred")
            if ____cond107 then
                do
                    local i = 0
                    while i < 6 do
                        local a = (i + 0.5) * math.pi / 6
                        P(
                            nil,
                            c,
                            math.cos(a) * d,
                            -math.sin(a) * d,
                            4 + __mod(i, 2),
                            3,
                            __t(__mod(i, 2)) and "#fbd693" or "#ac784e"
                        )
                        i = i + 1
                    end
                end
                if __t(slug == "fred" and m.art ~= "pao") then
                    risco(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({-d, -9}, 2),
                                __arrL({-5, -3}, 2),
                                __arrL({0, -10}, 2),
                                __arrL({6, -4}, 2),
                                __arrL({d, -12}, 2)
                            },
                            5
                        ),
                        "#eb9c94",
                        2
                    )
                end
                break
            end
            ____cond107 = ____cond107 or ____switch107 == "kaua"
            if ____cond107 then
                cantos(
                    nil,
                    c,
                    0,
                    -5,
                    18 + u * 28,
                    15 + u * 21,
                    "#c3fbff",
                    5
                )
                P(
                    nil,
                    c,
                    -5,
                    -6,
                    10,
                    2,
                    "#fff2d5"
                )
                break
            end
            ____cond107 = ____cond107 or ____switch107 == "barao"
            if ____cond107 then
                for ____, s in __iterar((__arrL({-1, 1}, 2))) do
                    risco(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({s * d, -1}, 2),
                                __arrL({s * (d - 4), -7}, 2),
                                __arrL({s * (d + 1), -14}, 2)
                            },
                            3
                        ),
                        "#f1d4a4",
                        2
                    )
                    P(
                        nil,
                        c,
                        s * d - 4,
                        -8,
                        7,
                        3,
                        "#a4bf6c"
                    )
                end
                break
            end
            ____cond107 = ____cond107 or ____switch107 == "breno"
            if ____cond107 then
                for ____, s in __iterar((__arrL({-1, 1}, 2))) do
                    risco(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({s * 3, -1}, 2),
                                __arrL({s * (d - 3), -9}, 2),
                                __arrL({s * (d - 6), -3}, 2),
                                __arrL({s * (d + 5), -13}, 2)
                            },
                            4
                        ),
                        "#ffca8d",
                        3
                    )
                end
                break
            end
            ____cond107 = ____cond107 or ____switch107 == "gemeos"
            if ____cond107 then
                do
                    local i = 0
                    while i < 4 do
                        P(
                            nil,
                            c,
                            (i - 1.5) * d * 0.7,
                            -7 + __mod(i, 2) * 7,
                            7 - i,
                            3,
                            "#69e4d5"
                        )
                        P(
                            nil,
                            c,
                            (i - 1.5) * d * 0.7 + 3,
                            -4 + __mod(i, 2) * 7,
                            5,
                            2,
                            "#f28abf"
                        )
                        i = i + 1
                    end
                end
                break
            end
            ____cond107 = ____cond107 or ____switch107 == "jorge"
            if ____cond107 then
                if __t(__call(
                    __arrL({
                        "metade1",
                        "metade2",
                        "revelacao",
                        "passagem",
                        "bilhete"
                    }, 5),
                    "includes",
                    m.art
                )) then
                    for ____, s in __iterar((__arrL({-1, 1}, 2))) do
                        P(
                            nil,
                            c,
                            s * d - 4,
                            -7 - u * 4,
                            8,
                            5,
                            "#ffe1b6"
                        )
                        P(
                            nil,
                            c,
                            s * d - 2,
                            -4 - u * 4,
                            6,
                            2,
                            "#bc9a93"
                        )
                    end
                else
                    for ____, s in __iterar((__arrL({-1, 1}, 2))) do
                        risco(
                            nil,
                            c,
                            __arrL(
                                {
                                    __arrL({s * 3, -5}, 2),
                                    __arrL({s * 8, -13}, 2),
                                    __arrL({s * 11, -3}, 2),
                                    __arrL({s * d, -8}, 2)
                                },
                                4
                            ),
                            cor,
                            2
                        )
                    end
                end
                break
            end
        until true
        c:restore()
    end
    local function fundo(self, c, f)
        if __t(f.slug ~= "jorge" or f.fase ~= 5) then
            return
        end
        local mid = __add(f.l, f.r) / 2
        local y = f.piso - 235
        c:save()
        c.globalAlpha = c.globalAlpha * 0.72
        local d = 11 + 4 * math.sin(f.idade * 0.8)
        retrato(
            nil,
            c,
            mid - d,
            y,
            68,
            55,
            -1
        )
        retrato(
            nil,
            c,
            mid + d,
            y,
            68,
            55,
            1
        )
        for ____, lado in __iterar((__arrL({-1, 1}, 2))) do
            local pts = __arrL({}, 0)
            do
                local i = 0
                while i <= 16 do
                    __call(
                        pts,
                        "push",
                        __arrL(
                            {
                                mid + lado * (43 + i * 8),
                                y + 4 * math.sin(i * 0.9 - f.idade * 2) * math.sin(i * math.pi / 16)
                            },
                            2
                        )
                    )
                    i = i + 1
                end
            end
            risco(
                nil,
                c,
                pts,
                "#d4abea",
                2
            )
        end
        c:restore()
    end
    local function personagem(self, c, f, tipo, x, y, o)
        local dir = __lt(o.facing, 0) and -1 or 1
        local ____f_tempo_17 = f.tempo
        local ____t_result_16
        if __t(f.dur) then
            ____t_result_16 = f.dur
        else
            ____t_result_16 = 1
        end
        local u = math.min(1, ____f_tempo_17 / ____t_result_16)
        local ____temp_18
        if f.estado == "windup" then
            ____temp_18 = u * u
        else
            ____temp_18 = 0
        end
        local carga = ____temp_18
        local ____temp_19
        if f.estado == "firing" then
            ____temp_19 = math.sin(math.min(1, u * 2.1) * math.pi)
        else
            ____temp_19 = 0
        end
        local golpe = ____temp_19
        local ____temp_20
        if f.estado == "recover" then
            ____temp_20 = math.sin(u * math.pi) * 0.028
        else
            ____temp_20 = 0
        end
        local repouso = ____temp_20
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        c:scale(1 + carga * 0.055 - golpe * 0.035, 1 - carga * 0.085 + golpe * 0.052 - repouso)
        c:rotate(dir * (golpe * 0.095 - carga * 0.06))
        local ____self_29 = window.Art
        local ____self_29_drawCharacter_30 = ____self_29.drawCharacter
        local ____c_27 = c
        local ____tipo_28 = tipo
        local ____assign_26 = __assign
        local ____temp_24 = {}
        local ____o_25 = o
        local ____f_idade_22 = f.idade
        local ____temp_23 = carga > 0 or golpe > 0
        local ____t_result_21
        if __t(carga) then
            ____t_result_21 = carga * 0.24
        else
            ____t_result_21 = 0.25 + golpe * 0.72
        end
        ____self_29_drawCharacter_30(
            ____self_29,
            ____c_27,
            ____tipo_28,
            0,
            0,
            ____assign_26(____temp_24, ____o_25, {frame = ____f_idade_22, attack = ____temp_23, attackProgress = ____t_result_21})
        )
        c:restore()
    end
    local function desenhar(self, c, f)
        if not __t(f) then
            return
        end
        c:save()
        c.imageSmoothingEnabled = false
        local ____t_result_33
        local ____t_32 = __t
        local ____getq_result_31 = __getq(
            combate:capitulo(f),
            2
        )
        __O[940] = ____getq_result_31
        if ____t_32(____getq_result_31) then
            ____t_result_33 = __O[940]
        else
            ____t_result_33 = __get(combate.chefes, f.slug).cor
        end
        local cor = ____t_result_33
        if f.estado == "phaseChange" then
            virada(nil, c, f)
        end
        for ____, o in __iterar((f.objetos)) do
            do
                local ativa = f.estado == "firing"
                local ____t_result_34
                if __t(ativa) then
                    ____t_result_34 = f.tempo - o.atraso
                else
                    ____t_result_34 = f.tempo - f.dur - o.atraso
                end
                local rel = ____t_result_34
                local ____t_37 = __t
                local ____t_result_36
                if __t(o.fim) then
                    ____t_result_36 = o.fim
                else
                    local ____temp_35
                    if f.estado == "windup" then
                        ____temp_35 = f.dur
                    else
                        ____temp_35 = 0
                    end
                    ____t_result_36 = rel < -math.max(0.76, ____temp_35)
                end
                if ____t_37(____t_result_36) then
                    continue
                end
                if __t(not __t(ativa) or rel < 0) then
                    aviso(
                        nil,
                        c,
                        o,
                        cor,
                        math.max(
                            0,
                            math.min(
                                1,
                                1 + rel / (__t(ativa) and 0.76 or f.dur)
                            )
                        )
                    )
                    continue
                end
                local u = math.min(1, rel / o.dur)
                if __t(o.area) then
                    zona(
                        nil,
                        c,
                        o,
                        u,
                        cor
                    )
                else
                    local p = combate:ponto(o, u)
                    local ____t_41 = __t
                    local ____t_result_40
                    local ____t_39 = __t
                    local ____temp_38 = not __t(o.corpo) and o.art ~= "motoTonhao"
                    __O[941] = ____temp_38
                    if ____t_39(____temp_38) then
                        ____t_result_40 = u > 0.02
                    else
                        ____t_result_40 = __O[941]
                    end
                    if ____t_41(____t_result_40) then
                        local a = combate:ponto(
                            o,
                            math.max(0, u - 0.035 / o.dur)
                        )
                        local dx = p.x - a.x
                        local dy = p.y - a.y
                        local comprimento = __hypot(dx, dy)
                        if comprimento > 6 then
                            local s = math.min(17, comprimento) / comprimento
                            risco(
                                nil,
                                c,
                                __arrL(
                                    {
                                        __arrL({p.x - dx * s, p.y - dy * s}, 2),
                                        __arrL({p.x, p.y}, 2)
                                    },
                                    2
                                ),
                                cor,
                                2
                            )
                        end
                    end
                    movel(
                        nil,
                        c,
                        o,
                        p,
                        u,
                        cor
                    )
                end
            end
        end
        for ____, m in __iterar((f.marcas)) do
            impacto(
                nil,
                c,
                f.slug,
                m,
                cor
            )
        end
        c:restore()
    end
    window.ConquistaEfeitos = __ord({desenhar = desenhar, fundo = fundo, personagem = personagem}, "desenhar,fundo,personagem")
end)(nil)
return ____exports
