--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __le, __gt, __ge, __mod, __ord, __arrL, __iterar, __t, __get, __set, __arr = __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__arr
local __len, __call, __add, __new, __iter, __keys, __assign, __isArray = __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__new, __JSR.__iter, __JSR.__keys, __JSR.__assign, __JSR.__isArray
local ____lualib = require(script.Parent.lualib_bundle)
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__Spread = ____lualib.__TS__Spread
local __TS__MathSign = ____lualib.__TS__MathSign
local __TS__Number = ____lualib.__TS__Number
local ____exports = {}
local __O = {};
(function()
    local iconeSVG, soco, retratoVilao, render, fecharMural, atualizarBotoes, PODERES, BASICOS, byId, lv, estado, avisar, tem, estadoPublico, iconeBasico, cd, efeitos, buff, carga, pronto, painel, sel, aoFechar, modoTeste, hash
    function iconeSVG(self, p, size)
        if size == nil then
            size = 24
        end
        local a = ""
        local b = ""
        __call(
            p.icone,
            "forEach",
            function(____, row, y) return __call(
                __arr(__TS__Spread(__iter(row))),
                "forEach",
                function(____, ch, x)
                    local r = ((("M" .. tostring(x * 2)) .. " ") .. tostring(y * 2)) .. "h2v2h-2z"
                    if ch == "x" then
                        a = __add(a, r)
                    elseif ch == "o" then
                        b = __add(b, r)
                    end
                end
            ) end
        )
        return ((((((((("<svg class=\"control-icon c2-icone\" viewBox=\"0 0 24 24\" width=\"" .. tostring(size)) .. "\" height=\"") .. tostring(size)) .. "\" aria-hidden=\"true\" shape-rendering=\"crispEdges\"><path fill=\"currentColor\" d=\"") .. a) .. "\"/><path class=\"icon-light\" fill=\"") .. tostring(p.cor)) .. "\" d=\"") .. b) .. "\"/></svg>"
    end
    function soco(self, p, mundo, fase)
        local h = mundo.heroi
        if fase == "down" then
            local ____t_45 = __t
            local ____t_44 = __t
            local ____temp_43 = not __t(pronto(nil, "supersoco"))
            __O[462] = ____temp_43
            if ____t_45(if ____t_44(____temp_43) then __O[462] else carga) then
                return {ok = false, motivo = "recarga", falta = cd.supersoco}
            end
            carga = {
                t = 0,
                max = lv(nil, p, "carga")
            }
            return {ok = true, carregando = true}
        end
        if not __t(carga) then
            return {ok = false}
        end
        local f = math.max(
            0.35,
            math.min(1, carga.t / carga.max)
        )
        local dir = if __lt(h.facing, 0) then -1 else 1
        carga = nil
        cd.supersoco = lv(nil, p, "recarga")
        __call(efeitos, "push", {
            k = "pow",
            x = h.x + dir * 54,
            y = h.y - 46,
            t = 0,
            f = f
        })
        local ____this_47
        ____this_47 = mundo
        local ____opt_46 = ____this_47.tremer
        if ____opt_46 ~= nil then
            ____opt_46(____this_47, 4 + f * 8)
        end
        local ____iter_59 = __iter
        local ____t_58 = __t
        local ____this_57
        ____this_57 = mundo
        local ____opt_56 = ____this_57.inimigos
        if ____opt_56 ~= nil then
            ____opt_56 = ____opt_56(____this_57)
        end
        __O[463] = ____opt_56
        for ____, e in __TS__Iterator(____iter_59(if ____t_58(____opt_56) then __O[463] else __arrL({}, 0))) do
            if __le(e.hp, 0) then
                continue
            end
            local dx = (e.x - h.x) * dir
            local ____t_51 = __t
            local ____t_49 = __t
            local ____temp_48 = dx > -10 and dx < 120
            __O[464] = ____temp_48
            local ____e_y_50 = e.y
            if ____e_y_50 == nil then
                ____e_y_50 = h.y
            end
            if ____t_51(if ____t_49(____temp_48) then math.abs(____e_y_50 - h.y) < 70 else __O[464]) then
                local ____this_53
                ____this_53 = mundo
                local ____opt_52 = ____this_53.dano
                if ____opt_52 ~= nil then
                    ____opt_52(
                        ____this_53,
                        e,
                        math.floor(lv(nil, p, "dano") * f * if __t(buff) then buff.forca else 1 + 0.5),
                        "soco",
                        dir
                    )
                end
                local ____this_55
                ____this_55 = mundo
                local ____opt_54 = ____this_55.empurrar
                if ____opt_54 ~= nil then
                    ____opt_54(____this_55, e, dir * (300 + 500 * f), -220 * f)
                end
            end
        end
        return {ok = true, forca = f}
    end
    function retratoVilao(self, cv, p, bloq)
        local c = cv:getContext("2d")
        c.imageSmoothingEnabled = false
        c:clearRect(0, 0, 64, 64)
        c:save()
        c:translate(32, 74)
        c:scale(1.05, 1.05)
        local ____opt_96 = window.Art
        if ____opt_96 ~= nil then
            ____opt_96 = ____opt_96.drawCharacter
        end
        if ____opt_96 ~= nil then
            ____opt_96(
                ____opt_96,
                c,
                p.quem,
                0,
                0,
                {frame = 1, facing = 1}
            )
        end
        c:restore()
        if __t(bloq) then
            c:save()
            c.globalCompositeOperation = "source-atop"
            c.fillStyle = "#1c140c"
            c:fillRect(0, 0, 64, 64)
            c:restore()
        end
    end
    function render(self)
        local s = estado
        local slots = painel:querySelector(".slots")
        slots.innerHTML = ""
        __call(
            __arrL({0, 1}, 2),
            "forEach",
            function(____, i)
                local id = __get(s.equipados, i)
                local p = byId(nil, id)
                local d = window.document:createElement("div")
                d.className = "slot"
                local ____temp_103 = if __t(p) then iconeSVG(nil, p, 32) else "<svg width=\"32\" height=\"32\"></svg>"
                local ____temp_104 = i + 1
                local ____temp_105 = if __t(i) then "I" else "U"
                local ____add_102 = __add
                local ____add_result_101 = __add(p.nome, " ")
                local ____call_100 = __call
                local ____t_99 = __t
                local ____get_result_98 = __get(s.niveis, id)
                __O[470] = ____get_result_98
                d.innerHTML = (((((((____temp_103 .. "<div><b>PODER ") .. tostring(____temp_104)) .. " · tecla ") .. ____temp_105) .. "</b><span>") .. tostring(if __t(p) then ____add_102(
                    ____add_result_101,
                    ____call_100("★", "repeat", if ____t_99(____get_result_98) then __O[470] else 1)
                ) else "vazio: escolha um poder no mural")) .. "</span></div>") .. if __t(p) then ("<button type=\"button\" data-a=\"tirar\" data-s=\"" .. tostring(i)) .. "\" style=\"margin-left:auto\">TIRAR</button>" else ""
                d.style.color = "#f6ead0"
                slots:appendChild(d)
            end
        )
        painel:querySelector(".basicos").innerHTML = __add(
            __add(
                "<b>SEMPRE COM VOCÊ:</b>",
                __call(
                    __call(
                        BASICOS,
                        "map",
                        function(____, b) return (((("<i>" .. tostring(iconeBasico(nil, b.id))) .. tostring(b.nome)) .. " <small>(") .. tostring(b.tecla)) .. ")</small></i>" end
                    ),
                    "join",
                    ""
                )
            ),
            "<i>JOYSTICK</i>"
        )
        local g = painel:querySelector(".grade")
        g.innerHTML = ""
        __call(
            PODERES,
            "forEach",
            function(____, p, i)
                local ok = tem(nil, p.id)
                local d = window.document:createElement("div")
                d.className = __add(
                    __add("card", if __t(ok) then "" else " bloq"),
                    if i == sel then " sel" else ""
                )
                d.dataset.a = "card"
                d.dataset.i = i
                d.tabIndex = 0
                d.style:setProperty(
                    "--r",
                    tostring((hash(nil, i) - 0.5) * 4) .. "deg"
                )
                d.style:setProperty(
                    "--pin",
                    __get(
                        __arrL({"#c43c3a", "#2c5a9e", "#3c8a5a", "#e8c24c"}, 4),
                        __mod(i, 4)
                    )
                )
                local eq = __call(s.equipados, "indexOf", p.id)
                local ____temp_113 = if eq >= 0 then ("<span class=\"eq\">" .. tostring(eq + 1)) .. "</span>" else ""
                local ____temp_114 = if __t(ok) then p.nome else "???"
                local ____call_108 = __call
                local ____t_107 = __t
                local ____get_result_106 = __get(s.niveis, p.id)
                __O[471] = ____get_result_106
                local ____call_108_result_112 = ____call_108("★", "repeat", if ____t_107(____get_result_106) then __O[471] else 1)
                local ____call_111 = __call
                local ____t_110 = __t
                local ____get_result_109 = __get(s.niveis, p.id)
                __O[472] = ____get_result_109
                d.innerHTML = ((((____temp_113 .. "<canvas width=\"64\" height=\"64\"></canvas><b>") .. tostring(____temp_114)) .. "</b><small>") .. tostring(if __t(ok) then (("<span class=\"estr\">" .. tostring(____call_108_result_112)) .. tostring(____call_111("☆", "repeat", 3 - if ____t_110(____get_result_109) then __O[472] else 1))) .. "</span>" else __add("vença ", p.vilao))) .. "</small>"
                g:appendChild(d)
                retratoVilao(
                    nil,
                    d:querySelector("canvas"),
                    p,
                    not __t(ok)
                )
            end
        )
        local p = __get(PODERES, sel)
        local ok = tem(nil, p.id)
        local ____t_116 = __t
        local ____get_result_115 = __get(s.niveis, p.id)
        __O[473] = ____get_result_115
        local n = if ____t_116(____get_result_115) then __O[473] else 1
        local det = painel:querySelector(".det")
        det.innerHTML = ((((((((("<div class=\"ic\">" .. if __t(ok) then iconeSVG(nil, p, 48) else "<svg width=\"48\" height=\"48\"></svg>") .. "</div><div style=\"flex:1;min-width:220px\"><p style=\"color:#ffd98a\">") .. tostring(if __t(ok) then p.nome else "??? (bloqueado)")) .. "</p><p>") .. tostring(if __t(ok) then p.desc else ((("Derrote <b>" .. tostring(p.vilao)) .. "</b> (") .. tostring(p.lugar)) .. ") para ganhar este poder.")) .. "</p>") .. if __t(ok) then (((((("<p class=\"nv\">NÍVEL " .. tostring(n)) .. ": ") .. tostring(__get(p.nivel, n - 1))) .. if __lt(n, 3) then "<br>PRÓXIMO (com o Gugu do Ferro-Velho): " .. tostring(__get(p.nivel, n)) else "<br>NÍVEL MÁXIMO") .. "</p><p class=\"nv\">RECARGA: ") .. tostring(__call(
            tostring(lv(nil, p, "recarga")),
            "replace",
            ".",
            ","
        ))) .. " s</p>" else "") .. "\n      <div class=\"bts\">") .. if __t(ok) then "<button type=\"button\" data-a=\"eq0\">EQUIPAR NO 1 (U)</button><button type=\"button\" data-a=\"eq1\">EQUIPAR NO 2 (I)</button>" .. if __t(if __t(modoTeste) then __lt(n, 3) else modoTeste) then "<button type=\"button\" data-a=\"up\">TESTE: UPGRADE DO GUGU</button>" else "" else "") .. "</div></div>"
        painel:querySelector(".info").textContent = tostring(__len(s.desbloqueados)) .. "/8 PODERES · ← → escolher · 1/2 equipar · ESC fechar"
        painel:querySelector("[data-a=\"teste\"]").hidden = not __t(modoTeste)
    end
    function fecharMural(self)
        local ____t_119 = __t
        local ____t_118 = __t
        local ____temp_117 = not __t(painel)
        __O[474] = ____temp_117
        if ____t_119(if ____t_118(____temp_117) then __O[474] else painel.hidden) then
            return
        end
        painel.hidden = true
        window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {active = false}}))
        local f = aoFechar
        aoFechar = nil
        if f ~= nil then
            f(nil)
        end
    end
    function atualizarBotoes(self)
        __call(
            __arrL({0, 1}, 2),
            "forEach",
            function(____, i)
                local b = window.document:getElementById("c2Poder" .. tostring(i + 1))
                if not __t(b) then
                    return
                end
                local p = byId(
                    nil,
                    __get(estado.equipados, i)
                )
                b.classList:toggle(
                    "vazio",
                    not __t(p)
                )
                b.innerHTML = ((((if __t(p) then iconeSVG(nil, p) else "<svg class=\"control-icon\" viewBox=\"0 0 24 24\" width=\"24\" height=\"24\"><path fill=\"currentColor\" d=\"M4 4h16v2H4zM4 18h16v2H4zM4 6h2v12H4zM18 6h2v12h-2z\"/></svg>" .. "<small>") .. tostring(if __t(p) then p.curto else "VAZIO")) .. "</small><kbd>") .. if __t(i) then "I" else "U") .. "</kbd><span class=\"c2-cd\"></span>"
            end
        )
    end
    local ____ = "use strict"
    if __t(window.CampanhaPoderes) then
        return
    end
    local KEY = "daroca-c2-poderes"
    local TAU = math.pi * 2
    PODERES = __arrL(
        {
            __ord(
                {
                    id = "fofoca",
                    nome = "FOFOCA CONFUSA",
                    curto = "FOFOCA",
                    vilao = "Dona Creuza Fofoqueira",
                    quem = "c2_creuza",
                    lugar = "Bairro da pensão",
                    cor = "#e48fb0",
                    desc = "Espalha uma fofoca fresquinha: quem estiver perto fica confuso e parte pra cima dos próprios colegas.",
                    recarga = __arrL({12, 10, 8}, 3),
                    raio = __arrL({210, 250, 300}, 3),
                    dur = __arrL({4, 5, 6}, 3),
                    nivel = __arrL({"Fofoca no raio de 210 por 4 s.", "Raio maior e 5 s de confusão.", "A fofoca vira notícia: 6 s, raio enorme."}, 3),
                    icone = __arrL({
                        "..xxxxxxxx..",
                        ".xoooooooox.",
                        "xoooooooooox",
                        "xoxxoxxoxxox",
                        "xoxxoxxoxxox",
                        "xoooooooooox",
                        ".xoooooooox.",
                        "..xxxxxxxx..",
                        "...xxo......",
                        "..xxo.......",
                        ".xx.........",
                        "............"
                    }, 12)
                },
                "id,nome,curto,vilao,quem,lugar,cor,desc,recarga,raio,dur,nivel,icone"
            ),
            __ord(
                {
                    id = "buzina",
                    nome = "BUZINA TURBO",
                    curto = "BUZINA",
                    vilao = "Tonhão do Mototáxi",
                    quem = "c2_tonhao",
                    lugar = "Monumento ao Índio",
                    cor = "#f08a24",
                    desc = "Uma buzinada de mototáxi que vira onda sonora e empurra tudo que estiver na frente.",
                    recarga = __arrL({6, 5, 4}, 3),
                    alcance = __arrL({230, 270, 320}, 3),
                    empurrao = __arrL({300, 360, 440}, 3),
                    dano = __arrL({6, 9, 12}, 3),
                    nivel = __arrL({"Empurra forte e dá 6 de dano.", "Mais alcance, 9 de dano.", "Buzina de caminhão: 12 de dano e empurrão gigante."}, 3),
                    icone = __arrL({
                        "........x...",
                        "..x......x..",
                        "xxxo..x...x.",
                        "xooxo..x..x.",
                        "xoooxo.x...x",
                        "xoooox.x...x",
                        "xoooox.x...x",
                        "xoooxo.x...x",
                        "xooxo..x..x.",
                        "xxxo..x...x.",
                        "..x......x..",
                        "........x..."
                    }, 12)
                },
                "id,nome,curto,vilao,quem,lugar,cor,desc,recarga,alcance,empurrao,dano,nivel,icone"
            ),
            __ord(
                {
                    id = "biscoito",
                    nome = "RAJADA DE BISCOITO",
                    curto = "BISCOITO",
                    vilao = "Seu Valdomiro da Feira",
                    quem = "c2_valdomiro",
                    lugar = "Feira",
                    cor = "#e9d6a8",
                    desc = "Dispara um leque de biscoitos de polvilho crocantes. Cada um machuca pouco, mas são muitos.",
                    recarga = __arrL({4, 3.5, 3}, 3),
                    n = __arrL({5, 7, 9}, 3),
                    dano = __arrL({5, 6, 7}, 3),
                    nivel = __arrL({"5 biscoitos de 5 de dano.", "7 biscoitos de 6 de dano.", "9 biscoitos de 7: uma fornada inteira."}, 3),
                    icone = __arrL({
                        "............",
                        ".xxx....xxx.",
                        "xo.ox..xo.ox",
                        "xo.ox..xo.ox",
                        ".xxx....xxx.",
                        "............",
                        "....xxxx....",
                        "...xo..ox...",
                        "...xo..ox...",
                        "....xxxx....",
                        "............",
                        "............"
                    }, 12)
                },
                "id,nome,curto,vilao,quem,lugar,cor,desc,recarga,n,dano,nivel,icone"
            ),
            __ord(
                {
                    id = "flash",
                    nome = "FLASH DO STORY",
                    curto = "FLASH",
                    vilao = "Kauã Influencer",
                    quem = "c2_kaua_influencer",
                    lugar = "Serra do Periperi",
                    cor = "#c8d8ff",
                    desc = "Um flash de celular na cara: todo mundo em volta fica atordoado vendo estrelinha.",
                    recarga = __arrL({10, 9, 8}, 3),
                    raio = __arrL({250, 290, 340}, 3),
                    dur = __arrL({2, 2.5, 3}, 3),
                    nivel = __arrL({"Atordoa por 2 s.", "Atordoa por 2,5 s, raio maior.", "Flash com filtro: 3 s e alcance de live."}, 3),
                    icone = __arrL({
                        "x....x....x.",
                        ".x...x...x..",
                        "..xxxxxxx...",
                        "..xooooox...",
                        "xxxoxxxoxxx.",
                        "..xoxxxox...",
                        "..xooooox...",
                        "..xooooox...",
                        "..xxxxxxx...",
                        ".x...x...x..",
                        "x....x....x.",
                        "............"
                    }, 12)
                },
                "id,nome,curto,vilao,quem,lugar,cor,desc,recarga,raio,dur,nivel,icone"
            ),
            __ord(
                {
                    id = "cafezao",
                    nome = "CAFEZÃO",
                    curto = "CAFEZÃO",
                    vilao = "Barão do Café",
                    quem = "c2_barao",
                    lugar = "Fazendas de café",
                    cor = "#a8743a",
                    desc = "Um gole de café do planalto: o Da Roça fica mais rápido e bate mais forte por um tempo.",
                    recarga = __arrL({16, 14, 12}, 3),
                    dur = __arrL({6, 8, 10}, 3),
                    vel = __arrL({1.4, 1.5, 1.6}, 3),
                    forca = __arrL({1.4, 1.6, 1.8}, 3),
                    nivel = __arrL({"6 s: +40% velocidade e força.", "8 s: +50% velocidade, +60% força.", "10 s de café coado: +60% e +80%."}, 3),
                    icone = __arrL({
                        "...x..x.....",
                        "..x..x......",
                        "...x..x.....",
                        "............",
                        "xxxxxxxxx...",
                        "xoooooooxxx.",
                        "xoooooooxo.x",
                        "xoooooooxo.x",
                        "xoooooooxxx.",
                        ".xoooooox...",
                        "..xxxxxx....",
                        "xxxxxxxxxxx."
                    }, 12)
                },
                "id,nome,curto,vilao,quem,lugar,cor,desc,recarga,dur,vel,forca,nivel,icone"
            ),
            __ord(
                {
                    id = "supersoco",
                    nome = "SUPERSOCO",
                    curto = "SOCO",
                    vilao = "Breno Pitbull",
                    quem = "c2_breno",
                    lugar = "Teatro e Planetário",
                    cor = "#e8433a",
                    desc = "Segure o botão para carregar e solte: um soco que arremessa o inimigo longe.",
                    recarga = __arrL({5, 4.5, 4}, 3),
                    dano = __arrL({20, 28, 36}, 3),
                    carga = __arrL({1, 0.85, 0.7}, 3),
                    nivel = __arrL({"Carrega em 1 s, até 20 de dano.", "Carrega mais rápido, até 28.", "Carrega em 0,7 s, até 36 de dano."}, 3),
                    icone = __arrL({
                        "............",
                        "..xxxxxxx...",
                        ".xoxoxoxox..",
                        ".xoxoxoxox..",
                        ".xooooooox..",
                        "xxooooooox..",
                        "xoxooooox...",
                        "xooooooox...",
                        ".xooooox....",
                        "..xxxxx.....",
                        "..xoox......",
                        "..xxxx......"
                    }, 12)
                },
                "id,nome,curto,vilao,quem,lugar,cor,desc,recarga,dano,carga,nivel,icone"
            ),
            __ord(
                {
                    id = "clone",
                    nome = "CLONE DE LAN",
                    curto = "CLONE",
                    vilao = "Ryan e Bryan",
                    quem = "c2_ryan",
                    lugar = "Lan house do shopping",
                    cor = "#5ae0d0",
                    desc = "Um Da Roça digital entra na luta e joga bolinha de papel junto com você.",
                    recarga = __arrL({18, 16, 14}, 3),
                    dur = __arrL({8, 10, 12}, 3),
                    dano = __arrL({3, 4, 5}, 3),
                    nivel = __arrL({"Clone por 8 s, 3 de dano por papel.", "Clone por 10 s, 4 de dano.", "Clone por 12 s, 5 de dano e mira melhor."}, 3),
                    icone = __arrL({
                        "xxxxxxxxxxxx",
                        "xoooooooooox",
                        "xo.xx..xx.ox",
                        "xo.xx..xx.ox",
                        "xoxxxxxxxxox",
                        "xoxxxxxxxxox",
                        "xoooooooooox",
                        "xxxxxxxxxxxx",
                        "....xxxx....",
                        "..xxxxxxxx..",
                        "............",
                        "............"
                    }, 12)
                },
                "id,nome,curto,vilao,quem,lugar,cor,desc,recarga,dur,dano,nivel,icone"
            ),
            __ord(
                {
                    id = "aura",
                    nome = "AURA DE AMIZADE",
                    curto = "AURA",
                    vilao = "Fred",
                    quem = "fred_conquista",
                    lugar = "Escola SESI (antes da luta final)",
                    cor = "#ffd24a",
                    desc = "Um escudo feito de amizade: enquanto ele brilha, nenhum golpe passa.",
                    recarga = __arrL({22, 20, 18}, 3),
                    dur = __arrL({4, 5, 6}, 3),
                    nivel = __arrL({"Escudo de 4 s.", "Escudo de 5 s.", "Escudo de 6 s: amizade de verdade."}, 3),
                    icone = __arrL({
                        "...xxxxxx...",
                        "..x......x..",
                        ".x.xx..xx.x.",
                        "x.xooxxoox.x",
                        "x.xoooooox.x",
                        "x.xoooooox.x",
                        "x..xoooox..x",
                        ".x..xoox..x.",
                        "..x..xx..x..",
                        "...xxxxxx...",
                        "............",
                        "............"
                    }, 12)
                },
                "id,nome,curto,vilao,quem,lugar,cor,desc,recarga,dur,nivel,icone"
            )
        },
        8
    )
    BASICOS = __arrL(
        {
            __ord({id = "interact", nome = "FALAR", tecla = "E", desc = "Conversar e interagir."}, "id,nome,tecla,desc"),
            __ord({id = "jump", nome = "PULAR / VOAR", tecla = "ESPAÇO", desc = "Pula; segurando, voa."}, "id,nome,tecla,desc"),
            __ord({id = "paper", nome = "BOLINHA DE PAPEL", tecla = "J", desc = "Joga bolinha de papel."}, "id,nome,tecla,desc"),
            __ord({id = "fart", nome = "PEIDO", tecla = "K", desc = "A nuvem verde de sempre."}, "id,nome,tecla,desc"),
            __ord({id = "dash", nome = "DASH", tecla = "L", desc = "Esquiva rápida."}, "id,nome,tecla,desc")
        },
        5
    )
    local SAIRAM = __arrL({"reeis", "bivolt", "taunt", "vehicle"}, 4)
    byId = function(____, id) return __call(
        PODERES,
        "find",
        function(____, p) return p.id == id end
    ) end
    lv = function(____, p, campo)
        local ____get_3 = __get
        local ____get_result_2 = __get(p, campo)
        local ____t_1 = __t
        local ____get_result_0 = __get(estado.niveis, p.id)
        __O[453] = ____get_result_0
        return ____get_3(
            ____get_result_2,
            math.max(
                0,
                math.min(2, if ____t_1(____get_result_0) then __O[453] else 1 - 1)
            )
        )
    end
    estado = __ord(
        {
            desbloqueados = __arrL({}, 0),
            equipados = __arr(nil, nil),
            niveis = {}
        },
        "desbloqueados,equipados,niveis"
    )
    do
        pcall(function()
            local ____self_6 = window.JSON
            local ____self_6_parse_7 = ____self_6.parse
            local ____t_5 = __t
            local ____temp_4 = window.localStorage:getItem(KEY)
            __O[454] = ____temp_4
            local s = ____self_6_parse_7(____self_6, if ____t_5(____temp_4) then __O[454] else "null")
            if __t(if __t(s) then __isArray(s.desbloqueados) else s) then
                estado = __ord(
                    {
                        desbloqueados = __call(s.desbloqueados, "filter", byId),
                        equipados = __call(
                            __call(if __t(s.equipados) then s.equipados else __arr(nil, nil), "slice", 0, 2),
                            "map",
                            function(____, id) return if __t(byId(nil, id)) then id else nil end
                        ),
                        niveis = if __t(s.niveis) then s.niveis else {}
                    },
                    "desbloqueados,equipados,niveis"
                )
            end
        end)
    end
    local function salvar()
        do
            pcall(function()
                window.localStorage:setItem(
                    KEY,
                    window.JSON:stringify(estado)
                )
            end)
        end
        avisar(nil)
    end
    local ouvintes = __TS__New(Set)
    avisar = function()
        for ____, f in __iterar((ouvintes)) do
            do
                pcall(function()
                    f(
                        nil,
                        estadoPublico(nil)
                    )
                end)
            end
        end
        atualizarBotoes(nil)
    end
    tem = function(____, id) return __call(estado.desbloqueados, "includes", id) end
    local function desbloquear(self, id)
        local ____t_10 = __t
        local ____t_9 = __t
        local ____temp_8 = not __t(byId(nil, id))
        __O[455] = ____temp_8
        if ____t_10(if ____t_9(____temp_8) then __O[455] else tem(nil, id)) then
            return false
        end
        __call(estado.desbloqueados, "push", id)
        local ____set_15 = __set
        local ____estado_niveis_13 = estado.niveis
        local ____id_14 = id
        local ____t_12 = __t
        local ____get_result_11 = __get(estado.niveis, id)
        __O[456] = ____get_result_11
        ____set_15(____estado_niveis_13, ____id_14, if ____t_12(____get_result_11) then __O[456] else 1)
        local vazio = __call(estado.equipados, "indexOf", nil)
        if vazio >= 0 then
            __set(estado.equipados, vazio, id)
        end
        salvar(nil)
        return true
    end
    local function equipar(self, slot, id)
        if __t(slot ~= 0 and slot ~= 1) then
            return false
        end
        if __t(id ~= nil and not __t(tem(nil, id))) then
            return false
        end
        local outro = __call(estado.equipados, "indexOf", id)
        local ____t_18 = __t
        local ____t_17 = __t
        local ____temp_16 = if __t(id) then outro >= 0 else id
        __O[457] = ____temp_16
        if ____t_18(if ____t_17(____temp_16) then outro ~= slot else __O[457]) then
            __set(
                estado.equipados,
                outro,
                __get(estado.equipados, slot)
            )
        end
        __set(estado.equipados, slot, id)
        salvar(nil)
        return true
    end
    local function upgrade(self, id)
        if not __t(tem(nil, id)) then
            return false
        end
        local ____t_20 = __t
        local ____get_result_19 = __get(estado.niveis, id)
        __O[458] = ____get_result_19
        local n = if ____t_20(____get_result_19) then __O[458] else 1
        if __ge(n, 3) then
            return false
        end
        __set(estado.niveis, id, n + 1)
        salvar(nil)
        return true
    end
    estadoPublico = function() return {
        desbloqueados = __call(estado.desbloqueados, "slice"),
        equipados = __call(estado.equipados, "slice"),
        niveis = __assign({}, estado.niveis)
    } end
    iconeBasico = function(____, id)
        local ____t_24 = __t
        local ____opt_21 = window.document:querySelector((".touch-controls [data-action=\"" .. tostring(id)) .. "\"] svg")
        local ____temp_23 = ____opt_21 and ____opt_21.outerHTML
        __O[459] = ____temp_23
        return if ____t_24(____temp_23) then __O[459] else ""
    end
    cd = {}
    efeitos = __arrL({}, 0)
    local proj = __arrL({}, 0)
    buff = nil
    local escudo = 0
    local escudoHit = 0
    local clone = nil
    carga = nil
    local flashTela = 0
    local T = 0
    pronto = function(____, id) return not __gt(
        __get(cd, id),
        0
    ) end
    local function usar(self, slotOuId, mundo, fase)
        if fase == nil then
            fase = "down"
        end
        local id = if type(slotOuId) == "number" then __get(estado.equipados, slotOuId) else slotOuId
        local p = byId(nil, id)
        if __t(not __t(p) or not __t(tem(nil, id))) then
            return {ok = false, motivo = if __t(p) then "bloqueado" else "vazio"}
        end
        if id == "supersoco" then
            return soco(nil, p, mundo, fase)
        end
        if fase ~= "down" then
            return {ok = false}
        end
        if not __t(pronto(nil, id)) then
            return {
                ok = false,
                motivo = "recarga",
                falta = __get(cd, id)
            }
        end
        local h = mundo.heroi
        local dir = if __lt(h.facing, 0) then -1 else 1
        local ____call_28 = __call
        local ____t_27 = __t
        local ____this_26
        ____this_26 = mundo
        local ____opt_25 = ____this_26.inimigos
        if ____opt_25 ~= nil then
            ____opt_25 = ____opt_25(____this_26)
        end
        __O[460] = ____opt_25
        local inim = ____call_28(
            if ____t_27(____opt_25) then __O[460] else __arrL({}, 0),
            "filter",
            function(____, e) return __gt(e.hp, 0) end
        )
        __set(
            cd,
            id,
            lv(nil, p, "recarga")
        )
        if id == "fofoca" then
            local r = lv(nil, p, "raio")
            local d = lv(nil, p, "dur")
            __call(efeitos, "push", {
                k = "fofoca",
                x = h.x,
                y = h.y,
                t = 0,
                r = r
            })
            for ____, e in __iterar((inim)) do
                if __lt(
                    math.abs(e.x - h.x),
                    r
                ) then
                    local ____this_30
                    ____this_30 = mundo
                    local ____opt_29 = ____this_30.confundir
                    if ____opt_29 ~= nil then
                        ____opt_29(____this_30, e, d)
                    end
                    __call(efeitos, "push", {k = "confuso", e = e, t = 0, ate = d})
                end
            end
        end
        if id == "buzina" then
            local al = lv(nil, p, "alcance")
            __call(efeitos, "push", {
                k = "buzina",
                x = h.x + dir * 20,
                y = h.y - 40,
                dir = dir,
                t = 0,
                al = al
            })
            local ____this_32
            ____this_32 = mundo
            local ____opt_31 = ____this_32.tremer
            if ____opt_31 ~= nil then
                ____opt_31(____this_32, 4)
            end
            for ____, e in __iterar((inim)) do
                local dx = (e.x - h.x) * dir
                local ____t_36 = __t
                local ____t_34 = __t
                local ____temp_33 = dx > -20 and __lt(dx, al)
                __O[461] = ____temp_33
                local ____e_y_35 = e.y
                if ____e_y_35 == nil then
                    ____e_y_35 = h.y
                end
                if ____t_36(if ____t_34(____temp_33) then math.abs(____e_y_35 - h.y) < 90 else __O[461]) then
                    local ____this_38
                    ____this_38 = mundo
                    local ____opt_37 = ____this_38.dano
                    if ____opt_37 ~= nil then
                        ____opt_37(
                            ____this_38,
                            e,
                            lv(nil, p, "dano"),
                            "som",
                            dir
                        )
                    end
                    local ____this_40
                    ____this_40 = mundo
                    local ____opt_39 = ____this_40.empurrar
                    if ____opt_39 ~= nil then
                        ____opt_39(
                            ____this_40,
                            e,
                            dir * lv(nil, p, "empurrao") * (1 - dx / al * 0.4),
                            -160
                        )
                    end
                end
            end
        end
        if id == "biscoito" then
            local n = lv(nil, p, "n")
            do
                local k = 0
                while __lt(k, n) do
                    local a = (k / math.max(1, n - 1) - 0.5) * 0.7 - 0.08
                    __call(
                        proj,
                        "push",
                        {
                            k = "biscoito",
                            x = h.x + dir * 24,
                            y = h.y - 46,
                            vx = math.cos(a) * 560 * dir,
                            vy = math.sin(a) * 560,
                            dano = lv(nil, p, "dano"),
                            vida = 0.9,
                            rot = k
                        }
                    )
                    k = k + 1
                end
            end
        end
        if id == "flash" then
            local r = lv(nil, p, "raio")
            local d = lv(nil, p, "dur")
            flashTela = 0.45
            __call(efeitos, "push", {k = "celular", t = 0})
            for ____, e in __iterar((inim)) do
                if __lt(
                    math.abs(e.x - h.x),
                    r
                ) then
                    local ____this_42
                    ____this_42 = mundo
                    local ____opt_41 = ____this_42.atordoar
                    if ____opt_41 ~= nil then
                        ____opt_41(____this_42, e, d)
                    end
                    __call(efeitos, "push", {k = "estrelas", e = e, t = 0, ate = d})
                end
            end
        end
        if id == "cafezao" then
            buff = {
                ate = lv(nil, p, "dur"),
                vel = lv(nil, p, "vel"),
                forca = lv(nil, p, "forca"),
                t = 0
            }
            __call(efeitos, "push", {k = "xicara", t = 0})
        end
        if id == "clone" then
            clone = {
                x = h.x - dir * 60,
                y = h.y,
                facing = dir,
                t = 0,
                ate = lv(nil, p, "dur"),
                tiro = 0.3,
                dano = lv(nil, p, "dano")
            }
        end
        if id == "aura" then
            escudo = lv(nil, p, "dur")
        end
        return {ok = true}
    end
    local function atualizar(self, dt, mundo)
        T = T + dt
        for ____, k in __iterar((__keys(cd))) do
            __set(
                cd,
                k,
                math.max(
                    0,
                    __get(cd, k) - dt
                )
            )
        end
        flashTela = math.max(0, flashTela - dt)
        escudoHit = math.max(0, escudoHit - dt)
        if escudo > 0 then
            escudo = math.max(0, escudo - dt)
        end
        if __t(buff) then
            buff.t = __add(buff.t, dt)
            if __ge(buff.t, buff.ate) then
                buff = nil
            end
        end
        if __t(carga) then
            carga.t = __add(carga.t, dt)
            if __gt(carga.t, carga.max + 0.35) then
                soco(
                    nil,
                    byId(nil, "supersoco"),
                    mundo,
                    "up"
                )
            end
        end
        efeitos = __call(
            efeitos,
            "filter",
            function(____, f)
                f.t = __add(f.t, dt)
                return __lt(f.t, if __t(f.ate) then f.ate else if f.k == "fofoca" then 1 else if f.k == "buzina" then 0.6 else if f.k == "pow" then 0.4 else 1.2)
            end
        )
        local ____call_67 = __call
        local ____t_66 = __t
        local ____opt_result_64
        if mundo ~= nil then
            ____opt_result_64 = mundo.inimigos
        end
        local ____opt_result_65
        if ____opt_result_64 ~= nil then
            ____opt_result_65 = ____opt_result_64(mundo)
        end
        __O[465] = ____opt_result_65
        local inim = ____call_67(
            if ____t_66(____opt_result_65) then __O[465] else __arrL({}, 0),
            "filter",
            function(____, e) return __gt(e.hp, 0) end
        )
        proj = __call(
            proj,
            "filter",
            function(____, q)
                q.vida = q.vida - dt
                q.x = q.x + q.vx * dt
                q.y = q.y + q.vy * dt
                q.vy = q.vy + 380 * dt
                for ____, e in __iterar((inim)) do
                    local ____t_76 = __t
                    local ____t_72 = __t
                    local ____temp_71 = math.abs(e.x - q.x) < 22
                    if ____temp_71 then
                        local ____gt_70 = __gt
                        local ____q_y_69 = q.y
                        local ____e_y_68 = e.y
                        if ____e_y_68 == nil then
                            ____e_y_68 = 440
                        end
                        ____temp_71 = ____gt_70(____q_y_69, ____e_y_68 - 76)
                    end
                    __O[466] = ____temp_71
                    local ____lt_75 = __lt
                    local ____q_y_74 = q.y
                    local ____e_y_73 = e.y
                    if ____e_y_73 == nil then
                        ____e_y_73 = 440
                    end
                    if ____t_76(if ____t_72(____temp_71) then ____lt_75(____q_y_74, ____e_y_73) else __O[466]) then
                        local ____this_82
                        ____this_82 = mundo
                        local ____opt_77 = ____this_82.dano
                        if ____opt_77 ~= nil then
                            local ____q_dano_81 = q.dano
                            local ____t_80 = __t
                            local ____t_79 = __t
                            local ____temp_78 = q.k == "biscoito"
                            __O[467] = ____temp_78
                            ____opt_77(
                                ____this_82,
                                e,
                                math.floor(____q_dano_81 * if ____t_80(if ____t_79(____temp_78) then buff else __O[467]) then buff.forca else 1 + 0.5),
                                q.k,
                                __TS__MathSign(q.vx)
                            )
                        end
                        __call(efeitos, "push", {
                            k = "farelo",
                            x = q.x,
                            y = q.y,
                            t = 0,
                            ate = 0.35
                        })
                        return false
                    end
                end
                return __gt(q.vida, 0) and __lt(q.y, 470)
            end
        )
        if __t(clone) then
            local h = mundo.heroi
            clone.t = __add(clone.t, dt)
            clone.facing = if __lt(h.facing, 0) then -1 else 1
            local alvoX = h.x - clone.facing * 60
            clone.x = clone.x + (alvoX - clone.x) * math.min(1, dt * 5)
            clone.y = clone.y + (h.y - clone.y) * math.min(1, dt * 6)
            clone.tiro = clone.tiro - dt
            local ____t_85 = __t
            local ____t_84 = __t
            local ____le_result_83 = __le(clone.tiro, 0)
            __O[468] = ____le_result_83
            if ____t_85(if ____t_84(____le_result_83) then __len(inim) else __O[468]) then
                local alvo = __call(
                    inim,
                    "reduce",
                    function(____, a, e) return if math.abs(e.x - clone.x) < math.abs(a.x - clone.x) then e else a end
                )
                local dir = if __gt(alvo.x, clone.x) then 1 else -1
                clone.facing = dir
                __call(proj, "push", {
                    k = "papel",
                    x = clone.x + dir * 18,
                    y = clone.y - 50,
                    vx = dir * 520,
                    vy = -60,
                    dano = clone.dano,
                    vida = 0.9
                })
                clone.tiro = 0.75
            end
            if __ge(clone.t, clone.ate) then
                __call(efeitos, "push", {
                    k = "glitch",
                    x = clone.x,
                    y = clone.y,
                    t = 0,
                    ate = 0.5
                })
                clone = nil
            end
        end
    end
    local function filtrarDano(self, n)
        if escudo > 0 then
            escudoHit = 0.3
            return 0
        end
        return n
    end
    local function multiplicadores()
        return {vel = if __t(buff) then buff.vel else 1, forca = if __t(buff) then buff.forca else 1}
    end
    local cloneCv = nil
    local function desenhar(self, c, mundo)
        local h = mundo.heroi
        local t = T
        c:save()
        c.imageSmoothingEnabled = false
        local function R(____, x, y, w, hh, col)
            c.fillStyle = col
            c:fillRect(
                math.floor(x + 0.5),
                math.floor(y + 0.5),
                math.floor(w + 0.5),
                math.floor(hh + 0.5)
            )
        end
        if __t(buff) then
            local a = 0.25 + math.sin(t * 8) * 0.08
            c.fillStyle = ("rgba(168,116,58," .. tostring(a)) .. ")"
            c:beginPath()
            c:ellipse(
                h.x,
                h.y - 44,
                34,
                54,
                0,
                0,
                TAU
            )
            __call(c, "fill")
            do
                local k = 0
                while k < 4 do
                    local q = __mod(t * 1.2 + k / 4, 1)
                    R(
                        nil,
                        h.x - 14 + k * 9 + math.sin(t * 3 + k) * 3,
                        h.y - 70 - q * 40,
                        3,
                        6,
                        ("rgba(255,255,255," .. tostring((1 - q) * 0.55)) .. ")"
                    )
                    k = k + 1
                end
            end
        end
        if __t(clone) then
            if not __t(cloneCv) then
                cloneCv = window.document:createElement("canvas")
                cloneCv.width = 120
                cloneCv.height = 140
            end
            local cc = cloneCv:getContext("2d")
            cc.imageSmoothingEnabled = false
            cc:clearRect(0, 0, 120, 140)
            local ____opt_88 = window.Art
            if ____opt_88 ~= nil then
                ____opt_88 = ____opt_88.drawCharacter
            end
            if ____opt_88 ~= nil then
                ____opt_88(
                    ____opt_88,
                    cc,
                    "daroca",
                    60,
                    130,
                    {frame = t, facing = clone.facing, moving = true, grounded = true}
                )
            end
            cc:save()
            cc.globalCompositeOperation = "source-atop"
            cc.fillStyle = "rgba(90,224,208,.55)"
            cc:fillRect(0, 0, 120, 140)
            do
                local y = 0
                while y < 140 do
                    cc.fillStyle = "rgba(10,40,60,.35)"
                    cc:fillRect(
                        0,
                        y + __mod(
                            math.floor(t * 20),
                            4
                        ),
                        120,
                        1
                    )
                    y = y + 4
                end
            end
            cc:restore()
            c.globalAlpha = 0.82 + if math.random() < 0.06 then -0.4 else 0
            c:drawImage(
                cloneCv,
                math.floor(clone.x - 60 + 0.5) + if math.random() < 0.05 then 4 else 0,
                math.floor(clone.y - 130 + 0.5)
            )
            c.globalAlpha = 1
            R(
                nil,
                clone.x - 16,
                clone.y - 104,
                32,
                9,
                "#0e1016"
            )
            c.font = "9px Pixel, monospace"
            c.textAlign = "center"
            c.fillStyle = "#5ae0d0"
            c:fillText("LAN", clone.x, clone.y - 97)
        end
        for ____, q in __iterar((proj)) do
            if q.k == "biscoito" then
                c:save()
                c:translate(q.x, q.y)
                c:rotate(t * 10 + q.rot)
                R(
                    nil,
                    -7,
                    -2,
                    14,
                    4,
                    "#8a6a3a"
                )
                R(
                    nil,
                    -6,
                    -3,
                    12,
                    6,
                    "#f6ecd0"
                )
                R(
                    nil,
                    -3,
                    -1,
                    6,
                    2,
                    "#8a6a3a"
                )
                c:restore()
            else
                R(
                    nil,
                    q.x - 5,
                    q.y - 5,
                    10,
                    10,
                    "#f6f4ee"
                )
                R(
                    nil,
                    q.x - 3,
                    q.y - 3,
                    4,
                    4,
                    "#d8d4c8"
                )
            end
        end
        for ____, f in __iterar((efeitos)) do
            local u = f.t / if __t(f.ate) then f.ate else 1
            if f.k == "fofoca" then
                local r = f.r * math.min(1, f.t / 0.6)
                c.strokeStyle = ("rgba(228,143,176," .. tostring(1 - f.t)) .. ")"
                c.lineWidth = 3
                c:setLineDash(__arrL({8, 6}, 2))
                c:beginPath()
                c:ellipse(
                    f.x,
                    f.y - 30,
                    r,
                    r * 0.28,
                    0,
                    0,
                    TAU
                )
                c:stroke()
                c:setLineDash(__arrL({}, 0))
                do
                    local k = 0
                    while k < 5 do
                        local a = k / 5 * TAU + f.t * 2
                        local x = f.x + math.cos(a) * r * 0.7
                        local y = f.y - 70 + math.sin(a) * 20
                        R(
                            nil,
                            x - 12,
                            y - 8,
                            24,
                            14,
                            "#fbf2f6"
                        )
                        R(
                            nil,
                            x - 4,
                            y + 6,
                            4,
                            4,
                            "#fbf2f6"
                        )
                        c.font = "9px Pixel, monospace"
                        c.textAlign = "center"
                        c.fillStyle = "#c4384e"
                        c:fillText(
                            __get(
                                __arrL({
                                    "PSIU",
                                    "SABIA?",
                                    "NOSSA!",
                                    "JURA?",
                                    "OXE!"
                                }, 5),
                                k
                            ),
                            x,
                            y + 3
                        )
                        k = k + 1
                    end
                end
            end
            if __t(f.k == "confuso" and __gt(f.e.hp, 0)) then
                local x = f.e.x
                local ____f_e_y_90 = f.e.y
                if ____f_e_y_90 == nil then
                    ____f_e_y_90 = 440
                end
                local y = ____f_e_y_90 - 100 + math.sin(t * 6) * 3
                R(
                    nil,
                    x - 14,
                    y - 10,
                    28,
                    18,
                    "#fbf2f6"
                )
                R(
                    nil,
                    x - 14,
                    y - 10,
                    28,
                    2,
                    "#e48fb0"
                )
                c.font = "12px Pixel, monospace"
                c.textAlign = "center"
                c.fillStyle = "#c4384e"
                c:fillText(if __t(__mod(
                    math.floor(t * 3),
                    2
                )) then "?!" else "!?", x, y + 4)
            end
            if f.k == "buzina" then
                do
                    local k = 0
                    while k < 4 do
                        local q = math.min(1, f.t / 0.5 + k * 0.12)
                        local r = 20 + q * f.al * 0.9
                        c.strokeStyle = ("rgba(240,138,36," .. tostring((1 - q) * 0.9)) .. ")"
                        c.lineWidth = 4
                        c:beginPath()
                        c:arc(
                            f.x,
                            f.y,
                            r,
                            if __gt(f.dir, 0) then -0.6 else math.pi - 0.6,
                            if __gt(f.dir, 0) then 0.6 else math.pi + 0.6
                        )
                        c:stroke()
                        k = k + 1
                    end
                end
                c.font = "16px Pixel, monospace"
                c.textAlign = "center"
                c.fillStyle = "#2a1a14"
                c:fillText("FOOOM!", f.x + f.dir * 70 + 2, f.y - 40 + 2)
                c.fillStyle = "#ffd24a"
                c:fillText("FOOOM!", f.x + f.dir * 70, f.y - 40)
            end
            if f.k == "celular" then
                local x = h.x + if __lt(h.facing, 0) then -26 else 26
                local y = h.y - 74
                R(
                    nil,
                    x - 7,
                    y - 12,
                    14,
                    24,
                    "#1c1c24"
                )
                R(
                    nil,
                    x - 5,
                    y - 10,
                    10,
                    18,
                    "#5ab8e8"
                )
                if __lt(f.t, 0.3) then
                    c.fillStyle = ("rgba(255,255,255," .. tostring(1 - f.t / 0.3)) .. ")"
                    c:beginPath()
                    c:arc(
                        x,
                        y - 6,
                        26 + f.t * 120,
                        0,
                        TAU
                    )
                    __call(c, "fill")
                end
            end
            if __t(f.k == "estrelas" and __gt(f.e.hp, 0)) then
                do
                    local k = 0
                    while k < 3 do
                        local a = t * 4 + k * 2.1
                        local x = f.e.x + math.cos(a) * 18
                        local ____f_e_y_91 = f.e.y
                        if ____f_e_y_91 == nil then
                            ____f_e_y_91 = 440
                        end
                        local y = ____f_e_y_91 - 92 + math.sin(a) * 5
                        R(
                            nil,
                            x - 1,
                            y - 4,
                            3,
                            9,
                            "#ffe24a"
                        )
                        R(
                            nil,
                            x - 4,
                            y - 1,
                            9,
                            3,
                            "#ffe24a"
                        )
                        k = k + 1
                    end
                end
            end
            if __t(f.k == "xicara" and __lt(f.t, 1.2)) then
                local x = h.x
                local y = h.y - 108 - f.t * 12
                R(
                    nil,
                    x - 9,
                    y,
                    18,
                    14,
                    "#f6f2ea"
                )
                R(
                    nil,
                    x + 9,
                    y + 3,
                    4,
                    7,
                    "#f6f2ea"
                )
                R(
                    nil,
                    x - 7,
                    y + 2,
                    14,
                    3,
                    "#5a3624"
                )
                do
                    local k = 0
                    while k < 3 do
                        R(
                            nil,
                            x - 6 + k * 5,
                            y - 8 - math.sin(t * 6 + k) * 2,
                            2,
                            6,
                            "rgba(255,255,255,.7)"
                        )
                        k = k + 1
                    end
                end
            end
            if f.k == "pow" then
                local s = 1 + f.t * 3
                c:save()
                c:translate(f.x, f.y)
                c:scale(s, s)
                c.globalAlpha = 1 - f.t / 0.4
                c.fillStyle = "#ffd24a"
                c:beginPath()
                do
                    local k = 0
                    while k < 16 do
                        local a = k / 16 * TAU
                        local r = if __t(__mod(k, 2)) then 10 else 22 * (0.6 + f.f * 0.5)
                        c:lineTo(
                            math.cos(a) * r,
                            math.sin(a) * r
                        )
                        k = k + 1
                    end
                end
                __call(c, "fill")
                c.font = "10px Pixel, monospace"
                c.textAlign = "center"
                c.fillStyle = "#c4384e"
                c:fillText("POW!", 0, 4)
                c:restore()
            end
            if f.k == "farelo" then
                do
                    local k = 0
                    while k < 5 do
                        R(
                            nil,
                            f.x + (k - 2) * 5 * (1 + u * 3),
                            f.y + u * 20 - math.abs(k - 2) * 4,
                            3,
                            3,
                            "#f6ecd0"
                        )
                        k = k + 1
                    end
                end
            end
            if f.k == "glitch" then
                do
                    local k = 0
                    while k < 6 do
                        R(
                            nil,
                            f.x - 30 + math.random() * 60,
                            f.y - 100 + k * 16,
                            20 + math.random() * 30,
                            4,
                            ("rgba(90,224,208," .. tostring(1 - u)) .. ")"
                        )
                        k = k + 1
                    end
                end
            end
        end
        if __t(carga) then
            local f = math.min(1, carga.t / carga.max)
            local x = h.x + if __lt(h.facing, 0) then -24 else 24
            local y = h.y - 48
            c.fillStyle = ("rgba(232,67,58," .. tostring(0.25 + f * 0.4)) .. ")"
            c:beginPath()
            c:arc(
                x,
                y,
                8 + f * 16 + math.sin(t * 30) * 2,
                0,
                TAU
            )
            __call(c, "fill")
            R(
                nil,
                h.x - 24,
                h.y - 120,
                48,
                6,
                "#2a1a14"
            )
            R(
                nil,
                h.x - 23,
                h.y - 119,
                46 * f,
                4,
                if f >= 1 then "#ffd24a" else "#e8433a"
            )
        end
        if escudo > 0 then
            local a = 0.35 + math.sin(t * 5) * 0.1 + escudoHit
            c.strokeStyle = ("rgba(255,210,74," .. tostring(math.min(1, a + 0.3))) .. ")"
            c.lineWidth = 3
            c.fillStyle = ("rgba(255,226,140," .. tostring(a * 0.4)) .. ")"
            c:beginPath()
            c:ellipse(
                h.x,
                h.y - 44,
                40,
                58,
                0,
                0,
                TAU
            )
            __call(c, "fill")
            c:stroke()
            do
                local k = 0
                while k < 4 do
                    local an = t * 2 + k * TAU / 4
                    local x = h.x + math.cos(an) * 40
                    local y = h.y - 44 + math.sin(an) * 56
                    R(
                        nil,
                        x - 4,
                        y - 2,
                        3,
                        3,
                        "#ff6a8a"
                    )
                    R(
                        nil,
                        x + 1,
                        y - 2,
                        3,
                        3,
                        "#ff6a8a"
                    )
                    R(
                        nil,
                        x - 3,
                        y + 1,
                        6,
                        2,
                        "#ff6a8a"
                    )
                    R(
                        nil,
                        x - 1,
                        y + 3,
                        2,
                        2,
                        "#ff6a8a"
                    )
                    k = k + 1
                end
            end
        end
        if flashTela > 0 then
            local ____t_93 = __t
            local ____TS__Number_result_92 = __TS__Number(mundo.camera)
            __O[469] = ____TS__Number_result_92
            local cam = if ____t_93(____TS__Number_result_92) then __O[469] else 0
            c.fillStyle = ("rgba(255,255,255," .. tostring(flashTela / 0.45 * 0.85)) .. ")"
            c:fillRect(cam - 20, -20, 1000, 600)
        end
        c:restore()
    end
    painel = nil
    sel = 0
    aoFechar = nil
    modoTeste = false
    local function css(self)
        if __t(window.document:getElementById("c2PoderesCss")) then
            return
        end
        local st = window.document:createElement("style")
        st.id = "c2PoderesCss"
        st.textContent = "#gameShell:not(.c2-controles) .c2-poder-btn{display:none!important}#gameShell.c2-controles :is(.reeis-btn,.taunt-btn,.vehicle-btn,.bivolt-btn){display:none!important}\n.c2-poder-btn{position:relative}.c2-poder-btn.vazio{opacity:.45}.c2-poder-btn .c2-cd{position:absolute;inset:0;background:rgba(10,8,6,.55);clip-path:inset(var(--cd,100%) 0 0 0);pointer-events:none;border-radius:inherit}\n.c2-mural{position:fixed;inset:0;z-index:2147483100;display:grid;place-items:center;background:rgba(8,6,4,.72);font-family:Pixel,monospace;color:#f6ead0;image-rendering:pixelated}.c2-mural[hidden]{display:none}\n.c2-mural .mb{width:min(980px,calc(100vw - 16px));max-height:calc(100vh - 16px);overflow:auto;background:#8a6a45;border:6px solid #4a2e18;box-shadow:0 0 0 4px #1c1208,0 18px 40px rgba(0,0,0,.6);padding:14px;background-image:radial-gradient(#9a7a52 1px,transparent 1px);background-size:6px 6px}\n.c2-mural h2{margin:0 0 4px;font-size:18px;color:#fff6d8;text-shadow:2px 2px #3a2414}.c2-mural .sub{font-size:10px;color:#f2e2b8;margin-bottom:10px}\n.c2-mural .linha{display:flex;gap:10px;flex-wrap:wrap;align-items:stretch;margin-bottom:10px}.c2-mural .slot{flex:1;min-width:200px;background:#2a1e14;border:3px solid #e8c66a;padding:8px;display:flex;gap:8px;align-items:center;cursor:pointer}.c2-mural .slot b{font-size:11px;color:#ffd98a}.c2-mural .slot span{font-size:9px;color:#c8b48a;display:block}\n.c2-mural .basicos{background:#f6efd8;color:#3a2414;border:2px solid #4a2e18;padding:6px 8px;font-size:9px;display:flex;flex-wrap:wrap;gap:8px;align-items:center}.c2-mural .basicos i{font-style:normal;display:inline-flex;gap:4px;align-items:center;background:#e8dcc0;padding:3px 6px;border:1px solid #b8a47a}.c2-mural .basicos svg{width:16px;height:16px;color:#3a2414}\n.c2-mural .grade{display:grid;grid-template-columns:repeat(4,1fr);gap:10px}@media(max-width:700px){.c2-mural .grade{grid-template-columns:repeat(2,1fr)}}\n.c2-mural .card{position:relative;background:#f6efd8;color:#2a1e14;border:2px solid #4a2e18;padding:8px 8px 6px;text-align:center;cursor:pointer;transform:rotate(var(--r,0deg));box-shadow:2px 3px 0 rgba(0,0,0,.35)}.c2-mural .card::before{content:'';position:absolute;top:-6px;left:50%;width:10px;height:10px;margin-left:-5px;background:var(--pin,#c43c3a);border-radius:50%;box-shadow:inset -2px -2px rgba(0,0,0,.3)}\n.c2-mural .card.sel{outline:4px solid #ffd24a;outline-offset:2px}.c2-mural .card.bloq{background:#3a2e24;color:#a8946a}.c2-mural .card canvas{width:64px;height:64px;image-rendering:pixelated;display:block;margin:0 auto 2px}.c2-mural .card b{font-size:10px;display:block}.c2-mural .card small{font-size:8px;display:block;margin-top:2px}.c2-mural .card .estr{color:#c4743a;font-size:10px}.c2-mural .card .eq{position:absolute;top:4px;right:4px;font-size:8px;background:#2c5a9e;color:#fff;padding:1px 4px}\n.c2-mural .det{margin-top:10px;background:#2a1e14;border:3px solid #e8c66a;padding:10px;display:flex;gap:12px;align-items:flex-start;flex-wrap:wrap}.c2-mural .det .ic{color:#f6ead0}.c2-mural .det .ic svg{width:48px;height:48px}.c2-mural .det p{margin:2px 0;font-size:11px;line-height:1.5}.c2-mural .det .nv{font-size:9px;color:#c8b48a}\n.c2-mural .bts{display:flex;gap:6px;flex-wrap:wrap;margin-top:6px}.c2-mural button{font:inherit;font-size:10px;padding:7px 10px;background:#4a3420;color:#f6ead0;border:2px solid #e8c66a;cursor:pointer}.c2-mural button:hover,.c2-mural button:focus{background:#e8c66a;color:#2a1e14;outline:none}.c2-mural button[disabled]{opacity:.4;cursor:default}\n.c2-mural .rod{display:flex;justify-content:space-between;align-items:center;margin-top:10px;font-size:9px;color:#fff6d8;gap:8px;flex-wrap:wrap}"
        window.document.head:appendChild(st)
    end
    local function montarMural(self)
        css(nil)
        painel = window.document:createElement("div")
        painel.className = "c2-mural"
        painel.hidden = true
        painel:setAttribute("role", "dialog")
        painel:setAttribute("aria-label", "Mural dos poderes")
        painel.innerHTML = "<div class=\"mb\"><h2>MURAL DOS PODERES</h2><div class=\"sub\">Os poderes da campanha 1 ficaram em Itabuna. Cada vilão vencido deixa um poder novo. Escolha dois para levar.</div><div class=\"linha slots\"></div><div class=\"basicos\"></div><div class=\"grade\" style=\"margin-top:14px\"></div><div class=\"det\"></div><div class=\"rod\"><span class=\"info\"></span><span class=\"bts\"><button type=\"button\" data-a=\"teste\" hidden>TESTE: LIBERAR TODOS</button><button type=\"button\" data-a=\"fechar\">PRONTO ✓</button></span></div></div>"
        window.document.body:appendChild(painel)
        painel:addEventListener(
            "click",
            function(____, e)
                local b = e.target:closest("[data-a]")
                if not __t(b) then
                    if e.target == painel then
                        fecharMural(nil)
                    end
                    return
                end
                local a = b.dataset.a
                if a == "fechar" then
                    fecharMural(nil)
                end
                if a == "teste" then
                    for ____, p in __iterar((PODERES)) do
                        desbloquear(nil, p.id)
                    end
                    render(nil)
                end
                if a == "card" then
                    sel = __TS__Number(b.dataset.i)
                    render(nil)
                end
                if __t(a == "eq0" or a == "eq1") then
                    equipar(
                        nil,
                        if a == "eq0" then 0 else 1,
                        __get(PODERES, sel).id
                    )
                    render(nil)
                end
                if a == "tirar" then
                    equipar(
                        nil,
                        __TS__Number(b.dataset.s),
                        nil
                    )
                    render(nil)
                end
                if a == "up" then
                    upgrade(
                        nil,
                        __get(PODERES, sel).id
                    )
                    render(nil)
                end
            end
        )
    end
    hash = function(____, n)
        local x = math.sin(n * 127.1 + 311.7) * 43758.5453
        return x - math.floor(x)
    end
    local function abrirMural(self, opts)
        if opts == nil then
            opts = {}
        end
        if not __t(painel) then
            montarMural(nil)
        end
        modoTeste = not not __t(opts.teste)
        aoFechar = if __t(opts.onClose) then opts.onClose else nil
        painel.hidden = false
        render(nil)
        window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {active = true}}))
    end
    window:addEventListener(
        "keydown",
        function(____, e)
            local ____t_124 = __t
            local ____t_123 = __t
            local ____temp_122 = not __t(painel)
            __O[475] = ____temp_122
            if ____t_124(if ____t_123(____temp_122) then __O[475] else painel.hidden) then
                return
            end
            local k = e.key
            if k == "Escape" then
                fecharMural(nil)
            elseif k == "ArrowRight" then
                sel = __mod(sel + 1, 8)
                render(nil)
            elseif k == "ArrowLeft" then
                sel = __mod(sel + 7, 8)
                render(nil)
            elseif k == "ArrowDown" then
                sel = __mod(sel + 4, 8)
                render(nil)
            elseif k == "ArrowUp" then
                sel = __mod(sel + 4, 8)
                render(nil)
            elseif __t(k == "1" or k == "2") then
                equipar(
                    nil,
                    __TS__Number(k) - 1,
                    __get(PODERES, sel).id
                )
                render(nil)
            else
                local ____t_128 = __t
                local ____temp_127 = k == "Enter"
                if ____temp_127 then
                    local ____opt_125 = window.document.activeElement
                    ____temp_127 = (____opt_125 and ____opt_125.tagName) == "BUTTON"
                end
                if ____t_128(____temp_127) then
                    return
                else
                    return
                end
            end
            e:preventDefault()
            e:stopImmediatePropagation()
        end,
        true
    )
    local function criarBotoes(self)
        local box = window.document:querySelector("#gameShell .touch-extras")
        local ____t_131 = __t
        local ____t_130 = __t
        local ____temp_129 = not __t(box)
        __O[476] = ____temp_129
        if ____t_131(if ____t_130(____temp_129) then __O[476] else window.document:getElementById("c2Poder1")) then
            return
        end
        css(nil)
        __call(
            __arrL({0, 1}, 2),
            "forEach",
            function(____, i)
                local b = window.document:createElement("button")
                b.type = "button"
                b.id = "c2Poder" .. tostring(i + 1)
                b.className = "touch-btn c2-poder-btn"
                b.dataset.action = "poder" .. tostring(i + 1)
                b:setAttribute(
                    "aria-label",
                    "Poder equipado " .. tostring(i + 1)
                )
                box:appendChild(b)
            end
        )
        atualizarBotoes(nil)
    end
    local function atualizarRecarga(self)
        __call(
            __arrL({0, 1}, 2),
            "forEach",
            function(____, i)
                local b = window.document:getElementById("c2Poder" .. tostring(i + 1))
                local p = byId(
                    nil,
                    __get(estado.equipados, i)
                )
                if __t(not __t(b) or not __t(p)) then
                    return
                end
                local ____t_133 = __t
                local ____get_result_132 = __get(cd, p.id)
                __O[477] = ____get_result_132
                local f = if ____t_133(____get_result_132) then __O[477] else 0 / lv(nil, p, "recarga")
                local ____opt_134 = b:querySelector(".c2-cd")
                if ____opt_134 ~= nil then
                    ____opt_134.style:setProperty(
                        "--cd",
                        tostring(math.floor((1 - f) * 100 + 0.5)) .. "%"
                    )
                end
            end
        )
    end
    local ativo = false
    local forcado = nil
    local function controles(self, on, o)
        if __t(if __t(o) then o.forcar ~= nil else o) then
            forcado = if __t(o.forcar) then not not __t(on) else nil
        end
        if forcado ~= nil then
            on = forcado
        end
        on = not not __t(on)
        if on == ativo then
            return
        end
        ativo = on
        criarBotoes(nil)
        local ____opt_136 = window.document:getElementById("gameShell")
        if ____opt_136 ~= nil then
            ____opt_136.classList:toggle("c2-controles", on)
        end
    end
    if window.document.readyState == "loading" then
        window:addEventListener("DOMContentLoaded", criarBotoes)
    else
        criarBotoes(nil)
    end
    window:setInterval(atualizarRecarga, 120)
    window.CampanhaPoderes = __ord(
        {
            lista = function() return __call(
                PODERES,
                "map",
                function(____, ____bindingPattern0)
                    local nivel
                    local cor
                    local desc
                    local lugar
                    local quem
                    local vilao
                    local curto
                    local nome
                    local id
                    id = ____bindingPattern0.id
                    nome = ____bindingPattern0.nome
                    curto = ____bindingPattern0.curto
                    vilao = ____bindingPattern0.vilao
                    quem = ____bindingPattern0.quem
                    lugar = ____bindingPattern0.lugar
                    desc = ____bindingPattern0.desc
                    cor = ____bindingPattern0.cor
                    nivel = ____bindingPattern0.nivel
                    return {
                        id = id,
                        nome = nome,
                        curto = curto,
                        vilao = vilao,
                        quem = quem,
                        lugar = lugar,
                        desc = desc,
                        cor = cor,
                        niveis = if __t(nivel) then __call(nivel, "slice") else __arrL({}, 0)
                    }
                end
            ) end,
            basicos = function() return __call(BASICOS, "slice") end,
            sairam = function() return __call(SAIRAM, "slice") end,
            estado = estadoPublico,
            desbloquear = desbloquear,
            equipar = equipar,
            upgrade = upgrade,
            ouvir = function(____, f)
                __call(ouvintes, "add", f)
                return function() return __call(ouvintes, "delete", f) end
            end,
            usar = usar,
            atualizar = atualizar,
            desenhar = desenhar,
            filtrarDano = filtrarDano,
            multiplicadores = multiplicadores,
            recarga = function(____, id)
                local ____t_139 = __t
                local ____get_result_138 = __get(cd, id)
                __O[478] = ____get_result_138
                return if ____t_139(____get_result_138) then __O[478] else 0
            end,
            recargaTotal = function(____, id) return if __t(byId(nil, id)) then lv(
                nil,
                byId(nil, id),
                "recarga"
            ) else 1 end,
            escudo = function() return escudo > 0 end,
            abrirMural = abrirMural,
            fecharMural = fecharMural,
            muralAberto = function() return not not __t(painel) and not __t(painel.hidden) end,
            controles = controles,
            ativa = function() return ativo end,
            iconeSVG = function(____, id) return if __t(byId(nil, id)) then iconeSVG(
                nil,
                byId(nil, id)
            ) else "" end,
            zerar = function()
                estado = {
                    desbloqueados = __arrL({}, 0),
                    equipados = __arr(nil, nil),
                    niveis = {}
                }
                salvar(nil)
                for ____, k in __iterar((__keys(cd))) do
                    __set(cd, k, 0)
                end
                buff = nil
                escudo = 0
                clone = nil
                efeitos = __arrL({}, 0)
                proj = __arrL({}, 0)
            end
        },
        "lista,basicos,sairam,estado,desbloquear,equipar,upgrade,ouvir,usar,atualizar,desenhar,filtrarDano,multiplicadores,recarga,recargaTotal,escudo,abrirMural,fecharMural,muralAberto,controles,ativa,iconeSVG,zerar"
    )
end)(nil)
return ____exports
