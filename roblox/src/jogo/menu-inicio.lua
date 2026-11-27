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
        b.textContent = if __t(v) then "－ MENOS MODOS" else "＋ MAIS MODOS"
    end
    local ____ = "use strict"
    local tela = window.document:getElementById("startScreen")
    local ____t_2 = __t
    local ____t_1 = __t
    local ____temp_0 = not __t(tela)
    __O[3169] = ____temp_0
    if ____t_2(if ____t_1(____temp_0) then __O[3169] else window.MenuInicio) then
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
        local ____t_5 = __t
        local ____t_4 = __t
        local ____temp_3 = b == jogar or b == multi
        __O[3170] = ____temp_3
        if ____t_5(if ____t_4(____temp_3) then __O[3170] else b.id == "adventureInfoBtn") then
            return menu
        end
        if __t(b.id == "startBtn" or b.id == "continueBtn") then
            return c1
        end
        if __t(b:hasAttribute("data-open-campanha2")) then
            return c2
        end
        local ____t_8 = __t
        local ____t_7 = __t
        local ____temp_6 = b:hasAttribute("data-open-arena")
        __O[3171] = ____temp_6
        if ____t_8(if ____t_7(____temp_6) then __O[3171] else b:hasAttribute("data-open-tv")) then
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
                local ____iter_18 = __iter
                local ____arr_17 = __arr
                local ____array_16 = __TS__SparseArrayNew(__TS__Spread(__iter(menu.children)))
                __TS__SparseArrayPush(
                    ____array_16,
                    __TS__Spread(__iter(if __t(listaVelha) then __arr(__TS__Spread(__iter(listaVelha.children))) else __arrL({}, 0)))
                )
                for ____, b in __TS__Iterator(____iter_18(____arr_17(__TS__SparseArraySpread(____array_16)))) do
                    if b.tagName ~= "BUTTON" then
                        continue
                    end
                    local d = destino(nil, b)
                    if d == nil then
                        b:remove()
                        continue
                    end
                    local ____opt_11 = __call(
                        __arr(__TS__Spread(__iter(b.attributes))),
                        "find",
                        function(____, a) return __call(a.name, "startsWith", "data-open-") end
                    )
                    if ____opt_11 ~= nil then
                        ____opt_11 = ____opt_11.name
                    end
                    local chave = ____opt_11
                    local ____t_15 = __t
                    local ____t_14 = __t
                    local ____temp_13 = if __t(chave) then b.parentElement ~= d else chave
                    __O[3172] = ____temp_13
                    if ____t_15(if ____t_14(____temp_13) then painel:querySelector(("[" .. tostring(chave)) .. "]") else __O[3172]) then
                        b:remove()
                        continue
                    end
                    if d ~= b.parentElement then
                        d:appendChild(b)
                    end
                end
                local diario = window.document:getElementById("adventureInfoBtn")
                if menu.firstElementChild ~= jogar then
                    menu:prepend(jogar)
                end
                if jogar.nextElementSibling ~= multi then
                    jogar:after(multi)
                end
                if __t(if __t(diario) then multi.nextElementSibling ~= diario else diario) then
                    multi:after(diario)
                end
                local cont = window.document:getElementById("continueBtn")
                local ini = window.document:getElementById("startBtn")
                local ____t_23 = __t
                local ____t_22 = __t
                local ____t_20 = __t
                local ____temp_19 = if __t(cont) then ini else cont
                __O[3173] = ____temp_19
                local ____temp_21 = if ____t_20(____temp_19) then cont.parentElement == c1 else __O[3173]
                __O[3174] = ____temp_21
                if ____t_23(if ____t_22(____temp_21) then cont.nextElementSibling ~= ini else __O[3174]) then
                    c1:insertBefore(cont, ini)
                end
                if __t(if __t(listaVelha) then not __t(listaVelha.hidden) else listaVelha) then
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
        local ____t_29 = __t
        local ____opt_26 = window.Campanha2
        if ____opt_26 ~= nil then
            ____opt_26 = ____opt_26.liberada
        end
        local ____opt_result_28
        if ____opt_26 ~= nil then
            ____opt_result_28 = ____opt_26(____opt_26)
        end
        local ok = not not ____t_29(____opt_result_28)
        local b = c2:querySelector("[data-open-campanha2]")
        _____24(nil, ".me-c2-info").textContent = if __t(ok) then "Um ano depois · a busca pelo Jorge" else "🔒 Termine a Campanha 1 para liberar"
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
                sm.textContent = if __t(ok) then "Um ano depois · a busca pelo Jorge" else "Termine a Campanha 1"
            end
        end
    end
    local function abrir(self, pg)
        arrumar(nil)
        travaC2(nil)
        painel.hidden = false
        painel.dataset.pg = pg
        _____24(nil, ".me-titulo").textContent = if pg == "multi" then "MULTIPLAYER" else "JOGAR"
        for ____, p in __iterar((painel:querySelectorAll(".me-pagina"))) do
            p.hidden = p.dataset.pg ~= pg
        end
        mais(nil, false)
        window:requestAnimationFrame(function()
            local ____opt_30 = painel:querySelector((".me-pagina[data-pg=\"" .. tostring(pg)) .. "\"] button:not([hidden]):not([disabled])")
            return ____opt_30 and ____opt_30:focus()
        end)
    end
    local function fechar(self)
        painel.hidden = true
        local ____opt_32 = jogar.focus
        if ____opt_32 ~= nil then
            ____opt_32(jogar, {preventScroll = true})
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
            if __t(if __t(tela.hidden) then tela.hidden else window:getComputedStyle(tela).display == "none") then
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
