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
                    local ____t_24 = __t
                    local ____t_result_23
                    local ____t_22 = __t
                    local ____temp_21 = id == "interact"
                    __O[660] = ____temp_21
                    if ____t_22(____temp_21) then
                        ____t_result_23 = down
                    else
                        ____t_result_23 = __O[660]
                    end
                    if ____t_24(____t_result_23) then
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
                local ____opt_27 = window.DayTime
                if ____opt_27 ~= nil then
                    ____opt_27 = ____opt_27.force
                end
                if ____opt_27 ~= nil then
                    ____opt_27(____opt_27, nil)
                end
            end)
        end
    end
    function jump(self)
        local ____t_30 = __t
        local ____t_result_29
        if __t(P.ground) then
            ____t_result_29 = not __t(viagem)
        else
            ____t_result_29 = P.ground
        end
        if ____t_30(____t_result_29) then
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
        local ____t_82 = __t
        local ____t_result_81
        if __t(viagem) then
            ____t_result_81 = viagem
        else
            ____t_result_81 = not __t(perto)
        end
        if ____t_82(____t_result_81) then
            return
        end
        local p = perto
        if p.tipo == "extra" then
            __call(keys, "clear")
            if p.id == "loja" then
                local ____opt_85 = window.CampanhaLoja
                if ____opt_85 ~= nil then
                    ____opt_85 = ____opt_85.abrir
                end
                if ____opt_85 ~= nil then
                    ____opt_85(____opt_85, {teste = true})
                end
            else
                local ____opt_89 = window.CampanhaTaxi
                if ____opt_89 ~= nil then
                    ____opt_89 = ____opt_89.abrir
                end
                if ____opt_89 ~= nil then
                    ____opt_89(
                        ____opt_89,
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
            local ____opt_93 = window.CampanhaPoderes
            if ____opt_93 ~= nil then
                ____opt_93 = ____opt_93.abrirMural
            end
            if ____opt_93 ~= nil then
                ____opt_93(____opt_93, {teste = true})
            end
            return
        end
        if p.tipo == "conversa" then
            __call(keys, "clear")
            local ____opt_97 = window.CampanhaMoradores
            if ____opt_97 ~= nil then
                ____opt_97 = ____opt_97.conversar
            end
            if ____opt_97 ~= nil then
                ____opt_97(____opt_97, p.id)
            end
            return
        end
        if p.tipo == "armario" then
            local ____t_101 = __t
            local ____opt_99 = window.DarocaLook
            if ____opt_99 ~= nil then
                ____opt_99 = ____opt_99.open
            end
            if ____t_101(____opt_99) then
                __call(keys, "clear")
                window.DarocaLook:open({title = "ARMÁRIO DO QUARTO 4", line = "Escolha a roupa do Da Roça para hoje."})
            end
            return
        end
        if p.tipo == "pc" then
            local ____t_104 = __t
            local ____opt_102 = window.Fliperama
            if ____opt_102 ~= nil then
                ____opt_102 = ____opt_102.open
            end
            if ____t_104(____opt_102) then
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
    local ____t_3 = __t
    local ____t_result_2
    local ____t_1 = __t
    local ____temp_0 = not __re_test(
        __re("[?&]cenarios2\\b", ""),
        window.location.search
    ) or not __t(window.CampanhaCenarios)
    __O[658] = ____temp_0
    if ____t_1(____temp_0) then
        ____t_result_2 = __O[658]
    else
        ____t_result_2 = not __t(window.Art)
    end
    if ____t_3(____t_result_2) then
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
        local ____t_result_10
        local ____t_9 = __t
        local ____opt_6 = window.CampanhaAmbientes
        if ____opt_6 ~= nil then
            ____opt_6 = ____opt_6.portais
        end
        local ____opt_result_8
        if ____opt_6 ~= nil then
            ____opt_result_8 = ____opt_6(____opt_6, id)
        end
        __O[659] = ____opt_result_8
        if ____t_9(____opt_result_8) then
            ____t_result_10 = __O[659]
        else
            ____t_result_10 = __arrL({}, 0)
        end
        return ____t_result_10
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
                local ____opt_13 = window.CampanhaPoderes
                if ____opt_13 ~= nil then
                    ____opt_13 = ____opt_13.abrirMural
                end
                local ____opt_result_15
                if ____opt_13 ~= nil then
                    ____opt_result_15 = ____opt_13(____opt_13, {teste = true})
                end
                return ____opt_result_15
            end
        ),
        btn(
            nil,
            "CUTSCENES",
            function()
                local ____opt_18 = window.CampanhaCutscenes
                if ____opt_18 ~= nil then
                    ____opt_18 = ____opt_18.galeria
                end
                local ____opt_result_20
                if ____opt_18 ~= nil then
                    ____opt_result_20 = ____opt_18(____opt_18)
                end
                return ____opt_result_20
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
        local ____t_71 = __t
        local ____t_result_70
        local ____t_64 = __t
        local ____t_result_63
        local ____t_57 = __t
        local ____t_result_56
        local ____t_50 = __t
        local ____t_result_49
        local ____t_43 = __t
        local ____t_result_42
        local ____t_36 = __t
        local ____opt_33 = window.Fliperama
        if ____opt_33 ~= nil then
            ____opt_33 = ____opt_33.isOpen
        end
        local ____opt_result_35
        if ____opt_33 ~= nil then
            ____opt_result_35 = ____opt_33(____opt_33)
        end
        __O[661] = ____opt_result_35
        if ____t_36(____opt_result_35) then
            ____t_result_42 = __O[661]
        else
            local ____opt_39 = window.DarocaLook
            if ____opt_39 ~= nil then
                ____opt_39 = ____opt_39.isOpen
            end
            local ____opt_result_41
            if ____opt_39 ~= nil then
                ____opt_result_41 = ____opt_39(____opt_39)
            end
            ____t_result_42 = ____opt_result_41
        end
        __O[662] = ____t_result_42
        if ____t_43(____t_result_42) then
            ____t_result_49 = __O[662]
        else
            local ____opt_46 = window.CampanhaPoderes
            if ____opt_46 ~= nil then
                ____opt_46 = ____opt_46.muralAberto
            end
            local ____opt_result_48
            if ____opt_46 ~= nil then
                ____opt_result_48 = ____opt_46(____opt_46)
            end
            ____t_result_49 = ____opt_result_48
        end
        __O[663] = ____t_result_49
        if ____t_50(____t_result_49) then
            ____t_result_56 = __O[663]
        else
            local ____opt_53 = window.Mapa3D
            if ____opt_53 ~= nil then
                ____opt_53 = ____opt_53.aberto
            end
            local ____opt_result_55
            if ____opt_53 ~= nil then
                ____opt_result_55 = ____opt_53(____opt_53)
            end
            ____t_result_56 = ____opt_result_55
        end
        __O[664] = ____t_result_56
        if ____t_57(____t_result_56) then
            ____t_result_63 = __O[664]
        else
            local ____opt_60 = window.CampanhaLoja
            if ____opt_60 ~= nil then
                ____opt_60 = ____opt_60.aberta
            end
            local ____opt_result_62
            if ____opt_60 ~= nil then
                ____opt_result_62 = ____opt_60(____opt_60)
            end
            ____t_result_63 = ____opt_result_62
        end
        __O[665] = ____t_result_63
        if ____t_64(____t_result_63) then
            ____t_result_70 = __O[665]
        else
            local ____opt_67 = window.CampanhaCutscenes
            if ____opt_67 ~= nil then
                ____opt_67 = ____opt_67.aberta
            end
            local ____opt_result_69
            if ____opt_67 ~= nil then
                ____opt_result_69 = ____opt_67(____opt_67)
            end
            ____t_result_70 = ____opt_result_69
        end
        return not not ____t_71(____t_result_70)
    end
    local function ocupado()
        local ____t_result_80
        local ____t_73 = __t
        local ____cobre_result_72 = cobre(nil)
        __O[666] = ____cobre_result_72
        if ____t_73(____cobre_result_72) then
            ____t_result_80 = __O[666]
        else
            local ____t_79 = __t
            local ____opt_76 = window.CampanhaMoradores
            if ____opt_76 ~= nil then
                ____opt_76 = ____opt_76.aberto
            end
            local ____opt_result_78
            if ____opt_76 ~= nil then
                ____opt_result_78 = ____opt_76(____opt_76)
            end
            ____t_result_80 = not not ____t_79(____opt_result_78)
        end
        return ____t_result_80
    end
    window:addEventListener(
        "keydown",
        function(____, e)
            local ____t_108 = __t
            local ____t_result_107
            local ____t_106 = __t
            local ____temp_105 = not __t(open)
            __O[667] = ____temp_105
            if ____t_106(____temp_105) then
                ____t_result_107 = __O[667]
            else
                ____t_result_107 = ocupado(nil)
            end
            if ____t_108(____t_result_107) then
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
            local ____opt_result_113
            if TR ~= nil then
                ____opt_result_113 = TR.ligado
            end
            local ____opt_result_114
            if ____opt_result_113 ~= nil then
                ____opt_result_114 = ____opt_result_113(TR)
            end
            local treino = ____opt_result_114
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
            local ____t_118 = __t
            local ____t_result_117
            local ____t_116 = __t
            local ____t_result_115
            if __t(treino) then
                ____t_result_115 = __get(mapa, k)
            else
                ____t_result_115 = treino
            end
            __O[668] = ____t_result_115
            if ____t_116(____t_result_115) then
                ____t_result_117 = not __t(e["repeat"])
            else
                ____t_result_117 = __O[668]
            end
            if ____t_118(____t_result_117) then
                TR:acao(
                    __get(mapa, k),
                    true,
                    P
                )
            end
            local ____t_122 = __t
            local ____t_result_121
            local ____t_120 = __t
            local ____temp_119 = k == "Space" or k == "KeyW"
            __O[669] = ____temp_119
            if ____t_120(____temp_119) then
                ____t_result_121 = __O[669]
            else
                ____t_result_121 = k == "ArrowUp"
            end
            if ____t_122(____t_result_121) then
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
            local ____t_129 = __t
            local ____opt_result_127
            if TR ~= nil then
                ____opt_result_127 = TR.ligado
            end
            local ____opt_result_128
            if ____opt_result_127 ~= nil then
                ____opt_result_128 = ____opt_result_127(TR)
            end
            if ____t_129(____opt_result_128) then
                if e.code == "KeyU" then
                    TR:acao("poder1", false, P)
                end
                if e.code == "KeyI" then
                    TR:acao("poder2", false, P)
                end
                local ____t_133 = __t
                local ____t_result_132
                local ____t_131 = __t
                local ____temp_130 = e.code == "Space" or e.code == "KeyW"
                __O[670] = ____temp_130
                if ____t_131(____temp_130) then
                    ____t_result_132 = __O[670]
                else
                    ____t_result_132 = e.code == "ArrowUp"
                end
                if ____t_133(____t_result_132) then
                    TR:acao("jump", false, P)
                end
            end
            local ____t_137 = __t
            local ____t_result_136
            local ____t_135 = __t
            local ____temp_134 = e.code == "Space" or e.code == "KeyW"
            __O[671] = ____temp_134
            if ____t_135(____temp_134) then
                ____t_result_136 = __O[671]
            else
                ____t_result_136 = e.code == "ArrowUp"
            end
            if ____t_137(____t_result_136) then
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
        local dir = (__t(__call(keys, "has", "right")) and 1 or 0) - (__t(__call(keys, "has", "left")) and 1 or 0)
        if __t(dir) then
            P.facing = dir
        end
        local TR = window.CampanhaTreino
        local ____t_result_154
        local ____t_144 = __t
        local ____opt_result_142
        if TR ~= nil then
            ____opt_result_142 = TR.dashing
        end
        local ____opt_result_143
        if ____opt_result_142 ~= nil then
            ____opt_result_143 = ____opt_result_142(TR)
        end
        if ____t_144(____opt_result_143) then
            ____t_result_154 = P.vx
        else
            local ____temp_153 = dir * 260
            local ____t_result_152
            local ____t_151 = __t
            local ____opt_result_149
            if TR ~= nil then
                ____opt_result_149 = TR.velocidade
            end
            local ____opt_result_150
            if ____opt_result_149 ~= nil then
                ____opt_result_150 = ____opt_result_149(TR)
            end
            __O[672] = ____opt_result_150
            if ____t_151(____opt_result_150) then
                ____t_result_152 = __O[672]
            else
                ____t_result_152 = 1
            end
            ____t_result_154 = ____temp_153 * ____t_result_152
        end
        P.vx = ____t_result_154
        local ____t_result_155
        if __t(d.limites) then
            ____t_result_155 = d.limites
        else
            ____t_result_155 = __arrL({40, d.largura - 40}, 2)
        end
        local lim = ____t_result_155
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
            local ____t_159 = __t
            local ____t_result_158
            local ____t_157 = __t
            local ____temp_156 = r.tipo == "rampa" and __ge(P.x, r.x0)
            __O[673] = ____temp_156
            if ____t_157(____temp_156) then
                ____t_result_158 = __le(P.x, r.x1)
            else
                ____t_result_158 = __O[673]
            end
            if ____t_159(____t_result_158) then
                local ry = r.y0 + (r.y1 - r.y0) * (P.x - r.x0) / (r.x1 - r.x0)
                local ____t_163 = __t
                local ____t_result_162
                local ____t_161 = __t
                local ____temp_160 = P.vy >= 0 and P.y >= ry - 14
                __O[674] = ____temp_160
                if ____t_161(____temp_160) then
                    ____t_result_162 = __le(prevY, ry + 40)
                else
                    ____t_result_162 = __O[674]
                end
                if ____t_163(____t_result_162) then
                    P.y = ry
                    P.vy = 0
                    P.ground = true
                end
                local ____t_169 = __t
                local ____t_result_168
                local ____t_167 = __t
                local ____t_result_166
                local ____t_165 = __t
                local ____temp_164 = P.x >= r.x1 - 4
                __O[675] = ____temp_164
                if ____t_165(____temp_164) then
                    ____t_result_166 = P.ground
                else
                    ____t_result_166 = __O[675]
                end
                __O[676] = ____t_result_166
                if ____t_167(____t_result_166) then
                    ____t_result_168 = dir > 0
                else
                    ____t_result_168 = __O[676]
                end
                if ____t_169(____t_result_168) then
                    viagem = {tipo = "porta", t = 0, para = r.para}
                end
            end
        end
        if __t(P.vy >= 0 and not __t(P.ground)) then
            for ____, ____value in __iterar((d.plataformas)) do
                local px = ____value[1]
                local py = ____value[2]
                local pw = ____value[3]
                local ____t_175 = __t
                local ____t_result_174
                local ____t_173 = __t
                local ____t_result_172
                local ____t_171 = __t
                local ____temp_170 = P.x > px - 6 and __lt(
                    P.x,
                    __add(px, pw) + 6
                )
                __O[677] = ____temp_170
                if ____t_171(____temp_170) then
                    ____t_result_172 = __le(prevY, py + 2)
                else
                    ____t_result_172 = __O[677]
                end
                __O[678] = ____t_result_172
                if ____t_173(____t_result_172) then
                    ____t_result_174 = __ge(P.y, py)
                else
                    ____t_result_174 = __O[678]
                end
                if ____t_175(____t_result_174) then
                    P.y = py
                    P.vy = 0
                    P.ground = true
                end
            end
            local ____t_179 = __t
            local ____t_result_178
            local ____t_177 = __t
            local ____temp_176 = not __t(P.ground) and not __t(overGap)
            __O[679] = ____temp_176
            if ____t_177(____temp_176) then
                ____t_result_178 = P.y >= FLOOR
            else
                ____t_result_178 = __O[679]
            end
            if ____t_179(____t_result_178) then
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
            local k = u < 0.15 and 0 or (u - 0.15) / 0.85
            local ____temp_180
            if k <= 0 then
                ____temp_180 = __get(v.de, 0) + (__get(v.ini, 0) - __get(v.de, 0)) * (u / 0.15)
            else
                ____temp_180 = __get(v.ini, 0) + (__get(v.fim, 0) - __get(v.ini, 0)) * k
            end
            P.x = ____temp_180
            P.y = k <= 0 and FLOOR or __get(v.ini, 1) + (__get(v.fim, 1) - __get(v.ini, 1)) * k
            P.facing = __gt(
                __get(v.fim, 0),
                __get(v.ini, 0)
            ) and 1 or -1
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
        local ____t_186 = __t
        local ____opt_183 = window.CampanhaMoradores
        if ____opt_183 ~= nil then
            ____opt_183 = ____opt_183.aberto
        end
        local ____opt_result_185
        if ____opt_183 ~= nil then
            ____opt_result_185 = ____opt_183(____opt_183)
        end
        if ____t_186(____opt_result_185) then
            __call(keys, "clear")
            P.vx = 0
        end
        box.style.visibility = __t(fl) and "hidden" or "visible"
        if __t(fl) then
            window:requestAnimationFrame(frame)
            return
        end
        t = t + dt
        local d = __get(L, idx)
        local ____opt_189 = window.CampanhaTreino
        if ____opt_189 ~= nil then
            ____opt_189 = ____opt_189.passo
        end
        if ____opt_189 ~= nil then
            ____opt_189(
                ____opt_189,
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
                local ____opt_193 = window.DayTime
                if ____opt_193 ~= nil then
                    ____opt_193 = ____opt_193.force
                end
                if ____opt_193 ~= nil then
                    ____opt_193(
                        ____opt_193,
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
                local ____opt_197 = window.Interact
                if ____opt_197 ~= nil then
                    ____opt_197 = ____opt_197.update
                end
                if ____opt_197 ~= nil then
                    ____opt_197(____opt_197, dt, o)
                end
            end)
        end
        local ____this_200
        ____this_200 = window.CampanhaCenarios
        local ____opt_199 = ____this_200.heroi
        if ____opt_199 ~= nil then
            ____opt_199(____this_200, P.x, P.y, P.vy)
        end
        window.Art:drawScene(c, D.id, cam, t)
        c:save()
        do
            local ____t_result_207
            local ____t_206 = __t
            local ____opt_203 = window.CampanhaTreino
            if ____opt_203 ~= nil then
                ____opt_203 = ____opt_203.tremor
            end
            local ____opt_result_205
            if ____opt_203 ~= nil then
                ____opt_result_205 = ____opt_203(____opt_203)
            end
            __O[680] = ____opt_result_205
            if ____t_206(____opt_result_205) then
                ____t_result_207 = __O[680]
            else
                ____t_result_207 = 0
            end
            local sh = ____t_result_207
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
        local ____opt_210 = window.Interact
        if ____opt_210 ~= nil then
            ____opt_210 = ____opt_210.drawBack
        end
        if ____opt_210 ~= nil then
            ____opt_210(____opt_210, c, o)
        end
        local ____opt_214 = window.CampanhaPlantas
        if ____opt_214 ~= nil then
            ____opt_214 = ____opt_214.drawBack
        end
        if ____opt_214 ~= nil then
            ____opt_214(____opt_214, c, o)
        end
        local ____opt_218 = window.CampanhaTaxi
        if ____opt_218 ~= nil then
            ____opt_218 = ____opt_218.desenhar
        end
        if ____opt_218 ~= nil then
            ____opt_218(____opt_218, c, o)
        end
        local ____opt_222 = window.CampanhaLoja
        if ____opt_222 ~= nil then
            ____opt_222 = ____opt_222.desenhar
        end
        if ____opt_222 ~= nil then
            ____opt_222(____opt_222, c, o)
        end
        local ____opt_226 = window.CampanhaMoradores
        if ____opt_226 ~= nil then
            ____opt_226 = ____opt_226.desenhar
        end
        if ____opt_226 ~= nil then
            ____opt_226(____opt_226, c, o)
        end
        local ____self_240 = window.Art
        local ____self_240_drawCharacter_241 = ____self_240.drawCharacter
        local ____P_x_238 = P.x
        local ____P_y_239 = P.y
        local ____t_236 = t
        local ____P_facing_237 = P.facing
        local ____t_result_235
        local ____t_231 = __t
        local ____t_result_230
        local ____t_229 = __t
        local ____temp_228 = not not __t(P.vx)
        __O[681] = ____temp_228
        if ____t_229(____temp_228) then
            ____t_result_230 = P.ground
        else
            ____t_result_230 = __O[681]
        end
        __O[682] = ____t_result_230
        if ____t_231(____t_result_230) then
            ____t_result_235 = __O[682]
        else
            local ____opt_result_234
            if viagem ~= nil then
                ____opt_result_234 = viagem.tipo
            end
            ____t_result_235 = ____opt_result_234 == "porta"
        end
        ____self_240_drawCharacter_241(
            ____self_240,
            c,
            "daroca",
            ____P_x_238,
            ____P_y_239,
            {
                frame = ____t_236,
                facing = ____P_facing_237,
                moving = ____t_result_235,
                grounded = P.ground,
                vy = P.vy,
                attack = atkT > 0,
                attackType = "paper",
                attackProgress = 1 - atkT / 0.32
            }
        )
        local ____opt_244 = window.CampanhaTreino
        if ____opt_244 ~= nil then
            ____opt_244 = ____opt_244.desenhar
        end
        if ____opt_244 ~= nil then
            ____opt_244(____opt_244, c, t)
        end
        local ____opt_248 = window.Interact
        if ____opt_248 ~= nil then
            ____opt_248 = ____opt_248.drawFront
        end
        if ____opt_248 ~= nil then
            ____opt_248(____opt_248, c, o)
        end
        local ____opt_252 = window.CampanhaPlantas
        if ____opt_252 ~= nil then
            ____opt_252 = ____opt_252.drawFront
        end
        if ____opt_252 ~= nil then
            ____opt_252(____opt_252, c, o)
        end
        local ____opt_256 = window.CampanhaCamadas
        if ____opt_256 ~= nil then
            ____opt_256 = ____opt_256.primeiroPlano
        end
        if ____opt_256 ~= nil then
            ____opt_256(____opt_256, c, o)
        end
        perto = nil
        local ____t_261 = __t
        local ____t_result_260
        local ____t_259 = __t
        local ____temp_258 = not __t(viagem)
        __O[683] = ____temp_258
        if ____t_259(____temp_258) then
            ____t_result_260 = P.ground
        else
            ____t_result_260 = __O[683]
        end
        if ____t_261(____t_result_260) then
            local best = 1000000000
            for ____, p in __iterar((portais(nil, D.id))) do
                do
                    if p.tipo == "rampa" then
                        continue
                    end
                    local dd = math.abs(p.x - P.x)
                    if __t(dd < 70 and dd < best) then
                        best = dd
                        perto = p
                    end
                end
            end
            local ____opt_264 = window.CampanhaMoradores
            if ____opt_264 ~= nil then
                ____opt_264 = ____opt_264.perto
            end
            local ____opt_result_266
            if ____opt_264 ~= nil then
                ____opt_result_266 = ____opt_264(____opt_264, D.id, P.x)
            end
            local m = ____opt_result_266
            local ____t_268 = __t
            local ____t_result_267
            if __t(m) then
                ____t_result_267 = math.abs(m.x - P.x) < best
            else
                ____t_result_267 = m
            end
            if ____t_268(____t_result_267) then
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
                local ____opt_result_273
                if X ~= nil then
                    ____opt_result_273 = X.perto
                end
                local ____opt_result_274
                if ____opt_result_273 ~= nil then
                    ____opt_result_274 = ____opt_result_273(X, D.id, P.x)
                end
                local e = ____opt_result_274
                local ____t_276 = __t
                local ____t_result_275
                if __t(e) then
                    ____t_result_275 = not __t(perto) or math.abs(e.x - P.x) < math.abs(perto.x - P.x)
                else
                    ____t_result_275 = e
                end
                if ____t_276(____t_result_275) then
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
        local ____opt_279 = window.CampanhaAmbientes
        if ____opt_279 ~= nil then
            ____opt_279 = ____opt_279.cobrir
        end
        if ____opt_279 ~= nil then
            ____opt_279(____opt_279, c, D.id, cam)
        end
        entrar.hidden = not __t(perto)
        if __t(perto) then
            local ____temp_286
            if perto.tipo == "extra" then
                ____temp_286 = perto.botao
            else
                local ____temp_285
                if perto.tipo == "conversa" then
                    ____temp_285 = "FALAR"
                else
                    local ____temp_284
                    if perto.tipo == "poderes" then
                        ____temp_284 = "PODERES"
                    else
                        local ____temp_283
                        if perto.tipo == "pc" then
                            ____temp_283 = "USAR"
                        else
                            local ____temp_282
                            if perto.tipo == "armario" then
                                ____temp_282 = "ABRIR"
                            else
                                local ____temp_281
                                if perto.tipo == "rolante" then
                                    ____temp_281 = __lt(
                                        __get(perto.ate, 1),
                                        FLOOR
                                    ) and "SUBIR" or "DESCER"
                                else
                                    ____temp_281 = __re_test(
                                        __re("^SAIR|DESCER", ""),
                                        perto.rotulo
                                    ) and "SAIR" or "ENTRAR"
                                end
                                ____temp_282 = ____temp_281
                            end
                            ____temp_283 = ____temp_282
                        end
                        ____temp_284 = ____temp_283
                    end
                    ____temp_285 = ____temp_284
                end
                ____temp_286 = ____temp_285
            end
            entrar.textContent = ____temp_286
        end
        local ____t_292 = __t
        local ____opt_289 = window.Graphics
        if ____opt_289 ~= nil then
            ____opt_289 = ____opt_289.isShader
        end
        local ____opt_result_291
        if ____opt_289 ~= nil then
            ____opt_result_291 = ____opt_289(____opt_289)
        end
        if ____t_292(____opt_result_291) then
            local ____opt_295 = window.Shader
            if ____opt_295 ~= nil then
                ____opt_295 = ____opt_295.apply
            end
            if ____opt_295 ~= nil then
                ____opt_295(
                    ____opt_295,
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
                local ____get_result_id_307 = __get(L, idx).id
                local ____t_result_301
                local ____t_300 = __t
                local ____opt_result_299
                if viagem ~= nil then
                    ____opt_result_299 = viagem.tipo
                end
                __O[684] = ____opt_result_299
                if ____t_300(____opt_result_299) then
                    ____t_result_301 = __O[684]
                else
                    ____t_result_301 = nil
                end
                local ____t_result_306
                local ____t_305 = __t
                local ____opt_result_304
                if perto ~= nil then
                    ____opt_result_304 = perto.rotulo
                end
                __O[685] = ____opt_result_304
                if ____t_305(____opt_result_304) then
                    ____t_result_306 = __O[685]
                else
                    ____t_result_306 = nil
                end
                return {cena = ____get_result_id_307, viagem = ____t_result_301, perto = ____t_result_306}
            end
        },
        "go,cena,hora,ir,bater,usar,fechar,jogador,estado"
    )
end)(nil)
return ____exports
