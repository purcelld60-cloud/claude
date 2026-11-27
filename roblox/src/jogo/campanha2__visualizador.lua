--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __le, __gt, __ge, __mod, __ord, __arrL, __iterar, __t, __get, __len, __call = __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__len, __JSR.__call
local __add, __assign, __re, __re_test = __JSR.__add, __JSR.__assign, __JSR.__re, __JSR.__re_test
local ____lualib = require(script.Parent.lualib_bundle)
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local __TS__Number = ____lualib.__TS__Number
local __TS__Iterator = ____lualib.__TS__Iterator
local ____exports = {}
local __O = {};
(function()
    local alternarTreino, go, irPara, close, jump, hit, usar, L, FLOOR, P, idx, cam, hour, keys, open, atkT, viagem, fade, perto, box, idxOf
    function alternarTreino(self)
        local TR = window.CampanhaTreino
        if not __t(TR) then
            return
        end
        if not __t(box:querySelector(".c2-treino-wrap")) then
            TR:montarBarra(
                box:querySelector(".c2-tela"),
                function(____, id, down)
                    if __t(TR:acao(id, down, P)) then
                        return
                    end
                    if id == "jump" then
                        if __t(down) then
                            __call(keys, "add", "jump")
                            jump(nil)
                        else
                            __call(keys, "delete", "jump")
                        end
                    end
                    local ____t_21 = __t
                    local ____t_20 = __t
                    local ____temp_19 = id == "interact"
                    __O[642] = ____temp_19
                    if ____t_21(if ____t_20(____temp_19) then down else __O[642]) then
                        usar(nil)
                    end
                end
            )
        end
        TR:ligar(nil, P)
    end
    function go(self, d)
        idx = __mod(
            __add(
                idx + d,
                __len(L)
            ),
            __len(L)
        )
        P.x = 300
        P.y = FLOOR
        P.vy = 0
        cam = 0
        viagem = nil
        if __t(__get(L, idx).noite) then
            hour = 3
        end
    end
    function irPara(self, id, x)
        idx = idxOf(nil, id)
        P.x = x
        P.y = FLOOR
        P.vy = 0
        P.ground = true
        cam = math.max(
            0,
            math.min(
                __get(L, idx).largura - 960,
                x - 360
            )
        )
        if __t(__get(L, idx).noite) then
            hour = 3
        end
    end
    function close(self)
        open = false
        box:remove()
        do
            pcall(function()
                local ____opt_24 = window.DayTime
                if ____opt_24 ~= nil then
                    ____opt_24 = ____opt_24.force
                end
                if ____opt_24 ~= nil then
                    ____opt_24(____opt_24, nil)
                end
            end)
        end
    end
    function jump(self)
        if __t(if __t(P.ground) then not __t(viagem) else P.ground) then
            P.vy = -620
            P.ground = false
        end
    end
    function hit(self)
        if __t(atkT <= 0 and not __t(viagem)) then
            atkT = 0.32
        end
    end
    function usar(self)
        if __t(if __t(viagem) then viagem else not __t(perto)) then
            return
        end
        local p = perto
        if p.tipo == "extra" then
            __call(keys, "clear")
            if p.id == "loja" then
                local ____opt_76 = window.CampanhaLoja
                if ____opt_76 ~= nil then
                    ____opt_76 = ____opt_76.abrir
                end
                if ____opt_76 ~= nil then
                    ____opt_76(____opt_76, {teste = true})
                end
            else
                local ____opt_80 = window.CampanhaTaxi
                if ____opt_80 ~= nil then
                    ____opt_80 = ____opt_80.abrir
                end
                if ____opt_80 ~= nil then
                    ____opt_80(
                        ____opt_80,
                        __get(L, idx).id,
                        function(____, cena, x)
                            viagem = nil
                            fade = 0
                            irPara(nil, cena, x + 120)
                        end,
                        {teste = true}
                    )
                end
            end
            return
        end
        if p.tipo == "poderes" then
            __call(keys, "clear")
            local ____opt_84 = window.CampanhaPoderes
            if ____opt_84 ~= nil then
                ____opt_84 = ____opt_84.abrirMural
            end
            if ____opt_84 ~= nil then
                ____opt_84(____opt_84, {teste = true})
            end
            return
        end
        if p.tipo == "conversa" then
            __call(keys, "clear")
            local ____opt_88 = window.CampanhaMoradores
            if ____opt_88 ~= nil then
                ____opt_88 = ____opt_88.conversar
            end
            if ____opt_88 ~= nil then
                ____opt_88(____opt_88, p.id)
            end
            return
        end
        if p.tipo == "armario" then
            local ____t_92 = __t
            local ____opt_90 = window.DarocaLook
            if ____opt_90 ~= nil then
                ____opt_90 = ____opt_90.open
            end
            if ____t_92(____opt_90) then
                __call(keys, "clear")
                window.DarocaLook:open({title = "ARMÁRIO DO QUARTO 4", line = "Escolha a roupa do Da Roça para hoje."})
            end
            return
        end
        if p.tipo == "pc" then
            local ____t_95 = __t
            local ____opt_93 = window.Fliperama
            if ____opt_93 ~= nil then
                ____opt_93 = ____opt_93.open
            end
            if ____t_95(____opt_93) then
                __call(keys, "clear")
                window.Fliperama:open(nil, {from = "quarto"})
            end
            return
        end
        if p.tipo == "rolante" then
            __call(keys, "clear")
            viagem = {
                tipo = "rolante",
                t = 0,
                dur = 2.2,
                de = __arrL({P.x, P.y}, 2),
                ini = p.de,
                fim = p.ate,
                para = p.para
            }
            return
        end
        __call(keys, "clear")
        viagem = {tipo = "porta", t = 0, para = p.para}
    end
    local ____ = "use strict"
    local ____t_2 = __t
    local ____t_1 = __t
    local ____temp_0 = not __re_test(
        __re("[?&]cenarios2\\b", ""),
        window.location.search
    ) or not __t(window.CampanhaCenarios)
    __O[640] = ____temp_0
    if ____t_2(if ____t_1(____temp_0) then __O[640] else not __t(window.Art)) then
        return
    end
    L = window.CampanhaCenarios.lista
    FLOOR = 440
    local HOURS = __arrL(
        {
            __arrL({"MANHÃ", 7}, 2),
            __arrL({"TARDE", 15}, 2),
            __arrL({"PÔR DO SOL", 17.4}, 2),
            __arrL({"NOITE", 21}, 2)
        },
        4
    )
    P = __ord({
        x = 300,
        y = FLOOR,
        vx = 0,
        vy = 0,
        ground = true,
        facing = 1,
        attack = 0
    }, "x,y,vx,vy,ground,facing,attack")
    idx = 0
    cam = 0
    hour = 1
    keys = __TS__New(Set)
    local last = window.performance:now()
    local t = 0
    open = true
    atkT = 0
    viagem = nil
    fade = 0
    perto = nil
    local function portais(____, id)
        local ____t_8 = __t
        local ____opt_5 = window.CampanhaAmbientes
        if ____opt_5 ~= nil then
            ____opt_5 = ____opt_5.portais
        end
        local ____opt_result_7
        if ____opt_5 ~= nil then
            ____opt_result_7 = ____opt_5(____opt_5, id)
        end
        __O[641] = ____opt_result_7
        return if ____t_8(____opt_result_7) then __O[641] else __arrL({}, 0)
    end
    box = window.document:createElement("div")
    box.style.cssText = "position:fixed;inset:0;z-index:100000;background:#0b0f14;display:flex;flex-direction:column;align-items:center;justify-content:center;gap:8px;font:12px Pixel,monospace;color:#f2efe6;touch-action:none"
    box.innerHTML = "<div class=\"c2-top\" style=\"display:flex;gap:6px;flex-wrap:wrap;justify-content:center\"></div><div class=\"c2-tela\" style=\"position:relative;width:min(100vw,177.7vh);max-height:calc(100vh - 120px);aspect-ratio:16/9\"><canvas id=\"c2Viewer\" width=\"960\" height=\"540\" style=\"width:100%;height:100%;image-rendering:pixelated;display:block\"></canvas><button class=\"c2-entrar\" hidden style=\"position:absolute;right:3%;bottom:6%;font:12px Pixel,monospace;padding:12px 16px;background:#e8a83a;color:#1c1408;border:3px solid #fff2c8;border-radius:6px;cursor:pointer;box-shadow:0 4px 0 #8a5a1a\"></button></div><div class=\"c2-bot\" style=\"display:flex;gap:8px;flex-wrap:wrap;justify-content:center\"></div>"
    window.document.body:append(box)
    local cv = box:querySelector("canvas")
    local c = cv:getContext("2d", {alpha = false})
    c.imageSmoothingEnabled = false
    local entrar = box:querySelector(".c2-entrar")
    entrar:addEventListener(
        "click",
        function() return usar(nil) end
    )
    local function btn(____, label, fn, hold)
        local b = window.document:createElement("button")
        b.textContent = label
        b.style.cssText = "font:11px Pixel,monospace;padding:8px 12px;background:#2a3540;color:#f2efe6;border:2px solid #4a5a68;border-radius:4px;cursor:pointer"
        if __t(hold) then
            local function on(____, e)
                e:preventDefault()
                __call(keys, "add", hold)
                if hold == "jump" then
                    jump(nil)
                end
                if hold == "hit" then
                    hit(nil)
                end
            end
            local function off()
                return __call(keys, "delete", hold)
            end
            b:addEventListener("pointerdown", on)
            b:addEventListener("pointerup", off)
            b:addEventListener("pointerleave", off)
            b:addEventListener("pointercancel", off)
        else
            b:addEventListener("click", fn)
        end
        return b
    end
    local top = box:querySelector(".c2-top")
    local bot = box:querySelector(".c2-bot")
    local title = window.document:createElement("span")
    title.style.cssText = "padding:8px 10px;min-width:260px;text-align:center;color:#e8c66a"
    top:append(
        btn(
            nil,
            "◀ CENÁRIO",
            function() return go(nil, -1) end
        ),
        title,
        btn(
            nil,
            "CENÁRIO ▶",
            function() return go(nil, 1) end
        )
    )
    bot:append(
        btn(nil, "◀", nil, "left"),
        btn(nil, "▶", nil, "right"),
        btn(nil, "PULAR", nil, "jump"),
        btn(nil, "BATER", nil, "hit")
    )
    __call(
        HOURS,
        "forEach",
        function(____, ____bindingPattern0, i)
            local n
            n = ____bindingPattern0[1]
            return bot:append(btn(
                nil,
                n,
                function()
                    hour = i
                end
            ))
        end
    )
    bot:append(
        btn(
            nil,
            "TREINO (P)",
            function() return alternarTreino(nil) end
        ),
        btn(
            nil,
            "MURAL",
            function()
                local ____opt_11 = window.CampanhaPoderes
                if ____opt_11 ~= nil then
                    ____opt_11 = ____opt_11.abrirMural
                end
                local ____opt_result_13
                if ____opt_11 ~= nil then
                    ____opt_result_13 = ____opt_11(____opt_11, {teste = true})
                end
                return ____opt_result_13
            end
        ),
        btn(
            nil,
            "CUTSCENES",
            function()
                local ____opt_16 = window.CampanhaCutscenes
                if ____opt_16 ~= nil then
                    ____opt_16 = ____opt_16.galeria
                end
                local ____opt_result_18
                if ____opt_16 ~= nil then
                    ____opt_result_18 = ____opt_16(____opt_16)
                end
                return ____opt_result_18
            end
        ),
        btn(nil, "FECHAR", close)
    )
    idxOf = function(____, id) return math.max(
        0,
        __call(
            L,
            "findIndex",
            function(____, d) return d.id == id end
        )
    ) end
    local function cobre()
        local ____t_65 = __t
        local ____t_59 = __t
        local ____t_52 = __t
        local ____t_45 = __t
        local ____t_38 = __t
        local ____t_31 = __t
        local ____opt_28 = window.Fliperama
        if ____opt_28 ~= nil then
            ____opt_28 = ____opt_28.isOpen
        end
        local ____opt_result_30
        if ____opt_28 ~= nil then
            ____opt_result_30 = ____opt_28(____opt_28)
        end
        __O[643] = ____opt_result_30
        local ____opt_34 = window.DarocaLook
        if ____opt_34 ~= nil then
            ____opt_34 = ____opt_34.isOpen
        end
        local ____opt_result_36
        if ____opt_34 ~= nil then
            ____opt_result_36 = ____opt_34(____opt_34)
        end
        local ____temp_37 = if ____t_31(____opt_result_30) then __O[643] else ____opt_result_36
        __O[644] = ____temp_37
        local ____opt_41 = window.CampanhaPoderes
        if ____opt_41 ~= nil then
            ____opt_41 = ____opt_41.muralAberto
        end
        local ____opt_result_43
        if ____opt_41 ~= nil then
            ____opt_result_43 = ____opt_41(____opt_41)
        end
        local ____temp_44 = if ____t_38(____temp_37) then __O[644] else ____opt_result_43
        __O[645] = ____temp_44
        local ____opt_48 = window.Mapa3D
        if ____opt_48 ~= nil then
            ____opt_48 = ____opt_48.aberto
        end
        local ____opt_result_50
        if ____opt_48 ~= nil then
            ____opt_result_50 = ____opt_48(____opt_48)
        end
        local ____temp_51 = if ____t_45(____temp_44) then __O[645] else ____opt_result_50
        __O[646] = ____temp_51
        local ____opt_55 = window.CampanhaLoja
        if ____opt_55 ~= nil then
            ____opt_55 = ____opt_55.aberta
        end
        local ____opt_result_57
        if ____opt_55 ~= nil then
            ____opt_result_57 = ____opt_55(____opt_55)
        end
        local ____temp_58 = if ____t_52(____temp_51) then __O[646] else ____opt_result_57
        __O[647] = ____temp_58
        local ____opt_62 = window.CampanhaCutscenes
        if ____opt_62 ~= nil then
            ____opt_62 = ____opt_62.aberta
        end
        local ____opt_result_64
        if ____opt_62 ~= nil then
            ____opt_result_64 = ____opt_62(____opt_62)
        end
        return not not ____t_65(if ____t_59(____temp_58) then __O[647] else ____opt_result_64)
    end
    local function ocupado()
        local ____t_67 = __t
        local ____cobre_result_66 = cobre(nil)
        __O[648] = ____cobre_result_66
        local ____t_73 = __t
        local ____opt_70 = window.CampanhaMoradores
        if ____opt_70 ~= nil then
            ____opt_70 = ____opt_70.aberto
        end
        local ____opt_result_72
        if ____opt_70 ~= nil then
            ____opt_result_72 = ____opt_70(____opt_70)
        end
        return if ____t_67(____cobre_result_66) then __O[648] else not not ____t_73(____opt_result_72)
    end
    window:addEventListener(
        "keydown",
        function(____, e)
            local ____t_98 = __t
            local ____t_97 = __t
            local ____temp_96 = not __t(open)
            __O[649] = ____temp_96
            if ____t_98(if ____t_97(____temp_96) then __O[649] else ocupado(nil)) then
                return
            end
            local k = e.code
            if __t(k == "ArrowLeft" or k == "KeyA") then
                __call(keys, "add", "left")
            end
            if __t(k == "ArrowRight" or k == "KeyD") then
                __call(keys, "add", "right")
            end
            local TR = window.CampanhaTreino
            local ____opt_result_103
            if TR ~= nil then
                ____opt_result_103 = TR.ligado
            end
            local ____opt_result_104
            if ____opt_result_103 ~= nil then
                ____opt_result_104 = ____opt_result_103(TR)
            end
            local treino = ____opt_result_104
            local mapa = {
                KeyJ = "paper",
                KeyK = "fart",
                KeyL = "dash",
                KeyU = "poder1",
                KeyI = "poder2"
            }
            if k == "KeyP" then
                alternarTreino(nil)
            end
            local ____t_107 = __t
            local ____t_106 = __t
            local ____temp_105 = if __t(treino) then __get(mapa, k) else treino
            __O[650] = ____temp_105
            if ____t_107(if ____t_106(____temp_105) then not __t(e["repeat"]) else __O[650]) then
                TR:acao(
                    __get(mapa, k),
                    true,
                    P
                )
            end
            local ____t_110 = __t
            local ____t_109 = __t
            local ____temp_108 = k == "Space" or k == "KeyW"
            __O[651] = ____temp_108
            if ____t_110(if ____t_109(____temp_108) then __O[651] else k == "ArrowUp") then
                __call(keys, "add", "jump")
                jump(nil)
                if __t(treino) then
                    TR:acao("jump", true, P)
                end
            end
            if __t(k == "KeyJ" and not __t(treino)) then
                hit(nil)
            end
            if __t(k == "KeyE" or k == "Enter") then
                usar(nil)
            end
            if k == "BracketLeft" then
                go(nil, -1)
            end
            if k == "BracketRight" then
                go(nil, 1)
            end
            if __re_test(
                __re("^Digit[1-4]$", ""),
                k
            ) then
                hour = __TS__Number(__call(k, "slice", 5)) - 1
            end
            if k == "Escape" then
                close(nil)
            end
            e:preventDefault()
            e:stopImmediatePropagation()
        end,
        true
    )
    window:addEventListener(
        "keyup",
        function(____, e)
            local TR = window.CampanhaTreino
            local ____t_117 = __t
            local ____opt_result_115
            if TR ~= nil then
                ____opt_result_115 = TR.ligado
            end
            local ____opt_result_116
            if ____opt_result_115 ~= nil then
                ____opt_result_116 = ____opt_result_115(TR)
            end
            if ____t_117(____opt_result_116) then
                if e.code == "KeyU" then
                    TR:acao("poder1", false, P)
                end
                if e.code == "KeyI" then
                    TR:acao("poder2", false, P)
                end
                local ____t_120 = __t
                local ____t_119 = __t
                local ____temp_118 = e.code == "Space" or e.code == "KeyW"
                __O[652] = ____temp_118
                if ____t_120(if ____t_119(____temp_118) then __O[652] else e.code == "ArrowUp") then
                    TR:acao("jump", false, P)
                end
            end
            local ____t_123 = __t
            local ____t_122 = __t
            local ____temp_121 = e.code == "Space" or e.code == "KeyW"
            __O[653] = ____temp_121
            if ____t_123(if ____t_122(____temp_121) then __O[653] else e.code == "ArrowUp") then
                __call(keys, "delete", "jump")
            end
            if __t(e.code == "ArrowLeft" or e.code == "KeyA") then
                __call(keys, "delete", "left")
            end
            if __t(e.code == "ArrowRight" or e.code == "KeyD") then
                __call(keys, "delete", "right")
            end
        end,
        true
    )
    local function physics(self, d, dt)
        local dir = if __t(__call(keys, "has", "right")) then 1 else 0 - if __t(__call(keys, "has", "left")) then 1 else 0
        if __t(dir) then
            P.facing = dir
        end
        local TR = window.CampanhaTreino
        local ____t_130 = __t
        local ____opt_result_128
        if TR ~= nil then
            ____opt_result_128 = TR.dashing
        end
        local ____opt_result_129
        if ____opt_result_128 ~= nil then
            ____opt_result_129 = ____opt_result_128(TR)
        end
        local ____temp_138 = dir * 260
        local ____t_137 = __t
        local ____opt_result_135
        if TR ~= nil then
            ____opt_result_135 = TR.velocidade
        end
        local ____opt_result_136
        if ____opt_result_135 ~= nil then
            ____opt_result_136 = ____opt_result_135(TR)
        end
        __O[654] = ____opt_result_136
        P.vx = if ____t_130(____opt_result_129) then P.vx else ____temp_138 * if ____t_137(____opt_result_136) then __O[654] else 1
        local lim = if __t(d.limites) then d.limites else __arrL({40, d.largura - 40}, 2)
        P.x = math.max(
            __get(lim, 0),
            math.min(
                __get(lim, 1),
                P.x + P.vx * dt
            )
        )
        local prevY = P.y
        P.vy = math.min(900, P.vy + 1700 * dt)
        P.y = P.y + P.vy * dt
        P.ground = false
        local overGap = __call(
            d.vaos,
            "some",
            function(____, ____bindingPattern0)
                local gw
                local gx
                gx = ____bindingPattern0[1]
                gw = ____bindingPattern0[2]
                return __gt(P.x, gx + 10) and P.x < __add(gx, gw) - 10
            end
        )
        for ____, r in __iterar((portais(nil, d.id))) do
            local ____t_141 = __t
            local ____t_140 = __t
            local ____temp_139 = r.tipo == "rampa" and __ge(P.x, r.x0)
            __O[655] = ____temp_139
            if ____t_141(if ____t_140(____temp_139) then __le(P.x, r.x1) else __O[655]) then
                local ry = r.y0 + (r.y1 - r.y0) * (P.x - r.x0) / (r.x1 - r.x0)
                local ____t_144 = __t
                local ____t_143 = __t
                local ____temp_142 = P.vy >= 0 and P.y >= ry - 14
                __O[656] = ____temp_142
                if ____t_144(if ____t_143(____temp_142) then __le(prevY, ry + 40) else __O[656]) then
                    P.y = ry
                    P.vy = 0
                    P.ground = true
                end
                local ____t_149 = __t
                local ____t_148 = __t
                local ____t_146 = __t
                local ____temp_145 = P.x >= r.x1 - 4
                __O[657] = ____temp_145
                local ____temp_147 = if ____t_146(____temp_145) then P.ground else __O[657]
                __O[658] = ____temp_147
                if ____t_149(if ____t_148(____temp_147) then dir > 0 else __O[658]) then
                    viagem = {tipo = "porta", t = 0, para = r.para}
                end
            end
        end
        if __t(P.vy >= 0 and not __t(P.ground)) then
            for ____, ____value in __iterar((d.plataformas)) do
                local px = ____value[1]
                local py = ____value[2]
                local pw = ____value[3]
                local ____t_154 = __t
                local ____t_153 = __t
                local ____t_151 = __t
                local ____temp_150 = P.x > px - 6 and __lt(
                    P.x,
                    __add(px, pw) + 6
                )
                __O[659] = ____temp_150
                local ____temp_152 = if ____t_151(____temp_150) then __le(prevY, py + 2) else __O[659]
                __O[660] = ____temp_152
                if ____t_154(if ____t_153(____temp_152) then __ge(P.y, py) else __O[660]) then
                    P.y = py
                    P.vy = 0
                    P.ground = true
                end
            end
            local ____t_157 = __t
            local ____t_156 = __t
            local ____temp_155 = not __t(P.ground) and not __t(overGap)
            __O[661] = ____temp_155
            if ____t_157(if ____t_156(____temp_155) then P.y >= FLOOR else __O[661]) then
                P.y = FLOOR
                P.vy = 0
                P.ground = true
            end
        end
        if P.y > 600 then
            P.x = math.max(60, P.x - 260)
            P.y = FLOOR - 200
            P.vy = 0
        end
        atkT = math.max(0, atkT - dt)
        P.attack = atkT
    end
    local function andarViagem(self, dt)
        local v = viagem
        v.t = __add(v.t, dt)
        if v.tipo == "rolante" then
            local u = math.min(1, v.t / v.dur)
            local k = if u < 0.15 then 0 else (u - 0.15) / 0.85
            P.x = if k <= 0 then __get(v.de, 0) + (__get(v.ini, 0) - __get(v.de, 0)) * (u / 0.15) else __get(v.ini, 0) + (__get(v.fim, 0) - __get(v.ini, 0)) * k
            P.y = if k <= 0 then FLOOR else __get(v.ini, 1) + (__get(v.fim, 1) - __get(v.ini, 1)) * k
            P.facing = if __gt(
                __get(v.fim, 0),
                __get(v.ini, 0)
            ) then 1 else -1
            P.vx = 0
            P.ground = true
            fade = math.max(0, (u - 0.78) / 0.22)
            if u >= 1 then
                irPara(nil, v.para.cena, v.para.x)
                viagem = {tipo = "chegada", t = 0}
            end
            return
        end
        if v.tipo == "porta" then
            fade = math.min(1, v.t / 0.35)
            P.vx = 0
            if __ge(v.t, 0.35) then
                irPara(nil, v.para.cena, v.para.x)
                viagem = {tipo = "chegada", t = 0}
            end
            return
        end
        if v.tipo == "chegada" then
            fade = math.max(0, 1 - v.t / 0.35)
            if __ge(v.t, 0.35) then
                viagem = nil
                fade = 0
            end
        end
    end
    local function frame(self, now)
        if not __t(open) then
            return
        end
        local dt = math.min(0.05, (now - last) / 1000)
        last = now
        local fl = cobre(nil)
        local ____t_163 = __t
        local ____opt_160 = window.CampanhaMoradores
        if ____opt_160 ~= nil then
            ____opt_160 = ____opt_160.aberto
        end
        local ____opt_result_162
        if ____opt_160 ~= nil then
            ____opt_result_162 = ____opt_160(____opt_160)
        end
        if ____t_163(____opt_result_162) then
            __call(keys, "clear")
            P.vx = 0
        end
        box.style.visibility = if __t(fl) then "hidden" else "visible"
        if __t(fl) then
            window:requestAnimationFrame(frame)
            return
        end
        t = t + dt
        local d = __get(L, idx)
        local ____opt_166 = window.CampanhaTreino
        if ____opt_166 ~= nil then
            ____opt_166 = ____opt_166.passo
        end
        if ____opt_166 ~= nil then
            ____opt_166(
                ____opt_166,
                dt,
                P,
                {
                    cam = cam,
                    segurandoPulo = __call(keys, "has", "jump")
                }
            )
        end
        if __t(viagem) then
            andarViagem(nil, dt)
        else
            physics(nil, d, dt)
        end
        local D = __get(L, idx)
        cam = cam + (math.max(
            0,
            math.min(D.largura - 960, P.x - 360)
        ) - cam) * math.min(1, dt * 8)
        do
            pcall(function()
                local ____opt_170 = window.DayTime
                if ____opt_170 ~= nil then
                    ____opt_170 = ____opt_170.force
                end
                if ____opt_170 ~= nil then
                    ____opt_170(
                        ____opt_170,
                        __get(
                            __get(HOURS, hour),
                            1
                        )
                    )
                end
            end)
        end
        local o = {
            scene = D.id,
            camera = cam,
            time = t,
            player = P,
            shots = __arrL({}, 0),
            enemies = __arrL({}, 0),
            minions = __arrL({}, 0)
        }
        do
            pcall(function()
                local ____opt_174 = window.Interact
                if ____opt_174 ~= nil then
                    ____opt_174 = ____opt_174.update
                end
                if ____opt_174 ~= nil then
                    ____opt_174(____opt_174, dt, o)
                end
            end)
        end
        local ____this_177
        ____this_177 = window.CampanhaCenarios
        local ____opt_176 = ____this_177.heroi
        if ____opt_176 ~= nil then
            ____opt_176(____this_177, P.x, P.y, P.vy)
        end
        window.Art:drawScene(c, D.id, cam, t)
        c:save()
        do
            local ____t_183 = __t
            local ____opt_180 = window.CampanhaTreino
            if ____opt_180 ~= nil then
                ____opt_180 = ____opt_180.tremor
            end
            local ____opt_result_182
            if ____opt_180 ~= nil then
                ____opt_result_182 = ____opt_180(____opt_180)
            end
            __O[662] = ____opt_result_182
            local sh = if ____t_183(____opt_result_182) then __O[662] else 0
            c:translate(
                -math.floor(cam + 0.5) + math.floor((math.random() - 0.5) * sh + 0.5),
                math.floor((math.random() - 0.5) * sh + 0.5)
            )
        end
        for ____, pl in __iterar((D.plataformas)) do
            if __t(__gt(
                __add(
                    __get(pl, 0),
                    __get(pl, 2)
                ),
                cam - 20
            ) and __lt(
                __get(pl, 0),
                cam + 980
            )) then
                window.CampanhaCenarios:plataforma(c, D.id, pl, t)
            end
        end
        local ____opt_186 = window.Interact
        if ____opt_186 ~= nil then
            ____opt_186 = ____opt_186.drawBack
        end
        if ____opt_186 ~= nil then
            ____opt_186(____opt_186, c, o)
        end
        local ____opt_190 = window.CampanhaPlantas
        if ____opt_190 ~= nil then
            ____opt_190 = ____opt_190.drawBack
        end
        if ____opt_190 ~= nil then
            ____opt_190(____opt_190, c, o)
        end
        local ____opt_194 = window.CampanhaTaxi
        if ____opt_194 ~= nil then
            ____opt_194 = ____opt_194.desenhar
        end
        if ____opt_194 ~= nil then
            ____opt_194(____opt_194, c, o)
        end
        local ____opt_198 = window.CampanhaLoja
        if ____opt_198 ~= nil then
            ____opt_198 = ____opt_198.desenhar
        end
        if ____opt_198 ~= nil then
            ____opt_198(____opt_198, c, o)
        end
        local ____opt_202 = window.CampanhaMoradores
        if ____opt_202 ~= nil then
            ____opt_202 = ____opt_202.desenhar
        end
        if ____opt_202 ~= nil then
            ____opt_202(____opt_202, c, o)
        end
        local ____self_215 = window.Art
        local ____self_215_drawCharacter_216 = ____self_215.drawCharacter
        local ____P_x_213 = P.x
        local ____P_y_214 = P.y
        local ____t_211 = t
        local ____P_facing_212 = P.facing
        local ____t_207 = __t
        local ____t_205 = __t
        local ____temp_204 = not not __t(P.vx)
        __O[663] = ____temp_204
        local ____temp_206 = if ____t_205(____temp_204) then P.ground else __O[663]
        __O[664] = ____temp_206
        local ____opt_result_210
        if viagem ~= nil then
            ____opt_result_210 = viagem.tipo
        end
        ____self_215_drawCharacter_216(
            ____self_215,
            c,
            "daroca",
            ____P_x_213,
            ____P_y_214,
            {
                frame = ____t_211,
                facing = ____P_facing_212,
                moving = if ____t_207(____temp_206) then __O[664] else ____opt_result_210 == "porta",
                grounded = P.ground,
                vy = P.vy,
                attack = atkT > 0,
                attackType = "paper",
                attackProgress = 1 - atkT / 0.32
            }
        )
        local ____opt_219 = window.CampanhaTreino
        if ____opt_219 ~= nil then
            ____opt_219 = ____opt_219.desenhar
        end
        if ____opt_219 ~= nil then
            ____opt_219(____opt_219, c, t)
        end
        local ____opt_223 = window.Interact
        if ____opt_223 ~= nil then
            ____opt_223 = ____opt_223.drawFront
        end
        if ____opt_223 ~= nil then
            ____opt_223(____opt_223, c, o)
        end
        local ____opt_227 = window.CampanhaPlantas
        if ____opt_227 ~= nil then
            ____opt_227 = ____opt_227.drawFront
        end
        if ____opt_227 ~= nil then
            ____opt_227(____opt_227, c, o)
        end
        local ____opt_231 = window.CampanhaCamadas
        if ____opt_231 ~= nil then
            ____opt_231 = ____opt_231.primeiroPlano
        end
        if ____opt_231 ~= nil then
            ____opt_231(____opt_231, c, o)
        end
        perto = nil
        local ____t_235 = __t
        local ____t_234 = __t
        local ____temp_233 = not __t(viagem)
        __O[665] = ____temp_233
        if ____t_235(if ____t_234(____temp_233) then P.ground else __O[665]) then
            local best = 1000000000
            for ____, p in __iterar((portais(nil, D.id))) do
                if p.tipo == "rampa" then
                    continue
                end
                local dd = math.abs(p.x - P.x)
                if __t(dd < 70 and dd < best) then
                    best = dd
                    perto = p
                end
            end
            local ____opt_238 = window.CampanhaMoradores
            if ____opt_238 ~= nil then
                ____opt_238 = ____opt_238.perto
            end
            local ____opt_result_240
            if ____opt_238 ~= nil then
                ____opt_result_240 = ____opt_238(____opt_238, D.id, P.x)
            end
            local m = ____opt_result_240
            if __t(if __t(m) then math.abs(m.x - P.x) < best else m) then
                perto = {
                    tipo = "conversa",
                    id = m.id,
                    x = m.x,
                    rotulo = __add(
                        "CONVERSAR COM ",
                        __call(m.nome, "toUpperCase")
                    )
                }
            end
            for ____, X in __iterar((__arrL({window.CampanhaTaxi, window.CampanhaLoja}, 2))) do
                local ____opt_result_245
                if X ~= nil then
                    ____opt_result_245 = X.perto
                end
                local ____opt_result_246
                if ____opt_result_245 ~= nil then
                    ____opt_result_246 = ____opt_result_245(X, D.id, P.x)
                end
                local e = ____opt_result_246
                if __t(if __t(e) then not __t(perto) or math.abs(e.x - P.x) < math.abs(perto.x - P.x) else e) then
                    perto = __assign({}, {tipo = "extra"}, e)
                end
            end
        end
        if __t(perto) then
            local w = __len(perto.rotulo) * 7.6 + 34
            local x = perto.x
            local y = FLOOR - 150
            c.fillStyle = "#1c342de8"
            c:fillRect(x - w / 2, y - 13, w, 26)
            c.strokeStyle = "#e8c66a"
            c:strokeRect(x - w / 2 + 0.5, y - 12.5, w - 1, 25)
            c.font = "11px Pixel, monospace"
            c.textAlign = "center"
            c.textBaseline = "middle"
            c.fillStyle = "#f3d89e"
            c:fillText(
                __add("[E] ", perto.rotulo),
                x,
                y + 1
            )
        end
        c:restore()
        local ____opt_249 = window.CampanhaAmbientes
        if ____opt_249 ~= nil then
            ____opt_249 = ____opt_249.cobrir
        end
        if ____opt_249 ~= nil then
            ____opt_249(____opt_249, c, D.id, cam)
        end
        entrar.hidden = not __t(perto)
        if __t(perto) then
            entrar.textContent = if perto.tipo == "extra" then perto.botao else if perto.tipo == "conversa" then "FALAR" else if perto.tipo == "poderes" then "PODERES" else if perto.tipo == "pc" then "USAR" else if perto.tipo == "armario" then "ABRIR" else if perto.tipo == "rolante" then if __lt(
                __get(perto.ate, 1),
                FLOOR
            ) then "SUBIR" else "DESCER" else if __re_test(
                __re("^SAIR|DESCER", ""),
                perto.rotulo
            ) then "SAIR" else "ENTRAR"
        end
        local ____t_256 = __t
        local ____opt_253 = window.Graphics
        if ____opt_253 ~= nil then
            ____opt_253 = ____opt_253.isShader
        end
        local ____opt_result_255
        if ____opt_253 ~= nil then
            ____opt_result_255 = ____opt_253(____opt_253)
        end
        if ____t_256(____opt_result_255) then
            local ____opt_259 = window.Shader
            if ____opt_259 ~= nil then
                ____opt_259 = ____opt_259.apply
            end
            if ____opt_259 ~= nil then
                ____opt_259(
                    ____opt_259,
                    cv,
                    {
                        scene = D.id,
                        camera = cam,
                        time = t,
                        outdoor = not __t(D.interno)
                    }
                )
            end
        end
        if fade > 0 then
            c.fillStyle = ("rgba(8,10,14," .. tostring(fade)) .. ")"
            c:fillRect(0, 0, 960, 540)
        end
        title.textContent = __add(
            __add(
                __add(
                    __add(idx + 1, "/"),
                    __len(L)
                ),
                " · "
            ),
            __call(D.nome, "toUpperCase")
        )
        window:requestAnimationFrame(frame)
    end
    window:requestAnimationFrame(frame)
    window.CampanhaVisualizador = __ord(
        {
            go = function(____, i)
                idx = math.max(
                    0,
                    math.min(
                        __len(L) - 1,
                        i
                    )
                )
                P.x = 300
                P.y = FLOOR
                cam = 0
                viagem = nil
            end,
            cena = function(____, id, x)
                if x == nil then
                    x = 300
                end
                viagem = nil
                fade = 0
                irPara(nil, id, x)
            end,
            hora = function(____, i)
                hour = i
            end,
            ir = function(____, x)
                P.x = x
            end,
            bater = hit,
            usar = usar,
            fechar = close,
            jogador = function() return __assign({}, P) end,
            estado = function()
                local ____get_result_id_269 = __get(L, idx).id
                local ____t_264 = __t
                local ____opt_result_263
                if viagem ~= nil then
                    ____opt_result_263 = viagem.tipo
                end
                __O[666] = ____opt_result_263
                local ____temp_270 = if ____t_264(____opt_result_263) then __O[666] else nil
                local ____t_268 = __t
                local ____opt_result_267
                if perto ~= nil then
                    ____opt_result_267 = perto.rotulo
                end
                __O[667] = ____opt_result_267
                return {cena = ____get_result_id_269, viagem = ____temp_270, perto = if ____t_268(____opt_result_267) then __O[667] else nil}
            end
        },
        "go,cena,hora,ir,bater,usar,fechar,jogador,estado"
    )
end)(nil)
return ____exports
