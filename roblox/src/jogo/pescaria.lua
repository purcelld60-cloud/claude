--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __ge, __mod, __ord, __arrL, __t, __get, __len, __call, __add, __new = __JSR.__lt, __JSR.__ge, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__t, __JSR.__get, __JSR.__len, __JSR.__call, __JSR.__add, __JSR.__new
local ____exports = {}
local __O = {};
(function()
    local puxar, desenhar, tecla, fechar, LW, TENTATIVAS, TAU, R, ell, PEIXES, box, ctx, raf, j, aoFim
    function puxar(self)
        local ____t_2 = __t
        local ____t_1 = __t
        local ____temp_0 = not __t(j)
        __O[1334] = ____temp_0
        if ____t_2(if ____t_1(____temp_0) then __O[1334] else j.fim) then
            return
        end
        if j.fase == "mordeu" then
            j.peixes = j.peixes + 1
            j.ultimo = __get(
                PEIXES,
                math.floor(math.random() * __len(PEIXES))
            )
            j.fase = "pegou"
            j.tf = 0
            j.msg = __add(
                __add(
                    "PEGOU UMA ",
                    __get(j.ultimo, 0)
                ),
                "!"
            )
        elseif j.fase == "espera" then
            j.fase = "espantou"
            j.tf = 0
            j.msg = "CEDO DEMAIS! O PEIXE FUGIU"
        end
    end
    function desenhar(self)
        local c = ctx
        local t = j.t
        c:setTransform(
            1,
            0,
            0,
            1,
            0,
            0
        )
        c.imageSmoothingEnabled = false
        local g = c:createLinearGradient(0, 0, 0, 130)
        g:addColorStop(0, "#7ab8e8")
        g:addColorStop(1, "#cfe8f4")
        c.fillStyle = g
        c:fillRect(0, 0, LW, 130)
        do
            local i = 0
            while i < 6 do
                ell(
                    nil,
                    c,
                    40 + i * 90,
                    128,
                    70,
                    26,
                    if __t(__mod(i, 2)) then "#4a8a4a" else "#3a7a3a"
                )
                i = i + 1
            end
        end
        R(
            nil,
            c,
            0,
            130,
            LW,
            140,
            "#3a7aa8"
        )
        do
            local k = 0
            while k < 40 do
                local x = __mod(k * 61 + t * 10, 520) - 20
                local y = 136 + __mod(k * 9, 120)
                R(
                    nil,
                    c,
                    x,
                    y,
                    8 + __mod(k, 3) * 4,
                    1,
                    if __t(__mod(k, 2)) then "#7ab0d0" else "#5a9ac0"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            0,
            176,
            150,
            8,
            "#a8784a"
        )
        do
            local k = 0
            while k < 150 do
                R(
                    nil,
                    c,
                    k + 6,
                    184,
                    5,
                    86,
                    "#5a3a22"
                )
                k = k + 30
            end
        end
        do
            pcall(function()
                local ____opt_13 = window.Art
                if ____opt_13 ~= nil then
                    ____opt_13 = ____opt_13.drawCharacter
                end
                if ____opt_13 ~= nil then
                    ____opt_13(
                        ____opt_13,
                        c,
                        "vagner",
                        34,
                        176,
                        {frame = t, facing = 1, grounded = true, scale = 0.85}
                    )
                end
                local ____opt_17 = window.Art
                if ____opt_17 ~= nil then
                    ____opt_17 = ____opt_17.drawCharacter
                end
                if ____opt_17 ~= nil then
                    ____opt_17(
                        ____opt_17,
                        c,
                        "daroca",
                        108,
                        176,
                        {
                            frame = t,
                            facing = 1,
                            grounded = true,
                            scale = 0.9,
                            attack = j.fase == "pegou" and __lt(j.tf, 0.4)
                        }
                    )
                end
            end)
        end
        local bx = 300
        local base = 158
        local afunda = if j.fase == "mordeu" then 6 + math.sin(j.tf * 30) * 2 else if j.fase == "espera" then math.sin(t * 2) * 1.2 else 0
        c.strokeStyle = "#6a4a2a"
        c.lineWidth = 2
        c:beginPath()
        c:moveTo(120, 140)
        c:lineTo(178, 96)
        c:stroke()
        c.strokeStyle = "rgba(255,255,255,.7)"
        c.lineWidth = 1
        c:beginPath()
        c:moveTo(178, 96)
        c:quadraticCurveTo(240, 110, bx, base + afunda - 6)
        c:stroke()
        if j.fase ~= "pegou" then
            ell(
                nil,
                c,
                bx,
                base + afunda,
                5,
                6,
                "#f2f2ee"
            )
            R(
                nil,
                c,
                bx - 5,
                base + afunda - 1,
                10,
                3,
                "#e8433a"
            )
            R(
                nil,
                c,
                bx - 1,
                base + afunda - 10,
                2,
                5,
                "#1c1c1c"
            )
        end
        if j.fase == "mordeu" then
            do
                local k = 0
                while k < 3 do
                    c.strokeStyle = ("rgba(255,255,255," .. tostring(0.6 - k * 0.18)) .. ")"
                    c:beginPath()
                    c:ellipse(
                        bx,
                        base + 6,
                        8 + k * 6 + j.tf * 20,
                        3 + k * 2,
                        0,
                        0,
                        TAU
                    )
                    c:stroke()
                    k = k + 1
                end
            end
        end
        if j.fase == "pegou" then
            local u = math.min(1, j.tf / 0.6)
            local fx = bx - (bx - 140) * u
            local fy = base - math.sin(u * math.pi) * 70 - u * 20
            c:save()
            c:translate(fx, fy)
            c:rotate(math.sin(t * 20) * 0.4)
            ell(
                nil,
                c,
                0,
                0,
                12,
                6,
                __get(j.ultimo, 1)
            )
            c.fillStyle = __get(j.ultimo, 1)
            c:beginPath()
            c:moveTo(-10, 0)
            c:lineTo(-18, -6)
            c:lineTo(-18, 6)
            c:closePath()
            __call(c, "fill")
            R(
                nil,
                c,
                6,
                -2,
                2,
                2,
                "#1c1c1c"
            )
            c:restore()
        end
        R(
            nil,
            c,
            300,
            8,
            172,
            26,
            "rgba(10,20,30,.7)"
        )
        c.font = "bold 11px monospace"
        c.textAlign = "center"
        c.textBaseline = "middle"
        c.fillStyle = "#fff6dc"
        c:fillText(
            (((("PEIXES " .. tostring(j.peixes)) .. " · ARREMESSO ") .. tostring(math.min(j.tent + 1, TENTATIVAS))) .. "/") .. tostring(TENTATIVAS),
            386,
            21
        )
        c.font = "bold 14px monospace"
        if j.fase == "mordeu" then
            c.fillStyle = "#ffd24a"
            c:fillText("PUXA!", bx, 120)
        end
        if __t(j.msg) then
            c.fillStyle = if j.fase == "pegou" then "#7af07a" else "#ffb0a0"
            c:fillText(j.msg, LW / 2, 250)
        end
        if __t(j.fim) then
            R(
                nil,
                c,
                0,
                100,
                LW,
                56,
                "rgba(0,0,0,.7)"
            )
            c.fillStyle = if __ge(j.peixes, 3) then "#7af07a" else "#ffd24a"
            c.font = "bold 16px monospace"
            c:fillText(if __ge(j.peixes, 3) then tostring(j.peixes) .. " PEIXES! PESCADOR DE VERDADE!" else tostring(j.peixes) .. " PEIXE(S). O VAGNER RIU DE VOCÊ.", LW / 2, 128)
        end
    end
    function tecla(self, e)
        if not __t(box) then
            return
        end
        if e.code == "Escape" then
            e:preventDefault()
            e:stopPropagation()
            local ____fechar_23 = fechar
            local ____t_22 = __t
            local ____opt_result_21
            if j ~= nil then
                ____opt_result_21 = j.peixes
            end
            __O[1337] = ____opt_result_21
            ____fechar_23(nil, if ____t_22(____opt_result_21) then __O[1337] else 0)
            return
        end
        if __t(__call(
            __arrL({"KeyE", "Space", "Enter", "KeyJ"}, 4),
            "includes",
            e.code
        )) then
            e:preventDefault()
            e:stopPropagation()
            if not __t(e["repeat"]) then
                puxar(nil)
            end
        end
    end
    function fechar(self, peixes)
        if not __t(box) then
            return
        end
        window:cancelAnimationFrame(raf)
        window:removeEventListener("keydown", tecla, true)
        box:remove()
        box = nil
        j = nil
        window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {active = false}}))
        local ____opt_31 = window.document:getElementById("gameCanvas")
        local ____opt_29 = ____opt_31 and ____opt_31.focus
        if ____opt_29 ~= nil then
            ____opt_29(____opt_31)
        end
        local fn = aoFim
        aoFim = nil
        if __t(fn) then
            do
                pcall(function()
                    fn(nil, if __t(peixes) then peixes else 0)
                end)
            end
        end
    end
    local ____ = "use strict"
    if __t(window.PescariaBene) then
        return
    end
    LW = 480
    local LH = 270
    TENTATIVAS = 5
    local JANELA = 0.62
    TAU = math.pi * 2
    R = function(____, c, x, y, w, h, cor)
        c.fillStyle = cor
        c:fillRect(
            math.floor(x + 0.5),
            math.floor(y + 0.5),
            math.floor(w + 0.5),
            math.floor(h + 0.5)
        )
    end
    ell = function(____, c, x, y, rx, ry, cor)
        c.fillStyle = cor
        c:beginPath()
        c:ellipse(
            math.floor(x + 0.5),
            math.floor(y + 0.5),
            rx,
            ry,
            0,
            0,
            TAU
        )
        __call(c, "fill")
    end
    PEIXES = __arrL(
        {
            __arrL({"TILÁPIA", "#a8b8c0"}, 2),
            __arrL({"TRAÍRA", "#7a8a5a"}, 2),
            __arrL({"PIABA", "#d8d0a0"}, 2),
            __arrL({"CARÁ", "#c8a06a"}, 2),
            __arrL({"TUCUNARÉ", "#e8b84a"}, 2)
        },
        5
    )
    box = nil
    local cv = nil
    ctx = nil
    raf = 0
    j = nil
    aoFim = nil
    local function novoArremesso(self)
        j.fase = "espera"
        j.espera = 1.2 + math.random() * 2.3
        j.tf = 0
        j.msg = ""
    end
    local function quadro(self, agora)
        if not __t(j) then
            return
        end
        local dt = math.min(0.1, (agora - if __t(j.ultimoT) then j.ultimoT else agora) / 1000)
        j.ultimoT = agora
        j.t = j.t + dt
        j.tf = j.tf + dt
        if __t(j.fase == "espera" and __ge(j.tf, j.espera)) then
            j.fase = "mordeu"
            j.tf = 0
        elseif __t(j.fase == "mordeu" and __ge(j.tf, JANELA)) then
            j.fase = "escapou"
            j.tf = 0
            j.msg = "ESCAPOU! PUXE QUANDO A BOIA AFUNDAR"
        else
            local ____t_5 = __t
            local ____t_4 = __t
            local ____call_result_3 = __call(
                __arrL({"pegou", "espantou", "escapou"}, 3),
                "includes",
                j.fase
            )
            __O[1335] = ____call_result_3
            if ____t_5(if ____t_4(____call_result_3) then __ge(j.tf, 1.3) else __O[1335]) then
                j.tent = j.tent + 1
                if __ge(j.tent, TENTATIVAS) then
                    j.fim = true
                    window:setTimeout(
                        function()
                            local ____fechar_10 = fechar
                            local ____t_9 = __t
                            local ____opt_result_8
                            if j ~= nil then
                                ____opt_result_8 = j.peixes
                            end
                            __O[1336] = ____opt_result_8
                            return ____fechar_10(nil, if ____t_9(____opt_result_8) then __O[1336] else 0)
                        end,
                        1400
                    )
                else
                    novoArremesso(nil)
                end
            end
        end
        desenhar(nil)
        raf = window:requestAnimationFrame(quadro)
    end
    local function abrir(self, o)
        if o == nil then
            o = {}
        end
        if __t(box) then
            return false
        end
        aoFim = if __t(o.onFim) then o.onFim else nil
        if not __t(window.document:getElementById("pbEstilo")) then
            local st = window.document:createElement("style")
            st.id = "pbEstilo"
            st.textContent = ".pb-overlay{position:fixed;inset:0;z-index:9000;background:rgba(6,14,20,.86);display:flex;flex-direction:column;align-items:center;justify-content:center;gap:10px;font-family:monospace;touch-action:none;user-select:none}.pb-overlay canvas{width:min(96vw,calc(78vh*16/9),960px);aspect-ratio:16/9;image-rendering:pixelated;border:2px solid #7ab0d0;border-radius:6px}.pb-puxar{font:bold 20px monospace;color:#fff;background:#2a5a7a;border:2px solid #7ab0d0;border-radius:10px;padding:12px 36px}.pb-puxar:active{background:#3a7aa8}.pb-sair{font:bold 12px monospace;color:#ffd24a;background:transparent;border:1px solid #ffd24a;border-radius:6px;padding:6px 12px}"
            window.document.head:append(st)
        end
        box = window.document:createElement("div")
        box.className = "pb-overlay"
        box:setAttribute("role", "dialog")
        box:setAttribute("aria-label", "Pescaria do Vagner")
        cv = window.document:createElement("canvas")
        cv.width = LW
        cv.height = LH
        ctx = cv:getContext("2d")
        box:append(cv)
        local b = window.document:createElement("button")
        b.type = "button"
        b.className = "pb-puxar"
        b.textContent = "PUXAR!"
        b:addEventListener(
            "pointerdown",
            function(____, e)
                e:preventDefault()
                puxar(nil)
            end
        )
        box:append(b)
        local s = window.document:createElement("button")
        s.type = "button"
        s.className = "pb-sair"
        s.textContent = "SAIR (Esc)"
        s:addEventListener(
            "click",
            function()
                local ____fechar_28 = fechar
                local ____t_27 = __t
                local ____opt_result_26
                if j ~= nil then
                    ____opt_result_26 = j.peixes
                end
                __O[1338] = ____opt_result_26
                return ____fechar_28(nil, if ____t_27(____opt_result_26) then __O[1338] else 0)
            end
        )
        box:append(s)
        window.document.body:append(box)
        window:addEventListener("keydown", tecla, true)
        j = {
            t = 0,
            tf = 0,
            tent = 0,
            peixes = 0,
            fase = "espera",
            espera = 1.5,
            msg = "",
            fim = false,
            ultimoT = 0
        }
        novoArremesso(nil)
        window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {active = true}}))
        window:cancelAnimationFrame(raf)
        raf = window:requestAnimationFrame(quadro)
        return true
    end
    window.PescariaBene = __ord(
        {
            abrir = abrir,
            aberto = function() return not not __t(box) end,
            estado = function() return if __t(j) then {fase = j.fase, peixes = j.peixes, tent = j.tent} else j end
        },
        "abrir,aberto,estado"
    )
end)(nil)
return ____exports
