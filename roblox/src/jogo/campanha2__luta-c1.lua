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
        local ____t_14 = __t
        local ____t_result_13
        local ____t_8 = __t
        local ____t_result_7
        local ____t_3 = __t
        local ____t_result_2
        local ____t_1 = __t
        local ____temp_0 = not __t(k)
        __O[972] = ____temp_0
        if ____t_1(____temp_0) then
            ____t_result_2 = __O[972]
        else
            ____t_result_2 = skin
        end
        __O[973] = ____t_result_2
        if ____t_3(____t_result_2) then
            ____t_result_7 = __O[973]
        else
            local ____t_6 = __t
            local ____opt_4 = window.Game
            if ____opt_4 ~= nil then
                ____opt_4 = ____opt_4.startSandboxBoss
            end
            ____t_result_7 = not ____t_6(____opt_4)
        end
        __O[974] = ____t_result_7
        if ____t_8(____t_result_7) then
            ____t_result_13 = __O[974]
        else
            local ____t_12 = __t
            local ____getq_11 = __getq
            local ____opt_9 = window.ConquistaCombate
            if ____opt_9 ~= nil then
                ____opt_9 = ____opt_9.chefes
            end
            ____t_result_13 = not ____t_12(____getq_11(____opt_9, o.slug))
        end
        if ____t_14(____t_result_13) then
            return false
        end
        local fase = __get(window.CampanhaFases.FASES, o.slug)
        local ____callq_19 = __callq
        local ____opt_17 = window.CampanhaCenarios
        if ____opt_17 ~= nil then
            ____opt_17 = ____opt_17.lista
        end
        local ____opt_15 = ____callq_19(
            ____opt_17,
            "find",
            function(____, d) return d.id == o.cena end
        )
        if ____opt_15 ~= nil then
            ____opt_15 = ____opt_15.nome
        end
        local lugar = ____opt_15
        local ____lugar_21 = lugar
        local ____fase_chefe_nivel_22 = fase.chefe.nivel
        local ____k_kit_23 = k.kit
        local ____k_vida_24 = k.vida
        local ____o_tipo_25 = o.tipo
        local ____t_result_20
        if __t(o.nome) then
            ____t_result_20 = o.nome
        else
            ____t_result_20 = o.slug
        end
        skin = {
            lugar = ____lugar_21,
            nivel = ____fase_chefe_nivel_22,
            kit = ____k_kit_23,
            vida = ____k_vida_24,
            dano = 1.3,
            tipo = ____o_tipo_25,
            nome = ____t_result_20,
            tema = o.slug,
            cena = o.cena,
            bossX = o.bossX
        }
        local ____t_result_32
        local ____t_31 = __t
        local ____opt_28 = window.CampanhaCenarios
        if ____opt_28 ~= nil then
            ____opt_28 = ____opt_28.largura
        end
        local ____opt_result_30
        if ____opt_28 ~= nil then
            ____opt_result_30 = ____opt_28(____opt_28, o.cena)
        end
        __O[975] = ____opt_result_30
        if ____t_31(____opt_result_30) then
            ____t_result_32 = __O[975]
        else
            ____t_result_32 = 4000
        end
        local larg = ____t_result_32
        local ____temp_36 = larg - 960
        local ____t_result_35
        local ____t_34 = __t
        local ____TS__Number_result_33 = __TS__Number(o.bossX)
        __O[976] = ____TS__Number_result_33
        if ____t_34(____TS__Number_result_33) then
            ____t_result_35 = __O[976]
        else
            ____t_result_35 = 480
        end
        camBase = math.max(
            0,
            math.min(____temp_36, ____t_result_35 - 480)
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
            local ____opt_40 = window.DayTime
            if ____opt_40 ~= nil then
                ____opt_40 = ____opt_40.force
            end
            if ____opt_40 ~= nil then
                local ____o_hora_38 = o.hora
                if ____o_hora_38 == nil then
                    ____o_hora_38 = fase.hora
                end
                ____opt_40(____opt_40, ____o_hora_38)
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
            local ____t_45 = __t
            local ____t_result_44
            local ____t_43 = __t
            local ____temp_42 = not __t(skin) or not __t(aoFim)
            __O[977] = ____temp_42
            if ____t_43(____temp_42) then
                ____t_result_44 = __O[977]
            else
                ____t_result_44 = entrando
            end
            if ____t_45(____t_result_44) then
                return
            end
            if not __t(d) then
                local cb = aoFim
                aoFim = nil
                skin = nil
                local ____opt_48 = window.DayTime
                if ____opt_48 ~= nil then
                    ____opt_48 = ____opt_48.force
                end
                if ____opt_48 ~= nil then
                    ____opt_48(____opt_48, nil)
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
                    local ____opt_52 = window.DayTime
                    if ____opt_52 ~= nil then
                        ____opt_52 = ____opt_52.force
                    end
                    if ____opt_52 ~= nil then
                        ____opt_52(____opt_52, nil)
                    end
                    do
                        pcall(function()
                            window.Game:exitSandbox()
                        end)
                    end
                    if cb ~= nil then
                        cb(nil, r == "won" and "venceu" or (r == "retreat" and "recuou" or "perdeu"))
                    end
                end,
                r == "won" and 700 or 500
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
        local ____t_result_62
        local ____t_61 = __t
        local ____opt_58 = window.CampanhaCenarios
        if ____opt_58 ~= nil then
            ____opt_58 = ____opt_58.largura
        end
        local ____opt_result_60
        if ____opt_58 ~= nil then
            ____opt_result_60 = ____opt_58(____opt_58, skin.cena)
        end
        __O[978] = ____opt_result_60
        if ____t_61(____opt_result_60) then
            ____t_result_62 = __O[978]
        else
            ____t_result_62 = 4000
        end
        local larg = ____t_result_62
        local cx = math.max(
            0,
            math.min(larg - 960, camBase + (camera - cam0))
        )
        do
            local function ____catch(e)
                return true, false
            end
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                local ____opt_65 = window.Art
                if ____opt_65 ~= nil then
                    ____opt_65 = ____opt_65.drawScene
                end
                if ____opt_65 ~= nil then
                    ____opt_65(
                        ____opt_65,
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
        local ____beep_69 = beep
        local ____hz_68 = hz
        local ____temp_67
        if slug == "jorge" then
            ____temp_67 = fase * 24
        else
            ____temp_67 = 0
        end
        ____beep_69(
            nil,
            ____hz_68 + ____temp_67,
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
