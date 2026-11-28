--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __getq, __ord, __arrL, __iterar, __t, __get, __set, __call, __add, __new, __keys, __assign = __JSR.__getq, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__call, __JSR.__add, __JSR.__new, __JSR.__keys, __JSR.__assign
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Iterator = ____lualib.__TS__Iterator
local ____exports = {}
local __O = {};
(function()
    local effectiveLook, build, render, drawPreview, open, close, updateInventory, DEFAULT, OPTIONS, look, unlocked, save, jaglionStatus, TRAJES, statusTraje, cobre, isDefault, panel, preview, raf, onClose, t0, ROWS
    function effectiveLook(self)
        local ____t_result_17
        if __t(look.costume ~= "normal" and statusTraje(nil, look.costume) ~= "ready") then
            ____t_result_17 = __assign({}, look, {costume = "normal"})
        else
            ____t_result_17 = look
        end
        return ____t_result_17
    end
    function build(self)
        if __t(panel) then
            return
        end
        panel = window.document:createElement("div")
        panel.id = "visualPanel"
        panel.className = "visual-panel"
        panel.hidden = true
        panel:setAttribute("role", "dialog")
        panel:setAttribute("aria-label", "Espelho da Bigodon")
        panel.innerHTML = "<div class=\"vp-box\"><div class=\"vp-head\"><b>ESPELHO DA BIGODON</b><span class=\"vp-davi\"></span></div><div class=\"vp-body\"><div class=\"vp-mirror\"><canvas width=\"200\" height=\"230\" aria-hidden=\"true\"></canvas><small class=\"vp-note\"></small></div><div class=\"vp-rows\"></div></div><div class=\"vp-actions\"><button type=\"button\" class=\"vp-reset\">PADRÃO</button><button type=\"button\" class=\"vp-done primary-btn\">PRONTO</button></div></div>"
        local ____t_result_34
        local ____t_33 = __t
        local ____temp_32 = window.document:getElementById("gameShell")
        __O[136] = ____temp_32
        if ____t_33(____temp_32) then
            ____t_result_34 = __O[136]
        else
            ____t_result_34 = window.document.body
        end
        ____t_result_34:append(panel)
        preview = panel:querySelector("canvas")
        panel:querySelector(".vp-done"):addEventListener("click", close)
        panel:querySelector(".vp-reset"):addEventListener(
            "click",
            function()
                look = __assign({}, DEFAULT)
                save(nil)
                render(nil)
            end
        )
        panel:addEventListener(
            "keydown",
            function(____, e)
                if e.key == "Escape" then
                    e:preventDefault()
                    close(nil)
                end
                e:stopPropagation()
            end
        )
        render(nil)
    end
    function render(self)
        local rows = panel:querySelector(".vp-rows")
        rows.innerHTML = ""
        local outfit = effectiveLook(nil)
        local status = jaglionStatus(nil)
        local traje = outfit.costume
        local hint = status == "reserved" and "Seu Jaglion está pronto. Fale com Davi na Bigodon para recebê-lo." or "Para ganhar o Jaglion, encontre Amanda na entrada da Praça Camacan e aceite o jantar."
        for ____, ____value in __iterar((ROWS)) do
            local key = ____value[1]
            local label = ____value[2]
            do
                if __t(key == "hatColor" and outfit.hat ~= "bone") then
                    continue
                end
                local row = window.document:createElement("div")
                row.className = __add(
                    "vp-row",
                    __t(cobre(nil, traje, key)) and " is-off" or ""
                )
                row.innerHTML = __add(
                    __add("<span>", label),
                    "</span>"
                )
                local list = window.document:createElement("div")
                list.className = "vp-opts"
                for ____, ____value in __iterar((__get(OPTIONS, key))) do
                    local val = ____value[1]
                    local name = ____value[2]
                    local light = ____value[3]
                    local b = window.document:createElement("button")
                    b.type = "button"
                    local color = __call(val, "startsWith", "#")
                    b.className = __add(
                        __add(
                            "vp-opt",
                            __t(color) and " vp-swatch" or ""
                        ),
                        __get(outfit, key) == val and " on" or ""
                    )
                    b:setAttribute(
                        "aria-pressed",
                        __get(outfit, key) == val and "true" or "false"
                    )
                    if __t(color) then
                        b.style:setProperty("--sw", val)
                        b.title = name
                        b:setAttribute(
                            "aria-label",
                            __add(
                                __add(
                                    __call(label, "toLowerCase"),
                                    " "
                                ),
                                name
                            )
                        )
                    else
                        b.textContent = name
                    end
                    if val == "jaglion" then
                        __call(b.classList, "add", "vp-lion")
                        if status ~= "ready" then
                            b.textContent = status == "reserved" and "JAGLION · RESERVADO" or "JAGLION · BLOQUEADO"
                            b.title = hint
                        end
                    elseif __t(key == "costume" and val ~= "normal") then
                        __call(b.classList, "add", "vp-lion")
                        if statusTraje(nil, val) ~= "ready" then
                            b.textContent = __add(name, " · BLOQUEADO")
                            b.title = __get(TRAJES, val).dica
                        end
                    end
                    local ____t_result_37
                    local ____t_36 = __t
                    local ____temp_35 = key == "costume" and statusTraje(nil, val) ~= "ready"
                    __O[137] = ____temp_35
                    if ____t_36(____temp_35) then
                        ____t_result_37 = __O[137]
                    else
                        ____t_result_37 = cobre(nil, traje, key)
                    end
                    b.disabled = ____t_result_37
                    b:addEventListener(
                        "click",
                        function()
                            __set(look, key, val)
                            if key == "shirt" then
                                local ____look_39 = look
                                local ____t_result_38
                                if __t(light) then
                                    ____t_result_38 = light
                                else
                                    ____t_result_38 = look.shirtLight
                                end
                                ____look_39.shirtLight = ____t_result_38
                            end
                            save(nil)
                            render(nil)
                            local ____opt_42 = panel:querySelector(("[data-k=\"" .. tostring(key)) .. "\"] .on")
                            if ____opt_42 ~= nil then
                                ____opt_42 = ____opt_42.focus
                            end
                            if ____opt_42 ~= nil then
                                ____opt_42(____opt_42)
                            end
                        end
                    )
                    list:append(b)
                end
                row.dataset.k = key
                row:append(list)
                rows:append(row)
            end
        end
        local falta = __call(
            __arrL({"dajegue", "caipira", "farda"}, 3),
            "find",
            function(____, k) return statusTraje(nil, k) ~= "ready" end
        )
        local ____temp_47 = panel:querySelector(".vp-note")
        local ____t_result_46
        if __t(__get(TRAJES, traje)) then
            ____t_result_46 = __get(TRAJES, traje).nota
        else
            local ____temp_45
            if status ~= "ready" then
                ____temp_45 = hint
            else
                local ____t_result_44
                if __t(falta) then
                    ____t_result_44 = __get(TRAJES, falta).dica
                else
                    ____t_result_44 = __t(isDefault(nil, outfit)) and "O Da Roça de sempre." or "Visual novo, mesma resenha."
                end
                ____temp_45 = ____t_result_44
            end
            ____t_result_46 = ____temp_45
        end
        ____temp_47.textContent = ____t_result_46
    end
    function drawPreview(self, now)
        if __t(panel.hidden) then
            return
        end
        local c = preview:getContext("2d")
        local t = (now - t0) / 1000
        c:setTransform(
            1,
            0,
            0,
            1,
            0,
            0
        )
        c:clearRect(0, 0, 200, 230)
        c.imageSmoothingEnabled = false
        local g = c:createLinearGradient(0, 0, 0, 230)
        g:addColorStop(0, "#cfe3e8")
        g:addColorStop(1, "#9fbcc4")
        c.fillStyle = g
        c:fillRect(0, 0, 200, 230)
        c.fillStyle = "rgba(255,255,255,.35)"
        c:fillRect(24, 0, 10, 230)
        c:fillRect(40, 0, 4, 230)
        c.fillStyle = "rgba(40,60,70,.25)"
        c:fillRect(40, 214, 120, 6)
        do
            pcall(function()
                local ____opt_50 = window.Art
                if ____opt_50 ~= nil then
                    ____opt_50 = ____opt_50.drawCharacter
                end
                if ____opt_50 ~= nil then
                    ____opt_50(
                        ____opt_50,
                        c,
                        "daroca",
                        100,
                        214,
                        {
                            facing = math.sin(t * 0.6) > -0.2 and 1 or -1,
                            frame = t,
                            scale = 2.1,
                            grounded = true
                        }
                    )
                end
            end)
        end
        raf = window:requestAnimationFrame(drawPreview)
    end
    function open(self, opts)
        if opts == nil then
            opts = {}
        end
        build(nil)
        unlocked = true
        save(nil)
        local ____t_result_52
        if __t(opts.onClose) then
            ____t_result_52 = opts.onClose
        else
            ____t_result_52 = nil
        end
        onClose = ____t_result_52
        local ____temp_54 = panel:querySelector(".vp-davi")
        local ____t_result_53
        if __t(opts.line) then
            ____t_result_53 = opts.line
        else
            ____t_result_53 = "Davi: E aí, Da Roça, vai querer o quê hoje?"
        end
        ____temp_54.textContent = ____t_result_53
        local ____temp_56 = panel:querySelector(".vp-head b")
        local ____t_result_55
        if __t(opts.title) then
            ____t_result_55 = opts.title
        else
            ____t_result_55 = "ESPELHO DA BIGODON"
        end
        ____temp_56.textContent = ____t_result_55
        local ____panel_58 = panel
        local ____panel_setAttribute_59 = panel.setAttribute
        local ____t_result_57
        if __t(opts.title) then
            ____t_result_57 = opts.title
        else
            ____t_result_57 = "Espelho da Bigodon"
        end
        ____panel_setAttribute_59(____panel_58, "aria-label", ____t_result_57)
        render(nil)
        panel.hidden = false
        t0 = window.performance:now()
        window:cancelAnimationFrame(raf)
        raf = window:requestAnimationFrame(drawPreview)
        window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {active = true}}))
        window:setTimeout(
            function()
                local ____opt_62 = panel:querySelector(".vp-opt.on")
                if ____opt_62 ~= nil then
                    ____opt_62 = ____opt_62.focus
                end
                local ____opt_result_64
                if ____opt_62 ~= nil then
                    ____opt_result_64 = ____opt_62(____opt_62)
                end
                return ____opt_result_64
            end,
            40
        )
        updateInventory(nil)
    end
    function close(self)
        local ____t_68 = __t
        local ____t_result_67
        local ____t_66 = __t
        local ____temp_65 = not __t(panel)
        __O[138] = ____temp_65
        if ____t_66(____temp_65) then
            ____t_result_67 = __O[138]
        else
            ____t_result_67 = panel.hidden
        end
        if ____t_68(____t_result_67) then
            return
        end
        panel.hidden = true
        window:cancelAnimationFrame(raf)
        save(nil)
        window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {active = false}}))
        local ____opt_71 = window.document:getElementById("gameCanvas")
        local ____opt_69 = ____opt_71 and ____opt_71.focus
        if ____opt_69 ~= nil then
            ____opt_69(____opt_71)
        end
        local fn = onClose
        onClose = nil
        if __t(fn) then
            do
                pcall(function()
                    fn(
                        nil,
                        __assign(
                            {},
                            effectiveLook(nil)
                        )
                    )
                end)
            end
        end
    end
    function updateInventory(self)
        local inv = window.document:getElementById("hudInvPanel")
        if __t(not __t(inv) or not __t(unlocked)) then
            return
        end
        if __t(inv:querySelector(".hud-visual")) then
            return
        end
        local row = window.document:createElement("div")
        row.className = "hud-row hud-visual"
        row.innerHTML = "<span>✂ VISUAL</span>"
        local b = window.document:createElement("button")
        b.type = "button"
        b.className = "hud-fliperama-btn"
        b.textContent = "ESPELHO"
        b:addEventListener(
            "click",
            function() return open(nil, {line = "Espelho de bolso da Bigodon. O Davi aprova."}) end
        )
        row:append(b)
        inv:append(row)
    end
    local ____ = "use strict"
    if __t(window.DarocaLook) then
        return
    end
    local KEY = "daroca-visual-v1"
    DEFAULT = __ord({
        costume = "normal",
        hat = "palha",
        hatColor = "#c0392b",
        hairStyle = "curto",
        hairColor = "#5f4934",
        shirt = "#dc8c47",
        shirtLight = "#e7ac65",
        pants = "#455b62"
    }, "costume,hat,hatColor,hairStyle,hairColor,shirt,shirtLight,pants")
    OPTIONS = __ord(
        {
            costume = __arrL(
                {
                    __arrL({"normal", "NORMAL"}, 2),
                    __arrL({"jaglion", "JAGLION"}, 2),
                    __arrL({"dajegue", "DA JEGUE"}, 2),
                    __arrL({"caipira", "CAIPIRA"}, 2),
                    __arrL({"farda", "FARDA"}, 2)
                },
                5
            ),
            hat = __arrL(
                {
                    __arrL({"palha", "PALHA"}, 2),
                    __arrL({"sem", "SEM CHAPÉU"}, 2),
                    __arrL({"bone", "BONÉ"}, 2),
                    __arrL({"couro", "COURO"}, 2),
                    __arrL({"preto", "PRETO"}, 2)
                },
                5
            ),
            hairStyle = __arrL(
                {
                    __arrL({"curto", "CURTO"}, 2),
                    __arrL({"black", "BLACK"}, 2),
                    __arrL({"moicano", "MOICANO"}, 2),
                    __arrL({"raspado", "RASPADO"}, 2),
                    __arrL({"comprido", "COMPRIDO"}, 2)
                },
                5
            ),
            hairColor = __arrL(
                {
                    __arrL({"#5f4934", "castanho"}, 2),
                    __arrL({"#1e1a18", "preto"}, 2),
                    __arrL({"#d8b45a", "loiro"}, 2),
                    __arrL({"#b5502a", "ruivo"}, 2),
                    __arrL({"#e6e2da", "platinado"}, 2),
                    __arrL({"#3a6ad0", "azul"}, 2),
                    __arrL({"#d0508a", "rosa"}, 2)
                },
                7
            ),
            shirt = __arrL(
                {
                    __arrL({"#dc8c47", "laranja", "#e7ac65"}, 3),
                    __arrL({"#3a7fd0", "azul", "#6aa6e8"}, 3),
                    __arrL({"#3aa655", "verde", "#6ac884"}, 3),
                    __arrL({"#d03a3a", "vermelha", "#e86a6a"}, 3),
                    __arrL({"#8a5ac8", "roxa", "#ad86e0"}, 3),
                    __arrL({"#e8e4d8", "branca", "#ffffff"}, 3),
                    __arrL({"#2a2d33", "preta", "#4a4e57"}, 3),
                    __arrL({"#e8c23a", "amarela", "#f4dc78"}, 3)
                },
                8
            ),
            pants = __arrL(
                {
                    __arrL({"#455b62", "jeans"}, 2),
                    __arrL({"#22252a", "preta"}, 2),
                    __arrL({"#b8a074", "bege"}, 2),
                    __arrL({"#5a6a3a", "oliva"}, 2),
                    __arrL({"#8a2a2a", "vinho"}, 2)
                },
                5
            ),
            hatColor = __arrL(
                {
                    __arrL({"#c0392b", "vermelho"}, 2),
                    __arrL({"#2a5ad0", "azul"}, 2),
                    __arrL({"#2a8a4a", "verde"}, 2),
                    __arrL({"#1e1a18", "preto"}, 2),
                    __arrL({"#e8c23a", "amarelo"}, 2)
                },
                5
            )
        },
        "costume,hat,hairStyle,hairColor,shirt,pants,hatColor"
    )
    look = __assign({}, DEFAULT)
    unlocked = false
    local trajes = {}
    do
        pcall(function()
            local d = window.JSON:parse(window.localStorage:getItem(KEY))
            local ____t_1 = __t
            local ____t_result_0
            if __t(d) then
                ____t_result_0 = type(d) == "table"
            else
                ____t_result_0 = d
            end
            if ____t_1(____t_result_0) then
                unlocked = not not __t(d.unlocked)
                local ____t_3 = __t
                local ____t_result_2
                if __t(d.trajes) then
                    ____t_result_2 = type(d.trajes) == "table"
                else
                    ____t_result_2 = d.trajes
                end
                if ____t_3(____t_result_2) then
                    for ____, k in __iterar((__arrL({"dajegue", "caipira", "farda"}, 3))) do
                        __set(
                            trajes,
                            k,
                            __get(d.trajes, k) == true
                        )
                    end
                end
                for ____, k in __iterar((__keys(DEFAULT))) do
                    if type(__getq(d.look, k)) == "string" then
                        __set(
                            look,
                            k,
                            __get(d.look, k)
                        )
                    end
                end
            end
        end)
    end
    save = function()
        do
            pcall(function()
                window.localStorage:setItem(
                    KEY,
                    window.JSON:stringify({unlocked = unlocked, look = look, trajes = trajes})
                )
            end)
        end
    end
    jaglionStatus = function()
        local ____t_result_10
        local ____t_9 = __t
        local ____opt_6 = window.Game
        if ____opt_6 ~= nil then
            ____opt_6 = ____opt_6.getJaglionStatus
        end
        local ____opt_result_8
        if ____opt_6 ~= nil then
            ____opt_result_8 = ____opt_6(____opt_6)
        end
        __O[129] = ____opt_result_8
        if ____t_9(____opt_result_8) then
            ____t_result_10 = __O[129]
        else
            ____t_result_10 = "locked"
        end
        return ____t_result_10
    end
    TRAJES = __ord(
        {
            jaglion = {nota = "Capuz de juba, patas e rabo, costurados pelo Vitor. Rugido por sua conta."},
            dajegue = __ord({nota = "Orelhonas, crina e rabo de burro. O baile inteiro gritou: DA JEGUE!", dica = "DA JEGUE: vença o concurso de fantasia no baile funk do Ollyan."}, "nota,dica"),
            caipira = __ord({nota = "Chapéu desfiado, xadrez e lenço. Arraiá no meio do shopping.", dica = "CAIPIRA: na Campanha 2, ajude Dona Fátima no Shopping Conquista (missão \"Caipira no Shopping\")."}, "nota,dica"),
            farda = __ord({nota = "Farda do colégio: camisa branca com listra azul e calça com listra clara.", dica = "FARDA: no Colégio Adventista, fale com o Allef na recepção (missão \"Farda nova\")."}, "nota,dica")
        },
        "jaglion,dajegue,caipira,farda"
    )
    statusTraje = function(____, id)
        local ____temp_16
        if id == "normal" then
            ____temp_16 = "ready"
        else
            local ____temp_15
            if id == "jaglion" then
                ____temp_15 = jaglionStatus(nil)
            else
                local ____t_14 = __t
                local ____t_result_13
                local ____t_12 = __t
                local ____get_result_11 = __get(trajes, id)
                __O[130] = ____get_result_11
                if ____t_12(____get_result_11) then
                    ____t_result_13 = __O[130]
                else
                    ____t_result_13 = window.DAROCA_DEV
                end
                ____temp_15 = ____t_14(____t_result_13) and "ready" or "locked"
            end
            ____temp_16 = ____temp_15
        end
        return ____temp_16
    end
    cobre = function(____, traje, key)
        local ____t_result_31
        local ____t_19 = __t
        local ____temp_18 = key ~= "costume"
        __O[135] = ____temp_18
        if ____t_19(____temp_18) then
            local ____t_result_30
            local ____t_26 = __t
            local ____t_result_25
            local ____t_21 = __t
            local ____temp_20 = traje == "jaglion" or traje == "dajegue"
            __O[132] = ____temp_20
            if ____t_21(____temp_20) then
                ____t_result_25 = __O[132]
            else
                local ____t_result_24
                local ____t_23 = __t
                local ____temp_22 = traje == "caipira"
                __O[131] = ____temp_22
                if ____t_23(____temp_22) then
                    ____t_result_24 = __call(
                        __arrL({"hat", "hatColor", "shirt", "pants"}, 4),
                        "includes",
                        key
                    )
                else
                    ____t_result_24 = __O[131]
                end
                ____t_result_25 = ____t_result_24
            end
            __O[134] = ____t_result_25
            if ____t_26(____t_result_25) then
                ____t_result_30 = __O[134]
            else
                local ____t_result_29
                local ____t_28 = __t
                local ____temp_27 = traje == "farda"
                __O[133] = ____temp_27
                if ____t_28(____temp_27) then
                    ____t_result_29 = __call(
                        __arrL({"shirt", "pants"}, 2),
                        "includes",
                        key
                    )
                else
                    ____t_result_29 = __O[133]
                end
                ____t_result_30 = ____t_result_29
            end
            ____t_result_31 = ____t_result_30
        else
            ____t_result_31 = __O[135]
        end
        return ____t_result_31
    end
    isDefault = function(____, outfit) return __call(
        __keys(DEFAULT),
        "every",
        function(____, k) return __get(outfit, k) == __get(DEFAULT, k) end
    ) end
    panel = nil
    preview = nil
    raf = 0
    onClose = nil
    t0 = 0
    ROWS = __arrL(
        {
            __arrL({"costume", "TRAJE"}, 2),
            __arrL({"hat", "CHAPÉU"}, 2),
            __arrL({"hatColor", "COR DO BONÉ"}, 2),
            __arrL({"hairStyle", "CABELO"}, 2),
            __arrL({"hairColor", "COR DO CABELO"}, 2),
            __arrL({"shirt", "CAMISA"}, 2),
            __arrL({"pants", "CALÇA"}, 2)
        },
        7
    )
    window:setTimeout(updateInventory, 1600)
    window.DarocaLook = __ord(
        {
            get = function()
                local outfit = effectiveLook(nil)
                local ____t_result_73
                if __t(isDefault(nil, outfit)) then
                    ____t_result_73 = nil
                else
                    ____t_result_73 = outfit
                end
                return ____t_result_73
            end,
            current = function() return __assign(
                {},
                effectiveLook(nil)
            ) end,
            open = open,
            close = close,
            isOpen = function() return not not __t(panel) and not __t(panel.hidden) end,
            unlocked = function() return unlocked end,
            set = function(____, k, v)
                local ____t_77 = __t
                local ____t_result_76
                local ____t_75 = __t
                local ____temp_74 = DEFAULT[k] ~= nil and type(v) == "string"
                __O[139] = ____temp_74
                if ____t_75(____temp_74) then
                    ____t_result_76 = not __t(k == "costume" and statusTraje(nil, v) ~= "ready")
                else
                    ____t_result_76 = __O[139]
                end
                if ____t_77(____t_result_76) then
                    __set(look, k, v)
                    save(nil)
                end
            end,
            ganhar = function(____, id)
                local ____t_81 = __t
                local ____t_result_80
                local ____t_79 = __t
                local ____temp_78 = not __t(__get(TRAJES, id)) or id == "jaglion"
                __O[140] = ____temp_78
                if ____t_79(____temp_78) then
                    ____t_result_80 = __O[140]
                else
                    ____t_result_80 = __get(trajes, id)
                end
                if ____t_81(____t_result_80) then
                    return false
                end
                __set(trajes, id, true)
                unlocked = true
                save(nil)
                do
                    pcall(function()
                        window:dispatchEvent(__new("CustomEvent", "daroca-traje", {detail = {id = id}}))
                    end)
                end
                return true
            end,
            tem = function(____, id) return statusTraje(nil, id) == "ready" end,
            trajes = function() return __assign({}, trajes) end,
            reset = function()
                look = __assign({}, DEFAULT)
                save(nil)
            end
        },
        "get,current,open,close,isOpen,unlocked,set,ganhar,tem,trajes,reset"
    )
end)(nil)
return ____exports
