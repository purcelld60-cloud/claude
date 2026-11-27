--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __le, __gt, __ge, __mod, __ord, __arrL, __iterar, __t, __get, __set, __len = __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__len
local __call, __add, __assign, __isArray, __re, __re_test, __re_replace = __JSR.__call, __JSR.__add, __JSR.__assign, __JSR.__isArray, __JSR.__re, __JSR.__re_test, __JSR.__re_replace
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__New = ____lualib.__TS__New
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
                b.innerHTML = ((((("<kbd>" .. if __t(i) then "I" else "U") .. "</kbd>") .. tostring(if __t(p) then PW:iconeSVG(id) else "<svg class=\"control-icon\" viewBox=\"0 0 24 24\" width=\"24\" height=\"24\"><path fill=\"currentColor\" d=\"M4 4h16v2H4zM4 18h16v2H4zM4 6h2v12H4zM18 6h2v12h-2z\"/></svg>")) .. "<small>") .. tostring(if __t(p) then p.curto else "VAZIO")) .. "</small><span class=\"c2-cd\"></span>"
            end
        )
    end
    local ____ = "use strict"
    if __t(if __t(window.CampanhaTreino) then window.CampanhaTreino else not __t(window.CampanhaPoderes)) then
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
            for ____, r in __iterar((if __t(rules) then rules else __arrL({}, 0))) do
                local ____t_2 = __t
                local ____t_1 = __t
                local ____temp_0 = if __t(r.selectorText) then __re_test(
                    __re("crafted-controls", ""),
                    r.selectorText
                ) else r.selectorText
                __O[479] = ____temp_0
                if ____t_2(if ____t_1(____temp_0) then __re_test(
                    __re("touch-btn|control-icon|kbd|-btn\\b", ""),
                    r.selectorText
                ) else __O[479]) then
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
                b.className = if __t(orig) then __re_replace(
                    orig.className,
                    __re("\\b(pressed|campaign-layout-target)\\b", "g"),
                    ""
                ) else "touch-btn"
                local ____add_9 = __add
                local ____t_8 = __t
                local ____opt_3 = orig and orig:querySelector("svg")
                local ____temp_7 = ____opt_3 and ____opt_3.outerHTML
                __O[480] = ____temp_7
                b.innerHTML = ____add_9(
                    if ____t_8(____temp_7) then __O[480] else "",
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
        local ____v_10 = v
        if ____v_10 == nil then
            ____v_10 = not __t(on)
        end
        on = ____v_10
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
            bonecos = if __t(modoJogo) then __arrL({}, 0) else __arrL(
                {
                    novoBoneco(nil, P.x + 170),
                    novoBoneco(nil, P.x + 250),
                    novoBoneco(nil, P.x + 330)
                },
                3
            )
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
                local ____t_13 = __t
                local ____t_12 = __t
                local ____temp_11 = if __t(modoJogo) then tipo ~= "papel" else modoJogo
                __O[481] = ____temp_11
                if ____t_13(if ____t_12(____temp_11) then tipo ~= "peido" else __O[481]) then
                    n = math.floor(n * 5 + 0.5)
                end
                e.piscaAte = window.performance:now() + 400
                if __t(e.onDano) then
                    local r = e:onDano(n, tipo, dir)
                    if r ~= false then
                        __call(
                            textos,
                            "push",
                            {
                                x = e.x + (math.random() - 0.5) * 20,
                                y = e.y - if __t(e.alto) then e.alto else 90,
                                n = if __t(r) then r else n,
                                t = 0,
                                cor = if tipo == "soco" then "#ffd24a" else if tipo == "confuso" then "#e48fb0" else "#fff6dc"
                            }
                        )
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
                        cor = if tipo == "soco" then "#ffd24a" else if tipo == "confuso" then "#e48fb0" else "#fff6dc"
                    }
                )
                if __le(e.hp, 0) then
                    e.morto = 2.2
                    local ____opt_16 = window.CampanhaLoja
                    if ____opt_16 ~= nil then
                        ____opt_16 = ____opt_16.ganhar
                    end
                    if ____opt_16 ~= nil then
                        ____opt_16(____opt_16, 8)
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
        local ____self_26 = mundo(nil)
        local ____self_26_dano_27 = ____self_26.dano
        local ____e_25 = e
        local ____temp_24 = n * if __t(bn.damageMultiplier) then bn.damageMultiplier else 1 * PW:multiplicadores().forca
        local ____t_23 = __t
        local ____opt_20 = window.CampanhaAliados
        if ____opt_20 ~= nil then
            ____opt_20 = ____opt_20.forca
        end
        local ____opt_result_22
        if ____opt_20 ~= nil then
            ____opt_result_22 = ____opt_20(____opt_20)
        end
        __O[482] = ____opt_result_22
        ____self_26_dano_27(
            ____self_26,
            ____e_25,
            math.max(
                1,
                math.floor(____temp_24 * if ____t_23(____opt_result_22) then __O[482] else 1 + 0.5)
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
                local ____assign_35 = __assign
                local ____temp_34 = {}
                local ____t_33 = __t
                local ____opt_30 = window.Progression
                if ____opt_30 ~= nil then
                    ____opt_30 = ____opt_30.bonuses
                end
                local ____opt_result_32
                if ____opt_30 ~= nil then
                    ____opt_result_32 = ____opt_30(____opt_30)
                end
                __O[483] = ____opt_result_32
                bn = ____assign_35(____temp_34, BONUS0, if ____t_33(____opt_result_32) then __O[483] else {})
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
                local ____t_39 = __t
                local ____t_38 = __t
                local ____opt_36 = window.Game
                if ____opt_36 ~= nil then
                    ____opt_36 = ____opt_36.soundOn
                end
                __O[484] = ____opt_36
                if ____t_39(if ____t_38(____opt_36) then not __t(window.Game:soundOn()) else __O[484]) then
                    return true
                end
                local ____opt_42 = window.DarocaAudio
                if ____opt_42 ~= nil then
                    ____opt_42 = ____opt_42.sfx
                end
                local ____opt_result_44
                if ____opt_42 ~= nil then
                    ____opt_result_44 = ____opt_42(____opt_42)
                end
                local ____opt_result_44_45 = ____opt_result_44
                if ____opt_result_44_45 == nil then
                    ____opt_result_44_45 = 1
                end
                vol = vol * ____opt_result_44_45
                if vol <= 0.0005 then
                    return true
                end
                ctxSom = if __t(ctxSom) then ctxSom else __TS__New(if __t(window.AudioContext) then window.AudioContext else window.webkitAudioContext)
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
        local w = if __t(C1.weapon) then C1.weapon else 0
        local tier = if __t(C1.miqueias) then bn.projectileTier else 0
        local elemento = if tier >= 2 then "electric" else if tier == 1 then "fire" else nil
        local tipo = if __t(elemento) then "papaia" else if w == 2 then "case" else if w == 1 then "ruler" else "paper"
        local vel = if __t(w) then 680 else CFG.papel
        local dano = if __t(C1.trained) then 28 else 18 + if w == 1 then 14 else if w == 2 then 22 else 0
        cdPapel = if w == 2 then 0.31 else CFG.papelCd
        papeis = papeis - 1
        shake = math.max(shake, 1.2)
        P.attack = 0.24
        P.attackType = "paper"
        P.attackDuration = 0.24
        local dir = if __lt(P.facing, 0) then -1 else 1
        local alvo = __get(
            __call(
                __call(
                    bonecos,
                    "filter",
                    function(____, b)
                        local ____t_49 = __t
                        local ____t_47 = __t
                        local ____temp_46 = __gt(b.hp, 0) and not __t(b.intocavel)
                        __O[485] = ____temp_46
                        local ____temp_48 = if ____t_47(____temp_46) then __TS__MathSign(b.x - P.x) == dir else __O[485]
                        __O[486] = ____temp_48
                        return if ____t_49(____temp_48) then math.abs(b.x - P.x) < 650 else __O[486]
                    end
                ),
                "sort",
                function(____, a, b) return math.abs(a.x - P.x) - math.abs(b.x - P.x) end
            ),
            0
        )
        local mira = if __t(alvo) then math.max(
            -0.85,
            math.min(
                0.85,
                math.atan2(
                    alvo.y - if __t(alvo.alto) then alvo.alto else 80 / 2 - (P.y - 32),
                    math.abs(alvo.x - P.x)
                )
            )
        ) else 0
        for ____, ab in __iterar((if w == 2 then __arrL({-0.11, 0, 0.11}, 3) else __arrL({0}, 1))) do
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
        local ____opt_52 = VFX(nil)
        if ____opt_52 ~= nil then
            ____opt_52 = ____opt_52.emit
        end
        if ____opt_52 ~= nil then
            ____opt_52(____opt_52, "cast", {x = P.x + dir * 26, y = P.y - 32, dir = dir, element = elemento})
        end
        fx(
            nil,
            P.x + dir * 30,
            P.y - 32,
            if elemento == "electric" then "#a7e6f1" else if __t(elemento) then "#f7b76c" else "#f8f3da",
            4,
            35
        )
        beep(nil, if __t(elemento) then 570 else 760, 0.045)
    end
    local function peido(self, P)
        if cdPeido > 0 then
            return
        end
        local corrente = janela > 0
        combo = if __t(corrente) then math.min(3, combo + 1) else 1
        local custo = if combo == 3 then 20 else if combo == 2 then 17 else 20
        if gas < custo then
            aviso(nil, "Seu gás precisa recarregar. Espere no chão!")
            combo = 0
            cdPeido = 0.3
            return
        end
        gas = gas - custo
        cdPeido = if combo == 3 then 1.5 else 0.24
        janela = if combo < 3 then 0.85 else 0
        P.attack = 0.36
        P.attackType = "fart"
        P.attackDuration = 0.36
        shake = math.max(shake, if combo == 3 then 9 else 4)
        beep(
            nil,
            80 - combo * 8,
            0.2,
            "sawtooth",
            0.045
        )
        local dir = if __lt(P.facing, 0) then -1 else 1
        local raio = if combo == 3 then 260 else if combo == 2 then 205 else 155
        local mult = if combo == 3 then 1.8 else if combo == 2 then 1.25 else 1
        local ____opt_56 = VFX(nil)
        if ____opt_56 ~= nil then
            ____opt_56 = ____opt_56.emit
        end
        if ____opt_56 ~= nil then
            ____opt_56(____opt_56, "gas", {
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
            if combo == 3 then "#e0ef82" else "#b9df55",
            if combo == 3 then 52 else 25,
            raio * 0.75
        )
        for ____, b in __iterar((bonecos)) do
            local ____t_62 = __t
            local ____t_61 = __t
            local ____t_59 = __t
            local ____temp_58 = __gt(b.hp, 0) and not __t(b.intocavel)
            __O[487] = ____temp_58
            local ____temp_60 = if ____t_59(____temp_58) then math.abs(b.x - P.x) < raio + (if __t(b.largura) then b.largura else 22 - 22) else __O[487]
            __O[488] = ____temp_60
            if ____t_62(if ____t_61(____temp_60) then math.abs(if __t(b.y) then b.y else FLOOR - P.y) < 180 else __O[488]) then
                bater(
                    nil,
                    b,
                    if __t(C1.trained) then 55 else 34 * mult,
                    "peido",
                    0
                )
            end
        end
    end
    local function acao(self, id, down, P)
        heroRef = P
        local dir = if __lt(P.facing, 0) then -1 else 1
        if __t(id == "poder1" or id == "poder2") then
            local r = PW:usar(
                if id == "poder1" then 0 else 1,
                mundo(nil),
                if __t(down) then "down" else "up"
            )
            local ____t_65 = __t
            local ____t_64 = __t
            local ____temp_63 = if __t(down) then not __t(r.ok) else down
            __O[489] = ____temp_63
            if ____t_65(if ____t_64(____temp_63) then r.motivo == "vazio" else __O[489]) then
                aviso(nil, "Equipe um poder no Mural dos Poderes (quarto da pensão).")
            end
            local ____t_68 = __t
            local ____t_67 = __t
            local ____temp_66 = if __t(down) then not __t(r.ok) else down
            __O[490] = ____temp_66
            if ____t_68(if ____t_67(____temp_66) then r.motivo == "recarga" else __O[490]) then
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
                if id == "paper" then papel else peido(nil, P)
            end
            return true
        end
        if not __t(down) then
            return id ~= "jump" and id ~= "interact"
        end
        if id == "dash" then
            if dashCd <= 0 then
                dashDir = if __lt(P.facing, 0) then -1 else 1
                dashT = CFG.dashT
                dashCd = bn.dashCooldown
                P.vx = dashDir * CFG.dash
                P.inv = math.max(if __t(P.inv) then P.inv else 0, 0.18)
                local ____opt_71 = VFX(nil)
                if ____opt_71 ~= nil then
                    ____opt_71 = ____opt_71.emit
                end
                if ____opt_71 ~= nil then
                    ____opt_71(____opt_71, "dash", {x = P.x, y = P.y - 3, dir = dashDir})
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
                local ____t_84 = __t
                local ____opt_79 = window.Game
                if ____opt_79 ~= nil then
                    ____opt_79 = ____opt_79.getState
                end
                local ____opt_result_81
                if ____opt_79 ~= nil then
                    ____opt_result_81 = ____opt_79(____opt_79)
                end
                local ____opt_result_82
                if ____opt_result_81 ~= nil then
                    ____opt_result_82 = ____opt_result_81.q
                end
                local ____opt_result_83
                if ____opt_result_82 ~= nil then
                    ____opt_result_83 = ____opt_result_82.trained
                end
                return true, not not ____t_84(____opt_result_83)
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
        local ____t_87 = __t
        local ____opt_85 = window.Campanha2
        if ____opt_85 ~= nil then
            ____opt_85 = ____opt_85.aviso
        end
        if ____t_87(if __t(modoJogo) then ____opt_85 else modoJogo) then
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
        local ____t_89 = __t
        local ____temp_88 = not __t(P.ground) and gas > 0
        __O[491] = ____temp_88
        voandoAgora = if ____t_89(____temp_88) then not not __t(o.segurandoPulo) else __O[491]
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
            gas = math.min(bn.maxGas, gas + dt * if __t(P.ground) then bn.gasRegen else bn.airGasRegen)
        end
        local ____opt_92 = VFX(nil)
        if ____opt_92 ~= nil then
            ____opt_92 = ____opt_92.update
        end
        if ____opt_92 ~= nil then
            ____opt_92(____opt_92, dt)
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
        tiros = __call(
            tiros,
            "filter",
            function(____, q)
                q.vida = q.vida - dt
                q.x = q.x + q.vx * dt
                q.y = q.y + q.vy * dt
                for ____, b in __iterar((bonecos)) do
                    local ____t_100 = __t
                    local ____t_99 = __t
                    local ____t_97 = __t
                    local ____t_95 = __t
                    local ____temp_94 = __gt(b.hp, 0) and not __t(b.intocavel)
                    __O[492] = ____temp_94
                    local ____temp_96 = if ____t_95(____temp_94) then __lt(
                        math.abs(b.x - q.x),
                        if __t(b.largura) then b.largura else 22
                    ) else __O[492]
                    __O[493] = ____temp_96
                    local ____temp_98 = if ____t_97(____temp_96) then __gt(q.y, b.y - if __t(b.alto) then b.alto else 80) else __O[493]
                    __O[494] = ____temp_98
                    if ____t_100(if ____t_99(____temp_98) then __lt(q.y, b.y + 4) else __O[494]) then
                        bater(
                            nil,
                            b,
                            if __t(q.dano) then q.dano else 6,
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
        return __gt(
            if __t(e.piscaAte) then e.piscaAte else 0,
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
        local sh = if __gt(b.hit, 0) then math.floor(math.sin(t * 60) * 2 + 0.5) else 0
        local x = b.x + sh
        local y = b.y
        c:save()
        local ____t_103 = __t
        local ____t_102 = __t
        local ____temp_101 = not __t(caido)
        __O[495] = ____temp_101
        if ____t_103(if ____t_102(____temp_101) then piscando(nil, b) else __O[495]) then
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
            if __gt(b.hit, 0) then "#ffffff" else "#c43c3a"
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
                if b.hp / b.max > 0.4 then "#7ac85a" else "#e8433a"
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
            local ____t_109 = __t
            local ____opt_106 = VFX(nil)
            if ____opt_106 ~= nil then
                ____opt_106 = ____opt_106.drawProjectile
            end
            local ____opt_result_108
            if ____opt_106 ~= nil then
                ____opt_result_108 = ____opt_106(____opt_106, c, {
                    type = if __t(q.tipo) then q.tipo else "paper",
                    element = if __t(q.elemento) then q.elemento else nil,
                    x = q.x,
                    y = q.y,
                    vx = q.vx,
                    vy = q.vy,
                    owner = "player"
                }, t)
            end
            if ____t_109(____opt_result_108) then
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
        local ____opt_112 = VFX(nil)
        if ____opt_112 ~= nil then
            ____opt_112 = ____opt_112.draw
        end
        if ____opt_112 ~= nil then
            ____opt_112(____opt_112, c, t, "front")
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
            local ____temp_123 = barra:querySelector(".c2-treino-info")
            local ____opt_116 = window.CampanhaLoja
            if ____opt_116 ~= nil then
                ____opt_116 = ____opt_116.moedas
            end
            local ____opt_result_118
            if ____opt_116 ~= nil then
                ____opt_result_118 = ____opt_116(____opt_116)
            end
            local ____opt_result_118_119 = ____opt_result_118
            if ____opt_result_118_119 == nil then
                ____opt_result_118_119 = 0
            end
            ____temp_123.innerHTML = (((("TREINO DE PODERES · ● " .. tostring(____opt_result_118_119)) .. " MOEDAS<br>J PAPEL · K PEIDO · L DASH · ␣ VOAR · U/I PODERES<br>") .. tostring(if __t(__len(__call(eq, "filter", window.Boolean))) then __add(
                "Equipados: ",
                __call(
                    __call(
                        eq,
                        "map",
                        function(____, id)
                            local ____t_122 = __t
                            local ____opt_120 = __call(
                                PW:lista(),
                                "find",
                                function(____, p) return p.id == id end
                            )
                            if ____opt_120 ~= nil then
                                ____opt_120 = ____opt_120.curto
                            end
                            __O[496] = ____opt_120
                            return if ____t_122(____opt_120) then __O[496] else "—"
                        end
                    ),
                    "join",
                    " + "
                )
            ) else "Sem poder equipado: abra o MURAL")) .. if __gt(m.vel, 1) then "<br>☕ CAFEZÃO ATIVO" else "") .. if __t(PW:escudo()) then "<br>♥ AURA ATIVA" else ""
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
                local ____opt_126 = VFX(nil)
                if ____opt_126 ~= nil then
                    ____opt_126 = ____opt_126.draw
                end
                if ____opt_126 ~= nil then
                    ____opt_126(____opt_126, c, t, "back")
                end
                for ____, a in __iterar((rastro)) do
                    c:save()
                    c.globalAlpha = math.min(1, a.life * 2)
                    do
                        pcall(function()
                            local ____opt_130 = window.Art
                            if ____opt_130 ~= nil then
                                ____opt_130 = ____opt_130.drawCharacter
                            end
                            if ____opt_130 ~= nil then
                                ____opt_130(
                                    ____opt_130,
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
            dashing = function() return if __t(on) then dashT > 0 else on end,
            acao = acao,
            passo = passo,
            desenhar = desenhar,
            montarBarra = montarBarra,
            tremor = function() return shake end,
            velocidade = function() return if __t(on) then PW:multiplicadores().vel else 1 end
        },
        "dashFalta,voandoAgora,som,bonus,gasMax,encher,dadosC1,desenharAtras,papeis,musculoso,piscando,ligar,ligado,gas,inimigos,dashing,acao,passo,desenhar,montarBarra,tremor,velocidade"
    )
end)(nil)
return ____exports
