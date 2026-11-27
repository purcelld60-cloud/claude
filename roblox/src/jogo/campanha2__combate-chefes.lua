--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __gt, __ge, __getq, __mod, __ord, __arrL, __iterar, __t, __get, __len, __call = __JSR.__lt, __JSR.__gt, __JSR.__ge, __JSR.__getq, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__len, __JSR.__call
local __add, __iter, __assign = __JSR.__add, __JSR.__iter, __JSR.__assign
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__Spread = ____lualib.__TS__Spread
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local function clamp(____, n, min, max)
        return math.min(
            max,
            math.max(min, n)
        )
    end
    local function mix(____, a, b, t)
        return a + (b - a) * t
    end
    local function tres(____, a, b, c, d, e, f, g)
        return __arrL(
            {
                __arrL({a, b, e}, 3),
                __arrL({
                    c,
                    f,
                    a,
                    e,
                    b
                }, 5),
                __arrL({
                    d,
                    g,
                    f,
                    c,
                    e,
                    b,
                    a
                }, 7)
            },
            3
        )
    end
    local chefes = __ord(
        {
            creuza = __ord(
                {
                    cor = "#ff96c2",
                    fases = tres(
                        nil,
                        "parapeito",
                        "recado",
                        "encaminhado",
                        "quarteirao",
                        "edicao",
                        "varal",
                        "interfone"
                    )
                },
                "cor,fases"
            ),
            tonhao = __ord(
                {
                    cor = "#ffaf43",
                    fases = tres(
                        nil,
                        "bandeirada",
                        "recibo",
                        "retorno",
                        "contramao",
                        "pneu",
                        "oleo",
                        "capacete"
                    )
                },
                "cor,fases"
            ),
            valdomiro = __ord(
                {
                    cor = "#ffcf74",
                    fases = tres(
                        nil,
                        "rosquinha",
                        "quilo",
                        "peneira",
                        "balanca",
                        "rolo",
                        "fornada",
                        "carimbo"
                    )
                },
                "cor,fases"
            ),
            kaua = __ord(
                {
                    cor = "#76efff",
                    fases = tres(
                        nil,
                        "enquadrar",
                        "curtidas",
                        "carrossel",
                        "reprise",
                        "enquete",
                        "corte",
                        "tripé"
                    )
                },
                "cor,fases"
            ),
            barao = __ord(
                {
                    cor = "#aede70",
                    fases = tres(
                        nil,
                        "semeadura",
                        "coado",
                        "florada",
                        "safra",
                        "regador",
                        "moenda",
                        "terraco"
                    )
                },
                "cor,fases"
            ),
            breno = __ord(
                {
                    cor = "#ff8268",
                    fases = tres(
                        nil,
                        "ribalta",
                        "contrapeso",
                        "deixa",
                        "bis",
                        "roteiro",
                        "mascara",
                        "pendulo"
                    )
                },
                "cor,fases"
            ),
            gemeos = __ord(
                {
                    cor = "#69f1dd",
                    fases = tres(
                        nil,
                        "player1",
                        "player2",
                        "cabolink",
                        "coop",
                        "escape",
                        "invasores",
                        "cartucho"
                    )
                },
                "cor,fases"
            ),
            fred = __ord(
                {
                    cor = "#ffcb55",
                    fases = tres(
                        nil,
                        "pao",
                        "pente",
                        "toque",
                        "clube",
                        "convite",
                        "pulseira",
                        "broche"
                    )
                },
                "cor,fases"
            ),
            jorge = __ord(
                {
                    cor = "#d2aaff",
                    fases = __arrL(
                        {
                            __arrL({"descartar", "retratoPartido"}, 2),
                            __arrL({"saltoBarriga", "descartar", "saltoBarriga", "retratoPartido"}, 4),
                            __arrL({"farpa", "retratoPartido", "descartar"}, 3),
                            __arrL({"rasante", "ruptura", "rasante", "farpa"}, 4),
                            __arrL({"linhaCruzada", "farpa", "retratoPartido", "descartar"}, 4)
                        },
                        5
                    )
                },
                "cor,fases"
            )
        },
        "creuza,tonhao,valdomiro,kaua,barao,breno,gemeos,fred,jorge"
    )
    local capitulos = __arrL(
        {
            __arrL({"Bilhete sem resposta", "bilhete", "#b5dffa"}, 3),
            __arrL({"O peso da lembrança", "tenis", "#ffcb79"}, 3),
            __arrL({"Palavras que partem", "coracao", "#ffa2ba"}, 3),
            __arrL({"O céu se abre", "vitral", "#96f6ff"}, 3),
            __arrL({"Atende, sou eu", "telefone", "#ffdb8d"}, 3)
        },
        5
    )
    local function barras(self, slug, base)
        return __call(
            if slug == "jorge" then __arrL({
                0.56,
                0.68,
                0.8,
                0.93,
                1.03
            }, 5) else __arrL({1, 1.25, 1.5}, 3),
            "map",
            function(____, m) return math.max(
                1,
                math.floor(base * m + 0.5)
            ) end
        )
    end
    local function palco(self, f, p)
        local l = f.l + 36
        local r = f.r - 36
        local dianteira = clamp(
            nil,
            if __t(p.vx) then p.vx else 0 * math.min(0.18, (f.fase - 1) * 0.08) / f.avisoModo,
            -64,
            64
        )
        local x = clamp(nil, p.x + dianteira, l, r)
        local d = if __lt(p.x, f.x) then -1 else 1
        local edge = if d < 0 then l else r
        local function alvo(____, dx)
            return clamp(nil, x + dx, l, r)
        end
        local function mov(____, art, x0, h0, x1, h1, dur, op)
            if op == nil then
                op = {}
            end
            return __assign({}, {
                art = art,
                x0 = x0,
                y0 = f.piso - h0,
                x1 = x1,
                y1 = f.piso - h1,
                dur = dur,
                atraso = 0,
                rx = 16,
                ry = 13,
                dano = 13
            }, op)
        end
        local function area(____, art, cx, largura, altura, atraso, dur)
            if atraso == nil then
                atraso = 0
            end
            if dur == nil then
                dur = 0.37
            end
            local ax = clamp(nil, cx, f.l + largura / 2, f.r - largura / 2)
            return {
                art = art,
                area = true,
                x0 = ax,
                x1 = ax,
                y0 = f.piso - altura / 2,
                y1 = f.piso - altura / 2,
                rx = largura / 2,
                ry = altura / 2,
                atraso = atraso,
                dur = dur,
                dano = 15
            }
        end
        return {
            f = f,
            l = l,
            r = r,
            x = x,
            d = d,
            edge = edge,
            alvo = alvo,
            mov = mov,
            area = area,
            b = f.x,
            twin = f.gemeoX,
            centro = (l + r) / 2,
            setor = function(____, dx) return clamp(nil, x, l + 140, r - 140) + dx end,
            altura = clamp(nil, f.piso - p.y + 27, 25, 270)
        }
    end
    local golpes = __ord(
        {
            parapeito = __arrL(
                {
                    "Plantão na janela",
                    function(____, a) return __arrL(
                        {a:area("janela", a.x, 78, 116)},
                        1
                    ) end
                },
                2
            ),
            recado = __arrL(
                {
                    "Áudio da vizinha",
                    function(____, a) return __arrL(
                        {a:mov(
                            "audio",
                            a.b,
                            68,
                            a.edge,
                            a.altura,
                            1.05,
                            {onda = 19}
                        )},
                        1
                    ) end
                },
                2
            ),
            encaminhado = __arrL(
                {
                    "Encaminhado de novo",
                    function(____, a) return __arrL(
                        {
                            a:mov(
                                "balao",
                                a.b,
                                75,
                                a.edge,
                                28,
                                0.85,
                                {arco = 55}
                            ),
                            a:mov(
                                "audio",
                                a.edge,
                                28,
                                a.b,
                                90,
                                1,
                                {atraso = 0.88, onda = 20}
                            )
                        },
                        2
                    ) end
                },
                2
            ),
            quarteirao = __arrL(
                {
                    "Todas as janelas!",
                    function(____, a) return __arrL(
                        {
                            a:area(
                                "janela",
                                a:setor(-120),
                                105,
                                148,
                                0,
                                0.75
                            ),
                            a:area(
                                "janela",
                                a:setor(120),
                                105,
                                148,
                                0,
                                0.75
                            ),
                            a:area(
                                "janela",
                                a:setor(0),
                                115,
                                175,
                                0.86,
                                0.6
                            )
                        },
                        3
                    ) end
                },
                2
            ),
            bandeirada = __arrL(
                {
                    "Corta a fila!",
                    function(____, a) return __arrL(
                        {a:mov(
                            "motoTonhao",
                            a.b,
                            65,
                            a.edge,
                            65,
                            0.84,
                            {piloto = true, rx = 42, ry = 19}
                        )},
                        1
                    ) end
                },
                2
            ),
            recibo = __arrL(
                {
                    "Cobrança em comboio",
                    function(____, a) return window.PerseguicaoMoto:recibos(a) end
                },
                2
            ),
            retorno = __arrL(
                {
                    "Costura e volta",
                    function(____, a) return __arrL(
                        {
                            a:mov(
                                "motoTonhao",
                                a.b,
                                65,
                                a.edge,
                                65,
                                0.82,
                                {piloto = true, rx = 41, ry = 18}
                            ),
                            a:mov(
                                "motoTonhao",
                                a.edge,
                                65,
                                a.b,
                                65,
                                0.79,
                                {piloto = true, atraso = 1.12, rx = 41, ry = 18}
                            )
                        },
                        2
                    ) end
                },
                2
            ),
            contramao = __arrL(
                {
                    "Blitz nos bagageiros",
                    function(____, a) return window.PerseguicaoMoto:setores(a, "blitz", 82, true) end
                },
                2
            ),
            rosquinha = __arrL(
                {
                    "Biscoito de goma",
                    function(____, a) return __arrL(
                        {
                            a:mov(
                                "biscoito",
                                a.b,
                                58,
                                a.x,
                                20,
                                0.82,
                                {arco = 108}
                            ),
                            a:mov(
                                "biscoito",
                                a.x,
                                20,
                                a.edge,
                                17,
                                0.78,
                                {arco = 54, atraso = 0.82}
                            )
                        },
                        2
                    ) end
                },
                2
            ),
            quilo = __arrL(
                {
                    "Só vendo no quilo!",
                    function(____, a) return __arrL(
                        {
                            a:mov(
                                "saco",
                                a.x,
                                262,
                                a.x,
                                20,
                                0.64,
                                {rx = 19, ry = 20}
                            ),
                            a:area(
                                "farinha",
                                a.x,
                                102,
                                46,
                                0.64,
                                0.38
                            )
                        },
                        2
                    ) end
                },
                2
            ),
            peneira = __arrL(
                {
                    "Sai da peneira!",
                    function(____, a) return __call(
                        __arrL({-88, 88}, 2),
                        "map",
                        function(____, dx, i) return a:mov(
                            "biscoito",
                            a.b,
                            70,
                            a:alvo(dx),
                            17,
                            0.92,
                            {arco = 125, atraso = i * 0.23}
                        ) end
                    ) end
                },
                2
            ),
            balanca = __arrL(
                {
                    "Balança e nuvem de polvilho",
                    function(____, a) return __call(
                        __arrL({-1, 1}, 2),
                        "flatMap",
                        function(____, d, i) return __arrL(
                            {
                                a:mov(
                                    "prato",
                                    a:setor(d * 96),
                                    211,
                                    a:setor(d * 96),
                                    19,
                                    0.54,
                                    {rx = 27, ry = 12, atraso = i * 0.26}
                                ),
                                a:area(
                                    "farinha",
                                    a:setor(d * 96),
                                    128,
                                    76,
                                    0.57 + i * 0.26,
                                    0.75
                                )
                            },
                            2
                        ) end
                    ) end
                },
                2
            ),
            enquadrar = __arrL(
                {
                    "Sai do enquadramento!",
                    function(____, a) return __arrL(
                        {a:area("visor", a.x, 98, 205)},
                        1
                    ) end
                },
                2
            ),
            curtidas = __arrL(
                {
                    "Chuva de curtidas",
                    function(____, a) return __call(
                        __arrL({-55, 55}, 2),
                        "map",
                        function(____, dx, i) return a:mov(
                            "like",
                            a:alvo(dx),
                            228,
                            a:alvo(__TS__Number(-dx)),
                            18,
                            0.96,
                            {onda = 20, atraso = i * 0.38}
                        ) end
                    ) end
                },
                2
            ),
            carrossel = __arrL(
                {
                    "Arrasta pro lado",
                    function(____, a) return __call(
                        __arrL({-114, 0, 114}, 3),
                        "map",
                        function(____, n, i) return a:area(
                            "visor",
                            a:alvo(n),
                            74,
                            196,
                            i * 0.36
                        ) end
                    ) end
                },
                2
            ),
            reprise = __arrL(
                {
                    "Replay em tela dividida",
                    function(____, a) return __arrL(
                        {
                            a:area(
                                "visor",
                                a:setor(-124),
                                118,
                                185,
                                0,
                                0.7
                            ),
                            a:area(
                                "visor",
                                a:setor(124),
                                118,
                                185,
                                0,
                                0.7
                            ),
                            a:area(
                                "visor",
                                a:setor(0),
                                130,
                                215,
                                0.88,
                                0.57
                            ),
                            a:mov(
                                "like",
                                a.b,
                                60,
                                a.edge,
                                63,
                                1.1,
                                {arco = 55, atraso = 0.68}
                            )
                        },
                        4
                    ) end
                },
                2
            ),
            semeadura = __arrL(
                {
                    "Do grão ao pé de café",
                    function(____, a) return __arrL(
                        {
                            a:mov(
                                "grao",
                                a.b,
                                62,
                                a.x,
                                10,
                                0.78,
                                {arco = 103}
                            ),
                            a:area(
                                "cafeeiro",
                                a.x,
                                62,
                                125,
                                0.9,
                                0.52
                            )
                        },
                        2
                    ) end
                },
                2
            ),
            coado = __arrL(
                {
                    "Café passado na hora",
                    function(____, a) return __arrL(
                        {a:mov(
                            "bule",
                            a.b,
                            34,
                            a.edge,
                            28,
                            1.28,
                            {onda = 8, rx = 24, ry = 18}
                        )},
                        1
                    ) end
                },
                2
            ),
            florada = __arrL(
                {
                    "Florada do cafezal",
                    function(____, a) return __call(
                        __arrL({-105, 0, 105}, 3),
                        "map",
                        function(____, dx, i) return a:area(
                            "cafeeiro",
                            a:alvo(dx),
                            59,
                            107 + i * 19,
                            i * 0.3
                        ) end
                    ) end
                },
                2
            ),
            safra = __arrL(
                {
                    "Raízes em fileiras",
                    function(____, a) return __arrL(
                        {
                            a:mov(
                                "grao",
                                a.b,
                                65,
                                a:setor(-110),
                                12,
                                0.61,
                                {arco = 86}
                            ),
                            a:area(
                                "cafeeiro",
                                a:setor(-110),
                                92,
                                138,
                                0.65,
                                0.74
                            ),
                            a:area(
                                "cafeeiro",
                                a:setor(110),
                                92,
                                138,
                                0.65,
                                0.74
                            ),
                            a:area(
                                "cafeeiro",
                                a:setor(0),
                                108,
                                158,
                                1.54,
                                0.52
                            )
                        },
                        4
                    ) end
                },
                2
            ),
            ribalta = __arrL(
                {
                    "Na mira do refletor",
                    function(____, a) return __arrL(
                        {a:area(
                            "refletor",
                            a.x,
                            91,
                            220,
                            0,
                            0.45
                        )},
                        1
                    ) end
                },
                2
            ),
            contrapeso = __arrL(
                {
                    "Cuidado com o cenário!",
                    function(____, a) return __arrL(
                        {
                            a:mov(
                                "peso",
                                a.x,
                                274,
                                a.x,
                                22,
                                0.57,
                                {rx = 23, ry = 22}
                            ),
                            a:mov(
                                "tabua",
                                a.x,
                                13,
                                a.edge,
                                13,
                                0.76,
                                {atraso = 0.59, rx = 23, ry = 10}
                            )
                        },
                        2
                    ) end
                },
                2
            ),
            deixa = __arrL(
                {
                    "A deixa do Pitbull",
                    function(____, a) return __arrL(
                        {
                            a:area(
                                "cortina",
                                a:alvo(-76),
                                72,
                                194
                            ),
                            a:area(
                                "cortina",
                                a:alvo(76),
                                72,
                                194,
                                0.23
                            ),
                            a:mov(
                                "luva",
                                a.b,
                                47,
                                a.x,
                                42,
                                0.54,
                                {piloto = true, atraso = 0.74, rx = 24, ry = 17}
                            )
                        },
                        3
                    ) end
                },
                2
            ),
            bis = __arrL(
                {
                    "Último ato!",
                    function(____, a) return __arrL(
                        {
                            a:area(
                                "refletor",
                                a:setor(0),
                                110,
                                220,
                                0,
                                0.63
                            ),
                            a:area(
                                "cortina",
                                a:setor(-128),
                                96,
                                204,
                                0.81,
                                0.81
                            ),
                            a:area(
                                "cortina",
                                a:setor(128),
                                96,
                                204,
                                0.81,
                                0.81
                            ),
                            a:mov(
                                "tabua",
                                a.x,
                                14,
                                a.b,
                                14,
                                0.76,
                                {atraso = 1.65, rx = 25, ry = 10}
                            )
                        },
                        4
                    ) end
                },
                2
            ),
            player1 = __arrL(
                {
                    "Ryan • comando baixo",
                    function(____, a) return __arrL(
                        {a:mov(
                            "controle1",
                            a.b,
                            44,
                            a.edge,
                            25,
                            1.1
                        )},
                        1
                    ) end
                },
                2
            ),
            player2 = __arrL(
                {
                    "Bryan • comando aéreo",
                    function(____, a) return __arrL(
                        {
                            a:mov(
                                "controle2",
                                a.twin,
                                80,
                                a.x,
                                20,
                                0.87,
                                {arco = 78}
                            ),
                            a:mov(
                                "controle2",
                                a.x,
                                20,
                                a.twin,
                                82,
                                0.85,
                                {arco = 43, atraso = 0.88}
                            )
                        },
                        2
                    ) end
                },
                2
            ),
            cabolink = __arrL(
                {
                    "Cabo link desconectado",
                    function(____, a) return __arrL(
                        {
                            a:mov(
                                "plug1",
                                a.b,
                                26,
                                a.twin,
                                27,
                                1.12,
                                {rx = 20}
                            ),
                            a:mov(
                                "plug2",
                                a.twin,
                                96,
                                a.b,
                                94,
                                1.12,
                                {atraso = 0.34, rx = 20}
                            )
                        },
                        2
                    ) end
                },
                2
            ),
            coop = __arrL(
                {
                    "Checkpoint para dois",
                    function(____, a) return __arrL(
                        {
                            a:mov(
                                "controle1",
                                a.b,
                                40,
                                a.x,
                                27,
                                0.8
                            ),
                            a:mov(
                                "controle2",
                                a.twin,
                                84,
                                a.x,
                                29,
                                0.86,
                                {arco = 72, atraso = 0.3}
                            ),
                            a:area(
                                "checkpoint",
                                a:setor(-116),
                                101,
                                132,
                                1.12,
                                0.72
                            ),
                            a:area(
                                "checkpoint",
                                a:setor(116),
                                101,
                                132,
                                1.12,
                                0.72
                            ),
                            a:area(
                                "checkpoint",
                                a:setor(0),
                                105,
                                116,
                                1.98,
                                0.46
                            )
                        },
                        5
                    ) end
                },
                2
            ),
            pao = __arrL(
                {
                    "Pão de queijo ou biscoito?",
                    function(____, a) return __arrL(
                        {
                            a:mov(
                                "pao",
                                a.b,
                                66,
                                a.x,
                                18,
                                0.82,
                                {arco = 90}
                            ),
                            a:mov(
                                "pao",
                                a.x,
                                18,
                                a.edge,
                                18,
                                0.73,
                                {arco = 62, atraso = 0.82}
                            )
                        },
                        2
                    ) end
                },
                2
            ),
            pente = __arrL(
                {
                    "Pente do topete",
                    function(____, a) return __arrL(
                        {
                            a:mov(
                                "pente",
                                a.b,
                                75,
                                a.edge,
                                a.altura,
                                0.86,
                                {arco = 48}
                            ),
                            a:mov(
                                "pente",
                                a.edge,
                                38,
                                a.b,
                                63,
                                0.97,
                                {atraso = 0.95}
                            )
                        },
                        2
                    ) end
                },
                2
            ),
            toque = __arrL(
                {
                    "Topete, topete… toca aqui!",
                    function(____, a) return __arrL(
                        {
                            a:area("palma", a.x, 68, 97),
                            a:area(
                                "palma",
                                a:alvo(a.d * 96),
                                68,
                                111,
                                0.36
                            ),
                            a:mov(
                                "pao",
                                a.b,
                                62,
                                a.x,
                                23,
                                0.78,
                                {arco = 84, atraso = 0.82}
                            )
                        },
                        3
                    ) end
                },
                2
            ),
            clube = __arrL(
                {
                    "Roda do Clube do Topete",
                    function(____, a) return __arrL(
                        {
                            a:area(
                                "palma",
                                a:setor(-112),
                                109,
                                121,
                                0,
                                0.72
                            ),
                            a:area(
                                "palma",
                                a:setor(112),
                                109,
                                121,
                                0,
                                0.72
                            ),
                            a:area(
                                "palma",
                                a:setor(0),
                                108,
                                145,
                                0.88,
                                0.57
                            ),
                            a:mov(
                                "pente",
                                a.b,
                                47,
                                a.edge,
                                37,
                                0.96,
                                {atraso = 1.16}
                            )
                        },
                        4
                    ) end
                },
                2
            ),
            edicao = __arrL(
                {
                    "Edição extra!",
                    function(____, a) return __arrL(
                        {
                            a:mov(
                                "jornal",
                                a.b,
                                81,
                                a.x,
                                20,
                                0.81,
                                {arco = 95, rx = 23}
                            ),
                            a:mov(
                                "jornal",
                                a.x,
                                20,
                                a.edge,
                                33,
                                0.63,
                                {atraso = 0.82, onda = -16, rx = 23}
                            )
                        },
                        2
                    ) end
                },
                2
            ),
            varal = __arrL(
                {
                    "Roupa suja no varal",
                    function(____, a) return __call(
                        __arrL({-84, 40}, 2),
                        "map",
                        function(____, v, i) return a:mov(
                            "pregador",
                            a:alvo(v),
                            220,
                            a:alvo(v + 34),
                            19,
                            0.59,
                            {atraso = i * 0.38, ry = 21}
                        ) end
                    ) end
                },
                2
            ),
            interfone = __arrL(
                {
                    "Tocou no prédio errado",
                    function(____, a) return __arrL(
                        {
                            a:mov(
                                "fone",
                                a.b,
                                64,
                                a.edge,
                                62,
                                0.83,
                                {onda = 28, rx = 22}
                            ),
                            a:mov(
                                "fone",
                                a.edge,
                                62,
                                a.x,
                                20,
                                0.72,
                                {atraso = 0.85, arco = 50, rx = 22}
                            )
                        },
                        2
                    ) end
                },
                2
            ),
            pneu = __arrL(
                {
                    "Pneu sem freio",
                    function(____, a) return __arrL(
                        {a:mov(
                            "pneu",
                            a.b,
                            74,
                            a.edge,
                            73,
                            1.12,
                            {quiques = 3, arco = 64, rx = 19, ry = 19}
                        )},
                        1
                    ) end
                },
                2
            ),
            oleo = __arrL(
                {
                    "Derrapagem • troque de moto",
                    function(____, a) return window.PerseguicaoMoto:setores(
                        a,
                        "oleo",
                        41,
                        __ge(a.f.fase, 3)
                    ) end
                },
                2
            ),
            capacete = __arrL(
                {
                    "Capacete de carona",
                    function(____, a) return __arrL(
                        {
                            a:mov(
                                "capacete",
                                a.b,
                                113,
                                a.x,
                                a.altura,
                                0.72,
                                {arco = 76, rx = 21}
                            ),
                            a:mov(
                                "capacete",
                                a.x,
                                a.altura,
                                a.b,
                                100,
                                0.68,
                                {atraso = 0.81, onda = -18, rx = 21}
                            )
                        },
                        2
                    ) end
                },
                2
            ),
            rolo = __arrL(
                {
                    "Abre essa massa!",
                    function(____, a) return __arrL(
                        {a:mov(
                            "rolo",
                            a.b,
                            14,
                            a.edge,
                            14,
                            0.8,
                            {rx = 29, ry = 11}
                        )},
                        1
                    ) end
                },
                2
            ),
            fornada = __arrL(
                {
                    "Tabuleiro quente",
                    function(____, a) return __arrL(
                        {
                            a:mov(
                                "forma",
                                a.b,
                                72,
                                a.x,
                                15,
                                0.76,
                                {arco = 108, rx = 27, ry = 11}
                            ),
                            a:area(
                                "vapor",
                                a.x,
                                60,
                                110,
                                0.8,
                                0.53
                            )
                        },
                        2
                    ) end
                },
                2
            ),
            carimbo = __arrL(
                {
                    "Selo da feira",
                    function(____, a) return __call(
                        __arrL({0, -95, 88}, 3),
                        "map",
                        function(____, dx, i) return a:mov(
                            "carimbo",
                            a:alvo(dx),
                            177,
                            a:alvo(dx),
                            13,
                            0.43,
                            {atraso = i * 0.36, rx = 23, ry = 13}
                        ) end
                    ) end
                },
                2
            ),
            enquete = __arrL(
                {
                    "Vota na enquete!",
                    function(____, a) return __call(
                        __arrL({-1, 1}, 2),
                        "map",
                        function(____, s, i) return a:mov(
                            "voto",
                            if s < 0 then a.l else a.r,
                            37 + i * 66,
                            a.x,
                            37 + i * 66,
                            0.78,
                            {letra = if __t(i) then "B" else "A", rx = 23, atraso = i * 0.22}
                        ) end
                    ) end
                },
                2
            ),
            corte = __arrL(
                {
                    "Corta esse take",
                    function(____, a) return __arrL(
                        {
                            a:mov(
                                "tesoura",
                                a.b,
                                138,
                                a.edge,
                                17,
                                0.73,
                                {rx = 22}
                            ),
                            a:mov(
                                "tesoura",
                                a.edge,
                                17,
                                a.b,
                                129,
                                0.83,
                                {atraso = 0.82, rx = 22}
                            )
                        },
                        2
                    ) end
                },
                2
            ),
            ["tripé"] = __arrL(
                {
                    "Caiu a câmera!",
                    function(____, a) return __arrL(
                        {
                            a:mov(
                                "camera",
                                a.x,
                                224,
                                a.x,
                                23,
                                0.56,
                                {rx = 23, ry = 20}
                            ),
                            a:area(
                                "visor",
                                a:alvo(a.d * 87),
                                68,
                                84,
                                0.7
                            )
                        },
                        2
                    ) end
                },
                2
            ),
            regador = __arrL(
                {
                    "Aguaceiro no talhão",
                    function(____, a) return __call(
                        __arrL({-86, -4, 78}, 3),
                        "map",
                        function(____, dx, i) return a:mov(
                            "gota",
                            a:alvo(dx - 28),
                            180 + i * 10,
                            a:alvo(dx),
                            14,
                            0.64,
                            {arco = 25, atraso = i * 0.19, rx = 10, ry = 17}
                        ) end
                    ) end
                },
                2
            ),
            moenda = __arrL(
                {
                    "Manivela da moenda",
                    function(____, a) return __arrL(
                        {a:mov(
                            "moenda",
                            a.b,
                            35,
                            a.edge,
                            33,
                            0.97,
                            {quiques = 2, arco = 39, rx = 21, ry = 21}
                        )},
                        1
                    ) end
                },
                2
            ),
            terraco = __arrL(
                {
                    "Rodo do terreiro",
                    function(____, a) return __arrL(
                        {
                            a:mov(
                                "rodo",
                                a.edge,
                                19,
                                a.b,
                                19,
                                0.89,
                                {rx = 30, ry = 16}
                            ),
                            a:mov(
                                "grao",
                                a.b,
                                24,
                                a.x,
                                38,
                                0.8,
                                {atraso = 0.92, arco = 82}
                            )
                        },
                        2
                    ) end
                },
                2
            ),
            roteiro = __arrL(
                {
                    "Página arrancada",
                    function(____, a) return __arrL(
                        {a:mov(
                            "roteiro",
                            a.b,
                            77,
                            a.edge,
                            52,
                            1,
                            {onda = 46, rx = 19}
                        )},
                        1
                    ) end
                },
                2
            ),
            mascara = __arrL(
                {
                    "Troca de máscara",
                    function(____, a) return __call(
                        __arrL({-1, 1}, 2),
                        "map",
                        function(____, d, i) return a:mov(
                            "mascara",
                            if __t(i) then a.r else a.l,
                            105 - i * 65,
                            a:alvo(d * 28),
                            40 + i * 53,
                            0.8,
                            {onda = 20 * d, atraso = 0.28 * i, rx = 18, ry = 20}
                        ) end
                    ) end
                },
                2
            ),
            pendulo = __arrL(
                {
                    "Lustre fora da marca",
                    function(____, a) return __arrL(
                        {
                            a:mov(
                                "lustre",
                                a:alvo(-140),
                                145,
                                a:alvo(140),
                                145,
                                0.94,
                                {arco = -100, rx = 30, ry = 19}
                            ),
                            a:mov(
                                "lustre",
                                a:alvo(140),
                                145,
                                a:alvo(-140),
                                145,
                                0.89,
                                {arco = -100, atraso = 0.97, rx = 30, ry = 19}
                            )
                        },
                        2
                    ) end
                },
                2
            ),
            escape = __arrL(
                {
                    "Cadê o ESC?",
                    function(____, a) return __call(
                        __arrL({-67, 67}, 2),
                        "map",
                        function(____, dx, i) return a:mov(
                            "tecla",
                            a:alvo(dx),
                            204,
                            a:alvo(dx),
                            18,
                            0.53,
                            {atraso = i * 0.36, rx = 22, ry = 17}
                        ) end
                    ) end
                },
                2
            ),
            invasores = __arrL(
                {
                    "Invasão de oito bits",
                    function(____, a) return __call(
                        __arrL({0, 1, 2}, 3),
                        "map",
                        function(____, i) return a:mov(
                            "invasor",
                            if __t(__mod(i, 2)) then a.twin else a.b,
                            32 + i * 36,
                            if __t(__mod(i, 2)) then a.r else a.l,
                            32 + i * 36,
                            0.98,
                            {onda = 13, atraso = i * 0.26, rx = 18}
                        ) end
                    ) end
                },
                2
            ),
            cartucho = __arrL(
                {
                    "Assopra o cartucho!",
                    function(____, a) return __arrL(
                        {
                            a:mov(
                                "cartucho",
                                a.b,
                                63,
                                a.twin,
                                32,
                                0.76,
                                {arco = 70}
                            ),
                            a:mov(
                                "cartucho",
                                a.twin,
                                32,
                                a.x,
                                17,
                                0.62,
                                {arco = 55, atraso = 0.81}
                            )
                        },
                        2
                    ) end
                },
                2
            ),
            convite = __arrL(
                {
                    "Seu nome ficou de fora",
                    function(____, a) return __arrL(
                        {
                            a:mov(
                                "convite",
                                a.b,
                                65,
                                a.x,
                                22,
                                0.83,
                                {onda = 33, rx = 23}
                            ),
                            a:mov(
                                "convite",
                                a.x,
                                22,
                                a.edge,
                                92,
                                0.62,
                                {atraso = 0.84, rx = 23}
                            )
                        },
                        2
                    ) end
                },
                2
            ),
            pulseira = __arrL(
                {
                    "Pulseira de melhores amigos",
                    function(____, a) return __arrL(
                        {
                            a:mov(
                                "pulseira",
                                a.b,
                                37,
                                a.edge,
                                42,
                                0.69,
                                {onda = 16, rx = 23}
                            ),
                            a:mov(
                                "pulseira",
                                a.edge,
                                42,
                                a.b,
                                85,
                                0.9,
                                {atraso = 0.74, arco = 63, rx = 23}
                            )
                        },
                        2
                    ) end
                },
                2
            ),
            broche = __arrL(
                {
                    "Chuva de distintivos",
                    function(____, a) return __call(
                        __arrL({-90, 0, 90}, 3),
                        "map",
                        function(____, dx, i) return a:mov(
                            "broche",
                            a:alvo(__TS__Number(-dx)),
                            220,
                            a:alvo(dx),
                            18,
                            0.89,
                            {atraso = i * 0.13, rx = 13, ry = 17}
                        ) end
                    ) end
                },
                2
            ),
            descartar = __arrL(
                {
                    "Bilhete devolvido",
                    function(____, a) return __arrL(
                        {a:mov(
                            "bilhete",
                            a.b,
                            73,
                            a.edge,
                            a.altura,
                            0.91,
                            {onda = 24}
                        )},
                        1
                    ) end
                },
                2
            ),
            retratoPartido = __arrL(
                {
                    "Rasgou a nossa foto",
                    function(____, a) return __call(
                        __arrL({-1, 1}, 2),
                        "map",
                        function(____, d, i) return a:mov(
                            if __t(i) then "metade2" else "metade1",
                            a.x,
                            190,
                            if __t(i) then a.r else a.l,
                            23,
                            0.99,
                            {arco = 27, rx = 21, ry = 20}
                        ) end
                    ) end
                },
                2
            ),
            saltoBarriga = __arrL(
                {
                    "Sai de baixo!",
                    function(____, a)
                        local meio = a:alvo(__TS__Number(-a.d) * 78)
                        local final = a:alvo(a.d * 34)
                        return __arrL(
                            {
                                a:mov(
                                    "barriga",
                                    a.b,
                                    52,
                                    meio,
                                    52,
                                    0.79,
                                    {
                                        corpo = 52,
                                        arco = 145,
                                        rx = 39,
                                        ry = 45,
                                        dano = 20
                                    }
                                ),
                                a:mov(
                                    "barriga",
                                    meio,
                                    52,
                                    final,
                                    52,
                                    0.59,
                                    {
                                        corpo = 52,
                                        arco = 86,
                                        atraso = 0.88,
                                        rx = 39,
                                        ry = 45,
                                        dano = 18
                                    }
                                )
                            },
                            2
                        )
                    end
                },
                2
            ),
            farpa = __arrL(
                {
                    "Palavras que partem",
                    function(____, a)
                        local falas = __arrL({"O trio já era.", "Nem senti falta.", "Você ficou pra trás.", "Era só por pena."}, 4)
                        local ____get_4 = __get
                        local ____mod_3 = __mod
                        local ____a_f_0, ____farpas_1 = a.f, "farpas"
                        local ____a_f_farpas_2 = ____a_f_0[____farpas_1]
                        ____a_f_0[____farpas_1] = ____a_f_farpas_2 + 1
                        local fala = ____get_4(
                            falas,
                            ____mod_3(
                                ____a_f_farpas_2,
                                __len(falas)
                            )
                        )
                        local rx = math.ceil(__len(fala) * 3.65) + 7
                        local altura = a.f.piso - a.f.y + 57
                        return __arrL(
                            {a:mov(
                                "farpa",
                                clamp(nil, a.b, a.f.l + rx, a.f.r - rx),
                                altura,
                                clamp(nil, a.edge, a.f.l + rx, a.f.r - rx),
                                a.altura,
                                1.23,
                                {palavra = fala, rx = rx, ry = 15, onda = 13}
                            )},
                            1
                        )
                    end
                },
                2
            ),
            rasante = __arrL(
                {
                    "Rasante da saudade",
                    function(____, a) return __arrL(
                        {a:mov(
                            "rasante",
                            a.b,
                            a.f.piso - a.f.y + 40,
                            a:alvo(a.d * 45),
                            clamp(nil, a.altura, 62, 198),
                            0.97,
                            {
                                corpo = 40,
                                arco = -19,
                                rx = 24,
                                ry = 38,
                                dano = 18
                            }
                        )},
                        1
                    ) end
                },
                2
            ),
            ruptura = __arrL(
                {
                    "Metade do céu vai cair",
                    function(____, a) return __call(
                        window.JorgeDuelo:marcar(a.f),
                        "map",
                        function(____, i) return {
                            art = "fratura",
                            ilha = i.id,
                            x0 = i.x + i.w / 2,
                            x1 = i.x + i.w / 2,
                            y0 = i.y - 5,
                            y1 = i.y - 5,
                            rx = i.w / 2,
                            ry = 7,
                            atraso = 0,
                            dur = 0.28,
                            dano = 15,
                            area = true
                        } end
                    ) end
                },
                2
            ),
            linhaCruzada = __arrL(
                {
                    "A última chamada",
                    function(____, a) return __arrL(
                        {
                            a:mov(
                                "metade1",
                                a.l,
                                46,
                                a.centro,
                                135,
                                0.93,
                                {arco = 48}
                            ),
                            a:mov(
                                "metade2",
                                a.r,
                                46,
                                a.centro,
                                135,
                                0.93,
                                {arco = 48}
                            ),
                            a:area(
                                "sinal",
                                a:setor(-116),
                                108,
                                183,
                                0.91,
                                0.69
                            ),
                            a:area(
                                "sinal",
                                a:setor(116),
                                108,
                                183,
                                0.91,
                                0.69
                            ),
                            a:mov(
                                "passagem",
                                a.centro,
                                130,
                                a.x,
                                22,
                                0.88,
                                {atraso = 1.35, onda = 18}
                            )
                        },
                        5
                    ) end
                },
                2
            )
        },
        "parapeito,recado,encaminhado,quarteirao,bandeirada,recibo,retorno,contramao,rosquinha,quilo,peneira,balanca,enquadrar,curtidas,carrossel,reprise,semeadura,coado,florada,safra,ribalta,contrapeso,deixa,bis,player1,player2,cabolink,coop,pao,pente,toque,clube,edicao,varal,interfone,pneu,oleo,capacete,rolo,fornada,carimbo,enquete,corte,tripé,regador,moenda,terraco,roteiro,mascara,pendulo,escape,invasores,cartucho,convite,pulseira,broche,descartar,retratoPartido,saltoBarriga,farpa,rasante,ruptura,linhaCruzada"
    )
    local function criar(self, slug, x, piso, l, r, modo, recuperacao)
        if modo == nil then
            modo = {}
        end
        if recuperacao == nil then
            recuperacao = __arrL({1, 0.9, 0.8}, 3)
        end
        local f = {
            slug = slug,
            x = x,
            y = piso,
            piso = piso,
            l = l,
            r = r,
            ceu = nil,
            estrada = nil,
            farpas = 0,
            gemeoX = if slug == "gemeos" then l + 43 else nil,
            fase = 1,
            indice = 0,
            estado = "idle",
            tempo = 0,
            dur = 0,
            idade = 0,
            objetos = __arrL({}, 0),
            marcas = __arrL({}, 0),
            golpe = "",
            destino = x,
            avisoModo = if __t(modo.windup) then modo.windup else 1,
            recuperacao = recuperacao,
            jogadorAnteriorX = nil,
            jogadorAnteriorY = nil
        }
        if slug == "tonhao" then
            f.estrada = window.PerseguicaoMoto:criar(l, r, piso)
            f.y = piso - 65
            window.PerseguicaoMoto:novaFase(f, 1)
        end
        return f
    end
    local function terreno(self, f)
        local ____t_8 = __t
        local ____opt_result_7
        if f ~= nil then
            ____opt_result_7 = f.estrada
        end
        local ____t_12 = __t
        local ____opt_result_11
        if f ~= nil then
            ____opt_result_11 = f.ceu
        end
        return if ____t_8(____opt_result_7) then window.PerseguicaoMoto else if ____t_12(____opt_result_11) then window.JorgeDuelo else nil
    end
    local function preparar(self, f, p)
        local lista = __get(
            __get(chefes, f.slug).fases,
            f.fase - 1
        )
        local ____f_18 = f
        local ____get_17 = __get
        local ____mod_16 = __mod
        local ____f_13, ____indice_14 = f, "indice"
        local ____f_indice_15 = ____f_13[____indice_14]
        ____f_13[____indice_14] = ____f_indice_15 + 1
        ____f_18.golpe = ____get_17(
            lista,
            ____mod_16(
                ____f_indice_15,
                __len(lista)
            )
        )
        f.objetos = __get(
            __get(golpes, f.golpe),
            1
        )(
            nil,
            palco(nil, f, p)
        )
        local ritmo = (1.42 + (f.fase - 1) * 0.085) / math.sqrt(f.avisoModo)
        for ____, o in __iterar((f.objetos)) do
            o.dur = o.dur / ritmo
            o.atraso = o.atraso / ritmo
        end
        f.estado = "windup"
        f.tempo = 0
        local aviso = if f.golpe == "ruptura" then 1.24 else if f.golpe == "saltoBarriga" then 0.91 else 0.78 - (f.fase - 1) * 0.04
        f.dur = math.max(if f.golpe == "ruptura" then 1.1 else 0.52, aviso * f.avisoModo)
    end
    local function trocar(self, f, fase, jogador)
        if f.slug == "jorge" then
            window.JorgeDuelo:mudar(f, fase, jogador)
        end
        if __t(f.estrada) then
            window.PerseguicaoMoto:novaFase(f, fase)
        end
        f.fase = fase
        f.indice = 0
        f.estado = "phaseChange"
        f.tempo = 0
        f.dur = if f.slug == "jorge" then 1.65 else 1.05
        f.objetos = __arrL({}, 0)
        f.marcas = __arrL({}, 0)
        f.golpe = ""
        local ____f_19 = f
        f.jogadorAnteriorY = nil
        ____f_19.jogadorAnteriorX = nil
        return f.dur
    end
    local function ponto(self, o, t)
        t = clamp(nil, t, 0, 1)
        return {
            x = mix(nil, o.x0, o.x1, t),
            y = mix(nil, o.y0, o.y1, t) - if __t(o.arco) then o.arco else 0 * if __t(o.quiques) then math.abs(math.sin(t * math.pi * o.quiques)) else 4 * t * (1 - t) - if __t(o.onda) then o.onda else 0 * math.sin(t * math.pi * 2)
        }
    end
    local function cruzaCaixa(self, x0, y0, x1, y1, rx, ry)
        local dx = (x1 - x0) / 2
        local dy = (y1 - y0) / 2
        local cx = x0 + dx
        local cy = y0 + dy
        local ____t_21 = __t
        local ____temp_20 = __lt(
            math.abs(cx),
            rx + math.abs(dx)
        ) and __lt(
            math.abs(cy),
            ry + math.abs(dy)
        )
        __O[909] = ____temp_20
        return if ____t_21(____temp_20) then math.abs(cx * dy - cy * dx) <= rx * math.abs(dy) + ry * math.abs(dx) else __O[909]
    end
    local function contatoNoQuadro(self, o, fim, tempo, dt, p, xAntes, yAntes)
        local inicio = math.max(tempo - dt, o.atraso)
        local termino = math.min(
            tempo,
            __add(o.atraso, o.dur)
        )
        local function fracao(____, instante)
            return if __gt(dt, 0) then clamp(nil, 1 - (tempo - instante) / dt, 0, 1) else 1
        end
        local inicioRel = (inicio - o.atraso) / o.dur
        local primeiro = ponto(nil, o, inicioRel)
        local u = fracao(nil, inicio)
        local x0 = primeiro.x - mix(nil, xAntes, p.x, u)
        local y0 = primeiro.y - mix(nil, yAntes, p.y, u) + 26
        local passos = if __t(if __t(o.arco) then o.arco else o.onda) then math.max(
            1,
            math.ceil((termino - inicio) * 60)
        ) else 1
        do
            local i = 1
            while i <= passos do
                local instante = mix(nil, inicio, termino, i / passos)
                local v = fracao(nil, instante)
                local pos = if i == passos then fim else ponto(nil, o, (instante - o.atraso) / o.dur)
                local x1 = pos.x - mix(nil, xAntes, p.x, v)
                local y1 = pos.y - mix(nil, yAntes, p.y, v) + 26
                if __t(cruzaCaixa(
                    nil,
                    x0,
                    y0,
                    x1,
                    y1,
                    o.rx + 13,
                    o.ry + 26
                )) then
                    return true
                end
                x0 = x1
                y0 = y1
                i = i + 1
            end
        end
        return false
    end
    local function impacto(self, f, o, pos)
        if __ge(
            __len(f.marcas),
            8
        ) then
            __call(f.marcas, "shift")
        end
        __call(f.marcas, "push", {art = o.art, x = pos.x, y = pos.y, idade = 0})
    end
    local function atualizar(self, f, dt, p, ferir, som)
        local ____f_jogadorAnteriorX_22 = f.jogadorAnteriorX
        if ____f_jogadorAnteriorX_22 == nil then
            ____f_jogadorAnteriorX_22 = p.x
        end
        local xAntes = ____f_jogadorAnteriorX_22
        local ____f_jogadorAnteriorY_23 = f.jogadorAnteriorY
        if ____f_jogadorAnteriorY_23 == nil then
            ____f_jogadorAnteriorY_23 = p.y
        end
        local yAntes = ____f_jogadorAnteriorY_23
        f.jogadorAnteriorX = p.x
        f.jogadorAnteriorY = p.y
        f.idade = __add(f.idade, dt)
        f.tempo = __add(f.tempo, dt)
        if __t(f.ceu) then
            window.JorgeDuelo:flutuar(f, dt)
        end
        do
            local i = __len(f.marcas) - 1
            while i >= 0 do
                local ____gt_25 = __gt
                local ____add_result_24 = __add(
                    __get(f.marcas, i).idade,
                    dt
                )
                __get(f.marcas, i).idade = ____add_result_24
                if ____gt_25(____add_result_24, 0.28) then
                    __call(f.marcas, "splice", i, 1)
                end
                i = i - 1
            end
        end
        if f.estado == "idle" then
            preparar(nil, f, p)
            return
        end
        if __t(f.estado == "phaseChange" or f.estado == "recover") then
            if f.estado == "recover" then
                local passo = (128 + 10 * (f.fase - 1)) * dt
                f.x = f.x + clamp(nil, f.destino - f.x, -passo, passo)
            end
            if __ge(f.tempo, f.dur) then
                preparar(nil, f, p)
            end
            return
        end
        if f.estado == "windup" then
            if __lt(f.tempo, f.dur) then
                return
            end
            f.tempo = f.tempo - f.dur
            f.estado = "firing"
            f.dur = math.max(__TS__Spread(__iter(__call(
                f.objetos,
                "map",
                function(____, o) return __add(o.atraso, o.dur) end
            ))))
            if f.golpe == "ruptura" then
                window.JorgeDuelo:romper(f, p)
            end
            if som ~= nil then
                som(nil, f.slug, f.fase)
            end
        end
        for ____, o in __iterar((f.objetos)) do
            local t = (f.tempo - o.atraso) / o.dur
            local ____t_30 = __t
            local ____t_29 = __t
            local ____temp_28 = t < 0
            __O[910] = ____temp_28
            if ____t_30(if ____t_29(____temp_28) then __O[910] else o.fim) then
                continue
            end
            local pos = ponto(nil, o, t)
            if __t(if __t(o.piloto) then o.piloto else o.corpo) then
                f.x = pos.x
            end
            if __t(o.corpo) then
                f.y = pos.y + o.corpo
            end
            local ____t_33 = __t
            local ____t_32 = __t
            local ____temp_31 = not __t(o.acertou)
            __O[911] = ____temp_31
            if ____t_33(if ____t_32(____temp_31) then contatoNoQuadro(
                nil,
                o,
                pos,
                f.tempo,
                dt,
                p,
                xAntes,
                yAntes
            ) else __O[911]) then
                o.acertou = true
                impacto(nil, f, o, pos)
                ferir(nil, o.dano, pos.x)
            end
            if t >= 1 then
                o.fim = true
                if not __t(o.acertou) then
                    impacto(nil, f, o, pos)
                end
            end
        end
        if __lt(f.tempo, f.dur) then
            return
        end
        f.estado = "recover"
        f.tempo = 0
        f.objetos = __arrL({}, 0)
        local base = __get(
            f.recuperacao,
            math.min(
                f.fase - 1,
                __len(f.recuperacao) - 1
            )
        )
        f.dur = math.max(0.3, base * (0.7 - (f.fase - 1) * 0.015))
        local dir = if __ge(f.x, p.x) then 1 else -1
        f.destino = clamp(nil, p.x + dir * 218, f.l + 52, f.r - 52)
    end
    local function capitulo(self, f)
        return if f.slug == "jorge" then __get(capitulos, f.fase - 1) else nil
    end
    local function titulo(self, f)
        local ____t_35 = __t
        local ____getq_result_34 = __getq(
            __get(golpes, f.golpe),
            0
        )
        __O[912] = ____getq_result_34
        return if ____t_35(____getq_result_34) then __O[912] else ""
    end
    window.ConquistaCombate = __ord({
        chefes = chefes,
        criar = criar,
        preparar = preparar,
        trocar = trocar,
        atualizar = atualizar,
        ponto = ponto,
        barras = barras,
        capitulo = capitulo,
        titulo = titulo,
        terreno = terreno
    }, "chefes,criar,preparar,trocar,atualizar,ponto,barras,capitulo,titulo,terreno")
end)(nil)
return ____exports
