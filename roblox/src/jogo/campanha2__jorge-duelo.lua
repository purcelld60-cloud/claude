--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __le, __gt, __ge, __mod, __ord, __arrL, __iterar, __t, __get, __arr, __len = __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__arr, __JSR.__len
local __call, __add, __iter, __assign, __arrayFrom = __JSR.__call, __JSR.__add, __JSR.__iter, __JSR.__assign, __JSR.__arrayFrom
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
    local pol, nuvem, rect
    function pol(self, c, p, cor)
        c.fillStyle = cor
        c:beginPath()
        c:moveTo(
            math.floor(__get(
                __get(p, 0),
                0
            ) + 0.5),
            math.floor(__get(
                __get(p, 0),
                1
            ) + 0.5)
        )
        do
            local i = 1
            while __lt(
                i,
                __len(p)
            ) do
                c:lineTo(
                    math.floor(__get(
                        __get(p, i),
                        0
                    ) + 0.5),
                    math.floor(__get(
                        __get(p, i),
                        1
                    ) + 0.5)
                )
                i = i + 1
            end
        end
        c:closePath()
        __call(c, "fill")
    end
    function nuvem(self, c, x, y, s, cor, luz)
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        c:scale(s, s)
        pol(
            nil,
            c,
            __arrL(
                {
                    __arrL({0, 8}, 2),
                    __arrL({6, 8}, 2),
                    __arrL({6, 5}, 2),
                    __arrL({16, 5}, 2),
                    __arrL({16, 0}, 2),
                    __arrL({23, 0}, 2),
                    __arrL({23, -3}, 2),
                    __arrL({35, -3}, 2),
                    __arrL({35, 1}, 2),
                    __arrL({44, 1}, 2),
                    __arrL({44, 5}, 2),
                    __arrL({55, 5}, 2),
                    __arrL({55, 8}, 2),
                    __arrL({65, 8}, 2),
                    __arrL({65, 12}, 2),
                    __arrL({0, 12}, 2)
                },
                16
            ),
            cor
        )
        rect(
            nil,
            c,
            17,
            0,
            7,
            2,
            luz
        )
        rect(
            nil,
            c,
            24,
            -3,
            10,
            2,
            luz
        )
        rect(
            nil,
            c,
            36,
            1,
            8,
            2,
            luz
        )
        c:restore()
    end
    local ____ = "use strict"
    local function clamp(____, v, l, r)
        return math.max(
            l,
            math.min(r, v)
        )
    end
    local formas = __arrL({
        "jorge",
        "jorge_gordo",
        "jorge_farpas",
        "jorge_aura",
        "jorge_promessa"
    }, 5)
    local escolhas = __arrL(
        {
            __arrL({0, 2, 4}, 3),
            __arrL({1, 3, 5}, 3),
            __arrL({0, 3, 5}, 3),
            __arrL({1, 2, 4}, 3)
        },
        4
    )
    local volta = 2.45
    local function meio(____, i)
        return i.x + i.w / 2
    end
    local function sob(____, i, x)
        return __ge(x, i.x - 4) and __le(
            x,
            __add(i.x, i.w) + 4
        )
    end
    local function maisPerto(self, ilhas, x)
        return __call(
            ilhas,
            "reduce",
            function(____, melhor, i)
                local ____t_result_4
                local ____t_3 = __t
                local ____t_result_2
                local ____t_1 = __t
                local ____temp_0 = i.estado ~= "ausente"
                __O[927] = ____temp_0
                if ____t_1(____temp_0) then
                    ____t_result_2 = not __t(melhor) or math.abs(meio(nil, i) - x) < math.abs(meio(nil, melhor) - x)
                else
                    ____t_result_2 = __O[927]
                end
                if ____t_3(____t_result_2) then
                    ____t_result_4 = i
                else
                    ____t_result_4 = melhor
                end
                return ____t_result_4
            end,
            nil
        )
    end
    local function mudar(self, f, fase, p)
        local desceu = not not __t(f.ceu)
        f.ceu = nil
        f.y = f.piso
        if fase ~= 4 then
            local ____t_6 = __t
            local ____t_result_5
            if __t(desceu) then
                ____t_result_5 = p
            else
                ____t_result_5 = desceu
            end
            if ____t_6(____t_result_5) then
                p.y = f.piso
                p.vy = 0
                p.ground = true
            end
            return
        end
        local passo = (f.r - f.l) / 6
        local ilhas = __arrayFrom(
            {length = 6},
            function(____, _, id) return {
                id = id,
                x = f.l + id * passo + 11,
                w = passo - 22,
                y = f.piso,
                anterior = f.piso,
                estado = "inteira",
                resto = 0
            } end
        )
        f.ceu = {tempo = 0, rodada = 0, ilhas = ilhas}
        if __t(p) then
            local i = maisPerto(nil, ilhas, p.x)
            p.x = clamp(
                nil,
                p.x,
                i.x + 9,
                __add(i.x, i.w) - 9
            )
            p.y = i.y
            p.vy = 0
            p.ground = true
        end
    end
    local function avancar(self, f, dt, p)
        local ceu = f.ceu
        ceu.tempo = __add(ceu.tempo, dt)
        local v = clamp(nil, ceu.tempo / 1.25, 0, 1)
        local subida = v * v * (3 - 2 * v)
        for ____, i in __iterar((ceu.ilhas)) do
            local ____t_result_13
            local ____t_12 = __t
            local ____t_result_11
            local ____t_10 = __t
            local ____t_result_9
            local ____t_8 = __t
            local ____t_result_7
            if __t(p.ground) then
                ____t_result_7 = __ge(p.vy, 0)
            else
                ____t_result_7 = p.ground
            end
            __O[928] = ____t_result_7
            if ____t_8(____t_result_7) then
                ____t_result_9 = i.estado ~= "ausente"
            else
                ____t_result_9 = __O[928]
            end
            __O[929] = ____t_result_9
            if ____t_10(____t_result_9) then
                ____t_result_11 = sob(nil, i, p.x)
            else
                ____t_result_11 = __O[929]
            end
            __O[930] = ____t_result_11
            if ____t_12(____t_result_11) then
                ____t_result_13 = math.abs(p.y - i.y) < 2
            else
                ____t_result_13 = __O[930]
            end
            local levando = ____t_result_13
            i.anterior = i.y
            i.y = f.piso - subida * (74 + 25 * math.sin(ceu.tempo * 1.12 + i.id * 0.94))
            if __t(levando) then
                p.y = p.y + (i.y - i.anterior)
            end
            if i.estado == "ausente" then
                i.resto = math.max(0, i.resto - dt)
                if i.resto == 0 then
                    i.estado = "inteira"
                end
            end
        end
        for ____, o in __iterar((f.objetos)) do
            if o.ilha ~= nil then
                local ____temp_14 = __get(ceu.ilhas, o.ilha).y - 5
                o.y1 = ____temp_14
                o.y0 = ____temp_14
            end
        end
    end
    local function pousar(self, f, p, antes, ferir)
        if __ge(p.vy, 0) then
            for ____, i in __iterar((f.ceu.ilhas)) do
                do
                    local ____t_20 = __t
                    local ____t_result_19
                    local ____t_18 = __t
                    local ____t_result_17
                    local ____t_16 = __t
                    local ____temp_15 = i.estado == "ausente" or not __t(sob(nil, i, p.x))
                    __O[931] = ____temp_15
                    if ____t_16(____temp_15) then
                        ____t_result_17 = __O[931]
                    else
                        ____t_result_17 = __gt(
                            antes,
                            math.max(i.y, i.anterior) + 2
                        )
                    end
                    __O[932] = ____t_result_17
                    if ____t_18(____t_result_17) then
                        ____t_result_19 = __O[932]
                    else
                        ____t_result_19 = __lt(p.y, i.y)
                    end
                    if ____t_20(____t_result_19) then
                        continue
                    end
                    p.y = i.y
                    p.vy = 0
                    p.ground = true
                    return
                end
            end
        end
        if __le(p.y, f.piso + 40) then
            return
        end
        local i = maisPerto(nil, f.ceu.ilhas, p.x)
        ferir(nil, 9, p.x)
        p.x = meio(nil, i)
        p.y = i.y
        p.vy = 0
        p.vx = 0
        p.ground = true
        local ____p_22 = p
        local ____t_result_21
        if __t(p.inv) then
            ____t_result_21 = p.inv
        else
            ____t_result_21 = 0
        end
        ____p_22.inv = math.max(____t_result_21, 0.95)
    end
    local function marcar(self, f)
        local ceu = f.ceu
        local ____get_27 = __get
        local ____mod_26 = __mod
        local ____ceu_23, ____rodada_24 = ceu, "rodada"
        local ____ceu_rodada_25 = ____ceu_23[____rodada_24]
        ____ceu_23[____rodada_24] = ____ceu_rodada_25 + 1
        local ids = ____get_27(
            escolhas,
            ____mod_26(
                ____ceu_rodada_25,
                __len(escolhas)
            )
        )
        local alvos = __call(
            ids,
            "map",
            function(____, id) return __get(ceu.ilhas, id) end
        )
        for ____, i in __iterar((alvos)) do
            i.estado = "aviso"
        end
        return alvos
    end
    local function romper(self, f, p)
        for ____, i in __iterar((f.ceu.ilhas)) do
            if i.estado == "aviso" then
                local ____t_35 = __t
                local ____t_result_34
                local ____t_33 = __t
                local ____t_result_32
                local ____t_31 = __t
                local ____opt_result_30
                if p ~= nil then
                    ____opt_result_30 = p.ground
                end
                __O[933] = ____opt_result_30
                if ____t_31(____opt_result_30) then
                    ____t_result_32 = sob(nil, i, p.x)
                else
                    ____t_result_32 = __O[933]
                end
                __O[934] = ____t_result_32
                if ____t_33(____t_result_32) then
                    ____t_result_34 = math.abs(i.y - p.y) < 3
                else
                    ____t_result_34 = __O[934]
                end
                if ____t_35(____t_result_34) then
                    p.ground = false
                end
                i.estado = "ausente"
                i.resto = volta
            end
        end
    end
    local function flutuar(self, f, dt)
        local ____t_39 = __t
        local ____t_result_38
        local ____t_37 = __t
        local ____temp_36 = f.golpe == "rasante"
        __O[935] = ____temp_36
        if ____t_37(____temp_36) then
            ____t_result_38 = f.estado == "firing" or f.estado == "windup"
        else
            ____t_result_38 = __O[935]
        end
        if ____t_39(____t_result_38) then
            return
        end
        local subida = clamp(nil, f.ceu.tempo / 1.18, 0, 1)
        local altura = 146 + 19 * math.sin(f.ceu.tempo * 1.7)
        f.y = f.y + (f.piso - subida * altura - f.y) * math.min(1, dt * 5.2)
    end
    local function corpo(self, f)
        local ____temp_40
        if f.fase == 2 then
            ____temp_40 = {rx = 36, altura = 103}
        else
            ____temp_40 = {rx = 22, altura = f.fase == 4 and 76 or 71}
        end
        return ____temp_40
    end
    local function toca(self, f, x, y, rx, ry)
        local c = corpo(nil, f)
        local ____t_result_43
        local ____t_42 = __t
        local ____temp_41 = __lt(
            math.abs(x - f.x),
            c.rx + rx
        ) and __gt(
            __add(y, ry),
            f.y - c.altura
        )
        __O[936] = ____temp_41
        if ____t_42(____temp_41) then
            ____t_result_43 = __lt(y - ry, f.y)
        else
            ____t_result_43 = __O[936]
        end
        return ____t_result_43
    end
    rect = function(____, c, x, y, w, h, cor)
        c.fillStyle = cor
        c:fillRect(
            math.floor(x + 0.5),
            math.floor(y + 0.5),
            math.floor(w + 0.5),
            math.floor(h + 0.5)
        )
    end
    local function risco(self, c, p, cor, w)
        if w == nil then
            w = 2
        end
        c.strokeStyle = cor
        c.lineWidth = w
        c.lineJoin = "bevel"
        c:beginPath()
        c:moveTo(
            math.floor(__get(
                __get(p, 0),
                0
            ) + 0.5),
            math.floor(__get(
                __get(p, 0),
                1
            ) + 0.5)
        )
        do
            local i = 1
            while __lt(
                i,
                __len(p)
            ) do
                c:lineTo(
                    math.floor(__get(
                        __get(p, i),
                        0
                    ) + 0.5),
                    math.floor(__get(
                        __get(p, i),
                        1
                    ) + 0.5)
                )
                i = i + 1
            end
        end
        c:stroke()
    end
    local paisagem
    local function horizonte(self)
        if __t(paisagem) then
            return paisagem
        end
        local img = window.document:createElement("canvas")
        img.width = 480
        img.height = 270
        local c = img:getContext("2d")
        local grad = c:createLinearGradient(0, 0, 0, 270)
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({0, "#171c46"}, 2),
                __arrL({0.3, "#393e79"}, 2),
                __arrL({0.55, "#856794"}, 2),
                __arrL({0.74, "#efac9c"}, 2),
                __arrL({0.88, "#ffd39e"}, 2),
                __arrL({1, "#9295ad"}, 2)
            },
            6
        ))) do
            local v = ____value[1]
            local cor = ____value[2]
            grad:addColorStop(v, cor)
        end
        c.fillStyle = grad
        c:fillRect(0, 0, 480, 270)
        do
            local k = 0
            while k < 66 do
                local x = __mod(k * 131 + 27, 480)
                local y = __mod(k * k * 7 + 13 * k + 3, 81)
                rect(
                    nil,
                    c,
                    x,
                    y,
                    __t(__mod(k, 7)) and 1 or 2,
                    1,
                    __t(__mod(k, 4)) and "#aca3bf" or "#fce4c7"
                )
                k = k + 1
            end
        end
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({0, 10}, 2),
                __arrL({2, 18}, 2),
                __arrL({5, 24}, 2),
                __arrL({9, 28}, 2),
                __arrL({15, 28}, 2),
                __arrL({20, 24}, 2),
                __arrL({24, 16}, 2),
                __arrL({27, 8}, 2)
            },
            8
        ))) do
            local y = ____value[1]
            local w = ____value[2]
            rect(
                nil,
                c,
                361 - w / 2,
                28 + y,
                w,
                4,
                "#ffe7c1"
            )
        end
        rect(
            nil,
            c,
            353,
            38,
            6,
            2,
            "#e9c7ad"
        )
        rect(
            nil,
            c,
            362,
            47,
            7,
            2,
            "#e9c7ad"
        )
        do
            local k = 0
            while k < 3 do
                local pontos = __arrL({}, 0)
                do
                    local x = 0
                    while x <= 488 do
                        __call(
                            pontos,
                            "push",
                            __arrL(
                                {
                                    x,
                                    37 + k * 7 + 14 * math.sin(x / 87 + k * 0.22) - 0.059 * x
                                },
                                2
                            )
                        )
                        x = x + 8
                    end
                end
                local ____pol_46 = pol
                local ____arr_45 = __arr
                local ____array_44 = __TS__SparseArrayNew(__TS__Spread(__iter(pontos)))
                __TS__SparseArrayPush(
                    ____array_44,
                    __TS__Spread(__iter(__call(
                        __call(
                            __call(pontos, "slice"),
                            "reverse"
                        ),
                        "map",
                        function(____, ____bindingPattern0)
                            local y
                            local x
                            x = ____bindingPattern0[1]
                            y = ____bindingPattern0[2]
                            return __arrL({x, y + 2 + k}, 2)
                        end
                    )))
                )
                ____pol_46(
                    nil,
                    c,
                    ____arr_45(__TS__SparseArraySpread(____array_44)),
                    __get(
                        __arrL({"#414b80", "#505888", "#635c8b"}, 3),
                        k
                    )
                )
                k = k + 1
            end
        end
        do
            local layer = 0
            while layer < 2 do
                local y = 175 + layer * 23
                local pts = __arrL(
                    {__arrL({0, 270}, 2)},
                    1
                )
                do
                    local x = 0
                    while x <= 486 do
                        __call(
                            pts,
                            "push",
                            __arrL(
                                {
                                    x,
                                    y + math.sin(x / 46 + layer) * 11 + math.sin(x / 19) * 5
                                },
                                2
                            )
                        )
                        x = x + 6
                    end
                end
                local ____pol_49 = pol
                local ____arr_48 = __arr
                local ____array_47 = __TS__SparseArrayNew(__TS__Spread(__iter(pts)))
                __TS__SparseArrayPush(
                    ____array_47,
                    __arrL({486, 270}, 2)
                )
                ____pol_49(
                    nil,
                    c,
                    ____arr_48(__TS__SparseArraySpread(____array_47)),
                    __t(layer) and "#91829a" or "#aa8c9e"
                )
                layer = layer + 1
            end
        end
        pol(
            nil,
            c,
            __arrL(
                {
                    __arrL({0, 208}, 2),
                    __arrL({80, 194}, 2),
                    __arrL({142, 202}, 2),
                    __arrL({214, 186}, 2),
                    __arrL({274, 209}, 2),
                    __arrL({315, 193}, 2),
                    __arrL({390, 207}, 2),
                    __arrL({480, 189}, 2),
                    __arrL({480, 270}, 2),
                    __arrL({0, 270}, 2)
                },
                10
            ),
            "#938497"
        )
        do
            local k = 0
            while k < 48 do
                local x = k * 11
                local h = 7 + __mod(k * 13, 14)
                rect(
                    nil,
                    c,
                    x,
                    211 - h,
                    9,
                    h,
                    "#81788c"
                )
                pol(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x - 2, 211 - h}, 2),
                            __arrL({x + 4, 207 - h}, 2),
                            __arrL({x + 11, 211 - h}, 2)
                        },
                        3
                    ),
                    "#79758e"
                )
                k = k + 1
            end
        end
        local sil = "#696c87"
        local vitral = "#e4b196"
        for ____, x in __iterar((__arrL({137, 168}, 2))) do
            rect(
                nil,
                c,
                x - 5,
                163,
                11,
                37,
                sil
            )
            rect(
                nil,
                c,
                x - 7,
                160,
                15,
                3,
                sil
            )
            pol(
                nil,
                c,
                __arrL(
                    {
                        __arrL({x - 6, 160}, 2),
                        __arrL({x, 139}, 2),
                        __arrL({x + 6, 160}, 2)
                    },
                    3
                ),
                sil
            )
            rect(
                nil,
                c,
                x,
                135,
                1,
                8,
                sil
            )
            rect(
                nil,
                c,
                x - 2,
                138,
                5,
                1,
                sil
            )
            rect(
                nil,
                c,
                x - 2,
                169,
                4,
                8,
                vitral
            )
            rect(
                nil,
                c,
                x - 1,
                167,
                2,
                2,
                vitral
            )
        end
        pol(
            nil,
            c,
            __arrL(
                {
                    __arrL({137, 195}, 2),
                    __arrL({152, 172}, 2),
                    __arrL({168, 195}, 2)
                },
                3
            ),
            sil
        )
        rect(
            nil,
            c,
            140,
            194,
            24,
            15,
            sil
        )
        rect(
            nil,
            c,
            150,
            187,
            4,
            6,
            vitral
        )
        rect(
            nil,
            c,
            0,
            211,
            480,
            4,
            "#877b90"
        )
        do
            local k = 0
            while k < 64 do
                local x = __mod(k * 71 + 11, 480)
                local y = 198 + __mod(k * 23, 12)
                rect(
                    nil,
                    c,
                    x,
                    y,
                    2,
                    1,
                    __t(__mod(k, 3)) and "#b4a1a3" or "#efd39e"
                )
                k = k + 1
            end
        end
        pol(
            nil,
            c,
            __arrL(
                {
                    __arrL({0, 217}, 2),
                    __arrL({52, 213}, 2),
                    __arrL({89, 221}, 2),
                    __arrL({147, 209}, 2),
                    __arrL({208, 222}, 2),
                    __arrL({268, 214}, 2),
                    __arrL({334, 221}, 2),
                    __arrL({395, 209}, 2),
                    __arrL({479, 218}, 2),
                    __arrL({480, 270}, 2),
                    __arrL({0, 270}, 2)
                },
                11
            ),
            "#81798e"
        )
        risco(
            nil,
            c,
            __arrL(
                {
                    __arrL({0, 233}, 2),
                    __arrL({76, 229}, 2),
                    __arrL({129, 235}, 2),
                    __arrL({179, 230}, 2),
                    __arrL({242, 235}, 2),
                    __arrL({310, 228}, 2),
                    __arrL({369, 230}, 2),
                    __arrL({431, 223}, 2),
                    __arrL({480, 226}, 2)
                },
                9
            ),
            "#a695a1",
            2
        )
        do
            local k = 0
            while k < 19 do
                local x = k * 30 - 24
                local y = 249 + math.floor(math.sin(k * 2.4) * 6 + 0.5)
                nuvem(
                    nil,
                    c,
                    x,
                    y,
                    1.2,
                    __t(__mod(k, 3)) and "#aba1b4" or "#a59aae",
                    "#c7b6bf"
                )
                k = k + 1
            end
        end
        paisagem = img
        return img
    end
    local function fundo(self, c, f)
        local t = f.ceu.tempo
        c:save()
        c.globalAlpha = c.globalAlpha * clamp(nil, t / 0.85, 0, 1)
        c.imageSmoothingEnabled = false
        c:drawImage(
            horizonte(nil),
            0,
            0,
            960,
            540
        )
        do
            local k = 0
            while k < 15 do
                local faixa = math.floor(k / 5)
                local x = __mod(
                    __mod(k * 217 - t * (4 + faixa * 5), 1160) + 1160,
                    1160
                ) - 147
                nuvem(
                    nil,
                    c,
                    x,
                    202 + faixa * 112 + math.sin(k * 3) * 29,
                    0.94 + faixa * 0.64,
                    __get(
                        __arrL({"#b297ac", "#d7a8ac", "#847e9f"}, 3),
                        faixa
                    ),
                    __get(
                        __arrL({"#d9b2b7", "#f6c4af", "#aca0b6"}, 3),
                        faixa
                    )
                )
                k = k + 1
            end
        end
        do
            local k = 0
            while k < 6 do
                local x = __mod(
                    __mod(k * 217 - t * 10, 1240) + 1240,
                    1240
                ) - 174
                local y = 509 + 14 * math.sin(k * 1.8)
                nuvem(
                    nil,
                    c,
                    x,
                    y,
                    2.4,
                    "#ac9fb6",
                    "#d0b8bd"
                )
                k = k + 1
            end
        end
        c:restore()
    end
    local function plataformas(self, c, f)
        local t = f.ceu.tempo
        for ____, i in __iterar((f.ceu.ilhas)) do
            do
                local x = math.floor(i.x + 0.5)
                local w = math.floor(i.w + 0.5)
                local y = math.floor(i.y + 0.5)
                local m = x + w / 2
                if i.estado == "ausente" then
                    local queda = volta - i.resto
                    if queda < 0.48 then
                        do
                            local n = 0
                            while n < 5 do
                                local dx = (n - 2) * w / 5
                                local dy = queda * queda * 390
                                pol(
                                    nil,
                                    c,
                                    __arrL(
                                        {
                                            __arrL({m + dx - 7, y + dy + 3}, 2),
                                            __arrL({m + dx + 8, y + dy + 6}, 2),
                                            __arrL({m + dx + 1, y + dy + 18 + n}, 2)
                                        },
                                        3
                                    ),
                                    __t(__mod(n, 2)) and "#a786b4" or "#dcaf97"
                                )
                                n = n + 1
                            end
                        end
                    end
                    if __lt(i.resto, 0.64) then
                        c:save()
                        c.globalAlpha = 0.26 + (1 - i.resto / 0.64) * 0.46
                        do
                            local n = 0
                            while n < w do
                                rect(
                                    nil,
                                    c,
                                    x + n,
                                    y,
                                    math.min(7, w - n),
                                    3,
                                    "#bff9ff"
                                )
                                n = n + 12
                            end
                        end
                        c:restore()
                    end
                    continue
                end
                local alerta = i.estado == "aviso"
                pol(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x, y + 4}, 2),
                            __arrL({x + w, y + 4}, 2),
                            __arrL({x + w - 9, y + 16}, 2),
                            __arrL({m + 15, y + 24}, 2),
                            __arrL({m + 7, y + 33}, 2),
                            __arrL({m - 10, y + 33}, 2),
                            __arrL({m - 17, y + 23}, 2),
                            __arrL({x + 10, y + 17}, 2)
                        },
                        8
                    ),
                    "#323453"
                )
                pol(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x + 8, y + 8}, 2),
                            __arrL({x + w - 9, y + 8}, 2),
                            __arrL({x + w - 19, y + 15}, 2),
                            __arrL({m, y + 28}, 2),
                            __arrL({x + 17, y + 15}, 2)
                        },
                        5
                    ),
                    "#65557e"
                )
                pol(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({m - 14, y + 13}, 2),
                            __arrL({m, y + 9}, 2),
                            __arrL({m + 14, y + 13}, 2),
                            __arrL({m, y + 29}, 2)
                        },
                        4
                    ),
                    __t(alerta) and "#ec7975" or "#75cacd"
                )
                pol(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({m - 9, y + 14}, 2),
                            __arrL({m, y + 12}, 2),
                            __arrL({m, y + 24}, 2)
                        },
                        3
                    ),
                    __t(alerta) and "#ffc79b" or "#baf9ed"
                )
                for ____, side in __iterar((__arrL({-1, 1}, 2))) do
                    local g = m + side * w * 0.3
                    pol(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({g - 7, y + 12}, 2),
                                __arrL({g, y + 10}, 2),
                                __arrL({g + 7, y + 12}, 2),
                                __arrL({g, y + 18}, 2)
                            },
                            4
                        ),
                        "#b28eaf"
                    )
                    rect(
                        nil,
                        c,
                        g - 1,
                        y + 18,
                        3,
                        7,
                        "#9e815d"
                    )
                    rect(
                        nil,
                        c,
                        g - 2,
                        y + 25,
                        5,
                        3,
                        "#ebbd78"
                    )
                end
                rect(
                    nil,
                    c,
                    x,
                    y,
                    w,
                    7,
                    "#4c435c"
                )
                rect(
                    nil,
                    c,
                    x,
                    y,
                    w,
                    3,
                    __t(alerta) and "#ffc783" or "#ffdfae"
                )
                rect(
                    nil,
                    c,
                    x + 4,
                    y + 3,
                    w - 8,
                    2,
                    __t(alerta) and "#d06c65" or "#b699aa"
                )
                do
                    local n = 1
                    while n < 4 do
                        rect(
                            nil,
                            c,
                            x + n * w / 4,
                            y + 3,
                            2,
                            4,
                            "#6b596e"
                        )
                        n = n + 1
                    end
                end
                if __t(alerta) then
                    risco(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({m - 13, y + 1}, 2),
                                __arrL({m - 6, y + 6}, 2),
                                __arrL({m - 10, y + 10}, 2),
                                __arrL({m + 1, y + 16}, 2),
                                __arrL({m - 1, y + 21}, 2),
                                __arrL({m + 7, y + 26}, 2)
                            },
                            6
                        ),
                        "#ffe8ae",
                        3
                    )
                    for ____, side in __iterar((__arrL({-1, 1}, 2))) do
                        local bx = m + side * w * 0.33
                        local by = y - 14 + math.sin(t * 9) * 2
                        risco(
                            nil,
                            c,
                            __arrL(
                                {
                                    __arrL({bx - 6, by - 4}, 2),
                                    __arrL({bx, by + 1}, 2),
                                    __arrL({bx + 6, by - 4}, 2)
                                },
                                3
                            ),
                            "#ffb68e",
                            3
                        )
                    end
                end
            end
        end
    end
    local function aura(self, c, f)
        local t = f.idade
        do
            local i = 0
            while i < 7 do
                local x = (i - 3) * 12
                local altura = 51 + 42 * (1 - math.abs(i - 3) / 4) + 11 * math.sin(t * 4 + i * 1.8)
                local y = -15 - math.abs(i - 3) * 4
                pol(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x - 10, y}, 2),
                            __arrL({x - 14, y - 23}, 2),
                            __arrL({x - 8, y - 18}, 2),
                            __arrL({x - 6, y - altura * 0.67}, 2),
                            __arrL({x - 2, y - altura * 0.62}, 2),
                            __arrL({x + 4, y - altura}, 2),
                            __arrL({x + 7, y - altura * 0.6}, 2),
                            __arrL({x + 10, y - 29}, 2),
                            __arrL({x + 13, y - 32}, 2),
                            __arrL({x + 10, y - 4}, 2)
                        },
                        10
                    ),
                    __t(__mod(i, 2)) and "#5178bd" or "#5a62ae"
                )
                pol(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x - 6, y}, 2),
                            __arrL({x - 8, y - 20}, 2),
                            __arrL({x - 2, y - 17}, 2),
                            __arrL({x + 3, y - altura * 0.76}, 2),
                            __arrL({x + 5, y - 26}, 2),
                            __arrL({x + 9, y - 29}, 2),
                            __arrL({x + 7, y - 2}, 2)
                        },
                        7
                    ),
                    __t(__mod(i, 2)) and "#9ce7e9" or "#acbcff"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 6 do
                local q = __mod(t * 0.75 + i / 6, 1)
                local lado = __t(__mod(i, 2)) and 1 or -1
                rect(
                    nil,
                    c,
                    lado * (28 + q * 19),
                    -13 - q * 105,
                    2,
                    5 + __mod(i, 3),
                    "#d7ffff"
                )
                i = i + 1
            end
        end
    end
    local function personagem(self, c, f, o)
        local tipo = __get(formas, f.fase - 1)
        local ____t_result_50
        if __t(o.facing) then
            ____t_result_50 = o.facing
        else
            ____t_result_50 = 1
        end
        local dir = ____t_result_50
        c:save()
        c:translate(
            math.floor(f.x + 0.5),
            math.floor(f.y + 0.5)
        )
        if f.fase == 4 then
            aura(nil, c, f)
        end
        if f.fase == 2 then
            local ____t_result_51
            if __t(f.estado == "windup" and f.golpe == "saltoBarriga") then
                ____t_result_51 = clamp(nil, f.tempo / f.dur, 0, 1)
            else
                ____t_result_51 = 0
            end
            local preparo = ____t_result_51
            local voo = clamp(nil, (f.piso - f.y) / 130, 0, 1)
            local ____t_result_52
            if __t(f.golpe == "saltoBarriga" and f.estado == "firing") then
                ____t_result_52 = math.max(0, 1 - (f.piso - f.y) / 18) * 0.07
            else
                ____t_result_52 = 0
            end
            local pouso = ____t_result_52
            c:scale(1.56 + preparo * 0.13 + pouso - voo * 0.09, 1.48 - preparo * 0.2 - pouso + voo * 0.08)
        end
        if f.fase == 5 then
            for ____, lado in __iterar((__arrL({-1, 1}, 2))) do
                local x = __TS__Number(-dir) * (17 + lado * 5)
                risco(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({x, -43}, 2),
                            __arrL({x - dir * 12, -39}, 2),
                            __arrL(
                                {
                                    x - dir * 21,
                                    -41 + math.sin(f.idade * 3 + lado) * 3
                                },
                                2
                            )
                        },
                        3
                    ),
                    lado < 0 and "#bce1e3" or "#ffd690",
                    3
                )
            end
        end
        window.Art:drawCharacter(
            c,
            tipo,
            0,
            0,
            __assign(
                {},
                o,
                {
                    scale = f.fase == 2 and 1 or 1.08,
                    duelo = f.fase,
                    grounded = not __t(f.ceu) and __ge(f.y, f.piso - 2),
                    frame = f.idade
                }
            )
        )
        c:restore()
    end
    window.JorgeDuelo = __ord({
        formas = formas,
        corpo = corpo,
        toca = toca,
        mudar = mudar,
        avancar = avancar,
        pousar = pousar,
        marcar = marcar,
        romper = romper,
        flutuar = flutuar,
        fundo = fundo,
        plataformas = plataformas,
        personagem = personagem
    }, "formas,corpo,toca,mudar,avancar,pousar,marcar,romper,flutuar,fundo,plataformas,personagem")
end)(nil)
return ____exports
