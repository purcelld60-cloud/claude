--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __newExpr, __lt, __le, __gt, __ge, __mod, __ord, __arrL, __iterar, __t, __get, __set = __JSR.__newExpr, __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set
local __len, __call, __add, __iter, __assign, __isArray, __re, __re_test, __re_replace = __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__iter, __JSR.__assign, __JSR.__isArray, __JSR.__re, __JSR.__re_test, __JSR.__re_replace
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__MathSign = ____lualib.__TS__MathSign
local __TS__Number = ____lualib.__TS__Number
local ____exports = {}
local __O = {};
(function()
    local atualizarSlots, PW, barra, bn, VFX, aviso
    function atualizarSlots(self)
        if not __t(barra) then
            return
        end
        __call(
            __arrL({0, 1}, 2),
            "forEach",
            function(____, i)
                local b = barra:querySelector(("[data-acao=\"poder" .. tostring(i + 1)) .. "\"]")
                local id = __get(
                    PW:estado().equipados,
                    i
                )
                local p = __call(
                    PW:lista(),
                    "find",
                    function(____, q) return q.id == id end
                )
                if not __t(b) then
                    return
                end
                b.classList:toggle(
                    "vazio",
                    not __t(p)
                )
                local ____temp_19 = __t(i) and "I" or "U"
                local ____t_result_17
                if __t(p) then
                    ____t_result_17 = PW:iconeSVG(id)
                else
                    ____t_result_17 = "<svg class=\"control-icon\" viewBox=\"0 0 24 24\" width=\"24\" height=\"24\"><path fill=\"currentColor\" d=\"M4 4h16v2H4zM4 18h16v2H4zM4 6h2v12H4zM18 6h2v12h-2z\"/></svg>"
                end
                local ____t_result_18
                if __t(p) then
                    ____t_result_18 = p.curto
                else
                    ____t_result_18 = "VAZIO"
                end
                b.innerHTML = ((((("<kbd>" .. ____temp_19) .. "</kbd>") .. tostring(____t_result_17)) .. "<small>") .. tostring(____t_result_18)) .. "</small><span class=\"c2-cd\"></span>"
            end
        )
    end
    local ____ = "use strict"
    local ____t_1 = __t
    local ____t_result_0
    if __t(window.CampanhaTreino) then
        ____t_result_0 = window.CampanhaTreino
    else
        ____t_result_0 = not __t(window.CampanhaPoderes)
    end
    if ____t_1(____t_result_0) then
        return
    end
    PW = window.CampanhaPoderes
    local FLOOR = 440
    local on = false
    local bonecos = __arrL({}, 0)
    local tiros = __arrL({}, 0)
    local nuvens = __arrL({}, 0)
    local textos = __arrL({}, 0)
    local gas = 100
    local voando = false
    local dashT = 0
    local dashCd = 0
    local shake = 0
    local cam = 0
    local heroRef = nil
    barra = nil
    local function copiarEstilo(self)
        if __t(window.document:getElementById("c2TreinoCss")) then
            return
        end
        local st = window.document:createElement("style")
        st.id = "c2TreinoCss"
        local txt = ""
        for ____, sh in __iterar((window.document.styleSheets)) do
            do
                local rules
                do
                    local ____hasContinued
                    local function ____catch(e)
                        ____hasContinued = true
                        return
                    end
                    local ____try, ____hasReturned = pcall(function()
                        rules = sh.cssRules
                    end)
                    if not ____try then
                        ____catch(____hasReturned)
                    end
                    if ____hasContinued then
                        continue
                    end
                end
                local ____iter_7 = __iter
                local ____t_result_6
                if __t(rules) then
                    ____t_result_6 = rules
                else
                    ____t_result_6 = __arrL({}, 0)
                end
                for ____, r in __TS__Iterator(____iter_7(____t_result_6)) do
                    local ____t_5 = __t
                    local ____t_result_4
                    local ____t_3 = __t
                    local ____t_result_2
                    if __t(r.selectorText) then
                        ____t_result_2 = __re_test(
                            __re("crafted-controls", ""),
                            r.selectorText
                        )
                    else
                        ____t_result_2 = r.selectorText
                    end
                    __O[503] = ____t_result_2
                    if ____t_3(____t_result_2) then
                        ____t_result_4 = __re_test(
                            __re("touch-btn|control-icon|kbd|-btn\\b", ""),
                            r.selectorText
                        )
                    else
                        ____t_result_4 = __O[503]
                    end
                    if ____t_5(____t_result_4) then
                        txt = __add(
                            txt,
                            __add(
                                __re_replace(
                                    __re_replace(
                                        r.cssText,
                                        __re("#gameShell\\s*", "g"),
                                        ""
                                    ),
                                    __re("\\.crafted-controls", "g"),
                                    ".c2-treino-ctl"
                                ),
                                "\n"
                            )
                        )
                    end
                end
            end
        end
        txt = __add(txt, ".c2-treino-ctl{position:absolute;right:2%;bottom:3%;display:grid;grid-template-columns:repeat(4,auto);gap:8px;z-index:3}.c2-treino-ctl .touch-btn{width:54px;height:54px;touch-action:none;user-select:none;-webkit-user-select:none}\n.c2-treino-ctl .touch-btn kbd{position:absolute;top:2px;left:4px;font:6px Pixel,monospace;opacity:.6}.c2-treino-ctl .touch-btn.pressed{transform:translateY(3px);filter:brightness(1.1)}.c2-treino-ctl .c2-poder-btn small{position:static;transform:none;color:inherit}.c2-treino-ctl .c2-poder-btn{--key-face:#c8a8e8;--key-edge:#8a6ab8;--key-ink:#4a2a6a;--key-light:#f0e0ff}.c2-treino-ctl .interact-btn{--key-face:#f0dcae;--key-edge:#b8955a;--key-ink:#5a3a1a;--key-light:#fff6d8}\n.c2-treino-ctl .c2-cd{position:absolute;inset:0;background:rgba(10,8,6,.55);clip-path:inset(var(--cd,100%) 0 0 0);pointer-events:none}.c2-treino-ctl .vazio{opacity:.5}\n.c2-treino-info{position:absolute;left:2%;top:3%;font:9px Pixel,monospace;color:#f3d89e;background:rgba(20,14,8,.7);padding:6px 8px;border:2px solid #e8c66a;line-height:1.6;z-index:3;max-width:46%}\n.c2-treino-gas{position:absolute;left:2%;bottom:4%;width:120px;height:10px;background:#1c1408;border:2px solid #e8c66a;z-index:3}.c2-treino-gas i{display:block;height:100%;background:linear-gradient(#9ae06a,#4a9a3a)}")
        st.textContent = txt
        window.document.head:appendChild(st)
    end
    local ORDEM = __arrL(
        {
            __arrL({"interact", "FALAR", "E"}, 3),
            __arrL({"jump", "VOAR", "␣"}, 3),
            __arrL({"paper", "PAPEL", "J"}, 3),
            __arrL({"fart", "PEIDO", "K"}, 3),
            __arrL({"dash", "DASH", "L"}, 3),
            __arrL({"poder1", "", "U"}, 3),
            __arrL({"poder2", "", "I"}, 3)
        },
        7
    )
    local function montarBarra(self, tela, acionar)
        copiarEstilo(nil)
        barra = window.document:createElement("div")
        barra.className = "c2-treino-wrap"
        barra.innerHTML = "<div class=\"c2-treino-info\"></div><div class=\"c2-treino-gas\"><i></i></div><div class=\"c2-treino-ctl\"></div>"
        tela:appendChild(barra)
        local ctl = barra:querySelector(".c2-treino-ctl")
        for ____, ____value in __iterar((ORDEM)) do
            local id = ____value[1]
            local nome = ____value[2]
            local k = ____value[3]
            local b = window.document:createElement("button")
            b.type = "button"
            b.dataset.acao = id
            if __t(__call(id, "startsWith", "poder")) then
                b.className = "touch-btn c2-poder-btn"
            else
                local orig = window.document:querySelector(("#gameShell .touch-controls [data-action=\"" .. tostring(id)) .. "\"]")
                local ____t_result_8
                if __t(orig) then
                    ____t_result_8 = __re_replace(
                        orig.className,
                        __re("\\b(pressed|campaign-layout-target)\\b", "g"),
                        ""
                    )
                else
                    ____t_result_8 = "touch-btn"
                end
                b.className = ____t_result_8
                local ____add_16 = __add
                local ____t_result_15
                local ____t_14 = __t
                local ____opt_9 = orig and orig:querySelector("svg")
                local ____temp_13 = ____opt_9 and ____opt_9.outerHTML
                __O[504] = ____temp_13
                if ____t_14(____temp_13) then
                    ____t_result_15 = __O[504]
                else
                    ____t_result_15 = ""
                end
                b.innerHTML = ____add_16(
                    ____t_result_15,
                    ("<small>" .. tostring(nome)) .. "</small>"
                )
            end
            b:insertAdjacentHTML(
                "afterbegin",
                ("<kbd>" .. tostring(k)) .. "</kbd>"
            )
            local function down(____, e)
                e:preventDefault()
                __call(b.classList, "add", "pressed")
                acionar(nil, id, true)
            end
            local function up()
                if not __t(b.classList:contains("pressed")) then
                    return
                end
                b.classList:remove("pressed")
                acionar(nil, id, false)
            end
            b:addEventListener("pointerdown", down)
            b:addEventListener("pointerup", up)
            b:addEventListener("pointerleave", up)
            b:addEventListener("pointercancel", up)
            ctl:appendChild(b)
        end
        atualizarSlots(nil)
        PW:ouvir(atualizarSlots)
    end
    local function novoBoneco(____, x)
        return {
            x = x,
            y = FLOOR,
            vx = 0,
            vy = 0,
            hp = 60,
            max = 60,
            stun = 0,
            conf = 0,
            hit = 0,
            morto = 0,
            golpe = 0,
            base = x
        }
    end
    local modoJogo = false
    local function ligar(self, v, P, o)
        if o == nil then
            o = {}
        end
        local ____v_20 = v
        if ____v_20 == nil then
            ____v_20 = not __t(on)
        end
        on = ____v_20
        modoJogo = not not __t(o.jogo)
        if __t(barra) then
            barra.hidden = not __t(on)
            local inf = barra:querySelector(".c2-treino-info")
            local gs = barra:querySelector(".c2-treino-gas")
            if __t(inf) then
                inf.hidden = modoJogo
            end
            if __t(gs) then
                gs.hidden = modoJogo
            end
        end
        if __t(on) then
            local ____t_result_21
            if __t(modoJogo) then
                ____t_result_21 = __arrL({}, 0)
            else
                ____t_result_21 = __arrL(
                    {
                        novoBoneco(nil, P.x + 170),
                        novoBoneco(nil, P.x + 250),
                        novoBoneco(nil, P.x + 330)
                    },
                    3
                )
            end
            bonecos = ____t_result_21
            heroRef = P
        else
            bonecos = __arrL({}, 0)
            tiros = __arrL({}, 0)
            nuvens = __arrL({}, 0)
        end
        return on
    end
    local function mundo()
        return {
            heroi = heroRef,
            inimigos = function() return bonecos end,
            camera = cam,
            dano = function(____, e, n, tipo, dir)
                if __le(e.hp, 0) then
                    return
                end
                local ____t_25 = __t
                local ____t_result_24
                local ____t_23 = __t
                local ____t_result_22
                if __t(modoJogo) then
                    ____t_result_22 = tipo ~= "papel"
                else
                    ____t_result_22 = modoJogo
                end
                __O[505] = ____t_result_22
                if ____t_23(____t_result_22) then
                    ____t_result_24 = tipo ~= "peido"
                else
                    ____t_result_24 = __O[505]
                end
                if ____t_25(____t_result_24) then
                    n = math.floor(n * 5 + 0.5)
                end
                e.piscaAte = window.performance:now() + 400
                if __t(e.onDano) then
                    local r = e:onDano(n, tipo, dir)
                    if r ~= false then
                        local ____call_32 = __call
                        local ____textos_31 = textos
                        local ____temp_29 = e.x + (math.random() - 0.5) * 20
                        local ____e_y_27 = e.y
                        local ____t_result_26
                        if __t(e.alto) then
                            ____t_result_26 = e.alto
                        else
                            ____t_result_26 = 90
                        end
                        local ____temp_30 = ____e_y_27 - ____t_result_26
                        local ____t_result_28
                        if __t(r) then
                            ____t_result_28 = r
                        else
                            ____t_result_28 = n
                        end
                        ____call_32(____textos_31, "push", {
                            x = ____temp_29,
                            y = ____temp_30,
                            n = ____t_result_28,
                            t = 0,
                            cor = tipo == "soco" and "#ffd24a" or (tipo == "confuso" and "#e48fb0" or "#fff6dc")
                        })
                    end
                    return
                end
                e.hp = math.max(0, e.hp - n)
                e.hit = 0.18
                __call(
                    textos,
                    "push",
                    {
                        x = e.x + (math.random() - 0.5) * 20,
                        y = e.y - 90,
                        n = n,
                        t = 0,
                        cor = tipo == "soco" and "#ffd24a" or (tipo == "confuso" and "#e48fb0" or "#fff6dc")
                    }
                )
                if __le(e.hp, 0) then
                    e.morto = 2.2
                    local ____opt_35 = window.CampanhaLoja
                    if ____opt_35 ~= nil then
                        ____opt_35 = ____opt_35.ganhar
                    end
                    if ____opt_35 ~= nil then
                        ____opt_35(____opt_35, 8)
                    end
                    __call(textos, "push", {
                        x = e.x,
                        y = e.y - 120,
                        n = "+8 ●",
                        t = 0,
                        cor = "#ffd24a"
                    })
                end
            end,
            empurrar = function(____, e, vx, vy)
                e.vx = vx
                e.vy = vy
            end,
            atordoar = function(____, e, s)
                e.stun = s
            end,
            confundir = function(____, e, s)
                e.conf = s
            end,
            tremer = function(____, n)
                shake = math.max(shake, n)
            end
        }
    end
    local function bater(self, e, n, tipo, dir)
        local ____self_48 = mundo(nil)
        local ____self_48_dano_49 = ____self_48.dano
        local ____e_47 = e
        local ____n_38 = n
        local ____t_result_37
        if __t(bn.damageMultiplier) then
            ____t_result_37 = bn.damageMultiplier
        else
            ____t_result_37 = 1
        end
        local ____temp_46 = ____n_38 * ____t_result_37 * PW:multiplicadores().forca
        local ____t_result_45
        local ____t_44 = __t
        local ____opt_41 = window.CampanhaAliados
        if ____opt_41 ~= nil then
            ____opt_41 = ____opt_41.forca
        end
        local ____opt_result_43
        if ____opt_41 ~= nil then
            ____opt_result_43 = ____opt_41(____opt_41)
        end
        __O[506] = ____opt_result_43
        if ____t_44(____opt_result_43) then
            ____t_result_45 = __O[506]
        else
            ____t_result_45 = 1
        end
        ____self_48_dano_49(
            ____self_48,
            ____e_47,
            math.max(
                1,
                math.floor(____temp_46 * ____t_result_45 + 0.5)
            ),
            tipo,
            dir
        )
    end
    local BONUS0 = __ord({
        maxHP = 100,
        maxGas = 100,
        damageMultiplier = 1,
        moveSpeed = 280,
        dashCooldown = 1.1,
        projectileTier = 0,
        gasRegen = 16,
        airGasRegen = 6
    }, "maxHP,maxGas,damageMultiplier,moveSpeed,dashCooldown,projectileTier,gasRegen,airGasRegen")
    bn = __assign({}, BONUS0)
    local C1 = __ord({weapon = 0, trained = true, miqueias = false}, "weapon,trained,miqueias")
    local function atualizarBonus()
        do
            local function ____catch(e)
                bn = __assign({}, BONUS0)
            end
            local ____try, ____hasReturned = pcall(function()
                local ____assign_58 = __assign
                local ____temp_57 = {}
                local ____t_result_56
                local ____t_55 = __t
                local ____opt_52 = window.Progression
                if ____opt_52 ~= nil then
                    ____opt_52 = ____opt_52.bonuses
                end
                local ____opt_result_54
                if ____opt_52 ~= nil then
                    ____opt_result_54 = ____opt_52(____opt_52)
                end
                __O[507] = ____opt_result_54
                if ____t_55(____opt_result_54) then
                    ____t_result_56 = __O[507]
                else
                    ____t_result_56 = {}
                end
                bn = ____assign_58(____temp_57, BONUS0, ____t_result_56)
            end)
            if not ____try then
                ____catch(____hasReturned)
            end
        end
    end
    local CFG = __ord({
        mover = 280,
        pulo = 365,
        grav = 850,
        voo = 235,
        empuxo = 1050,
        gasVoo = 17,
        gasChao = 16,
        gasAr = 6,
        gasMax = 100,
        papel = 600,
        papelVida = 1.5,
        papelCd = 0.23,
        papelMax = 30,
        dash = 600,
        dashT = 0.2,
        dashCd = 1.1
    }, "mover,pulo,grav,voo,empuxo,gasVoo,gasChao,gasAr,gasMax,papel,papelVida,papelCd,papelMax,dash,dashT,dashCd")
    local papeis = CFG.papelMax
    local municao = 0
    local cdPapel = 0
    local cdPeido = 0
    local combo = 0
    local janela = 0
    local dashDir = 1
    local segura = __ord({paper = false, fart = false}, "paper,fart")
    local rastro = __arrL({}, 0)
    local parts = __arrL({}, 0)
    local ctxSom = nil
    local function beep(self, freq, dur, ____type, vol)
        if freq == nil then
            freq = 440
        end
        if dur == nil then
            dur = 0.09
        end
        if ____type == nil then
            ____type = "square"
        end
        if vol == nil then
            vol = 0.025
        end
        do
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                local ____t_63 = __t
                local ____t_result_62
                local ____t_61 = __t
                local ____opt_59 = window.Game
                if ____opt_59 ~= nil then
                    ____opt_59 = ____opt_59.soundOn
                end
                __O[508] = ____opt_59
                if ____t_61(____opt_59) then
                    ____t_result_62 = not __t(window.Game:soundOn())
                else
                    ____t_result_62 = __O[508]
                end
                if ____t_63(____t_result_62) then
                    return true
                end
                local ____opt_66 = window.DarocaAudio
                if ____opt_66 ~= nil then
                    ____opt_66 = ____opt_66.sfx
                end
                local ____opt_result_68
                if ____opt_66 ~= nil then
                    ____opt_result_68 = ____opt_66(____opt_66)
                end
                local ____opt_result_68_69 = ____opt_result_68
                if ____opt_result_68_69 == nil then
                    ____opt_result_68_69 = 1
                end
                vol = vol * ____opt_result_68_69
                if vol <= 0.0005 then
                    return true
                end
                local ____t_result_72
                if __t(ctxSom) then
                    ____t_result_72 = ctxSom
                else
                    local ____newExpr_71 = __newExpr
                    local ____t_result_70
                    if __t(window.AudioContext) then
                        ____t_result_70 = window.AudioContext
                    else
                        ____t_result_70 = window.webkitAudioContext
                    end
                    ____t_result_72 = ____newExpr_71(____t_result_70)
                end
                ctxSom = ____t_result_72
                ctxSom:resume()
                local o = ctxSom:createOscillator()
                local g = ctxSom:createGain()
                local t0 = ctxSom.currentTime
                o.type = ____type
                o.frequency:setValueAtTime(freq, t0)
                o.frequency:exponentialRampToValueAtTime(
                    math.max(35, freq * 0.5),
                    t0 + dur
                )
                g.gain:setValueAtTime(vol, t0)
                g.gain:exponentialRampToValueAtTime(0.001, t0 + dur)
                o:connect(g)
                g:connect(ctxSom.destination)
                o:start()
                o:stop(t0 + dur)
            end)
            if ____try and ____hasReturned then
                return ____returnValue
            end
        end
    end
    local function fx(self, x, y, color, count, power)
        if count == nil then
            count = 10
        end
        if power == nil then
            power = 90
        end
        local n = math.min(
            12,
            math.max(
                0,
                math.floor(count * 0.5 + 0.5)
            ),
            math.max(
                0,
                96 - __len(parts)
            )
        )
        do
            local i = 0
            while i < n do
                __call(
                    parts,
                    "push",
                    {
                        x = x,
                        y = y,
                        vx = (math.random() * 2 - 1) * power,
                        vy = -power + math.random() * power * 1.35,
                        life = 0.18 + math.random() * 0.3,
                        color = color,
                        size = 2 + math.random() * 2
                    }
                )
                i = i + 1
            end
        end
    end
    local function papel(self, P)
        if cdPapel > 0 then
            return
        end
        if papeis <= 0 then
            aviso(nil, "O papel recarrega sozinho. Use o combo de gás enquanto espera!")
            cdPapel = 0.4
            return
        end
        local ____t_result_73
        if __t(C1.weapon) then
            ____t_result_73 = C1.weapon
        else
            ____t_result_73 = 0
        end
        local w = ____t_result_73
        local ____t_result_74
        if __t(C1.miqueias) then
            ____t_result_74 = bn.projectileTier
        else
            ____t_result_74 = 0
        end
        local tier = ____t_result_74
        local elemento = tier >= 2 and "electric" or (tier == 1 and "fire" or nil)
        local tipo = __t(elemento) and "papaia" or (w == 2 and "case" or (w == 1 and "ruler" or "paper"))
        local vel = __t(w) and 680 or CFG.papel
        local dano = (__t(C1.trained) and 28 or 18) + (w == 1 and 14 or (w == 2 and 22 or 0))
        cdPapel = w == 2 and 0.31 or CFG.papelCd
        papeis = papeis - 1
        shake = math.max(shake, 1.2)
        P.attack = 0.24
        P.attackType = "paper"
        P.attackDuration = 0.24
        local dir = __lt(P.facing, 0) and -1 or 1
        local alvo = __get(
            __call(
                __call(
                    bonecos,
                    "filter",
                    function(____, b)
                        local ____t_result_79
                        local ____t_78 = __t
                        local ____t_result_77
                        local ____t_76 = __t
                        local ____temp_75 = __gt(b.hp, 0) and not __t(b.intocavel)
                        __O[509] = ____temp_75
                        if ____t_76(____temp_75) then
                            ____t_result_77 = __TS__MathSign(b.x - P.x) == dir
                        else
                            ____t_result_77 = __O[509]
                        end
                        __O[510] = ____t_result_77
                        if ____t_78(____t_result_77) then
                            ____t_result_79 = math.abs(b.x - P.x) < 650
                        else
                            ____t_result_79 = __O[510]
                        end
                        return ____t_result_79
                    end
                ),
                "sort",
                function(____, a, b) return math.abs(a.x - P.x) - math.abs(b.x - P.x) end
            ),
            0
        )
        local ____t_result_83
        if __t(alvo) then
            local ____temp_82 = -0.85
            local ____alvo_y_81 = alvo.y
            local ____t_result_80
            if __t(alvo.alto) then
                ____t_result_80 = alvo.alto
            else
                ____t_result_80 = 80
            end
            ____t_result_83 = math.max(
                ____temp_82,
                math.min(
                    0.85,
                    math.atan(
                        ____alvo_y_81 - ____t_result_80 / 2 - (P.y - 32),
                        math.abs(alvo.x - P.x)
                    )
                )
            )
        else
            ____t_result_83 = 0
        end
        local mira = ____t_result_83
        local ____iter_85 = __iter
        local ____temp_84
        if w == 2 then
            ____temp_84 = __arrL({-0.11, 0, 0.11}, 3)
        else
            ____temp_84 = __arrL({0}, 1)
        end
        for ____, ab in __TS__Iterator(____iter_85(____temp_84)) do
            __call(
                tiros,
                "push",
                {
                    x = P.x + dir * 28,
                    y = P.y - 32,
                    vx = dir * math.cos(mira + ab) * vel,
                    vy = math.sin(mira + ab) * vel,
                    vida = CFG.papelVida,
                    tipo = tipo,
                    elemento = elemento,
                    dano = dano
                }
            )
        end
        local ____opt_88 = VFX(nil)
        if ____opt_88 ~= nil then
            ____opt_88 = ____opt_88.emit
        end
        if ____opt_88 ~= nil then
            ____opt_88(____opt_88, "cast", {x = P.x + dir * 26, y = P.y - 32, dir = dir, element = elemento})
        end
        fx(
            nil,
            P.x + dir * 30,
            P.y - 32,
            elemento == "electric" and "#a7e6f1" or (__t(elemento) and "#f7b76c" or "#f8f3da"),
            4,
            35
        )
        beep(
            nil,
            __t(elemento) and 570 or 760,
            0.045
        )
    end
    local function peido(self, P)
        if cdPeido > 0 then
            return
        end
        local corrente = janela > 0
        local ____t_result_90
        if __t(corrente) then
            ____t_result_90 = math.min(3, combo + 1)
        else
            ____t_result_90 = 1
        end
        combo = ____t_result_90
        local custo = combo == 3 and 20 or (combo == 2 and 17 or 20)
        if gas < custo then
            aviso(nil, "Seu gás precisa recarregar. Espere no chão!")
            combo = 0
            cdPeido = 0.3
            return
        end
        gas = gas - custo
        cdPeido = combo == 3 and 1.5 or 0.24
        janela = combo < 3 and 0.85 or 0
        P.attack = 0.36
        P.attackType = "fart"
        P.attackDuration = 0.36
        shake = math.max(shake, combo == 3 and 9 or 4)
        beep(
            nil,
            80 - combo * 8,
            0.2,
            "sawtooth",
            0.045
        )
        local dir = __lt(P.facing, 0) and -1 or 1
        local raio = combo == 3 and 260 or (combo == 2 and 205 or 155)
        local mult = combo == 3 and 1.8 or (combo == 2 and 1.25 or 1)
        local ____opt_93 = VFX(nil)
        if ____opt_93 ~= nil then
            ____opt_93 = ____opt_93.emit
        end
        if ____opt_93 ~= nil then
            ____opt_93(____opt_93, "gas", {
                x = P.x + dir * 9,
                y = P.y - 23,
                dir = dir,
                stage = combo,
                radius = raio
            })
        end
        fx(
            nil,
            P.x + dir * 38,
            P.y - 22,
            combo == 3 and "#e0ef82" or "#b9df55",
            combo == 3 and 52 or 25,
            raio * 0.75
        )
        for ____, b in __iterar((bonecos)) do
            local ____t_103 = __t
            local ____t_result_102
            local ____t_100 = __t
            local ____t_result_99
            local ____t_96 = __t
            local ____temp_95 = __gt(b.hp, 0) and not __t(b.intocavel)
            __O[511] = ____temp_95
            if ____t_96(____temp_95) then
                local ____math_abs_result_98 = math.abs(b.x - P.x)
                local ____t_result_97
                if __t(b.largura) then
                    ____t_result_97 = b.largura
                else
                    ____t_result_97 = 22
                end
                ____t_result_99 = ____math_abs_result_98 < raio + (____t_result_97 - 22)
            else
                ____t_result_99 = __O[511]
            end
            __O[512] = ____t_result_99
            if ____t_100(____t_result_99) then
                local ____t_result_101
                if __t(b.y) then
                    ____t_result_101 = b.y
                else
                    ____t_result_101 = FLOOR
                end
                ____t_result_102 = math.abs(____t_result_101 - P.y) < 180
            else
                ____t_result_102 = __O[512]
            end
            if ____t_103(____t_result_102) then
                bater(
                    nil,
                    b,
                    (__t(C1.trained) and 55 or 34) * mult,
                    "peido",
                    0
                )
            end
        end
    end
    local function acao(self, id, down, P)
        heroRef = P
        local dir = __lt(P.facing, 0) and -1 or 1
        if __t(id == "poder1" or id == "poder2") then
            local r = PW:usar(
                id == "poder1" and 0 or 1,
                mundo(nil),
                __t(down) and "down" or "up"
            )
            local ____t_107 = __t
            local ____t_result_106
            local ____t_105 = __t
            local ____t_result_104
            if __t(down) then
                ____t_result_104 = not __t(r.ok)
            else
                ____t_result_104 = down
            end
            __O[513] = ____t_result_104
            if ____t_105(____t_result_104) then
                ____t_result_106 = r.motivo == "vazio"
            else
                ____t_result_106 = __O[513]
            end
            if ____t_107(____t_result_106) then
                aviso(nil, "Equipe um poder no Mural dos Poderes (quarto da pensão).")
            end
            local ____t_111 = __t
            local ____t_result_110
            local ____t_109 = __t
            local ____t_result_108
            if __t(down) then
                ____t_result_108 = not __t(r.ok)
            else
                ____t_result_108 = down
            end
            __O[514] = ____t_result_108
            if ____t_109(____t_result_108) then
                ____t_result_110 = r.motivo == "recarga"
            else
                ____t_result_110 = __O[514]
            end
            if ____t_111(____t_result_110) then
                aviso(
                    nil,
                    ("Recarregando: " .. tostring(__call(
                        __call(r.falta, "toFixed", 1),
                        "replace",
                        ".",
                        ","
                    ))) .. " s"
                )
            end
            return true
        end
        if __t(id == "paper" or id == "fart") then
            __set(
                segura,
                id,
                not not __t(down)
            )
            if __t(down) then
                local ____temp_112
                if id == "paper" then
                    ____temp_112 = papel
                else
                    ____temp_112 = peido
                end
                ____temp_112(nil, P)
            end
            return true
        end
        if not __t(down) then
            return id ~= "jump" and id ~= "interact"
        end
        if id == "dash" then
            if dashCd <= 0 then
                dashDir = __lt(P.facing, 0) and -1 or 1
                dashT = CFG.dashT
                dashCd = bn.dashCooldown
                P.vx = dashDir * CFG.dash
                local ____P_114 = P
                local ____t_result_113
                if __t(P.inv) then
                    ____t_result_113 = P.inv
                else
                    ____t_result_113 = 0
                end
                ____P_114.inv = math.max(____t_result_113, 0.18)
                local ____opt_117 = VFX(nil)
                if ____opt_117 ~= nil then
                    ____opt_117 = ____opt_117.emit
                end
                if ____opt_117 ~= nil then
                    ____opt_117(____opt_117, "dash", {x = P.x, y = P.y - 3, dir = dashDir})
                end
                fx(
                    nil,
                    P.x,
                    P.y - 22,
                    "#c0dfb8",
                    18,
                    130
                )
                beep(nil, 310, 0.08, "sawtooth")
            end
            return true
        end
        if id == "jump" then
            return false
        end
        return false
    end
    VFX = function() return window.CampaignVfx end
    local function musculoso()
        do
            local function ____catch(e)
                return true, false
            end
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                local ____t_130 = __t
                local ____opt_125 = window.Game
                if ____opt_125 ~= nil then
                    ____opt_125 = ____opt_125.getState
                end
                local ____opt_result_127
                if ____opt_125 ~= nil then
                    ____opt_result_127 = ____opt_125(____opt_125)
                end
                local ____opt_result_128
                if ____opt_result_127 ~= nil then
                    ____opt_result_128 = ____opt_result_127.q
                end
                local ____opt_result_129
                if ____opt_result_128 ~= nil then
                    ____opt_result_129 = ____opt_result_128.trained
                end
                return true, not not ____t_130(____opt_result_129)
            end)
            if not ____try then
                ____hasReturned, ____returnValue = ____catch(____hasReturned)
            end
            if ____hasReturned then
                return ____returnValue
            end
        end
    end
    local voandoAgora = false
    local avisoTxt = ""
    local avisoT = 0
    local avisoUlt = ""
    local avisoQuando = 0
    aviso = function(____, s)
        local agora = window.performance:now()
        if __t(s == avisoUlt and agora - avisoQuando < 3000) then
            return
        end
        avisoUlt = s
        avisoQuando = agora
        local ____t_134 = __t
        local ____t_result_133
        if __t(modoJogo) then
            local ____opt_131 = window.Campanha2
            if ____opt_131 ~= nil then
                ____opt_131 = ____opt_131.aviso
            end
            ____t_result_133 = ____opt_131
        else
            ____t_result_133 = modoJogo
        end
        if ____t_134(____t_result_133) then
            do
                local ____try, ____hasReturned, ____returnValue = pcall(function()
                    window.Campanha2:aviso(s)
                    return true
                end)
                if ____try and ____hasReturned then
                    return ____returnValue
                end
            end
        end
        avisoTxt = s
        avisoT = 2.4
    end
    local function passo(self, dt, P, o)
        if not __t(on) then
            return
        end
        heroRef = P
        cam = o.cam
        atualizarBonus(nil)
        PW:atualizar(
            dt,
            mundo(nil)
        )
        cdPapel = math.max(0, cdPapel - dt)
        cdPeido = math.max(0, cdPeido - dt)
        janela = math.max(0, janela - dt)
        if __gt(P.attack, 0) then
            P.attack = math.max(0, P.attack - dt)
        end
        dashCd = math.max(0, dashCd - dt)
        shake = math.max(0, shake - dt * 28)
        avisoT = math.max(0, avisoT - dt)
        municao = municao + dt
        if municao > 1.1 then
            municao = 0
            papeis = math.min(CFG.papelMax, papeis + 1)
        end
        if __t(segura.paper) then
            papel(nil, P)
        end
        if __t(segura.fart) then
            peido(nil, P)
        end
        if dashT > 0 then
            dashT = dashT - dt
            P.vx = dashDir * CFG.dash
            __call(rastro, "push", {x = P.x, y = P.y, facing = P.facing, life = 0.2})
        end
        local ____t_result_137
        local ____t_136 = __t
        local ____temp_135 = not __t(P.ground) and gas > 0
        __O[515] = ____temp_135
        if ____t_136(____temp_135) then
            ____t_result_137 = not not __t(o.segurandoPulo)
        else
            ____t_result_137 = __O[515]
        end
        voandoAgora = ____t_result_137
        if __t(voandoAgora) then
            if __gt(
                P.vy,
                __TS__Number(-CFG.voo)
            ) then
                P.vy = math.max(
                    __TS__Number(-CFG.voo),
                    P.vy - CFG.empuxo * dt
                )
            end
            gas = math.max(0, gas - CFG.gasVoo * dt)
            if math.random() < 0.35 then
                fx(
                    nil,
                    P.x,
                    P.y + 3,
                    "#bed970",
                    1,
                    50
                )
            end
        elseif not __t(o.segurandoPulo) then
            local ____bn_maxGas_141 = bn.maxGas
            local ____gas_140 = gas
            local ____dt_139 = dt
            local ____t_result_138
            if __t(P.ground) then
                ____t_result_138 = bn.gasRegen
            else
                ____t_result_138 = bn.airGasRegen
            end
            gas = math.min(____bn_maxGas_141, ____gas_140 + ____dt_139 * ____t_result_138)
        end
        local ____opt_144 = VFX(nil)
        if ____opt_144 ~= nil then
            ____opt_144 = ____opt_144.update
        end
        if ____opt_144 ~= nil then
            ____opt_144(____opt_144, dt)
        end
        for ____, a in __iterar((rastro)) do
            a.life = a.life - dt
        end
        rastro = __call(
            rastro,
            "filter",
            function(____, a) return __gt(a.life, 0) end
        )
        for ____, q in __iterar((parts)) do
            q.x = q.x + q.vx * dt
            q.y = q.y + q.vy * dt
            q.vy = q.vy + 180 * dt
            q.life = q.life - dt
        end
        parts = __call(
            parts,
            "filter",
            function(____, q) return __gt(q.life, 0) end
        )
        if not __t(modoJogo) then
            for ____, b in __iterar((bonecos)) do
                do
                    if __gt(b.morto, 0) then
                        b.morto = b.morto - dt
                        if __le(b.morto, 0) then
                            __assign(
                                b,
                                novoBoneco(nil, b.base)
                            )
                        end
                        continue
                    end
                    b.hit = math.max(0, b.hit - dt)
                    b.stun = math.max(0, b.stun - dt)
                    b.conf = math.max(0, b.conf - dt)
                    b.golpe = math.max(0, b.golpe - dt)
                    b.x = b.x + b.vx * dt
                    b.vx = b.vx * 0.02 ^ dt
                    b.vy = b.vy + 1400 * dt
                    b.y = math.min(FLOOR, b.y + b.vy * dt)
                    if __ge(b.y, FLOOR) then
                        b.vy = 0
                    end
                    if __t(__gt(b.conf, 0) and __le(b.stun, 0)) then
                        local alvo = __get(
                            __call(
                                __call(
                                    bonecos,
                                    "filter",
                                    function(____, q) return q ~= b and __gt(q.hp, 0) end
                                ),
                                "sort",
                                function(____, p, q) return math.abs(p.x - b.x) - math.abs(q.x - b.x) end
                            ),
                            0
                        )
                        if __t(alvo) then
                            local d = alvo.x - b.x
                            if math.abs(d) > 40 then
                                b.x = b.x + __TS__MathSign(d) * 120 * dt
                            elseif __le(b.golpe, 0) then
                                b.golpe = 0.7
                                mundo(nil):dano(
                                    alvo,
                                    4,
                                    "confuso",
                                    __TS__MathSign(d)
                                )
                                alvo.vx = __TS__MathSign(d) * 160
                                __call(textos, "push", {
                                    x = b.x,
                                    y = b.y - 110,
                                    n = "TOMA!",
                                    t = 0,
                                    cor = "#e48fb0"
                                })
                            end
                        end
                    elseif __le(b.stun, 0) then
                        b.x = b.x + (b.base - b.x) * math.min(1, dt * 0.8)
                    end
                end
            end
        end
        tiros = __call(
            tiros,
            "filter",
            function(____, q)
                q.vida = q.vida - dt
                q.x = q.x + q.vx * dt
                q.y = q.y + q.vy * dt
                for ____, b in __iterar((bonecos)) do
                    local ____t_160 = __t
                    local ____t_result_159
                    local ____t_158 = __t
                    local ____t_result_157
                    local ____t_152 = __t
                    local ____t_result_151
                    local ____t_147 = __t
                    local ____temp_146 = __gt(b.hp, 0) and not __t(b.intocavel)
                    __O[516] = ____temp_146
                    if ____t_147(____temp_146) then
                        local ____lt_150 = __lt
                        local ____math_abs_result_149 = math.abs(b.x - q.x)
                        local ____t_result_148
                        if __t(b.largura) then
                            ____t_result_148 = b.largura
                        else
                            ____t_result_148 = 22
                        end
                        ____t_result_151 = ____lt_150(____math_abs_result_149, ____t_result_148)
                    else
                        ____t_result_151 = __O[516]
                    end
                    __O[517] = ____t_result_151
                    if ____t_152(____t_result_151) then
                        local ____gt_156 = __gt
                        local ____q_y_155 = q.y
                        local ____b_y_154 = b.y
                        local ____t_result_153
                        if __t(b.alto) then
                            ____t_result_153 = b.alto
                        else
                            ____t_result_153 = 80
                        end
                        ____t_result_157 = ____gt_156(____q_y_155, ____b_y_154 - ____t_result_153)
                    else
                        ____t_result_157 = __O[517]
                    end
                    __O[518] = ____t_result_157
                    if ____t_158(____t_result_157) then
                        ____t_result_159 = __lt(q.y, b.y + 4)
                    else
                        ____t_result_159 = __O[518]
                    end
                    if ____t_160(____t_result_159) then
                        local ____bater_162 = bater
                        local ____t_result_161
                        if __t(q.dano) then
                            ____t_result_161 = q.dano
                        else
                            ____t_result_161 = 6
                        end
                        ____bater_162(
                            nil,
                            b,
                            ____t_result_161,
                            "papel",
                            __TS__MathSign(q.vx)
                        )
                        b.vx = __TS__MathSign(q.vx) * 90
                        return false
                    end
                end
                return __gt(q.vida, 0)
            end
        )
        nuvens = __arrL({}, 0)
        textos = __call(
            textos,
            "filter",
            function(____, x)
                x.t = __add(x.t, dt)
                return __lt(x.t, 0.9)
            end
        )
    end
    local function piscando(____, e)
        local ____gt_164 = __gt
        local ____t_result_163
        if __t(e.piscaAte) then
            ____t_result_163 = e.piscaAte
        else
            ____t_result_163 = 0
        end
        return ____gt_164(
            ____t_result_163,
            window.performance:now()
        ) and __mod(
            math.floor(window.performance:now() / 55),
            2
        ) == 0
    end
    local function espantalho(self, c, b, t)
        local function R(____, x, y, w, h, col)
            c.fillStyle = col
            c:fillRect(
                math.floor(x + 0.5),
                math.floor(y + 0.5),
                w,
                h
            )
        end
        local caido = __le(b.hp, 0)
        local ____gt_result_165
        if __gt(b.hit, 0) then
            ____gt_result_165 = math.floor(math.sin(t * 60) * 2 + 0.5)
        else
            ____gt_result_165 = 0
        end
        local sh = ____gt_result_165
        local x = b.x + sh
        local y = b.y
        c:save()
        local ____t_169 = __t
        local ____t_result_168
        local ____t_167 = __t
        local ____temp_166 = not __t(caido)
        __O[519] = ____temp_166
        if ____t_167(____temp_166) then
            ____t_result_168 = piscando(nil, b)
        else
            ____t_result_168 = __O[519]
        end
        if ____t_169(____t_result_168) then
            c.globalAlpha = 0.25
        end
        if __t(caido) then
            c:translate(x, y)
            c:rotate(-1.4 * math.min(1, (2.2 - b.morto) * 4))
            c:translate(
                __TS__Number(-x),
                __TS__Number(-y)
            )
        end
        R(
            nil,
            x - 2,
            y - 70,
            4,
            70,
            "#6a4a2a"
        )
        R(
            nil,
            x - 22,
            y - 62,
            44,
            4,
            "#6a4a2a"
        )
        R(
            nil,
            x - 14,
            y - 64,
            28,
            30,
            __gt(b.hit, 0) and "#ffffff" or "#c43c3a"
        )
        R(
            nil,
            x - 14,
            y - 64,
            28,
            3,
            "#e85a4a"
        )
        R(
            nil,
            x - 3,
            y - 64,
            6,
            30,
            "#2c4a7a"
        )
        do
            local k = 0
            while k < 4 do
                R(
                    nil,
                    x - 24 + k * 2,
                    y - 61 + k,
                    2,
                    4,
                    "#e8c24c"
                )
                R(
                    nil,
                    x + 20 + k * 1,
                    y - 61 + k,
                    2,
                    4,
                    "#e8c24c"
                )
                R(
                    nil,
                    x - 10 + k * 6,
                    y - 34,
                    2,
                    6,
                    "#e8c24c"
                )
                k = k + 1
            end
        end
        R(
            nil,
            x - 10,
            y - 84,
            20,
            20,
            "#e9d6a8"
        )
        R(
            nil,
            x - 6,
            y - 78,
            3,
            3,
            "#2a2a2a"
        )
        R(
            nil,
            x + 3,
            y - 78,
            3,
            3,
            "#2a2a2a"
        )
        R(
            nil,
            x - 5,
            y - 71,
            10,
            2,
            "#8a3a2a"
        )
        if __gt(b.conf, 0) then
            R(
                nil,
                x - 5,
                y - 72,
                10,
                2,
                "#c43c6a"
            )
        end
        R(
            nil,
            x - 16,
            y - 88,
            32,
            4,
            "#d7b665"
        )
        R(
            nil,
            x - 9,
            y - 96,
            18,
            8,
            "#d7b665"
        )
        R(
            nil,
            x - 9,
            y - 90,
            18,
            2,
            "#c43c3a"
        )
        c:restore()
        if not __t(caido) then
            R(
                nil,
                x - 20,
                y - 106,
                40,
                5,
                "#1c1408"
            )
            R(
                nil,
                x - 19,
                y - 105,
                38 * b.hp / b.max,
                3,
                b.hp / b.max > 0.4 and "#7ac85a" or "#e8433a"
            )
        end
    end
    local function desenhar(self, c, t)
        if not __t(on) then
            return
        end
        local P = heroRef
        if not __t(modoJogo) then
            for ____, b in __iterar((bonecos)) do
                espantalho(nil, c, b, t)
            end
        end
        for ____, q in __iterar((parts)) do
            c.globalAlpha = math.max(
                0,
                math.min(1, q.life * 2)
            )
            c.fillStyle = q.color
            c:fillRect(
                math.floor(q.x + 0.5),
                math.floor(q.y + 0.5),
                q.size,
                q.size
            )
        end
        c.globalAlpha = 1
        for ____, q in __iterar((tiros)) do
            do
                local ____t_178 = __t
                local ____opt_175 = VFX(nil)
                if ____opt_175 ~= nil then
                    ____opt_175 = ____opt_175.drawProjectile
                end
                local ____opt_result_177
                if ____opt_175 ~= nil then
                    local ____c_173 = c
                    local ____t_result_171
                    if __t(q.tipo) then
                        ____t_result_171 = q.tipo
                    else
                        ____t_result_171 = "paper"
                    end
                    local ____t_result_172
                    if __t(q.elemento) then
                        ____t_result_172 = q.elemento
                    else
                        ____t_result_172 = nil
                    end
                    ____opt_result_177 = ____opt_175(____opt_175, ____c_173, {
                        type = ____t_result_171,
                        element = ____t_result_172,
                        x = q.x,
                        y = q.y,
                        vx = q.vx,
                        vy = q.vy,
                        owner = "player"
                    }, t)
                end
                if ____t_178(____opt_result_177) then
                    continue
                end
                c.fillStyle = "#f6f4ee"
                c:fillRect(
                    math.floor(q.x - 5 + 0.5),
                    math.floor(q.y - 5 + 0.5),
                    10,
                    10
                )
            end
        end
        local ____opt_181 = VFX(nil)
        if ____opt_181 ~= nil then
            ____opt_181 = ____opt_181.draw
        end
        if ____opt_181 ~= nil then
            ____opt_181(____opt_181, c, t, "front")
        end
        PW:desenhar(
            c,
            mundo(nil)
        )
        c.font = "14px Pixel, monospace"
        c.textAlign = "center"
        for ____, x in __iterar((textos)) do
            c.globalAlpha = 1 - x.t / 0.9
            c.fillStyle = "#2a1a14"
            c:fillText(
                tostring(x.n),
                x.x + 2,
                x.y - x.t * 40 + 2
            )
            c.fillStyle = x.cor
            c:fillText(
                tostring(x.n),
                x.x,
                x.y - x.t * 40
            )
        end
        c.globalAlpha = 1
        if avisoT > 0 then
            c.font = "12px Pixel, monospace"
            local w = c:measureText(avisoTxt).width + 20
            c.fillStyle = "rgba(28,20,12,.85)"
            c:fillRect(P.x - w / 2, P.y - 150, w, 22)
            c.fillStyle = "#f3d89e"
            c:fillText(avisoTxt, P.x, P.y - 135)
        end
        if __t(barra) then
            barra:querySelector(".c2-treino-gas i").style.width = tostring(gas) .. "%"
            local m = PW:multiplicadores()
            local eq = PW:estado().equipados
            local ____temp_194 = barra:querySelector(".c2-treino-info")
            local ____opt_185 = window.CampanhaLoja
            if ____opt_185 ~= nil then
                ____opt_185 = ____opt_185.moedas
            end
            local ____opt_result_187
            if ____opt_185 ~= nil then
                ____opt_result_187 = ____opt_185(____opt_185)
            end
            local ____opt_result_187_188 = ____opt_result_187
            if ____opt_result_187_188 == nil then
                ____opt_result_187_188 = 0
            end
            local ____t_result_193
            if __t(__len(__call(eq, "filter", window.Boolean))) then
                ____t_result_193 = __add(
                    "Equipados: ",
                    __call(
                        __call(
                            eq,
                            "map",
                            function(____, id)
                                local ____t_result_192
                                local ____t_191 = __t
                                local ____opt_189 = __call(
                                    PW:lista(),
                                    "find",
                                    function(____, p) return p.id == id end
                                )
                                if ____opt_189 ~= nil then
                                    ____opt_189 = ____opt_189.curto
                                end
                                __O[520] = ____opt_189
                                if ____t_191(____opt_189) then
                                    ____t_result_192 = __O[520]
                                else
                                    ____t_result_192 = "—"
                                end
                                return ____t_result_192
                            end
                        ),
                        "join",
                        " + "
                    )
                )
            else
                ____t_result_193 = "Sem poder equipado: abra o MURAL"
            end
            ____temp_194.innerHTML = (((("TREINO DE PODERES · ● " .. tostring(____opt_result_187_188)) .. " MOEDAS<br>J PAPEL · K PEIDO · L DASH · ␣ VOAR · U/I PODERES<br>") .. tostring(____t_result_193)) .. (__gt(m.vel, 1) and "<br>☕ CAFEZÃO ATIVO" or "")) .. (__t(PW:escudo()) and "<br>♥ AURA ATIVA" or "")
            __call(
                __arrL({0, 1}, 2),
                "forEach",
                function(____, i)
                    local id = __get(eq, i)
                    local b = barra:querySelector(("[data-acao=\"poder" .. tostring(i + 1)) .. "\"] .c2-cd")
                    if __t(not __t(b) or not __t(id)) then
                        return
                    end
                    local max = PW:recargaTotal(id)
                    local f = math.min(
                        1,
                        PW:recarga(id) / max
                    )
                    b.style:setProperty(
                        "--cd",
                        tostring(math.floor((1 - f) * 100 + 0.5)) .. "%"
                    )
                end
            )
        end
    end
    window.CampanhaTreino = __ord(
        {
            dashFalta = function() return dashCd end,
            voandoAgora = function() return voandoAgora end,
            som = function(____, f, d, ty, v) return beep(
                nil,
                f,
                d,
                ty,
                v
            ) end,
            bonus = function() return __assign({}, bn) end,
            gasMax = function() return bn.maxGas end,
            encher = function()
                gas = bn.maxGas
                papeis = CFG.papelMax
            end,
            dadosC1 = function(____, d)
                if __t(d) then
                    C1 = __assign({}, C1, d)
                end
                return __assign({}, C1)
            end,
            desenharAtras = function(____, c, t)
                if not __t(on) then
                    return
                end
                local ____opt_197 = VFX(nil)
                if ____opt_197 ~= nil then
                    ____opt_197 = ____opt_197.draw
                end
                if ____opt_197 ~= nil then
                    ____opt_197(____opt_197, c, t, "back")
                end
                for ____, a in __iterar((rastro)) do
                    c:save()
                    c.globalAlpha = math.min(1, a.life * 2)
                    do
                        pcall(function()
                            local ____opt_201 = window.Art
                            if ____opt_201 ~= nil then
                                ____opt_201 = ____opt_201.drawCharacter
                            end
                            if ____opt_201 ~= nil then
                                ____opt_201(
                                    ____opt_201,
                                    c,
                                    "daroca",
                                    a.x,
                                    a.y,
                                    {
                                        facing = a.facing,
                                        frame = t,
                                        dash = true,
                                        moving = true,
                                        muscular = musculoso(nil),
                                        grounded = true
                                    }
                                )
                            end
                        end)
                    end
                    c:restore()
                end
            end,
            papeis = function() return papeis end,
            musculoso = function() return musculoso(nil) end,
            piscando = piscando,
            ligar = ligar,
            ligado = function() return on end,
            gas = function() return gas end,
            inimigos = function(____, lista)
                if __isArray(lista) then
                    bonecos = lista
                end
                return bonecos
            end,
            dashing = function()
                local ____t_result_203
                if __t(on) then
                    ____t_result_203 = dashT > 0
                else
                    ____t_result_203 = on
                end
                return ____t_result_203
            end,
            acao = acao,
            passo = passo,
            desenhar = desenhar,
            montarBarra = montarBarra,
            tremor = function() return shake end,
            velocidade = function()
                local ____t_result_204
                if __t(on) then
                    ____t_result_204 = PW:multiplicadores().vel
                else
                    ____t_result_204 = 1
                end
                return ____t_result_204
            end
        },
        "dashFalta,voandoAgora,som,bonus,gasMax,encher,dadosC1,desenharAtras,papeis,musculoso,piscando,ligar,ligado,gas,inimigos,dashing,acao,passo,desenhar,montarBarra,tremor,velocidade"
    )
end)(nil)
return ____exports
