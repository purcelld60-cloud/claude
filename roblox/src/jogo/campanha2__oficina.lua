--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __gt, __ge, __mod, __ord, __arrL, __iterar, __t, __get, __len, __call, __add = __JSR.__lt, __JSR.__gt, __JSR.__ge, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__len, __JSR.__call, __JSR.__add
local __new, __assign, __bor = __JSR.__new, __JSR.__assign, __JSR.__bor
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local __TS__Iterator = ____lualib.__TS__Iterator
local ____exports = {}
local __O = {};
(function()
    local falar, listar, ficha, escolher, turbinar, fechar, PW, PRECO, box, raf, aberto, sel, anim, falaTxt, falaT, aoFechar, clamp, moedas, meus, FALAS, sorte, sfx
    function falar(self, s)
        falaTxt = s
        falaT = 0
    end
    function listar(self)
        local L = meus(nil)
        local el = box:querySelector(".lista")
        el.innerHTML = ""
        if not __t(__len(L)) then
            el.innerHTML = "<button type=\"button\" class=\"on\">NENHUMA GARRAFADA AINDA</button>"
            ficha(nil)
            return
        end
        sel = clamp(
            nil,
            sel,
            0,
            __len(L) - 1
        )
        __call(
            L,
            "forEach",
            function(____, p, i)
                local ____t_10 = __t
                local ____get_result_9 = __get(
                    PW:estado().niveis,
                    p.id
                )
                __O[844] = ____get_result_9
                local n = if ____t_10(____get_result_9) then __O[844] else 1
                local b = window.document:createElement("button")
                b.type = "button"
                b.className = if i == sel then "on" else ""
                b.innerHTML = (((((tostring(PW:iconeSVG(p.id)) .. "<span>") .. tostring(p.curto)) .. "</span><span class=\"pips\">") .. tostring(__call("■", "repeat", n))) .. tostring(__call("□", "repeat", 3 - n))) .. "</span>"
                b:addEventListener(
                    "click",
                    function() return escolher(nil, i) end
                )
                el:appendChild(b)
            end
        )
        ficha(nil)
    end
    function ficha(self)
        local f = box:querySelector(".ficha")
        local L = meus(nil)
        if not __t(__len(L)) then
            f.innerHTML = "<b>FICHA DA OFICINA</b>" .. tostring(__get(FALAS.vazio, 0))
            return
        end
        local p = __get(L, sel)
        local ____t_12 = __t
        local ____get_result_11 = __get(
            PW:estado().niveis,
            p.id
        )
        __O[845] = ____get_result_11
        local n = if ____t_12(____get_result_11) then __O[845] else 1
        local ____t_14 = __t
        local ____get_result_13 = __get(PRECO, n)
        __O[846] = ____get_result_13
        local preco = if ____t_14(____get_result_13) then __O[846] else 0
        local max = __ge(n, 3)
        local ____t_16 = __t
        local ____temp_15 = not __t(max) and __ge(
            moedas(nil),
            preco
        )
        __O[847] = ____temp_15
        local pode = if ____t_16(____temp_15) then not __t(anim) else __O[847]
        local ____p_nome_22 = p.nome
        local ____t_18 = __t
        local ____get_result_17 = __get(p.niveis, n - 1)
        __O[848] = ____get_result_17
        local ____temp_23 = if ____t_18(____get_result_17) then __O[848] else p.desc
        local ____temp_21 = n + 1
        local ____t_20 = __t
        local ____get_result_19 = __get(p.niveis, n)
        __O[849] = ____get_result_19
        f.innerHTML = ((((((((((((("<b>" .. tostring(____p_nome_22)) .. "</b><span class=\"n\"><i>AGORA · NÍVEL ") .. tostring(n)) .. "</i>") .. tostring(____temp_23)) .. "</span>") .. if __t(max) then "<span class=\"n\"><i>NO TALO</i>Nível máximo. Mais que isso, só com outra garrafada.</span>" else ((("<span class=\"n\"><i>DEPOIS · NÍVEL " .. tostring(____temp_21)) .. "</i>") .. tostring(if ____t_20(____get_result_19) then __O[849] else "")) .. "</span>") .. "<div class=\"p\">") .. if __t(max) then "★ NÍVEL MÁXIMO" else (("CUSTO: ● " .. tostring(preco)) .. "  ·  VOCÊ TEM: ● ") .. tostring(moedas(nil))) .. "</div><button type=\"button\" ") .. if __t(pode) then "" else "disabled") .. ">") .. if __t(max) then "NO TALO" else if __t(anim) then "TURBINANDO..." else "🔧 TURBINAR") .. "</button>"
        f:querySelector("button"):addEventListener("click", turbinar)
    end
    function escolher(self, i)
        local L = meus(nil)
        local ____t_26 = __t
        local ____t_25 = __t
        local ____temp_24 = not __t(__len(L))
        __O[850] = ____temp_24
        if ____t_26(if ____t_25(____temp_24) then __O[850] else anim) then
            return
        end
        sel = __mod(
            __add(
                i,
                __len(L)
            ),
            __len(L)
        )
        listar(nil)
        falar(
            nil,
            sorte(
                nil,
                __arrL({"Essa aí? Boa escolha.", "Hmm... dá pra turbinar, sim.", "Deixa eu ver o lacre... tá bom."}, 3)
            )
        )
    end
    function turbinar(self)
        local L = meus(nil)
        local ____t_29 = __t
        local ____t_28 = __t
        local ____temp_27 = not __t(__len(L))
        __O[851] = ____temp_27
        if ____t_29(if ____t_28(____temp_27) then __O[851] else anim) then
            return
        end
        local p = __get(L, sel)
        local ____t_31 = __t
        local ____get_result_30 = __get(
            PW:estado().niveis,
            p.id
        )
        __O[852] = ____get_result_30
        local n = if ____t_31(____get_result_30) then __O[852] else 1
        if __ge(n, 3) then
            falar(
                nil,
                sorte(nil, FALAS.max)
            )
            return
        end
        if __lt(
            moedas(nil),
            __get(PRECO, n)
        ) then
            falar(
                nil,
                sorte(nil, FALAS.pobre)
            )
            sfx(nil, "risada")
            return
        end
        local ____opt_34 = window.CampanhaLoja
        if ____opt_34 ~= nil then
            ____opt_34 = ____opt_34.ganhar
        end
        if ____opt_34 ~= nil then
            ____opt_34(
                ____opt_34,
                __TS__Number(-__get(PRECO, n))
            )
        end
        anim = {t = 0, p = p, n = n + 1}
        falar(nil, "Segura que lá vem faísca!")
        sfx(nil, "whoosh")
        ficha(nil)
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
            300
        )
        window:cancelAnimationFrame(raf)
        window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {active = false}}))
        if aoFechar ~= nil then
            aoFechar(nil)
        end
    end
    local ____ = "use strict"
    if __t(if __t(window.CampanhaOficina) then window.CampanhaOficina else not __t(window.CampanhaPoderes)) then
        return
    end
    PW = window.CampanhaPoderes
    local LW = 480
    local LH = 270
    local TAU = math.pi * 2
    PRECO = __arrL({0, 80, 160}, 3)
    box = nil
    local cv = nil
    local c = nil
    raf = 0
    local last = 0
    local t = 0
    aberto = false
    sel = 0
    anim = nil
    local poeira = __arrL({}, 0)
    local faiscas = __arrL({}, 0)
    local vapor = __arrL({}, 0)
    falaTxt = ""
    falaT = 0
    local carimbo = nil
    aoFechar = nil
    clamp = function(____, v, a, b) return math.max(
        a,
        math.min(b, v)
    ) end
    local function hash(____, n)
        local x = math.sin(n * 127.1 + 311.7) * 43758.5453
        return x - math.floor(x)
    end
    local function R(____, x, y, w, h, col)
        c.fillStyle = col
        c:fillRect(
            math.floor(x + 0.5),
            math.floor(y + 0.5),
            math.floor(w + 0.5),
            math.floor(h + 0.5)
        )
    end
    moedas = function()
        local ____opt_2 = window.CampanhaLoja
        if ____opt_2 ~= nil then
            ____opt_2 = ____opt_2.moedas
        end
        local ____opt_result_4
        if ____opt_2 ~= nil then
            ____opt_result_4 = ____opt_2(____opt_2)
        end
        local ____opt_result_4_5 = ____opt_result_4
        if ____opt_result_4_5 == nil then
            ____opt_result_4_5 = 0
        end
        return ____opt_result_4_5
    end
    meus = function() return __call(
        PW:lista(),
        "filter",
        function(____, p) return __call(
            PW:estado().desbloqueados,
            "includes",
            p.id
        ) end
    ) end
    FALAS = __ord(
        {
            oi = __arrL({"Chega mais! Sucata boa vira coisa melhor ainda.", "Oficina do Gugu: se não tem conserto, eu invento um.", "Traz a garrafada que eu turbino. Preço de amigo... quase."}, 3),
            pobre = __arrL({"Sem moeda não tem solda, meu filho.", "Volta quando tiver uns trocados. Os vilões costumam deixar cair."}, 2),
            max = __arrL({"Esse aí já tá no talo. Mais que isso explode.", "Nível 3! Nem eu sei turbinar mais que isso."}, 2),
            feito = __arrL({"PRONTO! Saiu quentinho da máquina.", "Ó a faísca! Ficou uma beleza.", "Turbinado! Tenta não quebrar na primeira briga."}, 3),
            vazio = __arrL({"Você ainda não tem garrafada nenhuma. Vence uns vilões e passa na banca do Seu Lindomar."}, 1)
        },
        "oi,pobre,max,feito,vazio"
    )
    sorte = function(____, a) return __get(
        a,
        math.floor(math.random() * __len(a))
    ) end
    local function css(self)
        if __t(window.document:getElementById("c2OficinaCss")) then
            return
        end
        local st = window.document:createElement("style")
        st.id = "c2OficinaCss"
        st.textContent = ".c2-ofi{position:fixed;inset:0;z-index:2147483300;background:#050403;display:flex;align-items:center;justify-content:center;font-family:Pixel,monospace;color:#f6ead0;opacity:0;transition:opacity .3s}.c2-ofi.on{opacity:1}.c2-ofi[hidden]{display:none}\n.c2-ofi .tela{position:relative;width:min(100vw,177.78vh);aspect-ratio:16/9;max-height:100vh}.c2-ofi canvas{width:100%;height:100%;display:block;image-rendering:pixelated}\n.c2-ofi .lista{position:absolute;left:2%;top:25%;width:24%;display:flex;flex-direction:column;gap:5px}.c2-ofi .lista button{font:clamp(7px,.9vw,10px) Pixel,monospace;text-align:left;display:flex;align-items:center;gap:8px;padding:6px 8px;background:#2a1e14e8;color:#f6ead0;border:3px solid #5a4028;box-shadow:0 3px 0 #120c08;cursor:pointer}\n.c2-ofi .lista button.on{background:#e8c66a;color:#2a1e14;border-color:#fff2c8}.c2-ofi .lista button svg{width:22px;height:22px;flex:none}.c2-ofi .lista .pips{margin-left:auto;letter-spacing:2px;color:#ffd24a}.c2-ofi .lista button.on .pips{color:#7a3a10}\n.c2-ofi .ficha{position:absolute;right:2%;top:5%;width:28%;background:#e8dcc0;color:#2a1a10;border:4px solid #3a2a1a;box-shadow:5px 6px 0 #0008;padding:10px 12px;font:clamp(8px,1.05vw,12px) Space,Arial,sans-serif;line-height:1.45;transform:rotate(-.6deg)}\n.c2-ofi .ficha:before{content:'';position:absolute;left:50%;top:-10px;width:16px;height:16px;margin-left:-8px;border-radius:50%;background:radial-gradient(#e8433a,#7a1a1a);box-shadow:0 2px 0 #0006}\n.c2-ofi .ficha b{display:block;font:clamp(8px,1vw,11px) Pixel,monospace;color:#7a2a1a;margin-bottom:6px}.c2-ofi .ficha .n{display:block;margin:6px 0;padding:6px;background:#f6efd8;border:2px dashed #8a6a4a}.c2-ofi .ficha .n i{font-style:normal;font:clamp(7px,.8vw,9px) Pixel,monospace;color:#5a3a20;display:block}\n.c2-ofi .ficha .p{font:clamp(8px,1vw,11px) Pixel,monospace;margin:8px 0}.c2-ofi .ficha button{font:clamp(8px,1vw,11px) Pixel,monospace;padding:9px 10px;width:100%;background:#e8a83a;color:#1c1408;border:3px solid #3a2a1a;box-shadow:0 4px 0 #3a2410;cursor:pointer}.c2-ofi .ficha button[disabled]{opacity:.45;cursor:default}\n.c2-ofi .sair{position:absolute;left:2%;top:3%;font:11px Pixel,monospace;padding:8px 12px;background:#4a3420;color:#f6ead0;border:3px solid #e8c66a;cursor:pointer}"
        window.document.head:appendChild(st)
    end
    local function montar(self)
        css(nil)
        box = window.document:createElement("div")
        box.className = "c2-ofi"
        box.hidden = true
        box:setAttribute("role", "dialog")
        box:setAttribute("aria-label", "Oficina de melhorias do Gugu")
        box.innerHTML = ((("<div class=\"tela\"><canvas width=\"" .. tostring(LW)) .. "\" height=\"") .. tostring(LH)) .. "\"></canvas><button type=\"button\" class=\"sair\">✕ SAIR DA OFICINA</button><div class=\"lista\"></div><div class=\"ficha\"></div></div>"
        window.document.body:appendChild(box)
        cv = box:querySelector("canvas")
        c = cv:getContext("2d")
        c.imageSmoothingEnabled = false
        box:querySelector(".sair"):addEventListener("click", fechar)
        window:addEventListener(
            "keydown",
            function(____, e)
                if not __t(aberto) then
                    return
                end
                local k = e.code
                if k == "Escape" then
                    fechar(nil)
                elseif __t(k == "ArrowDown" or k == "KeyS") then
                    escolher(nil, sel + 1)
                elseif __t(k == "ArrowUp" or k == "KeyW") then
                    escolher(nil, sel - 1)
                else
                    local ____t_8 = __t
                    local ____t_7 = __t
                    local ____temp_6 = k == "Enter" or k == "KeyE"
                    __O[843] = ____temp_6
                    if ____t_8(if ____t_7(____temp_6) then __O[843] else k == "Space") then
                        turbinar(nil)
                    else
                        return
                    end
                end
                e:preventDefault()
                e:stopImmediatePropagation()
            end,
            true
        )
        do
            local i = 0
            while i < 40 do
                __call(
                    poeira,
                    "push",
                    {
                        x = math.random() * LW,
                        y = math.random() * LH,
                        v = 2 + math.random() * 6,
                        f = math.random() * TAU
                    }
                )
                i = i + 1
            end
        end
    end
    sfx = function(____, n)
        do
            pcall(function()
                window.__somCutscene = true
                local ____opt_38 = window.Roteiro
                if ____opt_38 ~= nil then
                    ____opt_38 = ____opt_38.sfx
                end
                if ____opt_38 ~= nil then
                    ____opt_38(____opt_38, n)
                end
            end)
        end
    end
    local fundo = nil
    local function pintarFundo(self)
        fundo = window.document:createElement("canvas")
        fundo.width = LW
        fundo.height = LH
        local g = fundo:getContext("2d")
        local function r(____, x, y, w, h, col)
            g.fillStyle = col
            g:fillRect(x, y, w, h)
        end
        do
            local x = 0
            while x < LW do
                local onda = math.sin(x / 6 * math.pi)
                r(
                    nil,
                    x,
                    0,
                    2,
                    200,
                    if onda > 0.3 then "#5a6068" else if onda < -0.3 then "#3a4048" else "#4a5058"
                )
                x = x + 2
            end
        end
        do
            local i = 0
            while i < 260 do
                local x = hash(nil, i) * LW
                local y = hash(nil, i + 9) * 200
                local w = 2 + hash(nil, i + 3) * 10
                g.globalAlpha = 0.25 + hash(nil, i + 5) * 0.4
                r(
                    nil,
                    x,
                    y,
                    w,
                    2 + hash(nil, i + 7) * 14,
                    if hash(nil, i + 2) > 0.5 then "#8a4a24" else "#6a3a1c"
                )
                i = i + 1
            end
        end
        g.globalAlpha = 1
        do
            local y = 0
            while y < 200 do
                r(
                    nil,
                    0,
                    y,
                    LW,
                    2,
                    "#2a2e34"
                )
                do
                    local x = 6
                    while x < LW do
                        r(
                            nil,
                            x,
                            y + 3,
                            2,
                            2,
                            "#8a8e94"
                        )
                        x = x + 24
                    end
                end
                y = y + 50
            end
        end
        r(
            nil,
            0,
            0,
            LW,
            18,
            "#2a2420"
        )
        do
            local x = 0
            while x < LW do
                r(
                    nil,
                    x,
                    0,
                    8,
                    26,
                    "#3a2e24"
                )
                r(
                    nil,
                    x,
                    0,
                    2,
                    26,
                    "#5a4a38"
                )
                x = x + 60
            end
        end
        r(
            nil,
            0,
            16,
            LW,
            4,
            "#4a3a2a"
        )
        r(
            nil,
            200,
            30,
            80,
            34,
            "#2a2e34"
        )
        r(
            nil,
            204,
            34,
            72,
            26,
            "#9ab8c8"
        )
        r(
            nil,
            204,
            34,
            72,
            8,
            "#c8dce8"
        )
        r(
            nil,
            238,
            34,
            4,
            26,
            "#2a2e34"
        )
        r(
            nil,
            204,
            46,
            72,
            2,
            "#2a2e34"
        )
        g.globalAlpha = 0.15
        g.fillStyle = "#e8f0f6"
        g:beginPath()
        g:moveTo(204, 60)
        g:lineTo(276, 60)
        g:lineTo(320, 200)
        g:lineTo(160, 200)
        __call(g, "fill")
        g.globalAlpha = 1
        r(
            nil,
            28,
            28,
            150,
            30,
            "#1c1408"
        )
        r(
            nil,
            30,
            30,
            146,
            26,
            "#c8a24a"
        )
        r(
            nil,
            30,
            30,
            146,
            3,
            "#e8c66a"
        )
        do
            local i = 0
            while i < 40 do
                r(
                    nil,
                    30 + hash(nil, i + 50) * 146,
                    30 + hash(nil, i + 51) * 26,
                    2,
                    1,
                    "#a8822a"
                )
                i = i + 1
            end
        end
        local ____opt_44 = window.CampanhaCamadas
        if ____opt_44 ~= nil then
            ____opt_44 = ____opt_44.kit
        end
        local ____opt_result_46
        if ____opt_44 ~= nil then
            ____opt_result_46 = ____opt_44.pxText
        end
        if ____opt_result_46 ~= nil then
            ____opt_result_46(
                ____opt_44,
                g,
                "FERRO-VELHO DO GUGU",
                103,
                36,
                "#3a1a08"
            )
        end
        local ____opt_51 = window.CampanhaCamadas
        if ____opt_51 ~= nil then
            ____opt_51 = ____opt_51.kit
        end
        local ____opt_result_53
        if ____opt_51 ~= nil then
            ____opt_result_53 = ____opt_51.pxText
        end
        if ____opt_result_53 ~= nil then
            ____opt_result_53(
                ____opt_51,
                g,
                "CONSERTO · SOLDA · TURBINA",
                103,
                46,
                "#5a2a10"
            )
        end
        r(
            nil,
            28,
            70,
            150,
            80,
            "#6a4a2a"
        )
        r(
            nil,
            30,
            72,
            146,
            76,
            "#9a7a4a"
        )
        do
            local y = 76
            while y < 146 do
                do
                    local x = 34
                    while x < 174 do
                        r(
                            nil,
                            x,
                            y,
                            1,
                            1,
                            "#5a3a1c"
                        )
                        x = x + 6
                    end
                end
                y = y + 6
            end
        end
        local function chave(____, x, y, h)
            r(
                nil,
                x,
                y,
                3,
                h,
                "#9aa0a6"
            )
            r(
                nil,
                x - 2,
                y - 3,
                7,
                5,
                "#9aa0a6"
            )
            r(
                nil,
                x - 1,
                y - 2,
                3,
                2,
                "#5a6068"
            )
            r(
                nil,
                x,
                y,
                1,
                h,
                "#d8dce0"
            )
        end
        chave(nil, 40, 82, 30)
        chave(nil, 50, 80, 36)
        chave(nil, 60, 84, 26)
        r(
            nil,
            74,
            80,
            4,
            34,
            "#8a5a30"
        )
        r(
            nil,
            70,
            78,
            12,
            8,
            "#5a6068"
        )
        r(
            nil,
            70,
            78,
            12,
            2,
            "#9aa0a6"
        )
        r(
            nil,
            92,
            82,
            30,
            8,
            "#c8ccd0"
        )
        do
            local k = 0
            while k < 30 do
                r(
                    nil,
                    92 + k,
                    90,
                    2,
                    3,
                    "#9aa0a6"
                )
                k = k + 3
            end
        end
        r(
            nil,
            118,
            80,
            10,
            14,
            "#8a3a2a"
        )
        r(
            nil,
            136,
            80,
            6,
            24,
            "#e8c24c"
        )
        r(
            nil,
            134,
            102,
            10,
            10,
            "#3a3a3a"
        )
        r(
            nil,
            150,
            84,
            18,
            4,
            "#c43c3a"
        )
        r(
            nil,
            156,
            84,
            4,
            22,
            "#9aa0a6"
        )
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({40, 120}, 2),
                __arrL({64, 124}, 2),
                __arrL({90, 120}, 2),
                __arrL({116, 122}, 2),
                __arrL({142, 120}, 2)
            },
            5
        ))) do
            local x = ____value[1]
            local y = ____value[2]
            r(
                nil,
                x,
                y,
                18,
                22,
                "#1c1408"
            )
            r(
                nil,
                x + 1,
                y + 1,
                16,
                20,
                __get(
                    __arrL({
                        "#8a5a30",
                        "#3c6aa8",
                        "#a8642a",
                        "#5a8a4a",
                        "#c8a24a"
                    }, 5),
                    __mod(
                        __bor(x / 26, 0),
                        5
                    )
                )
            )
            r(
                nil,
                x + 1,
                y + 1,
                16,
                3,
                "#ffffff33"
            )
        end
        r(
            nil,
            312,
            70,
            150,
            4,
            "#5a3a1c"
        )
        r(
            nil,
            312,
            110,
            150,
            4,
            "#5a3a1c"
        )
        r(
            nil,
            316,
            74,
            3,
            80,
            "#3a2410"
        )
        r(
            nil,
            456,
            74,
            3,
            80,
            "#3a2410"
        )
        do
            local i = 0
            while i < 9 do
                local x = 322 + i * 15
                local h = 14 + __mod(i, 3) * 5
                r(
                    nil,
                    x,
                    70 - h,
                    10,
                    h,
                    "#1c1408"
                )
                r(
                    nil,
                    x + 1,
                    71 - h,
                    8,
                    h - 1,
                    __get(
                        __arrL({"#7a9a6a", "#c8a24a", "#6a8aa8", "#a85a4a"}, 4),
                        __mod(i, 4)
                    )
                )
                r(
                    nil,
                    x + 2,
                    72 - h,
                    2,
                    h - 3,
                    "#ffffff44"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 7 do
                local x = 324 + i * 19
                r(
                    nil,
                    x,
                    96,
                    14,
                    14,
                    "#1c1408"
                )
                r(
                    nil,
                    x + 1,
                    97,
                    12,
                    12,
                    "#d8d0c0"
                )
                r(
                    nil,
                    x + 1,
                    100,
                    12,
                    3,
                    __get(
                        __arrL({"#c43c3a", "#3c6aa8", "#e8c24c"}, 3),
                        __mod(i, 3)
                    )
                )
                i = i + 1
            end
        end
        do
            local y = 200
            while y < LH do
                r(
                    nil,
                    0,
                    y,
                    LW,
                    2,
                    if __mod(y, 8) < 4 then "#4a4440" else "#423c38"
                )
                y = y + 2
            end
        end
        do
            local i = 0
            while i < 18 do
                g.globalAlpha = 0.4
                g.fillStyle = "#1c1612"
                g:beginPath()
                g:ellipse(
                    hash(nil, i + 70) * LW,
                    210 + hash(nil, i + 71) * 55,
                    10 + hash(nil, i + 72) * 22,
                    3 + hash(nil, i + 73) * 5,
                    0,
                    0,
                    TAU
                )
                __call(g, "fill")
                i = i + 1
            end
        end
        g.globalAlpha = 1
        r(
            nil,
            0,
            198,
            LW,
            4,
            "#2a2420"
        )
        do
            local k = 0
            while k < 3 do
                local y = 196 - k * 14
                g.fillStyle = "#121212"
                g:beginPath()
                g:ellipse(
                    36,
                    y,
                    26,
                    8,
                    0,
                    0,
                    TAU
                )
                __call(g, "fill")
                g.fillStyle = "#2a2a2a"
                g:beginPath()
                g:ellipse(
                    36,
                    y - 2,
                    24,
                    6,
                    0,
                    0,
                    TAU
                )
                __call(g, "fill")
                g.fillStyle = "#121212"
                g:beginPath()
                g:ellipse(
                    36,
                    y - 2,
                    12,
                    3,
                    0,
                    0,
                    TAU
                )
                __call(g, "fill")
                k = k + 1
            end
        end
        g.fillStyle = "#7a2a24"
        g:beginPath()
        g:moveTo(420, 200)
        g:lineTo(440, 150)
        g:lineTo(478, 140)
        g:lineTo(478, 200)
        __call(g, "fill")
        g.fillStyle = "#9a3a2a"
        g:beginPath()
        g:moveTo(426, 196)
        g:lineTo(442, 156)
        g:lineTo(478, 148)
        g:lineTo(478, 158)
        g:lineTo(446, 166)
        g:lineTo(432, 198)
        __call(g, "fill")
        do
            local i = 0
            while i < 20 do
                r(
                    nil,
                    430 + hash(nil, i + 90) * 44,
                    150 + hash(nil, i + 91) * 46,
                    3,
                    2,
                    "#5a2a14"
                )
                i = i + 1
            end
        end
    end
    local function maquina(self, x, y)
        local k = if __t(anim) then clamp(nil, anim.t / 2.2, 0, 1) else 0
        local ____t_56 = __t
        local ____t_55 = __t
        local ____temp_54 = if __t(anim) then __gt(anim.t, 0.6) else anim
        __O[853] = ____temp_54
        local treme = if ____t_56(if ____t_55(____temp_54) then __lt(anim.t, 1.9) else __O[853]) then math.floor(math.sin(t * 60) + 0.5) else 0
        x = x + treme
        R(
            nil,
            x - 2,
            y + 66,
            84,
            6,
            "rgba(0,0,0,.35)"
        )
        R(
            nil,
            x + 6,
            y + 6,
            68,
            62,
            "#1c1408"
        )
        R(
            nil,
            x + 8,
            y + 8,
            64,
            58,
            "#6a7078"
        )
        R(
            nil,
            x + 8,
            y + 8,
            64,
            6,
            "#9aa0a8"
        )
        R(
            nil,
            x + 8,
            y + 58,
            64,
            8,
            "#4a5058"
        )
        do
            local i = 0
            while i < 4 do
                R(
                    nil,
                    x + 12 + i * 16,
                    y + 12,
                    3,
                    52,
                    "#5a6068"
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 10 do
                R(
                    nil,
                    x + 10 + i * 6,
                    y + 16,
                    2,
                    2,
                    "#c8ccd0"
                )
                i = i + 1
            end
        end
        local mx = x + 40
        local my = y + 32
        c.fillStyle = "#1c1408"
        c:beginPath()
        c:arc(
            mx,
            my,
            13,
            0,
            TAU
        )
        __call(c, "fill")
        c.fillStyle = "#f2ecd8"
        c:beginPath()
        c:arc(
            mx,
            my,
            11,
            0,
            TAU
        )
        __call(c, "fill")
        c.fillStyle = "#c43c3a"
        c:beginPath()
        c:arc(
            mx,
            my,
            11,
            -0.2,
            0.9
        )
        c:lineTo(mx, my)
        __call(c, "fill")
        local ang = -2.6 + if __t(anim) then math.min(1, anim.t / 1.6) * 3.4 + math.sin(t * 30) * 0.05 else math.sin(t * 1.5) * 0.08
        c.strokeStyle = "#1c1408"
        c.lineWidth = 2
        c:beginPath()
        c:moveTo(mx, my)
        c:lineTo(
            mx + math.cos(ang) * 9,
            my + math.sin(ang) * 9
        )
        c:stroke()
        c.lineWidth = 1
        R(
            nil,
            x + 30,
            y - 4,
            20,
            10,
            "#1c1408"
        )
        R(
            nil,
            x + 32,
            y - 2,
            16,
            8,
            "#9aa0a8"
        )
        R(
            nil,
            x + 26,
            y - 10,
            28,
            6,
            "#1c1408"
        )
        R(
            nil,
            x + 28,
            y - 8,
            24,
            3,
            "#c8ccd0"
        )
        R(
            nil,
            x + 72,
            y + 40,
            18,
            8,
            "#1c1408"
        )
        R(
            nil,
            x + 72,
            y + 42,
            16,
            4,
            "#9aa0a8"
        )
        R(
            nil,
            x + 70,
            y + 14,
            30,
            5,
            "#1c1408"
        )
        R(
            nil,
            x + 70,
            y + 15,
            30,
            3,
            "#8a5a30"
        )
        R(
            nil,
            x + 96,
            y - 40,
            5,
            58,
            "#1c1408"
        )
        R(
            nil,
            x + 97,
            y - 40,
            3,
            58,
            "#8a5a30"
        )
        R(
            nil,
            x + 14,
            y + 46,
            6,
            6,
            if __t(anim) then if __t(__mod(
                math.floor(t * 8),
                2
            )) then "#ff3a2a" else "#7a1a1a" else "#3ae06a"
        )
        R(
            nil,
            x + 24,
            y + 46,
            6,
            6,
            if __t(if __t(anim) then __gt(anim.t, 1.6) else anim) then "#3ae06a" else "#1a3a1a"
        )
        if __t(anim) then
            local p = anim.p
            local cor = p.cor
            if __lt(anim.t, 0.6) then
                local yy = y - 40 + anim.t / 0.6 * 34
                R(
                    nil,
                    x + 34,
                    yy,
                    12,
                    18,
                    "#dceef2"
                )
                R(
                    nil,
                    x + 35,
                    yy + 6,
                    10,
                    11,
                    cor
                )
                R(
                    nil,
                    x + 37,
                    yy - 5,
                    6,
                    6,
                    "#dceef2"
                )
            end
            if __gt(anim.t, 1.7) then
                local u = clamp(nil, (anim.t - 1.7) / 0.5, 0, 1)
                local bx = x + 88 + u * 30
                local by = y + 30 - math.sin(u * math.pi) * 30
                c:save()
                c.globalCompositeOperation = "lighter"
                local g = c:createRadialGradient(
                    bx + 6,
                    by + 8,
                    2,
                    bx + 6,
                    by + 8,
                    30
                )
                g:addColorStop(
                    0,
                    __add(cor, "cc")
                )
                g:addColorStop(
                    1,
                    __add(cor, "00")
                )
                c.fillStyle = g
                c:fillRect(bx - 30, by - 30, 70, 70)
                c:restore()
                R(
                    nil,
                    bx,
                    by,
                    12,
                    18,
                    "#f6fbff"
                )
                R(
                    nil,
                    bx + 1,
                    by + 6,
                    10,
                    11,
                    cor
                )
                R(
                    nil,
                    bx + 2,
                    by - 5,
                    6,
                    6,
                    "#f6fbff"
                )
            end
            local ____t_59 = __t
            local ____t_58 = __t
            local ____temp_57 = __gt(anim.t, 0.6) and __lt(anim.t, 1.9)
            __O[854] = ____temp_57
            if ____t_59(if ____t_58(____temp_57) then math.random() < 0.5 else __O[854]) then
                __call(
                    vapor,
                    "push",
                    {
                        x = x + 40 + (math.random() - 0.5) * 10,
                        y = y - 10,
                        t = 0,
                        v = 20 + math.random() * 20
                    }
                )
            end
        end
    end
    local function gugu(self, x, y)
        local o = {frame = t, facing = 1, scale = 1.45, grounded = true}
        local ____t_62 = __t
        local ____t_61 = __t
        local ____temp_60 = if __t(anim) then __gt(anim.t, 0.5) else anim
        __O[855] = ____temp_60
        if ____t_62(if ____t_61(____temp_60) then __lt(anim.t, 1.8) else __O[855]) then
            o = __assign(
                {},
                o,
                {
                    attack = true,
                    attackProgress = __mod(anim.t * 3, 1),
                    facing = 1
                }
            )
        else
            local ____t_65 = __t
            local ____t_64 = __t
            local ____temp_63 = falaT < 1.2
            __O[856] = ____temp_63
            if ____t_65(if ____t_64(____temp_63) then falaTxt else __O[856]) then
                o = __assign({}, o, {moving = false})
            end
        end
        do
            pcall(function()
                window.Art:drawCharacter(
                    c,
                    "c2_gugu",
                    x,
                    y + math.floor(math.sin(t * 2) * 0.5 + 0.5),
                    o
                )
            end)
        end
    end
    local function lampada(self)
        local a = math.sin(t * 1.1) * 0.16 + if __t(anim) then math.sin(t * 9) * 0.04 else 0
        local px = 240
        local py = 18
        local len = 40
        local lx = px + math.sin(a) * len
        local ly = py + math.cos(a) * len
        c:save()
        c.globalCompositeOperation = "multiply"
        local g = c:createRadialGradient(
            lx,
            ly + 90,
            20,
            lx,
            ly + 90,
            300
        )
        g:addColorStop(0, "rgba(255,240,210,1)")
        g:addColorStop(0.45, "rgba(190,170,150,1)")
        g:addColorStop(1, "rgba(60,50,60,1)")
        c.fillStyle = g
        c:fillRect(0, 0, LW, LH)
        c:restore()
        c:save()
        c.globalCompositeOperation = "lighter"
        c.globalAlpha = 0.16
        c.fillStyle = "#ffe0a0"
        c:beginPath()
        c:moveTo(lx - 6, ly + 6)
        c:lineTo(lx + 6, ly + 6)
        c:lineTo(
            lx + 110 + math.sin(a) * 80,
            210
        )
        c:lineTo(
            lx - 110 + math.sin(a) * 80,
            210
        )
        __call(c, "fill")
        c:restore()
        c.strokeStyle = "#1c1408"
        c:beginPath()
        c:moveTo(px, py)
        c:lineTo(lx, ly)
        c:stroke()
        R(
            nil,
            lx - 8,
            ly - 2,
            16,
            8,
            "#2a3a2a"
        )
        R(
            nil,
            lx - 10,
            ly + 4,
            20,
            3,
            "#3a4a3a"
        )
        R(
            nil,
            lx - 4,
            ly + 6,
            8,
            6,
            "#fff2b0"
        )
        c:save()
        c.globalCompositeOperation = "lighter"
        local g2 = c:createRadialGradient(
            lx,
            ly + 9,
            1,
            lx,
            ly + 9,
            26
        )
        g2:addColorStop(0, "rgba(255,230,160,.9)")
        g2:addColorStop(1, "rgba(255,230,160,0)")
        c.fillStyle = g2
        c:fillRect(lx - 30, ly - 20, 60, 60)
        c:restore()
    end
    local function bancada(self)
        R(
            nil,
            150,
            186,
            200,
            8,
            "#1c1408"
        )
        R(
            nil,
            152,
            186,
            196,
            6,
            "#8a5a30"
        )
        R(
            nil,
            152,
            186,
            196,
            2,
            "#b07a44"
        )
        R(
            nil,
            160,
            194,
            8,
            40,
            "#3a2410"
        )
        R(
            nil,
            332,
            194,
            8,
            40,
            "#3a2410"
        )
        R(
            nil,
            150,
            222,
            200,
            4,
            "#3a2410"
        )
        R(
            nil,
            168,
            174,
            24,
            12,
            "#1c1408"
        )
        R(
            nil,
            170,
            176,
            20,
            8,
            "#4a6a8a"
        )
        R(
            nil,
            176,
            168,
            8,
            8,
            "#4a6a8a"
        )
        R(
            nil,
            166,
            184,
            28,
            3,
            "#9aa0a6"
        )
        do
            local i = 0
            while i < 6 do
                R(
                    nil,
                    206 + i * 9 + hash(nil, i) * 4,
                    182 - __mod(i, 2) * 2,
                    5,
                    4,
                    __get(
                        __arrL({"#9aa0a6", "#c8a24a", "#7a8086"}, 3),
                        __mod(i, 3)
                    )
                )
                i = i + 1
            end
        end
        local L = meus(nil)
        local p = __get(L, sel)
        if __t(if __t(p) then not __t(anim) else p) then
            local x = 288
            local y = 160 + math.sin(t * 3) * 1.5
            c:save()
            c.globalCompositeOperation = "lighter"
            c.globalAlpha = 0.4
            c.fillStyle = p.cor
            c:beginPath()
            c:arc(
                x + 6,
                y + 14,
                18,
                0,
                TAU
            )
            __call(c, "fill")
            c:restore()
            R(
                nil,
                x,
                y,
                12,
                22,
                "#1c1408"
            )
            R(
                nil,
                x + 1,
                y + 1,
                10,
                20,
                "#dceef2"
            )
            R(
                nil,
                x + 2,
                y + 8,
                8,
                12,
                p.cor
            )
            R(
                nil,
                x + 3,
                y - 4,
                6,
                6,
                "#dceef2"
            )
            R(
                nil,
                x + 2,
                y - 6,
                8,
                3,
                "#8a5a32"
            )
            R(
                nil,
                x + 3,
                y + 3,
                2,
                10,
                "#ffffff88"
            )
        end
    end
    local function loop(self, now)
        if not __t(aberto) then
            return
        end
        raf = window:requestAnimationFrame(loop)
        local dt = clamp(nil, (now - last) / 1000, 0, 0.05)
        last = now
        t = t + dt
        falaT = falaT + dt
        if not __t(fundo) then
            pintarFundo(nil)
        end
        c:drawImage(fundo, 0, 0)
        maquina(nil, 372, 132)
        gugu(nil, 250, 190)
        bancada(nil)
        for ____, v in __iterar((vapor)) do
            v.t = v.t + dt
            v.y = v.y - v.v * dt
            v.x = v.x + math.sin(v.t * 3) * 0.3
            c.globalAlpha = math.max(0, 0.6 - v.t * 0.5)
            c.fillStyle = "#e8eef2"
            c:beginPath()
            c:arc(
                v.x,
                v.y,
                3 + v.t * 8,
                0,
                TAU
            )
            __call(c, "fill")
        end
        c.globalAlpha = 1
        vapor = __call(
            vapor,
            "filter",
            function(____, v) return __lt(v.t, 1.2) end
        )
        local ____t_68 = __t
        local ____t_67 = __t
        local ____temp_66 = if __t(anim) then __gt(anim.t, 0.7) else anim
        __O[857] = ____temp_66
        if ____t_68(if ____t_67(____temp_66) then __lt(anim.t, 1.8) else __O[857]) then
            do
                local i = 0
                while i < 4 do
                    __call(
                        faiscas,
                        "push",
                        {
                            x = 300,
                            y = 178,
                            vx = (math.random() - 0.3) * 140,
                            vy = -math.random() * 160,
                            t = 0
                        }
                    )
                    i = i + 1
                end
            end
            if math.random() < 0.25 then
                sfx(nil, "impacto")
            end
        end
        for ____, f in __iterar((faiscas)) do
            f.t = f.t + dt
            f.x = f.x + f.vx * dt
            f.y = f.y + f.vy * dt
            f.vy = f.vy + 420 * dt
            R(
                nil,
                f.x,
                f.y,
                2,
                2,
                if __lt(f.t, 0.2) then "#ffffff" else if __lt(f.t, 0.4) then "#ffe23a" else "#f08a24"
            )
        end
        faiscas = __call(
            faiscas,
            "filter",
            function(____, f) return __lt(f.t, 0.7) and __lt(f.y, 200) end
        )
        local ____t_71 = __t
        local ____t_70 = __t
        local ____temp_69 = if __t(anim) then __gt(anim.t, 0.7) else anim
        __O[858] = ____temp_69
        if ____t_71(if ____t_70(____temp_69) then __lt(anim.t, 1.8) else __O[858]) then
            c:save()
            c.globalCompositeOperation = "lighter"
            c.globalAlpha = 0.25 + math.random() * 0.25
            local g = c:createRadialGradient(
                300,
                178,
                2,
                300,
                178,
                120
            )
            g:addColorStop(0, "#d8f0ff")
            g:addColorStop(1, "rgba(216,240,255,0)")
            c.fillStyle = g
            c:fillRect(180, 60, 240, 240)
            c:restore()
        end
        lampada(nil)
        for ____, d in __iterar((poeira)) do
            d.y = d.y + d.v * dt * 0.4
            d.x = d.x + math.sin(t + d.f) * 0.1
            if __gt(d.y, LH) then
                d.y = 0
            end
            c.globalAlpha = 0.35 + math.sin(t * 2 + d.f) * 0.2
            R(
                nil,
                d.x,
                d.y,
                1,
                1,
                "#fff2d0"
            )
        end
        c.globalAlpha = 1
        if __t(if __t(falaTxt) then falaT < 4 else falaTxt) then
            local n = math.min(
                __len(falaTxt),
                math.floor(falaT * 40)
            )
            c.font = "8px Space, Arial, sans-serif"
            local ls = __arrL({}, 0)
            local l = ""
            for ____, w in __iterar((__call(
                __call(falaTxt, "slice", 0, n),
                "split",
                " "
            ))) do
                local ____t_74 = __t
                local ____t_73 = __t
                local ____gt_result_72 = __gt(
                    c:measureText(__add(
                        __add(l, " "),
                        w
                    )).width,
                    150
                )
                __O[859] = ____gt_result_72
                if ____t_74(if ____t_73(____gt_result_72) then l else __O[859]) then
                    __call(ls, "push", l)
                    l = w
                else
                    l = __add(if __t(l) then __add(l, " ") else "", w)
                end
            end
            __call(ls, "push", l)
            local bw = 164
            local bh = __len(ls) * 10 + 12
            local bx = 190
            local by = 26
            R(
                nil,
                bx - 1,
                by - 1,
                bw + 2,
                bh + 2,
                "#1c1408"
            )
            R(
                nil,
                bx,
                by,
                bw,
                bh,
                "#fff6dc"
            )
            R(
                nil,
                262,
                by + bh,
                6,
                8,
                "#1c1408"
            )
            R(
                nil,
                263,
                by + bh,
                4,
                6,
                "#fff6dc"
            )
            c.fillStyle = "#3a2412"
            c.textBaseline = "top"
            __call(
                ls,
                "forEach",
                function(____, s, i) return c:fillText(s, bx + 7, by + 6 + i * 10) end
            )
        end
        if __t(carimbo) then
            carimbo.t = carimbo.t + dt
            local k = carimbo.t
            local sc = if __lt(k, 0.2) then 2.5 - k * 7.5 else 1
            c:save()
            c.globalAlpha = math.min(1, (2.4 - k) / 0.4)
            c:translate(240, 120)
            c:rotate(-0.18)
            c:scale(sc, sc)
            R(
                nil,
                -80,
                -24,
                160,
                48,
                "#7a1a1a"
            )
            R(
                nil,
                -76,
                -20,
                152,
                40,
                "#f6efd8"
            )
            local ____opt_79 = window.CampanhaCamadas
            if ____opt_79 ~= nil then
                ____opt_79 = ____opt_79.kit
            end
            local ____opt_result_81
            if ____opt_79 ~= nil then
                ____opt_result_81 = ____opt_79.pxText
            end
            if ____opt_result_81 ~= nil then
                ____opt_result_81(
                    ____opt_79,
                    c,
                    "TURBINADO!",
                    0,
                    -15,
                    "#c43c3a",
                    {s = 2}
                )
            end
            local ____opt_86 = window.CampanhaCamadas
            if ____opt_86 ~= nil then
                ____opt_86 = ____opt_86.kit
            end
            local ____opt_result_88
            if ____opt_86 ~= nil then
                ____opt_result_88 = ____opt_86.pxText
            end
            if ____opt_result_88 ~= nil then
                ____opt_result_88(
                    ____opt_86,
                    c,
                    carimbo.txt,
                    0,
                    5,
                    "#3a1a08"
                )
            end
            c:restore()
            if __gt(k, 2.4) then
                carimbo = nil
            end
        end
        R(
            nil,
            8,
            244,
            70,
            20,
            "#1c1408"
        )
        R(
            nil,
            10,
            246,
            66,
            16,
            "#3a2a1a"
        )
        c.fillStyle = "#ffd24a"
        c:beginPath()
        c:arc(
            22,
            254,
            5,
            0,
            TAU
        )
        __call(c, "fill")
        local ____opt_93 = window.CampanhaCamadas
        if ____opt_93 ~= nil then
            ____opt_93 = ____opt_93.kit
        end
        local ____opt_result_95
        if ____opt_93 ~= nil then
            ____opt_result_95 = ____opt_93.pxText
        end
        if ____opt_result_95 ~= nil then
            ____opt_result_95(
                ____opt_93,
                c,
                tostring(moedas(nil)),
                50,
                252,
                "#ffe9a8"
            )
        end
        if __t(anim) then
            anim.t = anim.t + dt
            if __ge(anim.t, 2.3) then
                PW:upgrade(anim.p.id)
                carimbo = {
                    t = 0,
                    txt = __add(
                        __add(anim.p.curto, " · NÍVEL "),
                        anim.n
                    )
                }
                falar(
                    nil,
                    sorte(nil, FALAS.feito)
                )
                sfx(nil, "poder")
                anim = nil
                listar(nil)
            end
        end
    end
    local function abrir(self, o)
        if o == nil then
            o = {}
        end
        if not __t(box) then
            montar(nil)
        end
        aberto = true
        aoFechar = if __t(o.onClose) then o.onClose else nil
        box.hidden = false
        window:requestAnimationFrame(function() return __call(box.classList, "add", "on") end)
        anim = nil
        carimbo = nil
        sel = 0
        listar(nil)
        falar(nil, if __t(__len(meus(nil))) then sorte(nil, FALAS.oi) else __get(FALAS.vazio, 0))
        last = window.performance:now()
        window:cancelAnimationFrame(raf)
        raf = window:requestAnimationFrame(loop)
        window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {active = true}}))
    end
    window.CampanhaOficina = __ord(
        {
            abrir = abrir,
            fechar = fechar,
            aberta = function() return aberto end,
            precos = function() return __call(PRECO, "slice") end
        },
        "abrir,fechar,aberta,precos"
    )
end)(nil)
return ____exports
