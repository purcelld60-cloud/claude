--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __D = {}
local __mod, __arrL, __t, __get, __len, __call, __new, __re, __re_test = __JSR.__mod, __JSR.__arrL, __JSR.__t, __JSR.__get, __JSR.__len, __JSR.__call, __JSR.__new, __JSR.__re, __JSR.__re_test
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    local el = window.document:getElementById("abertura")
    if not __t(el) then
        return
    end
    __D[1] = if __t(if __t(window.navigator.webdriver) then not __re_test(
        __re("[?&]abertura\\b", ""),
        window.location.search
    ) else window.navigator.webdriver) then
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
            if __t(if __t(dica) then not __t(el.classList:contains("ab-pronto")) else dica) then
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
        window:setTimeout(sair, if __t(pularPedido) then 150 else 900)
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
        local ____this_1
        ____this_1 = e
        local ____opt_0 = ____this_1.preventDefault
        if ____opt_0 ~= nil then
            ____opt_0(____this_1)
        end
        local ____this_3
        ____this_3 = e
        local ____opt_2 = ____this_3.stopPropagation
        if ____opt_2 ~= nil then
            ____opt_2(____this_3)
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
            local ____t_6 = __t
            local ____t_5 = __t
            local ____temp_4 = window.document:getElementById("abertura")
            __O[1] = ____temp_4
            if ____t_6(if ____t_5(____temp_4) then not __t(saindo) else __O[1]) then
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
