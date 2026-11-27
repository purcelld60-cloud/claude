--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __gt, __ge, __isFiniteN, __callq, __mod, __ord, __arrL, __iterar, __t, __get, __len = __JSR.__lt, __JSR.__gt, __JSR.__ge, __JSR.__isFiniteN, __JSR.__callq, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__len
local __call, __add, __new, __assign, __re, __re_replace = __JSR.__call, __JSR.__add, __JSR.__new, __JSR.__assign, __JSR.__re, __JSR.__re_replace
local ____lualib = require(script.Parent.lualib_bundle)
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__Number = ____lualib.__TS__Number
local ____exports = {}
local __O = {};
(function()
    local ganhar, garrafaEm, falar, escolher, perg, comprar, fechar, fundo, vendedor, balcao, garrafa, hud, loop, PW, LW, LH, PRECO, GARRAFA, FALA, st, salvar, ouvintes, box, c, aberto, raf, t, last, sel, falaTxt, falaT, humor, humorT, moedaFx, aoFechar, abriuT, lista, pos, DONO, liberada, sorte, R, hash
    function ganhar(self, n)
        st.moedas = math.max(
            0,
            math.floor(st.moedas + n + 0.5)
        )
        salvar(nil)
        for ____, f in __iterar((ouvintes)) do
            do
                pcall(function()
                    f(nil, st.moedas)
                end)
            end
        end
    end
    function garrafaEm(self, x, y)
        do
            local i = 0
            while i < 8 do
                local p = pos(nil, i)
                local ____t_14 = __t
                local ____t_13 = __t
                local ____temp_12 = math.abs(x - p.x) < 15 and __gt(y, p.y - 50)
                __O[499] = ____temp_12
                if ____t_14(if ____t_13(____temp_12) then __lt(y, p.y + 22) else __O[499]) then
                    return i
                end
                i = i + 1
            end
        end
        return -1
    end
    function falar(self, s, h)
        if h == nil then
            h = "fala"
        end
        falaTxt = s
        falaT = 0
        humor = h
        humorT = 0
    end
    function escolher(self, i)
        sel = i
        local p = __get(
            lista(nil),
            i
        )
        if __t(liberada(nil, p.id)) then
            falar(
                nil,
                __get(FALA.olhar, p.id),
                "aponta"
            )
        else
            falar(
                nil,
                (((("Essa aí? Só depois que alguém der um jeito n" .. if __call(
                    __get(
                        __get(DONO, p.id),
                        1
                    ),
                    "slice",
                    0,
                    1
                ) == "a" then "a" else "o") .. tostring(__call(
                    __get(
                        __get(DONO, p.id),
                        1
                    ),
                    "slice",
                    1
                ))) .. ". O ingrediente tá com ") .. if __t(__call(
                    __get(
                        __get(DONO, p.id),
                        1
                    ),
                    "startsWith",
                    "os"
                )) then "eles" else if __t(__call(
                    __get(
                        __get(DONO, p.id),
                        1
                    ),
                    "startsWith",
                    "a"
                )) then "ela" else "ele") .. "!",
                "nega"
            )
        end
        perg(nil)
    end
    function perg(self)
        local p = __get(
            lista(nil),
            sel
        )
        local tem = __call(
            PW:estado().desbloqueados,
            "includes",
            p.id
        )
        local preco = __get(PRECO, p.id)
        local livre = liberada(nil, p.id)
        local ____t_16 = __t
        local ____temp_15 = __ge(st.moedas, preco) and not __t(tem)
        __O[500] = ____temp_15
        local pode = if ____t_16(____temp_15) then livre else __O[500]
        box:querySelector(".perg").innerHTML = ((((((((("<b>GARRAFADA DE " .. tostring(p.nome)) .. "</b>") .. tostring(if __t(if __t(livre) then livre else tem) then p.desc else ("<span class=\"tranca\">🔒 Ainda não chegou na banca. Derrote " .. tostring(__call(
            __re_replace(
                __get(
                    __get(DONO, p.id),
                    1
                ),
                __re("^(a|o|os) ", ""),
                ""
            ),
            "toUpperCase"
        ))) .. " para o Seu Lindomar conseguir o ingrediente.</span>")) .. "<div class=\"p\">") .. if __t(tem) then "✔ VOCÊ JÁ TEM" else if __t(livre) then ("PREÇO: ● " .. tostring(preco)) .. " moedas" else "PREÇO: ● ???") .. "</div><div class=\"bts\"><button type=\"button\" class=\"comprar\" ") .. if __t(pode) then "" else "disabled") .. ">") .. if __t(tem) then "JÁ É SUA" else if __t(livre) then "COMPRAR" else "🔒 TRANCADA") .. "</button><button type=\"button\" class=\"mural\">MONTAR BUILD</button></div>"
        box:querySelector(".comprar"):addEventListener("click", comprar)
        box:querySelector(".mural"):addEventListener(
            "click",
            function()
                local tst = not not __t(aberto.teste)
                fechar(nil)
                PW:abrirMural({teste = tst})
            end
        )
    end
    function comprar(self)
        local p = __get(
            lista(nil),
            sel
        )
        local preco = __get(PRECO, p.id)
        if __t(__call(
            PW:estado().desbloqueados,
            "includes",
            p.id
        )) then
            falar(nil, FALA.tem, "nega")
            return
        end
        if not __t(liberada(nil, p.id)) then
            escolher(nil, sel)
            return
        end
        if __lt(st.moedas, preco) then
            falar(
                nil,
                sorte(nil, FALA.pobre),
                "nega"
            )
            return
        end
        ganhar(
            nil,
            __TS__Number(-preco)
        )
        PW:desbloquear(p.id)
        falar(
            nil,
            sorte(nil, FALA.comprou),
            "ri"
        )
        local q = pos(nil, sel)
        do
            local k = 0
            while k < 14 do
                __call(moedaFx, "push", {
                    x = 440,
                    y = 22,
                    tx = q.x,
                    ty = q.y - 20,
                    t = -k * 0.04
                })
                k = k + 1
            end
        end
        perg(nil)
    end
    function fechar(self)
        if not __t(aberto) then
            return
        end
        aberto = false
        box.classList:remove("on")
        window:setTimeout(
            function()
                if not __t(aberto) then
                    box.hidden = true
                end
            end,
            320
        )
        window:cancelAnimationFrame(raf)
        window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {active = false}}))
        local f = aoFechar
        aoFechar = nil
        if f ~= nil then
            f(nil)
        end
    end
    function fundo(self)
        do
            local x = 0
            while x < LW do
                R(
                    nil,
                    x,
                    0,
                    16,
                    190,
                    if __t(__mod(x, 32)) then "#6a4428" else "#5e3c24"
                )
                R(
                    nil,
                    x,
                    0,
                    1,
                    190,
                    "#4a2e18"
                )
                do
                    local y = 10
                    while y < 190 do
                        R(
                            nil,
                            x + 3 + __mod(x, 5),
                            y,
                            2,
                            2,
                            "#3a2414"
                        )
                        y = y + 37
                    end
                end
                x = x + 16
            end
        end
        R(
            nil,
            30,
            22,
            80,
            56,
            "#3a2414"
        )
        R(
            nil,
            34,
            26,
            72,
            48,
            "#9ac8e0"
        )
        R(
            nil,
            34,
            56,
            72,
            18,
            "#7aa852"
        )
        do
            local k = 0
            while k < 6 do
                R(
                    nil,
                    40 + k * 11,
                    50 - __mod(k, 3) * 3,
                    8,
                    8,
                    "#e8dcc8"
                )
                k = k + 1
            end
        end
        R(
            nil,
            69,
            26,
            3,
            48,
            "#3a2414"
        )
        R(
            nil,
            34,
            48,
            72,
            3,
            "#3a2414"
        )
        for ____, sy in __iterar((__arrL({40, 92}, 2))) do
            R(
                nil,
                130,
                sy,
                330,
                5,
                "#8a5a32"
            )
            R(
                nil,
                130,
                sy + 5,
                330,
                2,
                "#3a2414"
            )
            do
                local k = 0
                while k < 15 do
                    local px = 136 + k * 21
                    local h = 14 + __mod(k, 3) * 4
                    local col = __get(
                        __arrL({
                            "#c8a46a",
                            "#7a9a52",
                            "#a8743a",
                            "#c43c3a",
                            "#d8c8a0",
                            "#5a7a8a"
                        }, 6),
                        __mod(k, 6)
                    )
                    R(
                        nil,
                        px,
                        sy - h,
                        14,
                        h,
                        "#e8eef0"
                    )
                    R(
                        nil,
                        px + 1,
                        sy - h + 4,
                        12,
                        h - 5,
                        col
                    )
                    R(
                        nil,
                        px,
                        sy - h - 3,
                        14,
                        3,
                        "#8a5a32"
                    )
                    R(
                        nil,
                        px + 2,
                        sy - h + 2,
                        3,
                        h - 4,
                        "rgba(255,255,255,.35)"
                    )
                    k = k + 1
                end
            end
        end
        do
            local k = 0
            while k < 9 do
                local hx = 20 + k * 52 + if k > 1 then 70 else 0
                local sw = math.sin(t * 1.3 + k) * 1.5
                if hx > LW then
                    break
                end
                R(
                    nil,
                    hx,
                    0,
                    1,
                    10,
                    "#3a2414"
                )
                do
                    local j = 0
                    while j < 9 do
                        R(
                            nil,
                            hx - 5 + j + sw * (j / 9),
                            10 + math.abs(j - 4) * 2,
                            2,
                            12 - math.abs(j - 4),
                            __get(
                                __arrL({"#6a8a3a", "#8aa04a", "#a89a4a"}, 3),
                                __mod(j + k, 3)
                            )
                        )
                        j = j + 1
                    end
                end
                k = k + 1
            end
        end
        local ang = math.sin(t * 1.6) * 0.18
        local lx = 300 + math.sin(ang) * 30
        local ly = math.cos(ang) * 30 + 10
        c.strokeStyle = "#2a1a10"
        c:beginPath()
        c:moveTo(300, 0)
        c:lineTo(lx, ly)
        c:stroke()
        R(
            nil,
            lx - 6,
            ly,
            12,
            14,
            "#3a3a3a"
        )
        R(
            nil,
            lx - 4,
            ly + 2,
            8,
            9,
            "#ffd98a"
        )
        R(
            nil,
            lx - 2,
            ly - 3,
            4,
            3,
            "#3a3a3a"
        )
        local g = c:createRadialGradient(
            lx,
            ly + 6,
            4,
            lx,
            ly + 6,
            160
        )
        g:addColorStop(0, "rgba(255,214,140,.32)")
        g:addColorStop(1, "rgba(255,214,140,0)")
        c.fillStyle = g
        c:fillRect(0, 0, LW, LH)
        do
            local i = 0
            while i < 26 do
                local x = __mod(
                    hash(nil, i) * LW + t * (4 + __mod(i, 5)),
                    LW
                )
                local y = hash(nil, i * 3) * 180 + math.sin(t + i) * 8
                R(
                    nil,
                    x,
                    y,
                    1,
                    1,
                    "rgba(255,240,200,.5)"
                )
                i = i + 1
            end
        end
    end
    function vendedor(self)
        local bx = 70
        local by = 190
        local resp = math.floor(math.sin(t * 2) * 1.2 + 0.5)
        local pisca = __mod(t, 3.4) < 0.12
        local h = humor
        local lean = if h == "aponta" then math.min(1, humorT * 4) * 6 else 0
        local ri = h == "ri" and humorT < 1.6
        local nega = h == "nega" and humorT < 1.2
        local shake = if __t(nega) then math.floor(math.sin(humorT * 30) * 3 + 0.5) else 0
        local y0 = by - 120 + resp
        R(
            nil,
            bx - 2,
            y0 + 50,
            92,
            90,
            "#2a1a10"
        )
        R(
            nil,
            bx,
            y0 + 52,
            88,
            88,
            "#8a5a3a"
        )
        R(
            nil,
            bx + 18,
            y0 + 56,
            52,
            84,
            "#efe4cc"
        )
        R(
            nil,
            bx + 18,
            y0 + 56,
            52,
            4,
            "#d8cba8"
        )
        R(
            nil,
            bx + 40,
            y0 + 64,
            8,
            10,
            "#c43c3a"
        )
        local braco = if h == "aponta" then -18 - lean else if __t(ri) then -10 + math.sin(humorT * 12) * 4 else 0
        R(
            nil,
            bx + 80,
            y0 + 60 + braco,
            20,
            12,
            "#8a5a3a"
        )
        R(
            nil,
            bx + 96,
            y0 + 58 + braco,
            12,
            12,
            "#d8a07a"
        )
        if h == "aponta" then
            R(
                nil,
                bx + 106,
                y0 + 61 + braco,
                10,
                4,
                "#d8a07a"
            )
        end
        R(
            nil,
            bx - 10,
            y0 + 70,
            16,
            30,
            "#8a5a3a"
        )
        R(
            nil,
            bx - 10,
            y0 + 98,
            14,
            12,
            "#d8a07a"
        )
        local hx = bx + 22 + lean + shake
        local hy = y0 + 4
        R(
            nil,
            hx,
            hy + 8,
            44,
            44,
            "#d8a07a"
        )
        R(
            nil,
            hx + 34,
            hy + 8,
            10,
            44,
            "#c48a64"
        )
        R(
            nil,
            hx,
            hy + 44,
            44,
            8,
            "#c48a64"
        )
        R(
            nil,
            hx - 2,
            hy + 24,
            4,
            10,
            "#c48a64"
        )
        R(
            nil,
            hx + 42,
            hy + 24,
            4,
            10,
            "#c48a64"
        )
        R(
            nil,
            hx + 6,
            hy + 20,
            14,
            10,
            "#2a2a2a"
        )
        R(
            nil,
            hx + 24,
            hy + 20,
            14,
            10,
            "#2a2a2a"
        )
        R(
            nil,
            hx + 8,
            hy + 22,
            10,
            6,
            "#c8e0e8"
        )
        R(
            nil,
            hx + 26,
            hy + 22,
            10,
            6,
            "#c8e0e8"
        )
        R(
            nil,
            hx + 20,
            hy + 23,
            4,
            2,
            "#2a2a2a"
        )
        if not __t(pisca) then
            R(
                nil,
                hx + 11,
                hy + 23,
                4,
                4,
                "#2a2a2a"
            )
            R(
                nil,
                hx + 29,
                hy + 23,
                4,
                4,
                "#2a2a2a"
            )
        else
            R(
                nil,
                hx + 10,
                hy + 25,
                6,
                1,
                "#2a2a2a"
            )
            R(
                nil,
                hx + 28,
                hy + 25,
                6,
                1,
                "#2a2a2a"
            )
        end
        R(
            nil,
            hx + 18,
            hy + 30,
            8,
            8,
            "#c48a64"
        )
        local bg = math.floor(math.sin(t * 5) * if __t(ri) then 2 else 0.6 + 0.5)
        R(
            nil,
            hx + 6,
            hy + 37 + bg,
            32,
            7,
            "#f2efe6"
        )
        R(
            nil,
            hx + 4,
            hy + 40 + bg,
            6,
            6,
            "#f2efe6"
        )
        R(
            nil,
            hx + 34,
            hy + 40 + bg,
            6,
            6,
            "#f2efe6"
        )
        if __t(ri) then
            R(
                nil,
                hx + 14,
                hy + 45,
                16,
                5,
                "#5a2a1a"
            )
            R(
                nil,
                hx + 16,
                hy + 45,
                12,
                2,
                "#ffffff"
            )
        else
            R(
                nil,
                hx + 16,
                hy + 46,
                12,
                2,
                "#7a3a2a"
            )
        end
        R(
            nil,
            hx - 14,
            hy + 2,
            72,
            8,
            "#d7b665"
        )
        R(
            nil,
            hx - 14,
            hy + 2,
            72,
            2,
            "#f2d898"
        )
        R(
            nil,
            hx + 2,
            hy - 14,
            40,
            18,
            "#d7b665"
        )
        R(
            nil,
            hx + 2,
            hy - 2,
            40,
            4,
            "#c43c3a"
        )
        do
            local k = 0
            while k < 40 do
                R(
                    nil,
                    hx + 2 + k,
                    hy - 14,
                    2,
                    16,
                    "#c8a050"
                )
                k = k + 4
            end
        end
        if __t(ri) then
            c.font = "10px Pixel, monospace"
            c.fillStyle = "#ffd98a"
            c:fillText("HÉ HÉ!", hx + 50, hy - 4 - humorT * 6)
        end
    end
    function balcao(self)
        R(
            nil,
            0,
            190,
            LW,
            80,
            "#5a3a20"
        )
        R(
            nil,
            0,
            190,
            LW,
            6,
            "#8a5a32"
        )
        R(
            nil,
            0,
            196,
            LW,
            2,
            "#3a2414"
        )
        do
            local x = 0
            while x < LW do
                R(
                    nil,
                    x,
                    198,
                    2,
                    72,
                    "#4a2e18"
                )
                x = x + 40
            end
        end
        R(
            nil,
            0,
            236,
            LW,
            3,
            "#3a2414"
        )
        c.font = "8px Pixel, monospace"
        local nw = math.ceil(c:measureText("GARRAFADAS DO SEU LINDOMAR").width)
        R(
            nil,
            10,
            244,
            nw + 14,
            18,
            "#3a2414"
        )
        R(
            nil,
            12,
            246,
            nw + 10,
            14,
            "#c8a46a"
        )
        c.fillStyle = "#3a2414"
        c:fillText("GARRAFADAS DO SEU LINDOMAR", 17, 256)
    end
    function garrafa(self, i)
        local p = __get(
            lista(nil),
            i
        )
        local q = pos(nil, i)
        local tem = __call(
            PW:estado().desbloqueados,
            "includes",
            p.id
        )
        local on = i == sel
        local sobe = if __t(on) then 10 + math.sin(t * 3) * 2 else math.sin(t * 2 + i) * 0.6
        local x = q.x
        local y = q.y - sobe
        local ____t_20 = __t
        local ____liberada_result_19 = liberada(nil, p.id)
        __O[501] = ____liberada_result_19
        local livre = if ____t_20(____liberada_result_19) then __O[501] else tem
        local cor = if __t(livre) then p.cor else "#2a1e16"
        local forma = __get(GARRAFA, p.id)
        if __t(on) then
            local g = c:createRadialGradient(
                x,
                y - 18,
                2,
                x,
                y - 18,
                34
            )
            g:addColorStop(
                0,
                tostring(cor) .. "aa"
            )
            g:addColorStop(
                1,
                tostring(cor) .. "00"
            )
            c.fillStyle = g
            c:fillRect(x - 40, y - 60, 80, 80)
        end
        R(
            nil,
            x - 11,
            q.y + 2,
            22,
            3,
            "rgba(0,0,0,.35)"
        )
        local vid = if __t(livre) then "#dceef2" else "#3a2e24"
        local function liq(____, yy, h, w)
            R(
                nil,
                x - w / 2,
                yy,
                w,
                h,
                cor
            )
            R(
                nil,
                x - w / 2,
                yy,
                w,
                2,
                "#ffffff66"
            )
            R(
                nil,
                x - w / 2 + 1,
                yy + math.floor(math.sin(t * 4 + i) * 1 + 0.5) + 2,
                w - 2,
                1,
                "#ffffff44"
            )
        end
        if forma == "redonda" then
            c.fillStyle = vid
            c:beginPath()
            c:arc(
                x,
                y - 10,
                11,
                0,
                math.pi * 2
            )
            __call(c, "fill")
            c.fillStyle = cor
            c:beginPath()
            c:arc(
                x,
                y - 8,
                9,
                0,
                math.pi
            )
            __call(c, "fill")
            R(
                nil,
                x - 3,
                y - 28,
                6,
                9,
                vid
            )
            R(
                nil,
                x - 4,
                y - 31,
                8,
                4,
                "#8a5a32"
            )
        end
        if forma == "alta" then
            R(
                nil,
                x - 7,
                y - 34,
                14,
                34,
                vid
            )
            liq(nil, y - 22, 22, 12)
            R(
                nil,
                x - 3,
                y - 44,
                6,
                10,
                vid
            )
            R(
                nil,
                x - 4,
                y - 47,
                8,
                4,
                "#8a5a32"
            )
        end
        if forma == "pote" then
            R(
                nil,
                x - 11,
                y - 22,
                22,
                22,
                vid
            )
            liq(nil, y - 16, 16, 20)
            R(
                nil,
                x - 12,
                y - 26,
                24,
                5,
                "#8a5a32"
            )
        end
        if forma == "frasco" then
            R(
                nil,
                x - 9,
                y - 20,
                18,
                20,
                vid
            )
            liq(nil, y - 14, 14, 16)
            R(
                nil,
                x - 4,
                y - 30,
                8,
                10,
                vid
            )
            R(
                nil,
                x - 5,
                y - 33,
                10,
                4,
                "#c8ccd0"
            )
            R(
                nil,
                x + 5,
                y - 18,
                2,
                2,
                "#ffffff"
            )
        end
        if forma == "bule" then
            R(
                nil,
                x - 10,
                y - 18,
                20,
                18,
                if __t(livre) then "#f6f2ea" else vid
            )
            R(
                nil,
                x - 8,
                y - 16,
                16,
                4,
                cor
            )
            R(
                nil,
                x + 10,
                y - 14,
                6,
                3,
                if __t(livre) then "#f6f2ea" else vid
            )
            R(
                nil,
                x - 4,
                y - 22,
                8,
                4,
                if __t(livre) then "#f6f2ea" else vid
            )
            do
                local k = 0
                while k < 3 do
                    R(
                        nil,
                        x - 4 + k * 4,
                        y - 30 - math.sin(t * 5 + k) * 2,
                        2,
                        5,
                        "rgba(255,255,255,.6)"
                    )
                    k = k + 1
                end
            end
        end
        if forma == "quadrada" then
            R(
                nil,
                x - 10,
                y - 26,
                20,
                26,
                vid
            )
            liq(nil, y - 20, 20, 18)
            R(
                nil,
                x - 3,
                y - 32,
                6,
                6,
                vid
            )
            R(
                nil,
                x - 4,
                y - 35,
                8,
                4,
                "#8a5a32"
            )
            R(
                nil,
                x - 6,
                y - 16,
                12,
                8,
                if __t(livre) then "#f2e8c8" else "#4a3a2e"
            )
            R(
                nil,
                x - 3,
                y - 14,
                6,
                4,
                if __t(livre) then "#c43c3a" else "#3a2a20"
            )
        end
        if forma == "tubo" then
            R(
                nil,
                x - 5,
                y - 36,
                10,
                36,
                vid
            )
            liq(nil, y - 28, 28, 8)
            do
                local k = 0
                while k < 4 do
                    R(
                        nil,
                        x - 4,
                        y - 26 + k * 6,
                        8,
                        1,
                        "#0e1016"
                    )
                    k = k + 1
                end
            end
            R(
                nil,
                x - 6,
                y - 39,
                12,
                4,
                "#2a2c34"
            )
        end
        if forma == "coracao" then
            c.fillStyle = vid
            c:beginPath()
            c:arc(
                x - 5,
                y - 16,
                7,
                0,
                math.pi * 2
            )
            c:arc(
                x + 5,
                y - 16,
                7,
                0,
                math.pi * 2
            )
            __call(c, "fill")
            c:beginPath()
            c:moveTo(x - 12, y - 14)
            c:lineTo(x + 12, y - 14)
            c:lineTo(x, y)
            __call(c, "fill")
            c.fillStyle = cor
            c:beginPath()
            c:arc(
                x - 5,
                y - 14,
                5,
                0,
                math.pi * 2
            )
            c:arc(
                x + 5,
                y - 14,
                5,
                0,
                math.pi * 2
            )
            __call(c, "fill")
            R(
                nil,
                x - 2,
                y - 28,
                4,
                6,
                vid
            )
            R(
                nil,
                x - 3,
                y - 31,
                6,
                4,
                "#e8c24c"
            )
        end
        c.font = "7px Pixel, monospace"
        c.textAlign = "center"
        if __t(tem) then
            c:save()
            c:translate(x, q.y + 12)
            c:rotate(-0.2)
            R(
                nil,
                -14,
                -5,
                28,
                10,
                "#c43c3a"
            )
            c.fillStyle = "#fff6dc"
            c:fillText("É SUA", 0, 3)
            c:restore()
        elseif not __t(livre) then
            R(
                nil,
                x - 13,
                q.y + 8,
                26,
                10,
                "#5a4a3a"
            )
            c.fillStyle = "#c8b8a0"
            c:fillText("???", x, q.y + 16)
            local ly = y - 34 + math.floor(math.sin(t * 2.4 + i) * 1.5 + 0.5)
            R(
                nil,
                x - 5,
                ly - 6,
                10,
                1,
                "#2a0808"
            )
            R(
                nil,
                x - 6,
                ly - 5,
                1,
                4,
                "#2a0808"
            )
            R(
                nil,
                x + 5,
                ly - 5,
                1,
                4,
                "#2a0808"
            )
            R(
                nil,
                x - 5,
                ly - 5,
                1,
                4,
                "#9aa0a6"
            )
            R(
                nil,
                x + 4,
                ly - 5,
                1,
                4,
                "#9aa0a6"
            )
            R(
                nil,
                x - 7,
                ly - 1,
                14,
                10,
                "#2a0808"
            )
            R(
                nil,
                x - 6,
                ly,
                12,
                8,
                "#d83a3a"
            )
            R(
                nil,
                x - 6,
                ly,
                12,
                1,
                "#ff8a7a"
            )
            R(
                nil,
                x - 1,
                ly + 2,
                2,
                4,
                "#2a0808"
            )
        else
            R(
                nil,
                x - 13,
                q.y + 8,
                26,
                10,
                "#f2e2b8"
            )
            R(
                nil,
                x - 13,
                q.y + 8,
                26,
                1,
                "#ffffff"
            )
            c.fillStyle = if __ge(
                st.moedas,
                __get(PRECO, p.id)
            ) then "#3a2414" else "#a83a2a"
            c:fillText(
                __add(
                    "●",
                    __get(PRECO, p.id)
                ),
                x,
                q.y + 16
            )
        end
        c.textAlign = "left"
    end
    function hud(self)
        R(
            nil,
            LW - 92,
            8,
            84,
            20,
            "#2a1a10"
        )
        R(
            nil,
            LW - 90,
            10,
            80,
            16,
            "#4a3420"
        )
        c.fillStyle = "#ffd24a"
        c:beginPath()
        c:arc(
            LW - 78,
            18,
            6,
            0,
            math.pi * 2
        )
        __call(c, "fill")
        R(
            nil,
            LW - 79,
            14,
            2,
            8,
            "#c8962a"
        )
        c.font = "10px Pixel, monospace"
        c.fillStyle = "#ffe9a8"
        c:fillText(
            tostring(st.moedas),
            LW - 66,
            22
        )
        if __t(falaTxt) then
            local n = math.min(
                __len(falaTxt),
                math.floor(falaT * 40)
            )
            local txt = __call(falaTxt, "slice", 0, n)
            local lines = __arrL({}, 0)
            local words = __call(txt, "split", " ")
            local cur = ""
            for ____, w in __iterar((words)) do
                if __len(__add(
                    __add(cur, " "),
                    w
                )) > 34 then
                    __call(lines, "push", cur)
                    cur = w
                else
                    cur = __call(
                        __add(
                            __add(cur, " "),
                            w
                        ),
                        "trim"
                    )
                end
            end
            __call(lines, "push", cur)
            local bw = 190
            local bh = 10 + __len(lines) * 11
            local bx = 128
            local by = 26
            R(
                nil,
                bx,
                by,
                bw,
                bh,
                "#2a1a10"
            )
            R(
                nil,
                bx + 2,
                by + 2,
                bw - 4,
                bh - 4,
                "#fbf2dc"
            )
            R(
                nil,
                bx + 2,
                by + bh - 2,
                10,
                8,
                "#fbf2dc"
            )
            R(
                nil,
                bx,
                by + bh,
                4,
                8,
                "#2a1a10"
            )
            c.font = "8px Pixel, monospace"
            c.fillStyle = "#3a2414"
            __call(
                lines,
                "forEach",
                function(____, l, k) return c:fillText(l, bx + 8, by + 14 + k * 11) end
            )
        end
        for ____, m in __iterar((moedaFx)) do
            if __lt(m.t, 0) then
                continue
            end
            local u = math.min(1, m.t / 0.5)
            local x = m.x + (m.tx - m.x) * u
            local y = m.y + (m.ty - m.y) * u - math.sin(u * math.pi) * 30
            c.fillStyle = "#ffd24a"
            c:beginPath()
            c:arc(
                x,
                y,
                3,
                0,
                math.pi * 2
            )
            __call(c, "fill")
        end
    end
    function loop(self, now)
        if not __t(aberto) then
            return
        end
        raf = window:requestAnimationFrame(loop)
        local dt = math.max(
            0,
            math.min(0.05, (now - last) / 1000)
        )
        last = now
        t = t + dt
        falaT = falaT + dt
        humorT = humorT + dt
        abriuT = abriuT + dt
        moedaFx = __call(
            moedaFx,
            "filter",
            function(____, m)
                m.t = m.t + dt
                return __lt(m.t, 0.55)
            end
        )
        c:save()
        local zoom = 1 + math.max(0, 0.3 - abriuT) * 0.6
        c:translate(LW / 2, LH / 2)
        c:scale(zoom, zoom)
        c:translate(-LW / 2, -LH / 2)
        fundo(nil)
        vendedor(nil)
        balcao(nil)
        do
            local i = 0
            while i < 8 do
                garrafa(nil, i)
                i = i + 1
            end
        end
        hud(nil)
        c:restore()
    end
    local ____ = "use strict"
    if __t(if __t(window.CampanhaLoja) then window.CampanhaLoja else not __t(window.CampanhaPoderes)) then
        return
    end
    PW = window.CampanhaPoderes
    local KEY = "daroca-c2-loja"
    LW = 480
    LH = 270
    PRECO = __ord({
        fofoca = 30,
        buzina = 40,
        biscoito = 45,
        flash = 60,
        cafezao = 70,
        supersoco = 85,
        clone = 110,
        aura = 150
    }, "fofoca,buzina,biscoito,flash,cafezao,supersoco,clone,aura")
    GARRAFA = __ord({
        fofoca = "redonda",
        buzina = "alta",
        biscoito = "pote",
        flash = "frasco",
        cafezao = "bule",
        supersoco = "quadrada",
        clone = "tubo",
        aura = "coracao"
    }, "fofoca,buzina,biscoito,flash,cafezao,supersoco,clone,aura")
    FALA = __ord(
        {
            oi = __arrL({"Chegue, freguês! Garrafada boa cura até falta de coragem.", "Ô, o rapaz do chapéu! Veio montar a sua sorte?", "Tudo raiz da serra, colhida na lua certa. Quase tudo."}, 3),
            olhar = __ord({
                fofoca = "Essa aí é de língua solta. Um gole e todo mundo briga com todo mundo.",
                buzina = "Raiz de buzina de mototáxi. Não me pergunte como se colhe.",
                biscoito = "Polvilho benzido. Crocante por fora, perigoso por dentro.",
                flash = "Feita com a luz de mil stories. Não olhe direto.",
                cafezao = "Café do planalto com mais três cafés dentro. Coração fraco, não.",
                supersoco = "Essa é forte. Segura, carrega e solta. Igual saudade.",
                clone = "Garrafada digital. Veio num pendrive, juro.",
                aura = "A mais rara. Não é feita de raiz... é feita de amizade."
            }, "fofoca,buzina,biscoito,flash,cafezao,supersoco,clone,aura"),
            comprou = __arrL({"Boa escolha, meu rei! Volte sempre!", "Vendido! Agora vai lá no mural do quarto e equipa, viu?", "Hé hé! Essa vai fazer diferença."}, 3),
            pobre = __arrL({"Tá faltando moeda, freguês. Vai lá, que os encrenqueiros da cidade pagam bem.", "Fiado só amanhã. E amanhã nunca chega."}, 2),
            tem = "Essa você já tem, meu filho. Não precisa de duas."
        },
        "oi,olhar,comprou,pobre,tem"
    )
    st = {moedas = 0}
    do
        pcall(function()
            local ____self_2 = window.JSON
            local ____self_2_parse_3 = ____self_2.parse
            local ____t_1 = __t
            local ____temp_0 = window.localStorage:getItem(KEY)
            __O[498] = ____temp_0
            local s = ____self_2_parse_3(____self_2, if ____t_1(____temp_0) then __O[498] else "null")
            if __t(if __t(s) then __isFiniteN(s.moedas) else s) then
                st = s
            end
        end)
    end
    salvar = function()
        do
            pcall(function()
                window.localStorage:setItem(
                    KEY,
                    window.JSON:stringify(st)
                )
            end)
        end
    end
    ouvintes = __TS__New(Set)
    box = nil
    local cv = nil
    c = nil
    aberto = false
    raf = 0
    t = 0
    last = 0
    sel = 0
    falaTxt = ""
    falaT = 0
    humor = "oi"
    humorT = 0
    moedaFx = __arrL({}, 0)
    aoFechar = nil
    abriuT = 0
    lista = function() return PW:lista() end
    local function css(self)
        if __t(window.document:getElementById("c2LojaCss")) then
            return
        end
        local s = window.document:createElement("style")
        s.id = "c2LojaCss"
        s.textContent = ".c2-loja{position:fixed;inset:0;z-index:2147483150;background:#120c08;display:grid;place-items:center;font-family:Pixel,monospace;color:#2a1a10;opacity:0;transition:opacity .3s}.c2-loja.on{opacity:1}.c2-loja[hidden]{display:none}\n.c2-loja .tela{position:relative;width:min(100vw,177.7vh);aspect-ratio:16/9;max-height:100vh}.c2-loja canvas{width:100%;height:100%;image-rendering:pixelated;display:block}\n.c2-loja .perg{position:absolute;right:2.5%;top:12.5%;width:30%;background:#f2e2b8;border:3px solid #5a3a20;box-shadow:4px 4px 0 #2a1a10;padding:10px 12px;font-size:clamp(8px,1.15vw,12px);line-height:1.5;transform:rotate(1deg)}.c2-loja .perg .tranca{display:block;color:#a83a2a;margin-top:2px}.c2-loja .perg b{display:block;font-size:1.15em;color:#7a2a1a;margin-bottom:4px}.c2-loja .perg .p{margin-top:6px;font-size:1.1em}\n.c2-loja button{font:inherit;font-size:clamp(9px,1.2vw,12px);padding:8px 12px;background:#e8a83a;color:#1c1408;border:3px solid #5a3a20;box-shadow:0 4px 0 #3a2410;cursor:pointer}.c2-loja button:active{transform:translateY(3px);box-shadow:0 1px 0 #3a2410}.c2-loja button[disabled]{opacity:.5;cursor:default}.c2-loja .bts{display:flex;gap:6px;margin-top:8px;flex-wrap:wrap}\n.c2-loja .sair{position:absolute;left:2%;top:3%;background:#4a3420;color:#f6ead0;border-color:#e8c66a}"
        window.document.head:appendChild(s)
    end
    local function montar(self)
        css(nil)
        box = window.document:createElement("div")
        box.className = "c2-loja"
        box.hidden = true
        box:setAttribute("role", "dialog")
        box:setAttribute("aria-label", "Garrafadas do Seu Lindomar")
        box.innerHTML = "<div class=\"tela\"><canvas width=\"480\" height=\"270\"></canvas><div class=\"perg\"></div><button type=\"button\" class=\"sair\">✕ SAIR DA LOJA</button></div>"
        window.document.body:appendChild(box)
        cv = box:querySelector("canvas")
        c = cv:getContext("2d")
        c.imageSmoothingEnabled = false
        box:querySelector(".sair"):addEventListener("click", fechar)
        cv:addEventListener(
            "pointerdown",
            function(____, e)
                local r = cv:getBoundingClientRect()
                local x = (e.clientX - r.left) / r.width * LW
                local y = (e.clientY - r.top) / r.height * LH
                local i = garrafaEm(nil, x, y)
                if i >= 0 then
                    if i == sel then
                        comprar(nil)
                    else
                        escolher(nil, i)
                    end
                end
            end
        )
        window:addEventListener(
            "keydown",
            function(____, e)
                if not __t(aberto) then
                    return
                end
                local k = e.key
                if k == "Escape" then
                    fechar(nil)
                elseif k == "ArrowRight" then
                    escolher(
                        nil,
                        __mod(sel + 1, 8)
                    )
                elseif k == "ArrowLeft" then
                    escolher(
                        nil,
                        __mod(sel + 7, 8)
                    )
                elseif __t(k == "Enter" or k == " ") then
                    comprar(nil)
                else
                    return
                end
                e:preventDefault()
                e:stopImmediatePropagation()
            end,
            true
        )
    end
    pos = function(____, i) return {x = 196 + i * 34, y = 214} end
    DONO = __ord(
        {
            fofoca = __arrL({"creuza", "a Dona Creuza"}, 2),
            buzina = __arrL({"tonhao", "o Tonhão do Mototáxi"}, 2),
            biscoito = __arrL({"valdomiro", "o Seu Valdomiro"}, 2),
            flash = __arrL({"kaua", "o Kauã Influencer"}, 2),
            cafezao = __arrL({"barao", "o Barão do Café"}, 2),
            supersoco = __arrL({"breno", "o Breno Pitbull"}, 2),
            clone = __arrL({"gemeos", "os gêmeos Ryan e Bryan"}, 2),
            aura = __arrL({"fred", "o Fred"}, 2)
        },
        "fofoca,buzina,biscoito,flash,cafezao,supersoco,clone,aura"
    )
    liberada = function(____, id)
        local ____temp_11 = not __t(__get(DONO, id))
        if not ____temp_11 then
            local ____t_10 = __t
            local ____callq_9 = __callq
            local ____opt_6 = window.CampanhaTaxi
            if ____opt_6 ~= nil then
                ____opt_6 = ____opt_6.vencidos
            end
            local ____opt_result_8
            if ____opt_6 ~= nil then
                ____opt_result_8 = ____opt_6(____opt_6)
            end
            ____temp_11 = not not ____t_10(____callq_9(
                ____opt_result_8,
                "includes",
                __get(
                    __get(DONO, id),
                    0
                )
            ))
        end
        return ____temp_11
    end
    sorte = function(____, a) return __get(
        a,
        math.floor(math.random() * __len(a))
    ) end
    local function abrir(self, o)
        if o == nil then
            o = {}
        end
        if not __t(box) then
            montar(nil)
        end
        aberto = {teste = not not __t(o.teste)}
        aoFechar = if __t(o.onClose) then o.onClose else nil
        box.hidden = false
        window:requestAnimationFrame(function() return __call(box.classList, "add", "on") end)
        sel = 0
        falar(
            nil,
            sorte(nil, FALA.oi),
            "oi"
        )
        perg(nil)
        abriuT = 0
        last = window.performance:now()
        window:cancelAnimationFrame(raf)
        raf = window:requestAnimationFrame(loop)
        window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {active = true}}))
        return true
    end
    R = function(____, x, y, w, h, col)
        c.fillStyle = col
        c:fillRect(
            math.floor(x + 0.5),
            math.floor(y + 0.5),
            math.floor(w + 0.5),
            math.floor(h + 0.5)
        )
    end
    hash = function(____, n)
        local x = math.sin(n * 127.1 + 311.7) * 43758.5453
        return x - math.floor(x)
    end
    local ____opt_23 = window.CampanhaPersonagens
    if ____opt_23 ~= nil then
        ____opt_23 = ____opt_23.registrar
    end
    if ____opt_23 ~= nil then
        ____opt_23(
            ____opt_23,
            "c2_lindomar",
            __ord(
                {
                    name = "Seu Lindomar Raizeiro",
                    skin = "#d8a07a",
                    shade = "#c48a64",
                    build = "belly",
                    h = 0.95,
                    top = "#8a5a3a",
                    topKind = "apron",
                    apron = "#efe4cc",
                    pants = "#4a4a3a",
                    hat = __ord({kind = "straw", color = "#d7b665"}, "kind,color"),
                    hair = __ord({style = "short", color = "#e0dcd4"}, "style,color"),
                    mustache = "#f2efe6",
                    glasses = "#2a2a2a",
                    pose = "offer"
                },
                "name,skin,shade,build,h,top,topKind,apron,pants,hat,hair,mustache,glasses,pose"
            ),
            "vendedor (loja de poções)"
        )
    end
    local BANCA = __ord({cena = 17, x = 1460}, "cena,x")
    local function desenharBanca(self, c2, o)
        if __TS__Number(o.scene) ~= BANCA.cena then
            return
        end
        local x = BANCA.x
        local y = 440
        local ____t_26 = __t
        local ____TS__Number_result_25 = __TS__Number(o.time)
        __O[502] = ____TS__Number_result_25
        local t2 = if ____t_26(____TS__Number_result_25) then __O[502] else 0
        local function R2(____, a, b, w, h, col)
            c2.fillStyle = col
            c2:fillRect(
                math.floor(a + 0.5),
                math.floor(b + 0.5),
                w,
                h
            )
        end
        local ____t_28 = __t
        local ____TS__Number_result_27 = __TS__Number(o.camera)
        __O[503] = ____TS__Number_result_27
        if math.abs(x - if ____t_28(____TS__Number_result_27) then __O[503] else 0 - 480) > 640 then
            return
        end
        R2(
            nil,
            x - 70,
            y - 50,
            120,
            30,
            "#8a5a32"
        )
        R2(
            nil,
            x - 70,
            y - 50,
            120,
            4,
            "#c8985a"
        )
        for ____, wx in __iterar((__arrL({x - 50, x + 30}, 2))) do
            R2(
                nil,
                wx - 12,
                y - 24,
                24,
                24,
                "#3a2414"
            )
            R2(
                nil,
                wx - 4,
                y - 16,
                8,
                8,
                "#8a5a32"
            )
        end
        R2(
            nil,
            x + 50,
            y - 40,
            40,
            4,
            "#6a4428"
        )
        local cores = __arrL({
            "#e48fb0",
            "#f08a24",
            "#e9d6a8",
            "#c8d8ff",
            "#a8743a",
            "#e8433a",
            "#5ae0d0",
            "#ffd24a"
        }, 8)
        __call(
            cores,
            "forEach",
            function(____, col, k)
                local bx = x - 64 + k * 14
                local h = 16 + __mod(k, 3) * 6
                R2(
                    nil,
                    bx,
                    y - 50 - h,
                    10,
                    h,
                    "#dceef2"
                )
                R2(
                    nil,
                    bx + 1,
                    y - 50 - h + 6,
                    8,
                    h - 7,
                    col
                )
                R2(
                    nil,
                    bx + 2,
                    y - 54 - h,
                    6,
                    4,
                    "#8a5a32"
                )
            end
        )
        R2(
            nil,
            x - 76,
            y - 120,
            4,
            70,
            "#6a4428"
        )
        R2(
            nil,
            x + 50,
            y - 120,
            4,
            70,
            "#6a4428"
        )
        R2(
            nil,
            x - 84,
            y - 128,
            146,
            12,
            "#c43c3a"
        )
        do
            local k = 0
            while k < 146 do
                R2(
                    nil,
                    x - 84 + k,
                    y - 128,
                    6,
                    12,
                    "#f6ead0"
                )
                k = k + 12
            end
        end
        R2(
            nil,
            x - 70,
            y - 146,
            116,
            16,
            "#3a2414"
        )
        R2(
            nil,
            x - 68,
            y - 144,
            112,
            12,
            "#f2e2b8"
        )
        c2.font = "9px Pixel, monospace"
        c2.textAlign = "center"
        c2.fillStyle = "#7a2a1a"
        c2:fillText("GARRAFADAS", x - 12, y - 134)
        c2.textAlign = "left"
        local ____opt_31 = window.Art
        if ____opt_31 ~= nil then
            ____opt_31 = ____opt_31.drawCharacter
        end
        if ____opt_31 ~= nil then
            ____opt_31(
                ____opt_31,
                c2,
                "c2_lindomar",
                x + 74,
                y,
                {frame = t2, facing = -1, moving = false, grounded = true}
            )
        end
        local ____t_36 = __t
        local ____opt_33 = o.player
        if ____opt_33 ~= nil then
            ____opt_33 = ____opt_33.x
        end
        local ____TS__Number_result_35 = __TS__Number(____opt_33)
        __O[504] = ____TS__Number_result_35
        local hx = if ____t_36(____TS__Number_result_35) then __O[504] else -9999
        if math.abs(hx - x) < 110 then
            local dy = math.floor(math.sin(t2 * 5) * 3 + 0.5)
            R2(
                nil,
                x + 64,
                y - 132 + dy,
                22,
                22,
                "#2a1a14"
            )
            R2(
                nil,
                x + 66,
                y - 130 + dy,
                18,
                18,
                "#ffd24a"
            )
            c2.fillStyle = "#2a1a14"
            c2.font = "14px Pixel, monospace"
            c2.textAlign = "center"
            c2:fillText("●", x + 75, y - 115 + dy)
            c2.textAlign = "left"
        end
    end
    window.CampanhaLoja = __ord(
        {
            abrir = abrir,
            fechar = fechar,
            aberta = function() return not not __t(aberto) end,
            moedas = function() return st.moedas end,
            ganhar = ganhar,
            ouvir = function(____, f)
                __call(ouvintes, "add", f)
                return function() return __call(ouvintes, "delete", f) end
            end,
            precos = function() return __assign({}, PRECO) end,
            perto = function(____, cena, x) return if __t(cena == BANCA.cena and math.abs(x - BANCA.x) < 110) then {id = "loja", x = BANCA.x + 20, rotulo = "COMPRAR GARRAFADAS DO SEU LINDOMAR", botao = "LOJA"} else nil end,
            desenhar = desenharBanca,
            banca = function() return __assign({}, BANCA) end
        },
        "abrir,fechar,aberta,moedas,ganhar,ouvir,precos,perto,desenhar,banca"
    )
end)(nil)
return ____exports
