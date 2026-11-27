--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __le, __gt, __ge, __mod, __ord, __arrL, __iterar, __t, __get, __arr, __len = __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__arr, __JSR.__len
local __call, __add, __iter = __JSR.__call, __JSR.__add, __JSR.__iter
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__MathSign = ____lualib.__TS__MathSign
local __TS__Spread = ____lualib.__TS__Spread
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local function clamp(____, n, l, r)
        return math.max(
            l,
            math.min(r, n)
        )
    end
    local largura = 84
    local cores = __arrL({"#4b9c99", "#ca6955", "#776fb5", "#4c81ab"}, 4)
    local function sob(____, m, x)
        return math.abs(x - m.x) <= largura / 2 + 4
    end
    local function criar(self, l, r, piso)
        local estrada = {
            tempo = 0,
            distancia = 0,
            montou = false,
            apoio = nil,
            motos = __arrL({}, 0),
            fase = 1
        }
        do
            local id = 0
            while id < 4 do
                local base = l + (r - l) * (0.12 + id * 0.25)
                local y = piso - 57 - __mod(id, 2) * 13
                local m = {
                    id = id,
                    base = base,
                    x = base,
                    y = y,
                    anteriorX = base,
                    anteriorY = y,
                    cor = __get(cores, id),
                    pulo = 0
                }
                m.rival = {
                    x = base + 25,
                    y = y + 3,
                    alto = 54,
                    largura = 17,
                    hp = 0,
                    max = 60,
                    hit = 0,
                    ejetado = 0,
                    dir = -1,
                    onDano = function(self, n)
                        if __le(self.hp, 0) then
                            return false
                        end
                        local dano = math.max(
                            1,
                            math.floor(n + 0.5)
                        )
                        self.hp = math.max(0, self.hp - dano)
                        self.hit = 0.16
                        if not __t(self.hp) then
                            self.ejetado = 0.52
                        end
                        return dano
                    end
                }
                __call(estrada.motos, "push", m)
                id = id + 1
            end
        end
        return estrada
    end
    local function novaFase(self, f, fase)
        local e = f.estrada
        e.fase = fase
        for ____, m in __iterar((e.motos)) do
            local ____t_8 = __t
            local ____t_5 = __t
            local ____t_1 = __t
            local ____temp_0 = fase == 1 and m.id == 1
            __O[885] = ____temp_0
            local ____t_3 = __t
            local ____temp_2 = fase == 2
            __O[884] = ____temp_2
            local ____temp_4 = if ____t_1(____temp_0) then __O[885] else if ____t_3(____temp_2) then m.id == 1 or m.id == 3 else __O[884]
            __O[887] = ____temp_4
            local ____t_7 = __t
            local ____temp_6 = fase == 3
            __O[886] = ____temp_6
            if ____t_8(if ____t_5(____temp_4) then __O[887] else if ____t_7(____temp_6) then m.id == 1 or m.id == 2 else __O[886]) then
                m.rival.max = 42 + fase * 10
                m.rival.hp = m.rival.max
                m.rival.ejetado = 0
            else
                m.rival.hp = 0
            end
        end
    end
    local function perto(self, e, x)
        return __call(
            e.motos,
            "reduce",
            function(____, a, b) return if math.abs(b.x - x) < math.abs(a.x - x) then b else a end
        )
    end
    local function avancar(self, f, dt, p)
        local e = f.estrada
        if not __t(e.montou) then
            local m = __get(e.motos, 0)
            p.x = m.x - 10
            p.y = m.y
            local ____p_9 = p
            p.vy = 0
            ____p_9.vx = 0
            p.ground = true
            p.facing = 1
            e.montou = true
            e.apoio = m.id
        end
        e.tempo = __add(e.tempo, dt)
        e.distancia = e.distancia + dt * (205 + 44 * f.fase)
        for ____, m in __iterar((e.motos)) do
            local t = e.tempo
            local fase = m.id * 1.61
            m.anteriorX = m.x
            m.anteriorY = m.y
            m.x = m.base + 22 * math.sin(t * 0.91 + fase) + 6 * math.sin(t * 2.15 + fase)
            m.y = f.piso - 60 - 15 * __mod(m.id, 2) + 7 * math.sin(t * 1.6 + fase) + 2 * math.sin(t * 7 + fase)
            local ____t_14 = __t
            local ____t_13 = __t
            local ____t_11 = __t
            local ____temp_10 = e.apoio == m.id
            __O[888] = ____temp_10
            local ____temp_12 = if ____t_11(____temp_10) then p.ground else __O[888]
            __O[889] = ____temp_12
            if ____t_14(if ____t_13(____temp_12) then __ge(p.vy, 0) else __O[889]) then
                p.x = p.x + (m.x - m.anteriorX)
                p.y = p.y + (m.y - m.anteriorY)
            end
            m.rival.x = m.x + 25
            m.rival.y = m.y + 3
            m.rival.hit = math.max(0, m.rival.hit - dt)
            m.rival.ejetado = math.max(0, m.rival.ejetado - dt)
            m.pulo = math.max(0, m.pulo - dt)
        end
        f.y = f.piso - 65 + 3 * math.sin(e.tempo * 5.7)
        for ____, o in __iterar((f.objetos)) do
            if o.moto ~= nil then
                local m = __get(e.motos, o.moto)
                local ____m_x_15 = m.x
                o.x1 = ____m_x_15
                o.x0 = ____m_x_15
                local ____temp_16 = m.y - o.ry
                o.y1 = ____temp_16
                o.y0 = ____temp_16
            end
        end
        for ____, o in __iterar((f.objetos)) do
            local ____t_21 = __t
            local ____t_18 = __t
            local ____temp_17 = o.cobrador ~= nil and not __t(__get(e.motos, o.cobrador).rival.hp)
            __O[891] = ____temp_17
            local ____t_20 = __t
            local ____temp_19 = f.estado == "windup"
            __O[890] = ____temp_19
            if ____t_21(if ____t_18(____temp_17) then if ____t_20(____temp_19) then __O[890] else f.estado == "firing" and __lt(f.tempo, o.atraso) else __O[891]) then
                o.fim = true
            end
        end
    end
    local function pousar(self, f, p, antes, ferir)
        local e = f.estrada
        local ultimo = e.apoio
        e.apoio = nil
        if __ge(p.vy, 0) then
            for ____, m in __iterar((e.motos)) do
                local ____t_24 = __t
                local ____t_23 = __t
                local ____temp_22 = not __t(sob(nil, m, p.x)) or __gt(
                    antes,
                    math.max(m.y, m.anteriorY) + 3
                )
                __O[892] = ____temp_22
                if ____t_24(if ____t_23(____temp_22) then __O[892] else __lt(p.y, m.y)) then
                    continue
                end
                if ultimo ~= m.id then
                    m.pulo = 0.2
                end
                p.y = m.y
                p.vy = 0
                p.ground = true
                e.apoio = m.id
                return
            end
        end
        if __lt(p.y, f.piso + 1) then
            return
        end
        local m = perto(nil, e, p.x)
        ferir(nil, 10, p.x)
        p.x = m.x - 12
        p.y = m.y
        local ____p_25 = p
        p.vy = 0
        ____p_25.vx = 0
        p.ground = true
        e.apoio = m.id
        m.pulo = 0.2
        p.inv = math.max(if __t(p.inv) then p.inv else 0, 0.95)
    end
    local function setores(self, a, art, altura, dois)
        local e = a.f.estrada
        local m = perto(nil, e, a.x)
        local indices = __arrL({m.id}, 1)
        if __t(dois) then
            __call(indices, "push", if m.id == 3 then 2 else m.id + 1)
        end
        return __call(
            indices,
            "map",
            function(____, id, k)
                local apoio = __get(e.motos, id)
                local o = a:area(
                    art,
                    apoio.x,
                    largura + 13,
                    altura,
                    k * 0.44,
                    0.76
                )
                o.moto = id
                local ____temp_26 = apoio.y - o.ry
                o.y1 = ____temp_26
                o.y0 = ____temp_26
                return o
            end
        )
    end
    local function recibos(self, a)
        local h = a.f.piso - a.f.y
        local lista = __arrL(
            {a:mov(
                "recibo",
                a.b,
                h + 41,
                a.edge,
                a.altura,
                0.87,
                {onda = 17, rx = 13}
            )},
            1
        )
        local e = a.f.estrada
        for ____, m in __iterar((e.motos)) do
            if __gt(m.rival.hp, 0) then
                __call(
                    lista,
                    "push",
                    a:mov(
                        "recibo",
                        m.rival.x,
                        a.f.piso - m.rival.y + 37,
                        a:alvo(0),
                        a.altura,
                        0.78,
                        {
                            arco = 27,
                            atraso = 0.28 + 0.24 * (__len(lista) - 1),
                            rx = 12,
                            ry = 10,
                            cobrador = m.id
                        }
                    )
                )
            end
        end
        return lista
    end
    local function alvo(self, f, p, chefe)
        local escolhido = chefe
        local dist = if __TS__MathSign(chefe.x - p.x) == p.facing then math.abs(chefe.x - p.x) else math.huge
        for ____, m in __iterar((f.estrada.motos)) do
            local r = m.rival
            local d = (r.x - p.x) * p.facing
            local ____t_29 = __t
            local ____t_28 = __t
            local ____temp_27 = __gt(r.hp, 0) and d > 0
            __O[893] = ____temp_27
            if ____t_29(if ____t_28(____temp_27) then d < dist else __O[893]) then
                dist = d
                escolhido = r
            end
        end
        return escolhido
    end
    local function acertar(self, f, s)
        for ____, m in __iterar((f.estrada.motos)) do
            local r = m.rival
            local ____t_34 = __t
            local ____t_33 = __t
            local ____t_31 = __t
            local ____temp_30 = __gt(r.hp, 0) and __lt(
                math.abs(s.x - r.x),
                r.largura + 7
            )
            __O[894] = ____temp_30
            local ____temp_32 = if ____t_31(____temp_30) then __gt(s.y, r.y - r.alto - 6) else __O[894]
            __O[895] = ____temp_32
            if ____t_34(if ____t_33(____temp_32) then __lt(s.y, r.y + 5) else __O[895]) then
                r:onDano(s.damage)
                return true
            end
        end
        return false
    end
    local function px(____, c, x, y, w, h, cor)
        c.fillStyle = cor
        c:fillRect(
            math.floor(x + 0.5),
            math.floor(y + 0.5),
            math.floor(w + 0.5),
            math.floor(h + 0.5)
        )
    end
    local function pol(self, c, pts, cor)
        c.fillStyle = cor
        c:beginPath()
        c:moveTo(
            math.floor(__get(
                __get(pts, 0),
                0
            ) + 0.5),
            math.floor(__get(
                __get(pts, 0),
                1
            ) + 0.5)
        )
        do
            local i = 1
            while __lt(
                i,
                __len(pts)
            ) do
                c:lineTo(
                    math.floor(__get(
                        __get(pts, i),
                        0
                    ) + 0.5),
                    math.floor(__get(
                        __get(pts, i),
                        1
                    ) + 0.5)
                )
                i = i + 1
            end
        end
        c:closePath()
        __call(c, "fill")
    end
    local function traco(self, c, pts, cor, w)
        if w == nil then
            w = 2
        end
        c.strokeStyle = cor
        c.lineWidth = w
        c.lineJoin = "bevel"
        c:beginPath()
        c:moveTo(
            math.floor(__get(
                __get(pts, 0),
                0
            ) + 0.5),
            math.floor(__get(
                __get(pts, 0),
                1
            ) + 0.5)
        )
        do
            local i = 1
            while __lt(
                i,
                __len(pts)
            ) do
                c:lineTo(
                    math.floor(__get(
                        __get(pts, i),
                        0
                    ) + 0.5),
                    math.floor(__get(
                        __get(pts, i),
                        1
                    ) + 0.5)
                )
                i = i + 1
            end
        end
        c:stroke()
    end
    local paisagem
    local function serra(self)
        if __t(paisagem) then
            return paisagem
        end
        local img = window.document:createElement("canvas")
        img.width = 480
        img.height = 215
        local c = img:getContext("2d")
        local g = c:createLinearGradient(0, 0, 0, 204)
        g:addColorStop(0, "#4190c8")
        g:addColorStop(0.57, "#8bd2df")
        g:addColorStop(1, "#fee2a6")
        c.fillStyle = g
        c:fillRect(0, 0, 480, 215)
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({0, 11}, 2),
                __arrL({2, 19}, 2),
                __arrL({5, 25}, 2),
                __arrL({8, 29}, 2),
                __arrL({14, 28}, 2),
                __arrL({19, 22}, 2),
                __arrL({23, 14}, 2)
            },
            7
        ))) do
            local dy = ____value[1]
            local w = ____value[2]
            px(
                nil,
                c,
                369 - w / 2,
                31 + dy,
                w,
                5,
                "#fff1b5"
            )
        end
        do
            local n = 0
            while n < 8 do
                local x = n * 69 - 25
                local y = 28 + __mod(n * 43, 61)
                pol(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x, y + 7}, 2),
                            __arrL({x + 5, y + 7}, 2),
                            __arrL({x + 5, y + 4}, 2),
                            __arrL({x + 17, y + 4}, 2),
                            __arrL({x + 17, y}, 2),
                            __arrL({x + 28, y}, 2),
                            __arrL({x + 28, y + 3}, 2),
                            __arrL({x + 38, y + 3}, 2),
                            __arrL({x + 38, y + 7}, 2),
                            __arrL({x + 49, y + 7}, 2),
                            __arrL({x + 49, y + 10}, 2),
                            __arrL({x, y + 10}, 2)
                        },
                        12
                    ),
                    "#e2eeeb"
                )
                n = n + 1
            end
        end
        do
            local k = 0
            while k < 3 do
                local pts = __arrL(
                    {__arrL({0, 215}, 2)},
                    1
                )
                do
                    local x = 0
                    while x <= 480 do
                        local a = x / 480 * math.pi * 2
                        __call(
                            pts,
                            "push",
                            __arrL(
                                {
                                    x,
                                    124 + 23 * k + math.sin(a * (2 + k) + k) * 15 + math.cos(a * 4 + k) * 6
                                },
                                2
                            )
                        )
                        x = x + 4
                    end
                end
                local ____pol_37 = pol
                local ____arr_36 = __arr
                local ____array_35 = __TS__SparseArrayNew(__TS__Spread(__iter(pts)))
                __TS__SparseArrayPush(
                    ____array_35,
                    __arrL({480, 215}, 2)
                )
                ____pol_37(
                    nil,
                    c,
                    ____arr_36(__TS__SparseArraySpread(____array_35)),
                    __get(
                        __arrL({"#96b9bb", "#779e9a", "#5c8980"}, 3),
                        k
                    )
                )
                k = k + 1
            end
        end
        do
            local k = 0
            while k < 32 do
                local x = __mod(k * 31, 480)
                local y = 165 + __mod(k * 17, 19)
                local w = 6 + __mod(k, 3) * 2
                px(
                    nil,
                    c,
                    x,
                    y,
                    w,
                    5 + __mod(k, 3),
                    __get(
                        __arrL({"#d6bd93", "#ac9890", "#c7b393"}, 3),
                        __mod(k, 3)
                    )
                )
                pol(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x - 1, y}, 2),
                            __arrL({x + w / 2, y - 4}, 2),
                            __arrL({x + w + 2, y}, 2)
                        },
                        3
                    ),
                    "#9e7161"
                )
                px(
                    nil,
                    c,
                    x + 2,
                    y + 1,
                    2,
                    2,
                    "#576b69"
                )
                k = k + 1
            end
        end
        paisagem = img
        return paisagem
    end
    local function fundo(self, c, f)
        local d = f.estrada.distancia
        local faixa = __mod(
            __mod(d * 0.1, 960) + 960,
            960
        )
        c:save()
        c.imageSmoothingEnabled = false
        c:drawImage(
            serra(nil),
            -math.floor(faixa + 0.5),
            0,
            960,
            430
        )
        c:drawImage(
            serra(nil),
            960 - math.floor(faixa + 0.5),
            0,
            960,
            430
        )
        px(
            nil,
            c,
            0,
            362,
            960,
            178,
            "#556369"
        )
        px(
            nil,
            c,
            0,
            362,
            960,
            4,
            "#a3aca0"
        )
        px(
            nil,
            c,
            0,
            369,
            960,
            6,
            "#7a8582"
        )
        do
            local i = 0
            while i < 10 do
                local x = i * 126 - __mod(d * 0.64, 126)
                px(
                    nil,
                    c,
                    x,
                    344,
                    5,
                    23,
                    "#5d726e"
                )
                px(
                    nil,
                    c,
                    x - 3,
                    343,
                    12,
                    3,
                    "#c3c3a4"
                )
                i = i + 1
            end
        end
        px(
            nil,
            c,
            0,
            349,
            960,
            5,
            "#b8c2ad"
        )
        px(
            nil,
            c,
            0,
            353,
            960,
            3,
            "#778d84"
        )
        do
            local i = 0
            while i < 9 do
                local x = i * 160 - __mod(d, 160)
                px(
                    nil,
                    c,
                    x,
                    417,
                    72,
                    3,
                    "#d7b365"
                )
                px(
                    nil,
                    c,
                    x - 12,
                    430,
                    73,
                    3,
                    "#e8c77d"
                )
                px(
                    nil,
                    c,
                    x - 48,
                    496,
                    99,
                    6,
                    "#b7b7a9"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 35 do
                local x = __mod(
                    __mod(i * 167 - d * 0.85, 1000) + 1000,
                    1000
                ) - 25
                px(
                    nil,
                    c,
                    x,
                    381 + __mod(i, 9) * 16,
                    5 + __mod(i, 4) * 4,
                    1,
                    "#46585f"
                )
                i = i + 1
            end
        end
        local poste = 915 - __mod(d * 0.5, 1190)
        px(
            nil,
            c,
            poste,
            226,
            7,
            121,
            "#576d69"
        )
        px(
            nil,
            c,
            poste - 81,
            222,
            157,
            45,
            "#344f50"
        )
        px(
            nil,
            c,
            poste - 78,
            225,
            151,
            38,
            "#488575"
        )
        c.fillStyle = "#f7edbe"
        c.font = "bold 13px monospace"
        c.textAlign = "center"
        c:fillText("BR-116  →", poste, 241)
        c.font = "10px monospace"
        c:fillText("VITÓRIA DA CONQUISTA", poste, 256)
        if __lt(f.estrada.tempo, 4) then
            local dica = "PULE ENTRE AS MOTOS E ACERTE OS COBRADORES"
            c.font = "bold 15px monospace"
            local w = math.ceil(c:measureText(dica).width) + 24
            px(
                nil,
                c,
                480 - w / 2,
                86,
                w,
                24,
                "#263c44"
            )
            c.fillStyle = "#fff0c5"
            c:fillText(dica, 480, 103)
        end
        c:restore()
    end
    local function roda(self, c, x, y, t, cor)
        pol(
            nil,
            c,
            __arrL(
                {
                    __arrL({x - 9, y - 13}, 2),
                    __arrL({x + 9, y - 13}, 2),
                    __arrL({x + 14, y - 8}, 2),
                    __arrL({x + 14, y + 7}, 2),
                    __arrL({x + 8, y + 13}, 2),
                    __arrL({x - 8, y + 13}, 2),
                    __arrL({x - 14, y + 7}, 2),
                    __arrL({x - 14, y - 7}, 2)
                },
                8
            ),
            "#28333b"
        )
        pol(
            nil,
            c,
            __arrL(
                {
                    __arrL({x - 6, y - 9}, 2),
                    __arrL({x + 6, y - 9}, 2),
                    __arrL({x + 9, y - 5}, 2),
                    __arrL({x + 9, y + 5}, 2),
                    __arrL({x + 5, y + 8}, 2),
                    __arrL({x - 5, y + 8}, 2),
                    __arrL({x - 9, y + 5}, 2),
                    __arrL({x - 9, y - 5}, 2)
                },
                8
            ),
            "#82969a"
        )
        do
            local i = 0
            while i < 3 do
                local a = t + i * 2.094
                traco(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x, y}, 2),
                            __arrL(
                                {
                                    x + 7 * math.cos(a),
                                    y + 7 * math.sin(a)
                                },
                                2
                            )
                        },
                        2
                    ),
                    "#384b55",
                    3
                )
                i = i + 1
            end
        end
        px(
            nil,
            c,
            x - 2,
            y - 2,
            4,
            4,
            cor
        )
    end
    local function piloto(self, c, x, y, cor, capacete, chefe, acao, t, hit)
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        local pele = if __t(hit) then "#fff2cc" else if __t(chefe) then "#a96f48" else "#ad7c59"
        local bal = if __t(acao) then math.floor(3 * math.sin(t * 8) + 0.5) else 0
        traco(
            nil,
            c,
            __arrL(
                {
                    __arrL({-6, -10}, 2),
                    __arrL({4, 0}, 2),
                    __arrL({15, 6}, 2),
                    __arrL({10, 15}, 2)
                },
                4
            ),
            "#29343f",
            8
        )
        px(
            nil,
            c,
            6,
            13,
            13,
            5,
            "#34454b"
        )
        pol(
            nil,
            c,
            __arrL(
                {
                    __arrL({-10, -12}, 2),
                    __arrL({-11, -31}, 2),
                    __arrL({-4, -40}, 2),
                    __arrL({9, -38}, 2),
                    __arrL({15, -25}, 2),
                    __arrL({7, -10}, 2)
                },
                6
            ),
            "#263943"
        )
        pol(
            nil,
            c,
            __arrL(
                {
                    __arrL({-8, -13}, 2),
                    __arrL({-9, -29}, 2),
                    __arrL({-3, -37}, 2),
                    __arrL({7, -35}, 2),
                    __arrL({12, -25}, 2),
                    __arrL({5, -13}, 2)
                },
                6
            ),
            cor
        )
        px(
            nil,
            c,
            -7,
            -24,
            17,
            3,
            if __t(chefe) then "#f3e873" else "#d6dab9"
        )
        traco(
            nil,
            c,
            __arrL(
                {
                    __arrL({5, -32}, 2),
                    __arrL({14, -23 + bal}, 2),
                    __arrL({24, -24 + bal}, 2)
                },
                3
            ),
            "#29343d",
            7
        )
        traco(
            nil,
            c,
            __arrL(
                {
                    __arrL({6, -32}, 2),
                    __arrL({14, -24 + bal}, 2),
                    __arrL({22, -24 + bal}, 2)
                },
                3
            ),
            pele,
            4
        )
        pol(
            nil,
            c,
            __arrL(
                {
                    __arrL({-7, -41}, 2),
                    __arrL({-8, -50}, 2),
                    __arrL({-4, -56}, 2),
                    __arrL({7, -57}, 2),
                    __arrL({15, -51}, 2),
                    __arrL({15, -42}, 2),
                    __arrL({11, -36}, 2),
                    __arrL({1, -36}, 2)
                },
                8
            ),
            "#2a3540"
        )
        px(
            nil,
            c,
            -5,
            -52,
            18,
            11,
            capacete
        )
        px(
            nil,
            c,
            -2,
            -55,
            12,
            4,
            capacete
        )
        px(
            nil,
            c,
            -2,
            -53,
            10,
            2,
            "#f1d8af"
        )
        px(
            nil,
            c,
            3,
            -49,
            13,
            5,
            "#344c5a"
        )
        px(
            nil,
            c,
            6,
            -49,
            8,
            2,
            "#b2e1da"
        )
        px(
            nil,
            c,
            4,
            -43,
            9,
            6,
            pele
        )
        if __t(chefe) then
            px(
                nil,
                c,
                7,
                -40,
                7,
                2,
                "#302621"
            )
            px(
                nil,
                c,
                -7,
                -31,
                3,
                14,
                "#e6da71"
            )
        end
        if __t(if __t(acao) then not __t(chefe) else acao) then
            traco(
                nil,
                c,
                __arrL(
                    {
                        __arrL({-6, -30}, 2),
                        __arrL({-13, -33}, 2),
                        __arrL({-17, -41}, 2)
                    },
                    3
                ),
                pele,
                4
            )
            px(
                nil,
                c,
                -21,
                -47,
                11,
                10,
                "#f4e0b3"
            )
            px(
                nil,
                c,
                -20,
                -44,
                8,
                2,
                "#c47b63"
            )
        end
        c:restore()
    end
    local function moto(self, c, x, y, cor, t, bal, chefe, rival, f)
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        local treme = math.floor(bal * 3 + if __t(chefe) then math.sin(t * 8) * 1.5 else 0 + 0.5)
        px(
            nil,
            c,
            -39,
            42,
            96,
            3,
            "#414e55"
        )
        px(
            nil,
            c,
            -29,
            45,
            68,
            2,
            "#4c595f"
        )
        do
            local i = 0
            while i < 3 do
                local u = __mod(t * 2.2 + i / 3, 1)
                px(
                    nil,
                    c,
                    -46 - u * 37,
                    22 + i * 4 - u * 5,
                    4 + u * 8,
                    2,
                    if __t(__mod(i, 2)) then "#a2a8a2" else "#8e9a98"
                )
                i = i + 1
            end
        end
        roda(
            nil,
            c,
            -31,
            28,
            t * 17,
            cor
        )
        roda(
            nil,
            c,
            45,
            28,
            t * 17,
            cor
        )
        c:translate(0, treme)
        traco(
            nil,
            c,
            __arrL(
                {
                    __arrL({-32, 27}, 2),
                    __arrL({-7, 7}, 2),
                    __arrL({16, 26}, 2),
                    __arrL({33, 4}, 2),
                    __arrL({45, 27}, 2)
                },
                5
            ),
            "#263742",
            6
        )
        traco(
            nil,
            c,
            __arrL(
                {
                    __arrL({-30, 25}, 2),
                    __arrL({-6, 9}, 2),
                    __arrL({15, 24}, 2),
                    __arrL({33, 3}, 2),
                    __arrL({45, 26}, 2)
                },
                5
            ),
            "#bac1b5",
            3
        )
        pol(
            nil,
            c,
            __arrL(
                {
                    __arrL({-44, 9}, 2),
                    __arrL({-36, 4}, 2),
                    __arrL({-23, 5}, 2),
                    __arrL({-10, 11}, 2),
                    __arrL({5, -4}, 2),
                    __arrL({24, -8}, 2),
                    __arrL({39, 1}, 2),
                    __arrL({32, 13}, 2),
                    __arrL({13, 17}, 2),
                    __arrL({-5, 16}, 2),
                    __arrL({-13, 10}, 2)
                },
                11
            ),
            cor
        )
        px(
            nil,
            c,
            -14,
            9,
            26,
            8,
            "#667477"
        )
        do
            local i = 0
            while i < 3 do
                px(
                    nil,
                    c,
                    -12,
                    10 + i * 2,
                    18,
                    1,
                    "#b1b6a9"
                )
                i = i + 1
            end
        end
        px(
            nil,
            c,
            -46,
            18,
            34,
            4,
            "#a4a8a2"
        )
        px(
            nil,
            c,
            -45,
            21,
            26,
            2,
            "#37474c"
        )
        traco(
            nil,
            c,
            __arrL(
                {
                    __arrL({28, -1}, 2),
                    __arrL({35, -20}, 2),
                    __arrL({44, -22}, 2)
                },
                3
            ),
            "#384953",
            4
        )
        px(
            nil,
            c,
            34,
            -10,
            12,
            8,
            "#f6d77e"
        )
        px(
            nil,
            c,
            36,
            -9,
            8,
            4,
            "#fff3b2"
        )
        px(
            nil,
            c,
            -45,
            -1,
            83,
            5,
            "#293943"
        )
        px(
            nil,
            c,
            -41,
            -1,
            77,
            2,
            "#d5b486"
        )
        px(
            nil,
            c,
            -33,
            3,
            34,
            3,
            "#536167"
        )
        if __t(chefe) then
            piloto(
                nil,
                c,
                6,
                -2,
                "#ee8c31",
                "#c84035",
                true,
                f.estado == "firing",
                t,
                false
            )
        elseif __gt(rival.hp, 0) then
            local ____piloto_41 = piloto
            local ____array_40 = __TS__SparseArrayNew(
                nil,
                c,
                17,
                -1,
                cor,
                "#414e60",
                false
            )
            local ____t_39 = __t
            local ____temp_38 = f.golpe == "recibo"
            __O[896] = ____temp_38
            __TS__SparseArrayPush(
                ____array_40,
                if ____t_39(____temp_38) then f.estado == "windup" or f.estado == "firing" else __O[896],
                t,
                __gt(rival.hit, 0)
            )
            ____piloto_41(__TS__SparseArraySpread(____array_40))
        elseif __gt(rival.ejetado, 0) then
            local u = 1 - rival.ejetado / 0.52
            c:save()
            c:translate(
                17 - u * 77,
                -math.sin(u * math.pi) * 37 + u * 18
            )
            c:rotate(-u * 0.8)
            c.globalAlpha = 1 - u
            piloto(
                nil,
                c,
                0,
                -1,
                cor,
                "#414e60",
                false,
                false,
                t,
                false
            )
            c:restore()
        else
            px(
                nil,
                c,
                18,
                -10,
                12,
                8,
                "#5c493f"
            )
            px(
                nil,
                c,
                17,
                -10,
                14,
                2,
                "#c2a578"
            )
        end
        local ____t_44 = __t
        local ____t_43 = __t
        local ____temp_42 = not __t(chefe) and __gt(rival.hp, 0)
        __O[897] = ____temp_42
        if ____t_44(if ____t_43(____temp_42) then __lt(rival.hp, rival.max) else __O[897]) then
            px(
                nil,
                c,
                7,
                -69,
                24,
                3,
                "#2c3b40"
            )
            px(
                nil,
                c,
                8,
                -68,
                22 * rival.hp / rival.max,
                1,
                "#eeb57c"
            )
        end
        if __t(if __t(chefe) then f.estado == "windup" else chefe) then
            px(
                nil,
                c,
                37,
                -9,
                8,
                3,
                if math.sin(t * 15) > 0.1 then "#fff8db" else "#d79746"
            )
        end
        c:restore()
    end
    local function plataformas(self, c, f)
        for ____, m in __iterar((f.estrada.motos)) do
            moto(
                nil,
                c,
                m.x,
                m.y,
                m.cor,
                f.estrada.tempo,
                m.pulo / 0.2,
                false,
                m.rival,
                f
            )
        end
    end
    local function personagem(self, c, f)
        moto(
            nil,
            c,
            f.x,
            f.y,
            "#e77738",
            f.estrada.tempo,
            0,
            true,
            nil,
            f
        )
    end
    window.PerseguicaoMoto = __ord({
        criar = criar,
        novaFase = novaFase,
        avancar = avancar,
        pousar = pousar,
        setores = setores,
        recibos = recibos,
        alvo = alvo,
        acertar = acertar,
        fundo = fundo,
        plataformas = plataformas,
        personagem = personagem,
        largura = largura
    }, "criar,novaFase,avancar,pousar,setores,recibos,alvo,acertar,fundo,plataformas,personagem,largura")
end)(nil)
return ____exports
