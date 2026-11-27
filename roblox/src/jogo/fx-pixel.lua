--!native
--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __gt, __ge, __objCreate, __isFiniteN, __ord, __arrL, __iterar, __t, __get, __set, __del = __JSR.__lt, __JSR.__gt, __JSR.__ge, __JSR.__objCreate, __JSR.__isFiniteN, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__del
local __len, __call, __keys, __assign, __bor, __getters = __JSR.__len, __JSR.__call, __JSR.__keys, __JSR.__assign, __JSR.__bor, __JSR.__getters
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Promise = ____lualib.__TS__Promise
local __TS__New = ____lualib.__TS__New
local __TS__Number = ____lualib.__TS__Number
local __TS__Iterator = ____lualib.__TS__Iterator
local WeakMap = ____lualib.WeakMap
local ____exports = {}
local __O = {};
(function()
    local carregar, tocar, disparo, FW, FH, lib, carregando, frame, img, tela, tctx, ativos, ultimo, PAL, limite, DISPARO
    function carregar(self)
        if __t(lib) then
            return __TS__Promise.resolve(lib)
        end
        if __t(carregando) then
            return carregando
        end
        carregando = __TS__New(
            __TS__Promise,
            function(____, ok)
                local s = window.document:createElement("script")
                s.src = "vendor/pixelfx.js?v=2"
                s.async = true
                s.onload = function()
                    lib = if __t(window.PixelFXLib) then window.PixelFXLib else nil
                    if __t(lib) then
                        frame = lib:createFrame(FW, FH)
                        tela = window.document:createElement("canvas")
                        tela.width = FW
                        tela.height = FH
                        tctx = tela:getContext("2d")
                        img = tctx:createImageData(FW, FH)
                    end
                    ok(nil, lib)
                end
                s.onerror = function() return ok(nil, nil) end
                window.document.head:appendChild(s)
            end
        )
        return carregando
    end
    function tocar(self, id, o)
        if o == nil then
            o = {}
        end
        if not __t(lib) then
            carregar(nil)
            return nil
        end
        local mod = __get(lib.FX, id)
        if not __t(mod) then
            return nil
        end
        local dono = if __t(o.dono) then o.dono else "luta"
        local meus = __call(
            ativos,
            "filter",
            function(____, a) return a.dono == dono end
        )
        if __len(meus) >= limite(nil) then
            local velho = __get(meus, 0)
            __call(
                ativos,
                "splice",
                __call(ativos, "indexOf", velho),
                1
            )
        end
        local ____assign_9 = __assign
        local ____temp_7 = {}
        local ____temp_8 = if __t(o.opcoes) then o.opcoes else {}
        local ____o_seed_6 = o.seed
        if ____o_seed_6 == nil then
            ____o_seed_6 = __bor(
                math.random() * 1000000,
                0
            )
        end
        local op = ____assign_9(____temp_7, ____temp_8, {seed = ____o_seed_6})
        if __t(o.palette) then
            op.palette = o.palette
        end
        if __t(o.flip) then
            op.flip = true
        end
        if o.light ~= nil then
            op.light = o.light
        end
        local fx
        do
            local function ____catch(e)
                return true, nil
            end
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                fx = lib:createFx(mod, op)
                do
                    local k = 0
                    while k < if __t(o.avancar) then o.avancar else 0 * 60 do
                        fx:update(1 / 60)
                        k = k + 1
                    end
                end
            end)
            if not ____try then
                ____hasReturned, ____returnValue = ____catch(____hasReturned)
            end
            if ____hasReturned then
                return ____returnValue
            end
        end
        local ____fx_13 = fx
        local ____dono_14 = dono
        local ____temp_15 = o.mundo ~= false
        local ____temp_16 = if __t(o.x) then o.x else 0
        local ____temp_17 = if __t(o.y) then o.y else 0
        local ____temp_18 = if __t(o.seguir) then o.seguir else nil
        local ____temp_19 = if __t(o.atraso) then o.atraso else 0
        local ____t_12 = __t
        local ____opt_10 = mod.meta
        if ____opt_10 ~= nil then
            ____opt_10 = ____opt_10.loop
        end
        local a = {
            fx = ____fx_13,
            dono = ____dono_14,
            mundo = ____temp_15,
            x = ____temp_16,
            y = ____temp_17,
            seguir = ____temp_18,
            atraso = ____temp_19,
            vida = 0,
            duracao = if __t(o.duracao) then o.duracao else if ____t_12(____opt_10) then 4 else 0
        }
        __call(ativos, "push", a)
        return __getters(
            {parar = function() return fx:stop() end},
            {feito = function()
                return fx:done()
            end}
        )
    end
    function disparo(self, d)
        local pal = __get(
            PAL,
            __get(DISPARO, d.kind)
        )
        if not __t(pal) then
            return
        end
        local ag = window.performance:now()
        if ag - if __t(ultimo.__disparo) then ultimo.__disparo else 0 < 180 then
            return
        end
        ultimo.__disparo = ag
        if d.kind == "smoke" then
            tocar(nil, "spawn/poof", {x = d.x, y = d.y + 10, palette = pal})
        else
            tocar(nil, "arcane/mana-burst", {x = d.x, y = d.y + 10, palette = pal})
        end
    end
    local ____ = "use strict"
    if __t(window.FxPixel) then
        return
    end
    FW = 480
    FH = 270
    local ESC = 2
    lib = nil
    carregando = nil
    frame = nil
    img = nil
    tela = nil
    tctx = nil
    ativos = __arrL({}, 0)
    ultimo = __objCreate(nil)
    PAL = __ord(
        {
            peido = __arrL({
                "#16200c",
                "#2e3c14",
                "#56681e",
                "#8aa030",
                "#bcd25a",
                "#e6f6a0",
                "#fbffe0"
            }, 7),
            poeira = __arrL({
                "#2a2016",
                "#4a3a28",
                "#7a6448",
                "#a89070",
                "#d4c0a0",
                "#f2e8d4"
            }, 6),
            fumaca = __arrL({
                "#121016",
                "#26222c",
                "#3e3846",
                "#5c5466",
                "#867e8e",
                "#b2acb8",
                "#dcd8e0"
            }, 7),
            brasa = __arrL({
                "#1a0a06",
                "#4a1608",
                "#8a2a0a",
                "#d0501a",
                "#ff8a30",
                "#ffc870",
                "#fff0c8"
            }, 7),
            choque = __arrL({
                "#2a1712",
                "#5e2c1c",
                "#a4502a",
                "#e8893a",
                "#ffc764",
                "#fff0b4",
                "#ffffff"
            }, 7),
            tinta = __arrL({
                "#140a1c",
                "#2c1640",
                "#4a2a68",
                "#6e4296",
                "#9a6ec4",
                "#c8a4e6",
                "#f2e4ff"
            }, 7),
            ouro = __arrL({
                "#2a1a06",
                "#5a3a0a",
                "#9a6a14",
                "#d8a028",
                "#ffd25a",
                "#fff0a8",
                "#ffffff"
            }, 7),
            eletrico = __arrL({
                "#06101c",
                "#0c2a44",
                "#14507a",
                "#2a8ac0",
                "#6ac8f0",
                "#bff0ff",
                "#ffffff"
            }, 7),
            catarro = __arrL({
                "#101806",
                "#22320c",
                "#3e5a14",
                "#69922a",
                "#a2c946",
                "#d8ee8c",
                "#f6ffd6"
            }, 7)
        },
        "peido,poeira,fumaca,brasa,choque,tinta,ouro,eletrico,catarro"
    )
    local function agendar()
        return window:setTimeout(
            function() return carregar(nil) end,
            1200
        )
    end
    if window.document.readyState == "complete" then
        agendar(nil)
    else
        window:addEventListener("load", agendar, {once = true})
    end
    local function leve()
        local ____t_5 = __t
        local ____opt_2 = window.Graphics
        if ____opt_2 ~= nil then
            ____opt_2 = ____opt_2.isLite
        end
        local ____opt_result_4
        if ____opt_2 ~= nil then
            ____opt_result_4 = ____opt_2(____opt_2)
        end
        return not not ____t_5(____opt_result_4)
    end
    limite = function() return if __t(leve(nil)) then 6 else 22 end
    local function desenhar(self, ctx, o)
        if o == nil then
            o = {}
        end
        if __t(not __t(lib) or not __t(__len(ativos))) then
            return
        end
        local dono = if __t(o.dono) then o.dono else "luta"
        local camada = if o.camada == "back" then "back" else "front"
        local ____t_21 = __t
        local ____TS__Number_result_20 = __TS__Number(o.camera)
        __O[1474] = ____TS__Number_result_20
        local cam = if ____t_21(____TS__Number_result_20) then __O[1474] else 0
        local meus = __call(
            ativos,
            "filter",
            function(____, a) return a.dono == dono end
        )
        if not __t(__len(meus)) then
            return
        end
        local ____t_24 = __t
        local ____t_23 = __t
        local ____temp_22 = camada == "back"
        __O[1475] = ____temp_22
        if ____t_24(if ____t_23(____temp_22) then __O[1475] else o.atualizar) then
            local t = __TS__Number(o.tempo)
            local dt = 1 / 60
            if __isFiniteN(t) then
                local u = __get(ultimo, dono)
                dt = if u == nil then 1 / 60 else math.max(
                    0,
                    math.min(0.1, t - u)
                )
                __set(ultimo, dono, t)
            end
            for ____, a in __iterar((meus)) do
                if __gt(a.atraso, 0) then
                    a.atraso = a.atraso - dt
                    continue
                end
                a.fx:update(dt)
                a.vida = a.vida + dt
                if __t(if __t(a.duracao) then __ge(a.vida, a.duracao) else a.duracao) then
                    a.fx:stop()
                end
            end
            do
                local i = __len(ativos) - 1
                while i >= 0 do
                    local ____t_27 = __t
                    local ____t_26 = __t
                    local ____temp_25 = __get(ativos, i).dono == dono
                    __O[1476] = ____temp_25
                    if ____t_27(if ____t_26(____temp_25) then __get(ativos, i).fx:done() else __O[1476]) then
                        __call(ativos, "splice", i, 1)
                    end
                    i = i - 1
                end
            end
        end
        lib:clearFrame(frame)
        local algum = false
        for ____, a in __iterar((meus)) do
            local ____t_30 = __t
            local ____t_29 = __t
            local ____gt_result_28 = __gt(a.atraso, 0)
            __O[1477] = ____gt_result_28
            if ____t_30(if ____t_29(____gt_result_28) then __O[1477] else a.fx:done()) then
                continue
            end
            local p = if __t(a.seguir) then a:seguir() else a
            if not __t(p) then
                continue
            end
            a.fx.options.x = math.floor(if __t(a.mundo) then p.x - cam else p.x / ESC + 0.5)
            a.fx.options.y = math.floor(p.y / ESC + 0.5)
            do
                local function ____catch(e)
                    a.fx:stop()
                end
                local ____try, ____hasReturned = pcall(function()
                    a.fx:draw(frame, camada)
                    algum = true
                end)
                if not ____try then
                    ____catch(____hasReturned)
                end
            end
        end
        if not __t(algum) then
            return
        end
        lib:composite(frame, img.data, nil)
        tctx:putImageData(img, 0, 0)
        ctx:save()
        ctx.imageSmoothingEnabled = false
        ctx:drawImage(
            tela,
            if o.mundo == false then 0 else cam,
            0,
            FW * ESC,
            FH * ESC
        )
        ctx:restore()
    end
    local function limpar(self, dono)
        do
            local i = __len(ativos) - 1
            while i >= 0 do
                if __t(not __t(dono) or __get(ativos, i).dono == dono) then
                    __call(ativos, "splice", i, 1)
                end
                i = i - 1
            end
        end
        if __t(dono) then
            __del(ultimo, dono)
        else
            for ____, k in __iterar((__keys(ultimo))) do
                __del(ultimo, k)
            end
        end
    end
    local function aoEvento(self, tipo, d)
        if __t(window.Golpes) then
            return
        end
        local ____t_33 = __t
        local ____t_32 = __t
        local ____temp_31 = not __t(d) or not __isFiniteN(d.x)
        __O[1478] = ____temp_31
        if ____t_33(if ____t_32(____temp_31) then __O[1478] else not __isFiniteN(d.y)) then
            return
        end
        local dir = if __lt(d.dir, 0) then -1 else 1
        if tipo == "gas" then
            local st = math.max(
                1,
                math.min(3, if __t(d.stage) then d.stage else 1)
            )
            tocar(nil, "spawn/poof", {x = d.x + dir * 18, y = d.y + 22, palette = PAL.peido, flip = dir < 0})
            if st >= 2 then
                tocar(nil, "spawn/poof", {x = d.x + dir * 70, y = d.y + 26, palette = PAL.peido, atraso = 0.08})
            end
            if st >= 3 then
                tocar(nil, "nature/acid-splash", {x = d.x + dir * 60, y = d.y + 30, palette = PAL.peido, atraso = 0.12})
                tocar(nil, "spawn/poof", {x = d.x + dir * 125, y = d.y + 26, palette = PAL.peido, atraso = 0.16})
            end
        elseif tipo == "dash" then
            tocar(nil, "spawn/poof", {x = d.x - dir * 14, y = d.y + 4, palette = PAL.poeira, flip = dir < 0})
        else
            local ____t_36 = __t
            local ____t_35 = __t
            local ____temp_34 = tipo == "cast"
            __O[1479] = ____temp_34
            if ____t_36(if ____t_35(____temp_34) then d.kind else __O[1479]) then
                disparo(nil, d)
            elseif __t(tipo == "cast" and not __t(d.kind)) then
                if d.element == "fire" then
                    tocar(nil, "arcane/mana-burst", {x = d.x, y = d.y + 10, palette = PAL.brasa})
                elseif d.element == "electric" then
                    tocar(nil, "arcane/mana-burst", {x = d.x, y = d.y + 10, palette = PAL.eletrico})
                end
            elseif tipo == "surge" then
                tocar(nil, "explosions/plasma-explosion", {x = d.x, y = d.y + 40, palette = PAL.ouro})
            end
        end
    end
    local function ligarCampaignVfx(self)
        local o = window.CampaignVfx
        local ____t_39 = __t
        local ____t_38 = __t
        local ____temp_37 = not __t(o)
        __O[1480] = ____temp_37
        if ____t_39(if ____t_38(____temp_37) then __O[1480] else o.__pixel) then
            return false
        end
        window.CampaignVfx = __assign(
            {},
            o,
            {
                __pixel = true,
                emit = function(self, tipo, dados)
                    local r = o:emit(tipo, dados)
                    do
                        pcall(function()
                            aoEvento(nil, tipo, dados)
                        end)
                    end
                    return r
                end
            }
        )
        return true
    end
    if not __t(ligarCampaignVfx(nil)) then
        window:addEventListener("DOMContentLoaded", ligarCampaignVfx, {once = true})
    end
    local function perigo(self, h, chefe)
        local ____t_42 = __t
        local ____t_41 = __t
        local ____temp_40 = not __t(h)
        __O[1481] = ____temp_40
        if ____t_42(if ____t_41(____temp_40) then __O[1481] else window.Golpes) then
            return
        end
        local x = h.x
        local y = if __t(h.y) then h.y else 0 + 8
        local ____t_45 = __t
        local ____t_44 = __t
        local ____temp_43 = h.type == "astral"
        __O[1482] = ____temp_43
        if ____t_45(if ____t_44(____temp_43) then __O[1482] else h.astral) then
            tocar(nil, "arcane/star-fall", {x = x, y = y})
        elseif h.type == "slime" then
            tocar(nil, "nature/acid-splash", {x = x, y = y})
        else
            local ____t_48 = __t
            local ____t_47 = __t
            local ____temp_46 = h.type == "smoke"
            __O[1483] = ____temp_46
            if ____t_48(if ____t_47(____temp_46) then h.brasa else __O[1483]) then
                local ag = window.performance:now()
                if ag - if __t(ultimo.__brasa) then ultimo.__brasa else 0 > 280 then
                    ultimo.__brasa = ag
                    tocar(
                        nil,
                        "spawn/poof",
                        {
                            x = x,
                            y = y,
                            palette = PAL.fumaca,
                            opcoes = {stars = __call(PAL.brasa, "slice", 3)}
                        }
                    )
                end
            elseif h.type == "smoke" then
                tocar(nil, "spawn/poof", {x = x, y = y, palette = PAL.fumaca})
                tocar(nil, "explosions/smoke-bomb", {
                    x = x,
                    y = y + 4,
                    palette = PAL.fumaca,
                    avancar = 0.9,
                    duracao = 1.6,
                    opcoes = {semLata = true}
                })
            else
                local ____t_51 = __t
                local ____t_50 = __t
                local ____temp_49 = h.type == "ring"
                __O[1484] = ____temp_49
                if ____t_51(if ____t_50(____temp_49) then h.smoke else __O[1484]) then
                    tocar(nil, "spawn/poof", {x = x, y = y, palette = PAL.fumaca})
                else
                    local ____t_54 = __t
                    local ____t_53 = __t
                    local ____temp_52 = h.type == "ring"
                    __O[1485] = ____temp_52
                    if ____t_54(if ____t_53(____temp_52) then h.catarro else __O[1485]) then
                        tocar(nil, "water/wave-crash", {x = x - 30, y = y, palette = PAL.catarro, flip = true})
                        tocar(nil, "water/wave-crash", {x = x + 30, y = y, palette = PAL.catarro})
                        tocar(nil, "nature/acid-splash", {x = x, y = y, palette = PAL.catarro, atraso = 0.05})
                    elseif h.type == "slime" then
                        tocar(nil, "nature/acid-splash", {x = x, y = y, palette = PAL.catarro})
                    elseif __t(if __t(h.ink) then h.ink else h.type == "ink") then
                        tocar(nil, "shadow/dark-explosion", {x = x, y = y, palette = PAL.tinta})
                    elseif h.type == "provoke" then
                        tocar(nil, "arcane/magic-circle-cast", {x = x, y = y, palette = PAL.ouro})
                    elseif h.type == "ring" then
                        tocar(nil, "impacts/ground-slam", {x = x, y = y, palette = PAL.choque})
                    else
                        tocar(nil, "nature/quake", {x = x, y = y})
                    end
                end
            end
        end
    end
    local COR = __ord({
        nicolas = "ouro",
        reeisBoss = "ouro",
        arthur = "ouro",
        marco = "tinta",
        giant = "tinta",
        nikolas = "catarro",
        dede = "fumaca",
        freddy = "brasa",
        menezes = "poeira",
        igor = "eletrico",
        kaique = "eletrico"
    }, "nicolas,reeisBoss,arthur,marco,giant,nikolas,dede,freddy,menezes,igor,kaique")
    local function corDe(____, e)
        local ____t_61 = __t
        local ____get_59 = __get
        local ____get_58 = __get
        local ____opt_result_57
        if e ~= nil then
            ____opt_result_57 = e.type
        end
        local ____get_59_result_60 = ____get_59(
            PAL,
            ____get_58(COR, ____opt_result_57)
        )
        __O[1486] = ____get_59_result_60
        return if ____t_61(____get_59_result_60) then __O[1486] else PAL.ouro
    end
    local function fase(self, e)
        if not __t(e) then
            return
        end
        local x = e.x
        local y = e.y
        local t = e.type
        tocar(
            nil,
            "arcane/magic-circle-cast",
            {
                x = x,
                y = y,
                palette = corDe(nil, e)
            }
        )
        if t == "nicolas" then
            tocar(nil, "holy/sunburst", {x = x, y = y - 70, palette = PAL.ouro, duracao = 1.3})
        elseif __t(t == "marco" or t == "giant") then
            tocar(nil, "shadow/dark-explosion", {x = x, y = y, palette = PAL.tinta})
        else
            local ____t_66 = __t
            local ____t_65 = __t
            local ____t_63 = __t
            local ____temp_62 = t == "freddy" or t == "menezes"
            __O[1487] = ____temp_62
            local ____temp_64 = if ____t_63(____temp_62) then __O[1487] else t == "igor"
            __O[1488] = ____temp_64
            if ____t_66(if ____t_65(____temp_64) then __O[1488] else t == "kaique") then
                tocar(nil, "impacts/ground-slam", {x = x, y = y, palette = if __t(t == "igor" or t == "kaique") then PAL.eletrico else PAL.choque})
            elseif t == "dede" then
                tocar(nil, "explosions/smoke-bomb", {
                    x = x,
                    y = y,
                    palette = PAL.fumaca,
                    avancar = 0.9,
                    duracao = 1.8,
                    opcoes = {semLata = true}
                })
            elseif t == "reeisBoss" then
                tocar(nil, "explosions/plasma-explosion", {x = x, y = y - 30, palette = PAL.ouro})
            elseif t == "arthur" then
                tocar(nil, "holy/feather-burst", {x = x, y = y - 50})
            end
        end
    end
    local function derrota(self, e)
        if not __t(e) then
            return
        end
        local x = e.x
        local y = e.y
        tocar(nil, "explosions/firework-burst", {x = x, y = y - 150, palette = PAL.ouro})
        tocar(nil, "explosions/firework-burst", {x = x - 110, y = y - 120, atraso = 0.35})
        tocar(
            nil,
            "explosions/firework-burst",
            {
                x = x + 110,
                y = y - 135,
                palette = corDe(nil, e),
                atraso = 0.7
            }
        )
        tocar(nil, "spawn/poof", {x = x, y = y, palette = PAL.poeira})
    end
    local estados = __TS__New(WeakMap)
    local function chefe(self, e)
        if __t(not __t(e) or not __t(lib)) then
            return
        end
        local antes = __call(estados, "get", e)
        local agora = if __t(e.conquista) then e.conquista.estado else e.state
        if antes == agora then
            return
        end
        __call(estados, "set", e, agora)
        if __t(agora == "dashing" and not __t(window.Golpes)) then
            local d = if __lt(e.dashDir, 0) then -1 else 1
            tocar(nil, "spawn/poof", {x = e.x - d * 22, y = e.y, palette = PAL.poeira, flip = d < 0})
        elseif __t(agora == "phaseChange" and antes ~= nil) then
            fase(nil, e)
        end
    end
    DISPARO = __ord({
        smoke = "fumaca",
        astral = "eletrico",
        slime = "catarro",
        doodle = "tinta",
        inkBlade = "tinta",
        enemyBullet = "choque",
        gangFan = "ouro",
        confetti = "ouro",
        word = "ouro"
    }, "smoke,astral,slime,doodle,inkBlade,enemyBullet,gangFan,confetti,word")
    window.FxPixel = __ord(
        {
            pronto = function() return not not __t(lib) end,
            carregar = carregar,
            tocar = tocar,
            desenhar = desenhar,
            perigo = perigo,
            limpar = limpar,
            ativos = function() return __len(ativos) end,
            PAL = PAL,
            aoEvento = aoEvento,
            fase = fase,
            derrota = derrota,
            chefe = chefe
        },
        "pronto,carregar,tocar,desenhar,perigo,limpar,ativos,PAL,aoEvento,fase,derrota,chefe"
    )
end)(nil)
return ____exports
