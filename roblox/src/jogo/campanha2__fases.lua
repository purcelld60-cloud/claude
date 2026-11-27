--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __le, __gt, __ge, __getq, __mod, __ord, __arrL, __iterar, __t, __get, __len = __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__getq, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__len
local __setlen, __call, __add, __keys, __assign, __shr, __hypot, __getters = __JSR.__setlen, __JSR.__call, __JSR.__add, __JSR.__keys, __JSR.__assign, __JSR.__shr, __JSR.__hypot, __JSR.__getters
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__MathSign = ____lualib.__TS__MathSign
local __TS__Number = ____lualib.__TS__Number
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    if __t(window.CampanhaFases) then
        return
    end
    local FLOOR = 440
    local TAU = math.pi * 2
    local function clamp(____, v, a, b)
        return math.max(
            a,
            math.min(b, v)
        )
    end
    local function rnd(____, a, b)
        return a + math.random() * (b - a)
    end
    local function PW()
        return window.CampanhaPoderes
    end
    local function txt(____, c, s, x, y, col, o)
        local ____opt_4 = window.CampanhaCamadas
        if ____opt_4 ~= nil then
            ____opt_4 = ____opt_4.kit
        end
        local ____opt_result_6
        if ____opt_4 ~= nil then
            ____opt_result_6 = ____opt_4.pxText
        end
        local ____opt_result_7
        if ____opt_result_6 ~= nil then
            ____opt_result_7 = ____opt_result_6(
                ____opt_4,
                c,
                s,
                x,
                y,
                col,
                o
            )
        end
        return ____opt_result_7
    end
    local function reg(____, id, spec)
        local ____opt_10 = window.CampanhaPersonagens
        if ____opt_10 ~= nil then
            ____opt_10 = ____opt_10.registrar
        end
        local ____opt_result_12
        if ____opt_10 ~= nil then
            ____opt_result_12 = ____opt_10(____opt_10, id, spec, "inimigo")
        end
        return ____opt_result_12
    end
    reg(
        nil,
        "c2i_vizinha",
        __ord(
            {
                name = "Vizinha fofoqueira",
                skin = "#d9a57f",
                shade = "#ac7856",
                build = "normal",
                h = 0.92,
                top = "#8ab8e0",
                topKind = "robe",
                robeDots = "#d8ecf8",
                pants = "#8ab8e0",
                hair = __ord({style = "curlers", color = "#4a2e22", curler = "#f0a0c0"}, "style,color,curler"),
                item = "phone",
                pose = "phone"
            },
            "name,skin,shade,build,h,top,topKind,robeDots,pants,hair,item,pose"
        )
    )
    reg(
        nil,
        "c2i_vizinha2",
        __ord(
            {
                name = "Vizinha fofoqueira",
                skin = "#b07a52",
                shade = "#82563a",
                build = "belly",
                h = 0.9,
                top = "#c8a0e0",
                topKind = "robe",
                robeDots = "#ead8f6",
                pants = "#c8a0e0",
                hair = __ord({style = "curlers", color = "#2a1d16", curler = "#7cc7d8"}, "style,color,curler"),
                item = "phone",
                pose = "phone"
            },
            "name,skin,shade,build,h,top,topKind,robeDots,pants,hair,item,pose"
        )
    )
    reg(
        nil,
        "c2i_motoca",
        __ord(
            {
                name = "Mototaxista",
                skin = "#a96f48",
                shade = "#7c4f33",
                build = "normal",
                top = "#3a3f44",
                topKind = "vest",
                vest = "#f08a24",
                vestBand = "#e8f06a",
                pants = "#2a3038",
                hat = __ord({kind = "helmet", color = "#2c5a9e", visor = "#2a3a46"}, "kind,color,visor"),
                item = "keys",
                pose = "hips"
            },
            "name,skin,shade,build,top,topKind,vest,vestBand,pants,hat,item,pose"
        )
    )
    reg(
        nil,
        "c2i_feirante",
        __ord(
            {
                name = "Feirante",
                skin = "#c48a60",
                shade = "#956445",
                build = "normal",
                top = "#c84a3a",
                topKind = "apron",
                apron = "#e9dcc0",
                pants = "#4f4a3e",
                hat = __ord({kind = "cap", color = "#3c8a5a"}, "kind,color"),
                hair = __ord({style = "short", color = "#2a1d16"}, "style,color"),
                item = "biscuit",
                pose = "offer"
            },
            "name,skin,shade,build,top,topKind,apron,pants,hat,hair,item,pose"
        )
    )
    reg(
        nil,
        "c2i_seguidor",
        __ord(
            {
                name = "Seguidor do Kauã",
                skin = "#e9c2a3",
                shade = "#bb9275",
                build = "slim",
                top = "#2a2c34",
                topKind = "puffer",
                pants = "#3a4252",
                hair = __ord({style = "quiff", color = "#1a1410", tips = "#c8d8ff"}, "style,color,tips"),
                shades = true,
                item = "selfie",
                pose = "selfie"
            },
            "name,skin,shade,build,top,topKind,pants,hair,shades,item,pose"
        )
    )
    reg(
        nil,
        "c2i_jagunco",
        __ord(
            {
                name = "Capanga do Barão",
                skin = "#b98258",
                shade = "#8a5c3c",
                build = "strong",
                top = "#e8e0d0",
                topKind = "vest",
                vest = "#5a3a24",
                vestBand = "#7a5236",
                pants = "#3c2f26",
                hat = __ord({kind = "rancher", color = "#8a6a3c", band = "#2c1e14"}, "kind,color,band"),
                mustache = "#2a1d16",
                pose = "fists",
                mood = "angry"
            },
            "name,skin,shade,build,top,topKind,vest,vestBand,pants,hat,mustache,pose,mood"
        )
    )
    reg(
        nil,
        "c2i_valentao",
        __ord(
            {
                name = "Valentão do Teatro",
                skin = "#a96f48",
                shade = "#7c4f33",
                build = "strong",
                top = "#3a1f26",
                topKind = "tank",
                pants = "#22262c",
                hair = __ord({style = "buzz", color = "#1b1714"}, "style,color"),
                chain = "#c9ccc4",
                pose = "fists",
                mood = "angry"
            },
            "name,skin,shade,build,top,topKind,pants,hair,chain,pose,mood"
        )
    )
    reg(
        nil,
        "c2i_gamer",
        __ord(
            {
                name = "Gamer da LAN",
                skin = "#e9c2a3",
                shade = "#bb9275",
                build = "slim",
                top = "#3a7a5a",
                topKind = "hoodie",
                inner = "#1d2a26",
                pants = "#25303f",
                hair = __ord({style = "fringe", color = "#4a3020"}, "style,color"),
                headset = "#20262c",
                item = "pad",
                pose = "game"
            },
            "name,skin,shade,build,top,topKind,inner,pants,hair,headset,item,pose"
        )
    )
    reg(
        nil,
        "c2i_aluno",
        __ord(
            {
                name = "Turma do Fred",
                skin = "#d9a57f",
                shade = "#ac7856",
                build = "slim",
                top = "#2c5a9e",
                topKind = "tee",
                sleeve = "short",
                print = "#f2f2ee",
                pants = "#2a3442",
                hair = __ord({style = "wavy", color = "#2a1d16"}, "style,color"),
                pose = "cocky"
            },
            "name,skin,shade,build,top,topKind,sleeve,print,pants,hair,pose"
        )
    )
    reg(
        nil,
        "c2i_aluna",
        __ord(
            {
                name = "Turma do Fred",
                skin = "#b07a52",
                shade = "#82563a",
                build = "slim",
                h = 0.95,
                top = "#2c5a9e",
                topKind = "tee",
                sleeve = "short",
                print = "#f2f2ee",
                skirt = "#2a3442",
                hair = __ord({style = "ponytail", color = "#1e1512"}, "style,color"),
                item = "phone",
                pose = "phone"
            },
            "name,skin,shade,build,h,top,topKind,sleeve,print,skirt,hair,item,pose"
        )
    )
    local AVES = __ord(
        {
            pombo = __arrL({
                "#8a9096",
                "#b8bec4",
                "#c86a5a",
                "#e8833a",
                1,
                16
            }, 6),
            urubu = __arrL({
                "#1c1a1a",
                "#3a3636",
                "#c86a5a",
                "#d8c8a0",
                1.5,
                9
            }, 6),
            maritaca = __arrL({
                "#3c9a3a",
                "#7ad05a",
                "#3c9a3a",
                "#e8c24c",
                1,
                18
            }, 6),
            morcego = __arrL({
                "#3a2a4a",
                "#5a4a6a",
                "#3a2a4a",
                "#ff5a5a",
                1.2,
                20
            }, 6)
        },
        "pombo,urubu,maritaca,morcego"
    )
    local function drone(self, c, x, y, t, dir, hit)
        local function R(____, a, b, w, h, col)
            c.fillStyle = col
            c:fillRect(
                math.floor(a + 0.5),
                math.floor(b + 0.5),
                w,
                h
            )
        end
        R(
            nil,
            x - 14,
            y - 4,
            28,
            8,
            "#120e0e"
        )
        R(
            nil,
            x - 12,
            y - 3,
            24,
            6,
            if __t(hit) then "#ffffff" else "#3a3f48"
        )
        R(
            nil,
            x - 4,
            y - 2,
            8,
            4,
            if __t(__mod(
                math.floor(t * 6),
                2
            )) then "#ff3a3a" else "#5ae0ff"
        )
        for ____, sx in __iterar((__arrL({-14, 14}, 2))) do
            R(
                nil,
                x + sx - 1,
                y - 8,
                2,
                5,
                "#120e0e"
            )
            local w = math.abs(math.sin(t * 40)) * 10 + 2
            R(
                nil,
                x + sx - w / 2,
                y - 9,
                w,
                2,
                "#c8ccd0"
            )
        end
    end
    local function ave(self, c, x, y, t, tipo, dir, hit)
        if tipo == "drone" then
            return drone(
                nil,
                c,
                x,
                y,
                t,
                dir,
                hit
            )
        end
        local ____t_14 = __t
        local ____get_result_13 = __get(AVES, tipo)
        __O[924] = ____get_result_13
        local A = if ____t_14(____get_result_13) then __O[924] else AVES.pombo
        local urubu = tipo == "urubu"
        local function R(____, a, b, w, h, col)
            c.fillStyle = col
            c:fillRect(
                math.floor(a + 0.5),
                math.floor(b + 0.5),
                w,
                h
            )
        end
        local asa = math.sin(t * __get(A, 5)) > 0
        local s = __get(A, 4)
        local corpo = if __t(hit) then "#ffffff" else __get(A, 0)
        local claro = __get(A, 1)
        c:save()
        c:translate(x, y)
        c:scale(dir * s, s)
        R(
            nil,
            -8,
            -4,
            15,
            7,
            "#120e0e"
        )
        R(
            nil,
            -7,
            -3,
            13,
            5,
            corpo
        )
        R(
            nil,
            -6,
            -3,
            8,
            2,
            claro
        )
        R(
            nil,
            5,
            -7,
            6,
            6,
            "#120e0e"
        )
        R(
            nil,
            6,
            -6,
            4,
            4,
            if __t(urubu) then __get(A, 2) else corpo
        )
        R(
            nil,
            8,
            -5,
            1,
            1,
            if tipo == "morcego" then "#ff5a5a" else "#000"
        )
        R(
            nil,
            10,
            -4,
            3,
            2,
            __get(A, 3)
        )
        if tipo == "pombo" then
            R(
                nil,
                5,
                -2,
                3,
                2,
                "#5aa06a"
            )
        end
        if tipo == "morcego" then
            R(
                nil,
                5,
                -9,
                2,
                3,
                corpo
            )
            R(
                nil,
                9,
                -9,
                2,
                3,
                corpo
            )
        end
        if __t(asa) then
            R(
                nil,
                -5,
                -12,
                9,
                9,
                "#120e0e"
            )
            R(
                nil,
                -4,
                -11,
                7,
                7,
                corpo
            )
        else
            R(
                nil,
                -5,
                2,
                9,
                7,
                "#120e0e"
            )
            R(
                nil,
                -4,
                2,
                7,
                5,
                corpo
            )
        end
        R(
            nil,
            -11,
            -2,
            4,
            3,
            corpo
        )
        c:restore()
    end
    local function moto(self, c, x, y, cor, dir, t)
        local function R(____, a, b, w, h, col)
            c.fillStyle = col
            c:fillRect(
                math.floor(a + 0.5),
                math.floor(b + 0.5),
                w,
                h
            )
        end
        c:save()
        c:translate(x, y)
        c:scale(dir, 1)
        R(
            nil,
            -26,
            -4,
            52,
            3,
            "rgba(0,0,0,.3)"
        )
        for ____, wx in __iterar((__arrL({-18, 18}, 2))) do
            R(
                nil,
                wx - 9,
                -18,
                18,
                18,
                "#14141a"
            )
            R(
                nil,
                wx - 5,
                -14,
                10,
                10,
                "#5a5e66"
            )
            R(
                nil,
                wx - 2,
                -11,
                4,
                4,
                "#c8ccd0"
            )
        end
        R(
            nil,
            -14,
            -24,
            30,
            8,
            cor
        )
        R(
            nil,
            -14,
            -24,
            30,
            2,
            "#ffffff55"
        )
        R(
            nil,
            10,
            -32,
            6,
            10,
            "#2a2a2a"
        )
        R(
            nil,
            12,
            -34,
            10,
            3,
            "#3a3a3a"
        )
        R(
            nil,
            20,
            -26,
            5,
            4,
            "#fff2b0"
        )
        R(
            nil,
            -22,
            -20,
            10,
            3,
            "#8a8e94"
        )
        c:restore()
    end
    local FASES = __ord(
        {
            creuza = __ord(
                {
                    cena = 13,
                    hora = 9.5,
                    checkpoint = 2950,
                    chefe = __ord(
                        {
                            tipo = "c2_creuza",
                            nome = "DONA CREUZA",
                            titulo = "A FOFOQUEIRA DO BAIRRO",
                            nivel = 3,
                            x = 3520,
                            hp = 230,
                            cor = "#e48fb0",
                            proj = "balao",
                            arena = __arrL({-380, 340}, 2),
                            vel = 1,
                            falas = __arrL({
                                "PSIU!",
                                "JURA?!",
                                "EU SEMPRE SEI!",
                                "FORASTEIRO!",
                                "VOU CONTAR PRA TODO MUNDO!"
                            }, 5)
                        },
                        "tipo,nome,titulo,nivel,x,hp,cor,proj,arena,vel,falas"
                    ),
                    intro = "c2_vilao_creuza",
                    derrota = "c2_derrota_creuza",
                    inimigos = __arrL(
                        {
                            __arrL({"vizinha", 2150}, 2),
                            __arrL({"pombo", 2320}, 2),
                            __arrL({"vizinha", 2520}, 2),
                            __arrL({"pombo", 2640}, 2),
                            __arrL({"vizinha2", 2780}, 2),
                            __arrL({"pombo", 2880}, 2),
                            __arrL({"vizinha", 3020}, 2)
                        },
                        7
                    ),
                    curas = __arrL({2420, 2980}, 2)
                },
                "cena,hora,checkpoint,chefe,intro,derrota,inimigos,curas"
            ),
            tonhao = __ord(
                {
                    cena = 16,
                    hora = 11,
                    checkpoint = 4820,
                    chefe = __ord(
                        {
                            tipo = "c2_tonhao",
                            nome = "TONHÃO",
                            titulo = "O REI DO MOTOTÁXI",
                            nivel = 5,
                            x = 5320,
                            hp = 290,
                            cor = "#f08a24",
                            proj = "nota",
                            arena = __arrL({-400, 380}, 2),
                            vel = 1.08,
                            falas = __arrL({
                                "CENTO E CINQUENTA!",
                                "TAXA DE NEBLINA!",
                                "NINGUÉM FOGE DO TONHÃO!",
                                "FOOOM!",
                                "PAGA A CORRIDA!"
                            }, 5)
                        },
                        "tipo,nome,titulo,nivel,x,hp,cor,proj,arena,vel,falas"
                    ),
                    intro = "c2_vilao_tonhao",
                    derrota = "c2_derrota_tonhao",
                    inimigos = __arrL(
                        {
                            __arrL({"motoca", 3260}, 2),
                            __arrL({"pombo", 3480}, 2),
                            __arrL({"motoca", 3820}, 2),
                            __arrL({"motoca", 4120}, 2),
                            __arrL({"pombo", 4600}, 2),
                            __arrL({"motoca", 4760}, 2)
                        },
                        6
                    ),
                    curas = __arrL({3600, 4650}, 2)
                },
                "cena,hora,checkpoint,chefe,intro,derrota,inimigos,curas"
            ),
            valdomiro = __ord(
                {
                    cena = 17,
                    hora = 9,
                    checkpoint = 3000,
                    chefe = __ord(
                        {
                            tipo = "c2_valdomiro",
                            nome = "SEU VALDOMIRO",
                            titulo = "O CHEFÃO DA FEIRA",
                            nivel = 7,
                            x = 3560,
                            hp = 340,
                            cor = "#e9d6a8",
                            proj = "biscoito",
                            arena = __arrL({-400, 360}, 2),
                            vel = 1.12,
                            falas = __arrL({
                                "NO QUILO!",
                                "POLVILHO NA CARA!",
                                "A FEIRA É MINHA!",
                                "SEM A MINHA BÊNÇÃO, NÃO!",
                                "BISCOITO QUENTINHO!"
                            }, 5)
                        },
                        "tipo,nome,titulo,nivel,x,hp,cor,proj,arena,vel,falas"
                    ),
                    intro = "c2_vilao_valdomiro",
                    derrota = "c2_derrota_valdomiro",
                    inimigos = __arrL(
                        {
                            __arrL({"feirante", 980}, 2),
                            __arrL({"feirante", 1300}, 2),
                            __arrL({"pombo", 1820}, 2),
                            __arrL({"feirante", 2100}, 2),
                            __arrL({"feirante", 2450}, 2),
                            __arrL({"pombo", 2620}, 2),
                            __arrL({"feirante", 2860}, 2)
                        },
                        7
                    ),
                    curas = __arrL({1650, 2700}, 2)
                },
                "cena,hora,checkpoint,chefe,intro,derrota,inimigos,curas"
            ),
            kaua = __ord(
                {
                    cena = 15,
                    hora = 16.8,
                    checkpoint = 4290,
                    chefe = __ord(
                        {
                            tipo = "c2_kaua_influencer",
                            nome = "KAUÃ INFLUENCER",
                            titulo = "2 MILHÕES DE SEGUIDORES (QUASE)",
                            nivel = 9,
                            x = 4520,
                            hp = 380,
                            cor = "#c8d8ff",
                            proj = "flash",
                            arena = __arrL({-220, 240}, 2),
                            vel = 1.18,
                            falas = __arrL({
                                "DEIXA O LIKE!",
                                "ATIVA O SININHO!",
                                "TÁ GRAVANDO!",
                                "VAI VIRALIZAR!",
                                "CORTA ESSA PARTE!"
                            }, 5)
                        },
                        "tipo,nome,titulo,nivel,x,hp,cor,proj,arena,vel,falas"
                    ),
                    intro = "c2_vilao_kaua",
                    derrota = "c2_derrota_kaua",
                    inimigos = __arrL(
                        {
                            __arrL({"urubu", 900}, 2),
                            __arrL({"seguidor", 1240}, 2),
                            __arrL({"urubu", 1900}, 2),
                            __arrL({"seguidor", 2200}, 2),
                            __arrL({"urubu", 2500}, 2),
                            __arrL({"seguidor", 3150}, 2),
                            __arrL({"urubu", 3500}, 2),
                            __arrL({"seguidor", 3900}, 2)
                        },
                        8
                    ),
                    curas = __arrL({1260, 2350, 3700}, 3)
                },
                "cena,hora,checkpoint,chefe,intro,derrota,inimigos,curas"
            ),
            barao = __ord(
                {
                    cena = 18,
                    hora = 8,
                    checkpoint = 4100,
                    chefe = __ord(
                        {
                            tipo = "c2_barao",
                            nome = "BARÃO DO CAFÉ",
                            titulo = "MOVIDO A CAFEÍNA",
                            nivel = 11,
                            x = 4600,
                            hp = 420,
                            cor = "#a8743a",
                            proj = "grao",
                            chuva = "cafe",
                            arena = __arrL({-360, 380}, 2),
                            vel = 1.2,
                            falas = __arrL({
                                "DÉCIMO QUINTO CAFEZINHO!",
                                "RESPIRAR É PRA FRACO!",
                                "ESSA TERRA É MINHA!",
                                "CA-FE-Í-NA!",
                                "MEU OLHO NÃO TÁ TREMENDO!"
                            }, 5)
                        },
                        "tipo,nome,titulo,nivel,x,hp,cor,proj,chuva,arena,vel,falas"
                    ),
                    intro = "c2_vilao_barao",
                    derrota = "c2_derrota_barao",
                    inimigos = __arrL(
                        {
                            __arrL({"jagunco", 900}, 2),
                            __arrL({"maritaca", 1200}, 2),
                            __arrL({"jagunco", 2000}, 2),
                            __arrL({"maritaca", 2450}, 2),
                            __arrL({"jagunco", 2800}, 2),
                            __arrL({"jagunco", 3600}, 2),
                            __arrL({"maritaca", 3850}, 2),
                            __arrL({"jagunco", 4000}, 2)
                        },
                        8
                    ),
                    curas = __arrL({1900, 3000, 3950}, 3)
                },
                "cena,hora,checkpoint,chefe,intro,derrota,inimigos,curas"
            ),
            breno = __ord(
                {
                    cena = 19,
                    hora = 20.5,
                    checkpoint = 3300,
                    chefe = __ord(
                        {
                            tipo = "c2_breno",
                            nome = "BRENO PITBULL",
                            titulo = "O VALENTÃO DO TEATRO",
                            nivel = 12,
                            x = 3800,
                            hp = 470,
                            cor = "#e8433a",
                            proj = "punho",
                            arena = __arrL({-360, 380}, 2),
                            vel = 1.24,
                            furia = true,
                            falas = __arrL({
                                "PITBULL NÃO LATE!",
                                "VEM, FORASTEIRO!",
                                "TÁ COM MEDO?",
                                "OLHA O BRAÇO!",
                                "RESPEITA!"
                            }, 5)
                        },
                        "tipo,nome,titulo,nivel,x,hp,cor,proj,arena,vel,furia,falas"
                    ),
                    intro = "c2_vilao_breno",
                    derrota = "c2_derrota_breno",
                    inimigos = __arrL(
                        {
                            __arrL({"valentao", 1000}, 2),
                            __arrL({"morcego", 1350}, 2),
                            __arrL({"valentao", 1900}, 2),
                            __arrL({"morcego", 2300}, 2),
                            __arrL({"valentao", 2700}, 2),
                            __arrL({"valentao", 3100}, 2),
                            __arrL({"morcego", 3250}, 2)
                        },
                        7
                    ),
                    curas = __arrL({1700, 2900}, 2)
                },
                "cena,hora,checkpoint,chefe,intro,derrota,inimigos,curas"
            ),
            gemeos = __ord(
                {
                    cena = 20,
                    hora = 19,
                    checkpoint = 3080,
                    chefe = __ord(
                        {
                            tipo = "c2_ryan",
                            nome = "RYAN E BRYAN",
                            titulo = "OS GÊMEOS DA LAN",
                            nivel = 13,
                            x = 3560,
                            hp = 500,
                            cor = "#5ae0d0",
                            proj = "pixel",
                            arena = __arrL({-320, 420}, 2),
                            vel = 1.25,
                            dupla = __ord({tipo = "c2_bryan", dx = 140}, "tipo,dx"),
                            falas = __arrL({
                                "LAG! FOI LAG!",
                                "GG EZ!",
                                "PLAYER 3 NOOB!",
                                "COMBO DUPLO!",
                                "RESPAWN!"
                            }, 5),
                            falas2 = __arrL({"TÔ NA SUA COSTA!", "PEGA ELE, RYAN!", "HEADSHOT!", "É DOIS CONTRA UM!"}, 4)
                        },
                        "tipo,nome,titulo,nivel,x,hp,cor,proj,arena,vel,dupla,falas,falas2"
                    ),
                    intro = "c2_vilao_gemeos",
                    derrota = "c2_derrota_gemeos",
                    inimigos = __arrL(
                        {
                            __arrL({"gamer", 900}, 2),
                            __arrL({"drone", 1300}, 2),
                            __arrL({"gamer", 1900}, 2),
                            __arrL({"drone", 2300}, 2),
                            __arrL({"gamer", 2650}, 2),
                            __arrL({"gamer", 2950}, 2),
                            __arrL({"drone", 3000}, 2)
                        },
                        7
                    ),
                    curas = __arrL({1650, 2800}, 2)
                },
                "cena,hora,checkpoint,chefe,intro,derrota,inimigos,curas"
            ),
            fred = __ord(
                {
                    cena = 27,
                    hora = 10,
                    checkpoint = 1000,
                    chefe = __ord(
                        {
                            tipo = "fred_conquista",
                            nome = "FRED",
                            titulo = "O NOVO MELHOR AMIGO",
                            nivel = 15,
                            x = 1560,
                            hp = 560,
                            cor = "#ffd24a",
                            proj = "pao",
                            arena = __arrL({-360, 360}, 2),
                            vel = 1.32,
                            armor = 0.5,
                            falas = __arrL({
                                "TOPETE, TOPETE...",
                                "PÃO DE QUEIJO!",
                                "CLUBE DO TOPETE!",
                                "O JORGE ME ESCOLHEU!",
                                "VOCÊ É O PASSADO!",
                                "ELE NEM FALA DE VOCÊ!",
                                "O QUE EU SOU COM O JORGE..."
                            }, 7)
                        },
                        "tipo,nome,titulo,nivel,x,hp,cor,proj,arena,vel,armor,falas"
                    ),
                    intro = "c2_vilao_fred",
                    derrota = "c2_derrota_fred",
                    inimigos = __arrL(
                        {
                            __arrL({"aluno", 420}, 2),
                            __arrL({"pombo", 600}, 2),
                            __arrL({"aluna", 760}, 2),
                            __arrL({"aluno", 900}, 2)
                        },
                        4
                    ),
                    curas = __arrL({700}, 1)
                },
                "cena,hora,checkpoint,chefe,intro,derrota,inimigos,curas"
            ),
            jorge = __ord(
                {
                    cena = 14,
                    hora = 21,
                    checkpoint = 2080,
                    final = true,
                    chefe = __ord(
                        {
                            tipo = "jorge",
                            nome = "JORGE",
                            titulo = "O EX-MELHOR AMIGO",
                            nivel = 20,
                            x = 2640,
                            hp = 520,
                            cor = "#9a7ad8",
                            proj = "papel",
                            arena = __arrL({-420, 420}, 2),
                            vel = 1.34,
                            armor = 0.45,
                            danoMult = 1.35,
                            falasFase = __arrL(
                                {
                                    __arrL({"EU NÃO TE CONHEÇO!", "SAI DA MINHA VIDA!", "BOLINHA DE PAPEL, LEMBRA?", "VOLTA PRA ITABUNA!"}, 4),
                                    __arrL({"QUERO VER SEGURAR ESSE PESO!", "OLHA ONDE EU VOU CAIR!"}, 2),
                                    __arrL({"O TRIO JÁ ERA.", "NEM SENTI FALTA.", "VOCÊ FICOU PRA TRÁS."}, 3),
                                    __arrL({"DAQUI DE CIMA ITABUNA É TÃO PEQUENA.", "OLHA O VITRAL ANTES DE PULAR!"}, 2),
                                    __arrL({"EU LEMBRO DA PROMESSA.", "AQUELA LIGAÇÃO... ERA PRA VOCÊ."}, 2)
                                },
                                5
                            ),
                            falas = __arrL({"EU NÃO TE CONHEÇO!"}, 1)
                        },
                        "tipo,nome,titulo,nivel,x,hp,cor,proj,arena,vel,armor,danoMult,falasFase,falas"
                    ),
                    intro = "c2_centro",
                    derrota = "c2_final",
                    inimigos = __arrL(
                        {
                            __arrL({"aluno", 1960}, 2),
                            __arrL({"pombo", 2040}, 2),
                            __arrL({"aluna", 2120}, 2)
                        },
                        3
                    ),
                    curas = __arrL({1900, 2150}, 2)
                },
                "cena,hora,checkpoint,final,chefe,intro,derrota,inimigos,curas"
            )
        },
        "creuza,tonhao,valdomiro,kaua,barao,breno,gemeos,fred,jorge"
    )
    local TIPO = __ord({
        vizinha = "c2i_vizinha",
        vizinha2 = "c2i_vizinha2",
        motoca = "c2i_motoca",
        feirante = "c2i_feirante",
        seguidor = "c2i_seguidor",
        jagunco = "c2i_jagunco",
        valentao = "c2i_valentao",
        gamer = "c2i_gamer",
        aluno = "c2i_aluno",
        aluna = "c2i_aluna",
        pombo = nil,
        urubu = nil,
        maritaca = nil,
        morcego = nil,
        drone = nil
    }, "vizinha,vizinha2,motoca,feirante,seguidor,jagunco,valentao,gamer,aluno,aluna,pombo,urubu,maritaca,morcego,drone")
    local ESC = 5
    local function DIF()
        local ____t_20 = __t
        local ____opt_17 = window.Difficulty
        if ____opt_17 ~= nil then
            ____opt_17 = ____opt_17.getSettings
        end
        local ____opt_result_19
        if ____opt_17 ~= nil then
            ____opt_result_19 = ____opt_17(____opt_17)
        end
        __O[925] = ____opt_result_19
        return if ____t_20(____opt_result_19) then __O[925] else {hp = 1, windup = 1, recovery = 1, incomingDamage = 1}
    end
    local STATS = __ord(
        {
            vizinha = __ord({hp = 34, ia = "tiro", proj = "balao", dano = 9}, "hp,ia,proj,dano"),
            vizinha2 = __ord({hp = 40, ia = "tiro", proj = "balao", dano = 10}, "hp,ia,proj,dano"),
            pombo = __ord({hp = 14, ia = "voa", dano = 8}, "hp,ia,dano"),
            urubu = __ord({hp = 22, ia = "voa", dano = 11}, "hp,ia,dano"),
            motoca = __ord({hp = 46, ia = "carga", dano = 13}, "hp,ia,dano"),
            feirante = __ord({hp = 40, ia = "tiro", proj = "fruta", dano = 10}, "hp,ia,proj,dano"),
            seguidor = __ord({hp = 42, ia = "flash", dano = 10}, "hp,ia,dano"),
            jagunco = __ord({hp = 58, ia = "corpo", dano = 13}, "hp,ia,dano"),
            maritaca = __ord({hp = 20, ia = "voa", dano = 10}, "hp,ia,dano"),
            valentao = __ord({hp = 66, ia = "corpo", dano = 15}, "hp,ia,dano"),
            morcego = __ord({hp = 22, ia = "voa", dano = 11}, "hp,ia,dano"),
            gamer = __ord({hp = 52, ia = "tiro", proj = "controle", dano = 12}, "hp,ia,proj,dano"),
            drone = __ord({hp = 28, ia = "voa", dano = 12}, "hp,ia,dano"),
            aluno = __ord({hp = 64, ia = "corpo", dano = 15}, "hp,ia,dano"),
            aluna = __ord({hp = 56, ia = "tiro", proj = "pao", dano = 13}, "hp,ia,proj,dano")
        },
        "vizinha,vizinha2,pombo,urubu,motoca,feirante,seguidor,jagunco,maritaca,valentao,morcego,gamer,drone,aluno,aluna"
    )
    local function criar(self, slug, api)
        local placa, flutua, danoInimigo, danoChefe, novaFase, derrotar, fala, atualizaInimigo, atualizaChefe, K, P, efeitos, projs, textos, placas, t, falaT, falaTxt, falaVida, inimigos, curas, combate, HPF, NF, B, B2, arena, vencido, luta, fala2Txt, fala2Vida, estadosDoChefe
        function placa(self, titulo, sub, cor, vida)
            if cor == nil then
                cor = "#ffd25a"
            end
            if vida == nil then
                vida = 2
            end
            __call(placas, "push", {
                titulo = titulo,
                sub = sub,
                cor = cor,
                t = 0,
                vida = vida
            })
        end
        function flutua(self, x, y, s, cor)
            __call(
                textos,
                "push",
                {
                    x = x,
                    y = y,
                    s = tostring(s),
                    cor = cor,
                    t = 0
                }
            )
        end
        function danoInimigo(self, e, n, tipo)
            if __le(e.hp, 0) then
                return false
            end
            e.hp = e.hp - n
            e.hit = 0.16
            e.vx = e.vx + if __lt(P.x, e.x) then 1 else -1 * 60
            if __le(e.hp, 0) then
                e.hp = 0
                e.morto = 1
                local ____opt_26 = window.Campanha2
                if ____opt_26 ~= nil then
                    ____opt_26 = ____opt_26.ganharXP
                end
                if ____opt_26 ~= nil then
                    ____opt_26(
                        ____opt_26,
                        30,
                        nil,
                        e.x,
                        e.y - 120
                    )
                end
                local ____opt_30 = window.CampanhaLoja
                if ____opt_30 ~= nil then
                    ____opt_30 = ____opt_30.ganhar
                end
                if ____opt_30 ~= nil then
                    ____opt_30(____opt_30, 6)
                end
                flutua(
                    nil,
                    e.x,
                    e.y - 100,
                    "+6 ●",
                    "#ffd24a"
                )
                api:sfx("plim")
                if math.random() < 0.22 then
                    __call(curas, "push", {x = e.x, pego = false, solta = true})
                end
            end
            return n
        end
        function danoChefe(self, n, tipo, quem)
            if quem == nil then
                quem = B
            end
            local ____t_36 = __t
            local ____t_35 = __t
            local ____t_33 = __t
            local ____temp_32 = B.st == "espera" or B.st == "troca"
            __O[927] = ____temp_32
            local ____temp_34 = if ____t_33(____temp_32) then __O[927] else B.st == "derrotado"
            __O[928] = ____temp_34
            if ____t_36(if ____t_35(____temp_34) then __O[928] else B.st == "entrada") then
                return false
            end
            local exposto = B.st == "recupera" or B.stun > 0
            local d = math.max(
                1,
                math.floor(n * if __t(exposto) then 1 else B.armor + 0.5)
            )
            B.hp = B.hp - d
            quem.hit = 0.14
            api:tremer(if __t(exposto) then 3 else 1.5)
            if __le(B.hp, 0) then
                if __lt(B.fase, NF) then
                    novaFase(nil, B.fase + 1)
                else
                    derrotar(nil)
                end
            end
            return if __t(exposto) then __add(d, "!") else d
        end
        function novaFase(self, f)
            B.fase = f
            local ____get_result_37 = __get(HPF, f - 1)
            B.hp = ____get_result_37
            B.max = ____get_result_37
            B.st = "troca"
            B.tt = 1.3
            B.padrao = 0
            B.golpe = nil
            __setlen(projs, 0)
            __call(
                inimigos,
                "forEach",
                function(____, e)
                    if __t(e.invocado) then
                        e.hp = 0
                    end
                end
            )
            B.tt = combate:trocar(luta, f, P)
            P.inv = math.max(if __t(P.inv) then P.inv else 0, B.tt)
            api:sfx("vs")
            if slug ~= "jorge" then
                placa(
                    nil,
                    __add("FASE ", f),
                    if f == NF then "ÚLTIMA FASE · VIDA RENOVADA" else "VIDA RENOVADA",
                    K.cor,
                    1.05
                )
            end
            local ____fala_40 = fala
            local ____t_39 = __t
            local ____getq_result_38 = __getq(
                __getq(K.falasFase, f - 1),
                0
            )
            __O[929] = ____getq_result_38
            ____fala_40(nil, if ____t_39(____getq_result_38) then __O[929] else __get(K.falas, 0))
        end
        function derrotar(self)
            luta = nil
            B.hp = 0
            B.st = "derrotado"
            B.tt = 2.2
            __setlen(projs, 0)
            __call(
                inimigos,
                "forEach",
                function(____, e)
                    if __t(e.invocado) then
                        e.hp = 0
                    end
                end
            )
            vencido = true
            api:tremer(12)
            api:flash("#fff6d8")
            api:sfx(if K.nome == "JORGE" then "misterio" else "fanfarra")
            if K.nome ~= "JORGE" then
                local ____opt_43 = window.CampanhaLoja
                if ____opt_43 ~= nil then
                    ____opt_43 = ____opt_43.ganhar
                end
                if ____opt_43 ~= nil then
                    ____opt_43(____opt_43, 60)
                end
                flutua(
                    nil,
                    B.x,
                    B.y - 120,
                    "+60 ●",
                    "#ffd24a"
                )
            end
            if K.nome == "JORGE" then
                placa(
                    nil,
                    "JORGE CAIU...",
                    "E AGORA, DA ROÇA?",
                    "#e8d8ff",
                    2.2
                )
            else
                placa(
                    nil,
                    __add(
                        __add("DERROTAD", if K.nome == "DONA CREUZA" then "A" else if __t(K.dupla) then "OS" else "O"),
                        "!"
                    ),
                    K.nome,
                    "#ffd25a",
                    2.2
                )
            end
        end
        function fala(self, s)
            falaTxt = s
            falaVida = 1.6
        end
        function atualizaInimigo(self, e, dt)
            if __le(e.hp, 0) then
                e.morto = __add(e.morto, dt)
                return
            end
            e.hit = math.max(0, e.hit - dt)
            e.stun = math.max(0, e.stun - dt)
            e.conf = math.max(0, e.conf - dt)
            e.golpe = math.max(0, e.golpe - dt)
            e.x = e.x + e.vx * dt
            e.vx = e.vx * 0.05 ^ dt
            local st = __get(STATS, e.k)
            if st.ia ~= "voa" then
                e.vy = e.vy + 1400 * dt
                e.y = math.min(FLOOR, e.y + e.vy * dt)
                if __ge(e.y, FLOOR) then
                    e.vy = 0
                end
            end
            local ____t_66 = __t
            local ____t_65 = __t
            local ____temp_64 = if __t(arena.ativa) then not __t(e.invocado) else arena.ativa
            __O[935] = ____temp_64
            if ____t_66(if ____t_65(____temp_64) then __gt(e.x, arena.l - 40) and __lt(e.x, arena.r + 40) else __O[935]) then
                e.x = if __lt(
                    e.x,
                    __add(arena.l, arena.r) / 2
                ) then arena.l - 50 else arena.r + 50
            end
            if __gt(e.stun, 0) then
                return
            end
            local dx = P.x - e.x
            local perto = math.abs(dx) < 430 and math.abs(dx) > 0
            if __gt(e.conf, 0) then
                local ____t_68 = __t
                local ____get_result_67 = __get(
                    __call(
                        __call(
                            inimigos,
                            "filter",
                            function(____, o) return o ~= e and __gt(o.hp, 0) end
                        ),
                        "sort",
                        function(____, a, b) return math.abs(a.x - e.x) - math.abs(b.x - e.x) end
                    ),
                    0
                )
                __O[936] = ____get_result_67
                local alvo = if ____t_68(____get_result_67) then __O[936] else if __t(B.st ~= "espera" and __gt(B.hp, 0)) then B else nil
                if __t(alvo) then
                    local d = alvo.x - e.x
                    local ____e_71 = e
                    local ____t_70 = __t
                    local ____TS__MathSign_result_69 = __TS__MathSign(d)
                    __O[937] = ____TS__MathSign_result_69
                    ____e_71.dir = if ____t_70(____TS__MathSign_result_69) then __O[937] else 1
                    if math.abs(d) > 36 then
                        e.x = e.x + e.dir * 120 * dt
                    elseif __le(e.golpe, 0) then
                        e.golpe = 0.8
                        local ____ = if alvo == B then danoChefe(nil, 5, "confuso") else danoInimigo(nil, alvo, 6, "confuso")
                        flutua(
                            nil,
                            e.x,
                            e.y - 90,
                            "TOMA!",
                            "#e48fb0"
                        )
                    end
                end
                return
            end
            e.tt = e.tt - if e.st == "patrulha" then dt / 0.95 else dt
            if e.st ~= "ataca" then
                e.dir = if dx < 0 then -1 else 1
            end
            if st.ia == "voa" then
                if e.st == "patrulha" then
                    e.x = e.x + math.sin(t * 1.4 + e.homeX) * 40 * dt
                    e.y = e.y + (290 + math.sin(t * 2 + e.homeX) * 16 - e.y) * dt * 2
                    if __t(if __t(perto) then math.abs(dx) < 300 else perto) then
                        e.x = e.x + __TS__MathSign(dx) * 90 * dt
                    end
                    if __t(if __t(perto) then __le(e.tt, 0) else perto) then
                        e.st = "mira"
                        e.tt = 0.6
                    end
                elseif e.st == "mira" then
                    e.y = e.y - 30 * dt
                    if __le(e.tt, 0) then
                        e.st = "ataca"
                        e.alvo = __arrL({P.x, P.y - 24}, 2)
                        e.tt = 1
                    end
                elseif e.st == "ataca" then
                    local ax = __get(e.alvo, 0) - e.x
                    local ay = __get(e.alvo, 1) - e.y
                    local ____t_73 = __t
                    local ____hypot_result_72 = __hypot(ax, ay)
                    __O[938] = ____hypot_result_72
                    local d = if ____t_73(____hypot_result_72) then __O[938] else 1
                    e.x = e.x + ax / d * 420 * dt
                    e.y = e.y + ay / d * 420 * dt
                    if __t(math.abs(P.x - e.x) < 20 and math.abs(P.y - 30 - e.y) < 30) then
                        api:ferir(st.dano, e.x)
                        e.st = "volta"
                    end
                    if __t(d < 14 or __le(e.tt, 0)) then
                        e.st = "volta"
                        e.tt = 1.6
                    end
                elseif e.st == "volta" then
                    e.y = e.y + (290 - e.y) * dt * 2.4
                    if __le(e.tt, 0) then
                        e.st = "patrulha"
                        e.tt = rnd(nil, 1.2, 2.4)
                    end
                end
                return
            end
            if st.ia == "carga" then
                if e.st == "patrulha" then
                    e.x = e.x + math.sin(t * 0.8 + e.homeX) * 30 * dt
                    local ____t_76 = __t
                    local ____t_75 = __t
                    local ____temp_74 = if __t(perto) then math.abs(dx) < 380 else perto
                    __O[939] = ____temp_74
                    if ____t_76(if ____t_75(____temp_74) then __le(e.tt, 0) else __O[939]) then
                        e.st = "mira"
                        e.tt = 0.85
                        e.dir = __TS__MathSign(dx)
                        e.alvoX = e.x + e.dir * 520
                    end
                elseif e.st == "mira" then
                    if __le(e.tt, 0) then
                        e.st = "ataca"
                        e.tt = 1.1
                        api:sfx("buzina")
                    end
                elseif e.st == "ataca" then
                    e.x = e.x + e.dir * 520 * dt
                    if __t(math.abs(P.x - e.x) < 30 and __gt(P.y, FLOOR - 40)) then
                        api:ferir(st.dano, e.x - e.dir * 20)
                    end
                    if __le(e.tt, 0) then
                        e.st = "patrulha"
                        e.tt = rnd(nil, 1.4, 2.2)
                    end
                end
                return
            end
            if st.ia == "corpo" then
                if e.st == "patrulha" then
                    if __t(perto) then
                        if math.abs(dx) > 44 then
                            e.x = e.x + __TS__MathSign(dx) * 105 * dt
                        end
                        if __t(__le(e.tt, 0) and math.abs(dx) < 70) then
                            e.st = "mira"
                            e.tt = 0.55
                        end
                    else
                        e.x = e.x + (e.homeX - e.x) * dt * 0.5
                    end
                elseif e.st == "mira" then
                    if __le(e.tt, 0) then
                        e.st = "ataca"
                        e.tt = 0.25
                        e.vx = e.dir * 260
                    end
                elseif e.st == "ataca" then
                    local ____t_79 = __t
                    local ____t_78 = __t
                    local ____temp_77 = not __t(e.acertou) and math.abs(P.x - e.x) < 46
                    __O[940] = ____temp_77
                    if ____t_79(if ____t_78(____temp_77) then math.abs(P.y - e.y) < 50 else __O[940]) then
                        e.acertou = true
                        api:ferir(st.dano, e.x)
                    end
                    if __le(e.tt, 0) then
                        e.st = "patrulha"
                        e.tt = rnd(nil, 1.1, 1.9)
                        e.acertou = false
                    end
                end
                return
            end
            local dist = if st.ia == "tiro" then 240 else 60
            if e.st == "patrulha" then
                if __t(perto) then
                    if math.abs(dx) > dist + 30 then
                        e.x = e.x + __TS__MathSign(dx) * 70 * dt
                    elseif __t(math.abs(dx) < dist - 40 and st.ia == "tiro") then
                        e.x = e.x - __TS__MathSign(dx) * 50 * dt
                    end
                    if __t(__le(e.tt, 0) and math.abs(dx) < dist + 60) then
                        e.st = "mira"
                        e.tt = if st.ia == "flash" then 0.7 else 0.6
                    end
                else
                    e.x = e.x + (e.homeX - e.x) * dt * 0.5
                end
            elseif e.st == "mira" then
                if __le(e.tt, 0) then
                    e.st = "patrulha"
                    e.tt = rnd(nil, 1.3, 2.3)
                    if st.ia == "tiro" then
                        local vx = clamp(nil, dx * 1.2, -340, 340)
                        __call(projs, "push", {
                            x = e.x + e.dir * 12,
                            y = e.y - 52,
                            vx = vx,
                            vy = -330,
                            g = 900,
                            tipo = st.proj,
                            dano = st.dano,
                            vida = 3
                        })
                    else
                        __call(efeitos, "push", {k = "flashP", x = e.x + e.dir * 30, y = e.y - 50, t = 0})
                        if __t(math.abs(dx) < 90 and math.abs(P.y - e.y) < 60) then
                            api:ferir(st.dano, e.x)
                            P.atordoado = 0.5
                        end
                        api:sfx("plim")
                    end
                end
            end
        end
        function atualizaChefe(self, dt)
            B.hit = math.max(0, B.hit - dt)
            B.stun = math.max(0, B.stun - dt)
            B.conf = math.max(0, B.conf - dt)
            if B.st == "derrotado" then
                B.tt = B.tt - dt
                if __t(B.tt <= 0 and not __t(B.fim)) then
                    B.fim = true
                    api:vencer()
                end
                return
            end
            if __t(not __t(luta) or B.stun > 0) then
                return
            end
            B.x = clamp(nil, B.x + B.vx * dt, arena.l + 30, arena.r - 30)
            B.vx = B.vx * 0.05 ^ dt
            luta.x = B.x
            combate:atualizar(
                luta,
                dt,
                P,
                function(____, d, x) return api:ferir(
                    math.floor(d * if __t(K.danoMult) then K.danoMult else 1 + 0.5),
                    x
                ) end,
                function()
                    api:sfx(if slug == "tonhao" then "buzina" else "whoosh")
                    if __t(B2) then
                        fala2Txt = __get(
                            K.falas2,
                            __mod(
                                luta.indice,
                                __len(K.falas2)
                            )
                        )
                        fala2Vida = 1.3
                    end
                end
            )
            B.x = luta.x
            B.y = luta.y
            if slug == "jorge" then
                local corpo = window.JorgeDuelo:corpo(luta)
                B.alto = corpo.altura
                B.largura = corpo.rx
            end
            B.dir = if __lt(P.x, B.x) then -1 else 1
            B.st = __get(estadosDoChefe, luta.estado)
            B.tt = math.max(0, luta.dur - luta.tempo)
            if __t(B2) then
                B2.x = luta.gemeoX
                B2.dir = if __lt(P.x, B2.x) then -1 else 1
                B2.hit = math.max(0, B2.hit - dt)
            end
            falaT = falaT - dt
            if falaT <= 0 then
                falaT = rnd(nil, 4, 6.5)
                local ____t_81 = __t
                local ____getq_result_80 = __getq(K.falasFase, B.fase - 1)
                __O[941] = ____getq_result_80
                local falas = if ____t_81(____getq_result_80) then __O[941] else K.falas
                fala(
                    nil,
                    __get(
                        falas,
                        math.floor(rnd(
                            nil,
                            0,
                            __len(falas)
                        ))
                    )
                )
            end
        end
        local F = __get(FASES, slug)
        if not __t(F) then
            return nil
        end
        K = F.chefe
        P = api.P
        efeitos = __arrL({}, 0)
        projs = __arrL({}, 0)
        textos = __arrL({}, 0)
        placas = __arrL({}, 0)
        t = 0
        falaT = 3
        falaTxt = ""
        falaVida = 0
        local function novoInimigo(____, k, x, extra)
            if extra == nil then
                extra = {}
            end
            local st = __get(STATS, k)
            local e = __assign(
                {},
                {
                    k = k,
                    tipo = __get(TIPO, k),
                    x = x,
                    homeX = x,
                    y = if st.ia == "voa" then 300 else FLOOR,
                    hp = math.floor(st.hp * ESC + 0.5),
                    max = math.floor(st.hp * ESC + 0.5),
                    dir = -1,
                    st = "patrulha",
                    tt = rnd(nil, 0, 1.5),
                    hit = 0,
                    vx = 0,
                    vy = 0,
                    stun = 0,
                    conf = 0,
                    golpe = 0,
                    alto = if st.ia == "voa" then 24 else 70,
                    largura = if st.ia == "voa" then 20 else 22,
                    morto = 0
                },
                extra
            )
            e.onDano = function(____, n, tipo) return danoInimigo(nil, e, n, tipo) end
            return e
        end
        inimigos = __call(
            F.inimigos,
            "map",
            function(____, ____bindingPattern0)
                local x
                local k
                k = ____bindingPattern0[1]
                x = ____bindingPattern0[2]
                return novoInimigo(nil, k, x)
            end
        )
        curas = __call(
            F.curas,
            "map",
            function(____, x) return {x = x, pego = false} end
        )
        local ____temp_23 = K.hp * ESC
        local ____t_22 = __t
        local ____DIF_result_hp_21 = DIF(nil).hp
        __O[926] = ____DIF_result_hp_21
        local HPB = math.floor(____temp_23 * if ____t_22(____DIF_result_hp_21) then __O[926] else 1 + 0.5)
        combate = window.ConquistaCombate
        HPF = combate:barras(slug, if slug == "jorge" then HPB * 1.4 else HPB)
        NF = __len(HPF)
        B = {
            tipo = K.tipo,
            x = K.x,
            y = FLOOR,
            homeX = K.x,
            hp = __get(HPF, 0),
            max = __get(HPF, 0),
            fase = 1,
            st = "espera",
            tt = 0,
            hit = 0,
            golpe = nil,
            padrao = 0,
            dir = -1,
            vx = 0,
            vy = 0,
            stun = 0,
            conf = 0,
            alto = 96,
            largura = 30,
            armor = if __t(K.armor) then K.armor else 0.55,
            morto = 0
        }
        B.onDano = function(____, n, tipo) return danoChefe(nil, n, tipo) end
        B2 = if __t(K.dupla) then __getters(
            {
                tipo = K.dupla.tipo,
                x = __add(K.x, K.dupla.dx),
                y = FLOOR,
                dir = -1,
                hit = 0,
                st = "idle",
                tt = 2,
                stun = 0,
                conf = 0,
                vx = 0,
                vy = 0,
                alto = 96,
                largura = 30,
                onDano = function(____, n, tipo) return danoChefe(nil, n, tipo, B2) end
            },
            {hp = function()
                return B.hp
            end}
        ) else nil
        arena = {
            ativa = false,
            l = __add(
                K.x,
                __get(K.arena, 0)
            ),
            r = __add(
                K.x,
                __get(K.arena, 1)
            )
        }
        vencido = false
        luta = nil
        local function novaLuta(self)
            local modo = DIF(nil)
            luta = combate:criar(
                slug,
                B.x,
                FLOOR,
                arena.l,
                arena.r,
                modo,
                __call(
                    __arrL({1.1, 0.99, 0.88}, 3),
                    "map",
                    function(____, n) return n * modo.recovery end
                )
            )
            if __t(luta.estrada) then
                __setlen(projs, 0)
            end
            if __t(B2) then
                B2.x = luta.gemeoX
            end
        end
        local function update(self, dt)
            t = t + dt
            falaVida = math.max(0, falaVida - dt)
            fala2Vida = math.max(0, fala2Vida - dt)
            for ____, q in __iterar((curas)) do
                local ____t_47 = __t
                local ____t_46 = __t
                local ____temp_45 = not __t(q.pego) and math.abs(P.x - q.x) < 22
                __O[930] = ____temp_45
                if ____t_47(if ____t_46(____temp_45) then __gt(P.y, FLOOR - 60) else __O[930]) then
                    q.pego = true
                    P.hp = math.min(if __t(P.max) then P.max else 100, P.hp + 20)
                    flutua(
                        nil,
                        q.x,
                        FLOOR - 70,
                        "+20 ♥",
                        "#ff8a7a"
                    )
                    api:sfx("plim")
                end
            end
            local ____t_51 = __t
            local ____opt_result_50
            if luta ~= nil then
                ____opt_result_50 = luta.estrada
            end
            if not ____t_51(____opt_result_50) then
                for ____, e in __iterar((inimigos)) do
                    atualizaInimigo(nil, e, dt)
                end
            end
            do
                local i = __len(inimigos) - 1
                while i >= 0 do
                    if __t(__le(
                        __get(inimigos, i).hp,
                        0
                    ) and __gt(
                        __get(inimigos, i).morto,
                        1.6
                    )) then
                        __call(inimigos, "splice", i, 1)
                    end
                    i = i - 1
                end
            end
            atualizaChefe(nil, dt)
            for ____, q in __iterar((projs)) do
                q.vida = q.vida - dt
                q.x = q.x + q.vx * dt
                q.y = q.y + q.vy * dt
                q.vy = q.vy + if __t(q.g) then q.g else 0 * dt
                q.rot = if __t(q.rot) then q.rot else 0 + dt * 8
                if __t(if __t(q.cai) then __ge(q.y, FLOOR - 8) else q.cai) then
                    q.vida = 0
                    __call(efeitos, "push", {k = "poeira", x = q.x, y = FLOOR, t = 0})
                    if __t(math.abs(P.x - q.x) < 30 and __gt(P.y, FLOOR - 40)) then
                        api:ferir(q.dano, q.x)
                    end
                    continue
                end
                if __gt(q.y, FLOOR + 10) then
                    q.vida = 0
                end
                local alto = if __t(q.chao) then 26 else 18
                local ____t_54 = __t
                local ____t_53 = __t
                local ____temp_52 = math.abs(P.x - q.x) < if __t(q.chao) then 16 else 18 and __lt(P.y - 60, q.y + 6)
                __O[931] = ____temp_52
                if ____t_54(if ____t_53(____temp_52) then __gt(P.y, q.y - alto + if __t(q.chao) then 0 else -6) else __O[931]) then
                    if __t(if __t(q.chao) then __gt(P.y, FLOOR - 22) else true) then
                        api:ferir(q.dano, q.x)
                        q.vida = 0
                    end
                end
            end
            do
                local i = __len(projs) - 1
                while i >= 0 do
                    local ____t_57 = __t
                    local ____t_56 = __t
                    local ____temp_55 = __le(
                        __get(projs, i).vida,
                        0
                    ) or __lt(
                        __get(projs, i).x,
                        arena.l - 900
                    )
                    __O[932] = ____temp_55
                    if ____t_57(if ____t_56(____temp_55) then __O[932] else __gt(
                        __get(projs, i).x,
                        arena.r + 900
                    )) then
                        __call(projs, "splice", i, 1)
                    end
                    i = i - 1
                end
            end
            for ____, f in __iterar((efeitos)) do
                f.t = __add(f.t, dt)
                local ____t_60 = __t
                local ____t_59 = __t
                local ____temp_58 = f.k == "raio" and not __t(f.feito)
                __O[933] = ____temp_58
                if ____t_60(if ____t_59(____temp_58) then __gt(f.t, 0.05) else __O[933]) then
                    f.feito = true
                    if math.abs(P.x - f.x) < 26 then
                        api:ferir(f.dano, f.x)
                    end
                end
            end
            do
                local i = __len(efeitos) - 1
                while i >= 0 do
                    if __gt(
                        __get(efeitos, i).t,
                        if __get(efeitos, i).k == "raio" then 0.5 else 0.6
                    ) then
                        __call(efeitos, "splice", i, 1)
                    end
                    i = i - 1
                end
            end
            for ____, x in __iterar((textos)) do
                x.t = __add(x.t, dt)
            end
            do
                local i = __len(textos) - 1
                while i >= 0 do
                    if __gt(
                        __get(textos, i).t,
                        1
                    ) then
                        __call(textos, "splice", i, 1)
                    end
                    i = i - 1
                end
            end
            for ____, p in __iterar((placas)) do
                p.t = __add(p.t, dt)
            end
            do
                local i = __len(placas) - 1
                while i >= 0 do
                    if __gt(
                        __get(placas, i).t,
                        __get(placas, i).vida
                    ) then
                        __call(placas, "splice", i, 1)
                    end
                    i = i - 1
                end
            end
            local ____t_63 = __t
            local ____t_62 = __t
            local ____temp_61 = B.st == "espera" and __gt(P.x, arena.l + 60)
            __O[934] = ____temp_61
            if ____t_63(if ____t_62(____temp_61) then not __t(vencido) else __O[934]) then
                arena.ativa = true
                B.st = "entrada"
                api:entrarArena()
            end
            if __t(arena.ativa) then
                P.x = clamp(nil, P.x, arena.l + 16, arena.r - 16)
            end
        end
        fala2Txt = ""
        fala2Vida = 0
        estadosDoChefe = {
            windup = "carga",
            firing = "ataque",
            recover = "recupera",
            phaseChange = "troca",
            idle = "idle"
        }
        local function R(____, c, x, y, w, h, col)
            c.fillStyle = col
            c:fillRect(
                math.floor(x + 0.5),
                math.floor(y + 0.5),
                math.floor(w + 0.5),
                math.floor(h + 0.5)
            )
        end
        local function projetil(self, c, q)
            local x = math.floor(q.x + 0.5)
            local y = math.floor(q.y + 0.5)
            if q.tipo == "balao" then
                R(
                    nil,
                    c,
                    x - 13,
                    y - 9,
                    26,
                    16,
                    "#2a1a10"
                )
                R(
                    nil,
                    c,
                    x - 12,
                    y - 8,
                    24,
                    14,
                    "#fff6dc"
                )
                R(
                    nil,
                    c,
                    x - 3,
                    y + 6,
                    5,
                    4,
                    "#2a1a10"
                )
                R(
                    nil,
                    c,
                    x - 2,
                    y + 6,
                    3,
                    2,
                    "#fff6dc"
                )
                txt(
                    nil,
                    c,
                    __get(
                        __arrL({"PSIU", "JURA", "?!"}, 3),
                        __mod(
                            __shr(
                                math.abs(x),
                                4
                            ),
                            3
                        )
                    ),
                    x,
                    y - 5,
                    "#c43c6a"
                )
            elseif q.tipo == "nota" then
                c:save()
                c:translate(x, y)
                c:rotate(q.rot * 0.3)
                R(
                    nil,
                    c,
                    -10,
                    -10,
                    20,
                    20,
                    "#3a1a08"
                )
                R(
                    nil,
                    c,
                    -8,
                    -8,
                    16,
                    16,
                    "#f08a24"
                )
                R(
                    nil,
                    c,
                    -4,
                    -4,
                    8,
                    8,
                    "#ffd27a"
                )
                c:restore()
            elseif q.tipo == "biscoito" then
                c:save()
                c:translate(x, y)
                c:rotate(q.rot)
                c.strokeStyle = "#6a4a2a"
                c.lineWidth = 7
                c:beginPath()
                c:arc(
                    0,
                    0,
                    9,
                    0,
                    TAU
                )
                c:stroke()
                c.strokeStyle = "#e9d6a8"
                c.lineWidth = 4
                c:beginPath()
                c:arc(
                    0,
                    0,
                    9,
                    0,
                    TAU
                )
                c:stroke()
                c:restore()
            elseif q.tipo == "fruta" then
                R(
                    nil,
                    c,
                    x - 7,
                    y - 7,
                    14,
                    14,
                    "#3a1a08"
                )
                R(
                    nil,
                    c,
                    x - 6,
                    y - 6,
                    12,
                    12,
                    if __t(__mod(
                        __shr(
                            math.abs(x),
                            3
                        ),
                        2
                    )) then "#e8833a" else "#c43c3a"
                )
                R(
                    nil,
                    c,
                    x - 3,
                    y - 5,
                    4,
                    3,
                    "#ffffff66"
                )
                R(
                    nil,
                    c,
                    x - 1,
                    y - 10,
                    2,
                    4,
                    "#3c8a3a"
                )
            elseif q.tipo == "flash" then
                local s = 8 + math.sin(q.rot * 2) * 2
                R(
                    nil,
                    c,
                    x - s,
                    y - 2,
                    s * 2,
                    4,
                    "#ffffff"
                )
                R(
                    nil,
                    c,
                    x - 2,
                    y - s,
                    4,
                    s * 2,
                    "#ffffff"
                )
                R(
                    nil,
                    c,
                    x - 4,
                    y - 4,
                    8,
                    8,
                    "#c8d8ff"
                )
                c.globalAlpha = 0.3
                R(
                    nil,
                    c,
                    x - 14,
                    y - 14,
                    28,
                    28,
                    "#ffffff"
                )
                c.globalAlpha = 1
            elseif q.tipo == "grao" then
                c:save()
                c:translate(x, y)
                c:rotate(q.rot * 0.5)
                R(
                    nil,
                    c,
                    -6,
                    -8,
                    12,
                    16,
                    "#2a1408"
                )
                R(
                    nil,
                    c,
                    -5,
                    -7,
                    10,
                    14,
                    "#6a3a1c"
                )
                R(
                    nil,
                    c,
                    -1,
                    -6,
                    2,
                    12,
                    "#2a1408"
                )
                R(
                    nil,
                    c,
                    -4,
                    -6,
                    3,
                    3,
                    "#9a5a2c"
                )
                c:restore()
            elseif q.tipo == "cafe" then
                R(
                    nil,
                    c,
                    x - 5,
                    y - 10,
                    10,
                    16,
                    "#1c0e06"
                )
                R(
                    nil,
                    c,
                    x - 4,
                    y - 8,
                    8,
                    13,
                    "#5a2e12"
                )
                R(
                    nil,
                    c,
                    x - 2,
                    y - 12,
                    4,
                    4,
                    "#1c0e06"
                )
                R(
                    nil,
                    c,
                    x - 2,
                    y - 7,
                    2,
                    4,
                    "#c8946a"
                )
            elseif q.tipo == "punho" then
                R(
                    nil,
                    c,
                    x - 11,
                    y - 9,
                    22,
                    18,
                    "#3a0806"
                )
                R(
                    nil,
                    c,
                    x - 10,
                    y - 8,
                    20,
                    16,
                    "#e8433a"
                )
                R(
                    nil,
                    c,
                    x - 10,
                    y - 8,
                    20,
                    4,
                    "#ff8a6a"
                )
                do
                    local k = 0
                    while k < 3 do
                        R(
                            nil,
                            c,
                            x - 8 + k * 6,
                            y - 8,
                            1,
                            16,
                            "#a82a24"
                        )
                        k = k + 1
                    end
                end
                c.globalAlpha = 0.4
                R(
                    nil,
                    c,
                    x - __TS__MathSign(if __t(q.vx) then q.vx else 1) * 24,
                    y - 3,
                    14,
                    6,
                    "#ffb08a"
                )
                c.globalAlpha = 1
            elseif q.tipo == "pixel" then
                do
                    local k = 0
                    while k < 4 do
                        R(
                            nil,
                            c,
                            x - 8 + __mod(k, 2) * 8,
                            y - 8 + __shr(k, 1) * 8,
                            7,
                            7,
                            __get(
                                __arrL({"#5ae0d0", "#e85ad0", "#ffe23a", "#2a8ae8"}, 4),
                                __mod(
                                    k + __shr(
                                        math.abs(x),
                                        4
                                    ),
                                    4
                                )
                            )
                        )
                        k = k + 1
                    end
                end
                R(
                    nil,
                    c,
                    x - 9,
                    y - 9,
                    18,
                    1,
                    "#ffffff88"
                )
            elseif q.tipo == "controle" then
                c:save()
                c:translate(x, y)
                c:rotate(q.rot * 0.4)
                R(
                    nil,
                    c,
                    -12,
                    -6,
                    24,
                    12,
                    "#0e1016"
                )
                R(
                    nil,
                    c,
                    -11,
                    -5,
                    22,
                    10,
                    "#3a3f48"
                )
                R(
                    nil,
                    c,
                    -8,
                    -2,
                    5,
                    2,
                    "#c8ccd0"
                )
                R(
                    nil,
                    c,
                    -7,
                    -3,
                    2,
                    5,
                    "#c8ccd0"
                )
                R(
                    nil,
                    c,
                    5,
                    -3,
                    3,
                    3,
                    "#e8433a"
                )
                R(
                    nil,
                    c,
                    8,
                    0,
                    3,
                    3,
                    "#5ae0d0"
                )
                c:restore()
            elseif q.tipo == "pao" then
                R(
                    nil,
                    c,
                    x - 9,
                    y - 8,
                    18,
                    16,
                    "#5a3a14"
                )
                R(
                    nil,
                    c,
                    x - 8,
                    y - 7,
                    16,
                    14,
                    "#e8b84a"
                )
                R(
                    nil,
                    c,
                    x - 6,
                    y - 7,
                    10,
                    4,
                    "#f6d880"
                )
                R(
                    nil,
                    c,
                    x - 3,
                    y - 1,
                    2,
                    2,
                    "#c8902a"
                )
                R(
                    nil,
                    c,
                    x + 2,
                    y + 2,
                    2,
                    2,
                    "#c8902a"
                )
            elseif q.tipo == "papel" then
                c:save()
                c:translate(x, y)
                c:rotate(q.rot)
                R(
                    nil,
                    c,
                    -7,
                    -7,
                    14,
                    14,
                    "#5a5a62"
                )
                R(
                    nil,
                    c,
                    -6,
                    -6,
                    12,
                    12,
                    "#f6f4ee"
                )
                R(
                    nil,
                    c,
                    -4,
                    -2,
                    8,
                    1,
                    "#8ab8e8"
                )
                R(
                    nil,
                    c,
                    -2,
                    -5,
                    1,
                    9,
                    "#d8d4c8"
                )
                c:restore()
            elseif q.tipo == "carteira" then
                R(
                    nil,
                    c,
                    x - 20,
                    y - 14,
                    40,
                    6,
                    "#3a2414"
                )
                R(
                    nil,
                    c,
                    x - 19,
                    y - 13,
                    38,
                    4,
                    "#a87a54"
                )
                R(
                    nil,
                    c,
                    x - 17,
                    y - 8,
                    3,
                    18,
                    "#5a5e62"
                )
                R(
                    nil,
                    c,
                    x + 14,
                    y - 8,
                    3,
                    18,
                    "#5a5e62"
                )
                R(
                    nil,
                    c,
                    x - 17,
                    y + 2,
                    34,
                    2,
                    "#5a5e62"
                )
            elseif q.tipo == "letra" then
                R(
                    nil,
                    c,
                    x - 11,
                    y - 11,
                    22,
                    22,
                    "#2a0a3a"
                )
                R(
                    nil,
                    c,
                    x - 10,
                    y - 10,
                    20,
                    20,
                    "#c85af0"
                )
                txt(
                    nil,
                    c,
                    if __t(q.letra) then q.letra else "G",
                    x,
                    y - 7,
                    "#ffffff",
                    {s = 3}
                )
            elseif q.tipo == "foto" then
                c:save()
                c:translate(x, y)
                c:rotate(math.sin(q.rot) * 0.3)
                R(
                    nil,
                    c,
                    -12,
                    -14,
                    24,
                    28,
                    "#3a2a1a"
                )
                R(
                    nil,
                    c,
                    -11,
                    -13,
                    22,
                    26,
                    "#f6f2e8"
                )
                R(
                    nil,
                    c,
                    -9,
                    -11,
                    18,
                    14,
                    "#8ac8f0"
                )
                R(
                    nil,
                    c,
                    -9,
                    -1,
                    18,
                    4,
                    "#6aa850"
                )
                R(
                    nil,
                    c,
                    -7,
                    -6,
                    3,
                    5,
                    "#c68a5e"
                )
                R(
                    nil,
                    c,
                    -2,
                    -6,
                    3,
                    5,
                    "#7a4a2e"
                )
                R(
                    nil,
                    c,
                    3,
                    -6,
                    3,
                    5,
                    "#e2b48a"
                )
                c:restore()
            elseif q.tipo == "bronca" then
                local dx = __TS__MathSign(q.vx)
                R(
                    nil,
                    c,
                    x - 34,
                    y - 30,
                    68,
                    30,
                    "#3a0806"
                )
                R(
                    nil,
                    c,
                    x - 32,
                    y - 28,
                    64,
                    26,
                    "#fff6dc"
                )
                txt(
                    nil,
                    c,
                    "BRONCA!",
                    x,
                    y - 20,
                    "#c43c3a",
                    {s = 2}
                )
                do
                    local k = 1
                    while k < 4 do
                        c.globalAlpha = 0.4 / k
                        R(
                            nil,
                            c,
                            x - dx * (34 + k * 12),
                            y - 26 + k * 2,
                            8,
                            22 - k * 4,
                            "#ffffff"
                        )
                        k = k + 1
                    end
                end
                c.globalAlpha = 1
            elseif q.tipo == "onda" then
                c.globalAlpha = 0.9
                do
                    local k = 0
                    while k < 4 do
                        R(
                            nil,
                            c,
                            x - 3 - k * __TS__MathSign(q.vx) * 6,
                            y - 24 + k * 5,
                            6,
                            24 - k * 5,
                            __get(
                                __arrL({"#ffffff", K.cor, K.cor, "#ffffff88"}, 4),
                                k
                            )
                        )
                        k = k + 1
                    end
                end
                c.globalAlpha = 1
            end
        end
        local function personagem(self, c, tipo, x, y, o)
            do
                pcall(function()
                    window.Art:drawCharacter(
                        c,
                        tipo,
                        x,
                        y,
                        __assign({}, {frame = t, grounded = true}, o)
                    )
                end)
            end
        end
        local function barra(self, c, x, y, w, f, cor)
            R(
                nil,
                c,
                x - w / 2 - 1,
                y - 1,
                w + 2,
                6,
                "#1c1408"
            )
            R(
                nil,
                c,
                x - w / 2,
                y,
                w * clamp(nil, f, 0, 1),
                4,
                cor
            )
        end
        local function pisca(____, e)
            local ____t_87 = __t
            local ____opt_84 = window.CampanhaTreino
            if ____opt_84 ~= nil then
                ____opt_84 = ____opt_84.piscando
            end
            local ____opt_result_86
            if ____opt_84 ~= nil then
                ____opt_result_86 = ____opt_84(____opt_84, e)
            end
            return not not ____t_87(____opt_result_86)
        end
        local function desenhar(self, c)
            local percurso = combate:terreno(luta)
            if __t(percurso) then
                percurso:plataformas(c, luta)
            end
            if __t(luta) then
                window.ConquistaEfeitos:fundo(c, luta)
            end
            if __t(if __t(arena.ativa) then not __t(percurso) else arena.ativa) then
                for ____, x in __iterar((__arrL({arena.l, arena.r}, 2))) do
                    c.globalAlpha = 0.16 + math.sin(t * 4) * 0.06
                    R(
                        nil,
                        c,
                        x - 26,
                        FLOOR - 220,
                        52,
                        220,
                        K.cor
                    )
                    c.globalAlpha = 0.3
                    do
                        local y = FLOOR - 220
                        while y < FLOOR do
                            R(
                                nil,
                                c,
                                x - 26,
                                y + __mod(t * 40, 22),
                                52,
                                2,
                                "#ffffff"
                            )
                            y = y + 22
                        end
                    end
                    c.globalAlpha = 1
                    R(
                        nil,
                        c,
                        x - 9,
                        FLOOR - 150,
                        18,
                        150,
                        "#1c1408"
                    )
                    do
                        local y = FLOOR - 148
                        while y < FLOOR do
                            R(
                                nil,
                                c,
                                x - 7,
                                y,
                                14,
                                6,
                                "#ffd24a"
                            )
                            y = y + 12
                        end
                    end
                    do
                        local y = FLOOR - 142
                        while y < FLOOR do
                            R(
                                nil,
                                c,
                                x - 7,
                                y,
                                14,
                                6,
                                "#2a2a2a"
                            )
                            y = y + 12
                        end
                    end
                    R(
                        nil,
                        c,
                        x - 22,
                        FLOOR - 8,
                        44,
                        8,
                        "#1c1408"
                    )
                    R(
                        nil,
                        c,
                        x - 20,
                        FLOOR - 6,
                        40,
                        5,
                        "#e8833a"
                    )
                    R(
                        nil,
                        c,
                        x - 14,
                        FLOOR - 158,
                        28,
                        10,
                        "#1c1408"
                    )
                    R(
                        nil,
                        c,
                        x - 12,
                        FLOOR - 156,
                        24,
                        6,
                        if __t(__mod(
                            math.floor(t * 3),
                            2
                        )) then "#ff3a2a" else "#7a1a1a"
                    )
                    for ____, yy in __iterar((__arrL({FLOOR - 112, FLOOR - 70}, 2))) do
                        R(
                            nil,
                            c,
                            x - 40,
                            yy,
                            80,
                            6,
                            "#1c1408"
                        )
                        do
                            local k = 0
                            while k < 80 do
                                R(
                                    nil,
                                    c,
                                    x - 39 + k,
                                    yy + 1,
                                    6,
                                    4,
                                    "#ffd24a"
                                )
                                k = k + 10
                            end
                        end
                    end
                end
            end
            local ____t_91 = __t
            local ____opt_result_90
            if luta ~= nil then
                ____opt_result_90 = luta.estrada
            end
            if not ____t_91(____opt_result_90) then
                for ____, q in __iterar((curas)) do
                    if not __t(q.pego) then
                        local b = math.sin(t * 3 + q.x) * 3
                        local x = q.x
                        local y = FLOOR - 18 + b
                        c.strokeStyle = "#6a4a2a"
                        c.lineWidth = 6
                        c:beginPath()
                        c:arc(
                            x,
                            y,
                            7,
                            0,
                            TAU
                        )
                        c:stroke()
                        c.strokeStyle = "#f2e2b8"
                        c.lineWidth = 3
                        c:beginPath()
                        c:arc(
                            x,
                            y,
                            7,
                            0,
                            TAU
                        )
                        c:stroke()
                        if math.sin(t * 5 + q.x) > 0.6 then
                            R(
                                nil,
                                c,
                                x + 8,
                                y - 12,
                                2,
                                6,
                                "#fff3a8"
                            )
                            R(
                                nil,
                                c,
                                x + 6,
                                y - 10,
                                6,
                                2,
                                "#fff3a8"
                            )
                        end
                    end
                end
            end
            local ____t_95 = __t
            local ____opt_result_94
            if luta ~= nil then
                ____opt_result_94 = luta.estrada
            end
            if not ____t_95(____opt_result_94) then
                for ____, e in __iterar((inimigos)) do
                    local st = __get(STATS, e.k)
                    local caido = __le(e.hp, 0)
                    if __t(caido) then
                        c.globalAlpha = math.max(0, 1 - e.morto / 1.6)
                    elseif __t(pisca(nil, e)) then
                        c.globalAlpha = 0.25
                    end
                    if st.ia == "voa" then
                        ave(
                            nil,
                            c,
                            e.x,
                            e.y + if __t(caido) then e.morto * 120 else 0,
                            t + e.homeX,
                            e.k,
                            e.dir,
                            __gt(e.hit, 0)
                        )
                    else
                        c:save()
                        if __t(caido) then
                            c:translate(e.x, e.y)
                            c:rotate(__TS__Number(-e.dir) * math.min(1.4, e.morto * 4))
                            c:translate(
                                __TS__Number(-e.x),
                                __TS__Number(-e.y)
                            )
                        end
                        if e.k == "motoca" then
                            local andando = e.st == "ataca"
                            moto(
                                nil,
                                c,
                                e.x,
                                e.y,
                                "#c43c3a",
                                e.dir,
                                t
                            )
                            personagem(
                                nil,
                                c,
                                e.tipo,
                                e.x - e.dir * 4,
                                e.y - 18,
                                {
                                    facing = e.dir,
                                    moving = false,
                                    hit = __gt(e.hit, 0)
                                }
                            )
                            if __t(andando) then
                                do
                                    local k = 1
                                    while k < 5 do
                                        c.globalAlpha = 0.3
                                        R(
                                            nil,
                                            c,
                                            e.x - e.dir * (30 + k * 14),
                                            e.y - 20 + k * 3,
                                            10,
                                            3,
                                            "#ffffff"
                                        )
                                        c.globalAlpha = 1
                                        k = k + 1
                                    end
                                end
                            end
                        else
                            local ____personagem_100 = personagem
                            local ____array_99 = __TS__SparseArrayNew(
                                nil,
                                c,
                                e.tipo,
                                e.x,
                                e.y
                            )
                            local ____e_dir_98 = e.dir
                            local ____t_97 = __t
                            local ____temp_96 = math.abs(e.vx) > 5
                            __O[942] = ____temp_96
                            __TS__SparseArrayPush(
                                ____array_99,
                                {
                                    facing = ____e_dir_98,
                                    moving = if ____t_97(____temp_96) then __O[942] else e.st == "patrulha" and math.abs(P.x - e.x) < 430,
                                    hit = __gt(e.hit, 0),
                                    attack = e.st == "mira",
                                    attackProgress = 0.3
                                }
                            )
                            ____personagem_100(__TS__SparseArraySpread(____array_99))
                        end
                        c:restore()
                    end
                    c.globalAlpha = 1
                    if not __t(caido) then
                        if e.st == "mira" then
                            local pis = __mod(
                                math.floor(t * 10),
                                2
                            )
                            R(
                                nil,
                                c,
                                e.x - 3,
                                e.y - e.alto - 30 - if st.ia == "voa" then -10 else 0,
                                6,
                                12,
                                if __t(pis) then "#ff3a2a" else "#ffd24a"
                            )
                            R(
                                nil,
                                c,
                                e.x - 3,
                                e.y - e.alto - 15 - if st.ia == "voa" then -10 else 0,
                                6,
                                5,
                                if __t(pis) then "#ff3a2a" else "#ffd24a"
                            )
                        end
                        if __lt(e.hp, e.max) then
                            barra(
                                nil,
                                c,
                                e.x,
                                e.y - e.alto - 12,
                                34,
                                e.hp / e.max,
                                "#e8433a"
                            )
                        end
                        if __gt(e.conf, 0) then
                            txt(
                                nil,
                                c,
                                "?!",
                                e.x,
                                e.y - e.alto - 26,
                                "#e48fb0"
                            )
                        end
                        if __gt(e.stun, 0) then
                            do
                                local k = 0
                                while k < 3 do
                                    R(
                                        nil,
                                        c,
                                        e.x + math.cos(t * 6 + k * 2) * 12,
                                        e.y - e.alto - 8 + math.sin(t * 6 + k * 2) * 3,
                                        3,
                                        3,
                                        "#ffd24a"
                                    )
                                    k = k + 1
                                end
                            end
                        end
                    end
                end
            end
            if __t(B.st ~= "espera" or math.abs(P.x - B.x) < 1200) then
                local caido = B.st == "derrotado"
                local sh = if B.st == "carga" then math.floor(math.sin(t * 50) * 2 + 0.5) else 0
                local ____t_102 = __t
                local ____temp_101 = B.fase >= 2 and not __t(caido)
                __O[943] = ____temp_101
                local aura = if ____t_102(____temp_101) then slug ~= "jorge" else __O[943]
                if __t(aura) then
                    do
                        local k = 0
                        while k < 10 do
                            local q = __mod(t * 1.5 + k / 10, 1)
                            c.globalAlpha = (1 - q) * 0.5
                            R(
                                nil,
                                c,
                                B.x + math.sin(k * 2.3) * 22 - 3,
                                B.y - q * 110,
                                6,
                                10,
                                if B.fase >= 3 then if B.fase == 4 then "#f6e0ff" else "#ff5a3a" else K.cor
                            )
                            k = k + 1
                        end
                    end
                end
                c.globalAlpha = 1
                c:save()
                local ____t_105 = __t
                local ____t_104 = __t
                local ____temp_103 = not __t(caido)
                __O[944] = ____temp_103
                if ____t_105(if ____t_104(____temp_103) then pisca(nil, B) else __O[944]) then
                    c.globalAlpha = 0.25
                end
                if __t(caido) then
                    c:translate(B.x, B.y)
                    c:rotate(-B.dir * math.min(1.5, (2.2 - B.tt) * 3))
                    c:translate(
                        __TS__Number(-B.x),
                        -B.y
                    )
                end
                local pose = {
                    scale = 1.3,
                    facing = B.dir,
                    moving = B.st == "recupera",
                    hit = B.hit > 0,
                    attack = B.st == "carga" or B.st == "ataque",
                    attackProgress = if B.st == "carga" then 0.2 else 0.8
                }
                local ____t_109 = __t
                local ____opt_result_108
                if luta ~= nil then
                    ____opt_result_108 = luta.estrada
                end
                if ____t_109(____opt_result_108) then
                    window.PerseguicaoMoto:personagem(c, luta)
                else
                    local ____t_112 = __t
                    local ____t_111 = __t
                    local ____temp_110 = slug == "jorge"
                    __O[945] = ____temp_110
                    if ____t_112(if ____t_111(____temp_110) then luta else __O[945]) then
                        window.JorgeDuelo:personagem(c, luta, pose)
                    elseif __t(luta) then
                        window.ConquistaEfeitos:personagem(
                            c,
                            luta,
                            B.tipo,
                            B.x + sh,
                            B.y,
                            pose
                        )
                    else
                        local ____personagem_117 = personagem
                        local ____c_116 = c
                        local ____t_115 = __t
                        local ____t_114 = __t
                        local ____temp_113 = slug == "jorge"
                        __O[946] = ____temp_113
                        ____personagem_117(
                            nil,
                            ____c_116,
                            if ____t_115(if ____t_114(____temp_113) then caido else __O[946]) then "jorge_promessa" else B.tipo,
                            B.x + sh,
                            B.y,
                            pose
                        )
                    end
                end
                c:restore()
                local ____t_120 = __t
                local ____t_119 = __t
                local ____temp_118 = B.st == "carga"
                __O[947] = ____temp_118
                if ____t_120(if ____t_119(____temp_118) then luta else __O[947]) then
                    txt(
                        nil,
                        c,
                        combate:titulo(luta),
                        B.x,
                        B.y - 124,
                        K.cor,
                        {sombra = "#241d29"}
                    )
                end
                if B.st == "recupera" then
                    do
                        local k = 0
                        while k < 3 do
                            R(
                                nil,
                                c,
                                B.x + math.cos(t * 7 + k * 2.1) * 16,
                                B.y - 108 + math.sin(t * 7 + k * 2.1) * 4,
                                4,
                                4,
                                "#ffd24a"
                            )
                            k = k + 1
                        end
                    end
                    txt(
                        nil,
                        c,
                        "ABERTO!",
                        B.x,
                        B.y - 128,
                        "#7af07a",
                        {sombra = "#1c1408"}
                    )
                end
                local ____t_123 = __t
                local ____t_122 = __t
                local ____temp_121 = if __t(B2) then B.st ~= "espera" else B2
                __O[948] = ____temp_121
                if ____t_123(if ____t_122(____temp_121) then B.st ~= "entrada" else __O[948]) then
                    c:save()
                    if __t(caido) then
                        c:translate(B2.x, B2.y)
                        c:rotate(B2.dir * math.min(1.5, (2.2 - B.tt) * 3))
                        c:translate(
                            __TS__Number(-B2.x),
                            __TS__Number(-B2.y)
                        )
                    end
                    local ____t_126 = __t
                    local ____t_125 = __t
                    local ____temp_124 = not __t(caido)
                    __O[949] = ____temp_124
                    if ____t_126(if ____t_125(____temp_124) then pisca(nil, B2) else __O[949]) then
                        c.globalAlpha = 0.25
                    end
                    personagem(
                        nil,
                        c,
                        B2.tipo,
                        B2.x,
                        B2.y,
                        {
                            scale = 1.3,
                            facing = B2.dir,
                            moving = B2.st == "idle",
                            hit = B2.hit > 0,
                            attack = B2.st == "mira",
                            attackProgress = 0.3
                        }
                    )
                    c:restore()
                    if B2.st == "mira" then
                        local pis = __mod(
                            math.floor(t * 10),
                            2
                        )
                        R(
                            nil,
                            c,
                            B2.x - 4,
                            B2.y - 138,
                            8,
                            16,
                            if __t(pis) then "#ff3a2a" else "#ffd24a"
                        )
                        R(
                            nil,
                            c,
                            B2.x - 4,
                            B2.y - 118,
                            8,
                            7,
                            if __t(pis) then "#ff3a2a" else "#ffd24a"
                        )
                    end
                    if __t(fala2Vida > 0 and not __t(caido)) then
                        c.font = "bold 13px Space, Arial, sans-serif"
                        local w = c:measureText(fala2Txt).width + 20
                        local x = clamp(nil, B2.x - w / 2, arena.l - 40, arena.r + 40 - w)
                        local y = B2.y - 168
                        R(
                            nil,
                            c,
                            x - 2,
                            y - 2,
                            w + 4,
                            26,
                            "#1a5a5a"
                        )
                        R(
                            nil,
                            c,
                            x,
                            y,
                            w,
                            22,
                            "#eafffb"
                        )
                        R(
                            nil,
                            c,
                            B2.x - 4,
                            y + 22,
                            8,
                            6,
                            "#1a5a5a"
                        )
                        c.fillStyle = "#0a3a3a"
                        c.textAlign = "left"
                        c.textBaseline = "middle"
                        c:fillText(fala2Txt, x + 10, y + 12)
                    end
                end
                local ____t_129 = __t
                local ____t_128 = __t
                local ____temp_127 = falaVida > 0 and not __t(caido)
                __O[950] = ____temp_127
                if ____t_129(if ____t_128(____temp_127) then B.st ~= "espera" else __O[950]) then
                    c.font = "bold 13px Space, Arial, sans-serif"
                    local w = c:measureText(falaTxt).width + 20
                    local x = clamp(nil, B.x - w / 2, arena.l - 40, arena.r + 40 - w)
                    local y = B.y - 168
                    R(
                        nil,
                        c,
                        x - 2,
                        y - 2,
                        w + 4,
                        26,
                        "#8a1a1a"
                    )
                    R(
                        nil,
                        c,
                        x,
                        y,
                        w,
                        22,
                        "#fff6dc"
                    )
                    R(
                        nil,
                        c,
                        B.x - 4,
                        y + 22,
                        8,
                        6,
                        "#8a1a1a"
                    )
                    c.fillStyle = "#7a1010"
                    c.textAlign = "left"
                    c.textBaseline = "middle"
                    c:fillText(falaTxt, x + 10, y + 12)
                end
            end
            if __t(luta) then
                window.ConquistaEfeitos:desenhar(c, luta)
            end
            for ____, q in __iterar((projs)) do
                projetil(nil, c, q)
            end
            for ____, f in __iterar((efeitos)) do
                local k = f.t / 0.5
                if f.k == "raio" then
                    c.globalAlpha = 1 - k
                    R(
                        nil,
                        c,
                        f.x - 22,
                        0,
                        44,
                        FLOOR,
                        "#ffffff"
                    )
                    R(
                        nil,
                        c,
                        f.x - 10,
                        0,
                        20,
                        FLOOR,
                        if __t(f.foto) then "#ffe8c0" else "#c8d8ff"
                    )
                    c.globalAlpha = 1
                end
                if f.k == "poeira" then
                    c.globalAlpha = 0.6 * (1 - f.t / 0.6)
                    do
                        local j = 0
                        while j < 4 do
                            R(
                                nil,
                                c,
                                f.x - 20 + j * 12 + math.sin(j) * 4,
                                f.y - 8 - f.t * 30,
                                10 + f.t * 12,
                                6 + f.t * 6,
                                "#e8e0d0"
                            )
                            j = j + 1
                        end
                    end
                    c.globalAlpha = 1
                end
                if f.k == "flashP" then
                    c.globalAlpha = math.max(0, 1 - f.t / 0.4)
                    c.fillStyle = "#ffffff"
                    c:beginPath()
                    c:arc(
                        f.x,
                        f.y,
                        26 + f.t * 120,
                        0,
                        TAU
                    )
                    __call(c, "fill")
                    c.globalAlpha = 1
                end
            end
            c.font = "14px Pixel, monospace"
            c.textAlign = "center"
            for ____, x in __iterar((textos)) do
                c.globalAlpha = 1 - x.t
                c.fillStyle = "#2a1a14"
                c:fillText(x.s, x.x + 2, x.y - x.t * 40 + 2)
                c.fillStyle = x.cor
                c:fillText(x.s, x.x, x.y - x.t * 40)
            end
            c.globalAlpha = 1
            c.textAlign = "left"
        end
        local function desenharTela(self, c, W)
            local ____t_132 = __t
            local ____t_131 = __t
            local ____temp_130 = if __t(arena.ativa) then B.st ~= "espera" else arena.ativa
            __O[951] = ____temp_130
            if ____t_132(if ____t_131(____temp_130) then B.st ~= "entrada" else __O[951]) then
                local w = 420
                local x = W / 2 - w / 2
                local y = 30
                R(
                    nil,
                    c,
                    x - 4,
                    y - 4,
                    w + 8,
                    34,
                    "#1c1408"
                )
                R(
                    nil,
                    c,
                    x - 2,
                    y - 2,
                    w + 4,
                    30,
                    "#4a3420"
                )
                R(
                    nil,
                    c,
                    x,
                    y + 14,
                    w,
                    10,
                    "#2a1a10"
                )
                local ____array_135 = __TS__SparseArrayNew(
                    nil,
                    c,
                    x,
                    y + 14,
                    w * clamp(nil, B.hp / B.max, 0, 1),
                    10
                )
                local ____t_134 = __t
                local ____get_result_133 = __get(
                    __arrL({
                        "#e8433a",
                        "#f0a03a",
                        "#ff5a3a",
                        "#c85af0",
                        "#d9adff"
                    }, 5),
                    B.fase - 1
                )
                __O[952] = ____get_result_133
                __TS__SparseArrayPush(____array_135, if ____t_134(____get_result_133) then __O[952] else "#e8433a")
                R(__TS__SparseArraySpread(____array_135))
                R(
                    nil,
                    c,
                    x,
                    y + 14,
                    w * clamp(nil, B.hp / B.max, 0, 1),
                    3,
                    "#ffffff55"
                )
                c.font = "10px Pixel, monospace"
                c.fillStyle = "#ffe9a8"
                c.textAlign = "left"
                c.textBaseline = "top"
                c:fillText(
                    __add(
                        __add(K.nome, "  ·  NV "),
                        K.nivel
                    ),
                    x + 4,
                    y + 1
                )
                do
                    local f = 1
                    while __le(f, NF) do
                        R(
                            nil,
                            c,
                            x + w - 10 - (NF - f + 1) * 18,
                            y + 1,
                            12,
                            10,
                            if f <= B.fase then if f == B.fase then "#ffd24a" else "#7a6a4a" else "#2a1a10"
                        )
                        f = f + 1
                    end
                end
            end
            for ____, p in __iterar((placas)) do
                local k = p.t
                local a = math.min(1, k / 0.2, (p.vida - k) / 0.3)
                local sc = 1 + math.max(0, 0.25 - k) * 2
                c:save()
                c.globalAlpha = a
                c:translate(W / 2, 210)
                c:scale(sc, sc)
                c.fillStyle = "rgba(12,8,6,.75)"
                c:fillRect(-300, -46, 600, 92)
                c.fillStyle = p.cor
                c:fillRect(-300, -46, 600, 4)
                c:fillRect(-300, 42, 600, 4)
                txt(
                    nil,
                    c,
                    p.titulo,
                    0,
                    -30,
                    p.cor,
                    {s = 5, sombra = "#2a1006"}
                )
                txt(
                    nil,
                    c,
                    p.sub,
                    0,
                    14,
                    "#f6ead0",
                    {s = 2}
                )
                c:restore()
            end
        end
        local function reiniciar(self)
            luta = nil
            __assign(
                B,
                {
                    x = K.x,
                    y = FLOOR,
                    alto = 96,
                    largura = 30,
                    vx = 0,
                    hp = __get(HPF, 0),
                    max = __get(HPF, 0),
                    fase = 1,
                    st = "espera",
                    tt = 0,
                    golpe = nil,
                    padrao = 0,
                    stun = 0,
                    conf = 0,
                    fim = false
                }
            )
            if __t(B2) then
                __assign(
                    B2,
                    {
                        x = __add(K.x, K.dupla.dx),
                        st = "idle",
                        tt = 2,
                        stun = 0
                    }
                )
            end
            arena.ativa = false
            __setlen(projs, 0)
            __setlen(efeitos, 0)
            __setlen(placas, 0)
            vencido = false
            do
                local i = __len(inimigos) - 1
                while i >= 0 do
                    if __t(__get(inimigos, i).invocado) then
                        __call(inimigos, "splice", i, 1)
                    end
                    i = i - 1
                end
            end
        end
        local function comecarLuta(self)
            novaLuta(nil)
            B.st = "idle"
            B.tt = 1.2
            P.x = arena.l + 70
            placa(
                nil,
                K.nome,
                __add(
                    __add(
                        __add("NV ", K.nivel),
                        " · "
                    ),
                    K.titulo
                ),
                K.cor,
                2.3
            )
            api:sfx("vs")
        end
        return __getters(
            {
                slug = slug,
                F = F,
                chefe = B,
                arena = arena,
                inimigos = function()
                    local ____call_144 = __call
                    local ____t_139 = __t
                    local ____opt_result_138
                    if luta ~= nil then
                        ____opt_result_138 = luta.estrada
                    end
                    local ____temp_143 = if ____t_139(____opt_result_138) then __call(
                        __call(
                            luta.estrada.motos,
                            "map",
                            function(____, m) return m.rival end
                        ),
                        "filter",
                        function(____, r) return __gt(r.hp, 0) end
                    ) else inimigos
                    local ____t_142 = __t
                    local ____t_141 = __t
                    local ____temp_140 = B.st ~= "espera" and B.st ~= "derrotado"
                    __O[953] = ____temp_140
                    return ____call_144(____temp_143, "concat", if ____t_142(if ____t_141(____temp_140) then B.st ~= "entrada" else __O[953]) then if __t(B2) then __arrL({B, B2}, 2) else __arrL({B}, 1) else __arrL({}, 0))
                end,
                update = update,
                desenhar = desenhar,
                desenharTela = desenharTela,
                reiniciar = reiniciar,
                comecarLuta = comecarLuta,
                vencida = function() return vencido end,
                emArena = function() return arena.ativa end
            },
            {luta = function()
                return luta
            end}
        )
    end
    window.CampanhaFases = __ord(
        {
            FASES = FASES,
            criar = criar,
            lista = function() return __keys(FASES) end
        },
        "FASES,criar,lista"
    )
end)(nil)
return ____exports
