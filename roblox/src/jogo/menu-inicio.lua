--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __ord, __arrL, __iterar, __t, __arr, __len, __call, __new, __iter = __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__arr, __JSR.__len, __JSR.__call, __JSR.__new, __JSR.__iter
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Spread = ____lualib.__TS__Spread
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local __TS__Iterator = ____lualib.__TS__Iterator
local ____exports = {}
local __O = {};
(function()
    local mais, _____24, extra
    function mais(self, v)
        extra.hidden = not __t(v)
        local b = _____24(nil, ".me-mais")
        b:setAttribute(
            "aria-expanded",
            tostring(v)
        )
        b.textContent = __t(v) and "－ MENOS MODOS" or "＋ MAIS MODOS"
    end
    local ____ = "use strict"
    local tela = window.document:getElementById("startScreen")
    local ____t_3 = __t
    local ____t_result_2
    local ____t_1 = __t
    local ____temp_0 = not __t(tela)
    __O[3214] = ____temp_0
    if ____t_1(____temp_0) then
        ____t_result_2 = __O[3214]
    else
        ____t_result_2 = window.MenuInicio
    end
    if ____t_3(____t_result_2) then
        return
    end
    local menu = tela:querySelector(".start-menu")
    local listaVelha = tela:querySelector(".ranch-mode-entries")
    if not __t(menu) then
        return
    end
    local function novo(____, id, cls, html)
        local b = window.document:createElement("button")
        b.type = "button"
        b.id = id
        b.className = cls
        b.innerHTML = html
        return b
    end
    local jogar = novo(nil, "menuJogarBtn", "primary-btn title-start menu-jogar", "<span>▶</span> JOGAR")
    local multi = novo(nil, "menuMultiBtn", "menu-coop-button menu-multi", "<b aria-hidden=\"true\">👥</b> MULTIPLAYER")
    local painel = window.document:createElement("div")
    painel.className = "menu-escolha"
    painel.hidden = true
    painel:setAttribute("role", "dialog")
    painel.innerHTML = "<div class=\"me-caixa\"><h3 class=\"me-titulo\"></h3>\n    <div class=\"me-pagina\" data-pg=\"jogar\">\n      <div class=\"me-camp me-c1\"><b>CAMPANHA 1 · ITABUNA</b><small>A missão do bolo de sapo</small><div class=\"me-bts\"></div></div>\n      <div class=\"me-camp me-c2\"><b>CAMPANHA 2 · VITÓRIA DA CONQUISTA</b><small class=\"me-c2-info\"></small><div class=\"me-bts ranch-mode-entries\"></div></div>\n      <button type=\"button\" class=\"me-mais\" aria-expanded=\"false\">＋ MAIS MODOS</button>\n      <div class=\"me-extra ranch-mode-entries\" hidden></div>\n    </div>\n    <div class=\"me-pagina\" data-pg=\"multi\"><div class=\"me-lista ranch-mode-entries\"></div></div>\n    <button type=\"button\" class=\"me-voltar\">◀ VOLTAR</button></div>"
    tela:appendChild(painel)
    _____24 = function(____, s) return painel:querySelector(s) end
    local c1 = _____24(nil, ".me-c1 .me-bts")
    local c2 = _____24(nil, ".me-c2 .me-bts")
    extra = _____24(nil, ".me-extra")
    local multiLista = _____24(nil, ".me-lista")
    local function destino(self, b)
        local ____t_7 = __t
        local ____t_result_6
        local ____t_5 = __t
        local ____temp_4 = b == jogar or b == multi
        __O[3215] = ____temp_4
        if ____t_5(____temp_4) then
            ____t_result_6 = __O[3215]
        else
            ____t_result_6 = b.id == "adventureInfoBtn"
        end
        if ____t_7(____t_result_6) then
            return menu
        end
        if __t(b.id == "startBtn" or b.id == "continueBtn") then
            return c1
        end
        if __t(b:hasAttribute("data-open-campanha2")) then
            return c2
        end
        local ____t_11 = __t
        local ____t_result_10
        local ____t_9 = __t
        local ____temp_8 = b:hasAttribute("data-open-arena")
        __O[3216] = ____temp_8
        if ____t_9(____temp_8) then
            ____t_result_10 = __O[3216]
        else
            ____t_result_10 = b:hasAttribute("data-open-tv")
        end
        if ____t_11(____t_result_10) then
            return multiLista
        end
        if b.id == "partyEntryBtn" then
            return nil
        end
        return extra
    end
    local obs = nil
    local function arrumar(self)
        if obs ~= nil then
            obs:disconnect()
        end
        do
            local ____try, ____error = pcall(function()
                local ____iter_24 = __iter
                local ____arr_23 = __arr
                local ____array_22 = __TS__SparseArrayNew(__TS__Spread(__iter(menu.children)))
                local ____iter_21 = __iter
                local ____t_result_20
                if __t(listaVelha) then
                    ____t_result_20 = __arr(__TS__Spread(__iter(listaVelha.children)))
                else
                    ____t_result_20 = __arrL({}, 0)
                end
                __TS__SparseArrayPush(
                    ____array_22,
                    __TS__Spread(____iter_21(____t_result_20))
                )
                for ____, b in __TS__Iterator(____iter_24(____arr_23(__TS__SparseArraySpread(____array_22)))) do
                    do
                        if b.tagName ~= "BUTTON" then
                            continue
                        end
                        local d = destino(nil, b)
                        if d == nil then
                            b:remove()
                            continue
                        end
                        local ____opt_14 = __call(
                            __arr(__TS__Spread(__iter(b.attributes))),
                            "find",
                            function(____, a) return __call(a.name, "startsWith", "data-open-") end
                        )
                        if ____opt_14 ~= nil then
                            ____opt_14 = ____opt_14.name
                        end
                        local chave = ____opt_14
                        local ____t_19 = __t
                        local ____t_result_18
                        local ____t_17 = __t
                        local ____t_result_16
                        if __t(chave) then
                            ____t_result_16 = b.parentElement ~= d
                        else
                            ____t_result_16 = chave
                        end
                        __O[3217] = ____t_result_16
                        if ____t_17(____t_result_16) then
                            ____t_result_18 = painel:querySelector(("[" .. tostring(chave)) .. "]")
                        else
                            ____t_result_18 = __O[3217]
                        end
                        if ____t_19(____t_result_18) then
                            b:remove()
                            continue
                        end
                        if d ~= b.parentElement then
                            d:appendChild(b)
                        end
                    end
                end
                local diario = window.document:getElementById("adventureInfoBtn")
                if menu.firstElementChild ~= jogar then
                    menu:prepend(jogar)
                end
                if jogar.nextElementSibling ~= multi then
                    jogar:after(multi)
                end
                local ____t_26 = __t
                local ____t_result_25
                if __t(diario) then
                    ____t_result_25 = multi.nextElementSibling ~= diario
                else
                    ____t_result_25 = diario
                end
                if ____t_26(____t_result_25) then
                    multi:after(diario)
                end
                local cont = window.document:getElementById("continueBtn")
                local ini = window.document:getElementById("startBtn")
                local ____t_32 = __t
                local ____t_result_31
                local ____t_30 = __t
                local ____t_result_29
                local ____t_28 = __t
                local ____t_result_27
                if __t(cont) then
                    ____t_result_27 = ini
                else
                    ____t_result_27 = cont
                end
                __O[3218] = ____t_result_27
                if ____t_28(____t_result_27) then
                    ____t_result_29 = cont.parentElement == c1
                else
                    ____t_result_29 = __O[3218]
                end
                __O[3219] = ____t_result_29
                if ____t_30(____t_result_29) then
                    ____t_result_31 = cont.nextElementSibling ~= ini
                else
                    ____t_result_31 = __O[3219]
                end
                if ____t_32(____t_result_31) then
                    c1:insertBefore(cont, ini)
                end
                local ____t_34 = __t
                local ____t_result_33
                if __t(listaVelha) then
                    ____t_result_33 = not __t(listaVelha.hidden)
                else
                    ____t_result_33 = listaVelha
                end
                if ____t_34(____t_result_33) then
                    listaVelha.hidden = true
                end
                _____24(nil, ".me-mais").hidden = not __t(__len(extra.children))
            end)
            do
                if __t(obs) then
                    obs:observe(menu, {childList = true})
                    if __t(listaVelha) then
                        obs:observe(listaVelha, {childList = true})
                    end
                end
            end
            if not ____try then
                error(____error, 0)
            end
        end
    end
    local function travaC2(self)
        local ____t_40 = __t
        local ____opt_37 = window.Campanha2
        if ____opt_37 ~= nil then
            ____opt_37 = ____opt_37.liberada
        end
        local ____opt_result_39
        if ____opt_37 ~= nil then
            ____opt_result_39 = ____opt_37(____opt_37)
        end
        local ok = not not ____t_40(____opt_result_39)
        local b = c2:querySelector("[data-open-campanha2]")
        _____24(nil, ".me-c2-info").textContent = __t(ok) and "Um ano depois · a busca pelo Jorge" or "🔒 Termine a Campanha 1 para liberar"
        painel:querySelector(".me-c2").classList:toggle(
            "travada",
            not __t(ok)
        )
        if __t(b) then
            b.disabled = not __t(ok)
            b:setAttribute(
                "aria-disabled",
                tostring(not __t(ok))
            )
            local sm = b:querySelector("small")
            if __t(sm) then
                sm.textContent = __t(ok) and "Um ano depois · a busca pelo Jorge" or "Termine a Campanha 1"
            end
        end
    end
    local function abrir(self, pg)
        arrumar(nil)
        travaC2(nil)
        painel.hidden = false
        painel.dataset.pg = pg
        _____24(nil, ".me-titulo").textContent = pg == "multi" and "MULTIPLAYER" or "JOGAR"
        for ____, p in __iterar((painel:querySelectorAll(".me-pagina"))) do
            p.hidden = p.dataset.pg ~= pg
        end
        mais(nil, false)
        window:requestAnimationFrame(function()
            local ____opt_41 = painel:querySelector((".me-pagina[data-pg=\"" .. tostring(pg)) .. "\"] button:not([hidden]):not([disabled])")
            return ____opt_41 and ____opt_41:focus()
        end)
    end
    local function fechar(self)
        painel.hidden = true
        local ____opt_43 = jogar.focus
        if ____opt_43 ~= nil then
            ____opt_43(jogar, {preventScroll = true})
        end
    end
    jogar:addEventListener(
        "click",
        function() return abrir(nil, "jogar") end
    )
    multi:addEventListener(
        "click",
        function() return abrir(nil, "multi") end
    )
    _____24(nil, ".me-voltar"):addEventListener("click", fechar)
    _____24(nil, ".me-mais"):addEventListener(
        "click",
        function() return mais(nil, extra.hidden) end
    )
    painel:addEventListener(
        "keydown",
        function(____, e)
            if e.key == "Escape" then
                e:preventDefault()
                e:stopPropagation()
                fechar(nil)
            end
        end
    )
    painel:addEventListener(
        "click",
        function(____, e)
            if e.target == painel then
                fechar(nil)
            end
        end
    )
    __new(
        "MutationObserver",
        function()
            local ____t_46 = __t
            local ____t_result_45
            if __t(tela.hidden) then
                ____t_result_45 = tela.hidden
            else
                ____t_result_45 = window:getComputedStyle(tela).display == "none"
            end
            if ____t_46(____t_result_45) then
                painel.hidden = true
            end
        end
    ):observe(
        tela,
        __ord(
            {
                attributes = true,
                attributeFilter = __arrL({"hidden", "style", "class"}, 3)
            },
            "attributes,attributeFilter"
        )
    )
    obs = __new(
        "MutationObserver",
        function() return arrumar(nil) end
    )
    arrumar(nil)
    if window.document.readyState == "loading" then
        window:addEventListener("DOMContentLoaded", arrumar)
    end
    window:addEventListener("load", arrumar)
    window.MenuInicio = __ord({abrir = abrir, fechar = fechar, arrumar = arrumar}, "abrir,fechar,arrumar")
end)(nil)
return ____exports
