--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __le, __gt, __isFiniteN, __mod, __ord, __arrL, __iterar, __t, __get, __len, __call = __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__isFiniteN, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__len, __JSR.__call
local __add, __assign, __re, __re_test = __JSR.__add, __JSR.__assign, __JSR.__re, __JSR.__re_test
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local __TS__Iterator = ____lualib.__TS__Iterator
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    if __t(window.Golpes) then
        return
    end
    local CORPO = __ord(
        {
            daroca = __arrL({14, 76}, 2),
            nicolas = __arrL({17, 66}, 2),
            freddy = __arrL({17, 70}, 2),
            menezes = __arrL({18, 70}, 2),
            kaique = __arrL({17, 108}, 2),
            dede = __arrL({16, 66}, 2),
            marco = __arrL({16, 66}, 2),
            arthur = __arrL({18, 68}, 2),
            reeisBoss = __arrL({48, 160}, 2),
            giant = __arrL({104, 175}, 2),
            marcoRage = __arrL({21, 92}, 2),
            nikolas1 = __arrL({20, 68}, 2),
            nikolas2 = __arrL({72, 142}, 2),
            nikolas3 = __arrL({72, 142}, 2),
            nikolas4 = __arrL({190, 345}, 2)
        },
        "daroca,nicolas,freddy,menezes,kaique,dede,marco,arthur,reeisBoss,giant,marcoRage,nikolas1,nikolas2,nikolas3,nikolas4"
    )
    local CAPANGA = __ord(
        {
            rat = __arrL({22, 24}, 2),
            thug = __arrL({16, 67}, 2),
            k0 = __arrL({28, 96}, 2),
            k1 = __arrL({24, 76}, 2),
            k2 = __arrL({34, 80}, 2),
            sixseven = __arrL({30, 88}, 2)
        },
        "rat,thug,k0,k1,k2,sixseven"
    )
    local TIRO = __ord({
        paper = 8,
        ruler = 10,
        case = 10,
        papaia = 10,
        reeis = 7,
        enemyBullet = 8,
        slime = 12,
        inkBlade = 22,
        smoke = 12,
        bituca = 9,
        astral = 15,
        confetti = 8,
        doodle = 20,
        gangFan = 12
    }, "paper,ruler,case,papaia,reeis,enemyBullet,slime,inkBlade,smoke,bituca,astral,confetti,doodle,gangFan")
    local ONDA = __ord({meia = 13, alt = 58}, "meia,alt")
    local ALT = __ord({chao = 80, brasa = 40}, "chao,brasa")
    local function clamp(____, v, a, b)
        return math.max(
            a,
            math.min(b, v)
        )
    end
    local function hsh(____, n)
        local x = math.sin(n * 12.9898 + 78.233) * 43758.5453
        return x - math.floor(x)
    end
    local function caixa(____, x0, y0, x1, y1)
        return {x0 = x0, y0 = y0, x1 = x1, y1 = y1}
    end
    local function cruza(____, a, b)
        local ____t_7 = __t
        local ____t_5 = __t
        local ____t_3 = __t
        local ____t_1 = __t
        local ____temp_0 = not not __t(a) and not not __t(b)
        __O[1560] = ____temp_0
        local ____temp_2 = if ____t_1(____temp_0) then __lt(a.x0, b.x1) else __O[1560]
        __O[1561] = ____temp_2
        local ____temp_4 = if ____t_3(____temp_2) then __gt(a.x1, b.x0) else __O[1561]
        __O[1562] = ____temp_4
        local ____temp_6 = if ____t_5(____temp_4) then __lt(a.y0, b.y1) else __O[1562]
        __O[1563] = ____temp_6
        return if ____t_7(____temp_6) then __gt(a.y1, b.y0) else __O[1563]
    end
    local function circuloCaixa(self, cx, cy, r, b)
        local qx = clamp(nil, cx, b.x0, b.x1)
        local qy = clamp(nil, cy, b.y0, b.y1)
        return (qx - cx) * (qx - cx) + (qy - cy) * (qy - cy) <= r * r
    end
    local function elipseCaixa(self, cx, cy, rx, ry, b)
        local qx = clamp(nil, cx, b.x0, b.x1)
        local qy = clamp(nil, cy, b.y0, b.y1)
        local dx = (qx - cx) / rx
        local dy = (qy - cy) / ry
        return dx * dx + dy * dy <= 1
    end
    local function heroi(self, p)
        local b = CORPO.daroca
        return caixa(
            nil,
            p.x - __get(b, 0),
            p.y - __get(b, 1),
            p.x + __get(b, 0),
            p.y
        )
    end
    local function chaveChefe(self, e)
        local ____t_10 = __t
        local ____t_9 = __t
        local ____temp_8 = e.type == "marco"
        __O[1564] = ____temp_8
        return if e.type == "nikolas" then __add(
            "nikolas",
            clamp(
                nil,
                math.floor(if __t(e.phase) then e.phase else 1),
                1,
                4
            )
        ) else if ____t_10(if ____t_9(____temp_8) then e.rage else __O[1564]) then "marcoRage" else e.type
    end
    local function chefe(self, e)
        local ____t_12 = __t
        local ____get_result_11 = __get(
            CORPO,
            chaveChefe(nil, e)
        )
        __O[1565] = ____get_result_11
        local b = if ____t_12(____get_result_11) then __O[1565] else __arrL({20, 70}, 2)
        local ____t_14 = __t
        local ____TS__Number_result_13 = __TS__Number(e.escalaCorpo)
        __O[1566] = ____TS__Number_result_13
        local s = if ____t_14(____TS__Number_result_13) then __O[1566] else 1
        return caixa(
            nil,
            e.x - __get(b, 0) * s,
            e.y - __get(b, 1) * s,
            e.x + __get(b, 0) * s,
            e.y
        )
    end
    local function capanga(self, m)
        local k = if m.type == "rat" then "rat" else if __t(m.type == "thug" or m.kind == "thug") then "thug" else if m.design == "sixseven" then "sixseven" else __add("k", if __t(m.kind) then m.kind else 0)
        local ____t_16 = __t
        local ____get_result_15 = __get(CAPANGA, k)
        __O[1567] = ____get_result_15
        local b = if ____t_16(____get_result_15) then __O[1567] else __arrL({20, 60}, 2)
        return caixa(
            nil,
            m.x - __get(b, 0),
            m.y - __get(b, 1),
            __add(
                m.x,
                __get(b, 0)
            ),
            m.y
        )
    end
    local function formaTiro(self, s)
        if s.type == "word" then
            local w = math.min(
                220,
                __len(tostring(if __t(s.text) then s.text else "POUDI")) * 7 + 18
            )
            return {caixa = caixa(
                nil,
                s.x - w / 2 - 5,
                s.y - 13,
                s.x + w / 2 + 5,
                s.y + 15
            )}
        end
        local ____t_18 = __t
        local ____get_result_17 = __get(TIRO, s.type)
        __O[1568] = ____get_result_17
        return {r = if ____t_18(____get_result_17) then __O[1568] else 10}
    end
    local function tiroAcerta(self, s, b)
        local f = formaTiro(nil, s)
        return if __t(f.caixa) then cruza(nil, f.caixa, b) else circuloCaixa(
            nil,
            s.x,
            s.y,
            f.r,
            b
        )
    end
    local function perigoCaixas(self, h, chao)
        if h.type == "ring" then
            local y0 = chao - ONDA.alt
            return __arrL(
                {
                    caixa(
                        nil,
                        h.x - h.r - ONDA.meia,
                        y0,
                        h.x - h.r + ONDA.meia,
                        chao + 2
                    ),
                    caixa(
                        nil,
                        __add(h.x, h.r) - ONDA.meia,
                        y0,
                        __add(h.x, h.r) + ONDA.meia,
                        chao + 2
                    )
                },
                2
            )
        end
        local alt = if h.type == "astral" then chao + 600 else if __t(h.height) then h.height else if __t(h.brasa) then ALT.brasa else ALT.chao
        return __arrL(
            {caixa(
                nil,
                h.x - h.r,
                chao - alt,
                __add(h.x, h.r),
                chao + 2
            )},
            1
        )
    end
    local CHAO = nil
    local function chaoDo(____, h)
        local ____t_20 = __t
        local ____TS__Number_result_19 = __TS__Number(h.y)
        __O[1569] = ____TS__Number_result_19
        return if CHAO ~= nil then CHAO else if ____t_20(____TS__Number_result_19) then __O[1569] else 0 + if h.type == "ring" then 5 else 6
    end
    local function perigoAcerta(self, h, b)
        local c = chaoDo(nil, h)
        for ____, k in __iterar((perigoCaixas(nil, h, c))) do
            if __t(cruza(nil, k, b)) then
                return true
            end
        end
        return false
    end
    local function areaGas(self, x, y, raio)
        return {cx = x, cy = y - 22, rx = raio, ry = raio * 0.5}
    end
    local function gasAcerta(____, a, b)
        return elipseCaixa(
            nil,
            a.cx,
            a.cy,
            a.rx,
            a.ry,
            b
        )
    end
    local function gasPega(self, a, x, y, r)
        if r == nil then
            r = 0
        end
        local dx = (x - a.cx) / (a.rx + r)
        local dy = (y - a.cy) / (a.ry + r)
        return dx * dx + dy * dy <= 1
    end
    local ctx = nil
    local function px(self, x, y, w, h, cor)
        ctx.fillStyle = cor
        ctx:fillRect(
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
    local function bolha(self, x, y, r, cor, borda)
        if __t(borda) then
            do
                local yy = __TS__Number(-r) - 2
                while __le(yy, r + 2) do
                    local w = math.sqrt(math.max(0, (r + 2) * (r + 2) - yy * yy))
                    px(
                        nil,
                        x - w,
                        y + yy,
                        w * 2,
                        3,
                        borda
                    )
                    yy = yy + 3
                end
            end
        end
        do
            local yy = __TS__Number(-r)
            while __le(yy, r) do
                local w = math.sqrt(math.max(0, r * r - yy * yy))
                px(
                    nil,
                    x - w,
                    y + yy,
                    w * 2,
                    3,
                    cor
                )
                yy = yy + 3
            end
        end
    end
    local function espinho(self, x, chao, alt, larg, pal)
        do
            local yy = 0
            while __lt(yy, alt) do
                local k = 1 - yy / alt
                local w = math.max(
                    2,
                    math.floor(larg * k + 0.5)
                )
                px(
                    nil,
                    x - w / 2,
                    chao - yy - 4,
                    w,
                    4,
                    if yy < 4 then __get(pal, 0) else if k < 0.3 then __get(pal, 3) else if k < 0.65 then __get(pal, 2) else __get(pal, 1)
                )
                yy = yy + 4
            end
        end
    end
    local PAL = __ord(
        {
            gosma = __arrL({"#24401c", "#4f8a2c", "#9ccf4a", "#e4f7a0"}, 4),
            fumaca = __arrL({"#3a4044", "#7d8a8c", "#b8c3c0", "#eef3ec"}, 4),
            tinta = __arrL({"#241434", "#5a2f7a", "#9d6ec7", "#e6c6f5"}, 4),
            astral = __arrL({"#1c3a68", "#3f7fc0", "#9de5ec", "#fff0ac"}, 4),
            brasa = __arrL({"#3a1408", "#a8401a", "#ff8a30", "#ffe08a"}, 4),
            provoca = __arrL({"#4a1a38", "#a8457a", "#f0a0cc", "#ffe3f2"}, 4)
        },
        "gosma,fumaca,tinta,astral,brasa,provoca"
    )
    local function paleta(self, h, pal)
        local ____t_23 = __t
        local ____t_22 = __t
        local ____temp_21 = h.type == "smoke"
        __O[1570] = ____temp_21
        local ____t_26 = __t
        local ____t_25 = __t
        local ____temp_24 = h.type == "astral"
        __O[1571] = ____temp_24
        return if __t(if __t(h.catarro) then h.catarro else h.type == "slime") then PAL.gosma else if __t(h.brasa) then PAL.brasa else if __t(if __t(h.ink) then h.ink else h.type == "ink") then PAL.tinta else if ____t_23(if ____t_22(____temp_21) then __O[1570] else h.smoke) then PAL.fumaca else if ____t_26(if ____t_25(____temp_24) then __O[1571] else h.astral) then PAL.astral else if h.type == "provoke" then PAL.provoca else if __t(pal) then pal else PAL.tinta
    end
    local function aviso(self, h, t, pal, lite)
        local chao = chaoDo(nil, h)
        local pisca = 0.45 + 0.35 * math.abs(math.sin(t * 12))
        ctx:save()
        for ____, b in __iterar((perigoCaixas(nil, h, chao))) do
            local w = b.x1 - b.x0
            ctx.globalAlpha = pisca
            do
                local x = b.x0
                while __lt(x, b.x1) do
                    local y = chao - 3 + math.floor(math.sin(x * 0.37) * 1.2 + 0.5)
                    px(
                        nil,
                        x,
                        y,
                        4,
                        2,
                        __get(pal, 2)
                    )
                    if hsh(nil, x) > 0.78 then
                        px(
                            nil,
                            x + 1,
                            y - 2,
                            2,
                            2,
                            __get(pal, 3)
                        )
                    end
                    x = x + 4
                end
            end
            if not __t(lite) then
                do
                    local i = 0
                    while i < 4 do
                        local k = __mod(
                            t * 1.5 + hsh(nil, i + b.x0),
                            1
                        )
                        ctx.globalAlpha = (1 - k) * pisca * 0.8
                        px(
                            nil,
                            b.x0 + hsh(nil, i * 7 + b.x0) * (w - 2),
                            chao - 5 - k * 14,
                            2,
                            2,
                            __get(pal, 3)
                        )
                        i = i + 1
                    end
                end
            end
        end
        ctx:restore()
    end
    local function crista(self, h, cx, dir, chao, t, pal, lite)
        local M = ONDA.meia
        local A = ONDA.alt
        if __t(h.smoke) then
            do
                local i = 0
                while i < 3 do
                    local r = 12 - i * 1.5
                    local y = chao - r - i * (A - 24) / 2
                    bolha(
                        nil,
                        cx + math.sin(t * 14 + i) * 1.5,
                        y,
                        r,
                        __get(pal, 1),
                        __get(pal, 0)
                    )
                    bolha(
                        nil,
                        cx - dir * 2,
                        y - 2,
                        r * 0.6,
                        __get(pal, 2)
                    )
                    bolha(
                        nil,
                        cx - dir * 4,
                        y - 4,
                        r * 0.25,
                        __get(pal, 3)
                    )
                    i = i + 1
                end
            end
            return
        end
        if __t(h.catarro) then
            do
                local x = __TS__Number(-M)
                while x <= M do
                    local k = (x * dir + M) / (2 * M)
                    local alt = A * (0.45 + 0.55 * math.sin(k * math.pi * 0.5)) * (0.94 + 0.06 * math.sin(t * 20 + x))
                    do
                        local y = 0
                        while y < alt do
                            local f = y / alt
                            px(
                                nil,
                                cx + x,
                                chao - y - 3,
                                3,
                                3,
                                if f < 0.25 then __get(pal, 0) else if f < 0.65 then __get(pal, 1) else if f < 0.9 then __get(pal, 2) else __get(pal, 3)
                            )
                            y = y + 3
                        end
                    end
                    x = x + 3
                end
            end
            do
                local s = 0
                while s < 5 do
                    local an = s / 5 * math.pi * 0.8
                    px(
                        nil,
                        cx + dir * (M - 4 - math.cos(an) * 6) - 2,
                        chao - A + 4 + math.sin(an) * 5,
                        4,
                        3,
                        if s < 2 then __get(pal, 3) else __get(pal, 2)
                    )
                    s = s + 1
                end
            end
            if not __t(lite) then
                do
                    local i = 0
                    while i < 3 do
                        local yy = chao - 10 - __mod(t * 40 + i * 17, A - 16)
                        bolha(
                            nil,
                            cx - dir * (i * 6 - 4),
                            yy,
                            2,
                            __get(pal, 3)
                        )
                        i = i + 1
                    end
                end
            end
            return
        end
        if __t(h.astral) then
            do
                local x = __TS__Number(-M)
                while x < M do
                    local f = 1 - math.abs(x) / M
                    do
                        local y = 0
                        while y < A do
                            px(
                                nil,
                                cx + x,
                                chao - y - 3,
                                3,
                                3,
                                if f > 0.7 then __get(pal, 3) else if f > 0.35 then __get(pal, 2) else __get(pal, 1)
                            )
                            y = y + 3
                        end
                    end
                    x = x + 3
                end
            end
            do
                local i = 0
                while i < 4 do
                    local y = chao - 6 - __mod(t * 70 + i * 15, A - 8)
                    local x = cx + (hsh(nil, i + 3) - 0.5) * (2 * M - 6)
                    px(
                        nil,
                        x - 2,
                        y,
                        5,
                        1,
                        "#ffffff"
                    )
                    px(
                        nil,
                        x,
                        y - 2,
                        1,
                        5,
                        "#ffffff"
                    )
                    i = i + 1
                end
            end
            return
        end
        local alturas = __arrL({
            0.5,
            0.72,
            1,
            0.82,
            0.55
        }, 5)
        local n = __len(alturas)
        do
            local i = 0
            while i < n do
                local x = cx + (i - (n - 1) / 2) * (2 * M / n) * dir
                local a = A * __get(alturas, if __gt(dir, 0) then i else n - 1 - i) * (0.93 + 0.07 * math.sin(t * 26 + i))
                espinho(
                    nil,
                    x,
                    chao,
                    a,
                    2 * M / n + 3,
                    pal
                )
                i = i + 1
            end
        end
        if not __t(lite) then
            do
                local i = 0
                while i < 4 do
                    local k = __mod(t * 3 + i / 4, 1)
                    ctx.globalAlpha = 1 - k
                    px(
                        nil,
                        cx + (hsh(nil, i) - 0.5) * 2 * M,
                        chao - 8 - k * (A - 12),
                        2,
                        2,
                        __get(pal, 3)
                    )
                    ctx.globalAlpha = 1
                    i = i + 1
                end
            end
        end
    end
    local function rastro(self, h, dir, chao, pal)
        ctx:save()
        ctx.globalAlpha = 0.45
        local cx = h.x + dir * h.r
        do
            local x = h.x
            while __t(if __gt(dir, 0) then __lt(x, cx - ONDA.meia) else __gt(x, cx + ONDA.meia)) do
                px(
                    nil,
                    x,
                    chao - 2,
                    6,
                    2,
                    __get(pal, 0)
                )
                if hsh(nil, x) > 0.7 then
                    px(
                        nil,
                        x + 2,
                        chao - 3,
                        2,
                        1,
                        __get(pal, 1)
                    )
                end
                x = x + dir * 8
            end
        end
        ctx:restore()
    end
    local function erupcao(self, h, chao, t, pal, lite)
        local alt = if __t(h.height) then h.height else ALT.chao
        local L = h.r * 2
        local gosma = pal == PAL.gosma
        local tinta = pal == PAL.tinta
        if __t(gosma) then
            local n = math.max(
                3,
                math.floor(L / 18 + 0.5)
            )
            px(
                nil,
                h.x - h.r,
                chao - 10,
                L,
                10,
                __get(pal, 1)
            )
            px(
                nil,
                h.x - h.r,
                chao - 3,
                L,
                3,
                __get(pal, 0)
            )
            do
                local i = 0
                while i < n do
                    local k = if n > 1 then i / (n - 1) else 0.5
                    local w = L / n
                    local x = h.x - h.r + w / 2 + k * (L - w)
                    local a = alt * if __t(__mod(i, 2)) then 0.82 else 1 * (0.9 + 0.1 * math.sin(t * 12 + i * 1.7)) - w / 2
                    do
                        local y = 0
                        while y < a do
                            local f = y / a
                            local ww = w * (1 - f * 0.25)
                            px(
                                nil,
                                x - ww / 2,
                                chao - y - 3,
                                ww,
                                3,
                                if f < 0.3 then __get(pal, 0) else if f < 0.7 then __get(pal, 1) else __get(pal, 2)
                            )
                            y = y + 3
                        end
                    end
                    bolha(
                        nil,
                        x,
                        chao - a,
                        w / 2,
                        __get(pal, 2),
                        __get(pal, 0)
                    )
                    bolha(
                        nil,
                        x - w * 0.15,
                        chao - a - w * 0.15,
                        w * 0.18,
                        __get(pal, 3)
                    )
                    i = i + 1
                end
            end
            if not __t(lite) then
                do
                    local i = 0
                    while i < 8 do
                        local k = __mod(t * 2 + i / 8, 1)
                        local x = h.x - h.r + 4 + hsh(nil, i * 5 + h.x) * (L - 8)
                        local y = chao - alt * (0.55 + 0.45 * math.sin(k * math.pi))
                        ctx.globalAlpha = 1 - k * 0.6
                        bolha(
                            nil,
                            x,
                            math.max(chao - alt + 3, y),
                            2.5,
                            __get(pal, 3)
                        )
                        ctx.globalAlpha = 1
                        i = i + 1
                    end
                end
            end
            return
        end
        local n = math.max(
            3,
            math.floor(L / 13 + 0.5)
        )
        do
            local i = 0
            while i < n do
                local k = if n > 1 then i / (n - 1) else 0.5
                local x = h.x - h.r + 6 + k * (L - 12)
                local a = alt * (0.72 + 0.28 * math.sin(k * math.pi)) * if __t(__mod(i, 2)) then 0.86 else 1 * (0.94 + 0.06 * math.sin(t * 24 + i))
                espinho(
                    nil,
                    x,
                    chao,
                    a,
                    if __t(tinta) then 11 else 13,
                    pal
                )
                if __t(if __t(tinta) then not __t(lite) else tinta) then
                    px(
                        nil,
                        x - 1,
                        chao - a - 6 - math.abs(math.sin(t * 6 + i)) * 4,
                        3,
                        3,
                        __get(pal, 2)
                    )
                end
                i = i + 1
            end
        end
        px(
            nil,
            h.x - h.r,
            chao - 3,
            L,
            3,
            __get(pal, 0)
        )
        if not __t(lite) then
            do
                local i = 0
                while i < 6 do
                    local k = __mod(t * 2.2 + i / 6, 1)
                    ctx.globalAlpha = 1 - k
                    px(
                        nil,
                        h.x - h.r + hsh(nil, i * 3 + h.x) * (L - 3),
                        chao - 10 - k * (alt - 14),
                        3,
                        3,
                        __get(pal, 3)
                    )
                    ctx.globalAlpha = 1
                    i = i + 1
                end
            end
        end
    end
    local function nuvemChao(self, h, chao, t, pal)
        local alt = ALT.chao
        local cols = math.max(
            2,
            math.floor(h.r / 16 + 0.5)
        )
        local linhas = 3
        do
            local j = 0
            while j < linhas do
                do
                    local i = 0
                    while i < cols do
                        local r = math.min(h.r / cols + 4, alt / (linhas * 2) + 4)
                        local x = h.x - h.r + r + i * ((h.r * 2 - 2 * r) / math.max(1, cols - 1))
                        local y = chao - r - j * ((alt - 2 * r) / (linhas - 1)) + math.sin(t * 3 + i + j) * 2
                        bolha(
                            nil,
                            x,
                            y,
                            r,
                            __get(pal, 1),
                            __get(pal, 0)
                        )
                        bolha(
                            nil,
                            x - 2,
                            y - 3,
                            r * 0.55,
                            __get(pal, 2)
                        )
                        px(
                            nil,
                            x - r * 0.4,
                            y - r * 0.5,
                            3,
                            3,
                            __get(pal, 3)
                        )
                        i = i + 1
                    end
                end
                j = j + 1
            end
        end
    end
    local function brasas(self, h, chao, t, pal)
        local n = math.max(
            4,
            math.floor(h.r / 5 + 0.5)
        )
        do
            local i = 0
            while i < n do
                local x = h.x - h.r + 3 + i * (h.r * 2 - 6) / math.max(1, n - 1)
                local f = math.sin(t * 22 + i * 2.3)
                px(
                    nil,
                    x - 2,
                    chao - 4,
                    5,
                    3,
                    if f > 0.3 then __get(pal, 2) else __get(pal, 1)
                )
                local a = ALT.brasa * if __t(__mod(i, 2)) then 0.55 else 1 * (0.75 + 0.25 * math.sin(t * 28 + i))
                do
                    local y = 0
                    while y < a do
                        local k = y / a
                        px(
                            nil,
                            x - 2 + math.sin(t * 30 + i + y * 0.2) * k * 2,
                            chao - 4 - y,
                            if k > 0.7 then 2 else 4,
                            3,
                            if k < 0.3 then __get(pal, 1) else if k < 0.7 then __get(pal, 2) else __get(pal, 3)
                        )
                        y = y + 3
                    end
                end
                i = i + 1
            end
        end
    end
    local function feixe(self, h, chao, t, pal)
        do
            local x = __TS__Number(-h.r)
            while __lt(x, h.r) do
                local f = 1 - math.abs(x + 2) / h.r
                ctx.globalAlpha = 0.35 + 0.55 * f
                px(
                    nil,
                    h.x + x,
                    0,
                    4,
                    chao,
                    if f > 0.75 then __get(pal, 3) else if f > 0.45 then __get(pal, 2) else __get(pal, 1)
                )
                x = x + 4
            end
        end
        ctx.globalAlpha = 1
        do
            local i = 0
            while i < 8 do
                local y = __mod(t * 380 + i * 70, chao)
                local x = h.x + (hsh(nil, i) - 0.5) * (h.r * 2 - 6)
                px(
                    nil,
                    x - 3,
                    y,
                    7,
                    1,
                    "#ffffff"
                )
                px(
                    nil,
                    x,
                    y - 3,
                    1,
                    7,
                    "#ffffff"
                )
                i = i + 1
            end
        end
        px(
            nil,
            h.x - h.r,
            chao - 3,
            h.r * 2,
            3,
            __get(pal, 3)
        )
    end
    local function zonaProvoca(self, h, chao, t, pal)
        ctx:save()
        ctx.globalAlpha = 0.28
        px(
            nil,
            h.x - h.r,
            chao - ALT.chao,
            h.r * 2,
            ALT.chao,
            __get(pal, 2)
        )
        ctx:restore()
        px(
            nil,
            h.x - h.r,
            chao - ALT.chao,
            h.r * 2,
            2,
            __get(pal, 3)
        )
        px(
            nil,
            h.x - h.r,
            chao - 3,
            h.r * 2,
            3,
            __get(pal, 1)
        )
        do
            local i = 0
            while i < 6 do
                local x = h.x - h.r + 12 + i * (h.r * 2 - 24) / 5
                local y = chao - 10 - __mod(t * 90 + i * 23, ALT.chao - 20)
                px(
                    nil,
                    x - 1,
                    y,
                    3,
                    10,
                    __get(pal, 3)
                )
                px(
                    nil,
                    x - 4,
                    y + 2,
                    9,
                    2,
                    __get(pal, 3)
                )
                px(
                    nil,
                    x - 3,
                    y + 1,
                    7,
                    1,
                    __get(pal, 3)
                )
                i = i + 1
            end
        end
    end
    local function desenharPerigo(self, c, h, t, lite, pal)
        if __t(not __t(c) or not __t(h)) then
            return false
        end
        local ____t_29 = __t
        local ____t_28 = __t
        local ____temp_27 = if __t(h.height) then h.type ~= "astral" else h.height
        __O[1572] = ____temp_27
        if ____t_29(if ____t_28(____temp_27) then __le(h.delay, 0) else __O[1572]) then
            return false
        end
        ctx = c
        local p = paleta(nil, h, pal)
        local chao = chaoDo(nil, h)
        if __gt(h.delay, 0) then
            aviso(
                nil,
                h,
                t,
                p,
                lite
            )
            return true
        end
        if h.type == "ring" then
            for ____, dir in __iterar((__arrL({-1, 1}, 2))) do
                rastro(
                    nil,
                    h,
                    dir,
                    chao,
                    p
                )
                crista(
                    nil,
                    h,
                    h.x + dir * h.r,
                    dir,
                    chao,
                    t,
                    p,
                    lite
                )
            end
            return true
        end
        if h.type == "astral" then
            feixe(
                nil,
                h,
                chao,
                t,
                p
            )
        elseif __t(h.brasa) then
            brasas(
                nil,
                h,
                chao,
                t,
                p
            )
        elseif h.type == "smoke" then
            nuvemChao(
                nil,
                h,
                chao,
                t,
                p
            )
        elseif h.type == "provoke" then
            zonaProvoca(
                nil,
                h,
                chao,
                t,
                p
            )
        else
            erupcao(
                nil,
                h,
                chao,
                t,
                p,
                lite
            )
        end
        return true
    end
    local gases = __arrL({}, 0)
    local function gas(self, x, y, raio, estagio, dir)
        __call(
            gases,
            "push",
            __assign(
                {},
                areaGas(nil, x, y, raio),
                {
                    estagio = if __t(estagio) then estagio else 1,
                    dir = if __lt(dir, 0) then -1 else 1,
                    idade = 0,
                    vida = 0.4 + if __t(estagio) then estagio else 1 * 0.05,
                    seed = math.random() * 100
                }
            )
        )
        if __len(gases) > 6 then
            __call(gases, "shift")
        end
    end
    local function atualizar(self, dt)
        for ____, g in __iterar((gases)) do
            g.idade = __add(g.idade, dt)
        end
        gases = __call(
            gases,
            "filter",
            function(____, g) return __lt(g.idade, g.vida) end
        )
    end
    local VERDE = __arrL({"#4f7a24", "#8fbf3c", "#bfe06a", "#eaf6b0"}, 4)
    local function desenharGas(self, c, t)
        ctx = c
        for ____, g in __iterar((gases)) do
            local p = g.idade / g.vida
            local abre = 1 - (1 - clamp(nil, g.idade / 0.12, 0, 1)) ^ 3
            local some = if p > 0.4 then 1 - (p - 0.4) / 0.6 else 1
            local rx = g.rx * abre
            local ry = g.ry * abre
            if rx < 4 then
                continue
            end
            c:save()
            if CHAO ~= nil then
                c:beginPath()
                c:rect(g.cx - g.rx - 30, g.cy - g.ry - 40, g.rx * 2 + 60, CHAO - (g.cy - g.ry - 40))
                c:clip()
            end
            local n = math.floor(8 + g.rx / 18 + 0.5)
            local base = ry * 0.38 + 3
            do
                local i = 0
                while i < n do
                    local an = i / n * math.pi * 2 + g.seed
                    local br = base * (0.7 + 0.45 * hsh(nil, i + g.seed)) * (1 - p * 0.25)
                    local sobe = p * 8
                    local x = g.cx + math.cos(an) * (rx - br)
                    local y = g.cy + math.sin(an) * (ry - br) - sobe
                    c.globalAlpha = some * 0.5
                    bolha(
                        nil,
                        x,
                        y,
                        br,
                        if math.sin(an) > 0.2 then __get(VERDE, 1) else __get(VERDE, 2)
                    )
                    c.globalAlpha = some * 0.6
                    bolha(
                        nil,
                        x - br * 0.25,
                        y - br * 0.3,
                        br * 0.3,
                        __get(VERDE, 3)
                    )
                    i = i + 1
                end
            end
            do
                local i = 0
                while i < 4 do
                    local an = i / 4 * math.pi * 2 + g.seed + 0.6
                    local br = base * 0.8
                    local x = g.cx + math.cos(an) * rx * 0.35
                    local y = g.cy + math.sin(an) * ry * 0.35 - p * 6
                    c.globalAlpha = some * 0.35
                    bolha(
                        nil,
                        x,
                        y,
                        br,
                        __get(VERDE, 2)
                    )
                    i = i + 1
                end
            end
            if g.estagio == 3 then
                do
                    local i = 0
                    while i < 6 do
                        local k = __mod(t * 1.6 + i / 6, 1)
                        local x = g.cx + (hsh(nil, i + g.seed) - 0.5) * rx * 1.4
                        local y = g.cy + (hsh(nil, i * 3 + g.seed) - 0.5) * ry - k * 10
                        c.globalAlpha = some * (1 - k)
                        px(
                            nil,
                            x,
                            y,
                            2,
                            2,
                            "#ffe08a"
                        )
                        i = i + 1
                    end
                end
            end
            c:restore()
        end
    end
    local mostrar = __re_test(
        __re("[?&]hitbox\\b", ""),
        window.location.search
    )
    local function contorno(self, c, b, cor)
        c.strokeStyle = cor
        c.lineWidth = 1
        c:strokeRect(
            math.floor(b.x0 + 0.5) + 0.5,
            math.floor(b.y0 + 0.5) + 0.5,
            math.floor(b.x1 - b.x0 + 0.5),
            math.floor(b.y1 - b.y0 + 0.5)
        )
    end
    local function desenharCaixas(self, c, s)
        local ____t_32 = __t
        local ____t_31 = __t
        local ____temp_30 = not __t(mostrar) or not __t(c)
        __O[1573] = ____temp_30
        if ____t_32(if ____t_31(____temp_30) then __O[1573] else not __t(s)) then
            return
        end
        c:save()
        if __t(s.player) then
            contorno(
                nil,
                c,
                heroi(nil, s.player),
                "#4dff7a"
            )
        end
        for ____, e in __iterar((if __t(s.enemies) then s.enemies else __arrL({}, 0))) do
            local ____t_35 = __t
            local ____t_34 = __t
            local ____temp_33 = __gt(e.hp, 0) and not __t(e.conquista)
            __O[1574] = ____temp_33
            if ____t_35(if ____t_34(____temp_33) then e.type ~= "igor" else __O[1574]) then
                contorno(
                    nil,
                    c,
                    chefe(nil, e),
                    "#ff5a5a"
                )
            end
        end
        for ____, m in __iterar((if __t(s.minions) then s.minions else __arrL({}, 0))) do
            if not __t(m.dead) then
                contorno(
                    nil,
                    c,
                    capanga(nil, m),
                    "#ff9a5a"
                )
            end
        end
        for ____, h in __iterar((if __t(s.hazards) then s.hazards else __arrL({}, 0))) do
            for ____, b in __iterar((perigoCaixas(
                nil,
                h,
                chaoDo(nil, h)
            ))) do
                contorno(nil, c, b, if __gt(h.delay, 0) then "#ffe08a" else "#ffd000")
            end
        end
        for ____, t in __iterar((if __t(s.shots) then s.shots else __arrL({}, 0))) do
            local f = formaTiro(nil, t)
            c.strokeStyle = if t.owner == "player" then "#8ad8ff" else "#ff60d0"
            if __t(f.caixa) then
                contorno(nil, c, f.caixa, c.strokeStyle)
            else
                c:beginPath()
                c:arc(
                    t.x,
                    t.y,
                    f.r,
                    0,
                    math.pi * 2
                )
                c:stroke()
            end
        end
        for ____, g in __iterar((gases)) do
            c.strokeStyle = "#c8ff60"
            c:beginPath()
            c:ellipse(
                g.cx,
                g.cy,
                g.rx,
                g.ry,
                0,
                0,
                math.pi * 2
            )
            c:stroke()
        end
        c:restore()
    end
    window.Golpes = __ord(
        {
            CORPO = CORPO,
            CAPANGA = CAPANGA,
            TIRO = TIRO,
            ONDA = ONDA,
            ALT = ALT,
            caixa = caixa,
            cruza = cruza,
            circuloCaixa = circuloCaixa,
            elipseCaixa = elipseCaixa,
            heroi = heroi,
            chefe = chefe,
            capanga = capanga,
            formaTiro = formaTiro,
            tiroAcerta = tiroAcerta,
            perigoCaixas = perigoCaixas,
            perigoAcerta = perigoAcerta,
            areaGas = areaGas,
            gasAcerta = gasAcerta,
            gasPega = gasPega,
            desenharPerigo = desenharPerigo,
            gas = gas,
            atualizar = atualizar,
            desenharGas = desenharGas,
            desenharCaixas = desenharCaixas,
            chao = function(____, v)
                CHAO = if __isFiniteN(v) then v else nil
            end,
            mostrarCaixas = function(____, v)
                mostrar = if v == nil then not __t(mostrar) else not not __t(v)
                return mostrar
            end
        },
        "CORPO,CAPANGA,TIRO,ONDA,ALT,caixa,cruza,circuloCaixa,elipseCaixa,heroi,chefe,capanga,formaTiro,tiroAcerta,perigoCaixas,perigoAcerta,areaGas,gasAcerta,gasPega,desenharPerigo,gas,atualizar,desenharGas,desenharCaixas,chao,mostrarCaixas"
    )
end)(nil)
return ____exports
