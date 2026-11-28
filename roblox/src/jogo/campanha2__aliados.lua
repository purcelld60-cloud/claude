--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __le, __gt, __ge, __mod, __ord, __arrL, __iterar, __t, __get, __set, __len = __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__len
local __call, __add = __JSR.__call, __JSR.__add
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__MathSign = ____lualib.__TS__MathSign
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local ____exports = {}
local __O = {};
(function()
    local pistas, lojaPicole, iniciarCorrida, iniciarRitmo, bater, ferroVelho, vidaMax, FLOOR, TAU, clamp, api, t, corrida, ritmo, X, tem, marca, moedas, ganhar
    function pistas(self)
        local n = __len(__call(
            __arrL({"pista_vocida", "pista_larissa", "pista_carlinhos"}, 3),
            "filter",
            tem
        ))
        if __t(n >= 3 and not __t(tem(nil, "pistas_ok"))) then
            marca(nil, "pistas_ok")
            ganhar(nil, 90)
            api:item("AS 3 PISTAS DO JORGE · +90 MOEDAS")
            api:sfx("fanfarra")
        else
            api:aviso(("PISTA DO JORGE (" .. tostring(n)) .. "/3)")
        end
    end
    function lojaPicole(self)
        local ____arrL_65 = __arrL
        local ____temp_63 = {
            t = "Picolé Sigma (cura 40) · ● 15",
            preco = 15,
            f = function()
                api.P.hp = math.min(
                    vidaMax(nil),
                    api.P.hp + 40
                )
                api:aviso("+40 DE VIDA · SIGMA DEMAIS")
            end
        }
        local ____temp_64 = {
            t = "Picolé Mega Chad (cura tudo) · ● 40",
            preco = 40,
            f = function()
                api.P.hp = vidaMax(nil)
                api:aviso("VIDA CHEIA · CHAD SUPREMO")
            end
        }
        local ____t_57 = __t
        local ____t_result_56
        local ____t_55 = __t
        local ____tem_result_54 = tem(nil, "biscoito_cao")
        __O[879] = ____tem_result_54
        if ____t_55(____tem_result_54) then
            ____t_result_56 = __O[879]
        else
            ____t_result_56 = tem(nil, "cao")
        end
        local ____temp_61 = ____t_57(____t_result_56) and "Biscoito do cachorro (já comprado)" or "Biscoito de polvilho pro cachorro · ● 10"
        local function ____temp_62()
            marca(nil, "biscoito_cao")
            api:item("BISCOITO DE POLVILHO")
        end
        local ____t_result_60
        local ____t_59 = __t
        local ____tem_result_58 = tem(nil, "biscoito_cao")
        __O[880] = ____tem_result_58
        if ____t_59(____tem_result_58) then
            ____t_result_60 = __O[880]
        else
            ____t_result_60 = tem(nil, "cao")
        end
        local ops = ____arrL_65({____temp_63, ____temp_64, {t = ____temp_61, preco = 10, f = ____temp_62, usado = ____t_result_60}, {t = "Só olhando", sair = true}}, 4)
        api:escolher(
            "TIO DO PICOLÉ",
            "Picolé com nome de meme! O que vai ser?",
            __call(
                ops,
                "map",
                function(____, o) return {t = o.t, ok = true, f = o} end
            ),
            function(____, o)
                local ____opt_result_68
                if o ~= nil then
                    ____opt_result_68 = o.f
                end
                local p = ____opt_result_68
                local ____t_74 = __t
                local ____t_result_73
                local ____t_72 = __t
                local ____t_result_71
                local ____t_70 = __t
                local ____temp_69 = not __t(p)
                __O[881] = ____temp_69
                if ____t_70(____temp_69) then
                    ____t_result_71 = __O[881]
                else
                    ____t_result_71 = p.sair
                end
                __O[882] = ____t_result_71
                if ____t_72(____t_result_71) then
                    ____t_result_73 = __O[882]
                else
                    ____t_result_73 = p.usado
                end
                if ____t_74(____t_result_73) then
                    return
                end
                if __lt(
                    moedas(nil),
                    p.preco
                ) then
                    api:aviso("Moedas não dão. Derrote uns inimigos!")
                    return
                end
                ganhar(
                    nil,
                    __TS__Number(-p.preco)
                )
                p:f()
                api:sfx("plim")
            end
        )
    end
    function iniciarCorrida(self)
        corrida = {
            t = 0,
            lim = 26,
            ida = false,
            nando = 3520,
            fim = 4700,
            volta = 3520,
            fase = "contagem",
            cont = 3
        }
        api:aviso("CORRIDA! ATÉ A BANDEIRA E DE VOLTA")
    end
    function iniciarRitmo(self)
        local el = window.document:createElement("div")
        el.className = "c2-ritmo"
        api:tela():appendChild(el)
        local cv = window.document:createElement("canvas")
        cv.width = 480
        cv.height = 270
        el:appendChild(cv)
        if not __t(window.document:getElementById("c2RitmoCss")) then
            local st = window.document:createElement("style")
            st.id = "c2RitmoCss"
            st.textContent = ".c2-ritmo{position:absolute;inset:0;z-index:20;background:#05030a;touch-action:none}.c2-ritmo canvas{width:100%;height:100%;image-rendering:pixelated;display:block}"
            window.document.head:appendChild(st)
        end
        local LANES = __arrL({"ArrowLeft", "ArrowDown", "ArrowUp", "ArrowRight"}, 4)
        local ALT = __arrL({"KeyD", "KeyF", "KeyJ", "KeyK"}, 4)
        local N = 28
        local BPM = 112
        local beat = 60 / BPM
        local notas = __arrL({}, 0)
        do
            local i = 0
            while i < N do
                __call(
                    notas,
                    "push",
                    {
                        t = 2 + i * beat * (__mod(i, 7) == 6 and 1 or 0.75 + (__mod(i, 3) == 0 and 0.25 or 0)),
                        lane = __get(
                            __arrL({
                                0,
                                2,
                                1,
                                3,
                                0,
                                1,
                                2,
                                3,
                                3,
                                0,
                                2,
                                1
                            }, 12),
                            __mod(i, 12)
                        ),
                        ok = nil
                    }
                )
                i = i + 1
            end
        end
        do
            local i = 1
            while i < N do
                __get(notas, i).t = math.max(
                    __get(notas, i).t,
                    __get(notas, i - 1).t + beat * 0.75
                )
                i = i + 1
            end
        end
        ritmo = {
            t = 0,
            notas = notas,
            acertos = 0,
            combo = 0,
            msg = "",
            msgT = 0,
            fim = __get(notas, N - 1).t + 2,
            el = el,
            c = cv:getContext("2d")
        }
        local function tecla(____, e)
            local ____temp_81
            if __call(LANES, "indexOf", e.code) >= 0 then
                ____temp_81 = __call(LANES, "indexOf", e.code)
            else
                ____temp_81 = __call(ALT, "indexOf", e.code)
            end
            local i = ____temp_81
            if __t(i < 0 or not __t(ritmo)) then
                return
            end
            e:preventDefault()
            e:stopImmediatePropagation()
            bater(nil, i)
        end
        local function toque(____, e)
            local r = cv:getBoundingClientRect()
            bater(
                nil,
                clamp(
                    nil,
                    math.floor((e.clientX - r.left) / r.width * 4),
                    0,
                    3
                )
            )
        end
        ritmo.sair = function()
            window:removeEventListener("keydown", tecla, true)
            el:remove()
        end
        window:addEventListener("keydown", tecla, true)
        cv:addEventListener("pointerdown", toque)
        api:pausar(true)
    end
    function bater(self, i)
        local r = ritmo
        local best = nil
        local d = 0.26
        for ____, n in __iterar((r.notas)) do
            local ____t_85 = __t
            local ____t_result_84
            local ____t_83 = __t
            local ____temp_82 = n.ok == nil and n.lane == i
            __O[884] = ____temp_82
            if ____t_83(____temp_82) then
                ____t_result_84 = math.abs(n.t - r.t) < d
            else
                ____t_result_84 = __O[884]
            end
            if ____t_85(____t_result_84) then
                d = math.abs(n.t - r.t)
                best = n
            end
        end
        if __t(best) then
            best.ok = d < 0.12 and 2 or 1
            r.acertos = r.acertos + (best.ok == 2 and 1 or 0.7)
            r.combo = r.combo + 1
            r.msg = best.ok == 2 and "PERFEITO!" or "BOM!"
            do
                pcall(function()
                    local ____opt_88 = window.Roteiro
                    if ____opt_88 ~= nil then
                        ____opt_88 = ____opt_88.sfx
                    end
                    if ____opt_88 ~= nil then
                        ____opt_88(____opt_88, "plim")
                    end
                end)
            end
        else
            r.combo = 0
            r.msg = "ERROU!"
        end
        r.msgT = 0.5
        r.lane = i
        r.laneT = 0.15
    end
    function ferroVelho(self, c)
        local function R(____, x, y, w, h, col)
            c.fillStyle = col
            c:fillRect(
                math.floor(x + 0.5),
                math.floor(y + 0.5),
                w,
                h
            )
        end
        local x0 = 3930
        R(
            nil,
            x0,
            FLOOR - 120,
            260,
            120,
            "#4a5058"
        )
        do
            local x = 0
            while x < 260 do
                R(
                    nil,
                    x0 + x,
                    FLOOR - 120,
                    2,
                    120,
                    __t(__mod(x, 8)) and "#5a6068" or "#3a4048"
                )
                x = x + 4
            end
        end
        do
            local i = 0
            while i < 30 do
                R(
                    nil,
                    x0 + __mod(i * 37, 250),
                    FLOOR - 118 + __mod(i * 23, 100),
                    6 + __mod(i, 8),
                    3 + __mod(i, 5),
                    "#7a4224"
                )
                i = i + 1
            end
        end
        R(
            nil,
            x0 + 70,
            FLOOR - 80,
            120,
            80,
            "#1c1612"
        )
        R(
            nil,
            x0 + 74,
            FLOOR - 76,
            112,
            76,
            "#2a2420"
        )
        do
            local y = FLOOR - 74
            while y < FLOOR do
                R(
                    nil,
                    x0 + 74,
                    y,
                    112,
                    2,
                    "#3a3430"
                )
                y = y + 6
            end
        end
        R(
            nil,
            x0 + 20,
            FLOOR - 150,
            220,
            30,
            "#1c1408"
        )
        R(
            nil,
            x0 + 22,
            FLOOR - 148,
            216,
            26,
            "#c8a24a"
        )
        local ____opt_204 = window.CampanhaCamadas
        if ____opt_204 ~= nil then
            ____opt_204 = ____opt_204.kit
        end
        local ____opt_result_206
        if ____opt_204 ~= nil then
            ____opt_result_206 = ____opt_204.pxText
        end
        if ____opt_result_206 ~= nil then
            ____opt_result_206(
                ____opt_204,
                c,
                "FERRO-VELHO DO GUGU",
                x0 + 130,
                FLOOR - 143,
                "#3a1a08",
                {s = 2}
            )
        end
        do
            local k = 0
            while k < 3 do
                c.fillStyle = "#121212"
                c:beginPath()
                c:ellipse(
                    x0 + 30,
                    FLOOR - 6 - k * 12,
                    22,
                    7,
                    0,
                    0,
                    TAU
                )
                __call(c, "fill")
                k = k + 1
            end
        end
        R(
            nil,
            x0 + 200,
            FLOOR - 30,
            50,
            30,
            "#7a2a24"
        )
        R(
            nil,
            x0 + 204,
            FLOOR - 28,
            20,
            10,
            "#3a4a5a"
        )
        if __mod(
            math.floor(t * 6),
            7
        ) == 0 then
            do
                local k = 0
                while k < 6 do
                    R(
                        nil,
                        x0 + 130 + math.random() * 20,
                        FLOOR - 40 - math.random() * 20,
                        2,
                        2,
                        "#ffe23a"
                    )
                    k = k + 1
                end
            end
        end
    end
    function vidaMax(self)
        return 100 + (X(nil).lurdes == "feita" and 20 or 0)
    end
    local ____ = "use strict"
    if __t(window.CampanhaAliados) then
        return
    end
    FLOOR = 440
    TAU = math.pi * 2
    clamp = function(____, v, a, b) return math.max(
        a,
        math.min(b, v)
    ) end
    api = nil
    t = 0
    local cao = nil
    corrida = nil
    ritmo = nil
    X = function()
        local S = api:S()
        local ____S_flags_1 = S.flags
        local ____t_result_0
        if __t(S.flags.extra) then
            ____t_result_0 = S.flags.extra
        else
            ____t_result_0 = {}
        end
        ____S_flags_1.extra = ____t_result_0
        return S.flags.extra
    end
    tem = function(____, k) return not not __t(__get(
        X(nil),
        k
    )) end
    marca = function(____, k, v)
        if v == nil then
            v = 1
        end
        __set(
            X(nil),
            k,
            v
        )
        api:salvar()
    end
    moedas = function()
        local ____opt_4 = window.CampanhaLoja
        if ____opt_4 ~= nil then
            ____opt_4 = ____opt_4.moedas
        end
        local ____opt_result_6
        if ____opt_4 ~= nil then
            ____opt_result_6 = ____opt_4(____opt_4)
        end
        local ____opt_result_6_7 = ____opt_result_6
        if ____opt_result_6_7 == nil then
            ____opt_result_6_7 = 0
        end
        return ____opt_result_6_7
    end
    ganhar = function(____, n)
        local ____opt_10 = window.CampanhaLoja
        if ____opt_10 ~= nil then
            ____opt_10 = ____opt_10.ganhar
        end
        local ____opt_result_12
        if ____opt_10 ~= nil then
            ____opt_result_12 = ____opt_10(____opt_10, n)
        end
        return ____opt_result_12
    end
    local function F(____, quem, texto, emo)
        return __arrL({quem, texto, emo}, 3)
    end
    local ITENS = __arrL(
        {
            __ord(
                {
                    id = "radio",
                    cena = 16,
                    x = 1960,
                    nome = "RADINHO DA DONA LURDES",
                    quando = function() return X(nil).lurdes == "ativa" end,
                    cor = "#c43c3a"
                },
                "id,cena,x,nome,quando,cor"
            ),
            __ord(
                {
                    id = "mapa1",
                    cena = 14,
                    x = 4300,
                    nome = "PEDAÇO DO MAPA (1/3)",
                    quando = function() return X(nil).mel == "ativa" end,
                    cor = "#e8c24c"
                },
                "id,cena,x,nome,quando,cor"
            ),
            __ord(
                {
                    id = "mapa2",
                    cena = 17,
                    x = 3980,
                    nome = "PEDAÇO DO MAPA",
                    quando = function() return X(nil).mel == "ativa" end,
                    cor = "#e8c24c"
                },
                "id,cena,x,nome,quando,cor"
            ),
            __ord(
                {
                    id = "mapa3",
                    cena = 32,
                    x = 2400,
                    nome = "PEDAÇO DO MAPA",
                    quando = function() return X(nil).mel == "ativa" end,
                    cor = "#e8c24c"
                },
                "id,cena,x,nome,quando,cor"
            ),
            __ord(
                {
                    id = "pneu",
                    cena = 30,
                    x = 2300,
                    nome = "PNEU DE BICICLETA",
                    quando = function() return X(nil).juninho == "ativa" end,
                    cor = "#3a3a3a"
                },
                "id,cena,x,nome,quando,cor"
            ),
            __ord(
                {
                    id = "chapeu",
                    cena = 22,
                    x = 2050,
                    nome = "CHAPÉU DE PALHA DESFIADO",
                    quando = function() return X(nil).fatima == "ativa" end,
                    cor = "#e2c070"
                },
                "id,cena,x,nome,quando,cor"
            ),
            __ord(
                {
                    id = "lenco",
                    cena = 20,
                    x = 1250,
                    nome = "LENÇO VERMELHO DE BOLINHA",
                    quando = function() return X(nil).fatima == "ativa" end,
                    cor = "#d8342a"
                },
                "id,cena,x,nome,quando,cor"
            ),
            __ord(
                {
                    id = "girassol",
                    cena = 23,
                    x = 2780,
                    nome = "GIRASSOL DE PANO",
                    quando = function() return X(nil).fatima == "ativa" end,
                    cor = "#f2c230"
                },
                "id,cena,x,nome,quando,cor"
            )
        },
        8
    )
    local function pegou(____, id)
        return not not __t(__get(
            X(nil),
            __add("item_", id)
        ))
    end
    local function pedacos()
        return __len(__call(
            __arrL({"mapa1", "mapa2", "mapa3"}, 3),
            "filter",
            pegou
        ))
    end
    local function pecasCaipira()
        return __len(__call(
            __arrL({"chapeu", "lenco", "girassol"}, 3),
            "filter",
            pegou
        ))
    end
    local ALIADOS = __arrL(
        {
            __ord(
                {
                    id = "lurdes",
                    quem = "c2_lurdes",
                    nome = "Dona Lurdes",
                    cena = 13,
                    x = 1980,
                    estado = function()
                        local ____temp_14
                        if X(nil).lurdes == "feita" then
                            ____temp_14 = "ok"
                        else
                            local ____temp_13
                            if X(nil).lurdes == "ativa" then
                                ____temp_13 = __t(pegou(nil, "radio")) and "entregar" or "andando"
                            else
                                ____temp_13 = "nova"
                            end
                            ____temp_14 = ____temp_13
                        end
                        return ____temp_14
                    end,
                    falas = function(____, st)
                        local ____temp_17
                        if st == "nova" then
                            ____temp_17 = __arrL(
                                {
                                    F(nil, "c2_lurdes", "Ô menino, me ajuda? Roubaram meu radinho de pilha. Trinta anos ouvindo a rádio da cidade nele!", "sad"),
                                    F(nil, "daroca", "Quem levaria um radinho?"),
                                    F(nil, "c2_lurdes", "Um moleque de bicicleta. Saiu correndo pro lado do Monumento ao Índio."),
                                    F(nil, "c2_lurdes", "Se achar, eu faço um café que levanta até defunto.", "friend")
                                },
                                4
                            )
                        else
                            local ____temp_16
                            if st == "andando" then
                                ____temp_16 = __arrL(
                                    {F(nil, "c2_lurdes", "O moleque foi pro lado do Monumento ao Índio. Procura na avenida!")},
                                    1
                                )
                            else
                                local ____temp_15
                                if st == "entregar" then
                                    ____temp_15 = __arrL(
                                        {
                                            F(nil, "daroca", "Achei, Dona Lurdes! Tava largado na calçada da avenida."),
                                            F(nil, "c2_lurdes", "MEU RADINHO! Ai, que alegria!", "friend"),
                                            F(nil, "c2_lurdes", "Toma esse café passado na hora. Daqui pra frente, você aguenta muito mais pancada.", "friend")
                                        },
                                        3
                                    )
                                else
                                    ____temp_15 = __arrL(
                                        {F(nil, "c2_lurdes", "O radinho tá tocando arrocha o dia inteiro. Obrigada de novo, meu filho.", "friend")},
                                        1
                                    )
                                end
                                ____temp_16 = ____temp_15
                            end
                            ____temp_17 = ____temp_16
                        end
                        return ____temp_17
                    end,
                    fim = function(____, st)
                        if st == "nova" then
                            marca(nil, "lurdes", "ativa")
                        end
                        if st == "entregar" then
                            marca(nil, "lurdes", "feita")
                            api:item("CAFÉ DA DONA LURDES · +20 DE VIDA MÁXIMA")
                            api.P.hp = vidaMax(nil)
                            api:sfx("fanfarra")
                        end
                    end
                },
                "id,quem,nome,cena,x,estado,falas,fim"
            ),
            __ord(
                {
                    id = "mel",
                    quem = "c2_mel",
                    nome = "Mel",
                    cena = 14,
                    x = 960,
                    estado = function()
                        local ____temp_19
                        if X(nil).mel == "feita" then
                            ____temp_19 = "ok"
                        else
                            local ____temp_18
                            if X(nil).mel == "ativa" then
                                ____temp_18 = pedacos(nil) >= 3 and "entregar" or "andando"
                            else
                                ____temp_18 = "nova"
                            end
                            ____temp_19 = ____temp_18
                        end
                        return ____temp_19
                    end,
                    falas = function(____, st)
                        local ____temp_22
                        if st == "nova" then
                            ____temp_22 = __arrL(
                                {
                                    F(nil, "c2_mel", "Mapa da cidade! Só cinco reais! Com todos os atalhos secretos!"),
                                    F(nil, "daroca", "Esse mapa tem o desenho de um castelo."),
                                    F(nil, "c2_mel", "...É um mapa artístico.", "embarrassed"),
                                    F(nil, "c2_mel", "Tá bom, é falso. O verdadeiro, do meu avô, rasgou em três. Um pedaço voou pro fim do centro, outro pra feira e outro pra lagoa."),
                                    F(nil, "c2_mel", "Se você achar os três, eu monto o mapa verdadeiro pra você. De graça!", "friend")
                                },
                                5
                            )
                        else
                            local ____temp_21
                            if st == "andando" then
                                ____temp_21 = __arrL(
                                    {F(
                                        nil,
                                        "c2_mel",
                                        ("Já achou " .. tostring(pedacos(nil))) .. " de 3 pedaços. Fim do centro, fim da feira e a beira da lagoa!"
                                    )},
                                    1
                                )
                            else
                                local ____temp_20
                                if st == "entregar" then
                                    ____temp_20 = __arrL(
                                        {
                                            F(nil, "c2_mel", "Os três! Deixa eu colar...", "friend"),
                                            F(nil, "c2_mel", "Pronto: o mapa do meu avô. Ele marca tudo que tem pra fazer na cidade."),
                                            F(nil, "c2_mel", "Agora a sua seta mostra também onde tem gente precisando de ajuda.", "friend")
                                        },
                                        3
                                    )
                                else
                                    ____temp_20 = __arrL(
                                        {F(nil, "c2_mel", "Quer um mapa falso de lembrança? Brincadeira!", "friend")},
                                        1
                                    )
                                end
                                ____temp_21 = ____temp_20
                            end
                            ____temp_22 = ____temp_21
                        end
                        return ____temp_22
                    end,
                    fim = function(____, st)
                        if st == "nova" then
                            marca(nil, "mel", "ativa")
                        end
                        if st == "entregar" then
                            marca(nil, "mel", "feita")
                            ganhar(nil, 40)
                            api:item("MAPA VERDADEIRO · A SETA MOSTRA AS MISSÕES EXTRAS")
                            api:sfx("fanfarra")
                        end
                    end
                },
                "id,quem,nome,cena,x,estado,falas,fim"
            ),
            __ord(
                {
                    id = "biscoito",
                    quem = "c2_biscoito",
                    nome = "Biscoito",
                    cena = 13,
                    x = 640,
                    cao = true,
                    estado = function() return __t(tem(nil, "cao")) and "ok" or (__t(tem(nil, "biscoito_cao")) and "entregar" or (__t(X(nil).cao_visto) and "andando" or "nova")) end,
                    falas = function(____, st)
                        local ____temp_25
                        if st == "nova" then
                            ____temp_25 = __arrL(
                                {
                                    F(nil, "c2_biscoito", "Au... (ele olha pra você com cara de fome)", "sad"),
                                    F(nil, "daroca", "Tá com fome, caramelo? Eu não tenho nada..."),
                                    F(nil, "narrador", "Dizem que o Tio do Picolé, na feira, vende biscoito de polvilho. Cachorro caramelo nenhum resiste.")
                                },
                                3
                            )
                        else
                            local ____temp_24
                            if st == "andando" then
                                ____temp_24 = __arrL(
                                    {
                                        F(nil, "c2_biscoito", "Au? (ele cheira o seu bolso vazio)", "sad"),
                                        F(nil, "narrador", "Biscoito de polvilho: na banca do Tio do Picolé, na feira.")
                                    },
                                    2
                                )
                            else
                                local ____temp_23
                                if st == "entregar" then
                                    ____temp_23 = __arrL(
                                        {
                                            F(nil, "daroca", "Toma, caramelo. Biscoito de polvilho."),
                                            F(nil, "c2_biscoito", "AU! AU AU!", "friend"),
                                            F(nil, "narrador", "O Biscoito agora vai com você. Nas brigas, ele morde quem chegar perto.")
                                        },
                                        3
                                    )
                                else
                                    ____temp_23 = __arrL(
                                        {F(nil, "c2_biscoito", "AU! (abana o rabo)", "friend")},
                                        1
                                    )
                                end
                                ____temp_24 = ____temp_23
                            end
                            ____temp_25 = ____temp_24
                        end
                        return ____temp_25
                    end,
                    fim = function(____, st)
                        if st == "nova" then
                            marca(nil, "cao_visto")
                        end
                        if st == "entregar" then
                            marca(nil, "cao")
                            api:item("BISCOITO AGORA É SEU COMPANHEIRO")
                            api:sfx("fanfarra")
                        end
                    end
                },
                "id,quem,nome,cena,x,cao,estado,falas,fim"
            ),
            __ord(
                {
                    id = "picole",
                    quem = "c2_picole",
                    nome = "Tio do Picolé",
                    cena = 17,
                    x = 2280,
                    loja = true,
                    estado = function() return "loja" end,
                    falas = function() return __arrL(
                        {
                            F(nil, "c2_picole", "Olha o picolé! Picolé no frio de onze graus, quem vai querer?!"),
                            F(nil, "daroca", "Picolé... no frio?"),
                            F(nil, "c2_picole", "Por isso eu vendo com nome de meme. As pessoas riem e compram!", "friend")
                        },
                        3
                    ) end,
                    fim = function() return lojaPicole(nil) end
                },
                "id,quem,nome,cena,x,loja,estado,falas,fim"
            ),
            __ord(
                {
                    id = "nando",
                    quem = "c2_nando",
                    nome = "Nando Skatista",
                    cena = 14,
                    x = 3520,
                    estado = function() return __t(tem(nil, "skate")) and "ok" or "nova" end,
                    falas = function(____, st)
                        local ____temp_26
                        if st == "nova" then
                            ____temp_26 = __arrL(
                                {
                                    F(nil, "c2_nando", "Aí, forasteiro! Aposta uma corrida? Até a bandeira lá no fim do centro e de volta aqui."),
                                    F(nil, "c2_nando", "Se você chegar antes de mim, o skate reserva é seu. Ele te deixa bem mais rápido."),
                                    F(nil, "daroca", "Fechou. Mas eu vou a pé."),
                                    F(nil, "c2_nando", "Kkkk aí que tá a graça!", "friend")
                                },
                                4
                            )
                        else
                            ____temp_26 = __arrL(
                                {F(nil, "c2_nando", "O skate tá rodando bonito, hein? Cuidado com os buracos da avenida.", "friend")},
                                1
                            )
                        end
                        return ____temp_26
                    end,
                    fim = function(____, st)
                        if st == "nova" then
                            iniciarCorrida(nil)
                        end
                    end
                },
                "id,quem,nome,cena,x,estado,falas,fim"
            ),
            __ord(
                {
                    id = "juninho",
                    quem = "c2_juninho",
                    nome = "Juninho Mecânico",
                    cena = 16,
                    x = 2420,
                    estado = function()
                        local ____temp_32
                        if X(nil).juninho == "feita" then
                            ____temp_32 = "ok"
                        else
                            local ____temp_31
                            if X(nil).juninho == "ativa" then
                                local ____t_30 = __t
                                local ____t_result_29
                                local ____t_28 = __t
                                local ____pegou_result_27 = pegou(nil, "pneu")
                                __O[878] = ____pegou_result_27
                                if ____t_28(____pegou_result_27) then
                                    ____t_result_29 = tem(nil, "corrente")
                                else
                                    ____t_result_29 = __O[878]
                                end
                                ____temp_31 = ____t_30(____t_result_29) and "entregar" or "andando"
                            else
                                ____temp_31 = "nova"
                            end
                            ____temp_32 = ____temp_31
                        end
                        return ____temp_32
                    end,
                    falas = function(____, st)
                        local ____temp_35
                        if st == "nova" then
                            ____temp_35 = __arrL(
                                {
                                    F(nil, "c2_juninho", "Tá vendo essa bicicleta? Era do meu avô. Falta só uma corrente e um pneu."),
                                    F(nil, "c2_juninho", "Corrente, o Gugu do ferro-velho tem (no fim da rua da pensão). Pneu, vi um largado na rodoviária."),
                                    F(nil, "c2_juninho", "Traz os dois que eu monto e te empresto. De bicicleta você atravessa a cidade voando!", "friend")
                                },
                                3
                            )
                        else
                            local ____temp_34
                            if st == "andando" then
                                ____temp_34 = __arrL(
                                    {F(
                                        nil,
                                        "c2_juninho",
                                        (("Falta: " .. (__t(tem(nil, "corrente")) and "" or "a corrente (com o Gugu) ")) .. (__t(pegou(nil, "pneu")) and "" or "o pneu (na rodoviária)")) .. "."
                                    )},
                                    1
                                )
                            else
                                local ____temp_33
                                if st == "entregar" then
                                    ____temp_33 = __arrL(
                                        {
                                            F(nil, "c2_juninho", "Corrente e pneu! Deixa comigo...", "friend"),
                                            F(nil, "c2_juninho", "Pronto! Pedala com cuidado. E freia antes da rotatória.", "friend")
                                        },
                                        2
                                    )
                                else
                                    ____temp_33 = __arrL(
                                        {F(nil, "c2_juninho", "E a bicicleta, tá rodando bem? Se furar, já sabe.", "friend")},
                                        1
                                    )
                                end
                                ____temp_34 = ____temp_33
                            end
                            ____temp_35 = ____temp_34
                        end
                        return ____temp_35
                    end,
                    fim = function(____, st)
                        if st == "nova" then
                            marca(nil, "juninho", "ativa")
                        end
                        if st == "entregar" then
                            marca(nil, "juninho", "feita")
                            marca(nil, "bike")
                            api:item("BICICLETA · VOCÊ ANDA MUITO MAIS RÁPIDO")
                            api:sfx("fanfarra")
                        end
                    end
                },
                "id,quem,nome,cena,x,estado,falas,fim"
            ),
            __ord(
                {
                    id = "bia",
                    quem = "c2_bia",
                    nome = "Bia do Arrocha",
                    cena = 19,
                    x = 1720,
                    estado = function() return __t(tem(nil, "moral")) and "ok" or "nova" end,
                    falas = function(____, st)
                        local ____temp_36
                        if st == "nova" then
                            ____temp_36 = __arrL(
                                {
                                    F(nil, "c2_bia", "Ei, você! Meu dançarino faltou e o show começa agora. Sabe dançar arrocha?"),
                                    F(nil, "daroca", "Eu sei peidar no ritmo. Serve?"),
                                    F(nil, "c2_bia", "...Serve. Sobe no palco! Aperta as setas quando elas chegarem na linha.", "friend")
                                },
                                3
                            )
                        else
                            ____temp_36 = __arrL(
                                {F(nil, "c2_bia", "Ainda falam do seu show. O forasteiro que dança arrocha!", "friend")},
                                1
                            )
                        end
                        return ____temp_36
                    end,
                    fim = function(____, st)
                        if st == "nova" then
                            iniciarRitmo(nil)
                        end
                    end
                },
                "id,quem,nome,cena,x,estado,falas,fim"
            ),
            __ord(
                {
                    id = "gugu",
                    quem = "c2_gugu",
                    nome = "Gugu do Ferro-Velho",
                    cena = 13,
                    x = 4040,
                    oficina = true,
                    estado = function() return __t(X(nil).juninho == "ativa" and not __t(tem(nil, "corrente"))) and "entregar" or "loja" end,
                    falas = function(____, st)
                        local ____temp_37
                        if st == "entregar" then
                            ____temp_37 = __arrL(
                                {
                                    F(nil, "c2_gugu", "Corrente de bicicleta pro Juninho? Tenho uma aqui, já lubrificada."),
                                    F(nil, "c2_gugu", "Leva. E volta pra turbinar essas garrafadas na minha oficina!", "friend")
                                },
                                2
                            )
                        else
                            ____temp_37 = nil
                        end
                        return ____temp_37
                    end,
                    fim = function(____, st)
                        if st == "entregar" then
                            marca(nil, "corrente")
                            api:item("CORRENTE DE BICICLETA")
                        else
                            local ____opt_40 = window.CampanhaOficina
                            if ____opt_40 ~= nil then
                                ____opt_40 = ____opt_40.abrir
                            end
                            if ____opt_40 ~= nil then
                                ____opt_40(____opt_40, {})
                            end
                        end
                    end
                },
                "id,quem,nome,cena,x,oficina,estado,falas,fim"
            ),
            __ord(
                {
                    id = "vocida",
                    quem = "c2_vo_cida",
                    nome = "Vó Cida",
                    cena = 13,
                    x = 1080,
                    pista = true,
                    estado = function() return __t(tem(nil, "pista_vocida")) and "ok" or "nova" end,
                    falas = function(____, st)
                        local ____temp_42
                        if st == "nova" then
                            ____temp_42 = __arrL(
                                {
                                    F(nil, "c2_vo_cida", "Você é o amigo de Itabuna, né? Do menino de cachinhos."),
                                    F(nil, "c2_vo_cida", "Quando ele chegou aqui, sentava na minha calçada todo fim de tarde. Sozinho.", "sad"),
                                    F(nil, "c2_vo_cida", "Uma vez perguntei se ele tinha amigos. Ele disse: \"tinha dois. Os melhores do mundo.\"", "sad"),
                                    F(nil, "daroca", "...Tinha.", "sad")
                                },
                                4
                            )
                        else
                            ____temp_42 = __arrL(
                                {F(nil, "c2_vo_cida", "Vai com Deus, menino. E não desiste dele.", "friend")},
                                1
                            )
                        end
                        return ____temp_42
                    end,
                    fim = function(____, st)
                        if st == "nova" then
                            marca(nil, "pista_vocida")
                            pistas(nil)
                        end
                    end
                },
                "id,quem,nome,cena,x,pista,estado,falas,fim"
            ),
            __ord(
                {
                    id = "larissa",
                    quem = "c2_larissa",
                    nome = "Larissa da Biblioteca",
                    cena = 31,
                    x = 3400,
                    pista = true,
                    estado = function() return __t(tem(nil, "pista_larissa")) and "ok" or "nova" end,
                    falas = function(____, st)
                        local ____temp_43
                        if st == "nova" then
                            ____temp_43 = __arrL(
                                {
                                    F(nil, "c2_larissa", "Psiu, biblioteca! ...Ah, você procura o Jorge?"),
                                    F(nil, "c2_larissa", "Ele vinha aqui ler sobre Itabuna. Pegou o mesmo livro de história do cacau umas cinco vezes."),
                                    F(nil, "c2_larissa", "Na última página tem um desenho de três bonequinhos. Não fui eu que fiz.", "sad")
                                },
                                3
                            )
                        else
                            ____temp_43 = __arrL(
                                {F(nil, "c2_larissa", "Boa leitura. E boa sorte com o seu amigo.", "friend")},
                                1
                            )
                        end
                        return ____temp_43
                    end,
                    fim = function(____, st)
                        if st == "nova" then
                            marca(nil, "pista_larissa")
                            pistas(nil)
                        end
                    end
                },
                "id,quem,nome,cena,x,pista,estado,falas,fim"
            ),
            __ord(
                {
                    id = "fatima",
                    quem = "c2_fatima",
                    nome = "Dona Fátima",
                    cena = 23,
                    x = 1720,
                    estado = function()
                        local ____temp_45
                        if X(nil).fatima == "feita" then
                            ____temp_45 = "ok"
                        else
                            local ____temp_44
                            if X(nil).fatima == "ativa" then
                                ____temp_44 = pecasCaipira(nil) >= 3 and "entregar" or "andando"
                            else
                                ____temp_44 = "nova"
                            end
                            ____temp_45 = ____temp_44
                        end
                        return ____temp_45
                    end,
                    falas = function(____, st)
                        local ____temp_48
                        if st == "nova" then
                            ____temp_48 = __arrL(
                                {
                                    F(nil, "c2_fatima", "Ô meu filho, socorro! Hoje tem o Arraiá do Shopping e o meu manequim caipira ficou pelado!", "sad"),
                                    F(nil, "daroca", "Pelado como? Cadê a roupa dele?"),
                                    F(nil, "c2_fatima", "Os meninos da lan house brincaram de pega-pega com as peças. Sumiu o chapéu, o lenço e o girassol."),
                                    F(nil, "c2_fatima", "O chapéu voou lá pro estacionamento, o lenço ficou no térreo e o girassol tá aqui em cima, no fim do corredor."),
                                    F(nil, "daroca", "Caipira no shopping? Isso é comigo. Eu sou da roça!", "friend"),
                                    F(nil, "c2_fatima", "Então acha as três peças. Se servir em você, a fantasia é sua!", "friend")
                                },
                                6
                            )
                        else
                            local ____temp_47
                            if st == "andando" then
                                ____temp_47 = __arrL(
                                    {F(
                                        nil,
                                        "c2_fatima",
                                        ("Achou " .. tostring(pecasCaipira(nil))) .. " de 3. Chapéu no estacionamento, lenço no térreo e girassol no fim deste corredor!"
                                    )},
                                    1
                                )
                            else
                                local ____temp_46
                                if st == "entregar" then
                                    ____temp_46 = __arrL(
                                        {
                                            F(nil, "daroca", "Chapéu, lenço e girassol. Tudo aqui, Dona Fátima!"),
                                            F(nil, "c2_fatima", "Agora veste aí pra eu ver... AI QUE CAIPIRA MAIS ARRETADO!", "friend"),
                                            F(nil, "c2_fatima", "A fantasia é sua. Camisa xadrez, remendo no joelho e bigodinho pintado. Arraiá em pleno shopping!", "friend"),
                                            F(nil, "narrador", "O traje CAIPIRA está no armário do quarto e no espelho do inventário.")
                                        },
                                        4
                                    )
                                else
                                    ____temp_46 = __arrL(
                                        {F(nil, "c2_fatima", "O manequim agora tá com inveja de você. Volta no Arraiá, viu?", "friend")},
                                        1
                                    )
                                end
                                ____temp_47 = ____temp_46
                            end
                            ____temp_48 = ____temp_47
                        end
                        return ____temp_48
                    end,
                    fim = function(____, st)
                        if st == "nova" then
                            marca(nil, "fatima", "ativa")
                        end
                        if st == "entregar" then
                            marca(nil, "fatima", "feita")
                            local ____opt_51 = window.DarocaLook
                            if ____opt_51 ~= nil then
                                ____opt_51 = ____opt_51.ganhar
                            end
                            if ____opt_51 ~= nil then
                                ____opt_51(____opt_51, "caipira")
                            end
                            ganhar(nil, 30)
                            api:item("TRAJE CAIPIRA · VISTA NO ARMÁRIO OU NO ESPELHO")
                            api:sfx("fanfarra")
                        end
                    end
                },
                "id,quem,nome,cena,x,estado,falas,fim"
            ),
            __ord(
                {
                    id = "carlinhos",
                    quem = "c2_carlinhos",
                    nome = "Carlinhos",
                    cena = 20,
                    x = 2080,
                    pista = true,
                    estado = function() return __t(tem(nil, "pista_carlinhos")) and "ok" or "nova" end,
                    falas = function(____, st)
                        local ____temp_53
                        if st == "nova" then
                            ____temp_53 = __arrL(
                                {
                                    F(nil, "c2_carlinhos", "Eu andava com o Jorge antes do Fred aparecer. Depois, ele só andava grudado no Fred.", "sad"),
                                    F(nil, "c2_carlinhos", "Mas sabe? Ele falava de Itabuna quando achava que ninguém tava ouvindo."),
                                    F(nil, "c2_carlinhos", "Ele não admite. Mas sente falta. Muita.", "sad")
                                },
                                3
                            )
                        else
                            ____temp_53 = __arrL(
                                {F(nil, "c2_carlinhos", "Se você conseguir falar com ele... fala que eu mandei um oi.", "sad")},
                                1
                            )
                        end
                        return ____temp_53
                    end,
                    fim = function(____, st)
                        if st == "nova" then
                            marca(nil, "pista_carlinhos")
                            pistas(nil)
                        end
                    end
                },
                "id,quem,nome,cena,x,pista,estado,falas,fim"
            )
        },
        12
    )
    local function disponivel()
        local S = api:S()
        return not not __t(S.flags.embarcou) and not __t(__call(
            __arrL({"taxi1", "lurdes"}, 2),
            "includes",
            S.passo
        ))
    end
    local function atualizaCorrida(self, dt)
        local c0 = corrida
        local P = api.P
        if api:cena() ~= 14 then
            corrida = nil
            api:aviso("A corrida foi cancelada.")
            return
        end
        if c0.fase == "contagem" then
            c0.cont = c0.cont - dt
            if __le(c0.cont, 0) then
                c0.fase = "corre"
                api:sfx("buzina")
            end
            return
        end
        c0.t = __add(c0.t, dt)
        local vN = 300
        if not __t(c0.nIda) then
            c0.nando = c0.nando + vN * dt
            if __ge(c0.nando, c0.fim) then
                c0.nIda = true
            end
        else
            c0.nando = math.max(c0.volta, c0.nando - vN * dt)
        end
        if __t(not __t(c0.ida) and __ge(P.x, c0.fim - 20)) then
            c0.ida = true
            api:sfx("plim")
            api:aviso("BANDEIRA! AGORA VOLTA!")
        end
        local ____t_76 = __t
        local ____t_result_75
        if __t(c0.ida) then
            ____t_result_75 = __le(P.x, c0.volta + 30)
        else
            ____t_result_75 = c0.ida
        end
        if ____t_76(____t_result_75) then
            corrida = nil
            marca(nil, "skate")
            api:item("VOCÊ GANHOU! SKATE · ANDA MAIS RÁPIDO")
            api:sfx("fanfarra")
            return
        end
        local ____t_80 = __t
        local ____t_result_79
        local ____t_78 = __t
        local ____t_result_77
        if __t(c0.nIda) then
            ____t_result_77 = __le(c0.nando, c0.volta + 1)
        else
            ____t_result_77 = c0.nIda
        end
        __O[883] = ____t_result_77
        if ____t_78(____t_result_77) then
            ____t_result_79 = __O[883]
        else
            ____t_result_79 = __gt(c0.t, c0.lim)
        end
        if ____t_80(____t_result_79) then
            corrida = nil
            api:aviso("O Nando chegou primeiro! Fala com ele de novo pra revanche.")
            api:sfx("risada")
        end
    end
    local CORES = __arrL({"#e85ad0", "#5ae0d0", "#ffe23a", "#5a9aff"}, 4)
    local function atualizaRitmo(self, dt)
        local r = ritmo
        local c = r.c
        local W = 480
        local H = 270
        r.t = __add(r.t, dt)
        r.msgT = r.msgT - dt
        local ____t_result_90
        if __t(r.laneT) then
            ____t_result_90 = r.laneT
        else
            ____t_result_90 = 0
        end
        r.laneT = ____t_result_90 - dt
        for ____, n in __iterar((r.notas)) do
            if __t(n.ok == nil and r.t - n.t > 0.26) then
                n.ok = 0
                r.combo = 0
                r.msg = "ERROU!"
                r.msgT = 0.4
            end
        end
        if math.floor(r.t / (60 / 112)) ~= r.ultBat then
            r.ultBat = math.floor(r.t / (60 / 112))
            do
                pcall(function()
                    local ____opt_93 = window.Roteiro
                    if ____opt_93 ~= nil then
                        ____opt_93 = ____opt_93.sfx
                    end
                    if ____opt_93 ~= nil then
                        ____opt_93(____opt_93, "tambor")
                    end
                end)
            end
        end
        c.fillStyle = "#12081e"
        c:fillRect(0, 0, W, H)
        do
            local x = 0
            while x < W do
                c.fillStyle = __t(__mod(x, 12)) and "#6a1a2a" or "#5a1424"
                c:fillRect(x, 0, 6, 40)
                local ____c_fillRect_96 = c.fillRect
                local ____t_result_95
                if __t(x < 80 or x > 400) then
                    ____t_result_95 = x
                else
                    ____t_result_95 = -10
                end
                ____c_fillRect_96(
                    c,
                    ____t_result_95,
                    0,
                    6,
                    __t(x < 80 or x > 400) and 200 or 0
                )
                x = x + 6
            end
        end
        do
            local k = 0
            while k < 4 do
                local a = math.sin(r.t * 1.5 + k * 1.7) * 0.5
                local x0 = 80 + k * 106
                c:save()
                c.globalCompositeOperation = "lighter"
                c.globalAlpha = 0.18
                c.fillStyle = __get(
                    __arrL({"#ff5ad0", "#5ae0ff", "#ffe23a", "#7a5aff"}, 4),
                    k
                )
                c:beginPath()
                c:moveTo(x0, 20)
                c:lineTo(x0 + 10, 20)
                c:lineTo(x0 + 60 + a * 160, 210)
                c:lineTo(x0 - 50 + a * 160, 210)
                __call(c, "fill")
                c:restore()
                k = k + 1
            end
        end
        c.fillStyle = "#3a2418"
        c:fillRect(0, 200, W, 70)
        c.fillStyle = "#5a3a24"
        c:fillRect(0, 200, W, 4)
        do
            pcall(function()
                window.Art:drawCharacter(
                    c,
                    "c2_bia",
                    150,
                    200,
                    {
                        frame = r.t * 2,
                        facing = 1,
                        scale = 1.3,
                        moving = true,
                        grounded = true
                    }
                )
                window.Art:drawCharacter(
                    c,
                    "daroca",
                    330,
                    200 - math.abs(math.sin(r.t * 5.6)) * 6,
                    {
                        frame = r.t * 2,
                        facing = -1,
                        scale = 1.3,
                        moving = __gt(r.laneT, 0),
                        attack = __gt(r.laneT, 0),
                        attackType = "fart",
                        grounded = true
                    }
                )
            end)
        end
        do
            local k = 0
            while k < 22 do
                local x = 10 + k * 22
                local y = 254 + math.abs(math.sin(r.t * 4 + k)) * -4
                c.fillStyle = "#0a0610"
                c:beginPath()
                c:arc(
                    x,
                    y,
                    9,
                    0,
                    TAU
                )
                __call(c, "fill")
                c:fillRect(x - 10, y + 4, 20, 14)
                if __mod(
                    k + math.floor(r.t * 2),
                    5
                ) == 0 then
                    c:fillRect(x + 6, y - 14, 3, 10)
                end
                k = k + 1
            end
        end
        local function lx(____, i)
            return 186 + i * 28
        end
        local ly = 176
        do
            local i = 0
            while i < 4 do
                c.fillStyle = "rgba(10,6,16,.55)"
                c:fillRect(
                    lx(nil, i) - 11,
                    16,
                    22,
                    170
                )
                local ____t_result_97
                if __t(__gt(r.laneT, 0) and r.lane == i) then
                    ____t_result_97 = __get(CORES, i)
                else
                    ____t_result_97 = "#3a2a4a"
                end
                c.fillStyle = ____t_result_97
                c:fillRect(
                    lx(nil, i) - 12,
                    ly - 2,
                    24,
                    4
                )
                i = i + 1
            end
        end
        local function seta(____, x, y, i, cor)
            c:save()
            c:translate(x, y)
            c:rotate(__get(
                __arrL({-math.pi / 2, math.pi, 0, math.pi / 2}, 4),
                i
            ) + math.pi / 2)
            c.fillStyle = "#0a0610"
            c:beginPath()
            c:moveTo(0, -10)
            c:lineTo(10, 2)
            c:lineTo(4, 2)
            c:lineTo(4, 10)
            c:lineTo(-4, 10)
            c:lineTo(-4, 2)
            c:lineTo(-10, 2)
            __call(c, "fill")
            c.fillStyle = cor
            c:beginPath()
            c:moveTo(0, -7)
            c:lineTo(7, 1)
            c:lineTo(2, 1)
            c:lineTo(2, 8)
            c:lineTo(-2, 8)
            c:lineTo(-2, 1)
            c:lineTo(-7, 1)
            __call(c, "fill")
            c:restore()
        end
        do
            local i = 0
            while i < 4 do
                seta(
                    nil,
                    lx(nil, i),
                    ly,
                    i,
                    "#5a4a6a"
                )
                i = i + 1
            end
        end
        for ____, n in __iterar((r.notas)) do
            do
                if __t(n.ok) then
                    continue
                end
                local y = ly - (n.t - r.t) * 120
                if __t(y < 10 or y > 200) then
                    continue
                end
                seta(
                    nil,
                    lx(nil, n.lane),
                    y,
                    n.lane,
                    n.ok == 0 and "#5a3a3a" or __get(CORES, n.lane)
                )
            end
        end
        local ____opt_100 = window.CampanhaCamadas
        if ____opt_100 ~= nil then
            ____opt_100 = ____opt_100.kit
        end
        local ____opt_result_102
        if ____opt_100 ~= nil then
            ____opt_result_102 = ____opt_100.pxText
        end
        local tx = ____opt_result_102
        local pct = math.floor(r.acertos / __len(r.notas) * 100 + 0.5)
        if __t(tx) then
            tx(
                nil,
                c,
                __add(
                    __add("SHOW DA BIA · ", pct),
                    "%"
                ),
                240,
                4,
                "#ffe9a8",
                {sombra = "#000"}
            )
            if __gt(r.combo, 2) then
                tx(
                    nil,
                    c,
                    __add("COMBO ", r.combo),
                    240,
                    194,
                    "#ffd24a",
                    {s = 2, sombra = "#000"}
                )
            end
            if __gt(r.msgT, 0) then
                tx(
                    nil,
                    c,
                    r.msg,
                    240,
                    120,
                    r.msg == "ERROU!" and "#ff5a4a" or "#7af07a",
                    {s = 3, sombra = "#000"}
                )
            end
            tx(
                nil,
                c,
                "← ↓ ↑ →  OU  D F J K  (OU TOQUE NAS TRILHAS)",
                240,
                262,
                "#c8b8d8"
            )
        end
        if __gt(r.t, r.fim) then
            local ok = pct >= 65
            ritmo:sair()
            ritmo = nil
            api:pausar(false)
            if __t(ok) then
                marca(nil, "moral")
                api:item(("SHOW NOTA " .. tostring(pct)) .. "! MORAL · +15% DE FORÇA")
                api:sfx("fanfarra")
            else
                api:aviso(("Nota " .. tostring(pct)) .. "%. A Bia pediu bis: fala com ela de novo!")
                api:sfx("risada")
            end
        end
    end
    local function atualizaCao(self, dt, inimigos)
        local P = api.P
        if not __t(tem(nil, "cao")) then
            cao = nil
            return
        end
        if __t(not __t(cao) or cao.cena ~= api:cena()) then
            cao = {
                x = P.x - 50,
                cena = api:cena(),
                alvo = nil,
                cd = 1,
                mordeT = 0,
                dir = 1
            }
        end
        cao.cd = cao.cd - dt
        cao.mordeT = cao.mordeT - dt
        local ____call_113 = __call
        local ____t_result_103
        if __t(inimigos) then
            ____t_result_103 = inimigos
        else
            ____t_result_103 = __arrL({}, 0)
        end
        local vivos = ____call_113(
            ____t_result_103,
            "filter",
            function(____, e)
                local ____t_result_112
                local ____t_109 = __t
                local ____t_result_108
                local ____t_107 = __t
                local ____t_result_106
                local ____t_105 = __t
                local ____gt_result_104 = __gt(e.hp, 0)
                __O[885] = ____gt_result_104
                if ____t_105(____gt_result_104) then
                    ____t_result_106 = e.onDano
                else
                    ____t_result_106 = __O[885]
                end
                __O[886] = ____t_result_106
                if ____t_107(____t_result_106) then
                    ____t_result_108 = math.abs(e.x - P.x) < 340
                else
                    ____t_result_108 = __O[886]
                end
                __O[887] = ____t_result_108
                if ____t_109(____t_result_108) then
                    local ____gt_111 = __gt
                    local ____e_y_110 = e.y
                    if ____e_y_110 == nil then
                        ____e_y_110 = FLOOR
                    end
                    ____t_result_112 = ____gt_111(____e_y_110, FLOOR - 40)
                else
                    ____t_result_112 = __O[887]
                end
                return ____t_result_112
            end
        )
        local ____t_117 = __t
        local ____t_result_116
        local ____t_115 = __t
        local ____temp_114 = not __t(cao.alvo) or __le(cao.alvo.hp, 0)
        __O[888] = ____temp_114
        if ____t_115(____temp_114) then
            ____t_result_116 = __O[888]
        else
            ____t_result_116 = not __t(__call(vivos, "includes", cao.alvo))
        end
        if ____t_117(____t_result_116) then
            local ____cao_121 = cao
            local ____t_result_120
            local ____t_119 = __t
            local ____get_result_118 = __get(
                __call(
                    vivos,
                    "sort",
                    function(____, a, b) return math.abs(a.x - cao.x) - math.abs(b.x - cao.x) end
                ),
                0
            )
            __O[889] = ____get_result_118
            if ____t_119(____get_result_118) then
                ____t_result_120 = __O[889]
            else
                ____t_result_120 = nil
            end
            ____cao_121.alvo = ____t_result_120
        end
        local ____t_result_122
        if __t(cao.alvo) then
            ____t_result_122 = cao.alvo.x - __TS__MathSign(cao.alvo.x - cao.x) * 18
        else
            ____t_result_122 = P.x - P.facing * 46
        end
        local destino = ____t_result_122
        local dx = destino - cao.x
        if math.abs(dx) > 6 then
            cao.x = cao.x + __TS__MathSign(dx) * math.min(
                math.abs(dx),
                (__t(cao.alvo) and 340 or (math.abs(dx) > 160 and 420 or 220)) * dt
            )
            cao.dir = __TS__MathSign(dx)
        end
        local ____t_126 = __t
        local ____t_result_125
        local ____t_124 = __t
        local ____t_result_123
        if __t(cao.alvo) then
            ____t_result_123 = math.abs(cao.alvo.x - cao.x) < 30
        else
            ____t_result_123 = cao.alvo
        end
        __O[890] = ____t_result_123
        if ____t_124(____t_result_123) then
            ____t_result_125 = __le(cao.cd, 0)
        else
            ____t_result_125 = __O[890]
        end
        if ____t_126(____t_result_125) then
            cao.cd = 2.4
            cao.mordeT = 0.3
            cao.alvo:onDano(35, "mordida")
            do
                pcall(function()
                    local ____opt_129 = window.Roteiro
                    if ____opt_129 ~= nil then
                        ____opt_129 = ____opt_129.sfx
                    end
                    if ____opt_129 ~= nil then
                        ____opt_129(____opt_129, "risada")
                    end
                end)
            end
        end
    end
    local function candidatos(self, cena)
        if not __t(disponivel(nil)) then
            return __arrL({}, 0)
        end
        local out = __arrL({}, 0)
        for ____, a in __iterar((ALIADOS)) do
            do
                local ____t_135 = __t
                local ____t_result_134
                local ____t_132 = __t
                local ____temp_131 = a.cena ~= cena
                __O[891] = ____temp_131
                if ____t_132(____temp_131) then
                    ____t_result_134 = __O[891]
                else
                    local ____t_result_133
                    if __t(a.cao) then
                        ____t_result_133 = tem(nil, "cao")
                    else
                        ____t_result_133 = a.cao
                    end
                    ____t_result_134 = ____t_result_133
                end
                if ____t_135(____t_result_134) then
                    continue
                end
                local st = a:estado()
                local ____call_145 = __call
                local ____a_x_143 = a.x
                local ____add_139 = __add
                local ____t_result_138
                if __t(a.loja) then
                    ____t_result_138 = "COMPRAR COM "
                else
                    local ____t_137 = __t
                    local ____t_result_136
                    if __t(a.oficina) then
                        ____t_result_136 = st ~= "entregar"
                    else
                        ____t_result_136 = a.oficina
                    end
                    ____t_result_138 = ____t_137(____t_result_136) and "OFICINA DO " or "FALAR COM "
                end
                local ____add_139_result_144 = ____add_139(
                    ____t_result_138,
                    __call(a.nome, "toUpperCase")
                )
                local ____t_result_142
                if __t(a.loja) then
                    ____t_result_142 = "COMPRAR"
                else
                    local ____t_141 = __t
                    local ____t_result_140
                    if __t(a.oficina) then
                        ____t_result_140 = st ~= "entregar"
                    else
                        ____t_result_140 = a.oficina
                    end
                    ____t_result_142 = ____t_141(____t_result_140) and "OFICINA" or "FALAR"
                end
                ____call_145(
                    out,
                    "push",
                    {
                        tipo = "aliado",
                        x = ____a_x_143,
                        rotulo = ____add_139_result_144,
                        botao = ____t_result_142,
                        acao = function()
                            local fl = a:falas(st)
                            if __t(fl) then
                                api:conversa({
                                    id = __add("al_", a.id),
                                    quem = a.quem,
                                    x = a.x,
                                    falas = fl,
                                    fim = function() return a:fim(st) end
                                })
                            else
                                a:fim(st)
                            end
                        end
                    }
                )
            end
        end
        for ____, it in __iterar((ITENS)) do
            local ____t_151 = __t
            local ____t_result_150
            local ____t_149 = __t
            local ____t_result_148
            local ____t_147 = __t
            local ____temp_146 = it.cena == cena
            __O[892] = ____temp_146
            if ____t_147(____temp_146) then
                ____t_result_148 = it:quando()
            else
                ____t_result_148 = __O[892]
            end
            __O[893] = ____t_result_148
            if ____t_149(____t_result_148) then
                ____t_result_150 = not __t(pegou(nil, it.id))
            else
                ____t_result_150 = __O[893]
            end
            if ____t_151(____t_result_150) then
                __call(
                    out,
                    "push",
                    {
                        tipo = "item",
                        x = it.x,
                        rotulo = __add("PEGAR: ", it.nome),
                        botao = "PEGAR",
                        acao = function()
                            marca(
                                nil,
                                __add("item_", it.id)
                            )
                            local ____api_154 = api
                            local ____api_item_155 = api.item
                            local ____t_result_153
                            if __t(__call(it.id, "startsWith", "mapa")) then
                                ____t_result_153 = ("PEDAÇO DO MAPA (" .. tostring(pedacos(nil))) .. "/3)"
                            else
                                local ____t_result_152
                                if __t(__call(
                                    __arrL({"chapeu", "lenco", "girassol"}, 3),
                                    "includes",
                                    it.id
                                )) then
                                    ____t_result_152 = ((tostring(it.nome) .. " (") .. tostring(pecasCaipira(nil))) .. "/3)"
                                else
                                    ____t_result_152 = it.nome
                                end
                                ____t_result_153 = ____t_result_152
                            end
                            ____api_item_155(____api_154, ____t_result_153)
                            api:sfx("plim")
                        end
                    }
                )
            end
        end
        local ____t_159 = __t
        local ____t_result_158
        local ____t_157 = __t
        local ____temp_156 = cena == 14
        __O[894] = ____temp_156
        if ____t_157(____temp_156) then
            ____t_result_158 = corrida
        else
            ____t_result_158 = __O[894]
        end
        if ____t_159(____t_result_158) then
            return __call(
                out,
                "filter",
                function(____, o) return o.tipo ~= "aliado" end
            )
        end
        return out
    end
    local function atualizar(self, dt, inimigos)
        if not __t(api) then
            return
        end
        t = t + dt
        if __t(corrida) then
            atualizaCorrida(nil, dt)
        end
        if __t(ritmo) then
            atualizaRitmo(nil, dt)
        end
        atualizaCao(nil, dt, inimigos)
    end
    local function desenhar(self, c, cena)
        if __t(not __t(api) or not __t(disponivel(nil))) then
            return
        end
        local P = api.P
        local function R(____, x, y, w, h, col)
            c.fillStyle = col
            c:fillRect(
                math.floor(x + 0.5),
                math.floor(y + 0.5),
                w,
                h
            )
        end
        if cena == 13 then
            ferroVelho(nil, c)
        end
        for ____, a in __iterar((ALIADOS)) do
            do
                local ____t_164 = __t
                local ____t_result_163
                local ____t_161 = __t
                local ____temp_160 = a.cena ~= cena
                __O[895] = ____temp_160
                if ____t_161(____temp_160) then
                    ____t_result_163 = __O[895]
                else
                    local ____t_result_162
                    if __t(a.cao) then
                        ____t_result_162 = tem(nil, "cao")
                    else
                        ____t_result_162 = a.cao
                    end
                    ____t_result_163 = ____t_result_162
                end
                if ____t_164(____t_result_163) then
                    continue
                end
                local st = a:estado()
                do
                    pcall(function()
                        local ____self_170 = window.Art
                        local ____self_170_drawCharacter_171 = ____self_170.drawCharacter
                        local ____array_169 = __TS__SparseArrayNew(c, a.quem, a.x, FLOOR)
                        local ____temp_167 = t + a.x
                        local ____temp_168 = __lt(P.x, a.x) and -1 or 1
                        local ____t_166 = __t
                        local ____t_result_165
                        if __t(a.cao) then
                            ____t_result_165 = st ~= "ok"
                        else
                            ____t_result_165 = a.cao
                        end
                        __TS__SparseArrayPush(
                            ____array_169,
                            {
                                frame = ____temp_167,
                                facing = ____temp_168,
                                grounded = true,
                                emotion = ____t_166(____t_result_165) and "sad" or nil
                            }
                        )
                        ____self_170_drawCharacter_171(
                            ____self_170,
                            __TS__SparseArraySpread(____array_169)
                        )
                    end)
                end
                local ____temp_175
                if st == "nova" then
                    ____temp_175 = "!"
                else
                    local ____temp_174
                    if st == "entregar" then
                        ____temp_174 = "?"
                    else
                        local ____t_173 = __t
                        local ____t_result_172
                        if __t(a.loja) then
                            ____t_result_172 = a.loja
                        else
                            ____t_result_172 = a.oficina
                        end
                        ____temp_174 = ____t_173(____t_result_172) and "●" or ""
                    end
                    ____temp_175 = ____temp_174
                end
                local marcaTxt = ____temp_175
                if __t(marcaTxt) then
                    local y = FLOOR - (__t(a.cao) and 52 or 96) + math.sin(t * 4 + a.x) * 3
                    local cor = marcaTxt == "!" and "#ffd24a" or (marcaTxt == "?" and "#7af07a" or "#e8c66a")
                    R(
                        nil,
                        a.x - 8,
                        y - 18,
                        16,
                        20,
                        "#1c1408"
                    )
                    R(
                        nil,
                        a.x - 6,
                        y - 16,
                        12,
                        16,
                        cor
                    )
                    local ____opt_180 = window.CampanhaCamadas
                    if ____opt_180 ~= nil then
                        ____opt_180 = ____opt_180.kit
                    end
                    local ____opt_result_182
                    if ____opt_180 ~= nil then
                        ____opt_result_182 = ____opt_180.pxText
                    end
                    if ____opt_result_182 ~= nil then
                        ____opt_result_182(
                            ____opt_180,
                            c,
                            marcaTxt,
                            a.x,
                            y - 13,
                            "#1c1408",
                            {s = 2}
                        )
                    end
                end
            end
        end
        for ____, it in __iterar((ITENS)) do
            local ____t_188 = __t
            local ____t_result_187
            local ____t_186 = __t
            local ____t_result_185
            local ____t_184 = __t
            local ____temp_183 = it.cena == cena
            __O[896] = ____temp_183
            if ____t_184(____temp_183) then
                ____t_result_185 = it:quando()
            else
                ____t_result_185 = __O[896]
            end
            __O[897] = ____t_result_185
            if ____t_186(____t_result_185) then
                ____t_result_187 = not __t(pegou(nil, it.id))
            else
                ____t_result_187 = __O[897]
            end
            if ____t_188(____t_result_187) then
                local y = FLOOR - 20 + math.sin(t * 3 + it.x) * 4
                c:save()
                c.globalCompositeOperation = "lighter"
                c.globalAlpha = 0.35 + math.sin(t * 5) * 0.15
                c.fillStyle = it.cor
                c:beginPath()
                c:arc(
                    it.x,
                    y,
                    18,
                    0,
                    TAU
                )
                __call(c, "fill")
                c:restore()
                if it.id == "radio" then
                    R(
                        nil,
                        it.x - 10,
                        y - 8,
                        20,
                        14,
                        "#1c1408"
                    )
                    R(
                        nil,
                        it.x - 9,
                        y - 7,
                        18,
                        12,
                        "#c43c3a"
                    )
                    R(
                        nil,
                        it.x - 7,
                        y - 5,
                        7,
                        7,
                        "#2a2a2a"
                    )
                    R(
                        nil,
                        it.x + 2,
                        y - 4,
                        5,
                        2,
                        "#e8c24c"
                    )
                    R(
                        nil,
                        it.x + 6,
                        y - 14,
                        1,
                        7,
                        "#9aa0a6"
                    )
                elseif it.id == "pneu" then
                    c.strokeStyle = "#1c1c1c"
                    c.lineWidth = 4
                    c:beginPath()
                    c:arc(
                        it.x,
                        y,
                        10,
                        0,
                        TAU
                    )
                    c:stroke()
                    c.lineWidth = 1
                elseif it.id == "chapeu" then
                    R(
                        nil,
                        it.x - 16,
                        y + 1,
                        32,
                        4,
                        "#6e5335"
                    )
                    R(
                        nil,
                        it.x - 15,
                        y - 2,
                        30,
                        4,
                        "#e2c070"
                    )
                    do
                        local k = -16
                        while k < 16 do
                            R(
                                nil,
                                it.x + k,
                                y + 5,
                                2,
                                2,
                                "#c9a24a"
                            )
                            k = k + 3
                        end
                    end
                    R(
                        nil,
                        it.x - 8,
                        y - 10,
                        17,
                        9,
                        "#a98045"
                    )
                    R(
                        nil,
                        it.x - 7,
                        y - 10,
                        15,
                        7,
                        "#e6c474"
                    )
                    R(
                        nil,
                        it.x - 7,
                        y - 4,
                        15,
                        2,
                        "#c43a2e"
                    )
                elseif it.id == "lenco" then
                    c.fillStyle = "#1c1408"
                    c:beginPath()
                    c:moveTo(it.x - 13, y - 7)
                    c:lineTo(it.x + 13, y - 7)
                    c:lineTo(it.x, y + 9)
                    c:closePath()
                    __call(c, "fill")
                    c.fillStyle = "#d8342a"
                    c:beginPath()
                    c:moveTo(it.x - 11, y - 6)
                    c:lineTo(it.x + 11, y - 6)
                    c:lineTo(it.x, y + 7)
                    c:closePath()
                    __call(c, "fill")
                    R(
                        nil,
                        it.x - 5,
                        y - 4,
                        2,
                        2,
                        "#fff"
                    )
                    R(
                        nil,
                        it.x + 3,
                        y - 4,
                        2,
                        2,
                        "#fff"
                    )
                    R(
                        nil,
                        it.x - 1,
                        y + 1,
                        2,
                        2,
                        "#fff"
                    )
                elseif it.id == "girassol" then
                    R(
                        nil,
                        it.x - 1,
                        y + 2,
                        2,
                        12,
                        "#3a7a2a"
                    )
                    R(
                        nil,
                        it.x + 1,
                        y + 6,
                        5,
                        3,
                        "#4a9a3a"
                    )
                    do
                        local k = 0
                        while k < 8 do
                            local a = k / 8 * TAU + t
                            R(
                                nil,
                                it.x + math.cos(a) * 7 - 3,
                                y - 4 + math.sin(a) * 7 - 3,
                                6,
                                6,
                                __t(__mod(k, 2)) and "#f2c230" or "#e8a820"
                            )
                            k = k + 1
                        end
                    end
                    R(
                        nil,
                        it.x - 4,
                        y - 8,
                        8,
                        8,
                        "#6a3a12"
                    )
                    R(
                        nil,
                        it.x - 2,
                        y - 6,
                        2,
                        2,
                        "#8a5a22"
                    )
                else
                    R(
                        nil,
                        it.x - 9,
                        y - 7,
                        18,
                        14,
                        "#5a3a14"
                    )
                    R(
                        nil,
                        it.x - 8,
                        y - 6,
                        16,
                        12,
                        "#f2e2b8"
                    )
                    R(
                        nil,
                        it.x - 5,
                        y - 3,
                        8,
                        1,
                        "#a87a4a"
                    )
                    R(
                        nil,
                        it.x - 2,
                        y,
                        6,
                        1,
                        "#c43c3a"
                    )
                end
            end
        end
        local ____t_190 = __t
        local ____t_result_189
        if __t(cao) then
            ____t_result_189 = cao.cena == cena
        else
            ____t_result_189 = cao
        end
        if ____t_190(____t_result_189) then
            do
                pcall(function()
                    window.Art:drawCharacter(
                        c,
                        "c2_biscoito",
                        cao.x,
                        FLOOR,
                        {
                            frame = t * 1.6,
                            facing = cao.dir,
                            moving = true,
                            grounded = true,
                            attack = __gt(cao.mordeT, 0)
                        }
                    )
                end)
            end
            if __gt(cao.mordeT, 0) then
                local ____opt_195 = window.CampanhaCamadas
                if ____opt_195 ~= nil then
                    ____opt_195 = ____opt_195.kit
                end
                local ____opt_result_197
                if ____opt_195 ~= nil then
                    ____opt_result_197 = ____opt_195.pxText
                end
                if ____opt_result_197 ~= nil then
                    ____opt_result_197(
                        ____opt_195,
                        c,
                        "NHAC!",
                        cao.x,
                        FLOOR - 50,
                        "#ffd24a",
                        {sombra = "#000"}
                    )
                end
            end
        end
        local ____t_199 = __t
        local ____t_result_198
        if __t(corrida) then
            ____t_result_198 = cena == 14
        else
            ____t_result_198 = corrida
        end
        if ____t_199(____t_result_198) then
            R(
                nil,
                corrida.fim - 2,
                FLOOR - 90,
                4,
                90,
                "#5a5e62"
            )
            do
                local k = 0
                while k < 4 do
                    do
                        local j = 0
                        while j < 3 do
                            R(
                                nil,
                                corrida.fim + 2 + k * 6,
                                FLOOR - 90 + j * 6,
                                6,
                                6,
                                __t(__mod(k + j, 2)) and "#1c1c1c" or "#f6f6f0"
                            )
                            j = j + 1
                        end
                    end
                    k = k + 1
                end
            end
            do
                pcall(function()
                    window.Art:drawCharacter(
                        c,
                        "c2_nando",
                        corrida.nando,
                        FLOOR - 6,
                        {
                            frame = t,
                            facing = __t(corrida.nIda) and -1 or 1,
                            grounded = true
                        }
                    )
                end)
            end
            R(
                nil,
                corrida.nando - 14,
                FLOOR - 6,
                28,
                4,
                "#d9b347"
            )
            R(
                nil,
                corrida.nando - 10,
                FLOOR - 2,
                4,
                3,
                "#1c1c1c"
            )
            R(
                nil,
                corrida.nando + 6,
                FLOOR - 2,
                4,
                3,
                "#1c1c1c"
            )
        end
    end
    local function velocidade(self)
        return __t(tem(nil, "bike")) and 1.4 or (__t(tem(nil, "skate")) and 1.2 or 1)
    end
    local function forca(self)
        return __t(tem(nil, "moral")) and 1.15 or 1
    end
    local function missoes(self)
        if not __t(api) then
            return __arrL({}, 0)
        end
        local x = X(nil)
        local function st(____, k)
            return __get(x, k) == "feita" and "feita" or (__get(x, k) == "ativa" and "ativa" or "nova")
        end
        local L = __arrL({}, 0)
        __call(
            L,
            "push",
            __arrL(
                {
                    "O radinho da Dona Lurdes",
                    st(nil, "lurdes"),
                    "Ache o radinho na avenida (Monumento ao Índio)."
                },
                3
            )
        )
        __call(
            L,
            "push",
            __arrL(
                {
                    "O mapa verdadeiro da Mel",
                    st(nil, "mel"),
                    ("Pedaços: " .. tostring(pedacos(nil))) .. "/3 (fim do centro, fim da feira e beira da lagoa)."
                },
                3
            )
        )
        __call(
            L,
            "push",
            __arrL(
                {
                    "Um amigo caramelo",
                    __t(tem(nil, "cao")) and "feita" or (__t(x.cao_visto) and "ativa" or "nova"),
                    "Compre biscoito de polvilho com o Tio do Picolé (feira) e dê ao Biscoito (rua da pensão)."
                },
                3
            )
        )
        __call(
            L,
            "push",
            __arrL(
                {
                    "Corrida do Nando",
                    __t(tem(nil, "skate")) and "feita" or "nova",
                    "Vença a corrida de skate no centro."
                },
                3
            )
        )
        __call(
            L,
            "push",
            __arrL(
                {
                    "A bicicleta do Juninho",
                    st(nil, "juninho"),
                    ((("Corrente com o Gugu " .. (__t(tem(nil, "corrente")) and "✔" or "")) .. " · pneu na rodoviária ") .. (__t(pegou(nil, "pneu")) and "✔" or "")) .. "."
                },
                3
            )
        )
        __call(
            L,
            "push",
            __arrL(
                {
                    "O show da Bia",
                    __t(tem(nil, "moral")) and "feita" or "nova",
                    "Dance arrocha no palco do teatro."
                },
                3
            )
        )
        __call(
            L,
            "push",
            __arrL(
                {
                    "Caipira no Shopping",
                    st(nil, "fatima"),
                    ("Ache as peças da Dona Fátima (shopping, piso 2): " .. tostring(pecasCaipira(nil))) .. "/3."
                },
                3
            )
        )
        __call(
            L,
            "push",
            __arrL(
                {
                    "As pistas do Jorge",
                    __t(tem(nil, "pistas_ok")) and "feita" or (__t(__call(
                        __arrL({"pista_vocida", "pista_larissa", "pista_carlinhos"}, 3),
                        "some",
                        tem
                    )) and "ativa" or "nova"),
                    "Vó Cida (rua da pensão), Larissa (UESB) e Carlinhos (shopping)."
                },
                3
            )
        )
        return L
    end
    local function alvos(self, cena)
        if __t(not __t(api) or X(nil).mel ~= "feita") then
            return __arrL({}, 0)
        end
        return __call(
            __call(
                __call(
                    ALIADOS,
                    "filter",
                    function(____, a)
                        local ____t_result_209
                        local ____t_208 = __t
                        local ____temp_207 = a.cena == cena
                        __O[898] = ____temp_207
                        if ____t_208(____temp_207) then
                            ____t_result_209 = __call(
                                __arrL({"nova", "entregar"}, 2),
                                "includes",
                                a:estado()
                            )
                        else
                            ____t_result_209 = __O[898]
                        end
                        return ____t_result_209
                    end
                ),
                "map",
                function(____, a) return a.x end
            ),
            "concat",
            __call(
                __call(
                    ITENS,
                    "filter",
                    function(____, i)
                        local ____t_result_214
                        local ____t_213 = __t
                        local ____t_result_212
                        local ____t_211 = __t
                        local ____temp_210 = i.cena == cena
                        __O[899] = ____temp_210
                        if ____t_211(____temp_210) then
                            ____t_result_212 = i:quando()
                        else
                            ____t_result_212 = __O[899]
                        end
                        __O[900] = ____t_result_212
                        if ____t_213(____t_result_212) then
                            ____t_result_214 = not __t(pegou(nil, i.id))
                        else
                            ____t_result_214 = __O[900]
                        end
                        return ____t_result_214
                    end
                ),
                "map",
                function(____, i) return i.x end
            )
        )
    end
    window.CampanhaAliados = __ord(
        {
            ligar = function(____, a)
                api = a
                cao = nil
                corrida = nil
            end,
            candidatos = candidatos,
            atualizar = atualizar,
            desenhar = desenhar,
            velocidade = velocidade,
            vidaMax = vidaMax,
            forca = forca,
            missoes = missoes,
            alvos = alvos,
            ocupado = function() return not not __t(ritmo) end,
            correndo = function()
                local ____t_result_215
                if __t(corrida) then
                    ____t_result_215 = {t = corrida.t, lim = corrida.lim, cont = corrida.cont, fase = corrida.fase}
                else
                    ____t_result_215 = corrida
                end
                return ____t_result_215
            end
        },
        "ligar,candidatos,atualizar,desenhar,velocidade,vidaMax,forca,missoes,alvos,ocupado,correndo"
    )
end)(nil)
return ____exports
