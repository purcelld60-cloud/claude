--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __newExpr, __hasOwnV, __fcall, __lt, __le, __gt, __ge, __getq, __mod, __ord, __arrL, __iterar = __JSR.__newExpr, __JSR.__hasOwnV, __JSR.__fcall, __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__getq, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar
local __t, __get, __set, __len, __call, __add, __new, __iter, __keys, __assign, __isArray, __band = __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__new, __JSR.__iter, __JSR.__keys, __JSR.__assign, __JSR.__isArray, __JSR.__band
local __shr, __hypot, __re, __re_test, __re_replace, __re_exec = __JSR.__shr, __JSR.__hypot, __JSR.__re, __JSR.__re_test, __JSR.__re_replace, __JSR.__re_exec
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__ParseInt = ____lualib.__TS__ParseInt
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local __TS__Spread = ____lualib.__TS__Spread
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local ____t_4 = __t
    local ____t_result_3
    if __t(window.CampanhaCutscenes) then
        ____t_result_3 = window.CampanhaCutscenes
    else
        local ____t_2 = __t
        local ____opt_0 = window.Roteiro
        if ____opt_0 ~= nil then
            ____opt_0 = ____opt_0.estender
        end
        ____t_result_3 = not ____t_2(____opt_0)
    end
    if ____t_4(____t_result_3) then
        return
    end
    local W = 960
    local H = 540
    local TAU = math.pi * 2
    local function clamp(____, v, a, b)
        return math.max(
            a,
            math.min(b, v)
        )
    end
    local function ease(____, k)
        k = clamp(nil, k, 0, 1)
        return k * k * (3 - 2 * k)
    end
    local function lerp(____, a, b, k)
        return a + (b - a) * k
    end
    local function hash(____, n)
        local x = math.sin(n * 127.1 + 311.7) * 43758.5453
        return x - math.floor(x)
    end
    local function P(____, c, x, y, w, h, col)
        c.fillStyle = col
        c:fillRect(
            math.floor(x / 2 + 0.5) * 2,
            math.floor(y / 2 + 0.5) * 2,
            math.max(
                2,
                math.floor(w / 2 + 0.5) * 2
            ),
            math.max(
                2,
                math.floor(h / 2 + 0.5) * 2
            )
        )
    end
    local function circ(____, c, cx, cy, r, col, ry)
        if ry == nil then
            ry = r
        end
        c.fillStyle = col
        do
            local y = __TS__Number(-ry)
            while __le(y, ry) do
                local w = math.floor(r * math.sqrt(math.max(0, 1 - y / ry * (y / ry))) / 2 + 0.5) * 2
                c:fillRect(
                    math.floor((cx - w) / 2 + 0.5) * 2,
                    math.floor((cy + y) / 2 + 0.5) * 2,
                    w * 2 + 2,
                    2
                )
                y = y + 2
            end
        end
    end
    local function txt(____, c, s, x, y, col, o)
        if o == nil then
            o = {}
        end
        local ____opt_7 = window.CampanhaCamadas
        if ____opt_7 ~= nil then
            ____opt_7 = ____opt_7.kit
        end
        local ____opt_result_9
        if ____opt_7 ~= nil then
            ____opt_result_9 = ____opt_7.pxText
        end
        local f = ____opt_result_9
        if __t(f) then
            return f(
                nil,
                c,
                s,
                x,
                y,
                col,
                o
            )
        end
        local ____c_11 = c
        local ____t_result_10
        if __t(o.s) then
            ____t_result_10 = o.s
        else
            ____t_result_10 = 1
        end
        ____c_11.font = tostring(8 * ____t_result_10) .. "px Pixel, monospace"
        c.fillStyle = col
        c.textAlign = "center"
        local ____c_16 = c
        local ____c_fillText_17 = c.fillText
        local ____s_14 = s
        local ____x_15 = x
        local ____y_13 = y
        local ____t_result_12
        if __t(o.s) then
            ____t_result_12 = o.s
        else
            ____t_result_12 = 1
        end
        ____c_fillText_17(____c_16, ____s_14, ____x_15, ____y_13 + 6 * ____t_result_12)
        c.textAlign = "left"
        return 0
    end
    local function larg(____, s, sc)
        if sc == nil then
            sc = 1
        end
        return __len(tostring(s)) * 4 * sc - sc
    end
    local function ator(____, c, ____type, x, y, o)
        if o == nil then
            o = {}
        end
        do
            pcall(function()
                local ____opt_20 = window.Art
                if ____opt_20 ~= nil then
                    ____opt_20 = ____opt_20.drawCharacter
                end
                if ____opt_20 ~= nil then
                    ____opt_20(
                        ____opt_20,
                        c,
                        ____type,
                        x,
                        y,
                        __assign({}, {facing = 1, frame = 0, scale = 1, grounded = true}, o)
                    )
                end
            end)
        end
    end
    local function grad(____, c, y0, y1, cores)
        local n = __len(cores)
        do
            local y = y0
            while __lt(y, y1) do
                local k = (y - y0) / (y1 - y0) * (n - 1)
                local i = math.min(
                    n - 2,
                    math.floor(k)
                )
                local f = k - i
                local d = __mod(y / 2, 2) * 0.5
                local ____c_23 = c
                local ____temp_22
                if f + (hash(nil, y) - 0.5) * 0.12 > 0.5 + d * 0 then
                    ____temp_22 = __get(cores, i + 1)
                else
                    ____temp_22 = __get(cores, i)
                end
                ____c_23.fillStyle = ____temp_22
                c:fillRect(0, y, W, 2)
                y = y + 2
            end
        end
    end
    local retratos = {}
    local function retrato(____, ____type, emo)
        local ____add_26 = __add
        local ____type_25 = ____type
        local ____t_result_24
        if __t(emo) then
            ____t_result_24 = emo
        else
            ____t_result_24 = ""
        end
        local k = ____add_26(____type_25, ____t_result_24)
        if __t(__get(retratos, k)) then
            return __get(retratos, k)
        end
        local cv = window.document:createElement("canvas")
        cv.height = 64
        cv.width = 64
        do
            pcall(function()
                window.Roteiro:portrait(
                    cv:getContext("2d"),
                    ____type,
                    64,
                    0,
                    emo
                )
            end)
        end
        return __set(retratos, k, cv)
    end
    local SKIN = __ord({daroca = "#c68a5e", jorge = "#e2b48a", reeis = "#7a4a2e", miguel = "#f0c8a8"}, "daroca,jorge,reeis,miguel")
    local function sfx(____, n)
        do
            pcall(function()
                window.Roteiro:sfx(n)
            end)
        end
    end
    local nomes = __ord({
        jorge = "Jorge",
        jorge_gordo = "Jorge",
        jorge_celular = "Jorge",
        miguel = "Miguel",
        fred_conquista = "Fred",
        crianca_daroca = "Da Roça",
        crianca_reeis = "Reeis",
        crianca_jorge = "Jorge",
        pre_daroca = "Da Roça",
        pre_reeis = "Reeis",
        pre_jorge = "Jorge",
        c2_biscoito = "Biscoito",
        piloto = "Comandante",
        comissaria = "Comissária"
    }, "jorge,jorge_gordo,jorge_celular,miguel,fred_conquista,crianca_daroca,crianca_reeis,crianca_jorge,pre_daroca,pre_reeis,pre_jorge,c2_biscoito,piloto,comissaria")
    do
        pcall(function()
            local ____iter_31 = __iter
            local ____t_result_30
            local ____t_29 = __t
            local ____opt_27 = window.CampanhaPersonagens
            if ____opt_27 ~= nil then
                ____opt_27 = ____opt_27.lista
            end
            __O[810] = ____opt_27
            if ____t_29(____opt_27) then
                ____t_result_30 = __O[810]
            else
                ____t_result_30 = __arrL({}, 0)
            end
            for ____, p in __TS__Iterator(____iter_31(____t_result_30)) do
                if not __t(__get(nomes, p.id)) then
                    __set(nomes, p.id, p.nome)
                end
            end
        end)
    end
    local cenarios = __ord({
        pensao = 13,
        bairro = 13,
        centro = 14,
        catedral = 14,
        serra = 15,
        cristo = 15,
        monumento = 16,
        avenidas = 16,
        feira = 17,
        cafe = 18,
        fazenda = 18,
        teatro = 19,
        cultura = 19,
        planetario = 19,
        shopping = 20,
        sesi = 21,
        olivia = 21,
        escola_sesi = 21,
        corredor = 24,
        quarto = 25,
        patio_sesi = 27,
        poco = 28,
        lomantao = 29,
        rodoviaria_conquista = 30,
        uesb = 31,
        lagoa = 32,
        parque = 33,
        marcal = 34,
        aeroporto = 12
    }, "pensao,bairro,centro,catedral,serra,cristo,monumento,avenidas,feira,cafe,fazenda,teatro,cultura,planetario,shopping,sesi,olivia,escola_sesi,corredor,quarto,patio_sesi,poco,lomantao,rodoviaria_conquista,uesb,lagoa,parque,marcal,aeroporto")
    do
        pcall(function()
            local ____iter_40 = __iter
            local ____t_result_39
            local ____t_38 = __t
            local ____opt_36 = window.CampanhaCenarios
            if ____opt_36 ~= nil then
                ____opt_36 = ____opt_36.lista
            end
            __O[811] = ____opt_36
            if ____t_38(____opt_36) then
                ____t_result_39 = __O[811]
            else
                ____t_result_39 = __arrL({}, 0)
            end
            for ____, d in __TS__Iterator(____iter_40(____t_result_39)) do
                local ____t_35 = __t
                local ____t_result_34
                local ____t_33 = __t
                local ____t_result_32
                if __t(d.key) then
                    ____t_result_32 = not (cenarios[d.key] ~= nil)
                else
                    ____t_result_32 = d.key
                end
                __O[812] = ____t_result_32
                if ____t_33(____t_result_32) then
                    ____t_result_34 = not __t(__call(
                        __arrL({"patio"}, 1),
                        "includes",
                        d.key
                    ))
                else
                    ____t_result_34 = __O[812]
                end
                if ____t_35(____t_result_34) then
                    __set(cenarios, d.key, d.id)
                end
            end
        end)
    end
    local function ceuRoca(self, c, tt)
        grad(
            nil,
            c,
            0,
            H,
            __arrL({"#0a0e24", "#141a3a", "#241f4a", "#3a2850"}, 4)
        )
        do
            local i = 0
            while i < 70 do
                local tw = math.sin(tt * 2 + i * 1.7) > 0.2
                if __t(tw) then
                    P(
                        nil,
                        c,
                        hash(nil, i) * W,
                        hash(nil, i + 9) * 300,
                        2,
                        2,
                        __t(__mod(i, 9)) and "#c8d0ff" or "#fff6c0"
                    )
                end
                i = i + 1
            end
        end
        c.fillStyle = "#0c1020"
        c:beginPath()
        c:moveTo(0, 380)
        do
            local x = 0
            while x <= W do
                c:lineTo(
                    x,
                    370 - math.sin(x / 140) * 40 - math.sin(x / 57) * 12
                )
                x = x + 40
            end
        end
        c:lineTo(W, H)
        c:lineTo(0, H)
        __call(c, "fill")
        P(
            nil,
            c,
            120,
            330,
            70,
            50,
            "#10142a"
        )
        P(
            nil,
            c,
            110,
            316,
            90,
            16,
            "#14182e"
        )
        P(
            nil,
            c,
            146,
            350,
            12,
            14,
            "#e8b04a"
        )
        do
            local i = 0
            while i < 14 do
                local on = math.sin(tt * 1.6 + i * 2.3) > 0.4
                if __t(on) then
                    local x = hash(nil, i + 3) * W + math.sin(tt * 0.4 + i) * 30
                    local y = 380 + hash(nil, i + 5) * 140
                    P(
                        nil,
                        c,
                        x,
                        y,
                        2,
                        2,
                        "#e8f87a"
                    )
                    c.fillStyle = "rgba(232,248,122,.18)"
                    c:fillRect(x - 4, y - 4, 10, 10)
                end
                i = i + 1
            end
        end
    end
    local function quartoJorge(self, c, tt, sem)
        grad(
            nil,
            c,
            0,
            H,
            __arrL({"#2a2e46", "#262a40", "#1e2236"}, 3)
        )
        do
            local y = 0
            while y < 420 do
                P(
                    nil,
                    c,
                    0,
                    y,
                    W,
                    2,
                    "#2e3250"
                )
                y = y + 22
            end
        end
        P(
            nil,
            c,
            610,
            70,
            270,
            220,
            "#5a4a3a"
        )
        P(
            nil,
            c,
            620,
            80,
            250,
            200,
            "#0e1a34"
        )
        do
            local i = 0
            while i < 40 do
                P(
                    nil,
                    c,
                    624 + hash(nil, i) * 240,
                    80 + hash(nil, i + 2) * 70,
                    2,
                    2,
                    "#c8d0ff"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 9 do
                local bx = 620 + i * 28
                local bh = 40 + hash(nil, i + 7) * 70
                P(
                    nil,
                    c,
                    bx,
                    280 - bh,
                    24,
                    bh,
                    "#18223a"
                )
                do
                    local j = 0
                    while j < bh / 12 do
                        if hash(nil, i * 9 + j) > 0.45 then
                            P(
                                nil,
                                c,
                                bx + 6 + __mod(j, 2) * 8,
                                284 - bh + j * 12,
                                4,
                                4,
                                "#ffd27a"
                            )
                        end
                        j = j + 1
                    end
                end
                i = i + 1
            end
        end
        c:save()
        c:beginPath()
        c:rect(620, 80, 250, 200)
        c:clip()
        do
            local k = 0
            while k < 3 do
                c.globalAlpha = 0.22
                circ(
                    nil,
                    c,
                    620 + __mod(tt * 12 + k * 110, 330) - 40,
                    250 - k * 30,
                    90,
                    "#c8d0e0",
                    16
                )
                c.globalAlpha = 1
                k = k + 1
            end
        end
        c:restore()
        P(
            nil,
            c,
            744,
            80,
            4,
            200,
            "#5a4a3a"
        )
        P(
            nil,
            c,
            620,
            178,
            250,
            4,
            "#5a4a3a"
        )
        circ(
            nil,
            c,
            830,
            112,
            14,
            "#e8ecf8"
        )
        P(
            nil,
            c,
            410,
            170,
            140,
            220,
            "#8a6a4a"
        )
        P(
            nil,
            c,
            418,
            178,
            124,
            204,
            "#5a6a8a"
        )
        P(
            nil,
            c,
            426,
            186,
            34,
            140,
            "#7a8aaa"
        )
        do
            local fx0 = 484
            local fy0 = 196
            P(
                nil,
                c,
                fx0,
                fy0,
                48,
                56,
                "#f2ece0"
            )
            P(
                nil,
                c,
                fx0 + 4,
                fy0 + 4,
                40,
                36,
                "#9ad0f0"
            )
            P(
                nil,
                c,
                fx0 + 4,
                fy0 + 30,
                40,
                10,
                "#6aa850"
            )
            local function kid(____, x, pele, cab, roupa, chapeu)
                P(
                    nil,
                    c,
                    x,
                    fy0 + 16,
                    8,
                    8,
                    pele
                )
                P(
                    nil,
                    c,
                    x,
                    fy0 + 14,
                    8,
                    4,
                    cab
                )
                if __t(chapeu) then
                    P(
                        nil,
                        c,
                        x - 2,
                        fy0 + 12,
                        12,
                        2,
                        "#d8b04a"
                    )
                    P(
                        nil,
                        c,
                        x,
                        fy0 + 8,
                        8,
                        4,
                        "#d8b04a"
                    )
                end
                P(
                    nil,
                    c,
                    x + 4,
                    fy0 + 18,
                    2,
                    2,
                    "#1c1c1c"
                )
                P(
                    nil,
                    c,
                    x,
                    fy0 + 24,
                    8,
                    10,
                    roupa
                )
                P(
                    nil,
                    c,
                    x - 2,
                    fy0 + 26,
                    2,
                    6,
                    pele
                )
                P(
                    nil,
                    c,
                    x + 8,
                    fy0 + 26,
                    2,
                    6,
                    pele
                )
            end
            kid(
                nil,
                fx0 + 8,
                "#c68a5e",
                "#3a2414",
                "#e8c24c",
                true
            )
            kid(
                nil,
                fx0 + 20,
                "#7a4a2e",
                "#1c1c1c",
                "#c43c3a",
                false
            )
            kid(
                nil,
                fx0 + 32,
                "#e2b48a",
                "#5a3a20",
                "#3c6aa8",
                false
            )
            P(
                nil,
                c,
                fx0 + 31,
                fy0 + 12,
                10,
                4,
                "#5a3a20"
            )
            txt(
                nil,
                c,
                "TRIO",
                fx0 + 24,
                fy0 + 44,
                "#7a4a2a"
            )
            P(
                nil,
                c,
                fx0 + 20,
                fy0 - 4,
                8,
                8,
                "#c43c3a"
            )
            P(
                nil,
                c,
                fx0 + 22,
                fy0 - 2,
                2,
                2,
                "#ff8a7a"
            )
        end
        P(
            nil,
            c,
            250,
            90,
            110,
            140,
            "#3c6aa8"
        )
        P(
            nil,
            c,
            258,
            98,
            94,
            124,
            "#e8433a"
        )
        txt(
            nil,
            c,
            "SKATE",
            305,
            150,
            "#ffe39a",
            {s = 2}
        )
        P(
            nil,
            c,
            40,
            330,
            330,
            110,
            "#3a3020"
        )
        P(
            nil,
            c,
            46,
            320,
            320,
            50,
            "#2c5a9e"
        )
        P(
            nil,
            c,
            46,
            320,
            320,
            6,
            "#5a8ad0"
        )
        P(
            nil,
            c,
            52,
            300,
            80,
            30,
            "#e8ecf0"
        )
        P(
            nil,
            c,
            560,
            330,
            200,
            14,
            "#6a4a2e"
        )
        P(
            nil,
            c,
            570,
            344,
            10,
            96,
            "#5a3a20"
        )
        P(
            nil,
            c,
            740,
            344,
            10,
            96,
            "#5a3a20"
        )
        P(
            nil,
            c,
            600,
            266,
            110,
            64,
            "#1c1c24"
        )
        P(
            nil,
            c,
            606,
            272,
            98,
            50,
            "#2a4a8a"
        )
        if not __t(sem) then
            txt(
                nil,
                c,
                "FRED: KKKKK",
                655,
                282,
                "#9adcff"
            )
            txt(
                nil,
                c,
                "FRED: BORA LAN?",
                655,
                296,
                "#9adcff"
            )
        end
        P(
            nil,
            c,
            790,
            250,
            8,
            80,
            "#8a8a8a"
        )
        P(
            nil,
            c,
            770,
            230,
            48,
            24,
            "#e8c87a"
        )
        c:save()
        c.globalCompositeOperation = "lighter"
        local g = c:createRadialGradient(
            794,
            250,
            10,
            794,
            250,
            220
        )
        g:addColorStop(0, "rgba(255,200,120,.28)")
        g:addColorStop(1, "rgba(255,200,120,0)")
        c.fillStyle = g
        c:fillRect(560, 40, 400, 420)
        c:restore()
        P(
            nil,
            c,
            0,
            440,
            W,
            100,
            "#2a2420"
        )
        do
            local x = 0
            while x < W do
                P(
                    nil,
                    c,
                    x,
                    440,
                    2,
                    100,
                    "#201a16"
                )
                x = x + 48
            end
        end
    end
    local fundos = __ord(
        {
            celular = function(self, c, ____bindingPattern0)
                local p
                local tt
                local t
                t = ____bindingPattern0.t
                tt = ____bindingPattern0.tt
                p = ____bindingPattern0.p
                local ____t_result_41
                if __t(p.lado) then
                    ____t_result_41 = p.lado
                else
                    ____t_result_41 = "daroca"
                end
                local lado = ____t_result_41
                local ____t_result_42
                if __t(p.pele) then
                    ____t_result_42 = p.pele
                else
                    ____t_result_42 = __get(SKIN, lado == "jorge" and "jorge" or "daroca")
                end
                local pele = ____t_result_42
                if p.fundo == "quarto" then
                    quartoJorge(nil, c, tt, true)
                    c.fillStyle = "rgba(8,10,24,.55)"
                    c:fillRect(0, 0, W, H)
                else
                    ceuRoca(nil, c, tt)
                end
                local ____temp_43
                if p.aperta ~= nil then
                    ____temp_43 = __TS__Number(p.aperta)
                else
                    ____temp_43 = nil
                end
                local aperta = ____temp_43
                local apertou = aperta ~= nil and __ge(t, aperta)
                local ____t_result_44
                if __t(p.estado) then
                    ____t_result_44 = p.estado
                else
                    ____t_result_44 = "chamando"
                end
                local estado = ____t_result_44
                if __t(apertou) then
                    estado = "recusada"
                end
                local vib = estado == "chamando" and __mod(tt, 1.2) < 0.7
                local ____t_result_45
                if __t(vib) then
                    ____t_result_45 = math.floor(math.sin(tt * 90) * 3 + 0.5)
                else
                    ____t_result_45 = 0
                end
                local dx = ____t_result_45
                local X = 480 + dx
                local Y = 52
                if __t(vib) then
                    do
                        local k = 0
                        while k < 3 do
                            P(
                                nil,
                                c,
                                X - 150 - k * 14,
                                Y + 120 + k * 30,
                                4,
                                40 - k * 6,
                                "#ffffffaa"
                            )
                            P(
                                nil,
                                c,
                                X + 146 + k * 14,
                                Y + 120 + k * 30,
                                4,
                                40 - k * 6,
                                "#ffffffaa"
                            )
                            k = k + 1
                        end
                    end
                end
                if __t(vib) then
                    txt(
                        nil,
                        c,
                        "BZZ",
                        X + 190,
                        Y + 80,
                        "#fff6c0",
                        {s = 3, sombra = "#1c1408"}
                    )
                end
                P(
                    nil,
                    c,
                    X - 124,
                    Y,
                    248,
                    436,
                    "#14161c"
                )
                P(
                    nil,
                    c,
                    X - 120,
                    Y + 4,
                    240,
                    428,
                    "#2a2e38"
                )
                P(
                    nil,
                    c,
                    X - 112,
                    Y + 18,
                    224,
                    392,
                    "#0a0c12"
                )
                P(
                    nil,
                    c,
                    X - 20,
                    Y + 8,
                    40,
                    4,
                    "#0a0c12"
                )
                local sx = X - 108
                local sy = Y + 22
                local sw = 216
                local sh = 384
                local ____temp_47
                if estado == "recusada" then
                    ____temp_47 = __arrL({"#3a1418", "#1a0a0e"}, 2)
                else
                    local ____temp_46
                    if estado == "video" then
                        ____temp_46 = __arrL({"#1a2a3a", "#0a1420"}, 2)
                    else
                        ____temp_46 = __arrL({"#3a2a5a", "#141a30"}, 2)
                    end
                    ____temp_47 = ____temp_46
                end
                local bg = ____temp_47
                do
                    local y = 0
                    while y < sh do
                        local ____c_49 = c
                        local ____temp_48
                        if y / sh + hash(nil, y) * 0.08 > 0.5 then
                            ____temp_48 = __get(bg, 1)
                        else
                            ____temp_48 = __get(bg, 0)
                        end
                        ____c_49.fillStyle = ____temp_48
                        c:fillRect(sx, sy + y, sw, 2)
                        y = y + 2
                    end
                end
                local ____c_51 = c
                local ____t_result_50
                if __t(p.hora) then
                    ____t_result_50 = p.hora
                else
                    ____t_result_50 = "23:47"
                end
                txt(
                    nil,
                    ____c_51,
                    ____t_result_50,
                    sx + 12,
                    sy + 8,
                    "#e8ecf8",
                    {align = "left"}
                )
                do
                    local k = 0
                    while k < 4 do
                        P(
                            nil,
                            c,
                            sx + sw - 44 + k * 6,
                            sy + 16 - k * 3,
                            4,
                            4 + k * 3,
                            "#e8ecf8"
                        )
                        k = k + 1
                    end
                end
                P(
                    nil,
                    c,
                    sx + sw - 18,
                    sy + 8,
                    12,
                    8,
                    "#7ae07a"
                )
                if estado == "video" then
                    c.imageSmoothingEnabled = false
                    local ____c_53 = c
                    local ____c_drawImage_54 = c.drawImage
                    local ____t_result_52
                    if __t(p.foto) then
                        ____t_result_52 = p.foto
                    else
                        ____t_result_52 = "reeis"
                    end
                    ____c_drawImage_54(
                        ____c_53,
                        retrato(nil, ____t_result_52, p.emocao),
                        0,
                        0,
                        64,
                        64,
                        sx + 4,
                        sy + 30,
                        sw - 8,
                        sw - 8
                    )
                    P(
                        nil,
                        c,
                        sx + sw - 64,
                        sy + sh - 132,
                        56,
                        72,
                        "#2a2e38"
                    )
                    local ____c_56 = c
                    local ____c_drawImage_57 = c.drawImage
                    local ____t_result_55
                    if __t(p.eu) then
                        ____t_result_55 = p.eu
                    else
                        ____t_result_55 = "daroca"
                    end
                    ____c_drawImage_57(
                        ____c_56,
                        retrato(nil, ____t_result_55),
                        0,
                        0,
                        64,
                        64,
                        sx + sw - 62,
                        sy + sh - 128,
                        52,
                        52
                    )
                    local ____c_59 = c
                    local ____t_result_58
                    if __t(p.quem) then
                        ____t_result_58 = p.quem
                    else
                        ____t_result_58 = "REEIS"
                    end
                    txt(
                        nil,
                        ____c_59,
                        ____t_result_58,
                        X,
                        sy + sw + 36,
                        "#ffffff",
                        {s = 3, sombra = "#000"}
                    )
                    txt(
                        nil,
                        c,
                        __add(
                            __add(
                                __add(
                                    "VIDEOCHAMADA · ",
                                    __call(
                                        tostring(math.floor(t / 60)),
                                        "padStart",
                                        2,
                                        "0"
                                    )
                                ),
                                ":"
                            ),
                            __call(
                                tostring(math.floor(__mod(t, 60))),
                                "padStart",
                                2,
                                "0"
                            )
                        ),
                        X,
                        sy + sw + 64,
                        "#9adcff",
                        {s = 1}
                    )
                else
                    local cy = sy + 130
                    local r = 54
                    do
                        local k = 0
                        while true do
                            local ____t_63 = __t
                            local ____t_result_62
                            local ____t_61 = __t
                            local ____temp_60 = k < 3
                            __O[813] = ____temp_60
                            if ____t_61(____temp_60) then
                                ____t_result_62 = estado == "chamando" or estado == "ligando"
                            else
                                ____t_result_62 = __O[813]
                            end
                            if not ____t_63(____t_result_62) then
                                break
                            end
                            local q = __mod(tt * 0.8 + k / 3, 1)
                            c.globalAlpha = (1 - q) * 0.5
                            c.strokeStyle = "#c8b0ff"
                            c.lineWidth = 2
                            c:beginPath()
                            c:arc(
                                X,
                                cy,
                                r + q * 50,
                                0,
                                TAU
                            )
                            c:stroke()
                            k = k + 1
                        end
                    end
                    c.globalAlpha = 1
                    c:save()
                    c:beginPath()
                    c:arc(
                        X,
                        cy,
                        r,
                        0,
                        TAU
                    )
                    c:clip()
                    c.imageSmoothingEnabled = false
                    local ____c_65 = c
                    local ____c_drawImage_66 = c.drawImage
                    local ____t_result_64
                    if __t(p.foto) then
                        ____t_result_64 = p.foto
                    else
                        ____t_result_64 = "jorge_gordo"
                    end
                    ____c_drawImage_66(
                        ____c_65,
                        retrato(nil, ____t_result_64, p.emocao),
                        X - r,
                        cy - r,
                        r * 2,
                        r * 2
                    )
                    if estado == "recusada" then
                        c.fillStyle = "rgba(20,0,0,.5)"
                        c:fillRect(X - r, cy - r, r * 2, r * 2)
                    end
                    c:restore()
                    c.strokeStyle = "#e8ecf8"
                    c.lineWidth = 3
                    c:beginPath()
                    c:arc(
                        X,
                        cy,
                        r,
                        0,
                        TAU
                    )
                    c:stroke()
                    local ____c_68 = c
                    local ____t_result_67
                    if __t(p.quem) then
                        ____t_result_67 = p.quem
                    else
                        ____t_result_67 = "JORGE"
                    end
                    txt(
                        nil,
                        ____c_68,
                        ____t_result_67,
                        X,
                        cy + 78,
                        "#ffffff",
                        {s = 3, sombra = "#000"}
                    )
                    local dots = __call(
                        ".",
                        "repeat",
                        1 + __mod(
                            math.floor(tt * 2),
                            3
                        )
                    )
                    local ____t_result_71
                    local ____t_70 = __t
                    local ____get_result_69 = __get(
                        {
                            chamando = "CHAMADA DE VOZ",
                            ligando = __add("LIGANDO", dots),
                            recusada = "CHAMADA RECUSADA",
                            perdida = "1 CHAMADA PERDIDA",
                            encerrada = "CHAMADA ENCERRADA"
                        },
                        estado
                    )
                    __O[814] = ____get_result_69
                    if ____t_70(____get_result_69) then
                        ____t_result_71 = __O[814]
                    else
                        ____t_result_71 = ""
                    end
                    local sub = ____t_result_71
                    txt(
                        nil,
                        c,
                        sub,
                        X,
                        cy + 112,
                        estado == "recusada" and "#ff6a5a" or "#c8d0f0",
                        {s = 2}
                    )
                    local ____t_75 = __t
                    local ____t_result_74
                    local ____t_73 = __t
                    local ____temp_72 = estado == "recusada" and aperta ~= nil
                    __O[815] = ____temp_72
                    if ____t_73(____temp_72) then
                        ____t_result_74 = t - aperta < 0.4
                    else
                        ____t_result_74 = __O[815]
                    end
                    if ____t_75(____t_result_74) then
                        c.fillStyle = ("rgba(255,60,40," .. tostring(0.5 - (t - aperta))) .. ")"
                        c:fillRect(sx, sy, sw, sh)
                    end
                    local by = sy + sh - 70
                    local function botao(____, bx, cor, desliga, apertado)
                        circ(
                            nil,
                            c,
                            bx,
                            by + (__t(apertado) and 2 or 0),
                            26,
                            "#0a0c12"
                        )
                        circ(
                            nil,
                            c,
                            bx,
                            by - 2 + (__t(apertado) and 2 or 0),
                            24,
                            __t(apertado) and "#a82a24" or cor
                        )
                        P(
                            nil,
                            c,
                            bx - 14,
                            by - 6 + (__t(apertado) and 2 or 0) + (__t(desliga) and 2 or 0),
                            28,
                            6,
                            "#ffffff"
                        )
                        P(
                            nil,
                            c,
                            bx - 16,
                            by - (__t(desliga) and 2 or 10) + (__t(apertado) and 2 or 0),
                            8,
                            8,
                            "#ffffff"
                        )
                        P(
                            nil,
                            c,
                            bx + 8,
                            by - (__t(desliga) and 2 or 10) + (__t(apertado) and 2 or 0),
                            8,
                            8,
                            "#ffffff"
                        )
                    end
                    if estado == "chamando" then
                        botao(
                            nil,
                            X - 56,
                            "#e8433a",
                            true,
                            apertou
                        )
                        local b = math.abs(math.sin(tt * 5)) * 4
                        c:save()
                        c:translate(0, -b)
                        botao(
                            nil,
                            X + 56,
                            "#3ac25a",
                            false,
                            false
                        )
                        c:restore()
                    elseif estado == "ligando" then
                        botao(
                            nil,
                            X,
                            "#e8433a",
                            true,
                            false
                        )
                    elseif estado == "recusada" then
                        P(
                            nil,
                            c,
                            X - 30,
                            by - 30,
                            60,
                            60,
                            "#5a1418"
                        )
                        txt(
                            nil,
                            c,
                            "X",
                            X,
                            by - 22,
                            "#ff6a5a",
                            {s = 6}
                        )
                    end
                end
                local function sh2(____, col, k)
                    local n = __TS__ParseInt(
                        __call(col, "slice", 1),
                        16
                    )
                    local function f(____, v)
                        return math.max(
                            0,
                            math.min(
                                255,
                                math.floor(v * k + 0.5)
                            )
                        )
                    end
                    return __add(
                        "#",
                        __call(
                            __call(
                                __arrL(
                                    {
                                        __band(
                                            __shr(n, 16),
                                            255
                                        ),
                                        __band(
                                            __shr(n, 8),
                                            255
                                        ),
                                        __band(n, 255)
                                    },
                                    3
                                ),
                                "map",
                                function(____, v) return __call(
                                    __call(
                                        f(nil, v),
                                        "toString",
                                        16
                                    ),
                                    "padStart",
                                    2,
                                    "0"
                                ) end
                            ),
                            "join",
                            ""
                        )
                    )
                end
                local function rr(____, x, y, w, h, r, col)
                    c.fillStyle = col
                    c:beginPath()
                    if __t(c.roundRect) then
                        c:roundRect(
                            math.floor(x + 0.5),
                            math.floor(y + 0.5),
                            w,
                            h,
                            r
                        )
                    else
                        c:rect(
                            math.floor(x + 0.5),
                            math.floor(y + 0.5),
                            w,
                            h
                        )
                    end
                    __call(c, "fill")
                end
                local ____t_result_76
                if __t(p.manga) then
                    ____t_result_76 = p.manga
                else
                    ____t_result_76 = lado == "jorge" and "#7a5a3a" or "#c8a24a"
                end
                local manga = ____t_result_76
                do
                    local k = 0
                    while k < 4 do
                        local fy = Y + 150 + k * 44
                        local fw = 40 - math.abs(k - 1.4) * 4
                        rr(
                            nil,
                            X - 138 - fw / 3,
                            fy - 2,
                            fw + 4,
                            34,
                            14,
                            sh2(nil, pele, 0.62)
                        )
                        rr(
                            nil,
                            X - 136 - fw / 3,
                            fy,
                            fw,
                            30,
                            12,
                            pele
                        )
                        rr(
                            nil,
                            X - 132 - fw / 3,
                            fy + 4,
                            fw * 0.5,
                            8,
                            4,
                            sh2(nil, pele, 1.12)
                        )
                        rr(
                            nil,
                            X - 112,
                            fy + 6,
                            10,
                            18,
                            5,
                            sh2(nil, pele, 1.22)
                        )
                        k = k + 1
                    end
                end
                rr(
                    nil,
                    X - 170,
                    Y + 360,
                    340,
                    200,
                    70,
                    sh2(nil, pele, 0.62)
                )
                rr(
                    nil,
                    X - 166,
                    Y + 364,
                    332,
                    196,
                    66,
                    pele
                )
                rr(
                    nil,
                    X - 150,
                    Y + 380,
                    120,
                    16,
                    8,
                    sh2(nil, pele, 1.1)
                )
                rr(
                    nil,
                    X - 60,
                    Y + 420,
                    120,
                    6,
                    3,
                    sh2(nil, pele, 0.85)
                )
                rr(
                    nil,
                    X - 190,
                    Y + 470,
                    380,
                    120,
                    30,
                    sh2(nil, manga, 0.7)
                )
                rr(
                    nil,
                    X - 186,
                    Y + 474,
                    372,
                    116,
                    28,
                    manga
                )
                do
                    local k = 0
                    while k < 6 do
                        P(
                            nil,
                            c,
                            X - 170 + k * 62,
                            Y + 480,
                            30,
                            4,
                            sh2(nil, manga, 1.15)
                        )
                        k = k + 1
                    end
                end
                local tx = X + 112
                local ty = Y + 260
                if aperta ~= nil then
                    local k = ease(nil, (t - (aperta - 0.7)) / 0.7)
                    tx = lerp(nil, X + 112, X - 56, k)
                    ty = lerp(nil, Y + 260, Y + 22 + sh - 74, k)
                end
                rr(
                    nil,
                    tx - 18,
                    ty - 2,
                    42,
                    84,
                    18,
                    sh2(nil, pele, 0.62)
                )
                rr(
                    nil,
                    tx - 16,
                    ty,
                    38,
                    80,
                    16,
                    pele
                )
                rr(
                    nil,
                    tx - 10,
                    ty + 4,
                    22,
                    16,
                    8,
                    sh2(nil, pele, 1.2)
                )
                rr(
                    nil,
                    tx - 6,
                    ty + 6,
                    14,
                    10,
                    5,
                    "#f2d8c8"
                )
            end,
            aviao_janela = function(self, c, ____bindingPattern0)
                local p
                local tt
                tt = ____bindingPattern0.tt
                p = ____bindingPattern0.p
                local ____t_result_77
                if __t(p.fase) then
                    ____t_result_77 = p.fase
                else
                    ____t_result_77 = "voo"
                end
                local fase = ____t_result_77
                P(
                    nil,
                    c,
                    0,
                    0,
                    W,
                    H,
                    "#d8d2c4"
                )
                do
                    local x = 0
                    while x < W do
                        P(
                            nil,
                            c,
                            x,
                            0,
                            2,
                            H,
                            "#c4bdae"
                        )
                        x = x + 120
                    end
                end
                P(
                    nil,
                    c,
                    0,
                    470,
                    W,
                    70,
                    "#5a6a8a"
                )
                P(
                    nil,
                    c,
                    0,
                    470,
                    W,
                    4,
                    "#7a8aaa"
                )
                local wx = 300
                local wy = 70
                local ww = 360
                local wh = 300
                c:save()
                c:beginPath()
                local ____t_result_78
                if __t(c.roundRect) then
                    ____t_result_78 = c:roundRect(
                        wx,
                        wy,
                        ww,
                        wh,
                        90
                    )
                else
                    ____t_result_78 = c:rect(wx, wy, ww, wh)
                end
                c:clip()
                if fase == "voo" then
                    grad(
                        nil,
                        c,
                        wy,
                        wy + wh,
                        __arrL({"#3a7ad0", "#6aa8e8", "#a8d4f6", "#e8f4ff"}, 4)
                    )
                    circ(
                        nil,
                        c,
                        wx + 270,
                        wy + 70,
                        26,
                        "#fff6c0"
                    )
                    c.globalAlpha = 0.25
                    circ(
                        nil,
                        c,
                        wx + 270,
                        wy + 70,
                        60,
                        "#fff6c0"
                    )
                    c.globalAlpha = 1
                    do
                        local i = 0
                        while i < 18 do
                            local x = wx + __mod(
                                __mod(
                                    i * 61 - tt * (60 + __mod(i, 3) * 30),
                                    ww + 200
                                ) + ww + 200,
                                ww + 200
                            ) - 100
                            local y = wy + 190 + __mod(i, 4) * 26
                            circ(
                                nil,
                                c,
                                x,
                                y,
                                50 + __mod(i, 3) * 14,
                                __t(__mod(i, 2)) and "#ffffff" or "#eef4fa",
                                14
                            )
                            i = i + 1
                        end
                    end
                else
                    local decol = fase == "decolagem"
                    local ____t_result_79
                    if __t(decol) then
                        ____t_result_79 = tt * 26
                    else
                        ____t_result_79 = __TS__Number(-tt) * 10
                    end
                    local off = ____t_result_79
                    local ____t_result_80
                    if __t(decol) then
                        ____t_result_80 = 90 + math.min(70, tt * 8)
                    else
                        ____t_result_80 = 120
                    end
                    local hz = wy + ____t_result_80
                    local ____c_82 = c
                    local ____t_result_81
                    if __t(decol) then
                        ____t_result_81 = __arrL({"#5a9ae0", "#9ac8f0", "#d8ecfa"}, 3)
                    else
                        ____t_result_81 = __arrL({"#8aa4c0", "#b8c8d8", "#dfe6ee"}, 3)
                    end
                    grad(
                        nil,
                        ____c_82,
                        wy,
                        hz,
                        ____t_result_81
                    )
                    local ____c_84 = c
                    local ____temp_85 = wy + wh
                    local ____t_result_83
                    if __t(decol) then
                        ____t_result_83 = __arrL({"#7aa860", "#5a9048", "#4a7a3c"}, 3)
                    else
                        ____t_result_83 = __arrL({"#9aa080", "#8a9070", "#7a8060"}, 3)
                    end
                    grad(
                        nil,
                        ____c_84,
                        hz,
                        ____temp_85,
                        ____t_result_83
                    )
                    do
                        local i = 0
                        while i < 40 do
                            local x = wx + __mod(
                                hash(nil, i) * 600 + off * (1 + hash(nil, i + 1)),
                                600
                            ) - 100
                            local y = hz + 6 + hash(nil, i + 2) * (wy + wh - hz - 10)
                            if __t(decol) then
                                if __t(__mod(i, 3)) then
                                    circ(
                                        nil,
                                        c,
                                        x,
                                        y,
                                        6,
                                        "#2f6a2a",
                                        4
                                    )
                                else
                                    P(
                                        nil,
                                        c,
                                        x,
                                        y,
                                        16,
                                        10,
                                        "#e8e0d0"
                                    )
                                    P(
                                        nil,
                                        c,
                                        x,
                                        y - 4,
                                        16,
                                        4,
                                        "#c8543a"
                                    )
                                end
                            else
                                P(
                                    nil,
                                    c,
                                    x,
                                    y,
                                    14 + __mod(i, 3) * 6,
                                    18,
                                    __t(__mod(i, 4)) and "#e8e4dc" or "#d8d0c0"
                                )
                                P(
                                    nil,
                                    c,
                                    x + 3,
                                    y + 4,
                                    3,
                                    3,
                                    "#5a6a8a"
                                )
                            end
                            i = i + 1
                        end
                    end
                    if __t(decol) then
                        c.strokeStyle = "#4a92e2"
                        c.lineWidth = 6
                        c:beginPath()
                        c:moveTo(
                            wx - 20,
                            hz + 120 + __mod(off, 40)
                        )
                        c:quadraticCurveTo(wx + 180, hz + 40, wx + ww + 20, hz + 90)
                        c:stroke()
                    else
                        c.globalAlpha = 0.45
                        do
                            local k = 0
                            while k < 4 do
                                circ(
                                    nil,
                                    c,
                                    wx + __mod(tt * 18 + k * 120, 520) - 80,
                                    hz + 20 + k * 30,
                                    90,
                                    "#f4f8fa",
                                    14
                                )
                                k = k + 1
                            end
                        end
                        c.globalAlpha = 1
                        P(
                            nil,
                            c,
                            wx + 60,
                            hz - 30,
                            2,
                            30,
                            "#8a8478"
                        )
                        P(
                            nil,
                            c,
                            wx + 54,
                            hz - 24,
                            14,
                            2,
                            "#8a8478"
                        )
                    end
                end
                do
                    local i = 0
                    while i < 5 do
                        local x = wx + ww - __mod(tt * 300 + i * 160, ww + 200)
                        local y = wy + 40 + i * 50
                        c.globalAlpha = 0.5
                        P(
                            nil,
                            c,
                            x,
                            y,
                            80,
                            4,
                            "#ffffff"
                        )
                        c.globalAlpha = 1
                        i = i + 1
                    end
                end
                c.fillStyle = "#b8bcc4"
                c:beginPath()
                c:moveTo(wx - 10, wy + wh - 40)
                c:lineTo(wx + 230, wy + wh - 96)
                c:lineTo(wx + 250, wy + wh - 84)
                c:lineTo(wx - 10, wy + wh + 10)
                __call(c, "fill")
                P(
                    nil,
                    c,
                    wx + 220,
                    wy + wh - 98,
                    6,
                    8,
                    fase == "voo" and "#e8433a" or (__t(__mod(
                        math.floor(tt * 2),
                        2
                    )) and "#e8433a" or "#5a1a1a")
                )
                c:restore()
                c.lineWidth = 14
                c.strokeStyle = "#ece6d8"
                c:beginPath()
                local ____t_result_86
                if __t(c.roundRect) then
                    ____t_result_86 = c:roundRect(
                        wx - 6,
                        wy - 6,
                        ww + 12,
                        wh + 12,
                        96
                    )
                else
                    ____t_result_86 = c:rect(wx - 6, wy - 6, ww + 12, wh + 12)
                end
                c:stroke()
                c.lineWidth = 4
                c.strokeStyle = "#b8b0a0"
                c:beginPath()
                local ____t_result_87
                if __t(c.roundRect) then
                    ____t_result_87 = c:roundRect(
                        wx - 14,
                        wy - 14,
                        ww + 28,
                        wh + 28,
                        104
                    )
                else
                    ____t_result_87 = c:rect(wx - 14, wy - 14, ww + 28, wh + 28)
                end
                c:stroke()
                P(
                    nil,
                    c,
                    wx + 30,
                    wy - 4,
                    ww - 60,
                    40,
                    "#e8e2d4"
                )
                P(
                    nil,
                    c,
                    wx + ww / 2 - 16,
                    wy + 30,
                    32,
                    6,
                    "#a8a090"
                )
                c.lineWidth = 1
                P(
                    nil,
                    c,
                    0,
                    220,
                    250,
                    330,
                    "#2c4a7a"
                )
                P(
                    nil,
                    c,
                    0,
                    220,
                    250,
                    16,
                    "#3c5a8a"
                )
                do
                    local y = 240
                    while y < H do
                        P(
                            nil,
                            c,
                            0,
                            y,
                            250,
                            2,
                            "#284470"
                        )
                        y = y + 12
                    end
                end
                P(
                    nil,
                    c,
                    210,
                    220,
                    40,
                    320,
                    "#243e66"
                )
                P(
                    nil,
                    c,
                    30,
                    200,
                    160,
                    40,
                    "#e8e2d4"
                )
                P(
                    nil,
                    c,
                    30,
                    200,
                    160,
                    6,
                    "#f6f2e8"
                )
                P(
                    nil,
                    c,
                    120,
                    420,
                    260,
                    16,
                    "#8a8a92"
                )
                P(
                    nil,
                    c,
                    120,
                    436,
                    260,
                    6,
                    "#6a6a72"
                )
                local ____temp_88
                if fase ~= "voo" then
                    ____temp_88 = math.floor(math.sin(tt * 40) * 1 + 0.5)
                else
                    ____temp_88 = 0
                end
                local tr = ____temp_88
                P(
                    nil,
                    c,
                    230 + tr,
                    392,
                    30,
                    28,
                    "#f6f2ea"
                )
                P(
                    nil,
                    c,
                    234 + tr,
                    396,
                    22,
                    6,
                    "#5a3420"
                )
                P(
                    nil,
                    c,
                    260 + tr,
                    400,
                    8,
                    10,
                    "#f6f2ea"
                )
                do
                    local k = 0
                    while k < 3 do
                        local q = __mod(tt * 0.6 + k / 3, 1)
                        c.globalAlpha = (1 - q) * 0.5
                        P(
                            nil,
                            c,
                            240 + k * 6 + math.sin(tt * 3 + k) * 3,
                            386 - q * 30,
                            2,
                            6,
                            "#ffffff"
                        )
                        k = k + 1
                    end
                end
                c.globalAlpha = 1
            end,
            aviao_ceu = function(self, c, ____bindingPattern0)
                local tt
                local t
                t = ____bindingPattern0.t
                tt = ____bindingPattern0.tt
                grad(
                    nil,
                    c,
                    0,
                    H,
                    __arrL({"#4a8ad8", "#7ab4ec", "#b8dcf8", "#e8f4ff"}, 4)
                )
                circ(
                    nil,
                    c,
                    800,
                    90,
                    34,
                    "#fff6c0"
                )
                c.globalAlpha = 0.2
                circ(
                    nil,
                    c,
                    800,
                    90,
                    80,
                    "#fff6c0"
                )
                c.globalAlpha = 1
                do
                    local L = 0
                    while L < 3 do
                        do
                            local i = 0
                            while i < 9 do
                                local sp = 20 + L * 40
                                local x = __mod(
                                    __mod(i * 170 - tt * sp, 1300) + 1300,
                                    1300
                                ) - 170
                                local y = 150 + L * 130 + __mod(i, 3) * 20
                                c.globalAlpha = 0.7 + L * 0.1
                                circ(
                                    nil,
                                    c,
                                    x,
                                    y,
                                    70 + L * 20,
                                    L == 2 and "#ffffff" or "#f0f6fc",
                                    18 + L * 4
                                )
                                circ(
                                    nil,
                                    c,
                                    x + 40,
                                    y - 12,
                                    40 + L * 10,
                                    "#ffffff",
                                    14
                                )
                                i = i + 1
                            end
                        end
                        L = L + 1
                    end
                end
                c.globalAlpha = 1
                local x0 = 60 + t * 60
                local y0 = 270 - t * 10 + math.sin(tt * 2) * 4
                do
                    local k = 1
                    while k < 34 do
                        c.globalAlpha = 0.55 - k * 0.015
                        P(
                            nil,
                            c,
                            x0 - 110 - k * 16,
                            y0 + 10 + k * 2.4,
                            18,
                            6,
                            "#ffffff"
                        )
                        P(
                            nil,
                            c,
                            x0 - 110 - k * 16,
                            y0 + 36 + k * 2.4,
                            18,
                            6,
                            "#ffffff"
                        )
                        k = k + 1
                    end
                end
                c.globalAlpha = 1
                c:save()
                c:translate(x0, y0)
                c:scale(1.8, 1.8)
                local x = 0
                local y = 0
                P(
                    nil,
                    c,
                    x - 70,
                    y,
                    150,
                    26,
                    "#f2f4f6"
                )
                P(
                    nil,
                    c,
                    x - 70,
                    y + 18,
                    150,
                    8,
                    "#c9ced2"
                )
                P(
                    nil,
                    c,
                    x - 70,
                    y + 8,
                    150,
                    4,
                    "#2c5a9e"
                )
                P(
                    nil,
                    c,
                    x + 80,
                    y + 4,
                    14,
                    18,
                    "#f2f4f6"
                )
                P(
                    nil,
                    c,
                    x + 86,
                    y + 6,
                    8,
                    6,
                    "#3a4a5a"
                )
                P(
                    nil,
                    c,
                    x - 82,
                    y - 30,
                    26,
                    34,
                    "#2c5a9e"
                )
                P(
                    nil,
                    c,
                    x - 76,
                    y - 24,
                    12,
                    12,
                    "#e8c24c"
                )
                do
                    local k = 0
                    while k < 9 do
                        P(
                            nil,
                            c,
                            x - 50 + k * 14,
                            y + 4,
                            6,
                            6,
                            "#3a4a5a"
                        )
                        k = k + 1
                    end
                end
                P(
                    nil,
                    c,
                    x - 20,
                    y + 14,
                    70,
                    10,
                    "#d8dce0"
                )
                P(
                    nil,
                    c,
                    x - 30,
                    y + 22,
                    50,
                    8,
                    "#b8bcc4"
                )
                c:restore()
            end,
            sala_aula = function(self, c, ____bindingPattern0)
                local tt
                tt = ____bindingPattern0.tt
                P(
                    nil,
                    c,
                    0,
                    0,
                    W,
                    330,
                    "#efe2c0"
                )
                do
                    local x = 0
                    while x < W do
                        if hash(nil, x) > 0.7 then
                            P(
                                nil,
                                c,
                                x,
                                hash(nil, x + 1) * 320,
                                2,
                                2,
                                "#e4d4ac"
                            )
                        end
                        x = x + 6
                    end
                end
                P(
                    nil,
                    c,
                    0,
                    330,
                    W,
                    110,
                    "#5a8a5a"
                )
                P(
                    nil,
                    c,
                    0,
                    326,
                    W,
                    6,
                    "#3c6a40"
                )
                P(
                    nil,
                    c,
                    0,
                    440,
                    W,
                    100,
                    "#8a5a36"
                )
                do
                    local x = 0
                    while x < W do
                        P(
                            nil,
                            c,
                            x,
                            440,
                            2,
                            100,
                            "#6a4228"
                        )
                        x = x + 64
                    end
                end
                P(
                    nil,
                    c,
                    240,
                    80,
                    480,
                    190,
                    "#7a4a2a"
                )
                P(
                    nil,
                    c,
                    250,
                    90,
                    460,
                    170,
                    "#2a4a36"
                )
                do
                    local i = 0
                    while i < 30 do
                        P(
                            nil,
                            c,
                            254 + hash(nil, i) * 450,
                            94 + hash(nil, i + 3) * 160,
                            4,
                            2,
                            "#3a5a46"
                        )
                        i = i + 1
                    end
                end
                txt(
                    nil,
                    c,
                    "NAO CONVERSAR!",
                    360,
                    104,
                    "#e8ecef",
                    {s = 2}
                )
                txt(
                    nil,
                    c,
                    "6+7 = ?",
                    620,
                    110,
                    "#f2e2a8",
                    {s = 2}
                )
                do
                    local k = 0
                    while k < 3 do
                        local x = 300 + k * 34
                        circ(
                            nil,
                            c,
                            x,
                            170,
                            7,
                            "#e8ecef"
                        )
                        circ(
                            nil,
                            c,
                            x,
                            170,
                            5,
                            "#2a4a36"
                        )
                        P(
                            nil,
                            c,
                            x - 1,
                            178,
                            2,
                            24,
                            "#e8ecef"
                        )
                        P(
                            nil,
                            c,
                            x - 10,
                            186,
                            20,
                            2,
                            "#e8ecef"
                        )
                        P(
                            nil,
                            c,
                            x - 8,
                            202,
                            2,
                            12,
                            "#e8ecef"
                        )
                        P(
                            nil,
                            c,
                            x + 6,
                            202,
                            2,
                            12,
                            "#e8ecef"
                        )
                        k = k + 1
                    end
                end
                txt(
                    nil,
                    c,
                    "TRIO",
                    334,
                    222,
                    "#ffd27a",
                    {s = 2}
                )
                P(
                    nil,
                    c,
                    386,
                    160,
                    4,
                    4,
                    "#e86a8a"
                )
                P(
                    nil,
                    c,
                    394,
                    160,
                    4,
                    4,
                    "#e86a8a"
                )
                P(
                    nil,
                    c,
                    384,
                    164,
                    16,
                    4,
                    "#e86a8a"
                )
                P(
                    nil,
                    c,
                    388,
                    168,
                    8,
                    4,
                    "#e86a8a"
                )
                P(
                    nil,
                    c,
                    250,
                    262,
                    460,
                    8,
                    "#a87a54"
                )
                do
                    local k = 0
                    while k < 4 do
                        P(
                            nil,
                            c,
                            280 + k * 30,
                            258,
                            12,
                            4,
                            __get(
                                __arrL({"#f6f6f0", "#f2c94c", "#e86a8a", "#7ac0d0"}, 4),
                                k
                            )
                        )
                        k = k + 1
                    end
                end
                P(
                    nil,
                    c,
                    40,
                    90,
                    160,
                    200,
                    "#e8e2d0"
                )
                P(
                    nil,
                    c,
                    48,
                    98,
                    144,
                    184,
                    "#8ac8f0"
                )
                circ(
                    nil,
                    c,
                    140,
                    230,
                    40,
                    "#4a9a3a",
                    30
                )
                P(
                    nil,
                    c,
                    116,
                    98,
                    4,
                    184,
                    "#e8e2d0"
                )
                P(
                    nil,
                    c,
                    48,
                    186,
                    144,
                    4,
                    "#e8e2d0"
                )
                c:save()
                c.globalCompositeOperation = "lighter"
                c.fillStyle = "rgba(255,240,190,.08)"
                c:beginPath()
                c:moveTo(48, 98)
                c:lineTo(192, 98)
                c:lineTo(420, 440)
                c:lineTo(180, 440)
                __call(c, "fill")
                c:restore()
                circ(
                    nil,
                    c,
                    820,
                    110,
                    30,
                    "#f6f6f0"
                )
                c.strokeStyle = "#2a2a2a"
                c.lineWidth = 3
                c:beginPath()
                c:moveTo(820, 110)
                c:lineTo(
                    820 + math.cos(tt * 0.5) * 20,
                    110 + math.sin(tt * 0.5) * 20
                )
                c:moveTo(820, 110)
                c:lineTo(832, 102)
                c:stroke()
                c.lineWidth = 1
                P(
                    nil,
                    c,
                    760,
                    360,
                    160,
                    80,
                    "#7a4a2a"
                )
                P(
                    nil,
                    c,
                    760,
                    356,
                    160,
                    8,
                    "#a87a54"
                )
                circ(
                    nil,
                    c,
                    860,
                    346,
                    8,
                    "#c43c3a"
                )
                P(
                    nil,
                    c,
                    859,
                    336,
                    2,
                    4,
                    "#3a2a1a"
                )
                do
                    local k = 0
                    while k < 4 do
                        P(
                            nil,
                            c,
                            60 + k * 170,
                            400,
                            110,
                            10,
                            "#a87a54"
                        )
                        P(
                            nil,
                            c,
                            70 + k * 170,
                            410,
                            6,
                            30,
                            "#6a4228"
                        )
                        P(
                            nil,
                            c,
                            160 + k * 170,
                            410,
                            6,
                            30,
                            "#6a4228"
                        )
                        k = k + 1
                    end
                end
                do
                    local u = __mod(tt * 0.25, 1)
                    local x = 80 + u * 800
                    local y = 200 - math.sin(u * math.pi) * 80
                    c.fillStyle = "#ffffff"
                    c:beginPath()
                    c:moveTo(x + 18, y)
                    c:lineTo(x - 10, y - 8)
                    c:lineTo(x - 4, y)
                    c:lineTo(x - 10, y + 6)
                    __call(c, "fill")
                end
            end,
            rodoviaria = function(self, c, ____bindingPattern0)
                local p
                local tt
                local t
                t = ____bindingPattern0.t
                tt = ____bindingPattern0.tt
                p = ____bindingPattern0.p
                grad(
                    nil,
                    c,
                    0,
                    300,
                    __arrL({"#3a2a5a", "#8a4a6a", "#e8835a", "#f6c06a"}, 4)
                )
                circ(
                    nil,
                    c,
                    220,
                    250,
                    40,
                    "#ffd27a"
                )
                c.globalAlpha = 0.25
                circ(
                    nil,
                    c,
                    220,
                    250,
                    90,
                    "#ffd27a"
                )
                c.globalAlpha = 1
                P(
                    nil,
                    c,
                    0,
                    0,
                    W,
                    60,
                    "#3a3a42"
                )
                P(
                    nil,
                    c,
                    0,
                    56,
                    W,
                    8,
                    "#2a2a30"
                )
                do
                    local x = 40
                    while x < W do
                        P(
                            nil,
                            c,
                            x,
                            64,
                            6,
                            240,
                            "#4a4a52"
                        )
                        P(
                            nil,
                            c,
                            x - 20,
                            62,
                            46,
                            6,
                            "#ffe6a8"
                        )
                        x = x + 160
                    end
                end
                P(
                    nil,
                    c,
                    0,
                    300,
                    W,
                    140,
                    "#6a6a72"
                )
                do
                    local x = 0
                    while x < W do
                        P(
                            nil,
                            c,
                            x,
                            300,
                            20,
                            4,
                            "#e8c24c"
                        )
                        x = x + 40
                    end
                end
                P(
                    nil,
                    c,
                    0,
                    440,
                    W,
                    100,
                    "#5a5a62"
                )
                local ____temp_89
                if p.parte ~= nil then
                    ____temp_89 = __TS__Number(p.parte)
                else
                    ____temp_89 = 99
                end
                local parte = ____temp_89
                local ____gt_result_90
                if __gt(t, parte) then
                    ____gt_result_90 = (t - parte) ^ 2 * 60
                else
                    ____gt_result_90 = 0
                end
                local k = ____gt_result_90
                local bx = 360 - k
                do
                    local i = 0
                    while __t(i < 6 and __gt(t, parte)) do
                        local q = __mod(tt * 1.2 + i / 6, 1)
                        c.globalAlpha = (1 - q) * 0.5
                        circ(
                            nil,
                            c,
                            bx + 520 + q * 60,
                            420 - q * 30,
                            10 + q * 20,
                            "#c8c8c8"
                        )
                        i = i + 1
                    end
                end
                c.globalAlpha = 1
                P(
                    nil,
                    c,
                    bx,
                    210,
                    520,
                    220,
                    "#e8ecef"
                )
                P(
                    nil,
                    c,
                    bx,
                    210,
                    520,
                    10,
                    "#ffffff"
                )
                P(
                    nil,
                    c,
                    bx,
                    330,
                    520,
                    30,
                    "#2c5a9e"
                )
                P(
                    nil,
                    c,
                    bx,
                    360,
                    520,
                    10,
                    "#e8c24c"
                )
                P(
                    nil,
                    c,
                    bx + 4,
                    222,
                    120,
                    26,
                    "#14161c"
                )
                txt(
                    nil,
                    c,
                    "V. DA CONQUISTA",
                    bx + 64,
                    230,
                    "#ff9a3a"
                )
                do
                    local k2 = 0
                    while k2 < 5 do
                        P(
                            nil,
                            c,
                            bx + 140 + k2 * 74,
                            240,
                            64,
                            70,
                            "#1a2a3a"
                        )
                        P(
                            nil,
                            c,
                            bx + 144 + k2 * 74,
                            244,
                            20,
                            30,
                            "#2a4a6a"
                        )
                        k2 = k2 + 1
                    end
                end
                local jx = bx + 140 + 2 * 74
                c.imageSmoothingEnabled = false
                c:save()
                c:beginPath()
                c:rect(jx, 240, 64, 70)
                c:clip()
                local ____c_93 = c
                local ____c_drawImage_94 = c.drawImage
                local ____t_result_91
                if __t(p.quem) then
                    ____t_result_91 = p.quem
                else
                    ____t_result_91 = "pre_jorge"
                end
                local ____t_result_92
                if __t(p.emocao) then
                    ____t_result_92 = p.emocao
                else
                    ____t_result_92 = "sad"
                end
                ____c_drawImage_94(
                    ____c_93,
                    retrato(nil, ____t_result_91, ____t_result_92),
                    0,
                    0,
                    64,
                    64,
                    jx,
                    244,
                    64,
                    64
                )
                c:restore()
                local aceno = math.floor(math.sin(tt * 7) * 6 + 0.5)
                P(
                    nil,
                    c,
                    jx + 48 + aceno,
                    250,
                    12,
                    16,
                    SKIN.jorge
                )
                P(
                    nil,
                    c,
                    jx + 50 + aceno,
                    246,
                    3,
                    6,
                    SKIN.jorge
                )
                P(
                    nil,
                    c,
                    jx + 54 + aceno,
                    245,
                    3,
                    6,
                    SKIN.jorge
                )
                for ____, wx in __iterar((__arrL({bx + 90, bx + 430}, 2))) do
                    circ(
                        nil,
                        c,
                        wx,
                        430,
                        30,
                        "#1c1c1c"
                    )
                    circ(
                        nil,
                        c,
                        wx,
                        430,
                        14,
                        "#8a8e94"
                    )
                end
                P(
                    nil,
                    c,
                    bx + 500,
                    300,
                    20,
                    20,
                    "#fff2b0"
                )
            end,
            ceu_noite = function(self, c, ____bindingPattern0)
                local tt
                tt = ____bindingPattern0.tt
                grad(
                    nil,
                    c,
                    0,
                    440,
                    __arrL({"#06081c", "#0e1430", "#1c2048", "#2a2a5a"}, 4)
                )
                do
                    local i = 0
                    while i < 120 do
                        local tw = math.sin(tt * (1 + hash(nil, i) * 2) + i) > -0.2
                        if __t(tw) then
                            P(
                                nil,
                                c,
                                hash(nil, i + 1) * W,
                                hash(nil, i + 2) * 330,
                                2,
                                2,
                                __t(__mod(i, 11)) and "#c8d0ff" or "#ffe6a8"
                            )
                        end
                        i = i + 1
                    end
                end
                circ(
                    nil,
                    c,
                    760,
                    100,
                    36,
                    "#f2eed8"
                )
                circ(
                    nil,
                    c,
                    772,
                    92,
                    30,
                    "#0e1430"
                )
                P(
                    nil,
                    c,
                    744,
                    104,
                    6,
                    6,
                    "#d8d4c0"
                )
                local q = __mod(tt, 7) / 7
                if q < 0.14 then
                    local k = q / 0.14
                    local x = 200 + k * 420
                    local y = 60 + k * 120
                    do
                        local j = 0
                        while j < 10 do
                            c.globalAlpha = (1 - j / 10) * (1 - k)
                            P(
                                nil,
                                c,
                                x - j * 12,
                                y - j * 3.4,
                                4,
                                2,
                                "#ffffff"
                            )
                            j = j + 1
                        end
                    end
                    c.globalAlpha = 1
                end
                c.fillStyle = "#0a0c1c"
                c:beginPath()
                c:moveTo(0, 400)
                do
                    local x = 0
                    while x <= W do
                        c:lineTo(
                            x,
                            392 - math.sin(x / 160) * 34 - math.sin(x / 47) * 8
                        )
                        x = x + 30
                    end
                end
                c:lineTo(W, H)
                c:lineTo(0, H)
                __call(c, "fill")
                P(
                    nil,
                    c,
                    640,
                    330,
                    120,
                    70,
                    "#0c0e1e"
                )
                c.fillStyle = "#0c0e1e"
                c:beginPath()
                c:moveTo(630, 334)
                c:lineTo(700, 290)
                c:lineTo(770, 334)
                __call(c, "fill")
                P(
                    nil,
                    c,
                    676,
                    350,
                    18,
                    16,
                    "#e8b04a"
                )
                P(
                    nil,
                    c,
                    120,
                    300,
                    6,
                    120,
                    "#0c0e1e"
                )
                do
                    local k = 0
                    while k < 4 do
                        local a = tt * 0.6 + k * math.pi / 2
                        c.strokeStyle = "#0c0e1e"
                        c.lineWidth = 4
                        c:beginPath()
                        c:moveTo(123, 300)
                        c:lineTo(
                            123 + math.cos(a) * 40,
                            300 + math.sin(a) * 40
                        )
                        c:stroke()
                        k = k + 1
                    end
                end
                c.lineWidth = 1
                P(
                    nil,
                    c,
                    0,
                    440,
                    W,
                    100,
                    "#0a0c18"
                )
                do
                    local x = 0
                    while x < W do
                        P(
                            nil,
                            c,
                            x,
                            420,
                            4,
                            24,
                            "#14162a"
                        )
                        P(
                            nil,
                            c,
                            x,
                            426,
                            40,
                            3,
                            "#14162a"
                        )
                        x = x + 40
                    end
                end
                do
                    local i = 0
                    while i < 10 do
                        if math.sin(tt * 1.4 + i * 2.1) > 0.3 then
                            local x = hash(nil, i + 50) * W + math.sin(tt * 0.5 + i) * 20
                            local y = 360 + hash(nil, i + 51) * 160
                            P(
                                nil,
                                c,
                                x,
                                y,
                                2,
                                2,
                                "#e8f87a"
                            )
                            c.fillStyle = "rgba(232,248,122,.15)"
                            c:fillRect(x - 4, y - 4, 10, 10)
                        end
                        i = i + 1
                    end
                end
            end,
            quarto_jorge = function(self, c, ____bindingPattern0)
                local tt
                tt = ____bindingPattern0.tt
                quartoJorge(nil, c, tt, false)
            end
        },
        "celular,aviao_janela,aviao_ceu,sala_aula,rodoviaria,ceu_noite,quarto_jorge"
    )
    local CORACAO = __arrL({
        ".XX...XX.",
        "XXXX.XXXX",
        "XXXXXXXXX",
        "XXXXXXXXX",
        ".XXXXXXX.",
        "..XXXXX..",
        "...XXX...",
        "....X...."
    }, 8)
    local function desenhaCoracao(self, c, x, y, s, metade, cor)
        if cor == nil then
            cor = "#e8433a"
        end
        __call(
            CORACAO,
            "forEach",
            function(____, row, j)
                do
                    local i = 0
                    while i < 9 do
                        do
                            if __get(row, i) == "X" then
                                if __t(__lt(metade, 0) and i > 4 - __mod(j, 2)) then
                                    do i = i + 1 continue end
                                end
                                if __t(__gt(metade, 0) and i <= 4 - __mod(j, 2)) then
                                    do i = i + 1 continue end
                                end
                                local ____t_result_99
                                local ____t_98 = __t
                                local ____t_result_97
                                local ____t_96 = __t
                                local ____temp_95 = j == 1
                                __O[816] = ____temp_95
                                if ____t_96(____temp_95) then
                                    ____t_result_97 = i == 1 or i == 2
                                else
                                    ____t_result_97 = __O[816]
                                end
                                __O[817] = ____t_result_97
                                if ____t_98(____t_result_97) then
                                    ____t_result_99 = __O[817]
                                else
                                    ____t_result_99 = j == 2 and i == 1
                                end
                                local hl = ____t_result_99
                                c.fillStyle = __t(hl) and "#ffb0a0" or (j > 4 and "#b02a2a" or cor)
                                c:fillRect(
                                    math.floor(x + (i - 4.5) * s + 0.5),
                                    math.floor(y + (j - 4) * s + 0.5),
                                    math.ceil(s),
                                    math.ceil(s)
                                )
                            end
                        end
                        i = i + 1
                    end
                end
            end
        )
    end
    local iconCache = {}
    local function icone(self, id)
        if __t(__get(iconCache, id)) then
            return __get(iconCache, id)
        end
        local img = __new("Image")
        do
            pcall(function()
                local ____add_111 = __add
                local ____window_109 = window
                local ____window_encodeURIComponent_110 = window.encodeURIComponent
                local ____re_replace_108 = __re_replace
                local ____call_107 = __call
                local ____t_result_106
                local ____t_105 = __t
                local ____opt_102 = window.CampanhaPoderes
                if ____opt_102 ~= nil then
                    ____opt_102 = ____opt_102.iconeSVG
                end
                local ____opt_result_104
                if ____opt_102 ~= nil then
                    ____opt_result_104 = ____opt_102(____opt_102, id, 96)
                end
                __O[818] = ____opt_result_104
                if ____t_105(____opt_result_104) then
                    ____t_result_106 = __O[818]
                else
                    ____t_result_106 = ""
                end
                img.src = ____add_111(
                    "data:image/svg+xml;charset=utf-8,",
                    ____window_encodeURIComponent_110(
                        ____window_109,
                        ____re_replace_108(
                            ____call_107(____t_result_106, "replace", "<svg ", "<svg xmlns=\"http://www.w3.org/2000/svg\" "),
                            __re("currentColor", "g"),
                            "#fff6dc"
                        )
                    )
                )
            end)
        end
        return __set(iconCache, id, img)
    end
    local function desatura(____, c, a)
        if __le(a, 0) then
            return
        end
        c:save()
        c.globalCompositeOperation = "saturation"
        c.globalAlpha = clamp(nil, a, 0, 1)
        c.fillStyle = "#808080"
        c:fillRect(0, 0, W, H)
        c:restore()
    end
    local function polaroid(self, c, x, y, w, h, rot, fn, legenda)
        c:save()
        c:translate(x, y)
        c:rotate(rot)
        c.fillStyle = "rgba(0,0,0,.35)"
        c:fillRect(
            __TS__Number(-w) / 2 + 6,
            __TS__Number(-h) / 2 + 8,
            w,
            h
        )
        c.fillStyle = "#f6f2e8"
        c:fillRect(
            __TS__Number(-w) / 2,
            __TS__Number(-h) / 2,
            w,
            h
        )
        local iw = w - 20
        local ih = h - 54
        c:save()
        c:beginPath()
        c:rect(
            -iw / 2,
            __TS__Number(-h) / 2 + 10,
            iw,
            ih
        )
        c:clip()
        c:translate(
            -iw / 2,
            __TS__Number(-h) / 2 + 10
        )
        fn(nil, c, iw, ih)
        c:restore()
        c.fillStyle = "rgba(255,230,180,.12)"
        c:fillRect(
            -iw / 2,
            __TS__Number(-h) / 2 + 10,
            iw,
            ih
        )
        if __t(legenda) then
            txt(
                nil,
                c,
                legenda,
                0,
                h / 2 - 32,
                "#3a2a1a",
                {s = 1}
            )
        end
        c:restore()
    end
    local function cenaFoto(self, c, iw, ih, quem, ceu, chao, escala)
        if ceu == nil then
            ceu = __arrL({"#8ac8f0", "#c8e8f8"}, 2)
        end
        if chao == nil then
            chao = "#6aa850"
        end
        if escala == nil then
            escala = 1.1
        end
        do
            local y = 0
            while __lt(y, ih) do
                local ____c_114 = c
                local ____temp_113
                if y < ih * 0.62 then
                    local ____temp_112
                    if y / ih > 0.3 then
                        ____temp_112 = __get(ceu, 1)
                    else
                        ____temp_112 = __get(ceu, 0)
                    end
                    ____temp_113 = ____temp_112
                else
                    ____temp_113 = chao
                end
                ____c_114.fillStyle = ____temp_113
                c:fillRect(0, y, iw, 2)
                y = y + 2
            end
        end
        circ(
            nil,
            c,
            iw * 0.8,
            ih * 0.2,
            12,
            "#fff6c0"
        )
        local n = __len(quem)
        __call(
            quem,
            "forEach",
            function(____, q, i) return ator(
                nil,
                c,
                q,
                iw * (i + 1) / (n + 1),
                ih * 0.92,
                {
                    scale = escala,
                    facing = __lt(i, n / 2) and 1 or -1,
                    emotion = "friend",
                    frame = 0
                }
            ) end
        )
    end
    local efeitos = __ord(
        {
            titulo_c2 = function(self, c, e, t, ____bindingPattern0)
                local win
                win = ____bindingPattern0.win
                local ____win_118 = win
                local ____t_result_117
                local ____t_116 = __t
                local ____TS__Number_result_115 = __TS__Number(e.dur)
                __O[819] = ____TS__Number_result_115
                if ____t_116(____TS__Number_result_115) then
                    ____t_result_117 = __O[819]
                else
                    ____t_result_117 = 6
                end
                local f = ____win_118(nil, ____t_result_117)
                if not __t(f.on) then
                    return
                end
                local k = t - f.t0
                local a = math.min(
                    1,
                    k / 0.6,
                    (__add(f.t0, f.d) - t) / 0.6
                )
                c:save()
                c.globalAlpha = a
                grad(
                    nil,
                    c,
                    0,
                    H,
                    __arrL({"#0a1020", "#14203a", "#24345a", "#3a4a6a"}, 4)
                )
                do
                    local i = 0
                    while i < 6 do
                        c.globalAlpha = a * 0.18
                        circ(
                            nil,
                            c,
                            __mod(k * 20 + i * 220, 1300) - 170,
                            300 + __mod(i, 3) * 70,
                            200,
                            "#c8d8e8",
                            40
                        )
                        i = i + 1
                    end
                end
                c.globalAlpha = a
                do
                    local i = 0
                    while i < 60 do
                        local x = __mod(
                            hash(nil, i) * W + math.sin(k + i) * 20,
                            W
                        )
                        local y = __mod(
                            hash(nil, i + 3) * H + k * (20 + hash(nil, i) * 30),
                            H
                        )
                        P(
                            nil,
                            c,
                            x,
                            y,
                            2,
                            2,
                            "#e8f4ff"
                        )
                        i = i + 1
                    end
                end
                local T = "DA ROCA ADVENTURE"
                local s = 5
                local w = larg(nil, T, s)
                local x = W / 2 - w / 2
                do
                    local i = 0
                    while i < __len(T) do
                        local ki = clamp(nil, (k - 0.3 - i * 0.06) / 0.35, 0, 1)
                        local dy = (1 - ease(nil, ki)) * -60
                        if ki > 0 then
                            c.globalAlpha = a * ki
                            txt(
                                nil,
                                c,
                                __get(T, i),
                                x,
                                150 + dy,
                                "#ffe9b0",
                                {s = s, align = "left", sombra = "#2a1c10"}
                            )
                        end
                        x = x + 4 * s
                        i = i + 1
                    end
                end
                c.globalAlpha = a
                local k2 = clamp(nil, (k - 1.6) / 0.5, 0, 1)
                if k2 > 0 then
                    local ww = 280 * ease(nil, k2)
                    P(
                        nil,
                        c,
                        W / 2 - ww / 2,
                        214,
                        ww,
                        30,
                        "#8a2a2a"
                    )
                    P(
                        nil,
                        c,
                        W / 2 - ww / 2,
                        214,
                        ww,
                        4,
                        "#c84a3a"
                    )
                    if k2 >= 1 then
                        txt(
                            nil,
                            c,
                            "CAMPANHA 2",
                            W / 2,
                            222,
                            "#fff6dc",
                            {s = 2}
                        )
                    end
                end
                local k3 = clamp(nil, (k - 2.3) / 0.7, 0, 1)
                if k3 > 0 then
                    c.globalAlpha = a * k3
                    txt(
                        nil,
                        c,
                        "VITORIA DA CONQUISTA",
                        W / 2,
                        290,
                        "#c8e8ff",
                        {s = 4, sombra = "#0a1020"}
                    )
                    do
                        local i = 0
                        while i < 12 do
                            if math.sin(k * 6 + i * 2) > 0.7 then
                                local sx = W / 2 - 230 + hash(nil, i) * 460
                                local sy = 286 + hash(nil, i + 1) * 30
                                P(
                                    nil,
                                    c,
                                    sx,
                                    sy - 4,
                                    2,
                                    10,
                                    "#ffffff"
                                )
                                P(
                                    nil,
                                    c,
                                    sx - 4,
                                    sy,
                                    10,
                                    2,
                                    "#ffffff"
                                )
                            end
                            i = i + 1
                        end
                    end
                end
                local k4 = clamp(nil, (k - 3.2) / 0.6, 0, 1)
                if k4 > 0 then
                    c.globalAlpha = a * k4
                    txt(
                        nil,
                        c,
                        "- A SUICA BAIANA -",
                        W / 2,
                        336,
                        "#9ab4d0",
                        {s = 2}
                    )
                end
                c:restore()
            end,
            coracao_partido = function(self, c, e, t, ____bindingPattern0)
                local win
                win = ____bindingPattern0.win
                local ____win_122 = win
                local ____t_result_121
                local ____t_120 = __t
                local ____TS__Number_result_119 = __TS__Number(e.dur)
                __O[820] = ____TS__Number_result_119
                if ____t_120(____TS__Number_result_119) then
                    ____t_result_121 = __O[820]
                else
                    ____t_result_121 = 3.4
                end
                local f = ____win_122(nil, ____t_result_121)
                if not __t(f.on) then
                    return
                end
                local k = (t - f.t0) / f.d
                local ____t_result_125
                local ____t_124 = __t
                local ____TS__Number_result_123 = __TS__Number(e.x)
                __O[821] = ____TS__Number_result_123
                if ____t_124(____TS__Number_result_123) then
                    ____t_result_125 = __O[821]
                else
                    ____t_result_125 = 480
                end
                local x = ____t_result_125
                local ____t_result_128
                local ____t_127 = __t
                local ____TS__Number_result_126 = __TS__Number(e.y)
                __O[822] = ____TS__Number_result_126
                if ____t_127(____TS__Number_result_126) then
                    ____t_result_128 = __O[822]
                else
                    ____t_result_128 = 250
                end
                local y = ____t_result_128
                local ____t_result_131
                local ____t_130 = __t
                local ____TS__Number_result_129 = __TS__Number(e.escala)
                __O[823] = ____TS__Number_result_129
                if ____t_130(____TS__Number_result_129) then
                    ____t_result_131 = __O[823]
                else
                    ____t_result_131 = 1
                end
                local s = 16 * ____t_result_131
                c.fillStyle = ("rgba(10,4,8," .. tostring(math.min(0.6, k * 3) * (e.fundo == false and 0 or 1))) .. ")"
                c:fillRect(0, 0, W, H)
                local ____temp_132
                if k < 0.3 then
                    ____temp_132 = 1 + math.max(
                        0,
                        math.sin(k / 0.3 * math.pi * 3)
                    ) * 0.12
                else
                    ____temp_132 = 1
                end
                local pulso = ____temp_132
                local ____t_result_133
                if __t(k > 0.42 and k < 0.58) then
                    ____t_result_133 = math.sin(t * 70) * 3
                else
                    ____t_result_133 = 0
                end
                local tre = ____t_result_133
                if k < 0.58 then
                    desenhaCoracao(
                        nil,
                        c,
                        x + tre,
                        y,
                        s * pulso,
                        0
                    )
                    if k > 0.3 then
                        local n = math.floor(clamp(nil, (k - 0.3) / 0.12, 0, 1) * 8)
                        c.fillStyle = "#1a0608"
                        local px = x - s * 0.2
                        local py = y - s * 3
                        do
                            local i = 0
                            while i < n do
                                local ____t_result_134
                                if __t(__mod(i, 2)) then
                                    ____t_result_134 = s * 0.6
                                else
                                    ____t_result_134 = -s * 0.5
                                end
                                local nx = x + ____t_result_134 + tre
                                local ny = py + s * 0.8
                                c:fillRect(
                                    math.min(px, nx),
                                    py,
                                    math.abs(nx - px) + 4,
                                    4
                                )
                                c:fillRect(nx, py, 4, s * 0.8 + 2)
                                px = nx
                                py = ny
                                i = i + 1
                            end
                        end
                    end
                else
                    local q = (k - 0.58) / 0.42
                    local sep = ease(nil, q) * 70
                    local cai = q * q * 220
                    local cor = q > 0.3 and "#a03030" or "#e8433a"
                    c:save()
                    c:translate(x - sep, y + cai)
                    c:rotate(-q * 0.5)
                    desenhaCoracao(
                        nil,
                        c,
                        0,
                        0,
                        s,
                        -1,
                        cor
                    )
                    c:restore()
                    c:save()
                    c:translate(x + sep, y + cai * 0.9)
                    c:rotate(q * 0.5)
                    desenhaCoracao(
                        nil,
                        c,
                        0,
                        0,
                        s,
                        1,
                        cor
                    )
                    c:restore()
                    do
                        local i = 0
                        while i < 16 do
                            local a = hash(nil, i) * TAU
                            local v = 80 + hash(nil, i + 1) * 160
                            P(
                                nil,
                                c,
                                x + math.cos(a) * v * q,
                                y + math.sin(a) * v * q + q * q * 200,
                                6,
                                6,
                                __t(__mod(i, 3)) and "#e8433a" or "#ffb0a0"
                            )
                            i = i + 1
                        end
                    end
                    desatura(nil, c, q * 0.6)
                end
            end,
            batimento = function(self, c, e, t)
                local b = __mod(t * 1.15, 1)
                local ____temp_138
                if b < 0.12 then
                    ____temp_138 = b / 0.12
                else
                    local ____temp_137
                    if b < 0.24 then
                        ____temp_137 = 1 - (b - 0.12) / 0.12
                    else
                        local ____temp_136
                        if b < 0.32 then
                            ____temp_136 = (b - 0.24) / 0.08 * 0.7
                        else
                            local ____temp_135
                            if b < 0.5 then
                                ____temp_135 = 0.7 - (b - 0.32) / 0.18 * 0.7
                            else
                                ____temp_135 = 0
                            end
                            ____temp_136 = ____temp_135
                        end
                        ____temp_137 = ____temp_136
                    end
                    ____temp_138 = ____temp_137
                end
                local pulso = ____temp_138
                local ____t_result_141
                local ____t_140 = __t
                local ____TS__Number_result_139 = __TS__Number(e.forca)
                __O[824] = ____TS__Number_result_139
                if ____t_140(____TS__Number_result_139) then
                    ____t_result_141 = __O[824]
                else
                    ____t_result_141 = 0.5
                end
                local f = ____t_result_141 * (0.4 + pulso * 0.6)
                local g = c:createRadialGradient(
                    W / 2,
                    H / 2,
                    160,
                    W / 2,
                    H / 2,
                    600
                )
                g:addColorStop(0, "rgba(0,0,0,0)")
                g:addColorStop(
                    1,
                    ("rgba(90,0,10," .. tostring(f)) .. ")"
                )
                c.fillStyle = g
                c:fillRect(0, 0, W, H)
            end,
            polaroids = function(self, c, e, t)
                local ____isArray_result_142
                if __isArray(e.fotos) then
                    ____isArray_result_142 = e.fotos
                else
                    ____isArray_result_142 = __arrL({}, 0)
                end
                local fotos = ____isArray_result_142
                local ____t_result_145
                local ____t_144 = __t
                local ____TS__Number_result_143 = __TS__Number(e.t)
                __O[825] = ____TS__Number_result_143
                if ____t_144(____TS__Number_result_143) then
                    ____t_result_145 = __O[825]
                else
                    ____t_result_145 = 0
                end
                local t0 = ____t_result_145
                local ____t_result_148
                local ____t_147 = __t
                local ____TS__Number_result_146 = __TS__Number(e.intervalo)
                __O[826] = ____TS__Number_result_146
                if ____t_147(____TS__Number_result_146) then
                    ____t_result_148 = __O[826]
                else
                    ____t_result_148 = 1.3
                end
                local iv = ____t_result_148
                if __lt(t, t0) then
                    return
                end
                c.fillStyle = ("rgba(20,14,10," .. tostring(math.min(0.72, (t - t0) * 1.5))) .. ")"
                c:fillRect(0, 0, W, H)
                local n = __len(fotos)
                __call(
                    fotos,
                    "forEach",
                    function(____, ft, i)
                        local ti = t0 + i * iv
                        if __lt(t, ti) then
                            return
                        end
                        local k = ease(nil, (t - ti) / 0.55)
                        local ____le_result_149
                        if __le(n, 3) then
                            ____le_result_149 = i
                        else
                            ____le_result_149 = __mod(i, 4)
                        end
                        local col = ____le_result_149
                        local lin = __le(n, 3) and 0 or math.floor(i / 4)
                        local ____le_result_150
                        if __le(n, 3) then
                            ____le_result_150 = n
                        else
                            ____le_result_150 = 4
                        end
                        local porLinha = ____le_result_150
                        local x = W / 2 + (col - (porLinha - 1) / 2) * (__le(n, 3) and 250 or 210) + __mod(lin, 2) * 40
                        local y = (__le(n, 4) and 260 or 170 + lin * 200) - (1 - k) * 400
                        local rot = (hash(nil, i + 4) - 0.5) * 0.3 + (1 - k) * 0.8
                        polaroid(
                            nil,
                            c,
                            x,
                            y,
                            __le(n, 4) and 200 or 170,
                            __le(n, 4) and 230 or 196,
                            rot,
                            function(____, cc, iw, ih)
                                local ____cenaFoto_154 = cenaFoto
                                local ____array_153 = __TS__SparseArrayNew(nil, cc, iw, ih)
                                local ____t_result_151
                                if __t(ft.quem) then
                                    ____t_result_151 = ft.quem
                                else
                                    ____t_result_151 = __arrL({}, 0)
                                end
                                __TS__SparseArrayPush(____array_153, ____t_result_151, ft.ceu, ft.chao)
                                local ____t_result_152
                                if __t(ft.escala) then
                                    ____t_result_152 = ft.escala
                                else
                                    ____t_result_152 = __le(n, 4) and 1 or 0.85
                                end
                                __TS__SparseArrayPush(____array_153, ____t_result_152)
                                return ____cenaFoto_154(__TS__SparseArraySpread(____array_153))
                            end,
                            ft.legenda
                        )
                    end
                )
            end,
            foto_trio = function(self, c, e, t, ____bindingPattern0)
                local win
                win = ____bindingPattern0.win
                local ____win_158 = win
                local ____t_result_157
                local ____t_156 = __t
                local ____TS__Number_result_155 = __TS__Number(e.dur)
                __O[827] = ____TS__Number_result_155
                if ____t_156(____TS__Number_result_155) then
                    ____t_result_157 = __O[827]
                else
                    ____t_result_157 = 5
                end
                local f = ____win_158(nil, ____t_result_157)
                if not __t(f.on) then
                    return
                end
                local k = t - f.t0
                local a = math.min(
                    1,
                    k / 0.5,
                    (__add(f.t0, f.d) - t) / 0.5
                )
                local ____t_result_159
                if __t(e.era) then
                    ____t_result_159 = e.era
                else
                    ____t_result_159 = "crianca"
                end
                local era = ____t_result_159
                local ____temp_161
                if era == "agora" then
                    ____temp_161 = __arrL({"daroca", "reeis", "jorge"}, 3)
                else
                    local ____temp_160
                    if era == "pre" then
                        ____temp_160 = __arrL({"pre_daroca", "pre_reeis", "pre_jorge"}, 3)
                    else
                        ____temp_160 = __arrL({"crianca_daroca", "crianca_reeis", "crianca_jorge"}, 3)
                    end
                    ____temp_161 = ____temp_160
                end
                local quem = ____temp_161
                c:save()
                c.globalAlpha = a
                c.fillStyle = "rgba(16,10,6,.6)"
                c:fillRect(0, 0, W, H)
                local ____polaroid_173 = polaroid
                local ____array_172 = __TS__SparseArrayNew(nil, c)
                local ____t_result_164
                local ____t_163 = __t
                local ____TS__Number_result_162 = __TS__Number(e.x)
                __O[828] = ____TS__Number_result_162
                if ____t_163(____TS__Number_result_162) then
                    ____t_result_164 = __O[828]
                else
                    ____t_result_164 = 480
                end
                __TS__SparseArrayPush(
                    ____array_172,
                    ____t_result_164,
                    260 - (1 - ease(nil, k / 0.6)) * 60,
                    380,
                    400
                )
                local ____t_result_167
                local ____t_166 = __t
                local ____TS__Number_result_165 = __TS__Number(e.giro)
                __O[829] = ____TS__Number_result_165
                if ____t_166(____TS__Number_result_165) then
                    ____t_result_167 = __O[829]
                else
                    ____t_result_167 = -0.05
                end
                __TS__SparseArrayPush(
                    ____array_172,
                    ____t_result_167 + math.sin(k * 0.8) * 0.015,
                    function(____, cc, iw, ih)
                        local ____cenaFoto_170 = cenaFoto
                        local ____array_169 = __TS__SparseArrayNew(
                            nil,
                            cc,
                            iw,
                            ih,
                            quem
                        )
                        local ____temp_168
                        if era == "agora" then
                            ____temp_168 = __arrL({"#f2b06a", "#f8d8a0"}, 2)
                        else
                            ____temp_168 = __arrL({"#8ac8f0", "#c8e8f8"}, 2)
                        end
                        __TS__SparseArrayPush(____array_169, ____temp_168, era == "agora" and "#5a9a4a" or "#6aa850", era == "agora" and 1.35 or 1.6)
                        ____cenaFoto_170(__TS__SparseArraySpread(____array_169))
                        if era == "agora" then
                            do
                                local i = 0
                                while i < 8 do
                                    P(
                                        nil,
                                        cc,
                                        hash(nil, i) * iw,
                                        hash(nil, i + 1) * ih * 0.5,
                                        2,
                                        2,
                                        "#fff6c0"
                                    )
                                    i = i + 1
                                end
                            end
                        end
                    end
                )
                local ____t_result_171
                if __t(e.legenda) then
                    ____t_result_171 = e.legenda
                else
                    ____t_result_171 = era == "agora" and "O TRIO · DE NOVO" or "O TRIO · PRA SEMPRE"
                end
                __TS__SparseArrayPush(____array_172, ____t_result_171)
                ____polaroid_173(__TS__SparseArraySpread(____array_172))
                do
                    local i = 0
                    while i < 10 do
                        if math.sin(k * 5 + i * 1.9) > 0.6 then
                            local x = 300 + hash(nil, i) * 360
                            local y = 80 + hash(nil, i + 2) * 360
                            P(
                                nil,
                                c,
                                x,
                                y - 6,
                                2,
                                14,
                                "#fff3a8"
                            )
                            P(
                                nil,
                                c,
                                x - 6,
                                y,
                                14,
                                2,
                                "#fff3a8"
                            )
                        end
                        i = i + 1
                    end
                end
                c:restore()
            end,
            pensamento = function(self, c, e, t)
                local ____t_result_176
                local ____t_175 = __t
                local ____TS__Number_result_174 = __TS__Number(e.t)
                __O[830] = ____TS__Number_result_174
                if ____t_175(____TS__Number_result_174) then
                    ____t_result_176 = __O[830]
                else
                    ____t_result_176 = 0
                end
                local t0 = ____t_result_176
                local ____t_183 = __t
                local ____lt_result_182 = __lt(t, t0)
                if not ____lt_result_182 then
                    local ____gt_181 = __gt
                    local ____t_180 = t
                    local ____t_result_179
                    local ____t_178 = __t
                    local ____TS__Number_result_177 = __TS__Number(e.dur)
                    __O[831] = ____TS__Number_result_177
                    if ____t_178(____TS__Number_result_177) then
                        ____t_result_179 = __O[831]
                    else
                        ____t_result_179 = 99
                    end
                    ____lt_result_182 = ____gt_181(____t_180, t0 + ____t_result_179)
                end
                if ____t_183(____lt_result_182) then
                    return
                end
                local k = ease(nil, (t - t0) / 0.8)
                local ____t_result_186
                local ____t_185 = __t
                local ____TS__Number_result_184 = __TS__Number(e.x)
                __O[832] = ____TS__Number_result_184
                if ____t_185(____TS__Number_result_184) then
                    ____t_result_186 = __O[832]
                else
                    ____t_result_186 = 520
                end
                local x = ____t_result_186
                local ____t_result_189
                local ____t_188 = __t
                local ____TS__Number_result_187 = __TS__Number(e.y)
                __O[833] = ____TS__Number_result_187
                if ____t_188(____TS__Number_result_187) then
                    ____t_result_189 = __O[833]
                else
                    ____t_result_189 = 300
                end
                local y = ____t_result_189
                do
                    local i = 0
                    while i < 3 do
                        if k > i * 0.2 then
                            circ(
                                nil,
                                c,
                                x + 30 + i * 26,
                                y - 30 - i * 34,
                                6 + i * 4,
                                "#f6f2e8"
                            )
                        end
                        i = i + 1
                    end
                end
                local bx = x + 150
                local by = y - 190
                local bw = 300 * k
                local bh = 160 * k
                if k < 0.3 then
                    return
                end
                c:save()
                c.globalAlpha = math.min(1, k * 1.4)
                do
                    local i = 0
                    while i < 10 do
                        local a = i / 10 * TAU
                        circ(
                            nil,
                            c,
                            bx + math.cos(a) * bw * 0.45,
                            by + math.sin(a) * bh * 0.42,
                            46 * k,
                            "#f6f2e8",
                            34 * k
                        )
                        i = i + 1
                    end
                end
                circ(
                    nil,
                    c,
                    bx,
                    by,
                    bw * 0.46,
                    "#f6f2e8",
                    bh * 0.44
                )
                c:beginPath()
                c:ellipse(
                    bx,
                    by,
                    bw * 0.44,
                    bh * 0.4,
                    0,
                    0,
                    TAU
                )
                c:clip()
                c.fillStyle = "#e8c890"
                c:fillRect(bx - bw / 2, by - bh / 2, bw, bh)
                c.fillStyle = "#c8a468"
                c:fillRect(bx - bw / 2, by + bh * 0.2, bw, bh)
                local ____t_result_190
                if __t(e.quem) then
                    ____t_result_190 = e.quem
                else
                    ____t_result_190 = __arrL({"crianca_daroca", "crianca_reeis", "crianca_jorge"}, 3)
                end
                local quem = ____t_result_190
                __call(
                    quem,
                    "forEach",
                    function(____, q, i) return ator(
                        nil,
                        c,
                        q,
                        bx - 80 + i * 80,
                        by + bh * 0.32,
                        {
                            scale = 1,
                            facing = i == 2 and -1 or 1,
                            frame = t * 2,
                            moving = not not __t(e.andando),
                            emotion = "friend"
                        }
                    ) end
                )
                c.fillStyle = "rgba(160,110,60,.25)"
                c:fillRect(bx - bw / 2, by - bh / 2, bw, bh)
                c:restore()
            end,
            neblina = function(self, c, e, t, ____bindingPattern0)
                local s
                s = ____bindingPattern0.s
                local ____t_result_193
                local ____t_192 = __t
                local ____TS__Number_result_191 = __TS__Number(e.forca)
                __O[834] = ____TS__Number_result_191
                if ____t_192(____TS__Number_result_191) then
                    ____t_result_193 = __O[834]
                else
                    ____t_result_193 = 0.5
                end
                local f = ____t_result_193
                local tt = s.elapsed
                do
                    local i = 0
                    while i < 7 do
                        c.globalAlpha = f * 0.22
                        circ(
                            nil,
                            c,
                            __mod(tt * (8 + i * 3) + i * 190, 1400) - 220,
                            300 + __mod(i, 4) * 60,
                            220,
                            "#e8eef4",
                            34
                        )
                        i = i + 1
                    end
                end
                c.globalAlpha = 1
            end,
            frio = function(self, c)
                c.fillStyle = "rgba(80,130,200,.14)"
                c:fillRect(0, 0, W, H)
                for ____, ____value in __iterar((__arrL(
                    {
                        __arrL({0, 24}, 2),
                        __arrL({W, 24}, 2),
                        __arrL({0, H - 20}, 2),
                        __arrL({W, H - 20}, 2)
                    },
                    4
                ))) do
                    local cx = ____value[1]
                    local cy = ____value[2]
                    do
                        local i = 0
                        while i < 26 do
                            local a = hash(nil, i + cx) * TAU
                            local r = hash(nil, i + cy) * 70
                            P(
                                nil,
                                c,
                                cx + math.cos(a) * r,
                                cy + math.sin(a) * r,
                                2 + __mod(i, 3) * 2,
                                2,
                                "#e8f4ff"
                            )
                            i = i + 1
                        end
                    end
                end
            end,
            estrelas = function(self, c, e, t, ____bindingPattern0)
                local s
                s = ____bindingPattern0.s
                local tt = s.elapsed
                do
                    local i = 0
                    while i < 60 do
                        if math.sin(tt * (1 + hash(nil, i) * 2) + i) > 0 then
                            P(
                                nil,
                                c,
                                hash(nil, i + 7) * W,
                                30 + hash(nil, i + 8) * 180,
                                2,
                                2,
                                "#e8ecff"
                            )
                        end
                        i = i + 1
                    end
                end
            end,
            pb = function(self, c, e, t)
                local ____t_result_196
                local ____t_195 = __t
                local ____TS__Number_result_194 = __TS__Number(e.t)
                __O[835] = ____TS__Number_result_194
                if ____t_195(____TS__Number_result_194) then
                    ____t_result_196 = __O[835]
                else
                    ____t_result_196 = 0
                end
                local t0 = ____t_result_196
                local ____t_result_199
                local ____t_198 = __t
                local ____TS__Number_result_197 = __TS__Number(e.dur)
                __O[836] = ____TS__Number_result_197
                if ____t_198(____TS__Number_result_197) then
                    ____t_result_199 = __O[836]
                else
                    ____t_result_199 = 1.5
                end
                local d = ____t_result_199
                if __lt(t, t0) then
                    return
                end
                local ____c_204 = c
                local ____clamp_result_203 = clamp(nil, (t - t0) / d, 0, 1)
                local ____t_result_202
                local ____t_201 = __t
                local ____TS__Number_result_200 = __TS__Number(e.forca)
                __O[837] = ____TS__Number_result_200
                if ____t_201(____TS__Number_result_200) then
                    ____t_result_202 = __O[837]
                else
                    ____t_result_202 = 1
                end
                desatura(nil, ____c_204, ____clamp_result_203 * ____t_result_202)
            end,
            flashback = function(self, c, e, t, ____bindingPattern0)
                local s
                s = ____bindingPattern0.s
                local tt = s.elapsed
                c.fillStyle = "rgba(170,120,60,.26)"
                c:fillRect(0, 0, W, H)
                desatura(nil, c, 0.35)
                local g = c:createRadialGradient(
                    W / 2,
                    H / 2,
                    180,
                    W / 2,
                    H / 2,
                    600
                )
                g:addColorStop(0, "rgba(0,0,0,0)")
                g:addColorStop(1, "rgba(40,24,10,.6)")
                c.fillStyle = g
                c:fillRect(0, 0, W, H)
                do
                    local i = 0
                    while i < 40 do
                        P(
                            nil,
                            c,
                            hash(
                                nil,
                                i + math.floor(tt * 14)
                            ) * W,
                            hash(
                                nil,
                                i * 3 + math.floor(tt * 14)
                            ) * H,
                            2,
                            2,
                            "rgba(255,240,210,.3)"
                        )
                        i = i + 1
                    end
                end
                if hash(
                    nil,
                    math.floor(tt * 6)
                ) > 0.6 then
                    P(
                        nil,
                        c,
                        hash(
                            nil,
                            math.floor(tt * 6) + 1
                        ) * W,
                        0,
                        2,
                        H,
                        "rgba(255,240,210,.18)"
                    )
                end
                c:save()
                c.globalCompositeOperation = "lighter"
                c.fillStyle = ("rgba(255,150,60," .. tostring(0.06 + 0.05 * math.sin(tt * 0.7))) .. ")"
                c:beginPath()
                c:ellipse(
                    80,
                    80,
                    260,
                    180,
                    0,
                    0,
                    TAU
                )
                __call(c, "fill")
                c:restore()
            end,
            vs = function(self, c, e, t, ____bindingPattern0)
                local win
                win = ____bindingPattern0.win
                local ____win_208 = win
                local ____t_result_207
                local ____t_206 = __t
                local ____TS__Number_result_205 = __TS__Number(e.dur)
                __O[838] = ____TS__Number_result_205
                if ____t_206(____TS__Number_result_205) then
                    ____t_result_207 = __O[838]
                else
                    ____t_result_207 = 3.4
                end
                local f = ____win_208(nil, ____t_result_207)
                if not __t(f.on) then
                    return
                end
                local k = t - f.t0
                local a = math.min(
                    1,
                    (__add(f.t0, f.d) - t) / 0.35
                )
                local ____t_result_209
                if __t(e.cor) then
                    ____t_result_209 = e.cor
                else
                    ____t_result_209 = "#e8433a"
                end
                local cor = ____t_result_209
                c:save()
                c.globalAlpha = a
                c.fillStyle = "#0c0e1a"
                c:fillRect(0, 0, W, H)
                c:save()
                c:beginPath()
                c:moveTo(W / 2 + 60, 0)
                c:lineTo(W, 0)
                c:lineTo(W, H)
                c:lineTo(W / 2 - 60, H)
                c:clip()
                c.fillStyle = cor
                c:fillRect(0, 0, W, H)
                do
                    local i = -10
                    while i < 30 do
                        c.fillStyle = "rgba(0,0,0,.14)"
                        local x = __mod(i * 60 + k * 240, 1800) - 400
                        c:beginPath()
                        c:moveTo(x, 0)
                        c:lineTo(x + 30, 0)
                        c:lineTo(x - 270, H)
                        c:lineTo(x - 300, H)
                        __call(c, "fill")
                        i = i + 1
                    end
                end
                c:restore()
                do
                    local i = 0
                    while i < 30 do
                        local x = __mod(
                            __mod(
                                hash(nil, i) * W - k * (400 + hash(nil, i + 1) * 500),
                                W
                            ) + W,
                            W
                        )
                        P(
                            nil,
                            c,
                            x,
                            hash(nil, i + 2) * H,
                            40,
                            2,
                            "rgba(255,255,255,.18)"
                        )
                        i = i + 1
                    end
                end
                local ent = ease(nil, k / 0.4)
                local dl = (1 - ent) * -400
                local dr = (1 - ent) * 400
                ator(
                    nil,
                    c,
                    "daroca",
                    250 + dl,
                    470,
                    {scale = 3.6, facing = 1, frame = k, emotion = "taunted"}
                )
                local ____t_result_210
                if __t(e.vilao) then
                    ____t_result_210 = e.vilao
                else
                    ____t_result_210 = "c2_creuza"
                end
                local vilao = tostring(____t_result_210)
                if vilao == "gemeos" then
                    ator(
                        nil,
                        c,
                        "c2_ryan",
                        660 + dr,
                        470,
                        {scale = 3, facing = -1, frame = k}
                    )
                    ator(
                        nil,
                        c,
                        "c2_bryan",
                        800 + dr,
                        480,
                        {scale = 3, facing = -1, frame = k + 0.5}
                    )
                else
                    ator(
                        nil,
                        c,
                        vilao,
                        720 + dr,
                        470,
                        {scale = 3.6, facing = -1, frame = k}
                    )
                end
                c.fillStyle = "#ffffff"
                c:beginPath()
                c:moveTo(W / 2 + 54, 0)
                c:lineTo(W / 2 + 66, 0)
                c:lineTo(W / 2 - 54, H)
                c:lineTo(W / 2 - 66, H)
                __call(c, "fill")
                local kv = clamp(nil, (k - 0.35) / 0.25, 0, 1)
                if kv > 0 then
                    local sc = 1 + (1 - kv) * 2.5
                    c:save()
                    c:translate(W / 2, 250)
                    c:scale(sc, sc)
                    c.globalAlpha = a * kv
                    txt(
                        nil,
                        c,
                        "VS",
                        0,
                        -28,
                        "#ffe23a",
                        {s = 10, sombra = "#2a0a0a"}
                    )
                    c:restore()
                    if kv < 1 then
                        c.fillStyle = ("rgba(255,255,255," .. tostring((1 - kv) * 0.6)) .. ")"
                        c:fillRect(0, 0, W, H)
                    end
                end
                local kn = clamp(nil, (k - 0.6) / 0.3, 0, 1)
                c.globalAlpha = a * kn
                P(
                    nil,
                    c,
                    40,
                    470,
                    300,
                    46,
                    "#0c0e1a"
                )
                txt(
                    nil,
                    c,
                    "DA ROCA",
                    60,
                    480,
                    "#ffffff",
                    {s = 3, align = "left"}
                )
                local ____t_result_211
                if __t(e.nome) then
                    ____t_result_211 = e.nome
                else
                    ____t_result_211 = ""
                end
                local nome = tostring(____t_result_211)
                local ____t_result_212
                if __t(e.titulo) then
                    ____t_result_212 = e.titulo
                else
                    ____t_result_212 = ""
                end
                local tit = tostring(____t_result_212)
                P(
                    nil,
                    c,
                    W - 40 - math.max(
                        larg(nil, nome, 4),
                        larg(nil, tit, 2)
                    ) - 30,
                    400,
                    math.max(
                        larg(nil, nome, 4),
                        larg(nil, tit, 2)
                    ) + 30,
                    100,
                    "#0c0e1a"
                )
                txt(
                    nil,
                    c,
                    nome,
                    W - 55,
                    412,
                    "#ffffff",
                    {s = 4, align = "right"}
                )
                txt(
                    nil,
                    c,
                    tit,
                    W - 55,
                    458,
                    cor == "#ffffff" and "#ffe23a" or "#ffe9b0",
                    {s = 2, align = "right"}
                )
                c:restore()
            end,
            poder = function(self, c, e, t, ____bindingPattern0)
                local win
                win = ____bindingPattern0.win
                local ____win_216 = win
                local ____t_result_215
                local ____t_214 = __t
                local ____TS__Number_result_213 = __TS__Number(e.dur)
                __O[839] = ____TS__Number_result_213
                if ____t_214(____TS__Number_result_213) then
                    ____t_result_215 = __O[839]
                else
                    ____t_result_215 = 4.2
                end
                local f = ____win_216(nil, ____t_result_215)
                if not __t(f.on) then
                    return
                end
                local k = t - f.t0
                local a = math.min(
                    1,
                    k / 0.3,
                    (__add(f.t0, f.d) - t) / 0.4
                )
                local ____t_result_217
                if __t(e.poder) then
                    ____t_result_217 = e.poder
                else
                    ____t_result_217 = "fofoca"
                end
                local id = tostring(____t_result_217)
                local ____t_result_228
                local ____t_227 = __t
                local ____call_225 = __call
                local ____t_result_224
                local ____t_223 = __t
                local ____opt_220 = window.CampanhaPoderes
                if ____opt_220 ~= nil then
                    ____opt_220 = ____opt_220.lista
                end
                local ____opt_result_222
                if ____opt_220 ~= nil then
                    ____opt_result_222 = ____opt_220(____opt_220)
                end
                __O[840] = ____opt_result_222
                if ____t_223(____opt_result_222) then
                    ____t_result_224 = __O[840]
                else
                    ____t_result_224 = __arrL({}, 0)
                end
                local ____call_225_result_226 = ____call_225(
                    ____t_result_224,
                    "find",
                    function(____, p) return p.id == id end
                )
                __O[841] = ____call_225_result_226
                if ____t_227(____call_225_result_226) then
                    ____t_result_228 = __O[841]
                else
                    ____t_result_228 = {
                        nome = __call(id, "toUpperCase"),
                        cor = "#ffd24a"
                    }
                end
                local info = ____t_result_228
                c:save()
                c.globalAlpha = a
                c.fillStyle = "rgba(8,8,16,.82)"
                c:fillRect(0, 0, W, H)
                c:save()
                c:translate(W / 2, 220)
                c:rotate(k * 0.4)
                do
                    local i = 0
                    while i < 12 do
                        c:rotate(TAU / 12)
                        c.fillStyle = __add(info.cor, "33")
                        c:beginPath()
                        c:moveTo(0, 0)
                        c:lineTo(40, -500)
                        c:lineTo(-40, -500)
                        __call(c, "fill")
                        i = i + 1
                    end
                end
                c:restore()
                local b = math.sin(k * 3) * 6
                local sc = ease(nil, k / 0.5)
                circ(
                    nil,
                    c,
                    W / 2,
                    220 + b,
                    70 * sc,
                    __add(info.cor, "55")
                )
                local img = icone(nil, id)
                local ____t_230 = __t
                local ____t_result_229
                if __t(img.complete) then
                    ____t_result_229 = img.naturalWidth
                else
                    ____t_result_229 = img.complete
                end
                if ____t_230(____t_result_229) then
                    c.imageSmoothingEnabled = false
                    c:drawImage(
                        img,
                        W / 2 - 64 * sc,
                        156 + b - 64 * (sc - 1),
                        128 * sc,
                        128 * sc
                    )
                else
                    desenhaCoracao(
                        nil,
                        c,
                        W / 2,
                        220 + b,
                        12 * sc,
                        0,
                        info.cor
                    )
                end
                if k > 0.4 then
                    txt(
                        nil,
                        c,
                        "NOVO PODER!",
                        W / 2,
                        330,
                        "#ffe23a",
                        {s = 4, sombra = "#2a1a0a"}
                    )
                    txt(
                        nil,
                        c,
                        info.nome,
                        W / 2,
                        384,
                        info.cor,
                        {s = 3, sombra = "#0a0a10"}
                    )
                end
                if k > 1.1 then
                    local ____c_232 = c
                    local ____t_result_231
                    if __t(e.texto) then
                        ____t_result_231 = e.texto
                    else
                        ____t_result_231 = "GARRAFADA LIBERADA NA BANCA DO SEU LINDOMAR"
                    end
                    txt(
                        nil,
                        ____c_232,
                        tostring(____t_result_231),
                        W / 2,
                        432,
                        "#e8e2d0",
                        {s = 2}
                    )
                end
                do
                    local i = 0
                    while i < 16 do
                        if math.sin(k * 6 + i * 1.3) > 0.5 then
                            local x = W / 2 + math.cos(i * 1.7 + k) * (120 + i * 6)
                            local y = 220 + math.sin(i * 2.3 + k) * (80 + i * 4)
                            P(
                                nil,
                                c,
                                x,
                                y - 6,
                                2,
                                14,
                                "#fff3a8"
                            )
                            P(
                                nil,
                                c,
                                x - 6,
                                y,
                                14,
                                2,
                                "#fff3a8"
                            )
                        end
                        i = i + 1
                    end
                end
                c:restore()
            end,
            fim = function(self, c, e, t)
                local ____t_result_235
                local ____t_234 = __t
                local ____TS__Number_result_233 = __TS__Number(e.t)
                __O[842] = ____TS__Number_result_233
                if ____t_234(____TS__Number_result_233) then
                    ____t_result_235 = __O[842]
                else
                    ____t_result_235 = 0
                end
                local t0 = ____t_result_235
                if __lt(t, t0) then
                    return
                end
                local k = t - t0
                c.fillStyle = ("rgba(6,6,12," .. tostring(math.min(1, k / 1.2))) .. ")"
                c:fillRect(0, 0, W, H)
                do
                    local i = 0
                    while i < 26 do
                        local x = hash(nil, i) * W + math.sin(k * 0.5 + i) * 20
                        local y = H - __mod(
                            k * (16 + hash(nil, i + 1) * 20) + hash(nil, i + 2) * H,
                            H
                        )
                        c.globalAlpha = 0.5
                        P(
                            nil,
                            c,
                            x,
                            y,
                            2,
                            2,
                            __t(__mod(i, 2)) and "#ffd27a" or "#e8f87a"
                        )
                        i = i + 1
                    end
                end
                c.globalAlpha = 1
                local kf = clamp(nil, (k - 1) / 1.2, 0, 1)
                if kf > 0 then
                    c:save()
                    c.globalAlpha = kf
                    local sc = 1 + (1 - ease(nil, kf)) * 0.3
                    c:translate(W / 2, 220)
                    c:scale(sc, sc)
                    txt(
                        nil,
                        c,
                        "FIM",
                        0,
                        -60,
                        "#ffe9b0",
                        {s = 16, sombra = "#3a1a0a"}
                    )
                    c:restore()
                end
                local kc = clamp(nil, (k - 2.4) / 0.8, 0, 1)
                if kc > 0 then
                    local pul = 1 + math.max(
                        0,
                        math.sin(k * 7)
                    ) * 0.1
                    c.globalAlpha = kc
                    desenhaCoracao(
                        nil,
                        c,
                        W / 2,
                        330,
                        6 * pul,
                        0
                    )
                    local ____c_237 = c
                    local ____t_result_236
                    if __t(e.sub) then
                        ____t_result_236 = e.sub
                    else
                        ____t_result_236 = "O TRIO VOLTOU."
                    end
                    txt(
                        nil,
                        ____c_237,
                        tostring(____t_result_236),
                        W / 2,
                        380,
                        "#e8e2d0",
                        {s = 2}
                    )
                    c.globalAlpha = 1
                end
            end,
            luz_final = function(self, c, e, t, ____bindingPattern0)
                local s
                s = ____bindingPattern0.s
                local tt = s.elapsed
                c:save()
                c.globalCompositeOperation = "lighter"
                do
                    local i = 0
                    while i < 6 do
                        local x = 160 + i * 130 + math.sin(tt * 0.3 + i) * 20
                        c.fillStyle = ("rgba(255,214,140," .. tostring(0.07 + 0.03 * math.sin(tt * 0.8 + i))) .. ")"
                        c:beginPath()
                        c:moveTo(x, 0)
                        c:lineTo(x + 60, 0)
                        c:lineTo(x - 60, H)
                        c:lineTo(x - 160, H)
                        __call(c, "fill")
                        i = i + 1
                    end
                end
                c:restore()
                do
                    local i = 0
                    while i < 30 do
                        local x = hash(nil, i) * W + math.sin(tt * 0.4 + i) * 30
                        local y = H - __mod(
                            tt * (10 + hash(nil, i + 1) * 16) + hash(nil, i + 2) * H,
                            H
                        )
                        P(
                            nil,
                            c,
                            x,
                            y,
                            2,
                            2,
                            "#fff0c0"
                        )
                        i = i + 1
                    end
                end
            end,
            barras = function(self, c, e, t)
                local ____t_result_240
                local ____t_239 = __t
                local ____TS__Number_result_238 = __TS__Number(e.t)
                __O[843] = ____TS__Number_result_238
                if ____t_239(____TS__Number_result_238) then
                    ____t_result_240 = __O[843]
                else
                    ____t_result_240 = 0
                end
                local t0 = ____t_result_240
                local ____temp_244 = t - t0
                local ____t_result_243
                local ____t_242 = __t
                local ____TS__Number_result_241 = __TS__Number(e.dur)
                __O[844] = ____TS__Number_result_241
                if ____t_242(____TS__Number_result_241) then
                    ____t_result_243 = __O[844]
                else
                    ____t_result_243 = 1
                end
                local k = ease(nil, ____temp_244 / ____t_result_243)
                local ____t_result_247
                local ____t_246 = __t
                local ____TS__Number_result_245 = __TS__Number(e.altura)
                __O[845] = ____TS__Number_result_245
                if ____t_246(____TS__Number_result_245) then
                    ____t_result_247 = __O[845]
                else
                    ____t_result_247 = 60
                end
                local h = ____t_result_247 * k
                c.fillStyle = "#05060a"
                c:fillRect(0, 0, W, 24 + h)
                c:fillRect(0, H - 20 - h, W, 20 + h)
            end,
            flash_memoria = function(self, c, e, t, ____bindingPattern0)
                local win
                win = ____bindingPattern0.win
                local ____win_251 = win
                local ____t_result_250
                local ____t_249 = __t
                local ____TS__Number_result_248 = __TS__Number(e.dur)
                __O[846] = ____TS__Number_result_248
                if ____t_249(____TS__Number_result_248) then
                    ____t_result_250 = __O[846]
                else
                    ____t_result_250 = 0.9
                end
                local f = ____win_251(nil, ____t_result_250)
                if not __t(f.on) then
                    return
                end
                local k = f.k
                c.fillStyle = ("rgba(255,248,230," .. tostring((1 - k) * 0.9)) .. ")"
                c:fillRect(0, 0, W, H)
                c:save()
                c.globalAlpha = math.sin(k * math.pi) * 0.75
                local ____polaroid_267 = polaroid
                local ____c_265 = c
                local ____t_result_254
                local ____t_253 = __t
                local ____TS__Number_result_252 = __TS__Number(e.x)
                __O[847] = ____TS__Number_result_252
                if ____t_253(____TS__Number_result_252) then
                    ____t_result_254 = __O[847]
                else
                    ____t_result_254 = 480
                end
                local ____t_result_257
                local ____t_256 = __t
                local ____TS__Number_result_255 = __TS__Number(e.y)
                __O[848] = ____TS__Number_result_255
                if ____t_256(____TS__Number_result_255) then
                    ____t_result_257 = __O[848]
                else
                    ____t_result_257 = 250
                end
                local ____t_result_260
                local ____t_259 = __t
                local ____TS__Number_result_258 = __TS__Number(e.giro)
                __O[849] = ____TS__Number_result_258
                if ____t_259(____TS__Number_result_258) then
                    ____t_result_260 = __O[849]
                else
                    ____t_result_260 = 0.06
                end
                local function ____temp_266(____, cc, iw, ih)
                    local ____cenaFoto_263 = cenaFoto
                    local ____array_262 = __TS__SparseArrayNew(nil, cc, iw, ih)
                    local ____t_result_261
                    if __t(e.quem) then
                        ____t_result_261 = e.quem
                    else
                        ____t_result_261 = __arrL({"crianca_daroca", "crianca_reeis", "crianca_jorge"}, 3)
                    end
                    __TS__SparseArrayPush(
                        ____array_262,
                        ____t_result_261,
                        nil,
                        nil,
                        1.4
                    )
                    return ____cenaFoto_263(__TS__SparseArraySpread(____array_262))
                end
                local ____t_result_264
                if __t(e.legenda) then
                    ____t_result_264 = e.legenda
                else
                    ____t_result_264 = ""
                end
                ____polaroid_267(
                    nil,
                    ____c_265,
                    ____t_result_254,
                    ____t_result_257,
                    300,
                    300,
                    ____t_result_260,
                    ____temp_266,
                    ____t_result_264
                )
                c:restore()
            end,
            chat = function(self, c, e, t)
                local ____t_result_270
                local ____t_269 = __t
                local ____TS__Number_result_268 = __TS__Number(e.t)
                __O[850] = ____TS__Number_result_268
                if ____t_269(____TS__Number_result_268) then
                    ____t_result_270 = __O[850]
                else
                    ____t_result_270 = 0
                end
                local t0 = ____t_result_270
                local ____t_277 = __t
                local ____lt_result_276 = __lt(t, t0)
                if not ____lt_result_276 then
                    local ____gt_275 = __gt
                    local ____t_274 = t
                    local ____t_result_273
                    local ____t_272 = __t
                    local ____TS__Number_result_271 = __TS__Number(e.dur)
                    __O[851] = ____TS__Number_result_271
                    if ____t_272(____TS__Number_result_271) then
                        ____t_result_273 = __O[851]
                    else
                        ____t_result_273 = 99
                    end
                    ____lt_result_276 = ____gt_275(____t_274, t0 + ____t_result_273)
                end
                if ____t_277(____lt_result_276) then
                    return
                end
                local ____isArray_result_278
                if __isArray(e.mensagens) then
                    ____isArray_result_278 = e.mensagens
                else
                    ____isArray_result_278 = __arrL({}, 0)
                end
                local msgs = ____isArray_result_278
                local ____t_result_281
                local ____t_280 = __t
                local ____TS__Number_result_279 = __TS__Number(e.x)
                __O[852] = ____TS__Number_result_279
                if ____t_280(____TS__Number_result_279) then
                    ____t_result_281 = __O[852]
                else
                    ____t_result_281 = 760
                end
                local X = ____t_result_281
                local Y = 70
                P(
                    nil,
                    c,
                    X - 130,
                    Y,
                    260,
                    400,
                    "#14161c"
                )
                P(
                    nil,
                    c,
                    X - 122,
                    Y + 10,
                    244,
                    380,
                    "#e8e2d8"
                )
                P(
                    nil,
                    c,
                    X - 122,
                    Y + 10,
                    244,
                    40,
                    "#2c5a9e"
                )
                local ____c_283 = c
                local ____t_result_282
                if __t(e.titulo) then
                    ____t_result_282 = e.titulo
                else
                    ____t_result_282 = "GRUPO"
                end
                txt(
                    nil,
                    ____c_283,
                    tostring(____t_result_282),
                    X,
                    Y + 24,
                    "#ffffff",
                    {s = 2}
                )
                local y = Y + 64
                __call(
                    msgs,
                    "forEach",
                    function(____, m)
                        local ____t_result_286
                        local ____t_285 = __t
                        local ____TS__Number_result_284 = __TS__Number(m.t)
                        __O[853] = ____TS__Number_result_284
                        if ____t_285(____TS__Number_result_284) then
                            ____t_result_286 = __O[853]
                        else
                            ____t_result_286 = 0
                        end
                        local tm = t0 + ____t_result_286
                        if __lt(t, tm) then
                            return
                        end
                        local eu = not not __t(m.eu)
                        local ____t_result_287
                        if __t(m.texto) then
                            ____t_result_287 = m.texto
                        else
                            ____t_result_287 = ""
                        end
                        local s2 = tostring(____t_result_287)
                        local linhas = __arrL({}, 0)
                        local lin = ""
                        for ____, w2 in __iterar((__call(s2, "split", " "))) do
                            if __len(__call(
                                __add(
                                    __add(lin, " "),
                                    w2
                                ),
                                "trim"
                            )) > 18 then
                                __call(linhas, "push", lin)
                                lin = w2
                            else
                                lin = __call(
                                    __add(
                                        __add(lin, " "),
                                        w2
                                    ),
                                    "trim"
                                )
                            end
                        end
                        __call(linhas, "push", lin)
                        local bw = math.max(__TS__Spread(__iter(__call(
                            linhas,
                            "map",
                            function(____, l) return larg(nil, l, 1) end
                        )))) + 20
                        local bh = __len(linhas) * 10 + 18
                        local ____t_result_288
                        if __t(eu) then
                            ____t_result_288 = X + 112 - bw
                        else
                            ____t_result_288 = X - 112
                        end
                        local bx = ____t_result_288
                        local pop = ease(nil, (t - tm) / 0.2)
                        c:save()
                        c:translate(bx + bw / 2, y + bh / 2)
                        c:scale(pop, pop)
                        P(
                            nil,
                            c,
                            -bw / 2,
                            -bh / 2,
                            bw,
                            bh,
                            __t(eu) and "#c8f0b0" or "#ffffff"
                        )
                        local ____c_291 = c
                        local ____call_290 = __call
                        local ____t_result_289
                        if __t(m.de) then
                            ____t_result_289 = m.de
                        else
                            ____t_result_289 = ""
                        end
                        txt(
                            nil,
                            ____c_291,
                            ____call_290(
                                tostring(____t_result_289),
                                "toUpperCase"
                            ),
                            -bw / 2 + 8,
                            -bh / 2 + 4,
                            __t(eu) and "#3a7a2a" or "#c43c3a",
                            {align = "left"}
                        )
                        __call(
                            linhas,
                            "forEach",
                            function(____, l, i) return txt(
                                nil,
                                c,
                                l,
                                -bw / 2 + 8,
                                -bh / 2 + 14 + i * 10,
                                "#1c1c1c",
                                {align = "left"}
                            ) end
                        )
                        c:restore()
                        y = y + (bh + 8)
                    end
                )
            end
        },
        "titulo_c2,coracao_partido,batimento,polaroids,foto_trio,pensamento,neblina,frio,estrelas,pb,flashback,vs,poder,fim,luz_final,barras,flash_memoria,chat"
    )
    local function cab(____, x)
        local ____t_result_292
        if __t(x.o.scale) then
            ____t_result_292 = x.o.scale
        else
            ____t_result_292 = 1
        end
        local S = ____t_result_292
        local ____opt_293 = x.head
        if ____opt_293 ~= nil then
            ____opt_293 = ____opt_293.top
        end
        local ____opt_293_295 = ____opt_293
        if ____opt_293_295 == nil then
            ____opt_293_295 = 150
        end
        local alt = (220 - ____opt_293_295) * S
        local fx = __lt(x.o.facing, 0) and -1 or 1
        local ____S_298 = S
        local ____alt_299 = alt
        local ____fx_300 = fx
        local ____temp_301 = x.y - alt
        local ____x_x_297 = x.x
        local ____t_result_296
        if __t(x.head) then
            ____t_result_296 = x.head.cx - 100
        else
            ____t_result_296 = 0
        end
        return {
            S = ____S_298,
            alt = ____alt_299,
            fx = ____fx_300,
            topo = ____temp_301,
            olhoX = ____x_x_297 + fx * (____t_result_296 * S + 5 * S),
            olhoY = x.y - alt + 13 * S,
            boca = x.y - alt + 20 * S
        }
    end
    local function desenhaAgarrado(self, w, hx, gy, t, d, op)
        local INK = "#342d2b"
        local ____t_result_302
        if __t(op.pele) then
            ____t_result_302 = op.pele
        else
            ____t_result_302 = "#d29a6c"
        end
        local SK = ____t_result_302
        local SKS = "#a8704a"
        local SKL = "#e9b684"
        local ____t_result_303
        if __t(op.camisa) then
            ____t_result_303 = op.camisa
        else
            ____t_result_303 = "#dc8c47"
        end
        local SH = ____t_result_303
        local SHS = "#b06a32"
        local SHL = "#efaa6a"
        local PA = "#455b62"
        local PAS = "#33464c"
        local BO = "#3a2a1e"
        local BOL = "#6a4a34"
        local HA = "#5f4934"
        local puxa = math.floor(math.sin(t * 7) * 3 + math.sin(t * 13) * 1.5 + 0.5)
        local function chute(____, k)
            return math.floor(math.max(
                0,
                math.sin(t * 11 + k * 2.1)
            ) * 6 + 0.5)
        end
        w:save()
        w:translate(
            math.floor(hx + 0.5) + puxa,
            math.floor(gy + 0.5)
        )
        w:scale(d, 1)
        local function r(____, x, y, ww, hh, col)
            w.fillStyle = col
            w:fillRect(x, y, ww, hh)
        end
        local function cont(____, x, y, ww, hh, col)
            r(
                nil,
                x - 1,
                y - 1,
                ww + 2,
                hh + 2,
                INK
            )
            r(
                nil,
                x,
                y,
                ww,
                hh,
                col
            )
        end
        local function barra(____, x1, y1, x2, y2, esp, col, contorno)
            if contorno == nil then
                contorno = true
            end
            local n = math.max(
                1,
                math.floor(__hypot(x2 - x1, y2 - y1) + 0.5)
            )
            if __t(contorno) then
                do
                    local k = 0
                    while k <= n do
                        r(
                            nil,
                            math.floor(x1 + (x2 - x1) * k / n + 0.5) - 1,
                            math.floor(y1 + (y2 - y1) * k / n + 0.5) - 1,
                            esp + 2,
                            esp + 2,
                            INK
                        )
                        k = k + 1
                    end
                end
            end
            do
                local k = 0
                while k <= n do
                    r(
                        nil,
                        math.floor(x1 + (x2 - x1) * k / n + 0.5),
                        math.floor(y1 + (y2 - y1) * k / n + 0.5),
                        esp,
                        esp,
                        col
                    )
                    k = k + 1
                end
            end
        end
        w.globalAlpha = 0.28
        r(
            nil,
            -92,
            -2,
            90,
            4,
            "#000"
        )
        r(
            nil,
            -86,
            -3,
            78,
            1,
            "#000"
        )
        w.globalAlpha = 1
        do
            local k = 0
            while k < 5 do
                local q = __mod(t * 1.6 + k / 5, 1)
                w.globalAlpha = (1 - q) * 0.55
                r(
                    nil,
                    -60 - k * 8 - math.floor(q * 18 + 0.5),
                    -4 - math.floor(q * 9 + 0.5),
                    4 + math.floor(q * 5 + 0.5),
                    3 + math.floor(q * 3 + 0.5),
                    "#d8d0c0"
                )
                k = k + 1
            end
        end
        w.globalAlpha = 1
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({0, -11, PAS}, 3),
                __arrL({1, -7, PA}, 3)
            },
            2
        ))) do
            local k = ____value[1]
            local y0 = ____value[2]
            local cor = ____value[3]
            local jx = -66
            local jy = y0
            local lev = chute(nil, k)
            barra(
                nil,
                -50,
                y0 - 1,
                jx,
                jy,
                6,
                cor
            )
            barra(
                nil,
                jx,
                jy,
                -80,
                y0 - 10 - lev,
                6,
                cor
            )
            local px = -80
            local py = y0 - 10 - lev
            r(
                nil,
                px - 9,
                py - 3,
                10,
                8,
                INK
            )
            r(
                nil,
                px - 8,
                py - 2,
                8,
                6,
                BO
            )
            r(
                nil,
                px - 8,
                py - 2,
                2,
                6,
                BOL
            )
            r(
                nil,
                px - 10,
                py + 4,
                4,
                2,
                INK
            )
        end
        cont(
            nil,
            -52,
            -18,
            4,
            15,
            "#5a3a20"
        )
        cont(
            nil,
            -48,
            -19,
            27,
            16,
            SH
        )
        r(
            nil,
            -48,
            -6,
            27,
            3,
            SHS
        )
        r(
            nil,
            -48,
            -19,
            27,
            2,
            SHL
        )
        r(
            nil,
            -44,
            -12,
            6,
            1,
            SHS
        )
        r(
            nil,
            -36,
            -10,
            7,
            1,
            SHS
        )
        r(
            nil,
            -28,
            -13,
            1,
            6,
            SHS
        )
        r(
            nil,
            -23,
            -17,
            3,
            12,
            SHS
        )
        cont(
            nil,
            -46,
            -29,
            19,
            10,
            "#6a7a3a"
        )
        r(
            nil,
            -46,
            -29,
            19,
            2,
            "#8a9a4a"
        )
        r(
            nil,
            -44,
            -24,
            15,
            1,
            "#4a5a2a"
        )
        r(
            nil,
            -38,
            -27,
            4,
            3,
            "#c8b860"
        )
        r(
            nil,
            -46,
            -20,
            3,
            2,
            "#4a5a2a"
        )
        r(
            nil,
            -30,
            -20,
            3,
            2,
            "#4a5a2a"
        )
        barra(
            nil,
            -24,
            -18,
            -2,
            -16,
            4,
            "#9a6038"
        )
        r(
            nil,
            -3,
            -19,
            6,
            6,
            INK
        )
        r(
            nil,
            -2,
            -18,
            4,
            4,
            SKS
        )
        r(
            nil,
            1,
            -18,
            2,
            4,
            "#8a5030"
        )
        r(
            nil,
            -21,
            -22,
            8,
            6,
            SKS
        )
        cont(
            nil,
            -25,
            -37,
            16,
            16,
            SK
        )
        r(
            nil,
            -25,
            -37,
            16,
            3,
            HA
        )
        r(
            nil,
            -25,
            -37,
            5,
            11,
            HA
        )
        r(
            nil,
            -21,
            -29,
            3,
            4,
            SKS
        )
        r(
            nil,
            -20,
            -28,
            1,
            2,
            "#8e5e43"
        )
        r(
            nil,
            -24,
            -22,
            15,
            1,
            SKS
        )
        r(
            nil,
            -14,
            -32,
            5,
            2,
            "#f2f2ee"
        )
        r(
            nil,
            -12,
            -32,
            2,
            2,
            "#252f2b"
        )
        r(
            nil,
            -15,
            -35,
            5,
            1,
            "#5a3a20"
        )
        r(
            nil,
            -15,
            -34,
            1,
            1,
            "#5a3a20"
        )
        r(
            nil,
            -10,
            -28,
            2,
            2,
            SKS
        )
        r(
            nil,
            -9,
            -27,
            1,
            1,
            "#8e5e43"
        )
        local grito = __mod(
            math.floor(t * 5),
            2
        )
        r(
            nil,
            -15,
            -25,
            6,
            2 + grito,
            "#5a2018"
        )
        r(
            nil,
            -14,
            -25,
            4,
            1,
            "#f2f2ee"
        )
        r(
            nil,
            -12,
            -23 + grito,
            2,
            1,
            "#c84a3a"
        )
        if op.chorando ~= false then
            local qq = __mod(t * 1.2, 1)
            r(
                nil,
                -12,
                -30,
                1,
                4,
                "#8ad0ff"
            )
            w.globalAlpha = 1 - qq
            r(
                nil,
                -12,
                -26 + math.floor(qq * 8 + 0.5),
                1,
                2,
                "#8ad0ff"
            )
            w.globalAlpha = 1
        end
        local ch = math.floor(math.sin(t * 7) * 1 + 0.5)
        w:save()
        w:translate(-24, -38 + ch)
        w:rotate(-0.38)
        r(
            nil,
            -12,
            -1,
            26,
            5,
            INK
        )
        r(
            nil,
            -11,
            0,
            24,
            3,
            "#dbb969"
        )
        r(
            nil,
            -11,
            3,
            24,
            1,
            "#6e5335"
        )
        r(
            nil,
            -6,
            -8,
            14,
            9,
            INK
        )
        r(
            nil,
            -5,
            -7,
            12,
            7,
            "#dfb96a"
        )
        r(
            nil,
            -5,
            -2,
            12,
            2,
            "#8a5a3b"
        )
        r(
            nil,
            -4,
            -8,
            8,
            1,
            "#f0ce7e"
        )
        w:restore()
        barra(
            nil,
            -20,
            -12,
            -8,
            -10,
            5,
            SH
        )
        barra(
            nil,
            -8,
            -10,
            0,
            -9,
            4,
            SK
        )
        r(
            nil,
            -1,
            -12,
            7,
            8,
            INK
        )
        r(
            nil,
            0,
            -11,
            5,
            6,
            SK
        )
        r(
            nil,
            0,
            -11,
            5,
            1,
            SKL
        )
        r(
            nil,
            1,
            -8,
            4,
            1,
            "#8e5e43"
        )
        r(
            nil,
            1,
            -6,
            4,
            1,
            "#8e5e43"
        )
        local q = __mod(t * 1.3, 1)
        w.globalAlpha = 1 - q
        r(
            nil,
            -26,
            -36 - math.floor(q * 6 + 0.5),
            2,
            3,
            "#8ad0ff"
        )
        w.globalAlpha = 1
        if __t(__mod(
            math.floor(t * 4),
            2
        )) then
            r(
                nil,
                -4,
                -36,
                1,
                4,
                "#ffffff"
            )
            r(
                nil,
                -1,
                -34,
                1,
                4,
                "#ffffff"
            )
            r(
                nil,
                2,
                -32,
                1,
                3,
                "#ffffff"
            )
        end
        w:restore()
    end
    local anims = __ord(
        {
            chorando = {depois = function(self, w, x)
                local h = cab(nil, x)
                w.fillStyle = "#8ad0ff"
                w:fillRect(
                    math.floor(h.olhoX + 0.5),
                    math.floor(h.olhoY + 2 * h.S + 0.5),
                    2,
                    math.floor(9 * h.S + 0.5)
                )
                do
                    local k = 0
                    while k < 2 do
                        local q = __mod(x.t * 1.3 + k * 0.5, 1)
                        w.globalAlpha = 1 - q
                        w:fillRect(
                            math.floor(h.olhoX + h.fx * 2 + 0.5),
                            math.floor(h.olhoY + 10 * h.S + q * 50 * h.S + 0.5),
                            2,
                            4
                        )
                        k = k + 1
                    end
                end
                w.globalAlpha = 1
            end},
            frio = __ord(
                {
                    antes = function(self, w, x)
                        w:save()
                        w:translate(
                            math.floor(math.sin(x.t * 55) * 1.4 + 0.5),
                            0
                        )
                    end,
                    depois = function(self, w, x)
                        w:restore()
                        local h = cab(nil, x)
                        do
                            local k = 0
                            while k < 3 do
                                local q = __mod(x.t * 0.7 + k / 3, 1)
                                w.globalAlpha = (1 - q) * 0.7
                                circ(
                                    nil,
                                    w,
                                    h.olhoX + h.fx * (8 + q * 26) * h.S,
                                    h.boca - q * 18 * h.S,
                                    (2 + q * 8) * h.S,
                                    "#f4f8ff"
                                )
                                k = k + 1
                            end
                        end
                        w.globalAlpha = 1
                    end
                },
                "antes,depois"
            ),
            treme = __ord(
                {
                    antes = function(self, w, x)
                        w:save()
                        w:translate(
                            math.floor(math.sin(x.t * 47) * 2 + 0.5),
                            math.floor(math.cos(x.t * 31) + 0.5)
                        )
                    end,
                    depois = function(self, w)
                        w:restore()
                    end
                },
                "antes,depois"
            ),
            deitado = __ord(
                {
                    antes = function(self, w, x)
                        w:save()
                        w:translate(x.x, x.y)
                        w:rotate(math.pi / 2 * (__lt(x.o.facing, 0) and -1 or 1))
                        w:translate(
                            __TS__Number(-x.x),
                            __TS__Number(-x.y)
                        )
                    end,
                    depois = function(self, w, x)
                        w:restore()
                        local h = cab(nil, x)
                        local d = __lt(x.o.facing, 0) and -1 or 1
                        local L = h.alt * 0.62
                        local ____temp_304
                        if d > 0 then
                            ____temp_304 = x.x - 4
                        else
                            ____temp_304 = x.x - L + 4
                        end
                        local x0 = ____temp_304
                        do
                            local i = 0
                            while i < L do
                                do
                                    local j = 0
                                    while j < 22 do
                                        P(
                                            nil,
                                            w,
                                            x0 + i,
                                            x.y - 2 + j,
                                            4,
                                            4,
                                            __t(__mod((i + j) / 4, 2)) and "#b83a3a" or "#8a2424"
                                        )
                                        j = j + 4
                                    end
                                end
                                i = i + 4
                            end
                        end
                        P(
                            nil,
                            w,
                            x0,
                            x.y - 2,
                            L,
                            2,
                            "#d85a4a"
                        )
                    end
                },
                "antes,depois"
            ),
            agarra_pernas = __ord(
                {
                    cabeca = function(____, x) return {
                        x = x.x - (__lt(x.facing, 0) and -1 or 1) * 17,
                        y = x.y - 34
                    } end,
                    antes = function(self, w)
                        w:save()
                        w:translate(-100000, 0)
                    end,
                    depois = function(self, w, x)
                        w:restore()
                        local ____desenhaAgarrado_307 = desenhaAgarrado
                        local ____array_306 = __TS__SparseArrayNew(
                            nil,
                            w,
                            x.x,
                            x.y,
                            x.t,
                            __lt(x.o.facing, 0) and -1 or 1
                        )
                        local ____t_result_305
                        if __t(x.a.opts) then
                            ____t_result_305 = x.a.opts
                        else
                            ____t_result_305 = {}
                        end
                        __TS__SparseArrayPush(____array_306, ____t_result_305)
                        ____desenhaAgarrado_307(__TS__SparseArraySpread(____array_306))
                    end
                },
                "cabeca,antes,depois"
            ),
            sacudindo = __ord(
                {
                    antes = function(self, w, x)
                        local ang = math.sin(x.t * 7) * 0.1 + math.sin(x.t * 13) * 0.04
                        local dx = math.sin(x.t * 7) * 3 + math.sin(x.t * 13) * 1.5
                        w:save()
                        w:translate(
                            math.floor(dx + 0.5),
                            math.floor(-math.abs(math.sin(x.t * 7)) * 3 + 0.5)
                        )
                        w:translate(x.x, x.y)
                        w:rotate(ang)
                        w:translate(
                            __TS__Number(-x.x),
                            __TS__Number(-x.y)
                        )
                    end,
                    depois = function(self, w, x)
                        w:restore()
                        local h = cab(nil, x)
                        do
                            local k = 0
                            while k < 3 do
                                local q = __mod(x.t * 2 + k / 3, 1)
                                w.globalAlpha = (1 - q) * 0.8
                                P(
                                    nil,
                                    w,
                                    x.x - h.fx * (14 + q * 16) * h.S,
                                    x.y - h.alt * (0.3 + k * 0.2),
                                    10 * h.S * (1 - q),
                                    2,
                                    "#ffffff"
                                )
                                P(
                                    nil,
                                    w,
                                    x.x + h.fx * (14 + q * 16) * h.S,
                                    x.y - h.alt * (0.4 + k * 0.18),
                                    10 * h.S * (1 - q),
                                    2,
                                    "#ffffff"
                                )
                                k = k + 1
                            end
                        end
                        w.globalAlpha = 1
                        local q = __mod(x.t * 1.1, 1)
                        P(
                            nil,
                            w,
                            x.x - h.fx * 8 * h.S,
                            h.topo + 4 + q * 16,
                            4,
                            6,
                            "#8ad0ff"
                        )
                    end
                },
                "antes,depois"
            ),
            ajoelhado = __ord(
                {
                    antes = function(self, w, x)
                        w:save()
                        w:translate(x.x, x.y)
                        w:scale(1.06, 0.76)
                        w:translate(
                            __TS__Number(-x.x),
                            __TS__Number(-x.y)
                        )
                    end,
                    depois = function(self, w)
                        w:restore()
                    end
                },
                "antes,depois"
            ),
            celular = {depois = function(self, w, x)
                local h = cab(nil, x)
                local ____w_310 = w
                local ____temp_309 = h.olhoX + h.fx * 2 * h.S
                local ____temp_308
                if h.fx < 0 then
                    ____temp_308 = 6 * h.S
                else
                    ____temp_308 = 0
                end
                P(
                    nil,
                    ____w_310,
                    ____temp_309 - ____temp_308,
                    h.olhoY - 2 * h.S,
                    6 * h.S,
                    12 * h.S,
                    "#1c1e24"
                )
                local ____w_313 = w
                local ____temp_312 = h.olhoX + h.fx * 3 * h.S
                local ____temp_311
                if h.fx < 0 then
                    ____temp_311 = 5 * h.S
                else
                    ____temp_311 = 0
                end
                P(
                    nil,
                    ____w_313,
                    ____temp_312 - ____temp_311,
                    h.olhoY,
                    4 * h.S,
                    8 * h.S,
                    "#5a8ad0"
                )
            end},
            celular_mao = {depois = function(self, w, x)
                local h = cab(nil, x)
                local px = x.x + h.fx * 10 * h.S
                local py = x.y - h.alt * 0.55
                P(
                    nil,
                    w,
                    px - 4 * h.S,
                    py,
                    8 * h.S,
                    12 * h.S,
                    "#1c1e24"
                )
                P(
                    nil,
                    w,
                    px - 3 * h.S,
                    py + h.S,
                    6 * h.S,
                    9 * h.S,
                    __t(__mod(
                        math.floor(x.t * 3),
                        2
                    )) and "#8ab8ff" or "#5a8ad0"
                )
                w:save()
                w.globalCompositeOperation = "lighter"
                w.fillStyle = "rgba(120,170,255,.12)"
                w:fillRect(px - 20 * h.S, h.topo, 40 * h.S, 30 * h.S)
                w:restore()
            end},
            zzz = {depois = function(self, w, x)
                local h = cab(nil, x)
                local deit = __call(
                    tostring(x.a.anim),
                    "includes",
                    "deitado"
                )
                local ____t_result_314
                if __t(deit) then
                    ____t_result_314 = x.x + h.fx * h.alt * 0.85
                else
                    ____t_result_314 = h.olhoX + 10
                end
                local bx = ____t_result_314
                local ____t_result_315
                if __t(deit) then
                    ____t_result_315 = x.y - 30
                else
                    ____t_result_315 = h.topo - 10
                end
                local by = ____t_result_315
                do
                    local k = 0
                    while k < 3 do
                        local q = __mod(x.t * 0.5 + k / 3, 1)
                        w.globalAlpha = math.sin(q * math.pi)
                        txt(
                            nil,
                            w,
                            "Z",
                            bx + q * 30,
                            by - q * 50,
                            "#e8ecff",
                            {s = 2 + __mod(k, 2)}
                        )
                        k = k + 1
                    end
                end
                w.globalAlpha = 1
            end},
            exclama = {depois = function(self, w, x)
                local h = cab(nil, x)
                local pop = math.min(1, x.t * 6)
                local y = h.topo - 30 * pop
                P(
                    nil,
                    w,
                    x.x - 10,
                    y - 30,
                    20,
                    32,
                    "#fff6dc"
                )
                P(
                    nil,
                    w,
                    x.x - 3,
                    y - 26,
                    6,
                    16,
                    "#e8433a"
                )
                P(
                    nil,
                    w,
                    x.x - 3,
                    y - 6,
                    6,
                    6,
                    "#e8433a"
                )
            end},
            pergunta = {depois = function(self, w, x)
                local h = cab(nil, x)
                local y = h.topo - 30 + math.sin(x.t * 3) * 3
                txt(
                    nil,
                    w,
                    "?",
                    x.x,
                    y - 24,
                    "#ffe23a",
                    {s = 4, sombra = "#2a1a0a"}
                )
            end},
            raiva = {depois = function(self, w, x)
                local h = cab(nil, x)
                local pul = math.sin(x.t * 10) > 0 and 1 or 0
                local cx = x.x + h.fx * 10 * h.S
                local cy = h.topo - 2
                for ____, ____value in __iterar((__arrL(
                    {
                        __arrL({-1, -1}, 2),
                        __arrL({1, -1}, 2),
                        __arrL({-1, 1}, 2),
                        __arrL({1, 1}, 2)
                    },
                    4
                ))) do
                    local dx = ____value[1]
                    local dy = ____value[2]
                    P(
                        nil,
                        w,
                        cx + dx * (4 + pul),
                        cy + dy * (4 + pul),
                        6,
                        6,
                        "#e8433a"
                    )
                end
            end},
            suor = {depois = function(self, w, x)
                local h = cab(nil, x)
                local q = __mod(x.t * 0.8, 1)
                P(
                    nil,
                    w,
                    x.x - h.fx * 8 * h.S,
                    h.topo + 4 + q * 20,
                    4,
                    6,
                    "#8ad0ff"
                )
                P(
                    nil,
                    w,
                    x.x - h.fx * 8 * h.S + 1,
                    h.topo + 2 + q * 20,
                    2,
                    2,
                    "#8ad0ff"
                )
            end},
            coracao = {depois = function(self, w, x)
                local h = cab(nil, x)
                desenhaCoracao(
                    nil,
                    w,
                    x.x,
                    h.topo - 22 + math.sin(x.t * 3) * 4,
                    3 * (1 + math.max(
                        0,
                        math.sin(x.t * 6)
                    ) * 0.15),
                    0
                )
            end},
            coracao_partido = {depois = function(self, w, x)
                local h = cab(nil, x)
                local y = h.topo - 22
                desenhaCoracao(
                    nil,
                    w,
                    x.x - 4,
                    y,
                    3,
                    -1,
                    "#a83030"
                )
                desenhaCoracao(
                    nil,
                    w,
                    x.x + 4,
                    y + 2,
                    3,
                    1,
                    "#a83030"
                )
            end},
            brilho = __ord(
                {
                    antes = function(self, w, x)
                        local h = cab(nil, x)
                        w:save()
                        w.globalCompositeOperation = "lighter"
                        local g = w:createRadialGradient(
                            x.x,
                            x.y - h.alt / 2,
                            4,
                            x.x,
                            x.y - h.alt / 2,
                            h.alt
                        )
                        g:addColorStop(
                            0,
                            ("rgba(255,220,120," .. tostring(0.35 + math.sin(x.t * 4) * 0.1)) .. ")"
                        )
                        g:addColorStop(1, "rgba(255,220,120,0)")
                        w.fillStyle = g
                        w:fillRect(x.x - h.alt, x.y - h.alt * 1.6, h.alt * 2, h.alt * 2)
                        w:restore()
                    end,
                    depois = function(self, w, x)
                        local h = cab(nil, x)
                        do
                            local i = 0
                            while i < 6 do
                                if math.sin(x.t * 5 + i * 2) > 0.5 then
                                    local a = i * 1.1 + x.t
                                    local r = h.alt * 0.6
                                    P(
                                        nil,
                                        w,
                                        x.x + math.cos(a) * r,
                                        x.y - h.alt / 2 + math.sin(a) * r,
                                        2,
                                        6,
                                        "#fff3a8"
                                    )
                                end
                                i = i + 1
                            end
                        end
                    end
                },
                "antes,depois"
            ),
            chama = {antes = function(self, w, x)
                local h = cab(nil, x)
                do
                    local i = 0
                    while i < 14 do
                        local q = __mod(x.t * 1.6 + i / 14, 1)
                        local px = x.x + (hash(nil, i) - 0.5) * 30 * h.S
                        local py = x.y - q * h.alt * 1.2
                        w.globalAlpha = (1 - q) * 0.7
                        P(
                            nil,
                            w,
                            px,
                            py,
                            4 * h.S,
                            6 * h.S,
                            q < 0.4 and "#ffd23a" or (q < 0.7 and "#f08a24" or "#c43c3a")
                        )
                        i = i + 1
                    end
                end
                w.globalAlpha = 1
            end},
            mao = {depois = function(self, w, x)
                local h = cab(nil, x)
                local y = x.y - h.alt * 0.56
                local x0 = x.x + h.fx * 4 * h.S
                local k = math.min(1, x.t * 1.5)
                local x1 = x0 + h.fx * 22 * h.S * k
                local ____t_result_319
                local ____t_318 = __t
                local ____opt_316 = x.a.opts
                if ____opt_316 ~= nil then
                    ____opt_316 = ____opt_316.pele
                end
                __O[854] = ____opt_316
                if ____t_318(____opt_316) then
                    ____t_result_319 = __O[854]
                else
                    ____t_result_319 = "#c68a5e"
                end
                local pele = ____t_result_319
                local ____array_324 = __TS__SparseArrayNew(
                    nil,
                    w,
                    math.min(x0, x1),
                    y,
                    math.abs(x1 - x0) + 2,
                    6 * h.S
                )
                local ____t_result_323
                local ____t_322 = __t
                local ____opt_320 = x.a.opts
                if ____opt_320 ~= nil then
                    ____opt_320 = ____opt_320.manga
                end
                __O[855] = ____opt_320
                if ____t_322(____opt_320) then
                    ____t_result_323 = __O[855]
                else
                    ____t_result_323 = "#a8704a"
                end
                __TS__SparseArrayPush(____array_324, ____t_result_323)
                P(__TS__SparseArraySpread(____array_324))
                local ____w_326 = w
                local ____temp_325
                if h.fx < 0 then
                    ____temp_325 = 6 * h.S
                else
                    ____temp_325 = 0
                end
                P(
                    nil,
                    ____w_326,
                    x1 - ____temp_325,
                    y - h.S,
                    7 * h.S,
                    8 * h.S,
                    pele
                )
            end},
            silhueta = __ord(
                {
                    antes = function(self, w)
                        w:save()
                        w.filter = "brightness(0.1) saturate(0)"
                    end,
                    depois = function(self, w)
                        w:restore()
                    end
                },
                "antes,depois"
            ),
            fantasma = __ord(
                {
                    antes = function(self, w)
                        w:save()
                        w.globalAlpha = 0.5
                    end,
                    depois = function(self, w)
                        w:restore()
                    end
                },
                "antes,depois"
            )
        },
        "chorando,frio,treme,deitado,agarra_pernas,sacudindo,ajoelhado,celular,celular_mao,zzz,exclama,pergunta,raiva,suor,coracao,coracao_partido,brilho,chama,mao,silhueta,fantasma"
    )
    local sons = __ord(
        {
            vibrar = function(____, ____bindingPattern0)
                local tone
                tone = ____bindingPattern0.tone
                do
                    local i = 0
                    while i < 3 do
                        tone(
                            nil,
                            70,
                            68,
                            0.22,
                            "sawtooth",
                            i * 0.3,
                            0.9
                        )
                        i = i + 1
                    end
                end
            end,
            toque = function(____, ____bindingPattern0)
                local tone
                tone = ____bindingPattern0.tone
                __call(
                    __arrL({
                        659,
                        784,
                        988,
                        784,
                        659,
                        523
                    }, 6),
                    "forEach",
                    function(____, f, i) return tone(
                        nil,
                        f,
                        f,
                        0.16,
                        "sine",
                        i * 0.17,
                        0.8
                    ) end
                )
            end,
            coracao = function(____, ____bindingPattern0)
                local tone
                tone = ____bindingPattern0.tone
                tone(
                    nil,
                    70,
                    40,
                    0.18,
                    "sine",
                    0,
                    1.6
                )
                tone(
                    nil,
                    64,
                    36,
                    0.2,
                    "sine",
                    0.22,
                    1.3
                )
            end,
            quebra = function(____, ____bindingPattern0)
                local noise
                local tone
                tone = ____bindingPattern0.tone
                noise = ____bindingPattern0.noise
                noise(
                    nil,
                    0.5,
                    0.9,
                    0,
                    2400
                )
                tone(
                    nil,
                    1800,
                    600,
                    0.3,
                    "square",
                    0,
                    0.3
                )
                do
                    local i = 0
                    while i < 5 do
                        tone(
                            nil,
                            2400 - i * 300,
                            1600 - i * 200,
                            0.08,
                            "triangle",
                            0.1 + i * 0.06,
                            0.4
                        )
                        i = i + 1
                    end
                end
            end,
            aviao = function(____, ____bindingPattern0)
                local tone
                local noise
                noise = ____bindingPattern0.noise
                tone = ____bindingPattern0.tone
                noise(
                    nil,
                    2.6,
                    0.8,
                    0,
                    300
                )
                tone(
                    nil,
                    180,
                    420,
                    2.4,
                    "sawtooth",
                    0,
                    0.18
                )
            end,
            vento = function(____, ____bindingPattern0)
                local noise
                noise = ____bindingPattern0.noise
                noise(
                    nil,
                    2.2,
                    0.6,
                    0,
                    600
                )
            end,
            desliga = function(____, ____bindingPattern0)
                local tone
                tone = ____bindingPattern0.tone
                tone(
                    nil,
                    480,
                    480,
                    0.18,
                    "sine"
                )
                tone(
                    nil,
                    380,
                    380,
                    0.18,
                    "sine",
                    0.22
                )
                tone(
                    nil,
                    300,
                    300,
                    0.3,
                    "sine",
                    0.44
                )
            end,
            vs = function(____, ____bindingPattern0)
                local noise
                local tone
                tone = ____bindingPattern0.tone
                noise = ____bindingPattern0.noise
                tone(
                    nil,
                    90,
                    40,
                    0.5,
                    "square",
                    0,
                    1.4
                )
                noise(nil, 0.4, 1)
                tone(
                    nil,
                    880,
                    440,
                    0.3,
                    "sawtooth",
                    0.05,
                    0.4
                )
            end,
            poder = function(____, ____bindingPattern0)
                local tone
                tone = ____bindingPattern0.tone
                __call(
                    __arrL({
                        523,
                        659,
                        784,
                        1046,
                        1318
                    }, 5),
                    "forEach",
                    function(____, f, i) return tone(
                        nil,
                        f,
                        f * 1.01,
                        0.22,
                        "square",
                        i * 0.09,
                        0.7
                    ) end
                )
                tone(
                    nil,
                    1568,
                    1568,
                    0.6,
                    "sine",
                    0.5,
                    0.6
                )
            end,
            abraco = function(____, ____bindingPattern0)
                local tone
                tone = ____bindingPattern0.tone
                __call(
                    __arrL({349, 440, 523, 698}, 4),
                    "forEach",
                    function(____, f, i) return tone(
                        nil,
                        f,
                        f,
                        1.8,
                        "sine",
                        i * 0.04,
                        0.5
                    ) end
                )
            end,
            digitar = function(____, ____bindingPattern0)
                local noise
                noise = ____bindingPattern0.noise
                do
                    local i = 0
                    while i < 6 do
                        noise(
                            nil,
                            0.03,
                            0.5,
                            i * 0.09 + __mod(i, 2) * 0.03,
                            2000
                        )
                        i = i + 1
                    end
                end
            end,
            soluco = function(____, ____bindingPattern0)
                local tone
                tone = ____bindingPattern0.tone
                tone(
                    nil,
                    330,
                    260,
                    0.25,
                    "triangle",
                    0,
                    0.6
                )
                tone(
                    nil,
                    300,
                    220,
                    0.3,
                    "triangle",
                    0.35,
                    0.5
                )
            end
        },
        "vibrar,toque,coracao,quebra,aviao,vento,desliga,vs,poder,abraco,digitar,soluco"
    )
    local function NOTA(____, n)
        if not __t(n) then
            return 0
        end
        local m = __re_exec(
            __re("^([A-G])(#|b)?(\\d)$", ""),
            n
        )
        if not __t(m) then
            return 0
        end
        local i = __get(
            {
                C = -9,
                D = -7,
                E = -5,
                F = -4,
                G = -2,
                A = 0,
                B = 2
            },
            __get(m, 1)
        ) + (__get(m, 2) == "#" and 1 or (__get(m, 2) == "b" and -1 or 0)) + (__TS__Number(__get(m, 3)) - 4) * 12
        return 440 * 2 ^ (i / 12)
    end
    local function AC(____, s)
        return __call(s, "split", " ")
    end
    local TRILHAS = __ord(
        {
            saudade = __ord(
                {
                    bpm = 66,
                    timbre = "sine",
                    arp = "triangle",
                    vol = 0.9,
                    bat = nil,
                    comp = __arrL(
                        {
                            __arrL(
                                {
                                    AC(nil, "A3 C4 E4"),
                                    "A2",
                                    __arrL({
                                        "E5",
                                        0,
                                        "D5",
                                        "C5",
                                        "B4",
                                        0,
                                        "C5",
                                        0
                                    }, 8)
                                },
                                3
                            ),
                            __arrL(
                                {
                                    AC(nil, "F3 A3 C4"),
                                    "F2",
                                    __arrL({
                                        "A4",
                                        0,
                                        0,
                                        "C5",
                                        "E5",
                                        0,
                                        "D5",
                                        0
                                    }, 8)
                                },
                                3
                            ),
                            __arrL(
                                {
                                    AC(nil, "C4 E4 G4"),
                                    "C3",
                                    __arrL({
                                        "G4",
                                        0,
                                        "E5",
                                        "D5",
                                        "C5",
                                        0,
                                        "B4",
                                        0
                                    }, 8)
                                },
                                3
                            ),
                            __arrL(
                                {
                                    AC(nil, "G3 B3 D4"),
                                    "G2",
                                    __arrL({
                                        "D5",
                                        0,
                                        0,
                                        "B4",
                                        "G4",
                                        0,
                                        0,
                                        0
                                    }, 8)
                                },
                                3
                            ),
                            __arrL(
                                {
                                    AC(nil, "A3 C4 E4"),
                                    "A2",
                                    __arrL({
                                        "E5",
                                        0,
                                        "G5",
                                        "E5",
                                        "D5",
                                        0,
                                        "C5",
                                        0
                                    }, 8)
                                },
                                3
                            ),
                            __arrL(
                                {
                                    AC(nil, "F3 A3 C4"),
                                    "F2",
                                    __arrL({
                                        "C5",
                                        0,
                                        "D5",
                                        "E5",
                                        "F5",
                                        0,
                                        "E5",
                                        0
                                    }, 8)
                                },
                                3
                            ),
                            __arrL(
                                {
                                    AC(nil, "C4 E4 G4"),
                                    "C3",
                                    __arrL({
                                        "E5",
                                        0,
                                        "D5",
                                        "C5",
                                        "G4",
                                        0,
                                        "A4",
                                        0
                                    }, 8)
                                },
                                3
                            ),
                            __arrL(
                                {
                                    AC(nil, "E3 G#3 B3"),
                                    "E2",
                                    __arrL({
                                        "B4",
                                        0,
                                        0,
                                        0,
                                        "G#4",
                                        0,
                                        0,
                                        0
                                    }, 8)
                                },
                                3
                            )
                        },
                        8
                    )
                },
                "bpm,timbre,arp,vol,bat,comp"
            ),
            flashback = __ord(
                {
                    bpm = 92,
                    timbre = "sine",
                    arp = "sine",
                    sino = true,
                    vol = 0.8,
                    bat = nil,
                    comp = __arrL(
                        {
                            __arrL(
                                {
                                    AC(nil, "C5 E5 G5"),
                                    "C3",
                                    __arrL({
                                        "E6",
                                        0,
                                        0,
                                        0,
                                        "D6",
                                        0,
                                        "C6",
                                        0
                                    }, 8)
                                },
                                3
                            ),
                            __arrL(
                                {
                                    AC(nil, "A4 C5 E5"),
                                    "A2",
                                    __arrL({
                                        "C6",
                                        0,
                                        0,
                                        0,
                                        "B5",
                                        0,
                                        "A5",
                                        0
                                    }, 8)
                                },
                                3
                            ),
                            __arrL(
                                {
                                    AC(nil, "F4 A4 C5"),
                                    "F2",
                                    __arrL({
                                        "A5",
                                        0,
                                        "C6",
                                        0,
                                        "F6",
                                        0,
                                        "E6",
                                        0
                                    }, 8)
                                },
                                3
                            ),
                            __arrL(
                                {
                                    AC(nil, "G4 B4 D5"),
                                    "G2",
                                    __arrL({
                                        "D6",
                                        0,
                                        0,
                                        0,
                                        "G5",
                                        0,
                                        0,
                                        0
                                    }, 8)
                                },
                                3
                            )
                        },
                        4
                    )
                },
                "bpm,timbre,arp,sino,vol,bat,comp"
            ),
            tensao = __ord(
                {
                    bpm = 58,
                    timbre = "triangle",
                    arp = nil,
                    drone = true,
                    vol = 0.9,
                    bat = "k.k.....",
                    comp = __arrL(
                        {
                            __arrL(
                                {
                                    AC(nil, "D3 F3 A3"),
                                    "D2",
                                    __arrL({
                                        0,
                                        0,
                                        0,
                                        0,
                                        "A4",
                                        0,
                                        "Bb4",
                                        0
                                    }, 8)
                                },
                                3
                            ),
                            __arrL(
                                {
                                    AC(nil, "D3 F3 Bb3"),
                                    "D2",
                                    __arrL({
                                        0,
                                        0,
                                        0,
                                        0,
                                        "A4",
                                        0,
                                        0,
                                        0
                                    }, 8)
                                },
                                3
                            ),
                            __arrL(
                                {
                                    AC(nil, "C3 E3 G3"),
                                    "C2",
                                    __arrL({
                                        0,
                                        0,
                                        0,
                                        0,
                                        "G4",
                                        0,
                                        "F4",
                                        0
                                    }, 8)
                                },
                                3
                            ),
                            __arrL(
                                {
                                    AC(nil, "Db3 F3 A3"),
                                    "Db2",
                                    __arrL({
                                        0,
                                        0,
                                        0,
                                        0,
                                        "E4",
                                        0,
                                        0,
                                        0
                                    }, 8)
                                },
                                3
                            )
                        },
                        4
                    )
                },
                "bpm,timbre,arp,drone,vol,bat,comp"
            ),
            vilao = __ord(
                {
                    bpm = 136,
                    timbre = "square",
                    arp = nil,
                    riff = true,
                    vol = 0.7,
                    bat = "k.h.s.hk",
                    comp = __arrL(
                        {
                            __arrL(
                                {
                                    AC(nil, "E3 G3 B3"),
                                    "E2",
                                    __arrL({
                                        "E5",
                                        0,
                                        "G5",
                                        "E5",
                                        0,
                                        "B4",
                                        "D5",
                                        "E5"
                                    }, 8)
                                },
                                3
                            ),
                            __arrL(
                                {
                                    AC(nil, "C3 E3 G3"),
                                    "C2",
                                    __arrL({
                                        "E5",
                                        0,
                                        "G5",
                                        "A5",
                                        0,
                                        "G5",
                                        "E5",
                                        0
                                    }, 8)
                                },
                                3
                            ),
                            __arrL(
                                {
                                    AC(nil, "D3 F#3 A3"),
                                    "D2",
                                    __arrL({
                                        "F#5",
                                        0,
                                        "A5",
                                        "F#5",
                                        0,
                                        "D5",
                                        "E5",
                                        "F#5"
                                    }, 8)
                                },
                                3
                            ),
                            __arrL(
                                {
                                    AC(nil, "B2 D#3 F#3"),
                                    "B1",
                                    __arrL({
                                        "D#5",
                                        0,
                                        "F#5",
                                        "B5",
                                        0,
                                        "A5",
                                        "F#5",
                                        "D#5"
                                    }, 8)
                                },
                                3
                            )
                        },
                        4
                    )
                },
                "bpm,timbre,arp,riff,vol,bat,comp"
            ),
            conquista = __ord(
                {
                    bpm = 108,
                    timbre = "square",
                    arp = "triangle",
                    pizz = true,
                    vol = 0.6,
                    bat = "k.h.k.h.",
                    comp = __arrL(
                        {
                            __arrL(
                                {
                                    AC(nil, "C4 E4 G4"),
                                    "C3",
                                    __arrL({
                                        "C5",
                                        "E5",
                                        "G5",
                                        "E5",
                                        "C5",
                                        0,
                                        "G4",
                                        0
                                    }, 8)
                                },
                                3
                            ),
                            __arrL(
                                {
                                    AC(nil, "F3 A3 C4"),
                                    "F2",
                                    __arrL({
                                        "A4",
                                        "C5",
                                        "F5",
                                        "C5",
                                        "A4",
                                        0,
                                        "F4",
                                        0
                                    }, 8)
                                },
                                3
                            ),
                            __arrL(
                                {
                                    AC(nil, "G3 B3 D4"),
                                    "G2",
                                    __arrL({
                                        "B4",
                                        "D5",
                                        "G5",
                                        "D5",
                                        "B4",
                                        0,
                                        "A4",
                                        "B4"
                                    }, 8)
                                },
                                3
                            ),
                            __arrL(
                                {
                                    AC(nil, "C4 E4 G4"),
                                    "C3",
                                    __arrL({
                                        "C5",
                                        0,
                                        "G4",
                                        0,
                                        "C5",
                                        0,
                                        0,
                                        0
                                    }, 8)
                                },
                                3
                            )
                        },
                        4
                    )
                },
                "bpm,timbre,arp,pizz,vol,bat,comp"
            ),
            final = __ord(
                {
                    bpm = 70,
                    timbre = "sine",
                    arp = "triangle",
                    pad = true,
                    vol = 1,
                    bat = nil,
                    comp = __arrL(
                        {
                            __arrL(
                                {
                                    AC(nil, "F3 A3 C4"),
                                    "F2",
                                    __arrL({
                                        "A4",
                                        0,
                                        "C5",
                                        0,
                                        "F5",
                                        0,
                                        "E5",
                                        0
                                    }, 8)
                                },
                                3
                            ),
                            __arrL(
                                {
                                    AC(nil, "C3 E3 G3"),
                                    "C2",
                                    __arrL({
                                        "E5",
                                        0,
                                        "D5",
                                        0,
                                        "C5",
                                        0,
                                        "G4",
                                        0
                                    }, 8)
                                },
                                3
                            ),
                            __arrL(
                                {
                                    AC(nil, "D3 F3 A3"),
                                    "D2",
                                    __arrL({
                                        "F4",
                                        0,
                                        "A4",
                                        0,
                                        "D5",
                                        0,
                                        "C5",
                                        0
                                    }, 8)
                                },
                                3
                            ),
                            __arrL(
                                {
                                    AC(nil, "Bb2 D3 F3"),
                                    "Bb1",
                                    __arrL({
                                        "D5",
                                        0,
                                        "C5",
                                        "Bb4",
                                        "A4",
                                        0,
                                        "G4",
                                        0
                                    }, 8)
                                },
                                3
                            ),
                            __arrL(
                                {
                                    AC(nil, "F3 A3 C4"),
                                    "F2",
                                    __arrL({
                                        "A4",
                                        0,
                                        "C5",
                                        0,
                                        "F5",
                                        0,
                                        "G5",
                                        0
                                    }, 8)
                                },
                                3
                            ),
                            __arrL(
                                {
                                    AC(nil, "C3 E3 G3"),
                                    "C2",
                                    __arrL({
                                        "G5",
                                        0,
                                        "E5",
                                        0,
                                        "C5",
                                        0,
                                        "E5",
                                        0
                                    }, 8)
                                },
                                3
                            ),
                            __arrL(
                                {
                                    AC(nil, "Bb2 D3 F3"),
                                    "Bb1",
                                    __arrL({
                                        "F5",
                                        0,
                                        "D5",
                                        0,
                                        "Bb4",
                                        0,
                                        "D5",
                                        0
                                    }, 8)
                                },
                                3
                            ),
                            __arrL(
                                {
                                    AC(nil, "C3 E3 G3"),
                                    "C2",
                                    __arrL({
                                        "E5",
                                        0,
                                        0,
                                        0,
                                        "C5",
                                        0,
                                        0,
                                        0
                                    }, 8)
                                },
                                3
                            )
                        },
                        8
                    )
                },
                "bpm,timbre,arp,pad,vol,bat,comp"
            )
        },
        "saudade,flashback,tensao,vilao,conquista,final"
    )
    local musica = (function()
        local parar, ac, master, atual, timer
        function parar(self, fade)
            if fade == nil then
                fade = 0.8
            end
            if not __t(master) then
                atual = nil
                return
            end
            local m = master
            do
                pcall(function()
                    m.gain:cancelScheduledValues(ac.currentTime)
                    m.gain:setValueAtTime(m.gain.value, ac.currentTime)
                    m.gain:linearRampToValueAtTime(0, ac.currentTime + fade)
                    window:setTimeout(
                        function()
                            do
                                pcall(function()
                                    m:disconnect()
                                end)
                            end
                        end,
                        fade * 1000 + 200
                    )
                end)
            end
            master = nil
            atual = nil
            window:clearInterval(timer)
        end
        ac = nil
        master = nil
        atual = nil
        local prox = 0
        local passo = 0
        timer = 0
        local ultimo = 0
        local function ligado()
            local ____t_333 = __t
            local ____t_result_332
            local ____t_331 = __t
            local ____t_result_330
            local ____t_329 = __t
            local ____opt_327 = window.Game
            if ____opt_327 ~= nil then
                ____opt_327 = ____opt_327.soundOn
            end
            __O[856] = ____opt_327
            if ____t_329(____opt_327) then
                ____t_result_330 = not __t(window.Game:soundOn())
            else
                ____t_result_330 = __O[856]
            end
            __O[857] = ____t_result_330
            if ____t_331(____t_result_330) then
                ____t_result_332 = not __t(window.__somCutscene)
            else
                ____t_result_332 = __O[857]
            end
            return not ____t_333(____t_result_332)
        end
        local function nota(self, f, t0, dur, tipo, vol, o)
            if o == nil then
                o = {}
            end
            if not __t(f) then
                return
            end
            local osc = ac:createOscillator()
            local g = ac:createGain()
            osc.type = tipo
            osc.frequency:setValueAtTime(f, t0)
            if __t(o.vib) then
                local l = ac:createOscillator()
                local lg = ac:createGain()
                l.frequency.value = 5
                lg.gain.value = f * 0.006
                l:connect(lg)
                lg:connect(osc.frequency)
                l:start(t0)
                l:stop(__add(t0, dur) + 0.1)
            end
            local ____o_at_334 = o.at
            if ____o_at_334 == nil then
                ____o_at_334 = 0.02
            end
            local at = ____o_at_334
            g.gain:setValueAtTime(0, t0)
            g.gain:linearRampToValueAtTime(
                vol,
                __add(t0, at)
            )
            local ____self_337 = g.gain
            local ____self_337_exponentialRampToValueAtTime_338 = ____self_337.exponentialRampToValueAtTime
            local ____vol_336 = vol
            local ____o_sus_335 = o.sus
            if ____o_sus_335 == nil then
                ____o_sus_335 = 0.5
            end
            ____self_337_exponentialRampToValueAtTime_338(
                ____self_337,
                math.max(0.0001, ____vol_336 * ____o_sus_335),
                t0 + math.max(at + 0.01, dur * 0.6)
            )
            local ____self_342 = g.gain
            local ____self_342_exponentialRampToValueAtTime_343 = ____self_342.exponentialRampToValueAtTime
            local ____add_341 = __add
            local ____add_result_340 = __add(t0, dur)
            local ____o_rel_339 = o.rel
            if ____o_rel_339 == nil then
                ____o_rel_339 = 0.25
            end
            ____self_342_exponentialRampToValueAtTime_343(
                ____self_342,
                0.0001,
                ____add_341(____add_result_340, ____o_rel_339)
            )
            local n = osc
            if __t(o.lp) then
                local fl = ac:createBiquadFilter()
                fl.type = "lowpass"
                fl.frequency.value = o.lp
                osc:connect(fl)
                n = fl
            end
            n:connect(g)
            g:connect(master)
            osc:start(t0)
            local ____osc_stop_347 = osc.stop
            local ____add_346 = __add
            local ____add_result_345 = __add(t0, dur)
            local ____o_rel_344 = o.rel
            if ____o_rel_344 == nil then
                ____o_rel_344 = 0.25
            end
            ____osc_stop_347(
                osc,
                ____add_346(____add_result_345, ____o_rel_344) + 0.05
            )
        end
        local function ruido(self, t0, dur, vol, hp)
            local len = math.floor(ac.sampleRate * dur)
            local b = ac:createBuffer(1, len, ac.sampleRate)
            local d = b:getChannelData(0)
            do
                local i = 0
                while i < len do
                    __set(
                        d,
                        i,
                        (math.random() * 2 - 1) * (1 - i / len)
                    )
                    i = i + 1
                end
            end
            local s = ac:createBufferSource()
            local g = ac:createGain()
            local f = ac:createBiquadFilter()
            f.type = "highpass"
            f.frequency.value = hp
            s.buffer = b
            g.gain.value = vol
            s:connect(f)
            f:connect(g)
            g:connect(master)
            s:start(t0)
        end
        local function agendar(self)
            local tr = __get(TRILHAS, atual)
            if not __t(tr) then
                return
            end
            local dt = 60 / tr.bpm / 2
            while __lt(prox, ac.currentTime + 0.25) do
                local bar = __get(
                    tr.comp,
                    __mod(
                        math.floor(passo / 8),
                        __len(tr.comp)
                    )
                )
                local acorde, baixo, mel = table.unpack(bar, 1, 3)
                local i = __mod(passo, 8)
                local t0 = prox
                if i == 0 then
                    nota(
                        nil,
                        NOTA(nil, baixo),
                        t0,
                        dt * (__t(tr.riff) and 1 or 7),
                        "triangle",
                        0.26,
                        {at = 0.03, lp = 600}
                    )
                    local ____t_349 = __t
                    local ____t_result_348
                    if __t(tr.pad) then
                        ____t_result_348 = tr.pad
                    else
                        ____t_result_348 = tr.drone
                    end
                    if ____t_349(____t_result_348) then
                        for ____, n in __iterar((acorde)) do
                            nota(
                                nil,
                                NOTA(nil, n),
                                t0,
                                dt * 8,
                                "sawtooth",
                                __t(tr.drone) and 0.05 or 0.035,
                                {
                                    at = dt * 2,
                                    lp = __t(tr.drone) and 500 or 900,
                                    sus = 0.9,
                                    rel = 1
                                }
                            )
                        end
                    end
                end
                if __t(tr.riff) then
                    nota(
                        nil,
                        NOTA(nil, baixo) * (__t(__mod(i, 2)) and 2 or 1),
                        t0,
                        dt * 0.8,
                        "square",
                        0.08,
                        {at = 0.005, lp = 1200, sus = 0.3}
                    )
                end
                if __t(tr.arp) then
                    local n = __get(
                        acorde,
                        __mod(
                            __mod(i, 4) == 3 and 1 or __mod(i, 4),
                            __len(acorde)
                        )
                    )
                    nota(
                        nil,
                        NOTA(nil, n) * (__t(tr.sino) and 2 or 1),
                        t0,
                        dt * (__t(tr.pizz) and 0.5 or 1.6),
                        tr.arp,
                        __t(tr.sino) and 0.07 or 0.08,
                        {
                            at = 0.005,
                            sus = 0.3,
                            rel = __t(tr.sino) and 0.9 or 0.3
                        }
                    )
                end
                if __t(__get(mel, i)) then
                    local d = 1
                    while __t(i + d < 8 and not __t(__get(mel, i + d))) do
                        d = d + 1
                    end
                    nota(
                        nil,
                        NOTA(
                            nil,
                            __get(mel, i)
                        ),
                        t0,
                        dt * d * (__t(tr.pizz) and 0.55 or 0.95),
                        tr.timbre,
                        tr.timbre == "square" and 0.06 or 0.14,
                        {
                            at = __t(tr.pizz) and 0.005 or 0.04,
                            vib = not __t(tr.pizz) and tr.timbre == "sine",
                            sus = 0.6,
                            rel = 0.4,
                            lp = tr.timbre == "square" and 2400 or 0
                        }
                    )
                    if __t(tr.pad) then
                        nota(
                            nil,
                            NOTA(
                                nil,
                                __get(mel, i)
                            ) / 2,
                            t0,
                            dt * d,
                            "triangle",
                            0.05,
                            {at = 0.05}
                        )
                    end
                end
                local b = __getq(tr.bat, i)
                if b == "k" then
                    nota(
                        nil,
                        90,
                        t0,
                        0.14,
                        "sine",
                        0.5,
                        {at = 0.002, sus = 0.1, rel = 0.05}
                    )
                elseif b == "s" then
                    ruido(
                        nil,
                        t0,
                        0.14,
                        0.25,
                        1500
                    )
                elseif b == "h" then
                    ruido(
                        nil,
                        t0,
                        0.04,
                        0.12,
                        6000
                    )
                end
                prox = prox + dt
                passo = passo + 1
            end
        end
        local function tocar(self, id)
            if id == atual then
                return
            end
            parar(nil, 0.9)
            local ____t_353 = __t
            local ____t_result_352
            local ____t_351 = __t
            local ____temp_350 = not __t(id) or not __t(__get(TRILHAS, id))
            __O[858] = ____temp_350
            if ____t_351(____temp_350) then
                ____t_result_352 = __O[858]
            else
                ____t_result_352 = not __t(ligado(nil))
            end
            if ____t_353(____t_result_352) then
                return
            end
            do
                local function ____catch(e)
                    return true
                end
                local ____try, ____hasReturned, ____returnValue = pcall(function()
                    local ____t_result_356
                    if __t(ac) then
                        ____t_result_356 = ac
                    else
                        local ____newExpr_355 = __newExpr
                        local ____t_result_354
                        if __t(window.AudioContext) then
                            ____t_result_354 = window.AudioContext
                        else
                            ____t_result_354 = window.webkitAudioContext
                        end
                        ____t_result_356 = ____newExpr_355(____t_result_354)
                    end
                    ac = ____t_result_356
                    if ac.state == "suspended" then
                        ac:resume()
                    end
                end)
                if not ____try then
                    ____hasReturned, ____returnValue = ____catch(____hasReturned)
                end
                if ____hasReturned then
                    return ____returnValue
                end
            end
            master = ac:createGain()
            local ____t_result_359
            local ____t_358 = __t
            local ____get_result_vol_357 = __get(TRILHAS, id).vol
            __O[859] = ____get_result_vol_357
            if ____t_358(____get_result_vol_357) then
                ____t_result_359 = __O[859]
            else
                ____t_result_359 = 1
            end
            local ____temp_366 = 0.5 * ____t_result_359
            local ____opt_362 = window.DarocaAudio
            if ____opt_362 ~= nil then
                ____opt_362 = ____opt_362.music
            end
            local ____opt_result_364
            if ____opt_362 ~= nil then
                ____opt_result_364 = ____opt_362(____opt_362)
            end
            local ____opt_result_364_365 = ____opt_result_364
            if ____opt_result_364_365 == nil then
                ____opt_result_364_365 = 1
            end
            local vol = ____temp_366 * ____opt_result_364_365
            master.gain:setValueAtTime(0, ac.currentTime)
            master.gain:linearRampToValueAtTime(vol, ac.currentTime + 1.2)
            local eco = ac:createDelay()
            eco.delayTime.value = 0.28
            local fb = ac:createGain()
            fb.gain.value = 0.28
            local sai = ac:createGain()
            sai.gain.value = 0.7
            master:connect(sai)
            sai:connect(ac.destination)
            master:connect(eco)
            eco:connect(fb)
            fb:connect(eco)
            eco:connect(ac.destination)
            atual = id
            passo = 0
            prox = ac.currentTime + 0.08
            window:clearInterval(timer)
            timer = window:setInterval(agendar, 60)
            agendar(nil)
        end
        window:setInterval(
            function()
                local ____t_368 = __t
                local ____t_result_367
                if __t(atual) then
                    ____t_result_367 = window.performance:now() - ultimo > 700
                else
                    ____t_result_367 = atual
                end
                if ____t_368(____t_result_367) then
                    parar(nil, 1.2)
                end
            end,
            300
        )
        return {
            tocar = tocar,
            parar = parar,
            quadro = function()
                ultimo = window.performance:now()
            end,
            atual = function() return atual end,
            lista = function() return __keys(TRILHAS) end
        }
    end)(nil)
    local gancho = {quadro = function(self, s, sc, shot)
        musica:quadro()
        local ____t_373 = __t
        local ____t_372 = __t
        local ____opt_result_371
        if sc ~= nil then
            ____opt_result_371 = sc.raw
        end
        if ____t_373(not ____t_372(____opt_result_371) or not __re_test(
            __re("^c2_", ""),
            sc.id
        )) then
            return
        end
        if __t(shot.scene == 14 or shot.scene == 16) then
            local ____t_376 = __t
            local ____opt_374 = shot.raw
            if ____opt_374 ~= nil then
                ____opt_374 = ____opt_374.engarrafamento
            end
            local quer = not not ____t_376(____opt_374)
            do
                pcall(function()
                    local ____opt_379 = window.CampanhaCamadas
                    if ____opt_379 ~= nil then
                        ____opt_379 = ____opt_379.engarrafado
                    end
                    local ____opt_result_381
                    if ____opt_379 ~= nil then
                        ____opt_result_381 = ____opt_379(____opt_379, shot.scene)
                    end
                    if ____opt_result_381 ~= quer then
                        local ____opt_384 = window.CampanhaCamadas
                        if ____opt_384 ~= nil then
                            ____opt_384 = ____opt_384.engarrafamento
                        end
                        if ____opt_384 ~= nil then
                            ____opt_384(____opt_384, shot.scene, quer)
                        end
                    end
                end)
            end
        end
        local ____sc_raw_trilha_386 = sc.raw.trilha
        if ____sc_raw_trilha_386 == nil then
            ____sc_raw_trilha_386 = nil
        end
        local quer = ____sc_raw_trilha_386
        for ____, sh in __iterar((sc.shots)) do
            if __gt(sh.index, shot.index) then
                break
            end
            local ____t_388 = __t
            local ____t_result_387
            if __t(sh.raw) then
                ____t_result_387 = __fcall(__hasOwnV, sh.raw, "trilha")
            else
                ____t_result_387 = sh.raw
            end
            if ____t_388(____t_result_387) then
                quer = sh.raw.trilha
            end
        end
        local ____t_394 = __t
        local ____opt_391 = window.GameMusic
        if ____opt_391 ~= nil then
            ____opt_391 = ____opt_391.isPlaying
        end
        local ____opt_result_393
        if ____opt_391 ~= nil then
            ____opt_result_393 = ____opt_391(____opt_391)
        end
        if ____t_394(____opt_result_393) then
            quer = nil
        end
        musica:tocar(quer)
    end}
    window.Roteiro:estender(__ord({
        cenarios = cenarios,
        nomes = nomes,
        fundos = fundos,
        efeitos = efeitos,
        anims = anims,
        sons = sons,
        gancho = gancho
    }, "cenarios,nomes,fundos,efeitos,anims,sons,gancho"))
    window:setTimeout(
        function()
            do
                pcall(function()
                    local ____iter_402 = __iter
                    local ____t_result_401
                    local ____t_400 = __t
                    local ____opt_397 = window.CampanhaPoderes
                    if ____opt_397 ~= nil then
                        ____opt_397 = ____opt_397.lista
                    end
                    local ____opt_result_399
                    if ____opt_397 ~= nil then
                        ____opt_result_399 = ____opt_397(____opt_397)
                    end
                    __O[860] = ____opt_result_399
                    if ____t_400(____opt_result_399) then
                        ____t_result_401 = __O[860]
                    else
                        ____t_result_401 = __arrL({}, 0)
                    end
                    for ____, p in __TS__Iterator(____iter_402(____t_result_401)) do
                        icone(nil, p.id)
                    end
                end)
            end
        end,
        400
    )
    local ORDEM = __arrL({
        "c2_abertura",
        "c2_aeroporto",
        "c2_voo",
        "c2_chegada",
        "c2_primeira_noite",
        "c2_vilao_creuza",
        "c2_derrota_creuza",
        "c2_vilao_tonhao",
        "c2_derrota_tonhao",
        "c2_vilao_valdomiro",
        "c2_derrota_valdomiro",
        "c2_vilao_kaua",
        "c2_derrota_kaua",
        "c2_vilao_barao",
        "c2_derrota_barao",
        "c2_vilao_breno",
        "c2_derrota_breno",
        "c2_vilao_gemeos",
        "c2_derrota_gemeos",
        "c2_vilao_fred",
        "c2_derrota_fred",
        "c2_centro",
        "c2_final",
        "c2_creditos"
    }, 24)
    local gal = nil
    local tocando = nil
    local function aberta()
        local ____t_404 = __t
        local ____t_result_403
        if __t(gal) then
            ____t_result_403 = not __t(gal.hidden)
        else
            ____t_result_403 = gal
        end
        local ____temp_407 = not not ____t_404(____t_result_403)
        if not ____temp_407 then
            local ____t_406 = __t
            local ____t_result_405
            if __t(tocando) then
                ____t_result_405 = tocando.isConnected
            else
                ____t_result_405 = tocando
            end
            ____temp_407 = not not ____t_406(____t_result_405)
        end
        return ____temp_407
    end
    local function galeria(self)
        if not __t(gal) then
            gal = window.document:createElement("div")
            gal.className = "c2-galeria"
            gal.hidden = true
            window.document.body:appendChild(gal)
            local st = window.document:createElement("style")
            st.textContent = ".c2-galeria{position:fixed;inset:0;z-index:2147483400;background:#0b0d14ee;font-family:Pixel,monospace;color:#f6ead0;display:flex;flex-direction:column;align-items:center;padding:20px;overflow:auto}.c2-galeria[hidden]{display:none}.c2-galeria h2{font-size:16px;color:#ffd98a;margin:6px 0 4px}.c2-galeria p{font-size:9px;color:#c8b48a;margin:0 0 14px;text-align:center;max-width:620px;line-height:1.6}.c2-galeria .g{display:grid;grid-template-columns:repeat(auto-fill,minmax(210px,1fr));gap:8px;width:min(900px,96vw)}.c2-galeria button{font:inherit;font-size:10px;text-align:left;padding:10px 12px;background:#2a1e14;color:#f6ead0;border:3px solid #8a6a3a;box-shadow:0 4px 0 #120c08;cursor:pointer;line-height:1.5}.c2-galeria button:hover,.c2-galeria button:focus-visible{background:#e8c66a;color:#2a1e14;outline:none}.c2-galeria button small{display:block;font-size:8px;opacity:.75}.c2-galeria .x{position:fixed;top:12px;right:14px;text-align:center}"
            window.document.head:appendChild(st)
        end
        local lista = __call(
            __call(
                ORDEM,
                "filter",
                function(____, id) return __call(window.Roteiro, "has", id) end
            ),
            "concat",
            __call(
                window.Roteiro:list(),
                "filter",
                function(____, id) return __re_test(
                    __re("^c2_", ""),
                    id
                ) and not __t(__call(ORDEM, "includes", id)) end
            )
        )
        gal.innerHTML = "<button type=\"button\" class=\"x\">✕ FECHAR</button><h2>CUTSCENES · CAMPANHA 2</h2><p>Clique numa cutscene para assistir. Clique ou Enter avança as falas, Esc volta. A trilha e os sons tocam aqui mesmo com o som do jogo desligado.</p><div class=\"g\"></div>"
        local g = gal:querySelector(".g")
        for ____, id in __iterar((lista)) do
            local sc = __call(window.Roteiro, "get", id)
            local b = window.document:createElement("button")
            b.type = "button"
            local ____re_replace_413 = __re_replace
            local ____t_result_412
            local ____t_411 = __t
            local ____opt_result_410
            if sc ~= nil then
                ____opt_result_410 = sc.title
            end
            __O[861] = ____opt_result_410
            if ____t_411(____opt_result_410) then
                ____t_result_412 = __O[861]
            else
                ____t_result_412 = id
            end
            local ____re_replace_413_result_415 = ____re_replace_413(
                ____t_result_412,
                __re("[<>&]", "g"),
                ""
            )
            local ____t_result_414
            if __t(sc) then
                ____t_result_414 = __add(
                    __add(
                        __add(
                            __len(sc.beats),
                            " falas · ~"
                        ),
                        math.floor(sc.duration + 0.5)
                    ),
                    " s"
                )
            else
                ____t_result_414 = ""
            end
            b.innerHTML = ((tostring(____re_replace_413_result_415) .. "<small>") .. tostring(____t_result_414)) .. "</small>"
            b:addEventListener(
                "click",
                function()
                    window.__somCutscene = true
                    local antes = __TS__New(
                        Set,
                        window.document:querySelectorAll("body > canvas")
                    )
                    window.Roteiro:preview(id)
                    for ____, cv in __iterar((window.document:querySelectorAll("body > canvas"))) do
                        if not __t(__call(antes, "has", cv)) then
                            cv.style.zIndex = "2147483500"
                            tocando = cv
                        end
                    end
                end
            )
            g:appendChild(b)
        end
        if not __t(__len(lista)) then
            g.innerHTML = "<p>Os roteiros ainda estão carregando...</p>"
        end
        gal:querySelector(".x"):addEventListener(
            "click",
            function()
                gal.hidden = true
                window.__somCutscene = false
                musica:parar()
            end
        )
        gal.hidden = false
    end
    window.CampanhaCutscenes = __ord(
        {
            galeria = galeria,
            aberta = aberta,
            ordem = function() return __call(ORDEM, "slice") end,
            musica = __ord({tocar = musica.tocar, parar = musica.parar, lista = musica.lista}, "tocar,parar,lista"),
            efeitos = function() return __keys(efeitos) end,
            fundos = function() return __keys(fundos) end,
            anims = function() return __keys(anims) end
        },
        "galeria,aberta,ordem,musica,efeitos,fundos,anims"
    )
end)(nil)
return ____exports
