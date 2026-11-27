--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __ord, __arrL, __iterar, __t, __get, __set, __arr, __len, __call, __add, __iter, __keys = __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__arr, __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__iter, __JSR.__keys
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Spread = ____lualib.__TS__Spread
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__ParseFloat = ____lualib.__TS__ParseFloat
local __TS__Number = ____lualib.__TS__Number
local ____exports = {}
local __O = {};
(function()
    local ____ = "use strict"
    if __t(window.CampanhaBotoes) then
        return
    end
    local KEY = "daroca-c2-layout-v2"
    local L = {}
    do
        pcall(function()
            local ____self_2 = window.JSON
            local ____self_2_parse_3 = ____self_2.parse
            local ____t_1 = __t
            local ____temp_0 = window.localStorage:getItem(KEY)
            __O[873] = ____temp_0
            local r = ____self_2_parse_3(____self_2, if ____t_1(____temp_0) then __O[873] else "null")
            if __t(if __t(r) then type(r) == "table" else r) then
                L = r
            end
        end)
    end
    local function salvar()
        do
            pcall(function()
                if __t(__len(__keys(L))) then
                    window.localStorage:setItem(
                        KEY,
                        window.JSON:stringify(L)
                    )
                else
                    window.localStorage:removeItem(KEY)
                end
            end)
        end
    end
    local NOMES = __ord({
        joy = "Joystick",
        jump = "Pular",
        paper = "Papel",
        fart = "Peido",
        dash = "Dash",
        interact = "Falar",
        poder1 = "Poder 1",
        poder2 = "Poder 2"
    }, "joy,jump,paper,fart,dash,interact,poder1,poder2")
    local function alvos(____, tela)
        local ____t_6 = __t
        local ____opt_4 = tela:closest(".c2j")
        if ____opt_4 ~= nil then
            ____opt_4 = ____opt_4:querySelector(".c2-c1-shell")
        end
        __O[874] = ____opt_4
        local c1 = if ____t_6(____opt_4) then __O[874] else tela:querySelector(".c2-c1-shell")
        if __t(c1) then
            return __call(
                __arr(
                    __arrL(
                        {
                            "joy",
                            c1:querySelector(".move-joystick")
                        },
                        2
                    ),
                    __TS__Spread(__iter(__call(
                        __arr(__TS__Spread(__iter(c1:querySelectorAll("[data-action]")))),
                        "map",
                        function(____, b) return __arrL({b.dataset.action, b}, 2) end
                    )))
                ),
                "filter",
                function(____, x) return __get(x, 1) end
            )
        end
        return __call(
            __arr(
                __arrL(
                    {
                        "joy",
                        tela:querySelector(".joy")
                    },
                    2
                ),
                __TS__Spread(__iter(__call(
                    __arr(__TS__Spread(__iter(tela:querySelectorAll(".c2-treino-ctl [data-acao]")))),
                    "map",
                    function(____, b) return __arrL({b.dataset.acao, b}, 2) end
                )))
            ),
            "filter",
            function(____, x) return __get(x, 1) end
        )
    end
    local function clamp(____, v, a, b)
        return math.max(
            a,
            math.min(b, v)
        )
    end
    local function aplicar(self, tela)
        if not __t(tela) then
            return
        end
        local tem = __len(__keys(L)) > 0
        local ____opt_7 = tela:querySelector(".c2-treino-ctl")
        if ____opt_7 ~= nil then
            ____opt_7.classList:toggle("livre", tem)
        end
        for ____, ____value in __iterar((alvos(nil, tela))) do
            local id = ____value[1]
            local el = ____value[2]
            local v = __get(L, id)
            local c1 = el:closest(".c2-c1-shell")
            if __t(if __t(c1) then el.dataset.c1Style == nil else c1) then
                local ____el_dataset_11 = el.dataset
                local ____t_10 = __t
                local ____temp_9 = el:getAttribute("style")
                __O[875] = ____temp_9
                ____el_dataset_11.c1Style = if ____t_10(____temp_9) then __O[875] else ""
            end
            if __t(not __t(tem) or not __t(v)) then
                el.classList:remove("c2-livre")
                if __t(c1) then
                    el:setAttribute("style", el.dataset.c1Style)
                else
                    for ____, k in __iterar((__arrL({
                        "left",
                        "top",
                        "right",
                        "bottom",
                        "transform",
                        "margin",
                        "position"
                    }, 7))) do
                        __set(el.style, k, "")
                    end
                end
                continue
            end
            if __t(c1) then
                el:setAttribute("style", el.dataset.c1Style)
                local ____t_14 = __t
                local ____opt_12 = if __t(el.offsetParent) then el.offsetParent else el:closest(".touch-controls")
                if ____opt_12 ~= nil then
                    ____opt_12 = ____opt_12:getBoundingClientRect()
                end
                __O[876] = ____opt_12
                local lay = if ____t_14(____opt_12) then __O[876] else {left = 0, top = 0}
                local ____t_18 = __t
                local ____t_16 = __t
                local ____TS__ParseFloat_result_15 = __TS__ParseFloat(window:getComputedStyle(el):getPropertyValue("--ccl-size"))
                __O[877] = ____TS__ParseFloat_result_15
                local ____temp_17 = if ____t_16(____TS__ParseFloat_result_15) then __O[877] else el:getBoundingClientRect().width
                __O[878] = ____temp_17
                local base = if ____t_18(____temp_17) then __O[878] else 50
                el.style:setProperty(
                    "--ccl-x",
                    __add(
                        __call(v.x / 100 * window.innerWidth - lay.left, "toFixed", 1),
                        "px"
                    )
                )
                el.style:setProperty(
                    "--ccl-y",
                    __add(
                        __call(v.y / 100 * window.innerHeight - lay.top, "toFixed", 1),
                        "px"
                    )
                )
                el.style:setProperty(
                    "--ccl-size",
                    __add(
                        math.floor(base * if __t(v.s) then v.s else 1 + 0.5),
                        "px"
                    )
                )
                __call(el.classList, "add", "c2-livre")
                continue
            end
            __call(el.classList, "add", "c2-livre")
            el.style.left = __add(v.x, "%")
            el.style.top = __add(v.y, "%")
            el.style.right = "auto"
            el.style.bottom = "auto"
            el.style.margin = "0"
            el.style.transform = ("translate(-50%,-50%) scale(" .. tostring(if __t(v.s) then v.s else 1)) .. ")"
        end
    end
    local function fotografar(self, tela)
        local ____t_21 = __t
        local ____opt_19 = tela:closest(".c2j")
        if ____opt_19 ~= nil then
            ____opt_19 = ____opt_19:querySelector(".c2-c1-shell")
        end
        local r = if ____t_21(____opt_19) then {left = 0, top = 0, width = window.innerWidth, height = window.innerHeight} else tela:getBoundingClientRect()
        local novo = {}
        for ____, ____value in __iterar((alvos(nil, tela))) do
            local id = ____value[1]
            local el = ____value[2]
            local b = el:getBoundingClientRect()
            if not __t(b.width) then
                continue
            end
            local ____set_28 = __set
            local ____id_27 = id
            local ____TS__Number_result_25 = __TS__Number(__call((b.left + b.width / 2 - r.left) / r.width * 100, "toFixed", 2))
            local ____TS__Number_result_26 = __TS__Number(__call((b.top + b.height / 2 - r.top) / r.height * 100, "toFixed", 2))
            local ____t_24 = __t
            local ____opt_22 = __get(L, id)
            if ____opt_22 ~= nil then
                ____opt_22 = ____opt_22.s
            end
            __O[879] = ____opt_22
            ____set_28(novo, ____id_27, {x = ____TS__Number_result_25, y = ____TS__Number_result_26, s = if ____t_24(____opt_22) then __O[879] else 1})
        end
        L = novo
        aplicar(nil, tela)
    end
    local function editar(self, tela, aoFechar)
        local ____t_31 = __t
        local ____t_30 = __t
        local ____temp_29 = not __t(tela)
        __O[880] = ____temp_29
        if ____t_31(if ____t_30(____temp_29) then __O[880] else tela:querySelector(".c2-editor")) then
            return
        end
        local joy = tela:querySelector(".joy")
        local ____opt_result_34
        if joy ~= nil then
            ____opt_result_34 = joy.style.display
        end
        local joyDisp = ____opt_result_34
        if __t(joy) then
            joy.style.display = "block"
        end
        local tinha = __len(__keys(L)) > 0
        fotografar(nil, tela)
        __call(tela.classList, "add", "c2-editando")
        local sel = "joy"
        local arrasta = nil
        local mexeu = tinha
        local ed = window.document:createElement("div")
        ed.className = "c2-editor"
        ed.innerHTML = "<div class=\"barra\"><b>ARRASTE OS BOTÕES PARA ONDE QUISER</b><span class=\"nome\"></span><label>TAMANHO <input type=\"range\" min=\"60\" max=\"170\" step=\"5\"></label><button type=\"button\" data-a=\"restaurar\">RESTAURAR</button><button type=\"button\" data-a=\"pronto\">PRONTO</button></div>"
        tela:appendChild(ed)
        local range = ed:querySelector("input")
        local nome = ed:querySelector(".nome")
        local function marcar()
            for ____, ____value in __iterar((alvos(nil, tela))) do
                local id = ____value[1]
                local el = ____value[2]
                el.classList:toggle("c2-sel", id == sel)
            end
            local ____add_38 = __add
            local ____call_37 = __call
            local ____t_36 = __t
            local ____get_result_35 = __get(NOMES, sel)
            __O[881] = ____get_result_35
            nome.textContent = ____add_38(
                ____call_37(if ____t_36(____get_result_35) then __O[881] else sel, "toUpperCase"),
                ":"
            )
            local ____t_41 = __t
            local ____opt_39 = __get(L, sel)
            if ____opt_39 ~= nil then
                ____opt_39 = ____opt_39.s
            end
            __O[882] = ____opt_39
            range.value = math.floor(if ____t_41(____opt_39) then __O[882] else 1 * 100 + 0.5)
        end
        range:addEventListener(
            "input",
            function()
                if not __t(__get(L, sel)) then
                    return
                end
                mexeu = true
                __get(L, sel).s = __TS__Number(range.value) / 100
                aplicar(nil, tela)
                salvar(nil)
            end
        )
        local function baixo(____, e)
            local hit = __call(
                alvos(nil, tela),
                "find",
                function(____, ____bindingPattern0)
                    local el
                    el = ____bindingPattern0[2]
                    return el:contains(e.target)
                end
            )
            if not __t(hit) then
                return
            end
            e:preventDefault()
            e:stopPropagation()
            sel = __get(hit, 0)
            marcar(nil)
            arrasta = e.pointerId
        end
        local function move(____, e)
            if __t(arrasta ~= e.pointerId or not __t(__get(L, sel))) then
                return
            end
            mexeu = true
            local ____t_44 = __t
            local ____opt_42 = tela:closest(".c2j")
            if ____opt_42 ~= nil then
                ____opt_42 = ____opt_42:querySelector(".c2-c1-shell")
            end
            local r = if ____t_44(____opt_42) then {left = 0, top = 0, width = window.innerWidth, height = window.innerHeight} else tela:getBoundingClientRect()
            __get(L, sel).x = __TS__Number(__call(
                clamp(nil, (e.clientX - r.left) / r.width * 100, 4, 96),
                "toFixed",
                2
            ))
            __get(L, sel).y = __TS__Number(__call(
                clamp(nil, (e.clientY - r.top) / r.height * 100, 6, 96),
                "toFixed",
                2
            ))
            aplicar(nil, tela)
        end
        local function cima(____, e)
            if arrasta == e.pointerId then
                arrasta = nil
                salvar(nil)
            end
        end
        local function bloqueia(____, e)
            if __t(__call(
                alvos(nil, tela),
                "some",
                function(____, ____bindingPattern0)
                    local el
                    el = ____bindingPattern0[2]
                    return el:contains(e.target)
                end
            )) then
                e:preventDefault()
                e:stopPropagation()
            end
        end
        local ____t_46 = __t
        local ____temp_45 = tela:closest(".c2j")
        __O[883] = ____temp_45
        local raiz = if ____t_46(____temp_45) then __O[883] else tela
        raiz:addEventListener("pointerdown", baixo, true)
        window:addEventListener("pointermove", move)
        window:addEventListener("pointerup", cima, true)
        window:addEventListener("pointercancel", cima, true)
        for ____, ev in __iterar((__arrL({"pointerup", "pointerleave", "click", "touchstart"}, 4))) do
            raiz:addEventListener(ev, bloqueia, true)
        end
        local function fechar()
            raiz:removeEventListener("pointerdown", baixo, true)
            window:removeEventListener("pointermove", move)
            window:removeEventListener("pointerup", cima, true)
            window:removeEventListener("pointercancel", cima, true)
            for ____, ev in __iterar((__arrL({"pointerup", "pointerleave", "click", "touchstart"}, 4))) do
                raiz:removeEventListener(ev, bloqueia, true)
            end
            ed:remove()
            tela.classList:remove("c2-editando")
            for ____, ____value in __iterar((alvos(nil, tela))) do
                local el = ____value[2]
                el.classList:remove("c2-sel")
            end
            if __t(joy) then
                joy.style.display = if __t(joyDisp) then joyDisp else ""
            end
            if not __t(mexeu) then
                L = {}
            end
            salvar(nil)
            aplicar(nil, tela)
            if aoFechar ~= nil then
                aoFechar(nil)
            end
        end
        ed:querySelector("[data-a=\"pronto\"]"):addEventListener("click", fechar)
        ed:querySelector("[data-a=\"restaurar\"]"):addEventListener(
            "click",
            function()
                L = {}
                salvar(nil)
                aplicar(nil, tela)
                fotografar(nil, tela)
                mexeu = false
                marcar(nil)
            end
        )
        marcar(nil)
        window:setTimeout(
            function()
                local ____opt_49 = ed:querySelector("[data-a=\"pronto\"]")
                return ____opt_49 and ____opt_49:focus()
            end,
            30
        )
    end
    window.CampanhaBotoes = __ord(
        {
            aplicar = aplicar,
            editar = editar,
            layout = function() return window.JSON:parse(window.JSON:stringify(L)) end,
            zerar = function()
                L = {}
                salvar(nil)
            end
        },
        "aplicar,editar,layout,zerar"
    )
end)(nil)
return ____exports
