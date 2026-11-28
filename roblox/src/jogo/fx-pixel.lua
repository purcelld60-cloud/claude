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
                    local ____t_result_0
                    if __t(window.PixelFXLib) then
                        ____t_result_0 = window.PixelFXLib
                    else
                        ____t_result_0 = nil
                    end
                    lib = ____t_result_0
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
        local ____t_result_7
        if __t(o.dono) then
            ____t_result_7 = o.dono
        else
            ____t_result_7 = "luta"
        end
        local dono = ____t_result_7
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
        local ____assign_11 = __assign
        local ____temp_10 = {}
        local ____t_result_8
        if __t(o.opcoes) then
            ____t_result_8 = o.opcoes
        else
            ____t_result_8 = {}
        end
        local ____o_seed_9 = o.seed
        if ____o_seed_9 == nil then
            ____o_seed_9 = __bor(
                math.random() * 1000000,
                0
            )
        end
        local op = ____assign_11(____temp_10, ____t_result_8, {seed = ____o_seed_9})
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
                    while true do
                        local ____k_13 = k
                        local ____t_result_12
                        if __t(o.avancar) then
                            ____t_result_12 = o.avancar
                        else
                            ____t_result_12 = 0
                        end
                        if not (____k_13 < ____t_result_12 * 60) then
                            break
                        end
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
        local ____fx_22 = fx
        local ____dono_23 = dono
        local ____temp_24 = o.mundo ~= false
        local ____t_result_14
        if __t(o.x) then
            ____t_result_14 = o.x
        else
            ____t_result_14 = 0
        end
        local ____t_result_15
        if __t(o.y) then
            ____t_result_15 = o.y
        else
            ____t_result_15 = 0
        end
        local ____t_result_16
        if __t(o.seguir) then
            ____t_result_16 = o.seguir
        else
            ____t_result_16 = nil
        end
        local ____t_result_17
        if __t(o.atraso) then
            ____t_result_17 = o.atraso
        else
            ____t_result_17 = 0
        end
        local ____t_result_21
        if __t(o.duracao) then
            ____t_result_21 = o.duracao
        else
            local ____t_20 = __t
            local ____opt_18 = mod.meta
            if ____opt_18 ~= nil then
                ____opt_18 = ____opt_18.loop
            end
            ____t_result_21 = ____t_20(____opt_18) and 4 or 0
        end
        local a = {
            fx = ____fx_22,
            dono = ____dono_23,
            mundo = ____temp_24,
            x = ____t_result_14,
            y = ____t_result_15,
            seguir = ____t_result_16,
            atraso = ____t_result_17,
            vida = 0,
            duracao = ____t_result_21
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
        local ____t_result_103
        if __t(ultimo.__disparo) then
            ____t_result_103 = ultimo.__disparo
        else
            ____t_result_103 = 0
        end
        if ag - ____t_result_103 < 180 then
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
        local ____t_6 = __t
        local ____opt_3 = window.Graphics
        if ____opt_3 ~= nil then
            ____opt_3 = ____opt_3.isLite
        end
        local ____opt_result_5
        if ____opt_3 ~= nil then
            ____opt_result_5 = ____opt_3(____opt_3)
        end
        return not not ____t_6(____opt_result_5)
    end
    limite = function() return __t(leve(nil)) and 6 or 22 end
    local function desenhar(self, ctx, o)
        if o == nil then
            o = {}
        end
        if __t(not __t(lib) or not __t(__len(ativos))) then
            return
        end
        local ____t_result_25
        if __t(o.dono) then
            ____t_result_25 = o.dono
        else
            ____t_result_25 = "luta"
        end
        local dono = ____t_result_25
        local camada = o.camada == "back" and "back" or "front"
        local ____t_result_28
        local ____t_27 = __t
        local ____TS__Number_result_26 = __TS__Number(o.camera)
        __O[1492] = ____TS__Number_result_26
        if ____t_27(____TS__Number_result_26) then
            ____t_result_28 = __O[1492]
        else
            ____t_result_28 = 0
        end
        local cam = ____t_result_28
        local meus = __call(
            ativos,
            "filter",
            function(____, a) return a.dono == dono end
        )
        if not __t(__len(meus)) then
            return
        end
        local ____t_32 = __t
        local ____t_result_31
        local ____t_30 = __t
        local ____temp_29 = camada == "back"
        __O[1493] = ____temp_29
        if ____t_30(____temp_29) then
            ____t_result_31 = __O[1493]
        else
            ____t_result_31 = o.atualizar
        end
        if ____t_32(____t_result_31) then
            local t = __TS__Number(o.tempo)
            local dt = 1 / 60
            if __isFiniteN(t) then
                local u = __get(ultimo, dono)
                local ____temp_33
                if u == nil then
                    ____temp_33 = 1 / 60
                else
                    ____temp_33 = math.max(
                        0,
                        math.min(0.1, t - u)
                    )
                end
                dt = ____temp_33
                __set(ultimo, dono, t)
            end
            for ____, a in __iterar((meus)) do
                do
                    if __gt(a.atraso, 0) then
                        a.atraso = a.atraso - dt
                        continue
                    end
                    a.fx:update(dt)
                    a.vida = a.vida + dt
                    local ____t_35 = __t
                    local ____t_result_34
                    if __t(a.duracao) then
                        ____t_result_34 = __ge(a.vida, a.duracao)
                    else
                        ____t_result_34 = a.duracao
                    end
                    if ____t_35(____t_result_34) then
                        a.fx:stop()
                    end
                end
            end
            do
                local i = __len(ativos) - 1
                while i >= 0 do
                    local ____t_39 = __t
                    local ____t_result_38
                    local ____t_37 = __t
                    local ____temp_36 = __get(ativos, i).dono == dono
                    __O[1494] = ____temp_36
                    if ____t_37(____temp_36) then
                        ____t_result_38 = __get(ativos, i).fx:done()
                    else
                        ____t_result_38 = __O[1494]
                    end
                    if ____t_39(____t_result_38) then
                        __call(ativos, "splice", i, 1)
                    end
                    i = i - 1
                end
            end
        end
        lib:clearFrame(frame)
        local algum = false
        for ____, a in __iterar((meus)) do
            do
                local ____t_43 = __t
                local ____t_result_42
                local ____t_41 = __t
                local ____gt_result_40 = __gt(a.atraso, 0)
                __O[1495] = ____gt_result_40
                if ____t_41(____gt_result_40) then
                    ____t_result_42 = __O[1495]
                else
                    ____t_result_42 = a.fx:done()
                end
                if ____t_43(____t_result_42) then
                    continue
                end
                local ____t_result_44
                if __t(a.seguir) then
                    ____t_result_44 = a:seguir()
                else
                    ____t_result_44 = a
                end
                local p = ____t_result_44
                if not __t(p) then
                    continue
                end
                local ____a_fx_options_46 = a.fx.options
                local ____t_result_45
                if __t(a.mundo) then
                    ____t_result_45 = p.x - cam
                else
                    ____t_result_45 = p.x
                end
                ____a_fx_options_46.x = math.floor(____t_result_45 / ESC + 0.5)
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
            o.mundo == false and 0 or cam,
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
        local ____t_50 = __t
        local ____t_result_49
        local ____t_48 = __t
        local ____temp_47 = not __t(d) or not __isFiniteN(d.x)
        __O[1496] = ____temp_47
        if ____t_48(____temp_47) then
            ____t_result_49 = __O[1496]
        else
            ____t_result_49 = not __isFiniteN(d.y)
        end
        if ____t_50(____t_result_49) then
            return
        end
        local dir = __lt(d.dir, 0) and -1 or 1
        if tipo == "gas" then
            local ____t_result_51
            if __t(d.stage) then
                ____t_result_51 = d.stage
            else
                ____t_result_51 = 1
            end
            local st = math.max(
                1,
                math.min(3, ____t_result_51)
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
            local ____t_55 = __t
            local ____t_result_54
            local ____t_53 = __t
            local ____temp_52 = tipo == "cast"
            __O[1497] = ____temp_52
            if ____t_53(____temp_52) then
                ____t_result_54 = d.kind
            else
                ____t_result_54 = __O[1497]
            end
            if ____t_55(____t_result_54) then
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
        local ____t_59 = __t
        local ____t_result_58
        local ____t_57 = __t
        local ____temp_56 = not __t(o)
        __O[1498] = ____temp_56
        if ____t_57(____temp_56) then
            ____t_result_58 = __O[1498]
        else
            ____t_result_58 = o.__pixel
        end
        if ____t_59(____t_result_58) then
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
        local ____t_63 = __t
        local ____t_result_62
        local ____t_61 = __t
        local ____temp_60 = not __t(h)
        __O[1499] = ____temp_60
        if ____t_61(____temp_60) then
            ____t_result_62 = __O[1499]
        else
            ____t_result_62 = window.Golpes
        end
        if ____t_63(____t_result_62) then
            return
        end
        local x = h.x
        local ____t_result_64
        if __t(h.y) then
            ____t_result_64 = h.y
        else
            ____t_result_64 = 0
        end
        local y = ____t_result_64 + 8
        local ____t_68 = __t
        local ____t_result_67
        local ____t_66 = __t
        local ____temp_65 = h.type == "astral"
        __O[1500] = ____temp_65
        if ____t_66(____temp_65) then
            ____t_result_67 = __O[1500]
        else
            ____t_result_67 = h.astral
        end
        if ____t_68(____t_result_67) then
            tocar(nil, "arcane/star-fall", {x = x, y = y})
        elseif h.type == "slime" then
            tocar(nil, "nature/acid-splash", {x = x, y = y})
        else
            local ____t_72 = __t
            local ____t_result_71
            local ____t_70 = __t
            local ____temp_69 = h.type == "smoke"
            __O[1501] = ____temp_69
            if ____t_70(____temp_69) then
                ____t_result_71 = h.brasa
            else
                ____t_result_71 = __O[1501]
            end
            if ____t_72(____t_result_71) then
                local ag = window.performance:now()
                local ____t_result_73
                if __t(ultimo.__brasa) then
                    ____t_result_73 = ultimo.__brasa
                else
                    ____t_result_73 = 0
                end
                if ag - ____t_result_73 > 280 then
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
                local ____t_77 = __t
                local ____t_result_76
                local ____t_75 = __t
                local ____temp_74 = h.type == "ring"
                __O[1502] = ____temp_74
                if ____t_75(____temp_74) then
                    ____t_result_76 = h.smoke
                else
                    ____t_result_76 = __O[1502]
                end
                if ____t_77(____t_result_76) then
                    tocar(nil, "spawn/poof", {x = x, y = y, palette = PAL.fumaca})
                else
                    local ____t_81 = __t
                    local ____t_result_80
                    local ____t_79 = __t
                    local ____temp_78 = h.type == "ring"
                    __O[1503] = ____temp_78
                    if ____t_79(____temp_78) then
                        ____t_result_80 = h.catarro
                    else
                        ____t_result_80 = __O[1503]
                    end
                    if ____t_81(____t_result_80) then
                        tocar(nil, "water/wave-crash", {x = x - 30, y = y, palette = PAL.catarro, flip = true})
                        tocar(nil, "water/wave-crash", {x = x + 30, y = y, palette = PAL.catarro})
                        tocar(nil, "nature/acid-splash", {x = x, y = y, palette = PAL.catarro, atraso = 0.05})
                    elseif h.type == "slime" then
                        tocar(nil, "nature/acid-splash", {x = x, y = y, palette = PAL.catarro})
                    else
                        local ____t_83 = __t
                        local ____t_result_82
                        if __t(h.ink) then
                            ____t_result_82 = h.ink
                        else
                            ____t_result_82 = h.type == "ink"
                        end
                        if ____t_83(____t_result_82) then
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
        local ____t_result_91
        local ____t_90 = __t
        local ____get_88 = __get
        local ____get_87 = __get
        local ____opt_result_86
        if e ~= nil then
            ____opt_result_86 = e.type
        end
        local ____get_88_result_89 = ____get_88(
            PAL,
            ____get_87(COR, ____opt_result_86)
        )
        __O[1504] = ____get_88_result_89
        if ____t_90(____get_88_result_89) then
            ____t_result_91 = __O[1504]
        else
            ____t_result_91 = PAL.ouro
        end
        return ____t_result_91
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
            local ____t_97 = __t
            local ____t_result_96
            local ____t_95 = __t
            local ____t_result_94
            local ____t_93 = __t
            local ____temp_92 = t == "freddy" or t == "menezes"
            __O[1505] = ____temp_92
            if ____t_93(____temp_92) then
                ____t_result_94 = __O[1505]
            else
                ____t_result_94 = t == "igor"
            end
            __O[1506] = ____t_result_94
            if ____t_95(____t_result_94) then
                ____t_result_96 = __O[1506]
            else
                ____t_result_96 = t == "kaique"
            end
            if ____t_97(____t_result_96) then
                local ____tocar_101 = tocar
                local ____x_99 = x
                local ____y_100 = y
                local ____t_result_98
                if __t(t == "igor" or t == "kaique") then
                    ____t_result_98 = PAL.eletrico
                else
                    ____t_result_98 = PAL.choque
                end
                ____tocar_101(nil, "impacts/ground-slam", {x = ____x_99, y = ____y_100, palette = ____t_result_98})
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
        local ____t_result_102
        if __t(e.conquista) then
            ____t_result_102 = e.conquista.estado
        else
            ____t_result_102 = e.state
        end
        local agora = ____t_result_102
        if antes == agora then
            return
        end
        __call(estados, "set", e, agora)
        if __t(agora == "dashing" and not __t(window.Golpes)) then
            local d = __lt(e.dashDir, 0) and -1 or 1
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
