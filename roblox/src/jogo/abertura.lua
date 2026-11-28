--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __mod, __arrL, __t, __get, __len, __call, __new, __re, __re_test = __JSR.__mod, __JSR.__arrL, __JSR.__t, __JSR.__get, __JSR.__len, __JSR.__call, __JSR.__new, __JSR.__re, __JSR.__re_test
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local el = window.document:getElementById("abertura")
    if not __t(el) then
        return
    end
    local ____t_1 = __t
    local ____t_result_0
    if __t(window.navigator.webdriver) then
        ____t_result_0 = not __re_test(
            __re("[?&]abertura\\b", ""),
            window.location.search
        )
    else
        ____t_result_0 = window.navigator.webdriver
    end
    if ____t_1(____t_result_0) then
        el:remove()
        return
    end
    local MINIMO = 4300
    local DICAS = __arrL({
        "Assando o bolo de sapo...",
        "Afiando o chinelo...",
        "Enchendo o botijão do carro...",
        "Chamando a resenha...",
        "Varrendo o terreiro...",
        "Acordando os passarinhos...",
        "Separando o açaí de quarta..."
    }, 7)
    local dica = el:querySelector(".ab-dica")
    local n = 0
    local troca = window:setInterval(
        function()
            n = __mod(
                n + 1,
                __len(DICAS)
            )
            local ____t_3 = __t
            local ____t_result_2
            if __t(dica) then
                ____t_result_2 = not __t(el.classList:contains("ab-pronto"))
            else
                ____t_result_2 = dica
            end
            if ____t_3(____t_result_2) then
                dica.textContent = __get(DICAS, n)
            end
        end,
        900
    )
    local carregado = false
    local pularPedido = false
    local saindo = false
    local t0 = window.performance:now()
    local function sair(self)
        if __t(saindo) then
            return
        end
        saindo = true
        window:clearInterval(troca)
        __call(el.classList, "add", "ab-sai")
        window:setTimeout(
            function()
                el:remove()
                window:dispatchEvent(__new("Event", "abertura-fim"))
            end,
            600
        )
    end
    local function pronto(self)
        carregado = true
        __call(el.classList, "add", "ab-pronto")
        if __t(dica) then
            dica.textContent = "PRONTO!"
        end
        window:setTimeout(
            sair,
            __t(pularPedido) and 150 or 900
        )
    end
    local function quandoCarregar(self)
        local falta = math.max(
            0,
            MINIMO - (window.performance:now() - t0)
        )
        window:setTimeout(pronto, falta)
    end
    if window.document.readyState == "complete" then
        quandoCarregar(nil)
    else
        window:addEventListener("load", quandoCarregar, {once = true})
    end
    local function pular(____, e)
        local ____this_5
        ____this_5 = e
        local ____opt_4 = ____this_5.preventDefault
        if ____opt_4 ~= nil then
            ____opt_4(____this_5)
        end
        local ____this_7
        ____this_7 = e
        local ____opt_6 = ____this_7.stopPropagation
        if ____opt_6 ~= nil then
            ____opt_6(____this_7)
        end
        if __t(carregado) then
            sair(nil)
        else
            pularPedido = true
        end
    end
    el:addEventListener("pointerdown", pular)
    window:addEventListener(
        "keydown",
        function(____, e)
            local ____t_11 = __t
            local ____t_result_10
            local ____t_9 = __t
            local ____temp_8 = window.document:getElementById("abertura")
            __O[1] = ____temp_8
            if ____t_9(____temp_8) then
                ____t_result_10 = not __t(saindo)
            else
                ____t_result_10 = __O[1]
            end
            if ____t_11(____t_result_10) then
                pular(nil, e)
            end
        end,
        true
    )
    window:setTimeout(
        function()
            if not __t(saindo) then
                __call(el.classList, "add", "ab-pronto")
                sair(nil)
            end
        end,
        15000
    )
end)(nil)
return ____exports
