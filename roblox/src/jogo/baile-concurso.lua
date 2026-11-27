--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __gt, __mod, __ord, __arrL, __iterar, __t, __get, __set, __len, __call, __add = __JSR.__lt, __JSR.__gt, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__set, __JSR.__len, __JSR.__call, __JSR.__add
local __new, __assign = __JSR.__new, __JSR.__assign
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__New = ____lualib.__TS__New
local __TS__Iterator = ____lualib.__TS__Iterator
local ____exports = {}
local __O = {};
(function()
    local som, apertar, nota, parcial, desenhar, seta, tecla, fechar, LW, LH, BEAT, DURACAO, LINHA, VEL, META, CORES, TECLAS, R, lx, box, ctx, raf, jogo, aoFim, audio, cfg
    function som(self, f, d, tipo, vol)
        if d == nil then
            d = 0.07
        end
        if tipo == nil then
            tipo = "square"
        end
        if vol == nil then
            vol = 0.03
        end
        do
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                local ____t_8 = __t
                local ____opt_5 = window.Game
                if ____opt_5 ~= nil then
                    ____opt_5 = ____opt_5.soundOn
                end
                local ____opt_result_7
                if ____opt_5 ~= nil then
                    ____opt_result_7 = ____opt_5(____opt_5)
                end
                if not ____t_8(____opt_result_7) then
                    return true
                end
                audio = if __t(audio) then audio else __TS__New(if __t(window.AudioContext) then window.AudioContext else window.webkitAudioContext)
                local o = audio:createOscillator()
                local g = audio:createGain()
                o.type = tipo
                o.frequency.value = f
                g.gain:setValueAtTime(vol, audio.currentTime)
                g.gain:exponentialRampToValueAtTime(0.0001, audio.currentTime + d)
                o:connect(g)
                g:connect(audio.destination)
                o:start()
                o:stop(audio.currentTime + d)
            end)
            if ____try and ____hasReturned then
                return ____returnValue
            end
        end
    end
    function apertar(self, lane)
        local ____t_11 = __t
        local ____t_10 = __t
        local ____temp_9 = not __t(jogo)
        __O[1396] = ____temp_9
        if ____t_11(if ____t_10(____temp_9) then __O[1396] else jogo.fim) then
            return
        end
        __set(jogo.trilha, lane, 0.18)
        local melhor = nil
        local dist = 1
        for ____, n in __iterar((jogo.notas)) do
            if __t(n.ok ~= nil or n.lane ~= lane) then
                continue
            end
            local d = math.abs(n.t - jogo.t)
            if d < dist then
                dist = d
                melhor = n
            end
        end
        if __t(if __t(melhor) then dist <= 0.16 else melhor) then
            melhor.ok = if dist <= 0.06 then 1 else 0.7
            jogo.combo = jogo.combo + 1
            jogo.melhorCombo = math.max(jogo.melhorCombo, jogo.combo)
            jogo.msg = if dist <= 0.06 then "PERFEITO!" else "BOM!"
            jogo.msgT = 0.45
            jogo.pulo = 0.25
            som(nil, if dist <= 0.06 then 880 else 660)
        else
            jogo.combo = 0
            jogo.msg = "FORA DO RITMO"
            jogo.msgT = 0.35
            som(
                nil,
                150,
                0.08,
                "sawtooth",
                0.02
            )
        end
    end
    function nota(self)
        local n = jogo.notas
        return math.floor(__call(
            n,
            "reduce",
            function(____, s, x) return __add(s, if __t(x.ok) then x.ok else 0) end,
            0
        ) / __len(n) * 100 + 0.5)
    end
    function parcial(self)
        local n = __call(
            jogo.notas,
            "filter",
            function(____, x) return x.ok ~= nil end
        )
        return if __t(__len(n)) then math.floor(__call(
            n,
            "reduce",
            function(____, s, x) return __add(s, x.ok) end,
            0
        ) / __len(n) * 100 + 0.5) else 100
    end
    function desenhar(self)
        local c = ctx
        local t = jogo.t
        local beat = math.floor(t / BEAT)
        local fase = __mod(t, BEAT) / BEAT
        c:setTransform(
            1,
            0,
            0,
            1,
            0,
            0
        )
        c.imageSmoothingEnabled = false
        local g = c:createLinearGradient(0, 0, 0, LH)
        g:addColorStop(0, "#0a0618")
        g:addColorStop(1, "#2a1438")
        c.fillStyle = g
        c:fillRect(0, 0, LW, LH)
        c:save()
        c.globalCompositeOperation = "lighter"
        do
            local i = 0
            while i < 5 do
                local x = 30 + i * 55
                local a = math.sin(t * 0.9 + i) * 0.4
                c.globalAlpha = 0.12
                c.fillStyle = __get(
                    CORES,
                    __mod(i + beat, 4)
                )
                c:beginPath()
                c:moveTo(x, 0)
                c:lineTo(
                    x + math.sin(a) * 260 - 30,
                    230
                )
                c:lineTo(
                    x + math.sin(a) * 260 + 30,
                    230
                )
                c:closePath()
                __call(c, "fill")
                i = i + 1
            end
        end
        c:restore()
        R(
            nil,
            c,
            20,
            18,
            230,
            26,
            "#120e1e"
        )
        c.strokeStyle = "#ff4fa8"
        c.lineWidth = 1
        c:strokeRect(20.5, 18.5, 229, 25)
        c.font = "bold 12px monospace"
        c.textAlign = "center"
        c.textBaseline = "middle"
        c.fillStyle = "#ffd24a"
        c:fillText(cfg.titulo, 135, 31)
        R(
            nil,
            c,
            0,
            230,
            280,
            40,
            "#1a1428"
        )
        do
            local x = 0
            while x < 280 do
                R(
                    nil,
                    c,
                    x,
                    230,
                    19,
                    4,
                    if __t(__mod(x / 20 + beat, 3)) then "#2a2040" else __get(
                        CORES,
                        __mod(x / 20 + beat, 4)
                    )
                )
                x = x + 20
            end
        end
        do
            pcall(function()
                local ____opt_14 = window.Art
                if ____opt_14 ~= nil then
                    ____opt_14 = ____opt_14.drawCharacter
                end
                if ____opt_14 ~= nil then
                    ____opt_14(
                        ____opt_14,
                        c,
                        cfg.rival,
                        52,
                        230,
                        {
                            frame = t * 2,
                            facing = 1,
                            grounded = true,
                            scale = 0.9,
                            attack = if __t(cfg.versos) then __mod(
                                math.floor(t / (BEAT * 8)),
                                2
                            ) == 0 else cfg.versos,
                            attackProgress = __mod(t, BEAT) / BEAT
                        }
                    )
                end
                local pula = math.abs(math.sin(t * math.pi / BEAT)) * 6 + jogo.pulo * 14
                local ____opt_18 = window.Art
                if ____opt_18 ~= nil then
                    ____opt_18 = ____opt_18.drawCharacter
                end
                if ____opt_18 ~= nil then
                    ____opt_18(
                        ____opt_18,
                        c,
                        "daroca",
                        138,
                        230 - pula,
                        {
                            frame = t * 2.2,
                            facing = if __t(__mod(beat, 2)) then 1 else -1,
                            moving = true,
                            grounded = pula < 2,
                            scale = 1
                        }
                    )
                end
                if __t(cfg.premioLook) then
                    R(
                        nil,
                        c,
                        212,
                        160,
                        4,
                        70,
                        "#8a7a5a"
                    )
                    R(
                        nil,
                        c,
                        200,
                        228,
                        28,
                        4,
                        "#6a5a3a"
                    )
                    local ____opt_22 = window.Art
                    if ____opt_22 ~= nil then
                        ____opt_22 = ____opt_22.drawCharacter
                    end
                    if ____opt_22 ~= nil then
                        ____opt_22(
                            ____opt_22,
                            c,
                            "daroca",
                            214,
                            226,
                            {
                                frame = 0,
                                facing = -1,
                                grounded = true,
                                scale = 0.82,
                                look = {
                                    costume = cfg.premioLook,
                                    hat = "palha",
                                    hatColor = "#c0392b",
                                    hairStyle = "curto",
                                    hairColor = "#5f4934",
                                    shirt = "#dc8c47",
                                    shirtLight = "#e7ac65",
                                    pants = "#455b62"
                                }
                            }
                        )
                    end
                end
            end)
        end
        c.font = "bold 8px monospace"
        c.fillStyle = "#ffd24a"
        if __t(cfg.premio) then
            c:fillText(
                __add("PRÊMIO: ", cfg.premio),
                214,
                246
            )
        end
        if __t(cfg.versos) then
            local i = math.floor(math.max(0, t) / (BEAT * 8))
            local seu = __mod(i, 2) == 1
            local v = __get(
                cfg.versos,
                __mod(
                    i,
                    __len(cfg.versos)
                )
            )
            R(
                nil,
                c,
                14,
                54,
                252,
                30,
                "rgba(10,6,20,.75)"
            )
            c.font = "bold 9px monospace"
            c.textAlign = "left"
            c.fillStyle = if __t(seu) then "#7af0ff" else "#ff9ad0"
            c:fillText(
                __add(
                    if __t(seu) then "DA ROÇA: " else "FREDDY: ",
                    __get(v, 0)
                ),
                20,
                64
            )
            c.fillStyle = "#f2f2ea"
            c:fillText(
                __get(v, 1),
                20,
                76
            )
            c.textAlign = "center"
        end
        do
            local k = 0
            while k < 14 do
                local x = 8 + k * 20
                local y = 262 - math.abs(math.sin(t * 4 + k)) * 5
                c.fillStyle = "#05030a"
                c:beginPath()
                c:arc(
                    x,
                    y,
                    7,
                    0,
                    math.pi * 2
                )
                __call(c, "fill")
                R(
                    nil,
                    c,
                    x - 8,
                    y + 3,
                    16,
                    10,
                    "#05030a"
                )
                k = k + 1
            end
        end
        do
            local i = 0
            while i < 4 do
                R(
                    nil,
                    c,
                    lx(nil, i) - 15,
                    0,
                    30,
                    LH,
                    "rgba(10,6,20,.6)"
                )
                R(
                    nil,
                    c,
                    lx(nil, i) - 16,
                    LINHA - 2,
                    32,
                    4,
                    if __gt(
                        __get(jogo.trilha, i),
                        0
                    ) then __get(CORES, i) else "#3a2a4a"
                )
                seta(
                    nil,
                    lx(nil, i),
                    LINHA,
                    i,
                    if __gt(
                        __get(jogo.trilha, i),
                        0
                    ) then "#ffffff" else "#5a4a6a",
                    1
                )
                i = i + 1
            end
        end
        for ____, n in __iterar((jogo.notas)) do
            if __t(n.ok) then
                continue
            end
            local y = LINHA - (n.t - t) * VEL
            if __t(y < -14 or y > LH + 14) then
                continue
            end
            seta(
                nil,
                lx(nil, n.lane),
                y,
                n.lane,
                if n.ok == 0 then "#5a3a3a" else __get(CORES, n.lane),
                1 + if math.abs(n.t - t) < 0.1 then 0.15 else 0
            )
        end
        local pct = if __t(jogo.fim) then nota(nil) else parcial(nil)
        c.font = "bold 11px monospace"
        c.textAlign = "center"
        c.fillStyle = if pct >= META then "#ffe9a8" else "#ff9a7a"
        c:fillText(
            ((("ACERTO " .. tostring(pct)) .. "% · META ") .. tostring(META)) .. "%",
            360,
            10
        )
        if __gt(jogo.combo, 2) then
            c.font = "bold 14px monospace"
            c.fillStyle = "#ffd24a"
            c:fillText(
                __add("COMBO ", jogo.combo),
                360,
                252
            )
        end
        if __gt(jogo.msgT, 0) then
            c.font = "bold 14px monospace"
            c.fillStyle = if jogo.msg == "FORA DO RITMO" then "#ff5a4a" else "#7af07a"
            c:fillText(jogo.msg, 360, 130)
        end
        local prog = math.min(1, t / DURACAO)
        R(
            nil,
            c,
            290,
            262,
            160,
            4,
            "#2a2040"
        )
        R(
            nil,
            c,
            290,
            262,
            160 * prog,
            4,
            "#ff4fa8"
        )
        if __lt(jogo.t, 2) then
            c.font = "bold 16px monospace"
            c.fillStyle = "#ffffff"
            c:fillText(if __lt(jogo.t, 1) then "PREPARA..." else "VAI!", 360, 100)
        end
        if __t(jogo.fim) then
            R(
                nil,
                c,
                0,
                100,
                LW,
                60,
                "rgba(0,0,0,.7)"
            )
            c.font = "bold 18px monospace"
            c.fillStyle = if pct >= META then "#7af07a" else "#ffd24a"
            c:fillText(if pct >= META then (("NOTA " .. tostring(pct)) .. "%! ") .. tostring(cfg.ganhou) else ("NOTA " .. tostring(pct)) .. "%. FALTOU POUCO!", LW / 2, 130)
        end
    end
    function seta(self, x, y, i, cor, esc)
        local c = ctx
        c:save()
        c:translate(
            math.floor(x + 0.5),
            math.floor(y + 0.5)
        )
        c:scale(esc, esc)
        c:rotate(__get(
            __arrL({math.pi, math.pi / 2, -math.pi / 2, 0}, 4),
            i
        ))
        c.fillStyle = "#05030a"
        c:beginPath()
        c:moveTo(12, 0)
        c:lineTo(0, -12)
        c:lineTo(0, -5)
        c:lineTo(-11, -5)
        c:lineTo(-11, 5)
        c:lineTo(0, 5)
        c:lineTo(0, 12)
        c:closePath()
        __call(c, "fill")
        c.fillStyle = cor
        c:beginPath()
        c:moveTo(9, 0)
        c:lineTo(1, -8)
        c:lineTo(1, -3)
        c:lineTo(-9, -3)
        c:lineTo(-9, 3)
        c:lineTo(1, 3)
        c:lineTo(1, 8)
        c:closePath()
        __call(c, "fill")
        c:restore()
    end
    function tecla(self, e)
        if not __t(box) then
            return
        end
        if e.code == "Escape" then
            e:preventDefault()
            e:stopPropagation()
            fechar(nil, false, if __t(jogo) then nota(nil) else 0, true)
            return
        end
        local lane = __get(TECLAS, e.code)
        if lane == nil then
            return
        end
        e:preventDefault()
        e:stopPropagation()
        if not __t(e["repeat"]) then
            apertar(nil, lane)
        end
    end
    function fechar(self, ok, pct, desistiu)
        if desistiu == nil then
            desistiu = false
        end
        if not __t(box) then
            return
        end
        window:cancelAnimationFrame(raf)
        window:removeEventListener("keydown", tecla, true)
        box:remove()
        box = nil
        jogo = nil
        window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {active = false}}))
        local ____opt_26 = window.document:getElementById("gameCanvas")
        local ____opt_24 = ____opt_26 and ____opt_26.focus
        if ____opt_24 ~= nil then
            ____opt_24(____opt_26)
        end
        local fn = aoFim
        aoFim = nil
        if __t(fn) then
            do
                pcall(function()
                    fn(
                        nil,
                        not not __t(ok),
                        if __t(pct) then pct else 0,
                        desistiu
                    )
                end)
            end
        end
    end
    local ____ = "use strict"
    if __t(window.BaileConcurso) then
        return
    end
    LW = 480
    LH = 270
    local BPM = 128
    BEAT = 60 / BPM
    DURACAO = 30
    LINHA = 214
    VEL = 150
    META = 70
    CORES = __arrL({"#ff4fa8", "#3fe0ff", "#5dff9a", "#ffd24a"}, 4)
    local SETAS = __arrL({"←", "↓", "↑", "→"}, 4)
    TECLAS = __ord({
        ArrowLeft = 0,
        KeyA = 0,
        ArrowDown = 1,
        KeyS = 1,
        ArrowUp = 2,
        KeyW = 2,
        ArrowRight = 3,
        KeyD = 3
    }, "ArrowLeft,KeyA,ArrowDown,KeyS,ArrowUp,KeyW,ArrowRight,KeyD")
    R = function(____, c, x, y, w, h, cor)
        c.fillStyle = cor
        c:fillRect(
            math.floor(x + 0.5),
            math.floor(y + 0.5),
            math.floor(w + 0.5),
            math.floor(h + 0.5)
        )
    end
    lx = function(____, i) return 300 + i * 40 end
    box = nil
    local cv = nil
    ctx = nil
    raf = 0
    jogo = nil
    aoFim = nil
    audio = nil
    cfg = {}
    local PADRAO = __ord({
        titulo = "CONCURSO DA FANTASIA",
        rival = "mc_batidao",
        premio = "DA JEGUE",
        premioLook = "dajegue",
        ganhou = "O BAILE GRITOU: DA JEGUE!",
        perdeu = "FALTOU POUCO!",
        versos = nil
    }, "titulo,rival,premio,premioLook,ganhou,perdeu,versos")
    local function mapa(self)
        local notas = __arrL({}, 0)
        local seed = 7
        local function rnd()
            seed = __mod(seed * 9301 + 49297, 233280)
            return seed / 233280
        end
        do
            local b = 4
            while b < DURACAO / BEAT - 2 do
                local t = b * BEAT
                local compasso = math.floor(b / 8)
                __call(notas, "push", {t = t, lane = if __mod(b + compasso, 4) == 0 then 0 else math.floor(rnd(nil) * 4)})
                local ____t_2 = __t
                local ____t_1 = __t
                local ____temp_0 = __mod(compasso, 2) == 1 and __mod(b, 2) == 1
                __O[1395] = ____temp_0
                if ____t_2(if ____t_1(____temp_0) then rnd(nil) < 0.55 else __O[1395]) then
                    __call(
                        notas,
                        "push",
                        {
                            t = t + BEAT / 2,
                            lane = math.floor(rnd(nil) * 4)
                        }
                    )
                end
                if __mod(b, 16) == 15 then
                    __call(
                        notas,
                        "push",
                        {
                            t = t,
                            lane = __mod(
                                __get(
                                    notas,
                                    __len(notas) - 1
                                ).lane + 2,
                                4
                            )
                        }
                    )
                end
                b = b + 1
            end
        end
        return __call(
            __call(
                notas,
                "sort",
                function(____, a, b) return a.t - b.t end
            ),
            "map",
            function(____, n) return __assign({}, n, {ok = nil}) end
        )
    end
    local function quadro(self, agora)
        if not __t(jogo) then
            return
        end
        local dt = math.min(0.1, (agora - if __t(jogo.ultimo) then jogo.ultimo else agora) / 1000)
        jogo.ultimo = agora
        jogo.t = jogo.t + dt
        jogo.msgT = jogo.msgT - dt
        jogo.pulo = math.max(0, jogo.pulo - dt)
        do
            local i = 0
            while i < 4 do
                __set(
                    jogo.trilha,
                    i,
                    math.max(
                        0,
                        __get(jogo.trilha, i) - dt
                    )
                )
                i = i + 1
            end
        end
        for ____, n in __iterar((jogo.notas)) do
            if __t(n.ok == nil and jogo.t - n.t > 0.18) then
                n.ok = 0
                jogo.combo = 0
            end
        end
        desenhar(nil)
        if __t(__gt(jogo.t, DURACAO) and not __t(jogo.fim)) then
            jogo.fim = true
            local pct = nota(nil)
            window:setTimeout(
                function() return fechar(nil, pct >= META, pct) end,
                900
            )
        end
        raf = window:requestAnimationFrame(quadro)
    end
    local function montar(self)
        if __t(box) then
            return
        end
        if not __t(window.document:getElementById("bcEstilo")) then
            local st = window.document:createElement("style")
            st.id = "bcEstilo"
            st.textContent = ".bc-overlay{position:fixed;inset:0;z-index:9000;background:rgba(6,4,14,.86);display:flex;flex-direction:column;align-items:center;justify-content:center;gap:10px;font-family:monospace;touch-action:none;user-select:none}.bc-overlay canvas{width:min(96vw,calc(78vh*16/9),960px);aspect-ratio:16/9;image-rendering:pixelated;border:2px solid #ff4fa8;border-radius:6px;background:#0a0618}.bc-botoes{display:flex;gap:10px}.bc-botoes button{width:64px;height:56px;font:bold 26px monospace;color:#fff;background:#2a1438;border:2px solid #5a3a6a;border-radius:10px}.bc-botoes button:active{background:#5a2a6a}.bc-sair{font:bold 12px monospace;color:#ffd24a;background:transparent;border:1px solid #ffd24a;border-radius:6px;padding:6px 12px}"
            window.document.head:append(st)
        end
        box = window.document:createElement("div")
        box.className = "bc-overlay"
        box:setAttribute("role", "dialog")
        box:setAttribute("aria-label", "Concurso da Fantasia")
        cv = window.document:createElement("canvas")
        cv.width = LW
        cv.height = LH
        ctx = cv:getContext("2d")
        box:append(cv)
        local bt = window.document:createElement("div")
        bt.className = "bc-botoes"
        __call(
            SETAS,
            "forEach",
            function(____, s, i)
                local b = window.document:createElement("button")
                b.type = "button"
                b.textContent = s
                b.style.borderColor = __get(CORES, i)
                b:setAttribute(
                    "aria-label",
                    __add(
                        "seta ",
                        __get(
                            __arrL({"esquerda", "baixo", "cima", "direita"}, 4),
                            i
                        )
                    )
                )
                b:addEventListener(
                    "pointerdown",
                    function(____, e)
                        e:preventDefault()
                        apertar(nil, i)
                    end
                )
                bt:append(b)
            end
        )
        box:append(bt)
        local sair = window.document:createElement("button")
        sair.type = "button"
        sair.className = "bc-sair"
        sair.textContent = "DESISTIR (Esc)"
        sair:addEventListener(
            "click",
            function() return fechar(nil, false, if __t(jogo) then nota(nil) else 0, true) end
        )
        box:append(sair)
        window.document.body:append(box)
        window:addEventListener("keydown", tecla, true)
    end
    local function abrir(self, o)
        if o == nil then
            o = {}
        end
        if __t(box) then
            return false
        end
        aoFim = if __t(o.onFim) then o.onFim else nil
        cfg = __assign({}, PADRAO, if __t(o.config) then o.config else {})
        montar(nil)
        jogo = {
            t = -1,
            notas = mapa(nil),
            combo = 0,
            melhorCombo = 0,
            msg = "",
            msgT = 0,
            pulo = 0,
            trilha = __arrL({0, 0, 0, 0}, 4),
            fim = false,
            ultimo = 0
        }
        window:dispatchEvent(__new("CustomEvent", "controls-capture", {detail = {active = true}}))
        window:cancelAnimationFrame(raf)
        raf = window:requestAnimationFrame(quadro)
        return true
    end
    window.BaileConcurso = __ord(
        {
            abrir = abrir,
            fechar = function() return fechar(nil, false, 0, true) end,
            aberto = function() return not not __t(box) end,
            META = META,
            estado = function() return if __t(jogo) then {
                t = jogo.t,
                nota = nota(nil),
                notas = __call(
                    jogo.notas,
                    "map",
                    function(____, n) return {t = n.t, lane = n.lane, ok = n.ok} end
                )
            } else jogo end
        },
        "abrir,fechar,aberto,META,estado"
    )
end)(nil)
return ____exports
