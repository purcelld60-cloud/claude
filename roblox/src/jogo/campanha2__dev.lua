--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __callq, __ord, __arrL, __iterar, __t, __get, __set, __call, __add, __new, __iter = __JSR.__lt, __JSR.__callq, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__call, __JSR.__add, __JSR.__new, __JSR.__iter
local __keys, __assign, __re, __re_test, __re_replace = __JSR.__keys, __JSR.__assign, __JSR.__re, __JSR.__re_test, __JSR.__re_replace
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__Number = ____lualib.__TS__Number
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local ____t_3 = __t
    local ____t_result_2
    local ____t_1 = __t
    local ____temp_0 = not __t(window.DAROCA_DEV)
    __O[1089] = ____temp_0
    if ____t_1(____temp_0) then
        ____t_result_2 = __O[1089]
    else
        ____t_result_2 = window.DarocaDev
    end
    if ____t_3(____t_result_2) then
        return
    end
    do
        pcall(function()
            window.localStorage:setItem("daroca-sandbox-v1", "1")
        end)
    end
    local W = 960
    local H = 540
    local CAPS = __arrL(
        {
            __arrL(
                {
                    "Prólogo · abertura e a roça",
                    "abertura",
                    0,
                    700,
                    __arrL({}, 0)
                },
                5
            ),
            __arrL(
                {
                    "Aeroporto de Itabuna (Miguel)",
                    "checkin",
                    12,
                    520,
                    __arrL({}, 0)
                },
                5
            ),
            __arrL(
                {
                    "Chegada em Conquista (Seu Zé)",
                    "taxi1",
                    12,
                    3700,
                    __arrL({}, 0)
                },
                5
            ),
            __arrL(
                {
                    "Vilão 1 · Dona Creuza",
                    "creuza",
                    13,
                    2000,
                    __arrL({}, 0)
                },
                5
            ),
            __arrL(
                {
                    "Vilão 2 · Tonhão",
                    "tonhao",
                    16,
                    2820,
                    __arrL({"creuza"}, 1)
                },
                5
            ),
            __arrL(
                {
                    "Vilão 3 · Seu Valdomiro",
                    "valdomiro",
                    17,
                    520,
                    __arrL({"creuza", "tonhao"}, 2)
                },
                5
            ),
            __arrL(
                {
                    "Vilão 4 · Kauã Influencer",
                    "kaua",
                    15,
                    420,
                    __arrL({"creuza", "tonhao", "valdomiro"}, 3)
                },
                5
            ),
            __arrL(
                {
                    "Vilão 5 · Barão do Café",
                    "barao",
                    18,
                    420,
                    __arrL({"creuza", "tonhao", "valdomiro", "kaua"}, 4)
                },
                5
            ),
            __arrL(
                {
                    "Vilão 6 · Breno Pitbull",
                    "breno",
                    19,
                    420,
                    __arrL({
                        "creuza",
                        "tonhao",
                        "valdomiro",
                        "kaua",
                        "barao"
                    }, 5)
                },
                5
            ),
            __arrL(
                {
                    "Vilão 7 · Ryan e Bryan",
                    "gemeos",
                    20,
                    300,
                    __arrL({
                        "creuza",
                        "tonhao",
                        "valdomiro",
                        "kaua",
                        "barao",
                        "breno"
                    }, 6)
                },
                5
            ),
            __arrL(
                {
                    "Vilão 8 · Fred",
                    "fred",
                    27,
                    160,
                    __arrL({
                        "creuza",
                        "tonhao",
                        "valdomiro",
                        "kaua",
                        "barao",
                        "breno",
                        "gemeos"
                    }, 7)
                },
                5
            ),
            __arrL(
                {
                    "BATALHA FINAL · Jorge",
                    "jorge",
                    14,
                    1820,
                    __arrL({
                        "creuza",
                        "tonhao",
                        "valdomiro",
                        "kaua",
                        "barao",
                        "breno",
                        "gemeos",
                        "fred"
                    }, 8)
                },
                5
            ),
            __arrL(
                {
                    "Pós-final · Conquista livre",
                    "zerou",
                    14,
                    2200,
                    __arrL({
                        "creuza",
                        "tonhao",
                        "valdomiro",
                        "kaua",
                        "barao",
                        "breno",
                        "gemeos",
                        "fred"
                    }, 8)
                },
                5
            )
        },
        13
    )
    local PODER_DE = __ord({
        creuza = "fofoca",
        tonhao = "buzina",
        valdomiro = "biscoito",
        kaua = "flash",
        barao = "cafezao",
        breno = "supersoco",
        gemeos = "clone",
        fred = "aura"
    }, "creuza,tonhao,valdomiro,kaua,barao,breno,gemeos,fred")
    local function capitulo(self, i)
        local ____, passo, cena, x, venc = table.unpack(
            __get(CAPS, i),
            1,
            5
        )
        local flags = {embarcou = __t(passo ~= "abertura" and passo ~= "checkin") and 1 or 0}
        for ____, v in __iterar((venc)) do
            __set(
                flags,
                __add("venceu_", v),
                1
            )
        end
        if passo == "zerou" then
            flags.venceu_jorge = 1
            flags.zerou = 1
        end
        do
            pcall(function()
                window.localStorage:setItem(
                    "daroca-c2-save",
                    window.JSON:stringify({
                        v = 1,
                        passo = passo,
                        cena = cena,
                        x = x,
                        hp = 100,
                        flags = flags,
                        criado = window.Date:now(),
                        salvo = window.Date:now()
                    })
                )
                window.localStorage:setItem(
                    "daroca-c2-vencidos",
                    window.JSON:stringify(venc)
                )
            end)
        end
        local ____opt_6 = window.CampanhaTaxi
        if ____opt_6 ~= nil then
            ____opt_6 = ____opt_6.zerarVencidos
        end
        if ____opt_6 ~= nil then
            ____opt_6(____opt_6)
        end
        for ____, v in __iterar((venc)) do
            local ____opt_10 = window.CampanhaTaxi
            if ____opt_10 ~= nil then
                ____opt_10 = ____opt_10.vencer
            end
            if ____opt_10 ~= nil then
                ____opt_10(____opt_10, v)
            end
            local ____opt_14 = window.CampanhaPoderes
            if ____opt_14 ~= nil then
                ____opt_14 = ____opt_14.desbloquear
            end
            if ____opt_14 ~= nil then
                ____opt_14(
                    ____opt_14,
                    __get(PODER_DE, v)
                )
            end
        end
        local ____lt_22 = __lt
        local ____opt_18 = window.CampanhaLoja
        if ____opt_18 ~= nil then
            ____opt_18 = ____opt_18.moedas
        end
        local ____opt_result_20
        if ____opt_18 ~= nil then
            ____opt_result_20 = ____opt_18(____opt_18)
        end
        local ____opt_result_20_21 = ____opt_result_20
        if ____opt_result_20_21 == nil then
            ____opt_result_20_21 = 0
        end
        if ____lt_22(____opt_result_20_21, 600) then
            local ____opt_31 = window.CampanhaLoja
            if ____opt_31 ~= nil then
                ____opt_31 = ____opt_31.ganhar
            end
            if ____opt_31 ~= nil then
                local ____opt_26 = window.CampanhaLoja
                if ____opt_26 ~= nil then
                    ____opt_26 = ____opt_26.moedas
                end
                local ____opt_result_28
                if ____opt_26 ~= nil then
                    ____opt_result_28 = ____opt_26(____opt_26)
                end
                local ____opt_result_28_29 = ____opt_result_28
                if ____opt_result_28_29 == nil then
                    ____opt_result_28_29 = 0
                end
                ____opt_31(____opt_31, 600 - ____opt_result_28_29)
            end
        end
        local ____opt_33 = window.document:getElementById("c2Painel")
        if ____opt_33 ~= nil then
            ____opt_33:setAttribute("hidden", "")
        end
        local ____opt_37 = window.Campanha2
        if ____opt_37 ~= nil then
            ____opt_37 = ____opt_37.abrir
        end
        if ____opt_37 ~= nil then
            ____opt_37(____opt_37, {})
        end
    end
    local function liberarTudo(self)
        local ____iter_46 = __iter
        local ____t_result_45
        local ____t_44 = __t
        local ____opt_41 = window.CampanhaPoderes
        if ____opt_41 ~= nil then
            ____opt_41 = ____opt_41.lista
        end
        local ____opt_result_43
        if ____opt_41 ~= nil then
            ____opt_result_43 = ____opt_41(____opt_41)
        end
        __O[1090] = ____opt_result_43
        if ____t_44(____opt_result_43) then
            ____t_result_45 = __O[1090]
        else
            ____t_result_45 = __arrL({}, 0)
        end
        for ____, p in __TS__Iterator(____iter_46(____t_result_45)) do
            window.CampanhaPoderes:desbloquear(p.id)
            while __t(window.CampanhaPoderes:upgrade(p.id)) do
            end
        end
        local ____opt_49 = window.CampanhaLoja
        if ____opt_49 ~= nil then
            ____opt_49 = ____opt_49.ganhar
        end
        if ____opt_49 ~= nil then
            ____opt_49(____opt_49, 999)
        end
        for ____, v in __iterar((__keys(PODER_DE))) do
            local ____opt_53 = window.CampanhaTaxi
            if ____opt_53 ~= nil then
                ____opt_53 = ____opt_53.vencer
            end
            if ____opt_53 ~= nil then
                ____opt_53(____opt_53, v)
            end
        end
        do
            pcall(function()
                local ____self_58 = window.JSON
                local ____self_58_parse_59 = ____self_58.parse
                local ____t_result_57
                local ____t_56 = __t
                local ____temp_55 = window.localStorage:getItem("daroca-c2-save")
                __O[1091] = ____temp_55
                if ____t_56(____temp_55) then
                    ____t_result_57 = __O[1091]
                else
                    ____t_result_57 = "null"
                end
                local s = ____self_58_parse_59(____self_58, ____t_result_57)
                if __t(s) then
                    local ____t_result_60
                    if __t(s.flags) then
                        ____t_result_60 = s.flags
                    else
                        ____t_result_60 = {}
                    end
                    s.flags = ____t_result_60
                    local ____s_flags_64 = s.flags
                    local ____assign_63 = __assign
                    local ____temp_62 = {}
                    local ____t_result_61
                    if __t(s.flags.extra) then
                        ____t_result_61 = s.flags.extra
                    else
                        ____t_result_61 = {}
                    end
                    ____s_flags_64.extra = ____assign_63(____temp_62, ____t_result_61, {
                        mel = "feita",
                        lurdes = "feita",
                        cao = 1,
                        bike = 1,
                        skate = 1,
                        moral = 1,
                        juninho = "feita",
                        pistas_ok = 1
                    })
                    window.localStorage:setItem(
                        "daroca-c2-save",
                        window.JSON:stringify(s)
                    )
                end
            end)
        end
        window:alert("Modo desenvolvedor: 8 poderes no nível 3, +999 moedas, todos os pontos de táxi e os extras liberados.")
    end
    local function painelDev(self)
        local el = window.document:createElement("div")
        el.className = "c2j dev-cap"
        el.style.background = "#06080c"
        el.innerHTML = ("<div class=\"pausa\" style=\"position:relative;background:none;overflow:auto;max-height:100vh;padding:20px 0\"><h2>🛠 CAPÍTULOS · MODO DESENVOLVEDOR</h2><p>Escolha de onde começar. O save da Campanha 2 é trocado (a campanha principal não muda).</p>" .. tostring(__call(
            __call(
                CAPS,
                "map",
                function(____, ____bindingPattern0, i)
                    local n
                    n = ____bindingPattern0[1]
                    return ((("<button type=\"button\" data-i=\"" .. tostring(i)) .. "\">") .. tostring(n)) .. "</button>"
                end
            ),
            "join",
            ""
        ))) .. "<button type=\"button\" data-a=\"tudo\">⚡ LIBERAR TUDO (PODERES NV 3, MOEDAS, EXTRAS)</button><button type=\"button\" data-a=\"fechar\">VOLTAR</button></div>"
        el:addEventListener(
            "click",
            function(____, e)
                local b = e.target:closest("button")
                if not __t(b) then
                    return
                end
                if b.dataset.a == "fechar" then
                    el:remove()
                elseif b.dataset.a == "tudo" then
                    liberarTudo(nil)
                else
                    el:remove()
                    capitulo(
                        nil,
                        __TS__Number(b.dataset.i)
                    )
                end
            end
        )
        window.document.body:appendChild(el)
        window:setTimeout(
            function()
                local ____opt_65 = el:querySelector("button")
                return ____opt_65 and ____opt_65:focus()
            end,
            30
        )
    end
    __new(
        "MutationObserver",
        function()
            local p = window.document:querySelector("#c2Painel .pausa")
            local ____t_68 = __t
            local ____t_result_67
            if __t(p) then
                ____t_result_67 = not __t(p:querySelector("[data-dev]"))
            else
                ____t_result_67 = p
            end
            if ____t_68(____t_result_67) then
                local b = window.document:createElement("button")
                b.type = "button"
                b.dataset.dev = ""
                b.textContent = "🛠 ESCOLHER CAPÍTULO (DEV)"
                b:addEventListener(
                    "click",
                    function(____, e)
                        e:stopPropagation()
                        painelDev(nil)
                    end
                )
                p:insertBefore(
                    b,
                    p:querySelector("[data-a=\"fechar\"]")
                )
            end
        end
    ):observe(
        window.document.body,
        __ord({childList = true, subtree = true}, "childList,subtree")
    )
    local function tocarCena(self, kind)
        local tecla
        local C = window.Cinematics
        if not __t(C) then
            return
        end
        local cv = window.document:createElement("canvas")
        cv.width = W
        cv.height = H
        cv.style.cssText = "position:fixed;inset:0;margin:auto;width:min(100vw,177.8vh);height:min(56.25vw,100vh);z-index:2147483600;background:#000;image-rendering:pixelated"
        window.document.body:appendChild(cv)
        local c = cv:getContext("2d")
        local s = C:create(kind, {})
        local last = window.performance:now()
        local stop = false
        local function fim()
            stop = true
            cv:remove()
            window:removeEventListener("keydown", tecla, true)
        end
        local function passo()
            local ____t_72 = __t
            local ____t_result_71
            local ____t_70 = __t
            local ____temp_69 = not __t(C:advance(s))
            __O[1092] = ____temp_69
            if ____t_70(____temp_69) then
                ____t_result_71 = __O[1092]
            else
                ____t_result_71 = s.done
            end
            if ____t_72(____t_result_71) then
                fim(nil)
            end
        end
        tecla = function(____, e)
            if e.key == "Escape" then
                fim(nil)
            elseif __t(__call(
                __arrL({
                    " ",
                    "Enter",
                    "e",
                    "E",
                    "ArrowRight"
                }, 5),
                "includes",
                e.key
            )) then
                passo(nil)
            else
                return
            end
            e:preventDefault()
            e:stopImmediatePropagation()
        end
        window:addEventListener("keydown", tecla, true)
        cv:addEventListener("click", passo)
        local loop
        loop = function(____, now)
            if __t(stop) then
                return
            end
            local dt = math.min(0.1, (now - last) / 1000)
            last = now
            do
                local function ____catch(e)
                    fim(nil)
                    return true
                end
                local ____try, ____hasReturned, ____returnValue = pcall(function()
                    C:update(s, dt)
                    if __t(s.done) then
                        fim(nil)
                        return true
                    end
                    C:draw(c, s)
                    local b = C:beat(s)
                    local ____t_76 = __t
                    local ____opt_result_75
                    if b ~= nil then
                        ____opt_result_75 = b.text
                    end
                    if ____t_76(____opt_result_75) then
                        c.fillStyle = "rgba(20,14,8,.9)"
                        c:fillRect(30, 404, 900, 110)
                        c.fillStyle = "#e8c66a"
                        c:fillRect(30, 404, 900, 3)
                        c.font = "12px Pixel, monospace"
                        c.fillStyle = "#ffd98a"
                        c.textAlign = "left"
                        c.textBaseline = "top"
                        local ____c_fillText_78 = c.fillText
                        local ____t_result_77
                        if __t(b.speaker) then
                            ____t_result_77 = b.speaker
                        else
                            ____t_result_77 = ""
                        end
                        ____c_fillText_78(c, ____t_result_77, 46, 416)
                        c.font = "16px Arial, sans-serif"
                        c.fillStyle = "#f6ead0"
                        local l = ""
                        local y = 440
                        for ____, w in __iterar((__call(
                            tostring(b.text),
                            "split",
                            " "
                        ))) do
                            if c:measureText(__add(l, w)).width > 860 then
                                c:fillText(l, 46, y)
                                l = ""
                                y = y + 22
                            end
                            l = __add(
                                l,
                                __add(w, " ")
                            )
                        end
                        c:fillText(l, 46, y)
                    end
                    c.font = "10px Pixel, monospace"
                    c.textAlign = "right"
                    c.fillStyle = "#ffffffaa"
                    c:fillText(
                        tostring(kind) .. " · clique/Enter avança · Esc fecha",
                        950,
                        6
                    )
                end)
                if not ____try then
                    ____hasReturned, ____returnValue = ____catch(____hasReturned)
                end
                if ____hasReturned then
                    return ____returnValue
                end
            end
            window:requestAnimationFrame(loop)
        end
        window:requestAnimationFrame(loop)
    end
    local function galeria(self)
        local el = window.document:createElement("div")
        el.className = "c2-galeria"
        local R = window.Roteiro
        local ____call_84 = __call
        local ____keys_83 = __keys
        local ____t_result_82
        local ____t_81 = __t
        local ____opt_79 = window.Cinematics
        if ____opt_79 ~= nil then
            ____opt_79 = ____opt_79.metadata
        end
        __O[1093] = ____opt_79
        if ____t_81(____opt_79) then
            ____t_result_82 = __O[1093]
        else
            ____t_result_82 = {}
        end
        local cinema = ____call_84(
            ____keys_83(____t_result_82),
            "filter",
            function(____, k) return not __t(__callq(R, "has", k)) or not __re_test(
                __re("^c2_|^chegada_|^abertura$|^creditos$", ""),
                k
            ) end
        )
        local ____call_93 = __call
        local ____t_result_92
        local ____t_91 = __t
        local ____opt_result_89
        if R ~= nil then
            ____opt_result_89 = R.list
        end
        local ____opt_result_90
        if ____opt_result_89 ~= nil then
            ____opt_result_90 = ____opt_result_89(R)
        end
        __O[1094] = ____opt_result_90
        if ____t_91(____opt_result_90) then
            ____t_result_92 = __O[1094]
        else
            ____t_result_92 = __arrL({}, 0)
        end
        local roteiros1 = ____call_93(
            ____t_result_92,
            "filter",
            function(____, id) return not __re_test(
                __re("^c2", ""),
                id
            ) end
        )
        local ____call_101 = __call
        local ____t_result_100
        local ____t_99 = __t
        local ____opt_96 = window.CampanhaCutscenes
        if ____opt_96 ~= nil then
            ____opt_96 = ____opt_96.ordem
        end
        local ____opt_result_98
        if ____opt_96 ~= nil then
            ____opt_result_98 = ____opt_96(____opt_96)
        end
        __O[1095] = ____opt_result_98
        if ____t_99(____opt_result_98) then
            ____t_result_100 = __O[1095]
        else
            ____t_result_100 = __arrL({}, 0)
        end
        local roteiros2 = ____call_101(
            ____t_result_100,
            "filter",
            function(____, id) return __callq(R, "has", id) end
        )
        local function grupo(____, titulo, ids, tipo)
            return ((("<h2 style=\"margin-top:14px\">" .. tostring(titulo)) .. "</h2><div class=\"g\">") .. tostring(__call(
                __call(
                    ids,
                    "map",
                    function(____, id)
                        local ____tipo_107 = tipo
                        local ____id_108 = id
                        local ____re_replace_106 = __re_replace
                        local ____t_result_105
                        local ____t_104 = __t
                        local ____opt_102 = __callq(R, "get", id)
                        if ____opt_102 ~= nil then
                            ____opt_102 = ____opt_102.title
                        end
                        __O[1096] = ____opt_102
                        if ____t_104(____opt_102) then
                            ____t_result_105 = __O[1096]
                        else
                            ____t_result_105 = id
                        end
                        return ((((((("<button type=\"button\" data-t=\"" .. tostring(____tipo_107)) .. "\" data-id=\"") .. tostring(____id_108)) .. "\">") .. tostring(____re_replace_106(
                            ____t_result_105,
                            __re("[<>&]", "g"),
                            ""
                        ))) .. "<small>") .. tostring(id)) .. "</small></button>"
                    end
                ),
                "join",
                ""
            ))) .. "</div>"
        end
        el.innerHTML = (("<button type=\"button\" class=\"x\">✕ FECHAR</button><h2>🎬 TODAS AS CUTSCENES · DEV</h2><p>Clique para assistir. Clique ou Enter avança, Esc fecha.</p>" .. grupo(nil, "CAMPANHA 2 · VITÓRIA DA CONQUISTA", roteiros2, "r")) .. grupo(nil, "CAMPANHA 1 · ROTEIROS", roteiros1, "r")) .. grupo(nil, "CAMPANHA 1 · CENAS DO JOGO", cinema, "c")
        if not __t(window.document:querySelector(".c2-galeria:not([data-dev])")) then
            local ____opt_111 = window.CampanhaCutscenes
            if ____opt_111 ~= nil then
                ____opt_111 = ____opt_111.galeria
            end
            if ____opt_111 ~= nil then
                ____opt_111(____opt_111)
            end
        end
        __call(
            window.document:querySelectorAll(".c2-galeria:not([data-dev])"),
            "forEach",
            function(____, g)
                g.hidden = true
            end
        )
        el.dataset.dev = "1"
        window.document.body:appendChild(el)
        el:addEventListener(
            "click",
            function(____, e)
                local b = e.target:closest("button")
                if not __t(b) then
                    return
                end
                if __t(b.classList:contains("x")) then
                    el:remove()
                    window.__somCutscene = false
                    return
                end
                window.__somCutscene = true
                if b.dataset.t == "r" then
                    local antes = __TS__New(
                        Set,
                        window.document:querySelectorAll("body > canvas")
                    )
                    R:preview(b.dataset.id)
                    for ____, cv in __iterar((window.document:querySelectorAll("body > canvas"))) do
                        if not __t(__call(antes, "has", cv)) then
                            cv.style.zIndex = "2147483500"
                        end
                    end
                else
                    tocarCena(nil, b.dataset.id)
                end
            end
        )
    end
    local function botaoTitulo(self)
        local lista = window.document:querySelector("#startScreen .ranch-mode-entries")
        local ____t_116 = __t
        local ____t_result_115
        local ____t_114 = __t
        local ____temp_113 = not __t(lista)
        __O[1097] = ____temp_113
        if ____t_114(____temp_113) then
            ____t_result_115 = __O[1097]
        else
            ____t_result_115 = lista:querySelector("[data-dev-cut]")
        end
        if ____t_116(____t_result_115) then
            return
        end
        local b = window.document:createElement("button")
        b.type = "button"
        b.dataset.devCut = ""
        b.innerHTML = "<b>🎬 CUTSCENES · DEV</b><small>Todas as cenas das duas campanhas</small>"
        b:addEventListener(
            "click",
            function(____, e)
                e:preventDefault()
                galeria(nil)
            end
        )
        lista:appendChild(b)
        local tag = window.document:createElement("div")
        tag.textContent = "MODO DESENVOLVEDOR"
        tag.style.cssText = "position:fixed;left:8px;bottom:8px;z-index:99999;font:9px Pixel,monospace;color:#1c1408;background:#ffd24a;border:2px solid #1c1408;padding:4px 7px;pointer-events:none"
        window.document.body:appendChild(tag)
    end
    if window.document.readyState == "loading" then
        window.document:addEventListener("DOMContentLoaded", botaoTitulo)
    else
        botaoTitulo(nil)
    end
    window.DarocaDev = __ord({
        galeria = galeria,
        capitulo = capitulo,
        liberarTudo = liberarTudo,
        painel = painelDev,
        tocarCena = tocarCena
    }, "galeria,capitulo,liberarTudo,painel,tocarCena")
end)(nil)
return ____exports
