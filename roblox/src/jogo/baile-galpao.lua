--!native
--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __lt, __le, __gt, __isFiniteN, __mod, __ord, __arrL, __iterar, __t, __get, __len, __call = __JSR.__lt, __JSR.__le, __JSR.__gt, __JSR.__isFiniteN, __JSR.__mod, __JSR.__ord, __JSR.__arrL, __JSR.__iterar, __JSR.__t, __JSR.__get, __JSR.__len, __JSR.__call
local __add, __entries, __assign = __JSR.__add, __JSR.__entries, __JSR.__assign
local ____lualib = require(script.Parent.lualib_bundle)
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__Number = ____lualib.__TS__Number
local ____exports = {}
local __O = {};
(function()
    local texto, brilho, pessoa, bar, pista, W, H, FLOOR, lite, R, NEON
    function texto(self, c, s, x, y, tam, cor, sombra, align)
        if sombra == nil then
            sombra = "#0c0a18"
        end
        if align == nil then
            align = "center"
        end
        c:save()
        c.font = __add(
            __add("bold ", tam),
            "px monospace"
        )
        c.textAlign = align
        c.textBaseline = "middle"
        c.fillStyle = sombra
        c:fillText(s, x + 2, y + 2)
        c.fillStyle = cor
        c:fillText(s, x, y)
        c:restore()
    end
    function brilho(self, c, x, y, r, cor, a)
        if a == nil then
            a = 0.2
        end
        c:save()
        c.globalCompositeOperation = "lighter"
        c.globalAlpha = c.globalAlpha * a
        local g = c:createRadialGradient(
            x,
            y,
            0,
            x,
            y,
            r
        )
        g:addColorStop(0, cor)
        g:addColorStop(1, "rgba(0,0,0,0)")
        c.fillStyle = g
        c:fillRect(x - r, y - r, r * 2, r * 2)
        c:restore()
    end
    function pessoa(self, c, tipo, x, y, t, o)
        if o == nil then
            o = {}
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
                        tipo,
                        x,
                        y,
                        __assign({}, {frame = t, grounded = true}, o)
                    )
                end
            end)
        end
    end
    function bar(self, c, cam, t)
        local x0 = 1120 - cam
        if __t(x0 > W + 40 or x0 < -460) then
            return
        end
        R(
            nil,
            c,
            x0,
            210,
            400,
            6,
            "#3a2a4a"
        )
        do
            local k = 0
            while k < 3 do
                R(
                    nil,
                    c,
                    x0 + 10,
                    232 + k * 34,
                    380,
                    4,
                    "#5a4a6a"
                )
                do
                    local b = 0
                    while b < 22 do
                        local bx = x0 + 18 + b * 17
                        local h = 12 + __mod(b * 7, 10)
                        R(
                            nil,
                            c,
                            bx,
                            232 + k * 34 - h,
                            8,
                            h,
                            __get(
                                __arrL({
                                    "#3fe0ff",
                                    "#ff9a3a",
                                    "#5dff9a",
                                    "#ffd24a",
                                    "#b56bff"
                                }, 5),
                                __mod(b + k, 5)
                            )
                        )
                        R(
                            nil,
                            c,
                            bx + 2,
                            232 + k * 34 - h + 2,
                            2,
                            h - 4,
                            "#ffffff66"
                        )
                        b = b + 1
                    end
                end
                k = k + 1
            end
        end
        R(
            nil,
            c,
            x0 + 140,
            140,
            120,
            34,
            "#120e1e"
        )
        c:save()
        c.strokeStyle = "#3fe0ff"
        c.lineWidth = 2
        c:strokeRect(x0 + 140, 140, 120, 34)
        c:restore()
        texto(
            nil,
            c,
            "BAR",
            x0 + 200,
            157,
            18,
            "#3fe0ff",
            "#05030a"
        )
        brilho(
            nil,
            c,
            x0 + 200,
            157,
            90,
            "#3fe0ff",
            0.15
        )
        R(
            nil,
            c,
            x0 + 300,
            150,
            80,
            50,
            "#1a1626"
        )
        texto(
            nil,
            c,
            "REFRI",
            x0 + 340,
            160,
            8,
            "#ffd24a"
        )
        texto(
            nil,
            c,
            "ÁGUA",
            x0 + 340,
            172,
            8,
            "#3fe0ff"
        )
        texto(
            nil,
            c,
            "AÇAÍ",
            x0 + 340,
            184,
            8,
            "#b56bff"
        )
        pessoa(
            nil,
            c,
            "baile_barman",
            x0 + 200,
            384,
            t,
            {facing = math.sin(t * 0.5) > 0 and 1 or -1}
        )
        R(
            nil,
            c,
            x0,
            352,
            400,
            12,
            "#4a3a5a"
        )
        R(
            nil,
            c,
            x0,
            364,
            400,
            76,
            "#2a1f38"
        )
        R(
            nil,
            c,
            x0,
            352,
            400,
            3,
            "#8a6aa8"
        )
        do
            local k = 0
            while k < 10 do
                R(
                    nil,
                    c,
                    x0 + 8 + k * 40,
                    370,
                    30,
                    64,
                    "#33284a"
                )
                k = k + 1
            end
        end
        R(
            nil,
            c,
            x0,
            436,
            400,
            4,
            __get(
                NEON,
                __mod(
                    math.floor(t * 2),
                    __len(NEON)
                )
            )
        )
    end
    function pista(self, c, cam, t, ini, beat)
        R(
            nil,
            c,
            ini,
            FLOOR,
            W - ini,
            H - FLOOR,
            "#120f22"
        )
        local tile = 32
        do
            local x = __TS__Number(-__mod(cam, tile))
            while x < W do
                do
                    if x < ini - tile then
                        do x = x + tile continue end
                    end
                    local wx = x + cam
                    do
                        local y = FLOOR
                        while y < H do
                            local i = math.floor(wx / tile)
                            local j = (y - FLOOR) / 20
                            R(
                                nil,
                                c,
                                x,
                                y,
                                tile - 1,
                                19,
                                __t(__mod(i + j, 2)) and "#1a1630" or "#16132a"
                            )
                            local ____t_22 = __t
                            local ____t_result_21
                            local ____t_20 = __t
                            local ____temp_19 = __gt(wx, 1700) and __lt(wx, 2800)
                            __O[1412] = ____temp_19
                            if ____t_20(____temp_19) then
                                ____t_result_21 = not __t(lite(nil))
                            else
                                ____t_result_21 = __O[1412]
                            end
                            if ____t_22(____t_result_21) then
                                local on = __mod(i + j + beat, 4) == 0 or __mod(i * 3 + j + beat, 7) == 0
                                if __t(on) then
                                    c:save()
                                    c.globalAlpha = 0.38
                                    R(
                                        nil,
                                        c,
                                        x + 1,
                                        y + 1,
                                        tile - 3,
                                        17,
                                        __get(
                                            NEON,
                                            __mod(
                                                i + j + beat,
                                                __len(NEON)
                                            )
                                        )
                                    )
                                    c:restore()
                                end
                            end
                            y = y + 20
                        end
                    end
                end
                x = x + tile
            end
        end
        R(
            nil,
            c,
            ini,
            FLOOR,
            W - ini,
            3,
            "#4a3a6a"
        )
    end
    local ____ = "use strict"
    if __t(window.BaileGalpao) then
        return
    end
    W = 960
    H = 540
    FLOOR = 440
    local LENGTH = 4800
    local PORTA = 760
    local FACHADA = 610
    local NPC_X = 3260
    local PALCO = 2240
    local MC_X = 1960
    local TETO = 78
    local TAU = math.pi * 2
    local BPM = 128
    local BEAT = 60 / BPM
    local function clamp(____, n, a, b)
        return math.max(
            a,
            math.min(b, n)
        )
    end
    local function smooth(____, x)
        x = clamp(nil, x, 0, 1)
        return x * x * (3 - 2 * x)
    end
    local function hsh(____, n)
        local x = math.sin(n * 12.9898 + 78.233) * 43758.5453
        return x - math.floor(x)
    end
    lite = function()
        local ____t_5 = __t
        local ____opt_2 = window.Graphics
        if ____opt_2 ~= nil then
            ____opt_2 = ____opt_2.isLite
        end
        local ____opt_result_4
        if ____opt_2 ~= nil then
            ____opt_result_4 = ____opt_2(____opt_2)
        end
        return not not ____t_5(____opt_result_4)
    end
    R = function(____, c, x, y, w, h, cor)
        c.fillStyle = cor
        c:fillRect(
            math.floor(x + 0.5),
            math.floor(y + 0.5),
            math.floor(w + 0.5),
            math.floor(h + 0.5)
        )
    end
    local function poly(____, c, pts, cor)
        c.fillStyle = cor
        c:beginPath()
        __call(
            pts,
            "forEach",
            function(____, p, i)
                local ____t_result_6
                if __t(i) then
                    ____t_result_6 = c:lineTo(
                        __get(p, 0),
                        __get(p, 1)
                    )
                else
                    ____t_result_6 = c:moveTo(
                        __get(p, 0),
                        __get(p, 1)
                    )
                end
                return ____t_result_6
            end
        )
        c:closePath()
        __call(c, "fill")
    end
    local function linha(____, c, pts, cor, w)
        if w == nil then
            w = 1
        end
        c.strokeStyle = cor
        c.lineWidth = w
        c:beginPath()
        __call(
            pts,
            "forEach",
            function(____, p, i)
                local ____t_result_7
                if __t(i) then
                    ____t_result_7 = c:lineTo(
                        __get(p, 0),
                        __get(p, 1)
                    )
                else
                    ____t_result_7 = c:moveTo(
                        __get(p, 0),
                        __get(p, 1)
                    )
                end
                return ____t_result_7
            end
        )
        c:stroke()
    end
    NEON = __arrL({
        "#ff4fa8",
        "#3fe0ff",
        "#b56bff",
        "#ffd24a",
        "#5dff9a"
    }, 5)
    local LUAR = __arrL({
        "#0a1020",
        "#1a2a48",
        "#3a5a88",
        "#7aa0d0",
        "#b8d4f2",
        "#e4f0ff",
        "#ffffff"
    }, 7)
    local GENTE = __ord(
        {
            baile_seguranca = __ord(
                {
                    name = "Segurança do baile",
                    skin = "#7a4a2e",
                    shade = "#55331f",
                    build = "strong",
                    top = "#121216",
                    topKind = "tee",
                    sleeve = "short",
                    print = "#f2f2ea",
                    pants = "#1c1e24",
                    hair = __ord({style = "buzz", color = "#121010"}, "style,color"),
                    shades = true,
                    pose = "hips"
                },
                "name,skin,shade,build,top,topKind,sleeve,print,pants,hair,shades,pose"
            ),
            baile_barman = __ord(
                {
                    name = "Tonico do bar",
                    skin = "#c48a62",
                    shade = "#93613f",
                    build = "normal",
                    top = "#1f1f2a",
                    topKind = "vest",
                    vest = "#3a2a4a",
                    vestBand = "#ff4fa8",
                    pants = "#22252c",
                    hair = __ord({style = "quiff", color = "#2a1d16"}, "style,color"),
                    pose = "talk"
                },
                "name,skin,shade,build,top,topKind,vest,vestBand,pants,hair,pose"
            ),
            baile_fila1 = __ord(
                {
                    name = "Fila do baile",
                    skin = "#8a5a3c",
                    shade = "#5f3d2a",
                    build = "slim",
                    top = "#f2c230",
                    topKind = "tee",
                    sleeve = "short",
                    pants = "#2a3442",
                    hat = __ord({kind = "capback", color = "#1e2a36"}, "kind,color"),
                    hair = __ord({style = "short", color = "#1c1714"}, "style,color"),
                    chain = "#e8c24c",
                    pose = "pockets"
                },
                "name,skin,shade,build,top,topKind,sleeve,pants,hat,hair,chain,pose"
            ),
            baile_fila2 = __ord(
                {
                    name = "Fila do baile",
                    skin = "#e3b48f",
                    shade = "#b58665",
                    build = "slim",
                    h = 0.95,
                    top = "#ff4fa8",
                    topKind = "puffer",
                    skirt = "#1f2430",
                    hair = __ord({style = "ponytail", color = "#2b1d17"}, "style,color"),
                    earrings = "#f2cf5b",
                    item = "phone",
                    pose = "phone"
                },
                "name,skin,shade,build,h,top,topKind,skirt,hair,earrings,item,pose"
            ),
            baile_fila3 = __ord(
                {
                    name = "Fila do baile",
                    skin = "#5e3a26",
                    shade = "#3e2618",
                    build = "normal",
                    top = "#2f6fb5",
                    topKind = "hoodie",
                    inner = "#1d2a3c",
                    pants = "#25303f",
                    hair = __ord({style = "curlyBig", color = "#121010"}, "style,color"),
                    pose = "relaxed"
                },
                "name,skin,shade,build,top,topKind,inner,pants,hair,pose"
            ),
            mc_batidao = __ord(
                {
                    name = "MC Batidão",
                    skin = "#6a4028",
                    shade = "#4a2c1c",
                    build = "normal",
                    top = "#f2f1ec",
                    topKind = "tee",
                    sleeve = "short",
                    print = "#ff4fa8",
                    pants = "#1f2430",
                    hat = __ord({kind = "capback", color = "#ff4fa8"}, "kind,color"),
                    hair = __ord({style = "buzz", color = "#121010"}, "style,color"),
                    chain = "#e8c24c",
                    shades = true,
                    item = "mic",
                    pose = "sing"
                },
                "name,skin,shade,build,top,topKind,sleeve,print,pants,hat,hair,chain,shades,item,pose"
            )
        },
        "baile_seguranca,baile_barman,baile_fila1,baile_fila2,baile_fila3,mc_batidao"
    )
    local function registrar()
        local CP = window.CampanhaPersonagens
        local ____t_11 = __t
        local ____opt_result_10
        if CP ~= nil then
            ____opt_result_10 = CP.registrar
        end
        if not ____t_11(____opt_result_10) then
            return false
        end
        for ____, ____value in __iterar((__entries(GENTE))) do
            local id = ____value[1]
            local spec = ____value[2]
            CP:registrar(id, spec, "NPC (baile)")
        end
        return true
    end
    if not __t(registrar(nil)) then
        window:addEventListener("DOMContentLoaded", registrar, {once = true})
    end
    local telhadoAberto = false
    local ultimoRombo = 0
    local raios = nil
    local function dancarino(self, c, x, y, t, seed, esc)
        local ____t_18 = __t
        local ____opt_16 = window.BailePixel
        if ____opt_16 ~= nil then
            ____opt_16 = ____opt_16.dancer
        end
        if ____t_18(____opt_16) then
            window.BailePixel:dancer(
                c,
                x,
                y,
                t,
                seed,
                esc
            )
        end
    end
    local function ceu(self, c, cam, t)
        local g = c:createLinearGradient(0, 0, 0, FLOOR)
        g:addColorStop(0, "#070b1e")
        g:addColorStop(0.5, "#1a2148")
        g:addColorStop(1, "#3a2c52")
        c.fillStyle = g
        c:fillRect(0, 0, W, H)
        do
            local i = 0
            while i < 60 do
                local x = __mod(
                    __mod(i * 131.7 - cam * 0.03, 1000) + 1000,
                    1000
                )
                local y = 6 + __mod(i * 37, 200)
                R(
                    nil,
                    c,
                    x,
                    y,
                    __mod(i, 9) == 0 and 2 or 1,
                    __mod(i, 9) == 0 and 2 or 1,
                    __t(__mod(i, 5)) and "#c9cfe8" or "#ffffff"
                )
                i = i + 1
            end
        end
        local lx = 820 - cam * 0.02
        brilho(
            nil,
            c,
            lx,
            40,
            80,
            "#cfd8ff",
            0.25
        )
        c.fillStyle = "#eef0ff"
        c:beginPath()
        c:arc(
            lx,
            40,
            18,
            0,
            TAU
        )
        __call(c, "fill")
        c.fillStyle = "#121a40"
        c:beginPath()
        c:arc(
            lx + 8,
            34,
            16,
            0,
            TAU
        )
        __call(c, "fill")
    end
    local function rua(self, c, cam, t)
        local fim = FACHADA - cam
        if fim < 0 then
            return
        end
        c:save()
        c:beginPath()
        c:rect(
            0,
            0,
            math.min(W, fim),
            H
        )
        c:clip()
        do
            local layer = 0
            while layer < 2 do
                local v = __t(layer) and 0.3 or 0.15
                do
                    local i = -1
                    while i < 10 do
                        local x = i * 150 - __mod(cam * v, 150)
                        local h = 90 + __mod(i * 53 + layer * 31, 120)
                        local y = FLOOR - 30 - h + layer * 20
                        R(
                            nil,
                            c,
                            x,
                            y,
                            138,
                            FLOOR - y,
                            __t(layer) and "#1c2440" or "#141a33"
                        )
                        do
                            local r = 0
                            while r < 5 do
                                do
                                    local k = 0
                                    while k < 6 do
                                        if __t(__mod(i + r + k + layer, 3)) then
                                            R(
                                                nil,
                                                c,
                                                x + 10 + k * 20,
                                                y + 12 + r * 20,
                                                8,
                                                10,
                                                __t(__mod(i + r * k, 5)) and "#2a3456" or "#d8b86a"
                                            )
                                        end
                                        k = k + 1
                                    end
                                end
                                r = r + 1
                            end
                        end
                        i = i + 1
                    end
                end
                layer = layer + 1
            end
        end
        R(
            nil,
            c,
            0,
            FLOOR - 14,
            W,
            14,
            "#3a3a4a"
        )
        R(
            nil,
            c,
            0,
            FLOOR - 14,
            W,
            3,
            "#5a5a6e"
        )
        R(
            nil,
            c,
            0,
            FLOOR,
            W,
            H - FLOOR,
            "#22222e"
        )
        do
            local i = -1
            while i < 16 do
                local x = i * 70 - __mod(cam, 70)
                R(
                    nil,
                    c,
                    x,
                    FLOOR + 40,
                    36,
                    4,
                    "#d8c46a"
                )
                i = i + 1
            end
        end
        local pX = 300 - cam
        if __t(pX > -40 and pX < W + 40) then
            R(
                nil,
                c,
                pX,
                200,
                6,
                FLOOR - 200,
                "#2a2e3e"
            )
            R(
                nil,
                c,
                pX - 16,
                194,
                38,
                8,
                "#3a3e50"
            )
            R(
                nil,
                c,
                pX - 10,
                202,
                26,
                4,
                "#ffe6a0"
            )
            c:save()
            c.globalCompositeOperation = "lighter"
            c.globalAlpha = 0.12
            poly(
                nil,
                c,
                __arrL(
                    {
                        __arrL({pX - 10, 206}, 2),
                        __arrL({pX + 16, 206}, 2),
                        __arrL({pX + 70, FLOOR}, 2),
                        __arrL({pX - 64, FLOOR}, 2)
                    },
                    4
                ),
                "#ffe6a0"
            )
            c:restore()
        end
        local sX = 520 - cam
        if __t(sX > -60 and sX < W + 60) then
            R(
                nil,
                c,
                sX,
                330,
                4,
                110,
                "#5a5e6a"
            )
            R(
                nil,
                c,
                sX - 30,
                300,
                64,
                36,
                "#0f2a5a"
            )
            R(
                nil,
                c,
                sX - 28,
                302,
                60,
                32,
                "#1f4fa8"
            )
            texto(
                nil,
                c,
                "P",
                sX - 14,
                318,
                20,
                "#ffffff",
                "#0f2a5a"
            )
            texto(
                nil,
                c,
                "CARRO",
                sX + 14,
                312,
                9,
                "#ffffff",
                "#0f2a5a"
            )
            texto(
                nil,
                c,
                "SÓ ATÉ",
                sX + 14,
                322,
                8,
                "#ffffff",
                "#0f2a5a"
            )
            texto(
                nil,
                c,
                "AQUI",
                sX + 14,
                331,
                8,
                "#ffd24a",
                "#0f2a5a"
            )
        end
        c:restore()
    end
    local function fachada(self, c, cam, t)
        local x0 = FACHADA - cam
        local x1 = PORTA - cam
        if __t(x1 < -40 or x0 > W + 300) then
            return
        end
        R(
            nil,
            c,
            x0,
            TETO - 24,
            x1 - x0,
            FLOOR - TETO + 24,
            "#2a1f3e"
        )
        do
            local y = TETO
            while y < FLOOR do
                do
                    local x = x0 + __mod(y / 16, 2) * 12
                    while x < x1 do
                        R(
                            nil,
                            c,
                            x,
                            y,
                            22,
                            1,
                            "#3a2c52"
                        )
                        x = x + 24
                    end
                end
                y = y + 16
            end
        end
        R(
            nil,
            c,
            x0 - 6,
            TETO - 30,
            x1 - x0 + 12,
            8,
            "#4a3a66"
        )
        local dx = x0 + 36
        local dw = 86
        local dy = FLOOR - 118
        local pulso = 0.5 + 0.5 * math.sin(t * TAU / BEAT)
        R(
            nil,
            c,
            dx - 4,
            dy - 12,
            dw + 8,
            12,
            "#55556a"
        )
        do
            local k = 0
            while k < 3 do
                R(
                    nil,
                    c,
                    dx - 4,
                    dy - 12 + k * 4,
                    dw + 8,
                    1,
                    "#3a3a4c"
                )
                k = k + 1
            end
        end
        local g = c:createLinearGradient(dx, dy, dx + dw, FLOOR)
        g:addColorStop(0, "#3a1a4a")
        g:addColorStop(
            1,
            __get(
                NEON,
                __t(__mod(
                    math.floor(t / BEAT),
                    2
                )) and 0 or 1
            )
        )
        c.fillStyle = g
        c:fillRect(dx, dy, dw, FLOOR - dy)
        c:save()
        c.globalAlpha = 0.25 + pulso * 0.2
        c.globalCompositeOperation = "lighter"
        poly(
            nil,
            c,
            __arrL(
                {
                    __arrL({dx, FLOOR}, 2),
                    __arrL({dx + dw, FLOOR}, 2),
                    __arrL({dx + dw - 120, FLOOR + 60}, 2),
                    __arrL({dx - 160, FLOOR + 60}, 2)
                },
                4
            ),
            __get(
                NEON,
                __t(__mod(
                    math.floor(t / BEAT),
                    2
                )) and 0 or 1
            )
        )
        c:restore()
        local nx = x0 - 70
        local ny = 150
        local on = math.sin(t * 3.1) > -0.92
        R(
            nil,
            c,
            nx - 4,
            ny - 4,
            230,
            58,
            "#120e1e"
        )
        c:save()
        c.strokeStyle = __t(on) and "#ff4fa8" or "#5a2a44"
        c.lineWidth = 2
        c:strokeRect(nx, ny, 222, 50)
        c:restore()
        texto(
            nil,
            c,
            "BAILE DO",
            nx + 111,
            ny + 15,
            13,
            __t(on) and "#3fe0ff" or "#1a4a5a",
            "#05030a"
        )
        texto(
            nil,
            c,
            "OLLYAN",
            nx + 111,
            ny + 35,
            20,
            __t(on) and "#ff4fa8" or "#5a2a44",
            "#05030a"
        )
        if __t(on) then
            brilho(
                nil,
                c,
                nx + 111,
                ny + 25,
                140,
                "#ff4fa8",
                0.18
            )
        end
        do
            local i = 0
            while i < 6 do
                local yy = dy + 10 + i * 16
                c:save()
                c.globalAlpha = 0.35 * pulso
                linha(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({dx - 10 - i * 3, yy}, 2),
                            __arrL({dx - 18 - i * 3, yy + 6}, 2),
                            __arrL({dx - 10 - i * 3, yy + 12}, 2)
                        },
                        3
                    ),
                    "#ffb0d8",
                    2
                )
                c:restore()
                i = i + 1
            end
        end
    end
    local function interior(self, c, cam, t)
        local ini = math.max(0, PORTA - cam)
        local beat = math.floor(t / BEAT)
        local fase = __mod(t, BEAT) / BEAT
        c:save()
        c:beginPath()
        c:rect(ini, 0, W - ini, H)
        c:clip()
        R(
            nil,
            c,
            ini,
            TETO,
            W - ini,
            FLOOR - TETO,
            "#15122a"
        )
        do
            local y = TETO + 6
            while y < FLOOR do
                R(
                    nil,
                    c,
                    ini,
                    y,
                    W - ini,
                    1,
                    "#1d1936"
                )
                local off = __mod(y / 22, 2) * 22
                do
                    local x = __TS__Number(-__mod(cam + off, 44))
                    while x < W do
                        if x > ini - 44 then
                            R(
                                nil,
                                c,
                                x,
                                y,
                                1,
                                22,
                                "#1d1936"
                            )
                        end
                        x = x + 44
                    end
                end
                y = y + 22
            end
        end
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({960, "TAMBORZÃO", "#ffd24a", "#b8321a"}, 4),
                __arrL({2760, "PASSINHO", "#3fe0ff", "#2a1a6a"}, 4),
                __arrL({3700, "ITABUNA", "#5dff9a", "#1a4a2a"}, 4),
                __arrL({4330, "ORELHAS AO VENTO", "#ff4fa8", "#3a1238"}, 4)
            },
            4
        ))) do
            local wx = ____value[1]
            local s = ____value[2]
            local cor = ____value[3]
            local borda = ____value[4]
            do
                local x = wx - cam
                if __t(x < -320 or x > W + 320) then
                    continue
                end
                c:save()
                c:translate(x, 190)
                c:rotate(-0.04)
                c.font = "bold 34px monospace"
                c.textAlign = "center"
                c.lineWidth = 6
                c.strokeStyle = borda
                c:strokeText(s, 0, 0)
                c.fillStyle = cor
                c:fillText(s, 0, 0)
                c.fillStyle = "#ffffff55"
                c:fillText(s, -2, -2)
                do
                    local k = 0
                    while k < 6 do
                        R(
                            nil,
                            c,
                            -120 + k * 47 + hsh(nil, wx + k) * 20,
                            8,
                            3,
                            6 + hsh(nil, k + wx) * 18,
                            cor
                        )
                        k = k + 1
                    end
                end
                c:restore()
            end
        end
        do
            local x = ini - __mod(cam, 8)
            while x < W do
                local k = __mod(
                    math.floor((x + cam) / 8 + t * 14),
                    __len(NEON)
                )
                R(
                    nil,
                    c,
                    x,
                    296,
                    6,
                    2,
                    __get(
                        NEON,
                        __mod(
                            k + __len(NEON),
                            __len(NEON)
                        )
                    )
                )
                R(
                    nil,
                    c,
                    x,
                    118,
                    6,
                    2,
                    __get(
                        NEON,
                        __mod(
                            k + 2,
                            __len(NEON)
                        )
                    )
                )
                x = x + 8
            end
        end
        local sx = 800 - cam
        if __t(sx > -40 and sx < W) then
            R(
                nil,
                c,
                sx,
                238,
                52,
                18,
                "#0d3a1e"
            )
            R(
                nil,
                c,
                sx + 2,
                240,
                48,
                14,
                "#1fbf5a"
            )
            texto(
                nil,
                c,
                "SAÍDA",
                sx + 26,
                247,
                9,
                "#eaffea",
                "#0d3a1e"
            )
            brilho(
                nil,
                c,
                sx + 26,
                247,
                40,
                "#1fbf5a",
                0.2
            )
        end
        bar(nil, c, cam, t)
        R(
            nil,
            c,
            ini,
            TETO - 22,
            W - ini,
            22,
            "#2a2d3a"
        )
        do
            local x = ini - __mod(cam, 6)
            while x < W do
                R(
                    nil,
                    c,
                    x,
                    TETO - 22,
                    2,
                    22,
                    "#363a4a"
                )
                x = x + 6
            end
        end
        R(
            nil,
            c,
            ini,
            TETO,
            W - ini,
            3,
            "#101018"
        )
        local ty = TETO + 8
        R(
            nil,
            c,
            ini,
            ty,
            W - ini,
            3,
            "#4a4e60"
        )
        R(
            nil,
            c,
            ini,
            ty + 18,
            W - ini,
            3,
            "#4a4e60"
        )
        do
            local x = __TS__Number(-__mod(cam, 24))
            while x < W do
                if x > ini - 24 then
                    linha(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({x, ty + 3}, 2),
                                __arrL({x + 12, ty + 18}, 2),
                                __arrL({x + 24, ty + 3}, 2)
                            },
                            3
                        ),
                        "#3a3e50",
                        2
                    )
                end
                x = x + 24
            end
        end
        local gx = PALCO - cam
        if __t(gx > -200 and gx < W + 200) then
            R(
                nil,
                c,
                gx,
                ty + 20,
                1,
                36,
                "#8a8a9a"
            )
            c:save()
            c:beginPath()
            c:arc(
                gx,
                160,
                20,
                0,
                TAU
            )
            c:clip()
            R(
                nil,
                c,
                gx - 20,
                140,
                40,
                40,
                "#8a92a8"
            )
            do
                local a = 0
                while a < 8 do
                    do
                        local b = 0
                        while b < 8 do
                            if __mod(
                                a + b + math.floor(t * 4),
                                3
                            ) == 0 then
                                R(
                                    nil,
                                    c,
                                    gx - 20 + a * 5,
                                    140 + b * 5,
                                    4,
                                    4,
                                    "#f2f6ff"
                                )
                            end
                            b = b + 1
                        end
                    end
                    a = a + 1
                end
            end
            c:restore()
            brilho(
                nil,
                c,
                gx,
                160,
                50,
                "#ffffff",
                0.25
            )
        end
        pista(
            nil,
            c,
            cam,
            t,
            ini,
            beat
        )
        c:restore()
    end
    local function luzes(self, c, cam, t)
        local ini = math.max(0, PORTA - cam)
        local beat = math.floor(t / BEAT)
        c:save()
        c:beginPath()
        c:rect(ini, TETO, W - ini, H - TETO)
        c:clip()
        c.globalCompositeOperation = "lighter"
        do
            local i = -1
            while i < 14 do
                do
                    local wx = 900 + i * 300
                    local x = wx - cam
                    local ____t_29 = __t
                    local ____t_result_28
                    local ____t_24 = __t
                    local ____temp_23 = x < -400 or x > W + 400
                    __O[1414] = ____temp_23
                    if ____t_24(____temp_23) then
                        ____t_result_28 = __O[1414]
                    else
                        local ____t_result_27
                        local ____t_26 = __t
                        local ____lite_result_25 = lite(nil)
                        __O[1413] = ____lite_result_25
                        if ____t_26(____lite_result_25) then
                            ____t_result_27 = __mod(i, 2)
                        else
                            ____t_result_27 = __O[1413]
                        end
                        ____t_result_28 = ____t_result_27
                    end
                    if ____t_29(____t_result_28) then
                        do i = i + 1 continue end
                    end
                    R(
                        nil,
                        c,
                        x - 7,
                        TETO + 28,
                        14,
                        10,
                        "#2a2a36"
                    )
                    R(
                        nil,
                        c,
                        x - 4,
                        TETO + 38,
                        8,
                        6,
                        "#3a3a4a"
                    )
                    local ang = math.sin(t * 0.8 + i * 1.7) * 0.55 + (__t(__mod(i, 2)) and 0.1 or -0.1)
                    local cor = __get(
                        NEON,
                        __mod(
                            i + beat,
                            __len(NEON)
                        )
                    )
                    local len = 380
                    local ex = x + math.sin(ang) * len
                    local ey = TETO + 44 + math.cos(ang) * len
                    local w1 = 4
                    local w2 = 46
                    local nx = math.cos(ang)
                    local ny = -math.sin(ang)
                    c.globalAlpha = 0.1 + (__mod(i, 3) == __mod(beat, 3) and 0.05 or 0)
                    poly(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({x - nx * w1, TETO + 44 - ny * w1}, 2),
                                __arrL({x + nx * w1, TETO + 44 + ny * w1}, 2),
                                __arrL({ex + nx * w2, ey + ny * w2}, 2),
                                __arrL({ex - nx * w2, ey - ny * w2}, 2)
                            },
                            4
                        ),
                        cor
                    )
                    c.globalAlpha = 0.16
                    poly(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({x - nx * 1.5, TETO + 44}, 2),
                                __arrL({x + nx * 1.5, TETO + 44}, 2),
                                __arrL({ex + nx * 10, ey}, 2),
                                __arrL({ex - nx * 10, ey}, 2)
                            },
                            4
                        ),
                        cor
                    )
                end
                i = i + 1
            end
        end
        local px0 = PALCO - cam
        local ____t_35 = __t
        local ____t_result_34
        local ____t_33 = __t
        local ____t_result_32
        local ____t_31 = __t
        local ____temp_30 = not __t(lite(nil)) and px0 > -900
        __O[1415] = ____temp_30
        if ____t_31(____temp_30) then
            ____t_result_32 = px0 < W + 900
        else
            ____t_result_32 = __O[1415]
        end
        __O[1416] = ____t_result_32
        if ____t_33(____t_result_32) then
            ____t_result_34 = __mod(
                math.floor(t / (BEAT * 4)),
                2
            ) == 0
        else
            ____t_result_34 = __O[1416]
        end
        if ____t_35(____t_result_34) then
            c.globalAlpha = 0.55
            do
                local k = 0
                while k < 7 do
                    local a = -math.pi / 2 + (k - 3) * 0.32 + math.sin(t * 1.3) * 0.2
                    linha(
                        nil,
                        c,
                        __arrL(
                            {
                                __arrL({px0, 250}, 2),
                                __arrL(
                                    {
                                        px0 + math.cos(a) * 900,
                                        250 + math.sin(a) * -260 + 300
                                    },
                                    2
                                )
                            },
                            2
                        ),
                        "#5dff9a",
                        1
                    )
                    k = k + 1
                end
            end
        end
        if __t(px0 > -1200 and px0 < W + 1200) then
            c.globalAlpha = 0.5
            do
                local k = 0
                while k < (__t(lite(nil)) and 10 or 26) do
                    local a = k * 2.399 + t * 0.6
                    local rr = 160 + __mod(k * 47, 520)
                    local x = px0 + math.cos(a) * rr
                    local y = 160 + math.sin(a) * rr * 0.45
                    if __t(y > TETO and y < FLOOR) then
                        R(
                            nil,
                            c,
                            x,
                            y,
                            3,
                            2,
                            "#f2f6ff"
                        )
                    end
                    k = k + 1
                end
            end
        end
        c:restore()
    end
    local function fumaca(self, c, cam, t)
        if __t(lite(nil)) then
            return
        end
        local ini = math.max(0, PORTA - cam)
        c:save()
        c:beginPath()
        c:rect(ini, 0, W - ini, H)
        c:clip()
        do
            local k = 0
            while k < 9 do
                local x = __mod(
                    __mod(k * 260 - cam * 0.9 + t * (12 + k * 3), 1400) + 1400,
                    1400
                ) - 220
                local y = 330 + __mod(k, 3) * 30
                c.globalAlpha = 0.07
                c.fillStyle = __t(__mod(k, 2)) and "#b8a8e8" or "#e8b8e0"
                c:beginPath()
                c:ellipse(
                    x,
                    y,
                    190,
                    34,
                    0,
                    0,
                    TAU
                )
                __call(c, "fill")
                k = k + 1
            end
        end
        c:restore()
    end
    local function multidao(self, c, cam, t, frente)
        local ini = PORTA + 50
        if not __t(frente) then
            do
                local row = 0
                while row < 2 do
                    do
                        local i = 0
                        while i < 116 do
                            do
                                local wx = 60 + i * 41 + row * 23
                                local x = wx - cam
                                local ____t_49 = __t
                                local ____t_result_48
                                local ____t_44 = __t
                                local ____t_result_43
                                local ____t_39 = __t
                                local ____t_result_38
                                local ____t_37 = __t
                                local ____temp_36 = wx < ini or x < -45
                                __O[1417] = ____temp_36
                                if ____t_37(____temp_36) then
                                    ____t_result_38 = __O[1417]
                                else
                                    ____t_result_38 = x > W + 45
                                end
                                __O[1419] = ____t_result_38
                                if ____t_39(____t_result_38) then
                                    ____t_result_43 = __O[1419]
                                else
                                    local ____t_result_42
                                    local ____t_41 = __t
                                    local ____temp_40 = row == 0 and wx > 1900
                                    __O[1418] = ____temp_40
                                    if ____t_41(____temp_40) then
                                        ____t_result_42 = wx < 2560
                                    else
                                        ____t_result_42 = __O[1418]
                                    end
                                    ____t_result_43 = ____t_result_42
                                end
                                __O[1421] = ____t_result_43
                                if ____t_44(____t_result_43) then
                                    ____t_result_48 = __O[1421]
                                else
                                    local ____t_result_47
                                    local ____t_46 = __t
                                    local ____temp_45 = wx > 1100 and wx < 1530
                                    __O[1420] = ____temp_45
                                    if ____t_46(____temp_45) then
                                        ____t_result_47 = row == 0
                                    else
                                        ____t_result_47 = __O[1420]
                                    end
                                    ____t_result_48 = ____t_result_47
                                end
                                if ____t_49(____t_result_48) then
                                    do i = i + 1 continue end
                                end
                                local ____dancarino_52 = dancarino
                                local ____c_51 = c
                                local ____temp_50
                                if row == 0 then
                                    ____temp_50 = 401 + __mod(i, 3) * 5
                                else
                                    ____temp_50 = 438 + __mod(i, 2) * 3
                                end
                                ____dancarino_52(
                                    nil,
                                    ____c_51,
                                    x,
                                    ____temp_50,
                                    t + row * 0.33,
                                    i + row * 7,
                                    row == 0 and 0.73 or 0.91
                                )
                            end
                            i = i + 1
                        end
                    end
                    row = row + 1
                end
            end
            return
        end
        if __t(lite(nil)) then
            return
        end
        do
            local i = 0
            while i < 70 do
                do
                    local wx = 40 + i * 67 + __mod(i * 29, 30)
                    local x = wx - cam
                    local ____t_60 = __t
                    local ____t_result_59
                    local ____t_58 = __t
                    local ____t_result_57
                    local ____t_56 = __t
                    local ____t_result_55
                    local ____t_54 = __t
                    local ____temp_53 = wx < ini or x < -50
                    __O[1422] = ____temp_53
                    if ____t_54(____temp_53) then
                        ____t_result_55 = __O[1422]
                    else
                        ____t_result_55 = x > W + 50
                    end
                    __O[1423] = ____t_result_55
                    if ____t_56(____t_result_55) then
                        ____t_result_57 = __O[1423]
                    else
                        ____t_result_57 = math.abs(wx - NPC_X) < 90
                    end
                    __O[1424] = ____t_result_57
                    if ____t_58(____t_result_57) then
                        ____t_result_59 = __O[1424]
                    else
                        ____t_result_59 = math.abs(wx - MC_X) < 70
                    end
                    if ____t_60(____t_result_59) then
                        do i = i + 1 continue end
                    end
                    dancarino(
                        nil,
                        c,
                        x,
                        486 + __mod(i, 3) * 9,
                        t + 0.6,
                        i * 5 + 3,
                        1.08
                    )
                end
                i = i + 1
            end
        end
    end
    local function lado_de_fora(self, c, cam, t)
        local function x(____, wx)
            return wx - cam
        end
        if x(nil, FACHADA) < -60 then
            return
        end
        for ____, ____value in __iterar((__arrL(
            {
                __arrL({"baile_fila1", 470, 1}, 3),
                __arrL({"baile_fila2", 512, 1}, 3),
                __arrL({"baile_fila3", 552, 1}, 3)
            },
            3
        ))) do
            local tipo = ____value[1]
            local wx = ____value[2]
            local f = ____value[3]
            if __t(x(nil, wx) > -40 and x(nil, wx) < W + 40) then
                pessoa(
                    nil,
                    c,
                    tipo,
                    x(nil, wx),
                    FLOOR,
                    __add(t, wx),
                    {facing = f}
                )
            end
        end
        if x(nil, 440) < W + 20 then
            for ____, px0 in __iterar((__arrL({440, 580}, 2))) do
                R(
                    nil,
                    c,
                    x(nil, px0),
                    FLOOR - 34,
                    4,
                    34,
                    "#c9a24a"
                )
                R(
                    nil,
                    c,
                    x(nil, px0) - 2,
                    FLOOR - 36,
                    8,
                    4,
                    "#e8c24c"
                )
            end
            c.strokeStyle = "#a8223a"
            c.lineWidth = 3
            c:beginPath()
            c:moveTo(
                x(nil, 442),
                FLOOR - 30
            )
            c:quadraticCurveTo(
                x(nil, 511),
                FLOOR - 14,
                x(nil, 582),
                FLOOR - 30
            )
            c:stroke()
        end
        pessoa(
            nil,
            c,
            "baile_seguranca",
            x(nil, PORTA - 128),
            FLOOR,
            t,
            {facing = -1}
        )
    end
    local function rombo(self, c, cam, t, k)
        if __le(k, 0) then
            return
        end
        local cx = NPC_X - cam
        if __t(cx < -500 or cx > W + 500) then
            return
        end
        local meia = 30 + 100 * k
        local ini = math.max(0, PORTA - cam)
        c:save()
        c:beginPath()
        c:rect(ini, 0, W - ini, H)
        c:clip()
        local pts = __arrL({}, 0)
        do
            local i = 0
            while i <= 12 do
                local x = cx - meia + i * (meia * 2 / 12)
                __call(
                    pts,
                    "push",
                    __arrL(
                        {
                            x,
                            TETO - 22 - (__t(__mod(i, 2)) and 4 or 0)
                        },
                        2
                    )
                )
                i = i + 1
            end
        end
        do
            local i = 12
            while i >= 0 do
                local x = cx - meia + i * (meia * 2 / 12)
                __call(
                    pts,
                    "push",
                    __arrL(
                        {
                            x,
                            TETO + 4 + __mod(i, 3) * 3
                        },
                        2
                    )
                )
                i = i - 1
            end
        end
        local g = c:createLinearGradient(0, TETO - 30, 0, TETO + 8)
        g:addColorStop(0, "#1a2148")
        g:addColorStop(1, "#3a4a88")
        poly(nil, c, pts, g)
        do
            local i = 0
            while i < 8 do
                R(
                    nil,
                    c,
                    cx - meia + 10 + hsh(nil, i) * (meia * 2 - 20),
                    TETO - 18 + hsh(nil, i + 3) * 18,
                    1,
                    1,
                    "#ffffff"
                )
                i = i + 1
            end
        end
        for ____, s in __iterar((__arrL({-1, 1}, 2))) do
            c:save()
            c:translate(cx + s * meia, TETO)
            c:rotate(s * (0.5 + 0.1 * math.sin(t * 2)))
            R(
                nil,
                c,
                -4,
                0,
                8,
                30,
                "#4a4e60"
            )
            do
                local y = 0
                while y < 30 do
                    R(
                        nil,
                        c,
                        -4,
                        y,
                        8,
                        1,
                        "#363a4a"
                    )
                    y = y + 4
                end
            end
            c:restore()
        end
        c.globalCompositeOperation = "lighter"
        local topo = TETO + 4
        local inc = 70
        local gg = c:createLinearGradient(0, topo, 0, FLOOR)
        gg:addColorStop(
            0,
            ("rgba(200,225,255," .. tostring(0.34 * k)) .. ")"
        )
        gg:addColorStop(
            1,
            ("rgba(150,190,255," .. tostring(0.06 * k)) .. ")"
        )
        c.fillStyle = gg
        c:beginPath()
        c:moveTo(cx - meia * 0.9, topo)
        c:lineTo(cx + meia * 0.9, topo)
        c:lineTo(cx + meia * 1.35 + inc, FLOOR)
        c:lineTo(cx - meia * 1.35 + inc, FLOOR)
        c:closePath()
        __call(c, "fill")
        do
            local i = 0
            while i < 6 do
                local u = (i + 0.5) / 6
                local a0 = 0.06 + 0.05 * math.sin(t * 0.7 + i * 1.9)
                local xt = cx - meia * 0.8 + u * meia * 1.6
                local xb = cx - meia * 1.2 + u * meia * 2.4 + inc
                c.globalAlpha = a0 * k
                poly(
                    nil,
                    c,
                    __arrL(
                        {
                            __arrL({xt - 3, topo}, 2),
                            __arrL({xt + 3, topo}, 2),
                            __arrL({xb + 9, FLOOR}, 2),
                            __arrL({xb - 9, FLOOR}, 2)
                        },
                        4
                    ),
                    "#e4f0ff"
                )
                i = i + 1
            end
        end
        c.globalAlpha = 1
        c.globalAlpha = 0.5 * k
        c.fillStyle = "#cfe3ff"
        c:beginPath()
        c:ellipse(
            cx + inc,
            FLOOR + 8,
            meia * 1.5,
            14,
            0,
            0,
            TAU
        )
        __call(c, "fill")
        c.globalAlpha = k
        do
            local i = 0
            while i < (__t(lite(nil)) and 12 or 34) do
                local u = __mod(
                    t * 0.05 + hsh(nil, i),
                    1
                )
                local yy = topo + u * (FLOOR - topo)
                local xx = cx - meia + hsh(nil, i * 7) * meia * 2 + inc * u + math.sin(t + i) * 4
                R(
                    nil,
                    c,
                    xx,
                    yy,
                    1,
                    1,
                    __t(__mod(i, 3)) and "#e4f0ff" or "#ffffff"
                )
                i = i + 1
            end
        end
        c:restore()
    end
    local function luzPixel(self, c, cam, t, k)
        local F = window.FxPixel
        local ____t_67 = __t
        local ____opt_result_65
        if F ~= nil then
            ____opt_result_65 = F.pronto
        end
        local ____opt_result_66
        if ____opt_result_65 ~= nil then
            ____opt_result_66 = ____opt_result_65(F)
        end
        if not ____t_67(____opt_result_66) then
            return
        end
        if __gt(k, 0.6) then
            local ____t_71 = __t
            local ____t_result_70
            local ____t_69 = __t
            local ____temp_68 = not __t(raios)
            __O[1425] = ____temp_68
            if ____t_69(____temp_68) then
                ____t_result_70 = __O[1425]
            else
                ____t_result_70 = raios.feito
            end
            if ____t_71(____t_result_70) then
                raios = F:tocar("weather/god-rays", {
                    dono = "baile",
                    x = NPC_X + 40,
                    y = FLOOR,
                    palette = LUAR,
                    duracao = 600,
                    light = 0.8
                })
            end
        elseif __t(raios) then
            raios:parar()
            raios = nil
        end
        F:desenhar(c, {dono = "baile", camada = "back", camera = cam, tempo = t})
        F:desenhar(c, {dono = "baile", camada = "front", camera = cam, tempo = t})
    end
    local function estouro(self, cam)
        local F = window.FxPixel
        local ____t_75 = __t
        local ____opt_result_74
        if F ~= nil then
            ____opt_result_74 = F.tocar
        end
        if not ____t_75(____opt_result_74) then
            return
        end
        F:tocar(
            "explosions/dirt-explosion",
            {
                dono = "baile",
                x = NPC_X,
                y = TETO + 10,
                palette = __arrL({
                    "#1c1c24",
                    "#2a2d3a",
                    "#363a4a",
                    "#4a4e60",
                    "#6a6e80",
                    "#9a9eb0",
                    "#cfd3e0"
                }, 7)
            }
        )
        F:tocar("spawn/poof", {dono = "baile", x = NPC_X - 60, y = TETO + 30, palette = window.FxPixel.PAL.poeira})
        F:tocar("spawn/poof", {
            dono = "baile",
            x = NPC_X + 70,
            y = TETO + 26,
            palette = window.FxPixel.PAL.poeira,
            atraso = 0.1
        })
    end
    local function draw(self, c, camera, t, opts)
        if camera == nil then
            camera = 0
        end
        if t == nil then
            t = 0
        end
        if opts == nil then
            opts = {}
        end
        local ____t_result_78
        local ____t_77 = __t
        local ____TS__Number_result_76 = __TS__Number(camera)
        __O[1426] = ____TS__Number_result_76
        if ____t_77(____TS__Number_result_76) then
            ____t_result_78 = __O[1426]
        else
            ____t_result_78 = 0
        end
        local cam = ____t_result_78
        local ____t_result_81
        local ____t_80 = __t
        local ____TS__Number_result_79 = __TS__Number(t)
        __O[1427] = ____TS__Number_result_79
        if ____t_80(____TS__Number_result_79) then
            ____t_result_81 = __O[1427]
        else
            ____t_result_81 = 0
        end
        t = ____t_result_81
        local ____isFiniteN_result_82
        if __isFiniteN(opts.rombo) then
            ____isFiniteN_result_82 = clamp(nil, opts.rombo, 0, 1)
        else
            ____isFiniteN_result_82 = __t(telhadoAberto) and 1 or 0
        end
        local k = ____isFiniteN_result_82
        local ____t_86 = __t
        local ____t_result_85
        local ____t_84 = __t
        local ____temp_83 = k > 0 and ultimoRombo <= 0
        __O[1428] = ____temp_83
        if ____t_84(____temp_83) then
            ____t_result_85 = __isFiniteN(opts.rombo)
        else
            ____t_result_85 = __O[1428]
        end
        if ____t_86(____t_result_85) then
            estouro(nil, cam)
        end
        ultimoRombo = k
        c:save()
        c.imageSmoothingEnabled = false
        ceu(nil, c, cam, t)
        rua(nil, c, cam, t)
        interior(nil, c, cam, t)
        fachada(nil, c, cam, t)
        luzes(nil, c, cam, t)
        do
            local ini = math.max(0, PORTA - cam)
            c:save()
            c:beginPath()
            c:rect(ini, TETO, W - ini, H - TETO)
            c:clip()
            do
                pcall(function()
                    local ____t_89 = __t
                    local ____opt_87 = window.BailePixel
                    if ____opt_87 ~= nil then
                        ____opt_87 = ____opt_87.palco
                    end
                    if ____t_89(____opt_87) then
                        window.BailePixel:palco(c, PALCO - cam, t)
                    end
                    if not __t(lite(nil)) then
                        local ____opt_92 = window.BailePixel
                        if ____opt_92 ~= nil then
                            ____opt_92 = ____opt_92.fx
                        end
                        if ____opt_92 ~= nil then
                            ____opt_92(____opt_92, c, PALCO - cam, t)
                        end
                    end
                end)
            end
            c:restore()
        end
        rombo(
            nil,
            c,
            cam,
            t,
            k
        )
        luzPixel(
            nil,
            c,
            cam,
            t,
            k
        )
        lado_de_fora(nil, c, cam, t)
        multidao(
            nil,
            c,
            cam,
            t,
            false
        )
        fumaca(nil, c, cam, t)
        multidao(
            nil,
            c,
            cam,
            t,
            true
        )
        local ini = math.max(0, PORTA - cam)
        if ini < W then
            c:save()
            c.globalCompositeOperation = "lighter"
            c.globalAlpha = 0.035 * (1 - __mod(t, BEAT) / BEAT)
            R(
                nil,
                c,
                ini,
                TETO,
                W - ini,
                H - TETO,
                __get(
                    NEON,
                    __t(__mod(
                        math.floor(t / BEAT),
                        2
                    )) and 0 or 1
                )
            )
            c:restore()
        end
        c:restore()
        return true
    end
    local function camarote(self, c, p, t)
        local x, y, w = table.unpack(p, 1, 3)
        R(
            nil,
            c,
            x,
            y,
            w,
            10,
            "#2a2d3a"
        )
        R(
            nil,
            c,
            x,
            y,
            w,
            2,
            "#6a6e80"
        )
        R(
            nil,
            c,
            x,
            y + 10,
            w,
            2,
            "#121218"
        )
        do
            local k = 0
            while __lt(k, w) do
                R(
                    nil,
                    c,
                    x + k,
                    y - 14,
                    1,
                    14,
                    "#4a4e60"
                )
                k = k + 8
            end
        end
        R(
            nil,
            c,
            x,
            y - 15,
            w,
            2,
            "#8a8ea0"
        )
        do
            local k = 0
            while __lt(k, w) do
                R(
                    nil,
                    c,
                    x + k,
                    y + 4,
                    4,
                    2,
                    __get(
                        NEON,
                        __mod(
                            math.floor(k / 6 + t * 10),
                            __len(NEON)
                        )
                    )
                )
                k = k + 6
            end
        end
        R(
            nil,
            c,
            x + 6,
            y + 12,
            3,
            22,
            "#2a2d3a"
        )
        R(
            nil,
            c,
            __add(x, w) - 9,
            y + 12,
            3,
            22,
            "#2a2d3a"
        )
    end
    local function sincronizar(self, o)
        if o == nil then
            o = {}
        end
        if type(o.telhado) == "boolean" then
            telhadoAberto = o.telhado
        end
    end
    window.BaileGalpao = __ord(
        {
            draw = draw,
            sincronizar = sincronizar,
            camarote = camarote,
            PORTA = PORTA,
            FACHADA = FACHADA,
            PALCO = PALCO,
            NPC_X = NPC_X,
            MC_X = MC_X,
            TETO = TETO,
            BPM = BPM,
            aberto = function() return telhadoAberto end
        },
        "draw,sincronizar,camarote,PORTA,FACHADA,PALCO,NPC_X,MC_X,TETO,BPM,aberto"
    )
end)(nil)
return ____exports
