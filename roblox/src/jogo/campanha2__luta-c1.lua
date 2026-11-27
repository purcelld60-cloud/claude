--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __getq, __callq, __ord, __arrL, __t, __get, __new, __getters = __JSR.__getq, __JSR.__callq, __JSR.__ord, __JSR.__arrL, __JSR.__t, __JSR.__get, __JSR.__new, __JSR.__getters
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Number = ____lualib.__TS__Number
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    if __t(window.C2Luta) then
        return
    end
    local KIT = __ord(
        {
            creuza = __ord({kit = "dede", vida = 1.6}, "kit,vida"),
            tonhao = __ord({kit = "arthur", vida = 1.6}, "kit,vida"),
            valdomiro = __ord({kit = "freddy", vida = 2}, "kit,vida"),
            kaua = __ord({kit = "menezes", vida = 1}, "kit,vida"),
            barao = __ord({kit = "reeisBoss", vida = 1.7}, "kit,vida"),
            breno = __ord({kit = "freddy", vida = 3}, "kit,vida"),
            gemeos = __ord({kit = "arthur", vida = 3}, "kit,vida"),
            fred = __ord({kit = "reeisBoss", vida = 2.2}, "kit,vida"),
            jorge = __ord({kit = "nicolas", vida = 2}, "kit,vida")
        },
        "creuza,tonhao,valdomiro,kaua,barao,breno,gemeos,fred,jorge"
    )
    local skin = nil
    local aoFim = nil
    local camBase = 0
    local cam0 = nil
    local entrando = false
    local function iniciar(self, o, fim)
        if o == nil then
            o = {}
        end
        local k = __get(KIT, o.slug)
        local ____t_13 = __t
        local ____t_8 = __t
        local ____t_3 = __t
        local ____t_1 = __t
        local ____temp_0 = not __t(k)
        __O[954] = ____temp_0
        local ____temp_2 = if ____t_1(____temp_0) then __O[954] else skin
        __O[955] = ____temp_2
        local ____t_6 = __t
        local ____opt_4 = window.Game
        if ____opt_4 ~= nil then
            ____opt_4 = ____opt_4.startSandboxBoss
        end
        local ____temp_7 = if ____t_3(____temp_2) then __O[955] else not ____t_6(____opt_4)
        __O[956] = ____temp_7
        local ____t_12 = __t
        local ____getq_11 = __getq
        local ____opt_9 = window.ConquistaCombate
        if ____opt_9 ~= nil then
            ____opt_9 = ____opt_9.chefes
        end
        if ____t_13(if ____t_8(____temp_7) then __O[956] else not ____t_12(____getq_11(____opt_9, o.slug))) then
            return false
        end
        local fase = __get(window.CampanhaFases.FASES, o.slug)
        local ____callq_18 = __callq
        local ____opt_16 = window.CampanhaCenarios
        if ____opt_16 ~= nil then
            ____opt_16 = ____opt_16.lista
        end
        local ____opt_14 = ____callq_18(
            ____opt_16,
            "find",
            function(____, d) return d.id == o.cena end
        )
        if ____opt_14 ~= nil then
            ____opt_14 = ____opt_14.nome
        end
        local lugar = ____opt_14
        skin = {
            lugar = lugar,
            nivel = fase.chefe.nivel,
            kit = k.kit,
            vida = k.vida,
            dano = 1.3,
            tipo = o.tipo,
            nome = if __t(o.nome) then o.nome else o.slug,
            tema = o.slug,
            cena = o.cena,
            bossX = o.bossX
        }
        local ____t_24 = __t
        local ____opt_21 = window.CampanhaCenarios
        if ____opt_21 ~= nil then
            ____opt_21 = ____opt_21.largura
        end
        local ____opt_result_23
        if ____opt_21 ~= nil then
            ____opt_result_23 = ____opt_21(____opt_21, o.cena)
        end
        __O[957] = ____opt_result_23
        local larg = if ____t_24(____opt_result_23) then __O[957] else 4000
        local ____temp_27 = larg - 960
        local ____t_26 = __t
        local ____TS__Number_result_25 = __TS__Number(o.bossX)
        __O[958] = ____TS__Number_result_25
        camBase = math.max(
            0,
            math.min(____temp_27, if ____t_26(____TS__Number_result_25) then __O[958] else 480 - 480)
        )
        cam0 = nil
        aoFim = fim
        do
            pcall(function()
                if window.localStorage:getItem("daroca-sandbox-v1") ~= "1" then
                    window.localStorage:setItem("daroca-sandbox-v1", "1")
                end
            end)
        end
        do
            pcall(function()
                window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {active = false}}))
            end)
        end
        local ok = false
        entrando = true
        do
            local function ____catch(e)
                ok = false
            end
            local ____try, ____hasReturned = pcall(function()
                ok = not not __t(window.Game:startSandboxBoss(k.kit))
            end)
            local ____rethrow
            if not ____try then
                ____try, ____rethrow = pcall(function()
                    ____catch(____hasReturned)
                end)
            end
            do
                entrando = false
            end
            if not ____try then
                error(____rethrow, 0)
            end
        end
        if __t(ok) then
            local ____opt_31 = window.DayTime
            if ____opt_31 ~= nil then
                ____opt_31 = ____opt_31.force
            end
            if ____opt_31 ~= nil then
                local ____o_hora_29 = o.hora
                if ____o_hora_29 == nil then
                    ____o_hora_29 = fase.hora
                end
                ____opt_31(____opt_31, ____o_hora_29)
            end
        else
            skin = nil
            aoFim = nil
            window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {active = true}}))
        end
        return ok
    end
    window:addEventListener(
        "sandbox-change",
        function(____, e)
            local d = e.detail
            local ____t_35 = __t
            local ____t_34 = __t
            local ____temp_33 = not __t(skin) or not __t(aoFim)
            __O[959] = ____temp_33
            if ____t_35(if ____t_34(____temp_33) then __O[959] else entrando) then
                return
            end
            if not __t(d) then
                local cb = aoFim
                aoFim = nil
                skin = nil
                local ____opt_38 = window.DayTime
                if ____opt_38 ~= nil then
                    ____opt_38 = ____opt_38.force
                end
                if ____opt_38 ~= nil then
                    ____opt_38(____opt_38, nil)
                end
                cb(nil, "recuou")
                return
            end
            if __t(not __t(d.result) or d.type ~= skin.kit) then
                return
            end
            local r = d.result
            local cb = aoFim
            aoFim = nil
            window:setTimeout(
                function()
                    skin = nil
                    local ____opt_42 = window.DayTime
                    if ____opt_42 ~= nil then
                        ____opt_42 = ____opt_42.force
                    end
                    if ____opt_42 ~= nil then
                        ____opt_42(____opt_42, nil)
                    end
                    do
                        pcall(function()
                            window.Game:exitSandbox()
                        end)
                    end
                    if cb ~= nil then
                        cb(nil, if r == "won" then "venceu" else if r == "retreat" then "recuou" else "perdeu")
                    end
                end,
                if r == "won" then 700 else 500
            )
        end
    )
    local function desenharFundo(self, ctx, camera, time)
        if not __t(skin) then
            return false
        end
        if cam0 == nil then
            cam0 = camera
        end
        local ____t_51 = __t
        local ____opt_48 = window.CampanhaCenarios
        if ____opt_48 ~= nil then
            ____opt_48 = ____opt_48.largura
        end
        local ____opt_result_50
        if ____opt_48 ~= nil then
            ____opt_result_50 = ____opt_48(____opt_48, skin.cena)
        end
        __O[960] = ____opt_result_50
        local larg = if ____t_51(____opt_result_50) then __O[960] else 4000
        local cx = math.max(
            0,
            math.min(larg - 960, camBase + (camera - cam0))
        )
        do
            local function ____catch(e)
                return true, false
            end
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                local ____opt_54 = window.Art
                if ____opt_54 ~= nil then
                    ____opt_54 = ____opt_54.drawScene
                end
                if ____opt_54 ~= nil then
                    ____opt_54(
                        ____opt_54,
                        ctx,
                        skin.cena,
                        cx,
                        time
                    )
                end
            end)
            if not ____try then
                ____hasReturned, ____returnValue = ____catch(____hasReturned)
            end
            if ____hasReturned then
                return ____returnValue
            end
        end
        return true
    end
    local timbres = __ord(
        {
            creuza = __arrL({720, "sine"}, 2),
            tonhao = __arrL({104, "sawtooth"}, 2),
            valdomiro = __arrL({260, "triangle"}, 2),
            kaua = __arrL({840, "square"}, 2),
            barao = __arrL({176, "triangle"}, 2),
            breno = __arrL({96, "triangle"}, 2),
            gemeos = __arrL({516, "square"}, 2),
            fred = __arrL({353, "triangle"}, 2),
            jorge = __arrL({286, "sine"}, 2)
        },
        "creuza,tonhao,valdomiro,kaua,barao,breno,gemeos,fred,jorge"
    )
    local function som(self, slug, beep, fase)
        local hz, onda = table.unpack(
            __get(timbres, slug),
            1,
            2
        )
        beep(
            nil,
            hz + if slug == "jorge" then fase * 24 else 0,
            0.11,
            onda,
            0.023
        )
    end
    window.C2Luta = __ord(
        __getters(
            {iniciar = iniciar, desenharFundo = desenharFundo, som = som, kits = KIT},
            {skin = function()
                return skin
            end}
        ),
        "skin,iniciar,desenharFundo,som,kits"
    )
end)(nil)
return ____exports
