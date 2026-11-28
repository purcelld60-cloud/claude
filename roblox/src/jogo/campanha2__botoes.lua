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
            local ____self_3 = window.JSON
            local ____self_3_parse_4 = ____self_3.parse
            local ____t_result_2
            local ____t_1 = __t
            local ____temp_0 = window.localStorage:getItem(KEY)
            __O[902] = ____temp_0
            if ____t_1(____temp_0) then
                ____t_result_2 = __O[902]
            else
                ____t_result_2 = "null"
            end
            local r = ____self_3_parse_4(____self_3, ____t_result_2)
            local ____t_6 = __t
            local ____t_result_5
            if __t(r) then
                ____t_result_5 = type(r) == "table"
            else
                ____t_result_5 = r
            end
            if ____t_6(____t_result_5) then
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
        local ____t_result_10
        local ____t_9 = __t
        local ____opt_7 = tela:closest(".c2j")
        if ____opt_7 ~= nil then
            ____opt_7 = ____opt_7:querySelector(".c2-c1-shell")
        end
        __O[903] = ____opt_7
        if ____t_9(____opt_7) then
            ____t_result_10 = __O[903]
        else
            ____t_result_10 = tela:querySelector(".c2-c1-shell")
        end
        local c1 = ____t_result_10
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
        local ____opt_11 = tela:querySelector(".c2-treino-ctl")
        if ____opt_11 ~= nil then
            ____opt_11.classList:toggle("livre", tem)
        end
        for ____, ____value in __iterar((alvos(nil, tela))) do
            local id = ____value[1]
            local el = ____value[2]
            do
                local v = __get(L, id)
                local c1 = el:closest(".c2-c1-shell")
                local ____t_14 = __t
                local ____t_result_13
                if __t(c1) then
                    ____t_result_13 = el.dataset.c1Style == nil
                else
                    ____t_result_13 = c1
                end
                if ____t_14(____t_result_13) then
                    local ____el_dataset_18 = el.dataset
                    local ____t_result_17
                    local ____t_16 = __t
                    local ____temp_15 = el:getAttribute("style")
                    __O[904] = ____temp_15
                    if ____t_16(____temp_15) then
                        ____t_result_17 = __O[904]
                    else
                        ____t_result_17 = ""
                    end
                    ____el_dataset_18.c1Style = ____t_result_17
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
                    local ____t_result_24
                    local ____t_23 = __t
                    local ____t_result_21
                    if __t(el.offsetParent) then
                        ____t_result_21 = el.offsetParent
                    else
                        ____t_result_21 = el:closest(".touch-controls")
                    end
                    local ____opt_result_22
                    if ____t_result_21 ~= nil then
                        ____opt_result_22 = ____t_result_21:getBoundingClientRect()
                    end
                    __O[905] = ____opt_result_22
                    if ____t_23(____opt_result_22) then
                        ____t_result_24 = __O[905]
                    else
                        ____t_result_24 = {left = 0, top = 0}
                    end
                    local lay = ____t_result_24
                    local ____t_result_29
                    local ____t_28 = __t
                    local ____t_result_27
                    local ____t_26 = __t
                    local ____TS__ParseFloat_result_25 = __TS__ParseFloat(window:getComputedStyle(el):getPropertyValue("--ccl-size"))
                    __O[906] = ____TS__ParseFloat_result_25
                    if ____t_26(____TS__ParseFloat_result_25) then
                        ____t_result_27 = __O[906]
                    else
                        ____t_result_27 = el:getBoundingClientRect().width
                    end
                    __O[907] = ____t_result_27
                    if ____t_28(____t_result_27) then
                        ____t_result_29 = __O[907]
                    else
                        ____t_result_29 = 50
                    end
                    local base = ____t_result_29
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
                    local ____self_32 = el.style
                    local ____self_32_setProperty_33 = ____self_32.setProperty
                    local ____add_31 = __add
                    local ____t_result_30
                    if __t(v.s) then
                        ____t_result_30 = v.s
                    else
                        ____t_result_30 = 1
                    end
                    ____self_32_setProperty_33(
                        ____self_32,
                        "--ccl-size",
                        ____add_31(
                            math.floor(base * ____t_result_30 + 0.5),
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
                local ____el_style_35 = el.style
                local ____t_result_34
                if __t(v.s) then
                    ____t_result_34 = v.s
                else
                    ____t_result_34 = 1
                end
                ____el_style_35.transform = ("translate(-50%,-50%) scale(" .. tostring(____t_result_34)) .. ")"
            end
        end
    end
    local function fotografar(self, tela)
        local ____t_result_39
        local ____t_38 = __t
        local ____opt_36 = tela:closest(".c2j")
        if ____opt_36 ~= nil then
            ____opt_36 = ____opt_36:querySelector(".c2-c1-shell")
        end
        if ____t_38(____opt_36) then
            ____t_result_39 = {left = 0, top = 0, width = window.innerWidth, height = window.innerHeight}
        else
            ____t_result_39 = tela:getBoundingClientRect()
        end
        local r = ____t_result_39
        local novo = {}
        for ____, ____value in __iterar((alvos(nil, tela))) do
            local id = ____value[1]
            local el = ____value[2]
            do
                local b = el:getBoundingClientRect()
                if not __t(b.width) then
                    continue
                end
                local ____set_47 = __set
                local ____id_46 = id
                local ____TS__Number_result_44 = __TS__Number(__call((b.left + b.width / 2 - r.left) / r.width * 100, "toFixed", 2))
                local ____TS__Number_result_45 = __TS__Number(__call((b.top + b.height / 2 - r.top) / r.height * 100, "toFixed", 2))
                local ____t_result_43
                local ____t_42 = __t
                local ____opt_40 = __get(L, id)
                if ____opt_40 ~= nil then
                    ____opt_40 = ____opt_40.s
                end
                __O[908] = ____opt_40
                if ____t_42(____opt_40) then
                    ____t_result_43 = __O[908]
                else
                    ____t_result_43 = 1
                end
                ____set_47(novo, ____id_46, {x = ____TS__Number_result_44, y = ____TS__Number_result_45, s = ____t_result_43})
            end
        end
        L = novo
        aplicar(nil, tela)
    end
    local function editar(self, tela, aoFechar)
        local ____t_51 = __t
        local ____t_result_50
        local ____t_49 = __t
        local ____temp_48 = not __t(tela)
        __O[909] = ____temp_48
        if ____t_49(____temp_48) then
            ____t_result_50 = __O[909]
        else
            ____t_result_50 = tela:querySelector(".c2-editor")
        end
        if ____t_51(____t_result_50) then
            return
        end
        local joy = tela:querySelector(".joy")
        local ____opt_result_54
        if joy ~= nil then
            ____opt_result_54 = joy.style.display
        end
        local joyDisp = ____opt_result_54
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
            local ____add_59 = __add
            local ____call_58 = __call
            local ____t_result_57
            local ____t_56 = __t
            local ____get_result_55 = __get(NOMES, sel)
            __O[910] = ____get_result_55
            if ____t_56(____get_result_55) then
                ____t_result_57 = __O[910]
            else
                ____t_result_57 = sel
            end
            nome.textContent = ____add_59(
                ____call_58(____t_result_57, "toUpperCase"),
                ":"
            )
            local ____t_result_63
            local ____t_62 = __t
            local ____opt_60 = __get(L, sel)
            if ____opt_60 ~= nil then
                ____opt_60 = ____opt_60.s
            end
            __O[911] = ____opt_60
            if ____t_62(____opt_60) then
                ____t_result_63 = __O[911]
            else
                ____t_result_63 = 1
            end
            range.value = math.floor(____t_result_63 * 100 + 0.5)
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
            local ____t_result_67
            local ____t_66 = __t
            local ____opt_64 = tela:closest(".c2j")
            if ____opt_64 ~= nil then
                ____opt_64 = ____opt_64:querySelector(".c2-c1-shell")
            end
            if ____t_66(____opt_64) then
                ____t_result_67 = {left = 0, top = 0, width = window.innerWidth, height = window.innerHeight}
            else
                ____t_result_67 = tela:getBoundingClientRect()
            end
            local r = ____t_result_67
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
        local ____t_result_70
        local ____t_69 = __t
        local ____temp_68 = tela:closest(".c2j")
        __O[912] = ____temp_68
        if ____t_69(____temp_68) then
            ____t_result_70 = __O[912]
        else
            ____t_result_70 = tela
        end
        local raiz = ____t_result_70
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
                local ____joy_style_72 = joy.style
                local ____t_result_71
                if __t(joyDisp) then
                    ____t_result_71 = joyDisp
                else
                    ____t_result_71 = ""
                end
                ____joy_style_72.display = ____t_result_71
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
                local ____opt_75 = ed:querySelector("[data-a=\"pronto\"]")
                return ____opt_75 and ____opt_75:focus()
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
