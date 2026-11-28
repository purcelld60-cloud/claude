--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __D = {}
local __getq, __ord, __arrL, __iterar, __t, __get, __set, __call, __add, __new, __keys, __assign = __JSR.__getq, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__call, __JSR.__add, __JSR.__new, __JSR.__keys, __JSR.__assign
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Iterator = ____lualib.__TS__Iterator
local ____exports = {}
local __O = {};
(function()
    local effectiveLook, build, render, drawPreview, open, close, updateInventory, DEFAULT, OPTIONS, look, unlocked, save, jaglionStatus, TRAJES, statusTraje, cobre, isDefault, panel, preview, raf, onClose, t0, ROWS
    function effectiveLook(self)
        return if __t(look.costume ~= "normal" and statusTraje(nil, look.costume) ~= "ready") then __assign({}, look, {costume = "normal"}) else look
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
        local ____t_20 = __t
        local ____temp_19 = window.document:getElementById("gameShell")
        __O[136] = ____temp_19
        __D[1] = if ____t_20(____temp_19) then __O[136] else window.document.body:append(panel)
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
        local hint = if status == "reserved" then "Seu Jaglion está pronto. Fale com Davi na Bigodon para recebê-lo." else "Para ganhar o Jaglion, encontre Amanda na entrada da Praça Camacan e aceite o jantar."
        for ____, ____value in __iterar((ROWS)) do
            local key = ____value[1]
            local label = ____value[2]
            if __t(key == "hatColor" and outfit.hat ~= "bone") then
                continue
            end
            local row = window.document:createElement("div")
            row.className = __add("vp-row", if __t(cobre(nil, traje, key)) then " is-off" else "")
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
                    __add("vp-opt", if __t(color) then " vp-swatch" else ""),
                    if __get(outfit, key) == val then " on" else ""
                )
                b:setAttribute("aria-pressed", if __get(outfit, key) == val then "true" else "false")
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
                        b.textContent = if status == "reserved" then "JAGLION · RESERVADO" else "JAGLION · BLOQUEADO"
                        b.title = hint
                    end
                elseif __t(key == "costume" and val ~= "normal") then
                    __call(b.classList, "add", "vp-lion")
                    if statusTraje(nil, val) ~= "ready" then
                        b.textContent = __add(name, " · BLOQUEADO")
                        b.title = __get(TRAJES, val).dica
                    end
                end
                local ____t_22 = __t
                local ____temp_21 = key == "costume" and statusTraje(nil, val) ~= "ready"
                __O[137] = ____temp_21
                b.disabled = if ____t_22(____temp_21) then __O[137] else cobre(nil, traje, key)
                b:addEventListener(
                    "click",
                    function()
                        __set(look, key, val)
                        if key == "shirt" then
                            look.shirtLight = if __t(light) then light else look.shirtLight
                        end
                        save(nil)
                        render(nil)
                        local ____opt_25 = panel:querySelector(("[data-k=\"" .. tostring(key)) .. "\"] .on")
                        if ____opt_25 ~= nil then
                            ____opt_25 = ____opt_25.focus
                        end
                        if ____opt_25 ~= nil then
                            ____opt_25(____opt_25)
                        end
                    end
                )
                list:append(b)
            end
            row.dataset.k = key
            row:append(list)
            rows:append(row)
        end
        local falta = __call(
            __arrL({"dajegue", "caipira", "farda"}, 3),
            "find",
            function(____, k) return statusTraje(nil, k) ~= "ready" end
        )
        panel:querySelector(".vp-note").textContent = if __t(__get(TRAJES, traje)) then __get(TRAJES, traje).nota else if status ~= "ready" then hint else if __t(falta) then __get(TRAJES, falta).dica else if __t(isDefault(nil, outfit)) then "O Da Roça de sempre." else "Visual novo, mesma resenha."
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
                local ____opt_29 = window.Art
                if ____opt_29 ~= nil then
                    ____opt_29 = ____opt_29.drawCharacter
                end
                if ____opt_29 ~= nil then
                    ____opt_29(
                        ____opt_29,
                        c,
                        "daroca",
                        100,
                        214,
                        {facing = if math.sin(t * 0.6) > -0.2 then 1 else -1, frame = t, scale = 2.1, grounded = true}
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
        onClose = if __t(opts.onClose) then opts.onClose else nil
        panel:querySelector(".vp-davi").textContent = if __t(opts.line) then opts.line else "Davi: E aí, Da Roça, vai querer o quê hoje?"
        panel:querySelector(".vp-head b").textContent = if __t(opts.title) then opts.title else "ESPELHO DA BIGODON"
        panel:setAttribute("aria-label", if __t(opts.title) then opts.title else "Espelho da Bigodon")
        render(nil)
        panel.hidden = false
        t0 = window.performance:now()
        window:cancelAnimationFrame(raf)
        raf = window:requestAnimationFrame(drawPreview)
        window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {active = true}}))
        window:setTimeout(
            function()
                local ____opt_33 = panel:querySelector(".vp-opt.on")
                if ____opt_33 ~= nil then
                    ____opt_33 = ____opt_33.focus
                end
                local ____opt_result_35
                if ____opt_33 ~= nil then
                    ____opt_result_35 = ____opt_33(____opt_33)
                end
                return ____opt_result_35
            end,
            40
        )
        updateInventory(nil)
    end
    function close(self)
        local ____t_38 = __t
        local ____t_37 = __t
        local ____temp_36 = not __t(panel)
        __O[138] = ____temp_36
        if ____t_38(if ____t_37(____temp_36) then __O[138] else panel.hidden) then
            return
        end
        panel.hidden = true
        window:cancelAnimationFrame(raf)
        save(nil)
        window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {active = false}}))
        local ____opt_41 = window.document:getElementById("gameCanvas")
        local ____opt_39 = ____opt_41 and ____opt_41.focus
        if ____opt_39 ~= nil then
            ____opt_39(____opt_41)
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
            if __t(if __t(d) then type(d) == "table" else d) then
                unlocked = not not __t(d.unlocked)
                if __t(if __t(d.trajes) then type(d.trajes) == "table" else d.trajes) then
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
        local ____t_5 = __t
        local ____opt_2 = window.Game
        if ____opt_2 ~= nil then
            ____opt_2 = ____opt_2.getJaglionStatus
        end
        local ____opt_result_4
        if ____opt_2 ~= nil then
            ____opt_result_4 = ____opt_2(____opt_2)
        end
        __O[129] = ____opt_result_4
        return if ____t_5(____opt_result_4) then __O[129] else "locked"
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
        local ____t_8 = __t
        local ____t_7 = __t
        local ____get_result_6 = __get(trajes, id)
        __O[130] = ____get_result_6
        return if id == "normal" then "ready" else if id == "jaglion" then jaglionStatus(nil) else if ____t_8(if ____t_7(____get_result_6) then __O[130] else window.DAROCA_DEV) then "ready" else "locked"
    end
    cobre = function(____, traje, key)
        local ____t_10 = __t
        local ____temp_9 = key ~= "costume"
        __O[135] = ____temp_9
        local ____t_16 = __t
        local ____t_12 = __t
        local ____temp_11 = traje == "jaglion" or traje == "dajegue"
        __O[132] = ____temp_11
        local ____t_14 = __t
        local ____temp_13 = traje == "caipira"
        __O[131] = ____temp_13
        local ____temp_15 = if ____t_12(____temp_11) then __O[132] else if ____t_14(____temp_13) then __call(
            __arrL({"hat", "hatColor", "shirt", "pants"}, 4),
            "includes",
            key
        ) else __O[131]
        __O[134] = ____temp_15
        local ____t_18 = __t
        local ____temp_17 = traje == "farda"
        __O[133] = ____temp_17
        return if ____t_10(____temp_9) then if ____t_16(____temp_15) then __O[134] else if ____t_18(____temp_17) then __call(
            __arrL({"shirt", "pants"}, 2),
            "includes",
            key
        ) else __O[133] else __O[135]
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
                return if __t(isDefault(nil, outfit)) then nil else outfit
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
                local ____t_45 = __t
                local ____t_44 = __t
                local ____temp_43 = DEFAULT[k] ~= nil and type(v) == "string"
                __O[139] = ____temp_43
                if ____t_45(if ____t_44(____temp_43) then not __t(k == "costume" and statusTraje(nil, v) ~= "ready") else __O[139]) then
                    __set(look, k, v)
                    save(nil)
                end
            end,
            ganhar = function(____, id)
                local ____t_48 = __t
                local ____t_47 = __t
                local ____temp_46 = not __t(__get(TRAJES, id)) or id == "jaglion"
                __O[140] = ____temp_46
                if ____t_48(if ____t_47(____temp_46) then __O[140] else __get(trajes, id)) then
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
